import '/src/agora_media_player.dart';
import '/src/agora_rtc_engine.dart';
import '/src/agora_rtc_engine_ex.dart';
import '/src/impl/agora_rtc_engine_impl.dart';
import '/src/impl/agora_rtc_engine_impl.dart' as impl;
import '/src/impl/media_player_impl.dart';

/// @nodoc
extension RtcEngineExt on RtcEngine {
  /// Obtains the actual absolute path of the Asset through the relative path of the Asset.
  ///
  /// * [assetPath] The flutter -> assets field configured in the pubspec.yaml file.
  ///
  /// Returns
  /// The actual path of the Asset.
  Future<String?> getAssetAbsolutePath(String assetPath) async {
    final impl = this as RtcEngineImpl;
    return impl.getAssetAbsolutePath(assetPath);
  }
}

/// Error codes and error messages.
class AgoraRtcException implements Exception {
  /// @nodoc
  AgoraRtcException({required this.code, this.message});

  /// The error code. See ErrorCodeType.
  final int code;

  /// The error message.
  final String? message;

  @override
  String toString() => 'AgoraRtcException($code, $message)';
}

/// Creates one RtcEngine object.
///
/// Currently, the Agora RTC SDK v6.x supports creating only one RtcEngine object for each app.
///
/// Returns
/// One RtcEngine object.
RtcEngine createAgoraRtcEngine({Object? sharedNativeHandle}) {
  return impl.RtcEngineImpl.create(sharedNativeHandle: sharedNativeHandle);
}

/// Creates one RtcEngineEx object.
///
/// Currently, the Agora RTC v6.x SDK supports creating only one RtcEngineEx object for each app.
///
/// Returns
/// One RtcEngineEx object.
RtcEngineEx createAgoraRtcEngineEx({Object? sharedNativeHandle}) {
  return impl.RtcEngineImpl.create(sharedNativeHandle: sharedNativeHandle);
}

/// Gets one MediaPlayerCacheManager instance.
///
/// Before calling any APIs in the MediaPlayerCacheManager class, you need to call this method to get a cache manager instance of a media player.
///
/// Returns
/// The MediaPlayerCacheManager instance.
MediaPlayerCacheManager getMediaPlayerCacheManager(RtcEngine rtcEngine) {
  return MediaPlayerCacheManagerImpl.create(rtcEngine);
}
