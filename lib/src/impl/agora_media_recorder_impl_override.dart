import 'package:agora_rtc_engine/src/binding_forward_export.dart';
import 'package:agora_rtc_engine/src/binding/impl_forward_export.dart';
import 'package:agora_rtc_engine/src/binding/agora_media_recorder_impl.dart'
    as media_recorder_impl_binding;

import 'package:agora_rtc_engine/src/impl/disposable_object.dart';
import 'package:agora_rtc_engine/src/impl/event_loop.dart';

// ignore_for_file: public_member_api_docs, unused_local_variable

class MediaRecorderImpl extends media_recorder_impl_binding.MediaRecorderImpl
    implements AsyncDisposableObject {
  MediaRecorderImpl._(this._eventLoop);

  factory MediaRecorderImpl.create(EventLoop eventLoop) {
    return MediaRecorderImpl._(eventLoop);
  }

  final EventLoop _eventLoop;

  @override
  Future<void> setMediaRecorderObserver(
      {required RtcConnection connection,
      required MediaRecorderObserver callback}) async {
    const apiType = 'MediaRecorder_setMediaRecorderObserver';

    final param = createParams({'connection': connection.toJson()});

    final List<Uint8List> buffers = [];
    buffers.addAll(connection.collectBufferList());

    await apiCaller.callIrisEventAsync(
        const IrisEventObserverKey(
            op: CallIrisEventOp.create,
            registerName: 'MediaRecorder_setMediaRecorderObserver',
            unregisterName: 'MediaRecorder_unsetMediaRecorderObserver'),
        jsonEncode(param));

    _eventLoop.addEventHandler(
      const EventLoopEventHandlerKey(MediaRecorderImpl),
      MediaRecorderObserverWrapper(callback),
    );
  }

  @override
  Future<void> release() async {
    await apiCaller.callIrisEventAsync(
        const IrisEventObserverKey(
            op: CallIrisEventOp.dispose,
            registerName: 'MediaRecorder_setMediaRecorderObserver',
            unregisterName: 'MediaRecorder_unsetMediaRecorderObserver'),
        jsonEncode({}));
    _eventLoop.removeEventHandlers(
      const EventLoopEventHandlerKey(MediaRecorderImpl),
    );
  }

  @override
  Future<void> disposeAsync() async {
    await release();
  }
}
