// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names, deprecated_member_use_from_same_package, unused_element

part of 'agora_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogConfig _$LogConfigFromJson(Map<String, dynamic> json) => LogConfig(
      filePath: json['filePath'] as String?,
      fileSizeInKB: (json['fileSizeInKB'] as num?)?.toInt(),
      level: $enumDecodeNullable(_$LogLevelEnumMap, json['level']),
    );

Map<String, dynamic> _$LogConfigToJson(LogConfig instance) => <String, dynamic>{
      if (instance.filePath case final value?) 'filePath': value,
      if (instance.fileSizeInKB case final value?) 'fileSizeInKB': value,
      if (_$LogLevelEnumMap[instance.level] case final value?) 'level': value,
    };

const _$LogLevelEnumMap = {
  LogLevel.logLevelNone: 0,
  LogLevel.logLevelInfo: 1,
  LogLevel.logLevelWarn: 2,
  LogLevel.logLevelError: 4,
  LogLevel.logLevelFatal: 8,
  LogLevel.logLevelApiCall: 16,
};

const _$LogFilterTypeEnumMap = {
  LogFilterType.logFilterOff: 0,
  LogFilterType.logFilterDebug: 2063,
  LogFilterType.logFilterInfo: 15,
  LogFilterType.logFilterWarn: 14,
  LogFilterType.logFilterError: 12,
  LogFilterType.logFilterCritical: 8,
  LogFilterType.logFilterMask: 2063,
};
