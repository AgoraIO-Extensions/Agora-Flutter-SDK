import '/src/agora_media_player.dart';
import '/src/agora_rtc_engine.dart';
import '/src/agora_rtc_engine_ex.dart';
import '/src/impl/agora_rtc_engine_impl.dart';
import '/src/agora_base.dart';
import 'package:flutter/foundation.dart';
import 'impl/agora_rtc_engine_impl.dart' as impl;
import 'impl/media_player_impl.dart';

/// Agora Picture in Picture options.
class AgoraPipOptions {
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

  /// Whether to enable auto enter.
  /// @note only for android
  final bool? autoEnterEnabled;

  /// The aspect ratio of the video view.
  /// @note only for android
  final int? aspectRatioX;

  /// The aspect ratio of the video view.
  /// @note only for android
  final int? aspectRatioY;

  /// The left position of the source rect hint.
  /// @note only for android
  final int? sourceRectHintLeft;

  /// The top position of the source rect hint.
  /// @note only for android
  final int? sourceRectHintTop;

  /// The right position of the source rect hint.
  /// @note only for android
  final int? sourceRectHintRight;

  /// The bottom position of the source rect hint.
  /// @note only for android
  final int? sourceRectHintBottom;

  /// Whether to enable seamless resize.
  /// Default is false. Set to true to enable seamless resize.
  /// @note only for android
  final bool? seamlessResizeEnabled;

  /// Whether to use external state monitor.
  /// Default is false. Set to true to use external state monitor, which will create a new thread to monitor the state of the pip view and
  /// check the pip state with the interval set in [externalStateMonitorInterval].
  /// @note only for android
  final bool? useExternalStateMonitor;

  /// The interval of the external state monitor, in milliseconds. Default is 100ms.
  /// @note only for android
  final int? externalStateMonitorInterval;

  /// The rtc connection.
  /// @note only for ios
  final RtcConnection? connection;

  /// @see VideoCanvas
  /// @note the view in videoCanvas is the sourceView of pip view, zero means to use the root view of the app.
  /// @note only some properties of VideoCanvas are supported:
  /// - uid (optional)
  /// - view (optional)
  /// - backgroundColor (optional)
  /// - mirrorMode (optional)
  /// - renderMode (optional)
  /// - sourceType (optional)
  /// - mediaPlayerId (optional) not supported
  /// @note only for ios
  final VideoCanvas? videoCanvas;

  /// The preferred content width.
  /// @note only for ios
  final int? preferredContentWidth;

  /// The preferred content height.
  /// @note only for ios
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

/// The state of the Picture in Picture.
enum AgoraPipState {
  /// The Picture in Picture is started.
  pipStateStarted,

  /// The Picture in Picture is stopped.
  pipStateStopped,

  /// The Picture in Picture is failed.
  pipStateFailed,
}

/// The observer of the Picture in Picture state changed.
class AgoraPipStateChangedObserver {
  const AgoraPipStateChangedObserver({
    required this.onPipStateChanged,
  });

  /// The callback of the Picture in Picture state changed.
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
  Future<bool> pipIsSupported() async {
    final impl = this as RtcEngineImpl;
    return impl.pipIsSupported();
  }

  /// Check if Picture in Picture can auto enter.
  ///
  /// Returns
  /// Whether Picture in Picture can auto enter.
  Future<bool> pipIsAutoEnterSupported() async {
    final impl = this as RtcEngineImpl;
    return impl.pipIsAutoEnterSupported();
  }

  /// Check if Picture in Picture is activated.
  ///
  /// Returns
  /// Whether Picture in Picture is activated.
  Future<bool> isPipActivated() async {
    final impl = this as RtcEngineImpl;
    return impl.isPipActivated();
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
  Future<void> pipStop() async {
    final impl = this as RtcEngineImpl;
    return impl.pipStop();
  }

  /// Dispose Picture in Picture.
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
