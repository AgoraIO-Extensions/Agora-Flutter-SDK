import 'package:agora_rtc_engine/src/binding_forward_export.dart';
import 'package:agora_rtc_engine/src/binding/impl_forward_export.dart';
import 'package:agora_rtc_engine/src/binding/agora_media_recorder_impl.dart'
    as media_recorder_impl_binding;
import 'package:agora_rtc_engine/src/impl/agora_rtc_engine_impl.dart'
    as rtc_engine_impl;
import 'package:agora_rtc_engine/src/impl/disposable_object.dart';
import 'package:iris_event/iris_event.dart';

// ignore_for_file: public_member_api_docs, unused_local_variable

class MediaRecorderImpl extends media_recorder_impl_binding.MediaRecorderImpl
    implements IrisEventHandler, AsyncDisposableObject {
  MediaRecorderImpl._(this._rtcEngine) {
    _rtcEngine.addToPool(MediaRecorderImpl, this);
    apiCaller.addEventHandler(this);
  }

  factory MediaRecorderImpl.create(RtcEngine rtcEngine) {
    return MediaRecorderImpl._(rtcEngine);
  }

  final RtcEngine _rtcEngine;

  final Set<IrisEventHandler> _eventHandlers = {};

  @override
  Future<void> setMediaRecorderObserver(
      {required RtcConnection connection,
      required MediaRecorderObserver callback}) async {
    const apiType = 'MediaRecorder_setMediaRecorderObserver';

    final param = createParams({'connection': connection.toJson()});

    final List<Uint8List> buffers = [];
    buffers.addAll(connection.collectBufferList());

    await apiCaller.callIrisEventAsync(
        const IrisEventHandlerKey(
            op: CallIrisEventOp.create,
            registerName: 'MediaRecorder_setMediaRecorderObserver',
            unregisterName: 'MediaRecorder_unsetMediaRecorderObserver'),
        jsonEncode(param));

    final callApiResult = await apiCaller
        .callIrisApi(apiType, jsonEncode(param), buffers: buffers);

    _eventHandlers.clear();
    _eventHandlers.add(MediaRecorderObserverWrapper(callback));
  }

  @override
  Future<void> release() async {
    if (_eventHandlers.isNotEmpty) {
      await apiCaller.callIrisEventAsync(
          const IrisEventHandlerKey(
              op: CallIrisEventOp.dispose,
              registerName: 'MediaRecorder_setMediaRecorderObserver',
              unregisterName: 'MediaRecorder_unsetMediaRecorderObserver'),
          jsonEncode({}));
      _eventHandlers.clear();
    }
  }

  @override
  void onEvent(String event, String data, List<Uint8List> buffers) {
    for (final e in _eventHandlers) {
      e.onEvent(event, data, buffers);
    }
  }

  @override
  Future<void> disposeAsync() async {
    await release();
  }
}
