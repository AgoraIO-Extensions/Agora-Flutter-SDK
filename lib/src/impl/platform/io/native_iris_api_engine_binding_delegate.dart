import 'dart:convert';
import 'dart:io';
import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import 'native_iris_api_engine_bindings.dart' as bindings;
import 'package:iris_method_channel/iris_method_channel.dart';
import 'package:iris_method_channel/iris_method_channel_bindings_io.dart'
    as iris_bindings;

// ignore_for_file: public_member_api_docs

const _libName = 'AgoraRtcWrapper';

const _doNotInterceptCall = -1000000;

ffi.DynamicLibrary _loadLib() {
  if (Platform.isWindows) {
    return ffi.DynamicLibrary.open('$_libName.dll');
  }

  if (Platform.isAndroid) {
    return ffi.DynamicLibrary.open("lib$_libName.so");
  }

  return ffi.DynamicLibrary.process();
}

class NativeIrisApiEngineBindingsDelegate
    extends PlatformBindingsDelegateInterface {
  late final bindings.NativeIrisApiEngineBinding _binding;
  bindings.NativeIrisApiEngineBinding get binding => _binding;

  @override
  void initialize() {
    _binding = bindings.NativeIrisApiEngineBinding(_loadLib());
    _binding.enableUseJsonArray(1);
  }

  @override
  CreateApiEngineResult createApiEngine(List<InitilizationArgProvider> args) {
    ffi.Pointer<ffi.Void> enginePtr = ffi.nullptr;
    if (args.isNotEmpty) {
      assert(args.length == 1);
      final engineIntPtr =
          args[0].provide(const IrisApiEngineHandle(0))() as int;
      if (engineIntPtr != 0) {
        enginePtr = ffi.Pointer<ffi.Void>.fromAddress(engineIntPtr);
      }
    }

    final apiEnginePtr = _binding.CreateIrisApiEngine(enginePtr);

    return CreateApiEngineResult(IrisApiEngineHandle(apiEnginePtr));
  }

  void _response(
      ffi.Pointer<iris_bindings.ApiParam> param, Map<String, Object> result) {
    using<void>((Arena arena) {
      final ffi.Pointer<Utf8> resultMapPointerUtf8 =
          jsonEncode(result).toNativeUtf8(allocator: arena);
      final ffi.Pointer<ffi.Int8> resultMapPointerInt8 =
          resultMapPointerUtf8.cast();

      for (int i = 0; i < kBasicResultLength; i++) {
        if (i >= resultMapPointerUtf8.length) {
          break;
        }

        param.ref.result[i] = resultMapPointerInt8[i];
      }
    });
  }

  /// The value of `methoCall.funcName` should be same as the C function name
  int _interceptCall(
    IrisMethodCall methodCall,
    ffi.Pointer<ffi.Void> apiEnginePtr,
    ffi.Pointer<iris_bindings.ApiParam> param,
  ) {
    switch (methodCall.funcName) {
      case 'StartDumpVideo':
        {
          final data = jsonDecode(methodCall.params);
          final videoFrameBufferManagerIntPtr = data['nativeHandle'];
          final type = data['type'];
          final dir = data['dir'];
          return _binding.StartDumpVideo(
              ffi.Pointer<ffi.Void>.fromAddress(videoFrameBufferManagerIntPtr),
              type,
              dir);
        }

      case 'StopDumpVideo':
        {
          final data = jsonDecode(methodCall.params);
          final videoFrameBufferManagerIntPtr = data['nativeHandle'];
          return _binding.StopDumpVideo(
              ffi.Pointer<ffi.Void>.fromAddress(videoFrameBufferManagerIntPtr));
        }
      case 'CreateIrisRtcRendering':
        {
          final data = jsonDecode(methodCall.params);
          assert(data.containsKey('irisRtcEngineNativeHandle'));
          final irisRtcEngineNativeHandle =
              data['irisRtcEngineNativeHandle'] as int;

          final bufferManager = _binding.CreateIrisRtcRendering(
              ffi.Pointer<ffi.Void>.fromAddress(irisRtcEngineNativeHandle));

          final result = {'irisRtcRenderingHandle': bufferManager.address};
          _response(param, result);

          return 0;
        }
      case 'FreeIrisRtcRendering':
        {
          final data = jsonDecode(methodCall.params);
          final videoFrameBufferManagerIntPtr =
              data['irisRtcRenderingHandle'] as int;
          _binding.FreeIrisRtcRendering(
              ffi.Pointer<ffi.Void>.fromAddress(videoFrameBufferManagerIntPtr));

          _response(param, {});

          return 0;
        }
      default:
        break;
    }
    return _doNotInterceptCall;
  }

  @override
  int callApi(
    IrisMethodCall methodCall,
    IrisApiEngineHandle apiEnginePtr,
    IrisApiParamHandle param,
  ) {
    final nApiEnginePtr = apiEnginePtr() as ffi.Pointer<ffi.Void>;
    final nParam = param() as ffi.Pointer<iris_bindings.ApiParam>;
    final interceptRet = _interceptCall(methodCall, nApiEnginePtr, nParam);
    if (interceptRet != _doNotInterceptCall) {
      return interceptRet;
    }

    return _binding.CallIrisApi(nApiEnginePtr, nParam.cast());
  }

  @override
  IrisEventHandlerHandle createIrisEventHandler(
    IrisCEventHandlerHandle eventHandler,
  ) {
    return IrisEventHandlerHandle(_binding.CreateIrisEventHandler(
        (eventHandler() as ffi.Pointer<iris_bindings.IrisCEventHandler>)
            .cast()));
  }

  @override
  void destroyIrisEventHandler(
    IrisEventHandlerHandle handler,
  ) {
    _binding.DestroyIrisEventHandler(handler() as ffi.Pointer<ffi.Void>);
  }

  @override
  void destroyNativeApiEngine(IrisApiEngineHandle apiEnginePtr) {
    _binding.DestroyIrisApiEngine(apiEnginePtr() as ffi.Pointer<ffi.Void>);
  }

  @override
  Future<CallApiResult> callApiAsync(IrisMethodCall methodCall,
      IrisApiEngineHandle apiEnginePtr, IrisApiParamHandle param) {
    throw UnsupportedError(
        '`callApiAsync` not support on native implementation.');
  }
}

class IrisApiEngineNativeBindingDelegateProvider
    extends PlatformBindingsProvider {
  @override
  PlatformBindingsDelegateInterface provideNativeBindingDelegate() {
    return NativeIrisApiEngineBindingsDelegate();
  }
}
