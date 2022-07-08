import 'package:agora_rtc_ng/src/impl/video_view_controller_impl.dart';
import 'package:agora_rtc_ng/src/render/agora_video_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'agora_rtc_renderer.dart';

// ignore_for_file: public_member_api_docs

class AgoraVideoViewState extends State<AgoraVideoView> with RtcRenderMixin {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.windows) {
      return AgoraRtcRenderTexture(
          key: widget.key, controller: widget.controller);
    }

    if (widget.controller.useFlutterTexture) {
      if (defaultTargetPlatform == TargetPlatform.android) {
        return const Text(
            'Flutter texture render is not supported on Android.');
      }

      return AgoraRtcRenderTexture(
          key: widget.key, controller: widget.controller);
    }

    return AgoraRtcRenderPlatformView(
        key: widget.key, controller: widget.controller);
  }
}

class AgoraRtcRenderPlatformView extends StatefulWidget {
  const AgoraRtcRenderPlatformView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final VideoViewControllerBase controller;

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

    widget.controller.initialize();
  }

  @override
  void dispose() {
    super.dispose();

    _disposeRender();
  }

  @override
  void didUpdateWidget(covariant AgoraRtcRenderPlatformView oldWidget) {
    super.didUpdateWidget(oldWidget);

    _didUpdateWidget(oldWidget);
  }

  Future<void> _didUpdateWidget(
      covariant AgoraRtcRenderPlatformView oldWidget) async {
    if (!oldWidget.controller.isSame(widget.controller)) {
      await oldWidget.controller.dispose();
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

  Future<void> _setupVideo() async {
    _nativeViewIntPtr =
        (await getMethodChannel()!.invokeMethod<int>('getNativeViewPtr'))!;
    if (!mounted) return;
    widget.controller.setupView(_nativeViewIntPtr);
  }

  Future<void> _disposeRender() async {
    await widget.controller.disposeRender();
    await getMethodChannel()!.invokeMethod<int>('deleteNativeViewPtr');
  }
}

class AgoraRtcRenderTexture extends StatefulWidget {
  const AgoraRtcRenderTexture({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final VideoViewControllerBase controller;

  @override
  State<AgoraRtcRenderTexture> createState() => _AgoraRtcRenderTextureState();
}

class _AgoraRtcRenderTextureState extends State<AgoraRtcRenderTexture>
    with RtcRenderMixin {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    final oldTextureId = widget.controller.getTextureId();
    await widget.controller.initialize();
    if (oldTextureId != widget.controller.getTextureId()) {
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
      oldWidget.controller.dispose();
      if (!mounted) return;
      _initialize();
    } else {
      widget.controller.setTextureId(oldWidget.controller.getTextureId());
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.disposeRender();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controller.getTextureId() != kTextureNotInit) {
      return buildTexure(widget.controller.getTextureId());
    }

    return Container();
  }
}
