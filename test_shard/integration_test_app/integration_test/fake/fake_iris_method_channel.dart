import 'package:flutter/foundation.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

class FakeIrisMethodChannel extends IrisMethodChannel {
  FakeIrisMethodChannel(NativeBindingsProvider provider) : super(provider);
  final List<IrisMethodCall> methodCallQueue = [];

  @override
  Future<InitilizationResult?> initilize(List<int> args) async {
    return null;
  }

  @override
  Future<CallApiResult> invokeMethod(IrisMethodCall methodCall) async {
    methodCallQueue.add(methodCall);
    return CallApiResult(data: {'result': 0}, irisReturnCode: 0);
  }

  @override
  int getNativeHandle() {
    return 100;
  }

  @override
  VoidCallback addHotRestartListener(HotRestartListener listener) {
    return () {};
  }

  @override
  void removeHotRestartListener(HotRestartListener listener) {}

  @override
  Future<void> dispose() async {}

  void reset() {
    methodCallQueue.clear();
  }
}
