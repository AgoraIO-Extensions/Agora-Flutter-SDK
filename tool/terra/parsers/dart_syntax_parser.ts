import {
  CXXFile,
  CXXTYPE,
  CXXTerraNode,
  Clazz,
  SimpleType,
  SimpleTypeKind,
} from "@agoraio-extensions/cxx-parser";
import { ParseResult, TerraContext } from "@agoraio-extensions/terra-core";
import { setUserdata } from "../renderers/utils";

import path from "path";

const userDataKey = "DartSyntaxParser";

export interface DartSyntaxParserValue {
  dartFileName?: string;
  dartName?: string;
}

function _dartClassName(clazz: Clazz): string {
  let name = clazz.name;
  if (name.startsWith("I")) {
    name = name.replace("I", "");
  }

  return name;
}

function _dartMemberName(memberName: string): string {
  return nameWithUnderscoresToCamelCase(memberName);
}

function nameWithUnderscoresToCamelCase(
  nameWithUnderscores: string,
  upperCamelCase: boolean = false
): string {
  if (!nameWithUnderscores.includes("_")) {
    return nameWithUnderscores;
  }

  const nameWithUnderscoresLower = nameWithUnderscores.toLowerCase();
  const words = nameWithUnderscoresLower.split("_");
  for (let i = 0; i < words.length; i++) {
    let word = words[i];

    if ((i === 0 && upperCamelCase) || i !== 0) {
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

  //   const baseRegex = /((I[A-Z]|[A-Z])?[a-z0-9]*)/g;
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

function _dartTypeName(type: SimpleType): string {
  let dartType = type.name.trimNamespace();
  if (type.kind == SimpleTypeKind.template_t) {
    dartType = type.template_arguments[0];
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
          dartName: _dartClassName(clazz),
        });

        clazz.methods.forEach((method) => {
          setUserdata(method, userDataKey, {
            dartName: _dartMemberName(method.name),
          });

          setUserdata(method.return_type, userDataKey, {
            dartName: _dartTypeName(method.return_type),
          });

          method.parameters.forEach((param) => {
            setUserdata(param.type, userDataKey, {
              dartName: _dartTypeName(param.type),
            });

            setUserdata(param, userDataKey, {
              dartName: _dartMemberName(param.name),
            });
          });
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
