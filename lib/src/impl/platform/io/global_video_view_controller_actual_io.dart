import 'package:agora_rtc_engine/src/impl/agora_rtc_engine_impl.dart';
import 'package:agora_rtc_engine/src/impl/platform/global_video_view_controller_platform.dart';
import 'package:agora_rtc_engine/src/impl/platform/io/global_video_view_controller_platform_io.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

/// `createGlobalVideoViewController` stub function implementation on `dart:io`,
/// see also: `lib/src/impl/platform/global_video_view_controller_expect.dart`
GlobalVideoViewControllerPlatfrom createGlobalVideoViewController(
    IrisMethodChannel irisMethodChannel, RtcEngineImpl rtcEngine) {
  return GlobalVideoViewControllerIO(irisMethodChannel, rtcEngine);
}
