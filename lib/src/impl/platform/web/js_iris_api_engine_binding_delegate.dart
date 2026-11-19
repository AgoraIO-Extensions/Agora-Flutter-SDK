// ignore: avoid_web_libraries_in_flutter
import 'dart:js_interop';

import '/src/binding_forward_export.dart';
import '/src/impl/platform/web/iris_web_rtc_bindings_js.dart';
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
        options = InitIrisRtcOptions(irisRtcEngine: arg as JSAny?);
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

    // The binding's array members are `JSArray` (required for dart2wasm,
    // where Dart lists are not JS arrays), so convert each element here.
    final buffer = <JSAny?>[];
    final lenOfBuffer = <JSNumber>[];
    int bufferCount = 0;
    if (methodCall.buffers != null) {
      bufferCount += methodCall.buffers!.length;
      for (final rb in methodCall.buffers!) {
        buffer.add(rb.toJS);
        lenOfBuffer.add(rb.length.toJS);
      }
    }
    if (methodCall.rawBufferParams != null) {
      bufferCount += methodCall.rawBufferParams!.length;
      for (final rb in methodCall.rawBufferParams!) {
        buffer.add(rb.intPtr() as JSAny?);
        lenOfBuffer.add(rb.length.toJS);
      }
    }

    final nParam = js.EventParam(
      event: methodCall.funcName,
      data: methodCall.params,
      data_size: methodCall.params.length,
      result: '',
      buffer: buffer.toJS,
      length: lenOfBuffer.toJS,
      buffer_count: bufferCount,
    );

    if (_skipCalls.contains(methodCall.funcName)) {
      debugPrint('[callApiAsync]: ${methodCall.funcName} is skipped.');
      return CallApiResult(irisReturnCode: 0, data: const {'result': 0});
    }

    final js.CallIrisApiResult irisApiResult =
        await js.callIrisApi(nApiEnginePtr, nParam).toDart;

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
