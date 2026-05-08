// ignore: avoid_web_libraries_in_flutter
import 'dart:js_interop';

@JS('IrisWebRtc.initIrisRtc')
external void initIrisRtc(JSAny irisApiEngine, InitIrisRtcOptions? options);

@JS()
@staticInterop
@anonymous
class InitIrisRtcOptions {
  external factory InitIrisRtcOptions({
    JSAny? agoraRTC,
    JSAny? irisRtcEngine,
  });
}
