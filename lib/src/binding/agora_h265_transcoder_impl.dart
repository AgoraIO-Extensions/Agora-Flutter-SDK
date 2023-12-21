/// GENERATED BY terra, DO NOT MODIFY BY HAND.

// ignore_for_file: public_member_api_docs, unused_local_variable, unused_import, annotate_overrides
import 'package:agora_rtc_engine/src/binding_forward_export.dart';
import 'package:agora_rtc_engine/src/binding/impl_forward_export.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

class H265TranscoderImpl implements H265Transcoder {
  H265TranscoderImpl(this.irisMethodChannel);

  @protected
  final IrisMethodChannel irisMethodChannel;

  @protected
  Map<String, dynamic> createParams(Map<String, dynamic> param) {
    return param;
  }

  @protected
  bool get isOverrideClassName => false;

  @protected
  String get className => 'H265Transcoder';

  @override
  Future<void> enableTranscode(
      {required String token,
      required String channel,
      required int uid}) async {
    const apiType =
        'IH265Transcoder__enableTranscode__const_char_ptr__const_char_ptr__agora_rtc_uid_t';
    final param =
        createParams({'token': token, 'channel': channel, 'uid': uid});
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
  Future<int> queryChannel(
      {required String token,
      required String channel,
      required int uid}) async {
    const apiType =
        'IH265Transcoder__queryChannel__const_char_ptr__const_char_ptr__agora_rtc_uid_t';
    final param =
        createParams({'token': token, 'channel': channel, 'uid': uid});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as int;
  }

  @override
  Future<void> triggerTranscode(
      {required String token,
      required String channel,
      required int uid}) async {
    const apiType =
        'IH265Transcoder__triggerTranscode__const_char_ptr__const_char_ptr__agora_rtc_uid_t';
    final param =
        createParams({'token': token, 'channel': channel, 'uid': uid});
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
  void registerTranscoderObserver(H265TranscoderObserver observer) {
// Implementation template
// const apiType = 'IH265Transcoder__registerTranscoderObserver__agora_rtc_IH265TranscoderObserver_ptr';
// final param = createParams({// 'observer':observer// });
// final callApiResult =  irisMethodChannel.invokeMethod(IrisMethodCall(apiType, jsonEncode(param), buffers:null));
// if (callApiResult.irisReturnCode < 0) {
// throw AgoraRtcException(code: callApiResult.irisReturnCode);
// }
// final rm = callApiResult.data;
// final result = rm['result'];
// if (result < 0) {
// throw AgoraRtcException(code: result);
// }
    throw UnimplementedError('Unimplement for registerTranscoderObserver');
  }

  @override
  void unregisterTranscoderObserver(H265TranscoderObserver observer) {
// Implementation template
// const apiType = 'IH265Transcoder__unregisterTranscoderObserver__agora_rtc_IH265TranscoderObserver_ptr';
// final param = createParams({// 'observer':observer// });
// final callApiResult =  irisMethodChannel.invokeMethod(IrisMethodCall(apiType, jsonEncode(param), buffers:null));
// if (callApiResult.irisReturnCode < 0) {
// throw AgoraRtcException(code: callApiResult.irisReturnCode);
// }
// final rm = callApiResult.data;
// final result = rm['result'];
// if (result < 0) {
// throw AgoraRtcException(code: result);
// }
    throw UnimplementedError('Unimplement for unregisterTranscoderObserver');
  }
}
