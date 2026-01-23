import '/src/_serializable.dart';
import '/src/binding_forward_export.dart';
part 'agora_rte_config.g.dart';

/// RTE configuration
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AgoraRteConfig implements AgoraSerializable {
  @JsonKey(name: 'appId')
  final String? appId;
  @JsonKey(name: 'logFolder')
  final String? logFolder;
  @JsonKey(name: 'logFileSize')
  final int? logFileSize;
  @JsonKey(name: 'areaCode')
  final int? areaCode;
  @JsonKey(name: 'cloudProxy')
  final String? cloudProxy;
  @JsonKey(name: 'jsonParameter')
  final String? jsonParameter;
  @JsonKey(name: 'useStringUid')
  final bool? useStringUid;

  AgoraRteConfig({
    this.appId,
    this.logFolder,
    this.logFileSize,
    this.areaCode,
    this.cloudProxy,
    this.jsonParameter,
    this.useStringUid,
  });

  /// @nodoc
  factory AgoraRteConfig.fromJson(Map<String, dynamic> json) =>
      _$AgoraRteConfigFromJson(json);

  /// @nodoc
  @override
  Map<String, dynamic> toJson() => _$AgoraRteConfigToJson(this);
}
