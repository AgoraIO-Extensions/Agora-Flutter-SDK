import 'dart:convert';
import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/src/binding/agora_media_base_event_impl.dart';
import 'package:agora_rtc_engine/src/binding/agora_media_engine_impl.dart'
    as media_engine_impl_binding;
import 'package:agora_rtc_engine/src/binding/call_api_event_handler_buffer_ext.dart';
import 'package:agora_rtc_engine/src/binding/event_handler_param_json.dart';
import 'package:agora_rtc_engine/src/impl/agora_rtc_engine_impl.dart';
import 'package:agora_rtc_engine/src/impl/api_caller.dart';
import 'package:agora_rtc_engine/src/impl/disposable_object.dart';
import 'package:iris_event/iris_event.dart';

// ignore_for_file: public_member_api_docs, unused_local_variable

class AudioFrameObserverWrapperOverride extends AudioFrameObserverWrapper {
  AudioFrameObserverWrapperOverride(AudioFrameObserver audioFrameObserver)
      : super(audioFrameObserver);

  @override
  void onEvent(String event, String data, List<Uint8List> buffers) {
    if (!event.startsWith('AudioFrameObserver')) return;

    final jsonMap = jsonDecode(data);
    switch (event) {
      case 'AudioFrameObserver_onPlaybackAudioFrameBeforeMixing':
        if (audioFrameObserver.onPlaybackAudioFrameBeforeMixing == null) break;
        AudioFrameObserverOnPlaybackAudioFrameBeforeMixingJson paramJson =
            AudioFrameObserverOnPlaybackAudioFrameBeforeMixingJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? channelId = paramJson.channelId;
        int? uid = paramJson.uid;
        AudioFrame? audioFrame = paramJson.audioFrame;
        if (channelId == null || uid == null || audioFrame == null) {
          break;
        }
        audioFrame = audioFrame.fillBuffers(buffers);
        audioFrameObserver.onPlaybackAudioFrameBeforeMixing!(
            channelId, uid, audioFrame);
        break;

      case 'AudioFrameObserver_onRecordAudioFrame':
        if (audioFrameObserver.onRecordAudioFrame == null) break;
        AudioFrameObserverBaseOnRecordAudioFrameJson paramJson =
            AudioFrameObserverBaseOnRecordAudioFrameJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? channelId = paramJson.channelId;
        AudioFrame? audioFrame = paramJson.audioFrame;
        if (channelId == null || audioFrame == null) {
          break;
        }
        audioFrame = audioFrame.fillBuffers(buffers);
        audioFrameObserver.onRecordAudioFrame!(channelId, audioFrame);
        break;

      case 'AudioFrameObserver_onPlaybackAudioFrame':
        if (audioFrameObserver.onPlaybackAudioFrame == null) break;
        AudioFrameObserverBaseOnPlaybackAudioFrameJson paramJson =
            AudioFrameObserverBaseOnPlaybackAudioFrameJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? channelId = paramJson.channelId;
        AudioFrame? audioFrame = paramJson.audioFrame;
        if (channelId == null || audioFrame == null) {
          break;
        }
        audioFrame = audioFrame.fillBuffers(buffers);
        audioFrameObserver.onPlaybackAudioFrame!(channelId, audioFrame);
        break;

      case 'AudioFrameObserver_onMixedAudioFrame':
        if (audioFrameObserver.onMixedAudioFrame == null) break;
        AudioFrameObserverBaseOnMixedAudioFrameJson paramJson =
            AudioFrameObserverBaseOnMixedAudioFrameJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? channelId = paramJson.channelId;
        AudioFrame? audioFrame = paramJson.audioFrame;
        if (channelId == null || audioFrame == null) {
          break;
        }
        audioFrame = audioFrame.fillBuffers(buffers);
        audioFrameObserver.onMixedAudioFrame!(channelId, audioFrame);
        break;
      default:
        break;
    }
  }
}

class MediaEngineImpl extends media_engine_impl_binding.MediaEngineImpl
    implements IrisEventHandler, AsyncDisposableObject {
  MediaEngineImpl._(this._rtcEngine) {
    _rtcEngine.addToPool(MediaEngineImpl, this);
    apiCaller.addEventHandler(this);
  }

  factory MediaEngineImpl.create(RtcEngine rtcEngine) {
    return MediaEngineImpl._(rtcEngine);
  }

  final RtcEngine _rtcEngine;

  final Set<IrisEventHandler> _eventHandlers = {};

  @override
  void registerAudioFrameObserver(AudioFrameObserver observer) async {
    final param = createParams({});
    await apiCaller.callIrisEventAsync(
        const IrisEventObserverKey(
            op: CallIrisEventOp.create,
            registerName: 'MediaEngine_registerAudioFrameObserver',
            unregisterName: 'MediaEngine_unregisterAudioFrameObserver'),
        jsonEncode(param));

    _eventHandlers.add(AudioFrameObserverWrapperOverride(observer));
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

    _eventHandlers.add(VideoFrameObserverWrapper(observer));
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

    _eventHandlers.add(VideoEncodedFrameObserverWrapper(observer));
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

    _eventHandlers.remove(AudioFrameObserverWrapperOverride(observer));
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

    _eventHandlers.remove(VideoFrameObserverWrapper(observer));
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

    _eventHandlers.remove(VideoEncodedFrameObserverWrapper(observer));
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
  void onEvent(String event, String data, List<Uint8List> buffers) {
    for (final e in _eventHandlers) {
      e.onEvent(event, data, buffers);
    }
  }

  @override
  Future<void> release() async {
    _eventHandlers.clear();
  }

  @override
  Future<void> disposeAsync() async {
    await release();
  }
}
