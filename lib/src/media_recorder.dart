import 'package:agora_rtc_engine/src/classes.dart';
import 'package:agora_rtc_engine/src/event_types.dart';
import 'package:agora_rtc_engine/src/impl/media_recorder_impl.dart';
import 'package:agora_rtc_engine/src/rtc_engine.dart';

///
/// The MediaRecorderObserver class.
///
///
class MediaRecorderObserver {
  /// Constructs the [MediaRecorderObserver].
  MediaRecorderObserver({
    this.onRecorderStateChanged,
    this.onRecorderInfoUpdated,
  });

  ///
  /// Occurs when the local audio and video recording state changes.
  /// When the local audio and video recording state changes, the SDK triggers this callback to report the current recording state and the reason for the change.
  ///
  /// Param [state] The current recording state. See RecorderState .
  ///
  /// Param [error] The reason for the state change. See RecorderErrorCode .
  ///
  OnRecorderStateChanged? onRecorderStateChanged;

  ///
  /// Occurs when the recording information is updated.
  /// After you successfully register this callback and enable the local audio and video recording, the SDK periodically triggers this callback according to the value of recorderInfoUpdateInterval you set in MediaRecorderConfiguration . This callback reports the filename, duration, and size of the current recording file.
  ///
  /// Param [info] Information of the recording file. See RecorderInfo .
  ///
  OnRecorderInfoUpdated? onRecorderInfoUpdated;
}

///
/// Used for recording audio and video on the client.
/// MediaRecorder can record the following: The audio captured by the local microphone and encoded in AAC format.
///  The video captured by the local camera and encoded by the SDK.
///
abstract class MediaRecorder {
  ///
  /// Gets the MediaRecorder object.
  /// Call this method after initializing the RtcEngine object.
  ///
  /// Param [engine] The RtcEngine object.
  ///
  /// Param [callback] The MediaRecorderObserver object.
  ///
  /// **return** The MediaRecorder object.
  ///
  static MediaRecorder getMediaRecorder(RtcEngine engine,
      {MediaRecorderObserver? callback}) {
    return MediaRecorderImpl.getMediaRecorder(engine, callback: callback);
  }

  ///
  /// Starts recording the local audio and video.
  /// After successfully getting the object, you can all this method to enable the recoridng of the local audio and video.
  ///  This method can record the following content: The audio captured by the local microphone and encoded in AAC format.
  ///  The video captured by the local camera and encoded by the SDK. The SDK can generate a recording file only when it detects the recordable audio and video streams; when there are no audio
  ///  and video streams to be recorded or the audio and video streams are interrupted for more than five seconds, the SDK stops
  ///  recording and triggers the onRecorderStateChanged (Error, NoStream) callback.
  ///  Call this method after joining the channel.
  ///
  /// Param [config] The recording configuration. See MediaRecorderConfiguration .
  ///
  /// **return** 0(ERR_OK): Success.
  ///  < 0: Failure. -2(ERR_INVALID_ARGUMANT): The parameter is invalid. Ensure the following: The specified path of the recording file exists and is writable.
  ///  The specified format of the recording file is supported.
  ///  The maximum recording duration is correctly set. -4(ERR_NOT_SUPPORTED): RtcEngine does not support the request due to one of the following reasons: The recording is ongoing.
  ///  The recording stops because an error occurs. -7(ERR_NOT_INITIALIZED): This method is called before the initialization of RtcEngine . Ensure that you have called getMediaRecorder before calling this method.
  ///
  Future<void> startRecording(MediaRecorderConfiguration config);

  ///
  /// Stops recording the local audio and video
  /// After calling startRecording , if you want to stop the recording, you must call this method;
  ///  otherwise, the generated recording files may not be playable.
  ///
  /// **return** 0(ERR_OK): Success.
  ///  < 0: Failure: -7(ERR_NOT_INITIALIZED): This method is called before the initialization of RtcEngine . Ensure that ou have called getMediaRecorder before calling this method.
  ///
  Future<void> stopRecording();

  ///
  /// Releases the MediaRecorder object.
  /// This method releases the RtcEngine object and all the other resources used by MediaRecorder . After calling this method, if you want to enable the recording again, you must call getMediaRecorder to get the MediaRecorder first.
  ///
  Future<void> releaseRecorder();
}
