import 'package:agora_rtc_engine/src/agora_base.dart';
import 'package:agora_rtc_engine/src/agora_media_player.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine_ex.dart';
import 'package:agora_rtc_engine/src/impl/media_player_controller_impl.dart';
import 'package:agora_rtc_engine/src/render/video_view_controller.dart';

/// AgoraVideoView 的控制器，用于渲染媒体播放器的视频。
///
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

  /// 创建一个 MediaPlayerController。
  /// 该方法需要在初始化 RtcEngine 对象后调用。请确保在调用其他 MediaPlayer 中的 API 前先调用该方法。
  Future<void> initialize();
}
