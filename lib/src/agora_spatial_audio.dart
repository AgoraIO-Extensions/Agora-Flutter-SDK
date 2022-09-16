import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_spatial_audio.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RemoteVoicePositionInfo {
  const RemoteVoicePositionInfo({this.position, this.forward});

  @JsonKey(name: 'position')
  final List<double>? position;

  @JsonKey(name: 'forward')
  final List<double>? forward;
  factory RemoteVoicePositionInfo.fromJson(Map<String, dynamic> json) =>
      _$RemoteVoicePositionInfoFromJson(json);
  Map<String, dynamic> toJson() => _$RemoteVoicePositionInfoToJson(this);
}

abstract class BaseSpatialAudioEngine {
  Future<void> release();

  Future<void> setMaxAudioRecvCount(int maxCount);

  Future<void> setAudioRecvRange(double range);

  Future<void> setDistanceUnit(double unit);

  Future<void> updateSelfPosition(
      {required List<double> position,
      required List<double> axisForward,
      required List<double> axisRight,
      required List<double> axisUp});

  Future<void> updateSelfPositionEx(
      {required List<double> position,
      required List<double> axisForward,
      required List<double> axisRight,
      required List<double> axisUp,
      required RtcConnection connection});

  Future<void> updatePlayerPositionInfo(
      {required int playerId, required RemoteVoicePositionInfo positionInfo});

  Future<void> setParameters(String params);

  Future<void> muteLocalAudioStream(bool mute);

  Future<void> muteAllRemoteAudioStreams(bool mute);
}

abstract class LocalSpatialAudioEngine implements BaseSpatialAudioEngine {
  Future<void> initialize();

  Future<void> updateRemotePosition(
      {required int uid, required RemoteVoicePositionInfo posInfo});

  Future<void> updateRemotePositionEx(
      {required int uid,
      required RemoteVoicePositionInfo posInfo,
      required RtcConnection connection});

  Future<void> removeRemotePosition(int uid);

  Future<void> removeRemotePositionEx(
      {required int uid, required RtcConnection connection});

  Future<void> clearRemotePositions();

  Future<void> clearRemotePositionsEx(RtcConnection connection);
}
