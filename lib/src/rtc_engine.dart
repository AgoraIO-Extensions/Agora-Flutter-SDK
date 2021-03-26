import 'dart:async';

import 'package:flutter/services.dart';

import '../rtc_local_view.dart';
import 'classes.dart';
import 'enum_converter.dart';
import 'enums.dart';
import 'events.dart';
import 'rtc_channel.dart';

/// RtcEngine is the main class of the Agora SDK.
class RtcEngine with RtcEngineInterface {
  static const MethodChannel _methodChannel = MethodChannel('agora_rtc_engine');
  static const EventChannel _eventChannel =
      EventChannel('agora_rtc_engine/events');

  /// Exposing methodChannel to other files
  static MethodChannel get methodChannel => _methodChannel;

  static RtcEngine _engine;

  RtcEngineEventHandler _handler;

  RtcEngine._() {
    _eventChannel.receiveBroadcastStream().listen((event) {
      final eventMap = Map<dynamic, dynamic>.from(event);
      final methodName = eventMap['methodName'] as String;
      final data = List<dynamic>.from(eventMap['data']);
      _handler?.process(methodName, data);
    });
  }

  static Future<T> _invokeMethod<T>(String method,
      [Map<String, dynamic> arguments]) {
    return _methodChannel.invokeMethod(method, arguments);
  }

  /// Creates an [RtcEngine] instance.
  ///
  /// Unless otherwise specified, all the methods provided by the RtcEngine class are executed asynchronously. Agora recommends calling these methods in the same thread.
  ///
  /// **Note**
  /// - You must create an [RtcEngine] instance before calling any other method.
  /// - You can create an [RtcEngine] instance either by calling this method or by calling [RtcEngine.createWithAreaCode]. The difference between [RtcEngine.createWithAreaCode] and this method is that [RtcEngine.createWithAreaCode] enables you to specify the connection area.
  /// - The RTC Flutter SDK supports creating only one [RtcEngine] instance for an app for now.
  ///
  /// **Parameter** [appId] The App ID issued to you by Agora. See How to get the App ID. Only users in apps with the same App ID can join the same channel and communicate with each other. Use an App ID to create only one [RtcEngine] instance. To change your App ID, call destroy to destroy the current [RtcEngine] instance, and after destroy returns 0, call create to create an [RtcEngine] instance with the new App ID.
  ///
  /// **Returns**
  /// - An [RtcEngine] instance if the method call succeeds.
  /// - The error code, if this method call fails:
  ///   - [ErrorCode.InvalidAppId]
  static Future<RtcEngine> create(String appId) async {
    if (_engine != null) return _engine;
    await _methodChannel.invokeMethod('create', {'appId': appId, 'appType': 4});
    _engine = RtcEngine._();
    return _engine;
  }

  @override
  Future<void> destroy() {
    RtcChannel.destroyAll();
    _handler = null;
    _engine = null;
    return _invokeMethod('destroy');
  }

  /// Sets the engine event handler.
  ///
  /// After setting the engine event handler, you can listen for engine events and receive the statistics of the corresponding [RtcEngine] instance.
  ///
  /// **Parameter** [handler] The event handler.
  void setEventHandler(RtcEngineEventHandler handler) {
    _handler = handler;
  }

  @override
  Future<void> setChannelProfile(ChannelProfile profile) {
    return _invokeMethod('setChannelProfile',
        {'profile': ChannelProfileConverter(profile).value()});
  }

  @override
  Future<void> setClientRole(ClientRole role) {
    return _invokeMethod(
        'setClientRole', {'role': ClientRoleConverter(role).value()});
  }

  @override
  Future<void> joinChannel(
      String token, String channelName, String optionalInfo, int optionalUid) {
    return _invokeMethod('joinChannel', {
      'token': token,
      'channelName': channelName,
      'optionalInfo': optionalInfo,
      'optionalUid': optionalUid
    });
  }

  @override
  Future<void> switchChannel(String token, String channelName) {
    return _invokeMethod(
        'switchChannel', {'token': token, 'channelName': channelName});
  }

  @override
  Future<void> leaveChannel() {
    return _invokeMethod('leaveChannel');
  }

  @override
  Future<void> renewToken(String token) {
    return _invokeMethod('renewToken', {'token': token});
  }

  @override
  @deprecated
  Future<void> enableWebSdkInteroperability(bool enabled) {
    return _invokeMethod('enableWebSdkInteroperability', {'enabled': enabled});
  }

  @override
  Future<ConnectionStateType> getConnectionState() {
    return _invokeMethod('getConnectionState').then((value) {
      return ConnectionStateTypeConverter.fromValue(value).e;
    });
  }

  @override
  Future<String> getCallId() {
    return _invokeMethod('getCallId');
  }

  @override
  Future<void> rate(String callId, int rating, {String description}) {
    return _invokeMethod('rate',
        {'callId': callId, 'rating': rating, 'description': description});
  }

  @override
  Future<void> complain(String callId, String description) {
    return _invokeMethod(
        'complain', {'callId': callId, 'description': description});
  }

  @override
  Future<void> setLogFile(String filePath) {
    return _invokeMethod('setLogFile', {'filePath': filePath});
  }

  @override
  Future<void> setLogFilter(LogFilter filter) {
    return _invokeMethod(
        'setLogFilter', {'filter': LogFilterConverter(filter).value()});
  }

  @override
  Future<void> setLogFileSize(int fileSizeInKBytes) {
    return _invokeMethod(
        'setLogFileSize', {'fileSizeInKBytes': fileSizeInKBytes});
  }

  @override
  Future<void> setParameters(String parameters) {
    return _invokeMethod('setParameters', {'parameters': parameters});
  }

  @override
  Future<UserInfo> getUserInfoByUid(int uid) {
    return _invokeMethod('getUserInfoByUid', {'uid': uid}).then((value) {
      return UserInfo.fromJson(Map<String, dynamic>.from(value));
    });
  }

  @override
  Future<UserInfo> getUserInfoByUserAccount(String userAccount) {
    return _invokeMethod(
        'getUserInfoByUserAccount', {'userAccount': userAccount}).then((value) {
      return UserInfo.fromJson(Map<String, dynamic>.from(value));
    });
  }

  @override
  Future<void> joinChannelWithUserAccount(
      String token, String channelName, String userAccount) {
    return _invokeMethod('joinChannelWithUserAccount', {
      'token': token,
      'channelName': channelName,
      'userAccount': userAccount
    });
  }

  @override
  Future<void> registerLocalUserAccount(String appId, String userAccount) {
    return _invokeMethod('registerLocalUserAccount',
        {'appId': appId, 'userAccount': userAccount});
  }

  @override
  Future<void> adjustPlaybackSignalVolume(int volume) {
    return _invokeMethod('adjustPlaybackSignalVolume', {'volume': volume});
  }

  @override
  Future<void> adjustRecordingSignalVolume(int volume) {
    return _invokeMethod('adjustRecordingSignalVolume', {'volume': volume});
  }

  @override
  Future<void> adjustUserPlaybackSignalVolume(int uid, int volume) {
    return _invokeMethod(
        'adjustUserPlaybackSignalVolume', {'uid': uid, 'volume': volume});
  }

  @override
  Future<void> disableAudio() {
    return _invokeMethod('disableAudio');
  }

  @override
  Future<void> enableAudio() {
    return _invokeMethod('enableAudio');
  }

  @override
  Future<void> enableAudioVolumeIndication(
      int interval, int smooth, bool report_vad) {
    return _invokeMethod('enableAudioVolumeIndication',
        {'interval': interval, 'smooth': smooth, 'report_vad': report_vad});
  }

  @override
  Future<void> enableLocalAudio(bool enabled) {
    return _invokeMethod('enableLocalAudio', {'enabled': enabled});
  }

  @override
  Future<void> muteAllRemoteAudioStreams(bool muted) {
    return _invokeMethod('muteAllRemoteAudioStreams', {'muted': muted});
  }

  @override
  Future<void> muteLocalAudioStream(bool muted) {
    return _invokeMethod('muteLocalAudioStream', {'muted': muted});
  }

  @override
  Future<void> muteRemoteAudioStream(int uid, bool muted) {
    return _invokeMethod('muteRemoteAudioStream', {'uid': uid, 'muted': muted});
  }

  @override
  Future<void> setAudioProfile(AudioProfile profile, AudioScenario scenario) {
    return _invokeMethod('setAudioProfile', {
      'profile': AudioProfileConverter(profile).value(),
      'scenario': AudioScenarioConverter(scenario).value()
    });
  }

  @override
  Future<void> setDefaultMuteAllRemoteAudioStreams(bool muted) {
    return _invokeMethod(
        'setDefaultMuteAllRemoteAudioStreams', {'muted': muted});
  }

  @override
  Future<void> disableVideo() {
    return _invokeMethod('disableVideo');
  }

  @override
  Future<void> enableLocalVideo(bool enabled) {
    return _invokeMethod('enableLocalVideo', {'enabled': enabled});
  }

  @override
  Future<void> enableVideo() {
    return _invokeMethod('enableVideo');
  }

  @override
  Future<void> muteAllRemoteVideoStreams(bool muted) {
    return _invokeMethod('muteAllRemoteVideoStreams', {'muted': muted});
  }

  @override
  Future<void> muteLocalVideoStream(bool muted) {
    return _invokeMethod('muteLocalVideoStream', {'muted': muted});
  }

  @override
  Future<void> muteRemoteVideoStream(int uid, bool muted) {
    return _invokeMethod('muteRemoteVideoStream', {'uid': uid, 'muted': muted});
  }

  @override
  Future<void> setBeautyEffectOptions(bool enabled, BeautyOptions options) {
    return _invokeMethod('setBeautyEffectOptions',
        {'enabled': enabled, 'options': options.toJson()});
  }

  @override
  Future<void> setDefaultMuteAllRemoteVideoStreams(bool muted) {
    return _invokeMethod(
        'setDefaultMuteAllRemoteVideoStreams', {'muted': muted});
  }

  @override
  Future<void> setVideoEncoderConfiguration(VideoEncoderConfiguration config) {
    return _invokeMethod(
        'setVideoEncoderConfiguration', {'config': config.toJson()});
  }

  @override
  Future<void> startPreview() {
    return _invokeMethod('startPreview');
  }

  @override
  Future<void> stopPreview() {
    return _invokeMethod('stopPreview');
  }

  @override
  Future<void> adjustAudioMixingPlayoutVolume(int volume) {
    return _invokeMethod('adjustAudioMixingPlayoutVolume', {'volume': volume});
  }

  @override
  Future<void> adjustAudioMixingPublishVolume(int volume) {
    return _invokeMethod('adjustAudioMixingPublishVolume', {'volume': volume});
  }

  @override
  Future<void> adjustAudioMixingVolume(int volume) {
    return _invokeMethod('adjustAudioMixingVolume', {'volume': volume});
  }

  @override
  Future<int> getAudioMixingCurrentPosition() {
    return _invokeMethod('getAudioMixingCurrentPosition');
  }

  @override
  Future<int> getAudioMixingDuration() {
    return _invokeMethod('getAudioMixingDuration');
  }

  @override
  Future<int> getAudioMixingPlayoutVolume() {
    return _invokeMethod('getAudioMixingPlayoutVolume');
  }

  @override
  Future<int> getAudioMixingPublishVolume() {
    return _invokeMethod('getAudioMixingPublishVolume');
  }

  @override
  Future<void> pauseAudioMixing() {
    return _invokeMethod('pauseAudioMixing');
  }

  @override
  Future<void> resumeAudioMixing() {
    return _invokeMethod('resumeAudioMixing');
  }

  @override
  Future<void> setAudioMixingPosition(int pos) {
    return _invokeMethod('setAudioMixingPosition', {'pos': pos});
  }

  @override
  Future<void> startAudioMixing(
      String filePath, bool loopback, bool replace, int cycle) {
    return _invokeMethod('startAudioMixing', {
      'filePath': filePath,
      'loopback': loopback,
      'replace': replace,
      'cycle': cycle
    });
  }

  @override
  Future<void> stopAudioMixing() {
    return _invokeMethod('stopAudioMixing');
  }

  @override
  Future<void> addInjectStreamUrl(String url, LiveInjectStreamConfig config) {
    return _invokeMethod(
        'addInjectStreamUrl', {'url': url, 'config': config.toJson()});
  }

  @override
  Future<void> addPublishStreamUrl(String url, bool transcodingEnabled) {
    return _invokeMethod('addPublishStreamUrl',
        {'url': url, 'transcodingEnabled': transcodingEnabled});
  }

  @override
  Future<void> addVideoWatermark(
      String watermarkUrl, WatermarkOptions options) {
    return _invokeMethod('addVideoWatermark',
        {'watermarkUrl': watermarkUrl, 'options': options.toJson()});
  }

  @override
  Future<void> clearVideoWatermarks() {
    return _invokeMethod('clearVideoWatermarks');
  }

  @override
  Future<int> createDataStream(bool reliable, bool ordered) {
    return _invokeMethod(
        'createDataStream', {'reliable': reliable, 'ordered': ordered});
  }

  @override
  Future<void> disableLastmileTest() {
    return _invokeMethod('disableLastmileTest');
  }

  @override
  Future<void> enableDualStreamMode(bool enabled) {
    return _invokeMethod('enableDualStreamMode', {'enabled': enabled});
  }

  @override
  Future<void> enableInEarMonitoring(bool enabled) {
    return _invokeMethod('enableInEarMonitoring', {'enabled': enabled});
  }

  @override
  Future<void> enableLastmileTest() {
    return _invokeMethod('enableLastmileTest');
  }

  @override
  Future<void> enableSoundPositionIndication(bool enabled) {
    return _invokeMethod('enableSoundPositionIndication', {'enabled': enabled});
  }

  @override
  Future<double> getCameraMaxZoomFactor() {
    return _invokeMethod('getCameraMaxZoomFactor');
  }

  @override
  Future<double> getEffectsVolume() {
    return _invokeMethod('getEffectsVolume');
  }

  @override
  Future<bool> isCameraAutoFocusFaceModeSupported() {
    return _invokeMethod('isCameraAutoFocusFaceModeSupported');
  }

  @override
  Future<bool> isCameraExposurePositionSupported() {
    return _invokeMethod('isCameraExposurePositionSupported');
  }

  @override
  Future<bool> isCameraFocusSupported() {
    return _invokeMethod('isCameraFocusSupported');
  }

  @override
  Future<bool> isCameraTorchSupported() {
    return _invokeMethod('isCameraTorchSupported');
  }

  @override
  Future<bool> isCameraZoomSupported() {
    return _invokeMethod('isCameraZoomSupported');
  }

  @override
  Future<bool> isSpeakerphoneEnabled() {
    return _invokeMethod('isSpeakerphoneEnabled');
  }

  @override
  Future<void> pauseAllEffects() {
    return _invokeMethod('pauseAllEffects');
  }

  @override
  Future<void> pauseEffect(int soundId) {
    return _invokeMethod('pauseEffect', {'soundId': soundId});
  }

  @override
  Future<void> playEffect(int soundId, String filePath, int loopCount,
      double pitch, double pan, double gain, bool publish) {
    return _invokeMethod('playEffect', {
      'soundId': soundId,
      'filePath': filePath,
      'loopCount': loopCount,
      'pitch': pitch,
      'pan': pan,
      'gain': gain,
      'publish': publish
    });
  }

  @override
  Future<void> preloadEffect(int soundId, String filePath) {
    return _invokeMethod(
        'preloadEffect', {'soundId': soundId, 'filePath': filePath});
  }

  @override
  Future<void> registerMediaMetadataObserver() {
    return _invokeMethod('registerMediaMetadataObserver');
  }

  @override
  Future<void> removeInjectStreamUrl(String url) {
    return _invokeMethod('removeInjectStreamUrl', {'url': url});
  }

  @override
  Future<void> removePublishStreamUrl(String url) {
    return _invokeMethod('removePublishStreamUrl', {'url': url});
  }

  @override
  Future<void> resumeAllEffects() {
    return _invokeMethod('resumeAllEffects');
  }

  @override
  Future<void> resumeEffect(int soundId) {
    return _invokeMethod('resumeEffect', {'soundId': soundId});
  }

  @override
  Future<void> sendMetadata(String metadata) {
    return _invokeMethod('sendMetadata', {'metadata': metadata});
  }

  @override
  Future<void> sendStreamMessage(int streamId, String message) {
    return _invokeMethod(
        'sendStreamMessage', {'streamId': streamId, 'message': message});
  }

  @override
  Future<void> setCameraAutoFocusFaceModeEnabled(bool enabled) {
    return _invokeMethod(
        'setCameraAutoFocusFaceModeEnabled', {'enabled': enabled});
  }

  @override
  Future<void> setCameraCapturerConfiguration(
      CameraCapturerConfiguration config) {
    return _invokeMethod(
        'setCameraCapturerConfiguration', {'config': config.toJson()});
  }

  @override
  Future<void> setCameraExposurePosition(
      double positionXinView, double positionYinView) {
    return _invokeMethod('setCameraExposurePosition', {
      'positionXinView': positionXinView,
      'positionYinView': positionYinView
    });
  }

  @override
  Future<void> setCameraFocusPositionInPreview(
      double positionX, double positionY) {
    return _invokeMethod('setCameraFocusPositionInPreview',
        {'positionX': positionX, 'positionY': positionY});
  }

  @override
  Future<void> setCameraTorchOn(bool isOn) {
    return _invokeMethod('setCameraTorchOn', {'isOn': isOn});
  }

  @override
  Future<void> setCameraZoomFactor(double factor) {
    return _invokeMethod('setCameraZoomFactor', {'factor': factor});
  }

  @override
  Future<void> setDefaultAudioRoutetoSpeakerphone(bool defaultToSpeaker) {
    return _invokeMethod('setDefaultAudioRoutetoSpeakerphone',
        {'defaultToSpeaker': defaultToSpeaker});
  }

  @override
  Future<void> setEffectsVolume(double volume) {
    return _invokeMethod('setEffectsVolume', {'volume': volume});
  }

  @override
  Future<void> setEnableSpeakerphone(bool enabled) {
    return _invokeMethod('setEnableSpeakerphone', {'enabled': enabled});
  }

  @override
  Future<void> setEncryptionMode(EncryptionMode encryptionMode) {
    return _invokeMethod('setEncryptionMode',
        {'encryptionMode': EncryptionModeConverter(encryptionMode).value()});
  }

  @override
  Future<void> setEncryptionSecret(String secret) {
    return _invokeMethod('setEncryptionSecret', {'secret': secret});
  }

  @override
  Future<void> setInEarMonitoringVolume(int volume) {
    return _invokeMethod('setInEarMonitoringVolume', {'volume': volume});
  }

  @override
  Future<void> setLiveTranscoding(LiveTranscoding transcoding) {
    return _invokeMethod(
        'setLiveTranscoding', {'transcoding': transcoding.toJson()});
  }

  @override
  Future<void> setLocalPublishFallbackOption(StreamFallbackOptions option) {
    return _invokeMethod('setLocalPublishFallbackOption',
        {'option': StreamFallbackOptionsConverter(option).value()});
  }

  @override
  Future<void> setLocalVoiceChanger(AudioVoiceChanger voiceChanger) {
    return _invokeMethod('setLocalVoiceChanger',
        {'voiceChanger': AudioVoiceChangerConverter(voiceChanger).value()});
  }

  @override
  Future<void> setLocalVoiceEqualization(
      AudioEqualizationBandFrequency bandFrequency, int bandGain) {
    return _invokeMethod('setLocalVoiceEqualization', {
      'bandFrequency':
          AudioEqualizationBandFrequencyConverter(bandFrequency).value(),
      'bandGain': bandGain
    });
  }

  @override
  Future<void> setLocalVoicePitch(double pitch) {
    return _invokeMethod('setLocalVoicePitch', {'pitch': pitch});
  }

  @override
  Future<void> setLocalVoiceReverb(AudioReverbType reverbKey, int value) {
    return _invokeMethod('setLocalVoiceReverb', {
      'reverbKey': AudioReverbTypeConverter(reverbKey).value(),
      'value': value
    });
  }

  @override
  Future<void> setLocalVoiceReverbPreset(AudioReverbPreset preset) {
    return _invokeMethod('setLocalVoiceReverbPreset',
        {'preset': AudioReverbPresetConverter(preset).value()});
  }

  @override
  Future<void> setMaxMetadataSize(int size) {
    return _invokeMethod('setMaxMetadataSize', {'size': size});
  }

  @override
  Future<void> setRemoteDefaultVideoStreamType(VideoStreamType streamType) {
    return _invokeMethod('setRemoteDefaultVideoStreamType',
        {'streamType': VideoStreamTypeConverter(streamType).value()});
  }

  @override
  Future<void> setRemoteSubscribeFallbackOption(StreamFallbackOptions option) {
    return _invokeMethod('setRemoteSubscribeFallbackOption',
        {'option': StreamFallbackOptionsConverter(option).value()});
  }

  @override
  Future<void> setRemoteUserPriority(int uid, UserPriority userPriority) {
    return _invokeMethod('setRemoteUserPriority', {
      'uid': uid,
      'userPriority': UserPriorityConverter(userPriority).value()
    });
  }

  @override
  Future<void> setRemoteVideoStreamType(int uid, VideoStreamType streamType) {
    return _invokeMethod('setRemoteVideoStreamType', {
      'uid': uid,
      'streamType': VideoStreamTypeConverter(streamType).value()
    });
  }

  @override
  Future<void> setRemoteVoicePosition(int uid, double pan, double gain) {
    return _invokeMethod(
        'setRemoteVoicePosition', {'uid': uid, 'pan': pan, 'gain': gain});
  }

  @override
  Future<void> setVolumeOfEffect(int soundId, double volume) {
    return _invokeMethod(
        'setVolumeOfEffect', {'soundId': soundId, 'volume': volume});
  }

  @override
  Future<void> startAudioRecording(String filePath,
      AudioSampleRateType sampleRate, AudioRecordingQuality quality) {
    return _invokeMethod('startAudioRecording', {
      'filePath': filePath,
      'sampleRate': AudioSampleRateTypeConverter(sampleRate).value(),
      'quality': AudioRecordingQualityConverter(quality).value()
    });
  }

  @override
  Future<void> startChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration) {
    return _invokeMethod('startChannelMediaRelay', {
      'channelMediaRelayConfiguration': channelMediaRelayConfiguration.toJson()
    });
  }

  @override
  Future<void> startEchoTest(int intervalInSeconds) {
    return _invokeMethod(
        'startEchoTest', {'intervalInSeconds': intervalInSeconds});
  }

  @override
  Future<void> startLastmileProbeTest(LastmileProbeConfig config) {
    return _invokeMethod('startLastmileProbeTest', {'config': config.toJson()});
  }

  @override
  Future<void> stopAllEffects() {
    return _invokeMethod('stopAllEffects');
  }

  @override
  Future<void> stopAudioRecording() {
    return _invokeMethod('stopAudioRecording');
  }

  @override
  Future<void> stopChannelMediaRelay() {
    return _invokeMethod('stopChannelMediaRelay');
  }

  @override
  Future<void> stopEchoTest() {
    return _invokeMethod('stopEchoTest');
  }

  @override
  Future<void> stopEffect(int soundId) {
    return _invokeMethod('stopEffect', {'soundId': soundId});
  }

  @override
  Future<void> stopLastmileProbeTest() {
    return _invokeMethod('stopLastmileProbeTest');
  }

  @override
  Future<void> switchCamera() {
    return _invokeMethod('switchCamera');
  }

  @override
  Future<void> unloadEffect(int soundId) {
    return _invokeMethod('unloadEffect', {'soundId': soundId});
  }

  @override
  Future<void> unregisterMediaMetadataObserver() {
    return _invokeMethod('unregisterMediaMetadataObserver');
  }

  @override
  Future<void> updateChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration) {
    return _invokeMethod('updateChannelMediaRelay', {
      'channelMediaRelayConfiguration': channelMediaRelayConfiguration.toJson()
    });
  }

  @override
  Future<void> setAudioSessionOperationRestriction(
      AudioSessionOperationRestriction restriction) {
    return _invokeMethod('setAudioSessionOperationRestriction', {
      'restriction':
          AudioSessionOperationRestrictionConverter(restriction).value()
    });
  }

  @override
  Future<int> getNativeHandle() {
    return _invokeMethod('getNativeHandle');
  }
}

/// @nodoc
mixin RtcEngineInterface
    implements
        RtcUserInfoInterface,
        RtcAudioInterface,
        RtcVideoInterface,
        RtcAudioMixingInterface,
        RtcAudioEffectInterface,
        RtcVoiceChangerInterface,
        RtcVoicePositionInterface,
        RtcPublishStreamInterface,
        RtcMediaRelayInterface,
        RtcAudioRouteInterface,
        RtcEarMonitoringInterface,
        RtcDualStreamInterface,
        RtcFallbackInterface,
        RtcTestInterface,
        RtcMediaMetadataInterface,
        RtcWatermarkInterface,
        RtcEncryptionInterface,
        RtcAudioRecorderInterface,
        RtcInjectStreamInterface,
        RtcCameraInterface,
        RtcStreamMessageInterface {
  /// Destroys the [RtcEngine] instance and releases all resources used by the Agora SDK.
  ///
  /// This method is useful for apps that occasionally make voice or video calls, to free up resources for other operations when not making calls.
  ///
  /// **Note**
  /// - Call this method in the subthread.
  /// - Once the app calls [RtcEngine.destroy] to destroy the created [RtcEngine] instance, you cannot use any method or callback in the SDK.
  Future<void> destroy();

  /// Sets the channel profile of the Agora RtcEngine.
  ///
  /// The Agora RtcEngine differentiates channel profiles and applies different optimization algorithms accordingly. For example, it prioritizes smoothness and low latency for a video call, and prioritizes video quality for a video broadcast.
  ///
  /// **Parameter** [profile] The channel profile of the Agora RtcEngine. See [ChannelProfile].
  Future<void> setChannelProfile(ChannelProfile profile);

  /// Sets the role of a user ([ChannelProfile.LiveBroadcasting] only).
  ///
  /// This method sets the role of a user, such as a host or an audience (default), before joining a channel.
  /// This method can be used to switch the user role after a user joins a channel. In the [ChannelProfile.LiveBroadcasting] profile, when a user switches user roles after joining a channel, a successful `setClientRole` method call triggers the following callbacks:
  /// - The local client: [RtcEngineEventHandler.clientRoleChanged].
  /// - The remote client: [RtcEngineEventHandler.userJoined] or [RtcEngineEventHandler.userOffline] ([UserOfflineReason.BecomeAudience]).
  ///
  /// **Parameter** [role] Sets the role of a user. See [ClientRole].
  Future<void> setClientRole(ClientRole role);

  /// Allows a user to join a channel.
  ///
  /// Users in the same channel can talk to each other, and multiple users in the same channel can start a group chat. Users with different App IDs cannot call each other.
  /// You must call the [RtcEngine.leaveChannel] method to exit the current call before joining another channel.
  /// A successful joinChannel method call triggers the following callbacks:
  /// - The local client: [RtcEngineEventHandler.joinChannelSuccess].
  /// - The remote client: [RtcEngineEventHandler.userJoined], if the user joining the channel is in the [ChannelProfile.Communication] profile, or is a [ClientRole.Broadcaster] in the [ChannelProfile.LiveBroadcasting] profile.
  ///
  /// When the connection between the client and Agora's server is interrupted due to poor network conditions, the SDK tries reconnecting to the server. When the local client successfully rejoins the channel, the SDK triggers the [RtcEngineEventHandler.rejoinChannelSuccess] callback on the local client.
  ///
  /// **Note**
  /// - A channel does not accept duplicate uids, such as two users with the same uid. If you set uid as 0, the system automatically assigns a uid.
  ///
  /// **Warning**
  /// - Ensure that the App ID used for creating the token is the same App ID used in the create method for creating an [RtcEngine] object. Otherwise, CDN live streaming may fail.
  ///
  /// **Parameter** [token] The token for authentication:
  /// - In situations not requiring high security: You can use the temporary token generated at Console. For details, see [Get a temporary token](https://docs.agora.io/en/Agora%20Platform/token?platform=All%20Platforms#temptoken).
  /// - In situations requiring high security: Set it as the token generated at your server. For details, see [Get a token](https://docs.agora.io/en/Agora%20Platform/token?platform=All%20Platforms#generatetoken).
  ///
  /// **Parameter** [channelName] The unique channel name for the AgoraRTC session in the string format. The string length must be less than 64 bytes. Supported character scopes are:
  /// - All lowercase English letters: a to z.
  /// - All uppercase English letters: A to Z.
  /// - All numeric characters: 0 to 9.
  /// - The space character.
  /// - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
  ///
  /// **Parameter** [optionalInfo] Additional information about the channel. This parameter can be set as null or contain channel related information. Other users in the channel do not receive this message.
  ///
  /// **Parameter** [optionalUid] (Optional) User ID. `optionalUid` must be unique. If `optionalUid` is not assigned (or set to 0), the SDK assigns and returns uid in the [RtcEngineEventHandler.joinChannelSuccess] callback. Your app must record and maintain the returned uid since the SDK does not do so.
  Future<void> joinChannel(
      String token, String channelName, String optionalInfo, int optionalUid);

  /// Switches to a different channel.
  ///
  /// This method allows the audience of a [ChannelProfile.LiveBroadcasting] channel to switch to a different channel.
  /// After the user successfully switches to another channel, the [RtcEngineEventHandler.leaveChannel] and [RtcEngineEventHandler.joinChannelSuccess] callbacks are triggered to indicate that the user has left the original channel and joined a new one.
  ///
  /// **Note**
  /// - This method applies to the [ClientRole.Audience] role in a [ChannelProfile.LiveBroadcasting] channel only.
  ///
  /// **Parameter** [token] The token for authentication:
  /// - In situations not requiring high security: You can use the temporary token generated at Console. For details, see [Get a temporary token](https://docs.agora.io/en/Agora%20Platform/token?platform=All%20Platforms#temptoken).
  /// - In situations requiring high security: Set it as the token generated at your server. For details, see [Get a token](https://docs.agora.io/en/Agora%20Platform/token?platform=All%20Platforms#generatetoken).
  ///
  /// **Parameter** [channelName] Unique channel name for the AgoraRTC session in the string format. The string length must be less than 64 bytes. Supported character scopes are:
  /// - All lowercase English letters: a to z.
  /// - All uppercase English letters: A to Z.
  /// - All numeric characters: 0 to 9.
  /// - The space character.
  /// - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
  Future<void> switchChannel(String token, String channelName);

  /// Allows a user to leave a channel.
  ///
  /// After joining a channel, the user must call this method to end the call before joining another channel. This method returns 0 if the user leaves the channel and releases all resources related to the call. This method call is asynchronous, and the user has not exited the channel when the method call returns. Once the user leaves the channel, the SDK triggers the [RtcEngineEventHandler.leaveChannel] callback.
  /// A successful method call triggers the following callbacks:
  /// - The local client: [RtcEngineEventHandler.leaveChannel].
  /// - The remote client: [RtcEngineEventHandler.userOffline], if the user leaving the channel is in the [ChannelProfile.Communication] profile, or is a [ClientRole.Broadcaster] in the [ChannelProfile.LiveBroadcasting] profile.
  ///
  /// **Note**
  /// - If you call the [RtcEngine.destroy] method immediately after calling this method, the `leaveChannel` process interrupts, and the SDK does not trigger the [RtcEngineEventHandler.leaveChannel] callback.
  /// - If you call this method during CDN live streaming, the SDK triggers the [RtcEngine.removeInjectStreamUrl] method.
  Future<void> leaveChannel();

  /// Renews the token when the current token expires.
  ///
  /// The token expires after a period of time once the token schema is enabled when:
  /// - The SDK triggers the [RtcEngineEventHandler.tokenPrivilegeWillExpire] callback
  /// - The [RtcEngineEventHandler.connectionStateChanged] callback reports the [ConnectionChangedReason.TokenExpired] error.
  /// The app should retrieve a new token from the server and call this method to renew it. Failure to do so results in the SDK disconnecting from the server.
  ///
  /// **Parameter** [token] The new token.
  Future<void> renewToken(String token);

  /// Enables interoperability with the Agora Web SDK (LiveBroadcasting only).
  ///
  /// The SDK automatically enables interoperability with the Web SDK, so you no longer need to call this method.
  /// If the channel has Web SDK users, ensure that you call this method, or the video of the Native user will be a black screen for the Web user.
  /// Use this method when the channel profile is [ChannelProfile.LiveBroadcasting]. Interoperability with the Agora Web SDK is enabled by default when the channel profile is [ChannelProfile.Communication].
  ///
  /// **Parameter** [enabled] Sets whether to enable/disable interoperability with the Agora Web SDK:
  /// - `true`: Enable.
  /// - `false`: (Default) Disable.
  @deprecated
  Future<void> enableWebSdkInteroperability(bool enabled);

  /// Gets the connection state of the SDK.
  Future<ConnectionStateType> getConnectionState();

  /// Gets the current call ID.
  ///
  /// When a user joins a channel on a client, a call ID is generated to identify the call from the client. Feedback methods, such as the [RtcEngine.rate] and [RtcEngine.complain] method, must be called after the call ends to submit feedback to the SDK.
  ///
  /// The `rate` and `complain` methods require the `callId` parameter retrieved from the [RtcEngine.getCallId] method during a call. `callId` is passed as an argument into the rate and complain methods after the call ends.
  ///
  ///  **Returns**
  /// - The current call ID, if the method call succeeds.
  /// - The empty string "", if the method call fails.
  Future<String> getCallId();

  /// Allows the user to rate a call after the call ends.
  ///
  /// **Parameter** [callId] ID of the call retrieved from the [RtcEngine.getCallId] method.
  ///
  /// **Parameter** [rating] Rating of the call. The value is between 1 (lowest score) and 5 (highest score). If you set a value out of this range, the [ErrorCode.InvalidArgument] error occurs.
  ///
  /// **Parameter** [description] (Optional) The description of the rating. The string length must be less than 800 bytes.
  Future<void> rate(String callId, int rating, {String description});

  /// Allows a user to complain about the call quality after a call ends.
  ///
  /// **Parameter** [callId] ID of the call retrieved from the [RtcEngine.getCallId] method.
  ///
  /// **Parameter** [description] (Optional) The description of the complaint. The string length must be less than 800 bytes.
  Future<void> complain(String callId, String description);

  /// Specifies an SDK output log file.
  ///
  /// The log file records all log data for the SDK’s operation. Ensure that the directory for the log file exists and is writable.
  ///
  /// **Note**
  /// - Ensure that you call this method immediately after calling the [RtcEngine.create] method, otherwise the output log may not be complete.
  ///
  /// **Parameter** [filePath] File path of the log file. The string of the log file is in UTF-8. The default file path is `/storage/emulated/0/Android/data/<package name>="">/files/agorasdk.log`.
  Future<void> setLogFile(String filePath);

  /// Sets the output log level of the SDK.
  ///
  /// You can use one or a combination of the filters. The log level follows the sequence of `OFF`, `CRITICAL`, `ERROR`, `WARNING`, `INFO`, and `DEBUG`. Choose a level to see the logs preceding that level. For example, if you set the log level to `WARNING`, you see the logs within levels `CRITICAL`, `ERROR`, and `WARNING`.
  ///
  /// **Parameter** [filter] Sets the log filter level. See [LogFilter].
  Future<void> setLogFilter(LogFilter filter);

  /// Sets the log file size (KB).
  ///
  /// By default, the SDK outputs five log files, `agorasdk.log`, `agorasdk_1.log`, `agorasdk_2.log`, `agorasdk_3.log`, `agorasdk_4.log`, each with a default size of 1024 KB.
  ///
  /// These log files are encoded in UTF-8. The SDK writes the latest logs in `agorasdk.log`. When agorasdk.log is full, the SDK deletes the log file with the earliest modification time among the other four, renames agorasdk.log to the name of the deleted log file, and create a new `agorasdk.log` to record latest logs.
  ///
  /// **Parameter** [fileSizeInKBytes] The size (KB) of a log file. The default value is 1024 KB. If you set `fileSizeInKBytes` to 1024 KB, the SDK outputs at most 5 MB log files; if you set it to less than 1024 KB, the maximum size of a log file is still 1024 KB.
  Future<void> setLogFileSize(int fileSizeInKBytes);

  /// @nodoc Provides technical preview functionalities or special customizations by configuring the SDK with JSON options.
  ///
  /// The JSON options are not public by default. Agora is working on making commonly used JSON options public in a standard way.
  ///
  /// **Parameter** [parameters] Sets the parameter as a JSON string in the specified format.
  Future<void> setParameters(String parameters);

  /// Gets the native handle of the SDK engine.
  ///
  /// This interface is used to retrieve the native C++ handle of the SDK engine used in special scenarios, such as registering the audio and video frame observer.
  Future<int> getNativeHandle();
}

/// @nodoc
mixin RtcUserInfoInterface {
  /// Registers a user account.
  ///
  /// Once registered, the user account can be used to identify the local user when the user joins the channel. After the user successfully registers a user account, the SDK triggers the [RtcEngineEventHandler.localUserRegistered] callback on the local client, reporting the user ID and user account of the local user.
  ///
  /// To join a channel with a user account, you can choose either of the following:
  /// - Call the [RtcEngine.registerLocalUserAccount] method to create a user account, and then the [RtcEngine.joinChannelWithUserAccount] method to join the channel.
  /// - Call the [RtcEngine.joinChannelWithUserAccount] method to join the channel.
  /// The difference between the two is that for the former, the time elapsed between calling the [RtcEngine.joinChannelWithUserAccount] method and joining the channel is shorter than the latter.
  ///
  /// **Note**
  /// - Ensure that you set the [userAccount] parameter. Otherwise, this method does not take effect.
  /// - Ensure that the value of the userAccount parameter is unique in the channel.
  /// - To ensure smooth communication, use the same parameter type to identify the user. For example, if a user joins the channel with a user ID, then ensure all the other users use the user ID too. The same applies to the user account. If a user joins the channel with the Agora Web SDK, ensure that the uid of the user is set to the same parameter type.
  ///
  /// **Parameter** [appId] The App ID of your project.
  ///
  /// **Parameter** [userAccount] The user account. The maximum length of this parameter is 255 bytes. Ensure that you set this parameter and do not set it as null. Supported character scopes are:
  /// - All lowercase English letters: a to z.
  /// - All uppercase English letters: A to Z.
  /// - All numeric characters: 0 to 9.
  /// - The space character.
  /// - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
  Future<void> registerLocalUserAccount(String appId, String userAccount);

  /// Joins the channel with a user account.
  ///
  /// After the user successfully joins the channel, the SDK triggers the following callbacks:
  /// - The local client: [RtcEngineEventHandler.localUserRegistered] and [RtcEngineEventHandler.joinChannelSuccess].
  /// - The remote client: [RtcEngineEventHandler.userJoined] and [RtcEngineEventHandler.userInfoUpdated], if the user joining the channel is in the [ChannelProfile.Communication] profile, or is a [ClientRole.Broadcaster] in the [ChannelProfile.LiveBroadcasting] profile.
  ///
  /// **Note**
  /// - To ensure smooth communication, use the same parameter type to identify the user. For example, if a user joins the channel with a user ID, then ensure all the other users use the user ID too. The same applies to the user account. If a user joins the channel with the Agora Web SDK, ensure that the uid of the user is set to the same parameter type.
  ///
  /// **Parameter** [token] The token generated at your server:
  /// - In situations not requiring high security: You can use the temporary token generated at Console. For details, see [Get a temporary token](https://docs.agora.io/en/Agora%20Platform/token?platform=All%20Platforms#temptoken).
  /// - In situations requiring high security: Set it as the token generated at your server. For details, see [Get a token](https://docs.agora.io/en/Agora%20Platform/token?platform=All%20Platforms#generatetoken).
  ///
  /// **Parameter** [channelName] The channel name. The maximum length of this parameter is 64 bytes. Supported character scopes are:
  /// - All lowercase English letters: a to z.
  /// - All uppercase English letters: A to Z.
  /// - All numeric characters: 0 to 9.
  /// - The space character.
  /// - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
  ///
  /// **Parameter** [userAccount] The user account. The maximum length of this parameter is 255 bytes. Ensure that you set this parameter and do not set it as null.
  /// - All lowercase English letters: a to z.
  /// - All uppercase English letters: A to Z.
  /// - All numeric characters: 0 to 9.
  /// - The space character.
  /// - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
  Future<void> joinChannelWithUserAccount(
      String token, String channelName, String userAccount);

  /// Gets the user information by passing in the user account.
  ///
  /// After a remote user joins the channel, the SDK gets the user ID and user account of the remote user, caches them in a mapping table object ([UserInfo]), and triggers the [RtcEngineEventHandler.userInfoUpdated] callback on the local client.
  ///
  /// After receiving the [RtcEngineEventHandler.userInfoUpdated] callback, you can call this method to get the user ID of the remote user from the [UserInfo] object by passing in the user account.
  ///
  /// **Parameter** [userAccount] The user account of the user. Ensure that you set this parameter.
  ///
  /// **Returns**
  /// - [UserInfo], if successful.
  /// - Error code, if failed.
  ///   - [ErrorCode.InvalidArgument]
  ///   - [ErrorCode.NotReady]
  ///   - [ErrorCode.Refused]
  Future<UserInfo> getUserInfoByUserAccount(String userAccount);

  /// Gets the user information by passing in the user ID.
  ///
  /// After a remote user joins the channel, the SDK gets the user ID and user account of the remote user, caches them in a mapping table object ([UserInfo]), and triggers the [RtcEngineEventHandler.userInfoUpdated] callback on the local client.
  ///
  /// After receiving the [RtcEngineEventHandler.userInfoUpdated] callback, you can call this method to get the user ID of the remote user from the [UserInfo] object by passing in the user account.
  ///
  /// **Parameter** [uid] The user ID of the user. Ensure that you set this parameter.
  ///
  /// **Returns**
  /// - [UserInfo], if successful.
  /// - Error code, if failed.
  ///   - [ErrorCode.InvalidArgument]
  ///   - [ErrorCode.NotReady]
  ///   - [ErrorCode.Refused]
  Future<UserInfo> getUserInfoByUid(int uid);
}

/// @nodoc
mixin RtcAudioInterface {
  /// Enables the audio module.
  ///
  /// The audio module is enabled by default.
  ///
  /// **Note**
  /// - This method affects the internal engine and can be called after calling the [RtcEngine.leaveChannel] method. You can call this method either before or after joining a channel.
  /// - This method resets the internal engine and takes some time to take effect. We recommend using the following API methods to control the audio engine modules separately:
  ///   - [RtcEngine.enableLocalAudio]: Whether to enable the microphone to create the local audio stream.
  ///   - [RtcEngine.muteLocalAudioStream]: Whether to publish the local audio stream.
  ///   - [RtcEngine.muteRemoteAudioStream]: Whether to subscribe to and play the remote audio stream.
  ///   - [RtcEngine.muteAllRemoteAudioStreams]: Whether to subscribe to and play all remote audio streams.
  Future<void> enableAudio();

  /// Disables the audio module.
  ///
  /// **Note**
  /// - This method affects the internal engine and can be called after calling the [RtcEngine.leaveChannel] method. You can call this method either before or after joining a channel.
  /// - This method resets the engine and takes some time to take effect. We recommend using the following API methods to control the audio engine modules separately:
  ///   - [RtcEngine.enableLocalAudio]: Whether to enable the microphone to create the local audio stream.
  ///   - [RtcEngine.muteLocalAudioStream]: Whether to publish the local audio stream.
  ///   - [RtcEngine.muteRemoteAudioStream]: Whether to subscribe to and play the remote audio stream.
  ///   - [RtcEngine.muteAllRemoteAudioStreams]: Whether to subscribe to and play all remote audio streams.
  Future<void> disableAudio();

  /// Sets the audio parameters and application scenarios.
  ///
  /// **Note**
  /// - You must call this method before calling the joinChannel method.
  /// See [RtcEngine.joinChannel]
  /// - In the Communication and [ChannelProfile.LiveBroadcasting] profiles, the bitrates may be different from your settings due to network self-adaptation.
  /// - In scenarios requiring high-quality audio, we recommend setting profile as [AudioScenario.ShowRoom] and scenario as [AudioScenario.GameStreaming]. For example, for music education scenarios.
  ///
  /// **Parameter** [profile] Sets the sample rate, bitrate, encoding mode, and the number of channels. See [AudioProfile].
  ///
  /// **Parameter** [scenario] Sets the audio application scenarios. Under different audio scenarios, the device uses different volume tracks, i.e. either the in-call volume or the media volume. See [AudioScenario].
  Future<void> setAudioProfile(AudioProfile profile, AudioScenario scenario);

  /// Adjusts the recording volume.
  ///
  /// **Note**
  /// - To avoid echoes and improve call quality, Agora recommends setting the value of volume between 0 and 100. If you need to set the value higher than 100, contact support@agora.io first.
  ///
  /// **Parameter** [volume] Recording volume. The value ranges between 0 and 400:
  /// - 0: Mute.
  /// - 100: Original volume.
  /// - 400: (Maximum) Four times the original volume with signal-clipping protection.
  Future<void> adjustRecordingSignalVolume(int volume);

  /// Adjusts the playback volume of a specified remote user.
  ///
  /// You can call this method as many times as necessary to adjust the playback volume of different remote users, or to repeatedly adjust the playback volume of the same remote user.
  ///
  /// **Note**
  /// - Call this method after joining a channel.
  /// - The playback volume here refers to the mixed volume of a specified remote user.
  /// - This method can only adjust the playback volume of one specified remote user at a time. To adjust the playback volume of different remote users, call the method as many times, once for each remote user.
  ///
  /// **Parameter** [uid] ID of the remote user.
  ///
  /// **Parameter** [volume] The playback volume of the specified remote user. The value ranges from 0 to 100:
  /// - 0: Mute.
  /// - 100: The original volume.
  Future<void> adjustUserPlaybackSignalVolume(int uid, int volume);

  /// Adjusts the playback volume of all remote users.
  ///
  /// **Note**
  /// - This method adjusts the playback volume which is mixed volume of all remote users.
  /// - To mute the local audio playback, call both [RtcEngine.adjustPlaybackSignalVolume] and [RtcEngine.adjustAudioMixingVolume], and set volume as 0.
  /// - To avoid echoes and improve call quality, Agora recommends setting the value of volume between 0 and 100. If you need to set the value higher than 100, contact support@agora.io first.
  ///
  /// **Parameter** [volume] The playback volume of all remote users. The value ranges from 0 to 400:
  /// - 0: Mute.
  /// - 100: The original volume.
  /// - 400: (Maximum) Four times the original volume with signal clipping protection.
  Future<void> adjustPlaybackSignalVolume(int volume);

  /// Enables/Disables the local audio capture.
  ///
  /// The audio function is enabled by default. This method disables/re-enables the local audio function, that is, to stop or restart local audio capture and processing.
  ///
  /// This method does not affect receiving or playing the remote audio streams, and enableLocalAudio(false) is applicable to scenarios where the user wants to receive remote audio streams without sending any audio stream to other users in the channel.
  ///
  /// The SDK triggers the [RtcEngineEventHandler.microphoneEnabled] callback once the local audio function is disabled or re-enabled.
  ///
  /// **Note**
  /// - This method is different from the [RtcEngine.muteLocalAudioStream] method:
  ///   - [RtcEngine.enableLocalAudio]: Disables/Re-enables the local audio capture and processing. If you disable or re-enable local audio recording using the [RtcEngine.enableLocalAudio] method, the local user may hear a pause in the remote audio playback.
  ///   - [RtcEngine.muteLocalAudioStream]: Stops/Continues sending the local audio streams.
  ///
  /// **Parameter** [enabled] Sets whether to disable/re-enable the local audio function:
  /// - `true`: (Default) Re-enable the local audio function, that is, to start local audio capture and processing.
  /// - `false`: Disable the local audio function, that is, to stop local audio capture and processing.
  Future<void> enableLocalAudio(bool enabled);

  /// Stops/Resumes sending the local audio stream.
  ///
  /// A successful [RtcEngine.muteLocalAudioStream] method call triggers the [RtcEngineEventHandler.userMuteAudio] callback on the remote client.
  ///
  /// **Note**
  /// - When muted is set as true, this method does not disable the microphone and thus does not affect any ongoing recording.
  /// - If you call [RtcEngine.setChannelProfile] after this method, the SDK resets whether or not to mute the local audio according to the channel profile and user role. Therefore, we recommend calling this method after the [RtcEngine.setChannelProfile] method.
  ///
  /// **Parameter** [muted] Sets whether to send/stop sending the local audio stream:
  /// - `true`: Stop sending the local audio stream.
  /// - `false`: (Default) Send the local audio stream.
  Future<void> muteLocalAudioStream(bool muted);

  /// Stops/Resumes receiving a specified audio stream.
  ///
  /// **Note**
  /// - If you called the [RtcEngine.muteAllRemoteAudioStreams] method and set muted as true to stop receiving all remote video streams, ensure that the [RtcEngine.muteAllRemoteAudioStreams] method is called and set muted as false before calling this method. The [RtcEngine.muteAllRemoteAudioStreams] method sets all remote audio streams, while the [RtcEngine.muteRemoteAudioStream] method sets a specified remote user's audio stream.
  ///
  /// **Parameter** [uid] ID of the specified remote user.
  ///
  /// **Parameter** [muted] Sets whether to receive/stop receiving the specified remote user's audio stream:
  /// - `true`: Stop receiving the specified remote user’s audio stream.
  /// - `false`: (Default) Receive the specified remote user’s audio stream.
  Future<void> muteRemoteAudioStream(int uid, bool muted);

  /// Stops/Resumes receiving all remote audio streams.
  ///
  /// **Parameter** [muted] Sets whether to receive/stop receiving all remote audio streams:
  /// - `true`: Stop receiving all remote audio streams.
  /// - `false`: (Default) Receive all remote audio streams.
  Future<void> muteAllRemoteAudioStreams(bool muted);

  /// Sets whether to receive all remote audio streams by default.
  ///
  /// You can call this method either before or after joining a channel. If you call [RtcEngine.setDefaultMuteAllRemoteAudioStreams] (true) after joining a channel, you will not receive the audio streams of any subsequent user.
  ///
  /// **Note**
  /// - If you want to resume receiving audio streams, call [RtcEngine.muteRemoteAudioStream] (false), and specify the ID of the remote user that you want to subscribe to. To resume audio streams of multiple users, call [RtcEngine.muteRemoteAudioStream] as many times. Calling [RtcEngine.setDefaultMuteAllRemoteAudioStreams] (false) resumes receiving audio streams of the subsequent users only.
  ///
  /// **Parameter** [muted] Sets whether or not to receive/stop receiving the remote audio streams by default:
  /// - `true`: Stop receiving any audio stream by default.
  /// - `false`: (Default) Receive all remote audio streams by default.
  Future<void> setDefaultMuteAllRemoteAudioStreams(bool muted);

  /// Enables the [RtcEngineEventHandler.audioVolumeIndication] callback at a set time interval to report on which users are speaking and the speakers' volume.
  ///
  /// Once this method is enabled, the SDK returns the volume indication in the [RtcEngineEventHandler.audioVolumeIndication] callback at the set time interval, regardless of whether any user is speaking in the channel.
  ///
  /// **Parameter** [interval] Sets the time interval between two consecutive volume indications:
  /// - ≤ 0: Disables the volume indication.
  /// - > 0: Time interval (ms) between two consecutive volume indications. We recommend setting interval ≥ 200 ms.
  ///
  /// **Parameter** [smooth] The smoothing factor sets the sensitivity of the audio volume indicator. The value ranges between 0 and 10. The greater the value, the more sensitive the indicator. The recommended value is 3.
  ///
  /// **Parameter** [report_vad]
  /// - `true`: Enable the voice activity detection of the local user. Once it is enabled, the vad parameter of the [RtcEngineEventHandler.audioVolumeIndication] callback reports the voice activity status of the local user.
  /// - `false`: (Default) Disable the voice activity detection of the local user. Once it is enabled, the vad parameter of the [RtcEngineEventHandler.audioVolumeIndication] callback does not report the voice activity status of the local user, except for scenarios where the engine automatically detects the voice activity of the local user.
  Future<void> enableAudioVolumeIndication(
      int interval, int smooth, bool report_vad);
}

/// @nodoc
mixin RtcVideoInterface {
  /// Enables the video module.
  ///
  /// You can call this method either before joining a channel or during a call. If you call this method before joining a channel, the service starts in the video mode. If you call this method during an audio call, the audio mode switches to the video mode.
  ///
  /// A successful enableVideo method call triggers the [RtcEngineEventHandler.userEnableVideo] (true) callback on the remote client.
  ///
  /// To disable the video, call the [RtcEngine.disableVideo] method.
  ///
  /// **Note**
  /// - This method affects the internal engine and can be called after calling the [RtcEngine.leaveChannel] method. You can call this method either before or after joining a channel.
  /// - This method resets the internal engine and takes some time to take effect. We recommend using the following API methods to control the video engine modules separately:
  ///   - [RtcEngine.enableLocalVideo]: Whether to enable the camera to create the local video stream.
  ///   - [RtcEngine.muteLocalVideoStream]: Whether to publish the local video stream.
  ///   - [RtcEngine.muteRemoteVideoStream]: Whether to subscribe to and play the remote video stream.
  ///   - [RtcEngine.muteAllRemoteVideoStreams]: Whether to subscribe to and play all remote video streams.
  Future<void> enableVideo();

  /// Disables the video module.
  ///
  /// You can call this method before joining a channel or during a call. If you call this method before joining a channel, the service starts in audio mode. If you call this method during a video call, the video mode switches to the audio mode.
  /// - A successful disableVideo method call triggers the [RtcEngineEventHandler.userEnableVideo] (false) callback on the remote client.
  /// - To enable the video mode, call the [RtcEngine.enableVideo] method.
  ///
  /// **Note**
  /// - This method affects the internal engine and can be called after calling the [RtcEngine.leaveChannel] method. You can call this method either before or after joining a channel.
  /// - This method resets the internal engine and takes some time to take effect. We recommend using the following API methods to control the video engine modules separately:
  ///   - [RtcEngine.enableLocalVideo]: Whether to enable the camera to create the local video stream.
  ///   - [RtcEngine.muteLocalVideoStream]: Whether to publish the local video stream.
  ///   - [RtcEngine.muteRemoteVideoStream]: Whether to subscribe to and play the remote video stream.
  ///   - [RtcEngine.muteAllRemoteVideoStreams]: Whether to subscribe to and play all remote video streams.
  Future<void> disableVideo();

  /// Sets the video encoder configuration.
  ///
  /// Each video encoder configuration corresponds to a set of video parameters, including the resolution, frame rate, bitrate, and video orientation. The parameters specified in this method are the maximum values under ideal network conditions. If the video engine cannot render the video using the specified parameters due to poor network conditions, the parameters further down the list are considered until a successful configuration is found.
  /// If you do not set the video encoder configuration after joining the channel, you can call this method before calling the [RtcEngine.enableVideo] method to reduce the render time of the first video frame.
  ///
  /// **Parameter** [config] The local video encoder configuration. See [VideoEncoderConfiguration].
  Future<void> setVideoEncoderConfiguration(VideoEncoderConfiguration config);

  /// Starts the local video preview before joining a channel.
  ///
  /// Before calling this method, you must:
  /// - Create the RtcLocalView.
  ///   - (Android only) See [TextureView] and [SurfaceView].
  ///   - (iOS only) See [UIView](https://developer.apple.com/documentation/uikit/uiview).
  /// - Call the [RtcEngine.enableVideo] method to enable the video.
  ///
  /// **Note**
  /// - By default, the local preview enables the mirror mode.
  /// - Once you call this method to start the local video preview, if you leave the channel by calling the [RtcEngine.leaveChannel] method, the local video preview remains until you call the [RtcEngine.stopPreview] method to disable it.
  Future<void> startPreview();

  /// Stops the local video preview and the video.
  Future<void> stopPreview();

  /// Disables/Re-enables the local video capture.
  ///
  /// This method disables or re-enables the local video capturer, and does not affect receiving the remote video stream.
  ///
  /// After you call the [RtcEngine.enableVideo] method, the local video capturer is enabled by default. You can call [RtcEngine.enableVideo] (false) to disable the local video capturer. If you want to re-enable it, call [RtcEngine.enableVideo] (true).
  ///
  /// After the local video capturer is successfully disabled or re-enabled, the SDK triggers the [RtcEngineEventHandler.userEnableLocalVideo] callback on the remote client.
  ///
  /// **Note**
  /// - This method affects the internal engine and can be called after calling  the [RtcEngine.leaveChannel] method.
  ///
  /// **Parameter** [enabled] Sets whether to disable/re-enable the local video, including the capturer, renderer, and sender:
  /// - `true`: (Default) Re-enable the local video.
  /// - `false`: Disable the local video. Once the local video is disabled, the remote users can no longer receive the video stream of this user, while this user can still receive the video streams of other remote users. When you set enabled as false, this method does not require a local camera.
  Future<void> enableLocalVideo(bool enabled);

  /// Stops/Resumes sending the local video stream.
  ///
  /// A successful `muteLocalVideoStream` method call triggers the [RtcEngineEventHandler.userMuteVideo] callback on the remote client.
  ///
  /// **Note**
  /// - When you set muted as true, this method does not disable the camera and thus does not affect the retrieval of the local video streams. This method responds faster than calling the [RtcEngine.enableLocalVideo] method and set muted as false, which controls sending the local video stream.
  /// - If you call [RtcEngine.setChannelProfile] after this method, the SDK resets whether or not to mute the local video according to the channel profile and user role. Therefore, we recommend calling this method after the [RtcEngine.setChannelProfile] method.
  ///
  /// **Parameter** [muted] Sets whether to send/stop sending the local video stream:
  /// - `true`: Stop sending the local video stream.
  /// - `false`: (Default) Send the local video stream.
  Future<void> muteLocalVideoStream(bool muted);

  /// Stops/Resumes receiving a specified remote user's video stream.
  ///
  /// **Note**
  /// - If you call the [RtcEngine.muteAllRemoteVideoStreams] method and set set muted as true to stop receiving all remote video streams, ensure that the [RtcEngine.muteAllRemoteVideoStreams] method is called and set muted as false before calling this method. The [RtcEngine.muteAllRemoteVideoStreams] method sets all remote streams, while this method sets a specified remote user's stream.
  ///
  /// **Parameter** [uid] User ID of the specified remote user.
  ///
  /// **Parameter** [muted] Sets whether to receive/stop receiving a specified remote user's video stream:
  /// - `true`: Stop receiving a specified remote user’s video stream.
  /// - `false`: (Default) Receive a specified remote user’s video stream.
  Future<void> muteRemoteVideoStream(int uid, bool muted);

  /// Stops/Resumes receiving all remote video streams.
  ///
  /// **Parameter** [muted] Sets whether to receive/stop receiving all remote video streams:
  /// - `true`: Stop receiving all remote video streams.
  /// - `false`: (Default) Receive all remote video streams.
  Future<void> muteAllRemoteVideoStreams(bool muted);

  /// Sets whether to receive all remote video streams by default.
  ///
  /// You can call this method either before or after joining a channel. If you call `setDefaultMuteAllRemoteVideoStreams`(true) after joining a channel, you will not receive the video stream of any subsequent user.
  ///
  /// **Note**
  /// - If you want to resume receiving video streams, call [RtcEngine.muteRemoteVideoStream] (false), and specify the ID of the remote user that you want to subscribe to. To resume receiving video streams of multiple users, call [RtcEngine.muteRemoteVideoStream] as many times. Calling `setDefaultMuteAllRemoteVideoStreams`(false) resumes receiving video streams of the subsequent users only.
  ///
  /// **Parameter** [muted] Sets whether to receive/stop receiving all remote video streams by default:
  /// - `true`: Stop receiving any remote video stream by default.
  /// - `false`: (Default) Receive all remote video streams by default.
  Future<void> setDefaultMuteAllRemoteVideoStreams(bool muted);

  /// Enables/Disables image enhancement and sets the options.
  ///
  /// **Note**
  /// - Call this method after calling [RtcEngine.enableVideo].
  /// - This method supports both Android and iOS. For Android, this method applies to Android 4.4 or later.
  ///
  /// **Parameter** [enabled] Sets whether or not to enable image enhancement:
  /// - enables image enhancement.
  /// - disables image enhancement.
  ///
  /// **Parameter** [options] The image enhancement options. See [BeautyOptions].
  Future<void> setBeautyEffectOptions(bool enabled, BeautyOptions options);
}

/// @nodoc
mixin RtcAudioMixingInterface {
  /// Starts playing and mixing the music file.
  ///
  /// This method mixes the specified local or online audio file with the audio stream from the microphone, or replaces the microphone’s audio stream with the specified local or remote audio file. You can choose whether the other user can hear the local audio playback and specify the number of playback loops. When the audio mixing file playback finishes after calling this method, the SDK triggers the [RtcEngineEventHandler.audioMixingFinished] callback.
  ///
  /// A successful `startAudioMixing` method call triggers the [RtcEngineEventHandler.audioMixingStateChanged] ([AudioMixingStateCode.Playing]) callback on the local client.
  ///
  /// When the audio mixing file playback finishes, the SDK triggers the [RtcEngineEventHandler.audioMixingStateChanged] ([AudioMixingStateCode.Stopped]) callback on the local client.
  ///
  /// **Note**
  /// - This method supports both Android and iOS. To use this method in Android, ensure that the Android device is v4.2 or later, and the API version is v16 or later.
  /// - Call this method when you are in the channel, otherwise it may cause issues.
  /// - If you want to play an online music file, ensure that the time interval between calling this method is more than 100 ms, or the [AudioMixingErrorCode.TooFrequentCall] error occurs.
  /// - If you want to play an online music file, Agora does not recommend using the redirected URL address. Some Android devices may fail to open a redirected URL address.
  /// - If the local audio mixing file does not exist, or if the SDK does not support the file format or cannot access the music file URL, the SDK returns [AudioMixingErrorCode.CanNotOpen].
  /// - If you call this method on an emulator, only the MP3 file format is supported.
  ///
  /// **Parameter** [filePath] Specifies the absolute path (including the suffixes of the filename) of the local or online audio file to be mixed. For example, `/sdcard/emulated/0/audio.mp4`. Supported audio formats: mp3, mp4, m4a, aac, 3gp, mkv, and wav.
  /// - If the path begins with `/assets/`, the audio file is in the `/assets/` directory.
  /// - Otherwise, the audio file is in the absolute path.
  ///
  /// **Parameter** [loopback] Sets which user can hear the audio mixing:
  /// - `true`: Only the local user can hear the audio mixing.
  /// - `false`: Both users can hear the audio mixing.
  ///
  /// **Parameter** [replace] Sets the audio mixing content:
  /// - `true`: Only publish the specified audio file; the audio stream from the microphone is not published.
  /// - `false`: The local audio file is mixed with the audio stream from the microphone.
  ///
  /// **Parameter** [cycle] Sets the number of playback loops:
  /// - Positive integer: Number of playback loops
  /// - -1: Infinite playback loops
  Future<void> startAudioMixing(
      String filePath, bool loopback, bool replace, int cycle);

  /// Stops playing or mixing the music file.
  ///
  /// Call this method when you are in a channel.
  Future<void> stopAudioMixing();

  /// Pauses playing and mixing the music file.
  ///
  /// Call this method when you are in a channel.
  Future<void> pauseAudioMixing();

  /// Resumes playing and mixing the music file.
  ///
  /// Call this method when you are in a channel.
  Future<void> resumeAudioMixing();

  /// Adjusts the volume of audio mixing.
  ///
  /// Call this method when you are in a channel.
  ///
  /// **Note**
  /// - Calling this method does not affect the volume of the audio effect file playback invoked by the [RtcEngine.playEffect] method.
  ///
  /// **Parameter** [volume] Audio mixing volume. The value ranges between 0 and 100 (default).
  Future<void> adjustAudioMixingVolume(int volume);

  /// Adjusts the volume of audio mixing for local playback.
  ///
  /// Call this method when you are in a channel.
  ///
  /// **Parameter** [volume] Audio mixing volume for local playback. The value ranges between 0 and 100 (default).
  Future<void> adjustAudioMixingPlayoutVolume(int volume);

  /// Adjusts the volume of audio mixing for publishing (sending to other users).
  ///
  /// Call this method when you are in a channel.
  ///
  /// **Parameter** [volume] Audio mixing volume for publishing. The value ranges between 0 and 100 (default).
  Future<void> adjustAudioMixingPublishVolume(int volume);

  /// Gets the audio mixing volume for local playback.
  ///
  /// This method helps troubleshoot audio volume related issues.
  ///
  /// **Returns**
  /// - The audio mixing volume for local playback, if the method call is successful. The value range is [0,100].
  /// - < 0: Failure.
  Future<int> getAudioMixingPlayoutVolume();

  /// Gets the audio mixing volume for publishing.
  ///
  /// This method helps troubleshoot audio volume related issues.
  ///
  /// **Returns**
  /// - The audio mixing volume for publishing, if the method call is successful. The value range is [0,100].
  /// - < 0: Failure.
  Future<int> getAudioMixingPublishVolume();

  /// Gets the duration (ms) of the music file.
  ///
  /// Call this method when you are in a channel.
  ///
  /// **Returns**
  /// - The audio mixing duration, if this method call is successful.
  /// - < 0: Failure.
  Future<int> getAudioMixingDuration();

  /// Gets the playback position (ms) of the music file.
  ///
  /// Call this method when you are in a channel.
  ///
  /// **Returns**
  /// - The current playback position of the audio mixing file, if this method call is successful.
  /// - < 0: Failure.
  Future<int> getAudioMixingCurrentPosition();

  /// Sets the playback position (ms) of the music file to a different starting position (the default plays from the beginning).
  ///
  /// **Parameter** [pos] The playback starting position (ms) of the audio mixing file.
  Future<void> setAudioMixingPosition(int pos);
}

/// @nodoc
mixin RtcAudioEffectInterface {
  /// Gets the volume of the audio effects.
  ///
  /// The value ranges between 0.0 and 100.0.
  Future<double> getEffectsVolume();

  /// Sets the volume of the audio effects.
  ///
  /// **Parameter** [volume] Volume of the audio effects. The value ranges between 0.0 and 100.0 (default).
  Future<void> setEffectsVolume(double volume);

  /// Sets the volume of a specified audio effect.
  ///
  /// **Parameter** [soundId] ID of the audio effect. Each audio effect has a unique ID.
  ///
  /// **Parameter** [volume] Volume of the audio effect. The value ranges between 0.0 and 100.0 (default).
  Future<void> setVolumeOfEffect(int soundId, double volume);

  /// Plays a specified local or online audio effect file.
  ///
  /// With this method, you can set the loop count, pitch, pan, and gain of the audio effect file and whether the remote user can hear the audio effect.
  ///
  /// To play multiple audio effect files simultaneously, call this method multiple times with different soundIds and filePaths. We recommend playing no more than three audio effect files at the same time.
  ///
  /// When the audio effect file playback is finished, the SDK triggers the [RtcEngineEventHandler.audioEffectFinished] callback.
  ///
  /// **Parameter** [soundId] ID of the specified audio effect. Each audio effect has a unique ID. If you preloaded the audio effect into the memory through the [RtcEngine.preloadEffect] method, ensure that the soundID value is set to the same value as in the [RtcEngine.preloadEffect] method.
  ///
  /// **Parameter** [filePath] The absolute file path (including the suffixes of the filename) of the audio effect file or the URL of the online audio effect file. For example, `/sdcard/emulated/0/audio.mp4`. Supported audio formats: mp3, mp4, m4a, aac. 3gp, mkv, and wav.
  ///
  /// **Parameter** [loopCount] Sets the number of times the audio effect loops:
  /// - 0: Plays the audio effect once.
  /// - 1: Plays the audio effect twice.
  /// - -1: Plays the audio effect in a loop indefinitely, until you call the [RtcEngine.stopEffect] or [RtcEngine.stopAllEffects] method.
  ///
  /// **Parameter** [pitch] Sets the pitch of the audio effect. The value ranges between 0.5 and 2. The default value is 1 (no change to the pitch). The lower the value, the lower the pitch.
  ///
  /// **Parameter** [pan] Sets the spatial position of the audio effect. The value ranges between -1.0 and 1.0.
  /// - 0.0: The audio effect shows ahead.
  /// - 1.0: The audio effect shows on the right.
  /// - -1.0: The audio effect shows on the left.
  ///
  /// **Parameter** [gain] Sets the volume of the audio effect. The value ranges between 0.0 and 100,0. The default value is 100.0. The lower the value, the lower the volume of the audio effect.
  ///
  /// **Parameter** [publish] Set whether or not to publish the specified audio effect to the remote stream:
  /// - `true`: The locally played audio effect is published to the Agora Cloud and the remote users can hear it.
  /// - `false`: The locally played audio effect is not published to the Agora Cloud and the remote users cannot hear it.
  Future<void> playEffect(int soundId, String filePath, int loopCount,
      double pitch, double pan, double gain, bool publish);

  /// Stops playing a specified audio effect.
  ///
  /// **Note**
  /// - If you preloaded the audio effect into the memory through the [RtcEngine.preloadEffect] method, ensure that the `soundID` value is set to the same value as in the [RtcEngine.preloadEffect] method.
  ///
  /// **Parameter** [soundId] ID of the specified audio effect. Each audio effect has a unique ID.
  Future<void> stopEffect(int soundId);

  /// Stops playing all audio effects.
  Future<void> stopAllEffects();

  /// Preloads a specified audio effect file into the memory.
  ///
  /// Supported audio formats: mp3, aac, m4a, 3gp, wav.
  ///
  /// **Note**
  /// - This method does not support online audio effect files.
  ///
  /// **Note**
  /// - To ensure smooth communication, limit the size of the audio effect file. We recommend using this method to preload the audio effect before calling the [RtcEngine.joinChannel] method.
  ///
  /// **Parameter** [soundId] ID of the audio effect. Each audio effect has a unique ID.
  ///
  /// **Parameter** [filePath] Absolute path of the audio effect file.
  Future<void> preloadEffect(int soundId, String filePath);

  /// Releases a specified preloaded audio effect from the memory.
  ///
  /// **Parameter** [soundId] ID of the audio effect. Each audio effect has a unique ID.
  Future<void> unloadEffect(int soundId);

  /// Pauses a specified audio effect.
  ///
  /// **Parameter** [soundId] ID of the audio effect. Each audio effect has a unique ID.
  Future<void> pauseEffect(int soundId);

  /// Pauses all audio effects.
  Future<void> pauseAllEffects();

  /// Resumes playing a specified audio effect.
  ///
  /// **Parameter** [soundId] ID of the audio effect. Each audio effect has a unique ID.
  Future<void> resumeEffect(int soundId);

  /// Resumes playing all audio effects.
  Future<void> resumeAllEffects();

  /// The SDK and the app can both configure the audio session by default. The app may occasionally use other apps or third-party components to manipulate the audio session and restrict the SDK from doing so. This method allows the app to restrict the SDK’s manipulation of the audio session.
  ///
  /// You can call this method at any time to return the control of the audio sessions to the SDK.
  ///
  /// **Note**
  /// - This method restricts the SDK’s manipulation of the audio session. Any operation to the audio session relies solely on the app, other apps, or third-party components.
  ///
  /// **Parameter** [restriction] The operational restriction (bit mask) of the SDK on the audio session. See [AudioSessionOperationRestriction].
  Future<void> setAudioSessionOperationRestriction(
      AudioSessionOperationRestriction restriction);
}

/// @nodoc
mixin RtcVoiceChangerInterface {
  /// Sets the local voice changer option.
  ///
  /// **Note**
  /// - Do not use this method together with [RtcEngine.setLocalVoiceReverbPreset], or the method called earlier does not take effect.
  ///
  /// **Parameter** [voiceChanger] The local voice changer option. See [AudioVoiceChanger].
  Future<void> setLocalVoiceChanger(AudioVoiceChanger voiceChanger);

  /// Sets the preset local voice reverberation effect
  ///
  /// **Note**
  /// - Do not use this method together with [RtcEngine.setLocalVoiceReverb].
  /// - Do not use this method together with [RtcEngine.setLocalVoiceChanger], or the method called eariler does not take effect.
  ///
  /// **Parameter** [preset] The local voice reverberation preset. See See [AudioReverbPreset].
  Future<void> setLocalVoiceReverbPreset(AudioReverbPreset preset);

  /// Changes the voice pitch of the local speaker.
  ///
  /// **Parameter** [pitch] Sets the voice pitch. The value ranges between 0.5 and 2.0. The lower the value, the lower the voice pitch. The default value is 1.0 (no change to the local voice pitch).
  Future<void> setLocalVoicePitch(double pitch);

  /// Sets the local voice equalization effect.
  ///
  /// **Parameter** [bandFrequency] Sets the band frequency. The value ranges between 0 and 9; representing the respective 10-band center frequencies of the voice effects, including 31, 62, 125, 500, 1k, 2k, 4k, 8k, and 16k Hz.
  /// See [AudioEqualizationBandFrequency]
  ///
  /// **Parameter** [bandGain] Sets the gain of each band (dB). The value ranges between -15 and 15. The default value is 0.
  Future<void> setLocalVoiceEqualization(
      AudioEqualizationBandFrequency bandFrequency, int bandGain);

  /// Sets the local voice reverberation.
  ///
  /// **Note**
  /// - Adds the [RtcEngine.setLocalVoiceReverbPreset] method, a more user-friendly method for setting the local voice reverberation. You can use this method to set the local reverberation effect, such as Popular, R&B, Rock, Hip-hop, and more.
  ///
  /// **Parameter** [reverbKey] Sets the reverberation key. This method contains five reverberation keys. For details, see the description of each value in [AudioReverbType].
  ///
  /// **Parameter** [value] Sets the local voice reverberation value.
  Future<void> setLocalVoiceReverb(AudioReverbType reverbKey, int value);
}

/// @nodoc
mixin RtcVoicePositionInterface {
  /// Enables/Disables stereo panning for remote users.
  ///
  /// Ensure that you call this method before [RtcEngine.joinChannel] to enable stereo panning for remote users so that the local user can track the position of a remote user by calling [RtcEngine.setRemoteVoicePosition].
  ///
  /// **Parameter** [enabled] Sets whether or not to enable stereo panning for remote users:
  /// - `true`: enables stereo panning.
  /// - `false`: disables stereo panning.
  Future<void> enableSoundPositionIndication(bool enabled);

  /// Sets the sound position of a remote user.
  /// When the local user calls this method to set the sound position of a remote user, the sound difference between the left and right channels allows the local user to track the real-time position of the remote user, creating a real sense of space. This method applies to massively multiplayer online games, such as Battle Royale games.
  ///
  /// **Note**
  /// - For this method to work, enable stereo panning for remote users by calling the [RtcEngine.enableSoundPositionIndication] method before joining a channel.
  /// - This method requires hardware support. For the best sound positioning, we recommend using a stereo headset.
  ///
  /// **Parameter** [uid] The ID of the remote user.
  ///
  /// **Parameter** [pan] The sound position of the remote user. The value ranges from -1.0 to 1.0:
  /// - 0.0: The remote sound comes from the front.
  /// - -1.0: The remote sound comes from the left.
  /// - 1.0: The remote sound comes from the right.
  ///
  /// **Parameter** [gain] Gain of the remote user. The value ranges from 0.0 to 100.0. The default value is 100.0 (the original gain of the remote user). The smaller the value, the less the gain.
  Future<void> setRemoteVoicePosition(int uid, double pan, double gain);
}

/// @nodoc
mixin RtcPublishStreamInterface {
  /// Sets the video layout and audio settings for CDN live.
  ///
  /// The SDK triggers the [RtcEngineEventHandler.transcodingUpdated] callback when you call this method to update the [LiveTranscoding] class. If you call this method to set the [LiveTranscoding] class for the first time, the SDK does not trigger the [RtcEngineEventHandler.transcodingUpdated] callback.
  ///
  /// **Note**
  /// - Before calling the methods listed in this section:
  ///   - This method applies to [ChannelProfile.LiveBroadcasting] only.
  ///   - Ensure that you enable the RTMP Converter service before using this function. See Prerequisites in *Push Streams to CDN*.
  ///   - Ensure that you call the [RtcEngine.setClientRole] method and set the user role as the host.
  ///   - Ensure that you call the `setLiveTranscoding` method before calling the [RtcEngine.addPublishStreamUrl] method.
  ///
  /// **Parameter** [transcoding] Sets the CDN live audio/video transcoding settings. See [LiveTranscoding].
  Future<void> setLiveTranscoding(LiveTranscoding transcoding);

  /// Publishes the local stream to the CDN.
  ///
  /// The addPublishStreamUrl method call triggers the [RtcEngineEventHandler.rtmpStreamingStateChanged] callback on the local client to report the state of adding a local stream to the CDN.
  ///
  /// **Note**
  /// - Ensure that you enable the RTMP Converter service before using this function. See Prerequisites in *Push Streams to CDN*.
  /// - This method applies to LiveBroadcasting only.
  /// - Ensure that the user joins a channel before calling this method.
  /// - This method adds only one stream HTTP/HTTPS URL address each time it is called.
  ///
  /// **Parameter** [url] The CDN streaming URL in the RTMP format. The maximum length of this parameter is 1024 bytes. The URL address must not contain special characters, such as Chinese language characters.
  ///
  /// **Parameter** [transcodingEnabled] Sets whether transcoding is enabled/disabled. If you set this parameter as true, ensure that you call the setLiveTranscoding method before this method.
  /// See [RtcEngine.setLiveTranscoding]
  /// - `true`: Enable transcoding. To transcode the audio or video streams when publishing them to CDN live, often used for combining the audio and video streams of multiple hosts in CDN live.
  /// - `false`: Disable transcoding.
  Future<void> addPublishStreamUrl(String url, bool transcodingEnabled);

  /// Removes an RTMP stream from the CDN.
  ///
  /// This method removes the RTMP URL address (added by [RtcEngine.addPublishStreamUrl]) from a CDN live stream. The SDK reports the result of this method call in the [RtcEngineEventHandler.rtmpStreamingStateChanged] callback.
  ///
  /// **Note**
  /// - Ensure that you enable the RTMP Converter service before using this function. See Prerequisites in *Push Streams to CDN*.
  /// - Ensure that the user joins a channel before calling this method.
  /// - This method applies to LiveBroadcasting only.
  /// - This method removes only one stream RTMP URL address each time it is called.
  ///
  /// **Parameter** [url] The RTMP URL address to be removed. The maximum length of this parameter is 1024 bytes. The URL address must not contain special characters, such as Chinese language characters.
  Future<void> removePublishStreamUrl(String url);
}

/// @nodoc
mixin RtcMediaRelayInterface {
  /// Starts to relay media streams across channels.
  ///
  /// After a successful method call, the SDK triggers the [RtcEngineEventHandler.channelMediaRelayStateChanged] and [RtcEngineEventHandler.channelMediaRelayEvent] callbacks, and these callbacks return the state and events of the media stream relay.
  /// - If the [RtcEngineEventHandler.channelMediaRelayStateChanged] callback returns [ChannelMediaRelayState.Running] and [ChannelMediaRelayError.None], and the [RtcEngineEventHandler.channelMediaRelayEvent] callback returns [ChannelMediaRelayEvent.SentToDestinationChannel], the SDK starts relaying media streams between the original and the destination channel.
  /// - If the [RtcEngineEventHandler.channelMediaRelayStateChanged] callback returns [ChannelMediaRelayState.Failure], an exception occurs during the media stream relay.
  ///
  /// **Note**
  /// - Contact sales-us@agora.io before implementing this function.
  /// - We do not support string user accounts in this API.
  /// - Call this method after the [RtcEngine.joinChannel] method.
  /// - This method takes effect only when you are a [ClientRole.Broadcaster] in a [ChannelProfile.LiveBroadcasting] channel.
  /// - After a successful method call, if you want to call this method again, ensure that you call the [RtcEngine.stopChannelMediaRelay] method to quit the current relay.
  ///
  /// **Parameter** [channelMediaRelayConfiguration] The configuration of the media stream relay.
  Future<void> startChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration);

  /// Updates the channels for media relay.
  ///
  /// After the channel media relay starts, if you want to relay the media stream to more channels, or leave the current relay channel, you can call the `updateChannelMediaRelay` method.
  ///
  /// After a successful method call, the SDK triggers the [RtcEngineEventHandler.channelMediaRelayEvent] callback with the [ChannelMediaRelayEvent.UpdateDestinationChannel] state code.
  ///
  /// **Note**
  /// - Call this method after the [RtcEngine.startChannelMediaRelay] method to update the destination channel.
  /// - This method supports adding at most four destination channels in the relay. If there are already four destination channels in the relay.
  ///
  /// **Parameter** [channelMediaRelayConfiguration] The media stream relay configuration. See [ChannelMediaRelayConfiguration].
  Future<void> updateChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration);

  /// Stops the media stream relay.
  ///
  /// Once the relay stops, the broadcaster quits all the destination channels.
  ///
  /// After a successful method call, the SDK triggers the [RtcEngineEventHandler.channelMediaRelayStateChanged] callback. If the callback returns [ChannelMediaRelayState.Idle] and [ChannelMediaRelayError.None], the [ClientRole.Broadcaster] successfully stops the relay.
  ///
  /// **Note**
  /// - If the method call fails, the SDK triggers the [RtcEngineEventHandler.channelMediaRelayStateChanged] callback with the [ChannelMediaRelayError.ServerNoResponse] or [ChannelMediaRelayError.ServerConnectionLost] state code. You can leave the channel by calling the [RtcEngine.leaveChannel] method, and the media stream relay automatically stops.
  Future<void> stopChannelMediaRelay();
}

/// @nodoc
mixin RtcAudioRouteInterface {
  /// Sets the default audio playback route.
  ///
  /// This method sets whether the received audio is routed to the earpiece or speakerphone by default before joining a channel. If a user does not call this method, the audio is routed to the earpiece by default. If you need to change the default audio route after joining a channel, call the [RtcEngine.setEnableSpeakerphone] method.
  /// The default audio route for each scenario:
  /// - In the [ChannelProfile.Communication] profile:
  ///   - For a voice call, the default audio route is the earpiece.
  ///   - For a video call, the default audio route is the speaker. If the user disables the video using [RtcEngine.disableVideo], or [RtcEngine.muteLocalVideoStream] and [RtcEngine.muteAllRemoteVideoStreams], the default audio route automatically switches back to the earpiece.
  /// - In the [ChannelProfile.LiveBroadcasting] profile: The default audio route is the speaker.
  /// See [ChannelProfile.LiveBroadcasting]
  ///
  /// **Note**
  /// - This method applies to the [ChannelProfile.Communication] profile only.
  /// - Call this method before the user joins a channel.
  ///
  /// **Parameter** [defaultToSpeaker] Sets the default audio route:
  /// - `true`: Route the audio to the speaker. If the playback device connects to the earpiece or Bluetooth, the audio cannot be routed to the earpiece.
  /// - `false`: (Default) Route the audio to the earpiece. If a headset is plugged in, the audio is routed to the headset.
  Future<void> setDefaultAudioRoutetoSpeakerphone(bool defaultToSpeaker);

  /// Enables/Disables the audio playback route to the speakerphone.
  ///
  /// This method sets whether the audio is routed to the speakerphone or earpiece. After calling this method, the SDK returns the [RtcEngineEventHandler.audioRouteChanged] callback to indicate the changes.
  ///
  /// **Note**
  /// - Ensure that you have successfully called the [RtcEngine.joinChannel] method before calling this method.
  /// - This method is invalid for audience users in the [ChannelProfile.LiveBroadcasting] profile.
  ///
  /// **Parameter** [enabled] Sets whether to route the audio to the speakerphone or earpiece:
  /// - `true`: Route the audio to the speakerphone.
  /// - `false`: Route the audio to the earpiece. If the headset is plugged in, the audio is routed to the headset.
  Future<void> setEnableSpeakerphone(bool enabled);

  /// Checks whether the speakerphone is enabled.
  Future<bool> isSpeakerphoneEnabled();
}

/// @nodoc
mixin RtcEarMonitoringInterface {
  /// Enables in-ear monitoring.
  ///
  /// **Parameter** [enabled] Sets whether to enable/disable in-ear monitoring:
  /// - `true`: Enable.
  /// - `false`: (Default) Disable.
  Future<void> enableInEarMonitoring(bool enabled);

  /// Sets the volume of the in-ear monitor.
  ///
  /// **Parameter** [volume] Sets the volume of the in-ear monitor. The value ranges between 0 and 100 (default).
  Future<void> setInEarMonitoringVolume(int volume);
}

/// @nodoc
mixin RtcDualStreamInterface {
  /// Enables/Disables the dual video stream mode.
  ///
  /// If dual-stream mode is enabled, the receiver can choose to receive the high stream (high-resolution high-bitrate video stream) or low stream (low-resolution low-bitrate video stream) video.
  ///
  /// **Parameter** [enabled] Sets the stream mode:
  /// - `true`: Dual-stream mode.
  /// - `false`: (Default) Single-stream mode.
  Future<void> enableDualStreamMode(bool enabled);

  /// Sets the stream type of the remote video.
  ///
  /// Under limited network conditions, if the publisher has not disabled the dual-stream mode using [RtcEngine.enableDualStreamMode] (false), the receiver can choose to receive either the high-video stream (the high resolution, and high bitrate video stream) or the low-video stream (the low resolution, and low bitrate video stream).
  ///
  /// By default, users receive the high-video stream. Call this method if you want to switch to the low-video stream. This method allows the app to adjust the corresponding video stream type based on the size of the video window to reduce the bandwidth and resources.
  ///
  /// The aspect ratio of the low-video stream is the same as the high-video stream. Once the resolution of the high-video stream is set, the system automatically sets the resolution, frame rate, and bitrate of the low-video stream.
  ///
  /// The SDK reports the result of calling this method in the [RtcEngineEventHandler.apiCallExecuted] callback.
  ///
  /// **Parameter** [uid] ID of the remote user sending the video stream.
  ///
  /// **Parameter** [streamType] Sets the video-stream type. See [VideoStreamType].
  Future<void> setRemoteVideoStreamType(int uid, VideoStreamType streamType);

  /// Sets the default video-stream type of the remotely subscribed video stream when the remote user sends dual streams.
  ///
  /// **Parameter** [streamType] Sets the default video-stream type. See [VideoStreamType].
  Future<void> setRemoteDefaultVideoStreamType(VideoStreamType streamType);
}

/// @nodoc
mixin RtcFallbackInterface {
  /// Sets the fallback option for the locally published video stream based on the network conditions.
  ///
  /// If option is set as [StreamFallbackOptions.AudioOnly], the SDK will:
  /// - Disable the upstream video but enable audio only when the network conditions deteriorate and cannot support both video and audio.
  /// - Re-enable the video when the network conditions improve.
  ///
  /// When the locally published video stream falls back to audio only or when the audio-only stream switches back to the video, the SDK triggers the [RtcEngineEventHandler.localPublishFallbackToAudioOnly].
  ///
  /// **Note**
  /// - Agora does not recommend using this method for CDN live streaming, because the remote CDN live user will have a noticeable lag when the locally published video stream falls back to audio only.
  ///
  /// **Parameter** [option] Sets the fallback option for the locally published video stream. See [StreamFallbackOptions].
  ///
  Future<void> setLocalPublishFallbackOption(StreamFallbackOptions option);

  /// Sets the fallback option for the remotely subscribed video stream based on the network conditions.
  ///
  /// If option is set as [StreamFallbackOptions.VideoStreamLow] or [StreamFallbackOptions.AudioOnly], the SDK automatically switches the video from a high-stream to a low-stream, or disables the video when the downlink network condition cannot support both audio and video to guarantee the quality of the audio. The SDK monitors the network quality and restores the video stream when the network conditions improve. When the remotely subscribed video stream falls back to audio only, or the audio-only stream switches back to the video, the SDK triggers the [RtcEngineEventHandler.remoteSubscribeFallbackToAudioOnly] callback.
  ///
  /// **Parameter** [option] Sets the fallback option for the remotely subscribed video stream. See [StreamFallbackOptions].
  Future<void> setRemoteSubscribeFallbackOption(StreamFallbackOptions option);

  /// Sets the priority of a remote user's media stream.
  ///
  /// Use this method with the [RtcEngine.setRemoteSubscribeFallbackOption] method. If the fallback function is enabled for a subscribed stream, the SDK ensures the high-priority user gets the best possible stream quality.
  ///
  /// **Note**
  /// The Agora SDK supports setting `userPriority` as `High` for one user only.
  ///
  /// **Parameter** [uid] The ID of the remote user.
  ///
  /// **Parameter** [userPriority] The priority of the remote user. See [UserPriority].
  Future<void> setRemoteUserPriority(int uid, UserPriority userPriority);
}

/// @nodoc
mixin RtcTestInterface {
  /// Starts an audio call test.
  ///
  /// In the audio call test, you record your voice. If the recording plays back within the set time interval, the audio devices and the network connection are working properly.
  ///
  /// **Note**
  /// - Call this method before joining a channel.
  /// - After calling this method, call the [RtcEngine.stopEchoTest] method to end the test. Otherwise, the app cannot run the next echo test, or call the [RtcEngine.joinChannel] method.
  /// - In the [ChannelProfile.LiveBroadcasting] profile, only a host can call this method.
  ///
  /// **Parameter** [intervalInSeconds] The time interval (s) between when you speak and when the recording plays back.
  Future<void> startEchoTest(int intervalInSeconds);

  /// Stops the audio call test.
  Future<void> stopEchoTest();

  /// Enables the network connection quality test.
  ///
  /// This method tests the quality of the users' network connections and is disabled by default.
  ///
  /// Before users join a channel or before an audience switches to a host, call this method to check the uplink network quality. This method consumes additional network traffic, which may affect the communication quality. Call the [RtcEngine.disableLastmileTest] method to disable this test after receiving the [RtcEngineEventHandler.lastmileQuality] callback, and before the user joins a channel or switches the user role.
  ///
  /// **Note**
  /// - Do not use this method with the startLastmileProbeTest method.
  /// See [RtcEngine.startLastmileProbeTest]
  /// - Do not call any other methods before receiving the onLastmileQuality callback. Otherwise, the callback may be interrupted by other methods and may not execute.
  /// See [RtcEngineEventHandler.lastmileQuality]
  /// - In the [ChannelProfile.LiveBroadcasting] profile, a host should not call this method after joining a channel.
  /// - If you call this method to test the last-mile quality, the SDK consumes the bandwidth of a video stream, whose bitrate corresponds to the bitrate you set in the [RtcEngine.setVideoEncoderConfiguration] method. After you join the channel, whether you have called the [RtcEngine.disableLastmileTest] method or not, the SDK automatically stops consuming the bandwidth.
  Future<void> enableLastmileTest();

  /// Disables the network connection quality test.
  Future<void> disableLastmileTest();

  /// Starts the last-mile network probe test before joining a channel to get the uplink and downlink last-mile network statistics, including the bandwidth, packet loss, jitter, and round-trip time (RTT).
  ///
  /// Once this method is enabled, the SDK returns the following callbacks:
  /// - [RtcEngineEventHandler.lastmileQuality]: the SDK triggers this callback within two seconds depending on the network conditions. This callback rates the network conditions with a score and is more closely linked to the user experience.
  /// - [RtcEngineEventHandler.lastmileProbeResult]: the SDK triggers this callback within 30 seconds depending on the network conditions. This callback returns the real-time statistics of the network conditions and is more objective.
  ///
  /// Call this method to check the uplink network quality before users join a channel or before an audience switches to a host.
  ///
  /// **Note**
  /// - This method consumes extra network traffic and may affect communication quality. We do not recommend calling this method together with [RtcEngine.enableLastmileTest].
  /// - Do not call other methods before receiving the [RtcEngineEventHandler.lastmileQuality] and [RtcEngineEventHandler.lastmileProbeResult] callbacks. Otherwise, the callbacks may be interrupted by other methods.
  /// - In the [ChannelProfile.LiveBroadcasting] profile, a host should not call this method after joining a channel.
  ///
  /// **Parameter** [config] The configurations of the last-mile network probe test. See [LastmileProbeConfig].
  Future<void> startLastmileProbeTest(LastmileProbeConfig config);

  /// Stops the last-mile network probe test.
  Future<void> stopLastmileProbeTest();
}

/// @nodoc
mixin RtcMediaMetadataInterface {
  /// Registers the metadata observer.
  ///
  /// This method enables you to add synchronized metadata in the video stream for more diversified live broadcast interactions, such as sending shopping links, digital coupons, and online quizzes.
  ///
  /// **Note**
  /// Call this method before the [RtcEngine.joinChannel] method.
  Future<void> registerMediaMetadataObserver();

  /// Unregisters the metadata observer.
  Future<void> unregisterMediaMetadataObserver();

  /// Sets the maximum size of the metadata.
  ///
  /// **Parameter** [size] The maximum size of the buffer of the metadata that you want to use. The highest value is 1024 bytes.
  Future<void> setMaxMetadataSize(int size);

  /// Sends the metadata.
  ///
  /// **Parameter** [metadata] The metadata to be sent in the form of String.
  ///
  /// **Note**
  ///
  /// Ensure that the size of the metadata does not exceed the value set in the [setMaxMetadataSize] method.
  Future<void> sendMetadata(String metadata);
}

/// @nodoc
mixin RtcWatermarkInterface {
  /// Adds a watermark image to the local video.
  ///
  /// This method adds a PNG watermark image to the local video stream in a live broadcast. Once the watermark image is added, all the audience in the channel (CDN audience included), and the recording device can see and capture it.
  ///
  /// Agora supports adding only one watermark image onto the local video, and the newly watermark image replaces the previous one.
  ///
  /// The watermark position depends on the settings in the [RtcEngine.setVideoEncoderConfiguration] method:
  /// - If the orientation mode of the encoding video is [VideoOutputOrientationMode.FixedLandscape], or the landscape mode in [VideoOutputOrientationMode.Adaptative], the watermark uses the landscape orientation.
  /// - If the orientation mode of the encoding video is [VideoOutputOrientationMode.FixedPortrait], or the portrait mode in [VideoOutputOrientationMode.Adaptative], the watermark uses the portrait orientation.
  /// - When setting the watermark position, the region must be less than the dimensions set in the setVideoEncoderConfiguration method. Otherwise, the watermark image will be cropped.
  ///
  /// **Note**
  /// - Ensure that you have called the [RtcEngine.enableVideo] method to enable the video module before calling this method.
  /// - If you only want to add a watermark image to the local video for the audience in the CDN LiveBroadcasting channel to see and capture, you can call this method or the [RtcEngine.setLiveTranscoding] method.
  /// - This method supports adding a watermark image in the PNG file format only. Supported pixel formats of the PNG image are RGBA, RGB, Palette, Gray, and Alpha_gray.
  /// - If the dimensions the PNG image differ from your settings in this method, the image will be cropped or zoomed to conform to your settings.
  /// - If you have enabled the local video preview by calling the startPreview method, you can use the visibleInPreview member in the WatermarkOptions class to set whether or not the watermark is visible in preview.
  /// - If you have enabled the mirror mode for the local video, the watermark on the local video is also mirrored. To avoid mirroring the watermark, Agora recommends that you do not use the mirror and watermark functions for the local video at the same time. You can implement the watermark function in your application layer.
  ///
  /// **Parameter** [watermarkUrl] The local file path of the watermark image to be added. This method supports adding a watermark image from either the local file path or the assets file path. If you use the assets file path, you need to start with `/assets/` when filling in this parameter.
  ///
  /// **Parameter** [options] The options of the watermark image to be added. See [WatermarkOptions].
  Future<void> addVideoWatermark(String watermarkUrl, WatermarkOptions options);

  /// Removes the watermark image from the video stream added by [RtcEngine.addVideoWatermark].
  Future<void> clearVideoWatermarks();
}

/// @nodoc
mixin RtcEncryptionInterface {
  /// Enables built-in encryption with an encryption password before joining a channel.
  ///
  /// All users in a channel must set the same encryption password. The encryption password is automatically cleared once a user leaves the channel. If the encryption password is not specified or set to empty, the encryption functionality is disabled.
  ///
  /// **Note**
  /// - For optimal transmission, ensure that the encrypted data size does not exceed the original data size + 16 bytes. 16 bytes is the maximum padding size for AES encryption.
  /// - Do not use this method for CDN live streaming.
  ///
  /// **Parameter** [secret] The encryption password.
  Future<void> setEncryptionSecret(String secret);

  /// Sets the built-in encryption mode.
  ///
  /// The Agora SDK supports built-in encryption, which is set to aes-128-xts mode by default. Call this method to set the encryption mode to use other encryption modes. All users in the same channel must use the same encryption mode and password.
  ///
  /// Refer to the information related to the AES encryption algorithm on the differences between the encryption modes.
  ///
  /// **Note**
  /// - Call the [RtcEngine.setEncryptionSecret] method before calling this method.
  ///
  /// **Parameter** [encryptionMode] Sets the encryption mode. See [EncryptionMode].
  Future<void> setEncryptionMode(EncryptionMode encryptionMode);
}

/// @nodoc
mixin RtcAudioRecorderInterface {
  /// Starts an audio recording on the client.
  ///
  /// The SDK allows recording during a call. After successfully calling this method, you can record the audio of all the users in the channel and get an audio recording file.
  ///
  /// Supported formats of the recording file are as follows:
  /// - .wav: Large file size with high fidelity.
  /// - .aac: Small file size with low fidelity.
  ///
  /// **Note**
  /// - Ensure that the directory to save the recording file exists and is writable.
  /// - This method is usually called after calling the [RtcEngine.joinChannel] method. The recording automatically stops when you call the [RtcEngine.leaveChannel] method.
  /// - For better recording effects, set quality as [AudioRecordingQuality.Medium] or [AudioRecordingQuality.High] when sampleRate is 44.1 kHz or 48 kHz.
  ///
  /// **Parameter** [filePath] Absolute file path (including the suffixes of the filename) of the recording file. The string of the file name is in UTF-8. For example, `/sdcard/emulated/0/audio/aac`.
  ///
  /// **Parameter** [sampleRate] Sample rate (Hz) of the recording file. See [AudioSampleRateType] for supported values.
  ///
  /// **Parameter** [quality] The audio recording quality. See [AudioRecordingQuality].
  Future<void> startAudioRecording(String filePath,
      AudioSampleRateType sampleRate, AudioRecordingQuality quality);

  /// Stops the audio recording on the client.
  ///
  /// **Note**
  /// You can call this method before calling the [RtcEngine.leaveChannel] method; else, the recording automatically stops when you call the [RtcEngine.leaveChannel] method.
  Future<void> stopAudioRecording();
}

/// @nodoc
mixin RtcInjectStreamInterface {
  /// Injects an online media stream to a live broadcast.
  ///
  /// If this method call is successful, the server pulls the voice or video stream and injects it into a live channel. This is applicable to scenarios where all audience members in the channel can watch a live show and interact with each other.
  ///
  /// **Note**
  /// - This method applies to the LiveBroadcasting profile only.
  /// - Ensure that you enable the RTMP Converter service before using this function. See Prerequisites in *Push Streams to CDN*.
  /// - You can inject only one media stream into the channel at the same time.
  ///
  /// This method call triggers the following callbacks:
  /// - The local client:
  ///   - [RtcEngineEventHandler.streamInjectedStatus], with the state of the injecting the online stream.
  ///   - [RtcEngineEventHandler.userJoined](uid: 666), if the method call is successful and the online media stream is injected into the channel.
  /// - The remote client:
  ///   - [RtcEngineEventHandler.userJoined](uid: 666), if the method call is successful and the online media stream is injected into the channel.
  ///
  /// **Parameter** [url] The URL address to be added to the ongoing live broadcast. Valid protocols are RTMP, HLS, and HTTP-FLV.
  /// - Supported audio codec type: AAC.
  /// - Supported video codec type: H264(AVC).
  ///
  /// **Parameter** [config] The [LiveInjectStreamConfig] object which contains the configuration information for the added voice or video stream.
  Future<void> addInjectStreamUrl(String url, LiveInjectStreamConfig config);

  /// Removes the injected online media stream from a live broadcast.
  ///
  /// This method removes the URL address (added by [RtcEngine.addInjectStreamUrl]) from a live broadcast.
  ///
  /// If this method call is successful, the SDK triggers the [RtcEngineEventHandler.userOffline] callback and returns a stream uid of 666.
  ///
  /// **Parameter** [url] HTTP/HTTPS URL address of the added stream to be removed.
  Future<void> removeInjectStreamUrl(String url);
}

/// @nodoc
mixin RtcCameraInterface {
  /// Switches between front and rear cameras.
  Future<void> switchCamera();

  /// Checks whether the camera zoom function is supported.
  Future<bool> isCameraZoomSupported();

  /// Checks whether the camera flash function is supported.
  Future<bool> isCameraTorchSupported();

  /// Checks whether the camera manual focus function is supported.
  Future<bool> isCameraFocusSupported();

  /// Checks whether the camera exposure function is supported.
  Future<bool> isCameraExposurePositionSupported();

  /// Checks whether the camera auto-face focus function is supported.
  Future<bool> isCameraAutoFocusFaceModeSupported();

  /// Sets the camera zoom ratio.
  ///
  /// **Parameter** [factor] Sets the camera zoom factor. The value ranges between 1.0 and the maximum zoom supported by the device.
  Future<void> setCameraZoomFactor(double factor);

  /// Gets the maximum zoom ratio supported by the camera.
  Future<double> getCameraMaxZoomFactor();

  /// Sets the camera manual focus position.
  /// A successful method call triggers the [RtcEngineEventHandler.cameraFocusAreaChanged] callback on the local client.
  ///
  /// **Parameter** [positionX] The horizontal coordinate of the touch point in the view.
  ///
  /// **Parameter** [positionY] The vertical coordinate of the touch point in the view.
  Future<void> setCameraFocusPositionInPreview(
      double positionX, double positionY);

  /// Sets the camera exposure position.
  ///
  /// A successful method call triggers the [RtcEngineEventHandler.cameraExposureAreaChanged] callback on the local client.
  /// See [RtcEngineEventHandler.cameraExposureAreaChanged]
  ///
  /// **Parameter** [positionXinView] The horizontal coordinate of the touch point in the view.
  ///
  /// **Parameter** [positionYinView] The vertical coordinate of the touch point in the view.
  Future<void> setCameraExposurePosition(
      double positionXinView, double positionYinView);

  /// Enables the camera flash function.
  ///
  /// **Parameter** [isOn] Sets whether to enable/disable the camera flash function:
  /// - `true`: Enable the camera flash function.
  /// - `false`: Disable the camera flash function.
  Future<void> setCameraTorchOn(bool isOn);

  /// Enables the camera auto-face focus function.
  ///
  /// **Parameter** [enabled] Sets whether to enable/disable the camera auto-face focus function:
  /// - `true`: Enable the camera auto-face focus function.
  /// - `false`: (Default) Disable the camera auto-face focus function.
  Future<void> setCameraAutoFocusFaceModeEnabled(bool enabled);

  /// Sets the camera capturer configuration.
  ///
  /// For a video call or live broadcast, generally the SDK controls the camera output parameters. When the default camera capture settings do not meet special requirements or cause performance problems, we recommend using this method to set the camera capturer configuration:
  /// - If the resolution or frame rate of the captured raw video data are higher than those set by [RtcEngine.setVideoEncoderConfiguration], processing video frames requires extra CPU and RAM usage and degrades performance. We recommend setting config as [CameraCaptureOutputPreference.Performance] to avoid such problems.
  /// - If you do not need local video preview or are willing to sacrifice preview quality, we recommend setting config as [CameraCaptureOutputPreference.Performance] to optimize CPU and RAM usage.
  /// - If you want better quality for the local video preview, we recommend setting config as [CameraCaptureOutputPreference.Preview].
  ///
  /// **Note**
  /// - Call this method before enabling the local camera. That said, you can call this method before calling [RtcEngine.joinChannel], [RtcEngine.enableVideo], or [RtcEngine.enableLocalVideo], depending on which method you use to turn on your local camera.
  ///
  /// **Parameter** [config] The camera capturer configuration. See [CameraCapturerConfiguration].
  Future<void> setCameraCapturerConfiguration(
      CameraCapturerConfiguration config);
}

/// @nodoc
mixin RtcStreamMessageInterface {
  /// Creates a data stream.
  ///
  /// Each user can create up to five data streams during the lifecycle of the [RtcEngine].
  ///
  /// **Note**
  /// - Set both the reliable and ordered parameters to true or false. Do not set one as true and the other as false.
  ///
  /// **Parameter** [reliable] Sets whether or not the recipients are guaranteed to receive the data stream from the sender within five seconds:
  /// - `true`: The recipients receive the data from the sender within five seconds. If the recipient does not receive the data within five seconds, the SDK triggers the [RtcEngineEventHandler.streamMessageError] callback and returns an error code.
  /// - `false`: There is no guarantee that the recipients receive the data stream within five seconds and no error message is reported for any delay or missing data stream.
  ///
  /// **Parameter** [ordered] Sets whether or not the recipients receive the data stream in the sent order:
  /// - `true`: The recipients receive the data in the sent order.
  /// - `false`: The recipients do not receive the data in the sent order.
  ///
  ///
  /// **Returns**
  /// - 0: Success.
  /// - < 0: Failure.
  Future<int> createDataStream(bool reliable, bool ordered);

  /// Sends data stream messages.
  ///
  /// The SDK has the following restrictions on this method:
  /// - Up to 30 packets can be sent per second in a channel with each packet having a maximum size of 1 kB.
  /// - Each client can send up to 6 kB of data per second.
  /// - Each user can have up to five data channels simultaneously.
  ///
  /// A successful method call triggers the [RtcEngineEventHandler.streamMessage] callback on the remote client, from which the remote user gets the stream message.
  ///
  /// A failed method call triggers the [RtcEngineEventHandler.streamMessageError] callback on the remote client.
  ///
  /// **Note**
  /// - Ensure that you have created the data stream using [RtcEngine.createDataStream] before calling this method.
  /// - This method applies only to the [ChannelProfile.Communication] profile or to hosts in the [ChannelProfile.LiveBroadcasting] profile.
  ///
  /// **Parameter** [streamId] ID of the sent data stream returned by the [RtcEngine.createDataStream] method.
  ///
  /// **Parameter** [message] Sent data.
  Future<void> sendStreamMessage(int streamId, String message);
}
