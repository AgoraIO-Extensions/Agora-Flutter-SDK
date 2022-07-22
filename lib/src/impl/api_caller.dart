import 'dart:async';
import 'dart:convert';
import 'dart:ffi' as ffi;
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';
import 'package:agora_rtc_ng/agora_rtc_ng.dart';
import 'package:async/async.dart';

import 'package:agora_rtc_ng/src/impl/native_iris_api_engine_bindings.dart';
import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:iris_event/iris_event.dart';

// ignore_for_file: public_member_api_docs

const int kBasicResultLength = 64 * 1024;

class CallApiResult {
  CallApiResult({required this.irisReturnCode, required this.data});

  final int irisReturnCode;

  final Map<String, dynamic> data;
}

Uint8List uint8ListFromPtr(int intPtr, int length) {
  final ptr = ffi.Pointer<ffi.Uint8>.fromAddress(intPtr);
  return ptr.asTypedList(length);
}

ffi.Pointer<ffi.Void> uint8ListToPtr(Uint8List buffer) {
  ffi.Pointer<ffi.Void> bufferPointer;

  final ffi.Pointer<ffi.Uint8> bufferData =
      calloc.allocate<ffi.Uint8>(buffer.length);

  final pointerList = bufferData.asTypedList(buffer.length);
  pointerList.setAll(0, buffer);

  bufferPointer = bufferData.cast<ffi.Void>();
  return bufferPointer;
}

void freePointer(ffi.Pointer<ffi.Void> ptr) {
  calloc.free(ptr);
}

ffi.DynamicLibrary _loadAgoraFpaServiceLib() {
  if (Platform.isWindows) {
    return ffi.DynamicLibrary.open('AgoraRtcWrapper.dll');
  }

  if (Platform.isAndroid) {
    return ffi.DynamicLibrary.open("libAgoraRtcWrapper.so");
  }

  return ffi.DynamicLibrary.process();
}

ApiCaller _defaultApiCaller = ApiCaller();
ApiCaller get apiCaller => _defaultApiCaller;

class ApiCaller {
  _ApiCallExecutor? _apiCallExecutor;

  Future<void> initilize() async {
    _apiCallExecutor = _ApiCallExecutor();
    await _apiCallExecutor!.prepare();
  }

  Future<void> dispose() async {
    await _apiCallExecutor!.close();
    _apiCallExecutor = null;
  }

  int getIrisApiEngineIntPtr() {
    return _apiCallExecutor!.getIrisApiEngineIntPtr();
  }

  Future<CallApiResult> callIrisApi(
    String funcName,
    String params, {
    Uint8List? buffer,
  }) async {
    if (_apiCallExecutor == null) {
      throw AgoraRtcException(
        code: ErrorCodeType.errAborted.value(),
        message: 'Make sure you call RtcEngine.initialize first',
      );
    }
    return _apiCallExecutor!.callIrisApi(funcName, params, buffer: buffer);
  }

  Future<void> setupIrisRtcEngineEventHandler() {
    return _apiCallExecutor!.setupIrisRtcEngineEventHandler();
  }

  Future<void> disposeIrisRtcEngineEventHandler() {
    return _apiCallExecutor!.disposeIrisRtcEngineEventHandler();
  }

  Future<void> disposeIrisMediaPlayerEventHandlerIfNeed() {
    return _apiCallExecutor!.disposeIrisMediaPlayerEventHandlerIfNeed();
  }

  Future<void> setupIrisMediaPlayerEventHandlerIfNeed() {
    return _apiCallExecutor!.setupIrisMediaPlayerEventHandlerIfNeed();
  }

  void addEventHandler(IrisEventHandler eventHandler) {
    _apiCallExecutor!.addEventHandler(eventHandler);
  }

  void removeEventHandler(IrisEventHandler eventHandler) {
    _apiCallExecutor!.removeEventHandler(eventHandler);
  }
}

class _ApiCallExecutor {
  late final StreamQueue<dynamic> responseQueue;
  late final SendPort requestPort;
  late final StreamSubscription evntSubscription;
  final Set<IrisEventHandler> _irisEventHandlers = {};
  late final int irisApiEngineIntPtr;

  static Future<void> _execute(List<SendPort> mainSendPorts) async {
    SendPort mainApiCallSendPort = mainSendPorts[0];
    SendPort mainEventSendPort = mainSendPorts[1];
    // Send a SendPort to the main isolate so that it can send JSON strings to
    // this isolate.
    // final apiCallPort = ReceivePort('IrisApiEngine_ApiCallPort');
    final apiCallPort = ReceivePort();
    // final eventPort = ReceivePort('IrisApiEngine_EventPort');

    _ApiCallExecutorInternal executor = _ApiCallExecutorInternal();
    executor.initilize();
    mainApiCallSendPort.send([
      apiCallPort.sendPort,
      executor.getIrisApiEngineIntPtr(),
    ]);

    // Wait for messages from the main isolate.
    await for (final request in apiCallPort) {
      if (request == null) {
        // Exit if the main isolate sends a null message, indicating there are no
        // more files to read and parse.
        break;
      }

      assert(request is _Request);

      if (request is _ApiCallRequest) {
        final result = executor.callIrisApi(
          request.funcName,
          request.params,
          buffer: request.buffer,
        );

        mainApiCallSendPort.send(result);
      } else if (request is _SetupIrisRtcEngineEventHandlerRequest) {
        executor.setupIrisRtcEngineEventHandler(mainEventSendPort);
        mainApiCallSendPort.send(0);
      } else if (request is _DisposeIrisRtcEngineEventHandlerRequest) {
        executor.disposeIrisRtcEngineEventHandler();
        mainApiCallSendPort.send(0);
      } else if (request is _SetupIrisMediaPlayerEventHandlerRequest) {
        executor.setupIrisMediaPlayerEventHandlerIfNeed(mainEventSendPort);
        mainApiCallSendPort.send(0);
      } else if (request is _DisposeIrisMediaPlayerEventHandlerRequest) {
        executor.disposeIrisMediaPlayerEventHandlerIfNeed();
        mainApiCallSendPort.send(0);
      }
    }

    executor.dispose();
    Isolate.exit();
  }

  Future<void> prepare() async {
    final apiCallPort = ReceivePort();
    final eventPort = ReceivePort();
    await Isolate.spawn(_execute, [apiCallPort.sendPort, eventPort.sendPort]);

    // Convert the ReceivePort into a StreamQueue to receive messages from the
    // spawned isolate using a pull-based interface. Events are stored in this
    // queue until they are accessed by `events.next`.
    // final events = StreamQueue<dynamic>(p);
    responseQueue = StreamQueue<dynamic>(apiCallPort);

    // The first message from the spawned isolate is a SendPort. This port is
    // used to communicate with the spawned isolate.
    // SendPort sendPort = await events.next;
    final msg = await responseQueue.next;
    requestPort = msg[0];
    irisApiEngineIntPtr = msg[1];

    evntSubscription = eventPort.listen((message) {
      String event = message[0];
      String data = message[1];
      List<Uint8List> buffers = message[2];

      for (final eventHandler in _irisEventHandlers) {
        eventHandler.onEvent(event, data, buffers);
      }
    });
  }

  int getIrisApiEngineIntPtr() {
    return irisApiEngineIntPtr;
  }

  Future<CallApiResult> callIrisApi(
    String funcName,
    String params, {
    Uint8List? buffer,
  }) async {
    requestPort.send(_ApiCallRequest(funcName, params, buffer));
    final CallApiResult result = await responseQueue.next;
    return result;
  }

  Future<void> setupIrisRtcEngineEventHandler() async {
    requestPort.send(const _SetupIrisRtcEngineEventHandlerRequest());
    await responseQueue.next;
  }

  Future<void> disposeIrisRtcEngineEventHandler() async {
    requestPort.send(const _DisposeIrisRtcEngineEventHandlerRequest());
    await responseQueue.next;
  }

  Future<void> disposeIrisMediaPlayerEventHandlerIfNeed() async {
    requestPort.send(const _DisposeIrisMediaPlayerEventHandlerRequest());
    await responseQueue.next;
  }

  Future<void> setupIrisMediaPlayerEventHandlerIfNeed() async {
    requestPort.send(const _SetupIrisMediaPlayerEventHandlerRequest());
    await responseQueue.next;
  }

  void addEventHandler(IrisEventHandler eventHandler) {
    _irisEventHandlers.add(eventHandler);
  }

  void removeEventHandler(IrisEventHandler eventHandler) {
    _irisEventHandlers.remove(eventHandler);
  }

  Future<void> close() async {
    _irisEventHandlers.clear();
    await evntSubscription.cancel();

    requestPort.send(null);
    await responseQueue.cancel();
  }
}

abstract class _Request {}

class _ApiCallRequest implements _Request {
  const _ApiCallRequest(this.funcName, this.params, this.buffer);

  final String funcName;
  final String params;
  final Uint8List? buffer;
}

class _SetupIrisRtcEngineEventHandlerRequest implements _Request {
  const _SetupIrisRtcEngineEventHandlerRequest();
}

class _DisposeIrisRtcEngineEventHandlerRequest implements _Request {
  const _DisposeIrisRtcEngineEventHandlerRequest();
}

class _SetupIrisMediaPlayerEventHandlerRequest implements _Request {
  const _SetupIrisMediaPlayerEventHandlerRequest();
}

class _DisposeIrisMediaPlayerEventHandlerRequest implements _Request {
  const _DisposeIrisMediaPlayerEventHandlerRequest();
}

class _ApiCallExecutorInternal {
  late final NativeIrisApiEngineBinding _nativeIrisApiEngineBinding;
  IrisApiEnginePtr? _irisApiEnginePtr;

  late final IrisEvent _irisEvent;
  ffi.Pointer<IrisCEventHandler>? _irisCEventHandler;
  ffi.Pointer<ffi.Void>? _irisEventHandlerPtr;
  ffi.Pointer<ffi.Void>? _irisMediaPlayerEventHandlerPtr;

  void initilize() {
    _nativeIrisApiEngineBinding =
        NativeIrisApiEngineBinding(_loadAgoraFpaServiceLib());
    _irisApiEnginePtr = _nativeIrisApiEngineBinding.CreateIrisApiEngine();
    _irisEvent = IrisEvent();
  }

  int getIrisApiEngineIntPtr() {
    assert(_irisApiEnginePtr != null);
    return _irisApiEnginePtr!.address;
  }

  void _initIrisCEventHandlerIfNeed(SendPort sendPort) {
    if (_irisCEventHandler == null) {
      _irisCEventHandler = calloc<IrisCEventHandler>()
        ..ref.OnEvent = _irisEvent.onEventPtr;
      _irisEvent.setEventHandler(_SendableIrisEventHandler(sendPort));
    }
  }

  void setupIrisRtcEngineEventHandler(SendPort sendPort) {
    assert(_irisApiEnginePtr != null);

    _initIrisCEventHandlerIfNeed(sendPort);
    assert(_irisCEventHandler != null);

    _irisEventHandlerPtr =
        _nativeIrisApiEngineBinding.SetIrisRtcEngineEventHandler(
            _irisApiEnginePtr!, _irisCEventHandler!);
  }

  void disposeIrisRtcEngineEventHandler() {
    if (_irisEventHandlerPtr != null && _irisCEventHandler != null) {
      _nativeIrisApiEngineBinding.UnsetIrisRtcEngineEventHandler(
          _irisApiEnginePtr!, _irisEventHandlerPtr!);

      calloc.free(_irisCEventHandler!);
      _irisCEventHandler = null;
      _irisEventHandlerPtr = null;
    }
  }

  void disposeIrisMediaPlayerEventHandlerIfNeed() {
    if (_irisMediaPlayerEventHandlerPtr != null && _irisCEventHandler != null) {
      _nativeIrisApiEngineBinding.UnsetIrisMediaPlayerEventHandler(
          _irisApiEnginePtr!, _irisMediaPlayerEventHandlerPtr!);

      _irisMediaPlayerEventHandlerPtr = null;
    }
  }

  void setupIrisMediaPlayerEventHandlerIfNeed(SendPort sendPort) {
    assert(_irisApiEnginePtr != null);
    if (_irisMediaPlayerEventHandlerPtr != null) return;

    _initIrisCEventHandlerIfNeed(sendPort);
    assert(_irisCEventHandler != null);

    _irisMediaPlayerEventHandlerPtr =
        _nativeIrisApiEngineBinding.SetIrisMediaPlayerEventHandler(
            _irisApiEnginePtr!, _irisCEventHandler!);
  }

  CallApiResult callIrisApi(
    String funcName,
    String params, {
    Uint8List? buffer,
  }) {
    assert(_irisApiEnginePtr != null, 'Make sure initilize() has been called.');

    return using<CallApiResult>((Arena arena) {
      final ffi.Pointer<ffi.Int8> resultPointer =
          arena.allocate<ffi.Int8>(kBasicResultLength).cast<ffi.Int8>();

      final ffi.Pointer<ffi.Int8> funcNamePointer =
          funcName.toNativeUtf8(allocator: arena).cast<ffi.Int8>();

      final ffi.Pointer<Utf8> paramsPointerUtf8 =
          params.toNativeUtf8(allocator: arena);
      final paramsPointerUtf8Length = paramsPointerUtf8.length;
      final ffi.Pointer<ffi.Int8> paramsPointer =
          paramsPointerUtf8.cast<ffi.Int8>();

      ffi.Pointer<ffi.Void> bufferPointer;
      ffi.Pointer<ffi.Pointer<ffi.Void>> bufferPtrToPtr;
      int bufferLength = buffer?.length ?? 0;
      if (buffer != null) {
        final ffi.Pointer<ffi.Uint8> bufferData =
            arena.allocate<ffi.Uint8>(buffer.length);

        final pointerList = bufferData.asTypedList(buffer.length);
        pointerList.setAll(0, buffer);

        bufferPointer = bufferData.cast<ffi.Void>();

        bufferPtrToPtr = arena();

        bufferPtrToPtr.value =
            ffi.Pointer<ffi.Void>.fromAddress(bufferPointer.address);
      } else {
        bufferPtrToPtr = ffi.nullptr;
      }

      try {
        final irisReturnCode = _nativeIrisApiEngineBinding.CallIrisApi(
            _irisApiEnginePtr!,
            funcNamePointer,
            paramsPointer,
            paramsPointerUtf8Length,
            bufferPtrToPtr,
            bufferLength,
            resultPointer);

        final result = resultPointer.cast<Utf8>().toDartString();
        final resultMap = Map<String, dynamic>.from(jsonDecode(result));

        return CallApiResult(irisReturnCode: irisReturnCode, data: resultMap);
      } catch (e) {
        debugPrint(
            '[_ApiCallExecutor] $funcName, params: $params\nerror: ${e.toString()}');
        return CallApiResult(irisReturnCode: -10000, data: const {});
      }
    });
  }

  void dispose() {
    assert(_irisApiEnginePtr != null);

    disposeIrisMediaPlayerEventHandlerIfNeed();
    // The IrisRtcEngineEventHandler should be dispose on last, which will free the
    // _irisCEventHandler internally.
    disposeIrisRtcEngineEventHandler();

    _nativeIrisApiEngineBinding.DestroyIrisApiEngine(_irisApiEnginePtr!);
    _irisApiEnginePtr = null;
  }
}

class _SendableIrisEventHandler implements IrisEventHandler {
  const _SendableIrisEventHandler(this._sendPort);
  final SendPort _sendPort;

  @override
  void onEvent(String event, String data, List<Uint8List> buffers) {
    _sendPort.send([event, data, buffers]);
  }
}
