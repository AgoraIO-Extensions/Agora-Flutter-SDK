import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/base.dart';

export 'src/agora_render_widget.dart';
export 'src/base.dart';

class AgoraChannelMediaRelayConfiguration {
  final String srcChannelName;
  final int srcUid;
  final String srcToken;
  final List<Map<String, dynamic>>
      channels; // e.g. [{"channelName": channelName, "uid": uid, "token": token}]

  AgoraChannelMediaRelayConfiguration(json)
      : srcChannelName = json["srcChannelName"],
        srcUid = json["srcUid"],
        srcToken = json["srcToken"],
        channels = json["channels"];

  toJson() => {
        "src": {
          "channelName": srcChannelName,
          "uid": srcUid,
          "token": srcToken,
        },
        "channels": channels,
      };
}

class WatermarkOptions {
  final bool visibleInPreview;
  final Map<String, int> positionInLandscapeMode;
  final Map<String, int> positionInPortraitMode;

  WatermarkOptions(json)
      : visibleInPreview = json['visibleInPreview'],
        positionInLandscapeMode = json['positionInLandscapeMode'],
        positionInPortraitMode = json['positionInPortraitMode'];

  toJson() => {
        "visibleInPreview": visibleInPreview,
        "positionInLandscapeMode": positionInLandscapeMode,
        "positionInPortraitMode": positionInPortraitMode,
      };
}

class AgoraLastmileProbeConfig {
  final bool probeDownlink;
  final bool probeUplink;
  final int expectedUplinkBitrate;
  final int expectedDownlinkBitrate;

  AgoraLastmileProbeConfig(this.expectedDownlinkBitrate,
      this.expectedUplinkBitrate, this.probeDownlink, this.probeUplink)
      : assert(expectedDownlinkBitrate != null),
        assert(expectedUplinkBitrate != null),
        assert(probeDownlink != null),
        assert(probeUplink != null);

  AgoraLastmileProbeConfig.fromJson(json)
      : probeDownlink = json["probeDownlink"],
        probeUplink = json["probeUplink"],
        expectedUplinkBitrate = json["expectedUplinkBitrate"],
        expectedDownlinkBitrate = json["expectedDownlinkBitrate"];

  toJson() => {
        "probeDownlink": probeDownlink,
        "probeUplink": probeUplink,
        "expectedUplinkBitrate": expectedUplinkBitrate,
        "expectedDownlinkBitrate": expectedDownlinkBitrate,
      };
}

class AgoraUserInfo {
  int uid;
  String userAccount;

  AgoraUserInfo(this.uid, this.userAccount);

  AgoraUserInfo.fromJson(Map<dynamic, dynamic> json)
      : uid = json['uid'],
        userAccount = json['userAccount'];

  Map<String, dynamic> toJson() => {'uid': uid, 'userAccount': userAccount};

  @override
  String toString() {
    return "{uid: $uid, userAccount: $userAccount}";
  }
}

class AgoraCameraRect {
  int width;
  int height;
  int x;
  int y;

  AgoraCameraRect(this.width, this.height, this.x, this.y);

  AgoraCameraRect.fromJson(json)
      : width = json['width'],
        height = json['height'],
        x = json['x'],
        y = json['y'];

  Map<String, dynamic> toJson() => {
        "width": width,
        "height": height,
        "x": x,
        "y": y,
      };
}

class NetworkLinkReport {
  final int availableBandwidth;
  final int jitter;
  final int packetLossRate;

  NetworkLinkReport(this.availableBandwidth, this.jitter, this.packetLossRate);

  NetworkLinkReport.fromJson(json)
      : availableBandwidth = json['availableBandwidth'],
        jitter = json['jitter'],
        packetLossRate = json['packetLossRate'];

  Map<String, dynamic> toJson() => {
        "availableBandwidth": availableBandwidth,
        "jitter": jitter,
        "packetLossRate": packetLossRate,
      };
}

class AgoraLastmileProbeResult {
  final int state;
  final int rtt;
  final NetworkLinkReport uplinkReport;
  final NetworkLinkReport downlinkReport;

  AgoraLastmileProbeResult(
      this.state, this.rtt, this.uplinkReport, this.downlinkReport);

  AgoraLastmileProbeResult.fromJson(json)
      : state = json['state'],
        rtt = json['rtt'],
        uplinkReport = NetworkLinkReport.fromJson(json['uplinkReport']),
        downlinkReport = NetworkLinkReport.fromJson(json['downlinkReport']);

  Map<String, dynamic> toJson() => {
        'state': state,
        'rtt': state,
        'uplinkReport': uplinkReport.toJson(),
        'downlinkReport': downlinkReport.toJson(),
      };
}

class AgoraRtcEngine {
  static const MethodChannel _channel = const MethodChannel('agora_rtc_engine');
  static const EventChannel _eventChannel =
      const EventChannel('agora_rtc_engine_event_channel');

  static StreamSubscription<dynamic> _sink;

  // Core Events
  /// Reports a warning during SDK runtime.
  ///
  /// In most cases, the app can ignore the warning reported by the SDK because the SDK can usually fix the issue and resume running.
  static void Function(int warn) onWarning;

  /// Reports an error during SDK runtime.
  ///
  /// In most cases, the SDK cannot fix the issue and resume running. The SDK requires the app to take action or informs the user about the issue.
  static void Function(dynamic err) onError;

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

  /// Occurs when the local user successfully registers a user account by calling the registerLocalUserAccount or joinChannelByUserAccount method.
  static void Function(String userAccount, int uid) onRegisteredLocalUser;

  /// Occurs when the SDK gets the user ID and user account of the remote user.
  static void Function(AgoraUserInfo userInfo, int uid) onUpdatedUserInfo;

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

  /// Occurs when a remote user's video stream is muted/unmuted.
  // static void Function(int uid, bool muted) onUserMuteVideo;

  /// Occurs when the video size or rotation information of a specified remote user changes.
  static void Function(int uid, double width, double height, int rotation)
      onVideoSizeChanged;

  /// Occurs when the remote video stream state changes.
  static void Function(int uid, int state, int reason, int elapsed)
      onRemoteVideoStateChanged;

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
  static void Function(Map<String, dynamic> json) onStreamInjectedStatus;

  // Device Events
  /// Occurs when the local audio pkayout route changes.
  ///
  /// This callback returns that the audio route switched to an earpiece, speakerphone, headset, or Bluetooth device.
  static void Function(int routing) onAudioRouteChanged;

  /// Occurs when a camera focus area changes.
  ///
  /// This callback returns rect of camera focus area changed.
  static void Function(AgoraCameraRect rect) onCameraFocusAreaChanged;

  /// Occurs when the camera exposure area changes.
  ///
  /// This callback returns rect of camera exposure area changed.
  static void Function(AgoraCameraRect rect) onCameraExposureAreaChanged;

  /// Occurs when the local video stream state changes.
  ///
  /// The SDK returns the current video state in this callback.
  static void Function(
          LocalVideoStreamState localVideoState, LocalVideoStreamError error)
      onLocalVideoStateChanged;

  /// Occurs when the remote audio stream state changes.
  ///
  /// The SDK returns the current remote audio state in this callback.
  static void Function(int uid, int state, int reason, int elapsed)
      onRemoteAudioStateChanged;

  /// Occurs when the local audio stream state changes.
  ///
  /// The SDK returns the current local audio state in this callback.
  static void Function(int error, int state) onLocalAudioStateChanged;

  // Statistics Events
  /// Reports the statistics of the audio stream from each remote user/host.
  ///
  /// The SDK triggers this callback once every two seconds for each remote user/host. If a channel includes multiple remote users, the SDK triggers this callback as many times.
  static void Function(RemoteAudioStats stats) onRemoteAudioStats;

  /// Occurs when a local audio mixing state changed.
  static void Function(int state, int errorCode) onLocalAudioMixingStateChanged;

  /// Occurs when a remote user starts audio mixing.
  // static void Function() onRemoteAudioMixingStarted;

  /// Occurs when a remote user finishes audio mixing.
  // static void Function() onRemoteAudioMixingFinished;

  /// Occurs when the local audio effect playback finishes.
  static void Function(int soundId) onAudioEffectFinished;

  /// Occurs when the stream published
  static void Function(String url, int errorCode) onStreamPublished;

  /// Occurs when the stream unpublished
  static void Function(String url) onStreamUnpublished;

  /// Occurs when the transcoding updated
  static void Function() onTranscodingUpdated;

  /// Reports the statistics of the RtcEngine once every two seconds.
  static void Function(RtcStats stats) onRtcStats;

  /// Reports the last mile network quality of the local user once every two seconds before the user joins a channel.
  static void Function(int quality) onLastmileQuality;

  /// Reports the last mile network quality of each user in the channel once every two seconds.
  ///
  /// Last mile refers to the connection between the local device and Agora's edge server. This callback reports once every two seconds the uplink last mile network conditions of each user in the channel. If a channel includes multiple users, then this callback will be triggered as many times.
  static void Function(int uid, int txQuality, int rxQuality) onNetworkQuality;

  /// Reports the last-mile network probe result.
  static void Function(AgoraLastmileProbeResult result)
      onLastmileProbeTestResult;

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

  // Miscellaneous Events
  /// Occurs when the media engine is loaded.
  static VoidCallback onMediaEngineLoadSuccess;

  /// Occurs when the media engine starts.
  static VoidCallback onMediaEngineStartCallSuccess;

  /// Occurs when received channel media relay changed
  static void Function(int state, int errorCode) onChannelMediaRelayChanged;

  /// Occurs when received channel media relay event
  static void Function(int event) onReceivedChannelMediaRelayEvent;

  // Core Methods
  /// Creates an RtcEngine instance.
  ///
  /// The Agora SDK only supports one RtcEngine instance at a time, therefore the app should create one RtcEngine object only.
  /// Only users with the same App ID can join the same channel and call each other.
  static Future<void> create(String appid) async {
    await _channel.invokeMethod('create', {'appId': appid});
    _addEventChannelHandler();
  }

  /// Destroys the RtcEngine instance and releases all resources used by the Agora SDK.
  ///
  /// This method is useful for apps that occasionally make voice or video calls, to free up resources for other operations when not making calls.
  /// Once the app calls destroy to destroy the created RtcEngine instance, you cannot use any method or callback in the SDK.
  static Future<void> destroy() async {
    await _removeEventChannelHandler();
    await _channel.invokeMethod('destroy');
  }

  /// Sets the channel profile.
  ///
  /// RtcEngine needs to know the application scenario to set the appropriate channel profile to apply different optimization methods.
  /// Users in the same channel must use the same channel profile.
  /// Before calling this method to set a new channel profile, [destroy] the current RtcEngine and [create] a new RtcEngine first.
  /// Call this method before [joinChannel], you cannot configure the channel profile when the channel is in use.
  static Future<void> setChannelProfile(ChannelProfile profile) async {
    await _channel
        .invokeMethod('setChannelProfile', {'profile': profile.index});
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
    final Map res = await _channel.invokeMethod(
        "switchChannel", {"token": token, "channelId": channelId});
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
    await _channel
        .invokeMethod('enableWebSdkInteroperability', {'enabled': enabled});
  }

  /// Gets the connection state of the SDK.
  static Future<int> getConnectionState() async {
    final int state = await _channel.invokeMethod('getConnectionState');
    return state;
  }

  /// stringuid userAccount
  /// registerLocalUserAccount
  static Future<bool> registerLocalUserAccount(Map<String, String> args) async {
    final bool result = await _channel.invokeMethod('registerLocalUserAccount',
        {"appId": args["appId"], "userAccount": args["userAccount"]});
    return result;
  }

  /// joinChannelByUserAccount
  ///
  /// Joins the channel with a user account.
  static Future<bool> joinChannelByUserAccount(Map<String, String> args) async {
    final bool result =
        await _channel.invokeMethod('joinChannelByUserAccount', {
      "userAccount": args["userAccount"],
      "token": args["token"],
      "channelId": args["channelId"],
    });
    return result;
  }

  /// registerLocalUserAccount
  ///
  /// Gets the user information by passing in the user account.
  static Future<AgoraUserInfo> getUserInfoByUserAccount(
      String userAccount) async {
    final AgoraUserInfo result = AgoraUserInfo.fromJson(await _channel
        .invokeMethod(
            'getUserInfoByUserAccount', {"userAccount": userAccount}));
    return result;
  }

  /// registerLocalUserAccount
  ///
  /// Gets the user information by passing in the uid.
  static Future<AgoraUserInfo> getUserInfoByUid(int uid) async {
    final AgoraUserInfo result = AgoraUserInfo.fromJson(
        await _channel.invokeMethod('getUserInfoByUserAccount', {"uid": uid}));
    return result;
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
      int interval, int smooth, bool vad) async {
    await _channel.invokeMethod('enableAudioVolumeIndication',
        {'interval': interval, 'smooth': smooth, 'vad': vad});
  }

  /// Enables/Disables the local audio capture.
  ///
  /// The audio function is enabled by default. This method disables/re-enables the local audio function, that is, to stop or restart local audio capture and processing.
  /// This method does not affect receiving or playing the remote audio streams, and is applicable to scenarios where the user wants to receive remote audio streams without sending any audio stream to other users in the channel.
  /// The SDK triggers the [onLocalAudioStateChange] callback once the local audio function is disabled or re-enabled.
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
        {'enabled': enabled, 'options': options.toJson()});
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
        'setVideoEncoderConfiguration', {'config': config.toJson()});
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

  /// Sets the local voice changer option.
  static Future<void> setLocalVoiceChanger(VoiceChanger changer) async {
    await _channel.invokeMethod(
        'setLocalVoiceChanger', {'changer': _intLocalVoiceChangere(changer)});
  }

  /// Changes the voice pitch of the local speaker
  static Future<void> setLocalVoicePitch(double pitch) async {
    await _channel.invokeMethod('setLocalVoicePitch', {'pitch': pitch});
  }

  // Sets the local voice equalization effect.
  static Future<void> setLocalVoiceEqualizationOfBandFrequency(
      AgoraAudioEqualizationBandFrequency bandFrequency, int gain) async {
    await _channel.invokeMethod('setLocalVoiceEqualizationOfBandFrequency',
        {'bandFrequency': bandFrequency.index, 'gain': gain});
  }

  // Sets the local voice reverberation.
  // Sets the effect of the reverberation type. See [AgoraAudioReverbType](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/oc/Constants/AgoraAudioReverbType.html) for the value range.
  static Future<void> setLocalVoiceReverbOfType(
      AgoraAudioReverbType reverbType, int value) async {
    await _channel.invokeMethod('setLocalVoiceReverbOfType',
        {'reverbType': reverbType.index, 'value': value});
  }

  // Sets the preset local voice reverberation effect.
  static Future<void> setLocalVoiceReverbPreset(
      AgoraAudioReverbType reverbType) async {
    await _channel.invokeMethod(
        'setLocalVoiceReverbPreset', {'reverbType': reverbType.index});
  }

  /// Enables/Disables stereo panning for remote users.
  static Future<void> enableSoundPositionIndication(bool enabled) async {
    await _channel
        .invokeMethod('enableSoundPositionIndication', {'enabled': enabled});
  }

  /// Sets the sound position and gain of a remote user.
  static Future<void> setRemoteVoicePosition(
      int uid, double pan, int gain) async {
    await _channel.invokeMethod(
        'setRemoteVoicePosition', {'uid': uid, 'pan': pan, 'gain': gain});
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
    return _channel
        .invokeMethod('setLiveTranscoding', {"transcoding": config.toJson()});
  }

  /// Publishes the local stream to the CDN.
  static Future<int> addPublishStreamUrl(String url, bool enable) async {
    return _channel
        .invokeMethod('addPublishStreamUrl', {"url": url, "enable": enable});
  }

  /// Removes an RTMP stream from the CDN.
  static Future<int> removePublishStreamUrl(String url) async {
    return _channel.invokeMethod('removePublishStreamUrl', {"url": url});
  }

  /// Adds a voice or video stream RTMP URL address to a live broadcast.
  static Future<int> addInjectStreamUrl(
      String url, AgoraLiveInjectStreamConfig config) async {
    return _channel.invokeMethod(
        'addInjectStreamUrl', {'url': url, 'config': config.toJson()});
  }

  /// Removes the voice or video stream RTMP URL address from a live broadcast.
  static Future<int> removeInjectStreamUrl(String url) async {
    return _channel.invokeMethod('removeInjectStreamUrl', {
      'url': url,
    });
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

  /// Starts an audio call test.
  static Future<dynamic> startEchoTestWithInterval(int interval) async {
    dynamic res = await _channel
        .invokeMethod('startEchoTestWithInterval', {'interval': interval});
    return res;
  }

  /// Stops the audio call test.
  static Future<void> stopEchoTest() async {
    await _channel.invokeMethod('stopEchoTest');
  }

  /// Enables the network connection quality test.
  static Future<void> enableLastmileTest() async {
    await _channel.invokeMethod('enableLastmileTest');
  }

  /// Disables the network connection quality test.
  static Future<void> disableLastmileTest() async {
    await _channel.invokeMethod('disableLastmileTest');
  }

  /// Starts the last-mile network probe test.
  static Future<void> startLastmileProbeTest(
      AgoraLastmileProbeConfig config) async {
    await _channel
        .invokeMethod('startLastmileProbeTest', {"config": config.toJson()});
  }

  /// Stops the last-mile network probe test.
  static Future<void> stopLastmileProbeTest() async {
    await _channel.invokeMethod('stopLastmileProbeTest');
  }

  /// Adds a watermark image to the local video.
  ///
  /// [WatermarkOptions](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/oc/Classes/WatermarkOptions.html)
  static Future<void> addVideoWatermark(
      String url, WatermarkOptions options) async {
    await _channel.invokeMethod(
        'addVideoWatermark', {"url": url, "options": options.toJson()});
  }

  /// Removes the watermark image from the video stream added by addVideoWatermark.
  static Future<void> clearVideoWatermarks() async {
    await _channel.invokeMethod('clearVideoWatermarks');
  }

  /// startAudioMixing
  static Future<void> startAudioMixing(
      String filepath, bool loopback, bool replace, int cycle) async {
    await _channel.invokeMethod('startAudioMixing', {
      "filepath": filepath,
      "loopback": loopback,
      "replace": replace,
      "cycle": cycle,
    });
  }

  /// stopAudioMixing
  static Future<void> stopAudioMixing() async {
    await _channel.invokeMethod('stopAudioMixing');
  }

  /// pauseAudioMixing
  static Future<void> pauseAudioMixing() async {
    await _channel.invokeMethod('pauseAudioMixing');
  }

  /// resumeAudioMixing
  static Future<void> resumeAudioMixing() async {
    await _channel.invokeMethod('resumeAudioMixing');
  }

  /// adjustAudioMixingVolume
  static Future<void> adjustAudioMixingVolume(int volume) async {
    await _channel.invokeMethod('adjustAudioMixingVolume', {"volume": volume});
  }

  /// adjustAudioMixingPlayoutVolume
  static Future<void> adjustAudioMixingPlayoutVolume(int volume) async {
    await _channel
        .invokeMethod('adjustAudioMixingPlayoutVolume', {"volume": volume});
  }

  /// adjustAudioMixingPublishVolume
  static Future<void> adjustAudioMixingPublishVolume(int volume) async {
    await _channel
        .invokeMethod('adjustAudioMixingPublishVolume', {"volume": volume});
  }

  /// getAudioMixingPlayoutVolume
  static Future<int> getAudioMixingPlayoutVolume() {
    return _channel.invokeMethod('getAudioMixingPlayoutVolume');
  }

  /// getAudioMixingPublishVolume
  static Future<void> getAudioMixingPublishVolume() {
    return _channel.invokeMethod('getAudioMixingPublishVolume');
  }

  /// startAudioMixing
  static Future<void> getAudioMixingDuration() {
    return _channel.invokeMethod('getAudioMixingDuration');
  }

  /// startAudioMixing
  static Future<void> getAudioMixingCurrentPosition() {
    return _channel.invokeMethod('getAudioMixingCurrentPosition');
  }

  /// setAudioMixingPosition
  static Future<void> setAudioMixingPosition(int pos) async {
    await _channel.invokeMethod('setAudioMixingPosition', {"pos": pos});
  }

  /// getEffectsVolume
  static Future<void> getEffectsVolume() async {
    await _channel.invokeMethod('getEffectsVolume');
  }

  /// setEffectsVolume
  static Future<void> setEffectsVolume(double volume) async {
    await _channel.invokeMethod('setEffectsVolume', {"volume": volume});
  }

  /// setVolumeOfEffect
  static Future<void> setVolumeOfEffect() async {
    await _channel.invokeMethod('setVolumeOfEffect');
  }

  /// playEffect
  static Future<void> playEffect(int soundId, String filepath, int loopcount,
      double pitch, double pan, double gain, bool publish) async {
    await _channel.invokeMethod('playEffect', {
      "soundId": soundId,
      "filepath": filepath,
      "loopcount": loopcount,
      "pitch": pitch,
      "pan": pan,
      "gain": gain,
      "publish": publish,
    });
  }

  /// stopEffect
  static Future<void> stopEffect(int soundId) async {
    await _channel.invokeMethod('stopEffect', {"soundId": soundId});
  }

  /// stopAllEffects
  static Future<void> stopAllEffects() async {
    await _channel.invokeMethod('stopAllEffects');
  }

  /// preloadEffect
  static Future<void> preloadEffect(int soundId, String filepath) async {
    await _channel.invokeMethod('preloadEffect', {
      "soundId": soundId,
      "filepath": filepath,
    });
  }

  /// unloadEffect
  static Future<void> unloadEffect(int soundId) async {
    await _channel.invokeMethod('unloadEffect', {"soundId": soundId});
  }

  /// pauseEffect
  static Future<void> pauseEffect(int soundId) async {
    await _channel.invokeMethod('pauseEffect', {"soundId": soundId});
  }

  /// pauseAllEffects
  static Future<void> pauseAllEffects() async {
    await _channel.invokeMethod('pauseAllEffects');
  }

  /// resumeEffect
  static Future<void> resumeEffect(int soundId) async {
    await _channel.invokeMethod('resumeEffect', {"soundId": soundId});
  }

  /// resumeAllEffects
  static Future<void> resumeAllEffects() async {
    await _channel.invokeMethod('resumeAllEffects');
  }

  /// startChannelMediaRelay
  static Future<void> startChannelMediaRelay(
      AgoraChannelMediaRelayConfiguration config) async {
    await _channel
        .invokeMethod('startChannelMediaRelay', {"config": config.toJson()});
  }

  /// removeChannelMediaRelay
  static Future<void> removeChannelMediaRelay(
      AgoraChannelMediaRelayConfiguration config) async {
    await _channel
        .invokeMethod('removeChannelMediaRelay', {"config": config.toJson()});
  }

  /// updateChannelMediaRelay
  static Future<void> updateChannelMediaRelay(
      AgoraChannelMediaRelayConfiguration config) async {
    await _channel
        .invokeMethod('updateChannelMediaRelay', {"config": config.toJson()});
  }

  /// stopChannelMediaRelay
  static Future<void> stopChannelMediaRelay() async {
    await _channel.invokeMethod('stopChannelMediaRelay');
  }

  /// enableInEarMonitoring
  static Future<void> enableInEarMonitoring(bool enabled) async {
    await _channel.invokeMethod('enableInEarMonitoring', {"enabled": enabled});
  }

  /// setInEarMonitoringVolume
  static Future<void> setInEarMonitoringVolume(int volume) async {
    await _channel.invokeMethod('setInEarMonitoringVolume', {"volume": volume});
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

  static Future<void> setLogFile(String filePath) async {
    await _channel.invokeMethod('setLogFile', {"filePath": filePath});
  }

  static Future<void> setLogFilter(int filter) async {
    await _channel.invokeMethod('setLogFilter', {"filter": filter});
  }

  static Future<void> setLogFileSize(int fileSizeInKBytes) async {
    await _channel
        .invokeMethod('setLogFileSize', {"fileSizeInKBytes": fileSizeInKBytes});
  }

  // setParameters
  static Future<int> setParameters(String params) async {
    final int res =
        await _channel.invokeMethod('setParameters', {"params": params});
    return res;
  }

  // getParameters
  static Future<String> getParameters(String params, String args) async {
    final String res = await _channel
        .invokeMethod('getParameters', {"params": params, "args": args});
    return res;
  }

  static void _addEventChannelHandler() async {
    _sink = _eventChannel
        .receiveBroadcastStream()
        .listen(_eventListener, onError: onError);
  }

  static void _removeEventChannelHandler() async {
    await _sink.cancel();
  }

  // CallHandler
  static void _eventListener(dynamic event) {
    final Map<dynamic, dynamic> map = event;
    switch (map['event']) {
      // Core Events
      case 'onWarning':
        if (onWarning != null) {
          onWarning(map['errorCode']);
        }
        break;
      case 'onError':
        if (onError != null) {
          onError(map['errorCode']);
        }
        break;
      case 'onJoinChannelSuccess':
        if (onJoinChannelSuccess != null) {
          onJoinChannelSuccess(map['channel'], map['uid'], map['elapsed']);
        }
        break;
      case 'onRejoinChannelSuccess':
        if (onRejoinChannelSuccess != null) {
          onRejoinChannelSuccess(map['channel'], map['uid'], map['elapsed']);
        }
        break;
      case 'onLeaveChannel':
        if (onLeaveChannel != null) {
          onLeaveChannel();
        }
        break;
      case 'onClientRoleChanged':
        if (onClientRoleChanged != null) {
          ClientRole oldRole = _clientRoleFromInt(map['oldRole']);
          ClientRole newRole = _clientRoleFromInt(map['newRole']);
          onClientRoleChanged(oldRole, newRole);
        }
        break;
      case 'onUserJoined':
        if (onUserJoined != null) {
          onUserJoined(map['uid'], map['elapsed']);
        }
        break;
      case 'onUserOffline':
        if (onUserOffline != null) {
          onUserOffline(map['uid'], map['reason']);
        }
        break;
      case 'onRegisteredLocalUser':
        if (onRegisteredLocalUser != null) {
          onRegisteredLocalUser(map['userAccount'], map['uid']);
        }
        break;
      case 'onUpdatedUserInfo':
        if (onUpdatedUserInfo != null) {
          onUpdatedUserInfo(
              AgoraUserInfo.fromJson(map['userInfo']), map['uid']);
        }
        break;
      case 'onConnectionStateChanged':
        if (onConnectionStateChanged != null) {
          onConnectionStateChanged(map['state'], map['reason']);
        }
        break;
      case 'onNetworkTypeChanged':
        if (onNetworkTypeChanged != null) {
          onNetworkTypeChanged(map['type']);
        }
        break;
      case 'onConnectionLost':
        if (onConnectionLost != null) {
          onConnectionLost();
        }
        break;
      case 'onApiCallExecuted':
        if (onApiCallExecuted != null) {
          onApiCallExecuted(map['errorCode'], map['api'], map['result']);
        }
        break;
      case 'onTokenPrivilegeWillExpire':
        if (onTokenPrivilegeWillExpire != null) {
          onTokenPrivilegeWillExpire(map['token']);
        }
        break;
      case 'onRequestToken':
        if (onRequestToken != null) {
          onRequestToken();
        }
        break;
      // Media Events
      case 'onAudioVolumeIndication':
        if (onAudioVolumeIndication != null) {
          List<dynamic> speakerValues = map['speakers'];
          List<AudioVolumeInfo> speakers = List<AudioVolumeInfo>();
          for (Map speakerValue in speakerValues) {
            AudioVolumeInfo info =
                AudioVolumeInfo(speakerValue['uid'], speakerValue['volume']);
            speakers.add(info);
          }
          onAudioVolumeIndication(map['totalVolume'], speakers);
        }
        break;
      case 'onActiveSpeaker':
        if (onActiveSpeaker != null) {
          onActiveSpeaker(map['uid']);
        }
        break;
      case 'onFirstLocalAudioFrame':
        if (onFirstLocalAudioFrame != null) {
          onFirstLocalAudioFrame(map['elapsed']);
        }
        break;
      case 'onFirstRemoteAudioFrame':
        if (onFirstRemoteAudioFrame != null) {
          onFirstRemoteAudioFrame(map['uid'], map['elapsed']);
        }
        break;
      case 'onFirstRemoteAudioDecoded':
        if (onFirstRemoteAudioDecoded != null) {
          onFirstRemoteAudioDecoded(map['uid'], map['elapsed']);
        }
        break;
      case 'onFirstLocalVideoFrame':
        if (onFirstLocalVideoFrame != null) {
          onFirstLocalVideoFrame(map['width'], map['height'], map['elapsed']);
        }
        break;
      case 'onFirstRemoteVideoFrame':
        if (onFirstRemoteVideoFrame != null) {
          onFirstRemoteVideoFrame(
              map['uid'], map['width'], map['height'], map['elapsed']);
        }
        break;
      case 'onUserMuteAudio':
        if (onUserMuteAudio != null) {
          onUserMuteAudio(map['uid'], map['muted']);
        }
        break;
      // case 'onUserMuteVideo':
      //   if (onUserMuteVideo != null) {
      //     onUserMuteVideo(map['uid'], map['muted']);
      //   }
      //   break;
      case 'onVideoSizeChanged':
        if (onVideoSizeChanged != null) {
          onVideoSizeChanged(map['uid'], map['width'].toDouble(),
              map['height'].toDouble(), map['rotation']);
        }
        break;
      case 'onRemoteVideoStateChanged':
        if (onRemoteVideoStateChanged != null) {
          onRemoteVideoStateChanged(
              map['uid'], map['state'], map['reason'], map['elapsed']);
        }
        break;
      // Fallback Events
      case 'onLocalPublishFallbackToAudioOnly':
        if (onLocalPublishFallbackToAudioOnly != null) {
          onLocalPublishFallbackToAudioOnly(map['isFallbackOrRecover']);
        }
        break;
      case 'onRemoteSubscribeFallbackToAudioOnly':
        if (onRemoteSubscribeFallbackToAudioOnly != null) {
          onRemoteSubscribeFallbackToAudioOnly(
              map['uid'], map['isFallbackOrRecover']);
        }
        break;
      // Device Events
      case 'onAudioRouteChanged':
        if (onAudioRouteChanged != null) {
          onAudioRouteChanged(map['routing']);
        }
        break;
      case 'onCameraFocusAreaChanged':
        if (onCameraFocusAreaChanged != null) {
          onCameraFocusAreaChanged(AgoraCameraRect.fromJson(map["rect"]));
        }
        break;
      case 'onCameraExposureAreaChanged':
        if (onCameraExposureAreaChanged != null) {
          onCameraExposureAreaChanged(AgoraCameraRect.fromJson(map["rect"]));
        }
        break;
      case 'onLocalVideoStateChanged':
        if (onLocalVideoStateChanged != null) {
          onLocalVideoStateChanged(map['localVideoState'], map['errorCode']);
        }
        break;
      case 'onRemoteAudioStateChanged':
        if (onRemoteAudioStateChanged != null) {
          onRemoteAudioStateChanged(
              map['uid'], map['state'], map['reason'], map['elapsed']);
        }
        break;
      case 'onLocalAudioStateChanged':
        if (onLocalAudioStateChanged != null) {
          onLocalAudioStateChanged(map['errorCode'], map['state']);
        }
        break;
      case 'onRtcStats':
        if (onRtcStats != null) {
          RtcStats stats = RtcStats.fromJson(map['stats']);
          onRtcStats(stats);
        }
        break;
      case 'onLastmileQuality':
        if (onLastmileQuality != null) {
          onLastmileQuality(map['quality']);
        }
        break;
      case 'onNetworkQuality':
        if (onNetworkQuality != null) {
          onNetworkQuality(map['uid'], map['txQuality'], map['rxQuality']);
        }
        break;
      case 'onLastmileProbeTestResult':
        if (onLastmileProbeTestResult != null) {
          onLastmileProbeTestResult(AgoraLastmileProbeResult.fromJson(map));
        }
        break;
      case 'onLocalVideoStats':
        if (onLocalVideoStats != null) {
          onLocalVideoStats(LocalVideoStats.fromJson(map['stats']));
        }
        break;
      case 'onLocalAudioStats':
        if (onLocalAudioStats != null) {
          onLocalAudioStats(LocalAudioStats.fromJson(map['stats']));
        }
        break;
      case 'onRemoteVideoStats':
        if (onRemoteVideoStats != null) {
          RemoteVideoStats stats = RemoteVideoStats.fromJson(map['stats']);
          onRemoteVideoStats(stats);
        }
        break;
      case 'onRemoteAudioStats':
        if (onRemoteAudioStats != null) {
          RemoteAudioStats stats = RemoteAudioStats.fromJson(map['stats']);
          onRemoteAudioStats(stats);
        }
        break;
      // Statistics Events
      case 'onLocalAudioMixingStateChanged':
        if (onLocalAudioMixingStateChanged != null) {
          onLocalAudioMixingStateChanged(map["state"], map["errorCode"]);
        }
        break;
      // case 'onRemoteAudioMixingStarted':
      //   if (onRemoteAudioMixingStarted != null) {
      //     onRemoteAudioMixingStarted();
      //   }
      //   break;
      // case 'onRemoteAudioMixingFinished':
      //   if (onRemoteAudioMixingFinished != null) {
      //     onRemoteAudioMixingFinished();
      //   }
      //   break;
      case 'onAudioEffectFinished':
        if (onAudioEffectFinished != null) {
          onAudioEffectFinished(map["soundId"]);
        }
        break;
      case 'onStreamPublished':
        if (onStreamPublished != null) {
          onStreamPublished(map["url"], map["errorCode"]);
        }
        break;
      case 'onStreamUnpublished':
        if (onStreamUnpublished != null) {
          onStreamUnpublished(map["url"]);
        }
        break;
      case 'onTranscodingUpdated':
        if (onTranscodingUpdated != null) {
          onTranscodingUpdated();
        }
        break;
      case 'onRtmpStreamingStateChanged':
        if (onRtmpStreamingStateChanged != null) {
          onRtmpStreamingStateChanged(
              map['url'], map['errorCode'], map['state']);
        }
        break;
      case 'onStreamInjectedStatus':
        if (onStreamInjectedStatus != null) {
          onStreamInjectedStatus(
              {'url': map['url'], 'uid': map['uid'], 'status': map['status']});
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
      case 'onChannelMediaRelayChanged':
        if (onChannelMediaRelayChanged != null) {
          onChannelMediaRelayChanged(map["state"], map["errorCode"]);
        }
        break;
      case 'onReceivedChannelMediaRelayEvent':
        if (onReceivedChannelMediaRelayEvent != null) {
          onReceivedChannelMediaRelayEvent(map["event"]);
        }
        break;

      default:
    }
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
