// TODO(littlegnal): Temporary disable somke test for iOS/macOS, because it is not stable 
// to run somke test on CI at this time
@Skip('currently failing')

import 'dart:convert';
import 'dart:typed_data';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/src/api_types.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_test_app/main.dart' as app;
import 'package:integration_test_app/src/fake_iris_rtc_engine.dart';
import 'package:integration_test_app/src/configs.dart' as config;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('can create a RtcEngine after destroy multiple times',
      (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    RtcEngine rtcEngine = await RtcEngine.create(config.appId);
    await rtcEngine.enableVideo();
    await rtcEngine.destroy();

    rtcEngine = await RtcEngine.create(config.appId);
    await rtcEngine.enableVideo();
    await rtcEngine.destroy();

    rtcEngine = await RtcEngine.create(config.appId);
    await rtcEngine.enableVideo();
    await rtcEngine.destroy();
  });

  testWidgets(
    'getCameraMaxZoomFactor',
    (WidgetTester tester) async {
      RtcEngine rtcEngine = await RtcEngine.create(config.appId);
      await rtcEngine.startPreview();
      try {
        await rtcEngine.getCameraMaxZoomFactor();
      } catch (e) {
        final exception = e as PlatformException;
        // -4 = ErrorCode.NotSupported
        // It's allow this function return -4
        if ('-4' != exception.code) {
          rethrow;
        }
      }

      await rtcEngine.destroy();
    },
    skip: defaultTargetPlatform != TargetPlatform.iOS,
  );

  testWidgets(
    'getCameraMaxZoomFactor',
    (WidgetTester tester) async {
      RtcEngine rtcEngine = await RtcEngine.create(config.appId);
      await rtcEngine.startPreview();
      try {
        await rtcEngine.getCameraMaxZoomFactor();
      } catch (e) {
        final exception = e as PlatformException;
        // -4 = ErrorCode.NotSupported
        // It's allow this function return -4
        if ('-4' != exception.code) {
          rethrow;
        }
      }

      await rtcEngine.destroy();
    },
    skip: defaultTargetPlatform != TargetPlatform.iOS,
  );

  testWidgets(
    'isCameraAutoFocusFaceModeSupported',
    (WidgetTester tester) async {
      RtcEngine rtcEngine = await RtcEngine.create(config.appId);
      await rtcEngine.startPreview();
      await rtcEngine.isCameraAutoFocusFaceModeSupported();

      await rtcEngine.destroy();
    },
  );

  testWidgets(
    'isCameraExposurePositionSupported',
    (WidgetTester tester) async {
      RtcEngine rtcEngine = await RtcEngine.create(config.appId);
      await rtcEngine.startPreview();
      await rtcEngine.isCameraExposurePositionSupported();

      await rtcEngine.destroy();
    },
  );

  testWidgets(
    'isCameraFocusSupported',
    (WidgetTester tester) async {
      RtcEngine rtcEngine = await RtcEngine.create(config.appId);
      await rtcEngine.startPreview();
      await rtcEngine.isCameraFocusSupported();

      await rtcEngine.destroy();
    },
  );

  testWidgets(
    'isCameraZoomSupported',
    (WidgetTester tester) async {
      RtcEngine rtcEngine = await RtcEngine.create(config.appId);
      await rtcEngine.startPreview();
      await rtcEngine.isCameraZoomSupported();

      await rtcEngine.destroy();
    },
  );

  testWidgets(
    'setCameraAutoFocusFaceModeEnabled',
    (WidgetTester tester) async {
      RtcEngine rtcEngine = await RtcEngine.create(config.appId);
      await rtcEngine.startPreview();
      await rtcEngine.setCameraAutoFocusFaceModeEnabled(true);

      await rtcEngine.destroy();
    },
  );

  testWidgets(
    'setCameraExposurePosition',
    (WidgetTester tester) async {
      RtcEngine rtcEngine = await RtcEngine.create(config.appId);
      await rtcEngine.startPreview();
      await rtcEngine.setCameraExposurePosition(10, 10);

      await rtcEngine.destroy();
    },
  );

  testWidgets(
    'setCameraFocusPositionInPreview',
    (WidgetTester tester) async {
      RtcEngine rtcEngine = await RtcEngine.create(config.appId);
      await rtcEngine.startPreview();
      await rtcEngine.setCameraFocusPositionInPreview(10, 10);

      await rtcEngine.destroy();
    },
  );

  testWidgets(
    'setCameraZoomFactor',
    (WidgetTester tester) async {
      RtcEngine rtcEngine = await RtcEngine.create(config.appId);
      await rtcEngine.startPreview();
      await rtcEngine.setCameraZoomFactor(1.0);

      await rtcEngine.destroy();
    },
  );

  testWidgets(
    'startRhythmPlayer',
    (WidgetTester tester) async {
      RtcEngine rtcEngine = await RtcEngine.create(config.appId);
      await rtcEngine.startPreview();
      RhythmPlayerConfig c =
          RhythmPlayerConfig(beatsPerMeasure: 2, beatsPerMinute: 2);
      await rtcEngine.startRhythmPlayer('/path', '/path', c);

      await rtcEngine.destroy();
    },
    // TODO(littlegnal): Add soundId later
    skip: true,
  );

  testWidgets(
    'stopRhythmPlayer',
    (WidgetTester tester) async {
      RtcEngine rtcEngine = await RtcEngine.create(config.appId);
      await rtcEngine.startPreview();

      await rtcEngine.stopRhythmPlayer();

      await rtcEngine.destroy();
    },
  );

  testWidgets(
    'stopRhythmPlayer',
    (WidgetTester tester) async {
      RtcEngine rtcEngine = await RtcEngine.create(config.appId);
      await rtcEngine.startPreview();

      await rtcEngine.stopRhythmPlayer();

      await rtcEngine.destroy();
    },
  );

  testWidgets(
    'configRhythmPlayer',
    (WidgetTester tester) async {
      RtcEngine rtcEngine = await RtcEngine.create(config.appId);
      await rtcEngine.startPreview();

      RhythmPlayerConfig c = RhythmPlayerConfig(
          beatsPerMeasure: 2, beatsPerMinute: 2, publish: false);
      await rtcEngine.configRhythmPlayer(c);

      await rtcEngine.destroy();
    },
  );

  testWidgets(
    'getNativeHandle',
    (WidgetTester tester) async {
      RtcEngine rtcEngine = await RtcEngine.create(config.appId);
      await rtcEngine.startPreview();

      final ret = await rtcEngine.getNativeHandle();
      expect(ret != 0, isTrue);

      await rtcEngine.destroy();
    },
    // TODO(littlegnal): Wait for iris fix
    skip: true,
  );
}
