import 'package:agora_rtc_engine/src/agora_base.dart';
import 'package:agora_rtc_engine/src/agora_media_base.dart';

import 'package:agora_rtc_engine/src/impl/video_view_controller_impl.dart';
import 'package:agora_rtc_engine/src/render/agora_video_view.dart';
import 'package:agora_rtc_engine/src/render/video_view_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart' show SchedulerBinding;
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
    if (kIsWeb) {
      return AgoraRtcRenderPlatformView(
        key: widget.key,
        controller: widget.controller,
        onAgoraVideoViewCreated: widget.onAgoraVideoViewCreated,
      );
    }

    if (defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.windows) {
      return AgoraRtcRenderTexture(
        key: widget.key,
        controller: widget.controller,
        onAgoraVideoViewCreated: widget.onAgoraVideoViewCreated,
      );
    }

    if (widget.controller.useFlutterTexture) {
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

  int _platformViewId = 0;
  int _nativeViewIntPtr = 0;
  late String _viewType;

  VoidCallback? _listener;

  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      _viewType = _viewTypeAgoraSurfaceView;
    } else if (defaultTargetPlatform == TargetPlatform.android) {
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
    } else {
      _controller(widget.controller).updateController(oldWidget.controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildPlatformView(
      viewType: _viewType,
      onPlatformViewCreated: (int id) {
        _platformViewId = id;
        _setupVideo();
      },
    );
  }

  Future<void> _setupNativeView() async {
    if (_isDisposed) {
      return;
    }

    // On web, the `_nativeViewIntPtr` is assigned with the platform view id, so
    // the initialize value is 0, only check the 0(null value) on non-web.
    if (!kIsWeb && _nativeViewIntPtr == 0) {
      return;
    }
    try {
      await widget.controller.setupView(_nativeViewIntPtr);
    } catch (e) {
      debugPrint(
          '[AgoraVideoView] error when widget.controller.setupView: ${e.toString()}');
    } finally {
      await _controller(widget.controller).dePlatformRenderRef(_platformViewId);
    }

    widget.onAgoraVideoViewCreated?.call(_nativeViewIntPtr);
  }

  Future<void> _setupVideo() async {
    if (kIsWeb) {
      // On web, we maintain the platform view id and `HtmlElement` mapping internally
      _nativeViewIntPtr = _platformViewId;
    } else {
      _nativeViewIntPtr =
          (await getMethodChannel()!.invokeMethod<int>('getNativeViewPtr'))!;
    }

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
    _isDisposed = true;
    _nativeViewIntPtr = 0;

    await widget.controller.disposeRender();
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
    // For flutter texture rendering, only update the texture id and other state, and the
    // Flutter framework will handle the rest.
    _controller(widget.controller).updateController(oldWidget.controller);
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
        sourceTypeInt == VideoSourceType.videoSourceScreenSecondary.value() ||
        sourceTypeInt == VideoSourceType.videoSourceTranscoded.value();
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

  Future<void> _setSizeNative(Size size, Offset position) async {
    assert(defaultTargetPlatform == TargetPlatform.android);
    // Call `SurfaceTexture.setDefaultBufferSize` on Android， or the video will be
    // black screen
    await methodChannel!.invokeMethod('setSizeNative', {
      'width': size.width.toInt(),
      'height': size.height.toInt(),
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget result = const SizedBox.expand();

    if (widget.controller.getTextureId() != kTextureNotInit) {
      if (_height != 0 && _width != 0) {
        result = buildTexure(widget.controller.getTextureId());
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
      }

      // Only need to size in native side on Android
      if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
        result = _SizeChangedAwareWidget(
          onChange: (size) {
            _setSizeNative(size, Offset.zero);
          },
          child: result,
        );
      }
    }

    return result;
  }
}

typedef _OnWidgetSizeChange = void Function(Size size);

class _SizeChangedAwareRenderObject extends RenderProxyBox {
  Size? oldSize;
  _OnWidgetSizeChange onChange;

  _SizeChangedAwareRenderObject(this.onChange);

  @override
  void performLayout() {
    super.performLayout();

    Size newSize = child!.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    // Compatible with Flutter SDK 2.10.x
    // ignore: invalid_null_aware_operator
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      onChange(newSize);
    });
  }
}

class _SizeChangedAwareWidget extends SingleChildRenderObjectWidget {
  final _OnWidgetSizeChange onChange;

  const _SizeChangedAwareWidget({
    Key? key,
    required this.onChange,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _SizeChangedAwareRenderObject(onChange);
  }

  @override
  void updateRenderObject(BuildContext context,
      covariant _SizeChangedAwareRenderObject renderObject) {
    renderObject.onChange = onChange;
  }
}
