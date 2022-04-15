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

class SimpleComment {
  List<String> commentLines = [];
  late int offset;
  late int end;
}

class BaseNode {
  late SimpleComment comment;
  late String source;
  late Uri uri;
}

class Method extends BaseNode {
  late String name;
  late FunctionBody body;
  List<Parameter> parameters = [];
  late Type returnType;
}

class Field extends BaseNode {
  late Type type;
  late String name;
}

class Constructor extends BaseNode {
  late String name;
  List<Parameter> parameters = [];
  late bool isFactory;
  late bool isConst;
}

class Clazz extends BaseNode {
  late String name;
  List<Constructor> constructors = [];
  List<Method> methods = [];
  List<Field> fields = [];
}

class Extensionz extends BaseNode {
  late String name;
  late String extendedType;
  List<Method> methods = [];
  List<Field> fields = [];
}

class EnumConstant extends BaseNode {
  late String name;
  List<SimpleAnnotation> annotations = [];
}

class Enumz extends BaseNode {
  late String name;
  List<EnumConstant> enumConstants = [];
}

class ParseResult {
  late List<Clazz> classes;
  late List<Enumz> enums;
  late List<Extensionz> extensions;

  // TODO(littlegnal): Optimize this later.
  // late Map<String, List<String>> classFieldsMap;
  // late Map<String, String> fieldsTypeMap;
  late Map<String, List<String>> genericTypeAliasParametersMap;
}

extension ParseResultExt on ParseResult {
  bool hasEnum(String type) {
    return enums.any((e) => e.name == type);
  }

  List<Enumz> getEnum(String type, {String? package}) {
    List<Enumz> foundEnums = [];
    for (final enumz in enums) {
      if (package == null) {
        if (enumz.name == type) {
          foundEnums.add(enumz);
        }
      } else {
        if (enumz.name == type &&
            enumz.uri.pathSegments.last.replaceAll('.dart', '') == package) {
          foundEnums.add(enumz);
        }
      }
    }

    return foundEnums;
  }

  bool hasClass(String type) {
    return classes.any((e) => e.name == type);
  }

  List<Clazz> getClazz(String type, {String? package}) {
    List<Clazz> foundClasses = [];
    for (final clazz in classes) {
      if (package == null) {
        if (clazz.name == type) {
          foundClasses.add(clazz);
        }
      } else {
        if (clazz.name == type &&
            clazz.uri.pathSegments.last.replaceAll('.dart', '') == package) {
          foundClasses.add(clazz);
        }
      }
    }

    return foundClasses;
  }

  bool hasExtension(String type) {
    return extensions.any((e) => e.name == type);
  }

  List<Extensionz> getExtension(String type, {String? package}) {
    List<Extensionz> foundExtensions = [];
    for (final extension in extensions) {
      if (package == null) {
        if (extension.name == type) {
          foundExtensions.add(extension);
        }
      } else {
        if (extension.name == type &&
            extension.uri.pathSegments.last.replaceAll('.dart', '') ==
                package) {
          foundExtensions.add(extension);
        }
      }
    }

    return foundExtensions;
  }
}

abstract class DefaultVisitor<R>
    extends dart_ast_visitor.RecursiveAstVisitor<R> {
  /// Called before visiting any node.
  void preVisit(Uri uri) {}

  /// Called after visiting nodes completed.
  void postVisit(Uri uri) {}
}

class DefaultVisitorImpl extends DefaultVisitor<Object?> {
  final classFieldsMap = <String, List<String>>{};
  final fieldsTypeMap = <String, String>{};
  final genericTypeAliasParametersMap = <String, List<String>>{};

  final classMap = <String, Clazz>{};
  final enumMap = <String, Enumz>{};
  final extensionMap = <String, Extensionz>{};

  Uri? _currentVisitUri;

  @override
  void preVisit(Uri uri) {
    _currentVisitUri = uri;
  }

  @override
  void postVisit(Uri uri) {
    _currentVisitUri = null;
  }

  @override
  Object? visitFieldDeclaration(dart_ast.FieldDeclaration node) {
    final clazz = _getClazz(node);
    if (clazz == null) return null;

    final dart_ast.TypeAnnotation? type = node.fields.type;
    if (type is dart_ast.NamedType) {
      final fieldName = node.fields.variables[0].name.name;

      Field field = Field()
        ..name = fieldName
        ..comment = _generateComment(node)
        ..source = node.toString()
        ..uri = _currentVisitUri!;

      Type t = Type()..type = type.name.name;
      field.type = t;

      clazz.fields.add(field);
    }

    return null;
  }

  @override
  Object? visitConstructorDeclaration(ConstructorDeclaration node) {
    final clazz = _getClazz(node);
    if (clazz == null) return null;

    Constructor constructor = Constructor()
      ..name = node.name?.name ?? ''
      ..parameters = _getParameter(node.parent, node.parameters)
      ..isFactory = node.factoryKeyword != null
      ..isConst = node.constKeyword != null
      ..comment = _generateComment(node)
      ..source = node.toSource();

    clazz.constructors.add(constructor);

    return null;
  }

  @override
  Object? visitEnumDeclaration(EnumDeclaration node) {
    final enumz = enumMap.putIfAbsent(node.name.name, () => Enumz());
    enumz.name = node.name.name;
    enumz.comment = _generateComment(node);
    enumz.uri = _currentVisitUri!;

    for (final constant in node.constants) {
      EnumConstant enumConstant = EnumConstant()
        ..name = '${node.name.name}.${constant.name.name}'
        ..comment = _generateComment(constant)
        ..source = constant.toSource();
      enumz.enumConstants.add(enumConstant);

      for (final meta in constant.metadata) {
        SimpleAnnotation simpleAnnotation = SimpleAnnotation()
          ..name = meta.name.name;
        enumConstant.annotations.add(simpleAnnotation);

        for (final a in meta.arguments?.arguments ?? []) {
          SimpleLiteral simpleLiteral = SimpleLiteral();
          simpleAnnotation.arguments.add(simpleLiteral);

          late String type;
          late String value;

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
          } else if (a is SimpleStringLiteral) {
            type = 'String';
            value = a.toSource();
          } else {
            stderr
                .writeln('Not handled enum annotation type: ${a.runtimeType}');
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
    if (_currentVisitUri == null ||
        classNode == null ||
        classNode is! dart_ast.ClassDeclaration) {
      return null;
    }

    Clazz clazz = classMap.putIfAbsent(
      '${_currentVisitUri.toString()}#${classNode.name.name}',
      () => Clazz()
        ..name = classNode.name.name
        ..comment = _generateComment(node as AnnotatedNode)
        ..uri = _currentVisitUri!,
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

  SimpleComment _generateComment(AnnotatedNode node) {
    SimpleComment simpleComment = SimpleComment()
      ..offset = node.documentationComment?.offset ?? 0
      ..end = node.documentationComment?.end ?? 0;

    for (final token in node.documentationComment?.tokens ?? []) {
      simpleComment.commentLines.add(token.stringValue ?? '');
    }
    return simpleComment;
  }

  @override
  Object? visitMethodDeclaration(MethodDeclaration node) {
    final clazz = _getClazz(node);
    if (clazz == null) return null;

    clazz.methods.add(_createMethod(node));

    return null;
  }

  Method _createMethod(MethodDeclaration node) {
    Method method = Method()
      ..name = node.name.name
      ..source = node.toString()
      ..uri = _currentVisitUri!;

    method.comment = _generateComment(node);

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

    return method;
  }

  @override
  Object? visitGenericTypeAlias(dart_ast.GenericTypeAlias node) {
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

    genericTypeAliasParametersMap[node.name.name] = parametersList;

    return null;
  }

  @override
  Object? visitExtensionDeclaration(dart_ast.ExtensionDeclaration node) {
    extensionMap.putIfAbsent(node.name?.name ?? '', () {
      Extensionz extensionz = Extensionz()
        ..name = node.name?.name ?? ''
        ..uri = _currentVisitUri!;
      if (node.extendedType is dart_ast.NamedType) {
        extensionz.extendedType =
            (node.extendedType as dart_ast.NamedType).name.name;
      }
      for (final member in node.members) {
        if (member is MethodDeclaration) {
          extensionz.methods.add(_createMethod(member));
        }
      }

      return extensionz;
    });

    return null;
  }
}

class Paraphrase {
  const Paraphrase({required this.includedPaths});

  final List<String> includedPaths;

  ParseResult visit() {
    final DefaultVisitorImpl rootBuilder = DefaultVisitorImpl();

    visitWith(visitor: rootBuilder);

    final parseResult = ParseResult()
      ..classes = rootBuilder.classMap.values.toList()
      ..enums = rootBuilder.enumMap.values.toList()
      ..extensions = rootBuilder.extensionMap.values.toList()
      ..genericTypeAliasParametersMap =
          rootBuilder.genericTypeAliasParametersMap;

    return parseResult;
  }

  void visitWith({required DefaultVisitor visitor}) {
    final AnalysisContextCollection collection = AnalysisContextCollection(
      includedPaths: includedPaths,
    );

    for (final AnalysisContext context in collection.contexts) {
      for (final String path in context.contextRoot.analyzedFiles()) {
        final AnalysisSession session = context.currentSession;
        final ParsedUnitResult result =
            session.getParsedUnit(path) as ParsedUnitResult;
        if (result.errors.isEmpty) {
          final dart_ast.CompilationUnit unit = result.unit;
          visitor.preVisit(result.uri);
          unit.accept(visitor);
          visitor.postVisit(result.uri);
        } else {
          for (final AnalysisError error in result.errors) {
            stderr.writeln(error.toString());
          }
        }
      }
    }
  }
}
