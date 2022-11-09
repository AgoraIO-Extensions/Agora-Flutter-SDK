// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names, deprecated_member_use_from_same_package, unused_element

part of 'agora_stream_channel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JoinChannelOptions _$JoinChannelOptionsFromJson(Map<String, dynamic> json) =>
    JoinChannelOptions(
      token: json['token'] as String?,
    );

Map<String, dynamic> _$JoinChannelOptionsToJson(JoinChannelOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('token', instance.token);
  return val;
}

JoinTopicOptions _$JoinTopicOptionsFromJson(Map<String, dynamic> json) =>
    JoinTopicOptions(
      qos: $enumDecodeNullable(_$RtmMessageQosEnumMap, json['qos']),
      metaLength: json['metaLength'] as int?,
    );

Map<String, dynamic> _$JoinTopicOptionsToJson(JoinTopicOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('qos', _$RtmMessageQosEnumMap[instance.qos]);
  writeNotNull('metaLength', instance.metaLength);
  return val;
}

const _$RtmMessageQosEnumMap = {
  RtmMessageQos.rtmMessageQosUnordered: 0,
  RtmMessageQos.rtmMessageQosOrdered: 1,
};

TopicOptions _$TopicOptionsFromJson(Map<String, dynamic> json) => TopicOptions(
      users:
          (json['users'] as List<dynamic>?)?.map((e) => e as String).toList(),
      userCount: json['userCount'] as int?,
    );

Map<String, dynamic> _$TopicOptionsToJson(TopicOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('users', instance.users);
  writeNotNull('userCount', instance.userCount);
  return val;
}

UserList _$UserListFromJson(Map<String, dynamic> json) => UserList(
      users:
          (json['users'] as List<dynamic>?)?.map((e) => e as String).toList(),
      userCount: json['userCount'] as int?,
    );

Map<String, dynamic> _$UserListToJson(UserList instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('users', instance.users);
  writeNotNull('userCount', instance.userCount);
  return val;
}
