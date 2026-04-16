@JS()
library iris_web_rtc;

import 'package:iris_method_channel/iris_method_channel_bindings_web.dart';
import 'package:js/js.dart';

@JS('IrisWebRtc.initIrisRtc')
external void initIrisRtc(
    IrisApiEngine irisApiEngine, InitIrisRtcOptions? options);

@JS('InitIrisRtcOptions')
@anonymous
class InitIrisRtcOptions {
  // Must have an unnamed factory constructor with named arguments.
  external factory InitIrisRtcOptions(
      {Object? agoraRTC, Object? irisRtcEngine});

  external Object get agoraRTC;
  external Object get irisRtcEngine;
}
