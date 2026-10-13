import 'dart:js_interop';

import 'package:iris_method_channel/iris_method_channel_bindings_web.dart';

@JS('IrisWebRtc.initIrisRtc')
external void initIrisRtc(
    IrisApiEngine irisApiEngine, InitIrisRtcOptions? options);

extension type InitIrisRtcOptions._(JSObject _) implements JSObject {
  // An external factory with only named arguments creates a JS object
  // literal (the `dart:js_interop` equivalent of `@anonymous`).
  external factory InitIrisRtcOptions({JSAny? agoraRTC, JSAny? irisRtcEngine});

  external JSAny? get agoraRTC;
  external JSAny? get irisRtcEngine;
}
