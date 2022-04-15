import 'package:agora_rtc_engine/src/classes.dart';
import 'package:agora_rtc_engine/src/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_handler_json.g.dart';

// ignore_for_file: public_member_api_docs

@JsonSerializable()
class ScreenCaptureInfoJson {
  final ScreenCaptureInfo info;

  const ScreenCaptureInfoJson(this.info);

  /// @nodoc
  factory ScreenCaptureInfoJson.fromJson(Map<String, dynamic> json) =>
      _$ScreenCaptureInfoJsonFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ScreenCaptureInfoJsonToJson(this);
}

@JsonSerializable()
class OnClientRoleChangeFailedJson {
  final ClientRoleChangeFailedReason reason;
  final ClientRole currentRole;

  const OnClientRoleChangeFailedJson(this.reason, this.currentRole);

  /// @nodoc
  factory OnClientRoleChangeFailedJson.fromJson(Map<String, dynamic> json) =>
      _$OnClientRoleChangeFailedJsonFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$OnClientRoleChangeFailedJsonToJson(this);
}

@JsonSerializable()
class OnWlAccMessageJson {
  final WlaccMessageReason reason;
  final WlaccSuggestAction action;
  final String wlAccMsg;

  const OnWlAccMessageJson(this.reason, this.action, this.wlAccMsg);

  /// @nodoc
  factory OnWlAccMessageJson.fromJson(Map<String, dynamic> json) =>
      _$OnWlAccMessageJsonFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$OnWlAccMessageJsonToJson(this);
}

@JsonSerializable()
class OnWlAccStatsJson {
  final WlAccStats currentStats;
  final WlAccStats averageStats;

  OnWlAccStatsJson(this.currentStats, this.averageStats);

  /// @nodoc
  factory OnWlAccStatsJson.fromJson(Map<String, dynamic> json) =>
      _$OnWlAccStatsJsonFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$OnWlAccStatsJsonToJson(this);
}

@JsonSerializable()
class OnProxyConnectedJson {
  final String channel;
  final int uid;
  final ProxyType proxyType;
  final String localProxyIp;
  final int elapsed;

  const OnProxyConnectedJson(
    this.channel,
    this.uid,
    this.proxyType,
    this.localProxyIp,
    this.elapsed,
  );

  /// @nodoc
  factory OnProxyConnectedJson.fromJson(Map<String, dynamic> json) =>
      _$OnProxyConnectedJsonFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$OnProxyConnectedJsonToJson(this);
}

@JsonSerializable()
class OnAudioDeviceTestVolumeIndicationJson {
  final AudioDeviceTestVolumeType volumeType;
  final int volume;

  const OnAudioDeviceTestVolumeIndicationJson(this.volumeType, this.volume);

  /// @nodoc
  factory OnAudioDeviceTestVolumeIndicationJson.fromJson(
          Map<String, dynamic> json) =>
      _$OnAudioDeviceTestVolumeIndicationJsonFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() =>
      _$OnAudioDeviceTestVolumeIndicationJsonToJson(this);
}

@JsonSerializable()
class OnRecorderStateChangedJson {
  final RecorderState state;
  final RecorderErrorCode error;

  const OnRecorderStateChangedJson(this.state, this.error);

  factory OnRecorderStateChangedJson.fromJson(Map<String, dynamic> json) =>
      _$OnRecorderStateChangedJsonFromJson(json);

  Map<String, dynamic> toJson() => _$OnRecorderStateChangedJsonToJson(this);
}

@JsonSerializable()
class OnRecorderInfoUpdatedJson {
  final RecorderInfo info;

  const OnRecorderInfoUpdatedJson(this.info);

  factory OnRecorderInfoUpdatedJson.fromJson(Map<String, dynamic> json) =>
      _$OnRecorderInfoUpdatedJsonFromJson(json);

  Map<String, dynamic> toJson() => _$OnRecorderInfoUpdatedJsonToJson(this);
}

@JsonSerializable()
class OnContentInspectResultJson {
  final ContentInspectResult result;
  const OnContentInspectResultJson(this.result);

  factory OnContentInspectResultJson.fromJson(Map<String, dynamic> json) =>
      _$OnContentInspectResultJsonFromJson(json);

  Map<String, dynamic> toJson() => _$OnContentInspectResultJsonToJson(this);
}
