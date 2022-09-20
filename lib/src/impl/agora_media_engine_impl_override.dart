import 'dart:convert';
import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/src/binding/agora_media_base_event_impl.dart';
import 'package:agora_rtc_engine/src/binding/agora_media_engine_impl.dart'
    as media_engine_impl_binding;
import 'package:agora_rtc_engine/src/impl/api_caller.dart';
import 'package:agora_rtc_engine/src/impl/disposable_object.dart';
import 'package:agora_rtc_engine/src/impl/event_loop.dart';

// ignore_for_file: public_member_api_docs, unused_local_variable

class MediaEngineImpl extends media_engine_impl_binding.MediaEngineImpl
    implements AsyncDisposableObject {
  MediaEngineImpl._(this._eventLoop);

  factory MediaEngineImpl.create(EventLoop eventLoop) {
    return MediaEngineImpl._(eventLoop);
  }

  final EventLoop _eventLoop;

  @override
  void registerAudioFrameObserver(AudioFrameObserver observer) async {
    final param = createParams({});
    await apiCaller.callIrisEventAsync(
        const IrisEventObserverKey(
            op: CallIrisEventOp.create,
            registerName: 'MediaEngine_registerAudioFrameObserver',
            unregisterName: 'MediaEngine_unregisterAudioFrameObserver'),
        jsonEncode(param));

    _eventLoop.addEventHandler(const EventLoopEventHandlerKey(MediaEngineImpl),
        AudioFrameObserverWrapper(observer));
  }

  @override
  void registerVideoFrameObserver(VideoFrameObserver observer) async {
    final param = createParams({});
    await apiCaller.callIrisEventAsync(
        const IrisEventObserverKey(
            op: CallIrisEventOp.create,
            registerName: 'MediaEngine_registerVideoFrameObserver',
            unregisterName: 'MediaEngine_unregisterVideoFrameObserver'),
        jsonEncode(param));

    _eventLoop.addEventHandler(const EventLoopEventHandlerKey(MediaEngineImpl),
        VideoFrameObserverWrapper(observer));
  }

  @override
  void registerVideoEncodedFrameObserver(
      VideoEncodedFrameObserver observer) async {
    final param = createParams({});
    await apiCaller.callIrisEventAsync(
        const IrisEventObserverKey(
            op: CallIrisEventOp.create,
            registerName: 'MediaEngine_registerVideoEncodedFrameObserver',
            unregisterName: 'MediaEngine_unregisterVideoEncodedFrameObserver'),
        jsonEncode(param));

    _eventLoop.addEventHandler(const EventLoopEventHandlerKey(MediaEngineImpl),
        VideoEncodedFrameObserverWrapper(observer));
  }

  @override
  void unregisterAudioFrameObserver(AudioFrameObserver observer) async {
    final param = createParams({});
    await apiCaller.callIrisEventAsync(
        const IrisEventObserverKey(
            op: CallIrisEventOp.dispose,
            registerName: 'MediaEngine_registerAudioFrameObserver',
            unregisterName: 'MediaEngine_unregisterAudioFrameObserver'),
        jsonEncode(param));

    _eventLoop.removeEventHandler(
        const EventLoopEventHandlerKey(MediaEngineImpl),
        AudioFrameObserverWrapper(observer));
  }

  @override
  void unregisterVideoFrameObserver(VideoFrameObserver observer) async {
    final param = createParams({});
    await apiCaller.callIrisEventAsync(
        const IrisEventObserverKey(
            op: CallIrisEventOp.dispose,
            registerName: 'MediaEngine_registerVideoFrameObserver',
            unregisterName: 'MediaEngine_unregisterVideoFrameObserver'),
        jsonEncode(param));

    _eventLoop.removeEventHandler(
        const EventLoopEventHandlerKey(MediaEngineImpl),
        VideoFrameObserverWrapper(observer));
  }

  @override
  void unregisterVideoEncodedFrameObserver(
      VideoEncodedFrameObserver observer) async {
    final param = createParams({});
    await apiCaller.callIrisEventAsync(
        const IrisEventObserverKey(
            op: CallIrisEventOp.dispose,
            registerName: 'MediaEngine_registerVideoEncodedFrameObserver',
            unregisterName: 'MediaEngine_unregisterVideoEncodedFrameObserver'),
        jsonEncode(param));

    _eventLoop.removeEventHandler(
        const EventLoopEventHandlerKey(MediaEngineImpl),
        VideoEncodedFrameObserverWrapper(observer));
  }

  @override
  Future<void> pushVideoFrame(
      {required ExternalVideoFrame frame, int videoTrackId = 0}) async {
    const apiType = 'MediaEngine_pushVideoFrame';
    final json = frame.toJson();
    json['eglContext'] = 0;
    json['metadata_buffer'] = 0;
    final param = createParams({'frame': json, 'videoTrackId': videoTrackId});
    final List<Uint8List> buffers = [];
    final bufferList = <Uint8List>[];
    // This is a little tricky that the buffers length must be 3
    buffers.add(frame.buffer ?? Uint8List.fromList([]));
    buffers.add(Uint8List.fromList([]));
    buffers.add(frame.metadataBuffer ?? Uint8List.fromList([]));
    final callApiResult = await apiCaller
        .callIrisApi(apiType, jsonEncode(param), buffers: buffers);

    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> release() async {
    _eventLoop.removeEventHandlers(
      const EventLoopEventHandlerKey(MediaEngineImpl),
    );
  }

  @override
  Future<void> disposeAsync() async {
    await release();
  }
}
