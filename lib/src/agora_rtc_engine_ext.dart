import 'package:agora_rtc_engine/src/impl/agora_rtc_engine_impl.dart';
import 'agora_media_player.dart';
import 'agora_rtc_engine.dart';
import 'agora_rtc_engine_ex.dart';
import 'impl/agora_rtc_engine_impl.dart' as impl;
import 'impl/media_player_impl.dart';

/// @nodoc
extension RtcEngineExt on RtcEngine {
  /// @nodoc
  Future<String?> getAssetAbsolutePath(String assetPath) async {
    final impl = this as RtcEngineImpl;
    final p = await impl.engineMethodChannel
        .invokeMethod<String>('getAssetAbsolutePath', assetPath);
    return p;
  }

  /// @nodoc
  MediaPlayerCacheManager getMediaPlayerCacheManager() {
    return MediaPlayerCacheManagerImpl.create(this);
  }
}

/// Error codes and error messages.
///
class AgoraRtcException implements Exception {
  /// @nodoc
  AgoraRtcException({required this.code, this.message});

  /// The error code. See ErrorCodeType .
  final int code;

  /// The error message.
  final String? message;

  @override
  String toString() => 'AgoraRtcException($code, $message)';
}

/// Creates the RtcEngine object.
/// Currently, the Agora RTC SDK v4.0.0 supports creating only one RtcEngine object for an app.
///
/// Returns
/// RtcEngine object.
RtcEngine createAgoraRtcEngine() {
  return impl.RtcEngineImpl.create();
}

/// Creates an RtcEngineEx object.
/// Currentluy, the Agora RTC v4.x SDK supports creating only one RtcEngineEx object for each app.
///
/// Returns
/// An RtcEngineEx object.
RtcEngineEx createAgoraRtcEngineEx() {
  return impl.RtcEngineImpl.create();
}
