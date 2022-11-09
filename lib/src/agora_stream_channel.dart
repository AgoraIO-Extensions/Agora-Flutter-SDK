import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_stream_channel.g.dart';

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum RtmMessageQos {
  /// @nodoc
  @JsonValue(0)
  rtmMessageQosUnordered,

  /// @nodoc
  @JsonValue(1)
  rtmMessageQosOrdered,
}

/// @nodoc
extension RtmMessageQosExt on RtmMessageQos {
  /// @nodoc
  static RtmMessageQos fromValue(int value) {
    return $enumDecode(_$RtmMessageQosEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$RtmMessageQosEnumMap[this]!;
  }
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class JoinChannelOptions {
  /// @nodoc
  const JoinChannelOptions({this.token});

  /// @nodoc
  @JsonKey(name: 'token')
  final String? token;

  /// @nodoc
  factory JoinChannelOptions.fromJson(Map<String, dynamic> json) =>
      _$JoinChannelOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$JoinChannelOptionsToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class JoinTopicOptions {
  /// @nodoc
  const JoinTopicOptions({this.qos, this.meta, this.metaLength});

  /// @nodoc
  @JsonKey(name: 'qos')
  final RtmMessageQos? qos;

  /// @nodoc
  @JsonKey(name: 'meta', ignore: true)
  final Uint8List? meta;

  /// @nodoc
  @JsonKey(name: 'metaLength')
  final int? metaLength;

  /// @nodoc
  factory JoinTopicOptions.fromJson(Map<String, dynamic> json) =>
      _$JoinTopicOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$JoinTopicOptionsToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TopicOptions {
  /// @nodoc
  const TopicOptions({this.users, this.userCount});

  /// @nodoc
  @JsonKey(name: 'users')
  final List<String>? users;

  /// @nodoc
  @JsonKey(name: 'userCount')
  final int? userCount;

  /// @nodoc
  factory TopicOptions.fromJson(Map<String, dynamic> json) =>
      _$TopicOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$TopicOptionsToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class UserList {
  /// @nodoc
  const UserList({this.users, this.userCount});

  /// @nodoc
  @JsonKey(name: 'users')
  final List<String>? users;

  /// @nodoc
  @JsonKey(name: 'userCount')
  final int? userCount;

  /// @nodoc
  factory UserList.fromJson(Map<String, dynamic> json) =>
      _$UserListFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$UserListToJson(this);
}

/// @nodoc
abstract class StreamChannel {
  /// @nodoc
  Future<void> join(JoinChannelOptions options);

  /// @nodoc
  Future<void> leave();

  /// @nodoc
  Future<String> getChannelName();

  /// @nodoc
  Future<void> joinTopic(
      {required String topic, required JoinTopicOptions options});

  /// @nodoc
  Future<void> publishTopicMessage(
      {required String topic, required Uint8List message, required int length});

  /// @nodoc
  Future<void> leaveTopic(String topic);

  /// @nodoc
  Future<void> subscribeTopic(
      {required String topic, required TopicOptions options});

  /// @nodoc
  Future<void> unsubscribeTopic(
      {required String topic, required TopicOptions options});

  /// @nodoc
  Future<UserList> getSubscribedUserList(String topic);

  /// @nodoc
  Future<void> release();
}
