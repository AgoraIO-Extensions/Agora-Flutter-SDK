import 'package:agora_rtc_engine/src/binding_forward_export.dart';
import 'package:agora_rtc_engine/src/binding/impl_forward_export.dart';
import 'package:iris_method_channel/iris_method_channel.dart';
// ignore_for_file: public_member_api_docs, unused_local_variable, annotate_overrides

class StreamChannelImpl implements StreamChannel {
  StreamChannelImpl(this.irisMethodChannel);

  @protected
  final IrisMethodChannel irisMethodChannel;

  @protected
  Map<String, dynamic> createParams(Map<String, dynamic> param) {
    return param;
  }

  @protected
  bool get isOverrideClassName => false;

  @protected
  String get className => 'StreamChannel';

  @override
  Future<void> join(JoinChannelOptions options) async {
    final apiType = '${isOverrideClassName ? className : 'StreamChannel'}_join';
    final param = createParams({'options': options.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(options.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> leave() async {
    final apiType =
        '${isOverrideClassName ? className : 'StreamChannel'}_leave';
    final param = createParams({});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<String> getChannelName() async {
    final apiType =
        '${isOverrideClassName ? className : 'StreamChannel'}_getChannelName';
    final param = createParams({});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as String;
  }

  @override
  Future<void> joinTopic(
      {required String topic, required JoinTopicOptions options}) async {
    final apiType =
        '${isOverrideClassName ? className : 'StreamChannel'}_joinTopic';
    final param = createParams({'topic': topic, 'options': options.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(options.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> publishTopicMessage(
      {required String topic,
      required Uint8List message,
      required int length}) async {
    final apiType =
        '${isOverrideClassName ? className : 'StreamChannel'}_publishTopicMessage';
    final param = createParams({'topic': topic, 'length': length});
    final List<Uint8List> buffers = [];
    buffers.add(message);
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> leaveTopic(String topic) async {
    final apiType =
        '${isOverrideClassName ? className : 'StreamChannel'}_leaveTopic';
    final param = createParams({'topic': topic});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> subscribeTopic(
      {required String topic, required TopicOptions options}) async {
    final apiType =
        '${isOverrideClassName ? className : 'StreamChannel'}_subscribeTopic';
    final param = createParams({'topic': topic, 'options': options.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(options.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> unsubscribeTopic(
      {required String topic, required TopicOptions options}) async {
    final apiType =
        '${isOverrideClassName ? className : 'StreamChannel'}_unsubscribeTopic';
    final param = createParams({'topic': topic, 'options': options.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(options.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<UserList> getSubscribedUserList(String topic) async {
    final apiType =
        '${isOverrideClassName ? className : 'StreamChannel'}_getSubscribedUserList';
    final param = createParams({'topic': topic});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
    final getSubscribedUserListJson =
        StreamChannelGetSubscribedUserListJson.fromJson(rm);
    return getSubscribedUserListJson.users;
  }

  @override
  Future<void> release() async {
    final apiType =
        '${isOverrideClassName ? className : 'StreamChannel'}_release';
    final param = createParams({});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }
}
