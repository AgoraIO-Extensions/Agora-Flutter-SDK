import 'package:agora_rtc_engine/agora_rte_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

// Web-only imports via conditional
import 'impl/web/agora_rte_video_view_web.dart'
    if (dart.library.io) 'impl/web/agora_rte_video_view_stub.dart'
    as web_view;

/// A Flutter widget that displays RTE video content.
///
/// This widget encapsulates the platform view creation and automatic canvas
/// binding for RTE video rendering. It creates:
/// - iOS: `UiKitView` with "AgoraSurfaceView"
/// - Android: `AndroidView` with "AgoraTextureView"
///
/// The widget automatically retrieves the native view pointer and binds it to
/// the provided [canvas] using [AgoraRteCanvas.addView]. When the widget is
/// disposed, it automatically unbinds the view using [AgoraRteCanvas.removeView].
///
/// **Usage Pattern:**
/// 1. Create an [AgoraRte] instance
/// 2. Create an [AgoraRtePlayer] and [AgoraRteCanvas]
/// 3. Pass both to this widget
/// 4. The widget handles all native view binding automatically
///
/// **Since:** v4.4.0
///
/// **Supported Platforms:** iOS, Android (Web is not supported)
///
/// **Example:**
/// ```dart
/// // Initialize RTE
/// final rte = createAgoraRte();
/// await rte.createWithConfig(AgoraRteConfig(appId: 'your_app_id'));
/// await rte.initMediaEngine();
///
/// // Create player and canvas
/// final player = await rte.createPlayer(AgoraRtePlayerConfig());
/// final canvas = await rte.createCanvas(AgoraRteCanvasConfig());
///
/// // Set canvas to player
/// await player.setCanvas(canvas);
///
/// // Use the widget in your UI
/// @override
/// Widget build(BuildContext context) {
///   return AgoraRteVideoView(
///     player: player,
///     canvas: canvas,
///     onViewCreated: () {
///       print('Video view created and bound');
///     },
///     onLog: (message) {
///       print('RTE Video: $message');
///     },
///   );
/// }
/// ```
///
/// **See also:**
/// - [AgoraRteCanvas]
/// - [AgoraRtePlayer]
/// - [AgoraRte.createCanvas]
class AgoraRteVideoView extends StatefulWidget {
  /// The RTE canvas used for rendering video.
  ///
  /// This canvas should be created using [AgoraRte.createCanvas]. The widget
  /// will automatically bind the native view to this canvas.
  ///
  /// Can be `null` during initialization or temporary states.
  final AgoraRteCanvas? canvas;

  /// The RTE player that provides video content.
  ///
  /// This player should be created using [AgoraRte.createPlayer] and should
  /// have [AgoraRtePlayer.setCanvas] called with the same [canvas] instance.
  ///
  /// When both [canvas] and [player] are non-null and the view is created,
  /// the widget will re-associate the canvas with the player to ensure proper
  /// binding.
  ///
  /// Can be `null` during initialization or temporary states.
  final AgoraRtePlayer? player;

  /// Callback invoked when the platform view has been created and successfully
  /// bound to the canvas.
  ///
  /// This is a good place to start playback or perform other operations that
  /// require the view to be ready.
  ///
  /// **Example:**
  /// ```dart
  /// AgoraRteVideoView(
  ///   canvas: myCanvas,
  ///   player: myPlayer,
  ///   onViewCreated: () async {
  ///     // View is ready, now open and play the URL
  ///     await myPlayer.openWithUrl('rte://...');
  ///   },
  /// )
  /// ```
  final VoidCallback? onViewCreated;

  /// Optional callback for receiving log messages from the widget.
  ///
  /// Useful for debugging view creation, binding, and lifecycle events.
  /// All messages are also output to [debugPrint].
  ///
  /// **Example:**
  /// ```dart
  /// AgoraRteVideoView(
  ///   onLog: (message) {
  ///     print('[RTE Video] $message');
  ///   },
  /// )
  /// ```
  final Function(String)? onLog;

  const AgoraRteVideoView({
    super.key,
    this.canvas,
    this.player,
    this.onViewCreated,
    this.onLog,
  });

  @override
  State<AgoraRteVideoView> createState() => _AgoraRteVideoViewState();
}

class _AgoraRteVideoViewState extends State<AgoraRteVideoView> {
  int? _viewPtr;
  MethodChannel? _platformViewChannel;
  bool _isViewAdded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AgoraRteVideoView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.canvas != oldWidget.canvas) {
      // Canvas changed, re-add view
      if (widget.canvas != null && _viewPtr != null && !_isViewAdded) {
        _addViewToCanvas();
      }
    }
  }

  @override
  void dispose() {
    _removeViewFromCanvas();
    super.dispose();
  }

  void _log(String message) {
    widget.onLog?.call(message);
    debugPrint('[AgoraRteVideoView] $message');
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return web_view.buildWebVideoView(
        canvas: widget.canvas,
        player: widget.player,
        onViewCreated: widget.onViewCreated,
        onLog: widget.onLog,
      );
    }

    final String viewType = defaultTargetPlatform == TargetPlatform.iOS
        ? 'AgoraSurfaceView'
        : 'AgoraTextureView';

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: viewType,
        onPlatformViewCreated: _onPlatformViewCreated,
        hitTestBehavior: PlatformViewHitTestBehavior.transparent,
      );
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: viewType,
        onPlatformViewCreated: _onPlatformViewCreated,
        hitTestBehavior: PlatformViewHitTestBehavior.transparent,
      );
    } else {
      return const Center(child: Text('Platform not supported'));
    }
  }

  void _onPlatformViewCreated(int id) {
    final String viewType = defaultTargetPlatform == TargetPlatform.iOS
        ? 'AgoraSurfaceView'
        : 'AgoraTextureView';
    _platformViewChannel = MethodChannel('agora_rtc_ng/${viewType}_$id');
    _log('PlatformView created: id=$id, type=$viewType');
    _getNativeViewPtr();
  }

  Future<void> _getNativeViewPtr() async {
    if (_platformViewChannel == null) {
      _log('PlatformView channel is null');
      return;
    }

    try {
      final viewPtr =
          await _platformViewChannel!.invokeMethod<int>('getNativeViewPtr');
      _log('Got viewPtr: $viewPtr');
      if (viewPtr != null && viewPtr != 0) {
        _viewPtr = viewPtr;
        await _addViewToCanvas();
        widget.onViewCreated?.call();
      } else {
        _log('Invalid viewPtr: $viewPtr');
      }
    } catch (e) {
      _log('Get native view ptr error: $e');
    }
  }

  Future<void> _addViewToCanvas() async {
    if (_viewPtr == null || widget.canvas == null) {
      _log('Cannot add view: viewPtr=$_viewPtr, canvas=${widget.canvas}');
      return;
    }

    if (_isViewAdded) {
      _log('View already added to canvas');
      return;
    }

    try {
      await widget.canvas!.addView(_viewPtr!);
      _isViewAdded = true;
      _log('View added to canvas successfully, viewPtr: $_viewPtr');

      // If Player is provided and has already set Canvas, re-associate
      if (widget.player != null) {
        await widget.player!.setCanvas(widget.canvas!);
        _log('Canvas re-associated with player');
      }
    } catch (e) {
      _log('Add view to canvas error: $e');
    }
  }

  Future<void> _removeViewFromCanvas() async {
    if (_viewPtr == null || widget.canvas == null || !_isViewAdded) {
      return;
    }

    try {
      await widget.canvas!.removeView(_viewPtr!);
      _isViewAdded = false;
      _log('View removed from canvas');
    } catch (e) {
      _log('Remove view from canvas error: $e');
    }
  }
}
