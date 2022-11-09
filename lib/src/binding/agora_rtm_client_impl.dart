import 'package:agora_rtc_engine/src/binding_forward_export.dart';
import 'package:agora_rtc_engine/src/binding/impl_forward_export.dart';
import 'package:iris_method_channel/iris_method_channel.dart';
// ignore_for_file: public_member_api_docs, unused_local_variable, annotate_overrides

class RtmClientImpl implements RtmClient {
  RtmClientImpl(this.irisMethodChannel);

  @protected
  final IrisMethodChannel irisMethodChannel;

  @protected
  Map<String, dynamic> createParams(Map<String, dynamic> param) {
    return param;
  }

  @protected
  bool get isOverrideClassName => false;

  @protected
  String get className => 'RtmClient';

  @override
  Future<void> initialize(RtmConfig config) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtmClient'}_initialize';
    final param = createParams({'config': config.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(config.collectBufferList());
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
  Future<void> release() async {
    final apiType = '${isOverrideClassName ? className : 'RtmClient'}_release';
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
  Future<StreamChannel> createStreamChannel(String channelName) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtmClient'}_createStreamChannel';
    final param = createParams({'channelName': channelName});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as StreamChannel;
  }
}
