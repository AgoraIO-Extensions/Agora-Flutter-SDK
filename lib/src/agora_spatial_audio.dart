import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_spatial_audio.g.dart';

/// The spatial position of the remote user or the media player.
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RemoteVoicePositionInfo {
  /// @nodoc
  const RemoteVoicePositionInfo({this.position, this.forward});

  /// The coordinates in the world coordinate system. This parameter is an array of length 3, and the three values represent the front, right, and top coordinates in turn.
  @JsonKey(name: 'position')
  final List<double>? position;

  /// The unit vector of the x axis in the coordinate system. This parameter is an array of length 3, and the three values represent the front, right, and top coordinates in turn.
  @JsonKey(name: 'forward')
  final List<double>? forward;

  /// @nodoc
  factory RemoteVoicePositionInfo.fromJson(Map<String, dynamic> json) =>
      _$RemoteVoicePositionInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RemoteVoicePositionInfoToJson(this);
}

/// 隔声区域的设置。
///
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

  /// 隔声区域的 ID。
  @JsonKey(name: 'zoneSetId')
  final int? zoneSetId;

  /// 隔声区域的空间中心点。该参数是长度为 3 的数组，三个值依次表示前、右、上的坐标值。
  @JsonKey(name: 'position')
  final List<double>? position;

  /// 以 position 为起点，向前的单位向量。该参数是长度为 3 的数组，三个值依次表示前、右、上的坐标值。
  @JsonKey(name: 'forward')
  final List<double>? forward;

  /// 以 position 为起点，向右的单位向量。该参数是长度为 3 的数组，三个值依次表示前、右、上的坐标值。
  @JsonKey(name: 'right')
  final List<double>? right;

  /// 以 position 为起点，向上的单位向量。该参数是长度为 3 的数组，三个值依次表示前、右、上的坐标值。
  @JsonKey(name: 'up')
  final List<double>? up;

  /// 将整个隔声区域看做一个立方体，表示向前的边长，单位为游戏引擎的单位长度。
  @JsonKey(name: 'forwardLength')
  final double? forwardLength;

  /// 将整个隔声区域看做一个立方体，表示向右的边长，单位为游戏引擎的单位长度。
  @JsonKey(name: 'rightLength')
  final double? rightLength;

  /// 将整个隔声区域看做一个立方体，表示向上的边长，单位为游戏引擎的单位长度。
  @JsonKey(name: 'upLength')
  final double? upLength;

  /// 隔声区域以内的用户和外部用户互通时的声音衰减系数，取值范围为 [0,1]。其中： 0：广播模式，即音量和音色均不随距离衰减，无论距离远近，本地用户听到的音量和音色都无变化。(0,0.5)：弱衰减模式，即音量和音色在传播过程中仅发生微弱衰减，跟真实环境相比，声音可以传播得更远。0.5：模拟音量在真实环境下的衰减，效果等同于不设置 audioAttenuation 参数。(0.5,1]：强衰减模式 (默认值为 1) ，即音量和音色在传播过程中发生迅速衰减。
  @JsonKey(name: 'audioAttenuation')
  final double? audioAttenuation;

  /// @nodoc
  factory SpatialAudioZone.fromJson(Map<String, dynamic> json) =>
      _$SpatialAudioZoneFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$SpatialAudioZoneToJson(this);
}

/// This class contains some of the APIs in the LocalSpatialAudioEngine class.
/// The LocalSpatialAudioEngine class inherits from BaseSpatialAudioEngine.
abstract class BaseSpatialAudioEngine {
  /// Destroys BaseSpatialAudioEngine .
  /// This method releases all resources under BaseSpatialAudioEngine. When the user does not need to use the spatial audio effect, you can call this method to release resources for other operations.After calling this method, you can no longer use any of the APIs under BaseSpatialAudioEngine.Call this method before the release method under RtcEngine .
  Future<void> release();

  /// Sets the maximum number of streams that a user can receive in a specified audio reception range.
  /// If the number of receivable streams exceeds the set value, the local user receives the maxCount streams that are closest to the local user. If there are users who belong to the same team as the local user in the room, the local user receives the audio of the teammates first. For example, when maxCount is set to 3, if there are five remote users in the room, two of whom belong to the same team as the local user, and three of whom belong to different teams but are within the audio reception range of the local user, the local user can hear the two teammates and the one user from a different team closest to the local user.
  ///
  /// * [maxCount] The maximum number of streams that a user can receive within a specified audio reception range.
  Future<void> setMaxAudioRecvCount(int maxCount);

  /// Sets the audio reception range of the local user.
  /// After the setting is successful, the local user can only hear the remote users within the setting range or belonging to the same team. You can call this method at any time to update the audio reception range.
  ///
  /// * [range] The maximum audio reception range. The unit is meters. The value must be greater than 0.
  Future<void> setAudioRecvRange(double range);

  /// Sets the length (in meters) of the game engine distance per unit.
  /// In a game engine, the unit of distance is customized, while in the Agora spatial audio algorithm, distance is measured in meters. By default, the SDK converts the game engine distance per unit to one meter. You can call this method to convert the game engine distance per unit to a specified number of meters.
  ///
  /// * [unit] The number of meters that the game engine distance per unit is equal to. This parameter must be greater than 0.00. For example, setting unit as 2.00 means the game engine distance per unit equals 2 meters.The larger the value is, the faster the sound heard by the local user attenuates when the remote user moves far away from the local user.
  Future<void> setDistanceUnit(double unit);

  /// Updates the spatial position of the local user.
  /// Under the LocalSpatialAudioEngine class, this method needs to be used with updateRemotePosition . The SDK calculates the relative position between the local and remote users according to this method and the parameter settings in updateRemotePosition, and then calculates the user's spatial audio effect parameters.
  ///
  /// * [position] The coordinates in the world coordinate system. This parameter is an array of length 3, and the three values represent the front, right, and top coordinates in turn.
  /// * [axisForward] The unit vector of the x axis in the coordinate system. This parameter is an array of length 3, and the three values represent the front, right, and top coordinates in turn.
  /// * [axisRight] The unit vector of the y axis in the coordinate system. This parameter is an array of length 3, and the three values represent the front, right, and top coordinates in turn.
  /// * [axisUp] The unit vector of the z axis in the coordinate system. This parameter is an array of length 3, and the three values represent the front, right, and top coordinates in turn.
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
  /// After a successful update, the local user can hear the change in the spatial position of the media player.
  ///
  /// * [playerId] The ID of the media player.
  /// * [positionInfo] The spatial position of the media player. See RemoteVoicePositionInfo .
  Future<void> updatePlayerPositionInfo(
      {required int playerId, required RemoteVoicePositionInfo positionInfo});

  /// @nodoc
  Future<void> setParameters(String params);

  /// Stops or resumes publishing the local audio stream.
  /// This method does not affect any ongoing audio recording, because it does not disable the audio capture device.Call this method after joinChannel [2/2] .When using the spatial audio effect, if you need to set whether to publish the local audio stream, Agora recommends calling this method instead of the muteLocalAudioStream method under RtcEngine .
  ///
  /// * [mute] Whether to stop publishing the local audio stream.true: Stop publishing the local audio stream.false: Publish the local audio stream.
  Future<void> muteLocalAudioStream(bool mute);

  /// Stops or resumes subscribing to the audio streams of all remote users.
  /// After successfully calling this method, the local user stops or resumes subscribing to the audio streams of all remote users, including all subsequent users.Call this method after joinChannel [2/2] .When using the spatial audio effect, if you need to set whether to stop subscribing to the audio streams of all remote users, Agora recommends calling this method instead of the muteAllRemoteAudioStreams method under RtcEngine .After calling this method, you need to call updateSelfPosition and updateRemotePosition to update the spatial location of the local user and the remote user; otherwise, the settings in this method do not take effect.
  ///
  /// * [mute] Whether to stop subscribing to the audio streams of all remote users:true: Stop subscribing to the audio streams of all remote users.false: Subscribe to the audio streams of all remote users.
  Future<void> muteAllRemoteAudioStreams(bool mute);

  /// 设置隔声区域。
  /// 在虚拟互动场景下，你可以通过该方法设置隔声区域和声音衰减系数。当音源（可以为用户或媒体播放器）跟听声者分属于隔声区域区域内部和外部时，会体验到类似真实环境中声音在遇到建筑隔断时的衰减效果。当音源跟听声者分属于隔声区域区域内部和外部时，声音的衰减效果由 SpatialAudioZone 中的声音衰减系数决定。如果用户或媒体播放器同在一个隔声区域内，则不受 SpatialAudioZone 的影响，声音的衰减效果由 setPlayerAttenuation 或 setRemoteAudioAttenuation 中的 attenuation 参数决定。如果不调用 setPlayerAttenuation 或 setRemoteAudioAttenuation，则 SDK 默认声音的衰减系数为 0.5，即模拟声音在真实环境下的衰减。如果音源跟接收者分别属于两个隔声区域，则接收者无法听到音源。如果多次调用该方法，以最后一次设置的隔声区域为准。
  ///
  /// * [zones] 隔声区域的设置。详见 SpatialAudioZone。
  Future<void> setZones(
      {required SpatialAudioZone zones, required int zoneCount});

  /// 设置媒体播放器的声音衰减属性。
  ///
  ///
  /// * [playerId] 媒体播放器 ID。
  /// * [attenuation] 媒体播放器的声音衰减系数，取值范围为[0,1]。其中： 0：广播模式，即音量和音色均不随距离衰减，无论距离远近，本地用户听到的音量和音色都无变化。(0,0.5)：弱衰减模式，即音量和音色在传播过程中仅发生微弱衰减，跟真实环境相比，声音可以传播得更远。0.5：（默认）模拟音量在真实环境下的衰减，效果等同于不设置 attenuation 参数。(0.5,1]：强衰减模式，即音量和音色在传播过程中发生迅速衰减。
  /// * [forceSet] 是否强制设定媒体播放器的声音衰减效果： true：强制使用 attenuation 设置媒体播放器的声音衰减效果，此时 SpatialAudioZone 中的 audioAttenuation 中设置的隔声区域衰减系数对媒体播放器不生效。false：不强制使用 attenuation 设置媒体播放器的声音衰减效果，分为以下两种情况。 如果音源和听声者分属于隔声区域内部和外部，则声音衰减效果由 SpatialAudioZone 中的 audioAttenuation 决定。 如果音源和听声者在同一个隔声区域内或同在隔声区域外，则声音衰减效果由该方法中的 attenuation 决定。
  Future<void> setPlayerAttenuation(
      {required int playerId,
      required double attenuation,
      required bool forceSet});

  /// @nodoc
  Future<void> muteRemoteAudioStream({required int uid, required bool mute});
}

/// This class calculates user positions through the SDK to implement the spatial audio effect.
/// This class inherits from BaseSpatialAudioEngine . Before calling other APIs in this class, you need to call the initialize method to initialize this class.
abstract class LocalSpatialAudioEngine implements BaseSpatialAudioEngine {
  /// Initializes LocalSpatialAudioEngine .
  /// Before calling other methods of the LocalSpatialAudioEngine class, you need to call this method to initialize LocalSpatialAudioEngine.The SDK supports creating only one LocalSpatialAudioEngine instance for an app.
  Future<void> initialize();

  /// Updates the spatial position of the specified remote user.
  /// After successfully calling this method, the SDK calculates the spatial audio parameters based on the relative position of the local and remote user.Call this method after the joinChannel [2/2] method.
  ///
  /// * [uid] The user ID. This parameter must be the same as the user ID passed in when the user joined the channel.
  /// * [posInfo] The spatial position of the remote user. See RemoteVoicePositionInfo .
  Future<void> updateRemotePosition(
      {required int uid, required RemoteVoicePositionInfo posInfo});

  /// @nodoc
  Future<void> updateRemotePositionEx(
      {required int uid,
      required RemoteVoicePositionInfo posInfo,
      required RtcConnection connection});

  /// Removes the spatial position of the specified remote user.
  /// After successfully calling this method, the local user no longer hears the specified remote user.After leaving the channel, to avoid wasting resources, you can also call this method to delete the spatial position of the specified remote user.
  ///
  /// * [uid] The user ID. This parameter must be the same as the user ID passed in when the user joined the channel.
  Future<void> removeRemotePosition(int uid);

  /// @nodoc
  Future<void> removeRemotePositionEx(
      {required int uid, required RtcConnection connection});

  /// Removes the spatial positions of all remote users.
  /// After successfully calling this method, the local user no longer hears any remote users.After leaving the channel, to avoid wasting resources, you can also call this method to delete the spatial positions of all remote users.
  Future<void> clearRemotePositions();

  /// @nodoc
  Future<void> clearRemotePositionsEx(RtcConnection connection);

  /// @nodoc
  Future<void> setRemoteAudioAttenuation(
      {required int uid, required double attenuation, required bool forceSet});
}
