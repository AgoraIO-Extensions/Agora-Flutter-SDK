import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_rtc_engine_ex.g.dart';

/// Contains connection information.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RtcConnection {
  /// @nodoc
  const RtcConnection({this.channelId, this.localUid});

  /// The channel name.
  @JsonKey(name: 'channelId')
  final String? channelId;

  /// The ID of the local user.
  @JsonKey(name: 'localUid')
  final int? localUid;

  /// @nodoc
  factory RtcConnection.fromJson(Map<String, dynamic> json) =>
      _$RtcConnectionFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RtcConnectionToJson(this);
}

/// This interface class contains multi-channel methods.
/// Inherited from RtcEngine .
abstract class RtcEngineEx implements RtcEngine {
  /// Joins a channel with the connection ID.
  /// You can call this method multiple times to join more than one channel.If you are already in a channel, you cannot rejoin it with the same user ID.If you want to join the same channel from different devices, ensure that the user IDs are different for all devices.Ensure that the app ID you use to generate the token is the same as RtcEngine the app ID used when creating the instance.
  ///
  /// * [options] The channel media options. See ChannelMediaOptions .
  /// * [token] The token generated on your server for authentication.
  /// * [connection] The connection information. See RtcConnection .
  Future<void> joinChannelEx(
      {required String token,
      required RtcConnection connection,
      required ChannelMediaOptions options});

  /// Leaves a channel.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [options] The options for leaving the channel. See LeaveChannelOptions .This parameter only supports the stopMicrophoneRecording member in the LeaveChannelOptions settings; setting other members does not take effect.
  Future<void> leaveChannelEx(
      {required RtcConnection connection, LeaveChannelOptions? options});

  /// Updates the channel media options after joining the channel.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [options] The channel media options. See ChannelMediaOptions .
  Future<void> updateChannelMediaOptionsEx(
      {required ChannelMediaOptions options,
      required RtcConnection connection});

  /// Sets the encoder configuration for the local video.
  /// Each configuration profile corresponds to a set of video parameters, including the resolution, frame rate, and bitrate.The config specified in this method is the maximum values under ideal network conditions. If the network condition is not good, the video engine cannot use the config renders local video, which automatically reduces to an appropriate video parameter setting.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [config] Video profile. See VideoEncoderConfiguration .
  ///
  Future<void> setVideoEncoderConfigurationEx(
      {required VideoEncoderConfiguration config,
      required RtcConnection connection});

  /// Initializes the video view of a remote user.
  /// This method initializes the video view of a remote stream on the local device. It affects only the video view that the local user sees. Call this method to bind the remote video stream to a video view and to set the rendering and mirror modes of the video view.The application specifies the uid of the remote video in the VideoCanvas method before the remote user joins the channel.If the remote uid is unknown to the application, set it after the application receives the onUserJoined callback. If the Video Recording function is enabled, the Video Recording Service joins the channel as a dummy client, causing other clients to also receive the onUserJoined callback. Do not bind the dummy client to the application view because the dummy client does not send any video streams.To unbind the remote user from the view, set the view parameter to NULL.Once the remote user leaves the channel, the SDK unbinds the remote user.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [canvas] The remote video view settings. See VideoCanvas .
  Future<void> setupRemoteVideoEx(
      {required VideoCanvas canvas, required RtcConnection connection});

  /// Stops or resumes receiving the audio stream of a specified user.
  /// This method is used to stops or resumes receiving the audio stream of a specified user. You can call this method before or after joining a channel. If a user leaves a channel, the settings in this method become invalid.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [uid] The ID of the specified user.
  /// * [mute] Whether to stop receiving the audio stream of the specified user:true: Stop receiving the audio stream of the specified user.false: (Default) Resume receiving the audio stream of the specified user.
  ///
  Future<void> muteRemoteAudioStreamEx(
      {required int uid,
      required bool mute,
      required RtcConnection connection});

  /// Stops or resumes receiving the video stream of a specified user.
  /// This method is used to stops or resumes receiving the video stream of a specified user. You can call this method before or after joining a channel. If a user leaves a channel, the settings in this method become invalid.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [uid] The user ID of the remote user.
  /// * [mute] Whether to stop receiving the video stream of the specified user:true: Stop receiving the video stream of the specified user.false: (Default) Resume receiving the video stream of the specified user.
  ///
  Future<void> muteRemoteVideoStreamEx(
      {required int uid,
      required bool mute,
      required RtcConnection connection});

  /// Sets the stream type of the remote video.
  /// Under limited network conditions, if the publisher has not disabled the dual-stream mode using enableDualStreamModeEx (false), the receiver can choose to receive either the high-quality video stream or the low-quality video stream. The high-quality video stream has a higher resolution and bitrate, and the low-quality video stream has a lower resolution and bitrate.
  /// By default, users receive the high-quality video stream. Call this method if you want to switch to the low-quality video stream. This method allows the app to adjust the corresponding video stream type based on the size of the video window to reduce the bandwidth and resources. The aspect ratio of the low-quality video stream is the same as the high-quality video stream. Once the resolution of the high-quality video stream is set, the system automatically sets the resolution, frame rate, and bitrate of the low-quality video stream.
  /// The SDK enables the low-quality video stream auto mode on the sender by default (not actively sending low-quality video streams). The host at the receiving end can call this method to initiate a low-quality video stream stream request on the receiving end, and the sender automatically switches to the low-quality video stream mode after receiving the request.
  /// The result of this method returns in the onApiCallExecuted callback.
  ///
  /// * [uid] The user ID.
  /// * [streamType] The video stream type. See VideoStreamType.
  /// * [connection] The connection information. See RtcConnection .
  ///
  Future<void> setRemoteVideoStreamTypeEx(
      {required int uid,
      required VideoStreamType streamType,
      required RtcConnection connection});

  /// Stops or resumes publishing the local audio stream.
  /// This method does not affect any ongoing audio recording, because it does not disable the audio capture device.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [mute] Whether to stop publishing the local audio stream:true: Stops publishing the local audio stream.false: (Default) Resumes publishing the local audio stream.
  Future<void> muteLocalAudioStreamEx(
      {required bool mute, required RtcConnection connection});

  /// Stops or resumes publishing the local video stream.
  /// A successful call of this method triggers the onUserMuteVideo callback on the remote client.This method does not affect any ongoing video recording, because it does not disable the camera.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [mute] Whether to stop publishing the local video stream.true: Stop publishing the local video stream.false: (Default) Publish the local video stream.
  ///
  Future<void> muteLocalVideoStreamEx(
      {required bool mute, required RtcConnection connection});

  /// Stops or resumes subscribing to the audio streams of all remote users.
  /// After successfully calling this method, the local user stops or resumes subscribing to the audio streams of all remote users, including the ones who join the channel subsequent to this call.Call this method after joining a channel.If you do not want to subscribe the audio streams of remote users before joining a channel, you can set autoSubscribeAudio as false when calling joinChannel [2/2] .
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [mute] Whether to stop subscribing to the audio streams of all remote users:true: Stops subscribing to the audio streams of all remote users.false: (Default) Subscribes to the audio streams of all remote users.
  Future<void> muteAllRemoteAudioStreamsEx(
      {required bool mute, required RtcConnection connection});

  /// Stops or resumes subscribing to the video streams of all remote users.
  /// After successfully calling this method, the local user stops or resumes subscribing to the audio streams of all remote users, including all subsequent users.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [mute] Whether to stop subscribing to the video streams of all remote users.
  ///  true: Stop subscribing to the video streams of all remote users.
  ///  false: (Default) Subscribe to the audio streams of all remote users by default.
  ///
  Future<void> muteAllRemoteVideoStreamsEx(
      {required bool mute, required RtcConnection connection});

  /// Set the blocklist of subscriptions for audio streams.
  /// You can call this method to specify the audio streams of a user that you do not want to subscribe to. You can call this method either before or after joining a channel.
  ///  The blocklist is not affected by the setting in muteRemoteAudioStream , muteAllRemoteAudioStreams , and autoSubscribeAudio in ChannelMediaOptions .
  ///  Once the blocklist of subscriptions is set, it is effective even if you leave the current channel and rejoin the channel.
  ///  If a user is added in the allowlist and blocklist at the same time, only the blocklist takes effect.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [uidNumber] The number of users in the user ID list.
  /// * [uidList] The user ID list of users that you do not want to subscribe to.
  ///  If you want to specify the audio streams of a user that you do not want to subscribe to, add the user ID in this list. If you want to remove a user from the blocklist, you need to call the setSubscribeAudioBlocklist method to update the user ID list; this means you only add the uid of users that you do not want to subscribe to in the new user ID list.
  ///
  Future<void> setSubscribeAudioBlocklistEx(
      {required List<int> uidList,
      required int uidNumber,
      required RtcConnection connection});

  /// Sets the allowlist of subscriptions for audio streams.
  /// You can call this method to specify the audio streams of a user that you want to subscribe to. If a user is added in the allowlist and blocklist at the same time, only the blocklist takes effect.You can call this method either before or after joining a channel.The allowlist is not affected by the setting in muteRemoteAudioStream , muteAllRemoteAudioStreams and autoSubscribeAudio in ChannelMediaOptions .
  ///  Once the allowlist of subscriptions is set, it is effective even if you leave the current channel and rejoin the channel.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [uidNumber] The number of users in the user ID list.
  /// * [uidList] The user ID list of users that you want to subscribe to.
  ///  If you want to specify the audio streams of a user for subscription, add the user ID in this list. If you want to remove a user from the allowlist, you need to call the setSubscribeAudioAllowlist method to update the user ID list; this means you only add the uid of users that you want to subscribe to in the new user ID list.
  ///
  Future<void> setSubscribeAudioAllowlistEx(
      {required List<int> uidList,
      required int uidNumber,
      required RtcConnection connection});

  /// Set the blocklist of subscriptions for video streams.
  /// You can call this method to specify the video streams of a user that you do not want to subscribe to. If a user is added in the allowlist and blocklist at the same time, only the blocklist takes effect.
  ///  Once the blocklist of subscriptions is set, it is effective even if you leave the current channel and rejoin the channel.
  ///  You can call this method either before or after joining a channel.
  ///  The blocklist is not affected by the setting in muteRemoteVideoStream , muteAllRemoteVideoStreams and autoSubscribeAudio in ChannelMediaOptions .
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [uidNumber] The number of users in the user ID list.
  /// * [uidList] The user ID list of users that you do not want to subscribe to.
  ///  If you want to specify the video streams of a user that you do not want to subscribe to, add the user ID of that user in this list. If you want to remove a user from the blocklist, you need to call the setSubscribeVideoBlocklist method to update the user ID list; this means you only add the uid of users that you do not want to subscribe to in the new user ID list.
  ///
  Future<void> setSubscribeVideoBlocklistEx(
      {required List<int> uidList,
      required int uidNumber,
      required RtcConnection connection});

  /// Set the allowlist of subscriptions for video streams.
  /// You can call this method to specify the video streams of a user that you want to subscribe to.If a user is added in the allowlist and blocklist at the same time, only the blocklist takes effect.
  ///  Once the allowlist of subscriptions is set, it is effective even if you leave the current channel and rejoin the channel.
  ///  You can call this method either before or after joining a channel.
  ///  The allowlist is not affected by the setting in muteRemoteVideoStream , muteAllRemoteVideoStreams and autoSubscribeAudio in ChannelMediaOptions .
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [uidNumber] The number of users in the user ID list.
  /// * [uidList] The user ID list of users that you want to subscribe to.If you want to specify the video streams of a user for subscription, add the user ID of that user in this list. If you want to remove a user from the allowlist, you need to call the setSubscribeVideoAllowlist method to update the user ID list; this means you only add the uid of users that you want to subscribe to in the new user ID list.
  Future<void> setSubscribeVideoAllowlistEx(
      {required List<int> uidList,
      required int uidNumber,
      required RtcConnection connection});

  /// Options for subscribing to remote video streams.
  /// When a remote user has enabled dual-stream mode, you can call this method to choose the option for subscribing to the video streams sent by the remote user.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [options] The video subscription options. See VideoSubscriptionOptions .
  /// * [uid] The user ID of the remote user.
  Future<void> setRemoteVideoSubscriptionOptionsEx(
      {required int uid,
      required VideoSubscriptionOptions options,
      required RtcConnection connection});

  /// Sets the 2D position (the position on the horizontal plane) of the remote user's voice.
  /// This method sets the voice position and volume of a remote user.When the local user calls this method to set the voice position of a remote user, the voice difference between the left and right channels allows the local user to track the real-time position of the remote user, creating a sense of space. This method applies to massive multiplayer online games, such as Battle Royale games.For the best voice positioning, Agora recommends using a wired headset.Call this method after joining a channel.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [uid] The user ID of the remote user.
  /// * [pan] The voice position of the remote user. The value ranges from -1.0 to 1.0:-1.0: The remote voice comes from the left.0.0: (Default) The remote voice comes from the front.1.0: The remote voice comes from the right.
  /// * [gain] The volume of the remote user. The value ranges from 0.0 to 100.0. The default value is 100.0 (the original volume of the remote user). The smaller the value, the lower the volume.
  ///
  Future<void> setRemoteVoicePositionEx(
      {required int uid,
      required double pan,
      required double gain,
      required RtcConnection connection});

  /// @nodoc
  Future<void> setRemoteUserSpatialAudioParamsEx(
      {required int uid,
      required SpatialAudioParams params,
      required RtcConnection connection});

  /// @nodoc
  Future<void> setRemoteRenderModeEx(
      {required int uid,
      required RenderModeType renderMode,
      required VideoMirrorModeType mirrorMode,
      required RtcConnection connection});

  /// Enables loopback audio capture.
  /// If you enable loopback audio capture, the output of the sound card is mixed into the audio stream sent to the other end.macOS does not support loopback audio capture of the default sound card. If you need to use this method, use a virtual sound card and pass its name to the deviceName parameter. Agora recommends that you use Soundflower for loopback audio capture.You can call this method either before or after joining a channel.
  ///
  /// * [deviceName] macOS: The device name of the virtual sound card. The default is set to null, which means the SDK uses Soundflower for loopback audio capture.Windows: The device name of the sound card. The default is set to null, which means the SDK uses the sound card of your device for loopback audio capture.
  /// * [connection] The connection information. See RtcConnection .
  /// * [enabled] Sets whether to enable loopback audio capture:
  ///  true: Enable loopback audio capture.false: (Default) Disable loopback audio capture.
  ///
  Future<void> enableLoopbackRecordingEx(
      {required RtcConnection connection,
      required bool enabled,
      String? deviceName});

  /// Adjusts the playback signal volume of a specified remote user.
  /// You can call this method to adjust the playback volume of a specified remote user. To adjust the playback volume of different remote users, call the method as many times, once for each remote user.Call this method after joining a channel.The playback volume here refers to the mixed volume of a specified remote user.
  ///
  /// * [volume] Audio mixing volume. The value ranges between 0 and 100. The default value is 100, which means the original volume.
  /// * [connection] The connection information. See RtcConnection .
  /// * [uid] The user ID of the remote user.
  Future<void> adjustUserPlaybackSignalVolumeEx(
      {required int uid,
      required int volume,
      required RtcConnection connection});

  /// Gets the current connection state of the SDK.
  /// You can call this method either before or after joining a channel.
  ///
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// The current connection state.
  Future<ConnectionStateType> getConnectionStateEx(RtcConnection connection);

  /// @nodoc
  Future<void> enableEncryptionEx(
      {required RtcConnection connection,
      required bool enabled,
      required EncryptionConfig config});

  /// Creates a data stream.
  /// Creates a data stream. Each user can create up to five data streams in a single channel.Compared with createDataStreamEx , this method does not support data reliability. If a data packet is not received five seconds after it was sent, the SDK directly discards the data.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [config] The configurations for the data stream. See DataStreamConfig .
  ///
  /// Returns
  /// < 0: Failure.
  Future<int> createDataStreamEx(
      {required DataStreamConfig config, required RtcConnection connection});

  /// Sends data stream messages.
  /// After calling createDataStreamEx , you can call this method to send data stream messages to all users in the channel.The SDK has the following restrictions on this method:Up to 30 packets can be sent per second in a channel with each packet having a maximum size of 1 kB.Each client can send up to 6 KB of data per second.Each user can have up to five data streams simultaneously.A successful method call triggers the onStreamMessage callback on the remote client, from which the remote user gets the stream message.
  /// A failed method call triggers the onStreamMessageError callback on the remote client.Ensure that you call createDataStreamEx to create a data channel before calling this method.This method applies only to the COMMUNICATION profile or to the hosts in the LIVE_BROADCASTING profile. If an audience in the LIVE_BROADCASTING profile calls this method, the audience may be switched to a host.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [streamId] The data stream ID. You can get the data stream ID by calling createDataStreamEx.
  /// * [data] The data to be sent.
  /// * [length] The length of the data.
  ///
  Future<void> sendStreamMessageEx(
      {required int streamId,
      required Uint8List data,
      required int length,
      required RtcConnection connection});

  /// Adds a watermark image to the local video.
  /// This method adds a PNG watermark image to the local video in the live streaming. Once the watermark image is added, all the audience in the channel (CDN audience included), and the capturing device can see and capture it. Agora supports adding only one watermark image onto the local video, and the newly watermark image replaces the previous one.The watermark coordinatesare dependent on the settings in the setVideoEncoderConfigurationEx method:If the orientation mode of the encoding video ( OrientationMode ) is fixed landscape mode or the adaptive landscape mode, the watermark uses the landscape orientation.If the orientation mode of the encoding video (OrientationMode) is fixed portrait mode or the adaptive portrait mode, the watermark uses the portrait orientation.When setting the watermark position, the region must be less than the setVideoEncoderConfigurationEx dimensions set in the method; otherwise, the watermark image will be cropped.Ensure that you have called enableVideo before calling this method.This method supports adding a watermark image in the PNG file format only. Supported pixel formats of the PNG image are RGBA, RGB, Palette, Gray, and Alpha_gray.If the dimensions of the PNG image differ from your settings in this method, the image will be cropped or zoomed to conform to your settings.If you have enabled the local video preview by calling the startPreview method, you can use the visibleInPreview member to set whether or not the watermark is visible in the preview.If you have enabled the mirror mode for the local video, the watermark on the local video is also mirrored. To avoid mirroring the watermark, Agora recommends that you do not use the mirror and watermark functions for the local video at the same time. You can implement the watermark function in your application layer.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [options] The options of the watermark image to be added.
  /// * [watermarkUrl] The local file path of the watermark image to be added. This method supports adding a watermark image from the local absolute or relative file path.
  ///
  Future<void> addVideoWatermarkEx(
      {required String watermarkUrl,
      required WatermarkOptions options,
      required RtcConnection connection});

  /// Removes the watermark image from the video stream.
  ///
  /// * [connection] The connection information. See RtcConnection .
  Future<void> clearVideoWatermarkEx(RtcConnection connection);

  /// Agora supports reporting and analyzing customized messages.
  /// Agora supports reporting and analyzing customized messages. This function is in the beta stage with a free trial. The ability provided in its beta test version is reporting a maximum of 10 message pieces within 6 seconds, with each message piece not exceeding 256 bytes and each string not exceeding 100 bytes. To try out this function, contact and discuss the format of customized messages with us.
  Future<void> sendCustomReportMessageEx(
      {required String id,
      required String category,
      required String event,
      required String label,
      required int value,
      required RtcConnection connection});

  /// Enables the reporting of users' volume indication.
  /// This method enables the SDK to regularly report the volume information to the app of the local user who sends a stream and remote users (three users at most) whose instantaneous volumes are the highest. Once you call this method and users send streams in the channel, the SDK triggers the onAudioVolumeIndication callback at the time interval set in this method.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [reportVad] true: Enable the voice activity detection of the local user. Once it is enabled,the vad parameter of the onAudioVolumeIndication callback reports the voice activity status of the local user.
  ///  false: (Default) Disable the voice activity detection of the local user. Once it is disabled, the vad parameter of the onAudioVolumeIndication callback does not report the voice activity status of the local user, except for the scenario where the engine automatically detects the voice activity of the local user.
  ///
  /// * [smooth] The smoothing factor sets the sensitivity of the audio volume indicator. The value ranges between 0 and 10. The recommended value is 3. The greater the value, the more sensitive the indicator.
  /// * [interval] Sets the time interval between two consecutive volume indications:
  ///  ≤ 0: Disables the volume indication.
  ///  > 0: Time interval (ms) between two consecutive volume indications. You need to set this parameter to an integer multiple of 200. If the value is lower than 200, the SDK automatically adjusts the value to 200.
  ///
  Future<void> enableAudioVolumeIndicationEx(
      {required int interval,
      required int smooth,
      required bool reportVad,
      required RtcConnection connection});

  /// Starts pushing media streams to a CDN without transcoding.
  /// Ensure that you enable the media push service before using this function.
  ///  Call this method after joining a channel.
  ///  Only hosts in the LIVE_BROADCASTING profile can call this method.
  ///  If you want to retry pushing streams after a failed push, make sure to call stopRtmpStream first, then call this method to retry pushing streams; otherwise, the SDK returns the same error code as the last failed push.
  ///  You can call this method to push an audio or video stream to the specified CDN address. This method can push media streams to only one CDN address at a time, so if you need to push streams to multiple addresses, call this method multiple times.After you call this method, the SDK triggers the onRtmpStreamingStateChanged callback on the local client to report the state of the streaming.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [url] The address of media push. The format is RTMP or RTMPS. The character length cannot exceed 1024 bytes. Special characters such as Chinese characters are not supported.
  Future<void> startRtmpStreamWithoutTranscodingEx(
      {required String url, required RtcConnection connection});

  /// Starts Media Push and sets the transcoding configuration.
  /// You can call this method to push a live audio-and-video stream to the specified CDN address and set the transcoding configuration. This method can push media streams to only one CDN address at a time, so if you need to push streams to multiple addresses, call this method multiple times.After you call this method, the SDK triggers the onRtmpStreamingStateChanged callback on the local client to report the state of the streaming.Ensure that you enable the Media Push service before using this function. Call this method after joining a channel.Only hosts in the LIVE_BROADCASTING profile can call this method.If you want to retry pushing streams after a failed push, make sure to call stopRtmpStreamEx first, then call this method to retry pushing streams; otherwise, the SDK returns the same error code as the last failed push.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [transcoding] The transcoding configuration for media push. See LiveTranscoding .
  /// * [url] The address of media push. The format is RTMP or RTMPS. The character length cannot exceed 1024 bytes. Special characters such as Chinese characters are not supported.
  Future<void> startRtmpStreamWithTranscodingEx(
      {required String url,
      required LiveTranscoding transcoding,
      required RtcConnection connection});

  /// Updates the transcoding configuration.
  /// After you start pushing media streams to CDN with transcoding, you can dynamically update the transcoding configuration according to the scenario. The SDK triggers the onTranscodingUpdated callback after the transcoding configuration is updated.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [transcoding] The transcoding configuration for media push. See LiveTranscoding .
  ///
  Future<void> updateRtmpTranscodingEx(
      {required LiveTranscoding transcoding,
      required RtcConnection connection});

  /// Stops pushing media streams to a CDN.
  /// You can call this method to stop the live stream on the specified CDN address. This method can stop pushing media streams to only one CDN address at a time, so if you need to stop pushing streams to multiple addresses, call this method multiple times.After you call this method, the SDK triggers the onRtmpStreamingStateChanged callback on the local client to report the state of the streaming.
  ///
  /// * [url] The address of media push. The format is RTMP or RTMPS. The character length cannot exceed 1024 bytes. Special characters such as Chinese characters are not supported.
  Future<void> stopRtmpStreamEx(
      {required String url, required RtcConnection connection});

  /// Starts relaying media streams across channels. This method can be used to implement scenarios such as co-host across channels.
  /// After a successful method call, the SDK triggers the onChannelMediaRelayStateChanged and onChannelMediaRelayEvent callbacks, and these callbacks return the state and events of the media stream relay.If the onChannelMediaRelayStateChanged callback returns relayStateRunning (2) and relayOk (0), and the onChannelMediaRelayEvent callback returns relayEventPacketSentToDestChannel (4), it means that the SDK starts relaying media streams between the source channel and the destination channel.If the onChannelMediaRelayStateChanged callback returnsrelayStateFailure (3), an exception occurs during the media stream relay.Call this method after joining the channel.This method takes effect only when you are a host in a live streaming channel.After a successful method call, if you want to call this method again, ensure that you call the stopChannelMediaRelayEx method to quit the current relay.The relaying media streams across channels function needs to be enabled.We do not support string user accounts in this API.
  ///
  /// * [configuration] The configuration of the media stream relay. See ChannelMediaRelayConfiguration .
  /// * [connection] The connection information. See RtcConnection .
  Future<void> startChannelMediaRelayEx(
      {required ChannelMediaRelayConfiguration configuration,
      required RtcConnection connection});

  /// Updates the channels for media stream relay.
  /// After the media relay starts, if you want to relay the media stream to more channels, or leave the current relay channel, you can call the updateChannelMediaRelay method.After a successful method call, the SDK triggers the onChannelMediaRelayEvent callback with the relayEventPacketUpdateDestChannel (7) state code.Call the method after successfully calling the startChannelMediaRelayEx method and receiving onChannelMediaRelayStateChanged (relayStateRunning, relayOk); otherwise, the method call fails.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [configuration] The configuration of the media stream relay. See ChannelMediaRelayConfiguration .
  Future<void> updateChannelMediaRelayEx(
      {required ChannelMediaRelayConfiguration configuration,
      required RtcConnection connection});

  /// Stops the media stream relay. Once the relay stops, the host quits all the destination channels.
  /// After a successful method call, the SDK triggers the onChannelMediaRelayStateChanged callback. If the callback reports relayStateIdle (0) and relayOk (0), the host successfully stops the relay.If the method call fails, the SDK triggers the onChannelMediaRelayStateChanged callback with the relayErrorServerNoResponse (2) or relayErrorServerConnectionLost (8) status code. You can call the leaveChannel method to leave the channel, and the media stream relay automatically stops.
  ///
  /// * [connection] The connection information. See RtcConnection .
  Future<void> stopChannelMediaRelayEx(RtcConnection connection);

  /// Pauses the media stream relay to all destination channels.
  /// After the cross-channel media stream relay starts, you can call this method to pause relaying media streams to all destination channels; after the pause, if you want to resume the relay, call resumeAllChannelMediaRelay .After a successful method call, the SDK triggers the onChannelMediaRelayEvent callback to report whether the media stream relay is successfully paused.Call this method after startChannelMediaRelayEx .
  ///
  /// * [connection] The connection information. See RtcConnection .
  Future<void> pauseAllChannelMediaRelayEx(RtcConnection connection);

  /// Resumes the media stream relay to all destination channels.
  /// After calling the pauseAllChannelMediaRelayEx method, you can call this method to resume relaying media streams to all destination channels.After a successful method call, the SDK triggers the onChannelMediaRelayEvent callback to report whether the media stream relay is successfully resumed.Call this method after pauseAllChannelMediaRelayEx .
  ///
  /// * [connection] The connection information. See RtcConnection .
  Future<void> resumeAllChannelMediaRelayEx(RtcConnection connection);

  /// @nodoc
  Future<UserInfo> getUserInfoByUserAccountEx(
      {required String userAccount, required RtcConnection connection});

  /// @nodoc
  Future<UserInfo> getUserInfoByUidEx(
      {required int uid, required RtcConnection connection});

  /// @nodoc
  Future<void> setVideoProfileEx(
      {required int width,
      required int height,
      required int frameRate,
      required int bitrate});

  /// Enables or disables dual-stream mode on the sender side.
  /// This method is applicable to all types of streams from the sender, including but not limited to video streams collected from cameras, screen sharing streams, and custom-collected video streams.If you need to enable dual video streams in a multi-channel scenario, you can call the enableDualStreamModeEx method.You can call this method either before or after joining a channel.After you enable dual-stream mode, you can call setRemoteVideoStreamType to choose to receive either the high-quality video stream or the low-quality video stream on the subscriber side.You can call this method to enable or disable the dual-stream mode on the publisher side. Dual streams are a pairing of a high-quality video stream and a low-quality video stream:High-quality video stream: High bitrate, high resolution.Low-quality video stream: Low bitrate, low resolution.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [streamConfig] The configuration of the low-quality video stream. See SimulcastStreamConfig .
  ///
  /// * [enabled] Whether to enable dual-stream mode:
  ///  true: Enable dual-stream mode.
  ///  false: (Default) Disable dual-stream mode.
  Future<void> enableDualStreamModeEx(
      {required bool enabled,
      required SimulcastStreamConfig streamConfig,
      required RtcConnection connection});

  /// Sets dual-stream mode on the sender side.
  /// The SDK enables the low-quality video stream auto mode on the sender by default, which is equivalent to calling this method and setting the mode to autoSimulcastStream. If you want to modify this behavior, you can call this method and modify the mode to disableSimulcastStream(never sends low-quality video streams) or enableSimulcastStream(sends low-quality video streams).The difference and between this method and enableDualStreamModeEx is as follows:When calling this method and setting mode to disableSimulcastStream, it has the same effect as enableDualStreamModeEx(false).When calling this method and setting mode to enableSimulcastStream, it has the same effect as enableDualStreamModeEx(true).Both methods can be called before and after joining a channel. If they are used at the same time, the settings in the method called later shall prevail.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [streamConfig] The configuration of the low-quality video stream. See SimulcastStreamConfig .
  ///
  /// * [mode] The mode in which the video stream is sent. See SimulcastStreamMode .
  Future<void> setDualStreamModeEx(
      {required SimulcastStreamMode mode,
      required SimulcastStreamConfig streamConfig,
      required RtcConnection connection});

  @override
  Future<void> enableWirelessAccelerate(bool enabled);

  /// Takes a snapshot of a video stream.
  /// The method is asynchronous, and the SDK has not taken the snapshot when the method call returns. After a successful method call, the SDK triggers the onSnapshotTaken callback to report whether the snapshot is successfully taken, as well as the details for that snapshot.This method takes a snapshot of a video stream from the specified user, generates a JPG image, and saves it to the specified path.Call this method after the joinChannelEx method.This method takes a snapshot of the published video stream specified in ChannelMediaOptions .If the user's video has been preprocessed, for example, watermarked or beautified, the resulting snapshot includes the pre-processing effect.
  ///
  /// * [filePath] The local path (including filename extensions) of the snapshot. For example:Windows: C:\Users\<user_name>\AppData\Local\Agora\<process_name>\example.jpgiOS: /App Sandbox/Library/Caches/example.jpgmacOS: ～/Library/Logs/example.jpgAndroid: /storage/emulated/0/Android/data/<package name>/files/example.jpgEnsure that the path you specify exists and is writable.
  /// * [uid] The user ID. Set uid as 0 if you want to take a snapshot of the local user's video.
  /// * [connection] The connection information. See RtcConnection .
  Future<void> takeSnapshotEx(
      {required RtcConnection connection,
      required int uid,
      required String filePath});
}
