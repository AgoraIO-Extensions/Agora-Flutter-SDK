import 'package:agora_rtc_engine/src/agora_base.dart';
import 'package:agora_rtc_engine/src/agora_log.dart';
import 'package:agora_rtc_engine/src/agora_media_base.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine_ex.dart';

import 'package:agora_rtc_engine/src/impl/video_view_controller_impl.dart';
import 'package:agora_rtc_engine/src/render/agora_video_view.dart';
import 'package:agora_rtc_engine/src/render/video_view_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

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
      await widget.controller.setupView(_platformViewId, _nativeViewIntPtr);
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

/// Delegate of the `VideoViewController` to handle the state of the texture rendering.
class _VideoViewControllerInternal with VideoViewControllerBaseMixin {
  _VideoViewControllerInternal(this._controller);

  final VideoViewControllerBaseMixin _controller;

  int _textureId = kTextureNotInit;

  @override
  VideoCanvas get canvas => _controller.canvas;

  @override
  RtcConnection? get connection => _controller.connection;

  @override
  bool get useAndroidSurfaceView => _controller.useAndroidSurfaceView;

  @override
  bool get useFlutterTexture => _controller.useFlutterTexture;

  @override
  int getVideoSourceType() {
    return _controller.getVideoSourceType();
  }

  @override
  RtcEngine get rtcEngine => _controller.rtcEngine;

  @override
  bool get shouldHandlerRenderMode => _controller.shouldHandlerRenderMode;

  @override
  int getTextureId() => _textureId;

  @override
  void addInitializedCompletedListener(VoidCallback listener) =>
      _controller.addInitializedCompletedListener(listener);

  @override
  void removeInitializedCompletedListener(VoidCallback listener) =>
      _controller.removeInitializedCompletedListener(listener);

  @override
  Future<void> dispose() => _controller.dispose();

  @override
  Future<void> disposeRenderInternal() => _controller.disposeRenderInternal();

  @override
  Future<int> createTextureRender(
    int uid,
    String channelId,
    int videoSourceType,
    int videoViewSetupMode,
  ) =>
      _controller.createTextureRender(
          uid, channelId, videoSourceType, videoViewSetupMode);

  @override
  Future<void> initializeRender() async {
    await _controller.initializeRender();
    // Renew the texture id
    _textureId = _controller.getTextureId();
  }

  @override
  Future<void> setupView(int platformViewId, int nativeViewPtr) =>
      _controller.setupView(platformViewId, nativeViewPtr);
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

  VideoViewControllerBaseMixin? _controllerInternal;

  void _log(String message, {LogLevel level = LogLevel.logLevelInfo}) {
     _controllerInternal?.rtcEngine.writeLog(
      level: level,
      fmt: "[AgoraRtcRenderTexture] $message key:${widget.key}",
    );
  }

  @override
  void initState() {
    super.initState();
    _log("initState");
    _initialize();
  }

  Future<void> _initialize() async {
    final sourceController = widget.controller;
    _controllerInternal = _VideoViewControllerInternal(
        sourceController as VideoViewControllerBaseMixin);

    _log('initialize');

    if (!_controllerInternal!.isInitialzed) {
      _listener ??= () {
        _controllerInternal?.removeInitializedCompletedListener(_listener!);
        _listener = null;

        _initializeTexture();
      };
      _controllerInternal!.addInitializedCompletedListener(_listener!);
    } else {
      await _initializeTexture();
    }
  }

  Future<void> _initializeTexture() async {
    if (_controllerInternal == null) {
      _log('initializeTexture _controllerInternal is null', level: LogLevel.logLevelWarn);
      return;
    }

    final oldTextureId = _controllerInternal!.getTextureId();
    await _controllerInternal!.initializeRender();
    final textureId = _controllerInternal!.getTextureId();
    _log('initializeTexture w:$_width, h:$_height, key:${widget.key}, oldTextureId:$oldTextureId, newTextureId:$textureId');

    if (oldTextureId != textureId) {
      _log('textureId changed from $oldTextureId to $textureId');
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
    _log('didUpdateWidget');
    _didUpdateWidget(oldWidget);
  }

  Future<void> _didUpdateWidget(
      covariant AgoraRtcRenderTexture oldWidget) async {
    if (_controllerInternal == null ||
        _controllerInternal!.getTextureId() == kTextureNotInit) {
      _log('didUpdateWidget _controllerInternal is null or textureId is not init');
      return;
    }
    if (!oldWidget.controller.isSame(widget.controller) &&
        _controllerInternal != null) {
      _log('didUpdateWidget isSame: ${oldWidget.controller.isSame(widget.controller)}');
      _log('didUpdateWidget oldWidget.controller.canvas.view: ${oldWidget.controller.canvas.view}, widget.controller.canvas.view: ${widget.controller.canvas.view}');
      _log('didUpdateWidget oldWidget.controller.canvas.renderMode: ${oldWidget.controller.canvas.renderMode}, widget.controller.canvas.renderMode: ${widget.controller.canvas.renderMode}');
      _log('didUpdateWidget oldWidget.controller.canvas.mirrorMode: ${oldWidget.controller.canvas.mirrorMode}, widget.controller.canvas.mirrorMode: ${widget.controller.canvas.mirrorMode}');
      _log('didUpdateWidget oldWidget.controller.canvas.uid: ${oldWidget.controller.canvas.uid}, widget.controller.canvas.uid: ${widget.controller.canvas.uid}');
      _log('didUpdateWidget oldWidget.controller.canvas.sourceType: ${oldWidget.controller.canvas.sourceType}, widget.controller.canvas.sourceType: ${widget.controller.canvas.sourceType}');
      _log('didUpdateWidget oldWidget.controller.canvas.cropArea: ${oldWidget.controller.canvas.cropArea}, widget.controller.canvas.cropArea: ${widget.controller.canvas.cropArea}');
      _log('didUpdateWidget oldWidget.controller.canvas.setupMode: ${oldWidget.controller.canvas.setupMode}, widget.controller.canvas.setupMode: ${widget.controller.canvas.setupMode}');
      _log('didUpdateWidget oldWidget.controller.canvas.mediaPlayerId: ${oldWidget.controller.canvas.mediaPlayerId}, widget.controller.canvas.mediaPlayerId: ${widget.controller.canvas.mediaPlayerId}');
      _log('didUpdateWidget disposeRender and initialize');
      _log('didUpdateWidget disposeRender start');
      await _controllerInternal!.disposeRender();
      _log('didUpdateWidget disposeRender end');
      await _initialize();
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    if (_listener != null) {
      _controllerInternal?.removeInitializedCompletedListener(_listener!);
      _listener = null;
    }
    _log('deactivate _listener is null');
  }

  @override
  void dispose() {
    _log('dispose _controllerInternal is not null');
    _controllerInternal?.disposeRender();
    _controllerInternal = null;

    super.dispose();
    _log('dispose _controllerInternal is null');
  }

  @override
  void maybeCreateChannel(int viewId, String viewType) {
    if (_controllerInternal == null) {
      _log('maybeCreateChannel _controllerInternal is null');
      return;
    }
    final textureId = _controllerInternal!.getTextureId();
    _log('maybeCreateChannel textureId: $textureId');
    methodChannel = MethodChannel('agora_rtc_engine/texture_render_$textureId');
    methodChannel!.setMethodCallHandler((call) async {
      if (call.method == 'onSizeChanged') {
        _log('onSizeChanged w:$_width, h:$_height, key:${widget.key}, newW:${call.arguments['width']}, newH:${call.arguments['height']}');
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

  @override
    Widget build(BuildContext context) {
    Widget result = const SizedBox.expand();
    _log('build w:$_width, h:$_height, key:${widget.key}');
    if (_controllerInternal == null) {
      _log('build _controllerInternal is null');
      return result;
    }
    final controller = _controllerInternal!;
    _log('build textureId: ${controller.getTextureId()}');
    if (controller.getTextureId() != kTextureNotInit) {
      if (_height != 0 && _width != 0) {
        _log('build buildTexure');
        result = buildTexure(controller.getTextureId());
        final renderMode =
            controller.canvas.renderMode ?? RenderModeType.renderModeHidden;

        if (controller.shouldHandlerRenderMode) {
          _log('build shouldHandlerRenderMode');
          result = _applyRenderMode(renderMode, result);
          VideoMirrorModeType mirrorMode;
          if (controller.isLocalUid) {
            _log('build isLocalUid');
            mirrorMode = controller.canvas.mirrorMode ??
                VideoMirrorModeType.videoMirrorModeEnabled;
          } else {
            _log('build is not LocalUid');
            mirrorMode = controller.canvas.mirrorMode ??
                VideoMirrorModeType.videoMirrorModeDisabled;
          }

          final sourceType = controller.canvas.sourceType ??
              VideoSourceType.videoSourceCameraPrimary;
          _log('build applyMirrorMode');
          result = _applyMirrorMode(mirrorMode, result, sourceType);
        } else {
          // Fit mode by default if does not need to handle render mode
          _log('build applyRenderMode');
          result = _applyRenderMode(RenderModeType.renderModeFit, result);
        }
      }
    }

    return result;
  }
}
