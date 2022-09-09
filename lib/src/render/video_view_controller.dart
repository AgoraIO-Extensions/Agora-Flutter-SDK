import 'package:agora_rtc_engine/src/agora_base.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine_ex.dart';
import 'package:agora_rtc_engine/src/impl/video_view_controller_impl.dart';
import 'package:meta/meta.dart';

/// AgoraVideoView 的控制器，用于渲染本地和远端视频。
/// 在不同平台上，该类对应的默认视图不同：
///  Android: 。如果你想要使用 ，则设置 useAndroidSurfaceView 的属性为 true。iOS: 。 如果你想要使用 Flutter Texture，则设置 useFlutterTexture 的属性为 true。macOS 和 Windows：。
abstract class VideoViewControllerBase {
  ///  RtcEngine 。
  RtcEngine get rtcEngine;

  /// 本地视频显示属性。详见 VideoCanvas 。
  VideoCanvas get canvas;

  /// Connection 信息。详见 RtcConnection 。
  RtcConnection? get connection;

  /// 是否使用 FlutterTexture 渲染视频：
  ///  true: 使用 FlutterTexture 渲染视频。false: 不使用 FlutterTexture 渲染视频。FlutterTexture 仅适用于 iOS、macOS 和 Windows 平台。
  bool get useFlutterTexture;

  /// 是否使用 Android SurfaceView 渲染视频：
  ///  true: 使用 Android SurfaceView 渲染视频。false: 不使用 Android SurfaceView 渲染视频。Android SurfaceView 仅适用于 Android 平台。
  bool get useAndroidSurfaceView;

  @internal
  void setTextureId(int textureId);

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
  );

  @internal
  Future<void> initializeRender();

  @internal
  Future<void> disposeRender();

  /// @nodoc
  Future<void> dispose();
}

/// AgoraVideoView 的控制器，用于渲染本地和远端视频。
/// 在不同平台上，该类对应的默认视图不同：
///  Android: 。如果你想要使用 ，则设置 useAndroidSurfaceView 的属性为 true。iOS: 。 如果你想要使用 Flutter Texture，则设置 useFlutterTexture 的属性为 true。macOS 和 Windows：。
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
      : assert(connection.channelId != null);

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
