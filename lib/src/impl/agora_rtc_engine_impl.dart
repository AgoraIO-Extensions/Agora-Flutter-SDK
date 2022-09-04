import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:agora_rtc_engine/src/agora_base.dart';
import 'package:agora_rtc_engine/src/agora_media_base.dart';
import 'package:agora_rtc_engine/src/agora_media_engine.dart';
import 'package:agora_rtc_engine/src/agora_media_player.dart';
import 'package:agora_rtc_engine/src/agora_media_recorder.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine_ex.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine_ext.dart';
import 'package:agora_rtc_engine/src/agora_spatial_audio.dart';
import 'package:agora_rtc_engine/src/audio_device_manager.dart';
import 'package:agora_rtc_engine/src/binding/agora_rtc_engine_ex_impl.dart'
    as rtc_engine_ex_binding;
import 'package:agora_rtc_engine/src/binding/agora_rtc_engine_impl.dart'
    as rtc_engine_binding;
import 'package:agora_rtc_engine/src/binding/agora_media_base_event_impl.dart'
    as media_base_event_binding;

import 'package:agora_rtc_engine/src/impl/agora_media_recorder_impl_override.dart'
    as media_recorder_impl;
import 'package:agora_rtc_engine/src/impl/agora_spatial_audio_impl_override.dart'
    as agora_spatial_audio_impl;
import 'package:agora_rtc_engine/src/impl/agora_media_engine_impl_override.dart'
    as media_engine_impl;
import 'package:agora_rtc_engine/src/impl/disposable_object.dart';
import 'package:agora_rtc_engine/src/impl/media_player_impl.dart'
    as media_player_impl;
import 'package:agora_rtc_engine/src/impl/audio_device_manager_impl.dart'
    as audio_device_manager_impl;
import 'package:agora_rtc_engine/src/binding/impl_forward_export.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:iris_event/iris_event.dart';

import 'global_video_view_controller.dart';
import 'package:meta/meta.dart';

// ignore_for_file: public_member_api_docs

class ObjectPool {
  ObjectPool();
  final Map<Type, AsyncDisposableObject> pool = {};

  void put(Type objectType, AsyncDisposableObject obj) {
    pool.putIfAbsent(objectType, () => obj);
  }

  void remove(Type objectType) {
    pool.remove(objectType);
  }

  AsyncDisposableObject? get(Type objectType) {
    return pool[objectType];
  }

  Future<void> clear() async {
    for (final key in pool.keys) {
      await pool[key]?.disposeAsync();
    }

    pool.clear();
  }
}

extension RtcEngineExt on RtcEngine {
  GlobalVideoViewController get globalVideoViewController =>
      (this as RtcEngineImpl)._globalVideoViewController;

  void addToPool<V>(Type objectType, AsyncDisposableObject obj) {
    (this as RtcEngineImpl)._objectPool.put(objectType, obj);
  }

  void removeFromPool(Type objectType) {
    (this as RtcEngineImpl)._objectPool.remove(objectType);
  }

  V? getObjectFromPool<V>(Type objectType) {
    return (this as RtcEngineImpl)._objectPool.get(objectType) as V?;
  }
}

extension ThumbImageBufferExt on ThumbImageBuffer {
  ThumbImageBuffer copyWithBuffer(Map<String, dynamic> origanalJson) {
    return ThumbImageBuffer(
      buffer: uint8ListFromPtr(origanalJson['buffer'], length!),
      length: length,
      width: width,
      height: height,
    );
  }
}

extension RtcEngineEventHandlerExExt on RtcEngineEventHandler {
  bool eventIntercept(String event, String eventData, List<Uint8List> buffers) {
    switch (event) {
      case 'onStreamMessageEx':
        if (onStreamMessage == null) break;
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnStreamMessageJson paramJson =
            RtcEngineEventHandlerOnStreamMessageJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        int? streamId = paramJson.streamId;

        int? length = paramJson.length;
        int? sentTs = paramJson.sentTs;

        if (connection == null ||
            remoteUid == null ||
            streamId == null ||
            length == null ||
            sentTs == null) {
          break;
        }
        Uint8List? data = buffers[0];

        onStreamMessage!(connection, remoteUid, streamId, data, length, sentTs);
        return true;
      default:
        break;
    }
    return false;
  }
}

extension MetadataExt on Metadata {
  Metadata copyWith(
      {int? uid, int? size, Uint8List? buffer, int? timeStampMs}) {
    return Metadata(
      uid: uid ?? this.uid,
      size: size ?? this.size,
      buffer: buffer ?? this.buffer,
      timeStampMs: timeStampMs ?? this.timeStampMs,
    );
  }
}

extension MetadataObserverExt on MetadataObserver {
  bool eventIntercept(String event, String data, List<Uint8List> buffers) {
    final jsonMap = jsonDecode(data);
    switch (event) {
      case 'MetadataObserver_onMetadataReceived':
        if (onMetadataReceived == null) break;
        MetadataObserverOnMetadataReceivedJson paramJson =
            MetadataObserverOnMetadataReceivedJson.fromJson(jsonMap);
        Metadata? metadata = paramJson.metadata;

        if (metadata == null) {
          break;
        }

        metadata = Metadata(
          uid: metadata.uid,
          size: metadata.size,
          buffer: buffers[0],
          timeStampMs: metadata.timeStampMs,
        );

        onMetadataReceived!(metadata);
        return true;
      default:
        break;
    }

    return false;
  }
}

class AudioSpectrumObserverWrapper
    extends media_base_event_binding.AudioSpectrumObserverWrapper {
  const AudioSpectrumObserverWrapper(
      AudioSpectrumObserver audioSpectrumObserver)
      : super(audioSpectrumObserver);

  @override
  void onEvent(String event, String data, List<Uint8List> buffers) {
    if (!event.startsWith('RtcEngine_')) return;
    audioSpectrumObserver.process(
        event.replaceFirst('RtcEngine_', ''), data, buffers);
  }
}

class _Lifecycle with WidgetsBindingObserver {
  const _Lifecycle(this.onDestroy);

  final VoidCallback onDestroy;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.detached) {
      onDestroy();
    }
  }
}

class RtcEngineImpl extends rtc_engine_ex_binding.RtcEngineExImpl
    implements RtcEngineEx, IrisEventHandler {
  RtcEngineImpl._();

  static RtcEngineImpl? _instance;
  final Set<RtcEngineEventHandler> _rtcEngineEventHandlers = {};
  final Set<MetadataObserver> _metadataObservers = {};
  DirectCdnStreamingEventHandler? _directCdnStreamingEventHandler;

  final List<IrisEventHandler> _eventHandlers = [];

  final GlobalVideoViewController _globalVideoViewController =
      GlobalVideoViewController();

  final ObjectPool _objectPool = ObjectPool();

  int _mediaPlayerCount = 0;

  _Lifecycle? _lifecycle;

  @internal
  final MethodChannel engineMethodChannel = const MethodChannel('agora_rtc_ng');

  static RtcEngineEx create() {
    if (_instance != null) return _instance!;

    _instance = RtcEngineImpl._();

    return _instance!;
  }

  Future<void> _initializeInternal(RtcEngineContext context) async {
    _lifecycle ??= _Lifecycle(
      () {
        release(sync: true);
      },
    );
    WidgetsBinding.instance.addObserver(_lifecycle!);

    if (defaultTargetPlatform == TargetPlatform.android) {
      final externalFilesDir =
          await engineMethodChannel.invokeMethod('getExternalFilesDir');
      if (externalFilesDir != null) {
        try {
          // Reset the sdk log file to ensure the iris log path has been set
          await setLogFile('$externalFilesDir/agorasdk.log');
        } catch (e) {
          debugPrint(
              '[RtcEngine] setLogFile fail, make sure the permission is granted.');
        }
      }
    }

    await _globalVideoViewController
        .attachVideoFrameBufferManager(apiCaller.getIrisApiEngineIntPtr());
  }

  @override
  Future<void> initialize(RtcEngineContext context) async {
    await apiCaller.initilizeAsync();
    await super.initialize(context);

    await apiCaller.callIrisApi(
      'RtcEngine_setAppType',
      jsonEncode({'appType': 4}),
    );

    await _initializeInternal(context);
  }

  @override
  Future<void> release({bool sync = false}) async {
    if (_instance == null) return;

    if (_lifecycle != null) {
      WidgetsBinding.instance.removeObserver(_lifecycle!);
      _lifecycle = null;
    }

    if (_rtcEngineEventHandlers.isNotEmpty) {
      _rtcEngineEventHandlers.clear();
      apiCaller.removeEventHandler(this);
    }

    _eventHandlers.clear();
    _metadataObservers.clear();
    _directCdnStreamingEventHandler = null;
    _mediaPlayerCount = 0;

    await _objectPool.clear();

    await apiCaller.disposeAllEventHandlersAsync();

    await _globalVideoViewController
        .detachVideoFrameBufferManager(apiCaller.getIrisApiEngineIntPtr());

    await super.release(sync: sync);

    await apiCaller.disposeAsync();
    _instance = null;
  }

  @override
  void onEvent(String event, String data, List<Uint8List> buffers) {
    for (final e in _eventHandlers) {
      e.onEvent(event, data, buffers);
    }

    for (final eh in _rtcEngineEventHandlers) {
      if (!eh.eventIntercept(event, data, buffers)) {
        eh.process(event, data, buffers);
      }
    }

    for (final observer in _metadataObservers) {
      if (!observer.eventIntercept(event, data, buffers)) {
        observer.process(event, data, buffers);
      }
    }

    _directCdnStreamingEventHandler?.process(event, data, buffers);
  }

  @override
  void registerEventHandler(
      covariant RtcEngineEventHandler eventHandler) async {
    if (_rtcEngineEventHandlers.isEmpty) {
      await apiCaller.setupIrisRtcEngineEventHandlerAsync();
      apiCaller.addEventHandler(_instance!);
    }
    _rtcEngineEventHandlers.add(eventHandler);
  }

  @override
  void unregisterEventHandler(
      covariant RtcEngineEventHandler eventHandler) async {
    _rtcEngineEventHandlers.remove(eventHandler);
    if (_rtcEngineEventHandlers.isEmpty) {
      await apiCaller.disposeIrisRtcEngineEventHandlerAsync();
    }
  }

  @override
  Future<void> setupRemoteVideo(VideoCanvas canvas) async {
    const apiType = 'RtcEngine_setupRemoteVideo';
    final jsonWithBuffer = canvas.toJson();
    final bufferPtr = canvas.priv != null ? uint8ListToPtr(canvas.priv!) : null;
    jsonWithBuffer['priv'] = bufferPtr?.address;
    final param = createParams({'canvas': jsonWithBuffer});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    if (bufferPtr != null) {
      freePointer(bufferPtr);
    }
    final result = rm['result'];

    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> setupLocalVideo(VideoCanvas canvas) async {
    const apiType = 'RtcEngine_setupLocalVideo';
    final jsonWithBuffer = canvas.toJson();
    final bufferPtr = canvas.priv != null ? uint8ListToPtr(canvas.priv!) : null;
    jsonWithBuffer['priv'] = bufferPtr?.address;
    final param = createParams({'canvas': jsonWithBuffer});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    if (bufferPtr != null) {
      freePointer(bufferPtr);
    }
    final result = rm['result'];

    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> setupRemoteVideoEx(
      {required VideoCanvas canvas, required RtcConnection connection}) async {
    const apiType = 'RtcEngineEx_setupRemoteVideoEx';
    final jsonWithBuffer = canvas.toJson();
    final bufferPtr = canvas.priv != null ? uint8ListToPtr(canvas.priv!) : null;
    jsonWithBuffer['priv'] = bufferPtr?.address;
    final param = createParams({
      'canvas': jsonWithBuffer,
      'connection': connection.toJson(),
    });
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    if (bufferPtr != null) {
      freePointer(bufferPtr);
    }
    final result = rm['result'];

    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<MediaPlayer> createMediaPlayer() async {
    const apiType = 'RtcEngine_createMediaPlayer';
    final param = createParams({});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];

    if (_mediaPlayerCount == 0) {
      await apiCaller.setupIrisMediaPlayerEventHandlerIfNeedAsync();
    }

    final MediaPlayer mediaPlayer =
        media_player_impl.MediaPlayerImpl.create(result as int);
    ++_mediaPlayerCount;
    return mediaPlayer;
  }

  @override
  Future<void> destroyMediaPlayer(covariant MediaPlayer mediaPlayer) async {
    --_mediaPlayerCount;
    if (_mediaPlayerCount == 0) {
      await apiCaller.disposeIrisMediaPlayerEventHandlerIfNeedAsync();
    }

    const apiType = 'RtcEngine_destroyMediaPlayer';
    final playerId = mediaPlayer.getMediaPlayerId();
    final param = createParams({'playerId': playerId});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> sendStreamMessage(
      {required int streamId,
      required Uint8List data,
      required int length}) async {
    const apiType = 'RtcEngine_sendStreamMessage';
    final dataPtr = uint8ListToPtr(data);
    final param = createParams(
        {'streamId': streamId, 'data': dataPtr.address, 'length': length});
    final callApiResult = await apiCaller
        .callIrisApi(apiType, jsonEncode(param), buffers: [data]);
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;

    freePointer(dataPtr);
    final result = rm['result'];

    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> enableEncryption(
      {required bool enabled, required EncryptionConfig config}) async {
    const apiType = 'RtcEngine_enableEncryption';
    final configJsonMap = config.toJson();
    if (config.encryptionKdfSalt != null) {
      configJsonMap['encryptionKdfSalt'] = config.encryptionKdfSalt!;
    }

    final param = createParams({'enabled': enabled, 'config': configJsonMap});

    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> enableEncryptionEx(
      {required RtcConnection connection,
      required bool enabled,
      required EncryptionConfig config}) async {
    const apiType = 'RtcEngineEx_enableEncryptionEx';
    final configJsonMap = config.toJson();
    if (config.encryptionKdfSalt != null) {
      configJsonMap['encryptionKdfSalt'] = config.encryptionKdfSalt!;
    }

    final param = createParams({
      'connection': connection.toJson(),
      'enabled': enabled,
      'config': configJsonMap
    });

    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<List<ScreenCaptureSourceInfo>> getScreenCaptureSources(
      {required SIZE thumbSize,
      required SIZE iconSize,
      required bool includeScreen}) async {
    const apiType = 'RtcEngine_getScreenCaptureSources';
    final param = createParams({
      'thumbSize': thumbSize.toJson(),
      'iconSize': iconSize.toJson(),
      'includeScreen': includeScreen
    });
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    final sourcesIntPtr = rm['sources'];
    final resultList = List.from(result);
    List<ScreenCaptureSourceInfo> output = [];
    for (final r in resultList) {
      final oldInfo = ScreenCaptureSourceInfo.fromJson(r);

      final newThumbImage = oldInfo.thumbImage!.copyWithBuffer(r['thumbImage']);
      final newIconImage = oldInfo.iconImage!.copyWithBuffer(r['iconImage']);
      final info = ScreenCaptureSourceInfo(
        type: oldInfo.type,
        sourceId: oldInfo.sourceId,
        sourceName: oldInfo.sourceName,
        thumbImage: newThumbImage,
        iconImage: newIconImage,
        processPath: oldInfo.processPath,
        sourceTitle: oldInfo.sourceTitle,
        primaryMonitor: oldInfo.primaryMonitor,
        isOccluded: oldInfo.isOccluded,
      );

      output.add(info);
    }

    await apiCaller.callIrisApi(
      'RtcEngine_releaseScreenCaptureSources',
      jsonEncode({'sources': sourcesIntPtr}),
    );

    return output;
  }

  @override
  Future<void> sendMetaData(
      {required Metadata metadata, required VideoSourceType sourceType}) async {
    assert(metadata.buffer != null);
    const apiType = 'RtcEngine_sendMetaData';
    final dataPtr = uint8ListToPtr(metadata.buffer!);
    final metadataMap = metadata.toJson();
    metadataMap['buffer'] = dataPtr.address;
    final param = createParams(
        {'metadata': metadataMap, 'source_type': sourceType.value()});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    freePointer(dataPtr);
    final result = rm['result'];

    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  void registerMediaMetadataObserver(
      {required MetadataObserver observer, required MetadataType type}) async {
    const apiType = 'RtcEngine_registerMediaMetadataObserver';
    final param = createParams({'type': type.value()});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
    _metadataObservers.add(observer);
  }

  @override
  void unregisterMediaMetadataObserver(
      {required MetadataObserver observer, required MetadataType type}) async {
    const apiType = 'RtcEngine_unregisterMediaMetadataObserver';
    final param = createParams({'type': type.value()});

    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }

    _metadataObservers.remove(observer);
  }

  @override
  Future<void> startDirectCdnStreaming(
      {required DirectCdnStreamingEventHandler eventHandler,
      required String publishUrl,
      required DirectCdnStreamingMediaOptions options}) async {
    _directCdnStreamingEventHandler = eventHandler;

    const apiType = 'RtcEngine_startDirectCdnStreaming';
    final param =
        createParams({'publishUrl': publishUrl, 'options': options.toJson()});

    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> stopDirectCdnStreaming() async {
    await super.stopDirectCdnStreaming();

    _directCdnStreamingEventHandler = null;
  }

  @override
  VideoDeviceManager getVideoDeviceManager() {
    return VideoDeviceManagerImpl.create();
  }

  @override
  AudioDeviceManager getAudioDeviceManager() {
    return audio_device_manager_impl.AudioDeviceManagerImpl.create();
  }

  @override
  MediaEngine getMediaEngine() {
    return getObjectFromPool(MediaEngineImpl) ??
        media_engine_impl.MediaEngineImpl.create(this);
  }

  @override
  MediaRecorder getMediaRecorder() {
    return getObjectFromPool(MediaRecorderImpl) ??
        media_recorder_impl.MediaRecorderImpl.create(this);
  }

  @override
  LocalSpatialAudioEngine getLocalSpatialAudioEngine() {
    return getObjectFromPool(LocalSpatialAudioEngineImpl) ??
        agora_spatial_audio_impl.LocalSpatialAudioEngineImpl.create(this);
  }

  @override
  Future<SDKBuildInfo> getVersion() async {
    const apiType = 'RtcEngine_getVersion';
    final param = createParams({});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return SDKBuildInfo(version: result, build: rm['build']);
  }

  @override
  Future<void> joinChannel(
      {required String token,
      required String channelId,
      required int uid,
      required ChannelMediaOptions options}) async {
    const apiType = 'RtcEngine_joinChannel2';
    final param = createParams({
      'token': token,
      'channelId': channelId,
      'uid': uid,
      'options': options.toJson()
    });
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> leaveChannel({LeaveChannelOptions? options}) async {
    final apiType =
        options == null ? 'RtcEngine_leaveChannel' : 'RtcEngine_leaveChannel2';
    final param = createParams({'options': options?.toJson()});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> setClientRole(
      {required ClientRoleType role, ClientRoleOptions? options}) async {
    final apiType = options == null
        ? 'RtcEngine_setClientRole'
        : 'RtcEngine_setClientRole2';
    final param =
        createParams({'role': role.value(), 'options': options?.toJson()});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> startEchoTest({int intervalInSeconds = 10}) async {
    const apiType = 'RtcEngine_startEchoTest2';
    final param = createParams({'intervalInSeconds': intervalInSeconds});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> startPreview(
      {VideoSourceType sourceType =
          VideoSourceType.videoSourceCameraPrimary}) async {
    if (_instance == null) return;
    const apiType = 'RtcEngine_startPreview2';
    final param = createParams({'sourceType': sourceType.value()});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> enableVideo() async {
    if (_instance == null) return;
    super.enableVideo();
  }

  @override
  Future<void> stopPreview(
      {VideoSourceType sourceType =
          VideoSourceType.videoSourceCameraPrimary}) async {
    const apiType = 'RtcEngine_stopPreview2';
    final param = createParams({'sourceType': sourceType.value()});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> startAudioRecording(AudioRecordingConfiguration config) async {
    const apiType = 'RtcEngine_startAudioRecording3';
    final param = createParams({'config': config.toJson()});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> startAudioMixing(
      {required String filePath,
      required bool loopback,
      required int cycle,
      int startPos = 0}) async {
    const apiType = 'RtcEngine_startAudioMixing2';
    final param = createParams({
      'filePath': filePath,
      'loopback': loopback,
      'cycle': cycle,
      'startPos': startPos
    });
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> enableDualStreamMode(
      {required bool enabled,
      VideoSourceType sourceType = VideoSourceType.videoSourceCameraPrimary,
      SimulcastStreamConfig? streamConfig}) async {
    final apiType = streamConfig == null
        ? 'RtcEngine_enableDualStreamMode2'
        : 'RtcEngine_enableDualStreamMode3';
    final param = createParams({
      'enabled': enabled,
      'sourceType': sourceType.value(),
      'streamConfig': streamConfig?.toJson()
    });
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<int> createDataStream(DataStreamConfig config) async {
    const apiType = 'RtcEngine_createDataStream2';
    final param = createParams({'config': config.toJson()});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
    final streamIdResult = rm['streamId'];
    return streamIdResult as int;
  }

  @override
  Future<void> addVideoWatermark(
      {required String watermarkUrl, required WatermarkOptions options}) async {
    const apiType = 'RtcEngine_addVideoWatermark2';
    final param = createParams(
        {'watermarkUrl': watermarkUrl, 'options': options.toJson()});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> joinChannelWithUserAccount(
      {required String token,
      required String channelId,
      required String userAccount,
      ChannelMediaOptions? options}) async {
    final apiType = options == null
        ? 'RtcEngine_joinChannelWithUserAccount'
        : 'RtcEngine_joinChannelWithUserAccount2';
    final param = createParams({
      'token': token,
      'channelId': channelId,
      'userAccount': userAccount,
      'options': options?.toJson()
    });
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  void registerAudioEncodedFrameObserver(
      {required AudioEncodedFrameObserverConfig config,
      required AudioEncodedFrameObserver observer}) async {
    final param = createParams({'config': config.toJson()});
    await apiCaller.callIrisEventAsync(
        const IrisEventObserverKey(
            op: CallIrisEventOp.create,
            registerName: 'RtcEngine_registerAudioEncodedFrameObserver',
            unregisterName: 'RtcEngine_unregisterAudioEncodedFrameObserver'),
        jsonEncode(param));

    _eventHandlers.add(AudioEncodedFrameObserverWrapper(observer));
  }

  @override
  void unregisterAudioEncodedFrameObserver(
      AudioEncodedFrameObserver observer) async {
    final param = createParams({});
    await apiCaller.callIrisEventAsync(
        const IrisEventObserverKey(
            op: CallIrisEventOp.dispose,
            registerName: 'RtcEngine_registerAudioEncodedFrameObserver',
            unregisterName: 'RtcEngine_unregisterAudioEncodedFrameObserver'),
        jsonEncode(param));

    _eventHandlers.remove(AudioEncodedFrameObserverWrapper(observer));
  }

  @override
  void registerAudioSpectrumObserver(AudioSpectrumObserver observer) async {
    final param = createParams({});
    await apiCaller.callIrisEventAsync(
        const IrisEventObserverKey(
            op: CallIrisEventOp.create,
            registerName: 'RtcEngine_registerAudioSpectrumObserver',
            unregisterName: 'RtcEngine_unregisterAudioSpectrumObserver'),
        jsonEncode(param));

    _eventHandlers.add(AudioSpectrumObserverWrapper(observer));
  }

  @override
  void unregisterAudioSpectrumObserver(AudioSpectrumObserver observer) async {
    final param = createParams({});
    await apiCaller.callIrisEventAsync(
        const IrisEventObserverKey(
            op: CallIrisEventOp.dispose,
            registerName: 'RtcEngine_registerAudioSpectrumObserver',
            unregisterName: 'RtcEngine_unregisterAudioSpectrumObserver'),
        jsonEncode(param));

    _eventHandlers.remove(AudioSpectrumObserverWrapper(observer));
  }

  /////////// debug ////////

  /// [type] see [VideoSourceType], only [VideoSourceType.videoSourceCamera], [VideoSourceType.videoSourceRemote] supported
  Future<void> startDumpVideo(int type, String dir) {
    return apiCaller.startDumpVideoAsync(
        _globalVideoViewController.videoFrameBufferManagerIntPtr, type, dir);
  }

  Future<void> stopDumpVideo() {
    return apiCaller.stopDumpVideoAsync(
        _globalVideoViewController.videoFrameBufferManagerIntPtr);
  }

  //////////////////////////
}

class VideoDeviceManagerImpl extends rtc_engine_binding.VideoDeviceManagerImpl
    implements VideoDeviceManager {
  static VideoDeviceManagerImpl? _instance;

  VideoDeviceManagerImpl._();

  @override
  factory VideoDeviceManagerImpl.create() {
    if (_instance != null) return _instance!;

    _instance = VideoDeviceManagerImpl._();

    return _instance!;
  }

  @override
  Future<List<VideoDeviceInfo>> enumerateVideoDevices() async {
    const apiType = 'VideoDeviceManager_enumerateVideoDevices';
    final param = createParams({});

    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];

    final devicesList = List.from(result);
    final List<VideoDeviceInfo> deviceInfoList = [];
    for (final d in devicesList) {
      final dm = Map<String, dynamic>.from(d);

      deviceInfoList.add(VideoDeviceInfo.fromJson(dm));
    }

    return deviceInfoList;
  }

  @override
  Future<void> release() async {
    _instance = null;
  }
}
