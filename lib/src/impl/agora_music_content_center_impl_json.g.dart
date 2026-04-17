// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names, deprecated_member_use_from_same_package, unused_element

part of 'agora_music_content_center_impl_json.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicCollectionJson _$MusicCollectionJsonFromJson(Map<String, dynamic> json) =>
    MusicCollectionJson(
      count: (json['count'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      music: (json['music'] as List<dynamic>?)
          ?.map((e) => Music.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MusicCollectionJsonToJson(MusicCollectionJson instance) {
  final val = <String, dynamic>{
    'count': instance.count,
    'total': instance.total,
    'page': instance.page,
    'pageSize': instance.pageSize,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('music', instance.music?.map((e) => e.toJson()).toList());
  return val;
}
