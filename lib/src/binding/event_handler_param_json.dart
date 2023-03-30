import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'event_handler_param_json.g.dart';

// ignore_for_file: public_member_api_docs, unused_local_variable, prefer_is_empty

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnJoinChannelSuccessJson {
  const RtcEngineEventHandlerOnJoinChannelSuccessJson(
      {this.connection, this.elapsed});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerOnJoinChannelSuccessJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnJoinChannelSuccessJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnJoinChannelSuccessJsonToJson(this);
}

extension RtcEngineEventHandlerOnJoinChannelSuccessJsonBufferExt
    on RtcEngineEventHandlerOnJoinChannelSuccessJson {
  RtcEngineEventHandlerOnJoinChannelSuccessJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnRejoinChannelSuccessJson {
  const RtcEngineEventHandlerOnRejoinChannelSuccessJson(
      {this.connection, this.elapsed});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerOnRejoinChannelSuccessJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnRejoinChannelSuccessJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnRejoinChannelSuccessJsonToJson(this);
}

extension RtcEngineEventHandlerOnRejoinChannelSuccessJsonBufferExt
    on RtcEngineEventHandlerOnRejoinChannelSuccessJson {
  RtcEngineEventHandlerOnRejoinChannelSuccessJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnProxyConnectedJson {
  const RtcEngineEventHandlerOnProxyConnectedJson(
      {this.channel,
      this.uid,
      this.proxyType,
      this.localProxyIp,
      this.elapsed});

  @JsonKey(name: 'channel')
  final String? channel;
  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'proxyType')
  final ProxyType? proxyType;
  @JsonKey(name: 'localProxyIp')
  final String? localProxyIp;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerOnProxyConnectedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnProxyConnectedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnProxyConnectedJsonToJson(this);
}

extension RtcEngineEventHandlerOnProxyConnectedJsonBufferExt
    on RtcEngineEventHandlerOnProxyConnectedJson {
  RtcEngineEventHandlerOnProxyConnectedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnErrorJson {
  const RtcEngineEventHandlerOnErrorJson({this.err, this.msg});

  @JsonKey(name: 'err')
  final ErrorCodeType? err;
  @JsonKey(name: 'msg')
  final String? msg;
  factory RtcEngineEventHandlerOnErrorJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnErrorJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnErrorJsonToJson(this);
}

extension RtcEngineEventHandlerOnErrorJsonBufferExt
    on RtcEngineEventHandlerOnErrorJson {
  RtcEngineEventHandlerOnErrorJson fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnAudioQualityJson {
  const RtcEngineEventHandlerOnAudioQualityJson(
      {this.connection, this.remoteUid, this.quality, this.delay, this.lost});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'quality')
  final QualityType? quality;
  @JsonKey(name: 'delay')
  final int? delay;
  @JsonKey(name: 'lost')
  final int? lost;
  factory RtcEngineEventHandlerOnAudioQualityJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnAudioQualityJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnAudioQualityJsonToJson(this);
}

extension RtcEngineEventHandlerOnAudioQualityJsonBufferExt
    on RtcEngineEventHandlerOnAudioQualityJson {
  RtcEngineEventHandlerOnAudioQualityJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnLastmileProbeResultJson {
  const RtcEngineEventHandlerOnLastmileProbeResultJson({this.result});

  @JsonKey(name: 'result')
  final LastmileProbeResult? result;
  factory RtcEngineEventHandlerOnLastmileProbeResultJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnLastmileProbeResultJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnLastmileProbeResultJsonToJson(this);
}

extension RtcEngineEventHandlerOnLastmileProbeResultJsonBufferExt
    on RtcEngineEventHandlerOnLastmileProbeResultJson {
  RtcEngineEventHandlerOnLastmileProbeResultJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnAudioVolumeIndicationJson {
  const RtcEngineEventHandlerOnAudioVolumeIndicationJson(
      {this.connection, this.speakers, this.speakerNumber, this.totalVolume});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'speakers')
  final List<AudioVolumeInfo>? speakers;
  @JsonKey(name: 'speakerNumber')
  final int? speakerNumber;
  @JsonKey(name: 'totalVolume')
  final int? totalVolume;
  factory RtcEngineEventHandlerOnAudioVolumeIndicationJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnAudioVolumeIndicationJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnAudioVolumeIndicationJsonToJson(this);
}

extension RtcEngineEventHandlerOnAudioVolumeIndicationJsonBufferExt
    on RtcEngineEventHandlerOnAudioVolumeIndicationJson {
  RtcEngineEventHandlerOnAudioVolumeIndicationJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnLeaveChannelJson {
  const RtcEngineEventHandlerOnLeaveChannelJson({this.connection, this.stats});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'stats')
  final RtcStats? stats;
  factory RtcEngineEventHandlerOnLeaveChannelJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnLeaveChannelJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnLeaveChannelJsonToJson(this);
}

extension RtcEngineEventHandlerOnLeaveChannelJsonBufferExt
    on RtcEngineEventHandlerOnLeaveChannelJson {
  RtcEngineEventHandlerOnLeaveChannelJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnRtcStatsJson {
  const RtcEngineEventHandlerOnRtcStatsJson({this.connection, this.stats});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'stats')
  final RtcStats? stats;
  factory RtcEngineEventHandlerOnRtcStatsJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnRtcStatsJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnRtcStatsJsonToJson(this);
}

extension RtcEngineEventHandlerOnRtcStatsJsonBufferExt
    on RtcEngineEventHandlerOnRtcStatsJson {
  RtcEngineEventHandlerOnRtcStatsJson fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnAudioDeviceStateChangedJson {
  const RtcEngineEventHandlerOnAudioDeviceStateChangedJson(
      {this.deviceId, this.deviceType, this.deviceState});

  @JsonKey(name: 'deviceId')
  final String? deviceId;
  @JsonKey(name: 'deviceType')
  final MediaDeviceType? deviceType;
  @JsonKey(name: 'deviceState')
  final MediaDeviceStateType? deviceState;
  factory RtcEngineEventHandlerOnAudioDeviceStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnAudioDeviceStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnAudioDeviceStateChangedJsonToJson(this);
}

extension RtcEngineEventHandlerOnAudioDeviceStateChangedJsonBufferExt
    on RtcEngineEventHandlerOnAudioDeviceStateChangedJson {
  RtcEngineEventHandlerOnAudioDeviceStateChangedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnAudioMixingPositionChangedJson {
  const RtcEngineEventHandlerOnAudioMixingPositionChangedJson({this.position});

  @JsonKey(name: 'position')
  final int? position;
  factory RtcEngineEventHandlerOnAudioMixingPositionChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnAudioMixingPositionChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnAudioMixingPositionChangedJsonToJson(this);
}

extension RtcEngineEventHandlerOnAudioMixingPositionChangedJsonBufferExt
    on RtcEngineEventHandlerOnAudioMixingPositionChangedJson {
  RtcEngineEventHandlerOnAudioMixingPositionChangedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnAudioMixingFinishedJson {
  const RtcEngineEventHandlerOnAudioMixingFinishedJson();

  factory RtcEngineEventHandlerOnAudioMixingFinishedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnAudioMixingFinishedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnAudioMixingFinishedJsonToJson(this);
}

extension RtcEngineEventHandlerOnAudioMixingFinishedJsonBufferExt
    on RtcEngineEventHandlerOnAudioMixingFinishedJson {
  RtcEngineEventHandlerOnAudioMixingFinishedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnAudioEffectFinishedJson {
  const RtcEngineEventHandlerOnAudioEffectFinishedJson({this.soundId});

  @JsonKey(name: 'soundId')
  final int? soundId;
  factory RtcEngineEventHandlerOnAudioEffectFinishedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnAudioEffectFinishedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnAudioEffectFinishedJsonToJson(this);
}

extension RtcEngineEventHandlerOnAudioEffectFinishedJsonBufferExt
    on RtcEngineEventHandlerOnAudioEffectFinishedJson {
  RtcEngineEventHandlerOnAudioEffectFinishedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnVideoDeviceStateChangedJson {
  const RtcEngineEventHandlerOnVideoDeviceStateChangedJson(
      {this.deviceId, this.deviceType, this.deviceState});

  @JsonKey(name: 'deviceId')
  final String? deviceId;
  @JsonKey(name: 'deviceType')
  final MediaDeviceType? deviceType;
  @JsonKey(name: 'deviceState')
  final MediaDeviceStateType? deviceState;
  factory RtcEngineEventHandlerOnVideoDeviceStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnVideoDeviceStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnVideoDeviceStateChangedJsonToJson(this);
}

extension RtcEngineEventHandlerOnVideoDeviceStateChangedJsonBufferExt
    on RtcEngineEventHandlerOnVideoDeviceStateChangedJson {
  RtcEngineEventHandlerOnVideoDeviceStateChangedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnNetworkQualityJson {
  const RtcEngineEventHandlerOnNetworkQualityJson(
      {this.connection, this.remoteUid, this.txQuality, this.rxQuality});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'txQuality')
  final QualityType? txQuality;
  @JsonKey(name: 'rxQuality')
  final QualityType? rxQuality;
  factory RtcEngineEventHandlerOnNetworkQualityJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnNetworkQualityJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnNetworkQualityJsonToJson(this);
}

extension RtcEngineEventHandlerOnNetworkQualityJsonBufferExt
    on RtcEngineEventHandlerOnNetworkQualityJson {
  RtcEngineEventHandlerOnNetworkQualityJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnIntraRequestReceivedJson {
  const RtcEngineEventHandlerOnIntraRequestReceivedJson({this.connection});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  factory RtcEngineEventHandlerOnIntraRequestReceivedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnIntraRequestReceivedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnIntraRequestReceivedJsonToJson(this);
}

extension RtcEngineEventHandlerOnIntraRequestReceivedJsonBufferExt
    on RtcEngineEventHandlerOnIntraRequestReceivedJson {
  RtcEngineEventHandlerOnIntraRequestReceivedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnUplinkNetworkInfoUpdatedJson {
  const RtcEngineEventHandlerOnUplinkNetworkInfoUpdatedJson({this.info});

  @JsonKey(name: 'info')
  final UplinkNetworkInfo? info;
  factory RtcEngineEventHandlerOnUplinkNetworkInfoUpdatedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnUplinkNetworkInfoUpdatedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnUplinkNetworkInfoUpdatedJsonToJson(this);
}

extension RtcEngineEventHandlerOnUplinkNetworkInfoUpdatedJsonBufferExt
    on RtcEngineEventHandlerOnUplinkNetworkInfoUpdatedJson {
  RtcEngineEventHandlerOnUplinkNetworkInfoUpdatedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnDownlinkNetworkInfoUpdatedJson {
  const RtcEngineEventHandlerOnDownlinkNetworkInfoUpdatedJson({this.info});

  @JsonKey(name: 'info')
  final DownlinkNetworkInfo? info;
  factory RtcEngineEventHandlerOnDownlinkNetworkInfoUpdatedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnDownlinkNetworkInfoUpdatedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnDownlinkNetworkInfoUpdatedJsonToJson(this);
}

extension RtcEngineEventHandlerOnDownlinkNetworkInfoUpdatedJsonBufferExt
    on RtcEngineEventHandlerOnDownlinkNetworkInfoUpdatedJson {
  RtcEngineEventHandlerOnDownlinkNetworkInfoUpdatedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnLastmileQualityJson {
  const RtcEngineEventHandlerOnLastmileQualityJson({this.quality});

  @JsonKey(name: 'quality')
  final QualityType? quality;
  factory RtcEngineEventHandlerOnLastmileQualityJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnLastmileQualityJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnLastmileQualityJsonToJson(this);
}

extension RtcEngineEventHandlerOnLastmileQualityJsonBufferExt
    on RtcEngineEventHandlerOnLastmileQualityJson {
  RtcEngineEventHandlerOnLastmileQualityJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnFirstLocalVideoFrameJson {
  const RtcEngineEventHandlerOnFirstLocalVideoFrameJson(
      {this.source, this.width, this.height, this.elapsed});

  @JsonKey(name: 'source')
  final VideoSourceType? source;
  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerOnFirstLocalVideoFrameJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnFirstLocalVideoFrameJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnFirstLocalVideoFrameJsonToJson(this);
}

extension RtcEngineEventHandlerOnFirstLocalVideoFrameJsonBufferExt
    on RtcEngineEventHandlerOnFirstLocalVideoFrameJson {
  RtcEngineEventHandlerOnFirstLocalVideoFrameJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJson {
  const RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJson(
      {this.connection, this.elapsed});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJsonToJson(this);
}

extension RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJsonBufferExt
    on RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJson {
  RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnFirstRemoteVideoDecodedJson {
  const RtcEngineEventHandlerOnFirstRemoteVideoDecodedJson(
      {this.connection, this.remoteUid, this.width, this.height, this.elapsed});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerOnFirstRemoteVideoDecodedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnFirstRemoteVideoDecodedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnFirstRemoteVideoDecodedJsonToJson(this);
}

extension RtcEngineEventHandlerOnFirstRemoteVideoDecodedJsonBufferExt
    on RtcEngineEventHandlerOnFirstRemoteVideoDecodedJson {
  RtcEngineEventHandlerOnFirstRemoteVideoDecodedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnVideoSizeChangedJson {
  const RtcEngineEventHandlerOnVideoSizeChangedJson(
      {this.connection,
      this.sourceType,
      this.uid,
      this.width,
      this.height,
      this.rotation});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'sourceType')
  final VideoSourceType? sourceType;
  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  @JsonKey(name: 'rotation')
  final int? rotation;
  factory RtcEngineEventHandlerOnVideoSizeChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnVideoSizeChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnVideoSizeChangedJsonToJson(this);
}

extension RtcEngineEventHandlerOnVideoSizeChangedJsonBufferExt
    on RtcEngineEventHandlerOnVideoSizeChangedJson {
  RtcEngineEventHandlerOnVideoSizeChangedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnLocalVideoStateChangedJson {
  const RtcEngineEventHandlerOnLocalVideoStateChangedJson(
      {this.source, this.state, this.error});

  @JsonKey(name: 'source')
  final VideoSourceType? source;
  @JsonKey(name: 'state')
  final LocalVideoStreamState? state;
  @JsonKey(name: 'error')
  final LocalVideoStreamError? error;
  factory RtcEngineEventHandlerOnLocalVideoStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnLocalVideoStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnLocalVideoStateChangedJsonToJson(this);
}

extension RtcEngineEventHandlerOnLocalVideoStateChangedJsonBufferExt
    on RtcEngineEventHandlerOnLocalVideoStateChangedJson {
  RtcEngineEventHandlerOnLocalVideoStateChangedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnRemoteVideoStateChangedJson {
  const RtcEngineEventHandlerOnRemoteVideoStateChangedJson(
      {this.connection, this.remoteUid, this.state, this.reason, this.elapsed});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'state')
  final RemoteVideoState? state;
  @JsonKey(name: 'reason')
  final RemoteVideoStateReason? reason;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerOnRemoteVideoStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnRemoteVideoStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnRemoteVideoStateChangedJsonToJson(this);
}

extension RtcEngineEventHandlerOnRemoteVideoStateChangedJsonBufferExt
    on RtcEngineEventHandlerOnRemoteVideoStateChangedJson {
  RtcEngineEventHandlerOnRemoteVideoStateChangedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnFirstRemoteVideoFrameJson {
  const RtcEngineEventHandlerOnFirstRemoteVideoFrameJson(
      {this.connection, this.remoteUid, this.width, this.height, this.elapsed});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerOnFirstRemoteVideoFrameJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnFirstRemoteVideoFrameJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnFirstRemoteVideoFrameJsonToJson(this);
}

extension RtcEngineEventHandlerOnFirstRemoteVideoFrameJsonBufferExt
    on RtcEngineEventHandlerOnFirstRemoteVideoFrameJson {
  RtcEngineEventHandlerOnFirstRemoteVideoFrameJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnUserJoinedJson {
  const RtcEngineEventHandlerOnUserJoinedJson(
      {this.connection, this.remoteUid, this.elapsed});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerOnUserJoinedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnUserJoinedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnUserJoinedJsonToJson(this);
}

extension RtcEngineEventHandlerOnUserJoinedJsonBufferExt
    on RtcEngineEventHandlerOnUserJoinedJson {
  RtcEngineEventHandlerOnUserJoinedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnUserOfflineJson {
  const RtcEngineEventHandlerOnUserOfflineJson(
      {this.connection, this.remoteUid, this.reason});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'reason')
  final UserOfflineReasonType? reason;
  factory RtcEngineEventHandlerOnUserOfflineJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnUserOfflineJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnUserOfflineJsonToJson(this);
}

extension RtcEngineEventHandlerOnUserOfflineJsonBufferExt
    on RtcEngineEventHandlerOnUserOfflineJson {
  RtcEngineEventHandlerOnUserOfflineJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnUserMuteAudioJson {
  const RtcEngineEventHandlerOnUserMuteAudioJson(
      {this.connection, this.remoteUid, this.muted});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'muted')
  final bool? muted;
  factory RtcEngineEventHandlerOnUserMuteAudioJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnUserMuteAudioJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnUserMuteAudioJsonToJson(this);
}

extension RtcEngineEventHandlerOnUserMuteAudioJsonBufferExt
    on RtcEngineEventHandlerOnUserMuteAudioJson {
  RtcEngineEventHandlerOnUserMuteAudioJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnUserMuteVideoJson {
  const RtcEngineEventHandlerOnUserMuteVideoJson(
      {this.connection, this.remoteUid, this.muted});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'muted')
  final bool? muted;
  factory RtcEngineEventHandlerOnUserMuteVideoJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnUserMuteVideoJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnUserMuteVideoJsonToJson(this);
}

extension RtcEngineEventHandlerOnUserMuteVideoJsonBufferExt
    on RtcEngineEventHandlerOnUserMuteVideoJson {
  RtcEngineEventHandlerOnUserMuteVideoJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnUserEnableVideoJson {
  const RtcEngineEventHandlerOnUserEnableVideoJson(
      {this.connection, this.remoteUid, this.enabled});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'enabled')
  final bool? enabled;
  factory RtcEngineEventHandlerOnUserEnableVideoJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnUserEnableVideoJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnUserEnableVideoJsonToJson(this);
}

extension RtcEngineEventHandlerOnUserEnableVideoJsonBufferExt
    on RtcEngineEventHandlerOnUserEnableVideoJson {
  RtcEngineEventHandlerOnUserEnableVideoJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnUserStateChangedJson {
  const RtcEngineEventHandlerOnUserStateChangedJson(
      {this.connection, this.remoteUid, this.state});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'state')
  final int? state;
  factory RtcEngineEventHandlerOnUserStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnUserStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnUserStateChangedJsonToJson(this);
}

extension RtcEngineEventHandlerOnUserStateChangedJsonBufferExt
    on RtcEngineEventHandlerOnUserStateChangedJson {
  RtcEngineEventHandlerOnUserStateChangedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnUserEnableLocalVideoJson {
  const RtcEngineEventHandlerOnUserEnableLocalVideoJson(
      {this.connection, this.remoteUid, this.enabled});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'enabled')
  final bool? enabled;
  factory RtcEngineEventHandlerOnUserEnableLocalVideoJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnUserEnableLocalVideoJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnUserEnableLocalVideoJsonToJson(this);
}

extension RtcEngineEventHandlerOnUserEnableLocalVideoJsonBufferExt
    on RtcEngineEventHandlerOnUserEnableLocalVideoJson {
  RtcEngineEventHandlerOnUserEnableLocalVideoJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnApiCallExecutedJson {
  const RtcEngineEventHandlerOnApiCallExecutedJson(
      {this.err, this.api, this.result});

  @JsonKey(name: 'err')
  final ErrorCodeType? err;
  @JsonKey(name: 'api')
  final String? api;
  @JsonKey(name: 'result')
  final String? result;
  factory RtcEngineEventHandlerOnApiCallExecutedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnApiCallExecutedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnApiCallExecutedJsonToJson(this);
}

extension RtcEngineEventHandlerOnApiCallExecutedJsonBufferExt
    on RtcEngineEventHandlerOnApiCallExecutedJson {
  RtcEngineEventHandlerOnApiCallExecutedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnLocalAudioStatsJson {
  const RtcEngineEventHandlerOnLocalAudioStatsJson(
      {this.connection, this.stats});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'stats')
  final LocalAudioStats? stats;
  factory RtcEngineEventHandlerOnLocalAudioStatsJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnLocalAudioStatsJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnLocalAudioStatsJsonToJson(this);
}

extension RtcEngineEventHandlerOnLocalAudioStatsJsonBufferExt
    on RtcEngineEventHandlerOnLocalAudioStatsJson {
  RtcEngineEventHandlerOnLocalAudioStatsJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnRemoteAudioStatsJson {
  const RtcEngineEventHandlerOnRemoteAudioStatsJson(
      {this.connection, this.stats});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'stats')
  final RemoteAudioStats? stats;
  factory RtcEngineEventHandlerOnRemoteAudioStatsJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnRemoteAudioStatsJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnRemoteAudioStatsJsonToJson(this);
}

extension RtcEngineEventHandlerOnRemoteAudioStatsJsonBufferExt
    on RtcEngineEventHandlerOnRemoteAudioStatsJson {
  RtcEngineEventHandlerOnRemoteAudioStatsJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnLocalVideoStatsJson {
  const RtcEngineEventHandlerOnLocalVideoStatsJson(
      {this.connection, this.stats});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'stats')
  final LocalVideoStats? stats;
  factory RtcEngineEventHandlerOnLocalVideoStatsJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnLocalVideoStatsJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnLocalVideoStatsJsonToJson(this);
}

extension RtcEngineEventHandlerOnLocalVideoStatsJsonBufferExt
    on RtcEngineEventHandlerOnLocalVideoStatsJson {
  RtcEngineEventHandlerOnLocalVideoStatsJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnRemoteVideoStatsJson {
  const RtcEngineEventHandlerOnRemoteVideoStatsJson(
      {this.connection, this.stats});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'stats')
  final RemoteVideoStats? stats;
  factory RtcEngineEventHandlerOnRemoteVideoStatsJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnRemoteVideoStatsJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnRemoteVideoStatsJsonToJson(this);
}

extension RtcEngineEventHandlerOnRemoteVideoStatsJsonBufferExt
    on RtcEngineEventHandlerOnRemoteVideoStatsJson {
  RtcEngineEventHandlerOnRemoteVideoStatsJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnCameraReadyJson {
  const RtcEngineEventHandlerOnCameraReadyJson();

  factory RtcEngineEventHandlerOnCameraReadyJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnCameraReadyJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnCameraReadyJsonToJson(this);
}

extension RtcEngineEventHandlerOnCameraReadyJsonBufferExt
    on RtcEngineEventHandlerOnCameraReadyJson {
  RtcEngineEventHandlerOnCameraReadyJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnCameraFocusAreaChangedJson {
  const RtcEngineEventHandlerOnCameraFocusAreaChangedJson(
      {this.x, this.y, this.width, this.height});

  @JsonKey(name: 'x')
  final int? x;
  @JsonKey(name: 'y')
  final int? y;
  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  factory RtcEngineEventHandlerOnCameraFocusAreaChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnCameraFocusAreaChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnCameraFocusAreaChangedJsonToJson(this);
}

extension RtcEngineEventHandlerOnCameraFocusAreaChangedJsonBufferExt
    on RtcEngineEventHandlerOnCameraFocusAreaChangedJson {
  RtcEngineEventHandlerOnCameraFocusAreaChangedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnCameraExposureAreaChangedJson {
  const RtcEngineEventHandlerOnCameraExposureAreaChangedJson(
      {this.x, this.y, this.width, this.height});

  @JsonKey(name: 'x')
  final int? x;
  @JsonKey(name: 'y')
  final int? y;
  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  factory RtcEngineEventHandlerOnCameraExposureAreaChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnCameraExposureAreaChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnCameraExposureAreaChangedJsonToJson(this);
}

extension RtcEngineEventHandlerOnCameraExposureAreaChangedJsonBufferExt
    on RtcEngineEventHandlerOnCameraExposureAreaChangedJson {
  RtcEngineEventHandlerOnCameraExposureAreaChangedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnFacePositionChangedJson {
  const RtcEngineEventHandlerOnFacePositionChangedJson(
      {this.imageWidth,
      this.imageHeight,
      this.vecRectangle,
      this.vecDistance,
      this.numFaces});

  @JsonKey(name: 'imageWidth')
  final int? imageWidth;
  @JsonKey(name: 'imageHeight')
  final int? imageHeight;
  @JsonKey(name: 'vecRectangle')
  final Rectangle? vecRectangle;
  @JsonKey(name: 'vecDistance')
  final int? vecDistance;
  @JsonKey(name: 'numFaces')
  final int? numFaces;
  factory RtcEngineEventHandlerOnFacePositionChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnFacePositionChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnFacePositionChangedJsonToJson(this);
}

extension RtcEngineEventHandlerOnFacePositionChangedJsonBufferExt
    on RtcEngineEventHandlerOnFacePositionChangedJson {
  RtcEngineEventHandlerOnFacePositionChangedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnVideoStoppedJson {
  const RtcEngineEventHandlerOnVideoStoppedJson();

  factory RtcEngineEventHandlerOnVideoStoppedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnVideoStoppedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnVideoStoppedJsonToJson(this);
}

extension RtcEngineEventHandlerOnVideoStoppedJsonBufferExt
    on RtcEngineEventHandlerOnVideoStoppedJson {
  RtcEngineEventHandlerOnVideoStoppedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnAudioMixingStateChangedJson {
  const RtcEngineEventHandlerOnAudioMixingStateChangedJson(
      {this.state, this.reason});

  @JsonKey(name: 'state')
  final AudioMixingStateType? state;
  @JsonKey(name: 'reason')
  final AudioMixingReasonType? reason;
  factory RtcEngineEventHandlerOnAudioMixingStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnAudioMixingStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnAudioMixingStateChangedJsonToJson(this);
}

extension RtcEngineEventHandlerOnAudioMixingStateChangedJsonBufferExt
    on RtcEngineEventHandlerOnAudioMixingStateChangedJson {
  RtcEngineEventHandlerOnAudioMixingStateChangedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnRhythmPlayerStateChangedJson {
  const RtcEngineEventHandlerOnRhythmPlayerStateChangedJson(
      {this.state, this.errorCode});

  @JsonKey(name: 'state')
  final RhythmPlayerStateType? state;
  @JsonKey(name: 'errorCode')
  final RhythmPlayerErrorType? errorCode;
  factory RtcEngineEventHandlerOnRhythmPlayerStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnRhythmPlayerStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnRhythmPlayerStateChangedJsonToJson(this);
}

extension RtcEngineEventHandlerOnRhythmPlayerStateChangedJsonBufferExt
    on RtcEngineEventHandlerOnRhythmPlayerStateChangedJson {
  RtcEngineEventHandlerOnRhythmPlayerStateChangedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnConnectionLostJson {
  const RtcEngineEventHandlerOnConnectionLostJson({this.connection});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  factory RtcEngineEventHandlerOnConnectionLostJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnConnectionLostJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnConnectionLostJsonToJson(this);
}

extension RtcEngineEventHandlerOnConnectionLostJsonBufferExt
    on RtcEngineEventHandlerOnConnectionLostJson {
  RtcEngineEventHandlerOnConnectionLostJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnConnectionInterruptedJson {
  const RtcEngineEventHandlerOnConnectionInterruptedJson({this.connection});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  factory RtcEngineEventHandlerOnConnectionInterruptedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnConnectionInterruptedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnConnectionInterruptedJsonToJson(this);
}

extension RtcEngineEventHandlerOnConnectionInterruptedJsonBufferExt
    on RtcEngineEventHandlerOnConnectionInterruptedJson {
  RtcEngineEventHandlerOnConnectionInterruptedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnConnectionBannedJson {
  const RtcEngineEventHandlerOnConnectionBannedJson({this.connection});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  factory RtcEngineEventHandlerOnConnectionBannedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnConnectionBannedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnConnectionBannedJsonToJson(this);
}

extension RtcEngineEventHandlerOnConnectionBannedJsonBufferExt
    on RtcEngineEventHandlerOnConnectionBannedJson {
  RtcEngineEventHandlerOnConnectionBannedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnStreamMessageJson {
  const RtcEngineEventHandlerOnStreamMessageJson(
      {this.connection,
      this.remoteUid,
      this.streamId,
      this.data,
      this.length,
      this.sentTs});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'streamId')
  final int? streamId;
  @JsonKey(name: 'data', ignore: true)
  final Uint8List? data;
  @JsonKey(name: 'length')
  final int? length;
  @JsonKey(name: 'sentTs')
  final int? sentTs;
  factory RtcEngineEventHandlerOnStreamMessageJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnStreamMessageJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnStreamMessageJsonToJson(this);
}

extension RtcEngineEventHandlerOnStreamMessageJsonBufferExt
    on RtcEngineEventHandlerOnStreamMessageJson {
  RtcEngineEventHandlerOnStreamMessageJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    Uint8List? data;
    if (bufferList.length > 0) {
      data = bufferList[0];
    }
    return RtcEngineEventHandlerOnStreamMessageJson(
        connection: connection,
        remoteUid: remoteUid,
        streamId: streamId,
        data: data,
        length: length,
        sentTs: sentTs);
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    if (data != null) {
      bufferList.add(data!);
    }
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnStreamMessageErrorJson {
  const RtcEngineEventHandlerOnStreamMessageErrorJson(
      {this.connection,
      this.remoteUid,
      this.streamId,
      this.code,
      this.missed,
      this.cached});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'streamId')
  final int? streamId;
  @JsonKey(name: 'code')
  final ErrorCodeType? code;
  @JsonKey(name: 'missed')
  final int? missed;
  @JsonKey(name: 'cached')
  final int? cached;
  factory RtcEngineEventHandlerOnStreamMessageErrorJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnStreamMessageErrorJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnStreamMessageErrorJsonToJson(this);
}

extension RtcEngineEventHandlerOnStreamMessageErrorJsonBufferExt
    on RtcEngineEventHandlerOnStreamMessageErrorJson {
  RtcEngineEventHandlerOnStreamMessageErrorJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnRequestTokenJson {
  const RtcEngineEventHandlerOnRequestTokenJson({this.connection});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  factory RtcEngineEventHandlerOnRequestTokenJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnRequestTokenJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnRequestTokenJsonToJson(this);
}

extension RtcEngineEventHandlerOnRequestTokenJsonBufferExt
    on RtcEngineEventHandlerOnRequestTokenJson {
  RtcEngineEventHandlerOnRequestTokenJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnTokenPrivilegeWillExpireJson {
  const RtcEngineEventHandlerOnTokenPrivilegeWillExpireJson(
      {this.connection, this.token});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'token')
  final String? token;
  factory RtcEngineEventHandlerOnTokenPrivilegeWillExpireJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnTokenPrivilegeWillExpireJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnTokenPrivilegeWillExpireJsonToJson(this);
}

extension RtcEngineEventHandlerOnTokenPrivilegeWillExpireJsonBufferExt
    on RtcEngineEventHandlerOnTokenPrivilegeWillExpireJson {
  RtcEngineEventHandlerOnTokenPrivilegeWillExpireJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnLicenseValidationFailureJson {
  const RtcEngineEventHandlerOnLicenseValidationFailureJson(
      {this.connection, this.reason});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'reason')
  final LicenseErrorType? reason;
  factory RtcEngineEventHandlerOnLicenseValidationFailureJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnLicenseValidationFailureJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnLicenseValidationFailureJsonToJson(this);
}

extension RtcEngineEventHandlerOnLicenseValidationFailureJsonBufferExt
    on RtcEngineEventHandlerOnLicenseValidationFailureJson {
  RtcEngineEventHandlerOnLicenseValidationFailureJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnFirstLocalAudioFramePublishedJson {
  const RtcEngineEventHandlerOnFirstLocalAudioFramePublishedJson(
      {this.connection, this.elapsed});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerOnFirstLocalAudioFramePublishedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnFirstLocalAudioFramePublishedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnFirstLocalAudioFramePublishedJsonToJson(this);
}

extension RtcEngineEventHandlerOnFirstLocalAudioFramePublishedJsonBufferExt
    on RtcEngineEventHandlerOnFirstLocalAudioFramePublishedJson {
  RtcEngineEventHandlerOnFirstLocalAudioFramePublishedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnFirstRemoteAudioFrameJson {
  const RtcEngineEventHandlerOnFirstRemoteAudioFrameJson(
      {this.connection, this.userId, this.elapsed});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'userId')
  final int? userId;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerOnFirstRemoteAudioFrameJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnFirstRemoteAudioFrameJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnFirstRemoteAudioFrameJsonToJson(this);
}

extension RtcEngineEventHandlerOnFirstRemoteAudioFrameJsonBufferExt
    on RtcEngineEventHandlerOnFirstRemoteAudioFrameJson {
  RtcEngineEventHandlerOnFirstRemoteAudioFrameJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnFirstRemoteAudioDecodedJson {
  const RtcEngineEventHandlerOnFirstRemoteAudioDecodedJson(
      {this.connection, this.uid, this.elapsed});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerOnFirstRemoteAudioDecodedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnFirstRemoteAudioDecodedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnFirstRemoteAudioDecodedJsonToJson(this);
}

extension RtcEngineEventHandlerOnFirstRemoteAudioDecodedJsonBufferExt
    on RtcEngineEventHandlerOnFirstRemoteAudioDecodedJson {
  RtcEngineEventHandlerOnFirstRemoteAudioDecodedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnLocalAudioStateChangedJson {
  const RtcEngineEventHandlerOnLocalAudioStateChangedJson(
      {this.connection, this.state, this.error});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'state')
  final LocalAudioStreamState? state;
  @JsonKey(name: 'error')
  final LocalAudioStreamError? error;
  factory RtcEngineEventHandlerOnLocalAudioStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnLocalAudioStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnLocalAudioStateChangedJsonToJson(this);
}

extension RtcEngineEventHandlerOnLocalAudioStateChangedJsonBufferExt
    on RtcEngineEventHandlerOnLocalAudioStateChangedJson {
  RtcEngineEventHandlerOnLocalAudioStateChangedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnRemoteAudioStateChangedJson {
  const RtcEngineEventHandlerOnRemoteAudioStateChangedJson(
      {this.connection, this.remoteUid, this.state, this.reason, this.elapsed});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'state')
  final RemoteAudioState? state;
  @JsonKey(name: 'reason')
  final RemoteAudioStateReason? reason;
  @JsonKey(name: 'elapsed')
  final int? elapsed;
  factory RtcEngineEventHandlerOnRemoteAudioStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnRemoteAudioStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnRemoteAudioStateChangedJsonToJson(this);
}

extension RtcEngineEventHandlerOnRemoteAudioStateChangedJsonBufferExt
    on RtcEngineEventHandlerOnRemoteAudioStateChangedJson {
  RtcEngineEventHandlerOnRemoteAudioStateChangedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnActiveSpeakerJson {
  const RtcEngineEventHandlerOnActiveSpeakerJson({this.connection, this.uid});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'uid')
  final int? uid;
  factory RtcEngineEventHandlerOnActiveSpeakerJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnActiveSpeakerJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnActiveSpeakerJsonToJson(this);
}

extension RtcEngineEventHandlerOnActiveSpeakerJsonBufferExt
    on RtcEngineEventHandlerOnActiveSpeakerJson {
  RtcEngineEventHandlerOnActiveSpeakerJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnContentInspectResultJson {
  const RtcEngineEventHandlerOnContentInspectResultJson({this.result});

  @JsonKey(name: 'result')
  final ContentInspectResult? result;
  factory RtcEngineEventHandlerOnContentInspectResultJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnContentInspectResultJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnContentInspectResultJsonToJson(this);
}

extension RtcEngineEventHandlerOnContentInspectResultJsonBufferExt
    on RtcEngineEventHandlerOnContentInspectResultJson {
  RtcEngineEventHandlerOnContentInspectResultJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnSnapshotTakenJson {
  const RtcEngineEventHandlerOnSnapshotTakenJson(
      {this.connection,
      this.uid,
      this.filePath,
      this.width,
      this.height,
      this.errCode});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'filePath')
  final String? filePath;
  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;
  @JsonKey(name: 'errCode')
  final int? errCode;
  factory RtcEngineEventHandlerOnSnapshotTakenJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnSnapshotTakenJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnSnapshotTakenJsonToJson(this);
}

extension RtcEngineEventHandlerOnSnapshotTakenJsonBufferExt
    on RtcEngineEventHandlerOnSnapshotTakenJson {
  RtcEngineEventHandlerOnSnapshotTakenJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnClientRoleChangedJson {
  const RtcEngineEventHandlerOnClientRoleChangedJson(
      {this.connection, this.oldRole, this.newRole, this.newRoleOptions});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'oldRole')
  final ClientRoleType? oldRole;
  @JsonKey(name: 'newRole')
  final ClientRoleType? newRole;
  @JsonKey(name: 'newRoleOptions')
  final ClientRoleOptions? newRoleOptions;
  factory RtcEngineEventHandlerOnClientRoleChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnClientRoleChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnClientRoleChangedJsonToJson(this);
}

extension RtcEngineEventHandlerOnClientRoleChangedJsonBufferExt
    on RtcEngineEventHandlerOnClientRoleChangedJson {
  RtcEngineEventHandlerOnClientRoleChangedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnClientRoleChangeFailedJson {
  const RtcEngineEventHandlerOnClientRoleChangeFailedJson(
      {this.connection, this.reason, this.currentRole});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'reason')
  final ClientRoleChangeFailedReason? reason;
  @JsonKey(name: 'currentRole')
  final ClientRoleType? currentRole;
  factory RtcEngineEventHandlerOnClientRoleChangeFailedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnClientRoleChangeFailedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnClientRoleChangeFailedJsonToJson(this);
}

extension RtcEngineEventHandlerOnClientRoleChangeFailedJsonBufferExt
    on RtcEngineEventHandlerOnClientRoleChangeFailedJson {
  RtcEngineEventHandlerOnClientRoleChangeFailedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnAudioDeviceVolumeChangedJson {
  const RtcEngineEventHandlerOnAudioDeviceVolumeChangedJson(
      {this.deviceType, this.volume, this.muted});

  @JsonKey(name: 'deviceType')
  final MediaDeviceType? deviceType;
  @JsonKey(name: 'volume')
  final int? volume;
  @JsonKey(name: 'muted')
  final bool? muted;
  factory RtcEngineEventHandlerOnAudioDeviceVolumeChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnAudioDeviceVolumeChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnAudioDeviceVolumeChangedJsonToJson(this);
}

extension RtcEngineEventHandlerOnAudioDeviceVolumeChangedJsonBufferExt
    on RtcEngineEventHandlerOnAudioDeviceVolumeChangedJson {
  RtcEngineEventHandlerOnAudioDeviceVolumeChangedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnRtmpStreamingStateChangedJson {
  const RtcEngineEventHandlerOnRtmpStreamingStateChangedJson(
      {this.url, this.state, this.errCode});

  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'state')
  final RtmpStreamPublishState? state;
  @JsonKey(name: 'errCode')
  final RtmpStreamPublishErrorType? errCode;
  factory RtcEngineEventHandlerOnRtmpStreamingStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnRtmpStreamingStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnRtmpStreamingStateChangedJsonToJson(this);
}

extension RtcEngineEventHandlerOnRtmpStreamingStateChangedJsonBufferExt
    on RtcEngineEventHandlerOnRtmpStreamingStateChangedJson {
  RtcEngineEventHandlerOnRtmpStreamingStateChangedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnRtmpStreamingEventJson {
  const RtcEngineEventHandlerOnRtmpStreamingEventJson(
      {this.url, this.eventCode});

  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'eventCode')
  final RtmpStreamingEvent? eventCode;
  factory RtcEngineEventHandlerOnRtmpStreamingEventJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnRtmpStreamingEventJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnRtmpStreamingEventJsonToJson(this);
}

extension RtcEngineEventHandlerOnRtmpStreamingEventJsonBufferExt
    on RtcEngineEventHandlerOnRtmpStreamingEventJson {
  RtcEngineEventHandlerOnRtmpStreamingEventJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnTranscodingUpdatedJson {
  const RtcEngineEventHandlerOnTranscodingUpdatedJson();

  factory RtcEngineEventHandlerOnTranscodingUpdatedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnTranscodingUpdatedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnTranscodingUpdatedJsonToJson(this);
}

extension RtcEngineEventHandlerOnTranscodingUpdatedJsonBufferExt
    on RtcEngineEventHandlerOnTranscodingUpdatedJson {
  RtcEngineEventHandlerOnTranscodingUpdatedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnAudioRoutingChangedJson {
  const RtcEngineEventHandlerOnAudioRoutingChangedJson({this.routing});

  @JsonKey(name: 'routing')
  final int? routing;
  factory RtcEngineEventHandlerOnAudioRoutingChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnAudioRoutingChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnAudioRoutingChangedJsonToJson(this);
}

extension RtcEngineEventHandlerOnAudioRoutingChangedJsonBufferExt
    on RtcEngineEventHandlerOnAudioRoutingChangedJson {
  RtcEngineEventHandlerOnAudioRoutingChangedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnChannelMediaRelayStateChangedJson {
  const RtcEngineEventHandlerOnChannelMediaRelayStateChangedJson(
      {this.state, this.code});

  @JsonKey(name: 'state')
  final ChannelMediaRelayState? state;
  @JsonKey(name: 'code')
  final ChannelMediaRelayError? code;
  factory RtcEngineEventHandlerOnChannelMediaRelayStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnChannelMediaRelayStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnChannelMediaRelayStateChangedJsonToJson(this);
}

extension RtcEngineEventHandlerOnChannelMediaRelayStateChangedJsonBufferExt
    on RtcEngineEventHandlerOnChannelMediaRelayStateChangedJson {
  RtcEngineEventHandlerOnChannelMediaRelayStateChangedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnChannelMediaRelayEventJson {
  const RtcEngineEventHandlerOnChannelMediaRelayEventJson({this.code});

  @JsonKey(name: 'code')
  final ChannelMediaRelayEvent? code;
  factory RtcEngineEventHandlerOnChannelMediaRelayEventJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnChannelMediaRelayEventJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnChannelMediaRelayEventJsonToJson(this);
}

extension RtcEngineEventHandlerOnChannelMediaRelayEventJsonBufferExt
    on RtcEngineEventHandlerOnChannelMediaRelayEventJson {
  RtcEngineEventHandlerOnChannelMediaRelayEventJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnLocalPublishFallbackToAudioOnlyJson {
  const RtcEngineEventHandlerOnLocalPublishFallbackToAudioOnlyJson(
      {this.isFallbackOrRecover});

  @JsonKey(name: 'isFallbackOrRecover')
  final bool? isFallbackOrRecover;
  factory RtcEngineEventHandlerOnLocalPublishFallbackToAudioOnlyJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnLocalPublishFallbackToAudioOnlyJsonFromJson(
          json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnLocalPublishFallbackToAudioOnlyJsonToJson(this);
}

extension RtcEngineEventHandlerOnLocalPublishFallbackToAudioOnlyJsonBufferExt
    on RtcEngineEventHandlerOnLocalPublishFallbackToAudioOnlyJson {
  RtcEngineEventHandlerOnLocalPublishFallbackToAudioOnlyJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnRemoteSubscribeFallbackToAudioOnlyJson {
  const RtcEngineEventHandlerOnRemoteSubscribeFallbackToAudioOnlyJson(
      {this.uid, this.isFallbackOrRecover});

  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'isFallbackOrRecover')
  final bool? isFallbackOrRecover;
  factory RtcEngineEventHandlerOnRemoteSubscribeFallbackToAudioOnlyJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnRemoteSubscribeFallbackToAudioOnlyJsonFromJson(
          json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnRemoteSubscribeFallbackToAudioOnlyJsonToJson(
          this);
}

extension RtcEngineEventHandlerOnRemoteSubscribeFallbackToAudioOnlyJsonBufferExt
    on RtcEngineEventHandlerOnRemoteSubscribeFallbackToAudioOnlyJson {
  RtcEngineEventHandlerOnRemoteSubscribeFallbackToAudioOnlyJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnRemoteAudioTransportStatsJson {
  const RtcEngineEventHandlerOnRemoteAudioTransportStatsJson(
      {this.connection,
      this.remoteUid,
      this.delay,
      this.lost,
      this.rxKBitRate});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'delay')
  final int? delay;
  @JsonKey(name: 'lost')
  final int? lost;
  @JsonKey(name: 'rxKBitRate')
  final int? rxKBitRate;
  factory RtcEngineEventHandlerOnRemoteAudioTransportStatsJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnRemoteAudioTransportStatsJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnRemoteAudioTransportStatsJsonToJson(this);
}

extension RtcEngineEventHandlerOnRemoteAudioTransportStatsJsonBufferExt
    on RtcEngineEventHandlerOnRemoteAudioTransportStatsJson {
  RtcEngineEventHandlerOnRemoteAudioTransportStatsJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnRemoteVideoTransportStatsJson {
  const RtcEngineEventHandlerOnRemoteVideoTransportStatsJson(
      {this.connection,
      this.remoteUid,
      this.delay,
      this.lost,
      this.rxKBitRate});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'delay')
  final int? delay;
  @JsonKey(name: 'lost')
  final int? lost;
  @JsonKey(name: 'rxKBitRate')
  final int? rxKBitRate;
  factory RtcEngineEventHandlerOnRemoteVideoTransportStatsJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnRemoteVideoTransportStatsJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnRemoteVideoTransportStatsJsonToJson(this);
}

extension RtcEngineEventHandlerOnRemoteVideoTransportStatsJsonBufferExt
    on RtcEngineEventHandlerOnRemoteVideoTransportStatsJson {
  RtcEngineEventHandlerOnRemoteVideoTransportStatsJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnConnectionStateChangedJson {
  const RtcEngineEventHandlerOnConnectionStateChangedJson(
      {this.connection, this.state, this.reason});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'state')
  final ConnectionStateType? state;
  @JsonKey(name: 'reason')
  final ConnectionChangedReasonType? reason;
  factory RtcEngineEventHandlerOnConnectionStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnConnectionStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnConnectionStateChangedJsonToJson(this);
}

extension RtcEngineEventHandlerOnConnectionStateChangedJsonBufferExt
    on RtcEngineEventHandlerOnConnectionStateChangedJson {
  RtcEngineEventHandlerOnConnectionStateChangedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnWlAccMessageJson {
  const RtcEngineEventHandlerOnWlAccMessageJson(
      {this.connection, this.reason, this.action, this.wlAccMsg});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'reason')
  final WlaccMessageReason? reason;
  @JsonKey(name: 'action')
  final WlaccSuggestAction? action;
  @JsonKey(name: 'wlAccMsg')
  final String? wlAccMsg;
  factory RtcEngineEventHandlerOnWlAccMessageJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnWlAccMessageJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnWlAccMessageJsonToJson(this);
}

extension RtcEngineEventHandlerOnWlAccMessageJsonBufferExt
    on RtcEngineEventHandlerOnWlAccMessageJson {
  RtcEngineEventHandlerOnWlAccMessageJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnWlAccStatsJson {
  const RtcEngineEventHandlerOnWlAccStatsJson(
      {this.connection, this.currentStats, this.averageStats});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'currentStats')
  final WlAccStats? currentStats;
  @JsonKey(name: 'averageStats')
  final WlAccStats? averageStats;
  factory RtcEngineEventHandlerOnWlAccStatsJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnWlAccStatsJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnWlAccStatsJsonToJson(this);
}

extension RtcEngineEventHandlerOnWlAccStatsJsonBufferExt
    on RtcEngineEventHandlerOnWlAccStatsJson {
  RtcEngineEventHandlerOnWlAccStatsJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnNetworkTypeChangedJson {
  const RtcEngineEventHandlerOnNetworkTypeChangedJson(
      {this.connection, this.type});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'type')
  final NetworkType? type;
  factory RtcEngineEventHandlerOnNetworkTypeChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnNetworkTypeChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnNetworkTypeChangedJsonToJson(this);
}

extension RtcEngineEventHandlerOnNetworkTypeChangedJsonBufferExt
    on RtcEngineEventHandlerOnNetworkTypeChangedJson {
  RtcEngineEventHandlerOnNetworkTypeChangedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnEncryptionErrorJson {
  const RtcEngineEventHandlerOnEncryptionErrorJson(
      {this.connection, this.errorType});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'errorType')
  final EncryptionErrorType? errorType;
  factory RtcEngineEventHandlerOnEncryptionErrorJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnEncryptionErrorJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnEncryptionErrorJsonToJson(this);
}

extension RtcEngineEventHandlerOnEncryptionErrorJsonBufferExt
    on RtcEngineEventHandlerOnEncryptionErrorJson {
  RtcEngineEventHandlerOnEncryptionErrorJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnPermissionErrorJson {
  const RtcEngineEventHandlerOnPermissionErrorJson({this.permissionType});

  @JsonKey(name: 'permissionType')
  final PermissionType? permissionType;
  factory RtcEngineEventHandlerOnPermissionErrorJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnPermissionErrorJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnPermissionErrorJsonToJson(this);
}

extension RtcEngineEventHandlerOnPermissionErrorJsonBufferExt
    on RtcEngineEventHandlerOnPermissionErrorJson {
  RtcEngineEventHandlerOnPermissionErrorJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnLocalUserRegisteredJson {
  const RtcEngineEventHandlerOnLocalUserRegisteredJson(
      {this.uid, this.userAccount});

  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'userAccount')
  final String? userAccount;
  factory RtcEngineEventHandlerOnLocalUserRegisteredJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnLocalUserRegisteredJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnLocalUserRegisteredJsonToJson(this);
}

extension RtcEngineEventHandlerOnLocalUserRegisteredJsonBufferExt
    on RtcEngineEventHandlerOnLocalUserRegisteredJson {
  RtcEngineEventHandlerOnLocalUserRegisteredJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnUserInfoUpdatedJson {
  const RtcEngineEventHandlerOnUserInfoUpdatedJson({this.uid, this.info});

  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'info')
  final UserInfo? info;
  factory RtcEngineEventHandlerOnUserInfoUpdatedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnUserInfoUpdatedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnUserInfoUpdatedJsonToJson(this);
}

extension RtcEngineEventHandlerOnUserInfoUpdatedJsonBufferExt
    on RtcEngineEventHandlerOnUserInfoUpdatedJson {
  RtcEngineEventHandlerOnUserInfoUpdatedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnUploadLogResultJson {
  const RtcEngineEventHandlerOnUploadLogResultJson(
      {this.connection, this.requestId, this.success, this.reason});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'requestId')
  final String? requestId;
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'reason')
  final UploadErrorReason? reason;
  factory RtcEngineEventHandlerOnUploadLogResultJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnUploadLogResultJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnUploadLogResultJsonToJson(this);
}

extension RtcEngineEventHandlerOnUploadLogResultJsonBufferExt
    on RtcEngineEventHandlerOnUploadLogResultJson {
  RtcEngineEventHandlerOnUploadLogResultJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnAudioSubscribeStateChangedJson {
  const RtcEngineEventHandlerOnAudioSubscribeStateChangedJson(
      {this.channel,
      this.uid,
      this.oldState,
      this.newState,
      this.elapseSinceLastState});

  @JsonKey(name: 'channel')
  final String? channel;
  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'oldState')
  final StreamSubscribeState? oldState;
  @JsonKey(name: 'newState')
  final StreamSubscribeState? newState;
  @JsonKey(name: 'elapseSinceLastState')
  final int? elapseSinceLastState;
  factory RtcEngineEventHandlerOnAudioSubscribeStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnAudioSubscribeStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnAudioSubscribeStateChangedJsonToJson(this);
}

extension RtcEngineEventHandlerOnAudioSubscribeStateChangedJsonBufferExt
    on RtcEngineEventHandlerOnAudioSubscribeStateChangedJson {
  RtcEngineEventHandlerOnAudioSubscribeStateChangedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnVideoSubscribeStateChangedJson {
  const RtcEngineEventHandlerOnVideoSubscribeStateChangedJson(
      {this.channel,
      this.uid,
      this.oldState,
      this.newState,
      this.elapseSinceLastState});

  @JsonKey(name: 'channel')
  final String? channel;
  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'oldState')
  final StreamSubscribeState? oldState;
  @JsonKey(name: 'newState')
  final StreamSubscribeState? newState;
  @JsonKey(name: 'elapseSinceLastState')
  final int? elapseSinceLastState;
  factory RtcEngineEventHandlerOnVideoSubscribeStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnVideoSubscribeStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnVideoSubscribeStateChangedJsonToJson(this);
}

extension RtcEngineEventHandlerOnVideoSubscribeStateChangedJsonBufferExt
    on RtcEngineEventHandlerOnVideoSubscribeStateChangedJson {
  RtcEngineEventHandlerOnVideoSubscribeStateChangedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnAudioPublishStateChangedJson {
  const RtcEngineEventHandlerOnAudioPublishStateChangedJson(
      {this.channel, this.oldState, this.newState, this.elapseSinceLastState});

  @JsonKey(name: 'channel')
  final String? channel;
  @JsonKey(name: 'oldState')
  final StreamPublishState? oldState;
  @JsonKey(name: 'newState')
  final StreamPublishState? newState;
  @JsonKey(name: 'elapseSinceLastState')
  final int? elapseSinceLastState;
  factory RtcEngineEventHandlerOnAudioPublishStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnAudioPublishStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnAudioPublishStateChangedJsonToJson(this);
}

extension RtcEngineEventHandlerOnAudioPublishStateChangedJsonBufferExt
    on RtcEngineEventHandlerOnAudioPublishStateChangedJson {
  RtcEngineEventHandlerOnAudioPublishStateChangedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnVideoPublishStateChangedJson {
  const RtcEngineEventHandlerOnVideoPublishStateChangedJson(
      {this.source,
      this.channel,
      this.oldState,
      this.newState,
      this.elapseSinceLastState});

  @JsonKey(name: 'source')
  final VideoSourceType? source;
  @JsonKey(name: 'channel')
  final String? channel;
  @JsonKey(name: 'oldState')
  final StreamPublishState? oldState;
  @JsonKey(name: 'newState')
  final StreamPublishState? newState;
  @JsonKey(name: 'elapseSinceLastState')
  final int? elapseSinceLastState;
  factory RtcEngineEventHandlerOnVideoPublishStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnVideoPublishStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnVideoPublishStateChangedJsonToJson(this);
}

extension RtcEngineEventHandlerOnVideoPublishStateChangedJsonBufferExt
    on RtcEngineEventHandlerOnVideoPublishStateChangedJson {
  RtcEngineEventHandlerOnVideoPublishStateChangedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnExtensionEventJson {
  const RtcEngineEventHandlerOnExtensionEventJson(
      {this.provider, this.extension, this.key, this.value});

  @JsonKey(name: 'provider')
  final String? provider;
  @JsonKey(name: 'extension')
  final String? extension;
  @JsonKey(name: 'key')
  final String? key;
  @JsonKey(name: 'value')
  final String? value;
  factory RtcEngineEventHandlerOnExtensionEventJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnExtensionEventJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnExtensionEventJsonToJson(this);
}

extension RtcEngineEventHandlerOnExtensionEventJsonBufferExt
    on RtcEngineEventHandlerOnExtensionEventJson {
  RtcEngineEventHandlerOnExtensionEventJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnExtensionStartedJson {
  const RtcEngineEventHandlerOnExtensionStartedJson(
      {this.provider, this.extension});

  @JsonKey(name: 'provider')
  final String? provider;
  @JsonKey(name: 'extension')
  final String? extension;
  factory RtcEngineEventHandlerOnExtensionStartedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnExtensionStartedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnExtensionStartedJsonToJson(this);
}

extension RtcEngineEventHandlerOnExtensionStartedJsonBufferExt
    on RtcEngineEventHandlerOnExtensionStartedJson {
  RtcEngineEventHandlerOnExtensionStartedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnExtensionStoppedJson {
  const RtcEngineEventHandlerOnExtensionStoppedJson(
      {this.provider, this.extension});

  @JsonKey(name: 'provider')
  final String? provider;
  @JsonKey(name: 'extension')
  final String? extension;
  factory RtcEngineEventHandlerOnExtensionStoppedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnExtensionStoppedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnExtensionStoppedJsonToJson(this);
}

extension RtcEngineEventHandlerOnExtensionStoppedJsonBufferExt
    on RtcEngineEventHandlerOnExtensionStoppedJson {
  RtcEngineEventHandlerOnExtensionStoppedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnExtensionErrorJson {
  const RtcEngineEventHandlerOnExtensionErrorJson(
      {this.provider, this.extension, this.error, this.message});

  @JsonKey(name: 'provider')
  final String? provider;
  @JsonKey(name: 'extension')
  final String? extension;
  @JsonKey(name: 'error')
  final int? error;
  @JsonKey(name: 'message')
  final String? message;
  factory RtcEngineEventHandlerOnExtensionErrorJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnExtensionErrorJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnExtensionErrorJsonToJson(this);
}

extension RtcEngineEventHandlerOnExtensionErrorJsonBufferExt
    on RtcEngineEventHandlerOnExtensionErrorJson {
  RtcEngineEventHandlerOnExtensionErrorJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class RtcEngineEventHandlerOnUserAccountUpdatedJson {
  const RtcEngineEventHandlerOnUserAccountUpdatedJson(
      {this.connection, this.remoteUid, this.userAccount});

  @JsonKey(name: 'connection')
  final RtcConnection? connection;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'userAccount')
  final String? userAccount;
  factory RtcEngineEventHandlerOnUserAccountUpdatedJson.fromJson(
          Map<String, dynamic> json) =>
      _$RtcEngineEventHandlerOnUserAccountUpdatedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RtcEngineEventHandlerOnUserAccountUpdatedJsonToJson(this);
}

extension RtcEngineEventHandlerOnUserAccountUpdatedJsonBufferExt
    on RtcEngineEventHandlerOnUserAccountUpdatedJson {
  RtcEngineEventHandlerOnUserAccountUpdatedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class MetadataObserverOnMetadataReceivedJson {
  const MetadataObserverOnMetadataReceivedJson({this.metadata});

  @JsonKey(name: 'metadata')
  final Metadata? metadata;
  factory MetadataObserverOnMetadataReceivedJson.fromJson(
          Map<String, dynamic> json) =>
      _$MetadataObserverOnMetadataReceivedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MetadataObserverOnMetadataReceivedJsonToJson(this);
}

extension MetadataObserverOnMetadataReceivedJsonBufferExt
    on MetadataObserverOnMetadataReceivedJson {
  MetadataObserverOnMetadataReceivedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class DirectCdnStreamingEventHandlerOnDirectCdnStreamingStateChangedJson {
  const DirectCdnStreamingEventHandlerOnDirectCdnStreamingStateChangedJson(
      {this.state, this.error, this.message});

  @JsonKey(name: 'state')
  final DirectCdnStreamingState? state;
  @JsonKey(name: 'error')
  final DirectCdnStreamingError? error;
  @JsonKey(name: 'message')
  final String? message;
  factory DirectCdnStreamingEventHandlerOnDirectCdnStreamingStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$DirectCdnStreamingEventHandlerOnDirectCdnStreamingStateChangedJsonFromJson(
          json);
  Map<String, dynamic> toJson() =>
      _$DirectCdnStreamingEventHandlerOnDirectCdnStreamingStateChangedJsonToJson(
          this);
}

extension DirectCdnStreamingEventHandlerOnDirectCdnStreamingStateChangedJsonBufferExt
    on DirectCdnStreamingEventHandlerOnDirectCdnStreamingStateChangedJson {
  DirectCdnStreamingEventHandlerOnDirectCdnStreamingStateChangedJson
      fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class DirectCdnStreamingEventHandlerOnDirectCdnStreamingStatsJson {
  const DirectCdnStreamingEventHandlerOnDirectCdnStreamingStatsJson(
      {this.stats});

  @JsonKey(name: 'stats')
  final DirectCdnStreamingStats? stats;
  factory DirectCdnStreamingEventHandlerOnDirectCdnStreamingStatsJson.fromJson(
          Map<String, dynamic> json) =>
      _$DirectCdnStreamingEventHandlerOnDirectCdnStreamingStatsJsonFromJson(
          json);
  Map<String, dynamic> toJson() =>
      _$DirectCdnStreamingEventHandlerOnDirectCdnStreamingStatsJsonToJson(this);
}

extension DirectCdnStreamingEventHandlerOnDirectCdnStreamingStatsJsonBufferExt
    on DirectCdnStreamingEventHandlerOnDirectCdnStreamingStatsJson {
  DirectCdnStreamingEventHandlerOnDirectCdnStreamingStatsJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class AudioEncodedFrameObserverOnRecordAudioEncodedFrameJson {
  const AudioEncodedFrameObserverOnRecordAudioEncodedFrameJson(
      {this.frameBuffer, this.length, this.audioEncodedFrameInfo});

  @JsonKey(name: 'frameBuffer', ignore: true)
  final Uint8List? frameBuffer;
  @JsonKey(name: 'length')
  final int? length;
  @JsonKey(name: 'audioEncodedFrameInfo')
  final EncodedAudioFrameInfo? audioEncodedFrameInfo;
  factory AudioEncodedFrameObserverOnRecordAudioEncodedFrameJson.fromJson(
          Map<String, dynamic> json) =>
      _$AudioEncodedFrameObserverOnRecordAudioEncodedFrameJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$AudioEncodedFrameObserverOnRecordAudioEncodedFrameJsonToJson(this);
}

extension AudioEncodedFrameObserverOnRecordAudioEncodedFrameJsonBufferExt
    on AudioEncodedFrameObserverOnRecordAudioEncodedFrameJson {
  AudioEncodedFrameObserverOnRecordAudioEncodedFrameJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    Uint8List? frameBuffer;
    if (bufferList.length > 0) {
      frameBuffer = bufferList[0];
    }
    return AudioEncodedFrameObserverOnRecordAudioEncodedFrameJson(
        frameBuffer: frameBuffer,
        length: length,
        audioEncodedFrameInfo: audioEncodedFrameInfo);
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    if (frameBuffer != null) {
      bufferList.add(frameBuffer!);
    }
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class AudioEncodedFrameObserverOnPlaybackAudioEncodedFrameJson {
  const AudioEncodedFrameObserverOnPlaybackAudioEncodedFrameJson(
      {this.frameBuffer, this.length, this.audioEncodedFrameInfo});

  @JsonKey(name: 'frameBuffer', ignore: true)
  final Uint8List? frameBuffer;
  @JsonKey(name: 'length')
  final int? length;
  @JsonKey(name: 'audioEncodedFrameInfo')
  final EncodedAudioFrameInfo? audioEncodedFrameInfo;
  factory AudioEncodedFrameObserverOnPlaybackAudioEncodedFrameJson.fromJson(
          Map<String, dynamic> json) =>
      _$AudioEncodedFrameObserverOnPlaybackAudioEncodedFrameJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$AudioEncodedFrameObserverOnPlaybackAudioEncodedFrameJsonToJson(this);
}

extension AudioEncodedFrameObserverOnPlaybackAudioEncodedFrameJsonBufferExt
    on AudioEncodedFrameObserverOnPlaybackAudioEncodedFrameJson {
  AudioEncodedFrameObserverOnPlaybackAudioEncodedFrameJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    Uint8List? frameBuffer;
    if (bufferList.length > 0) {
      frameBuffer = bufferList[0];
    }
    return AudioEncodedFrameObserverOnPlaybackAudioEncodedFrameJson(
        frameBuffer: frameBuffer,
        length: length,
        audioEncodedFrameInfo: audioEncodedFrameInfo);
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    if (frameBuffer != null) {
      bufferList.add(frameBuffer!);
    }
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class AudioEncodedFrameObserverOnMixedAudioEncodedFrameJson {
  const AudioEncodedFrameObserverOnMixedAudioEncodedFrameJson(
      {this.frameBuffer, this.length, this.audioEncodedFrameInfo});

  @JsonKey(name: 'frameBuffer', ignore: true)
  final Uint8List? frameBuffer;
  @JsonKey(name: 'length')
  final int? length;
  @JsonKey(name: 'audioEncodedFrameInfo')
  final EncodedAudioFrameInfo? audioEncodedFrameInfo;
  factory AudioEncodedFrameObserverOnMixedAudioEncodedFrameJson.fromJson(
          Map<String, dynamic> json) =>
      _$AudioEncodedFrameObserverOnMixedAudioEncodedFrameJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$AudioEncodedFrameObserverOnMixedAudioEncodedFrameJsonToJson(this);
}

extension AudioEncodedFrameObserverOnMixedAudioEncodedFrameJsonBufferExt
    on AudioEncodedFrameObserverOnMixedAudioEncodedFrameJson {
  AudioEncodedFrameObserverOnMixedAudioEncodedFrameJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    Uint8List? frameBuffer;
    if (bufferList.length > 0) {
      frameBuffer = bufferList[0];
    }
    return AudioEncodedFrameObserverOnMixedAudioEncodedFrameJson(
        frameBuffer: frameBuffer,
        length: length,
        audioEncodedFrameInfo: audioEncodedFrameInfo);
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    if (frameBuffer != null) {
      bufferList.add(frameBuffer!);
    }
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class AudioFrameObserverBaseOnRecordAudioFrameJson {
  const AudioFrameObserverBaseOnRecordAudioFrameJson(
      {this.channelId, this.audioFrame});

  @JsonKey(name: 'channelId')
  final String? channelId;
  @JsonKey(name: 'audioFrame')
  final AudioFrame? audioFrame;
  factory AudioFrameObserverBaseOnRecordAudioFrameJson.fromJson(
          Map<String, dynamic> json) =>
      _$AudioFrameObserverBaseOnRecordAudioFrameJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$AudioFrameObserverBaseOnRecordAudioFrameJsonToJson(this);
}

extension AudioFrameObserverBaseOnRecordAudioFrameJsonBufferExt
    on AudioFrameObserverBaseOnRecordAudioFrameJson {
  AudioFrameObserverBaseOnRecordAudioFrameJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class AudioFrameObserverBaseOnPlaybackAudioFrameJson {
  const AudioFrameObserverBaseOnPlaybackAudioFrameJson(
      {this.channelId, this.audioFrame});

  @JsonKey(name: 'channelId')
  final String? channelId;
  @JsonKey(name: 'audioFrame')
  final AudioFrame? audioFrame;
  factory AudioFrameObserverBaseOnPlaybackAudioFrameJson.fromJson(
          Map<String, dynamic> json) =>
      _$AudioFrameObserverBaseOnPlaybackAudioFrameJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$AudioFrameObserverBaseOnPlaybackAudioFrameJsonToJson(this);
}

extension AudioFrameObserverBaseOnPlaybackAudioFrameJsonBufferExt
    on AudioFrameObserverBaseOnPlaybackAudioFrameJson {
  AudioFrameObserverBaseOnPlaybackAudioFrameJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class AudioFrameObserverBaseOnMixedAudioFrameJson {
  const AudioFrameObserverBaseOnMixedAudioFrameJson(
      {this.channelId, this.audioFrame});

  @JsonKey(name: 'channelId')
  final String? channelId;
  @JsonKey(name: 'audioFrame')
  final AudioFrame? audioFrame;
  factory AudioFrameObserverBaseOnMixedAudioFrameJson.fromJson(
          Map<String, dynamic> json) =>
      _$AudioFrameObserverBaseOnMixedAudioFrameJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$AudioFrameObserverBaseOnMixedAudioFrameJsonToJson(this);
}

extension AudioFrameObserverBaseOnMixedAudioFrameJsonBufferExt
    on AudioFrameObserverBaseOnMixedAudioFrameJson {
  AudioFrameObserverBaseOnMixedAudioFrameJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class AudioFrameObserverBaseOnEarMonitoringAudioFrameJson {
  const AudioFrameObserverBaseOnEarMonitoringAudioFrameJson({this.audioFrame});

  @JsonKey(name: 'audioFrame')
  final AudioFrame? audioFrame;
  factory AudioFrameObserverBaseOnEarMonitoringAudioFrameJson.fromJson(
          Map<String, dynamic> json) =>
      _$AudioFrameObserverBaseOnEarMonitoringAudioFrameJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$AudioFrameObserverBaseOnEarMonitoringAudioFrameJsonToJson(this);
}

extension AudioFrameObserverBaseOnEarMonitoringAudioFrameJsonBufferExt
    on AudioFrameObserverBaseOnEarMonitoringAudioFrameJson {
  AudioFrameObserverBaseOnEarMonitoringAudioFrameJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class AudioFrameObserverOnPlaybackAudioFrameBeforeMixingJson {
  const AudioFrameObserverOnPlaybackAudioFrameBeforeMixingJson(
      {this.channelId, this.uid, this.audioFrame});

  @JsonKey(name: 'channelId')
  final String? channelId;
  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'audioFrame')
  final AudioFrame? audioFrame;
  factory AudioFrameObserverOnPlaybackAudioFrameBeforeMixingJson.fromJson(
          Map<String, dynamic> json) =>
      _$AudioFrameObserverOnPlaybackAudioFrameBeforeMixingJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$AudioFrameObserverOnPlaybackAudioFrameBeforeMixingJsonToJson(this);
}

extension AudioFrameObserverOnPlaybackAudioFrameBeforeMixingJsonBufferExt
    on AudioFrameObserverOnPlaybackAudioFrameBeforeMixingJson {
  AudioFrameObserverOnPlaybackAudioFrameBeforeMixingJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class AudioSpectrumObserverOnLocalAudioSpectrumJson {
  const AudioSpectrumObserverOnLocalAudioSpectrumJson({this.data});

  @JsonKey(name: 'data')
  final AudioSpectrumData? data;
  factory AudioSpectrumObserverOnLocalAudioSpectrumJson.fromJson(
          Map<String, dynamic> json) =>
      _$AudioSpectrumObserverOnLocalAudioSpectrumJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$AudioSpectrumObserverOnLocalAudioSpectrumJsonToJson(this);
}

extension AudioSpectrumObserverOnLocalAudioSpectrumJsonBufferExt
    on AudioSpectrumObserverOnLocalAudioSpectrumJson {
  AudioSpectrumObserverOnLocalAudioSpectrumJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class AudioSpectrumObserverOnRemoteAudioSpectrumJson {
  const AudioSpectrumObserverOnRemoteAudioSpectrumJson(
      {this.spectrums, this.spectrumNumber});

  @JsonKey(name: 'spectrums')
  final List<UserAudioSpectrumInfo>? spectrums;
  @JsonKey(name: 'spectrumNumber')
  final int? spectrumNumber;
  factory AudioSpectrumObserverOnRemoteAudioSpectrumJson.fromJson(
          Map<String, dynamic> json) =>
      _$AudioSpectrumObserverOnRemoteAudioSpectrumJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$AudioSpectrumObserverOnRemoteAudioSpectrumJsonToJson(this);
}

extension AudioSpectrumObserverOnRemoteAudioSpectrumJsonBufferExt
    on AudioSpectrumObserverOnRemoteAudioSpectrumJson {
  AudioSpectrumObserverOnRemoteAudioSpectrumJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class VideoEncodedFrameObserverOnEncodedVideoFrameReceivedJson {
  const VideoEncodedFrameObserverOnEncodedVideoFrameReceivedJson(
      {this.uid, this.imageBuffer, this.length, this.videoEncodedFrameInfo});

  @JsonKey(name: 'uid')
  final int? uid;
  @JsonKey(name: 'imageBuffer', ignore: true)
  final Uint8List? imageBuffer;
  @JsonKey(name: 'length')
  final int? length;
  @JsonKey(name: 'videoEncodedFrameInfo')
  final EncodedVideoFrameInfo? videoEncodedFrameInfo;
  factory VideoEncodedFrameObserverOnEncodedVideoFrameReceivedJson.fromJson(
          Map<String, dynamic> json) =>
      _$VideoEncodedFrameObserverOnEncodedVideoFrameReceivedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$VideoEncodedFrameObserverOnEncodedVideoFrameReceivedJsonToJson(this);
}

extension VideoEncodedFrameObserverOnEncodedVideoFrameReceivedJsonBufferExt
    on VideoEncodedFrameObserverOnEncodedVideoFrameReceivedJson {
  VideoEncodedFrameObserverOnEncodedVideoFrameReceivedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    Uint8List? imageBuffer;
    if (bufferList.length > 0) {
      imageBuffer = bufferList[0];
    }
    return VideoEncodedFrameObserverOnEncodedVideoFrameReceivedJson(
        uid: uid,
        imageBuffer: imageBuffer,
        length: length,
        videoEncodedFrameInfo: videoEncodedFrameInfo);
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    if (imageBuffer != null) {
      bufferList.add(imageBuffer!);
    }
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class VideoFrameObserverOnCaptureVideoFrameJson {
  const VideoFrameObserverOnCaptureVideoFrameJson({this.videoFrame});

  @JsonKey(name: 'videoFrame')
  final VideoFrame? videoFrame;
  factory VideoFrameObserverOnCaptureVideoFrameJson.fromJson(
          Map<String, dynamic> json) =>
      _$VideoFrameObserverOnCaptureVideoFrameJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$VideoFrameObserverOnCaptureVideoFrameJsonToJson(this);
}

extension VideoFrameObserverOnCaptureVideoFrameJsonBufferExt
    on VideoFrameObserverOnCaptureVideoFrameJson {
  VideoFrameObserverOnCaptureVideoFrameJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class VideoFrameObserverOnPreEncodeVideoFrameJson {
  const VideoFrameObserverOnPreEncodeVideoFrameJson({this.videoFrame});

  @JsonKey(name: 'videoFrame')
  final VideoFrame? videoFrame;
  factory VideoFrameObserverOnPreEncodeVideoFrameJson.fromJson(
          Map<String, dynamic> json) =>
      _$VideoFrameObserverOnPreEncodeVideoFrameJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$VideoFrameObserverOnPreEncodeVideoFrameJsonToJson(this);
}

extension VideoFrameObserverOnPreEncodeVideoFrameJsonBufferExt
    on VideoFrameObserverOnPreEncodeVideoFrameJson {
  VideoFrameObserverOnPreEncodeVideoFrameJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class VideoFrameObserverOnSecondaryCameraCaptureVideoFrameJson {
  const VideoFrameObserverOnSecondaryCameraCaptureVideoFrameJson(
      {this.videoFrame});

  @JsonKey(name: 'videoFrame')
  final VideoFrame? videoFrame;
  factory VideoFrameObserverOnSecondaryCameraCaptureVideoFrameJson.fromJson(
          Map<String, dynamic> json) =>
      _$VideoFrameObserverOnSecondaryCameraCaptureVideoFrameJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$VideoFrameObserverOnSecondaryCameraCaptureVideoFrameJsonToJson(this);
}

extension VideoFrameObserverOnSecondaryCameraCaptureVideoFrameJsonBufferExt
    on VideoFrameObserverOnSecondaryCameraCaptureVideoFrameJson {
  VideoFrameObserverOnSecondaryCameraCaptureVideoFrameJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class VideoFrameObserverOnSecondaryPreEncodeCameraVideoFrameJson {
  const VideoFrameObserverOnSecondaryPreEncodeCameraVideoFrameJson(
      {this.videoFrame});

  @JsonKey(name: 'videoFrame')
  final VideoFrame? videoFrame;
  factory VideoFrameObserverOnSecondaryPreEncodeCameraVideoFrameJson.fromJson(
          Map<String, dynamic> json) =>
      _$VideoFrameObserverOnSecondaryPreEncodeCameraVideoFrameJsonFromJson(
          json);
  Map<String, dynamic> toJson() =>
      _$VideoFrameObserverOnSecondaryPreEncodeCameraVideoFrameJsonToJson(this);
}

extension VideoFrameObserverOnSecondaryPreEncodeCameraVideoFrameJsonBufferExt
    on VideoFrameObserverOnSecondaryPreEncodeCameraVideoFrameJson {
  VideoFrameObserverOnSecondaryPreEncodeCameraVideoFrameJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class VideoFrameObserverOnScreenCaptureVideoFrameJson {
  const VideoFrameObserverOnScreenCaptureVideoFrameJson({this.videoFrame});

  @JsonKey(name: 'videoFrame')
  final VideoFrame? videoFrame;
  factory VideoFrameObserverOnScreenCaptureVideoFrameJson.fromJson(
          Map<String, dynamic> json) =>
      _$VideoFrameObserverOnScreenCaptureVideoFrameJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$VideoFrameObserverOnScreenCaptureVideoFrameJsonToJson(this);
}

extension VideoFrameObserverOnScreenCaptureVideoFrameJsonBufferExt
    on VideoFrameObserverOnScreenCaptureVideoFrameJson {
  VideoFrameObserverOnScreenCaptureVideoFrameJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class VideoFrameObserverOnPreEncodeScreenVideoFrameJson {
  const VideoFrameObserverOnPreEncodeScreenVideoFrameJson({this.videoFrame});

  @JsonKey(name: 'videoFrame')
  final VideoFrame? videoFrame;
  factory VideoFrameObserverOnPreEncodeScreenVideoFrameJson.fromJson(
          Map<String, dynamic> json) =>
      _$VideoFrameObserverOnPreEncodeScreenVideoFrameJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$VideoFrameObserverOnPreEncodeScreenVideoFrameJsonToJson(this);
}

extension VideoFrameObserverOnPreEncodeScreenVideoFrameJsonBufferExt
    on VideoFrameObserverOnPreEncodeScreenVideoFrameJson {
  VideoFrameObserverOnPreEncodeScreenVideoFrameJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class VideoFrameObserverOnMediaPlayerVideoFrameJson {
  const VideoFrameObserverOnMediaPlayerVideoFrameJson(
      {this.videoFrame, this.mediaPlayerId});

  @JsonKey(name: 'videoFrame')
  final VideoFrame? videoFrame;
  @JsonKey(name: 'mediaPlayerId')
  final int? mediaPlayerId;
  factory VideoFrameObserverOnMediaPlayerVideoFrameJson.fromJson(
          Map<String, dynamic> json) =>
      _$VideoFrameObserverOnMediaPlayerVideoFrameJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$VideoFrameObserverOnMediaPlayerVideoFrameJsonToJson(this);
}

extension VideoFrameObserverOnMediaPlayerVideoFrameJsonBufferExt
    on VideoFrameObserverOnMediaPlayerVideoFrameJson {
  VideoFrameObserverOnMediaPlayerVideoFrameJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class VideoFrameObserverOnSecondaryScreenCaptureVideoFrameJson {
  const VideoFrameObserverOnSecondaryScreenCaptureVideoFrameJson(
      {this.videoFrame});

  @JsonKey(name: 'videoFrame')
  final VideoFrame? videoFrame;
  factory VideoFrameObserverOnSecondaryScreenCaptureVideoFrameJson.fromJson(
          Map<String, dynamic> json) =>
      _$VideoFrameObserverOnSecondaryScreenCaptureVideoFrameJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$VideoFrameObserverOnSecondaryScreenCaptureVideoFrameJsonToJson(this);
}

extension VideoFrameObserverOnSecondaryScreenCaptureVideoFrameJsonBufferExt
    on VideoFrameObserverOnSecondaryScreenCaptureVideoFrameJson {
  VideoFrameObserverOnSecondaryScreenCaptureVideoFrameJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class VideoFrameObserverOnSecondaryPreEncodeScreenVideoFrameJson {
  const VideoFrameObserverOnSecondaryPreEncodeScreenVideoFrameJson(
      {this.videoFrame});

  @JsonKey(name: 'videoFrame')
  final VideoFrame? videoFrame;
  factory VideoFrameObserverOnSecondaryPreEncodeScreenVideoFrameJson.fromJson(
          Map<String, dynamic> json) =>
      _$VideoFrameObserverOnSecondaryPreEncodeScreenVideoFrameJsonFromJson(
          json);
  Map<String, dynamic> toJson() =>
      _$VideoFrameObserverOnSecondaryPreEncodeScreenVideoFrameJsonToJson(this);
}

extension VideoFrameObserverOnSecondaryPreEncodeScreenVideoFrameJsonBufferExt
    on VideoFrameObserverOnSecondaryPreEncodeScreenVideoFrameJson {
  VideoFrameObserverOnSecondaryPreEncodeScreenVideoFrameJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class VideoFrameObserverOnRenderVideoFrameJson {
  const VideoFrameObserverOnRenderVideoFrameJson(
      {this.channelId, this.remoteUid, this.videoFrame});

  @JsonKey(name: 'channelId')
  final String? channelId;
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;
  @JsonKey(name: 'videoFrame')
  final VideoFrame? videoFrame;
  factory VideoFrameObserverOnRenderVideoFrameJson.fromJson(
          Map<String, dynamic> json) =>
      _$VideoFrameObserverOnRenderVideoFrameJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$VideoFrameObserverOnRenderVideoFrameJsonToJson(this);
}

extension VideoFrameObserverOnRenderVideoFrameJsonBufferExt
    on VideoFrameObserverOnRenderVideoFrameJson {
  VideoFrameObserverOnRenderVideoFrameJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class VideoFrameObserverOnTranscodedVideoFrameJson {
  const VideoFrameObserverOnTranscodedVideoFrameJson({this.videoFrame});

  @JsonKey(name: 'videoFrame')
  final VideoFrame? videoFrame;
  factory VideoFrameObserverOnTranscodedVideoFrameJson.fromJson(
          Map<String, dynamic> json) =>
      _$VideoFrameObserverOnTranscodedVideoFrameJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$VideoFrameObserverOnTranscodedVideoFrameJsonToJson(this);
}

extension VideoFrameObserverOnTranscodedVideoFrameJsonBufferExt
    on VideoFrameObserverOnTranscodedVideoFrameJson {
  VideoFrameObserverOnTranscodedVideoFrameJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class MediaRecorderObserverOnRecorderStateChangedJson {
  const MediaRecorderObserverOnRecorderStateChangedJson(
      {this.state, this.error});

  @JsonKey(name: 'state')
  final RecorderState? state;
  @JsonKey(name: 'error')
  final RecorderErrorCode? error;
  factory MediaRecorderObserverOnRecorderStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$MediaRecorderObserverOnRecorderStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MediaRecorderObserverOnRecorderStateChangedJsonToJson(this);
}

extension MediaRecorderObserverOnRecorderStateChangedJsonBufferExt
    on MediaRecorderObserverOnRecorderStateChangedJson {
  MediaRecorderObserverOnRecorderStateChangedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class MediaRecorderObserverOnRecorderInfoUpdatedJson {
  const MediaRecorderObserverOnRecorderInfoUpdatedJson({this.info});

  @JsonKey(name: 'info')
  final RecorderInfo? info;
  factory MediaRecorderObserverOnRecorderInfoUpdatedJson.fromJson(
          Map<String, dynamic> json) =>
      _$MediaRecorderObserverOnRecorderInfoUpdatedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MediaRecorderObserverOnRecorderInfoUpdatedJsonToJson(this);
}

extension MediaRecorderObserverOnRecorderInfoUpdatedJsonBufferExt
    on MediaRecorderObserverOnRecorderInfoUpdatedJson {
  MediaRecorderObserverOnRecorderInfoUpdatedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class MediaPlayerAudioFrameObserverOnFrameJson {
  const MediaPlayerAudioFrameObserverOnFrameJson({this.frame});

  @JsonKey(name: 'frame')
  final AudioPcmFrame? frame;
  factory MediaPlayerAudioFrameObserverOnFrameJson.fromJson(
          Map<String, dynamic> json) =>
      _$MediaPlayerAudioFrameObserverOnFrameJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MediaPlayerAudioFrameObserverOnFrameJsonToJson(this);
}

extension MediaPlayerAudioFrameObserverOnFrameJsonBufferExt
    on MediaPlayerAudioFrameObserverOnFrameJson {
  MediaPlayerAudioFrameObserverOnFrameJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class MediaPlayerVideoFrameObserverOnFrameJson {
  const MediaPlayerVideoFrameObserverOnFrameJson({this.frame});

  @JsonKey(name: 'frame')
  final VideoFrame? frame;
  factory MediaPlayerVideoFrameObserverOnFrameJson.fromJson(
          Map<String, dynamic> json) =>
      _$MediaPlayerVideoFrameObserverOnFrameJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MediaPlayerVideoFrameObserverOnFrameJsonToJson(this);
}

extension MediaPlayerVideoFrameObserverOnFrameJsonBufferExt
    on MediaPlayerVideoFrameObserverOnFrameJson {
  MediaPlayerVideoFrameObserverOnFrameJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class MediaPlayerSourceObserverOnPlayerSourceStateChangedJson {
  const MediaPlayerSourceObserverOnPlayerSourceStateChangedJson(
      {this.state, this.ec});

  @JsonKey(name: 'state')
  final MediaPlayerState? state;
  @JsonKey(name: 'ec')
  final MediaPlayerError? ec;
  factory MediaPlayerSourceObserverOnPlayerSourceStateChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$MediaPlayerSourceObserverOnPlayerSourceStateChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MediaPlayerSourceObserverOnPlayerSourceStateChangedJsonToJson(this);
}

extension MediaPlayerSourceObserverOnPlayerSourceStateChangedJsonBufferExt
    on MediaPlayerSourceObserverOnPlayerSourceStateChangedJson {
  MediaPlayerSourceObserverOnPlayerSourceStateChangedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class MediaPlayerSourceObserverOnPositionChangedJson {
  const MediaPlayerSourceObserverOnPositionChangedJson({this.positionMs});

  @JsonKey(name: 'position_ms')
  final int? positionMs;
  factory MediaPlayerSourceObserverOnPositionChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$MediaPlayerSourceObserverOnPositionChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MediaPlayerSourceObserverOnPositionChangedJsonToJson(this);
}

extension MediaPlayerSourceObserverOnPositionChangedJsonBufferExt
    on MediaPlayerSourceObserverOnPositionChangedJson {
  MediaPlayerSourceObserverOnPositionChangedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class MediaPlayerSourceObserverOnPlayerEventJson {
  const MediaPlayerSourceObserverOnPlayerEventJson(
      {this.eventCode, this.elapsedTime, this.message});

  @JsonKey(name: 'eventCode')
  final MediaPlayerEvent? eventCode;
  @JsonKey(name: 'elapsedTime')
  final int? elapsedTime;
  @JsonKey(name: 'message')
  final String? message;
  factory MediaPlayerSourceObserverOnPlayerEventJson.fromJson(
          Map<String, dynamic> json) =>
      _$MediaPlayerSourceObserverOnPlayerEventJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MediaPlayerSourceObserverOnPlayerEventJsonToJson(this);
}

extension MediaPlayerSourceObserverOnPlayerEventJsonBufferExt
    on MediaPlayerSourceObserverOnPlayerEventJson {
  MediaPlayerSourceObserverOnPlayerEventJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class MediaPlayerSourceObserverOnMetaDataJson {
  const MediaPlayerSourceObserverOnMetaDataJson({this.data, this.length});

  @JsonKey(name: 'data', ignore: true)
  final Uint8List? data;
  @JsonKey(name: 'length')
  final int? length;
  factory MediaPlayerSourceObserverOnMetaDataJson.fromJson(
          Map<String, dynamic> json) =>
      _$MediaPlayerSourceObserverOnMetaDataJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MediaPlayerSourceObserverOnMetaDataJsonToJson(this);
}

extension MediaPlayerSourceObserverOnMetaDataJsonBufferExt
    on MediaPlayerSourceObserverOnMetaDataJson {
  MediaPlayerSourceObserverOnMetaDataJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    Uint8List? data;
    if (bufferList.length > 0) {
      data = bufferList[0];
    }
    return MediaPlayerSourceObserverOnMetaDataJson(data: data, length: length);
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    if (data != null) {
      bufferList.add(data!);
    }
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class MediaPlayerSourceObserverOnPlayBufferUpdatedJson {
  const MediaPlayerSourceObserverOnPlayBufferUpdatedJson(
      {this.playCachedBuffer});

  @JsonKey(name: 'playCachedBuffer')
  final int? playCachedBuffer;
  factory MediaPlayerSourceObserverOnPlayBufferUpdatedJson.fromJson(
          Map<String, dynamic> json) =>
      _$MediaPlayerSourceObserverOnPlayBufferUpdatedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MediaPlayerSourceObserverOnPlayBufferUpdatedJsonToJson(this);
}

extension MediaPlayerSourceObserverOnPlayBufferUpdatedJsonBufferExt
    on MediaPlayerSourceObserverOnPlayBufferUpdatedJson {
  MediaPlayerSourceObserverOnPlayBufferUpdatedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class MediaPlayerSourceObserverOnPreloadEventJson {
  const MediaPlayerSourceObserverOnPreloadEventJson({this.src, this.event});

  @JsonKey(name: 'src')
  final String? src;
  @JsonKey(name: 'event')
  final PlayerPreloadEvent? event;
  factory MediaPlayerSourceObserverOnPreloadEventJson.fromJson(
          Map<String, dynamic> json) =>
      _$MediaPlayerSourceObserverOnPreloadEventJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MediaPlayerSourceObserverOnPreloadEventJsonToJson(this);
}

extension MediaPlayerSourceObserverOnPreloadEventJsonBufferExt
    on MediaPlayerSourceObserverOnPreloadEventJson {
  MediaPlayerSourceObserverOnPreloadEventJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class MediaPlayerSourceObserverOnCompletedJson {
  const MediaPlayerSourceObserverOnCompletedJson();

  factory MediaPlayerSourceObserverOnCompletedJson.fromJson(
          Map<String, dynamic> json) =>
      _$MediaPlayerSourceObserverOnCompletedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MediaPlayerSourceObserverOnCompletedJsonToJson(this);
}

extension MediaPlayerSourceObserverOnCompletedJsonBufferExt
    on MediaPlayerSourceObserverOnCompletedJson {
  MediaPlayerSourceObserverOnCompletedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class MediaPlayerSourceObserverOnAgoraCDNTokenWillExpireJson {
  const MediaPlayerSourceObserverOnAgoraCDNTokenWillExpireJson();

  factory MediaPlayerSourceObserverOnAgoraCDNTokenWillExpireJson.fromJson(
          Map<String, dynamic> json) =>
      _$MediaPlayerSourceObserverOnAgoraCDNTokenWillExpireJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MediaPlayerSourceObserverOnAgoraCDNTokenWillExpireJsonToJson(this);
}

extension MediaPlayerSourceObserverOnAgoraCDNTokenWillExpireJsonBufferExt
    on MediaPlayerSourceObserverOnAgoraCDNTokenWillExpireJson {
  MediaPlayerSourceObserverOnAgoraCDNTokenWillExpireJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class MediaPlayerSourceObserverOnPlayerSrcInfoChangedJson {
  const MediaPlayerSourceObserverOnPlayerSrcInfoChangedJson(
      {this.from, this.to});

  @JsonKey(name: 'from')
  final SrcInfo? from;
  @JsonKey(name: 'to')
  final SrcInfo? to;
  factory MediaPlayerSourceObserverOnPlayerSrcInfoChangedJson.fromJson(
          Map<String, dynamic> json) =>
      _$MediaPlayerSourceObserverOnPlayerSrcInfoChangedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MediaPlayerSourceObserverOnPlayerSrcInfoChangedJsonToJson(this);
}

extension MediaPlayerSourceObserverOnPlayerSrcInfoChangedJsonBufferExt
    on MediaPlayerSourceObserverOnPlayerSrcInfoChangedJson {
  MediaPlayerSourceObserverOnPlayerSrcInfoChangedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class MediaPlayerSourceObserverOnPlayerInfoUpdatedJson {
  const MediaPlayerSourceObserverOnPlayerInfoUpdatedJson({this.info});

  @JsonKey(name: 'info')
  final PlayerUpdatedInfo? info;
  factory MediaPlayerSourceObserverOnPlayerInfoUpdatedJson.fromJson(
          Map<String, dynamic> json) =>
      _$MediaPlayerSourceObserverOnPlayerInfoUpdatedJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MediaPlayerSourceObserverOnPlayerInfoUpdatedJsonToJson(this);
}

extension MediaPlayerSourceObserverOnPlayerInfoUpdatedJsonBufferExt
    on MediaPlayerSourceObserverOnPlayerInfoUpdatedJson {
  MediaPlayerSourceObserverOnPlayerInfoUpdatedJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class MediaPlayerSourceObserverOnAudioVolumeIndicationJson {
  const MediaPlayerSourceObserverOnAudioVolumeIndicationJson({this.volume});

  @JsonKey(name: 'volume')
  final int? volume;
  factory MediaPlayerSourceObserverOnAudioVolumeIndicationJson.fromJson(
          Map<String, dynamic> json) =>
      _$MediaPlayerSourceObserverOnAudioVolumeIndicationJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MediaPlayerSourceObserverOnAudioVolumeIndicationJsonToJson(this);
}

extension MediaPlayerSourceObserverOnAudioVolumeIndicationJsonBufferExt
    on MediaPlayerSourceObserverOnAudioVolumeIndicationJson {
  MediaPlayerSourceObserverOnAudioVolumeIndicationJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class MusicContentCenterEventHandlerOnMusicChartsResultJson {
  const MusicContentCenterEventHandlerOnMusicChartsResultJson(
      {this.requestId, this.status, this.result});

  @JsonKey(name: 'requestId')
  final String? requestId;
  @JsonKey(name: 'status')
  final MusicContentCenterStatusCode? status;
  @JsonKey(name: 'result')
  final List<MusicChartInfo>? result;
  factory MusicContentCenterEventHandlerOnMusicChartsResultJson.fromJson(
          Map<String, dynamic> json) =>
      _$MusicContentCenterEventHandlerOnMusicChartsResultJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MusicContentCenterEventHandlerOnMusicChartsResultJsonToJson(this);
}

extension MusicContentCenterEventHandlerOnMusicChartsResultJsonBufferExt
    on MusicContentCenterEventHandlerOnMusicChartsResultJson {
  MusicContentCenterEventHandlerOnMusicChartsResultJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class MusicContentCenterEventHandlerOnMusicCollectionResultJson {
  const MusicContentCenterEventHandlerOnMusicCollectionResultJson(
      {this.requestId, this.status, this.result});

  @JsonKey(name: 'requestId')
  final String? requestId;
  @JsonKey(name: 'status')
  final MusicContentCenterStatusCode? status;
  @JsonKey(name: 'result', ignore: true)
  final MusicCollection? result;
  factory MusicContentCenterEventHandlerOnMusicCollectionResultJson.fromJson(
          Map<String, dynamic> json) =>
      _$MusicContentCenterEventHandlerOnMusicCollectionResultJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MusicContentCenterEventHandlerOnMusicCollectionResultJsonToJson(this);
}

extension MusicContentCenterEventHandlerOnMusicCollectionResultJsonBufferExt
    on MusicContentCenterEventHandlerOnMusicCollectionResultJson {
  MusicContentCenterEventHandlerOnMusicCollectionResultJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class MusicContentCenterEventHandlerOnLyricResultJson {
  const MusicContentCenterEventHandlerOnLyricResultJson(
      {this.requestId, this.lyricUrl});

  @JsonKey(name: 'requestId')
  final String? requestId;
  @JsonKey(name: 'lyricUrl')
  final String? lyricUrl;
  factory MusicContentCenterEventHandlerOnLyricResultJson.fromJson(
          Map<String, dynamic> json) =>
      _$MusicContentCenterEventHandlerOnLyricResultJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MusicContentCenterEventHandlerOnLyricResultJsonToJson(this);
}

extension MusicContentCenterEventHandlerOnLyricResultJsonBufferExt
    on MusicContentCenterEventHandlerOnLyricResultJson {
  MusicContentCenterEventHandlerOnLyricResultJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

@JsonSerializable(explicitToJson: true)
class MusicContentCenterEventHandlerOnPreLoadEventJson {
  const MusicContentCenterEventHandlerOnPreLoadEventJson(
      {this.songCode, this.percent, this.status, this.msg, this.lyricUrl});

  @JsonKey(name: 'songCode')
  final int? songCode;
  @JsonKey(name: 'percent')
  final int? percent;
  @JsonKey(name: 'status')
  final PreloadStatusCode? status;
  @JsonKey(name: 'msg')
  final String? msg;
  @JsonKey(name: 'lyricUrl')
  final String? lyricUrl;
  factory MusicContentCenterEventHandlerOnPreLoadEventJson.fromJson(
          Map<String, dynamic> json) =>
      _$MusicContentCenterEventHandlerOnPreLoadEventJsonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MusicContentCenterEventHandlerOnPreLoadEventJsonToJson(this);
}

extension MusicContentCenterEventHandlerOnPreLoadEventJsonBufferExt
    on MusicContentCenterEventHandlerOnPreLoadEventJson {
  MusicContentCenterEventHandlerOnPreLoadEventJson fillBuffers(
      List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}
