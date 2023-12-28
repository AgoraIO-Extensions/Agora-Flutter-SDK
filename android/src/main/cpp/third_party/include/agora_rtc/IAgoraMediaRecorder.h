//
//  Agora SDK
//
//  Copyright (c) 2022 Agora.io. All rights reserved.
//
#pragma once  // NOLINT(build/header_guard)

#include "AgoraBase.h"
#include "AgoraMediaBase.h"
#include "IAgoraRtcEngineEx.h"

namespace agora {
namespace rtc {

class IMediaRecorder : public RefCountInterface {
 protected:
  virtual ~IMediaRecorder() {}

 public:
  /**
   * Registers the IMediaRecorderObserver object.
   *
   * @since v4.0.0
   *
   * @note Call this method before the startRecording method.
   *
   * @param callback The callbacks for recording audio and video streams. See \ref IMediaRecorderObserver.
   *
   * @return
   * - 0(ERR_OK): Success.
   * - < 0: Failure:
   */
  virtual int setMediaRecorderObserver(media::IMediaRecorderObserver* callback) = 0;
  /**
   * Starts recording the local or remote audio and video.
   *
   * @since v4.0.0
   *
   * After successfully calling \ref IRtcEngine::createMediaRecorder "createMediaRecorder" to get the media recorder object
   * , you can call this method to enable the recording of the local audio and video.
   *
   * This method can record the following content:
   * - The audio captured by the local microphone and encoded in AAC format.
   * - The video captured by the local camera and encoded by the SDK.
   * - The audio received from remote users and encoded in AAC format.
   * - The video received from remote users.
   * 
   * The SDK can generate a recording file only when it detects the recordable audio and video streams; when there are
   * no audio and video streams to be recorded or the audio and video streams are interrupted for more than five
   * seconds, the SDK stops recording and triggers the
   * \ref IMediaRecorderObserver::onRecorderStateChanged "onRecorderStateChanged" (RECORDER_STATE_ERROR, RECORDER_ERROR_NO_STREAM)
   * callback.
   *
   * @note Call this method after joining the channel.
   *
   * @param config The recording configurations. See MediaRecorderConfiguration.
   *
   * @return
   * - 0(ERR_OK): Success.
   * - < 0: Failure:
   *    - `-1(ERR_FAILED)`: IRtcEngine does not support the request because the remote user did not subscribe to the target channel or the media streams published by the local user during remote recording.
   *    - `-2(ERR_INVALID_ARGUMENT)`: The parameter is invalid. Ensure the following:
   *      - The specified path of the recording file exists and is writable.
   *      - The specified format of the recording file is supported.
   *      - The maximum recording duration is correctly set.
   *      - During remote recording, ensure the user whose media streams you want record did join the channel.
   *    - `-4(ERR_NOT_SUPPORTED)`: IRtcEngine does not support the request due to one of the following reasons:
   *      - The recording is ongoing.
   *      - The recording stops because an error occurs.
   *      - No \ref IMediaRecorderObserver object is registered.
   */
  virtual int startRecording(const media::MediaRecorderConfiguration& config) = 0;
  /**
   * Stops recording the audio and video.
   *
   * @since v4.0.0
   *
   * @note After calling \ref IMediaRecorder::startRecording "startRecording", if you want to stop the recording,
   * you must call `stopRecording`; otherwise, the generated recording files might not be playable.
   *
   *
   * @return
   * - 0(ERR_OK): Success.
   * - < 0: Failure:
   */
  virtual int stopRecording() = 0;
};

} //namespace rtc
} // namespace agora
