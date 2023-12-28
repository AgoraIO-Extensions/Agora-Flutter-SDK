import 'dart:convert';
import 'dart:typed_data';

import 'package:agora_rtc_engine/src/agora_rtc_engine_ext.dart';
import 'package:agora_rtc_engine/src/binding/agora_spatial_audio_impl.dart'
    as spatial_audio_binding;
import 'package:iris_method_channel/iris_method_channel.dart';

// ignore_for_file: public_member_api_docs, unused_local_variable

class LocalSpatialAudioEngineImpl extends spatial_audio_binding
    .LocalSpatialAudioEngineImpl with ScopedDisposableObjectMixin {
  LocalSpatialAudioEngineImpl._(IrisMethodChannel irisMethodChannel)
      : super(irisMethodChannel);

  factory LocalSpatialAudioEngineImpl.create(
      IrisMethodChannel irisMethodChannel) {
    return LocalSpatialAudioEngineImpl._(irisMethodChannel);
  }

  @override
  bool get isOverrideClassName => true;

  @override
  Future<void> initialize() async {
    final apiType =
        '${isOverrideClassName ? className : 'LocalSpatialAudioEngine'}_initialize_cf94fbf';
    final param = createParams({});
    final List<Uint8List> buffers = [];
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
    final apiType =
        '${isOverrideClassName ? className : 'LocalSpatialAudioEngine'}_release';
    final param = createParams({});
    final callApiResult = await irisMethodChannel
        .invokeMethod(IrisMethodCall(apiType, jsonEncode(param)));
  }

  @override
  Future<void> dispose() async {
    await release();
  }
}
