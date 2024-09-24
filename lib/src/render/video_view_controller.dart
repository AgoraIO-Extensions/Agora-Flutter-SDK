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

/// A [VideoViewControllerBase] for managing picture-in-picture (PIP) features.
/// Use this controller to handle the picture-in-picture functionality.
///
/// Note that the behavior differs between Android and iOS:
///
/// - On Android:
///   The PIP feature controls the entire `Activity`, not a single [AgoraVideoView].
///   For more details on PIP on Android, see:
///   https://developer.android.com/develop/ui/views/picture-in-picture.
///   We recommend using a local [PIPVideoViewController] (uid = 0) to manage the PIP feature on Android.
///
/// - On iOS:
///   The PIP feature controls a single [AgoraVideoView].
///   For more details on PIP on iOS, see:
///   https://developer.apple.com/documentation/avkit/adopting-picture-in-picture-for-video-calls?language=objc.
///
/// Note that only one picture-in-picture instance can be active at a time.
abstract class PIPVideoViewController extends VideoViewControllerBase {
  /// Creates a [PIPVideoViewController] for the local user (uid = 0).
  factory PIPVideoViewController(
          {required RtcEngine rtcEngine,
          required VideoCanvas canvas,
          bool useFlutterTexture = false,
          bool useAndroidSurfaceView = false}) =>
      PIPVideoViewControllerImpl(
        rtcEngine: rtcEngine,
        canvas: canvas,
        useFlutterTexture: useFlutterTexture,
        useAndroidSurfaceView: useAndroidSurfaceView,
      );

  /// Creates a [PIPVideoViewController] for remote users.
  factory PIPVideoViewController.remote(
          {required RtcEngine rtcEngine,
          required VideoCanvas canvas,
          required RtcConnection connection,
          bool useFlutterTexture = false,
          bool useAndroidSurfaceView = false}) =>
      PIPVideoViewControllerImpl.remote(
        rtcEngine: rtcEngine,
        canvas: canvas,
        connection: connection,
        useFlutterTexture: useFlutterTexture,
        useAndroidSurfaceView: useAndroidSurfaceView,
      );

  /// Checks if picture-in-picture is supported.
  Future<bool> isPipSupported();

  /// Starts picture-in-picture mode with the specified [PipOptions].
  Future<void> startPictureInPicture(PipOptions options);

  /// Stops picture-in-picture mode.
  Future<void> stopPictureInPicture();

  /// Checks if the current mode is picture-in-picture.
  bool get isInPictureInPictureMode;
}
