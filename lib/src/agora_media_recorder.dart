import 'package:agora_rtc_engine/src/binding_forward_export.dart';

abstract class MediaRecorder {
  Future<void> setMediaRecorderObserver(MediaRecorderObserver callback);

  Future<void> startRecording(MediaRecorderConfiguration config);

  Future<void> stopRecording();
}
