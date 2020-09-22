import 'classes.dart';
import 'enum_converter.dart';
import 'enums.dart';

typedef EmptyCallback = void Function();
typedef WarningCallback = void Function(WarningCode warn);
typedef ErrorCallback = void Function(ErrorCode err);
typedef ApiCallCallback = void Function(
    ErrorCode error, String api, String result);
typedef UidWithElapsedAndChannelCallback = void Function(
    String channel, int uid, int elapsed);
typedef RtcStatsCallback = void Function(RtcStats stats);
typedef UserAccountCallback = void Function(int uid, String userAccount);
typedef UserInfoCallback = void Function(int uid, UserInfo userInfo);
typedef ClientRoleCallback = void Function(
    ClientRole oldRole, ClientRole newRole);
typedef UidWithElapsedCallback = void Function(int uid, int elapsed);
typedef UserOfflineCallback = void Function(int uid, UserOfflineReason reason);
typedef ConnectionStateCallback = void Function(
    ConnectionStateType state, ConnectionChangedReason reason);
typedef NetworkTypeCallback = void Function(NetworkType type);
typedef TokenCallback = void Function(String token);
typedef AudioVolumeCallback = void Function(
    List<AudioVolumeInfo> speakers, int totalVolume);
typedef UidCallback = void Function(int uid);
typedef ElapsedCallback = void Function(int elapsed);
typedef VideoFrameCallback = void Function(int width, int height, int elapsed);
typedef UidWithMutedCallback = void Function(int uid, bool muted);
typedef VideoSizeCallback = void Function(
    int uid, int width, int height, int rotation);
typedef RemoteVideoStateCallback = void Function(int uid,
    VideoRemoteState state, VideoRemoteStateReason reason, int elapsed);
typedef LocalVideoStateCallback = void Function(
    LocalVideoStreamState localVideoState, LocalVideoStreamError error);
typedef RemoteAudioStateCallback = void Function(int uid,
    AudioRemoteState state, AudioRemoteStateReason reason, int elapsed);
typedef LocalAudioStateCallback = void Function(
    AudioLocalState state, AudioLocalError error);
typedef FallbackCallback = void Function(bool isFallbackOrRecover);
typedef FallbackWithUidCallback = void Function(
    int uid, bool isFallbackOrRecover);
typedef AudioRouteCallback = void Function(AudioOutputRouting routing);
typedef RectCallback = void Function(Rect rect);
typedef NetworkQualityCallback = void Function(NetworkQuality quality);
typedef NetworkQualityWithUidCallback = void Function(
    int uid, NetworkQuality txQuality, NetworkQuality rxQuality);
typedef LastmileProbeCallback = void Function(LastmileProbeResult result);
typedef LocalVideoStatsCallback = void Function(LocalVideoStats stats);
typedef LocalAudioStatsCallback = void Function(LocalAudioStats stats);
typedef RemoteVideoStatsCallback = void Function(RemoteVideoStats stats);
typedef RemoteAudioStatsCallback = void Function(RemoteAudioStats stats);
typedef AudioMixingStateCallback = void Function(
    AudioMixingStateCode state, AudioMixingErrorCode errorCode);
typedef SoundIdCallback = void Function(int soundId);
typedef RtmpStreamingStateCallback = void Function(
    String url, RtmpStreamingState state, RtmpStreamingErrorCode errCode);
typedef StreamInjectedStatusCallback = void Function(
    String url, int uid, InjectStreamStatus status);
typedef StreamMessageCallback = void Function(
    int uid, int streamId, String data);
typedef StreamMessageErrorCallback = void Function(
    int uid, int streamId, ErrorCode error, int missed, int cached);
typedef MediaRelayStateCallback = void Function(
    ChannelMediaRelayState state, ChannelMediaRelayError code);
typedef MediaRelayEventCallback = void Function(ChannelMediaRelayEvent code);
typedef VideoFrameWithUidCallback = void Function(
    int uid, int width, int height, int elapsed);
typedef UrlWithErrorCallback = void Function(String url, ErrorCode error);
typedef UrlCallback = void Function(String url);
typedef TransportStatsCallback = void Function(
    int uid, int delay, int lost, int rxKBitRate);
typedef UidWithEnabledCallback = void Function(int uid, bool enabled);
typedef EnabledCallback = void Function(bool enabled);
typedef AudioQualityCallback = void Function(
    int uid, int quality, int delay, int lost);
typedef MetadataCallback = void Function(
    String buffer, int uid, int timeStampMs);
typedef FacePositionCallback = void Function(
    int imageWidth, int imageHeight, List<FacePositionInfo> faces);

/// The SDK uses the [RtcEngineEventHandler] class to send callbacks to the application, and the application inherits the methods of this class to retrieve these callbacks.
///
/// All methods in this class have their (empty) default implementations, and the application can inherit only some of the required events instead of all of them.
///
/// In the callbacks, the application should avoid time-consuming tasks or call blocking APIs (such as SendMessage), otherwise, the SDK may not work properly.
class RtcEngineEventHandler {
  /// Reports a warning during SDK runtime.
  ///
  /// In most cases, the app can ignore the warning reported by the SDK because the SDK can usually fix the issue and resume running.
  ///
  /// For instance, the SDK may report a [WarningCode.LookupChannelTimeout] warning upon disconnection with the server and tries to reconnect. For detailed warning codes, see [WarningCode].
  WarningCallback warning;

  /// Reports an error during SDK runtime.
  ///
  /// In most cases, the SDK cannot fix the issue and resume running. The SDK requires the app to take action or informs the user about the issue.
  ///
  /// For example, the SDK reports an [ErrorCode.StartCall] error when failing to initialize a call. The app informs the user that the call initialization failed and invokes the [RtcEngine.leaveChannel] method to leave the channel. For detailed error codes, see [ErrorCode].
  ErrorCallback error;

  /// Occurs when an API method is executed.
  ApiCallCallback apiCallExecuted;

  /// Occurs when the local user joins a specified channel.
  ///
  /// The channel name assignment is based on channelName specified in the [RtcEngine.joinChannel] method.
  ///
  /// If the uid is not specified when [RtcEngine.joinChannel] is called, the server automatically assigns a uid.
  UidWithElapsedAndChannelCallback joinChannelSuccess;

  /// Occurs when a user rejoins the channel after being disconnected due to network problems.
  ///
  /// When a user loses connection with the server because of network problems, the SDK automatically tries to reconnect and triggers this callback upon reconnection.
  RtcStatsCallback rejoinChannelSuccess;

  /// Occurs when a user leaves the channel.
  ///
  /// When the app calls the [RtcEngine.leaveChannel] method, the SDK uses this callback to notify the app when the user leaves the channel.
  ///
  /// With this callback, the application retrieves the channel information, such as the call duration and statistics.
  RtcStatsCallback leaveChannel;

  /// Occurs when the local user registers a user account.
  ///
  /// This callback is triggered when the local user successfully registers a user account by calling the [RtcEngine.registerLocalUserAccount] method, or joins a channel by calling the [RtcEngine.joinChannelWithUserAccount] method. This callback reports the user ID and user account of the local user.
  UserAccountCallback localUserRegistered;

  /// Occurs when the SDK gets the user ID and user account of the remote user.
  ///
  /// After a remote user joins the channel, the SDK gets the UID and user account of the remote user, caches them in a mapping table object ([UserInfo]), and triggers this callback on the local client.
  UserInfoCallback userInfoUpdated;

  /// Occurs when the user role switches in a live broadcast. For example, from a host to an audience or from an audience to a host.
  ///
  /// The SDK triggers this callback when the local user switches the user role by calling the [RtcEngine.setClientRole] method after joining the channel.
  ClientRoleCallback clientRoleChanged;

  /// Occurs when a remote user ([ChannelProfile.Communication])/host ([ChannelProfile.LiveBroadcasting]) joins the channel.
  /// - [ChannelProfile.Communication] profile: This callback notifies the app when another user joins the channel. If other users are already in the channel, the SDK also reports to the app on the existing users.
  /// - [ChannelProfile.LiveBroadcasting] profile: This callback notifies the app when the host joins the channel. If other hosts are already in the channel, the SDK also reports to the app on the existing hosts. We recommend having at most 17 hosts in a channel
  ///
  /// The SDK triggers this callback under one of the following circumstances:
  /// - A remote user/host joins the channel by calling the [RtcEngine.joinChannel] method.
  /// - A remote user switches the user role to the host by calling the [RtcEngine.setClientRole] method after joining the channel.
  /// - A remote user/host rejoins the channel after a network interruption.
  /// - The host injects an online media stream into the channel by calling the [RtcEngine.addInjectStreamUrl] method.
  ///
  /// **Note**
  /// - In the [ChannelProfile.LiveBroadcasting] profile:
  /// -- The host receives the `userJoined` callback when another host joins the channel.
  /// -- The audience in the channel receives the `userJoined` callback when a new host joins the channel.
  /// -- When a web application joins the channel, the `userJoined` callback is triggered as long as the web application publishes streams.
  UidWithElapsedCallback userJoined;

  /// Occurs when a remote user ([ChannelProfile.Communication])/host ([ChannelProfile.LiveBroadcasting]) leaves the channel.
  ///
  /// There are two reasons for users to become offline:
  /// - Leave the channel: When the user/host leaves the channel, the user/host sends a goodbye message. When this message is received, the SDK determines that the user/host leaves the channel.
  /// - Drop offline: When no data packet of the user or host is received for a certain period of time (20 seconds for the [ChannelProfile.Communication] profile, and more for the [ChannelProfile.LiveBroadcasting] profile), the SDK assumes that the user/host drops offline. A poor network connection may lead to false detections, so we recommend using the Agora RTM SDK for reliable offline detection.
  UserOfflineCallback userOffline;

  /// Occurs when the network connection state changes.
  ///
  /// The Agora SDK returns this callback to report on the current network connection state when it changes, and the reason to such change.
  ConnectionStateCallback connectionStateChanged;

  /// Occurs when the network type changes.
  ///
  /// The SDK returns the current network type in this callback. When the network connection is interrupted, this callback indicates whether the interruption is caused by a network type change or poor network conditions.
  NetworkTypeCallback networkTypeChanged;

  /// Occurs when the SDK cannot reconnect to Agora's edge server 10 seconds after its connection to the server is interrupted.
  ///
  /// The SDK triggers this callback when it cannot connect to the server 10 seconds after calling [RtcEngine.joinChannel], regardless of whether it is in the channel or not.
  /// If the SDK fails to rejoin the channel 20 minutes after being disconnected from Agora's edge server, the SDK stops rejoining the channel.
  EmptyCallback connectionLost;

  /// Occurs when the token expires in 30 seconds.
  ///
  /// The user becomes offline if the token used when joining the channel expires. This callback is triggered 30 seconds before the token expires to remind the app to get a new token. Upon receiving this callback, you need to generate a new token on the server and call [RtcEngine.renewToken] to pass the new token to the SDK.
  TokenCallback tokenPrivilegeWillExpire;

  /// Occurs when the token has expired.
  ///
  /// After a token is specified when joining the channel, the token expires after a certain period of time, and a new token is required to reconnect to the server. This callback notifies the app to generate a new token and call [RtcEngine.joinChannel] to rejoin the channel with the new token.
  EmptyCallback requestToken;

  /// Reports which users are speaking and the speakers' volume, and whether the local user is speaking.
  ///
  /// This callback reports the IDs and volumes of the loudest speakers (at most 3) at the moment in the channel, and whether the local user is speaking.
  /// By default, this callback is disabled. You can enable it by calling the [RtcEngine.enableAudioVolumeIndication] method. Once enabled, this callback is triggered at the set interval, regardless of whether a user speaks or not.
  /// The SDK triggers two independent onAudioVolumeIndication callbacks at one time, which separately report the volume information of the local user and all the remote speakers. For more information, see the detailed parameter descriptions.
  ///
  /// **Note**
  /// - To enable the voice activity detection of the local user, ensure that you set report_vad(true) in the [RtcEngine.enableAudioVolumeIndication] method.
  /// - Calling the muteLocalAudioStream method affects the SDK's behavior.
  /// @see RtcEngine.muteLocalAudioStream
  /// -- If the local user calls the muteLocalAudioStream method, the SDK stops triggering the local user's callback.
  /// @see RtcEngine.muteLocalAudioStream
  /// -- 20 seconds after a remote speaker calls the muteLocalAudioStream method, the remote speakers' callback does not include information of this remote user; 20 seconds after all remote users call the the muteLocalAudioStream method, the SDK stops triggering the remote speakers' callback.
  /// @see RtcEngine.muteLocalAudioStream
  AudioVolumeCallback audioVolumeIndication;

  /// Reports which user is the loudest speaker.
  ///
  /// This callback reports the speaker with the highest accumulative volume during a certain period. If the user enables the audio volume indication by calling [RtcEngine.enableAudioVolumeIndication], this callback returns the uid of the active speaker whose voice is detected by the audio volume detection module of the SDK.
  ///
  /// **Note**
  /// - To receive this callback, you need to call [RtcEngine.enableAudioVolumeIndication].
  /// - This callback returns the user ID of the user with the highest voice volume during a period of time, instead of at the moment.
  UidCallback activeSpeaker;

  /// Occurs when the first local audio frame is sent.
  ElapsedCallback firstLocalAudioFrame;

  /// Occurs when the first local video frame is rendered.
  ///
  /// This callback is triggered after the first local video frame is rendered on the local video window.
  VideoFrameCallback firstLocalVideoFrame;

  /// Occurs when a remote user stops/resumes sending the video stream.
  ///
  /// @deprecated This callback is deprecated. Use the [RtcEngineEventHandler.remoteVideoStateChanged] callback with the following parameters for the same function:
  /// - [VideoRemoteState.Stopped](0) and [VideoRemoteStateReason.RemoteMuted](5).
  /// - [VideoRemoteState.Decoding](2) and [VideoRemoteStateReason.RemoteUnmuted](6).
  ///
  /// The SDK triggers this callback when the remote user stops or resumes sending the video stream by calling the [RtcEngine.muteLocalVideoStream] method.
  ///
  /// **Note**
  /// - This callback is invalid when the number of users or broadcasters in the channel exceeds 20.
  @deprecated
  UidWithMutedCallback userMuteVideo;

  /// Occurs when the video size or rotation information of a remote user changes.
  VideoSizeCallback videoSizeChanged;

  /// Occurs when the remote video state changes.
  RemoteVideoStateCallback remoteVideoStateChanged;

  /// Occurs when the local video state changes.
  ///
  /// The SDK returns the current video state in this callback. When the state is [LocalVideoStreamState.Failed](3), see the error parameter for details.
  ///
  /// **Note**
  /// - This callback reports the current state of the local video, which keeps changing throughout the RtcEngine life cycle. We recommend maintaining the states reported in this callback, and check the local video state before starting the local camera. If the SDK reports [LocalVideoStreamError.CaptureFailure](4), the local camera is occupied by either the system or a third-party app. To access the camera, call [RtcEngine.enableLocalVideo] (false) first, and then [RtcEngine.enableLocalVideo] (video).
  LocalVideoStateCallback localVideoStateChanged;

  /// Occurs when the remote audio state changes.
  ///
  /// This callback indicates the state change of the remote audio stream.
  RemoteAudioStateCallback remoteAudioStateChanged;

  /// Occurs when the local audio stream state changes.
  ///
  /// This callback indicates the state change of the local audio stream, including the state of the audio recording and encoding, and allows you to troubleshoot issues when exceptions occur.
  ///
  /// **Note**
  /// - When the state is [AudioLocalState.Failed](3), see the error parameter for details.
  LocalAudioStateCallback localAudioStateChanged;

  /// Occurs when the published media stream falls back to an audio-only stream due to poor network conditions or switches back to video stream after the network conditions improve.
  ///
  /// If you call [RtcEngine.setLocalPublishFallbackOption] and set option as [StreamFallbackOptions.AudioOnly](2), this callback is triggered when the locally published stream falls back to audio-only mode due to poor uplink conditions, or when the audio stream switches back to the video after the uplink network condition improves.
  FallbackCallback localPublishFallbackToAudioOnly;

  /// Occurs when the remote media stream falls back to audio-only stream due to poor network conditions or switches back to video stream after the network conditions improve.
  ///
  /// If you call [RtcEngine.setRemoteSubscribeFallbackOption] and set option as [StreamFallbackOptions.AudioOnly](2), this callback is triggered when the remotely subscribed media stream falls back to audio-only mode due to poor uplink conditions, or when the remotely subscribed media stream switches back to the video after the uplink network condition improves.
  FallbackWithUidCallback remoteSubscribeFallbackToAudioOnly;

  /// Occurs when the local audio playback route changes.
  ///
  /// This callback returns that the audio route switched to an earpiece, speakerphone, headset, or Bluetooth device.
  /// See [AudioOutputRouting] for the definition of the routing.
  AudioRouteCallback audioRouteChanged;

  /// Occurs when the camera focus area is changed.
  ///
  /// The SDK triggers this callback when the local user changes the camera focus position by calling the [RtcEngine.setCameraFocusPositionInPreview] method.
  RectCallback cameraFocusAreaChanged;

  /// The camera exposure area has changed.
  ///
  /// The SDK triggers this callback when the local user changes the camera exposure position by calling the [RtcEngine.setCameraExposurePosition] method.
  RectCallback cameraExposureAreaChanged;

  /// Reports the face detection result of the local user.
  ///
  /// Once you enable face detection by calling [RtcEngine.enableFaceDetection], you can get the following information on the local user in real time:
  /// - The width and height of the local video.
  /// - The position of the human face in the local video.
  /// - The distance between the human face and the device screen. This value is based on the fitting calculation of the local video size and the position of the human face.
  ///
  /// **Note**
  /// - If the SDK does not detect a face, it reduces the frequency of this callback to reduce power consumption on the local device.
  /// - The SDK stops triggering this callback when a human face is in close proximity to the screen.
  /// - On Android, the distance value reported in this callback may be slightly different from the actual distance. Therefore, Agora does not recommend using it for accurate calculation.
  FacePositionCallback facePositionChanged;

  /// Reports the statistics of the [RtcEngine] once every two seconds.
  RtcStatsCallback rtcStats;

  /// Reports the last mile network quality of the local user once every two seconds before the user joins the channel. Last mile refers to the connection between the local device and Agora's edge server. After the application calls the [RtcEngine.enableLastmileTest] method, this callback reports once every two seconds the uplink and downlink last mile network conditions of the local user before the user joins the channel.
  NetworkQualityCallback lastmileQuality;

  /// Reports the last mile network quality of each user in the channel once every two seconds.
  ///
  /// Last mile refers to the connection between the local device and Agora's edge server. This callback reports once every two seconds the last mile network conditions of each user in the channel. If a channel includes multiple users, then this callback will be triggered as many times.
  NetworkQualityWithUidCallback networkQuality;

  /// Reports the last-mile network probe result.
  ///
  /// The SDK triggers this callback within 30 seconds after the app calls the [RtcEngine.startLastmileProbeTest] method.
  LastmileProbeCallback lastmileProbeResult;

  /// Reports the statistics of the local video streams.
  ///
  /// The SDK triggers this callback once every two seconds for each user/host. If there are multiple users/hosts in the channel, the SDK triggers this callback as many times.
  LocalVideoStatsCallback localVideoStats;

  /// Reports the statistics of the local audio stream.
  LocalAudioStatsCallback localAudioStats;

  /// Reports the statistics of the video stream from each remote user/host. The SDK triggers this callback once every two seconds for each remote user/host. If a channel includes multiple remote users, the SDK triggers this callback as many times.
  RemoteVideoStatsCallback remoteVideoStats;

  /// Reports the statistics of the audio stream from each remote user/host.
  ///
  /// The SDK triggers this callback once every two seconds for each remote user/host. If a channel includes multiple remote users, the SDK triggers this callback as many times.
  ///
  /// Schemes such as FEC (Forward Error Correction) or retransmission counter the frame loss rate. Hence, users may find the overall audio quality acceptable even when the packet loss rate is high.
  RemoteAudioStatsCallback remoteAudioStats;

  /// Occurs when the audio mixing file playback finishes.
  ///
  /// @deprecated This callback is deprecated. Use [RtcEngineEventHandler.audioMixingStateChanged] instead.
  ///
  /// You can start an audio mixing file playback by calling the [RtcEngine.startAudioMixing] method. This callback is triggered when the audio mixing file playback finishes.
  ///
  /// If the [RtcEngine.startAudioMixing] method call fails, an [WarningCode.AudioMixingOpenError] warning returns in the [warning] callback.
  @deprecated
  EmptyCallback audioMixingFinished;

  /// Occurs when the state of the local user's audio mixing file changes.
  ///
  /// When you call the [RtcEngine.startAudioMixing] method and the state of audio mixing file changes, the Agora SDK triggers this callback.
  /// - When the audio mixing file plays, pauses playing, or stops playing, this callback returns 710, 711, or 713 in state, and 0 in the `errorCode` parameter.
  /// - When exceptions occur during playback, this callback returns 714 in state and an error in the `errorCode` parameter.
  /// - If the local audio mixing file does not exist, or if the SDK does not support the file format or cannot access the music file URL, the SDK returns [WarningCode.AudioMixingOpenError] = 701.
  AudioMixingStateCallback audioMixingStateChanged;

  /// Occurs when the audio effect file playback finishes.
  ///
  /// You can start a local audio effect playback by calling the [RtcEngine.playEffect] method. This callback is triggered when the local audio effect file playback finishes.
  SoundIdCallback audioEffectFinished;

  /// Occurs when the state of the RTMP streaming changes.
  ///
  /// The SDK triggers this callback to report the result of the local user calling the [RtcEngine.addPublishStreamUrl] or [RtcEngine.removePublishStreamUrl] method. This callback returns the URL and its current streaming state. When the streaming state is [RtmpStreamingState.Failure](4), see the `errCode` parameter for details.
  ///
  /// This callback indicates the state of the RTMP streaming. When exceptions occur, you can troubleshoot issues by referring to the detailed error descriptions in the `errCode` parameter.
  RtmpStreamingStateCallback rtmpStreamingStateChanged;

  /// Occurs when the publisher's transcoding settings are updated.
  ///
  /// When the [LiveTranscoding] class in the [RtcEngine.setLiveTranscoding] method updates, the SDK triggers this callback to report the update information.
  ///
  /// **Note**
  /// - If you call the [RtcEngine.setLiveTranscoding] method to set the [LiveTranscoding] class for the first time, the SDK does not trigger this callback.
  EmptyCallback transcodingUpdated;

  /// Reports the status of injecting the online media stream.
  StreamInjectedStatusCallback streamInjectedStatus;

  /// Occurs when the local user receives a remote data stream.
  ///
  /// The SDK triggers this callback when the local user receives the stream message that the remote user sends by calling the [RtcEngine.sendStreamMessage] method.
  StreamMessageCallback streamMessage;

  /// Occurs when the local user fails to receive a remote data stream.
  ///
  /// The SDK triggers this callback when the local user fails to receive the stream message that the remote user sends by calling the [RtcEngine.sendStreamMessage] method.
  StreamMessageErrorCallback streamMessageError;

  /// Occurs when the media engine is loaded.
  EmptyCallback mediaEngineLoadSuccess;

  /// Occurs when the media engine starts.
  EmptyCallback mediaEngineStartCallSuccess;

  /// Occurs when the state of the media stream relay changes.
  ///
  /// The SDK reports the state of the current media relay and possible error messages in this callback.
  MediaRelayStateCallback channelMediaRelayStateChanged;

  /// Reports events during the media stream relay.
  MediaRelayEventCallback channelMediaRelayEvent;

  /// Occurs when the first remote video frame is rendered.
  ///
  /// @deprecated Use [VideoRemoteState.Starting](1) or [VideoRemoteState.Decoding](2) in the [remoteVideoStateChanged] callback instead.
  ///
  /// This callback is triggered after the first frame of the remote video is rendered on the video window. The application can retrieve the data of the time elapsed from the user joining the channel until the first video frame is displayed.
  @deprecated
  VideoFrameWithUidCallback firstRemoteVideoFrame;

  /// Occurs when the first remote audio frame is received.
  ///
  /// @deprecated Use [AudioRemoteState.Starting](1) in [remoteAudioStateChanged] instead.
  @deprecated
  UidWithElapsedCallback firstRemoteAudioFrame;

  /// Occurs when the engine receives the first audio frame from a specified remote user.
  ///
  /// @deprecated Use [VideoRemoteState.Decoding](2) in [remoteAudioStateChanged] instead.
  ///
  /// This callback is triggered in either of the following scenarios：
  /// - The remote user joins the channel and sends the audio stream.
  /// - The remote user stops sending the audio stream and re-sends it after 15 seconds. Possible reasons include:
  /// -- The remote user leaves channel.
  /// -- The remote user drops offline.
  /// -- The remote user calls the [RtcEngine.muteLocalAudioStream] method.
  /// -- The remote user calls the [RtcEngine.disableAudio] method.
  @deprecated
  UidWithElapsedCallback firstRemoteAudioDecoded;

  /// Occurs when a remote user stops/resumes sending the audio stream.
  ///
  /// @deprecated Use the [RtcEngineEventHandler.remoteAudioStateChanged] callback with the following parameters instead:
  /// - [VideoRemoteState.Stopped](0) and [VideoRemoteStateReason.RemoteMuted](5).
  /// - [VideoRemoteState.Decoding](2) and [VideoRemoteStateReason.RemoteUnmuted](6).
  ///
  /// The SDK triggers this callback when the remote user stops or resumes sending the audio stream by calling the [RtcEngine.muteLocalAudioStream] method.
  ///
  /// **Note**
  /// - This callback is invalid when the number of users or broadcasters in the channel exceeds 20.
  @deprecated
  UidWithMutedCallback userMuteAudio;

  /// Reports the result of calling the [RtcEngine.addPublishStreamUrl] method.
  ///
  /// @deprecated Use [RtcEngineEventHandler.rtmpStreamingStateChanged] instead.
  ///
  /// This callback indicates whether you have successfully added an RTMP stream to the CDN.
  @deprecated
  UrlWithErrorCallback streamPublished;

  /// Reports the result of calling the [RtcEngine.removePublishStreamUrl] method.
  ///
  /// @deprecated Use [RtcEngineEventHandler.rtmpStreamingStateChanged] instead.
  ///
  /// This callback indicates whether you have successfully removed an RTMP stream from the CDN.
  @deprecated
  UrlCallback streamUnpublished;

  /// Reports the transport-layer statistics of each remote audio stream.
  ///
  /// @deprecated This callback is deprecated. Use [RtcEngineEventHandler.remoteAudioStats] instead.
  ///
  /// This callback reports the transport-layer statistics, such as the packet loss rate and time delay, once every two seconds after the local user receives an audio packet from a remote user.
  @deprecated
  TransportStatsCallback remoteAudioTransportStats;

  /// Reports the transport-layer statistics of each remote video stream.
  ///
  /// @deprecated This callback is deprecated. Use [RtcEngineEventHandler.remoteVideoStats] instead.
  ///
  /// This callback reports the transport-layer statistics, such as the packet loss rate and time delay, once every two seconds after the local user receives the video packet from a remote user.
  @deprecated
  TransportStatsCallback remoteVideoTransportStats;

  /// Occurs when a remote user enables/disables the video module.
  ///
  /// @deprecated This callback is deprecated and replaced by the [RtcEngineEventHandler.remoteVideoStateChanged] callback with the following parameters:
  /// - [VideoRemoteState.Stopped](0) and [VideoRemoteStateReason.RemoteMuted](5).
  /// - [VideoRemoteState.Decoding](2) and [VideoRemoteStateReason.RemoteUnmuted](6).
  ///
  /// Once the video module is disabled, the remote user can only use a voice call. The remote user cannot send or receive any video from other users.
  ///
  /// The SDK triggers this callback when the remote user enables or disables the video module by calling the [RtcEngine.enableVideo] or [RtcEngine.disableVideo] method.
  ///
  /// **Note**
  /// - This callback is invalid when the number of users or broadcasters in the channel exceeds 20.
  @deprecated
  UidWithEnabledCallback userEnableVideo;

  /// Occurs when a remote user enables/disables the local video capture function.
  ///
  /// @deprecated This callback is deprecated and replaced by the [RtcEngineEventHandler.remoteVideoStateChanged] callback with the following parameters:
  /// - [VideoRemoteState.Stopped](0) and [VideoRemoteStateReason.RemoteMuted](5).
  /// - [VideoRemoteState.Decoding](2) and [VideoRemoteStateReason.RemoteUnmuted](6).
  ///
  /// The SDK triggers this callback when the remote user resumes or stops capturing the video stream by calling the [RtcEngine.enableLocalVideo] method.
  /// This callback is only applicable to the scenario when the remote user only wants to watch the remote video without sending any video stream to the other user.
  @deprecated
  UidWithEnabledCallback userEnableLocalVideo;

  /// Occurs when the first remote video frame is received and decoded.
  ///
  /// @deprecated This callback is deprecated. Use [VideoRemoteState.Starting](1) or [VideoRemoteState.Decoding](2) in the [RtcEngineEventHandler.remoteVideoStateChanged] callback instead.
  ///
  /// This callback is triggered in either of the following scenarios:
  /// - The remote user joins the channel and sends the video stream.
  /// - The remote user stops sending the video stream and re-sends it after 15 seconds. Possible reasons include:
  /// -- The remote user leaves channel.
  /// -- The remote user drops offline.
  /// -- The remote user calls the [RtcEngine.muteLocalVideoStream] method.
  /// -- The remote user calls the [RtcEngine.disableVideo] method.
  @deprecated
  VideoFrameWithUidCallback firstRemoteVideoDecoded;

  /// Occurs when the microphone is enabled/disabled.
  ///
  ///
  /// @deprecated This callback is deprecated. Use [AudioLocalState.Stopped](0) or [AudioLocalState.Recording](1) in the [RtcEngineEventHandler.localAudioStateChanged] callback instead.
  /// The SDK triggers this callback when the local user resumes or stops capturing the local audio stream by calling the [RtcEngine.enableLocalAudio] method.
  @deprecated
  EnabledCallback microphoneEnabled;

  /// Occurs when the connection between the SDK and the server is interrupted.
  ///
  /// @deprecated Use [RtcEngineEventHandler.connectionStateChanged] instead.
  ///
  /// The SDK triggers this callback when it loses connection to the server for more than four seconds after the connection is established. After triggering this callback, the SDK tries to reconnect to the server. You can use this callback to implement pop-up reminders. This callback is different from [RtcEngineEventHandler.connectionLost]:
  /// - The SDK triggers the [RtcEngineEventHandler.connectionInterrupted] callback when the SDK loses connection with the server for more than four seconds after it joins the channel.
  /// - The SDK triggers the [RtcEngineEventHandler.connectionLost] callback when it loses connection with the server for more than 10 seconds, regardless of whether it joins the channel or not.
  ///
  /// If the SDK fails to rejoin the channel 20 minutes after being disconnected from Agora's edge server, the SDK stops rejoining the channel.
  @deprecated
  EmptyCallback connectionInterrupted;

  /// Occurs when your connection is banned by the Agora Server.
  ///
  /// @deprecated Use [RtcEngineEventHandler.connectionStateChanged] instead.
  @deprecated
  EmptyCallback connectionBanned;

  /// Reports the statistics of the audio stream from each remote user/host.
  ///
  /// @deprecated Use [RtcEngineEventHandler.remoteAudioStats] instead.
  ///
  /// The SDK triggers this callback once every two seconds to report the audio quality of each remote user/host sending an audio stream. If a channel has multiple remote users/hosts sending audio streams, the SDK trggers this callback as many times.
  @deprecated
  AudioQualityCallback audioQuality;

  /// Occurs when the camera is turned on and ready to capture video.
  ///
  /// @deprecated Use [LocalVideoStreamState.Capturing](1) in the [RtcEngineEventHandler.localVideoStateChanged] callback instead. If the camera fails to turn on, fix the error reported in the [LocalVideoStreamState.Failed] callback.
  @deprecated
  EmptyCallback cameraReady;

  /// Occurs when the video stops playing.
  ///
  /// @deprecated Use [LocalVideoStreamState.Stopped](0) in the [RtcEngineEventHandler.localVideoStateChanged] callback instead. The application can use this callback to change the configuration of the view (for example, displaying other pictures in the view) after the video stops playing.
  @deprecated
  EmptyCallback videoStopped;

  /// Occurs when the local user receives the metadata.
  MetadataCallback metadataReceived;

  /// Constructs a [RtcEngineEventHandler]
  RtcEngineEventHandler({this.warning,
    this.error,
    this.apiCallExecuted,
    this.joinChannelSuccess,
    this.rejoinChannelSuccess,
    this.leaveChannel,
    this.localUserRegistered,
    this.userInfoUpdated,
    this.clientRoleChanged,
    this.userJoined,
    this.userOffline,
    this.connectionStateChanged,
    this.networkTypeChanged,
    this.connectionLost,
    this.tokenPrivilegeWillExpire,
    this.requestToken,
    this.audioVolumeIndication,
    this.activeSpeaker,
    this.firstLocalAudioFrame,
    this.firstLocalVideoFrame,
    this.userMuteVideo,
    this.videoSizeChanged,
    this.remoteVideoStateChanged,
    this.localVideoStateChanged,
    this.remoteAudioStateChanged,
    this.localAudioStateChanged,
    this.localPublishFallbackToAudioOnly,
    this.remoteSubscribeFallbackToAudioOnly,
    this.audioRouteChanged,
    this.cameraFocusAreaChanged,
    this.cameraExposureAreaChanged,
    this.facePositionChanged,
    this.rtcStats,
    this.lastmileQuality,
    this.networkQuality,
    this.lastmileProbeResult,
    this.localVideoStats,
    this.localAudioStats,
    this.remoteVideoStats,
    this.remoteAudioStats,
    this.audioMixingFinished,
    this.audioMixingStateChanged,
    this.audioEffectFinished,
    this.rtmpStreamingStateChanged,
    this.transcodingUpdated,
    this.streamInjectedStatus,
    this.streamMessage,
    this.streamMessageError,
    this.mediaEngineLoadSuccess,
    this.mediaEngineStartCallSuccess,
    this.channelMediaRelayStateChanged,
    this.channelMediaRelayEvent,
    this.firstRemoteVideoFrame,
    this.firstRemoteAudioFrame,
    this.firstRemoteAudioDecoded,
    this.userMuteAudio,
    this.streamPublished,
    this.streamUnpublished,
    this.remoteAudioTransportStats,
    this.remoteVideoTransportStats,
    this.userEnableVideo,
    this.userEnableLocalVideo,
    this.firstRemoteVideoDecoded,
    this.microphoneEnabled,
    this.connectionInterrupted,
    this.connectionBanned,
    this.audioQuality,
    this.cameraReady,
    this.videoStopped,
    this.metadataReceived});

  // ignore: public_member_api_docs
  void process(String methodName, List<dynamic> data) {
    switch (methodName) {
      case 'Warning':
        warning?.call(WarningCodeConverter
            .fromValue(data[0])
            .e);
        break;
      case 'Error':
        error?.call(ErrorCodeConverter
            .fromValue(data[0])
            .e);
        break;
      case 'ApiCallExecuted':
        apiCallExecuted?.call(
            ErrorCodeConverter
                .fromValue(data[0])
                .e, data[1], data[2]);
        break;
      case 'JoinChannelSuccess':
        joinChannelSuccess?.call(data[0], data[1], data[2]);
        break;
      case 'RejoinChannelSuccess':
        rejoinChannelSuccess
            ?.call(RtcStats.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'LeaveChannel':
        leaveChannel
            ?.call(RtcStats.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'LocalUserRegistered':
        localUserRegistered?.call(data[0], data[1]);
        break;
      case 'UserInfoUpdated':
        userInfoUpdated?.call(
            data[0], UserInfo.fromJson(Map<String, dynamic>.from(data[1])));
        break;
      case 'ClientRoleChanged':
        clientRoleChanged?.call(ClientRoleConverter
            .fromValue(data[0])
            .e,
            ClientRoleConverter
                .fromValue(data[1])
                .e);
        break;
      case 'UserJoined':
        userJoined?.call(data[0], data[1]);
        break;
      case 'UserOffline':
        userOffline?.call(
            data[0], UserOfflineReasonConverter
            .fromValue(data[1])
            .e);
        break;
      case 'ConnectionStateChanged':
        connectionStateChanged?.call(
            ConnectionStateTypeConverter
                .fromValue(data[0])
                .e,
            ConnectionChangedReasonConverter
                .fromValue(data[1])
                .e);
        break;
      case 'NetworkTypeChanged':
        networkTypeChanged?.call(NetworkTypeConverter
            .fromValue(data[0])
            .e);
        break;
      case 'ConnectionLost':
        connectionLost?.call();
        break;
      case 'TokenPrivilegeWillExpire':
        tokenPrivilegeWillExpire?.call(data[0]);
        break;
      case 'RequestToken':
        requestToken?.call();
        break;
      case 'AudioVolumeIndication':
        final list = List<Map>.from(data[0]);
        audioVolumeIndication?.call(
            List.generate(
                list.length,
                    (index) =>
                    AudioVolumeInfo.fromJson(
                        Map<String, dynamic>.from(list[index]))),
            data[1]);
        break;
      case 'ActiveSpeaker':
        activeSpeaker?.call(data[0]);
        break;
      case 'FirstLocalAudioFrame':
        firstLocalAudioFrame?.call(data[0]);
        break;
      case 'FirstLocalVideoFrame':
        firstLocalVideoFrame?.call(data[0], data[1], data[2]);
        break;
      case 'UserMuteVideo':
        userMuteVideo?.call(data[0], data[1]);
        break;
      case 'VideoSizeChanged':
        videoSizeChanged?.call(data[0], data[1], data[2], data[3]);
        break;
      case 'RemoteVideoStateChanged':
        remoteVideoStateChanged?.call(
            data[0],
            VideoRemoteStateConverter
                .fromValue(data[1])
                .e,
            VideoRemoteStateReasonConverter
                .fromValue(data[2])
                .e,
            data[3]);
        break;
      case 'LocalVideoStateChanged':
        localVideoStateChanged?.call(LocalVideoStreamStateConverter(data[0]).e,
            LocalVideoStreamErrorConverter(data[1]).e);
        break;
      case 'RemoteAudioStateChanged':
        remoteAudioStateChanged?.call(
            data[0],
            AudioRemoteStateConverter
                .fromValue(data[1])
                .e,
            AudioRemoteStateReasonConverter
                .fromValue(data[2])
                .e,
            data[3]);
        break;
      case 'LocalAudioStateChanged':
        localAudioStateChanged?.call(AudioLocalStateConverter(data[0]).e,
            AudioLocalErrorConverter(data[1]).e);
        break;
      case 'LocalPublishFallbackToAudioOnly':
        localPublishFallbackToAudioOnly?.call(data[0]);
        break;
      case 'RemoteSubscribeFallbackToAudioOnly':
        remoteSubscribeFallbackToAudioOnly?.call(data[0], data[1]);
        break;
      case 'AudioRouteChanged':
        audioRouteChanged
            ?.call(AudioOutputRoutingConverter
            .fromValue(data[0])
            .e);
        break;
      case 'CameraFocusAreaChanged':
        cameraFocusAreaChanged
            ?.call(Rect.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'CameraExposureAreaChanged':
        cameraExposureAreaChanged
            ?.call(Rect.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'FacePositionChanged':
        final list = List<Map>.from(data[2]);
        facePositionChanged?.call(
            data[0],
            data[1],
            List.generate(
                list.length,
                    (index) =>
                    FacePositionInfo.fromJson(
                        Map<String, dynamic>.from(list[index]))));
        break;
      case 'RtcStats':
        rtcStats?.call(RtcStats.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'LastmileQuality':
        lastmileQuality?.call(NetworkQualityConverter
            .fromValue(data[0])
            .e);
        break;
      case 'NetworkQuality':
        networkQuality?.call(
            data[0],
            NetworkQualityConverter
                .fromValue(data[1])
                .e,
            NetworkQualityConverter
                .fromValue(data[2])
                .e);
        break;
      case 'LastmileProbeResult':
        lastmileProbeResult?.call(
            LastmileProbeResult.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'LocalVideoStats':
        localVideoStats?.call(
            LocalVideoStats.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'LocalAudioStats':
        localAudioStats?.call(
            LocalAudioStats.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'RemoteVideoStats':
        remoteVideoStats?.call(
            RemoteVideoStats.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'RemoteAudioStats':
        remoteAudioStats?.call(
            RemoteAudioStats.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'AudioMixingFinished':
        audioMixingFinished?.call();
        break;
      case 'AudioMixingStateChanged':
        audioMixingStateChanged?.call(
          AudioMixingStateCodeConverter
              .fromValue(data[0])
              .e,
          AudioMixingErrorCodeConverter
              .fromValue(data[1])
              .e,
        );
        break;
      case 'AudioEffectFinished':
        audioEffectFinished?.call(data[0]);
        break;
      case 'RtmpStreamingStateChanged':
        rtmpStreamingStateChanged?.call(
          data[0],
          RtmpStreamingStateConverter
              .fromValue(data[1])
              .e,
          RtmpStreamingErrorCodeConverter
              .fromValue(data[2])
              .e,
        );
        break;
      case 'TranscodingUpdated':
        transcodingUpdated?.call();
        break;
      case 'StreamInjectedStatus':
        streamInjectedStatus?.call(
            data[0], data[1], InjectStreamStatusConverter
            .fromValue(data[2])
            .e);
        break;
      case 'StreamMessage':
        streamMessage?.call(data[0], data[1], data[2]);
        break;
      case 'StreamMessageError':
        streamMessageError?.call(data[0], data[1],
            ErrorCodeConverter
                .fromValue(data[2])
                .e, data[3], data[4]);
        break;
      case 'MediaEngineLoadSuccess':
        mediaEngineLoadSuccess?.call();
        break;
      case 'MediaEngineStartCallSuccess':
        mediaEngineStartCallSuccess?.call();
        break;
      case 'ChannelMediaRelayStateChanged':
        channelMediaRelayStateChanged?.call(
          ChannelMediaRelayStateConverter
              .fromValue(data[0])
              .e,
          ChannelMediaRelayErrorConverter
              .fromValue(data[1])
              .e,
        );
        break;
      case 'ChannelMediaRelayEvent':
        channelMediaRelayEvent
            ?.call(ChannelMediaRelayEventConverter
            .fromValue(data[0])
            .e);
        break;
      case 'FirstRemoteVideoFrame':
        firstRemoteVideoFrame?.call(data[0], data[1], data[2], data[3]);
        break;
      case 'FirstRemoteAudioFrame':
        firstRemoteAudioFrame?.call(data[0], data[1]);
        break;
      case 'FirstRemoteAudioDecoded':
        firstRemoteAudioDecoded?.call(data[0], data[1]);
        break;
      case 'UserMuteAudio':
        userMuteAudio?.call(data[0], data[1]);
        break;
      case 'StreamPublished':
        streamPublished?.call(data[0], ErrorCodeConverter
            .fromValue(data[1])
            .e);
        break;
      case 'StreamUnpublished':
        streamUnpublished?.call(data[0]);
        break;
      case 'RemoteAudioTransportStats':
        remoteAudioTransportStats?.call(data[0], data[1], data[2], data[3]);
        break;
      case 'RemoteVideoTransportStats':
        remoteVideoTransportStats?.call(data[0], data[1], data[2], data[3]);
        break;
      case 'UserEnableVideo':
        userEnableVideo?.call(data[0], data[1]);
        break;
      case 'UserEnableLocalVideo':
        userEnableLocalVideo?.call(data[0], data[1]);
        break;
      case 'FirstRemoteVideoDecoded':
        firstRemoteVideoDecoded?.call(data[0], data[1], data[2], data[3]);
        break;
      case 'MicrophoneEnabled':
        microphoneEnabled?.call(data[0]);
        break;
      case 'ConnectionInterrupted':
        connectionInterrupted?.call();
        break;
      case 'ConnectionBanned':
        connectionBanned?.call();
        break;
      case 'AudioQuality':
        audioQuality?.call(data[0], data[1], data[2], data[3]);
        break;
      case 'CameraReady':
        cameraReady?.call();
        break;
      case 'VideoStopped':
        videoStopped?.call();
        break;
      case 'MetadataReceived':
        metadataReceived?.call(data[0], data[1], data[2]);
        break;
    }
  }
}

/// The RtcChannelEvents interface.
class RtcChannelEventHandler {
  /// Reports the warning code of the [RtcChannel] instance.
  WarningCallback warning;

  /// Reports the error code of the [RtcChannel] instance.
  ErrorCallback error;

  /// Occurs when the local user joins a specified channel.
  ///
  /// If the uid is not specified when calling [RtcChannel.joinChannel], the server automatically assigns a uid.
  UidWithElapsedCallback joinChannelSuccess;

  /// Occurs when a user rejoins the channel after being disconnected due to network problems.
  ///
  /// When a user loses connection with the server because of network problems, the SDK automatically tries to reconnect and triggers this callback upon reconnection.
  UidWithElapsedCallback rejoinChannelSuccess;

  /// Occurs when a user leaves the channel.
  ///
  /// When a user leaves the channel by using the [RtcChannel.leaveChannel] method, the SDK uses this callback to notify the app when the user leaves the channel.
  ///
  /// With this callback, the app retrieves the channel information, such as the call duration and statistics.
  RtcStatsCallback leaveChannel;

  /// Occurs when the user role switches in a [ChannelProfile.LiveBroadcasting] channel. For example, from broadcaster to audience or vice versa.
  ///
  /// The SDK triggers this callback when the local user switches the user role by calling the setClientRole method after joining the channel.
  /// See [RtcChannel.setClientRole].
  ClientRoleCallback clientRoleChanged;

  /// Occurs when a remote user (Communication) or a broadcaster ([ChannelProfile.LiveBroadcasting]) joins the channel.
  /// - [ChannelProfile.Communication] profile: This callback notifies the app when another user joins the channel. If other users are already in the channel, the SDK also reports to the app on the existing users.
  /// - [ChannelProfile.LiveBroadcasting] profile: This callback notifies the app when the host joins the channel. If other hosts are already in the channel, the SDK also reports to the app on the existing hosts. We recommend having at most 17 hosts in a channel.
  ///
  /// **Note**
  /// - In the [ChannelProfile.LiveBroadcasting] profile:
  /// -- The host receives this callback when another host joins the channel.
  /// -- The audience in the channel receives this callback when a new host joins the channel.
  /// -- When a web app joins the channel, this callback is triggered as long as the web app publishes streams.
  UidWithElapsedCallback userJoined;

  /// Occurs when a remote user ([ChannelProfile.Communication]) or a broadcaster ([ChannelProfile.LiveBroadcasting]) leaves the channel.
  ///
  /// There are two reasons for users to become offline:
  /// - Leave the channel: When the user/broadcaster leaves the channel, the user/broadcaster sends a goodbye message. When this message is received, the SDK determines that the user/host leaves the channel.
  /// - Go offline: When no data packet of the user or broadcaster is received for a certain period of time (around 20 seconds), the SDK assumes that the user/broadcaster drops offline. A poor network connection may lead to false detections, so we recommend using the Agora RTM SDK for reliable offline detection.
  UserOfflineCallback userOffline;

  /// Occurs when the network connection state changes.
  ///
  /// The Agora SDK triggers this callback to report on the current network connection state when it changes, and the reason to such change.
  ConnectionStateCallback connectionStateChanged;

  /// Occurs when the SDK cannot reconnect to Agora's edge server 10 seconds after its connection to the server is interrupted.
  ///
  /// The SDK also triggers this callback when it cannot connect to the server 10 seconds after calling [RtcChannel.joinChannel], regardless of whether it is in the channel or not.
  /// If the SDK fails to rejoin the channel 20 minutes after being disconnected from Agora's edge server, the SDK stops rejoining the channel.
  EmptyCallback connectionLost;

  /// Occurs when the token expires in 30 seconds.
  ///
  /// The user becomes offline if the token used when joining the channel expires. This callback is triggered 30 seconds before the token expires, to remind the app to get a new token. Upon receiving this callback, you need to generate a new token on the server and call [RtcChannel.renewToken] to pass the new token to the SDK.
  TokenCallback tokenPrivilegeWillExpire;

  /// Occurs when the token has expired.
  ///
  /// After a token is specified when joining the channel, the token expires after a certain period of time, and a new token is required to reconnect to the server. This callback notifies the app to generate a new token and call [RtcChannel.renewToken] to renew the token.
  EmptyCallback requestToken;

  /// Reports which user is the loudest speaker.
  ///
  /// This callback reports the speaker with the highest accumulative volume during a certain period. If the user enables the audio volume indication by calling [RtcEngine.enableAudioVolumeIndication], this callback returns the uid of the active speaker whose voice is detected by the audio volume detection module of the SDK.
  ///
  /// **Note**
  /// - To receive this callback, you need to call [RtcEngine.enableAudioVolumeIndication].
  /// - This callback reports the ID of the user with the highest voice volume during a period of time, instead of at the moment.
  UidCallback activeSpeaker;

  /// Occurs when the video size or rotation information of a remote user changes.
  VideoSizeCallback videoSizeChanged;

  /// Occurs when the remote video state changes.
  RemoteVideoStateCallback remoteVideoStateChanged;

  /// Occurs when the remote audio state changes.
  ///
  /// This callback indicates the state change of the remote audio stream.
  RemoteAudioStateCallback remoteAudioStateChanged;

  /// Occurs when the published media stream falls back to an audio-only stream due to poor network conditions or switches back to video stream after the network conditions improve.
  ///
  /// If you call [RtcEngine.setLocalPublishFallbackOption] and set option as [StreamFallbackOptions.AudioOnly](2), this callback is triggered when the locally published stream falls back to audio-only mode due to poor uplink conditions, or when the audio stream switches back to the video after the uplink network condition improves.
  FallbackCallback localPublishFallbackToAudioOnly;

  /// Occurs when the remote media stream falls back to audio-only stream due to poor network conditions or switches back to video stream after the network conditions improve.
  ///
  /// If you call [RtcEngine.setRemoteSubscribeFallbackOption] and set option as [StreamFallbackOptions.AudioOnly](2), this callback is triggered when the remote media stream falls back to audio-only mode due to poor uplink conditions, or when the remote media stream switches back to the video after the uplink network condition improves.
  ///
  /// **Note**
  /// - Once the remote media stream is switched to the low stream due to poor network conditions, you can monitor the stream switch between a high and low stream in the [RtcEngineEventHandler.remoteVideoStats] callback.
  FallbackWithUidCallback remoteSubscribeFallbackToAudioOnly;

  /// Reports the statistics of the [RtcEngine] once every two seconds.
  RtcStatsCallback rtcStats;

  /// Reports the last mile network quality of each user in the channel once every two seconds.
  ///
  /// Last mile refers to the connection between the local device and Agora's edge server. This callback reports once every two seconds the last mile network conditions of each user in the channel. If a channel includes multiple users, then this callback will be triggered as many times.
  NetworkQualityWithUidCallback networkQuality;

  /// Reports the statistics of the video stream from each remote user/broadcaster. The SDK triggers this callback once every two seconds for each remote user/broadcaster. If a channel includes multiple remote users, the SDK triggers this callback as many times.
  RemoteVideoStatsCallback remoteVideoStats;

  /// Reports the statistics of the audio stream from each remote user/broadcaster.
  ///
  /// The SDK triggers this callback once every two seconds for each remote user/broadcaster. If a channel includes multiple remote users, the SDK triggers this callback as many times.
  ///
  /// Schemes such as FEC (Forward Error Correction) or retransmission counter the frame loss rate. Hence, users may find the overall audio quality acceptable even when the packet loss rate is high.
  RemoteAudioStatsCallback remoteAudioStats;

  /// Occurs when the state of the RTMP streaming changes.
  ///
  /// The SDK triggers this callback to report the result of the local user calling the [RtcChannel.addPublishStreamUrl] or [RtcChannel.removePublishStreamUrl] method. This callback returns the URL and its current streaming state. When the streaming state is [RtmpStreamingState.Failure](4), see the `errCode` parameter for details.
  ///
  /// This callback indicates the state of the RTMP streaming. When exceptions occur, you can troubleshoot issues by referring to the detailed error descriptions in the `errCode` parameter.
  RtmpStreamingStateCallback rtmpStreamingStateChanged;

  /// Occurs when the publisher's transcoding settings are updated.
  ///
  /// When the [LiveTranscoding] class in the [RtcChannel.setLiveTranscoding] method updates, the SDK triggers this callback to report the update information.
  ///
  /// **Note**
  /// - If you call the [RtcChannel.setLiveTranscoding] method to set the [LiveTranscoding] class for the first time, the SDK does not trigger this callback.
  EmptyCallback transcodingUpdated;

  /// Reports the status of injecting the online media stream.
  StreamInjectedStatusCallback streamInjectedStatus;

  /// Occurs when the local user receives a remote data stream.
  ///
  /// The SDK triggers this callback when the local user receives the stream message that the remote user sends by calling the [RtcChannel.sendStreamMessage] method.
  StreamMessageCallback streamMessage;

  /// Occurs when the local user fails to receive a remote data stream.
  ///
  /// The SDK triggers this callback when the local user fails to receive the stream message that the remote user sends by calling the [RtcChannel.sendStreamMessage] method.
  StreamMessageErrorCallback streamMessageError;

  /// Occurs when the state of the media stream relay changes.
  ///
  /// The SDK reports the state of the current media relay and possible error messages in this callback.
  MediaRelayStateCallback channelMediaRelayStateChanged;

  /// Reports events during the media stream relay.
  MediaRelayEventCallback channelMediaRelayEvent;

  /// Occurs when the local user receives the metadata, including the following parameters:
  /// - `buffer`: The sent or received metadata.
  /// - `uid`: ID of the user who sends the metadata.
  /// - `timeStampMs`: The timestamp of the metadata.
  MetadataCallback metadataReceived;

  /// Constructs a [RtcChannelEventHandler]
  RtcChannelEventHandler({this.warning,
    this.error,
    this.joinChannelSuccess,
    this.rejoinChannelSuccess,
    this.leaveChannel,
    this.clientRoleChanged,
    this.userJoined,
    this.userOffline,
    this.connectionStateChanged,
    this.connectionLost,
    this.tokenPrivilegeWillExpire,
    this.requestToken,
    this.activeSpeaker,
    this.videoSizeChanged,
    this.remoteVideoStateChanged,
    this.remoteAudioStateChanged,
    this.localPublishFallbackToAudioOnly,
    this.remoteSubscribeFallbackToAudioOnly,
    this.rtcStats,
    this.networkQuality,
    this.remoteVideoStats,
    this.remoteAudioStats,
    this.rtmpStreamingStateChanged,
    this.transcodingUpdated,
    this.streamInjectedStatus,
    this.streamMessage,
    this.streamMessageError,
    this.channelMediaRelayStateChanged,
    this.channelMediaRelayEvent,
    this.metadataReceived});

  // ignore: public_member_api_docs
  void process(String methodName, List<dynamic> data) {
    switch (methodName) {
      case 'Warning':
        warning?.call(WarningCodeConverter
            .fromValue(data[0])
            .e);
        break;
      case 'Error':
        error?.call(ErrorCodeConverter
            .fromValue(data[0])
            .e);
        break;
      case 'JoinChannelSuccess':
        joinChannelSuccess?.call(data[0], data[1]);
        break;
      case 'RejoinChannelSuccess':
        rejoinChannelSuccess?.call(data[0], data[1]);
        break;
      case 'LeaveChannel':
        leaveChannel
            ?.call(RtcStats.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'ClientRoleChanged':
        clientRoleChanged?.call(ClientRoleConverter
            .fromValue(data[0])
            .e,
            ClientRoleConverter
                .fromValue(data[1])
                .e);
        break;
      case 'UserJoined':
        userJoined?.call(data[0], data[1]);
        break;
      case 'UserOffline':
        userOffline?.call(
            data[0], UserOfflineReasonConverter
            .fromValue(data[1])
            .e);
        break;
      case 'ConnectionStateChanged':
        connectionStateChanged?.call(
            ConnectionStateTypeConverter
                .fromValue(data[0])
                .e,
            ConnectionChangedReasonConverter
                .fromValue(data[1])
                .e);
        break;
      case 'ConnectionLost':
        connectionLost?.call();
        break;
      case 'TokenPrivilegeWillExpire':
        tokenPrivilegeWillExpire?.call(data[0]);
        break;
      case 'RequestToken':
        requestToken?.call();
        break;
      case 'ActiveSpeaker':
        activeSpeaker?.call(data[0]);
        break;
      case 'VideoSizeChanged':
        videoSizeChanged?.call(data[0], data[1], data[2], data[3]);
        break;
      case 'RemoteVideoStateChanged':
        remoteVideoStateChanged?.call(
            data[0],
            VideoRemoteStateConverter
                .fromValue(data[1])
                .e,
            VideoRemoteStateReasonConverter
                .fromValue(data[2])
                .e,
            data[3]);
        break;
      case 'RemoteAudioStateChanged':
        remoteAudioStateChanged?.call(
            data[0],
            AudioRemoteStateConverter
                .fromValue(data[1])
                .e,
            AudioRemoteStateReasonConverter
                .fromValue(data[2])
                .e,
            data[3]);
        break;
      case 'LocalPublishFallbackToAudioOnly':
        localPublishFallbackToAudioOnly?.call(data[0]);
        break;
      case 'RemoteSubscribeFallbackToAudioOnly':
        remoteSubscribeFallbackToAudioOnly?.call(data[0], data[1]);
        break;
      case 'RtcStats':
        rtcStats?.call(RtcStats.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'NetworkQuality':
        networkQuality?.call(
            data[0],
            NetworkQualityConverter
                .fromValue(data[1])
                .e,
            NetworkQualityConverter
                .fromValue(data[2])
                .e);
        break;
      case 'RemoteVideoStats':
        remoteVideoStats?.call(
            RemoteVideoStats.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'RemoteAudioStats':
        remoteAudioStats?.call(
            RemoteAudioStats.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'RtmpStreamingStateChanged':
        rtmpStreamingStateChanged?.call(
          data[0],
          RtmpStreamingStateConverter
              .fromValue(data[1])
              .e,
          RtmpStreamingErrorCodeConverter
              .fromValue(data[2])
              .e,
        );
        break;
      case 'TranscodingUpdated':
        transcodingUpdated?.call();
        break;
      case 'StreamInjectedStatus':
        streamInjectedStatus?.call(
            data[0], data[1], InjectStreamStatusConverter
            .fromValue(data[2])
            .e);
        break;
      case 'StreamMessage':
        streamMessage?.call(data[0], data[1], data[2]);
        break;
      case 'StreamMessageError':
        streamMessageError?.call(data[0], data[1],
            ErrorCodeConverter
                .fromValue(data[2])
                .e, data[3], data[4]);
        break;
      case 'ChannelMediaRelayStateChanged':
        channelMediaRelayStateChanged?.call(
          ChannelMediaRelayStateConverter
              .fromValue(data[0])
              .e,
          ChannelMediaRelayErrorConverter
              .fromValue(data[1])
              .e,
        );
        break;
      case 'ChannelMediaRelayEvent':
        channelMediaRelayEvent
            ?.call(ChannelMediaRelayEventConverter
            .fromValue(data[0])
            .e);
        break;
      case 'MetadataReceived':
        metadataReceived?.call(data[0], data[1], data[2]);
        break;
    }
  }
}
