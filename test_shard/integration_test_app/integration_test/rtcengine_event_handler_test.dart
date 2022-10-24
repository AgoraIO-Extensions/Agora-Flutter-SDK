import 'dart:async';
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
    'onJoinChannelSuccess',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // String engineAppId = const String.fromEnvironment('TEST_APP_ID',
      //     defaultValue: '<YOUR_APP_ID>');

      // final irisTester = IrisTester();
      // final debugApiEngineIntPtr = irisTester.createDebugApiEngine();
      // setMockIrisApiEngineIntPtr(debugApiEngineIntPtr);

      // RtcEngine rtcEngine = createAgoraRtcEngine();
      // await rtcEngine.initialize(RtcEngineContext(
      //   appId: engineAppId,
      //   areaCode: AreaCode.areaCodeGlob.value(),
      // ));

      // final Completer<bool> calledEventCompleter = Completer();
      // final eventHandler = RtcEngineEventHandler(
      //   onJoinChannelSuccess: (connection, elapsed) {
      //     calledEventCompleter.complete(true);
      //   },
      // );
      // rtcEngine.registerEventHandler(eventHandler);

      // await Future.delayed(const Duration(seconds: 1));

      // irisTester.fireEvent('');

      // final calledEvent = await calledEventCompleter.future;

      // expect(calledEvent, isTrue);

      // rtcEngine.unregisterEventHandler(eventHandler);

      // await rtcEngine.release();
    },
//  skip: !(),
  );

  testWidgets(
    'onRejoinChannelSuccess',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // String engineAppId = const String.fromEnvironment('TEST_APP_ID',
      //     defaultValue: '<YOUR_APP_ID>');

      // final irisTester = IrisTester();
      // final debugApiEngineIntPtr = irisTester.createDebugApiEngine();

      // setMockIrisApiEngineIntPtr(debugApiEngineIntPtr);
      // RtcEngine rtcEngine = createAgoraRtcEngine();
      // await rtcEngine.initialize(RtcEngineContext(
      //   appId: engineAppId,
      //   areaCode: AreaCode.areaCodeGlob.value(),
      // ));

      // final Completer<bool> calledEventCompleter = Completer();
      // final eventHandler = RtcEngineEventHandler(
      //   onRejoinChannelSuccess: (connection, elapsed) {
      //     calledEventCompleter.complete(true);
      //   },
      // );
      // rtcEngine.registerEventHandler(eventHandler);

      // await Future.delayed(const Duration(seconds: 1));

      // irisTester.fireEvent('');

      // final calledEvent = await calledEventCompleter.future;

      // expect(calledEvent, isTrue);

      // rtcEngine.unregisterEventHandler(eventHandler);

      // await rtcEngine.release();
    },
//  skip: !(),
  );
}
