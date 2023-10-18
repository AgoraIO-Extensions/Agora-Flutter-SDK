// ignore: avoid_web_libraries_in_flutter
import 'dart:js_util';

import 'package:agora_rtc_engine/src/binding_forward_export.dart';
import 'package:agora_rtc_engine/src/impl/platform/web/iris_web_rtc_bindings_js.dart';
import 'package:iris_method_channel/iris_method_channel.dart';
import 'package:iris_method_channel/iris_method_channel_bindings_web.dart'
    as js;

// ignore_for_file: public_member_api_docs

class IrisApiEngineBindingsDelegateJS
    extends PlatformBindingsDelegateInterface {
  @override
  void initialize() {}

  @override
  CreateApiEngineResult createApiEngine(List<InitilizationArgProvider> args) {
    final apiEnginePtr = js.createIrisApiEngine();
    final irisApiEngineHandle = IrisApiEngineHandle(apiEnginePtr);
    InitIrisRtcOptions? options;
    // Only set the option in debug mode
    assert(() {
      if (args.isNotEmpty) {
        final arg = args[0].provide(irisApiEngineHandle)();
        options = InitIrisRtcOptions(irisRtcEngine: arg);
      }

      return true;
    }());
    initIrisRtc(apiEnginePtr, options);

    final res = CreateApiEngineResult(irisApiEngineHandle);

    return res;
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

    List<Object> buffer = [];
    List<int> lenOfBuffer = [];
    int bufferCount = 0;
    if (methodCall.buffers != null) {
      bufferCount += methodCall.buffers!.length;
      for (final rb in methodCall.buffers!) {
        buffer.add(rb);
        lenOfBuffer.add(rb.length);
      }
    }
    if (methodCall.rawBufferParams != null) {
      bufferCount += methodCall.rawBufferParams!.length;
      for (final rb in methodCall.rawBufferParams!) {
        buffer.add(rb.intPtr());
        lenOfBuffer.add(rb.length);
      }
    }

    final nParam = js.EventParam(
      event: methodCall.funcName,
      data: methodCall.params,
      data_size: methodCall.params.length,
      result: '',
      buffer: buffer,
      length: lenOfBuffer,
      buffer_count: bufferCount,
    );

    if (_skipCalls.contains(methodCall.funcName)) {
      debugPrint('[callApiAsync]: ${methodCall.funcName} is skipped.');
      return CallApiResult(irisReturnCode: 0, data: {'result': 0});
    }

    final promiseFuture =
        promiseToFuture(js.callIrisApi(nApiEnginePtr, nParam));

    final js.CallIrisApiResult irisApiResult = await promiseFuture;

    return irisApiResult.toCallApiResult();
  }

  @override
  IrisEventHandlerHandle createIrisEventHandler(
    IrisCEventHandlerHandle eventHandler,
  ) {
    return IrisEventHandlerHandle(
        js.createIrisEventHandler(eventHandler() as js.IrisCEventHandler));
  }

  @override
  void destroyIrisEventHandler(
    IrisEventHandlerHandle handler,
  ) {}

  @override
  void destroyNativeApiEngine(IrisApiEngineHandle apiEnginePtr) {
    js.disposeIrisApiEngine(apiEnginePtr() as js.IrisApiEngine);
  }
}

class IrisApiEngineNativeBindingDelegateProviderWeb
    extends PlatformBindingsProvider {
  @override
  PlatformBindingsDelegateInterface provideNativeBindingDelegate() {
    return IrisApiEngineBindingsDelegateJS();
  }
}
