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

  /// Creates a data stream.
  /// Creates a data stream. Each user can create up to five data streams in a single channel.Compared with createDataStreamEx , this method does not support data reliability. If a data packet is not received five seconds after it was sent, the SDK directly discards the data.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [config] The configurations for the data stream. See DataStreamConfig .
  ///
  /// Returns
  /// ID of the created data stream, if the method call succeeds.< 0: Failure.
  Future<void> startRecording(
      {required RtcConnection connection,
      required MediaRecorderConfiguration config});

  /// Enables tracing the video frame rendering process.
  /// By default, the SDK starts tracing the video rendering event automatically when the local user successfully joins the channel. You can call this method at an appropriate time according to the actual application scenario to customize the tracing process.
  ///  After the local user leaves the current channel, the SDK automatically resets the time point to the next time when the user successfully joins the channel.
  ///  The SDK starts tracing the rendering status of the video frames in the channel from the moment this method is successfully called and reports information about the event through the onVideoRenderingTracingResult callback.
  ///
  /// * [connection] The connection information. See RtcConnection .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.< 0: Failure.
  Future<void> stopRecording(RtcConnection connection);

  /// @nodoc
  Future<void> release();
}
