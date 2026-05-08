// ignore: avoid_web_libraries_in_flutter
import 'dart:js_interop';

/// Same property shape as `IrisCore.EventParam` (plain JS object for Iris web).
@JS()
extension type EventParam._(JSObject _) implements JSObject {
  external factory EventParam({
    required String event,
    required String data,
    @JS('data_size')
    required int dataSize,
    required String result,
    required JSArray<JSAny?> buffer,
    required JSArray<JSNumber> length,
    @JS('buffer_count')
    required int bufferCount,
  });
}

@JS('createIrisRtcEngineFake')
external JSAny createIrisRtcEngineFake(JSAny irisApiEngine);

@JS('irisMock')
external void irisMock();

@JS('triggerEventWithFakeApiEngine')
external int triggerEventWithFakeApiEngine(
  // ignore: non_constant_identifier_names
  String func_name,
  EventParam parameters,
);
