import '/src/agora_media_player.dart';
import '/src/agora_rtc_engine.dart';
import '/src/agora_rtc_engine_ex.dart';
import '/src/impl/agora_rtc_engine_impl.dart';
import '/src/agora_base.dart';
import 'package:flutter/foundation.dart';
import 'impl/agora_rtc_engine_impl.dart' as impl;
import 'impl/media_player_impl.dart';

/// @nodoc
class AgoraPipOptions {
  /// @nodoc
  const AgoraPipOptions({
    this.autoEnterEnabled,
    this.aspectRatioX,
    this.aspectRatioY,
    this.sourceRectHintLeft,
    this.sourceRectHintTop,
    this.sourceRectHintRight,
    this.sourceRectHintBottom,
    this.seamlessResizeEnabled,
    this.useExternalStateMonitor,
    this.externalStateMonitorInterval,
    this.connection,
    this.videoCanvas,
    this.preferredContentWidth,
    this.preferredContentHeight,
  });

  /// @nodoc
  final bool? autoEnterEnabled;

  /// @nodoc
  final int? aspectRatioX;

  /// @nodoc
  final int? aspectRatioY;

  /// @nodoc
  final int? sourceRectHintLeft;

  /// @nodoc
  final int? sourceRectHintTop;

  /// @nodoc
  final int? sourceRectHintRight;

  /// @nodoc
  final int? sourceRectHintBottom;

  /// @nodoc
  final bool? seamlessResizeEnabled;

  /// @nodoc
  final bool? useExternalStateMonitor;

  /// @nodoc
  final int? externalStateMonitorInterval;

  /// @nodoc
  final RtcConnection? connection;

  /// @nodoc
  final VideoCanvas? videoCanvas;

  /// @nodoc
  final int? preferredContentWidth;

  /// @nodoc
  final int? preferredContentHeight;

  /// @nodoc
  Map<String, dynamic> toDictionary() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('autoEnterEnabled', autoEnterEnabled);

    // only for android
    if (defaultTargetPlatform == TargetPlatform.android) {
      writeNotNull('aspectRatioX', aspectRatioX);
      writeNotNull('aspectRatioY', aspectRatioY);
      writeNotNull('sourceRectHintLeft', sourceRectHintLeft);
      writeNotNull('sourceRectHintTop', sourceRectHintTop);
      writeNotNull('sourceRectHintRight', sourceRectHintRight);
      writeNotNull('sourceRectHintBottom', sourceRectHintBottom);
      writeNotNull('seamlessResizeEnabled', seamlessResizeEnabled);
      writeNotNull('useExternalStateMonitor', useExternalStateMonitor);
      writeNotNull(
          'externalStateMonitorInterval', externalStateMonitorInterval);
    }

    // only for ios
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      writeNotNull('connection', connection?.toJson());
      writeNotNull('videoCanvas', videoCanvas?.toJson());
      writeNotNull('preferredContentWidth', preferredContentWidth);
      writeNotNull('preferredContentHeight', preferredContentHeight);
    }
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

/// @nodoc
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

  /// @nodoc
  Future<void> registerPipStateChangedObserver(
      AgoraPipStateChangedObserver observer) async {
    final impl = this as RtcEngineImpl;
    return impl.registerPipStateChangedObserver(observer);
  }

  /// @nodoc
  Future<void> unregisterPipStateChangedObserver() async {
    final impl = this as RtcEngineImpl;
    return impl.unregisterPipStateChangedObserver();
  }

  /// @nodoc
  Future<bool> pipIsSupported() async {
    final impl = this as RtcEngineImpl;
    return impl.pipIsSupported();
  }

  /// @nodoc
  Future<bool> pipIsAutoEnterSupported() async {
    final impl = this as RtcEngineImpl;
    return impl.pipIsAutoEnterSupported();
  }

  /// @nodoc
  Future<bool> isPipActivated() async {
    final impl = this as RtcEngineImpl;
    return impl.isPipActivated();
  }

  /// @nodoc
  Future<bool> pipSetup(AgoraPipOptions options) async {
    final impl = this as RtcEngineImpl;
    return impl.pipSetup(options);
  }

  /// @nodoc
  Future<bool> pipStart() async {
    final impl = this as RtcEngineImpl;
    return impl.pipStart();
  }

  /// @nodoc
  Future<void> pipStop() async {
    final impl = this as RtcEngineImpl;
    return impl.pipStop();
  }

  /// @nodoc
  Future<void> pipDispose() async {
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
