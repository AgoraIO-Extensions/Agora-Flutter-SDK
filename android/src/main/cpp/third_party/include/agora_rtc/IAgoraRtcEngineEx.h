//
//  Agora Media SDK
//
//  Created by Sting Feng in 2015-05.
//  Updated by Tommy Miao in 2020-11.
//  Copyright (c) 2015 Agora IO. All rights reserved.
//
#pragma once

#include "IAgoraRtcEngine.h"

namespace agora {
namespace rtc {

// OPTIONAL_ENUM_CLASS RTC_EVENT;

/**
 * Rtc Connection.
 */
struct RtcConnection {
  /**
   *  The unique channel name for the AgoraRTC session in the string format. The string
   * length must be less than 64 bytes. Supported character scopes are:
   * - All lowercase English letters: a to z.
   * - All uppercase English letters: A to Z.
   * - All numeric characters: 0 to 9.
   * - The space character.
   * - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-",
   * ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
   */
  const char* channelId;
  /**
   * User ID: A 32-bit unsigned integer ranging from 1 to (2^32-1). It must be unique.
   */
  uid_t localUid;

  RtcConnection() : channelId(NULL), localUid(0) {}
  RtcConnection(const char* channel_id, uid_t local_uid)
      : channelId(channel_id), localUid(local_uid) {}
};

class IRtcEngineEventHandlerEx : public IRtcEngineEventHandler {
 public:
  using IRtcEngineEventHandler::eventHandlerType;
  using IRtcEngineEventHandler::onJoinChannelSuccess;
  using IRtcEngineEventHandler::onRejoinChannelSuccess;
  using IRtcEngineEventHandler::onAudioQuality;
  using IRtcEngineEventHandler::onAudioVolumeIndication;
  using IRtcEngineEventHandler::onLeaveChannel;
  using IRtcEngineEventHandler::onRtcStats;
  using IRtcEngineEventHandler::onNetworkQuality;
  using IRtcEngineEventHandler::onIntraRequestReceived;
  using IRtcEngineEventHandler::onFirstLocalVideoFramePublished;
  using IRtcEngineEventHandler::onFirstRemoteVideoDecoded;
  using IRtcEngineEventHandler::onVideoSizeChanged;
  using IRtcEngineEventHandler::onLocalVideoStateChanged;
  using IRtcEngineEventHandler::onRemoteVideoStateChanged;
  using IRtcEngineEventHandler::onFirstRemoteVideoFrame;
  using IRtcEngineEventHandler::onUserJoined;
  using IRtcEngineEventHandler::onUserOffline;
  using IRtcEngineEventHandler::onUserMuteAudio;
  using IRtcEngineEventHandler::onUserMuteVideo;
  using IRtcEngineEventHandler::onUserEnableVideo;
  using IRtcEngineEventHandler::onUserEnableLocalVideo;
  using IRtcEngineEventHandler::onUserStateChanged;
  using IRtcEngineEventHandler::onLocalAudioStats;
  using IRtcEngineEventHandler::onRemoteAudioStats;
  using IRtcEngineEventHandler::onLocalVideoStats;
  using IRtcEngineEventHandler::onRemoteVideoStats;
  using IRtcEngineEventHandler::onConnectionLost;
  using IRtcEngineEventHandler::onConnectionInterrupted;
  using IRtcEngineEventHandler::onConnectionBanned;
  using IRtcEngineEventHandler::onStreamMessage;
  using IRtcEngineEventHandler::onStreamMessageError;
  using IRtcEngineEventHandler::onRequestToken;
  using IRtcEngineEventHandler::onTokenPrivilegeWillExpire;
  using IRtcEngineEventHandler::onLicenseValidationFailure;
  using IRtcEngineEventHandler::onFirstLocalAudioFramePublished;
  using IRtcEngineEventHandler::onFirstRemoteAudioFrame;
  using IRtcEngineEventHandler::onFirstRemoteAudioDecoded;
  using IRtcEngineEventHandler::onLocalAudioStateChanged;
  using IRtcEngineEventHandler::onRemoteAudioStateChanged;
  using IRtcEngineEventHandler::onActiveSpeaker;
  using IRtcEngineEventHandler::onClientRoleChanged;
  using IRtcEngineEventHandler::onClientRoleChangeFailed;
  using IRtcEngineEventHandler::onRemoteAudioTransportStats;
  using IRtcEngineEventHandler::onRemoteVideoTransportStats;
  using IRtcEngineEventHandler::onConnectionStateChanged;
  using IRtcEngineEventHandler::onWlAccMessage;
  using IRtcEngineEventHandler::onWlAccStats;
  using IRtcEngineEventHandler::onNetworkTypeChanged;
  using IRtcEngineEventHandler::onEncryptionError;
  using IRtcEngineEventHandler::onUploadLogResult;
  using IRtcEngineEventHandler::onUserInfoUpdated;
  using IRtcEngineEventHandler::onUserAccountUpdated;
  using IRtcEngineEventHandler::onAudioSubscribeStateChanged;
  using IRtcEngineEventHandler::onVideoSubscribeStateChanged;
  using IRtcEngineEventHandler::onAudioPublishStateChanged;
  using IRtcEngineEventHandler::onVideoPublishStateChanged;
  using IRtcEngineEventHandler::onSnapshotTaken;
  using IRtcEngineEventHandler::onVideoRenderingTracingResult;
  using IRtcEngineEventHandler::onSetRtmFlagResult;
  using IRtcEngineEventHandler::onTranscodedStreamLayoutInfo;
  using IRtcEngineEventHandler::onAudioMetadataReceived;

  virtual const char* eventHandlerType() const { return "event_handler_ex"; }

  /**
   * Occurs when a user joins a channel.
   *
   * This callback notifies the application that a user joins a specified channel.
   *
   * @param connection The RtcConnection object.
   * @param elapsed The time elapsed (ms) from the local user calling joinChannel until the SDK triggers this callback.
   */
  virtual void onJoinChannelSuccess(const RtcConnection& connection, int elapsed) {
    (void)connection;
    (void)elapsed;
  }

  /**
   * Occurs when a user rejoins the channel.
   *
   * When a user loses connection with the server because of network problems, the SDK automatically tries to reconnect
   * and triggers this callback upon reconnection.
   *
   * @param connection The RtcConnection object.
   * @param elapsed Time elapsed (ms) from the local user calling the joinChannel method until this callback is triggered.
   */
  virtual void onRejoinChannelSuccess(const RtcConnection& connection, int elapsed) {
    (void)connection;
    (void)elapsed;
  }

  /** Reports the statistics of the audio stream from each remote
  user/broadcaster.

  @deprecated This callback is deprecated. Use onRemoteAudioStats instead.

  The SDK triggers this callback once every two seconds to report the audio
  quality of each remote user/host sending an audio stream. If a channel has
  multiple remote users/hosts sending audio streams, the SDK triggers this
  callback as many times.

  @param connection The RtcConnection object.
  @param remoteUid The user ID of the remote user sending the audio stream.
  @param quality The audio quality of the user: #QUALITY_TYPE
  @param delay The network delay (ms) from the sender to the receiver, including the delay caused by audio sampling pre-processing, network transmission, and network jitter buffering.
  @param lost The audio packet loss rate (%) from the sender to the receiver.
  */
  virtual void onAudioQuality(const RtcConnection& connection, uid_t remoteUid, int quality, unsigned short delay, unsigned short lost) __deprecated {
    (void)connection;
    (void)remoteUid;
    (void)quality;
    (void)delay;
    (void)lost;
  }
  /**
   * Reports the volume information of users.
   *
   * By default, this callback is disabled. You can enable it by calling `enableAudioVolumeIndication`. Once this
   * callback is enabled and users send streams in the channel, the SDK triggers the `onAudioVolumeIndication`
   * callback at the time interval set in `enableAudioVolumeIndication`. The SDK triggers two independent
   * `onAudioVolumeIndication` callbacks simultaneously, which separately report the volume information of the
   * local user who sends a stream and the remote users (up to three) whose instantaneous volume is the highest.
   *
   * @note After you enable this callback, calling muteLocalAudioStream affects the SDK's behavior as follows:
   * - If the local user stops publishing the audio stream, the SDK stops triggering the local user's callback.
   * - 20 seconds after a remote user whose volume is one of the three highest stops publishing the audio stream,
   * the callback excludes this user's information; 20 seconds after all remote users stop publishing audio streams,
   * the SDK stops triggering the callback for remote users.
   *
   * @param connection The RtcConnection object.
   * @param speakers The volume information of the users, see AudioVolumeInfo. An empty `speakers` array in the
   * callback indicates that no remote user is in the channel or sending a stream at the moment.
   * @param speakerNumber The total number of speakers.
   * - In the local user's callback, when the local user sends a stream, `speakerNumber` is 1.
   * - In the callback for remote users, the value range of speakerNumber is [0,3]. If the number of remote users who
   * send streams is greater than or equal to three, the value of `speakerNumber` is 3.
   * @param totalVolume The volume of the speaker. The value ranges between 0 (lowest volume) and 255 (highest volume).
   * - In the local user's callback, `totalVolume` is the volume of the local user who sends a stream.
   * - In the remote users' callback, `totalVolume` is the sum of all remote users (up to three) whose instantaneous
   * volume is the highest. If the user calls `startAudioMixing`, `totalVolume` is the volume after audio mixing.
   */
  virtual void onAudioVolumeIndication(const RtcConnection& connection, const AudioVolumeInfo* speakers,
                                       unsigned int speakerNumber, int totalVolume) {
    (void)connection;
    (void)speakers;
    (void)speakerNumber;
    (void)totalVolume;
  }

  /**
   * Occurs when a user leaves a channel.
   *
   * This callback notifies the app that the user leaves the channel by calling `leaveChannel`. From this callback,
   * the app can get information such as the call duration and quality statistics.
   *
   * @param connection The RtcConnection object.
   * @param stats The statistics on the call: RtcStats.
   */
  virtual void onLeaveChannel(const RtcConnection& connection, const RtcStats& stats) {
    (void)connection;
    (void)stats;
  }

  /**
   * Reports the statistics of the current call.
   *
   * The SDK triggers this callback once every two seconds after the user joins the channel.
   *
   * @param connection The RtcConnection object.
   * @param stats The statistics of the current call: RtcStats.
   */
  virtual void onRtcStats(const RtcConnection& connection, const RtcStats& stats) {
    (void)connection;
    (void)stats;
  }

  /**
   * Reports the last mile network quality of each user in the channel.
   *
   * This callback reports the last mile network conditions of each user in the channel. Last mile refers to the
   * connection between the local device and Agora's edge server.
   *
   * The SDK triggers this callback once every two seconds. If a channel includes multiple users, the SDK triggers
   * this callback as many times.
   *
   * @note `txQuality` is UNKNOWN when the user is not sending a stream; `rxQuality` is UNKNOWN when the user is not
   * receiving a stream.
   *
   * @param connection The RtcConnection object.
   * @param remoteUid The user ID. The network quality of the user with this user ID is reported.
   * @param txQuality Uplink network quality rating of the user in terms of the transmission bit rate, packet loss rate,
   * average RTT (Round-Trip Time) and jitter of the uplink network. This parameter is a quality rating helping you
   * understand how well the current uplink network conditions can support the selected video encoder configuration.
   * For example, a 1000 Kbps uplink network may be adequate for video frames with a resolution of 640 × 480 and a frame
   * rate of 15 fps in the LIVE_BROADCASTING profile, but may be inadequate for resolutions higher than 1280 × 720.
   * See #QUALITY_TYPE.
   * @param rxQuality Downlink network quality rating of the user in terms of packet loss rate, average RTT, and jitter
   * of the downlink network. See #QUALITY_TYPE.
   */
  virtual void onNetworkQuality(const RtcConnection& connection, uid_t remoteUid, int txQuality, int rxQuality) {
    (void)connection;
    (void)remoteUid;
    (void)txQuality;
    (void)rxQuality;
  }

  /**
   * Occurs when intra request from remote user is received.
   *
   * This callback is triggered once remote user needs one Key frame.
   *
   * @param connection The RtcConnection object.
   */
  virtual void onIntraRequestReceived(const RtcConnection& connection) {
    (void)connection;
  }

  /** Occurs when the first local video frame is published.
   * The SDK triggers this callback under one of the following circumstances:
   * - The local client enables the video module and calls `joinChannel` successfully.
   * - The local client calls `muteLocalVideoStream(true)` and muteLocalVideoStream(false) in sequence.
   * - The local client calls `disableVideo` and `enableVideo` in sequence.
   * - The local client calls `pushVideoFrame` to successfully push the video frame to the SDK.
   *
   * @param connection The RtcConnection object.
   * @param elapsed The time elapsed (ms) from the local user calling joinChannel` to the SDK triggers
   * this callback.
  */
  virtual void onFirstLocalVideoFramePublished(const RtcConnection& connection, int elapsed) {
    (void)connection;
    (void)elapsed;
  }

  /** Occurs when the first remote video frame is received and decoded.

  The SDK triggers this callback under one of the following circumstances:
  - The remote user joins the channel and sends the video stream.
  - The remote user stops sending the video stream and re-sends it after 15 seconds. Reasons for such an interruption include:
   - The remote user leaves the channel.
   - The remote user drops offline.
   - The remote user calls `muteLocalVideoStream` to stop sending the video stream.
   - The remote user calls `disableVideo` to disable video.

  @param connection The RtcConnection object.
  @param remoteUid The user ID of the remote user sending the video stream.
  @param width The width (pixels) of the video stream.
  @param height The height (pixels) of the video stream.
  @param elapsed The time elapsed (ms) from the local user calling `joinChannel`
  until the SDK triggers this callback.
  */
  virtual void onFirstRemoteVideoDecoded(const RtcConnection& connection, uid_t remoteUid, int width, int height, int elapsed) {
    (void)connection;
    (void)remoteUid;
    (void)width;
    (void)height;
    (void)elapsed;
  }

  /**
   * Occurs when the local or remote video size or rotation has changed.
   *
   * @param connection The RtcConnection object.
   * @param sourceType The video source type: #VIDEO_SOURCE_TYPE.
   * @param uid The user ID. 0 indicates the local user.
   * @param width The new width (pixels) of the video.
   * @param height The new height (pixels) of the video.
   * @param rotation The rotation information of the video.
   */
  virtual void onVideoSizeChanged(const RtcConnection& connection, VIDEO_SOURCE_TYPE sourceType, uid_t uid, int width, int height, int rotation) {
    (void)connection;
    (void)sourceType;
    (void)uid;
    (void)width;
    (void)height;
    (void)rotation;
  }

  /** Occurs when the local video stream state changes.
   *
   * When the state of the local video stream changes (including the state of the video capture and
   * encoding), the SDK triggers this callback to report the current state. This callback indicates
   * the state of the local video stream, including camera capturing and video encoding, and allows
   * you to troubleshoot issues when exceptions occur.
   *
   * The SDK triggers the onLocalVideoStateChanged callback with the state code of `LOCAL_VIDEO_STREAM_STATE_FAILED`
   * and error code of `LOCAL_VIDEO_STREAM_REASON_CAPTURE_FAILURE` in the following situations:
   * - The app switches to the background, and the system gets the camera resource.
   * - The camera starts normally, but does not output video for four consecutive seconds.
   *
   * When the camera outputs the captured video frames, if the video frames are the same for 15
   * consecutive frames, the SDK triggers the `onLocalVideoStateChanged` callback with the state code
   * of `LOCAL_VIDEO_STREAM_STATE_CAPTURING` and error code of `LOCAL_VIDEO_STREAM_REASON_CAPTURE_FAILURE`.
   * Note that the video frame duplication detection is only available for video frames with a resolution
   * greater than 200 × 200, a frame rate greater than or equal to 10 fps, and a bitrate less than 20 Kbps.
   *
   * @note For some device models, the SDK does not trigger this callback when the state of the local
   * video changes while the local video capturing device is in use, so you have to make your own
   * timeout judgment.
   *
   * @param connection The RtcConnection object.
   * @param state The state of the local video. See #LOCAL_VIDEO_STREAM_STATE.
   * @param reason The detailed error information. See #LOCAL_VIDEO_STREAM_REASON.
   */
  virtual void onLocalVideoStateChanged(const RtcConnection& connection,
                                        LOCAL_VIDEO_STREAM_STATE state,
                                        LOCAL_VIDEO_STREAM_REASON reason) {
    (void)connection;
    (void)state;
    (void)reason;
  }

  /**
   * Occurs when the remote video state changes.
   *
   * @note This callback does not work properly when the number of users (in the voice/video call
   * channel) or hosts (in the live streaming channel) in the channel exceeds 17.
   *
   * @param connection The RtcConnection object.
   * @param remoteUid The ID of the user whose video state has changed.
   * @param state The remote video state: #REMOTE_VIDEO_STATE.
   * @param reason The reason of the remote video state change: #REMOTE_VIDEO_STATE_REASON.
   * @param elapsed The time elapsed (ms) from the local client calling `joinChannel` until this callback is triggered.
   */
  virtual void onRemoteVideoStateChanged(const RtcConnection& connection, uid_t remoteUid, REMOTE_VIDEO_STATE state, REMOTE_VIDEO_STATE_REASON reason, int elapsed) {
    (void)connection;
    (void)remoteUid;
    (void)state;
    (void)reason;
    (void)elapsed;
  }

  /** Occurs when the renderer receives the first frame of the remote video.
   *
   * @param connection The RtcConnection object.
   * @param remoteUid The user ID of the remote user sending the video stream.
   * @param width The width (px) of the video frame.
   * @param height The height (px) of the video stream.
   * @param elapsed The time elapsed (ms) from the local user calling `joinChannel` until the SDK triggers this callback.
   */
  virtual void onFirstRemoteVideoFrame(const RtcConnection& connection, uid_t remoteUid, int width, int height, int elapsed) {
    (void)connection;
    (void)remoteUid;
    (void)width;
    (void)height;
    (void)elapsed;
  }

  /**
   * Occurs when a remote user or broadcaster joins the channel.
   *
   * - In the COMMUNICATION channel profile, this callback indicates that a remote user joins the channel.
   * The SDK also triggers this callback to report the existing users in the channel when a user joins the
   * channel.
   * In the LIVE_BROADCASTING channel profile, this callback indicates that a host joins the channel. The
   * SDK also triggers this callback to report the existing hosts in the channel when a host joins the
   * channel. Agora recommends limiting the number of hosts to 17.
   *
   * The SDK triggers this callback under one of the following circumstances:
   * - A remote user/host joins the channel by calling the `joinChannel` method.
   * - A remote user switches the user role to the host after joining the channel.
   * - A remote user/host rejoins the channel after a network interruption.
   *
   * @param connection The RtcConnection object.
   * @param remoteUid The ID of the remote user or broadcaster joining the channel.
   * @param elapsed The time elapsed (ms) from the local user calling `joinChannel` or `setClientRole`
   * until this callback is triggered.
  */
  virtual void onUserJoined(const RtcConnection& connection, uid_t remoteUid, int elapsed) {
    (void)connection;
    (void)remoteUid;
    (void)elapsed;
  }

  /**
   * Occurs when a remote user or broadcaster goes offline.
   *
   * There are two reasons for a user to go offline:
   * - Leave the channel: When the user leaves the channel, the user sends a goodbye message. When this
   * message is received, the SDK determines that the user leaves the channel.
   * - Drop offline: When no data packet of the user is received for a certain period of time, the SDK assumes
   * that the user drops offline. A poor network connection may lead to false detection, so we recommend using
   * the RTM SDK for reliable offline detection.
   * - The user switches the user role from a broadcaster to an audience.
   *
   * @param connection The RtcConnection object.
   * @param remoteUid The ID of the remote user or broadcaster who leaves the channel or drops offline.
   * @param reason The reason why the remote user goes offline: #USER_OFFLINE_REASON_TYPE.
   */
  virtual void onUserOffline(const RtcConnection& connection, uid_t remoteUid, USER_OFFLINE_REASON_TYPE reason) {
    (void)connection;
    (void)remoteUid;
    (void)reason;
  }

  /** Occurs when a remote user's audio stream playback pauses/resumes.
   * The SDK triggers this callback when the remote user stops or resumes sending the audio stream by
   * calling the `muteLocalAudioStream` method.
   * @note This callback can be inaccurate when the number of users (in the `COMMUNICATION` profile) or hosts (in the `LIVE_BROADCASTING` profile) in the channel exceeds 17.
   *
   * @param connection The RtcConnection object.
   * @param remoteUid The user ID.
   * @param muted Whether the remote user's audio stream is muted/unmuted:
   * - true: Muted.
   * - false: Unmuted.
   */
 virtual void onUserMuteAudio(const RtcConnection& connection, uid_t remoteUid, bool muted) __deprecated {
    (void)connection;
    (void)remoteUid;
    (void)muted;
  }

  /** Occurs when a remote user pauses or resumes sending the video stream.
   *
   * When a remote user calls `muteLocalVideoStream` to stop or resume publishing the video stream, the
   * SDK triggers this callback to report the state of the remote user's publishing stream to the local
   * user.
   *
   * @note This callback can be inaccurate when the number of users or broadacasters in a
   * channel exceeds 20.
   *
   * @param connection The RtcConnection object.
   * @param remoteUid ID of the remote user.
   * @param muted Whether the remote user stops publishing the video stream:
   * - true: The remote user has paused sending the video stream.
   * - false: The remote user has resumed sending the video stream.
   */
 virtual void onUserMuteVideo(const RtcConnection& connection, uid_t remoteUid, bool muted) {
    (void)connection;
    (void)remoteUid;
    (void)muted;
  }

  /** Occurs when a remote user enables or disables the video module.

  Once the video function is disabled, the users cannot see any video.

  The SDK triggers this callback when a remote user enables or disables the video module by calling the
  `enableVideo` or `disableVideo` method.

  @param connection The RtcConnection object.
  @param remoteUid The ID of the remote user.
  @param enabled Whether the video of the remote user is enabled:
  - true: The remote user has enabled video.
  - false: The remote user has disabled video.
  */
 virtual void onUserEnableVideo(const RtcConnection& connection, uid_t remoteUid, bool enabled) {
    (void)connection;
    (void)remoteUid;
    (void)enabled;
  }

  /** Occurs when a remote user enables or disables local video capturing.

  The SDK triggers this callback when the remote user resumes or stops capturing the video stream by
  calling the `enableLocalVideo` method.

  @param connection The RtcConnection object.
  @param remoteUid The ID of the remote user.
  @param enabled Whether the specified remote user enables/disables local video:
  - `true`: The remote user has enabled local video capturing.
  - `false`: The remote user has disabled local video capturing.
  */
  virtual void onUserEnableLocalVideo(const RtcConnection& connection, uid_t remoteUid, bool enabled) __deprecated {
    (void)connection;
    (void)remoteUid;
    (void)enabled;
  }

  /**
   * Occurs when the remote user state is updated.
   *
   * @param connection The RtcConnection object.
   * @param remoteUid The uid of the remote user.
   * @param state The remote user state: #REMOTE_USER_STATE.
   */
  virtual void onUserStateChanged(const RtcConnection& connection, uid_t remoteUid, uint32_t state) {
    (void)connection;
    (void)remoteUid;
    (void)state;
  }

  /** Reports the statistics of the local audio stream.
   *
   * The SDK triggers this callback once every two seconds.
   *
   * @param connection The RtcConnection object.
   * @param stats The statistics of the local audio stream.
   * See LocalAudioStats.
   */
  virtual void onLocalAudioStats(const RtcConnection& connection, const LocalAudioStats& stats) {
    (void)connection;
    (void)stats;
  }

  /** Reports the statistics of the audio stream from each remote user/host.

   The SDK triggers this callback once every two seconds for each remote user who is sending audio
   streams. If a channel includes multiple remote users, the SDK triggers this callback as many times.
   @param connection The RtcConnection object.
   @param stats Statistics of the received remote audio streams. See RemoteAudioStats.
   */
  virtual void onRemoteAudioStats(const RtcConnection& connection, const RemoteAudioStats& stats) {
    (void)connection;
    (void)stats;
  }

  /** Reports the statistics of the local video stream.
   *
   * The SDK triggers this callback once every two seconds for each
   * user/host. If there are multiple users/hosts in the channel, the SDK
   * triggers this callback as many times.
   *
   * @note If you have called the `enableDualStreamMode`
   * method, this callback reports the statistics of the high-video
   * stream (high bitrate, and high-resolution video stream).
   *
   * @param connection The RtcConnection object.
   * @param stats Statistics of the local video stream. See LocalVideoStats.
   */
  virtual void onLocalVideoStats(const RtcConnection& connection, const LocalVideoStats& stats) {
    (void)connection;
    (void)stats;
  }

  /** Reports the statistics of the video stream from each remote user/host.
   *
   * The SDK triggers this callback once every two seconds for each remote user. If a channel has
   * multiple users/hosts sending video streams, the SDK triggers this callback as many times.
   *
   * @param connection The RtcConnection object.
   * @param stats Statistics of the remote video stream. See
   * RemoteVideoStats.
   */
  virtual void onRemoteVideoStats(const RtcConnection& connection, const RemoteVideoStats& stats) {
    (void)connection;
    (void)stats;
  }

  /**
   * Occurs when the SDK cannot reconnect to the server 10 seconds after its connection to the server is
   * interrupted.
   *
   * The SDK triggers this callback when it cannot connect to the server 10 seconds after calling
   * `joinChannel`, regardless of whether it is in the channel or not. If the SDK fails to rejoin
   * the channel 20 minutes after being disconnected from Agora's edge server, the SDK stops rejoining the channel.
   *
   * @param connection The RtcConnection object.
   */
  virtual void onConnectionLost(const RtcConnection& connection) {
    (void)connection;
  }

  /** Occurs when the connection between the SDK and the server is interrupted.
   * @deprecated Use `onConnectionStateChanged` instead.

  The SDK triggers this callback when it loses connection with the serer for more
  than 4 seconds after the connection is established. After triggering this
  callback, the SDK tries to reconnect to the server. If the reconnection fails
  within a certain period (10 seconds by default), the onConnectionLost()
  callback is triggered. If the SDK fails to rejoin the channel 20 minutes after
  being disconnected from Agora's edge server, the SDK stops rejoining the channel.

  @param connection The RtcConnection object.

  */
  virtual void onConnectionInterrupted(const RtcConnection& connection) __deprecated {
    (void)connection;
  }

  /** Occurs when your connection is banned by the Agora Server.
   *
   * @param connection The RtcConnection object.
   */
  virtual void onConnectionBanned(const RtcConnection& connection) {
    (void)connection;
  }

  /** Occurs when the local user receives the data stream from the remote user.
   *
   * The SDK triggers this callback when the user receives the data stream that another user sends
   * by calling the \ref agora::rtc::IRtcEngine::sendStreamMessage "sendStreamMessage" method.
   *
   * @param connection The RtcConnection object.
   * @param remoteUid ID of the user who sends the data stream.
   * @param streamId The ID of the stream data.
   * @param data The data stream.
   * @param length The length (byte) of the data stream.
   * @param sentTs The time when the data stream sent.
   */
  virtual void onStreamMessage(const RtcConnection& connection, uid_t remoteUid, int streamId, const char* data, size_t length, uint64_t sentTs) {
    (void)connection;
    (void)remoteUid;
    (void)streamId;
    (void)data;
    (void)length;
    (void)sentTs;
  }

  /** Occurs when the local user does not receive the data stream from the remote user.
   *
   * The SDK triggers this callback when the user fails to receive the data stream that another user sends
   * by calling the \ref agora::rtc::IRtcEngine::sendStreamMessage "sendStreamMessage" method.
   *
   * @param connection The RtcConnection object.
   * @param remoteUid ID of the user who sends the data stream.
   * @param streamId The ID of the stream data.
   * @param code The error code.
   * @param missed The number of lost messages.
   * @param cached The number of incoming cached messages when the data stream is
   * interrupted.
   */
  virtual void onStreamMessageError(const RtcConnection& connection, uid_t remoteUid, int streamId, int code, int missed, int cached) {
    (void)connection;
    (void)remoteUid;
    (void)streamId;
    (void)code;
    (void)missed;
    (void)cached;
  }

  /**
   * Occurs when the token expires.
   *
   * When the token expires during a call, the SDK triggers this callback to remind the app to renew the token.
   *
   * Upon receiving this callback, generate a new token at your app server and call
   * `joinChannel` to pass the new token to the SDK.
   *
   * @param connection The RtcConnection object.
   */
  virtual void onRequestToken(const RtcConnection& connection) {
    (void)connection;
  }

  /**
   * Occurs when connection license verification fails.
   *
   * You can know the reason accordding to error code
   */
  virtual void onLicenseValidationFailure(const RtcConnection& connection, LICENSE_ERROR_TYPE reason) {
    (void)connection;
    (void)reason;
  }

  /**
   * Occurs when the token will expire in 30 seconds.
   *
   * When the token is about to expire in 30 seconds, the SDK triggers this callback to remind the app to renew the token.

   * Upon receiving this callback, generate a new token at your app server and call
   * \ref IRtcEngine::renewToken "renewToken" to pass the new Token to the SDK.
   *
   * @param connection The RtcConnection object.
   * @param token The token that will expire in 30 seconds.
   */
  virtual void onTokenPrivilegeWillExpire(const RtcConnection& connection, const char* token) {
    (void)connection;
    (void)token;
  }

  /** Occurs when the first local audio frame is published.
   *
   * The SDK triggers this callback under one of the following circumstances:
   * - The local client enables the audio module and calls `joinChannel` successfully.
   * - The local client calls `muteLocalAudioStream(true)` and `muteLocalAudioStream(false)` in sequence.
   * - The local client calls `disableAudio` and `enableAudio` in sequence.
   * - The local client calls `pushAudioFrame` to successfully push the audio frame to the SDK.
   *
   * @param connection The RtcConnection object.
   * @param elapsed The time elapsed (ms) from the local user calling `joinChannel` to the SDK triggers this callback.
   */
  virtual void onFirstLocalAudioFramePublished(const RtcConnection& connection, int elapsed) {
    (void)connection;
    (void)elapsed;
  }

  /** Occurs when the SDK receives the first audio frame from a specific remote user.
   * @deprecated Use `onRemoteAudioStateChanged` instead.
   *
   * @param connection The RtcConnection object.
   * @param userId ID of the remote user.
   * @param elapsed The time elapsed (ms) from the loca user calling `joinChannel`
   * until this callback is triggered.
   */
  virtual void onFirstRemoteAudioFrame(const RtcConnection& connection, uid_t userId, int elapsed) __deprecated {
    (void)connection;
    (void)userId;
    (void)elapsed;
  }

  /**
   * Occurs when the SDK decodes the first remote audio frame for playback.
   *
   * @deprecated Use `onRemoteAudioStateChanged` instead.
   * The SDK triggers this callback under one of the following circumstances:
   * - The remote user joins the channel and sends the audio stream for the first time.
   * - The remote user's audio is offline and then goes online to re-send audio. It means the local user cannot
   * receive audio in 15 seconds. Reasons for such an interruption include:
   *   - The remote user leaves channel.
   *   - The remote user drops offline.
   *   - The remote user calls muteLocalAudioStream to stop sending the audio stream.
   *   - The remote user calls disableAudio to disable audio.
   * @param connection The RtcConnection object.
   * @param uid User ID of the remote user sending the audio stream.
   * @param elapsed The time elapsed (ms) from the loca user calling `joinChannel`
   * until this callback is triggered.
   */
  virtual void onFirstRemoteAudioDecoded(const RtcConnection& connection, uid_t uid, int elapsed) __deprecated {
    (void)connection;
    (void)uid;
    (void)elapsed;
  }

  /** Occurs when the local audio state changes.
   *
   * When the state of the local audio stream changes (including the state of the audio capture and encoding), the SDK
   * triggers this callback to report the current state. This callback indicates the state of the local audio stream,
   * and allows you to troubleshoot issues when audio exceptions occur.
   *
   * @note
   * When the state is `LOCAL_AUDIO_STREAM_STATE_FAILED(3)`, see the `error`
   * parameter for details.
   *
   * @param connection The RtcConnection object.
   * @param state State of the local audio. See #LOCAL_AUDIO_STREAM_STATE.
   * @param reason The reason information of the local audio.
   * See #LOCAL_AUDIO_STREAM_REASON.
   */
  virtual void onLocalAudioStateChanged(const RtcConnection& connection, LOCAL_AUDIO_STREAM_STATE state, LOCAL_AUDIO_STREAM_REASON reason) {
    (void)connection;
    (void)state;
    (void)reason;
  }

  /** Occurs when the remote audio state changes.
   *
   * When the audio state of a remote user (in the voice/video call channel) or host (in the live streaming channel)
   * changes, the SDK triggers this callback to report the current state of the remote audio stream.
   *
   * @note This callback does not work properly when the number of users (in the voice/video call channel) or hosts
   * (in the live streaming channel) in the channel exceeds 17.
   *
   * @param connection The RtcConnection object.
   * @param remoteUid ID of the remote user whose audio state changes.
   * @param state State of the remote audio. See #REMOTE_AUDIO_STATE.
   * @param reason The reason of the remote audio state change.
   * See #REMOTE_AUDIO_STATE_REASON.
   * @param elapsed Time elapsed (ms) from the local user calling the
   * `joinChannel` method until the SDK
   * triggers this callback.
   */
  virtual void onRemoteAudioStateChanged(const RtcConnection& connection, uid_t remoteUid, REMOTE_AUDIO_STATE state, REMOTE_AUDIO_STATE_REASON reason, int elapsed) {
    (void)connection;
    (void)remoteUid;
    (void)state;
    (void)reason;
    (void)elapsed;
  }

  /**
   * Occurs when an active speaker is detected.
   *
   * After a successful call of `enableAudioVolumeIndication`, the SDK continuously detects which remote user has the
   * loudest volume. During the current period, the remote user, who is detected as the loudest for the most times,
   * is the most active user.
   *
   * When the number of users is no less than two and an active remote speaker exists, the SDK triggers this callback and reports the uid of the most active remote speaker.
   * - If the most active remote speaker is always the same user, the SDK triggers the `onActiveSpeaker` callback only once.
   * - If the most active remote speaker changes to another user, the SDK triggers this callback again and reports the uid of the new active remote speaker.
   *
   * @param connection The RtcConnection object.
   * @param uid The ID of the active speaker. A `uid` of 0 means the local user.
   */
  virtual void onActiveSpeaker(const RtcConnection& connection, uid_t uid) {
    (void)connection;
    (void)uid;
  }

  /**
   * Occurs when the user role switches in the interactive live streaming.
   *
   * @param connection The RtcConnection of the local user: #RtcConnection
   * @param oldRole The old role of the user: #CLIENT_ROLE_TYPE
   * @param newRole The new role of the user: #CLIENT_ROLE_TYPE
   * @param newRoleOptions The client role options of the new role: #ClientRoleOptions.
   */
  virtual void onClientRoleChanged(const RtcConnection& connection, CLIENT_ROLE_TYPE oldRole, CLIENT_ROLE_TYPE newRole, const ClientRoleOptions& newRoleOptions) {
    (void)connection;
    (void)oldRole;
    (void)newRole;
    (void)newRoleOptions;
  }

  /**
   * Occurs when the user role in a Live-Broadcast channel fails to switch, for example, from a broadcaster
   * to an audience or vice versa.
   *
   * @param connection The RtcConnection object.
   * @param reason The reason for failing to change the client role: #CLIENT_ROLE_CHANGE_FAILED_REASON.
   * @param currentRole The current role of the user: #CLIENT_ROLE_TYPE.
   */
  virtual void onClientRoleChangeFailed(const RtcConnection& connection, CLIENT_ROLE_CHANGE_FAILED_REASON reason, CLIENT_ROLE_TYPE currentRole) {
    (void)connection;
    (void)reason;
    (void)currentRole;
  }

  /** Reports the transport-layer statistics of each remote audio stream.
   * @deprecated Use `onRemoteAudioStats` instead.

  This callback reports the transport-layer statistics, such as the packet loss rate and network time delay, once every
  two seconds after the local user receives an audio packet from a remote user. During a call, when the user receives
  the audio packet sent by the remote user/host, the callback is triggered every 2 seconds.

  @param connection The RtcConnection object.
  @param remoteUid ID of the remote user whose audio data packet is received.
  @param delay The network time delay (ms) from the sender to the receiver.
  @param lost The Packet loss rate (%) of the audio packet sent from the remote
  user.
  @param rxKBitRate Received bitrate (Kbps) of the audio packet sent from the
  remote user.
  */
  virtual void onRemoteAudioTransportStats(const RtcConnection& connection, uid_t remoteUid, unsigned short delay, unsigned short lost,
                                           unsigned short rxKBitRate) __deprecated {
    (void)connection;
    (void)remoteUid;
    (void)delay;
    (void)lost;
    (void)rxKBitRate;
  }

  /** Reports the transport-layer statistics of each remote video stream.
   * @deprecated Use `onRemoteVideoStats` instead.

  This callback reports the transport-layer statistics, such as the packet loss rate and network time
  delay, once every two seconds after the local user receives a video packet from a remote user.

  During a call, when the user receives the video packet sent by the remote user/host, the callback is
  triggered every 2 seconds.

  @param connection The RtcConnection object.
  @param remoteUid ID of the remote user whose video packet is received.
  @param delay The network time delay (ms) from the remote user sending the
  video packet to the local user.
  @param lost The packet loss rate (%) of the video packet sent from the remote
  user.
  @param rxKBitRate The bitrate (Kbps) of the video packet sent from
  the remote user.
  */
  virtual void onRemoteVideoTransportStats(const RtcConnection& connection, uid_t remoteUid, unsigned short delay, unsigned short lost,
                                           unsigned short rxKBitRate) __deprecated {
    (void)connection;
    (void)remoteUid;
    (void)delay;
    (void)lost;
    (void)rxKBitRate;
  }

  /** Occurs when the network connection state changes.
   *
   * When the network connection state changes, the SDK triggers this callback and reports the current
   * connection state and the reason for the change.
   *
   * @param connection The RtcConnection object.
   * @param state The current connection state. See #CONNECTION_STATE_TYPE.
   * @param reason The reason for a connection state change. See #CONNECTION_CHANGED_REASON_TYPE.
   */
  virtual void onConnectionStateChanged(const RtcConnection& connection,
                                        CONNECTION_STATE_TYPE state,
                                        CONNECTION_CHANGED_REASON_TYPE reason) {
    (void)connection;
    (void)state;
    (void)reason;
  }

  /** Occurs when the WIFI message need be sent to the user.
   *
   * @param connection The RtcConnection object.
   * @param reason The reason of notifying the user of a message.
   * @param action Suggest an action for the user.
   * @param wlAccMsg The message content of notifying the user.
   */
  virtual void onWlAccMessage(const RtcConnection& connection, WLACC_MESSAGE_REASON reason, WLACC_SUGGEST_ACTION action, const char* wlAccMsg) {
    (void)connection;
    (void)reason;
    (void)action;
    (void)wlAccMsg;
  }

  /** Occurs when SDK statistics wifi acceleration optimization effect.
   *
   * @param connection The RtcConnection object.
   * @param currentStats Instantaneous value of optimization effect.
   * @param averageStats Average value of cumulative optimization effect.
   */
  virtual void onWlAccStats(const RtcConnection& connection, WlAccStats currentStats, WlAccStats averageStats) {
    (void)connection;
    (void)currentStats;
    (void)averageStats;
  }

  /** Occurs when the local network type changes.
   *
   * This callback occurs when the connection state of the local user changes. You can get the
   * connection state and reason for the state change in this callback. When the network connection
   * is interrupted, this callback indicates whether the interruption is caused by a network type
   * change or poor network conditions.
   * @param connection The RtcConnection object.
   * @param type The type of the local network connection. See #NETWORK_TYPE.
   */
  virtual void onNetworkTypeChanged(const RtcConnection& connection, NETWORK_TYPE type) {
    (void)connection;
    (void)type;
  }

  /** Reports the built-in encryption errors.
   *
   * When encryption is enabled by calling `enableEncryption`, the SDK triggers this callback if an
   * error occurs in encryption or decryption on the sender or the receiver side.
   * @param connection The RtcConnection object.
   * @param errorType The error type. See #ENCRYPTION_ERROR_TYPE.
   */
  virtual void onEncryptionError(const RtcConnection& connection, ENCRYPTION_ERROR_TYPE errorType) {
    (void)connection;
    (void)errorType;
  }
  /**
   * Reports the user log upload result
   * @param connection The RtcConnection object.
   * @param requestId RequestId of the upload
   * @param success Is upload success
   * @param reason Reason of the upload, 0: OK, 1 Network Error, 2 Server Error.
   */
  virtual void onUploadLogResult(const RtcConnection& connection, const char* requestId, bool success, UPLOAD_ERROR_REASON reason) {
    (void)connection;
    (void)requestId;
    (void)success;
    (void)reason;
  }

  /**
   * Occurs when the user account is updated.
   *
   * @param connection The RtcConnection object.
   * @param remoteUid The user ID.
   * @param userAccount The user account.
   */
  virtual void onUserAccountUpdated(const RtcConnection& connection, uid_t remoteUid, const char* remoteUserAccount){
    (void)connection;
    (void)remoteUid;
    (void)remoteUserAccount;
  }

  /** Reports the result of taking a video snapshot.
   *
   * After a successful `takeSnapshot` method call, the SDK triggers this callback to report whether the snapshot is
   * successfully taken, as well as the details for that snapshot.
   * @param connection The RtcConnection object.
   * @param uid The user ID. A `uid` of 0 indicates the local user.
   * @param filePath The local path of the snapshot.
   * @param width The width (px) of the snapshot.
   * @param height The height (px) of the snapshot.
   * @param errCode The message that confirms success or gives the reason why the snapshot is not successfully taken:
   * - 0: Success.
   * - &lt; 0: Failure.
   *   - -1: The SDK fails to write data to a file or encode a JPEG image.
   *   - -2: The SDK does not find the video stream of the specified user within one second after the `takeSnapshot` method call succeeds.
   *   - -3: Calling the `takeSnapshot` method too frequently. Call the `takeSnapshot` method after receiving the `onSnapshotTaken`
   * callback from the previous call.
   */
  virtual void onSnapshotTaken(const RtcConnection& connection, uid_t uid, const char* filePath, int width, int height, int errCode) {
    (void)uid;
    (void)filePath;
    (void)width;
    (void)height;
    (void)errCode;
  }

  /**
   * Reports the tracing result of video rendering event of the user.
   * 
   * @param connection The RtcConnection object.
   * @param uid The user ID.
   * @param currentEvent The current event of the tracing result: #MEDIA_TRACE_EVENT.
   * @param tracingInfo The tracing result: #VideoRenderingTracingInfo.
   */
  virtual void onVideoRenderingTracingResult(const RtcConnection& connection, uid_t uid, MEDIA_TRACE_EVENT currentEvent, VideoRenderingTracingInfo tracingInfo) {
    (void)uid;
    (void)currentEvent;
    (void)tracingInfo;
  }

  /**
   * Occurs when receive use rtm response.
   *
   * @param connection The RtcConnection object.
   * @param code The error code:
   */
  virtual void onSetRtmFlagResult(const RtcConnection& connection, int code) {
    (void)connection;
    (void)code;
  }
  /**
   * Occurs when receive a video transcoder stream which has video layout info.
   *
   * @param connection The RtcConnection object.
   * @param uid user id of the transcoded stream.
   * @param width width of the transcoded stream.
   * @param height height of the transcoded stream.
   * @param layoutCount count of layout info in the transcoded stream.
   * @param layoutlist video layout info list of the transcoded stream.
   */
  virtual void onTranscodedStreamLayoutInfo(const RtcConnection& connection, uid_t uid, int width, int height, int layoutCount,const VideoLayout* layoutlist) {
    (void)uid;
    (void)width;
    (void)height;
    (void)layoutCount;
    (void)layoutlist;
  }

  /**
   * The audio metadata received.
   *
   * @param connection The RtcConnection object.
   * @param uid ID of the remote user.
   * @param metadata The pointer of metadata
   * @param length Size of metadata
   * @technical preview 
   */
  virtual void onAudioMetadataReceived(const RtcConnection& connection, uid_t uid, const char* metadata, size_t length) {
    (void)metadata;
    (void)length;
  }
};

class IRtcEngineEx : public IRtcEngine {
public:
   /**
    * Joins a channel with media options.
    *
    * This method enables users to join a channel. Users in the same channel can talk to each other,
    * and multiple users in the same channel can start a group chat. Users with different App IDs
    * cannot call each other.
    *
    * A successful call of this method triggers the following callbacks:
    * - The local client: The `onJoinChannelSuccess` and `onConnectionStateChanged` callbacks.
    * - The remote client: `onUserJoined`, if the user joining the channel is in the Communication
    * profile or is a host in the Live-broadcasting profile.
    *
    * When the connection between the client and Agora's server is interrupted due to poor network
    * conditions, the SDK tries reconnecting to the server. When the local client successfully rejoins
    * the channel, the SDK triggers the `onRejoinChannelSuccess` callback on the local client.
    *
    * Compared to `joinChannel`, this method adds the options parameter to configure whether to
    * automatically subscribe to all remote audio and video streams in the channel when the user
    * joins the channel. By default, the user subscribes to the audio and video streams of all
    * the other users in the channel, giving rise to usage and billings. To unsubscribe, set the
    * `options` parameter or call the `mute` methods accordingly.
    *
    * @note
    * - This method allows users to join only one channel at a time.
    * - Ensure that the app ID you use to generate the token is the same app ID that you pass in the
    * `initialize` method; otherwise, you may fail to join the channel by token.
    *
    * @param connection The RtcConnection object.
    * @param token The token generated on your server for authentication.
    * @param options The channel media options: ChannelMediaOptions.
    * @param eventHandler The event handler: IRtcEngineEventHandler.
    *
    * @return
    * - 0: Success.
    * - < 0: Failure.
    *   - -2: The parameter is invalid. For example, the token is invalid, the uid parameter is not set
    * to an integer, or the value of a member in the `ChannelMediaOptions` structure is invalid. You need
    * to pass in a valid parameter and join the channel again.
    *   - -3: Failes to initialize the `IRtcEngine` object. You need to reinitialize the IRtcEngine object.
    *   - -7: The IRtcEngine object has not been initialized. You need to initialize the IRtcEngine
    * object before calling this method.
    *   - -8: The internal state of the IRtcEngine object is wrong. The typical cause is that you call
    * this method to join the channel without calling `stopEchoTest` to stop the test after calling
    * `startEchoTest` to start a call loop test. You need to call `stopEchoTest` before calling this method.
    *   - -17: The request to join the channel is rejected. The typical cause is that the user is in the
    * channel. Agora recommends using the `onConnectionStateChanged` callback to get whether the user is
    * in the channel. Do not call this method to join the channel unless you receive the
    * `CONNECTION_STATE_DISCONNECTED(1)` state.
    *   - -102: The channel name is invalid. You need to pass in a valid channel name in channelId to
    * rejoin the channel.
    *   - -121: The user ID is invalid. You need to pass in a valid user ID in uid to rejoin the channel.
    */
    virtual int joinChannelEx(const char* token, const RtcConnection& connection,
                              const ChannelMediaOptions& options,
                              IRtcEngineEventHandler* eventHandler) = 0;

  /**
   * Leaves the channel.
   *
   * This method allows a user to leave the channel, for example, by hanging up or exiting a call.
   *
   * This method is an asynchronous call, which means that the result of this method returns even before
   * the user has not actually left the channel. Once the user successfully leaves the channel, the
   * SDK triggers the \ref IRtcEngineEventHandler::onLeaveChannel "onLeaveChannel" callback.
   *
   * @param connection The RtcConnection object.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
    virtual int leaveChannelEx(const RtcConnection& connection) = 0;

    /**
     * Leaves the channel with the connection ID.
     *
     * @param connection connection.
     * @param options The options for leaving the channel. See #LeaveChannelOptions.
     * @return int
     * - 0: Success.
     * - < 0: Failure.
     */
    virtual int leaveChannelEx(const RtcConnection& connection, const LeaveChannelOptions& options) = 0;

    /**
     *  Updates the channel media options after joining the channel.
     *
     * @param options The channel media options: ChannelMediaOptions.
     * @param connection The RtcConnection object.
     * @return int
     * - 0: Success.
     * - < 0: Failure.
     */
    virtual int updateChannelMediaOptionsEx(const ChannelMediaOptions& options, const RtcConnection& connection) = 0;
    /**
     * Sets the video encoder configuration.
     *
     * Each configuration profile corresponds to a set of video parameters, including
     * the resolution, frame rate, and bitrate.
     *
     * The parameters specified in this method are the maximum values under ideal network conditions.
     * If the video engine cannot render the video using the specified parameters due
     * to poor network conditions, the parameters further down the list are considered
     * until a successful configuration is found.
     *
     * @param config The local video encoder configuration: VideoEncoderConfiguration.
     * @param connection The RtcConnection object.
     * @return
     * - 0: Success.
     * - < 0: Failure.
     */
    virtual int setVideoEncoderConfigurationEx(const VideoEncoderConfiguration& config, const RtcConnection& connection) = 0;
    /**
     * Initializes the video view of a remote user.
     *
     * This method initializes the video view of a remote stream on the local device. It affects only the
     * video view that the local user sees.
     *
     * Usually the app should specify the `uid` of the remote video in the method call before the
     * remote user joins the channel. If the remote `uid` is unknown to the app, set it later when the
     * app receives the \ref IRtcEngineEventHandler::onUserJoined "onUserJoined" callback.
     *
     * To unbind the remote user from the view, set `view` in VideoCanvas as `null`.
     *
     * @note
     * Ensure that you call this method in the UI thread.
     *
     * @param canvas The remote video view settings: VideoCanvas.
     * @param connection The RtcConnection object.
     * @return
     * - 0: Success.
     * - < 0: Failure.
     */
    virtual int setupRemoteVideoEx(const VideoCanvas& canvas, const RtcConnection& connection) = 0;
    /**
     * Stops or resumes receiving the audio stream of a specified user.
     *
     * @note
     * You can call this method before or after joining a channel. If a user
     * leaves a channel, the settings in this method become invalid.
     *
     * @param uid The ID of the specified user.
     * @param mute Whether to stop receiving the audio stream of the specified user:
     * - true: Stop receiving the audio stream of the specified user.
     * - false: (Default) Resume receiving the audio stream of the specified user.
     * @param connection The RtcConnection object.
     *
     * @return
     * - 0: Success.
     * - < 0: Failure.
     */
    virtual int muteRemoteAudioStreamEx(uid_t uid, bool mute, const RtcConnection& connection) = 0;
    /**
     * Stops or resumes receiving the video stream of a specified user.
     *
     * @note
     * You can call this method before or after joining a channel. If a user
     * leaves a channel, the settings in this method become invalid.
     *
     * @param uid The ID of the specified user.
     * @param mute Whether to stop receiving the video stream of the specified user:
     * - true: Stop receiving the video stream of the specified user.
     * - false: (Default) Resume receiving the video stream of the specified user.
     * @param connection The RtcConnetion object.
     *
     * @return
     * - 0: Success.
     * - < 0: Failure.
     */
    virtual int muteRemoteVideoStreamEx(uid_t uid, bool mute, const RtcConnection& connection) = 0;
    /**
     * Sets the remote video stream type.
     *
     * If the remote user has enabled the dual-stream mode, by default the SDK receives the high-stream video by
     * Call this method to switch to the low-stream video.
     *
     * @note
     * This method applies to scenarios where the remote user has enabled the dual-stream mode using
     * \ref enableDualStreamMode "enableDualStreamMode"(true) before joining the channel.
     *
     * @param uid ID of the remote user sending the video stream.
     * @param streamType Sets the video stream type: #VIDEO_STREAM_TYPE.
     * @param connection The RtcConnection object.
     *
     * @return
     * - 0: Success.
     * - < 0: Failure.
     */
    virtual int setRemoteVideoStreamTypeEx(uid_t uid, VIDEO_STREAM_TYPE streamType, const RtcConnection& connection) = 0;
    /**
     *Stops or resumes sending the local audio stream with connection.
     *
     *@param mute Determines whether to send or stop sending the local audio stream:
     *- true: Stop sending the local audio stream.
     *- false: Send the local audio stream.
     *
     *@param connection The connection of the user ID.
     *
     *@return
     *- 0: Success.
     *- < 0: Failure.
     */
    virtual int muteLocalAudioStreamEx(bool mute, const RtcConnection& connection) = 0;
  
    /**
     *Stops or resumes sending the local video stream with connection.
     *
     *@param mute Determines whether to send or stop sending the local video stream:
     *- true: Stop sending the local video stream.
     *- false: Send the local video stream.
     *
     *@param connection The connection of the user ID.
     *
     *@return
     *- 0: Success.
     *- < 0: Failure.
     */
    virtual int muteLocalVideoStreamEx(bool mute, const RtcConnection& connection) = 0;
    
    /**
     *Stops or resumes receiving all remote audio stream with connection.
     *
     *@param mute Whether to stop receiving remote audio streams:
     *- true: Stop receiving any remote audio stream.
     *- false: Resume receiving all remote audio streams.
     *
     *@param connection The connection of the user ID.
     *
     *@return
     *- 0: Success.
     *- < 0: Failure.
     */
    virtual int muteAllRemoteAudioStreamsEx(bool mute, const RtcConnection& connection) = 0;
  
    /**
     *Stops or resumes receiving all remote video stream with connection.
     *
     *@param mute Whether to stop receiving remote audio streams:
     *- true: Stop receiving any remote audio stream.
     *- false: Resume receiving all remote audio streams.
     *
     *@param connection The connection of the user ID.
     *
     *@return
     *- 0: Success.
     *- < 0: Failure.
     */
    virtual int muteAllRemoteVideoStreamsEx(bool mute, const RtcConnection& connection) = 0;


    /**
     * Sets the blocklist of subscribe remote stream audio.
     *
     * @note
     * If uid is in uidList, the remote user's audio will not be subscribed,
     * even if muteRemoteAudioStream(uid, false) and muteAllRemoteAudioStreams(false) are operated.
     *
     * @param uidList The id list of users who do not subscribe to audio.
     * @param uidNumber The number of uid in uidList.
     * @param connection The RtcConnection object.
     *
     * @return
     * - 0: Success.
     * - < 0: Failure.
     */
    virtual int setSubscribeAudioBlocklistEx(uid_t* uidList, int uidNumber, const RtcConnection& connection) = 0;

    /**
     * Sets the allowlist of subscribe remote stream audio.
     *
     * @note
     * - If uid is in uidList, the remote user's audio will be subscribed,
     * even if muteRemoteAudioStream(uid, true) and muteAllRemoteAudioStreams(true) are operated.
     * - If a user is in the blacklist and whitelist at the same time, the user will not subscribe to audio.
     *
     * @param uidList The id list of users who do subscribe to audio.
     * @param uidNumber The number of uid in uidList.
     * @param connection The RtcConnection object.
     *
     * @return
     * - 0: Success.
     * - < 0: Failure.
     */
    virtual int setSubscribeAudioAllowlistEx(uid_t* uidList, int uidNumber, const RtcConnection& connection) = 0;

    /**
     * Sets the blocklist of subscribe remote stream video.
     *
     * @note
     * If uid is in uidList, the remote user's video will not be subscribed,
     * even if muteRemoteVideoStream(uid, false) and muteAllRemoteVideoStreams(false) are operated.
     *
     * @param uidList The id list of users who do not subscribe to video.
     * @param uidNumber The number of uid in uidList.
     * @param connection The RtcConnection object.
     *
     * @return
     * - 0: Success.
     * - < 0: Failure.
     */
    virtual int setSubscribeVideoBlocklistEx(uid_t* uidList, int uidNumber, const RtcConnection& connection) = 0;

    /**
     * Sets the allowlist of subscribe remote stream video.
     *
     * @note
     * - If uid is in uidList, the remote user's video will be subscribed,
     * even if muteRemoteVideoStream(uid, true) and muteAllRemoteVideoStreams(true) are operated.
     * - If a user is in the blacklist and whitelist at the same time, the user will not subscribe to video.
     *
     * @param uidList The id list of users who do subscribe to video.
     * @param uidNumber The number of uid in uidList.
     * @param connection The RtcConnection object.
     *
     * @return
     * - 0: Success.
     * - < 0: Failure.
     */
    virtual int setSubscribeVideoAllowlistEx(uid_t* uidList, int uidNumber, const RtcConnection& connection) = 0;
    /**
     * Sets the remote video subscription options
     *
     *
     * @param uid ID of the remote user sending the video stream.
     * @param options Sets the video subscription options: VideoSubscriptionOptions.
     * @param connection The RtcConnection object.
     * @return
     * - 0: Success.
     * - < 0: Failure.
     */
    virtual int setRemoteVideoSubscriptionOptionsEx(uid_t uid, const VideoSubscriptionOptions& options, const RtcConnection& connection) = 0;
    /** Sets the sound position and gain of a remote user.

    When the local user calls this method to set the sound position of a remote user, the sound difference between the left and right channels allows the local user to track the real-time position of the remote user, creating a real sense of space. This method applies to massively multiplayer online games, such as Battle Royale games.

    @note
    - For this method to work, enable stereo panning for remote users by calling the \ref agora::rtc::IRtcEngine::enableSoundPositionIndication "enableSoundPositionIndication" method before joining a channel.
    - This method requires hardware support. For the best sound positioning, we recommend using a wired headset.
    - Ensure that you call this method after joining a channel.

    @param uid The ID of the remote user.
    @param pan The sound position of the remote user. The value ranges from -1.0 to 1.0:
    - 0.0: the remote sound comes from the front.
    - -1.0: the remote sound comes from the left.
    - 1.0: the remote sound comes from the right.
    @param gain Gain of the remote user. The value ranges from 0.0 to 100.0. The default value is 100.0 (the original gain of the remote user). The smaller the value, the less the gain.
    @param connection The RtcConnection object.

    @return
    - 0: Success.
    - < 0: Failure.
    */
    virtual int setRemoteVoicePositionEx(uid_t uid, double pan, double gain, const RtcConnection& connection) = 0;
    /** Sets remote user parameters for spatial audio

    @param uid The ID of the remote user.
    @param param Spatial audio parameters. See SpatialAudioParams.
    @param connection The RtcConnection object.

    @return int
    - 0: Success.
    - < 0: Failure.
    */
    virtual int setRemoteUserSpatialAudioParamsEx(uid_t uid, const agora::SpatialAudioParams& params, const RtcConnection& connection) = 0;
    /**
     * Updates the display mode of the video view of a remote user.
     *
     * After initializing the video view of a remote user, you can call this method to update its
     * rendering and mirror modes. This method affects only the video view that the local user sees.
     *
     * @note
     * - Ensure that you have called \ref setupRemoteVideo "setupRemoteVideo" to initialize the remote video
     * view before calling this method.
     * - During a call, you can call this method as many times as necessary to update the display mode
     * of the video view of a remote user.
     *
     * @param uid ID of the remote user.
     * @param renderMode Sets the remote display mode. See #RENDER_MODE_TYPE.
     * @param mirrorMode Sets the mirror type. See #VIDEO_MIRROR_MODE_TYPE.
     * @param connection The RtcConnection object.
     *
     * @return
     * - 0: Success.
     * - < 0: Failure.
     */
    virtual int setRemoteRenderModeEx(uid_t uid, media::base::RENDER_MODE_TYPE renderMode,
                                      VIDEO_MIRROR_MODE_TYPE mirrorMode, const RtcConnection& connection) = 0;
    /** Enables loopback recording.
     *
     * If you enable loopback recording, the output of the default sound card is mixed into
     * the audio stream sent to the other end.
     *
     * @note This method is for Windows only.
     *
     * @param connection The RtcConnection object.
     * @param enabled Sets whether to enable/disable loopback recording.
     * - true: Enable loopback recording.
     * - false: (Default) Disable loopback recording.
     * @param deviceName Pointer to the device name of the sound card. The default value is NULL (the default sound card).
     * - This method is for macOS and Windows only.
     * - macOS does not support loopback capturing of the default sound card. If you need to use this method,
     * please use a virtual sound card and pass its name to the deviceName parameter. Agora has tested and recommends using soundflower.
     * @return
     * - 0: Success.
     * - < 0: Failure.
     */
    virtual int enableLoopbackRecordingEx(const RtcConnection& connection, bool enabled, const char* deviceName = NULL) = 0;
    
    /**
     * Adjusts the recording volume.
     *
     * @param volume The recording volume, which ranges from 0 to 400:
     * - 0  : Mute the recording volume.
     * - 100: The original volume.
     * - 400: (Maximum) Four times the original volume with signal clipping protection.
     *
     * @param connection The RtcConnection object.
     *
     * @return
     * - 0  : Success.
     * - < 0: Failure.
     */
    virtual int adjustRecordingSignalVolumeEx(int volume, const RtcConnection& connection) = 0;
    
    /**
     * Mute or resume recording signal volume.
     *
     * @param mute Determines whether to mute or resume the recording signal volume.
     * -  true: Mute the recording signal volume.
     * - false: (Default) Resume the recording signal volume.
     *
     * @param connection The RtcConnection object.
     *
     * @return
     * - 0  : Success.
     * - < 0: Failure.
     */
    virtual int muteRecordingSignalEx(bool mute, const RtcConnection& connection) = 0;

    /**
     * Adjust the playback signal volume of a specified remote user.
     * You can call this method as many times as necessary to adjust the playback volume of different remote users, or to repeatedly adjust the playback volume of the same remote user.
     * 
     * @note
     * The playback volume here refers to the mixed volume of a specified remote user.
     * This method can only adjust the playback volume of one specified remote user at a time. To adjust the playback volume of different remote users, call the method as many times, once for each remote user.
     * 
     * @param uid The ID of the remote user.
     * @param volume The playback volume of the specified remote user. The value ranges between 0 and 400, including the following:
     * 
     * - 0: Mute.
     * - 100: (Default) Original volume.
     * @param connection  RtcConnection
     * 
     * @return
     * - 0: Success.
     * - < 0: Failure.
     */    
    virtual int adjustUserPlaybackSignalVolumeEx(uid_t uid, int volume, const RtcConnection& connection) = 0;

    /** Gets the current connection state of the SDK.
     @param connection The RtcConnection object.
     @return #CONNECTION_STATE_TYPE.
     */
    virtual CONNECTION_STATE_TYPE getConnectionStateEx(const RtcConnection& connection) = 0;
    /** Enables/Disables the built-in encryption.
     *
     * In scenarios requiring high security, Agora recommends calling this method to enable the built-in encryption before joining a channel.
     *
     * All users in the same channel must use the same encryption mode and encryption key. Once all users leave the channel, the encryption key of this channel is automatically cleared.
     *
     * @note
     * - If you enable the built-in encryption, you cannot use the RTMP streaming function.
     *
     * @param connection The RtcConnection object.
     * @param enabled Whether to enable the built-in encryption:
     * - true: Enable the built-in encryption.
     * - false: Disable the built-in encryption.
     * @param config Configurations of built-in encryption schemas. See EncryptionConfig.
     *
     * @return
     * - 0: Success.
     * - < 0: Failure.
     *  - -2(ERR_INVALID_ARGUMENT): An invalid parameter is used. Set the parameter with a valid value.
     *  - -4(ERR_NOT_SUPPORTED): The encryption mode is incorrect or the SDK fails to load the external encryption library. Check the enumeration or reload the external encryption library.
     *  - -7(ERR_NOT_INITIALIZED): The SDK is not initialized. Initialize the `IRtcEngine` instance before calling this method.
     */
    virtual int enableEncryptionEx(const RtcConnection& connection, bool enabled, const EncryptionConfig& config) = 0;
    /** Creates a data stream.
     *
     * You can call this method to create a data stream and improve the
     * reliability and ordering of data tranmission.
     *
     * @note
     * - Ensure that you set the same value for `reliable` and `ordered`.
     * - Each user can only create a maximum of 5 data streams during a RtcEngine
     * lifecycle.
     * - The data channel allows a data delay of up to 5 seconds. If the receiver
     * does not receive the data stream within 5 seconds, the data channel reports
     * an error.
     *
     * @param[out] streamId The ID of the stream data.
     * @param reliable Sets whether the recipients are guaranteed to receive
     * the data stream from the sender within five seconds:
     * - true: The recipients receive the data stream from the sender within
     * five seconds. If the recipient does not receive the data stream within
     * five seconds, an error is reported to the application.
     * - false: There is no guarantee that the recipients receive the data stream
     * within five seconds and no error message is reported for any delay or
     * missing data stream.
     * @param ordered Sets whether the recipients receive the data stream
     * in the sent order:
     * - true: The recipients receive the data stream in the sent order.
     * - false: The recipients do not receive the data stream in the sent order.
     * @param connection The RtcConnection object.
     *
     * @return
     * - 0: Success.
     * - < 0: Failure.
     */
    virtual int createDataStreamEx(int* streamId, bool reliable, bool ordered, const RtcConnection& connection) = 0;
    /** Creates a data stream.
     *
     * Each user can create up to five data streams during the lifecycle of the IChannel.
     * @param streamId The ID of the created data stream.
     * @param config  The config of data stream.
     * @param connection The RtcConnection object.
     * @return int
     * - Returns 0: Success.
     * - < 0: Failure.
     */
    virtual int createDataStreamEx(int* streamId, const DataStreamConfig& config, const RtcConnection& connection) = 0;
    /** Sends a data stream.
     *
     * After calling \ref IRtcEngine::createDataStream "createDataStream", you can call
     * this method to send a data stream to all users in the channel.
     *
     * The SDK has the following restrictions on this method:
     * - Up to 60 packets can be sent per second in a channel with each packet having a maximum size of 1 KB.
     * - Each client can send up to 30 KB of data per second.
     * - Each user can have up to five data streams simultaneously.
     *
     * After the remote user receives the data stream within 5 seconds, the SDK triggers the
     * \ref IRtcEngineEventHandler::onStreamMessage "onStreamMessage" callback on
     * the remote client. After the remote user does not receive the data stream within 5 seconds,
     * the SDK triggers the \ref IRtcEngineEventHandler::onStreamMessageError "onStreamMessageError"
     * callback on the remote client.
     *
     * @note
     * - Call this method after calling \ref IRtcEngine::createDataStream "createDataStream".
     * - This method applies only to the `COMMUNICATION` profile or to
     * the hosts in the `LIVE_BROADCASTING` profile. If an audience in the
     * `LIVE_BROADCASTING` profile calls this method, the audience may be switched to a host.
     *
     * @param streamId The ID of the stream data.
     * @param data The data stream.
     * @param length The length (byte) of the data stream.
     * @param connection The RtcConnection object.
     *
     * @return
     * - 0: Success.
     * - < 0: Failure.
     */
    virtual int sendStreamMessageEx(int streamId, const char* data, size_t length, const RtcConnection& connection) = 0;
    /** Adds a watermark image to the local video.

    This method adds a PNG watermark image to the local video in a live broadcast. Once the watermark image is added, all the audience in the channel (CDN audience included),
    and the recording device can see and capture it. Agora supports adding only one watermark image onto the local video, and the newly watermark image replaces the previous one.

    The watermark position depends on the settings in the \ref IRtcEngine::setVideoEncoderConfiguration "setVideoEncoderConfiguration" method:
    - If the orientation mode of the encoding video is #ORIENTATION_MODE_FIXED_LANDSCAPE, or the landscape mode in #ORIENTATION_MODE_ADAPTIVE, the watermark uses the landscape orientation.
    - If the orientation mode of the encoding video is #ORIENTATION_MODE_FIXED_PORTRAIT, or the portrait mode in #ORIENTATION_MODE_ADAPTIVE, the watermark uses the portrait orientation.
    - When setting the watermark position, the region must be less than the dimensions set in the `setVideoEncoderConfiguration` method. Otherwise, the watermark image will be cropped.

    @note
    - Ensure that you have called the \ref agora::rtc::IRtcEngine::enableVideo "enableVideo" method to enable the video module before calling this method.
    - If you only want to add a watermark image to the local video for the audience in the CDN live broadcast channel to see and capture, you can call this method or the \ref agora::rtc::IRtcEngine::setLiveTranscoding "setLiveTranscoding" method.
    - This method supports adding a watermark image in the PNG file format only. Supported pixel formats of the PNG image are RGBA, RGB, Palette, Gray, and Alpha_gray.
    - If the dimensions of the PNG image differ from your settings in this method, the image will be cropped or zoomed to conform to your settings.
    - If you have enabled the local video preview by calling the \ref agora::rtc::IRtcEngine::startPreview "startPreview" method, you can use the `visibleInPreview` member in the WatermarkOptions class to set whether or not the watermark is visible in preview.
    - If you have enabled the mirror mode for the local video, the watermark on the local video is also mirrored. To avoid mirroring the watermark, Agora recommends that you do not use the mirror and watermark functions for the local video at the same time. You can implement the watermark function in your application layer.

    @param watermarkUrl The local file path of the watermark image to be added. This method supports adding a watermark image from the local absolute or relative file path.
    @param options Pointer to the watermark's options to be added. See WatermarkOptions for more infomation.
    @param connection The RtcConnection object.

    @return int
    - 0: Success.
    - < 0: Failure.
    */
    virtual int addVideoWatermarkEx(const char* watermarkUrl, const WatermarkOptions& options, const RtcConnection& connection) = 0;
    /** Removes the watermark image on the video stream added by
    addVideoWatermark().

    @param connection The RtcConnection object.
    @return
    - 0: Success.
    - < 0: Failure.
    */
    virtual int clearVideoWatermarkEx(const RtcConnection& connection) = 0;
    /** Agora supports reporting and analyzing customized messages.
     *
     * This function is in the beta stage with a free trial. The ability provided
     * in its beta test version is reporting a maximum of 10 message pieces within
     * 6 seconds, with each message piece not exceeding 256 bytes.
     *
     * To try out this function, contact [support@agora.io](mailto:support@agora.io)
     * and discuss the format of customized messages with us.
     */
    virtual int sendCustomReportMessageEx(const char* id, const char* category, const char* event, const char* label,
                                          int value, const RtcConnection& connection) = 0;

    /**
     * Enables the `onAudioVolumeIndication` callback to report on which users are speaking
     * and the speakers' volume.
     *
     * Once the \ref IRtcEngineEventHandler::onAudioVolumeIndication "onAudioVolumeIndication"
     * callback is enabled, the SDK returns the volume indication in the at the time interval set
     * in `enableAudioVolumeIndication`, regardless of whether any user is speaking in the channel.
     *
     * @param interval Sets the time interval between two consecutive volume indications:
     * - <= 0: Disables the volume indication.
     * - > 0: Time interval (ms) between two consecutive volume indications,
     * and should be integral multiple of 200 (less than 200 will be set to 200).
     * @param smooth The smoothing factor that sets the sensitivity of the audio volume
     * indicator. The value range is [0, 10]. The greater the value, the more sensitive the
     * indicator. The recommended value is 3.
     * @param reportVad
     * - `true`: Enable the voice activity detection of the local user. Once it is enabled, the `vad` parameter of the
     * `onAudioVolumeIndication` callback reports the voice activity status of the local user.
     * - `false`: (Default) Disable the voice activity detection of the local user. Once it is disabled, the `vad` parameter
     * of the `onAudioVolumeIndication` callback does not report the voice activity status of the local user, except for
     * the scenario where the engine automatically detects the voice activity of the local user.
     * @param connection The RtcConnection object.
     * @return
     * - 0: Success.
     * - < 0: Failure.
     */
    virtual int enableAudioVolumeIndicationEx(int interval, int smooth, bool reportVad, const RtcConnection& connection) = 0;
  
    /** Publishes the local stream without transcoding to a specified CDN live RTMP address.  (CDN live only.)
      *
      * @param url The CDN streaming URL in the RTMP format. The maximum length of this parameter is 1024 bytes.
      * @param connection RtcConnection.
      *
      * @return
      * - 0: Success.
      * - < 0: Failure.
      */
    virtual int startRtmpStreamWithoutTranscodingEx(const char* url, const RtcConnection& connection) = 0;
  
    /** Publishes the local stream with transcoding to a specified CDN live RTMP address.  (CDN live only.)
      *
      * @param url The CDN streaming URL in the RTMP format. The maximum length of this parameter is 1024 bytes.
      * @param transcoding Sets the CDN live audio/video transcoding settings.  See LiveTranscoding.
      * @param connection RtcConnection.
      *
      * @return
      * - 0: Success.
      * - < 0: Failure.
      */
    virtual int startRtmpStreamWithTranscodingEx(const char* url, const LiveTranscoding& transcoding, const RtcConnection& connection) = 0;
  
    /** Update the video layout and audio settings for CDN live. (CDN live only.)
      * @note This method applies to Live Broadcast only.
      *
      * @param transcoding Sets the CDN live audio/video transcoding settings. See LiveTranscoding.
      * @param connection RtcConnection.
      *
      * @return
      * - 0: Success.
      * - < 0: Failure.
      */
    virtual int updateRtmpTranscodingEx(const LiveTranscoding& transcoding, const RtcConnection& connection) = 0;
  
    /** Stop an RTMP stream with transcoding or without transcoding from the CDN. (CDN live only.)
      * @param url The RTMP URL address to be removed. The maximum length of this parameter is 1024 bytes.
      * @param connection RtcConnection.
      * @return
      * - 0: Success.
      * - < 0: Failure.
      */
    virtual int stopRtmpStreamEx(const char* url, const RtcConnection& connection) = 0;
  
    /** Starts relaying media streams across channels or updates the channels for media relay.
     *
     * @since v4.2.0
     * @param configuration The configuration of the media stream relay:ChannelMediaRelayConfiguration.
     * @param connection RtcConnection.
     * @return
     * - 0: Success.
     * - < 0: Failure.
     *   - -1(ERR_FAILED): A general error occurs (no specified reason).
     *   - -2(ERR_INVALID_ARGUMENT): The argument is invalid.
     *   - -5(ERR_REFUSED): The request is rejected.
     *   - -8(ERR_INVALID_STATE): The current status is invalid, only allowed to be called when the role is the broadcaster.
     */
    virtual int startOrUpdateChannelMediaRelayEx(const ChannelMediaRelayConfiguration& configuration, const RtcConnection& connection) = 0;
  
    /** Stops the media stream relay.
     *
     * Once the relay stops, the host quits all the destination
     * channels.
     *
     * @param connection RtcConnection.
     * @return
     * - 0: Success.
     * - < 0: Failure.
     *   - -1(ERR_FAILED): A general error occurs (no specified reason).
     *   - -2(ERR_INVALID_ARGUMENT): The argument is invalid.
     *   - -5(ERR_REFUSED): The request is rejected.
     *   - -7(ERR_NOT_INITIALIZED): cross channel media streams are not relayed.
     */
    virtual int stopChannelMediaRelayEx(const RtcConnection& connection) = 0;
  
    /** pause the channels for media stream relay.
     *
     * @param connection RtcConnection.
     * @return
     * - 0: Success.
     * - < 0: Failure.
     *   - -1(ERR_FAILED): A general error occurs (no specified reason).
     *   - -2(ERR_INVALID_ARGUMENT): The argument is invalid.
     *   - -5(ERR_REFUSED): The request is rejected.
     *   - -7(ERR_NOT_INITIALIZED): cross channel media streams are not relayed.
     */
    virtual int pauseAllChannelMediaRelayEx(const RtcConnection& connection) = 0;

    /** resume the channels for media stream relay.
     *
     * @param connection RtcConnection.
     * @return
     * - 0: Success.
     * - < 0: Failure.
     *   - -1(ERR_FAILED): A general error occurs (no specified reason).
     *   - -2(ERR_INVALID_ARGUMENT): The argument is invalid.
     *   - -5(ERR_REFUSED): The request is rejected.
     *   - -7(ERR_NOT_INITIALIZED): cross channel media streams are not relayed.
     */
    virtual int resumeAllChannelMediaRelayEx(const RtcConnection& connection) = 0;

   /** Gets the user information by passing in the user account.
    *  It is same as agora::rtc::IRtcEngine::getUserInfoByUserAccount.
    *
    * @param userAccount The user account of the user. Ensure that you set this parameter.
    * @param [in,out] userInfo  A userInfo object that identifies the user:
    * - Input: A userInfo object.
    * - Output: A userInfo object that contains the user account and user ID of the user.
    * @param connection The RtcConnection object.
    *
    * @return
    * - 0: Success.
    * - < 0: Failure.
    */
    virtual int getUserInfoByUserAccountEx(const char* userAccount, rtc::UserInfo* userInfo, const RtcConnection& connection) = 0;

    /** Gets the user information by passing in the user ID.
    *  It is same as agora::rtc::IRtcEngine::getUserInfoByUid.
    *
    * @param uid The user ID of the remote user. Ensure that you set this parameter.
    * @param[in,out] userInfo A userInfo object that identifies the user:
    * - Input: A userInfo object.
    * - Output: A userInfo object that contains the user account and user ID of the user.
    * @param connection The RtcConnection object.
    *
    * @return
    * - 0: Success.
    * - < 0: Failure.
    */
    virtual int getUserInfoByUidEx(uid_t uid, rtc::UserInfo* userInfo, const RtcConnection& connection) = 0;

     /**
     * Enables or disables the dual video stream mode.
     *
     * @deprecated v4.2.0. This method is deprecated. Use setDualStreamModeEx instead
     *
     * If dual-stream mode is enabled, the subscriber can choose to receive the high-stream
     * (high-resolution high-bitrate video stream) or low-stream (low-resolution low-bitrate video
     * stream) video using {@link setRemoteVideoStreamType setRemoteVideoStreamType}.
     *
     * @param enabled
     * - true: Enable the dual-stream mode.
     * - false: (default) Disable the dual-stream mode.
     * @param streamConfig The minor stream config
     * @param connection The RtcConnection object.
     */
    virtual int enableDualStreamModeEx(bool enabled, const SimulcastStreamConfig& streamConfig,
                                       const RtcConnection& connection) = 0;
    /**
     * Enables, disables or auto enable the dual video stream mode.
     *
     * If dual-stream mode is enabled, the subscriber can choose to receive the high-stream
     * (high-resolution high-bitrate video stream) or low-stream (low-resolution low-bitrate video
     * stream) video using {@link setRemoteVideoStreamType setRemoteVideoStreamType}.
     *
     * @param mode The dual stream mode: #SIMULCAST_STREAM_MODE.
     * @param streamConfig The configuration of the low stream: SimulcastStreamConfig.
     * @param connection The RtcConnection object.
     */
    virtual int setDualStreamModeEx(SIMULCAST_STREAM_MODE mode,
                                   const SimulcastStreamConfig& streamConfig,
                                   const RtcConnection& connection) = 0;
    
  /**
    * Set the high priority user list and their fallback level in weak network condition.
    *
    * @note
    * - This method can be called before and after joining a channel.
    * - If a subscriber is set to high priority, this stream only fallback to lower stream after all normal priority users fallback to their fallback level on weak network condition if needed.
    *
    * @param uidList The high priority user list.
    * @param uidNum The size of uidList.
    * @param option The fallback level of high priority users.
    * @param connection An output parameter which is used to control different connection instances.
    *
    * @return int
    * - 0 : Success.
    * - <0 : Failure.
    */
    virtual int setHighPriorityUserListEx(uid_t* uidList, int uidNum,
                                          STREAM_FALLBACK_OPTIONS option,
                                          const RtcConnection& connection) = 0;

  /**
   * Takes a snapshot of a video stream.
   *
   * This method takes a snapshot of a video stream from the specified user, generates a JPG
   * image, and saves it to the specified path.
   *
   * The method is asynchronous, and the SDK has not taken the snapshot when the method call
   * returns. After a successful method call, the SDK triggers the `onSnapshotTaken` callback
   * to report whether the snapshot is successfully taken, as well as the details for that
   * snapshot.
   *
   * @note
   * - Call this method after joining a channel.
   * - This method takes a snapshot of the published video stream specified in `ChannelMediaOptions`.
   * - If the user's video has been preprocessed, for example, watermarked or beautified, the resulting
   * snapshot includes the pre-processing effect.
   * @param connection The RtcConnection object.
   * @param uid The user ID. Set uid as 0 if you want to take a snapshot of the local user's video.
   * @param filePath The local path (including filename extensions) of the snapshot. For example:
   * - Windows: `C:\Users\<user_name>\AppData\Local\Agora\<process_name>\example.jpg`
   * - iOS: `/App Sandbox/Library/Caches/example.jpg`
   * - macOS: `～/Library/Logs/example.jpg`
   * - Android: `/storage/emulated/0/Android/data/<package name>/files/example.jpg`
   *
   * Ensure that the path you specify exists and is writable.
   * @return
   * - 0 : Success.
   * - < 0 : Failure.
   */
    virtual int takeSnapshotEx(const RtcConnection& connection, uid_t uid, const char* filePath)  = 0;

    /** Enables video screenshot and upload with the connection ID.
    @param enabled Whether to enable video screenshot and upload:
    - `true`: Yes.
    - `false`: No.
    @param config The configuration for video screenshot and upload.
    @param connection The connection information. See RtcConnection.
    @return
    - 0: Success.
    - < 0: Failure.
    */
    virtual int enableContentInspectEx(bool enabled, const media::ContentInspectConfig &config, const RtcConnection& connection) = 0;

    /**
     @brief Start tracing media rendering events.
     @since v4.1.1
     @discussion
     - SDK will trace media rendering events when this API is called.
     - The tracing result can be obtained through callback `IRtcEngineEventHandler(Ex)::onVideoRenderingTracingResult`
     @param connection The RtcConnection object.
     @note
     - By default, SDK will trace media rendering events when `IRtcEngineEx::joinChannelEx` is called.
     - The start point of event tracing will be reset after leaving channel.
     @return
     - 0: Success.
     - < 0: Failure.
      - -2(ERR_INVALID_ARGUMENT): The parameter is invalid. Check the channel ID and local uid set by parameter `connection`.
      - -7(ERR_NOT_INITIALIZED): The SDK is not initialized. Initialize the `IRtcEngine` instance before calling this method.
     */
    virtual int startMediaRenderingTracingEx(const RtcConnection& connection) = 0;

    /** Provides the technical preview functionalities or special customizations by configuring the SDK with JSON options.
    @since v4.3.0
    @param connection The connection information. See RtcConnection.
    @param parameters Pointer to the set parameters in a JSON string.
    @return
    - 0: Success.
    - < 0: Failure.
    */
    virtual int setParametersEx(const RtcConnection& connection, const char* parameters) = 0;

    /**
     * Gets the current call ID.
     *
     * When a user joins a channel on a client, a `callId` is generated to identify
     * the call.
     *
     * After a call ends, you can call `rate` or `complain` to gather feedback from the customer.
     * These methods require a `callId` parameter. To use these feedback methods, call the this
     * method first to retrieve the `callId` during the call, and then pass the value as an
     * argument in the `rate` or `complain` method after the call ends.
     *
     * @param callId The reference to the call ID.
     * @param connection The RtcConnection object.
     * @return
     * - The call ID if the method call is successful.
     * - < 0: Failure.
    */
    virtual int getCallIdEx(agora::util::AString& callId, const RtcConnection& connection) = 0;

    /**
     * send audio metadata
     * @since v4.3.1
     * @param connection The RtcConnection object.
     * @param metadata The pointer of metadata
     * @param length Size of metadata
     * @return
     * - 0: success
     * - <0: failure
     * @technical preview
    */
    virtual int sendAudioMetadataEx(const RtcConnection& connection, const char* metadata, size_t length) = 0;
};

}  // namespace rtc
}  // namespace agora
