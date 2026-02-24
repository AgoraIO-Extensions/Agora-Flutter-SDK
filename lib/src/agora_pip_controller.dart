import 'package:flutter/foundation.dart';

import '/src/agora_base.dart';
import '/src/agora_rtc_engine_ex.dart';

/// Video stream configuration for picture-in-picture mode.
///
/// Since Available since v4.6.2. This class stores the connection and canvas settings required to display the video stream in the picture-in-picture window.
class AgoraPipVideoStream {
  /// The RTC connection associated with this video stream.
  final RtcConnection connection;

  /// The canvas configuration used to render this video stream. See VideoCanvas.
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

/// Layout configuration for picture-in-picture video streams.
///
/// Since Available since v4.6.2. This class defines the arrangement of multiple video streams in a flowing layout, where video streams are arranged from left to right and top to bottom.
class AgoraPipContentViewLayout {
  /// Padding around the entire layout in pixels. Used to create space between the layout edges and the video streams. If null, no padding is applied.
  final int? padding;

  /// Horizontal and vertical spacing between video streams in pixels. Used to create consistent spacing between adjacent video streams. If null, video streams are placed directly next to each other.
  final int? spacing;

  /// Maximum number of rows allowed in the layout. Once the maximum number of rows is reached, no new rows are created even if more video streams exist. If null, rows are created as needed to accommodate all video streams. Must be greater than 0 or null.
  final int? row;

  /// Maximum number of video streams per row. Once the maximum is reached, a new row is started. If null, video streams will flow to fill the available width. Must be greater than 0 or null.
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

/// Configuration options for Agora picture-in-picture mode.
///
/// Since Available since v4.6.2. This class provides platform-specific options to configure picture-in-picture behavior on Android and iOS platforms.
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

  /// Whether to automatically enter picture-in-picture mode.
  ///
  /// (Android only)
  final bool? autoEnterEnabled;

  /// Horizontal aspect ratio of the picture-in-picture window.
  ///
  /// (Android only)
  final int? aspectRatioX;

  /// Vertical aspect ratio of the picture-in-picture window.
  ///
  /// (Android only)
  final int? aspectRatioY;

  /// Left coordinate of the source rectangle hint.
  ///
  /// Used to specify the initial position of the picture-in-picture window.
  /// (Android only)
  final int? sourceRectHintLeft;

  /// Top coordinate of the source rectangle hint.
  ///
  /// Used to specify the initial position of the picture-in-picture window.
  /// (Android only)
  final int? sourceRectHintTop;

  /// Right coordinate of the source rectangle hint.
  ///
  /// Used to specify the initial position of the picture-in-picture window.
  /// (Android only)
  final int? sourceRectHintRight;

  /// Bottom coordinate of the source rectangle hint.
  ///
  /// Used to specify the initial position of the picture-in-picture window.
  /// (Android only)
  final int? sourceRectHintBottom;

  /// Whether to enable seamless resizing of the picture-in-picture window.
  ///
  /// When enabled, the picture-in-picture window resizes smoothly.
  /// Default is false.
  /// (Android only)
  final bool? seamlessResizeEnabled;

  /// Whether to use an external state monitor.
  ///
  /// When enabled, a dedicated thread is created to monitor the picture-in-picture window state. Use externalStateMonitorInterval to configure the monitoring frequency.
  /// Default is false.
  /// (Android only)
  final bool? useExternalStateMonitor;

  /// Interval for external state monitoring in milliseconds.
  ///
  /// Takes effect only when useExternalStateMonitor is true.
  /// Default is 100ms.
  /// (Android only)
  final int? externalStateMonitorInterval;

  /// Identifier of the source content view.
  ///
  /// Set to 0 to use the root view as the source.
  /// (iOS only)
  final int? sourceContentView;

  /// Identifier of the content view used for video rendering.
  ///
  /// Set to 0 to let the SDK manage the view. When set to 0, you must provide video sources via videoStreams.
  /// (iOS only)
  int? contentView;

  /// Video transcoding configuration.
  ///
  /// Takes effect only when contentView is set to 0. When the SDK manages the view, all video streams are placed in the root view of the picture-in-picture window.
  /// (iOS only)
  final List<AgoraPipVideoStream>? videoStreams;

  /// Layout configuration for picture-in-picture video streams.
  ///
  /// Takes effect only when contentView is set to 0.
  /// (iOS only)
  final AgoraPipContentViewLayout? contentViewLayout;

  /// Preferred width of the picture-in-picture content.
  ///
  /// (iOS only)
  final int? preferredContentWidth;

  /// Preferred height of the picture-in-picture content.
  ///
  /// (iOS only)
  final int? preferredContentHeight;

  /// Control style of the picture-in-picture window.
  /// Available styles:
  ///  0: Show all system controls (default)
  ///  1: Hide forward and backward buttons
  ///  2: Hide play/pause button and progress bar (recommended)
  ///  3: Hide all system controls, including close and resume buttons (iOS only)
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

/// Represents the current state of Picture-in-Picture mode.
///
/// Since Available since v4.6.2.
enum AgoraPipState {
  /// Picture-in-Picture mode has started successfully.
  pipStateStarted,

  /// Picture-in-Picture mode has stopped.
  pipStateStopped,

  /// Picture-in-Picture mode failed to start or encountered an error.
  pipStateFailed,
}

/// Observer for picture-in-picture state changes.
///
/// Since Available since v4.6.2. Implement this class to receive notifications about picture-in-picture state transitions and potential errors.
class AgoraPipStateChangedObserver {
  /// @nodoc
  const AgoraPipStateChangedObserver({required this.onPipStateChanged});

  /// Callback for picture-in-picture state changes.
  ///
  /// Since Available since v4.6.2. This callback is triggered by the SDK when the picture-in-picture state changes.
  ///
  /// * [state] The new picture-in-picture state. See AgoraPipState.
  /// * [error] Returns an error message if the state change fails; otherwise returns null.
  final void Function(AgoraPipState state, String? error) onPipStateChanged;
}

/// Controller interface for managing picture-in-picture functionality.
///
/// Since Available since v4.6.2. This abstract class defines the methods required to control picture-in-picture mode, including setup, state management, and lifecycle operations.
abstract class AgoraPipController {
  /// Releases resources related to picture-in-picture.
  ///
  /// Since Available since v4.6.2.
  Future<void> dispose();

  /// Registers a picture-in-picture state change observer.
  ///
  /// Since Available since v4.6.2.
  ///
  /// * [observer] Picture-in-picture state change observer. See AgoraPipStateChangedObserver.
  Future<void> registerPipStateChangedObserver(
    AgoraPipStateChangedObserver observer,
  );

  /// Unregisters the picture-in-picture state change observer.
  ///
  /// Since Available since v4.6.2.
  Future<void> unregisterPipStateChangedObserver();

  /// Checks whether the current device supports picture-in-picture mode.
  ///
  /// Since Available since v4.6.2.
  ///
  /// Returns
  /// true : The current device supports picture-in-picture mode. false : The current device does not support picture-in-picture mode.
  Future<bool> pipIsSupported();

  /// Checks whether automatic entry into picture-in-picture mode is supported.
  ///
  /// Since Available since v4.6.2.
  ///
  /// Returns
  /// true : Automatic entry into picture-in-picture mode is supported. false : Automatic entry into picture-in-picture mode is not supported.
  Future<bool> pipIsAutoEnterSupported();

  /// Checks whether picture-in-picture mode is activated.
  ///
  /// Since Available since v4.6.2.
  ///
  /// Returns
  /// true : Picture-in-picture mode is activated. false : Picture-in-picture mode is not activated.
  Future<bool> isPipActivated();

  /// Configures picture-in-picture mode.
  ///
  /// Since Available since v4.6.2.
  ///
  /// * [options] Picture-in-picture configuration options. See AgoraPipOptions.
  ///
  /// Returns
  /// true : The method call succeeds. false : The method call fails.
  Future<bool> pipSetup(AgoraPipOptions options);

  /// Starts picture-in-picture mode.
  ///
  /// Since Available since v4.6.2.
  ///
  /// Returns
  /// true : Success. false : Failure.
  Future<bool> pipStart();

  /// Stops picture-in-picture mode.
  ///
  /// Since Available since v4.6.2.
  Future<void> pipStop();

  /// Releases resources related to picture-in-picture.
  ///
  /// Since Available since v4.6.2.
  Future<void> pipDispose();
}
