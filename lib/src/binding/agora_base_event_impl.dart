import 'package:agora_rtc_engine/src/binding_forward_export.dart';
import 'package:agora_rtc_engine/src/binding/impl_forward_export.dart';
import 'package:agora_rtc_engine/src/impl/event_loop.dart';

// ignore_for_file: public_member_api_docs, unused_local_variable

class AudioEncodedFrameObserverWrapper implements EventLoopEventHandler {
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
  bool handleEventInternal(
      String eventName, String eventData, List<Uint8List> buffers) {
    switch (eventName) {
      case 'OnRecordAudioEncodedFrame':
        if (audioEncodedFrameObserver.onRecordAudioEncodedFrame == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
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
          return true;
        }
        audioEncodedFrameInfo = audioEncodedFrameInfo.fillBuffers(buffers);
        audioEncodedFrameObserver.onRecordAudioEncodedFrame!(
            frameBuffer, length, audioEncodedFrameInfo);
        return true;

      case 'OnPlaybackAudioEncodedFrame':
        if (audioEncodedFrameObserver.onPlaybackAudioEncodedFrame == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
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
          return true;
        }
        audioEncodedFrameInfo = audioEncodedFrameInfo.fillBuffers(buffers);
        audioEncodedFrameObserver.onPlaybackAudioEncodedFrame!(
            frameBuffer, length, audioEncodedFrameInfo);
        return true;

      case 'OnMixedAudioEncodedFrame':
        if (audioEncodedFrameObserver.onMixedAudioEncodedFrame == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
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
          return true;
        }
        audioEncodedFrameInfo = audioEncodedFrameInfo.fillBuffers(buffers);
        audioEncodedFrameObserver.onMixedAudioEncodedFrame!(
            frameBuffer, length, audioEncodedFrameInfo);
        return true;
    }
    return false;
  }

  @override
  bool handleEvent(
      String eventName, String eventData, List<Uint8List> buffers) {
    if (!eventName.startsWith('AudioEncodedFrameObserver')) return false;
    final newEvent = eventName.replaceFirst('AudioEncodedFrameObserver_', '');
    if (handleEventInternal(newEvent, eventData, buffers)) {
      return true;
    }

    return false;
  }
}
