import 'package:agora_rtc_engine/src/binding_forward_export.dart';

/// This class provides APIs for local and remote recording.
abstract class MediaRecorder {
  /// Registers one MediaRecorderObserver oberver.
  /// This method is used to set the callbacks of audio and video recording, so as to notify the app of the recording status and information of the audio and video stream during recording.Before calling this method, ensure the following:The RtcEngine object is created and initialized.The recording object is created through createMediaRecorder .
  ///
  /// * [callback] The callbacks for recording audio and video streams. See MediaRecorderObserver .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.< 0: Failure.
  Future<void> setMediaRecorderObserver(
      {required RtcConnection connection,
      required MediaRecorderObserver callback});

  /// Starts recording audio and video streams.
  /// You can call this method to enable the recording function. Agora supports recording the media streams of local and remote users at the same time.Before you call this method, ensure the following:The recording object is created through createMediaRecorder .The recording observer is registered through setMediaRecorderObserver .You have joined the channel which the remote user that you want to record is in.Supported formats of recording are listed as below:AAC-encoded audio captured by the microphone.Video captured by a camera and encoded in H.264 or H.265.Once the recording is started, if the video resolution is changed, the SDK stops the recording; if the sampling rate and audio channel changes, the SDK continues recording and generates audio files respectively.The SDK can generate a recording file only when it detects audio and video streams; when there are no audio and video streams to be recorded or the audio and video streams are interrupted for more than five seconds, the SDK stops the recording and triggers the onRecorderStateChanged(recorderStateError, recorderErrorNoStream) callback.If you want to record the media streams of the local user, ensure the role of the local user is set as broadcaster.If you want to record the media streams of a remote user, ensure you have subscribed to the user's media streams before starting the recording.
  ///
  /// * [config] The recording configuration. See MediaRecorderConfiguration .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.< 0: Failure.-2: The parameter is invalid. Ensure the following:The specified path of the recording file exists and is writable.The specified format of the recording file is supported.The maximum recording duration is correctly set.-4: RtcEngine does not support the request. The recording is ongoing or the recording stops because an error occurs.-7: The method is called before RtcEngine is initialized. Ensure the MediaRecorder object is created before calling this method.
  Future<void> startRecording(
      {required RtcConnection connection,
      required MediaRecorderConfiguration config});

  /// Stops recording audio and video streams.
  /// After calling startRecording , if you want to stop the recording, you must call this method; otherwise, the generated recording files may not be playable.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.< 0: Failure.-7: The method is called before RtcEngine is initialized. Ensure the MediaRecorder object is created before calling this method.
  Future<void> stopRecording(RtcConnection connection);

  /// @nodoc
  Future<void> release();
}
