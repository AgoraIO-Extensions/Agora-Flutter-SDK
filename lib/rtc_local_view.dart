import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import './src/enums.dart';
import './src/rtc_render_view.dart';

/// Use SurfaceView in Android.
/// Use UIView in iOS.
class SurfaceView extends RtcSurfaceView {
  /// Constructs a [SurfaceView]
  SurfaceView({
    Key key,
    bool zOrderMediaOverlay = false,
    bool zOrderOnTop = false,
    VideoRenderMode renderMode = VideoRenderMode.Hidden,
    String channelId,
    VideoMirrorMode mirrorMode = VideoMirrorMode.Auto,
    Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers,
    PlatformViewCreatedCallback onPlatformViewCreated,
  }) : super(
      key: key,
      zOrderMediaOverlay: zOrderMediaOverlay,
      zOrderOnTop: zOrderOnTop,
      renderMode: renderMode,
      channelId: channelId,
      mirrorMode: mirrorMode,
      gestureRecognizers: gestureRecognizers,
      onPlatformViewCreated: onPlatformViewCreated,
      uid: 0);
}

/// Use TextureView in Android.
/// Not support for iOS.
class TextureView extends RtcTextureView {
  /// Constructs a [TextureView]
  TextureView({
    Key key,
    String channelId,
    bool mirror = false,
    Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers,
    PlatformViewCreatedCallback onPlatformViewCreated,
  }) : super(
      key: key,
      channelId: channelId,
      mirror: mirror,
      gestureRecognizers: gestureRecognizers,
      onPlatformViewCreated: onPlatformViewCreated,
      uid: 0);
}
