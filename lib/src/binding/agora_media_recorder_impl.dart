import 'package:agora_rtc_engine/src/binding_forward_export.dart';
import 'package:agora_rtc_engine/src/binding/impl_forward_export.dart';
// ignore_for_file: public_member_api_docs, unused_local_variable, annotate_overrides

class MediaRecorderImpl implements MediaRecorder {
  @protected
  Map<String, dynamic> createParams(Map<String, dynamic> param) {
    return param;
  }

  @protected
  bool get isOverrideClassName => false;

  @protected
  String get className => 'MediaRecorder';

  @override
  Future<void> setMediaRecorderObserver(
      {required RtcConnection connection,
      required MediaRecorderObserver callback}) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaRecorder'}_setMediaRecorderObserver';
    final param =
        createParams({'connection': connection.toJson(), 'callback': callback});
    final List<Uint8List> buffers = [];
    buffers.addAll(connection.collectBufferList());
    final callApiResult = await apiCaller
        .callIrisApi(apiType, jsonEncode(param), buffers: buffers);
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
  Future<void> startRecording(
      {required RtcConnection connection,
      required MediaRecorderConfiguration config}) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaRecorder'}_startRecording';
    final param = createParams(
        {'connection': connection.toJson(), 'config': config.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(connection.collectBufferList());
    buffers.addAll(config.collectBufferList());
    final callApiResult = await apiCaller
        .callIrisApi(apiType, jsonEncode(param), buffers: buffers);
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
  Future<void> stopRecording(RtcConnection connection) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaRecorder'}_stopRecording';
    final param = createParams({'connection': connection.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(connection.collectBufferList());
    final callApiResult = await apiCaller
        .callIrisApi(apiType, jsonEncode(param), buffers: buffers);
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
    final apiType =
        '${isOverrideClassName ? className : 'MediaRecorder'}_release';
    final param = createParams({});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
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
