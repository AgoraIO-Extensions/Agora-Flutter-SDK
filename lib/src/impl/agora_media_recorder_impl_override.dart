import 'dart:convert';
import 'dart:typed_data';

import 'package:agora_rtc_engine/src/agora_media_base.dart';
import 'package:agora_rtc_engine/src/binding/agora_media_recorder_impl.dart'
    as media_recorder_impl_binding;
import 'package:agora_rtc_engine/src/binding/agora_media_base_event_impl.dart'
    as media_base_event_b;

import 'package:iris_method_channel/iris_method_channel.dart';

// ignore_for_file: public_member_api_docs, unused_local_variable

class MediaRecorderObserverWrapperOverride
    extends media_base_event_b.MediaRecorderObserverWrapper {
  const MediaRecorderObserverWrapperOverride(
    this.strNativeHandle,
    MediaRecorderObserver mediaRecorderObserver,
  ) : super(mediaRecorderObserver);

  final String strNativeHandle;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is MediaRecorderObserverWrapperOverride &&
        other.mediaRecorderObserver == mediaRecorderObserver &&
        other.strNativeHandle == strNativeHandle;
  }

  @override
  int get hashCode => Object.hash(mediaRecorderObserver, strNativeHandle);

  @override
  bool handleEventInternal(
      String eventName, String eventData, List<Uint8List> buffers) {
    final jsonMap = jsonDecode(eventData);
    final ct = jsonMap['nativeHandle'];
    if (ct == null || ct != strNativeHandle) {
      return false;
    }

    return super.handleEventInternal(eventName, eventData, buffers);
  }
}

class MediaRecorderImpl extends media_recorder_impl_binding.MediaRecorderImpl
    with ScopedDisposableObjectMixin {
  MediaRecorderImpl._(IrisMethodChannel irisMethodChannel, this.strNativeHandle)
      : super(irisMethodChannel);

  factory MediaRecorderImpl.fromNativeHandle(
      IrisMethodChannel irisMethodChannel, String strNativeHandle) {
    return MediaRecorderImpl._(irisMethodChannel, strNativeHandle);
  }

  final TypedScopedKey _mediaRecorderScopedKey =
      const TypedScopedKey(MediaRecorderImpl);

  final String strNativeHandle;

  @override
  Map<String, dynamic> createParams(Map<String, dynamic> param) {
    return {
      'nativeHandle': strNativeHandle,
      ...param,
    };
  }

  @override
  Future<void> setMediaRecorderObserver(MediaRecorderObserver callback) async {
    const apiType = 'MediaRecorder_setMediaRecorderObserver';

    final param = createParams({});

    final eventHandlerWrapper =
        MediaRecorderObserverWrapperOverride(strNativeHandle, callback);

    await irisMethodChannel.registerEventHandler(
        ScopedEvent(
            scopedKey: _mediaRecorderScopedKey,
            registerName: 'MediaRecorder_setMediaRecorderObserver',
            unregisterName: 'MediaRecorder_unsetMediaRecorderObserver',
            handler: eventHandlerWrapper),
        jsonEncode(param));
  }

  @override
  Future<void> dispose() async {
    await irisMethodChannel.unregisterEventHandlers(_mediaRecorderScopedKey);
  }
}
