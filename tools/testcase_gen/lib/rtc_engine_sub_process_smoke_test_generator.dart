import 'dart:io';

import 'package:paraphrase/paraphrase.dart';
import 'package:path/path.dart' as path;
import 'package:testcase_gen/default_generator.dart';
import 'package:testcase_gen/generator.dart';

class RtcEngineSubProcessSmokeTestGenerator extends DefaultGenerator {
  const RtcEngineSubProcessSmokeTestGenerator();

  static const List<GeneratorConfig> configs = [
    GeneratorConfig(name: 'getScreenShareHelper', donotGenerate: true),
    GeneratorConfig(name: 'instance', donotGenerate: true),
    GeneratorConfig(name: 'initialize', donotGenerate: true),
    GeneratorConfig(name: 'getSdkVersion', donotGenerate: true),
    GeneratorConfig(name: 'getErrorDescription', donotGenerate: true),

    // TODO(littlegnal): This should be a getter proerpty.
    GeneratorConfig(name: 'methodChannel', donotGenerate: true),
    GeneratorConfig(name: 'setEventHandler', donotGenerate: true),
    GeneratorConfig(name: 'sendMetadata', donotGenerate: true),
    GeneratorConfig(name: 'sendStreamMessage', donotGenerate: true),
    // TODO(littlegnal): Re-enable it later
    // GeneratorConfig(name: 'setLiveTranscoding', donotGenerate: true),
    // TODO(littlegnal): Re-enable it later
    GeneratorConfig(name: 'enableVirtualBackground', donotGenerate: true),
    GeneratorConfig(name: 'deviceManager', donotGenerate: true),
    GeneratorConfig(name: 'destroy', donotGenerate: true),
    GeneratorConfig(
      name: 'enableLoopbackRecording',
      supportedPlatforms: desktopPlatforms,
    ),
    // TODO(littlegnal): Re-enable it later
    GeneratorConfig(name: 'setVideoEncoderConfiguration', donotGenerate: true),
    GeneratorConfig(name: 'getUserInfoByUid', donotGenerate: true),
    GeneratorConfig(name: 'getUserInfoByUserAccount', donotGenerate: true),
    GeneratorConfig(name: 'getConnectionState', donotGenerate: true),
    // Only run on valid appId.
    GeneratorConfig(name: 'getCameraMaxZoomFactor', donotGenerate: true),
    GeneratorConfig(
        name: 'isCameraAutoFocusFaceModeSupported', donotGenerate: true),
    GeneratorConfig(
        name: 'isCameraExposurePositionSupported', donotGenerate: true),
    GeneratorConfig(name: 'isCameraFocusSupported', donotGenerate: true),
    GeneratorConfig(name: 'isCameraZoomSupported', donotGenerate: true),
    GeneratorConfig(
        name: 'setCameraAutoFocusFaceModeEnabled', donotGenerate: true),
    GeneratorConfig(name: 'setCameraExposurePosition', donotGenerate: true),
    GeneratorConfig(
        name: 'setCameraFocusPositionInPreview', donotGenerate: true),
    GeneratorConfig(name: 'setCameraZoomFactor', donotGenerate: true),
    GeneratorConfig(name: 'startRhythmPlayer', donotGenerate: true),
    GeneratorConfig(name: 'stopRhythmPlayer', donotGenerate: true),
    GeneratorConfig(name: 'configRhythmPlayer', donotGenerate: true),
    GeneratorConfig(name: 'getNativeHandle', donotGenerate: true),
    GeneratorConfig(name: 'startEchoTest', donotGenerate: true),

// TODO(littlegnal): Re-enable it later
    GeneratorConfig(name: 'takeSnapshot', donotGenerate: true),

    // Destop only
    GeneratorConfig(
      name: 'setAudioSessionOperationRestriction',
      supportedPlatforms: desktopPlatforms,
    ),
    GeneratorConfig(
      name: 'setScreenCaptureContentHint',
      supportedPlatforms: desktopPlatforms,
    ),
    GeneratorConfig(
      name: 'startScreenCaptureByDisplayId',
      supportedPlatforms: desktopPlatforms,
    ),
    GeneratorConfig(
      name: 'startScreenCaptureByScreenRect',
      supportedPlatforms: desktopPlatforms,
    ),
    GeneratorConfig(
      name: 'startScreenCaptureByWindowId',
      supportedPlatforms: desktopPlatforms,
    ),
    GeneratorConfig(
      name: 'stopScreenCapture',
      supportedPlatforms: desktopPlatforms,
    ),
    GeneratorConfig(
      name: 'updateScreenCaptureParameters',
      supportedPlatforms: desktopPlatforms,
    ),
    GeneratorConfig(
      name: 'updateScreenCaptureRegion',
      supportedPlatforms: desktopPlatforms,
    ),
    GeneratorConfig(
      name: 'startScreenCapture',
      supportedPlatforms: desktopPlatforms,
    ),
  ];

  @override
  void generate(StringSink sink, ParseResult parseResult) {
    final clazz = parseResult.getClazz('RtcEngine')[0];

    const testCaseTemplate = '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    String engineAppId = const String.fromEnvironment('TEST_APP_ID',
      defaultValue: '<YOUR_APP_ID>');

    RtcEngine rtcEngine = await RtcEngine.createWithContext(RtcEngineContext(
    engineAppId,
    areaCode: [AreaCode.NA, AreaCode.GLOB],
  ));

    final screenShareHelper = await rtcEngine.getScreenShareHelper(appGroup: 'io.agora');

    {{TEST_CASE_BODY}}

    await screenShareHelper.destroy();
    await rtcEngine.destroy();
  },
  skip: {{TEST_CASE_SKIP}},
);
''';

    const testCasesContentTemplate = '''
$defaultHeader

import 'dart:io';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test_app/main.dart' as app;

void rtcEngineSubProcessSmokeTestCases() {
  {{TEST_CASES_CONTENT}}
}
''';

    final output = generateWithTemplate(
      parseResult: parseResult,
      clazz: clazz,
      testCaseTemplate: testCaseTemplate,
      testCasesContentTemplate: testCasesContentTemplate,
      methodInvokeObjectName: 'screenShareHelper',
      configs: configs,
      supportedPlatformsOverride: desktopPlatforms,
    );

    sink.writeln(output);
  }

  @override
  IOSink? shouldGenerate(ParseResult parseResult) {
    if (parseResult.hasClass('RtcEngine')) {
      return openSink(path.join(
          path.current,
          'integration_test_app',
          'integration_test',
          'agora_rtc_engine_subprocess_api_smoke_test.generated.dart'));
    }

    return null;
  }
}
