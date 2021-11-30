import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class ApiCallNative extends Struct {
  @Uint32()
  external int apiType;
  external Pointer<Utf8> params;
  // external Pointer<Utf8> result;
  external Pointer<NativeType> buffer;
  @Int32()
  external int bufferSize;
}

class ApiCallQueueNative extends Struct {
  external Pointer<ApiCallNative> apiCallQueue;
  @Int32()
  external int len;
}

typedef OnCallApi = int Function(int apiType, String params, String result);
typedef OnCallApiWithBuffer = int Function(
  int apiType,
  String params,
  Pointer<NativeType> buffer,
  String result,
);

class IrisCallApiCallback {
  IrisCallApiCallback({this.onCallApi, this.onCallApiWithBuffer});
  final OnCallApi? onCallApi;
  final OnCallApiWithBuffer? onCallApiWithBuffer;
}

typedef CallApiNative = Int32 Function(
  Uint32 apiType,
  Pointer<Utf8> params,
  Pointer<Utf8> result,
);

typedef CallApiWithBufferNative = Int32 Function(
  Uint32 apiType,
  Pointer<Utf8> params,
  Pointer<NativeType> buffer,
  Pointer<Utf8> result,
);

class IrisCCallApiCallbackNative extends Struct {
  external Pointer<NativeFunction<CallApiNative>> onCallApi;
  external Pointer<NativeFunction<CallApiWithBufferNative>> onCallApiWithBuffer;
}

typedef GetIrisRtcEngineFromAndroidNativeHandleNative = Pointer<NativeType>
    Function(Pointer<NativeType> androidIrisEngineNativeHandle);
typedef GetIrisRtcEngineFromAndroidNativeHandle = Pointer<NativeType> Function(
    Pointer<NativeType> androidIrisEngineNativeHandle);

typedef SetIrisProxyCallApiNative = Pointer<NativeType> Function(
  Pointer<NativeType> enginePtr,
  Int32 isMockChannel,
  // Pointer<IrisCCallApiCallbackNative> callApiCallback,
);
typedef SetIrisProxyCallApi = Pointer<NativeType> Function(
  Pointer<NativeType> enginePtr,
  int isMockChannel,
  // Pointer<IrisCCallApiCallbackNative> callApiCallback,
);

typedef CallIrisProxyEventHandlerOnEventNative = Void Function(
  Pointer<NativeType> irisProxyPtr,
  Pointer<Utf8> event,
  Pointer<Utf8> data,
);
typedef CallIrisProxyEventHandlerOnEvent = void Function(
  Pointer<NativeType> irisProxyPtr,
  Pointer<Utf8> event,
  Pointer<Utf8> data,
);

typedef CallIrisProxyEventHandlerOnEventWithBufferNative = Void Function(
  Pointer<NativeType> irisProxyPtr,
  Pointer<Utf8> event,
  Pointer<NativeType> data,
  Pointer<NativeType> buffer,
  Uint32 length,
);
typedef CallIrisProxyEventHandlerOnEventWithBuffer = void Function(
  Pointer<NativeType> irisProxyPtr,
  Pointer<Utf8> event,
  Pointer<NativeType> data,
  Pointer<NativeType> buffer,
  int length,
);

typedef DestroyIrisProxyCallApiNative = Void Function(
  Pointer<NativeType> enginePtr,
  Int32 isMockChannel,
  Pointer<NativeType> irisProxyPtr,
);
typedef DestroyIrisProxyCallApi = void Function(
  Pointer<NativeType> enginePtr,
  int isMockChannel,
  Pointer<NativeType> irisProxyPtr,
);

typedef GetIrisProxyApiCallQueueNative = Pointer<ApiCallQueueNative> Function(
    Pointer<NativeType> irisProxyPtr);

typedef IrisProxyMockCallApiResultNative = Void Function(
    Pointer<NativeType> irisProxyPtr,
    Uint32 apiType,
    Pointer<Utf8> params,
    Pointer<Utf8> mockResult);
typedef IrisProxyMockCallApiResult = void Function(
    Pointer<NativeType> irisProxyPtr,
    int apiType,
    Pointer<Utf8> params,
    Pointer<Utf8> mockResult);

typedef IrisProxyMockCallApiReturnCodeNative = Void Function(
    Pointer<NativeType> irisProxyPtr,
    Uint32 apiType,
    Pointer<Utf8> params,
    Int32 mockReturnCode);
typedef IrisProxyMockCallApiReturnCode = void Function(
    Pointer<NativeType> irisProxyPtr,
    int apiType,
    Pointer<Utf8> params,
    int mockReturnCode);

typedef IrisProxySetExplicitBufferSizeNative = Void Function(
    Pointer<NativeType> irisProxyPtr,
    Uint32 apiType,
    Pointer<Utf8> params,
    Int32 bufferSize);
typedef IrisProxySetExplicitBufferSize = void Function(
    Pointer<NativeType> irisProxyPtr,
    int apiType,
    Pointer<Utf8> params,
    int bufferSize);

typedef IrisProxyExpectCalledApiNative = Int32 Function(
  Pointer<NativeType> irisProxyPtr,
  Uint32 apiType,
  Pointer<Utf8> params,
  Pointer<NativeType> buffer,
  Int32 bufferSize,
);
typedef IrisProxyExpectCalledApi = int Function(
  Pointer<NativeType> irisProxyPtr,
  int apiType,
  Pointer<Utf8> params,
  Pointer<NativeType> buffer,
  int bufferSize,
);

typedef SetIrisProxyEventHandlerNative = Pointer<NativeType> Function(
  Pointer<NativeType> enginePtr,
  Int32 isMockChannel,
);
typedef SetIrisProxyEventHandler = Pointer<NativeType> Function(
  Pointer<NativeType> enginePtr,
  int isMockChannel,
);

typedef DestroyIrisProxyEventHandlerNative = Void Function(
  Pointer<NativeType> enginePtr,
  Int32 isMockChannel,
  Pointer<NativeType> irisProxyPtr,
);
typedef DestroyIrisProxyEventHandler = void Function(
  Pointer<NativeType> enginePtr,
  int isMockChannel,
  Pointer<NativeType> irisProxyPtr,
);

class _NativeIrisProxyBinding {
  _NativeIrisProxyBinding(int irisRtcEngineIntPtr) {
    _agoraRtcWrapperLib = _loadAgoraRtcWrapperLib();
    _irisRtcEnginePtr = _getIrisRtcEnginePtr(
      _agoraRtcWrapperLib,
      irisRtcEngineIntPtr,
    );
  }

  static const int _callApiExceptionalReturn = -1;

  late final DynamicLibrary _agoraRtcWrapperLib;

  late final Pointer<NativeType> _irisRtcEnginePtr;

  late final Pointer<NativeType> _irisProxyPtr;

  static IrisCallApiCallback? _irisCallApiCallback;

  static DynamicLibrary _loadAgoraRtcWrapperLib() {
    return Platform.isAndroid
        ? DynamicLibrary.open("libAgoraRtcWrapper.so")
        : DynamicLibrary.process();
  }

  static Pointer<NativeType> _getIrisRtcEnginePtr(
      DynamicLibrary agoraRtcWrapperLib, int irisRtcEngineIntPtr) {
    if (!Platform.isAndroid) {
      return Pointer.fromAddress(irisRtcEngineIntPtr);
    }

    final fp = agoraRtcWrapperLib.lookupFunction<
            GetIrisRtcEngineFromAndroidNativeHandleNative,
            GetIrisRtcEngineFromAndroidNativeHandle>(
        'GetIrisRtcEngineFromAndroidNativeHandle');
    return fp(Pointer.fromAddress(irisRtcEngineIntPtr));
  }

  static int _onCallApiHandle(
      int apiType, Pointer<Utf8> param, Pointer<Utf8> result) {
    return _irisCallApiCallback?.onCallApi?.call(
          apiType,
          param.toDartString(),
          result.toDartString(),
        ) ??
        0;
  }

  static int _onCallApiWithBufferHandle(
    int apiType,
    Pointer<Utf8> param,
    Pointer<NativeType> buffer,
    Pointer<Utf8> result,
  ) {
    return _irisCallApiCallback?.onCallApiWithBuffer?.call(
          apiType,
          param.toDartString(),
          buffer,
          result.toDartString(),
        ) ??
        0;
  }

  void setIrisProxyCallApi(bool isMockChannel) {
    // _irisCallApiCallback = irisCallApiCallback;

    final fp = _agoraRtcWrapperLib.lookupFunction<SetIrisProxyCallApiNative,
        SetIrisProxyCallApi>('SetIrisProxyCallApi');

    // final Pointer<NativeFunction<CallApiNative>> onCallApiPtr =
    //     Pointer.fromFunction<CallApiNative>(
    //   _onCallApiHandle,
    //   _callApiExceptionalReturn,
    // );
    // final Pointer<NativeFunction<CallApiWithBufferNative>>
    //     onCallApiWithBufferPtr = Pointer.fromFunction<CallApiWithBufferNative>(
    //         _onCallApiWithBufferHandle, _callApiExceptionalReturn);

    // final callApiCallbackPtr = calloc<IrisCCallApiCallbackNative>()
    //   ..ref.onCallApi = onCallApiPtr
    //   ..ref.onCallApiWithBuffer = onCallApiWithBufferPtr;

    _irisProxyPtr = fp(_irisRtcEnginePtr, isMockChannel ? 1 : 0);
  }

  void callIrisProxyEventHandlerOnEvent(String event, String data) {
    final fp = _agoraRtcWrapperLib.lookupFunction<
        CallIrisProxyEventHandlerOnEventNative,
        CallIrisProxyEventHandlerOnEvent>('CallIrisProxyEventHandlerOnEvent');
    final eventN = event.toNativeUtf8();
    final dataN = data.toNativeUtf8();
    fp(_irisProxyPtr, eventN, dataN);

    // calloc.free(eventN);
    // calloc.free(dataN);
  }

  void callIrisProxyEventHandlerOnEventWithBuffer(
    String event,
    String data,
    Uint8List buffer,
    int bufferSize,
  ) {
    final fp = _agoraRtcWrapperLib.lookupFunction<
            CallIrisProxyEventHandlerOnEventWithBufferNative,
            CallIrisProxyEventHandlerOnEventWithBuffer>(
        'CallIrisProxyEventHandlerOnEventWithBuffer');
    final eventN = event.toNativeUtf8();
    final dataN = data.toNativeUtf8();
    // final bufferN = calloc.allocate<Uint8>(bufferSize);

    final Pointer<Uint8> bufferN = calloc.allocate<Uint8>(buffer.length);
    final pointerList = bufferN.asTypedList(buffer.length);
    pointerList.setAll(0, buffer);

    fp(_irisProxyPtr, eventN, dataN, bufferN, bufferSize);

    // calloc.free(eventN);
    // calloc.free(dataN);
    // calloc.free(bufferN);
  }

  void destroyIrisProxyCallApi(bool isMockChannel) {
    final fp = _agoraRtcWrapperLib.lookupFunction<DestroyIrisProxyCallApiNative,
        DestroyIrisProxyCallApi>('DestroyIrisProxyCallApi');
    fp(_irisRtcEnginePtr, isMockChannel ? 1 : 0, _irisProxyPtr);
  }

  Pointer<ApiCallQueueNative> getIrisProxyApiCallQueue() {
    final fp = _agoraRtcWrapperLib.lookupFunction<
        GetIrisProxyApiCallQueueNative,
        GetIrisProxyApiCallQueueNative>('GetIrisProxyApiCallQueue');
    final p = fp(_irisProxyPtr);

    return p;
  }

  void irisProxyMockCallApiResult(
    int apiType,
    String params,
    String mockResult,
  ) {
    final fp = _agoraRtcWrapperLib.lookupFunction<
        IrisProxyMockCallApiResultNative,
        IrisProxyMockCallApiResult>('IrisProxyMockCallApiResult');
    final paramsN = params.toNativeUtf8();
    final mockResultN = mockResult.toNativeUtf8();
    fp(_irisProxyPtr, apiType, paramsN, mockResultN);

    calloc.free(paramsN);
    calloc.free(mockResultN);
  }

  void irisProxyMockCallApiReturnCode(
    int apiType,
    String params,
    int mockReturnCode,
  ) {
    final fp = _agoraRtcWrapperLib.lookupFunction<
        IrisProxyMockCallApiReturnCodeNative,
        IrisProxyMockCallApiReturnCode>('IrisProxyMockCallApiReturnCode');
    final paramsN = params.toNativeUtf8();

    fp(_irisProxyPtr, apiType, paramsN, mockReturnCode);

    calloc.free(paramsN);
  }

  void irisProxySetExplicitBufferSize(
    int apiType,
    String params,
    int bufferSize,
  ) {
    final fp = _agoraRtcWrapperLib.lookupFunction<
        IrisProxySetExplicitBufferSizeNative,
        IrisProxySetExplicitBufferSize>('IrisProxySetExplicitBufferSize');
    final paramsN = params.toNativeUtf8();

    fp(_irisProxyPtr, apiType, paramsN, bufferSize);

    calloc.free(paramsN);
  }

  bool irisProxyExpectCalledApi(
    int apiType,
    String params, {
    Uint8List? buffer,
    int bufferSize = 0,
  }) {
    final fp = _agoraRtcWrapperLib.lookupFunction<
        IrisProxyExpectCalledApiNative,
        IrisProxyExpectCalledApi>('IrisProxyExpectCalledApi');
    final paramsN = params.toNativeUtf8();

// 'data' is a Uint8List created by concatenating the planes received from the CameraImage the camera puts out.
// Based on the code found here https://github.com/renancaraujo/bitmap/blob/master/lib/ffi.dart in the execute function
// https://groups.google.com/forum/#!searchin/dart-ffi/list%7Csort:date/dart-ffi/V_6g5hpABec/U9we6UyvBAAJ
    final Pointer<Uint8> bufferN;
    if (buffer != null) {
      bufferN = calloc.allocate<Uint8>(buffer.length);
      final pointerList = bufferN.asTypedList(buffer.length);
      pointerList.setAll(0, buffer);
    } else {
      bufferN = Pointer.fromAddress(0);
    }

    final ret = fp(_irisProxyPtr, apiType, paramsN, bufferN, bufferSize);

    calloc.free(paramsN);
    calloc.free(bufferN);
    return ret == 1;
  }

  void setIrisProxyEventHandler(bool isMockChannel) {
    final fp = _agoraRtcWrapperLib.lookupFunction<
        SetIrisProxyEventHandlerNative,
        SetIrisProxyEventHandler>('SetIrisProxyEventHandler');

    _irisProxyPtr = fp(_irisRtcEnginePtr, isMockChannel ? 1 : 0);
  }

  void destroyIrisProxyEventHandler(bool isMockChannel) {
    final fp = _agoraRtcWrapperLib.lookupFunction<
        DestroyIrisProxyEventHandlerNative,
        DestroyIrisProxyEventHandler>('DestroyIrisProxyEventHandler');
    fp(
      _irisRtcEnginePtr,
      isMockChannel ? 1 : 0,
      _irisProxyPtr,
    );
  }
}

class ApiCall {
  ApiCall({
    required this.apiType,
    required this.params,
    required this.result,
    this.buffer,
  });
  final int apiType;
  final String params;
  final String result;
  final Object? buffer;
}

class FakeIrisRtcEngine {
  FakeIrisRtcEngine({bool isMockChannel = false})
      : _isMockChannel = isMockChannel;

  final bool _isMockChannel;
  late final int _irisRtcEngineIntPtr;
  late final _NativeIrisProxyBinding _nativeIrisProxyBinding;
  final MethodChannel _methodChannel = const MethodChannel('agora_rtc_engine');
  // final List<ApiCall> _callApiQueue = [];

  Future<void> _initialize() async {
    _irisRtcEngineIntPtr =
        await _methodChannel.invokeMethod('getIrisRtcEngineIntPtr');
    _nativeIrisProxyBinding = _NativeIrisProxyBinding(_irisRtcEngineIntPtr);
  }

  Future<void> initialize() async {
    await _initialize();
    _nativeIrisProxyBinding.setIrisProxyCallApi(_isMockChannel
        // IrisCallApiCallback(
        //   onCallApi: (int apiType, String params, String result) {
        //     final apiCall = ApiCall(
        //       apiType: apiType,
        //       params: params,
        //       result: result,
        //     );
        //     // _callApiQueue.add(apiCall);
        //     return 0;
        //   },
        //   onCallApiWithBuffer: (
        //     int apiType,
        //     String params,
        //     Pointer<NativeType> buffer,
        //     String result,
        //   ) {
        //     final apiCall = ApiCall(
        //       apiType: apiType,
        //       params: params,
        //       result: result,
        //       buffer: buffer,
        //     );
        //     // _callApiQueue.add(apiCall);
        //     return 0;
        //   },
        // ),
        );
  }

  void fireEvent(
    String event,
    String data, {
    Uint8List? buffer,
    int bufferSize = 0,
  }) {
    if (buffer == null) {
      _nativeIrisProxyBinding.callIrisProxyEventHandlerOnEvent(event, data);
    } else {
      _nativeIrisProxyBinding.callIrisProxyEventHandlerOnEventWithBuffer(
          event, data, buffer, bufferSize);
    }
  }

  // void triggerEventWithBuffer(
  //   String event,
  //   String data,
  //   Object buffer,
  //   int length,
  // ) {
  //   _nativeIrisProxyBinding.callIrisProxyEventHandlerOnEventWithBuffer(
  //     event,
  //     data,
  //     buffer,
  //     length,
  //   );
  // }

  void dispose() {
    // _callApiQueue.clear();
    _nativeIrisProxyBinding.destroyIrisProxyCallApi(_isMockChannel);
  }

  List<ApiCallNative> _getCallApiQueue() {
    final queueN = _nativeIrisProxyBinding.getIrisProxyApiCallQueue();

    final queue = queueN.ref.apiCallQueue;
    final len = queueN.ref.len;

    final output = <ApiCallNative>[];
    for (int i = 0; i < len; i++) {
      output.add(queue[i]);
    }

    return output;
  }

  bool calledApi(
    int apiType,
    String params, {
    Uint8List? buffer,
    int bufferSize = 0,
  }) {
    return _nativeIrisProxyBinding.irisProxyExpectCalledApi(
      apiType,
      params,
      buffer: buffer,
      bufferSize: bufferSize,
    );
  }

  void mockCallApiResult(
    int apiType,
    String params,
    String mockResult,
  ) {
    _nativeIrisProxyBinding.irisProxyMockCallApiResult(
      apiType,
      params,
      mockResult,
    );
  }

  void mockCallApiReturnCode(
    int apiType,
    String params,
    int mockReturnCode,
  ) {
    _nativeIrisProxyBinding.irisProxyMockCallApiReturnCode(
      apiType,
      params,
      mockReturnCode,
    );
  }

  void setExplicitBufferSize(
    int apiType,
    String params,
    int bufferSize,
  ) {
    _nativeIrisProxyBinding.irisProxySetExplicitBufferSize(
      apiType,
      params,
      bufferSize,
    );
  }

  Future<void> initForCallApiTest() async {
    await _initialize();
    _nativeIrisProxyBinding.setIrisProxyCallApi(
      _isMockChannel,
    );
  }

  void disposeForCallApiTest() {
    _nativeIrisProxyBinding.destroyIrisProxyCallApi(_isMockChannel);
  }

  Future<void> initForEventHandlerTest() async {
    await _initialize();
    _nativeIrisProxyBinding.setIrisProxyEventHandler(_isMockChannel);
  }

  void disposeForEventHandlerTest() {
    _nativeIrisProxyBinding.destroyIrisProxyEventHandler(_isMockChannel);
  }
}

extension FakeIrisRtcEngineExt on FakeIrisRtcEngine {
  void expectCalledApi(
    int apiType,
    String params, {
    Uint8List? buffer,
    String result = '',
    int bufferSize = 0,
  }) {
    expect(
      calledApi(
        apiType,
        params,
        buffer: buffer,
        bufferSize: bufferSize,
      ),
      isTrue,
    );
  }

  Future<void> fireAndWaitEvent(
    WidgetTester tester,
    String event,
    String data, {
    Uint8List? buffer,
    int bufferSize = 0,
  }) async {
    fireEvent(
      event,
      data,
      buffer: buffer,
      bufferSize: bufferSize,
    );
    // // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));
  }
}
