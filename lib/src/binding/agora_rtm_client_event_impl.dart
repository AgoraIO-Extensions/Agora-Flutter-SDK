import 'package:agora_rtc_engine/src/binding_forward_export.dart';
import 'package:agora_rtc_engine/src/binding/impl_forward_export.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

// ignore_for_file: public_member_api_docs, unused_local_variable

class RtmEventHandlerWrapper implements EventLoopEventHandler {
  const RtmEventHandlerWrapper(this.rtmEventHandler);
  final RtmEventHandler rtmEventHandler;
  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is RtmEventHandlerWrapper &&
        other.rtmEventHandler == rtmEventHandler;
  }

  @override
  int get hashCode => rtmEventHandler.hashCode;
  @override
  bool handleEventInternal(
      String eventName, String eventData, List<Uint8List> buffers) {
    switch (eventName) {
      case 'onMessageEvent':
        if (rtmEventHandler.onMessageEvent == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtmEventHandlerOnMessageEventJson paramJson =
            RtmEventHandlerOnMessageEventJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        MessageEvent? event = paramJson.event;
        if (event == null) {
          return true;
        }
        event = event.fillBuffers(buffers);
        rtmEventHandler.onMessageEvent!(event);
        return true;

      case 'onPresenceEvent':
        if (rtmEventHandler.onPresenceEvent == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtmEventHandlerOnPresenceEventJson paramJson =
            RtmEventHandlerOnPresenceEventJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        PresenceEvent? event = paramJson.event;
        if (event == null) {
          return true;
        }
        event = event.fillBuffers(buffers);
        rtmEventHandler.onPresenceEvent!(event);
        return true;

      case 'onJoinResult':
        if (rtmEventHandler.onJoinResult == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtmEventHandlerOnJoinResultJson paramJson =
            RtmEventHandlerOnJoinResultJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? channelName = paramJson.channelName;
        String? userId = paramJson.userId;
        StreamChannelErrorCode? errorCode = paramJson.errorCode;
        if (channelName == null || userId == null || errorCode == null) {
          return true;
        }
        rtmEventHandler.onJoinResult!(channelName, userId, errorCode);
        return true;

      case 'onLeaveResult':
        if (rtmEventHandler.onLeaveResult == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtmEventHandlerOnLeaveResultJson paramJson =
            RtmEventHandlerOnLeaveResultJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? channelName = paramJson.channelName;
        String? userId = paramJson.userId;
        StreamChannelErrorCode? errorCode = paramJson.errorCode;
        if (channelName == null || userId == null || errorCode == null) {
          return true;
        }
        rtmEventHandler.onLeaveResult!(channelName, userId, errorCode);
        return true;

      case 'onJoinTopicResult':
        if (rtmEventHandler.onJoinTopicResult == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtmEventHandlerOnJoinTopicResultJson paramJson =
            RtmEventHandlerOnJoinTopicResultJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? channelName = paramJson.channelName;
        String? userId = paramJson.userId;
        String? topic = paramJson.topic;
        String? meta = paramJson.meta;
        StreamChannelErrorCode? errorCode = paramJson.errorCode;
        if (channelName == null ||
            userId == null ||
            topic == null ||
            meta == null ||
            errorCode == null) {
          return true;
        }
        rtmEventHandler.onJoinTopicResult!(
            channelName, userId, topic, meta, errorCode);
        return true;

      case 'onLeaveTopicResult':
        if (rtmEventHandler.onLeaveTopicResult == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtmEventHandlerOnLeaveTopicResultJson paramJson =
            RtmEventHandlerOnLeaveTopicResultJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? channelName = paramJson.channelName;
        String? userId = paramJson.userId;
        String? topic = paramJson.topic;
        String? meta = paramJson.meta;
        StreamChannelErrorCode? errorCode = paramJson.errorCode;
        if (channelName == null ||
            userId == null ||
            topic == null ||
            meta == null ||
            errorCode == null) {
          return true;
        }
        rtmEventHandler.onLeaveTopicResult!(
            channelName, userId, topic, meta, errorCode);
        return true;

      case 'onTopicSubscribed':
        if (rtmEventHandler.onTopicSubscribed == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtmEventHandlerOnTopicSubscribedJson paramJson =
            RtmEventHandlerOnTopicSubscribedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? channelName = paramJson.channelName;
        String? userId = paramJson.userId;
        String? topic = paramJson.topic;
        UserList? succeedUsers = paramJson.succeedUsers;
        UserList? failedUsers = paramJson.failedUsers;
        StreamChannelErrorCode? errorCode = paramJson.errorCode;
        if (channelName == null ||
            userId == null ||
            topic == null ||
            succeedUsers == null ||
            failedUsers == null ||
            errorCode == null) {
          return true;
        }
        succeedUsers = succeedUsers.fillBuffers(buffers);
        failedUsers = failedUsers.fillBuffers(buffers);
        rtmEventHandler.onTopicSubscribed!(
            channelName, userId, topic, succeedUsers, failedUsers, errorCode);
        return true;

      case 'onTopicUnsubscribed':
        if (rtmEventHandler.onTopicUnsubscribed == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtmEventHandlerOnTopicUnsubscribedJson paramJson =
            RtmEventHandlerOnTopicUnsubscribedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? channelName = paramJson.channelName;
        String? userId = paramJson.userId;
        String? topic = paramJson.topic;
        UserList? succeedUsers = paramJson.succeedUsers;
        UserList? failedUsers = paramJson.failedUsers;
        StreamChannelErrorCode? errorCode = paramJson.errorCode;
        if (channelName == null ||
            userId == null ||
            topic == null ||
            succeedUsers == null ||
            failedUsers == null ||
            errorCode == null) {
          return true;
        }
        succeedUsers = succeedUsers.fillBuffers(buffers);
        failedUsers = failedUsers.fillBuffers(buffers);
        rtmEventHandler.onTopicUnsubscribed!(
            channelName, userId, topic, succeedUsers, failedUsers, errorCode);
        return true;

      case 'onConnectionStateChange':
        if (rtmEventHandler.onConnectionStateChange == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtmEventHandlerOnConnectionStateChangeJson paramJson =
            RtmEventHandlerOnConnectionStateChangeJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? channelName = paramJson.channelName;
        RtmConnectionState? state = paramJson.state;
        RtmConnectionChangeReason? reason = paramJson.reason;
        if (channelName == null || state == null || reason == null) {
          return true;
        }
        rtmEventHandler.onConnectionStateChange!(channelName, state, reason);
        return true;
    }
    return false;
  }

  @override
  bool handleEvent(
      String eventName, String eventData, List<Uint8List> buffers) {
    if (!eventName.startsWith('RtmEventHandler')) return false;
    final newEvent = eventName.replaceFirst('RtmEventHandler_', '');
    if (handleEventInternal(newEvent, eventData, buffers)) {
      return true;
    }

    return false;
  }
}
