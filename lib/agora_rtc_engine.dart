import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'src/base.dart';

export 'src/agora_render_widget.dart';
export 'src/base.dart';

class AgoraRtcEngine {
  static const MethodChannel _channel = const MethodChannel('agora_rtc_engine');

  // Core Events
  /// Reports a warning during SDK runtime.
  ///
  /// In most cases, the app can ignore the warning reported by the SDK because the SDK can usually fix the issue and resume running.
  static void Function(int warn) onWarning;

  /// Reports an error during SDK runtime.
  ///
  /// In most cases, the SDK cannot fix the issue and resume running. The SDK requires the app to take action or informs the user about the issue.
  static void Function(int err) onError;

  /// Occurs when a user joins a specified channel.
  ///
  /// The channel name assignment is based on channelName specified in the [joinChannel] method.
  /// If the uid is not specified when [joinChannel] is called, the server automatically assigns a uid.
  static void Function(String channel, int uid, int elapsed)
      onJoinChannelSuccess;

  /// Occurs when a user rejoins the channel after being disconnected due to network problems.
  ///
  /// When a user loses connection with the server because of network problems, the SDK automatically tries to reconnect and triggers this callback upon reconnection.
  static void Function(String channel, int uid, int elapsed)
      onRejoinChannelSuccess;

  /// Occurs when a user leaves the channel.
  ///
  /// When the app calls the [leaveChannel] method, the SDK uses this callback to notify the app when the user leaves the channel.
  static VoidCallback onLeaveChannel;

  /// Occurs when the user role switches in a live broadcast.
  static void Function(ClientRole oldRole, ClientRole newRole)
      onClientRoleChanged;

  /// Occurs when a remote user (Communication)/host (Live Broadcast) joins the channel.
  ///
  /// Communication profile: This callback notifies the app when another user joins the channel. If other users are already in the channel, the SDK also reports to the app on the existing users.
  /// Live-broadcast profile: This callback notifies the app when the host joins the channel. If other hosts are already in the channel, the SDK also reports to the app on the existing hosts. Agora recommends having at most 17 hosts in a channel
  static void Function(int uid, int elapsed) onUserJoined;

  /// Occurs when a remote user (Communication)/host (Live Broadcast) leaves the channel.
  ///
  /// There are two reasons for users to become offline:
  /// 1. Leave the channel: When the user/host leaves the channel, the user/host sends a goodbye message. When this message is received, the SDK determines that the user/host leaves the channel.
  /// 2. Drop offline: When no data packet of the user or host is received for a certain period of time (20 seconds for the communication profile, and more for the live broadcast profile), the SDK assumes that the user/host drops offline. A poor network connection may lead to false detections, so Agora recommends using the signaling system for reliable offline detection.
  static void Function(int uid, int elapsed) onUserOffline;

  /// Occurs when the network connection state changes.
  static void Function(int state, int reason) onConnectionStateChanged;

  /// Occurs when the local network type changes.
  ///
  /// When the network connection is interrupted, this callback indicates whether the interruption is caused by a network type change or poor network conditions.
  static void Function(int type) onNetworkTypeChanged;

  /// Occurs when the SDK cannot reconnect to Agora's edge server 10 seconds after its connection to the server is interrupted.
  ///
  /// The SDK triggers this callback when it cannot connect to the server 10 seconds after calling [joinChannel], regardless of whether it is in the channel or not.
  static VoidCallback onConnectionLost;

  /// Occurs when an API method is executed.
  static void Function(int error, String api, String result) onApiCallExecuted;

  /// Occurs when the token expires in 30 seconds.
  static void Function(String token) onTokenPrivilegeWillExpire;

  /// Occurs when the token expires.
  static VoidCallback onRequestToken;

  // Media Events
  /// Occurs when the microphone is enabled/disabled.
  static void Function(bool enabled) onMicrophoneEnabled;

  /// Reports which users are speaking and the speakers' volume.
  ///
  /// This callback reports the ID and volume of the loudest speakers at the moment in the channel. This callback is disabled by default and can be enabled by the [enableAudioVolumeIndication] method.
  static void Function(int totalVolume, List<AudioVolumeInfo> speakers)
      onAudioVolumeIndication;

  /// Reports which user is the loudest speaker.
  ///
  /// If the user enables the audio volume indication by calling [enableAudioVolumeIndication], this callback returns the uid of the active speaker whose voice is detected by the audio volume detection module of the SDK.
  static void Function(int uid) onActiveSpeaker;

  /// Occurs when the first local audio frame is sent.
  static void Function(int elapsed) onFirstLocalAudioFrame;

  /// Occurs when the first remote audio frame is received.
  static void Function(int uid, int elapsed) onFirstRemoteAudioFrame;

  /// Occurs when the SDK decodes the first remote audio frame for playback.
  static void Function(int uid, int elapsed) onFirstRemoteAudioDecoded;

  /// Occurs when the first local video frame is sent.
  ///
  /// This callback is triggered after the first local video frame is rendered on the video window.
  static void Function(int width, int height, int elapsed)
      onFirstLocalVideoFrame;

  /// Occurs when the first remote video frame is rendered.
  ///
  /// This callback is triggered after the first frame of the remote video is rendered on the video window. The application can retrieve the data of the time elapsed from the user joining the channel until the first video frame is displayed.
  static void Function(int uid, int width, int height, int elapsed)
      onFirstRemoteVideoFrame;

  /// Occurs when a remote user's audio stream is muted/unmuted.
  static void Function(int uid, bool muted) onUserMuteAudio;

  /// Occurs when the video size or rotation information of a specified remote user changes.
  static void Function(int uid, double width, double height, int rotation)
      onVideoSizeChanged;

  /// Occurs when the remote video stream state changes.
  static void Function(int uid, int state, int reason, int elapsed) onRemoteVideoStateChanged;

  // Fallback Events
  /// Occurs when the published media stream falls back to an audio-only stream due to poor network conditions or switches back to video stream after the network conditions improve.
  ///
  /// If you call [setLocalPublishFallbackOption] and set option as STREAM_FALLBACK_OPTION_AUDIO_ONLY(2), this callback is triggered when the locally published stream falls back to audio-only mode due to poor uplink conditions, or when the audio stream switches back to the video after the uplink network condition improves.
  static void Function(bool isFallbackOrRecover)
      onLocalPublishFallbackToAudioOnly;

  /// Occurs when the subscribed media stream falls back to audio-only stream due to poor network conditions or switches back to video stream after the network conditions improve.
  ///
  /// If you call [setRemoteSubscribeFallbackOption] and set option as STREAM_FALLBACK_OPTION_AUDIO_ONLY(2), this callback is triggered when the remotely subscribed media stream falls back to audio-only mode due to poor uplink conditions, or when the remotely subscribed media stream switches back to the video after the uplink network condition improves.
  static void Function(int uid, bool isFallbackOrRecover)
      onRemoteSubscribeFallbackToAudioOnly;

  /// Occurs when the state of the RTMP streaming changes.
  static void Function(String url, int error, int state)
      onRtmpStreamingStateChanged;
    
  /// Occurs when the CDN live streaming settings are updated.
  static void Function(Map<String, dynamic> json)
      onStreamInjectedStatus;

  // Device Events
  /// Occurs when the local audio pkayout route changes.
  ///
  /// This callback returns that the audio route switched to an earpiece, speakerphone, headset, or Bluetooth device.
  static void Function(int routing) onAudioRouteChanged;

  /// Occurs when the local video stream state changes.
  ///
  /// The SDK returns the current video state in this callback.
  static void Function(
          LocalVideoStreamState localVideoState, LocalVideoStreamError error)
      onLocalVideoStateChanged;

  /// Occurs when the remote audio stream state changes.
  ///
  /// The SDK returns the current remote audio state in this callback.
  static void Function(
          int uid, int state, int reason, int elapsed)
      onRemoteAudioStateChanged;

  /// Occurs when the local audio stream state changes.
  ///
  /// The SDK returns the current local audio state in this callback.
  static void Function(
          int error, int state)
      onLocalAudioStateChanged;

  // Statistics Events
  /// Reports the statistics of the audio stream from each remote user/host.
  ///
  /// The SDK triggers this callback once every two seconds for each remote user/host. If a channel includes multiple remote users, the SDK triggers this callback as many times.
  static void Function(RemoteAudioStats stats) onRemoteAudioStats;

  /// Reports the statistics of the RtcEngine once every two seconds.
  static void Function(RtcStats stats) onRtcStats;

  /// Reports the last mile network quality of each user in the channel once every two seconds.
  ///
  /// Last mile refers to the connection between the local device and Agora's edge server. This callback reports once every two seconds the uplink last mile network conditions of each user in the channel. If a channel includes multiple users, then this callback will be triggered as many times.
  static void Function(int uid, int txQuality, int rxQuality) onNetworkQuality;

  /// Reports the statistics of the uploading local video streams.
  ///
  /// This callback is triggered once every two seconds for each individual user/host. If there are multiple users/hosts in the channel, this callback is triggered multiple times every 2 seconds.
  static void Function(LocalVideoStats stats) onLocalVideoStats;

  /// Reports the statistics of the uploading local audio streams.
  ///
  /// This callback is triggered once every two seconds for each individual user/host. If there are multiple users/hosts in the channel, this callback is triggered multiple times every 2 seconds.
  static void Function(LocalAudioStats stats) onLocalAudioStats;

  /// Reports the statistics of the video stream from each remote user/host.
  ///
  /// The SDK triggers this callback once every two seconds for each remote user/host. If a channel includes multiple remote users, the SDK triggers this callback as many times.
  static void Function(RemoteVideoStats stats) onRemoteVideoStats;

  /// Reports the transport-layer statistics of each remote video stream.
  ///
  /// This callback reports the transport-layer statistics, such as the packet loss rate and time delay, once every two seconds after the local user receives the video packet from a remote user.
  static void Function(int uid, int delay, int lost, int rxKBitRate)
      onRemoteVideoTransportStats;

  // Miscellaneous Events
  /// Occurs when the media engine is loaded.
  static VoidCallback onMediaEngineLoadSuccess;

  /// Occurs when the media engine starts.
  static VoidCallback onMediaEngineStartCallSuccess;

  // Core Methods
  /// Creates an RtcEngine instance.
  ///
  /// The Agora SDK only supports one RtcEngine instance at a time, therefore the app should create one RtcEngine object only.
  /// Only users with the same App ID can join the same channel and call each other.
  static Future<void> create(String appid) async {
    _addMethodCallHandler();
    await _channel.invokeMethod('create', {'appId': appid});
  }

  /// Destroys the RtcEngine instance and releases all resources used by the Agora SDK.
  ///
  /// This method is useful for apps that occasionally make voice or video calls, to free up resources for other operations when not making calls.
  /// Once the app calls destroy to destroy the created RtcEngine instance, you cannot use any method or callback in the SDK.
  static Future<void> destroy() async {
    _removeMethodCallHandler();
    await _channel.invokeMethod('destroy');
  }

  /// Sets the channel profile.
  ///
  /// RtcEngine needs to know the application scenario to set the appropriate channel profile to apply different optimization methods.
  /// Users in the same channel must use the same channel profile.
  /// Before calling this method to set a new channel profile, [destroy] the current RtcEngine and [create] a new RtcEngine first.
  /// Call this method before [joinChannel], you cannot configure the channel profile when the channel is in use.
  static Future<void> setChannelProfile(ChannelProfile profile) async {
    await _channel.invokeMethod('setChannelProfile', {'profile': profile.index});
  }

  /// Sets the role of a user (Live Broadcast only).
  ///
  /// This method sets the role of a user, such as a host or an audience (default), before joining a channel.
  /// This method can be used to switch the user role after a user joins a channel.
  static Future<void> setClientRole(ClientRole role) async {
    int roleValue = _intFromClientRole(role);
    await _channel.invokeMethod('setClientRole', {'role': roleValue});
  }

  /// Allows a user to join a channel.
  ///
  /// Users in the same channel can talk to each other, and multiple users in the same channel can start a group chat. Users with different App IDs cannot call each other.
  /// You must call the [leaveChannel] method to exit the current call before joining another channel.
  /// A channel does not accept duplicate uids, such as two users with the same uid. If you set uid as 0, the system automatically assigns a uid.
  static Future<bool> joinChannel(
      String token, String channelId, String info, int uid) async {
    final bool success = await _channel.invokeMethod('joinChannel',
        {'token': token, 'channelId': channelId, 'info': info, 'uid': uid});
    return success;
  }

  /// Allows a user to leave a channel.
  ///
  /// If you call the [destroy] method immediately after calling this method, the leaveChannel process interrupts, and the SDK does not trigger the onLeaveChannel callback.
  static Future<bool> leaveChannel() async {
    final bool success = await _channel.invokeMethod('leaveChannel');
    return success;
  }

  /// Switches to a different channel.
  /// This method allows the audience of a Live-broadcast channel to switch to a different channel.
  static Future<bool> switchChannel(String token, String channelId) async {
    final Map res = await _channel.invokeMethod("switchChannel", {"token": token, "channelId": channelId});
    bool result = res["result"];
    return result;
  }

  /// Renews the token when the current token expires.
  ///
  /// The app should retrieve a new token from the server and call this method to renew it. Failure to do so results in the SDK disconnecting from the server.
  static Future<void> renewToken(String token) async {
    await _channel.invokeMethod('renewToken', {'token': token});
  }

  /// Enables interoperability with the Agora Web SDK (Live Broadcast only).
  ///
  /// Use this method when the channel profile is Live Broadcast. Interoperability with the Agora Web SDK is enabled by default when the channel profile is Communication.
  static Future<void> enableWebSdkInteroperability(bool enabled) async {
    await _channel.invokeMethod('enableWebSdkInteroperability', {'enabled': enabled});
  }

  /// Gets the connection state of the SDK.
  static Future<int> getConnectionState() async {
    final int state = await _channel.invokeMethod('getConnectionState');
    return state;
  }

  // Core Audio
  /// Enables the audio module.
  ///
  /// The audio module is enabled by default.
  /// This method affects the internal engine and can be called after calling the [leaveChannel] method. You can call this method either before or after joining a channel.
  /// This method resets the internal engine and takes some time to take effect. Agora recommends using the following API methods to control the audio engine modules separately:
  /// [enableLocalAudio], [muteLocalAudioStream], [muteRemoteAudioStream], [muteAllRemoteAudioStreams].
  static Future<void> enableAudio() async {
    await _channel.invokeMethod('enableAudio');
  }

  /// Disables the audio module.
  ///
  /// The audio module is enabled by default.
  /// This method affects the internal engine and can be called after calling the [leaveChannel] method. You can call this method either before or after joining a channel.
  /// This method resets the engine and takes some time to take effect. Agora recommends using the following API methods to control the audio engine modules separately:
  /// [enableLocalAudio], [muteLocalAudioStream], [muteRemoteAudioStream], [muteAllRemoteAudioStreams].
  static Future<void> disableAudio() async {
    await _channel.invokeMethod('disableAudio');
  }

  /// Sets the audio parameters and application scenarios.
  ///
  /// You must call this method before calling the [joinChannel] method.
  static Future<void> setAudioProfile(
      AudioProfile profile, AudioScenario scenario) async {
    await _channel.invokeMethod('setAudioProfile',
        {'profile': profile.index, 'scenario': scenario.index});
  }

  /// Adjusts the recording volume.
  static Future<void> adjustRecordingSignalVolume(int volume) async {
    await _channel
        .invokeMethod('adjustRecordingSignalVolume', {'volume': volume});
  }

  /// Adjusts the playback volume.
  static Future<void> adjustPlaybackSignalVolume(int volume) async {
    await _channel
        .invokeMethod('adjustPlaybackSignalVolume', {'volume': volume});
  }

  /// Enables the [onAudioVolumeIndication] callback at a set time interval to report on which users are speaking and the speakers' volume.
  ///
  /// Once this method is enabled, the SDK returns the volume indication in the [onAudioVolumeIndication] callback at the set time interval, regardless of whether any user is speaking in the channel.
  static Future<void> enableAudioVolumeIndication(
      int interval, int smooth) async {
    await _channel.invokeMethod('enableAudioVolumeIndication',
        {'interval': interval, 'smooth': smooth});
  }

  /// Enables/Disables the local audio capture.
  ///
  /// The audio function is enabled by default. This method disables/re-enables the local audio function, that is, to stop or restart local audio capture and processing.
  /// This method does not affect receiving or playing the remote audio streams, and is applicable to scenarios where the user wants to receive remote audio streams without sending any audio stream to other users in the channel.
  /// The SDK triggers the [onMicrophoneEnabled] callback once the local audio function is disabled or re-enabled.
  /// Call this method after calling the [joinChannelmethod].
  static Future<void> enableLocalAudio(bool enabled) async {
    await _channel.invokeMethod('enableLocalAudio', {'enabled': enabled});
  }

  /// Sends/Stops sending the local audio stream.
  ///
  /// When muted is set as true, this method does not disable the microphone and thus does not affect any ongoing recording.
  static Future<void> muteLocalAudioStream(bool muted) async {
    await _channel.invokeMethod('muteLocalAudioStream', {'muted': muted});
  }

  /// Receives/Stops receiving a specified audio stream.
  ///
  /// If you called the [muteAllRemoteAudioStreams] method and set muted as true to stop receiving all remote video streams, ensure that the [muteAllRemoteAudioStreams] method is called and set muted as false before calling this method.
  /// The [muteAllRemoteAudioStreams] method sets all remote audio streams, while this method sets a specified remote user's audio stream.
  static Future<void> muteRemoteAudioStream(int uid, bool muted) async {
    await _channel
        .invokeMethod('muteRemoteAudioStream', {'uid': uid, 'muted': muted});
  }

  /// Receives/Stops receiving all remote audio streams.
  static Future<void> muteAllRemoteAudioStreams(bool muted) async {
    await _channel.invokeMethod('muteAllRemoteAudioStreams', {'muted': muted});
  }

  /// Sets whether to receive all remote audio streams by default.
  ///
  /// You can call this method either before or after [joinChannel]. If you call this method after joining a channel, the remote audio streams of all subsequent users are not received.
  static Future<void> setDefaultMuteAllRemoteAudioStreams(bool muted) async {
    await _channel
        .invokeMethod('setDefaultMuteAllRemoteAudioStreams', {'muted': muted});
  }

  // Video Pre-process and Post-process
  /// Enables/Disables image enhancement and sets the options.
  static Future<void> setBeautyEffectOptions(
      bool enabled, BeautyOptions options) async {
    await _channel.invokeListMethod('setBeautyEffectOptions',
        {'enabled': enabled, 'options': options.jsonMap()});
  }

  // Core Video
  /// Enables the video module.
  ///
  /// You can call this method either before or after [joinChannel]. If you call this method before joining a channel, the service starts in the video mode. If you call this method during an audio call, the audio mode switches to the video mode.
  /// To disable the video, call the [disableVideo] method.
  /// This method affects the internal engine and can be called after calling the [leaveChannel] method.
  /// This method resets the internal engine and takes some time to take effect. Agora recommends using the following API methods to control the video engine modules separately:
  /// [enableLocalVideo], [muteLocalVideoStream], [muteRemoteVideoStream], [muteAllRemoteVideoStreams].
  static Future<void> enableVideo() async {
    await _channel.invokeMethod('enableVideo');
  }

  /// Disables the video module.
  ///
  /// You can call this method either before or after [joinChannel]. If you call this method before joining a channel, the service starts in audio mode. If you call this method during a video call, the video mode switches to the audio mode.
  /// To enable the video mode, call the [enableVideo] method.
  /// This method affects the internal engine and can be called after calling the [leaveChannel] method.
  /// This method resets the internal engine and takes some time to take effect. Agora recommends using the following API methods to control the video engine modules separately:
  /// [enableLocalVideo], [muteLocalVideoStream], [muteRemoteVideoStream], [muteAllRemoteVideoStreams].
  static Future<void> disableVideo() async {
    await _channel.invokeMethod('disableVideo');
  }

  /// Sets the video encoder configuration.
  ///
  /// Each video encoder configuration corresponds to a set of video parameters, including the resolution, frame rate, bitrate, and video orientation.
  /// If you do not set the video encoder configuration after joining the channel, you can call this method before calling the [enableVideo] method to reduce the render time of the first video frame.
  /// The parameters specified in this method are the maximum values under ideal network conditions. If the video engine cannot render the video using the specified parameters due to poor network conditions, the parameters further down the list are considered until a successful configuration is found.
  static Future<void> setVideoEncoderConfiguration(
      VideoEncoderConfiguration config) async {
    await _channel.invokeMethod(
        'setVideoEncoderConfiguration', {'config': config.jsonMap()});
  }

  /// Creates the video renderer Widget.
  ///
  /// The Widget is identified by viewId, the operation and layout of the Widget are managed by the app.
  static Widget createNativeView(Function(int viewId) created, {Key key}) {
    if (Platform.isIOS) {
      return UiKitView(
        key: key,
        viewType: 'AgoraRendererView',
        onPlatformViewCreated: (viewId) {
          if (created != null) {
            created(viewId);
          }
        },
      );
    } else {
      return AndroidView(
        key: key,
        viewType: 'AgoraRendererView',
        onPlatformViewCreated: (viewId) {
          if (created != null) {
            created(viewId);
          }
        },
      );
    }
  }

  /// Remove the video renderer Widget.
  static Future<void> removeNativeView(int viewId) async {
    await _channel.invokeMethod('removeNativeView', {'viewId': viewId});
  }

  /// Sets the local video view and configures the video display settings on the local device.
  ///
  /// You can call this method to bind local video streams to Widget created by [createNativeView] of the  and configure the video display settings.
  static Future<void> setupLocalVideo(
      int viewId, VideoRenderMode renderMode) async {
    await _channel.invokeMethod('setupLocalVideo',
        {'viewId': viewId, 'renderMode': _intFromVideoRenderMode(renderMode)});
  }

  /// Sets the remote user's video view.
  ///
  /// This method binds the remote user to the Widget created by [createNativeView].
  static Future<void> setupRemoteVideo(
      int viewId, VideoRenderMode renderMode, int uid) async {
    await _channel.invokeMethod('setupRemoteVideo', {
      'viewId': viewId,
      'renderMode': _intFromVideoRenderMode(renderMode),
      'uid': uid,
    });
  }

  /// Sets the local video display mode.
  ///
  /// This method may be invoked multiple times during a call to change the display mode.
  static Future<void> setLocalRenderMode(VideoRenderMode renderMode) async {
    await _channel.invokeMethod(
        'setLocalRenderMode', {'mode': _intFromVideoRenderMode(renderMode)});
  }

  /// Sets the local voice changer option.
  static Future<void> setLocalVoiceChanger(VoiceChanger changer) async {
    await _channel.invokeMethod(
        'setLocalVoiceChanger', {'changer': _intLocalVoiceChangere(changer)});
  }

  /// Sets the remote video display mode.
  ///
  /// This method can be invoked multiple times during a call to change the display mode.
  static Future<void> setRemoteRenderMode(
      int uid, VideoRenderMode renderMode) async {
    await _channel.invokeMethod('setRemoteRenderMode',
        {'uid': uid, 'mode': _intFromVideoRenderMode(renderMode)});
  }

  /// Starts the local video preview before joining a channel.
  ///
  /// Before calling this method, you must:
  /// 1. Call the [setupLocalVideo] method to set the local preview Widget and configure the attributes.
  /// 2. Call the [enableVideo] method to enable the video.
  static Future<void> startPreview() async {
    await _channel.invokeMethod('startPreview');
  }

  /// Stops the local video preview and the video.
  static Future<void> stopPreview() async {
    await _channel.invokeMethod('stopPreview');
  }

  /// Disables/Re-enables the local video capture.
  ///
  /// The local video is enabled by default. This method disables/re-enables the local video and is only applicable when the user wants to watch the remote video without sending any video stream to the other user.
  /// Call this method after calling the [enableVideo] method. Otherwise, this method may not work properly.
  /// Calling the [enableVideo] method enables the local video by default. This method is used to disable/re-enable the local video while the remote video remains unaffected.
  static Future<void> enableLocalVideo(bool enabled) async {
    await _channel.invokeMethod('enableLocalVideo', {'enabled': enabled});
  }

  /// Sends/Stops sending the local video stream.
  ///
  /// When you set muted as true, this method does not disable the camera and thus does not affect the retrieval of the local video streams.
  /// This method responds faster than calling the [enableLocalVideo] method and set muted as false, which controls sending the local video stream.
  static Future<void> muteLocalVideoStream(bool muted) async {
    await _channel.invokeMethod('muteLocalVideoStream', {'muted': muted});
  }

  /// Receives/Stops receiving a specified remote user's video stream.
  ///
  /// If you call the [muteAllRemoteVideoStreams] method and set set muted as true to stop receiving all remote video streams, ensure that the [muteAllRemoteVideoStreams] method is called and set muted as false before calling this method.
  /// The [muteAllRemoteVideoStreams] method sets all remote streams, while this method sets a specified remote user's stream.
  static Future<void> muteRemoteVideoStream(int uid, bool muted) async {
    await _channel
        .invokeMethod('muteRemoteVideoStream', {'uid': uid, 'muted': muted});
  }

  /// Receives/Stops receiving all remote video streams.
  static Future<void> muteAllRemoteVideoStreams(bool muted) async {
    await _channel.invokeMethod('muteAllRemoteVideoStreams', {'muted': muted});
  }

  /// Sets whether to receive all remote video streams by default.
  static Future<void> setDefaultMuteAllRemoteVideoStreams(bool muted) async {
    await _channel
        .invokeMethod('setDefaultMuteAllRemoteVideoStreams', {'muted': muted});
  }

  // Audio Routing Controller
  /// Sets the default audio playback route.
  static Future<void> setDefaultAudioRouteToSpeaker(
      bool defaultToSpeaker) async {
    await _channel.invokeMethod('setDefaultAudioRouteToSpeaker',
        {'defaultToSpeaker': defaultToSpeaker});
  }

  /// Enables/Disables the audio playback route to the speakerphone.
  ///
  /// This method sets whether the audio is routed to the speakerphone or earpiece.
  static Future<void> setEnableSpeakerphone(bool enabled) async {
    await _channel.invokeMethod('setEnableSpeakerphone', {'enabled': enabled});
  }

  /// Checks whether the speakerphone is enabled.
  static Future<bool> isSpeakerphoneEnabled() async {
    final bool enabled = await _channel.invokeMethod('isSpeakerphoneEnabled');
    return enabled;
  }

  // Stream Fallback
  /// Sets the priority of a remote user.
  ///
  /// Use this method with the [setRemoteSubscribeFallbackOption] method.
  /// If the fallback function is enabled for a remote stream, the SDK ensures the high-priority user gets the best possible stream quality.
  /// The Agora SDK supports setting userPriority as high for one user only.
  static Future<void> setRemoteUserPriority(
      int uid, UserPriority userPriority) async {
    int priorityValue = 100;
    switch (userPriority) {
      case UserPriority.Normal:
        priorityValue = 100;
        break;
      case UserPriority.High:
        priorityValue = 50;
        break;
      default:
        break;
    }
    await _channel.invokeMethod(
        'setRemoteUserPriority', {'uid': uid, 'userPriority': priorityValue});
  }

  /// Sets the fallback option for the locally published video stream based on the network conditions.
  static Future<void> setLocalPublishFallbackOption(
      StreamFallbackOptions options) async {
    await _channel.invokeMethod(
        'setLocalPublishFallbackOption', {'option': options.index});
  }

  /// Sets the fallback option for the remotely subscribed video stream based on the network conditions.
  static Future<void> setRemoteSubscribeFallbackOption(
      StreamFallbackOptions options) async {
    await _channel.invokeMethod(
        'setRemoteSubscribeFallbackOption', {'option': options.index});
  }

  // Dual-stream Mode
  /// Enables/Disables dual-stream mode.
  ///
  /// If dual-stream mode is enabled, the receiver can choose to receive the high stream (high-resolution high-bitrate video stream) or low stream (low-resolution low-bitrate video stream) video.
  static Future<void> enableDualStreamMode(bool enabled) async {
    await _channel.invokeMethod('enableDualStreamMode', {'enabled': enabled});
  }

  /// Sets the video stream type of the remotely subscribed video stream when the remote user sends dual streams.
  ///
  /// This method allows the app to adjust the corresponding video-stream type based on the size of the video window to reduce the bandwidth and resources.
  static Future<void> setRemoteVideoStreamType(int uid, int streamType) async {
    await _channel.invokeMethod(
        'setRemoteVideoStreamType', {'uid': uid, 'streamType': streamType});
  }

  /// Sets the default video-stream type of the remotely subscribed video stream when the remote user sends dual streams.
  static Future<void> setRemoteDefaultVideoStreamType(int streamType) async {
    await _channel.invokeMethod(
        'setRemoteDefaultVideoStreamType', {'streamType': streamType});
  }

  /// Sets the video layout and audio settings for CDN live. (CDN live only.)
  static Future<int> setLiveTranscoding(AgoraLiveTranscoding config) async {
    return _channel.invokeMethod(
      'setLiveTranscoding',
      {"transcoding": config.toJson()}
    );
  }

  /// Publishes the local stream to the CDN.
  static Future<int> addPublishStreamUrl(String url, bool enable) async {
    return _channel.invokeMethod(
      'addPublishStreamUrl',
      {"url": url, "enable": enable}
    );
  }

  /// Removes an RTMP stream from the CDN.
  static Future<int> removePublishStreamUrl(String url) async {
    return _channel.invokeMethod(
      'removePublishStreamUrl',
      {"url": url}
    ); 
  }

  /// Adds a voice or video stream RTMP URL address to a live broadcast.
  static Future<int> addInjectStreamUrl(String url, AgoraLiveInjectStreamConfig config) async {
    return _channel.invokeMethod(
      'addInjectStreamUrl',
      {
        'url': url,
        'config': config.toJson()
      }
    );
  }

  /// Removes the voice or video stream RTMP URL address from a live broadcast.
  static Future<int> removeInjectStreamUrl(String url) async {
    return _channel.invokeMethod(
      'removeInjectStreamUrl',
      {
        'url': url,
      }
    );
  }

  // Encryption
  /// Enables built-in encryption with an encryption password before joining a channel.
  ///
  /// All users in a channel must set the same encryption password. The encryption password is automatically cleared once a user leaves the channel.
  /// If the encryption password is not specified or set to empty, the encryption functionality is disabled.
  static Future<void> setEncryptionSecret(String secret) async {
    await _channel.invokeMethod('setEncryptionSecret', {'secret': secret});
  }

  /// Sets the built-in encryption mode.
  ///
  /// The SDK supports built-in encryption, which is set to the `"aes-128-xts" mode by default. Call this method to use other encryption modes.
  /// - "aes-128-xts": 128-bit AES encryption, XTS mode.
  /// - "aes-256-xts": 256-bit AES encryption, XTS mode.
  /// - "aes-128-ecb": 128-bit AES encryption, ECB mode.
  ///
  /// All users in the same channel must use the same encryption mode and password.
  /// Refer to the information related to the AES encryption algorithm on the differences between the encryption modes.
  /// When encryptionMode is set as NULL, the encryption mode is set as "aes-128-xts" by default.
  static Future<void> setEncryptionMode(String encryptionMode) async {
    await _channel
        .invokeMethod('setEncryptionMode', {'encryptionMode': encryptionMode});
  }

  // Camera Control
  /// Switches between front and rear cameras.
  static Future<void> switchCamera() async {
    await _channel.invokeMethod('switchCamera');
  }

  // Miscellaneous Methods
  /// Gets the SDK version.
  static Future<String> getSdkVersion() async {
    final String version = await _channel.invokeMethod('getSdkVersion');
    return version;
  }

  // CallHandler
  static void _addMethodCallHandler() {
    _channel.setMethodCallHandler((MethodCall call) {
      Map values = call.arguments;

      switch (call.method) {
        // Core Events
        case 'onWarning':
          if (onWarning != null) {
            onWarning(values['warn']);
          }
          break;
        case 'onError':
          if (onError != null) {
            onError(values['err']);
          }
          break;
        case 'onJoinChannelSuccess':
          if (onJoinChannelSuccess != null) {
            onJoinChannelSuccess(
                values['channel'], values['uid'], values['elapsed']);
          }
          break;
        case 'onRejoinChannelSuccess':
          if (onRejoinChannelSuccess != null) {
            onRejoinChannelSuccess(
                values['channel'], values['uid'], values['elapsed']);
          }
          break;
        case 'onLeaveChannel':
          if (onLeaveChannel != null) {
            onLeaveChannel();
          }
          break;
        case 'onClientRoleChanged':
          if (onClientRoleChanged != null) {
            ClientRole oldRole = _clientRoleFromInt(values['oldRole']);
            ClientRole newRole = _clientRoleFromInt(values['newRole']);
            onClientRoleChanged(oldRole, newRole);
          }
          break;
        case 'onUserJoined':
          if (onUserJoined != null) {
            onUserJoined(values['uid'], values['elapsed']);
          }
          break;
        case 'onUserOffline':
          if (onUserOffline != null) {
            onUserOffline(values['uid'], values['reason']);
          }
          break;
        case 'onConnectionStateChanged':
          if (onConnectionStateChanged != null) {
            onConnectionStateChanged(values['state'], values['reason']);
          }
          break;
        case 'onNetworkTypeChanged':
          if (onNetworkTypeChanged != null) {
            onNetworkTypeChanged(values['type']);
          }
          break;
        case 'onConnectionLost':
          if (onConnectionLost != null) {
            onConnectionLost();
          }
          break;
        case 'onApiCallExecuted':
          if (onApiCallExecuted != null) {
            onApiCallExecuted(values['error'], values['api'], values['result']);
          }
          break;
        case 'onTokenPrivilegeWillExpire':
          if (onTokenPrivilegeWillExpire != null) {
            onTokenPrivilegeWillExpire(values['token']);
          }
          break;
        case 'onRequestToken':
          if (onRequestToken != null) {
            onRequestToken();
          }
          break;
        // Media Events
        case 'onMicrophoneEnabled':
          if (onMicrophoneEnabled != null) {
            onMicrophoneEnabled(values['enabled']);
          }
          break;
        case 'onAudioVolumeIndication':
          if (onAudioVolumeIndication != null) {
            List<dynamic> speakerValues = values['speakers'];
            List<AudioVolumeInfo> speakers = List<AudioVolumeInfo>();
            for (Map speakerValue in speakerValues) {
              AudioVolumeInfo info =
                  AudioVolumeInfo(speakerValue['uid'], speakerValue['volume']);
              speakers.add(info);
            }
            onAudioVolumeIndication(values['totalVolume'], speakers);
          }
          break;
        case 'onActiveSpeaker':
          if (onActiveSpeaker != null) {
            onActiveSpeaker(values['uid']);
          }
          break;
        case 'onFirstLocalAudioFrame':
          if (onFirstLocalAudioFrame != null) {
            onFirstLocalAudioFrame(values['elapsed']);
          }
          break;
        case 'onFirstRemoteAudioFrame':
          if (onFirstRemoteAudioFrame != null) {
            onFirstRemoteAudioFrame(values['uid'], values['elapsed']);
          }
          break;
        case 'onFirstRemoteAudioDecoded':
          if (onFirstRemoteAudioDecoded != null) {
            onFirstRemoteAudioDecoded(values['uid'], values['elapsed']);
          }
          break;
        case 'onFirstLocalVideoFrame':
          if (onFirstLocalVideoFrame != null) {
            onFirstLocalVideoFrame(
                values['width'], values['height'], values['elapsed']);
          }
          break;
        case 'onFirstRemoteVideoFrame':
          if (onFirstRemoteVideoFrame != null) {
            onFirstRemoteVideoFrame(values['uid'], values['width'],
                values['height'], values['elapsed']);
          }
          break;
        case 'onUserMuteAudio':
          if (onUserMuteAudio != null) {
            onUserMuteAudio(values['uid'], values['muted']);
          }
          break;
        case 'onVideoSizeChanged':
          if (onVideoSizeChanged != null) {
            onVideoSizeChanged(values['uid'], values['width'], values['height'],
                values['rotation']);
          }
          break;
        case 'onRemoteVideoStateChanged':
          if (onRemoteVideoStateChanged != null) {
            onRemoteVideoStateChanged(values['uid'], values['state'], values['reason'], values['elapsed']);
          }
          break;
        // Fallback Events
        case 'onLocalPublishFallbackToAudioOnly':
          if (onLocalPublishFallbackToAudioOnly != null) {
            onLocalPublishFallbackToAudioOnly(values['isFallbackOrRecover']);
          }
          break;
        case 'onRemoteSubscribeFallbackToAudioOnly':
          if (onRemoteSubscribeFallbackToAudioOnly != null) {
            onRemoteSubscribeFallbackToAudioOnly(
                values['uid'], values['isFallbackOrRecover']);
          }
          break;
        case 'onRtmpStreamingStateChanged':
          if (onRtmpStreamingStateChanged != null) {
            onRtmpStreamingStateChanged(values['url'], values['error'], values['state']);
          }
          break;
        case 'onStreamInjectedStatus':
          if (onStreamInjectedStatus != null) {
            onStreamInjectedStatus({'url': values['url'], 'uid': values['uid'], 'status': values['status']});
          }
          break;
        // Device Events
        case 'onAudioRouteChanged':
          if (onAudioRouteChanged != null) {
            onAudioRouteChanged(values['routing']);
          }
          break;
        case 'onLocalVideoStateChanged':
          if (onLocalVideoStateChanged != null) {
            onLocalVideoStateChanged(
                values['localVideoState'], values['error']);
          }
          break;
        case 'onRemoteAudioStateChanged':
          if (onRemoteAudioStateChanged != null) {
            onRemoteAudioStateChanged(
              values['uid'], values['state'], values['reason'], values['elapsed']
            );
          }
          break;
        case 'onLocalAudioStateChanged':
          if (onLocalAudioStateChanged != null) {
            onLocalAudioStateChanged(
              values['error'], values['state']
            );
          }
          break;
        // Statistics Events
        case 'onRemoteAudioStats':
          if (onRemoteAudioStats != null) {
            Map statsValue = values['stats'];
            RemoteAudioStats stats = RemoteAudioStats();
            stats.uid = statsValue['uid'];
            stats.quality = statsValue['quality'];
            stats.networkTransportDelay = statsValue['networkTransportDelay'];
            stats.jitterBufferDelay = statsValue['jitterBufferDelay'];
            stats.audioLossRate = statsValue['audioLossRate'];
            onRemoteAudioStats(stats);
          }
          break;
        case 'onRtcStats':
          if (onRtcStats != null) {
            Map statsValue = values['stats'];
            RtcStats stats = RtcStats.fromJson(statsValue);
            onRtcStats(stats);
          }
          break;
        case 'onNetworkQuality':
          if (onNetworkQuality != null) {
            onNetworkQuality(
                values['uid'], values['txQuality'], values['rxQuality']);
          }
          break;
        case 'onLocalVideoStats':
          if (onLocalVideoStats != null) {
            Map statsValue = values['stats'];
            LocalVideoStats stats = LocalVideoStats.fromJson(statsValue);
            stats.sentBitrate = statsValue['sentBitrate'];
            stats.sentFrameRate = statsValue['sentFrameRate'];
            stats.encoderOutputFrameRate = statsValue['encoderOutputFrameRate'];
            stats.rendererOutputFrameRate =
                statsValue['rendererOutputFrameRate'];
            onLocalVideoStats(stats);
          }
          break;
        case 'onLocalAudioStats':
          if (onLocalAudioStats != null) {
            Map statsValue = values['stats'];
            LocalAudioStats stats = LocalAudioStats();
            stats.numChannels = statsValue['numChannels'];
            stats.sentSampleRate = statsValue['sentSampleRate'];
            stats.sentBitrate = statsValue['sentBitrate'];
            onLocalAudioStats(stats);
          }
          break;
        case 'onRemoteVideoStats':
          if (onRemoteVideoStats != null) {
            Map statsValue = values['stats'];
            RemoteVideoStats stats = RemoteVideoStats.fromJson(statsValue);
            onRemoteVideoStats(stats);
          }
          break;
        case 'onRemoteVideoTransportStats':
          if (onRemoteVideoTransportStats != null) {
            onRemoteVideoTransportStats(values['uid'], values['delay'],
                values['lost'], values['rxKBitRate']);
          }
          break;
        // Miscellaneous Events
        case 'onMediaEngineLoadSuccess':
          if (onMediaEngineLoadSuccess != null) {
            onMediaEngineLoadSuccess();
          }
          break;
        case 'onMediaEngineStartCallSuccess':
          if (onMediaEngineStartCallSuccess != null) {
            onMediaEngineStartCallSuccess();
          }
          break;
        default:
      }
    });
  }

  static void _removeMethodCallHandler() {
    _channel.setMethodCallHandler(null);
  }

  static ClientRole _clientRoleFromInt(int value) {
    switch (value) {
      case 1:
        return ClientRole.Broadcaster;
        break;
      case 2:
        return ClientRole.Audience;
        break;
      default:
        return ClientRole.Audience;
    }
  }

  static int _intFromClientRole(ClientRole role) {
    switch (role) {
      case ClientRole.Broadcaster:
        return 1;
        break;
      case ClientRole.Audience:
        return 2;
        break;
      default:
        return 2;
    }
  }

  static VideoRenderMode _videoRenderModeFromInt(int value) {
    switch (value) {
      case 1:
        return VideoRenderMode.Hidden;
        break;
      case 2:
        return VideoRenderMode.Fit;
        break;
      default:
        return VideoRenderMode.Hidden;
    }
  }

  static int _intFromVideoRenderMode(VideoRenderMode mode) {
    switch (mode) {
      case VideoRenderMode.Hidden:
        return 1;
        break;
      case VideoRenderMode.Fit:
        return 2;
        break;
      default:
        return 1;
    }
  }

  static int _intLocalVoiceChangere(VoiceChanger changer) {
    switch (changer) {
      case VoiceChanger.VOICE_CHANGER_OLDMAN:
        return 1;
        break;
      case VoiceChanger.VOICE_CHANGER_BABYBOY:
        return 2;
        break;
      case VoiceChanger.VOICE_CHANGER_BABYGILR:
        return 3;
        break;
      case VoiceChanger.VOICE_CHANGER_ZHUBAJIE:
        return 4;
        break;
      case VoiceChanger.VOICE_CHANGER_ETHEREAL:
        return 5;
        break;
      case VoiceChanger.VOICE_CHANGER_HULK:
        return 6;
        break;
      default:
        return 0;
    }
  }
}