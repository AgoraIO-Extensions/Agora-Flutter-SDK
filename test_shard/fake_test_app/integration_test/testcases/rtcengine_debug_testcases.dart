import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:iris_tester/iris_tester.dart';

import 'package:agora_rtc_engine/agora_rtc_engine_debug.dart';
import 'package:path_provider/path_provider.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

void testCases() {
  testWidgets(
    'startDumpVideo/stopDumpVideo fake test',
    (WidgetTester tester) async {
      final irisTester = IrisTester();
      final debugApiEngineIntPtr = irisTester.getDebugApiEngineNativeHandle();
      setMockIrisMethodChannelNativeHandle(debugApiEngineIntPtr);

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngineEx rtcEngine = createAgoraRtcEngineEx();
      await rtcEngine.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      Directory appDocDir = await getApplicationDocumentsDirectory();

      await rtcEngine.startDumpVideo(
        VideoSourceType.videoSourceCamera.value(),
        appDocDir.absolute.path,
      );
      await rtcEngine.stopDumpVideo();
      await rtcEngine.release();
    },
    // TODO(littlegnal): Dump video raw data on Android is not supported at this time.
    skip: Platform.isAndroid,
  );
}
