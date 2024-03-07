import {
  CXXFile,
  CXXTYPE,
  CXXTerraNode,
  Clazz,
} from "@agoraio-extensions/cxx-parser";
import {
  ParseResult,
  RenderResult,
  TerraContext,
} from "@agoraio-extensions/terra-core";
import { irisApiId } from "@agoraio-extensions/terra_shared_configs";
import { isCallbackClass } from "./utils";

const funcNeedCheckWithBaseClasses = [
  "agora::media::IAudioFrameObserver",
  "agora::rtc::IRtcEngineEventHandlerEx",
];
function isNeedCheckWithBaseClasses(clazz: Clazz): boolean {
  return funcNeedCheckWithBaseClasses.includes(clazz.fullName);
}

export default function EventIdsMappingRenderer(
  terraContext: TerraContext,
  args: any,
  parseResult: ParseResult
): RenderResult[] {
  let cxxFiles = parseResult!.nodes as CXXFile[];
  let eventIdsMapping: Map<string, string[]> = new Map();

  cxxFiles.forEach((cxxFile: CXXFile) => {
    cxxFile.nodes.forEach((node) => {
      if (node.__TYPE == CXXTYPE.Clazz) {
        let clazz = node as Clazz;
        clazz.methods.forEach((method) => {
          if (isCallbackClass(clazz)) {
            let key = `${clazz.name.replace("I", "")}_${method.name}`;
            let value = getIrisApiIdValue(method);
            if (value.length > 0) {
              if (!eventIdsMapping.has(key)) {
                eventIdsMapping.set(key, []);
              }
              eventIdsMapping.get(key)?.push(value);
            }
          }
        });
      }
    });
  });

  let eventIdsMappingContents: string[] = [];

  eventIdsMapping.forEach((value, key) => {
    eventIdsMappingContents.push(
      `"${key}": [${value.map((it) => `"${it}"`).join(", ")}]`
    );
  });

  let output = `
  /// Event Ids mapping of iris api id.
const eventIdsMapping = {
  ${eventIdsMappingContents.join(",\n")}
};
`.trim();

  return [
    {
      file_name:
        "test_shard/fake_test_app/integration_test/generated/event_ids_mapping_gen.dart",
      file_content: output,
    },
  ];
}

export function getIrisApiIdKey(node: CXXTerraNode): string {
  return node.user_data?.["IrisApiIdParser"]?.key ?? "";
}

export function getIrisApiIdValue(node: CXXTerraNode): string {
  return node.user_data?.["IrisApiIdParser"]?.value ?? "";
}
