import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart'
    show AnalysisContextCollection;
import 'package:analyzer/dart/analysis/results.dart' show ParsedUnitResult;
import 'package:analyzer/dart/analysis/session.dart' show AnalysisSession;
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/ast.dart' as dart_ast;
import 'package:analyzer/dart/ast/visitor.dart' as dart_ast_visitor;
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/error/error.dart' show AnalysisError;
import 'package:file/file.dart' as file;
import 'package:file/local.dart';
import 'package:path/path.dart' as path;
import 'package:dart_style/dart_style.dart';

class CallApiInvoke {
  late String apiType;
  late String params;
}

class FunctionBody {
  late CallApiInvoke callApiInvoke;
}

class Parameter {
  late DartType? dartType;
  late String type;
  List<String> typeArguments = [];
  late String name;
  late bool isNamed;
  late bool isOptional;
  String? defaultValue;
}

extension ParameterExt on Parameter {
  bool get isPrimitiveType =>
      type == 'int' ||
      type == 'double' ||
      type == 'bool' ||
      type == 'String' ||
      type == 'List' ||
      type == 'Map' ||
      type == 'Set';

  String primitiveDefualtValue() {
    switch (type) {
      case 'int':
        return '10';
      case 'double':
        return '10.0';
      case 'String':
        return '"hello"';
      case 'bool':
        return 'true';
      case 'List':
        return '[]';
      case 'Map':
        return '{}';
      case 'Uint8List':
        return 'Uint8List.fromList([])';
      case 'Set':
        return '{}';
      default:
        throw Exception('not support type $type');
    }
  }
}

class Type {
  late String type;
  List<String> typeArguments = [];
}

extension TypeExt on Type {
  bool get isPrimitiveType =>
      type == 'int' ||
      type == 'double' ||
      type == 'bool' ||
      type == 'String' ||
      type == 'List' ||
      type == 'Map' ||
      type == 'Set';

  String primitiveDefualtValue() {
    switch (type) {
      case 'int':
        return '10';
      case 'double':
        return '10.0';
      case 'String':
        return '"hello"';
      case 'bool':
        return 'true';
      case 'List':
        return '[]';
      case 'Map':
        return '{}';
      case 'Uint8List':
        return 'Uint8List.fromList([])';
      case 'Set':
        return '{}';
      default:
        throw Exception('not support type $type');
    }
  }

  bool isVoid() {
    return type == 'void';
  }
}

class SimpleLiteral {
  late String type;
  late String value;
}

class SimpleAnnotation {
  late String name;
  List<SimpleLiteral> arguments = [];
}

class Method {
  late String name;
  late FunctionBody body;
  List<Parameter> parameters = [];
  late Type returnType;
}

class Field {
  late Type type;
  late String name;
}

class Constructor {
  late String name;
  List<Parameter> parameters = [];
  late bool isFactory;
}

class Clazz {
  late String name;
  List<Constructor> constructors = [];
  List<Method> methods = [];
  List<Field> fields = [];
}

class EnumConstant {
  late String name;
  List<SimpleAnnotation> annotations = [];
}

class Enumz {
  late String name;
  List<EnumConstant> enumConstants = [];
}

class ParseResult {
  late Map<String, Clazz> classMap;
  late Map<String, Enumz> enumMap;

  // TODO(littlegnal): Optimize this later.
  // late Map<String, List<String>> classFieldsMap;
  // late Map<String, String> fieldsTypeMap;
  late Map<String, List<String>> genericTypeAliasParametersMap;
}

class _RootBuilder extends dart_ast_visitor.RecursiveAstVisitor<Object?> {
  final classFieldsMap = <String, List<String>>{};
  final fieldsTypeMap = <String, String>{};
  final genericTypeAliasParametersMap = <String, List<String>>{};

  final classMap = <String, Clazz>{};
  final enumMap = <String, Enumz>{};

  @override
  Object? visitFieldDeclaration(dart_ast.FieldDeclaration node) {
    stdout.writeln(
        'variables: ${node.fields.variables}, type: ${node.fields.type}');

    final clazz = _getClazz(node);
    if (clazz == null) return null;

    final dart_ast.TypeAnnotation? type = node.fields.type;
    if (type is dart_ast.NamedType) {
      final fieldName = node.fields.variables[0].name.name;

      Field field = Field()..name = fieldName;

      // if (node.parent is dart_ast.ClassDeclaration) {
      //   final fieldList = classFieldsMap.putIfAbsent(
      //       (node.parent as dart_ast.ClassDeclaration).name.name,
      //       () => <String>[]);
      //   fieldList.add(fieldName);
      // }
      // fieldsTypeMap[fieldName] = type.name.name;

      Type t = Type()..type = type.name.name;
      field.type = t;

      clazz.fields.add(field);
    }

    return null;
  }

  @override
  Object? visitConstructorDeclaration(ConstructorDeclaration node) {
    stdout.writeln(
        'root visitConstructorDeclaration: node.name: ${node.name}, type: ${node.runtimeType} , ${node.initializers}, ${node.parent}');

    final clazz = _getClazz(node);
    if (clazz == null) return null;

    Constructor constructor = Constructor()
      ..name = node.name?.name ?? ''
      ..parameters = _getParameter(node.parent, node.parameters)
      ..isFactory = node.factoryKeyword != null;

    clazz.constructors.add(constructor);

    return null;
  }

  @override
  Object? visitEnumDeclaration(EnumDeclaration node) {
    stdout.writeln(
        'root visitEnumDeclaration: node.name: ${node.name}, type: ${node.runtimeType} constants: ${node.constants}, ${node.metadata}');
    for (final c in node.constants) {
      for (final m in c.metadata) {
        // stdout.writeln('m: ${m.arguments?.arguments}, ${m.name}');

        for (final a in m.arguments?.arguments ?? []) {
          stdout.writeln('a ${a.runtimeType}, ${a.toSource()}');
        }
      }
    }

    final enumz = enumMap.putIfAbsent(node.name.name, () => Enumz());
    enumz.name = node.name.name;

    for (final constant in node.constants) {
      EnumConstant enumConstant = EnumConstant()
        ..name = '${node.name.name}.${constant.name.name}';
      enumz.enumConstants.add(enumConstant);

      for (final meta in constant.metadata) {
        SimpleAnnotation simpleAnnotation = SimpleAnnotation()
          ..name = meta.name.name;
        enumConstant.annotations.add(simpleAnnotation);

        for (final a in meta.arguments?.arguments ?? []) {
          SimpleLiteral simpleLiteral = SimpleLiteral();
          simpleAnnotation.arguments.add(simpleLiteral);

          String type = '';
          String value = '';

          if (a is IntegerLiteral) {
            type = 'int';
            value = a.value.toString();
          } else if (a is PrefixExpression) {
            if (a.operand is IntegerLiteral) {
              final operand = a.operand as IntegerLiteral;
              type = 'int';
              value = '${a.operator.value()}${operand.value.toString()}';
            }
          } else if (a is BinaryExpression) {
            type = 'int';
            value = a.toSource();
          }
          simpleLiteral.type = type;
          simpleLiteral.value = value;
        }
      }
    }

    return null;
  }

  Clazz? _getClazz(AstNode node) {
    final classNode = node.parent;
    if (classNode == null || classNode is! dart_ast.ClassDeclaration) {
      return null;
    }

    Clazz clazz = classMap.putIfAbsent(
      classNode.name.name,
      () => Clazz()..name = classNode.name.name,
    );

    return clazz;
  }

  List<Parameter> _getParameter(
      AstNode? root, FormalParameterList? formalParameterList) {
    if (formalParameterList == null) return [];
    List<Parameter> parameters = [];
    for (final p in formalParameterList.parameters) {
      Parameter parameter = Parameter();

      if (p is SimpleFormalParameter) {
        parameter.name = p.identifier?.name ?? '';
        DartType? dartType = p.type?.type;

        parameter.dartType = dartType;

        final namedType = p.type as NamedType;
        for (final ta in namedType.typeArguments?.arguments ?? []) {
          parameter.typeArguments.add(ta.name.name);
        }

        parameter.type = namedType.name.name;
        parameter.isNamed = p.isNamed;
        parameter.isOptional = p.isOptional;
      } else if (p is DefaultFormalParameter) {
        parameter.name = p.identifier?.name ?? '';
        parameter.defaultValue = p.defaultValue?.toSource();

        DartType? dartType;
        String? type;
        List<String> typeArguments = [];

        if (p.parameter is SimpleFormalParameter) {
          final SimpleFormalParameter simpleFormalParameter =
              p.parameter as SimpleFormalParameter;
          dartType = simpleFormalParameter.type?.type;

          final namedType = simpleFormalParameter.type as NamedType;
          for (final ta in namedType.typeArguments?.arguments ?? []) {
            typeArguments.add(ta.name.name);
          }

          type = (simpleFormalParameter.type as NamedType).name.name;
        } else if (p.parameter is FieldFormalParameter) {
          final FieldFormalParameter fieldFormalParameter =
              p.parameter as FieldFormalParameter;

          dartType = fieldFormalParameter.type?.type;

          if (root != null && root is ClassDeclaration) {
            for (final classMember in root.members) {
              if (classMember is FieldDeclaration) {
                final dart_ast.TypeAnnotation? fieldType =
                    classMember.fields.type;
                if (fieldType is dart_ast.NamedType) {
                  final fieldName = classMember.fields.variables[0].name.name;
                  if (fieldName == fieldFormalParameter.identifier.name) {
                    type = fieldType.name.name;
                    for (final ta in fieldType.typeArguments?.arguments ?? []) {
                      typeArguments.add(ta.name.name);
                    }
                    break;
                  }
                }
              }
            }
          }
        }
        parameter.dartType = dartType;
        parameter.type = type!;
        parameter.typeArguments.addAll(typeArguments);
        parameter.isNamed = p.isNamed;
        parameter.isOptional = p.isOptional;
      } else if (p is FieldFormalParameter) {
        String type = '';
        List<String> typeArguments = [];
        if (root != null && root is ClassDeclaration) {
          for (final classMember in root.members) {
            if (classMember is FieldDeclaration) {
              final dart_ast.TypeAnnotation? fieldType =
                  classMember.fields.type;
              if (fieldType is dart_ast.NamedType) {
                final fieldName = classMember.fields.variables[0].name.name;
                if (fieldName == p.identifier.name) {
                  type = fieldType.name.name;
                  for (final ta in fieldType.typeArguments?.arguments ?? []) {
                    typeArguments.add(ta.name.name);
                  }
                  break;
                }
              }
            }
          }
        }

        parameter.name = p.identifier.name;
        parameter.dartType = p.type?.type;
        parameter.type = type;
        parameter.typeArguments.addAll(typeArguments);
        parameter.isNamed = p.isNamed;
        parameter.isOptional = p.isOptional;
      }

      parameters.add(parameter);
    }

    return parameters;
  }

  CallApiInvoke? _getCallApiInvoke(Expression expression) {
    if (expression is! MethodInvocation) return null;

    if (expression.target != null) {
      return _getCallApiInvoke(expression.target!);
    }

    CallApiInvoke callApiInvoke = CallApiInvoke();
    for (final argument in expression.argumentList.arguments) {
      if (argument is SimpleStringLiteral) {
      } else if (argument is FunctionExpression) {
      } else if (argument is SetOrMapLiteral) {
        for (final element in argument.elements) {
          if (element is MapLiteralEntry) {
            final key = (element.key as SimpleStringLiteral).value;
            if (key == 'apiType') {
              callApiInvoke.apiType = element.value.toSource();
            } else if (key == 'params') {
              callApiInvoke.params = element.value.toSource();
            }
          }
        }
      }
    }

    return callApiInvoke;
  }

  @override
  Object? visitMethodDeclaration(MethodDeclaration node) {
    final classNode = node.parent;
    if (classNode == null || classNode is! dart_ast.ClassDeclaration) {
      return null;
    }

    Clazz clazz = classMap.putIfAbsent(
      classNode.name.name,
      () => Clazz()..name = classNode.name.name,
    );

    Method method = Method()..name = node.name.name;
    clazz.methods.add(method);

    if (node.parameters != null) {
      method.parameters.addAll(_getParameter(node.parent, node.parameters));
    }

    if (node.returnType != null && node.returnType is NamedType) {
      final returnType = node.returnType as NamedType;
      method.returnType = Type()
        ..type = returnType.name.name
        ..typeArguments = returnType.typeArguments?.arguments
                .map((ta) => (ta as NamedType).name.name)
                .toList() ??
            [];
    }

    if (node.body is BlockFunctionBody) {
      final body = node.body as BlockFunctionBody;

      FunctionBody fb = FunctionBody();
      method.body = fb;
      CallApiInvoke callApiInvoke = CallApiInvoke();
      method.body.callApiInvoke = callApiInvoke;

      for (final statement in body.block.statements) {
        if (statement is ReturnStatement) {
          final returns = statement;

          if (returns.expression != null) {
            CallApiInvoke? callApiInvoke =
                _getCallApiInvoke(returns.expression!);
            if (callApiInvoke != null) {
              method.body.callApiInvoke = callApiInvoke;
            }
          }
        }
      }
    }
    return null;
  }

  @override
  Object? visitGenericTypeAlias(dart_ast.GenericTypeAlias node) {
    stdout.writeln(
        'root visitGenericTypeAlias: node.name: ${node.name}, node.functionType?.parameters: ${node.functionType?.parameters.parameters}');

    final parametersList = node.functionType?.parameters.parameters
            .map((e) {
              if (e is SimpleFormalParameter) {
                return '${e.type} ${e.identifier?.name}';
              }
              return '';
            })
            .where((e) => e.isNotEmpty)
            .toList() ??
        [];

    stdout.writeln(parametersList);

    genericTypeAliasParametersMap[node.name.name] = parametersList;

    return null;
  }
}

enum GeneratorConfigPlatform {
  android,
  iOS,
  macOS,
  windows,
  linux,
}

extension GeneratorConfigPlatformExt on GeneratorConfigPlatform {
  String toPlatformExpression() {
    switch (this) {
      case GeneratorConfigPlatform.android:
        return 'Platform.isAndroid';
      case GeneratorConfigPlatform.iOS:
        return 'Platform.isIOS';
      case GeneratorConfigPlatform.macOS:
        return 'Platform.isMacOS';
      case GeneratorConfigPlatform.windows:
        return 'Platform.isWindows';
      case GeneratorConfigPlatform.linux:
        return 'Platform.isLinux';
    }
  }
}

class GeneratorConfig {
  const GeneratorConfig({
    required this.name,
    this.donotGenerate = false,
    this.supportedPlatforms = const [
      GeneratorConfigPlatform.android,
      GeneratorConfigPlatform.iOS,
      GeneratorConfigPlatform.macOS,
      GeneratorConfigPlatform.windows,
      GeneratorConfigPlatform.linux,
    ],
    this.shouldMockResult = false,
    this.shouldMockReturnCode = false,
  });
  final String name;
  final bool donotGenerate;
  final List<GeneratorConfigPlatform> supportedPlatforms;
  final bool shouldMockReturnCode;
  final bool shouldMockResult;
}

const List<GeneratorConfigPlatform> desktopPlatforms = [
  GeneratorConfigPlatform.macOS,
  GeneratorConfigPlatform.windows,
  GeneratorConfigPlatform.linux,
];

const List<GeneratorConfigPlatform> mobilePlatforms = [
  GeneratorConfigPlatform.android,
  GeneratorConfigPlatform.iOS,
];

IOSink? _openSink(String? output) {
  if (output == null) {
    return null;
  }
  IOSink sink;
  File file;
  if (output == 'stdout') {
    sink = stdout;
  } else {
    file = File(output);
    sink = file.openWrite();
  }
  return sink;
}

abstract class Generator {
  void generate(StringSink sink, ParseResult parseResult);

  IOSink? shouldGenerate(ParseResult parseResult);
}

abstract class DefaultGenerator implements Generator {
  const DefaultGenerator();

  GeneratorConfig? _getConfig(
      List<GeneratorConfig> configs, String methodName) {
    for (final config in configs) {
      if (config.name == methodName) {
        return config;
      }
    }
    return null;
  }

  String _concatParamName(String? prefix, String name) {
    if (prefix == null) return name;
    return '$prefix${name[0].toUpperCase()}${name.substring(1)}';
  }

  String _getParamType(Parameter parameter) {
    if (parameter.typeArguments.isEmpty) {
      return parameter.type;
    }

    return '${parameter.type}<${parameter.typeArguments.join(', ')}>';
  }

  void _createConstructorInitializerForMethodParameter(
    ParseResult parseResult,
    Parameter? rootParameter,
    Parameter parameter,
    StringBuffer initializerBuilder,
  ) {
    final bool isEnum = parseResult.enumMap.containsKey(parameter.type);

    if (isEnum) {
      final enumz = parseResult.enumMap[parameter.type]!;

      initializerBuilder.writeln(
          'const ${_getParamType(parameter)} ${_concatParamName(rootParameter?.name, parameter.name)} = ${enumz.enumConstants[0].name};');

      return;
    }

    final parameterClass = parseResult.classMap[parameter.type]!;
    final initBlockParameterListBuilder = StringBuffer();
    final initBlockBuilder = StringBuffer();
    initBlockBuilder.write(parameterClass.name);
    initBlockBuilder.write('(');

    for (final cp in parameterClass.constructors[0].parameters) {
      final adjustedParamName = _concatParamName(parameter.name, cp.name);
      if (cp.isNamed) {
        if (cp.isPrimitiveType) {
          initBlockParameterListBuilder.writeln(
              'const ${_getParamType(cp)} $adjustedParamName = ${cp.primitiveDefualtValue()};');
          initBlockBuilder.write('${cp.name}: $adjustedParamName,');
        } else {
          _createConstructorInitializerForMethodParameter(
              parseResult, parameter, cp, initializerBuilder);
          initBlockBuilder.write('${cp.name}: $adjustedParamName,');
        }
      } else {
        if (cp.isPrimitiveType) {
          initBlockParameterListBuilder.writeln(
              'const ${_getParamType(cp)} $adjustedParamName = ${cp.primitiveDefualtValue()};');
          initBlockBuilder.write('$adjustedParamName,');
        } else {
          _createConstructorInitializerForMethodParameter(
              parseResult, parameter, cp, initializerBuilder);
          initBlockBuilder.write('$adjustedParamName,');
        }
      }
    }

    initBlockBuilder.write(')');

    initializerBuilder.write(initBlockParameterListBuilder.toString());
    initializerBuilder.writeln(
        'final ${_getParamType(parameter)} ${_concatParamName(rootParameter?.name, parameter.name)} = ${initBlockBuilder.toString()};');
  }

  String generateWithTemplate({
    required ParseResult parseResult,
    required Clazz clazz,
    required String testCaseTemplate,
    required String testCasesContentTemplate,
    required String methodInvokeObjectName,
    required List<GeneratorConfig> configs,
    List<GeneratorConfigPlatform>? supportedPlatformsOverride,
  }) {
//     const testWidgetTemplate = '''
// testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
//     app.main();
//     await tester.pumpAndSettle();

//     String engineAppId = const String.fromEnvironment('TEST_APP_ID',
//       defaultValue: '<YOUR_APP_ID>');

//     RtcEngine rtcEngine = await RtcEngine.create(engineAppId);

//     final screenShareHelper = await rtcEngine.getScreenShareHelper();

//     {{TEST_CASE_BODY}}

//     await screenShareHelper.destroy();
//     await rtcEngine.destroy();
//   },
//   skip: {{TEST_CASE_SKIP}},
// );
// ''';

    final testCases = <String>[];
    for (final method in clazz.methods) {
      final methodName = method.name;

      final config = _getConfig(configs, methodName);
      if (config?.donotGenerate == true) continue;
      if (methodName.startsWith('_')) continue;
      if (methodName.startsWith('create')) continue;

      StringBuffer pb = StringBuffer();

//       if (!method.returnType.isVoid()) {
// //         final mockCallApiResultBlock = '''
// // fakeIrisEngine.mockCallApiResult(
// //   ${method.body.callApiInvoke.apiType},
// //   ${method.body.callApiInvoke.params},
// //   '1',
// // );
// // ''';

//         // stdout.writeln(
//         //     'method.returnType: ${method.returnType.typeArguments[0]}');
//         final typeArgument = method.returnType.typeArguments[0];
//         if (parseResult.enumMap.containsKey(typeArgument)) {
//           final enumz = parseResult.enumMap[typeArgument]!;
//           final jsonValue =
//               enumz.enumConstants[0].annotations[0].arguments[0].value;
//           final mockCallApiReturnCodeBlock = '''
// fakeIrisEngine.mockCallApiReturnCode(
//   ${method.body.callApiInvoke.apiType},
//   ${method.body.callApiInvoke.params},
//   $jsonValue,
// );
// ''';

//           pb.writeln(mockCallApiReturnCodeBlock);
//         }
//       }

      for (final parameter in method.parameters) {
        if (parameter.isPrimitiveType) {
          pb.writeln(
              'const ${_getParamType(parameter)} ${parameter.name} = ${parameter.primitiveDefualtValue()};');
        } else {
          _createConstructorInitializerForMethodParameter(
              parseResult, null, parameter, pb);
        }
      }

      StringBuffer methodCallBuilder = StringBuffer();
      // methodCallBuilder.write('await screenShareHelper.$methodName(');
      methodCallBuilder.write('await $methodInvokeObjectName.$methodName(');
      for (final parameter in method.parameters) {
        if (parameter.isNamed) {
          methodCallBuilder.write('${parameter.name}:${parameter.name},');
        } else {
          methodCallBuilder.write('${parameter.name}, ');
        }
      }
      methodCallBuilder.write(');');

      pb.writeln(methodCallBuilder.toString());

//       final expectBlock = '''
// fakeIrisEngine.expectCalledApi(
//   ${method.body.callApiInvoke.apiType},
//   ${method.body.callApiInvoke.params},
// );
// ''';
//       pb.writeln(expectBlock);

      String skipExpression = 'false';

      if (supportedPlatformsOverride != null) {
        // skipExpression =
        //     '!(${desktopPlatforms.map((e) => e.toPlatformExpression()).join(' || ')})';
        skipExpression =
            '!(${supportedPlatformsOverride.map((e) => e.toPlatformExpression()).join(' || ')})';
      } else {
        if (config != null &&
            config.supportedPlatforms.length <
                GeneratorConfigPlatform.values.length) {
          skipExpression =
              '!(${config.supportedPlatforms.map((e) => e.toPlatformExpression()).join(' || ')})';
        }
      }

      String testCase =
          testCaseTemplate.replaceAll('{{TEST_CASE_NAME}}', methodName);
      testCase = testCase.replaceAll('{{TEST_CASE_BODY}}', pb.toString());
      testCase = testCase.replaceAll('{{TEST_CASE_SKIP}}', skipExpression);
      testCases.add(testCase);
    }

//     final output = '''
// import 'dart:io';

// import 'package:agora_rtc_engine/rtc_engine.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test_app/main.dart' as app;

// void rtcEngineSubProcessSmokeTestCases() {
//   ${testCases.join('\n')}
//   {{TEST_CASES_CONTENT}}
// }
// ''';

    final output = testCasesContentTemplate.replaceAll(
      '{{TEST_CASES_CONTENT}}',
      testCases.join('\n'),
    );

    return DartFormatter().format(output);
  }
}

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
  };

  @override
  void generate(StringSink sink, ParseResult parseResult) {
    final clazz = parseResult.classMap['RtcEngineEventHandler'];
    stdout.writeln('clazz: $clazz');
    if (clazz == null) return;

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
  fakeIrisEngine.dispose();
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
    if (parseResult.classMap.containsKey('RtcEngineEventHandler')) {
      return _openSink(path.join(
          fileSystem.currentDirectory.absolute.path,
          'integration_test_app',
          'integration_test',
          'agora_rtc_engine_event_handler_smoke_test.generated.dart'));
    }

    return null;
  }
}

class RtcChannelEventHandlerSomkeTestGenerator implements Generator {
  const RtcChannelEventHandlerSomkeTestGenerator();

  static const Map<String, String> _functionNameToEventNameMap = {
    'warning': 'ChannelWarning',
    'error': 'ChannelError',
  };

  // TODO(littlegnal): Re-implement later
  static const List<String> _skipEvent = ['onMetadataReceived'];

  @override
  void generate(StringSink sink, ParseResult parseResult) {
    final clazz = parseResult.classMap['RtcChannelEventHandler'];

    if (clazz == null) return;

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

      final baseEventName =
          _functionNameToEventNameMap[field.name] ?? field.name;
      final eventName =
          'on${baseEventName.substring(0, 1).toUpperCase()}${baseEventName.substring(1)}';

      if (_skipEvent.contains(eventName)) continue;

      final t = '''
bool ${field.name}Called = false;
rtcChannel.setEventHandler(RtcChannelEventHandler(
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
import 'package:agora_rtc_engine/rtc_channel.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test_app/main.dart' as app;
import 'package:integration_test_app/src/fake_iris_rtc_engine.dart';

void rtcChannelEventHandlerSomkeTestCases() {
  {{TEST_CASES_CONTENT}}
}
''';

    final output = testCasesContentTemplate.replaceAll(
        '{{TEST_CASES_CONTENT}}', testCases.join("\n"));

    sink.writeln(DartFormatter().format(output));
  }

  @override
  IOSink? shouldGenerate(ParseResult parseResult) {
    if (parseResult.classMap.containsKey('RtcChannelEventHandler')) {
      return _openSink(path.join(
          fileSystem.currentDirectory.absolute.path,
          'integration_test_app',
          'integration_test',
          'agora_rtc_channel_event_handler_smoke_test.generated.dart'));
    }

    return null;
  }
}

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
    GeneratorConfig(name: 'setLiveTranscoding', donotGenerate: true),
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
    final clazz = parseResult.classMap['RtcEngine'];
    if (clazz == null) return;

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
    if (parseResult.classMap.containsKey('RtcEngine')) {
      return _openSink(path.join(
          fileSystem.currentDirectory.absolute.path,
          'integration_test_app',
          'integration_test',
          'agora_rtc_engine_subprocess_api_smoke_test.generated.dart'));
    }

    return null;
  }
}

class RtcDeviceManagerSmokeTestGenerator extends DefaultGenerator {
  const RtcDeviceManagerSmokeTestGenerator();

  static const List<GeneratorConfig> configs = [
    GeneratorConfig(name: 'getVideoDevice', donotGenerate: true),
  ];

  @override
  void generate(StringSink sink, ParseResult parseResult) {
    final clazz = parseResult.classMap['RtcDeviceManager'];
    if (clazz == null) return;

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
    if (parseResult.classMap.containsKey('RtcDeviceManager')) {
      return _openSink(path.join(
          fileSystem.currentDirectory.absolute.path,
          'integration_test_app',
          'integration_test',
          'agora_rtc_device_manager_api_smoke_test.generated.dart'));
    }

    return null;
  }
}

final List<Generator> generators = [
  const RtcEngineSubProcessSmokeTestGenerator(),
  const RtcEngineEventHandlerSomkeTestGenerator(),
  const RtcDeviceManagerSmokeTestGenerator(),
  const RtcChannelEventHandlerSomkeTestGenerator(),
];

const file.FileSystem fileSystem = LocalFileSystem();

void main(List<String> args) {
  final srcDir = path.join(
    fileSystem.currentDirectory.absolute.path,
    'lib',
    'src',
  );
  final List<String> includedPaths = <String>[
    path.join(srcDir, 'rtc_engine.dart'),
    path.join(srcDir, 'enums.dart'),
    path.join(srcDir, 'classes.dart'),
    path.join(srcDir, 'rtc_device_manager.dart'),
    path.join(srcDir, 'rtc_channel_event_handler.dart'),
    path.join(srcDir, 'rtc_engine_event_handler.dart'),
    path.join(srcDir, 'event_types.dart'),
  ];
  final AnalysisContextCollection collection = AnalysisContextCollection(
    includedPaths: includedPaths,
  );
  final _RootBuilder rootBuilder = _RootBuilder();

  for (final AnalysisContext context in collection.contexts) {
    for (final String path in context.contextRoot.analyzedFiles()) {
      final AnalysisSession session = context.currentSession;
      final ParsedUnitResult result =
          session.getParsedUnit(path) as ParsedUnitResult;
      if (result.errors.isEmpty) {
        final dart_ast.CompilationUnit unit = result.unit;
        unit.accept(rootBuilder);
      } else {
        for (final AnalysisError error in result.errors) {
          stderr.writeln(error.toString());
        }
      }
    }
  }

  final parseResult = ParseResult()
    ..classMap = rootBuilder.classMap
    ..enumMap = rootBuilder.enumMap
    // ..classFieldsMap = rootBuilder.classFieldsMap
    // ..fieldsTypeMap = rootBuilder.fieldsTypeMap
    ..genericTypeAliasParametersMap = rootBuilder.genericTypeAliasParametersMap;

  for (final generator in generators) {
    final sink = generator.shouldGenerate(parseResult);
    if (sink != null) {
      generator.generate(sink, parseResult);
      sink.flush();
    }
  }
}
