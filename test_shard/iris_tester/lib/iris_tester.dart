import 'dart:io';

import 'src/iris_tester_bindings.dart';
import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';

import 'package:flutter_test/flutter_test.dart';

const int kBasicResultLength = 64 * 1024;

ffi.DynamicLibrary _loadLib() {
  if (Platform.isWindows) {
    return ffi.DynamicLibrary.open('AgoraRtcWrapper.dll');
  }

  if (Platform.isAndroid) {
    return ffi.DynamicLibrary.open("libAgoraRtcWrapper.so");
  }

  return ffi.DynamicLibrary.process();
}

class IrisTester {
  IrisTester({NativeIrisTesterBinding? nativeIrisTesterBinding}) {
    _nativeIrisTesterBinding =
        nativeIrisTesterBinding ?? NativeIrisTesterBinding(_loadLib());
  }
  late final NativeIrisTesterBinding _nativeIrisTesterBinding;

  int createDebugApiEngine() {
    return _nativeIrisTesterBinding.CreateDebugApiEngine().address;
  }

  void expectCalled(String funcName, String params) {
    final isCalled = using<bool>((Arena arena) {
      final ffi.Pointer<ffi.Int8> resultPointer =
          arena.allocate<ffi.Int8>(kBasicResultLength).cast<ffi.Int8>();

      final ffi.Pointer<ffi.Int8> funcNamePointer =
          funcName.toNativeUtf8(allocator: arena).cast<ffi.Int8>();

      final ffi.Pointer<Utf8> paramsPointerUtf8 =
          params.toNativeUtf8(allocator: arena);
      final paramsPointerUtf8Length = paramsPointerUtf8.length;
      final ffi.Pointer<ffi.Int8> paramsPointer =
          paramsPointerUtf8.cast<ffi.Int8>();

      // ffi.Pointer<ffi.Void> bufferPointer;
      ffi.Pointer<ffi.Pointer<ffi.Void>> bufferListPtr = ffi.nullptr;

      return _nativeIrisTesterBinding.ExpectCalled(funcNamePointer,
              paramsPointer, paramsPointerUtf8Length, bufferListPtr, 0) ==
          1;
    });

    expect(isCalled, isTrue);
  }

  void fireEvent(String eventName) {
    using<void>((Arena arena) {
      final ffi.Pointer<ffi.Int8> eventNamePtr =
          eventName.toNativeUtf8(allocator: arena).cast<ffi.Int8>();

      _nativeIrisTesterBinding.FireEvent(eventNamePtr);
    });
  }
}
