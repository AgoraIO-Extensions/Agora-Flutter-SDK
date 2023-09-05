// ignore: avoid_web_libraries_in_flutter
import 'dart:js_util';

import 'package:agora_rtc_engine/src/binding_forward_export.dart';
import 'package:iris_method_channel/iris_method_channel.dart';
import 'package:iris_method_channel/iris_method_channel_bindings_web.dart'
    as js;

// ignore_for_file: public_member_api_docs

class IrisApiEngineBindingsDelegateJS
    extends PlatformBindingsDelegateInterface {
  @override
  void initialize() {}

  @override
  CreateApiEngineResult createApiEngine(List<Object> args) {
    final apiEnginePtr = js.CreateIrisApiEngine();

    return CreateApiEngineResult(IrisApiEngineHandle(apiEnginePtr));
  }

  static const _skipCalls = ['CreateIrisRtcRendering'];

  @override
  int callApi(
    IrisMethodCall methodCall,
    IrisApiEngineHandle apiEnginePtr,
    IrisApiParamHandle param,
  ) {
    throw UnimplementedError('Sync call of `callApi` is not supported on js');
  }

  @override
  Future<CallApiResult> callApiAsync(
    IrisMethodCall methodCall,
    IrisApiEngineHandle apiEnginePtr,
    IrisApiParamHandle param,
  ) async {
    final nApiEnginePtr = apiEnginePtr() as js.IrisApiEngine;

    final nParam = js.EventParam(
      event: methodCall.funcName,
      data: methodCall.params,
      data_size: methodCall.params.length,
      result: '',
      buffer: [],
      length: [],
      buffer_count: 0,
    );

    if (_skipCalls.contains(methodCall.funcName)) {
      debugPrint('[callApiAsync]: ${methodCall.funcName} is skipped.');
      return CallApiResult(irisReturnCode: 0, data: {'result': 0});
    }

    final promiseFuture =
        promiseToFuture(js.CallIrisApiAsync(nApiEnginePtr, nParam));

    final js.CallIrisApiResult irisApiResult = await promiseFuture;

    return irisApiResult.toCallApiResult();
  }

  @override
  IrisEventHandlerHandle createIrisEventHandler(
    IrisCEventHandlerHandle eventHandler,
  ) {
    return IrisEventHandlerHandle(
        js.CreateIrisEventHandler(eventHandler() as js.IrisCEventHandler));
  }

  @override
  void destroyIrisEventHandler(
    IrisEventHandlerHandle handler,
  ) {}

  @override
  void destroyNativeApiEngine(IrisApiEngineHandle apiEnginePtr) {
    js.DestroyIrisApiEngine(apiEnginePtr() as js.IrisApiEngine);
  }
}

class IrisApiEngineNativeBindingDelegateProviderWeb
    extends PlatformBindingsProvider {
  @override
  PlatformBindingsDelegateInterface provideNativeBindingDelegate() {
    return IrisApiEngineBindingsDelegateJS();
  }
}
