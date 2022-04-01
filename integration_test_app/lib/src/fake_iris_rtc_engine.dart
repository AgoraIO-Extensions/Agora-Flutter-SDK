import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

typedef SetIrisRtcEngineCallApiRecorderNative = Pointer<NativeType> Function(
  Pointer<NativeType> enginePtr,
  Int32 isMockChannel,
  // Pointer<IrisCCallApiCallbackNative> callApiCallback,
);
typedef SetIrisRtcEngineCallApiRecorder = Pointer<NativeType> Function(
  Pointer<NativeType> enginePtr,
  int isMockChannel,
  // Pointer<IrisCCallApiCallbackNative> callApiCallback,
);

typedef ClearCallApiRecorderNative = Void Function(
  Pointer<NativeType> callApiRecorderPtr,
);
typedef ClearCallApiRecorder = void Function(
  Pointer<NativeType> callApiRecorderPtr,
);

typedef MockCallApiResultNative = Void Function(
    Pointer<NativeType> callApiRecorderPtr,
    Uint32 apiType,
    Pointer<Utf8> params,
    Pointer<Utf8> mockResult);
typedef MockCallApiResult = void Function(
    Pointer<NativeType> callApiRecorderPtr,
    int apiType,
    Pointer<Utf8> params,
    Pointer<Utf8> mockResult);

typedef MockCallApiReturnCodeNative = Void Function(
    Pointer<NativeType> callApiRecorderPtr,
    Uint32 apiType,
    Pointer<Utf8> params,
    Int32 mockReturnCode);
typedef MockCallApiReturnCode = void Function(
    Pointer<NativeType> callApiRecorderPtr,
    int apiType,
    Pointer<Utf8> params,
    int mockReturnCode);

typedef SetExplicitBufferSizeNative = Void Function(
    Pointer<NativeType> callApiRecorderPtr,
    Uint32 apiType,
    Pointer<Utf8> params,
    Int32 bufferSize);
typedef SetExplicitBufferSize = void Function(
    Pointer<NativeType> callApiRecorderPtr,
    int apiType,
    Pointer<Utf8> params,
    int bufferSize);

typedef ExpectCalledApiNative = Int32 Function(
  Pointer<NativeType> callApiRecorderPtr,
  Uint32 apiType,
  Pointer<Utf8> params,
  Pointer<NativeType> buffer,
  Int32 bufferSize,
);
typedef ExpectCalledApi = int Function(
  Pointer<NativeType> callApiRecorderPtr,
  int apiType,
  Pointer<Utf8> params,
  Pointer<NativeType> buffer,
  int bufferSize,
);

// typedef SetIrisProxyEventHandlerNative = Pointer<NativeType> Function(
//   Pointer<NativeType> enginePtr,
//   Int32 isMockChannel,
// );
// typedef SetIrisProxyEventHandler = Pointer<NativeType> Function(
//   Pointer<NativeType> enginePtr,
//   int isMockChannel,
// );

// typedef DestroyIrisProxyEventHandlerNative = Void Function(
//   Pointer<NativeType> enginePtr,
//   Int32 isMockChannel,
//   Pointer<NativeType> irisProxyPtr,
// );
// typedef DestroyIrisProxyEventHandler = void Function(
//   Pointer<NativeType> enginePtr,
//   int isMockChannel,
//   Pointer<NativeType> irisProxyPtr,
// );

typedef CallIrisEventHandlerOnEventNative = Void Function(
  Pointer<NativeType> enginePtr,
  Int32 isMockChannel,
  Pointer<Utf8> event,
  Pointer<Utf8> data,
);
typedef CallIrisEventHandlerOnEvent = void Function(
  Pointer<NativeType> enginePtr,
  int isMockChannel,
  Pointer<Utf8> event,
  Pointer<Utf8> data,
);

typedef CallIrisEventHandlerOnEventWithBufferNative = Void Function(
  Pointer<NativeType> enginePtr,
  Int32 isMockChannel,
  Pointer<Utf8> event,
  Pointer<NativeType> data,
  Pointer<NativeType> buffer,
  Uint32 length,
);
typedef CallIrisEventHandlerOnEventWithBuffer = void Function(
  Pointer<NativeType> enginePtr,
  int isMockChannel,
  Pointer<Utf8> event,
  Pointer<NativeType> data,
  Pointer<NativeType> buffer,
  int length,
);

typedef CallRtcEngineEventNative = Void Function(
    Pointer<NativeType> enginePtr, Pointer<Utf8> eventName);
typedef CallRtcEngineEvent = void Function(
    Pointer<NativeType> enginePtr, Pointer<Utf8> eventName);

typedef CallRtcChannelEventNative = Void Function(
    Pointer<NativeType> enginePtr, Pointer<Utf8> eventName);
typedef CallRtcChannelEvent = void Function(
    Pointer<NativeType> enginePtr, Pointer<Utf8> eventName);

class _NativeIrisProxyBinding {
  _NativeIrisProxyBinding(int irisRtcEngineIntPtr) {
    _agoraRtcWrapperLib = _loadAgoraRtcWrapperLib();
    _irisRtcEnginePtr = _getIrisRtcEnginePtr(
      _agoraRtcWrapperLib,
      irisRtcEngineIntPtr,
    );
  }

  // static const int _callApiExceptionalReturn = -1;

  late final DynamicLibrary _agoraRtcWrapperLib;

  late final Pointer<NativeType> _irisRtcEnginePtr;

  late final Pointer<NativeType> _callApiRecorderPtr;

  // late final Pointer<NativeType> _irisEventHandlerPtr;

  // static IrisCallApiCallback? _irisCallApiCallback;

  static DynamicLibrary _loadAgoraRtcWrapperLib() {
    if (Platform.isWindows) {
      return DynamicLibrary.open('iris_integration_test.dll');
    }
    return Platform.isAndroid
        ? DynamicLibrary.open("libiris_integration_test.so")
        : DynamicLibrary.process();
  }

  static Pointer<NativeType> _getIrisRtcEnginePtr(
      DynamicLibrary agoraRtcWrapperLib, int irisRtcEngineIntPtr) {
    return Pointer.fromAddress(irisRtcEngineIntPtr);
  }

  void setIrisRtcEngineCallApiRecorder(bool isMockChannel) {
    // _irisCallApiCallback = irisCallApiCallback;

    final fp = _agoraRtcWrapperLib.lookupFunction<
        SetIrisRtcEngineCallApiRecorderNative,
        SetIrisRtcEngineCallApiRecorder>('SetIrisRtcEngineCallApiRecorder');

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

    _callApiRecorderPtr = fp(_irisRtcEnginePtr, isMockChannel ? 1 : 0);
  }

  void callIrisProxyEventHandlerOnEvent(
    bool isMockChannel,
    String event,
    String data,
  ) {
    final fp = _agoraRtcWrapperLib.lookupFunction<
        CallIrisEventHandlerOnEventNative,
        CallIrisEventHandlerOnEvent>('CallIrisEventHandlerOnEvent');
    final eventN = event.toNativeUtf8();
    final dataN = data.toNativeUtf8();
    fp(_irisRtcEnginePtr, isMockChannel ? 1 : 0, eventN, dataN);

    // calloc.free(eventN);
    // calloc.free(dataN);
  }

  void callIrisProxyEventHandlerOnEventWithBuffer(
    bool isMockChannel,
    String event,
    String data,
    Uint8List buffer,
    int bufferSize,
  ) {
    final fp = _agoraRtcWrapperLib.lookupFunction<
            CallIrisEventHandlerOnEventWithBufferNative,
            CallIrisEventHandlerOnEventWithBuffer>(
        'CallIrisEventHandlerOnEventWithBuffer');
    final eventN = event.toNativeUtf8();
    final dataN = data.toNativeUtf8();
    // final bufferN = calloc.allocate<Uint8>(bufferSize);

    final Pointer<Uint8> bufferN = calloc.allocate<Uint8>(buffer.length);
    final pointerList = bufferN.asTypedList(buffer.length);
    pointerList.setAll(0, buffer);

    fp(_irisRtcEnginePtr, isMockChannel ? 1 : 0, eventN, dataN, bufferN,
        bufferSize);

    // calloc.free(eventN);
    // calloc.free(dataN);
    // calloc.free(bufferN);
  }

  void clearCallApiRecorder() {
    final fp = _agoraRtcWrapperLib.lookupFunction<ClearCallApiRecorderNative,
        ClearCallApiRecorder>('ClearCallApiRecorder');
    fp(_callApiRecorderPtr);
  }

  // Pointer<ApiCallQueueNative> getIrisProxyApiCallQueue() {
  //   final fp = _agoraRtcWrapperLib.lookupFunction<
  //       GetIrisProxyApiCallQueueNative,
  //       GetIrisProxyApiCallQueueNative>('GetIrisProxyApiCallQueue');
  //   final p = fp(_irisProxyPtr);

  //   return p;
  // }

  void mockCallApiResult(
    int apiType,
    String params,
    String mockResult,
  ) {
    final fp = _agoraRtcWrapperLib.lookupFunction<MockCallApiResultNative,
        MockCallApiResult>('MockCallApiResult');
    final paramsN = params.toNativeUtf8();
    final mockResultN = mockResult.toNativeUtf8();
    fp(_callApiRecorderPtr, apiType, paramsN, mockResultN);

    calloc.free(paramsN);
    calloc.free(mockResultN);
  }

  void mockCallApiReturnCode(
    int apiType,
    String params,
    int mockReturnCode,
  ) {
    final fp = _agoraRtcWrapperLib.lookupFunction<MockCallApiReturnCodeNative,
        MockCallApiReturnCode>('MockCallApiReturnCode');
    final paramsN = params.toNativeUtf8();

    fp(_callApiRecorderPtr, apiType, paramsN, mockReturnCode);

    calloc.free(paramsN);
  }

  void setExplicitBufferSize(
    int apiType,
    String params,
    int bufferSize,
  ) {
    final fp = _agoraRtcWrapperLib.lookupFunction<SetExplicitBufferSizeNative,
        SetExplicitBufferSize>('SetExplicitBufferSize');
    final paramsN = params.toNativeUtf8();

    fp(_callApiRecorderPtr, apiType, paramsN, bufferSize);

    calloc.free(paramsN);
  }

  bool expectCalledApi(
    int apiType,
    String params, {
    Uint8List? buffer,
    int bufferSize = 0,
  }) {
    final fp = _agoraRtcWrapperLib.lookupFunction<ExpectCalledApiNative,
        ExpectCalledApi>('ExpectCalledApi');
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

    final ret = fp(_callApiRecorderPtr, apiType, paramsN, bufferN, bufferSize);

    calloc.free(paramsN);
    calloc.free(bufferN);
    return ret == 1;
  }

  // void setIrisProxyEventHandler(bool isMockChannel) {
  //   final fp = _agoraRtcWrapperLib.lookupFunction<
  //       SetIrisProxyEventHandlerNative,
  //       SetIrisProxyEventHandler>('SetIrisProxyEventHandler');

  //   _irisEventHandlerPtr = fp(_irisRtcEnginePtr, isMockChannel ? 1 : 0);
  // }

  // void destroyIrisProxyEventHandler(bool isMockChannel) {
  //   final fp = _agoraRtcWrapperLib.lookupFunction<
  //       DestroyIrisProxyEventHandlerNative,
  //       DestroyIrisProxyEventHandler>('DestroyIrisProxyEventHandler');
  //   fp(
  //     _irisRtcEnginePtr,
  //     isMockChannel ? 1 : 0,
  //     _callApiRecorderPtr,
  //   );
  // }

  void callRtcEngineEvent(String event) {
    final fp = _agoraRtcWrapperLib.lookupFunction<CallRtcEngineEventNative,
        CallRtcEngineEvent>('CallRtcEngineEvents');
    final pN = event.toNativeUtf8();
    fp(_irisRtcEnginePtr, pN);
    // calloc.free(pN);
  }

  void callRtcChannelEvent(String event) {
    final fp = _agoraRtcWrapperLib.lookupFunction<CallRtcChannelEventNative,
        CallRtcChannelEvent>('CallRtcChannelEvents');
    final pN = event.toNativeUtf8();
    fp(_irisRtcEnginePtr, pN);
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
  FakeIrisRtcEngine({
    bool isMockChannel = false,
    bool isSubProcess = false,
  })  : _isMockChannel = isMockChannel,
        _isSubProcess = isSubProcess;

  final bool _isMockChannel;
  final bool _isSubProcess;
  late final int _irisRtcEngineIntPtr;
  late final _NativeIrisProxyBinding _nativeIrisProxyBinding;
  final MethodChannel _methodChannel = const MethodChannel('agora_rtc_engine');
  // final List<ApiCall> _callApiQueue = [];

  Future<void> _initialize() async {
    _irisRtcEngineIntPtr = await _methodChannel
        .invokeMethod('getIrisRtcEngineIntPtr', {'subProcess': _isSubProcess});
    _nativeIrisProxyBinding = _NativeIrisProxyBinding(_irisRtcEngineIntPtr);
  }

  Future<void> initialize({bool getIrisRtcEngineIntPtrOnly = false}) async {
    await _initialize();
    if (!getIrisRtcEngineIntPtrOnly) {
      _nativeIrisProxyBinding.setIrisRtcEngineCallApiRecorder(_isMockChannel);
    }
  }

  void fireEvent(
    String event,
    String data, {
    Uint8List? buffer,
    int bufferSize = 0,
  }) {
    if (buffer == null) {
      _nativeIrisProxyBinding.callIrisProxyEventHandlerOnEvent(
          _isMockChannel, event, data);
    } else {
      _nativeIrisProxyBinding.callIrisProxyEventHandlerOnEventWithBuffer(
          _isMockChannel, event, data, buffer, bufferSize);
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
    _nativeIrisProxyBinding.clearCallApiRecorder();
  }

  // List<ApiCallNative> _getCallApiQueue() {
  //   final queueN = _nativeIrisProxyBinding.getIrisProxyApiCallQueue();

  //   final queue = queueN.ref.apiCallQueue;
  //   final len = queueN.ref.len;

  //   final output = <ApiCallNative>[];
  //   for (int i = 0; i < len; i++) {
  //     output.add(queue[i]);
  //   }

  //   return output;
  // }

  bool calledApi(
    int apiType,
    String params, {
    Uint8List? buffer,
    int bufferSize = 0,
  }) {
    return _nativeIrisProxyBinding.expectCalledApi(
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
    _nativeIrisProxyBinding.mockCallApiResult(
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
    _nativeIrisProxyBinding.mockCallApiReturnCode(
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
    _nativeIrisProxyBinding.setExplicitBufferSize(
      apiType,
      params,
      bufferSize,
    );
  }

  // Future<void> initForCallApiTest() async {
  //   await _initialize();
  //   _nativeIrisProxyBinding.setIrisRtcEngineCallApiRecorder(
  //     _isMockChannel,
  //   );
  // }

  // void disposeForCallApiTest() {
  //   _nativeIrisProxyBinding.clearCallApiRecorder(_isMockChannel);
  // }

  // Future<void> initForEventHandlerTest() async {
  //   await initialize();
  //   _nativeIrisProxyBinding.setIrisProxyEventHandler(_isMockChannel);
  // }

  // void disposeForEventHandlerTest() {
  //   _nativeIrisProxyBinding.destroyIrisProxyEventHandler(_isMockChannel);
  // }

  void fireAllEngineEvents() {
    _nativeIrisProxyBinding.callRtcEngineEvent('');
  }

  void fireRtcEngineEvent(String event) {
    _nativeIrisProxyBinding.callRtcEngineEvent(event);
  }

  void fireAllChannelEvents() {
    _nativeIrisProxyBinding.callRtcChannelEvent('');
  }

  void fireRtcChannelEvent(String event) {
    _nativeIrisProxyBinding.callRtcChannelEvent(event);
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
