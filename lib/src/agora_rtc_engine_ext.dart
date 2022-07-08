import 'package:agora_rtc_ng/src/impl/agora_rtc_engine_impl.dart';
import 'agora_rtc_engine.dart';
import 'agora_rtc_engine_ex.dart';
import 'impl/agora_rtc_engine_impl.dart' as impl;

/// Extension for [RtcEngineExt]
extension RtcEngineExt on RtcEngine {
  /// Obtain the actual absolute path of the Asset through the relative path of the Asset.
  ///
  /// * [assetPath] The flutter -> assets field configured in the pubspec.yaml file.None
  ///
  /// ## Return
  /// The actual path of the Asset.
  Future<String?> getAssetAbsolutePath(String assetPath) async {
    final impl = this as RtcEngineImpl;
    final p = await impl.engineMethodChannel
        .invokeMethod<String>('getAssetAbsolutePath', assetPath);
    return p;
  }
}

/// Exceptions are thrown when [RtcEngine] and releative class call error.
class AgoraRtcException implements Exception {
  /// Construct the [AgoraRtcException]
  AgoraRtcException({required this.code, this.message});

  /// The error code, see [ErrorCodeType]
  final int code;

  /// The error description of the [code].
  final String? message;

  @override
  String toString() => 'AgoraRtcException($code, $message)';
}

/// Creates the RtcEngineEx object.
/// Currently, the Agora RTC SDK v4.0.0 supports creating only one RtcEngineEx object for an app.
///
/// ## Return
/// RtcEngineEx object.
RtcEngine createAgoraRtcEngine() {
  return impl.RtcEngineImpl.create();
}

/// @nodoc
RtcEngineEx createAgoraRtcEngineEx() {
  return impl.RtcEngineImpl.create();
}
