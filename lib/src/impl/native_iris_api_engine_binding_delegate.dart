import 'dart:convert';
import 'dart:io';
import 'dart:ffi' as ffi;

import 'native_iris_api_engine_bindings.dart' as bindings;
import 'package:iris_method_channel/iris_method_channel.dart';

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

class NativeIrisApiEngineBindingsDelegate extends NativeBindingDelegate {
  late final bindings.NativeIrisApiEngineBinding _binding;

  @override
  void initialize() {
    _binding = bindings.NativeIrisApiEngineBinding(_loadLib());
    _binding.enableUseJsonArray(1);
  }

  @override
  ffi.Pointer<ffi.Void> createNativeApiEngine(
      List<ffi.Pointer<ffi.Void>>? args) {
    ffi.Pointer<ffi.Void> enginePtr = ffi.nullptr;
    assert(() {
      if (args != null && args.isNotEmpty) {
        assert(args.length == 1);
        enginePtr = args[0];
      }
      return true;
    }());

    return _binding.CreateIrisApiEngine(enginePtr);
  }

  int _interceptCall(
    IrisMethodCall methodCall,
    ffi.Pointer<ffi.Void> apiEnginePtr,
    ffi.Pointer<ApiParam> param,
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
      default:
        break;
    }
    return _doNotInterceptCall;
  }

  @override
  int callApi(
    IrisMethodCall methodCall,
    ffi.Pointer<ffi.Void> apiEnginePtr,
    ffi.Pointer<ApiParam> param,
  ) {
    final interceptRet = _interceptCall(methodCall, apiEnginePtr, param);
    if (interceptRet != _doNotInterceptCall) {
      return interceptRet;
    }

    return _binding.CallIrisApi(apiEnginePtr, param.cast());
  }

  @override
  ffi.Pointer<ffi.Void> createIrisEventHandler(
    ffi.Pointer<IrisCEventHandler> eventHandler,
  ) {
    return _binding.CreateIrisEventHandler(eventHandler.cast());
  }

  @override
  void destroyIrisEventHandler(
    ffi.Pointer<ffi.Void> handler,
  ) {
    _binding.DestroyIrisEventHandler(handler);
  }

  @override
  void destroyNativeApiEngine(ffi.Pointer<ffi.Void> apiEnginePtr) {
    _binding.DestroyIrisApiEngine(apiEnginePtr);
  }
}

class IrisApiEngineNativeBindingDelegateProvider
    implements NativeBindingDelegateProvider {
  @override
  NativeBindingDelegate provide() {
    return NativeIrisApiEngineBindingsDelegate();
  }
}
