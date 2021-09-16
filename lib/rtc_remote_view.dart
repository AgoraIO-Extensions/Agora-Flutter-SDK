import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

import 'src/enums.dart';
import 'src/rtc_render_view.dart';

/// SurfaceView.
class SurfaceView extends RtcSurfaceView {
  /// Constructs a [SurfaceView]
  SurfaceView({
    Key key,
    @required int uid,
    String channelId,
    VideoRenderMode renderMode = VideoRenderMode.Hidden,
    VideoMirrorMode mirrorMode = VideoMirrorMode.Auto,
    bool zOrderOnTop = false,
    bool zOrderMediaOverlay = false,
    PlatformViewCreatedCallback onPlatformViewCreated,
    Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers,
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

/// TextureView.
class TextureView extends RtcTextureView {
  /// Constructs a [TextureView]
  TextureView({
    Key key,
    @required int uid,
    String channelId,
    VideoRenderMode renderMode = VideoRenderMode.Hidden,
    VideoMirrorMode mirrorMode = VideoMirrorMode.Auto,
    PlatformViewCreatedCallback onPlatformViewCreated,
    Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers,
  })  : assert(uid != 0),
        super(
          key: key,
          uid: uid,
          channelId: channelId,
          renderMode: renderMode,
          mirrorMode: mirrorMode,
          onPlatformViewCreated: onPlatformViewCreated,
          gestureRecognizers: gestureRecognizers,
        );
}
