import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_spatial_audio.g.dart';

/// Spatial position information of the remote user or media player.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RemoteVoicePositionInfo {
  /// @nodoc
  const RemoteVoicePositionInfo({this.position, this.forward});

  /// Coordinates in the world coordinate system. This parameter is an array of length 3, where the three values represent the coordinates in the front, right, and up directions respectively.
  @JsonKey(name: 'position')
  final List<double>? position;

  /// @nodoc
  @JsonKey(name: 'forward')
  final List<double>? forward;

  /// @nodoc
  factory RemoteVoicePositionInfo.fromJson(Map<String, dynamic> json) =>
      _$RemoteVoicePositionInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RemoteVoicePositionInfoToJson(this);
}

/// Sound insulation zone settings.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SpatialAudioZone {
  /// @nodoc
  const SpatialAudioZone(
      {this.zoneSetId,
      this.position,
      this.forward,
      this.right,
      this.up,
      this.forwardLength,
      this.rightLength,
      this.upLength,
      this.audioAttenuation});

  /// ID of the sound insulation zone.
  @JsonKey(name: 'zoneSetId')
  final int? zoneSetId;

  /// The spatial center point of the sound insulation zone. This parameter is an array of length 3, representing the coordinates in the forward, right, and up directions.
  @JsonKey(name: 'position')
  final List<double>? position;

  /// Unit vector in the forward direction starting from position. This parameter is an array of length 3, representing the coordinates in the forward, right, and up directions.
  @JsonKey(name: 'forward')
  final List<double>? forward;

  /// Unit vector in the right direction starting from position. This parameter is an array of length 3, representing the coordinates in the forward, right, and up directions.
  @JsonKey(name: 'right')
  final List<double>? right;

  /// Unit vector in the upward direction starting from position. This parameter is an array of length 3, representing the coordinates in the forward, right, and up directions.
  @JsonKey(name: 'up')
  final List<double>? up;

  /// Assuming the sound insulation zone is a cube, this represents the length in the forward direction, in game engine units.
  @JsonKey(name: 'forwardLength')
  final double? forwardLength;

  /// Assuming the sound insulation zone is a cube, this represents the length in the right direction, in game engine units.
  @JsonKey(name: 'rightLength')
  final double? rightLength;

  /// Assuming the sound insulation zone is a cube, this represents the length in the upward direction, in game engine units.
  @JsonKey(name: 'upLength')
  final double? upLength;

  /// Sound attenuation coefficient when users inside and outside the sound insulation zone communicate. Value range: [0,1]:
  ///  0: Broadcast mode. Volume and timbre do not attenuate with distance.
  ///  (0,0.5): Weak attenuation. Slight attenuation of volume and timbre during transmission. Sound travels farther than in real environments.
  ///  0.5: Simulates real-world volume attenuation. Equivalent to not setting the audioAttenuation parameter.
  ///  (0.5,1]: Strong attenuation (default is 1). Rapid attenuation of volume and timbre during transmission.
  @JsonKey(name: 'audioAttenuation')
  final double? audioAttenuation;

  /// @nodoc
  factory SpatialAudioZone.fromJson(Map<String, dynamic> json) =>
      _$SpatialAudioZoneFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$SpatialAudioZoneToJson(this);
}

/// This class contains some APIs from the LocalSpatialAudioEngine class.
///
/// The LocalSpatialAudioEngine class inherits from BaseSpatialAudioEngine.
abstract class BaseSpatialAudioEngine {
  /// Destroys the BaseSpatialAudioEngine.
  ///
  /// This method releases all resources under BaseSpatialAudioEngine. When you no longer need to use spatial audio, you can call this method to release resources for other operations.
  /// After calling this method, you will no longer be able to use any API under BaseSpatialAudioEngine.
  Future<void> release();

  /// Sets the maximum number of audio streams that can be received within the audio reception range.
  ///
  /// If the number of audio streams that can be received within the audio reception range exceeds the set value, the local user will receive the maxCount audio streams from the closest audio sources.
  ///
  /// * [maxCount] The maximum number of audio streams that can be received within the audio reception range. The value must be ≤ 16. The default value is 10.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when it fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setMaxAudioRecvCount(int maxCount);

  /// Sets the audio receive range for the local user.
  ///
  /// After setting successfully, the user can only hear remote users within the specified range or those in the same team. You can call this method at any time to update the audio receive range.
  ///
  /// * [range] Maximum range for receiving audio, in the distance unit used by the game engine. The value must be greater than 0. The default is 20.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setAudioRecvRange(double range);

  /// Sets the length (in meters) of one unit of distance in the game engine.
  ///
  /// The distance unit in the game engine is defined by the game engine itself, while the distance unit of the Agora spatial audio algorithm is in meters. By default, the SDK converts each unit of game engine distance to one meter. You can call this method to convert one unit of game engine distance to a specified number of meters.
  ///
  /// * [unit] The number of meters corresponding to one unit of game engine distance. The value must be greater than 0.00. The default is 1.00. For example, setting unit to 2.00 means one unit of game engine distance equals 2 meters.
  /// The larger the value, the faster the sound attenuation when the remote user moves away from the local user.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setDistanceUnit(double unit);

  /// Updates the local user's spatial position.
  ///
  /// Under the LocalSpatialAudioEngine class, this method needs to be used together with updateRemotePosition. The SDK calculates the relative position between the local and remote users based on the parameters set by this method and updateRemotePosition, and then calculates the spatial audio parameters.
  ///
  /// * [position] Coordinates in the world coordinate system. This parameter is an array of length 3, representing the coordinates in the forward, right, and up directions respectively.
  /// * [axisForward] Unit vector of the forward axis in the world coordinate system. This parameter is an array of length 3, representing the coordinates in the forward, right, and up directions respectively.
  /// * [axisRight] Unit vector of the right axis in the world coordinate system. This parameter is an array of length 3, representing the coordinates in the forward, right, and up directions respectively.
  /// * [axisUp] Unit vector of the up axis in the world coordinate system. This parameter is an array of length 3, representing the coordinates in the forward, right, and up directions respectively.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> updateSelfPosition(
      {required List<double> position,
      required List<double> axisForward,
      required List<double> axisRight,
      required List<double> axisUp});

  /// @nodoc
  Future<void> updateSelfPositionEx(
      {required List<double> position,
      required List<double> axisForward,
      required List<double> axisRight,
      required List<double> axisUp,
      required RtcConnection connection});

  /// Updates the spatial position of the media player.
  ///
  /// After a successful update, the local user can hear the spatial position changes of the media player.
  ///
  /// * [playerId] Media player ID.
  /// * [positionInfo] Spatial position information of the media player. See RemoteVoicePositionInfo.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> updatePlayerPositionInfo(
      {required int playerId, required RemoteVoicePositionInfo positionInfo});

  /// @nodoc
  Future<void> setParameters(String params);

  /// Stops or resumes publishing the local audio stream.
  ///
  /// This method does not affect the audio capture state, as it does not disable the audio capturing device.
  ///  You must call this method after joinChannel1 or joinChannel.
  ///  When using spatial audio, to set whether to publish the local audio stream, it is recommended to call this method instead of the muteLocalAudioStream method of RtcEngine.
  ///  After successfully calling this method, the remote side will trigger the onUserMuteAudio and onRemoteAudioStateChanged callbacks.
  ///
  /// * [mute] Whether to stop publishing the local audio stream: true : Stop publishing the local audio stream. false : Publish the local audio stream.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when it fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> muteLocalAudioStream(bool mute);

  /// Stops or resumes subscribing to all remote users' audio streams.
  ///
  /// After successfully calling this method, the local user will stop or resume subscribing to all remote users' audio streams, including those who join the channel after the method is called.
  ///  You must call this method after joinChannel.
  ///  When using spatial audio, to set whether to subscribe to all remote users' audio streams, it is recommended to call this method instead of the muteAllRemoteAudioStreams method of RtcEngine.
  ///  After calling this method, you need to call updateSelfPosition and updateRemotePosition to update the spatial positions of the local and remote users; otherwise, the settings in this method will not take effect.
  ///
  /// * [mute] Whether to stop subscribing to all remote users' audio streams: true : Stop subscribing to all remote users' audio streams. false : Subscribe to all remote users' audio streams.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when it fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> muteAllRemoteAudioStreams(bool mute);

  /// Sets sound insulation zones.
  ///
  /// In virtual interactive scenarios, you can use this method to set sound insulation zones and sound attenuation coefficients. When the audio source (which can be a user or media player) and the listener are in and out of the sound insulation zone respectively, the user experiences attenuation similar to how sound is blocked by structures in the real world.
  ///  When the audio source and listener are in and out of the sound insulation zone respectively, the attenuation effect is determined by the sound attenuation coefficient in SpatialAudioZone.
  ///  If the user or media player is within the same sound insulation zone, the attenuation effect is not affected by SpatialAudioZone and is instead determined by the attenuation parameter in setPlayerAttenuation or setRemoteAudioAttenuation. If neither method is called, the SDK defaults to an attenuation coefficient of 0.5, simulating real-world sound attenuation.
  ///  If the audio source and receiver are in different sound insulation zones, the receiver cannot hear the audio source. If this method is called multiple times, the most recent configuration of sound insulation zones takes effect.
  ///
  /// * [zones] Configuration of sound insulation zones. See SpatialAudioZone. Setting this parameter to NULL clears all sound insulation zones. On the Windows platform, ensure that the number of elements in the zones array matches the value of zoneCount, otherwise a crash may occur.
  /// * [zoneCount] The number of sound insulation zones.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when it fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setZones(
      {required List<SpatialAudioZone> zones, required int zoneCount});

  /// Sets the sound attenuation properties of the media player.
  ///
  /// * [playerId] Media player ID.
  /// * [attenuation] The sound attenuation coefficient of the media player, ranging from [0,1].
  ///  0: Broadcast mode, where volume and timbre do not attenuate with distance. The local user hears no change in volume or timbre regardless of distance.
  ///  (0,0.5): Weak attenuation mode, where volume and timbre attenuate slightly during propagation. Compared to the real world, sound can travel farther.
  ///  0.5: (Default) Simulates attenuation in a real environment. Equivalent to not setting the attenuation parameter.
  ///  (0.5,1]: Strong attenuation mode, where volume and timbre attenuate rapidly during propagation.
  /// * [forceSet] Whether to forcibly apply the attenuation effect to the media player: true : Forces the use of attenuation to set the media player's sound attenuation effect. In this case, the audioAttenuation value set in SpatialAudioZone has no effect on the media player. false : Does not forcibly apply attenuation to the media player. Behavior depends on the following:
  ///  If the audio source and listener are in and out of the sound insulation zone respectively, the attenuation effect is determined by audioAttenuation in SpatialAudioZone.
  ///  If the audio source and listener are both inside or both outside the same sound insulation zone, the attenuation effect is determined by the attenuation parameter in this method.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when it fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setPlayerAttenuation(
      {required int playerId,
      required double attenuation,
      required bool forceSet});

  /// Stops or resumes subscribing to the audio stream of a specified remote user.
  ///
  /// * [uid] The user ID. It must be the same as the user ID used when the user joins the channel.
  /// * [mute] Whether to stop subscribing to the specified remote user's audio stream: true : Stop subscribing to the specified user's audio stream. false : (Default) Subscribe to the specified user's audio stream. The SDK determines whether to subscribe based on the distance between the local and remote users.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when it fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> muteRemoteAudioStream({required int uid, required bool mute});
}

/// This class calculates user coordinates through the SDK to implement spatial audio.
///
/// This class inherits from BaseSpatialAudioEngine. Before calling other APIs under this class, you need to call the initialize method to initialize it.
abstract class LocalSpatialAudioEngine implements BaseSpatialAudioEngine {
  /// Initializes the LocalSpatialAudioEngine.
  ///
  /// You must call this method to initialize the LocalSpatialAudioEngine before calling other methods of the LocalSpatialAudioEngine class.
  ///  The SDK supports only one LocalSpatialAudioEngine instance per app.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when it fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> initialize();

  /// Updates the spatial position information of a remote user.
  ///
  /// After successfully calling this method, the SDK calculates spatial audio parameters based on the relative position of the local and remote users. You must call this method after joinChannel.
  ///
  /// * [uid] The user ID. It must be the same as the user ID used when the user joins the channel.
  /// * [posInfo] The spatial position information of the remote user. See RemoteVoicePositionInfo.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when it fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> updateRemotePosition(
      {required int uid, required RemoteVoicePositionInfo posInfo});

  /// @nodoc
  Future<void> updateRemotePositionEx(
      {required int uid,
      required RemoteVoicePositionInfo posInfo,
      required RtcConnection connection});

  /// Deletes the spatial position information of the specified remote user.
  ///
  /// After this method is successfully called, the local user will no longer hear the specified remote user.
  /// After leaving the channel, to avoid wasting computing resources, you need to call this method to delete the spatial position information of the specified remote user. Otherwise, the user's spatial position information will continue to be stored. When the number of remote users exceeds the number of audio streams set in setMaxAudioRecvCount, the SDK will automatically unsubscribe from the audio streams of the farthest users based on relative distance.
  ///
  /// * [uid] User ID. Must match the user ID used when joining the channel.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> removeRemotePosition(int uid);

  /// @nodoc
  Future<void> removeRemotePositionEx(
      {required int uid, required RtcConnection connection});

  /// Deletes the spatial position information of all remote users.
  ///
  /// After this method is successfully called, the local user will no longer hear any remote users.
  /// After leaving the channel, you can also call this method to delete all remote users' spatial position information to avoid wasting computing resources.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> clearRemotePositions();

  /// @nodoc
  Future<void> clearRemotePositionsEx(RtcConnection connection);

  /// Sets the sound attenuation effect for a specified user.
  ///
  /// * [uid] User ID. Must match the user ID used when joining the channel.
  /// * [attenuation] The sound attenuation coefficient for the specified user, ranging from [0,1].
  /// * [forceSet] Whether to forcibly apply the sound attenuation effect for the user: true : Forces the use of attenuation to set the user's sound attenuation effect. In this case, the audioAttenuation value set in SpatialAudioZone has no effect on this user. false : Does not forcibly apply attenuation to the user. Behavior depends on the following:
  ///  If the audio source and listener are in and out of the sound insulation zone respectively, the attenuation effect is determined by audioAttenuation in SpatialAudioZone.
  ///  If the audio source and listener are both inside or both outside the same sound insulation zone, the attenuation effect is determined by the attenuation parameter in this method.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when it fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setRemoteAudioAttenuation(
      {required int uid, required double attenuation, required bool forceSet});
}
