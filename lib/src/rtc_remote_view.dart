import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

import 'enums.dart';
import 'rtc_render_view.dart';

///
/// SurfaceView class for rendering remote video. Extends from the RtcSurfaceView class.
/// This class has the following corresponding classes: Android: SurfaceView (https://developer.android.com/reference/android/view/SurfaceView).
///  iOS: UIView (https://developer.apple.com/documentation/uikit/uiview)
///  Applies to the macOS and Windows platforms only.
///
class SurfaceView extends RtcSurfaceView {
  /// Constructs the [SurfaceView].
  const SurfaceView({
    Key? key,
    required int uid,
    required String channelId,
    VideoRenderMode renderMode = VideoRenderMode.Hidden,
    VideoMirrorMode mirrorMode = VideoMirrorMode.Auto,
    bool zOrderOnTop = false,
    bool zOrderMediaOverlay = false,
    PlatformViewCreatedCallback? onPlatformViewCreated,
    Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers,
  })  : assert(uid != 0),
        super(
          key: key,
          uid: uid,
          channelId: channelId,
          renderMode: renderMode,
          mirrorMode: mirrorMode,
          zOrderOnTop: zOrderOnTop,
          zOrderMediaOverlay: zOrderMediaOverlay,
          onPlatformViewCreated: onPlatformViewCreated,
          gestureRecognizers: gestureRecognizers,
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
  const TextureView({
    Key? key,
    required int uid,
    required String channelId,
    VideoRenderMode renderMode = VideoRenderMode.Hidden,
    VideoMirrorMode mirrorMode = VideoMirrorMode.Auto,
    PlatformViewCreatedCallback? onPlatformViewCreated,
    Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers,
    bool useFlutterTexture = true,
  })  : assert(uid != 0),
        super(
          key: key,
          uid: uid,
          channelId: channelId,
          renderMode: renderMode,
          mirrorMode: mirrorMode,
          onPlatformViewCreated: onPlatformViewCreated,
          gestureRecognizers: gestureRecognizers,
          useFlutterTexture: useFlutterTexture,
        );
}
