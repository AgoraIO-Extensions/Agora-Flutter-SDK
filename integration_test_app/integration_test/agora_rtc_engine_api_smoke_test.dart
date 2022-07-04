import 'dart:io';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_test_app/main.dart' as app;
import 'package:integration_test_app/src/configs.dart' as config;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'can create a RtcEngine after destroy multiple times',
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
    },
    skip: !(Platform.isAndroid || Platform.isIOS),
  );

  testWidgets(
    'getCameraMaxZoomFactor',
    (WidgetTester tester) async {
      RtcEngine rtcEngine = await RtcEngine.create(config.appId);
      await rtcEngine.startPreview();
      try {
        await rtcEngine.getCameraMaxZoomFactor();
      } catch (e, s) {
        debugPrint(
            'getCameraMaxZoomFactor exception: ${e.toString()}, stacktrack: $s');
        final exception = e as PlatformException;
        // -4 = ErrorCode.NotSupported
        // It's allow this function return -4
        if ('-4' != exception.code) {
          rethrow;
        }
      }

      await rtcEngine.destroy();
    },
    skip: !(Platform.isAndroid || Platform.isIOS),
  );

  testWidgets(
    'isCameraAutoFocusFaceModeSupported',
    (WidgetTester tester) async {
      RtcEngine rtcEngine = await RtcEngine.create(config.appId);
      await rtcEngine.startPreview();
      await rtcEngine.isCameraAutoFocusFaceModeSupported();

      await rtcEngine.destroy();
    },
    skip: !(Platform.isAndroid || Platform.isIOS),
  );

  testWidgets(
    'isCameraExposurePositionSupported',
    (WidgetTester tester) async {
      RtcEngine rtcEngine = await RtcEngine.create(config.appId);
      await rtcEngine.startPreview();
      await rtcEngine.isCameraExposurePositionSupported();

      await rtcEngine.destroy();
    },
    skip: !(Platform.isAndroid || Platform.isIOS),
  );

  testWidgets(
    'isCameraFocusSupported',
    (WidgetTester tester) async {
      RtcEngine rtcEngine = await RtcEngine.create(config.appId);
      await rtcEngine.startPreview();
      await rtcEngine.isCameraFocusSupported();

      await rtcEngine.destroy();
    },
    skip: !(Platform.isAndroid || Platform.isIOS),
  );

  testWidgets(
    'isCameraZoomSupported',
    (WidgetTester tester) async {
      RtcEngine rtcEngine = await RtcEngine.create(config.appId);
      await rtcEngine.startPreview();
      await rtcEngine.isCameraZoomSupported();

      await rtcEngine.destroy();
    },
    skip: !(Platform.isAndroid || Platform.isIOS),
  );

  testWidgets(
    'setCameraAutoFocusFaceModeEnabled',
    (WidgetTester tester) async {
      RtcEngine rtcEngine = await RtcEngine.create(config.appId);
      await rtcEngine.startPreview();
      await rtcEngine.setCameraAutoFocusFaceModeEnabled(true);

      await rtcEngine.destroy();
    },
    skip: !(Platform.isAndroid || Platform.isIOS),
  );

  testWidgets(
    'setCameraExposurePosition',
    (WidgetTester tester) async {
      RtcEngine rtcEngine = await RtcEngine.create(config.appId);
      await rtcEngine.startPreview();
      await rtcEngine.setCameraExposurePosition(10, 10);

      await rtcEngine.destroy();
    },
    skip: !(Platform.isAndroid || Platform.isIOS),
  );

  testWidgets(
    'setCameraFocusPositionInPreview',
    (WidgetTester tester) async {
      RtcEngine rtcEngine = await RtcEngine.create(config.appId);
      await rtcEngine.startPreview();
      await rtcEngine.setCameraFocusPositionInPreview(10, 10);

      await rtcEngine.destroy();
    },
    skip: !(Platform.isAndroid || Platform.isIOS),
  );

  testWidgets(
    'setCameraZoomFactor',
    (WidgetTester tester) async {
      RtcEngine rtcEngine = await RtcEngine.create(config.appId);
      await rtcEngine.startPreview();
      await rtcEngine.setCameraZoomFactor(1.0);

      await rtcEngine.destroy();
    },
    skip: !(Platform.isAndroid || Platform.isIOS),
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

    // skip: !(Platform.isAndroid || Platform.isIOS),
    // TODO(littlegnal): [MS-99386] Wait for iris fix.
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
    skip: !(Platform.isAndroid || Platform.isIOS),
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
    skip: !(Platform.isAndroid || Platform.isIOS),
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
  );

  testWidgets(
    'updateScreenCaptureParametersMobile',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      final context = RtcEngineContext(
        engineAppId,
        areaCode: const [AreaCode.GLOB],
      );

      final rtcEngine = await RtcEngine.createWithContext(context);

      const int audioParamsCaptureSignalVolume = 10;
      const ScreenAudioParameters parametersAudioParams = ScreenAudioParameters(
        audioParamsCaptureSignalVolume,
      );
      const int dimensionsWidth = 10;
      const int dimensionsHeight = 10;
      const VideoDimensions videoParamsDimensions = VideoDimensions(
        width: dimensionsWidth,
        height: dimensionsHeight,
      );
      const VideoContentHint videoParamsContentHint = VideoContentHint.None;
      const int videoParamsFrameRate = 10;
      const int videoParamsBitrate = 10;
      const ScreenVideoParameters parametersVideoParams = ScreenVideoParameters(
        dimensions: videoParamsDimensions,
        frameRate: videoParamsFrameRate,
        bitrate: videoParamsBitrate,
        contentHint: videoParamsContentHint,
      );
      const bool parametersCaptureAudio = true;
      const bool parametersCaptureVideo = true;
      const ScreenCaptureParameters2 parameters = ScreenCaptureParameters2(
        captureAudio: parametersCaptureAudio,
        audioParams: parametersAudioParams,
        captureVideo: parametersCaptureVideo,
        videoParams: parametersVideoParams,
      );
      await rtcEngine.updateScreenCaptureParametersMobile(
        parameters,
      );
    },
    skip: !(Platform.isAndroid || Platform.isIOS),
  );

  testWidgets(
    'startScreenCaptureMobile',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      final context = RtcEngineContext(
        engineAppId,
        areaCode: const [AreaCode.GLOB],
      );

      final rtcEngine = await RtcEngine.createWithContext(context);

      const int audioParamsCaptureSignalVolume = 10;
      const ScreenAudioParameters parametersAudioParams = ScreenAudioParameters(
        audioParamsCaptureSignalVolume,
      );
      const int dimensionsWidth = 10;
      const int dimensionsHeight = 10;
      const VideoDimensions videoParamsDimensions = VideoDimensions(
        width: dimensionsWidth,
        height: dimensionsHeight,
      );
      const VideoContentHint videoParamsContentHint = VideoContentHint.None;
      const int videoParamsFrameRate = 10;
      const int videoParamsBitrate = 10;
      const ScreenVideoParameters parametersVideoParams = ScreenVideoParameters(
        dimensions: videoParamsDimensions,
        frameRate: videoParamsFrameRate,
        bitrate: videoParamsBitrate,
        contentHint: videoParamsContentHint,
      );
      const bool parametersCaptureAudio = true;
      const bool parametersCaptureVideo = true;
      const ScreenCaptureParameters2 parameters = ScreenCaptureParameters2(
        captureAudio: parametersCaptureAudio,
        audioParams: parametersAudioParams,
        captureVideo: parametersCaptureVideo,
        videoParams: parametersVideoParams,
      );
      await rtcEngine.startScreenCaptureMobile(
        parameters,
      );
    },
    skip: !(Platform.isAndroid || Platform.isIOS),
  );
}
