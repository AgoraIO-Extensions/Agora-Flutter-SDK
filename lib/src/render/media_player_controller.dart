import 'package:agora_rtc_ng/src/agora_base.dart';
import 'package:agora_rtc_ng/src/agora_media_player.dart';
import 'package:agora_rtc_ng/src/agora_rtc_engine.dart';
import 'package:agora_rtc_ng/src/impl/media_player_impl.dart';
import 'package:agora_rtc_ng/src/impl/video_view_controller_impl.dart';

/// The AgoraVideoView controller used to render the video for the media player.
abstract class MediaPlayerController extends MediaPlayer
    implements VideoViewControllerBase {
  /// Create a MediaPlayerController.
  /// Make sure the RtcEngine is initialized before you call this method.
  /// Make sure to call this method before calling other APIs in MediaPlayer .
  ///
  /// * [useAndroidSurfaceView] Whether to use Android SurfaceView to render video:
  ///  true: Use Android SurfaceView to render video.
  ///  false: Do not use Android SurfaceView to render video. Android SurfaceView applies to Android platform only.None
  ///
  /// * [useFlutterTexture] Whether to use FlutterTexture to render video:
  ///  true: Use FlutterTexture to render video.
  ///  false: Do not use FlutterTexture to render video. FlutterTexture applies to iOS, macOS and Windows platforms.None
  ///
  /// * [canvas] Local video display properties. See VideoCanvas .None
  ///
  /// * [rtcEngine]  RtcEngine .None
  ///
  /// ## Return
  /// MediaPlayerController object.
  static Future<MediaPlayerController> create(
      {required RtcEngine rtcEngine,
      required VideoCanvas canvas,
      bool useFlutterTexture = false,
      bool useAndroidSurfaceView = false}) async {
    return MediaPlayerImpl.createMediaPlayerController(
        rtcEngine: rtcEngine,
        canvas: canvas,
        useFlutterTexture: useFlutterTexture,
        useAndroidSurfaceView: useAndroidSurfaceView);
  }
}
