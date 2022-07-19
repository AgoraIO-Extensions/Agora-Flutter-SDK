import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'enums.dart';
import 'impl/rtc_ender_view_impl.dart';

///
/// RtcSurfaceView class for rendering local and remote video.
/// This class has the following corresponding classes: Android: SurfaceView (https://developer.android.com/reference/android/view/SurfaceView).
///  iOS: UIView (https://developer.apple.com/documentation/uikit/uiview)
///  Applies to the macOS and Windows platforms only.
///
class RtcSurfaceView extends StatefulWidget {
  ///
  /// The user ID.
  ///
  final int uid;

  ///
  /// The channel name. This parameter signifies the channel in which users engage in real-time audio and video interaction. Under the premise of the same App ID, users who fill in the same channel ID enter the same channel for audio and video interaction. The string length must be less than 64 bytes. Supported characters: The 26 lowercase English letters: a to z.
  ///  The 26 uppercase English letters: A to Z.
  ///  The 10 numeric characters: 0 to 9.
  ///  Space
  ///  "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","
  ///
  final String? channelId;

  ///
  /// The rendering mode of the video. See VideoRenderMode .
  ///
  final VideoRenderMode renderMode;

  ///
  /// The mirror mode of the view. See VideoMirrorMode .
  ///
  final VideoMirrorMode mirrorMode;

  ///
  /// Whether to place the current screen on another layer of the current window. This method is for Android only.
  ///
  final bool zOrderOnTop;

  ///
  /// Whether to place the surface layer of the SurfaceView view on top of another SurfaceView in the window (but still below the window). This method is for Android only.
  ///
  final bool zOrderMediaOverlay;

  ///
  /// This event is triggered when a platform view is created.
  ///
  final PlatformViewCreatedCallback? onPlatformViewCreated;

  ///
  /// The Gesture object.
  ///
  final Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers;

  ///
  /// Whether to create a subprocess.
  ///
  final bool subProcess;

  /// Constructs the [RtcSurfaceView].
  const RtcSurfaceView({
    Key? key,
    required this.uid,
    this.channelId,
    this.renderMode = VideoRenderMode.Hidden,
    this.mirrorMode = VideoMirrorMode.Auto,
    this.zOrderOnTop = false,
    this.zOrderMediaOverlay = false,
    this.onPlatformViewCreated,
    this.gestureRecognizers,
    this.subProcess = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RtcSurfaceViewState();
  }
}

///
/// RtcTextureView class for rendering local and remote video.
/// This class has the following corresponding classes: Android: TextureView (https://developer.android.com/reference/android/view/TextureView)
/// or FlutterTexture (https://api.flutter.dev/objcdoc/Protocols/FlutterTexture.html)。
///  iOS/macOS/Windows: FlutterTexture (https://api.flutter.dev/objcdoc/Protocols/FlutterTexture.html)。
///
class RtcTextureView extends StatefulWidget {
  ///
  /// The user ID.
  ///
  final int uid;

  ///
  /// The channel name. This parameter signifies the channel in which users engage in real-time audio and video interaction. Under the premise of the same App ID, users who fill in the same channel ID enter the same channel for audio and video interaction. The string length must be less than 64 bytes. Supported characters: The 26 lowercase English letters: a to z.
  ///  The 26 uppercase English letters: A to Z.
  ///  The 10 numeric characters: 0 to 9.
  ///  Space
  ///  "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","
  ///
  final String? channelId;

  ///
  /// The rendering mode of the video. See VideoRenderMode .
  ///
  final VideoRenderMode renderMode;

  ///
  /// The mirror mode of the view. See VideoMirrorMode .
  ///
  final VideoMirrorMode mirrorMode;

  ///
  /// This event is triggered when a platform view is created.
  ///
  final PlatformViewCreatedCallback? onPlatformViewCreated;

  ///
  /// The Gesture object.
  ///
  final Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers;

  ///
  /// Whether to render the video using FlutterTexture.
  ///
  final bool useFlutterTexture;

  ///
  /// Whether to create a subprocess.
  ///
  final bool subProcess;

  /// Constructs the [RtcTextureView].
  const RtcTextureView({
    Key? key,
    required this.uid,
    this.channelId,
    this.renderMode = VideoRenderMode.Hidden,
    this.mirrorMode = VideoMirrorMode.Auto,
    this.onPlatformViewCreated,
    this.gestureRecognizers,
    this.useFlutterTexture = true,
    this.subProcess = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RtcTextureViewState();
  }
}
