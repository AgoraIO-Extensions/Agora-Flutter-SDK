// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names, deprecated_member_use_from_same_package, unused_element

part of 'json_converters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VideoFrameMetaInfoInternalJson _$VideoFrameMetaInfoInternalJsonFromJson(
        Map<String, dynamic> json) =>
    _VideoFrameMetaInfoInternalJson(
      KEY_FACE_CAPTURE: json['KEY_FACE_CAPTURE'] as String?,
    );

Map<String, dynamic> _$VideoFrameMetaInfoInternalJsonToJson(
    _VideoFrameMetaInfoInternalJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('KEY_FACE_CAPTURE', instance.KEY_FACE_CAPTURE);
  return val;
}
