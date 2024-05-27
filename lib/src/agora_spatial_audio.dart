import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_spatial_audio.g.dart';

/// The spatial position of the remote user or the media player.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RemoteVoicePositionInfo {
  /// @nodoc
  const RemoteVoicePositionInfo({this.position, this.forward});

  /// @nodoc
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

/// Sound insulation area settings.
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

  /// The ID of the sound insulation area.
  @JsonKey(name: 'zoneSetId')
  final int? zoneSetId;

  /// The spatial center point of the sound insulation area. This parameter is an array of length 3, and the three values represent the front, right, and top coordinates in turn.
  @JsonKey(name: 'position')
  final List<double>? position;

  /// Starting at position, the forward unit vector. This parameter is an array of length 3, and the three values represent the front, right, and top coordinates in turn.
  @JsonKey(name: 'forward')
  final List<double>? forward;

  /// Starting at position, the right unit vector. This parameter is an array of length 3, and the three values represent the front, right, and top coordinates in turn.
  @JsonKey(name: 'right')
  final List<double>? right;

  /// Starting at position, the up unit vector. This parameter is an array of length 3, and the three values represent the front, right, and top coordinates in turn.
  @JsonKey(name: 'up')
  final List<double>? up;

  /// The entire sound insulation area is regarded as a cube; this represents the length of the forward side in the unit length of the game engine.
  @JsonKey(name: 'forwardLength')
  final double? forwardLength;

  /// The entire sound insulation area is regarded as a cube; this represents the length of the right side in the unit length of the game engine.
  @JsonKey(name: 'rightLength')
  final double? rightLength;

  /// The entire sound insulation area is regarded as a cube; this represents the length of the up side in the unit length of the game engine.
  @JsonKey(name: 'upLength')
  final double? upLength;

  /// The sound attenuation coefficient when users within the sound insulation area communicate with external users. The value range is [0,1]. The values are as follows:
  ///  0: Broadcast mode, where the volume and timbre are not attenuated with distance, and the volume and timbre heard by local users do not change regardless of distance.
  ///  (0,0.5): Weak attenuation mode, that is, the volume and timbre are only weakly attenuated during the propagation process, and the sound can travel farther than the real environment.
  ///  0.5: (Default) simulates the attenuation of the volume in the real environment; the effect is equivalent to not setting the audioAttenuation parameter.
  ///  (0.5,1]: Strong attenuation mode (default value is 1), that is, the volume and timbre attenuate rapidly during propagation.
  @JsonKey(name: 'audioAttenuation')
  final double? audioAttenuation;

  /// @nodoc
  factory SpatialAudioZone.fromJson(Map<String, dynamic> json) =>
      _$SpatialAudioZoneFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$SpatialAudioZoneToJson(this);
}

/// This class calculates user positions through the SDK to implement the spatial audio effect.
///
/// This class inherits from BaseSpatialAudioEngine. Before calling other APIs in this class, you need to call the initialize method to initialize this class.
abstract class LocalSpatialAudioEngine {
  /// @nodoc
  Future<void> release();

  /// Initializes LocalSpatialAudioEngine.
  ///
  /// Before calling other methods of the LocalSpatialAudioEngine class, you need to call this method to initialize LocalSpatialAudioEngine.
  ///  The SDK supports creating only one LocalSpatialAudioEngine instance for an app.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> initialize();

  /// Updates the spatial position of the specified remote user.
  ///
  /// After successfully calling this method, the SDK calculates the spatial audio parameters based on the relative position of the local and remote user. Call this method after the or joinChannel method.
  ///
  /// * [uid] The user ID. This parameter must be the same as the user ID passed in when the user joined the channel.
  /// * [posInfo] The spatial position of the remote user. See RemoteVoicePositionInfo.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> updateRemotePosition(
      {required int uid, required RemoteVoicePositionInfo posInfo});

  /// @nodoc
  Future<void> updateRemotePositionEx(
      {required int uid,
      required RemoteVoicePositionInfo posInfo,
      required RtcConnection connection});

  /// Removes the spatial position of the specified remote user.
  ///
  /// After successfully calling this method, the local user no longer hears the specified remote user. After leaving the channel, to avoid wasting computing resources, call this method to delete the spatial position information of the specified remote user. Otherwise, the user's spatial position information will be saved continuously. When the number of remote users exceeds the number of audio streams that can be received as set in setMaxAudioRecvCount, the system automatically unsubscribes from the audio stream of the user who is furthest away based on relative distance.
  ///
  /// * [uid] The user ID. This parameter must be the same as the user ID passed in when the user joined the channel.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
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

  /// Sets the sound attenuation effect for the specified user.
  ///
  /// * [uid] The user ID. This parameter must be the same as the user ID passed in when the user joined the channel.
  /// * [attenuation] For the user's sound attenuation coefficient, the value range is [0,1]. The values are as follows:
  ///  0: Broadcast mode, where the volume and timbre are not attenuated with distance, and the volume and timbre heard by local users do not change regardless of distance.
  ///  (0,0.5): Weak attenuation mode, that is, the volume and timbre are only weakly attenuated during the propagation process, and the sound can travel farther than the real environment.
  ///  0.5: (Default) simulates the attenuation of the volume in the real environment; the effect is equivalent to not setting the speaker_attenuation parameter.
  ///  (0.5,1]: Strong attenuation mode, that is, the volume and timbre attenuate rapidly during the propagation process.
  /// * [forceSet] Whether to force the user's sound attenuation effect: true : Force attenuation to set the sound attenuation of the user. At this time, the attenuation coefficient of the sound insulation area set in the audioAttenuation of the SpatialAudioZone does not take effect for the user.
  ///  If the sound source and listener are inside and outside the sound isolation area, the sound attenuation effect is determined by the audioAttenuation in SpatialAudioZone.
  ///  If the sound source and the listener are in the same sound insulation area or outside the same sound insulation area, the sound attenuation effect is determined by attenuation in this method. false : Do not force attenuation to set the user's sound attenuation effect, as shown in the following two cases.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
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

  /// Removes the spatial positions of all remote users.
  ///
  /// After successfully calling this method, the local user no longer hears any remote users. After leaving the channel, to avoid wasting resources, you can also call this method to delete the spatial positions of all remote users.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> clearRemotePositions();
}
