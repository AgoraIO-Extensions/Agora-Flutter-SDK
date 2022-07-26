import 'package:agora_rtc_engine/src/binding_forward_export.dart';
import 'package:agora_rtc_engine/src/binding/impl_forward_export.dart';
import 'package:iris_event/iris_event.dart';

// ignore_for_file: public_member_api_docs, unused_local_variable

extension AudioEncodedFrameObserverExt on AudioEncodedFrameObserver {
  void process(String event, String data, List<Uint8List> buffers) {
    final jsonMap = jsonDecode(data);
    switch (event) {
      case 'AudioEncodedFrameObserver_OnRecordAudioEncodedFrame':
        if (onRecordAudioEncodedFrame == null) break;
        AudioEncodedFrameObserverOnRecordAudioEncodedFrameJson paramJson =
            AudioEncodedFrameObserverOnRecordAudioEncodedFrameJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        Uint8List? frameBuffer = paramJson.frameBuffer;
        int? length = paramJson.length;
        EncodedAudioFrameInfo? audioEncodedFrameInfo =
            paramJson.audioEncodedFrameInfo;
        if (frameBuffer == null ||
            length == null ||
            audioEncodedFrameInfo == null) {
          break;
        }
        audioEncodedFrameInfo = audioEncodedFrameInfo.fillBuffers(buffers);
        onRecordAudioEncodedFrame!(frameBuffer, length, audioEncodedFrameInfo);
        break;

      case 'AudioEncodedFrameObserver_OnPlaybackAudioEncodedFrame':
        if (onPlaybackAudioEncodedFrame == null) break;
        AudioEncodedFrameObserverOnPlaybackAudioEncodedFrameJson paramJson =
            AudioEncodedFrameObserverOnPlaybackAudioEncodedFrameJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        Uint8List? frameBuffer = paramJson.frameBuffer;
        int? length = paramJson.length;
        EncodedAudioFrameInfo? audioEncodedFrameInfo =
            paramJson.audioEncodedFrameInfo;
        if (frameBuffer == null ||
            length == null ||
            audioEncodedFrameInfo == null) {
          break;
        }
        audioEncodedFrameInfo = audioEncodedFrameInfo.fillBuffers(buffers);
        onPlaybackAudioEncodedFrame!(
            frameBuffer, length, audioEncodedFrameInfo);
        break;

      case 'AudioEncodedFrameObserver_OnMixedAudioEncodedFrame':
        if (onMixedAudioEncodedFrame == null) break;
        AudioEncodedFrameObserverOnMixedAudioEncodedFrameJson paramJson =
            AudioEncodedFrameObserverOnMixedAudioEncodedFrameJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        Uint8List? frameBuffer = paramJson.frameBuffer;
        int? length = paramJson.length;
        EncodedAudioFrameInfo? audioEncodedFrameInfo =
            paramJson.audioEncodedFrameInfo;
        if (frameBuffer == null ||
            length == null ||
            audioEncodedFrameInfo == null) {
          break;
        }
        audioEncodedFrameInfo = audioEncodedFrameInfo.fillBuffers(buffers);
        onMixedAudioEncodedFrame!(frameBuffer, length, audioEncodedFrameInfo);
        break;
      default:
        break;
    }
  }
}

class AudioEncodedFrameObserverWrapper implements IrisEventHandler {
  const AudioEncodedFrameObserverWrapper(this.audioEncodedFrameObserver);
  final AudioEncodedFrameObserver audioEncodedFrameObserver;
  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is AudioEncodedFrameObserverWrapper &&
        other.audioEncodedFrameObserver == audioEncodedFrameObserver;
  }

  @override
  int get hashCode => audioEncodedFrameObserver.hashCode;
  @override
  void onEvent(String event, String data, List<Uint8List> buffers) {
    if (!event.startsWith('AudioEncodedFrameObserver')) return;
    audioEncodedFrameObserver.process(event, data, buffers);
  }
}
