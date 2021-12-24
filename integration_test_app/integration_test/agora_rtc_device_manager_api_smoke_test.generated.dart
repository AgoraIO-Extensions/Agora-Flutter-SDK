import 'dart:io';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test_app/main.dart' as app;

void rtcDeviceManagerSmokeTestCases() {
  testWidgets(
    'enumerateAudioPlaybackDevices',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = await RtcEngine.create(engineAppId);
      final deviceManager = rtcEngine.deviceManager;

      await deviceManager.enumerateAudioPlaybackDevices();

      await rtcEngine.destroy();
    },
    skip: !(Platform.isMacOS || Platform.isWindows || Platform.isLinux),
  );

  testWidgets(
    'setAudioPlaybackDevice',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = await RtcEngine.create(engineAppId);
      final deviceManager = rtcEngine.deviceManager;

      const String deviceId = "hello";
      await deviceManager.setAudioPlaybackDevice(
        deviceId,
      );

      await rtcEngine.destroy();
    },
    skip: !(Platform.isMacOS || Platform.isWindows || Platform.isLinux),
  );

  testWidgets(
    'getAudioPlaybackDevice',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = await RtcEngine.create(engineAppId);
      final deviceManager = rtcEngine.deviceManager;

      await deviceManager.getAudioPlaybackDevice();

      await rtcEngine.destroy();
    },
    skip: !(Platform.isMacOS || Platform.isWindows || Platform.isLinux),
  );

  testWidgets(
    'getAudioPlaybackDeviceInfo',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = await RtcEngine.create(engineAppId);
      final deviceManager = rtcEngine.deviceManager;

      await deviceManager.getAudioPlaybackDeviceInfo();

      await rtcEngine.destroy();
    },
    skip: !(Platform.isMacOS || Platform.isWindows || Platform.isLinux),
  );

  testWidgets(
    'setAudioPlaybackDeviceVolume',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = await RtcEngine.create(engineAppId);
      final deviceManager = rtcEngine.deviceManager;

      const int volume = 10;
      await deviceManager.setAudioPlaybackDeviceVolume(
        volume,
      );

      await rtcEngine.destroy();
    },
    skip: !(Platform.isMacOS || Platform.isWindows || Platform.isLinux),
  );

  testWidgets(
    'getAudioPlaybackDeviceVolume',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = await RtcEngine.create(engineAppId);
      final deviceManager = rtcEngine.deviceManager;

      await deviceManager.getAudioPlaybackDeviceVolume();

      await rtcEngine.destroy();
    },
    skip: !(Platform.isMacOS || Platform.isWindows || Platform.isLinux),
  );

  testWidgets(
    'setAudioPlaybackDeviceMute',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = await RtcEngine.create(engineAppId);
      final deviceManager = rtcEngine.deviceManager;

      const bool mute = true;
      await deviceManager.setAudioPlaybackDeviceMute(
        mute,
      );

      await rtcEngine.destroy();
    },
    skip: !(Platform.isMacOS || Platform.isWindows || Platform.isLinux),
  );

  testWidgets(
    'getAudioPlaybackDeviceMute',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = await RtcEngine.create(engineAppId);
      final deviceManager = rtcEngine.deviceManager;

      await deviceManager.getAudioPlaybackDeviceMute();

      await rtcEngine.destroy();
    },
    skip: !(Platform.isMacOS || Platform.isWindows || Platform.isLinux),
  );

  testWidgets(
    'startAudioPlaybackDeviceTest',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = await RtcEngine.create(engineAppId);
      final deviceManager = rtcEngine.deviceManager;

      const String testAudioFilePath = "hello";
      await deviceManager.startAudioPlaybackDeviceTest(
        testAudioFilePath,
      );

      await rtcEngine.destroy();
    },
    skip: !(Platform.isMacOS || Platform.isWindows || Platform.isLinux),
  );

  testWidgets(
    'stopAudioPlaybackDeviceTest',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = await RtcEngine.create(engineAppId);
      final deviceManager = rtcEngine.deviceManager;

      await deviceManager.stopAudioPlaybackDeviceTest();

      await rtcEngine.destroy();
    },
    skip: !(Platform.isMacOS || Platform.isWindows || Platform.isLinux),
  );

  testWidgets(
    'enumerateAudioRecordingDevices',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = await RtcEngine.create(engineAppId);
      final deviceManager = rtcEngine.deviceManager;

      await deviceManager.enumerateAudioRecordingDevices();

      await rtcEngine.destroy();
    },
    skip: !(Platform.isMacOS || Platform.isWindows || Platform.isLinux),
  );

  testWidgets(
    'setAudioRecordingDevice',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = await RtcEngine.create(engineAppId);
      final deviceManager = rtcEngine.deviceManager;

      const String deviceId = "hello";
      await deviceManager.setAudioRecordingDevice(
        deviceId,
      );

      await rtcEngine.destroy();
    },
    skip: !(Platform.isMacOS || Platform.isWindows || Platform.isLinux),
  );

  testWidgets(
    'getAudioRecordingDevice',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = await RtcEngine.create(engineAppId);
      final deviceManager = rtcEngine.deviceManager;

      await deviceManager.getAudioRecordingDevice();

      await rtcEngine.destroy();
    },
    skip: !(Platform.isMacOS || Platform.isWindows || Platform.isLinux),
  );

  testWidgets(
    'getAudioRecordingDeviceInfo',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = await RtcEngine.create(engineAppId);
      final deviceManager = rtcEngine.deviceManager;

      await deviceManager.getAudioRecordingDeviceInfo();

      await rtcEngine.destroy();
    },
    skip: !(Platform.isMacOS || Platform.isWindows || Platform.isLinux),
  );

  testWidgets(
    'setAudioRecordingDeviceVolume',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = await RtcEngine.create(engineAppId);
      final deviceManager = rtcEngine.deviceManager;

      const int volume = 10;
      await deviceManager.setAudioRecordingDeviceVolume(
        volume,
      );

      await rtcEngine.destroy();
    },
    skip: !(Platform.isMacOS || Platform.isWindows || Platform.isLinux),
  );

  testWidgets(
    'getAudioRecordingDeviceVolume',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = await RtcEngine.create(engineAppId);
      final deviceManager = rtcEngine.deviceManager;

      await deviceManager.getAudioRecordingDeviceVolume();

      await rtcEngine.destroy();
    },
    skip: !(Platform.isMacOS || Platform.isWindows || Platform.isLinux),
  );

  testWidgets(
    'setAudioRecordingDeviceMute',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = await RtcEngine.create(engineAppId);
      final deviceManager = rtcEngine.deviceManager;

      const bool mute = true;
      await deviceManager.setAudioRecordingDeviceMute(
        mute,
      );

      await rtcEngine.destroy();
    },
    skip: !(Platform.isMacOS || Platform.isWindows || Platform.isLinux),
  );

  testWidgets(
    'getAudioRecordingDeviceMute',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = await RtcEngine.create(engineAppId);
      final deviceManager = rtcEngine.deviceManager;

      await deviceManager.getAudioRecordingDeviceMute();

      await rtcEngine.destroy();
    },
    skip: !(Platform.isMacOS || Platform.isWindows || Platform.isLinux),
  );

  testWidgets(
    'startAudioRecordingDeviceTest',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = await RtcEngine.create(engineAppId);
      final deviceManager = rtcEngine.deviceManager;

      const String testAudioFilePath = "hello";
      await deviceManager.startAudioRecordingDeviceTest(
        testAudioFilePath,
      );

      await rtcEngine.destroy();
    },
    skip: !(Platform.isMacOS || Platform.isWindows || Platform.isLinux),
  );

  testWidgets(
    'stopAudioRecordingDeviceTest',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = await RtcEngine.create(engineAppId);
      final deviceManager = rtcEngine.deviceManager;

      await deviceManager.stopAudioRecordingDeviceTest();

      await rtcEngine.destroy();
    },
    skip: !(Platform.isMacOS || Platform.isWindows || Platform.isLinux),
  );

  testWidgets(
    'startAudioDeviceLoopbackTest',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = await RtcEngine.create(engineAppId);
      final deviceManager = rtcEngine.deviceManager;

      const int indicationInterval = 10;
      await deviceManager.startAudioDeviceLoopbackTest(
        indicationInterval,
      );

      await rtcEngine.destroy();
    },
    skip: !(Platform.isMacOS || Platform.isWindows || Platform.isLinux),
  );

  testWidgets(
    'stopAudioDeviceLoopbackTest',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = await RtcEngine.create(engineAppId);
      final deviceManager = rtcEngine.deviceManager;

      await deviceManager.stopAudioDeviceLoopbackTest();

      await rtcEngine.destroy();
    },
    skip: !(Platform.isMacOS || Platform.isWindows || Platform.isLinux),
  );

  testWidgets(
    'enumerateVideoDevices',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = await RtcEngine.create(engineAppId);
      final deviceManager = rtcEngine.deviceManager;

      await deviceManager.enumerateVideoDevices();

      await rtcEngine.destroy();
    },
    skip: !(Platform.isMacOS || Platform.isWindows || Platform.isLinux),
  );

  testWidgets(
    'setVideoDevice',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = await RtcEngine.create(engineAppId);
      final deviceManager = rtcEngine.deviceManager;

      const String deviceId = "hello";
      await deviceManager.setVideoDevice(
        deviceId,
      );

      await rtcEngine.destroy();
    },
    skip: !(Platform.isMacOS || Platform.isWindows || Platform.isLinux),
  );

  testWidgets(
    'getVideoDevice',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = await RtcEngine.create(engineAppId);
      final deviceManager = rtcEngine.deviceManager;

      await deviceManager.getVideoDevice();

      await rtcEngine.destroy();
    },
    skip: !(Platform.isMacOS || Platform.isWindows || Platform.isLinux),
  );

  testWidgets(
    'startVideoDeviceTest',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = await RtcEngine.create(engineAppId);
      final deviceManager = rtcEngine.deviceManager;

      const int hwnd = 10;
      await deviceManager.startVideoDeviceTest(
        hwnd,
      );

      await rtcEngine.destroy();
    },
    skip: !(Platform.isMacOS || Platform.isWindows || Platform.isLinux),
  );

  testWidgets(
    'stopVideoDeviceTest',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = await RtcEngine.create(engineAppId);
      final deviceManager = rtcEngine.deviceManager;

      await deviceManager.stopVideoDeviceTest();

      await rtcEngine.destroy();
    },
    skip: !(Platform.isMacOS || Platform.isWindows || Platform.isLinux),
  );
}
