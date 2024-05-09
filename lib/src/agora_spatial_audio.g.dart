// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names, deprecated_member_use_from_same_package, unused_element

part of 'agora_spatial_audio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteVoicePositionInfo _$RemoteVoicePositionInfoFromJson(
        Map<String, dynamic> json) =>
    RemoteVoicePositionInfo(
      position: (json['position'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      forward: (json['forward'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$RemoteVoicePositionInfoToJson(
    RemoteVoicePositionInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('position', instance.position);
  writeNotNull('forward', instance.forward);
  return val;
}

SpatialAudioZone _$SpatialAudioZoneFromJson(Map<String, dynamic> json) =>
    SpatialAudioZone(
      zoneSetId: (json['zoneSetId'] as num?)?.toInt(),
      position: (json['position'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      forward: (json['forward'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      right: (json['right'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      up: (json['up'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      forwardLength: (json['forwardLength'] as num?)?.toDouble(),
      rightLength: (json['rightLength'] as num?)?.toDouble(),
      upLength: (json['upLength'] as num?)?.toDouble(),
      audioAttenuation: (json['audioAttenuation'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SpatialAudioZoneToJson(SpatialAudioZone instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('zoneSetId', instance.zoneSetId);
  writeNotNull('position', instance.position);
  writeNotNull('forward', instance.forward);
  writeNotNull('right', instance.right);
  writeNotNull('up', instance.up);
  writeNotNull('forwardLength', instance.forwardLength);
  writeNotNull('rightLength', instance.rightLength);
  writeNotNull('upLength', instance.upLength);
  writeNotNull('audioAttenuation', instance.audioAttenuation);
  return val;
}
