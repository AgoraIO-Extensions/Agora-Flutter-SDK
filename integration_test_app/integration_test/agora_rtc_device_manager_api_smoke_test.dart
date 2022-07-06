import 'dart:io';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_test_app/main.dart' as app;

import 'agora_rtc_device_manager_api_smoke_test.generated.dart'
    as rtc_device_manager;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  rtc_device_manager.rtcDeviceManagerSmokeTestCases();

  testWidgets(
    'getVideoDevice',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = await RtcEngine.create(engineAppId);

      final deviceManager = rtcEngine.deviceManager;

      try {
        await rtcEngine.enableVideo();
        await deviceManager.getVideoDevice();
      } catch (e) {
        expect(e is PlatformException, isTrue);
      }

      await rtcEngine.destroy();
    },
    skip: !(Platform.isMacOS || Platform.isWindows || Platform.isLinux),
  );

  testWidgets(
    'followSystemPlaybackDevice',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = await RtcEngine.create(engineAppId);
      final deviceManager = rtcEngine.deviceManager;

      try {
        const bool enable = true;
        await deviceManager.followSystemPlaybackDevice(
          enable,
        );
      } catch (e) {
        if (e is! PlatformException) {
          rethrow;
        }
        expect(e.code != '-4', isTrue);
      }

      await rtcEngine.destroy();
    },
    skip: !(Platform.isMacOS || Platform.isWindows || Platform.isLinux),
  );

  testWidgets(
    'followSystemRecordingDevice',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = await RtcEngine.create(engineAppId);
      final deviceManager = rtcEngine.deviceManager;

      try {
        const bool enable = true;
        await deviceManager.followSystemRecordingDevice(
          enable,
        );
      } catch (e) {
        if (e is! PlatformException) {
          rethrow;
        }
        expect(e.code != '-4', isTrue);
      }

      await rtcEngine.destroy();
    },
    skip: !(Platform.isMacOS || Platform.isWindows || Platform.isLinux),
  );
}
