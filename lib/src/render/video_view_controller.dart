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

  /// Android SurfaceView HDR is only available on Android platform. Whether to render HDR (PQ / HLG) video with an Android SurfaceView in Hybrid Composition: true : Render video with an Android SurfaceView in Hybrid Composition. This takes priority over useAndroidSurfaceView and treats it as true. The Flutter UI performance may be lower. false : (Default) Do not change how the video is rendered. It is ignored when useFlutterTexture is true. It is read when the AgoraVideoView is created; to change it, create a new AgoraVideoView. On Flutter 3.44 or later, the app can also enable Hybrid Composition++ by adding the `io.flutter.embedding.android.EnableHcpp` meta-data to AndroidManifest.xml. Flutter then uses it on Android 14 or later with Impeller Vulkan, which avoids showing earlier Flutter UI in the video area before the first video frame, and falls back to Hybrid Composition on other devices. The meta-data applies to every platform view in the app.
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
