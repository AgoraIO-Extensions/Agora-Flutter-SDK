import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:agora_rtc_engine/src/agora_base.dart';
import 'package:agora_rtc_engine/src/agora_h265_transcoder.dart';
import 'package:agora_rtc_engine/src/agora_media_base.dart';
import 'package:agora_rtc_engine/src/agora_media_engine.dart';
import 'package:agora_rtc_engine/src/agora_media_player.dart';
import 'package:agora_rtc_engine/src/agora_media_recorder.dart';
import 'package:agora_rtc_engine/src/agora_music_content_center.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine_ex.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine_ext.dart';
import 'package:agora_rtc_engine/src/agora_spatial_audio.dart';
import 'package:agora_rtc_engine/src/audio_device_manager.dart';
import 'package:agora_rtc_engine/src/binding/agora_base_event_impl.dart';
import 'package:agora_rtc_engine/src/binding/agora_media_base_event_impl.dart';
import 'package:agora_rtc_engine/src/binding/agora_media_engine_impl.dart';
import 'package:agora_rtc_engine/src/binding/agora_rtc_engine_event_impl.dart';
import 'package:agora_rtc_engine/src/binding/agora_rtc_engine_ex_impl.dart'
    as rtc_engine_ex_binding;
import 'package:agora_rtc_engine/src/binding/agora_rtc_engine_impl.dart'
    as rtc_engine_binding;
import 'package:agora_rtc_engine/src/binding/agora_spatial_audio_impl.dart';
import 'package:agora_rtc_engine/src/binding/call_api_event_handler_buffer_ext.dart';
import 'package:agora_rtc_engine/src/binding/event_handler_param_json.dart';
import 'package:agora_rtc_engine/src/impl/agora_h265_transcoder_impl_override.dart';
import 'package:agora_rtc_engine/src/impl/agora_media_engine_impl_override.dart'
    as media_engine_impl;
import 'package:agora_rtc_engine/src/impl/agora_media_recorder_impl_override.dart'
    as media_recorder_impl;
import 'package:agora_rtc_engine/src/impl/agora_music_content_center_impl_override.dart'
    as mcci;
import 'package:agora_rtc_engine/src/impl/agora_spatial_audio_impl_override.dart'
    as agora_spatial_audio_impl;
import 'package:agora_rtc_engine/src/impl/audio_device_manager_impl.dart'
    as audio_device_manager_impl;
import 'package:agora_rtc_engine/src/impl/media_player_impl.dart'
    as media_player_impl;

import 'package:agora_rtc_engine/src/impl/platform/platform_bindings_provider.dart';
import 'package:async/async.dart' show AsyncMemoizer;
import 'package:flutter/foundation.dart'
    show
        ChangeNotifier,
        debugPrint,
        defaultTargetPlatform,
        kIsWeb,
        visibleForTesting;
import 'package:flutter/services.dart' show MethodChannel;
import 'package:flutter/widgets.dart' show VoidCallback, TargetPlatform;
import 'package:iris_method_channel/iris_method_channel.dart';
import 'package:meta/meta.dart';

import 'platform/global_video_view_controller.dart';

// ignore_for_file: public_member_api_docs

InitilizationArgProvider? _mockRtcEngineProvider;
@visibleForTesting
void setMockRtcEngineProvider(InitilizationArgProvider? mockRtcEngineProvider) {
  assert(() {
    _mockRtcEngineProvider = mockRtcEngineProvider;
    return true;
  }());
}

// In 64-bits system, the native handle ptr value (unsigned long 64) can be 2^64 - 1,
// which may greater than the dart int max value (2^63 - 1), so we can not decode
// the json with big int native handle ptr value and parse it directly.
//
// After dart sdk 2.0 support parse hexadecimal in unsigned int64 range.
// https://github.com/dart-lang/language/blob/ee1135e0c22391cee17bf3ee262d6a04582d25de/archive/newsletter/20170929.md#semantics
//
// So we retrive the native handle ptr value from the json string directly, and
// parse an int from hexadecimal here.
int _string2IntPtr(String stringPtr) {
  BigInt nativeHandleBI = BigInt.parse(stringPtr);
  return int.parse('0x${nativeHandleBI.toRadixString(16)}');
}

extension RtcEngineExt on RtcEngine {
  GlobalVideoViewControllerPlatfrom? get globalVideoViewController =>
      (this as RtcEngineImpl).globalVideoViewController;

  ScopedObjects get objectPool => (this as RtcEngineImpl)._objectPool;

  IrisMethodChannel get irisMethodChannel =>
      (this as RtcEngineImpl)._getIrisMethodChannel();

  Future<void> setupVideoView(Object viewHandle, VideoCanvas videoCanvas,
      {RtcConnection? connection}) async {
    Object view = viewHandle;
    if (kIsWeb) {
      view = 0;
    }

    VideoCanvas newVideoCanvas = VideoCanvas(
      view: view as int,
      renderMode: videoCanvas.renderMode,
      mirrorMode: videoCanvas.mirrorMode,
      uid: videoCanvas.uid,
      sourceType: videoCanvas.sourceType,
      cropArea: videoCanvas.cropArea,
      setupMode: videoCanvas.setupMode,
      mediaPlayerId: videoCanvas.mediaPlayerId,
    );
    try {
      if (newVideoCanvas.uid != 0) {
        if (connection != null) {
          await _setupRemoteVideoExCompat(
              viewHandle, newVideoCanvas, connection);
        } else {
          await _setupRemoteVideoCompat(viewHandle, newVideoCanvas);
        }
      } else {
        await _setupLocalVideoCompat(viewHandle, newVideoCanvas);
      }
    } catch (e) {
      debugPrint('setupVideoView error: ${e.toString()}');
    }
  }

  Future<void> _setupRemoteVideoExCompat(
      Object viewHandle, VideoCanvas canvas, RtcConnection connection) async {
    if (kIsWeb) {
      return _setupRemoteVideoExWeb(viewHandle, canvas, connection);
    }
    return (this as RtcEngineImpl)
        .setupRemoteVideoEx(canvas: canvas, connection: connection);
  }

  Future<void> _setupRemoteVideoCompat(
      Object viewHandle, VideoCanvas canvas) async {
    if (kIsWeb) {
      return _setupRemoteVideoWeb(viewHandle, canvas);
    }
    return setupRemoteVideo(canvas);
  }

  Future<void> _setupLocalVideoCompat(
      Object viewHandle, VideoCanvas canvas) async {
    if (kIsWeb) {
      return _setupLocalVideoWeb(canvas, viewHandle);
    }
    return setupLocalVideo(canvas);
  }

  Map<String, dynamic> _createParamsWeb(Object viewHandle, VideoCanvas canvas,
      {RtcConnection? connection}) {
    // The type of the `VideoCanvas.view` is `String` on web
    final param = {
      'canvas': canvas.toJson()..['view'] = (viewHandle as String),
      if (connection != null) 'connection': connection.toJson(),
    };
    return param;
  }

  Future<void> _setupRemoteVideoExWeb(
      Object viewHandle, VideoCanvas canvas, RtcConnection connection) async {
    const apiType = 'RtcEngineEx_setupRemoteVideoEx_522a409';
    final param = _createParamsWeb(viewHandle, canvas, connection: connection);
    final List<Uint8List> buffers = [];
    buffers.addAll(canvas.collectBufferList());
    buffers.addAll(connection.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  Future<void> _setupRemoteVideoWeb(
      Object viewHandle, VideoCanvas canvas) async {
    const apiType = 'RtcEngine_setupRemoteVideo_acc9c38';
    final param = _createParamsWeb(viewHandle, canvas);
    final List<Uint8List> buffers = [];
    buffers.addAll(canvas.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  Future<void> _setupLocalVideoWeb(
      VideoCanvas canvas, Object viewHandle) async {
    const apiType = 'RtcEngine_setupLocalVideo_acc9c38';
    // The type of the `VideoCanvas.view` is `String` on web
    final param = _createParamsWeb(viewHandle, canvas);
    final List<Uint8List> buffers = [];
    buffers.addAll(canvas.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(IrisMethodCall(
      apiType,
      jsonEncode(param),
      rawBufferParams: [BufferParam(BufferParamHandle(viewHandle), 1)],
    ));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    return;
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
      case 'RtcEngineEventHandler_onStreamMessage_99898cb':
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
      case 'MetadataObserver_onMetadataReceived_cb7661d':
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

@internal
class InitializationState extends ChangeNotifier {
  bool _isInitialzed = false;
  bool get isInitialzed => _isInitialzed;
  set isInitialzed(bool value) {
    if (_isInitialzed == value) {
      return;
    }

    _isInitialzed = value;
    notifyListeners();
  }
}

class SharedNativeHandleInitilizationArgProvider
    implements InitilizationArgProvider {
  const SharedNativeHandleInitilizationArgProvider(this.sharedNativeHandle);

  final Object sharedNativeHandle;
  @override
  IrisHandle provide(IrisApiEngineHandle apiEngineHandle) {
    return ObjectIrisHandle(sharedNativeHandle);
  }
}

class RtcEngineImpl extends rtc_engine_ex_binding.RtcEngineExImpl
    implements RtcEngineEx {
  RtcEngineImpl._({
    required IrisMethodChannel irisMethodChannel,
    Object? sharedNativeHandle,
  })  : _sharedNativeHandle = sharedNativeHandle,
        super(irisMethodChannel);

  static RtcEngineImpl? _instance;

  Object? _sharedNativeHandle;

  InitializationState? _rtcEngineStateInternal;
  InitializationState get _rtcEngineState {
    _rtcEngineStateInternal ??= InitializationState();
    return _rtcEngineStateInternal!;
  }

  @internal
  bool get isInitialzed => _rtcEngineState.isInitialzed;

  bool _isReleased = false;

  Completer<void>? _initializingCompleter;
  Completer<void>? _releasingCompleter;

  final _rtcEngineImplScopedKey = const TypedScopedKey(RtcEngineImpl);

  GlobalVideoViewControllerPlatfrom? _globalVideoViewController;
  GlobalVideoViewControllerPlatfrom get globalVideoViewController {
    _globalVideoViewController ??=
        createGlobalVideoViewController(irisMethodChannel, this);
    return _globalVideoViewController!;
  }

  final ScopedObjects _objectPool = ScopedObjects();

  DirectCdnStreamingEventHandlerWrapper? _directCdnStreamingEventHandlerWrapper;

  @internal
  late MethodChannel engineMethodChannel;

  AsyncMemoizer? _initializeCallOnce;

  static RtcEngineEx create({
    Object? sharedNativeHandle,
    IrisMethodChannel? irisMethodChannel,
  }) {
    if (_instance != null) {
      _instance!._updateSharedNativeHandle(sharedNativeHandle);
      return _instance!;
    }

    _instance = RtcEngineImpl._(
      irisMethodChannel: irisMethodChannel ??
          IrisMethodChannel(createPlatformBindingsProvider()),
      sharedNativeHandle: sharedNativeHandle,
    );

    return _instance!;
  }

  @visibleForTesting
  static RtcEngineEx createForTesting({
    Object? sharedNativeHandle,
    required IrisMethodChannel irisMethodChannel,
  }) {
    return RtcEngineImpl._(
      irisMethodChannel: irisMethodChannel,
      sharedNativeHandle: sharedNativeHandle,
    );
  }

  void _updateSharedNativeHandle(Object? sharedNativeHandle) {
    if (_sharedNativeHandle != sharedNativeHandle) {
      _sharedNativeHandle = sharedNativeHandle;
    }
  }

  IrisMethodChannel _getIrisMethodChannel() {
    return irisMethodChannel;
  }

  Future<void> _initializeInternal(RtcEngineContext context) async {
    await globalVideoViewController
        .attachVideoFrameBufferManager(irisMethodChannel.getApiEngineHandle());
  }

  @override
  Future<void> initialize(RtcEngineContext context) async {
    // The `RtcEngine` is a singleton, a new `initialize` should be called after the
    // previous `release` is completed, or the following API calls maybe call to the
    // previous `RtcEngine` instance, which maybe cause some unexpected error. so we
    // should wait for the previous `release` function is completed here.
    if (_releasingCompleter != null && !_releasingCompleter!.isCompleted) {
      await _releasingCompleter?.future;
    }

    // If previous initialization still in progess, skip it.
    if (_initializingCompleter != null &&
        !_initializingCompleter!.isCompleted) {
      return;
    }

    _initializingCompleter = Completer<void>();
    _initializeCallOnce ??= AsyncMemoizer();
    await _initializeCallOnce!.runOnce(() async {
      engineMethodChannel = const MethodChannel('agora_rtc_ng');

      if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
        await engineMethodChannel.invokeMethod('androidInit');
      }

      List<InitilizationArgProvider> args = [
        if (_sharedNativeHandle != null)
          SharedNativeHandleInitilizationArgProvider(_sharedNativeHandle!)
      ];
      assert(() {
        if (_mockRtcEngineProvider != null) {
          args.add(_mockRtcEngineProvider!);
        }
        return true;
      }());

      await irisMethodChannel.initilize(args);
      await _initializeInternal(context);
    });

    await super.initialize(context);

    await irisMethodChannel.invokeMethod(IrisMethodCall(
      'RtcEngine_setAppType',
      jsonEncode({'appType': 4}),
    ));

    _rtcEngineState.isInitialzed = true;
    _isReleased = false;
    _initializingCompleter?.complete(null);
    _initializingCompleter = null;
  }

  @internal
  void addInitializedCompletedListener(VoidCallback listener) {
    _rtcEngineState.addListener(listener);
  }

  @internal
  void removeInitializedCompletedListener(VoidCallback listener) {
    _rtcEngineState.removeListener(listener);
  }

  @override
  Future<void> release({bool sync = false}) async {
    // Same as explanation inside `initialize`. We should wait for
    // the `initialize` function is completed here.
    if (_initializingCompleter != null &&
        !_initializingCompleter!.isCompleted) {
      await _initializingCompleter?.future;
    }

    // If previous release still in progess, skip it.
    if (_releasingCompleter != null && !_releasingCompleter!.isCompleted) {
      return;
    }

    if (!_rtcEngineState.isInitialzed || _isReleased) {
      return;
    }

    _releasingCompleter = Completer<void>();

    _rtcEngineStateInternal?.dispose();
    _rtcEngineStateInternal = null;

    await _objectPool.clear();

    await _globalVideoViewController
        ?.detachVideoFrameBufferManager(irisMethodChannel.getApiEngineHandle());
    _globalVideoViewController = null;

    await irisMethodChannel.unregisterEventHandlers(_rtcEngineImplScopedKey);

    await super.release(sync: sync);

    await irisMethodChannel.dispose();
    _isReleased = true;
    _releasingCompleter?.complete(null);
    _releasingCompleter = null;
    assert(_initializeCallOnce!.hasRun);
    _initializeCallOnce = null;
    _instance = null;
  }

  @override
  void registerEventHandler(
      covariant RtcEngineEventHandler eventHandler) async {
    final eventHandlerWrapper = RtcEngineEventHandlerWrapper(eventHandler);
    final param = createParams({});

    await irisMethodChannel.registerEventHandler(
        ScopedEvent(
            scopedKey: _rtcEngineImplScopedKey,
            registerName: 'RtcEngine_registerEventHandler_5fc0465',
            unregisterName: 'RtcEngine_unregisterEventHandler_5fc0465',
            handler: eventHandlerWrapper),
        jsonEncode(param));
  }

  @override
  void unregisterEventHandler(
      covariant RtcEngineEventHandler eventHandler) async {
    final eventHandlerWrapper = RtcEngineEventHandlerWrapper(eventHandler);
    final param = createParams({});

    await irisMethodChannel.unregisterEventHandler(
        ScopedEvent(
            scopedKey: _rtcEngineImplScopedKey,
            registerName: 'RtcEngine_registerEventHandler_5fc0465',
            unregisterName: 'RtcEngine_unregisterEventHandler_5fc0465',
            handler: eventHandlerWrapper),
        jsonEncode(param));
  }

  @override
  Future<MediaPlayer?> createMediaPlayer() async {
    const apiType = 'RtcEngine_createMediaPlayer';
    final param = createParams({});
    final callApiResult = await irisMethodChannel
        .invokeMethod(IrisMethodCall(apiType, jsonEncode(param)));
    if (callApiResult.irisReturnCode < 0) {
      return null;
    }
    final rm = callApiResult.data;
    final result = rm['result'];

// TODO(littlegnal): Manage the mediaPlayer in scopedObjects
    final MediaPlayer mediaPlayer = media_player_impl.MediaPlayerImpl.create(
        result as int, irisMethodChannel);
    return mediaPlayer;
  }

  @override
  Future<void> destroyMediaPlayer(covariant MediaPlayer mediaPlayer) async {
    const apiType = 'RtcEngine_destroyMediaPlayer_328a49b';
    final playerId = mediaPlayer.getMediaPlayerId();
    final param = createParams({'playerId': playerId});
    final callApiResult = await irisMethodChannel
        .invokeMethod(IrisMethodCall(apiType, jsonEncode(param)));
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
  Future<void> enableEncryption(
      {required bool enabled, required EncryptionConfig config}) async {
    const apiType = 'RtcEngine_enableEncryption_421c27b';
    final configJsonMap = config.toJson();
    if (config.encryptionKdfSalt != null) {
      configJsonMap['encryptionKdfSalt'] = config.encryptionKdfSalt!;
    }

    final param = createParams({'enabled': enabled, 'config': configJsonMap});

    final callApiResult = await irisMethodChannel
        .invokeMethod(IrisMethodCall(apiType, jsonEncode(param)));
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
    const apiType = 'RtcEngineEx_enableEncryptionEx_10cd872';
    final configJsonMap = config.toJson();
    if (config.encryptionKdfSalt != null) {
      configJsonMap['encryptionKdfSalt'] = config.encryptionKdfSalt!;
    }

    final param = createParams({
      'connection': connection.toJson(),
      'enabled': enabled,
      'config': configJsonMap
    });

    final callApiResult = await irisMethodChannel
        .invokeMethod(IrisMethodCall(apiType, jsonEncode(param)));
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
    const apiType = 'RtcEngine_getScreenCaptureSources_f3e02cb';
    final param = createParams({
      'thumbSize': thumbSize.toJson(),
      'iconSize': iconSize.toJson(),
      'includeScreen': includeScreen
    });
    final callApiResult = await irisMethodChannel
        .invokeMethod(IrisMethodCall(apiType, jsonEncode(param)));
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

    await irisMethodChannel.invokeMethod(IrisMethodCall(
        'RtcEngine_releaseScreenCaptureSources',
        jsonEncode({'sources': sourcesIntPtr})));

    return output;
  }

  @override
  void registerMediaMetadataObserver(
      {required MetadataObserver observer, required MetadataType type}) async {
    final eventHandlerWrapper = MetadataObserverWrapper(observer);
    final param = createParams({'type': type.value()});

    await irisMethodChannel.registerEventHandler(
        ScopedEvent(
            scopedKey: _rtcEngineImplScopedKey,
            registerName: 'RtcEngine_registerMediaMetadataObserver_8701fec',
            unregisterName: 'RtcEngine_unregisterMediaMetadataObserver_8701fec',
            handler: eventHandlerWrapper),
        jsonEncode(param));
  }

  @override
  void unregisterMediaMetadataObserver(
      {required MetadataObserver observer, required MetadataType type}) async {
    final eventHandlerWrapper = MetadataObserverWrapper(observer);
    final param = createParams({'type': type.value()});

    await irisMethodChannel.unregisterEventHandler(
        ScopedEvent(
            scopedKey: _rtcEngineImplScopedKey,
            registerName: 'RtcEngine_registerMediaMetadataObserver_8701fec',
            unregisterName: 'RtcEngine_unregisterMediaMetadataObserver_8701fec',
            handler: eventHandlerWrapper),
        jsonEncode(param));
  }

  @override
  Future<void> startDirectCdnStreaming(
      {required DirectCdnStreamingEventHandler eventHandler,
      required String publishUrl,
      required DirectCdnStreamingMediaOptions options}) async {
    _directCdnStreamingEventHandlerWrapper =
        DirectCdnStreamingEventHandlerWrapper(eventHandler);
    final param =
        createParams({'publishUrl': publishUrl, 'options': options.toJson()});

    await irisMethodChannel.registerEventHandler(
        ScopedEvent(
            scopedKey: _rtcEngineImplScopedKey,
            registerName: 'RtcEngine_startDirectCdnStreaming_ed8d77b',
            unregisterName: 'RtcEngine_stopDirectCdnStreaming',
            handler: _directCdnStreamingEventHandlerWrapper!),
        jsonEncode(param));
  }

  @override
  Future<void> stopDirectCdnStreaming() async {
    if (_directCdnStreamingEventHandlerWrapper == null) {
      return;
    }

    final param = createParams({});
    await irisMethodChannel.unregisterEventHandler(
        ScopedEvent(
            scopedKey: _rtcEngineImplScopedKey,
            registerName: 'RtcEngine_startDirectCdnStreaming_ed8d77b',
            unregisterName: 'RtcEngine_stopDirectCdnStreaming',
            handler: _directCdnStreamingEventHandlerWrapper!),
        jsonEncode(param));

    _directCdnStreamingEventHandlerWrapper = null;
  }

  @override
  VideoDeviceManager getVideoDeviceManager() {
    return VideoDeviceManagerImpl.create(this);
  }

  @override
  AudioDeviceManager getAudioDeviceManager() {
    return audio_device_manager_impl.AudioDeviceManagerImpl.create(this);
  }

  @override
  MediaEngine getMediaEngine() {
    return _objectPool.putIfAbsent<media_engine_impl.MediaEngineImpl>(
        const TypedScopedKey(MediaEngineImpl),
        () => media_engine_impl.MediaEngineImpl.create(irisMethodChannel));
  }

  @override
  LocalSpatialAudioEngine getLocalSpatialAudioEngine() {
    return _objectPool
        .putIfAbsent<agora_spatial_audio_impl.LocalSpatialAudioEngineImpl>(
            const TypedScopedKey(LocalSpatialAudioEngineImpl),
            () => agora_spatial_audio_impl.LocalSpatialAudioEngineImpl.create(
                irisMethodChannel));
  }

  @override
  MusicContentCenter getMusicContentCenter() {
    return mcci.MusicContentCenterImpl.create(this);
  }

  @override
  H265Transcoder getH265Transcoder() {
    return H265TranscoderImplOverride(irisMethodChannel);
  }

  @override
  Future<SDKBuildInfo> getVersion() async {
    const apiType = 'RtcEngine_getVersion_915cb25';
    final param = createParams({});
    final callApiResult = await irisMethodChannel
        .invokeMethod(IrisMethodCall(apiType, jsonEncode(param)));
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
    const apiType = 'RtcEngine_joinChannel_cdbb747';
    final param = createParams({
      'token': token,
      'channelId': channelId,
      'uid': uid,
      'options': options.toJson()
    });
    final callApiResult = await irisMethodChannel
        .invokeMethod(IrisMethodCall(apiType, jsonEncode(param)));
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
    final apiType = options == null
        ? 'RtcEngine_leaveChannel'
        : 'RtcEngine_leaveChannel_2c0e3aa';
    final param = createParams({'options': options?.toJson()});
    final callApiResult = await irisMethodChannel
        .invokeMethod(IrisMethodCall(apiType, jsonEncode(param)));
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
        ? 'RtcEngine_setClientRole_3426fa6'
        : 'RtcEngine_setClientRole_b46cc48';
    final param =
        createParams({'role': role.value(), 'options': options?.toJson()});
    final callApiResult = await irisMethodChannel
        .invokeMethod(IrisMethodCall(apiType, jsonEncode(param)));
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
  Future<void> startEchoTest(EchoTestConfiguration config) async {
    const apiType = 'RtcEngine_startEchoTest_16140d7';
    final param = createParams({'config': config.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(config.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
  }

  @override
  Future<void> startPreview(
      {VideoSourceType sourceType =
          VideoSourceType.videoSourceCameraPrimary}) async {
    if (_instance == null) return;
    const apiType = 'RtcEngine_startPreview_4fd718e';
    final param = createParams({'sourceType': sourceType.value()});
    final callApiResult = await irisMethodChannel
        .invokeMethod(IrisMethodCall(apiType, jsonEncode(param)));
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
  Future<void> startPreviewWithoutSourceType() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_startPreview';
    final param = createParams({});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
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
    const apiType = 'RtcEngine_stopPreview_4fd718e';
    final param = createParams({'sourceType': sourceType.value()});
    final callApiResult = await irisMethodChannel
        .invokeMethod(IrisMethodCall(apiType, jsonEncode(param)));
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
    const apiType = 'RtcEngine_startAudioRecording_e32bb3b';
    final param = createParams({'config': config.toJson()});
    final callApiResult = await irisMethodChannel
        .invokeMethod(IrisMethodCall(apiType, jsonEncode(param)));
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
    const apiType = 'RtcEngine_startAudioMixing_1ee1b1e';
    final param = createParams({
      'filePath': filePath,
      'loopback': loopback,
      'cycle': cycle,
      'startPos': startPos
    });
    final callApiResult = await irisMethodChannel
        .invokeMethod(IrisMethodCall(apiType, jsonEncode(param)));
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
        ? 'RtcEngine_enableDualStreamMode_5039d15'
        : 'RtcEngine_enableDualStreamMode_9822d8a';
    final param = createParams({
      'enabled': enabled,
      'sourceType': sourceType.value(),
      'streamConfig': streamConfig?.toJson()
    });
    final callApiResult = await irisMethodChannel
        .invokeMethod(IrisMethodCall(apiType, jsonEncode(param)));
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
    const apiType = 'RtcEngine_createDataStream_5862815';
    final param = createParams({'config': config.toJson()});
    final callApiResult = await irisMethodChannel
        .invokeMethod(IrisMethodCall(apiType, jsonEncode(param)));
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
    const apiType = 'RtcEngine_addVideoWatermark_7480410';
    final param = createParams(
        {'watermarkUrl': watermarkUrl, 'options': options.toJson()});
    final callApiResult = await irisMethodChannel
        .invokeMethod(IrisMethodCall(apiType, jsonEncode(param)));
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
        ? 'RtcEngine_joinChannelWithUserAccount_0e4f59e'
        : 'RtcEngine_joinChannelWithUserAccount_4685af9';
    final param = createParams({
      'token': token,
      'channelId': channelId,
      'userAccount': userAccount,
      'options': options?.toJson()
    });
    final callApiResult = await irisMethodChannel
        .invokeMethod(IrisMethodCall(apiType, jsonEncode(param)));
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
    final eventHandlerWrapper = AudioEncodedFrameObserverWrapper(observer);
    final param = createParams({'config': config.toJson()});

    await irisMethodChannel.registerEventHandler(
        ScopedEvent(
            scopedKey: _rtcEngineImplScopedKey,
            registerName: 'RtcEngine_registerAudioEncodedFrameObserver_ed4a177',
            unregisterName: 'RtcEngine_unregisterAudioEncodedFrameObserver',
            handler: eventHandlerWrapper),
        jsonEncode(param));
  }

  @override
  void unregisterAudioEncodedFrameObserver(
      AudioEncodedFrameObserver observer) async {
    final eventHandlerWrapper = AudioEncodedFrameObserverWrapper(observer);
    final param = createParams({});

    await irisMethodChannel.unregisterEventHandler(
        ScopedEvent(
            scopedKey: _rtcEngineImplScopedKey,
            registerName: 'RtcEngine_registerAudioEncodedFrameObserver_ed4a177',
            unregisterName: 'RtcEngine_unregisterAudioEncodedFrameObserver',
            handler: eventHandlerWrapper),
        jsonEncode(param));
  }

  @override
  void registerAudioSpectrumObserver(AudioSpectrumObserver observer) async {
    final eventHandlerWrapper = AudioSpectrumObserverWrapper(observer);
    final param = createParams({});

    await irisMethodChannel.registerEventHandler(
        ScopedEvent(
            scopedKey: _rtcEngineImplScopedKey,
            registerName: 'RtcEngine_registerAudioSpectrumObserver_0406ea7',
            unregisterName: 'RtcEngine_unregisterAudioSpectrumObserver_0406ea7',
            handler: eventHandlerWrapper),
        jsonEncode(param));
  }

  @override
  void unregisterAudioSpectrumObserver(AudioSpectrumObserver observer) async {
    final eventHandlerWrapper = AudioSpectrumObserverWrapper(observer);
    final param = createParams({});

    await irisMethodChannel.unregisterEventHandler(
        ScopedEvent(
            scopedKey: _rtcEngineImplScopedKey,
            registerName: 'RtcEngine_registerAudioSpectrumObserver_0406ea7',
            unregisterName: 'RtcEngine_unregisterAudioSpectrumObserver_0406ea7',
            handler: eventHandlerWrapper),
        jsonEncode(param));
  }

  @override
  Future<int> getNativeHandle() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_getNativeHandle';

    final param = createParams({});
    final callApiResult = await irisMethodChannel
        .invokeMethod(IrisMethodCall(apiType, jsonEncode(param)));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }

    // In 64-bits system, the native handle ptr value (unsigned long 64) can be 2^64 - 1,
    // which may greater than the dart int max value (2^63 - 1), so we can not decode
    // the json with big int native handle ptr value and parse it directly.
    //
    // After dart sdk 2.0 support parse hexadecimal in unsigned int64 range.
    // https://github.com/dart-lang/language/blob/ee1135e0c22391cee17bf3ee262d6a04582d25de/archive/newsletter/20170929.md#semantics
    //
    // So we retrive the native handle ptr value from the json string directly, and
    // parse an int from hexadecimal here.
    final rawJsonStr = callApiResult.rawData;
    // TODO(littlegnal): Replace retrive nativeHandleIntPtr logic after EP-253 landed.
    final rawJsonStrSplit = rawJsonStr.split(',');
    String resultStr = '';
    for (final s in rawJsonStrSplit) {
      if (s.contains('result')) {
        resultStr = s;
      }
    }
    final nativeHandleIntPtr =
        resultStr.substring(resultStr.indexOf(':') + 1, resultStr.length - 1);

    int nativeHandleBIHexInt = _string2IntPtr(nativeHandleIntPtr);

    return nativeHandleBIHexInt;
  }

  @override
  Future<MediaRecorder?> createMediaRecorder(RecorderStreamInfo info) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_createMediaRecorder_f779617';
    final param = createParams({'info': info.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(info.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return media_recorder_impl.MediaRecorderImpl.fromNativeHandle(
        irisMethodChannel, result);
  }

  @override
  Future<void> destroyMediaRecorder(MediaRecorder mediaRecorder) async {
    final impl = mediaRecorder as media_recorder_impl.MediaRecorderImpl;

    await impl.dispose();

    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_destroyMediaRecorder_95cdef5';
    final param = createParams({'nativeHandle': impl.strNativeHandle});
    await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
  }

  @override
  Future<void> startScreenCaptureBySourceType(
      {required VideoSourceType sourceType,
      required ScreenCaptureConfiguration config}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_startScreenCapture_9ebb320';
    final param = createParams(
        {'sourceType': sourceType.value(), 'config': config.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(config.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> stopScreenCaptureBySourceType(VideoSourceType sourceType) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_stopScreenCapture_4fd718e';
    final param = createParams({'sourceType': sourceType.value()});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  // @override
  // Future<void> preloadChannelWithUserAccount(
  //     {required String token,
  //     required String channelId,
  //     required String userAccount}) async {
  //   final apiType =
  //       '${isOverrideClassName ? className : 'RtcEngine'}_preloadChannel2';
  //   final param = createParams(
  //       {'token': token, 'channelId': channelId, 'userAccount': userAccount});
  //   final callApiResult = await irisMethodChannel.invokeMethod(
  //       IrisMethodCall(apiType, jsonEncode(param), buffers: null));
  //   if (callApiResult.irisReturnCode < 0) {
  //     throw AgoraRtcException(code: callApiResult.irisReturnCode);
  //   }
  // }

  Future<String?> getAssetAbsolutePath(String assetPath) async {
    if (kIsWeb) {
      // The assets are located in the `assets` directory.
      return 'assets/$assetPath';
    }

    final p = await engineMethodChannel.invokeMethod<String>(
        'getAssetAbsolutePath', assetPath);
    return p;
  }

  /////////// debug ////////

  /// [type] see [VideoSourceType], only [VideoSourceType.videoSourceCamera], [VideoSourceType.videoSourceRemote] supported
  Future<void> startDumpVideo(int type, String dir) async {
    await setParameters(
        "{\"engine.video.enable_video_dump\":{\"mode\": 0, \"enable\": true");

    // await irisMethodChannel.invokeMethod(IrisMethodCall(
    //   'StartDumpVideo',
    //   jsonEncode({
    //     'nativeHandle': _globalVideoViewController!.irisRtcRenderingHandle,
    //     'type': type,
    //     'dir': dir,
    //   }),
    // ));
  }

  Future<void> stopDumpVideo() async {
    await setParameters(
        "{\"engine.video.enable_video_dump\":{\"mode\": 0, \"enable\": false");

    // await irisMethodChannel.invokeMethod(IrisMethodCall(
    //   'StopDumpVideo',
    //   jsonEncode(
    //       {'nativeHandle': _globalVideoViewController!.irisRtcRenderingHandle}),
    // ));
  }

  //////////////////////////
}

class VideoDeviceManagerImpl extends rtc_engine_binding.VideoDeviceManagerImpl
    with ScopedDisposableObjectMixin
    implements VideoDeviceManager {
  VideoDeviceManagerImpl._(RtcEngine rtcEngine)
      : super(rtcEngine.irisMethodChannel);

  factory VideoDeviceManagerImpl.create(RtcEngine rtcEngine) {
    return rtcEngine.objectPool.putIfAbsent(
        _videoDeviceManagerKey, () => VideoDeviceManagerImpl._(rtcEngine));
  }

  static const _videoDeviceManagerKey = TypedScopedKey(VideoDeviceManagerImpl);

  @override
  Future<List<VideoDeviceInfo>> enumerateVideoDevices() async {
    const apiType = 'VideoDeviceManager_enumerateVideoDevices';
    final param = createParams({});

    final callApiResult = await irisMethodChannel
        .invokeMethod(IrisMethodCall(apiType, jsonEncode(param)));
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
    markDisposed();
  }

  @override
  Future<void> startDeviceTest(int hwnd) {
    throw AgoraRtcException(code: -ErrorCodeType.errNotSupported.value());
  }

  @override
  Future<void> dispose() {
    return release();
  }
}
