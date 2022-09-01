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

/// 错误码及错误描述。
///
class AgoraRtcException implements Exception {
  /// @nodoc
  AgoraRtcException({required this.code, this.message});

  /// 错误码，详见 ErrorCodeType 。
  final int code;

  /// 错误描述。
  final String? message;

  @override
  String toString() => 'AgoraRtcException($code, $message)';
}

/// 创建RtcEngine 对象。
/// 目前 Agora RTC SDK v4.0.0 只支持每个 app 创建一个RtcEngine 对象。
///
/// Returns
/// RtcEngine 对象。
RtcEngine createAgoraRtcEngine() {
  return impl.RtcEngineImpl.create();
}

/// @nodoc
RtcEngineEx createAgoraRtcEngineEx() {
  return impl.RtcEngineImpl.create();
}
