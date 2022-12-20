import 'package:agora_rtc_engine/src/binding_forward_export.dart';
import 'package:agora_rtc_engine/src/binding/impl_forward_export.dart';
import 'package:agora_rtc_engine/src/binding/agora_media_recorder_impl.dart'
    as media_recorder_impl_binding;
import 'package:agora_rtc_engine/src/binding/agora_media_base_event_impl.dart'
    as media_base_event_b;

import 'package:agora_rtc_engine/src/impl/disposable_object.dart';
import 'package:agora_rtc_engine/src/impl/event_loop.dart';

// ignore_for_file: public_member_api_docs, unused_local_variable

class MediaRecorderObserverWrapperOverride
    extends media_base_event_b.MediaRecorderObserverWrapper {
  const MediaRecorderObserverWrapperOverride(
    this.connection,
    MediaRecorderObserver mediaRecorderObserver,
  ) : super(mediaRecorderObserver);

  final RtcConnection connection;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is MediaRecorderObserverWrapperOverride &&
        other.mediaRecorderObserver == mediaRecorderObserver &&
        other.connection == connection;
  }

  @override
  int get hashCode => Object.hash(mediaRecorderObserver, connection);

  @override
  bool handleEvent(
      String eventName, String eventData, List<Uint8List> buffers) {
    if (!eventName.startsWith('MediaRecorderObserver')) return false;
    final newEvent = eventName.replaceFirst('MediaRecorderObserver_', '');

    final jsonMap = jsonDecode(eventData);
    final ct = jsonMap['connection'];
    if (ct == null) {
      return false;
    }

    final rtcConnection = RtcConnection.fromJson(ct);

    if (rtcConnection.channelId != connection.channelId ||
        rtcConnection.localUid != connection.localUid) {
      return false;
    }

    if (handleEventInternal(newEvent, eventData, buffers)) {
      return true;
    }

    return false;
  }
}

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

    final eventHandlerWrapper =
        MediaRecorderObserverWrapperOverride(connection, callback);
    await apiCaller.callIrisEventAsync(
        IrisEventObserverKey(
          op: CallIrisEventOp.create,
          registerName: 'MediaRecorder_setMediaRecorderObserver',
          unregisterName: 'MediaRecorder_unsetMediaRecorderObserver',
          handler: eventHandlerWrapper,
        ),
        jsonEncode(param));

    _eventLoop.addEventHandlerIfAbsent(
      const EventLoopEventHandlerKey(MediaRecorderImpl),
      eventHandlerWrapper,
    );
  }

  @override
  Future<void> release() async {
    await apiCaller.callIrisEventAsync(
        IrisEventObserverKey(
          op: CallIrisEventOp.dispose,
          registerName: 'MediaRecorder_setMediaRecorderObserver',
          unregisterName: 'MediaRecorder_unsetMediaRecorderObserver',
          handler: null,
        ),
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
