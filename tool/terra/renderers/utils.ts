import { Clazz } from "@agoraio-extensions/cxx-parser";
import _ from "lodash";

export function isCallbackClass(clazz: Clazz): boolean {
  return new RegExp(
    "(EventHandler|Observer|Provider|Sink|Callback|ObserverBase|EventHandlerEx)$"
  ).test(clazz.name);
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
