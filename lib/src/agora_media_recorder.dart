import 'package:agora_rtc_engine/src/binding_forward_export.dart';

/// Used for recording audio and video on the client.
/// MediaRecorder can record the following:
///  The audio captured by the local microphone and encoded in AAC format.The video captured by the local camera and encoded by the SDK.
abstract class MediaRecorder {
  /// Registers one MediaRecorderObserver object.
  /// Make sure that RtcEngine is initialized before you call this method.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [callback] The callbacks for recording local audio and video streams. See MediaRecorderObserver .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; you need to catch the exception and handle it accordingly.< 0: Failure.
  Future<void> setMediaRecorderObserver(
      {required RtcConnection connection,
      required MediaRecorderObserver callback});

  /// Starts recording the local audio and video.
  /// After successfully getting the MediaRecorder object by calling getMediaRecorder , you can call this method to enable the recoridng of the local audio and video.This method can record the audio captured by the local microphone and encoded in AAC format, and the video captured by the local camera and encoded in H.264 format. The SDK can generate a recording file only when it detects audio and video streams; when there are no audio and video streams to be recorded or the audio and video streams are interrupted for more than five seconds, the SDK stops the recording and triggers the onRecorderStateChanged(recorderStateError, recorderErrorNoStream) callback.Once the recording is started, if the video resolution is changed, the SDK stops the recording; if the sampling rate and audio channel changes, the SDK continues recording and generates audio files respectively.Call this method after joining a channel.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [config] The recording configuration. See MediaRecorderConfiguration .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; you need to catch the exception and handle it accordingly.< 0: Failure.-2: The parameter is invalid. Ensure the following:The specified path of the recording file exists and is writable.The specified format of the recording file is supported.The maximum recording duration is correctly set.-4: RtcEngine does not support the request. The recording is ongoing or the recording stops because an error occurs.-7: The method is called before RtcEngine is initialized.
  Future<void> startRecording(
      {required RtcConnection connection,
      required MediaRecorderConfiguration config});

  /// Stops recording the local audio and video.
  /// After calling startRecording , if you want to stop the recording, you must call this method; otherwise, the generated recording files may not be playable.
  ///
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; you need to catch the exception and handle it accordingly.< 0: Failure.-7: The method is called before RtcEngine is initialized.
  Future<void> stopRecording(RtcConnection connection);

  /// Release the MediaRecorder object.
  /// This method releases the MediaRecorder object and all resources used by the RtcEngine object. After calling this method, if you need to start recording again, you need to call getMediaRecorder again to get the MediaRecorder object.
  Future<void> release();
}
