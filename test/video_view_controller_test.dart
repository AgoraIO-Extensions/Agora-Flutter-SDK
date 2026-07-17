import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/src/impl/video_view_controller_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    debugDefaultTargetPlatformOverride = TargetPlatform.ohos;
  });

  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
  });

  test('OHOS ignores the Flutter texture request', () {
    final controller = VideoViewController(
      rtcEngine: createAgoraRtcEngine(),
      canvas: const VideoCanvas(uid: 0),
      useFlutterTexture: true,
    );

    expect(controller.shouldUseFlutterTexture, isFalse);
  });
}
