import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_rtc_engine_ex.g.dart';

/// Contains connection information.
///
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
  /// You can call this method multiple times to join more than one channels.If you are already in a channel, you cannot rejoin it with the same user ID.If you want to join the same channel from different devices, ensure that the user IDs in all devices are different.Ensure that the app ID you use to generate the token is the same with the app ID used when creating the RtcEngine instance.
  ///
  /// * [options] The channel media options. See ChannelMediaOptions .
  /// * [token] The token generated on your server for authentication.
  ///
  Future<void> joinChannelEx(
      {required String token,
      required RtcConnection connection,
      required ChannelMediaOptions options});

  /// Leaves a channel.
  ///
  ///
  /// * [connection] The connection information. See RtcConnection .
  Future<void> leaveChannelEx(RtcConnection connection);

  /// Updates the channel media options after joining the channel.
  ///
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
  /// Returns
  /// 0: Success.< 0: Failure.
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
  /// Returns
  /// 0: Success. < 0: Failure.
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
  /// Returns
  /// 0: Success.< 0: Failure.
  Future<void> muteRemoteVideoStreamEx(
      {required int uid,
      required bool mute,
      required RtcConnection connection});

  /// @nodoc
  Future<void> setRemoteVideoStreamTypeEx(
      {required int uid,
      required VideoStreamType streamType,
      required RtcConnection connection});

  /// Set the blocklist of subscriptions for audio streams.
  /// You can call this method to specify the audio streams of a user that you do not want to subscribe to.You can call this method either before or after joining a channel.The blocklist is not affected by the setting in muteRemoteAudioStream , muteAllRemoteAudioStreams and autoSubscribeAudio in ChannelMediaOptions .Once the blocklist of subscriptions is set, it is effective even if you leave the current channel and rejoin the channel.If a user is added in the allowlist and blocklist at the same time, only the blocklist takes effect.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [uidNumber] The number of users in the user ID list.
  /// * [uidList] The user ID list of users that you do not want to subscribe to.If you want to specify the audio streams of a user that you do not want to subscribe to, add the user ID in this list. If you want to remove a user from the blocklist, you need to call the setSubscribeAudioBlacklist method to update the user ID list; this means you only add the uid of users that you do not want to subscribe to in the new user ID list.
  Future<void> setSubscribeAudioBlacklistEx(
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
  ///  If you want to specify the audio streams of a user for subscription, add the user ID in this list. If you want to remove a user from the allowlist, you need to call the setSubscribeAudioWhitelist method to update the user ID list; this means you only add the uid of users that you want to subscribe to in the new user ID list.
  ///
  Future<void> setSubscribeAudioWhitelistEx(
      {required List<int> uidList,
      required int uidNumber,
      required RtcConnection connection});

  /// Set the bocklist of subscriptions for video streams.
  /// You can call this method to specify the video streams of a user that you do not want to subscribe to. If a user is added in the allowlist and blocklist at the same time, only the blocklist takes effect.Once the blocklist of subscriptions is set, it is effective even if you leave the current channel and rejoin the channel.You can call this method either before or after joining a channel.The blocklist is not affected by the setting in muteRemoteVideoStream , muteAllRemoteVideoStreams and autoSubscribeAudio in ChannelMediaOptions .
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [uidNumber] The number of users in the user ID list.
  /// * [uidList] The user ID list of users that you do not want to subscribe to.
  ///  If you want to specify the video streams of a user that you do not want to subscribe to, add the user ID of that user in this list. If you want to remove a user from the blocklist, you need to call the setSubscribeVideoBlacklist method to update the user ID list; this means you only add the uid of users that you do not want to subscribe to in the new user ID list.
  ///
  Future<void> setSubscribeVideoBlacklistEx(
      {required List<int> uidList,
      required int uidNumber,
      required RtcConnection connection});

  /// Set the allowlist of subscriptions for video streams.
  /// You can call this method to specify the video streams of a user that you want to subscribe to. If a user is added in the allowlist and blocklist at the same time, only the blocklist takes effect.Once the allowlist of subscriptions is set, it is effective even if you leave the current channel and rejoin the channel.
  ///  You can call this method either before or after joining a channel.The allowlist is not affected by the setting in muteRemoteVideoStream , muteAllRemoteVideoStreams and autoSubscribeAudio in ChannelMediaOptions .
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [uidNumber] The number of users in the user ID list.
  /// * [uidList] The user ID list of users that you want to subscribe to.
  ///  If you want to specify the video streams of a user for subscription, add the user ID of that user in this list. If you want to remove a user from the allowlist, you need to call the setSubscribeVideoWhitelist method to update the user ID list; this means you only add the uid of users that you want to subscribe to in the new user ID list.
  ///
  Future<void> setSubscribeVideoWhitelistEx(
      {required List<int> uidList,
      required int uidNumber,
      required RtcConnection connection});

  /// @nodoc
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
  /// Returns
  /// 0: Success.< 0: Failure.
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
  /// * [deviceName] macOS: The device name of the virtual sound card. The default is set to null, which means the SDK uses Soundflower for loopback audio capture.
  ///  Windows: The device name of the sound card. The default is set to null, which means the SDK uses the sound card of your device for loopback audio capture.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [enabled] Sets whether to enable loopback audio capture:
  ///  true: Enable loopback audio capture.false: (Default) Disable loopback audio capture.
  ///
  /// Returns
  /// 0: Success.< 0: Failure.
  Future<void> enableLoopbackRecordingEx(
      {required RtcConnection connection,
      required bool enabled,
      String? deviceName});

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

  /// Sends data stream messages.
  /// After calling createDataStreamEx , you can call this method to send data stream messages to all users in the channel.The SDK has the following restrictions on this method:Up to 30 packets can be sent per second in a channel with each packet having a maximum size of 1 kB.Each client can send up to 6 KB of data per second.Each user can have up to five data streams simultaneously.A successful method call triggers the onStreamMessage callback on the remote client, from which the remote user gets the stream message.
  /// A failed method call triggers the onStreamMessageError callback on the remote client.Ensure that you call createDataStreamEx to create a data channel before calling this method.This method applies only to the COMMUNICATION profile or to the hosts in the LIVE_BROADCASTING profile. If an audience in the LIVE_BROADCASTING profile calls this method, the audience may be switched to a host.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [streamId] The data stream ID. You can get the data stream ID by calling createDataStreamEx.
  /// * [data] The data to be sent.
  /// * [length] The length of the data.
  ///
  /// Returns
  /// 0: Success.< 0: Failure.
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
  /// Returns
  /// 0: Success.< 0: Failure.
  Future<void> addVideoWatermarkEx(
      {required String watermarkUrl,
      required WatermarkOptions options,
      required RtcConnection connection});

  /// Removes the watermark image from the video stream.
  ///
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

  /// @nodoc
  Future<void> enableAudioVolumeIndicationEx(
      {required int interval,
      required int smooth,
      required bool reportVad,
      required RtcConnection connection});

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

  /// @nodoc
  Future<void> enableDualStreamModeEx(
      {required VideoSourceType sourceType,
      required bool enabled,
      required SimulcastStreamConfig streamConfig,
      required RtcConnection connection});

  /// @nodoc
  Future<void> setDualStreamModeEx(
      {required VideoSourceType sourceType,
      required SimulcastStreamMode mode,
      required SimulcastStreamConfig streamConfig,
      required RtcConnection connection});

  @override
  Future<void> enableWirelessAccelerate(bool enabled);

  /// Takes a snapshot of a video stream.
  /// The method is asynchronous, and the SDK has not taken the snapshot when the method call returns. After a successful method call, the SDK triggers the onSnapshotTaken callback to report whether the snapshot is successfully taken, as well as the details for that snapshot.
  ///  This method takes a snapshot of a video stream from the specified user, generates a JPG image, and saves it to the specified path.
  ///  Call this method after the joinChannelEx method.This method takes a snapshot of the published video stream specified in ChannelMediaOptions .If the user's video has been preprocessed, for example, watermarked or beautified, the resulting snapshot includes the pre-processing effect.
  ///
  /// * [filePath] The local path (including filename extensions) of the snapshot. For example:
  ///  Windows: C:\Users\<user_name>\AppData\Local\Agora\<process_name>\example.jpg
  ///  iOS: /App Sandbox/Library/Caches/example.jpg
  ///  macOS: ～/Library/Logs/example.jpg
  ///  Android: /storage/emulated/0/Android/data/<package name>/files/example.jpg
  ///  Ensure that the path you specify exists and is writable.
  ///
  /// * [uid] The user ID. Set uid as 0 if you want to take a snapshot of the local user's video.
  /// * [connection] The connection information. See RtcConnection .
  Future<void> takeSnapshotEx(
      {required RtcConnection connection,
      required int uid,
      required String filePath});

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
}
