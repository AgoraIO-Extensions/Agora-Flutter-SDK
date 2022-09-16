import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_rtc_engine_ex.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RtcConnection {
  const RtcConnection({this.channelId, this.localUid});

  @JsonKey(name: 'channelId')
  final String? channelId;

  @JsonKey(name: 'localUid')
  final int? localUid;
  factory RtcConnection.fromJson(Map<String, dynamic> json) =>
      _$RtcConnectionFromJson(json);
  Map<String, dynamic> toJson() => _$RtcConnectionToJson(this);
}

abstract class RtcEngineEx implements RtcEngine {
  Future<void> joinChannelEx(
      {required String token,
      required RtcConnection connection,
      required ChannelMediaOptions options});

  Future<void> leaveChannelEx(RtcConnection connection);

  Future<void> updateChannelMediaOptionsEx(
      {required ChannelMediaOptions options,
      required RtcConnection connection});

  Future<void> setVideoEncoderConfigurationEx(
      {required VideoEncoderConfiguration config,
      required RtcConnection connection});

  Future<void> setupRemoteVideoEx(
      {required VideoCanvas canvas, required RtcConnection connection});

  Future<void> muteRemoteAudioStreamEx(
      {required int uid,
      required bool mute,
      required RtcConnection connection});

  Future<void> muteRemoteVideoStreamEx(
      {required int uid,
      required bool mute,
      required RtcConnection connection});

  Future<void> setRemoteVideoStreamTypeEx(
      {required int uid,
      required VideoStreamType streamType,
      required RtcConnection connection});

  Future<void> setSubscribeAudioBlacklistEx(
      {required List<int> uidList,
      required int uidNumber,
      required RtcConnection connection});

  Future<void> setSubscribeAudioWhitelistEx(
      {required List<int> uidList,
      required int uidNumber,
      required RtcConnection connection});

  Future<void> setSubscribeVideoBlacklistEx(
      {required List<int> uidList,
      required int uidNumber,
      required RtcConnection connection});

  Future<void> setSubscribeVideoWhitelistEx(
      {required List<int> uidList,
      required int uidNumber,
      required RtcConnection connection});

  Future<void> setRemoteVideoSubscriptionOptionsEx(
      {required int uid,
      required VideoSubscriptionOptions options,
      required RtcConnection connection});

  Future<void> setRemoteVoicePositionEx(
      {required int uid,
      required double pan,
      required double gain,
      required RtcConnection connection});

  Future<void> setRemoteUserSpatialAudioParamsEx(
      {required int uid,
      required SpatialAudioParams params,
      required RtcConnection connection});

  Future<void> setRemoteRenderModeEx(
      {required int uid,
      required RenderModeType renderMode,
      required VideoMirrorModeType mirrorMode,
      required RtcConnection connection});

  Future<void> enableLoopbackRecordingEx(
      {required RtcConnection connection,
      required bool enabled,
      String? deviceName});

  Future<ConnectionStateType> getConnectionStateEx(RtcConnection connection);

  Future<void> enableEncryptionEx(
      {required RtcConnection connection,
      required bool enabled,
      required EncryptionConfig config});

  Future<void> sendStreamMessageEx(
      {required int streamId,
      required Uint8List data,
      required int length,
      required RtcConnection connection});

  Future<void> addVideoWatermarkEx(
      {required String watermarkUrl,
      required WatermarkOptions options,
      required RtcConnection connection});

  Future<void> clearVideoWatermarkEx(RtcConnection connection);

  Future<void> sendCustomReportMessageEx(
      {required String id,
      required String category,
      required String event,
      required String label,
      required int value,
      required RtcConnection connection});

  Future<void> enableAudioVolumeIndicationEx(
      {required int interval,
      required int smooth,
      required bool reportVad,
      required RtcConnection connection});

  Future<UserInfo> getUserInfoByUserAccountEx(
      {required String userAccount, required RtcConnection connection});

  Future<UserInfo> getUserInfoByUidEx(
      {required int uid, required RtcConnection connection});

  Future<void> setVideoProfileEx(
      {required int width,
      required int height,
      required int frameRate,
      required int bitrate});

  Future<void> enableDualStreamModeEx(
      {required VideoSourceType sourceType,
      required bool enabled,
      required SimulcastStreamConfig streamConfig,
      required RtcConnection connection});

  Future<void> setDualStreamModeEx(
      {required VideoSourceType sourceType,
      required SimulcastStreamMode mode,
      required SimulcastStreamConfig streamConfig,
      required RtcConnection connection});

  Future<void> enableWirelessAccelerate(bool enabled);

  Future<void> takeSnapshotEx(
      {required RtcConnection connection,
      required int uid,
      required String filePath});

  Future<int> createDataStreamEx(
      {required DataStreamConfig config, required RtcConnection connection});
}
