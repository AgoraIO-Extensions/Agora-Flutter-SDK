import 'package:agora_rtc_engine/src/agora_base.dart';
import 'package:agora_rtc_engine/src/agora_media_base.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine_ex.dart';
import 'package:agora_rtc_engine/src/impl/video_view_controller_impl.dart';
import 'package:meta/meta.dart';

/// A AgoraVideoView controller for rendering local and remote video.
///
/// On different platforms, the default view corresponding to this class is different:
///  Android:. If you want to use, set the useAndroidSurfaceView property to true.
///  iOS:. If you want to use Flutter Texture, set the useFlutterTexture property to true.
///  macOS and Windows:.
abstract class VideoViewControllerBase {
  /// RtcEngine.
  RtcEngine get rtcEngine;

  /// The local video view and settings. See VideoCanvas.
  VideoCanvas get canvas;

  /// The connection information. See RtcConnection.
  RtcConnection? get connection;

  /// Whether to use FlutterTexture to render video: true : Use FlutterTexture to render video. false : Do not use FlutterTexture to render video. FlutterTexture applies to iOS, macOS and Windows platforms.
  bool get useFlutterTexture;

  /// Whether to use Android SurfaceView to render video: true : Use Android SurfaceView to render video. false : Do not use Android SurfaceView to render video. Android SurfaceView applies to Android platform only.
  bool get useAndroidSurfaceView;

  @internal
  int getTextureId();

  @internal
  int getVideoSourceType();

  @internal
  Future<void> setupView(int nativeViewPtr);

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

/// A AgoraVideoView controller for rendering local and remote video.
///
/// On different platforms, the default view corresponding to this class is different:
///  Android:. If you want to use, set the useAndroidSurfaceView property to true.
///  iOS:. If you want to use Flutter Texture, set the useFlutterTexture property to true.
///  macOS and Windows:.
class VideoViewController
    with VideoViewControllerBaseMixin
    implements VideoViewControllerBase {
  /// @nodoc
  VideoViewController(
      {required this.rtcEngine,
      required this.canvas,
      this.useFlutterTexture = false,
      this.useAndroidSurfaceView = false})
      : connection = const RtcConnection();

  /// @nodoc
  VideoViewController.remote(
      {required this.rtcEngine,
      required this.canvas,
      required this.connection,
      this.useFlutterTexture = false,
      this.useAndroidSurfaceView = false})
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

  @protected
  @override
  int getVideoSourceType() {
    return canvas.uid! == 0
        ? VideoSourceType.videoSourceCamera.value()
        : VideoSourceType.videoSourceRemote.value();
  }
}
