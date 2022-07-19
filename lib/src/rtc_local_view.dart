import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

import 'enums.dart';
import 'rtc_render_view.dart';

///
/// SurfaceView class for rendering local video. Extends from the RtcSurfaceView class.
/// This class has the following corresponding classes: Android: SurfaceView (https://developer.android.com/reference/android/view/SurfaceView).
///  iOS: UIView (https://developer.apple.com/documentation/uikit/uiview)
///  Applies to the macOS and Windows platforms only.
///
class SurfaceView extends RtcSurfaceView {
  /// Constructs the [SurfaceView].
  /// Constructs the [SurfaceView].
  const SurfaceView({
    Key? key,
    String? channelId,
    VideoRenderMode renderMode = VideoRenderMode.Hidden,
    VideoMirrorMode mirrorMode = VideoMirrorMode.Auto,
    bool zOrderOnTop = false,
    bool zOrderMediaOverlay = false,
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

  /// Constructs the [SurfaceView].
  ///
  /// Construction method of the SurfaceView class for rendering local screen shared video.
  ///
  ///
  /// Param [gestureRecognizers] The Gesture object.
  ///
  /// Param [onPlatformViewCreated] This event is triggered when a platform view is created.
  ///
  /// Param [mirrorMode] The mirror mode of the view. See VideoMirrorMode .
  ///
  /// Param [renderMode] The rendering mode of the video. See VideoRenderMode .
  ///
  /// Param [key] Specifiers of Widget, Element, and SemanticsNode. For details, see Flutter's official documentation for a description of the key object.
  ///
  const SurfaceView.screenShare({
    Key? key,
    VideoRenderMode renderMode = VideoRenderMode.Hidden,
    VideoMirrorMode mirrorMode = VideoMirrorMode.Disabled,
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

///
/// TextureView class for rendering local video. Extends from the RtcTextureView class.
/// This class has the following corresponding classes: Android: TextureView (https://developer.android.com/reference/android/view/TextureView)
/// or FlutterTexture (https://api.flutter.dev/objcdoc/Protocols/FlutterTexture.html)。
///  iOS/macOS/Windows: FlutterTexture (https://api.flutter.dev/objcdoc/Protocols/FlutterTexture.html)。
///
class TextureView extends RtcTextureView {
  /// Constructs the [TextureView].
  /// Constructs the [TextureView].
  const TextureView({
    Key? key,
    String? channelId,
    VideoRenderMode renderMode = VideoRenderMode.Hidden,
    VideoMirrorMode mirrorMode = VideoMirrorMode.Auto,
    PlatformViewCreatedCallback? onPlatformViewCreated,
    Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers,
    bool useFlutterTexture = true,
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

  /// Constructs the [TextureView].
  ///
  /// Constructor of the TextureView class for rendering local screen sharing video.
  ///
  ///
  /// Param [useFlutterTexture] Whether to render the video using FlutterTexture.
  ///
  /// Param [gestureRecognizers] The Gesture object.
  ///
  /// Param [onPlatformViewCreated] This event is triggered when a platform view is created.
  ///
  /// Param [mirrorMode] The mirror mode of the view. See VideoMirrorMode .
  ///
  /// Param [renderMode] The rendering mode of the video. See VideoRenderMode .
  ///
  /// Param [key] Specifiers of Widget, Element, and SemanticsNode. For details, see Flutter's official documentation for a description of the key object.
  ///
  const TextureView.screenShare({
    Key? key,
    VideoRenderMode renderMode = VideoRenderMode.Hidden,
    VideoMirrorMode mirrorMode = VideoMirrorMode.Disabled,
    PlatformViewCreatedCallback? onPlatformViewCreated,
    Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers,
    bool useFlutterTexture = true,
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
