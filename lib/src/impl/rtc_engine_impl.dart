import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:agora_rtc_engine/src/impl/api_types.dart';
import 'package:agora_rtc_engine/src/classes.dart';
import 'package:agora_rtc_engine/src/impl/media_recorder_impl.dart';
import 'enum_converter.dart';
import 'package:agora_rtc_engine/src/enums.dart';

import 'package:agora_rtc_engine/src/rtc_channel.dart';
import 'package:agora_rtc_engine/src/rtc_device_manager.dart';
import 'package:agora_rtc_engine/src/rtc_engine.dart';
import 'package:agora_rtc_engine/src/rtc_engine_event_handler.dart';
import 'rtc_engine_event_handler_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'media_recorder_observer_impl.dart';

/// Implementation of [RtcEngine]
class RtcEngineImpl with MediaRecorderImplMixin implements RtcEngine {
  static const MethodChannel _methodChannel = MethodChannel('agora_rtc_engine');
  static const EventChannel _eventChannel =
      EventChannel('agora_rtc_engine/events');
  static StreamSubscription? _subscription;

  /// Exposing methodChannel to other files
  static MethodChannel get methodChannel => _methodChannel;

  static RtcEngineImpl? _instance;

  /// Get the singleton of [RtcEngine].
  static RtcEngineImpl? get instance => _instance;

  final bool _subProcess;
  final String? _appGroup;
  RtcEngineContext? _rtcEngineContext;
  RtcEngineImpl? _screenShareHelper;

  ///
  /// Initializes RtcEngine.
  /// All called methods provided by the RtcEngine class are executed asynchronously. We recommend calling these methods in the same thread.
  ///
  ///
  /// Before calling other APIs, you must call create and createWithContext to create and initialize an RtcEngine object.
  /// The SDK supports creating only one RtcEngine instance for an app.
  ///
  /// Param [config] Configurations for the RtcEngine instance. For details, see RtcEngineContext.
  ///
  ///
  static Future<RtcEngine> createWithContext(RtcEngineContext config) async {
    if (_instance != null) return _instance!;
    _instance = RtcEngineImpl._(false);
    await _instance!.initialize(config);
    return _instance!;
  }

  @override
  Future<RtcEngine> getScreenShareHelper({String? appGroup}) async {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      throw PlatformException(code: ErrorCode.NotSupported.toString());
    }
    if (_subProcess) {
      throw PlatformException(code: ErrorCode.TooOften.toString());
    }
    _screenShareHelper ??= () {
      var engine = RtcEngineImpl._(true, appGroup: appGroup);
      engine.initialize(_rtcEngineContext!);
      return engine;
    }();
    return _screenShareHelper!;
  }

  final RtcDeviceManager _deviceManager = RtcDeviceManager();

  ///
  /// Gets the RtcDeviceManager class.
  ///
  ///
  /// **return** The RtcDeviceManager class.
  ///
  @override
  RtcDeviceManager get deviceManager {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      throw PlatformException(code: ErrorCode.NotSupported.toString());
    }
    return _deviceManager;
  }

  RtcEngineEventHandler? _handler;

  RtcEngineImpl._(this._subProcess, {String? appGroup}) : _appGroup = appGroup {
    _subscription ??= _eventChannel.receiveBroadcastStream().listen((event) {
      final eventMap = Map<dynamic, dynamic>.from(event);
      final methodName = eventMap['methodName'] as String;
      final data = eventMap['data'];
      final buffer = eventMap['buffer'];
      final subProcess = (eventMap['subProcess'] as bool?) ?? false;
      if (subProcess) {
        _instance?._screenShareHelper?._handler
            ?.process(methodName, data, buffer);
      } else {
        _instance?._handler?.process(methodName, data, buffer);
        _instance?.getMediaRecorderObserver()?.process(methodName, data);
      }
    });
  }

  Future<T?> _invokeMethod<T>(String method,
      [Map<String, dynamic>? arguments]) {
    if (kIsWeb || (Platform.isWindows || Platform.isMacOS)) {
      arguments?['subProcess'] = _subProcess;
    }
    return _methodChannel.invokeMethod(method, arguments);
  }

  @override
  Future<String?> getSdkVersion() {
    return RtcEngineImpl.methodChannel.invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineGetVersion.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<String?> getErrorDescription(int error) {
    return RtcEngineImpl.methodChannel.invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineGetErrorDescription.index,
      'params': jsonEncode({
        'code': error,
      }),
    });
  }

  @override
  Future<void> initialize(RtcEngineContext context) {
    _rtcEngineContext = context;
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineInitialize.index,
      'params': jsonEncode({
        'context': context.toJson(),
        'appGroup': _appGroup,
      }),
    }).then((value) => _invokeMethod('callApi', {
          'apiType': ApiTypeEngine.kEngineSetAppType.index,
          'params': jsonEncode({
            'appType': 4,
          }),
        }));
  }

  // TODO(littlegnal): Fill test
  @override
  Future<void> destroy() async {
    _rtcEngineContext = null;

    if (_subProcess) {
      _handler = null;
      instance?._screenShareHelper = null;
    } else {
      await _screenShareHelper?.destroy();
      _screenShareHelper = null;
      await releaseRecorder();
      RtcChannel.destroyAll();
      _instance?._handler = null;
      _instance = null;
    }
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineRelease.index,
      'params': jsonEncode({
        'sync': true,
      }),
    });
  }

  @override
  void setEventHandler(RtcEngineEventHandler handler) {
    _handler = handler;
  }

  @override
  Future<void> setChannelProfile(ChannelProfile profile) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetChannelProfile.index,
      'params': jsonEncode({
        'profile': ChannelProfileConverter(profile).value(),
      }),
    });
  }

  @override
  Future<void> setClientRole(ClientRole role, [ClientRoleOptions? options]) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetClientRole.index,
      'params': jsonEncode({
        'role': ClientRoleConverter(role).value(),
        'options': options?.toJson(),
      }),
    });
  }

  @override
  Future<void> joinChannel(
      String? token, String channelName, String? optionalInfo, int optionalUid,
      [ChannelMediaOptions? options]) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineJoinChannel.index,
      'params': jsonEncode({
        'token': token?.isEmpty == true ? null : token,
        'channelId': channelName,
        'info': optionalInfo,
        'uid': optionalUid,
        'options': options?.toJson(),
      }),
    });
  }

  @override
  Future<void> switchChannel(String? token, String channelName,
      [ChannelMediaOptions? options]) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSwitchChannel.index,
      'params': jsonEncode({
        'token': token,
        'channelId': channelName,
        'options': options?.toJson(),
      }),
    });
  }

  @override
  Future<void> leaveChannel() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineLeaveChannel.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<void> renewToken(String token) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineRenewToken.index,
      'params': jsonEncode({
        'token': token,
      }),
    });
  }

  @override
  Future<void> enableWebSdkInteroperability(bool enabled) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineEnableWebSdkInteroperability.index,
      'params': jsonEncode({
        'enabled': enabled,
      }),
    });
  }

  @override
  Future<ConnectionStateType> getConnectionState() {
    if (_subProcess) {
      throw PlatformException(code: ErrorCode.NotSupported.toString());
    }
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineGetConnectionState.index,
      'params': jsonEncode({}),
    }).then((value) {
      return ConnectionStateTypeConverter.fromValue(value).e;
    });
  }

  @override
  Future<String?> getCallId() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineGetCallId.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<void> rate(String callId, int rating, {String? description}) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineRate.index,
      'params': jsonEncode({
        'callId': callId,
        'rating': rating,
        'description': description,
      }),
    });
  }

  @override
  Future<void> complain(String callId, String description) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineComplain.index,
      'params': jsonEncode({
        'callId': callId,
        'description': description,
      }),
    });
  }

  @override
  Future<void> setLogFile(String filePath) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetLogFile.index,
      'params': jsonEncode({
        'filePath': filePath,
      }),
    });
  }

  @override
  Future<void> setLogFilter(LogFilter filter) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetLogFilter.index,
      'params': jsonEncode({
        'filter': LogFilterConverter(filter).value(),
      }),
    });
  }

  @override
  Future<void> setLogFileSize(int fileSizeInKBytes) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetLogFileSize.index,
      'params': jsonEncode({
        'fileSizeInKBytes': fileSizeInKBytes,
      }),
    });
  }

  @override
  Future<void> setParameters(String parameters) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetParameters.index,
      'params': jsonEncode({
        'parameters': parameters,
      }),
    });
  }

  @override
  Future<UserInfo> getUserInfoByUid(int uid) {
    if (_subProcess) {
      throw PlatformException(code: ErrorCode.NotSupported.toString());
    }
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineGetUserInfoByUid.index,
      'params': jsonEncode({
        'uid': uid,
      }),
    }).then((value) {
      return UserInfo.fromJson(Map<String, dynamic>.from(jsonDecode(value)));
    });
  }

  @override
  Future<UserInfo> getUserInfoByUserAccount(String userAccount) {
    if (_subProcess) {
      throw PlatformException(code: ErrorCode.NotSupported.toString());
    }
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineGetUserInfoByUserAccount.index,
      'params': jsonEncode({
        'userAccount': userAccount,
      }),
    }).then((value) {
      return UserInfo.fromJson(Map<String, dynamic>.from(jsonDecode(value)));
    });
  }

  @override
  Future<void> joinChannelWithUserAccount(
      String? token, String channelName, String userAccount,
      [ChannelMediaOptions? options]) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineJoinChannelWithUserAccount.index,
      'params': jsonEncode({
        'token': token,
        'channelId': channelName,
        'userAccount': userAccount,
        'options': options?.toJson(),
      }),
    });
  }

  @override
  Future<void> registerLocalUserAccount(String appId, String userAccount) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineRegisterLocalUserAccount.index,
      'params': jsonEncode({
        'appId': appId,
        'userAccount': userAccount,
      }),
    });
  }

  @override
  Future<void> adjustPlaybackSignalVolume(int volume) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineAdjustPlaybackSignalVolume.index,
      'params': jsonEncode({
        'volume': volume,
      }),
    });
  }

  @override
  Future<void> adjustRecordingSignalVolume(int volume) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineAdjustRecordingSignalVolume.index,
      'params': jsonEncode({
        'volume': volume,
      }),
    });
  }

  @override
  Future<void> adjustUserPlaybackSignalVolume(int uid, int volume) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineAdjustUserPlaybackSignalVolume.index,
      'params': jsonEncode({
        'uid': uid,
        'volume': volume,
      }),
    });
  }

  @override
  Future<void> enableLoopbackRecording(bool enabled, {String? deviceName}) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineEnableLoopBackRecording.index,
      'params': jsonEncode({
        'enabled': enabled,
        'deviceName': deviceName,
      }),
    });
  }

  @override
  Future<void> disableAudio() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineDisableAudio.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<void> enableAudio() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineEnableAudio.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<void> enableAudioVolumeIndication(
    int interval,
    int smooth,
    // ignore: non_constant_identifier_names
    bool report_vad,
  ) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineEnableAudioVolumeIndication.index,
      'params': jsonEncode({
        'interval': interval,
        'smooth': smooth,
        'report_vad': report_vad,
      }),
    });
  }

  @override
  Future<void> enableLocalAudio(bool enabled) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineEnableLocalAudio.index,
      'params': jsonEncode({
        'enabled': enabled,
      }),
    });
  }

  @override
  Future<void> muteAllRemoteAudioStreams(bool muted) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineMuteAllRemoteAudioStreams.index,
      'params': jsonEncode({
        'mute': muted,
      }),
    });
  }

  @override
  Future<void> muteLocalAudioStream(bool muted) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineMuteLocalAudioStream.index,
      'params': jsonEncode({
        'mute': muted,
      }),
    });
  }

  @override
  Future<void> muteRemoteAudioStream(int uid, bool muted) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineMuteRemoteAudioStream.index,
      'params': jsonEncode({
        'userId': uid,
        'mute': muted,
      }),
    });
  }

  @override
  Future<void> setAudioProfile(AudioProfile profile, AudioScenario scenario) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetAudioProfile.index,
      'params': jsonEncode({
        'profile': AudioProfileConverter(profile).value(),
        'scenario': AudioScenarioConverter(scenario).value(),
      }),
    });
  }

  @override
  Future<void> setDefaultMuteAllRemoteAudioStreams(bool muted) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetDefaultMuteAllRemoteAudioStreams.index,
      'params': jsonEncode({
        'mute': muted,
      }),
    });
  }

  @override
  Future<void> disableVideo() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineDisableVideo.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<void> enableLocalVideo(bool enabled) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineEnableLocalVideo.index,
      'params': jsonEncode({
        'enabled': enabled,
      }),
    });
  }

  @override
  Future<void> enableVideo() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineEnableVideo.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<void> muteAllRemoteVideoStreams(bool muted) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineMuteAllRemoteVideoStreams.index,
      'params': jsonEncode({
        'mute': muted,
      }),
    });
  }

  @override
  Future<void> muteLocalVideoStream(bool muted) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineMuteLocalVideoStream.index,
      'params': jsonEncode({
        'mute': muted,
      }),
    });
  }

  @override
  Future<void> muteRemoteVideoStream(int uid, bool muted) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineMuteRemoteVideoStream.index,
      'params': jsonEncode({
        'userId': uid,
        'mute': muted,
      }),
    });
  }

  @override
  Future<void> setBeautyEffectOptions(bool enabled, BeautyOptions options) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetBeautyEffectOptions.index,
      'params': jsonEncode({
        'enabled': enabled,
        'options': options.toJson(),
      }),
    });
  }

  @override
  Future<void> setDefaultMuteAllRemoteVideoStreams(bool muted) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetDefaultMuteAllRemoteVideoStreams.index,
      'params': jsonEncode({
        'mute': muted,
      }),
    });
  }

  @override
  Future<void> setVideoEncoderConfiguration(VideoEncoderConfiguration config) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetVideoEncoderConfiguration.index,
      'params': jsonEncode({
        'config': config.toJson(),
      }),
    });
  }

  @override
  Future<void> startPreview() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineStartPreview.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<void> stopPreview() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineStopPreview.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<void> adjustAudioMixingPlayoutVolume(int volume) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineAdjustAudioMixingPlayoutVolume.index,
      'params': jsonEncode({
        'volume': volume,
      }),
    });
  }

  @override
  Future<void> adjustAudioMixingPublishVolume(int volume) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineAdjustAudioMixingPublishVolume.index,
      'params': jsonEncode({
        'volume': volume,
      }),
    });
  }

  @override
  Future<void> adjustAudioMixingVolume(int volume) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineAdjustAudioMixingVolume.index,
      'params': jsonEncode({
        'volume': volume,
      }),
    });
  }

  @override
  Future<int?> getAudioMixingCurrentPosition() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineGetAudioMixingCurrentPosition.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<int?> getAudioMixingDuration([String? filePath]) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineGetAudioMixingDuration.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<int?> getAudioFileInfo(String filePath) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineGetAudioFileInfo.index,
      'params': jsonEncode({
        'filePath': filePath,
      }),
    });
  }

  @override
  Future<int?> getAudioMixingPlayoutVolume() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineGetAudioMixingPlayoutVolume.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<int?> getAudioMixingPublishVolume() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineGetAudioMixingPublishVolume.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<void> pauseAudioMixing() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEnginePauseAudioMixing.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<void> resumeAudioMixing() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineResumeAudioMixing.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<void> setAudioMixingPosition(int pos) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetAudioMixingPosition.index,
      'params': jsonEncode({
        'pos': pos,
      }),
    });
  }

  @override
  Future<void> startAudioMixing(
      String filePath, bool loopback, bool replace, int cycle,
      [int? startPos]) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineStartAudioMixing.index,
      'params': jsonEncode({
        'filePath': filePath,
        'loopback': loopback,
        'replace': replace,
        'cycle': cycle,
        'startPos': startPos,
      }),
    });
  }

  @override
  Future<void> stopAudioMixing() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineStopAudioMixing.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<void> addInjectStreamUrl(String url, LiveInjectStreamConfig config) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineAddInjectStreamUrl.index,
      'params': jsonEncode({
        'url': url,
        'config': config.toJson(),
      }),
    });
  }

  @override
  Future<void> addPublishStreamUrl(String url, bool transcodingEnabled) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineAddPublishStreamUrl.index,
      'params': jsonEncode({
        'url': url,
        'transcodingEnabled': transcodingEnabled,
      }),
    });
  }

  @override
  Future<void> addVideoWatermark(
      String watermarkUrl, WatermarkOptions options) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineAddVideoWaterMark.index,
      'params': jsonEncode({
        'watermarkUrl': watermarkUrl,
        'options': options.toJson(),
      }),
    });
  }

  @override
  Future<void> clearVideoWatermarks() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineClearVideoWaterMarks.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<int?> createDataStream(bool reliable, bool ordered) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineCreateDataStream.index,
      'params': jsonEncode({
        'reliable': reliable,
        'ordered': ordered,
      }),
    });
  }

  @override
  Future<void> disableLastmileTest() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineDisableLastMileTest.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<void> enableDualStreamMode(bool enabled) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineEnableDualStreamMode.index,
      'params': jsonEncode({
        'enabled': enabled,
      }),
    });
  }

  @override
  Future<void> enableInEarMonitoring(bool enabled) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineEnableInEarMonitoring.index,
      'params': jsonEncode({
        'enabled': enabled,
      }),
    });
  }

  @override
  Future<void> enableLastmileTest() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineEnableLastMileTest.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<void> enableSoundPositionIndication(bool enabled) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineEnableSoundPositionIndication.index,
      'params': jsonEncode({
        'enabled': enabled,
      }),
    });
  }

  @override
  Future<double?> getCameraMaxZoomFactor() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineGetCameraMaxZoomFactor.index,
      'params': jsonEncode({}),
    }).then((value) => double.tryParse(value) ?? 0.0);
  }

  @override
  Future<double?> getEffectsVolume() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineGetEffectsVolume.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<bool?> isCameraAutoFocusFaceModeSupported() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineIsCameraAutoFocusFaceModeSupported.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<bool?> isCameraExposurePositionSupported() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineIsCameraExposurePositionSupported.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<bool?> isCameraFocusSupported() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineIsCameraFocusSupported.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<bool?> isCameraTorchSupported() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineIsCameraTorchSupported.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<bool?> isCameraZoomSupported() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineIsCameraZoomSupported.index,
      'params': jsonEncode({}),
    }).then((v) => v == 1 ? true : false);
  }

  @override
  Future<bool?> isSpeakerphoneEnabled() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineIsSpeakerPhoneEnabled.index,
      'params': jsonEncode({}),
    }).then((value) => value == 1 ? true : false);
  }

  @override
  Future<void> pauseAllEffects() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEnginePauseAllEffects.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<void> pauseEffect(int soundId) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEnginePauseEffect.index,
      'params': jsonEncode({
        'soundId': soundId,
      }),
    });
  }

  @override
  Future<void> playEffect(int soundId, String filePath, int loopCount,
      double pitch, double pan, int gain, bool publish,
      [int? startPos]) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEnginePlayEffect.index,
      'params': jsonEncode({
        'soundId': soundId,
        'filePath': filePath,
        'loopCount': loopCount,
        'pitch': pitch,
        'pan': pan,
        'gain': gain,
        'publish': publish,
        'startPos': startPos,
      }),
    });
  }

  @override
  Future<void> setEffectPosition(int soundId, int pos) {
    if (kIsWeb) {
      throw PlatformException(code: ErrorCode.NotSupported.toString());
    }
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetEffectPosition.index,
      'params': jsonEncode({
        'soundId': soundId,
        'pos': pos,
      }),
    });
  }

  @override
  Future<int?> getEffectDuration(String filePath) {
    if (kIsWeb) {
      throw PlatformException(code: ErrorCode.NotSupported.toString());
    }
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineGetEffectDuration.index,
      'params': jsonEncode({
        'filePath': filePath,
      }),
    });
  }

  @override
  Future<int?> getEffectCurrentPosition(int soundId) {
    if (kIsWeb) {
      throw PlatformException(code: ErrorCode.NotSupported.toString());
    }
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineGetEffectCurrentPosition.index,
      'params': jsonEncode({
        'soundId': soundId,
      }),
    });
  }

  @override
  Future<void> preloadEffect(int soundId, String filePath) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEnginePreloadEffect.index,
      'params': jsonEncode({
        'soundId': soundId,
        'filePath': filePath,
      }),
    });
  }

  @override
  Future<void> registerMediaMetadataObserver() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineRegisterMediaMetadataObserver.index,
      'params': jsonEncode({'type': 0}),
    });
  }

  @override
  Future<void> removeInjectStreamUrl(String url) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineRemoveInjectStreamUrl.index,
      'params': jsonEncode({
        'url': url,
      }),
    });
  }

  @override
  Future<void> removePublishStreamUrl(String url) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineRemovePublishStreamUrl.index,
      'params': jsonEncode({
        'url': url,
      }),
    });
  }

  @override
  Future<void> resumeAllEffects() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineResumeAllEffects.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<void> resumeEffect(int soundId) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineResumeEffect.index,
      'params': jsonEncode({
        'soundId': soundId,
      }),
    });
  }

  @override
  Future<void> sendMetadata(Uint8List metadata) {
    return _invokeMethod('callApiWithBuffer', {
      'apiType': ApiTypeEngine.kEngineSendMetadata.index,
      'params': jsonEncode({
        'metadata': {
          'size': metadata.length,
        },
      }),
      'buffer': metadata,
    });
  }

  @override
  Future<void> sendStreamMessage(int streamId, Uint8List message) {
    return _invokeMethod('callApiWithBuffer', {
      'apiType': ApiTypeEngine.kEngineSendStreamMessage.index,
      'params': jsonEncode({
        'streamId': streamId,
        'length': message.length,
      }),
      'buffer': message,
    });
  }

  @override
  Future<void> setCameraAutoFocusFaceModeEnabled(bool enabled) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetCameraAutoFocusFaceModeEnabled.index,
      'params': jsonEncode({
        'enabled': enabled,
      }),
    });
  }

  @override
  Future<void> setCameraCapturerConfiguration(
      CameraCapturerConfiguration config) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetCameraCapturerConfiguration.index,
      'params': jsonEncode({
        'config': config.toJson(),
      }),
    });
  }

  @override
  Future<void> setCameraExposurePosition(
      double positionXinView, double positionYinView) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetCameraExposurePosition.index,
      'params': jsonEncode({
        'positionXinView': positionXinView,
        'positionYinView': positionYinView,
      }),
    });
  }

  @override
  Future<void> setCameraFocusPositionInPreview(
      double positionX, double positionY) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetCameraFocusPositionInPreview.index,
      'params': jsonEncode({
        'positionX': positionX,
        'positionY': positionY,
      }),
    });
  }

  @override
  Future<void> setCameraTorchOn(bool isOn) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetCameraTorchOn.index,
      'params': jsonEncode({
        'isOn': isOn,
      }),
    });
  }

  @override
  Future<void> setCameraZoomFactor(double factor) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetCameraZoomFactor.index,
      'params': jsonEncode({
        'factor': factor,
      }),
    });
  }

  @override
  Future<void> setDefaultAudioRouteToSpeakerphone(bool defaultToSpeaker) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetDefaultAudioRouteToSpeakerPhone.index,
      'params': jsonEncode({
        'defaultToSpeaker': defaultToSpeaker,
      }),
    });
  }

  @override
  Future<void> setEffectsVolume(int volume) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetEffectsVolume.index,
      'params': jsonEncode({
        'volume': volume,
      }),
    });
  }

  @override
  Future<void> setEnableSpeakerphone(bool speakerOn) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetEnableSpeakerPhone.index,
      'params': jsonEncode({
        'speakerOn': speakerOn,
      }),
    });
  }

  @override
  Future<void> setEncryptionMode(EncryptionMode encryptionMode) {
    var encryption = '';
    switch (encryptionMode) {
      case EncryptionMode.AES128XTS:
        encryption = 'aes-128-xts';
        break;
      case EncryptionMode.AES128ECB:
        encryption = 'aes-128-ecb';
        break;
      case EncryptionMode.AES256XTS:
        encryption = 'aes-256-xts';
        break;
      default:
        break;
    }
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetEncryptionMode.index,
      'params': jsonEncode({
        'encryptionMode': encryption,
      }),
    });
  }

  @override
  Future<void> setEncryptionSecret(String secret) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetEncryptionSecret.index,
      'params': jsonEncode({
        'secret': secret,
      }),
    });
  }

  @override
  Future<void> setInEarMonitoringVolume(int volume) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetInEarMonitoringVolume.index,
      'params': jsonEncode({
        'volume': volume,
      }),
    });
  }

  @override
  Future<void> setLiveTranscoding(LiveTranscoding transcoding) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetLiveTranscoding.index,
      'params': jsonEncode({
        'transcoding': transcoding.toJson(),
      }),
    });
  }

  @override
  Future<void> setLocalPublishFallbackOption(StreamFallbackOptions option) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetLocalPublishFallbackOption.index,
      'params': jsonEncode({
        'option': StreamFallbackOptionsConverter(option).value(),
      }),
    });
  }

  @override
  Future<void> setLocalVoiceChanger(AudioVoiceChanger voiceChanger) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetLocalVoiceChanger.index,
      'params': jsonEncode({
        'voiceChanger': AudioVoiceChangerConverter(voiceChanger).value(),
      }),
    });
  }

  @override
  Future<void> setLocalVoiceEqualization(
      AudioEqualizationBandFrequency bandFrequency, int bandGain) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetLocalVoiceEqualization.index,
      'params': jsonEncode({
        'bandFrequency':
            AudioEqualizationBandFrequencyConverter(bandFrequency).value(),
        'bandGain': bandGain,
      }),
    });
  }

  @override
  Future<void> setLocalVoicePitch(double pitch) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetLocalVoicePitch.index,
      'params': jsonEncode({
        'pitch': pitch,
      }),
    });
  }

  @override
  Future<void> setLocalVoiceReverb(AudioReverbType reverbKey, int value) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetLocalVoiceReverb.index,
      'params': jsonEncode({
        'reverbKey': AudioReverbTypeConverter(reverbKey).value(),
        'value': value,
      }),
    });
  }

  @override
  Future<void> setLocalVoiceReverbPreset(AudioReverbPreset reverbPreset) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetLocalVoiceReverbPreset.index,
      'params': jsonEncode({
        'reverbPreset': AudioReverbPresetConverter(reverbPreset).value(),
      }),
    });
  }

  @override
  Future<void> setMaxMetadataSize(int size) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetMaxMetadataSize.index,
      'params': jsonEncode({
        'size': size,
      }),
    });
  }

  @override
  Future<void> setRemoteDefaultVideoStreamType(VideoStreamType streamType) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetRemoteDefaultVideoStreamType.index,
      'params': jsonEncode({
        'streamType': VideoStreamTypeConverter(streamType).value(),
      }),
    });
  }

  @override
  Future<void> setRemoteSubscribeFallbackOption(StreamFallbackOptions option) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetRemoteSubscribeFallbackOption.index,
      'params': jsonEncode({
        'option': StreamFallbackOptionsConverter(option).value(),
      }),
    });
  }

  @override
  Future<void> setRemoteUserPriority(int uid, UserPriority userPriority) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetRemoteUserPriority.index,
      'params': jsonEncode({
        'uid': uid,
        'userPriority': UserPriorityConverter(userPriority).value(),
      }),
    });
  }

  @override
  Future<void> setRemoteVideoStreamType(
      int userId, VideoStreamType streamType) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetRemoteVideoStreamType.index,
      'params': jsonEncode({
        'userId': userId,
        'streamType': VideoStreamTypeConverter(streamType).value(),
      }),
    });
  }

  @override
  Future<void> setRemoteVoicePosition(int uid, double pan, double gain) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetRemoteVoicePosition.index,
      'params': jsonEncode({
        'uid': uid,
        'pan': pan,
        'gain': gain,
      }),
    });
  }

  @override
  Future<void> setVolumeOfEffect(int soundId, int volume) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetVolumeOfEffect.index,
      'params': jsonEncode({
        'soundId': soundId,
        'volume': volume,
      }),
    });
  }

  @override
  Future<void> startAudioRecording(String filePath,
      AudioSampleRateType sampleRate, AudioRecordingQuality quality) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineStartAudioRecording.index,
      'params': jsonEncode({
        'filePath': filePath,
        'sampleRate': AudioSampleRateTypeConverter(sampleRate).value(),
        'quality': AudioRecordingQualityConverter(quality).value(),
      }),
    });
  }

  @override
  Future<void> startAudioRecordingWithConfig(
      AudioRecordingConfiguration config) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineStartAudioRecording.index,
      'params': jsonEncode({
        'config': config.toJson(),
      }),
    });
  }

  @override
  Future<void> startChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineStartChannelMediaRelay.index,
      'params': jsonEncode({
        'configuration': channelMediaRelayConfiguration.toJson(),
      }),
    });
  }

  @override
  Future<void> startRhythmPlayer(
      String sound1, String sound2, RhythmPlayerConfig config) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineStartRhythmPlayer.index,
      'params': jsonEncode({
        'sound1': sound1,
        'sound2': sound2,
        'config': config.toJson(),
      }),
    });
  }

  @override
  Future<void> stopRhythmPlayer() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineStopRhythmPlayer.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<void> configRhythmPlayer(RhythmPlayerConfig config) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineConfigRhythmPlayer.index,
      'params': jsonEncode({
        'config': config.toJson(),
      }),
    });
  }

  @override
  Future<void> startEchoTest(
      {int? intervalInSeconds, EchoTestConfiguration? config}) {
    assert(intervalInSeconds == null || config == null,
        'Only need one of the params');
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineStartEchoTest.index,
      'params': jsonEncode(config == null
          ? {'intervalInSeconds': intervalInSeconds}
          : {'config': config.toJson()}),
    });
  }

  @override
  Future<void> startLastmileProbeTest(LastmileProbeConfig config) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineStartLastMileProbeTest.index,
      'params': jsonEncode({
        'config': config.toJson(),
      }),
    });
  }

  @override
  Future<void> stopAllEffects() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineStopAllEffects.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<void> stopAudioRecording() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineStopAudioRecording.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<void> stopChannelMediaRelay() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineStopChannelMediaRelay.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<void> stopEchoTest() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineStopEchoTest.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<void> stopEffect(int soundId) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineStopEffect.index,
      'params': jsonEncode({
        'soundId': soundId,
      }),
    });
  }

  @override
  Future<void> stopLastmileProbeTest() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineStopLastMileProbeTest.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<void> switchCamera() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSwitchCamera.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<void> unloadEffect(int soundId) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineUnloadEffect.index,
      'params': jsonEncode({
        'soundId': soundId,
      }),
    });
  }

  @override
  Future<void> unregisterMediaMetadataObserver() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineUnRegisterMediaMetadataObserver.index,
      'params': jsonEncode({'type': 0}),
    });
  }

  @override
  Future<void> updateChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineUpdateChannelMediaRelay.index,
      'params': jsonEncode({
        'configuration': channelMediaRelayConfiguration.toJson(),
      }),
    });
  }

  @override
  Future<void> enableFaceDetection(bool enable) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineEnableFaceDetection.index,
      'params': jsonEncode({
        'enable': enable,
      }),
    });
  }

  @override
  Future<void> setAudioMixingPitch(int pitch) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetAudioMixingPitch.index,
      'params': jsonEncode({
        'pitch': pitch,
      }),
    });
  }

  @override
  Future<void> setAudioMixingPlaybackSpeed(int speed) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetAudioMixingPlaybackSpeed.index,
      'params': jsonEncode({
        'speed': speed,
      }),
    });
  }

  @override
  Future<int?> getAudioTrackCount() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineGetAudioTrackCount.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<void> selectAudioTrack(int index) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSelectAudioTrack.index,
      'params': jsonEncode({
        'index': index,
      }),
    });
  }

  @override
  Future<void> setAudioMixingDualMonoMode(AudioMixingDualMonoMode mode) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetAudioMixingDualMonoMode.index,
      'params': jsonEncode({
        'mode': AudioMixingDualMonoModeConverter(mode).value(),
      }),
    });
  }

  @override
  Future<void> enableEncryption(bool enabled, EncryptionConfig config) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineEnableEncryption.index,
      'params': jsonEncode({
        'enabled': enabled,
        'config': config.toJson(),
      }),
    });
  }

  @override
  Future<void> sendCustomReportMessage(
      String id, String category, String event, String label, int value) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSendCustomReportMessage.index,
      'params': jsonEncode({
        'id': id,
        'category': category,
        'event': event,
        'label': label,
        'value': value,
      }),
    });
  }

  @override
  Future<void> setAudioSessionOperationRestriction(
      AudioSessionOperationRestriction restriction) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetAudioSessionOperationRestriction.index,
      'params': jsonEncode({
        'restriction':
            AudioSessionOperationRestrictionConverter(restriction).value(),
      }),
    });
  }

  @override
  Future<int?> getNativeHandle() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineGetNativeHandle.index,
      'params': jsonEncode({}),
    }).then((value) => int.tryParse(value) ?? -1);
  }

  @override
  Future<void> setAudioEffectParameters(
      AudioEffectPreset preset, int param1, int param2) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetAudioEffectParameters.index,
      'params': jsonEncode({
        'preset': AudioEffectPresetConverter(preset).value(),
        'param1': param1,
        'param2': param2,
      }),
    });
  }

  @override
  Future<void> setAudioEffectPreset(AudioEffectPreset preset) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetAudioEffectPreset.index,
      'params': jsonEncode({
        'preset': AudioEffectPresetConverter(preset).value(),
      }),
    });
  }

  @override
  Future<void> setVoiceBeautifierPreset(VoiceBeautifierPreset preset) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetVoiceBeautifierPreset.index,
      'params': jsonEncode({
        'preset': VoiceBeautifierPresetConverter(preset).value(),
      }),
    });
  }

  @override
  Future<int?> createDataStreamWithConfig(DataStreamConfig config) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineCreateDataStream.index,
      'params': jsonEncode({
        'config': config.toJson(),
      }),
    });
  }

  @override
  Future<void> enableDeepLearningDenoise(bool enable) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineEnableDeepLearningDenoise.index,
      'params': jsonEncode({
        'enable': enable,
      }),
    });
  }

  @override
  Future<void> enableRemoteSuperResolution(int userId, bool enable) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineEnableRemoteSuperResolution.index,
      'params': jsonEncode({
        'userId': userId,
        'enable': enable,
      }),
    });
  }

  @override
  Future<void> setCloudProxy(CloudProxyType proxyType) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetCloudProxy.index,
      'params': jsonEncode({
        'proxyType': CloudProxyTypeConverter(proxyType).value(),
      }),
    });
  }

  @override
  Future<String?> uploadLogFile() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineUploadLogFile.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<void> setVoiceBeautifierParameters(
      VoiceBeautifierPreset preset, int param1, int param2) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetVoiceBeautifierParameters.index,
      'params': jsonEncode({
        'preset': VoiceBeautifierPresetConverter(preset).value(),
        'param1': param1,
        'param2': param2,
      }),
    });
  }

  @override
  Future<void> setVoiceConversionPreset(VoiceConversionPreset preset) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetVoiceConversionPreset.index,
      'params': jsonEncode({
        'preset': VoiceConversionPresetConverter(preset).value(),
      }),
    });
  }

  @override
  Future<void> pauseAllChannelMediaRelay() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEnginePauseAllChannelMediaRelay.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<void> resumeAllChannelMediaRelay() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineResumeAllChannelMediaRelay.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<void> setLocalAccessPoint(LocalAccessPointConfiguration config) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetLocalAccessPoint.index,
      'params': jsonEncode({
        'config': config.toJson(),
      }),
    });
  }

  @override
  Future<void> setScreenCaptureContentHint(VideoContentHint contentHint) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetScreenCaptureContentHint.index,
      'params': jsonEncode({
        'contentHint': VideoContentHintConverter(contentHint).value(),
      }),
    });
  }

  @override
  Future<void> startScreenCaptureByDisplayId(int displayId,
      [Rectangle? regionRect, ScreenCaptureParameters? captureParams]) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineStartScreenCaptureByDisplayId.index,
      'params': jsonEncode({
        'displayId': displayId,
        'regionRect': regionRect?.toJson(),
        'captureParams': captureParams?.toJson(),
      }),
    });
  }

  @override
  Future<void> startScreenCaptureByScreenRect(Rectangle screenRect,
      [Rectangle? regionRect, ScreenCaptureParameters? captureParams]) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineStartScreenCaptureByScreenRect.index,
      'params': jsonEncode({
        'screenRect': screenRect.toJson(),
        'regionRect': regionRect?.toJson(),
        'captureParams': captureParams?.toJson(),
      }),
    });
  }

  @override
  Future<void> startScreenCaptureByWindowId(int windowId,
      [Rectangle? regionRect, ScreenCaptureParameters? captureParams]) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineStartScreenCaptureByWindowId.index,
      'params': jsonEncode({
        'windowId': windowId,
        'regionRect': regionRect?.toJson(),
        'captureParams': captureParams?.toJson(),
      }),
    });
  }

  @override
  Future<void> stopScreenCapture() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineStopScreenCapture.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<void> updateScreenCaptureParameters(
      ScreenCaptureParameters captureParams) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineUpdateScreenCaptureParameters.index,
      'params': jsonEncode({
        'captureParams': captureParams.toJson(),
      }),
    });
  }

  @override
  Future<void> updateScreenCaptureRegion(Rectangle regionRect) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineUpdateScreenCaptureRegion.index,
      'params': jsonEncode({
        'regionRect': regionRect.toJson(),
      }),
    });
  }

  @override
  Future<void> startScreenCapture(int windowId,
      [int captureFreq = 0, Rect? rect, int bitrate = 0]) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineStartScreenCapture.index,
      'params': jsonEncode({
        'windowId': windowId,
        'captureFreq': captureFreq,
        'rect': rect?.toJson(),
        'bitrate': bitrate,
      }),
    });
  }

  @override
  Future<void> enableVirtualBackground(
      bool enabled, VirtualBackgroundSource backgroundSource) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineEnableVirtualBackground.index,
      'params': jsonEncode({
        'enabled': enabled,
        'backgroundSource': backgroundSource.toJson(),
      }),
    });
  }

  @override
  Future<void> takeSnapshot(String channel, int uid, String filePath) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineTakeSnapshot.index,
      'params': jsonEncode({
        'channel': channel,
        'uid': uid,
        'filePath': filePath,
      }),
    });
  }

  @override
  Future<void> enableWirelessAccelerate(bool enabled) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineEnableWirelessAccelerate.index,
      'params': jsonEncode({
        'enabled': enabled,
      }),
    });
  }

  @override
  Future<void> setAVSyncSource(String channelId, int uid) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetAVSyncSource.index,
      'params': jsonEncode({
        'channelId': channelId,
        'uid': uid,
      }),
    });
  }

  @override
  Future<void> setColorEnhanceOptions(
      bool enabled, ColorEnhanceOptions option) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetColorEnhanceOptions.index,
      'params': jsonEncode({
        'enabled': enabled,
        'option': option.toJson(),
      }),
    });
  }

  @override
  Future<void> setLowlightEnhanceOptions(
      bool enabled, LowLightEnhanceOptions option) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetLowlightEnhanceOptions.index,
      'params': jsonEncode({
        'enabled': enabled,
        'option': option.toJson(),
      }),
    });
  }

  @override
  Future<void> setVideoDenoiserOptions(
      bool enabled, VideoDenoiserOptions option) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineSetVideoDenoiserOptions.index,
      'params': jsonEncode({
        'enabled': enabled,
        'option': option.toJson(),
      }),
    });
  }

  @override
  Future<void> startRtmpStreamWithoutTranscoding(String url) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineStartRtmpStreamWithoutTranscoding.index,
      'params': jsonEncode({
        'url': url,
      }),
    });
  }

  @override
  Future<void> stopRtmpStream(String url) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineStopRtmpStream.index,
      'params': jsonEncode({
        'url': url,
      }),
    });
  }

  @override
  Future<void> updateRtmpTranscoding(LiveTranscoding transcoding) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeEngine.kEngineUpdateRtmpTranscoding.index,
      'params': jsonEncode({
        'transcoding': transcoding.toJson(),
      }),
    });
  }
}
