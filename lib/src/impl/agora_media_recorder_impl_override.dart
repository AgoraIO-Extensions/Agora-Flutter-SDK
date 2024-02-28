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

class _MediaRecorderScopedKey extends TypedScopedKey {
  const _MediaRecorderScopedKey(Type type, this.strNativeHandle) : super(type);
  final String strNativeHandle;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is _MediaRecorderScopedKey &&
        other.type == type &&
        other.strNativeHandle == strNativeHandle;
  }

  @override
  int get hashCode => Object.hash(type, strNativeHandle);
}

class MediaRecorderImpl extends media_recorder_impl_binding.MediaRecorderImpl
    with ScopedDisposableObjectMixin {
  MediaRecorderImpl._(IrisMethodChannel irisMethodChannel, this.strNativeHandle)
      : super(irisMethodChannel) {
    _mediaRecorderScopedKey =
        _MediaRecorderScopedKey(MediaRecorderImpl, strNativeHandle);
  }

  factory MediaRecorderImpl.fromNativeHandle(
      IrisMethodChannel irisMethodChannel, String strNativeHandle) {
    return MediaRecorderImpl._(irisMethodChannel, strNativeHandle);
  }

  late final TypedScopedKey _mediaRecorderScopedKey;

  final String strNativeHandle;

  MediaRecorderObserverWrapperOverride? _mediaRecorderObserver;

  @override
  Map<String, dynamic> createParams(Map<String, dynamic> param) {
    return {
      'nativeHandle': strNativeHandle,
      ...param,
    };
  }

  @override
  Future<void> setMediaRecorderObserver(MediaRecorderObserver callback) async {
    const apiType = 'MediaRecorder_setMediaRecorderObserver_e1f7340';

    final param = createParams({});

    _mediaRecorderObserver =
        MediaRecorderObserverWrapperOverride(strNativeHandle, callback);

    await irisMethodChannel.registerEventHandler(
        ScopedEvent(
            scopedKey: _mediaRecorderScopedKey,
            registerName: 'MediaRecorder_setMediaRecorderObserver_e1f7340',
            unregisterName: 'MediaRecorder_unsetMediaRecorderObserver',
            handler: _mediaRecorderObserver!),
        jsonEncode(param));
  }

  @override
  Future<void> dispose() async {
    if (_mediaRecorderObserver == null) {
      return;
    }

    final param = createParams({});
    await irisMethodChannel.unregisterEventHandler(
        ScopedEvent(
            scopedKey: _mediaRecorderScopedKey,
            registerName: 'MediaRecorder_setMediaRecorderObserver_e1f7340',
            unregisterName: 'MediaRecorder_unsetMediaRecorderObserver',
            handler: _mediaRecorderObserver!),
        jsonEncode(param));
    _mediaRecorderObserver = null;
  }
}
