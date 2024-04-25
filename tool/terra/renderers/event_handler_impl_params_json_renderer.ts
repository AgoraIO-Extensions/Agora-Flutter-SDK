import {
  CXXFile,
  CXXTYPE,
  MemberFunction,
} from "@agoraio-extensions/cxx-parser";
import {
  ParseResult,
  RenderResult,
  TerraContext,
} from "@agoraio-extensions/terra-core";
import {
  defaultDartHeader,
  defaultIgnoreForFile,
  isCallbackClass,
  renderJsonSerializable,
  variableToMemberVariable,
} from "./utils";
import { dartName } from "../parsers/dart_syntax_parser";
import { renderBufferExtBlock } from "./buffer_ext_renderer";

/// Generate the files:
/// - lib/src/binding/event_handler_param_json.dart
export default function EventHandlerImplParamsJsonRenderer(
  terraContext: TerraContext,
  args: any,
  parseResult: ParseResult
): RenderResult[] {
  let cxxFiles = parseResult!.nodes as CXXFile[];

  let subContents = cxxFiles
    .flatMap((cxxFile: CXXFile) => cxxFile.nodes)
    .filter((it) => it.__TYPE == CXXTYPE.Clazz)
    .filter((it) => isCallbackClass(it.asClazz()))
    .map((it) => {
      return {
        clazz: it.asClazz()!,
        methods: it.asClazz()!.methods,
      };
    })
    .flatMap((holder) => {
      return holder.methods.map((node) => {
        let memberFunc = node as MemberFunction;
        let dartFuncName = dartName(memberFunc);
        dartFuncName = dartFuncName[0].toUpperCase() + dartFuncName.slice(1);
        let parentName = dartName(holder.clazz);
        let jsonClassName = parentName + dartFuncName + "Json";

        return `
        ${renderJsonSerializable(
          parseResult,
          jsonClassName,
          memberFunc.parameters.map((it) => variableToMemberVariable(it))
        )}
  
        ${renderBufferExtBlock(
          parseResult,
          jsonClassName,
          memberFunc.parameters.map((it) => variableToMemberVariable(it))
        )}
        `.trim();
      });
    })
    .join("\n\n");

  let content = `
${defaultDartHeader}

${defaultIgnoreForFile}, prefer_is_empty

import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'event_handler_param_json.g.dart';

${subContents}
`;

  return [
    {
      file_name: "lib/src/binding/event_handler_param_json.dart",
      file_content: content,
    },
  ];
}
