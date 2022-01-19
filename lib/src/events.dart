import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'classes.dart';
import 'enum_converter.dart';
import 'enums.dart';
import 'rtc_engine.dart';

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
typedef RequestAudioFileInfoCallback = void Function(
    AudioFileInfo info, AudioFileInfoError error);
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
    int uid, int streamId, Uint8List data);
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
typedef MetadataCallback = void Function(Metadata metadata);
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
typedef VirtualBackgroundSourceEnabledCallback = void Function(
    bool enabled, VirtualBackgroundSourceStateReason reason);
typedef VideoDeviceStateChanged = void Function(
  String deviceId,
  MediaDeviceType deviceType,
  MediaDeviceStateType deviceState,
);
// ignore: public_member_api_docs
typedef AudioDeviceVolumeChanged = void Function(
  MediaDeviceType deviceType,
  int volume,
  bool muted,
);
// ignore: public_member_api_docs
typedef AudioDeviceStateChanged = void Function(
  String deviceId,
  MediaDeviceType deviceType,
  MediaDeviceStateType deviceState,
);
// ignore: public_member_api_docs
typedef RemoteAudioMixingBegin = void Function();
// ignore: public_member_api_docs
typedef RemoteAudioMixingEnd = void Function();
// ignore: public_member_api_docs
typedef RecorderStateChangedCallback = void Function(
    RecorderState state, RecorderError error);
// ignore: public_member_api_docs
typedef SnapshotTakenCallback = void Function(String channel, int uid,
    String filePath, int width, int height, int errCode);

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
  /// Param [err] The error code returned by the SDK when the method call fails. For detailed error information and troubleshooting methods, see Error Code and Warning Code.If the SDK returns 0, then the method call is successful.
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
  /// callback.
  ///
  UidWithElapsedAndChannelCallback? rejoinChannelSuccess;

  ///
  /// Occurs when a user leaves a channel.
  /// This callback notifies the app that the user leaves the channel by calling leaveChannel. From this callback, the app can get information such as the call duration and quality statistics.
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
  /// Param [oldRole] Role that the user switches from: ClientRole.
  ///
  ///
  ///
  /// Param [newRole] Role that the user switches to: ClientRole.
  ///
  ClientRoleCallback? clientRoleChanged;

  ///
  /// Occurs when a remote user (COMMUNICATION)/ host (LIVE_BROADCASTING) joins the channel.
  /// In a communication channel, this callback indicates that a remote user joins the channel. The SDK also triggers this callback to report the existing users in the channel when a user joins the channel.
  /// In a live-broadcast channel, this callback indicates that a host joins the channel. The SDK also triggers this callback to report the existing hosts in the channel when a host joins the channel. Agora recommends limiting the number of hosts to 17.
  ///
  ///   The SDK triggers this callback under one of the following circumstances:
  /// A remote user/host joins the channel by calling the joinChannel method.
  /// A remote user switches the user role to the host after joining the channel.
  /// A remote user/host rejoins the channel after a network interruption.
  ///
  /// Param [uid] The ID of the user or host who joins the channel.
  ///
  /// Param [elapsed] Time delay (ms) from the local user calling joinChannel
  /// until this callback is triggered.
  ///
  UidWithElapsedCallback? userJoined;

  ///
  /// Occurs when a remote user (COMMUNICATION)/ host (LIVE_BROADCASTING) leaves the channel.
  /// There are two reasons for users to become offline:
  /// Leave the channel: When a user/host leaves the channel, the user/host sends a goodbye message. When this message is received, the SDK determines that the user/host leaves the channel.
  /// Drop offline: When no data packet of the user or host is received for a certain period of time (20 seconds for the communication profile, and more for the live broadcast profile), the SDK assumes that the user/host drops offline. A poor network connection may lead to false detections. It's recommended to use the Agora RTM SDK for reliable offline detection.
  ///
  /// Param [uid] The ID of the user who leaves the channel or goes offline.
  ///
  /// Param [reason] Reasons why the user goes offline: UserOfflineReason.
  ///
  UserOfflineCallback? userOffline;

  ///
  /// Occurs when the network connection state changes.
  /// When the network connection state changes, the SDK triggers this callback and reports the current connection state and the reason for the change.
  ///
  /// Param [state] The current connection state. For details, see ConnectionStateType.
  ///
  /// Disconnected (1): The SDK is disconnected from Agora's edge server.
  /// Connecting (2): The SDK is connecting to Agora's edge server.
  /// Connected (3): The SDK is connected to Agora's edge server and has joined a channel.
  /// Reconnecting (4): The SDK keeps reconnecting to the Agora edge server.
  /// Failed 5: The SDK fails to connect to Agora's edge server or join the channel.
  ///
  ///
  ///
  /// Param [reason] The reason for a connection state change.
  ///
  ///
  ///
  ConnectionStateCallback? connectionStateChanged;

  ///
  /// Occurs when the local network type changes.
  /// This callback occurs when the connection state of the local user changes. You can get the connection state and reason for the state change in this callback. When the network connection is interrupted, this callback indicates whether the interruption is caused by a network type change or poor network conditions.
  ///
  /// Param [type] The type of the local network connection.
  /// For details, see NetworkType. Network type:
  /// Unknown (-1): The network type is
  /// unknown.
  /// Disconnected (0): The SDK disconnects from
  /// the network.
  /// LAN (1): The network type is LAN.
  /// WIFI (2): The network type is Wi-Fi
  /// (including hotspots).
  /// Mobile2G (3) : The network type is mobile
  /// 2G.
  /// Mobile3G (4): The network type is mobile
  /// 3G.
  /// Mobile4G (5): The network type is mobile
  /// 4G.
  ///
  ///
  NetworkTypeCallback? networkTypeChanged;

  ///
  /// Occurs when the SDK cannot reconnect to Agora's edge server 10 seconds after its connection to the server is interrupted.
  /// The SDK triggers this callback when it cannot connect to the server 10 seconds after
  /// calling the joinChannel method, regardless of whether it is in
  /// the channel. If the SDK fails to rejoin the channel 20 minutes after being
  /// disconnected from Agora's edge server, the SDK stops rejoining the channel.
  ///
  EmptyCallback? connectionLost;

  ///
  /// Occurs when the token expires in 30 seconds.
  /// When the token is about to expire in 30 seconds, the SDK triggers this callback to remind the app to renew the token.
  /// Upon receiving this callback, generate a new token on your server, and call renewToken to pass the new token to the SDK.
  ///
  /// Param [token] The token that expires in 30 seconds.
  ///
  TokenCallback? tokenPrivilegeWillExpire;

  ///
  /// Occurs when the token expires.
  /// When the token expires during a call, the SDK triggers this callback to
  /// remind the app to renew the token.
  /// Once you receive this callback, generate a new token on your app server, and call
  /// joinChannel to rejoin the channel.
  ///
  EmptyCallback? requestToken;

  ///
  /// Reports the volume information of users.
  /// By default, this callback is disabled. You can enable it by calling enableAudioVolumeIndication. Once this callback is enabled and users send streams in the channel, the SDK triggers the enableAudioVolumeIndication callback at the time interval set in audioVolumeIndication. The SDK triggers two independent audioVolumeIndication callbacks simultaneously, which separately report the volume information of the local user who sends a stream and the remote users (up to three) whose instantaneous volumes are the highest.
  /// After you enable this callback, calling muteLocalAudioStream affects the SDK's behavior as follows:
  ///   If the local user stops publishing the audio stream, the SDK stops triggering the local user's callback.
  ///   20 seconds after a remote user whose volume is one of the three highest stops publishing the audio stream, the callback excludes this user's information; 20 seconds after all remote users stop publishing audio streams, the SDK stops triggering the callback for remote users.
  ///
  /// Param [speakers] The volume information of the users, see AudioVolumeInfo. An empty speakers array in the callback indicates that no remote user is in the channel or sending a stream at the moment.
  ///
  /// Param [totalVolume]
  /// The volume of the speaker. The value range is [0,255].
  /// In the callback for the local user, totalVolume is the volume of the local user who sends a stream.
  /// In the callback for remote users, totalVolume is the sum of the volume of all remote users (up to three) whose instantaneous volumes are the highest. If the user calls startAudioMixing, then totalVolume is the volume after audio mixing.
  ///
  ///
  ///
  ///
  AudioVolumeCallback? audioVolumeIndication;

  ///
  /// Occurs when the most active speaker is detected.
  /// After a successful call of enableAudioVolumeIndication, the SDK continuously detects which remote user has the loudest volume. During the current period, the remote user, who is detected as the loudest for the most times, is the most active user.
  /// When the number of users exceeds two (included) and an active speaker is detected, the SDK triggers this callback and reports the uid of the most active speaker.
  ///   If the most active speaker remains the same, the SDK triggers the activeSpeaker callback only once.
  ///   If the most active speaker changes to another user, the SDK triggers this callback again and reports the uid of the new active speaker.
  ///
  /// Param [uid] The user ID of the most active speaker.
  ///
  UidCallback? activeSpeaker;

  ///
  /// Occurs when the engine sends the first local audio frame.
  /// Deprecated:
  ///   Please use
  /// instead.
  ///
  /// Param [elapsed] The time elapsed (ms) from the local user calling joinChannel until the SDK triggers this callback.
  ///
  @deprecated
  ElapsedCallback? firstLocalAudioFrame;

  ///
  /// Occurs when the first local video frame is rendered.
  /// The SDK triggers this callback when the first local video frame is displayed/rendered on the local video view.
  ///
  /// Param [size] The size of the first local video frame.
  ///
  /// Param [width] The width (px) of the first local video frame.
  ///
  /// Param [height] The height (px) of the first local video frame.
  ///
  /// Param [elapsed] The time elapsed (ms) from the local user calling joinChanneluntil the SDK triggers this callback. If you
  /// call startPreview before calling joinChannel, then this parameter is the time elapsed from
  /// calling the startPreview method until the SDK
  /// triggers this callback.
  ///
  VideoFrameCallback? firstLocalVideoFrame;

  ///
  /// Occurs when a remote user's video stream playback pauses/resumes.
  /// The SDK triggers this callback when the remote user stops or resumes sending the video stream by calling the muteLocalVideoStream method.
  /// This callback does not work properly when the number of users (in the COMMUNICATION profile) or hosts (in the LIVE_BROADCASTING profile) in the channel exceeds 17.
  ///
  /// Param [uid] The ID of the remote user.
  ///
  /// Param [muted] Whether the remote user's video stream playback is paused/resumed:
  /// true: Paused.
  /// false: Resumed.
  ///
  ///
  @deprecated
  UidWithMutedCallback? userMuteVideo;

  ///
  /// Occurs when the video size or rotation of a specified user changes.
  ///
  ///
  /// Param [uid] The ID of the user whose video size or rotation changes.
  /// uid is 0 for the local user.
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
  /// VideoRemoteState.
  ///
  /// Param [reason]  The reason for the remote video state
  /// change, see VideoRemoteStateReason.
  ///
  /// Param [elapsed] Time elapsed (ms) from the local user calling the joinChannel method until the SDK triggers this
  /// callback.
  ///
  RemoteVideoStateCallback? remoteVideoStateChanged;

  ///
  /// Occurs when the local video stream state changes.
  /// When the state of the local video stream changes (including the state of the video capture and encoding), the SDK triggers this callback to report the current state. This callback indicates the state of the local video stream, including camera capturing and video encoding, and allows you to troubleshoot issues when exceptions occur.
  /// The SDK triggers the localVideoStateChanged callback with the state code Failed and error code CaptureFailure in the following situations:
  /// The app switches to the background, and the system gets the camera resource.
  /// The camera starts normally, but does not output video for four consecutive seconds.
  ///
  /// When the camera outputs the captured video frames, if the video frames are the same for 15 consecutive frames, the SDK triggers the localVideoStateChanged callback with the state code Capturing and error code CaptureFailure. Note that the video frame duplication detection is only available for video frames with a resolution greater than 200 × 200, a frame rate greater than or equal to 10 fps, and a bitrate less than 20 Kbps.
  /// For some device models, the SDK does not trigger this callback when the state of the local video changes while the local video capturing device is in use, so you have to make your own timeout judgment.
  ///
  /// Param [state]
  /// The state of the local video, see LocalVideoStreamState.
  ///
  ///
  /// Stopped (0): The local video is in the initial state.
  /// Capturing (1): The local video capturing device starts successfully.
  /// Encoding (2): The first video frame is successfully encoded.
  /// Failed (3): The local video fails to start.
  ///
  ///
  ///
  ///
  /// Param [error]
  /// The detailed error information, see LocalVideoStreamError.
  ///
  ///
  LocalVideoStateCallback? localVideoStateChanged;

  ///
  /// Occurs when the remote audio state changes.
  /// When the audio state of a remote user (in the voice/video call channel) or host (in the live streaming channel) changes, the SDK triggers this callback to report the current state of the remote audio stream.
  /// This callback does not work properly when the number of users (in the voice/video call channel) or hosts (in the live streaming channel) in the channel exceeds 17.
  ///
  /// Param [uid] The ID of the remote user whose audio state changes.
  ///
  /// Param [state] The state of the remote audio, see AudioRemoteState.
  ///
  /// Param [reason] The reason of the remote audio state change, see AudioRemoteStateReason.
  ///
  /// Param [elapsed] Time elapsed (ms) from the local user calling the joinChannel method until the SDK triggers this callback.
  ///
  RemoteAudioStateCallback? remoteAudioStateChanged;

  ///
  /// Occurs when the local audio stream state changes.
  /// When the state of the local audio stream changes (including the state of the audio capture and encoding), the SDK triggers this callback to report the current state. This callback indicates the state of the local audio stream, and allows you to troubleshoot issues when audio exceptions occur.
  /// When the state isFailed (3), you can view the error information in the error parameter.
  ///
  /// Param [state] The state of the local audio. For details, see AudioLocalState.
  ///
  /// Param [error] Local audio state error codes. For details, see AudioLocalError.
  ///
  LocalAudioStateCallback? localAudioStateChanged;

  ///
  /// Reports the information of an audio file.
  /// After successfully calling getAudioFileInfo, the SDK triggers this callback to report the information of the audio file, such as the file path and duration.
  ///
  /// Param [info] The information of an audio file. See AudioFileInfo.
  ///
  /// Param [error] The information acquisition state. See AudioFileInfoError.
  @Deprecated('Use requestAudioFileInfo instead')
  RequestAudioFileInfoCallback? requestAudioFileInfoCallback;

  ///
  /// Reports the information of an audio file.
  /// After successfully calling getAudioFileInfo, the SDK triggers this callback to report the information of the audio file, such as the file path and duration.
  ///
  /// Param [info] The information of an audio file. See AudioFileInfo.
  ///
  /// Param [error] The information acquisition state. See AudioFileInfoError.
  RequestAudioFileInfoCallback? requestAudioFileInfo;

  ///
  /// Occurs when the published media stream falls back to an audio-only stream.
  /// If you call setLocalPublishFallbackOption and set option as AudioOnly, the SDK triggers this callback when the remote media stream falls back to audio-only mode due to poor uplink conditions, or when the remote media stream switches back to the video after the uplink network condition improves.
  /// If the local stream falls back to the audio-only stream, the remote user receives the userMuteVideo callback.
  ///
  /// Param [isFallbackOrRecover]
  ///
  /// true: The published stream falls
  /// back to audio-only due to poor network conditions.
  /// false: The published stream switches
  /// back to the video after the network conditions improve.
  ///
  ///
  ///
  FallbackCallback? localPublishFallbackToAudioOnly;

  ///
  /// Occurs when the remote media stream falls back to audio-only stream due to poor network conditions or switches back to the video stream after the network conditions improve.
  /// If you call setRemoteSubscribeFallbackOption and set option as AudioOnly, the SDK triggers this callback when the remote media stream falls back to audio-only mode due to poor downlink conditions, or when the remote media stream switches back to the video after the downlink network condition improves.
  /// Once the remote media stream switches to the low stream due to poor network conditions, you can monitor the stream switch between a high and low stream in the RemoteVideoStats callback.
  ///
  /// Param [uid] The ID of the remote user.
  ///
  /// Param [isFallbackOrRecover]
  ///
  ///  true: The remotely subscribed media stream falls back to audio-only due to poor network conditions.
  ///  false: The remotely subscribed media stream switches back to the video stream after the network conditions improved.
  ///
  ///
  ///
  FallbackWithUidCallback? remoteSubscribeFallbackToAudioOnly;

  ///
  /// Occurs when the local audio route changes.
  ///
  ///
  /// Param [routing] The current audio routing. For details, see AudioOutputRouting.
  /// The current audio routing. For details, see AudioOutputRouting.
  /// -1: Default audio route.
  /// 0: The audio route is a headset with a microphone.
  /// 1: The audio route is an earpiece.
  /// 2: The audio route is a headset without a microphone.
  /// 3: The audio route is the speaker that comes with the device.
  /// 4: The audio route is an external speaker.
  /// 5：The audio route is a Bluetooth headset.
  ///
  /// The current audio routing.
  /// Default (-1): The default audio route.
  /// Headset (0): The headset.
  /// Earpiece (1): The earpiece.
  /// HeadsetNoMic (2):The headset with no microphone.
  /// Speakerphone (3): The built-in speaker on a mobile device.
  /// Loudspeaker (4): The external speaker.
  /// HeadsetBluetooth (5): The bluetooth headset.
  ///
  ///
  ///
  ///
  AudioRouteCallback? audioRouteChanged;

  ///
  /// Occurs when the camera focus area changes.
  /// The SDK triggers this callback when the local user changes the camera focus position by calling setCameraFocusPositionInPreview.
  /// This method is for Android and iOS only.
  ///
  /// Param [engine] RtcEngine object.
  ///
  /// Param [rect] The focus rectangle in the local preview.
  ///
  RectCallback? cameraFocusAreaChanged;

  ///
  /// Occurs when the camera exposure area changes.
  /// The SDK triggers this callback when the local user changes the camera exposure position by calling setCameraExposurePosition.
  /// This method is for Android and iOS only.
  ///
  /// Param [engine] RtcEngine object.
  ///
  /// Param [rect] The focus rectangle in the local preview.
  ///
  RectCallback? cameraExposureAreaChanged;

  ///
  /// Reports the face detection result of the local user.
  /// Once you enable face detection by calling enableFaceDetection(true), you can get the following information on the local user in real-time:
  ///   The width and height of the local video.
  ///   The position of the human face in the local video.
  ///   The distance between the human face and the screen.
  ///
  ///
  /// The distance between the human face and the screen is based on the fitting calculation of the local video size and the position of the human face captured by the camera.
  ///
  ///
  /// If the SDK does not detect a face, it reduces the frequency of this callback to reduce power consumption on the local device.
  ///   The SDK stops triggering this callback when a human face is in close proximity to the screen.
  ///
  /// Param [imageWidth] The width (px) of the video image captured by the local camera.
  ///
  /// Param [imageHeight] The height (px) of the video image captured by the local camera.
  ///
  /// Param [faces] For the information of the detected face, see FacePositionInfo for details. If several faces are detected,
  /// this callback reports several FacePositionInfo
  /// arrays. The length of the array can be 0, which means that no human face is
  /// detected in front of the camera.
  ///
  /// Param [vecDistance] The distance between the human face and the device screen (cm).
  ///
  FacePositionCallback? facePositionChanged;

  ///
  /// Reports the statistics of the current call.
  /// The SDK triggers this callback once every two seconds after the user joins the channel.
  ///
  /// Param [stats]
  /// Statistics of the RTC engine, see RtcStats for
  /// details.
  ///
  ///
  RtcStatsCallback? rtcStats;

  ///
  /// Reports the last-mile network quality of the local user once every two seconds.
  /// This callback reports the last-mile network conditions of the local user before the user joins the channel. Last mile refers to the connection between the local device and Agora's edge server.
  /// Before the user joins the channel, this callback is triggered by the SDK once startLastmileProbeTest is called and reports the last-mile network conditions of the local user.
  ///
  /// Param [quality] The last mile network quality.
  /// Unknown (0): The quality is unknown.
  /// Excellent (1): The quality is excellent.
  /// Good (2): The network quality seems excellent, but the bitrate can be slightly lower than excellent.
  /// Poor (3): Users can feel the communication is slightly impaired.
  /// Bad (4): Users cannot communicate smoothly.
  /// VBad (5): The quality is so bad that users can barely communicate.
  /// Down (6): The network is down, and users cannot communicate at all.
  ///
  /// See
  /// NetworkQuality.
  ///
  NetworkQualityCallback? lastmileQuality;

  ///
  /// Reports the last mile network quality of each user in the channel.
  /// This callback reports the last mile network conditions of each user in the channel. Last mile refers to the connection between the local device and Agora's edge server.
  /// The SDK triggers this callback once every two seconds. If a channel includes multiple users, the SDK triggers this callback as many times.
  ///
  /// Param [uid]
  /// User ID. The network quality of the user with this user ID is
  /// reported.
  /// If the uid is 0, the local network quality is reported.
  ///
  ///
  /// Param [txQuality] Uplink network quality rating of the user in terms of the transmission bit
  /// rate, packet loss rate, average RTT (Round-Trip Time) and jitter of the
  /// uplink network. This parameter is a quality rating helping you understand
  /// how well the current uplink network conditions can support the selected
  /// video encoder configuration. For example, a 1000 Kbps uplink network may be
  /// adequate for video frames with a resolution of 640 × 480 and a frame rate of
  /// 15 fps in the LIVE_BROADCASTING profile, but might be inadequate for
  /// resolutions higher than 1280 × 720.
  /// Unknown (0): The quality is unknown.
  /// Excellent (1): The quality is excellent.
  /// Good (2): The network quality seems excellent, but the bitrate can be slightly lower than excellent.
  /// Poor (3): Users can feel the communication is slightly impaired.
  /// Bad (4): Users cannot communicate smoothly.
  /// VBad (5): The quality is so bad that users can barely communicate.
  /// Down (6): The network is down, and users cannot communicate at all.
  ///
  ///
  ///
  /// Param [rxQuality] Downlink network quality rating of the user in terms of packet loss rate,
  /// average RTT, and jitter of the downlink network.
  /// Unknown (0): The quality is unknown.
  /// Excellent (1): The quality is excellent.
  /// Good (2): The network quality seems excellent, but the bitrate can be slightly lower than excellent.
  /// Poor (3): Users can feel the communication is slightly impaired.
  /// Bad (4): Users cannot communicate smoothly.
  /// VBad (5): The quality is so bad that users can barely communicate.
  /// Down (6): The network is down, and users cannot communicate at all.
  ///
  ///
  ///
  NetworkQualityWithUidCallback? networkQuality;

  ///
  /// Reports the last mile network probe result.
  /// The SDK triggers this callback within 30 seconds after the app calls startLastmileProbeTest.
  ///
  /// Param [result] The uplink and downlink last-mile network probe test result. For details,
  /// see LastmileProbeResult.
  ///
  LastmileProbeCallback? lastmileProbeResult;

  ///
  /// Reports the statistics of the local video stream.
  /// The SDK triggers this callback once every two seconds to report the statistics of the local video stream.
  ///
  /// Param [stats] The statistics of the local video stream. For details, see LocalVideoStats.
  ///
  LocalVideoStatsCallback? localVideoStats;

  ///
  /// Reports the statistics of the local audio stream.
  /// The SDK triggers this callback once every two seconds.
  ///
  /// Param [stats] Local audio statistics. For details, see LocalAudioStats.
  ///
  LocalAudioStatsCallback? localAudioStats;

  ///
  /// Reports the transport-layer statistics of each remote video stream.
  /// Reports the statistics of the video stream from the remote users. The SDK triggers this callback once every two seconds for each remote user. If a channel has multiple users/hosts sending video streams, the SDK triggers this callback as many times.
  ///
  /// Param [stats] Statistics of the remote video stream. For details, see RemoteVideoStats.
  ///
  RemoteVideoStatsCallback? remoteVideoStats;

  ///
  /// Reports the transport-layer statistics of each remote audio stream.
  /// The SDK triggers this callback once every two seconds for each remote user who is sending audio streams. If a channel includes multiple remote users, the SDK triggers this callback as many times.
  ///
  /// Param [stats] The statistics of the received remote audio streams. See RemoteAudioStats.
  ///
  RemoteAudioStatsCallback? remoteAudioStats;

  ///
  /// Occurs when the playback of the local music file finishes.
  /// Deprecated:
  /// This method is deprecated as of v2.4.0. Use audioMixingStateChanged instead.
  ///
  ///
  /// After you call startAudioMixing to play a local music
  /// file, this callback occurs when the playback finishes. If the call of startAudioMixing fails, the callback returns the error code
  /// WARN_AUDIO_MIXING_OPEN_ERROR.
  ///
  @deprecated
  EmptyCallback? audioMixingFinished;

  ///
  /// Occurs when the playback state of the music file changes.
  /// This callback occurs when the playback state of the music file changes, and reports the current state and error code.
  ///
  /// Param [state] The playback state of the music file. For details, see AudioMixingStateCode.
  ///
  /// Playing (710): The music file is playing.
  /// Paused (711): The music file pauses playing.
  /// Stopped (713): The music file stops playing.
  /// Failed (714): An exception occurs when playing the audio mixing file. The SDK
  /// returns the reasons for the error in the reason parameter.
  /// (715):
  /// The music file is played once.
  /// (716):
  /// The music file is all played out.
  ///
  ///
  ///
  /// Param [reason] The reason why the playback state of the music file changes.
  ///
  /// CanNotOpen 701: The SDK cannot open the music file. For example, the local music file does not exist, the SDK does not support the file format, or the the SDK cannot access the music file URL.
  /// TooFrequentCall 702: The SDK opens the music file too frequently. If you need to call this method multiple times, ensure that the time interval between calling this method is more than 500 ms.
  /// InterruptedEOF (703): The music file playback is interrupted.
  /// StartedByUser (720): The music file plays by calling startAudioMixing.
  /// OneLoopCompleted(721): The music file completes a loop playback.
  /// StartNewLoop (722): The music file starts a new loop playback.
  /// AllLoopsCompleted (723): The music file completes all loop playback. .
  /// StoppedByUser (724): The music file stops playing by calling stopAudioMixing. .
  /// PausedByUser (725): The music file pauses playing by calling pauseAudioMixing. .
  /// ResumedByUser (726): The music file resumes playing by calling resumeAudioMixing. .
  ///
  ///
  ///
  ///
  AudioMixingStateCallback? audioMixingStateChanged;

  ///
  /// Occurs when the playback of the local audio effect file finishes.
  /// This callback occurs when the local audio effect file finishes playing.
  ///
  /// Param [soundId] The ID of the audio effect. Each audio effect has a unique ID.
  ///
  SoundIdCallback? audioEffectFinished;

  ///
  /// Occurs when the state of the RTMP or RTMPS streaming changes.
  /// The SDK triggers this callback to report the result of the local user calling the addPublishStreamUrl or removePublishStreamUrl method. When the RTMP/RTMPS streaming status changes, the SDK triggers this callback and report the URL address and the current status of the streaming. This callback indicates the state of the RTMP or RTMPS streaming. When exceptions occur, you can troubleshoot issues by referring to the detailed error descriptions in the error code parameter.
  ///
  /// Param [url] The CDN streaming URL.
  ///
  /// Param [state] The RTMP or RTMPS streaming state, see RtmpStreamingState. When the streaming status is Failure(4), you can view the error information in the errorCode parameter.
  ///
  /// Param [errCode] The detailed error information for streaming, see RtmpStreamingErrorCode.
  ///
  RtmpStreamingStateCallback? rtmpStreamingStateChanged;

  ///
  /// Occurs when the publisher's transcoding is updated.
  /// When the LiveTranscoding class in the setLiveTranscoding method updates, the SDK triggers the transcodingUpdated callback to report the update information.
  /// If you call the setLiveTranscoding
  /// method to set the LiveTranscoding class for the first time, the
  /// SDK does not trigger this callback.
  ///
  EmptyCallback? transcodingUpdated;

  ///
  /// Occurs when a media stream URL address is added to the interactive live streaming.
  /// Agora will soon stop the service for injecting online media streams on the client. If you have not implemented this service, Agora recommends that you do not use it. For details, see Service Sunset Plans.
  ///
  /// Param [url] The URL address of the externally injected stream.
  ///
  /// Param [uid] User ID.
  ///
  /// Param [status] State of the externally injected stream: InjectStreamStatus.
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
  /// Param [state]  The state code. For details, see ChannelMediaRelayState. The state code:
  /// Idle (0): The SDK is initializing.
  /// Connecting (1): The SDK tries to relay the
  /// media stream to the destination channel.
  /// Running (2): The SDK successfully relays the
  /// media stream to the destination channel.
  /// Failure (3): An error occurs. See `code` for
  /// the error code.
  ///
  ///
  /// Param [code]  The error code of the channel media
  /// replay. For details, see ChannelMediaRelayError.
  ///
  MediaRelayStateCallback? channelMediaRelayStateChanged;

  ///
  /// Reports events during the media stream relay.
  ///
  ///
  /// Param [code] The event code of channel media relay. See ChannelMediaRelayEvent.
  /// The event code of channel media relay:
  /// Disconnect(0): The user disconnects from the server due to a poor network connection.
  /// Connected(1): The user is connected to the server.
  /// JoinedSourceChannel(2): The user joins the source channel.
  /// JoinedDestinationChannel(3): The user joins the destination channel.
  /// SentToDestinationChannel(4): The SDK starts relaying the media stream to the destination channel.
  /// ReceivedVideoPacketFromSource(5): The server receives the video stream from the source channel.
  /// ReceivedAudioPacketFromSource(6): The server receives the audio stream from the source channel.
  /// UpdateDestinationChannel(7): The destination channel is updated.
  /// UpdateDestinationChannelRefused(8): The destination channel update fails due to internal reasons.
  /// UpdateDestinationChannelNotChange(9): The destination channel does not change, which means that the destination channel fails to be updated.
  /// UpdateDestinationChannelIsNil(10): The destination channel name is NULL.
  /// VideoProfileUpdate(11): The video profile is sent to the server.
  /// PauseSendPacketToDestChannelSuccess(12): The SDK successfully pauses relaying the media stream to destination channels.
  /// PauseSendPacketToDestChannelFailed(13): The SDK fails to pause relaying the media stream to destination channels.
  /// ResumeSendPacketToDestChannelSuccess(14): The SDK successfully resumes relaying the media stream to destination channels.
  /// ResumeSendPacketToDestChannelFailed(15): The SDK fails to resume relaying the media stream to destination channels.
  ///
  ///
  ///
  ///
  MediaRelayEventCallback? channelMediaRelayEvent;

  ///
  /// Occurs when the first remote video frame is rendered.
  /// The SDK triggers this callback when the first local video frame is displayed/rendered on the local video view.  The application can retrieve the time elapsed (the elapsed parameter) from a user joining the channel until the first video frame is displayed.
  ///
  /// Param [uid] The user ID of the remote user sending the video stream.
  ///
  /// Param [width] The width (px) of the video stream.
  ///
  /// Param [height] The height (px) of the video stream.
  ///
  /// Param [elapsed] Time elapsed (ms) from the local user calling joinChannel until the SDK triggers this callback.
  ///
  @deprecated
  VideoFrameWithUidCallback? firstRemoteVideoFrame;

  ///
  /// Occurs when the SDK receives the first audio frame from a specific remote user.
  /// Deprecated:
  ///   Please use remoteAudioStateChanged instead.
  ///
  /// Param [uid] The user ID of the remote user.
  ///
  /// Param [elapsed] The time elapsed (ms) from the local user calling joinChannel until the SDK triggers this callback.
  ///
  @deprecated
  UidWithElapsedCallback? firstRemoteAudioFrame;

  ///
  /// Occurs when the SDK decodes the first remote audio frame for playback.
  /// Deprecated:
  ///   Please use remoteAudioStateChanged instead.
  ///
  ///
  /// The SDK triggers this callback under one of the following circumstances:
  /// The remote user joins the channel and sends the audio stream for the first time.
  /// The remote user's audio is offline and then goes online to re-send audio. It means the local user cannot receive audio in 15 seconds. Reasons for such an interruption include:
  /// The remote user leaves channel.
  /// The remote user drops offline.
  /// The remote user calls muteLocalAudioStream to stop sending the audio stream.
  /// The remote user calls disableAudio to disable audio.
  ///
  /// Param [uid] The ID of the remote user.
  ///
  /// Param [elapsed] The time elapsed (ms) from the local user calling joinChannel until the SDK triggers this callback.
  ///
  @deprecated
  UidWithElapsedCallback? firstRemoteAudioDecoded;

  ///
  /// Occurs when a remote user (in the communication profile)/ host (in the live streaming profile) joins the channel.
  /// The SDK triggers this callback when the remote user stops or resumes sending the audio stream by calling the muteLocalAudioStream method.
  /// This callback does not work properly when the number of users (in the communication profile) or hosts (in the live streaming profile) in the channel exceeds 17.
  ///
  /// Param [uid] User ID.
  ///
  /// Param [muted] Whether the remote user's audio stream is muted/unmuted:
  /// true: Muted.
  /// false: Unmuted.
  ///
  ///
  ///
  @deprecated
  UidWithMutedCallback? userMuteAudio;

  ///
  /// Occurs when an RTMP or RTMPS stream is published.
  /// Deprecated:
  ///   Please use rtmpStreamingStateChanged instead.
  ///
  ///
  /// Reports the result of publishing an RTMP or RTMPS stream.
  ///
  /// Param [url] The CDN streaming URL.
  ///
  /// Param [errorCode]
  /// Error codes of the RTMP or RTMPS streaming.
  /// ERR_OK (0): The publishing succeeds.
  /// ERR_FAILED (1): The publishing fails.
  /// ERR_INVALID_ARGUMENT (-2): Invalid argument used.
  /// If you do not call setLiveTranscoding to configure
  /// LiveTranscoding before calling addPublishStreamUrl, the SDK reports
  /// ERR_INVALID_ARGUMENT.
  /// ERR_TIMEDOUT (10): The publishing timed out.
  /// ERR_ALREADY_IN_USE (19): The chosen URL address is
  /// already in use for CDN live streaming.
  /// ERR_ENCRYPTED_STREAM_NOT_ALLOWED_PUBLISH (130): You
  /// cannot publish an encrypted stream.
  /// ERR_PUBLISH_STREAM_CDN_ERROR (151): CDN related
  /// error. Remove the original URL address and add a new one by calling
  /// the removePublishStreamUrl and addPublishStreamUrl methods.
  /// ERR_PUBLISH_STREAM_NUM_REACH_LIMIT (152): The host
  /// manipulates more than 10 URLs. Delete the unnecessary URLs before
  /// adding new ones.
  /// ERR_PUBLISH_STREAM_NOT_AUTHORIZED (153): The host
  /// manipulates other hosts' URLs. Please check your app logic.
  /// ERR_PUBLISH_STREAM_INTERNAL_SERVER_ERROR (154): An
  /// error occurs in Agora's streaming server. Call the removePublishStreamUrl method to publish the streaming
  /// again.
  /// ERR_PUBLISH_STREAM_FORMAT_NOT_SUPPORTED (156): The
  /// format of the CDN streaming URL is not supported. Check whether the
  /// URL format is correct.
  ///
  ///
  ///
  @deprecated
  UrlWithErrorCallback? streamPublished;

  ///
  /// Occurs when an RTMP or RTMPS stream is removed.
  /// Deprecated:
  ///   Please use rtmpStreamingStateChanged instead.
  ///
  /// Param [url] The URL of the removed RTMP or RTMPS stream.
  ///
  @deprecated
  UrlCallback? streamUnpublished;

  ///
  /// Reports the transport-layer statistics of each remote audio stream.
  /// Deprecated:
  /// Please use remoteAudioStats instead.
  ///
  ///
  ///
  /// This callback reports the transport-layer statistics, such as the packet loss rate and network time delay, once every two seconds after the local user receives an audio packet from a remote user. During a call, when the user receives the audio packet sent by the remote user/host, the callback is triggered every 2 seconds.
  ///
  /// Param [uid] The ID of the remote user sending the audio streams.
  ///
  /// Param [delay] The network delay (ms) from the sender to the receiver.
  ///
  /// Param [lost] Packet loss rate (%) of the audio packet sent from the sender to the
  /// receiver.
  ///
  /// Param [rxKBitrate] Bitrate of the received audio (Kbps).
  ///
  @deprecated
  TransportStatsCallback? remoteAudioTransportStats;

  ///
  /// Reports the transport-layer statistics of each remote video stream.
  /// Deprecated:
  ///   Please use remoteVideoStats instead.
  ///
  ///
  /// This callback reports the transport-layer statistics, such as the packet loss rate and network time delay, once every two seconds after the local user receives a video packet from a remote user.
  /// During a call, when the user receives the video packet sent by the remote user/host, the callback is triggered every 2 seconds.
  ///
  /// Param [uid] The ID of the remote user sending the video packets.
  ///
  /// Param [delay] The network delay (ms) from the sender to the receiver.
  ///
  /// Param [lost] The packet loss rate (%) of the video packet sent from the remote user.
  ///
  /// Param [rxKBitRate] The bitrate of the received video (Kbps).
  ///
  @deprecated
  TransportStatsCallback? remoteVideoTransportStats;

  ///
  /// Occurs when a remote user enables/disables the video module.
  /// Once the video module is disabled, the user can only use a voice call. The user cannot send or receive any video.
  /// The SDK triggers this callback when a remote user enables or disables the video module by calling the enableVideo or disableVideo method.
  ///
  /// Param [uid] The user ID of the remote user.
  ///
  /// Param [enabled]
  ///
  /// true: Enable.
  /// false: Disable.
  ///
  ///
  ///
  @deprecated
  UidWithEnabledCallback? userEnableVideo;

  ///
  /// Occurs when a specific remote user enables/disables the local video capturing function.
  /// The SDK triggers this callback when the remote user resumes or stops capturing the video stream by calling the enableLocalVideo method.
  ///
  /// Param [uid] The user ID of the remote user.
  ///
  /// Param [enabled]
  /// Whether the specified remote user enables/disables the local video
  /// capturing function:
  /// true: Enable. Other users in the
  /// channel can see the video of this remote user.
  /// false: Disable. Other users in the
  /// channel can no longer receive the video stream from this remote
  /// user, while this remote user can still receive the video streams
  /// from other users.
  ///
  ///
  ///
  @deprecated
  UidWithEnabledCallback? userEnableLocalVideo;

  ///
  /// Occurs when the first remote video frame is received and decoded.
  /// Deprecated:
  ///   Please use the remoteVideoStateChanged callback with the following parameters:
  /// Starting (1).
  /// Decoding (2).
  ///
  ///
  ///
  ///
  /// The SDK triggers this callback under one of the following circumstances:
  /// The remote user joins the channel and sends the video stream.
  /// The remote user stops sending the video stream and re-sends it after 15 seconds. Reasons for such an interruption include:
  /// The remote user leaves the channel.
  /// The remote user drops offline.
  /// The remote user calls muteLocalVideoStream to stop sending the video stream.
  /// The remote user calls disableVideo to disable video.
  ///
  /// Param [uid] The user ID of the remote user sending the video stream.
  ///
  /// Param [size] Video dimensions.
  ///
  /// Param [width] The width (px) of the video stream.
  ///
  /// Param [height] The height (px) of the video stream.
  ///
  /// Param [elapsed] The time elapsed (ms) from the local user calling joinChannel until the SDK triggers this callback.
  ///
  @deprecated
  VideoFrameWithUidCallback? firstRemoteVideoDecoded;

  ///
  /// Occurs when the microphone is enabled/disabled.
  /// Deprecated:
  ///
  /// Please use the localAudioStateChanged callback:
  /// Stopped(0).
  /// Recording(1).
  ///
  ///
  ///
  ///
  /// The SDK triggers this callback when the local userenableLocalAudio resumes or stops capturing the local audio stream by calling the method.
  ///
  /// Param [enabled]
  /// Whether the microphone is enabled/disabled:
  /// true: The microphone is enabled.
  /// false: The microphone is disabled.
  ///
  ///
  ///
  @deprecated
  EnabledCallback? microphoneEnabled;

  ///
  /// Occurs when the connection between the SDK and the server is interrupted.
  /// Deprecated:
  ///   Please use connectionStateChanged instead.
  ///
  ///
  /// The SDK triggers this callback when it loses connection with the server for more than four seconds after the connection is established. After triggering this callback, the SDK tries to reconnect to the server. You can use this callback to implement pop-up reminders. The difference between this callback and connectionLost is:
  /// The SDK triggers the connectionInterrupted callback when it loses connection with the server for more than four seconds after it successfully joins the channel.
  /// The SDK triggers the connectionLost callback when it loses connection with the server for more than 10 seconds, whether or not it joins the channel.
  /// If the SDK fails to rejoin the channel 20 minutes after being disconnected from Agora's edge server, the SDK stops rejoining the channel.
  ///
  @deprecated
  EmptyCallback? connectionInterrupted;

  ///
  /// Occurs when the connection is banned by the Agora server.
  /// Deprecated:
  /// Please use connectionStateChanged instead.
  ///
  @deprecated
  EmptyCallback? connectionBanned;

  ///
  /// Reports the statistics of the audio stream from each remote user.
  /// Deprecated:
  /// remoteAudioStats instead.
  ///
  ///
  ///
  /// The SDK triggers this callback once every two seconds to report the audio quality of each remote user/host sending an audio stream. If a channel has multiple users/hosts sending audio streams, the SDK triggers this callback as many times.
  ///
  /// Param [uid] The user ID of the remote user sending the audio stream.
  ///
  /// Param [quality] Audio quality of the user.
  /// Unknown (0): The quality is unknown.
  /// Excellent (1): The quality is excellent.
  /// Good (2): The network quality seems excellent, but the bitrate can be slightly lower than excellent.
  /// Poor (3): Users can feel the communication is slightly impaired.
  /// Bad (4): Users cannot communicate smoothly.
  /// VBad (5): The quality is so bad that users can barely communicate.
  /// Down (6): The network is down, and users cannot communicate at all.
  ///
  ///
  ///
  /// Param [delay] The network delay (ms) from the sender to the receiver, including the delay
  /// caused by audio sampling pre-processing, network transmission, and network
  /// jitter buffering.
  ///
  /// Param [lost] Packet loss rate (%) of the audio packet sent from the sender to the
  /// receiver.
  ///
  @deprecated
  AudioQualityCallback? audioQuality;

  ///
  /// Occurs when the camera turns on and is ready to capture the video.
  /// Deprecated:
  ///
  /// Please use Capturing(1) in
  /// instead.
  ///
  ///
  ///
  /// This callback indicates that the camera has been successfully turned on and
  /// you can start to capture video.
  ///
  @deprecated
  EmptyCallback? cameraReady;

  ///
  /// Occurs when the video stops playing.
  /// Deprecated:
  /// Please use Stopped(0) in the
  /// callback instead.
  ///
  ///
  /// The application can use this callback to change the configuration of the
  /// view (for example, displaying other pictures in the view) after
  /// the video stops playing.
  ///
  @deprecated
  EmptyCallback? videoStopped;

  ///
  /// Occurs when the local user receives the metadata.
  ///
  ///
  /// Param [buffer] The data received.
  ///
  /// Param [uid] The user ID.
  ///
  /// Param [timeStampMs] The timestamp.
  ///
  MetadataCallback? metadataReceived;

  ///
  /// Occurs when the first audio frame is published.
  /// The SDK triggers this callback under one of the following circumstances:
  /// The local client enables the audio module and calls joinChannel successfully.
  /// The local client calls muteLocalAudioStream(true) and muteLocalAudioStream(false) in sequence.
  /// The local client calls disableAudio and enableAudio in sequence.
  /// The local client calls  to successfully push the audio frame to the SDK.
  /// The local client calls  to successfully push the audio frame to the SDK.
  ///
  /// Param [elapsed] The time elapsed (ms) from the local client calling joinChannel until the SDK triggers this callback.
  ///
  ElapsedCallback? firstLocalAudioFramePublished;

  ///
  /// Occurs when the first video frame is published.
  /// The SDK triggers this callback under one of the following circumstances:
  ///   The local client enables the video module and calls joinChannel successfully.
  ///   The local client calls muteLocalVideoStream(true) and muteLocalVideoStream(false) in sequence.
  ///   The local client calls disableVideo and enableVideo in sequence.
  /// The local client calls  to successfully push the video frame to the SDK.
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
  /// Param [oldState] For the previous publishing state, see StreamPublishState.
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
  /// Param [oldState] For the previous publishing state, see StreamPublishState.
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
  /// Param [oldState] The previous subscribing status, see StreamSubscribeState
  /// for details.
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
  /// for details.
  ///
  /// Param [newState] The current subscribing status, see StreamSubscribeState for details.
  ///
  /// Param [elapseSinceLastState] The time elapsed (ms) from the previous state to the current state.
  ///
  StreamSubscribeStateCallback? videoSubscribeStateChanged;

  ///
  /// Reports events during the RTMP or RTMPS streaming.
  ///
  ///
  /// Param [url] The RTMP or RTMPS streaming URL.
  ///
  /// Param [eventCode] The event code of the streaming. For details, see RtmpStreamingEvent.
  ///
  RtmpStreamingEventCallback? rtmpStreamingEvent;

  ///
  /// Reports whether the super resolution feature is successfully enabled.
  /// After calling enableRemoteSuperResolution, the SDK triggers the callback to report whether super resolution is successfully enabled. If it is not successfully enabled, use reason for troubleshooting.
  ///
  /// Param [uid] The ID of the remote user.
  ///
  /// Param [enabled] Whether super resolution is successfully enabled:
  /// true: Super resolution is successfully enabled.
  /// false: Super resolution is not successfully enabled.
  ///
  ///
  /// Param [reason] The reason why super resolution algorithm is not successfully enabled. For details, see SuperResolutionStateReason.
  ///
  UserSuperResolutionEnabledCallback? userSuperResolutionEnabled;

  ///
  /// Reports the result of uploading the SDK log files.
  /// Since
  ///   v3.3.0
  ///
  ///
  /// After uploadLogFile is called, the SDK triggers the callback to report the result of uploading the SDK log files. If the upload fails, refer to the reason parameter to troubleshoot.
  ///
  /// Param [requestId] The request ID. The request ID is the same as the requestId returned in uploadLogFile. You can use the requestId to match a specific upload with a callback.
  ///
  /// Param [success] Whether the log file is uploaded successfully:
  /// true: Successfully upload the log files.
  /// false: Fails to upload the log files. For details, see the reason parameter.
  ///
  ///
  /// Param [reason] The reason for the upload failure. For details, see UploadErrorReason.
  ///
  UploadLogResultCallback? uploadLogResult;

  /* callback-engine-airPlayIsConnected */
  @Deprecated('Use airPlayConnected instead')
  EmptyCallback? airPlayIsConnected;

  EmptyCallback? airPlayConnected;

  ///
  /// Reports whether virtual background is successfully enabled. (Beta feature)
  /// After you call enableVirtualBackground, the SDK triggers this callback to report whether virtual background is successfully enabled.
  /// If the background image customized in the virtual background is in the PNG or JPG format, this callback is triggered after the image is read.
  ///
  /// Param [enabled] Whether virtual background is successfully enabled:
  /// true: Virtual background is successfully enabled.
  /// false: Virtual background is not successfully enabled.
  ///
  ///
  /// Param [reason] The reason why virtual background is not successfully enabled. See VirtualBackgroundSourceStateReason.
  ///
  VirtualBackgroundSourceEnabledCallback? virtualBackgroundSourceEnabled;

  ///
  /// Occurs when the video device state changes.
  /// This callback reports the change of system video devices, such as being unplugged or removed. On a Windows device with an external camera for video capturing, the video disables once the external camera is unplugged.
  ///
  /// Param [deviceId] The device ID.
  ///
  /// Param [deviceType] Media device types. For details, see MediaDeviceType.
  ///
  /// Param [deviceState] Media device states. For details, see MediaDeviceStateType.
  ///
  VideoDeviceStateChanged? videoDeviceStateChanged;

  ///
  /// Occurs when the volume on the playback or audio capture device, or the volume in the application changes.
  ///
  ///
  /// Param [deviceType] The device type. For details, see MediaDeviceType.
  ///
  /// Param [volume] The volume value. The range is [0, 255].
  ///
  /// Param [muted] Whether the audio device is muted:
  /// true: The audio device is muted.
  /// false: The audio device is not muted.
  ///
  ///
  AudioDeviceVolumeChanged? audioDeviceVolumeChanged;

  ///
  /// Occurs when the audio device state changes.
  /// This callback notifies the application that the system's audio device state is changed. For example, a headset is unplugged from the device.
  /// This method is for Windows and macOS only.
  ///
  /// Param [deviceId] The device ID.
  ///
  /// Param [deviceType] The device type. For details, see MediaDeviceType.
  ///
  /// Param [deviceState] The device state.
  /// on macOS:
  /// 0: The device is ready for use.
  /// 8: The device is not connected.
  ///
  /// On Windows: MediaDeviceStateType.
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
  /// takeSnapshot method call, the SDK triggers this callback to report whether the snapshot is successfully taken as well as the details for the snapshot taken.
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
  /// 0: Success.
  /// < 0: Failure:
  /// -1: The SDK fails to write data to a file or encode a JPEG image.
  /// -2: The SDK does not find the video stream of the specified user within one second after the takeSnapshot method call succeeds.
  ///
  ///
  ///
  /// Since
  /// v3.5.2
  /// After a successful takeSnapshot method call, the SDK triggers this callback
  /// to report whether the snapshot is successfully taken as well as the details
  /// for the snapshot taken.
  ///
  /// Parameters
  /// - channel	The channel name.
  /// - uid	The user ID of the user. A uid of 0 indicates the local user.
  /// - filePath	The local path of the snapshot.
  /// - width	The width (px) of the snapshot.
  /// - height	The height (px) of the snapshot.
  /// - errCode	The message that confirms success or the reason why the snapshot
  /// is not successfully taken:
  ///     - 0: Success.
  ///     - < 0: Failure.
  ///     - -1: The SDK fails to write data to a file or encode a JPEG image.
  ///     - -2: The SDK does not find the video stream of the specified user within
  /// one second after the takeSnapshot method call succeeds.
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
  });

  // ignore: public_member_api_docs
  void process(String methodName, dynamic data, [Uint8List? buffer]) {
    List<dynamic> newData;
    // if (kIsWeb || (Platform.isWindows || Platform.isMacOS)) {

    // } else {
    //   newData = List<dynamic>.from(data);
    // }
    if (methodName.startsWith('on')) {
      methodName = methodName.substring(2);
    }

    newData = List<dynamic>.from(
        Map<String, dynamic>.from(jsonDecode(data as String)).values);
    switch (methodName) {
      case 'Warning':
        warning?.call(WarningCodeConverter.fromValue(newData[0]).e);
        break;
      case 'Error':
        error?.call(ErrorCodeConverter.fromValue(newData[0]).e);
        break;
      case 'ApiCallExecuted':
        apiCallExecuted?.call(
            ErrorCodeConverter.fromValue(newData[0]).e, newData[1], newData[2]);
        break;
      case 'JoinChannelSuccess':
        joinChannelSuccess?.call(newData[0], newData[1], newData[2]);
        break;
      case 'RejoinChannelSuccess':
        rejoinChannelSuccess?.call(newData[0], newData[1], newData[2]);
        break;
      case 'LeaveChannel':
        leaveChannel
            ?.call(RtcStats.fromJson(Map<String, dynamic>.from(newData[0])));
        break;
      case 'LocalUserRegistered':
        localUserRegistered?.call(newData[0], newData[1]);
        break;
      case 'UserInfoUpdated':
        userInfoUpdated?.call(newData[0],
            UserInfo.fromJson(Map<String, dynamic>.from(newData[1])));
        break;
      case 'ClientRoleChanged':
        clientRoleChanged?.call(ClientRoleConverter.fromValue(newData[0]).e,
            ClientRoleConverter.fromValue(newData[1]).e);
        break;
      case 'UserJoined':
        userJoined?.call(newData[0], newData[1]);
        break;
      case 'UserOffline':
        userOffline?.call(
            newData[0], UserOfflineReasonConverter.fromValue(newData[1]).e);
        break;
      case 'ConnectionStateChanged':
        connectionStateChanged?.call(
            ConnectionStateTypeConverter.fromValue(newData[0]).e,
            ConnectionChangedReasonConverter.fromValue(newData[1]).e);
        break;
      case 'NetworkTypeChanged':
        networkTypeChanged?.call(NetworkTypeConverter.fromValue(newData[0]).e);
        break;
      case 'ConnectionLost':
        connectionLost?.call();
        break;
      case 'TokenPrivilegeWillExpire':
        tokenPrivilegeWillExpire?.call(newData[0]);
        break;
      case 'RequestToken':
        requestToken?.call();
        break;
      case 'AudioVolumeIndication':
        final list = List<Map>.from(newData[0]);
        var totalVolume;
        // if (kIsWeb || (Platform.isWindows || Platform.isMacOS)) {

        // } else {
        //   totalVolume = newData[2];
        // }
        totalVolume = newData[2];
        audioVolumeIndication?.call(
            List.generate(
                list.length,
                (index) => AudioVolumeInfo.fromJson(
                    Map<String, dynamic>.from(list[index]))),
            totalVolume);
        break;
      case 'ActiveSpeaker':
        activeSpeaker?.call(newData[0]);
        break;
      case 'FirstLocalAudioFrame':
        firstLocalAudioFrame?.call(newData[0]);
        break;
      case 'FirstLocalVideoFrame':
        firstLocalVideoFrame?.call(newData[0], newData[1], newData[2]);
        break;
      case 'UserMuteVideo':
        userMuteVideo?.call(newData[0], newData[1]);
        break;
      case 'VideoSizeChanged':
        videoSizeChanged?.call(newData[0], newData[1], newData[2], newData[3]);
        break;
      case 'RemoteVideoStateChanged':
        remoteVideoStateChanged?.call(
            newData[0],
            VideoRemoteStateConverter.fromValue(newData[1]).e,
            VideoRemoteStateReasonConverter.fromValue(newData[2]).e,
            newData[3]);
        break;
      case 'LocalVideoStateChanged':
        localVideoStateChanged?.call(
            LocalVideoStreamStateConverter.fromValue(newData[0]).e,
            LocalVideoStreamErrorConverter.fromValue(newData[1]).e);
        break;
      case 'RemoteAudioStateChanged':
        remoteAudioStateChanged?.call(
            newData[0],
            AudioRemoteStateConverter.fromValue(newData[1]).e,
            AudioRemoteStateReasonConverter.fromValue(newData[2]).e,
            newData[3]);
        break;
      case 'LocalAudioStateChanged':
        localAudioStateChanged?.call(
            AudioLocalStateConverter.fromValue(newData[0]).e,
            AudioLocalErrorConverter.fromValue(newData[1]).e);
        break;
      case 'RequestAudioFileInfo':
        requestAudioFileInfoCallback?.call(AudioFileInfo.fromJson(newData[0]),
            AudioFileInfoErrorConverter.fromValue(newData[1]).e);

        requestAudioFileInfo?.call(AudioFileInfo.fromJson(newData[0]),
            AudioFileInfoErrorConverter.fromValue(newData[1]).e);
        break;
      case 'LocalPublishFallbackToAudioOnly':
        localPublishFallbackToAudioOnly?.call(newData[0]);
        break;
      case 'RemoteSubscribeFallbackToAudioOnly':
        remoteSubscribeFallbackToAudioOnly?.call(newData[0], newData[1]);
        break;
      case 'AudioRouteChanged':
        audioRouteChanged
            ?.call(AudioOutputRoutingConverter.fromValue(newData[0]).e);
        break;
      case 'CameraFocusAreaChanged':
        if (cameraFocusAreaChanged != null) {
          // TODO(littlegnal): Optimize this logic
          final rect = Rect(); // Rect.fromJson(newData[0]);
          rect.x = newData[0];
          rect.y = newData[1];
          rect.width = newData[2];
          rect.height = newData[3];
          // ignore: deprecated_member_use_from_same_package
          rect.left = rect.x;
          // ignore: deprecated_member_use_from_same_package
          rect.top = rect.y;
          // ignore: deprecated_member_use_from_same_package
          rect.right = rect.x + rect.width;
          // ignore: deprecated_member_use_from_same_package
          rect.bottom = rect.y + rect.height;
          cameraFocusAreaChanged!(rect);
        }

        break;
      case 'CameraExposureAreaChanged':
        if (cameraExposureAreaChanged != null) {
          // TODO(littlegnal): Optimize this logic
          final rect = Rect(); // Rect.fromJson(newData[0]);
          rect.x = newData[0];
          rect.y = newData[1];
          rect.width = newData[2];
          rect.height = newData[3];
          // ignore: deprecated_member_use_from_same_package
          rect.left = rect.x;
          // ignore: deprecated_member_use_from_same_package
          rect.top = rect.y;
          // ignore: deprecated_member_use_from_same_package
          rect.right = rect.x + rect.width;
          // ignore: deprecated_member_use_from_same_package
          rect.bottom = rect.y + rect.height;
          cameraExposureAreaChanged!(rect);
        }
        break;
      case 'FacePositionChanged':
        if (facePositionChanged != null) {
          final rectList = List<Map>.from(newData[2]);
          final distanceList = List<int>.from(newData[3]);
          final faceInfos = List.generate(
            rectList.length,
            (index) {
              final rect = rectList[index];
              rect['distance'] = distanceList[index];
              final info =
                  FacePositionInfo.fromJson(Map<String, dynamic>.from(rect));
              return info;
            },
          );
          facePositionChanged!(newData[0], newData[1], faceInfos);
        }

        break;
      case 'RtcStats':
        rtcStats
            ?.call(RtcStats.fromJson(Map<String, dynamic>.from(newData[0])));
        break;
      case 'LastmileQuality':
        lastmileQuality?.call(NetworkQualityConverter.fromValue(newData[0]).e);
        break;
      case 'NetworkQuality':
        networkQuality?.call(
            newData[0],
            NetworkQualityConverter.fromValue(newData[1]).e,
            NetworkQualityConverter.fromValue(newData[2]).e);
        break;
      case 'LastmileProbeResult':
        lastmileProbeResult?.call(LastmileProbeResult.fromJson(
            Map<String, dynamic>.from(newData[0])));
        break;
      case 'LocalVideoStats':
        localVideoStats?.call(
            LocalVideoStats.fromJson(Map<String, dynamic>.from(newData[0])));
        break;
      case 'LocalAudioStats':
        localAudioStats?.call(
            LocalAudioStats.fromJson(Map<String, dynamic>.from(newData[0])));
        break;
      case 'RemoteVideoStats':
        remoteVideoStats?.call(
            RemoteVideoStats.fromJson(Map<String, dynamic>.from(newData[0])));
        break;
      case 'RemoteAudioStats':
        remoteAudioStats?.call(
            RemoteAudioStats.fromJson(Map<String, dynamic>.from(newData[0])));
        break;
      case 'AudioMixingFinished':
        audioMixingFinished?.call();
        break;
      case 'AudioMixingStateChanged':
        audioMixingStateChanged?.call(
          AudioMixingStateCodeConverter.fromValue(newData[0]).e,
          AudioMixingReasonConverter.fromValue(newData[1]).e,
        );
        break;
      case 'AudioEffectFinished':
        audioEffectFinished?.call(newData[0]);
        break;
      case 'RtmpStreamingStateChanged':
        rtmpStreamingStateChanged?.call(
          newData[0],
          RtmpStreamingStateConverter.fromValue(newData[1]).e,
          RtmpStreamingErrorCodeConverter.fromValue(newData[2]).e,
        );
        break;
      case 'TranscodingUpdated':
        transcodingUpdated?.call();
        break;
      case 'StreamInjectedStatus':
        streamInjectedStatus?.call(newData[0], newData[1],
            InjectStreamStatusConverter.fromValue(newData[2]).e);
        break;
      case 'StreamMessage':
        // if (kIsWeb || (Platform.isWindows || Platform.isMacOS)) {

        // } else {
        //   String data = newData[2];
        //   streamMessage?.call(
        //       newData[0], newData[1], Uint8List.fromList(data.codeUnits));
        // }
        if (buffer == null) return;
        streamMessage?.call(newData[0], newData[1], buffer);
        break;
      case 'StreamMessageError':
        streamMessageError?.call(newData[0], newData[1],
            ErrorCodeConverter.fromValue(newData[2]).e, newData[3], newData[4]);
        break;
      case 'MediaEngineLoadSuccess':
        mediaEngineLoadSuccess?.call();
        break;
      case 'MediaEngineStartCallSuccess':
        mediaEngineStartCallSuccess?.call();
        break;
      case 'ChannelMediaRelayStateChanged':
        channelMediaRelayStateChanged?.call(
          ChannelMediaRelayStateConverter.fromValue(newData[0]).e,
          ChannelMediaRelayErrorConverter.fromValue(newData[1]).e,
        );
        break;
      case 'ChannelMediaRelayEvent':
        channelMediaRelayEvent
            ?.call(ChannelMediaRelayEventConverter.fromValue(newData[0]).e);
        break;
      case 'FirstRemoteVideoFrame':
        firstRemoteVideoFrame?.call(
            newData[0], newData[1], newData[2], newData[3]);
        break;
      case 'FirstRemoteAudioFrame':
        firstRemoteAudioFrame?.call(newData[0], newData[1]);
        break;
      case 'FirstRemoteAudioDecoded':
        firstRemoteAudioDecoded?.call(newData[0], newData[1]);
        break;
      case 'UserMuteAudio':
        userMuteAudio?.call(newData[0], newData[1]);
        break;
      case 'StreamPublished':
        streamPublished?.call(
            newData[0], ErrorCodeConverter.fromValue(newData[1]).e);
        break;
      case 'StreamUnpublished':
        streamUnpublished?.call(newData[0]);
        break;
      case 'RemoteAudioTransportStats':
        remoteAudioTransportStats?.call(
            newData[0], newData[1], newData[2], newData[3]);
        break;
      case 'RemoteVideoTransportStats':
        remoteVideoTransportStats?.call(
            newData[0], newData[1], newData[2], newData[3]);
        break;
      case 'UserEnableVideo':
        userEnableVideo?.call(newData[0], newData[1]);
        break;
      case 'UserEnableLocalVideo':
        userEnableLocalVideo?.call(newData[0], newData[1]);
        break;
      case 'FirstRemoteVideoDecoded':
        firstRemoteVideoDecoded?.call(
            newData[0], newData[1], newData[2], newData[3]);
        break;
      case 'MicrophoneEnabled':
        microphoneEnabled?.call(newData[0]);
        break;
      case 'ConnectionInterrupted':
        connectionInterrupted?.call();
        break;
      case 'ConnectionBanned':
        connectionBanned?.call();
        break;
      case 'AudioQuality':
        audioQuality?.call(newData[0], newData[1], newData[2], newData[3]);
        break;
      case 'CameraReady':
        cameraReady?.call();
        break;
      case 'VideoStopped':
        videoStopped?.call();
        break;
      case 'MetadataReceived':
        Metadata metadata;
        // if (kIsWeb || (Platform.isWindows || Platform.isMacOS)) {

        // } else {
        //   metadata = Metadata(newData[1], newData[2]);
        //   String buffer = newData[0];
        //   metadata.buffer = Uint8List.fromList(buffer.codeUnits);
        // }
        if (buffer == null) return;
        metadata = Metadata.fromJson(Map<String, dynamic>.from(newData[0]));
        metadata.buffer = buffer;
        metadataReceived?.call(metadata);
        break;
      case 'FirstLocalAudioFramePublished':
        firstLocalAudioFramePublished?.call(newData[0]);
        break;
      case 'FirstLocalVideoFramePublished':
        firstLocalVideoFramePublished?.call(newData[0]);
        break;
      case 'AudioPublishStateChanged':
        audioPublishStateChanged?.call(
            newData[0],
            StreamPublishStateConverter.fromValue(newData[1]).e,
            StreamPublishStateConverter.fromValue(newData[2]).e,
            newData[3]);
        break;
      case 'VideoPublishStateChanged':
        videoPublishStateChanged?.call(
            newData[0],
            StreamPublishStateConverter.fromValue(newData[1]).e,
            StreamPublishStateConverter.fromValue(newData[2]).e,
            newData[3]);
        break;
      case 'AudioSubscribeStateChanged':
        audioSubscribeStateChanged?.call(
            newData[0],
            newData[1],
            StreamSubscribeStateConverter.fromValue(newData[2]).e,
            StreamSubscribeStateConverter.fromValue(newData[3]).e,
            newData[4]);
        break;
      case 'VideoSubscribeStateChanged':
        videoSubscribeStateChanged?.call(
            newData[0],
            newData[1],
            StreamSubscribeStateConverter.fromValue(newData[2]).e,
            StreamSubscribeStateConverter.fromValue(newData[3]).e,
            newData[4]);
        break;
      case 'RtmpStreamingEvent':
        rtmpStreamingEvent?.call(
          newData[0],
          RtmpStreamingEventConverter.fromValue(newData[1]).e,
        );
        break;
      case 'UserSuperResolutionEnabled':
        userSuperResolutionEnabled?.call(newData[0], newData[1],
            SuperResolutionStateReasonConverter.fromValue(newData[2]).e);
        break;
      case 'UploadLogResult':
        uploadLogResult?.call(newData[0], newData[1],
            UploadErrorReasonConverter.fromValue(newData[2]).e);
        break;
      case 'VideoDeviceStateChanged':
        videoDeviceStateChanged?.call(
          newData[0] as String,
          MediaDeviceTypeConverter.fromValue(newData[1]).e,
          MediaDeviceStateTypeConverter.fromValue(newData[2]).e,
        );
        break;
      case 'AudioDeviceVolumeChanged':
        audioDeviceVolumeChanged?.call(
          MediaDeviceTypeConverter.fromValue(newData[0]).e,
          newData[1] as int,
          newData[2] as bool,
        );
        break;
      case 'AudioDeviceStateChanged':
        audioDeviceStateChanged?.call(
          newData[0] as String,
          MediaDeviceTypeConverter.fromValue(newData[1]).e,
          MediaDeviceStateTypeConverter.fromValue(newData[2]).e,
        );
        break;
      case 'RemoteAudioMixingBegin':
        remoteAudioMixingBegin?.call();
        break;
      case 'RemoteAudioMixingEnd':
        remoteAudioMixingEnd?.call();
        break;
      case 'AirPlayConnected':
        airPlayIsConnected?.call();

        airPlayConnected?.call();
        break;
      case 'VirtualBackgroundSourceEnabled':
        virtualBackgroundSourceEnabled?.call(
            newData[0],
            VirtualBackgroundSourceStateReasonConverter.fromValue(newData[1])
                .e);
        break;
      case 'SnapshotTaken':
        snapshotTaken?.call(newData[0], newData[1], newData[2], newData[3],
            newData[4], newData[5]);
        break;
      default:
        throw ArgumentError('Not Supported Event: $methodName');
    }
  }
}

///
/// The SDK uses RtcChannelEventHandler to send RtcChannel event notifications to your app.
///
///
class RtcChannelEventHandler {
  ///
  /// Reports the warning code of RtcChannel.
  ///
  ///
  /// Param [rtcChannel] RtcChannel.
  ///
  /// Param [warn] Warning codes. For details, see Error Codes and Warning Codes.
  ///
  /// Param [msg] The warning message.
  ///
  WarningCallback? warning;

  ///
  /// The error code RtcChannel reported.
  ///
  ///
  /// Param [rtcChannel] RtcChannel.
  ///
  /// Param [err] The error code. For details, see Error Codes and Warning Codes.
  ///
  /// Param [msg] The error message.
  ///
  ErrorCallback? error;

  ///
  /// Occurs when a user joins a channel.
  /// This callback notifies the application that a user joins a specified channel.
  ///
  /// Param [channelId] The channel ID.
  ///
  /// Param [uid] User ID. If you have specified a user ID in joinChannel, the ID will be returned here; otherwise, the SDK returns an ID automatically assigned by the Agora server.
  ///
  /// Param [elapsed] The time elapsed (in milliseconds) from the local user calling joinChannel till this event.
  ///
  UidWithElapsedAndChannelCallback? joinChannelSuccess;

  ///
  /// Occurs when a user rejoins the channel.
  /// When a user loses connection with the server because of network problems, the SDK automatically tries to reconnect and triggers this callback upon reconnection.
  ///
  /// Param [elapsed] Time elapsed (ms) from starting to reconnect until the SDK triggers this
  /// callback.
  ///
  /// Param [uid] The ID of the user who rejoins the channel.
  ///
  /// Param [rtcChannel] RtcChannel.
  ///
  UidWithElapsedAndChannelCallback? rejoinChannelSuccess;

  ///
  /// Occurs when a user leaves a channel.
  /// When a user leaves the channel by using the leaveChannel method, the SDK uses this callback to notify the app when the user leaves the channel. With this callback, the app gets the channel information, such as the call duration and quality statistics.
  ///
  /// Param [stats] The statistics of the call, see RtcStats .
  ///
  /// Param [rtcChannel] RtcChannel.
  ///
  RtcStatsCallback? leaveChannel;

  ///
  /// Occurs when the user role switches in the interactive live streaming.
  /// The SDK triggers this callback when the local user changes the user role after joining the channel.
  ///
  /// Param [newRole] Role that the user switches to: ClientRole.
  ///
  ///
  ///
  /// Param [oldRole] Role that the user switches from: ClientRole.
  ///
  ///
  ///
  /// Param [rtcChannel] RtcChannel.
  ///
  ClientRoleCallback? clientRoleChanged;

  ///
  /// Occurs when a remote user (COMMUNICATION)/ host (LIVE_BROADCASTING) joins the channel.
  /// In a communication channel, this callback indicates that a remote user joins the channel. The SDK also triggers this callback to report the existing users in the channel when a user joins the channel.
  /// In a live-broadcast channel, this callback indicates that a host joins the channel. The SDK also triggers this callback to report the existing hosts in the channel when a host joins the channel. Agora recommends limiting the number of hosts to 17.
  ///
  ///   The SDK triggers this callback under one of the following circumstances:
  ///   A remote user/host joins the channel by calling the joinChannel method.
  ///   A remote user switches the user role to the host after joining the channel.
  ///   A remote user/host rejoins the channel after a network interruption.
  ///   The host injects an online media stream into the channel by calling the addInjectStreamUrl method.
  ///
  /// Param [uid] The ID of the user or host who joins the channel.
  ///
  /// Param [rtcChannel] RtcChannel.
  ///
  /// Param [elapsed] Time delay (ms) fromthe local user calling joinChannel until this callback is triggered.
  ///
  UidWithElapsedCallback? userJoined;

  ///
  /// Occurs when a remote user (COMMUNICATION)/ host (LIVE_BROADCASTING) leaves the channel.
  /// There are two reasons for users to become offline:
  /// Leave the channel: When a user/host leaves the channel, the user/host sends a goodbye message. When this message is received, the SDK determines that the user/host leaves the channel.
  /// Drop offline: When no data packet of the user or host is received for a certain period of time (20 seconds for the communication profile, and more for the live broadcast profile), the SDK assumes that the user/host drops offline. A poor network connection may lead to false detections. It's recommended to use the Agora RTM SDK for reliable offline detection.
  ///
  /// Param [reason] Reasons why the user goes offline: UserOfflineReason. Reasons why a
  /// remote user (COMMUNICATION) or a host (LIVE_BROADCASTING) goes offline:
  /// Quit (0): The user has quit the call. When
  /// the user leaves the channel, the user sends a goodbye message. When this
  /// message is received, the SDK determines that the user leaves the
  /// channel.
  /// Dropped (1): The SDK timed out and the user
  /// dropped offline because it has not received any data package within a
  /// certain period of time. A poor network connection may lead to false
  /// detection, so we recommend using the RTM SDK for reliable offline
  /// detection.
  /// BecomeAudience (2): The user switches the
  /// user role from a broadcaster to an audience.
  ///
  ///
  /// Param [uid] The ID of the user who leaves the channel or goes offline.
  ///
  /// Param [rtcChannel] RtcChannel.
  ///
  UserOfflineCallback? userOffline;

  ///
  /// Occurs when the network connection state changes.
  /// When the network connection state changes, the SDK triggers this callback and reports the current connection state and the reason for the change.
  ///
  /// Param [reason] The reason for a connection state change. For details, see ConnectionChangedReason.
  ///
  ///
  /// Connecting (0): The SDK is connecting to Agora's edge server.
  /// JoinSuccess (1): The SDK has joined the channel successfully.
  /// Interrupted (2): The connection between the SDK and Agora's edge server is interrupted.
  /// BannedByServer (3): The connection between the SDK and Agora's edge server is banned by Agora's edge server.
  /// JoinFailed (4): The SDK fails to join the channel.
  /// LeaveChannel (5): The SDK has left the channel.
  /// InvalidAppId (6): The connection failed because the App ID is not valid. Please rejoin the channel with a valid App ID.
  /// InvalidChannelName (7): The connection failed because the channel name is not valid. Please rejoin the channel with a valid channel name.
  /// InvalidToken (8): The connection failed because the token is not valid. Typical reasons include:
  /// The App Certificate for the project is enabled in Agora Console, but you do not use a token when joining the channel. If you enable the App Certificate, you must use a token to join the channel.
  /// The uid specified when calling  to join the channel is inconsistent with the uid passed in when generating the token.
  ///
  ///
  /// TokenExpired (9): The token has expired. You need to generate a new token from your server.
  /// RejectedByServer (10): The user is banned by the server.
  /// SettingProxyServer (11): The SDK tries to reconnect after setting a proxy server.
  /// RenewToken (12): The connection state changed because the token is renewed.
  /// ClientIpAddressChanged (13): The IP Address of the SDK client has changed, probably due to a change of the network type, IP address, or network port.
  /// KeepAliveTimeout (14): Timeout for the keep-alive of the connection between the SDK and the Agora edge server. The connection state changes to state.
  /// (15): The SDK has rejoined the channel successfully.
  /// (16): The connection between the SDK and the server is lost.
  /// (17): The connection state changes due to the echo test.
  ///
  ///
  ///
  ///
  /// Param [state] The current connection state. For details, see ConnectionStateType.
  ///
  /// Disconnected (1): The SDK is disconnected from Agora's edge server.
  /// Connecting (2): The SDK is connecting to Agora's edge server.
  /// Connected (3): The SDK is connected to Agora's edge server and has joined a channel.
  /// Reconnecting (4): The SDK keeps reconnecting to the Agora edge server.
  /// Failed 5: The SDK fails to connect to Agora's edge server or join the channel.
  ///
  ///
  ///
  /// Param [rtcChannel] RtcChannel.
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
  /// Param [rtcChannel] RtcChannel.
  ///
  TokenCallback? tokenPrivilegeWillExpire;

  ///
  /// Occurs when the token expires.
  /// When the token expires during a call, the SDK triggers this callback to remind the app to renew the token.
  /// Once you receive this callback, generate a new token on your app server, and call joinChannel to rejoin the channel.
  ///
  EmptyCallback? requestToken;

  ///
  /// Occurs when the most active speaker is detected.
  /// After a successful call of enableAudioVolumeIndication, the SDK continuously detects which remote user has the loudest volume. During the current period, the remote user, who is detected as the loudest for the most times, is the most active user.
  /// When the number of users exceeds two (included) and an active speaker is detected, the SDK triggers this callback and reports the uid of the most active speaker.
  ///   If the most active speaker remains the same, the SDK triggers the activeSpeaker callback only once.
  ///   If the most active speaker changes to another user, the SDK triggers this callback again and reports the uid of the new active speaker.
  ///
  /// Param [uid] The user ID of the most active speaker.
  ///
  /// Param [rtcChannel] RtcChannel.
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
  /// uid is 0 for the local user.
  ///
  /// Param [rtcChannel] RtcChannel.
  ///
  VideoSizeCallback? videoSizeChanged;

  ///
  /// Occurs when the remote video state changes.
  /// Since
  /// v2.9.0
  ///
  ///
  /// This callback does not work properly when the number of users (in the voice/video call channel) or hosts (in the live streaming channel) in the channel exceeds 17.
  ///
  /// Param [reason]  The reason for the remote video state
  /// change, see VideoRemoteStateReason. Remote audio state reasons.
  /// Internal (0): Internal
  /// reasons.
  /// NetworkCongestion (1):
  /// Network congestion.
  /// NetworkRecovery (2):
  /// Network recovery.
  /// LocalMuted (3): The
  /// local user stops receiving the remote video stream or disables
  /// the video module.
  /// LocalUnmuted (4): The
  /// local user resumes receiving the remote video stream or enables
  /// the video module.
  /// RemoteMuted (5): The
  /// remote user stops sending the video stream or disables the video
  /// module.
  /// RemoteUnmuted (6): The
  /// remote user resumes sending the video stream or enables the video
  /// module.
  /// RemoteOffline (7): The
  /// remote user leaves the channel.
  /// AudioFallback (8): The
  /// remote media stream falls back to the audio-only stream due to
  /// poor network conditions.
  /// AudioFallbackRecovery
  /// (9): The remote media stream switches back to the video stream
  /// after the network conditions improve.
  ///
  ///
  /// Param [state]  The state of the remote video, see
  /// VideoRemoteState. The state
  /// of the remote video.
  /// Stopped (0): The remote video is
  /// in the initial state. The remote video is in the initial state,
  /// probably due to
  /// REMOTE_VIDEO_STATE_REASON_LOCAL_MUTED(3),
  /// REMOTE_VIDEO_STATE_REASON_REMOTE_MUTED(5), or
  /// REMOTE_VIDEO_STATE_REASON_REMOTE_OFFLINE(7).
  /// Starting (1): The first remote
  /// video packet is received.
  /// Decoding (2): The remote audio
  /// stream is decoded and plays normally. The remote audio stream is
  /// decoded and plays normally, probably due to
  /// REMOTE_VIDEO_STATE_REASON_NETWORK_RECOVERY(2),
  /// REMOTE_VIDEO_STATE_REASON_LOCAL_UNMUTED(4),
  /// REMOTE_VIDEO_STATE_REASON_REMOTE_UNMUTED(6), or
  /// REMOTE_VIDEO_STATE_REASON_AUDIO_FALLBACK_RECOVERY(9).
  /// Frozen (3): The remote video is
  /// frozen. The remote video is frozen, probably due to
  /// REMOTE_VIDEO_STATE_REASON_NETWORK_CONGESTION(1)
  /// or
  /// REMOTE_VIDEO_STATE_REASON_AUDIO_FALLBACK(8).
  /// Failed (4): The remote video
  /// fails to start. The remote video fails to start, probably due to
  /// REMOTE_VIDEO_STATE_REASON_INTERNAL (0).
  ///
  ///
  /// Param [uid] The ID of the remote user whose video state changes.
  ///
  /// Param [rtcChannel] RtcChannel.
  ///
  /// Param [elapsed] Time elapsed (ms) from the local user calling the joinChannel method until the SDK triggers this callback.
  ///
  RemoteVideoStateCallback? remoteVideoStateChanged;

  ///
  /// Occurs when the remote audio state changes.
  /// Since
  /// v2.9.0
  ///
  ///
  /// When the audio state of a remote user (in the voice/video call channel) or host (in the live streaming channel) changes, the SDK triggers this callback to report the current state of the remote audio stream.
  /// This callback does not work properly when the number of users (in the voice/video call channel) or hosts (in the live streaming channel) in the channel exceeds 17.
  ///
  /// Param [reason] The reason of the remote audio state change, see AudioRemoteStateReason.
  ///
  /// Param [state] The state of the remote audio, see AudioRemoteState.
  ///
  /// Param [uid] The ID of the remote user whose audio state changes.
  ///
  /// Param [rtcChannel] RtcChannel.
  ///
  /// Param [elapsed] Time elapsed (ms) from the local user calling the joinChannel method until the SDK triggers this callback.
  ///
  RemoteAudioStateCallback? remoteAudioStateChanged;

  ///
  /// Occurs when the published media stream falls back to an audio-only stream.
  /// If you call setLocalPublishFallbackOption and set option as AudioOnly, the SDK triggers this callback when the remote media stream falls back to audio-only mode due to poor uplink conditions, or when the remote media stream switches back to the video after the uplink network condition improves.
  /// If the local stream falls back to the audio-only stream, the remote user receives the userMuteVideo callback.
  ///
  /// Param [isFallbackOrRecover]
  ///
  /// true: The published stream falls
  /// back to audio-only due to poor network conditions.
  /// false: The published stream switches
  /// back to the video after the network conditions improve.
  ///
  ///
  ///
  /// Param [rtcChannel] RtcChannel.
  ///
  FallbackCallback? localPublishFallbackToAudioOnly;

  ///
  /// Occurs when the remote media stream falls back to audio-only stream due to poor network conditions or switches back to the video stream after the network conditions improve.
  /// If you call setRemoteSubscribeFallbackOption and set option as AudioOnly, the SDK triggers this callback when the remote media stream falls back to audio-only mode due to poor downlink conditions, or when the remote media stream switches back to the video after the downlink network condition improves.
  /// Once the remote media stream switches to the low stream due to poor network conditions, you can monitor the stream switch between a high and low stream in the RemoteVideoStats callback.
  ///
  /// Param [isFallbackOrRecover]
  ///
  ///  true: The remotely subscribed media stream falls back to audio-only due to poor network conditions.
  ///  false: The remotely subscribed media stream switches back to the video stream after the network conditions improved.
  ///
  ///
  ///
  /// Param [uid] The ID of the remote user.
  ///
  /// Param [rtcChannel] RtcChannel.
  ///
  FallbackWithUidCallback? remoteSubscribeFallbackToAudioOnly;

  ///
  /// Reports the statistics of the current call.
  /// The SDK triggers this callback once every two seconds after the user joins the channel.
  ///
  /// Param [stats]
  /// Statistics of the RTC engine, see RtcStats for
  /// details.
  ///
  ///
  /// Param [rtcChannel] RtcChannel.
  ///
  RtcStatsCallback? rtcStats;

  ///
  /// Reports the last mile network quality of each user in the channel.
  /// This callback reports the last mile network conditions of each user in the channel. Last mile refers to the connection between the local device and Agora's edge server.
  /// The SDK triggers this callback once every two seconds. If a channel includes multiple users, the SDK triggers this callback as many times.
  ///
  /// Param [rxQuality] Downlink network quality rating of the user in terms of packet loss rate,
  /// average RTT, and jitter of the downlink network. For details, see NetworkQuality.
  ///
  ///
  ///
  /// Param [txQuality] Uplink network quality rating of the user in terms of the transmission bit
  /// rate, packet loss rate, average RTT (Round-Trip Time) and jitter of the
  /// uplink network. This parameter is a quality rating helping you understand
  /// how well the current uplink network conditions can support the selected
  /// video encoder configuration. For example, a 1000 Kbps uplink network may be
  /// adequate for video frames with a resolution of 640 × 480 and a frame rate of
  /// 15 fps in the LIVE_BROADCASTING profile, but might be inadequate for
  /// resolutions higher than 1280 × 720. For details, see NetworkQuality.
  ///
  ///
  ///
  /// Param [uid]
  /// User ID. The network quality of the user with this user ID is
  /// reported.
  /// If the uid is 0, the local network quality is reported.
  ///
  ///
  /// Param [rtcChannel] RtcChannel.
  ///
  NetworkQualityWithUidCallback? networkQuality;

  ///
  /// Reports the transport-layer statistics of each remote video stream.
  /// Reports the statistics of the video stream from the remote users. The SDK triggers this callback once every two seconds for each remote user. If a channel has multiple users/hosts sending video streams, the SDK triggers this callback as many times.
  ///
  /// Param [stats] Statistics of the remote video stream. For details, see RemoteVideoStats.
  ///
  /// Param [rtcChannel] RtcChannel.
  ///
  RemoteVideoStatsCallback? remoteVideoStats;

  ///
  /// Reports the transport-layer statistics of each remote audio stream.
  /// The SDK triggers this callback once every two seconds for each remote user who is sending audio streams. If a channel includes multiple remote users, the SDK triggers this callback as many times.
  ///
  /// Param [stats] The statistics of the received remote audio streams. See RemoteAudioStats.
  ///
  /// Param [rtcChannel] RtcChannel.
  ///
  RemoteAudioStatsCallback? remoteAudioStats;

  ///
  /// Occurs when the state of the RTMP or RTMPS streaming changes.
  /// The SDK triggers this callback to report the result of the local user calling the addPublishStreamUrl or removePublishStreamUrl method. When the RTMP/RTMPS streaming status changes, the SDK triggers this callback and report the URL address and the current status of the streaming. This callback indicates the state of the RTMP or RTMPS streaming. When exceptions occur, you can troubleshoot issues by referring to the detailed error descriptions in the error code parameter.
  ///
  /// Param [errCode] The detailed error information for streaming, see RtmpStreamingErrorCode.
  ///
  /// Param [state] The RTMP or RTMPS streaming state, see RtmpStreamingState. When the streaming status is Failure(4), you can view the error information in the errorCode parameter.
  ///
  /// Param [url] The CDN streaming URL.
  ///
  /// Param [rtcChannel] RtcChannel.
  ///
  RtmpStreamingStateCallback? rtmpStreamingStateChanged;

  ///
  /// Occurs when the publisher's transcoding is updated.
  /// If you call the setLiveTranscoding
  /// method to set the LiveTranscoding class for the first time, the
  /// SDK does not trigger this callback.
  /// When the LiveTranscoding class in the setLiveTranscoding method updates, the SDK triggers the transcodingUpdated callback to report the update information.
  ///
  EmptyCallback? transcodingUpdated;

  ///
  /// Occurs when a media stream URL address is added to the interactive live streaming.
  ///
  ///
  /// Param [status] State of the externally injected stream: InjectStreamStatus.
  ///
  /// Param [uid] User ID.
  ///
  /// Param [url] The URL address of the externally injected stream.
  ///
  /// Param [rtcChannel] RtcChannel.
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
  /// Param [rtcChannel] RtcChannel.
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
  /// Param [code] The error code.
  ///
  /// Param [streamId] The stream ID of the received message.
  ///
  /// Param [uid] The ID of the remote user sending the message.
  ///
  /// Param [rtcChannel] RtcChannel.
  ///
  StreamMessageErrorCallback? streamMessageError;

  ///
  /// Occurs when the state of the media stream relay changes.
  /// The SDK returns the state of the current media relay with any error message.
  ///
  /// Param [code]  The error code of the channel media
  /// replay. For details, see ChannelMediaRelayError. The error code:
  /// None (0): Everything is normal.
  /// ServerErrorResponse (1): An error occurs in
  /// the server response.
  /// ServerNoResponse (2): No server response.
  /// You can call toleaveChannel leave the channel.
  /// NoResourceAvailable (3): The SDK fails to
  /// access the service, probably due to limited resources of the
  /// server.
  /// FailedJoinSourceChannel (4): The server fails to join
  /// the source channel.
  /// FailedJoinDestinationChannel (5): The server fails to
  /// join the destination channel.
  /// FailedPacketReceivedFromSource (6): The
  /// server fails to receive the media stream.
  /// FailedPacketSentToDestination (7): The source
  /// channel fails to send the media stream.
  /// ServerConnectionLost (8): The SDK
  /// disconnects from the server due to poor network connections. You can
  /// call theleaveChannel method to leave the
  /// channel.
  /// InternalError (9): An internal error occurs
  /// in the server.
  /// SourceTokenExpired (10): The token of the
  /// source channel has expired.
  /// DestinationTokenExpired (11): The token of the
  /// destination channel has expired.
  ///
  ///
  /// Param [state]  The state code. For details, see ChannelMediaRelayState. The state code:
  /// Idle (0): The SDK is initializing.
  /// Connecting (1): The SDK tries to relay the
  /// media stream to the destination channel.
  /// Running (2): The SDK successfully relays the
  /// media stream to the destination channel.
  /// Failure (3): An error occurs. See `code` for
  /// the error code.
  ///
  ///
  /// Param [rtcChannel] RtcChannel.
  ///
  MediaRelayStateCallback? channelMediaRelayStateChanged;

  ///
  /// Reports events during the media stream relay.
  ///
  ///
  /// Param [code] The event code of channel media relay. See ChannelMediaRelayEvent.
  /// The event code of channel media relay:
  /// Disconnect(0): The user disconnects from the server due to a poor network connection.
  /// Connected(1): The user is connected to the server.
  /// JoinedSourceChannel(2): The user joins the source channel.
  /// JoinedDestinationChannel(3): The user joins the destination channel.
  /// SentToDestinationChannel(4): The SDK starts relaying the media stream to the destination channel.
  /// ReceivedVideoPacketFromSource(5): The server receives the video stream from the source channel.
  /// ReceivedAudioPacketFromSource(6): The server receives the audio stream from the source channel.
  /// UpdateDestinationChannel(7): The destination channel is updated.
  /// UpdateDestinationChannelRefused(8): The destination channel update fails due to internal reasons.
  /// UpdateDestinationChannelNotChange(9): The destination channel does not change, which means that the destination channel fails to be updated.
  /// UpdateDestinationChannelIsNil(10): The destination channel name is NULL.
  /// VideoProfileUpdate(11): The video profile is sent to the server.
  /// PauseSendPacketToDestChannelSuccess(12): The SDK successfully pauses relaying the media stream to destination channels.
  /// PauseSendPacketToDestChannelFailed(13): The SDK fails to pause relaying the media stream to destination channels.
  /// ResumeSendPacketToDestChannelSuccess(14): The SDK successfully resumes relaying the media stream to destination channels.
  /// ResumeSendPacketToDestChannelFailed(15): The SDK fails to resume relaying the media stream to destination channels.
  ///
  ///
  ///
  ///
  /// Param [rtcChannel] RtcChannel.
  ///
  MediaRelayEventCallback? channelMediaRelayEvent;

  ///
  /// Occurs when the local user receives Metadata.
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
  /// Since
  ///   v3.1.0
  ///
  /// Param [elapseSinceLastState] The time elapsed (ms) from the previous state to the current state.
  ///
  /// Param [newState] For the current publishing state, see StreamPublishState.
  ///
  /// Param [oldState] For the previous publishing state, see StreamPublishState.
  ///
  /// Param [rtcChannel] RtcChannel.
  ///
  /// Param [channel] The channel name.
  ///
  StreamPublishStateCallback? audioPublishStateChanged;

  ///
  /// Occurs when the video publishing state changes.
  /// Since
  ///   v3.1.0
  ///
  /// Param [null]
  ///
  /// Param [channel] The channel name.
  ///
  StreamPublishStateCallback? videoPublishStateChanged;

  ///
  /// Occurs when the audio subscribing state changes.
  /// Since
  ///   v3.1.0
  ///
  /// Param [elapseSinceLastState] The time elapsed (ms) from the previous state to the current state.
  ///
  /// Param [newState] The current subscribing status, see StreamSubscribeState for details.
  ///
  /// Param [oldState] The previous subscribing status, see StreamSubscribeState
  /// for details.
  ///
  /// Param [rtcChannel] RtcChannel.
  ///
  /// Param [channel] The channel name.
  ///
  StreamSubscribeStateCallback? audioSubscribeStateChanged;

  ///
  /// Occurs when the video subscribing state changes.
  /// Since
  ///   v3.1.0
  ///
  /// Param [null]
  ///
  /// Param [channel] The channel name.
  ///
  StreamSubscribeStateCallback? videoSubscribeStateChanged;

  ///
  /// Reports events during the RTMP or RTMPS streaming.
  /// Since
  ///   v3.1.0
  ///
  /// Param [eventCode] The event code of the streaming. For details, see RtmpStreamingEvent.
  ///
  /// Param [url] The RTMP or RTMPS streaming URL.
  ///
  /// Param [rtcChannel] RtcChannel.
  ///
  RtmpStreamingEventCallback? rtmpStreamingEvent;

  ///
  /// Reports whether the super resolution feature is successfully enabled.
  /// Since
  /// v3.5.1
  ///
  ///
  /// After calling enableRemoteSuperResolution, the SDK triggers the callback to report whether super resolution is successfully enabled. If it is not successfully enabled, use reason for troubleshooting.
  ///
  /// Param [reason] The reason why super resolution algorithm is not successfully enabled. For details, see SuperResolutionStateReason.
  ///
  /// Param [enabled] Whether super resolution is successfully enabled:
  /// true: Super resolution is successfully enabled.
  /// false: Super resolution is not successfully enabled.
  ///
  ///
  /// Param [uid] The ID of the remote user.
  ///
  /// Param [rtcChannel] RtcChannel.
  ///
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
  void process(String channelId, String methodName, dynamic data,
      [Uint8List? buffer]) {
    List<dynamic> newData;
    // if (kIsWeb || (Platform.isWindows || Platform.isMacOS)) {

    // } else {
    //   newData = List<dynamic>.from(data);
    // }
    if (methodName.startsWith('on')) {
      methodName = methodName.substring(2);
    }
    newData = List<dynamic>.from(
        Map<String, dynamic>.from(jsonDecode(data as String)).values);
    switch (methodName) {
      case 'ChannelWarning':
        warning?.call(WarningCodeConverter.fromValue(newData[0]).e);
        break;
      case 'ChannelError':
        error?.call(ErrorCodeConverter.fromValue(newData[0]).e);
        break;
      case 'JoinChannelSuccess':
        joinChannelSuccess?.call(newData[0], newData[1], newData[2]);
        break;
      case 'RejoinChannelSuccess':
        rejoinChannelSuccess?.call(newData[0], newData[1], newData[2]);
        break;
      case 'LeaveChannel':
        leaveChannel
            ?.call(RtcStats.fromJson(Map<String, dynamic>.from(newData[0])));
        break;
      case 'ClientRoleChanged':
        clientRoleChanged?.call(ClientRoleConverter.fromValue(newData[0]).e,
            ClientRoleConverter.fromValue(newData[1]).e);
        break;
      case 'UserJoined':
        userJoined?.call(newData[0], newData[1]);
        break;
      case 'UserOffline':
        userOffline?.call(
            newData[0], UserOfflineReasonConverter.fromValue(newData[1]).e);
        break;
      case 'ConnectionStateChanged':
        connectionStateChanged?.call(
            ConnectionStateTypeConverter.fromValue(newData[0]).e,
            ConnectionChangedReasonConverter.fromValue(newData[1]).e);
        break;
      case 'ConnectionLost':
        connectionLost?.call();
        break;
      case 'TokenPrivilegeWillExpire':
        tokenPrivilegeWillExpire?.call(newData[0]);
        break;
      case 'RequestToken':
        requestToken?.call();
        break;
      case 'ActiveSpeaker':
        activeSpeaker?.call(newData[0]);
        break;
      case 'VideoSizeChanged':
        videoSizeChanged?.call(newData[0], newData[1], newData[2], newData[3]);
        break;
      case 'RemoteVideoStateChanged':
        remoteVideoStateChanged?.call(
            newData[0],
            VideoRemoteStateConverter.fromValue(newData[1]).e,
            VideoRemoteStateReasonConverter.fromValue(newData[2]).e,
            newData[3]);
        break;
      case 'RemoteAudioStateChanged':
        remoteAudioStateChanged?.call(
            newData[0],
            AudioRemoteStateConverter.fromValue(newData[1]).e,
            AudioRemoteStateReasonConverter.fromValue(newData[2]).e,
            newData[3]);
        break;
      case 'LocalPublishFallbackToAudioOnly':
        localPublishFallbackToAudioOnly?.call(newData[0]);
        break;
      case 'RemoteSubscribeFallbackToAudioOnly':
        remoteSubscribeFallbackToAudioOnly?.call(newData[0], newData[1]);
        break;
      case 'RtcStats':
        rtcStats
            ?.call(RtcStats.fromJson(Map<String, dynamic>.from(newData[0])));
        break;
      case 'NetworkQuality':
        networkQuality?.call(
            newData[0],
            NetworkQualityConverter.fromValue(newData[1]).e,
            NetworkQualityConverter.fromValue(newData[2]).e);
        break;
      case 'RemoteVideoStats':
        remoteVideoStats?.call(
            RemoteVideoStats.fromJson(Map<String, dynamic>.from(newData[0])));
        break;
      case 'RemoteAudioStats':
        remoteAudioStats?.call(
            RemoteAudioStats.fromJson(Map<String, dynamic>.from(newData[0])));
        break;
      case 'RtmpStreamingStateChanged':
        rtmpStreamingStateChanged?.call(
          newData[0],
          RtmpStreamingStateConverter.fromValue(newData[1]).e,
          RtmpStreamingErrorCodeConverter.fromValue(newData[2]).e,
        );
        break;
      case 'TranscodingUpdated':
        transcodingUpdated?.call();
        break;
      case 'StreamInjectedStatus':
        streamInjectedStatus?.call(newData[0], newData[1],
            InjectStreamStatusConverter.fromValue(newData[2]).e);
        break;
      case 'StreamMessage':
        // if (kIsWeb || (Platform.isWindows || Platform.isMacOS || Platform.isAndroid)) {

        // } else {
        //   String data = newData[2];
        //   streamMessage?.call(
        //       newData[0], newData[1], Uint8List.fromList(data.codeUnits));
        // }
        if (buffer == null) return;
        streamMessage?.call(newData[0], newData[1], buffer);
        break;
      case 'StreamMessageError':
        streamMessageError?.call(newData[0], newData[1],
            ErrorCodeConverter.fromValue(newData[2]).e, newData[3], newData[4]);
        break;
      case 'ChannelMediaRelayStateChanged':
        channelMediaRelayStateChanged?.call(
          ChannelMediaRelayStateConverter.fromValue(newData[0]).e,
          ChannelMediaRelayErrorConverter.fromValue(newData[1]).e,
        );
        break;
      case 'ChannelMediaRelayEvent':
        channelMediaRelayEvent
            ?.call(ChannelMediaRelayEventConverter.fromValue(newData[0]).e);
        break;
      case 'MetadataReceived':
        Metadata metadata;
        // if (kIsWeb || (Platform.isWindows || Platform.isMacOS || Platform.isAndroid)) {

        // } else {
        //   metadata = Metadata(newData[1], newData[2]);
        //   String buffer = newData[0];
        //   metadata.buffer = Uint8List.fromList(buffer.codeUnits);
        // }
        if (buffer == null) return;
        metadata = Metadata.fromJson(Map<String, dynamic>.from(newData[0]));
        metadata.buffer = buffer;
        metadataReceived?.call(metadata);
        break;
      case 'AudioPublishStateChanged':
        audioPublishStateChanged?.call(
            channelId,
            StreamPublishStateConverter.fromValue(newData[0]).e,
            StreamPublishStateConverter.fromValue(newData[1]).e,
            newData[2]);
        break;
      case 'VideoPublishStateChanged':
        videoPublishStateChanged?.call(
            channelId,
            StreamPublishStateConverter.fromValue(newData[0]).e,
            StreamPublishStateConverter.fromValue(newData[1]).e,
            newData[2]);
        break;
      case 'AudioSubscribeStateChanged':
        audioSubscribeStateChanged?.call(
            channelId,
            newData[0],
            StreamSubscribeStateConverter.fromValue(newData[1]).e,
            StreamSubscribeStateConverter.fromValue(newData[2]).e,
            newData[3]);
        break;
      case 'VideoSubscribeStateChanged':
        videoSubscribeStateChanged?.call(
            channelId,
            newData[0],
            StreamSubscribeStateConverter.fromValue(newData[1]).e,
            StreamSubscribeStateConverter.fromValue(newData[2]).e,
            newData[3]);
        break;
      case 'RtmpStreamingEvent':
        rtmpStreamingEvent?.call(
          newData[0],
          RtmpStreamingEventConverter.fromValue(newData[1]).e,
        );
        break;
      case 'UserSuperResolutionEnabled':
        userSuperResolutionEnabled?.call(newData[0], newData[1],
            SuperResolutionStateReasonConverter.fromValue(newData[2]).e);
        break;
      default:
        throw ArgumentError('Not Supported Event: $methodName');
    }
  }
}
