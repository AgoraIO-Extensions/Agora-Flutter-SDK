@JS()
library iris_web_rtc;

import 'dart:js_interop';

import 'package:iris_method_channel/iris_method_channel_bindings_web.dart';

@JS('IrisWebRtc.initIrisRtc')
external void initIrisRtc(
    IrisApiEngine irisApiEngine, InitIrisRtcOptions? options);

@JS('InitIrisRtcOptions')
@anonymous
@staticInterop
class InitIrisRtcOptions {
  external factory InitIrisRtcOptions(
      {JSAny? agoraRTC, JSAny? irisRtcEngine});
}

extension InitIrisRtcOptionsExt on InitIrisRtcOptions {
  external JSAny? get agoraRTC;
  external JSAny? get irisRtcEngine;
}
