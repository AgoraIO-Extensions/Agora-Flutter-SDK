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
        options = InitIrisRtcOptions(irisRtcEngine: arg);
      }

      return true;
    }());
    initIrisRtc(apiEnginePtr, options);
    return CreateApiEngineResult(irisApiEngineHandle);
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
    final buffers = <Object>[
      ...?methodCall.buffers,
      ...?methodCall.rawBufferParams?.map((rb) => rb.intPtr()),
    ];
    final bufferLengths = <int>[
      ...?methodCall.buffers?.map((rb) => rb.length),
      ...?methodCall.rawBufferParams?.map((rb) => rb.length),
    ];

    final nParam = js.EventParam(
      event: methodCall.funcName,
      data: methodCall.params,
      data_size: methodCall.params.length,
      result: '',
      buffer: buffers,
      length: bufferLengths,
      buffer_count: buffers.length,
    );

    if (_skipCalls.contains(methodCall.funcName)) {
      debugPrint('[callApiAsync]: ${methodCall.funcName} is skipped.');
      return CallApiResult(irisReturnCode: 0, data: const {'result': 0});
    }

    final irisReturnCode = js.callIrisApi(nApiEnginePtr, nParam);

    return CallApiResult(
      irisReturnCode: irisReturnCode,
      data: jsonDecode(nParam.result),
      rawData: nParam.result,
    );
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
