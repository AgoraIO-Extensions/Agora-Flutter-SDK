@JS()
library iris_tester_web;

import 'dart:js_interop';
import 'dart:typed_data';

// ignore_for_file: non_constant_identifier_names

JSAny _eventParamBufferEntryToJS(Object value) {
  if (value is Uint8List) {
    return value.toJS;
  }
  if (value is int) {
    return value.toJS;
  }
  if (value is double) {
    return value.toJS;
  }
  if (value is String) {
    return value.toJS;
  }
  if (value is bool) {
    return value.toJS;
  }
  return value as JSObject;
}

/// Copy of the one define in the `iris_method_channel`
@JS('IrisCore.EventParam')
@anonymous
@staticInterop
class EventParam {
  factory EventParam({
    String event = '',
    String data = '',
    int data_size = 0,
    String result = '',
    List<Object> buffer = const [],
    List<int> length = const [],
    int buffer_count = 0,
  }) =>
      EventParam._(
        event: event,
        data: data,
        data_size: data_size,
        result: result,
        buffer: buffer.map(_eventParamBufferEntryToJS).toList().toJS,
        length: length.map((value) => value.toJS).toList().toJS,
        buffer_count: buffer_count,
      );

  external factory EventParam._({
    String event,
    String data,
    int data_size,
    String result,
    JSArray<JSAny> buffer,
    JSArray<JSNumber> length,
    int buffer_count,
  });
}

@JS('createIrisRtcEngineFake')
external JSAny createIrisRtcEngineFake(JSAny irisApiEngine);

@JS('irisMock')
external void irisMock();

@JS('triggerEventWithFakeApiEngine')
external int triggerEventWithFakeApiEngine(
  String func_name,
  EventParam parameters,
);
