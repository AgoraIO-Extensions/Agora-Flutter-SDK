import 'dart:convert';
import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:path_provider/path_provider.dart';
import 'generated/rtcengine_smoke_test.generated.dart' as generated;
import 'package:integration_test_app/main.dart' as app;
import 'package:path/path.dart' as path;
import 'package:agora_rtc_engine/src/impl/api_caller.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'getEffectDuration',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      // final irisTester = IrisTester();
      // final debugApiEngineIntPtr = irisTester.createDebugApiEngine();

      // setMockIrisApiEngineIntPtr(debugApiEngineIntPtr);
      // RtcEngine rtcEngine = createAgoraRtcEngine();
      // await rtcEngine.initialize(RtcEngineContext(
      //   appId: engineAppId,
      //   areaCode: AreaCode.areaCodeGlob.value(),
      // ));

      // final filePath = 'path';

      // await rtcEngine.getEffectDuration(
      //   filePath,
      // );

      // irisTester.expectCalled(
      //     'RtcEngine_getEffectDuration', jsonEncode({'filePath': filePath}));

      // try {
      //   ByteData data =
      //       await rootBundle.load("assets/Agora.io-Interactions.mp3");
      //   List<int> bytes =
      //       data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      //   Directory appDocDir = await getApplicationDocumentsDirectory();
      //   String filePath =
      //       path.join(appDocDir.path, 'Agora.io-Interactions.mp3');
      //   final file = File(filePath);
      //   if (!(await file.exists())) {
      //     await file.create();
      //     await file.writeAsBytes(bytes);
      //   }

      //   await rtcEngine.getEffectDuration(
      //     filePath,
      //   );
      // } catch (e) {
      //   if (e is! AgoraRtcException) {
      //     debugPrint('[getEffectDuration] error: ${e.toString()}');
      //   }
      //   expect(e is AgoraRtcException, true);
      //   debugPrint(
      //       '[getEffectDuration] errorcode: ${(e as AgoraRtcException).code}');
      // }

      // await rtcEngine.release();
    },
//  skip: !(),
  );
}
