import 'package:flutter/foundation.dart';

import '/src/agora_base.dart';
import '/src/agora_rtc_engine_ex.dart';

/// Represents a video stream configuration for Picture-in-Picture (PiP) mode.
///
/// This class holds the connection and canvas settings needed to display
/// a video stream within the PiP window.
class AgoraPipVideoStream {
  /// The RTC connection associated with this video stream.
  final RtcConnection connection;

  /// The video canvas configuration for rendering this stream.
  final VideoCanvas canvas;

  /// Creates an [AgoraPipVideoStream] instance.
  ///
  /// Both [connection] and [canvas] parameters are required to properly
  /// configure the video stream in PiP mode.
  const AgoraPipVideoStream({required this.connection, required this.canvas});
}

/// Layout configuration for Picture-in-Picture (PiP) video streams.
///
/// This class defines how multiple video streams should be arranged in a flow layout,
/// where streams are placed from left to right and top to bottom in sequence.
///
/// Example layout with padding=10, spacing=5, column=3:
/// ```
/// ┌────────────────────────────────────┐
/// │                                    │
/// │  ┌────┐  ┌────┐  ┌────┐           │
/// │  │ 1  │  │ 2  │  │ 3  │           │
/// │  └────┘  └────┘  └────┘           │
/// │                                    │
/// │  ┌────┐  ┌────┐  ┌────┐           │
/// │  │ 4  │  │ 5  │  │ 6  │           │
/// │  └────┘  └────┘  └────┘           │
/// │                                    │
/// │  ┌────┐                           │
/// │  │ 7  │                           │
/// │  └────┘                           │
/// │                                    │
/// └────────────────────────────────────┘
/// ```
class AgoraPipContentViewLayout {
  /// The padding around the entire layout in pixels.
  /// Creates space between the layout edges and the streams.
  /// If null, no padding will be applied.
  final int? padding;

  /// The horizontal and vertical spacing between streams in pixels.
  /// Creates consistent gaps between adjacent streams.
  /// If null, streams will be placed directly adjacent to each other.
  final int? spacing;

  /// Maximum number of rows allowed in the layout.
  /// When reached, no more rows will be created even if more streams exist.
  /// If null, rows will be created as needed to fit all streams.
  /// Must be greater than 0 or null.
  final int? row;

  /// Maximum number of streams per row.
  /// When reached, a new row will be started.
  /// If null, streams will flow to fill the available width.
  /// Must be greater than 0 or null.
  final int? column;

  /// Creates an [AgoraPipContentViewLayout] instance.
  ///
  /// The [streams] parameter is required and specifies which video streams
  /// should be shown in the layout in sequential order.
  const AgoraPipContentViewLayout({
    this.padding,
    this.spacing,
    this.row,
    this.column,
  });

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

/// Configuration options for Agora Picture-in-Picture (PiP) mode.
///
/// This class provides platform-specific options to configure PiP behavior
/// for both Android and iOS platforms.
class AgoraPipOptions {
  /// Creates an [AgoraPipOptions] instance.
  ///
  /// All parameters are optional and platform-specific.
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

  /// Whether to automatically enter PiP mode.
  ///
  /// Platform: Android only
  final bool? autoEnterEnabled;

  /// The horizontal aspect ratio of the PiP window.
  ///
  /// Platform: Android only
  final int? aspectRatioX;

  /// The vertical aspect ratio of the PiP window.
  ///
  /// Platform: Android only
  final int? aspectRatioY;

  /// The left coordinate of the source rectangle hint.
  ///
  /// Used to specify the initial position of the PiP window.
  /// Platform: Android only
  final int? sourceRectHintLeft;

  /// The top coordinate of the source rectangle hint.
  ///
  /// Used to specify the initial position of the PiP window.
  /// Platform: Android only
  final int? sourceRectHintTop;

  /// The right coordinate of the source rectangle hint.
  ///
  /// Used to specify the initial position of the PiP window.
  /// Platform: Android only
  final int? sourceRectHintRight;

  /// The bottom coordinate of the source rectangle hint.
  ///
  /// Used to specify the initial position of the PiP window.
  /// Platform: Android only
  final int? sourceRectHintBottom;

  /// Whether to enable seamless resize for the PiP window.
  ///
  /// When enabled, the PiP window will resize smoothly.
  /// Defaults to false.
  /// Platform: Android only
  final bool? seamlessResizeEnabled;

  /// Whether to use external state monitoring.
  ///
  /// When enabled, creates a dedicated thread to monitor PiP window state.
  /// Use [externalStateMonitorInterval] to configure monitoring frequency.
  /// Defaults to false.
  /// Platform: Android only
  final bool? useExternalStateMonitor;

  /// The interval for external state monitoring in milliseconds.
  ///
  /// Only takes effect when [useExternalStateMonitor] is true.
  /// Defaults to 100ms.
  /// Platform: Android only
  final int? externalStateMonitorInterval;

  /// The source content view identifier.
  ///
  /// Set to 0 to use the root view as the source.
  /// Platform: iOS only
  final int? sourceContentView;

  /// The content view identifier for video rendering.
  ///
  /// Set to 0 to let the SDK manage the view.
  /// When set to 0, you must provide video sources through [videoStreams].
  /// Platform: iOS only
  int? contentView;

  /// Configuration for video transcoding.
  ///
  /// Only takes effect when [contentView] is set to 0.
  /// When user let the SDK manage the view, all video streams will place in a root view in the PIP window.
  /// Platform: iOS only
  final List<AgoraPipVideoStream>? videoStreams;

  /// Layout configuration for PiP video streams.
  ///
  /// Only takes effect when [contentView] is set to 0.
  /// Platform: iOS only
  final AgoraPipContentViewLayout? contentViewLayout;

  /// The preferred width of the PiP content.
  ///
  /// Platform: iOS only
  final int? preferredContentWidth;

  /// The preferred height of the PiP content.
  ///
  /// Platform: iOS only
  final int? preferredContentHeight;

  /// The control style for the PiP window.
  ///
  /// Available styles:
  /// * 0: Show all system controls (default)
  /// * 1: Hide forward and backward buttons
  /// * 2: Hide play/pause button and progress bar (recommended)
  /// * 3: Hide all system controls including close and restore buttons
  ///
  /// Platform: iOS only
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
      writeNotNull('contentViewLayout', contentViewLayout?.toDictionary());
      writeNotNull('preferredContentWidth', preferredContentWidth);
      writeNotNull('preferredContentHeight', preferredContentHeight);
      writeNotNull('controlStyle', controlStyle);
    }
    return val;
  }
}

/// Represents the current state of Picture-in-Picture mode.
enum AgoraPipState {
  /// PiP mode has been successfully started.
  pipStateStarted,

  /// PiP mode has been stopped.
  pipStateStopped,

  /// PiP mode failed to start or encountered an error.
  pipStateFailed,
}

/// Observer for Picture-in-Picture state changes.
///
/// Implement this class to receive notifications about PiP state transitions
/// and potential errors.
class AgoraPipStateChangedObserver {
  /// Creates an observer for PiP state changes.
  ///
  /// The [onPipStateChanged] callback is required and will be called
  /// whenever the PiP state changes.
  const AgoraPipStateChangedObserver({required this.onPipStateChanged});

  /// Callback function for PiP state changes.
  ///
  /// Parameters:
  /// * [state] - The new PiP state
  /// * [error] - Error message if the state change failed, null otherwise
  final void Function(AgoraPipState state, String? error) onPipStateChanged;
}

/// Controller interface for managing Picture-in-Picture functionality.
///
/// This abstract class defines the methods required to control PiP mode,
/// including setup, state management, and lifecycle operations.
abstract class AgoraPipController {
  /// Releases resources associated with PiP mode.
  Future<void> dispose();

  /// Registers an observer for PiP state changes.
  Future<void> registerPipStateChangedObserver(
    AgoraPipStateChangedObserver observer,
  );

  /// Unregisters a previously registered PiP state observer.
  Future<void> unregisterPipStateChangedObserver();

  /// Checks if PiP mode is supported on the current device.
  Future<bool> pipIsSupported();

  /// Checks if automatic PiP mode entry is supported.
  Future<bool> pipIsAutoEnterSupported();

  /// Checks if PiP mode is currently active.
  Future<bool> isPipActivated();

  /// Configures PiP mode with the specified options.
  Future<bool> pipSetup(AgoraPipOptions options);

  /// Starts PiP mode with the current configuration.
  Future<bool> pipStart();

  /// Stops PiP mode.
  Future<void> pipStop();

  /// Releases resources associated with PiP mode.
  Future<void> pipDispose();
}