//
//  AgoraRtcEngine SDK
//
//  Copyright (c) 2019 Agora.io. All rights reserved.
//

#ifndef IAgoraRtcChannel_h
#define IAgoraRtcChannel_h
#include "IAgoraRtcEngine.h"

namespace agora {
namespace rtc {
/** The IChannel class. */
class IChannel;
/** The IChannelEventHandler class. */
class IChannelEventHandler {
 public:
  virtual ~IChannelEventHandler() {}
  /** Reports the warning code of `IChannel`.

   @param rtcChannel IChannel
   @param warn The warning code: #WARN_CODE_TYPE
   @param msg The warning message.

   */
  virtual void onChannelWarning(IChannel* rtcChannel, int warn, const char* msg) {
    (void)rtcChannel;
    (void)warn;
    (void)msg;
  }
  /** Reports the error code of `IChannel`.

   @param rtcChannel IChannel
   @param err The error code: #ERROR_CODE_TYPE
   @param msg The error message.
   */
  virtual void onChannelError(IChannel* rtcChannel, int err, const char* msg) {
    (void)rtcChannel;
    (void)err;
    (void)msg;
  }
  /** Occurs when a user joins a channel.

   This callback notifies the application that a user joins a specified channel.

   @param rtcChannel IChannel
   @param uid The user ID. If the `uid` is not specified in the \ref IChannel::joinChannel "joinChannel" method, the server automatically assigns a `uid`.

   @param elapsed Time elapsed (ms) from the local user calling \ref IChannel::joinChannel "joinChannel" until this callback is triggered.
   */
  virtual void onJoinChannelSuccess(IChannel* rtcChannel, uid_t uid, int elapsed) {
    (void)rtcChannel;
    (void)uid;
    (void)elapsed;
  }
  /** Occurs when a user rejoins the channel after being disconnected due to network problems.

   @param rtcChannel IChannel
   @param uid The user ID.
   @param elapsed Time elapsed (ms) from the local user starting to reconnect until this callback is triggered.

   */
  virtual void onRejoinChannelSuccess(IChannel* rtcChannel, uid_t uid, int elapsed) {
    (void)rtcChannel;
    (void)uid;
    (void)elapsed;
  }
  /** Occurs when a user leaves the channel.

   This callback notifies the application that a user leaves the channel when the application calls the \ref agora::rtc::IChannel::leaveChannel "leaveChannel" method.

   The application gets information, such as the call duration and statistics.

   @param rtcChannel IChannel
   @param stats The call statistics: RtcStats.
   */
  virtual void onLeaveChannel(IChannel* rtcChannel, const RtcStats& stats) {
    (void)rtcChannel;
    (void)stats;
  }
  /** Occurs when the user role switches in the interactive live streaming. For example, from a host to an audience or vice versa.

   This callback notifies the application of a user role switch when the application calls the \ref IChannel::setClientRole "setClientRole" method.

   The SDK triggers this callback when the local user switches the user role by calling the \ref IChannel::setClientRole "setClientRole" method after joining the channel.

   @param rtcChannel IChannel
   @param oldRole Role that the user switches from: #CLIENT_ROLE_TYPE.
   @param newRole Role that the user switches to: #CLIENT_ROLE_TYPE.
   */
  virtual void onClientRoleChanged(IChannel* rtcChannel, CLIENT_ROLE_TYPE oldRole, CLIENT_ROLE_TYPE newRole) {
    (void)rtcChannel;
    (void)oldRole;
    (void)newRole;
  }

  /// @cond nodoc
  virtual void onClientRoleChangeFailed(IChannel* rtcChannel, CLIENT_ROLE_CHANGE_FAILED_REASON reason, CLIENT_ROLE_TYPE currentRole) {
    (void)rtcChannel;
    (void)reason;
    (void)currentRole;
  }
  /// @endcond

  /** Occurs when a remote user (`COMMUNICATION`)/ host (`LIVE_BROADCASTING`) joins the channel.

   - `COMMUNICATION` profile: This callback notifies the application that another user joins the channel. If other users are already in the channel, the SDK also reports to the application on the existing users.
   - `LIVE_BROADCASTING` profile: This callback notifies the application that the host joins the channel. If other hosts are already in the channel, the SDK also reports to the application on the existing hosts. We recommend limiting the number of hosts to 17.

   The SDK triggers this callback under one of the following circumstances:
   - A remote user/host joins the channel by calling the \ref agora::rtc::IChannel::joinChannel "joinChannel" method.
   - A remote user switches the user role to the host by calling the \ref agora::rtc::IChannel::setClientRole "setClientRole" method after joining the channel.
   - A remote user/host rejoins the channel after a network interruption.
   - The host injects an online media stream into the channel by calling the \ref agora::rtc::IChannel::addInjectStreamUrl "addInjectStreamUrl" method.

   @note In the `LIVE_BROADCASTING` profile:
   - The host receives this callback when another host joins the channel.
   - The audience in the channel receives this callback when a new host joins the channel.
   - When a web application joins the channel, the SDK triggers this callback as long as the web application publishes streams.

   @param rtcChannel IChannel
   @param uid User ID of the user or host joining the channel.
   @param elapsed Time delay (ms) from the local user calling the \ref IChannel::joinChannel "joinChannel" method until the SDK triggers this callback.
   */
  virtual void onUserJoined(IChannel* rtcChannel, uid_t uid, int elapsed) {
    (void)rtcChannel;
    (void)uid;
    (void)elapsed;
  }
  /** Occurs when a remote user ( `COMMUNICATION`)/host (`LIVE_BROADCASTING`) leaves the channel.

   Reasons why the user is offline:

   - Leave the channel: When the user/host leaves the channel, the user/host sends a goodbye message. When the message is received, the SDK assumes that the user/host leaves the channel.
   - Drop offline: When no data packet of the user or host is received for a certain period of time, the SDK assumes that the user/host drops offline. Unreliable network connections may lead to false detections, so we recommend using the Agora RTM SDK for more reliable offline detection.

   @param rtcChannel IChannel
   @param uid User ID of the user leaving the channel or going offline.
   @param reason Reason why the user is offline: #USER_OFFLINE_REASON_TYPE.
   */
  virtual void onUserOffline(IChannel* rtcChannel, uid_t uid, USER_OFFLINE_REASON_TYPE reason) {
    (void)rtcChannel;
    (void)uid;
    (void)reason;
  }
  /** Occurs when the SDK cannot reconnect to Agora's edge server 10 seconds after its connection to the server is interrupted.

   The SDK triggers this callback when it cannot connect to the server 10 seconds after calling the \ref IChannel::joinChannel "joinChannel" method, whether or not it is in the channel.

   This callback is different from \ref agora::rtc::IRtcEngineEventHandler::onConnectionInterrupted "onConnectionInterrupted":

   - The SDK triggers the `onConnectionInterrupted` callback when it loses connection with the server for more than four seconds after it successfully joins the channel.
   - The SDK triggers the `onConnectionLost` callback when it loses connection with the server for more than 10 seconds, whether or not it joins the channel.

   If the SDK fails to rejoin the channel 20 minutes after being disconnected from Agora's edge server, the SDK stops rejoining the channel.

   @param rtcChannel IChannel
   */
  virtual void onConnectionLost(IChannel* rtcChannel) { (void)rtcChannel; }
  /** Occurs when the token expires.

   After a token is specified by calling the \ref IChannel::joinChannel "joinChannel" method, if the SDK losses connection with the Agora server due to network issues, the token may expire after a certain period of time and a new token may be required to reconnect to the server.

   Once you receive this callback, generate a new token on your app server, and call
   \ref agora::rtc::IChannel::renewToken "renewToken" to pass the new token to the SDK.

   @param rtcChannel IChannel
   */
  virtual void onRequestToken(IChannel* rtcChannel) { (void)rtcChannel; }
  /** Occurs when the token expires in 30 seconds.

   The user becomes offline if the token used in the \ref IChannel::joinChannel "joinChannel" method expires. The SDK triggers this callback 30 seconds before the token expires to remind the application to get a new token. Upon receiving this callback, generate a new token on the server and call the \ref IChannel::renewToken "renewToken" method to pass the new token to the SDK.

   @param rtcChannel IChannel
   @param token Token that expires in 30 seconds.
   */
  virtual void onTokenPrivilegeWillExpire(IChannel* rtcChannel, const char* token) {
    (void)rtcChannel;
    (void)token;
  }
  /** Reports the statistics of the current call.

   The SDK triggers this callback once every two seconds after the user joins the channel.

   @param rtcChannel IChannel
   @param stats Statistics of the RtcEngine: RtcStats.
   */
  virtual void onRtcStats(IChannel* rtcChannel, const RtcStats& stats) {
    (void)rtcChannel;
    (void)stats;
  }
  /** Reports the last mile network quality of each user in the channel once every two seconds.
   *
   * Last mile refers to the connection between the local device and Agora's edge server. This callback reports once every
   * two seconds the last mile network conditions of each user in the channel. If a channel includes multiple users, the
   * SDK triggers this callback as many times.
   *
   * @note `txQuality` is `UNKNOWN` when the user is not sending a stream; `rxQuality` is `UNKNOWN` when the user is not receiving a stream.
   *
   * @param rtcChannel IChannel
   * @param uid User ID. The network quality of the user with this @p uid is reported. If @p uid is 0, the local network quality is reported.
   * @param txQuality Uplink transmission quality rating of the user in terms of the transmission bitrate, packet loss rate, average RTT (Round-Trip Time), and jitter of the uplink network. @p txQuality is a quality rating helping you understand how well the current uplink network conditions can support the selected VideoEncoderConfiguration. For example, a 1000 Kbps uplink network may be adequate for video frames with a resolution of 640 * 480 and a frame rate of 15 fps in the `LIVE_BROADCASTING` profile, but may be inadequate for resolutions higher than 1280 * 720. See #QUALITY_TYPE.
   * @param rxQuality Downlink network quality rating of the user in terms of the packet loss rate, average RTT, and jitter of the downlink network. See #QUALITY_TYPE.
   */
  virtual void onNetworkQuality(IChannel* rtcChannel, uid_t uid, int txQuality, int rxQuality) {
    (void)rtcChannel;
    (void)uid;
    (void)txQuality;
    (void)rxQuality;
  }
  /** Reports the statistics of the video stream from each remote user/host.
   *
   * The SDK triggers this callback once every two seconds for each remote
   * user/host. If a channel includes multiple remote users, the SDK
   * triggers this callback as many times.
   *
   * @param rtcChannel IChannel
   * @param stats Statistics of the remote video stream. See
   * RemoteVideoStats.
   */
  virtual void onRemoteVideoStats(IChannel* rtcChannel, const RemoteVideoStats& stats) {
    (void)rtcChannel;
    (void)stats;
  }
  /** Reports the statistics of the audio stream from each remote user/host.

   This callback replaces the \ref agora::rtc::IRtcEngineEventHandler::onAudioQuality "onAudioQuality" callback.

   The SDK triggers this callback once every two seconds for each remote user/host. If a channel includes multiple remote users, the SDK triggers this callback as many times.

   @param rtcChannel IChannel
   @param stats The statistics of the received remote audio streams. See RemoteAudioStats.
   */
  virtual void onRemoteAudioStats(IChannel* rtcChannel, const RemoteAudioStats& stats) {
    (void)rtcChannel;
    (void)stats;
  }
  /** Occurs when the remote audio state changes.
   *
   * This callback indicates the state change of the remote audio stream.
   *
   * @note This callback can be inaccurate when the number of users (in the `COMMUNICATION` profile)
   * or hosts (in the `LIVE_BROADCASTING` profile) in a channel exceeds 17.
   *
   * @param rtcChannel IChannel
   * @param uid ID of the remote user whose audio state changes.
   * @param state State of the remote audio. See #REMOTE_AUDIO_STATE.
   * @param reason The reason of the remote audio state change. See #REMOTE_AUDIO_STATE_REASON.
   * @param elapsed Time elapsed (ms) from the local user calling the
   * \ref IChannel::joinChannel "joinChannel" method until the SDK
   * triggers this callback.
   */
  virtual void onRemoteAudioStateChanged(IChannel* rtcChannel, uid_t uid, REMOTE_AUDIO_STATE state, REMOTE_AUDIO_STATE_REASON reason, int elapsed) {
    (void)rtcChannel;
    (void)uid;
    (void)state;
    (void)reason;
    (void)elapsed;
  }

  /** Occurs when the audio publishing state changes.
   *
   * @since v3.1.0
   *
   * This callback indicates the publishing state change of the local audio stream.
   *
   * @param rtcChannel IChannel
   * @param oldState The previous publishing state. For details, see #STREAM_PUBLISH_STATE.
   * @param newState The current publishing state. For details, see #STREAM_PUBLISH_STATE.
   * @param elapseSinceLastState The time elapsed (ms) from the previous state to the current state.
   */
  virtual void onAudioPublishStateChanged(IChannel* rtcChannel, STREAM_PUBLISH_STATE oldState, STREAM_PUBLISH_STATE newState, int elapseSinceLastState) {
    (void)rtcChannel;
    (void)oldState;
    (void)newState;
    (void)elapseSinceLastState;
  }

  /** Occurs when the video publishing state changes.
   *
   * @since v3.1.0
   *
   * This callback indicates the publishing state change of the local video stream.
   *
   * @param rtcChannel IChannel
   * @param oldState The previous publishing state. For details, see #STREAM_PUBLISH_STATE.
   * @param newState The current publishing state. For details, see #STREAM_PUBLISH_STATE.
   * @param elapseSinceLastState The time elapsed (ms) from the previous state to the current state.
   */
  virtual void onVideoPublishStateChanged(IChannel* rtcChannel, STREAM_PUBLISH_STATE oldState, STREAM_PUBLISH_STATE newState, int elapseSinceLastState) {
    (void)rtcChannel;
    (void)oldState;
    (void)newState;
    (void)elapseSinceLastState;
  }

  /** Occurs when the audio subscribing state changes.
   *
   * @since v3.1.0
   *
   * This callback indicates the subscribing state change of a remote audio stream.
   *
   * @param rtcChannel IChannel
   * @param uid The ID of the remote user.
   * @param oldState The previous subscribing state. For details, see #STREAM_SUBSCRIBE_STATE.
   * @param newState The current subscribing state. For details, see #STREAM_SUBSCRIBE_STATE.
   * @param elapseSinceLastState The time elapsed (ms) from the previous state to the current state.
   */
  virtual void onAudioSubscribeStateChanged(IChannel* rtcChannel, uid_t uid, STREAM_SUBSCRIBE_STATE oldState, STREAM_SUBSCRIBE_STATE newState, int elapseSinceLastState) {
    (void)rtcChannel;
    (void)uid;
    (void)oldState;
    (void)newState;
    (void)elapseSinceLastState;
  }

  /** Occurs when the audio subscribing state changes.
   *
   * @since v3.1.0
   *
   * This callback indicates the subscribing state change of a remote video stream.
   *
   * @param rtcChannel IChannel
   * @param uid The ID of the remote user.
   * @param oldState The previous subscribing state. For details, see #STREAM_SUBSCRIBE_STATE.
   * @param newState The current subscribing state. For details, see #STREAM_SUBSCRIBE_STATE.
   * @param elapseSinceLastState The time elapsed (ms) from the previous state to the current state.
   */
  virtual void onVideoSubscribeStateChanged(IChannel* rtcChannel, uid_t uid, STREAM_SUBSCRIBE_STATE oldState, STREAM_SUBSCRIBE_STATE newState, int elapseSinceLastState) {
    (void)rtcChannel;
    (void)uid;
    (void)oldState;
    (void)newState;
    (void)elapseSinceLastState;
  }

  /** Reports whether the super resolution feature is successfully enabled. (beta feature)
   *
   * @since v3.5.1
   *
   * After calling \ref IChannel::enableRemoteSuperResolution "enableRemoteSuperResolution", the SDK triggers this
   * callback to report whether super resolution is successfully enabled. If it is not successfully enabled,
   * use `reason` for troubleshooting.
   *
   * @param rtcChannel IChannel
   * @param uid The user ID of the remote user.
   * @param enabled Whether super resolution is successfully enabled:
   * - true: Super resolution is successfully enabled.
   * - false: Super resolution is not successfully enabled.
   * @param reason The reason why super resolution is not successfully enabled or the message
   * that confirms success. See #SUPER_RESOLUTION_STATE_REASON.
   *
   */
  virtual void onUserSuperResolutionEnabled(IChannel* rtcChannel, uid_t uid, bool enabled, SUPER_RESOLUTION_STATE_REASON reason) {
    (void)rtcChannel;
    (void)uid;
    (void)enabled;
    (void)reason;
  }

  /** Occurs when the most active remote speaker is detected.

  After a successful call of \ref IRtcEngine::enableAudioVolumeIndication(int, int, bool) "enableAudioVolumeIndication",
  the SDK continuously detects which remote user has the loudest volume. During the current period, the remote user,
  who is detected as the loudest for the most times, is the most active user.

  When the number of user is no less than two and an active speaker exists, the SDK triggers this callback and reports the `uid` of the most active speaker.
  - If the most active speaker is always the same user, the SDK triggers this callback only once.
  - If the most active speaker changes to another user, the SDK triggers this callback again and reports the `uid` of the new active speaker.

  @param rtcChannel IChannel
  @param uid The user ID of the most active remote speaker.
  */
  virtual void onActiveSpeaker(IChannel* rtcChannel, uid_t uid) {
    (void)rtcChannel;
    (void)uid;
  }
  /** Occurs when the video size or rotation of a specified user changes.

  @param rtcChannel IChannel
  @param uid User ID of the remote user or local user (0) whose video size or rotation changes.
  @param width New width (pixels) of the video.
  @param height New height (pixels) of the video.
  @param rotation New rotation of the video [0 to 360).
  */
  virtual void onVideoSizeChanged(IChannel* rtcChannel, uid_t uid, int width, int height, int rotation) {
    (void)rtcChannel;
    (void)uid;
    (void)width;
    (void)height;
    (void)rotation;
  }
  /** Occurs when the remote video state changes.
   *
   * @note This callback can be inaccurate when the number of users (in the `COMMUNICATION` profile) or
   * hosts (in the `LIVE_BROADCASTING` profile) in a channel exceeds 17.
   *
   * @param rtcChannel IChannel
   * @param uid ID of the remote user whose video state changes.
   * @param state State of the remote video. See #REMOTE_VIDEO_STATE.
   * @param reason The reason of the remote video state change. See #REMOTE_VIDEO_STATE_REASON.
   * @param elapsed Time elapsed (ms) from the local user calling the
   * \ref agora::rtc::IChannel::joinChannel "joinChannel" method until the
   * SDK triggers this callback.
   */
  virtual void onRemoteVideoStateChanged(IChannel* rtcChannel, uid_t uid, REMOTE_VIDEO_STATE state, REMOTE_VIDEO_STATE_REASON reason, int elapsed) {
    (void)rtcChannel;
    (void)uid;
    (void)state;
    (void)reason;
    (void)elapsed;
  }
  /** Occurs when the local user receives the data stream from the remote user within five seconds.

   The SDK triggers this callback when the local user receives the stream message that the remote user sends by calling the \ref agora::rtc::IChannel::sendStreamMessage "sendStreamMessage" method.

   @param rtcChannel IChannel
   @param uid User ID of the remote user sending the message.
   @param streamId Stream ID.
   @param data The data received by the local user.
   @param length Length of the data in bytes.
  */
  virtual void onStreamMessage(IChannel* rtcChannel, uid_t uid, int streamId, const char* data, size_t length) {
    (void)rtcChannel;
    (void)uid;
    (void)streamId;
    (void)data;
    (void)length;
  }
  /** Occurs when the local user does not receive the data stream from the remote user within five seconds.

   The SDK triggers this callback when the local user fails to receive the stream message that the remote user sends by calling the \ref agora::rtc::IChannel::sendStreamMessage "sendStreamMessage" method.

   @param rtcChannel IChannel
   @param uid User ID of the remote user sending the message.
   @param streamId Stream ID.
   @param code Error code: #ERROR_CODE_TYPE.
   @param missed Number of lost messages.
   @param cached Number of incoming cached messages when the data stream is interrupted.
   */
  virtual void onStreamMessageError(IChannel* rtcChannel, uid_t uid, int streamId, int code, int missed, int cached) {
    (void)rtcChannel;
    (void)uid;
    (void)streamId;
    (void)code;
    (void)missed;
    (void)cached;
  }
  /** Occurs when the state of the media stream relay changes.
   *
   * The SDK returns the state of the current media relay with any error
   * message.
   * @param rtcChannel IChannel
   * @param state The state code in #CHANNEL_MEDIA_RELAY_STATE.
   * @param code The error code in #CHANNEL_MEDIA_RELAY_ERROR.
   */
  virtual void onChannelMediaRelayStateChanged(IChannel* rtcChannel, CHANNEL_MEDIA_RELAY_STATE state, CHANNEL_MEDIA_RELAY_ERROR code) {
    (void)rtcChannel;
    (void)state;
    (void)code;
  }
  /** Reports events during the media stream relay.
   * @param rtcChannel IChannel
   * @param code The event code in #CHANNEL_MEDIA_RELAY_EVENT.
   */
  virtual void onChannelMediaRelayEvent(IChannel* rtcChannel, CHANNEL_MEDIA_RELAY_EVENT code) {
    (void)rtcChannel;
    (void)code;
  }
  /**
   * Occurs when the state of the RTMP or RTMPS streaming changes.
   *
   * When the CDN live streaming state changes, the SDK triggers this callback to report the current state and the reason
   * why the state has changed.
   *
   * When exceptions occur, you can troubleshoot issues by referring to the detailed error descriptions in the *errCode* parameter.
   *
   * @param rtcChannel IChannel
   * @param url The CDN streaming URL.
   * @param state The RTMP or RTMPS streaming state. See: #RTMP_STREAM_PUBLISH_STATE.
   * @param errCode The detailed error information for streaming. See: #RTMP_STREAM_PUBLISH_ERROR_TYPE.
   */
  virtual void onRtmpStreamingStateChanged(IChannel* rtcChannel, const char* url, RTMP_STREAM_PUBLISH_STATE state, RTMP_STREAM_PUBLISH_ERROR_TYPE errCode) {
    (void)rtcChannel;
    (void)url;
    (void)state;
    (void)errCode;
  }

  /** Reports events during the RTMP or RTMPS streaming.
   *
   * @since v3.1.0
   *
   * @param rtcChannel IChannel
   * @param url The RTMP or RTMPS streaming URL.
   * @param eventCode The event code. See #RTMP_STREAMING_EVENT
   */
  virtual void onRtmpStreamingEvent(IChannel* rtcChannel, const char* url, RTMP_STREAMING_EVENT eventCode) {
    (void)rtcChannel;
    (void)url;
    (void)eventCode;
  }

  /** Occurs when the publisher's transcoding is updated.

  When the `LiveTranscoding` class in the \ref agora::rtc::IChannel::setLiveTranscoding "setLiveTranscoding" method updates, the SDK triggers the `onTranscodingUpdated` callback to report the update information to the local host.

  @note If you call the `setLiveTranscoding` method to set the LiveTranscoding class for the first time, the SDK does not trigger the `onTranscodingUpdated` callback.

  @param rtcChannel IChannel
  */
  virtual void onTranscodingUpdated(IChannel* rtcChannel) { (void)rtcChannel; }
  /** Occurs when a voice or video stream URL address is added to the interactive live streaming.

   @warning Agora will soon stop the service for injecting online media streams on the client. If you have not implemented this service, Agora recommends that you do not use it.

   @param rtcChannel IChannel
   @param url The URL address of the externally injected stream.
   @param uid User ID.
   @param status State of the externally injected stream: #INJECT_STREAM_STATUS.
   */
  virtual void onStreamInjectedStatus(IChannel* rtcChannel, const char* url, uid_t uid, int status) {
    (void)rtcChannel;
    (void)url;
    (void)uid;
    (void)status;
  }
  /** Occurs when the published media stream falls back to an audio-only stream due to poor network conditions or switches back to the video after the network conditions improve.

  If you call \ref IRtcEngine::setLocalPublishFallbackOption "setLocalPublishFallbackOption" and set *option* as #STREAM_FALLBACK_OPTION_AUDIO_ONLY, the SDK triggers this callback when the published stream falls back to audio-only mode due to poor uplink conditions, or when the audio stream switches back to the video after the uplink network condition improves.

  @param rtcChannel IChannel
  @param isFallbackOrRecover Whether the published stream falls back to audio-only or switches back to the video:
  - true: The published stream falls back to audio-only due to poor network conditions.
  - false: The published stream switches back to the video after the network conditions improve.
  */
  virtual void onLocalPublishFallbackToAudioOnly(IChannel* rtcChannel, bool isFallbackOrRecover) {
    (void)rtcChannel;
    (void)isFallbackOrRecover;
  }
  /** Occurs when the remote media stream falls back to audio-only stream
   * due to poor network conditions or switches back to the video stream
   * after the network conditions improve.
   *
   * If you call
   * \ref IRtcEngine::setRemoteSubscribeFallbackOption
   * "setRemoteSubscribeFallbackOption" and set
   * @p option as #STREAM_FALLBACK_OPTION_AUDIO_ONLY, the SDK triggers this
   * callback when the remote media stream falls back to audio-only mode due
   * to poor downlink conditions, or when the remote media stream switches
   * back to the video after the downlink network condition improves.
   *
   * @note Once the remote media stream switches to the low stream due to
   * poor network conditions, you can monitor the stream switch between a
   * high and low stream in the RemoteVideoStats callback.
   * @param rtcChannel IChannel
   * @param uid ID of the remote user sending the stream.
   * @param isFallbackOrRecover Whether the remotely subscribed media stream
   * falls back to audio-only or switches back to the video:
   * - true: The remotely subscribed media stream falls back to audio-only
   * due to poor network conditions.
   * - false: The remotely subscribed media stream switches back to the
   * video stream after the network conditions improved.
   */
  virtual void onRemoteSubscribeFallbackToAudioOnly(IChannel* rtcChannel, uid_t uid, bool isFallbackOrRecover) {
    (void)rtcChannel;
    (void)uid;
    (void)isFallbackOrRecover;
  }
  /** Occurs when the connection state between the SDK and the server changes.

   @param rtcChannel IChannel
   @param state See #CONNECTION_STATE_TYPE.
   @param reason See #CONNECTION_CHANGED_REASON_TYPE.
   */
  virtual void onConnectionStateChanged(IChannel* rtcChannel, CONNECTION_STATE_TYPE state, CONNECTION_CHANGED_REASON_TYPE reason) {
    (void)rtcChannel;
    (void)state;
    (void)reason;
  }
  /**
   * Reports the proxy connection state.
   *
   * @since v3.6.2
   *
   * You can use this callback to listen for the state of the SDK connecting to a proxy.
   * For example, when a user calls \ref IRtcEngine::setCloudProxy "setCloudProxy" and joins a channel successfully, the SDK triggers this callback to report the user ID, the proxy type connected, and the time elapsed from the user calling \ref IChannel::joinChannel "joinChannel" until this callback is triggered.
   *
   * @param rtcChannel IChannel
   * @param uid The user ID.
   * @param proxyType The proxy type connected. See #PROXY_TYPE.
   * @param localProxyIp Reserved for future use.
   * @param elapsed The time elapsed (ms) from the user calling `joinChannel` until this callback is triggered.
   *
   */
  virtual void onProxyConnected(IChannel* rtcChannel, uid_t uid, PROXY_TYPE proxyType, const char* localProxyIp, int elapsed) {
    (void)rtcChannel;
    (void)uid;
    (void)proxyType;
    (void)localProxyIp;
    (void)elapsed;
  }
};

/** The IChannel class. */
class IChannel {
 public:
  virtual ~IChannel() {}
  /** Releases all IChannel resources.

   @return
   - 0: Success.
   - < 0: Failure.
      - `ERR_NOT_INITIALIZED (7)`: The SDK is not initialized before calling this method.
   */
  virtual int release() = 0;
  /** Sets the channel event handler.

   After setting the channel event handler, you can listen for channel events and receive the statistics of the corresponding `IChannel` object.

   @param channelEh The event handler of the `IChannel` object. For details, see IChannelEventHandler.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setChannelEventHandler(IChannelEventHandler* channelEh) = 0;
  /** Joins the channel with a user ID.
   *
   * Compared with the `joinChannel` method in the IRtcEngine class, this method supports joining multiple channels at
   * a time by creating multiple IChannel objects and then calling `joinChannel` in each IChannel object.
   *
   * Once the user joins the channel, the user publishes the local audio and video streams and automatically
   * subscribes to the audio and video streams of all the other users in the channel by default. Subscribing
   * incurs all associated usage costs. To unsubscribe, set the `options` parameter or call the `mute` methods accordingly.
   *
   * @note
   * - If you are already in a channel, you cannot rejoin it with the same `uid`.
   * - If you want to join the same channel from different devices, ensure that the UIDs in all devices are different.
   * - Ensure that the app ID you use to generate the token is the same with the app ID used when creating the `IRtcEngine` object.
   *
   * @param token The token generated at your server. See [Authenticate Your Users with Tokens](https://docs.agora.io/en/Interactive%20Broadcast/token_server?platform=All%20Platforms).
   * @param info (Optional) Additional information about the channel. This parameter can be set as null. Other users in the channel do not receive this information.
   * @param uid The user ID. A 32-bit unsigned integer with a value ranging from 1 to (232-1). This parameter must be unique. If `uid` is not assigned (or set as `0`), the SDK assigns a `uid` and reports it in the \ref agora::rtc::IChannelEventHandler::onJoinChannelSuccess "onJoinChannelSuccess" callback. The app must maintain this user ID.
   * @param options The channel media options: \ref agora::rtc::ChannelMediaOptions::ChannelMediaOptions "ChannelMediaOptions"
   *
   * @return
   * - 0(ERR_OK): Success.
   * - < 0: Failure.
   *    - -2(ERR_INVALID_ARGUMENT): The parameter is invalid.
   *    - -3(ERR_NOT_READY): The SDK fails to be initialized. You can try re-initializing the SDK.
   *    - -5(ERR_REFUSED): The request is rejected. This may be caused by the following:
   *       - You have created an IChannel object with the same channel name.
   *       - You have joined and published a stream in a channel created by the IChannel object. When you join a channel created by the IRtcEngine object, the SDK publishes the local audio and video streams to that channel by default. Because the SDK does not support publishing a local stream to more than one channel simultaneously, an error occurs in this occasion.
   *    - -7(ERR_NOT_INITIALIZED): The SDK is not initialized before calling this method.
   *    - `ERR_JOIN_CHANNEL_REJECTED(-17)`: The request to join the channel is rejected. The SDK does not support
   * joining the same IChannel channel repeatedly. Therefore, the SDK returns this error code when a user who has
   * already joined an IChannel channel calls the joining channel method of this IChannel object.
   */
  virtual int joinChannel(const char* token, const char* info, uid_t uid, const ChannelMediaOptions& options) = 0;
  /** Joins the channel with a user account.
   *
   * Compared with the `joinChannelWithUserAccount` method in the IRtcEngine class, this method supports joining multiple channels at
   * a time by creating multiple IChannel objects and then calling `joinChannelWithUserAccount` in each IChannel object.
   *
   * After the user successfully joins the channel, the SDK triggers the following callbacks:
   *
   * - The local client: \ref agora::rtc::IRtcEngineEventHandler::onLocalUserRegistered "onLocalUserRegistered" and \ref agora::rtc::IChannelEventHandler::onJoinChannelSuccess "onJoinChannelSuccess" .
   * - The remote client: \ref agora::rtc::IChannelEventHandler::onUserJoined "onUserJoined" and \ref agora::rtc::IRtcEngineEventHandler::onUserInfoUpdated "onUserInfoUpdated" , if the user joining the channel is in the `COMMUNICATION` profile, or is a host in the `LIVE_BROADCASTING` profile.
   *
   * Once the user joins the channel, the user publishes the local audio and video streams and
   * automatically subscribes to the audio and video streams of all the other users in the channel by default.
   * Subscribing incurs all associated usage costs. To unsubscribe, set the `options` parameters or call the `mute` methods accordingly.
   *
   * @note
   * - To ensure smooth communication, use the same parameter type to identify the user. For example, if a user joins the channel with a user ID, then ensure all the other users use the user ID too. The same applies to the user account.
   * If a user joins the channel with the Agora Web SDK, ensure that the uid of the user is set to the same parameter type.
   * - Before using a String user name, ensure that you read [How can I use string user names](https://docs.agora.io/en/faq/string) for getting details about the limitations and implementation steps.
   *
   * @param token The token generated at your server. See [Authenticate Your Users with Tokens](https://docs.agora.io/en/Interactive%20Broadcast/token_server?platform=All%20Platforms).
   * @param userAccount The user account. The maximum length of this parameter is 255 bytes. Ensure that the user account is unique and do not set it as null. Supported character scopes are:
   * - All lowercase English letters: a to z.
   * - All uppercase English letters: A to Z.
   * - All numeric characters: 0 to 9.
   * - The space character.
   * - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
   * @param options The channel media options: \ref agora::rtc::ChannelMediaOptions::ChannelMediaOptions “ChannelMediaOptions”.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *    - #ERR_INVALID_ARGUMENT (-2)
   *    - #ERR_NOT_READY (-3)
   *    - #ERR_REFUSED (-5)
   *    - #ERR_NOT_INITIALIZED (-7)
   *    - `ERR_JOIN_CHANNEL_REJECTED(-17)`: The request to join the channel is rejected. The SDK does not support
   * joining the same IChannel channel repeatedly. Therefore, the SDK returns this error code when a user who has
   * already joined an IChannel channel calls the joining channel method of this IChannel object.
   */
  virtual int joinChannelWithUserAccount(const char* token, const char* userAccount, const ChannelMediaOptions& options) = 0;
  /** Allows a user to leave a channel, such as hanging up or exiting a call.

   After joining a channel, the user must call the *leaveChannel* method to end the call before joining another channel.

   This method returns 0 if the user leaves the channel and releases all resources related to the call.

   This method call is asynchronous, and the user has not left the channel when the method call returns. Once the user leaves the channel, the SDK triggers the \ref IChannelEventHandler::onLeaveChannel "onLeaveChannel" callback.

   A successful \ref agora::rtc::IChannel::leaveChannel "leaveChannel" method call triggers the following callbacks:
   - The local client: \ref agora::rtc::IChannelEventHandler::onLeaveChannel "onLeaveChannel"
   - The remote client: \ref agora::rtc::IChannelEventHandler::onUserOffline "onUserOffline" , if the user leaving the channel is in the Communication channel, or is a host in the `LIVE_BROADCASTING` profile.

   @note
   - If you call the \ref IChannel::release "release" method immediately after the *leaveChannel* method, the *leaveChannel* process interrupts, and the \ref IChannelEventHandler::onLeaveChannel "onLeaveChannel" callback is not triggered.
   - If you call the *leaveChannel* method during a CDN live streaming, the SDK triggers the \ref IChannel::removePublishStreamUrl "removePublishStreamUrl" method.

     @return
     - 0(ERR_OK): Success.
     - < 0: Failure.
        - -1(ERR_FAILED): A general error occurs (no specified reason).
        - -2(ERR_INVALID_ARGUMENT): The parameter is invalid.
        - -7(ERR_NOT_INITIALIZED): The SDK is not initialized.
     */
  virtual int leaveChannel() = 0;

  /// @cond nodoc
  virtual int setAVSyncSource(const char* channelId, uid_t uid) = 0;
  /// @endcond

  /** Publishes the local stream to the channel.

   @deprecated This method is deprecated as of v3.4.5. Use \ref IChannel::muteLocalAudioStream "muteLocalAudioStream" (false)
   or \ref IChannel::muteLocalVideoStream "muteLocalVideoStream" (false) instead.

   You must keep the following restrictions in mind when calling this method. Otherwise, the SDK returns the #ERR_REFUSED (5):
   - This method publishes one stream only to the channel corresponding to the current IChannel object.
   - In the interactive live streaming channel, only a host can call this method.
   To switch the client role, call \ref IChannel::setClientRole "setClientRole" of the current IChannel object.
   - You can publish a stream to only one channel at a time. For details on joining multiple channels, see the advanced guide *Join Multiple Channels*.

   @return
   - 0: Success.
   - < 0: Failure.
      - #ERR_REFUSED (5): The method call is refused.
   */
  virtual int publish() AGORA_DEPRECATED_ATTRIBUTE = 0;

  /** Stops publishing a stream to the channel.

   @deprecated This method is deprecated as of v3.4.5. Use \ref IChannel::muteLocalAudioStream "muteLocalAudioStream" (true)
   or \ref IChannel::muteLocalVideoStream "muteLocalVideoStream" (true) instead.

   If you call this method in a channel where you are not publishing streams, the SDK returns #ERR_REFUSED (5).

   @return
   - 0: Success.
   - < 0: Failure.
      - #ERR_REFUSED (5): The method call is refused.
   */
  virtual int unpublish() AGORA_DEPRECATED_ATTRIBUTE = 0;

  /** Gets the channel ID of the current `IChannel` object.

   @return
   - The channel ID of the current `IChannel` object, if the method call succeeds.
   - The empty string "", if the method call fails.
   */
  virtual const char* channelId() = 0;
  /** Gets the current call ID.

   When a user joins a channel on a client, a `callId` is generated to identify the call from the client.
   Feedback methods, such as \ref IRtcEngine::rate "rate" and \ref IRtcEngine::complain "complain", must be called after the call ends to submit feedback to the SDK.

   The `rate` and `complain` methods require the `callId` parameter retrieved from the `getCallId` method during a call. `callId` is passed as an argument into the `rate` and `complain` methods after the call ends.

   @note Ensure that you call this method after joining a channel.

   @param callId The current call ID.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int getCallId(agora::util::AString& callId) = 0;
  /** Gets a new token when the current token expires after a period of time.

   The `token` expires after a period of time once the token schema is enabled when:

   - The SDK triggers the \ref IChannelEventHandler::onTokenPrivilegeWillExpire "onTokenPrivilegeWillExpire" callback, or
   - The \ref IChannelEventHandler::onConnectionStateChanged "onConnectionStateChanged" reports CONNECTION_CHANGED_TOKEN_EXPIRED(9).

   The application should call this method to get the new `token`. Failure to do so will result in the SDK disconnecting from the server.

   @param token The new token.

   @return
   - 0(ERR_OK): Success.
   - < 0: Failure.
      - -1(ERR_FAILED): A general error occurs (no specified reason).
      - -2(ERR_INVALID_ARGUMENT): The parameter is invalid.
      - -7(ERR_NOT_INITIALIZED): The SDK is not initialized.
   */
  virtual int renewToken(const char* token) = 0;
  /** Enables built-in encryption with an encryption password before users join a channel.

   @deprecated Deprecated as of v3.1.0. Use the \ref agora::rtc::IChannel::enableEncryption "enableEncryption" instead.

   All users in a channel must use the same encryption password. The encryption password is automatically cleared once a user leaves the channel.

   If an encryption password is not specified, the encryption functionality will be disabled.

   @note
   - Do not use this method for CDN live streaming.
   - For optimal transmission, ensure that the encrypted data size does not exceed the original data size + 16 bytes. 16 bytes is the maximum padding size for AES encryption.

   @param secret Pointer to the encryption password.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setEncryptionSecret(const char* secret) AGORA_DEPRECATED_ATTRIBUTE = 0;
  /** Sets the built-in encryption mode.

   @deprecated Deprecated as of v3.1.0. Use the \ref agora::rtc::IChannel::enableEncryption "enableEncryption" instead.

   The Agora SDK supports built-in encryption, which is set to the `aes-128-xts` mode by default. Call this method to use other encryption modes.

   All users in the same channel must use the same encryption mode and password.

   Refer to the information related to the AES encryption algorithm on the differences between the encryption modes.

   @note Call the \ref IChannel::setEncryptionSecret "setEncryptionSecret" method to enable the built-in encryption function before calling this method.

   @param encryptionMode The set encryption mode:
   - "aes-128-xts": (Default) 128-bit AES encryption, XTS mode.
   - "aes-128-ecb": 128-bit AES encryption, ECB mode.
   - "aes-256-xts": 256-bit AES encryption, XTS mode.
   - "": When encryptionMode is set as NULL, the encryption mode is set as "aes-128-xts" by default.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setEncryptionMode(const char* encryptionMode) AGORA_DEPRECATED_ATTRIBUTE = 0;
  /** Enables/Disables the built-in encryption.
   *
   * @since v3.1.0
   *
   * In scenarios requiring high security, Agora recommends calling this method to enable the built-in encryption before joining a channel.
   *
   * After a user leaves the channel, the SDK automatically disables the built-in encryption.
   * To re-enable the built-in encryption, call this method before the user joins the channel again.
   *
   * As of v3.4.5, Agora recommends using either the `AES_128_GCM2` or `AES_256_GCM2` encryption mode,
   * both of which support adding a salt and are more secure. For details, see *Media Stream Encryption*.
   *
   * @warning All users in the same channel must use the same encryption mode, encryption key, and salt; otherwise,
   * users cannot communicate with each other.
   *
   * @note
   * - If you enable the built-in encryption, you cannot use the RTMP or RTMPS streaming function.
   * - To enhance security, Agora recommends using a new key and salt every time you enable the media stream encryption.
   *
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
  virtual int enableEncryption(bool enabled, const EncryptionConfig& config) = 0;
  /** Registers a packet observer.

   The Agora SDK allows your application to register a packet observer to receive callbacks for voice or video packet transmission.

   @note
   - The size of the packet sent to the network after processing should not exceed 1200 bytes, otherwise, the packet may fail to be sent.
   - Ensure that both receivers and senders call this method, otherwise, you may meet undefined behaviors such as no voice and black screen.
   - When you use CDN live streaming and recording functions, Agora doesn't recommend calling this method.
   - Call this method before joining a channel.
   @param observer The registered packet observer. See IPacketObserver.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int registerPacketObserver(IPacketObserver* observer) = 0;
  /** Registers the metadata observer.

   Registers the metadata observer. You need to implement the IMetadataObserver class and specify the metadata type in this method. A successful call of this method triggers the \ref agora::rtc::IMetadataObserver::getMaxMetadataSize "getMaxMetadataSize" callback.
   This method enables you to add synchronized metadata in the video stream for more diversified interactive live streaming, such as sending shopping links, digital coupons, and online quizzes.

   @note Call this method before the joinChannel method.

   @param observer The IMetadataObserver class. See the definition of IMetadataObserver for details.
   @param type See \ref IMetadataObserver::METADATA_TYPE "METADATA_TYPE". The SDK supports VIDEO_METADATA (0) only for now.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int registerMediaMetadataObserver(IMetadataObserver* observer, IMetadataObserver::METADATA_TYPE type) = 0;
  /** Sets the role of the user in interactive live streaming.
   *
   * In the `LIVE_BROADCASTING` channel profile, the
   * SDK sets the user role as audience by default. You can call `setClientRole` to set the user role as host.
   *
   * You can call this method either before or after joining a channel. If you
   * call this method to switch the user role after joining a channel, the SDK automatically does the following:
   * - Calls \ref IChannel::muteLocalAudioStream "muteLocalAudioStream" and \ref IChannel::muteLocalVideoStream "muteLocalVideoStream" to
   * change the publishing state.
   * - Triggers \ref IChannelEventHandler::onClientRoleChanged "onClientRoleChanged" on the local client.
   * - Triggers \ref IChannelEventHandler::onUserJoined "onUserJoined" or \ref IChannelEventHandler::onUserOffline "onUserOffline" (BECOME_AUDIENCE)
   * on the remote client.
   *
   * @note This method applies to the `LIVE_BROADCASTING` profile only.
   *
   * @param role The role of a user in interactive live streaming. See #CLIENT_ROLE_TYPE.
   *
   * @return
   * - 0(ERR_OK): Success.
   * - < 0: Failure.
   *  - -1(ERR_FAILED): A general error occurs (no specified reason).
   *  - -2(ERR_INVALID_ARGUMENT): The parameter is invalid.
   *  - -5 (ERR_REFUSED): The request is rejected. In multichannel scenarios, if you have set any of the following in
   * one channel, the SDK returns this error code when the user switches the user role to host in another channel:
   *    - Call `joinChannel` with the `options` parameter and use the default settings `publishLocalAudio = true` or `publishLocalVideo = true`.
   *    - Call `setClientRole` to set the user role as host.
   *    - Call `muteLocalAudioStream(false)` or `muteLocalVideoStream(false)`.
   *  - -7(ERR_NOT_INITIALIZED): The SDK is not initialized.
   */
  virtual int setClientRole(CLIENT_ROLE_TYPE role) = 0;

  /** Sets the role of the user in interactive live streaming.
   *
   * @since v3.2.0
   *
   * In the `LIVE_BROADCASTING` channel profile, the
   * SDK sets the user role as audience by default. You can call `setClientRole` to set the user role as host.
   *
   * You can call this method either before or after joining a channel. If you
   * call this method to switch the user role after joining a channel, the SDK automatically does the following:
   * - Calls \ref IChannel::muteLocalAudioStream "muteLocalAudioStream" and \ref IChannel::muteLocalVideoStream "muteLocalVideoStream" to
   * change the publishing state.
   * - Triggers \ref IChannelEventHandler::onClientRoleChanged "onClientRoleChanged" on the local client.
   * - Triggers \ref IChannelEventHandler::onUserJoined "onUserJoined" or \ref IChannelEventHandler::onUserOffline "onUserOffline" (BECOME_AUDIENCE)
   * on the remote client.
   *
   * @note
   * - This method applies to the `LIVE_BROADCASTING` profile only.
   * - The difference between this method and \ref IChannel::setClientRole(CLIENT_ROLE_TYPE) "setClientRole" [1/2] is that
   * this method can set the user level in addition to the user role.
   *  - The user role determines the permissions that the SDK grants to a user, such as permission to send local streams,
   * receive remote streams, and push streams to a CDN address.
   *  - The user level determines the level of services that a user can enjoy within the permissions of the user's role.
   * For example, an audience member can choose to receive remote streams with low latency or ultra low latency.
   * **User level affects the pricing of services.**
   *
   * @param role The role of a user in interactive live streaming. See #CLIENT_ROLE_TYPE.
   * @param options The detailed options of a user, including user level. See ClientRoleOptions.
   *
   * @return
   * - 0(ERR_OK): Success.
   * - < 0: Failure.
   *  - -1(ERR_FAILED): A general error occurs (no specified reason).
   *  - -2(ERR_INVALID_ARGUMENT): The parameter is invalid.
   *  - -5 (ERR_REFUSED): The request is rejected. In multichannel scenarios, if you have set any of the following in
   * one channel, the SDK returns this error code when the user switches the user role to host in another channel:
   *    - Call `joinChannel` with the `options` parameter and use the default settings `publishLocalAudio = true` or `publishLocalVideo = true`.
   *    - Call `setClientRole` to set the user role as host.
   *    - Call `muteLocalAudioStream(false)` or `muteLocalVideoStream(false)`.
   *  - -7(ERR_NOT_INITIALIZED): The SDK is not initialized.
   */
  virtual int setClientRole(CLIENT_ROLE_TYPE role, const ClientRoleOptions& options) = 0;

  /** Prioritizes a remote user's stream.
   *
   * The SDK ensures the high-priority user gets the best possible stream quality.
   *
   * @note
   * - The Agora SDK supports setting `serPriority` as high for one user only.
   * - Ensure that you call this method before joining a channel.
   *
   * @param  uid  The ID of the remote user.
   * @param  userPriority Sets the priority of the remote user. See #PRIORITY_TYPE.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setRemoteUserPriority(uid_t uid, PRIORITY_TYPE userPriority) = 0;
  /** Sets the sound position and gain of a remote user.

   When the local user calls this method to set the sound position of a remote user, the sound difference between the left and right channels allows the
   local user to track the real-time position of the remote user, creating a real sense of space. This method applies to massively multiplayer online games,
   such as Battle Royale games.

   @note
   - For this method to work, enable stereo panning for remote users by calling the \ref agora::rtc::IRtcEngine::enableSoundPositionIndication "enableSoundPositionIndication" method before joining a channel.
   - This method requires hardware support. For the best sound positioning, we recommend using a wired headset.
   - Ensure that you call this method after joining a channel.

   @param uid The ID of the remote user.
   @param pan The sound position of the remote user. The value ranges from -1.0 to 1.0:
   - 0.0: the remote sound comes from the front.
   - -1.0: the remote sound comes from the left.
   - 1.0: the remote sound comes from the right.
   @param gain Gain of the remote user. The value ranges from 0.0 to 100.0. The default value is 100.0 (the original gain of the remote user).
   The smaller the value, the less the gain.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setRemoteVoicePosition(uid_t uid, double pan, double gain) = 0;
  /** Updates the display mode of the video view of a remote user.

   After initializing the video view of a remote user, you can call this method to update its rendering and mirror modes.
   This method affects only the video view that the local user sees.

   @note
   - Call this method after calling the \ref agora::rtc::IRtcEngine::setupRemoteVideo "setupRemoteVideo" method to initialize the remote video view.
   - During a call, you can call this method as many times as necessary to update the display mode of the video view of a remote user.

   @param userId The ID of the remote user.
   @param renderMode The rendering mode of the remote video view. See #RENDER_MODE_TYPE.
   @param mirrorMode
   - The mirror mode of the remote video view. See #VIDEO_MIRROR_MODE_TYPE.
   - **Note**: The SDK disables the mirror mode by default.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setRemoteRenderMode(uid_t userId, RENDER_MODE_TYPE renderMode, VIDEO_MIRROR_MODE_TYPE mirrorMode) = 0;
  /** Stops or resumes subscribing to the audio streams of all remote users by default.
   *
   * @deprecated This method is deprecated from v3.3.0.
   *
   *
   * Call this method after joining a channel. After successfully calling this method, the
   * local user stops or resumes subscribing to the audio streams of all subsequent users.
   *
   * @note If you need to resume subscribing to the audio streams of remote users in the
   * channel after calling \ref IRtcEngine::setDefaultMuteAllRemoteAudioStreams "setDefaultMuteAllRemoteAudioStreams" (true), do the following:
   * - If you need to resume subscribing to the audio stream of a specified user, call \ref IRtcEngine::muteRemoteAudioStream "muteRemoteAudioStream" (false), and specify the user ID.
   * - If you need to resume subscribing to the audio streams of multiple remote users, call \ref IRtcEngine::muteRemoteAudioStream "muteRemoteAudioStream" (false) multiple times.
   *
   * @param mute Sets whether to stop subscribing to the audio streams of all remote users by default.
   * - true: Stop subscribing to the audio streams of all remote users by default.
   * - false: (Default) Resume subscribing to the audio streams of all remote users by default.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setDefaultMuteAllRemoteAudioStreams(bool mute) AGORA_DEPRECATED_ATTRIBUTE = 0;
  /** Stops or resumes subscribing to the video streams of all remote users by default.
   *
   * @deprecated This method is deprecated from v3.3.0.
   *
   * Call this method after joining a channel. After successfully calling this method, the
   * local user stops or resumes subscribing to the video streams of all subsequent users.
   *
   * @note If you need to resume subscribing to the video streams of remote users in the
   * channel after calling \ref IChannel::setDefaultMuteAllRemoteVideoStreams "setDefaultMuteAllRemoteVideoStreams" (true), do the following:
   * - If you need to resume subscribing to the video stream of a specified user, call \ref IChannel::muteRemoteVideoStream "muteRemoteVideoStream" (false), and specify the user ID.
   * - If you need to resume subscribing to the video streams of multiple remote users, call \ref IChannel::muteRemoteVideoStream "muteRemoteVideoStream" (false) multiple times.
   *
   * @param mute Sets whether to stop subscribing to the video streams of all remote users by default.
   * - true: Stop subscribing to the video streams of all remote users by default.
   * - false: (Default) Resume subscribing to the video streams of all remote users by default.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setDefaultMuteAllRemoteVideoStreams(bool mute) AGORA_DEPRECATED_ATTRIBUTE = 0;
  /**
   * Stops or resumes publishing the local audio stream.
   *
   * @since v3.4.5
   *
   * This method only sets the publishing state of the audio stream in the channel of IChannel.
   *
   * A successful method call triggers the
   * \ref IChannelEventHandler::onRemoteAudioStateChanged "onRemoteAudioStateChanged"
   * callback on the remote client.
   *
   * You can only publish the local stream in one channel at a time. If you create multiple channels, ensure that
   * you only call \ref IChannel::muteLocalAudioStream "muteLocalAudioStream" (false) in one channel;
   * otherwise, the method call fails, and the SDK returns `-5 (ERR_REFUSED)`.
   *
   * @note
   * - This method does not change the usage state of the audio-capturing device.
   * - Whether this method call takes effect is affected by the \ref IChannel::joinChannel "joinChannel"
   * and \ref IChannel::setClientRole "setClientRole" methods. For details, see *Set the Publishing State*.
   *
   * @param mute Sets whether to stop publishing the local audio stream.
   * - true: Stop publishing the local audio stream.
   * - false: Resume publishing the local audio stream.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *  - `-5 (ERR_REFUSED)`: The request is rejected.
   */
  virtual int muteLocalAudioStream(bool mute) = 0;
  /** Stops or resumes publishing the local video stream.
   *
   * @since v3.4.5
   *
   * This method only sets the publishing state of the video stream in the channel of IChannel.
   *
   * A successful method call triggers the \ref IChannelEventHandler::onRemoteVideoStateChanged "onRemoteVideoStateChanged"
   * callback on the remote client.
   *
   * You can only publish the local stream in one channel at a time. If you create multiple channels,
   * ensure that you only call \ref IChannel::muteLocalVideoStream "muteLocalVideoStream" (false) in one channel;
   * otherwise, the method call fails, and the SDK returns `-5 (ERR_REFUSED)`.
   *
   * @note
   * - This method does not change the usage state of the video-capturing device.
   * - Whether this method call takes effect is affected by the \ref IChannel::joinChannel "joinChannel"
   * and \ref IChannel::setClientRole "setClientRole" methods. For details, see *Set the Publishing State*.
   *
   * @param mute Sets whether to stop publishing the local video stream.
   * - true: Stop publishing the local video stream.
   * - false: Resume publishing the local video stream.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *  - `-5 (ERR_REFUSED)`: The request is rejected.
   */
  virtual int muteLocalVideoStream(bool mute) = 0;
  /**
   * Stops or resumes subscribing to the audio streams of all remote users.
   *
   * After successfully calling this method, the local user stops or resumes
   * subscribing to the audio streams of all remote users, including all subsequent users.
   *
   * @note
   * - Call this method after joining a channel.
   * - As of v3.3.0, this method contains the function of \ref IChannel::setDefaultMuteAllRemoteAudioStreams "setDefaultMuteAllRemoteAudioStreams".
   * Agora recommends not calling `muteAllRemoteAudioStreams` and `setDefaultMuteAllRemoteAudioStreams`
   * together; otherwise, the settings may not take effect. See *Set the Subscribing State*.
   *
   * @param mute Sets whether to stop subscribing to the audio streams of all remote users.
   * - true: Stop subscribing to the audio streams of all remote users.
   * - false: (Default) Resume subscribing to the audio streams of all remote users.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int muteAllRemoteAudioStreams(bool mute) = 0;
  /** Adjust the playback signal volume of the specified remote user.
   *
   * After joining a channel, call \ref agora::rtc::IRtcEngine::adjustPlaybackSignalVolume "adjustPlaybackSignalVolume" to adjust the playback volume of different remote users,
   * or adjust multiple times for one remote user.
   *
   * @note
   * - Call this method after joining a channel.
   * - This method adjusts the playback volume, which is the mixed volume for the specified remote user.
   * - This method can only adjust the playback volume of one specified remote user at a time. If you want to adjust the playback volume of several remote users,
   * call the method multiple times, once for each remote user.
   *
   * @param userId The user ID, which should be the same as the `uid` of \ref agora::rtc::IChannel::joinChannel "joinChannel"
   * @param volume The playback volume of the voice. The value
   * ranges between 0 and 100, including the following:
   * - 0: Mute.
   * - 100: (Default) Original volume.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int adjustUserPlaybackSignalVolume(uid_t userId, int volume) = 0;
  /**
   * Stops or resumes subscribing to the audio stream of a specified user.
   *
   * @note
   * - Call this method after joining a channel.
   * - See recommended settings in *Set the Subscribing State*.
   *
   * @param userId The user ID of the specified remote user.
   * @param mute Sets whether to stop subscribing to the audio stream of a specified user.
   * - true: Stop subscribing to the audio stream of a specified user.
   * - false: (Default) Resume subscribing to the audio stream of a specified user.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int muteRemoteAudioStream(uid_t userId, bool mute) = 0;
  /**
   * Stops or resumes subscribing to the video streams of all remote users.
   *
   * After successfully calling this method, the local user stops or resumes
   * subscribing to the video streams of all remote users, including all subsequent users.
   *
   * @note
   * - Call this method after joining a channel.
   * - See recommended settings in *Set the Subscribing State*.
   *
   * @param mute Sets whether to stop subscribing to the video streams of all remote users.
   * - true: Stop subscribing to the video streams of all remote users.
   * - false: (Default) Resume subscribing to the video streams of all remote users.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int muteAllRemoteVideoStreams(bool mute) = 0;
  /**
   * Stops or resumes subscribing to the video stream of a specified user.
   *
   * @note
   * - Call this method after joining a channel.
   * - See recommended settings in *Set the Subscribing State*.
   *
   * @param userId The user ID of the specified remote user.
   * @param mute Sets whether to stop subscribing to the video stream of a specified user.
   * - true: Stop subscribing to the video stream of a specified user.
   * - false: (Default) Resume subscribing to the video stream of a specified user.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int muteRemoteVideoStream(uid_t userId, bool mute) = 0;
  /** Sets the stream type of the remote video.

   Under limited network conditions, if the publisher has not disabled the dual-stream mode using
   \ref agora::rtc::IRtcEngine::enableDualStreamMode "enableDualStreamMode" (false),
   the receiver can choose to receive either the high-quality video stream (the high resolution, and high bitrate video stream) or
   the low-video stream (the low resolution, and low bitrate video stream).

   By default, users receive the high-quality video stream. Call this method if you want to switch to the low-video stream.
   This method allows the app to adjust the corresponding video stream type based on the size of the video window to
   reduce the bandwidth and resources.

   The aspect ratio of the low-video stream is the same as the high-quality video stream. Once the resolution of the high-quality video
   stream is set, the system automatically sets the resolution, frame rate, and bitrate of the low-video stream.

   The method result returns in the \ref agora::rtc::IRtcEngineEventHandler::onApiCallExecuted "onApiCallExecuted" callback.

   @note You can call this method either before or after joining a channel. If you call both
   \ref IChannel::setRemoteVideoStreamType "setRemoteVideoStreamType" and
   \ref IChannel::setRemoteDefaultVideoStreamType "setRemoteDefaultVideoStreamType", the SDK applies the settings in
   the \ref IChannel::setRemoteVideoStreamType "setRemoteVideoStreamType" method.

   @param userId The ID of the remote user sending the video stream.
   @param streamType  Sets the video-stream type. See #REMOTE_VIDEO_STREAM_TYPE.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setRemoteVideoStreamType(uid_t userId, REMOTE_VIDEO_STREAM_TYPE streamType) = 0;
  /** Sets the default stream type of remote videos.

   Under limited network conditions, if the publisher has not disabled the dual-stream mode using
   \ref agora::rtc::IRtcEngine::enableDualStreamMode "enableDualStreamMode" (false),
   the receiver can choose to receive either the high-quality video stream (the high resolution, and high bitrate video stream) or
   the low-video stream (the low resolution, and low bitrate video stream).

   By default, users receive the high-quality video stream. Call this method if you want to switch to the low-video stream.
   This method allows the app to adjust the corresponding video stream type based on the size of the video window to
   reduce the bandwidth and resources. The aspect ratio of the low-video stream is the same as the high-quality video stream.
    Once the resolution of the high-quality video
   stream is set, the system automatically sets the resolution, frame rate, and bitrate of the low-video stream.

   The method result returns in the \ref agora::rtc::IRtcEngineEventHandler::onApiCallExecuted "onApiCallExecuted" callback.

   @note
   - This method can only be called before joining a channel. Agora does not support you to change the default subscribed video stream type after joining a channel.
   - If you call both this method and `setRemoteVideoStreamType`, the SDK applies the settings in the `setRemoteVideoStreamType` method.

   @param streamType Sets the default video-stream type. See #REMOTE_VIDEO_STREAM_TYPE.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setRemoteDefaultVideoStreamType(REMOTE_VIDEO_STREAM_TYPE streamType) = 0;
  /** Creates a data stream.

   @deprecated This method is deprecated from v3.3.0. Use the \ref IChannel::createDataStream(int* streamId, DataStreamConfig& config) "createDataStream" [2/2] method instead.

   Each user can create up to five data streams during the lifecycle of the IChannel.

   @note
   - Do not set `reliable` as `true` while setting `ordered` as `false`.
   - Ensure that you call this method after joining a channel.

   @param[out] streamId The ID of the created data stream.
   @param reliable Sets whether or not the recipients are guaranteed to receive the data stream from the sender within five seconds:
   - true: The recipients receive the data stream from the sender within five seconds. If the recipient does not receive the data stream within five seconds,
   an error is reported to the application.
   - false: There is no guarantee that the recipients receive the data stream within five seconds and no error message is reported for
   any delay or missing data stream.
   @param ordered Sets whether or not the recipients receive the data stream in the sent order:
   - true: The recipients receive the data stream in the sent order.
   - false: The recipients do not receive the data stream in the sent order.

   @return
   - Returns 0: Success.
   - < 0: Failure.
   */
  virtual int createDataStream(int* streamId, bool reliable, bool ordered) AGORA_DEPRECATED_ATTRIBUTE = 0;
  /** Creates a data stream.
   *
   * @since v3.3.0
   *
   * Each user can create up to five data streams in a single channel.
   *
   * This method does not support data reliability. If the receiver receives a data packet five
   * seconds or more after it was sent, the SDK directly discards the data.
   *
   * @param[out] streamId The ID of the created data stream.
   * @param config The configurations for the data stream: DataStreamConfig.
   *
   * @return
   * - 0: Creates the data stream successfully.
   * - < 0: Fails to create the data stream.
   */
  virtual int createDataStream(int* streamId, DataStreamConfig& config) = 0;
  /** Sends data stream messages to all users in a channel.

   The SDK has the following restrictions on this method:
   - Up to 30 packets can be sent per second in a channel with each packet having a maximum size of 1 kB.
   - Each client can send up to 6 kB of data per second.
   - Each user can have up to five data streams simultaneously.

   A successful \ref agora::rtc::IChannel::sendStreamMessage "sendStreamMessage" method call triggers
   the \ref agora::rtc::IChannelEventHandler::onStreamMessage "onStreamMessage" callback on the remote client, from which the remote user gets the stream message.

   A failed \ref agora::rtc::IChannel::sendStreamMessage "sendStreamMessage" method call triggers
   the \ref agora::rtc::IChannelEventHandler::onStreamMessageError "onStreamMessage" callback on the remote client.

   @note
   - This method applies only to the `COMMUNICATION` profile or to the hosts in the `LIVE_BROADCASTING` profile. If an audience in the `LIVE_BROADCASTING` profile calls this method, the audience may be switched to a host.
   - Ensure that you have created the data stream using \ref agora::rtc::IChannel::createDataStream "createDataStream" before calling this method.

   @param  streamId  The ID of the sent data stream, returned in the \ref IChannel::createDataStream "createDataStream" method.
   @param data The sent data.
   @param length The length of the sent data.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int sendStreamMessage(int streamId, const char* data, size_t length) = 0;
  /** Publishes the local stream to a specified CDN streaming URL. (CDN live only.)

   @deprecated This method is deprecated as of v3.6.0. See [Release Notes](https://docs.agora.io/en/Interactive%20Broadcast/release_windows_video?platform=Windows) for an alternative solution.

   The SDK returns the result of this method call in the \ref IRtcEngineEventHandler::onStreamPublished "onStreamPublished" callback.

   After calling this method, you can push media streams in RTMP or RTMPS protocol to the CDN. The SDK triggers
   the \ref agora::rtc::IChannelEventHandler::onRtmpStreamingStateChanged "onRtmpStreamingStateChanged" callback on the local client
   to report the state of adding a local stream to the CDN.

   @note
   - Ensure that the user joins the channel before calling this method.
   - Ensure that you enable the RTMP Converter service before using this function. See Prerequisites in the advanced guide *Push Streams to CDN*.
   - This method adds only one stream CDN streaming URL each time it is called.
   - Agora supports pushing media streams in RTMPS protocol to the CDN only when you enable transcoding.

   @param url The CDN streaming URL in the RTMP or RTMPS format. The maximum length of this parameter is 1024 bytes. The CDN streaming URL must not contain special characters, such as Chinese language characters.
   @param transcodingEnabled Sets whether transcoding is enabled/disabled:
   - true: Enable transcoding. To [transcode](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#transcoding) the audio or video streams when publishing them to CDN live, often used for combining the audio and video streams of multiple hosts in CDN live. If you set this parameter as `true`, ensure that you call the \ref IChannel::setLiveTranscoding "setLiveTranscoding" method before this method.
   - false: Disable transcoding.

   @return
   - 0: Success.
   - < 0: Failure.
        - #ERR_INVALID_ARGUMENT (-2): The CDN streaming URL is NULL or has a string length of 0.
        - #ERR_NOT_INITIALIZED (-7): You have not initialized `IChannel` when publishing the stream.
   */
  virtual int addPublishStreamUrl(const char* url, bool transcodingEnabled) AGORA_DEPRECATED_ATTRIBUTE = 0;
  /** Removes an RTMP or RTMPS stream from the CDN.

   @deprecated This method is deprecated as of v3.6.0. See [Release Notes](https://docs.agora.io/en/Interactive%20Broadcast/release_windows_video?platform=Windows) for an alternative solution.

   This method removes the CDN streaming URL (added by the \ref IChannel::addPublishStreamUrl "addPublishStreamUrl" method) from a CDN live stream.
   The SDK returns the result of this method call in the \ref IRtcEngineEventHandler::onStreamUnpublished "onStreamUnpublished" callback.

   The \ref agora::rtc::IChannel::removePublishStreamUrl "removePublishStreamUrl" method call triggers
   the \ref agora::rtc::IChannelEventHandler::onRtmpStreamingStateChanged "onRtmpStreamingStateChanged" callback on the local client to report the state of removing an RTMP or RTMPS stream from the CDN.

   @note
   - This method removes only one CDN streaming URL each time it is called.
   - The CDN streaming URL must not contain special characters, such as Chinese language characters.

   @param url The CDN streaming URL to be removed. The maximum length of this parameter is 1024 bytes.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int removePublishStreamUrl(const char* url) AGORA_DEPRECATED_ATTRIBUTE = 0;
  /** Sets the video layout and audio settings for CDN live. (CDN live only.)

   @deprecated This method is deprecated as of v3.6.0. See [Release Notes](https://docs.agora.io/en/Interactive%20Broadcast/release_windows_video?platform=Windows) for an alternative solution.

   The SDK triggers the \ref agora::rtc::IChannelEventHandler::onTranscodingUpdated "onTranscodingUpdated" callback when you
   call the `setLiveTranscoding` method to update the transcoding setting.

   @note
   - Ensure that you enable the RTMP Converter service before using this function. See Prerequisites in the advanced guide *Push Streams to CDN*..
   - If you call the `setLiveTranscoding` method to set the transcoding setting for the first time, the SDK does not trigger the `onTranscodingUpdated` callback.
   - Ensure that you call this method after joining a channel.
   - Agora supports pushing media streams in RTMPS protocol to the CDN only when you enable transcoding.

   @param transcoding Sets the CDN live audio/video transcoding settings. See LiveTranscoding.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setLiveTranscoding(const LiveTranscoding& transcoding) AGORA_DEPRECATED_ATTRIBUTE = 0;
  /**
   * Starts pushing media streams to a CDN without transcoding.
   *
   * @since v3.6.0
   *
   * You can call this method to push a live audio-and-video stream to the specified CDN address. This method can push
   * media streams to only one CDN address at a time, so if you need to push streams to multiple addresses, call this
   * method multiple times.
   *
   * After you call this method, the SDK triggers the \ref IChannelEventHandler::onRtmpStreamingStateChanged "onRtmpStreamingStateChanged"
   * callback on the local client to report the state of the streaming.
   *
   * @note
   * - Ensure that you enable the RTMP Converter service before using this function. See Prerequisites in *Push Streams to CDN*.
   * - Call this method after joining a channel.
   * - Only hosts in the `LIVE_BROADCASTING` profile can call this method.
   * - If you want to retry pushing streams after a failed push, make sure to call \ref IChannel::stopRtmpStream "stopRtmpStream" first,
   * then call this method to retry pushing streams; otherwise, the SDK returns the same error code as the last failed push.
   *
   * @param url The address of the CDN live streaming. The format is RTMP or RTMPS. The character length cannot exceed 1024 bytes.
   * Special characters such as Chinese characters are not supported.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *  - `ERR_INVALID_ARGUMENT(-2)`: url is null or the string length is 0.
   *  - `ERR_NOT_INITIALIZED(-7)`: The SDK is not initialized before calling this method.
   */
  virtual int startRtmpStreamWithoutTranscoding(const char* url) = 0;
  /**
   * Starts pushing media streams to a CDN and sets the transcoding configuration.
   *
   * @since v3.6.0
   *
   * You can call this method to push a live audio-and-video stream to the specified CDN address and set the transcoding
   * configuration. This method can push media streams to only one CDN address at a time, so if you need to push streams to
   * multiple addresses, call this method multiple times.
   *
   * After you call this method, the SDK triggers the \ref IChannelEventHandler::onRtmpStreamingStateChanged "onRtmpStreamingStateChanged"
   * callback on the local client to report the state of the streaming.
   *
   * @note
   * - Ensure that you enable the RTMP Converter service before using this function. See Prerequisites in *Push Streams to CDN*.
   * - Call this method after joining a channel.
   * - Only hosts in the `LIVE_BROADCASTING` profile can call this method.
   * - If you want to retry pushing streams after a failed push, make sure to call \ref IChannel::stopRtmpStream "stopRtmpStream" first,
   * then call this method to retry pushing streams; otherwise, the SDK returns the same error code as the last failed push.
   *
   * @param url The address of the CDN live streaming. The format is RTMP or RTMPS. The character length cannot exceed 1024 bytes.
   * Special characters such as Chinese characters are not supported.
   * @param transcoding The transcoding configuration for CDN live streaming. See LiveTranscoding.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *  - `ERR_INVALID_ARGUMENT(-2)`: url is null or the string length is 0.
   *  - `ERR_NOT_INITIALIZED(-7)`: The SDK is not initialized before calling this method.
   */
  virtual int startRtmpStreamWithTranscoding(const char* url, const LiveTranscoding& transcoding) = 0;
  /**
   * Updates the transcoding configuration.
   *
   * @since v3.6.0
   *
   * After you start pushing media streams to CDN with transcoding, you can dynamically update the transcoding configuration according to the scenario.
   * The SDK triggers the \ref IChannelEventHandler::onTranscodingUpdated "onTranscodingUpdated" callback after the
   * transcoding configuration is updated.
   *
   * @param transcoding The transcoding configuration for CDN live streaming. See LiveTranscoding.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int updateRtmpTranscoding(const LiveTranscoding& transcoding) = 0;
  /**
   * Stops pushing media streams to a CDN.
   *
   * @since v3.6.0
   *
   * You can call this method to stop the live stream on the specified CDN address.
   * This method can stop pushing media streams to only one CDN address at a time, so if you need to stop pushing streams to multiple addresses, call this method multiple times.
   *
   * After you call this method, the SDK triggers the \ref IChannelEventHandler::onRtmpStreamingStateChanged "onRtmpStreamingStateChanged" callback on the local client to report the state of the streaming.
   *
   * @param url The address of the CDN live streaming. The format is RTMP or RTMPS.
   * The character length cannot exceed 1024 bytes. Special characters such as Chinese characters are not supported.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int stopRtmpStream(const char* url) = 0;

  /** Adds a voice or video stream URL address to the interactive live streaming.

  The \ref IRtcEngineEventHandler::onStreamPublished "onStreamPublished" callback returns the inject status.
  If this method call is successful, the server pulls the voice or video stream and injects it into a live channel.
  This is applicable to scenarios where all audience members in the channel can watch a live show and interact with each other.

   The \ref agora::rtc::IChannel::addInjectStreamUrl "addInjectStreamUrl" method call triggers the following callbacks:
  - The local client:
    - \ref agora::rtc::IChannelEventHandler::onStreamInjectedStatus "onStreamInjectedStatus" , with the state of the injecting the online stream.
    - \ref agora::rtc::IChannelEventHandler::onUserJoined "onUserJoined" (uid: 666), if the method call is successful and the online media stream is injected into the channel.
  - The remote client:
    - \ref agora::rtc::IChannelEventHandler::onUserJoined "onUserJoined" (uid: 666), if the method call is successful and the online media stream is injected into the channel.

   @warning Agora will soon stop the service for injecting online media streams on the client. If you have not implemented this service, Agora recommends that you do not use it.

   @note
   - Ensure that you enable the RTMP Converter service before using this function. See Prerequisites in the advanced guide *Push Streams to CDN*.
   - This method applies to the Native SDK v2.4.1 and later.
   - This method applies to the `LIVE_BROADCASTING` profile only.
   - You can inject only one media stream into the channel at the same time.
   - Ensure that you call this method after joining a channel.

   @param url The URL address to be added to the ongoing live streaming. Valid protocols are RTMP, HLS, and HTTP-FLV.
   - Supported audio codec type: AAC.
   - Supported video codec type: H264 (AVC).
   @param config The InjectStreamConfig object that contains the configuration of the added voice or video stream.

   @return
   - 0: Success.
   - < 0: Failure.
      - #ERR_INVALID_ARGUMENT (-2): The injected URL does not exist. Call this method again to inject the stream and ensure that the URL is valid.
      - #ERR_NOT_READY (-3): The user is not in the channel.
      - #ERR_NOT_SUPPORTED (-4): The channel profile is not `LIVE_BROADCASTING`. Call the \ref IRtcEngine::setChannelProfile "setChannelProfile" method and set the channel profile to `LIVE_BROADCASTING` before calling this method.
      - #ERR_NOT_INITIALIZED (-7): The SDK is not initialized. Ensure that the IChannel object is initialized before calling this method.
   */
  virtual int addInjectStreamUrl(const char* url, const InjectStreamConfig& config) = 0;
  /** Removes the voice or video stream URL address from a live streaming.

   This method removes the URL address (added by the \ref IChannel::addInjectStreamUrl "addInjectStreamUrl" method) from the live streaming.

   @warning Agora will soon stop the service for injecting online media streams on the client. If you have not implemented this service, Agora recommends that you do not use it.

   @note If this method is called successfully, the SDK triggers the \ref IChannelEventHandler::onUserOffline "onUserOffline" callback and returns a stream uid of 666.

   @param url Pointer to the URL address of the added stream to be removed.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int removeInjectStreamUrl(const char* url) = 0;
  /** Starts to relay media streams across channels.
   *
   * After a successful method call, the SDK triggers the
   * \ref agora::rtc::IChannelEventHandler::onChannelMediaRelayStateChanged
   *  "onChannelMediaRelayStateChanged" and
   * \ref agora::rtc::IChannelEventHandler::onChannelMediaRelayEvent
   * "onChannelMediaRelayEvent" callbacks, and these callbacks return the
   * state and events of the media stream relay.
   * - If the
   * \ref agora::rtc::IChannelEventHandler::onChannelMediaRelayStateChanged
   *  "onChannelMediaRelayStateChanged" callback returns
   * #RELAY_STATE_RUNNING (2) and #RELAY_OK (0), and the
   * \ref agora::rtc::IChannelEventHandler::onChannelMediaRelayEvent
   * "onChannelMediaRelayEvent" callback returns
   * #RELAY_EVENT_PACKET_SENT_TO_DEST_CHANNEL (4), the host starts
   * sending data to the destination channel.
   * - If the
   * \ref agora::rtc::IChannelEventHandler::onChannelMediaRelayStateChanged
   *  "onChannelMediaRelayStateChanged" callback returns
   * #RELAY_STATE_FAILURE (3), an exception occurs during the media stream
   * relay.
   *
   * @note
   * - Call this method after the \ref joinChannel() "joinChannel" method.
   * - This method takes effect only when you are a host in a
   * `LIVE_BROADCASTING` channel.
   * - After a successful method call, if you want to call this method
   * again, ensure that you call the
   * \ref stopChannelMediaRelay() "stopChannelMediaRelay" method to quit the
   * current relay.
   * - Contact sales-us@agora.io before implementing this function.
   * - We do not support string user accounts in this API.
   *
   * @param configuration The configuration of the media stream relay:
   * ChannelMediaRelayConfiguration.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int startChannelMediaRelay(const ChannelMediaRelayConfiguration& configuration) = 0;
  /** Updates the channels for media stream relay.
   *
   * After a successful
   * \ref startChannelMediaRelay() "startChannelMediaRelay" method call, if
   * you want to relay the media stream to more channels, or leave the
   * current relay channel, you can call the
   * \ref updateChannelMediaRelay() "updateChannelMediaRelay" method.
   *
   * After a successful method call, the SDK triggers the
   * \ref agora::rtc::IChannelEventHandler::onChannelMediaRelayEvent
   *  "onChannelMediaRelayEvent" callback with the
   * #RELAY_EVENT_PACKET_UPDATE_DEST_CHANNEL (7) state code.
   *
   * @note Call this method after successfully calling the \ref startChannelMediaRelay() "startChannelMediaRelay" method
   * and receiving the \ref IChannelEventHandler::onChannelMediaRelayStateChanged "onChannelMediaRelayStateChanged" (RELAY_STATE_RUNNING, RELAY_OK) callback;
   * otherwise, this method call fails.
   *
   * @param configuration The media stream relay configuration:
   * ChannelMediaRelayConfiguration.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int updateChannelMediaRelay(const ChannelMediaRelayConfiguration& configuration) = 0;

  /**
   * Pauses the media stream relay to all destination channels.
   *
   * @since v3.5.1
   *
   * After the cross-channel media stream relay starts, you can call this method
   * to pause relaying media streams to all destination channels; after the pause,
   * if you want to resume the relay, call \ref IChannel::resumeAllChannelMediaRelay "resumeAllChannelMediaRelay".
   *
   * After a successful method call, the SDK triggers the
   * \ref IChannelEventHandler::onChannelMediaRelayEvent "onChannelMediaRelayEvent"
   * callback to report whether the media stream relay is successfully paused.
   *
   * @note Call this method after the \ref IChannel::startChannelMediaRelay "startChannelMediaRelay" method.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int pauseAllChannelMediaRelay() = 0;

  /** Resumes the media stream relay to all destination channels.
   *
   * @since v3.5.1
   *
   * After calling the \ref IChannel::pauseAllChannelMediaRelay "pauseAllChannelMediaRelay" method,
   * you can call this method to resume relaying media streams to all destination channels.
   *
   * After a successful method call, the SDK triggers the
   * \ref IChannelEventHandler::onChannelMediaRelayEvent "onChannelMediaRelayEvent"
   * callback to report whether the media stream relay is successfully resumed.
   *
   * @note Call this method after the \ref IChannel::pauseAllChannelMediaRelay "pauseAllChannelMediaRelay" method.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int resumeAllChannelMediaRelay() = 0;

  /** Stops the media stream relay.
   *
   * Once the relay stops, the host quits all the destination
   * channels.
   *
   * After a successful method call, the SDK triggers the
   * \ref agora::rtc::IChannelEventHandler::onChannelMediaRelayStateChanged
   *  "onChannelMediaRelayStateChanged" callback. If the callback returns
   * #RELAY_STATE_IDLE (0) and #RELAY_OK (0), the host successfully
   * stops the relay.
   *
   * @note
   * If the method call fails, the SDK triggers the
   * \ref agora::rtc::IChannelEventHandler::onChannelMediaRelayStateChanged
   *  "onChannelMediaRelayStateChanged" callback with the
   * #RELAY_ERROR_SERVER_NO_RESPONSE (2) or
   * #RELAY_ERROR_SERVER_CONNECTION_LOST (8) error code. You can leave the
   * channel by calling the \ref leaveChannel() "leaveChannel" method, and
   * the media stream relay automatically stops.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int stopChannelMediaRelay() = 0;
  /** Gets the current connection state of the SDK.

   @note You can call this method either before or after joining a channel.

   @return #CONNECTION_STATE_TYPE.
   */
  virtual CONNECTION_STATE_TYPE getConnectionState() = 0;

  /** Enables/Disables the super resolution feature for a remote user's video. (beta feature)
   *
   * @since v3.5.1
   *
   * This feature effectively boosts the resolution of a remote user's video seen by the local
   * user. If the original resolution of a remote user's video is a × b, the local user's device
   * can render the remote video at a resolution of 2a × 2b after you enable this feature.
   *
   * After calling this method, the SDK triggers the
   * \ref IChannelEventHandler::onUserSuperResolutionEnabled "onUserSuperResolutionEnabled"
   * callback to report whether you have successfully enabled super resolution.
   *
   * @warning The super resolution feature requires extra system resources. To balance the visual experience and system consumption, the SDK poses the following restrictions:
   * - This feature can only be enabled for a single remote user.
   * - The original resolution of the remote user's video cannot exceed a certain range. If the local user use super resolution on Android,
   * the original resolution of the remote user's video cannot exceed 640 × 360 pixels; if the local user use super resolution on iOS,
   * the original resolution of the remote user's video cannot exceed 640 × 480 pixels.
   *
   * @warning If you exceed these limitations, the SDK triggers the
   * \ref IRtcEngineEventHandler::onWarning "onWarning" callback and returns the corresponding warning codes:
   *
   * - #WARN_SUPER_RESOLUTION_STREAM_OVER_LIMITATION (1610): The original resolution of the remote user's video is beyond
   * the range where super resolution can be applied.
   * - #WARN_SUPER_RESOLUTION_USER_COUNT_OVER_LIMITATION (1611): Super resolution is already being used to boost another
   * remote user's video.
   * - #WARN_SUPER_RESOLUTION_DEVICE_NOT_SUPPORTED (1612): The device does not support using super resolution.
   *
   * @note
   * - This method is for Android and iOS only.
   * - Before calling this method, ensure that you have integrated the following dynamic library into your project:
   *  - Android: `libagora_super_resolution_extension.so`
   *  - iOS: `AgoraSuperResolutionExtension.xcframework`
   * - Because this method has certain system performance requirements, Agora recommends that you use the following devices or better:
   *  - Android:
   *    - VIVO: V1821A, NEX S, 1914A, 1916A, 1962A, 1824BA, X60, X60 Pro
   *    - OPPO: PCCM00, Find X3
   *    - OnePlus: A6000
   *    - Xiaomi: Mi 8, Mi 9, Mi 10, Mi 11, MIX3, Redmi K20 Pro
   *    - SAMSUNG: SM-G9600, SM-G9650, SM-N9600, SM-G9708, SM-G960U, SM-G9750, S20, S21
   *    - HUAWEI: SEA-AL00, ELE-AL00, VOG-AL00, YAL-AL10, HMA-AL00, EVR-AN00, nova 4, nova 5 Pro,
   * nova 6 5G, nova 7 5G, Mate 30, Mate 30 Pro, Mate 40, Mate 40 Pro, P40 P40 Pro, HUAWEI MediaPad M6, MatePad 10.8
   *  - iOS (iOS 12.0 or later):
   *      - iPhone XR
   *      - iPhone XS
   *      - iPhone XS Max
   *      - iPhone 11
   *      - iPhone 11 Pro
   *      - iPhone 11 Pro Max
   *      - iPhone 12
   *      - iPhone 12 mini
   *      - iPhone 12 Pro
   *      - iPhone 12 Pro Max
   *      - iPhone 12 SE (2nd generation)
   *      - iPad Pro 11-inch (3rd generation)
   *      - iPad Pro 12.9-inch (3rd generation)
   *      - iPad Air (3rd generation)
   *      - iPad Air (4th generation)
   *
   * @param userId The user ID of the remote user.
   * @param enable Determines whether to enable super resolution for the remote user's video:
   * - true: Enable super resolution.
   * - false: Disable super resolution.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *   - `-157 (ERR_MODULE_NOT_FOUND)`: The dynamic library for super resolution is not integrated.
   */
  virtual int enableRemoteSuperResolution(uid_t userId, bool enable) = 0;
};
/** @since v3.0.0

 The IRtcEngine2 class. */
class IRtcEngine2 : public IRtcEngine {
 public:
  /** Creates and gets an `IChannel` object.

   To join more than one channel, call this method multiple times to create as many `IChannel` objects as needed, and
   call the \ref agora::rtc::IChannel::joinChannel "joinChannel" method of each created `IChannel` object.

   After joining multiple channels, you can simultaneously subscribe to streams of all the channels, but publish a stream in only one channel at one time.
   @param channelId The unique channel name for an Agora RTC session. It must be in the string format and not exceed 64 bytes in length. Supported character scopes are:
   - All lowercase English letters: a to z.
   - All uppercase English letters: A to Z.
   - All numeric characters: 0 to 9.
   - The space character.
   - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".

   @note
   - This parameter does not have a default value. You must set it.
   - Do not set it as the empty string "". Otherwise, the SDK returns #ERR_REFUSED (5).

   @return
   - The `IChannel` object, if the method call succeeds.
   - An empty pointer NULL, if the method call fails.
   - `ERR_REFUSED(5)`, if you set channelId as the empty string "".
   */
  virtual IChannel* createChannel(const char* channelId) = 0;
};

}  // namespace rtc
}  // namespace agora

#endif
