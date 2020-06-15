import 'dart:async';

import 'package:flutter/services.dart';

import 'classes.dart';
import 'enums.dart';

class AgoraRtcEngine
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
  static const MethodChannel _methodChannel =
      const MethodChannel('agora_rtc_engine');

  static AgoraRtcEngine _engine;

  /// Creates an RtcEngine instance.
  /// @see RtcEngine
  /// The Agora SDK only supports one RtcEngine instance at a time, therefore the app should create one RtcEngine object only. Unless otherwise specified:
  /// - All called methods provided by the RtcEngine class are executed asynchronously. We recommend calling the interface methods in the same thread.
  /// @param appId The App ID issued to you by Agora. Apply for a new App ID from Agora if it is missing from your kit.
  static Future<AgoraRtcEngine> create(String appId) async {
    if (_engine != null) return _engine;
    await _methodChannel.invokeMethod('create', {'appId': appId});
    _engine = AgoraRtcEngine();
    return _engine;
  }

  /// Destroys the RtcEngine instance and releases all resources used by the Agora SDK.
  /// @see RtcEngine
  /// This method is useful for apps that occasionally make voice or video calls, to free up resources for other operations when not making calls.
  /// Note
  /// - Call this method in the subthread.
  /// - Once the app calls destroy to destroy the created RtcEngine instance, you cannot use any method or callback in the SDK.
  Future<void> destroy() {
// TODO RtcChannel.destroyAll();
    _engine = null;
    return _methodChannel.invokeMethod('destroy');
  }

  /// Sets the channel profile of the Agora RtcEngine.
  /// The Agora RtcEngine differentiates channel profiles and applies different optimization algorithms accordingly. For example, it prioritizes smoothness and low latency for a video call, and prioritizes video quality for a video broadcast.
  /// @param profile The channel profile of the Agora RtcEngine.
  /// @see ChannelProfile
  Future<void> setChannelProfile(ChannelProfile profile) {
    return _methodChannel.invokeMethod('setChannelProfile',
        {'profile': ChannelProfileConverter(profile).value()});
  }

  /// Sets the role of a user (Live Broadcast only).
  /// This method sets the role of a user, such as a host or an audience (default), before joining a channel.
  /// This method can be used to switch the user role after a user joins a channel. In the Live Broadcast profile, when a user switches user roles after joining a channel, a successful setClientRole method call triggers the following callbacks:
  /// - The local client: onClientRoleChanged.
  /// @see RtcEngineEvents.ClientRoleChanged
  /// - The remote client: onUserJoined or onUserOffline(BecomeAudience).
  /// @see RtcEngineEvents.UserJoined
  /// @see RtcEngineEvents.UserOffline
  /// @see UserOfflineReason.BecomeAudience
  /// @param role Sets the role of a user.
  /// @see ClientRole
  Future<void> setClientRole(ClientRole role) {
    return _methodChannel.invokeMethod(
        'setClientRole', {'role': ClientRoleConverter(role).value()});
  }

  /// Allows a user to join a channel.
  /// Users in the same channel can talk to each other, and multiple users in the same channel can start a group chat. Users with different App IDs cannot call each other.
  /// You must call the leaveChannel method to exit the current call before joining another channel.
  /// @see RtcEngine.leaveChannel
  /// A successful joinChannel method call triggers the following callbacks:
  /// - The local client: onJoinChannelSuccess.
  /// @see RtcEngineEvents.JoinChannelSuccess
  /// - The remote client: onUserJoined, if the user joining the channel is in the Communication profile, or is a BROADCASTER in the Live Broadcast profile.
  /// @see RtcEngineEvents.UserJoined
  /// @see ChannelProfile.Communication
  /// @see ClientRole.Broadcaster
  /// @see ChannelProfile.LiveBroadcasting
  /// When the connection between the client and Agora's server is interrupted due to poor network conditions, the SDK tries reconnecting to the server. When the local client successfully rejoins the channel, the SDK triggers the onRejoinChannelSuccess callback on the local client.
  /// @see RtcEngineEvents.RejoinChannelSuccess
  /// The uid is represented as a 32-bit unsigned integer in the SDK. Since unsigned integers are not supported by Java, the uid is handled as a 32-bit signed integer and larger numbers are interpreted as negative numbers in Java. If necessary, the uid can be converted to a 64-bit integer through “uid&0xffffffffL”.
  /// Note
  /// - A channel does not accept duplicate uids, such as two users with the same uid. If you set uid as 0, the system automatically assigns a uid.
  /// Warning
  /// - Ensure that the App ID used for creating the token is the same App ID used in the create method for creating an RtcEngine object. Otherwise, CDN live streaming may fail.
  /// @param token The token for authentication:
  /// - In situations not requiring high security: You can use the temporary token generated at Console. For details, see Get a temporary token.
  /// - In situations requiring high security: Set it as the token generated at your server. For details, see Generate a token.
  /// @param channelName The unique channel name for the AgoraRTC session in the string format. The string length must be less than 64 bytes. Supported character scopes are:
  /// - All lowercase English letters: a to z.
  /// - All uppercase English letters: A to Z.
  /// - All numeric characters: 0 to 9.
  /// - The space character.
  /// - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
  /// @param optionalInfo Additional information about the channel. This parameter can be set as null or contain channel related information. Other users in the channel do not receive this message.
  /// @param optionalUid (Optional) User ID. A 32-bit unsigned integer with a value ranging from 1 to (2^32-1). optionalUid must be unique. If optionalUid is not assigned (or set to 0), the SDK assigns and returns uid in the onJoinChannelSuccess callback. Your app must record and maintain the returned uid since the SDK does not do so.
  /// @see RtcEngineEvents.JoinChannelSuccess
  Future<void> joinChannel(
      String token, String channelName, String optionalInfo, int optionalUid) {
    return _methodChannel.invokeMethod('joinChannel', {
      'token': token,
      'channelName': channelName,
      'optionalInfo': optionalInfo,
      'optionalUid': optionalUid
    });
  }

  /// Switches to a different channel.
  /// This method allows the audience of a Live-broadcast channel to switch to a different channel.
  /// After the user successfully switches to another channel, the onLeaveChannel and onJoinChannelSuccess callbacks are triggered to indicate that the user has left the original channel and joined a new one.
  /// @see RtcEngineEvents.LeaveChannel
  /// @see RtcEngineEvents.JoinChannelSuccess
  /// Note
  /// - This method applies to the audience role in a Live-broadcast channel only.
  /// @see ClientRole.Audience
  /// @see ChannelProfile.LiveBroadcasting
  /// @param token The token for authentication:
  /// - In situations not requiring high security: You can use the temporary token generated at Console. For details, see Get a temporary token.
  /// - In situations requiring high security: Set it as the token generated at your server. For details, see Generate a token.
  /// @param channelName Unique channel name for the AgoraRTC session in the string format. The string length must be less than 64 bytes. Supported character scopes are:
  /// - All lowercase English letters: a to z.
  /// - All uppercase English letters: A to Z.
  /// - All numeric characters: 0 to 9.
  /// - The space character.
  /// - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
  Future<void> switchChannel(String token, String channelName) {
    return _methodChannel.invokeMethod(
        'switchChannel', {'token': token, 'channelName': channelName});
  }

  /// Allows a user to leave a channel.
  /// After joining a channel, the user must call the leaveChannel method to end the call before joining another channel. This method returns 0 if the user leaves the channel and releases all resources related to the call. This method call is asynchronous, and the user has not exited the channel when the method call returns. Once the user leaves the channel, the SDK triggers the onLeaveChannel callback.
  /// A successful leaveChannel method call triggers the following callbacks:
  /// - The local client: onLeaveChannel.
  /// @see RtcEngineEvents.LeaveChannel
  /// - The remote client: onUserOffline, if the user leaving the channel is in the Communication channel, or is a BROADCASTER in the Live Broadcast profile.
  /// @see RtcEngineEvents.UserOffline
  /// @see ChannelProfile.Communication
  /// @see ClientRole.Broadcaster
  /// @see ChannelProfile.LiveBroadcasting
  /// Note
  /// - If you call the destroy method immediately after calling the leaveChannel method, the leaveChannel process interrupts, and the SDK does not trigger the onLeaveChannel callback.
  /// @see RtcEngine.destroy
  /// - If you call the leaveChannel method during CDN live streaming, the SDK triggers the removeInjectStreamUrl method.
  /// @see RtcEngine.removeInjectStreamUrl
  Future<void> leaveChannel() {
    return _methodChannel.invokeMethod('leaveChannel');
  }

  /// Renews the token when the current token expires.
  /// The token expires after a period of time once the token schema is enabled when:
  /// - The SDK triggers the onTokenPrivilegeWillExpire callback, or
  /// @see RtcEngineEvents.TokenPrivilegeWillExpire
  /// - The onConnectionStateChanged callback reports the TokenExpired(9) error.
  /// @see RtcEngineEvents.ConnectionStateChanged
  /// @see ConnectionChangedReason.TokenExpired
  /// The app should retrieve a new token from the server and call this method to renew it. Failure to do so results in the SDK disconnecting from the server.
  /// @param token The new token.
  Future<void> renewToken(String token) {
    return _methodChannel.invokeMethod('renewToken', {'token': token});
  }

  /// Enables interoperability with the Agora Web SDK (Live Broadcast only).
  /// @deprecated As of v3.0.0, the Native SDK automatically enables interoperability with the Web SDK, so you no longer need to call this method.
  /// If the channel has Web SDK users, ensure that you call this method, or the video of the Native user will be a black screen for the Web user.
  /// Use this method when the channel profile is Live Broadcast. Interoperability with the Agora Web SDK is enabled by default when the channel profile is Communication.
  /// @param enabled Sets whether to enable/disable interoperability with the Agora Web SDK:
  /// - true: Enable.
  /// - false: (Default) Disable.
  @deprecated
  Future<void> enableWebSdkInteroperability(bool enabled) {
    return _methodChannel
        .invokeMethod('enableWebSdkInteroperability', {'enabled': enabled});
  }

  /// Gets the connection state of the SDK.
  Future<ConnectionStateType> getConnectionState() {
    return _methodChannel.invokeMethod('getConnectionState').then((value) {
      return ConnectionStateTypeConverter.value(value).e;
    });
  }

  /// Gets the current call ID.
  /// When a user joins a channel on a client, a call ID is generated to identify the call from the client. Feedback methods, such as the rate and complain method, must be called after the call ends to submit feedback to the SDK.
  /// @see RtcEngine.rate
  /// @see RtcEngine.complain
  /// The rate and complain methods require the callId parameter retrieved from the getCallId method during a call. callId is passed as an argument into the rate and complain methods after the call ends.
  Future<String> getCallId() {
    return _methodChannel.invokeMethod('getCallId');
  }

  /// Allows the user to rate a call after the call ends.
  /// @param callId ID of the call retrieved from the getCallId method.
  /// @see RtcEngine.getCallId
  /// @param rating Rating of the call. The value is between 1 (lowest score) and 5 (highest score). If you set a value out of this range, the InvalidArgument(-2) error occurs.
  /// @see ErrorCode.InvalidArgument
  /// @param description (Optional) The description of the rating. The string length must be less than 800 bytes.
  Future<void> rate(String callId, int rating, {String description}) {
    return _methodChannel.invokeMethod('rate',
        {'callId': callId, 'rating': rating, 'description': description});
  }

  /// Allows a user to complain about the call quality after a call ends.
  /// @param callId ID of the call retrieved from the getCallId method.
  /// @see RtcEngine.getCallId
  /// @param description (Optional) The description of the complaint. The string length must be less than 800 bytes.
  Future<void> complain(String callId, String description) {
    return _methodChannel.invokeMethod(
        'complain', {'callId': callId, 'description': description});
  }

  /// Specifies an SDK output log file.
  /// The log file records all log data for the SDK’s operation. Ensure that the directory for the log file exists and is writable.
  /// Note
  /// - Ensure that you call this method immediately after calling the create method, otherwise the output log may not be complete.
  /// @see RtcEngine.create
  /// @param filePath File path of the log file. The string of the log file is in UTF-8. The default file path is /storage/emulated/0/Android/data/<package name>="">/files/agorasdk.log.
  Future<void> setLogFile(String filePath) {
    return _methodChannel.invokeMethod('setLogFile', {'filePath': filePath});
  }

  /// Sets the output log level of the SDK.
  /// You can use one or a combination of the filters. The log level follows the sequence of OFF, CRITICAL, ERROR, WARNING, INFO, and DEBUG. Choose a level to see the logs preceding that level. For example, if you set the log level to WARNING, you see the logs within levels CRITICAL, ERROR, and WARNING.
  /// @param filter Sets the log filter level.
  /// @see LogFilter
  Future<void> setLogFilter(LogFilter filter) {
    return _methodChannel.invokeMethod(
        'setLogFilter', {'filter': LogFilterConverter(filter).value()});
  }

  /// Sets the log file size (KB).
  /// The Agora SDK has two log files, each with a default size of 512 KB. If you set fileSizeInKBytes as 1024 KB, the SDK outputs log files with a total maximum size of 2 MB. If the total size of the log files exceed the set value, the new output log files overwrite the old output log files.
  /// @param fileSizeInKBytes The SDK log file size (KB).
  Future<void> setLogFileSize(int fileSizeInKBytes) {
    return _methodChannel
        .invokeMethod('setLogFileSize', {'fileSizeInKBytes': fileSizeInKBytes});
  }

  /// Provides technical preview functionalities or special customizations by configuring the SDK with JSON options.
  /// The JSON options are not public by default. Agora is working on making commonly used JSON options public in a standard way.
  /// @param parameters Sets the parameter as a JSON string in the specified format.
  Future<void> setParameters(String parameters) {
    return _methodChannel
        .invokeMethod('setParameters', {'parameters': parameters});
  }

  @override
  Future<UserInfo> getUserInfoByUid(int uid) {
    return _methodChannel
        .invokeMethod('getUserInfoByUid', {'uid': uid}).then((value) {
      return UserInfo.fromJson(value);
    });
  }

  @override
  Future<UserInfo> getUserInfoByUserAccount(String userAccount) {
    return _methodChannel.invokeMethod(
        'getUserInfoByUserAccount', {'userAccount': userAccount}).then((value) {
      return UserInfo.fromJson(value);
    });
  }

  @override
  Future<void> joinChannelWithUserAccount(
      String token, String channelName, String userAccount) {
    return _methodChannel.invokeMethod('joinChannelWithUserAccount', {
      'token': token,
      'channelName': channelName,
      'userAccount': userAccount
    });
  }

  @override
  Future<void> registerLocalUserAccount(String appId, String userAccount) {
    return _methodChannel.invokeMethod('registerLocalUserAccount',
        {'appId': appId, 'userAccount': userAccount});
  }

  @override
  Future<void> adjustPlaybackSignalVolume(int volume) {
    return _methodChannel
        .invokeMethod('adjustPlaybackSignalVolume', {'volume': volume});
  }

  @override
  Future<void> adjustRecordingSignalVolume(int volume) {
    return _methodChannel
        .invokeMethod('adjustRecordingSignalVolume', {'volume': volume});
  }

  @override
  Future<void> adjustUserPlaybackSignalVolume(int uid, int volume) {
    return _methodChannel.invokeMethod(
        'adjustUserPlaybackSignalVolume', {'uid': uid, 'volume': volume});
  }

  @override
  Future<void> disableAudio() {
    return _methodChannel.invokeMethod('disableAudio');
  }

  @override
  Future<void> enableAudio() {
    return _methodChannel.invokeMethod('enableAudio');
  }

  @override
  Future<void> enableAudioVolumeIndication(
      int interval, int smooth, bool report_vad) {
    return _methodChannel.invokeMethod('enableAudioVolumeIndication',
        {'interval': interval, 'smooth': smooth, 'report_vad': report_vad});
  }

  @override
  Future<void> enableLocalAudio(bool enabled) {
    return _methodChannel
        .invokeMethod('enableLocalAudio', {'enabled': enabled});
  }

  @override
  Future<void> muteAllRemoteAudioStreams(bool muted) {
    return _methodChannel
        .invokeMethod('muteAllRemoteAudioStreams', {'muted': muted});
  }

  @override
  Future<void> muteLocalAudioStream(bool muted) {
    return _methodChannel
        .invokeMethod('muteLocalAudioStream', {'muted': muted});
  }

  @override
  Future<void> muteRemoteAudioStream(int uid, bool muted) {
    return _methodChannel
        .invokeMethod('muteRemoteAudioStream', {'uid': uid, 'muted': muted});
  }

  @override
  Future<void> setAudioProfile(AudioProfile profile, AudioScenario scenario) {
    return _methodChannel.invokeMethod('setAudioProfile', {
      'profile': AudioProfileConverter(profile).value(),
      'scenario': AudioScenarioConverter(scenario).value()
    });
  }

  @override
  Future<void> setDefaultMuteAllRemoteAudioStreams(bool muted) {
    return _methodChannel
        .invokeMethod('setDefaultMuteAllRemoteAudioStreams', {'muted': muted});
  }

  @override
  Future<void> disableVideo() {
    return _methodChannel.invokeMethod('disableVideo');
  }

  @override
  Future<void> enableLocalVideo(bool enabled) {
    return _methodChannel
        .invokeMethod('enableLocalVideo', {'enabled': enabled});
  }

  @override
  Future<void> enableVideo() {
    return _methodChannel.invokeMethod('enableVideo');
  }

  @override
  Future<void> muteAllRemoteVideoStreams(bool muted) {
    return _methodChannel
        .invokeMethod('muteAllRemoteVideoStreams', {'muted': muted});
  }

  @override
  Future<void> muteLocalVideoStream(bool muted) {
    return _methodChannel
        .invokeMethod('muteLocalVideoStream', {'muted': muted});
  }

  @override
  Future<void> muteRemoteVideoStream(int uid, bool muted) {
    return _methodChannel
        .invokeMethod('muteRemoteVideoStream', {'uid': uid, 'muted': muted});
  }

  @override
  Future<void> setBeautyEffectOptions(bool enabled, BeautyOptions options) {
    return _methodChannel.invokeMethod('setBeautyEffectOptions',
        {'enabled': enabled, 'options': options.toJson()});
  }

  @override
  Future<void> setDefaultMuteAllRemoteVideoStreams(bool muted) {
    return _methodChannel
        .invokeMethod('setDefaultMuteAllRemoteVideoStreams', {'muted': muted});
  }

  @override
  Future<void> setVideoEncoderConfiguration(VideoEncoderConfiguration config) {
    return _methodChannel.invokeMethod(
        'setVideoEncoderConfiguration', {'config': config.toJson()});
  }

  @override
  Future<void> adjustAudioMixingPlayoutVolume(int volume) {
    return _methodChannel
        .invokeMethod('adjustAudioMixingPlayoutVolume', {'volume': volume});
  }

  @override
  Future<void> adjustAudioMixingPublishVolume(int volume) {
    return _methodChannel
        .invokeMethod('adjustAudioMixingPublishVolume', {'volume': volume});
  }

  @override
  Future<void> adjustAudioMixingVolume(int volume) {
    return _methodChannel
        .invokeMethod('adjustAudioMixingVolume', {'volume': volume});
  }

  @override
  Future<int> getAudioMixingCurrentPosition() {
    return _methodChannel.invokeMethod('getAudioMixingCurrentPosition');
  }

  @override
  Future<int> getAudioMixingDuration() {
    return _methodChannel.invokeMethod('getAudioMixingDuration');
  }

  @override
  Future<int> getAudioMixingPlayoutVolume() {
    return _methodChannel.invokeMethod('getAudioMixingPlayoutVolume');
  }

  @override
  Future<int> getAudioMixingPublishVolume() {
    return _methodChannel.invokeMethod('getAudioMixingPublishVolume');
  }

  @override
  Future<void> pauseAudioMixing() {
    return _methodChannel.invokeMethod('pauseAudioMixing');
  }

  @override
  Future<void> resumeAudioMixing() {
    return _methodChannel.invokeMethod('resumeAudioMixing');
  }

  @override
  Future<void> setAudioMixingPosition(int pos) {
    return _methodChannel.invokeMethod('setAudioMixingPosition', {'pos': pos});
  }

  @override
  Future<void> startAudioMixing(
      String filePath, bool loopback, bool replace, int cycle) {
    return _methodChannel.invokeMethod('startAudioMixing', {
      'filePath': filePath,
      'loopback': loopback,
      'replace': replace,
      'cycle': cycle
    });
  }

  @override
  Future<void> stopAudioMixing() {
    return _methodChannel.invokeMethod('stopAudioMixing');
  }

  @override
  Future<void> addInjectStreamUrl(String url, LiveInjectStreamConfig config) {
    return _methodChannel.invokeMethod(
        'addInjectStreamUrl', {'url': url, 'config': config.toJson()});
  }

  @override
  Future<void> addPublishStreamUrl(String url, bool transcodingEnabled) {
    return _methodChannel.invokeMethod('addPublishStreamUrl',
        {'url': url, 'transcodingEnabled': transcodingEnabled});
  }

  @override
  Future<void> addVideoWatermark(
      String watermarkUrl, WatermarkOptions options) {
    return _methodChannel.invokeMethod('addVideoWatermark',
        {'watermarkUrl': watermarkUrl, 'options': options.toJson()});
  }

  @override
  Future<void> clearVideoWatermarks() {
    return _methodChannel.invokeMethod('clearVideoWatermarks');
  }

  @override
  Future<int> createDataStream(bool reliable, bool ordered) {
    return _methodChannel.invokeMethod(
        'createDataStream', {'reliable': reliable, 'ordered': ordered});
  }

  @override
  Future<void> disableLastmileTest() {
    return _methodChannel.invokeMethod('disableLastmileTest');
  }

  @override
  Future<void> enableDualStreamMode(bool enabled) {
    return _methodChannel
        .invokeMethod('enableDualStreamMode', {'enabled': enabled});
  }

  @override
  Future<void> enableInEarMonitoring(bool enabled) {
    return _methodChannel
        .invokeMethod('enableInEarMonitoring', {'enabled': enabled});
  }

  @override
  Future<void> enableLastmileTest() {
    return _methodChannel.invokeMethod('enableLastmileTest');
  }

  @override
  Future<void> enableSoundPositionIndication(bool enabled) {
    return _methodChannel
        .invokeMethod('enableSoundPositionIndication', {'enabled': enabled});
  }

  @override
  Future<double> getCameraMaxZoomFactor() {
    return _methodChannel.invokeMethod('getCameraMaxZoomFactor');
  }

  @override
  Future<double> getEffectsVolume() {
    return _methodChannel.invokeMethod('getEffectsVolume');
  }

  @override
  Future<bool> isCameraAutoFocusFaceModeSupported() {
    return _methodChannel.invokeMethod('isCameraAutoFocusFaceModeSupported');
  }

  @override
  Future<bool> isCameraExposurePositionSupported() {
    return _methodChannel.invokeMethod('isCameraExposurePositionSupported');
  }

  @override
  Future<bool> isCameraFocusSupported() {
    return _methodChannel.invokeMethod('isCameraFocusSupported');
  }

  @override
  Future<bool> isCameraTorchSupported() {
    return _methodChannel.invokeMethod('isCameraTorchSupported');
  }

  @override
  Future<bool> isCameraZoomSupported() {
    return _methodChannel.invokeMethod('isCameraZoomSupported');
  }

  @override
  Future<bool> isSpeakerphoneEnabled() {
    return _methodChannel.invokeMethod('isSpeakerphoneEnabled');
  }

  @override
  Future<void> pauseAllEffects() {
    return _methodChannel.invokeMethod('pauseAllEffects');
  }

  @override
  Future<void> pauseEffect(int soundId) {
    return _methodChannel.invokeMethod('pauseEffect', {'soundId': soundId});
  }

  @override
  Future<void> playEffect(int soundId, String filePath, int loopCount,
      double pitch, double pan, double gain, bool publish) {
    return _methodChannel.invokeMethod('playEffect', {
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
    return _methodChannel.invokeMethod(
        'preloadEffect', {'soundId': soundId, 'filePath': filePath});
  }

  @override
  Future<void> registerMediaMetadataObserver() {
    return _methodChannel.invokeMethod('registerMediaMetadataObserver');
  }

  @override
  Future<void> removeInjectStreamUrl(String url) {
    return _methodChannel.invokeMethod('removeInjectStreamUrl', {'url', url});
  }

  @override
  Future<void> removePublishStreamUrl(String url) {
    return _methodChannel.invokeMethod('removePublishStreamUrl', {'url', url});
  }

  @override
  Future<void> resumeAllEffects() {
    return _methodChannel.invokeMethod('resumeAllEffects');
  }

  @override
  Future<void> resumeEffect(int soundId) {
    return _methodChannel.invokeMethod('resumeEffect', {'soundId': soundId});
  }

  @override
  Future<void> sendMetadata(String metadata) {
    return _methodChannel.invokeMethod('sendMetadata', {'metadata': metadata});
  }

  @override
  Future<void> sendStreamMessage(int streamId, String message) {
    return _methodChannel.invokeMethod(
        'sendStreamMessage', {'streamId': streamId, 'message': message});
  }

  @override
  Future<void> setCameraAutoFocusFaceModeEnabled(bool enabled) {
    return _methodChannel.invokeMethod(
        'setCameraAutoFocusFaceModeEnabled', {'enabled': enabled});
  }

  @override
  Future<void> setCameraCapturerConfiguration(
      CameraCapturerConfiguration config) {
    return _methodChannel.invokeMethod(
        'setCameraCapturerConfiguration', {'config': config.toJson()});
  }

  @override
  Future<void> setCameraExposurePosition(
      double positionXinView, double positionYinView) {
    return _methodChannel.invokeMethod('setCameraExposurePosition', {
      'positionXinView': positionXinView,
      'positionYinView': positionYinView
    });
  }

  @override
  Future<void> setCameraFocusPositionInPreview(
      double positionX, double positionY) {
    return _methodChannel.invokeMethod('setCameraFocusPositionInPreview',
        {'positionX': positionX, 'positionY': positionY});
  }

  @override
  Future<void> setCameraTorchOn(bool isOn) {
    return _methodChannel.invokeMethod('setCameraTorchOn', {'isOn': isOn});
  }

  @override
  Future<void> setCameraZoomFactor(double factor) {
    return _methodChannel
        .invokeMethod('setCameraZoomFactor', {'factor': factor});
  }

  @override
  Future<void> setDefaultAudioRoutetoSpeakerphone(booldefaultToSpeaker) {
    return _methodChannel.invokeMethod('setDefaultAudioRoutetoSpeakerphone',
        {'booldefaultToSpeaker': booldefaultToSpeaker});
  }

  @override
  Future<void> setEffectsVolume(double volume) {
    return _methodChannel.invokeMethod('setEffectsVolume', {'volume': volume});
  }

  @override
  Future<void> setEnableSpeakerphone(bool enabled) {
    return _methodChannel
        .invokeMethod('setEnableSpeakerphone', {'enabled': enabled});
  }

  @override
  Future<void> setEncryptionMode(EncryptionMode encryptionMode) {
    return _methodChannel.invokeMethod('setEncryptionMode',
        {'encryptionMode': EncryptionModeConverter(encryptionMode).value()});
  }

  @override
  Future<void> setEncryptionSecret(String secret) {
    return _methodChannel
        .invokeMethod('setEncryptionSecret', {'secret': secret});
  }

  @override
  Future<void> setInEarMonitoringVolume(int volume) {
    return _methodChannel
        .invokeMethod('setInEarMonitoringVolume', {'volume': volume});
  }

  @override
  Future<void> setLiveTranscoding(LiveTranscoding transcoding) {
    return _methodChannel.invokeMethod(
        'setLiveTranscoding', {'transcoding': transcoding.toJson()});
  }

  @override
  Future<void> setLocalPublishFallbackOption(StreamFallbackOptions option) {
    return _methodChannel.invokeMethod('setLocalPublishFallbackOption',
        {'option': StreamFallbackOptionsConverter(option).value()});
  }

  @override
  Future<void> setLocalVoiceChanger(AudioVoiceChanger voiceChanger) {
    return _methodChannel.invokeMethod('setLocalVoiceChanger',
        {'voiceChanger': AudioVoiceChangerConverter(voiceChanger).value()});
  }

  @override
  Future<void> setLocalVoiceEqualization(
      AudioEqualizationBandFrequency bandFrequency, int bandGain) {
    return _methodChannel.invokeMethod('setLocalVoiceEqualization', {
      'bandFrequency':
          AudioEqualizationBandFrequencyConverter(bandFrequency).value(),
      'bandGain': bandGain
    });
  }

  @override
  Future<void> setLocalVoicePitch(double pitch) {
    return _methodChannel.invokeMethod('setLocalVoicePitch', {'pitch': pitch});
  }

  @override
  Future<void> setLocalVoiceReverb(AudioReverbType reverbKey, int value) {
    return _methodChannel.invokeMethod('setLocalVoiceReverb', {
      'reverbKey': AudioReverbTypeConverter(reverbKey).value(),
      'value': value
    });
  }

  @override
  Future<void> setLocalVoiceReverbPreset(AudioReverbPreset preset) {
    return _methodChannel.invokeMethod('setLocalVoiceReverbPreset',
        {'preset': AudioReverbPresetConverter(preset).value()});
  }

  @override
  Future<void> setMaxMetadataSize(int size) {
    return _methodChannel.invokeMethod('setMaxMetadataSize', {'size': size});
  }

  @override
  Future<void> setRemoteDefaultVideoStreamType(VideoStreamType streamType) {
    return _methodChannel.invokeMethod('setRemoteDefaultVideoStreamType',
        {'streamType': VideoStreamTypeConverter(streamType).value()});
  }

  @override
  Future<void> setRemoteSubscribeFallbackOption(StreamFallbackOptions option) {
    return _methodChannel.invokeMethod('setRemoteSubscribeFallbackOption',
        {'option': StreamFallbackOptionsConverter(option).value()});
  }

  @override
  Future<void> setRemoteUserPriority(int uid, UserPriority userPriority) {
    return _methodChannel.invokeMethod('setRemoteUserPriority', {
      'uid': uid,
      'userPriority': UserPriorityConverter(userPriority).value()
    });
  }

  @override
  Future<void> setRemoteVideoStreamType(int uid, VideoStreamType streamType) {
    return _methodChannel.invokeMethod('setRemoteVideoStreamType', {
      'uid': uid,
      'streamType': VideoStreamTypeConverter(streamType).value()
    });
  }

  @override
  Future<void> setRemoteVoicePosition(int uid, double pan, double gain) {
    return _methodChannel.invokeMethod(
        'setRemoteVoicePosition', {'uid': uid, 'pan': pan, 'gain': gain});
  }

  @override
  Future<void> setVolumeOfEffect(int soundId, double volume) {
    return _methodChannel.invokeMethod(
        'setVolumeOfEffect', {'soundId': soundId, 'volume': volume});
  }

  @override
  Future<void> startAudioRecording(String filePath,
      AudioSampleRateType sampleRate, AudioRecordingQuality quality) {
    return _methodChannel.invokeMethod('startAudioRecording', {
      'filePath': filePath,
      'sampleRate': AudioSampleRateTypeConverter(sampleRate).value(),
      'quality': AudioRecordingQualityConverter(quality).value()
    });
  }

  @override
  Future<void> startChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration) {
    return _methodChannel.invokeMethod('startChannelMediaRelay', {
      'channelMediaRelayConfiguration': channelMediaRelayConfiguration.toJson()
    });
  }

  @override
  Future<void> startEchoTest(int intervalInSeconds) {
    return _methodChannel.invokeMethod(
        'startEchoTest', {'intervalInSeconds': intervalInSeconds});
  }

  @override
  Future<void> startLastmileProbeTest(LastmileProbeConfig config) {
    return _methodChannel
        .invokeMethod('startLastmileProbeTest', {'config': config.toJson()});
  }

  @override
  Future<void> stopAllEffects() {
    return _methodChannel.invokeMethod('stopAllEffects');
  }

  @override
  Future<void> stopAudioRecording() {
    return _methodChannel.invokeMethod('stopAudioRecording');
  }

  @override
  Future<void> stopChannelMediaRelay() {
    return _methodChannel.invokeMethod('stopChannelMediaRelay');
  }

  @override
  Future<void> stopEchoTest() {
    return _methodChannel.invokeMethod('stopEchoTest');
  }

  @override
  Future<void> stopEffect(int soundId) {
    return _methodChannel.invokeMethod('stopEffect', {'soundId': soundId});
  }

  @override
  Future<void> stopLastmileProbeTest() {
    return _methodChannel.invokeMethod('stopLastmileProbeTest');
  }

  @override
  Future<void> switchCamera() {
    return _methodChannel.invokeMethod('switchCamera');
  }

  @override
  Future<void> unloadEffect(int soundId) {
    return _methodChannel.invokeMethod('unloadEffect', {'soundId': soundId});
  }

  @override
  Future<void> unregisterMediaMetadataObserver() {
    return _methodChannel.invokeMethod('unregisterMediaMetadataObserver');
  }

  @override
  Future<void> updateChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration) {
    return _methodChannel.invokeMethod('updateChannelMediaRelay', {
      'channelMediaRelayConfiguration': channelMediaRelayConfiguration.toJson()
    });
  }
}

mixin RtcUserInfoInterface {
  /// Registers a user account.
  /// Once registered, the user account can be used to identify the local user when the user joins the channel. After the user successfully registers a user account, the SDK triggers the onLocalUserRegistered callback on the local client, reporting the user ID and user account of the local user.
  /// @see RtcEngineEvents.LocalUserRegistered
  /// To join a channel with a user account, you can choose either of the following:
  /// - Call the registerLocalUserAccount method to create a user account, and then the joinChannelWithUserAccount method to join the channel.
  /// @see RtcEngine.registerLocalUserAccount
  /// - Call the joinChannelWithUserAccount method to join the channel.
  /// @see RtcEngine.joinChannelWithUserAccount
  /// The difference between the two is that for the former, the time elapsed between calling the joinChannelWithUserAccount method and joining the channel is shorter than the latter.
  /// Note
  /// - Ensure that you set the userAccount parameter. Otherwise, this method does not take effect.
  /// - Ensure that the value of the userAccount parameter is unique in the channel.
  /// - To ensure smooth communication, use the same parameter type to identify the user. For example, if a user joins the channel with a user ID, then ensure all the other users use the user ID too. The same applies to the user account. If a user joins the channel with the Agora Web SDK, ensure that the uid of the user is set to the same parameter type.
  /// @param appId The App ID of your project.
  /// @param userAccount The user account. The maximum length of this parameter is 255 bytes. Ensure that you set this parameter and do not set it as null. Supported character scopes are:
  /// - All lowercase English letters: a to z.
  /// - All uppercase English letters: A to Z.
  /// - All numeric characters: 0 to 9.
  /// - The space character.
  /// - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
  Future<void> registerLocalUserAccount(String appId, String userAccount);

  /// Joins the channel with a user account.
  /// After the user successfully joins the channel, the SDK triggers the following callbacks:
  /// - The local client: onLocalUserRegistered and onJoinChannelSuccess.
  /// @see RtcEngineEvents.LocalUserRegistered
  /// @see RtcEngineEvents.JoinChannelSuccess
  /// - The remote client: onUserJoined and onUserInfoUpdated, if the user joining the channel is in the Communication profile, or is a BROADCASTER in the Live Broadcast profile.
  /// @see RtcEngineEvents.UserJoined
  /// @see RtcEngineEvents.UserInfoUpdated
  /// Note
  /// - To ensure smooth communication, use the same parameter type to identify the user. For example, if a user joins the channel with a user ID, then ensure all the other users use the user ID too. The same applies to the user account. If a user joins the channel with the Agora Web SDK, ensure that the uid of the user is set to the same parameter type.
  /// @param token The token generated at your server:
  /// - In situations not requiring high security: You can use the temporary token generated at Console. For details, see Get a temporary token.
  /// - In situations requiring high security: Set it as the token generated at your server. For details, see Generate a token.
  /// @param channelName The channel name. The maximum length of this parameter is 64 bytes. Supported character scopes are:
  /// - All lowercase English letters: a to z.
  /// - All uppercase English letters: A to Z.
  /// - All numeric characters: 0 to 9.
  /// - The space character.
  /// - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
  /// @param userAccount The user account. The maximum length of this parameter is 255 bytes. Ensure that you set this parameter and do not set it as null.
  /// - All lowercase English letters: a to z.
  /// - All uppercase English letters: A to Z.
  /// - All numeric characters: 0 to 9.
  /// - The space character.
  /// - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
  Future<void> joinChannelWithUserAccount(
      String token, String channelName, String userAccount);

  /// Gets the user information by passing in the user account.
  /// After a remote user joins the channel, the SDK gets the user ID and user account of the remote user, caches them in a mapping table object (UserInfo), and triggers the onUserInfoUpdated callback on the local client.
  /// @see UserInfo
  /// @see RtcEngineEvents.UserInfoUpdated
  /// After receiving the onUserInfoUpdated callback, you can call this method to get the user ID of the remote user from the userInfo object by passing in the user account.
  /// @param userAccount The user account of the user. Ensure that you set this parameter.
  Future<UserInfo> getUserInfoByUserAccount(String userAccount);

  /// Gets the user information by passing in the user ID.
  /// After a remote user joins the channel, the SDK gets the user ID and user account of the remote user, caches them in a mapping table object (UserInfo), and triggers the onUserInfoUpdated callback on the local client.
  /// @see UserInfo
  /// @see RtcEngineEvents.UserInfoUpdated
  /// After receiving the onUserInfoUpdated callback, you can call this method to get the user ID of the remote user from the userInfo object by passing in the user account.
  /// @param uid The user ID of the user. Ensure that you set this parameter.
  Future<UserInfo> getUserInfoByUid(int uid);
}

mixin RtcAudioInterface {
  /// Enables the audio module.
  /// The audio module is enabled by default.
  /// Note
  /// - This method affects the internal engine and can be called after calling the leaveChannel method. You can call this method either before or after joining a channel.
  /// @see RtcEngine.leaveChannel
  /// - This method resets the internal engine and takes some time to take effect. We recommend using the following API methods to control the audio engine modules separately:
  /// -- enableLocalAudio: Whether to enable the microphone to create the local audio stream.
  /// @see RtcEngine.enableLocalAudio
  /// -- muteLocalAudioStream: Whether to publish the local audio stream.
  /// @see RtcEngine.muteLocalAudioStream
  /// -- muteRemoteAudioStream: Whether to subscribe to and play the remote audio stream.
  /// @see RtcEngine.muteRemoteAudioStream
  /// -- muteAllRemoteAudioStreams: Whether to subscribe to and play all remote audio streams.
  /// @see RtcEngine.muteAllRemoteAudioStreams
  Future<void> enableAudio();

  /// Disables the audio module.
  /// Note
  /// - This method affects the internal engine and can be called after calling the leaveChannel method. You can call this method either before or after joining a channel.
  /// @see RtcEngine.leaveChannel
  /// - This method resets the engine and takes some time to take effect. We recommend using the following API methods to control the audio engine modules separately:
  /// -- enableLocalAudio: Whether to enable the microphone to create the local audio stream.
  /// @see RtcEngine.enableLocalAudio
  /// -- muteLocalAudioStream: Whether to publish the local audio stream.
  /// @see RtcEngine.muteLocalAudioStream
  /// -- muteRemoteAudioStream: Whether to subscribe to and play the remote audio stream.
  /// @see RtcEngine.muteRemoteAudioStream
  /// -- muteAllRemoteAudioStreams: Whether to subscribe to and play all remote audio streams.
  /// @see RtcEngine.muteAllRemoteAudioStreams
  Future<void> disableAudio();

  /// Sets the audio parameters and application scenarios.
  /// Note
  /// - You must call this method before calling the joinChannel method.
  /// @see RtcEngine.joinChannel
  /// - In the Communication and Live Broadcast profiles, the bitrates may be different from your settings due to network self-adaptation.
  /// - In scenarios requiring high-quality audio, we recommend setting profile as ShowRoom(4) and scenario as GameStreaming(3). For example, for music education scenarios.
  /// @see AudioScenario.ShowRoom
  /// @see AudioScenario.GameStreaming
  /// @param profile Sets the sample rate, bitrate, encoding mode, and the number of channels.
  /// @see AudioProfile
  /// @param scenario Sets the audio application scenarios. Under different audio scenarios, the device uses different volume tracks, i.e. either the in-call volume or the media volume.
  /// @see AudioScenario
  Future<void> setAudioProfile(AudioProfile profile, AudioScenario scenario);

  /// Adjusts the recording volume.
  /// Note
  /// - To avoid echoes and improve call quality, Agora recommends setting the value of volume between 0 and 100. If you need to set the value higher than 100, contact support@agora.io first.
  /// @param volume Recording volume. The value ranges between 0 and 400:
  /// - 0: Mute.
  /// - 100: Original volume.
  /// - 400: (Maximum) Four times the original volume with signal-clipping protection.
  Future<void> adjustRecordingSignalVolume(int volume);

  /// Adjusts the playback volume of a specified remote user.
  /// You can call this method as many times as necessary to adjust the playback volume of different remote users, or to repeatedly adjust the playback volume of the same remote user.
  /// Note
  /// - Call this method after joining a channel.
  /// - The playback volume here refers to the mixed volume of a specified remote user.
  /// - This method can only adjust the playback volume of one specified remote user at a time. To adjust the playback volume of different remote users, call the method as many times, once for each remote user.
  /// @param uid ID of the remote user.
  /// @param volume The playback volume of the specified remote user. The value ranges from 0 to 100:
  /// - 0: Mute.
  /// - 100: The original volume.
  Future<void> adjustUserPlaybackSignalVolume(int uid, int volume);

  /// Adjusts the playback volume of all remote users.
  /// Note
  /// - This method adjusts the playback volume which is mixed volume of all remote users.
  /// - To mute the local audio playback, call both adjustPlaybackSignalVolume and adjustAudioMixingVolume, and set volume as 0.
  /// @see RtcEngine.adjustPlaybackSignalVolume
  /// @see RtcEngine.adjustAudioMixingVolume
  /// - To avoid echoes and improve call quality, Agora recommends setting the value of volume between 0 and 100. If you need to set the value higher than 100, contact support@agora.io first.
  /// @param volume The playback volume of all remote users. The value ranges from 0 to 400:
  /// - 0: Mute.
  /// - 100: The original volume.
  /// - 400: (Maximum) Four times the original volume with signal clipping protection.
  Future<void> adjustPlaybackSignalVolume(int volume);

  /// Enables/Disables the local audio capture.
  /// The audio function is enabled by default. This method disables/re-enables the local audio function, that is, to stop or restart local audio capture and processing.
  /// This method does not affect receiving or playing the remote audio streams, and enableLocalAudio(false) is applicable to scenarios where the user wants to receive remote audio streams without sending any audio stream to other users in the channel.
  /// The SDK triggers the onMicrophoneEnabled callback once the local audio function is disabled or re-enabled.
  /// @see RtcEngineEvents.MicrophoneEnabled
  /// Note
  /// - This method is different from the muteLocalAudioStream method:
  /// -- enableLocalAudio: Disables/Re-enables the local audio capture and processing. If you disable or re-enable local audio recording using the enableLocalAudio method, the local user may hear a pause in the remote audio playback.
  /// @see RtcEngine.enableLocalAudio
  /// -- muteLocalAudioStream: Stops/Continues sending the local audio streams.
  /// @see RtcEngine.muteLocalAudioStream
  /// @param enabled Sets whether to disable/re-enable the local audio function:
  /// - true: (Default) Re-enable the local audio function, that is, to start local audio capture and processing.
  /// - false: Disable the local audio function, that is, to stop local audio capture and processing.
  Future<void> enableLocalAudio(bool enabled);

  /// Stops/Resumes sending the local audio stream.
  /// A successful muteLocalAudioStream method call triggers the onUserMuteAudio callback on the remote client.
  /// @see RtcEngineEvents.UserMuteAudio
  /// Note
  /// - When muted is set as true, this method does not disable the microphone and thus does not affect any ongoing recording.
  /// - If you call setChannelProfile after this method, the SDK resets whether or not to mute the local audio according to the channel profile and user role. Therefore, we recommend calling this method after the setChannelProfile method.
  /// @see RtcEngine.setChannelProfile
  /// @param muted Sets whether to send/stop sending the local audio stream:
  /// - true: Stop sending the local audio stream.
  /// - false: (Default) Send the local audio stream.
  Future<void> muteLocalAudioStream(bool muted);

  /// Stops/Resumes receiving a specified audio stream.
  /// Note
  /// - If you called the muteAllRemoteAudioStreams method and set muted as true to stop receiving all remote video streams, ensure that the muteAllRemoteAudioStreams method is called and set muted as false before calling this method. The muteAllRemoteAudioStreams method sets all remote audio streams, while the muteRemoteAudioStream method sets a specified remote user's audio stream.
  /// @see RtcEngine.muteAllRemoteAudioStreams
  /// @param uid ID of the specified remote user.
  /// @param muted Sets whether to receive/stop receiving the specified remote user's audio stream:
  /// - true: Stop receiving the specified remote user’s audio stream.
  /// - false: (Default) Receive the specified remote user’s audio stream.
  Future<void> muteRemoteAudioStream(int uid, bool muted);

  /// Stops/Resumes receiving all remote audio streams.
  /// @param muted Sets whether to receive/stop receiving all remote audio streams:
  /// - true: Stop receiving all remote audio streams.
  /// - false: (Default) Receive all remote audio streams.
  Future<void> muteAllRemoteAudioStreams(bool muted);

  /// Sets whether to receive all remote audio streams by default.
  /// You can call this method either before or after joining a channel. If you call setDefaultMuteAllRemoteAudioStreams(true) after joining a channel, you will not receive the audio streams of any subsequent user.
  /// Note
  /// - If you want to resume receiving audio streams, call muteRemoteAudioStream(false), and specify the ID of the remote user that you want to subscribe to. To resume audio streams of multiple users, call muteRemoteAudioStream as many times. Calling setDefaultMuteAllRemoteAudioStreams(false) resumes receiving audio streams of the subsequent users only.
  /// @see RtcEngine.muteRemoteAudioStream
  /// @param muted Sets whether or not to receive/stop receiving the remote audio streams by default:
  /// - true: Stop receiving any audio stream by default.
  /// - false: (Default) Receive all remote audio streams by default.
  Future<void> setDefaultMuteAllRemoteAudioStreams(bool muted);

  /// Enables the onAudioVolumeIndication callback at a set time interval to report on which users are speaking and the speakers' volume.
  /// @see RtcEngineEvents.AudioVolumeIndication
  /// Once this method is enabled, the SDK returns the volume indication in the onAudioVolumeIndication callback at the set time interval, regardless of whether any user is speaking in the channel.
  /// @param interval Sets the time interval between two consecutive volume indications:
  /// - ≤ 0: Disables the volume indication.
  /// - > 0: Time interval (ms) between two consecutive volume indications. We recommend setting interval ≥ 200 ms.
  /// @param smooth The smoothing factor sets the sensitivity of the audio volume indicator. The value ranges between 0 and 10. The greater the value, the more sensitive the indicator. The recommended value is 3.
  /// @param report_vad
  /// - true: Enable the voice activity detection of the local user. Once it is enabled, the vad parameter of the onAudioVolumeIndication callback reports the voice activity status of the local user.
  /// - false: (Default) Disable the voice activity detection of the local user. Once it is enabled, the vad parameter of the onAudioVolumeIndication callback does not report the voice activity status of the local user, except for scenarios where the engine automatically detects the voice activity of the local user.
  Future<void> enableAudioVolumeIndication(
      int interval, int smooth, bool report_vad);
}

mixin RtcVideoInterface {
  /// Enables the video module.
  /// You can call this method either before joining a channel or during a call. If you call this method before joining a channel, the service starts in the video mode. If you call this method during an audio call, the audio mode switches to the video mode.
  /// A successful enableVideo method call triggers the onUserEnableVideo(true) callback on the remote client.
  /// @see RtcEngineEvents.UserEnableVideo
  /// To disable the video, call the disableVideo method.
  /// @see RtcEngine.disableVideo
  /// Note
  /// - This method affects the internal engine and can be called after calling the leaveChannel method. You can call this method either before or after joining a channel.
  /// @see RtcEngine.leaveChannel
  /// - This method resets the internal engine and takes some time to take effect. We recommend using the following API methods to control the video engine modules separately:
  /// -- enableLocalVideo: Whether to enable the camera to create the local video stream.
  /// @see RtcEngine.enableLocalVideo
  /// -- muteLocalVideoStream: Whether to publish the local video stream.
  /// @see RtcEngine.muteLocalVideoStream
  /// -- muteRemoteVideoStream: Whether to subscribe to and play the remote video stream.
  /// @see RtcEngine.muteRemoteVideoStream
  /// -- muteAllRemoteVideoStreams: Whether to subscribe to and play all remote video streams.
  /// @see RtcEngine.muteAllRemoteVideoStreams
  Future<void> enableVideo();

  /// Disables the video module.
  /// You can call this method before joining a channel or during a call. If you call this method before joining a channel, the service starts in audio mode. If you call this method during a video call, the video mode switches to the audio mode.
  /// - A successful disableVideo method call triggers the onUserEnableVideo(false) callback on the remote client.
  /// @see RtcEngineEvents.UserEnableVideo
  /// - To enable the video mode, call the enableVideo method.
  /// @see RtcEngine.enableVideo
  /// Note
  /// - This method affects the internal engine and can be called after calling the leaveChannel method. You can call this method either before or after joining a channel.
  /// @see RtcEngine.leaveChannel
  /// - This method resets the internal engine and takes some time to take effect. We recommend using the following API methods to control the video engine modules separately:
  /// -- enableLocalVideo: Whether to enable the camera to create the local video stream.
  /// @see RtcEngine.enableLocalVideo
  /// -- muteLocalVideoStream: Whether to publish the local video stream.
  /// @see RtcEngine.muteLocalVideoStream
  /// -- muteRemoteVideoStream: Whether to subscribe to and play the remote video stream.
  /// @see RtcEngine.muteRemoteVideoStream
  /// -- muteAllRemoteVideoStreams: Whether to subscribe to and play all remote video streams.
  /// @see RtcEngine.muteAllRemoteVideoStreams
  Future<void> disableVideo();

  /// Sets the video encoder configuration.
  /// Each video encoder configuration corresponds to a set of video parameters, including the resolution, frame rate, bitrate, and video orientation. The parameters specified in this method are the maximum values under ideal network conditions. If the video engine cannot render the video using the specified parameters due to poor network conditions, the parameters further down the list are considered until a successful configuration is found.
  /// If you do not set the video encoder configuration after joining the channel, you can call this method before calling the enableVideo method to reduce the render time of the first video frame.
  /// @see RtcEngine.enableVideo
  /// @param config The local video encoder configuration.
  /// @see VideoEncoderConfiguration
  Future<void> setVideoEncoderConfiguration(VideoEncoderConfiguration config);

  /// Disables/Re-enables the local video capture.
  /// This method disables or re-enables the local video capturer, and does not affect receiving the remote video stream.
  /// After you call the enableVideo method, the local video capturer is enabled by default. You can call enableLocalVideo(false) to disable the local video capturer. If you want to re-enable it, call enableLocalVideo(true).
  /// @see RtcEngine.enableVideo
  /// After the local video capturer is successfully disabled or re-enabled, the SDK triggers the onUserEnableLocalVideo callback on the remote client.
  /// @see RtcEngineEvents.UserEnableLocalVideo
  /// Note
  /// - This method affects the internal engine and can be called after calling the leaveChannel method.
  /// @param enabled Sets whether to disable/re-enable the local video, including the capturer, renderer, and sender:
  /// - true: (Default) Re-enable the local video.
  /// - false: Disable the local video. Once the local video is disabled, the remote users can no longer receive the video stream of this user, while this user can still receive the video streams of other remote users. When you set enabled as false, this method does not require a local camera.
  Future<void> enableLocalVideo(bool enabled);

  /// Stops/Resumes sending the local video stream.
  /// A successful muteLocalVideoStream method call triggers the onUserMuteVideo callback on the remote client.
  /// @see RtcEngineEvents.UserMuteVideo
  /// Note
  /// - When you set muted as true, this method does not disable the camera and thus does not affect the retrieval of the local video streams. This method responds faster than calling the enableLocalVideo method and set muted as false, which controls sending the local video stream.
  /// @see RtcEngine.enableLocalVideo
  /// - If you call setChannelProfile after this method, the SDK resets whether or not to mute the local video according to the channel profile and user role. Therefore, we recommend calling this method after the setChannelProfile method.
  /// @see RtcEngine.setChannelProfile
  /// @param muted Sets whether to send/stop sending the local video stream:
  /// - true: Stop sending the local video stream.
  /// - false: (Default) Send the local video stream.
  Future<void> muteLocalVideoStream(bool muted);

  /// Stops/Resumes receiving a specified remote user's video stream.
  /// Note
  /// - If you call the muteAllRemoteVideoStreams method and set set muted as true to stop receiving all remote video streams, ensure that the muteAllRemoteVideoStreams method is called and set muted as false before calling this method. The muteAllRemoteVideoStreams method sets all remote streams, while this method sets a specified remote user's stream.
  /// @see RtcEngine.muteAllRemoteVideoStreams
  /// @param uid User ID of the specified remote user.
  /// @param muted Sets whether to receive/stop receiving a specified remote user's video stream:
  /// - true: Stop receiving a specified remote user’s video stream.
  /// - false: (Default) Receive a specified remote user’s video stream.
  Future<void> muteRemoteVideoStream(int uid, bool muted);

  /// Stops/Resumes receiving all remote video streams.
  /// @param muted Sets whether to receive/stop receiving all remote video streams:
  /// - true: Stop receiving all remote video streams.
  /// - false: (Default) Receive all remote video streams.
  Future<void> muteAllRemoteVideoStreams(bool muted);

  /// Sets whether to receive all remote video streams by default.
  /// You can call this method either before or after joining a channel. If you call setDefaultMuteAllRemoteVideoStreams(true) after joining a channel, you will not receive the video stream of any subsequent user.
  /// Note
  /// - If you want to resume receiving video streams, call muteRemoteVideoStream(false), and specify the ID of the remote user that you want to subscribe to. To resume receiving video streams of multiple users, call muteRemoteVideoStream as many times. Calling setDefaultMuteAllRemoteVideoStreams(false) resumes receiving video streams of the subsequent users only.
  /// @see RtcEngine.muteRemoteVideoStream
  /// @param muted Sets whether to receive/stop receiving all remote video streams by default:
  /// - true: Stop receiving any remote video stream by default.
  /// - false: (Default) Receive all remote video streams by default.
  Future<void> setDefaultMuteAllRemoteVideoStreams(bool muted);

  /// Enables/Disables image enhancement and sets the options.
  /// Note
  /// - Call this method after calling enableVideo.
  /// - This method applies to Android 4.4 or later.
  /// @param enabled Sets whether or not to enable image enhancement:
  /// - enables image enhancement.
  /// - disables image enhancement.
  /// @param options The image enhancement options.
  /// @see BeautyOptions
  Future<void> setBeautyEffectOptions(bool enabled, BeautyOptions options);
}

mixin RtcAudioMixingInterface {
  /// Starts playing and mixing the music file.
  /// This method mixes the specified local or online audio file with the audio stream from the microphone, or replaces the microphone’s audio stream with the specified local or remote audio file. You can choose whether the other user can hear the local audio playback and specify the number of playback loops. When the audio mixing file playback finishes after calling this method, the SDK triggers the onAudioMixingFinished callback.
  /// @see RtcEngineEvents.AudioMixingFinished
  /// A successful startAudioMixing method call triggers the onAudioMixingStateChanged(Playing) callback on the local client.
  /// @see RtcEngineEvents.AudioMixingStateChanged
  /// @see AudioMixingStateCode.Playing
  /// When the audio mixing file playback finishes, the SDK triggers the onAudioMixingStateChanged(Stopped) callback on the local client.
  /// @see RtcEngineEvents.AudioMixingStateChanged
  /// @see AudioMixingStateCode.Stopped
  /// Note
  /// - To use this method, ensure that the Android device is v4.2 or later, and the API version is v16 or later.
  /// - Call this method when you are in the channel, otherwise it may cause issues.
  /// - If you want to play an online music file, ensure that the time interval between calling this method is more than 100 ms, or the TooFrequentCall = 702 error occurs.
  /// @see AudioMixingErrorCode.TooFrequentCall
  /// - If you want to play an online music file, Agora does not recommend using the redirected URL address. Some Android devices may fail to open a redirected URL address.
  /// - If the local audio mixing file does not exist, or if the SDK does not support the file format or cannot access the music file URL, the SDK returns CanNotOpen = 701.
  /// @see AudioMixingErrorCode.CanNotOpen
  /// - If you call this method on an emulator, only the MP3 file format is supported.
  /// @param filePath Specifies the absolute path (including the suffixes of the filename) of the local or online audio file to be mixed. For example, /sdcard/emulated/0/audio.mp4. Supported audio formats: mp3, mp4, m4a, aac, 3gp, mkv, and wav.
  /// - If the path begins with /assets/, the audio file is in the /assets/ directory.
  /// - Otherwise, the audio file is in the absolute path.
  /// @param loopback Sets which user can hear the audio mixing:
  /// - true: Only the local user can hear the audio mixing.
  /// - false: Both users can hear the audio mixing.
  /// @param replace Sets the audio mixing content:
  /// - true: Only publish the specified audio file; the audio stream from the microphone is not published.
  /// - false: The local audio file is mixed with the audio stream from the microphone.
  /// @param cycle Sets the number of playback loops:
  /// - Positive integer: Number of playback loops
  /// - -1: Infinite playback loops
  Future<void> startAudioMixing(
      String filePath, bool loopback, bool replace, int cycle);

  /// Stops playing or mixing the music file.
  /// Call this method when you are in a channel.
  Future<void> stopAudioMixing();

  /// Pauses playing and mixing the music file.
  /// Call this method when you are in a channel.
  Future<void> pauseAudioMixing();

  /// Resumes playing and mixing the music file.
  /// Call this method when you are in a channel.
  Future<void> resumeAudioMixing();

  /// Adjusts the volume of audio mixing.
  /// Call this method when you are in a channel.
  /// Note
  /// - Calling this method does not affect the volume of the audio effect file playback invoked by the playEffect method.
  /// @see RtcEngine.playEffect
  /// @param volume Audio mixing volume. The value ranges between 0 and 100 (default).
  Future<void> adjustAudioMixingVolume(int volume);

  /// Adjusts the volume of audio mixing for local playback.
  /// Call this method when you are in a channel.
  /// @param volume Audio mixing volume for local playback. The value ranges between 0 and 100 (default).
  Future<void> adjustAudioMixingPlayoutVolume(int volume);

  /// Adjusts the volume of audio mixing for publishing (sending to other users).
  /// Call this method when you are in a channel.
  /// @param volume Audio mixing volume for publishing. The value ranges between 0 and 100 (default).
  Future<void> adjustAudioMixingPublishVolume(int volume);

  /// Gets the audio mixing volume for local playback.
  /// This method helps troubleshoot audio volume related issues.
  Future<int> getAudioMixingPlayoutVolume();

  /// Gets the audio mixing volume for publishing.
  /// This method helps troubleshoot audio volume related issues.
  Future<int> getAudioMixingPublishVolume();

  /// Gets the duration (ms) of the music file.
  /// Call this method when you are in a channel.
  Future<int> getAudioMixingDuration();

  /// Gets the playback position (ms) of the music file.
  /// Call this method when you are in a channel.
  Future<int> getAudioMixingCurrentPosition();

  /// Sets the playback position (ms) of the music file to a different starting position (the default plays from the beginning).
  /// @param pos The playback starting position (ms) of the audio mixing file.
  Future<void> setAudioMixingPosition(int pos);
}

mixin RtcAudioEffectInterface {
  /// Gets the volume of the audio effects.
  /// The value ranges between 0.0 and 100.0.
  Future<double> getEffectsVolume();

  /// Sets the volume of the audio effects.
  /// @param volume Volume of the audio effects. The value ranges between 0.0 and 100.0 (default).
  Future<void> setEffectsVolume(double volume);

  /// Sets the volume of a specified audio effect.
  /// @param soundId ID of the audio effect. Each audio effect has a unique ID.
  /// @param volume Volume of the audio effect. The value ranges between 0.0 and 100.0 (default).
  Future<void> setVolumeOfEffect(int soundId, double volume);

  /// Plays a specified local or online audio effect file.
  /// With this method, you can set the loop count, pitch, pan, and gain of the audio effect file and whether the remote user can hear the audio effect.
  /// To play multiple audio effect files simultaneously, call this method multiple times with different soundIds and filePaths. We recommend playing no more than three audio effect files at the same time.
  /// When the audio effect file playback is finished, the SDK triggers the onAudioEffectFinished callback.
  /// @see RtcEngineEvents.AudioEffectFinished
  /// @param soundId ID of the specified audio effect. Each audio effect has a unique ID. If you preloaded the audio effect into the memory through the preloadEffect method, ensure that the soundID value is set to the same value as in the preloadEffect method.
  /// @see RtcEngine.preloadEffect
  /// @param filePath The absolute file path (including the suffixes of the filename) of the audio effect file or the URL of the online audio effect file. For example, /sdcard/emulated/0/audio.mp4. Supported audio formats: mp3, mp4, m4a, aac. 3gp, mkv, and wav.
  /// @param loopCount Sets the number of times the audio effect loops:
  /// - 0: Plays the audio effect once.
  /// - 1: Plays the audio effect twice.
  /// - -1: Plays the audio effect in a loop indefinitely, until you call the stopEffect or stopAllEffects method.
  /// @see RtcEngine.stopEffect
  /// @see RtcEngine.stopAllEffects
  /// @param pitch Sets the pitch of the audio effect. The value ranges between 0.5 and 2. The default value is 1 (no change to the pitch). The lower the value, the lower the pitch.
  /// @param pan Sets the spatial position of the audio effect. The value ranges between -1.0 and 1.0.
  /// - 0.0: The audio effect shows ahead.
  /// - 1.0: The audio effect shows on the right.
  /// - -1.0: The audio effect shows on the left.
  /// @param gain Sets the volume of the audio effect. The value ranges between 0.0 and 100,0. The default value is 100.0. The lower the value, the lower the volume of the audio effect.
  /// @param publish Set whether or not to publish the specified audio effect to the remote stream:
  /// - true: The locally played audio effect is published to the Agora Cloud and the remote users can hear it.
  /// - false: The locally played audio effect is not published to the Agora Cloud and the remote users cannot hear it.
  Future<void> playEffect(int soundId, String filePath, int loopCount,
      double pitch, double pan, double gain, bool publish);

  /// Stops playing a specified audio effect.
  /// Note
  /// - If you preloaded the audio effect into the memory through the preloadEffect method, ensure that the soundID value is set to the same value as in the preloadEffect method.
  /// @see RtcEngine.preloadEffect
  /// @param soundId ID of the specified audio effect. Each audio effect has a unique ID.
  Future<void> stopEffect(int soundId);

  /// Stops playing all audio effects.
  Future<void> stopAllEffects();

  /// Preloads a specified audio effect file into the memory.
  /// Supported audio formats: mp3, aac, m4a, 3gp, wav.
  /// Note
  /// - This method does not support online audio effect files.
  /// Note
  /// - To ensure smooth communication, limit the size of the audio effect file. We recommend using this method to preload the audio effect before calling the joinChannel method.
  /// @see RtcEngine.joinChannel
  /// @param soundId ID of the audio effect. Each audio effect has a unique ID.
  /// @param filePath Absolute path of the audio effect file.
  Future<void> preloadEffect(int soundId, String filePath);

  /// Releases a specified preloaded audio effect from the memory.
  /// @param soundId ID of the audio effect. Each audio effect has a unique ID.
  Future<void> unloadEffect(int soundId);

  /// Pauses a specified audio effect.
  /// @param soundId ID of the audio effect. Each audio effect has a unique ID.
  Future<void> pauseEffect(int soundId);

  /// Pauses all audio effects.
  Future<void> pauseAllEffects();

  /// Resumes playing a specified audio effect.
  /// @param soundId ID of the audio effect. Each audio effect has a unique ID.
  Future<void> resumeEffect(int soundId);

  /// Resumes playing all audio effects.
  Future<void> resumeAllEffects();
}

mixin RtcVoiceChangerInterface {
  /// Sets the local voice changer option.
  /// Note
  /// - Do not use this method together with setLocalVoiceReverbPreset, or the method called earlier does not take effect.
  /// @see RtcEngine.setLocalVoiceReverbPreset
  /// @param voiceChanger The local voice changer option.
  /// @see AudioVoiceChanger
  Future<void> setLocalVoiceChanger(AudioVoiceChanger voiceChanger);

  /// Sets the preset local voice reverberation effect
  /// Note
  /// - Do not use this method together with setLocalVoiceReverb.
  /// @see RtcEngine.setLocalVoiceReverb
  /// - Do not use this method together with setLocalVoiceChanger, or the method called eariler does not take effect.
  /// @see RtcEngine.setLocalVoiceChanger
  /// @param preset The local voice reverberation preset
  /// @see AudioReverbPreset
  Future<void> setLocalVoiceReverbPreset(AudioReverbPreset preset);

  /// Changes the voice pitch of the local speaker.
  /// @param pitch Sets the voice pitch. The value ranges between 0.5 and 2.0. The lower the value, the lower the voice pitch. The default value is 1.0 (no change to the local voice pitch).
  Future<void> setLocalVoicePitch(double pitch);

  /// Sets the local voice equalization effect.
  /// @param bandFrequency Sets the band frequency. The value ranges between 0 and 9; representing the respective 10-band center frequencies of the voice effects, including 31, 62, 125, 500, 1k, 2k, 4k, 8k, and 16k Hz.
  /// @see AudioEqualizationBandFrequency
  /// @param bandGain Sets the gain of each band (dB). The value ranges between -15 and 15. The default value is 0.
  Future<void> setLocalVoiceEqualization(
      AudioEqualizationBandFrequency bandFrequency, int bandGain);

  /// Sets the local voice reverberation.
  /// Note
  /// - Adds the setLocalVoiceReverbPreset method, a more user-friendly method for setting the local voice reverberation. You can use this method to set the local reverberation effect, such as Popular, R&B, Rock, Hip-hop, and more.
  /// @see RtcEngine.setLocalVoiceReverbPreset
  /// @param reverbKey Sets the reverberation key. This method contains five reverberation keys. For details, see the description of each @ value.
  /// @see AudioReverbType
  /// @param value Sets the local voice reverberation value.
  Future<void> setLocalVoiceReverb(AudioReverbType reverbKey, int value);
}

mixin RtcVoicePositionInterface {
  /// Enables/Disables stereo panning for remote users.
  /// Ensure that you call this method before joinChannel to enable stereo panning for remote users so that the local user can track the position of a remote user by calling setRemoteVoicePosition.
  /// @see RtcEngine.joinChannel
  /// @see RtcEngine.setRemoteVoicePosition
  /// @param enabled Sets whether or not to enable stereo panning for remote users:
  /// - true: enables stereo panning.
  /// - false: disables stereo panning.
  Future<void> enableSoundPositionIndication(bool enabled);

  /// Sets the sound position of a remote user.
  /// When the local user calls this method to set the sound position of a remote user, the sound difference between the left and right channels allows the local user to track the real-time position of the remote user, creating a real sense of space. This method applies to massively multiplayer online games, such as Battle Royale games.
  /// Note
  /// - For this method to work, enable stereo panning for remote users by calling the enableSoundPositionIndication method before joining a channel.
  /// @see RtcEngine.enableSoundPositionIndication
  /// - This method requires hardware support. For the best sound positioning, we recommend using a stereo headset.
  /// @param uid The ID of the remote user.
  /// @param pan The sound position of the remote user. The value ranges from -1.0 to 1.0:
  /// - 0.0: The remote sound comes from the front.
  /// - -1.0: The remote sound comes from the left.
  /// - 1.0: The remote sound comes from the right.
  /// @param gain Gain of the remote user. The value ranges from 0.0 to 100.0. The default value is 100.0 (the original gain of the remote user). The smaller the value, the less the gain.
  Future<void> setRemoteVoicePosition(int uid, double pan, double gain);
}

mixin RtcPublishStreamInterface {
  /// Sets the video layout and audio settings for CDN live.
  /// The SDK triggers the onTranscodingUpdated callback when you call this method to update the LiveTranscodingclass. If you call this method to set the LiveTranscoding class for the first time, the SDK does not trigger the onTranscodingUpdated callback.
  /// @see RtcEngineEvents.TranscodingUpdated
  /// Note
  /// - Before calling the methods listed in this section:
  /// -- This method applies to Live Broadcast only.
  /// -- Ensure that you enable the RTMP Converter service before using this function. See Prerequisites.
  /// -- Ensure that you call the setClientRole method and set the user role as the host.
  /// @see RtcEngine.setClientRole
  /// -- Ensure that you call the setLiveTranscoding method before calling the addPublishStreamUrl method.
  /// @see RtcEngine.addPublishStreamUrl
  /// @param transcoding Sets the CDN live audio/video transcoding settings.
  /// @see LiveTranscoding
  Future<void> setLiveTranscoding(LiveTranscoding transcoding);

  /// Publishes the local stream to the CDN.
  /// The addPublishStreamUrl method call triggers the onRtmpStreamingStateChanged callback on the local client to report the state of adding a local stream to the CDN.
  /// @see RtcEngineEvents.RtmpStreamingStateChanged
  /// Note
  /// - Ensure that you enable the RTMP Converter service before using this function. See Prerequisites.
  /// - This method applies to Live Broadcast only.
  /// - Ensure that the user joins a channel before calling this method.
  /// - This method adds only one stream HTTP/HTTPS URL address each time it is called.
  /// @param url The CDN streaming URL in the RTMP format. The maximum length of this parameter is 1024 bytes. The URL address must not contain special characters, such as Chinese language characters.
  /// @param transcodingEnabled Sets whether transcoding is enabled/disabled. If you set this parameter as true, ensure that you call the setLiveTranscoding method before this method.
  /// @see RtcEngine.setLiveTranscoding
  /// - true: Enable transcoding. To transcode the audio or video streams when publishing them to CDN live, often used for combining the audio and video streams of multiple hosts in CDN live.
  /// - false: Disable transcoding.
  Future<void> addPublishStreamUrl(String url, bool transcodingEnabled);

  /// Removes an RTMP stream from the CDN.
  /// This method removes the RTMP URL address (added by addPublishStreamUrl) from a CDN live stream. The SDK reports the result of this method call in the onRtmpStreamingStateChanged callback.
  /// @see RtcEngine.addPublishStreamUrl
  /// @see RtcEngineEvents.RtmpStreamingStateChanged
  /// Note
  /// - Ensure that you enable the RTMP Converter service before using this function. See Prerequisites.
  /// - Ensure that the user joins a channel before calling this method.
  /// - This method applies to Live Broadcast only.
  /// - This method removes only one stream RTMP URL address each time it is called.
  /// @param url The RTMP URL address to be removed. The maximum length of this parameter is 1024 bytes. The URL address must not contain special characters, such as Chinese language characters.
  Future<void> removePublishStreamUrl(String url);
}

mixin RtcMediaRelayInterface {
  /// Starts to relay media streams across channels.
  /// After a successful method call, the SDK triggers the onChannelMediaRelayStateChanged and onChannelMediaRelayEvent callbacks, and these callbacks return the state and events of the media stream relay.
  /// @see RtcEngineEvents.ChannelMediaRelayStateChanged
  /// @see RtcEngineEvents.ChannelMediaRelayEvent
  /// - If the onChannelMediaRelayStateChanged callback returns Running(2) and None(0), and the onChannelMediaRelayEvent callback returns SentToDestinationChannel(4), the SDK starts relaying media streams between the original and the destination channel.
  /// @see ChannelMediaRelayState.Running
  /// @see ChannelMediaRelayError.None
  /// @see ChannelMediaRelayEvent.SentToDestinationChannel
  /// - If the onChannelMediaRelayStateChanged callback returns Failure(3), an exception occurs during the media stream relay.
  /// @see ChannelMediaRelayState.Failure
  /// Note
  /// - Contact sales-us@agora.io before implementing this function.
  /// - We do not support string user accounts in this API.
  /// - Call this method after the joinChannel method.
  /// @see RtcEngine.joinChannel
  /// - This method takes effect only when you are a broadcaster in a Live-broadcast channel.
  /// - After a successful method call, if you want to call this method again, ensure that you call the stopChannelMediaRelay method to quit the current relay.
  /// @see RtcEngine.stopChannelMediaRelay
  /// @param channelMediaRelayConfiguration The configuration of the media stream relay.
  /// @see ChannelMediaRelayConfiguration
  Future<void> startChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration);

  /// Updates the channels for media relay.
  /// After the channel media relay starts, if you want to relay the media stream to more channels, or leave the current relay channel, you can call the updateChannelMediaRelay method.
  /// After a successful method call, the SDK triggers the onChannelMediaRelayEvent callback with the UpdateDestinationChannel(7) state code.
  /// @see RtcEngineEvents.ChannelMediaRelayEvent
  /// @see ChannelMediaRelayEvent.UpdateDestinationChannel
  /// Note
  /// - Call this method after the startChannelMediaRelay method to update the destination channel.
  /// @see RtcEngine.startChannelMediaRelay
  /// - This method supports adding at most four destination channels in the relay. If there are already four destination channels in the relay.
  /// @param channelMediaRelayConfiguration The media stream relay configuration
  /// @see ChannelMediaRelayConfiguration
  Future<void> updateChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration);

  /// Stops the media stream relay.
  /// Once the relay stops, the broadcaster quits all the destination channels.
  /// After a successful method call, the SDK triggers the onChannelMediaRelayStateChanged callback. If the callback returns Idle(0) and None(0), the broadcaster successfully stops the relay.
  /// @see RtcEngineEvents.ChannelMediaRelayStateChanged
  /// @see ChannelMediaRelayState.Idle
  /// @see ChannelMediaRelayError.None
  /// Note
  /// - If the method call fails, the SDK triggers the onChannelMediaRelayStateChanged callback with the ServerNoResponse(2) or ServerConnectionLost(8) state code. You can leave the channel by calling the leaveChannel method, and the media stream relay automatically stops.
  /// @see RtcEngineEvents.ChannelMediaRelayStateChanged
  /// @see ChannelMediaRelayError.ServerNoResponse
  /// @see ChannelMediaRelayError.ServerConnectionLost
  /// @see RtcEngine.leaveChannel
  Future<void> stopChannelMediaRelay();
}

mixin RtcAudioRouteInterface {
  /// Sets the default audio playback route.
  /// This method sets whether the received audio is routed to the earpiece or speakerphone by default before joining a channel. If a user does not call this method, the audio is routed to the earpiece by default. If you need to change the default audio route after joining a channel, call the setEnableSpeakerphone method.
  /// @see RtcEngine.setEnableSpeakerphone
  /// The default audio route for each scenario:
  /// - In the Communication profile:
  /// @see ChannelProfile.Communication
  /// -- For a voice call, the default audio route is the earpiece.
  /// -- For a video call, the default audio route is the speaker. If the user disables the video using disableVideo, or muteLocalVideoStream and muteAllRemoteVideoStreams, the default audio route automatically switches back to the earpiece.
  /// @see RtcEngine.disableVideo
  /// @see RtcEngine.muteLocalVideoStream
  /// @see RtcEngine.muteAllRemoteVideoStreams
  /// - In the Live Broadcast profile: The default audio route is the speaker.
  /// @see ChannelProfile.LiveBroadcasting
  /// Note
  /// - This method applies to the Communication profile only.
  /// - Call this method before the user joins a channel.
  /// @param defaultToSpeaker Sets the default audio route:
  /// - true: Route the audio to the speaker. If the playback device connects to the earpiece or Bluetooth, the audio cannot be routed to the earpiece.
  /// - false: (Default) Route the audio to the earpiece. If a headset is plugged in, the audio is routed to the headset.
  Future<void> setDefaultAudioRoutetoSpeakerphone(booldefaultToSpeaker);

  /// Enables/Disables the audio playback route to the speakerphone.
  /// This method sets whether the audio is routed to the speakerphone or earpiece. After calling this method, the SDK returns the onAudioRouteChanged callback to indicate the changes.
  /// @see RtcEngineEvents.AudioRouteChanged
  /// Note
  /// - Ensure that you have successfully called the joinChannel method before calling this method.
  /// @see RtcEngine.joinChannel
  /// - This method is invalid for audience users in the Live Broadcast profile.
  /// @see ChannelProfile.LiveBroadcasting
  /// @param enabled Sets whether to route the audio to the speakerphone or earpiece:
  /// - true: Route the audio to the speakerphone.
  /// - false: Route the audio to the earpiece. If the headset is plugged in, the audio is routed to the headset.
  Future<void> setEnableSpeakerphone(bool enabled);

  /// Checks whether the speakerphone is enabled.
  Future<bool> isSpeakerphoneEnabled();
}

mixin RtcEarMonitoringInterface {
  /// Enables in-ear monitoring.
  /// @param enabled Sets whether to enable/disable in-ear monitoring:
  /// - true: Enable.
  /// - false: (Default) Disable.
  Future<void> enableInEarMonitoring(bool enabled);

  /// Sets the volume of the in-ear monitor.
  /// @param volume Sets the volume of the in-ear monitor. The value ranges between 0 and 100 (default).
  Future<void> setInEarMonitoringVolume(int volume);
}

mixin RtcDualStreamInterface {
  /// Enables/Disables the dual video stream mode.
  /// If dual-stream mode is enabled, the receiver can choose to receive the high stream (high-resolution high-bitrate video stream) or low stream (low-resolution low-bitrate video stream) video.
  /// @param enabled Sets the stream mode:
  /// - true: Dual-stream mode.
  /// - false: (Default) Single-stream mode.
  Future<void> enableDualStreamMode(bool enabled);

  /// Sets the stream type of the remote video.
  /// Under limited network conditions, if the publisher has not disabled the dual-stream mode using enableDualStreamMode(false), the receiver can choose to receive either the high-video stream (the high resolution, and high bitrate video stream) or the low-video stream (the low resolution, and low bitrate video stream).
  /// @see RtcEngine.enableDualStreamMode
  /// By default, users receive the high-video stream. Call this method if you want to switch to the low-video stream. This method allows the app to adjust the corresponding video stream type based on the size of the video window to reduce the bandwidth and resources.
  /// The aspect ratio of the low-video stream is the same as the high-video stream. Once the resolution of the high-video stream is set, the system automatically sets the resolution, frame rate, and bitrate of the low-video stream.
  /// The SDK reports the result of calling this method in the onApiCallExecuted callback.
  /// @see RtcEngineEvents.ApiCallExecuted
  /// @param uid ID of the remote user sending the video stream.
  /// @param streamType Sets the video-stream type.
  /// @see VideoStreamType
  Future<void> setRemoteVideoStreamType(int uid, VideoStreamType streamType);

  /// Sets the default video-stream type of the remotely subscribed video stream when the remote user sends dual streams.
  /// @param streamType Sets the default video-stream type.
  /// @see VideoStreamType
  Future<void> setRemoteDefaultVideoStreamType(VideoStreamType streamType);
}

mixin RtcFallbackInterface {
  /// Sets the fallback option for the locally published video stream based on the network conditions.
  /// If option is set as AudioOnly(2), the SDK will:
  /// @see StreamFallbackOptions.AudioOnly
  /// - Disable the upstream video but enable audio only when the network conditions deteriorate and cannot support both video and audio.
  /// - Re-enable the video when the network conditions improve.
  /// When the locally published video stream falls back to audio only or when the audio-only stream switches back to the video, the SDK triggers the onLocalPublishFallbackToAudioOnly.
  /// @see RtcEngineEvents.LocalPublishFallbackToAudioOnly
  /// Note
  /// - Agora does not recommend using this method for CDN live streaming, because the remote CDN live user will have a noticeable lag when the locally published video stream falls back to audio only.
  /// @param option Sets the fallback option for the locally published video stream.
  /// @see StreamFallbackOptions
  Future<void> setLocalPublishFallbackOption(StreamFallbackOptions option);

  /// Sets the fallback option for the remotely subscribed video stream based on the network conditions.
  /// If option is set as AudioOnly(2), the SDK automatically switches the video from a high-stream to a low-stream, or disables the video when the downlink network condition cannot support both audio and video to guarantee the quality of the audio. The SDK monitors the network quality and restores the video stream when the network conditions improve. When the remotely subscribed video stream falls back to audio only, or the audio-only stream switches back to the video, the SDK triggers the onRemoteSubscribeFallbackToAudioOnly callback.
  /// @see StreamFallbackOptions.AudioOnly
  /// @see RtcEngineEvents.RemoteSubscribeFallbackToAudioOnly
  /// @param option Sets the fallback option for the remotely subscribed video stream.
  /// @see StreamFallbackOptions
  Future<void> setRemoteSubscribeFallbackOption(StreamFallbackOptions option);

  /// Sets the priority of a remote user's media stream.
  /// Use this method with the setRemoteSubscribeFallbackOption method. If the fallback function is enabled for a subscribed stream, the SDK ensures the high-priority user gets the best possible stream quality.
  /// @see RtcEngine.setRemoteSubscribeFallbackOption
  /// Note
  /// - The Agora SDK supports setting userPriority as high for one user only.
  /// @param uid The ID of the remote user.
  /// @param userPriority The priority of the remote user.
  /// @see UserPriority
  Future<void> setRemoteUserPriority(int uid, UserPriority userPriority);
}

mixin RtcTestInterface {
  /// Starts an audio call test.
  /// In the audio call test, you record your voice. If the recording plays back within the set time interval, the audio devices and the network connection are working properly.
  /// Note
  /// - Call this method before joining a channel.
  /// - After calling this method, call the stopEchoTest method to end the test. Otherwise, the app cannot run the next echo test, or call the joinChannel method.
  /// @see RtcEngine.stopEchoTest
  /// @see RtcEngine.joinChannel
  /// - In the Live Broadcast profile, only a host can call this method.
  /// @param intervalInSeconds The time interval (s) between when you speak and when the recording plays back.
  Future<void> startEchoTest(int intervalInSeconds);

  /// Stops the audio call test.
  Future<void> stopEchoTest();

  /// Enables the network connection quality test.
  /// This method tests the quality of the users' network connections and is disabled by default.
  /// Before users join a channel or before an audience switches to a host, call this method to check the uplink network quality. This method consumes additional network traffic, which may affect the communication quality. Call the disableLastmileTest method to disable this test after receiving the onLastmileQuality callback, and before the user joins a channel or switches the user role.
  /// @see RtcEngine.disableLastmileTest
  /// @see RtcEngineEvents.LastmileQuality
  /// Note
  /// - Do not use this method with the startLastmileProbeTest method.
  /// @see RtcEngine.startLastmileProbeTest
  /// - Do not call any other methods before receiving the onLastmileQuality callback. Otherwise, the callback may be interrupted by other methods and may not execute.
  /// @see RtcEngineEvents.LastmileQuality
  /// - In the Live Broadcast profile, a host should not call this method after joining a channel.
  /// - If you call this method to test the last-mile quality, the SDK consumes the bandwidth of a video stream, whose bitrate corresponds to the bitrate you set in the setVideoEncoderConfiguration method. After you join the channel, whether you have called the disableLastmileTest method or not, the SDK automatically stops consuming the bandwidth.
  /// @see RtcEngine.setVideoEncoderConfiguration
  /// @see RtcEngine.disableLastmileTest
  Future<void> enableLastmileTest();

  /// Disables the network connection quality test.
  Future<void> disableLastmileTest();

  /// Starts the last-mile network probe test before joining a channel to get the uplink and downlink last-mile network statistics, including the bandwidth, packet loss, jitter, and round-trip time (RTT).
  /// Once this method is enabled, the SDK returns the following callbacks:
  /// - onLastmileQuality: the SDK triggers this callback within two seconds depending on the network conditions. This callback rates the network conditions with a score and is more closely linked to the user experience.
  /// @see RtcEngineEvents.LastmileQuality
  /// - onLastmileProbeResult: the SDK triggers this callback within 30 seconds depending on the network conditions. This callback returns the real-time statistics of the network conditions and is more objective.
  /// @see RtcEngineEvents.LastmileProbeResult
  /// Call this method to check the uplink network quality before users join a channel or before an audience switches to a host.
  /// Note
  /// - This method consumes extra network traffic and may affect communication quality. We do not recommend calling this method together with enableLastmileTest.
  /// @see RtcEngine.enableLastmileTest
  /// - Do not call other methods before receiving the onLastmileQuality and onLastmileProbeResult callbacks. Otherwise, the callbacks may be interrupted by other methods.
  /// - In the Live Broadcast profile, a host should not call this method after joining a channel.
  /// @see ChannelProfile.LiveBroadcasting
  /// @param config The configurations of the last-mile network probe test.
  /// @see LastmileProbeConfig
  Future<void> startLastmileProbeTest(LastmileProbeConfig config);

  /// Stops the last-mile network probe test.
  Future<void> stopLastmileProbeTest();
}

mixin RtcMediaMetadataInterface {
  /// Registers the metadata observer.
  /// This method enables you to add synchronized metadata in the video stream for more diversified live broadcast interactions, such as sending shopping links, digital coupons, and online quizzes.
  /// Note
  /// - Call this method before the joinChannel method.
  /// @see RtcEngine.joinChannel
  Future<void> registerMediaMetadataObserver();

  /// TODO
  Future<void> unregisterMediaMetadataObserver();

  /// TODO
  /// @param size
  Future<void> setMaxMetadataSize(int size);

  /// TODO
  /// @param metadata
  Future<void> sendMetadata(String metadata);
}

mixin RtcWatermarkInterface {
  /// Adds a watermark image to the local video.
  /// This method adds a PNG watermark image to the local video stream in a live broadcast. Once the watermark image is added, all the audience in the channel (CDN audience included), and the recording device can see and capture it.
  /// Agora supports adding only one watermark image onto the local video, and the newly watermark image replaces the previous one.
  /// The watermark position depends on the settings in the setVideoEncoderConfiguration method:
  /// @see RtcEngine.setVideoEncoderConfiguration
  /// - If the orientation mode of the encoding video is FixedLandscape, or the landscape mode in Adaptative, the watermark uses the landscape orientation.
  /// @see VideoOutputOrientationMode.FixedLandscape
  /// @see VideoOutputOrientationMode.Adaptative
  /// - If the orientation mode of the encoding video is FixedPortrait, or the portrait mode in Adaptative, the watermark uses the portrait orientation.
  /// @see VideoOutputOrientationMode.FixedPortrait
  /// @see VideoOutputOrientationMode.Adaptative
  /// - When setting the watermark position, the region must be less than the dimensions set in the setVideoEncoderConfiguration method. Otherwise, the watermark image will be cropped.
  /// Note
  /// - Ensure that you have called the enableVideo method to enable the video module before calling this method.
  /// @see RtcEngine.enableVideo
  /// - If you only want to add a watermark image to the local video for the audience in the CDN live broadcast channel to see and capture, you can call this method or the setLiveTranscoding method.
  /// @see RtcEngine.setLiveTranscoding
  /// - This method supports adding a watermark image in the PNG file format only. Supported pixel formats of the PNG image are RGBA, RGB, Palette, Gray, and Alpha_gray.
  /// - If the dimensions the PNG image differ from your settings in this method, the image will be cropped or zoomed to conform to your settings.
  /// - If you have enabled the local video preview by calling the startPreview method, you can use the visibleInPreview member in the WatermarkOptions class to set whether or not the watermark is visible in preview.
  /// - If you have enabled the mirror mode for the local video, the watermark on the local video is also mirrored. To avoid mirroring the watermark, Agora recommends that you do not use the mirror and watermark functions for the local video at the same time. You can implement the watermark function in your application layer.
  /// @param watermarkUrl The local file path of the watermark image to be added. This method supports adding a watermark image from either the local file path or the assets file path. If you use the assets file path, you need to start with /assets/ when filling in this parameter.
  /// @param options The options of the watermark image to be added.
  /// @see WatermarkOptions
  Future<void> addVideoWatermark(String watermarkUrl, WatermarkOptions options);

  /// Removes the watermark image from the video stream added by addVideoWatermark.
  /// @see RtcEngine.addVideoWatermark
  Future<void> clearVideoWatermarks();
}

mixin RtcEncryptionInterface {
  /// Enables built-in encryption with an encryption password before joining a channel.
  /// All users in a channel must set the same encryption password. The encryption password is automatically cleared once a user leaves the channel. If the encryption password is not specified or set to empty, the encryption functionality is disabled.
  /// Note
  /// - For optimal transmission, ensure that the encrypted data size does not exceed the original data size + 16 bytes. 16 bytes is the maximum padding size for AES encryption.
  /// - Do not use this method for CDN live streaming.
  /// @param secret The encryption password.
  Future<void> setEncryptionSecret(String secret);

  /// Sets the built-in encryption mode.
  /// The Agora SDK supports built-in encryption, which is set to aes-128-xts mode by default. Call this method to set the encryption mode to use other encryption modes. All users in the same channel must use the same encryption mode and password.
  /// Refer to the information related to the AES encryption algorithm on the differences between the encryption modes.
  /// Note
  /// - Call the setEncryptionSecret method before calling this method.
  /// @see RtcEngine.setEncryptionSecret
  /// @param encryptionMode Sets the encryption mode.
  /// @see EncryptionMode
  Future<void> setEncryptionMode(EncryptionMode encryptionMode);
}

mixin RtcAudioRecorderInterface {
  /// Starts an audio recording on the client.
  /// The SDK allows recording during a call. After successfully calling this method, you can record the audio of all the users in the channel and get an audio recording file.
  /// Supported formats of the recording file are as follows:
  /// - .wav: Large file size with high fidelity.
  /// - .aac: Small file size with low fidelity.
  /// Note
  /// - Ensure that the directory to save the recording file exists and is writable.
  /// - This method is usually called after calling the joinChannel method. The recording automatically stops when you call the leaveChannel method.
  /// @see RtcEngine.joinChannel
  /// @see RtcEngine.leaveChannel
  /// - For better recording effects, set quality as AUDIO_RECORDING_QUALITY_MEDIUM or AUDIO_RECORDING_QUALITY_HIGH when sampleRate is 44.1 kHz or 48 kHz.
  /// @see AudioRecordingQuality.Medium
  /// @see AudioRecordingQuality.High
  /// @param filePath Absolute file path (including the suffixes of the filename) of the recording file. The string of the file name is in UTF-8. For example, /sdcard/emulated/0/audio/aac.
  /// @param sampleRate Sample rate (Hz) of the recording file. Supported values are as follows.
  /// @see AudioSampleRateType
  /// @param quality The audio recording quality.
  /// @see AudioRecordingQuality
  Future<void> startAudioRecording(String filePath,
      AudioSampleRateType sampleRate, AudioRecordingQuality quality);

  /// Stops the audio recording on the client.
  /// Note
  /// - You can call this method before calling the leaveChannel method; else, the recording automatically stops when you call the leaveChannel method.
  /// @see RtcEngine.leaveChannel
  Future<void> stopAudioRecording();
}

mixin RtcInjectStreamInterface {
  /// Injects an online media stream to a live broadcast.
  /// If this method call is successful, the server pulls the voice or video stream and injects it into a live channel. This is applicable to scenarios where all audience members in the channel can watch a live show and interact with each other.
  /// Note
  /// - This method applies to the Live-Broadcast profile only.
  /// - Ensure that you enable the RTMP Converter service before using this function. See Prerequisites.
  /// - You can inject only one media stream into the channel at the same time.
  /// The addInjectStreamUrl method call triggers the following callbacks:
  /// - The local client:
  /// -- onStreamInjectedStatus, with the state of the injecting the online stream.
  /// @see RtcEngineEvents.StreamInjectedStatus
  /// -- onUserJoined(uid: 666), if the method call is successful and the online media stream is injected into the channel.
  /// @see RtcEngineEvents.UserJoined
  /// - The remote client:
  /// -- onUserJoined(uid: 666), if the method call is successful and the online media stream is injected into the channel.
  /// @see RtcEngineEvents.UserJoined
  /// @param url The URL address to be added to the ongoing live broadcast. Valid protocols are RTMP, HLS, and HTTP-FLV.
  /// - Supported audio codec type: AAC.
  /// - Supported video codec type: H264(AVC).
  /// @param config The LiveInjectStreamConfig object which contains the configuration information for the added voice or video stream.
  /// @see LiveInjectStreamConfig
  Future<void> addInjectStreamUrl(String url, LiveInjectStreamConfig config);

  /// Removes the injected online media stream from a live broadcast.
  /// This method removes the URL address (added by addInjectStreamUrl) from a live broadcast.
  /// @see RtcEngine.addInjectStreamUrl
  /// If this method call is successful, the SDK triggers the onUserOffline callback and returns a stream uid of 666.
  /// @see RtcEngineEvents.UserOffline
  /// @param url HTTP/HTTPS URL address of the added stream to be removed.
  Future<void> removeInjectStreamUrl(String url);
}

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
  /// @param factor Sets the camera zoom factor. The value ranges between 1.0 and the maximum zoom supported by the device.
  Future<void> setCameraZoomFactor(double factor);

  /// Gets the maximum zoom ratio supported by the camera.
  Future<double> getCameraMaxZoomFactor();

  /// Sets the camera manual focus position.
  /// A successful setCameraFocusPositionInPreview method call triggers the onCameraFocusAreaChanged callback on the local client.
  /// @see RtcEngineEvents.CameraFocusAreaChanged
  /// @param positionX The horizontal coordinate of the touch point in the view.
  /// @param positionY The vertical coordinate of the touch point in the view.
  Future<void> setCameraFocusPositionInPreview(
      double positionX, double positionY);

  /// Sets the camera exposure position.
  /// A successful setCameraExposurePosition method call triggers the onCameraExposureAreaChanged callback on the local client.
  /// @see RtcEngineEvents.CameraExposureAreaChanged
  /// @param positionXinView The horizontal coordinate of the touch point in the view.
  /// @param positionYinView The vertical coordinate of the touch point in the view.
  Future<void> setCameraExposurePosition(
      double positionXinView, double positionYinView);

  /// Enables the camera flash function.
  /// @param isOn Sets whether to enable/disable the camera flash function:
  /// - true: Enable the camera flash function.
  /// - false: Disable the camera flash function.
  Future<void> setCameraTorchOn(bool isOn);

  /// Enables the camera auto-face focus function.
  /// @param enabled Sets whether to enable/disable the camera auto-face focus function:
  /// - true: Enable the camera auto-face focus function.
  /// - false: (Default) Disable the camera auto-face focus function.
  Future<void> setCameraAutoFocusFaceModeEnabled(bool enabled);

  /// Sets the camera capturer configuration.
  /// For a video call or live broadcast, generally the SDK controls the camera output parameters. When the default camera capture settings do not meet special requirements or cause performance problems, we recommend using this method to set the camera capturer configuration:
  /// - If the resolution or frame rate of the captured raw video data are higher than those set by setVideoEncoderConfiguration, processing video frames requires extra CPU and RAM usage and degrades performance. We recommend setting config as Performance(1) to avoid such problems.
  /// @see RtcEngine.setVideoEncoderConfiguration
  /// @see CameraCaptureOutputPreference.Performance
  /// - If you do not need local video preview or are willing to sacrifice preview quality, we recommend setting config as Performance(1) to optimize CPU and RAM usage.
  /// @see CameraCaptureOutputPreference.Performance
  /// - If you want better quality for the local video preview, we recommend setting config as Preview(2).
  /// @see CameraCaptureOutputPreference.Preview
  /// Note
  /// - Call this method before enabling the local camera. That said, you can call this method before calling joinChannel, enableVideo, or enableLocalVideo, depending on which method you use to turn on your local camera.
  /// @see RtcEngine.joinChannel
  /// @see RtcEngine.enableVideo
  /// @see RtcEngine.enableLocalVideo
  /// @param config The camera capturer configuration.
  /// @see CameraCapturerConfiguration
  Future<void> setCameraCapturerConfiguration(
      CameraCapturerConfiguration config);
}

mixin RtcStreamMessageInterface {
  /// Creates a data stream.
  /// Each user can create up to five data streams during the lifecycle of the RtcEngine.
  /// @see RtcEngine
  /// Note
  /// - Set both the reliable and ordered parameters to true or false. Do not set one as true and the other as false.
  /// @param reliable Sets whether or not the recipients are guaranteed to receive the data stream from the sender within five seconds:
  /// - true: The recipients receive the data from the sender within five seconds. If the recipient does not receive the data within five seconds, the SDK triggers the onStreamMessageError callback and returns an error code.
  /// @see RtcEngineEvents.StreamMessageError
  /// - false: There is no guarantee that the recipients receive the data stream within five seconds and no error message is reported for any delay or missing data stream.
  /// @param ordered Sets whether or not the recipients receive the data stream in the sent order:
  /// - true: The recipients receive the data in the sent order.
  /// - false: The recipients do not receive the data in the sent order.
  Future<int> createDataStream(bool reliable, bool ordered);

  /// Sends data stream messages.
  /// The SDK has the following restrictions on this method:
  /// - Up to 30 packets can be sent per second in a channel with each packet having a maximum size of 1 kB.
  /// - Each client can send up to 6 kB of data per second.
  /// - Each user can have up to five data channels simultaneously.
  /// A successful sendStreamMessage method call triggers the onStreamMessage callback on the remote client, from which the remote user gets the stream message.
  /// @see RtcEngineEvents.StreamMessage
  /// A failed sendStreamMessage method call triggers the onStreamMessageError callback on the remote client.
  /// @see RtcEngineEvents.StreamMessageError
  /// Note
  /// - Ensure that you have created the data stream using createDataStream before calling this method.
  /// @see RtcEngine.createDataStream
  /// - This method applies only to the Communication profile or to hosts in the Live Broadcast profile.
  /// @param streamId ID of the sent data stream returned by the createDataStream method.
  /// @see RtcEngine.createDataStream
  /// @param message Sent data.
  Future<void> sendStreamMessage(int streamId, String message);
}
