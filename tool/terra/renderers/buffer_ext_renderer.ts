import { CXXFile, CXXTYPE, Clazz, MemberVariable, Struct } from "@agoraio-extensions/cxx-parser";
import {
  ParseResult,
  RenderResult,
  TerraContext,
} from "@agoraio-extensions/terra-core";
import { defaultDartHeader, defaultIgnoreForFile, isCallbackClass, isNeedIgnoreJsonInJsonObject } from "./utils";
import { dartFileName, dartName } from "../parsers/dart_syntax_parser";

/// Generate the files:
/// - lib/src/binding/call_api_event_handler_buffer_ext.dart
export default function BufferExtRenderer(
  terraContext: TerraContext,
  args: any,
  parseResult: ParseResult
): RenderResult[] {
  let cxxFiles = parseResult!.nodes as CXXFile[];

  let extensionContents = cxxFiles.flatMap((cxxFile: CXXFile) => cxxFile.nodes)
    .filter((node) => node.__TYPE == CXXTYPE.Struct)
    .map((node) => renderBufferExtBlock(parseResult, dartName(node.asStruct()), node.asStruct()!.member_variables))
    .join("\n\n");

  let content = `
${defaultDartHeader}

${defaultIgnoreForFile}, prefer_is_empty

import '/src/binding_forward_export.dart';

${extensionContents}
`;

  return [
    {
      file_name: "lib/src/binding/call_api_event_handler_buffer_ext.dart",
      file_content: content,
    },
  ];
}

export function renderBufferExtBlock(parseResult: ParseResult, structName: string, memberVariables: MemberVariable[]) {
  let extName = `${structName}BufferExt`;

  let bufferMemberNames = memberVariables.filter((member) => dartName(member.type) == 'Uint8List').map((member) => dartName(member));
  let constructorNamedParams = memberVariables.map((it) => `${dartName(it)}: ${dartName(it)}`);

  let output = `
extension ${extName} on ${structName} {
  ${structName} fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    ${function () {
      let tmpOutput = "";
      for (let i = 0; i < bufferMemberNames.length; i++) {
        let n = bufferMemberNames[i];
        tmpOutput += `
        Uint8List? ${n};
        if (bufferList.length > ${i}) {
          ${n} = bufferList[${i}];
        }`.trim();
      }
      if (bufferMemberNames.length == 0) {
        tmpOutput += "return this;";
      } else {
        tmpOutput += `return ${structName}(${constructorNamedParams.join(", ")});`;
      }
      return tmpOutput;
    }()}
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    ${function () {
      if (bufferMemberNames.length == 0) return "return bufferList;";
      return `
          ${bufferMemberNames.map((it) => `if (${it} != null) { bufferList.add(${it}!); }`).join("\n")}
          return bufferList;
          `.trim();
    }()
    }
  }
}
  `;

  return output;
}
