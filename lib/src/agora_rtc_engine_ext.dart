import 'package:agora_rtc_engine/src/agora_media_player.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine_ex.dart';
import 'package:agora_rtc_engine/src/impl/agora_rtc_engine_impl.dart';
import 'impl/agora_rtc_engine_impl.dart' as impl;
import 'impl/media_player_impl.dart';

export 'dart:convert';
export 'dart:typed_data';
export 'package:json_annotation/json_annotation.dart';

/// @nodoc
class AgoraPipOptions {
  /// @nodoc
  const AgoraPipOptions(
      {this.autoEnterEnabled,
      this.aspectRatioX,
      this.aspectRatioY,
      this.sourceView,
      this.sourceRectHintLeft,
      this.sourceRectHintTop,
      this.sourceRectHintRight,
      this.sourceRectHintBottom});

  /// @nodoc
  final bool? autoEnterEnabled;

  /// @nodoc
  final int? aspectRatioX;

  /// @nodoc
  final int? aspectRatioY;

  /// @nodoc
  final int? sourceView;

  /// @nodoc
  final int? sourceRectHintLeft;

  /// @nodoc
  final int? sourceRectHintTop;

  /// @nodoc
  final int? sourceRectHintRight;

  /// @nodoc
  final int? sourceRectHintBottom;

  /// @nodoc
  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('autoEnterEnabled', autoEnterEnabled);
    writeNotNull('aspectRatioX', aspectRatioX);
    writeNotNull('aspectRatioY', aspectRatioY);
    writeNotNull('sourceView', sourceView);
    writeNotNull('sourceRectHintLeft', sourceRectHintLeft);
    writeNotNull('sourceRectHintTop', sourceRectHintTop);
    writeNotNull('sourceRectHintRight', sourceRectHintRight);
    writeNotNull('sourceRectHintBottom', sourceRectHintBottom);
    return val;
  }
}

/// @nodoc
enum AgoraPipState {
  /// @nodoc
  pipStateStarted,

  /// @nodoc
  pipStateStopped,

  /// @nodoc
  pipStateFailed,
}

class AgoraPipStateChangedObserver {
  /// @nodoc
  const AgoraPipStateChangedObserver({
    required this.onPipStateChanged,
  });

  /// @nodoc
  final void Function(AgoraPipState state, String? error) onPipStateChanged;
}

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

  /// Registers a Picture in Picture state change observer.
  ///
  /// [observer] The Picture in Picture state change observer.
  Future<void> registerPipStateChangedObserver(
      AgoraPipStateChangedObserver observer) async {
    final impl = this as RtcEngineImpl;
    return impl.registerPipStateChangedObserver(observer);
  }

  /// Unregisters a Picture in Picture state change observer.
  Future<void> unregisterPipStateChangedObserver() async {
    final impl = this as RtcEngineImpl;
    return impl.unregisterPipStateChangedObserver();
  }

  /// Check if Picture in Picture is supported.
  ///
  /// Returns
  /// Whether Picture in Picture is supported.
  Future<bool> isPipSupported() async {
    final impl = this as RtcEngineImpl;
    return impl.isPipSupported();
  }

  /// Check if Picture in Picture can auto enter.
  ///
  /// Returns
  /// Whether Picture in Picture can auto enter.
  Future<bool> isPipAutoEnterSupported() async {
    final impl = this as RtcEngineImpl;
    return impl.isPipAutoEnterSupported();
  }

  /// Check if Picture in Picture is active.
  ///
  /// Returns
  /// Whether Picture in Picture is active.
  Future<bool> isPipActived() async {
    final impl = this as RtcEngineImpl;
    return impl.isPipActived();
  }

  /// Setup or update Picture in Picture.
  ///
  /// [options] The options of the Picture in Picture.
  ///
  /// Returns
  /// Whether Picture in Picture is setup successfully.
  Future<bool> pipSetup(AgoraPipOptions options) async {
    final impl = this as RtcEngineImpl;
    return impl.pipSetup(options);
  }

  /// Start Picture in Picture.
  ///
  /// Returns
  /// Whether Picture in Picture is started successfully.
  Future<bool> pipStart() async {
    final impl = this as RtcEngineImpl;
    return impl.pipStart();
  }

  /// Stop Picture in Picture.
  ///
  /// Returns
  /// Whether Picture in Picture is stopped successfully.
  Future<bool> pipStop() async {
    final impl = this as RtcEngineImpl;
    return impl.pipStop();
  }

  /// Dispose Picture in Picture.
  ///
  /// Returns
  /// Whether Picture in Picture is disposed successfully.
  Future<bool> pipDispose() async {
    final impl = this as RtcEngineImpl;
    return impl.pipDispose();
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
