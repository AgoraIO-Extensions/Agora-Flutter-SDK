@JS()
library agora_rtc_engine;

import 'dart:async';
import 'dart:convert';

// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:js';
import 'dart:ui' as ui;

import 'package:agora_rtc_engine/src/enum_converter.dart';
import 'package:agora_rtc_engine/src/enums.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:js/js.dart';
import 'package:js/js_util.dart';

@JS()
@anonymous
class _AgoraRTCError {
  external String get code;

  external String get message;

  external Object? get data;

  external String get _name;

  external _AgoraRTCError(String code, [String? message, Object? data]);

  @override
  external String toString();

  external _AgoraRTCError print();
}

@JS()
class _AgoraRTCStats {
  external int get Duration;

  external int get RecvBitrate;

  external int get RecvBytes;

  external int get SendBitrate;

  external int get SendBytes;

  external int get UserCount;

  external int get RTT;

  external int get OutgoingAvailableBandwidth;
}

@JS()
@anonymous
class _AudioEncoderConfiguration {
  external factory _AudioEncoderConfiguration({
    int? sampleRate,
    int? sampleSize,
    int? stereo,
    int? bitrate,
  });
}

@JS()
@anonymous
class _AudioSourceOptions {
  external factory _AudioSourceOptions({
    int? cycle,
    bool? loop,
    int? startPlayTime,
  });
}

@JS()
@anonymous
class _BeautyEffectOptions {
  external factory _BeautyEffectOptions({
    double? smoothnessLevel,
    double? lighteningLevel,
    double? rednessLevel,
    int? lighteningContrastLevel,
  });
}

@JS()
@anonymous
class _BufferSourceAudioTrackInitConfig {
  external factory _BufferSourceAudioTrackInitConfig({
    String source,
    bool? cacheOnlineFile,
    _AudioEncoderConfiguration? encoderConfig,
  });
}

@JS()
@anonymous
class _CameraVideoTrackInitConfig {
  external factory _CameraVideoTrackInitConfig({
    _VideoEncoderConfiguration? encoderConfig,
    String? facingMode,
    String? cameraId,
    String? optimizationMode,
    _SVCConfiguration? scalabiltyMode,
  });
}

@JS()
@anonymous
class _ChannelMediaRelayInfo {
  external factory _ChannelMediaRelayInfo({
    String channelName,
    String? token,
    int uid,
  });
}

@JS()
@anonymous
class _ClientConfig {
  external factory _ClientConfig({
    String codec,
    String mode,
    String? role,
    _ClientRoleOptions? clientRoleOptions,
    String? proxyServer,
    _TurnServerConfig? turnServer,
    _RetryConfiguration? httpRetryConfig,
    _RetryConfiguration? websocketRetryConfig,
  });
}

@JS()
@anonymous
class _ClientRoleOptions {
  external factory _ClientRoleOptions({
    int level,
  });
}

@JS()
@anonymous
class _ConstrainLong {
  external factory _ConstrainLong({
    int? min,
    int? max,
    int? ideal,
    int? exact,
  });
}

@JS()
@anonymous
class _CustomAudioTrackInitConfig {
  external factory _CustomAudioTrackInitConfig({
    MediaStreamTrack mediaStreamTrack,
    _AudioEncoderConfiguration? encoderConfig,
  });
}

@JS()
@anonymous
class _CustomVideoTrackInitConfig {
  external factory _CustomVideoTrackInitConfig({
    MediaStreamTrack mediaStreamTrack,
    int? bitrateMin,
    int? bitrateMax,
    String? optimizationMode,
    _SVCConfiguration? scalabiltyMode,
  });
}

@JS()
class _DeviceInfo {
  external int get updateAt;

  external int get initAt;

  external String get state;

  external MediaDeviceInfo get device;
}

@JS()
@anonymous
class _EventCustomReportParams {
  external factory _EventCustomReportParams({
    String reportId,
    String category,
    String event,
    String label,
    int value,
  });
}

@JS()
class _EventEmitter {
  external String get _events;

  external List<Function> getListeners(String event);

  external void on(String event, Function listener);

  external void once(String event, Function listener);

  external void off(String event, Function listener);

  external void removeAllListeners([String? event]);

  external int get _indexOfListener;
}

@JS('AgoraRTC')
class _AgoraRTC {
  external static String get VERSION;

  external static Future<Map<String, List<String>>> getSupportedCodec();

  external static bool checkSystemRequirements();

  external static _AgoraRTCClient createClient(_ClientConfig config);

  external static _LocalAudioTrack createCustomAudioTrack(
      _CustomAudioTrackInitConfig config);

  external static Future<_MicrophoneAudioTrack> createMicrophoneAudioTrack(
      [_MicrophoneAudioTrackInitConfig? config]);

  external static Future<_BufferSourceAudioTrack> createBufferSourceAudioTrack(
      _BufferSourceAudioTrackInitConfig config);

  external static _LocalVideoTrack createCustomVideoTrack(
      _CustomVideoTrackInitConfig config);

  external static Future<_CameraVideoTrack> createCameraVideoTrack(
      [_CameraVideoTrackInitConfig? config]);

  external static Future<List<_LocalTrack>> createMicrophoneAndCameraTracks(
      [_MicrophoneAudioTrackInitConfig? audioConfig,
      _CameraVideoTrackInitConfig? videoConfig]);

  external static Future<dynamic> createScreenVideoTrack(
      _ScreenVideoTrackInitConfig config,
      [String? withAudio = 'disable']);

  external static Future<List<MediaDeviceInfo>> getDevices(
      [bool? skipPermissionCheck]);

  external static Future<List<MediaDeviceInfo>> getMicrophones(
      [bool? skipPermissionCheck]);

  external static Future<List<MediaDeviceInfo>> getCameras(
      [bool? skipPermissionCheck]);

  external static Future<List<MediaDeviceInfo>> getPlaybackDevices(
      [bool? skipPermissionCheck]);

  external static void setLogLevel(int level);

  external static void enableLogUpload();

  external static void disableLogUpload();

  external static _ChannelMediaRelayConfiguration
      createChannelMediaRelayConfiguration();

  external static Future<bool> checkVideoTrackIsActive(Object track,
      [int? timeout]);

  external static Future<bool> checkAudioTrackIsActive(Object track,
      [int? timeout]);

  external static set onCameraChanged(Function _);

  external static set onMicrophoneChanged(Function _);

  external static set onPlaybackDeviceChanged(Function _);

  external static set onAudioAutoplayFailed(Function _);

  external static void setArea(List<String> area);

  external static void startProcessingLocalAEC(MediaElement element);

  external static void setParameter(String key, String value);
}

@JS()
@anonymous
class _LayerOptions {
  external factory _LayerOptions({
    int spatialLayer,
    int temporalLayer,
  });
}

@JS()
class _AgoraRTCClient extends _EventEmitter {
  external String get connectionState;

  external List<_AgoraRTCRemoteUser> get remoteUsers;

  external List<_LocalTrack> get localTracks;

  external int? get uid;

  external String? get channelName;

  external Future<int> join(String appid, String channel, String? token,
      [int? uid]);

  external Future<void> leave();

  external Future<void> publish(List<_LocalTrack> tracks);

  external Future<void> unpublish([List<_LocalTrack>? tracks]);

  external Future<_RemoteTrack> subscribe(
      _AgoraRTCRemoteUser user, String mediaType);

  external Future<void> unsubscribe(_AgoraRTCRemoteUser user,
      [String? mediaType]);

  external void setLowStreamParameter(_LowStreamParameter streamParameter);

  external Future<void> enableDualStream();

  external Future<void> disableDualStream();

  external Future<void> setClientRole(String role,
      [_ClientRoleOptions? options]);

  external void setProxyServer(String proxyServer);

  external void setTurnServer(_TurnServerConfig turnServer);

  external void startProxyServer([int? mode]);

  external void stopProxyServer();

  external Future<void> setRemoteVideoStreamType(int uid, int streamType);

  external Future<void> pickSVCLayer(int uid, _LayerOptions layerOptions);

  external Future<void> setStreamFallbackOption(int uid, int fallbackType);

  external void setEncryptionConfig(String encryptionMode, String secret);

  external Future<void> renewToken(String token);

  external void enableAudioVolumeIndicator();

  external _AgoraRTCStats getRTCStats();

  external Future<void> setLiveTranscoding(
      _LiveStreamingTranscodingConfig config);

  external Future<void> startLiveStreaming(String url,
      [bool? transcodingEnabled]);

  external Future<void> stopLiveStreaming(String url);

  external Future<void> addInjectStreamUrl(
      String url, _InjectStreamConfig config);

  external Future<void> removeInjectStreamUrl(String url);

  external Future<void> startChannelMediaRelay(
      _ChannelMediaRelayConfiguration config);

  external Future<void> updateChannelMediaRelay(
      _ChannelMediaRelayConfiguration config);

  external Future<void> stopChannelMediaRelay();

  external Future<void> sendCustomReportMessage(
      List<_EventCustomReportParams> reports);

  external _LocalAudioTrackStats getLocalAudioStats();

  external Map<String, _RemoteAudioTrackStats> getRemoteAudioStats();

  external Map<String, _NetworkQuality> getRemoteNetworkQuality();

  external _LocalVideoTrackStats getLocalVideoStats();

  external Map<String, _RemoteVideoTrackStats> getRemoteVideoStats();
}

@JS()
@anonymous
class _AgoraRTCRemoteUser {
  external factory _AgoraRTCRemoteUser({
    int uid,
    _RemoteAudioTrack? audioTrack,
    _RemoteVideoTrack? videoTrack,
    bool hasAudio,
    bool hasVideo,
  });

  external int get uid;

  external _RemoteAudioTrack? get audioTrack;

  external _RemoteVideoTrack? get videoTrack;

  external bool get hasAudio;

  external bool get hasVideo;
}

@JS()
class _BufferSourceAudioTrack extends _LocalAudioTrack {
  external set source(String _);

  external String get source;

  external set currentState(String _);

  external String get currentState;

  external set duration(int _);

  external int get duration;

  external int getCurrentTime();

  external void startProcessAudioBuffer([_AudioSourceOptions? options]);

  external void pauseProcessAudioBuffer();

  external void seekAudioBuffer(int time);

  external void resumeProcessAudioBuffer();

  external void stopProcessAudioBuffer();
}

@JS()
class _CameraVideoTrack extends _LocalVideoTrack {
  external Future<void> setDevice(String deviceId);

  external Future<void> setEncoderConfiguration(
      _VideoEncoderConfiguration config);
}

@JS()
class _ChannelMediaRelayConfiguration {
  external void setSrcChannelInfo(_ChannelMediaRelayInfo info);

  external void addDestChannelInfo(_ChannelMediaRelayInfo info);

  external void removeDestChannelInfo(String channelName);
}

@JS()
class _LocalAudioTrack extends _LocalTrack {
  external void setVolume(int volume);

  external double getVolumeLevel();

  external void setAudioFrameCallback(Function audioFrameCallback,
      [int? frameSize]);

  external void play();

  external Future<void> setPlaybackDevice(String deviceId);

  external _LocalAudioTrackStats getStats();
}

@JS()
class _LocalTrack extends _Track {
  external Future<void> setEnabled(bool enabled);

  external String getTrackLabel();

  external void close();
}

@JS()
class _LocalVideoTrack extends _LocalTrack {
  external void play(Object element, [_VideoPlayerConfig? config]);

  external _LocalVideoTrackStats getStats();

  external Future<void> setBeautyEffect(bool enabled,
      [_BeautyEffectOptions? options]);

  external ImageData getCurrentFrameData();

  external Future<void> setOptimizationMode(String mode);
}

@JS()
class _MicrophoneAudioTrack extends _LocalAudioTrack {
  external Future<void> setDevice(String deviceId);
}

@JS()
@anonymous
class _InjectStreamConfig {
  external factory _InjectStreamConfig({
    int? audioVolume,
    int? audioBitrate,
    int? audioChannels,
    int? audioSampleRate,
    int? height,
    int? width,
    int? videoBitrate,
    int? videoFramerate,
    int? videoGop,
  });
}

@JS()
class _RemoteAudioTrack extends _RemoteTrack {
  external _RemoteAudioTrackStats getStats();

  external void play();

  external Future<void> setPlaybackDevice(String deviceId);

  external void setAudioFrameCallback(Function audioFrameCallback,
      [int? frameSize]);

  external void setVolume(int volume);

  external double getVolumeLevel();
}

@JS()
class _RemoteTrack extends _Track {
  external int getUserId();
}

@JS()
class _RemoteVideoTrack extends _RemoteTrack {
  external _RemoteVideoTrackStats getStats();

  external void play(HtmlElement element, [_VideoPlayerConfig? config]);

  external ImageData getCurrentFrameData();
}

@JS()
class _Track extends _EventEmitter {
  external String get trackMediaType;

  external bool get isPlaying;

  external String getTrackId();

  external MediaStreamTrack getMediaStreamTrack();

  external void stop();
}

@JS()
@anonymous
class _LiveStreamingTranscodingConfig {
  external factory _LiveStreamingTranscodingConfig({
    int? audioBitrate,
    int? audioChannels,
    int? audioSampleRate,
    int? backgroundColor,
    int? height,
    int? width,
    bool? lowLatency,
    int? videoBitrate,
    int? videoCodecProfile,
    int? videoFrameRate,
    int? videoGop,
    List<_LiveStreamingTranscodingImage>? images,
    _LiveStreamingTranscodingImage? watermark,
    List<_LiveStreamingTranscodingImage>? backgroundImage,
    List<_LiveStreamingTranscodingUser>? transcodingUsers,
    String? userConfigExtraInfo,
  });
}

@JS()
@anonymous
class _LiveStreamingTranscodingImage {
  external factory _LiveStreamingTranscodingImage({
    String url,
    int? x,
    int? y,
    int? width,
    int? height,
    double? alpha,
  });

  external String get url;

  external int? get x;

  external int? get y;

  external int? get width;

  external int? get height;

  external double? get alpha;
}

@JS()
@anonymous
class _LiveStreamingTranscodingUser {
  external factory _LiveStreamingTranscodingUser({
    double? alpha,
    int? height,
    int uid,
    int? width,
    int? x,
    int? y,
    int? zOrder,
    int? audioChannel,
  });

  external double? get alpha;

  external int? get height;

  external int get uid;

  external int? get width;

  external int? get x;

  external int? get y;

  external int? get zOrder;

  external int? get audioChannel;
}

@JS()
class _LocalAudioTrackStats {
  external String? get codecType;

  external int get sendVolumeLevel;

  external int get sendBitrate;

  external int get sendBytes;

  external int get sendPackets;

  external int get sendPacketsLost;
}

@JS()
class _LocalVideoTrackStats {
  external String? get codecType;

  external int get sendBytes;

  external int? get sendFrameRate;

  external int? get captureFrameRate;

  external int get sendPackets;

  external int get sendPacketsLost;

  external int get sendResolutionHeight;

  external int get sendResolutionWidth;

  external int get captureResolutionHeight;

  external int get captureResolutionWidth;

  external int? get encodeDelay;

  external int get sendBitrate;

  external int get targetSendBitrate;

  external int get totalDuration;

  external int get totalFreezeTime;
}

@JS()
@anonymous
class _LowStreamParameter {
  external factory _LowStreamParameter({
    int width,
    int height,
    int? framerate,
    int? bitrate,
  });
}

@JS()
@anonymous
class _MicrophoneAudioTrackInitConfig {
  external factory _MicrophoneAudioTrackInitConfig({
    _AudioEncoderConfiguration? encoderConfig,
    bool? AEC,
    bool? AGC,
    bool? ANS,
    bool? DTX,
    String? microphoneId,
  });
}

@JS()
class _NetworkQuality {
  external int get uplinkNetworkQuality;

  external int get downlinkNetworkQuality;
}

@JS()
class _RemoteAudioTrackStats {
  external int get transportDelay;

  external String? get codecType;

  external int get end2EndDelay;

  external int get receiveBitrate;

  external int get receiveLevel;

  external int get receiveBytes;

  external int get receiveDelay;

  external int get receivePackets;

  external int get receivePacketsLost;

  external int get packetLossRate;

  external int get totalDuration;

  external int get totalFreezeTime;

  external int get freezeRate;

  external int get publishDuration;
}

@JS()
class _RemoteVideoTrackStats {
  external int get transportDelay;

  external String? get codecType;

  external int get end2EndDelay;

  external int get receiveBitrate;

  external int get receiveDelay;

  external int get receiveBytes;

  external int? get decodeFrameRate;

  external int? get receiveFrameRate;

  external int? get renderFrameRate;

  external int get receivePackets;

  external int get receivePacketsLost;

  external int get packetLossRate;

  external int get receiveResolutionHeight;

  external int get receiveResolutionWidth;

  external int get totalDuration;

  external int get totalFreezeTime;

  external int get freezeRate;

  external int get publishDuration;
}

@JS()
@anonymous
class _RetryConfiguration {
  external factory _RetryConfiguration({
    int timeout,
    int timeoutFactor,
    int maxRetryCount,
    int maxRetryTimeout,
  });
}

@JS()
@anonymous
class _ScreenVideoTrackInitConfig {
  external factory _ScreenVideoTrackInitConfig({
    _VideoEncoderConfiguration? encoderConfig,
    String? electronScreenSourceId,
    String? extensionId,
    String? screenSourceType,
    String? optimizationMode,
    _SVCConfiguration? scalabiltyMode,
  });
}

@JS()
@anonymous
class _SVCConfiguration {
  external factory _SVCConfiguration({
    int numSpatialLayers,
    int numTemporalLayers,
  });
}

@JS()
@anonymous
class _TurnServerConfig {
  external factory _TurnServerConfig({
    String turnServerURL,
    String password,
    int? udpport,
    String username,
    bool? forceturn,
    int? tcpport,
    bool? security,
  });
}

@JS()
@anonymous
class _VideoEncoderConfiguration {
  external factory _VideoEncoderConfiguration({
    int? width,
    int? height,
    int? frameRate,
    int? bitrateMin,
    int? bitrateMax,
  });
}

@JS()
@anonymous
class _VideoPlayerConfig {
  external factory _VideoPlayerConfig({
    bool? mirror,
    String? fit,
  });
}

@JS()
class _Event {
  external String get methodName;

  external List<dynamic> get data;
}

@JS('IrisRtcEngine')
class _IrisRtcEngine {
  external Future<dynamic> callApi(int apiType, String params, [Object? extra]);

  external void setEventHandler(Function params);
}

/// A web implementation of the AgoraRtcEngine plugin.
class AgoraRtcEngineWeb {
  // ignore: public_member_api_docs
  static void registerWith(Registrar registrar) {
    final methodChannel = MethodChannel(
      'agora_rtc_engine',
      const StandardMethodCodec(),
      registrar,
    );
    final eventChannel = PluginEventChannel(
        'agora_rtc_engine/events', const StandardMethodCodec(), registrar);

    final pluginInstance = AgoraRtcEngineWeb();
    methodChannel.setMethodCallHandler(pluginInstance.handleMethodCall);
    eventChannel.setController(pluginInstance._controller);

    ui.platformViewRegistry.registerViewFactory('AgoraSurfaceView',
        (int viewId) {
      var element = DivElement();
      MethodChannel('agora_rtc_engine/surface_view_$viewId',
              const StandardMethodCodec(), registrar)
          .setMethodCallHandler(
              (call) => pluginInstance.handleViewMethodCall(call, element));
      return element;
    });
  }

  final _controller = StreamController();
  String? _appId;
  final bool _enableAudio = true;
  final bool _enableVideo = false;
  _AgoraRTCClient? _client;
  late _MicrophoneAudioTrack _audioTrack;
  late _CameraVideoTrack _videoTrack;
  final _IrisRtcEngine _engine = _IrisRtcEngine();

  /// Handles method calls over the MethodChannel of this plugin.
  /// Note: Check the "federated" architecture for a new way of doing this:
  /// https://flutter.dev/go/federated-plugins
  Future<dynamic> handleMethodCall(MethodCall call) async {
    _engine.setEventHandler(allowInterop((String event, String data) {
      _controller.add({'methodName': event, 'data': data});
    }));
    var args = <String, dynamic>{};
    if (call.arguments != null) {
      args = Map<String, dynamic>.from(call.arguments);
    }
    if (call.method == 'callApi') {
      return promiseToFuture(_engine.callApi(args['apiType'], args['params']));
    }

    switch (call.method) {
      case 'getSdkVersion':
        return _getSdkVersion();
      case 'getErrorDescription':
        break;
      case 'create':
        return _create(args);
      case 'destroy':
        return _destroy();
      case 'setChannelProfile':
        return _setChannelProfile(args);
      case 'setClientRole':
        return _setClientRole(args);
      case 'joinChannel':
        return _joinChannel(args);
      case 'leaveChannel':
        return _leaveChannel(args);
      case 'renewToken':
        return _renewToken(args);
      case 'getConnectionState':
        return _getConnectionState(args);
      case 'setLogFilter':
        return _setLogFilter(args);
      case 'enableAudio':
        break;
      case 'enableVideo':
        break;
      case 'startPreview':
        break;
      default:
        throw PlatformException(code: ErrorCode.NotSupported.toString());
    }
  }

  // ignore: public_member_api_docs
  Future<dynamic> handleViewMethodCall(MethodCall call, Element element) async {
    var args = <String, dynamic>{};
    if (call.arguments != null) {
      args = Map<String, dynamic>.from(call.arguments);
    }
    switch (call.method) {
      case 'setData':
        var data = Map<String, dynamic>.from(args['data']);
        if (data['uid'] == 0) {
          final kEngineSetupLocalVideo = 20;
          return promiseToFuture(_engine.callApi(
              kEngineSetupLocalVideo,
              jsonEncode({
                'canvas': {
                  'uid': 0,
                }
              }),
              element));
          // _videoTrack.play(element);
        } else {
          final kEngineSetupLocalVideo = 21;
          return promiseToFuture(_engine.callApi(
              kEngineSetupLocalVideo,
              jsonEncode({
                'canvas': {
                  'uid': data['uid'],
                }
              }),
              element));
        }
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details:
              'agora_rtc_engine for web doesn\'t implement \'${call.method}\'',
        );
    }
  }

  String _getSdkVersion() {
    return _AgoraRTC.VERSION;
  }

  Future<void> _create(Map<String, dynamic> arguments) async {
    _appId = arguments['config']['appId'];
    _AgoraRTC.setParameter(
        'REPORT_APP_SCENARIO', arguments['appType'].toString());
    _audioTrack = await promiseToFuture(_AgoraRTC.createMicrophoneAudioTrack(
        _MicrophoneAudioTrackInitConfig()));
    _videoTrack = await promiseToFuture(
        _AgoraRTC.createCameraVideoTrack(_CameraVideoTrackInitConfig()));
  }

  void _destroy() {
    _client = null;
  }

  Future<void> _setChannelProfile(Map<String, dynamic> arguments) async {
    String mode;
    switch (ChannelProfileConverter.fromValue(arguments['profile']).e) {
      case ChannelProfile.Communication:
        mode = 'rtc';
        break;
      case ChannelProfile.LiveBroadcasting:
        mode = 'live';
        break;
      case ChannelProfile.Game:
        mode = '';
        break;
    }
    _client = _AgoraRTC.createClient(_ClientConfig(codec: 'h264', mode: mode));
    _client?.on('connection-state-change',
        allowInterop((String curState, String revState, String? reason) {
      final state = _ConnectionStateType.fromWeb(curState);
      final _reason = _ConnectionChangedReason.fromWeb(reason, state);
      _controller.add({
        'methodName': 'ConnectionStateChanged',
        'data': [
          ConnectionStateTypeConverter(state).value(),
          ConnectionChangedReasonConverter(_reason).value(),
        ],
      });
    }));
  }

  Future<void> _setClientRole(Map<String, dynamic> arguments) async {
    String role;
    switch (ClientRoleConverter.fromValue(arguments['role']).e) {
      case ClientRole.Broadcaster:
        role = 'host';
        break;
      case ClientRole.Audience:
        role = 'audience';
        break;
    }
    await _client?.setClientRole(role);
  }

  Future<void> _joinChannel(Map<String, dynamic> arguments) async {
    if (_appId != null && _client != null) {
      final channelName = arguments['channelName'];
      final token = arguments['token'];
      final optionalUid = arguments['optionalUid'];
      print('_joinChannel $_appId $channelName $token $optionalUid');
      final promise = _client!.join(_appId!, channelName, token, optionalUid);
      await promiseToFuture(promise).then((uid) {
        _controller.add({
          'methodName': 'JoinChannelSuccess',
          'data': [channelName, uid, 0],
        });
        var tracks = <_LocalTrack>[];
        if (_enableAudio) tracks.add(_audioTrack);
        if (_enableVideo) tracks.add(_videoTrack);
        _client!.publish(tracks);
      });
    }
  }

  Future<void> _leaveChannel(Map<String, dynamic> arguments) async {
    if (_client != null) {
      await promiseToFuture(_client!.leave());
    }
  }

  Future<void> _renewToken(Map<String, dynamic> arguments) async {
    if (_client != null) {
      final token = arguments['token'];
      await promiseToFuture(_client!.renewToken(token));
    }
  }

  Future<int> _getConnectionState(Map<String, dynamic> arguments) async {
    var state = ConnectionStateType.Disconnected;
    if (_client != null) {
      state = _ConnectionStateType.fromWeb(_client!.connectionState);
    }
    return ConnectionStateTypeConverter(state).value();
  }

  Future<void> _setLogFilter(Map<String, dynamic> arguments) async {
    if (_client != null) {
      final filter = arguments['filter'];
      _AgoraRTC.setLogLevel(LogFilterConverter(filter).e.toWeb());
    }
  }
}

extension _LogFilter on LogFilter {
  static LogFilter fromWeb(int filter) {
    switch (filter) {
      case 0:
        return LogFilter.Debug;
      case 1:
        return LogFilter.Info;
      case 2:
        return LogFilter.Warning;
      case 3:
        return LogFilter.Error;
      case 4:
        return LogFilter.Off;
      default:
        return LogFilter.Info;
    }
  }

  int toWeb() {
    switch (this) {
      case LogFilter.Off:
        return 4;
      case LogFilter.Debug:
        return 0;
      case LogFilter.Info:
        return 1;
      case LogFilter.Warning:
        return 2;
      case LogFilter.Error:
      case LogFilter.Critical:
        return 3;
    }
  }
}

extension _ConnectionStateType on ConnectionStateType {
  static ConnectionStateType fromWeb(String state) {
    switch (state) {
      case 'DISCONNECTED':
        return ConnectionStateType.Disconnected;
      case 'CONNECTING':
        return ConnectionStateType.Connecting;
      case 'RECONNECTING':
        return ConnectionStateType.Reconnecting;
      case 'CONNECTED':
        return ConnectionStateType.Connected;
      case 'DISCONNECTING':
        return ConnectionStateType.Disconnected;
      default:
        return ConnectionStateType.Connecting;
    }
  }
}

extension _ConnectionChangedReason on ConnectionChangedReason {
  static ConnectionChangedReason fromWeb(String? reason,
      [ConnectionStateType? state]) {
    switch (reason) {
      case 'LEAVE':
        return ConnectionChangedReason.LeaveChannel;
      case 'NETWORK_ERROR':
      case 'SERVER_ERROR':
        return ConnectionChangedReason.Interrupted;
      case 'UID_BANNED':
        return ConnectionChangedReason.RejectedByServer;
      case 'IP_BANNED':
        return ConnectionChangedReason.BannedByServer;
      case 'CHANNEL_BANNED':
        return ConnectionChangedReason.BannedByServer;
      default:
        if (state == ConnectionStateType.Connected) {
          return ConnectionChangedReason.JoinSuccess;
        } else {
          return ConnectionChangedReason.JoinFailed;
        }
    }
  }
}
