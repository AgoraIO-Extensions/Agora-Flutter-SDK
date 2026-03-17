import 'package:agora_rtc_engine/src/_serializable.dart';
import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_spatial_audio.g.dart';

/// Spatial position information of the remote user or media player.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RemoteVoicePositionInfo implements AgoraSerializable {
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

  @override
  Map<String, dynamic> toJson() => _$RemoteVoicePositionInfoToJson(this);
}

/// Sound insulation zone settings.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SpatialAudioZone implements AgoraSerializable {
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

  @override
  Map<String, dynamic> toJson() => _$SpatialAudioZoneToJson(this);
}

/// This class calculates user coordinates through the SDK to implement spatial audio.
///
/// This class inherits from BaseSpatialAudioEngine. Before calling other APIs under this class, you need to call the initialize method to initialize it.
abstract class LocalSpatialAudioEngine {
  /// @nodoc
  Future<void> release();

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

  /// @nodoc
  Future<void> clearRemotePositionsEx(RtcConnection connection);

  /// @nodoc
  Future<void> updateSelfPositionEx(
      {required List<double> position,
      required List<double> axisForward,
      required List<double> axisRight,
      required List<double> axisUp,
      required RtcConnection connection});

  /// @nodoc
  Future<void> setMaxAudioRecvCount(int maxCount);

  /// @nodoc
  Future<void> setAudioRecvRange(double range);

  /// @nodoc
  Future<void> setDistanceUnit(double unit);

  /// @nodoc
  Future<void> updateSelfPosition(
      {required List<double> position,
      required List<double> axisForward,
      required List<double> axisRight,
      required List<double> axisUp});

  /// @nodoc
  Future<void> updatePlayerPositionInfo(
      {required int playerId, required RemoteVoicePositionInfo positionInfo});

  /// @nodoc
  Future<void> setParameters(String params);

  /// @nodoc
  Future<void> muteLocalAudioStream(bool mute);

  /// @nodoc
  Future<void> muteAllRemoteAudioStreams(bool mute);

  /// @nodoc
  Future<void> muteRemoteAudioStream({required int uid, required bool mute});

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

  /// @nodoc
  Future<void> setZones(
      {required List<SpatialAudioZone> zones, required int zoneCount});

  /// @nodoc
  Future<void> setPlayerAttenuation(
      {required int playerId,
      required double attenuation,
      required bool forceSet});

  /// Deletes the spatial position information of all remote users.
  ///
  /// After this method is successfully called, the local user will no longer hear any remote users.
  /// After leaving the channel, you can also call this method to delete all remote users' spatial position information to avoid wasting computing resources.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> clearRemotePositions();
}
