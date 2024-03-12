@JS()
library iris_tester_web;

import 'package:js/js.dart';

/// Copy of the one define in the `iris_method_channel`
@JS('IrisCore.EventParam')
@anonymous
class EventParam {
  // Must have an unnamed factory constructor with named arguments.
  external factory EventParam({
    String event,
    String data,
    int data_size,
    String result,
    List<Object> buffer,
    List<int> length,
    int buffer_count,
  });

  external String get event;
  external String get data;
  external int get data_size;
  external String get result;
  external List<Object> get buffer;
  external List<int> get length;
  external int get buffer_count;
}

@JS('createIrisRtcEngineFake')
external Object createIrisRtcEngineFake(Object irisApiEngine);

@JS('irisMock')
external void irisMock();

@JS('triggerEventWithFakeApiEngine')
external int triggerEventWithFakeApiEngine(
  // ignore: non_constant_identifier_names
  String func_name,
  EventParam parameters,
);
