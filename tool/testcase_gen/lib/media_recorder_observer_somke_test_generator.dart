import 'dart:io';

import 'package:dart_style/dart_style.dart';
import 'package:paraphrase/paraphrase.dart';
import 'package:testcase_gen/default_generator.dart';
import 'package:testcase_gen/generator.dart';

class MediaRecorderObserverSomkeTestGenerator implements Generator {
  const MediaRecorderObserverSomkeTestGenerator();

  @override
  void generate(StringSink sink, ParseResult parseResult) {
    final clazz = parseResult.getClazz('MediaRecorderObserver')[0];

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
  final rtcChannel = await RtcChannel.create('testapi');
  {{TEST_CASE_BODY}}

  await rtcChannel.destroy();
  await rtcEngine.destroy();
  fakeIrisEngine.dispose();
});
    ''';

    for (final field in fields) {
      final fieldType = field.type.type;
      final paramsOfFieldType = genericTypeAliasParametersMap[fieldType]
          ?.map((e) => e.split(' ')[1])
          .toList();
      final paramsOfFieldTypeList = paramsOfFieldType?.join(',');

      final eventName = field.name;

      // if (_skipEvent.contains(eventName)) continue;

      final t = '''
bool ${field.name}Called = false;
MediaRecorder.getMediaRecorder(rtcEngine,
    callback: MediaRecorderObserver(
        ${field.name}: ($paramsOfFieldTypeList) {
          ${field.name}Called = true;
        },
    ));
  
fakeIrisEngine.fireRtcChannelEvent('$eventName');
// Wait for the `EventChannel` event be sent from Android/iOS side
await tester.pump(const Duration(milliseconds: 500));
expect(${field.name}Called, isTrue);
      ''';

      String testCase =
          testCaseTemplate.replaceAll('{{TEST_CASE_NAME}}', eventName);
      testCase = testCase.replaceAll('{{TEST_CASE_BODY}}', t);

      testCases.add(testCase);
    }

    const testCasesContentTemplate = '''
$defaultHeader

import 'package:agora_rtc_engine/rtc_channel.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test_app/main.dart' as app;
import 'package:integration_test_app/src/fake_iris_rtc_engine.dart';
import 'package:agora_rtc_engine/media_recorder.dart';

void mediaRecorderObserverSomkeTestCases() {
  {{TEST_CASES_CONTENT}}
}
''';

    final output = testCasesContentTemplate.replaceAll(
        '{{TEST_CASES_CONTENT}}', testCases.join("\n"));

    sink.writeln(DartFormatter().format(output));
  }

  @override
  IOSink? shouldGenerate(ParseResult parseResult) {
    // if (parseResult.classMap.containsKey('MediaRecorderObserver')) {
    //   return openSink(path.join(
    //       path.current,
    //       'integration_test_app',
    //       'integration_test',
    //       'media_recorder_observer_smoke_test.generated.dart'));
    // }

    return null;
  }
}
