import {
  CXXFile,
  CXXTYPE,
  CXXTerraNode,
  Clazz,
} from "@agoraio-extensions/cxx-parser";
import { ParseResult, TerraContext } from "@agoraio-extensions/terra-core";
import { irisApiId } from "@agoraio-extensions/terra_shared_configs";

const funcNeedCheckWithBaseClasses = [
  "agora::media::IAudioFrameObserver",
  "agora::rtc::IRtcEngineEventHandlerEx",
];
function isNeedCheckWithBaseClasses(clazz: Clazz): boolean {
  return funcNeedCheckWithBaseClasses.includes(clazz.fullName);
}

export default function IrisApiIdParser(
  terraContext: TerraContext,
  args: any,
  preParseResult?: ParseResult
): ParseResult | undefined {
  let cxxFiles = preParseResult!.nodes as CXXFile[];
  cxxFiles.forEach((cxxFile: CXXFile) => {
    cxxFile.nodes.forEach((node) => {
      if (node.__TYPE == CXXTYPE.Clazz) {
        let clazz = node as Clazz;
        let needCheckWithBaseClasses = isNeedCheckWithBaseClasses(clazz);
        clazz.methods.forEach((method) => {
          method.user_data ??= {};
          method.user_data!["IrisApiIdParser"] = {
            key: irisApiId(clazz, method, {
              toUpperCase: true,
            }),
            value: irisApiId(clazz, method, {
              toUpperCase: false,
            }),
          };
        });
      }
    });
  });

  return preParseResult;
}

export function getIrisApiIdKey(node: CXXTerraNode): string {
  return node.user_data?.["IrisApiIdParser"]?.key ?? "";
}

export function getIrisApiIdValue(node: CXXTerraNode): string {
  return node.user_data?.["IrisApiIdParser"]?.value ?? "";
}
