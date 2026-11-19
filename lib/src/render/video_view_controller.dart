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

  /// Android only. Whether to render HDR (PQ / HLG) video so that the Android SurfaceView stays a separate layer and HDR reaches the display.
  ///
  /// - true: Create the view with `initSurfaceAndroidView`. Flutter uses Hybrid Composition++ (HCPP) when the app enables it and the device supports it, and falls back to Hybrid Composition (HC) otherwise. HDR works in both. It takes priority over [useAndroidSurfaceView] (treated as true), so you do not need to set both.
  /// - false: (Default) The rendering is unchanged. It is ignored when [useFlutterTexture] is true.
  ///
  /// It is read when the [AgoraVideoView] is created.
  ///
  /// HC has performance and rendering-residue compatibility issues, so enabling HCPP is recommended: add the `io.flutter.embedding.android.EnableHcpp` meta-data (value `true`) to AndroidManifest.xml. HCPP needs Flutter 3.44 or later, Android 14 (API 34) or later, and Impeller with Vulkan. The meta-data applies to every platform view in the app.
  ///
  /// Without this option, enabling HCPP and setting [useAndroidSurfaceView] to true also shows HDR, but only on devices that support HCPP; other devices show SDR.
  ///
  /// Flutter version: use Flutter 3.50.0 with Android Gradle Plugin (AGP) 9 (set `ext.compileSdkVersion = 36` in the app's root `build.gradle`), or Flutter 3.47.9 if the app stays on AGP 8.
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
