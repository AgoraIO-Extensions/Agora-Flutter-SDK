import {
  CXXFile,
  CXXTYPE,
  CXXTerraNode,
  Clazz,
  MemberFunction,
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

export default function MergeRtcEngineEventHandlerParser(
  terraContext: TerraContext,
  args: any,
  preParseResult?: ParseResult
): ParseResult | undefined {
  let rtcEngineEventHandlerClazz = preParseResult!.resolveNodeByName(
    "agora::rtc::IRtcEngineEventHandler"
  );
  let rtcEngineEventHandlerExClazz = preParseResult!.resolveNodeByName(
    "agora::rtc::IRtcEngineEventHandlerEx"
  );

  if (rtcEngineEventHandlerClazz && rtcEngineEventHandlerClazz) {
    let adjustMethods: MemberFunction[] = [];
    rtcEngineEventHandlerClazz.asClazz().methods.forEach((method) => {
      let sameNameMethod = rtcEngineEventHandlerExClazz!
        .asClazz()
        .methods.find((it) => it.name == method.name);
      if (sameNameMethod) {
        // If there is a method with the same name in `IRtcEngineEventHandlerEx`, use it.
        adjustMethods.push(sameNameMethod);
      } else {
        // Force filter the `eventHandlerType` method.
        if (method.name != "eventHandlerType") {
          adjustMethods.push(method);
        }
      }
    });

    // After merge the `IRtcEngineEventHandler` and `IRtcEngineEventHandlerEx`,
    // remove the `IRtcEngineEventHandlerEx` from the parse result.
    preParseResult!.nodes.forEach((it) => {
      let cxxFile = it as CXXFile;
      cxxFile.nodes = cxxFile.nodes.filter(
        (it) =>
          it.__TYPE == CXXTYPE.Clazz &&
          it.fullName != "agora::rtc::IRtcEngineEventHandlerEx"
      );
    });
  }

  return preParseResult;
}

export function getIrisApiIdKey(node: CXXTerraNode): string {
  return node.user_data?.["IrisApiIdParser"]?.key ?? "";
}

export function getIrisApiIdValue(node: CXXTerraNode): string {
  return node.user_data?.["IrisApiIdParser"]?.value ?? "";
}
