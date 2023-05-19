import 'package:agora_rtc_engine/src/binding_forward_export.dart';

/// @nodoc
abstract class MediaRecorder {
  /// @nodoc
  Future<void> setMediaRecorderObserver(
      {required RtcConnection connection,
      required MediaRecorderObserver callback});

  /// @nodoc
  Future<void> startRecording(
      {required RtcConnection connection,
      required MediaRecorderConfiguration config});

  /// @nodoc
  Future<void> stopRecording(RtcConnection connection);

  /// @nodoc
  Future<void> release();
}
