import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

import 'src/enums.dart';
import 'src/rtc_render_view.dart';

/// SurfaceView.
class SurfaceView extends RtcSurfaceView {
  /// Constructs a [SurfaceView]
  const SurfaceView({
    Key? key,
    String? channelId,
    renderMode = VideoRenderMode.Hidden,
    mirrorMode = VideoMirrorMode.Auto,
    zOrderOnTop = false,
    zOrderMediaOverlay = false,
    PlatformViewCreatedCallback? onPlatformViewCreated,
    Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers,
  }) : super(
          key: key,
          uid: 0,
          channelId: channelId,
          renderMode: renderMode,
          mirrorMode: mirrorMode,
          zOrderOnTop: zOrderOnTop,
          zOrderMediaOverlay: zOrderMediaOverlay,
          onPlatformViewCreated: onPlatformViewCreated,
          gestureRecognizers: gestureRecognizers,
        );

  /// TODO(doc)
  const SurfaceView.screenShare({
    Key? key,
    renderMode = VideoRenderMode.Hidden,
    mirrorMode = VideoMirrorMode.Disabled,
    PlatformViewCreatedCallback? onPlatformViewCreated,
    Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers,
  }) : super(
          key: key,
          uid: 0,
          renderMode: renderMode,
          mirrorMode: mirrorMode,
          onPlatformViewCreated: onPlatformViewCreated,
          gestureRecognizers: gestureRecognizers,
          subProcess: true,
        );
}

/// TextureView.
class TextureView extends RtcTextureView {
  /// Constructs a [TextureView]
  const TextureView({
    Key? key,
    String? channelId,
    renderMode = VideoRenderMode.Hidden,
    mirrorMode = VideoMirrorMode.Auto,
    PlatformViewCreatedCallback? onPlatformViewCreated,
    Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers,
    useFlutterTexture = true,
  }) : super(
          key: key,
          uid: 0,
          channelId: channelId,
          renderMode: renderMode,
          mirrorMode: mirrorMode,
          onPlatformViewCreated: onPlatformViewCreated,
          gestureRecognizers: gestureRecognizers,
          useFlutterTexture: useFlutterTexture,
        );

  /// TODO(doc)
  const TextureView.screenShare({
    Key? key,
    renderMode = VideoRenderMode.Hidden,
    mirrorMode = VideoMirrorMode.Disabled,
    PlatformViewCreatedCallback? onPlatformViewCreated,
    Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers,
    useFlutterTexture = true,
  }) : super(
          key: key,
          uid: 0,
          renderMode: renderMode,
          mirrorMode: mirrorMode,
          onPlatformViewCreated: onPlatformViewCreated,
          gestureRecognizers: gestureRecognizers,
          useFlutterTexture: useFlutterTexture,
          subProcess: true,
        );
}
