import 'package:agora_rtc_engine/src/binding_forward_export.dart';

abstract class MediaRecorder {
  Future<void> setMediaRecorderObserver(
      {required RtcConnection connection,
      required MediaRecorderObserver callback});

  Future<void> startRecording(
      {required RtcConnection connection,
      required MediaRecorderConfiguration config});

  Future<void> stopRecording(RtcConnection connection);

  Future<void> release();
}
