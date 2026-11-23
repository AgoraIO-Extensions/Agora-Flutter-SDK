import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show MethodCall;

import '/src/agora_media_player.dart';
import '/src/agora_rtc_engine.dart';
import '/src/agora_rtc_engine_ex.dart';
import '/src/impl/agora_rtc_engine_impl.dart';
import '/src/impl/agora_rtc_engine_impl.dart' as impl;
import '/src/impl/media_player_impl.dart';
import '/src/agora_pip_controller.dart';
import '/src/impl/agora_pip_controller_impl.dart';

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

  /// @nodoc
  int getApiEngineHandle() {
    final impl = this as RtcEngineImpl;
    return impl.getApiEngineHandle();
  }

  /// @nodoc
  AgoraPipController createPipController() {
    return AgoraPipControllerImpl(this);
  }

  /// @nodoc
  @optionalTypeArgs
  Future<T?> invokeAgoraMethod<T>(String method, [dynamic arguments]) {
    final impl = this as RtcEngineImpl;
    return impl.invokeAgoraMethod<T>(method, arguments);
  }

  /// @nodoc
  /// Reads a parameter of the native SDK: the value in effect after
  /// `setParameters`, the config service and other sources are merged by
  /// priority. [type] is one of `bool`, `int`, `uint`, `number`, `string`,
  /// `object`, `array` (object / array are returned as decoded JSON); [args] is
  /// passed to the native getter for `array`. Call it after `initialize`.
  ///
  /// Throws [AgoraRtcException] when the value cannot be read, for example
  /// -7 when the key has never been set, -2 when it holds another type, or
  /// -1009 when the native library does not support this call.
  Future<dynamic> getParameters(String key, String type, {String? args}) {
    final impl = this as RtcEngineImpl;
    return impl.getParameters(key, type, args: args);
  }

  /// @nodoc
  Future<void> registerMethodChannelHandler(
    String method,
    Future<dynamic> Function(MethodCall call) handler,
  ) {
    final impl = this as RtcEngineImpl;
    return impl.registerMethodChannelHandler(method, handler);
  }

  /// @nodoc
  Future<void> unregisterMethodChannelHandler(
    String method,
    Future<dynamic> Function(MethodCall call)? handler,
  ) {
    final impl = this as RtcEngineImpl;
    return impl.unregisterMethodChannelHandler(method, handler);
  }

  /// @nodoc
  void setEnableArgusCounters(bool enabled) {
    if (this is RtcEngineImpl) {
      (this as RtcEngineImpl).setEnableArgusCounters(enabled);
    }
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
RtcEngine createAgoraRtcEngine({Object? sharedNativeHandle}) {
  return impl.RtcEngineImpl.create(sharedNativeHandle: sharedNativeHandle);
}

/// @nodoc
RtcEngineEx createAgoraRtcEngineEx({Object? sharedNativeHandle}) {
  return impl.RtcEngineImpl.create(sharedNativeHandle: sharedNativeHandle);
}

/// @nodoc
MediaPlayerCacheManager getMediaPlayerCacheManager(RtcEngine rtcEngine) {
  return MediaPlayerCacheManagerImpl.create(rtcEngine);
}
