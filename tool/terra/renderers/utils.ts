import { Clazz } from "@agoraio-extensions/cxx-parser";

export function isCallbackClass(clazz: Clazz): boolean {
    return new RegExp(
      "(EventHandler|Observer|Provider|Sink|Callback|ObserverBase|EventHandlerEx)$"
    ).test(clazz.name);
  }