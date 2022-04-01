import 'dart:io';

import 'package:dart_style/dart_style.dart';
import 'package:paraphrase/paraphrase.dart';
import 'package:path/path.dart' as path;
import 'package:testcase_gen/generator.dart';

import 'default_generator.dart';

class RtcEngineEventHandlerSomkeTestGenerator implements Generator {
  const RtcEngineEventHandlerSomkeTestGenerator();

  static const Map<String, String> _eventFieldMap = {
    'requestAudioFileInfoCallback': 'RequestAudioFileInfo',
    'airPlayIsConnected': 'AirPlayConnected',
  };

// TODO(littlegnal): Re-implement later
  static const List<String> _skipEvent = [
    'onMetadataReceived',
  ];

  static const Map<String, List<GeneratorConfigPlatform>> _restrictPlatforms = {
    'onFacePositionChanged': mobilePlatforms,
    'onScreenCaptureInfoUpdated': [GeneratorConfigPlatform.windows],
  };

  @override
  void generate(StringSink sink, ParseResult parseResult) {
    final clazz = parseResult.getClazz('RtcEngineEventHandler')[0];

    final fields = clazz.fields;

    final Map<String, List<String>> genericTypeAliasParametersMap =
        parseResult.genericTypeAliasParametersMap;

    final testCases = <String>[];

    const testCaseTemplate = '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
  app.main();
  await tester.pumpAndSettle();

  FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
  await fakeIrisEngine.initialize();
  final rtcEngine = await RtcEngine.create('123');
  {{TEST_CASE_BODY}}

  rtcEngine.destroy();
}, 
{{TEST_CASE_SKIP}}
);
    
    ''';

    for (final field in fields) {
      final fieldType = field.type.type;
      final paramsOfFieldType = genericTypeAliasParametersMap[fieldType]
          ?.map((e) => e.split(' ')[1])
          .toList();
      final paramsOfFieldTypeList = paramsOfFieldType?.join(',');

      final eventSuffix = _eventFieldMap[field.name] ?? field.name;

      final eventName =
          'on${eventSuffix.substring(0, 1).toUpperCase()}${eventSuffix.substring(1)}';

      if (_skipEvent.contains(eventName)) continue;

      final t = '''
bool ${field.name}Called = false;
rtcEngine.setEventHandler(RtcEngineEventHandler(
  ${field.name}: ($paramsOfFieldTypeList) {
    ${field.name}Called = true;
  },
));
  
fakeIrisEngine.fireRtcEngineEvent('$eventName');
// Wait for the `EventChannel` event be sent from Android/iOS side
await tester.pump(const Duration(milliseconds: 500));
expect(${field.name}Called, isTrue);
''';
      String skipExpression = '';
      if (_restrictPlatforms.containsKey(eventName)) {
        skipExpression =
            'skip: !(${_restrictPlatforms[eventName]!.map((e) => e.toPlatformExpression()).join(' || ')}),';
      }

      String testCase =
          testCaseTemplate.replaceAll('{{TEST_CASE_NAME}}', eventName);
      testCase = testCase.replaceAll('{{TEST_CASE_BODY}}', t);
      testCase = testCase.replaceAll('{{TEST_CASE_SKIP}}', skipExpression);

      testCases.add(testCase);
    }

    const testCasesContentTemplate = '''
$defaultHeader

import 'dart:io';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test_app/main.dart' as app;
import 'package:integration_test_app/src/fake_iris_rtc_engine.dart';

void rtcEngineEventHandlerSomkeTestCases() {
  {{TEST_CASES_CONTENT}}
}
''';

    final output = testCasesContentTemplate.replaceAll(
        '{{TEST_CASES_CONTENT}}', testCases.join("\n"));

    sink.writeln(DartFormatter().format(output));
  }

  @override
  IOSink? shouldGenerate(ParseResult parseResult) {
    if (parseResult.hasClass('RtcEngineEventHandler')) {
      return openSink(path.join(
          path.current,
          'integration_test_app',
          'integration_test',
          'agora_rtc_engine_event_handler_smoke_test.generated.dart'));
    }

    return null;
  }
}
