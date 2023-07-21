import 'package:flutter/foundation.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

class FakeIrisMethodChannelConfig {
  const FakeIrisMethodChannelConfig({
    this.isFakeInitilize = true,
    this.isFakeInvokeMethod = true,
    this.isFakeGetNativeHandle = true,
    this.isFakeAddHotRestartListener = true,
    this.isFakeRemoveHotRestartListener = true,
    this.isFakeDispose = true,
    this.delayInvokeMethod = const {},
  });

  final bool isFakeInitilize;
  final bool isFakeInvokeMethod;
  final bool isFakeGetNativeHandle;
  final bool isFakeAddHotRestartListener;
  final bool isFakeRemoveHotRestartListener;
  final bool isFakeDispose;
  final Map<String, int> delayInvokeMethod;

  FakeIrisMethodChannelConfig copyWith({
    bool? isFakeInitilize,
    bool? isFakeInvokeMethod,
    bool? isFakeGetNativeHandle,
    bool? isFakeAddHotRestartListener,
    bool? isFakeRemoveHotRestartListener,
    bool? isFakeDispose,
    Map<String, int>? delayInvokeMethod,
  }) {
    return FakeIrisMethodChannelConfig(
      isFakeInitilize: isFakeInitilize ?? this.isFakeInitilize,
      isFakeInvokeMethod: isFakeInvokeMethod ?? this.isFakeInvokeMethod,
      isFakeGetNativeHandle:
          isFakeGetNativeHandle ?? this.isFakeGetNativeHandle,
      isFakeAddHotRestartListener:
          isFakeAddHotRestartListener ?? this.isFakeAddHotRestartListener,
      isFakeRemoveHotRestartListener:
          isFakeRemoveHotRestartListener ?? this.isFakeRemoveHotRestartListener,
      isFakeDispose: isFakeDispose ?? this.isFakeDispose,
      delayInvokeMethod: delayInvokeMethod ?? this.delayInvokeMethod,
    );
  }
}

class FakeIrisMethodChannel extends IrisMethodChannel {
  FakeIrisMethodChannel(NativeBindingsProvider provider) : super(provider);
  final List<IrisMethodCall> methodCallQueue = [];

  FakeIrisMethodChannelConfig _config = const FakeIrisMethodChannelConfig();
  FakeIrisMethodChannelConfig get config => _config;
  set config(FakeIrisMethodChannelConfig value) {
    _config = value;
  }

  @override
  Future<InitilizationResult?> initilize(List<int> args) async {
    if (_config.isFakeInitilize) {
      return null;
    }

    return super.initilize(args);
  }

  @override
  Future<CallApiResult> invokeMethod(IrisMethodCall methodCall) async {
    methodCallQueue.add(methodCall);

    Future<void> __maybeDelay() async {
      if (_config.delayInvokeMethod.containsKey(methodCall.funcName)) {
        await Future.delayed(Duration(
            milliseconds: _config.delayInvokeMethod[methodCall.funcName]!));
      }
    }

    if (_config.isFakeInvokeMethod) {
      await __maybeDelay();
      return CallApiResult(data: {'result': 0}, irisReturnCode: 0);
    }


    await __maybeDelay();
    final res = super.invokeMethod(methodCall);
    return res;
  }

  @override
  int getNativeHandle() {
    if (_config.isFakeGetNativeHandle) {
      return 100;
    }
    return super.getNativeHandle();
  }

  @override
  VoidCallback addHotRestartListener(HotRestartListener listener) {
    if (_config.isFakeAddHotRestartListener) {
      return () {};
    }

    return super.addHotRestartListener(listener);
  }

  @override
  void removeHotRestartListener(HotRestartListener listener) {
    if (_config.isFakeRemoveHotRestartListener) {
      return;
    }

    super.removeHotRestartListener(listener);
  }

  @override
  Future<void> dispose() async {
    if (_config.isFakeDispose) {
      return;
    }

    return super.dispose();
  }

  void reset() {
    _config = const FakeIrisMethodChannelConfig();
    methodCallQueue.clear();
  }
}
