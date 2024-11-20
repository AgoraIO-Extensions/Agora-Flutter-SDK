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
        RemoteVoicePositionInfo instance) =>
    <String, dynamic>{
      if (instance.position case final value?) 'position': value,
      if (instance.forward case final value?) 'forward': value,
    };

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

Map<String, dynamic> _$SpatialAudioZoneToJson(SpatialAudioZone instance) =>
    <String, dynamic>{
      if (instance.zoneSetId case final value?) 'zoneSetId': value,
      if (instance.position case final value?) 'position': value,
      if (instance.forward case final value?) 'forward': value,
      if (instance.right case final value?) 'right': value,
      if (instance.up case final value?) 'up': value,
      if (instance.forwardLength case final value?) 'forwardLength': value,
      if (instance.rightLength case final value?) 'rightLength': value,
      if (instance.upLength case final value?) 'upLength': value,
      if (instance.audioAttenuation case final value?)
        'audioAttenuation': value,
    };
