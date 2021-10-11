import 'classes.dart';
import 'enum_converter.dart';
import 'enums.dart';

// ignore: public_member_api_docs
typedef EmptyCallback = void Function();
// ignore: public_member_api_docs
typedef WarningCallback = void Function(WarningCode warn);
// ignore: public_member_api_docs
typedef ErrorCallback = void Function(ErrorCode err);
// ignore: public_member_api_docs
typedef ApiCallCallback = void Function(
    ErrorCode error, String api, String result);
// ignore: public_member_api_docs
typedef UidWithElapsedAndChannelCallback = void Function(
    String channel, int uid, int elapsed);
// ignore: public_member_api_docs
typedef RtcStatsCallback = void Function(RtcStats stats);
// ignore: public_member_api_docs
typedef UserAccountCallback = void Function(int uid, String userAccount);
// ignore: public_member_api_docs
typedef UserInfoCallback = void Function(int uid, UserInfo userInfo);
// ignore: public_member_api_docs
typedef ClientRoleCallback = void Function(
    ClientRole oldRole, ClientRole newRole);
// ignore: public_member_api_docs
typedef UidWithElapsedCallback = void Function(int uid, int elapsed);
// ignore: public_member_api_docs
typedef UserOfflineCallback = void Function(int uid, UserOfflineReason reason);
// ignore: public_member_api_docs
typedef ConnectionStateCallback = void Function(
    ConnectionStateType state, ConnectionChangedReason reason);
// ignore: public_member_api_docs
typedef NetworkTypeCallback = void Function(NetworkType type);
// ignore: public_member_api_docs
typedef TokenCallback = void Function(String token);
// ignore: public_member_api_docs
typedef AudioVolumeCallback = void Function(
    List<AudioVolumeInfo> speakers, int totalVolume);
// ignore: public_member_api_docs
typedef UidCallback = void Function(int uid);
// ignore: public_member_api_docs
typedef ElapsedCallback = void Function(int elapsed);
// ignore: public_member_api_docs
typedef VideoFrameCallback = void Function(int width, int height, int elapsed);
// ignore: public_member_api_docs
typedef UidWithMutedCallback = void Function(int uid, bool muted);
// ignore: public_member_api_docs
typedef VideoSizeCallback = void Function(
    int uid, int width, int height, int rotation);
// ignore: public_member_api_docs
typedef RemoteVideoStateCallback = void Function(int uid,
    VideoRemoteState state, VideoRemoteStateReason reason, int elapsed);
// ignore: public_member_api_docs
typedef LocalVideoStateCallback = void Function(
    LocalVideoStreamState localVideoState, LocalVideoStreamError error);
// ignore: public_member_api_docs
typedef RemoteAudioStateCallback = void Function(int uid,
    AudioRemoteState state, AudioRemoteStateReason reason, int elapsed);
// ignore: public_member_api_docs
typedef LocalAudioStateCallback = void Function(
    AudioLocalState state, AudioLocalError error);
// ignore: public_member_api_docs
typedef FallbackCallback = void Function(bool isFallbackOrRecover);
// ignore: public_member_api_docs
typedef FallbackWithUidCallback = void Function(
    int uid, bool isFallbackOrRecover);
// ignore: public_member_api_docs
typedef AudioRouteCallback = void Function(AudioOutputRouting routing);
// ignore: public_member_api_docs
typedef RectCallback = void Function(Rect rect);
// ignore: public_member_api_docs
typedef NetworkQualityCallback = void Function(NetworkQuality quality);
// ignore: public_member_api_docs
typedef NetworkQualityWithUidCallback = void Function(
    int uid, NetworkQuality txQuality, NetworkQuality rxQuality);
// ignore: public_member_api_docs
typedef LastmileProbeCallback = void Function(LastmileProbeResult result);
// ignore: public_member_api_docs
typedef LocalVideoStatsCallback = void Function(LocalVideoStats stats);
// ignore: public_member_api_docs
typedef LocalAudioStatsCallback = void Function(LocalAudioStats stats);
// ignore: public_member_api_docs
typedef RemoteVideoStatsCallback = void Function(RemoteVideoStats stats);
// ignore: public_member_api_docs
typedef RemoteAudioStatsCallback = void Function(RemoteAudioStats stats);
// ignore: public_member_api_docs
typedef AudioMixingStateCallback = void Function(
    AudioMixingStateCode state, AudioMixingReason reason);
// ignore: public_member_api_docs
typedef SoundIdCallback = void Function(int soundId);
// ignore: public_member_api_docs
typedef RtmpStreamingStateCallback = void Function(
    String url, RtmpStreamingState state, RtmpStreamingErrorCode errCode);
// ignore: public_member_api_docs
typedef StreamInjectedStatusCallback = void Function(
    String url, int uid, InjectStreamStatus status);
// ignore: public_member_api_docs
typedef StreamMessageCallback = void Function(
    int uid, int streamId, String data);
// ignore: public_member_api_docs
typedef StreamMessageErrorCallback = void Function(
    int uid, int streamId, ErrorCode error, int missed, int cached);
// ignore: public_member_api_docs
typedef MediaRelayStateCallback = void Function(
    ChannelMediaRelayState state, ChannelMediaRelayError code);
// ignore: public_member_api_docs
typedef MediaRelayEventCallback = void Function(ChannelMediaRelayEvent code);
// ignore: public_member_api_docs
typedef VideoFrameWithUidCallback = void Function(
    int uid, int width, int height, int elapsed);
// ignore: public_member_api_docs
typedef UrlWithErrorCallback = void Function(String url, ErrorCode error);
// ignore: public_member_api_docs
typedef UrlCallback = void Function(String url);
// ignore: public_member_api_docs
typedef TransportStatsCallback = void Function(
    int uid, int delay, int lost, int rxKBitRate);
// ignore: public_member_api_docs
typedef UidWithEnabledCallback = void Function(int uid, bool enabled);
// ignore: public_member_api_docs
typedef EnabledCallback = void Function(bool enabled);
// ignore: public_member_api_docs
typedef AudioQualityCallback = void Function(
    int uid, int quality, int delay, int lost);
// ignore: public_member_api_docs
typedef MetadataCallback = void Function(
    String buffer, int uid, int timeStampMs);
// ignore: public_member_api_docs
typedef FacePositionCallback = void Function(
    int imageWidth, int imageHeight, List<FacePositionInfo> faces);
// ignore: public_member_api_docs
typedef StreamPublishStateCallback = void Function(
    String channel,
    StreamPublishState oldState,
    StreamPublishState newState,
    int elapseSinceLastState);
// ignore: public_member_api_docs
typedef StreamSubscribeStateCallback = void Function(
    String channel,
    int uid,
    StreamSubscribeState oldState,
    StreamSubscribeState newState,
    int elapseSinceLastState);
// ignore: public_member_api_docs
typedef RtmpStreamingEventCallback = void Function(
    String url, RtmpStreamingEvent eventCode);
// ignore: public_member_api_docs
typedef UserSuperResolutionEnabledCallback = void Function(
    int uid, bool enabled, SuperResolutionStateReason reason);
// ignore: public_member_api_docs
typedef UploadLogResultCallback = void Function(
    String requestId, bool success, UploadErrorReason reason);
// ignore: public_member_api_docs
typedef ContentInspectResultCallback = void Function(
    ContentInspectResult result);
// ignore: public_member_api_docs
typedef SnapshotTakenCallback = void Function(String channel, int uid,
    String filePath, int width, int height, int errCode);

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
  ///
  /// The `WarningCallback` typedef includes the following parameter:
  /// - [WarningCode] `warn`: Warning code.
  WarningCallback? warning;

  /// Reports an error during SDK runtime.
  ///
  /// In most cases, the SDK cannot fix the issue and resume running. The SDK requires the app to take action or informs the user about the issue.
  ///
  /// For example, the SDK reports an [ErrorCode.StartCall] error when failing to initialize a call. The app informs the user that the call initialization failed and invokes the [RtcEngine.leaveChannel] method to leave the channel. For detailed error codes, see [ErrorCode].
  ///
  /// The `ErrorCallback` typedef includes the following parameter:
  /// - [ErrorCode] `err`: Error code.
  ErrorCallback? error;

  /// Occurs when an API method is executed.
  ///
  /// The `ApiCallCallback` typedef includes the following parameters:
  /// - [ErrorCode] `error`: Error code.
  /// - [String] `api`: The method executed by the SDK.
  /// - [String] `result`: The result of the method call.
  ApiCallCallback? apiCallExecuted;

  /// Occurs when the local user joins a specified channel.
  ///
  /// The channel name assignment is based on channelName specified in the [RtcEngine.joinChannel] method.
  ///
  /// If the uid is not specified when [RtcEngine.joinChannel] is called, the server automatically assigns a uid.
  ///
  /// The `UidWithElapsedAndChannelCallback` typedef includes the following parameters:
  /// - [String] `channel`: Channel name.
  /// - [int] `uid`: User ID.
  /// - [int] `elapsed`:Time elapsed (ms) from the user calling [RtcEngine.joinChannel] until this callback is triggered.
  UidWithElapsedAndChannelCallback? joinChannelSuccess;

  /// Occurs when a user rejoins the channel after being disconnected due to network problems.
  ///
  /// When a user loses connection with the server because of network problems, the SDK automatically tries to reconnect and triggers this callback upon reconnection.
  ///
  /// The `UidWithElapsedAndChannelCallback` typedef includes the following parameters:
  /// - [String] `channel`: Channel name.
  /// - [int] `uid`: User ID.
  /// - [int] `elapsed`:Time elapsed (ms) from the user calling [RtcEngine.joinChannel] until this callback is triggered.
  UidWithElapsedAndChannelCallback? rejoinChannelSuccess;

  /// Occurs when a user leaves the channel.
  ///
  /// When the app calls the [RtcEngine.leaveChannel] method, the SDK uses this callback to notify the app when the user leaves the channel.
  ///
  /// With this callback, the application retrieves the channel information, such as the call duration and statistics.
  ///
  /// The `RtcStatsCallback` typedef includes the following parameter:
  /// - [RtcStats] `stats`: Statistics of the call.
  RtcStatsCallback? leaveChannel;

  /// Occurs when the local user registers a user account.
  ///
  /// This callback is triggered when the local user successfully registers a user account by calling the [RtcEngine.registerLocalUserAccount] method, or joins a channel by calling the [RtcEngine.joinChannelWithUserAccount] method. This callback reports the user ID and user account of the local user.
  ///
  /// The `UserAccountCallback` typedef includes the following parameters:
  /// - [int] `uid`: The ID of the local user.
  /// - [String] `userAccount`: The account of the local user.
  UserAccountCallback? localUserRegistered;

  /// Occurs when the SDK gets the user ID and user account of the remote user.
  ///
  /// After a remote user joins the channel, the SDK gets the UID and user account of the remote user, caches them in a mapping table object ([UserInfo]), and triggers this callback on the local client.
  ///
  /// The `UserInfoCallback` typedef includes the following parameters:
  /// - [int] `uid`: The ID of the local user.
  /// - [UserInfo] `userInfo`: The `UserInfo` object that contains the user ID and user account of the remote user.
  UserInfoCallback? userInfoUpdated;

  /// Occurs when the user role switches in a live broadcast. For example, from a host to an audience or from an audience to a host.
  ///
  /// The SDK triggers this callback when the local user switches the user role by calling the [RtcEngine.setClientRole] method after joining the channel.
  ///
  /// The `ClientRoleCallback` typedef includes the following parameters:
  /// - [ClientRole] `oldRole`: Role that the user switches from.
  /// - [ClientRole] `newRole`: Role that the user switches to.
  ClientRoleCallback? clientRoleChanged;

  /// Occurs when a remote user ([ChannelProfile.Communication])/host ([ChannelProfile.LiveBroadcasting]) joins the channel.
  /// - [ChannelProfile.Communication] profile: This callback notifies the app when another user joins the channel. If other users are already in the channel, the SDK also reports to the app on the existing users.
  /// - [ChannelProfile.LiveBroadcasting] profile: This callback notifies the app when the host joins the channel. If other hosts are already in the channel, the SDK also reports to the app on the existing hosts. We recommend having at most 17 hosts in a channel.
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
  ///
  /// The `UidWithElapsedCallback` typedef includes the following parameters:
  /// - [int] `uid`: This parameter has the following definitions in different events:
  ///   - [userJoined]: ID of the user or host who joins the channel.
  ///   - [firstRemoteAudioFrame]: User ID of the remote user.
  ///   - [firstRemoteAudioDecoded]: User ID of the remote user sending the audio stream.
  ///   - [joinChannelSuccess]: User ID.
  ///   - [rejoinChannelSuccess]: User ID.
  /// - [int] `elapsed`:
  ///   - [userJoined]: Time delay (ms) from the local user calling [RtcEngine.joinChannel] or [RtcEngine.setClientRole] until this callback is triggered.
  ///   - [firstRemoteAudioFrame]: Time elapsed (ms) from the local user calling [RtcEngine.joinChannel] until this callback is triggered.
  ///   - [firstRemoteAudioDecoded]: Time elapsed (ms) from the local user calling [RtcEngine.joinChannel] until the SDK triggers this callback.
  ///   - [joinChannelSuccess]: Time elapsed (ms) from the local user calling [RtcChannel.joinChannel] until this callback is triggered.
  ///   - [rejoinChannelSuccess]: Time elapsed (ms) from the local user starting to reconnect until this callback is triggered.
  UidWithElapsedCallback? userJoined;

  /// Occurs when a remote user ([ChannelProfile.Communication])/host ([ChannelProfile.LiveBroadcasting]) leaves the channel.
  ///
  /// There are two reasons for users to become offline:
  /// - Leave the channel: When the user/host leaves the channel, the user/host sends a goodbye message. When this message is received, the SDK determines that the user/host leaves the channel.
  /// - Drop offline: When no data packet of the user or host is received for a certain period of time (20 seconds for the [ChannelProfile.Communication] profile, and more for the [ChannelProfile.LiveBroadcasting] profile), the SDK assumes that the user/host drops offline. A poor network connection may lead to false detections, so we recommend using the Agora RTM SDK for reliable offline detection.
  ///
  /// The `UserOfflineCallback` typedef includes the following parameters:
  /// - [int] `uid`: ID of the user or host who leaves the channel or goes offline.
  /// - [UserOfflineReason] `reason`: Reason why the user goes offline.
  UserOfflineCallback? userOffline;

  /// Occurs when the network connection state changes.
  ///
  /// The Agora SDK returns this callback to report on the current network connection state when it changes, and the reason to such change.
  ///
  /// The `ConnectionStateCallback` typedef includes the following parameters:
  /// - [ConnectionStateType] `state`: The current network connection state.
  /// - [ConnectionChangedReason] `reason`: The reason causing the change of the connection state.
  ConnectionStateCallback? connectionStateChanged;

  /// Occurs when the network type changes.
  ///
  /// The SDK returns the current network type in this callback. When the network connection is interrupted, this callback indicates whether the interruption is caused by a network type change or poor network conditions.
  ///
  /// The `NetworkTypeCallback` typedef includes the following parameters:
  /// - [NetworkType] `type`: The network type.
  NetworkTypeCallback? networkTypeChanged;

  /// Occurs when the SDK cannot reconnect to Agora's edge server 10 seconds after its connection to the server is interrupted.
  ///
  /// The SDK triggers this callback when it cannot connect to the server 10 seconds after calling [RtcEngine.joinChannel], regardless of whether it is in the channel or not.
  /// If the SDK fails to rejoin the channel 20 minutes after being disconnected from Agora's edge server, the SDK stops rejoining the channel.
  ///
  /// The `EmptyCallback` typedef does not include any parameter.
  EmptyCallback? connectionLost;

  /// Occurs when the token expires in 30 seconds.
  ///
  /// The user becomes offline if the token used when joining the channel expires. This callback is triggered 30 seconds before the token expires to remind the app to get a new token. Upon receiving this callback, you need to generate a new token on the server and call [RtcEngine.renewToken] to pass the new token to the SDK.
  ///
  /// The `TokenCallback` typedef includes the following parameters:
  /// - [String] `token`: The token that will expire in 30 seconds.
  TokenCallback? tokenPrivilegeWillExpire;

  /// Occurs when the token has expired.
  ///
  /// After a token is specified when joining the channel, the token expires after a certain period of time, and a new token is required to reconnect to the server. This callback notifies the app to generate a new token and call [RtcEngine.joinChannel] to rejoin the channel with the new token.
  ///
  /// The `EmptyCallback` typedef does not include any parameter.
  EmptyCallback? requestToken;

  /// Reports which users are speaking and the speakers' volume, and whether the local user is speaking.
  ///
  /// This callback reports the IDs and volumes of the loudest speakers (at most 3) at the moment in the channel, and whether the local user is speaking.
  /// By default, this callback is disabled. You can enable it by calling the [RtcEngine.enableAudioVolumeIndication] method. Once enabled, this callback is triggered at the set interval, regardless of whether a user speaks or not.
  /// The SDK triggers two independent [audioVolumeIndication] callbacks at one time, which separately report the volume information of the local user and all the remote speakers. For more information, see the detailed parameter descriptions.
  ///
  /// **Note**
  /// - To enable the voice activity detection of the local user, ensure that you set `report_vad`(true) in the [RtcEngine.enableAudioVolumeIndication] method.
  /// - Calling the [RtcEngine.muteLocalAudioStream] method affects the SDK's behavior.
  /// -- If the local user calls the [RtcEngine.muteLocalAudioStream] method, the SDK stops triggering the local user's callback.
  /// -- 20 seconds after a remote speaker calls the [RtcEngine.muteLocalAudioStream] method, the remote speakers' callback does not include information of this remote user; 20 seconds after all remote users call the the [RtcEngine.muteLocalAudioStream] method, the SDK stops triggering the remote speakers' callback.
  ///
  /// The `AudioVolumeCallback` typedef includes the following parameters:
  /// - [List]<[AudioVolumeInfo]> `speakers`: An array containing the user ID and volume information for each speaker.
  /// - [int] `totalVolume`: Total volume after audio mixing. The value ranges between 0 (lowest volume) and 255 (highest volume).
  AudioVolumeCallback? audioVolumeIndication;

  /// Reports which user is the loudest speaker.
  ///
  /// This callback reports the speaker with the highest accumulative volume during a certain period. If the user enables the audio volume indication by calling [RtcEngine.enableAudioVolumeIndication], this callback returns the uid of the active speaker whose voice is detected by the audio volume detection module of the SDK.
  ///
  /// **Note**
  /// - To receive this callback, you need to call [RtcEngine.enableAudioVolumeIndication].
  /// - This callback returns the user ID of the user with the highest voice volume during a period of time, instead of at the moment.
  ///
  /// The `UidCallback` typedef includes the following parameters:
  /// - [int] `uid`: User ID of the active speaker. A `uid` of 0 represents the local user.
  UidCallback? activeSpeaker;

  /// Occurs when the first local audio frame is sent.
  ///
  /// The `ElapsedCallback` typedef includes the following parameters:
  /// - [int] `Elapsed`: Time elapsed (ms) from the local user calling the [RtcEngine.joinChannel] until this callback is triggered.
  @deprecated
  ElapsedCallback? firstLocalAudioFrame;

  /// Occurs when the first local video frame is rendered.
  ///
  /// This callback is triggered after the first local video frame is rendered on the local video window.
  ///
  /// The `VideoFrameCallback` typedef includes the following parameters:
  /// - [int] `width`: Width (pixels) of the first local video frame.
  /// - [int] `height`: Height (pixels) of the first local video frame.
  /// - [int] `elapsed`: Time elapsed (ms) from the local user calling [RtcEngine.joinChannel] until this callback is triggered. If [RtcEngine.startPreview] is called before [RtcEngine.joinChannel], elapsed is the time elapsed (ms) from the local user calling [RtcEngine.startPreview] until this callback is triggered.
  VideoFrameCallback? firstLocalVideoFrame;

  /// Occurs when a remote user stops/resumes sending the video stream.
  ///
  /// **Deprecated** This callback is deprecated. Use the [RtcEngineEventHandler.remoteVideoStateChanged] callback with the following parameters for the same function:
  /// - [VideoRemoteState.Stopped] and [VideoRemoteStateReason.RemoteMuted].
  /// - [VideoRemoteState.Decoding] and [VideoRemoteStateReason.RemoteUnmuted].
  ///
  /// The SDK triggers this callback when the remote user stops or resumes sending the video stream by calling the [RtcEngine.muteLocalVideoStream] method.
  ///
  /// **Note**
  /// - This callback is invalid when the number of users or broadcasters in the channel exceeds 17.
  ///
  /// The `UidWithMutedCallback` typedef includes the following parameters:
  /// - [int] `uid`: ID of the remote user.
  /// - [bool] `muted`: Whether the remote user's video stream playback pauses/resumes:
  ///    - `true`: Pause.
  ///    - `false`: Resume.
  @deprecated
  UidWithMutedCallback? userMuteVideo;

  /// Occurs when the video size or rotation information of a remote user changes.
  ///
  /// The `VideoSizeCallback` typedef includes the following parameters:
  /// - [int] `uid`: User ID of the remote user or local user (0) whose video size or rotation changes.
  /// - [int] `width`: New width (pixels) of the video.
  /// - [int] `height`: New height (pixels) of the video.
  /// - [int] `rotation`: New rotation of the video [0 to 360).
  VideoSizeCallback? videoSizeChanged;

  /// Occurs when the remote video state changes.
  ///
  /// The `RemoteVideoStateCallback` typedef includes the following parameters:
  /// - [int] `uid`: ID of the remote user whose video state changes.
  /// - [VideoRemoteState] `state`: State of the remote video.
  /// - [VideoRemoteStateReason] `reason`: The reason of the remote video state change.
  /// - [int] `elapsed`: Time elapsed (ms) from the local user calling [RtcEngine.joinChannel] until the SDK triggers this callback.
  RemoteVideoStateCallback? remoteVideoStateChanged;

  /// Occurs when the local video state changes.
  ///
  /// The SDK returns the current video state in this callback. When the state is [LocalVideoStreamState.Failed], see the error parameter for details.
  ///
  /// **Note**
  /// - This callback reports the current state of the local video, which keeps changing throughout the RtcEngine life cycle. We recommend maintaining the states reported in this callback, and check the local video state before starting the local camera. If the SDK reports [LocalVideoStreamError.CaptureFailure], the local camera is occupied by either the system or a third-party app. To access the camera, call [RtcEngine.enableLocalVideo] (`false`) first, and then [RtcEngine.enableLocalVideo] (`true`).
  ///
  /// The `LocalVideoStateCallback` typedef includes the following parameters:
  /// - [LocalVideoStreamState] `localVideoState`: The local video state.
  /// - [LocalVideoStreamError] `error`: The detailed error information of the local video.
  LocalVideoStateCallback? localVideoStateChanged;

  /// Occurs when the remote audio state changes.
  ///
  /// This callback indicates the state change of the remote audio stream.
  ///
  /// The `RemoteAudioStateCallback` typedef includes the following parameters:
  /// - [int] `uid`: ID of the user whose audio state changes.
  /// - [AudioRemoteState] `state`: State of the remote audio.
  /// - [AudioRemoteStateReason] `reason`: The reason of the remote audio state change.
  /// - [int] `elapsed`: Time elapsed (ms) from the local user calling [RtcEngine.joinChannel] until the SDK triggers this callback.
  RemoteAudioStateCallback? remoteAudioStateChanged;

  /// Occurs when the local audio stream state changes.
  ///
  /// This callback indicates the state change of the local audio stream, including the state of the audio recording and encoding, and allows you to troubleshoot issues when exceptions occur.
  ///
  /// **Note**
  /// - When the state is [AudioLocalState.Failed], see the error parameter for details.
  ///
  /// The `LocalAudioStateCallback` typedef includes the following parameters:
  /// - [AudioLocalState] `state`: State of the local audio.
  /// - [AudioLocalError] `error`: The error information of the local audio.
  LocalAudioStateCallback? localAudioStateChanged;

  /// Occurs when the published media stream falls back to an audio-only stream due to poor network conditions or switches back to video stream after the network conditions improve.
  ///
  /// If you call [RtcEngine.setLocalPublishFallbackOption] and set option as [StreamFallbackOptions.AudioOnly], this callback is triggered when the locally published stream falls back to audio-only mode due to poor uplink conditions, or when the audio stream switches back to the video after the uplink network condition improves.
  ///
  /// The `FallbackCallback` typedef includes the following parameters:
  /// - [bool] `isFallbackOrRecover`: Whether the published stream fell back to audio-only or switched back to the video:
  /// -- `true`: The published stream fell back to audio-only due to poor network conditions.
  /// -- `false`: The published stream switched back to the video after the network conditions improved.
  FallbackCallback? localPublishFallbackToAudioOnly;

  /// Occurs when the remote media stream falls back to audio-only stream due to poor network conditions or switches back to video stream after the network conditions improve.
  ///
  /// If you call [RtcEngine.setRemoteSubscribeFallbackOption] and set option as [StreamFallbackOptions.AudioOnly], this callback is triggered when the remotely subscribed media stream falls back to audio-only mode due to poor uplink conditions, or when the remotely subscribed media stream switches back to the video after the uplink network condition improves.
  ///
  /// The `FallbackWithUidCallback` typedef includes the following parameters:
  /// - [int] `uid`: ID of the remote user sending the stream.
  /// - [bool] `isFallbackOrRecover`: Whether the published stream fell back to audio-only or switched back to the video:
  /// -- `true`: The published stream fell back to audio-only due to poor network conditions.
  /// -- `false`: The published stream switched back to the video after the network conditions improved.
  FallbackWithUidCallback? remoteSubscribeFallbackToAudioOnly;

  /// Occurs when the local audio playback route changes.
  ///
  /// This callback returns that the audio route switched to an earpiece, speakerphone, headset, or Bluetooth device.
  ///
  /// See [AudioOutputRouting] for the definition of the routing.
  ///
  /// The `AudioRouteCallback` typedef includes the following parameter:
  /// - [AudioOutputRouting] `routing`: Audio output routing.
  AudioRouteCallback? audioRouteChanged;

  /// Occurs when the camera focus area is changed.
  ///
  /// The SDK triggers this callback when the local user changes the camera focus position by calling the [RtcEngine.setCameraFocusPositionInPreview] method.
  ///
  /// The `RectCallback` typedef includes the following parameter:
  /// - [Rect] `rect`: Rectangular area in the camera zoom specifying the focus area.
  RectCallback? cameraFocusAreaChanged;

  /// The camera exposure area has changed.
  ///
  /// The SDK triggers this callback when the local user changes the camera exposure position by calling the [RtcEngine.setCameraExposurePosition] method.
  ///
  /// The `RectCallback` typedef includes the following parameter:
  /// - [Rect] `rect`: Rectangular area in the camera zoom specifying the focus area.
  RectCallback? cameraExposureAreaChanged;

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
  ///
  /// `The FacePositionCallback` typedef includes the following parameters:
  /// - [int] `imageWidth`: The width (px) of the local video.
  /// - [int] `imageHeight`: The height (px) of the local video.
  /// - [List]<[FacePositionInfo]> `faces`: The information of the detected human face. For details, see [FacePositionInfo]. The number of the `FacePositionInfo` array depends on the number of human faces detected. If the array length is 0, it means that no human face is detected.
  FacePositionCallback? facePositionChanged;

  /// Reports the statistics of the [RtcEngine] once every two seconds.
  ///
  /// The `RtcStatsCallback` typedef includes the following parameter:
  /// - [RtcStats] `stats`: Statistics of the call.
  RtcStatsCallback? rtcStats;

  /// Reports the last mile network quality of the local user once every two seconds before the user joins the channel. Last mile refers to the connection between the local device and Agora's edge server. After the application calls the [RtcEngine.enableLastmileTest] method, this callback reports once every two seconds the uplink and downlink last mile network conditions of the local user before the user joins the channel.
  ///
  /// The `NetworkQualityCallback` typedef includes the following parameter:
  /// - [NetworkQuality] `quality`: The last mile network quality based on the uplink and downlink packet loss rate and jitter.
  NetworkQualityCallback? lastmileQuality;

  /// Reports the last mile network quality of each user in the channel once every two seconds.
  ///
  /// Last mile refers to the connection between the local device and Agora's edge server. This callback reports once every two seconds the last mile network conditions of each user in the channel. If a channel includes multiple users, then this callback will be triggered as many times.
  ///
  /// The `NetworkQualityWithUidCallback` typedef includes the following parameters:
  /// - [int] `uid`：User ID. The network quality of the user with this uid is reported. If `uid` is 0, the local network quality is reported.
  /// - [NetworkQuality] `txQuality`: Uplink transmission quality of the user in terms of the transmission bitrate, packet loss rate, average RTT (Round-Trip Time)and jitter of the uplink network. `txQuality` is a quality rating helping you understand how well the current uplink network conditions can support the selected [VideoEncoderConfiguration]. For example, a 1000 Kbps uplink network may be adequate for video frames with a resolution of 680 × 480 and a frame rate of 30 fps, but may be inadequate for resolutions higher than 1280 × 720.
  /// - [NetworkQuality] `rxQuality`: Downlink network quality rating of the user in terms of packet loss rate, average RTT, and jitter of the downlink network.
  NetworkQualityWithUidCallback? networkQuality;

  /// Reports the last-mile network probe result.
  ///
  /// The SDK triggers this callback within 30 seconds after the app calls the [RtcEngine.startLastmileProbeTest] method.
  ///
  /// The `LastmileProbeCallback` typedef includes the following parameter:
  /// - [LastmileProbeResult] `result`: The uplink and downlink last-mile network probe test result.
  LastmileProbeCallback? lastmileProbeResult;

  /// Reports the statistics of the local video streams.
  ///
  /// The SDK triggers this callback once every two seconds for each user/host. If there are multiple users/hosts in the channel, the SDK triggers this callback as many times.
  ///
  /// The `LocalVideoStatsCallback` typedef includes the following parameter:
  /// - [LocalVideoStats] `stats`: The statistics of the local video stream.
  LocalVideoStatsCallback? localVideoStats;

  /// Reports the statistics of the local audio stream.
  ///
  /// The `LocalAudioStats` typedef includes the following parameter:
  /// - [LocalAudioStats] `stats`: The statistics of the local audio stream.
  LocalAudioStatsCallback? localAudioStats;

  /// Reports the statistics of the video stream from each remote user/host. The SDK triggers this callback once every two seconds for each remote user/host. If a channel includes multiple remote users, the SDK triggers this callback as many times.
  ///
  /// The `RemoteVideoStatsCallback` typedef includes the following parameter:
  /// - [RemoteVideoStats] `stats`: Statistics of the received remote video streams.
  RemoteVideoStatsCallback? remoteVideoStats;

  /// Reports the statistics of the audio stream from each remote user/host.
  ///
  /// The SDK triggers this callback once every two seconds for each remote user/host. If a channel includes multiple remote users, the SDK triggers this callback as many times.
  ///
  /// Schemes such as FEC (Forward Error Correction) or retransmission counter the frame loss rate. Hence, users may find the overall audio quality acceptable even when the packet loss rate is high.
  ///
  /// The `RemoteAudioStatsCallback` typedef includes the following parameter:
  /// - [RemoteAudioStats] `stats`: Statistics of the received remote audio streams.
  RemoteAudioStatsCallback? remoteAudioStats;

  /// Occurs when the audio mixing file playback finishes.
  ///
  /// **Deprecated** This callback is deprecated. Use [RtcEngineEventHandler.audioMixingStateChanged] instead.
  ///
  /// You can start an audio mixing file playback by calling the [RtcEngine.startAudioMixing] method. This callback is triggered when the audio mixing file playback finishes.
  ///
  /// If the [RtcEngine.startAudioMixing] method call fails, an [WarningCode.AudioMixingOpenError] warning returns in the [warning] callback.
  /// The `EmptyCallback` typedef does not include any parameter.
  @deprecated
  EmptyCallback? audioMixingFinished;

  /// Occurs when the playback state of the local user's music file changes.
  ///
  /// When you call the [RtcEngine.startAudioMixing] method and the state of audio mixing file changes, the Agora SDK triggers this callback.
  /// When the playback state of the local user's music file changes, the SDK triggers this callback and reports the current playback state and the reason for the change.
  ///
  /// The `AudioMixingStateCallback` typedef includes the following parameters:
  /// - [AudioMixingStateCode] `state`: The current music file playback state.
  /// - [AudioMixingReason] `reason`: The reason for the change of the music file playback state.
  AudioMixingStateCallback? audioMixingStateChanged;

  /// Occurs when the audio effect file playback finishes.
  ///
  /// You can start a local audio effect playback by calling the [RtcEngine.playEffect] method. This callback is triggered when the local audio effect file playback finishes.
  ///
  /// The `SoundIdCallback` typedef includes the following parameter:
  /// - [int] `soundId`: ID of the local audio effect. Each local audio effect has a unique ID.
  SoundIdCallback? audioEffectFinished;

  /// Occurs when the state of the RTMP or RTMPS streaming changes.
  ///
  /// The SDK triggers this callback to report the result of the local user calling the [RtcEngine.addPublishStreamUrl] or [RtcEngine.removePublishStreamUrl] method. This callback returns the URL and its current streaming state. When the streaming state is [RtmpStreamingState.Failure], see the `errCode` parameter for details.
  ///
  /// This callback indicates the state of the RTMP or RTMPS streaming. When exceptions occur, you can troubleshoot issues by referring to the detailed error descriptions in the `errCode` parameter.
  ///
  /// The `RtmpStreamingStateCallback` typedef includes the following parameters:
  /// - [String] `url`: The CDN streaming URL.
  /// - [RtmpStreamingState] `state`: The RTMP or RTMPS streaming state.
  /// - [RtmpStreamingErrorCode] `errCode`: The detailed error information for streaming.
  RtmpStreamingStateCallback? rtmpStreamingStateChanged;

  /// Occurs when the publisher's transcoding settings are updated.
  ///
  /// When the [LiveTranscoding] class in the [RtcEngine.setLiveTranscoding] method updates, the SDK triggers this callback to report the update information.
  ///
  /// **Note**
  /// - If you call the [RtcEngine.setLiveTranscoding] method to set the [LiveTranscoding] class for the first time, the SDK does not trigger this callback.
  /// The `EmptyCallback` typedef does not include any parameter.
  EmptyCallback? transcodingUpdated;

  /// Reports the status of injecting the online media stream.
  ///
  /// The `StreamInjectedStatusCallback` typedef includes the following parameters:
  /// - [String] `url`: The URL address of the externally injected stream.
  /// - [int] `uid`: User ID.
  /// - [InjectStreamStatus] `status`: State of the externally injected stream.
  StreamInjectedStatusCallback? streamInjectedStatus;

  /// Occurs when the local user receives a remote data stream.
  ///
  /// The SDK triggers this callback when the local user receives the stream message that the remote user sends by calling the [RtcEngine.sendStreamMessage] method.
  ///
  /// The `StreamMessageCallback` typedef includes the following parameters:
  /// - [int] `uid`: User ID of the remote user sending the data stream.
  /// - [int] `streamId`: Stream ID.
  /// - [String] `data`: Data received by the local user.
  StreamMessageCallback? streamMessage;

  /// Occurs when the local user fails to receive a remote data stream.
  ///
  /// The SDK triggers this callback when the local user fails to receive the stream message that the remote user sends by calling the [RtcEngine.sendStreamMessage] method.
  ///
  /// The `StreamMessageErrorCallback` callback includes the following parameters:
  /// - [int] `uid`: User ID of the remote user sending the data stream.
  /// - [int] `streamId`: Stream ID.
  /// - [ErrorCode] `error`: Error code.
  /// - [int] `missed`: The number of lost messages.
  /// - [int] `cached`: The number of incoming cached messages when the data stream is interrupted.
  StreamMessageErrorCallback? streamMessageError;

  /// Occurs when the media engine is loaded.
  ///
  /// The `EmptyCallback` typedef does not include any parameter.
  EmptyCallback? mediaEngineLoadSuccess;

  /// Occurs when the media engine starts.
  ///
  /// The `EmptyCallback` typedef does not include any parameter.
  EmptyCallback? mediaEngineStartCallSuccess;

  /// Occurs when the state of the media stream relay changes.
  ///
  /// The SDK reports the state of the current media relay and possible error messages in this callback.
  ///
  /// The `MediaRelayStateCallback` typedef includes the following parameters:
  /// - [ChannelMediaRelayState] `state`: The state code.
  /// - [ChannelMediaRelayError] `code`: The error code.
  MediaRelayStateCallback? channelMediaRelayStateChanged;

  /// Reports events during the media stream relay.
  ///
  /// The `MediaRelayEventCallback` typedef includes the following parameter:
  /// - [ChannelMediaRelayEvent] `code`: The event code for media stream relay.
  MediaRelayEventCallback? channelMediaRelayEvent;

  /// Occurs when the first remote video frame is rendered.
  ///
  /// **Deprecated** Use [VideoRemoteState.Starting] or [VideoRemoteState.Decoding] in the [remoteVideoStateChanged] callback instead.
  ///
  /// This callback is triggered after the first frame of the remote video is rendered on the video window. The application can retrieve the data of the time elapsed from the user joining the channel until the first video frame is displayed.
  ///
  /// The `VideoFrameWithUidCallback` typedef includes the following parameters:
  /// - [int] `uid`: User ID of the remote user sending the video streams.
  /// - [int] `width`: Width (pixels) of the video stream.
  /// - [int] `height`: Height (pixels) of the video stream.
  /// - [int] `elapsed`: Time elapsed (ms) from the local user calling [RtcEngine.joinChannel] until this callback is triggered.
  @deprecated
  VideoFrameWithUidCallback? firstRemoteVideoFrame;

  /// Occurs when the first remote audio frame is received.
  ///
  /// **Deprecated** Use [AudioRemoteState.Starting] in [remoteAudioStateChanged] instead.
  ///
  /// The `UidWithElapsedCallback` typedef includes the following parameters:
  /// - [int] `uid`: This parameter has the following definitions in different events:
  ///   - [userJoined]: ID of the user or host who joins the channel.
  ///   - [firstRemoteAudioFrame]: User ID of the remote user.
  ///   - [firstRemoteAudioDecoded]: User ID of the remote user sending the audio stream.
  ///   - [joinChannelSuccess]: User ID.
  ///   - [rejoinChannelSuccess]: User ID.
  /// - [int] `elapsed`:
  ///   - [userJoined]: Time delay (ms) from the local user calling [RtcEngine.joinChannel] or [RtcEngine.setClientRole] until this callback is triggered.
  ///   - [firstRemoteAudioFrame]: Time elapsed (ms) from the local user calling [RtcEngine.joinChannel] until this callback is triggered.
  ///   - [firstRemoteAudioDecoded]: Time elapsed (ms) from the local user calling [RtcEngine.joinChannel] until the SDK triggers this callback.
  ///   - [joinChannelSuccess]: Time elapsed (ms) from the local user calling [RtcChannel.joinChannel] until this callback is triggered.
  ///   - [rejoinChannelSuccess]: Time elapsed (ms) from the local user starting to reconnect until this callback is triggered.
  @deprecated
  UidWithElapsedCallback? firstRemoteAudioFrame;

  /// Occurs when the engine receives the first audio frame from a specified remote user.
  ///
  /// **Deprecated** Use [VideoRemoteState.Decoding] in [remoteAudioStateChanged] instead.
  ///
  /// This callback is triggered in either of the following scenarios：
  /// - The remote user joins the channel and sends the audio stream.
  /// - The remote user stops sending the audio stream and re-sends it after 15 seconds. Possible reasons include:
  /// -- The remote user leaves channel.
  /// -- The remote user drops offline.
  /// -- The remote user calls the [RtcEngine.muteLocalAudioStream] method.
  /// -- The remote user calls the [RtcEngine.disableAudio] method.
  ///
  /// The `UidWithElapsedCallback` typedef includes the following parameters:
  /// - [int] `uid`: This parameter has the following definitions in different events:
  ///   - [userJoined]: ID of the user or host who joins the channel.
  ///   - [firstRemoteAudioFrame]: User ID of the remote user.
  ///   - [firstRemoteAudioDecoded]: User ID of the remote user sending the audio stream.
  ///   - [joinChannelSuccess]: User ID.
  ///   - [rejoinChannelSuccess]: User ID.
  /// - [int] `elapsed`:
  ///   - [userJoined]: Time delay (ms) from the local user calling [RtcEngine.joinChannel] or [RtcEngine.setClientRole] until this callback is triggered.
  ///   - [firstRemoteAudioFrame]: Time elapsed (ms) from the local user calling [RtcEngine.joinChannel] until this callback is triggered.
  ///   - [firstRemoteAudioDecoded]: Time elapsed (ms) from the local user calling [RtcEngine.joinChannel] until the SDK triggers this callback.
  ///   - [joinChannelSuccess]: Time elapsed (ms) from the local user calling [RtcChannel.joinChannel] until this callback is triggered.
  ///   - [rejoinChannelSuccess]: Time elapsed (ms) from the local user starting to reconnect until this callback is triggered.
  @deprecated
  UidWithElapsedCallback? firstRemoteAudioDecoded;

  /// Occurs when a remote user stops/resumes sending the audio stream.
  ///
  /// **Deprecated** Use the [RtcEngineEventHandler.remoteAudioStateChanged] callback with the following parameters instead:
  /// - [VideoRemoteState.Stopped] and [VideoRemoteStateReason.RemoteMuted].
  /// - [VideoRemoteState.Decoding] and [VideoRemoteStateReason.RemoteUnmuted].
  ///
  /// The SDK triggers this callback when the remote user stops or resumes sending the audio stream by calling the [RtcEngine.muteLocalAudioStream] method.
  ///
  /// **Note**
  /// - This callback is invalid when the number of users or broadcasters in the channel exceeds 17.
  ///
  /// The `UidWithMutedCallback` typedef includes the following parameters:
  /// - [int] `uid`: ID of the remote user.
  /// - [bool] `muted`: Whether the remote user's video stream playback pauses/resumes:
  ///    - `true`: Pause.
  ///    - `false`: Resume.
  @deprecated
  UidWithMutedCallback? userMuteAudio;

  /// Reports the result of calling the [RtcEngine.addPublishStreamUrl] method.
  ///
  /// **Deprecated** Use [RtcEngineEventHandler.rtmpStreamingStateChanged] instead.
  ///
  /// This callback indicates whether you have successfully added an RTMP stream to the CDN.
  ///
  /// The `UrlWithErrorCallback` includes the following parameters:
  /// - [String] `url`: The CDN streaming URL.
  /// - [ErrorCode] `error`: The detailed error information.
  @deprecated
  UrlWithErrorCallback? streamPublished;

  /// Reports the result of calling the [RtcEngine.removePublishStreamUrl] method.
  ///
  /// **Deprecated** Use [RtcEngineEventHandler.rtmpStreamingStateChanged] instead.
  ///
  /// This callback indicates whether you have successfully removed an RTMP stream from the CDN.
  ///
  /// The `UrlCallback` typedef includes the following parameter:
  /// - [String] `url`: The CDN streaming URL.
  @deprecated
  UrlCallback? streamUnpublished;

  /// Reports the transport-layer statistics of each remote audio stream.
  ///
  /// **Deprecated** This callback is deprecated. Use [RtcEngineEventHandler.remoteAudioStats] instead.
  ///
  /// This callback reports the transport-layer statistics, such as the packet loss rate and time delay, once every two seconds after the local user receives an audio packet from a remote user.
  ///
  /// The `TransportStatsCallback` typedef includes the following parameters:
  /// - [int] `uid`: User ID of the remote user sending the audio packet.
  /// - [int] `delay`: Network time delay (ms) from the remote user sending the audio packet to the local user.
  /// - [int] `lost`: Packet loss rate (%) of the audio packet sent from the remote user.
  /// - [int] `rxKBitRate`: Received bitrate (Kbps) of the audio packet sent from the remote user.
  @deprecated
  TransportStatsCallback? remoteAudioTransportStats;

  /// Reports the transport-layer statistics of each remote video stream.
  ///
  /// **Deprecated** This callback is deprecated. Use [RtcEngineEventHandler.remoteVideoStats] instead.
  ///
  /// This callback reports the transport-layer statistics, such as the packet loss rate and time delay, once every two seconds after the local user receives the video packet from a remote user.
  ///
  /// The `TransportStatsCallback` typedef includes the following parameters:
  /// - [int] `uid`: User ID of the remote user sending the audio packet.
  /// - [int] `delay`: Network time delay (ms) from the remote user sending the audio packet to the local user.
  /// - [int] `lost`: Packet loss rate (%) of the audio packet sent from the remote user.
  /// - [int] `rxKBitRate`: Received bitrate (Kbps) of the audio packet sent from the remote user.
  @deprecated
  TransportStatsCallback? remoteVideoTransportStats;

  /// Occurs when a remote user enables/disables the video module.
  ///
  /// **Deprecated** This callback is deprecated and replaced by the [RtcEngineEventHandler.remoteVideoStateChanged] callback with the following parameters:
  /// - [VideoRemoteState.Stopped] and [VideoRemoteStateReason.RemoteMuted].
  /// - [VideoRemoteState.Decoding] and [VideoRemoteStateReason.RemoteUnmuted].
  ///
  /// Once the video module is disabled, the remote user can only use a voice call. The remote user cannot send or receive any video from other users.
  ///
  /// The SDK triggers this callback when the remote user enables or disables the video module by calling the [RtcEngine.enableVideo] or [RtcEngine.disableVideo] method.
  ///
  /// **Note**
  /// - This callback is invalid when the number of users or broadcasters in the channel exceeds 17.
  ///
  /// The `UidWithEnabledCallback` typedef includes the followinh parameters:
  /// - [int] `uid`: User ID of the remote user.
  /// - [bool] `enabled`: Whether the specific remote user enables/disables the video module:
  ///   - `true`: Enabled. The remote user can enter a video session.
  ///   - `false`: Disabled. The remote user can only enter a voice session, and cannot send or receive any video stream.
  @deprecated
  UidWithEnabledCallback? userEnableVideo;

  /// Occurs when a remote user enables/disables the local video capture function.
  ///
  /// **Deprecated** This callback is deprecated and replaced by the [RtcEngineEventHandler.remoteVideoStateChanged] callback with the following parameters:
  /// - [VideoRemoteState.Stopped] and [VideoRemoteStateReason.RemoteMuted].
  /// - [VideoRemoteState.Decoding] and [VideoRemoteStateReason.RemoteUnmuted].
  ///
  /// The SDK triggers this callback when the remote user resumes or stops capturing the video stream by calling the [RtcEngine.enableLocalVideo] method.
  /// This callback is only applicable to the scenario when the remote user only wants to watch the remote video without sending any video stream to the other user.
  ///
  /// The `UidWithEnabledCallback` typedef includes the followinh parameters:
  /// - [int] `uid`: User ID of the remote user.
  /// - [bool] `enabled`: Whether the specific remote user enables/disables the video module:
  ///   - `true`: Enabled. The remote user can enter a video session.
  ///   - `false`: Disabled. The remote user can only enter a voice session, and cannot send or receive any video stream.
  @deprecated
  UidWithEnabledCallback? userEnableLocalVideo;

  /// Occurs when the first remote video frame is received and decoded.
  ///
  /// **Deprecated** This callback is deprecated. Use [VideoRemoteState.Starting] or [VideoRemoteState.Decoding] in the [RtcEngineEventHandler.remoteVideoStateChanged] callback instead.
  ///
  /// This callback is triggered in either of the following scenarios:
  /// - The remote user joins the channel and sends the video stream.
  /// - The remote user stops sending the video stream and re-sends it after 15 seconds. Possible reasons include:
  /// -- The remote user leaves channel.
  /// -- The remote user drops offline.
  /// -- The remote user calls the [RtcEngine.muteLocalVideoStream] method.
  /// -- The remote user calls the [RtcEngine.disableVideo] method.
  ///
  /// The `VideoFrameWithUidCallback` typedef includes the following parameters:
  /// - [int] `uid`: User ID of the remote user sending the video streams.
  /// - [int] `width`: Width (pixels) of the video stream.
  /// - [int] `height`: Height (pixels) of the video stream.
  /// - [int] `elapsed`: Time elapsed (ms) from the local user calling [RtcEngine.joinChannel] until this callback is triggered.
  @deprecated
  VideoFrameWithUidCallback? firstRemoteVideoDecoded;

  /// Occurs when the microphone is enabled/disabled.
  ///
  ///
  /// **Deprecated** This callback is deprecated. Use [AudioLocalState.Stopped] (0) or [AudioLocalState.Recording] (1) in the [RtcEngineEventHandler.localAudioStateChanged] callback instead.
  /// The SDK triggers this callback when the local user resumes or stops capturing the local audio stream by calling the [RtcEngine.enableLocalAudio] method.
  ///
  /// The `EnabledCallback` includes the following parameter:
  /// - [bool] `enabled`: Whether the microphone is enabled/disabled:
  ///   - `true`：Enabled.
  ///   - `false`：Disabled.
  @deprecated
  EnabledCallback? microphoneEnabled;

  /// Occurs when the connection between the SDK and the server is interrupted.
  ///
  /// **Deprecated** Use [RtcEngineEventHandler.connectionStateChanged] instead.
  ///
  /// The SDK triggers this callback when it loses connection to the server for more than four seconds after the connection is established. After triggering this callback, the SDK tries to reconnect to the server. You can use this callback to implement pop-up reminders. This callback is different from [RtcEngineEventHandler.connectionLost]:
  /// - The SDK triggers the [RtcEngineEventHandler.connectionInterrupted] callback when the SDK loses connection with the server for more than four seconds after it joins the channel.
  /// - The SDK triggers the [RtcEngineEventHandler.connectionLost] callback when it loses connection with the server for more than 10 seconds, regardless of whether it joins the channel or not.
  ///
  /// If the SDK fails to rejoin the channel 20 minutes after being disconnected from Agora's edge server, the SDK stops rejoining the channel.
  /// The `EmptyCallback` typedef does not include any parameter.
  @deprecated
  EmptyCallback? connectionInterrupted;

  /// Occurs when your connection is banned by the Agora Server.
  ///
  /// **Deprecated** Use [RtcEngineEventHandler.connectionStateChanged] instead.
  /// The `EmptyCallback` typedef does not include any parameter.
  @deprecated
  EmptyCallback? connectionBanned;

  /// Reports the statistics of the audio stream from each remote user/host.
  ///
  /// **Deprecated** Use [RtcEngineEventHandler.remoteAudioStats] instead.
  ///
  /// The SDK triggers this callback once every two seconds to report the audio quality of each remote user/host sending an audio stream. If a channel has multiple remote users/hosts sending audio streams, the SDK trggers this callback as many times.
  ///
  /// The `AudioQualityCallback` typedef includes the following parameters:
  /// [int] `uid`: User ID of the speaker.
  /// [int] `quality`: Audio quality of the user.
  /// [int] `delay`: Time delay (ms) of the audio packet from the sender to the receiver, including the time delay from audio sampling pre-processing, transmission, and the jitter buffer.
  /// [int] `lost`: Packet loss rate (%) of the audio packet sent from the sender to the receiver.
  @deprecated
  AudioQualityCallback? audioQuality;

  /// Occurs when the camera is turned on and ready to capture video.
  ///
  /// **Deprecated** Use [LocalVideoStreamState.Capturing] in the [RtcEngineEventHandler.localVideoStateChanged] callback instead. If the camera fails to turn on, fix the error reported in the [LocalVideoStreamState.Failed] callback.
  /// The `EmptyCallback` typedef does not include any parameter.
  @deprecated
  EmptyCallback? cameraReady;

  /// Occurs when the video stops playing.
  ///
  /// **Deprecated** Use [LocalVideoStreamState.Stopped] in the [RtcEngineEventHandler.localVideoStateChanged] callback instead. The application can use this callback to change the configuration of the view (for example, displaying other pictures in the view) after the video stops playing.
  /// The `EmptyCallback` typedef does not include any parameter.
  @deprecated
  EmptyCallback? videoStopped;

  /// Occurs when the local user receives the metadata.
  ///
  /// The `MetadataCallback` typedef includes the following parameters:
  /// - [String]: `buffer`: The received metadata.
  /// - [int]: `uid`: The ID of the user who sent the metadata.
  /// - [int]: `timeStampMs`: The timestamp (ms) of the received metadata.
  MetadataCallback? metadataReceived;

  /// Occurs when the first audio frame is published.
  ///
  /// The SDK triggers this callback under one of the following circumstances:
  /// - The local client enables the audio module and calls [RtcEngine.joinChannel] successfully.
  /// - The local client calls [RtcEngine.muteLocalAudioStream] (`true`) and [RtcEngine.muteLocalAudioStream] (`false`) in sequence.
  /// - The local client calls [RtcEngine.disableAudio] (`true`) and [RtcEngine.enableAudio] in sequence.
  ///
  /// The `ElapsedCallback` typedef includes the following parameters:
  /// - [int] `Elapsed`: Time elapsed (ms) from the local user calling the [RtcEngine.joinChannel] until this callback is triggered.
  ElapsedCallback? firstLocalAudioFramePublished;

  /// Occurs when the first video frame is published.
  ///
  /// The SDK triggers this callback under one of the following circumstances:
  /// - The local client enables the video module and calls [RtcEngine.joinChannel] successfully.
  /// - The local client calls [RtcEngine.muteLocalVideoStream] (`true`) and [RtcEngine.muteLocalVideoStream] (`false`) in sequence.
  /// - The local client calls [RtcEngine.disableVideo] and [RtcEngine.enableVideo] in sequence.
  ///
  /// The `ElapsedCallback` typedef includes the following parameters:
  /// - [int] `Elapsed`: Time elapsed (ms) from the local user calling the [RtcEngine.joinChannel] until this callback is triggered.
  ElapsedCallback? firstLocalVideoFramePublished;

  /// Occurs when the audio publishing state changes.
  ///
  /// This callback indicates the publishing state change of the local audio stream.
  ///
  /// The `StreamPublishStateCallback` typedef includes the following parameters:
  /// - [String] `channel`: The channel name.
  /// - [StreamPublishState] `oldState`: The previous publishing state. See [StreamPublishState].
  /// - [StreamPublishState] `newState`: The current publishing state. See [StreamPublishState].
  /// - [int] `elapseSinceLastState`: The time elapsed (ms) from the previous state to the current state.
  StreamPublishStateCallback? audioPublishStateChanged;

  /// Occurs when the video publishing state changes.
  ///
  /// This callback indicates the publishing state change of the local video stream.
  ///
  /// The `StreamPublishStateCallback` typedef includes the following parameters:
  /// - [String] `channel`: The channel name.
  /// - [StreamPublishState] `oldState`: The previous publishing state. See [StreamPublishState].
  /// - [StreamPublishState] `newState`: The current publishing state. See [StreamPublishState].
  /// - [int] `elapseSinceLastState`: The time elapsed (ms) from the previous state to the current state.
  StreamPublishStateCallback? videoPublishStateChanged;

  /// Occurs when the audio subscribing state changes.
  ///
  /// This callback indicates the subscribing state change of a remote audio stream.
  ///
  /// The `StreamSubscribeStateCallback` typedef includes the following parameters:
  /// - [String] `channel`: The channel name.
  /// - [StreamSubscribeState] `oldState`: The previous publishing state. See [StreamPublishState].
  /// - [StreamSubscribeState] `newState`: The current publishing state. See [StreamPublishState].
  /// - [int] `elapseSinceLastState`: The time elapsed (ms) from the previous state to the current state.
  StreamSubscribeStateCallback? audioSubscribeStateChanged;

  /// Occurs when the video subscribing state changes.
  ///
  /// This callback indicates the subscribing state change of a remote video stream.
  ///
  /// The `StreamSubscribeStateCallback` typedef includes the following parameters:
  /// - [String] `channel`: The channel name.
  /// - [StreamSubscribeState] `oldState`: The previous publishing state. See [StreamPublishState].
  /// - [StreamSubscribeState] `newState`: The current publishing state. See [StreamPublishState].
  /// - [int] `elapseSinceLastState`: The time elapsed (ms) from the previous state to the current state.
  StreamSubscribeStateCallback? videoSubscribeStateChanged;

  /// Reports events during the RTMP or RTMPS streaming.
  ///
  /// The `RtmpStreamingEventCallback` typedef includes the following parameters:
  /// - [String] `url`: The RTMP or RTMPS streaming URL.
  /// - [RtmpStreamingEvent] `eventCode`: The event code. See [RtmpStreamingEvent].
  RtmpStreamingEventCallback? rtmpStreamingEvent;

  /// @nodoc
  UserSuperResolutionEnabledCallback? userSuperResolutionEnabled;

  /// @nodoc
  UploadLogResultCallback? uploadLogResult;

  /// @nodoc
  ContentInspectResultCallback? contentInspectResult;

  /// @nodoc
  SnapshotTakenCallback? snapshotTaken;

  /// Constructs a [RtcEngineEventHandler]
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
  });

  // ignore: public_member_api_docs
  void process(String methodName, List<dynamic> data) {
    switch (methodName) {
      case 'Warning':
        warning?.call(WarningCodeConverter.fromValue(data[0]).e);
        break;
      case 'Error':
        error?.call(ErrorCodeConverter.fromValue(data[0]).e);
        break;
      case 'ApiCallExecuted':
        apiCallExecuted?.call(
            ErrorCodeConverter.fromValue(data[0]).e, data[1], data[2]);
        break;
      case 'JoinChannelSuccess':
        joinChannelSuccess?.call(data[0], data[1], data[2]);
        break;
      case 'RejoinChannelSuccess':
        rejoinChannelSuccess?.call(data[0], data[1], data[2]);
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
        clientRoleChanged?.call(ClientRoleConverter.fromValue(data[0]).e,
            ClientRoleConverter.fromValue(data[1]).e);
        break;
      case 'UserJoined':
        userJoined?.call(data[0], data[1]);
        break;
      case 'UserOffline':
        userOffline?.call(
            data[0], UserOfflineReasonConverter.fromValue(data[1]).e);
        break;
      case 'ConnectionStateChanged':
        connectionStateChanged?.call(
            ConnectionStateTypeConverter.fromValue(data[0]).e,
            ConnectionChangedReasonConverter.fromValue(data[1]).e);
        break;
      case 'NetworkTypeChanged':
        networkTypeChanged?.call(NetworkTypeConverter.fromValue(data[0]).e);
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
                (index) => AudioVolumeInfo.fromJson(
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
            VideoRemoteStateConverter.fromValue(data[1]).e,
            VideoRemoteStateReasonConverter.fromValue(data[2]).e,
            data[3]);
        break;
      case 'LocalVideoStateChanged':
        localVideoStateChanged?.call(
            LocalVideoStreamStateConverter.fromValue(data[0]).e,
            LocalVideoStreamErrorConverter.fromValue(data[1]).e);
        break;
      case 'RemoteAudioStateChanged':
        remoteAudioStateChanged?.call(
            data[0],
            AudioRemoteStateConverter.fromValue(data[1]).e,
            AudioRemoteStateReasonConverter.fromValue(data[2]).e,
            data[3]);
        break;
      case 'LocalAudioStateChanged':
        localAudioStateChanged?.call(
            AudioLocalStateConverter.fromValue(data[0]).e,
            AudioLocalErrorConverter.fromValue(data[1]).e);
        break;
      case 'LocalPublishFallbackToAudioOnly':
        localPublishFallbackToAudioOnly?.call(data[0]);
        break;
      case 'RemoteSubscribeFallbackToAudioOnly':
        remoteSubscribeFallbackToAudioOnly?.call(data[0], data[1]);
        break;
      case 'AudioRouteChanged':
        audioRouteChanged
            ?.call(AudioOutputRoutingConverter.fromValue(data[0]).e);
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
                (index) => FacePositionInfo.fromJson(
                    Map<String, dynamic>.from(list[index]))));
        break;
      case 'RtcStats':
        rtcStats?.call(RtcStats.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'LastmileQuality':
        lastmileQuality?.call(NetworkQualityConverter.fromValue(data[0]).e);
        break;
      case 'NetworkQuality':
        networkQuality?.call(
            data[0],
            NetworkQualityConverter.fromValue(data[1]).e,
            NetworkQualityConverter.fromValue(data[2]).e);
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
          AudioMixingStateCodeConverter.fromValue(data[0]).e,
          AudioMixingReasonConverter.fromValue(data[1]).e,
        );
        break;
      case 'AudioEffectFinished':
        audioEffectFinished?.call(data[0]);
        break;
      case 'RtmpStreamingStateChanged':
        rtmpStreamingStateChanged?.call(
          data[0],
          RtmpStreamingStateConverter.fromValue(data[1]).e,
          RtmpStreamingErrorCodeConverter.fromValue(data[2]).e,
        );
        break;
      case 'TranscodingUpdated':
        transcodingUpdated?.call();
        break;
      case 'StreamInjectedStatus':
        streamInjectedStatus?.call(
            data[0], data[1], InjectStreamStatusConverter.fromValue(data[2]).e);
        break;
      case 'StreamMessage':
        streamMessage?.call(data[0], data[1], data[2]);
        break;
      case 'StreamMessageError':
        streamMessageError?.call(data[0], data[1],
            ErrorCodeConverter.fromValue(data[2]).e, data[3], data[4]);
        break;
      case 'MediaEngineLoadSuccess':
        mediaEngineLoadSuccess?.call();
        break;
      case 'MediaEngineStartCallSuccess':
        mediaEngineStartCallSuccess?.call();
        break;
      case 'ChannelMediaRelayStateChanged':
        channelMediaRelayStateChanged?.call(
          ChannelMediaRelayStateConverter.fromValue(data[0]).e,
          ChannelMediaRelayErrorConverter.fromValue(data[1]).e,
        );
        break;
      case 'ChannelMediaRelayEvent':
        channelMediaRelayEvent
            ?.call(ChannelMediaRelayEventConverter.fromValue(data[0]).e);
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
        streamPublished?.call(data[0], ErrorCodeConverter.fromValue(data[1]).e);
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
      case 'FirstLocalAudioFramePublished':
        firstLocalAudioFramePublished?.call(data[0]);
        break;
      case 'FirstLocalVideoFramePublished':
        firstLocalVideoFramePublished?.call(data[0]);
        break;
      case 'AudioPublishStateChanged':
        audioPublishStateChanged?.call(
            data[0],
            StreamPublishStateConverter.fromValue(data[1]).e,
            StreamPublishStateConverter.fromValue(data[2]).e,
            data[3]);
        break;
      case 'VideoPublishStateChanged':
        videoPublishStateChanged?.call(
            data[0],
            StreamPublishStateConverter.fromValue(data[1]).e,
            StreamPublishStateConverter.fromValue(data[2]).e,
            data[3]);
        break;
      case 'AudioSubscribeStateChanged':
        audioSubscribeStateChanged?.call(
            data[0],
            data[1],
            StreamSubscribeStateConverter.fromValue(data[2]).e,
            StreamSubscribeStateConverter.fromValue(data[3]).e,
            data[4]);
        break;
      case 'VideoSubscribeStateChanged':
        videoSubscribeStateChanged?.call(
            data[0],
            data[1],
            StreamSubscribeStateConverter.fromValue(data[2]).e,
            StreamSubscribeStateConverter.fromValue(data[3]).e,
            data[4]);
        break;
      case 'RtmpStreamingEvent':
        rtmpStreamingEvent?.call(data[0], data[1]);
        break;
      case 'UserSuperResolutionEnabled':
        userSuperResolutionEnabled?.call(data[0], data[1],
            SuperResolutionStateReasonConverter.fromValue(data[2]).e);
        break;
      case 'UploadLogResult':
        uploadLogResult?.call(
            data[0], data[1], UploadErrorReasonConverter.fromValue(data[2]).e);
        break;
      case 'ContentInspectResult':
        contentInspectResult
            ?.call(ContentInspectResultConverter.fromValue(data[0]).e);
        break;
      case 'SnapshotTaken':
        snapshotTaken?.call(
            data[0], data[1], data[2], data[3], data[4], data[5]);
        break;
    }
  }
}

/// The RtcChannelEvents interface.
class RtcChannelEventHandler {
  /// Reports the warning code of the [RtcChannel] instance.
  ///
  /// The `WarningCallback` typedef includes the following parameter:
  /// - [WarningCode] `warn`: Warning code.
  WarningCallback? warning;

  /// Reports the error code of the [RtcChannel] instance.
  ///
  /// The `ErrorCallback` typedef includes the following parameter:
  /// - [ErrorCode] `err`: Error code.
  ErrorCallback? error;

  /// Occurs when the local user joins a specified channel.
  ///
  /// If the uid is not specified when calling [RtcChannel.joinChannel], the server automatically assigns a uid.
  ///
  /// The `UidWithElapsedCallback` typedef includes the following parameters:
  /// - [int] `uid`: This parameter has the following definitions in different events:
  ///   - [userJoined]: ID of the user or host who joins the channel.
  ///   - [firstRemoteAudioFrame]: User ID of the remote user.
  ///   - [firstRemoteAudioDecoded]: User ID of the remote user sending the audio stream.
  ///   - [joinChannelSuccess]: User ID.
  ///   - [rejoinChannelSuccess]: User ID.
  /// - [int] `elapsed`:
  ///   - [userJoined]: Time delay (ms) from the local user calling [RtcEngine.joinChannel] or [RtcEngine.setClientRole] until this callback is triggered.
  ///   - [firstRemoteAudioFrame]: Time elapsed (ms) from the local user calling [RtcEngine.joinChannel] until this callback is triggered.
  ///   - [firstRemoteAudioDecoded]: Time elapsed (ms) from the local user calling [RtcEngine.joinChannel] until the SDK triggers this callback.
  ///   - [joinChannelSuccess]: Time elapsed (ms) from the local user calling [RtcChannel.joinChannel] until this callback is triggered.
  ///   - [rejoinChannelSuccess]: Time elapsed (ms) from the local user starting to reconnect until this callback is triggered.
  UidWithElapsedAndChannelCallback? joinChannelSuccess;

  /// Occurs when a user rejoins the channel after being disconnected due to network problems.
  ///
  /// When a user loses connection with the server because of network problems, the SDK automatically tries to reconnect and triggers this callback upon reconnection.
  ///
  /// The `UidWithElapsedCallback` typedef includes the following parameters:
  /// - [int] `uid`: This parameter has the following definitions in different events:
  ///   - [userJoined]: ID of the user or host who joins the channel.
  ///   - [firstRemoteAudioFrame]: User ID of the remote user.
  ///   - [firstRemoteAudioDecoded]: User ID of the remote user sending the audio stream.
  ///   - [joinChannelSuccess]: User ID.
  ///   - [rejoinChannelSuccess]: User ID.
  /// - [int] `elapsed`:
  ///   - [userJoined]: Time delay (ms) from the local user calling [RtcEngine.joinChannel] or [RtcEngine.setClientRole] until this callback is triggered.
  ///   - [firstRemoteAudioFrame]: Time elapsed (ms) from the local user calling [RtcEngine.joinChannel] until this callback is triggered.
  ///   - [firstRemoteAudioDecoded]: Time elapsed (ms) from the local user calling [RtcEngine.joinChannel] until the SDK triggers this callback.
  ///   - [joinChannelSuccess]: Time elapsed (ms) from the local user calling [RtcChannel.joinChannel] until this callback is triggered.
  ///   - [rejoinChannelSuccess]: Time elapsed (ms) from the local user starting to reconnect until this callback is triggered.
  UidWithElapsedAndChannelCallback? rejoinChannelSuccess;

  /// Occurs when a user leaves the channel.
  ///
  /// When a user leaves the channel by using the [RtcChannel.leaveChannel] method, the SDK uses this callback to notify the app when the user leaves the channel.
  ///
  /// With this callback, the app retrieves the channel information, such as the call duration and statistics.
  /// The `RtcStatsCallback` typedef includes the following parameter:
  /// - [RtcStats] `stats`: Statistics of the call.
  RtcStatsCallback? leaveChannel;

  /// Occurs when the user role switches in a [ChannelProfile.LiveBroadcasting] channel. For example, from broadcaster to audience or vice versa.
  ///
  /// The SDK triggers this callback when the local user switches the user role by calling the setClientRole method after joining the channel.
  /// See [RtcChannel.setClientRole].
  ///
  /// The `ClientRoleCallback` typedef includes the following parameters:
  /// - [ClientRole] `oldRole`: Role that the user switches from.
  /// - [ClientRole] `newRole`: Role that the user switches to.
  ClientRoleCallback? clientRoleChanged;

  /// Occurs when a remote user (Communication) or a broadcaster ([ChannelProfile.LiveBroadcasting]) joins the channel.
  /// - [ChannelProfile.Communication] profile: This callback notifies the app when another user joins the channel. If other users are already in the channel, the SDK also reports to the app on the existing users.
  /// - [ChannelProfile.LiveBroadcasting] profile: This callback notifies the app when the host joins the channel. If other hosts are already in the channel, the SDK also reports to the app on the existing hosts. We recommend having at most 17 hosts in a channel.
  ///
  /// **Note**
  /// - In the [ChannelProfile.LiveBroadcasting] profile:
  /// -- The host receives this callback when another host joins the channel.
  /// -- The audience in the channel receives this callback when a new host joins the channel.
  /// -- When a web app joins the channel, this callback is triggered as long as the web app publishes streams.
  ///
  /// The `UidWithElapsedCallback` typedef includes the following parameters:
  /// - [int] `uid`: This parameter has the following definitions in different events:
  ///   - [userJoined]: ID of the user or host who joins the channel.
  ///   - [firstRemoteAudioFrame]: User ID of the remote user.
  ///   - [firstRemoteAudioDecoded]: User ID of the remote user sending the audio stream.
  ///   - [joinChannelSuccess]: User ID.
  ///   - [rejoinChannelSuccess]: User ID.
  /// - [int] `elapsed`:
  ///   - [userJoined]: Time delay (ms) from the local user calling [RtcEngine.joinChannel] or [RtcEngine.setClientRole] until this callback is triggered.
  ///   - [firstRemoteAudioFrame]: Time elapsed (ms) from the local user calling [RtcEngine.joinChannel] until this callback is triggered.
  ///   - [firstRemoteAudioDecoded]: Time elapsed (ms) from the local user calling [RtcEngine.joinChannel] until the SDK triggers this callback.
  ///   - [joinChannelSuccess]: Time elapsed (ms) from the local user calling [RtcChannel.joinChannel] until this callback is triggered.
  ///   - [rejoinChannelSuccess]: Time elapsed (ms) from the local user starting to reconnect until this callback is triggered.
  UidWithElapsedCallback? userJoined;

  /// Occurs when a remote user ([ChannelProfile.Communication]) or a broadcaster ([ChannelProfile.LiveBroadcasting]) leaves the channel.
  ///
  /// There are two reasons for users to become offline:
  /// - Leave the channel: When the user/broadcaster leaves the channel, the user/broadcaster sends a goodbye message. When this message is received, the SDK determines that the user/host leaves the channel.
  /// - Go offline: When no data packet of the user or broadcaster is received for a certain period of time (around 20 seconds), the SDK assumes that the user/broadcaster drops offline. A poor network connection may lead to false detections, so we recommend using the Agora RTM SDK for reliable offline detection.
  ///
  /// The `UserOfflineCallback` typedef includes the following parameters:
  /// - [int] `uid`: ID of the user or host who leaves the channel or goes offline.
  /// - [UserOfflineReason] `reason`: Reason why the user goes offline.
  UserOfflineCallback? userOffline;

  /// Occurs when the network connection state changes.
  ///
  /// The Agora SDK triggers this callback to report on the current network connection state when it changes, and the reason to such change.
  ///
  /// The `ConnectionStateCallback` typedef includes the following parameters:
  /// - [ConnectionStateType] `state`: The current network connection state.
  /// - [ConnectionChangedReason] `reason`: The reason causing the change of the connection state.
  ConnectionStateCallback? connectionStateChanged;

  /// Occurs when the SDK cannot reconnect to Agora's edge server 10 seconds after its connection to the server is interrupted.
  ///
  /// The SDK also triggers this callback when it cannot connect to the server 10 seconds after calling [RtcChannel.joinChannel], regardless of whether it is in the channel or not.
  /// If the SDK fails to rejoin the channel 20 minutes after being disconnected from Agora's edge server, the SDK stops rejoining the channel.
  /// The `EmptyCallback` typedef does not include any parameter.
  EmptyCallback? connectionLost;

  /// Occurs when the token expires in 30 seconds.
  ///
  /// The user becomes offline if the token used when joining the channel expires. This callback is triggered 30 seconds before the token expires, to remind the app to get a new token. Upon receiving this callback, you need to generate a new token on the server and call [RtcChannel.renewToken] to pass the new token to the SDK.
  ///
  /// The `TokenCallback` typedef includes the following parameters:
  /// - [String] `token`: The token that will expire in 30 seconds.
  TokenCallback? tokenPrivilegeWillExpire;

  /// Occurs when the token has expired.
  ///
  /// After a token is specified when joining the channel, the token expires after a certain period of time, and a new token is required to reconnect to the server. This callback notifies the app to generate a new token and call [RtcChannel.renewToken] to renew the token.
  /// The `EmptyCallback` typedef does not include any parameter.
  EmptyCallback? requestToken;

  /// Reports which user is the loudest speaker.
  ///
  /// This callback reports the speaker with the highest accumulative volume during a certain period. If the user enables the audio volume indication by calling [RtcEngine.enableAudioVolumeIndication], this callback returns the uid of the active speaker whose voice is detected by the audio volume detection module of the SDK.
  ///
  /// **Note**
  /// - To receive this callback, you need to call [RtcEngine.enableAudioVolumeIndication].
  /// - This callback reports the ID of the user with the highest voice volume during a period of time, instead of at the moment.
  ///
  /// The `UidCallback` typedef includes the following parameters:
  /// - [int] `uid`: User ID of the active speaker. A `uid` of 0 represents the local user.
  UidCallback? activeSpeaker;

  /// Occurs when the video size or rotation information of a remote user changes.
  ///
  /// The `VideoSizeCallback` typedef includes the following parameters:
  /// - [int] `uid`: User ID of the remote user or local user (0) whose video size or rotation changes.
  /// - [int] `width`: New width (pixels) of the video.
  /// - [int] `height`: New height (pixels) of the video.
  /// - [int] `rotation`: New rotation of the video [0 to 360).
  VideoSizeCallback? videoSizeChanged;

  /// Occurs when the remote video state changes.
  ///
  /// The `RemoteVideoStateCallback` typedef includes the following parameters:
  /// - [int] `uid`: ID of the remote user whose video state changes.
  /// - [VideoRemoteState] `state`: State of the remote video.
  /// - [VideoRemoteStateReason] `reason`: The reason of the remote video state change.
  /// - [int] `elapsed`: Time elapsed (ms) from the local user calling [RtcEngine.joinChannel] until the SDK triggers this callback.
  RemoteVideoStateCallback? remoteVideoStateChanged;

  /// Occurs when the remote audio state changes.
  ///
  /// This callback indicates the state change of the remote audio stream.
  ///
  /// This callback does not work properly when the number of users (in the `Communication` profile) or hosts (in the `LiveBroadcasting` profile) in the channel exceeds 17.
  ///
  /// The `RemoteAudioStateCallback` typedef includes the following parameters:
  /// - [int] `uid`: ID of the user whose audio state changes.
  /// - [AudioRemoteState] `state`: State of the remote audio.
  /// - [AudioRemoteStateReason] `reason`: The reason of the remote audio state change.
  /// - [int] `elapsed`: Time elapsed (ms) from the local user calling [RtcEngine.joinChannel] until the SDK triggers this callback.
  RemoteAudioStateCallback? remoteAudioStateChanged;

  /// Occurs when the published media stream falls back to an audio-only stream due to poor network conditions or switches back to video stream after the network conditions improve.
  ///
  /// If you call [RtcEngine.setLocalPublishFallbackOption] and set option as [StreamFallbackOptions.AudioOnly], this callback is triggered when the locally published stream falls back to audio-only mode due to poor uplink conditions, or when the audio stream switches back to the video after the uplink network condition improves.
  ///
  /// The `FallbackCallback` typedef includes the following parameters:
  /// - [bool] `isFallbackOrRecover`: Whether the published stream fell back to audio-only or switched back to the video:
  /// -- `true`: The published stream fell back to audio-only due to poor network conditions.
  /// -- `false`: The published stream switched back to the video after the network conditions improved.
  FallbackCallback? localPublishFallbackToAudioOnly;

  /// Occurs when the remote media stream falls back to audio-only stream due to poor network conditions or switches back to video stream after the network conditions improve.
  ///
  /// If you call [RtcEngine.setRemoteSubscribeFallbackOption] and set option as [StreamFallbackOptions.AudioOnly], this callback is triggered when the remote media stream falls back to audio-only mode due to poor uplink conditions, or when the remote media stream switches back to the video after the uplink network condition improves.
  ///
  /// **Note**
  /// - Once the remote media stream is switched to the low stream due to poor network conditions, you can monitor the stream switch between a high and low stream in the [RtcEngineEventHandler.remoteVideoStats] callback.
  ///
  /// The `FallbackWithUidCallback` typedef includes the following parameters:
  /// - [int]: `uid`: ID of the remote user sending the stream.
  /// - [bool] `isFallbackOrRecover`: Whether the published stream fell back to audio-only or switched back to the video:
  /// -- `true`: The published stream fell back to audio-only due to poor network conditions.
  /// -- `false`: The published stream switched back to the video after the network conditions improved.
  FallbackWithUidCallback? remoteSubscribeFallbackToAudioOnly;

  /// Reports the statistics of the [RtcEngine] once every two seconds.
  /// The `RtcStatsCallback` typedef includes the following parameter:
  /// - [RtcStats] `stats`: Statistics of the call.
  RtcStatsCallback? rtcStats;

  /// Reports the last mile network quality of each user in the channel once every two seconds.
  ///
  /// Last mile refers to the connection between the local device and Agora's edge server. This callback reports once every two seconds the last mile network conditions of each user in the channel. If a channel includes multiple users, then this callback will be triggered as many times.
  ///
  /// The `NetworkQualityWithUidCallback` typedef includes the following parameters:
  /// - [int] `uid`：User ID. The network quality of the user with this uid is reported. If `uid` is 0, the local network quality is reported.
  /// - [NetworkQuality] `txQuality`: Uplink transmission quality of the user in terms of the transmission bitrate, packet loss rate, average RTT (Round-Trip Time)and jitter of the uplink network. `txQuality` is a quality rating helping you understand how well the current uplink network conditions can support the selected [VideoEncoderConfiguration]. For example, a 1000 Kbps uplink network may be adequate for video frames with a resolution of 680 × 480 and a frame rate of 30 fps, but may be inadequate for resolutions higher than 1280 × 720.
  /// - [NetworkQuality] `rxQuality`: Downlink network quality rating of the user in terms of packet loss rate, average RTT, and jitter of the downlink network.
  NetworkQualityWithUidCallback? networkQuality;

  /// Reports the statistics of the video stream from each remote user/broadcaster. The SDK triggers this callback once every two seconds for each remote user/broadcaster. If a channel includes multiple remote users, the SDK triggers this callback as many times.
  ///
  /// The `RemoteVideoStatsCallback` typedef includes the following parameter:
  /// - [RemoteVideoStats] `stats`: Statistics of the received remote video streams.
  RemoteVideoStatsCallback? remoteVideoStats;

  /// Reports the statistics of the audio stream from each remote user/broadcaster.
  ///
  /// The SDK triggers this callback once every two seconds for each remote user/broadcaster. If a channel includes multiple remote users, the SDK triggers this callback as many times.
  ///
  /// Schemes such as FEC (Forward Error Correction) or retransmission counter the frame loss rate. Hence, users may find the overall audio quality acceptable even when the packet loss rate is high.
  ///
  /// The `RemoteAudioStatsCallback` typedef includes the following parameter:
  /// - [RemoteAudioStats] `stats`: Statistics of the received remote audio streams.
  RemoteAudioStatsCallback? remoteAudioStats;

  /// Occurs when the state of the RTMP or RTMPS streaming changes.
  ///
  /// The SDK triggers this callback to report the result of the local user calling the [RtcChannel.addPublishStreamUrl] or [RtcChannel.removePublishStreamUrl] method. This callback returns the URL and its current streaming state. When the streaming state is [RtmpStreamingState.Failure], see the `errCode` parameter for details.
  ///
  /// This callback indicates the state of the RTMP or RTMPS streaming. When exceptions occur, you can troubleshoot issues by referring to the detailed error descriptions in the `errCode` parameter.
  ///
  /// The `RtmpStreamingStateCallback` typedef includes the following parameters:
  /// - [String] `url`: The CDN streaming URL.
  /// - [RtmpStreamingState] `state`: The RTMP or RTMPS streaming state.
  /// - [RtmpStreamingErrorCode] `errCode`: The detailed error information for streaming.
  RtmpStreamingStateCallback? rtmpStreamingStateChanged;

  /// Occurs when the publisher's transcoding settings are updated.
  ///
  /// When the [LiveTranscoding] class in the [RtcChannel.setLiveTranscoding] method updates, the SDK triggers this callback to report the update information.
  ///
  /// **Note**
  /// - If you call the [RtcChannel.setLiveTranscoding] method to set the [LiveTranscoding] class for the first time, the SDK does not trigger this callback.
  /// The `EmptyCallback` typedef does not include any parameter.
  EmptyCallback? transcodingUpdated;

  /// Reports the status of injecting the online media stream.
  ///
  /// The `StreamInjectedStatusCallback` typedef includes the following parameters:
  /// - [String] `url`: The URL address of the externally injected stream.
  /// - [int] `uid`: User ID.
  /// - [InjectStreamStatus] `status`: State of the externally injected stream.
  StreamInjectedStatusCallback? streamInjectedStatus;

  /// Occurs when the local user receives a remote data stream.
  ///
  /// The SDK triggers this callback when the local user receives the stream message that the remote user sends by calling the [RtcChannel.sendStreamMessage] method.
  ///
  /// The `StreamMessageCallback` typedef includes the following parameters:
  /// - [int] `uid`: User ID of the remote user sending the data stream.
  /// - [int] `streamId`: Stream ID.
  /// - [String] `data`: Data received by the local user.
  StreamMessageCallback? streamMessage;

  /// Occurs when the local user fails to receive a remote data stream.
  ///
  /// The SDK triggers this callback when the local user fails to receive the stream message that the remote user sends by calling the [RtcChannel.sendStreamMessage] method.
  ///
  /// The `StreamMessageErrorCallback` callback includes the following parameters:
  /// - [int] `uid`: User ID of the remote user sending the data stream.
  /// - [int] `streamId`: Stream ID.
  /// - [ErrorCode] `error`: Error code.
  /// - [int] `missed`: The number of lost messages.
  /// - [int] `cached`: The number of incoming cached messages when the data stream is interrupted.
  StreamMessageErrorCallback? streamMessageError;

  /// Occurs when the state of the media stream relay changes.
  ///
  /// The SDK reports the state of the current media relay and possible error messages in this callback.
  ///
  /// The `MediaRelayStateCallback` typedef includes the following parameters:
  /// - [ChannelMediaRelayState] `state`: The state code.
  /// - [ChannelMediaRelayError] `code`: The error code.
  MediaRelayStateCallback? channelMediaRelayStateChanged;

  /// Reports events during the media stream relay.
  ///
  /// The `MediaRelayEventCallback` typedef includes the following parameter:
  /// - [ChannelMediaRelayEvent] `code`: The event code for media stream relay.
  MediaRelayEventCallback? channelMediaRelayEvent;

  /// Occurs when the local user receives the metadata, including the following parameters:
  /// - `buffer`: The sent or received metadata.
  /// - `uid`: ID of the user who sends the metadata.
  /// - `timeStampMs`: The timestamp of the metadata.
  ///
  /// The `MetadataCallback` typedef includes the following parameters:
  /// - [String]: `buffer`: The received metadata.
  /// - [int]: `uid`: The ID of the user who sent the metadata.
  /// - [int]: `timeStampMs`: The timestamp (ms) of the received metadata.
  MetadataCallback? metadataReceived;

  /// Occurs when the audio publishing state changes.
  ///
  /// This callback indicates the publishing state change of the local audio stream.
  ///
  /// The `StreamPublishStateCallback` typedef includes the following parameters:
  /// - [String] `channel`: The channel name.
  /// - [StreamPublishState] `oldState`: The previous publishing state. See [StreamPublishState].
  /// - [StreamPublishState] `newState`: The current publishing state. See [StreamPublishState].
  /// - [int] `elapseSinceLastState`: The time elapsed (ms) from the previous state to the current state.
  StreamPublishStateCallback? audioPublishStateChanged;

  /// Occurs when the video publishing state changes.
  ///
  /// This callback indicates the publishing state change of the local video stream.
  ///
  /// The `StreamPublishStateCallback` typedef includes the following parameters:
  /// - [String] `channel`: The channel name.
  /// - [StreamPublishState] `oldState`: The previous publishing state. See [StreamPublishState].
  /// - [StreamPublishState] `newState`: The current publishing state. See [StreamPublishState].
  /// - [int] `elapseSinceLastState`: The time elapsed (ms) from the previous state to the current state.
  StreamPublishStateCallback? videoPublishStateChanged;

  /// Occurs when the audio subscribing state changes.
  ///
  /// This callback indicates the subscribing state change of a remote audio stream.
  ///
  /// The `StreamSubscribeStateCallback` typedef includes the following parameters:
  /// - [String] `channel`: The channel name.
  /// - [StreamSubscribeState] `oldState`: The previous publishing state. See [StreamPublishState].
  /// - [StreamSubscribeState] `newState`: The current publishing state. See [StreamPublishState].
  /// - [int] `elapseSinceLastState`: The time elapsed (ms) from the previous state to the current state.
  StreamSubscribeStateCallback? audioSubscribeStateChanged;

  /// Occurs when the video subscribing state changes.
  ///
  /// This callback indicates the subscribing state change of a remote video stream.
  ///
  /// The `StreamSubscribeStateCallback` typedef includes the following parameters:
  /// - [String] `channel`: The channel name.
  /// - [StreamSubscribeState] `oldState`: The previous publishing state. See [StreamPublishState].
  /// - [StreamSubscribeState] `newState`: The current publishing state. See [StreamPublishState].
  /// - [int] `elapseSinceLastState`: The time elapsed (ms) from the previous state to the current state.
  StreamSubscribeStateCallback? videoSubscribeStateChanged;

  /// Reports events during the RTMP or RTMPS streaming.
  ///
  /// The `RtmpStreamingEventCallback` typedef includes the following parameters:
  /// - [String] `url`: The RTMP or RTMPS streaming URL.
  /// - [RtmpStreamingEvent] `eventCode`: The event code. See [RtmpStreamingEvent].
  RtmpStreamingEventCallback? rtmpStreamingEvent;

  /// @nodoc
  UserSuperResolutionEnabledCallback? userSuperResolutionEnabled;

  /// Constructs a [RtcChannelEventHandler]
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
  });

  // ignore: public_member_api_docs
  void process(String methodName, List<dynamic> data) {
    switch (methodName) {
      case 'Warning':
        warning?.call(WarningCodeConverter.fromValue(data[0]).e);
        break;
      case 'Error':
        error?.call(ErrorCodeConverter.fromValue(data[0]).e);
        break;
      case 'JoinChannelSuccess':
        joinChannelSuccess?.call(data[0], data[1], data[2]);
        break;
      case 'RejoinChannelSuccess':
        rejoinChannelSuccess?.call(data[0], data[1], data[2]);
        break;
      case 'LeaveChannel':
        leaveChannel
            ?.call(RtcStats.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'ClientRoleChanged':
        clientRoleChanged?.call(ClientRoleConverter.fromValue(data[0]).e,
            ClientRoleConverter.fromValue(data[1]).e);
        break;
      case 'UserJoined':
        userJoined?.call(data[0], data[1]);
        break;
      case 'UserOffline':
        userOffline?.call(
            data[0], UserOfflineReasonConverter.fromValue(data[1]).e);
        break;
      case 'ConnectionStateChanged':
        connectionStateChanged?.call(
            ConnectionStateTypeConverter.fromValue(data[0]).e,
            ConnectionChangedReasonConverter.fromValue(data[1]).e);
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
            VideoRemoteStateConverter.fromValue(data[1]).e,
            VideoRemoteStateReasonConverter.fromValue(data[2]).e,
            data[3]);
        break;
      case 'RemoteAudioStateChanged':
        remoteAudioStateChanged?.call(
            data[0],
            AudioRemoteStateConverter.fromValue(data[1]).e,
            AudioRemoteStateReasonConverter.fromValue(data[2]).e,
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
            NetworkQualityConverter.fromValue(data[1]).e,
            NetworkQualityConverter.fromValue(data[2]).e);
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
          RtmpStreamingStateConverter.fromValue(data[1]).e,
          RtmpStreamingErrorCodeConverter.fromValue(data[2]).e,
        );
        break;
      case 'TranscodingUpdated':
        transcodingUpdated?.call();
        break;
      case 'StreamInjectedStatus':
        streamInjectedStatus?.call(
            data[0], data[1], InjectStreamStatusConverter.fromValue(data[2]).e);
        break;
      case 'StreamMessage':
        streamMessage?.call(data[0], data[1], data[2]);
        break;
      case 'StreamMessageError':
        streamMessageError?.call(data[0], data[1],
            ErrorCodeConverter.fromValue(data[2]).e, data[3], data[4]);
        break;
      case 'ChannelMediaRelayStateChanged':
        channelMediaRelayStateChanged?.call(
          ChannelMediaRelayStateConverter.fromValue(data[0]).e,
          ChannelMediaRelayErrorConverter.fromValue(data[1]).e,
        );
        break;
      case 'ChannelMediaRelayEvent':
        channelMediaRelayEvent
            ?.call(ChannelMediaRelayEventConverter.fromValue(data[0]).e);
        break;
      case 'MetadataReceived':
        metadataReceived?.call(data[0], data[1], data[2]);
        break;
      case 'AudioPublishStateChanged':
        audioPublishStateChanged?.call(
            data[0],
            StreamPublishStateConverter.fromValue(data[1]).e,
            StreamPublishStateConverter.fromValue(data[2]).e,
            data[3]);
        break;
      case 'VideoPublishStateChanged':
        videoPublishStateChanged?.call(
            data[0],
            StreamPublishStateConverter.fromValue(data[1]).e,
            StreamPublishStateConverter.fromValue(data[2]).e,
            data[3]);
        break;
      case 'AudioSubscribeStateChanged':
        audioSubscribeStateChanged?.call(
            data[0],
            data[1],
            StreamSubscribeStateConverter.fromValue(data[2]).e,
            StreamSubscribeStateConverter.fromValue(data[3]).e,
            data[4]);
        break;
      case 'VideoSubscribeStateChanged':
        videoSubscribeStateChanged?.call(
            data[0],
            data[1],
            StreamSubscribeStateConverter.fromValue(data[2]).e,
            StreamSubscribeStateConverter.fromValue(data[3]).e,
            data[4]);
        break;
      case 'RtmpStreamingEvent':
        rtmpStreamingEvent?.call(data[0], data[1]);
        break;
      case 'UserSuperResolutionEnabled':
        userSuperResolutionEnabled?.call(data[0], data[1],
            SuperResolutionStateReasonConverter.fromValue(data[2]).e);
        break;
    }
  }
}
