// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names, deprecated_member_use_from_same_package, unused_element

part of 'agora_rtc_engine_ex.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RtcConnection _$RtcConnectionFromJson(Map<String, dynamic> json) =>
    RtcConnection(
      channelId: json['channelId'] as String?,
      localUid: (json['localUid'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RtcConnectionToJson(RtcConnection instance) =>
    <String, dynamic>{
      if (instance.channelId case final value?) 'channelId': value,
      if (instance.localUid case final value?) 'localUid': value,
    };
