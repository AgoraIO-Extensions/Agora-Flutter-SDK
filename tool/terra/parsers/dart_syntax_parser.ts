import {
  CXXFile,
  CXXTYPE,
  CXXTerraNode,
  Clazz,
  Enumz,
  SimpleType,
  SimpleTypeKind,
  TypeAlias,
} from "@agoraio-extensions/cxx-parser";
import { ParseResult, TerraContext } from "@agoraio-extensions/terra-core";
import { setUserdata } from "../renderers/utils";

import path from "path";
import { getOutVariable } from "@agoraio-extensions/terra_shared_configs";

const userDataKey = "DartSyntaxParser";

export interface DartSyntaxParserValue {
  dartFileName?: string;
  dartName?: string;
}

function _dartClassName(name: string): string {
  // `IRtcEngine` -> `RtcEngine`
  // `Input` -> `Input`
  if (
    name !== name.toUpperCase() && // not all uppercase
    name.startsWith("I") &&
    name.length > 1 &&
    name[1] === name[1].toUpperCase()
  ) {
    name = name.replace("I", "");
  }

  return nameWithUnderscoresToCamelCase(name, true);
}

export function toDartMemberName(memberName: string): string {
  return nameWithUnderscoresToCamelCase(memberName.trimNamespace());
}

export function toDartStyleNaming(
  memberName: string,
  upperCamelCase: boolean = false
): string {
  let name = nameWithUnderscoresToCamelCase(
    memberName.trimNamespace(),
    upperCamelCase
  );

  if (upperCamelCase && name[0] == name[0].toLowerCase()) {
    name = name[0].toUpperCase() + name.slice(1);
  } else if (!upperCamelCase && name[0] == name[0].toUpperCase()) {
    name = name[0].toLowerCase() + name.slice(1);
  }

  return name;
}

function nameWithUnderscoresToCamelCase(
  nameWithUnderscores: string,
  upperCamelCase: boolean = false
): string {
  if (!nameWithUnderscores.includes("_")) {
    if (
      !upperCamelCase &&
      nameWithUnderscores === nameWithUnderscores.toUpperCase()
    ) {
      nameWithUnderscores = nameWithUnderscores.toLowerCase();
    }

    return nameWithUnderscores;
  }

  const nameWithUnderscoresLower = nameWithUnderscores.toLowerCase();
  const words = nameWithUnderscoresLower.split("_");
  for (let i = 0; i < words.length; i++) {
    let word = words[i];

    if (word.length > 0 && ((i === 0 && upperCamelCase) || i !== 0)) {
      word = word[0].toUpperCase() + word.slice(1);
    }

    words[i] = word;
  }

  return words.join("");
}

function _dartFileName(filePath: string): string {
  let fileName = path.basename(filePath);
  fileName = upperCamelCaseToLowercaseWithUnderscores(fileName);
  if (fileName.startsWith("i")) {
    fileName = fileName.replace("i", "");
  }
  return fileName;
}

function upperCamelCaseToLowercaseWithUnderscores(
  upperCamelCaseName: string
): string {
  const result: string[] = [];

  let toSearch = upperCamelCaseName;

  let baseRegex = new RegExp("((I[A-Z]|[A-Z])?[a-z0-9]*)");

  let baseMatch;

  while ((baseMatch = baseRegex.exec(toSearch)) !== null) {
    let tmp = baseMatch[0];
    if (tmp.length === 0) {
      break;
    }
    result.push(tmp.toLowerCase());
    toSearch = toSearch.replace(tmp, "");
  }

  return result.join("_");
}

const _cppTypedefToDartTypeMappping: Map<string, string> = new Map([
  ["uid_t", "int"],
  ["track_id_t", "int"],
  ["video_track_id_t", "int"],
  ["conn_id_t", "int"],
  ["view_t", "int"],
  ["AString", "String"],
  ["user_id_t", "String"],
]);

const _cppStdTypeToDartTypeMappping: Map<string, string> = new Map([
  ["char", "String"],
  ["char *", "String"],
  ["const char *", "String"],
  ["unsigned int", "int"],
  ["size_t", "int"],
  ["unsigned short", "int"],
  ["float", "double"],
  ["int64_t", "int"],
  ["int32_t", "int"],
  ["long", "int"],
  ["int16_t", "int"],
  ["unsigned char", "Uint8List"],
  ["unsigned char *", "Uint8List"],
  ["uint8_t", "int"],
  ["uint32_t", "int"],
  ["uint64_t", "int"],
  ["uint16_t", "int"],
  ["long long", "int"],
  ["intptr_t", "int"],
]);

function _dartTypeName(parseResult: ParseResult, type: SimpleType): string {
  let typeNode = parseResult.resolveNodeByType(type);
  let dartType = typeNode.name.trimNamespace();
  if (typeNode.__TYPE == CXXTYPE.Clazz || typeNode.__TYPE == CXXTYPE.Struct) {
    dartType = _dartClassName(dartType);
  } else if (typeNode.__TYPE == CXXTYPE.Enumz) {
    if (dartType.length == 0) {
      dartType = (typeNode.parent?.name.trimNamespace() ?? "") + "Enum";
    } else {
      dartType = _dartClassName(dartType);
    }
  } else if (
    typeNode.isSimpleType() &&
    typeNode.asSimpleType().kind == SimpleTypeKind.template_t &&
    typeNode.asSimpleType().template_arguments.length > 0
  ) {
    dartType = typeNode.asSimpleType().template_arguments[0].trimNamespace();
  }

  if (
    (dartType == "unsigned char" || dartType == "uint8_t") &&
    (type.kind == SimpleTypeKind.pointer_t ||
      type.kind == SimpleTypeKind.array_t)
  ) {
    dartType = "Uint8List";
  } else {
    if (_cppStdTypeToDartTypeMappping.has(dartType)) {
      dartType = _cppStdTypeToDartTypeMappping.get(dartType)!;
    }
    if (_cppTypedefToDartTypeMappping.has(dartType)) {
      dartType = _cppTypedefToDartTypeMappping.get(dartType)!;
    }
    if (dartType.includes("_")) {
      dartType = nameWithUnderscoresToCamelCase(dartType, true);
    }

    // String type
    if (
      type.name == "char" &&
      (type.kind == SimpleTypeKind.array_t ||
        type.kind == SimpleTypeKind.pointer_t)
    ) {
      if (type.source.endsWith("**")) {
        dartType = "List<" + dartType + ">";
      }
    } else {
      if (type.kind == SimpleTypeKind.array_t) {
        dartType = "List<" + dartType + ">";
      }
    }
  }

  return dartType;
}

export default function DartSyntaxParser(
  terraContext: TerraContext,
  args: any,
  preParseResult?: ParseResult
): ParseResult | undefined {
  let cxxFiles = preParseResult!.nodes as CXXFile[];

  cxxFiles.forEach((cxxFile: CXXFile) => {
    setUserdata(cxxFile, userDataKey, {
      dartFileName: _dartFileName(cxxFile.fileName),
    });

    cxxFile.nodes.forEach((node) => {
      if (node.__TYPE == CXXTYPE.Clazz || node.__TYPE == CXXTYPE.Struct) {
        let clazz = node as Clazz;

        setUserdata(clazz, userDataKey, {
          dartName: _dartClassName(clazz.name),
        });

        clazz.methods.forEach((method) => {
          setUserdata(method, userDataKey, {
            dartName: toDartStyleNaming(method.name),
          });

          setUserdata(method.return_type, userDataKey, {
            dartName: _dartTypeName(preParseResult!, method.return_type),
          });

          // If the `ReturnTypeParser` is applied, the `ReturnTypeParser` phase is executed before the `DartSyntaxParser`.
          // Therefore, the parameter associated with the out variable's naming may not be set.
          // In such cases, we need to reapply the naming here to ensure consistency.
          let outVariable = getOutVariable(method);
          if (outVariable) {
            setUserdata(outVariable, userDataKey, {
              dartName: toDartStyleNaming(outVariable.name),
            });
          }

          method.parameters.forEach((param) => {
            setUserdata(param.type, userDataKey, {
              dartName: _dartTypeName(preParseResult!, param.type),
            });

            setUserdata(param, userDataKey, {
              dartName: toDartStyleNaming(param.name),
            });
          });
        });

        clazz.member_variables.forEach((member) => {
          setUserdata(member, userDataKey, {
            dartName: toDartStyleNaming(member.name),
          });

          setUserdata(member.type, userDataKey, {
            dartName: _dartTypeName(preParseResult!, member.type),
          });
        });
      } else if (node.__TYPE == CXXTYPE.TypeAlias) {
        let typeAlias = node as TypeAlias;
        setUserdata(typeAlias, userDataKey, {
          dartName: toDartStyleNaming(typeAlias.name),
        });
        setUserdata(typeAlias.underlyingType, userDataKey, {
          dartName: _dartTypeName(preParseResult!, typeAlias.underlyingType),
        });
      } else if (node.__TYPE == CXXTYPE.Enumz) {
        let enumz = node as Enumz;
        setUserdata(enumz, userDataKey, {
          dartName: _dartClassName(enumz.name),
        });
        enumz.enum_constants.forEach((enumConstant) => {
          setUserdata(enumConstant, userDataKey, {
            dartName: toDartStyleNaming(enumConstant.name),
          });
        });
      } else if (node.isVariable()) {
        let v = node.asVariable();
        setUserdata(v, userDataKey, {
          dartName: toDartStyleNaming(v.name),
        });

        setUserdata(v.type, userDataKey, {
          dartName: _dartTypeName(preParseResult!, v.type),
        });
      }
    });
  });

  return preParseResult;
}

export function dartFileName(node: CXXTerraNode): string {
  return node.user_data?.[userDataKey]?.dartFileName ?? "";
}

export function dartName(node: CXXTerraNode): string {
  return node.user_data?.[userDataKey]?.dartName ?? "";
}
