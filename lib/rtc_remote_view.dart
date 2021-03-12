import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

import './src/enums.dart';
import './src/rtc_render_view.dart';

/// SurfaceView.
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

/// (Android only) TextureView.
class TextureView extends RtcTextureView {
  /// Constructs a [TextureView]
  TextureView({
    Key key,
    @required int uid,
    VideoRenderMode renderMode = VideoRenderMode.Hidden,
    String channelId,
    VideoMirrorMode mirrorMode = VideoMirrorMode.Auto,
    Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers,
    PlatformViewCreatedCallback onPlatformViewCreated,
  })  : assert(uid != 0),
        super(
          key: key,
          uid: uid,
          renderMode: renderMode,
          channelId: channelId,
          mirrorMode: mirrorMode,
          gestureRecognizers: gestureRecognizers,
          onPlatformViewCreated: onPlatformViewCreated,
        );
}
