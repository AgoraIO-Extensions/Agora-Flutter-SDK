import '/src/agora_rtc_engine.dart';
import '/src/binding/agora_rtc_engine_impl.dart' as video_effect_binding;
import 'package:iris_method_channel/iris_method_channel.dart';
import 'package:meta/meta.dart';

// ignore_for_file: public_member_api_docs

/// Hand-written impl-layer override for [VideoEffectObject].
///
/// - iris returns an integer [objectId] from `createVideoEffectObject`.
/// - Every subsequent `VideoEffectObject_*` call must carry that id so iris can
///   route to the correct native object stored in its internal map.
/// - We achieve this by overriding [createParams] to inject `{'objectId': objectId}`.
class VideoEffectObjectImpl extends video_effect_binding.VideoEffectObjectImpl {
  VideoEffectObjectImpl._(this._objectId, IrisMethodChannel irisMethodChannel)
      : super(irisMethodChannel);

  final int _objectId;

  /// The iris-side integer key for this native VideoEffectObject.
  int get objectId => _objectId;

  /// Factory used by [RtcEngineImpl.createVideoEffectObject].
  VideoEffectObjectImpl.create(
      int objectId, IrisMethodChannel irisMethodChannel)
      : this._(objectId, irisMethodChannel);

  /// Injects the objectId into every iris call so the native layer can look up
  /// the right C++ object from its `video_effect_objects_` map.
  @protected
  @override
  Map<String, dynamic> createParams(Map<String, dynamic> param) {
    return {
      'objectId': _objectId,
      ...param,
    };
  }
}
