import 'dart:convert';
import 'dart:typed_data';

import 'package:agora_rtc_engine/src/agora_media_base.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine_ext.dart';
import 'package:agora_rtc_engine/src/binding/agora_media_base_event_impl.dart';
import 'package:agora_rtc_engine/src/binding/agora_media_engine_impl.dart'
    as media_engine_impl_binding;
import 'package:iris_method_channel/iris_method_channel.dart';

// ignore_for_file: public_member_api_docs, unused_local_variable

class MediaEngineImpl extends media_engine_impl_binding.MediaEngineImpl
    with ScopedDisposableObjectMixin {
  MediaEngineImpl._(IrisMethodChannel irisMethodChannel)
      : super(irisMethodChannel);

  factory MediaEngineImpl.create(IrisMethodChannel irisMethodChannel) {
    return MediaEngineImpl._(irisMethodChannel);
  }

  final TypedScopedKey _mediaEngineScopedKey =
      const TypedScopedKey(MediaEngineImpl);

  @override
  void registerAudioFrameObserver(AudioFrameObserver observer) async {
    final eventHandlerWrapper = AudioFrameObserverWrapper(observer);
    final param = createParams({});

    await irisMethodChannel.registerEventHandler(
        ScopedEvent(
            scopedKey: _mediaEngineScopedKey,
            registerName: 'MediaEngine_registerAudioFrameObserver_d873a64',
            unregisterName: 'MediaEngine_unregisterAudioFrameObserver',
            handler: eventHandlerWrapper),
        jsonEncode(param));
  }

  @override
  void registerVideoFrameObserver(VideoFrameObserver observer) async {
    final eventHandlerWrapper = VideoFrameObserverWrapper(observer);
    final param = createParams({});

    await irisMethodChannel.registerEventHandler(
        ScopedEvent(
            scopedKey: _mediaEngineScopedKey,
            registerName: 'MediaEngine_registerVideoFrameObserver_2cc0ef1',
            unregisterName: 'MediaEngine_unregisterVideoFrameObserver',
            handler: eventHandlerWrapper),
        jsonEncode(param));
  }

  @override
  void registerVideoEncodedFrameObserver(
      VideoEncodedFrameObserver observer) async {
    final eventHandlerWrapper = VideoEncodedFrameObserverWrapper(observer);
    final param = createParams({});

    await irisMethodChannel.registerEventHandler(
        ScopedEvent(
            scopedKey: _mediaEngineScopedKey,
            registerName:
                'MediaEngine_registerVideoEncodedFrameObserver_d45d579',
            unregisterName: 'MediaEngine_unregisterVideoEncodedFrameObserver',
            handler: eventHandlerWrapper),
        jsonEncode(param));
  }

  @override
  void unregisterAudioFrameObserver(AudioFrameObserver observer) async {
    final eventHandlerWrapper = AudioFrameObserverWrapper(observer);
    final param = createParams({});

    await irisMethodChannel.unregisterEventHandler(
        ScopedEvent(
            scopedKey: _mediaEngineScopedKey,
            registerName: 'MediaEngine_registerAudioFrameObserver_d873a64',
            unregisterName: 'MediaEngine_unregisterAudioFrameObserver',
            handler: eventHandlerWrapper),
        jsonEncode(param));
  }

  @override
  void unregisterVideoFrameObserver(VideoFrameObserver observer) async {
    final eventHandlerWrapper = VideoFrameObserverWrapper(observer);
    final param = createParams({});

    await irisMethodChannel.unregisterEventHandler(
        ScopedEvent(
            scopedKey: _mediaEngineScopedKey,
            registerName: 'MediaEngine_registerVideoFrameObserver_2cc0ef1',
            unregisterName: 'MediaEngine_unregisterVideoFrameObserver',
            handler: eventHandlerWrapper),
        jsonEncode(param));
  }

  @override
  void unregisterVideoEncodedFrameObserver(
      VideoEncodedFrameObserver observer) async {
    final eventHandlerWrapper = VideoEncodedFrameObserverWrapper(observer);
    final param = createParams({});
    await irisMethodChannel.unregisterEventHandler(
        ScopedEvent(
            scopedKey: _mediaEngineScopedKey,
            registerName:
                'MediaEngine_registerVideoEncodedFrameObserver_d45d579',
            unregisterName: 'MediaEngine_unregisterVideoEncodedFrameObserver',
            handler: eventHandlerWrapper),
        jsonEncode(param));
  }

  @override
  Future<void> pushVideoFrame(
      {required ExternalVideoFrame frame, int videoTrackId = 0}) async {
    const apiType = 'MediaEngine_pushVideoFrame_4e544e2';
    final json = frame.toJson();
    json['eglContext'] = 0;
    json['metadata_buffer'] = 0;
    final param = createParams({'frame': json, 'videoTrackId': videoTrackId});
    final List<Uint8List> buffers = [];
    // This is a little tricky that the buffers length must be 5
    buffers.add(frame.buffer ?? Uint8List.fromList([]));
    buffers.add(Uint8List.fromList([]));
    buffers.add(frame.metadataBuffer ?? Uint8List.fromList([]));
    buffers.add(frame.alphaBuffer ?? Uint8List.fromList([]));
    // This position should add the `d3d11_texture_2d`, but it's not suppoted on Flutter,
    // so add a empty placeholder here.
    buffers.add(Uint8List.fromList([]));
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));

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
    markDisposed();

    await irisMethodChannel.unregisterEventHandlers(_mediaEngineScopedKey);
  }

  @override
  Future<void> dispose() async {
    await release();
  }

  @override
  void registerFaceInfoObserver(FaceInfoObserver observer) async {
    final eventHandlerWrapper = FaceInfoObserverWrapper(observer);
    final param = createParams({});

    await irisMethodChannel.registerEventHandler(
        ScopedEvent(
            scopedKey: _mediaEngineScopedKey,
            registerName: 'MediaEngine_registerFaceInfoObserver_0303ed6',
            unregisterName: 'MediaEngine_unregisterFaceInfoObserver',
            handler: eventHandlerWrapper),
        jsonEncode(param));
  }

  @override
  void unregisterFaceInfoObserver(FaceInfoObserver observer) async {
    final eventHandlerWrapper = FaceInfoObserverWrapper(observer);
    final param = createParams({});

    await irisMethodChannel.unregisterEventHandler(
        ScopedEvent(
            scopedKey: _mediaEngineScopedKey,
            registerName: 'MediaEngine_registerFaceInfoObserver_0303ed6',
            unregisterName: 'MediaEngine_unregisterFaceInfoObserver',
            handler: eventHandlerWrapper),
        jsonEncode(param));
  }
}
