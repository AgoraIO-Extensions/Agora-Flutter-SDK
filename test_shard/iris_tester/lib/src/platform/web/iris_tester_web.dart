// ignore: avoid_web_libraries_in_flutter
import 'dart:js_interop';

import 'dart:convert';

import 'package:iris_tester/src/platform/iris_tester_interface.dart';
import 'package:iris_tester/src/platform/web/iris_tester_bindings_web.dart'
    as bindings;

class IrisTesterWeb implements IrisTester {
  late Object _irisRtcEngineFake;

  bool isCreatedIrisRtcEngineFake = false;

  @override
  List<TesterArgsProvider> getTesterArgs() {
    return [_lazyCreateIrisRtcEngineFake];
  }

  Object _lazyCreateIrisRtcEngineFake(Object irisApiEngine) {
    if (isCreatedIrisRtcEngineFake) {
      return _irisRtcEngineFake;
    }

    isCreatedIrisRtcEngineFake = true;
    _irisRtcEngineFake = bindings.createIrisRtcEngineFake(irisApiEngine as JSAny);
    bindings.irisMock();

    return _irisRtcEngineFake;
  }

  @override
  void initialize() {}

  @override
  void dispose() {
    isCreatedIrisRtcEngineFake = false;
  }

  @override
  void expectCalled(String funcName, String params) {}

  @override
  bool fireEvent(String eventName, {Map params = const {}}) {
    final pJson = jsonEncode(params);
    final param = bindings.EventParam(
      event: eventName,
      data: pJson,
      dataSize: pJson.length,
      result: '',
      buffer: JSArray<JSAny?>(),
      length: JSArray<JSNumber>(),
      bufferCount: 0,
    );

    final ret = bindings.triggerEventWithFakeApiEngine(eventName, param);

    // TODO(littlegnal): Allow not supported calls at this time.
    return ret == 0 || ret == -4;
  }
}
