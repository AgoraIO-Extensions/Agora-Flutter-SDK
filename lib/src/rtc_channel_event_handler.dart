import 'package:agora_rtc_engine/src/event_types.dart';

///
/// The SDK uses RtcChannelEventHandler to send RtcChannel event notifications to your app.
///
///
class RtcChannelEventHandler {
  ///
  /// Reports the warning code of RtcChannel .
  ///
  ///
  /// Param [warn] Warning codes.
  ///
  /// Param [msg] The warning message.
  ///
  WarningCallback? warning;

  ///
  /// The error code RtcChannel reported.
  ///
  ///
  /// Param [err] The error code.
  ///
  /// Param [msg] The error message.
  ///
  ErrorCallback? error;

  ///
  /// Occurs when a user joins a channel.
  /// This callback notifies the application that a user joins a specified channel.
  ///
  /// Param [uid] User ID. If you have specified a user ID in joinChannel , the ID will be returned here; otherwise, the SDK returns an ID automatically assigned by the Agora server.
  ///
  /// Param [elapsed] The time elapsed (in milliseconds) from the local user calling joinChannel till this event.
  ///
  UidWithElapsedAndChannelCallback? joinChannelSuccess;

  ///
  /// Occurs when a user rejoins the channel.
  /// When a user loses connection with the server because of network problems, the SDK automatically tries to reconnect and triggers this callback upon reconnection.
  ///
  /// Param [elapsed] Time elapsed (ms) from starting to reconnect until the SDK triggers this
  ///  callback.
  ///
  /// Param [uid] The ID of the user who rejoins the channel.
  ///
  UidWithElapsedAndChannelCallback? rejoinChannelSuccess;

  ///
  /// Occurs when a user leaves a channel.
  /// When a user leaves the channel by using the leaveChannel method, the SDK uses this callback to notify the app when the user leaves the channel. With this callback, the app gets the channel information, such as the call duration and quality statistics.
  ///
  /// Param [stats] The statistics of the call, see RtcStats .
  ///
  RtcStatsCallback? leaveChannel;

  ///
  /// Occurs when the user role switches in the interactive live streaming.
  /// The SDK triggers this callback when the local user changes the user role after joining the channel.
  ///
  /// Param [newRole] Role that the user switches to: ClientRole .
  ///
  /// Param [oldRole] Role that the user switches from: ClientRole .
  ///
  ClientRoleCallback? clientRoleChanged;

  ///
  /// Occurs when a remote user (COMMUNICATION)/ host (LIVE_BROADCASTING) joins the channel.
  /// In a communication channel, this callback indicates that a remote user joins the channel. The SDK also triggers this callback to report the existing users in the channel when a user joins the channel.
  ///  In a live-broadcast channel, this callback indicates that a host joins the channel. The SDK also triggers this callback to report the existing hosts in the channel when a host joins the channel. Agora recommends limiting the number of hosts to 17. The SDK triggers this callback under one of the following circumstances:
  ///  A remote user/host joins the channel by calling the joinChannel method.
  ///  A remote user switches the user role to the host after joining the channel.
  ///  A remote user/host rejoins the channel after a network interruption.
  ///  The host injects an online media stream into the channel by calling the addInjectStreamUrl method.
  ///
  /// Param [uid] The ID of the user or host who joins the channel.
  ///
  /// Param [elapsed] Time delay (ms) fromthe local user calling joinChannel until this callback is triggered.
  ///
  UidWithElapsedCallback? userJoined;

  ///
  /// Occurs when a remote user (COMMUNICATION)/ host (LIVE_BROADCASTING) leaves the channel.
  /// There are two reasons for users to become offline:
  ///  Leave the channel: When a user/host leaves the channel, the user/host sends a goodbye message. When this message is received, the SDK determines that the user/host leaves the channel.
  ///  Drop offline: When no data packet of the user or host is received for a certain period of time (20 seconds for the communication profile, and more for the live broadcast profile), the SDK assumes that the user/host drops offline. A poor network connection may lead to false detections. It's recommended to use the Agora RTM SDK for reliable offline detection.
  ///
  /// Param [reason] Reasons why the user goes offline: UserOfflineReason .
  ///
  /// Param [uid] The ID of the user who leaves the channel or goes offline.
  ///
  UserOfflineCallback? userOffline;

  ///
  /// Occurs when the network connection state changes.
  /// When the network connection state changes, the SDK triggers this callback and reports the current connection state and the reason for the change.
  ///
  /// Param [reason] The reason for a connection state change.
  ///
  /// Param [state] The current connection state.
  ///
  ///
  ConnectionStateCallback? connectionStateChanged;

  ///
  /// Occurs when the SDK cannot reconnect to Agora's edge server 10 seconds after its connection to the server is interrupted.
  /// The SDK triggers this callback when it cannot connect to the server 10 seconds after calling the joinChannel method, regardless of whether it is in the channel.
  ///
  EmptyCallback? connectionLost;

  ///
  /// Occurs when the token expires in 30 seconds.
  /// When the token is about to expire in 30 seconds, the SDK triggers this callback to remind the app to renew the token. Upon receiving this callback, generate a new token on your server, and call renewToken to pass the new token to the SDK.
  ///
  /// Param [token] The token that expires in 30 seconds.
  ///
  TokenCallback? tokenPrivilegeWillExpire;

  ///
  /// Occurs when the token expires.
  /// When the token expires during a call, the SDK triggers this callback to remind the app to renew the token.
  ///  Once you receive this callback, generate a new token on your app server, and call joinChannel to rejoin the channel.
  ///
  EmptyCallback? requestToken;

  ///
  /// Occurs when the most active speaker is detected.
  /// After a successful call of enableAudioVolumeIndication , the SDK continuously detects which remote user has the loudest volume. During the current period, the remote user, who is detected as the loudest for the most times, is the most active user.
  ///  When the number of users exceeds two (included) and an active speaker is detected, the SDK triggers this callback and reports the uid of the most active speaker.
  ///  If the most active speaker remains the same, the SDK triggers the activeSpeaker callback only once.
  ///  If the most active speaker changes to another user, the SDK triggers this callback again and reports the uid of the new active speaker.
  ///
  /// Param [uid] The user ID of the most active speaker.
  ///
  UidCallback? activeSpeaker;

  ///
  /// Occurs when the video size or rotation of a specified user changes.
  ///
  ///
  /// Param [rotation] The rotation information. The value range is [0,360).
  ///
  /// Param [height] The height (pixels) of the video stream.
  ///
  /// Param [width] The width (pixels) of the video stream.
  ///
  /// Param [uid] The ID of the user whose video size or rotation changes.
  ///  uid is 0 for the local user.
  ///
  VideoSizeCallback? videoSizeChanged;

  ///
  /// Occurs when the remote video state changes.
  /// This callback does not work properly when the number of users (in the voice/video call channel) or hosts (in the live streaming channel) in the channel exceeds 17.
  ///
  /// Param [reason]  The reason for the remote video state
  ///  change, see VideoRemoteStateReason .
  ///
  /// Param [state]  The state of the remote video, see
  ///  VideoRemoteState .
  ///
  /// Param [uid] The ID of the remote user whose video state changes.
  ///
  /// Param [elapsed] Time elapsed (ms) from the local user calling the joinChannel method until the SDK triggers this callback.
  ///
  RemoteVideoStateCallback? remoteVideoStateChanged;

  ///
  /// Occurs when the remote audio state changes.
  /// When the audio state of a remote user (in the voice/video call channel) or host (in the live streaming channel) changes, the SDK triggers this callback to report the current state of the remote audio stream.
  ///  This callback does not work properly when the number of users (in the voice/video call channel) or hosts (in the live streaming channel) in the channel exceeds 17.
  ///
  /// Param [reason] The reason of the remote audio state change, see AudioRemoteStateReason .
  ///
  /// Param [state] The state of the remote audio, see AudioRemoteState .
  ///
  /// Param [uid] The ID of the remote user whose audio state changes.
  ///
  /// Param [elapsed] Time elapsed (ms) from the local user calling the joinChannel method until the SDK triggers this callback.
  ///
  RemoteAudioStateCallback? remoteAudioStateChanged;

  ///
  /// Occurs when the published media stream falls back to an audio-only stream.
  /// If you call setLocalPublishFallbackOption and set option as AudioOnly, the SDK triggers this callback when the remote media stream falls back to audio-only mode due to poor uplink conditions, or when the remote media stream switches back to the video after the uplink network condition improves.
  ///  If the local stream falls back to the audio-only stream, the remote user receives the userMuteVideo callback.
  ///
  /// Param [isFallbackOrRecover] true: The published stream falls
  ///  back to audio-only due to poor network conditions.
  ///  false: The published stream switches
  ///  back to the video after the network conditions improve.
  ///
  FallbackCallback? localPublishFallbackToAudioOnly;

  ///
  /// Occurs when the remote media stream falls back to the audio-only stream due to poor network conditions or switches back to the video stream after the network conditions improve.
  /// If you call setRemoteSubscribeFallbackOption and set option as AudioOnly, the SDK triggers this callback when the remote media stream falls back to audio-only mode due to poor uplink conditions, or when the remote media stream switches back to the video after the downlink network condition improves.
  ///  Once the remote media stream switches to the low-quality stream due to poor network conditions, you can monitor the stream switch between a high-quality and low-quality stream in the remoteVideoStats callback.
  ///
  /// Param [isFallbackOrRecover] true: The remotely subscribed media stream falls back to audio-only due to poor network conditions.
  ///  false: The remotely subscribed media stream switches back to the video stream after the network conditions improved.
  ///
  /// Param [uid] The user ID of the remote user.
  ///
  FallbackWithUidCallback? remoteSubscribeFallbackToAudioOnly;

  ///
  /// Reports the statistics of the current call.
  /// The SDK triggers this callback once every two seconds after the user joins the channel.
  ///
  /// Param [stats] Statistics of the RTC engine, see RtcStats for
  ///  details.
  ///
  ///
  RtcStatsCallback? rtcStats;

  ///
  /// Reports the last mile network quality of each user in the channel.
  /// This callback reports the last mile network conditions of each user in the channel. Last mile refers to the connection between the local device and Agora's edge server.
  ///  The SDK triggers this callback once every two seconds. If a channel includes multiple users, the SDK triggers this callback as many times.
  ///
  /// Param [rxQuality] Downlink network quality rating of the user in terms of packet loss rate,
  ///  average RTT, and jitter of the downlink network.
  ///  Unknown (0): The quality is unknown.
  ///  Excellent (1): The quality is excellent.
  ///  Good (2): The network quality seems excellent, but the bitrate can be slightly lower than excellent.
  ///  Poor (3): Users can feel the communication is slightly impaired.
  ///  Bad (4): Users cannot communicate smoothly.
  ///  VBad (5): The quality is so bad that users can barely communicate.
  ///  Down (6): The network is down, and users cannot communicate at all.
  ///
  ///
  /// Param [txQuality] Uplink network quality rating of the user in terms of the transmission bit
  ///  rate, packet loss rate, average RTT (Round-Trip Time) and jitter of the
  ///  uplink network. This parameter is a quality rating helping you understand
  ///  how well the current uplink network conditions can support the selected
  ///  video encoder configuration. For example, a 1000 Kbps uplink network may be
  ///  adequate for video frames with a resolution of 640 × 480 and a frame rate of
  ///  15 fps in the LIVE_BROADCASTING profile, but might be inadequate for
  ///  resolutions higher than 1280 × 720.
  ///  Unknown (0): The quality is unknown.
  ///  Excellent (1): The quality is excellent.
  ///  Good (2): The network quality seems excellent, but the bitrate can be slightly lower than excellent.
  ///  Poor (3): Users can feel the communication is slightly impaired.
  ///  Bad (4): Users cannot communicate smoothly.
  ///  VBad (5): The quality is so bad that users can barely communicate.
  ///  Down (6): The network is down, and users cannot communicate at all.
  ///
  ///
  /// Param [uid] User ID. The network quality of the user with this user ID is
  ///  reported.
  ///  If the uid is 0, the local network quality is reported.
  ///
  ///
  NetworkQualityWithUidCallback? networkQuality;

  ///
  /// Reports the transport-layer statistics of each remote video stream.
  /// Reports the statistics of the video stream from the remote users. The SDK triggers this callback once every two seconds for each remote user. If a channel has multiple users/hosts sending video streams, the SDK triggers this callback as many times.
  ///
  /// Param [stats] Statistics of the remote video stream.
  ///
  RemoteVideoStatsCallback? remoteVideoStats;

  ///
  /// Reports the transport-layer statistics of each remote audio stream.
  /// The SDK triggers this callback once every two seconds for each remote user who is sending audio streams. If a channel includes multiple remote users, the SDK triggers this callback as many times.
  ///
  /// Param [stats] The statistics of the received remote audio streams. See RemoteAudioStats .
  ///
  RemoteAudioStatsCallback? remoteAudioStats;

  ///
  /// Occurs when the media push state changes.
  /// When the CDN live streaming state changes, the SDK triggers this callback to report the current state and the reason why the state has changed. When exceptions occur, you can troubleshoot issues by referring to the detailed error descriptions in the error code parameter.
  ///
  /// Param [errCode] The detailed error information for the media push. See RtmpStreamingErrorCode .
  ///
  /// Param [state] The current state of the media push. See RtmpStreamingState . When the streaming state is Failure (4), you can view the error information in the errorCode parameter.
  ///
  /// Param [url] The URL address where the state of the media push changes.
  ///
  RtmpStreamingStateCallback? rtmpStreamingStateChanged;

  ///
  /// Occurs when the publisher's transcoding is updated.
  /// If you call the setLiveTranscoding
  ///  method to set the LiveTranscoding class for the first time, the
  ///  SDK does not trigger this callback.
  ///  When the LiveTranscoding class in the setLiveTranscoding method updates, the SDK triggers the transcodingUpdated callback to report the update information.
  ///
  EmptyCallback? transcodingUpdated;

  ///
  /// Occurs when a media stream URL address is added to the interactive live streaming.
  ///
  ///
  /// Param [status] State of the externally injected stream: InjectStreamStatus .
  ///
  /// Param [uid] User ID.
  ///
  /// Param [url] The URL address of the externally injected stream.
  ///
  StreamInjectedStatusCallback? streamInjectedStatus;

  ///
  /// Occurs when the local user receives the data stream from the remote user.
  /// The SDK triggers this callback when the local user receives the stream message that the remote user sends by calling the sendStreamMessage method.
  ///
  /// Param [data] The data received.
  ///
  /// Param [streamId] The stream ID of the received message.
  ///
  /// Param [uid] The ID of the remote user sending the message.
  ///
  StreamMessageCallback? streamMessage;

  ///
  /// Occurs when the local user does not receive the data stream from the remote user.
  /// The SDK triggers this callback when the local user fails to receive the stream message that the remote user sends by calling the sendStreamMessage method.
  ///
  /// Param [cached] Number of incoming cached messages when the data stream is interrupted.
  ///
  /// Param [missed] The number of lost messages.
  ///
  /// Param [error] The error code.
  ///
  /// Param [streamId] The stream ID of the received message.
  ///
  /// Param [uid] The ID of the remote user sending the message.
  ///
  StreamMessageErrorCallback? streamMessageError;

  ///
  /// Occurs when the state of the media stream relay changes.
  /// The SDK returns the state of the current media relay with any error message.
  ///
  /// Param [code]  The error code of the channel media
  ///  replay.
  ///
  /// Param [state]  The state code.
  ///
  MediaRelayStateCallback? channelMediaRelayStateChanged;

  ///
  /// Reports events during the media stream relay.
  ///
  ///
  /// Param [code] The event code of channel media relay. See ChannelMediaRelayEvent .
  ///
  ///
  MediaRelayEventCallback? channelMediaRelayEvent;

  ///
  /// Occurs when the local user receives Metadata .
  ///
  ///
  /// Param [buffer] The recevied metadata.
  ///
  /// Param [uid] The ID of the user who sent the metadata.
  ///
  /// Param [timeStampMs] The timestamp (ms) of the received metadata.
  ///
  MetadataCallback? metadataReceived;

  ///
  /// Occurs when the audio publishing state changes.
  ///
  ///
  /// Param [elapseSinceLastState] The time elapsed (ms) from the previous state to the current state.
  ///
  /// Param [newState] For the current publishing state, see StreamPublishState.
  ///
  /// Param [oldState] For the previous publishing state, see StreamPublishState .
  ///
  /// Param [channel] The channel name.
  ///
  StreamPublishStateCallback? audioPublishStateChanged;

  ///
  /// Occurs when the video publishing state changes.
  ///
  ///
  /// Param [elapseSinceLastState] The time elapsed (ms) from the previous state to the current state.
  ///
  /// Param [newState] For the current publishing state, see StreamPublishState.
  ///
  /// Param [oldState] For the previous publishing state, see StreamPublishState .
  ///
  StreamPublishStateCallback? videoPublishStateChanged;

  ///
  /// Occurs when the audio subscribing state changes.
  ///
  ///
  /// Param [elapseSinceLastState] The time elapsed (ms) from the previous state to the current state.
  ///
  /// Param [newState] The current subscribing status, see StreamSubscribeState for details.
  ///
  /// Param [oldState] The previous subscribing status, see StreamSubscribeState
  ///  for details.
  ///
  /// Param [channel] The channel name.
  ///
  StreamSubscribeStateCallback? audioSubscribeStateChanged;

  ///
  /// Occurs when the video subscribing state changes.
  ///
  ///
  /// Param [elapseSinceLastState] The time elapsed (ms) from the previous state to the current state.
  ///
  /// Param [newState] The current subscribing status, see StreamSubscribeState for details.
  ///
  /// Param [oldState] The previous subscribing status, see StreamSubscribeState
  ///  for details.
  ///
  /// Param [uid] The ID of the remote user.
  ///
  StreamSubscribeStateCallback? videoSubscribeStateChanged;

  ///
  /// Reports events during the media push.
  ///
  ///
  /// Param [eventCode] The event code of media push. See RtmpStreamingEvent for details.
  ///
  /// Param [url] The URL for media push.
  ///
  RtmpStreamingEventCallback? rtmpStreamingEvent;

  ///
  /// Reports whether the super resolution feature is successfully enabled.
  /// After calling enableRemoteSuperResolution , the SDK triggers the callback to report whether super resolution is successfully enabled. If it is not successfully enabled, use reason for troubleshooting.
  ///
  /// Param [reason] The reason why super resolution algorithm is not successfully enabled.
  ///
  /// Param [enabled] Whether super resolution is successfully enabled:
  ///  true: Super resolution is successfully enabled.
  ///  false: Super resolution is not successfully enabled.
  ///
  ///
  /// Param [uid] The ID of the remote user.
  ///
  UserSuperResolutionEnabledCallback? userSuperResolutionEnabled;

  /// @nodoc
  OnClientRoleChangeFailed? clientRoleChangeFailed;

  /// Constructs the [RtcChannelEventHandler].
  RtcChannelEventHandler({
    this.warning,
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
    this.metadataReceived,
    this.audioPublishStateChanged,
    this.videoPublishStateChanged,
    this.audioSubscribeStateChanged,
    this.videoSubscribeStateChanged,
    this.rtmpStreamingEvent,
    this.userSuperResolutionEnabled,
    this.clientRoleChangeFailed,
  });
}
