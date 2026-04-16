import 'dart:io';

import 'package:testcase_gen/core/paraphrase.dart';
import 'package:testcase_gen/default_generator.dart';

class _TestGenerator extends DefaultGenerator {
  const _TestGenerator();

  @override
  void generate(StringSink sink, ParseResult parseResult) {}

  @override
  IOSink? shouldGenerate(ParseResult parseResult) => null;
}

SimpleComment _comment() => SimpleComment()
  ..commentLines = []
  ..offset = 0
  ..end = 0;

Type _type(String name, [List<String> typeArguments = const []]) => Type()
  ..type = name
  ..typeArguments = List<String>.from(typeArguments);

Parameter _parameter({
  required String name,
  required String type,
  bool isNamed = false,
  bool isOptional = false,
  List<String> typeArguments = const [],
}) {
  return Parameter()
    ..name = name
    ..type = _type(type, typeArguments)
    ..dartType = null
    ..isNamed = isNamed
    ..isOptional = isOptional;
}

Constructor _constructor({
  String name = '',
  List<Parameter> parameters = const [],
}) {
  return Constructor()
    ..name = name
    ..parameters = List<Parameter>.from(parameters)
    ..isFactory = false
    ..isConst = false
    ..comment = _comment()
    ..source = '';
}

Method _method({
  required String name,
  required List<Parameter> parameters,
}) {
  final functionBody = FunctionBody()..callApiInvoke = CallApiInvoke();
  return Method()
    ..name = name
    ..parameters = List<Parameter>.from(parameters)
    ..returnType = _type('Future')
    ..body = functionBody
    ..comment = _comment()
    ..source = ''
    ..uri = Uri.parse('memory://generated.dart');
}

Clazz _clazz({
  required String name,
  List<Constructor> constructors = const [],
  List<Method> methods = const [],
}) {
  return Clazz()
    ..name = name
    ..constructors = List<Constructor>.from(constructors)
    ..methods = List<Method>.from(methods)
    ..fields = []
    ..comment = _comment()
    ..source = ''
    ..uri = Uri.parse('memory://generated.dart');
}

ParseResult _parseResult(List<Clazz> classes) {
  return ParseResult()
    ..classes = classes
    ..enums = []
    ..extensions = []
    ..genericTypeAliasParametersMap = {};
}

void _expect(bool condition, String message) {
  if (!condition) {
    throw StateError(message);
  }
}

void main() {
  const generator = _TestGenerator();
  const testCaseTemplate = '''
// {{TEST_CASE_NAME}}
{
{{TEST_CASE_BODY}}
}
''';
  const fileTemplate = '''
Future<void> generatedCases(dynamic rtcEngine) async {
{{TEST_CASES_CONTENT}}
}
''';

  final directOpaqueParseResult = _parseResult([
    _clazz(
      name: 'RtcEngine',
      methods: [
        _method(
          name: 'destroyVideoEffectObject',
          parameters: [
            _parameter(
              name: 'videoEffectObject',
              type: 'VideoEffectObject',
            ),
          ],
        ),
        _method(
          name: 'setBeautyOptions',
          parameters: [
            _parameter(name: 'options', type: 'BeautyOptions'),
          ],
        ),
      ],
    ),
    _clazz(name: 'VideoEffectObject'),
    _clazz(
      name: 'BeautyOptions',
      constructors: [
        _constructor(
          parameters: [
            _parameter(
              name: 'lighteningLevel',
              type: 'double',
              isNamed: true,
            ),
          ],
        ),
      ],
    ),
  ]);

  final directOpaqueOutput = generator.generateWithTemplate(
    parseResult: directOpaqueParseResult,
    clazz: directOpaqueParseResult.getClazz('RtcEngine')[0],
    testCaseTemplate: testCaseTemplate,
    testCasesContentTemplate: fileTemplate,
    methodInvokeObjectName: 'rtcEngine',
    configs: const [],
  );

  _expect(
    !directOpaqueOutput.contains('RtcEngine.destroyVideoEffectObject'),
    'Expected opaque handle methods to be skipped from generated output.',
  );
  _expect(
    directOpaqueOutput.contains('RtcEngine.setBeautyOptions'),
    'Expected constructible object parameters to remain in generated output.',
  );

  final nestedOpaqueParseResult = _parseResult([
    _clazz(
      name: 'RtcEngine',
      methods: [
        _method(
          name: 'configureWrapper',
          parameters: [
            _parameter(name: 'wrapper', type: 'EffectWrapper'),
          ],
        ),
      ],
    ),
    _clazz(
      name: 'EffectWrapper',
      constructors: [
        _constructor(
          parameters: [
            _parameter(
              name: 'videoEffectObject',
              type: 'VideoEffectObject',
              isNamed: true,
            ),
          ],
        ),
      ],
    ),
    _clazz(name: 'VideoEffectObject'),
  ]);

  final nestedOpaqueOutput = generator.generateWithTemplate(
    parseResult: nestedOpaqueParseResult,
    clazz: nestedOpaqueParseResult.getClazz('RtcEngine')[0],
    testCaseTemplate: testCaseTemplate,
    testCasesContentTemplate: fileTemplate,
    methodInvokeObjectName: 'rtcEngine',
    configs: const [],
  );

  _expect(
    !nestedOpaqueOutput.contains('RtcEngine.configureWrapper'),
    'Expected methods with nested opaque constructor parameters to be skipped.',
  );
}
