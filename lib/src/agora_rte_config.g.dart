// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names, deprecated_member_use_from_same_package, unused_element

part of 'agora_rte_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgoraRteConfig _$AgoraRteConfigFromJson(Map<String, dynamic> json) =>
    AgoraRteConfig(
      appId: json['appId'] as String?,
      logFolder: json['logFolder'] as String?,
      logFileSize: (json['logFileSize'] as num?)?.toInt(),
      areaCode: (json['areaCode'] as num?)?.toInt(),
      cloudProxy: json['cloudProxy'] as String?,
      jsonParameter: json['jsonParameter'] as String?,
      useStringUid: json['useStringUid'] as bool?,
    );

Map<String, dynamic> _$AgoraRteConfigToJson(AgoraRteConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('appId', instance.appId);
  writeNotNull('logFolder', instance.logFolder);
  writeNotNull('logFileSize', instance.logFileSize);
  writeNotNull('areaCode', instance.areaCode);
  writeNotNull('cloudProxy', instance.cloudProxy);
  writeNotNull('jsonParameter', instance.jsonParameter);
  writeNotNull('useStringUid', instance.useStringUid);
  return val;
}
