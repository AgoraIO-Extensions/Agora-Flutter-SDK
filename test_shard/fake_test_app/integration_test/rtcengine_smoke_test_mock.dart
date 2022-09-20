import 'dart:convert';
import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:iris_tester/iris_tester.dart';
import 'package:path/path.dart' as path;
import 'package:agora_rtc_engine/src/impl/api_caller.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'getEffectDuration',
    (WidgetTester tester) async {
      // app.main();
      // await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      final irisTester = IrisTester();
      final debugApiEngineIntPtr = irisTester.createDebugApiEngine();
      setMockIrisApiEngineIntPtr(debugApiEngineIntPtr);
      
      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      final filePath = 'path';

      await rtcEngine.getEffectDuration(
        filePath,
      );

      irisTester.expectCalled(
          'RtcEngine_getEffectDuration', jsonEncode({'filePath': filePath}));

      await rtcEngine.release();
    },
//  skip: !(),
  );
}
