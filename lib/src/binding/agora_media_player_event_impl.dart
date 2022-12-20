import 'package:agora_rtc_engine/src/binding_forward_export.dart';
import 'package:agora_rtc_engine/src/binding/impl_forward_export.dart';
import 'package:agora_rtc_engine/src/impl/event_loop.dart';

// ignore_for_file: public_member_api_docs, unused_local_variable

class MediaPlayerAudioFrameObserverWrapper implements EventLoopEventHandler {
  const MediaPlayerAudioFrameObserverWrapper(
      this.mediaPlayerAudioFrameObserver);
  final MediaPlayerAudioFrameObserver mediaPlayerAudioFrameObserver;
  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is MediaPlayerAudioFrameObserverWrapper &&
        other.mediaPlayerAudioFrameObserver == mediaPlayerAudioFrameObserver;
  }

  @override
  int get hashCode => mediaPlayerAudioFrameObserver.hashCode;
  @override
  bool handleEventInternal(
      String eventName, String eventData, List<Uint8List> buffers) {
    switch (eventName) {
      case 'onFrame':
        if (mediaPlayerAudioFrameObserver.onFrame == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        MediaPlayerAudioFrameObserverOnFrameJson paramJson =
            MediaPlayerAudioFrameObserverOnFrameJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        AudioPcmFrame? frame = paramJson.frame;
        if (frame == null) {
          return true;
        }
        frame = frame.fillBuffers(buffers);
        mediaPlayerAudioFrameObserver.onFrame!(frame);
        return true;
    }
    return false;
  }

  @override
  bool handleEvent(
      String eventName, String eventData, List<Uint8List> buffers) {
    if (!eventName.startsWith('MediaPlayerAudioFrameObserver')) return false;
    final newEvent =
        eventName.replaceFirst('MediaPlayerAudioFrameObserver_', '');
    if (handleEventInternal(newEvent, eventData, buffers)) {
      return true;
    }

    return false;
  }
}

class MediaPlayerVideoFrameObserverWrapper implements EventLoopEventHandler {
  const MediaPlayerVideoFrameObserverWrapper(
      this.mediaPlayerVideoFrameObserver);
  final MediaPlayerVideoFrameObserver mediaPlayerVideoFrameObserver;
  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is MediaPlayerVideoFrameObserverWrapper &&
        other.mediaPlayerVideoFrameObserver == mediaPlayerVideoFrameObserver;
  }

  @override
  int get hashCode => mediaPlayerVideoFrameObserver.hashCode;
  @override
  bool handleEventInternal(
      String eventName, String eventData, List<Uint8List> buffers) {
    switch (eventName) {
      case 'onFrame':
        if (mediaPlayerVideoFrameObserver.onFrame == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        MediaPlayerVideoFrameObserverOnFrameJson paramJson =
            MediaPlayerVideoFrameObserverOnFrameJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        VideoFrame? frame = paramJson.frame;
        if (frame == null) {
          return true;
        }
        frame = frame.fillBuffers(buffers);
        mediaPlayerVideoFrameObserver.onFrame!(frame);
        return true;
    }
    return false;
  }

  @override
  bool handleEvent(
      String eventName, String eventData, List<Uint8List> buffers) {
    if (!eventName.startsWith('MediaPlayerVideoFrameObserver')) return false;
    final newEvent =
        eventName.replaceFirst('MediaPlayerVideoFrameObserver_', '');
    if (handleEventInternal(newEvent, eventData, buffers)) {
      return true;
    }

    return false;
  }
}
