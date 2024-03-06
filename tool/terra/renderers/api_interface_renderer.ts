import {
  CXXFile,
  CXXTYPE,
  Clazz,
  MemberFunction,
  SimpleTypeKind,
  Variable,
} from "@agoraio-extensions/cxx-parser";
import {
  _trim,
  defaultDartHeader,
  defaultIgnoreForFile,
  getBaseClassMethods,
  getBaseClasses,
  isCallbackClass,
  isNullableType,
  isNullableVariable,
  isRegisterCallbackFunction,
  isUnregisterCallbackFunction,
  renderEnumJsonSerializable,
  renderJsonSerializable,
} from "./utils";
import { isNodeMatched } from "../parsers/cud_node_parser";
import {
  ParseResult,
  RenderResult,
  TerraContext,
} from "@agoraio-extensions/terra-core";
import {
  dartFileName,
  dartName,
  toDartMemberName,
} from "../parsers/dart_syntax_parser";

export default function ApiInterfaceRenderer(
  terraContext: TerraContext,
  args: any,
  parseResult: ParseResult
): RenderResult[] {
  // let cxxFiles = (parseResult!.nodes as CXXFile[]).filter((cxxFile) => {
  //   return cxxFile.nodes.find((node) => {
  //     return node.__TYPE == CXXTYPE.Clazz && !isCallbackClass(node as Clazz);
  //   });
  // });
  let renderResults = (parseResult!.nodes as CXXFile[]).map((cxxFile) => {
    let subContents = cxxFile.nodes
      .filter((it) => it.name.length > 0)
      .map((node) => {
        switch (node.__TYPE) {
          case CXXTYPE.Clazz: {
            let clazz = node as Clazz;
            if (isCallbackClass(clazz)) {
              return renderCallbackClass(parseResult, clazz);
            } else {
              return renderClass(parseResult, clazz);
            }
          }
          case CXXTYPE.Struct: {
            return renderJsonSerializable(
              parseResult,
              dartName(node.asStruct()),
              node.asStruct()!.member_variables
            );
          }
          case CXXTYPE.Enumz: {
            return renderEnumJsonSerializable(node.asEnumz());
          }
          case CXXTYPE.Variable: {
            return renderTopLevelVariable(node.asVariable());
          }
          default: {
            return "";
          }
        }
      })
      .join("\n\n");

    // cxx_parser.isStruct(node);

    let isNeedImportGDartFile =
      cxxFile.nodes.find((node) => {
        return node.isStruct() || node.isEnumz();
      }) != undefined;

    let content = _trim(`
        import 'package:agora_rtc_engine/src/binding_forward_export.dart';
        ${
          isNeedImportGDartFile ? `part '${dartFileName(cxxFile)}.g.dart';` : ""
        }
        
        ${subContents}
        `);

    return {
      file_name: `lib/src/${dartFileName(cxxFile)}.dart`,
      file_content: content,
    };
  });

  return renderResults;
}

export function renderClass(parseResult: ParseResult, clazz: Clazz) {
  let baseClassNames = getBaseClasses(parseResult, clazz).map((it) =>
    dartName(it)
  );
  let implementsBlock =
    baseClassNames.length > 0 ? `implements ${baseClassNames.join(", ")}` : "";

  let funcs = clazz.methods
    .map((method) => {
      return `${functionSignature(parseResult, method, {
        ignoreAsyncKeyword: true,
      })};`;
    })
    .join("\n\n");

  return `
abstract class ${dartName(clazz)} ${implementsBlock} {
    ${funcs}
}
    `;
}

export function renderCallbackClass(parseResult: ParseResult, clazz: Clazz) {
  let clazzName = dartName(clazz);
  let baseClasses = getBaseClasses(parseResult, clazz);
  let baseClassMethods = getBaseClassMethods(parseResult, clazz);
  let baseClassNames = getBaseClasses(parseResult, clazz).map((it) =>
    dartName(it)
  );
  let extendsBlock =
    baseClassNames.length > 0 ? `extends ${baseClassNames.join(", ")}` : "";

  let constructorSuperBlock = "";
  if (baseClassMethods.length > 0) {
    constructorSuperBlock = `
super(
${baseClassMethods.map((it) => `${dartName(it)} : ${dartName(it)},`).join("")}
)
`;
  }

  let constructorParameters: string[] = [];
  if (baseClassMethods.length > 0) {
    baseClassMethods.forEach((it) => {
      let funcType = `${dartName(it.return_type)} Function(${it.parameters
        .map((param) => `${dartName(param.type)} ${dartName(param)}`)
        .join(", ")})?`;
      constructorParameters.push(`${funcType} ${dartName(it)},`);
    });
  }
  clazz.methods.forEach((method) => {
    constructorParameters.push(`this.${dartName(method)},`);
  });
  // constructorParameters.push(",");

  let constructorBlock = _trim(`
  /// Construct the [${clazzName}].
  const ${clazzName}({
    ${constructorParameters.join("")}
  })
  ${constructorSuperBlock.length > 0 ? `: ${constructorSuperBlock}` : ""};`);

  // NOTE: A new line between the constructor and the methods is required, otherwise the `iris_doc` CLI
  // may cause a bug.
  return _trim(`
  class ${clazzName} ${extendsBlock} {

  ${constructorBlock}

  ${clazz.methods
    .map((method) => {
      let funcType = `${dartName(
        method.return_type
      )} Function(${method.parameters
        .map((param) => `${dartName(param.type)} ${dartName(param)}`)
        .join(", ")})?`;
      return `final ${funcType} ${dartName(method)};`;
    })
    .join("\n\n")}
  }
    `);
}

function renderTopLevelVariable(topLevelVariable: Variable): string {
  const unsignedIntMaxExpression = "(std::numeric_limits<unsigned int>::max)()";
  let dartConst = "";
  dartConst += "/// @nodoc \n";
  let defaultValue = topLevelVariable.default_value;
  if (defaultValue === unsignedIntMaxExpression) {
    // value of `(std::numeric_limits<unsigned int>::max)()`
    defaultValue = "4294967295";
  }
  dartConst += `const ${dartName(topLevelVariable)} = ${defaultValue};\n`;
  return dartConst;
}

// We treat the callback as a synchronized function, see the logic inside `isSynchronizedFunction`,
// but some functions with callback parameters are not synchronized, so we need to add them to the `asyncFunctions` list.
const asyncFunctions = [
  // agora::rtc::IMediaRecorder
  {
    __TYPE: CXXTYPE.MemberFunction,
    name: "setMediaRecorderObserver",
    parent_name: "IMediaRecorder",
    namespaces: ["agora", "rtc"],
  },
  // agora::rtc::IRtcEngine::startDirectCdnStreaming
  {
    __TYPE: CXXTYPE.MemberFunction,
    name: "startDirectCdnStreaming",
    parent_name: "IRtcEngine",
    namespaces: ["agora", "rtc"],
  },
];

const synchronizedFunctions = [
  // agora::rtc::IRtcEngine
  {
    __TYPE: CXXTYPE.MemberFunction,
    name: "getVideoDeviceManager",
    parent_name: "IRtcEngine",
    namespaces: ["agora", "rtc"],
  },
  {
    __TYPE: CXXTYPE.MemberFunction,
    name: "getAudioDeviceManager",
    parent_name: "IRtcEngine",
    namespaces: ["agora", "rtc"],
  },
  {
    __TYPE: CXXTYPE.MemberFunction,
    name: "getMediaEngine",
    parent_name: "IRtcEngine",
    namespaces: ["agora", "rtc"],
  },
  {
    __TYPE: CXXTYPE.MemberFunction,
    name: "getMediaRecorder",
    parent_name: "IRtcEngine",
    namespaces: ["agora", "rtc"],
  },
  {
    __TYPE: CXXTYPE.MemberFunction,
    name: "getLocalSpatialAudioEngine",
    parent_name: "IRtcEngine",
    namespaces: ["agora", "rtc"],
  },
  {
    __TYPE: CXXTYPE.MemberFunction,
    name: "getMusicContentCenter",
    parent_name: "IRtcEngine",
    namespaces: ["agora", "rtc"],
  },
  {
    __TYPE: CXXTYPE.MemberFunction,
    name: "getH265Transcoder",
    parent_name: "IRtcEngine",
    namespaces: ["agora", "rtc"],
  },
  // agora::rtc::IMediaPlayer
  {
    __TYPE: CXXTYPE.MemberFunction,
    name: "getMediaPlayerId",
    parent_name: "IMediaPlayer",
    namespaces: ["agora", "rtc"],
  },
  // agora::rtc::MusicCollection
  {
    __TYPE: CXXTYPE.MemberFunction,
    name: "getCount",
    parent_name: "MusicCollection",
    namespaces: ["agora", "rtc"],
  },
  {
    __TYPE: CXXTYPE.MemberFunction,
    name: "getTotal",
    parent_name: "MusicCollection",
    namespaces: ["agora", "rtc"],
  },
  {
    __TYPE: CXXTYPE.MemberFunction,
    name: "getPage",
    parent_name: "MusicCollection",
    namespaces: ["agora", "rtc"],
  },
  {
    __TYPE: CXXTYPE.MemberFunction,
    name: "getPageSize",
    parent_name: "MusicCollection",
    namespaces: ["agora", "rtc"],
  },
  {
    __TYPE: CXXTYPE.MemberFunction,
    name: "getMusic",
    parent_name: "MusicCollection",
    namespaces: ["agora", "rtc"],
  },
];
export function isSynchronizedFunction(
  parseResult: ParseResult,
  memberFunction: MemberFunction
): boolean {
  let isSyncFunc =
    synchronizedFunctions.find((it) => isNodeMatched(memberFunction, it)) !=
      undefined ||
    isRegisterCallbackFunction(memberFunction) ||
    isUnregisterCallbackFunction(memberFunction);
  if (
    !isSyncFunc &&
    asyncFunctions.find((it) => isNodeMatched(memberFunction, it)) == undefined
  ) {
    // If there a callback class in the parameter list, then it's a synchronized function
    isSyncFunc =
      memberFunction.parameters.find((param) => {
        let tmpNode = parseResult.resolveNodeByType(param.type);
        if (tmpNode.__TYPE == CXXTYPE.Clazz) {
          return isCallbackClass(tmpNode.asClazz());
        }
        return false;
      }) != undefined;
  }
  return isSyncFunc;
}

export function functionSignature(
  parseResult: ParseResult,
  memberFunction: MemberFunction,
  options?: {
    forceAddOverridePrefix?: boolean;
    ignoreAsyncKeyword?: boolean;
  }
): string {
  let isSynchronizedFunc = isSynchronizedFunction(parseResult, memberFunction);
  let parentClass = memberFunction.parent! as Clazz;
  let forceAddOverridePrefix: boolean =
    options?.forceAddOverridePrefix ?? false;
  let ignoreAsyncKeyword = options?.ignoreAsyncKeyword ?? false;
  let addOverrideSurffix =
    forceAddOverridePrefix ||
    getBaseClassMethods(parseResult, parentClass).find(
      (it) => it.name == memberFunction.name
    );
  let overridePrefix = addOverrideSurffix ? "@override " : "";
  let returnType = dartName(memberFunction.return_type);
  returnType = `${returnType}${
    isNullableType(memberFunction.return_type) ? "?" : ""
  }`;
  if (!isSynchronizedFunc) {
    returnType = `Future<${returnType}>`;
  }
  let functionName = dartName(memberFunction);
  let defaultValue = "";
  let isNeedRequiredKeyword = memberFunction.parameters.length > 1;
  let asyncKeywordSurffix =
    isSynchronizedFunc || ignoreAsyncKeyword ? "" : "async";

  let parameterListBlock = memberFunction.parameters
    .map((param) => {
      let typeNode = parseResult.resolveNodeByType(param.type);
      //   let typeName = dartName(typeNode);
      //   if (typeNode.__TYPE == CXXTYPE.TypeAlias) {
      //     typeName = dartName(param.type);
      //   }
      let typeName = dartName(param.type);
      let variableName = dartName(param);

      // Has default value
      if (param.default_value) {
        isNeedRequiredKeyword = false;

        if (typeNode.__TYPE == CXXTYPE.Enumz) {
          console.log(
            `method: ${memberFunction.name}, enum: ${typeNode.name}, default: ${param.default_value}`
          );
          defaultValue = `${typeName}.${toDartMemberName(param.default_value)}`;
        } else if (typeNode.__TYPE == CXXTYPE.Struct) {
          defaultValue = `const ${dartName(typeNode)}()`;
        } else {
          defaultValue = param.default_value;
        }

        if (isNullableVariable(param)) {
          typeName = `${typeName}?`;
          defaultValue = "";
        }
      }

      return `${
        isNeedRequiredKeyword ? "required" : ""
      } ${typeName} ${variableName}${defaultValue ? ` = ${defaultValue}` : ""}`;
    })
    .join(",");

  if (
    memberFunction.parameters.find((it) => it.default_value) ||
    memberFunction.parameters.length > 1
  ) {
    parameterListBlock = `{${parameterListBlock}}`;
  }

  return `${overridePrefix} ${returnType} ${functionName}(${parameterListBlock}) ${asyncKeywordSurffix}`;
}
