import 'package:agora_rtc_engine/src/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/src/impl/platform/global_video_view_controller_platform.dart';
import 'package:agora_rtc_engine/src/impl/platform/io/global_video_view_controller_platform_io.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

/// `createGlobalVideoViewController` stub function implementation on `dart:io`,
/// see also: `lib/src/impl/platform/global_video_view_controller_expect.dart`
GlobalVideoViewControllerPlatfrom createGlobalVideoViewController(
    IrisMethodChannel irisMethodChannel, RtcEngine rtcEngine) {
  return GlobalVideoViewControllerIO(irisMethodChannel, rtcEngine);
}
