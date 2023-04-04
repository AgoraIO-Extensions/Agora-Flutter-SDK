import 'package:agora_rtc_engine/src/agora_base.dart';
import 'package:agora_rtc_engine/src/agora_media_base.dart';

import 'package:agora_rtc_engine/src/impl/video_view_controller_impl.dart';
import 'package:agora_rtc_engine/src/render/agora_video_view.dart';
import 'package:agora_rtc_engine/src/render/video_view_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'agora_rtc_renderer.dart';

// ignore_for_file: public_member_api_docs

/// Callback when [AgoraVideoView] created.
typedef AgoraVideoViewCreatedCallback = void Function(int viewId);

VideoViewControllerBaseMixin _controller(VideoViewControllerBase controller) {
  return controller as VideoViewControllerBaseMixin;
}

class AgoraVideoViewState extends State<AgoraVideoView> {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.windows) {
      return AgoraRtcRenderTexture(
        key: widget.key,
        controller: widget.controller,
        onAgoraVideoViewCreated: widget.onAgoraVideoViewCreated,
      );
    }

    if (widget.controller.useFlutterTexture) {
      if (defaultTargetPlatform == TargetPlatform.android) {
        return const Text(
            'Flutter texture render is not supported on Android.');
      }

      return AgoraRtcRenderTexture(
        key: widget.key,
        controller: widget.controller,
        onAgoraVideoViewCreated: widget.onAgoraVideoViewCreated,
      );
    }

    return AgoraRtcRenderPlatformView(
      key: widget.key,
      controller: widget.controller,
      onAgoraVideoViewCreated: widget.onAgoraVideoViewCreated,
    );
  }
}

class AgoraRtcRenderPlatformView extends StatefulWidget {
  const AgoraRtcRenderPlatformView({
    Key? key,
    required this.controller,
    this.onAgoraVideoViewCreated,
  }) : super(key: key);

  final VideoViewControllerBase controller;

  final AgoraVideoViewCreatedCallback? onAgoraVideoViewCreated;

  @override
  State<AgoraRtcRenderPlatformView> createState() =>
      _AgoraRtcRenderPlatformViewState();
}

class _AgoraRtcRenderPlatformViewState extends State<AgoraRtcRenderPlatformView>
    with RtcRenderMixin {
  static const String _viewTypeAgoraTextureView = 'AgoraTextureView';
  static const String _viewTypeAgoraSurfaceView = 'AgoraSurfaceView';

  int _nativeViewIntPtr = 0;
  late String _viewType;

  VoidCallback? _listener;

  @override
  void initState() {
    super.initState();

    if (defaultTargetPlatform == TargetPlatform.android) {
      if (widget.controller.useAndroidSurfaceView) {
        _viewType = _viewTypeAgoraSurfaceView;
      } else {
        _viewType = _viewTypeAgoraTextureView;
      }
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      _viewType = _viewTypeAgoraSurfaceView;
    } else {
      throw ArgumentError('PlatformView render is not supported on desktop');
    }

    widget.controller.initializeRender();
  }

  @override
  void deactivate() {
    super.deactivate();
    if (_listener != null) {
      _controller(widget.controller)
          .removeInitializedCompletedListener(_listener!);
      _listener = null;
    }
  }

  @override
  void dispose() {
    _disposeRender();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AgoraRtcRenderPlatformView oldWidget) {
    super.didUpdateWidget(oldWidget);

    _didUpdateWidget(oldWidget);
  }

  Future<void> _didUpdateWidget(
      covariant AgoraRtcRenderPlatformView oldWidget) async {
    if (!oldWidget.controller.isSame(widget.controller)) {
      await oldWidget.controller.disposeRender();
      await _setupVideo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildPlatformView(
      viewType: _viewType,
      onPlatformViewCreated: (int id) {
        _setupVideo();
      },
    );
  }

  Future<void> _setupNativeView() async {
    if (_nativeViewIntPtr == 0) {
      return;
    }

    await widget.controller.setupView(_nativeViewIntPtr);
    widget.onAgoraVideoViewCreated?.call(_nativeViewIntPtr);
  }

  Future<void> _setupVideo() async {
    _nativeViewIntPtr =
        (await getMethodChannel()!.invokeMethod<int>('getNativeViewPtr'))!;
    if (!mounted) return;
    if (!_controller(widget.controller).isInitialzed) {
      _listener ??= () {
        _controller(widget.controller)
            .removeInitializedCompletedListener(_listener!);
        _listener = null;

        _setupNativeView();
      };
      _controller(widget.controller)
          .addInitializedCompletedListener(_listener!);
    } else {
      await _setupNativeView();
    }
  }

  Future<void> _disposeRender() async {
    await widget.controller.disposeRender();
    await getMethodChannel()?.invokeMethod<int>('deleteNativeViewPtr');
  }
}

class AgoraRtcRenderTexture extends StatefulWidget {
  const AgoraRtcRenderTexture({
    Key? key,
    required this.controller,
    this.onAgoraVideoViewCreated,
  }) : super(key: key);

  final VideoViewControllerBase controller;
  final AgoraVideoViewCreatedCallback? onAgoraVideoViewCreated;

  @override
  State<AgoraRtcRenderTexture> createState() => _AgoraRtcRenderTextureState();
}

class _AgoraRtcRenderTextureState extends State<AgoraRtcRenderTexture>
    with RtcRenderMixin {
  int _width = 0;
  int _height = 0;

  VoidCallback? _listener;

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  Future<void> _initialize() async {
    if (!_controller(widget.controller).isInitialzed) {
      _listener ??= () {
        _controller(widget.controller)
            .removeInitializedCompletedListener(_listener!);
        _listener = null;
        _initializeTexture();
      };
      _controller(widget.controller)
          .addInitializedCompletedListener(_listener!);
    } else {
      await _initializeTexture();
    }
  }

  Future<void> _initializeTexture() async {
    final oldTextureId = widget.controller.getTextureId();
    await widget.controller.initializeRender();
    final textureId = widget.controller.getTextureId();
    if (oldTextureId != textureId) {
      _width = 0;
      _height = 0;
      // The parameters is no used
      maybeCreateChannel(-1, '');
      widget.onAgoraVideoViewCreated?.call(textureId);
      setState(() {});
    }
  }

  @override
  void didUpdateWidget(covariant AgoraRtcRenderTexture oldWidget) {
    super.didUpdateWidget(oldWidget);

    _didUpdateWidget(oldWidget);
  }

  Future<void> _didUpdateWidget(
      covariant AgoraRtcRenderTexture oldWidget) async {
    if (!oldWidget.controller.isSame(widget.controller)) {
      await oldWidget.controller.dispose();
      if (!mounted) return;
      _initialize();
    } else {
      widget.controller.setTextureId(oldWidget.controller.getTextureId());
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    if (_listener != null) {
      _controller(widget.controller)
          .removeInitializedCompletedListener(_listener!);
      _listener = null;
    }
  }

  @override
  void dispose() {
    widget.controller.disposeRender();
    super.dispose();
  }

  @override
  void maybeCreateChannel(int viewId, String viewType) {
    // Only handle render mode on macos at this time
    final textureId = widget.controller.getTextureId();
    methodChannel = MethodChannel('agora_rtc_engine/texture_render_$textureId');
    methodChannel!.setMethodCallHandler((call) async {
      if (call.method == 'onSizeChanged') {
        _width = call.arguments['width'];
        _height = call.arguments['height'];
        setState(() {});
        return true;
      }
      return false;
    });
  }

  Widget _applyRenderMode(RenderModeType renderMode, Widget child) {
    if (renderMode == RenderModeType.renderModeFit) {
      return Container(
        color: Colors.black,
        constraints: const BoxConstraints.expand(),
        child: FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            width: _width.toDouble(),
            height: _height.toDouble(),
            child: child,
          ),
        ),
      );
    } else if (renderMode == RenderModeType.renderModeHidden) {
      return Container(
        constraints: const BoxConstraints.expand(),
        child: FittedBox(
          fit: BoxFit.cover,
          clipBehavior: Clip.hardEdge,
          child: SizedBox(
            width: _width.toDouble(),
            height: _height.toDouble(),
            child: child,
          ),
        ),
      );
    } else {
      // RenderModeType.renderModeAdaptive
      return Container(
        constraints: const BoxConstraints.expand(),
        child: FittedBox(
          fit: BoxFit.fill,
          child: SizedBox(
            width: _width.toDouble(),
            height: _height.toDouble(),
            child: child,
          ),
        ),
      );
    }
  }

  bool _isScreenSource(VideoSourceType sourceType) {
    final sourceTypeInt = sourceType.value();
    // int value of `VideoSourceType.videoSourceScreen` and `VideoSourceType.videoSourceScreenPrimary` is the same
    return sourceTypeInt == VideoSourceType.videoSourceScreenPrimary.value() ||
        sourceTypeInt == VideoSourceType.videoSourceScreenSecondary.value();
  }

  Widget _applyMirrorMode(VideoMirrorModeType mirrorMode, Widget child,
      VideoSourceType sourceType) {
    bool enableMirror = true;
    if (mirrorMode == VideoMirrorModeType.videoMirrorModeDisabled ||
        _isScreenSource(sourceType)) {
      enableMirror = false;
    }

    if (enableMirror) {
      return Transform.scale(
        scaleX: -1.0,
        child: child,
      );
    }

    return child;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controller.getTextureId() != kTextureNotInit) {
      // Only handle render mode on macos at this time
      if (_height != 0 && _width != 0) {
        Widget result = buildTexure(widget.controller.getTextureId());
        final renderMode = widget.controller.canvas.renderMode ??
            RenderModeType.renderModeHidden;

        if (widget.controller.shouldHandlerRenderMode) {
          result = _applyRenderMode(renderMode, result);
          VideoMirrorModeType mirrorMode;
          if (widget.controller.isLocalUid) {
            mirrorMode = widget.controller.canvas.mirrorMode ??
                VideoMirrorModeType.videoMirrorModeEnabled;
          } else {
            mirrorMode = widget.controller.canvas.mirrorMode ??
                VideoMirrorModeType.videoMirrorModeDisabled;
          }

          final sourceType = widget.controller.canvas.sourceType ??
              VideoSourceType.videoSourceCameraPrimary;

          result = _applyMirrorMode(mirrorMode, result, sourceType);
        } else {
          // Fit mode by default if does not need to handle render mode
          result = _applyRenderMode(RenderModeType.renderModeFit, result);
        }

        return result;
      }
    }

    return Container();
  }
}
