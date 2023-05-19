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
  /// You can call this method multiple times to join more than one channel.If you are already in a channel, you cannot rejoin it with the same user ID.If you want to join the same channel from different devices, ensure that the user IDs are different for all devices.Ensure that the app ID you use to generate the token is the same as the app ID used when creating the RtcEngine instance.
  ///
  /// * [token] The token generated on your server for authentication.
  /// * [connection] The connection information. See RtcConnection .
  /// * [options] The channel media options. See ChannelMediaOptions .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly. < 0: Failure.
  ///  -2: The parameter is invalid. For example, the token is invalid, the uid parameter is not set to an integer, or the value of a member in ChannelMediaOptions is invalid. You need to pass in a valid parameter and join the channel again.
  ///  -3: Failes to initialize the RtcEngine object. You need to reinitialize the RtcEngine object.
  ///  -7: The RtcEngine object has not been initialized. You need to initialize the RtcEngine object before calling this method.
  ///  -8: The internal state of the RtcEngine object is wrong. The typical cause is that you call this method to join the channel without calling startEchoTest to stop the test after calling stopEchoTest to start a call loop test. You need to call stopEchoTest before calling this method.
  ///  -17: The request to join the channel is rejected. The typical cause is that the user is in the channel. Agora recommends that you use the onConnectionStateChanged callback to determine whether the user exists in the channel. Do not call this method to join the channel unless you receive the connectionStateDisconnected(1) state.
  ///  -102: The channel name is invalid. You need to pass in a valid channelname in channelId to rejoin the channel.
  ///  -121: The user ID is invalid. You need to pass in a valid user ID in uid to rejoin the channel.
  Future<void> joinChannelEx(
      {required String token,
      required RtcConnection connection,
      required ChannelMediaOptions options});

  /// Sets channel options and leaves the channel.
  /// This method lets the user leave the channel, for example, by hanging up or exiting the call.After calling joinChannelEx to join the channel, this method must be called to end the call before starting the next call.This method can be called whether or not a call is currently in progress. This method releases all resources related to the session.This method call is asynchronous. When this method returns, it does not necessarily mean that the user has left the channel. After you leave the channel, the SDK triggers the onLeaveChannel callback.After actually leaving the channel, the local user triggers the onLeaveChannel callback; after the user in the communication scenario and the host in the live streaming scenario leave the channel, the remote user triggers the onUserOffline callback.If you call release immediately after calling this method, the SDK does not trigger the onLeaveChannel callback.Calling leaveChannel will leave the channels when calling joinChannel and joinChannelEx at the same time.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [options] The options for leaving the channel. See LeaveChannelOptions .This parameter only supports the stopMicrophoneRecording member in the LeaveChannelOptions settings; setting other members does not take effect.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.< 0: Failure.
  Future<void> leaveChannelEx(
      {required RtcConnection connection, LeaveChannelOptions? options});

  /// Updates the channel media options after joining the channel.
  ///
  /// * [options] The channel media options. See ChannelMediaOptions .
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly. < 0: Failure.
  ///  -2: The value of a member in the ChannelMediaOptions structure is invalid. For example, the token or the user ID is invalid. You need to fill in a valid parameter.
  ///  -7: The RtcEngine object has not been initialized. You need to initialize the RtcEngine object before calling this method.
  ///  -8: The internal state of the RtcEngine object is wrong. The possible reason is that the user is not in the channel. Agora recommends that you use the onConnectionStateChanged callback to determine whether the user exists in the channel. If you receive the connectionStateDisconnected (1) or connectionStateFailed (5) state, the user is not in the channel. You need to call joinChannel to join a channel before calling this method.
  Future<void> updateChannelMediaOptionsEx(
      {required ChannelMediaOptions options,
      required RtcConnection connection});

  /// Sets the encoder configuration for the local video.
  /// Each configuration profile corresponds to a set of video parameters, including the resolution, frame rate, and bitrate.The config specified in this method is the maximum value under ideal network conditions. If the video engine cannot render the video using the specified config due to unreliable network conditions, the parameters further down the list are considered until a successful configuration is found.
  ///
  /// * [config] Video profile. See VideoEncoderConfiguration .
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.< 0: Failure.
  Future<void> setVideoEncoderConfigurationEx(
      {required VideoEncoderConfiguration config,
      required RtcConnection connection});

  /// Initializes the video view of a remote user.
  /// This method initializes the video view of a remote stream on the local device. It affects only the video view that the local user sees. Call this method to bind the remote video stream to a video view and to set the rendering and mirror modes of the video view.The application specifies the uid of the remote video in the VideoCanvas method before the remote user joins the channel.If the remote uid is unknown to the application, set it after the application receives the onUserJoined callback. If the Video Recording function is enabled, the Video Recording Service joins the channel as a dummy client, causing other clients to also receive the onUserJoined callback. Do not bind the dummy client to the application view because the dummy client does not send any video streams.To unbind the remote user from the view, set the view parameter to NULL.Once the remote user leaves the channel, the SDK unbinds the remote user.To update the rendering or mirror mode of the remote video view during a call, use the setRemoteRenderModeEx method.
  ///
  /// * [canvas] The remote video view settings. See VideoCanvas .
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.< 0: Failure.
  Future<void> setupRemoteVideoEx(
      {required VideoCanvas canvas, required RtcConnection connection});

  /// Stops or resumes receiving the audio stream of a specified user.
  ///
  /// * [uid] The ID of the specified user.
  /// * [mute] Whether to stop receiving the audio stream of the specified user:true: Stop receiving the audio stream of the specified user.false: (Default) Resume receiving the audio stream of the specified user.
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly. < 0: Failure.
  Future<void> muteRemoteAudioStreamEx(
      {required int uid,
      required bool mute,
      required RtcConnection connection});

  /// Stops or resumes receiving the video stream of a specified user.
  /// This method is used to stop or resume receiving the video stream of a specified user. You can call this method before or after joining a channel. If a user leaves a channel, the settings in this method become invalid.
  ///
  /// * [uid] The user ID of the remote user.
  /// * [mute] Whether to stop receiving the video stream of the specified user:true: Stop receiving the video stream of the specified user.false: (Default) Resume receiving the video stream of the specified user.
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.< 0: Failure.
  Future<void> muteRemoteVideoStreamEx(
      {required int uid,
      required bool mute,
      required RtcConnection connection});

  /// Sets the stream type of the remote video.
  /// Under limited network conditions, if the publisher has not disabled the dual-stream mode using enableDualStreamModeEx (false), the receiver can choose to receive either the high-quality video stream or the low-quality video stream. The high-quality video stream has a higher resolution and bitrate, and the low-quality video stream has a lower resolution and bitrate.By default, users receive the high-quality video stream. Call this method if you want to switch to the low-quality video stream. This method allows the app to adjust the corresponding video stream type based on the size of the video window to reduce the bandwidth and resources. The aspect ratio of the low-quality video stream is the same as the high-quality video stream. Once the resolution of the high-quality video stream is set, the system automatically sets the resolution, frame rate, and bitrate of the low-quality video stream.The SDK enables the low-quality video stream auto mode on the sender by default (not actively sending low-quality video streams). The host at the receiving end can call this method to initiate a low-quality video stream stream request on the receiving end, and the sender automatically switches to the low-quality video stream mode after receiving the request.
  ///
  /// * [uid] The user ID.
  /// * [streamType] The video stream type: VideoStreamType .
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.< 0: Failure.
  Future<void> setRemoteVideoStreamTypeEx(
      {required int uid,
      required VideoStreamType streamType,
      required RtcConnection connection});

  /// Stops or resumes publishing the local audio stream.
  /// This method does not affect any ongoing audio recording, because it does not disable the audio capture device.
  ///
  /// * [mute] Whether to stop publishing the local audio stream:true: Stops publishing the local audio stream.false: (Default) Resumes publishing the local audio stream.
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly. < 0: Failure.
  Future<void> muteLocalAudioStreamEx(
      {required bool mute, required RtcConnection connection});

  /// Stops or resumes publishing the local video stream.
  /// A successful call of this method triggers the onUserMuteVideo callback on the remote client.This method does not affect any ongoing video recording, because it does not disable the camera.
  ///
  /// * [mute] Whether to stop publishing the local video stream.true: Stop publishing the local video stream.false: (Default) Publish the local video stream.
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.< 0: Failure.
  Future<void> muteLocalVideoStreamEx(
      {required bool mute, required RtcConnection connection});

  /// Stops or resumes subscribing to the audio streams of all remote users.
  /// After successfully calling this method, the local user stops or resumes subscribing to the audio streams of all remote users, including the ones join the channel subsequent to this call.Call this method after joining a channel.If you do not want to subscribe the audio streams of remote users before joining a channel, you can set autoSubscribeAudio as false when calling joinChannel .
  ///
  /// * [mute] Whether to stop subscribing to the audio streams of all remote users:true: Stops subscribing to the audio streams of all remote users.false: (Default) Subscribes to the audio streams of all remote users by default.
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly. < 0: Failure.
  Future<void> muteAllRemoteAudioStreamsEx(
      {required bool mute, required RtcConnection connection});

  /// Stops or resumes subscribing to the video streams of all remote users.
  /// After successfully calling this method, the local user stops or resumes subscribing to the audio streams of all remote users, including all subsequent users.
  ///
  /// * [mute] Whether to stop subscribing to the video streams of all remote users.true: Stop subscribing to the video streams of all remote users.false: (Default) Subscribe to the audio streams of all remote users by default.
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.< 0: Failure.
  Future<void> muteAllRemoteVideoStreamsEx(
      {required bool mute, required RtcConnection connection});

  /// Set the blocklist of subscriptions for audio streams.
  /// You can call this method to specify the audio streams of a user that you do not want to subscribe to.You can call this method either before or after joining a channel.The blocklist is not affected by the setting in muteRemoteAudioStream , muteAllRemoteAudioStreams , and autoSubscribeAudio in ChannelMediaOptions .Once the blocklist of subscriptions is set, it is effective even if you leave the current channel and rejoin the channel.If a user is added in the allowlist and blocklist at the same time, only the blocklist takes effect.
  ///
  /// * [uidList] The user ID list of users that you do not want to subscribe to.If you want to specify the audio streams of a user that you do not want to subscribe to, add the user ID in this list. If you want to remove a user from the blocklist, you need to call the setSubscribeAudioBlocklist method to update the user ID list; this means you only add the uid of users that you do not want to subscribe to in the new user ID list.
  /// * [uidNumber] The number of users in the user ID list.
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.< 0: Failure.
  Future<void> setSubscribeAudioBlocklistEx(
      {required List<int> uidList,
      required int uidNumber,
      required RtcConnection connection});

  /// Sets the allowlist of subscriptions for audio streams.
  /// You can call this method to specify the audio streams of a user that you want to subscribe to.If a user is added in the allowlist and blocklist at the same time, only the blocklist takes effect.You can call this method either before or after joining a channel.The allowlist is not affected by the setting in muteRemoteAudioStream , muteAllRemoteAudioStreams and autoSubscribeAudio in ChannelMediaOptions .Once the allowlist of subscriptions is set, it is effective even if you leave the current channel and rejoin the channel.
  ///
  /// * [uidList] The user ID list of users that you want to subscribe to.If you want to specify the audio streams of a user for subscription, add the user ID in this list. If you want to remove a user from the allowlist, you need to call the setSubscribeAudioAllowlist method to update the user ID list; this means you only add the uid of users that you want to subscribe to in the new user ID list.
  /// * [uidNumber] The number of users in the user ID list.
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.< 0: Failure.
  Future<void> setSubscribeAudioAllowlistEx(
      {required List<int> uidList,
      required int uidNumber,
      required RtcConnection connection});

  /// Set the blocklist of subscriptions for video streams.
  /// You can call this method to specify the video streams of a user that you do not want to subscribe to.If a user is added in the allowlist and blocklist at the same time, only the blocklist takes effect.Once the blocklist of subscriptions is set, it is effective even if you leave the current channel and rejoin the channel.You can call this method either before or after joining a channel.The blocklist is not affected by the setting in muteRemoteVideoStream , muteAllRemoteVideoStreams and autoSubscribeAudio in ChannelMediaOptions .
  ///
  /// * [uidList] The user ID list of users that you do not want to subscribe to.If you want to specify the video streams of a user that you do not want to subscribe to, add the user ID of that user in this list. If you want to remove a user from the blocklist, you need to call the setSubscribeVideoBlocklist method to update the user ID list; this means you only add the uid of users that you do not want to subscribe to in the new user ID list.
  /// * [uidNumber] The number of users in the user ID list.
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.< 0: Failure.
  Future<void> setSubscribeVideoBlocklistEx(
      {required List<int> uidList,
      required int uidNumber,
      required RtcConnection connection});

  /// Set the allowlist of subscriptions for video streams.
  /// You can call this method to specify the video streams of a user that you want to subscribe to.If a user is added in the allowlist and blocklist at the same time, only the blocklist takes effect.Once the allowlist of subscriptions is set, it is effective even if you leave the current channel and rejoin the channel.You can call this method either before or after joining a channel.The allowlist is not affected by the setting in muteRemoteVideoStream , muteAllRemoteVideoStreams and autoSubscribeAudio in ChannelMediaOptions .
  ///
  /// * [uidList] The user ID list of users that you want to subscribe to.If you want to specify the video streams of a user for subscription, add the user ID of that user in this list. If you want to remove a user from the allowlist, you need to call the setSubscribeVideoAllowlist method to update the user ID list; this means you only add the uid of users that you want to subscribe to in the new user ID list.
  /// * [uidNumber] The number of users in the user ID list.
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.< 0: Failure.
  Future<void> setSubscribeVideoAllowlistEx(
      {required List<int> uidList,
      required int uidNumber,
      required RtcConnection connection});

  /// Options for subscribing to remote video streams.
  /// When a remote user has enabled dual-stream mode, you can call this method to choose the option for subscribing to the video streams sent by the remote user.
  ///
  /// * [uid] The user ID of the remote user.
  /// * [options] The video subscription options. See VideoSubscriptionOptions .
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly. < 0: Failure.
  Future<void> setRemoteVideoSubscriptionOptionsEx(
      {required int uid,
      required VideoSubscriptionOptions options,
      required RtcConnection connection});

  /// Sets the 2D position (the position on the horizontal plane) of the remote user's voice.
  /// This method sets the voice position and volume of a remote user.When the local user calls this method to set the voice position of a remote user, the voice difference between the left and right channels allows the local user to track the real-time position of the remote user, creating a sense of space. This method applies to massive multiplayer online games, such as Battle Royale games.For the best voice positioning, Agora recommends using a wired headset.Call this method after joining a channel.
  ///
  /// * [uid] The user ID of the remote user.
  /// * [pan] The voice position of the remote user. The value ranges from -1.0 to 1.0:-1.0: The remote voice comes from the left.0.0: (Default) The remote voice comes from the front.1.0: The remote voice comes from the right.
  /// * [gain] The volume of the remote user. The value ranges from 0.0 to 100.0. The default value is 100.0 (the original volume of the remote user). The smaller the value, the lower the volume.
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.< 0: Failure.
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

  /// Sets the video display mode of a specified remote user.
  /// After initializing the video view of a remote user, you can call this method to update its rendering and mirror modes. This method affects only the video view that the local user sees.Call this method after initializing the remote view by calling the setupRemoteVideo method.During a call, you can call this method as many times as necessary to update the display mode of the video view of a remote user.
  ///
  /// * [uid] The user ID of the remote user.
  /// * [renderMode] The video display mode of the remote user. See RenderModeType .
  /// * [mirrorMode] The mirror mode of the remote user view. See VideoMirrorModeType .
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.< 0: Failure.
  Future<void> setRemoteRenderModeEx(
      {required int uid,
      required RenderModeType renderMode,
      required VideoMirrorModeType mirrorMode,
      required RtcConnection connection});

  /// Enables loopback audio capturing.
  /// If you enable loopback audio capturing, the output of the sound card is mixed into the audio stream sent to the other end.This method applies to the macOS and Windows only.macOS does not support loopback audio capture of the default sound card. If you need to use this function, use a virtual sound card and pass its name to the deviceName parameter. Agora recommends using AgoraALD as the virtual sound card for audio capturing.This method only supports using one sound card for audio capturing.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [enabled] Sets whether to enable loopback audio capture:true: Enable loopback audio capturing.false: (Default) Disable loopback audio capturing.
  /// * [deviceName] macOS: The device name of the virtual sound card. The default value is set to NULL, which means using AgoraALD for loopback audio capturing.
  ///  Windows: The device name of the sound card. The default is set to NULL, which means the SDK uses the sound card of your device for loopback audio capturing.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.< 0: Failure.
  Future<void> enableLoopbackRecordingEx(
      {required RtcConnection connection,
      required bool enabled,
      String? deviceName});

  /// Adjusts the playback signal volume of a specified remote user.
  /// You can call this method to adjust the playback volume of a specified remote user. To adjust the playback volume of different remote users, call the method as many times, once for each remote user.Call this method after joining a channel.The playback volume here refers to the mixed volume of a specified remote user.
  ///
  /// * [uid] The user ID of the remote user.
  /// * [volume] Audio mixing volume. The value ranges between 0 and 100. The default value is 100, which means the original volume.
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.< 0: Failure.
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
  /// The current connection state. See ConnectionStateType .
  Future<ConnectionStateType> getConnectionStateEx(RtcConnection connection);

  /// @nodoc
  Future<void> enableEncryptionEx(
      {required RtcConnection connection,
      required bool enabled,
      required EncryptionConfig config});

  /// Creates a data stream.
  /// Creates a data stream. Each user can create up to five data streams in a single channel.Compared with createDataStreamEx , this method does not support data reliability. If a data packet is not received five seconds after it was sent, the SDK directly discards the data.
  ///
  /// * [config] The configurations for the data stream. See DataStreamConfig .
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// ID of the created data stream, if the method call succeeds.< 0: Failure.
  Future<int> createDataStreamEx(
      {required DataStreamConfig config, required RtcConnection connection});

  /// Sends data stream messages.
  /// After calling createDataStreamEx , you can call this method to send data stream messages to all users in the channel.The SDK has the following restrictions on this method:Up to 60 packets can be sent per second in a channel with each packet having a maximum size of 1 KB.Each client can send up to 30 KB of data per second.Each user can have up to five data streams simultaneously.A successful method call triggers the onStreamMessage callback on the remote client, from which the remote user gets the stream message.
  /// A failed method call triggers the onStreamMessageError callback on the remote client.Ensure that you call createDataStreamEx to create a data channel before calling this method.This method applies only to the COMMUNICATION profile or to the hosts in the LIVE_BROADCASTING profile. If an audience in the LIVE_BROADCASTING profile calls this method, the audience may be switched to a host.
  ///
  /// * [streamId] The data stream ID. You can get the data stream ID by calling createDataStreamEx.
  /// * [data] The message to be sent.
  /// * [length] The length of the data.
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.< 0: Failure.
  Future<void> sendStreamMessageEx(
      {required int streamId,
      required Uint8List data,
      required int length,
      required RtcConnection connection});

  /// Adds a watermark image to the local video.
  /// This method adds a PNG watermark image to the local video in the live streaming. Once the watermark image is added, all the audience in the channel (CDN audience included), and the capturing device can see and capture it. The Agora SDK supports adding only one watermark image onto a local video or CDN live stream. The newly added watermark image replaces the previous one.
  ///  The watermark coordinates are dependent on the settings in the setVideoEncoderConfigurationEx method:If the orientation mode of the encoding video ( OrientationMode ) is fixed landscape mode or the adaptive landscape mode, the watermark uses the landscape orientation.If the orientation mode of the encoding video (OrientationMode) is fixed portrait mode or the adaptive portrait mode, the watermark uses the portrait orientation.When setting the watermark position, the region must be less than the dimensions set in the setVideoEncoderConfigurationEx method; otherwise, the watermark image will be cropped.Ensure that you have called enableVideo before calling this method.This method supports adding a watermark image in the PNG file format only. Supported pixel formats of the PNG image are RGBA, RGB, Palette, Gray, and Alpha_gray.If the dimensions of the PNG image differ from your settings in this method, the image will be cropped or zoomed to conform to your settings.If you have enabled the local video preview by calling the startPreview method, you can use the visibleInPreview member to set whether or not the watermark is visible in the preview.If you have enabled the mirror mode for the local video, the watermark on the local video is also mirrored. To avoid mirroring the watermark, Agora recommends that you do not use the mirror and watermark functions for the local video at the same time. You can implement the watermark function in your application layer.
  ///
  /// * [watermarkUrl] The local file path of the watermark image to be added. This method supports adding a watermark image from the local absolute or relative file path.
  /// * [options] The options of the watermark image to be added. See WatermarkOptions .
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.< 0: Failure.
  Future<void> addVideoWatermarkEx(
      {required String watermarkUrl,
      required WatermarkOptions options,
      required RtcConnection connection});

  /// Removes the watermark image from the video stream.
  ///
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.< 0: Failure.
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
  /// * [interval] Sets the time interval between two consecutive volume indications:≤ 0: Disables the volume indication.> 0: Time interval (ms) between two consecutive volume indications. The lowest value is 50.
  /// * [smooth] The smoothing factor that sets the sensitivity of the audio volume indicator. The value ranges between 0 and 10. The recommended value is 3. The greater the value, the more sensitive the indicator.
  /// * [reportVad] true: Enables the voice activity detection of the local user. Once it is enabled, the vad parameter of the onAudioVolumeIndication callback reports the voice activity status of the local user.false: (Default) Disables the voice activity detection of the local user. Once it is disabled, the vad parameter of the onAudioVolumeIndication callback does not report the voice activity status of the local user, except for the scenario where the engine automatically detects the voice activity of the local user.
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.< 0: Failure.
  Future<void> enableAudioVolumeIndicationEx(
      {required int interval,
      required int smooth,
      required bool reportVad,
      required RtcConnection connection});

  /// Starts pushing media streams to a CDN without transcoding.
  /// Ensure that you enable the Media Push service before using this function. See Enable Media Push.
  ///  Call this method after joining a channel.
  ///  Only hosts in the LIVE_BROADCASTING profile can call this method.
  ///  If you want to retry pushing streams after a failed push, make sure to call stopRtmpStream first, then call this method to retry pushing streams; otherwise, the SDK returns the same error code as the last failed push.
  ///  Agora recommends that you use the server-side Media Push function. You can call this method to push an audio or video stream to the specified CDN address. This method can push media streams to only one CDN address at a time, so if you need to push streams to multiple addresses, call this method multiple times.After you call this method, the SDK triggers the onRtmpStreamingStateChanged callback on the local client to report the state of the streaming.
  ///
  /// * [url] The address of Media Push. The format is RTMP or RTMPS. The character length cannot exceed 1024 bytes. Special characters such as Chinese characters are not supported.
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly. < 0: Failure.
  ///  -2: The URL is null or the string length is 0.
  ///  -7: The SDK is not initialized before calling this method.
  ///  -19: The Media Push URL is already in use, use another URL instead.
  Future<void> startRtmpStreamWithoutTranscodingEx(
      {required String url, required RtcConnection connection});

  /// Starts Media Push and sets the transcoding configuration.
  /// Agora recommends that you use the server-side Media Push function. You can call this method to push a live audio-and-video stream to the specified CDN address and set the transcoding configuration. This method can push media streams to only one CDN address at a time, so if you need to push streams to multiple addresses, call this method multiple times.After you call this method, the SDK triggers the onRtmpStreamingStateChanged callback on the local client to report the state of the streaming.Ensure that you enable the Media Push service before using this function. Call this method after joining a channel.Only hosts in the LIVE_BROADCASTING profile can call this method.If you want to retry pushing streams after a failed push, make sure to call stopRtmpStreamEx first, then call this method to retry pushing streams; otherwise, the SDK returns the same error code as the last failed push.
  ///
  /// * [url] The address of Media Push. The format is RTMP or RTMPS. The character length cannot exceed 1024 bytes. Special characters such as Chinese characters are not supported.
  /// * [transcoding] The transcoding configuration for Media Push. See LiveTranscoding .
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.< 0: Failure.-2: The URL is null or the string length is 0.-7: The SDK is not initialized before calling this method.-19: The Media Push URL is already in use, use another URL instead.
  Future<void> startRtmpStreamWithTranscodingEx(
      {required String url,
      required LiveTranscoding transcoding,
      required RtcConnection connection});

  /// Updates the transcoding configuration.
  /// Agora recommends that you use the server-side Media Push function. After you start pushing media streams to CDN with transcoding, you can dynamically update the transcoding configuration according to the scenario. The SDK triggers the onTranscodingUpdated callback after the transcoding configuration is updated.
  ///
  /// * [transcoding] The transcoding configuration for Media Push. See LiveTranscoding .
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.< 0: Failure.
  Future<void> updateRtmpTranscodingEx(
      {required LiveTranscoding transcoding,
      required RtcConnection connection});

  /// Stops pushing media streams to a CDN.
  /// Agora recommends that you use the server-side Media Push function. You can call this method to stop the live stream on the specified CDN address. This method can stop pushing media streams to only one CDN address at a time, so if you need to stop pushing streams to multiple addresses, call this method multiple times.After you call this method, the SDK triggers the onRtmpStreamingStateChanged callback on the local client to report the state of the streaming.
  ///
  /// * [url] The address of Media Push. The format is RTMP or RTMPS. The character length cannot exceed 1024 bytes. Special characters such as Chinese characters are not supported.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.< 0: Failure.
  Future<void> stopRtmpStreamEx(
      {required String url, required RtcConnection connection});

  /// Starts relaying media streams across channels. This method can be used to implement scenarios such as co-host across channels.
  /// Deprecated:This method is deprecated. Use startOrUpdateChannelMediaRelayEx instead.After a successful method call, the SDK triggers the onChannelMediaRelayStateChanged and onChannelMediaRelayEvent callbacks, and these callbacks return the state and events of the media stream relay.If the onChannelMediaRelayStateChanged callback returns relayStateRunning (2) and relayOk (0), and the onChannelMediaRelayEvent callback returns relayEventPacketSentToDestChannel (4), it means that the SDK starts relaying media streams between the source channel and the target channel.If the onChannelMediaRelayStateChanged callback returns relayStateFailure (3), an exception occurs during the media stream relay.Call this method after joining the channel.This method takes effect only when you are a host in a live streaming channel.After a successful method call, if you want to call this method again, ensure that you call the stopChannelMediaRelayEx method to quit the current relay.The relaying media streams across channels function needs to be enabled by contacting .Agora does not support string user accounts in this API.
  ///
  /// * [configuration] The configuration of the media stream relay. See ChannelMediaRelayConfiguration .
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.< 0: Failure.-1: A general error occurs (no specified reason).-2: The parameter is invalid.-7: The method call was rejected. It may be because the SDK has not been initialized successfully, or the user role is not an host.-8: Internal state error. Probably because the user is not an audience member.
  Future<void> startChannelMediaRelayEx(
      {required ChannelMediaRelayConfiguration configuration,
      required RtcConnection connection});

  /// Updates the channels for media stream relay.
  /// Deprecated:This method is deprecated. Use startOrUpdateChannelMediaRelayEx instead.After the media relay starts, if you want to relay the media stream to more channels, or leave the current relay channel, you can call this method.After a successful method call, the SDK triggers the onChannelMediaRelayEvent callback with the relayEventPacketUpdateDestChannel (7) state code.Call the method after successfully calling the startChannelMediaRelayEx method and receiving onChannelMediaRelayStateChanged (relayStateRunning, relayOk); otherwise, the method call fails.
  ///
  /// * [configuration] The configuration of the media stream relay. See ChannelMediaRelayConfiguration .
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.< 0: Failure.
  Future<void> updateChannelMediaRelayEx(
      {required ChannelMediaRelayConfiguration configuration,
      required RtcConnection connection});

  /// Stops the media stream relay. Once the relay stops, the host quits all the target channels.
  /// After a successful method call, the SDK triggers the onChannelMediaRelayStateChanged callback. If the callback reports relayStateIdle (0) and relayOk (0), the host successfully stops the relay.If the method call fails, the SDK triggers the onChannelMediaRelayStateChanged callback with the relayErrorServerNoResponse (2) or relayErrorServerConnectionLost (8) status code. You can call the leaveChannel method to leave the channel, and the media stream relay automatically stops.
  ///
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.< 0: Failure.
  Future<void> stopChannelMediaRelayEx(RtcConnection connection);

  /// Pauses the media stream relay to all target channels.
  /// After the cross-channel media stream relay starts, you can call this method to pause relaying media streams to all target channels; after the pause, if you want to resume the relay, call resumeAllChannelMediaRelay .Call this method after startOrUpdateChannelMediaRelayEx .
  ///
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.< 0: Failure.
  Future<void> pauseAllChannelMediaRelayEx(RtcConnection connection);

  /// Resumes the media stream relay to all target channels.
  /// After calling the pauseAllChannelMediaRelayEx method, you can call this method to resume relaying media streams to all destination channels.Call this method after pauseAllChannelMediaRelayEx .
  ///
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.< 0: Failure.
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
  /// After you enable dual-stream mode, you can call setRemoteVideoStreamType to choose to receive either the high-quality video stream or the low-quality video stream on the subscriber side.You can call this method to enable or disable the dual-stream mode on the publisher side. Dual streams are a pairing of a high-quality video stream and a low-quality video stream:High-quality video stream: High bitrate, high resolution.Low-quality video stream: Low bitrate, low resolution.This method is applicable to all types of streams from the sender, including but not limited to video streams collected from cameras, screen sharing streams, and custom-collected video streams.
  ///
  /// * [enabled] Whether to enable dual-stream mode:
  ///  true: Enable dual-stream mode.
  ///  false: (Default) Disable dual-stream mode.
  /// * [streamConfig] The configuration of the low-quality video stream. See SimulcastStreamConfig .
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.< 0: Failure.
  Future<void> enableDualStreamModeEx(
      {required bool enabled,
      required SimulcastStreamConfig streamConfig,
      required RtcConnection connection});

  /// Sets the dual-stream mode on the sender side.
  /// The SDK enables the low-quality video stream auto mode on the sender by default, which is equivalent to calling this method and setting the mode to autoSimulcastStream. If you want to modify this behavior, you can call this method and modify the mode to disableSimulcastStream (never send low-quality video streams) or enableSimulcastStream (always send low-quality video streams).The difference and connection between this method and enableDualStreamModeEx is as follows:When calling this method and setting mode to disableSimulcastStream, it has the same effect as enableDualStreamModeEx(false).When calling this method and setting mode to enableSimulcastStream, it has the same effect as enableDualStreamModeEx(true).Both methods can be called before and after joining a channel. If both methods are used, the settings in the method called later takes precedence.
  ///
  /// * [mode] The mode in which the video stream is sent. See SimulcastStreamMode .
  /// * [streamConfig] The configuration of the low-quality video stream. See SimulcastStreamConfig .
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.< 0: Failure.
  Future<void> setDualStreamModeEx(
      {required SimulcastStreamMode mode,
      required SimulcastStreamConfig streamConfig,
      required RtcConnection connection});

  @override
  Future<void> enableWirelessAccelerate(bool enabled);

  /// Takes a snapshot of a video stream.
  /// The method is asynchronous, and the SDK has not taken the snapshot when the method call returns. After a successful method call, the SDK triggers the onSnapshotTaken callback to report whether the snapshot is successfully taken, as well as the details for that snapshot.This method takes a snapshot of a video stream from the specified user, generates a JPG image, and saves it to the specified path.Call this method after the joinChannelEx method.This method takes a snapshot of the published video stream specified in ChannelMediaOptions .If the user's video has been preprocessed, for example, watermarked or beautified, the resulting snapshot includes the pre-processing effect.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [uid] The user ID. Set uid as 0 if you want to take a snapshot of the local user's video.
  /// * [filePath] The local path (including filename extensions) of the snapshot. For example:Windows: C:\Users\<user_name>\AppData\Local\Agora\<process_name>\example.jpgiOS: /App Sandbox/Library/Caches/example.jpgmacOS: ～/Library/Logs/example.jpgAndroid: /storage/emulated/0/Android/data/<package name>/files/example.jpgEnsure that the path you specify exists and is writable.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.< 0: Failure.
  Future<void> takeSnapshotEx(
      {required RtcConnection connection,
      required int uid,
      required String filePath});
}
