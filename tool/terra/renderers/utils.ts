import {
  CXXTYPE,
  Clazz,
  Enumz,
  MemberFunction,
  MemberVariable,
  SimpleType,
  SimpleTypeKind,
  Variable,
} from "@agoraio-extensions/cxx-parser";
import { ParseResult } from "@agoraio-extensions/terra-core";
import _ from "lodash";
import { dartName } from "../parsers/dart_syntax_parser";

export const defaultDartHeader =
  "/// GENERATED BY terra, DO NOT MODIFY BY HAND.";

export const defaultIgnoreForFile =
  "// ignore_for_file: public_member_api_docs, unused_local_variable, unused_import";

export function isCallbackClass(clazz: Clazz): boolean {
  return new RegExp(
    "(EventHandler|Observer|Provider|Sink|Callback|ObserverBase|EventHandlerEx)$"
  ).test(clazz.name);
}

export function isRegisterCallbackFunction(
  memberFunc: MemberFunction
): boolean {
  return new RegExp(
    "^(register)[A-Za-z0-9]*(EventHandler|Observer|Provider)$"
  ).test(memberFunc.name);
}

export function isUnregisterCallbackFunction(
  memberFunc: MemberFunction
): boolean {
  return new RegExp(
    "^(unregister)[A-Za-z0-9]*(EventHandler|Observer|Provider)$"
  ).test(memberFunc.name);
}

export function getBaseClasses(
  parseResult: ParseResult,
  clazz: Clazz
): Clazz[] {
  let output: Clazz[] = [];
  clazz.base_clazzs.forEach((it) => {
    let found = parseResult.resolveNodeByName(it);
    if (found) {
      output.push(found! as Clazz);
    }
  });

  return output;
}

export function getBaseClassMethods(
  parseResult: ParseResult,
  clazz: Clazz
): MemberFunction[] {
  return clazz.base_clazzs
    .map((it) => {
      return parseResult.resolveNodeByName(it);
    })
    .filter((it) => it?.__TYPE == CXXTYPE.Clazz)
    .map((it) => {
      return it?.asClazz().methods ?? [];
    })
    .flat();
}

export function isNullableType(type: SimpleType): boolean {
  const cppTypeToNullableTypes = ["agora_refptr", "Optional"];

  let isNullableType =
    cppTypeToNullableTypes.find((it) => type.source.includes(it)) != undefined;

  return isNullableType;
}

export function isNullableVariable(variable: Variable): boolean {
  return (
    variable.default_value == "__null" || variable.default_value == "nullptr"
  );
}

export function setUserdata(node: any, key: string, value: any) {
  node.user_data ??= {};
  let old = node.user_data![key];
  if (old) {
    node.user_data![key] = _.merge(old, value);
  } else {
    node.user_data![key] = value;
  }
}

const ignoreJsonTypes = ["Uint8List"];
export function isNeedIgnoreJsonInJsonObject(
  parseResult: ParseResult,
  type: SimpleType
): boolean {
  let isIgnoreJson = ignoreJsonTypes.includes(dartName(type));

  return isIgnoreJson;
}

export function isDartBufferType(type: SimpleType): boolean {
  return dartName(type) == "Uint8List";
}

export function _trim(
  str: string,
  options?: { eliminateEmptyLine?: boolean }
): string {
  let eliminateEmptyLine = options?.eliminateEmptyLine ?? false;
  if (eliminateEmptyLine) {
    return str
      .split("\n")
      .filter((it) => it.trim().length != 0)
      .join("\n")
      .trim();
  }

  return str.trim();
}

export function renderJsonSerializable(
  parseResult: ParseResult,
  jsonClassName: string,
  memberVariables: MemberVariable[],
  options?: {
    forceExplicitNullableType: boolean;
    forceNamingConstructor: boolean;
  }
) {
  let forceExplicitNullableType: boolean =
    options?.forceExplicitNullableType ?? true;
  let forceNamingConstructor: boolean = options?.forceNamingConstructor ?? true;

  let initializeBlock =
    memberVariables.length > 0
      ? `${memberVariables.map((it) => `this.${dartName(it)}`).join(",")}`
      : "";
  if (forceNamingConstructor && initializeBlock.length) {
    initializeBlock = `{${initializeBlock}}`;
  }

  let output = `
  @JsonSerializable(explicitToJson: true, includeIfNull: false)
    class ${jsonClassName} implements AgoraSerializable {
    const ${jsonClassName}(
      ${initializeBlock}
    );

    ${memberVariables
      .map((it) => {
        let isIgnoreJson = isNeedIgnoreJsonInJsonObject(parseResult, it.type);
        let isNeedReadValueWithReadIntPtr =
          !isIgnoreJson && isUIntPtr(parseResult, it.type);
        let isNeedReadValueWithReadIntPtrList =
          !isIgnoreJson && isUIntPtrList(parseResult, it.type);
        let actualNode = parseResult.resolveNodeByType(it.type);
        // Campatible with the old code.
        isIgnoreJson =
          isIgnoreJson || dartName(actualNode) == "MusicCollection";
        // TODO(littlegnal): Add converter annotation for class type.
        // We should add converter annotation for class type, but we only add it for VideoFrameMetaInfo
        // due to the historical reason.
        let isClazz =
          actualNode.__TYPE == CXXTYPE.Clazz &&
          dartName(actualNode) == "VideoFrameMetaInfo";
        let nullableSurffix = forceExplicitNullableType ? "?" : "";
        let jsonKeyAnnotations = [
          `name: '${it.name}'`,
          ...(isIgnoreJson ? ["ignore: true"] : []),
          ...(isNeedReadValueWithReadIntPtr &&
          !isNeedReadValueWithReadIntPtrList
            ? ["readValue: readIntPtr"]
            : []),
          ...(isNeedReadValueWithReadIntPtr && isNeedReadValueWithReadIntPtrList
            ? ["readValue: readIntPtrList"]
            : []),
        ];
        return `
      ${isClazz ? `@${dartName(actualNode)}Converter()` : ""}
      @JsonKey(${jsonKeyAnnotations.join(",")})
      final ${dartName(it.type)}${nullableSurffix} ${dartName(it)};
      `.trim();
      })
      .join("\n\n")}

    factory ${jsonClassName}.fromJson(Map<String, dynamic> json) => _$${jsonClassName}FromJson(json);

    @override
    Map<String, dynamic> toJson() => _$${jsonClassName}ToJson(this);
  }
  `;

  return output;
}

export function renderEnumJsonSerializable(enumz: Enumz) {
  let enumName = dartName(enumz);
  return `
@JsonEnum(alwaysCreate: true)
enum ${enumName} {
  ${enumz.enum_constants
    .map((it) => {
      return `
    @JsonValue(${it.value})
    ${dartName(it)},
    `;
    })
    .join("\n\n")}
}

extension ${enumName}Ext on ${enumName} {
  /// @nodoc
  static ${enumName} fromValue(int value) {
    return $enumDecode(_$${enumName}EnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$${enumName}EnumMap[this]!;
  }
}
`;
}

export function variableToMemberVariable(it: Variable): MemberVariable {
  return {
    name: it.name,
    type: it.type,
    user_data: it.user_data,
  } as MemberVariable;
}

const stdIntTypes = [
  "int8_t",
  "int16_t",
  "int32_t",
  "int64_t",
  "uint8_t",
  "uint16_t",
  "uint32_t",
  "uint64_t",
  "size_t",
];

// TODO(littlegnal): Move to cxx-parser
export function isStdIntType(typeName: string): boolean {
  return stdIntTypes.includes(typeName);
}

function isBufferPtr(type: SimpleType): boolean {
  return (
    type.kind == SimpleTypeKind.pointer_t &&
    (isStdIntType(type.name) ||
      type.source.includes("unsigned char") ||
      type.name.toLowerCase().includes("buffer") ||
      type.source.includes("void"))
  );
}

export function isUIntPtr(parseResult: ParseResult, type: SimpleType): boolean {
  let isUIntPtr = isBufferPtr(type);
  if (!isUIntPtr) {
    let actualNode = parseResult.resolveNodeByType(type);
    if (actualNode.__TYPE == CXXTYPE.TypeAlias) {
      isUIntPtr = isBufferPtr(actualNode.asTypeAlias().underlyingType);
    }
  }

  return isUIntPtr;
}

export function isUIntPtrList(
  parseResult: ParseResult,
  type: SimpleType
): boolean {
  let isPtrList = isUIntPtr(parseResult, type);
  isPtrList = isPtrList && type.kind == SimpleTypeKind.array_t;
  return isPtrList;
}
