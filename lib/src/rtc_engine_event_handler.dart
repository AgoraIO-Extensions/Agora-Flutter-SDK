import 'package:agora_rtc_engine/src/event_types.dart';

///
///  The SDK uses the RtcEngineEventHandler interface to send event notifications to your app. Your app can get those notifications through methods that inherit this interface.
///
///
class RtcEngineEventHandler {
  ///
  /// Reports a warning during SDK runtime.
  /// Occurs when a warning occurs during SDK runtime. In most cases, the app can ignore the warnings reported by the SDK because the SDK can usually fix the issue and resume running. For example, when losing connection with the server, the SDK may report WARN_LOOKUP_CHANNEL_TIMEOUT and automatically try to reconnect.
  ///
  /// Param [warn] Warning codes.
  ///
  /// Param [msg] Warning description.
  ///
  WarningCallback? warning;

  ///
  /// Reports an error during SDK runtime.
  /// This callback indicates that an error (concerning network or media) occurs during SDK runtime. In most cases, the SDK cannot fix the issue and resume running. The SDK requires the application to take action or informs the user about the issue. For example, the SDK reports an ERR_START_CALL error when failing to initialize a call. The app informs the user that the call initialization failed and calls leaveChannel to leave the channel.
  ///
  /// Param [err] The error code.
  ///
  ErrorCallback? error;

  ///
  /// Occurs when a method is executed by the SDK.
  ///
  ///
  /// Param [error] The error code returned by the SDK when the method call fails. For detailed error information and troubleshooting methods, see Error Code and Warning Code.If the SDK returns 0, then the method call is successful.
  ///
  /// Param [api] The method executed by the SDK.
  ///
  /// Param [result] The result of the method call.
  ///
  ApiCallCallback? apiCallExecuted;

  ///
  /// Occurs when a user joins a channel.
  /// This callback notifies the application that a user joins a specified channel.
  ///
  /// Param [channel] The name of the channel.
  ///
  /// Param [uid] The ID of the user who joins the channel.
  ///
  /// Param [elapsed] The time elapsed (ms) from the local user calling joinChannel until the SDK triggers this callback.
  ///
  UidWithElapsedAndChannelCallback? joinChannelSuccess;

  ///
  /// Occurs when a user rejoins the channel.
  /// When a user loses connection with the server because of network problems, the SDK automatically tries to reconnect and triggers this callback upon reconnection.
  ///
  /// Param [channel] The name of the channel.
  ///
  /// Param [uid] The ID of the user who rejoins the channel.
  ///
  /// Param [elapsed] Time elapsed (ms) from starting to reconnect until the SDK triggers this
  ///  callback.
  ///
  UidWithElapsedAndChannelCallback? rejoinChannelSuccess;

  ///
  /// Occurs when a user leaves a channel.
  /// This callback notifies the app that the user leaves the channel by calling leaveChannel . From this callback, the app can get information such as the call duration and quality statistics.
  ///
  /// Param [stats] The statistics of the call, see RtcStats .
  ///
  RtcStatsCallback? leaveChannel;

  ///
  /// Occurs when the local user registers a user account.
  /// After the local user successfully calls registerLocalUserAccount to register the user account or calls joinChannelWithUserAccount to join a channel, the SDK triggers the callback and informs the local user's UID and User Account.
  ///
  /// Param [uid] The ID of the local user.
  ///
  /// Param [userAccount] The user account of the local user.
  ///
  UserAccountCallback? localUserRegistered;

  ///
  /// Occurs when the SDK gets the user ID and user account of the remote user.
  /// After a remote user joins the channel, the SDK gets the UID and user account of the remote user, caches them in a mapping table object, and triggers this callback on the local client.
  ///
  /// Param [uid] The ID of the remote user.
  ///
  /// Param [userInfo] The UserInfo object that contains the user ID and user account of the remote user. See UserInfo for details.
  ///
  UserInfoCallback? userInfoUpdated;

  ///
  /// Occurs when the user role switches in the interactive live streaming.
  /// The SDK triggers this callback when the local user switches the user role after joining the channel.
  ///
  /// Param [oldRole] Role that the user switches from: ClientRole .
  ///
  /// Param [newRole] Role that the user switches to: ClientRole .
  ///
  ClientRoleCallback? clientRoleChanged;

  ///
  /// Occurs when a remote user (COMMUNICATION)/ host (LIVE_BROADCASTING) joins the channel.
  /// In a communication channel, this callback indicates that a remote user joins the channel. The SDK also triggers this callback to report the existing users in the channel when a user joins the channel.
  ///  In a live-broadcast channel, this callback indicates that a host joins the channel. The SDK also triggers this callback to report the existing hosts in the channel when a host joins the channel. Agora recommends limiting the number of hosts to 17. The SDK triggers this callback under one of the following circumstances:
  ///  A remote user/host joins the channel by calling the joinChannel method.
  ///  A remote user switches the user role to the host after joining the channel.
  ///  A remote user/host rejoins the channel after a network interruption.
  ///
  /// Param [uid] The ID of the user or host who joins the channel.
  ///
  /// Param [elapsed] Time delay (ms) from the local user calling joinChannel
  ///  until this callback is triggered.
  ///
  UidWithElapsedCallback? userJoined;

  ///
  /// Occurs when a remote user (COMMUNICATION)/ host (LIVE_BROADCASTING) leaves the channel.
  /// There are two reasons for users to become offline:
  ///  Leave the channel: When a user/host leaves the channel, the user/host sends a goodbye message. When this message is received, the SDK determines that the user/host leaves the channel.
  ///  Drop offline: When no data packet of the user or host is received for a certain period of time (20 seconds for the communication profile, and more for the live broadcast profile), the SDK assumes that the user/host drops offline. A poor network connection may lead to false detections. It's recommended to use the Agora RTM SDK for reliable offline detection.
  ///
  /// Param [uid] The ID of the user who leaves the channel or goes offline.
  ///
  /// Param [reason] Reasons why the user goes offline: UserOfflineReason .
  ///
  UserOfflineCallback? userOffline;

  ///
  /// Occurs when the network connection state changes.
  /// When the network connection state changes, the SDK triggers this callback and reports the current connection state and the reason for the change.
  ///
  /// Param [state] The current connection state.
  ///
  ///
  /// Param [reason] The reason for a connection state change.
  ///
  ConnectionStateCallback? connectionStateChanged;

  ///
  /// Occurs when the local network type changes.
  /// This callback occurs when the connection state of the local user changes. You can get the connection state and reason for the state change in this callback. When the network connection is interrupted, this callback indicates whether the interruption is caused by a network type change or poor network conditions.
  ///
  /// Param [type] The type of the local network connection.
  ///
  ///
  NetworkTypeCallback? networkTypeChanged;

  ///
  /// Occurs when the SDK cannot reconnect to Agora's edge server 10 seconds after its connection to the server is interrupted.
  /// The SDK triggers this callback when it cannot connect to the server 10 seconds after
  ///  calling the joinChannel method, regardless of whether it is in
  ///  the channel. If the SDK fails to rejoin the channel 20 minutes after being
  ///  disconnected from Agora's edge server, the SDK stops rejoining the channel.
  ///
  EmptyCallback? connectionLost;

  ///
  /// Occurs when the token expires in 30 seconds.
  /// When the token is about to expire in 30 seconds, the SDK triggers this callback to remind the app to renew the token.
  ///  Upon receiving this callback, generate a new token on your server, and call renewToken to pass the new token to the SDK.
  ///
  /// Param [token] The token that expires in 30 seconds.
  ///
  TokenCallback? tokenPrivilegeWillExpire;

  ///
  /// Occurs when the token expires.
  /// When the token expires during a call, the SDK triggers this callback to
  ///  remind the app to renew the token.
  ///  Once you receive this callback, generate a new token on your app server, and call
  ///  joinChannel to rejoin the channel.
  ///
  EmptyCallback? requestToken;

  ///
  /// Reports the volume information of users.
  /// By default, this callback is disabled. You can enable it by calling enableAudioVolumeIndication . Once this callback is enabled and users send streams in the channel, the SDK triggers the enableAudioVolumeIndication callback at the time interval set in audioVolumeIndication. The SDK triggers two independent audioVolumeIndication callbacks simultaneously, which separately report the volume information of the local user who sends a stream and the remote users (up to three) whose instantaneous volumes are the highest.
  ///  After you enable this callback, calling muteLocalAudioStream affects the SDK's behavior as follows:
  ///  If the local user stops publishing the audio stream, the SDK stops triggering the local user's callback.
  ///  20 seconds after a remote user whose volume is one of the three highest stops publishing the audio stream, the callback excludes this user's information; 20 seconds after all remote users stop publishing audio streams, the SDK stops triggering the callback for remote users.
  ///
  /// Param [speakers] The volume information of the users, see AudioVolumeInfo . An empty speakers array in the callback indicates that no remote user is in the channel or sending a stream at the moment.
  ///
  /// Param [totalVolume] The volume of the speaker. The value range is [0,255].
  ///  In the callback for the local user, totalVolume is the volume of the local user who sends a stream.
  ///  In the callback for remote users, totalVolume is the sum of the volume of all remote users (up to three) whose instantaneous volumes are the highest. If the user calls startAudioMixing , then totalVolume is the volume after audio mixing.
  ///
  AudioVolumeCallback? audioVolumeIndication;

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
  /// Occurs when the engine sends the first local audio frame.
  /// Deprecated:
  ///  Please use firstLocalAudioFramePublished instead.
  ///
  /// Param [elapsed] The time elapsed (ms) from the local user calling joinChannel until the SDK triggers this callback.
  ///
  @Deprecated('')
  ElapsedCallback? firstLocalAudioFrame;

  ///
  /// Occurs when the first local video frame is rendered.
  /// The SDK triggers this callback when the first local video frame is displayed/rendered on the local video view.
  ///
  /// Param [width] The width (px) of the first local video frame.
  ///
  /// Param [height] The height (px) of the first local video frame.
  ///
  /// Param [elapsed] The time elapsed (ms) from the local user calling joinChanneluntil the SDK triggers this callback. If you
  ///  call startPreview before calling joinChannel, then this parameter is the time elapsed from
  ///  calling the startPreview method until the SDK
  ///  triggers this callback.
  ///
  VideoFrameCallback? firstLocalVideoFrame;

  ///
  /// Occurs when a remote user's video stream playback pauses/resumes.
  /// The SDK triggers this callback when the remote user stops or resumes sending the video stream by calling the muteLocalVideoStream method.
  ///  This callback does not work properly when the number of users (in the COMMUNICATION profile) or hosts (in the LIVE_BROADCASTING profile) in the channel exceeds 17.
  ///
  /// Param [uid] The ID of the remote user.
  ///
  /// Param [muted] Whether the remote user's video stream playback is paused/resumed:
  ///  true: Paused.
  ///  false: Resumed.
  ///
  ///
  @Deprecated('')
  UidWithMutedCallback? userMuteVideo;

  ///
  /// Occurs when the video size or rotation of a specified user changes.
  ///
  ///
  /// Param [uid] The ID of the user whose video size or rotation changes.
  ///  uid is 0 for the local user.
  ///
  /// Param [width] The width (pixels) of the video stream.
  ///
  /// Param [height] The height (pixels) of the video stream.
  ///
  /// Param [rotation] The rotation information. The value range is [0,360).
  ///
  VideoSizeCallback? videoSizeChanged;

  ///
  /// Occurs when the remote video state changes.
  /// This callback does not work properly when the number of users (in the voice/video call channel) or hosts (in the live streaming channel) in the channel exceeds 17.
  ///
  /// Param [uid] The ID of the remote user whose video state changes.
  ///
  /// Param [state]  The state of the remote video, see
  ///  VideoRemoteState .
  ///
  /// Param [reason]  The reason for the remote video state
  ///  change, see VideoRemoteStateReason .
  ///
  /// Param [elapsed] Time elapsed (ms) from the local user calling the joinChannel method until the SDK triggers this
  ///  callback.
  ///
  RemoteVideoStateCallback? remoteVideoStateChanged;

  ///
  /// Occurs when the local video stream state changes.
  /// When the state of the local video stream changes (including the state of the video capture and encoding), the SDK triggers this callback to report the current state. This callback indicates the state of the local video stream, including camera capturing and video encoding, and allows you to troubleshoot issues when exceptions occur.
  ///  The SDK triggers the localVideoStateChanged callback with the state code of Failed and error code of CaptureFailure in the following situations:
  ///  The app switches to the background, and the system gets the camera resource.
  ///  The camera starts normally, but does not output video for four consecutive seconds. When the camera outputs the captured video frames, if the video frames are the same for 15 consecutive frames, the SDK triggers the localVideoStateChanged callback with the state code of Capturing and error code of CaptureFailure. Note that the video frame duplication detection is only available for video frames with a resolution greater than 200 × 200, a frame rate greater than or equal to 10 fps, and a bitrate less than 20 Kbps.
  ///  For some device models, the SDK does not trigger this callback when the state of the local video changes while the local video capturing device is in use, so you have to make your own timeout judgment.
  ///
  /// Param [localVideoState] The state of the local video, see LocalVideoStreamState .
  ///
  ///
  /// Param [error] The detailed error information, see LocalVideoStreamError .
  ///
  ///
  LocalVideoStateCallback? localVideoStateChanged;

  ///
  /// Occurs when the remote audio state changes.
  /// When the audio state of a remote user (in the voice/video call channel) or host (in the live streaming channel) changes, the SDK triggers this callback to report the current state of the remote audio stream.
  ///  This callback does not work properly when the number of users (in the voice/video call channel) or hosts (in the live streaming channel) in the channel exceeds 17.
  ///
  /// Param [uid] The ID of the remote user whose audio state changes.
  ///
  /// Param [state] The state of the remote audio, see AudioRemoteState .
  ///
  /// Param [reason] The reason of the remote audio state change, see AudioRemoteStateReason .
  ///
  /// Param [elapsed] Time elapsed (ms) from the local user calling the joinChannel method until the SDK triggers this callback.
  ///
  RemoteAudioStateCallback? remoteAudioStateChanged;

  ///
  /// Occurs when the local audio stream state changes.
  /// When the state of the local audio stream changes (including the state of the audio capture and encoding), the SDK triggers this callback to report the current state. This callback indicates the state of the local audio stream, and allows you to troubleshoot issues when audio exceptions occur.
  ///  When the state isFailed (3), you can view the error information in the error parameter.
  ///
  /// Param [state] The state of the local audio.
  ///
  /// Param [error] Local audio state error codes.
  ///
  LocalAudioStateCallback? localAudioStateChanged;

  /// @nodoc
  @Deprecated('Use requestAudioFileInfo instead')
  RequestAudioFileInfoCallback? requestAudioFileInfoCallback;

  ///
  /// Reports the information of an audio file.
  /// After successfully calling getAudioFileInfo , the SDK triggers this callback to report the information of the audio file, such as the file path and duration.
  ///
  /// Param [info] The information of an audio file. See AudioFileInfo .
  ///
  /// Param [error] The information acquisition state. See AudioFileInfoError .
  ///
  RequestAudioFileInfoCallback? requestAudioFileInfo;

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
  /// Param [uid] The user ID of the remote user.
  ///
  /// Param [isFallbackOrRecover] true: The remotely subscribed media stream falls back to audio-only due to poor network conditions.
  ///  false: The remotely subscribed media stream switches back to the video stream after the network conditions improved.
  ///
  FallbackWithUidCallback? remoteSubscribeFallbackToAudioOnly;

  ///
  /// Occurs when the local audio route changes.
  ///
  ///
  /// Param [routing] The current audio routing.
  ///
  ///
  AudioRouteCallback? audioRouteChanged;

  ///
  /// Occurs when the camera focus area changes.
  /// The SDK triggers this callback when the local user changes the camera focus position by calling setCameraFocusPositionInPreview .
  ///  This method is for Android and iOS only.
  ///
  /// Param [rect] The focus rectangle in the local preview.
  ///
  RectCallback? cameraFocusAreaChanged;

  ///
  /// Occurs when the camera exposure area changes.
  /// The SDK triggers this callback when the local user changes the camera exposure position by calling setCameraExposurePosition .
  ///  This method is for Android and iOS only.
  ///
  /// Param [rect] The focus rectangle in the local preview.
  ///
  RectCallback? cameraExposureAreaChanged;

  ///
  /// Reports the face detection result of the local user.
  /// Once you enable face detection by calling enableFaceDetection (true), you can get the following information on the local user in real-time:
  ///  The width and height of the local video.
  ///  The position of the human face in the local video.
  ///  The distance between the human face and the screen. The distance between the human face and the screen is based on the fitting calculation of the local video size and the position of the human face captured by the camera. If the SDK does not detect a face, it reduces the frequency of this callback to reduce power consumption on the local device.
  ///  The SDK stops triggering this callback when a human face is in close proximity to the screen.
  ///
  /// Param [imageWidth] The width (px) of the video image captured by the local camera.
  ///
  /// Param [imageHeight] The height (px) of the video image captured by the local camera.
  ///
  /// Param [faces] For the information of the detected face, see FacePositionInfo for details. If several faces are detected,
  ///  this callback reports several FacePositionInfo
  ///  arrays. The length of the array can be 0, which means that no human face is
  ///  detected in front of the camera.
  ///
  FacePositionCallback? facePositionChanged;

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
  /// Reports the last-mile network quality of the local user once every two seconds.
  /// This callback reports the last-mile network conditions of the local user before the user joins the channel. Last mile refers to the connection between the local device and Agora's edge server.
  ///  Before the user joins the channel, this callback is triggered by the SDK once startLastmileProbeTest is called and reports the last-mile network conditions of the local user.
  ///
  /// Param [quality] The last mile network quality.
  ///  Unknown (0): The quality is unknown.
  ///  Excellent (1): The quality is excellent.
  ///  Good (2): The network quality seems excellent, but the bitrate can be slightly lower than excellent.
  ///  Poor (3): Users can feel the communication is slightly impaired.
  ///  Bad (4): Users cannot communicate smoothly.
  ///  VBad (5): The quality is so bad that users can barely communicate.
  ///  Down (6): The network is down, and users cannot communicate at all.
  ///  See
  ///  NetworkQuality .
  ///
  NetworkQualityCallback? lastmileQuality;

  ///
  /// Reports the last mile network quality of each user in the channel.
  /// This callback reports the last mile network conditions of each user in the channel. Last mile refers to the connection between the local device and Agora's edge server.
  ///  The SDK triggers this callback once every two seconds. If a channel includes multiple users, the SDK triggers this callback as many times.
  ///
  /// Param [uid] User ID. The network quality of the user with this user ID is
  ///  reported.
  ///  If the uid is 0, the local network quality is reported.
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
  NetworkQualityWithUidCallback? networkQuality;

  ///
  /// Reports the last mile network probe result.
  /// The SDK triggers this callback within 30 seconds after the app calls startLastmileProbeTest .
  ///
  /// Param [result] The uplink and downlink last-mile network probe test result.
  ///
  LastmileProbeCallback? lastmileProbeResult;

  ///
  /// Reports the statistics of the local video stream.
  /// The SDK triggers this callback once every two seconds to report the statistics of the local video stream.
  ///
  /// Param [stats] The statistics of the local video stream.
  ///
  LocalVideoStatsCallback? localVideoStats;

  ///
  /// Reports the statistics of the local audio stream.
  /// The SDK triggers this callback once every two seconds.
  ///
  /// Param [stats] Local audio statistics.
  ///
  LocalAudioStatsCallback? localAudioStats;

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
  /// Occurs when the playback of the local music file finishes.
  /// Deprecated:
  ///  This method is deprecated as of v2.4.0. Use audioMixingStateChanged instead. After you call startAudioMixing to play a local music
  ///  file, this callback occurs when the playback finishes. If the call of startAudioMixing fails, the callback returns the error code
  ///  WARN_AUDIO_MIXING_OPEN_ERROR.
  ///
  @Deprecated(
      'This method is deprecated as of v2.4.0. Use audioMixingStateChanged instead.')
  EmptyCallback? audioMixingFinished;

  ///
  /// Occurs when the playback state of the music file changes.
  /// This callback occurs when the playback state of the music file changes, and reports the current state and error code.
  ///
  /// Param [state] The playback state of the music file.
  ///
  /// Param [reason] The reason why the playback state of the music file changes.
  ///
  AudioMixingStateCallback? audioMixingStateChanged;

  ///
  /// Occurs when the playback of the local audio effect file finishes.
  /// This callback occurs when the local audio effect file finishes playing.
  ///
  /// Param [soundId] The audio effect ID. The ID of each audio effect file is unique.
  ///
  SoundIdCallback? audioEffectFinished;

  ///
  /// Occurs when the media push state changes.
  /// When the media push state changes, the SDK triggers this callback to report the current state and the reason why the state has changed. When exceptions occur, you can troubleshoot issues by referring to the detailed error descriptions in the error code parameter.
  ///
  /// Param [url] The URL address where the state of the media push changes.
  ///
  /// Param [state] The current state of the media push. See RtmpStreamingState . When the streaming state is Failure (4), you can view the error information in the errorCode parameter.
  ///
  /// Param [errCode] The detailed error information for the media push. See RtmpStreamingErrorCode .
  ///
  RtmpStreamingStateCallback? rtmpStreamingStateChanged;

  ///
  /// Occurs when the publisher's transcoding is updated.
  /// When the LiveTranscoding class in the setLiveTranscoding method updates, the SDK triggers the transcodingUpdated callback to report the update information.
  ///  If you call the setLiveTranscoding
  ///  method to set the LiveTranscoding class for the first time, the
  ///  SDK does not trigger this callback.
  ///
  EmptyCallback? transcodingUpdated;

  ///
  /// Occurs when a media stream URL address is added to the interactive live streaming.
  /// Agora will soon stop the service for injecting online media streams on the client. If you have not implemented this service, Agora recommends that you do not use it.
  ///
  /// Param [url] The URL address of the externally injected stream.
  ///
  /// Param [uid] User ID.
  ///
  /// Param [status] State of the externally injected stream: InjectStreamStatus .
  ///
  StreamInjectedStatusCallback? streamInjectedStatus;

  ///
  /// Occurs when the local user receives the data stream from the remote user.
  /// The SDK triggers this callback when the local user receives the stream message that the remote user sends by calling the sendStreamMessage method.
  ///
  /// Param [uid] The ID of the remote user sending the message.
  ///
  /// Param [streamId] The stream ID of the received message.
  ///
  /// Param [data] The data received.
  ///
  StreamMessageCallback? streamMessage;

  ///
  /// Occurs when the local user does not receive the data stream from the remote user.
  /// The SDK triggers this callback when the local user fails to receive the stream message that the remote user sends by calling the sendStreamMessage method.
  ///
  /// Param [uid] The ID of the remote user sending the message.
  ///
  /// Param [streamId] The stream ID of the received message.
  ///
  /// Param [error] The error code.
  ///
  /// Param [missed] The number of lost messages.
  ///
  /// Param [cached] Number of incoming cached messages when the data stream is interrupted.
  ///
  StreamMessageErrorCallback? streamMessageError;

  ///
  /// Occurs when the media engine loads.
  ///
  ///
  EmptyCallback? mediaEngineLoadSuccess;

  ///
  /// Occurs when the media engine call starts.
  ///
  ///
  EmptyCallback? mediaEngineStartCallSuccess;

  ///
  /// Occurs when the state of the media stream relay changes.
  /// The SDK returns the state of the current media relay with any error message.
  ///
  /// Param [state]  The state code.
  ///
  /// Param [code]  The error code of the channel media
  ///  replay.
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
  ///  Occurs when the first remote video frame is rendered.
  /// The SDK triggers this callback when the first local video frame is displayed/rendered on the local video view. The application can retrieve the time elapsed (the elapsed parameter) from a user joining the channel until the first video frame is displayed.
  ///
  /// Param [uid] The user ID of the remote user sending the video stream.
  ///
  /// Param [width] The width (px) of the video stream.
  ///
  /// Param [height] The height (px) of the video stream.
  ///
  /// Param [elapsed] Time elapsed (ms) from the local user calling joinChannel until the SDK triggers this callback.
  ///
  @Deprecated('')
  VideoFrameWithUidCallback? firstRemoteVideoFrame;

  ///
  /// Occurs when the SDK receives the first audio frame from a specific remote user.
  /// Deprecated:
  ///  Please use remoteAudioStateChanged instead.
  ///
  /// Param [uid] The user ID of the remote user.
  ///
  /// Param [elapsed] The time elapsed (ms) from the local user calling joinChannel until the SDK triggers this callback.
  ///
  @Deprecated('Please use remoteAudioStateChanged instead.')
  UidWithElapsedCallback? firstRemoteAudioFrame;

  ///
  /// Occurs when the SDK decodes the first remote audio frame for playback.
  /// Deprecated:
  ///  Please use remoteAudioStateChanged instead. The SDK triggers this callback under one of the following circumstances:
  ///  The remote user joins the channel and sends the audio stream for the first time.
  ///  The remote user's audio is offline and then goes online to re-send audio. It means the local user cannot receive audio in 15 seconds. Reasons for such an interruption include:
  ///  The remote user leaves channel.
  ///  The remote user drops offline.
  ///  The remote user calls muteLocalAudioStream to stop sending the audio stream.
  ///  The remote user calls disableAudio to disable audio.
  ///
  /// Param [uid] The ID of the remote user.
  ///
  /// Param [elapsed] The time elapsed (ms) from the local user calling joinChannel until the SDK triggers this callback.
  ///
  @Deprecated('Please use remoteAudioStateChanged instead.')
  UidWithElapsedCallback? firstRemoteAudioDecoded;

  ///
  /// Occurs when a remote user (in the communication profile)/ host (in the live streaming profile) joins the channel.
  /// The SDK triggers this callback when the remote user stops or resumes sending the audio stream by calling the muteLocalAudioStream method.
  ///  This callback does not work properly when the number of users (in the communication profile) or hosts (in the live streaming profile) in the channel exceeds 17.
  ///
  /// Param [uid] User ID.
  ///
  /// Param [muted] Whether the remote user's audio stream is muted/unmuted:
  ///  true: Muted.
  ///  false: Unmuted.
  ///
  @Deprecated('')
  UidWithMutedCallback? userMuteAudio;

  ///
  /// Occurs when an RTMP or RTMPS stream is published.
  /// Deprecated:
  ///  Please use rtmpStreamingStateChanged instead. Reports the result of publishing an RTMP or RTMPS stream.
  ///
  /// Param [url] The CDN streaming URL.
  ///
  /// Param [error] Error codes of the RTMP or RTMPS streaming.
  ///  ERR_OK (0): The publishing succeeds.
  ///  ERR_FAILED (1): The publishing fails.
  ///  ERR_INVALID_ARGUMENT (-2): Invalid argument used.
  ///  If you do not call setLiveTranscoding to configure
  ///  LiveTranscoding before calling addPublishStreamUrl , the SDK reports
  ///  ERR_INVALID_ARGUMENT.
  ///  ERR_TIMEDOUT (10): The publishing timed out.
  ///  ERR_ALREADY_IN_USE (19): The chosen URL address is
  ///  already in use for CDN live streaming.
  ///  ERR_ENCRYPTED_STREAM_NOT_ALLOWED_PUBLISH (130): You
  ///  cannot publish an encrypted stream.
  ///  ERR_PUBLISH_STREAM_CDN_ERROR (151): CDN related
  ///  error. Remove the original URL address and add a new one by calling
  ///  the removePublishStreamUrl and addPublishStreamUrl methods.
  ///  ERR_PUBLISH_STREAM_NUM_REACH_LIMIT (152): The host
  ///  manipulates more than 10 URLs. Delete the unnecessary URLs before
  ///  adding new ones.
  ///  ERR_PUBLISH_STREAM_NOT_AUTHORIZED (153): The host
  ///  manipulates other hosts' URLs. Please check your app logic.
  ///  ERR_PUBLISH_STREAM_INTERNAL_SERVER_ERROR (154): An
  ///  error occurs in Agora's streaming server. Call the removePublishStreamUrl method to publish the streaming
  ///  again.
  ///  ERR_PUBLISH_STREAM_FORMAT_NOT_SUPPORTED (156): The
  ///  format of the CDN streaming URL is not supported. Check whether the
  ///  URL format is correct.
  ///
  @Deprecated('Please use rtmpStreamingStateChanged instead.')
  UrlWithErrorCallback? streamPublished;

  ///
  /// Occurs when the media push stops.
  /// Deprecated:
  ///  Please use rtmpStreamingStateChanged instead.
  ///
  /// Param [url] Removes an RTMP or RTMPS URL of the media push.
  ///
  @Deprecated('Please use rtmpStreamingStateChanged instead.')
  UrlCallback? streamUnpublished;

  ///
  /// Reports the transport-layer statistics of each remote audio stream.
  /// Deprecated:
  ///  Please use remoteAudioStats instead.
  ///  This callback reports the transport-layer statistics, such as the packet loss rate and network time delay, once every two seconds after the local user receives an audio packet from a remote user. During a call, when the user receives the audio packet sent by the remote user/host, the callback is triggered every 2 seconds.
  ///
  /// Param [uid] The ID of the remote user sending the audio streams.
  ///
  /// Param [delay] The network delay (ms) from the sender to the receiver.
  ///
  /// Param [lost] Packet loss rate (%) of the audio packet sent from the sender to the
  ///  receiver.
  ///
  /// Param [rxKBitrate] Bitrate of the received audio (Kbps).
  ///
  @Deprecated('Please use remoteAudioStats instead.')
  TransportStatsCallback? remoteAudioTransportStats;

  ///
  /// Reports the transport-layer statistics of each remote video stream.
  /// Deprecated:
  ///  Please use remoteVideoStats instead. This callback reports the transport-layer statistics, such as the packet loss rate and network time delay, once every two seconds after the local user receives a video packet from a remote user.
  ///  During a call, when the user receives the video packet sent by the remote user/host, the callback is triggered every 2 seconds.
  ///
  /// Param [uid] The ID of the remote user sending the video packets.
  ///
  /// Param [delay] The network delay (ms) from the sender to the receiver.
  ///
  /// Param [lost] The packet loss rate (%) of the video packet sent from the remote user.
  ///
  /// Param [rxKBitRate] The bitrate of the received video (Kbps).
  ///
  @Deprecated('Please use remoteVideoStats instead.')
  TransportStatsCallback? remoteVideoTransportStats;

  ///
  /// Occurs when a remote user enables/disables the video module.
  /// Once the video module is disabled, the user can only use a voice call. The user cannot send or receive any video.
  ///  The SDK triggers this callback when a remote user enables or disables the video module by calling the enableVideo or disableVideo method.
  ///
  /// Param [uid] The user ID of the remote user.
  ///
  /// Param [enabled] true: Enable.
  ///  false: Disable.
  ///
  @Deprecated('')
  UidWithEnabledCallback? userEnableVideo;

  ///
  /// Occurs when a specific remote user enables/disables the local video capturing function.
  /// The SDK triggers this callback when the remote user resumes or stops capturing the video stream by calling the enableLocalVideo method.
  ///
  /// Param [uid] The user ID of the remote user.
  ///
  /// Param [enabled] Whether the specified remote user enables/disables the local video
  ///  capturing function:
  ///  true: Enable. Other users in the
  ///  channel can see the video of this remote user.
  ///  false: Disable. Other users in the
  ///  channel can no longer receive the video stream from this remote
  ///  user, while this remote user can still receive the video streams
  ///  from other users.
  ///
  @Deprecated('')
  UidWithEnabledCallback? userEnableLocalVideo;

  ///
  /// Occurs when the first remote video frame is received and decoded.
  /// Deprecated:
  ///  Please use the remoteVideoStateChanged callback with the following parameters:
  ///  Starting (1).
  ///  Decoding (2). The SDK triggers this callback under one of the following circumstances:
  ///  The remote user joins the channel and sends the video stream.
  ///  The remote user stops sending the video stream and re-sends it after 15 seconds. Reasons for such an interruption include:
  ///  The remote user leaves the channel.
  ///  The remote user drops offline.
  ///  The remote user calls muteLocalVideoStream to stop sending the video stream.
  ///  The remote user calls disableVideo to disable video.
  ///
  /// Param [uid] The user ID of the remote user sending the video stream.
  ///
  /// Param [width] The width (px) of the video stream.
  ///
  /// Param [height] The height (px) of the video stream.
  ///
  /// Param [elapsed] The time elapsed (ms) from the local user calling joinChannel until the SDK triggers this callback.
  ///
  @Deprecated('')
  VideoFrameWithUidCallback? firstRemoteVideoDecoded;

  ///
  /// Occurs when the microphone is enabled/disabled.
  /// Deprecated: Please use the localAudioStateChanged callback:
  ///  Stopped(0).
  ///  Recording(1). The SDK triggers this callback when the local user enableLocalAudio resumes or stops capturing the local audio stream by calling the method.
  ///
  /// Param [enabled] Whether the microphone is enabled/disabled:
  ///  true: The microphone is enabled.
  ///  false: The microphone is disabled.
  ///
  @Deprecated('')
  EnabledCallback? microphoneEnabled;

  ///
  /// Occurs when the connection between the SDK and the server is interrupted.
  /// Deprecated:
  ///  Please use connectionStateChanged instead. The SDK triggers this callback when it loses connection with the server for more than four seconds after the connection is established. After triggering this callback, the SDK tries to reconnect to the server. You can use this callback to implement pop-up reminders. The difference between this callback and connectionLost is:
  ///  The SDK triggers the connectionInterrupted callback when it loses connection with the server for more than four seconds after it successfully joins the channel.
  ///  The SDK triggers the connectionLost callback when it loses connection with the server for more than 10 seconds, whether or not it joins the channel.
  ///  If the SDK fails to rejoin the channel 20 minutes after being disconnected from Agora's edge server, the SDK stops rejoining the channel.
  ///
  @Deprecated('Please use connectionStateChanged instead.')
  EmptyCallback? connectionInterrupted;

  ///
  /// Occurs when the connection is banned by the Agora server.
  /// Deprecated:
  ///  Please use connectionStateChanged instead.
  ///
  @Deprecated('Please use connectionStateChanged instead.')
  EmptyCallback? connectionBanned;

  ///
  /// Reports the statistics of the audio stream from each remote user.
  /// Deprecated:
  ///  Deprecated.Please use remoteAudioStats instead.
  ///  The SDK triggers this callback once every two seconds to report the audio quality of each remote user/host sending an audio stream. If a channel has multiple users/hosts sending audio streams, the SDK triggers this callback as many times.
  ///
  /// Param [uid] The user ID of the remote user sending the audio stream.
  ///
  /// Param [quality] Audio quality of the user.
  ///  Unknown (0): The quality is unknown.
  ///  Excellent (1): The quality is excellent.
  ///  Good (2): The network quality seems excellent, but the bitrate can be slightly lower than excellent.
  ///  Poor (3): Users can feel the communication is slightly impaired.
  ///  Bad (4): Users cannot communicate smoothly.
  ///  VBad (5): The quality is so bad that users can barely communicate.
  ///  Down (6): The network is down, and users cannot communicate at all.
  ///
  ///
  /// Param [delay] The network delay (ms) from the sender to the receiver, including the delay
  ///  caused by audio sampling pre-processing, network transmission, and network
  ///  jitter buffering.
  ///
  /// Param [lost] Packet loss rate (%) of the audio packet sent from the sender to the
  ///  receiver.
  ///
  @Deprecated('')
  AudioQualityCallback? audioQuality;

  ///
  /// Occurs when the camera turns on and is ready to capture the video.
  /// Deprecated: Please use Capturing(1) in localVideoStateChanged instead.
  ///  This callback indicates that the camera has been successfully turned on and
  ///  you can start to capture video.
  ///
  @Deprecated('')
  EmptyCallback? cameraReady;

  ///
  /// Occurs when the video stops playing.
  /// Deprecated:
  ///  Please use Stopped(0) in the localVideoStateChanged callback instead. The application can use this callback to change the configuration of the
  ///  view (for example, displaying other pictures in the view) after
  ///  the video stops playing.
  ///
  @Deprecated('')
  EmptyCallback? videoStopped;

  ///
  /// Occurs when the local user receives the metadata.
  ///
  ///
  /// Param [buffer]
  ///
  /// Param [uid] The user ID.
  ///
  /// Param [timeStampMs] The timestamp.
  ///
  MetadataCallback? metadataReceived;

  ///
  ///  Occurs when the first audio frame is published.
  /// The SDK triggers this callback under one of the following circumstances:
  ///  The local client enables the audio module and calls joinChannel successfully.
  ///  The local client calls muteLocalAudioStream (true) and muteLocalAudioStream(false) in sequence.
  ///  The local client calls disableAudio and enableAudio in sequence.
  ///
  /// Param [elapsed] The time elapsed (ms) from the local client calling joinChannel until the SDK triggers this callback.
  ///
  ElapsedCallback? firstLocalAudioFramePublished;

  ///
  /// Occurs when the first video frame is published.
  /// The SDK triggers this callback under one of the following circumstances:
  ///  The local client enables the video module and calls joinChannel successfully.
  ///  The local client calls muteLocalVideoStream (true) and muteLocalVideoStream(false) in sequence.
  ///  The local client calls disableVideo and enableVideo in sequence.
  ///
  /// Param [elapsed] The time elapsed(ms) from the local client calling joinChannel until the SDK triggers this callback.
  ///
  ElapsedCallback? firstLocalVideoFramePublished;

  ///
  /// Occurs when the audio publishing state changes.
  ///
  ///
  /// Param [channel] The name of the channel.
  ///
  /// Param [oldState] For the previous publishing state, see StreamPublishState .
  ///
  /// Param [newState] For the current publishing state, see StreamPublishState.
  ///
  /// Param [elapseSinceLastState] The time elapsed (ms) from the previous state to the current state.
  ///
  StreamPublishStateCallback? audioPublishStateChanged;

  ///
  /// Occurs when the video publishing state changes.
  ///
  ///
  /// Param [channel] The name of the channel.
  ///
  /// Param [oldState] For the previous publishing state, see StreamPublishState .
  ///
  /// Param [newState] For the current publishing state, see StreamPublishState.
  ///
  /// Param [elapseSinceLastState] The time elapsed (ms) from the previous state to the current state.
  ///
  StreamPublishStateCallback? videoPublishStateChanged;

  ///
  /// Occurs when the audio subscribing state changes.
  ///
  ///
  /// Param [channel] The name of the channel.
  ///
  /// Param [uid] The ID of the remote user.
  ///
  /// Param [oldState] The previous subscribing status, see StreamSubscribeState
  ///  for details.
  ///
  /// Param [newState] The current subscribing status, see StreamSubscribeState for details.
  ///
  /// Param [elapseSinceLastState] The time elapsed (ms) from the previous state to the current state.
  ///
  StreamSubscribeStateCallback? audioSubscribeStateChanged;

  ///
  /// Occurs when the video subscribing state changes.
  ///
  ///
  /// Param [channel] The name of the channel.
  ///
  /// Param [oldState] The previous subscribing status, see StreamSubscribeState
  ///  for details.
  ///
  /// Param [newState] The current subscribing status, see StreamSubscribeState for details.
  ///
  /// Param [elapseSinceLastState] The time elapsed (ms) from the previous state to the current state.
  ///
  StreamSubscribeStateCallback? videoSubscribeStateChanged;

  ///
  /// Reports events during the media push.
  ///
  ///
  /// Param [url] The URL for media push.
  ///
  /// Param [eventCode] The event code of media push. See RtmpStreamingEvent for details.
  ///
  RtmpStreamingEventCallback? rtmpStreamingEvent;

  ///
  /// Reports whether the super resolution feature is successfully enabled.
  /// After calling enableRemoteSuperResolution , the SDK triggers the callback to report whether super resolution is successfully enabled. If it is not successfully enabled, use reason for troubleshooting.
  ///
  /// Param [uid] The ID of the remote user.
  ///
  /// Param [enabled] Whether super resolution is successfully enabled:
  ///  true: Super resolution is successfully enabled.
  ///  false: Super resolution is not successfully enabled.
  ///
  ///
  /// Param [reason] The reason why super resolution algorithm is not successfully enabled.
  ///
  UserSuperResolutionEnabledCallback? userSuperResolutionEnabled;

  ///
  /// Reports the result of uploading the SDK log files.
  /// Since
  ///  v3.3.0 After uploadLogFile is called, the SDK triggers the callback to report the result of uploading the SDK log files. If the upload fails, refer to the reason parameter to troubleshoot.
  ///
  /// Param [requestId] The request ID. The request ID is the same as the requestId returned in uploadLogFile. You can use the requestId to match a specific upload with a callback.
  ///
  /// Param [success] Whether the log file is uploaded successfully:
  ///  true: Successfully upload the log files.
  ///  false: Fails to upload the log files.
  ///
  ///
  /// Param [reason] The reason for the upload failure.
  ///
  UploadLogResultCallback? uploadLogResult;

  /// @nodoc
  @Deprecated('Use airPlayConnected instead')
  EmptyCallback? airPlayIsConnected;

  ///
  /// Occurs when the audio route switches to Apple AirPlay (iOS and macOS only)。
  ///
  ///
  EmptyCallback? airPlayConnected;

  ///
  /// Reports whether virtual background is successfully enabled. (Beta feature)
  /// Since
  ///  v3.5.0 After you call enableVirtualBackground , the SDK triggers this callback to report whether virtual background is successfully enabled.
  ///  If the background image customized in the virtual background is in the PNG or JPG format, this callback is triggered after the image is read.
  ///
  /// Param [enabled] Whether virtual background is successfully enabled:
  ///  true: Virtual background is successfully enabled.
  ///  false: Virtual background is not successfully enabled.
  ///
  ///
  /// Param [reason] The reason why virtual background is not successfully enabled. See VirtualBackgroundSourceStateReason .
  ///
  VirtualBackgroundSourceEnabledCallback? virtualBackgroundSourceEnabled;

  ///
  /// Occurs when the video device state changes.
  /// This callback reports the change of system video devices, such as being unplugged or removed. On a Windows device with an external camera for video capturing, the video disables once the external camera is unplugged.
  ///
  /// Param [deviceId] The device ID.
  ///
  /// Param [deviceType] Media device types.
  ///
  /// Param [deviceState] Media device states.
  ///
  VideoDeviceStateChanged? videoDeviceStateChanged;

  ///
  /// Occurs when the volume on the playback or audio capture device, or the volume in the application changes.
  ///
  ///
  /// Param [deviceType] The device type.
  ///
  /// Param [volume] The volume value. The range is [0, 255].
  ///
  /// Param [muted] Whether the audio device is muted:
  ///  true: The audio device is muted.
  ///  false: The audio device is not muted.
  ///
  ///
  AudioDeviceVolumeChanged? audioDeviceVolumeChanged;

  ///
  /// Occurs when the audio device state changes.
  /// This callback notifies the application that the system's audio device state is changed. For example, a headset is unplugged from the device.
  ///  This method is for Windows and macOS only.
  ///
  /// Param [deviceId] The device ID.
  ///
  /// Param [deviceType] The device type.
  ///
  /// Param [deviceState] The device state.
  ///  on macOS:
  ///  0: The device is ready for use.
  ///  8: The device is not connected. On Windows: MediaDeviceStateType .
  ///
  ///
  AudioDeviceStateChanged? audioDeviceStateChanged;

  ///
  /// Occurs when a remote user starts audio mixing.
  /// When a remote user calls startAudioMixing to play the background music, the SDK reports this callback.
  ///
  EmptyCallback? remoteAudioMixingBegin;

  ///
  /// Occurs when a remote user finishes audio mixing.
  /// The SDK triggers this callback when a remote user finishes audio mixing.
  ///
  EmptyCallback? remoteAudioMixingEnd;

  ///
  /// Reports the result of taking a video snapshot.
  /// After a successful takeSnapshot method call, the SDK triggers this callback to report whether the snapshot is successfully taken as well as the details for the snapshot taken.
  ///
  /// Param [channel] The channel name.
  ///
  /// Param [uid] The user ID. A uid of 0 indicates the local user.
  ///
  /// Param [filePath] The local path of the snapshot.
  ///
  /// Param [width] The width (px) of the snapshot.
  ///
  /// Param [height] The height (px) of the snapshot.
  ///
  /// Param [errCode] The message that confirms success or the reason why the snapshot is not successfully taken:
  ///  0: Success.
  ///  < 0: Failure:
  ///  -1: The SDK fails to write data to a file or encode a JPEG image.
  ///  -2: The SDK does not find the video stream of the specified user within one second after the takeSnapshot method call succeeds.
  ///
  SnapshotTakenCallback? snapshotTaken;

  ///
  /// Occurs when the screen sharing information is updated.
  /// When you call startScreenCaptureByDisplayId or startScreenCaptureByScreenRect to start screen sharing and use the excludeWindowList attribute to block the specified window, the SDK triggers this callback if the window blocking fails.
  ///  This callback is for Windows only.
  ///
  /// Param [info] Screen sharing information. See ScreenCaptureInfo .
  ///
  OnScreenCaptureInfoUpdated? screenCaptureInfoUpdated;

  /// @nodoc
  OnClientRoleChangeFailed? clientRoleChangeFailed;

  /// @nodoc
  OnWlAccMessage? wlAccMessage;

  /// @nodoc
  OnWlAccStats? wlAccStats;

  ///
  /// Reports the proxy connection state.
  /// You can use this callback to listen for the state of the SDK connecting to a proxy. For example, when a user calls setCloudProxy and joins a channel successfully, the SDK triggers this callback to report the user ID, the proxy type connected, and the time elapsed from the user calling until this callback is triggered.
  ///
  /// Param [channel] The channel name.
  ///
  /// Param [uid] The user ID.
  ///
  /// Param [proxyType] The proxy type connected. See ProxyType .
  ///
  /// Param [localProxyIp] Reserved for future use.
  ///
  /// Param [elapsed] The time elapsed (ms) from the user calling until this callback is triggered.
  ///
  OnProxyConnected? proxyConnected;

  ///
  /// Reports the result of an audio device test.
  /// After successfully calling startAudioRecordingDeviceTest , startAudioPlaybackDeviceTest , or startAudioDeviceLoopbackTest to start an audio device test, the SDK triggers the audioDeviceTestVolumeIndication callback at the set time interval to report the volume information of the audio device tested.
  ///
  /// Param [volumeType] Volume type See AudioDeviceTestVolumeType .
  ///
  ///
  /// Param [volume] Volume level in the range [0,255].
  ///
  ///
  OnAudioDeviceTestVolumeIndication? audioDeviceTestVolumeIndication;

  /// @nodoc
  OnContentInspectResult? contentInspectResult;

  /// @nodoc
  RtcEngineEventHandler({
    this.warning,
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
    this.requestAudioFileInfoCallback,
    this.requestAudioFileInfo,
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
    this.metadataReceived,
    this.firstLocalAudioFramePublished,
    this.firstLocalVideoFramePublished,
    this.audioPublishStateChanged,
    this.videoPublishStateChanged,
    this.audioSubscribeStateChanged,
    this.videoSubscribeStateChanged,
    this.rtmpStreamingEvent,
    this.userSuperResolutionEnabled,
    this.uploadLogResult,
    this.airPlayIsConnected,
    this.airPlayConnected,
    this.virtualBackgroundSourceEnabled,
    this.videoDeviceStateChanged,
    this.audioDeviceVolumeChanged,
    this.audioDeviceStateChanged,
    this.remoteAudioMixingBegin,
    this.remoteAudioMixingEnd,
    this.snapshotTaken,
    this.screenCaptureInfoUpdated,
    this.clientRoleChangeFailed,
    this.wlAccMessage,
    this.wlAccStats,
    this.proxyConnected,
    this.audioDeviceTestVolumeIndication,
    this.contentInspectResult,
  });
}
