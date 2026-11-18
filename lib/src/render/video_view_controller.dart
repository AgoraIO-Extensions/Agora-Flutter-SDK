import '/src/agora_base.dart';
import '/src/agora_media_base.dart';
import '/src/agora_rtc_engine.dart';
import '/src/agora_rtc_engine_ex.dart';
import '/src/impl/video_view_controller_impl.dart';
import 'package:meta/meta.dart';

/// The controller for AgoraVideoView, used to render local and remote video.
///
/// On different platforms, the default view corresponding to this class varies:
///  Android: https://developer.android.com/reference/android/view/TextureView. If you want to use [SurfaceView](https://developer.android.com/reference/android/view/SurfaceView), set the useAndroidSurfaceView property to true.
///  iOS: [UIView](https://developer.apple.com/documentation/uikit/uiview). If you want to use [FlutterTexture](https://api.flutter.dev/macos-embedder/protocol_flutter_texture-p.html), set the useFlutterTexture property to true.
///  macOS and Windows: [FlutterTexture](https://api.flutter.dev/macos-embedder/protocol_flutter_texture-p.html).
abstract class VideoViewControllerBase {
  /// RtcEngine.
  RtcEngine get rtcEngine;

  /// Local video display properties. See VideoCanvas.
  VideoCanvas get canvas;

  /// Connection information. See RtcConnection.
  RtcConnection? get connection;

  /// FlutterTexture is only available on iOS, macOS, and Windows platforms. Whether to use FlutterTexture to render video: true : Use FlutterTexture to render video. false : Do not use FlutterTexture to render video.
  bool get useFlutterTexture;

  /// Android SurfaceView is only available on Android platform. Whether to use Android SurfaceView to render video: true : Use Android SurfaceView to render video. false : Do not use Android SurfaceView to render video.
  bool get useAndroidSurfaceView;

  /// Android only. Whether to render HDR (PQ / HLG) video with an Android SurfaceView in Hybrid Composition (HC), so the SurfaceView stays a separate layer and HDR reaches the display.
  ///
  /// - true: Use HC. It takes priority over [useAndroidSurfaceView] (treated as true). Flutter UI performance may be lower.
  /// - false: (Default) The rendering is unchanged. It is ignored when [useFlutterTexture] is true.
  ///
  /// It is read when the [AgoraVideoView] is created.
  ///
  /// Recommended: use Flutter 3.47.9 (the latest version that builds with Android Gradle Plugin 8) and enable Hybrid Composition++ (HCPP) by adding the `io.flutter.embedding.android.EnableHcpp` meta-data (value `true`) to AndroidManifest.xml. On Android 14 or later with Impeller Vulkan, Flutter then uses HCPP, which avoids showing stale Flutter UI in the video area before the first video frame. Other devices fall back to HC. The meta-data applies to every platform view in the app.
  bool get useAndroidSurfaceViewHdr;

  @internal
  int getTextureId();

  @internal
  int getViewHandle();

  @internal
  int getPlatformViewId();

  @internal
  int getVideoSourceType();

  @internal
  Future<void> setupView(int platformViewId, int nativeViewPtr);

  @protected
  Future<int> createTextureRender(
    int uid,
    String channelId,
    int videoSourceType,
    int videoViewSetupMode,
  );

  @internal
  Future<void> initializeRender();

  @internal
  Future<void> disposeRender();

  /// @nodoc
  Future<void> dispose();
}

/// The controller for AgoraVideoView, used to render local and remote video.
///
/// On different platforms, the default view corresponding to this class varies:
///  Android: https://developer.android.com/reference/android/view/TextureView. If you want to use [SurfaceView](https://developer.android.com/reference/android/view/SurfaceView), set the useAndroidSurfaceView property to true.
///  iOS: [UIView](https://developer.apple.com/documentation/uikit/uiview). If you want to use [FlutterTexture](https://api.flutter.dev/macos-embedder/protocol_flutter_texture-p.html), set the useFlutterTexture property to true.
///  macOS and Windows: [FlutterTexture](https://api.flutter.dev/macos-embedder/protocol_flutter_texture-p.html).
class VideoViewController
    with VideoViewControllerBaseMixin
    implements VideoViewControllerBase {
  /// @nodoc
  VideoViewController(
      {required this.rtcEngine,
      required this.canvas,
      this.useFlutterTexture = false,
      this.useAndroidSurfaceView = false,
      this.useAndroidSurfaceViewHdr = false})
      : connection = const RtcConnection();

  /// @nodoc
  VideoViewController.remote(
      {required this.rtcEngine,
      required this.canvas,
      required this.connection,
      this.useFlutterTexture = false,
      this.useAndroidSurfaceView = false,
      this.useAndroidSurfaceViewHdr = false})
      : assert(canvas.uid != null && canvas.uid != 0,
            'Remote uid can not be null or 0'),
        assert(connection.channelId != null);

  @override
  final RtcEngine rtcEngine;

  @override
  final VideoCanvas canvas;

  @override
  final RtcConnection connection;

  @override
  final bool useFlutterTexture;

  @override
  final bool useAndroidSurfaceView;

  @override
  final bool useAndroidSurfaceViewHdr;

  @protected
  @override
  int getVideoSourceType() {
    return canvas.uid! == 0
        ? VideoSourceType.videoSourceCamera.value()
        : VideoSourceType.videoSourceRemote.value();
  }
}
