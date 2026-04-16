import 'dart:js_interop';
import 'dart:js_interop_unsafe';

class InitIrisRtcOptions {
  const InitIrisRtcOptions({this.agoraRTC, this.irisRtcEngine});

  final Object? agoraRTC;
  final Object? irisRtcEngine;
}

void initIrisRtc(Object irisApiEngine, InitIrisRtcOptions? options) {
  final irisWebRtc = globalContext['IrisWebRtc'] as JSObject? ??
      (throw StateError('IrisWebRtc is not available on the global scope.'));

  irisWebRtc.callMethodVarArgs<JSAny?>('initIrisRtc'.toJS, [
    _toJSValue(irisApiEngine),
    if (options != null) _toJsOptions(options),
  ]);
}

JSObject _toJsOptions(InitIrisRtcOptions options) {
  final jsOptions = JSObject();
  if (options.agoraRTC != null) {
    jsOptions['agoraRTC'] = _toJSValue(options.agoraRTC!);
  }
  if (options.irisRtcEngine != null) {
    jsOptions['irisRtcEngine'] = _toJSValue(options.irisRtcEngine!);
  }

  return jsOptions;
}

JSAny _toJSValue(Object value) => switch (value) {
      String value => value.toJS,
      int value => value.toJS,
      double value => value.toJS,
      bool value => value.toJS,
      _ => JSObject.fromInteropObject(value),
    };
