import 'package:dart_style/dart_style.dart';
import 'package:paraphrase/paraphrase.dart';
import 'dart:io';

import 'package:testcase_gen/default_generator.dart';
import 'package:path/path.dart' as path;

import 'generator.dart';

abstract class TemplatedTestCase {
  TemplatedTestCase({
    required this.className,
    required this.testCaseFileTemplate,
    required this.testCaseTemplate,
    required this.outputDir,
    this.outputFileSuffixName = 'testcases',
  });

  final String className;
  final String testCaseFileTemplate;
  final String testCaseTemplate;
  final String outputDir;
  final String outputFileSuffixName;
}

class MethoCallTemplatedTestCase extends TemplatedTestCase {
  MethoCallTemplatedTestCase({
    required String className,
    required String testCaseFileTemplate,
    required String testCaseTemplate,
    required String outputDir,
    required this.methodInvokeObjectName,
    this.skipMemberFunctions = const [],
    required String outputFileSuffixName,
  }) : super(
          className: className,
          testCaseFileTemplate: testCaseFileTemplate,
          testCaseTemplate: testCaseTemplate,
          outputDir: outputDir,
          outputFileSuffixName: outputFileSuffixName,
        );

  final String methodInvokeObjectName;
  final List<String> skipMemberFunctions;
}

class EventHandlerTemplatedTestCase extends TemplatedTestCase {
  EventHandlerTemplatedTestCase({
    required this.callerObjClassName,
    required String className,
    required String testCaseFileTemplate,
    required String testCaseTemplate,
    required String outputDir,
    required this.callerObjName,
    this.eventPrefixOverride,
    required this.registerFunctionName,
    required this.unregisterFunctionName,
    this.isUpperFirstCaseOfEventName = false,
  }) : super(
          className: className,
          testCaseFileTemplate: testCaseFileTemplate,
          testCaseTemplate: testCaseTemplate,
          outputDir: outputDir,
        );

  final String callerObjClassName;
  final String callerObjName;
  final String? eventPrefixOverride;
  final String registerFunctionName;
  final String unregisterFunctionName;
  final bool isUpperFirstCaseOfEventName;
}

class TemplatedGenerator extends DefaultGenerator {
  const TemplatedGenerator(this.templatedTestCases);

  final List<TemplatedTestCase> templatedTestCases;

  @override
  void generate(StringSink sink, ParseResult parseResult) {
    for (final templated in templatedTestCases) {
      String output = '';
      String outputFileName = '';
      if (templated is MethoCallTemplatedTestCase) {
        output = generateWithTemplate(
          parseResult: parseResult,
          clazz: parseResult.getClazz(templated.className)[0],
          testCaseTemplate: templated.testCaseTemplate,
          testCasesContentTemplate: templated.testCaseFileTemplate,
          methodInvokeObjectName: templated.methodInvokeObjectName,
          configs: const [],
          supportedPlatformsOverride: const [],
          skipMemberFunctions: templated.skipMemberFunctions,
        );
        outputFileName =
            '${templated.className.toLowerCase()}_${templated.outputFileSuffixName}.generated.dart';
      } else if (templated is EventHandlerTemplatedTestCase) {
        output = _generateEventHandlerCasesWithTemplate(
          parseResult: parseResult,
          callerObjClazz: parseResult.getClazz(templated.callerObjClassName)[0],
          eventHandlerClazz: parseResult.getClazz(templated.className)[0],
          testCaseTemplate: templated.testCaseFileTemplate,
          testCasesContentTemplate: templated.testCaseTemplate,
          callerObjName: templated.callerObjName,
          eventPrefixOverride: templated.eventPrefixOverride,
          registerFunctionName: templated.registerFunctionName,
          unregisterFunctionName: templated.unregisterFunctionName,
          isUpperFirstCaseOfEventName: templated.isUpperFirstCaseOfEventName,
        );
        outputFileName =
            '${templated.callerObjClassName.toLowerCase()}_${templated.className.toLowerCase()}_${templated.outputFileSuffixName}.generated.dart';
      }

      final fileSink = openSink(path.join(
        templated.outputDir,
        outputFileName,
      ));
      fileSink!.writeln(output);
      fileSink.flush();
    }
  }

  @override
  IOSink? shouldGenerate(ParseResult parseResult) {
    return null;
  }

  String _generateEventHandlerCasesWithTemplate({
    required ParseResult parseResult,
    required Clazz callerObjClazz,
    required Clazz eventHandlerClazz,
    required String testCaseTemplate,
    required String testCasesContentTemplate,
    String? eventPrefixOverride,
    required String callerObjName,
    required String registerFunctionName,
    required String unregisterFunctionName,
    required bool isUpperFirstCaseOfEventName,
  }) {
    // final fields = clazz.fields;
    final eventHandlerName = 'the${eventHandlerClazz.name}';

    final testCases = <String>[];

    final registerFunctionImpl = _getMethodCallImpl(
      parseResult: parseResult,
      callerObjClazz: callerObjClazz,
      eventHandlerClazz: eventHandlerClazz,
      callerObjName: callerObjName,
      functionName: registerFunctionName,
      eventHandlerName: eventHandlerName,
    );
    final unregisterFunctionImpl = _getMethodCallImpl(
      parseResult: parseResult,
      callerObjClazz: callerObjClazz,
      eventHandlerClazz: eventHandlerClazz,
      callerObjName: callerObjName,
      functionName: unregisterFunctionName,
      eventHandlerName: eventHandlerName,
    );

    for (final field in eventHandlerClazz.fields) {
      StringBuffer bodyBuffer = StringBuffer();

      final functionParamsList = field.type.parameters
          .map((t) => '${t.type.type} ${t.name}')
          .join(', ');

      String eventName = field.name;

      StringBuffer jsonBuffer = StringBuffer();
      StringBuffer pb = StringBuffer();
      _createParameterInitializedList(
          parseResult, pb, field.type.parameters, []);

      jsonBuffer.writeln('final eventJson = {');
      for (final parameter in field.type.parameters) {
        if (parameter.isPrimitiveType) {
          final parameterType = getParamType(parameter);

          if (parameterType == 'Uint8List') {
            jsonBuffer
                .writeln('\'${parameter.name}\': ${parameter.name}.toList(),');
          } else {
            jsonBuffer.writeln('\'${parameter.name}\': ${parameter.name},');
          }
        } else {
          final bool isEnum = parseResult.hasEnum(parameter.type.type);
          if (isEnum) {
            jsonBuffer
                .writeln('\'${parameter.name}\': ${parameter.name}.value(),');
          } else {
            final parameterClass = parseResult.getClazz(parameter.type.type)[0];
            if (parameterClass.constructors.isEmpty) {
              continue;
            }
            jsonBuffer
                .writeln('\'${parameter.name}\': ${parameter.name}.toJson(),');
          }
        }
      }
      jsonBuffer.writeln('};');

      StringBuffer fireEventImplBuffer = StringBuffer();

      String fireEventSuffix = eventName;
      if (isUpperFirstCaseOfEventName) {
        fireEventSuffix =
            '${fireEventSuffix[0].toUpperCase()}${fireEventSuffix.substring(1)}';
      }
      fireEventImplBuffer.writeln('{');
      fireEventImplBuffer.writeln(pb.toString());
      fireEventImplBuffer.writeln(jsonBuffer.toString());
      fireEventImplBuffer.writeln(
          'irisTester.fireEvent(\'${eventHandlerClazz.name}_$fireEventSuffix\', params: eventJson);');
      if (eventPrefixOverride != null) {
        fireEventImplBuffer.writeln(
            'irisTester.fireEvent(\'${eventPrefixOverride}_$fireEventSuffix\', params: eventJson);');
      }

      fireEventImplBuffer.writeln('}');

      final eventCompleterName = '${field.name}Completer';
      bodyBuffer.writeln('''
final $eventCompleterName = Completer<bool>();
final $eventHandlerName = ${eventHandlerClazz.name}(
  $eventName: ($functionParamsList) {
    $eventCompleterName.complete(true);
  },
);

$registerFunctionImpl

// Delay 500 milliseconds to ensure the $registerFunctionName call completed.
await Future.delayed(const Duration(milliseconds: 500));

${fireEventImplBuffer.toString()}

final eventCalled = await $eventCompleterName.future;
expect(eventCalled, isTrue);

{
  $unregisterFunctionImpl
}
// Delay 500 milliseconds to ensure the $unregisterFunctionName call completed.
await Future.delayed(const Duration(milliseconds: 500));
''');

      String testCase =
          testCasesContentTemplate.replaceAll('{{TEST_CASE_NAME}}', eventName);
      testCase =
          testCase.replaceAll('{{TEST_CASE_BODY}}', bodyBuffer.toString());

      testCases.add(testCase);
    }

    final output = testCaseTemplate.replaceAll(
      '{{TEST_CASES_CONTENT}}',
      testCases.join('\n'),
    );

    return DartFormatter().format(output);
  }

  String _getMethodCallImpl({
    required ParseResult parseResult,
    required Clazz callerObjClazz,
    required Clazz eventHandlerClazz,
    required String callerObjName,
    required String functionName,
    required String eventHandlerName,
  }) {
    StringBuffer methodCallBuilder = StringBuffer();

    for (final method in callerObjClazz.methods) {
      final methodName = method.name;

      if (functionName == methodName) {
        StringBuffer pb = StringBuffer();


        _createParameterInitializedList(
            parseResult, pb, method.parameters, [eventHandlerClazz.name]);

        methodCallBuilder.writeln(pb.toString());
        bool isFuture = method.returnType.type == 'Future';
        methodCallBuilder
            .write('${isFuture ? 'await ' : ''}$callerObjName.$methodName(');
        for (final parameter in method.parameters) {
          final pn = parameter.type.type == eventHandlerClazz.name
              ? eventHandlerName
              : parameter.name;
          if (parameter.isNamed) {
            methodCallBuilder.write('${parameter.name}:$pn,');
          } else {
            methodCallBuilder.write('$pn, ');
          }
        }
        methodCallBuilder.write(');');

        break;
      }
    }

    return methodCallBuilder.toString();
  }

  String _createParameterInitializedList(
    ParseResult parseResult,
    StringBuffer pb,
    List<Parameter> parameters,
    List<String> skipTypes,
  ) {
    for (final parameter in parameters) {
      if (parameter.type.type == 'Function') {
        continue;
      }
      if (skipTypes.contains(parameter.type.type)) {
        continue;
      }

      if (parameter.isPrimitiveType) {
        final parameterType = getParamType(parameter);
        if (parameterType == 'Uint8List') {
          pb.writeln(
              '${getParamType(parameter)} ${parameter.name} = ${parameter.primitiveDefualtValue()};');
        } else {
          pb.writeln(
              'const ${getParamType(parameter)} ${parameter.name} = ${parameter.primitiveDefualtValue()};');
        }
      } else {
        createConstructorInitializerForMethodParameter(
            parseResult, null, parameter, pb);
      }
    }

    return pb.toString();
  }
}
