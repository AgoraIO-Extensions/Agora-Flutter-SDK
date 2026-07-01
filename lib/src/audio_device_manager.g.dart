// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names, deprecated_member_use_from_same_package, unused_element

part of 'audio_device_manager.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecordingDeviceTestConfiguration _$RecordingDeviceTestConfigurationFromJson(
        Map<String, dynamic> json) =>
    RecordingDeviceTestConfiguration(
      indicationInterval: (json['indicationInterval'] as num?)?.toInt(),
      enablePlayback: json['enablePlayback'] as bool?,
    );

Map<String, dynamic> _$RecordingDeviceTestConfigurationToJson(
    RecordingDeviceTestConfiguration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('indicationInterval', instance.indicationInterval);
  writeNotNull('enablePlayback', instance.enablePlayback);
  return val;
}

const _$MaxDeviceIdLengthTypeEnumMap = {
  MaxDeviceIdLengthType.maxDeviceIdLength: 512,
};
