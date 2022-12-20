import 'dart:async';
import 'dart:convert';
import 'dart:ffi' as ffi;
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';
import 'package:agora_rtc_engine/src/agora_base.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine_ext.dart';
import 'package:async/async.dart';

import 'package:agora_rtc_engine/src/impl/native_iris_api_engine_bindings.dart';
import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:iris_event/iris_event.dart';

import 'disposable_object.dart';
import 'event_loop.dart';

// ignore_for_file: public_member_api_docs

int? _mockIrisApiEngineIntPtr;
void setMockIrisApiEngineIntPtr(int? mockIrisApiEngineIntPtr) {
  assert(() {
    _mockIrisApiEngineIntPtr = mockIrisApiEngineIntPtr;
    return true;
  }());
}

const int kBasicResultLength = 64 * 1024;

class CallApiResult {
  CallApiResult({required this.irisReturnCode, required this.data});

  final int irisReturnCode;

  final Map<String, dynamic> data;
}

Uint8List uint8ListFromPtr(int intPtr, int length) {
  final ptr = ffi.Pointer<ffi.Uint8>.fromAddress(intPtr);
  final memoryList = ptr.asTypedList(length);
  return Uint8List.fromList(memoryList);
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

class ApiCaller implements _ApiCallExecutorBaseAsync {
  _ApiCallExecutor? _apiCallExecutor;

  @override
  Future<void> initilizeAsync() async {
    _apiCallExecutor = _ApiCallExecutor();
    await _apiCallExecutor!.initilizeAsync();
  }

  @override
  Future<void> disposeAsync() async {
    await _apiCallExecutor!.disposeAsync();
    _apiCallExecutor = null;
  }

  @override
  int getIrisApiEngineIntPtr() {
    return _apiCallExecutor!.getIrisApiEngineIntPtr();
  }

  @override
  Future<CallApiResult> callIrisApiWithUin8ListAsync(
    String funcName,
    String params, {
    List<Uint8List>? buffers,
  }) async {
    if (_apiCallExecutor == null) {
      throw AgoraRtcException(
        code: ErrorCodeType.errAborted.value(),
        message: 'Make sure you call RtcEngine.initialize first',
      );
    }
    return _apiCallExecutor!
        .callIrisApiWithUin8ListAsync(funcName, params, buffers: buffers);
  }

  Future<CallApiResult> callIrisApi(
    String funcName,
    String params, {
    List<Uint8List>? buffers,
  }) {
    return callIrisApiWithUin8ListAsync(funcName, params, buffers: buffers);
  }

  @override
  void addEventHandler(IrisEventHandler eventHandler) {
    _apiCallExecutor!.addEventHandler(eventHandler);
  }

  @override
  void removeEventHandler(IrisEventHandler eventHandler) {
    _apiCallExecutor!.removeEventHandler(eventHandler);
  }

  @override
  Future<CallApiResult> callIrisEventAsync(IrisEventKey key, String params) {
    return _apiCallExecutor!.callIrisEventAsync(key, params);
  }

  @override
  Future<void> disposeAllEventHandlersAsync() {
    return _apiCallExecutor!.disposeAllEventHandlersAsync();
  }

  @override
  Future<void> startDumpVideoAsync(
      int irisVideoFrameBufferManagerIntPtr, int type, String dir) {
    return _apiCallExecutor!
        .startDumpVideoAsync(irisVideoFrameBufferManagerIntPtr, type, dir);
  }

  @override
  Future<void> stopDumpVideoAsync(int irisVideoFrameBufferManagerIntPtr) {
    return _apiCallExecutor!
        .stopDumpVideoAsync(irisVideoFrameBufferManagerIntPtr);
  }
}

class _ApiCallExecutor implements _ApiCallExecutorBaseAsync {
  late final StreamQueue<dynamic> responseQueue;
  late final SendPort requestPort;
  late final StreamSubscription evntSubscription;
  final Set<IrisEventHandler> _irisEventHandlers = {};
  late final int irisApiEngineIntPtr;

  static Future<void> _execute(List<Object?> args) async {
    SendPort mainApiCallSendPort = args[0] as SendPort;
    SendPort mainEventSendPort = args[1] as SendPort;
    ffi.Pointer<ffi.Void>? irisApiEnginePtr;
    // We only aim to pass the irisApiEngine to the executor in the integration test (debug mode)
    assert(() {
      if (args.length > 2) {
        final intptr = args[2] as int?;
        if (intptr != null) {
          irisApiEnginePtr = ffi.Pointer.fromAddress(intptr);
        }
      }

      return true;
    }());
    // Send a SendPort to the main isolate so that it can send JSON strings to
    // this isolate.
    // final apiCallPort = ReceivePort('IrisApiEngine_ApiCallPort');
    final apiCallPort = ReceivePort();
    // final eventPort = ReceivePort('IrisApiEngine_EventPort');

    _ApiCallExecutorInternal executor = _ApiCallExecutorInternal();
    executor.initilize(mainEventSendPort, irisApiEnginePtr);
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
        final result = executor.callIrisApiWithUint8List(
          request.funcName,
          request.params,
          buffers: request.buffers,
        );

        mainApiCallSendPort.send(result);
      } else if (request is _IrisEventObserverRequest) {
        final result = executor.callIrisEvent(request.key, request.params);
        mainApiCallSendPort.send(result);
      } else if (request is _DisposeAllEventHandlersRequest) {
        executor.disposeAllEventHandlers();
        mainApiCallSendPort.send(0);
      } else if (request is _StartDumpVideoRequest) {
        executor.startDumpVideo(request.irisVideoFrameBufferManagerIntPtr,
            request.type, request.dir);
        mainApiCallSendPort.send(0);
      } else if (request is _StopDumpVideoRequest) {
        executor.stopDumpVideo(request.irisVideoFrameBufferManagerIntPtr);
        mainApiCallSendPort.send(0);
      }
    }

    executor.dispose();
    Isolate.exit();
  }

  @override
  Future<void> initilizeAsync() async {
    final apiCallPort = ReceivePort();
    final eventPort = ReceivePort();
    await Isolate.spawn(_execute, [
      apiCallPort.sendPort,
      eventPort.sendPort,
      _mockIrisApiEngineIntPtr,
    ]);

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

  @override
  int getIrisApiEngineIntPtr() {
    return irisApiEngineIntPtr;
  }

  @override
  Future<CallApiResult> callIrisApiWithUin8ListAsync(
    String funcName,
    String params, {
    List<Uint8List>? buffers,
  }) async {
    requestPort.send(_ApiCallRequest(funcName, params, buffers));
    final CallApiResult result = await responseQueue.next;
    return result;
  }

  @override
  void addEventHandler(IrisEventHandler eventHandler) {
    _irisEventHandlers.add(eventHandler);
  }

  @override
  void removeEventHandler(IrisEventHandler eventHandler) {
    _irisEventHandlers.remove(eventHandler);
  }

  @override
  Future<void> disposeAsync() async {
    _irisEventHandlers.clear();
    await evntSubscription.cancel();

    requestPort.send(null);
    await responseQueue.cancel();
  }

  @override
  Future<CallApiResult> callIrisEventAsync(
      IrisEventKey key, String params) async {
    requestPort.send(_IrisEventObserverRequest(params, key));
    final CallApiResult result = await responseQueue.next;
    return result;
  }

  @override
  Future<void> startDumpVideoAsync(
      int irisVideoFrameBufferManagerIntPtr, int type, String dir) async {
    requestPort.send(
        _StartDumpVideoRequest(irisVideoFrameBufferManagerIntPtr, type, dir));
    await responseQueue.next;
  }

  @override
  Future<void> stopDumpVideoAsync(int irisVideoFrameBufferManagerIntPtr) async {
    requestPort.send(_StopDumpVideoRequest(irisVideoFrameBufferManagerIntPtr));
    await responseQueue.next;
  }

  @override
  Future<void> disposeAllEventHandlersAsync() async {
    requestPort.send(const _DisposeAllEventHandlersRequest());
    await responseQueue.next;
  }
}

abstract class _Request {}

class _ApiCallRequest implements _Request {
  const _ApiCallRequest(this.funcName, this.params, this.buffers);

  final String funcName;
  final String params;
  final List<Uint8List>? buffers;
}

class _IrisEventObserverRequest implements _Request {
  const _IrisEventObserverRequest(this.params, this.key);

  final String params;
  final IrisEventKey key;
}

class _StartDumpVideoRequest implements _Request {
  const _StartDumpVideoRequest(
      this.irisVideoFrameBufferManagerIntPtr, this.type, this.dir);

  final int irisVideoFrameBufferManagerIntPtr;
  final int type;
  final String dir;
}

class _StopDumpVideoRequest implements _Request {
  const _StopDumpVideoRequest(this.irisVideoFrameBufferManagerIntPtr);

  final int irisVideoFrameBufferManagerIntPtr;
}

class _DisposeAllEventHandlersRequest implements _Request {
  const _DisposeAllEventHandlersRequest();
}

class _ApiCallExecutorInternal implements _ApiCallExecutorBase {
  late final NativeIrisApiEngineBinding _nativeIrisApiEngineBinding;
  IrisApiEnginePtr? _irisApiEnginePtr;

  late final IrisEvent _irisEvent;
  ffi.Pointer<IrisCEventHandler>? _irisCEventHandler;
  final Map<IrisEventKey, DisposableNativeIrisEventHandler>
      _irisEventHandlerObservers = {};

  @override
  void initilize(SendPort sendPort, ffi.Pointer<ffi.Void>? irisApiEnginePtr) {
    _nativeIrisApiEngineBinding =
        NativeIrisApiEngineBinding(_loadAgoraFpaServiceLib());
    _nativeIrisApiEngineBinding.enableUseJsonArray(1);
    _irisApiEnginePtr = irisApiEnginePtr ??
        _nativeIrisApiEngineBinding.CreateIrisApiEngine(ffi.nullptr);

    _irisEvent = IrisEvent();
    _irisEvent.setEventHandler(_SendableIrisEventHandler(sendPort));

    _irisCEventHandler = calloc<IrisCEventHandler>()
      ..ref.OnEvent = _irisEvent.onEventPtr.cast();
  }

  @override
  int getIrisApiEngineIntPtr() {
    assert(_irisApiEnginePtr != null);
    return _irisApiEnginePtr!.address;
  }

  @override
  CallApiResult callIrisApi(
    String funcName,
    String params, {
    List<BufferParam>? bufferList,
  }) {
    assert(_irisApiEnginePtr != null, 'Make sure initilize() has been called.');

    return using<CallApiResult>((Arena arena) {
      final ffi.Pointer<ffi.Int8> resultPointer =
          arena.allocate<ffi.Int8>(kBasicResultLength);

      final ffi.Pointer<ffi.Int8> funcNamePointer =
          funcName.toNativeUtf8(allocator: arena).cast<ffi.Int8>();

      final ffi.Pointer<Utf8> paramsPointerUtf8 =
          params.toNativeUtf8(allocator: arena);
      final paramsPointerUtf8Length = paramsPointerUtf8.length;
      final ffi.Pointer<ffi.Int8> paramsPointer =
          paramsPointerUtf8.cast<ffi.Int8>();

      ffi.Pointer<ffi.Pointer<ffi.Void>> bufferListPtr;
      ffi.Pointer<ffi.Uint32> bufferListLengthPtr = ffi.nullptr;
      int bufferLength = bufferList?.length ?? 0;

      if (bufferList != null) {
        bufferListPtr =
            arena.allocate(bufferList.length * ffi.sizeOf<ffi.Uint64>());

        for (int i = 0; i < bufferList.length; i++) {
          final bufferParam = bufferList[i];
          bufferListPtr[i] = ffi.Pointer.fromAddress(bufferParam.intPtr);
        }
      } else {
        bufferListPtr = ffi.nullptr;
        bufferListLengthPtr = ffi.nullptr;
      }

      try {
        final apiParam = arena<ApiParam>()
          ..ref.event = funcNamePointer
          ..ref.data = paramsPointer
          ..ref.data_size = paramsPointerUtf8Length
          ..ref.result = resultPointer
          ..ref.buffer = bufferListPtr
          ..ref.length = bufferListLengthPtr
          ..ref.buffer_count = bufferLength;

        final irisReturnCode = _nativeIrisApiEngineBinding.CallIrisApi(
            _irisApiEnginePtr!, apiParam);

        if (irisReturnCode != 0) {
          return CallApiResult(irisReturnCode: irisReturnCode, data: const {});
        }

        final result = resultPointer.cast<Utf8>().toDartString();

        final resultMap = Map<String, dynamic>.from(jsonDecode(result));

        return CallApiResult(irisReturnCode: irisReturnCode, data: resultMap);
      } catch (e) {
        debugPrint(
            '[_ApiCallExecutor] $funcName, params: $params\nerror: ${e.toString()}');
        return CallApiResult(
            irisReturnCode: -ErrorCodeType.errFailed.value(), data: const {});
      }
    });
  }

  @override
  CallApiResult callIrisApiWithUint8List(
    String funcName,
    String params, {
    List<Uint8List>? buffers,
  }) {
    return using<CallApiResult>((Arena arena) {
      int bufferLength = buffers?.length ?? 0;

      List<BufferParam>? buffersPtrList = [];

      if (buffers != null) {
        for (int i = 0; i < bufferLength; i++) {
          final buffer = buffers[i];
          if (buffer.isEmpty) {
            buffersPtrList.add(const BufferParam(0, 0));
            continue;
          }
          final ffi.Pointer<ffi.Uint8> bufferData =
              arena.allocate<ffi.Uint8>(buffer.length);

          final pointerList = bufferData.asTypedList(buffer.length);
          pointerList.setAll(0, buffer);

          buffersPtrList.add(BufferParam(bufferData.address, buffer.length));
        }
      }

      return callIrisApi(funcName, params, bufferList: buffersPtrList);
    });
  }

  @override
  void dispose() {
    assert(_irisApiEnginePtr != null);

    _irisEvent.dispose();

    calloc.free(_irisCEventHandler!);
    _irisCEventHandler = null;

    _nativeIrisApiEngineBinding.DestroyIrisApiEngine(_irisApiEnginePtr!);
    _irisApiEnginePtr = null;
  }

  void _destroyObservers() {
    _irisEventHandlerObservers.forEach((key, ob) {
      ob.dispose();
    });

    _irisEventHandlerObservers.clear();
  }

  @override
  CallApiResult callIrisEvent(IrisEventKey key, String params) {
    if (key is IrisEventObserverKey) {
      if (key.op == CallIrisEventOp.create) {
        _irisEventHandlerObservers.putIfAbsent(
            key,
            () => _IrisEventHandlerObserver(
                  apiCallExecutorBase: this,
                  nativeIrisApiEngineBinding: _nativeIrisApiEngineBinding,
                  irisCEventHandler: _irisCEventHandler!,
                  key: key,
                  params: params,
                ));
      } else if (key.op == CallIrisEventOp.dispose) {
        _irisEventHandlerObservers[key]?.dispose();
        _irisEventHandlerObservers.remove(key);
      }
    }

    // Treat the callIrisEvent to success by default
    return CallApiResult(irisReturnCode: 0, data: {});
  }

  @override
  void startDumpVideo(
      int irisVideoFrameBufferManagerIntPtr, int type, String dir) {
    using((Arena arena) {
      final dirPtr = dir.toNativeUtf8(allocator: arena).cast<ffi.Int8>();
      _nativeIrisApiEngineBinding.StartDumpVideo(
          ffi.Pointer.fromAddress(irisVideoFrameBufferManagerIntPtr),
          type,
          dirPtr);
    });
  }

  @override
  void stopDumpVideo(int irisVideoFrameBufferManagerIntPtr) {
    _nativeIrisApiEngineBinding.StopDumpVideo(
        ffi.Pointer.fromAddress(irisVideoFrameBufferManagerIntPtr));
  }

  @override
  void disposeAllEventHandlers() {
    _destroyObservers();
  }
}

class BufferParam {
  const BufferParam(this.intPtr, this.length);
  final int intPtr;
  final int length;
}

abstract class _ApiCallExecutorBase {
  void initilize(SendPort sendPort, ffi.Pointer<ffi.Void>? irisApiEnginePtr);

  int getIrisApiEngineIntPtr();

  CallApiResult callIrisApi(
    String funcName,
    String params, {
    List<BufferParam>? bufferList,
  });

  CallApiResult callIrisApiWithUint8List(
    String funcName,
    String params, {
    List<Uint8List>? buffers,
  });

  CallApiResult callIrisEvent(IrisEventKey key, String params);

  void disposeAllEventHandlers();

  void dispose();

  void startDumpVideo(
      int irisVideoFrameBufferManagerIntPtr, int type, String dir);

  void stopDumpVideo(int irisVideoFrameBufferManagerIntPtr);
}

abstract class _ApiCallExecutorBaseAsync {
  Future<void> initilizeAsync();

  int getIrisApiEngineIntPtr();

  Future<void> disposeAllEventHandlersAsync();

  Future<CallApiResult> callIrisApiWithUin8ListAsync(
    String funcName,
    String params, {
    List<Uint8List>? buffers,
  });

  Future<CallApiResult> callIrisEventAsync(IrisEventKey key, String params);

  Future<void> disposeAsync();

  void addEventHandler(IrisEventHandler eventHandler);

  void removeEventHandler(IrisEventHandler eventHandler);

  Future<void> startDumpVideoAsync(
      int irisVideoFrameBufferManagerIntPtr, int type, String dir);

  Future<void> stopDumpVideoAsync(int irisVideoFrameBufferManagerIntPtr);
}

class _SendableIrisEventHandler implements IrisEventHandler {
  const _SendableIrisEventHandler(this._sendPort);
  final SendPort _sendPort;

  @override
  void onEvent(String event, String data, List<Uint8List> buffers) {
    _sendPort.send([event, data, buffers]);
  }
}

abstract class IrisEventKey {
  const IrisEventKey({
    required this.registerName,
    required this.unregisterName,
    required this.op,
    required this.handlerHash,
  });
  final String registerName;
  final String unregisterName;
  final CallIrisEventOp op;
  final int handlerHash;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is IrisEventKey &&
        other.registerName == registerName &&
        other.unregisterName == unregisterName &&
        other.handlerHash == handlerHash;
  }

  @override
  int get hashCode => Object.hash(registerName, unregisterName, handlerHash);
}

enum CallIrisEventOp {
  create,
  dispose,
}

class IrisEventObserverKey extends IrisEventKey {
  IrisEventObserverKey({
    required String registerName,
    required String unregisterName,
    required CallIrisEventOp op,
    required EventLoopEventHandler? handler,
  }) : super(
          registerName: registerName,
          unregisterName: unregisterName,
          op: op,
          handlerHash: 0,
        );
}

abstract class DisposableNativeIrisEventHandler implements DisposableObject {
  @override
  void dispose();
}

class _IrisEventHandlerObserver implements DisposableNativeIrisEventHandler {
  _IrisEventHandlerObserver(
      {required this.apiCallExecutorBase,
      required this.nativeIrisApiEngineBinding,
      required this.irisCEventHandler,
      required this.key,
      required this.params}) {
    using((Arena arena) {
      _observerPtr =
          nativeIrisApiEngineBinding.CreateIrisEventHandler(irisCEventHandler);

      apiCallExecutorBase.callIrisApi(
        key.registerName,
        params,
        bufferList: [BufferParam(_observerPtr.address, 1)],
      );
    });
  }

  final NativeIrisApiEngineBinding nativeIrisApiEngineBinding;

  final IrisEventKey key;

  final _ApiCallExecutorBase apiCallExecutorBase;

  final String params;

  late final ffi.Pointer<ffi.Void> _observerPtr;

  final ffi.Pointer<IrisCEventHandler> irisCEventHandler;

  @override
  void dispose() {
    if (key.unregisterName.isEmpty) return;

    using((Arena arena) {
      apiCallExecutorBase.callIrisApi(key.unregisterName, params,
          bufferList: [BufferParam(_observerPtr.address, 1)]);

      nativeIrisApiEngineBinding.DestroyIrisEventHandler(_observerPtr);
    });
  }
}
