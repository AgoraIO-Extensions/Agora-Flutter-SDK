import 'dart:io';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:agora_rtc_engine/media_recorder.dart';

import 'package:integration_test_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'MediaRecorder smoke test',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = await RtcEngine.createWithContext(RtcEngineContext(
        engineAppId,
        areaCode: [AreaCode.NA, AreaCode.GLOB],
      ));

      MediaRecorder mediaRecorder = MediaRecorder.getMediaRecorder(rtcEngine);

      MediaRecorderConfiguration config = MediaRecorderConfiguration();
      await mediaRecorder.startRecording(config);

      await mediaRecorder.stopRecording();
      await mediaRecorder.releaseRecorder();
      await rtcEngine.destroy();
    },
    skip: !(Platform.isMacOS || Platform.isWindows || Platform.isLinux),
  );
}
