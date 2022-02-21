import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/src/classes.dart';

typedef OnRecorderStateChanged = void Function(
    RecorderState state, RecorderError error);

typedef OnRecorderInfoUpdated = void Function(RecorderInfo info);

class MediaRecorderCallback {
  MediaRecorderCallback({
    this.onRecorderStateChanged,
    this.onRecorderInfoUpdated,
  });

  /// Occurs when the recording state changes.
  ///
  /// When the local audio and video recording state changes, the SDK triggers this
  /// callback to report the current recording state and the reason for the change.
  ///
  /// Parameters
  /// - state	The current recording state:
  ///     - RECORDER_STATE_ERROR(-1): An error occurs during the recording. See error message for the reason.
  ///     - RECORDER_STATE_START(2): The audio and video recording is started.
  ///     - RECORDER_STATE_STOP(3): The audio and video recording is stopped.
  ///
  /// - error	The reason for the state change:
  ///     - RECORDER_ERROR_NONE(0): No error occurs.
  ///     - RECORDER_ERROR_WRITE_FAILED(1): The SDK fails to write the recorded data to a file.
  ///     - RECORDER_ERROR_NO_STREAM(2): The SDK does not detect audio and video streams
  /// to be recorded, or audio and video streams are interrupted for more than five seconds during recording.
  ///     - RECORDER_ERROR_OVER_MAX_DURATION(3): The recording duration exceeds the upper limit.
  ///     - RECORDER_ERROR_CONFIG_CHANGED(4): The recording configuration changes.
  ///     - RECORDER_ERROR_CUSTOM_STREAM_DETECTED(5): The SDK detects audio and video
  /// streams from users using versions of the SDK earlier than v3.0.0 in the COMMUNICATION channel profile.
  OnRecorderStateChanged? onRecorderStateChanged;

  /// Occurs when the recording information is updated.
  ///
  /// After you successfully register this callback and enable the local audio and
  /// video recording, the SDK periodically triggers the onRecorderInfoUpdated callback
  /// based on the set value of recorderInfoUpdateInterval. This callback reports the filename,
  /// duration, and size of the current recording file.
  ///
  /// Parameters
  /// - info	Information for the recording file. See RecorderInfo.
  OnRecorderInfoUpdated? onRecorderInfoUpdated;
}

abstract class AgoraMediaRecorder {
  /// Gets the AgoraMediaRecorder object.
  ///
  /// Note
  ///
  /// Call this method after initializing the RtcEngine object.
  ///
  /// Parameters
  /// - engine	The RtcEngine object. See RtcEngine.
  /// - callback	The IMediaRecorderCallback instance. See IMediaRecorderCallback.
  ///
  /// Returns
  ///
  /// The AgoraMediaRecorder object.
  AgoraMediaRecorder getMediaRecorder(
    RtcEngine engine,
    MediaRecorderCallback callback,
  );

  /// Starts recording the local audio and video.
  ///
  /// After successfully getting the object, you can call this method to enable
  /// the recording of the local audio and video.
  ///
  /// This method can record the following content:
  ///
  /// The audio captured by the local microphone and encoded in AAC format.
  /// The video captured by the local camera and encoded by the SDK.
  /// The SDK can generate a recording file only when it detects the recordable
  /// audio and video streams; when there are no audio and video streams to be recorded
  /// or the audio and video streams are interrupted for more than five seconds,
  /// the SDK stops recording and triggers the onRecorderStateChanged(RECORDER_STATE_ERROR, RECORDER_ERROR_NO_STREAM) callback.
  ///
  /// Note
  ///
  /// Call this method after joining the channel.
  ///
  /// Parameters
  ///
  /// - config	The recording configurations. See MediaRecorderConfiguration.
  ///
  /// Returns
  ///
  /// - 0: Success.
  /// - < 0: Failure:
  ///     - -2(ERR_INVALID_ARGUMENT): The parameter is invalid. Ensure the following:
  ///         - The specified path of the recording file exists and is writable.
  ///         - The specified format of the recording file is supported.
  ///         - The maximum recording duration is correctly set.
  ///     - -4(ERR_NOT_SUPPORTED): RtcEngine does not support the request due to one of the following reasons:
  ///         - The recording is ongoing.
  ///         - The recording stops because an error occurs.
  ///     - -7(ERR_NOT_INITIALIZED): This method is called before the initialization of
  /// RtcEngine. Ensure that you have called getMediaRecorder before calling startRecording.
  Future<void> startRecording(MediaRecorderConfiguration config);

  /// Stops recording the local audio and video.
  ///
  /// Note
  ///
  /// Call this method after calling startRecording.
  ///
  /// Returns
  /// - 0: Success.
  /// - < 0: Failure:
  ///     - -7(ERR_NOT_INITIALIZED): This method is called before the initialization of RtcEngine.
  /// Ensure that you have called getMediaRecorder before calling startRecording.
  Future<void> stopRecording();

  /// Releases the AgoraMediaRecorder object.
  ///
  /// This method releases the RtcEngine object and all other resources used by the
  /// AgoraMediaRecorder object. After calling this method, if you want to enable
  /// the recording again, you must call getMediaRecorder to get the AgoraMediaRecorder object.
  Future<void> release();
}
