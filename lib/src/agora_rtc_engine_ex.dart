import '/src/_serializable.dart';
import '/src/binding_forward_export.dart';
part 'agora_rtc_engine_ex.g.dart';

/// Class containing connection information.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RtcConnection implements AgoraSerializable {
  /// @nodoc
  const RtcConnection({this.channelId, this.localUid});

  /// Channel name.
  @JsonKey(name: 'channelId')
  final String? channelId;

  /// Local user ID.
  @JsonKey(name: 'localUid')
  final int? localUid;

  /// @nodoc
  factory RtcConnection.fromJson(Map<String, dynamic> json) =>
      _$RtcConnectionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RtcConnectionToJson(this);
}

/// Interface class that provides multi-channel methods.
///
/// Inherits from RtcEngine.
abstract class RtcEngineEx implements RtcEngine {
  /// Joins a channel.
  ///
  /// Call this method to join multiple channels simultaneously. If you want to join the same channel on different devices, make sure the user IDs used on each device are different. If you are already in a channel, you cannot join the same channel again with the same user ID.
  /// Before joining a channel, ensure that the App ID used to generate the Token is the same as the one used in the initialize method. Otherwise, joining the channel using the Token will fail.
  ///
  /// * [token] The dynamic key generated on your server for authentication. See [Token Authentication](https://docs.agora.io/en/video-calling/token-authentication/deploy-token-server).
  ///  (Recommended) If your project enables security mode (i.e., uses APP ID + Token for authentication), this parameter is required.
  ///  If your project only enables debug mode (i.e., uses APP ID for authentication), you can join a channel without providing a Token. You will automatically leave the channel after 24 hours.
  ///  If you need to join multiple channels at once or frequently switch between channels, Agora recommends using a wildcard Token to avoid requesting a new Token from your server for each new channel. See [Wildcard Token](https://docs.agora.io/en/video-calling/token-authentication/deploy-token-server).
  /// * [connection] Connection information. See RtcConnection.
  /// * [options] Channel media options. See ChannelMediaOptions.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when it fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Method call failed. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  -2: Invalid parameters. For example, an invalid Token, uid is not an integer, or ChannelMediaOptions contains invalid values. Provide valid parameters and rejoin the channel.
  ///  -3: RtcEngine initialization failed. Reinitialize the RtcEngine object.
  ///  -7: RtcEngine not initialized. Initialize the RtcEngine object before calling this method.
  ///  -8: Internal state error in RtcEngine. Possible cause: startEchoTest was called but stopEchoTest was not called before joining the channel. Call stopEchoTest before this method.
  ///  -17: Join channel rejected. Possible cause: user is already in the channel. Use onConnectionStateChanged to check if the user is in the channel. Do not call this method again unless you receive connectionStateDisconnected (1).
  ///  -102: Invalid channel name. Provide a valid channelId and rejoin the channel.
  ///  -121: Invalid user ID. Provide a valid uid and rejoin the channel.
  Future<void> joinChannelEx(
      {required String token,
      required RtcConnection connection,
      required ChannelMediaOptions options});

  /// Sets channel options and leaves the channel.
  ///
  /// After this method is called, the SDK stops audio and video communication, leaves the current channel, and releases all session-related resources.
  /// After successfully joining a channel by calling joinChannelEx, you must call this method to end the call; otherwise, you cannot start the next call.
  ///  This method is asynchronous. When the call returns, it does not mean the channel has been actually left.
  ///  If you call leaveChannel, you will leave both the channels joined by joinChannel and joinChannelEx. If you call release immediately after calling this method, the SDK will not trigger the onLeaveChannel callback.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [options] Options for leaving the channel. See LeaveChannelOptions. This parameter only supports setting the stopMicrophoneRecording member in LeaveChannelOptions. Setting other members has no effect.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> leaveChannelEx(
      {required RtcConnection connection, LeaveChannelOptions? options});

  /// @nodoc
  Future<void> leaveChannelWithUserAccountEx(
      {required String channelId,
      required String userAccount,
      LeaveChannelOptions? options});

  /// Updates channel media options after joining the channel.
  ///
  /// * [options] Channel media options. See ChannelMediaOptions.
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> updateChannelMediaOptionsEx(
      {required ChannelMediaOptions options,
      required RtcConnection connection});

  /// Sets the video encoding attributes.
  ///
  /// Sets the encoding attributes for the local video. Each video encoding profile corresponds to a set of video parameters, including resolution, frame rate, and bitrate. The config parameter of this method defines the maximum values achievable under ideal network conditions. If the network condition is poor, the video engine will not use this config to render the local video and will automatically downgrade to a more appropriate video configuration.
  ///
  /// * [config] Video encoding configuration. See VideoEncoderConfiguration.
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setVideoEncoderConfigurationEx(
      {required VideoEncoderConfiguration config,
      required RtcConnection connection});

  /// Initializes the remote user view.
  ///
  /// This method binds a remote user to a display view and sets the rendering and mirror mode of the remote user view displayed locally. It only affects the video seen by the local user.
  /// You need to specify the remote user's ID in VideoCanvas when calling this method. Typically, you can set this before joining the channel.
  /// If the remote user ID is not available before joining, call this method upon receiving the onUserJoined callback. If video recording is enabled, the recording service will join the channel as a dummy client, and other clients will also receive its onUserJoined event. The app should not bind a view for it (as it does not send video streams).
  /// To unbind a view from a remote user, call this method and set view to null.
  /// After leaving the channel, the SDK clears the binding of the remote user view.
  ///  This method must be called after joinChannelEx.
  ///  In Flutter, you do not need to call this method manually. Use AgoraVideoView to render local and remote views.
  ///  If you want to update the rendering or mirror mode of the remote user view during a call, use the setRemoteRenderModeEx method.
  ///
  /// * [canvas] Video canvas information. See VideoCanvas.
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Failure. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setupRemoteVideoEx(
      {required VideoCanvas canvas, required RtcConnection connection});

  /// Stops or resumes receiving a specified audio stream.
  ///
  /// This method stops or resumes receiving the audio stream of a specified remote user. You can call this method before or after joining a channel. The setting is reset after leaving the channel.
  ///
  /// * [uid] The ID of the specified user.
  /// * [mute] Whether to stop receiving the specified audio stream: true : Stop receiving the specified audio stream. false : (Default) Continue receiving the specified audio stream.
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> muteRemoteAudioStreamEx(
      {required int uid,
      required bool mute,
      required RtcConnection connection});

  /// Stops or resumes receiving a specified video stream.
  ///
  /// This method stops or resumes receiving the video stream of a specified remote user. You can call this method before or after joining a channel. The setting is reset after leaving the channel.
  ///
  /// * [uid] The ID of the remote user.
  /// * [mute] Whether to stop receiving the video of a remote user: true : Stop receiving. false : (Default) Resume receiving.
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Method call failed. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> muteRemoteVideoStreamEx(
      {required int uid,
      required bool mute,
      required RtcConnection connection});

  /// Sets the video stream type to subscribe to.
  ///
  /// Depending on the sender's default behavior and the specific settings of setDualStreamMode, the receiver's call to this method falls into the following cases:
  ///  By default, the SDK enables the small stream adaptive mode (autoSimulcastStream) on the sender side, meaning the sender only sends the high-quality stream. Only receivers with host role can call this method to request the low-quality stream. Once the sender receives the request, it starts sending the low-quality stream. All users in the channel can then call this method to switch to low-quality stream subscription mode.
  ///  If the sender calls setDualStreamMode and sets mode to disableSimulcastStream (never send low-quality stream), this method has no effect.
  ///  If the sender calls setDualStreamMode and sets mode to enableSimulcastStream (always send low-quality stream), both hosts and audience can call this method to switch to low-quality stream subscription mode. When receiving the low-quality stream, the SDK dynamically adjusts the video stream size according to the video window size to save bandwidth and computing resources. The default aspect ratio of the low-quality stream is consistent with the high-quality stream. Based on the current high-quality stream's aspect ratio, the system automatically assigns resolution, frame rate, and bitrate to the low-quality stream. If the sender has already called setDualStreamModeEx and set mode to disableSimulcastStream (never send low-quality stream), this method has no effect. You need to call setDualStreamModeEx again on the sender side to change the setting.
  ///
  /// * [uid] User ID.
  /// * [streamType] Video stream type: VideoStreamType.
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setRemoteVideoStreamTypeEx(
      {required int uid,
      required VideoStreamType streamType,
      required RtcConnection connection});

  /// Stops or resumes publishing the local audio stream.
  ///
  /// After this method is called successfully, remote users receive the onUserMuteAudio and onRemoteAudioStateChanged callbacks. This method does not affect the audio capture status because it does not disable the audio capture device.
  ///
  /// * [mute] Whether to stop publishing the local audio stream. true : Stop publishing. false : (Default) Publish.
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> muteLocalAudioStreamEx(
      {required bool mute, required RtcConnection connection});

  /// Stops or resumes publishing the local video stream.
  ///
  /// After this method is successfully called, the remote user receives the onUserMuteVideo callback.
  ///  This method does not affect the video capture state and does not disable the camera.
  ///
  /// * [mute] Whether to stop sending the local video stream. true : Stop sending the local video stream. false : (Default) Send the local video stream.
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> muteLocalVideoStreamEx(
      {required bool mute, required RtcConnection connection});

  /// Stops or resumes subscribing to all remote users' audio streams.
  ///
  /// After this method is called successfully, the local user stops or resumes subscribing to remote users' audio streams, including streams from users who join the channel after this method is called.
  ///  You must call this method after joining a channel.
  ///  To set the default behavior to not subscribe to remote audio streams before joining, set autoSubscribeAudio to false when calling joinChannel.
  ///
  /// * [mute] Whether to stop subscribing to all remote users' audio streams: true : Stop subscribing to all remote users' audio streams. false : (Default) Subscribe to all remote users' audio streams.
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> muteAllRemoteAudioStreamsEx(
      {required bool mute, required RtcConnection connection});

  /// Stops or resumes subscribing to all remote users' video streams.
  ///
  /// After this method is called successfully, the local user stops or resumes subscribing to all remote users' video streams, including streams from users who join the channel after this method is called.
  ///
  /// * [mute] Whether to stop subscribing to all remote users' video streams. true : Stop subscribing to all users' video streams. false : (Default) Subscribe to all users' video streams.
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> muteAllRemoteVideoStreamsEx(
      {required bool mute, required RtcConnection connection});

  /// Sets the audio subscription blocklist.
  ///
  /// You can call this method to specify the audio streams you do not want to subscribe to.
  ///  This method can be called before or after joining a channel.
  ///  The audio subscription blocklist is not affected by muteRemoteAudioStream, muteAllRemoteAudioStreams, or autoSubscribeAudio in ChannelMediaOptions.
  ///  After setting the blocklist, if you leave and rejoin the channel, the blocklist remains effective.
  ///  If a user appears in both the audio subscription allowlist and blocklist, only the blocklist takes effect.
  ///
  /// * [uidList] The list of user IDs in the audio subscription blocklist.
  /// If you want to exclude a specific user's audio stream from being subscribed to, add that user's ID to this list. If you want to remove a user from the blocklist, call the setSubscribeAudioBlocklist method again and update the list of user IDs so that it no longer contains the uid of the user you want to remove.
  /// * [uidNumber] The number of users in the blocklist.
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setSubscribeAudioBlocklistEx(
      {required List<int> uidList,
      required int uidNumber,
      required RtcConnection connection});

  /// Sets the audio subscription allowlist.
  ///
  /// You can call this method to specify the audio streams you want to subscribe to.
  ///  This method can be called before or after joining a channel.
  ///  The audio subscription allowlist is not affected by muteRemoteAudioStream, muteAllRemoteAudioStreams, or autoSubscribeAudio in ChannelMediaOptions.
  ///  After setting the allowlist, if you leave and rejoin the channel, the allowlist remains effective.
  ///  If a user appears in both the audio subscription allowlist and blocklist, only the blocklist takes effect.
  ///
  /// * [uidList] The list of user IDs in the audio subscription allowlist.
  /// If you want to subscribe to a specific user's audio stream, add that user's ID to this list. If you want to remove a user from the allowlist, call the setSubscribeAudioAllowlist method again and update the list of user IDs so that it no longer contains the uid of the user you want to remove.
  /// * [uidNumber] The number of users in the allowlist.
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setSubscribeAudioAllowlistEx(
      {required List<int> uidList,
      required int uidNumber,
      required RtcConnection connection});

  /// Sets the video subscription blocklist.
  ///
  /// You can call this method to specify the video streams you do not want to subscribe to.
  ///  You can call this method either before or after joining a channel.
  ///  The video subscription blocklist is not affected by muteRemoteVideoStream, muteAllRemoteVideoStreams, or the autoSubscribeVideo setting in ChannelMediaOptions.
  ///  After setting the blocklist, it remains effective even if you leave and rejoin the channel.
  ///  If a user is in both the audio subscription blocklist and allowlist, only the blocklist takes effect.
  ///
  /// * [uidList] The user ID list of the video subscription blocklist.
  /// If you want to unsubscribe from the video stream of a specific publishing user, add that user's ID to this list. If you want to remove a user from the blocklist, you need to call the setSubscribeVideoBlocklist method again to update the user ID list of the subscription blocklist so that it no longer contains the uid of the user you want to remove.
  /// * [uidNumber] The number of users in the blocklist.
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setSubscribeVideoBlocklistEx(
      {required List<int> uidList,
      required int uidNumber,
      required RtcConnection connection});

  /// Sets the video subscription allowlist.
  ///
  /// You can call this method to specify the video streams you want to subscribe to.
  ///  You can call this method either before or after joining a channel.
  ///  The video subscription allowlist is not affected by muteRemoteVideoStream, muteAllRemoteVideoStreams, or the autoSubscribeVideo setting in ChannelMediaOptions.
  ///  After setting the allowlist, it remains effective even if you leave and rejoin the channel.
  ///  If a user is in both the audio subscription blocklist and allowlist, only the blocklist takes effect.
  ///
  /// * [uidList] The user ID list of the video subscription allowlist.
  /// If you want to subscribe only to the video stream of a specific publishing user, add that user's ID to this list. If you want to remove a user from the allowlist, you need to call the setSubscribeVideoAllowlist method again to update the user ID list of the audio subscription allowlist so that it no longer contains the uid of the user you want to remove.
  /// * [uidNumber] The number of users in the allowlist.
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setSubscribeVideoAllowlistEx(
      {required List<int> uidList,
      required int uidNumber,
      required RtcConnection connection});

  /// Sets the subscription options for the remote video stream.
  ///
  /// When the remote user sends dual streams, you can call this method to set the subscription options for the remote video stream.
  ///
  /// * [uid] Remote user ID.
  /// * [options] Subscription settings for the video stream. See VideoSubscriptionOptions.
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setRemoteVideoSubscriptionOptionsEx(
      {required int uid,
      required VideoSubscriptionOptions options,
      required RtcConnection connection});

  /// Sets the 2D position of a remote user's voice, i.e., horizontal position.
  ///
  /// Sets the spatial position and volume of a remote user's voice to help local users identify direction by sound.
  /// By calling this method, you can set the position where the remote user's voice appears. The difference between the left and right audio channels creates a sense of direction, allowing users to determine the real-time position of the remote user. In online multiplayer games, such as battle royale games, this method enhances the sense of direction of game characters and simulates real-world scenarios.
  ///  For the best listening experience, it is recommended that users wear wired headphones.
  ///  This method must be called after joining a channel.
  ///
  /// * [uid] The ID of the remote user.
  /// * [pan] Sets the spatial position of the remote user's voice. The range is [-1.0, 1.0]:
  ///  -1.0: Voice appears on the left.
  ///  (Default) 0.0: Voice appears in the center.
  ///  1.0: Voice appears on the right.
  /// * [gain] Sets the volume of the remote user's voice. The range is [0.0, 100.0], and the default value is 100.0, representing the original volume of the user. The smaller the value, the lower the volume.
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
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

  /// Sets the display mode of the remote view.
  ///
  /// After initializing the remote user view, you can call this method to update the rendering and mirror mode of the remote user view displayed locally. This method only affects the video seen by the local user.
  ///
  /// * [uid] Remote user ID.
  /// * [renderMode] Display mode of the remote view. See RenderModeType.
  /// * [mirrorMode] Mirror mode of the remote user view. See VideoMirrorModeType.
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Failure. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setRemoteRenderModeEx(
      {required int uid,
      required RenderModeType renderMode,
      required VideoMirrorModeType mirrorMode,
      required RtcConnection connection});

  /// Enables loopback recording.
  ///
  /// After enabling loopback recording, the sound played through the sound card is mixed into the local audio stream and can be sent to the remote end.
  ///  This method is applicable to macOS and Windows only.
  ///  The default sound card on macOS does not support recording. If you need to use this feature, enable a virtual sound card and set deviceName to the name of that virtual device. Agora recommends using its self-developed virtual sound card AgoraALD for recording.
  ///  Currently, only one loopback recording is supported.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [enabled] Whether to enable loopback recording: true : Enable loopback recording. false : (default) Do not enable loopback recording.
  /// * [deviceName] macOS: The name of the virtual sound card. Default is empty, which means using the AgoraALD virtual sound card for recording.
  ///  Windows: The name of the sound card. Default is empty, which means using the built-in sound card of the device for recording.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> enableLoopbackRecordingEx(
      {required RtcConnection connection,
      required bool enabled,
      String? deviceName});

  /// @nodoc
  Future<void> adjustRecordingSignalVolumeEx(
      {required int volume, required RtcConnection connection});

  /// @nodoc
  Future<void> muteRecordingSignalEx(
      {required bool mute, required RtcConnection connection});

  /// Adjusts the playback volume of a specified remote user locally.
  ///
  /// You can call this method during a call to adjust the playback volume of a specified remote user locally. To adjust the playback volume of multiple users, call this method multiple times.
  ///
  /// * [uid] The ID of the remote user.
  /// * [volume] The volume, with a range of [0,400].
  ///  0: Mute.
  ///  100: (Default) Original volume.
  ///  400: Four times the original volume, with built-in overflow protection.
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> adjustUserPlaybackSignalVolumeEx(
      {required int uid,
      required int volume,
      required RtcConnection connection});

  /// Gets the current network connection state.
  ///
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// Current network connection state. See ConnectionStateType.
  Future<ConnectionStateType> getConnectionStateEx(RtcConnection connection);

  /// Enable or disable built-in encryption.
  ///
  /// After the user leaves the channel, the SDK automatically disables encryption. To enable encryption again, you need to call this method before the user rejoins the channel.
  ///  All users in the same channel must set the same encryption mode and key when calling this method.
  ///  If built-in encryption is enabled, the CDN live streaming feature cannot be used.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [enabled] Whether to enable built-in encryption: true : Enable built-in encryption. false : (default) Disable built-in encryption.
  /// * [config] Configure the built-in encryption mode and key. See EncryptionConfig.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> enableEncryptionEx(
      {required RtcConnection connection,
      required bool enabled,
      required EncryptionConfig config});

  /// Creates a data stream.
  ///
  /// If you need a more comprehensive, low-latency, high-concurrency, and scalable real-time messaging and state synchronization solution, we recommend using [Real-time Messaging](https://docs.agora.io/en/signaling/overview/product-overview).
  /// During the lifecycle of RtcEngine, each user can create up to 5 data streams. The data streams are destroyed when leaving the channel. If needed again, you must recreate them.
  ///
  /// * [config] Data stream configuration. See DataStreamConfig.
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// ID of the created data stream: method call succeeded.
  ///  < 0: method call failed. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<int> createDataStreamEx(
      {required DataStreamConfig config, required RtcConnection connection});

  /// Sends a data stream.
  ///
  /// After calling createDataStreamEx, you can call this method to send data stream messages to all users in the channel.
  /// The SDK imposes the following restrictions on this method:
  ///  Each client in the channel can have up to 5 data channels simultaneously, with a total sending bitrate limit of 30 KB/s shared among all channels.
  ///  Each data channel can send up to 60 packets per second, with each packet limited to 1 KB. After this method is successfully called, the remote side triggers the onStreamMessage callback, through which remote users can receive the stream message. If the call fails, the remote side triggers the onStreamMessageError callback.
  ///  If you need a more comprehensive solution for low-latency, high-concurrency, and scalable real-time messaging and state synchronization, we recommend using [Real-time Messaging](https://docs.agora.io/en/signaling/overview/product-overview).
  ///  This method must be called after joinChannelEx.
  ///  Make sure you have called createDataStreamEx to create the data channel before calling this method.
  ///
  /// * [streamId] The data stream ID. You can get it through createDataStreamEx.
  /// * [data] The data to be sent.
  /// * [length] The length of the data.
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> sendStreamMessageEx(
      {required int streamId,
      required Uint8List data,
      required int length,
      required RtcConnection connection});

  /// Adds a local video watermark.
  ///
  /// Deprecated Deprecated: This method is deprecated. Use addVideoWatermarkWithConfigEx instead. This method adds a PNG image as a watermark to the local published live video stream. Users in the same live streaming channel, audience members of the CDN live stream, and capturing devices can see or capture the watermark image. Currently, only one watermark can be added to the live video stream. Any new watermark added will replace the previous one.
  /// The watermark coordinates depend on the settings in the setVideoEncoderConfigurationEx method:
  ///  If the video encoding orientation (OrientationMode) is fixed to landscape or adaptive landscape, the watermark uses landscape coordinates.
  ///  If the video encoding orientation (OrientationMode) is fixed to portrait or adaptive portrait, the watermark uses portrait coordinates.
  ///  When setting the watermark coordinates, the watermark image area must not exceed the video dimensions set in the setVideoEncoderConfigurationEx method; otherwise, the exceeding part will be cropped.
  ///  You must call this method after calling enableVideo.
  ///  The watermark image to be added must be in PNG format. This method supports all pixel formats of PNG images: RGBA, RGB, Palette, Gray, and Alpha_gray.
  ///  If the size of the PNG image to be added does not match the size set in this method, the SDK will scale or crop the PNG image to match the settings.
  ///  If you have already started local video preview using the startPreview method, the visibleInPreview parameter of this method can be used to set whether the watermark is visible during preview.
  ///  If local video mirroring is enabled, the local watermark will also be mirrored. To avoid the watermark being mirrored when local users view their own video, it is recommended not to use both mirroring and watermark features simultaneously for local video. Implement the local watermark feature at the application level.
  ///
  /// * [watermarkUrl] Local path of the watermark image to be added. This method supports adding watermark images from local absolute/relative paths.
  /// * [options] Settings for the watermark image to be added. See WatermarkOptions.
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> addVideoWatermarkEx(
      {required String watermarkUrl,
      required WatermarkOptions options,
      required RtcConnection connection});

  /// Removes added video watermarks.
  ///
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> clearVideoWatermarkEx(RtcConnection connection);

  /// Custom data reporting and analytics service.
  ///
  /// Agora provides a custom data reporting and analytics service. This service is currently in a free beta period. During the beta, you can report up to 10 data entries within 6 seconds. Each custom data entry must not exceed 256 bytes, and each string must not exceed 100 bytes. To try this service, please [contact sales](mailto:support@agora.io) to enable it and agree on the custom data format.
  Future<void> sendCustomReportMessageEx(
      {required String id,
      required String category,
      required String event,
      required String label,
      required int value,
      required RtcConnection connection});

  /// Enables audio volume indication.
  ///
  /// This method allows the SDK to periodically report volume information of the local user who is sending a stream and up to 3 remote users with the highest instantaneous volume to the app.
  ///
  /// * [interval] The time interval for volume indication:
  ///  ≤ 0: Disables the volume indication.
  ///  > 0: The interval in milliseconds for volume indication. It is recommended to set it greater than 100 ms. Must not be less than 10 ms, otherwise the onAudioVolumeIndication callback will not be received.
  /// * [smooth] The smoothing factor that specifies the sensitivity of the volume indication. The range is [0,10], and the recommended value is 3. The larger the value, the more sensitive the fluctuation; the smaller the value, the smoother the fluctuation.
  /// * [reportVad] true : Enables local voice activity detection. When enabled, the vad parameter in the onAudioVolumeIndication callback reports whether voice is detected locally. false : (Default) Disables local voice activity detection. Unless the engine automatically detects local voice, the vad parameter in the onAudioVolumeIndication callback does not report local voice detection.
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Method call failed. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> enableAudioVolumeIndicationEx(
      {required int interval,
      required int smooth,
      required bool reportVad,
      required RtcConnection connection});

  /// Starts pushing streams without transcoding.
  ///
  /// Agora recommends using the more comprehensive server-side streaming feature. See [Implement Server-Side Streaming](https://docs.agora.io/en/media-push/get-started/enable-media-push).
  /// You can call this method to push live audio and video streams to a specified CDN streaming URL. This method can only push to one URL at a time. To push to multiple URLs, you must call this method multiple times.
  /// After calling this method, the SDK triggers the onRtmpStreamingStateChanged callback locally to report the streaming status.
  ///  Call this method after joining a channel.
  ///  Only hosts in live streaming scenarios can call this method.
  ///  If the stream fails to start and you want to restart it, you must call stopRtmpStream before calling this method again. Otherwise, the SDK returns the same error code as the previous failure.
  ///
  /// * [url] The CDN streaming URL. The format must be RTMP or RTMPS. The character length must not exceed 1024 bytes. Special characters such as Chinese are not supported.
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> startRtmpStreamWithoutTranscodingEx(
      {required String url, required RtcConnection connection});

  /// Starts pushing streams with transcoding settings.
  ///
  /// Agora recommends using the more comprehensive server-side streaming feature. See [Implement Server-Side Streaming](https://docs.agora.io/en/media-push/get-started/enable-media-push).
  /// You can call this method to push live audio and video streams to a specified CDN streaming URL with transcoding settings. This method can only push to one URL at a time. To push to multiple URLs, you must call this method multiple times.
  /// After calling this method, the SDK triggers the onRtmpStreamingStateChanged callback locally to report the streaming status.
  ///  Make sure the CDN streaming service is enabled.
  ///  Call this method after joining a channel.
  ///  Only hosts in live streaming scenarios can call this method.
  ///  If the stream fails to start and you want to restart it, you must call stopRtmpStreamEx before calling this method again. Otherwise, the SDK returns the same error code as the previous failure.
  ///
  /// * [url] The CDN streaming URL. The format must be RTMP or RTMPS. The character length must not exceed 1024 bytes. Special characters such as Chinese are not supported.
  /// * [transcoding] The transcoding settings for the CDN stream. See LiveTranscoding.
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> startRtmpStreamWithTranscodingEx(
      {required String url,
      required LiveTranscoding transcoding,
      required RtcConnection connection});

  /// Updates the RTMP transcoding configuration.
  ///
  /// Agora recommends using the more comprehensive server-side streaming feature. See [Implement Server-Side RTMP Streaming](https://docs.agora.io/en/media-push/get-started/enable-media-push).
  /// After enabling transcoding streaming, you can dynamically update the transcoding configuration based on your scenario needs. After the transcoding configuration is updated, the SDK triggers the onTranscodingUpdated callback.
  ///
  /// * [transcoding] The transcoding configuration for RTMP streaming. See LiveTranscoding.
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> updateRtmpTranscodingEx(
      {required LiveTranscoding transcoding,
      required RtcConnection connection});

  /// Stops the RTMP stream.
  ///
  /// Agora recommends using the more comprehensive server-side streaming feature. See [Implement Server-Side RTMP Streaming](https://docs.agora.io/en/media-push/get-started/enable-media-push).
  /// Call this method to stop the live stream on the specified RTMP streaming URL. This method can only stop one streaming URL at a time. If you need to stop multiple streaming URLs, call this method multiple times.
  /// After calling this method, the SDK triggers the onRtmpStreamingStateChanged callback locally to report the streaming status.
  ///
  /// * [url] The RTMP streaming URL. The format must be RTMP or RTMPS. The character length must not exceed 1024 bytes. Special characters such as Chinese characters are not supported.
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> stopRtmpStreamEx(
      {required String url, required RtcConnection connection});

  /// Starts or updates cross-channel media stream relay.
  ///
  /// The first successful call to this method starts the cross-channel media stream relay. To relay the stream to multiple destination channels or exit the current relay channels, you can call this method again to add or remove destination channels. This feature supports relaying media streams to up to 6 destination channels.
  /// After the method is successfully called, the SDK triggers the onChannelMediaRelayStateChanged callback to report the current state of the cross-channel media stream relay. Common states include:
  ///  If the onChannelMediaRelayStateChanged callback reports relayStateRunning (2) and relayOk (0), it indicates that the SDK has started relaying media streams between the source and destination channels.
  ///  If the onChannelMediaRelayStateChanged callback reports relayStateFailure (3), it indicates an exception occurred in the cross-channel media stream relay.
  ///  Call this method after successfully joining a channel.
  ///  In a live broadcast scenario, only users with the broadcaster role can call this method.
  ///  The cross-channel media stream relay feature requires [contacting technical support](https://www.agora.io/cn/contact/) to enable.
  ///  This feature does not support String-type UIDs.
  ///
  /// * [configuration] Configuration for cross-channel media stream relay. See ChannelMediaRelayConfiguration.
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Method call failed. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  -1: General error (not specifically classified).
  ///  -2: Invalid parameter.
  ///  -8: Internal state error. Possibly because the user role is not broadcaster.
  Future<void> startOrUpdateChannelMediaRelayEx(
      {required ChannelMediaRelayConfiguration configuration,
      required RtcConnection connection});

  /// Stops cross-channel media stream relay. Once stopped, the broadcaster leaves all destination channels.
  ///
  /// After the method is successfully called, the SDK triggers the onChannelMediaRelayStateChanged callback. If it reports relayStateIdle (0) and relayOk (0), it indicates that media stream relay has been stopped. If the method call fails, the SDK triggers the onChannelMediaRelayStateChanged callback and reports the status code relayErrorServerNoResponse (2) or relayErrorServerConnectionLost (8). You can call the leaveChannel method to leave the channel, and the cross-channel media stream relay will stop automatically.
  ///
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Method call failed. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  -5: This method call was rejected. There is no ongoing cross-channel media stream relay.
  Future<void> stopChannelMediaRelayEx(RtcConnection connection);

  /// Pauses media stream relay to all destination channels.
  ///
  /// After starting media stream relay across channels, if you want to pause relaying to all destination channels, you can call this method. To resume relaying, call resumeAllChannelMediaRelay. You must call this method after calling startOrUpdateChannelMediaRelayEx to start media stream relay across channels.
  ///
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when it fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> pauseAllChannelMediaRelayEx(RtcConnection connection);

  /// Resumes media stream relay to all destination channels.
  ///
  /// After calling the pauseAllChannelMediaRelayEx method, if you need to resume media stream relay to all destination channels, you can call this method. This method must be called after pauseAllChannelMediaRelayEx.
  ///
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Method call failed. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  -5: This method call was rejected. There is no paused cross-channel media stream relay.
  Future<void> resumeAllChannelMediaRelayEx(RtcConnection connection);

  /// @nodoc
  Future<UserInfo> getUserInfoByUserAccountEx(
      {required String userAccount, required RtcConnection connection});

  /// @nodoc
  Future<UserInfo> getUserInfoByUidEx(
      {required int uid, required RtcConnection connection});

  /// Enables or disables dual-stream mode on the sending end.
  ///
  /// Deprecated Deprecated: Deprecated since v4.2.0. Use setDualStreamModeEx instead. You can call this method on the sending end to enable or disable dual-stream mode. Dual-stream refers to high-quality and low-quality video streams:
  ///  High-quality stream: High resolution and high frame rate video stream.
  ///  Low-quality stream: Low resolution and low frame rate video stream. After enabling dual-stream mode, you can call setRemoteVideoStreamType on the receiving end to choose whether to receive the high-quality or low-quality stream. This method applies to all types of streams sent by the sender, including but not limited to camera-captured video, screen sharing, and custom-captured video.
  ///
  /// * [enabled] Whether to enable dual-stream mode: true : Enable dual-stream mode. false : (Default) Disable dual-stream mode.
  /// * [streamConfig] Configuration for the low-quality stream. See SimulcastStreamConfig. When mode is set to disableSimulcastStream, setting streamConfig has no effect.
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> enableDualStreamModeEx(
      {required bool enabled,
      required SimulcastStreamConfig streamConfig,
      required RtcConnection connection});

  /// Sets the dual-stream mode on the sender side.
  ///
  /// By default, the SDK enables the small stream adaptive mode (autoSimulcastStream) on the sender side, meaning the sender does not actively send the low-quality stream. The receiver with host role can call setRemoteVideoStreamTypeEx to request the low-quality stream, and the sender starts sending it upon receiving the request.
  ///  If you want to change this behavior, you can call this method and set mode to disableSimulcastStream (never send low-quality stream) or enableSimulcastStream (always send low-quality stream).
  ///  If you want to restore the default behavior after making changes, call this method again and set mode to autoSimulcastStream. The differences and relations between this method and enableDualStreamModeEx are as follows:
  ///  Calling this method with mode set to disableSimulcastStream has the same effect as enableDualStreamModeEx(false).
  ///  Calling this method with mode set to enableSimulcastStream has the same effect as enableDualStreamModeEx(true).
  ///  Both methods can be called before or after joining a channel. If both are used, the settings in the method called later take effect.
  ///
  /// * [mode] The mode for sending video streams. See SimulcastStreamMode.
  /// * [streamConfig] Configuration of the low-quality video stream. See SimulcastStreamConfig. When mode is set to disableSimulcastStream, setting streamConfig has no effect.
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setDualStreamModeEx(
      {required SimulcastStreamMode mode,
      required SimulcastStreamConfig streamConfig,
      required RtcConnection connection});

  /// @nodoc
  Future<void> setSimulcastConfigEx(
      {required SimulcastConfig simulcastConfig,
      required RtcConnection connection});

  /// @nodoc
  Future<void> setHighPriorityUserListEx(
      {required List<int> uidList,
      required int uidNum,
      required StreamFallbackOptions option,
      required RtcConnection connection});

  /// Takes a video snapshot using the connection ID.
  ///
  /// This method takes a snapshot of the specified user's video stream, generates a JPG image, and saves it to the specified path.
  ///  This method is asynchronous. When the call returns, the SDK has not actually captured the snapshot.
  ///  When used for local video snapshot, it captures the video stream specified in ChannelMediaOptions.
  ///  If the user's video has undergone preprocessing, such as watermarking or beautification, the snapshot will include these effects.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [uid] User ID. Set to 0 to capture the local user's video.
  /// * [filePath] Make sure the directory exists and is writable. The local path to save the snapshot. The path must include the file name and format, for example:
  ///  Windows: C:\Users\<user_name>\AppData\Local\Agora\<process_name>\example.jpg
  ///  iOS: /App Sandbox/Library/Caches/example.jpg
  ///  macOS: ～/Library/Logs/example.jpg
  ///  Android: /storage/emulated/0/Android/data/<package name>/files/example.jpg
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> takeSnapshotEx(
      {required RtcConnection connection,
      required int uid,
      required String filePath});

  /// Enables/disables local snapshot upload.
  ///
  /// This method can take and upload snapshots for multiple video streams. After enabling local snapshot upload, the SDK takes and uploads snapshots of the video sent by the local user based on the module type and frequency set in ContentInspectConfig. After the snapshot is completed, the Agora server sends a callback notification to your server via HTTPS request and uploads all snapshots to your specified third-party cloud storage. Before calling this method, please [contact technical support](https://www.agora.io/cn/contact/) to enable the local snapshot upload service.
  ///
  /// * [enabled] Sets whether to enable local snapshot upload: true : Enable local snapshot upload. false : Disable local snapshot upload.
  /// * [config] Local snapshot upload configuration. See ContentInspectConfig.
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> enableContentInspectEx(
      {required bool enabled,
      required ContentInspectConfig config,
      required RtcConnection connection});

  /// Starts video frame rendering tracing.
  ///
  /// After this method is successfully called, the SDK uses the time of the call as the starting point and reports information related to video frame rendering through the onVideoRenderingTracingResult callback.
  ///  If you do not call this method, the SDK uses the time of calling joinChannel to join the channel as the starting point to begin tracing video rendering events automatically. You can call this method at an appropriate time based on your actual business scenario to customize the tracing.
  ///  After leaving the current channel, the SDK automatically resets the starting point to the time of the next channel join.
  ///
  /// * [connection] Connection information. See RtcConnection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> startMediaRenderingTracingEx(RtcConnection connection);

  /// @nodoc
  Future<void> setParametersEx(
      {required RtcConnection connection, required String parameters});

  /// Gets the call ID using the connection ID.
  ///
  /// Each time the client joins a channel, a corresponding callId is generated to identify the current call. You can call this method to get the callId parameter, and then pass it in when calling methods such as rate and complain.
  ///
  /// * [connection] Connection information. See RtcConnection.
  Future<String> getCallIdEx(RtcConnection connection);

  /// @nodoc
  Future<void> sendAudioMetadataEx(
      {required RtcConnection connection,
      required Uint8List metadata,
      required int length});

  /// @nodoc
  Future<void> enableVideoImageSourceEx(
      {required bool enable,
      required ImageTrackOptions options,
      required RtcConnection connection});

  /// Preloads the specified audio effect into the channel.
  ///
  /// Since Available since v6.6.2. Each time you call this method, only one audio effect file can be preloaded into memory. To preload multiple audio effect files, call this method multiple times. After preloading, you can call playEffect to play the preloaded audio effect, or call playAllEffects to play all preloaded audio effects.
  ///  To ensure smooth usage, the size of the audio effect file should not exceed the limit.
  ///  Agora recommends calling this method before joining the channel.
  ///  If you call preloadEffectEx before playEffectEx, the file resource is not released after playEffectEx is executed. The next time you call playEffectEx, it will start playing from the beginning.
  ///  If you do not call preloadEffectEx before playEffectEx, the resource is destroyed after playEffectEx is executed. The next time you call playEffectEx, it will attempt to reopen the file and play from the beginning.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [soundId] Audio effect ID.
  /// * [filePath] The absolute path of a local file or the URL of an online file. Supported audio formats include: mp3, mp4, m4a, aac, 3gp, mkv, and wav.
  /// * [startPos] The start position for playing the audio effect file, in milliseconds.
  ///
  /// Returns
  /// 0: Success.
  ///  < 0: Failure.
  Future<void> preloadEffectEx(
      {required RtcConnection connection,
      required int soundId,
      required String filePath,
      int startPos = 0});

  /// Plays the specified audio effect in the channel.
  ///
  /// Since Available since v6.6.2. You can call this method to play a specified audio effect to all users in the channel. Each call plays only one audio effect. To play multiple audio effects simultaneously, call this method multiple times with different soundId and filePath. You can also set whether to publish the audio effect in the channel.
  ///  Agora recommends not playing more than three audio effects simultaneously.
  ///  The audio effect ID and file path in this method must match those in the preloadEffectEx method.
  ///  If preloadEffectEx is called before playEffectEx, the file resource is not released after playEffectEx is executed. The next time you call playEffectEx, it will start playing from the beginning.
  ///  If preloadEffectEx is not called before playEffectEx, the resource is destroyed after playEffectEx is executed. The next time you call playEffectEx, it will attempt to reopen the file and play from the beginning.
  ///
  /// * [connection] RtcConnection object. See RtcConnection.
  /// * [soundId] Audio effect ID.
  /// * [filePath] The absolute path of a local file or the URL of an online file. Supported audio formats include mp3, mp4, m4a, aac, 3gp, mkv, and wav.
  /// * [loopCount] The number of times the audio effect is played: -1 : Loops indefinitely until stopEffect or stopAllEffects is called. 0 : Plays once. 1 : Plays twice.
  /// * [pitch] The pitch of the audio effect. The range is 0.5 to 2.0. The default value is 1.0 (original pitch). The smaller the value, the lower the pitch.
  /// * [pan] The spatial position of the audio effect. The range is -1.0 to 1.0: -1.0 : Audio effect comes from the user's left. 0.0 : Audio effect comes from the front. 1.0 : Audio effect comes from the user's right.
  /// * [gain] The volume of the audio effect. The range is 0 to 100. The default value is 100 (original volume). The smaller the value, the lower the volume.
  /// * [publish] Whether to publish the audio effect in the channel: true : Publishes the audio effect in the channel. false : (Default) Does not publish the audio effect in the channel.
  /// * [startPos] The start position for playing the audio effect file, in milliseconds.
  ///
  /// Returns
  /// 0: Success.
  ///  < 0: Failure.
  Future<void> playEffectEx(
      {required RtcConnection connection,
      required int soundId,
      required String filePath,
      required int loopCount,
      required double pitch,
      required double pan,
      required int gain,
      bool publish = false,
      int startPos = 0});

  /// Takes a video snapshot at the specified observation point using the connection ID.
  ///
  /// This method takes a snapshot of the specified user's video stream, generates a JPG image, and saves it to the specified path.
  ///  This method is asynchronous. When the call returns, the SDK has not actually captured the snapshot.
  ///  When used for local video snapshot, it captures the video stream specified in ChannelMediaOptions.
  ///  If the user's video has undergone preprocessing, such as watermarking or beautification, the snapshot will include these effects.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [uid] User ID. Set to 0 to capture the local user's video.
  /// * [config] Snapshot configuration. See SnapshotConfig.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> takeSnapshotWithConfigEx(
      {required RtcConnection connection,
      required int uid,
      required SnapshotConfig config});
}
