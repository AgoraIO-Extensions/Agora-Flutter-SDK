import {
  CXXFile,
  CXXTYPE,
  Clazz,
  MemberFunction,
  SimpleTypeKind,
} from "@agoraio-extensions/cxx-parser";
import {
  ParseResult,
  RenderResult,
  TerraContext,
} from "@agoraio-extensions/terra-core";
import {
  _trim,
  defaultDartHeader,
  defaultIgnoreForFile,
  getBaseClasses,
  isCallbackClass,
  isDartBufferType,
  isNullableVariable,
  renderJsonSerializable,
  variableToMemberVariable,
} from "./utils";
import {
  dartFileName,
  dartName,
  toDartStyleNaming,
} from "../parsers/dart_syntax_parser";
import {
  getIrisApiIdValue,
  getOutVariable,
} from "@agoraio-extensions/terra_shared_configs";
import {
  functionSignature,
  isSynchronizedFunction,
} from "./api_interface_renderer";

/// Generate the implementation files.
export default function CallApiImplRenderer(
  terraContext: TerraContext,
  args: any,
  parseResult: ParseResult
): RenderResult[] {
  let cxxFiles = (parseResult!.nodes as CXXFile[]).filter((cxxFile) => {
    return cxxFile.nodes.find((node) => {
      return node.__TYPE == CXXTYPE.Clazz && !isCallbackClass(node as Clazz);
    });
  });
  let renderResults = cxxFiles.map((cxxFile) => {
    let subContents = cxxFile.nodes
      .filter((it) => it.__TYPE == CXXTYPE.Clazz)
      .filter((it) => !isCallbackClass(it.asClazz()))
      .map((it) => {
        let clazz = it.asClazz();
        let clazzName = dartName(clazz);
        let methods = clazz.methods;
        let methodImpls = methods
          .map((method) => callApiImplBlock(parseResult, clazz, method))
          .join("\n\n");
        let baseClassImplNames = getBaseClasses(parseResult, clazz).map(
          (baseClass) => `${dartName(baseClass)}Impl`
        );
        let shouldOverrideBaseClass = baseClassImplNames.length > 0;
        let classExtendsBlock = shouldOverrideBaseClass
          ? `extends ${baseClassImplNames.join(", ")} `
          : "";
        let constructorBlock = `${clazzName}Impl(${
          shouldOverrideBaseClass
            ? "IrisMethodChannel irisMethodChannel"
            : "this.irisMethodChannel"
        })${shouldOverrideBaseClass ? ": super(irisMethodChannel)" : ""};`;

        return `
        class ${clazzName}Impl ${classExtendsBlock} implements ${clazzName} {
          ${constructorBlock}

          ${
            shouldOverrideBaseClass
              ? ""
              : `
              @protected
              final IrisMethodChannel irisMethodChannel;`.trim()
          }
          
          ${shouldOverrideBaseClass ? "@override" : ""}
          @protected
          Map<String, dynamic> createParams(Map<String, dynamic> param) {
            return param;
          }

          ${shouldOverrideBaseClass ? "@override" : ""}
          @protected
          bool get isOverrideClassName => false;

          ${shouldOverrideBaseClass ? "@override" : ""}
          @protected
          String get className => '${clazzName}';

          ${methodImpls}
        }
        `.trim();
      })
      .join("\n\n");

    let content = `
      ${defaultDartHeader}
      
      ${defaultIgnoreForFile}, annotate_overrides
      
      import 'package:agora_rtc_engine/src/binding_forward_export.dart';
      import 'package:agora_rtc_engine/src/binding/impl_forward_export.dart';
      import 'package:iris_method_channel/iris_method_channel.dart';
      
      ${subContents}
      `;

    return {
      file_name: `lib/src/binding/${dartFileName(cxxFile)}_impl.dart`,
      file_content: content,
    };
  });

  return [...renderResults, callApiImplParamsJsonFile(parseResult, cxxFiles)];
}

interface JsonMapInitBlock {
  preInitBlock: string;
  nullCheckBlock: string;
  jsonKey: string;
  jsonValue: string;
  addBufferExtBlock: string;
}

function callApiImplBlock(
  parseResult: ParseResult,
  clazz: Clazz,
  method: MemberFunction
): string {
  let className = dartName(clazz);
  let methodName = dartName(method);

  let paramJsonMapBlock = method.parameters.map((param) => {
    let paramName = dartName(param);
    let preInitBlock = "";
    let nullCheckBlock = "";
    let jsonKey = param.name;
    let jsonValue = paramName;
    let addBufferExtBlock = "";

    if (isNullableVariable(param)) {
      nullCheckBlock = `if (${paramName} != null)`;
    }

    let actualNode = parseResult.resolveNodeByType(param.type);
    if (actualNode.__TYPE == CXXTYPE.Enumz) {
      jsonValue = `${paramName}.value()`;
    } else if (actualNode.__TYPE == CXXTYPE.Struct) {
      // Null check is not necessary for struct.
      nullCheckBlock = "";
      if (param.type.kind == SimpleTypeKind.array_t) {
        let tmpParamName = `${paramName}JsonList`;
        preInitBlock = `final ${tmpParamName} = ${paramName}.map((e) => e.toJson()).toList();`;
        jsonValue = tmpParamName;
        addBufferExtBlock = `
        for (final e in ${paramName}) {
          buffers.addAll(e.collectBufferList());
        }`;
        if (isNullableVariable(param)) {
          addBufferExtBlock = `if (${paramName} != null) {
            ${addBufferExtBlock}
          }`;
        }
      } else {
        jsonValue = `${paramName}${
          isNullableVariable(param) ? "?" : ""
        }.toJson()`;
        addBufferExtBlock = `buffers.addAll(${paramName}.collectBufferList());`;
        if (isNullableVariable(param)) {
          addBufferExtBlock = `if (${paramName} != null) {
            ${addBufferExtBlock}
          }`;
        }
      }
    } else if (isDartBufferType(param.type)) {
      jsonKey = "";
      jsonValue = "";
      addBufferExtBlock = `buffers.add(${paramName});`;
    }

    return {
      preInitBlock: preInitBlock,
      nullCheckBlock: nullCheckBlock,
      jsonKey: jsonKey,
      jsonValue: jsonValue,
      addBufferExtBlock: addBufferExtBlock,
    } as JsonMapInitBlock;
  });

  let isNoImplFunc = isSynchronizedFunction(parseResult, method);
  let isNeedAddBufferExtBlock =
    paramJsonMapBlock.find((it) => it.addBufferExtBlock) != undefined;
  let buffersValueInJsonMap = isNeedAddBufferExtBlock ? "buffers" : "null";

  let apiType = `final apiType = \'\${isOverrideClassName ? className : '${className}'}_${getIrisApiIdValue(
    method
  )
    .split("_")
    .slice(1)
    .join("_")}\';`;

  let returnBlock = "";
  let returnTypeNode = parseResult.resolveNodeByType(method.return_type);
  let outVariable = getOutVariable(method);
  if (outVariable) {
    returnBlock = _trim(`
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
    final ${methodName}Json = ${className}${toDartStyleNaming(
      methodName,
      true
    )}Json.fromJson(rm);
    return ${methodName}Json.${toDartStyleNaming(outVariable.name)};
    `);
  } else if (returnTypeNode.__TYPE == CXXTYPE.Enumz) {
    returnBlock = `return ${dartName(returnTypeNode)}Ext.fromValue(result);`;
  } else if (method.return_type.name != "void") {
    let returnType = dartName(method.return_type);
    returnBlock = `return result as ${returnType};`;
  } else {
    returnBlock = `if (result < 0) { throw AgoraRtcException(code: result); }`;
  }

  let funcSignature = functionSignature(parseResult, method, {
    forceAddOverridePrefix: true,
  });
  let funcBlock = _trim(
    `
${apiType}
${paramJsonMapBlock.map((it) => it.preInitBlock).join("\n")}
final param = createParams({
  ${paramJsonMapBlock
    .filter((it) => it.jsonKey && it.jsonValue)
    .map((it) => `${it.nullCheckBlock}'${it.jsonKey}': ${it.jsonValue}`)
    .join(",")}
});
${isNeedAddBufferExtBlock ? "final List<Uint8List> buffers = [];" : ""}
${paramJsonMapBlock.map((it) => it.addBufferExtBlock).join("\n")}
final callApiResult = await irisMethodChannel.invokeMethod(IrisMethodCall(apiType, jsonEncode(param), buffers:${buffersValueInJsonMap}));
if (callApiResult.irisReturnCode < 0) {
  throw AgoraRtcException(code: callApiResult.irisReturnCode);
}
final rm = callApiResult.data;
final result = rm['result'];
${returnBlock}
  `,
    { eliminateEmptyLine: true }
  );

  if (isNoImplFunc) {
    funcBlock = funcBlock
      .split("\n")
      .map((it) => `// ${it}`)
      .join("\n");
    funcBlock = _trim(`
// Implementation template
${funcBlock}
    throw UnimplementedError('Unimplement for ${dartName(method)}');
    `);
  }

  return _trim(
    `
${funcSignature} {
  ${funcBlock}
}
`
  );
}

/// Generate the file: lib/src/binding/call_api_impl_params_json.dart
function callApiImplParamsJsonFile(
  parseResult: ParseResult,
  cxxFiles: CXXFile[]
): RenderResult {
  let nodes = cxxFiles.flatMap((cxxFile) => {
    return cxxFile.nodes
      .filter((it) => it.__TYPE == CXXTYPE.Clazz)
      .filter((it) => !isCallbackClass(it.asClazz()));
  });

  let jsonClassContents = nodes
    .map((node) => {
      let clazz = node.asClazz();
      let className = dartName(clazz);
      let methods = clazz.methods;

      return methods
        .map((method) => {
          let methodName = dartName(method);
          let jsonClassName = `${className}${toDartStyleNaming(
            methodName,
            true
          )}Json`;
          let output = "";
          let outVariable = getOutVariable(method);
          if (outVariable) {
            output = renderJsonSerializable(
              parseResult,
              jsonClassName,
              [variableToMemberVariable(outVariable)],
              {
                forceExplicitNullableType: false,
                forceNamingConstructor: false,
              }
            );
          }

          return output;
        })
        .filter((it) => it.length > 0)
        .join("\n\n");
    })
    .join("\n\n");

  return {
    file_name: "lib/src/binding/call_api_impl_params_json.dart",
    file_content: _trim(`
${defaultDartHeader}

${defaultIgnoreForFile}

import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'call_api_impl_params_json.g.dart';

${jsonClassContents}`),
  };
}
