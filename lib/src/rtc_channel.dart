import 'dart:async';
import 'dart:typed_data';

import 'package:agora_rtc_engine/src/impl/rtc_channel_impl.dart';

import 'classes.dart';
import 'enums.dart';
import 'rtc_channel_event_handler.dart';

///
/// Provides methods that enable real-time communications in an channel.
/// Call create to create an RtcChannel object.
///
abstract class RtcChannel {
  ///
  /// Gets the current channel ID.
  ///
  ///
  /// **return** The current channel ID, if the method call succeeds.
  ///  The empty string "", if the method call fails.
  ///
  String get channelId;

  ///
  /// Creates a channel by channel name.
  ///
  ///
  /// Param [channelName] The channel name. This parameter signifies the channel in which users engage in real-time audio and video interaction. Under the premise of the same App ID, users who fill in the same channel ID enter the same channel for audio and video interaction. The string length must be less than 64 bytes. Supported characters:
  ///  The 26 lowercase English letters: a to z.
  ///  The 26 uppercase English letters: A to Z.
  ///  The 10 numeric characters: 0 to 9.
  ///  Space
  ///  "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","
  ///
  /// **return** An RtcChannel object.
  ///
  static Future<RtcChannel> create(String channelId) {
    return RtcChannelImpl.create(channelId);
  }

  ///
  /// Releases the RtcChannel instance.
  ///
  ///
  Future<void> destroy();

  ///
  /// Destroys all RtcChannel instances.
  ///
  ///
  static void destroyAll() {
    RtcChannelImpl.destroyAll();
  }

  ///
  /// Sets the event handler for the RtcChannel object.
  /// After setting the channel event handler, you can listen for channel events and receive the statistics of the corresponding RtcChannel object.
  ///
  /// Param [handler] The event handler for the RtcChannel object.
  ///
  /// **return** 0(ERR_OK): Success.
  ///  < 0: Failure.
  ///
  void setEventHandler(RtcChannelEventHandler handler);

  ///
  /// Sets the user role and level in an interactive live streaming channel.
  /// You can call this method either before or after joining the channel to set the user role as audience or host.
  ///  If you call this method to switch the user role after joining the channel, the SDK triggers the following callbacks:
  ///  The local client: clientRoleChanged .
  ///  The remote client: userJoined or userOffline .
  ///  This method only takes effect when the channel profile is live interactive streaming (when the profile parameter in setChannelProfile set as LiveBroadcasting).
  ///
  /// Param [role] The user role in the interactive live streaming. See ClientRole .
  ///
  /// Param [options] The detailed options of a user, including the user level. See ClientRoleOptions for details.
  ///
  Future<void> setClientRole(ClientRole role, [ClientRoleOptions? options]);

  ///
  /// Joins the channel with a user ID.
  /// Once the user joins the channel, the user subscribes to the audio and video streams of all the other users in the channel by default, giving rise to usage and billing calculation. If you do not want to subscribe to a specified stream or all remote streams, call the mute methods accordingly. If you are already in a channel, you cannot rejoin it with the user ID.
  ///  We recommend using different UIDs for different channels.
  ///  If you want to join the same channel from different devices, ensure that the user IDs in all devices are different.
  ///
  /// Param [options] The channel media options.
  ///
  ///
  /// Param [optionalInfo] Reserved for future use.
  ///
  ///
  /// Param [token] The token generated on your server for authentication. See Authenticate Your Users with Token.
  ///  Ensure that the App ID used for creating the token is the same App ID used by the createWithContext method for initializing the RTC engine.
  ///
  /// Param [optionalUid] User ID. This parameter is used to identify the user in the channel for real-time audio and video interaction. You need to set and manage user IDs yourself, and ensure that each user ID in the same channel is unique. This parameter is a 32-bit unsigned integer with a value ranging from 1 to 232 -1. If the user ID is not assigned (or set as 0), the SDK assigns a user ID and reports it in the joinChannelSuccess callback. Your app must maintain this user ID.
  ///
  Future<void> joinChannel(String? token, String? optionalInfo, int optionalUid,
      ChannelMediaOptions options);

  ///
  /// Joins the channel with a user account.
  /// Once the user joins the channel, the user subscribes to the audio and video streams of all the other users in the channel by default, giving rise to usage and billing calculation. If you do not want to subscribe to a specified stream or all remote streams, call the mute methods accordingly. If you are already in a channel, you cannot rejoin it with the user ID.
  ///  We recommend using different user accounts for different channels.
  ///  If you want to join the same channel from different devices, ensure that the user accounts in all devices are different.
  ///
  /// Param [options] The channel media options.
  ///
  ///
  /// Param [userAccount] The user account. This parameter is used to identify the user in the channel for real-time audio and video engagement. You need to set and manage user accounts yourself and ensure that each user account in the same channel is unique. The maximum length of this parameter is 255 bytes. Ensure that you set this parameter and do not set it as null. Supported characters are (89 in total): The 26 lowercase English letters: a to z.
  ///  The 26 uppercase English letters: A to Z.
  ///  All numeric characters: 0 to 9.
  ///  Space
  ///  "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","
  ///
  /// Param [token] The token generated on your server for authentication. See Authenticate Your Users with Token.
  ///  Ensure that the App ID used for creating the token is the same App ID used by the createWithContext method for initializing the RTC engine.
  ///
  Future<void> joinChannelWithUserAccount(
      String? token, String userAccount, ChannelMediaOptions options);

  ///
  /// Leaves a channel.
  /// This method lets the user leave the channel, for example, by hanging up or exiting the call. This method releases all resources related to the session. This method call is asynchronous, and the user has not left the channel when the method call returns.
  ///  After calling joinChannel , you must call leaveChannel to end the call, otherwise the next call cannot be started.
  ///  No matter whether you are currently in a call or not, you can call leaveChannel without side effects.
  ///  A successful call of this method triggers the following callbacks:
  ///  The local client: leaveChannel .
  ///  The remote client: userOffline , if the user
  ///  joining the channel is in the COMMUNICATION profile, or is a host in the
  ///  LIVE_BROADCASTING profile.
  ///  If you call the leaveChannel method immediately after calling destroy , the SDK will not be able to trigger the leaveChannel callback.
  ///  If you call the leaveChannel method during a CDN live streaming, the SDK automatically calls the removePublishStreamUrl method.
  ///
  Future<void> leaveChannel();

  ///
  /// Gets a new token when the current token expires after a period of time.
  /// Passes a new token to the SDK. A token expires after a certain period of time. The app should get a new token and call this method to pass the token to the SDK. Failure to do so results in the SDK disconnecting from the server.
  ///  The SDK triggers the tokenPrivilegeWillExpire callback.
  ///  The connectionStateChanged callback reports TokenExpired(9).
  ///
  /// Param [token] The new token.
  ///
  Future<void> renewToken(String token);

  ///
  /// Gets the current connection state of the SDK.
  /// You can call this method either before or after joining a channel.
  ///
  /// **return** The current connection state.
  ///
  Future<ConnectionStateType> getConnectionState();

  ///
  /// Publish local audio and video streams to the channel.
  /// The call of this method must meet the following requirements, otherwise the SDK returns -5(ERR_REFUSED):
  ///  This method only supports publishing audio and video streams to the channel corresponding to the current RtcChannel object.
  ///  In the interactive live streaming channel, only a host can call this method. To switch the client role, call setClientRole of the current RtcChannel object.
  ///  You can publish a stream to only one channel at a time. For details on joining multiple channels, see the advanced guide Join Multiple Channels.
  ///
  @Deprecated('')
  Future<void> publish();

  ///
  /// Stops publishing a stream to the channel.
  /// If you call this method in a channel where you are not publishing streams, the SDK returns
  ///  -5 (ERR_REFUSED).
  ///
  @Deprecated('')
  Future<void> unpublish();

  ///
  /// Retrieves the call ID.
  /// When a user joins a channel on a client, a callId is generated to identify the call from the client. Some methods, such as rate and complain , must be called after the call ends to submit feedback to the SDK. These methods require the callId parameter.
  ///  Call this method after joining a channel.
  ///
  /// **return** The current call ID.
  ///
  Future<String?> getCallId();

  ///
  /// Adjusts the playback signal volume of a specified remote user.
  /// You can call this method to adjust the playback volume of a specified remote user. To adjust the playback volume of different remote users, call the method as many times, once for each remote user. Call this method after joining a channel.
  ///  The playback volume here refers to the mixed volume of a specified remote user.
  ///
  /// Param [volume] Audio mixing volume. The value ranges between 0 and 100. The default value is 100, the original volume.
  ///
  /// Param [uid] The ID of the remote user.
  ///
  Future<void> adjustUserPlaybackSignalVolume(int uid, int volume);

  ///
  /// Stops or resumes publishing the local audio stream.
  ///
  ///
  /// Param [mute] Whether to stop publishing the local audio stream. true: Stop publishing the local audio stream.
  ///  false: (Default) Resumes publishing the local audio stream.
  ///
  Future<void> muteLocalAudioStream(bool mute);

  ///
  /// Stops or resumes subscribing to the audio stream of a specified user.
  /// Call this method after joining a channel.
  ///  See recommended settings in Set the Subscribing State.
  ///
  /// Param [userId] The user ID of the specified user.
  ///
  /// Param [muted] Whether to stop subscribing to the audio stream of the specified user. true: Stop subscribing to the audio stream of the specified user.
  ///  false: (Default) Subscribe to the audio stream of the specified user.
  ///
  Future<void> muteRemoteAudioStream(int userId, bool muted);

  ///
  /// Stops or resumes subscribing to the audio streams of all remote users.
  /// As of v3.3.0, after successfully calling this method, the local user stops or resumes subscribing to the audio streams of all remote users, including all subsequent users. Call this method after joining a channel.
  ///
  /// Param [muted] Whether to subscribe to the audio streams of all remote users:
  ///  true: Do not subscribe to the audio streams of all remote users.
  ///  false: (Default) Subscribe to the audio streams of all remote users by default.
  ///
  Future<void> muteAllRemoteAudioStreams(bool muted);

  ///
  /// Stops or resumes subscribing to the audio streams of all remote users by default.
  /// Call this method after joining a channel. After successfully calling this method, the local user stops or resumes subscribing to the audio streams of all subsequent users. Deprecated:
  ///  This method is deprecated.
  ///  If you need to resume subscribing to the audio streams of remote users in the channel after calling this method, do the following: If you need to resume subscribing to the audio stream of a specified user, call muteRemoteAudioStream (false), and specify the user ID.
  ///  If you need to resume subscribing to the audio streams of multiple remote users, call muteRemoteAudioStream (false) multiple times.
  ///
  /// Param [muted] Whether to stop subscribing to the audio streams of all remote users by default.
  ///  true: Stop subscribing to the audio streams of all remote users by default.
  ///  false: (Default) Subscribe to the audio streams of all remote users by default.
  ///
  @Deprecated('')
  Future<void> setDefaultMuteAllRemoteAudioStreams(bool muted);

  ///
  /// Stops or resumes publishing the local video stream.
  ///
  ///
  /// Param [muted] Whether to stop publishing the local video stream.
  ///  true: Stop publishing the local video stream.
  ///  false: (Default) Publish the local video stream.
  ///
  Future<void> muteLocalVideoStream(bool muted);

  ///
  /// Stops or resumes subscribing to the video stream of a specified user.
  /// Call this method after joining a channel.
  ///  See recommended settings in Set the Subscribing State.
  ///
  /// Param [userId] The ID of the specified user.
  ///
  /// Param [muted] Whether to stop subscribing to the video stream of the specified user.
  ///  true: Stop subscribing to the video streams of the specified user.
  ///  false: (Default) Subscribe to the video stream of the specified user.
  ///
  Future<void> muteRemoteVideoStream(int userId, bool muted);

  ///
  /// Stops or resumes subscribing to the video streams of all remote users.
  /// As of v3.3.0, after successfully calling this method, the local user stops or resumes subscribing to the video streams of all remote users, including all subsequent users. Call this method after joining a channel.
  ///  See recommended settings in Set the Subscribing State.
  ///
  /// Param [muted] Whether to stop subscribing to the video streams of all remote users.
  ///  true: Stop subscribing to the video streams of all remote users.
  ///  false: (Default) Subscribe to the audio streams of all remote users by default.
  ///
  Future<void> muteAllRemoteVideoStreams(bool muted);

  ///
  /// Stops or resumes subscribing to the video streams of all remote users by default.
  /// Call this method after joining a channel. After successfully calling this method, the local user stops or resumes subscribing to the audio streams of all subsequent users. Deprecated:
  ///  This method is deprecated.
  ///  If you need to resume subscribing to the video streams of remote users in the channel, do the following: If you need to resume subscribing to a single user, call muteRemoteVideoStream (false) and specify the ID of the remote user you want to subscribe to.
  ///  If you want to resume subscribing to multiple users, call muteRemoteVideoStream(false) multiple times.
  ///
  /// Param [muted] Whether to stop subscribing to the audio streams of all remote users by default.
  ///  true: Stop subscribing to the audio streams of all remote users by default.
  ///  false: (Default) Resume subscribing to the audio streams of all remote users by default.
  ///
  @Deprecated('')
  Future<void> setDefaultMuteAllRemoteVideoStreams(bool muted);

  ///
  /// Enables/Disables the super-resolution algorithm for a remote user's video stream.
  /// This feature effectively boosts the resolution of a remote user's video seen by the local user. If the original resolution of a remote user's video is a × b, the local user's device can render the remote video at a resolution of 2a × 2b
  ///  after you enable this feature.
  ///  After you call this method, the SDK triggers the userSuperResolutionEnabled callback to report whether you have successfully enabled super resolution.
  ///  The super resolution feature requires extra system resources. To balance the visual experience and system usage, the SDK poses the following restrictions: This feature can only be enabled for a single remote user.
  ///  On Android, the original resolution of the remote video must not exceed 640 × 360 pixels. On iOS, the original resolution of the remote video must not exceed 640 × 480 pixels. If you exceed these limitations, the SDK triggers the warning callback and returns the corresponding warning codes:
  ///  SuperResolutionStreamOverLimitation: 1610. The origin resolution of the remote video is beyond the range where the super resolution can be applied.
  ///  SuperResolutionUserCountOverLimitation: 1611. Super resolution is already being used on another remote user's video.
  ///  SuperResolutionDeviceNotSupported: 1612. The device does not support using super resolution.
  ///  This method is for Android and iOS only.
  ///  Before calling this method, ensure that you have integrated the following dynamic libraries:
  ///  Android: libagora_super_resolution_extension.so
  ///  iOS: AgoraSuperResolutionExtension.xcframework Because this method has certain system performance requirements, Agora recommends that you use the following devices or better:
  ///  Android:
  ///  VIVO: V1821A, NEX S, 1914A, 1916A, 1962A, 1824BA, X60, X60 Pro
  ///  OPPO: PCCM00, Find X3
  ///  OnePlus: A6000
  ///  Xiaomi: Mi 8, Mi 9, Mi 10, Mi 11, MIX3, Redmi K20 Pro
  ///  SAMSUNG: SM-G9600, SM-G9650, SM-N9600, SM-G9708, SM-G960U, SM-G9750, S20, S21
  ///  HUAWEI: SEA-AL00, ELE-AL00, VOG-AL00, YAL-AL10, HMA-AL00, EVR-AN00, nova 4, nova 5 Pro, nova 6 5G, nova 7 5G, Mate 30, Mate 30 Pro, Mate 40, Mate 40 Pro, P40, P40 Pro, Huawei M6, MatePad 10.8 iOS:
  ///  iPhone XR
  ///  iPhone XS
  ///  iPhone XS Max
  ///  iPhone 11
  ///  iPhone 11 Pro
  ///  iPhone 11 Pro Max
  ///  iPhone 12
  ///  iPhone 12 mini
  ///  iPhone 12 Pro
  ///  iPhone 12 Pro Max
  ///  iPhone 12 SE (2nd generation)
  ///  iPad Pro 11-inch (3rd generation)
  ///  iPad Pro 12.9-inch (3rd generation)
  ///  iPad Air 3 (3rd generation)
  ///  iPad Air 3 (4th generation)
  ///
  /// Param [userId] The ID of the remote user.
  ///
  /// Param [enable] Whether to enable super resolution for the remote user’s video:
  ///  true: Enable virtual background.
  ///  false: Do not enable virtual background.
  ///
  ///
  Future<void> enableRemoteSuperResolution(int userId, bool enable);

  ///
  /// Sets the 2D position (the position on the horizontal plane) of the remote user's voice.
  /// This method sets the 2D position and volume of a remote user, so that the local user can easily hear and identify the remote user's position.
  ///  When the local user calls this method to set the voice position of a remote user, the voice difference between the left and right channels allows the local user to track the real-time position of the remote user, creating a sense of space. This method applies to massive multiplayer online games, such as Battle Royale games. For this method to work, enable stereo panning for remote users by calling the enableSoundPositionIndication method before joining a channel.
  ///  For the best voice positioning, Agora recommends using a wired headset.
  ///  Call this method after joining a channel.
  ///
  /// Param [uid] The user ID of the remote user.
  ///
  /// Param [pan] The voice position of the remote user. The value ranges from -1.0 to 1.0:
  ///  0.0: (Default) The remote voice comes from the front.
  ///  -1.0: The remote voice comes from the left.
  ///  1.0: The remote voice comes from the right.
  ///
  /// Param [gain] The volume of the remote user. The value ranges from 0.0 to 100.0. The default value is 100.0 (the original volume of the remote user). The smaller the value, the lower the volume.
  ///
  Future<void> setRemoteVoicePosition(int uid, double pan, double gain);

  ///
  /// Sets the transcoding configurations for media push.
  /// This method takes effect only when you are a host in live interactive streaming.
  ///  Ensure that you enable the Media Push service before using this function. See Prerequisites in the advanced guide Media Push.
  ///  If you call this method to set the transcoding configuration for the first time, the SDK does not trigger the transcodingUpdated callback.
  ///  Call this method after joining a channel.
  ///  Agora only supports pushing media streams to the CDN in RTMPS protocol when you enable transcoding. Deprecated: This method is deprecated. See Release Notes for an alternative solution. This method sets the video layout and audio settings for CDN live streaming. The SDK triggers the
  ///  transcodingUpdated
  ///  callback when you call this method to update the transcoding setting.
  ///
  /// Param [transcoding] The transcoding configurations for the media push. See LiveTranscoding for details.
  ///
  Future<void> setLiveTranscoding(LiveTranscoding transcoding);

  ///
  ///  Publishes the local stream to a specified CDN live streaming URL.
  /// Call this method after joining a channel.
  ///  Ensure that the media push function is enabled.
  ///  This method takes effect only when you are a host in live interactive streaming.
  ///  This method adds only one streaming URL to the CDN each time it is called. To push multiple URLs, call this method multiple times.
  ///  Agora only supports pushing media streams to the CDN in RTMPS protocol when you enable transcoding. Deprecated: This method is deprecated. See Release Notes for an alternative solution. After calling this method, you can push media streams in RTMP or RTMPS protocol to the CDN. The SDK triggers the
  ///  rtmpStreamingStateChanged
  ///  callback on the local client to report the state of adding a local stream to the CDN.
  ///
  /// Param [url] The media push URL in the RTMP or RTMPS format. The maximum length of this parameter is 1024 bytes. The URL address must not contain special characters, such as Chinese language characters.
  ///
  /// Param [transcodingEnabled] Whether to enable transcoding. Transcoding in a CDN live streaming converts the audio and video streams before pushing them to the CDN server. It applies to scenarios where a channel has multiple broadcasters and composite layout is needed.
  ///  true: Enable transcoding.
  ///  false: Disable transcoding. If you set this parameter as true , ensure that you call the
  ///  setLiveTranscoding
  ///  method before this method.
  ///
  Future<void> addPublishStreamUrl(String url, bool transcodingEnabled);

  ///
  ///  Removes an RTMP or RTMPS stream from the CDN.
  /// Before calling this method, make sure that the media push function has been enabled.
  ///  This method takes effect only when you are a host in live interactive streaming.
  ///  Call this method after joining a channel.
  ///  This method removes only one media push URL each time it is called. To remove multiple URLs, call this method multiple times. Deprecated: This method is deprecated. See Release Notes for an alternative solution. After a successful method call, the SDK triggers
  ///  rtmpStreamingStateChanged
  ///  on the local client to report the result of deleting the address.
  ///
  /// Param [url] The media push URL to be removed. The maximum length of this parameter is 1024 bytes. The media push URL must not contain special characters, such as Chinese characters.
  ///
  Future<void> removePublishStreamUrl(String url);

  ///
  /// Starts relaying media streams across channels. This method can be used to implement scenarios such as co-host across channels.
  /// After a successful method call, the SDK triggers the channelMediaRelayStateChanged and channelMediaRelayEvent callbacks, and these callbacks return the state and events of the media stream relay.
  ///  If the channelMediaRelayStateChanged callback returns Running (2) and None (0), and the channelMediaRelayEvent callback returns SentToDestinationChannel (4), it means that the SDK starts relaying media streams between the source channel and the destination channel.
  ///  If the channelMediaRelayStateChanged callback returns Failure (3), an exception occurs during the media stream relay. Call this method after joining the channel.
  ///  This method takes effect only when you are a host in a live streaming channel.
  ///  After a successful method call, if you want to call this method again, ensure that you call the stopChannelMediaRelay method to quit the current relay.
  ///  You need to before implementing this function.
  ///  We do not support string user accounts in this API.
  ///
  /// Param [channelMediaRelayConfiguration] The configuration of the media stream relay. See ChannelMediaRelayConfiguration for details.
  ///
  Future<void> startChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration);

  ///
  /// Updates the channels for media stream relay.
  /// After the media relay starts, if you want to relay the media stream to more channels, or leave the current relay channel, you can call the updateChannelMediaRelay method.
  ///  After a successful method call, the SDK triggers the channelMediaRelayEvent callback with the UpdateDestinationChannel(7) state code.
  ///  Call this method after the startChannelMediaRelay method to update the destination channel.
  ///
  /// Param [channelMediaRelayConfiguration] The configuration of the media stream relay.
  ///
  Future<void> updateChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration);

  ///
  /// Stops the media stream relay. Once the relay stops, the host quits all the destination channels.
  /// After a successful method call, the SDK triggers the channelMediaRelayStateChanged callback. If the callback reports Idle(0) and None(0), the host successfully stops the relay.
  ///  If the method call fails, the SDK triggers the channelMediaRelayStateChanged callback with the ServerNoResponse(2) or ServerConnectionLost(8) status code. You can call the leaveChannel method to leave the channel, and the media stream relay automatically stops.
  ///
  Future<void> stopChannelMediaRelay();

  ///
  /// Pauses the media stream relay to all destination channels.
  /// After the cross-channel media stream relay starts, you can call this method to pause relaying media streams to all destination channels; after the pause, if you want to resume the relay, call resumeAllChannelMediaRelay .
  ///  After a successful method call, the SDK triggers the channelMediaRelayEvent callback to report whether the media stream relay is successfully paused.
  ///  Call this method after startChannelMediaRelay .
  ///
  Future<void> pauseAllChannelMediaRelay();

  ///
  /// Resumes the media stream relay to all destination channels.
  /// After calling the pauseAllChannelMediaRelay method, you can call this method to resume relaying media streams to all destination channels.
  ///  After a successful method call, the SDK triggers the channelMediaRelayEvent callback to report whether the media stream relay is successfully resumed.
  ///  Call this method after the pauseAllChannelMediaRelay method.
  ///
  Future<void> resumeAllChannelMediaRelay();

  ///
  ///  Sets the stream type of the remote video.
  /// The method result returns in the apiCallExecuted callback.
  ///  By default, users receive the high-quality video stream. Call this method if you want to switch to the low-quality video stream. This method allows the app to adjust the corresponding video stream type based on the size of the video window to reduce the bandwidth and resources. The aspect ratio of the low-quality video stream is the same as the high-quality video stream. Once the resolution of the high-quality video stream is set, the system automatically sets the resolution, frame rate, and bitrate of the low-quality video stream. Under limited network conditions, if the publisher has not disabled the dual-stream mode using enableDualStreamMode (false), the receiver can choose to receive either the high-quality video stream (the high resolution, and high bitrate video stream) or the low-quality video stream (the low resolution, and low bitrate video stream). The high-quality video stream has a higher resolution and bitrate, and the low-quality video stream has a lower resolution and bitrate.
  ///  Call this method after joining a channel. If you call both setRemoteVideoStreamType and setRemoteDefaultVideoStreamType , the setting of setRemoteVideoStreamType takes effect.
  ///
  /// Param [uid] User ID.
  ///
  /// Param [userId] User ID.
  ///
  /// Param [streamType] The video stream type: VideoStreamType .
  ///
  ///
  Future<void> setRemoteVideoStreamType(int userId, VideoStreamType streamType);

  ///
  /// Sets the default stream type of remote video streams.
  /// The result of this method returns in the apiCallExecuted callback.
  ///  By default, users receive the high-quality video stream. Call this method if you want to switch to the low-quality video stream. This method allows the app to adjust the corresponding video stream type based on the size of the video window to reduce the bandwidth and resources. The aspect ratio of the low-quality video stream is the same as the high-quality video stream. Once the resolution of the high-quality video stream is set, the system automatically sets the resolution, frame rate, and bitrate of the low-quality video stream.
  ///  Under limited network conditions, if the publisher has not disabled the dual-stream mode using (),the receiver can choose to receive either the high-quality video stream or the low-quality video stream. The high-quality video stream has a higher resolution and bitrate, and the low-quality video stream has a lower resolution and bitrate. enableDualStreamMode false
  ///  Call this method after joining a channel. If you call both setRemoteVideoStreamType and setRemoteDefaultVideoStreamType, the setting of setRemoteVideoStreamType takes effect.
  ///
  /// Param [streamType] The default stream type of the remote video, see VideoStreamType .
  ///
  ///
  Future<void> setRemoteDefaultVideoStreamType(VideoStreamType streamType);

  ///
  /// Prioritizes a remote user's stream.
  /// Prioritizes a remote user's stream. The SDK ensures the high-priority user gets the best possible stream quality. The SDK ensures the high-priority user gets the best possible stream quality. The SDK supports setting only one user as high priority.
  ///  Ensure that you call this method before joining a channel.
  ///
  /// Param [uid] The ID of the remote user.
  ///
  /// Param [userPriority] The priority of the remote user. See UserPriority .
  ///
  Future<void> setRemoteUserPriority(int uid, UserPriority userPriority);

  ///
  /// Registers the metadata observer.
  /// Call this method before joinChannel .
  ///  This method applies only to interactive live streaming.
  ///
  Future<void> registerMediaMetadataObserver();

  ///
  /// Unregisters the media metadata observer.
  ///
  ///
  Future<void> unregisterMediaMetadataObserver();

  ///
  /// Sets the maximum size of the media metadata.
  /// After calling registerMediaMetadataObserver , you can call this method to set the maximum size of the media metadata.
  ///
  /// Param [size] The maximum size of media metadata.
  ///
  Future<void> setMaxMetadataSize(int size);

  ///
  /// Sends media metadata.
  /// If the metadata is sent successfully, the SDK triggers the metadataReceived callback on the receiver.
  ///
  /// Param [metadata] Media metadata. See Metadata .
  ///
  Future<void> sendMetadata(Uint8List metadata);

  ///
  /// Enables built-in encryption with an encryption password before users join a channel.
  /// Do not use this method for CDN live streaming.
  ///  For optimal transmission, ensure that the encrypted data size does not exceed the original data size + 16 bytes. 16 bytes is the maximum padding size for AES encryption. Before joining the channel, you need to call this method to set the secret parameter to enable the built-in encryption. All users in the same channel should use the same secret. The secret is automatically cleared once a user leaves the channel. If you do not specify the secret or secret is set as null, the built-in encryption is disabled. Deprecated:
  ///  Please use the enableEncryption method instead.
  ///
  /// Param [secret] The encryption password.
  ///
  @Deprecated('Please use the enableEncryption method instead.')
  Future<void> setEncryptionSecret(String secret);

  ///
  /// Sets the built-in encryption mode.
  /// The Agora SDK supports built-in encryption, which is set to the AES-128-GCM mode by default. The Agora SDK supports built-in encryption, which is set to the AES-128-XTS mode by default. Call this method to use other encryption modes. All users in the same channel must use the same encryption mode and secret. Refer to the information related to the AES encryption algorithm on the differences between the encryption modes. Deprecated:
  ///  Please use the enableEncryption method instead. Before calling this method, please call setEncryptionSecret to enable the built-in encryption function.
  ///
  /// Param [encryptionMode] Encryption mode.
  ///  "aes-128-xts": 128-bit AES encryption, XTS mode.
  ///  "aes-128-ecb": 128-bit AES encryption, ECB mode.
  ///  "aes-256-xts": 256-bit AES encryption, XTS mode.
  ///  "sm4-128-ecb": 128-bit SM4 encryption, ECB mode.
  ///  "aes-128-gcm": 128-bit AES encryption, GCM mode.
  ///  "aes-256-gcm": 256-bit AES encryption, GCM mode.
  ///  "": When this parameter is set as null, the encryption mode is set as "aes-128-gcm" by default.
  ///  "": When setting as NULL, the encryption mode is set as "aes-128-xts" by default.
  ///
  @Deprecated('Please use the enableEncryption method instead.')
  Future<void> setEncryptionMode(EncryptionMode encryptionMode);

  ///
  /// Enables/Disables the built-in encryption.
  /// In scenarios requiring high security, Agora recommends calling this method to enable the built-in encryption before joining a channel.
  ///  All users in the same channel must use the same encryption mode and encryption key. After the user leaves the channel, the SDK automatically disables the built-in encryption. To enable the built-in encryption, call this method before the user joins the channel again.
  ///  If you enable the built-in encryption, you cannot use the media push function.
  ///
  /// Param [enabled] Whether to enable built-in encryption:
  ///  true: Enable the built-in encryption.
  ///  false: Disable the built-in encryption.
  ///
  /// Param [config] Built-in encryption configurations. See EncryptionConfig for details.
  ///
  Future<void> enableEncryption(bool enabled, EncryptionConfig config);

  ///
  /// Injects an online media stream to a live streaming channel.
  /// Agora will soon stop the service for injecting online media streams on the client. If you have not implemented this service, Agora recommends that you do not use it.  Ensure that you enable the Media Push service before using this function. See Prerequisites in Media Push.
  ///  This method takes effect only when you are a host in a live streaming channel.
  ///  Only one online media stream can be injected into the same channel at the same time.
  ///  Call this method after joining a channel. This method injects the currently playing audio and video as audio and video sources into the ongoing live broadcast. This applies to scenarios where all users in the channel can watch a live show and interact with each other. After calling this method, the SDK triggers the streamInjectedStatus callback on the local client to report the state of injecting the online media stream; after successfully injecting the media stream, the stream joins the channel, and all users in the channel receive the userJoined callback, where uid is 666.
  ///
  /// Param [url] The URL address to be added to the ongoing streaming. Valid protocols are RTMP, HLS, and HTTP-FLV.
  ///  Supported audio codec type: AAC.
  ///  Supported video codec type: H264 (AVC).
  ///
  /// Param [config] The configuration information for the added video stream: LiveInjectStreamConfig .
  ///
  Future<void> addInjectStreamUrl(String url, LiveInjectStreamConfig config);

  ///
  /// Removes the voice or video stream URL address from the live streaming.
  /// Agora will soon stop the service for injecting online media streams on the client. If you have not implemented this service, Agora recommends that you do not use it.
  ///  After a successful method, the SDK triggers the userOffline callback
  ///  with the uid of 666.
  ///
  /// Param [url] The URL address of the injected stream to be removed.
  ///
  Future<void> removeInjectStreamUrl(String url);

  ///
  /// Creates a data stream.
  /// Call this method after joining a channel.
  ///  Agora does not support setting reliable as true and ordered as true. Each user can create up to five data streams during the lifecycle of RtcEngine . Deprecated:
  ///  Please use createDataStreamWithConfig instead.
  ///
  /// Param [ordered] Whether or not the recipients receive the data stream in the sent order:
  ///  true: The recipients receive the data in the sent order.
  ///  false: The recipients do not receive the data in the sent order.
  ///
  ///
  /// Param [reliable] Whether or not the data stream is reliable:
  ///  true: The recipients receive the
  ///  data from the sender within five seconds. If the recipient does not
  ///  receive the data within five seconds, the SDK triggers the streamMessageError callback and returns an
  ///  error code.
  ///  false: There is no guarantee that
  ///  the recipients receive the data stream within five seconds and no
  ///  error message is reported for any delay or missing data stream.
  ///
  /// **return** ID of the created data stream, if the method call succeeds.
  ///  < 0: Failure. You can refer to Error Codes and Warning Codes for troubleshooting.
  ///
  @Deprecated('Please use createDataStreamWithConfig instead.')
  Future<int?> createDataStream(bool reliable, bool ordered);

  ///
  /// Creates a data stream.
  /// Compared with createDataStream [1/2], this method does not support data reliability. If a data packet is not received five seconds after it was sent, the SDK directly discards the data.
  ///  Creates a data stream. Each user can create up to five data streams in a single channel.
  ///
  /// Param [config] The configurations for the data stream.
  ///
  /// **return** ID of the created data stream, if the method call succeeds.
  ///  < 0: Failure. You can refer to Error Codes and Warning Codes for troubleshooting.
  ///
  Future<int?> createDataStreamWithConfig(DataStreamConfig config);

  ///
  /// Sends data stream messages.
  /// Sends data stream messages to all users in a channel. The SDK has the following restrictions on this method:Up to 30 packets can be sent per second in a channel with each packet having a maximum size of 1 KB.Each client can send up to 6 KB of data per second.Each user can have up to five data streams simultaneously.
  ///  A successful method call triggers the streamMessage callback on the remote client, from which the remote user gets the stream message. A failed method call triggers the streamMessageError callback on the remote client. Ensure that you call createDataStreamWithConfig to create a data channel before calling this method.
  ///  In live streaming scenarios, this method only applies to hosts.
  ///
  /// Param [streamId] The data stream ID. You can get the data stream ID by calling createDataStreamWithConfig.
  ///
  /// Param [message] The message to be sent.
  ///
  Future<void> sendStreamMessage(int streamId, Uint8List message);

  /// @nodoc
  Future<void> setAVSyncSource(String channelId, int uid);

  ///
  /// Starts pushing media streams to a CDN without transcoding.
  /// Ensure that you enable the RTMP Converter service before using this function. See Prerequisites in Push Streams to CDN.
  ///  Call this method after joining a channel.
  ///  Only hosts in the LIVE_BROADCASTING profile can call this method.
  ///  If you want to retry pushing streams after a failed push, make sure to call stopRtmpStream first, then call this method to retry pushing streams; otherwise, the SDK returns the same error code as the last failed push. This method can push media streams to only one CDN address at a time, so if you need to push streams to multiple addresses, call this method multiple times. This method can push media streams to only one CDN address at a time, so if you need to push streams to multiple addresses, call this method multiple times.
  ///  After you call this method, the SDK triggers the rtmpStreamingStateChanged callback on the local client to report the state of the streaming.
  ///
  /// Param [url] The address of the CDN live streaming. The format is RTMP or RTMPS. The character length cannot exceed 1024 bytes. Special characters such as Chinese characters are not supported.
  ///
  Future<void> startRtmpStreamWithoutTranscoding(String url);

  ///
  /// Starts pushing media streams to a CDN and sets the transcoding configuration.
  /// Ensure that you enable the RTMP Converter service before using this function. See Prerequisites in Push Streams to CDN.
  ///  Call this method after joining a channel.
  ///  Only hosts in the LIVE_BROADCASTING profile can call this method.
  ///  If you want to retry pushing streams after a failed push, make sure to call stopRtmpStream first, then call this method to retry pushing streams; otherwise, the SDK returns the same error code as the last failed push.
  ///  You can call this method to push a live audio-and-video stream to the specified CDN address and set the transcoding configuration. This method can push media streams to only one CDN address at a time, so if you need to push streams to multiple addresses, call this method multiple times.
  ///  After you call this method, the SDK triggers the rtmpStreamingStateChanged callback on the local client to report the state of the streaming.
  ///
  /// Param [transcoding] Transcoding configurations for CDN live streaming. See LiveTranscoding .
  ///
  /// Param [url] CDN streaming address. The format is RTMP or RTMPS. The character length cannot exceed 1024 bytes. Special characters such as Chinese characters are not supported.
  ///
  Future<void> startRtmpStreamWithTranscoding(LiveTranscoding transcoding);

  ///
  /// Updates the transcoding configuration.
  /// After you start pushing media streams to CDN with transcoding, you can dynamically update the transcoding configuration according to the scenario. The SDK triggers the transcodingUpdated callback after the transcoding configuration is updated.
  ///
  /// Param [transcoding] The transcoding configuration for CDN live streaming. See LiveTranscoding .
  ///
  Future<void> updateRtmpTranscoding(LiveTranscoding transcoding);

  ///
  /// Stops pushing media streams to a CDN.
  /// You can call this method to stop the live stream on the specified CDN address. This method can stop pushing media streams to only one CDN address at a time, so if you need to stop pushing streams to multiple addresses, call this method multiple times.
  ///  After you call this method, the SDK triggers the rtmpStreamingStateChanged callback on the local client to report the state of the streaming.
  ///
  /// Param [url] CDN streaming address. The format is RTMP or RTMPS. The character length cannot exceed 1024 bytes. Special characters such as Chinese characters are not supported.
  ///
  Future<void> stopRtmpStream(String url);
}
