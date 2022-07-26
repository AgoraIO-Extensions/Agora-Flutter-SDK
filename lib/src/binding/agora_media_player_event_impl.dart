import 'package:agora_rtc_engine/src/binding_forward_export.dart';
import 'package:agora_rtc_engine/src/binding/impl_forward_export.dart';
import 'package:iris_event/iris_event.dart';

// ignore_for_file: public_member_api_docs, unused_local_variable

extension MediaPlayerAudioFrameObserverExt on MediaPlayerAudioFrameObserver {
  void process(String event, String data, List<Uint8List> buffers) {
    final jsonMap = jsonDecode(data);
    switch (event) {
      case 'MediaPlayerAudioFrameObserver_onFrame':
        if (onFrame == null) break;
        MediaPlayerAudioFrameObserverOnFrameJson paramJson =
            MediaPlayerAudioFrameObserverOnFrameJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        AudioPcmFrame? frame = paramJson.frame;
        if (frame == null) {
          break;
        }
        frame = frame.fillBuffers(buffers);
        onFrame!(frame);
        break;
      default:
        break;
    }
  }
}

class MediaPlayerAudioFrameObserverWrapper implements IrisEventHandler {
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
  void onEvent(String event, String data, List<Uint8List> buffers) {
    if (!event.startsWith('MediaPlayerAudioFrameObserver')) return;
    mediaPlayerAudioFrameObserver.process(event, data, buffers);
  }
}

extension MediaPlayerVideoFrameObserverExt on MediaPlayerVideoFrameObserver {
  void process(String event, String data, List<Uint8List> buffers) {
    final jsonMap = jsonDecode(data);
    switch (event) {
      case 'MediaPlayerVideoFrameObserver_onFrame':
        if (onFrame == null) break;
        MediaPlayerVideoFrameObserverOnFrameJson paramJson =
            MediaPlayerVideoFrameObserverOnFrameJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        VideoFrame? frame = paramJson.frame;
        if (frame == null) {
          break;
        }
        frame = frame.fillBuffers(buffers);
        onFrame!(frame);
        break;
      default:
        break;
    }
  }
}

class MediaPlayerVideoFrameObserverWrapper implements IrisEventHandler {
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
  void onEvent(String event, String data, List<Uint8List> buffers) {
    if (!event.startsWith('MediaPlayerVideoFrameObserver')) return;
    mediaPlayerVideoFrameObserver.process(event, data, buffers);
  }
}
