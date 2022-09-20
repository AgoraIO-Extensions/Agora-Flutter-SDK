import 'package:agora_rtc_engine/src/binding_forward_export.dart';
import 'package:agora_rtc_engine/src/binding/impl_forward_export.dart';
import 'package:agora_rtc_engine/src/binding/agora_spatial_audio_impl.dart'
    as spatial_audio_binding;
import 'package:agora_rtc_engine/src/impl/disposable_object.dart';

// ignore_for_file: public_member_api_docs, unused_local_variable

class LocalSpatialAudioEngineImpl extends spatial_audio_binding
    .LocalSpatialAudioEngineImpl implements AsyncDisposableObject {
  LocalSpatialAudioEngineImpl._();

  factory LocalSpatialAudioEngineImpl.create() {
    return LocalSpatialAudioEngineImpl._();
  }

  @override
  bool get isOverrideClassName => true;

  @override
  Future<void> initialize() async {
    final apiType =
        '${isOverrideClassName ? className : 'LocalSpatialAudioEngine'}_initialize';
    final param = createParams({});
    final List<Uint8List> buffers = [];
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
        '${isOverrideClassName ? className : 'LocalSpatialAudioEngine'}_release';
    final param = createParams({});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
  }

  @override
  Future<void> disposeAsync() async {
    await release();
  }
}
