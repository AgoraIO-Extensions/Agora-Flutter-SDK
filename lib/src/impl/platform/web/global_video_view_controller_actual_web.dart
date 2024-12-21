import '/src/agora_rtc_engine.dart';
import '/src/impl/platform/global_video_view_controller_platform.dart';
import '/src/impl/platform/web/global_video_view_controller_platform_web.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

/// `createGlobalVideoViewController` stub function implementation on web,
/// see also: `lib/src/impl/platform/global_video_view_controller_expect.dart`
GlobalVideoViewControllerPlatfrom createGlobalVideoViewController(
    IrisMethodChannel irisMethodChannel, RtcEngine rtcEngine) {
  return GlobalVideoViewControllerWeb(irisMethodChannel, rtcEngine);
}
