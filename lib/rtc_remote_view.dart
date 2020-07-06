import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

import './src/enums.dart';
import './src/rtc_render_view.dart';

/// Use SurfaceView in Android.
/// Use UIView in iOS.
class SurfaceView extends RtcSurfaceView {
  /// Constructs a [SurfaceView]
  SurfaceView({
    Key key,
    @required int uid,
    bool zOrderMediaOverlay = false,
    bool zOrderOnTop = false,
    VideoRenderMode renderMode = VideoRenderMode.Hidden,
    String channelId,
    VideoMirrorMode mirrorMode = VideoMirrorMode.Auto,
    Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers,
    PlatformViewCreatedCallback onPlatformViewCreated,
  })  : assert(uid != 0),
        super(
          key: key,
          uid: uid,
          zOrderMediaOverlay: zOrderMediaOverlay,
          zOrderOnTop: zOrderOnTop,
          renderMode: renderMode,
          channelId: channelId,
          mirrorMode: mirrorMode,
          gestureRecognizers: gestureRecognizers,
          onPlatformViewCreated: onPlatformViewCreated,
        );
}

/// Use TextureView in Android.
/// Not support for iOS.
class TextureView extends RtcTextureView {
  /// Constructs a [TextureView]
  TextureView({
    Key key,
    @required int uid,
    String channelId,
    bool mirror = false,
    Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers,
    PlatformViewCreatedCallback onPlatformViewCreated,
  })  : assert(uid != 0),
        super(
          key: key,
          uid: uid,
          channelId: channelId,
          mirror: mirror,
          gestureRecognizers: gestureRecognizers,
          onPlatformViewCreated: onPlatformViewCreated,
        );
}
