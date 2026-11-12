import '/src/agora_base.dart';
import '/src/agora_media_player.dart';
import '/src/agora_rtc_engine.dart';
import '/src/agora_rtc_engine_ex.dart';
import '/src/impl/media_player_controller_impl.dart';
import '/src/render/video_view_controller.dart';

/// Controller for AgoraVideoView, used to render media player video.
abstract class MediaPlayerController
    implements MediaPlayer, VideoViewControllerBase {
  /// @nodoc
  factory MediaPlayerController(
          {required RtcEngine rtcEngine,
          required VideoCanvas canvas,
          RtcConnection? connection,
          bool useFlutterTexture = false,
          bool useAndroidSurfaceView = false}) =>
      MediaPlayerControllerImpl(
        rtcEngine,
        canvas,
        connection,
        useFlutterTexture,
        useAndroidSurfaceView,
      );

  /// Creates a MediaPlayerController.
  Future<void> initialize();
}
