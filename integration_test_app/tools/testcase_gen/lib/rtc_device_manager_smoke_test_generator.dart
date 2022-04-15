import 'dart:io';

import 'package:paraphrase/paraphrase.dart';
import 'package:testcase_gen/default_generator.dart';
import 'package:testcase_gen/generator.dart';
import 'package:path/path.dart' as path;

class RtcDeviceManagerSmokeTestGenerator extends DefaultGenerator {
  const RtcDeviceManagerSmokeTestGenerator();

  static const List<GeneratorConfig> configs = [
    GeneratorConfig(name: 'getVideoDevice', donotGenerate: true),
  ];

  @override
  void generate(StringSink sink, ParseResult parseResult) {
    final clazz = parseResult.getClazz('RtcDeviceManager')[0];

    const testCaseTemplate = '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    String engineAppId = const String.fromEnvironment('TEST_APP_ID',
        defaultValue: '<YOUR_APP_ID>');

    RtcEngine rtcEngine = await RtcEngine.create(engineAppId);
    final deviceManager = rtcEngine.deviceManager;

    try {
      {{TEST_CASE_BODY}}
    } catch (e) {
      if (e is! PlatformException) {
        rethrow;
      }
      expect(e.code != '-7', isTrue);
    }

    await rtcEngine.destroy();
  },
  skip: {{TEST_CASE_SKIP}},
);
''';

    const testCasesContentTemplate = '''
$defaultHeader

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test_app/main.dart' as app;

void rtcDeviceManagerSmokeTestCases() {
  {{TEST_CASES_CONTENT}}
}
''';

    final output = generateWithTemplate(
      parseResult: parseResult,
      clazz: clazz,
      testCaseTemplate: testCaseTemplate,
      testCasesContentTemplate: testCasesContentTemplate,
      methodInvokeObjectName: 'deviceManager',
      configs: configs,
      supportedPlatformsOverride: desktopPlatforms,
    );

    sink.writeln(output);
  }

  @override
  IOSink? shouldGenerate(ParseResult parseResult) {
    if (parseResult.hasClass('RtcDeviceManager')) {
      return openSink(path.join(
          path.current,
          'integration_test_app',
          'integration_test',
          'agora_rtc_device_manager_api_smoke_test.generated.dart'));
    }

    return null;
  }
}
