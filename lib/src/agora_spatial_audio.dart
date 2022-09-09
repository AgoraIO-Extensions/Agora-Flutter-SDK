import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_spatial_audio.g.dart';

/// 远端用户或媒体播放器的空间位置信息。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RemoteVoicePositionInfo {
  /// @nodoc
  const RemoteVoicePositionInfo({this.position, this.forward});

  /// 在世界坐标系中的坐标。该参数是长度为 3 的数组，三个值依次表示前、右、上的坐标值。
  @JsonKey(name: 'position')
  final List<double>? position;

  /// 在世界坐标系前轴的单位向量。该参数是长度为 3 的数组，三个值依次表示前、右、上的坐标值。
  @JsonKey(name: 'forward')
  final List<double>? forward;

  /// @nodoc
  factory RemoteVoicePositionInfo.fromJson(Map<String, dynamic> json) =>
      _$RemoteVoicePositionInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RemoteVoicePositionInfoToJson(this);
}

/// 该类包含 LocalSpatialAudioEngine 类中的部分 API。
/// LocalSpatialAudioEngine 类继承自 BaseSpatialAudioEngine。
abstract class BaseSpatialAudioEngine {
  /// 销毁 BaseSpatialAudioEngine 。
  /// 该方法释放 BaseSpatialAudioEngine 下的所有资源。当用户不需要使用空间音效时，你可以调用该方法将资源释放出来用于其他操作。调用该方法后，你将无法再使用 BaseSpatialAudioEngine 下的任何 API。 该方法需要在 RtcEngine 的 release 方法前调用。
  Future<void> release();

  /// 设置音频接收范围内最多可接收的音频流数。
  /// 如果在音频接收范围内可接收的音频流数超过设置的值，则本地用户会接收音源距离较近的 maxCount 路音频。如果房间里有和本地用户属于同一队伍的用户，则本地用户会优先接收队员的音频。例如，当 maxCount 设为 3 时，如果房间里有 5 位远端用户，其中 2 位和本地用户属于同一队伍、3 位和本地用户属于不同队伍但在本地用户的音频接收范围内，则本地用户可以听到 2 位队友和 1 位离自己最近的不同队伍的用户。
  ///
  /// * [maxCount] 音频接收范围内最多可接收的音频流数。
  Future<void> setMaxAudioRecvCount(int maxCount);

  /// 设置本地用户的音频接收范围。
  /// 设置成功后，用户只能听见设置范围内或属于同一队伍的远端用户。你可以随时调用该方法更新音频的接收范围。
  ///
  /// * [range] 可接收音频的最大范围，单位为米。取值需大于 0。
  Future<void> setAudioRecvRange(double range);

  /// 设置游戏引擎单位距离的长度（米）。
  /// 游戏引擎里的距离单位是游戏引擎自定义的，而 Agora 空间音效算法的距离单位为米。默认情况下，SDK 会将每单位的游戏引擎距离换算为一米。你可以调用该方法，将游戏引擎里的单位距离换算为指定的米数。
  ///
  /// * [unit] 每单位游戏引擎距离转换后的米数，取值需大于 0.00。例如，将 unit 设为 2.00，表示每单位的游戏引擎距离等于 2 米。 该值越大，当远端用户远离本地用户时，本地用户听到的声音衰减速度越快。
  Future<void> setDistanceUnit(double unit);

  /// 更新本地用户的空间位置。
  /// 在 LocalSpatialAudioEngine 类下，该方法需要和 updateRemotePosition 搭配使用。SDK 会根据该方法和 updateRemotePosition 设置的参数计算本地和远端用户之间的相对位置，从而计算用户的空间音效参数。
  ///
  /// * [position] 在世界坐标系中的坐标。该参数是长度为 3 的数组，三个值依次表示前、右、上的坐标值。
  /// * [axisForward] 在世界坐标系前轴的单位向量。该参数是长度为 3 的数组，三个值依次表示前、右、上的坐标值。
  /// * [axisRight] 在世界坐标系右轴的单位向量。该参数是长度为 3 的数组，三个值依次表示前、右、上的坐标值。
  /// * [axisUp] 在世界坐标系上轴的单位向量。该参数是长度为 3 的数组，三个值依次表示前、右、上的坐标值。
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

  /// 更新媒体播放器的空间位置。
  /// 成功更新后，本地用户可以听到媒体播放器空间位置的变化。
  ///
  /// * [playerId] 媒体播放器 ID。
  /// * [positionInfo] 媒体播放器的空间位置信息。详见 RemoteVoicePositionInfo 。
  Future<void> updatePlayerPositionInfo(
      {required int playerId, required RemoteVoicePositionInfo positionInfo});

  /// @nodoc
  Future<void> setParameters(String params);

  /// 取消或恢复发布本地音频流。
  /// 该方法不影响音频采集状态，因为没有禁用音频采集设备。该方法需要在 joinChannel [2/2] 后调用。在使用空间音效时，如需设置是否发布本地音频流，Agora 推荐调用该方法替代 RtcEngine 的 muteLocalAudioStream 方法。
  ///
  /// * [mute] 是否取消发布本地音频流。
  ///  true: 取消发布本地音频流。false: 发布本地音频流。
  Future<void> muteLocalAudioStream(bool mute);

  /// 取消或恢复订阅所有远端用户的音频流。
  /// 成功调用该方法后，本地用户会取消或恢复订阅所有远端用户的音频流，包括在调用该方法后加入频道的用户的音频流。该方法需要在 joinChannel [2/2] 后调用。在使用空间音效时，如需设置是否订阅所有远端用户的音频流，Agora 推荐调用该方法替代 RtcEngine 的 muteAllRemoteAudioStreams 方法。
  ///
  /// * [mute] 是否取消订阅所有远端用户的音频流： true: 取消订阅所有远端用户的音频流。false: 订阅所有远端用户的音频流。
  Future<void> muteAllRemoteAudioStreams(bool mute);
}

/// 该类通过 SDK 计算用户坐标，实现空间音效。
/// 调用该类下其他 API 前，你需要调用 initialize 方法初始化该类。
abstract class LocalSpatialAudioEngine implements BaseSpatialAudioEngine {
  /// 初始化 LocalSpatialAudioEngine 。
  /// 在调用 LocalSpatialAudioEngine 类的其他方法前，你需要先调用该方法初始化 LocalSpatialAudioEngine。SDK 只支持每个 app 创建一个 LocalSpatialAudioEngine 实例。
  Future<void> initialize();

  /// 更新远端用户的空间位置信息。
  /// 成功调用该方法后，SDK 会根据本地和远端用户的相对位置计算空间音效参数。该方法需要在 joinChannel [2/2] 后调用。
  ///
  /// * [uid] 用户 ID。需与用户加入频道时填写的用户 ID 一致。
  /// * [posInfo] 远端用户的空间位置信息。详见 RemoteVoicePositionInfo 。
  Future<void> updateRemotePosition(
      {required int uid, required RemoteVoicePositionInfo posInfo});

  /// @nodoc
  Future<void> updateRemotePositionEx(
      {required int uid,
      required RemoteVoicePositionInfo posInfo,
      required RtcConnection connection});

  /// 删除指定远端用户的空间位置信息。
  /// 成功调用该方法后，本地用户将听不到指定的远端用户。离开频道后，为避免计算资源的浪费，你也可以调用该方法删除指定远端用户的空间位置信息。
  ///
  /// * [uid] 用户 ID。需与用户加入频道时填写的用户 ID 一致。
  Future<void> removeRemotePosition(int uid);

  /// @nodoc
  Future<void> removeRemotePositionEx(
      {required int uid, required RtcConnection connection});

  /// 删除所有远端用户的空间位置信息。
  /// 成功调用该方法后，本地用户将听不到所有远端用户。离开频道后，为避免计算资源的浪费，你也可以调用该方法删除所有远端用户的空间位置信息。
  Future<void> clearRemotePositions();

  /// @nodoc
  Future<void> clearRemotePositionsEx(RtcConnection connection);
}
