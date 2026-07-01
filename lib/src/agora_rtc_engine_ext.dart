import 'package:agora_rtc_engine/src/agora_media_player.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine_ex.dart';
import 'package:agora_rtc_engine/src/impl/agora_rtc_engine_impl.dart';
import 'impl/agora_rtc_engine_impl.dart' as impl;
import 'impl/media_player_impl.dart';

/// @nodoc
extension RtcEngineExt on RtcEngine {
  /// Get the actual absolute path of an asset from its relative asset path.
  ///
  /// * [assetPath] The flutter -> assets field configured in the pubspec.yaml file.
  ///
  /// Returns
  /// The actual path of the asset.
  Future<String?> getAssetAbsolutePath(String assetPath) async {
    final impl = this as RtcEngineImpl;
    return impl.getAssetAbsolutePath(assetPath);
  }
}

/// Error code and description.
class AgoraRtcException implements Exception {
  /// @nodoc
  AgoraRtcException({required this.code, this.message});

  /// Error code. See ErrorCodeType.
  final int code;

  /// Error description.
  final String? message;

  @override
  String toString() => 'AgoraRtcException($code, $message)';
}

/// @nodoc
RtcEngine createAgoraRtcEngine() {
  return impl.RtcEngineImpl.create();
}

/// @nodoc
RtcEngineEx createAgoraRtcEngineEx() {
  return impl.RtcEngineImpl.create();
}

/// @nodoc
MediaPlayerCacheManager getMediaPlayerCacheManager(RtcEngine rtcEngine) {
  return MediaPlayerCacheManagerImpl.create(rtcEngine);
}
