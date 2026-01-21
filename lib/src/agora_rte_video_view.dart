import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

/// A widget that displays RTE video content.
///
/// This widget encapsulates the platform view creation and canvas binding
/// for RTE video rendering. It creates an iOS UiKitView or Android AndroidView
/// and automatically binds it to the provided canvas.
class AgoraRteVideoView extends StatefulWidget {
  /// The RTE canvas to render video on
  final AgoraRteCanvasImpl? canvas;

  /// The RTE player that provides video content
  final AgoraRtePlayerImpl? player;

  /// Optional callback when the view is created
  final VoidCallback? onViewCreated;

  /// Optional callback for logging
  final Function(String)? onLog;

  const AgoraRteVideoView({
    Key? key,
    this.canvas,
    this.player,
    this.onViewCreated,
    this.onLog,
  }) : super(key: key);

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
      return const Center(
        child: Text('Web platform not supported for RTE video view'),
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
