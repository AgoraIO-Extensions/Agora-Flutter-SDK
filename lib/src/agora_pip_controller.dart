import 'package:flutter/foundation.dart';

import '/src/agora_base.dart';
import '/src/agora_rtc_engine_ex.dart';

/// @nodoc
class AgoraPipVideoStream {
  /// @nodoc
  final RtcConnection connection;

  /// @nodoc
  final VideoCanvas canvas;

  /// @nodoc
  const AgoraPipVideoStream({required this.connection, required this.canvas});

  /// @nodoc
  Map<String, dynamic> toDictionary() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('connection', connection.toJson());
    writeNotNull('canvas', canvas.toJson());
    return val;
  }
}

/// @nodoc
class AgoraPipContentViewLayout {
  /// @nodoc
  final int? padding;

  /// @nodoc
  final int? spacing;

  /// @nodoc
  final int? row;

  /// @nodoc
  final int? column;

  /// @nodoc
  const AgoraPipContentViewLayout({
    this.padding,
    this.spacing,
    this.row,
    this.column,
  });

  /// @nodoc
  Map<String, dynamic> toDictionary() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('padding', padding);
    writeNotNull('spacing', spacing);
    writeNotNull('row', row);
    writeNotNull('column', column);
    return val;
  }
}

/// @nodoc
class AgoraPipOptions {
  /// @nodoc
  AgoraPipOptions({
    this.autoEnterEnabled,

    // Android-specific options
    this.aspectRatioX,
    this.aspectRatioY,
    this.sourceRectHintLeft,
    this.sourceRectHintTop,
    this.sourceRectHintRight,
    this.sourceRectHintBottom,
    this.seamlessResizeEnabled,
    this.useExternalStateMonitor,
    this.externalStateMonitorInterval,

    // iOS-specific options
    this.sourceContentView,
    this.contentView,
    this.videoStreams,
    this.contentViewLayout,
    this.preferredContentWidth,
    this.preferredContentHeight,
    this.controlStyle,
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
  final int? sourceContentView;

  /// @nodoc
  int? contentView;

  /// @nodoc
  final List<AgoraPipVideoStream>? videoStreams;

  /// @nodoc
  final AgoraPipContentViewLayout? contentViewLayout;

  /// @nodoc
  final int? preferredContentWidth;

  /// @nodoc
  final int? preferredContentHeight;

  /// @nodoc
  final int? controlStyle;

  /// @nodoc
  Map<String, dynamic> toDictionary() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('autoEnterEnabled', autoEnterEnabled);

    // Android-specific options
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
        'externalStateMonitorInterval',
        externalStateMonitorInterval,
      );
    }

    // iOS-specific options
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      writeNotNull('sourceContentView', sourceContentView);
      writeNotNull('contentView', contentView);
      writeNotNull(
          'videoStreams', videoStreams?.map((e) => e.toDictionary()).toList());
      writeNotNull('contentViewLayout', contentViewLayout?.toDictionary());
      writeNotNull('preferredContentWidth', preferredContentWidth);
      writeNotNull('preferredContentHeight', preferredContentHeight);
      writeNotNull('controlStyle', controlStyle);
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
  const AgoraPipStateChangedObserver({required this.onPipStateChanged});

  /// @nodoc
  final void Function(AgoraPipState state, String? error) onPipStateChanged;
}

/// @nodoc
abstract class AgoraPipController {
  /// @nodoc
  Future<void> dispose();

  /// @nodoc
  Future<void> registerPipStateChangedObserver(
    AgoraPipStateChangedObserver observer,
  );

  /// @nodoc
  Future<void> unregisterPipStateChangedObserver();

  /// @nodoc
  Future<bool> pipIsSupported();

  /// @nodoc
  Future<bool> pipIsAutoEnterSupported();

  /// @nodoc
  Future<bool> isPipActivated();

  /// @nodoc
  Future<bool> pipSetup(AgoraPipOptions options);

  /// @nodoc
  Future<bool> pipStart();

  /// @nodoc
  Future<void> pipStop();

  /// @nodoc
  Future<void> pipDispose();
}
