// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names, deprecated_member_use_from_same_package, unused_element

part of 'agora_rtm_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RtmConfig _$RtmConfigFromJson(Map<String, dynamic> json) => RtmConfig(
      appId: json['appId'] as String?,
      userId: json['userId'] as String?,
      useStringUserId: json['useStringUserId'] as bool?,
      logConfig: json['logConfig'] == null
          ? null
          : LogConfig.fromJson(json['logConfig'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RtmConfigToJson(RtmConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('appId', instance.appId);
  writeNotNull('userId', instance.userId);
  writeNotNull('useStringUserId', instance.useStringUserId);
  writeNotNull('logConfig', instance.logConfig?.toJson());
  return val;
}

TopicInfo _$TopicInfoFromJson(Map<String, dynamic> json) => TopicInfo(
      topic: json['topic'] as String?,
      numOfPublisher: json['numOfPublisher'] as int?,
      publisherUserIds: (json['publisherUserIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      publisherMetas: (json['publisherMetas'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$TopicInfoToJson(TopicInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('topic', instance.topic);
  writeNotNull('numOfPublisher', instance.numOfPublisher);
  writeNotNull('publisherUserIds', instance.publisherUserIds);
  writeNotNull('publisherMetas', instance.publisherMetas);
  return val;
}

MessageEvent _$MessageEventFromJson(Map<String, dynamic> json) => MessageEvent(
      channelType:
          $enumDecodeNullable(_$RtmChannelTypeEnumMap, json['channelType']),
      channelName: json['channelName'] as String?,
      channelTopic: json['channelTopic'] as String?,
      messageLength: json['messageLength'] as int?,
      publisher: json['publisher'] as String?,
    );

Map<String, dynamic> _$MessageEventToJson(MessageEvent instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('channelType', _$RtmChannelTypeEnumMap[instance.channelType]);
  writeNotNull('channelName', instance.channelName);
  writeNotNull('channelTopic', instance.channelTopic);
  writeNotNull('messageLength', instance.messageLength);
  writeNotNull('publisher', instance.publisher);
  return val;
}

const _$RtmChannelTypeEnumMap = {
  RtmChannelType.rtmChannelTypeMessage: 0,
  RtmChannelType.rtmChannelTypeStream: 1,
};

PresenceEvent _$PresenceEventFromJson(Map<String, dynamic> json) =>
    PresenceEvent(
      channelType:
          $enumDecodeNullable(_$RtmChannelTypeEnumMap, json['channelType']),
      type: $enumDecodeNullable(_$RtmPresenceTypeEnumMap, json['type']),
      channelName: json['channelName'] as String?,
      topicInfos: (json['topicInfos'] as List<dynamic>?)
          ?.map((e) => TopicInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      topicInfoNumber: json['topicInfoNumber'] as int?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$PresenceEventToJson(PresenceEvent instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('channelType', _$RtmChannelTypeEnumMap[instance.channelType]);
  writeNotNull('type', _$RtmPresenceTypeEnumMap[instance.type]);
  writeNotNull('channelName', instance.channelName);
  writeNotNull(
      'topicInfos', instance.topicInfos?.map((e) => e.toJson()).toList());
  writeNotNull('topicInfoNumber', instance.topicInfoNumber);
  writeNotNull('userId', instance.userId);
  return val;
}

const _$RtmPresenceTypeEnumMap = {
  RtmPresenceType.rtmPresenceTypeRemoteJoinChannel: 0,
  RtmPresenceType.rtmPresenceTypeRemoteLeaveChannel: 1,
  RtmPresenceType.rtmPresenceTypeRemoteConnectionTimeout: 2,
  RtmPresenceType.rtmPresenceTypeRemoteJoinTopic: 3,
  RtmPresenceType.rtmPresenceTypeRemoteLeaveTopic: 4,
  RtmPresenceType.rtmPresenceTypeSelfJoinChannel: 5,
};

const _$RtmErrorCodeEnumMap = {
  RtmErrorCode.rtmErrTopicAlreadyJoined: 10001,
  RtmErrorCode.rtmErrExceedJoinTopicLimitation: 10002,
  RtmErrorCode.rtmErrInvalidTopicName: 10003,
  RtmErrorCode.rtmErrPublishTopicMessageFailed: 10004,
  RtmErrorCode.rtmErrExceedSubscribeTopicLimitation: 10005,
  RtmErrorCode.rtmErrExceedUserLimitation: 10006,
  RtmErrorCode.rtmErrExceedChannelLimitation: 10007,
  RtmErrorCode.rtmErrAlreadyJoinChannel: 10008,
  RtmErrorCode.rtmErrNotJoinChannel: 10009,
};

const _$RtmConnectionStateEnumMap = {
  RtmConnectionState.rtmConnectionStateDisconnected: 1,
  RtmConnectionState.rtmConnectionStateConnecting: 2,
  RtmConnectionState.rtmConnectionStateConnected: 3,
  RtmConnectionState.rtmConnectionStateReconnecting: 4,
  RtmConnectionState.rtmConnectionStateFailed: 5,
};

const _$RtmConnectionChangeReasonEnumMap = {
  RtmConnectionChangeReason.rtmConnectionChangedConnecting: 0,
  RtmConnectionChangeReason.rtmConnectionChangedJoinSuccess: 1,
  RtmConnectionChangeReason.rtmConnectionChangedInterrupted: 2,
  RtmConnectionChangeReason.rtmConnectionChangedBannedByServer: 3,
  RtmConnectionChangeReason.rtmConnectionChangedJoinFailed: 4,
  RtmConnectionChangeReason.rtmConnectionChangedLeaveChannel: 5,
  RtmConnectionChangeReason.rtmConnectionChangedInvalidAppId: 6,
  RtmConnectionChangeReason.rtmConnectionChangedInvalidChannelName: 7,
  RtmConnectionChangeReason.rtmConnectionChangedInvalidToken: 8,
  RtmConnectionChangeReason.rtmConnectionChangedTokenExpired: 9,
  RtmConnectionChangeReason.rtmConnectionChangedRejectedByServer: 10,
  RtmConnectionChangeReason.rtmConnectionChangedSettingProxyServer: 11,
  RtmConnectionChangeReason.rtmConnectionChangedRenewToken: 12,
  RtmConnectionChangeReason.rtmConnectionChangedClientIpAddressChanged: 13,
  RtmConnectionChangeReason.rtmConnectionChangedKeepAliveTimeout: 14,
  RtmConnectionChangeReason.rtmConnectionChangedRejoinSuccess: 15,
  RtmConnectionChangeReason.rtmConnectionChangedLost: 16,
  RtmConnectionChangeReason.rtmConnectionChangedEchoTest: 17,
  RtmConnectionChangeReason.rtmConnectionChangedClientIpAddressChangedByUser:
      18,
  RtmConnectionChangeReason.rtmConnectionChangedSameUidLogin: 19,
  RtmConnectionChangeReason.rtmConnectionChangedTooManyBroadcasters: 20,
};

const _$StreamChannelErrorCodeEnumMap = {
  StreamChannelErrorCode.streamChannelErrorOk: 0,
  StreamChannelErrorCode.streamChannelErrorExceedLimitation: 1,
  StreamChannelErrorCode.streamChannelErrorUserNotExist: 2,
};
