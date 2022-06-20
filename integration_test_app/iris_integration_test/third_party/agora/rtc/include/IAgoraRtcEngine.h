//
//  AgoraRtcEngine SDK
//
//  Copyright (c) 2019 Agora.io. All rights reserved.
//

/**
 @defgroup createAgoraRtcEngine Create an AgoraRtcEngine
 */

#ifndef AGORA_RTC_ENGINE_H
#define AGORA_RTC_ENGINE_H
#include "AgoraBase.h"
#include "IAgoraService.h"
#include "IAgoraLog.h"

#include "IAgoraMediaEngine.h"
#if defined(TARGET_OS_IPHONE) && TARGET_OS_IPHONE /* Warning fixing. Lionfore Oct 12th, 2019 */
#include <CoreVideo/CVPixelBuffer.h>
#endif

namespace agora {
namespace rtc {
/** The IMediaRecorderObserver class.
 *
 * @since v3.5.2
 */
class IMediaRecorderObserver;
/**
 * The MediaRecorderConfiguration struct.
 *
 * @since v3.5.2
 */
struct MediaRecorderConfiguration;
typedef unsigned int uid_t;
typedef void* view_t;
/** Maximum length of the device ID.
 */
enum MAX_DEVICE_ID_LENGTH_TYPE {
  /** The maximum length of the device ID is 512 bytes.
   */
  MAX_DEVICE_ID_LENGTH = 512
};
/** Maximum length of user account.
 */
enum MAX_USER_ACCOUNT_LENGTH_TYPE {
  /** The maximum length of user account is 255 bytes.
   */
  MAX_USER_ACCOUNT_LENGTH = 256
};
/** Maximum length of channel ID.
 */
enum MAX_CHANNEL_ID_LENGTH_TYPE {
  /** The maximum length of channel id is 64 bytes.
   */
  MAX_CHANNEL_ID_LENGTH = 65
};
/** Formats of the quality report.
 */
enum QUALITY_REPORT_FORMAT_TYPE {
  /** 0: The quality report in JSON format,
   */
  QUALITY_REPORT_JSON = 0,
  /** 1: The quality report in HTML format.
   */
  QUALITY_REPORT_HTML = 1,
};
/// @cond nodoc
enum MEDIA_ENGINE_EVENT_CODE_TYPE {
  /** 0: For internal use only.
   */
  MEDIA_ENGINE_RECORDING_ERROR = 0,
  /** 1: For internal use only.
   */
  MEDIA_ENGINE_PLAYOUT_ERROR = 1,
  /** 2: For internal use only.
   */
  MEDIA_ENGINE_RECORDING_WARNING = 2,
  /** 3: For internal use only.
   */
  MEDIA_ENGINE_PLAYOUT_WARNING = 3,
  /** 10: For internal use only.
   */
  MEDIA_ENGINE_AUDIO_FILE_MIX_FINISH = 10,
  /** 12: For internal use only.
   */
  MEDIA_ENGINE_AUDIO_FAREND_MUSIC_BEGINS = 12,
  /** 13: For internal use only.
   */
  MEDIA_ENGINE_AUDIO_FAREND_MUSIC_ENDS = 13,
  /** 14: For internal use only.
   */
  MEDIA_ENGINE_LOCAL_AUDIO_RECORD_ENABLED = 14,
  /** 15: For internal use only.
   */
  MEDIA_ENGINE_LOCAL_AUDIO_RECORD_DISABLED = 15,
  // media engine role changed
  /** 20: For internal use only.
   */
  MEDIA_ENGINE_ROLE_BROADCASTER_SOLO = 20,
  /** 21: For internal use only.
   */
  MEDIA_ENGINE_ROLE_BROADCASTER_INTERACTIVE = 21,
  /** 22: For internal use only.
   */
  MEDIA_ENGINE_ROLE_AUDIENCE = 22,
  /** 23: For internal use only.
   */
  MEDIA_ENGINE_ROLE_COMM_PEER = 23,
  /** 24: For internal use only.
   */
  MEDIA_ENGINE_ROLE_GAME_PEER = 24,
  /** 30: For internal use only.
   */
  MEDIA_ENGINE_AUDIO_AIRPLAY_CONNECTED = 30,

  // iOS adm sample rate changed
  /** 110: For internal use only.
   */
  MEDIA_ENGINE_AUDIO_ADM_REQUIRE_RESTART = 110,
  /** 111: For internal use only.
   */
  MEDIA_ENGINE_AUDIO_ADM_SPECIAL_RESTART = 111,
  /** 112: For internal use only.
   */
  MEDIA_ENGINE_AUDIO_ADM_USING_COMM_PARAMS = 112,
  /** 113: For internal use only.
   */
  MEDIA_ENGINE_AUDIO_ADM_USING_NORM_PARAMS = 113,
  /** 114: For internal use only.
   */
  MEDIA_ENGINE_AUDIO_ADM_ROUTING_UPDATE = 114,
  // audio mix event
  /** 720: For internal use only.
   */
  MEDIA_ENGINE_AUDIO_EVENT_MIXING_STARTED_BY_USER = 720,
  /** 721: For internal use only.
   */
  MEDIA_ENGINE_AUDIO_EVENT_MIXING_ONE_LOOP_COMPLETED = 721,
  /** 722: For internal use only.
   */
  MEDIA_ENGINE_AUDIO_EVENT_MIXING_START_NEW_LOOP = 722,
  /** 723: For internal use only.
   */
  MEDIA_ENGINE_AUDIO_EVENT_MIXING_ALL_LOOPS_COMPLETED = 723,
  /** 724: For internal use only.
   */
  MEDIA_ENGINE_AUDIO_EVENT_MIXING_STOPPED_BY_USER = 724,
  /** 725: For internal use only.
   */
  MEDIA_ENGINE_AUDIO_EVENT_MIXING_PAUSED_BY_USER = 725,
  /** 726: For internal use only.
   */
  MEDIA_ENGINE_AUDIO_EVENT_MIXING_RESUMED_BY_USER = 726,
  // Mixing error codes
  /** 701: For internal use only.
   */
  MEDIA_ENGINE_AUDIO_ERROR_MIXING_OPEN = 701,
  /** 702: For internal use only.
   */
  MEDIA_ENGINE_AUDIO_ERROR_MIXING_TOO_FREQUENT = 702,
  /** 703: The audio mixing file playback is interrupted. For internal use only.
   */
  MEDIA_ENGINE_AUDIO_ERROR_MIXING_INTERRUPTED_EOF = 703,
  /** 0: For internal use only.
   */
  MEDIA_ENGINE_AUDIO_ERROR_MIXING_NO_ERROR = 0,
};
/// @endcond

/** The current music file playback state.
 *
 * Reports in the \ref IRtcEngineEventHandler::onAudioMixingStateChanged "onAudioMixingStateChanged" callback.
 */
enum AUDIO_MIXING_STATE_TYPE {
  /** 710: The music file is playing.
   *
   * This state comes with one of the following associated reasons:
   * - #AUDIO_MIXING_REASON_STARTED_BY_USER (720)
   * - #AUDIO_MIXING_REASON_ONE_LOOP_COMPLETED (721)
   * - #AUDIO_MIXING_REASON_START_NEW_LOOP (722)
   * - #AUDIO_MIXING_REASON_RESUMED_BY_USER (726)
   */
  AUDIO_MIXING_STATE_PLAYING = 710,
  /** 711: The music file pauses playing.
   *
   * This state comes with #AUDIO_MIXING_REASON_PAUSED_BY_USER (725).
   */
  AUDIO_MIXING_STATE_PAUSED = 711,
  /** 713: The music file stops playing.
   *
   * This state comes with one of the following associated reasons:
   * - #AUDIO_MIXING_REASON_ALL_LOOPS_COMPLETED (723)
   * - #AUDIO_MIXING_REASON_STOPPED_BY_USER (724)
   */
  AUDIO_MIXING_STATE_STOPPED = 713,
  /** 714: An exception occurs during the playback of the music file.
   *
   * This state comes with one of the following associated reasons:
   * - #AUDIO_MIXING_REASON_CAN_NOT_OPEN (701)
   * - #AUDIO_MIXING_REASON_TOO_FREQUENT_CALL (702)
   * - #AUDIO_MIXING_REASON_INTERRUPTED_EOF (703)
   */
  AUDIO_MIXING_STATE_FAILED = 714,
};

/**
 * @deprecated Deprecated from v3.4.0. Use #AUDIO_MIXING_REASON_TYPE instead.
 *
 * The error codes of the local user's audio mixing file.
 */
enum AGORA_DEPRECATED_ATTRIBUTE AUDIO_MIXING_ERROR_TYPE {
  /** 701: The SDK cannot open the audio mixing file.
   */
  AUDIO_MIXING_ERROR_CAN_NOT_OPEN = 701,
  /** 702: The SDK opens the audio mixing file too frequently.
   */
  AUDIO_MIXING_ERROR_TOO_FREQUENT_CALL = 702,
  /** 703: The audio mixing file playback is interrupted.
   */
  AUDIO_MIXING_ERROR_INTERRUPTED_EOF = 703,
  /** 0: The SDK can open the audio mixing file.
   */
  AUDIO_MIXING_ERROR_OK = 0,
};

/** The reason for the change of the music file playback state.
 *
 * @since v3.4.0
 *
 * Reports in the \ref IRtcEngineEventHandler::onAudioMixingStateChanged "onAudioMixingStateChanged" callback.
 */
enum AUDIO_MIXING_REASON_TYPE {
  /** 701: The SDK cannot open the music file. Possible causes include the local
   * music file does not exist, the SDK does not support the file format, or the
   * SDK cannot access the music file URL.
   */
  AUDIO_MIXING_REASON_CAN_NOT_OPEN = 701,
  /** 702: The SDK opens the music file too frequently. If you need to call
   * \ref IRtcEngine::startAudioMixing(const char*,bool,bool,int,int) "startAudioMixing" multiple times, ensure
   * that the call interval is longer than 500 ms.
   */
  AUDIO_MIXING_REASON_TOO_FREQUENT_CALL = 702,
  /** 703: The music file playback is interrupted.
   */
  AUDIO_MIXING_REASON_INTERRUPTED_EOF = 703,
  /** 720: Successfully calls \ref IRtcEngine::startAudioMixing(const char*,bool,bool,int,int) "startAudioMixing"
   * to play a music file.
   */
  AUDIO_MIXING_REASON_STARTED_BY_USER = 720,
  /** 721: The music file completes a loop playback.
   */
  AUDIO_MIXING_REASON_ONE_LOOP_COMPLETED = 721,
  /** 722: The music file starts a new loop playback.
   */
  AUDIO_MIXING_REASON_START_NEW_LOOP = 722,
  /** 723: The music file completes all loop playback.
   */
  AUDIO_MIXING_REASON_ALL_LOOPS_COMPLETED = 723,
  /** 724: Successfully calls \ref IRtcEngine::stopAudioMixing "stopAudioMixing"
   * to stop playing the music file.
   */
  AUDIO_MIXING_REASON_STOPPED_BY_USER = 724,
  /** 725: Successfully calls \ref IRtcEngine::pauseAudioMixing "pauseAudioMixing"
   * to pause playing the music file.
   */
  AUDIO_MIXING_REASON_PAUSED_BY_USER = 725,
  /** 726: Successfully calls \ref IRtcEngine::resumeAudioMixing "resumeAudioMixing"
   * to resume playing the music file.
   */
  AUDIO_MIXING_REASON_RESUMED_BY_USER = 726,
};

/** Media device states.
 */
enum MEDIA_DEVICE_STATE_TYPE {
  /** 0: The device is ready for use.
   *
   * @since v3.4.5
   */
  MEDIA_DEVICE_STATE_IDLE = 0,
  /** 1: The device is in use.
   *
   * @since v3.4.5
   */
  MEDIA_DEVICE_STATE_ACTIVE = 1,
  /** 2: The device is disabled.
   */
  MEDIA_DEVICE_STATE_DISABLED = 2,
  /** 4: The device is not present.
   */
  MEDIA_DEVICE_STATE_NOT_PRESENT = 4,
  /** 8: The device is unplugged.
   */
  MEDIA_DEVICE_STATE_UNPLUGGED = 8,
  /** 16: The device is not recommended.
   */
  MEDIA_DEVICE_STATE_UNRECOMMENDED = 16,
};

/** Media device types.
 */
enum MEDIA_DEVICE_TYPE {
  /** -1: Unknown device type.
   */
  UNKNOWN_AUDIO_DEVICE = -1,
  /** 0: Audio playback device.
   */
  AUDIO_PLAYOUT_DEVICE = 0,
  /** 1: Audio capturing device.
   */
  AUDIO_RECORDING_DEVICE = 1,
  /** 2: Video renderer.
   */
  VIDEO_RENDER_DEVICE = 2,
  /** 3: Video capturer.
   */
  VIDEO_CAPTURE_DEVICE = 3,
  /** 4: Application audio playback device.
   */
  AUDIO_APPLICATION_PLAYOUT_DEVICE = 4,
};

/** Local video state types.
 */
enum LOCAL_VIDEO_STREAM_STATE {
  /** 0: Initial state. */
  LOCAL_VIDEO_STREAM_STATE_STOPPED = 0,
  /** 1: The local video capturing device starts successfully.
   *
   * The SDK also reports this state when you share a maximized window by calling \ref IRtcEngine::startScreenCaptureByWindowId "startScreenCaptureByWindowId".
   */
  LOCAL_VIDEO_STREAM_STATE_CAPTURING = 1,
  /** 2: The first video frame is successfully encoded. */
  LOCAL_VIDEO_STREAM_STATE_ENCODING = 2,
  /** 3: The local video fails to start. */
  LOCAL_VIDEO_STREAM_STATE_FAILED = 3
};

/** Local video state error codes.
 */
enum LOCAL_VIDEO_STREAM_ERROR {
  /** 0: The local video is normal. */
  LOCAL_VIDEO_STREAM_ERROR_OK = 0,
  /** 1: No specified reason for the local video failure. */
  LOCAL_VIDEO_STREAM_ERROR_FAILURE = 1,
  /** 2: The application does not have permission to start the local video capture device. Remind your user to grant permission and rejoin the channel. */
  LOCAL_VIDEO_STREAM_ERROR_DEVICE_NO_PERMISSION = 2,
  /** 3: The local video capture device is in use. Check whether the camera is occupied by another application or try to rejoin the channel. */
  LOCAL_VIDEO_STREAM_ERROR_DEVICE_BUSY = 3,
  /** 4: The local video capture failed. Check whether the video capture device is working properly, check whether the camera is occupied by another application, or try to rejoin the channel. */
  LOCAL_VIDEO_STREAM_ERROR_CAPTURE_FAILURE = 4,
  /** 5: The local video encoding fails. */
  LOCAL_VIDEO_STREAM_ERROR_ENCODE_FAILURE = 5,
  /** 6: (iOS only) The application is in the background. Remind your user that the application cannot capture video properly when the application is in the background.
   *
   * @since v3.3.0
   */
  LOCAL_VIDEO_STREAM_ERROR_CAPTURE_INBACKGROUND = 6,
  /** 7: (iOS only) The application is running in Slide Over, Split View, or Picture in Picture mode. Remind your user that the application cannot capture video properly when the application is running in Slide Over, Split View, or Picture in Picture mode.
   *
   * @since v3.3.0
   */
  LOCAL_VIDEO_STREAM_ERROR_CAPTURE_MULTIPLE_FOREGROUND_APPS = 7,
  /**
   * 8: The SDK cannot find the local video capture device. Check whether the camera is connected to the device properly, check whether the camera is working properly, or try to rejoin the channel.
   *
   * @since v3.4.0
   */
  LOCAL_VIDEO_STREAM_ERROR_DEVICE_NOT_FOUND = 8,
  /**
   * 9: (macOS only) The external camera currently in use is disconnected
   * (such as being unplugged).
   *
   * @since v3.5.0
   */
  LOCAL_VIDEO_STREAM_ERROR_DEVICE_DISCONNECTED = 9,
  /**
   * 10: (macOS and Windows only) The SDK cannot find the video device in the video device list. Check whether the ID
   * of the video device is valid.
   *
   * @since v3.5.2
   */
  LOCAL_VIDEO_STREAM_ERROR_DEVICE_INVALID_ID = 10,
  /**
   * 11: The shared window is minimized when you call
   * \ref IRtcEngine::startScreenCaptureByWindowId "startScreenCaptureByWindowId"
   * to share a window. Remind your user that the window cannot be shared properly when the shared window is minimized.
   */
  LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_MINIMIZED = 11,
  /** 12: The error code indicates that a window shared by the window ID has been closed, or a full-screen window
   * shared by the window ID has exited full-screen mode.
   * After exiting full-screen mode, remote users cannot see the shared window. To prevent remote users from seeing a
   * black screen, Agora recommends that you immediately stop screen sharing.
   *
   * Common scenarios for reporting this error code:
   * - When the local user closes the shared window, the SDK reports this error code.
   * - The local user shows some slides in full-screen mode first, and then shares the windows of the slides. After
   * the user exits full-screen mode, the SDK reports this error code.
   * - The local user watches web video or reads web document in full-screen mode first, and then shares the window of
   * the web video or document. After the user exits full-screen mode, the SDK reports this error code.
   */
  LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_CLOSED = 12,
  /**
   * 13: (Windows only) The window being shared is overlapped by another window, so the overlapped area is blacked out by
   * the SDK during window sharing.
   *
   * @since v3.5.2
   */
  LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_OCCLUDED = 13,
  /**
   * 20: (Windows only) The SDK does not support sharing this type of window.Remind your user that the current type of window is not supported for sharing.
   *
   * @deprecated Deprecated from v3.7.0.As of v3.7.0, the SDK no longer throws this error code and automatically adjusts the capture method to capture more types of windows.
   *
   */
  LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_NOT_SUPPORTED AGORA_DEPRECATED_ATTRIBUTE = 20,
};

/** Local audio state types.
 */
enum LOCAL_AUDIO_STREAM_STATE {
  /** 0: The local audio is in the initial state.
   */
  LOCAL_AUDIO_STREAM_STATE_STOPPED = 0,
  /** 1: The capturing device starts successfully.
   */
  LOCAL_AUDIO_STREAM_STATE_RECORDING = 1,
  /** 2: The first audio frame encodes successfully.
   */
  LOCAL_AUDIO_STREAM_STATE_ENCODING = 2,
  /** 3: The local audio fails to start.
   */
  LOCAL_AUDIO_STREAM_STATE_FAILED = 3
};

/** Local audio state error codes.
 */
enum LOCAL_AUDIO_STREAM_ERROR {
  /** 0: The local audio is normal.
   */
  LOCAL_AUDIO_STREAM_ERROR_OK = 0,
  /** 1: No specified reason for the local audio error.
   */
  LOCAL_AUDIO_STREAM_ERROR_FAILURE = 1,
  /** 2: The application does not have permission to start the local audio capture device. Remind your user to grant permission.
   */
  LOCAL_AUDIO_STREAM_ERROR_DEVICE_NO_PERMISSION = 2,
  /** 3: The local audio capture device is in use. Check whether the microphone is occupied by another application, or try to rejoin the channel.
   */
  LOCAL_AUDIO_STREAM_ERROR_DEVICE_BUSY = 3,
  /** 4: The local audio capture failed. Check whether the audio capture device is working properly.
   */
  LOCAL_AUDIO_STREAM_ERROR_RECORD_FAILURE = 4,
  /** 5: The local audio encoding failed.
   */
  LOCAL_AUDIO_STREAM_ERROR_ENCODE_FAILURE = 5,
  /** 6: The application cannot find the local audio capture device. Check whether the microphone is connected to the device properly or the microphone is working properly.
   *
   * @since v3.4.0
   */
  LOCAL_AUDIO_STREAM_ERROR_NO_RECORDING_DEVICE = 6,
  /** 7: The application cannot find the local audio playback device. Check whether the speaker is connected to the device properly or the speaker is working properly.
   *
   * @since v3.4.0
   */
  LOCAL_AUDIO_STREAM_ERROR_NO_PLAYOUT_DEVICE = 7,
  /**
   * 8: The local audio capture is interrupted by a system call. If the local audio capture is required, remind your user to hang up the phone.
   */
  LOCAL_AUDIO_STREAM_ERROR_INTERRUPTED = 8,
  /** 9: The ID of the local audio-capture device is invalid. Check the audio capture device ID.
   *
   * @since v3.5.1
   */
  LOCAL_AUDIO_STREAM_ERROR_RECORD_INVALID_ID = 9,
  /** 10: The ID of the local audio-playback device is invalid. Check the audio playback device ID.
   *
   * @since v3.5.1
   */
  LOCAL_AUDIO_STREAM_ERROR_PLAYOUT_INVALID_ID = 10,
};

/** Audio recording quality, which is set in
 * \ref IRtcEngine::startAudioRecording(const AudioRecordingConfiguration&) "startAudioRecording".
 */
enum AUDIO_RECORDING_QUALITY_TYPE {
  /** 0: Low quality. For example, the size of an AAC file with a sample rate
   * of 32,000 Hz and a 10-minute recording is approximately 1.2 MB.
   */
  AUDIO_RECORDING_QUALITY_LOW = 0,
  /** 1: (Default) Medium quality. For example, the size of an AAC file with
   * a sample rate of 32,000 Hz and a 10-minute recording is approximately
   * 2 MB.
   */
  AUDIO_RECORDING_QUALITY_MEDIUM = 1,
  /** 2: High quality. For example, the size of an AAC file with a sample rate
   * of 32,000 Hz and a 10-minute recording is approximately 3.75 MB.
   */
  AUDIO_RECORDING_QUALITY_HIGH = 2,
  /** 3: Ultra high quality. For example, the size of an AAC file with a sample rate
   * of 32,000 Hz and a 10-minute recording is approximately 7.5 MB.
   *
   * @since v3.6.2
   */
  AUDIO_RECORDING_QUALITY_ULTRA_HIGH = 3,
};

/** Network quality types. */
enum QUALITY_TYPE {
  /** 0: The network quality is unknown. */
  QUALITY_UNKNOWN = 0,
  /**  1: The network quality is excellent. */
  QUALITY_EXCELLENT = 1,
  /** 2: The network quality is quite good, but the bitrate may be slightly lower than excellent. */
  QUALITY_GOOD = 2,
  /** 3: Users can feel the communication slightly impaired. */
  QUALITY_POOR = 3,
  /** 4: Users cannot communicate smoothly. */
  QUALITY_BAD = 4,
  /** 5: The network is so bad that users can barely communicate. */
  QUALITY_VBAD = 5,
  /** 6: The network is down and users cannot communicate at all. */
  QUALITY_DOWN = 6,
  /** 7: Users cannot detect the network quality. (Not in use.) */
  QUALITY_UNSUPPORTED = 7,
  /** 8: Detecting the network quality. */
  QUALITY_DETECTING = 8,
};

/** Video display modes. */
enum RENDER_MODE_TYPE {
  /**
1: Uniformly scale the video until it fills the visible boundaries (cropped). One dimension of the video may have clipped contents.
 */
  RENDER_MODE_HIDDEN = 1,
  /**
2: Uniformly scale the video until one of its dimension fits the boundary (zoomed to fit). Areas that are not filled due to disparity in the aspect ratio are filled with black.
*/
  RENDER_MODE_FIT = 2,
  /** **DEPRECATED** 3: This mode is deprecated.
   */
  RENDER_MODE_ADAPTIVE = 3,
  /**
  4: The fill mode. In this mode, the SDK stretches or zooms the video to fill the display window.
  */
  RENDER_MODE_FILL = 4,
};

/** Video mirror modes. */
enum VIDEO_MIRROR_MODE_TYPE {
  /** 0: (Default) The SDK enables the mirror mode.
   */
  VIDEO_MIRROR_MODE_AUTO = 0,  // determined by SDK
  /** 1: Enable mirror mode. */
  VIDEO_MIRROR_MODE_ENABLED = 1,  // enabled mirror
  /** 2: Disable mirror mode. */
  VIDEO_MIRROR_MODE_DISABLED = 2,  // disable mirror
};

/** @deprecated Video profiles. */
enum AGORA_DEPRECATED_ATTRIBUTE VIDEO_PROFILE_TYPE {
  /** 0: 160 * 120, frame rate 15 fps, bitrate 65 Kbps. */
  VIDEO_PROFILE_LANDSCAPE_120P = 0,
  /** 2: 120 * 120, frame rate 15 fps, bitrate 50 Kbps. */
  VIDEO_PROFILE_LANDSCAPE_120P_3 = 2,
  /** 10: 320*180, frame rate 15 fps, bitrate 140 Kbps. */
  VIDEO_PROFILE_LANDSCAPE_180P = 10,
  /** 12: 180 * 180, frame rate 15 fps, bitrate 100 Kbps. */
  VIDEO_PROFILE_LANDSCAPE_180P_3 = 12,
  /** 13: 240 * 180, frame rate 15 fps, bitrate 120 Kbps. */
  VIDEO_PROFILE_LANDSCAPE_180P_4 = 13,
  /** 20: 320 * 240, frame rate 15 fps, bitrate 200 Kbps. */
  VIDEO_PROFILE_LANDSCAPE_240P = 20,
  /** 22: 240 * 240, frame rate 15 fps, bitrate 140 Kbps. */
  VIDEO_PROFILE_LANDSCAPE_240P_3 = 22,
  /** 23: 424 * 240, frame rate 15 fps, bitrate 220 Kbps. */
  VIDEO_PROFILE_LANDSCAPE_240P_4 = 23,
  /** 30: 640 * 360, frame rate 15 fps, bitrate 400 Kbps. */
  VIDEO_PROFILE_LANDSCAPE_360P = 30,
  /** 32: 360 * 360, frame rate 15 fps, bitrate 260 Kbps. */
  VIDEO_PROFILE_LANDSCAPE_360P_3 = 32,
  /** 33: 640 * 360, frame rate 30 fps, bitrate 600 Kbps. */
  VIDEO_PROFILE_LANDSCAPE_360P_4 = 33,
  /** 35: 360 * 360, frame rate 30 fps, bitrate 400 Kbps. */
  VIDEO_PROFILE_LANDSCAPE_360P_6 = 35,
  /** 36: 480 * 360, frame rate 15 fps, bitrate 320 Kbps. */
  VIDEO_PROFILE_LANDSCAPE_360P_7 = 36,
  /** 37: 480 * 360, frame rate 30 fps, bitrate 490 Kbps. */
  VIDEO_PROFILE_LANDSCAPE_360P_8 = 37,
  /** 38: 640 * 360, frame rate 15 fps, bitrate 800 Kbps.
   @note `LIVE_BROADCASTING` profile only.
   */
  VIDEO_PROFILE_LANDSCAPE_360P_9 = 38,
  /** 39: 640 * 360, frame rate 24 fps, bitrate 800 Kbps.
   @note `LIVE_BROADCASTING` profile only.
   */
  VIDEO_PROFILE_LANDSCAPE_360P_10 = 39,
  /** 100: 640 * 360, frame rate 24 fps, bitrate 1000 Kbps.
   @note `LIVE_BROADCASTING` profile only.
   */
  VIDEO_PROFILE_LANDSCAPE_360P_11 = 100,
  /** 40: 640 * 480, frame rate 15 fps, bitrate 500 Kbps. */
  VIDEO_PROFILE_LANDSCAPE_480P = 40,
  /** 42: 480 * 480, frame rate 15 fps, bitrate 400 Kbps. */
  VIDEO_PROFILE_LANDSCAPE_480P_3 = 42,
  /** 43: 640 * 480, frame rate 30 fps, bitrate 750 Kbps. */
  VIDEO_PROFILE_LANDSCAPE_480P_4 = 43,
  /** 45: 480 * 480, frame rate 30 fps, bitrate 600 Kbps. */
  VIDEO_PROFILE_LANDSCAPE_480P_6 = 45,
  /** 47: 848 * 480, frame rate 15 fps, bitrate 610 Kbps. */
  VIDEO_PROFILE_LANDSCAPE_480P_8 = 47,
  /** 48: 848 * 480, frame rate 30 fps, bitrate 930 Kbps. */
  VIDEO_PROFILE_LANDSCAPE_480P_9 = 48,
  /** 49: 640 * 480, frame rate 10 fps, bitrate 400 Kbps. */
  VIDEO_PROFILE_LANDSCAPE_480P_10 = 49,
  /** 50: 1280 * 720, frame rate 15 fps, bitrate 1130 Kbps. */
  VIDEO_PROFILE_LANDSCAPE_720P = 50,
  /** 52: 1280 * 720, frame rate 30 fps, bitrate 1710 Kbps. */
  VIDEO_PROFILE_LANDSCAPE_720P_3 = 52,
  /** 54: 960 * 720, frame rate 15 fps, bitrate 910 Kbps. */
  VIDEO_PROFILE_LANDSCAPE_720P_5 = 54,
  /** 55: 960 * 720, frame rate 30 fps, bitrate 1380 Kbps. */
  VIDEO_PROFILE_LANDSCAPE_720P_6 = 55,
  /** 60: 1920 * 1080, frame rate 15 fps, bitrate 2080 Kbps. */
  VIDEO_PROFILE_LANDSCAPE_1080P = 60,
  /** 62: 1920 * 1080, frame rate 30 fps, bitrate 3150 Kbps. */
  VIDEO_PROFILE_LANDSCAPE_1080P_3 = 62,
  /** 64: 1920 * 1080, frame rate 60 fps, bitrate 4780 Kbps. */
  VIDEO_PROFILE_LANDSCAPE_1080P_5 = 64,
  /** 66: 2560 * 1440, frame rate 30 fps, bitrate 4850 Kbps. */
  VIDEO_PROFILE_LANDSCAPE_1440P = 66,
  /** 67: 2560 * 1440, frame rate 60 fps, bitrate 6500 Kbps. */
  VIDEO_PROFILE_LANDSCAPE_1440P_2 = 67,
  /** 70: 3840 * 2160, frame rate 30 fps, bitrate 6500 Kbps. */
  VIDEO_PROFILE_LANDSCAPE_4K = 70,
  /** 72: 3840 * 2160, frame rate 60 fps, bitrate 6500 Kbps. */
  VIDEO_PROFILE_LANDSCAPE_4K_3 = 72,
  /** 1000: 120 * 160, frame rate 15 fps, bitrate 65 Kbps. */
  VIDEO_PROFILE_PORTRAIT_120P = 1000,
  /** 1002: 120 * 120, frame rate 15 fps, bitrate 50 Kbps. */
  VIDEO_PROFILE_PORTRAIT_120P_3 = 1002,
  /** 1010: 180 * 320, frame rate 15 fps, bitrate 140 Kbps. */
  VIDEO_PROFILE_PORTRAIT_180P = 1010,
  /** 1012: 180 * 180, frame rate 15 fps, bitrate 100 Kbps. */
  VIDEO_PROFILE_PORTRAIT_180P_3 = 1012,
  /** 1013: 180 * 240, frame rate 15 fps, bitrate 120 Kbps. */
  VIDEO_PROFILE_PORTRAIT_180P_4 = 1013,
  /** 1020: 240 * 320, frame rate 15 fps, bitrate 200 Kbps. */
  VIDEO_PROFILE_PORTRAIT_240P = 1020,
  /** 1022: 240 * 240, frame rate 15 fps, bitrate 140 Kbps. */
  VIDEO_PROFILE_PORTRAIT_240P_3 = 1022,
  /** 1023: 240 * 424, frame rate 15 fps, bitrate 220 Kbps. */
  VIDEO_PROFILE_PORTRAIT_240P_4 = 1023,
  /** 1030: 360 * 640, frame rate 15 fps, bitrate 400 Kbps. */
  VIDEO_PROFILE_PORTRAIT_360P = 1030,
  /** 1032: 360 * 360, frame rate 15 fps, bitrate 260 Kbps. */
  VIDEO_PROFILE_PORTRAIT_360P_3 = 1032,
  /** 1033: 360 * 640, frame rate 30 fps, bitrate 600 Kbps. */
  VIDEO_PROFILE_PORTRAIT_360P_4 = 1033,
  /** 1035: 360 * 360, frame rate 30 fps, bitrate 400 Kbps. */
  VIDEO_PROFILE_PORTRAIT_360P_6 = 1035,
  /** 1036: 360 * 480, frame rate 15 fps, bitrate 320 Kbps. */
  VIDEO_PROFILE_PORTRAIT_360P_7 = 1036,
  /** 1037: 360 * 480, frame rate 30 fps, bitrate 490 Kbps. */
  VIDEO_PROFILE_PORTRAIT_360P_8 = 1037,
  /** 1038: 360 * 640, frame rate 15 fps, bitrate 800 Kbps.
   @note `LIVE_BROADCASTING` profile only.
   */
  VIDEO_PROFILE_PORTRAIT_360P_9 = 1038,
  /** 1039: 360 * 640, frame rate 24 fps, bitrate 800 Kbps.
   @note `LIVE_BROADCASTING` profile only.
   */
  VIDEO_PROFILE_PORTRAIT_360P_10 = 1039,
  /** 1100: 360 * 640, frame rate 24 fps, bitrate 1000 Kbps.
   @note `LIVE_BROADCASTING` profile only.
   */
  VIDEO_PROFILE_PORTRAIT_360P_11 = 1100,
  /** 1040: 480 * 640, frame rate 15 fps, bitrate 500 Kbps. */
  VIDEO_PROFILE_PORTRAIT_480P = 1040,
  /** 1042: 480 * 480, frame rate 15 fps, bitrate 400 Kbps. */
  VIDEO_PROFILE_PORTRAIT_480P_3 = 1042,
  /** 1043: 480 * 640, frame rate 30 fps, bitrate 750 Kbps. */
  VIDEO_PROFILE_PORTRAIT_480P_4 = 1043,
  /** 1045: 480 * 480, frame rate 30 fps, bitrate 600 Kbps. */
  VIDEO_PROFILE_PORTRAIT_480P_6 = 1045,
  /** 1047: 480 * 848, frame rate 15 fps, bitrate 610 Kbps. */
  VIDEO_PROFILE_PORTRAIT_480P_8 = 1047,
  /** 1048: 480 * 848, frame rate 30 fps, bitrate 930 Kbps. */
  VIDEO_PROFILE_PORTRAIT_480P_9 = 1048,
  /** 1049: 480 * 640, frame rate 10 fps, bitrate 400 Kbps. */
  VIDEO_PROFILE_PORTRAIT_480P_10 = 1049,
  /** 1050: 720 * 1280, frame rate 15 fps, bitrate 1130 Kbps. */
  VIDEO_PROFILE_PORTRAIT_720P = 1050,
  /** 1052: 720 * 1280, frame rate 30 fps, bitrate 1710 Kbps. */
  VIDEO_PROFILE_PORTRAIT_720P_3 = 1052,
  /** 1054: 720 * 960, frame rate 15 fps, bitrate 910 Kbps. */
  VIDEO_PROFILE_PORTRAIT_720P_5 = 1054,
  /** 1055: 720 * 960, frame rate 30 fps, bitrate 1380 Kbps. */
  VIDEO_PROFILE_PORTRAIT_720P_6 = 1055,
  /** 1060: 1080 * 1920, frame rate 15 fps, bitrate 2080 Kbps. */
  VIDEO_PROFILE_PORTRAIT_1080P = 1060,
  /** 1062: 1080 * 1920, frame rate 30 fps, bitrate 3150 Kbps. */
  VIDEO_PROFILE_PORTRAIT_1080P_3 = 1062,
  /** 1064: 1080 * 1920, frame rate 60 fps, bitrate 4780 Kbps. */
  VIDEO_PROFILE_PORTRAIT_1080P_5 = 1064,
  /** 1066: 1440 * 2560, frame rate 30 fps, bitrate 4850 Kbps. */
  VIDEO_PROFILE_PORTRAIT_1440P = 1066,
  /** 1067: 1440 * 2560, frame rate 60 fps, bitrate 6500 Kbps. */
  VIDEO_PROFILE_PORTRAIT_1440P_2 = 1067,
  /** 1070: 2160 * 3840, frame rate 30 fps, bitrate 6500 Kbps. */
  VIDEO_PROFILE_PORTRAIT_4K = 1070,
  /** 1072: 2160 * 3840, frame rate 60 fps, bitrate 6500 Kbps. */
  VIDEO_PROFILE_PORTRAIT_4K_3 = 1072,
  /** Default 640 * 360, frame rate 15 fps, bitrate 400 Kbps. */
  VIDEO_PROFILE_DEFAULT = VIDEO_PROFILE_LANDSCAPE_360P,
};

/** Audio profiles.

Sets the sample rate, bitrate, encoding mode, and the number of channels:*/
enum AUDIO_PROFILE_TYPE  // sample rate, bit rate, mono/stereo, speech/music codec
{
  /**
   * 0: Default audio profile:
   * - For the `LIVE_BROADCASTING` profile: A sample rate of 48 KHz, music encoding, mono, and a bitrate of up to 64 Kbps.
   * - For the `COMMUNICATION` profile:
   *    - Windows: A sample rate of 16 KHz, audio encoding, mono, and a bitrate of up to 16 Kbps.
   *    - Android/macOS/iOS: A sample rate of 32 KHz, audio encoding, mono, and a bitrate of up to 18 Kbps.
   */
  AUDIO_PROFILE_DEFAULT = 0,  // use default settings
  /**
   1: A sample rate of 32 KHz, audio encoding, mono, and a bitrate of up to 18 Kbps.
   */
  AUDIO_PROFILE_SPEECH_STANDARD = 1,  // 32Khz, 18Kbps, mono, speech
  /**
   2: A sample rate of 48 KHz, music encoding, mono, and a bitrate of up to 64 Kbps.
   */
  AUDIO_PROFILE_MUSIC_STANDARD = 2,  // 48Khz, 48Kbps, mono, music
  /**
   3: A sample rate of 48 KHz, music encoding, stereo, and a bitrate of up to 80 Kbps.
   */
  AUDIO_PROFILE_MUSIC_STANDARD_STEREO = 3,  // 48Khz, 56Kbps, stereo, music
  /**
   4: A sample rate of 48 KHz, music encoding, mono, and a bitrate of up to 96 Kbps.
   */
  AUDIO_PROFILE_MUSIC_HIGH_QUALITY = 4,  // 48Khz, 128Kbps, mono, music
  /**
   5: A sample rate of 48 KHz, music encoding, stereo, and a bitrate of up to 128 Kbps.
   */
  AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO = 5,  // 48Khz, 192Kbps, stereo, music
  /**
   6: A sample rate of 16 KHz, audio encoding, mono, and Acoustic Echo Cancellation (AES) enabled.
   */
  AUDIO_PROFILE_IOT = 6,
  /// @cond nodoc
  AUDIO_PROFILE_NUM = 7,
  /// @endcond
};

/** Audio application scenarios.
 */
enum AUDIO_SCENARIO_TYPE  // set a suitable scenario for your app type
{
  /** 0: Default audio scenario.
   *
   * @note If you run the iOS app on an M1 Mac, due to the hardware differences
   * between M1 Macs, iPhones, and iPads, the default audio scenario of the Agora
   * iOS SDK is the same as that of the Agora macOS SDK.
   */
  AUDIO_SCENARIO_DEFAULT = 0,
  /** 1: Entertainment scenario where users need to frequently switch the user role. */
  AUDIO_SCENARIO_CHATROOM_ENTERTAINMENT = 1,
  /** 2: Education scenario where users want smoothness and stability. */
  AUDIO_SCENARIO_EDUCATION = 2,
  /** 3: High-quality audio chatroom scenario where hosts mainly play music. */
  AUDIO_SCENARIO_GAME_STREAMING = 3,
  /** 4: Showroom scenario where a single host wants high-quality audio. */
  AUDIO_SCENARIO_SHOWROOM = 4,
  /** 5: Gaming scenario for group chat that only contains the human voice. */
  AUDIO_SCENARIO_CHATROOM_GAMING = 5,
  /** 6: IoT (Internet of Things) scenario where users use IoT devices with low power consumption. */
  AUDIO_SCENARIO_IOT = 6,
  /** 8: Meeting scenario that mainly contains the human voice.
   *
   * @since v3.2.0
   */
  AUDIO_SCENARIO_MEETING = 8,
  /** The number of elements in the enumeration.
   */
  AUDIO_SCENARIO_NUM = 9,
};

/** The channel profile.
 */
enum CHANNEL_PROFILE_TYPE {
  /** Communication. This profile applies to scenarios such as an audio call or video call,
   * where all users can publish and subscribe to streams.
   */
  CHANNEL_PROFILE_COMMUNICATION = 0,
  /** Live streaming. In this profile, uses have roles, namely, host and audience (default).
   * A host both publishes and subscribes to streams, while an audience subscribes to streams only.
   * This profile applies to scenarios such as a chat room or interactive video streaming.
   */
  CHANNEL_PROFILE_LIVE_BROADCASTING = 1,
  /** 2: Gaming. This profile uses a codec with a lower bitrate and consumes less power. Applies to the gaming scenario, where all game players can talk freely.
   *
   * @note Agora does not recommend using this setting.
   */
  CHANNEL_PROFILE_GAME = 2,
};

/** The role of a user in interactive live streaming. */
enum CLIENT_ROLE_TYPE {
  /** 1: Host. A host can both send and receive streams. */
  CLIENT_ROLE_BROADCASTER = 1,
  /** 2: (Default) Audience. An `audience` member can only receive streams. */
  CLIENT_ROLE_AUDIENCE = 2,
};

/** The latency level of an audience member in interactive live streaming.
 *
 * @note Takes effect only when the user role is `CLIENT_ROLE_AUDIENCE`.
 */
enum AUDIENCE_LATENCY_LEVEL_TYPE {
  /** 1: Low latency. */
  AUDIENCE_LATENCY_LEVEL_LOW_LATENCY = 1,
  /** 2: (Default) Ultra low latency. */
  AUDIENCE_LATENCY_LEVEL_ULTRA_LOW_LATENCY = 2,
};

/**
 * The reason why super resolution is not successfully enabled or the message
 * that confirms success.
 *
 * @since v3.5.1
 */
enum SUPER_RESOLUTION_STATE_REASON {
  /** 0: Super resolution is successfully enabled.
   */
  SR_STATE_REASON_SUCCESS = 0,
  /** 1: The original resolution of the remote video is beyond the range where
   * super resolution can be applied.
   */
  SR_STATE_REASON_STREAM_OVER_LIMITATION = 1,
  /** 2: Super resolution is already being used to boost another remote user's video.
   */
  SR_STATE_REASON_USER_COUNT_OVER_LIMITATION = 2,
  /** 3: The device does not support using super resolution.
   */
  SR_STATE_REASON_DEVICE_NOT_SUPPORTED = 3,
};

/**
 * The reason why the virtual background is not successfully enabled or the message that confirms success.
 *
 * @since v3.4.5
 */
enum VIRTUAL_BACKGROUND_SOURCE_STATE_REASON {
  /**
   * 0: The virtual background is successfully enabled.
   */
  VIRTUAL_BACKGROUND_SOURCE_STATE_REASON_SUCCESS = 0,
  /**
   * 1: The custom background image does not exist. Please check the value of `source` in VirtualBackgroundSource.
   */
  VIRTUAL_BACKGROUND_SOURCE_STATE_REASON_IMAGE_NOT_EXIST = 1,
  /**
   * 2: The color format of the custom background image is invalid. Please check the value of `color` in VirtualBackgroundSource.
   */
  VIRTUAL_BACKGROUND_SOURCE_STATE_REASON_COLOR_FORMAT_NOT_SUPPORTED = 2,
  /**
   * 3: The device does not support using the virtual background.
   */
  VIRTUAL_BACKGROUND_SOURCE_STATE_REASON_DEVICE_NOT_SUPPORTED = 3,
};
/// @cond nodoc
enum CONTENT_INSPECT_RESULT {
  CONTENT_INSPECT_NEUTRAL = 1,
  CONTENT_INSPECT_SEXY = 2,
  CONTENT_INSPECT_PORN = 3,
};
/// @endcond

/** Reasons for a user being offline. */
enum USER_OFFLINE_REASON_TYPE {
  /** 0: The user quits the call. */
  USER_OFFLINE_QUIT = 0,
  /** 1: The SDK times out and the user drops offline because no data packet is received within a certain period of time. If the user quits the call and the message is not passed to the SDK (due to an unreliable channel), the SDK assumes the user dropped offline. */
  USER_OFFLINE_DROPPED = 1,
  /** 2: (`LIVE_BROADCASTING` only.) The client role switched from the host to the audience. */
  USER_OFFLINE_BECOME_AUDIENCE = 2,
};
/**
 States of the RTMP or RTMPS streaming.
 */
enum RTMP_STREAM_PUBLISH_STATE {
  /** The RTMP or RTMPS streaming has not started or has ended. This state is also triggered after you remove an RTMP or RTMPS stream from the CDN by calling `removePublishStreamUrl`.
   */
  RTMP_STREAM_PUBLISH_STATE_IDLE = 0,
  /** The SDK is connecting to Agora's streaming server and the CDN server. This state is triggered after you call the \ref IRtcEngine::addPublishStreamUrl "addPublishStreamUrl" method.
   */
  RTMP_STREAM_PUBLISH_STATE_CONNECTING = 1,
  /** The RTMP or RTMPS streaming publishes. The SDK successfully publishes the RTMP or RTMPS streaming and returns this state.
   */
  RTMP_STREAM_PUBLISH_STATE_RUNNING = 2,
  /** The RTMP or RTMPS streaming is recovering. When exceptions occur to the CDN, or the streaming is interrupted, the SDK tries to resume RTMP or RTMPS streaming and returns this state.

   - If the SDK successfully resumes the streaming, #RTMP_STREAM_PUBLISH_STATE_RUNNING (2) returns.
   - If the streaming does not resume within 60 seconds or server errors occur, #RTMP_STREAM_PUBLISH_STATE_FAILURE (4) returns. You can also reconnect to the server by calling the \ref IRtcEngine::removePublishStreamUrl "removePublishStreamUrl" and \ref IRtcEngine::addPublishStreamUrl "addPublishStreamUrl" methods.
   */
  RTMP_STREAM_PUBLISH_STATE_RECOVERING = 3,
  /** The RTMP or RTMPS streaming fails. See the errCode parameter for the detailed error information. You can also call the \ref IRtcEngine::addPublishStreamUrl "addPublishStreamUrl" method to publish the RTMP or RTMPS streaming again.
   */
  RTMP_STREAM_PUBLISH_STATE_FAILURE = 4,
  /** The SDK is disconnecting from the Agora streaming server and CDN.
   * When you call remove or stop to stop the streaming normally, the SDK reports the streaming state as `DISCONNECTING`, `IDLE` in sequence.
   *
   * @since v3.6.0
   */
  RTMP_STREAM_PUBLISH_STATE_DISCONNECTING = 5,
};

/**
 Error codes of the RTMP or RTMPS streaming.
 */
enum RTMP_STREAM_PUBLISH_ERROR_TYPE {
  /** 0: The RTMP or RTMPS streaming publishes successfully. */
  RTMP_STREAM_PUBLISH_ERROR_OK = 0,
  /** 1: Invalid argument used. If, for example, you do not call the \ref IRtcEngine::setLiveTranscoding "setLiveTranscoding" method to configure the LiveTranscoding parameters before calling the addPublishStreamUrl method, the SDK returns this error. Check whether you set the parameters in the *setLiveTranscoding* method properly. */
  RTMP_STREAM_PUBLISH_ERROR_INVALID_ARGUMENT = 1,
  /** 2: The RTMP or RTMPS streaming is encrypted and cannot be published. */
  RTMP_STREAM_PUBLISH_ERROR_ENCRYPTED_STREAM_NOT_ALLOWED = 2,
  /** 3: Timeout for the RTMP or RTMPS streaming. Call the \ref IRtcEngine::addPublishStreamUrl "addPublishStreamUrl" method to publish the streaming again. */
  RTMP_STREAM_PUBLISH_ERROR_CONNECTION_TIMEOUT = 3,
  /** 4: An error occurs in Agora's streaming server. Call the `addPublishStreamUrl` method to publish the streaming again. */
  RTMP_STREAM_PUBLISH_ERROR_INTERNAL_SERVER_ERROR = 4,
  /** 5: An error occurs in the CDN server. */
  RTMP_STREAM_PUBLISH_ERROR_RTMP_SERVER_ERROR = 5,
  /** 6: Reserved. */
  RTMP_STREAM_PUBLISH_ERROR_TOO_OFTEN = 6,
  /** 7: The host publishes more than 10 URLs. Delete the unnecessary URLs before adding new ones. */
  RTMP_STREAM_PUBLISH_ERROR_REACH_LIMIT = 7,
  /** 8: The host manipulates other hosts' URLs. Check your app logic. */
  RTMP_STREAM_PUBLISH_ERROR_NOT_AUTHORIZED = 8,
  /** 9: Agora's server fails to find the RTMP or RTMPS streaming. */
  RTMP_STREAM_PUBLISH_ERROR_STREAM_NOT_FOUND = 9,
  /** 10: The format of the RTMP or RTMPS streaming URL is not supported. Check whether the URL format is correct. */
  RTMP_STREAM_PUBLISH_ERROR_FORMAT_NOT_SUPPORTED = 10,
  /**
   * 11: The user role is not host, so the user cannot use the CDN live streaming function.
   * Check your application code logic.
   *
   * @since v3.6.0
   */
  RTMP_STREAM_PUBLISH_ERROR_NOT_BROADCASTER = 11,  // Note: match to ERR_PUBLISH_STREAM_NOT_BROADCASTER in AgoraBase.h
  /**
   * 13: The `updateRtmpTranscoding` or `setLiveTranscoding` method is called to update the transcoding configuration in a scenario where there is streaming without transcoding.
   * Check your application code logic.
   *
   * @since v3.6.0
   */
  RTMP_STREAM_PUBLISH_ERROR_TRANSCODING_NO_MIX_STREAM = 13,  // Note: match to ERR_PUBLISH_STREAM_TRANSCODING_NO_MIX_STREAM in AgoraBase.h
  /**
   * 14: Errors occurred in the host's network.
   *
   * @since v3.6.0
   */
  RTMP_STREAM_PUBLISH_ERROR_NET_DOWN = 14,  // Note: match to ERR_NET_DOWN in AgoraBase.h
  /**
   * 15: Your App ID does not have permission to use the CDN live streaming function.
   * Refer to [Prerequisites](https://docs.agora.io/en/Interactive%20Broadcast/cdn_streaming_windows?platform=Windows#prerequisites) to
   * enable the CDN live streaming permission.
   *
   * @since v3.6.0
   */
  RTMP_STREAM_PUBLISH_ERROR_INVALID_APPID = 15,  // Note: match to ERR_PUBLISH_STREAM_APPID_INVALID in AgoraBase.h
  /**
   * 100: The streaming has been stopped normally. After you call
   * \ref IRtcEngine::removePublishStreamUrl "removePublishStreamUrl"
   * to stop streaming, the SDK returns this value.
   *
   * @since v3.4.5
   */
  RTMP_STREAM_UNPUBLISH_ERROR_OK = 100,
};

/** Events during the RTMP or RTMPS streaming. */
enum RTMP_STREAMING_EVENT {
  /** 1: An error occurs when you add a background image or a watermark image to the RTMP or RTMPS stream.
   */
  RTMP_STREAMING_EVENT_FAILED_LOAD_IMAGE = 1,
  /** 2: The streaming URL is already being used for CDN live streaming. If you want to start new streaming, use a new streaming URL.
   *
   * @since v3.4.5
   */
  RTMP_STREAMING_EVENT_URL_ALREADY_IN_USE = 2,
  /** 3: The feature is not supported.
   *
   * @since v3.6.0
   */
  RTMP_STREAMING_EVENT_ADVANCED_FEATURE_NOT_SUPPORT = 3,
  /** 4: Reserved.
   *
   * @since v3.6.0
   */
  RTMP_STREAMING_EVENT_REQUEST_TOO_OFTEN = 4,
};

/** States of importing an external video stream in the interactive live streaming. */
enum INJECT_STREAM_STATUS {
  /** 0: The external video stream imported successfully. */
  INJECT_STREAM_STATUS_START_SUCCESS = 0,
  /** 1: The external video stream already exists. */
  INJECT_STREAM_STATUS_START_ALREADY_EXISTS = 1,
  /** 2: The external video stream to be imported is unauthorized. */
  INJECT_STREAM_STATUS_START_UNAUTHORIZED = 2,
  /** 3: Import external video stream timeout. */
  INJECT_STREAM_STATUS_START_TIMEDOUT = 3,
  /** 4: Import external video stream failed. */
  INJECT_STREAM_STATUS_START_FAILED = 4,
  /** 5: The external video stream stopped importing successfully. */
  INJECT_STREAM_STATUS_STOP_SUCCESS = 5,
  /** 6: No external video stream is found. */
  INJECT_STREAM_STATUS_STOP_NOT_FOUND = 6,
  /** 7: The external video stream to be stopped importing is unauthorized. */
  INJECT_STREAM_STATUS_STOP_UNAUTHORIZED = 7,
  /** 8: Stop importing external video stream timeout. */
  INJECT_STREAM_STATUS_STOP_TIMEDOUT = 8,
  /** 9: Stop importing external video stream failed. */
  INJECT_STREAM_STATUS_STOP_FAILED = 9,
  /** 10: The external video stream is corrupted. */
  INJECT_STREAM_STATUS_BROKEN = 10,
};
/** Remote video stream types. */
enum REMOTE_VIDEO_STREAM_TYPE {
  /** 0: High-stream video. */
  REMOTE_VIDEO_STREAM_HIGH = 0,
  /** 1: Low-stream video. */
  REMOTE_VIDEO_STREAM_LOW = 1,
};
/** The brightness level of the video image captured by the local camera.
 *
 * @since v3.3.0
 */
enum CAPTURE_BRIGHTNESS_LEVEL_TYPE {
  /** -1: The SDK does not detect the brightness level of the video image.
   * Wait a few seconds to get the brightness level from `CAPTURE_BRIGHTNESS_LEVEL_TYPE` in the next callback.
   */
  CAPTURE_BRIGHTNESS_LEVEL_INVALID = -1,
  /** 0: The brightness level of the video image is normal.
   */
  CAPTURE_BRIGHTNESS_LEVEL_NORMAL = 0,
  /** 1: The brightness level of the video image is too bright.
   */
  CAPTURE_BRIGHTNESS_LEVEL_BRIGHT = 1,
  /** 2: The brightness level of the video image is too dark.
   */
  CAPTURE_BRIGHTNESS_LEVEL_DARK = 2,
};

/** The use mode of the audio data in the \ref media::IAudioFrameObserver::onRecordAudioFrame "onRecordAudioFrame" or \ref media::IAudioFrameObserver::onPlaybackAudioFrame "onPlaybackAudioFrame" callback.
 */
enum RAW_AUDIO_FRAME_OP_MODE_TYPE {
  /** 0: Read-only mode: Users only read the \ref agora::media::IAudioFrameObserver::AudioFrame "AudioFrame" data without modifying anything. For example, when users acquire the data with the Agora SDK, then push the RTMP or RTMPS streams. */
  RAW_AUDIO_FRAME_OP_MODE_READ_ONLY = 0,
  /** 1: Write-only mode: Users replace the \ref agora::media::IAudioFrameObserver::AudioFrame "AudioFrame" data with their own data and pass the data to the SDK for encoding. For example, when users acquire the data. */
  RAW_AUDIO_FRAME_OP_MODE_WRITE_ONLY = 1,
  /** 2: Read and write mode: Users read the data from \ref agora::media::IAudioFrameObserver::AudioFrame "AudioFrame", modify it, and then play it. For example, when users have their own sound-effect processing module and perform some voice pre-processing, such as a voice change. */
  RAW_AUDIO_FRAME_OP_MODE_READ_WRITE = 2,
};

/** Audio-sample rates. */
enum AUDIO_SAMPLE_RATE_TYPE {
  /** 32000: 32 kHz */
  AUDIO_SAMPLE_RATE_32000 = 32000,
  /** 44100: 44.1 kHz */
  AUDIO_SAMPLE_RATE_44100 = 44100,
  /** 48000: 48 kHz */
  AUDIO_SAMPLE_RATE_48000 = 48000,
};

/** Video codec profile types. */
enum VIDEO_CODEC_PROFILE_TYPE { /** 66: Baseline video codec profile. Generally used in video calls on mobile phones. */
                                VIDEO_CODEC_PROFILE_BASELINE = 66,
                                /** 77: Main video codec profile. Generally used in mainstream electronics such as MP4 players, portable video players, PSP, and iPads. */
                                VIDEO_CODEC_PROFILE_MAIN = 77,
                                /** 100: (Default) High video codec profile. Generally used in high-resolution live streaming or television. */
                                VIDEO_CODEC_PROFILE_HIGH = 100,
};

/** Video codec types */
enum VIDEO_CODEC_TYPE {
  /** 1: Standard VP8 */
  VIDEO_CODEC_VP8 = 1,
  /** 2: Standard H.264 */
  VIDEO_CODEC_H264 = 2,
  /** 3: Enhanced VP8 */
  VIDEO_CODEC_EVP = 3,
  /** 4: Enhanced H.264 */
  VIDEO_CODEC_E264 = 4,
};

/**
 * The video codec type of the output video stream.
 *
 * @since v3.2.0
 */
enum VIDEO_CODEC_TYPE_FOR_STREAM {
  /**
   * 1: (Default) H.264
   */
  VIDEO_CODEC_H264_FOR_STREAM = 1,
  /**
   * 2: H.265
   */
  VIDEO_CODEC_H265_FOR_STREAM = 2,
};

/** Audio equalization band frequencies. */
enum AUDIO_EQUALIZATION_BAND_FREQUENCY {
  /** 0: 31 Hz */
  AUDIO_EQUALIZATION_BAND_31 = 0,
  /** 1: 62 Hz */
  AUDIO_EQUALIZATION_BAND_62 = 1,
  /** 2: 125 Hz */
  AUDIO_EQUALIZATION_BAND_125 = 2,
  /** 3: 250 Hz */
  AUDIO_EQUALIZATION_BAND_250 = 3,
  /** 4: 500 Hz */
  AUDIO_EQUALIZATION_BAND_500 = 4,
  /** 5: 1 kHz */
  AUDIO_EQUALIZATION_BAND_1K = 5,
  /** 6: 2 kHz */
  AUDIO_EQUALIZATION_BAND_2K = 6,
  /** 7: 4 kHz */
  AUDIO_EQUALIZATION_BAND_4K = 7,
  /** 8: 8 kHz */
  AUDIO_EQUALIZATION_BAND_8K = 8,
  /** 9: 16 kHz */
  AUDIO_EQUALIZATION_BAND_16K = 9,
};

/** Audio reverberation types. */
enum AUDIO_REVERB_TYPE {
  /** 0: The level of the dry signal (db). The value is between -20 and 10. */
  AUDIO_REVERB_DRY_LEVEL = 0,  // (dB, [-20,10]), the level of the dry signal
  /** 1: The level of the early reflection signal (wet signal) (dB). The value is between -20 and 10. */
  AUDIO_REVERB_WET_LEVEL = 1,  // (dB, [-20,10]), the level of the early reflection signal (wet signal)
  /** 2: The room size of the reflection. The value is between 0 and 100. */
  AUDIO_REVERB_ROOM_SIZE = 2,  // ([0,100]), the room size of the reflection
  /** 3: The length of the initial delay of the wet signal (ms). The value is between 0 and 200. */
  AUDIO_REVERB_WET_DELAY = 3,  // (ms, [0,200]), the length of the initial delay of the wet signal in ms
  /** 4: The reverberation strength. The value is between 0 and 100. */
  AUDIO_REVERB_STRENGTH = 4,  // ([0,100]), the strength of the reverberation
};

/**
 * @deprecated Deprecated from v3.2.0.
 *
 * Local voice changer options.
 *
 * Gender-based beatification effect works best only when assigned a proper gender:
 *
 * - For male: #GENERAL_BEAUTY_VOICE_MALE_MAGNETIC
 * - For female: #GENERAL_BEAUTY_VOICE_FEMALE_FRESH or #GENERAL_BEAUTY_VOICE_FEMALE_VITALITY
 *
 * Failure to do so can lead to voice distortion.
 */
enum AGORA_DEPRECATED_ATTRIBUTE VOICE_CHANGER_PRESET {
  /**
   * The original voice (no local voice change).
   */
  VOICE_CHANGER_OFF = 0x00000000,  // Turn off the voice changer
  /**
   * The voice of an old man.
   */
  VOICE_CHANGER_OLDMAN = 0x00000001,
  /**
   * The voice of a little boy.
   */
  VOICE_CHANGER_BABYBOY = 0x00000002,
  /**
   * The voice of a little girl.
   */
  VOICE_CHANGER_BABYGIRL = 0x00000003,
  /**
   * The voice of Zhu Bajie, a character in Journey to the West who has a voice like that of a growling bear.
   */
  VOICE_CHANGER_ZHUBAJIE = 0x00000004,
  /**
   * The ethereal voice.
   */
  VOICE_CHANGER_ETHEREAL = 0x00000005,
  /**
   * The voice of Hulk.
   */
  VOICE_CHANGER_HULK = 0x00000006,
  /**
   * A more vigorous voice.
   */
  VOICE_BEAUTY_VIGOROUS = 0x00100001,  // 7,
  /**
   * A deeper voice.
   */
  VOICE_BEAUTY_DEEP = 0x00100002,
  /**
   * A mellower voice.
   */
  VOICE_BEAUTY_MELLOW = 0x00100003,
  /**
   * Falsetto.
   */
  VOICE_BEAUTY_FALSETTO = 0x00100004,
  /**
   * A fuller voice.
   */
  VOICE_BEAUTY_FULL = 0x00100005,
  /**
   * A clearer voice.
   */
  VOICE_BEAUTY_CLEAR = 0x00100006,
  /**
   * A more resounding voice.
   */
  VOICE_BEAUTY_RESOUNDING = 0x00100007,
  /**
   * A more ringing voice.
   */
  VOICE_BEAUTY_RINGING = 0x00100008,
  /**
   * A more spatially resonant voice.
   */
  VOICE_BEAUTY_SPACIAL = 0x00100009,
  /**
   * (For male only) A more magnetic voice. Do not use it when the speaker is a female; otherwise, voice distortion occurs.
   */
  GENERAL_BEAUTY_VOICE_MALE_MAGNETIC = 0x00200001,
  /**
   * (For female only) A fresher voice. Do not use it when the speaker is a male; otherwise, voice distortion occurs.
   */
  GENERAL_BEAUTY_VOICE_FEMALE_FRESH = 0x00200002,
  /**
   * 	(For female only) A more vital voice. Do not use it when the speaker is a male; otherwise, voice distortion occurs.
   */
  GENERAL_BEAUTY_VOICE_FEMALE_VITALITY = 0x00200003

};

/** @deprecated Deprecated from v3.2.0.
 *
 *  Local voice reverberation presets.
 */
enum AGORA_DEPRECATED_ATTRIBUTE AUDIO_REVERB_PRESET {
  /**
   * Turn off local voice reverberation, that is, to use the original voice.
   */
  AUDIO_REVERB_OFF = 0x00000000,  // Turn off audio reverb
  /**
   * The reverberation style typical of a KTV venue (enhanced).
   */
  AUDIO_REVERB_FX_KTV = 0x00100001,
  /**
   * The reverberation style typical of a concert hall (enhanced).
   */
  AUDIO_REVERB_FX_VOCAL_CONCERT = 0x00100002,
  /**
   * The reverberation style typical of an uncle's voice.
   */
  AUDIO_REVERB_FX_UNCLE = 0x00100003,
  /**
   * The reverberation style typical of a little sister's voice.
   */
  AUDIO_REVERB_FX_SISTER = 0x00100004,
  /**
   * The reverberation style typical of a recording studio (enhanced).
   */
  AUDIO_REVERB_FX_STUDIO = 0x00100005,
  /**
   * The reverberation style typical of popular music (enhanced).
   */
  AUDIO_REVERB_FX_POPULAR = 0x00100006,
  /**
   * The reverberation style typical of R&B music (enhanced).
   */
  AUDIO_REVERB_FX_RNB = 0x00100007,
  /**
   * The reverberation style typical of the vintage phonograph.
   */
  AUDIO_REVERB_FX_PHONOGRAPH = 0x00100008,
  /**
   * The reverberation style typical of popular music.
   */
  AUDIO_REVERB_POPULAR = 0x00000001,
  /**
   * The reverberation style typical of R&B music.
   */
  AUDIO_REVERB_RNB = 0x00000002,
  /**
   * The reverberation style typical of rock music.
   */
  AUDIO_REVERB_ROCK = 0x00000003,
  /**
   * The reverberation style typical of hip-hop music.
   */
  AUDIO_REVERB_HIPHOP = 0x00000004,
  /**
   * The reverberation style typical of a concert hall.
   */
  AUDIO_REVERB_VOCAL_CONCERT = 0x00000005,
  /**
   * The reverberation style typical of a KTV venue.
   */
  AUDIO_REVERB_KTV = 0x00000006,
  /**
   * The reverberation style typical of a recording studio.
   */
  AUDIO_REVERB_STUDIO = 0x00000007,
  /**
   * The reverberation of the virtual stereo. The virtual stereo is an effect that renders the monophonic
   * audio as the stereo audio, so that all users in the channel can hear the stereo voice effect.
   * To achieve better virtual stereo reverberation, Agora recommends setting `profile` in `setAudioProfile`
   * as `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)`.
   */
  AUDIO_VIRTUAL_STEREO = 0x00200001,
  /**
   * A pitch correction effect that corrects the user's pitch based on the pitch of the natural C major scale.
   */
  AUDIO_ELECTRONIC_VOICE = 0x00300001,
  /**
   * A 3D voice effect that makes the voice appear to be moving around the user.
   */
  AUDIO_THREEDIM_VOICE = 0x00400001
};
/** The options for SDK preset voice beautifier effects.
 */
enum VOICE_BEAUTIFIER_PRESET {
  /** Turn off voice beautifier effects and use the original voice.
   */
  VOICE_BEAUTIFIER_OFF = 0x00000000,
  /** A more magnetic voice.
   *
   * @note Agora recommends using this enumerator to process a male-sounding voice; otherwise, you may experience vocal distortion.
   */
  CHAT_BEAUTIFIER_MAGNETIC = 0x01010100,
  /** A fresher voice.
   *
   * @note Agora recommends using this enumerator to process a female-sounding voice; otherwise, you may experience vocal distortion.
   */
  CHAT_BEAUTIFIER_FRESH = 0x01010200,
  /** A more vital voice.
   *
   * @note Agora recommends using this enumerator to process a female-sounding voice; otherwise, you may experience vocal distortion.
   */
  CHAT_BEAUTIFIER_VITALITY = 0x01010300,
  /**
   * @since v3.3.0
   *
   * Singing beautifier effect.
   * - If you call \ref IRtcEngine::setVoiceBeautifierPreset "setVoiceBeautifierPreset" (SINGING_BEAUTIFIER), you can beautify a male-sounding voice and add a reverberation
   * effect that sounds like singing in a small room. Agora recommends not using \ref IRtcEngine::setVoiceBeautifierPreset "setVoiceBeautifierPreset" (SINGING_BEAUTIFIER)
   * to process a female-sounding voice; otherwise, you may experience vocal distortion.
   * - If you call \ref IRtcEngine::setVoiceBeautifierParameters "setVoiceBeautifierParameters"(SINGING_BEAUTIFIER, param1, param2), you can beautify a male- or
   * female-sounding voice and add a reverberation effect.
   */
  SINGING_BEAUTIFIER = 0x01020100,
  /** A more vigorous voice.
   */
  TIMBRE_TRANSFORMATION_VIGOROUS = 0x01030100,
  /** A deeper voice.
   */
  TIMBRE_TRANSFORMATION_DEEP = 0x01030200,
  /** A mellower voice.
   */
  TIMBRE_TRANSFORMATION_MELLOW = 0x01030300,
  /** A falsetto voice.
   */
  TIMBRE_TRANSFORMATION_FALSETTO = 0x01030400,
  /** A fuller voice.
   */
  TIMBRE_TRANSFORMATION_FULL = 0x01030500,
  /** A clearer voice.
   */
  TIMBRE_TRANSFORMATION_CLEAR = 0x01030600,
  /** A more resounding voice.
   */
  TIMBRE_TRANSFORMATION_RESOUNDING = 0x01030700,
  /** A more ringing voice.
   */
  TIMBRE_TRANSFORMATION_RINGING = 0x01030800
};
/** The options for SDK preset audio effects.
 */
enum AUDIO_EFFECT_PRESET {
  /** Turn off audio effects and use the original voice.
   */
  AUDIO_EFFECT_OFF = 0x00000000,
  /** An audio effect typical of a KTV venue.
   *
   * @note To achieve better audio effect quality, Agora recommends calling \ref IRtcEngine::setAudioProfile "setAudioProfile"
   * and setting the `profile` parameter to `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)`
   * before setting this enumerator.
   */
  ROOM_ACOUSTICS_KTV = 0x02010100,
  /** An audio effect typical of a concert hall.
   *
   * @note To achieve better audio effect quality, Agora recommends calling \ref IRtcEngine::setAudioProfile "setAudioProfile"
   * and setting the `profile` parameter to `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)`
   * before setting this enumerator.
   */
  ROOM_ACOUSTICS_VOCAL_CONCERT = 0x02010200,
  /** An audio effect typical of a recording studio.
   *
   * @note To achieve better audio effect quality, Agora recommends calling \ref IRtcEngine::setAudioProfile "setAudioProfile"
   * and setting the `profile` parameter to `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)`
   * before setting this enumerator.
   */
  ROOM_ACOUSTICS_STUDIO = 0x02010300,
  /** An audio effect typical of a vintage phonograph.
   *
   * @note To achieve better audio effect quality, Agora recommends calling \ref IRtcEngine::setAudioProfile "setAudioProfile"
   * and setting the `profile` parameter to `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)`
   * before setting this enumerator.
   */
  ROOM_ACOUSTICS_PHONOGRAPH = 0x02010400,
  /** A virtual stereo effect that renders monophonic audio as stereo audio.
   *
   * @note Call \ref IRtcEngine::setAudioProfile "setAudioProfile" and set the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_STANDARD_STEREO(3)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before setting this
   * enumerator; otherwise, the enumerator setting does not take effect.
   */
  ROOM_ACOUSTICS_VIRTUAL_STEREO = 0x02010500,
  /** A more spatial audio effect.
   *
   * @note To achieve better audio effect quality, Agora recommends calling \ref IRtcEngine::setAudioProfile "setAudioProfile"
   * and setting the `profile` parameter to `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)`
   * before setting this enumerator.
   */
  ROOM_ACOUSTICS_SPACIAL = 0x02010600,
  /** A more ethereal audio effect.
   *
   * @note To achieve better audio effect quality, Agora recommends calling \ref IRtcEngine::setAudioProfile "setAudioProfile"
   * and setting the `profile` parameter to `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)`
   * before setting this enumerator.
   */
  ROOM_ACOUSTICS_ETHEREAL = 0x02010700,
  /** A 3D voice effect that makes the voice appear to be moving around the user. The default cycle period of the 3D
   * voice effect is 10 seconds. To change the cycle period, call \ref IRtcEngine::setAudioEffectParameters "setAudioEffectParameters"
   * after this method.
   *
   * @note
   * - Call \ref IRtcEngine::setAudioProfile "setAudioProfile" and set the `profile` parameter to `AUDIO_PROFILE_MUSIC_STANDARD_STEREO(3)`
   * or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before setting this enumerator; otherwise, the enumerator setting does not take effect.
   * - If the 3D voice effect is enabled, users need to use stereo audio playback devices to hear the anticipated voice effect.
   */
  ROOM_ACOUSTICS_3D_VOICE = 0x02010800,
  /** The voice of a middle-aged man.
   *
   * @note
   * - Agora recommends using this enumerator to process a male-sounding voice; otherwise, you may not hear the anticipated voice effect.
   * - To achieve better audio effect quality, Agora recommends calling \ref IRtcEngine::setAudioProfile "setAudioProfile" and
   * setting the `profile` parameter to `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  VOICE_CHANGER_EFFECT_UNCLE = 0x02020100,
  /** The voice of an old man.
   *
   * @note
   * - Agora recommends using this enumerator to process a male-sounding voice; otherwise, you may not hear the anticipated voice effect.
   * - To achieve better audio effect quality, Agora recommends calling \ref IRtcEngine::setAudioProfile "setAudioProfile" and setting
   * the `profile` parameter to `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before setting
   * this enumerator.
   */
  VOICE_CHANGER_EFFECT_OLDMAN = 0x02020200,
  /** The voice of a boy.
   *
   * @note
   * - Agora recommends using this enumerator to process a male-sounding voice; otherwise, you may not hear the anticipated voice effect.
   * - To achieve better audio effect quality, Agora recommends calling \ref IRtcEngine::setAudioProfile "setAudioProfile" and setting
   * the `profile` parameter to `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  VOICE_CHANGER_EFFECT_BOY = 0x02020300,
  /** The voice of a young woman.
   *
   * @note
   * - Agora recommends using this enumerator to process a female-sounding voice; otherwise, you may not hear the anticipated voice effect.
   * - To achieve better audio effect quality, Agora recommends calling \ref IRtcEngine::setAudioProfile "setAudioProfile" and setting
   * the `profile` parameter to `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  VOICE_CHANGER_EFFECT_SISTER = 0x02020400,
  /** The voice of a girl.
   *
   * @note
   * - Agora recommends using this enumerator to process a female-sounding voice; otherwise, you may not hear the anticipated voice effect.
   * - To achieve better audio effect quality, Agora recommends calling \ref IRtcEngine::setAudioProfile "setAudioProfile" and setting
   * the `profile` parameter to `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  VOICE_CHANGER_EFFECT_GIRL = 0x02020500,
  /** The voice of Pig King, a character in Journey to the West who has a voice like a growling bear.
   *
   * @note To achieve better audio effect quality, Agora recommends calling \ref IRtcEngine::setAudioProfile "setAudioProfile" and
   * setting the `profile` parameter to `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  VOICE_CHANGER_EFFECT_PIGKING = 0x02020600,
  /** The voice of Hulk.
   *
   * @note To achieve better audio effect quality, Agora recommends calling \ref IRtcEngine::setAudioProfile "setAudioProfile" and
   * setting the `profile` parameter to `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  VOICE_CHANGER_EFFECT_HULK = 0x02020700,
  /** An audio effect typical of R&B music.
   *
   * @note To achieve better audio effect quality, Agora recommends calling \ref IRtcEngine::setAudioProfile "setAudioProfile" and
   * setting the `profile` parameter to `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  STYLE_TRANSFORMATION_RNB = 0x02030100,
  /** An audio effect typical of popular music.
   *
   * @note To achieve better audio effect quality, Agora recommends calling \ref IRtcEngine::setAudioProfile "setAudioProfile" and
   * setting the `profile` parameter to `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  STYLE_TRANSFORMATION_POPULAR = 0x02030200,
  /** A pitch correction effect that corrects the user's pitch based on the pitch of the natural C major scale.
   * To change the basic mode and tonic pitch, call \ref IRtcEngine::setAudioEffectParameters "setAudioEffectParameters" after this method.
   *
   * @note To achieve better audio effect quality, Agora recommends calling \ref IRtcEngine::setAudioProfile "setAudioProfile" and
   * setting the `profile` parameter to `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  PITCH_CORRECTION = 0x02040100
};
/** The options for SDK preset voice conversion effects.
 *
 * @since v3.3.1
 */
enum VOICE_CONVERSION_PRESET {
  /** Turn off voice conversion effects and use the original voice.
   */
  VOICE_CONVERSION_OFF = 0x00000000,
  /** A gender-neutral voice. To avoid audio distortion, ensure that you use
   * this enumerator to process a female-sounding voice.
   */
  VOICE_CHANGER_NEUTRAL = 0x03010100,
  /** A sweet voice. To avoid audio distortion, ensure that you use this
   * enumerator to process a female-sounding voice.
   */
  VOICE_CHANGER_SWEET = 0x03010200,
  /** A steady voice. To avoid audio distortion, ensure that you use this
   * enumerator to process a male-sounding voice.
   */
  VOICE_CHANGER_SOLID = 0x03010300,
  /** A deep voice. To avoid audio distortion, ensure that you use this
   * enumerator to process a male-sounding voice.
   */
  VOICE_CHANGER_BASS = 0x03010400
};
/** Audio codec profile types. The default value is LC_ACC. */
enum AUDIO_CODEC_PROFILE_TYPE {
  /** 0: (Default) LC-AAC */
  AUDIO_CODEC_PROFILE_LC_AAC = 0,
  /** 1: HE-AAC */
  AUDIO_CODEC_PROFILE_HE_AAC = 1,
  /** 2: HE-AAC v2
   *
   * @since v3.6.0
   */
  AUDIO_CODEC_PROFILE_HE_AAC_V2 = 2,
};

/** Remote audio states.
 */
enum REMOTE_AUDIO_STATE {
  /** 0: The remote audio is in the default state, probably due to
   * #REMOTE_AUDIO_REASON_LOCAL_MUTED (3),
   * #REMOTE_AUDIO_REASON_REMOTE_MUTED (5), or
   * #REMOTE_AUDIO_REASON_REMOTE_OFFLINE (7).
   */
  REMOTE_AUDIO_STATE_STOPPED = 0,  // Default state, audio is started or remote user disabled/muted audio stream
  /** 1: The first remote audio packet is received.
   */
  REMOTE_AUDIO_STATE_STARTING = 1,  // The first audio frame packet has been received
  /** 2: The remote audio stream is decoded and plays normally, probably
   * due to #REMOTE_AUDIO_REASON_NETWORK_RECOVERY (2),
   * #REMOTE_AUDIO_REASON_LOCAL_UNMUTED (4), or
   * #REMOTE_AUDIO_REASON_REMOTE_UNMUTED (6).
   */
  REMOTE_AUDIO_STATE_DECODING = 2,  // The first remote audio frame has been decoded or fronzen state ends
  /** 3: The remote audio is frozen, probably due to
   * #REMOTE_AUDIO_REASON_NETWORK_CONGESTION (1).
   */
  REMOTE_AUDIO_STATE_FROZEN = 3,  // Remote audio is frozen, probably due to network issue
  /** 4: The remote audio fails to start, probably due to
   * #REMOTE_AUDIO_REASON_INTERNAL (0).
   */
  REMOTE_AUDIO_STATE_FAILED = 4,  // Remote audio play failed
};

/** Remote audio state reasons.
 */
enum REMOTE_AUDIO_STATE_REASON {
  /** 0: The SDK reports this reason when the audio state changes.
   */
  REMOTE_AUDIO_REASON_INTERNAL = 0,
  /** 1: Network congestion.
   */
  REMOTE_AUDIO_REASON_NETWORK_CONGESTION = 1,
  /** 2: Network recovery.
   */
  REMOTE_AUDIO_REASON_NETWORK_RECOVERY = 2,
  /** 3: The local user stops receiving the remote audio stream or
   * disables the audio module.
   */
  REMOTE_AUDIO_REASON_LOCAL_MUTED = 3,
  /** 4: The local user resumes receiving the remote audio stream or
   * enables the audio module.
   */
  REMOTE_AUDIO_REASON_LOCAL_UNMUTED = 4,
  /** 5: The remote user stops sending the audio stream or disables the
   * audio module.
   */
  REMOTE_AUDIO_REASON_REMOTE_MUTED = 5,
  /** 6: The remote user resumes sending the audio stream or enables the
   * audio module.
   */
  REMOTE_AUDIO_REASON_REMOTE_UNMUTED = 6,
  /** 7: The remote user leaves the channel.
   */
  REMOTE_AUDIO_REASON_REMOTE_OFFLINE = 7,
};

/** Remote video states. */
// enum REMOTE_VIDEO_STATE
// {
//     // REMOTE_VIDEO_STATE_STOPPED is not used at this version. Ignore this value.
//     // REMOTE_VIDEO_STATE_STOPPED = 0,  // Default state, video is started or remote user disabled/muted video stream
//       /** 1: The remote video is playing. */
//       REMOTE_VIDEO_STATE_RUNNING = 1,  // Running state, remote video can be displayed normally
//       /** 2: The remote video is frozen. */
//       REMOTE_VIDEO_STATE_FROZEN = 2,    // Remote video is frozen, probably due to network issue.
// };

/** The state of the remote video. */
enum REMOTE_VIDEO_STATE {
  /** 0: The remote video is in the default state, probably due to #REMOTE_VIDEO_STATE_REASON_LOCAL_MUTED (3), #REMOTE_VIDEO_STATE_REASON_REMOTE_MUTED (5), or #REMOTE_VIDEO_STATE_REASON_REMOTE_OFFLINE (7).
   */
  REMOTE_VIDEO_STATE_STOPPED = 0,

  /** 1: The first remote video packet is received.
   */
  REMOTE_VIDEO_STATE_STARTING = 1,

  /** 2: The remote video stream is decoded and plays normally, probably due to #REMOTE_VIDEO_STATE_REASON_NETWORK_RECOVERY (2), #REMOTE_VIDEO_STATE_REASON_LOCAL_UNMUTED (4), #REMOTE_VIDEO_STATE_REASON_REMOTE_UNMUTED (6), or #REMOTE_VIDEO_STATE_REASON_AUDIO_FALLBACK_RECOVERY (9).
   */
  REMOTE_VIDEO_STATE_DECODING = 2,

  /** 3: The remote video is frozen, probably due to #REMOTE_VIDEO_STATE_REASON_NETWORK_CONGESTION (1) or #REMOTE_VIDEO_STATE_REASON_AUDIO_FALLBACK (8).
   */
  REMOTE_VIDEO_STATE_FROZEN = 3,

  /** 4: The remote video fails to start, probably due to #REMOTE_VIDEO_STATE_REASON_INTERNAL (0).
   */
  REMOTE_VIDEO_STATE_FAILED = 4
};
/** The publishing state.
 */
enum STREAM_PUBLISH_STATE {
  /** 0: The initial publishing state after joining the channel.
   */
  PUB_STATE_IDLE = 0,
  /** 1: Fails to publish the local stream. Possible reasons:
   * - The local user calls \ref IRtcEngine::muteLocalAudioStream "muteLocalAudioStream(true)" or \ref IRtcEngine::muteLocalVideoStream "muteLocalVideoStream(true)" to stop sending local streams.
   * - The local user calls \ref IRtcEngine::disableAudio "disableAudio" or \ref IRtcEngine::disableVideo "disableVideo" to disable the entire audio or video module.
   * - The local user calls \ref IRtcEngine::enableLocalAudio "enableLocalAudio(false)" or \ref IRtcEngine::enableLocalVideo "enableLocalVideo(false)" to disable the local audio sampling or video capturing.
   * - The role of the local user is `AUDIENCE`.
   */
  PUB_STATE_NO_PUBLISHED = 1,
  /** 2: Publishing.
   */
  PUB_STATE_PUBLISHING = 2,
  /** 3: Publishes successfully.
   */
  PUB_STATE_PUBLISHED = 3
};
/** The subscribing state.
 */
enum STREAM_SUBSCRIBE_STATE {
  /** 0: The initial subscribing state after joining the channel.
   */
  SUB_STATE_IDLE = 0,
  /** 1: Fails to subscribe to the remote stream. Possible reasons:
   * - The remote user:
   *  - Calls \ref IRtcEngine::muteLocalAudioStream "muteLocalAudioStream(true)" or \ref IRtcEngine::muteLocalVideoStream "muteLocalVideoStream(true)" to stop sending local streams.
   *  - Calls \ref IRtcEngine::disableAudio "disableAudio" or \ref IRtcEngine::disableVideo "disableVideo" to disable the entire audio or video modules.
   *  - Calls \ref IRtcEngine::enableLocalAudio "enableLocalAudio(false)" or \ref IRtcEngine::enableLocalVideo "enableLocalVideo(false)" to disable the local audio sampling or video capturing.
   *  - The role of the remote user is `AUDIENCE`.
   * - The local user calls the following methods to stop receiving remote streams:
   *  - Calls \ref IRtcEngine::muteRemoteAudioStream "muteRemoteAudioStream(true)", \ref IRtcEngine::muteAllRemoteAudioStreams "muteAllRemoteAudioStreams(true)", or \ref IRtcEngine::setDefaultMuteAllRemoteAudioStreams "setDefaultMuteAllRemoteAudioStreams(true)" to stop receiving remote audio streams.
   *  - Calls \ref IRtcEngine::muteRemoteVideoStream "muteRemoteVideoStream(true)", \ref IRtcEngine::muteAllRemoteVideoStreams "muteAllRemoteVideoStreams(true)", or \ref IRtcEngine::setDefaultMuteAllRemoteVideoStreams "setDefaultMuteAllRemoteVideoStreams(true)" to stop receiving remote video streams.
   */
  SUB_STATE_NO_SUBSCRIBED = 1,
  /** 2: Subscribing.
   */
  SUB_STATE_SUBSCRIBING = 2,
  /** 3: Subscribes to and receives the remote stream successfully.
   */
  SUB_STATE_SUBSCRIBED = 3
};

/** The remote video frozen type. */
enum XLA_REMOTE_VIDEO_FROZEN_TYPE {
  /** 0: 500ms video frozen type.
   */
  XLA_REMOTE_VIDEO_FROZEN_500MS = 0,
  /** 1: 200ms video frozen type.
   */
  XLA_REMOTE_VIDEO_FROZEN_200MS = 1,
  /** 2: 600ms video frozen type.
   */
  XLA_REMOTE_VIDEO_FROZEN_600MS = 2,
  /** 3: max video frozen type.
   */
  XLA_REMOTE_VIDEO_FROZEN_TYPE_MAX = 3,
};

/** The remote audio frozen type. */
enum XLA_REMOTE_AUDIO_FROZEN_TYPE {
  /** 0: 80ms audio frozen.
   */
  XLA_REMOTE_AUDIO_FROZEN_80MS = 0,
  /** 1: 200ms audio frozen.
   */
  XLA_REMOTE_AUDIO_FROZEN_200MS = 1,
  /** 2: max audio frozen type.
   */
  XLA_REMOTE_AUDIO_FROZEN_TYPE_MAX = 2,
};

/** The reason for the remote video state change. */
enum REMOTE_VIDEO_STATE_REASON {
  /** 0: The SDK reports this reason when the video state changes.
   */
  REMOTE_VIDEO_STATE_REASON_INTERNAL = 0,

  /** 1: Network congestion.
   */
  REMOTE_VIDEO_STATE_REASON_NETWORK_CONGESTION = 1,

  /** 2: Network recovery.
   */
  REMOTE_VIDEO_STATE_REASON_NETWORK_RECOVERY = 2,

  /** 3: The local user stops receiving the remote video stream or disables the video module.
   */
  REMOTE_VIDEO_STATE_REASON_LOCAL_MUTED = 3,

  /** 4: The local user resumes receiving the remote video stream or enables the video module.
   */
  REMOTE_VIDEO_STATE_REASON_LOCAL_UNMUTED = 4,

  /** 5: The remote user stops sending the video stream or disables the video module.
   */
  REMOTE_VIDEO_STATE_REASON_REMOTE_MUTED = 5,

  /** 6: The remote user resumes sending the video stream or enables the video module.
   */
  REMOTE_VIDEO_STATE_REASON_REMOTE_UNMUTED = 6,

  /** 7: The remote user leaves the channel.
   */
  REMOTE_VIDEO_STATE_REASON_REMOTE_OFFLINE = 7,

  /** 8: The remote audio-and-video stream falls back to the audio-only stream due to poor network conditions.
   */
  REMOTE_VIDEO_STATE_REASON_AUDIO_FALLBACK = 8,

  /** 9: The remote audio-only stream switches back to the audio-and-video stream after the network conditions improve.
   */
  REMOTE_VIDEO_STATE_REASON_AUDIO_FALLBACK_RECOVERY = 9,
  /** 10: The remote user sdk(only for iOS) in background.
   */
  REMOTE_VIDEO_STATE_REASON_SDK_IN_BACKGROUND = 10
};

/** Video frame rates. */
enum FRAME_RATE {
  /** 1: 1 fps */
  FRAME_RATE_FPS_1 = 1,
  /** 7: 7 fps */
  FRAME_RATE_FPS_7 = 7,
  /** 10: 10 fps */
  FRAME_RATE_FPS_10 = 10,
  /** 15: 15 fps */
  FRAME_RATE_FPS_15 = 15,
  /** 24: 24 fps */
  FRAME_RATE_FPS_24 = 24,
  /** 30: 30 fps */
  FRAME_RATE_FPS_30 = 30,
  /** 60: 60 fps (Windows and macOS only) */
  FRAME_RATE_FPS_60 = 60,
};

/** Video output orientation modes.
 */
enum ORIENTATION_MODE {
  /** 0: (Default) Adaptive mode.

   The video encoder adapts to the orientation mode of the video input device.

   - If the width of the captured video from the SDK is greater than the height, the encoder sends the video in landscape mode. The encoder also sends the rotational information of the video, and the receiver uses the rotational information to rotate the received video.
   - When you use a custom video source, the output video from the encoder inherits the orientation of the original video. If the original video is in portrait mode, the output video from the encoder is also in portrait mode. The encoder also sends the rotational information of the video to the receiver.
   */
  ORIENTATION_MODE_ADAPTIVE = 0,
  /** 1: Landscape mode.

   The video encoder always sends the video in landscape mode. The video encoder rotates the original video before sending it and the rotational infomation is 0. This mode applies to scenarios involving CDN live streaming.
   */
  ORIENTATION_MODE_FIXED_LANDSCAPE = 1,
  /** 2: Portrait mode.

   The video encoder always sends the video in portrait mode. The video encoder rotates the original video before sending it and the rotational infomation is 0. This mode applies to scenarios involving CDN live streaming.
   */
  ORIENTATION_MODE_FIXED_PORTRAIT = 2,
};

/** Video degradation preferences under limited bandwidth. */
enum DEGRADATION_PREFERENCE {
  /** 0: (Default) Prefers to reduce the video frame rate while maintaining
   * video quality during video encoding under limited bandwidth. This
   * degradation preference is suitable for scenarios where video quality is
   * prioritized.
   *
   * @note In the `COMMUNICATION` channel profile, the resolution of the video
   * sent may change, so remote users need to handle this issue.
   * See \ref IRtcEngineEventHandler::onVideoSizeChanged "onVideoSizeChanged".
   */
  MAINTAIN_QUALITY = 0,
  /** 1: Prefers to reduce the video quality while maintaining the video frame
   * rate during video encoding under limited bandwidth. This degradation
   * preference is suitable for scenarios where smoothness is prioritized and
   * video quality is allowed to be reduced.
   */
  MAINTAIN_FRAMERATE = 1,
  /** 2: Reduces the video frame rate and video quality simultaneously during
   * video encoding under limited bandwidth. `MAINTAIN_BALANCED` has a lower
   * reduction than `MAINTAIN_QUALITY` and `MAINTAIN_FRAMERATE`, and this
   * preference is suitable for scenarios where both smoothness and video
   * quality are a priority.
   *
   * @note The resolution of the video sent may change, so remote users need
   * to handle this issue.
   * See \ref IRtcEngineEventHandler::onVideoSizeChanged "onVideoSizeChanged".
   */
  MAINTAIN_BALANCED = 2,
};

/** Stream fallback options. */
enum STREAM_FALLBACK_OPTIONS {
  /** 0: No fallback behavior for the local/remote video stream when the uplink/downlink network conditions are poor. The quality of the stream is not guaranteed. */
  STREAM_FALLBACK_OPTION_DISABLED = 0,
  /** 1: Under poor downlink network conditions, the remote video stream, to which you subscribe, falls back to the low-stream (low resolution and low bitrate) video. You can set this option only in the \ref IRtcEngine::setRemoteSubscribeFallbackOption "setRemoteSubscribeFallbackOption" method. Nothing happens when you set this in the \ref IRtcEngine::setLocalPublishFallbackOption "setLocalPublishFallbackOption" method. */
  STREAM_FALLBACK_OPTION_VIDEO_STREAM_LOW = 1,
  /** 2: Under poor uplink network conditions, the published video stream falls back to audio only.

  Under poor downlink network conditions, the remote video stream, to which you subscribe, first falls back to the low-stream (low resolution and low bitrate) video; and then to an audio-only stream if the network conditions worsen.*/
  STREAM_FALLBACK_OPTION_AUDIO_ONLY = 2,
};

/** Camera capture preference.
 */
enum CAPTURER_OUTPUT_PREFERENCE {
  /** 0: (Default) self-adapts the camera output parameters to the system performance and network conditions to balance CPU consumption and video preview quality.
   */
  CAPTURER_OUTPUT_PREFERENCE_AUTO = 0,
  /** 1: Prioritizes the system performance. The SDK chooses the dimension and frame rate of the local camera capture closest to those set by \ref IRtcEngine::setVideoEncoderConfiguration "setVideoEncoderConfiguration".
   */
  CAPTURER_OUTPUT_PREFERENCE_PERFORMANCE = 1,
  /** 2: Prioritizes the local preview quality. The SDK chooses higher camera output parameters to improve the local video preview quality. This option requires extra CPU and RAM usage for video pre-processing.
   */
  CAPTURER_OUTPUT_PREFERENCE_PREVIEW = 2,
  /** 3: Allows you to customize the width and height of the video image captured by the local camera.
   *
   * @since v3.3.0
   */
  CAPTURER_OUTPUT_PREFERENCE_MANUAL = 3,
};

/** The priority of the remote user.
 */
enum PRIORITY_TYPE {
  /** 50: The user's priority is high.
   */
  PRIORITY_HIGH = 50,
  /** 100: (Default) The user's priority is normal.
   */
  PRIORITY_NORMAL = 100,
};

/** Connection states. */
enum CONNECTION_STATE_TYPE {
  /** 1: The SDK is disconnected from Agora's edge server.

   - This is the initial state before calling the \ref agora::rtc::IRtcEngine::joinChannel "joinChannel" method.
   - The SDK also enters this state when the application calls the \ref agora::rtc::IRtcEngine::leaveChannel "leaveChannel" method.
   */
  CONNECTION_STATE_DISCONNECTED = 1,
  /** 2: The SDK is connecting to Agora's edge server.

   - When the application calls the \ref agora::rtc::IRtcEngine::joinChannel "joinChannel" method, the SDK starts to establish a connection to the specified channel, triggers the \ref agora::rtc::IRtcEngineEventHandler::onConnectionStateChanged "onConnectionStateChanged" callback, and switches to the #CONNECTION_STATE_CONNECTING state.
   - When the SDK successfully joins the channel, it triggers the \ref agora::rtc::IRtcEngineEventHandler::onConnectionStateChanged "onConnectionStateChanged" callback and switches to the #CONNECTION_STATE_CONNECTED state.
   - After the SDK joins the channel and when it finishes initializing the media engine, the SDK triggers the \ref agora::rtc::IRtcEngineEventHandler::onJoinChannelSuccess "onJoinChannelSuccess" callback.
   */
  CONNECTION_STATE_CONNECTING = 2,
  /** 3: The SDK is connected to Agora's edge server and has joined a channel. You can now publish or subscribe to a media stream in the channel.

   If the connection to the channel is lost because, for example, if the network is down or switched, the SDK automatically tries to reconnect and triggers:
   - The \ref agora::rtc::IRtcEngineEventHandler::onConnectionInterrupted "onConnectionInterrupted" callback (deprecated).
   - The \ref agora::rtc::IRtcEngineEventHandler::onConnectionStateChanged "onConnectionStateChanged" callback and switches to the #CONNECTION_STATE_RECONNECTING state.
   */
  CONNECTION_STATE_CONNECTED = 3,
  /** 4: The SDK keeps rejoining the channel after being disconnected from a joined channel because of network issues.

   - If the SDK cannot rejoin the channel within 10 seconds after being disconnected from Agora's edge server, the SDK triggers the \ref agora::rtc::IRtcEngineEventHandler::onConnectionLost "onConnectionLost" callback, stays in the #CONNECTION_STATE_RECONNECTING state, and keeps rejoining the channel.
   - If the SDK fails to rejoin the channel 20 minutes after being disconnected from Agora's edge server, the SDK triggers the \ref agora::rtc::IRtcEngineEventHandler::onConnectionStateChanged "onConnectionStateChanged" callback, switches to the #CONNECTION_STATE_FAILED state, and stops rejoining the channel.
   */
  CONNECTION_STATE_RECONNECTING = 4,
  /** 5: The SDK fails to connect to Agora's edge server or join the channel.

   You must call the \ref agora::rtc::IRtcEngine::leaveChannel "leaveChannel" method to leave this state, and call the \ref agora::rtc::IRtcEngine::joinChannel "joinChannel" method again to rejoin the channel.

   If the SDK is banned from joining the channel by Agora's edge server (through the RESTful API), the SDK triggers the \ref agora::rtc::IRtcEngineEventHandler::onConnectionBanned "onConnectionBanned" (deprecated) and \ref agora::rtc::IRtcEngineEventHandler::onConnectionStateChanged "onConnectionStateChanged" callbacks.
   */
  CONNECTION_STATE_FAILED = 5,
};

/** Reasons for a connection state change. */
enum CONNECTION_CHANGED_REASON_TYPE {
  /** 0: The SDK is connecting to Agora's edge server. */
  CONNECTION_CHANGED_CONNECTING = 0,
  /** 1: The SDK has joined the channel successfully. */
  CONNECTION_CHANGED_JOIN_SUCCESS = 1,
  /** 2: The connection between the SDK and Agora's edge server is interrupted. */
  CONNECTION_CHANGED_INTERRUPTED = 2,
  /** 3: The user is banned by the server. This error occurs when the user is kicked out the channel from the server. */
  CONNECTION_CHANGED_BANNED_BY_SERVER = 3,
  /** 4: The SDK fails to join the channel for more than 20 minutes and stops reconnecting to the channel. */
  CONNECTION_CHANGED_JOIN_FAILED = 4,
  /** 5: The SDK has left the channel. */
  CONNECTION_CHANGED_LEAVE_CHANNEL = 5,
  /**
   * 6: The specified App ID is invalid. Try to rejoin the channel with a valid App ID.
   */
  CONNECTION_CHANGED_INVALID_APP_ID = 6,
  /** 7: The connection failed since channel name is not valid. */
  CONNECTION_CHANGED_INVALID_CHANNEL_NAME = 7,
  /** 8: The connection failed since token is not valid, possibly because:

   - The App Certificate for the project is enabled in Console, but you do not use Token when joining the channel. If you enable the App Certificate, you must use a token to join the channel.
   - The uid that you specify in the \ref agora::rtc::IRtcEngine::joinChannel "joinChannel" method is different from the uid that you pass for generating the token.
   */
  CONNECTION_CHANGED_INVALID_TOKEN = 8,
  /** 9: The connection failed since token is expired. */
  CONNECTION_CHANGED_TOKEN_EXPIRED = 9,
  /** 10: The connection is rejected by server. This error usually occurs in the following situations:
   * - When the user is already in the channel, and still calls the method to join the channel, for example,
   * \ref IRtcEngine::joinChannel "joinChannel".
   * - When the user tries to join a channel during \ref IRtcEngine::startEchoTest "startEchoTest". Once you
   * call \ref IRtcEngine::startEchoTest "startEchoTest", you need to call \ref IRtcEngine::stopEchoTest "stopEchoTest" before joining a channel.
   *
   */
  CONNECTION_CHANGED_REJECTED_BY_SERVER = 10,
  /** 11: The connection changed to reconnecting since SDK has set a proxy server. */
  CONNECTION_CHANGED_SETTING_PROXY_SERVER = 11,
  /** 12: When SDK is in connection failed, the renew token operation will make it connecting. */
  CONNECTION_CHANGED_RENEW_TOKEN = 12,
  /** 13: The IP Address of SDK client has changed. i.e., Network type or IP/Port changed by network operator might change client IP address. */
  CONNECTION_CHANGED_CLIENT_IP_ADDRESS_CHANGED = 13,
  /** 14: Timeout for the keep-alive of the connection between the SDK and Agora's edge server. The connection state changes to CONNECTION_STATE_RECONNECTING(4). */
  CONNECTION_CHANGED_KEEP_ALIVE_TIMEOUT = 14,
  /** 19: Join the same channel from different devices using the same user ID.
   *
   * @since v3.7.0
   */
  CONNECTION_CHANGED_SAME_UID_LOGIN = 19,
  /** 20: The number of hosts in the channel is already at the upper limit.
   *
   * @note This enumerator is reported only when the support for 128 users is enabled. The maximum number of hosts is based on the actual number of hosts configured when you enable the 128-user feature.
   *
   * @since v3.7.0
   */
  CONNECTION_CHANGED_TOO_MANY_BROADCASTERS = 20,
};

/** Network type. */
enum NETWORK_TYPE {
  /** -1: The network type is unknown. */
  NETWORK_TYPE_UNKNOWN = -1,
  /** 0: The SDK disconnects from the network. */
  NETWORK_TYPE_DISCONNECTED = 0,
  /** 1: The network type is LAN. */
  NETWORK_TYPE_LAN = 1,
  /** 2: The network type is Wi-Fi (including hotspots). */
  NETWORK_TYPE_WIFI = 2,
  /** 3: The network type is mobile 2G. */
  NETWORK_TYPE_MOBILE_2G = 3,
  /** 4: The network type is mobile 3G. */
  NETWORK_TYPE_MOBILE_3G = 4,
  /** 5: The network type is mobile 4G. */
  NETWORK_TYPE_MOBILE_4G = 5,
  /** 6: The network type is mobile 5G.
   *
   * @since v3.5.1
   */
  NETWORK_TYPE_MOBILE_5G = 6,
};
/// @cond nodoc
/**
 * The reason for the upload failure.
 *
 * @since v3.3.0
 */
enum UPLOAD_ERROR_REASON {
  /** 0: The log file is successfully uploaded.
   */
  UPLOAD_SUCCESS = 0,
  /**
   * 1: Network error. Check the network connection and call \ref IRtcEngine::uploadLogFile "uploadLogFile" again to upload the log file.
   */
  UPLOAD_NET_ERROR = 1,
  /**
   * 2: An error occurs in the Agora server. Try uploading the log files later.
   */
  UPLOAD_SERVER_ERROR = 2,
};
/// @endcond

/** States of the last-mile network probe test. */
enum LASTMILE_PROBE_RESULT_STATE {
  /** 1: The last-mile network probe test is complete. */
  LASTMILE_PROBE_RESULT_COMPLETE = 1,
  /** 2: The last-mile network probe test is incomplete and the bandwidth estimation is not available, probably due to limited test resources. */
  LASTMILE_PROBE_RESULT_INCOMPLETE_NO_BWE = 2,
  /** 3: The last-mile network probe test is not carried out, probably due to poor network conditions. */
  LASTMILE_PROBE_RESULT_UNAVAILABLE = 3
};
/** The current audio route.
 *
 * Reports in the \ref IRtcEngineEventHandler::onAudioRouteChanged "onAudioRouteChanged" callback.
 */
enum AUDIO_ROUTE_TYPE {
  /** -1: Default audio route.
   */
  AUDIO_ROUTE_DEFAULT = -1,
  /** 0: The audio route is a headset with a microphone.
   */
  AUDIO_ROUTE_HEADSET = 0,
  /** 1: The audio route is an earpiece.
   */
  AUDIO_ROUTE_EARPIECE = 1,
  /** 2: The audio route is a headset without a microphone.
   */
  AUDIO_ROUTE_HEADSET_NO_MIC = 2,
  /** 3: The audio route is the speaker that comes with the device.
   */
  AUDIO_ROUTE_SPEAKERPHONE = 3,
  /** 4: (iOS and macOS only) The audio route is an external speaker.
   */
  AUDIO_ROUTE_LOUDSPEAKER = 4,
  /** 5: The audio route is a Bluetooth headset.
   */
  AUDIO_ROUTE_BLUETOOTH = 5,
  /** 6: (macOS only) The audio route is a USB peripheral device.
   */
  AUDIO_ROUTE_USB = 6,
  /** 7: (macOS only) The audio route is an HDMI peripheral device.
   */
  AUDIO_ROUTE_HDMI = 7,
  /** 8: (macOS only) The audio route is a DisplayPort peripheral device.
   */
  AUDIO_ROUTE_DISPLAYPORT = 8,
  /** 9: (iOS and macOS only) The audio route is Apple AirPlay.
   */
  AUDIO_ROUTE_AIRPLAY = 9,
};

/** The cloud proxy type.
 *
 * @since v3.3.0
 */
enum CLOUD_PROXY_TYPE {
  /** 0: The automatic mode. In this mode, the SDK attempts a direct connection to SD-RTN™ and automatically
   * switches to TLS 443 if the attempt fails. As of v3.6.2, the SDK has this mode enabled by default.
   */
  NONE_PROXY = 0,
  /** 1: The cloud proxy for the UDP protocol, that is, the Force UDP cloud proxy mode.
   * In this mode, the SDK always transmits data over UDP.
   */
  UDP_PROXY = 1,
  /** 2: The cloud proxy for the TCP (encryption) protocol, that is, the Force TCP cloud proxy mode.
   * In this mode, the SDK always transmits data over TLS 443.
   *
   * @since v3.6.2
   */
  TCP_PROXY = 2,
};
/// @cond nodoc
/** The local  proxy mode type. */
enum LOCAL_PROXY_MODE {
  /** 0: Connect local proxy with high priority, if not connected to local proxy, fallback to sdrtn.
   */
  ConnectivityFirst = 0,
  /** 1: Only connect local proxy
   */
  LocalOnly = 1,
};
/// @endcond
/**
 * The error code of the window blocking during screen sharing.
 *
 * @since v3.6.1
 */
enum EXCLUDE_WINDOW_ERROR {
  /**
   * -1: Fails to block the window during screen sharing. The user's graphics card does not support window blocking.
   */
  EXCLUDE_WINDOW_FAIL = -1,
  /**
   * 0: Reserved.
   */
  EXCLUDE_WINDOW_NONE = 0
};
/**
 * The proxy type.
 *
 * @since v3.6.2
 */
enum PROXY_TYPE {
  /** 0: Reserved for future use.
   */
  NONE_PROXY_TYPE = 0,
  /** 1: The cloud proxy for the UDP protocol, that is, the Force UDP cloud proxy mode. In this mode, the SDK always transmits data over UDP.
   */
  UDP_PROXY_TYPE = 1,
  /** 2: The cloud proxy for the TCP (encryption) protocol, that is, the Force TCP cloud proxy mode. In this mode, the SDK always transmits data over TLS 443.
   */
  TCP_PROXY_TYPE = 2,
  /** 3: Reserved for future use.
   */
  LOCAL_PROXY_TYPE = 3,
  /** 4: The automatic mode. In this mode, the SDK attempts a direct connection to SD-RTN™ and automatically switches to TLS 443 if the attempt fails.
   */
  TCP_PROXY_AUTO_FALLBACK_TYPE = 4,
};

#if (defined(__APPLE__) && TARGET_OS_IOS)
/**
 * The operational permission of the SDK on the audio session.
 */
enum AUDIO_SESSION_OPERATION_RESTRICTION {
  /**
   * 0: No restriction; the SDK can change the audio session.
   */
  AUDIO_SESSION_OPERATION_RESTRICTION_NONE = 0,
  /**
   * 1: The SDK cannot change the audio session category.
   */
  AUDIO_SESSION_OPERATION_RESTRICTION_SET_CATEGORY = 1,
  /**
   * 2: The SDK cannot change the audio session category, mode, or categoryOptions.
   */
  AUDIO_SESSION_OPERATION_RESTRICTION_CONFIGURE_SESSION = 1 << 1,
  /**
   * 4: The SDK keeps the audio session active when the user leaves the
   * channel, for example, to play an audio file in the background.
   */
  AUDIO_SESSION_OPERATION_RESTRICTION_DEACTIVATE_SESSION = 1 << 2,
  /**
   * 128: Completely restricts the operational permission of the SDK on the
   * audio session; the SDK cannot change the audio session.
   */
  AUDIO_SESSION_OPERATION_RESTRICTION_ALL = 1 << 7,
};
#endif

#if defined(__ANDROID__) || (defined(__APPLE__) && TARGET_OS_IOS)
enum CAMERA_DIRECTION {
  /** The rear camera. */
  CAMERA_REAR = 0,
  /** The front camera. */
  CAMERA_FRONT = 1,
};
#endif

/**
 * Recording content, which is set
 * in \ref IRtcEngine::startAudioRecording(const AudioRecordingConfiguration&) "startAudioRecording".
 */
enum AUDIO_RECORDING_POSITION {
  /** 0: (Default) Records the mixed audio of the local user and all remote
   * users.
   */
  AUDIO_RECORDING_POSITION_MIXED_RECORDING_AND_PLAYBACK = 0,
  /** 1: Records the audio of the local user only.
   */
  AUDIO_RECORDING_POSITION_RECORDING = 1,
  /** 2: Records the audio of all remote users only.
   */
  AUDIO_RECORDING_POSITION_MIXED_PLAYBACK = 2,
};

/** The uplink or downlink last-mile network probe test result. */
struct LastmileProbeOneWayResult {
  /** The packet loss rate (%). */
  unsigned int packetLossRate;
  /** The network jitter (ms). */
  unsigned int jitter;
  /* The estimated available bandwidth (bps). */
  unsigned int availableBandwidth;
};

/** The uplink and downlink last-mile network probe test result. */
struct LastmileProbeResult {
  /** The state of the probe test. */
  LASTMILE_PROBE_RESULT_STATE state;
  /** The uplink last-mile network probe test result. */
  LastmileProbeOneWayResult uplinkReport;
  /** The downlink last-mile network probe test result. */
  LastmileProbeOneWayResult downlinkReport;
  /** The round-trip delay time (ms). */
  unsigned int rtt;
};

/** Configurations of the last-mile network probe test. */
struct LastmileProbeConfig {
  /** Sets whether to test the uplink network. Some users, for example, the audience in a `LIVE_BROADCASTING` channel, do not need such a test:
  - true: test.
  - false: do not test. */
  bool probeUplink;
  /** Sets whether to test the downlink network:
  - true: test.
  - false: do not test. */
  bool probeDownlink;
  /** The expected maximum sending bitrate (bps) of the local user. The value ranges between 100000 and 5000000. We recommend setting this parameter according to the bitrate value set by \ref IRtcEngine::setVideoEncoderConfiguration "setVideoEncoderConfiguration". */
  unsigned int expectedUplinkBitrate;
  /** The expected maximum receiving bitrate (bps) of the local user. The value ranges between 100000 and 5000000. */
  unsigned int expectedDownlinkBitrate;
};

/** The volume information of users.
 */
struct AudioVolumeInfo {
  /**
   * The user ID.
   * - In the local user's callback, `uid = 0`.
   * - In the remote users' callback, `uid` is the ID of a remote user whose instantaneous volume is one of the three highest.
   */
  uid_t uid;
  /** The volume of each user after audio mixing. The value ranges between 0 (lowest volume) and 255 (highest volume).
   * In the local user's callback, `volume = totalVolume`.
   */
  unsigned int volume;
  /** Voice activity status of the local user.
   * - `0`: The local user is not speaking.
   * - `1`: The local user is speaking.
   *
   * @note
   * - The `vad` parameter cannot report the voice activity status of remote users.
   * In the remote users' callback, `vad` is always `1`.
   * - To use this parameter, you must set the `report_vad` parameter to `true`
   * when calling \ref agora::rtc::IRtcEngine::enableAudioVolumeIndication(int, int, bool) "enableAudioVolumeIndication".
   */
  unsigned int vad;
  /** The name of the channel where the user is in.
   */
  const char* channelId;
};

/**
 * The information of an audio file. This struct is reported
 * in \ref IRtcEngineEventHandler::onRequestAudioFileInfo "onRequestAudioFileInfo".
 *
 * @since v3.5.1
 */
struct AudioFileInfo {
  /** The file path.
   */
  const char* filePath;
  /** The file duration (ms).
   */
  int durationMs;
};

/** The information acquisition state. This enum is reported
 * in \ref IRtcEngineEventHandler::onRequestAudioFileInfo "onRequestAudioFileInfo".
 *
 * @since v3.5.1
 */
enum AUDIO_FILE_INFO_ERROR {
  /** 0: Successfully get the information of an audio file.
   */
  AUDIO_FILE_INFO_ERROR_OK = 0,

  /** 1: Fail to get the information of an audio file.
   */
  AUDIO_FILE_INFO_ERROR_FAILURE = 1
};

/**
 * The reason for a user role switch failure.
 *
 * @since v3.7.0
 */
enum CLIENT_ROLE_CHANGE_FAILED_REASON {
  /** 1: The number of hosts in the channel is already at the upper limit.
   *
   * @note This enumerator is reported only when the support for 128 users is enabled. The maximum number of hosts is based on the actual number of hosts configured when you enable the 128-user feature.
   */
  CLIENT_ROLE_CHANGE_FAILED_BY_TOO_MANY_BROADCASTERS = 1,

  /** 2: The request is rejected by the Agora server. Agora recommends you prompt the user to try to switch their user role again.
   */
  CLIENT_ROLE_CHANGE_FAILED_BY_NOT_AUTHORIZED = 2,

  /** 3: The request is timed out. Agora recommends you prompt the user to check the network connection and try to switch their user role again.
   */
  CLIENT_ROLE_CHANGE_FAILED_BY_REQUEST_TIME_OUT = 3,

  /** 4: The SDK connection fails. You can use `reason` reported in the `onConnectionStateChanged` callback to troubleshoot the failure.
   */
  CLIENT_ROLE_CHANGE_FAILED_BY_CONNECTION_FAILED = 4,
};

/** The detailed options of a user.
 */
struct ClientRoleOptions {
  /** The latency level of an audience member in interactive live streaming. See #AUDIENCE_LATENCY_LEVEL_TYPE.
   */
  AUDIENCE_LATENCY_LEVEL_TYPE audienceLatencyLevel;
  ClientRoleOptions() : audienceLatencyLevel(AUDIENCE_LATENCY_LEVEL_ULTRA_LOW_LATENCY) {}
};
/** Statistics of the channel.
 */
struct RtcStats {
  /**
   * Call duration of the local user in seconds, represented by an aggregate value.
   */
  unsigned int duration;
  /**
   * Total number of bytes transmitted, represented by an aggregate value.
   */
  unsigned int txBytes;
  /**
   * Total number of bytes received, represented by an aggregate value.
   */
  unsigned int rxBytes;
  /** Total number of audio bytes sent (bytes), represented
   * by an aggregate value.
   */
  unsigned int txAudioBytes;
  /** Total number of video bytes sent (bytes), represented
   * by an aggregate value.
   */
  unsigned int txVideoBytes;
  /** Total number of audio bytes received (bytes) before
   * network countermeasures, represented by an aggregate value.
   */
  unsigned int rxAudioBytes;
  /** Total number of video bytes received (bytes),
   * represented by an aggregate value.
   */
  unsigned int rxVideoBytes;

  /**
   * Transmission bitrate (Kbps), represented by an instantaneous value.
   */
  unsigned short txKBitRate;
  /**
   * Receive bitrate (Kbps), represented by an instantaneous value.
   */
  unsigned short rxKBitRate;
  /**
   * Audio receive bitrate (Kbps), represented by an instantaneous value.
   */
  unsigned short rxAudioKBitRate;
  /**
   * Audio transmission bitrate (Kbps), represented by an instantaneous value.
   */
  unsigned short txAudioKBitRate;
  /**
   * Video receive bitrate (Kbps), represented by an instantaneous value.
   */
  unsigned short rxVideoKBitRate;
  /**
   * Video transmission bitrate (Kbps), represented by an instantaneous value.
   */
  unsigned short txVideoKBitRate;
  /** Client-server latency (ms)
   */
  unsigned short lastmileDelay;
  /** The packet loss rate (%) from the local client to Agora's edge server,
   * before using the anti-packet-loss method.
   */
  unsigned short txPacketLossRate;
  /** The packet loss rate (%) from Agora's edge server to the local client,
   * before using the anti-packet-loss method.
   */
  unsigned short rxPacketLossRate;
  /** Number of users in the channel.
   *
   * - `COMMUNICATION` profile: The number of users in the channel.
   * - `LIVE_BROADCASTING` profile:
   *    -  If the local user is an audience: The number of users in the channel = The number of hosts in the channel + 1.
   *    -  If the user is a host: The number of users in the channel = The number of hosts in the channel.
   */
  unsigned int userCount;
  /**
   * Application CPU usage (%).
   *
   * @note
   * - The `cpuAppUsage` reported in the \ref IRtcEngineEventHandler::onLeaveChannel "onLeaveChannel" callback is always 0.
   * - As of Android 8.1, you might not be able to get the CPU usage from this attribute due to system limitations.
   */
  double cpuAppUsage;
  /**
   * System CPU usage (%).
   *
   * In the multi-kernel environment, this member represents the average CPU usage.
   * The value **=** 100 **-** System Idle Progress in Task Manager (%).
   *
   * @note
   * - The `cpuTotalUsage` reported in the \ref IRtcEngineEventHandler::onLeaveChannel "onLeaveChannel" callback is always 0.
   * - As of Android 8.1, you cannot get the CPU usage from this attribute due to system limitations.
   */
  double cpuTotalUsage;
  /** The round-trip time delay from the client to the local router.
   *
   * @note
   * - On iOS, As of v3.3.0, this attribute is disabled on devices running iOS 14 or later, and enabled on devices
   * running versions earlier than iOS 14 by default. To enable this property on devices running iOS 14 or later,
   * contact support@agora.io. See [FAQ](https://docs.agora.io/en/Interactive%20Broadcast/faq/local_network_privacy) for details.
   * - On Android, to get this attribute, ensure that the `android.permission.ACCESS_WIFI_STATE` permission has been added after `</application>` in
   * the `AndroidManifest.xml` file in your project.
   */
  int gatewayRtt;
  /**
   * The memory usage ratio of the app (%).
   *
   * @note This value is for reference only. Due to system limitations, you may not get the value of this member.
   */
  double memoryAppUsageRatio;
  /**
   * The memory usage ratio of the system (%).
   *
   * @note This value is for reference only. Due to system limitations, you may not get the value of this member.
   */
  double memoryTotalUsageRatio;
  /**
   * The memory usage of the app (KB).
   *
   * @note This value is for reference only. Due to system limitations, you may not get the value of this member.
   */
  int memoryAppUsageInKbytes;
  RtcStats() : duration(0), txBytes(0), rxBytes(0), txAudioBytes(0), txVideoBytes(0), rxAudioBytes(0), rxVideoBytes(0), txKBitRate(0), rxKBitRate(0), rxAudioKBitRate(0), txAudioKBitRate(0), rxVideoKBitRate(0), txVideoKBitRate(0), lastmileDelay(0), txPacketLossRate(0), rxPacketLossRate(0), userCount(0), cpuAppUsage(0), cpuTotalUsage(0), gatewayRtt(0), memoryAppUsageRatio(0), memoryTotalUsageRatio(0), memoryAppUsageInKbytes(0) {}
};
/// @cond nodoc
/** The reason of notifying the user of a message.
 */
enum WLACC_MESSAGE_REASON {
  /** WIFI signal is weak.*/
  WLACC_MESSAGE_REASON_WEAK_SIGNAL = 0,
  /** Channel congestion.*/
  WLACC_MESSAGE_REASON_CHANNEL_CONGESTION = 1,
};
/** Suggest an action for the user.
 */
enum WLACC_SUGGEST_ACTION {
  /** Please get close to AP.*/
  WLACC_SUGGEST_ACTION_CLOSE_TO_WIFI = 0,
  /** The user is advised to connect to the prompted SSID.*/
  WLACC_SUGGEST_ACTION_CONNECT_SSID = 1,
  /** The user is advised to check whether the AP supports 5G band and enable 5G band (the aciton link is attached), or purchases an AP that supports 5G. AP does not support 5G band.*/
  WLACC_SUGGEST_ACTION_CHECK_5G = 2,
  /** The user is advised to change the SSID of the 2.4G or 5G band (the aciton link is attached). The SSID of the 2.4G band AP is the same as that of the 5G band.*/
  WLACC_SUGGEST_ACTION_MODIFY_SSID = 3,
};
/** Indicator optimization degree.
 */
struct WlAccStats {
  /** End-to-end delay optimization percentage.*/
  unsigned short e2eDelayPercent;
  /** Frozen Ratio optimization percentage.*/
  unsigned short frozenRatioPercent;
  /** Loss Rate optimization percentage.*/
  unsigned short lossRatePercent;
};
/// @endcond
/** Quality change of the local video in terms of target frame rate and target bit rate since last count.
 */
enum QUALITY_ADAPT_INDICATION {
  /** The quality of the local video stays the same. */
  ADAPT_NONE = 0,
  /** The quality improves because the network bandwidth increases. */
  ADAPT_UP_BANDWIDTH = 1,
  /** The quality worsens because the network bandwidth decreases. */
  ADAPT_DOWN_BANDWIDTH = 2,
};
/**
 * The screen sharing information.
 *
 * @since v3.6.1
 */
struct ScreenCaptureInfo {
  /**
   * The type of the graphics card, which contains the model information of the graphics card.
   */
  const char* graphicsCardType;
  /**
   * The error code of the window blocking during screen sharing. See #EXCLUDE_WINDOW_ERROR
   */
  EXCLUDE_WINDOW_ERROR errCode;
};

/** Quality of experience (QoE) of the local user when receiving a remote audio stream.
 *
 * @since v3.3.0
 */
enum EXPERIENCE_QUALITY_TYPE {
  /** 0: QoE of the local user is good.  */
  EXPERIENCE_QUALITY_GOOD = 0,
  /** 1: QoE of the local user is poor.  */
  EXPERIENCE_QUALITY_BAD = 1,
};

/**
 * The reason for poor QoE of the local user when receiving a remote audio stream.
 *
 * @since v3.3.0
 */
enum EXPERIENCE_POOR_REASON {
  /** 0: No reason, indicating good QoE of the local user.
   */
  EXPERIENCE_REASON_NONE = 0,
  /** 1: The remote user's network quality is poor.
   */
  REMOTE_NETWORK_QUALITY_POOR = 1,
  /** 2: The local user's network quality is poor.
   */
  LOCAL_NETWORK_QUALITY_POOR = 2,
  /** 4: The local user's Wi-Fi or mobile network signal is weak.
   */
  WIRELESS_SIGNAL_POOR = 4,
  /** 8: The local user enables both Wi-Fi and bluetooth, and their signals interfere with each other.
   * As a result, audio transmission quality is undermined.
   */
  WIFI_BLUETOOTH_COEXIST = 8,
};

/** The error code in CHANNEL_MEDIA_RELAY_ERROR. */
enum CHANNEL_MEDIA_RELAY_ERROR {
  /** 0: The state is normal.
   */
  RELAY_OK = 0,
  /** 1: An error occurs in the server response.
   */
  RELAY_ERROR_SERVER_ERROR_RESPONSE = 1,
  /** 2: No server response.
   *
   * You can call the
   * \ref agora::rtc::IRtcEngine::leaveChannel "leaveChannel" method to
   * leave the channel.
   *
   * This error can also occur if your project has not enabled the service for co-hosting across channels.
   * Contact support@agora.io to enable the service for co-hosting across channels before starting a channel media relay.
   */
  RELAY_ERROR_SERVER_NO_RESPONSE = 2,
  /** 3: The SDK fails to access the service, probably due to limited
   * resources of the server.
   */
  RELAY_ERROR_NO_RESOURCE_AVAILABLE = 3,
  /** 4: Fails to send the relay request.
   */
  RELAY_ERROR_FAILED_JOIN_SRC = 4,
  /** 5: Fails to accept the relay request.
   */
  RELAY_ERROR_FAILED_JOIN_DEST = 5,
  /** 6: The server fails to receive the media stream.
   */
  RELAY_ERROR_FAILED_PACKET_RECEIVED_FROM_SRC = 6,
  /** 7: The server fails to send the media stream.
   */
  RELAY_ERROR_FAILED_PACKET_SENT_TO_DEST = 7,
  /** 8: The SDK disconnects from the server due to poor network
   * connections. You can call the \ref agora::rtc::IRtcEngine::leaveChannel
   * "leaveChannel" method to leave the channel.
   */
  RELAY_ERROR_SERVER_CONNECTION_LOST = 8,
  /** 9: An internal error occurs in the server.
   */
  RELAY_ERROR_INTERNAL_ERROR = 9,
  /** 10: The token of the source channel has expired.
   */
  RELAY_ERROR_SRC_TOKEN_EXPIRED = 10,
  /** 11: The token of the destination channel has expired.
   */
  RELAY_ERROR_DEST_TOKEN_EXPIRED = 11,
};

/** The event code in CHANNEL_MEDIA_RELAY_EVENT. */
enum CHANNEL_MEDIA_RELAY_EVENT {
  /** 0: The user disconnects from the server due to poor network
   * connections.
   */
  RELAY_EVENT_NETWORK_DISCONNECTED = 0,
  /** 1: The network reconnects.
   */
  RELAY_EVENT_NETWORK_CONNECTED = 1,
  /** 2: The user joins the source channel.
   */
  RELAY_EVENT_PACKET_JOINED_SRC_CHANNEL = 2,
  /** 3: The user joins the destination channel.
   */
  RELAY_EVENT_PACKET_JOINED_DEST_CHANNEL = 3,
  /** 4: The SDK starts relaying the media stream to the destination channel.
   */
  RELAY_EVENT_PACKET_SENT_TO_DEST_CHANNEL = 4,
  /** 5: The server receives the video stream from the source channel.
   */
  RELAY_EVENT_PACKET_RECEIVED_VIDEO_FROM_SRC = 5,
  /** 6: The server receives the audio stream from the source channel.
   */
  RELAY_EVENT_PACKET_RECEIVED_AUDIO_FROM_SRC = 6,
  /** 7: The destination channel is updated.
   */
  RELAY_EVENT_PACKET_UPDATE_DEST_CHANNEL = 7,
  /** 8: The destination channel update fails due to internal reasons.
   */
  RELAY_EVENT_PACKET_UPDATE_DEST_CHANNEL_REFUSED = 8,
  /** 9: The destination channel does not change, which means that the
   * destination channel fails to be updated.
   */
  RELAY_EVENT_PACKET_UPDATE_DEST_CHANNEL_NOT_CHANGE = 9,
  /** 10: The destination channel name is NULL.
   */
  RELAY_EVENT_PACKET_UPDATE_DEST_CHANNEL_IS_NULL = 10,
  /** 11: The video profile is sent to the server.
   */
  RELAY_EVENT_VIDEO_PROFILE_UPDATE = 11,
  /** 12: The SDK successfully pauses relaying the media stream to destination channels.
   *
   * @since v3.5.1
   */
  RELAY_EVENT_PAUSE_SEND_PACKET_TO_DEST_CHANNEL_SUCCESS = 12,
  /** 13: The SDK fails to pause relaying the media stream to destination channels.
   *
   * @since v3.5.1
   */
  RELAY_EVENT_PAUSE_SEND_PACKET_TO_DEST_CHANNEL_FAILED = 13,
  /** 14: The SDK successfully resumes relaying the media stream to destination channels.
   *
   * @since v3.5.1
   */
  RELAY_EVENT_RESUME_SEND_PACKET_TO_DEST_CHANNEL_SUCCESS = 14,
  /** 15: The SDK fails to resume relaying the media stream to destination channels.
   *
   * @since v3.5.1
   */
  RELAY_EVENT_RESUME_SEND_PACKET_TO_DEST_CHANNEL_FAILED = 15,
};

/** The state code in CHANNEL_MEDIA_RELAY_STATE. */
enum CHANNEL_MEDIA_RELAY_STATE {
  /** 0: The initial state. After you successfully stop the channel media
   * relay by calling \ref IRtcEngine::stopChannelMediaRelay "stopChannelMediaRelay",
   * the \ref IRtcEngineEventHandler::onChannelMediaRelayStateChanged "onChannelMediaRelayStateChanged" callback returns this state.
   */
  RELAY_STATE_IDLE = 0,
  /** 1: The SDK tries to relay the media stream to the destination channel.
   */
  RELAY_STATE_CONNECTING = 1,
  /** 2: The SDK successfully relays the media stream to the destination
   * channel.
   */
  RELAY_STATE_RUNNING = 2,
  /** 3: A failure occurs. See the details in code.
   */
  RELAY_STATE_FAILURE = 3,
};

/**
 * The volume type.
 *
 * @since v3.6.2
 */
enum AudioDeviceTestVolumeType {
  /** 0: The volume of the audio capturing device.
   */
  AudioTestRecordingVolume = 0,
  /** 1: The volume of the audio playback device.
   */
  AudioTestPlaybackVolume = 1,
};

/** Statistics of the local video stream.
 */
struct LocalVideoStats {
  /** Bitrate (Kbps) sent in the reported interval, which does not include
   * the bitrate of the retransmission video after packet loss.
   */
  int sentBitrate;
  /** Frame rate (fps) sent in the reported interval, which does not include
   * the frame rate of the retransmission video after packet loss.
   */
  int sentFrameRate;
  /** The encoder output frame rate (fps) of the local video.
   */
  int encoderOutputFrameRate;
  /** The render output frame rate (fps) of the local video.
   */
  int rendererOutputFrameRate;
  /** The target bitrate (Kbps) of the current encoder. This value is estimated by the SDK based on the current network conditions.
   */
  int targetBitrate;
  /** The target frame rate (fps) of the current encoder.
   */
  int targetFrameRate;
  /** Quality change of the local video in terms of target frame rate and
   * target bit rate in this reported interval. See #QUALITY_ADAPT_INDICATION.
   */
  QUALITY_ADAPT_INDICATION qualityAdaptIndication;
  /** The encoding bitrate (Kbps), which does not include the bitrate of the
   * re-transmission video after packet loss.
   */
  int encodedBitrate;
  /** The width of the encoding frame (px).
   */
  int encodedFrameWidth;
  /** The height of the encoding frame (px).
   */
  int encodedFrameHeight;
  /** The value of the sent frames, represented by an aggregate value.
   */
  int encodedFrameCount;
  /** The codec type of the local video:
   * - VIDEO_CODEC_VP8 = 1: VP8.
   * - VIDEO_CODEC_H264 = 2: (Default) H.264.
   */
  VIDEO_CODEC_TYPE codecType;
  /** The video packet loss rate (%) from the local client to the Agora edge server before applying the anti-packet loss strategies.
   */
  unsigned short txPacketLossRate;
  /** The capture frame rate (fps) of the local video.
   */
  int captureFrameRate;
  /** The brightness level of the video image captured by the local camera. See #CAPTURE_BRIGHTNESS_LEVEL_TYPE.
   *
   * @since v3.3.0
   */
  CAPTURE_BRIGHTNESS_LEVEL_TYPE captureBrightnessLevel;
};

/** Statistics of the remote video stream.
 */
struct RemoteVideoStats {
  /**
   User ID of the remote user sending the video streams.
   */
  uid_t uid;
  /** **DEPRECATED** Time delay (ms).
   *
   * In scenarios where audio and video is synchronized, you can use the value of
   * `networkTransportDelay` and `jitterBufferDelay` in `RemoteAudioStats` to know the delay statistics of the remote video.
   */
  int delay;
  /** Width (pixels) of the video stream.
   */
  int width;
  /**
   Height (pixels) of the video stream.
   */
  int height;
  /**
   Bitrate (Kbps) received since the last count.
   */
  int receivedBitrate;
  /** The decoder output frame rate (fps) of the remote video.
   */
  int decoderOutputFrameRate;
  /** The render output frame rate (fps) of the remote video.
   */
  int rendererOutputFrameRate;
  /** Packet loss rate (%) of the remote video stream after using the anti-packet-loss method.
   */
  int packetLossRate;
  /** The type of the remote video stream: #REMOTE_VIDEO_STREAM_TYPE
   */
  REMOTE_VIDEO_STREAM_TYPE rxStreamType;
  /**
   The total freeze time (ms) of the remote video stream after the remote user joins the channel.
   In a video session where the frame rate is set to no less than 5 fps, video freeze occurs when
   the time interval between two adjacent renderable video frames is more than 500 ms.
   */
  int totalFrozenTime;
  /**
   The total video freeze time as a percentage (%) of the total time when the video is available.
   */
  int frozenRate;
  /**
   The total time (ms) when the remote user in the Communication profile or the remote
   broadcaster in the Live-broadcast profile neither stops sending the video stream nor
   disables the video module after joining the channel.

   @since v3.0.1
  */
  int totalActiveTime;
  /**
   * The total publish duration (ms) of the remote video stream.
   */
  int publishDuration;
};

/** Audio statistics of the local user */
struct LocalAudioStats {
  /** The number of channels.
   */
  int numChannels;
  /** The sample rate (Hz).
   */
  int sentSampleRate;
  /** The average sending bitrate (Kbps).
   */
  int sentBitrate;
  /** The audio packet loss rate (%) from the local client to the Agora edge server before applying the anti-packet loss strategies.
   */
  unsigned short txPacketLossRate;
};

/** Audio statistics of a remote user */
struct RemoteAudioStats {
  /** User ID of the remote user sending the audio streams.
   *
   */
  uid_t uid;
  /** Audio quality received by the user: #QUALITY_TYPE.
   */
  int quality;
  /** Network delay (ms) from the sender to the receiver.
   */
  int networkTransportDelay;
  /** Network delay (ms) from the receiver to the jitter buffer.
   */
  int jitterBufferDelay;
  /** The audio frame loss rate in the reported interval.
   */
  int audioLossRate;
  /** The number of channels.
   */
  int numChannels;
  /** The sample rate (Hz) of the received audio stream in the reported
   * interval.
   */
  int receivedSampleRate;
  /** The average bitrate (Kbps) of the received audio stream in the
   * reported interval. */
  int receivedBitrate;
  /** The total freeze time (ms) of the remote audio stream after the remote user joins the channel. In a session, audio freeze occurs when the audio frame loss rate reaches 4%.
   */
  int totalFrozenTime;
  /** The total audio freeze time as a percentage (%) of the total time when the audio is available. */
  int frozenRate;
  /** The total time (ms) when the remote user in the `COMMUNICATION` profile or the remote host in
   the `LIVE_BROADCASTING` profile neither stops sending the audio stream nor disables the audio module after joining the channel.
   */
  int totalActiveTime;
  /**
   * The total publish duration (ms) of the remote audio stream.
   */
  int publishDuration;
  /**
   * Quality of experience (QoE) of the local user when receiving a remote audio stream. See #EXPERIENCE_QUALITY_TYPE.
   *
   * @since v3.3.0
   */
  int qoeQuality;
  /**
   * The reason for poor QoE of the local user when receiving a remote audio stream. See #EXPERIENCE_POOR_REASON.
   *
   * @since v3.3.0
   */
  int qualityChangedReason;
  /**
   * The quality of the remote audio stream as determined by the Agora
   * real-time audio MOS (Mean Opinion Score) measurement method in the
   * reported interval. The return value ranges from 0 to 500. Dividing the
   * return value by 100 gets the MOS score, which ranges from 0 to 5. The
   * higher the score, the better the audio quality.
   *
   * @since v3.3.1
   *
   * The subjective perception of audio quality corresponding to the Agora
   * real-time audio MOS scores is as follows:
   *
   * | MOS score       | Perception of audio quality                                                                                                                                 |
   * |-----------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
   * | Greater than 4  | Excellent. The audio sounds clear and smooth.                                                                                                               |
   * | From 3.5 to 4   | Good. The audio has some perceptible impairment, but still sounds clear.                                                                                    |
   * | From 3 to 3.5   | Fair. The audio freezes occasionally and requires attentive listening.                                                                                      |
   * | From 2.5 to 3   | Poor. The audio sounds choppy and requires considerable effort to understand.                                                                               |
   * | From 2 to 2.5   | Bad. The audio has occasional noise. Consecutive audio dropouts occur, resulting in some information loss. The users can communicate only with difficulty.  |
   * | Less than 2     | Very bad. The audio has persistent noise. Consecutive audio dropouts are frequent, resulting in severe information loss. Communication is nearly impossible. |
   */
  int mosValue;
};

/**
 * Video dimensions.
 */
struct VideoDimensions {
  /** Width (pixels) of the video. */
  int width;
  /** Height (pixels) of the video. */
  int height;
  VideoDimensions() : width(640), height(480) {}
  VideoDimensions(int w, int h) : width(w), height(h) {}
};

/** (Recommended) The standard bitrate set in the \ref IRtcEngine::setVideoEncoderConfiguration "setVideoEncoderConfiguration" method.

 In this mode, the bitrates differ between the interactive live streaming and communication profiles:

 - `COMMUNICATION` profile: The video bitrate is the same as the base bitrate.
 - `LIVE_BROADCASTING` profile: The video bitrate is twice the base bitrate.

 */
const int STANDARD_BITRATE = 0;

/** The compatible bitrate set in the \ref IRtcEngine::setVideoEncoderConfiguration "setVideoEncoderConfiguration" method.

 The bitrate remains the same regardless of the channel profile. If you choose this mode in the `LIVE_BROADCASTING` profile, the video frame rate may be lower than the set value.
 */
const int COMPATIBLE_BITRATE = -1;

/** Use the default minimum bitrate.
 */
const int DEFAULT_MIN_BITRATE = -1;

/** Video encoder configurations.
 */
struct VideoEncoderConfiguration {
  /** The video frame dimensions (px) used to specify the video quality and measured by the total number of pixels along a frame's width and height: VideoDimensions. The default value is 640 x 360.
   */
  VideoDimensions dimensions;
  /** The frame rate of the video: #FRAME_RATE. The default value is 15.

   Note that we do not recommend setting this to a value greater than 30.
  */
  FRAME_RATE frameRate;
  /** The minimum frame rate of the video. The default value is -1.
   */
  int minFrameRate;
  /** The video encoding bitrate (Kbps).

   Choose one of the following options:

   - #STANDARD_BITRATE: (Recommended) The standard bitrate.
      - the `COMMUNICATION` profile: the encoding bitrate equals the base bitrate.
      - the `LIVE_BROADCASTING` profile: the encoding bitrate is twice the base bitrate.
   - #COMPATIBLE_BITRATE: The compatible bitrate: the bitrate stays the same regardless of the profile.

   the `COMMUNICATION` profile prioritizes smoothness, while the `LIVE_BROADCASTING` profile prioritizes video quality (requiring a higher bitrate). We recommend setting the bitrate mode as #STANDARD_BITRATE to address this difference.

   The following table lists the recommended video encoder configurations, where the base bitrate applies to the `COMMUNICATION` profile. Set your bitrate based on this table. If you set a bitrate beyond the proper range, the SDK automatically sets it to within the range.

   @note
   In the following table, **Base Bitrate** applies to the `COMMUNICATION` profile, and **Live Bitrate** applies to the `LIVE_BROADCASTING` profile.

   | Resolution             | Frame Rate (fps) | Base Bitrate (Kbps)                    | Live Bitrate (Kbps)                    |
   |------------------------|------------------|----------------------------------------|----------------------------------------|
   | 160 * 120              | 15               | 65                                     | 130                                    |
   | 120 * 120              | 15               | 50                                     | 100                                    |
   | 320 * 180              | 15               | 140                                    | 280                                    |
   | 180 * 180              | 15               | 100                                    | 200                                    |
   | 240 * 180              | 15               | 120                                    | 240                                    |
   | 320 * 240              | 15               | 200                                    | 400                                    |
   | 240 * 240              | 15               | 140                                    | 280                                    |
   | 424 * 240              | 15               | 220                                    | 440                                    |
   | 640 * 360              | 15               | 400                                    | 800                                    |
   | 360 * 360              | 15               | 260                                    | 520                                    |
   | 640 * 360              | 30               | 600                                    | 1200                                   |
   | 360 * 360              | 30               | 400                                    | 800                                    |
   | 480 * 360              | 15               | 320                                    | 640                                    |
   | 480 * 360              | 30               | 490                                    | 980                                    |
   | 640 * 480              | 15               | 500                                    | 1000                                   |
   | 480 * 480              | 15               | 400                                    | 800                                    |
   | 640 * 480              | 30               | 750                                    | 1500                                   |
   | 480 * 480              | 30               | 600                                    | 1200                                   |
   | 848 * 480              | 15               | 610                                    | 1220                                   |
   | 848 * 480              | 30               | 930                                    | 1860                                   |
   | 640 * 480              | 10               | 400                                    | 800                                    |
   | 1280 * 720             | 15               | 1130                                   | 2260                                   |
   | 1280 * 720             | 30               | 1710                                   | 3420                                   |
   | 960 * 720              | 15               | 910                                    | 1820                                   |
   | 960 * 720              | 30               | 1380                                   | 2760                                   |
   | 1920 * 1080            | 15               | 2080                                   | 4160                                   |
   | 1920 * 1080            | 30               | 3150                                   | 6300                                   |
   | 1920 * 1080            | 60               | 4780                                   | 6500                                   |

   */
  int bitrate;
  /** The minimum encoding bitrate (Kbps).

   The SDK automatically adjusts the encoding bitrate to adapt to the network conditions. Using a value greater than the default value forces the video encoder to output high-quality images but may cause more packet loss and hence sacrifice the smoothness of the video transmission. That said, unless you have special requirements for image quality, Agora does not recommend changing this value.

   @note This parameter applies only to the `LIVE_BROADCASTING` profile.
   */
  int minBitrate;
  /** The video orientation mode of the video: #ORIENTATION_MODE.
   */
  ORIENTATION_MODE orientationMode;
  /** The video encoding degradation preference under limited bandwidth: #DEGRADATION_PREFERENCE.
   */
  DEGRADATION_PREFERENCE degradationPreference;
  /** Sets the mirror mode of the published local video stream. It only affects the video that the remote user sees. See #VIDEO_MIRROR_MODE_TYPE

  @note The SDK disables the mirror mode by default.
  */
  VIDEO_MIRROR_MODE_TYPE mirrorMode;

  VideoEncoderConfiguration(const VideoDimensions& d, FRAME_RATE f, int b, ORIENTATION_MODE m, VIDEO_MIRROR_MODE_TYPE mr = VIDEO_MIRROR_MODE_AUTO) : dimensions(d), frameRate(f), minFrameRate(-1), bitrate(b), minBitrate(DEFAULT_MIN_BITRATE), orientationMode(m), degradationPreference(MAINTAIN_QUALITY), mirrorMode(mr) {}
  VideoEncoderConfiguration(int width, int height, FRAME_RATE f, int b, ORIENTATION_MODE m, VIDEO_MIRROR_MODE_TYPE mr = VIDEO_MIRROR_MODE_AUTO) : dimensions(width, height), frameRate(f), minFrameRate(-1), bitrate(b), minBitrate(DEFAULT_MIN_BITRATE), orientationMode(m), degradationPreference(MAINTAIN_QUALITY), mirrorMode(mr) {}
  VideoEncoderConfiguration() : dimensions(640, 480), frameRate(FRAME_RATE_FPS_15), minFrameRate(-1), bitrate(STANDARD_BITRATE), minBitrate(DEFAULT_MIN_BITRATE), orientationMode(ORIENTATION_MODE_ADAPTIVE), degradationPreference(MAINTAIN_QUALITY), mirrorMode(VIDEO_MIRROR_MODE_AUTO) {}
};

/** Recording configuration, which is set in
 * \ref IRtcEngine::startAudioRecording(const AudioRecordingConfiguration&) "startAudioRecording".
 *
 * @since v3.4.0
 */
struct AudioRecordingConfiguration {
  /** The absolute path (including the filename extensions) of the recording
   * file. For example: `C:\music\audio.aac`.
   *
   * @note Ensure that the path you specify exists and is writable.
   */
  const char* filePath;
  /** Audio recording quality. See #AUDIO_RECORDING_QUALITY_TYPE.
   *
   * @note This parameter applies to AAC files only.
   */
  AUDIO_RECORDING_QUALITY_TYPE recordingQuality;
  /** Recording content. See #AUDIO_RECORDING_POSITION.
   */
  AUDIO_RECORDING_POSITION recordingPosition;
  /** Recording sample rate (Hz). The following values are supported:
   *
   * - `16000`
   * - (Default) `32000`
   * - `44100`
   * - `48000`
   *
   * @note If this parameter is set to `44100` or `48000`, for better
   * recording effects, Agora recommends recording WAV files or AAC files
   * whose `recordingQuality` is
   * #AUDIO_RECORDING_QUALITY_MEDIUM or #AUDIO_RECORDING_QUALITY_HIGH.
   */
  int recordingSampleRate;
  /**
   * @since v3.6.2
   *
   * The recorded audio channel. The following values are supported:
   * - `1`: (Default) Mono channel.
   * - `2`: Dual channel.
   *
   * @note The actual recorded audio channel is related to the audio channel that you capture.
   * If the captured audio is mono and `recordingChannel` is 2, the recorded audio is the dual-channel data that is copied from mono data, not stereo.
   * If the captured audio is dual channel and `recordingChannel` is 1, the recorded audio is the mono data that is mixed by dual-channel data.
   * The integration scheme also affects the final recorded audio channel. Therefore, to record in stereo, contact technical support for assistance.
   */
  int recordingChannel;

  AudioRecordingConfiguration() : filePath(nullptr), recordingQuality(AUDIO_RECORDING_QUALITY_MEDIUM), recordingPosition(AUDIO_RECORDING_POSITION_MIXED_RECORDING_AND_PLAYBACK), recordingSampleRate(32000), recordingChannel(1) {}
  AudioRecordingConfiguration(const char* path, AUDIO_RECORDING_QUALITY_TYPE quality, AUDIO_RECORDING_POSITION position, int sampleRate, int channel) : filePath(path), recordingQuality(quality), recordingPosition(position), recordingSampleRate(sampleRate), recordingChannel(channel) {}
};

/** The video and audio properties of the user displaying the video in the CDN live. Agora supports a maximum of 17 transcoding users in a CDN streaming channel.
 */
typedef struct TranscodingUser {
  /** User ID of the user displaying the video in the CDN live.
   */
  uid_t uid;

  /** Horizontal position (pixel) of the video frame relative to the top left corner.
   */
  int x;
  /** Vertical position (pixel) of the video frame relative to the top left corner.
   */
  int y;
  /** Width (pixel) of the video frame. The default value is 360.
   */
  int width;
  /** Height (pixel) of the video frame. The default value is 640.
   */
  int height;

  /** The layer index of the video frame. An integer. The value range is [0, 100].

   - 0: (Default) Bottom layer.
   - 100: Top layer.

   @note
   - If zOrder is beyond this range, the SDK reports #ERR_INVALID_ARGUMENT.
   - As of v2.3, the SDK supports zOrder = 0.
   */
  int zOrder;
  /** The transparency level of the user's video. The value ranges between 0 and 1.0:

   - 0: Completely transparent
   - 1.0: (Default) Opaque
   */
  double alpha;
  /** The audio channel of the sound. The default value is 0:

   - 0: (Default) Supports dual channels at most, depending on the upstream of the host.
   - 1: The audio stream of the host uses the FL audio channel. If the upstream of the host uses multiple audio channels, these channels are mixed into mono first.
   - 2: The audio stream of the host uses the FC audio channel. If the upstream of the host uses multiple audio channels, these channels are mixed into mono first.
   - 3: The audio stream of the host uses the FR audio channel. If the upstream of the host uses multiple audio channels, these channels are mixed into mono first.
   - 4: The audio stream of the host uses the BL audio channel. If the upstream of the host uses multiple audio channels, these channels are mixed into mono first.
   - 5: The audio stream of the host uses the BR audio channel. If the upstream of the host uses multiple audio channels, these channels are mixed into mono first.

   @note If your setting is not 0, you may need a specialized player.
   */
  int audioChannel;
  TranscodingUser() : uid(0), x(0), y(0), width(0), height(0), zOrder(0), alpha(1.0), audioChannel(0) {}

} TranscodingUser;

/** Image properties.

 The properties of the watermark and background images.
 */
typedef struct RtcImage {
  RtcImage() : url(NULL), x(0), y(0), width(0), height(0), zOrder(0), alpha(1.0) {}
  /** HTTP/HTTPS URL address of the image on the live video. The maximum length of this parameter is 1024 bytes. */
  const char* url;
  /** Horizontal position of the image from the upper left of the live video. */
  int x;
  /** Vertical position of the image from the upper left of the live video. */
  int y;
  /** Width of the image on the live video. */
  int width;
  /** Height of the image on the live video. */
  int height;
  /**
   * The layer number of the watermark or background image.
   *
   * When you use the watermark array to add a watermark or multiple watermarks, you must pass a value to `zOrder` in the range [1,255]; otherwise, the SDK reports an error. In other cases, `zOrder` can optionally be passed in the range [0,255], with `0` being the default value. `0` means the bottom layer and `255` means the top layer.
   *
   * @since v3.6.0
   */
  int zOrder;
  /** The transparency of the watermark or background image. The value range is [0.0,1.0]:
   * - `0.0`: Completely transparent.
   * - `1.0`: (Default) Opaque.
   *
   * @since v3.6.0
   */
  double alpha;
} RtcImage;
/// @cond nodoc
/** The configuration for advanced features of the RTMP or RTMPS streaming with transcoding.
 */
typedef struct LiveStreamAdvancedFeature {
  LiveStreamAdvancedFeature() : featureName(NULL), opened(false) {}
  LiveStreamAdvancedFeature(const char* feat_name, bool open) : featureName(feat_name), opened(open) {}
  /** The advanced feature for high-quality video with a lower bitrate. */
  // static const char* LBHQ = "lbhq";
  /** The advanced feature for the optimized video encoder. */
  // static const char* VEO = "veo";

  /** The name of the advanced feature. It contains LBHQ and VEO.
   */
  const char* featureName;

  /** Whether to enable the advanced feature:
   * - true: Enable the advanced feature.
   * - false: (Default) Disable the advanced feature.
   */
  bool opened;
} LiveStreamAdvancedFeature;

/// @endcond
/** A struct for managing CDN live audio/video transcoding settings.
 */
typedef struct LiveTranscoding {
  /** The width of the video in pixels. The default value is 360.
   * - When pushing video streams to the CDN, the value range of `width` is [64,1920].
   * If the value is less than 64, Agora server automatically adjusts it to 64; if the
   * value is greater than 1920, Agora server automatically adjusts it to 1920.
   * - When pushing audio streams to the CDN, set `width` and `height` as 0.
   */
  int width;
  /** The height of the video in pixels. The default value is 640.
   * - When pushing video streams to the CDN, the value range of `height` is [64,1080].
   * If the value is less than 64, Agora server automatically adjusts it to 64; if the
   * value is greater than 1080, Agora server automatically adjusts it to 1080.
   * - When pushing audio streams to the CDN, set `width` and `height` as 0.
   */
  int height;
  /** Bitrate of the CDN live output video stream. The default value is 400 Kbps.

  Set this parameter according to the Video Bitrate Table. If you set a bitrate beyond the proper range, the SDK automatically adapts it to a value within the range.
  */
  int videoBitrate;
  /** Frame rate of the output video stream set for the CDN live streaming. The default value is 15 fps, and the value range is (0,30].

  @note The Agora server adjusts any value over 30 to 30.
  */
  int videoFramerate;

  /** **DEPRECATED** Latency mode:

   - true: Low latency with unassured quality.
   - false: (Default) High latency with assured quality.
   */
  bool lowLatency;

  /** Video GOP in frames. The default value is 30 fps.
   */
  int videoGop;
  /** Self-defined video codec profile: #VIDEO_CODEC_PROFILE_TYPE.

  @note If you set this parameter to other values, Agora adjusts it to the default value of 100.
  */
  VIDEO_CODEC_PROFILE_TYPE videoCodecProfile;
  /** The background color in RGB hex value. Value only. Do not include a preceeding #. For example, 0xFFB6C1 (light pink). The default value is 0x000000 (black).
   */
  unsigned int backgroundColor;

  /**
   * The video codec type of the output video stream. See #VIDEO_CODEC_TYPE_FOR_STREAM.
   *
   * @since v3.2.0
   */
  VIDEO_CODEC_TYPE_FOR_STREAM videoCodecType;

  /** The number of users in the interactive live streaming.
   *
   *  The value range is [0,17].
   */
  unsigned int userCount;
  /** TranscodingUser
   */
  TranscodingUser* transcodingUsers;
  /** Reserved property. Extra user-defined information to send SEI for the H.264/H.265 video stream to the CDN live client. Maximum length: 4096 Bytes.

   For more information on SEI frame, see [SEI-related questions](https://docs.agora.io/en/faq/sei).
   */
  const char* transcodingExtraInfo;

  /** **DEPRECATED** The metadata sent to the CDN live client defined by the RTMP or HTTP-FLV metadata.
   */
  const char* metadata;
  /**
   * The watermark on the live video. The format must be in the PNG format. See RtcImage.
   * You can add a watermark or use an array to add multiple watermarks.
   * This parameter is used in conjunction with `watermarkCount`.
   */
  RtcImage* watermark;

  /**
   * The number of watermarks on the live video. The total number of watermarks and background images must be greater than or equal to 0 and less than or equal to 10.
   * This parameter is used in conjunction with `watermark`.
   *
   * @since v3.6.0
   */
  unsigned int watermarkCount;

  /**
   * The background image on the live video. The format must be in the PNG format. See RtcImage.
   * You can add a background image or use an array to add multiple background images.
   * This parameter is used in conjunction with `backgroundImageCount`.
   */
  RtcImage* backgroundImage;
  /**
   * The number of background images on the live video. The total number of watermarks and background images must be greater than or equal to 0 and less than or equal to 10.
   * This parameter is used in conjunction with `backgroundImage`.
   */
  unsigned int backgroundImageCount;

  /** Self-defined audio-sample rate: #AUDIO_SAMPLE_RATE_TYPE.
   */
  AUDIO_SAMPLE_RATE_TYPE audioSampleRate;
  /** Bitrate of the CDN live audio output stream. The default value is 48 Kbps, and the highest value is 128.
   */
  int audioBitrate;
  /** The numbder of audio channels for the CDN live stream. Agora recommends choosing 1 (mono), or 2 (stereo) audio channels. Special players are required if you choose option 3, 4, or 5:

   - 1: (Default) Mono.
   - 2: Stereo.
   - 3: Three audio channels.
   - 4: Four audio channels.
   - 5: Five audio channels.
   */
  int audioChannels;
  /** Self-defined audio codec profile: #AUDIO_CODEC_PROFILE_TYPE.
   */

  AUDIO_CODEC_PROFILE_TYPE audioCodecProfile;
  /// @cond nodoc
  /** Advanced features of the RTMP or RTMPS streaming with transcoding. See LiveStreamAdvancedFeature.
   *
   * @since v3.1.0
   */
  LiveStreamAdvancedFeature* advancedFeatures;

  /** The number of enabled advanced features. The default value is 0. */
  unsigned int advancedFeatureCount;
  /// @endcond
  LiveTranscoding() : width(360), height(640), videoBitrate(400), videoFramerate(15), lowLatency(false), videoGop(30), videoCodecProfile(VIDEO_CODEC_PROFILE_HIGH), backgroundColor(0x000000), videoCodecType(VIDEO_CODEC_H264_FOR_STREAM), userCount(0), transcodingUsers(NULL), transcodingExtraInfo(NULL), metadata(NULL), watermark(NULL), watermarkCount(0), backgroundImage(NULL), backgroundImageCount(0), audioSampleRate(AUDIO_SAMPLE_RATE_48000), audioBitrate(48), audioChannels(1), audioCodecProfile(AUDIO_CODEC_PROFILE_LC_AAC), advancedFeatures(NULL), advancedFeatureCount(0) {}
} LiveTranscoding;

/** Camera capturer configuration.
 */
struct CameraCapturerConfiguration {
  /** Camera capturer preference settings. See: #CAPTURER_OUTPUT_PREFERENCE. */
  CAPTURER_OUTPUT_PREFERENCE preference;
  /** The width (px) of the video image captured by the local camera.
   * To customize the width of the video image, set `preference` as #CAPTURER_OUTPUT_PREFERENCE_MANUAL (3) first,
   * and then use `captureWidth`.
   *
   * @since v3.3.0
   */
  int captureWidth;
  /** The height (px) of the video image captured by the local camera.
   * To customize the height of the video image, set `preference` as #CAPTURER_OUTPUT_PREFERENCE_MANUAL (3) first,
   * and then use `captureHeight`.
   *
   * @since v3.3.0
   */
  int captureHeight;
#if defined(__ANDROID__) || (defined(__APPLE__) && TARGET_OS_IOS)
  /** Camera direction settings (for Android/iOS only). See: #CAMERA_DIRECTION. */
  CAMERA_DIRECTION cameraDirection;
#endif

  CameraCapturerConfiguration() : preference(CAPTURER_OUTPUT_PREFERENCE_AUTO), captureWidth(640), captureHeight(480) {}

  CameraCapturerConfiguration(int width, int height) : preference(CAPTURER_OUTPUT_PREFERENCE_MANUAL), captureWidth(width), captureHeight(height) {}
};
/** The configurations for the data stream.
 *
 * @since v3.3.0
 *
 * |`syncWithAudio` |`ordered`| SDK behaviors|
 * |--------------|--------|-------------|
 * | false   |  false   |The SDK triggers the `onStreamMessage` callback immediately after the receiver receives a data packet      |
 * | true |  false | <p>If the data packet delay is within the audio delay, the SDK triggers the `onStreamMessage` callback when the synchronized audio packet is played out.</p><p>If the data packet delay exceeds the audio delay, the SDK triggers the `onStreamMessage` callback as soon as the data packet is received. In this case, the data packet is not synchronized with the audio packet.</p>   |
 * | false  |  true | <p>If the delay of a data packet is within five seconds, the SDK corrects the order of the data packet.</p><p>If the delay of a data packet exceeds five seconds, the SDK discards the data packet.</p>     |
 * |  true  |  true   | <p>If the delay of a data packet is within the audio delay, the SDK corrects the order of the data packet.</p><p>If the delay of a data packet exceeds the audio delay, the SDK discards this data packet.</p>     |
 */
struct DataStreamConfig {
  /** Whether to synchronize the data packet with the published audio packet.
   *
   * - true: Synchronize the data packet with the audio packet.
   * - false: Do not synchronize the data packet with the audio packet.
   *
   * When you set the data packet to synchronize with the audio, then if the data
   * packet delay is within the audio delay, the SDK triggers the `onStreamMessage` callback when
   * the synchronized audio packet is played out. Do not set this parameter as `true` if you
   * need the receiver to receive the data packet immediately. Agora recommends that you set
   * this parameter to `true` only when you need to implement specific functions, for example
   * lyric synchronization.
   */
  bool syncWithAudio;
  /** Whether the SDK guarantees that the receiver receives the data in the sent order.
   *
   * - true: Guarantee that the receiver receives the data in the sent order.
   * - false: Do not guarantee that the receiver receives the data in the sent order.
   *
   * Do not set this parameter to `true` if you need the receiver to receive the data immediately.
   */
  bool ordered;
};
/** Configuration of the injected media stream.
 */
struct InjectStreamConfig {
  /** Width of the injected stream in the interactive live streaming. The default value is 0 (same width as the original stream).
   */
  int width;
  /** Height of the injected stream in the interactive live streaming. The default value is 0 (same height as the original stream).
   */
  int height;
  /** Video GOP (in frames) of the injected stream in the interactive live streaming. The default value is 30 fps.
   */
  int videoGop;
  /** Video frame rate of the injected stream in the interactive live streaming. The default value is 15 fps.
   */
  int videoFramerate;
  /** Video bitrate of the injected stream in the interactive live streaming. The default value is 400 Kbps.

   @note The setting of the video bitrate is closely linked to the resolution. If the video bitrate you set is beyond a reasonable range, the SDK sets it within a reasonable range.
   */
  int videoBitrate;
  /** Audio-sample rate of the injected stream in the interactive live streaming: #AUDIO_SAMPLE_RATE_TYPE. The default value is 48000 Hz.

   @note We recommend setting the default value.
   */
  AUDIO_SAMPLE_RATE_TYPE audioSampleRate;
  /** Audio bitrate of the injected stream in the interactive live streaming. The default value is 48.

   @note We recommend setting the default value.
   */
  int audioBitrate;
  /** Audio channels in the interactive live streaming.


   - 1: (Default) Mono
   - 2: Two-channel stereo

   @note We recommend setting the default value.
   */
  int audioChannels;

  // width / height default set to 0 means pull the stream with its original resolution
  InjectStreamConfig() : width(0), height(0), videoGop(30), videoFramerate(15), videoBitrate(400), audioSampleRate(AUDIO_SAMPLE_RATE_48000), audioBitrate(48), audioChannels(1) {}
};
/** The definition of ChannelMediaInfo.
 */
struct ChannelMediaInfo {
  /** The channel name.
   */
  const char* channelName;
  /** The token that enables the user to join the channel.
   */
  const char* token;
  /** The user ID.
   */
  uid_t uid;
};

/** The definition of ChannelMediaRelayConfiguration.
 */
struct ChannelMediaRelayConfiguration {
  /** Pointer to the information of the source channel: ChannelMediaInfo. It contains the following members:
   * - `channelName`: The name of the source channel. The default value is `NULL`, which means the SDK applies the name of the current channel.
   * - `uid`: The unique ID to identify the relay stream in the source channel. The default value is 0, which means the SDK generates a random UID. You must set it as 0.
   * - `token`: The token for joining the source channel. It is generated with the `channelName` and `uid` you set in `srcInfo`.
   *   - If you have not enabled the App Certificate, set this parameter as the default value `NULL`, which means the SDK applies the App ID.
   *   - If you have enabled the App Certificate, you must use the `token` generated with the `channelName` and `uid`, and the `uid` must be set as 0.
   */
  ChannelMediaInfo* srcInfo;
  /** Pointer to the information of the destination channel: ChannelMediaInfo. It contains the following members:
   * - `channelName`: The name of the destination channel.
   * - `uid`: The unique ID to identify the relay stream in the destination channel. The value ranges from 0 to (2<sup>32</sup>-1).
   * To avoid UID conflicts, this `uid` must be different from any other UIDs in the destination channel. The default
   * value is 0, which means the SDK generates a random UID. Do not set this parameter as the `uid` of the host in
   * the destination channel, and ensure that this `uid` is different from any other `uid` in the channel.
   * - `token`: The token for joining the destination channel. It is generated with the `channelName` and `uid` you set in `destInfos`.
   *   - If you have not enabled the App Certificate, set this parameter as the default value `NULL`, which means the SDK applies the App ID.
   *   - If you have enabled the App Certificate, you must use the `token` generated with the `channelName` and `uid`.
   */
  ChannelMediaInfo* destInfos;
  /** The number of destination channels. The default value is 0, and the
   * value range is [0,4]. Ensure that the value of this parameter
   * corresponds to the number of ChannelMediaInfo structs you define in
   * `destInfos`.
   */
  int destCount;

  ChannelMediaRelayConfiguration() : srcInfo(nullptr), destInfos(nullptr), destCount(0) {}
};
/// @cond nodoc
struct LocalAccessPointConfiguration {
  /** local access point ip address list.
   */
  const char** ipList;
  /** the number of local access point ip address.
   */
  int ipListSize;
  /** local access point domain list.
   */
  const char** domainList;
  /** the number of local access point domain.
   */
  int domainListSize;
  /** certificate domain name installed on specific local access point. pass "" means using sni domain on specific local access point
   */
  const char* verifyDomainName;
  /** local proxy connection mode, connectivity first or local only.
   */
  LOCAL_PROXY_MODE mode;
  LocalAccessPointConfiguration() : ipList(nullptr), ipListSize(0), domainList(nullptr), domainListSize(0), verifyDomainName(nullptr), mode(ConnectivityFirst) {}
};
/// @endcond

/**  **DEPRECATED** Lifecycle of the CDN live video stream.
 */
enum RTMP_STREAM_LIFE_CYCLE_TYPE {
  /** Bind to the channel lifecycle. If all hosts leave the channel, the CDN live streaming stops after 30 seconds.
   */
  RTMP_STREAM_LIFE_CYCLE_BIND2CHANNEL = 1,
  /** Bind to the owner of the RTMP stream. If the owner leaves the channel, the CDN live streaming stops immediately.
   */
  RTMP_STREAM_LIFE_CYCLE_BIND2OWNER = 2,
};

/** Content hints for screen sharing.
 */
enum VideoContentHint {
  /** (Default) No content hint.
   */
  CONTENT_HINT_NONE,
  /** Motion-intensive content. Choose this option if you prefer smoothness or when you are sharing a video clip, movie, or video game.
   */
  CONTENT_HINT_MOTION,
  /** Motionless content. Choose this option if you prefer sharpness or when you are sharing a picture, PowerPoint slide, or text.
   */
  CONTENT_HINT_DETAILS
};
/**
 * The screen sharing scenario.
 *
 * @since v3.7.0
 */
enum SCREEN_SCENARIO_TYPE {
  /** 1: (Default) Document. This scenario prioritizes the video quality of screen sharing and reduces the latency of the shared video for the receiver. If you share documents, slides, and tables, you can set this scenario.
   */
  SCREEN_SCENARIO_DOCUMENT = 1,
  /** 2: Game. This scenario prioritizes the smoothness of screen sharing. If you share games, you can set this scenario.
   */
  SCREEN_SCENARIO_GAMING = 2,
  /** 3: Video. This scenario prioritizes the smoothness of screen sharing. If you share movies or live videos, you can set this scenario.
   */
  SCREEN_SCENARIO_VIDEO = 3,
  /** 4: Remote control. This scenario prioritizes the video quality of screen sharing and reduces the latency of the shared video for the receiver. If you share the device desktop being remotely controlled, you can set this scenario.
   */
  SCREEN_SCENARIO_RDC = 4,
};

/** The relative location of the region to the screen or window.
 */
struct Rectangle {
  /** The horizontal offset from the top-left corner.
   */
  int x;
  /** The vertical offset from the top-left corner.
   */
  int y;
  /** The width of the region.
   */
  int width;
  /** The height of the region.
   */
  int height;

  Rectangle() : x(0), y(0), width(0), height(0) {}
  Rectangle(int xx, int yy, int ww, int hh) : x(xx), y(yy), width(ww), height(hh) {}
};

/**  **DEPRECATED** Definition of the rectangular region. */
typedef struct Rect {
  /** Y-axis of the top line.
   */
  int top;
  /** X-axis of the left line.
   */
  int left;
  /** Y-axis of the bottom line.
   */
  int bottom;
  /** X-axis of the right line.
   */
  int right;

  Rect() : top(0), left(0), bottom(0), right(0) {}
  Rect(int t, int l, int b, int r) : top(t), left(l), bottom(b), right(r) {}
} Rect;

/** The options of the watermark image to be added. */
typedef struct WatermarkOptions {
  /** Sets whether or not the watermark image is visible in the local video preview:
   * - true: (Default) The watermark image is visible in preview.
   * - false: The watermark image is not visible in preview.
   */
  bool visibleInPreview;
  /**
   * The watermark position in the landscape mode. See Rectangle.
   * For detailed information on the landscape mode, see the advanced guide *Video Rotation*.
   */
  Rectangle positionInLandscapeMode;
  /**
   * The watermark position in the portrait mode. See Rectangle.
   * For detailed information on the portrait mode, see the advanced guide *Video Rotation*.
   */
  Rectangle positionInPortraitMode;

  WatermarkOptions() : visibleInPreview(true), positionInLandscapeMode(0, 0, 0, 0), positionInPortraitMode(0, 0, 0, 0) {}
} WatermarkOptions;

/** Screen sharing encoding parameters.
 */
struct ScreenCaptureParameters {
  /** The maximum encoding dimensions of the shared region in terms of width * height.

   The default value is 1920 * 1080 pixels, that is, 2073600 pixels. Agora uses the value of this parameter to calculate the charges.

   If the aspect ratio is different between the encoding dimensions and screen dimensions, Agora applies the following algorithms for encoding. Suppose the encoding dimensions are 1920 x 1080:

   - If the value of the screen dimensions is lower than that of the encoding dimensions, for example, 1000 * 1000, the SDK uses 1000 * 1000 for encoding.
   - If the value of the screen dimensions is higher than that of the encoding dimensions, for example, 2000 * 1500, the SDK uses the maximum value under 1920 * 1080 with the aspect ratio of the screen dimension (4:3) for encoding, that is, 1440 * 1080.
   */
  VideoDimensions dimensions;
  /** The frame rate (fps) of the shared region.

  The default value is 5. We do not recommend setting this to a value greater than 15.
   */
  int frameRate;
  /** The bitrate (Kbps) of the shared region.

  The default value is 0 (the SDK works out a bitrate according to the dimensions of the current screen).
   */
  int bitrate;
  /** Sets whether to capture the mouse for screen sharing:

  - true: (Default) Capture the mouse.
  - false: Do not capture the mouse.
   */
  bool captureMouseCursor;
  /** Whether to bring the window to the front when calling \ref IRtcEngine::startScreenCaptureByWindowId "startScreenCaptureByWindowId" to share the window:
   * - true: Bring the window to the front.
   * - false: (Default) Do not bring the window to the front.
   */
  bool windowFocus;
  /** A list of IDs of windows to be blocked.
   *
   * When calling \ref IRtcEngine::startScreenCaptureByScreenRect "startScreenCaptureByScreenRect" or \ref IRtcEngine::startScreenCaptureByDisplayId "startScreenCaptureByDisplayId" to start screen sharing, you can use this parameter to block the specified windows.
   *
   * When calling \ref IRtcEngine::updateScreenCaptureParameters "updateScreenCaptureParameters" to update the configuration for screen sharing, you can use this parameter to dynamically block the specified windows during screen sharing.
   *
   * @note (Windows only) The SDK does not support you to block windows on a device with multiple graphics cards. If you set `excludeWindowList` on such a device, the SDK reports the error code `ERR_NOT_SUPPORTED_MUTI_GPU_EXCLUDE_WINDOW(1736)`.
   */
  view_t* excludeWindowList;
  /** The number of windows to be blocked.
   */
  int excludeWindowCount;
  /** (macOS only) The width (px) of the border. Defaults to 0, and the value range is [0,50].
   *
   * @since v3.7.0
   */
  int highLightWidth;
  /** (macOS only) The color of the border in RGBA format. The default value is 0xFF8CBF26.
   *
   * @since v3.7.0
   */
  unsigned int highLightColor;
  /** (macOS only) Determines whether to place a border around the shared window or screen:
   * - true: Place a border.
   * - false: (Default) Do not place a border.
   *
   * @note When you share a part of a window or screen, the SDK places a border around the entire window or screen if you set `enableHighLight` as true.
   *
   * @since v3.7.0
   */
  bool enableHighLight;

  ScreenCaptureParameters() : dimensions(1920, 1080), frameRate(5), bitrate(STANDARD_BITRATE), captureMouseCursor(true), windowFocus(false), excludeWindowList(NULL), excludeWindowCount(0), highLightWidth(0), highLightColor(0), enableHighLight(false) {}
  ScreenCaptureParameters(const VideoDimensions& d, int f, int b, bool c, bool focus, view_t* ex = NULL, int cnt = 0) : dimensions(d), frameRate(f), bitrate(b), captureMouseCursor(c), windowFocus(focus), excludeWindowList(ex), excludeWindowCount(cnt), highLightWidth(0), highLightColor(0), enableHighLight(false) {}
  ScreenCaptureParameters(int width, int height, int f, int b, bool c, bool focus, view_t* ex = NULL, int cnt = 0) : dimensions(width, height), frameRate(f), bitrate(b), captureMouseCursor(c), windowFocus(focus), excludeWindowList(ex), excludeWindowCount(cnt), highLightWidth(0), highLightColor(0), enableHighLight(false) {}
};

/** Video display settings of the VideoCanvas class.
 */
struct VideoCanvas {
  /** Video display window (view).
   */
  view_t view;
  /** The rendering mode of the video view. See #RENDER_MODE_TYPE
   */
  int renderMode;
  /** The unique channel name for the AgoraRTC session in the string format. The string length must be less than 64 bytes. Supported character scopes are:
   - All lowercase English letters: a to z.
   - All uppercase English letters: A to Z.
   - All numeric characters: 0 to 9.
   - The space character.
   - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".

   @note
   - The default value is the empty string "". Use the default value if the user joins the channel using the \ref IRtcEngine::joinChannel "joinChannel" method in the IRtcEngine class. The `VideoCanvas` struct defines the video canvas of the user in the channel.
   - If the user joins the channel using the \ref IRtcEngine::joinChannel "joinChannel" method in the IChannel class, set this parameter as the `channelId` of the `IChannel` object. The `VideoCanvas` struct defines the video canvas of the user in the channel with the specified channel ID.
   */
  char channelId[MAX_CHANNEL_ID_LENGTH];
  /** The user ID. */
  uid_t uid;
  void* priv;  // private data (underlying video engine denotes it)
  /** The mirror mode of the video view. See VIDEO_MIRROR_MODE_TYPE
   @note
   - For the mirror mode of the local video view: If you use a front camera, the SDK enables the mirror mode by default; if you use a rear camera, the SDK disables the mirror mode by default.
   - For the mirror mode of the remote video view: The SDK disables the mirror mode by default.
  */
  VIDEO_MIRROR_MODE_TYPE mirrorMode;

  VideoCanvas() : view(NULL), renderMode(RENDER_MODE_HIDDEN), uid(0), priv(NULL), mirrorMode(VIDEO_MIRROR_MODE_AUTO) { channelId[0] = '\0'; }
  VideoCanvas(view_t v, int m, uid_t u) : view(v), renderMode(m), uid(u), priv(NULL), mirrorMode(VIDEO_MIRROR_MODE_AUTO) { channelId[0] = '\0'; }
  VideoCanvas(view_t v, int m, const char* ch, uid_t u) : view(v), renderMode(m), uid(u), priv(NULL), mirrorMode(VIDEO_MIRROR_MODE_AUTO) {
    strncpy(channelId, ch, MAX_CHANNEL_ID_LENGTH);
    channelId[MAX_CHANNEL_ID_LENGTH - 1] = '\0';
  }
  VideoCanvas(view_t v, int rm, uid_t u, VIDEO_MIRROR_MODE_TYPE mm) : view(v), renderMode(rm), uid(u), priv(NULL), mirrorMode(mm) { channelId[0] = '\0'; }
  VideoCanvas(view_t v, int rm, const char* ch, uid_t u, VIDEO_MIRROR_MODE_TYPE mm) : view(v), renderMode(rm), uid(u), priv(NULL), mirrorMode(mm) {
    strncpy(channelId, ch, MAX_CHANNEL_ID_LENGTH);
    channelId[MAX_CHANNEL_ID_LENGTH - 1] = '\0';
  }
};

/** Image enhancement options.
 */
struct BeautyOptions {
  /** The contrast level, often used in conjunction with `lighteningLevel`.
   */
  enum LIGHTENING_CONTRAST_LEVEL {
    /** 0: Low contrast level. */
    LIGHTENING_CONTRAST_LOW = 0,
    /** (Default) Normal contrast level. */
    LIGHTENING_CONTRAST_NORMAL,
    /** High contrast level. */
    LIGHTENING_CONTRAST_HIGH
  };

  /** The contrast level, often used in conjunction with `lighteningLevel`.
   * The higher the value, the greater the contrast level. See #LIGHTENING_CONTRAST_LEVEL.
   */
  LIGHTENING_CONTRAST_LEVEL lighteningContrastLevel;

  /**
   * The brightening level, in the range [0.0,1.0], where 0.0 means the original brightening. The default value is 0.6. The higher the value, the greater the brightening level.
   */
  float lighteningLevel;

  /** The smoothness level, in the range [0.0,1.0], where 0.0 means the original smoothness. The default value is 0.5. The higher the value, the greater the smoothness level.
   */
  float smoothnessLevel;

  /** The redness level, in the range [0.0,1.0], where 0.0 means the original redness. The default value is 0.1. The higher the value, the greater the redness level.
   */
  float rednessLevel;

  /** The sharpness level, in the range [0.0,1.0], where 0.0 means the original sharpness.
   * The default value is 0.3. The higher the value, the greater the sharpness level.
   *
   * @since v3.6.0
   */
  float sharpnessLevel;

  BeautyOptions(LIGHTENING_CONTRAST_LEVEL contrastLevel, float lightening, float smoothness, float redness, float sharpness) : lighteningLevel(lightening), smoothnessLevel(smoothness), rednessLevel(redness), lighteningContrastLevel(contrastLevel), sharpnessLevel(sharpness) {}

  BeautyOptions() : lighteningLevel(0), smoothnessLevel(0), rednessLevel(0), sharpnessLevel(0), lighteningContrastLevel(LIGHTENING_CONTRAST_NORMAL) {}
};

/** The low-light enhancement options.
 *
 * @since v3.6.2
 */
struct LowLightEnhanceOptions {
  /**
   * The low-light enhancement mode.
   */
  enum LOW_LIGHT_ENHANCE_MODE {
    /** 0: (Default) Automatic mode. The SDK automatically enables or disables the low-light enhancement feature according to the ambient light to compensate for the lighting level or prevent overexposure, as necessary. */
    LOW_LIGHT_ENHANCE_AUTO = 0,
    /** Manual mode. Users need to enable or disable the low-light enhancement feature manually. */
    LOW_LIGHT_ENHANCE_MANUAL
  };
  /**
   * The low-light enhancement level.
   */
  enum LOW_LIGHT_ENHANCE_LEVEL {
    /**
     * 0: (Default) Promotes video quality during low-light enhancement. It processes the brightness, details, and noise of the video image. The performance consumption is moderate, the processing speed is moderate, and the overall video quality is optimal.
     */
    LOW_LIGHT_ENHANCE_LEVEL_HIGH_QUALITY = 0,
    /**
     * Promotes performance during low-light enhancement. It processes the brightness and details of the video image. The processing speed is faster.
     */
    LOW_LIGHT_ENHANCE_LEVEL_FAST
  };

  /** The low-light enhancement mode. See #LOW_LIGHT_ENHANCE_MODE.
   */
  LOW_LIGHT_ENHANCE_MODE mode;

  /** The low-light enhancement level. See #LOW_LIGHT_ENHANCE_LEVEL.
   */
  LOW_LIGHT_ENHANCE_LEVEL level;

  LowLightEnhanceOptions(LOW_LIGHT_ENHANCE_MODE lowlightMode, LOW_LIGHT_ENHANCE_LEVEL lowlightLevel) : mode(lowlightMode), level(lowlightLevel) {}

  LowLightEnhanceOptions() : mode(LOW_LIGHT_ENHANCE_AUTO), level(LOW_LIGHT_ENHANCE_LEVEL_HIGH_QUALITY) {}
};
/**
 * The video noise reduction options.
 *
 * @since v3.6.2
 */
struct VideoDenoiserOptions {
  /** The video noise reduction mode.
   */
  enum VIDEO_DENOISER_MODE {
    /** 0: (Default) Automatic mode. The SDK automatically enables or disables the video noise reduction feature according to the ambient light. */
    VIDEO_DENOISER_AUTO = 0,
    /** Manual mode. Users need to enable or disable the video noise reduction feature manually. */
    VIDEO_DENOISER_MANUAL
  };
  /**
   * The video noise reduction level.
   */
  enum VIDEO_DENOISER_LEVEL {
    /**
     * 0: (Default) Promotes video quality during video noise reduction. `HIGH_QUALITY` balances performance consumption and video noise reduction quality.
     * The performance consumption is moderate, the video noise reduction speed is moderate, and the overall video quality is optimal.
     */
    VIDEO_DENOISER_LEVEL_HIGH_QUALITY = 0,
    /**
     * Promotes reducing performance consumption during video noise reduction. `FAST` prioritizes reducing performance consumption over video noise reduction quality.
     * The performance consumption is lower, and the video noise reduction speed is faster. To avoid a noticeable shadowing effect (shadows trailing behind moving objects) in the processed video, Agora recommends that you use `FAST` when the camera is fixed.
     */
    VIDEO_DENOISER_LEVEL_FAST,
    /**
     * Enhanced video noise reduction. `STRENGTH` prioritizes video noise reduction quality over reducing performance consumption.
     * The performance consumption is higher, the video noise reduction speed is slower, and the video noise reduction quality is better.
     * If `HIGH_QUALITY` is not enough for your video noise reduction needs, you can use `STRENGTH`.
     */
    VIDEO_DENOISER_LEVEL_STRENGTH
  };
  /** The video noise reduction mode. See #VIDEO_DENOISER_MODE.
   */
  VIDEO_DENOISER_MODE mode;

  /** The video noise reduction level. See #VIDEO_DENOISER_LEVEL.
   */
  VIDEO_DENOISER_LEVEL level;

  VideoDenoiserOptions(VIDEO_DENOISER_MODE denoiserMode, VIDEO_DENOISER_LEVEL denoiserLevel) : mode(denoiserMode), level(denoiserLevel) {}

  VideoDenoiserOptions() : mode(VIDEO_DENOISER_AUTO), level(VIDEO_DENOISER_LEVEL_HIGH_QUALITY) {}
};

/** The color enhancement options.
 *
 * @since v3.6.2
 */
struct ColorEnhanceOptions {
  /** The level of color enhancement. The value range is [0.0,1.0]. `0.0` is the default value, which means no color enhancement is applied to the video. The higher the value, the higher the level of color enhancement.
   */
  float strengthLevel;

  /** The level of skin tone protection. The value range is [0.0,1.0]. `0.0` means no skin tone protection. The higher the value, the higher the level of skin tone protection.
   * The default value is `1.0`. When the level of color enhancement is higher, the portrait skin tone can be significantly distorted, so you need to set the level of skin tone protection; when the level of skin tone protection is higher, the color enhancement effect can be slightly reduced.
   * Therefore, to get the best color enhancement effect, Agora recommends that you adjust `strengthLevel` and `skinProtectLevel` to get the most appropriate values.
   */
  float skinProtectLevel;

  ColorEnhanceOptions(float stength, float skinProtect) : strengthLevel(stength), skinProtectLevel(skinProtect) {}

  ColorEnhanceOptions() : strengthLevel(0), skinProtectLevel(1) {}
};

/** The custom background image.
 *
 * @since v3.4.5
 */
struct VirtualBackgroundSource {
  /** The type of the custom background image.
   *
   * @since v3.4.5
   */
  enum BACKGROUND_SOURCE_TYPE {
    /**
     * 1: (Default) The background image is a solid color.
     */
    BACKGROUND_COLOR = 1,
    /**
     * The background image is a file in PNG or JPG format.
     */
    BACKGROUND_IMG,
    /**
     * The background image is blurred.
     *
     * @since v3.5.1
     */
    BACKGROUND_BLUR,
  };

  /**
   * The degree of blurring applied to the custom background image.
   *
   * @since v3.5.1
   */
  enum BACKGROUND_BLUR_DEGREE {
    /**
     * 1: The degree of blurring applied to the custom background image is low.
     * The user can almost see the background clearly.
     */
    BLUR_DEGREE_LOW = 1,
    /**
     * The degree of blurring applied to the custom background image is medium.
     * It is difficult for the user to recognize details in the background.
     */
    BLUR_DEGREE_MEDIUM,
    /**
     * (Default) The degree of blurring applied to the custom background image is high.
     * The user can barely see any distinguishing features in the background.
     */
    BLUR_DEGREE_HIGH,
  };

  /** The type of the custom background image. See #BACKGROUND_SOURCE_TYPE.
   */
  BACKGROUND_SOURCE_TYPE background_source_type;

  /**
   * The color of the custom background image. The format is a hexadecimal integer defined by RGB, without the # sign,
   * such as 0xFFB6C1 for light pink. The default value is 0xFFFFFF, which signifies white. The value range
   * is [0x000000,0xFFFFFF]. If the value is invalid, the SDK replaces the original background image with a white
   * background image.
   *
   * @note This parameter takes effect only when the type of the custom background image is `BACKGROUND_COLOR`.
   */
  unsigned int color;

  /**
   * The local absolute path of the custom background image. PNG and JPG formats are supported. If the path is invalid,
   * the SDK replaces the original background image with a white background image.
   *
   * @note This parameter takes effect only when the type of the custom background image is `BACKGROUND_IMG`.
   */
  const char* source;

  /**
   * The degree of blurring applied to the custom background image. See #BACKGROUND_BLUR_DEGREE.
   *
   * @note This parameter takes effect only when the type of the custom background image is `BACKGROUND_BLUR`.
   *
   * @since v3.5.1
   */
  BACKGROUND_BLUR_DEGREE blur_degree;

  VirtualBackgroundSource() : color(0xffffff), source(NULL), background_source_type(BACKGROUND_COLOR), blur_degree(BLUR_DEGREE_HIGH) {}
};

/**
 * The UserInfo struct.
 */
struct UserInfo {
  /**
   * The user ID.
   */
  uid_t uid;
  /**
   * The user account.
   */
  char userAccount[MAX_USER_ACCOUNT_LENGTH];
  UserInfo() : uid(0) { userAccount[0] = '\0'; }
};
/**
 * The configuration of the audio and video call loop test.
 *
 * @since v3.5.2
 */
struct EchoTestConfiguration {
  /**
   * The view used to render the local user's video. This parameter is only applicable to scenarios testing video
   * devices, that is, when `enableVideo` is `true`.
   */
  view_t view;
  /**
   * Whether to enable the audio device for the call loop test:
   * - true: (Default) Enables the audio device. To test the audio device, set this parameter as `true`.
   * - false: Disable the audio device.
   */
  bool enableAudio;
  /**
   * Whether to enable the video device for the call loop test:
   * - true: (Default) Enables the video device. To test the video device, set this parameter as `true`.
   * - false: Disable the video device.
   */
  bool enableVideo;
  /**
   * The token used to secure the audio and video call loop test. If you do not enable App Certificate in Agora
   * Console, you do not need to pass a value in this parameter; if you have enabled App Certificate in Agora Console,
   * you must pass a token in this parameter, the `uid` used when you generate the token must be 0xFFFFFFFF, and the
   * channel name used must be the channel name that identifies each audio and video call loop tested. For server-side
   * token generation, see [Authenticate Your Users with Tokens](https://docs.agora.io/en/Interactive%20Broadcast/token_server?platform=All%20Platforms).
   */
  const char* token;
  /**
   * The channel name that identifies each audio and video call loop. To ensure proper loop test functionality, the
   * channel name passed in to identify each loop test cannot be the same when users of the same project (App ID)
   * perform audio and video call loop tests on different devices.
   */
  const char* channelId;
  EchoTestConfiguration() : view(NULL), enableAudio(true), enableVideo(true), token(NULL), channelId(NULL) {}
  EchoTestConfiguration(view_t v, bool ea, bool ev, const char* t, const char* c) : view(v), enableAudio(ea), enableVideo(ev), token(t), channelId(c) {}
};

/**
 *  Regions for connetion.
 */
enum AREA_CODE {
  /**
   * Mainland China.
   */
  AREA_CODE_CN = 0x00000001,
  /**
   * North America.
   */
  AREA_CODE_NA = 0x00000002,
  /**
   * Europe.
   */
  AREA_CODE_EU = 0x00000004,
  /**
   * Asia, excluding Mainland China.
   */
  AREA_CODE_AS = 0x00000008,
  /**
   * Japan.
   */
  AREA_CODE_JP = 0x00000010,
  /**
   * India.
   */
  AREA_CODE_IN = 0x00000020,
  /**
   * (Default) Global.
   */
  AREA_CODE_GLOB = 0xFFFFFFFF
};

enum ENCRYPTION_CONFIG {
  /**
   * - 1: Force set master key and mode;
   * - 0: Not force set, checking whether encryption plugin exists
   */
  ENCRYPTION_FORCE_SETTING = (1 << 0),
  /**
   * - 1: Force not encrypting packet;
   * - 0: Not force encrypting;
   */
  ENCRYPTION_FORCE_DISABLE_PACKET = (1 << 1)
};
/// @cond nodoc
typedef int ContentInspectType;
/**
 * (Default) content inspect type invalid
 */
const ContentInspectType kContentInspectInvalid = 0;
/**
 * Content inspect type moderation
 */
const ContentInspectType kContentInspectModeration = 1;
/**
 * Content inspect type supervise
 */
const ContentInspectType kContentInspectSupervise = 2;

enum MAX_CONTENT_INSPECT_MODULE_TYPE {
  /** The maximum count of content inspect feature type is 32.
   */
  MAX_CONTENT_INSPECT_MODULE_COUNT = 32
};
/// @endcond
/// @cond nodoc
/** Definition of ContentInspectModule.
 */
struct ContentInspectModule {
  /**
   * The content inspect module type.
   * the module type can be 0 to 31.
   * kContentInspectInvalid(0)
   * kContentInspectModeration(1)
   * kContentInspectSupervise(2)
   */
  ContentInspectType type;
  /**The content inspect frequency, default is 0 second.
   * the frequency <= 0 is invalid.
   */
  int interval;
  /**The content inspect default value.
   */
  ContentInspectModule() {
    type = kContentInspectInvalid;
    interval = 0;
  }
};
/// @endcond
/// @cond nodoc
/** Definition of ContentInspectConfig.
 */
struct ContentInspectConfig {
  /** The extra information, max length of extraInfo is 1024.
   *  The extra information will send to server with content(image).
   */
  const char* extraInfo;
  /**The content inspect modules, max length of modules is 32.
   * the content(snapshot of send video stream, image) can be used to max of 32 types functions.
   */
  ContentInspectModule modules[MAX_CONTENT_INSPECT_MODULE_COUNT];
  /**The content inspect module count.
   */
  int moduleCount;

  ContentInspectConfig() : extraInfo(NULL), moduleCount(0) {}
};
/// @endcond

/** Definition of IPacketObserver.
 */
class IPacketObserver {
 public:
  /** Definition of Packet.
   */
  struct Packet {
    /** Buffer address of the sent or received data.
     *
     * @note Agora recommends that the value of buffer is more than 2048 bytes,
     * otherwise, you may meet undefined behaviors such as a crash.
     */
    const unsigned char* buffer;
    /** Buffer size of the sent or received data.
     */
    unsigned int size;
  };
  /** Occurs when the local user sends an audio packet.

   @param packet The sent audio packet. See Packet.
   @return
   - true: The audio packet is sent successfully.
   - false: The audio packet is discarded.
   */
  virtual bool onSendAudioPacket(Packet& packet) = 0;
  /** Occurs when the local user sends a video packet.

   @param packet The sent video packet. See Packet.
   @return
   - true: The video packet is sent successfully.
   - false: The video packet is discarded.
   */
  virtual bool onSendVideoPacket(Packet& packet) = 0;
  /** Occurs when the local user receives an audio packet.

   @param packet The received audio packet. See Packet.
   @return
   - true: The audio packet is received successfully.
   - false: The audio packet is discarded.
   */
  virtual bool onReceiveAudioPacket(Packet& packet) = 0;
  /** Occurs when the local user receives a video packet.

   @param packet The received video packet. See Packet.
   @return
   - true: The video packet is received successfully.
   - false: The video packet is discarded.
   */
  virtual bool onReceiveVideoPacket(Packet& packet) = 0;
};

/** The capture type of the custom video source.
 */
enum VIDEO_CAPTURE_TYPE {
  /** Unknown type.
   */
  VIDEO_CAPTURE_UNKNOWN,
  /** (Default) Video captured by the camera.
   */
  VIDEO_CAPTURE_CAMERA,
  /** Video for screen sharing.
   */
  VIDEO_CAPTURE_SCREEN,
};

/** The IVideoFrameConsumer class. The SDK uses it to receive the video frame that you capture.
 */
class IVideoFrameConsumer {
 public:
  /** Receives the raw video frame.
   *
   * @note Ensure that the video frame type that you specify in this method is the same as that in the \ref agora::rtc::IVideoSource::getBufferType "getBufferType" callback.
   *
   * @param buffer The video buffer.
   * @param frameType The video frame type. See \ref agora::media::ExternalVideoFrame::VIDEO_PIXEL_FORMAT "VIDEO_PIXEL_FORMAT".
   * @param width The width (px) of the video frame.
   * @param height The height (px) of the video frame.
   * @param rotation The angle (degree) at which the video frame rotates clockwise. If you set the rotation angle, the
   * SDK rotates the video frame after receiving it. You can set the rotation angle as `0`, `90`, `180`, and `270`.
   * @param timestamp The Unix timestamp (ms) of the video frame. You must set a timestamp for each video frame.
   */
  virtual void consumeRawVideoFrame(const unsigned char* buffer, agora::media::ExternalVideoFrame::VIDEO_PIXEL_FORMAT frameType, int width, int height, int rotation, long timestamp) = 0;
};

/** The IVideoSource class. You can use it to customize the video source.
 */
class IVideoSource {
 public:
  /** Notification for initializing the custom video source.
   *
   * The SDK triggers this callback to remind you to initialize the custom video source. After receiving this callback,
   * you can do some preparation, such as enabling the camera, and then use the return value to tell the SDK whether the
   * custom video source is prepared.
   *
   * @param consumer An IVideoFrameConsumer object that the SDK passes to you. You need to reserve this object and use it
   * to send the video frame to the SDK once the custom video source is started. See IVideoFrameConsumer.
   *
   * @return
   * - true: The custom video source is initialized.
   * - false: The custom video source is not ready or fails to initialize. The SDK stops and reports the error.
   */
  virtual bool onInitialize(IVideoFrameConsumer* consumer) = 0;

  /** Notification for disabling the custom video source.
   *
   * The SDK triggers this callback to remind you to disable the custom video source device. This callback tells you
   * that the SDK is about to release the IVideoFrameConsumer object. Ensure that you no longer use IVideoFrameConsumer
   * after receiving this callback.
   */
  virtual void onDispose() = 0;

  /** Notification for starting the custom video source.
   *
   * The SDK triggers this callback to remind you to start the custom video source for capturing video. The SDK uses
   * IVideoFrameConsumer to receive the video frame that you capture after the video source is started. You must use
   * the return value to tell the SDK whether the custom video source is started.
   *
   * @return
   * - true: The custom video source is started.
   * - false: The custom video source fails to start. The SDK stops and reports the error.
   */
  virtual bool onStart() = 0;

  /** Notification for stopping capturing video.
   *
   * The SDK triggers this callback to remind you to stop capturing video. This callback tells you that the SDK is about
   * to stop using IVideoFrameConsumer to receive the video frame that you capture.
   */
  virtual void onStop() = 0;

  /** Gets the video frame type.
   *
   * Before you initialize the custom video source, the SDK triggers this callback to query the video frame type. You
   * must specify the video frame type in the return value and then pass it to the SDK.
   *
   * @note Ensure that the video frame type that you specify in this callback is the same as that in the \ref agora::rtc::IVideoFrameConsumer::consumeRawVideoFrame "consumeRawVideoFrame" method.
   *
   * @return \ref agora::media::ExternalVideoFrame::VIDEO_PIXEL_FORMAT "VIDEO_PIXEL_FORMAT"
   */
  virtual agora::media::ExternalVideoFrame::VIDEO_PIXEL_FORMAT getBufferType() = 0;
  /** Gets the capture type of the custom video source.
   *
   * Before you initialize the custom video source, the SDK triggers this callback to query the capture type of the video source.
   * You must specify the capture type in the return value and then pass it to the SDK. The SDK enables the corresponding video
   * processing algorithm according to the capture type after receiving the video frame.
   *
   * @return #VIDEO_CAPTURE_TYPE
   */
  virtual VIDEO_CAPTURE_TYPE getVideoCaptureType() = 0;
  /** Gets the content hint of the custom video source.
   *
   * If you specify the custom video source as a screen-sharing video, the SDK triggers this callback to query the
   * content hint of the video source before you initialize the video source. You must specify the content hint in the
   * return value and then pass it to the SDK. The SDK enables the corresponding video processing algorithm according
   * to the content hint after receiving the video frame.
   *
   * @return \ref agora::rtc::VideoContentHint "VideoContentHint"
   */
  virtual VideoContentHint getVideoContentHint() = 0;
};

#if (defined(__APPLE__) && TARGET_OS_MAC && !TARGET_OS_IPHONE)
/**
 * The target size of the thumbnail or icon. (macOS only)
 *
 * @since v3.5.2
 */
struct SIZE {
  /** The target width (px) of the thumbnail or icon. The default value is 0.
   */
  int width;
  /** The target height (px) of the thumbnail or icon. The default value is 0.
   */
  int height;

  SIZE() : width(0), height(0) {}
  SIZE(int w, int h) : width(w), height(h) {}
};
#endif
/**
 * The image content of the thumbnail or icon.
 *
 * @since v3.5.2
 *
 * @note The default image is in the RGBA format. If you need to use another format, you need to convert the image on
 * your own.
 */
struct ThumbImageBuffer {
  /**
   * The buffer of the thumbnail or icon.
   */
  const char* buffer;
  /**
   * The buffer length (bytes) of the thumbnail or icon.
   */
  unsigned int length;
  /**
   * The actual width (px) of the thumbnail or icon.
   */
  unsigned int width;
  /**
   * The actual height (px) of the thumbnail or icon.
   */
  unsigned int height;
  ThumbImageBuffer() : buffer(nullptr), length(0), width(0), height(0) {}
};
/**
 * The type of the shared target.
 *
 * @since v3.5.2
 */
enum ScreenCaptureSourceType {
  /**
   * -1: Unknown type.
   */
  ScreenCaptureSourceType_Unknown = -1,
  /**
   * 0: The shared target is a window.
   */
  ScreenCaptureSourceType_Window = 0,
  /**
   * 1: The shared target is a screen of a particular monitor.
   */
  ScreenCaptureSourceType_Screen = 1,
  /**
   * 2: Reserved parameter.
   */
  ScreenCaptureSourceType_Custom = 2,
};
/**
 * The information about the specified shareable window or screen.
 *
 * @since v3.5.2
 */
struct ScreenCaptureSourceInfo {
  /**
   * The type of the shared target. See \ref agora::rtc::ScreenCaptureSourceType "ScreenCaptureSourceType".
   */
  ScreenCaptureSourceType type;
  /**
   * The window ID for a window or the display ID for a screen.
   */
  view_t sourceId;
  /**
   * The name of the window or screen. UTF-8 encoding.
   */
  const char* sourceName;
  /**
   * The image content of the thumbnail. See ThumbImageBuffer.
   */
  ThumbImageBuffer thumbImage;
  /**
   * The image content of the icon. See ThumbImageBuffer.
   */
  ThumbImageBuffer iconImage;
  /**
   * The process to which the window belongs. UTF-8 encoding.
   */
  const char* processPath;
  /**
   * The title of the window. UTF-8 encoding.
   */
  const char* sourceTitle;
  /**
   * Determines whether the screen is the primary display:
   * - true: The screen is the primary display.
   * - false: The screen is not the primary display.
   */
  bool primaryMonitor;
  ScreenCaptureSourceInfo() : type(ScreenCaptureSourceType_Unknown), sourceId(nullptr), sourceName(nullptr), processPath(nullptr), sourceTitle(nullptr), primaryMonitor(false) {}
};
/**
 * The IScreenCaptureSourceList class.
 *
 * @since v3.5.2
 */
class IScreenCaptureSourceList {
 protected:
  virtual ~IScreenCaptureSourceList(){};

 public:
  /**
   * Gets the number of shareable windows and screens.
   *
   * @since v3.5.2
   *
   * @return The number of shareable windows and screens.
   */
  virtual unsigned int getCount() = 0;
  /**
   * Gets information about the specified shareable window or screen.
   *
   * @since v3.5.2
   *
   * After you get IScreenCaptureSourceList, you can pass in the index value of the specified shareable window or
   * screen to get information about that window or screen from ScreenCaptureSourceInfo.
   *
   * @param index The index of the specified shareable window or screen. The value range is [0,`getCount()`).
   *
   * @return ScreenCaptureSourceInfo
   */
  virtual ScreenCaptureSourceInfo getSourceInfo(unsigned int index) = 0;
  /**
   * Releases IScreenCaptureSourceList.
   *
   * @since v3.5.2
   *
   * After you get the list of shareable windows and screens, to avoid memory leaks, call `release` to release
   * `IScreenCaptureSourceList` instead of deleting `IScreenCaptureSourceList` directly.
   */
  virtual void release() = 0;
};

/** The SDK uses the IRtcEngineEventHandler interface class to send callbacks to the application. The application inherits the methods of this interface class to retrieve these callbacks.

 All methods in this interface class have default (empty) implementations. Therefore, the application can only inherit some required events. In the callbacks, avoid time-consuming tasks or calling blocking APIs, such as the SendMessage method. Otherwise, the SDK may not work properly.
 */
class IRtcEngineEventHandler {
 public:
  virtual ~IRtcEngineEventHandler() {}

  /** Reports a warning during SDK runtime.

   In most cases, the application can ignore the warning reported by the SDK because the SDK can usually fix the issue and resume running. For example, when losing connection with the server, the SDK may report #WARN_LOOKUP_CHANNEL_TIMEOUT and automatically try to reconnect.

   @param warn Warning code: #WARN_CODE_TYPE.
   @param msg Pointer to the warning message.
   */
  virtual void onWarning(int warn, const char* msg) {
    (void)warn;
    (void)msg;
  }

  /** Reports an error during SDK runtime.

   In most cases, the SDK cannot fix the issue and resume running. The SDK requires the application to take action or informs the user about the issue.

   For example, the SDK reports an #ERR_START_CALL error when failing to initialize a call. The application informs the user that the call initialization failed and invokes the \ref IRtcEngine::leaveChannel "leaveChannel" method to leave the channel.

   @param err Error code: #ERROR_CODE_TYPE.
   @param msg Pointer to the error message.
   */
  virtual void onError(int err, const char* msg) {
    (void)err;
    (void)msg;
  }

  /** Occurs when a user joins a channel.

   This callback notifies the application that a user joins a specified channel when the application calls the \ref IRtcEngine::joinChannel "joinChannel" method.

   The channel name assignment is based on @p channelName specified in the \ref IRtcEngine::joinChannel "joinChannel" method.

   If the @p uid is not specified in the *joinChannel* method, the server automatically assigns a @p uid.

   @param channel  Pointer to the channel name.
   @param  uid User ID of the user joining the channel.
   @param  elapsed Time elapsed (ms) from the user calling the \ref IRtcEngine::joinChannel "joinChannel" method until the SDK triggers this callback.
   */
  virtual void onJoinChannelSuccess(const char* channel, uid_t uid, int elapsed) {
    (void)channel;
    (void)uid;
    (void)elapsed;
  }

  /** Occurs when a user rejoins the channel after disconnection due to network problems.

  When a user loses connection with the server because of network problems, the SDK automatically tries to reconnect and triggers this callback upon reconnection.

   @param channel Pointer to the channel name.
   @param uid User ID of the user rejoining the channel.
   @param elapsed Time elapsed (ms) from starting to reconnect until the SDK triggers this callback.
   */
  virtual void onRejoinChannelSuccess(const char* channel, uid_t uid, int elapsed) {
    (void)channel;
    (void)uid;
    (void)elapsed;
  }

  /** Occurs when a user leaves the channel.

  This callback notifies the application that a user leaves the channel when the application calls the \ref IRtcEngine::leaveChannel "leaveChannel" method.

  The application gets information, such as the call duration and statistics.

   @param stats Pointer to the statistics of the call: RtcStats.
   */
  virtual void onLeaveChannel(const RtcStats& stats) { (void)stats; }

  /** Occurs when the user role switches successfully in the interactive live streaming.
   *
   * In the `LIVE_BROADCASTING` channel profile, when the local user successfully calls \ref IRtcEngine::setClientRole "setClientRole" to switch their user role after joining the channel, for example, from a host to an audience member or vice versa, the SDK triggers this callback to report the user role before and after the switch.
   *
   * @param oldRole Role that the user switches from: #CLIENT_ROLE_TYPE.
   * @param newRole Role that the user switches to: #CLIENT_ROLE_TYPE.
   */
  virtual void onClientRoleChanged(CLIENT_ROLE_TYPE oldRole, CLIENT_ROLE_TYPE newRole) {}
  /** Occurs when the user role switch fails in the interactive live streaming.
   *
   * @since v3.7.0
   *
   * In the `LIVE_BROADCASTING` channel profile, when the local user calls \ref IRtcEngine::setClientRole "setClientRole" to switch their user role after joining the channel but the switch fails, the SDK triggers this callback to report the reason for the failure and the current user role.
   *
   * @param reason The reason for the user role switch failure. See #CLIENT_ROLE_CHANGE_FAILED_REASON.
   * @param currentRole The current user role. See #CLIENT_ROLE_TYPE.
   */
  virtual void onClientRoleChangeFailed(CLIENT_ROLE_CHANGE_FAILED_REASON reason, CLIENT_ROLE_TYPE currentRole) {}
  /** Occurs when a remote user (`COMMUNICATION`)/ host (`LIVE_BROADCASTING`) joins the channel.

   - `COMMUNICATION` profile: This callback notifies the application that another user joins the channel. If other users are already in the channel, the SDK also reports to the application on the existing users.
   - `LIVE_BROADCASTING` profile: This callback notifies the application that the host joins the channel. If other hosts are already in the channel, the SDK also reports to the application on the existing hosts. We recommend limiting the number of hosts to 17.

   The SDK triggers this callback under one of the following circumstances:
   - A remote user/host joins the channel by calling the \ref agora::rtc::IRtcEngine::joinChannel "joinChannel" method.
   - A remote user switches the user role to the host by calling the \ref agora::rtc::IRtcEngine::setClientRole "setClientRole" method after joining the channel.
   - A remote user/host rejoins the channel after a network interruption.
   - The host injects an online media stream into the channel by calling the \ref agora::rtc::IRtcEngine::addInjectStreamUrl "addInjectStreamUrl" method.

   @note In the `LIVE_BROADCASTING` profile:
   - The host receives this callback when another host joins the channel.
   - The audience in the channel receives this callback when a new host joins the channel.
   - When a web application joins the channel, the SDK triggers this callback as long as the web application publishes streams.

   @param uid User ID of the user or host joining the channel.
   @param elapsed Time delay (ms) from the local user calling the \ref IRtcEngine::joinChannel "joinChannel" method until the SDK triggers this callback.
   */
  virtual void onUserJoined(uid_t uid, int elapsed) {
    (void)uid;
    (void)elapsed;
  }

  /** Occurs when a remote user (`COMMUNICATION`)/ host (`LIVE_BROADCASTING`) leaves the channel.

  Reasons why the user is offline:

  - Leave the channel: When the user/host leaves the channel, the user/host sends a goodbye message. When the message is received, the SDK assumes that the user/host leaves the channel.
  - Drop offline: When no data packet of the user or host is received for a certain period of time, the SDK assumes that the user/host drops offline. Unreliable network connections may lead to false detections, so we recommend using the Agora RTM SDK for more reliable offline detection.

   @param uid User ID of the user leaving the channel or going offline.
   @param reason Reason why the user is offline: #USER_OFFLINE_REASON_TYPE.
   */
  virtual void onUserOffline(uid_t uid, USER_OFFLINE_REASON_TYPE reason) {
    (void)uid;
    (void)reason;
  }
  /**
   * Reports the proxy connection state.
   *
   * @since v3.6.2
   *
   * You can use this callback to listen for the state of the SDK connecting to a proxy.
   * For example, when a user calls \ref IRtcEngine::setCloudProxy "setCloudProxy" and joins a channel successfully, the SDK triggers this callback to report the user ID, the proxy type connected, and the time elapsed from the user calling \ref IRtcEngine::joinChannel "joinChannel" until this callback is triggered.
   *
   * @param channel The channel name.
   * @param uid The user ID.
   * @param proxyType The proxy type connected. See #PROXY_TYPE.
   * @param localProxyIp Reserved for future use.
   * @param elapsed The time elapsed (ms) from the user calling `joinChannel` until this callback is triggered.
   *
   */
  virtual void onProxyConnected(const char* channel, uid_t uid, PROXY_TYPE proxyType, const char* localProxyIp, int elapsed) {
    (void)channel;
    (void)uid;
    (void)proxyType;
    (void)localProxyIp;
    (void)elapsed;
  }

  /** Reports the last mile network quality of the local user once every two seconds before the user joins the channel.

   Last mile refers to the connection between the local device and Agora's edge server. After the application calls the \ref IRtcEngine::enableLastmileTest "enableLastmileTest" method, this callback reports once every two seconds the uplink and downlink last mile network conditions of the local user before the user joins the channel.

   @param quality The last mile network quality: #QUALITY_TYPE.
   */
  virtual void onLastmileQuality(int quality) { (void)quality; }

  /** Reports the last-mile network probe result.

  The SDK triggers this callback within 30 seconds after the app calls the \ref agora::rtc::IRtcEngine::startLastmileProbeTest "startLastmileProbeTest" method.

  @param result The uplink and downlink last-mile network probe test result. See LastmileProbeResult.
  */
  virtual void onLastmileProbeResult(const LastmileProbeResult& result) { (void)result; }

  /** **DEPRECATED** Occurs when the connection between the SDK and the server is interrupted.

   Deprecated as of v2.3.2. Replaced by the \ref agora::rtc::IRtcEngineEventHandler::onConnectionStateChanged "onConnectionStateChanged(CONNECTION_STATE_RECONNECTING, CONNECTION_CHANGED_INTERRUPTED)" callback.

   The SDK triggers this callback when it loses connection with the server for more than four seconds after the connection is established.

   After triggering this callback, the SDK tries reconnecting to the server. You can use this callback to implement pop-up reminders.

   This callback is different from \ref agora::rtc::IRtcEngineEventHandler::onConnectionLost "onConnectionLost":
   - The SDK triggers the \ref agora::rtc::IRtcEngineEventHandler::onConnectionInterrupted "onConnectionInterrupted" callback when it loses connection with the server for more than four seconds after it successfully joins the channel.
   - The SDK triggers the \ref agora::rtc::IRtcEngineEventHandler::onConnectionLost "onConnectionLost" callback when it loses connection with the server for more than 10 seconds, whether or not it joins the channel.

   If the SDK fails to rejoin the channel 20 minutes after being disconnected from Agora's edge server, the SDK stops rejoining the channel.

  */
  virtual void onConnectionInterrupted() {}

  /** Occurs when the SDK cannot reconnect to Agora's edge server 10 seconds after its connection to the server is interrupted.

  The SDK triggers this callback when it cannot connect to the server 10 seconds after calling the \ref IRtcEngine::joinChannel "joinChannel" method, whether or not it is in the channel.

  This callback is different from \ref agora::rtc::IRtcEngineEventHandler::onConnectionInterrupted "onConnectionInterrupted":

  - The SDK triggers the \ref agora::rtc::IRtcEngineEventHandler::onConnectionInterrupted "onConnectionInterrupted" callback when it loses connection with the server for more than four seconds after it successfully joins the channel.
  - The SDK triggers the \ref agora::rtc::IRtcEngineEventHandler::onConnectionLost "onConnectionLost" callback when it loses connection with the server for more than 10 seconds, whether or not it joins the channel.

  If the SDK fails to rejoin the channel 20 minutes after being disconnected from Agora's edge server, the SDK stops rejoining the channel.

   */
  virtual void onConnectionLost() {}

  /** **DEPRECATED** Deprecated as of v2.3.2. Replaced by the \ref agora::rtc::IRtcEngineEventHandler::onConnectionStateChanged "onConnectionStateChanged(CONNECTION_STATE_FAILED, CONNECTION_CHANGED_BANNED_BY_SERVER)" callback.

  Occurs when your connection is banned by the Agora Server.
   */
  virtual void onConnectionBanned() {}

  /** Occurs when a method is executed by the SDK.

   @param err The error code (#ERROR_CODE_TYPE) returned by the SDK when a method call fails. If the SDK returns 0, then the method call is successful.
   @param api Pointer to the method executed by the SDK.
   @param result Pointer to the result of the method call.
   */
  virtual void onApiCallExecuted(int err, const char* api, const char* result) {
    (void)err;
    (void)api;
    (void)result;
  }

  /** Occurs when the token expires.

   After a token is specified by calling the \ref IRtcEngine::joinChannel "joinChannel" method, if the SDK losses
   connection with the Agora server due to network issues, the token may expire after a certain period of time and a
   new token may be required to reconnect to the server.

   Once you receive this callback, generate a new token on your app server, and call
   \ref agora::rtc::IRtcEngine::renewToken "renewToken" to pass the new token to the SDK.
   */
  virtual void onRequestToken() {}

  /** Occurs when the token expires in 30 seconds.

   The user becomes offline if the token used in the \ref IRtcEngine::joinChannel "joinChannel" method expires. The SDK triggers this callback 30 seconds before the token expires to remind the application to get a new token. Upon receiving this callback, generate a new token on the server and call the \ref IRtcEngine::renewToken "renewToken" method to pass the new token to the SDK.

   @param token The token that expires in 30 seconds.
   */
  virtual void onTokenPrivilegeWillExpire(const char* token) { (void)token; }

  /** **DEPRECATED** Reports the statistics of the audio stream from each remote user/host.

  Deprecated as of v2.3.2. Use the \ref agora::rtc::IRtcEngineEventHandler::onRemoteAudioStats "onRemoteAudioStats" callback instead.

   The SDK triggers this callback once every two seconds to report the audio quality of each remote user/host sending an audio stream. If a channel has multiple users/hosts sending audio streams, the SDK triggers this callback as many times.

   @param uid User ID of the speaker.
   @param quality Audio quality of the user: #QUALITY_TYPE.
   @param delay Time delay (ms) of sending the audio packet from the sender to the receiver, including the time delay of audio sampling pre-processing, transmission, and the jitter buffer.
   @param lost Packet loss rate (%) of the audio packet sent from the sender to the receiver.
   */
  virtual void onAudioQuality(uid_t uid, int quality, unsigned short delay, unsigned short lost) {
    (void)uid;
    (void)quality;
    (void)delay;
    (void)lost;
  }

  /** Reports the statistics of the current call.

   The SDK triggers this callback once every two seconds after the user joins the channel.

   @param stats Statistics of the IRtcEngine: RtcStats.
   */
  virtual void onRtcStats(const RtcStats& stats) { (void)stats; }

  /** Reports the last mile network quality of each user in the channel once every two seconds.
   *
   * Last mile refers to the connection between the local device and Agora's edge server. This callback
   * reports once every two seconds the last mile network conditions of each user in the channel. If a channel includes
   * multiple users, the SDK triggers this callback as many times.
   *
   * @note `txQuality` is `UNKNOWN` when the user is not sending a stream; `rxQuality` is `UNKNOWN` when the user is not receiving a stream.
   *
   * @param uid User ID. The network quality of the user with this @p uid is reported. If @p uid is 0, the local network quality is reported.
   * @param txQuality Uplink transmission quality rating of the user in terms of the transmission bitrate, packet loss rate, average RTT (Round-Trip Time), and jitter of the uplink network. @p txQuality is a quality rating helping you understand how well the current uplink network conditions can support the selected VideoEncoderConfiguration. For example, a 1000 Kbps uplink network may be adequate for video frames with a resolution of 640 * 480 and a frame rate of 15 fps in the `LIVE_BROADCASTING` profile, but may be inadequate for resolutions higher than 1280 * 720. See #QUALITY_TYPE.
   * @param rxQuality Downlink network quality rating of the user in terms of the packet loss rate, average RTT, and jitter of the downlink network. See #QUALITY_TYPE.
   */
  virtual void onNetworkQuality(uid_t uid, int txQuality, int rxQuality) {
    (void)uid;
    (void)txQuality;
    (void)rxQuality;
  }

  /** Reports the statistics of the local video stream.
   *
   * The SDK triggers this callback once every two seconds for each
   * user/host. If there are multiple users/hosts in the channel, the SDK
   * triggers this callback as many times.
   *
   * @note
   * If you have called the
   * \ref agora::rtc::IRtcEngine::enableDualStreamMode "enableDualStreamMode"
   * method, the \ref onLocalVideoStats() "onLocalVideoStats" callback
   * reports the statistics of the high-video
   * stream (high bitrate, and high-resolution video stream).
   *
   * @param stats Statistics of the local video stream. See LocalVideoStats.
   */
  virtual void onLocalVideoStats(const LocalVideoStats& stats) { (void)stats; }

  /** Reports the statistics of the video stream from each remote user/host.
   *
   * The SDK triggers this callback once every two seconds for each remote
   * user/host. If a channel includes multiple remote users, the SDK
   * triggers this callback as many times.
   *
   * @param stats Statistics of the remote video stream. See
   * RemoteVideoStats.
   */
  virtual void onRemoteVideoStats(const RemoteVideoStats& stats) { (void)stats; }

  /** Reports the statistics of the local audio stream.
   *
   * The SDK triggers this callback once every two seconds.
   *
   * @param stats The statistics of the local audio stream.
   * See LocalAudioStats.
   */
  virtual void onLocalAudioStats(const LocalAudioStats& stats) { (void)stats; }

  /** Reports the statistics of the audio stream from each remote user/host.

   This callback replaces the \ref agora::rtc::IRtcEngineEventHandler::onAudioQuality "onAudioQuality" callback.

   The SDK triggers this callback once every two seconds for each remote user/host. If a channel includes multiple remote users, the SDK triggers this callback as many times.

   @param stats Pointer to the statistics of the received remote audio streams. See RemoteAudioStats.
   */
  virtual void onRemoteAudioStats(const RemoteAudioStats& stats) { (void)stats; }

  /** Occurs when the local audio state changes.
   * This callback indicates the state change of the local audio stream,
   * including the state of the audio capturing and encoding, and allows
   * you to troubleshoot issues when exceptions occur.
   *
   * @note
   * When the state is #LOCAL_AUDIO_STREAM_STATE_FAILED (3), see the `error`
   * parameter for details.
   *
   * @param state State of the local audio. See #LOCAL_AUDIO_STREAM_STATE.
   * @param error The error information of the local audio.
   * See #LOCAL_AUDIO_STREAM_ERROR.
   */
  virtual void onLocalAudioStateChanged(LOCAL_AUDIO_STREAM_STATE state, LOCAL_AUDIO_STREAM_ERROR error) {
    (void)state;
    (void)error;
  }

  /** Occurs when the remote audio state changes.
   *
   * This callback indicates the state change of the remote audio stream.
   *
   * @note This callback can be inaccurate when the number of users (in the `COMMUNICATION` profile)
   * or hosts (in the `LIVE_BROADCASTING` profile) in a channel exceeds 17.
   *
   * @param uid ID of the remote user whose audio state changes.
   * @param state State of the remote audio. See #REMOTE_AUDIO_STATE.
   * @param reason The reason of the remote audio state change. See #REMOTE_AUDIO_STATE_REASON.
   * @param elapsed Time elapsed (ms) from the local user calling the
   * \ref IRtcEngine::joinChannel "joinChannel" method until the SDK
   * triggers this callback.
   */
  virtual void onRemoteAudioStateChanged(uid_t uid, REMOTE_AUDIO_STATE state, REMOTE_AUDIO_STATE_REASON reason, int elapsed) {
    (void)uid;
    (void)state;
    (void)reason;
    (void)elapsed;
  }

  /** Occurs when the audio publishing state changes.
   *
   * @since v3.1.0
   *
   * This callback indicates the publishing state change of the local audio stream.
   *
   * @param channel The channel name.
   * @param oldState The previous publishing state. For details, see #STREAM_PUBLISH_STATE.
   * @param newState The current publishing state. For details, see #STREAM_PUBLISH_STATE.
   * @param elapseSinceLastState The time elapsed (ms) from the previous state to the current state.
   */
  virtual void onAudioPublishStateChanged(const char* channel, STREAM_PUBLISH_STATE oldState, STREAM_PUBLISH_STATE newState, int elapseSinceLastState) {
    (void)channel;
    (void)oldState;
    (void)newState;
    (void)elapseSinceLastState;
  }

  /** Occurs when the video publishing state changes.
   *
   * @since v3.1.0
   *
   * This callback indicates the publishing state change of the local video stream.
   *
   * @param channel The channel name.
   * @param oldState The previous publishing state. For details, see #STREAM_PUBLISH_STATE.
   * @param newState The current publishing state. For details, see #STREAM_PUBLISH_STATE.
   * @param elapseSinceLastState The time elapsed (ms) from the previous state to the current state.
   */
  virtual void onVideoPublishStateChanged(const char* channel, STREAM_PUBLISH_STATE oldState, STREAM_PUBLISH_STATE newState, int elapseSinceLastState) {
    (void)channel;
    (void)oldState;
    (void)newState;
    (void)elapseSinceLastState;
  }

  /** Occurs when the audio subscribing state changes.
   *
   * @since v3.1.0
   *
   * This callback indicates the subscribing state change of a remote audio stream.
   *
   * @param channel The channel name.
   * @param uid The ID of the remote user.
   * @param oldState The previous subscribing state. For details, see #STREAM_SUBSCRIBE_STATE.
   * @param newState The current subscribing state. For details, see #STREAM_SUBSCRIBE_STATE.
   * @param elapseSinceLastState The time elapsed (ms) from the previous state to the current state.
   */
  virtual void onAudioSubscribeStateChanged(const char* channel, uid_t uid, STREAM_SUBSCRIBE_STATE oldState, STREAM_SUBSCRIBE_STATE newState, int elapseSinceLastState) {
    (void)channel;
    (void)uid;
    (void)oldState;
    (void)newState;
    (void)elapseSinceLastState;
  }

  /** Occurs when the audio subscribing state changes.
   *
   * @since v3.1.0
   *
   * This callback indicates the subscribing state change of a remote video stream.
   *
   * @param channel The channel name.
   * @param uid The ID of the remote user.
   * @param oldState The previous subscribing state. For details, see #STREAM_SUBSCRIBE_STATE.
   * @param newState The current subscribing state. For details, see #STREAM_SUBSCRIBE_STATE.
   * @param elapseSinceLastState The time elapsed (ms) from the previous state to the current state.
   */
  virtual void onVideoSubscribeStateChanged(const char* channel, uid_t uid, STREAM_SUBSCRIBE_STATE oldState, STREAM_SUBSCRIBE_STATE newState, int elapseSinceLastState) {
    (void)channel;
    (void)uid;
    (void)oldState;
    (void)newState;
    (void)elapseSinceLastState;
  }

  /** Reports the volume information of users.
   *
   * By default, this callback is disabled. You can enable it by calling \ref IRtcEngine::enableAudioVolumeIndication(int, int, bool) "enableAudioVolumeIndication".
   * Once this callback is enabled and users send streams in the channel, the SDK triggers the `onAudioVolumeIndication` callback
   * at the time interval set in `enableAudioVolumeIndication`.
   *
   * The SDK triggers two independent `onAudioVolumeIndication` callbacks simultaneously, which separately report the
   * volume information of the local user who sends a stream and the remote users (up to three) whose instantaneous
   * volumes are the highest.
   *
   * @note After you enable this callback, calling \ref agora::rtc::IRtcEngine::muteLocalAudioStream "muteLocalAudioStream"
   * affects the SDK's behavior as follows:
   * - If the local user calls `muteLocalAudioStream`, the SDK stops triggering the local user's callback.
   * - 20 seconds after a remote user whose volume is one of the three highest calls `muteLocalAudioStream`, the
   * remote users' callback excludes this remote user's information; 20 seconds after all remote users call
   * `muteLocalAudioStream`, the SDK stops triggering the remote users' callback.
   *
   * @param speakers The volume information of users. See AudioVolumeInfo.
   *
   * An empty speakers array in the callback indicates that no remote user is in the channel or sending a stream at the moment.
   * @param speakerNumber Total number of users.
   * - In the local user's callback, when the local user sends a stream, `speakerNumber = 1`.
   * - In the remote users' callback, the value ranges between 0 and 3. If the number of remote users who send
   * streams is greater than or equal to three, `speakerNumber = 3`.
   * @param totalVolume Total volume after audio mixing. The value ranges between 0 (lowest volume) and 255 (highest volume).
   * - In the local user's callback, totalVolume is the volume of the local user who sends a stream.
   * - In the remote users' callback, totalVolume is the sum of the volume of all remote users (up to three) whose
   * instantaneous volumes are the highest.
   *
   * If the user calls \ref IRtcEngine::startAudioMixing(const char*,bool,bool,int,int) "startAudioMixing", `totalVolume` is the sum of
   * the voice volume and audio-mixing volume.
   */
  virtual void onAudioVolumeIndication(const AudioVolumeInfo* speakers, unsigned int speakerNumber, int totalVolume) {
    (void)speakers;
    (void)speakerNumber;
    (void)totalVolume;
  }

  /**
   * Reports the voice pitch of the local user.
   *
   * @since v3.7.0
   *
   * After the local audio capture is enabled, and you call \ref IRtcEngine::enableLocalVoicePitchCallback "enableLocalVoicePitchCallback" , the SDK triggers this callback at the time interval set in `enableLocalVoicePitchCallback`.
   *
   * @note After this callback is enabled, if the user disables the local audio capture, for example, by calling \ref IRtcEngine::enableLocalAudio "enableLocalAudio(false)", the SDK immediately stops sending the `onLocalVoicePitchInHz` callback.
   *
   * @param pitchInHz The voice pitch (Hz) of the local user.
   */
  virtual void onLocalVoicePitchInHz(int pitchInHz) { (void)pitchInHz; }

  /**
   * Reports the result of an audio device test.
   * @since v3.6.2
   *
   * After successfully calling \ref IAudioDeviceManager::startRecordingDeviceTest "startRecordingDeviceTest", \ref IAudioDeviceManager::startPlaybackDeviceTest "startPlaybackDeviceTest", or \ref IAudioDeviceManager::startAudioDeviceLoopbackTest "startAudioDeviceLoopbackTest" to start an audio device test,
   * the SDK triggers the `onAudioDeviceTestVolumeIndication` callback at the set time interval to report the volume information of the audio device tested.
   *
   * @param volumeType The volume type. See \ref agora::rtc::AudioDeviceTestVolumeType "AudioDeviceTestVolumeType".
   * @param volume The volume, in the range of [0,255].
   */
  virtual void onAudioDeviceTestVolumeIndication(AudioDeviceTestVolumeType volumeType, int volume) {
    (void)volumeType;
    (void)volume;
  }

  /** Occurs when the most active remote speaker is detected.

   After a successful call of \ref IRtcEngine::enableAudioVolumeIndication(int, int, bool) "enableAudioVolumeIndication",
   the SDK continuously detects which remote user has the loudest volume. During the current period, the remote user,
   who is detected as the loudest for the most times, is the most active user.

   When the number of user is no less than two and an active speaker exists, the SDK triggers this callback and reports the `uid` of the most active speaker.
   - If the most active speaker is always the same user, the SDK triggers this callback only once.
   - If the most active speaker changes to another user, the SDK triggers this callback again and reports the `uid` of the new active speaker.

   @param uid The user ID of the most active remote speaker.
  */
  virtual void onActiveSpeaker(uid_t uid) { (void)uid; }

  /** **DEPRECATED** Occurs when the video stops playing.

   The application can use this callback to change the configuration of the view (for example, displaying other pictures in the view) after the video stops playing.

   Deprecated as of v2.4.1. Use LOCAL_VIDEO_STREAM_STATE_STOPPED(0) in the \ref agora::rtc::IRtcEngineEventHandler::onLocalVideoStateChanged "onLocalVideoStateChanged" callback instead.
   */
  virtual void onVideoStopped() {}

  /** Occurs when the first local video frame is displayed/rendered on the local video view.

  @param width Width (px) of the first local video frame.
  @param height Height (px) of the first local video frame.
  @param elapsed Time elapsed (ms) from the local user calling the \ref IRtcEngine::joinChannel "joinChannel" method until the SDK triggers this callback.
  If you call the \ref IRtcEngine::startPreview "startPreview" method  before calling the *joinChannel* method, then @p elapsed is the time elapsed from calling the *startPreview* method until the SDK triggers this callback.
  */
  virtual void onFirstLocalVideoFrame(int width, int height, int elapsed) {
    (void)width;
    (void)height;
    (void)elapsed;
  }

  /** Occurs when the first video frame is published.
   *
   * @since v3.1.0
   *
   * The SDK triggers this callback under one of the following circumstances:
   * - The local client enables the video module and calls \ref IRtcEngine::joinChannel "joinChannel" successfully.
   * - The local client calls \ref IRtcEngine::muteLocalVideoStream "muteLocalVideoStream(true)" and \ref IRtcEngine::muteLocalVideoStream "muteLocalVideoStream(false)" in sequence.
   * - The local client calls \ref IRtcEngine::disableVideo "disableVideo" and \ref IRtcEngine::enableVideo "enableVideo" in sequence.
   * - The local client calls \ref agora::media::IMediaEngine::pushVideoFrame "pushVideoFrame" to successfully push the video frame to the SDK.
   *
   * @param elapsed The time elapsed (ms) from the local client calling \ref IRtcEngine::joinChannel "joinChannel" until the SDK triggers this callback.
   */
  virtual void onFirstLocalVideoFramePublished(int elapsed) { (void)elapsed; }

  /** Occurs when the first remote video frame is received and decoded.
   *
   * This callback is triggered in either of the following scenarios:
   *
   * - The remote user joins the channel and sends the video stream.
   * - The remote user stops sending the video stream and re-sends it after
   * 15 seconds. Reasons for such an interruption include:
   *  - The remote user leaves the channel.
   *  - The remote user drops offline.
   *  - The remote user calls the
   * \ref agora::rtc::IRtcEngine::muteLocalVideoStream "muteLocalVideoStream"
   *  method to stop sending the video stream.
   *  - The remote user calls the
   * \ref agora::rtc::IRtcEngine::disableVideo "disableVideo" method to
   * disable video.
   *
   * The application can configure the user view settings in this callback.
   *
   * @param uid User ID of the remote user sending the video stream.
   * @param width Width (px) of the video stream.
   * @param height Height (px) of the video stream.
   * @param elapsed Time elapsed (ms) from the local user calling the
   * \ref IRtcEngine::joinChannel "joinChannel" method until the SDK
   * triggers this callback.
   */
  virtual void onFirstRemoteVideoDecoded(uid_t uid, int width, int height, int elapsed) AGORA_DEPRECATED_ATTRIBUTE {
    (void)uid;
    (void)width;
    (void)height;
    (void)elapsed;
  }

  /** Occurs when the first remote video frame is rendered.
   *
   * The SDK triggers this callback when the first frame of the remote video is displayed in the user's video window. The application can get the time elapsed from a user joining the channel until the first video frame is displayed.
   *
   * @param uid User ID of the remote user sending the video stream.
   * @param width Width (px) of the video frame.
   * @param height Height (px) of the video stream.
   * @param elapsed Time elapsed (ms) from the local user calling the \ref IRtcEngine::joinChannel "joinChannel" method until the SDK triggers this callback.
   */
  virtual void onFirstRemoteVideoFrame(uid_t uid, int width, int height, int elapsed) {
    (void)uid;
    (void)width;
    (void)height;
    (void)elapsed;
  }

  /** Occurs when a remote user's audio stream playback pauses/resumes.
   *
   * The SDK triggers this callback when the remote user stops or resumes sending the audio stream by calling the \ref agora::rtc::IRtcEngine::muteLocalAudioStream "muteLocalAudioStream" method.
   *
   * @note This callback can be inaccurate when the number of users (in the `COMMUNICATION` profile)
   * or hosts (in the `LIVE_BROADCASTING` profile) in a channel exceeds 17.
   *
   * @param uid User ID of the remote user.
   * @param muted Whether the remote user's audio stream is muted/unmuted:
   * - true: Muted.
   * - false: Unmuted.
   */
  virtual void onUserMuteAudio(uid_t uid, bool muted) {
    (void)uid;
    (void)muted;
  }

  /**
   * Occurs when a remote user stops or resumes publishing the video stream.
   *
   * When a remote user calls \ref IRtcEngine::muteLocalVideoStream "muteLocalVideoStream" to
   * stop or resume publishing the video stream, the SDK triggers this callback to report the
   * state of the remote user's publishing stream to the local user.
   *
   * @note This callback can be inaccurate when the number of users
   * (in the `COMMUNICATION` profile) or hosts (in the `LIVE_BROADCASTING` profile) in a
   * channel exceeds 17.
   *
   * @param uid The user ID of the remote user.
   * @param muted Whether the remote user stops publishing the video stream:
   * - true: Stop publishing the video stream.
   * - false: Publish the video stream.
   */
  virtual void onUserMuteVideo(uid_t uid, bool muted) {
    (void)uid;
    (void)muted;
  }

  /** Occurs when a specific remote user enables/disables the video
   * module.
   *
   * Once the video module is disabled, the remote user can only use a
   * voice call. The remote user cannot send or receive any video from
   * other users.
   *
   * The SDK triggers this callback when the remote user enables or disables
   * the video module by calling the
   * \ref agora::rtc::IRtcEngine::enableVideo "enableVideo" or
   * \ref agora::rtc::IRtcEngine::disableVideo "disableVideo" method.
   *
   * @note This callback returns invalid when the number of users in a
   * channel exceeds 20.
   *
   * @param uid User ID of the remote user.
   * @param enabled Whether the remote user enables/disables the video
   * module:
   * - true: Enable. The remote user can enter a video session.
   * - false: Disable. The remote user can only enter a voice session, and
   * cannot send or receive any video stream.
   */
  virtual void onUserEnableVideo(uid_t uid, bool enabled) {
    (void)uid;
    (void)enabled;
  }

  /** Occurs when the audio device state changes (for macOS and Windows only).
   *
   * This callback notifies the application that the system's audio device state is changed. For example, a headset is unplugged from the device.
   *
   * @param deviceId Pointer to the device ID.
   * @param deviceType Device type: #MEDIA_DEVICE_TYPE.
   * @param deviceState The state of the device:
   * - On macOS:
   *  - 0: The device is ready for use.
   *  - 8: The device is not connected.
   * - On Windows: #MEDIA_DEVICE_STATE_TYPE.
   */
  virtual void onAudioDeviceStateChanged(const char* deviceId, int deviceType, int deviceState) {
    (void)deviceId;
    (void)deviceType;
    (void)deviceState;
  }

  /** Occurs when the volume of the playback device, microphone, or application changes.

   @param deviceType Device type: #MEDIA_DEVICE_TYPE.
   @param volume Volume of the device. The value ranges between 0 and 255.
   @param muted
   - true: The audio device is muted.
   - false: The audio device is not muted.
   */
  virtual void onAudioDeviceVolumeChanged(MEDIA_DEVICE_TYPE deviceType, int volume, bool muted) {
    (void)deviceType;
    (void)volume;
    (void)muted;
  }

  /** **DEPRECATED** Occurs when the camera turns on and is ready to capture the video.

   If the camera fails to turn on, fix the error reported in the \ref IRtcEngineEventHandler::onError "onError" callback.

   Deprecated as of v2.4.1. Use #LOCAL_VIDEO_STREAM_STATE_CAPTURING (1) in the \ref agora::rtc::IRtcEngineEventHandler::onLocalVideoStateChanged "onLocalVideoStateChanged" callback instead.
   */
  virtual void onCameraReady() {}

  /** Occurs when the camera focus area changes.

   The SDK triggers this callback when the local user changes the camera focus position by calling the setCameraFocusPositionInPreview method.

   @note This callback is for Android and iOS only.

   @param x x coordinate of the changed camera focus area.
   @param y y coordinate of the changed camera focus area.
   @param width Width of the changed camera focus area.
   @param height Height of the changed camera focus area.
   */
  virtual void onCameraFocusAreaChanged(int x, int y, int width, int height) {
    (void)x;
    (void)y;
    (void)width;
    (void)height;
  }
#if defined(__ANDROID__) || (defined(__APPLE__) && TARGET_OS_IOS)
  /**
   * Reports the face detection result of the local user. Applies to Android and iOS only.
   * @since v3.0.1
   *
   * Once you enable face detection by calling \ref IRtcEngine::enableFaceDetection "enableFaceDetection"(true), you can get the following information on the local user in real-time:
   * - The width and height of the local video.
   * - The position of the human face in the local view.
   * - The distance between the human face and the device screen. This value is based on the fitting calculation of the local video size and the position of the human face.
   *
   * @note
   * - If the SDK does not detect a face, it reduces the frequency of this callback to reduce power consumption on the local device.
   * - The SDK stops triggering this callback when a human face is in close proximity to the screen.
   * - On Android, the `distance` value reported in this callback may be slightly different from the actual distance. Therefore, Agora does not recommend using it for
   * accurate calculation.
   * @param imageWidth The width (px) of the local video.
   * @param imageHeight The height (px) of the local video.
   * @param vecRectangle The position and size of the human face on the local video:
   * - `x`: The x coordinate (px) of the human face in the local view. Taking the top left corner of the view as the origin,
   * the x coordinate represents the relative lateral displacement of the top left corner of the human face to the origin.
   * - `y`: The y coordinate (px) of the human face in the local view. Taking the top left corner of the view as the origin,
   * the y coordinate represents the relative longitudinal displacement of the top left corner of the human face to the origin.
   * - `width`: The width (px) of the human face in the captured video.
   * - `height`: The height (px) of the human face in the captured video.
   * @param vecDistance The distance (cm) between the human face and the screen.
   * @param numFaces The number of faces detected. If the value is 0, it means that no human face is detected.
   */
  virtual void onFacePositionChanged(int imageWidth, int imageHeight, Rectangle* vecRectangle, int* vecDistance, int numFaces) {
    (void)imageWidth;
    (void)imageHeight;
    (void)vecRectangle;
    (void)vecDistance;
    (void)numFaces;
  }
#endif
  /** Occurs when the camera exposure area changes.

  The SDK triggers this callback when the local user changes the camera exposure position by calling the setCameraExposurePosition method.

   @note This callback is for Android and iOS only.

   @param x x coordinate of the changed camera exposure area.
   @param y y coordinate of the changed camera exposure area.
   @param width Width of the changed camera exposure area.
   @param height Height of the changed camera exposure area.
   */
  virtual void onCameraExposureAreaChanged(int x, int y, int width, int height) {
    (void)x;
    (void)y;
    (void)width;
    (void)height;
  }

  /** Occurs when the audio mixing file playback finishes.

   You can start an audio mixing file playback by calling the \ref IRtcEngine::startAudioMixing(const char*,bool,bool,int,int) "startAudioMixing" method. The SDK triggers this callback when the audio mixing file playback finishes.

   If the *startAudioMixing* method call fails, an error code returns in the \ref IRtcEngineEventHandler::onError "onError" callback.

   */
  virtual void onAudioMixingFinished() {}

  /** Occurs when the state of the local user's music file changes.
   *
   * @since v3.4.0
   *
   * When the playback state of the local user's music file changes, the SDK triggers this callback and
   * reports the current playback state and the reason for the change.
   *
   * @param state The current music file playback state. See #AUDIO_MIXING_STATE_TYPE.
   * @param reason The reason for the change of the music file playback state. See #AUDIO_MIXING_REASON_TYPE.
   */
  virtual void onAudioMixingStateChanged(AUDIO_MIXING_STATE_TYPE state, AUDIO_MIXING_REASON_TYPE reason) {}
  /** Occurs when a remote user starts audio mixing.

   When a remote user calls \ref IRtcEngine::startAudioMixing(const char*,bool,bool,int,int) "startAudioMixing" to play the background music, the SDK reports this callback.
   */
  virtual void onRemoteAudioMixingBegin() {}
  /** Occurs when a remote user finishes audio mixing.
   */
  virtual void onRemoteAudioMixingEnd() {}

  /**
   * Reports the information of an audio file.
   *
   * @since v3.5.1
   *
   * After successfully calling \ref IRtcEngine::getAudioFileInfo "getAudioFileInfo", the SDK triggers this
   * callback to report the information of the audio file, such as the file path and duration.
   *
   * @param info The information of an audio file. See AudioFileInfo.
   * @param error The information acquisition state. See #AUDIO_FILE_INFO_ERROR.
   */
  virtual void onRequestAudioFileInfo(const AudioFileInfo& info, AUDIO_FILE_INFO_ERROR error) {}

  /** Occurs when the local audio effect playback finishes.

   The SDK triggers this callback when the local audio effect file playback finishes.

   @param soundId ID of the local audio effect. Each local audio effect has a unique ID.
   */
  virtual void onAudioEffectFinished(int soundId) {}
  /// @cond nodoc
  /** Occurs when AirPlay is connected.
   */
  virtual void onAirPlayConnected() {}
  /// @endcond

  /**
   Occurs when the SDK decodes the first remote audio frame for playback.

   @deprecated v3.0.0

   This callback is deprecated. Use `onRemoteAudioStateChanged` instead.

   This callback is triggered in either of the following scenarios:

   - The remote user joins the channel and sends the audio stream.
   - The remote user stops sending the audio stream and re-sends it after 15 seconds. Reasons for such an interruption include:
       - The remote user leaves channel.
       - The remote user drops offline.
       - The remote user calls the \ref agora::rtc::IRtcEngine::muteLocalAudioStream "muteLocalAudioStream" method to stop sending the local audio stream.
       - The remote user calls the \ref agora::rtc::IRtcEngine::disableAudio "disableAudio" method to disable audio.

   @param uid User ID of the remote user sending the audio stream.
   @param elapsed Time elapsed (ms) from the local user calling the \ref IRtcEngine::joinChannel "joinChannel" method until the SDK triggers this callback.
   */
  virtual void onFirstRemoteAudioDecoded(uid_t uid, int elapsed) AGORA_DEPRECATED_ATTRIBUTE {
    (void)uid;
    (void)elapsed;
  }

  /** Occurs when the video device state changes (for macOS and Windows only).
   *
   * @note On a Windows device with an external camera for video capturing, the video disables once the external camera is unplugged.
   *
   * @param deviceId Pointer to the device ID of the video device that changes state.
   * @param deviceType Device type: #MEDIA_DEVICE_TYPE.
   * @param deviceState The state of the device:
   * - On macOS:
   *  - 0: The device is ready for use.
   *  - 8: The device is not connected.
   * - On Windows: #MEDIA_DEVICE_STATE_TYPE.
   */
  virtual void onVideoDeviceStateChanged(const char* deviceId, int deviceType, int deviceState) {
    (void)deviceId;
    (void)deviceType;
    (void)deviceState;
  }

  /** Occurs when the local video stream state changes.
   *
   * This callback indicates the state of the local video stream, including camera capturing and video encoding, and allows you to troubleshoot issues when exceptions occur.
   *
   * The SDK triggers the `onLocalVideoStateChanged(LOCAL_VIDEO_STREAM_STATE_FAILED, LOCAL_VIDEO_STREAM_ERROR_CAPTURE_FAILURE)` callback in the following situations:
   * - The application exits to the background, and the system recycles the camera.
   * - The camera starts normally, but the captured video is not output for four seconds.
   *
   * When the camera outputs the captured video frames, if all the video frames are the same for 15 consecutive frames, the SDK triggers the
   * `onLocalVideoStateChanged(LOCAL_VIDEO_STREAM_STATE_CAPTURING, LOCAL_VIDEO_STREAM_ERROR_CAPTURE_FAILURE)` callback. Note that the
   * video frame duplication detection is only available for video frames with a resolution greater than 200 × 200, a frame rate greater than or equal to 10 fps,
   * and a bitrate less than 20 Kbps.
   *
   * @note For some device models, the SDK will not trigger this callback when the state of the local video changes while the local video capturing device is in use, so you have to make your own timeout judgment.
   *
   * @param localVideoState State type #LOCAL_VIDEO_STREAM_STATE.
   * @param error The detailed error information: #LOCAL_VIDEO_STREAM_ERROR.
   */
  virtual void onLocalVideoStateChanged(LOCAL_VIDEO_STREAM_STATE localVideoState, LOCAL_VIDEO_STREAM_ERROR error) {
    (void)localVideoState;
    (void)error;
  }

  /** Occurs when the video size or rotation of a specified user changes.

   @param uid User ID of the remote user or local user (0) whose video size or rotation changes.
   @param width New width (pixels) of the video.
   @param height New height (pixels) of the video.
   @param rotation New rotation of the video [0 to 360).
   */
  virtual void onVideoSizeChanged(uid_t uid, int width, int height, int rotation) {
    (void)uid;
    (void)width;
    (void)height;
    (void)rotation;
  }
  /** Occurs when the remote video state changes.
   *
   * @note This callback can be inaccurate when the number of users (in the `COMMUNICATION` profile)
   * or hosts (in the `LIVE_BROADCASTING` profile) in a channel exceeds 17.
   *
   * @param uid ID of the remote user whose video state changes.
   * @param state State of the remote video. See #REMOTE_VIDEO_STATE.
   * @param reason The reason of the remote video state change. See #REMOTE_VIDEO_STATE_REASON.
   * @param elapsed Time elapsed (ms) from the local user calling the
   * \ref agora::rtc::IRtcEngine::joinChannel "joinChannel" method until the
   * SDK triggers this callback.
   */
  virtual void onRemoteVideoStateChanged(uid_t uid, REMOTE_VIDEO_STATE state, REMOTE_VIDEO_STATE_REASON reason, int elapsed) {
    (void)uid;
    (void)state;
    (void)reason;
    (void)elapsed;
  }

  /** Occurs when a specified remote user enables/disables the local video
   * capturing function.
   *
   * This callback is only applicable to the scenario when the user only
   * wants to watch the remote video without sending any video stream to the
   * other user.
   *
   * The SDK triggers this callback when the remote user resumes or stops
   * capturing the video stream by calling the
   * \ref agora::rtc::IRtcEngine::enableLocalVideo "enableLocalVideo" method.
   *
   * @param uid User ID of the remote user.
   * @param enabled Whether the specified remote user enables/disables the
   * local video capturing function:
   * - true: Enable. Other users in the channel can see the video of this
   * remote user.
   * - false: Disable. Other users in the channel can no longer receive the
   * video stream from this remote user, while this remote user can still
   * receive the video streams from other users.
   */
  virtual void onUserEnableLocalVideo(uid_t uid, bool enabled) {
    (void)uid;
    (void)enabled;
  }

  //    virtual void onStreamError(int streamId, int code, int parameter, const char* message, size_t length) {}
  /** Occurs when the local user receives the data stream from the remote user within five seconds.

  The SDK triggers this callback when the local user receives the stream message that the remote user sends by calling the \ref agora::rtc::IRtcEngine::sendStreamMessage "sendStreamMessage" method.
  @param uid User ID of the remote user sending the message.
  @param streamId Stream ID.
  @param data Pointer to the data received by the local user.
  @param length Length of the data in bytes.
  */
  virtual void onStreamMessage(uid_t uid, int streamId, const char* data, size_t length) {
    (void)uid;
    (void)streamId;
    (void)data;
    (void)length;
  }

  /** Occurs when the local user does not receive the data stream from the remote user within five seconds.

The SDK triggers this callback when the local user fails to receive the stream message that the remote user sends by calling the \ref agora::rtc::IRtcEngine::sendStreamMessage "sendStreamMessage" method.
@param uid User ID of the remote user sending the message.
@param streamId Stream ID.
@param code Error code: #ERROR_CODE_TYPE.
@param missed Number of lost messages.
@param cached Number of incoming cached messages when the data stream is interrupted.
*/
  virtual void onStreamMessageError(uid_t uid, int streamId, int code, int missed, int cached) {
    (void)uid;
    (void)streamId;
    (void)code;
    (void)missed;
    (void)cached;
  }

  /** Occurs when the media engine loads.*/
  virtual void onMediaEngineLoadSuccess() {}
  /** Occurs when the media engine call starts.*/
  virtual void onMediaEngineStartCallSuccess() {}

  /** Reports whether the super resolution feature is successfully enabled. (beta feature)
   *
   * @since v3.5.1
   *
   * After calling \ref IRtcEngine::enableRemoteSuperResolution "enableRemoteSuperResolution", the SDK triggers this
   * callback to report whether super resolution is successfully enabled. If it is not successfully enabled,
   * use `reason` for troubleshooting.
   *
   * @param uid The user ID of the remote user.
   * @param enabled Whether super resolution is successfully enabled:
   * - true: Super resolution is successfully enabled.
   * - false: Super resolution is not successfully enabled.
   * @param reason The reason why super resolution is not successfully enabled or the message
   * that confirms success. See #SUPER_RESOLUTION_STATE_REASON.
   *
   */
  virtual void onUserSuperResolutionEnabled(uid_t uid, bool enabled, SUPER_RESOLUTION_STATE_REASON reason) {
    (void)uid;
    (void)enabled;
    (void)reason;
  }

  /**
   * Reports whether the virtual background is successfully enabled.
   *
   * @since v3.4.5
   *
   * After you call \ref IRtcEngine::enableVirtualBackground "enableVirtualBackground", the SDK triggers this callback
   * to report whether the virtual background is successfully enabled.
   *
   * @note If the background image customized in the virtual background is in PNG or JPG format, the triggering of this
   * callback is delayed until the image is read.
   *
   * @param enabled Whether the virtual background is successfully enabled:
   * - true: The virtual background is successfully enabled.
   * - false: The virtual background is not successfully enabled.
   * @param reason The reason why the virtual background is not successfully enabled or the message that confirms
   * success. See #VIRTUAL_BACKGROUND_SOURCE_STATE_REASON.
   */
  virtual void onVirtualBackgroundSourceEnabled(bool enabled, VIRTUAL_BACKGROUND_SOURCE_STATE_REASON reason) {
    (void)enabled;
    (void)reason;
  }
  /// @cond nodoc
  /** Reports result of Content Inspect*/
  virtual void onContentInspectResult(CONTENT_INSPECT_RESULT result) { (void)result; }
  /// @endcond
  /**
   * Reports the result of taking a video snapshot.
   *
   * @since v3.5.2
   *
   * After a successful \ref IRtcEngine::takeSnapshot "takeSnapshot" method call, the SDK triggers this callback to
   * report whether the snapshot is successfully taken as well as the details for the snapshot taken.
   *
   * @param channel The channel name.
   * @param uid The user ID of the user. A `uid` of 0 indicates the local user.
   * @param filePath The local path of the snapshot.
   * @param width The width (px) of the snapshot.
   * @param height The height (px) of the snapshot.
   * @param errCode The message that confirms success or the reason why the snapshot is not successfully taken:
   * - `0`: Success.
   * - < 0: Failure:
   *  - `-1`: The SDK fails to write data to a file or encode a JPEG image.
   *  - `-2`: The SDK does not find the video stream of the specified user within one second after
   * the \ref IRtcEngine::takeSnapshot "takeSnapshot" method call succeeds.
   */
  virtual void onSnapshotTaken(const char* channel, uid_t uid, const char* filePath, int width, int height, int errCode) {
    (void)channel;
    (void)uid;
    (void)filePath;
    (void)width;
    (void)height;
    (void)errCode;
  }

  /** Occurs when the state of the media stream relay changes.
   *
   * The SDK returns the state of the current media relay with any error
   * message.
   *
   * @param state The state code in #CHANNEL_MEDIA_RELAY_STATE.
   * @param code The error code in #CHANNEL_MEDIA_RELAY_ERROR.
   */
  virtual void onChannelMediaRelayStateChanged(CHANNEL_MEDIA_RELAY_STATE state, CHANNEL_MEDIA_RELAY_ERROR code) {}

  /** Reports events during the media stream relay.
   *
   * @param code The event code in #CHANNEL_MEDIA_RELAY_EVENT.
   */
  virtual void onChannelMediaRelayEvent(CHANNEL_MEDIA_RELAY_EVENT code) {}

  /** Occurs when the engine sends the first local audio frame.

   @deprecated Deprecated as of v3.1.0. Use the \ref IRtcEngineEventHandler::onFirstLocalAudioFramePublished "onFirstLocalAudioFramePublished" callback instead.

   @param elapsed Time elapsed (ms) from the local user calling \ref IRtcEngine::joinChannel "joinChannel" until the SDK triggers this callback.
   */
  virtual void onFirstLocalAudioFrame(int elapsed) AGORA_DEPRECATED_ATTRIBUTE { (void)elapsed; }

  /** Occurs when the first audio frame is published.
   *
   * @since v3.1.0
   *
   * The SDK triggers this callback under one of the following circumstances:
   * - The local client enables the audio module and calls \ref IRtcEngine::joinChannel "joinChannel" successfully.
   * - The local client calls \ref IRtcEngine::muteLocalAudioStream "muteLocalAudioStream(true)" and \ref IRtcEngine::muteLocalAudioStream "muteLocalAudioStream(false)" in sequence.
   * - The local client calls \ref IRtcEngine::disableAudio "disableAudio" and \ref IRtcEngine::enableAudio "enableAudio" in sequence.
   * - The local client calls \ref agora::media::IMediaEngine::pushAudioFrame "pushAudioFrame" to successfully push the video frame to the SDK.
   *
   * @param elapsed The time elapsed (ms) from the local client calling \ref IRtcEngine::joinChannel "joinChannel" until the SDK triggers this callback.
   */
  virtual void onFirstLocalAudioFramePublished(int elapsed) { (void)elapsed; }

  /** Occurs when the engine receives the first audio frame from a specific remote user.

  @deprecated v3.0.0

  This callback is deprecated. Use `onRemoteAudioStateChanged` instead.

  @param uid User ID of the remote user.
  @param elapsed Time elapsed (ms) from the remote user calling \ref IRtcEngine::joinChannel "joinChannel" until the SDK triggers this callback.
  */
  virtual void onFirstRemoteAudioFrame(uid_t uid, int elapsed) AGORA_DEPRECATED_ATTRIBUTE {
    (void)uid;
    (void)elapsed;
  }

  /**
   * Occurs when the state of the RTMP or RTMPS streaming changes.
   *
   * When the CDN live streaming state changes, the SDK triggers this callback to report the current state and the reason
   * why the state has changed.
   *
   * When exceptions occur, you can troubleshoot issues by referring to the detailed error descriptions in the *errCode* parameter.
   *
   * @param url The CDN streaming URL.
   * @param state The RTMP or RTMPS streaming state. See: #RTMP_STREAM_PUBLISH_STATE.
   * @param errCode The detailed error information for streaming. See: #RTMP_STREAM_PUBLISH_ERROR_TYPE.
   */
  virtual void onRtmpStreamingStateChanged(const char* url, RTMP_STREAM_PUBLISH_STATE state, RTMP_STREAM_PUBLISH_ERROR_TYPE errCode) {
    (void)url;
    (void)state;
    (void)errCode;
  }

  /** Reports events during the RTMP or RTMPS streaming.
   *
   * @since v3.1.0
   *
   * @param url The RTMP or RTMPS streaming URL.
   * @param eventCode The event code. See #RTMP_STREAMING_EVENT
   */
  virtual void onRtmpStreamingEvent(const char* url, RTMP_STREAMING_EVENT eventCode) {
    (void)url;
    (void)eventCode;
  }

  /** @deprecated This method is deprecated, use the \ref agora::rtc::IRtcEngineEventHandler::onRtmpStreamingStateChanged "onRtmpStreamingStateChanged" callback instead.

   Reports the result of calling the \ref IRtcEngine::addPublishStreamUrl "addPublishStreamUrl" method. (CDN live only.)

   @param url The CDN streaming URL.
   @param error Error code: #ERROR_CODE_TYPE. Main errors include:
   - #ERR_OK (0): The publishing succeeds.
   - #ERR_FAILED (1): The publishing fails.
   - #ERR_INVALID_ARGUMENT (-2): Invalid argument used. If, for example, you did not call \ref agora::rtc::IRtcEngine::setLiveTranscoding "setLiveTranscoding" to configure LiveTranscoding before calling \ref agora::rtc::IRtcEngine::addPublishStreamUrl "addPublishStreamUrl", the SDK reports #ERR_INVALID_ARGUMENT.
   - #ERR_TIMEDOUT (-10): The publishing timed out.
   - #ERR_ALREADY_IN_USE (-19): The chosen URL address is already in use for CDN live streaming.
   - #ERR_ENCRYPTED_STREAM_NOT_ALLOWED_PUBLISH (130): You cannot publish an encrypted stream.
   - #ERR_PUBLISH_STREAM_CDN_ERROR (151)
   - #ERR_PUBLISH_STREAM_NUM_REACH_LIMIT (152)
   - #ERR_PUBLISH_STREAM_NOT_AUTHORIZED (153)
   - #ERR_PUBLISH_STREAM_INTERNAL_SERVER_ERROR (154)
   - #ERR_PUBLISH_STREAM_FORMAT_NOT_SUPPORTED (156)
   */
  virtual void onStreamPublished(const char* url, int error) AGORA_DEPRECATED_ATTRIBUTE {
    (void)url;
    (void)error;
  }
  /** @deprecated This method is deprecated, use the \ref agora::rtc::IRtcEngineEventHandler::onRtmpStreamingStateChanged "onRtmpStreamingStateChanged" callback instead.

   Reports the result of calling the \ref agora::rtc::IRtcEngine::removePublishStreamUrl "removePublishStreamUrl" method. (CDN live only.)

   This callback indicates whether you have successfully removed an RTMP or RTMPS stream from the CDN.

   @param url The CDN streaming URL.
   */
  virtual void onStreamUnpublished(const char* url) AGORA_DEPRECATED_ATTRIBUTE { (void)url; }
  /** Occurs when the publisher's transcoding is updated.
   *
   * When the `LiveTranscoding` class in the \ref agora::rtc::IRtcEngine::setLiveTranscoding "setLiveTranscoding" method updates, the SDK triggers the `onTranscodingUpdated` callback to report the update information to the local host.
   *
   * @note If you call the `setLiveTranscoding` method to set the LiveTranscoding class for the first time, the SDK does not trigger the `onTranscodingUpdated` callback.
   *
   */
  virtual void onTranscodingUpdated() {}
  /** Occurs when a voice or video stream URL address is added to the interactive live streaming.

   @warning Agora will soon stop the service for injecting online media streams on the client. If you have not implemented this service, Agora recommends that you do not use it.

   @param url Pointer to the URL address of the externally injected stream.
   @param uid User ID.
   @param status State of the externally injected stream: #INJECT_STREAM_STATUS.
   */
  virtual void onStreamInjectedStatus(const char* url, uid_t uid, int status) {
    (void)url;
    (void)uid;
    (void)status;
  }

  /** Occurs when the local audio route changes.
   *
   * @note This callback applies to Android, iOS and macOS only.
   *
   * @param routing The current audio routing. See: #AUDIO_ROUTE_TYPE.
   */
  virtual void onAudioRouteChanged(AUDIO_ROUTE_TYPE routing) { (void)routing; }

  /** Occurs when the published media stream falls back to an audio-only stream due to poor network conditions or switches back to the video after the network conditions improve.

   If you call \ref IRtcEngine::setLocalPublishFallbackOption "setLocalPublishFallbackOption" and set *option* as #STREAM_FALLBACK_OPTION_AUDIO_ONLY, the SDK triggers this callback when the
   published stream falls back to audio-only mode due to poor uplink conditions, or when the audio stream switches back to the video after the uplink network condition improves.
   @note If the local stream fallbacks to the audio-only stream, the remote user receives the \ref IRtcEngineEventHandler::onUserMuteVideo "onUserMuteVideo" callback.

   @param isFallbackOrRecover Whether the published stream falls back to audio-only or switches back to the video:
   - true: The published stream falls back to audio-only due to poor network conditions.
   - false: The published stream switches back to the video after the network conditions improve.
   */
  virtual void onLocalPublishFallbackToAudioOnly(bool isFallbackOrRecover) { (void)isFallbackOrRecover; }

  /** Occurs when the remote media stream falls back to audio-only stream
   * due to poor network conditions or switches back to the video stream
   * after the network conditions improve.
   *
   * If you call
   * \ref IRtcEngine::setRemoteSubscribeFallbackOption
   * "setRemoteSubscribeFallbackOption" and set
   * @p option as #STREAM_FALLBACK_OPTION_AUDIO_ONLY, the SDK triggers this
   * callback when the remote media stream falls back to audio-only mode due
   * to poor downlink conditions, or when the remote media stream switches
   * back to the video after the downlink network condition improves.
   *
   * @note Once the remote media stream switches to the low stream due to
   * poor network conditions, you can monitor the stream switch between a
   * high and low stream in the RemoteVideoStats callback.
   *
   * @param uid ID of the remote user sending the stream.
   * @param isFallbackOrRecover Whether the remotely subscribed media stream
   * falls back to audio-only or switches back to the video:
   * - true: The remotely subscribed media stream falls back to audio-only
   * due to poor network conditions.
   * - false: The remotely subscribed media stream switches back to the
   * video stream after the network conditions improved.
   */
  virtual void onRemoteSubscribeFallbackToAudioOnly(uid_t uid, bool isFallbackOrRecover) {
    (void)uid;
    (void)isFallbackOrRecover;
  }

  /** Reports the transport-layer statistics of each remote audio stream.
   *
   * @deprecated
   * This callback is deprecated and replaced by the
   * \ref onRemoteAudioStats() "onRemoteAudioStats" callback.
   *
   * This callback reports the transport-layer statistics, such as the
   * packet loss rate and network time delay, once every two seconds after
   * the local user receives an audio packet from a remote user.
   *
   * @param uid  User ID of the remote user sending the audio packet.
   * @param delay Network time delay (ms) from the remote user sending the
   * audio packet to the local user.
   * @param lost Packet loss rate (%) of the audio packet sent from the
   * remote user.
   * @param rxKBitRate  Received bitrate (Kbps) of the audio packet sent
   * from the remote user.
   */
  virtual void onRemoteAudioTransportStats(uid_t uid, unsigned short delay, unsigned short lost, unsigned short rxKBitRate) AGORA_DEPRECATED_ATTRIBUTE {
    (void)uid;
    (void)delay;
    (void)lost;
    (void)rxKBitRate;
  }

  /** Reports the transport-layer statistics of each remote video stream.
   *
   * @deprecated
   * This callback is deprecated and replaced by the
   * \ref onRemoteVideoStats() "onRemoteVideoStats" callback.
   *
   * This callback reports the transport-layer statistics, such as the
   * packet loss rate and network time delay, once every two seconds after
   * the local user receives a video packet from a remote user.
   *
   * @param uid User ID of the remote user sending the video packet.
   * @param delay Network time delay (ms) from the remote user sending the
   * video packet to the local user.
   * @param lost Packet loss rate (%) of the video packet sent from the
   * remote user.
   * @param rxKBitRate Received bitrate (Kbps) of the video packet sent
   * from the remote user.
   */
  virtual void onRemoteVideoTransportStats(uid_t uid, unsigned short delay, unsigned short lost, unsigned short rxKBitRate) AGORA_DEPRECATED_ATTRIBUTE {
    (void)uid;
    (void)delay;
    (void)lost;
    (void)rxKBitRate;
  }

  /** Occurs when the microphone is enabled/disabled.
   *
   * @deprecated v2.9.0
   *
   * The \ref onMicrophoneEnabled() "onMicrophoneEnabled" callback is
   * deprecated. Use #LOCAL_AUDIO_STREAM_STATE_STOPPED (0) or
   * #LOCAL_AUDIO_STREAM_STATE_RECORDING (1) in the
   * \ref onLocalAudioStateChanged() "onLocalAudioStateChanged" callback
   * instead.
   *
   * The SDK triggers this callback when the local user resumes or stops
   * capturing the local audio stream by calling the
   * \ref agora::rtc::IRtcEngine::enableLocalAudio "enableLocalAudio" method.
   *
   * @param enabled Whether the microphone is enabled/disabled:
   * - true: Enabled.
   * - false: Disabled.
   */
  virtual void onMicrophoneEnabled(bool enabled) AGORA_DEPRECATED_ATTRIBUTE { (void)enabled; }
  /** Occurs when the connection state between the SDK and the server changes.

   @param state See #CONNECTION_STATE_TYPE.
   @param reason See #CONNECTION_CHANGED_REASON_TYPE.
   */
  virtual void onConnectionStateChanged(CONNECTION_STATE_TYPE state, CONNECTION_CHANGED_REASON_TYPE reason) {
    (void)state;
    (void)reason;
  }
  /// @cond nodoc
  /** Occurs when the WIFI message need be sent to the user.

   @param reason The reason of notifying the user of a message.
   @param action Suggest an action for the user.
   @param wlAccMsg The message content of notifying the user.
   */
  virtual void onWlAccMessage(WLACC_MESSAGE_REASON reason, WLACC_SUGGEST_ACTION action, const char* wlAccMsg) {
    (void)reason;
    (void)action;
    (void)wlAccMsg;
  }
  /** Occurs when SDK statistics wifi acceleration optimization effect.

   @param currentStats Instantaneous value of optimization effect.
   @param averageStats Average value of cumulative optimization effect.
   */
  virtual void onWlAccStats(WlAccStats currentStats, WlAccStats averageStats) {
    (void)currentStats;
    (void)averageStats;
  }
  /// @endcond

  /** Occurs when the local network type changes.

  When the network connection is interrupted, this callback indicates whether the interruption is caused by a network type change or poor network conditions.

   @param type See #NETWORK_TYPE.
   */
  virtual void onNetworkTypeChanged(NETWORK_TYPE type) { (void)type; }
  /** Occurs when the local user successfully registers a user account by calling the \ref agora::rtc::IRtcEngine::registerLocalUserAccount "registerLocalUserAccount" method or joins a channel by calling the \ref agora::rtc::IRtcEngine::joinChannelWithUserAccount "joinChannelWithUserAccount" method.This callback reports the user ID and user account of the local user.

   @param uid The ID of the local user.
   @param userAccount The user account of the local user.
   */
  virtual void onLocalUserRegistered(uid_t uid, const char* userAccount) {
    (void)uid;
    (void)userAccount;
  }
  /** Occurs when the SDK gets the user ID and user account of the remote user.

   After a remote user joins the channel, the SDK gets the UID and user account of the remote user,
   caches them in a mapping table object (`userInfo`), and triggers this callback on the local client.

     @param uid The ID of the remote user.
     @param info The `UserInfo` object that contains the user ID and user account of the remote user.
     */
  virtual void onUserInfoUpdated(uid_t uid, const UserInfo& info) {
    (void)uid;
    (void)info;
  }
  /// @cond nodoc
  /** Reports the result of uploading the SDK log files.
   *
   * @since v3.3.0
   *
   * After the method call of \ref IRtcEngine::uploadLogFile "uploadLogFile", the SDK triggers this callback to report the
   * result of uploading the log files. If the upload fails, refer to the `reason` parameter to troubleshoot.
   *
   * @param requestId The request ID. This request ID is the same as `requestId` returned by \ref IRtcEngine::uploadLogFile "uploadLogFile",
   * and you can use `requestId` to match a specific upload with a callback.
   * @param success Whether the log files are successfully uploaded.
   * - true: Successfully uploads the log files.
   * - false: Fails to upload the log files. For details, see the `reason` parameter.
   * @param reason The reason for the upload failure. See #UPLOAD_ERROR_REASON.
   */
  virtual void onUploadLogResult(const char* requestId, bool success, UPLOAD_ERROR_REASON reason) {
    (void)requestId;
    (void)success;
    (void)reason;
  }

#ifdef _WIN32
  /**
   * Occurs when the screen sharing information is updated.
   *
   * @since v3.6.1
   *
   * When you call \ref IRtcEngine::startScreenCaptureByDisplayId "startScreenCaptureByDisplayId" or \ref IRtcEngine::startScreenCaptureByScreenRect "startScreenCaptureByScreenRect" to start screen sharing and use the `excludeWindowList` attribute to block the specified window,
   * the SDK triggers this callback if the window blocking fails.
   *
   * @note This callback is for Windows only.
   *
   * @param info The screen sharing information. See ScreenCaptureInfo
   */
  virtual void onScreenCaptureInfoUpdated(ScreenCaptureInfo& info) { (void)info; }
#endif
  /// @endcond
};

/**
* Video device collection methods.

 The IVideoDeviceCollection interface class gets the video device information.
*/
class IVideoDeviceCollection {
 protected:
  virtual ~IVideoDeviceCollection() {}

 public:
  /** Gets the total number of the indexed video devices in the system.

  @return Total number of the indexed video devices:
  */
  virtual int getCount() = 0;

  /** Gets a specified piece of information about an indexed video device.

   @param index The specified index of the video device that must be less than the return value of \ref IVideoDeviceCollection::getCount "getCount".
   @param deviceName Pointer to the video device name.
   @param deviceId Pointer to the video device ID.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int getDevice(int index, char deviceName[MAX_DEVICE_ID_LENGTH], char deviceId[MAX_DEVICE_ID_LENGTH]) = 0;

  /** Sets the device with the device ID.

   @param deviceId Device ID of the device.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setDevice(const char deviceId[MAX_DEVICE_ID_LENGTH]) = 0;

  /** Releases all IVideoDeviceCollection resources.
   */
  virtual void release() = 0;
};

#if !defined(__ANDROID__) && !(defined(__APPLE__) && TARGET_OS_IPHONE)
/** Video device management methods.

 The IVideoDeviceManager interface class tests the video device interfaces. Instantiate an AVideoDeviceManager class to get an IVideoDeviceManager interface.
*/
class IVideoDeviceManager {
 protected:
  virtual ~IVideoDeviceManager() {}

 public:
  /** Enumerates the video devices (for macOS and Windows only).

   This method returns an IVideoDeviceCollection object including all video devices
   in the system. With the IVideoDeviceCollection object, the application can enumerate
   the video devices. The application must call the \ref IVideoDeviceCollection::release "release" method to release the returned object after using it.

   @return
   - An IVideoDeviceCollection object including all video devices in the system: Success.
   - NULL: Failure.
   */
  virtual IVideoDeviceCollection* enumerateVideoDevices() = 0;

  /** Starts the video-capture device test (for macOS and Windows only).

   This method tests whether the video-capture device works properly. Before calling this method, ensure that you have already called the \ref IRtcEngine::enableVideo "enableVideo" method, and the window handle (*hwnd*) parameter is valid.

   @param hwnd The window handle used to display the screen.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int startDeviceTest(view_t hwnd) = 0;

  /** Stops the video-capture device test (for macOS and Windows only).

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int stopDeviceTest() = 0;

  /** Sets a device with the device ID (for macOS and Windows only).

   @param deviceId Pointer to the video-capture device ID. Call the \ref IVideoDeviceManager::enumerateVideoDevices "enumerateVideoDevices" method to get it.

   @note Plugging or unplugging the device does not change the device ID.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setDevice(const char deviceId[MAX_DEVICE_ID_LENGTH]) = 0;

  /** Gets the video-capture device that is in use (for macOS and Windows only).

   @param deviceId Pointer to the video-capture device ID.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int getDevice(char deviceId[MAX_DEVICE_ID_LENGTH]) = 0;

  /** Releases all IVideoDeviceManager resources (for macOS and Windows only).
   */
  virtual void release() = 0;
};

/** Audio device collection methods.

The IAudioDeviceCollection interface class gets device-related information.
*/
class IAudioDeviceCollection {
 protected:
  virtual ~IAudioDeviceCollection() {}

 public:
  /** Gets the total number of audio playback or audio capturing devices (for macOS and Windows only).

   @note You must first call the \ref IAudioDeviceManager::enumeratePlaybackDevices "enumeratePlaybackDevices" or \ref IAudioDeviceManager::enumerateRecordingDevices "enumerateRecordingDevices" method before calling this method to return the number of  audio playback or audio capturing devices.

   @return Number of audio playback or audio capturing devices.
   */
  virtual int getCount() = 0;

  /** Gets a specified piece of information about an indexed audio device (for macOS and Windows only).

   @param index The specified index that must be less than the return value of \ref IAudioDeviceCollection::getCount "getCount".
   @param deviceName Pointer to the audio device name.
   @param deviceId Pointer to the audio device ID.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int getDevice(int index, char deviceName[MAX_DEVICE_ID_LENGTH], char deviceId[MAX_DEVICE_ID_LENGTH]) = 0;

  /** Specifies a device with the device ID (for macOS and Windows only).

   @param deviceId Pointer to the device ID of the device.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setDevice(const char deviceId[MAX_DEVICE_ID_LENGTH]) = 0;

  /**
   * Gets the default audio device of the system (for macOS and Windows only).
   *
   * @since v3.6.0
   *
   * @param deviceName The name of the system default audio device.
   * @param deviceId The device ID of the the system default audio device.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int getDefaultDevice(char deviceName[MAX_DEVICE_ID_LENGTH], char deviceId[MAX_DEVICE_ID_LENGTH]) = 0;

  /** Sets the volume of the application (for macOS and Windows only).

  @param volume Application volume. The value ranges between 0 (lowest volume) and 255 (highest volume).
  @return
  - 0: Success.
  - < 0: Failure.
  */
  virtual int setApplicationVolume(int volume) = 0;

  /** Gets the volume of the application (for macOS and Windows only).

   @param volume Pointer to the application volume. The volume value ranges between 0 (lowest volume) and 255 (highest volume).

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int getApplicationVolume(int& volume) = 0;

  /** Mutes the application (for macOS and Windows only).

   @param mute Sets whether to mute/unmute the application:
   - true: Mute the application.
   - false: Unmute the application.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setApplicationMute(bool mute) = 0;
  /** Gets the mute state of the application (for macOS and Windows only).

   @param mute Pointer to whether the application is muted/unmuted.
   - true: The application is muted.
   - false: The application is not muted.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int isApplicationMute(bool& mute) = 0;

  /** Releases all IAudioDeviceCollection resources (for macOS and Windows only).
   */
  virtual void release() = 0;
};
/** Audio device management methods.

 The IAudioDeviceManager interface class allows for audio device interface testing. Instantiate an AAudioDeviceManager class to get the IAudioDeviceManager interface.
*/
class IAudioDeviceManager {
 protected:
  virtual ~IAudioDeviceManager() {}

 public:
  /** Enumerates the audio playback devices (for macOS and Windows only).

   This method returns an IAudioDeviceCollection object that includes all audio playback devices in the system. With the IAudioDeviceCollection object, the application can enumerate the audio playback devices.

   @note The application must call the \ref IAudioDeviceCollection::release "release" method to release the returned object after using it.

   @return
   - Success: Returns an IAudioDeviceCollection object that includes all audio playback devices in the system. For wireless Bluetooth headset devices with master and slave headsets, the master headset is the playback device.
   - Returns NULL: Failure.
   */
  virtual IAudioDeviceCollection* enumeratePlaybackDevices() = 0;

  /** Enumerates the audio capturing devices (for macOS and Windows only).

   This method returns an IAudioDeviceCollection object that includes all audio capturing devices in the system. With the IAudioDeviceCollection object, the application can enumerate the audio capturing devices.

   @note The application needs to call the \ref IAudioDeviceCollection::release "release" method to release the returned object after using it.

   @return
   - Returns an IAudioDeviceCollection object that includes all audio capturing devices in the system: Success.
   - Returns NULL: Failure.
   */
  virtual IAudioDeviceCollection* enumerateRecordingDevices() = 0;

  /** Sets the audio playback device using the device ID (for macOS and Windows only).

   @note Plugging or unplugging the audio device does not change the device ID.

   @param deviceId Device ID of the audio playback device, retrieved by calling the \ref IAudioDeviceManager::enumeratePlaybackDevices "enumeratePlaybackDevices" method.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setPlaybackDevice(const char deviceId[MAX_DEVICE_ID_LENGTH]) = 0;

  /** Sets the audio capturing device using the device ID (for macOS and Windows only).

   @param deviceId Device ID of the audio capturing device, retrieved by calling the \ref IAudioDeviceManager::enumerateRecordingDevices "enumerateRecordingDevices" method.

   @note Plugging or unplugging the audio device does not change the device ID.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setRecordingDevice(const char deviceId[MAX_DEVICE_ID_LENGTH]) = 0;

  /**
   * Sets the audio playback device used by the SDK to follow the system default audio playback device (for macOS and Windows only).
   *
   * @since v3.6.0
   *
   * @param enable Whether to follow the system default audio playback device:
   * - true: Follow. The SDK immediately switches the audio playback device when the system default audio playback device changes.
   * - false: Do not follow. The SDK switches the audio playback device to the system default audio playback device only when the currently used audio playback device is disconnected.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int followSystemPlaybackDevice(bool enable) = 0;

  /**
   * Sets the audio recording device used by the SDK to follow the system default audio recording device (for macOS and Windows only).
   *
   * @since v3.6.0
   *
   * @param enable Whether to follow the system default audio recording device:
   * - true: Follow. The SDK immediately switches the audio recording device when the system default audio recording device changes.
   * - false: Do not follow. The SDK switches the audio recording device to the system default audio recording device only when the currently used audio recording device is disconnected.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int followSystemRecordingDevice(bool enable) = 0;

  /** Starts the audio playback device test (for macOS and Windows only).
   *
   * This method tests whether the audio playback device works properly. Once a user starts the test, the SDK plays an audio file specified by the user. If the user can hear the audio, the playback device works properly.
   *
   * As of v3.6.2, you can call this method either before or after joining a channel. Depending on the call sequence, the SDK triggers the following callbacks every 100 ms to report the volume of the audio playback device:
   *
   * - \ref IRtcEngineEventHandler::onAudioVolumeIndication "onAudioVolumeIndication" and \ref IRtcEngineEventHandler::onAudioDeviceTestVolumeIndication "onAudioDeviceTestVolumeIndication" when you call this method before joining the channel, with the following values:
   *
   *    - `uid = 1` and `volume` in `onAudioVolumeIndication`.
   *    - `volumeType = AudioTestPlaybackVolume(1)` and `volume` in `onAudioDeviceTestVolumeIndication`.
   *
   *  The two callbacks report the same volume information. Agora recommends using `onAudioDeviceTestVolumeIndication`.
   *
   * - `onAudioDeviceTestVolumeIndication` when you call this method after joining a channel, which reports `volumeType = AudioTestPlaybackVolume(1)` and `volume`.
   *
   * @note
   * - Calling this method after joining a channel tests the audio playback device that the SDK is using.
   * - After calling `startPlaybackDeviceTest`, you must call \ref IAudioDeviceManager::stopPlaybackDeviceTest "stopPlaybackDeviceTest" to stop the test.
   *
   * @param testAudioFilePath The absolute path in UTF-8 of the audio file used for the audio playback device test.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int startPlaybackDeviceTest(const char* testAudioFilePath) = 0;

  /** Stops the audio playback device test (for macOS and Windows only).

   This method stops testing the audio playback device. You must call this method to stop the test after calling the \ref IAudioDeviceManager::startPlaybackDeviceTest "startPlaybackDeviceTest" method.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int stopPlaybackDeviceTest() = 0;

  /** Sets the volume of the audio playback device (for macOS and Windows only).

   @param volume Sets the volume of the audio playback device. The value ranges between 0 (lowest volume) and 255 (highest volume).
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setPlaybackDeviceVolume(int volume) = 0;

  /** Gets the volume of the audio playback device (for macOS and Windows only).

   @param volume Pointer to the audio playback device volume. The volume value ranges between 0 (lowest volume) and 255 (highest volume).
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int getPlaybackDeviceVolume(int* volume) = 0;

  /** Sets the volume of the microphone (for macOS and Windows only).

   @note Ensure that you call this method after joining a channel.

   @param volume Sets the volume of the microphone. The value ranges between 0 (lowest volume) and 255 (highest volume).
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setRecordingDeviceVolume(int volume) = 0;

  /** Gets the volume of the microphone (for macOS and Windows only).

   @param volume Pointer to the microphone volume. The volume value ranges between 0 (lowest volume) and 255 (highest volume).
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int getRecordingDeviceVolume(int* volume) = 0;

  /** Mutes the audio playback device (for macOS and Windows only).

   @param mute Sets whether to mute/unmute the audio playback device:
   - true: Mutes.
   - false: Unmutes.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setPlaybackDeviceMute(bool mute) = 0;
  /** Gets the mute status of the audio playback device (for macOS and Windows only).

   @param mute Pointer to whether the audio playback device is muted/unmuted.
   - true: Muted.
   - false: Unmuted.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int getPlaybackDeviceMute(bool* mute) = 0;
  /** Mutes/Unmutes the microphone (for macOS and Windows only).

   @param mute Sets whether to mute/unmute the microphone:
   - true: Mutes.
   - false: Unmutes.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setRecordingDeviceMute(bool mute) = 0;

  /** Gets the microphone's mute status (for macOS and Windows only).

   @param mute Pointer to whether the microphone is muted/unmuted.
   - true: Muted.
   - false: Unmuted.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int getRecordingDeviceMute(bool* mute) = 0;

  /** Starts the audio capturing device test (for macOS and Windows only).
   *
   * This method tests whether the audio capturing device works properly.
   *
   * As of v3.6.2, you can call this method either before or after joining a channel. Depending on the call sequence, the SDK triggers the following callbacks at the set time interval to report the volume of the audio capturing device:
   *
   * - \ref IRtcEngineEventHandler::onAudioVolumeIndication "onAudioVolumeIndication" and \ref IRtcEngineEventHandler::onAudioDeviceTestVolumeIndication "onAudioDeviceTestVolumeIndication" when you call this method before joining the channel, with the following values:
   *
   *   - `uid = 0` and `volume` in `onAudioVolumeIndication`.
   *   - `volumeType = AudioTestRecordingVolume(0)` and `volume` in `onAudioDeviceTestVolumeIndication`.
   *
   *  The two callbacks report the same volume information. Agora recommends using `onAudioDeviceTestVolumeIndication`.
   *
   * - `onAudioDeviceTestVolumeIndication` when you call this method after joining a channel, which reports `volumeType = AudioTestRecordingVolume(0)` and `volume`.
   *
   *
   * @note
   * - When you call this method after joining a channel, ensure the audio capturing device is on ( \ref IRtcEngine::enableLocalAudio "enableLocalAudio" is set as `true`); otherwise, the method call fails, and the SDK triggers the \ref IRtcEngineEventHandler::onError "onError" callback with `ERR_ADM_START_RECORDING(1012)`.
   * - Calling this method after joining a channel tests the audio capturing device that the SDK is using.
   * - After calling `startRecordingDeviceTest`, you must call \ref IAudioDeviceManager::stopRecordingDeviceTest "stopRecordingDeviceTest" to stop the test.
   *
   * @param indicationInterval The time interval (ms) at which the `onAudioVolumeIndication` or `onAudioDeviceTestVolumeIndication` callback returns.
   * Agora recommends a setting greater than 200 ms. This value must be 10 ms or greater; otherwise, you cannot receive the `onAudioVolumeIndication` or `onAudioDeviceTestVolumeIndication` callback.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int startRecordingDeviceTest(int indicationInterval) = 0;

  /** Stops the audio capturing device test (for macOS and Windows only).

   This method stops the audio capturing device test. You must call this method to stop the test after calling the \ref IAudioDeviceManager::startRecordingDeviceTest "startRecordingDeviceTest" method.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int stopRecordingDeviceTest() = 0;

  /** Gets the audio playback device associated with the device ID (for macOS and Windows only).

   @param deviceId Pointer to the ID of the audio playback device.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int getPlaybackDevice(char deviceId[MAX_DEVICE_ID_LENGTH]) = 0;

  /** Gets the audio playback device information associated with the device ID and device name (for macOS and Windows only).

   @param deviceId Pointer to the device ID of the audio playback device.
   @param deviceName Pointer to the device name of the audio playback device.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int getPlaybackDeviceInfo(char deviceId[MAX_DEVICE_ID_LENGTH], char deviceName[MAX_DEVICE_ID_LENGTH]) = 0;

  /** Gets the audio capturing device associated with the device ID (for macOS and Windows only).

   @param deviceId Pointer to the device ID of the audio capturing device.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int getRecordingDevice(char deviceId[MAX_DEVICE_ID_LENGTH]) = 0;

  /** Gets the audio capturing device information associated with the device ID and device name (for macOS and Windows only).

   @param deviceId Pointer to the device ID of the audio capturing device.
   @param deviceName Pointer to the device name of the audio capturing device.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int getRecordingDeviceInfo(char deviceId[MAX_DEVICE_ID_LENGTH], char deviceName[MAX_DEVICE_ID_LENGTH]) = 0;

  /** Starts the audio device loopback test (for macOS and Windows only).
   *
   * This method tests whether the local audio capturing device and playback device work properly. After calling this method, the audio capturing device samples the local audio, and then the audio playback device plays the sampled audio.
   *
   * As of v3.6.2, you can call this method either before or after joining a channel. Depending on the call sequence, the SDK triggers the following callbacks at the set time interval to report the volume of the audio capturing and playback devices:
   *
   * - Two \ref IRtcEngineEventHandler::onAudioVolumeIndication "onAudioVolumeIndication" callbacks and two \ref IRtcEngineEventHandler::onAudioDeviceTestVolumeIndication "onAudioDeviceTestVolumeIndication" callbacks when you call this method before joining the channel, with the following values:
   *
   *    - `uid = 0` and `volume` in one `onAudioVolumeIndication` callback; `uid = 1` and `volume` in the other `onAudioVolumeIndication` callback.
   *    - `volumeType = AudioTestRecordingVolume(0)` and `volume` in one `onAudioDeviceTestVolumeIndication` callback; `volumeType = AudioTestPlaybackVolume(1)` and `volume` in the other `onAudioDeviceTestVolumeIndication` callback.
   *
   *  The `onAudioVolumeIndication` and `onAudioDeviceTestVolumeIndication` callbacks report the same volume information. Agora recommends using `onAudioDeviceTestVolumeIndication`.
   *
   * - Two `onAudioDeviceTestVolumeIndication` callbacks when you call this method after joining a channel, with the following values:
   *
   *    - `volumeType = AudioTestRecordingVolume(0)` and `volume` in one callback;
   *    - `volumeType = AudioTestPlaybackVolume(1)` and `volume` in the other one.
   *
   * @note
   * - When you call this method after joining a channel, ensure the audio capturing device is on (\ref IRtcEngine::enableLocalAudio "enableLocalAudio" is set as `true`); otherwise, the method call fails, and the SDK triggers the \ref IRtcEngineEventHandler::onError "onError" callback with `ERR_ADM_START_RECORDING(1012)`.
   * - Calling this method after joining a channel tests the audio capturing and playback devices that the SDK is using.
   * - This method tests local audio devices and does not report the network conditions.
   * - After calling this method, you must call \ref IAudioDeviceManager::stopAudioDeviceLoopbackTest "stopAudioDeviceLoopbackTest" to stop the test.
   *
   * @param indicationInterval The time interval (ms) at which the `onAudioVolumeIndication` or `onAudioDeviceTestVolumeIndication` callbacks return. Agora recommends a setting greater than 200 ms.
   * This value must be 10 ms or greater; otherwise, you cannot receive these callbacks.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int startAudioDeviceLoopbackTest(int indicationInterval) = 0;

  /** Stops the audio device loopback test (for macOS and Windows only).

  @note Ensure that you call this method to stop the loopback test after calling the \ref IAudioDeviceManager::startAudioDeviceLoopbackTest "startAudioDeviceLoopbackTest" method.

  @return
  - 0: Success.
  - < 0: Failure.
  */
  virtual int stopAudioDeviceLoopbackTest() = 0;

  /** Releases all IAudioDeviceManager resources (for macOS and Windows only).
   */
  virtual void release() = 0;
};
#endif

/** The configuration of the log files.
 *
 * @since v3.3.0
 */
struct LogConfig {
  /** The absolute path of log files.
   *
   * The default file path is:
   * - Android: `/storage/emulated/0/Android/data/<package name>/files/agorasdk.log`
   * - iOS: `App Sandbox/Library/caches/agorasdk.log`
   * - macOS:
   *  - Sandbox enabled: `App Sandbox/Library/Logs/agorasdk.log`, such as `/Users/<username>/Library/Containers/<App Bundle Identifier>/Data/Library/Logs/agorasdk.log`.
   *  - Sandbox disabled: `/Users/<username>/Library/Caches/<App Bundle Identifier>/Logs/agorasdk.log`.
   * - Windows: `C:\Users\<user_name>\AppData\Local\Agora\<process_name>\agorasdk.log`
   *
   * Ensure that the directory for the log files exists and is writable. You can use this parameter to rename the log files.
   */
  const char* filePath;
  /** The size (KB) of a log file. The default value is 1024 KB. If you set `fileSize` to 1024 KB, the SDK outputs at most 5 MB log files;
   * if you set it to less than 1024 KB, the setting is invalid, and the maximum size of a log file is still 1024 KB.
   */
  int fileSize;
  /** The output log level of the SDK. See #LOG_LEVEL.
   *
   * For example, if you set the log level to WARN, the SDK outputs the logs within levels FATAL, ERROR, and WARN.
   */
  LOG_LEVEL level;
  LogConfig() : filePath(NULL), fileSize(-1), level(LOG_LEVEL::LOG_LEVEL_INFO) {}
};

/** Definition of RtcEngineContext.
 */
struct RtcEngineContext {
  /** The IRtcEngineEventHandler object.
   */
  IRtcEngineEventHandler* eventHandler;
  /**
   * The App ID issued to you by Agora. See [How to get the App ID](https://docs.agora.io/en/Agora%20Platform/token#get-an-app-id).
   * Only users in apps with the same App ID can join the same channel and communicate with each other. Use an App ID to create only
   * one `IRtcEngine` instance. To change your App ID, call `release` to destroy the current `IRtcEngine` instance and then call `createAgoraRtcEngine`
   * and `initialize` to create an `IRtcEngine` instance with the new App ID.
   */
  const char* appId;
  // For android, it the context(Activity or Application
  // for windows,Video hot plug device
  /** The video window handle. Once set, this parameter enables you to plug
   * or unplug the video devices while they are powered.
   */
  void* context;
  /**
   * The region for connection. This advanced feature applies to scenarios that have regional restrictions.
   *
   * For the regions that Agora supports, see #AREA_CODE. The area codes support bitwise operation.
   *
   * After specifying the region, the SDK connects to the Agora servers within that region.
   */
  unsigned int areaCode;
  /** The configuration of the log files that the SDK outputs. See LogConfig.
   *
   * @since v3.3.0
   *
   * By default, the SDK outputs five log files, `agorasdk.log`, `agorasdk_1.log`, `agorasdk_2.log`, `agorasdk_3.log`, `agorasdk_4.log`, each with
   * a default size of 1024 KB. These log files are encoded in UTF-8. The SDK writes the latest logs in `agorasdk.log`. When `agorasdk.log` is
   * full, the SDK deletes the log file with the earliest modification time among the other four, renames `agorasdk.log` to the name of the
   * deleted log file, and creates a new `agorasdk.log` to record latest logs.
   *
   */
  LogConfig logConfig;
  RtcEngineContext() : eventHandler(NULL), appId(NULL), context(NULL), areaCode(rtc::AREA_CODE_GLOB) {}
};

/** Definition of IMetadataObserver
 */
class IMetadataObserver {
 public:
  /** Metadata type of the observer.
   @note We only support video metadata for now.
   */
  enum METADATA_TYPE {
    /** -1: the metadata type is unknown.
     */
    UNKNOWN_METADATA = -1,
    /** 0: the metadata type is video.
     */
    VIDEO_METADATA = 0,
  };

  struct Metadata {
    /** The User ID.

     - For the receiver: the ID of the user who sent the metadata.
     - For the sender: ignore it.
     */
    unsigned int uid;
    /** Buffer size of the sent or received Metadata.
     */
    unsigned int size;
    /** Buffer address of the sent or received Metadata.
     */
    unsigned char* buffer;
    /** Timestamp (ms) of the frame following the metadata.
     */
    long long timeStampMs;
  };

  virtual ~IMetadataObserver(){};

  /** Occurs when the SDK requests the maximum size of the Metadata.

   The metadata includes the following parameters:
   - `uid`: ID of the user who sends the metadata.
   - `size`: The size of the sent or received metadata.
   - `buffer`: The sent or received metadata.
   - `timeStampMs`: The timestamp (ms) of the metadata.

   The SDK triggers this callback after you successfully call the \ref agora::rtc::IRtcEngine::registerMediaMetadataObserver "registerMediaMetadataObserver" method. You need to specify the maximum size of the metadata in the return value of this callback.

   @return The maximum size of the buffer of the metadata that you want to use. The highest value is 1024 bytes. Ensure that you set the return value.
   */
  virtual int getMaxMetadataSize() = 0;

  /** Occurs when the SDK is ready to receive and send metadata.

   @note Ensure that the size of the metadata does not exceed the value set in the \ref agora::rtc::IMetadataObserver::getMaxMetadataSize "getMaxMetadataSize" callback.

   @param metadata The Metadata to be sent.
   @return
   - true:  Send.
   - false: Do not send.
   */
  virtual bool onReadyToSendMetadata(Metadata& metadata) = 0;

  /** Occurs when the local user receives the metadata.

   @param metadata The received Metadata.
   */
  virtual void onMetadataReceived(const Metadata& metadata) = 0;
};

/** Encryption mode. Agora recommends using either the `AES_128_GCM2` or `AES_256_GCM2`
 * encryption mode, both of which support adding a salt and are more secure.
 */
enum ENCRYPTION_MODE {
  /** 1: 128-bit AES encryption, XTS mode.
   */
  AES_128_XTS = 1,
  /** 2: 128-bit AES encryption, ECB mode.
   */
  AES_128_ECB = 2,
  /** 3: 256-bit AES encryption, XTS mode.
   */
  AES_256_XTS = 3,
  /// @cond nodoc
  /** 4: 128-bit SM4 encryption, ECB mode.
   */
  SM4_128_ECB = 4,
  /// @endcond
  /** 5: 128-bit AES encryption, GCM mode.
   *
   * @since v3.3.1
   */
  AES_128_GCM = 5,
  /** 6: 256-bit AES encryption, GCM mode.
   *
   * @since v3.3.1
   */
  AES_256_GCM = 6,
  /** 7: (Default) 128-bit AES encryption, GCM mode. Compared to `AES_128_GCM` encryption mode,
   * `AES_128_GCM2` encryption mode is more secure and requires you to set the salt (`encryptionKdfSalt`).
   *
   * @since v3.4.5
   */
  AES_128_GCM2 = 7,
  /** 8: 256-bit AES encryption, GCM mode. Compared to `AES_256_GCM` encryption mode,
   * `AES_256_GCM2` encryption mode is more secure and requires you to set the salt (`encryptionKdfSalt`).
   *
   * @since v3.4.5
   */
  AES_256_GCM2 = 8,
  /** Enumerator boundary.
   */
  MODE_END,
};

/** Configurations of built-in encryption schemas. */
struct EncryptionConfig {
  /**
   * Encryption mode. The default encryption mode is `AES_128_GCM2`. See #ENCRYPTION_MODE.
   */
  ENCRYPTION_MODE encryptionMode;
  /**
   * Encryption key in string type with unlimited length. Agora recommends using a 32-byte key.
   *
   * @note If you do not set an encryption key or set it as NULL, you cannot use the built-in encryption, and the SDK returns #ERR_INVALID_ARGUMENT (-2).
   */
  const char* encryptionKey;
  /**
   * The salt with the length of 32 bytes. Agora recommends using OpenSSL to generate the salt on your server.
   * For details, see *Media Stream Encryption*.
   *
   * @note This parameter is only valid when you set the encryption mode as `AES_128_GCM2` or `AES_256_GCM2`.
   * In this case, ensure that this parameter is not `0`.
   *
   * @since v3.4.5
   */
  uint8_t encryptionKdfSalt[32];

  EncryptionConfig() {
    encryptionMode = AES_128_GCM2;
    encryptionKey = nullptr;
    memset(encryptionKdfSalt, 0, sizeof(encryptionKdfSalt));
  }

  /// @cond nodoc
  const char* getEncryptionString() const {
    switch (encryptionMode) {
      case AES_128_XTS:
        return "aes-128-xts";
      case AES_128_ECB:
        return "aes-128-ecb";
      case AES_256_XTS:
        return "aes-256-xts";
      case SM4_128_ECB:
        return "sm4-128-ecb";
      case AES_128_GCM:
        return "aes-128-gcm";
      case AES_256_GCM:
        return "aes-256-gcm";
      case AES_128_GCM2:
        return "aes-128-gcm-2";
      case AES_256_GCM2:
        return "aes-256-gcm-2";
      default:
        return "aes-128-gcm-2";
    }
    return "aes-128-gcm-2";
  }
  /// @endcond
};

/** The channel media options.
 */
struct ChannelMediaOptions {
  /** Determines whether to automatically subscribe to all remote audio streams when the user joins a channel:
   - true: (Default) Subscribe.
   - false: Do not subscribe.

   This member serves a similar function to the `muteAllRemoteAudioStreams` method. After joining the channel,
   you can call the `muteAllRemoteAudioStreams` method to set whether to subscribe to audio streams in the channel.
   */
  bool autoSubscribeAudio;
  /** Determines whether to subscribe to video streams when the user joins the channel:
   - true: (Default) Subscribe.
   - false: Do not subscribe.

   This member serves a similar function to the `muteAllRemoteVideoStreams` method. After joining the channel,
   you can call the `muteAllRemoteVideoStreams` method to set whether to subscribe to video streams in the channel.
   */
  bool autoSubscribeVideo;
  /** Determines whether to publish the local audio stream when the user joins a channel:
   * - true: (Default) Publish.
   * - false: Do not publish.
   *
   * This member serves a similar function to the `muteLocalAudioStream` method. After the user joins
   * the channel, you can call the `muteLocalAudioStream` method to set whether to publish the
   * local audio stream in the channel.
   *
   * @since v3.4.5
   */
  bool publishLocalAudio;
  /** Determines whether to publish the local video stream when the user joins a channel:
   * - true: (Default) Publish.
   * - false: Do not publish.
   *
   * This member serves a similar function to the `muteLocalVideoStream` method. After the user joins
   * the channel, you can call the `muteLocalVideoStream` method to set whether to publish the
   * local video stream in the channel.
   */
  bool publishLocalVideo;
  ChannelMediaOptions() : autoSubscribeAudio(true), autoSubscribeVideo(true), publishLocalAudio(true), publishLocalVideo(true) {}
};
/**
 * @since v3.5.0
 *
 * The IVideoSink class, which can set up a custom video renderer.
 *
 * During a real-time audio and video interaction, the Agora SDK enables the default renderer to render local and
 * remote video. The IVideoSink class can customize the video renderer. You can implement this interface first, and
 * then customize the video renderer that you want by calling
 * \ref IRtcEngine::setLocalVideoRenderer "setLocalVideoRenderer" or
 * \ref IRtcEngine::setRemoteVideoRenderer "setRemoteVideoRenderer".
 */
class IVideoSink {
 public:
  /**
   * Notification for initializing the custom video renderer.
   *
   * @since v3.5.0
   *
   * The SDK triggers this callback to remind you to initialize the custom video renderer.
   * After receiving this callback, you can do some preparation, and then use the return value to tell the SDK
   * whether the custom video renderer is prepared. The SDK takes the corresponding behavior based on the return value.
   *
   * @return
   * - true: The custom video renderer is initialized. The SDK is ready to send the video data to be rendered.
   * - false: The custom video renderer is not ready or fails to initialize. The SDK reports the error.
   */
  virtual bool onInitialize() = 0;
  /**
   * Notification for starting the custom video source.
   *
   * @since v3.5.0
   *
   * The SDK triggers this callback to remind you to start the custom video source for capturing video. After receiving
   * this callback, you can do some preparation, and then use the return value to tell the SDK whether the custom video
   * renderer is started. The SDK takes the corresponding behavior based on the return value.
   *
   * @return
   * - true: The custom video renderer is started. The SDK is ready to send the video data to be rendered to the custom video renderer for rendering.
   * - false: The custom video renderer is not ready or fails to initialize. The SDK stops and reports the error.
   */
  virtual bool onStart() = 0;
  /**
   * Notification for stopping rendering the video.
   *
   * @since v3.5.0
   *
   * The SDK triggers this callback to remind you to stop rendering the video. This callback informs you that the SDK
   * is about to stop sending video data to the custom video renderer.
   */
  virtual void onStop() = 0;
  /**
   * Notification for disabling the custom video renderer.
   *
   * @since v3.5.0
   *
   * The SDK triggers this callback to remind you to disable the custom video renderer.
   */
  virtual void onDispose() = 0;
  /**
   * Gets the video frame type.
   *
   * @since v3.5.0
   *
   * Before you initialize the custom video renderer, the SDK triggers this callback to query the data type of the
   * video frame that you want to process. You must specify the data type of the video frame in the return value of
   * this callback and then pass it to the SDK.
   *
   * @return \ref agora::media::ExternalVideoFrame::VIDEO_BUFFER_TYPE "VIDEO_BUFFER_TYPE"
   */
  virtual agora::media::ExternalVideoFrame::VIDEO_BUFFER_TYPE getBufferType() = 0;
  /**
   * Gets the video frame pixel format.
   *
   * @since v3.5.0
   *
   * Before you initialize the custom video renderer, the SDK triggers this callback to query the pixel format of the
   * video frame that you want to process. You must specify a pixel format for the video frame in the return value of
   * this callback and then pass it to the SDK.
   *
   * @return \ref agora::media::ExternalVideoFrame::VIDEO_PIXEL_FORMAT "VIDEO_PIXEL_FORMAT"
   */
  virtual agora::media::ExternalVideoFrame::VIDEO_PIXEL_FORMAT getPixelFormat() = 0;
#if (defined(__APPLE__) && TARGET_OS_IOS)
  /**
   * Notification for rendering the video in the pixel data type.
   *
   * @since v3.5.0
   *
   * The SDK triggers this callback after capturing video in the pixel data type to alter the custom video renderer
   * to process the video data.
   *
   * @note This method applies to iOS only.
   *
   * @param pixelBuffer The video data in the pixel data type.
   * @param rotation The clockwise rotation angle of the video.
   */
  virtual void onRenderPixelBuffer(CVPixelBufferRef pixelBuffer, int rotation) = 0;
#endif
  /**
   * Notification for rendering the video in the raw data type.
   *
   * @since v3.5.0
   *
   * The SDK triggers this callback after capturing video in the raw data type to alter the custom video renderer to
   * process the video data.
   *
   * @param rawData The video data in the raw data type.
   * @param width The width (px) of the video.
   * @param height The height (px) of the video.
   * @param rotation The clockwise rotation angle of the video.
   */
  virtual void onRenderRawData(uint8_t* rawData, int width, int height, int rotation) = 0;
};
/** IRtcEngine is the base interface class of the Agora SDK that provides the main Agora SDK methods
invoked by your application.
Enable the Agora SDK's communication functionality through the creation of an IRtcEngine object, then call the methods of this object.
 */
class IRtcEngine {
 protected:
  virtual ~IRtcEngine() {}

 public:
  /** Initializes the Agora service.
   *
   * Unless otherwise specified, all the methods provided by the IRtcEngine class are executed asynchronously. Agora recommends calling these methods in the same thread.
   *
   * @note Ensure that you call the
   * \ref agora::rtc::IRtcEngine::createAgoraRtcEngine
   * "createAgoraRtcEngine" and \ref agora::rtc::IRtcEngine::initialize
   * "initialize" methods before calling any other APIs.
   *
   * @param context Pointer to the RTC engine context. See RtcEngineContext.
   *
   * @return
   * - 0(ERR_OK): Success.
   * - < 0: Failure.
   *  - -1(ERR_FAILED): A general error occurs (no specified reason).
   *  - -2(ERR_INVALID_ARGUMENT): No `IRtcEngineEventHandler` object is specified.
   *  - -7(ERR_NOT_INITIALIZED): The SDK is not initialized. Check whether `context` is properly set.
   *  - -22(ERR_RESOURCE_LIMITED): The resource is limited. The app uses too much of the system resource and fails to allocate any resources.
   *  - -101(ERR_INVALID_APP_ID): The App ID is invalid.
   */
  virtual int initialize(const RtcEngineContext& context) = 0;

  /** Releases all IRtcEngine resources.
   *
   * Use this method for apps in which users occasionally make voice or video calls. When users do not make calls, you
   * can free up resources for other operations. Once you call `release` to destroy the created `IRtcEngine` instance,
   * you cannot use any method or callback in the SDK any more. If you want to use the real-time communication functions
   * again, you must call \ref createAgoraRtcEngine "createAgoraRtcEngine" and \ref agora::rtc::IRtcEngine::initialize "initialize"
   * to create a new `IRtcEngine` instance.
   *
   * @note If you want to create a new `IRtcEngine` instance after destroying the current one, ensure that you wait
   * till the `release` method completes executing.
   *
   * @param sync
   * - true: Synchronous call. Agora suggests calling this method in a sub-thread to avoid congestion in the main thread
   * because the synchronous call and the app cannot move on to another task until the execution completes.
   * Besides, you **cannot** call this method in any method or callback of the SDK. Otherwise, the SDK cannot release the
   * resources occupied by the `IRtcEngine` instance until the callbacks return results, which may result in a deadlock.
   * The SDK automatically detects the deadlock and converts this method into an asynchronous call, causing the test to
   * take additional time.
   * - false: Asynchronous call. Do not immediately uninstall the SDK's dynamic library after the call, or it may cause
   * a crash due to the SDK clean-up thread not quitting.
   */
  AGORA_CPP_API static void release(bool sync = false);

  /** Sets the channel profile of the Agora IRtcEngine.
   *
   * After initialization, the SDK uses the `CHANNEL_PROFILE_COMMUNICATION` channel profile by default.
   * You can call this method to set the channel profile. The Agora IRtcEngine differentiates channel profiles and
   * applies optimization algorithms accordingly.
   * For example, it prioritizes smoothness and low latency for a video call, and prioritizes video quality for the interactive live video streaming.
   *
   * @warning
   * - To ensure the quality of real-time communication, we recommend that all users in a channel use the same channel profile.
   * - Call this method before calling \ref IRtcEngine::joinChannel "joinChannel" . You cannot set the channel profile once you have joined the channel.
   * - The default audio route and video encoding bitrate are different in different channel profiles. For details, see
   * \ref IRtcEngine::setDefaultAudioRouteToSpeakerphone "setDefaultAudioRouteToSpeakerphone" and \ref IRtcEngine::setVideoEncoderConfiguration "setVideoEncoderConfiguration".
   *
   * @param profile The channel profile of the Agora IRtcEngine. See #CHANNEL_PROFILE_TYPE
   * @return
   * - 0(ERR_OK): Success.
   * - < 0: Failure.
   *  - -2 (ERR_INVALID_ARGUMENT): The parameter is invalid.
   *  - -7(ERR_NOT_INITIALIZED): The SDK is not initialized.
   */
  virtual int setChannelProfile(CHANNEL_PROFILE_TYPE profile) = 0;

  /** Sets the role of the user in interactive live streaming.
   *
   * After calling \ref IRtcEngine::setChannelProfile "setChannelProfile" (CHANNEL_PROFILE_LIVE_BROADCASTING), the
   * SDK sets the user role as audience by default. You can call `setClientRole` to set the user role as host.
   *
   * You can call this method either before or after joining a channel. If you call this method to switch the user role after joining a channel, the SDK automatically does the following:
   * - Calls \ref IRtcEngine::muteLocalAudioStream "muteLocalAudioStream" and \ref IRtcEngine::muteLocalVideoStream "muteLocalVideoStream" to
   * change the publishing state.
   * - Triggers \ref IRtcEngineEventHandler::onClientRoleChanged "onClientRoleChanged" or \ref IRtcEngineEventHandler::onClientRoleChangeFailed "onClientRoleChangeFailed" on the local client.
   * - Triggers \ref IRtcEngineEventHandler::onUserJoined "onUserJoined" or \ref IRtcEngineEventHandler::onUserOffline "onUserOffline" (BECOME_AUDIENCE)
   * on the remote client.
   *
   * @note This method applies to the `LIVE_BROADCASTING` profile only.
   *
   * @param role The role of a user in interactive live streaming. See #CLIENT_ROLE_TYPE.
   *
   * @return
   * - 0(ERR_OK): Success.
   * - < 0: Failure.
   *  - -1(ERR_FAILED): A general error occurs (no specified reason).
   *  - -2(ERR_INVALID_ARGUMENT): The parameter is invalid.
   *  - -5 (ERR_REFUSED): The request is rejected. In multichannel scenarios, if you have set any of the following in
   * one channel, the SDK returns this error code when the user switches the user role to host in another channel:
   *    - Call `joinChannel` with the `options` parameter and use the default settings `publishLocalAudio = true` or `publishLocalVideo = true`.
   *    - Call `setClientRole` to set the user role as host.
   *    - Call `muteLocalAudioStream(false)` or `muteLocalVideoStream(false)`.
   *  - -7(ERR_NOT_INITIALIZED): The SDK is not initialized.
   */
  virtual int setClientRole(CLIENT_ROLE_TYPE role) = 0;

  /** Sets the role of the user in interactive live streaming.
   *
   * @since v3.2.0
   *
   * In the `LIVE_BROADCASTING` channel profile, the
   * SDK sets the user role as audience by default. You can call `setClientRole` to set the user role as host.
   *
   * You can call this method either before or after joining a channel. If you
   * call this method to switch the user role after joining a channel, the SDK automatically does the following:
   * - Calls \ref IRtcEngine::muteLocalAudioStream "muteLocalAudioStream" and \ref IRtcEngine::muteLocalVideoStream "muteLocalVideoStream" to
   * change the publishing state.
   * - Triggers \ref IRtcEngineEventHandler::onClientRoleChanged "onClientRoleChanged" or \ref IRtcEngineEventHandler::onClientRoleChangeFailed "onClientRoleChangeFailed" on the local client.
   * - Triggers \ref IRtcEngineEventHandler::onUserJoined "onUserJoined" or \ref IRtcEngineEventHandler::onUserOffline "onUserOffline" (BECOME_AUDIENCE)
   * on the remote client.
   *
   * @note
   * - This method applies to the `LIVE_BROADCASTING` profile only.
   * - The difference between this method and \ref IRtcEngine::setClientRole(CLIENT_ROLE_TYPE) "setClientRole" [1/2] is that
   * this method can set the user level in addition to the user role.
   *  - The user role determines the permissions that the SDK grants to a user, such as permission to send local streams,
   * receive remote streams, and push streams to a CDN address.
   *  - The user level determines the level of services that a user can enjoy within the permissions of the user's role.
   * For example, an audience member can choose to receive remote streams with low latency or ultra low latency.
   * **User level affects the pricing of services.**
   *
   * @param role The role of a user in interactive live streaming. See #CLIENT_ROLE_TYPE.
   * @param options The detailed options of a user, including user level. See ClientRoleOptions.
   *
   * @return
   * - 0(ERR_OK): Success.
   * - < 0: Failure.
   *  - -1(ERR_FAILED): A general error occurs (no specified reason).
   *  - -2(ERR_INVALID_ARGUMENT): The parameter is invalid.
   *  - -5 (ERR_REFUSED): The request is rejected. In multichannel scenarios, if you have set any of the following in
   * one channel, the SDK returns this error code when the user switches the user role to host in another channel:
   *    - Call `joinChannel` with the `options` parameter and use the default settings `publishLocalAudio = true` or `publishLocalVideo = true`.
   *    - Call `setClientRole` to set the user role as host.
   *    - Call `muteLocalAudioStream(false)` or `muteLocalVideoStream(false)`.
   *  - -7(ERR_NOT_INITIALIZED): The SDK is not initialized.
   */
  virtual int setClientRole(CLIENT_ROLE_TYPE role, const ClientRoleOptions& options) = 0;

  /** Joins a channel with the user ID.

   Users in the same channel can talk to each other, and multiple users in the same channel can start a group chat. Users with different App IDs cannot call each other.


   You must call the \ref IRtcEngine::leaveChannel "leaveChannel" method to exit the current call before entering another channel.

   A successful \ref agora::rtc::IRtcEngine::joinChannel "joinChannel" method call triggers the following callbacks:
   - The local client: \ref agora::rtc::IRtcEngineEventHandler::onJoinChannelSuccess "onJoinChannelSuccess".
   - The remote client: \ref agora::rtc::IRtcEngineEventHandler::onUserJoined "onUserJoined" , if the user joining the channel is in the `COMMUNICATION` profile, or is a host in the `LIVE_BROADCASTING` profile.

   When the connection between the client and Agora's server is interrupted due to poor network conditions, the SDK tries reconnecting to the server. When the local client successfully rejoins the channel, the SDK triggers the \ref agora::rtc::IRtcEngineEventHandler::onRejoinChannelSuccess "onRejoinChannelSuccess" callback on the local client.

   Once the user joins the channel (switches to another channel), the user subscribes to the audio and video streams of all the other users in the channel by default, giving rise to usage and billing calculation. If you do not want to subscribe to a specified stream or all remote streams, call the `mute` methods accordingly.

   @note A channel does not accept duplicate uids, such as two users with the same @p uid. If you set @p uid as 0, the system automatically assigns a @p uid. If you want to join a channel from different devices, ensure that each device has a different uid.
   @warning Ensure that the App ID used for creating the token is the same App ID used by the \ref IRtcEngine::initialize "initialize" method for initializing the RTC engine. Otherwise, the CDN live streaming may fail.

   @param token The token generated at your server. See [Authenticate Your Users with Tokens](https://docs.agora.io/en/Interactive%20Broadcast/token_server?platform=All%20Platforms).
   @param channelId Pointer to the unique channel name for the Agora RTC session in the string format smaller than 64 bytes. Supported characters:
   - All lowercase English letters: a to z.
   - All uppercase English letters: A to Z.
   - All numeric characters: 0 to 9.
   - The space character.
   - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
   @param info (Optional) Pointer to additional information about the channel. This parameter can be set to NULL or contain channel related information. Other users in the channel will not receive this message.
   @param uid (Optional) User ID. A 32-bit unsigned integer with a value ranging from 1 to 2<sup>32</sup>-1. The @p uid must be unique. If a @p uid is not assigned (or set to 0), the SDK assigns and returns a @p uid in the \ref IRtcEngineEventHandler::onJoinChannelSuccess "onJoinChannelSuccess" callback. Your application must record and maintain the returned `uid`, because the SDK does not do so.

   @return
   - 0(ERR_OK): Success.
   - < 0: Failure.
      - -2(ERR_INVALID_ARGUMENT): The parameter is invalid.
      - -3(ERR_NOT_READY): The SDK fails to be initialized. You can try re-initializing the SDK.
      - -5(ERR_REFUSED): The request is rejected. This may be caused by the following:
          - You have created an IChannel object with the same channel name.
          - You have joined and published a stream in a channel created by the IChannel object. When you join a channel created by the IRtcEngine object, the SDK publishes the local audio and video streams to that channel by default. Because the SDK does not support publishing a local stream to more than one channel simultaneously, an error occurs in this occasion.
      - -7(ERR_NOT_INITIALIZED): The SDK is not initialized before calling this method.
      - -17(ERR_JOIN_CHANNEL_REJECTED): The request to join the channel is rejected. The SDK supports joining only one
      IRtcEngine channel at a time. Therefore, the SDK returns this error code when a user who has already joined an
      IRtcEngine channel calls the joining channel method of the IRtcEngine class with a valid channel name.
   */
  virtual int joinChannel(const char* token, const char* channelId, const char* info, uid_t uid) = 0;
  /** Joins a channel with the user ID, and configures whether to publish or automatically subscribe to the audio or video streams.
   *
   * @since v3.3.0
   *
   * Users in the same channel can talk to each other, and multiple users in the same channel can start a group chat. Users with different App IDs cannot call each other.
   *
   * You must call the \ref IRtcEngine::leaveChannel "leaveChannel" method to exit the current call before entering another channel.
   *
   * A successful \ref IRtcEngine::joinChannel "joinChannel" method call triggers the following callbacks:
   * - The local client: \ref IRtcEngineEventHandler::onJoinChannelSuccess "onJoinChannelSuccess".
   * - The remote client: \ref IRtcEngineEventHandler::onUserJoined "onUserJoined", if the user joining the channel is in the `COMMUNICATION` profile, or is a host in the `LIVE_BROADCASTING` profile.
   *
   * When the connection between the client and the Agora server is interrupted due to poor network conditions, the SDK tries reconnecting to the server.
   * When the local client successfully rejoins the channel, the SDK triggers the \ref IRtcEngineEventHandler::onRejoinChannelSuccess "onRejoinChannelSuccess" callback on the local client.
   *
   * @note
   * - Compared with \ref IRtcEngine::joinChannel(const char* token, const char* channelId, const char* info, uid_t uid) "joinChannel" [1/2], this method
   * has the `options` parameter, which configures whether the user publishes or automatically subscribes to the audio and video streams in the channel when
   * joining the channel. By default, the user publishes the local audio and video streams and automatically subscribes to the audio and video streams
   * of all the other users in the channel. Subscribing incurs all
   * associated usage costs. To unsubscribe, set the `options` parameter or call the `mute` methods accordingly.
   * - Ensure that the App ID used for generating the token is the same App ID used in the \ref IRtcEngine::initialize "initialize" method for
   * creating an `IRtcEngine` object.
   *
   * @param token The token generated at your server. See [Authenticate Your Users with Tokens](https://docs.agora.io/en/Interactive%20Broadcast/token_server?platform=All%20Platforms).
   * @param channelId Pointer to the unique channel name for the Agora RTC session in the string format smaller than 64 bytes. Supported characters:
   * - All lowercase English letters: a to z.
   * - All uppercase English letters: A to Z.
   * - All numeric characters: 0 to 9.
   * - The space character.
   * - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
   * @param info (Optional) Reserved for future use.
   * @param uid (Optional) User ID. A 32-bit unsigned integer with a value ranging from 1 to 2<sup>32</sup>-1. The @p uid must be unique. If a @p uid is
   * not assigned (or set to 0), the SDK assigns and returns a `uid` in the \ref IRtcEngineEventHandler::onJoinChannelSuccess "onJoinChannelSuccess" callback.
   * Your application must record and maintain the returned `uid`, because the SDK does not do so. **Note**: The ID of each user in the channel should be unique.
   * If you want to join the same channel from different devices, ensure that the user IDs in all devices are different.
   * @param options The channel media options: ChannelMediaOptions.
   @return
   * - 0(ERR_OK): Success.
   * - < 0: Failure.
   *    - -2(ERR_INVALID_ARGUMENT): The parameter is invalid.
   *    - -3(ERR_NOT_READY): The SDK fails to be initialized. You can try re-initializing the SDK.
   *    - -5(ERR_REFUSED): The request is rejected. This may be caused by the following:
   *        - You have created an IChannel object with the same channel name.
   *        - You have joined and published a stream in a channel created by the IChannel object. When you join a channel created by the IRtcEngine object, the SDK publishes the local audio and video streams to that channel by default. Because the SDK does not support publishing a local stream to more than one channel simultaneously, an error occurs in this occasion.
   *    - -7(ERR_NOT_INITIALIZED): The SDK is not initialized before calling this method.
   *    - -17(ERR_JOIN_CHANNEL_REJECTED): The request to join the channel is rejected. The SDK supports joining only one
   * IRtcEngine channel at a time. Therefore, the SDK returns this error code when a user who has already joined an
   * IRtcEngine channel calls the joining channel method of the IRtcEngine class with a valid channel name.
   */
  virtual int joinChannel(const char* token, const char* channelId, const char* info, uid_t uid, const ChannelMediaOptions& options) = 0;
  /** Switches to a different channel.
   *
   * This method allows the audience of a `LIVE_BROADCASTING` channel to switch
   * to a different channel.
   *
   * After the user successfully switches to another channel, the
   * \ref agora::rtc::IRtcEngineEventHandler::onLeaveChannel "onLeaveChannel"
   *  and \ref agora::rtc::IRtcEngineEventHandler::onJoinChannelSuccess
   * "onJoinChannelSuccess" callbacks are triggered to indicate that the
   * user has left the original channel and joined a new one.
   *
   * Once the user switches to another channel, the user subscribes to the
   * audio and video streams of all the other users in the channel by
   * default, giving rise to usage and billing calculation. If you do not
   * want to subscribe to a specified stream or all remote streams, call
   * the `mute` methods accordingly.
   *
   * @note
   * This method applies to the audience role in a `LIVE_BROADCASTING` channel
   * only.
   *
   * @param token The token generated at your server. See [Authenticate Your Users with Tokens](https://docs.agora.io/en/Interactive%20Broadcast/token_server?platform=All%20Platforms).
   * @param channelId Unique channel name for the AgoraRTC session in the
   * string format. The string length must be less than 64 bytes. Supported
   * character scopes are:
   * - All lowercase English letters: a to z.
   * - All uppercase English letters: A to Z.
   * - All numeric characters: 0 to 9.
   * - The space character.
   * - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
   *
   * @return
   * - 0(ERR_OK): Success.
   * - < 0: Failure.
   *  - -1(ERR_FAILED): A general error occurs (no specified reason).
   *  - -2(ERR_INVALID_ARGUMENT): The parameter is invalid.
   *  - -5(ERR_REFUSED): The request is rejected, probably because the user is not an audience.
   *  - -7(ERR_NOT_INITIALIZED): The SDK is not initialized.
   *  - -102(ERR_INVALID_CHANNEL_NAME): The channel name is invalid.
   *  - -113(ERR_NOT_IN_CHANNEL): The user is not in the channel.
   */
  virtual int switchChannel(const char* token, const char* channelId) = 0;
  /** Switches to a different channel, and configures whether to automatically subscribe to audio or video streams in the target channel.
   *
   * @since v3.3.0
   *
   * This method allows the audience of a `LIVE_BROADCASTING` channel to switch to a different channel.
   *
   * After the user successfully switches to another channel, the \ref IRtcEngineEventHandler::onLeaveChannel "onLeaveChannel"
   * and \ref IRtcEngineEventHandler::onJoinChannelSuccess "onJoinChannelSuccess" callbacks are triggered to indicate that
   * the user has left the original channel and joined a new one.
   *
   * @note
   * - This method applies to the audience role in a `LIVE_BROADCASTING` channel only.
   * - The difference between this method and \ref IRtcEngine::switchChannel(const char* token, const char* channelId) "switchChannel[1/2]"
   * is that the former adds the options parameter to configure whether the user automatically subscribes to all remote audio and video streams in the target channel.
   * By default, the user subscribes to the audio and video streams of all the other users in the target channel, thus incurring all associated usage costs.
   * To unsubscribe, set the `options` parameter or call the `mute` methods accordingly.
   *
   * @param token The token generated at your server. See [Authenticate Your Users with Tokens](https://docs.agora.io/en/Interactive%20Broadcast/token_server?platform=All%20Platforms).
   * @param channelId Unique channel name for the AgoraRTC session in the
   * string format. The string length must be less than 64 bytes. Supported
   * character scopes are:
   * - All lowercase English letters: a to z.
   * - All uppercase English letters: A to Z.
   * - All numeric characters: 0 to 9.
   * - The space character.
   * - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
   * @param options The channel media options: ChannelMediaOptions.
   *
   * @return
   * - 0(ERR_OK): Success.
   * - < 0: Failure.
   *  - -1(ERR_FAILED): A general error occurs (no specified reason).
   *  - -2(ERR_INVALID_ARGUMENT): The parameter is invalid.
   *  - -5(ERR_REFUSED): The request is rejected, probably because the user is not an audience.
   *  - -7(ERR_NOT_INITIALIZED): The SDK is not initialized.
   *  - -102(ERR_INVALID_CHANNEL_NAME): The channel name is invalid.
   *  - -113(ERR_NOT_IN_CHANNEL): The user is not in the channel.
   */
  virtual int switchChannel(const char* token, const char* channelId, const ChannelMediaOptions& options) = 0;

  /** Allows a user to leave a channel, such as hanging up or exiting a call.

   After joining a channel, the user must call the *leaveChannel* method to end the call before joining another channel.

   This method returns 0 if the user leaves the channel and releases all resources related to the call.

   This method call is asynchronous, and the user has not left the channel when the method call returns. Once the user leaves the channel, the SDK triggers the \ref IRtcEngineEventHandler::onLeaveChannel "onLeaveChannel" callback.

   A successful \ref agora::rtc::IRtcEngine::leaveChannel "leaveChannel" method call triggers the following callbacks:
   - The local client: \ref agora::rtc::IRtcEngineEventHandler::onLeaveChannel "onLeaveChannel"
   - The remote client: \ref agora::rtc::IRtcEngineEventHandler::onUserOffline "onUserOffline" , if the user leaving the channel is in the `COMMUNICATION` channel, or is a host in the `LIVE_BROADCASTING` profile.

   @note
   - If you call the \ref IRtcEngine::release "release" method immediately after the *leaveChannel* method, the *leaveChannel* process interrupts, and the \ref IRtcEngineEventHandler::onLeaveChannel "onLeaveChannel" callback is not triggered.
   - If you call the *leaveChannel* method during a CDN live streaming, the SDK triggers the \ref IRtcEngine::removePublishStreamUrl "removePublishStreamUrl" method.

   @return
   - 0(ERR_OK): Success.
   - < 0: Failure.
      - -1(ERR_FAILED): A general error occurs (no specified reason).
      - -2(ERR_INVALID_ARGUMENT): The parameter is invalid.
      - -7(ERR_NOT_INITIALIZED): The SDK is not initialized.
   */
  virtual int leaveChannel() = 0;

  /// @cond nodoc
  virtual int setAVSyncSource(const char* channelId, uid_t uid) = 0;
  /// @endcond

  /** Gets a new token when the current token expires after a period of time.

   The `token` expires after a period of time once the token schema is enabled when:

   - The SDK triggers the \ref IRtcEngineEventHandler::onTokenPrivilegeWillExpire "onTokenPrivilegeWillExpire" callback, or
   - The \ref IRtcEngineEventHandler::onConnectionStateChanged "onConnectionStateChanged" reports CONNECTION_CHANGED_TOKEN_EXPIRED(9).

   The application should call this method to get the new `token`. Failure to do so will result in the SDK disconnecting from the server.

   @param token The new token.

   @return
   - 0(ERR_OK): Success.
   - < 0: Failure.
      - -1(ERR_FAILED): A general error occurs (no specified reason).
      - -2(ERR_INVALID_ARGUMENT): The parameter is invalid.
      - -7(ERR_NOT_INITIALIZED): The SDK is not initialized.
   */
  virtual int renewToken(const char* token) = 0;

  /** Gets the pointer to the device manager object.

   @param iid ID of the interface.
   @param inter Pointer to the *DeviceManager* object.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int queryInterface(INTERFACE_ID_TYPE iid, void** inter) = 0;

  /** Registers a user account.

  Once registered, the user account can be used to identify the local user when the user joins the channel.
  After the user successfully registers a user account, the SDK triggers the \ref agora::rtc::IRtcEngineEventHandler::onLocalUserRegistered "onLocalUserRegistered" callback on the local client,
  reporting the user ID and user account of the local user.

  To join a channel with a user account, you can choose either of the following:

  - Call the \ref agora::rtc::IRtcEngine::registerLocalUserAccount "registerLocalUserAccount" method to create a user account, and then the \ref agora::rtc::IRtcEngine::joinChannelWithUserAccount "joinChannelWithUserAccount" method to join the channel.
  - Call the \ref agora::rtc::IRtcEngine::joinChannelWithUserAccount "joinChannelWithUserAccount" method to join the channel.

  The difference between the two is that for the former, the time elapsed between calling the \ref agora::rtc::IRtcEngine::joinChannelWithUserAccount "joinChannelWithUserAccount" method
  and joining the channel is shorter than the latter.

  @note
  - Ensure that you set the `userAccount` parameter. Otherwise, this method does not take effect.
  - Ensure that the value of the `userAccount` parameter is unique in the channel.
  - To ensure smooth communication, use the same parameter type to identify the user. For example, if a user joins the channel with a user ID, then ensure all the other users use the user ID too. The same applies to the user account. If a user joins the channel with the Agora Web SDK, ensure that the uid of the user is set to the same parameter type.

  @param appId The App ID of your project.
  @param userAccount The user account. The maximum length of this parameter is 255 bytes. Ensure that the user account is unique and do not set it as null. Supported character scopes are:
  - All lowercase English letters: a to z.
  - All uppercase English letters: A to Z.
  - All numeric characters: 0 to 9.
  - The space character.
  - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".

  @return
  - 0: Success.
  - < 0: Failure.
 */
  virtual int registerLocalUserAccount(const char* appId, const char* userAccount) = 0;
  /** Joins the channel with a user account.

   After the user successfully joins the channel, the SDK triggers the following callbacks:

   - The local client: \ref agora::rtc::IRtcEngineEventHandler::onLocalUserRegistered "onLocalUserRegistered" and \ref agora::rtc::IRtcEngineEventHandler::onJoinChannelSuccess "onJoinChannelSuccess" .
   - The remote client: \ref agora::rtc::IRtcEngineEventHandler::onUserJoined "onUserJoined" and \ref agora::rtc::IRtcEngineEventHandler::onUserInfoUpdated "onUserInfoUpdated" , if the user joining the channel is in the `COMMUNICATION` profile, or is a host in the `LIVE_BROADCASTING` profile.

   Once the user joins the channel (switches to another channel), the user subscribes to the audio and video streams of all the other users in the channel by default, giving rise to usage and billing calculation. If you do not want to subscribe to a specified stream or all remote streams, call the `mute` methods accordingly.

   @note
   - To ensure smooth communication, use the same parameter type to identify the user. For example, if a user joins the channel with a user ID, then ensure all the other users use the user ID too. The same applies to the user account.
   If a user joins the channel with the Agora Web SDK, ensure that the uid of the user is set to the same parameter type.
   - Before using a String user name, ensure that you read [How can I use string user names](https://docs.agora.io/en/faq/string) for getting details about the limitations and implementation steps.

   @param token The token generated at your server. See [Authenticate Your Users with Tokens](https://docs.agora.io/en/Interactive%20Broadcast/token_server?platform=All%20Platforms).
   @param channelId The channel name. The maximum length of this parameter is 64 bytes. Supported character scopes are:
   - All lowercase English letters: a to z.
   - All uppercase English letters: A to Z.
   - All numeric characters: 0 to 9.
   - The space character.
   - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
   @param userAccount The user account. The maximum length of this parameter is 255 bytes. Ensure that the user account is unique and do not set it as null. Supported character scopes are:
   - All lowercase English letters: a to z.
   - All uppercase English letters: A to Z.
   - All numeric characters: 0 to 9.
   - The space character.
   - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".

   @return
   - 0: Success.
   - < 0: Failure.
      - #ERR_INVALID_ARGUMENT (-2)
      - #ERR_NOT_READY (-3)
      - #ERR_REFUSED (-5)
      - #ERR_NOT_INITIALIZED (-7)
      - -17(ERR_JOIN_CHANNEL_REJECTED): The request to join the channel is rejected. The SDK supports joining only one
      IRtcEngine channel at a time. Therefore, the SDK returns this error code when a user who has already joined an
      IRtcEngine channel calls the joining channel method of the IRtcEngine class with a valid channel name.
   */
  virtual int joinChannelWithUserAccount(const char* token, const char* channelId, const char* userAccount) = 0;
  /** Joins the channel with a user account, and configures
   * whether to publish or automatically subscribe to the audio or video streams.
   *
   * @since v3.3.0
   *
   * After the user successfully joins the channel, the SDK triggers the following callbacks:
   * - The local client: \ref agora::rtc::IRtcEngineEventHandler::onLocalUserRegistered "onLocalUserRegistered" and \ref agora::rtc::IRtcEngineEventHandler::onJoinChannelSuccess "onJoinChannelSuccess" .
   * - The remote client: \ref agora::rtc::IRtcEngineEventHandler::onUserJoined "onUserJoined" and \ref agora::rtc::IRtcEngineEventHandler::onUserInfoUpdated "onUserInfoUpdated" , if the user joining the channel is in the `COMMUNICATION` profile, or is a host in the `LIVE_BROADCASTING` profile.
   *
   * @note
   * - Compared with \ref IRtcEngine::joinChannelWithUserAccount(const char* token, const char* channelId, const char* userAccount) "joinChannelWithUserAccount" [1/2],
   * this method has the options parameter, which configures whether the user publishes or automatically subscribes to the audio and video streams in the channel when
   * joining the channel. By default, the user publishes the local audio and video streams and automatically subscribes to the audio and video streams of all the other
   * users in the channel. Subscribing incurs all associated usage costs. To unsubscribe, set the `options` parameter or call the `mute` methods accordingly.
   * - To ensure smooth communication, use the same parameter type to identify the user. For example, if a user joins the channel with a user ID, then ensure all
   *  the other users use the user ID too. The same applies to the user account. If a user joins the channel with the Agora Web SDK, ensure that the
   * uid of the user is set to the same parameter type.
   * - Before using a String user name, ensure that you read [How can I use string user names](https://docs.agora.io/en/faq/string) for getting details about the limitations and implementation steps.
   *
   * @param token The token generated at your server. See [Authenticate Your Users with Tokens](https://docs.agora.io/en/Interactive%20Broadcast/token_server?platform=All%20Platforms).
   * @param channelId The channel name. The maximum length of this parameter is 64 bytes. Supported character scopes are:
   * - All lowercase English letters: a to z.
   * - All uppercase English letters: A to Z.
   * - All numeric characters: 0 to 9.
   * - The space character.
   * - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
   * @param userAccount The user account. The maximum length of this parameter is 255 bytes. Ensure that the user account is unique and do not set it as null. Supported character scopes are:
   * - All lowercase English letters: a to z.
   * - All uppercase English letters: A to Z.
   * - All numeric characters: 0 to 9.
   * - The space character.
   * - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
   * @param options The channel media options: ChannelMediaOptions.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *    - #ERR_INVALID_ARGUMENT (-2)
   *    - #ERR_NOT_READY (-3)
   *    - #ERR_REFUSED (-5)
   *    - -17(ERR_JOIN_CHANNEL_REJECTED): The request to join the channel is rejected. The SDK supports joining only one
   * IRtcEngine channel at a time. Therefore, the SDK returns this error code when a user who has already joined an
   * IRtcEngine channel calls the joining channel method of the IRtcEngine class with a valid channel name.
   */
  virtual int joinChannelWithUserAccount(const char* token, const char* channelId, const char* userAccount, const ChannelMediaOptions& options) = 0;

  /** Gets the user information by passing in the user account.

   After a remote user joins the channel, the SDK gets the user ID and user account of the remote user, caches them
   in a mapping table object (`userInfo`), and triggers the \ref agora::rtc::IRtcEngineEventHandler::onUserInfoUpdated "onUserInfoUpdated" callback on the local client.

   After receiving the o\ref agora::rtc::IRtcEngineEventHandler::onUserInfoUpdated "onUserInfoUpdated" callback, you can call this method to get the user ID of the
   remote user from the `userInfo` object by passing in the user account.

   @param userAccount The user account of the user. Ensure that you set this parameter.
   @param [in,out] userInfo  A userInfo object that identifies the user:
   - Input: A userInfo object.
   - Output: A userInfo object that contains the user account and user ID of the user.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int getUserInfoByUserAccount(const char* userAccount, UserInfo* userInfo) = 0;
  /** Gets the user information by passing in the user ID.

   After a remote user joins the channel, the SDK gets the user ID and user account of the remote user,
   caches them in a mapping table object (`userInfo`), and triggers the \ref agora::rtc::IRtcEngineEventHandler::onUserInfoUpdated "onUserInfoUpdated" callback on the local client.

   After receiving the \ref agora::rtc::IRtcEngineEventHandler::onUserInfoUpdated "onUserInfoUpdated" callback, you can call this method to get the user account of the remote user
   from the `userInfo` object by passing in the user ID.

   @param uid The user ID of the remote user. Ensure that you set this parameter.
   @param[in,out] userInfo A userInfo object that identifies the user:
   - Input: A userInfo object.
   - Output: A userInfo object that contains the user account and user ID of the user.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int getUserInfoByUid(uid_t uid, UserInfo* userInfo) = 0;

  /** **DEPRECATED** Starts an audio call test.

   This method is deprecated as of v2.4.0.

   This method starts an audio call test to check whether the audio devices (for example, headset and speaker) and the network connection are working properly.

   To conduct the test:

   - The user speaks and the recording is played back within 10 seconds.
   - If the user can hear the recording within 10 seconds, the audio devices and network connection are working properly.

   @note
   - After calling this method, always call the \ref IRtcEngine::stopEchoTest "stopEchoTest" method to end the test. Otherwise, the application cannot run the next echo test.
   - In the `LIVE_BROADCASTING` profile, only the hosts can call this method. If the user switches from the `COMMUNICATION` to`LIVE_BROADCASTING` profile, the user must call the \ref IRtcEngine::setClientRole "setClientRole" method to change the user role from the audience (default) to the host before calling this method.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int startEchoTest() = 0;

  /** Starts an audio call test.

  This method starts an audio call test to determine whether the audio devices (for example, headset and speaker) and the network connection are working properly.

  In the audio call test, you record your voice. If the recording plays back within the set time interval, the audio devices and the network connection are working properly.

  @note
  - Call this method before joining a channel.
  - After calling this method, call the \ref IRtcEngine::stopEchoTest "stopEchoTest" method to end the test. Otherwise, the app cannot run the next echo test, or call the \ref IRtcEngine::joinChannel "joinChannel" method.
  - In the `LIVE_BROADCASTING` profile, only a host can call this method.
  @param intervalInSeconds The time interval (s) between when you speak and when the recording plays back.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int startEchoTest(int intervalInSeconds) = 0;

  /** Starts an audio and video call loop test.
   *
   * @since v3.5.2
   *
   * Before joining a channel, to test whether the user's local sending and receiving streams are normal, you can call
   * this method to perform an audio and video call loop test, which tests whether the audio and video devices and the
   * user's upstream and downstream networks are working properly.
   *
   * After starting the test, the user needs to make a sound or face the camera. The audio or video is output after
   * about two seconds. If the audio playback is normal, the audio device and the user's upstream and downstream
   * networks are working properly; if the video playback is normal, the video device and the user's upstream and
   * downstream networks are working properly.
   *
   * @note
   * - Call this method before joining a channel.
   * - After calling this method, call \ref IRtcEngine::stopEchoTest "stopEchoTest" to end the test; otherwise, the
   * user cannot perform the next audio and video call loop test and cannot join the channel.
   * - In the `LIVE_BROADCASTING` profile, only a host can call this method.
   *
   * @param config The configuration of the audio and video call loop test. See EchoTestConfiguration.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int startEchoTest(const EchoTestConfiguration& config) = 0;

  /** Stops call loop test.
   *
   * After calling `startEchoTest [2/3]` or `startEchoTest [3/3]`, call this method if you want to stop the call loop test.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int stopEchoTest() = 0;

  /** Sets the Agora cloud proxy service.
   *
   * @since v3.3.0
   *
   * When users' network access is restricted by a firewall, configure the firewall to allow specific IP addresses and ports provided by Agora; then, call this method to enable the cloud proxy and set the cloud proxy type with the `proxyType` parameter.
   *
   * After a successfully cloud proxy connection, the SDK triggers
   * the \ref IRtcEngineEventHandler::onConnectionStateChanged "onConnectionStateChanged" (CONNECTION_STATE_CONNECTING, CONNECTION_CHANGED_SETTING_PROXY_SERVER) callback.
   *
   * As of v3.6.2, when a user calls this method and then joins a channel successfully, the SDK triggers the \ref IRtcEngineEventHandler::onProxyConnected "onProxyConnected" callback to report the user ID, the proxy type connected, and the time elapsed from the user calling \ref IRtcEngine::joinChannel "joinChannel" until this callback is triggered.
   *
   * To disable the cloud proxy that has been set, call `setCloudProxy(NONE_PROXY)`. To change the cloud proxy type that has been set,
   * call `setCloudProxy(NONE_PROXY)` first, and then call `setCloudProxy` with the desired `proxyType`.
   *
   * @note
   * - Agora recommends that you call this method before joining the channel or after leaving the channel.
   * - For the SDK v3.3.x, when users use the Force UDP cloud proxy, the services for Media Push and cohosting across channels are not available; for the SDK v3.4.0 or later, when users behind a firewall use the Force UDP cloud proxy, the services for Media Push and cohosting across channels are not available.
   * - When you use the Force TCP cloud proxy, note the following:
   *    - An error occurs when calling \ref IRtcEngine::startAudioMixing "startAudioMixing" to play online music files in the HTTP protocol.
   *    - The services for Media Push and cohosting across channels use the cloud proxy with the TCP protocol.
   *
   * @param proxyType The cloud proxy type, see #CLOUD_PROXY_TYPE. This parameter is required, and the SDK reports an error if you do not pass in a value.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *  - `-2(ERR_INVALID_ARGUMENT)`: The parameter is invalid.
   *  - `-7(ERR_NOT_INITIALIZED)`: The SDK is not initialized.
   */
  virtual int setCloudProxy(CLOUD_PROXY_TYPE proxyType) = 0;
  /** Enables the video module.
   *
   * Call this method either before joining a channel or during a call. If this method is called before joining a channel, the call starts in the video mode. If this method is called during an audio call, the audio mode switches to the video mode. To disable the video module, call the \ref IRtcEngine::disableVideo "disableVideo" method.
   *
   * A successful \ref agora::rtc::IRtcEngine::enableVideo "enableVideo" method call triggers the \ref agora::rtc::IRtcEngineEventHandler::onUserEnableVideo "onUserEnableVideo" (true) callback on the remote client.
   * @note
   * - This method affects the internal engine and can be called after the \ref agora::rtc::IRtcEngine::leaveChannel "leaveChannel" method.
   * - This method resets the internal engine and takes some time to take effect. We recommend using the following API methods to control the video engine modules separately:
   *     - \ref IRtcEngine::enableLocalVideo "enableLocalVideo": Whether to enable the camera to create the local video stream.
   *     - \ref IRtcEngine::muteLocalVideoStream "muteLocalVideoStream": Whether to publish the local video stream.
   *     - \ref IRtcEngine::muteRemoteVideoStream "muteRemoteVideoStream": Whether to subscribe to and play the remote video stream.
   *     - \ref IRtcEngine::muteAllRemoteVideoStreams "muteAllRemoteVideoStreams": Whether to subscribe to and play all remote video streams.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int enableVideo() = 0;

  /** Disables the video module.
   *
   * This method can be called before joining a channel or during a call. If this method is called before joining a
   * channel, the call starts in audio mode. If this method is called during a video call, the video mode switches to
   * the audio mode. To enable the video module, call the \ref IRtcEngine::enableVideo "enableVideo" method.
   *
   * A successful \ref agora::rtc::IRtcEngine::disableVideo "disableVideo" method call triggers
   * the \ref agora::rtc::IRtcEngineEventHandler::onUserEnableVideo "onUserEnableVideo" (false) callback on the remote
   * client.
   *
   * @note
   * - This method affects the internal engine and can be called after
   * the \ref agora::rtc::IRtcEngine::leaveChannel "leaveChannel" method.
   * - This method resets the internal engine and takes some time to take effect. We recommend using the following
   * APIs to control the video engine modules separately:
   *     - \ref IRtcEngine::enableLocalVideo "enableLocalVideo": Whether to enable the camera to create the local video stream.
   *     - \ref IRtcEngine::muteLocalVideoStream "muteLocalVideoStream": Whether to publish the local video stream.
   *     - \ref IRtcEngine::muteRemoteVideoStream "muteRemoteVideoStream": Whether to subscribe to and play the remote video stream.
   *     - \ref IRtcEngine::muteAllRemoteVideoStreams "muteAllRemoteVideoStreams": Whether to subscribe to and play all remote video streams.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int disableVideo() = 0;

  /** Sets the video profile.

   @deprecated This method is deprecated as of v2.3. Use the \ref IRtcEngine::setVideoEncoderConfiguration "setVideoEncoderConfiguration" method instead.

   Each video profile includes a set of parameters, such as the resolution, frame rate, and bitrate. If the camera device does not support the specified resolution, the SDK automatically chooses a suitable camera resolution, keeping the encoder resolution specified by the *setVideoProfile* method.

   @note
   - You can call this method either before or after joining a channel.
   - If you do not need to set the video profile after joining the channel, call this method before the \ref IRtcEngine::enableVideo "enableVideo" method to reduce the render time of the first video frame.
   - Always set the video profile before calling the \ref IRtcEngine::joinChannel "joinChannel" or \ref IRtcEngine::startPreview "startPreview" method.

   @param profile Sets the video profile. See #VIDEO_PROFILE_TYPE.
   @param swapWidthAndHeight Sets whether to swap the width and height of the video stream:
   - true: Swap the width and height.
   - false: (Default) Do not swap the width and height.
   The width and height of the output video are consistent with the set video profile.
   @note Since the landscape or portrait mode of the output video can be decided directly by the video profile, We recommend setting *swapWidthAndHeight* to *false* (default).

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setVideoProfile(VIDEO_PROFILE_TYPE profile, bool swapWidthAndHeight) AGORA_DEPRECATED_ATTRIBUTE = 0;

  /** Sets the video encoder configuration.

   Each video encoder configuration corresponds to a set of video parameters, including the resolution, frame rate, bitrate, and video orientation.

   The parameters specified in this method are the maximum values under ideal network conditions. If the video engine cannot render the video using the specified parameters due to poor network conditions, the parameters further down the list are considered until a successful configuration is found.

   @note
   - You can call this method either before or after joining a channel.
   - If you do not need to set the video encoder configuration after joining the channel, you can call this method before the \ref IRtcEngine::enableVideo "enableVideo" method to reduce the render time of the first video frame.

   @param config Sets the local video encoder configuration. See VideoEncoderConfiguration.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setVideoEncoderConfiguration(const VideoEncoderConfiguration& config) = 0;
  /** Sets the camera capture configuration.

   For a video call or the interactive live video streaming, generally the SDK controls the camera output parameters. When the default camera capturer settings do not meet special requirements or cause performance problems, we recommend using this method to set the camera capturer configuration:

   - If the resolution or frame rate of the captured raw video data are higher than those set by \ref IRtcEngine::setVideoEncoderConfiguration "setVideoEncoderConfiguration", processing video frames requires extra CPU and RAM usage and degrades performance. We recommend setting config as #CAPTURER_OUTPUT_PREFERENCE_PERFORMANCE (1) to avoid such problems.
   - If you do not need local video preview or are willing to sacrifice preview quality, we recommend setting config as #CAPTURER_OUTPUT_PREFERENCE_PERFORMANCE (1) to optimize CPU and RAM usage.
   - If you want better quality for the local video preview, we recommend setting config as #CAPTURER_OUTPUT_PREFERENCE_PREVIEW (2).
   - To customize the width and height of the video image captured by the local camera, set the camera capture configuration as #CAPTURER_OUTPUT_PREFERENCE_MANUAL (3).

   @note Call this method before enabling the local camera. That said, you can call this method before calling \ref agora::rtc::IRtcEngine::joinChannel "joinChannel", \ref agora::rtc::IRtcEngine::enableVideo "enableVideo", or \ref IRtcEngine::enableLocalVideo "enableLocalVideo", depending on which method you use to turn on your local camera.

   @param config Sets the camera capturer configuration. See CameraCapturerConfiguration.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setCameraCapturerConfiguration(const CameraCapturerConfiguration& config) = 0;

  /** Initializes the local video view.

   This method initializes the video view of a local stream on the local device. It affects only the video view that the local user sees, not the published local video stream.

   Call this method to bind the local video stream to a video view and to set the rendering and mirror modes of the video view.
   The binding is still valid after the user leaves the channel, which means that the window still displays. To unbind the view, set the *view* in VideoCanvas to NULL.

   @note
   - You can call this method either before or after joining a channel.
   - During a call, you can call this method as many times as necessary to update the display mode of the local video view.

   @param canvas Pointer to the local video view and settings. See VideoCanvas.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setupLocalVideo(const VideoCanvas& canvas) = 0;

  /** Initializes the video view of a remote user.

   This method initializes the video view of a remote stream on the local device. It affects only the video view that the local user sees.

   Call this method to bind the remote video stream to a video view and to set the rendering and mirror modes of the video view.

   The application specifies the uid of the remote video in this method before the remote user joins the channel. If the remote uid is unknown to the application, set it after the application receives the \ref IRtcEngineEventHandler::onUserJoined "onUserJoined" callback.
   If the Video Recording function is enabled, the Video Recording Service joins the channel as a dummy client, causing other clients to also receive the \ref IRtcEngineEventHandler::onUserJoined "onUserJoined" callback. Do not bind the dummy client to the application view because the dummy client does not send any video streams. If your application does not recognize the dummy client, bind the remote user to the view when the SDK triggers the \ref IRtcEngineEventHandler::onFirstRemoteVideoDecoded "onFirstRemoteVideoDecoded" callback.
   To unbind the remote user from the view, set the view in VideoCanvas to NULL. Once the remote user leaves the channel, the SDK unbinds the remote user.

   @note To update the rendering or mirror mode of the remote video view during a call, use the \ref IRtcEngine::setRemoteRenderMode "setRemoteRenderMode" method.

   @param canvas Pointer to the remote video view and settings. See VideoCanvas.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setupRemoteVideo(const VideoCanvas& canvas) = 0;

  /** Starts the local video preview before joining the channel.

   Before calling this method, you must:

   - Call the \ref IRtcEngine::setupLocalVideo "setupLocalVideo" method to set up the local preview window and configure the attributes.
   - Call the \ref IRtcEngine::enableVideo "enableVideo" method to enable video.

   @note Once the startPreview method is called to start the local video preview, if you leave the channel by calling the \ref IRtcEngine::leaveChannel "leaveChannel" method, the local video preview remains until you call the \ref IRtcEngine::stopPreview "stopPreview" method to disable it.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int startPreview() = 0;

  /** Prioritizes a remote user's stream.
   *
   * The SDK ensures the high-priority user gets the best possible stream quality.
   *
   * @note
   * - The Agora SDK supports setting @p userPriority as high for one user only.
   * - Ensure that you call this method before joining a channel.
   *
   * @param  uid  The ID of the remote user.
   * @param  userPriority Sets the priority of the remote user. See #PRIORITY_TYPE.
   *
   *  @return
   *  - 0: Success.
   *  - < 0: Failure.
   */
  virtual int setRemoteUserPriority(uid_t uid, PRIORITY_TYPE userPriority) = 0;

  /** Stops the local video preview.
   *
   * After calling \ref IRtcEngine::startPreview "startPreview", if you want to stop
   * the local video preview, call `stopPreview`.
   *
   * @note Call this method before you join the channel or after you leave the channel.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int stopPreview() = 0;

  /** Enables the audio module.

  The audio mode is enabled by default.

   @note
   - This method affects the audio module and can be called after the \ref agora::rtc::IRtcEngine::leaveChannel "leaveChannel" method. You can call this method either before or after joining a channel.
   - This method enables the audio module and takes some time to take effect. Agora recommends using the following API methods to control the audio module separately:
       - \ref IRtcEngine::enableLocalAudio "enableLocalAudio": Whether to enable the microphone to create the local audio stream.
       - \ref IRtcEngine::muteLocalAudioStream "muteLocalAudioStream": Whether to publish the local audio stream.
       - \ref IRtcEngine::muteRemoteAudioStream "muteRemoteAudioStream": Whether to subscribe to and play the remote audio stream.
       - \ref IRtcEngine::muteAllRemoteAudioStreams "muteAllRemoteAudioStreams": Whether to subscribe to and play all remote audio streams.

  @return
  - 0: Success.
  - < 0: Failure.
  */
  virtual int enableAudio() = 0;

  /** Disables/Re-enables the local audio function.
   *
   * The audio function is enabled by default. This method disables or re-enables the local audio function, that is, to stop or restart local audio capturing.
   *
   * This method does not affect receiving the remote audio streams,and enableLocalAudio(false) is applicable to scenarios where the user wants to
   * receive remote audio streams without sending any audio stream to other users in the channel.
   *
   * Once the local audio function is disabled or re-enabled, the SDK triggers the \ref agora::rtc::IRtcEngineEventHandler::onLocalAudioStateChanged "onLocalAudioStateChanged" callback,
   * which reports `LOCAL_AUDIO_STREAM_STATE_STOPPED(0)` or `LOCAL_AUDIO_STREAM_STATE_RECORDING(1)`.
   *
   * @note
   * - This method is different from the \ref agora::rtc::IRtcEngine::muteLocalAudioStream "muteLocalAudioStream" method:
   *    - \ref agora::rtc::IRtcEngine::enableLocalAudio "enableLocalAudio": Disables/Re-enables the local audio capturing and processing.
   *    If you disable or re-enable local audio capturing using the `enableLocalAudio` method, the local user may hear a pause in the remote audio playback.
   *    - \ref agora::rtc::IRtcEngine::muteLocalAudioStream "muteLocalAudioStream": Sends/Stops sending the local audio streams.
   * - This method can be called either before or after you join a channel. Calling it before you
   * join a channel can set the device state only, and it takes effect immediately after you join the
   * channel.
   *
   * @param enabled Sets whether to disable/re-enable the local audio function:
   * - true: (Default) Re-enable the local audio function, that is, to start the local audio capturing device (for example, the microphone).
   * - false: Disable the local audio function, that is, to stop local audio capturing.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int enableLocalAudio(bool enabled) = 0;

  /** Disables the audio module.

   @note
   - This method affects the internal engine and can be called after the \ref agora::rtc::IRtcEngine::leaveChannel "leaveChannel" method. You can call this method either before or after joining a channel.
   - This method resets the internal engine and takes some time to take effect. We recommend using the \ref agora::rtc::IRtcEngine::enableLocalAudio "enableLocalAudio" and \ref agora::rtc::IRtcEngine::muteLocalAudioStream "muteLocalAudioStream" methods to capture, process, and send the local audio streams.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int disableAudio() = 0;

  /** Sets the audio parameters and application scenarios.

   @note
   - The `setAudioProfile` method must be called before the \ref IRtcEngine::joinChannel "joinChannel" method.
   - In the `COMMUNICATION` and `LIVE_BROADCASTING` profiles, the bitrate may be different from your settings due to network self-adaptation.
   - In scenarios requiring high-quality audio, for example, a music teaching scenario, we recommend setting profile as AUDIO_PROFILE_MUSIC_HIGH_QUALITY (4) and  scenario as AUDIO_SCENARIO_GAME_STREAMING (3).

   @param profile Sets the sample rate, bitrate, encoding mode, and the number of channels. See #AUDIO_PROFILE_TYPE.
   @param scenario Sets the audio application scenario. See #AUDIO_SCENARIO_TYPE.
   Under different audio scenarios, the device uses different volume types. For details, see
   [What is the difference between the in-call volume and the media volume?](https://docs.agora.io/en/faq/system_volume).

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setAudioProfile(AUDIO_PROFILE_TYPE profile, AUDIO_SCENARIO_TYPE scenario) = 0;
  /**
   * Stops or resumes publishing the local audio stream.
   *
   * As of v3.4.5, this method only sets the publishing state of the audio stream in the channel of IRtcEngine.
   *
   * A successful method call triggers the \ref IRtcEngineEventHandler::onUserMuteAudio "onUserMuteAudio" callback
   * on the remote client.
   *
   * You can only publish the local stream in one channel at a time. If you create multiple channels, ensure that
   * you only call \ref IRtcEngine::muteLocalAudioStream "muteLocalAudioStream" (false) in one channel;
   * otherwise, the method call fails, and the SDK returns `-5 (ERR_REFUSED)`.
   *
   * @note
   * - This method does not change the usage state of the audio-capturing device.
   * - Whether this method call takes effect is affected by the
   * \ref IRtcEngine::joinChannel(const char* token, const char* channelId, const char* info, uid_t uid, const ChannelMediaOptions& options) "joinChannel" [2/2]
   * and \ref IRtcEngine::setClientRole "setClientRole" methods. For details, see *Set the Publishing State*.
   *
   * @param mute Sets whether to stop publishing the local audio stream.
   * - true: Stop publishing the local audio stream.
   * - false: Resume publishing the local audio stream.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *  - `-5 (ERR_REFUSED)`: The request is rejected.
   */
  virtual int muteLocalAudioStream(bool mute) = 0;
  /**
   * Stops or resumes subscribing to the audio streams of all remote users.
   *
   * After successfully calling this method, the local user stops or resumes
   * subscribing to the audio streams of all remote users, including all subsequent users.
   *
   * @note
   * - Call this method after joining a channel.
   * - As of v3.3.0, this method contains the function of \ref IRtcEngine::setDefaultMuteAllRemoteAudioStreams "setDefaultMuteAllRemoteAudioStreams".
   * Agora recommends not calling `muteAllRemoteAudioStreams` and `setDefaultMuteAllRemoteAudioStreams`
   * together; otherwise, the settings may not take effect. See *Set the Subscribing State*.
   *
   * @param mute Sets whether to stop subscribing to the audio streams of all remote users.
   * - true: Stop subscribing to the audio streams of all remote users.
   * - false: (Default) Resume subscribing to the audio streams of all remote users.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int muteAllRemoteAudioStreams(bool mute) = 0;
  /** Stops or resumes subscribing to the audio streams of all remote users by default.
   *
   * @deprecated This method is deprecated from v3.3.0.
   *
   *
   * Call this method after joining a channel. After successfully calling this method, the
   * local user stops or resumes subscribing to the audio streams of all subsequent users.
   *
   * @note If you need to resume subscribing to the audio streams of remote users in the
   * channel after calling \ref IRtcEngine::setDefaultMuteAllRemoteAudioStreams "setDefaultMuteAllRemoteAudioStreams" (true), do the following:
   * - If you need to resume subscribing to the audio stream of a specified user, call \ref IRtcEngine::muteRemoteAudioStream "muteRemoteAudioStream" (false), and specify the user ID.
   * - If you need to resume subscribing to the audio streams of multiple remote users, call \ref IRtcEngine::muteRemoteAudioStream "muteRemoteAudioStream" (false) multiple times.
   *
   * @param mute Sets whether to stop subscribing to the audio streams of all remote users by default.
   * - true: Stop subscribing to the audio streams of all remote users by default.
   * - false: (Default) Resume subscribing to the audio streams of all remote users by default.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setDefaultMuteAllRemoteAudioStreams(bool mute) AGORA_DEPRECATED_ATTRIBUTE = 0;

  /** Adjusts the playback signal volume of a specified remote user.
   *
   * You can call this method as many times as necessary to adjust the playback volume of different remote users, or to repeatedly adjust the playback volume of the same remote user.
   *
   * @note
   * - Call this method after joining a channel.
   * - The playback volume here refers to the mixed volume of a specified remote user.
   * - This method can only adjust the playback volume of one specified remote user at a time. To adjust the playback volume of different remote users, call the method as many times, once for each remote user.
   *
   * @param uid The ID of the remote user.
   * @param volume The playback volume of the specified remote user. The value
   * ranges between 0 and 100, including the following:
   * - 0: Mute.
   * - 100: (Default) Original volume.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int adjustUserPlaybackSignalVolume(unsigned int uid, int volume) = 0;
  /**
   * Stops or resumes subscribing to the audio stream of a specified user.
   *
   * @note
   * - Call this method after joining a channel.
   * - See recommended settings in *Set the Subscribing State*.
   *
   * @param userId The user ID of the specified remote user.
   * @param mute Sets whether to stop subscribing to the audio stream of a specified user.
   * - true: Stop subscribing to the audio stream of a specified user.
   * - false: (Default) Resume subscribing to the audio stream of a specified user.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int muteRemoteAudioStream(uid_t userId, bool mute) = 0;
  /** Stops or resumes publishing the local video stream.
   *
   * As of v3.4.5, this method only sets the publishing state of the video stream in the channel of IRtcEngine.
   *
   * A successful method call triggers the \ref IRtcEngineEventHandler::onUserMuteVideo "onUserMuteVideo"
   * callback on the remote client.
   *
   * You can only publish the local stream in one channel at a time. If you create multiple channels,
   * ensure that you only call \ref IRtcEngine::muteLocalVideoStream "muteLocalVideoStream" (false) in one channel;
   * otherwise, the method call fails, and the SDK returns `-5 (ERR_REFUSED)`.
   *
   * @note
   * - This method does not change the usage state of the video-capturing device.
   * - Whether this method call takes effect is affected by the
   * \ref IRtcEngine::joinChannel(const char* token, const char* channelId, const char* info, uid_t uid, const ChannelMediaOptions& options) "joinChannel" [2/2]
   * and \ref IRtcEngine::setClientRole "setClientRole" methods. For details, see *Set the Publishing State*.
   *
   * @param mute Sets whether to stop publishing the local video stream.
   * - true: Stop publishing the local video stream.
   * - false: Resume publishing the local video stream.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *  - `-5 (ERR_REFUSED)`: The request is rejected.
   */
  virtual int muteLocalVideoStream(bool mute) = 0;
  /** Enables/Disables the local video capture.

   This method disables or re-enables the local video capturer, and does not affect receiving the remote video stream.

   After you call the \ref agora::rtc::IRtcEngine::enableVideo "enableVideo" method, the local video capturer is enabled by default. You can call \ref agora::rtc::IRtcEngine::enableLocalVideo "enableLocalVideo(false)" to disable the local video capturer. If you want to re-enable it, call \ref agora::rtc::IRtcEngine::enableLocalVideo "enableLocalVideo(true)".

   After the local video capturer is successfully disabled or re-enabled, the SDK triggers the \ref agora::rtc::IRtcEngineEventHandler::onUserEnableLocalVideo "onUserEnableLocalVideo" callback on the remote client.

   @note
   - You can call this method either before or after joining a channel.
   - This method affects the internal engine and can be called after the \ref agora::rtc::IRtcEngine::leaveChannel "leaveChannel" method.

   @param enabled Sets whether to disable/re-enable the local video, including the capturer, renderer, and sender:
   - true: (Default) Re-enable the local video.
   - false: Disable the local video. Once the local video is disabled, the remote users can no longer receive the video stream of this user, while this user can still receive the video streams of the other remote users.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int enableLocalVideo(bool enabled) = 0;
  /**
   * Stops or resumes subscribing to the video streams of all remote users.
   *
   * After successfully calling this method, the local user stops or resumes
   * subscribing to the video streams of all remote users, including all subsequent users.
   *
   * @note
   * - Call this method after joining a channel.
   * - See recommended settings in *Set the Subscribing State*.
   *
   * @param mute Sets whether to stop subscribing to the video streams of all remote users.
   * - true: Stop subscribing to the video streams of all remote users.
   * - false: (Default) Resume subscribing to the video streams of all remote users.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int muteAllRemoteVideoStreams(bool mute) = 0;
  /** Stops or resumes subscribing to the video streams of all remote users by default.
   *
   * @deprecated This method is deprecated from v3.3.0.
   *
   * Call this method after joining a channel. After successfully calling this method, the
   * local user stops or resumes subscribing to the video streams of all subsequent users.
   *
   * @note If you need to resume subscribing to the video streams of remote users in the
   * channel after calling \ref IRtcEngine::setDefaultMuteAllRemoteVideoStreams "setDefaultMuteAllRemoteVideoStreams" (true), do the following:
   * - If you need to resume subscribing to the video stream of a specified user, call \ref IRtcEngine::muteRemoteVideoStream "muteRemoteVideoStream" (false), and specify the user ID.
   * - If you need to resume subscribing to the video streams of multiple remote users, call \ref IRtcEngine::muteRemoteVideoStream "muteRemoteVideoStream" (false) multiple times.
   *
   * @param mute Sets whether to stop subscribing to the video streams of all remote users by default.
   * - true: Stop subscribing to the video streams of all remote users by default.
   * - false: (Default) Resume subscribing to the video streams of all remote users by default.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setDefaultMuteAllRemoteVideoStreams(bool mute) AGORA_DEPRECATED_ATTRIBUTE = 0;
  /**
   * Stops or resumes subscribing to the video stream of a specified user.
   *
   * @note
   * - Call this method after joining a channel.
   * - See recommended settings in *Set the Subscribing State*.
   *
   * @param userId The user ID of the specified remote user.
   * @param mute Sets whether to stop subscribing to the video stream of a specified user.
   * - true: Stop subscribing to the video stream of a specified user.
   * - false: (Default) Resume subscribing to the video stream of a specified user.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int muteRemoteVideoStream(uid_t userId, bool mute) = 0;
  /** Sets the stream type of the remote video.

   Under limited network conditions, if the publisher has not disabled the dual-stream mode using `enableDualStreamMode(false)`,
   the receiver can choose to receive either the high-quality video stream (the high resolution, and high bitrate video stream) or
   the low-video stream (the low resolution, and low bitrate video stream).

   By default, users receive the high-quality video stream. Call this method if you want to switch to the low-video stream.
   This method allows the app to adjust the corresponding video stream type based on the size of the video window to
   reduce the bandwidth and resources.

   The aspect ratio of the low-video stream is the same as the high-quality video stream. Once the resolution of the high-quality video
   stream is set, the system automatically sets the resolution, frame rate, and bitrate of the low-video stream.

   The method result returns in the \ref agora::rtc::IRtcEngineEventHandler::onApiCallExecuted "onApiCallExecuted" callback.

   @note You can call this method either before or after joining a channel. If you call both
   \ref IRtcEngine::setRemoteVideoStreamType "setRemoteVideoStreamType" and
   \ref IRtcEngine::setRemoteDefaultVideoStreamType "setRemoteDefaultVideoStreamType", the SDK applies the settings in
   the \ref IRtcEngine::setRemoteVideoStreamType "setRemoteVideoStreamType" method.

   @param userId ID of the remote user sending the video stream.
   @param streamType  Sets the video-stream type. See #REMOTE_VIDEO_STREAM_TYPE.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setRemoteVideoStreamType(uid_t userId, REMOTE_VIDEO_STREAM_TYPE streamType) = 0;
  /** Sets the default stream type of remote videos.

   Under limited network conditions, if the publisher has not disabled the dual-stream mode using `enableDualStreamMode(false)`,
   the receiver can choose to receive either the high-quality video stream (the high resolution, and high bitrate video stream) or
   the low-video stream (the low resolution, and low bitrate video stream).

   By default, users receive the high-quality video stream. Call this method if you want to switch to the low-video stream.
   This method allows the app to adjust the corresponding video stream type based on the size of the video window to
   reduce the bandwidth and resources. The aspect ratio of the low-video stream is the same as the high-quality video stream.
   Once the resolution of the high-quality video
   stream is set, the system automatically sets the resolution, frame rate, and bitrate of the low-video stream.

   The method result returns in the \ref agora::rtc::IRtcEngineEventHandler::onApiCallExecuted "onApiCallExecuted" callback.

   @note
   - This method can only be called before joining a channel. Agora does not support you to change the default subscribed video stream type after joining a channel.
   - If you call both this method and `setRemoteVideoStreamType`, the SDK applies the settings in the `setRemoteVideoStreamType` method.

   @param streamType Sets the default video-stream type. See #REMOTE_VIDEO_STREAM_TYPE.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setRemoteDefaultVideoStreamType(REMOTE_VIDEO_STREAM_TYPE streamType) = 0;
  /// @cond nodoc
  /** Turn WIFI acceleration on or off.

   @note
   - This method is called before and after joining a channel.
   - Users check the WIFI router app for information about acceleration. Therefore, if this interface is invoked, the caller accepts that the caller's name will be displayed to the user in the WIFI router application on behalf of the caller.

   @param enabled
   - true：Turn WIFI acceleration on.
   - false：Turn WIFI acceleration off.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int enableWirelessAccelerate(bool enabled) = 0;
  /// @endcond
  /** Enables the reporting of users' volume indication.

   This method enables the SDK to regularly report the volume information of the local user who sends a stream and
   remote users (up to three) whose instantaneous volumes are the highest to the app. Once you call this method and
   users send streams in the channel, the SDK triggers the
   \ref IRtcEngineEventHandler::onAudioVolumeIndication "onAudioVolumeIndication" callback at the time interval set
   in this method.

   @note You can call this method either before or after joining a channel.

   @param interval Sets the time interval between two consecutive volume indications:
   - &le; 0: Disables the volume indication.
   - &gt; 0: Time interval (ms) between two consecutive volume indications. We recommend setting @p interval &gt; 200 ms. Do not set @p interval &lt; 10 ms, or the *onAudioVolumeIndication* callback will not be triggered.
   @param smooth Smoothing factor sets the sensitivity of the audio volume indicator. The value ranges between 0 and 10. The greater the value, the more sensitive the indicator. The recommended value is 3.
   @param report_vad
   - true: Enable the voice activity detection of the local user. Once it is enabled, the `vad` parameter of the `onAudioVolumeIndication` callback reports the voice activity status of the local user.
   - false: (Default) Disable the voice activity detection of the local user. Once it is disabled, the `vad` parameter of the `onAudioVolumeIndication` callback does not report the voice activity status of the local user, except for the scenario where the engine automatically detects the voice activity of the local user.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int enableAudioVolumeIndication(int interval, int smooth, bool report_vad) = 0;

  /** Enables reporting the voice pitch of the local user.
   *
   * @since v3.7.0
   *
   * This method enables the SDK to regularly report the voice pitch of the local user. After the local audio capture is enabled, and you call this method, the SDK triggers the \ref IRtcEngineEventHandler::onLocalVoicePitchInHz "onLocalVoicePitchInHz" callback at the time interval set in this method.
   *
   * @note You can call this method either before or after joining a channel.
   *
   * @param interval Sets the time interval at which the SDK triggers the `onLocalVoicePitchInHz` callback:
   * - ≤ 0: Disables the `onLocalVoicePitchInHz` callback.
   * - &gt; 0: The time interval (ms) at which the SDK triggers the `onLocalVoicePitchInHz` callback. The value must be greater than or equal to 10. If the value is less than 10, the SDK automatically changes it to 10.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int enableLocalVoicePitchCallback(int interval) = 0;

  /** Starts an audio recording.

   @deprecated Deprecated from v2.9.1.
   Use \ref IRtcEngine::startAudioRecording(const AudioRecordingConfiguration&) "startAudioRecording" [3/3] instead.

   The SDK allows recording during a call. Supported formats:

   - .wav: Large file size with high fidelity.
   - .aac: Small file size with low fidelity.

   This method has a fixed sample rate of 32 kHz.

   Ensure that the directory to save the recording file exists and is writable.
   This method is usually called after the \ref agora::rtc::IRtcEngine::joinChannel "joinChannel" method.
   The recording automatically stops when the \ref agora::rtc::IRtcEngine::leaveChannel "leaveChannel" method is called.

   @param filePath Pointer to the absolute file path of the recording file. The string of the file name is in UTF-8.
   @param quality Sets the audio recording quality. See #AUDIO_RECORDING_QUALITY_TYPE.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int startAudioRecording(const char* filePath, AUDIO_RECORDING_QUALITY_TYPE quality) AGORA_DEPRECATED_ATTRIBUTE = 0;

  /** Starts an audio recording on the client.
   *
   * @deprecated Deprecated from v3.4.0. Use
   * \ref IRtcEngine::startAudioRecording(const AudioRecordingConfiguration&) "startAudioRecording" [3/3] instead.
   *
   * The SDK allows recording during a call. After successfully calling this method, you can record the audio of all the users in the channel and get an audio recording file.
   * Supported formats of the recording file are as follows:
   * - .wav: Large file size with high fidelity.
   * - .aac: Small file size with low fidelity.
   *
   * @note
   * - Ensure that the directory you use to save the recording file exists and is writable.
   * - This method is usually called after the `joinChannel` method. The recording automatically stops when you call the `leaveChannel` method.
   * - For better recording effects, set quality as #AUDIO_RECORDING_QUALITY_MEDIUM or #AUDIO_RECORDING_QUALITY_HIGH when `sampleRate` is 44.1 kHz or 48 kHz.
   *
   * @param filePath Pointer to the absolute file path of the recording file. The string of the file name is in UTF-8, such as c:/music/audio.aac.
   * @param sampleRate Sample rate (Hz) of the recording file. Supported values are as follows:
   * - 16000
   * - (Default) 32000
   * - 44100
   * - 48000
   * @param quality Sets the audio recording quality. See #AUDIO_RECORDING_QUALITY_TYPE.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int startAudioRecording(const char* filePath, int sampleRate, AUDIO_RECORDING_QUALITY_TYPE quality) AGORA_DEPRECATED_ATTRIBUTE = 0;
  /**
   * Starts an audio recording on the client.
   *
   * @since v3.4.0
   *
   * The SDK allows recording audio during a call. After successfully calling
   * this method, you can record the audio of users in the channel and get
   * an audio recording file. Supported file formats are as follows:
   * - WAV: High-fidelity files with typically larger file sizes. For example,
   * if the sample rate is 32,000 Hz, the file size for a 10-minute recording
   * is approximately 73 MB.
   * - AAC: Low-fidelity files with typically smaller file sizes. For example,
   * if the sample rate is 32,000 Hz and the recording quality is
   * #AUDIO_RECORDING_QUALITY_MEDIUM, the file size for a 10-minute recording
   * is approximately 2 MB.
   *
   * Once the user leaves the channel, the recording automatically stops.
   *
   * @note Call this method after joining a channel.
   *
   * @param config Recording configuration. See AudioRecordingConfiguration.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *  - `-160(ERR_ALREADY_IN_RECORDING)`: The client is already recording
   * audio. To start a new recording,
   * call \ref IRtcEngine::stopAudioRecording "stopAudioRecording" to stop the
   * current recording first, and then
   * call \ref IRtcEngine::startAudioRecording(const AudioRecordingConfiguration&) "startAudioRecording".
   */
  virtual int startAudioRecording(const AudioRecordingConfiguration& config) = 0;
  /** Stops an audio recording on the client.

   @return
   - 0: Success
   - < 0: Failure.
   */
  virtual int stopAudioRecording() = 0;

  /** Starts playing and mixing the music file.
   *
   * @deprecated Deprecated from v3.4.0. Use
   * \ref IRtcEngine::startAudioMixing(const char*,bool,bool,int,int) "startAudioMixing" [2/2] instead.
   *
   * This method mixes the specified local audio file with the audio stream from the microphone, or replaces the microphone's audio stream with the specified local audio file. You can choose whether the other user can hear the local audio playback and specify the number of playback loops. This method also supports online music playback.
   *
   * When the audio mixing file playback finishes after calling this method, the SDK triggers the \ref agora::rtc::IRtcEngineEventHandler::onAudioMixingFinished "onAudioMixingFinished" callback.
   *
   * A successful \ref IRtcEngine::startAudioMixing(const char*,bool,bool,int,int) "startAudioMixing" method call triggers the \ref agora::rtc::IRtcEngineEventHandler::onAudioMixingStateChanged "onAudioMixingStateChanged" (PLAY) callback on the local client.
   *
   * When the audio mixing file playback finishes, the SDK triggers the \ref agora::rtc::IRtcEngineEventHandler::onAudioMixingStateChanged "onAudioMixingStateChanged" (STOPPED) callback on the local client.
   *
   * @note
   * - If the local audio mixing file does not exist, or if the SDK does not support the file format or cannot access the music file URL, the SDK returns #WARN_AUDIO_MIXING_OPEN_ERROR (701).
   * - If you want to play an online music file, ensure that the time interval between calling this method is more than 100 ms, or the `AUDIO_MIXING_ERROR_TOO_FREQUENT_CALL(702)` error code occurs.
   * - To avoid blocking, as of v3.4.5, this method changes from a synchronous call to an asynchronous call.
   * - For the audio file formats supported by this method, see [What formats of audio files does the Agora RTC SDK support](https://docs.agora.io/en/faq/audio_format).
   *
   * @param filePath The absolute path or URL address (including the filename extensions)
   * of the music file. For example: `C:\music\audio.mp4`.
   * When you access a local file on Android, Agora recommends passing a URI address or the path starts
   * with `/assets/` in this parameter.
   * @param loopback Sets which user can hear the audio mixing:
   * - true: Only the local user can hear the audio mixing.
   * - false: Both users can hear the audio mixing.
   * @param replace Sets the audio mixing content:
   * - true: Only publish the specified audio file. The audio stream from the microphone is not published.
   * - false: The local audio file is mixed with the audio stream from the microphone.
   * @param cycle Sets the number of playback loops:
   * - Positive integer: Number of playback loops.
   * - `-1`: Infinite playback loops.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int startAudioMixing(const char* filePath, bool loopback, bool replace, int cycle) AGORA_DEPRECATED_ATTRIBUTE = 0;
  /**
   * Starts playing and mixing the music file.
   *
   * @since v3.4.0
   *
   * This method supports mixing or replacing local or online music file and
   * audio collected by a microphone. After successfully playing the music
   * file, the SDK triggers
   * \ref IRtcEngineEventHandler::onAudioMixingStateChanged "onAudioMixingStateChanged" (AUDIO_MIXING_STATE_PLAYING,AUDIO_MIXING_REASON_STARTED_BY_USER).
   * After completing playing the music file, the SDK triggers
   * `onAudioMixingStateChanged(AUDIO_MIXING_STATE_STOPPED,AUDIO_MIXING_REASON_ALL_LOOPS_COMPLETED)`.
   *
   * @note
   * - If you need to call
   * \ref IRtcEngine::startAudioMixing(const char*,bool,bool,int,int) "startAudioMixing" multiple times,
   * ensure that the call interval is longer than 500 ms.
   * - If the local music file does not exist, or if the SDK does not support
   * the file format or cannot access the music file URL, the SDK returns
   * #WARN_AUDIO_MIXING_OPEN_ERROR (701).
   * - On Android:
   *  - To use this method, ensure that the Android device is v4.2 or later
   * and the API version is v16 or later.
   *  - If you need to play an online music file, Agora does not recommend
   * using the redirected URL address. Some Android devices may fail to open a redirected URL address.
   *  - If you call this method on an emulator, ensure that the music file is
   * in the `/sdcard/` directory and the format is MP3.
   * - To avoid blocking, as of v3.4.5, this method changes from a synchronous call to an asynchronous call.
   * - For the audio file formats supported by this method, see [What formats of audio files does the Agora RTC SDK support](https://docs.agora.io/en/faq/audio_format).
   *
   * @param filePath The absolute path or URL address (including the filename extensions)
   * of the music file. For example: `C:\music\audio.mp4`.
   * When you access a local file on Android, Agora recommends passing a URI address or the path starts
   * with `/assets/` in this parameter.
   * @param loopback Whether to only play the music file on the local client:
   * - true: Only play the music file on the local client so that only the local
   * user can hear the music.
   * - false: Publish the music file to remote clients so that both the local
   * user and remote users can hear the music.
   * @param replace Whether to replace the audio collected by the microphone
   * with a music file:
   * - true: Replace. Users can only hear music.
   * - false: Do not replace. Users can hear both music and audio collected by
   * the microphone.
   * @param cycle The number of times the music file plays.
   * - &ge; 0: The number of playback times. For example, `0` means that the
   * SDK does not play the music file, while `1` means that the SDK plays the
   * music file once.
   * - `-1`: Play the music in an indefinite loop.
   * @param startPos The playback position (ms) of the music file.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int startAudioMixing(const char* filePath, bool loopback, bool replace, int cycle, int startPos) = 0;
  /**
   * Sets the playback speed of the current music file.
   *
   * @since v3.5.1
   *
   * @note Call this method after calling \ref IRtcEngine::startAudioMixing(const char*,bool,bool,int,int) "startAudioMixing" [2/2]
   * and receiving the \ref IRtcEngineEventHandler::onAudioMixingStateChanged "onAudioMixingStateChanged" (AUDIO_MIXING_STATE_PLAYING) callback.
   *
   * @param speed The playback speed. Agora recommends that you limit this value to between 50 and 400, defined as follows:
   * - 50: Half the original speed.
   * - 100: The original speed.
   * - 400: 4 times the original speed.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setAudioMixingPlaybackSpeed(int speed) = 0;
  /** Stops playing and mixing the music file.

   Call this method when you are in a channel.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int stopAudioMixing() = 0;
  /** Pauses playing and mixing the music file.

   Call this method when you are in a channel.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int pauseAudioMixing() = 0;
  /**
   * Specifies the playback track of the current music file.
   *
   * @since v3.5.1
   *
   * After getting the number of audio tracks of the current music file, call this
   * method to specify any audio track to play. For example, if different tracks
   * of a multitrack file store songs in different languages, you can call this
   * method to set the language of the music file to play.
   *
   * @note
   * - This method is for Android, iOS, and Windows only.
   * - Call this method after calling \ref IRtcEngine::startAudioMixing(const char*,bool,bool,int,int) "startAudioMixing" [2/2]
   * and receiving the \ref IRtcEngineEventHandler::onAudioMixingStateChanged "onAudioMixingStateChanged" (AUDIO_MIXING_STATE_PLAYING) callback.
   * - For the audio file formats supported by this method, see [What formats of audio files does the Agora RTC SDK support](https://docs.agora.io/en/faq/audio_format).
   *
   * @param index The specified playback track. The value range is [0, `getAudioTrackCount()`).
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int selectAudioTrack(int index) = 0;
  /**
   * Gets the number of audio tracks of the current music file.
   *
   * @since v3.5.1
   *
   * @note
   * - This method is for Android, iOS, and Windows only.
   * - Call this method after calling \ref IRtcEngine::startAudioMixing(const char*,bool,bool,int,int) "startAudioMixing" [2/2]
   * and receiving the \ref IRtcEngineEventHandler::onAudioMixingStateChanged "onAudioMixingStateChanged" (AUDIO_MIXING_STATE_PLAYING) callback.
   * - For the audio file formats supported by this method, see [What formats of audio files does the Agora RTC SDK support](https://docs.agora.io/en/faq/audio_format).
   *
   * @return
   * - &gt; 0: The number of audio tracks of the current music file, if this method call succeeds.
   * - < 0: Failure.
   */
  virtual int getAudioTrackCount() = 0;
  /**
   * Sets the channel mode of the current music file.
   *
   * @since v3.5.1
   *
   * In a stereo music file, the left and right channels can store different audio data.
   * According to your needs, you can set the channel mode to original mode, left channel mode,
   * right channel mode, or mixed channel mode. For example, in the KTV scenario, the left
   * channel of the music file stores the musical accompaniment, and the right channel
   * stores the singing voice. If you only need to listen to the accompaniment, call this
   * method to set the channel mode of the music file to left channel mode; if you need to
   * listen to the accompaniment and the singing voice at the same time, call this method
   * to set the channel mode to mixed channel mode.
   *
   * @note
   * - Call this method after calling \ref IRtcEngine::startAudioMixing(const char*,bool,bool,int,int) "startAudioMixing" [2/2]
   * and receiving the \ref IRtcEngineEventHandler::onAudioMixingStateChanged "onAudioMixingStateChanged" (AUDIO_MIXING_STATE_PLAYING) callback.
   * - This method only applies to stereo audio files.
   *
   * @param mode The channel mode. See \ref agora::media::AUDIO_MIXING_DUAL_MONO_MODE "AUDIO_MIXING_DUAL_MONO_MODE".
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setAudioMixingDualMonoMode(agora::media::AUDIO_MIXING_DUAL_MONO_MODE mode) = 0;
  /** Resumes playing and mixing the music file.

   Call this method when you are in a channel.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int resumeAudioMixing() = 0;
  /** **DEPRECATED** Agora does not recommend using this method.

   Sets the high-quality audio preferences. Call this method and set all parameters before joining a channel.

   Do not call this method again after joining a channel.

   @param fullband Sets whether to enable/disable full-band codec (48-kHz sample rate). Not compatible with SDK versions before v1.7.4:
   - true: Enable full-band codec.
   - false: Disable full-band codec.
   @param  stereo Sets whether to enable/disable stereo codec. Not compatible with SDK versions before v1.7.4:
   - true: Enable stereo codec.
   - false: Disable stereo codec.
   @param fullBitrate Sets whether to enable/disable high-bitrate mode. Recommended in voice-only mode:
   - true: Enable high-bitrate mode.
   - false: Disable high-bitrate mode.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setHighQualityAudioParameters(bool fullband, bool stereo, bool fullBitrate) = 0;
  /** Adjusts the volume during audio mixing.

   @note
   - Calling this method does not affect the volume of audio effect file playback invoked by the \ref IRtcEngine::playEffect(int,const char*,int,double,double,int,bool,int) "playEffect"  method.
   - Call this method after calling \ref IRtcEngine::startAudioMixing(const char*,bool,bool,int,int) "startAudioMixing" and receiving the \ref IRtcEngineEventHandler::onAudioMixingStateChanged "onAudioMixingStateChanged" (AUDIO_MIXING_STATE_PLAYING) callback.

   @param volume Audio mixing volume. The value ranges between 0 and 100 (default).

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int adjustAudioMixingVolume(int volume) = 0;
  /** Adjusts the audio mixing volume for local playback.

   @note Call this method after calling \ref IRtcEngine::startAudioMixing(const char*,bool,bool,int,int) "startAudioMixing" and receiving the \ref IRtcEngineEventHandler::onAudioMixingStateChanged "onAudioMixingStateChanged" (AUDIO_MIXING_STATE_PLAYING) callback.

   @param volume Audio mixing volume for local playback. The value ranges between 0 and 100 (default).

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int adjustAudioMixingPlayoutVolume(int volume) = 0;
  /** Gets the audio mixing volume for local playback.

   This method helps troubleshoot audio volume related issues.

   @note
   - Call this method when you are in a channel.
   - Call this method after calling \ref IRtcEngine::startAudioMixing(const char*,bool,bool,int,int) "startAudioMixing" and receiving the \ref IRtcEngineEventHandler::onAudioMixingStateChanged "onAudioMixingStateChanged" (AUDIO_MIXING_STATE_PLAYING) callback.

   @return
   - &ge; 0: The audio mixing volume, if this method call succeeds. The value range is [0,100].
   - < 0: Failure.
   */
  virtual int getAudioMixingPlayoutVolume() = 0;
  /** Adjusts the audio mixing volume for publishing (for remote users).

   @note Call this method after calling \ref IRtcEngine::startAudioMixing(const char*,bool,bool,int,int) "startAudioMixing" and receiving the \ref IRtcEngineEventHandler::onAudioMixingStateChanged "onAudioMixingStateChanged" (AUDIO_MIXING_STATE_PLAYING) callback.

   @param volume Audio mixing volume for publishing. The value ranges between 0 and 100 (default).

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int adjustAudioMixingPublishVolume(int volume) = 0;
  /** Gets the audio mixing volume for publishing.

   This method helps troubleshoot audio volume related issues.

   @note
   - Call this method when you are in a channel.
   - Call this method after calling \ref IRtcEngine::startAudioMixing(const char*,bool,bool,int,int) "startAudioMixing" and receiving the \ref IRtcEngineEventHandler::onAudioMixingStateChanged "onAudioMixingStateChanged" (AUDIO_MIXING_STATE_PLAYING) callback.

   @return
   - &ge; 0: The audio mixing volume for publishing, if this method call succeeds. The value range is [0,100].
   - < 0: Failure.
   */
  virtual int getAudioMixingPublishVolume() = 0;

  /** Gets the duration (ms) of the music file.
   *
   * @deprecated This method is deprecated as of v3.5.1. Use \ref IRtcEngine::getAudioFileInfo "getAudioFileInfo" instead.
   *
   * @note
   * - Call this method when you are in a channel.
   * - Call this method after calling \ref IRtcEngine::startAudioMixing(const char*,bool,bool,int,int) "startAudioMixing"
   * and receiving the \ref IRtcEngineEventHandler::onAudioMixingStateChanged "onAudioMixingStateChanged" (AUDIO_MIXING_STATE_PLAYING) callback.
   *
   * @return
   * - &ge; 0: The audio mixing duration, if this method call succeeds.
   * - < 0: Failure.
   */
  virtual int getAudioMixingDuration() AGORA_DEPRECATED_ATTRIBUTE = 0;
  /** Gets the playback position (ms) of the music file.
   *
   * @note
   * - Call this method after calling \ref IRtcEngine::startAudioMixing(const char*,bool,bool,int,int) "startAudioMixing" and receiving the \ref IRtcEngineEventHandler::onAudioMixingStateChanged "onAudioMixingStateChanged" (AUDIO_MIXING_STATE_PLAYING) callback.
   * - If you need to call `getAudioMixingCurrentPosition` multiple times, ensure that the call interval is longer than 500 ms.
   *
   * @return
   * - &ge; 0: The current playback position (ms) of the music file, if this method call succeeds. 0 represents that the current music file does not start playing.
   * - < 0: Failure.
   */
  virtual int getAudioMixingCurrentPosition() = 0;
  /** Sets the playback position of the music file to a different starting position (the default plays from the beginning).

   @note Call this method after calling \ref IRtcEngine::startAudioMixing(const char*,bool,bool,int,int) "startAudioMixing" and receiving the \ref IRtcEngineEventHandler::onAudioMixingStateChanged "onAudioMixingStateChanged" (AUDIO_MIXING_STATE_PLAYING) callback.

   @param pos The playback starting position (ms) of the music file.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setAudioMixingPosition(int pos /*in ms*/) = 0;
  /** Sets the pitch of the local music file.
   * @since v3.0.1
   *
   * When a local music file is mixed with a local human voice, call this method to set the pitch of the local music file only.
   *
   * @note Call this method after calling \ref IRtcEngine::startAudioMixing(const char*,bool,bool,int,int) "startAudioMixing" and receiving the \ref IRtcEngineEventHandler::onAudioMixingStateChanged "onAudioMixingStateChanged" (AUDIO_MIXING_STATE_PLAYING) callback.
   *
   * @param pitch Sets the pitch of the local music file by chromatic scale. The default value is 0,
   * which means keeping the original pitch. The value ranges from -12 to 12, and the pitch value between
   * consecutive values is a chromatic value. The greater the absolute value of this parameter, the
   * higher or lower the pitch of the local music file.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setAudioMixingPitch(int pitch) = 0;
  /** Gets the volume of the audio effects.

   The value ranges between 0.0 and 100.0.

   @note Ensure that this method is called after \ref IRtcEngine::playEffect(int,const char*,int,double,double,int,bool,int) "playEffect" .

   @return
   - &ge; 0: Volume of the audio effects, if this method call succeeds.

   - < 0: Failure.
   */
  virtual int getEffectsVolume() = 0;
  /** Sets the volume of the audio effects.

   @note Ensure that this method is called after \ref IRtcEngine::playEffect(int,const char*,int,double,double,int,bool,int) "playEffect" .

   @param volume Sets the volume of the audio effects. The value ranges between 0 and 100 (default).

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setEffectsVolume(int volume) = 0;
  /** Sets the volume of a specified audio effect.

   @note Ensure that this method is called after \ref IRtcEngine::playEffect(int,const char*,int,double,double,int,bool,int) "playEffect" .

   @param soundId ID of the audio effect. Each audio effect has a unique ID.
   @param volume Sets the volume of the specified audio effect. The value ranges between 0 and 100 (default).

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setVolumeOfEffect(int soundId, int volume) = 0;

#if defined(__ANDROID__) || (defined(__APPLE__) && TARGET_OS_IOS)
  /**
   * Enables/Disables face detection for the local user.
   *
   * @since v3.0.1
   *
   * @note
   * - Applies to Android and iOS only.
   * - You can call this method either before or after joining a channel.
   *
   * Once face detection is enabled, the SDK triggers the \ref IRtcEngineEventHandler::onFacePositionChanged "onFacePositionChanged" callback
   * to report the face information of the local user, which includes the following aspects:
   * - The width and height of the local video.
   * - The position of the human face in the local view.
   * - The distance between the human face and the device screen.
   *
   * @param enable Determines whether to enable the face detection function for the local user:
   * - true: Enable face detection.
   * - false: (Default) Disable face detection.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int enableFaceDetection(bool enable) = 0;
#endif
  /** Plays a specified local or online audio effect file.
   *
   * @deprecated Deprecated from v3.4.0. Use
   * \ref IRtcEngine::playEffect(int,const char*,int,double,double,int,bool,int) "playEffect" [2/2] instead.
   *
   * This method allows you to set the loop count, pitch, pan, and gain of the audio effect file, as well as whether the remote user can hear the audio effect.
   *
   * To play multiple audio effect files simultaneously, call this method multiple times with different soundIds and filePaths. We recommend playing no more than three audio effect files at the same time.
   *
   * @note
   * - If the audio effect is preloaded into the memory through the \ref IRtcEngine::preloadEffect "preloadEffect" method, the value of @p soundID must be the same as that in the *preloadEffect* method.
   * - Playing multiple online audio effect files simultaneously is not supported on macOS and Windows.
   * - Ensure that you call this method after joining a channel.
   * - For the audio file formats supported by this method, see [What formats of audio files does the Agora RTC SDK support](https://docs.agora.io/en/faq/audio_format).
   *
   * @param soundId ID of the specified audio effect. Each audio effect has a unique ID.
   * @param filePath The absolute path or URL address (including the filename extensions)
   * of the music file. For example: `C:\music\audio.mp4`.
   * When you access a local file on Android, Agora recommends passing a URI address or the path starts
   * with `/assets/` in this parameter.
   * @param loopCount Sets the number of times the audio effect loops:
   * - 0: Play the audio effect once.
   * - 1: Play the audio effect twice.
   * - -1: Play the audio effect in an indefinite loop until the \ref IRtcEngine::stopEffect "stopEffect" or \ref IRtcEngine::stopAllEffects "stopAllEffects" method is called.
   * @param pitch Sets the pitch of the audio effect. The value ranges between 0.5 and 2. The default value is 1 (no change to the pitch). The lower the value, the lower the pitch.
   * @param pan Sets the spatial position of the audio effect. The value ranges between -1.0 and 1.0:
   * - 0.0: The audio effect displays ahead.
   * - 1.0: The audio effect displays to the right.
   * - -1.0: The audio effect displays to the left.
   * @param gain  Sets the volume of the audio effect. The value ranges between 0 and 100 (default). The lower the value, the lower the volume of the audio effect.
   * @param publish Sets whether to publish the specified audio effect to the remote stream:
   * - true: The locally played audio effect is published to the Agora Cloud and the remote users can hear it.
   * - false: The locally played audio effect is not published to the Agora Cloud and the remote users cannot hear it.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int playEffect(int soundId, const char* filePath, int loopCount, double pitch, double pan, int gain, bool publish = false) AGORA_DEPRECATED_ATTRIBUTE = 0;
  /**
   * Plays a specified local or online audio effect file.
   *
   * @since v3.4.0
   *
   * To play multiple audio effect files at the same time, call this method
   * multiple times with different `soundId` and `filePath` values. For the
   * best user experience, Agora recommends playing no more than three audio
   * effect files at the same time.
   *
   * After completing playing an audio effect file, the SDK triggers the
   * \ref IRtcEngineEventHandler::onAudioEffectFinished "onAudioEffectFinished"
   * callback.
   *
   * @note
   * - Call this method after joining a channel.
   * - For the audio file formats supported by this method, see [What formats of audio files does the Agora RTC SDK support](https://docs.agora.io/en/faq/audio_format).
   *
   * @param soundId Audio effect ID. The ID of each audio effect file is
   * unique. If you preloaded an audio effect into memory by calling
   * \ref IRtcEngine::preloadEffect "preloadEffect", ensure that this
   * parameter is set to the same value as in `preloadEffect`.
   * @param filePath The absolute path or URL address (including the filename extensions)
   * of the music file. For example: `C:\music\audio.mp4`.
   * If you preloaded an audio effect into memory by calling
   * \ref IRtcEngine::preloadEffect "preloadEffect", ensure that this
   * parameter is set to the same value as in `preloadEffect`.
   * When you access a local file on Android, Agora recommends passing a URI address or the path starts
   * with `/assets/` in this parameter.
   *
   * @param loopCount The number of times the audio effect loops:
   * - &ge; 0: The number of loops. For example, `1` means loop one time,
   * which means play the audio effect two times in total.
   * - `-1`: Play the audio effect in an indefinite loop.
   * @param pitch The pitch of the audio effect. The range is 0.5 to 2.0.
   * The default value is 1.0, which means the original pitch. The lower the
   * value, the lower the pitch.
   * @param pan The spatial position of the audio effect. The range is `-1.0`
   * to `1.0`. For example:
   * - `-1.0`: The audio effect occurs on the left.
   * - `0.0`: The audio effect occurs in the front.
   * - `1.0`: The audio effect occurs on the right.
   * @param gain The volume of the audio effect. The range is 0.0 to 100.0.
   * The default value is 100.0, which means the original volume. The smaller
   * the value, the less the gain.
   * @param publish Whether to publish the audio effect to the remote users:
   * - true: Publish. Both the local user and remote users can hear the audio
   * effect.
   * - false: Do not publish. Only the local user can hear the audio effect.
   * @param startPos The playback position (ms) of the audio effect file.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int playEffect(int soundId, const char* filePath, int loopCount, double pitch, double pan, int gain, bool publish, int startPos) = 0;
  /** Stops playing a specified audio effect.

   @param soundId ID of the audio effect to stop playing. Each audio effect has a unique ID.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int stopEffect(int soundId) = 0;
  /** Stops playing all audio effects.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int stopAllEffects() = 0;

  /** Preloads a specified audio effect file into the memory.
   *
   * To ensure smooth communication, limit the size of the audio effect file. We recommend using this method to preload the audio effect before calling the \ref IRtcEngine::joinChannel "joinChannel" method.
   *
   * @note This method does not support online audio effect files. For the audio file formats supported by this method, see [What formats of audio files does the Agora RTC SDK support](https://docs.agora.io/en/faq/audio_format).
   *
   * @param soundId ID of the audio effect. Each audio effect has a unique ID.
   * @param filePath The absolute path or URL address (including the filename extensions)
   * of the music file. For example: `C:\music\audio.mp4`.
   * When you access a local file on Android, Agora recommends passing a URI address or the path starts
   * with `/assets/` in this parameter.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int preloadEffect(int soundId, const char* filePath) = 0;
  /** Releases a specified preloaded audio effect from the memory.

   @param soundId ID of the audio effect. Each audio effect has a unique ID.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int unloadEffect(int soundId) = 0;
  /** Pauses a specified audio effect.

   @param soundId ID of the audio effect. Each audio effect has a unique ID.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int pauseEffect(int soundId) = 0;
  /** Pauses all audio effects.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int pauseAllEffects() = 0;
  /** Resumes playing a specified audio effect.

   @param soundId ID of the audio effect. Each audio effect has a unique ID.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int resumeEffect(int soundId) = 0;
  /** Resumes playing all audio effects.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int resumeAllEffects() = 0;
  /**
   * Gets the duration of the audio effect file.
   *
   * @since v3.4.0
   *
   * @note
   * - Call this method after joining a channel.
   * - For the audio file formats supported by this method, see [What formats of audio files does the Agora RTC SDK support](https://docs.agora.io/en/faq/audio_format).
   *
   * @param filePath The absolute path or URL address (including the filename extensions)
   * of the music file. For example: `C:\music\audio.mp4`.
   * When you access a local file on Android, Agora recommends passing a URI address or the path starts
   * with `/assets/` in this parameter.
   *
   * @return
   * - &ge; 0: A successful method call. Returns the total duration (ms) of
   * the specified audio effect file.
   * - < 0: Failure.
   *  - `-22(ERR_RESOURCE_LIMITED)`: Cannot find the audio effect file. Please
   * set a correct `filePath`.
   */
  virtual int getEffectDuration(const char* filePath) = 0;
  /**
   * Sets the playback position of an audio effect file.
   *
   * @since v3.4.0
   *
   * After a successful setting, the local audio effect file starts playing at the specified position.
   *
   * @note Call this method after \ref IRtcEngine::playEffect(int,const char*,int,double,double,int,bool,int) "playEffect" .
   *
   * @param soundId Audio effect ID. Ensure that this parameter is set to the
   * same value as in \ref IRtcEngine::playEffect(int,const char*,int,double,double,int,bool,int) "playEffect" .
   * @param pos The playback position (ms) of the audio effect file.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *  - `-22(ERR_RESOURCE_LIMITED)`: Cannot find the audio effect file. Please
   * set a correct `soundId`.
   */
  virtual int setEffectPosition(int soundId, int pos) = 0;
  /**
   * Gets the playback position of the audio effect file.
   *
   * @since v3.4.0
   *
   * @note Call this method after \ref IRtcEngine::playEffect(int,const char*,int,double,double,int,bool,int) "playEffect" .
   *
   * @param soundId Audio effect ID. Ensure that this parameter is set to the
   * same value as in \ref IRtcEngine::playEffect(int,const char*,int,double,double,int,bool,int) "playEffect" .
   *
   * @return
   * - &ge; 0: A successful method call. Returns the playback position (ms) of
   * the specified audio effect file.
   * - < 0: Failure.
   *  - `-22(ERR_RESOURCE_LIMITED)`: Cannot find the audio effect file. Please
   * set a correct `soundId`.
   */
  virtual int getEffectCurrentPosition(int soundId) = 0;

  /** Gets the information of a specified audio file.
   *
   * @since v3.5.1
   *
   * After calling this method successfully, the SDK triggers the
   * \ref IRtcEngineEventHandler::onRequestAudioFileInfo "onRequestAudioFileInfo"
   * callback to report the information of an audio file, such as audio duration.
   * You can call this method multiple times to get the information of multiple audio files.
   *
   * @note
   * - Call this method after joining a channel.
   * - For the audio file formats supported by this method, see [What formats of audio files does the Agora RTC SDK support](https://docs.agora.io/en/faq/audio_format).
   *
   * @param filePath The file path:
   * - Windows: The absolute path or URL address (including the filename extensions) of
   * the audio file. For example: `C:\music\audio.mp4`.
   * - Android: The file path, including the filename extensions. To access an online file,
   * Agora supports using a URL address; to access a local file, Agora supports using a URI
   * address, an absolute path, or a path that starts with `/assets/`. You might encounter
   * permission issues if you use an absolute path to access a local file, so Agora recommends
   * using a URI address instead. For example: `content://com.android.providers.media.documents/document/audio%3A14441`.
   * - iOS or macOS: The absolute path or URL address (including the filename extensions) of the audio file.
   * For example: `/var/mobile/Containers/Data/audio.mp4`.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int getAudioFileInfo(const char* filePath) = 0;

  /** Enables or disables deep-learning noise reduction.
   *
   * @since v3.3.0
   *
   * The SDK enables traditional noise reduction mode by default to reduce most of the stationary background noise.
   * If you need to reduce most of the non-stationary background noise, Agora recommends enabling deep-learning
   * noise reduction as follows:
   *
   * 1. Ensure that the dynamical library is integrated in your project:
   *  - Android: `libagora_ai_denoise_extension.so`
   *  - iOS/macOS: `AgoraAIDenoiseExtension.xcframework`
   *  - Windows: `libagora_ai_denoise_extension.dll`
   * 2. Call `enableDeepLearningDenoise(true)`.
   *
   * Deep-learning noise reduction requires high-performance devices. For example, the following devices and later
   * models are known to support deep-learning noise reduction:
   * - iPhone 6S
   * - MacBook Pro 2015
   * - iPad Pro (2nd generation)
   * - iPad mini (5th generation)
   * - iPad Air (3rd generation)
   *
   * After successfully enabling deep-learning noise reduction, if the SDK detects that the device performance
   * is not sufficient, it automatically disables deep-learning noise reduction and enables traditional noise reduction.
   *
   * If you call `enableDeepLearningDenoise(false)` or the SDK automatically disables deep-learning noise reduction
   * in the channel, when you need to re-enable deep-learning noise reduction, you need to call \ref IRtcEngine::leaveChannel "leaveChannel"
   * first, and then call `enableDeepLearningDenoise(true)`.
   *
   * @note
   * - This method dynamically loads the library, so Agora recommends calling this method before joining a channel.
   * - This method works best with the human voice. Agora does not recommend using this method for audio containing music.
   *
   * @param enable Sets whether to enable deep-learning noise reduction.
   * - true: (Default) Enables deep-learning noise reduction.
   * - false: Disable deep-learning noise reduction.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *  - -157 (ERR_MODULE_NOT_FOUND): The dynamical library for enabling deep-learning noise reduction is not integrated.
   */
  virtual int enableDeepLearningDenoise(bool enable) = 0;
  /** Enables/Disables stereo panning for remote users.

   Ensure that you call this method before joinChannel to enable stereo panning for remote users so that the local user can track the position of a remote user by calling \ref agora::rtc::IRtcEngine::setRemoteVoicePosition "setRemoteVoicePosition".

   @param enabled Sets whether to enable stereo panning for remote users:
   - true: Enable stereo panning.
   - false: Disable stereo panning.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int enableSoundPositionIndication(bool enabled) = 0;
  /** Sets the sound position and gain of a remote user.

   When the local user calls this method to set the sound position of a remote user, the sound difference between the left and right channels allows the local user to track the real-time position of the remote user, creating a real sense of space. This method applies to massively multiplayer online games, such as Battle Royale games.

   @note
   - For this method to work, enable stereo panning for remote users by calling the \ref agora::rtc::IRtcEngine::enableSoundPositionIndication "enableSoundPositionIndication" method before joining a channel.
   - This method requires hardware support. For the best sound positioning, we recommend using a wired headset.
   - Ensure that you call this method after joining a channel.

   @param uid The ID of the remote user.
   @param pan The sound position of the remote user. The value ranges from -1.0 to 1.0:
   - 0.0: the remote sound comes from the front.
   - -1.0: the remote sound comes from the left.
   - 1.0: the remote sound comes from the right.
   @param gain Gain of the remote user. The value ranges from 0.0 to 100.0. The default value is 100.0 (the original gain of the remote user). The smaller the value, the less the gain.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setRemoteVoicePosition(uid_t uid, double pan, double gain) = 0;
  /// @cond nodoc
  /**
   * Enables or disables the spatial audio effect.
   *
   * @since v3.7.0
   *
   * After enabling the spatial audio effect, you can call `setRemoteUserSpatialAudioParams` to set the spatial audio effect parameters of a remote user. After a successful setting, the local user can hear the remote user with a real sense of space.
   *
   * @note You can call this method either before or after joining a channel.
   *
   * @param enabled Whether to enable the spatial audio effect:
   * - true: Enable the spatial audio effect.
   * - false: Disable the spatial audio effect.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int enableSpatialAudio(bool enabled) = 0;

  /** Sets the spatial audio effect parameters of the remote user.
   *
   * @since v3.7.0
   *
   * After calling \ref IRtcEngine::enableSpatialAudio "enableSpatialAudio" and setting the spatial audio effect parameters of a remote user successfully, the local user can hear the remote user with a real sense of space.
   *
   * @note Call this method after calling `enableSpatialAudio`.
   *
   * @param uid The user ID of the remote user.
   * @param spatial_audio_params Spatial audio effect parameters. See \ref agora::media::SpatialAudioParams "SpatialAudioParams".
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setRemoteUserSpatialAudioParams(uid_t uid, const agora::media::SpatialAudioParams& spatial_audio_params) = 0;
  /// @endcond

  /** Changes the voice pitch of the local speaker.

   @note You can call this method either before or after joining a channel.

   @param pitch Sets the voice pitch. The value ranges between 0.5 and 2.0. The lower the value, the lower the voice pitch. The default value is 1.0 (no change to the local voice pitch).
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setLocalVoicePitch(double pitch) = 0;
  /** Sets the local voice equalization effect.
   @note You can call this method either before or after joining a channel.

   @param bandFrequency Sets the band frequency. The value ranges between 0 and 9, representing the respective 10-band center frequencies of the voice effects, including 31, 62, 125, 250, 500, 1k, 2k, 4k, 8k, and 16k Hz. See #AUDIO_EQUALIZATION_BAND_FREQUENCY.

   @param bandGain  Sets the gain of each band in dB. The value ranges between -15 and 15.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setLocalVoiceEqualization(AUDIO_EQUALIZATION_BAND_FREQUENCY bandFrequency, int bandGain) = 0;
  /** Sets the local voice reverberation.
   *
   * As of v3.2.0, the SDK provides a more convenient method
   * \ref IRtcEngine::setAudioEffectPreset "setAudioEffectPreset", which
   * directly implements the popular music, R&B music, KTV and other preset
   * reverb effects.
   *
   * @note You can call this method either before or after joining a channel.
   *
   * @param reverbKey Sets the reverberation key. See #AUDIO_REVERB_TYPE.
   * @param value Sets the value of the reverberation key. See #AUDIO_REVERB_TYPE.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setLocalVoiceReverb(AUDIO_REVERB_TYPE reverbKey, int value) = 0;
  /** Sets the local voice changer option.

   @deprecated Deprecated from v3.2.0. Use the following methods instead:
   - \ref IRtcEngine::setAudioEffectPreset "setAudioEffectPreset": Audio effects.
   - \ref IRtcEngine::setVoiceBeautifierPreset "setVoiceBeautifierPreset": Voice beautifier effects.
   - \ref IRtcEngine::setVoiceConversionPreset "setVoiceConversionPreset": Voice conversion effects.

   This method can be used to set the local voice effect for users in a `COMMUNICATION` channel or hosts in a `LIVE_BROADCASTING` channel.
   Voice changer options include the following voice effects:

   - `VOICE_CHANGER_XXX`: Changes the local voice to an old man, a little boy, or the Hulk. Applies to the voice talk scenario.
   - `VOICE_BEAUTY_XXX`: Beautifies the local voice by making it sound more vigorous, resounding, or adding spacial resonance. Applies to the voice talk and singing scenario.
   - `GENERAL_VOICE_BEAUTY_XXX`: Adds gender-based beautification effect to the local voice. Applies to the voice talk scenario.
     - For a male voice: Adds magnetism to the voice.
     - For a female voice: Adds freshness or vitality to the voice.

   @note
   - To achieve better voice effect quality, Agora recommends setting the profile parameter in \ref IRtcEngine::setAudioProfile "setAudioProfile" as #AUDIO_PROFILE_MUSIC_HIGH_QUALITY (4) or #AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO (5)
   - This method works best with the human voice, and Agora does not recommend using it for audio containing music and a human voice.
   - Do not use this method with \ref IRtcEngine::setLocalVoiceReverbPreset "setLocalVoiceReverbPreset" , because the method called later overrides the one called earlier. For detailed considerations, see the advanced guide *Set the Voice Effect*.
   - You can call this method either before or after joining a channel.

   @param voiceChanger Sets the local voice changer option. The default value is `VOICE_CHANGER_OFF`,
   which means the original voice. See details in #VOICE_CHANGER_PRESET.

   @return
   - 0: Success.
   - < 0: Failure. Check if the enumeration is properly set.
   */
  virtual int setLocalVoiceChanger(VOICE_CHANGER_PRESET voiceChanger) AGORA_DEPRECATED_ATTRIBUTE = 0;
  /** Sets the local voice reverberation option, including the virtual stereo.
   *
   * @deprecated Deprecated from v3.2.0. Use \ref IRtcEngine::setAudioEffectPreset "setAudioEffectPreset" or
   * \ref IRtcEngine::setVoiceBeautifierPreset "setVoiceBeautifierPreset" instead.
   *
   * This method sets the local voice reverberation for users in a `COMMUNICATION` channel or hosts in a `LIVE_BROADCASTING` channel.
   * After successfully calling this method, all users in the channel can hear the voice with reverberation.
   *
   * @note
   * - When calling this method with enumerations that begin with `AUDIO_REVERB_FX`, ensure that you set profile in `setAudioProfile` as
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)`; otherwise, this methods cannot set the corresponding voice reverberation option.
   * - When calling this method with `AUDIO_VIRTUAL_STEREO`, Agora recommends setting the `profile` parameter in `setAudioProfile` as `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)`.
   * - This method works best with the human voice, and Agora does not recommend using it for audio containing music and a human voice.
   * - Do not use this method with `setLocalVoiceChanger`, because the method called later overrides the one called earlier.
   * For detailed considerations, see the advanced guide *Set the Voice Effect*.
   * - You can call this method either before or after joining a channel.
   *
   * @param reverbPreset The local voice reverberation option. The default value is `AUDIO_REVERB_OFF`,
   * which means the original voice.  See #AUDIO_REVERB_PRESET.
   * To achieve better voice effects, Agora recommends the enumeration whose name begins with `AUDIO_REVERB_FX`.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setLocalVoiceReverbPreset(AUDIO_REVERB_PRESET reverbPreset) AGORA_DEPRECATED_ATTRIBUTE = 0;
  /** Sets an SDK preset voice beautifier effect.
   *
   * @since v3.2.0
   *
   * Call this method to set an SDK preset voice beautifier effect for the local user who sends an audio stream. After
   * setting a voice beautifier effect, all users in the channel can hear the effect.
   *
   * You can set different voice beautifier effects for different scenarios. See *Set the Voice Effect*.
   *
   * To achieve better audio effect quality, Agora recommends calling \ref IRtcEngine::setAudioProfile "setAudioProfile" and
   * setting the `scenario` parameter to `AUDIO_SCENARIO_GAME_STREAMING(3)` and the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before calling this method.
   *
   * @note
   * - You can call this method either before or after joining a channel.
   * - Do not set the `profile` parameter of \ref IRtcEngine::setAudioProfile "setAudioProfile" to `AUDIO_PROFILE_SPEECH_STANDARD(1)`
   * or `AUDIO_PROFILE_IOT(6)`; otherwise, this method call does not take effect.
   * - This method works best with the human voice. Agora does not recommend using this method for audio containing music.
   * - After calling this method, Agora recommends not calling the following methods, because they can override \ref IRtcEngine::setAudioEffectParameters "setAudioEffectParameters":
   *  - \ref IRtcEngine::setAudioEffectPreset "setAudioEffectPreset"
   *  - \ref IRtcEngine::setVoiceBeautifierPreset "setVoiceBeautifierPreset"
   *  - \ref IRtcEngine::setLocalVoiceReverbPreset "setLocalVoiceReverbPreset"
   *  - \ref IRtcEngine::setLocalVoiceChanger "setLocalVoiceChanger"
   *  - \ref IRtcEngine::setLocalVoicePitch "setLocalVoicePitch"
   *  - \ref IRtcEngine::setLocalVoiceEqualization "setLocalVoiceEqualization"
   *  - \ref IRtcEngine::setLocalVoiceReverb "setLocalVoiceReverb"
   *  - \ref IRtcEngine::setVoiceBeautifierParameters "setVoiceBeautifierParameters"
   *  - \ref IRtcEngine::setVoiceConversionPreset "setVoiceConversionPreset"
   *
   * @param preset The options for SDK preset voice beautifier effects: #VOICE_BEAUTIFIER_PRESET.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setVoiceBeautifierPreset(VOICE_BEAUTIFIER_PRESET preset) = 0;
  /** Sets an SDK preset audio effect.
   *
   * @since v3.2.0
   *
   * Call this method to set an SDK preset audio effect for the local user who sends an audio stream. This audio effect
   * does not change the gender characteristics of the original voice. After setting an audio effect, all users in the
   * channel can hear the effect.
   *
   * You can set different audio effects for different scenarios. See *Set the Voice Effect*.
   *
   * To achieve better audio effect quality, Agora recommends calling \ref IRtcEngine::setAudioProfile "setAudioProfile"
   * and setting the `scenario` parameter to `AUDIO_SCENARIO_GAME_STREAMING(3)` before calling this method.
   *
   * @note
   * - You can call this method either before or after joining a channel.
   * - Do not set the profile `parameter` of `setAudioProfile` to `AUDIO_PROFILE_SPEECH_STANDARD(1)` or `AUDIO_PROFILE_IOT(6)`;
   * otherwise, this method call does not take effect.
   * - This method works best with the human voice. Agora does not recommend using this method for audio containing music.
   * - If you call this method and set the `preset` parameter to enumerators except `ROOM_ACOUSTICS_3D_VOICE` or `PITCH_CORRECTION`,
   * do not call \ref IRtcEngine::setAudioEffectParameters "setAudioEffectParameters"; otherwise, `setAudioEffectParameters`
   * overrides this method.
   * - After calling this method, Agora recommends not calling the following methods, because they can override `setAudioEffectPreset`:
   *  - \ref IRtcEngine::setVoiceBeautifierPreset "setVoiceBeautifierPreset"
   *  - \ref IRtcEngine::setLocalVoiceReverbPreset "setLocalVoiceReverbPreset"
   *  - \ref IRtcEngine::setLocalVoiceChanger "setLocalVoiceChanger"
   *  - \ref IRtcEngine::setLocalVoicePitch "setLocalVoicePitch"
   *  - \ref IRtcEngine::setLocalVoiceEqualization "setLocalVoiceEqualization"
   *  - \ref IRtcEngine::setLocalVoiceReverb "setLocalVoiceReverb"
   *  - \ref IRtcEngine::setVoiceBeautifierParameters "setVoiceBeautifierParameters"
   *  - \ref IRtcEngine::setVoiceConversionPreset "setVoiceConversionPreset"
   *
   * @param preset The options for SDK preset audio effects. See #AUDIO_EFFECT_PRESET.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setAudioEffectPreset(AUDIO_EFFECT_PRESET preset) = 0;
  /** Sets an SDK preset voice conversion effect.
   *
   * @since v3.3.1
   *
   * Call this method to set an SDK preset voice conversion effect for the
   * local user who sends an audio stream. After setting a voice conversion
   * effect, all users in the channel can hear the effect.
   *
   * You can set different voice conversion effects for different scenarios.
   * See *Set the Voice Effect*.
   *
   * To achieve better voice effect quality, Agora recommends calling
   * \ref IRtcEngine::setAudioProfile "setAudioProfile" and setting the
   * `profile` parameter to #AUDIO_PROFILE_MUSIC_HIGH_QUALITY (4) or
   * #AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO (5) and the `scenario`
   * parameter to #AUDIO_SCENARIO_GAME_STREAMING (3) before calling this
   * method.
   *
   * @note
   * - You can call this method either before or after joining a channel.
   * - Do not set the `profile` parameter of `setAudioProfile` to
   * #AUDIO_PROFILE_SPEECH_STANDARD (1) or
   * #AUDIO_PROFILE_IOT (6); otherwise, this method call does not take effect.
   * - This method works best with the human voice. Agora does not recommend
   * using this method for audio containing music.
   * - After calling this method, Agora recommends not calling the following
   * methods, because they can override `setVoiceConversionPreset`:
   *  - \ref IRtcEngine::setAudioEffectPreset "setAudioEffectPreset"
   *  - \ref IRtcEngine::setAudioEffectParameters "setAudioEffectParameters"
   *  - \ref IRtcEngine::setVoiceBeautifierPreset "setVoiceBeautifierPreset"
   *  - \ref IRtcEngine::setVoiceBeautifierParameters "setVoiceBeautifierParameters"
   *  - \ref IRtcEngine::setLocalVoiceReverbPreset "setLocalVoiceReverbPreset"
   *  - \ref IRtcEngine::setLocalVoiceChanger "setLocalVoiceChanger"
   *  - \ref IRtcEngine::setLocalVoicePitch "setLocalVoicePitch"
   *  - \ref IRtcEngine::setLocalVoiceEqualization "setLocalVoiceEqualization"
   *  - \ref IRtcEngine::setLocalVoiceReverb "setLocalVoiceReverb"
   *
   * @param preset The options for SDK preset voice conversion effects: #VOICE_CONVERSION_PRESET.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setVoiceConversionPreset(VOICE_CONVERSION_PRESET preset) = 0;
  /** Sets parameters for SDK preset audio effects.
   *
   * @since v3.2.0
   *
   * Call this method to set the following parameters for the local user who sends an audio stream:
   * - 3D voice effect: Sets the cycle period of the 3D voice effect.
   * - Pitch correction effect: Sets the basic mode and tonic pitch of the pitch correction effect. Different songs
   * have different modes and tonic pitches. Agora recommends bounding this method with interface elements to enable
   * users to adjust the pitch correction interactively.
   *
   * After setting parameters, all users in the channel can hear the relevant effect.
   *
   *
   * @note
   * - You can call this method either before or after joining a channel.
   * - To achieve better audio effect quality, Agora recommends calling \ref IRtcEngine::setAudioProfile "setAudioProfile"
   * and setting the `scenario` parameter to `AUDIO_SCENARIO_GAME_STREAMING(3)` before calling this method.
   * - Do not set the `profile` parameter of \ref IRtcEngine::setAudioProfile "setAudioProfile" to `AUDIO_PROFILE_SPEECH_STANDARD(1)` or
   * `AUDIO_PROFILE_IOT(6)`; otherwise, this method call does not take effect.
   * - This method works best with the human voice. Agora does not recommend using this method for audio containing music.
   * - After calling this method, Agora recommends not calling the following methods, because they can override `setAudioEffectParameters`:
   *  - \ref IRtcEngine::setAudioEffectPreset "setAudioEffectPreset"
   *  - \ref IRtcEngine::setVoiceBeautifierPreset "setVoiceBeautifierPreset"
   *  - \ref IRtcEngine::setLocalVoiceReverbPreset "setLocalVoiceReverbPreset"
   *  - \ref IRtcEngine::setLocalVoiceChanger "setLocalVoiceChanger"
   *  - \ref IRtcEngine::setLocalVoicePitch "setLocalVoicePitch"
   *  - \ref IRtcEngine::setLocalVoiceEqualization "setLocalVoiceEqualization"
   *  - \ref IRtcEngine::setLocalVoiceReverb "setLocalVoiceReverb"
   *  - \ref IRtcEngine::setVoiceBeautifierParameters "setVoiceBeautifierParameters"
   *  - \ref IRtcEngine::setVoiceConversionPreset "setVoiceConversionPreset"
   * @param preset The options for SDK preset audio effects:
   * - 3D voice effect: `ROOM_ACOUSTICS_3D_VOICE`.
   *  - Call \ref IRtcEngine::setAudioProfile "setAudioProfile" and set the `profile` parameter to `AUDIO_PROFILE_MUSIC_STANDARD_STEREO(3)`
   * or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before setting this enumerator; otherwise, the enumerator setting does not take effect.
   *  - If the 3D voice effect is enabled, users need to use stereo audio playback devices to hear the anticipated voice effect.
   * - Pitch correction effect: `PITCH_CORRECTION`. To achieve better audio effect quality, Agora recommends calling
   * \ref IRtcEngine::setAudioProfile "setAudioProfile" and setting the `profile` parameter to `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before setting this enumerator.
   * @param param1
   * - If you set `preset` to `ROOM_ACOUSTICS_3D_VOICE`, the `param1` sets the cycle period of the 3D voice effect.
   * The value range is [1,60] and the unit is a second. The default value is 10 seconds, indicating that the voice moves
   * around you every 10 seconds.
   * - If you set `preset` to `PITCH_CORRECTION`, `param1` sets the basic mode of the pitch correction effect:
   *  - `1`: (Default) Natural major scale.
   *  - `2`: Natural minor scale.
   *  - `3`: Japanese pentatonic scale.
   * @param param2
   * - If you set `preset` to `ROOM_ACOUSTICS_3D_VOICE`, you need to set `param2` to `0`.
   * - If you set `preset` to `PITCH_CORRECTION`, `param2` sets the tonic pitch of the pitch correction effect:
   *  - `1`: A
   *  - `2`: A#
   *  - `3`: B
   *  - `4`: (Default) C
   *  - `5`: C#
   *  - `6`: D
   *  - `7`: D#
   *  - `8`: E
   *  - `9`: F
   *  - `10`: F#
   *  - `11`: G
   *  - `12`: G#
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setAudioEffectParameters(AUDIO_EFFECT_PRESET preset, int param1, int param2) = 0;
  /** Sets parameters for SDK preset voice beautifier effects.
   *
   * @since v3.3.0
   *
   * Call this method to set a gender characteristic and a reverberation effect for the singing beautifier effect. This method sets parameters for the local user who sends an audio stream.
   *
   * After you call this method successfully, all users in the channel can hear the relevant effect.
   *
   * To achieve better audio effect quality, before you call this method, Agora recommends calling \ref IRtcEngine::setAudioProfile "setAudioProfile", and setting the `scenario` parameter
   * as `AUDIO_SCENARIO_GAME_STREAMING(3)` and the `profile` parameter as `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)`.
   *
   * @note
   * - You can call this method either before or after joining a channel.
   * - Do not set the `profile` parameter of \ref IRtcEngine::setAudioProfile "setAudioProfile" as `AUDIO_PROFILE_SPEECH_STANDARD(1)` or `AUDIO_PROFILE_IOT(6)`; otherwise, this method call does not take effect.
   * - This method works best with the human voice. Agora does not recommend using this method for audio containing music.
   * - After you call this method, Agora recommends not calling the following methods, because they can override `setVoiceBeautifierParameters`:
   *    - \ref IRtcEngine::setAudioEffectPreset "setAudioEffectPreset"
   *    - \ref IRtcEngine::setAudioEffectParameters "setAudioEffectParameters"
   *    - \ref IRtcEngine::setVoiceBeautifierPreset "setVoiceBeautifierPreset"
   *    - \ref IRtcEngine::setLocalVoiceReverbPreset "setLocalVoiceReverbPreset"
   *    - \ref IRtcEngine::setLocalVoiceChanger "setLocalVoiceChanger"
   *    - \ref IRtcEngine::setLocalVoicePitch "setLocalVoicePitch"
   *    - \ref IRtcEngine::setLocalVoiceEqualization "setLocalVoiceEqualization"
   *    - \ref IRtcEngine::setLocalVoiceReverb "setLocalVoiceReverb"
   *    - \ref IRtcEngine::setVoiceConversionPreset "setVoiceConversionPreset"
   *
   * @param preset The options for SDK preset voice beautifier effects:
   * - `SINGING_BEAUTIFIER`: Singing beautifier effect.
   * @param param1 The gender characteristics options for the singing voice:
   * - `1`: A male-sounding voice.
   * - `2`: A female-sounding voice.
   * @param param2 The reverberation effects options:
   * - `1`: The reverberation effect sounds like singing in a small room.
   * - `2`: The reverberation effect sounds like singing in a large room.
   * - `3`: The reverberation effect sounds like singing in a hall.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setVoiceBeautifierParameters(VOICE_BEAUTIFIER_PRESET preset, int param1, int param2) = 0;
  /** Sets the log files that the SDK outputs.
   *
   * @deprecated This method is deprecated from v3.3.0. Use `logConfig` in the \ref IRtcEngine::initialize "initialize" method instead.
   *
   * By default, the SDK outputs five log files, `agorasdk.log`, `agorasdk_1.log`, `agorasdk_2.log`, `agorasdk_3.log`, `agorasdk_4.log`, each with a default size of 1024 KB.
   * These log files are encoded in UTF-8. The SDK writes the latest logs in `agorasdk.log`. When `agorasdk.log` is full, the SDK deletes the log file with the earliest
   * modification time among the other four, renames `agorasdk.log` to the name of the deleted log file, and create a new `agorasdk.log` to record latest logs.
   *
   * @note Ensure that you call this method immediately after calling \ref agora::rtc::IRtcEngine::initialize "initialize" , otherwise the output logs may not be complete.
   *
   * @see \ref IRtcEngine::setLogFileSize "setLogFileSize"
   * @see \ref IRtcEngine::setLogFilter "setLogFilter"
   *
   * @param filePath The absolute path of log files. The default file path is `C: \Users\<user_name>\AppData\Local\Agora\<process_name>\agorasdk.log`.
   * Ensure that the directory for the log files exists and is writable. You can use this parameter to rename the log files.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setLogFile(const char* filePath) AGORA_DEPRECATED_ATTRIBUTE = 0;
  /// @cond nodoc
  /** Specifies an SDK external log writer.

   The external log writer output all SDK operations during runtime if it  exist.

   @note
   - Ensure that you call this method  after calling the \ref agora::rtc::IRtcEngine::initialize "initialize" method.

   @param pLogWriter .

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setLogWriter(agora::commons::ILogWriter* pLogWriter) = 0;

  /** Set the value of external log writer to null
   @note
   - Ensure that you call this method  after calling the \ref agora::rtc::IRtcEngine::initialize "initialize" method.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int releaseLogWriter() = 0;
  /// @endcond
  /** Sets the output log level of the SDK.

   @deprecated This method is deprecated from v3.3.0. Use `logConfig` in the \ref IRtcEngine::initialize "initialize" method instead.

   You can use one or a combination of the log filter levels. The log level follows the sequence of OFF, CRITICAL, ERROR, WARNING, INFO, and DEBUG. Choose a level to see the logs preceding that level.

   If you set the log level to WARNING, you see the logs within levels CRITICAL, ERROR, and WARNING.

   @see \ref IRtcEngine::setLogFile "setLogFile"
   @see \ref IRtcEngine::setLogFileSize "setLogFileSize"

   @param filter Sets the log filter level. See #LOG_FILTER_TYPE.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setLogFilter(unsigned int filter) AGORA_DEPRECATED_ATTRIBUTE = 0;
  /** Sets the size of a log file that the SDK outputs.
   *
   * @deprecated This method is deprecated from v3.3.0. Use `logConfig` in the \ref IRtcEngine::initialize "initialize" method instead.
   *
   * @note If you want to set the log file size, ensure that you call
   * this method before \ref IRtcEngine::setLogFile "setLogFile", or the logs are cleared.
   *
   * By default, the SDK outputs five log files, `agorasdk.log`, `agorasdk_1.log`, `agorasdk_2.log`, `agorasdk_3.log`, `agorasdk_4.log`, each with a default size of 1024 KB.
   * These log files are encoded in UTF-8. The SDK writes the latest logs in `agorasdk.log`. When `agorasdk.log` is full, the SDK deletes the log file with the earliest
   * modification time among the other four, renames `agorasdk.log` to the name of the deleted log file, and create a new `agorasdk.log` to record latest logs.
   *
   * @see \ref IRtcEngine::setLogFile "setLogFile"
   * @see \ref IRtcEngine::setLogFilter "setLogFilter"
   *
   * @param fileSizeInKBytes The size (KB) of a log file. The default value is 1024 KB. If you set `fileSizeInKByte` to 1024 KB,
   * the SDK outputs at most 5 MB log files; if you set it to less than 1024 KB, the maximum size of a log file is still 1024 KB.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setLogFileSize(unsigned int fileSizeInKBytes) AGORA_DEPRECATED_ATTRIBUTE = 0;
  /// @cond nodoc
  /** Uploads all SDK log files.
   *
   * @since v3.3.0
   *
   * Uploads all SDK log files from the client to the Agora server.
   * After a successful method call, the SDK triggers the \ref agora::rtc::IRtcEngineEventHandler::onUploadLogResult "onUploadLogResult" callback
   * to report whether the log files are successfully uploaded to the Agora server.
   *
   *
   * For easier debugging, Agora recommends that you bind this method to the UI element of your App, so as to instruct the
   * user to upload a log file when a quality issue occurs.
   *
   * @note Do not call this method more than once per minute, otherwise the SDK reports #ERR_TOO_OFTEN (12).
   *
   * @param[out] requestId The request ID. This request ID is the same as requestId in the \ref IRtcEngineEventHandler::onUploadLogResult "onUploadLogResult" callback,
   * and you can use the request ID to match a specific upload with a callback.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *   - -12(ERR_TOO_OFTEN): The call frequency exceeds the limit.
   */
  virtual int uploadLogFile(agora::util::AString& requestId) = 0;
  /// @endcond
  /**
   @deprecated This method is deprecated, use the \ref IRtcEngine::setLocalRenderMode(RENDER_MODE_TYPE renderMode, VIDEO_MIRROR_MODE_TYPE mirrorMode) "setLocalRenderMode" [2/2] method instead.
   Sets the local video display mode.

   This method can be called multiple times during a call to change the display mode.

   @param renderMode  Sets the local video display mode. See #RENDER_MODE_TYPE.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setLocalRenderMode(RENDER_MODE_TYPE renderMode) AGORA_DEPRECATED_ATTRIBUTE = 0;
  /** Updates the display mode of the local video view.

   @since v3.0.0

   After initializing the local video view, you can call this method to update its rendering and mirror modes. It affects only the video view that the local user sees, not the published local video stream.

   @note
   - Ensure that you have called the \ref IRtcEngine::setupLocalVideo "setupLocalVideo" method to initialize the local video view before calling this method.
   - During a call, you can call this method as many times as necessary to update the display mode of the local video view.
   @param renderMode The rendering mode of the local video view. See #RENDER_MODE_TYPE.
   @param mirrorMode
   - The mirror mode of the local video view. See #VIDEO_MIRROR_MODE_TYPE.
   - **Note**: If you use a front camera, the SDK enables the mirror mode by default; if you use a rear camera, the SDK disables the mirror mode by default.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setLocalRenderMode(RENDER_MODE_TYPE renderMode, VIDEO_MIRROR_MODE_TYPE mirrorMode) = 0;
  /**
   @deprecated This method is deprecated, use the \ref IRtcEngine::setRemoteRenderMode(uid_t userId, RENDER_MODE_TYPE renderMode, VIDEO_MIRROR_MODE_TYPE mirrorMode) "setRemoteRenderMode" [2/2] method instead.
   Sets the video display mode of a specified remote user.

   This method can be called multiple times during a call to change the display mode.

   @param userId ID of the remote user.
   @param renderMode  Sets the video display mode. See #RENDER_MODE_TYPE.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setRemoteRenderMode(uid_t userId, RENDER_MODE_TYPE renderMode) AGORA_DEPRECATED_ATTRIBUTE = 0;
  /** Updates the display mode of the video view of a remote user.

   @since v3.0.0
   After initializing the video view of a remote user, you can call this method to update its rendering and mirror modes. This method affects only the video view that the local user sees.

   @note
   - Ensure that you have called the \ref IRtcEngine::setupRemoteVideo "setupRemoteVideo" method to initialize the remote video view before calling this method.
   - During a call, you can call this method as many times as necessary to update the display mode of the video view of a remote user.

   @param userId The ID of the remote user.
   @param renderMode The rendering mode of the remote video view. See #RENDER_MODE_TYPE.
   @param mirrorMode
   - The mirror mode of the remote video view. See #VIDEO_MIRROR_MODE_TYPE.
   - **Note**: The SDK disables the mirror mode by default.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setRemoteRenderMode(uid_t userId, RENDER_MODE_TYPE renderMode, VIDEO_MIRROR_MODE_TYPE mirrorMode) = 0;
  /**
   @deprecated This method is deprecated, use the \ref IRtcEngine::setupLocalVideo "setupLocalVideo"
   or \ref IRtcEngine::setLocalRenderMode(RENDER_MODE_TYPE renderMode, VIDEO_MIRROR_MODE_TYPE mirrorMode) "setLocalRenderMode" method instead.

   Sets the local video mirror mode.

   @warning Call this method after calling the \ref agora::rtc::IRtcEngine::setupLocalVideo "setupLocalVideo" method to initialize the local video view.

   @param mirrorMode Sets the local video mirror mode. See #VIDEO_MIRROR_MODE_TYPE.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setLocalVideoMirrorMode(VIDEO_MIRROR_MODE_TYPE mirrorMode) AGORA_DEPRECATED_ATTRIBUTE = 0;
  /** Sets the stream mode to the single-stream (default) or dual-stream mode.

   If the dual-stream mode is enabled, the receiver can choose to receive the high stream (high-resolution and high-bitrate video stream), or the low stream (low-resolution and low-bitrate video stream).

   @note You can call this method either before or after joining a channel.

   @param enabled Sets the stream mode:
   - true: Dual-stream mode.
   - false: Single-stream mode.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int enableDualStreamMode(bool enabled) = 0;
  /** Sets the external audio source.

   @note Please call this method before \ref agora::rtc::IRtcEngine::joinChannel "joinChannel"
   and \ref IRtcEngine::startPreview "startPreview".

   @param enabled Sets whether to enable/disable the external audio source:
   - true: Enable the external audio source.
   - false: (Default) Disables the external audio source.
   @param sampleRate Sets the sample rate (Hz) of the external audio source, which can be set as 8000, 16000, 32000, 44100, or 48000 Hz.
   @param channels Sets the number of audio channels of the external audio source:
   - 1: Mono.
   - 2: Stereo.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setExternalAudioSource(bool enabled, int sampleRate, int channels) = 0;
  /** Sets the external audio sink.
   * This method applies to scenarios where you want to use external audio
   * data for playback. After enabling the external audio sink, you can call
   * the \ref agora::media::IMediaEngine::pullAudioFrame "pullAudioFrame" method to pull the remote audio data, process
   * it, and play it with the audio effects that you want.
   *
   * @note
   * - Once you enable the external audio sink, the app will not get any
   * audio data from the
   * \ref agora::media::IAudioFrameObserver::onPlaybackAudioFrame "onPlaybackAudioFrame" callback.
   * - Ensure that you call this method before joining a channel.
   *
   * @param enabled
   * - true: Enable the external audio sink.
   * - false: (Default) Disables the external audio sink.
   * @param sampleRate Sets the sample rate (Hz) of the external audio sink, which can be set as 16000, 32000, 44100 or 48000.
   * @param channels Sets the number of audio channels of the external
   * audio sink:
   * - 1: Mono.
   * - 2: Stereo.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setExternalAudioSink(bool enabled, int sampleRate, int channels) = 0;
  /** Sets the audio recording format for the \ref agora::media::IAudioFrameObserver::onRecordAudioFrame "onRecordAudioFrame" callback.

   @note Ensure that you call this method before joining a channel.

   @param sampleRate Sets the sample rate (@p samplesPerSec) returned in the *onRecordAudioFrame* callback, which can be set as 8000, 16000, 32000, 44100, or 48000 Hz.
   @param channel Sets the number of audio channels (@p channels) returned in the *onRecordAudioFrame* callback:
   - 1: Mono
   - 2: Stereo
   @param mode Sets the use mode (see #RAW_AUDIO_FRAME_OP_MODE_TYPE) of the *onRecordAudioFrame* callback.
   @param samplesPerCall Sets the number of samples returned in the *onRecordAudioFrame* callback. `samplesPerCall` is usually set as 1024 for RTMP or RTMPS streaming.


   @note The SDK triggers the `onRecordAudioFrame` callback according to the sample interval. Ensure that the sample interval ≥ 0.01 (s). And, Sample interval (sec) = `samplePerCall`/(`sampleRate` × `channel`).

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setRecordingAudioFrameParameters(int sampleRate, int channel, RAW_AUDIO_FRAME_OP_MODE_TYPE mode, int samplesPerCall) = 0;
  /** Sets the audio playback format for the \ref agora::media::IAudioFrameObserver::onPlaybackAudioFrame "onPlaybackAudioFrame" callback.

   @note Ensure that you call this method before joining a channel.

   @param sampleRate Sets the sample rate (@p samplesPerSec) returned in the *onPlaybackAudioFrame* callback, which can be set as 8000, 16000, 32000, 44100, or 48000 Hz.
   @param channel Sets the number of channels (@p channels) returned in the *onPlaybackAudioFrame* callback:
   - 1: Mono
   - 2: Stereo
   @param mode Sets the use mode (see #RAW_AUDIO_FRAME_OP_MODE_TYPE) of the *onPlaybackAudioFrame* callback.
   @param samplesPerCall Sets the number of samples returned in the *onPlaybackAudioFrame* callback. `samplesPerCall` is usually set as 1024 for RTMP or RTMPS streaming.

   @note The SDK triggers the `onPlaybackAudioFrame` callback according to the sample interval. Ensure that the sample interval ≥ 0.01 (s). And, Sample interval (sec) = `samplePerCall`/(`sampleRate` × `channel`).

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setPlaybackAudioFrameParameters(int sampleRate, int channel, RAW_AUDIO_FRAME_OP_MODE_TYPE mode, int samplesPerCall) = 0;
  /** Sets the mixed audio format for the \ref agora::media::IAudioFrameObserver::onMixedAudioFrame "onMixedAudioFrame" callback.

   @note Ensure that you call this method before joining a channel.

   @param sampleRate Sets the sample rate (@p samplesPerSec) returned in the *onMixedAudioFrame* callback, which can be set as 8000, 16000, 32000, 44100, or 48000 Hz.
   @param samplesPerCall Sets the number of samples (`samples`) returned in the *onMixedAudioFrame* callback. `samplesPerCall` is usually set as 1024 for RTMP or RTMPS streaming.

   @note The SDK triggers the `onMixedAudioFrame` callback according to the sample interval. Ensure that the sample interval ≥ 0.01 (s). And, Sample interval (sec) = `samplePerCall`/(`sampleRate` × `channels`).

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setMixedAudioFrameParameters(int sampleRate, int samplesPerCall) = 0;
  /** Adjusts the volume of the signal captured by the microphone.
   *
   * @note You can call this method either before or after joining a channel.
   *
   * @param volume The volume of the signal captured by the microphone.
   * The value ranges between 0 and 400, including the following:
   * - 0: Mute.
   * - 100: (Default) Original volume.
   * - 400: Four times the original volume with signal-clipping protection.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int adjustRecordingSignalVolume(int volume) = 0;
  /** Adjusts the playback signal volume of all remote users.
   *
   * @note
   * - This method adjusts the playback volume that is the mixed volume of all
   * remote users.
   * - You can call this method either before or after joining a channel.
   * - (Since v2.3.2) To mute the local audio playback, call both the
   * `adjustPlaybackSignalVolume` and
   * \ref IRtcEngine::adjustAudioMixingVolume "adjustAudioMixingVolume"
   * methods and set the volume as `0`.
   *
   * @param volume The playback volume. The value ranges between 0 and 400,
   * including the following:
   * - 0: Mute.
   * - 100: (Default) Original volume.
   * - 400: Four times the original volume with signal-clipping protection.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int adjustPlaybackSignalVolume(int volume) = 0;
  /**
   * Adjusts the volume of the signal captured by the sound card.
   *
   * @since v3.4.0
   *
   * After calling enableLoopbackRecording to enable loopback audio capturing,
   * you can call this method to adjust the volume of the signal captured by
   * the sound card.
   *
   * @note This method applies to Windows and macOS only.
   *
   * @param volume The volume of the signal captured by the sound card.
   * The value ranges between 0 and 100, including the following:
   * - 0: Mute.
   * - 100: (Default) Original volume.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int adjustLoopbackRecordingSignalVolume(int volume) = 0;
  /**
   @deprecated This method is deprecated. As of v3.0.0, the Native SDK automatically enables interoperability with the Web SDK, so you no longer need to call this method.
   Enables interoperability with the Agora Web SDK.

   @note
   - This method applies to the `LIVE_BROADCASTING` profile. In the `COMMUNICATION` profile, interoperability with the Agora Web SDK is enabled by default.
   - If the channel has Web SDK users, ensure that you call this method, or the video of the Native user will be a black screen for the Web user.

   @param enabled Sets whether to enable/disable interoperability with the Agora Web SDK:
   - true: Enable.
   - false: (Default) Disable.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int enableWebSdkInteroperability(bool enabled) AGORA_DEPRECATED_ATTRIBUTE = 0;
  // only for live broadcast
  /** **DEPRECATED** Sets the preferences for the high-quality video. (`LIVE_BROADCASTING` only).

   This method is deprecated as of v2.4.0.

   @param preferFrameRateOverImageQuality Sets the video quality preference:
   - true: Frame rate over image quality.
   - false: (Default) Image quality over frame rate.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setVideoQualityParameters(bool preferFrameRateOverImageQuality) = 0;
  /** Sets the fallback option for the published video stream based on the network conditions.

   If `option` is set as #STREAM_FALLBACK_OPTION_AUDIO_ONLY (2), the SDK will:

   - Disable the upstream video but enable audio only when the network conditions deteriorate and cannot support both video and audio.
   - Re-enable the video when the network conditions improve.

   When the published video stream falls back to audio only or when the audio-only stream switches back to the video, the SDK triggers the \ref agora::rtc::IRtcEngineEventHandler::onLocalPublishFallbackToAudioOnly "onLocalPublishFallbackToAudioOnly" callback.

   @note
   - Agora does not recommend using this method for CDN live streaming, because the remote CDN live user will have a noticeable lag when the published video stream falls back to audio only.
   - Ensure that you call this method before joining a channel.

   @param option Sets the fallback option for the published video stream:
   - #STREAM_FALLBACK_OPTION_DISABLED (0): (Default) No fallback behavior for the published video stream when the uplink network condition is poor. The stream quality is not guaranteed.
   - #STREAM_FALLBACK_OPTION_AUDIO_ONLY (2): The published video stream falls back to audio only when the uplink network condition is poor.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setLocalPublishFallbackOption(STREAM_FALLBACK_OPTIONS option) = 0;
  /** Sets the fallback option for the remotely subscribed video stream based on the network conditions.

   The default setting for `option` is #STREAM_FALLBACK_OPTION_VIDEO_STREAM_LOW (1), where the remotely subscribed video stream falls back to the low-stream video (low resolution and low bitrate) under poor downlink network conditions.

   If `option` is set as #STREAM_FALLBACK_OPTION_AUDIO_ONLY (2), the SDK automatically switches the video from a high-stream to a low-stream, or disables the video when the downlink network conditions cannot support both audio and video to guarantee the quality of the audio. The SDK monitors the network quality and restores the video stream when the network conditions improve.

   When the remotely subscribed video stream falls back to audio only or when the audio-only stream switches back to the video stream, the SDK triggers the \ref agora::rtc::IRtcEngineEventHandler::onRemoteSubscribeFallbackToAudioOnly "onRemoteSubscribeFallbackToAudioOnly" callback.

   @note Ensure that you call this method before joining a channel.

   @param  option  Sets the fallback option for the remotely subscribed video stream. See #STREAM_FALLBACK_OPTIONS.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setRemoteSubscribeFallbackOption(STREAM_FALLBACK_OPTIONS option) = 0;

#if defined(__ANDROID__) || (defined(__APPLE__) && TARGET_OS_IOS)
  /** Switches between front and rear cameras.

   @note
   - This method is for Android and iOS only.
   - Ensure that you call this method after the camera starts, for example, by
   calling \ref IRtcEngine::startPreview "startPreview" or \ref IRtcEngine::joinChannel "joinChannel".

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int switchCamera() = 0;
  /// @cond nodoc
  /** Switches between front and rear cameras.

   @note This method is for Android and iOS only.
   @note This method is private.

   @param direction Sets the camera to be used:
   - CAMERA_DIRECTION.CAMERA_REAR: Use the rear camera.
   - CAMERA_DIRECTION.CAMERA_FRONT: Use the front camera.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int switchCamera(CAMERA_DIRECTION direction) = 0;
  /// @endcond
  /**
   * Sets the default audio route.
   *
   * If the default audio route of the SDK (see *Set the Audio Route*) cannot meet your requirements, you can
   * call this method to switch the default audio route. After successfully switching the audio route, the SDK
   * triggers the \ref IRtcEngineEventHandler::onAudioRouteChanged "onAudioRouteChanged" callback to indicate the changes.
   *
   * @note
   * - This method applies to Android and iOS only.
   * - Call this method before calling \ref IRtcEngine::joinChannel "joinChannel". If you need to switch the audio
   * route after joining a channel, call \ref IRtcEngine::setEnableSpeakerphone "setEnableSpeakerphone".
   * - If the user uses an external audio playback device such as a Bluetooth or wired headset, this method does not
   * take effect, and the SDK plays audio through the external device. When the user uses multiple external devices,
   * the SDK plays audio through the last connected device.
   *
   * @param defaultToSpeaker Sets the default audio route as follows:
   * - true: Set to the speakerphone.
   * - false: Set to the earpiece.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setDefaultAudioRouteToSpeakerphone(bool defaultToSpeaker) = 0;
  /**
   * Enables/Disables the audio route to the speakerphone.
   *
   * If the default audio route of the SDK (see *Set the Audio Route*) or the
   * setting in \ref IRtcEngine::setDefaultAudioRouteToSpeakerphone "setDefaultAudioRouteToSpeakerphone"
   * cannot meet your requirements, you can call this method to switch the current audio route.
   * After successfully switching the audio route, the SDK triggers the
   * \ref IRtcEngineEventHandler::onAudioRouteChanged "onAudioRouteChanged" callback to indicate the changes.
   *
   * This method only sets the audio route in the current channel and does not influence the default audio route.
   * If the user leaves the current channel and joins another channel, the default audio route is used.
   *
   * @note
   * - This method applies to Android and iOS only.
   * - Call this method after calling joinChannel.
   * - If the user uses an external audio playback device such as a Bluetooth or wired headset, this method
   * does not take effect, and the SDK plays audio through the external device. When the user uses multiple external
   * devices, the SDK plays audio through the last connected device.
   *
   * @param speakerOn Sets whether to enable the speakerphone or earpiece:
   * - true: Enable the speakerphone. The audio route is the speakerphone.
   * - false: Disable the speakerphone. The audio route is the earpiece.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setEnableSpeakerphone(bool speakerOn) = 0;
  /** Enables in-ear monitoring (for Android and iOS only).
   *
   * @note
   * - Users must use wired earphones to hear their own voices.
   * - You can call this method either before or after joining a channel.
   *
   * @param enabled Determines whether to enable in-ear monitoring.
   * - true: Enable.
   * - false: (Default) Disable.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int enableInEarMonitoring(bool enabled) = 0;
  /** Sets the volume of the in-ear monitor.
   *
   * @note
   * - This method is for Android and iOS only.
   * - Users must use wired earphones to hear their own voices.
   * - You can call this method either before or after joining a channel.
   *
   * @param volume Sets the volume of the in-ear monitor. The value ranges between 0 and 100 (default).
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setInEarMonitoringVolume(int volume) = 0;
  /** Checks whether the speakerphone is enabled.

   @note
   - This method is for Android and iOS only.
   - You can call this method either before or after joining a channel.

   @return
   - true: The speakerphone is enabled, and the audio plays from the speakerphone.
   - false: The speakerphone is not enabled, and the audio plays from devices other than the speakerphone. For example, the headset or earpiece.
   */
  virtual bool isSpeakerphoneEnabled() = 0;
#endif

#if (defined(__APPLE__) && TARGET_OS_IOS)
  /** Sets the operational permission of the SDK on the audio session.
   *
   * The SDK and the app can both configure the audio session by default. If
   * you need to only use the app to configure the audio session, this method
   * restricts the operational permission of the SDK on the audio session.
   *
   * You can call this method either before or after joining a channel. Once
   * you call this method to restrict the operational permission of the SDK
   * on the audio session, the restriction takes effect when the SDK needs to
   * change the audio session.
   *
   * @note
   * - This method is for iOS only.
   * - This method does not restrict the operational permission of the app on
   * the audio session.
   *
   * @param restriction The operational permission of the SDK on the audio session.
   * See #AUDIO_SESSION_OPERATION_RESTRICTION. This parameter is in bit mask
   * format, and each bit corresponds to a permission.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setAudioSessionOperationRestriction(AUDIO_SESSION_OPERATION_RESTRICTION restriction) = 0;
#endif

#if (defined(__APPLE__) && TARGET_OS_MAC && !TARGET_OS_IPHONE) || defined(_WIN32)

  /** Enables loopback audio capturing.
   *
   * If you enable loopback audio capturing, the output of the sound card is mixed into the audio stream sent to the other end.
   *
   * @note
   * - This method is for macOS and Windows only.
   * - On macOS, call this method after joining a channel; on windows, call this method either before or after joining a channel.
   * - The default sound card on the macOS system does not support loopback audio capture. To enable this capture, you need to enable a virtual sound card and pass the name of the virtual sound card in the `deviceName` parameter.
   * Agora recommends that you use [AgoraALD (Agora Audio Loopback Device)](https://docs.agora.io/en/Interactive%20Broadcast/agoraald?platform=macOS) and pass in `"AgoraALD"`.
   *
   * @param enabled Sets whether to enable/disable loopback capturing.
   * - true: Enable loopback capturing.
   * - false: (Default) Disable loopback capturing.
   * @param deviceName The device name of the sound card. The default is set to null, which means the SDK uses the current sound card to capture. If you are using a virtual sound card, such as AgoraALD (Agora Audio Loopback Device), set this parameter as the name of the sound card (`"AgoraALD"`).
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *
   */
  virtual int enableLoopbackRecording(bool enabled, const char* deviceName = NULL) = 0;
  /**
   * Gets a list of shareable screens and windows.
   *
   * @since v3.5.2
   *
   * You can call this method before sharing a screen or window to get a list of shareable screens and windows, which
   * enables a user to use thumbnails in the list to easily choose a particular screen or window to share. This list
   * also contains important information such as window ID and screen ID, with which you can
   * call \ref IRtcEngine::startScreenCaptureByWindowId "startScreenCaptureByWindowId" or
   * \ref IRtcEngine::startScreenCaptureByDisplayId "startScreenCaptureByDisplayId" to start the sharing.
   *
   * @note This method applies to macOS and Windows only.
   *
   * @param thumbSize The target size of the screen or window thumbnail. The width and height are in pixels. See SIZE.
   * The SDK scales the original image to make the length of the longest side of the image the same as that of the
   * target size without distorting the original image. For example, if the original image is 400 × 300 and `thumbSize`
   * is 100 × 100, the actual size of the thumbnail is 100 × 75. If the target size is larger than the original size,
   * the thumbnail is the original image and the SDK does not scale it.
   * @param iconSize The target size of the icon corresponding to the application program. The width and height are in
   * pixels. See SIZE. The SDK scales the original image to make the length of the longest side of the image the same
   * as that of the target size without distorting the original image. For example, if the original image is 400 × 300
   * and `iconSize` is 100 × 100, the actual size of the icon is 100 × 75. If the target size is larger than the
   * original size, the icon is the original image and the SDK does not scale it.
   * @param includeScreen Whether the SDK returns screen information in addition to window information:
   * - true: The SDK returns screen and window information.
   * - false: The SDK returns window information only.
   *
   * @return IScreenCaptureSourceList
   */
  virtual IScreenCaptureSourceList* getScreenCaptureSources(const SIZE& thumbSize, const SIZE& iconSize, const bool includeScreen) = 0;

  /** Shares the whole or part of a screen by specifying the display ID.
   *
   * @note
   * - This method is for macOS and Windows only.
   * - Ensure that you call this method after joining a channel.
   *
   * @param displayId The display ID of the screen to be shared. Use this parameter to specify which screen you want to
   * share. For more information on how to get the display ID, see the advanced feature guide *Share the Screen* or get
   * the display ID from `sourceId` returned by \ref IRtcEngine::getScreenCaptureSources "getScreenCaptureSources".
   * @param regionRect (Optional) Sets the relative location of the region to the screen. NIL means sharing the whole screen. See Rectangle. If the specified region overruns the screen, the SDK shares only the region within it; if you set width or height as 0, the SDK shares the whole screen.
   * @param captureParams The screen sharing encoding parameters. The default video dimension is 1920 x 1080, that is, 2,073,600 pixels. Agora uses the value of `videoDimension` to calculate the charges.
   * For details, see descriptions in ScreenCaptureParameters.
   *
   *
   * @return
   * - 0: Success.
   * - < 0: Failure:
   *    - #ERR_INVALID_ARGUMENT: The argument is invalid.
   */
  virtual int startScreenCaptureByDisplayId(unsigned int displayId, const Rectangle& regionRect, const ScreenCaptureParameters& captureParams) = 0;

#if defined(_WIN32)
  /** Shares the whole or part of a screen by specifying the screen rect.
   *
   * @deprecated This method is deprecated as of v3.7.0, use \ref IRtcEngine::startScreenCaptureByDisplayId "startScreenCaptureByDisplayId" instead. Agora strongly recommends using `startScreenCaptureByDisplayId` if you need to start screen sharing on a device connected to another display.
   *
   * @note
   * - Ensure that you call this method after joining a channel.
   * - Applies to the Windows platform only.
   *
   *
   * @param screenRect Sets the relative location of the screen to the virtual screen. For information on how to get screenRect, see the advanced guide *Share Screen*.
   * @param regionRect (Optional) Sets the relative location of the region to the screen. NULL means sharing the whole screen. See Rectangle. If the specified region overruns the screen, the SDK shares only the region within it; if you set width or height as 0, the SDK shares the whole screen.
   * @param captureParams The screen sharing encoding parameters. The default video dimension is 1920 x 1080, that is, 2,073,600 pixels.
   * Agora uses the value of `videoDimension` to calculate the charges. For details, see descriptions in ScreenCaptureParameters.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure:
   *  - #ERR_INVALID_ARGUMENT: The argument is invalid.
   */
  virtual int startScreenCaptureByScreenRect(const Rectangle& screenRect, const Rectangle& regionRect, const ScreenCaptureParameters& captureParams) = 0;
#endif

  /** Shares the whole or part of a window by specifying the window ID.
   *
   * @note
   * - Ensure that you call this method after joining a channel.
   * - Applies to the macOS and Windows platforms only.
   * - The window sharing feature of the Agora SDK relies on WGC (Windows Graphics Capture) or GDI (Graphics Device Interface) capture, and WGC cannot be set to disable mouse capture on systems earlier than Windows 10 2004. Therefore, captureMouseCursor(false) might not work when you start window sharing on a device with a system earlier than Windows 10 2004. See [IsCursorCapture](https://docs.microsoft.com/en-us/uwp/api/windows.graphics.capture.graphicscapturesession.iscursorcaptureenabled?view=winrt-19041).
   *
   *
   * Since v3.0.0, this method supports window sharing of UWP (Universal Windows Platform) applications.
   *
   * Agora tests the mainstream UWP applications by using the lastest SDK, see details as follows:
   *
   * <table>
   *     <tr>
   *         <td><b>OS version</b></td>
   *         <td><b>Software</b></td>
   *         <td><b>Software name</b></td>
   *         <td><b>Whether support</b></td>
   *     </tr>
   *     <tr>
   *         <td rowspan="8">win10</td>
   *         <td >Chrome</td>
   *         <td>76.0.3809.100</td>
   *         <td>No</td>
   *     </tr>
   *     <tr>
   *         <td>Office Word</td>
   *         <td rowspan="3">18.1903.1152.0</td>
   *         <td>Yes</td>
   *     </tr>
   *         <tr>
   *         <td>Office Excel</td>
   *         <td>No</td>
   *     </tr>
   *     <tr>
   *         <td>Office PPT</td>
   *         <td>Yes</td>
   *     </tr>
   *  <tr>
   *         <td>WPS Word</td>
   *         <td rowspan="3">11.1.0.9145</td>
   *         <td rowspan="3">Yes</td>
   *     </tr>
   *         <tr>
   *         <td>WPS Excel</td>
   *     </tr>
   *     <tr>
   *         <td>WPS PPT</td>
   *     </tr>
   *         <tr>
   *         <td>Media Player (come with the system)</td>
   *         <td>All</td>
   *         <td>Yes</td>
   *     </tr>
   *      <tr>
   *         <td rowspan="8">win8</td>
   *         <td >Chrome</td>
   *         <td>All</td>
   *         <td>Yes</td>
   *     </tr>
   *     <tr>
   *         <td>Office Word</td>
   *         <td rowspan="3">All</td>
   *         <td rowspan="3">Yes</td>
   *     </tr>
   *         <tr>
   *         <td>Office Excel</td>
   *     </tr>
   *     <tr>
   *         <td>Office PPT</td>
   *     </tr>
   *  <tr>
   *         <td>WPS Word</td>
   *         <td rowspan="3">11.1.0.9098</td>
   *         <td rowspan="3">Yes</td>
   *     </tr>
   *         <tr>
   *         <td>WPS Excel</td>
   *     </tr>
   *     <tr>
   *         <td>WPS PPT</td>
   *     </tr>
   *         <tr>
   *         <td>Media Player(come with the system)</td>
   *         <td>All</td>
   *         <td>Yes</td>
   *     </tr>
   *   <tr>
   *         <td rowspan="8">win7</td>
   *         <td >Chrome</td>
   *         <td>73.0.3683.103</td>
   *         <td>No</td>
   *     </tr>
   *     <tr>
   *         <td>Office Word</td>
   *         <td rowspan="3">All</td>
   *         <td rowspan="3">Yes</td>
   *     </tr>
   *         <tr>
   *         <td>Office Excel</td>
   *     </tr>
   *     <tr>
   *         <td>Office PPT</td>
   *     </tr>
   *  <tr>
   *         <td>WPS Word</td>
   *         <td rowspan="2">11.1.0.9098</td>
   *         <td rowspan="2">No</td>
   *     </tr>
   *         <tr>
   *         <td>WPS Excel</td>
   *     </tr>
   *     <tr>
   *         <td>WPS PPT</td>
   *         <td>11.1.0.9098</td>
   *         <td>Yes</td>
   *     </tr>
   *         <tr>
   *         <td>Media Player(come with the system)</td>
   *         <td>All</td>
   *         <td>No</td>
   *     </tr>
   * </table>
   * @param  windowId The ID of the window to be shared. For information on how to get the windowId, see the advanced guide *Share Screen*.
   * @param  regionRect (Optional) The relative location of the region to the window. NULL/NIL means sharing the whole window. See Rectangle. If the specified region overruns the window, the SDK shares only the region within it; if you set width or height as 0, the SDK shares the whole window.
   * @param  captureParams The screen sharing encoding parameters. The default video dimension is 1920 x 1080, that is, 2,073,600 pixels. Agora uses the value of `videoDimension` to calculate the charges. For details, see descriptions in ScreenCaptureParameters.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure:
   *  - #ERR_INVALID_ARGUMENT: The argument is invalid.
   */
  virtual int startScreenCaptureByWindowId(view_t windowId, const Rectangle& regionRect, const ScreenCaptureParameters& captureParams) = 0;

  /** Sets the content hint for screen sharing.

   A content hint suggests the type of the content being shared, so that the SDK applies different optimization algorithm to different types of content.

   @note You can call this method either before or after you start screen sharing.

   @param  contentHint Sets the content hint for screen sharing. See VideoContentHint.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setScreenCaptureContentHint(VideoContentHint contentHint) = 0;
  /**
   * Sets the screen sharing scenario.
   *
   * @since v3.7.0
   *
   * When you start screen sharing or window sharing, you can call this method to set the screen sharing scenario. The SDK adjusts the video quality and experience of the sharing according to the scenario.
   *
   * @note This method is only available for the macOS and Windows platforms.
   *
   * @param screenScenario The screen sharing scenario. See #SCREEN_SCENARIO_TYPE.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setScreenCaptureScenario(SCREEN_SCENARIO_TYPE screenScenario) = 0;

  /** Updates the screen sharing parameters.

   @param  captureParams The screen sharing encoding parameters. The default video dimension is 1920 x 1080, that is,
   2,073,600 pixels. Agora uses the value of `videoDimension` to calculate the charges. For details,
   see descriptions in ScreenCaptureParameters.

   @return
   - 0: Success.
   - < 0: Failure:
      - #ERR_INVALID_ARGUMENT: The argument is invalid.
   */
  virtual int updateScreenCaptureParameters(const ScreenCaptureParameters& captureParams) = 0;

  /** Updates the screen sharing region.

   @param  regionRect Sets the relative location of the region to the screen or window. NULL means sharing the whole screen or window. See Rectangle. If the specified region overruns the screen or window, the SDK shares only the region within it; if you set width or height as 0, the SDK shares the whole screen or window.

   @return
   - 0: Success.
   - < 0: Failure:
      - #ERR_INVALID_ARGUMENT: The argument is invalid.
   */
  virtual int updateScreenCaptureRegion(const Rectangle& regionRect) = 0;

  /** Stop screen sharing.

   @return
   - 0: Success.
   - < 0: Failure.
  */
  virtual int stopScreenCapture() = 0;

#if defined(__APPLE__)
  typedef unsigned int WindowIDType;
#elif defined(_WIN32)
  typedef HWND WindowIDType;
#endif

  /** **DEPRECATED** Starts screen sharing.

   This method is deprecated as of v2.4.0. See the following methods instead:

   - \ref agora::rtc::IRtcEngine::startScreenCaptureByDisplayId "startScreenCaptureByDisplayId"
   - \ref agora::rtc::IRtcEngine::startScreenCaptureByWindowId "startScreenCaptureByWindowId"

   This method shares the whole screen, specified window, or specified region:

   - Whole screen: Set @p windowId as 0 and @p rect as NULL.
   - Specified window: Set @p windowId as a value other than 0. Each window has a @p windowId that is not 0.
   - Specified region: Set @p windowId as 0 and @p rect not as NULL. In this case, you can share the specified region, for example by dragging the mouse or implementing your own logic.

   @note The specified region is a region on the whole screen. Currently, sharing a specified region in a specific window is not supported.
   *captureFreq* is the captured frame rate once the screen-sharing function is enabled. The mandatory value ranges between 1 fps and 15 fps.

   @param windowId Sets the screen sharing area. See WindowIDType.
   @param captureFreq (Mandatory) The captured frame rate. The value ranges between 1 fps and 15 fps.
   @param rect Specifies the screen-sharing region. @p rect is valid when @p windowsId is set as 0. When @p rect is set as NULL, the whole screen is shared.
   @param bitrate The captured bitrate.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int startScreenCapture(WindowIDType windowId, int captureFreq, const Rect* rect, int bitrate) = 0;

  /** **DEPRECATED** Updates the screen capture region.

   @param rect Specifies the required region inside the screen or window.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int updateScreenCaptureRegion(const Rect* rect) = 0;
#endif

  /** Sets a custom video source.
   *
   * During real-time communication, the Agora SDK enables the default video input device, that is, the built-in camera to
   * capture video. If you need a custom video source, implement the IVideoSource class first, and call this method to add
   * the custom video source to the SDK.
   *
   * @note You can call this method either before or after joining a channel.
   *
   * @param source The custom video source. See IVideoSource.
   *
   * @return
   * - true: The custom video source is added to the SDK.
   * - false: The custom video source is not added to the SDK.
   */
  virtual bool setVideoSource(IVideoSource* source) = 0;

  /** Gets the current call ID.

   When a user joins a channel on a client, a @p callId is generated to identify the call from the client. Feedback methods, such as \ref IRtcEngine::rate "rate" and \ref IRtcEngine::complain "complain", must be called after the call ends to submit feedback to the SDK.

   The \ref IRtcEngine::rate "rate" and \ref IRtcEngine::complain "complain" methods require the @p callId parameter retrieved from the *getCallId* method during a call. @p callId is passed as an argument into the \ref IRtcEngine::rate "rate" and \ref IRtcEngine::complain "complain" methods after the call ends.

   @note Ensure that you call this method after joining a channel.

   @param callId Pointer to the current call ID.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int getCallId(agora::util::AString& callId) = 0;

  /** Allows a user to rate a call after the call ends.

   @note Ensure that you call this method after joining a channel.

   @param callId Pointer to the ID of the call, retrieved from the \ref IRtcEngine::getCallId "getCallId" method.
   @param rating  Rating of the call. The value is between 1 (lowest score) and 5 (highest score). If you set a value out of this range, the #ERR_INVALID_ARGUMENT (2) error returns.
   @param description (Optional) Pointer to the description of the rating, with a string length of less than 800 bytes.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int rate(const char* callId, int rating, const char* description) = 0;

  /** Allows a user to complain about the call quality after a call ends.

  @note Ensure that you call this method after joining a channel.

  @param callId Pointer to the ID of the call, retrieved from the \ref IRtcEngine::getCallId "getCallId" method.
  @param description (Optional) Pointer to the description of the complaint, with a string length of less than 800 bytes.

  @return
  - 0: Success.
  - < 0: Failure.

  */
  virtual int complain(const char* callId, const char* description) = 0;

  /** Gets the SDK version number.

   @param build Pointer to the build number.
   @return The version of the current SDK in the string format. For example, 2.3.1.
   */
  virtual const char* getVersion(int* build) = 0;

  /**  Enables the network connection quality test.

   This method tests the quality of the users' network connections and is disabled by default.

   Before a user joins a channel or before an audience switches to a host, call this method to check the uplink network quality.

   This method consumes additional network traffic, and hence may affect communication quality.

   Call the \ref IRtcEngine::disableLastmileTest "disableLastmileTest" method to disable this test after receiving the \ref IRtcEngineEventHandler::onLastmileQuality "onLastmileQuality" callback, and before joining a channel.

   @note
   - Do not call any other methods before receiving the \ref IRtcEngineEventHandler::onLastmileQuality "onLastmileQuality" callback. Otherwise, the callback may be interrupted by other methods, and hence may not be triggered.
   - A host should not call this method after joining a channel (when in a call).
   - If you call this method to test the last mile network quality, the SDK consumes the bandwidth of a video stream, whose bitrate corresponds to the bitrate you set in the \ref agora::rtc::IRtcEngine::setVideoEncoderConfiguration "setVideoEncoderConfiguration" method. After you join the channel, whether you have called the `disableLastmileTest` method or not, the SDK automatically stops consuming the bandwidth.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int enableLastmileTest() = 0;

  /** Disables the network connection quality test.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int disableLastmileTest() = 0;

  /** Starts the last-mile network probe test.

  This method starts the last-mile network probe test before joining a channel to get the uplink and downlink last mile network statistics, including the bandwidth, packet loss, jitter, and round-trip time (RTT).

  Call this method to check the uplink network quality before users join a channel or before an audience switches to a host.
  Once this method is enabled, the SDK returns the following callbacks:
  - \ref IRtcEngineEventHandler::onLastmileQuality "onLastmileQuality": the SDK triggers this callback within two seconds depending on the network conditions. This callback rates the network conditions and is more closely linked to the user experience.
  - \ref IRtcEngineEventHandler::onLastmileProbeResult "onLastmileProbeResult": the SDK triggers this callback within 30 seconds depending on the network conditions. This callback returns the real-time statistics of the network conditions and is more objective.

  @note
  - This method consumes extra network traffic and may affect communication quality. We do not recommend calling this method together with enableLastmileTest.
  - Do not call other methods before receiving the \ref IRtcEngineEventHandler::onLastmileQuality "onLastmileQuality" and \ref IRtcEngineEventHandler::onLastmileProbeResult "onLastmileProbeResult" callbacks. Otherwise, the callbacks may be interrupted.
  - In the `LIVE_BROADCASTING` profile, a host should not call this method after joining a channel.

  @param config Sets the configurations of the last-mile network probe test. See LastmileProbeConfig.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int startLastmileProbeTest(const LastmileProbeConfig& config) = 0;

  /** Stops the last-mile network probe test. */
  virtual int stopLastmileProbeTest() = 0;

  /** Gets the warning or error description.

   @param code Warning code or error code returned in the \ref agora::rtc::IRtcEngineEventHandler::onWarning "onWarning" or \ref agora::rtc::IRtcEngineEventHandler::onError "onError" callback.

   @return #WARN_CODE_TYPE or #ERROR_CODE_TYPE.
   */
  virtual const char* getErrorDescription(int code) = 0;

  /** Enables built-in encryption with an encryption password before users join a channel.

   @deprecated Deprecated as of v3.1.0. Use the \ref agora::rtc::IRtcEngine::enableEncryption "enableEncryption" instead.

   All users in a channel must use the same encryption password. The encryption password is automatically cleared once a user leaves the channel.

   If an encryption password is not specified, the encryption functionality will be disabled.

   @note
   - Do not use this method for CDN live streaming.
   - For optimal transmission, ensure that the encrypted data size does not exceed the original data size + 16 bytes. 16 bytes is the maximum padding size for AES encryption.

   @param secret Pointer to the encryption password.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setEncryptionSecret(const char* secret) AGORA_DEPRECATED_ATTRIBUTE = 0;

  /** Sets the built-in encryption mode.

   @deprecated Deprecated as of v3.1.0. Use the \ref agora::rtc::IRtcEngine::enableEncryption "enableEncryption" instead.

   The Agora SDK supports built-in encryption, which is set to the @p aes-128-xts mode by default. Call this method to use other encryption modes.

   All users in the same channel must use the same encryption mode and password.

   Refer to the information related to the AES encryption algorithm on the differences between the encryption modes.

   @note Call the \ref IRtcEngine::setEncryptionSecret "setEncryptionSecret" method to enable the built-in encryption function before calling this method.

   @param encryptionMode Pointer to the set encryption mode:
   - "aes-128-xts": (Default) 128-bit AES encryption, XTS mode.
   - "aes-128-ecb": 128-bit AES encryption, ECB mode.
   - "aes-256-xts": 256-bit AES encryption, XTS mode.
   - "": When encryptionMode is set as NULL, the encryption mode is set as "aes-128-xts" by default.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setEncryptionMode(const char* encryptionMode) AGORA_DEPRECATED_ATTRIBUTE = 0;

  /** Enables/Disables the built-in encryption.
   *
   * @since v3.1.0
   *
   * In scenarios requiring high security, Agora recommends calling this method to enable the built-in encryption before joining a channel.
   *
   * After a user leaves the channel, the SDK automatically disables the built-in encryption.
   * To re-enable the built-in encryption, call this method before the user joins the channel again.
   *
   * As of v3.4.5, Agora recommends using either the `AES_128_GCM2` or `AES_256_GCM2` encryption mode,
   * both of which support adding a salt and are more secure. For details, see *Media Stream Encryption*.
   *
   * @warning All users in the same channel must use the same encryption mode, encryption key, and salt; otherwise,
   * users cannot communicate with each other.
   *
   * @note
   * - If you enable the built-in encryption, you cannot use the RTMP or RTMPS streaming function.
   * - To enhance security, Agora recommends using a new key and salt every time you enable the media stream encryption.
   *
   * @param enabled Whether to enable the built-in encryption:
   * - true: Enable the built-in encryption.
   * - false: Disable the built-in encryption.
   * @param config Configurations of built-in encryption schemas. See EncryptionConfig.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *  - -2(ERR_INVALID_ARGUMENT): An invalid parameter is used. Set the parameter with a valid value.
   *  - -4(ERR_NOT_SUPPORTED): The encryption mode is incorrect or the SDK fails to load the external encryption library. Check the enumeration or reload the external encryption library.
   *  - -7(ERR_NOT_INITIALIZED): The SDK is not initialized. Initialize the `IRtcEngine` instance before calling this method.
   */
  virtual int enableEncryption(bool enabled, const EncryptionConfig& config) = 0;

  /** Registers a packet observer.

   The Agora SDK allows your application to register a packet observer to receive callbacks for voice or video packet transmission.

   @note
   - The size of the packet sent to the network after processing should not exceed 1200 bytes, otherwise, the packet may fail to be sent.
   - Ensure that both receivers and senders call this method, otherwise, you may meet undefined behaviors such as no voice and black screen.
   - When you use CDN live streaming and recording functions, Agora doesn't recommend calling this method.
   - Call this method before joining a channel.

   @param observer Pointer to the registered packet observer. See IPacketObserver.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int registerPacketObserver(IPacketObserver* observer) = 0;

  /** Creates a data stream.

   @deprecated This method is deprecated from v3.3.0. Use the \ref IRtcEngine::createDataStream(int* streamId, DataStreamConfig& config) "createDataStream" [2/2] method instead.

   Each user can create up to five data streams during the lifecycle of the IRtcEngine.

   @note
   - Do not set `reliable` as `true` while setting `ordered` as `false`.
   - Ensure that you call this method after joining a channel.

   @param[out] streamId Pointer to the ID of the created data stream.
   @param reliable Sets whether or not the recipients are guaranteed to receive the data stream from the sender within five seconds:
   - true: The recipients receive the data stream from the sender within five seconds. If the recipient does not receive the data stream within five seconds, an error is reported to the application.
   - false: There is no guarantee that the recipients receive the data stream within five seconds and no error message is reported for any delay or missing data stream.
   @param ordered Sets whether or not the recipients receive the data stream in the sent order:
   - true: The recipients receive the data stream in the sent order.
   - false: The recipients do not receive the data stream in the sent order.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int createDataStream(int* streamId, bool reliable, bool ordered) AGORA_DEPRECATED_ATTRIBUTE = 0;
  /** Creates a data stream.
   *
   * @since v3.3.0
   *
   * Each user can create up to five data streams in a single channel.
   *
   * This method does not support data reliability. If the receiver receives a data packet five
   * seconds or more after it was sent, the SDK directly discards the data.
   *
   * @param[out] streamId The ID of the created data stream.
   * @param config The configurations for the data stream: DataStreamConfig.
   *
   * @return
   * - 0: Creates the data stream successfully.
   * - < 0: Fails to create the data stream.
   */
  virtual int createDataStream(int* streamId, DataStreamConfig& config) = 0;

  /** Sends data stream messages to all users in a channel.

   The SDK has the following restrictions on this method:
   - Up to 30 packets can be sent per second in a channel with each packet having a maximum size of 1 kB.
   - Each client can send up to 6 kB of data per second.
   - Each user can have up to five data streams simultaneously.

   A successful \ref agora::rtc::IRtcEngine::sendStreamMessage "sendStreamMessage" method call triggers the
   \ref agora::rtc::IRtcEngineEventHandler::onStreamMessage "onStreamMessage" callback on the remote client, from which the remote user gets the stream message.

   A failed \ref agora::rtc::IRtcEngine::sendStreamMessage "sendStreamMessage" method call triggers the
    \ref agora::rtc::IRtcEngineEventHandler::onStreamMessage "onStreamMessage" callback on the remote client.
   @note This method applies only to the `COMMUNICATION` profile or to the hosts in the `LIVE_BROADCASTING` profile. If an audience in the `LIVE_BROADCASTING` profile calls this method, the audience may be switched to a host.
   @param  streamId  ID of the sent data stream, returned in the \ref IRtcEngine::createDataStream "createDataStream" method.
   @param data Pointer to the sent data.
   @param length Length of the sent data.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int sendStreamMessage(int streamId, const char* data, size_t length) = 0;

  /** Publishes the local stream to a specified CDN live address.  (CDN live only.)

   @deprecated This method is deprecated as of v3.6.0. See [Release Notes](https://docs.agora.io/en/Interactive%20Broadcast/release_windows_video?platform=Windows) for an alternative solution.

   The SDK returns the result of this method call in the \ref IRtcEngineEventHandler::onStreamPublished "onStreamPublished" callback.

   The \ref agora::rtc::IRtcEngine::addPublishStreamUrl "addPublishStreamUrl" method call triggers the \ref agora::rtc::IRtcEngineEventHandler::onRtmpStreamingStateChanged "onRtmpStreamingStateChanged" callback on the local client to report the state of adding a local stream to the CDN.
   @note
   - Ensure that the user joins the channel before calling this method.
   - Ensure that you enable the Media Push service before using this function. See  *Prerequisites* in the advanced guide *Media Push*.
   - This method adds only one stream CDN streaming URL each time it is called.
   - This method applies to `LIVE_BROADCASTING` only.

   @param url The CDN streaming URL in the RTMP or RTMPS format. The maximum length of this parameter is 1024 bytes. The CDN streaming URL must not contain special characters, such as Chinese language characters.
   @param  transcodingEnabled Sets whether transcoding is enabled/disabled:
   - true: Enable transcoding. To [transcode](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#transcoding) the audio or video streams when publishing them to CDN live, often used for combining the audio and video streams of multiple hosts in CDN live. If you set this parameter as `true`, ensure that you call the \ref IRtcEngine::setLiveTranscoding "setLiveTranscoding" method before this method.
   - false: Disable transcoding.

   @return
   - 0: Success.
   - < 0: Failure.
        - #ERR_INVALID_ARGUMENT (-2): The CDN streaming URL is NULL or has a string length of 0.
        - #ERR_NOT_INITIALIZED (-7): You have not initialized the RTC engine when publishing the stream.
   */
  virtual int addPublishStreamUrl(const char* url, bool transcodingEnabled) AGORA_DEPRECATED_ATTRIBUTE = 0;

  /** Removes an RTMP or RTMPS stream from the CDN. (CDN live only.)

   @deprecated This method is deprecated as of v3.6.0. See [Release Notes](https://docs.agora.io/en/Interactive%20Broadcast/release_windows_video?platform=Windows) for an alternative solution.

   This method removes the CDN streaming URL (added by the \ref IRtcEngine::addPublishStreamUrl "addPublishStreamUrl" method) from a CDN live stream. The SDK returns the result of this method call in the \ref IRtcEngineEventHandler::onStreamUnpublished "onStreamUnpublished" callback.

   The \ref agora::rtc::IRtcEngine::removePublishStreamUrl "removePublishStreamUrl" method call triggers the \ref agora::rtc::IRtcEngineEventHandler::onRtmpStreamingStateChanged "onRtmpStreamingStateChanged" callback on the local client to report the state of removing an RTMP or RTMPS stream from the CDN.

   @note
   - This method removes only one CDN streaming URL each time it is called.
   - The CDN streaming URL must not contain special characters, such as Chinese language characters.
   - This method applies to `LIVE_BROADCASTING` only.

   @param url The CDN streaming URL to be removed. The maximum length of this parameter is 1024 bytes.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int removePublishStreamUrl(const char* url) AGORA_DEPRECATED_ATTRIBUTE = 0;

  /** Sets the video layout and audio settings for CDN live. (CDN live only.)

   @deprecated This method is deprecated as of v3.6.0. See [Release Notes](https://docs.agora.io/en/Interactive%20Broadcast/release_windows_video?platform=Windows) for an alternative solution.

   The SDK triggers the \ref agora::rtc::IRtcEngineEventHandler::onTranscodingUpdated "onTranscodingUpdated" callback when you call the `setLiveTranscoding` method to update the transcoding setting.

   @note
   - This method applies to `LIVE_BROADCASTING` only.
   - Ensure that you enable the Media Push service before using this function. See *Prerequisites* in the advanced guide *Media Push*.
   - If you call the `setLiveTranscoding` method to update the transcoding setting for the first time, the SDK does not trigger the `onTranscodingUpdated` callback.
   - Ensure that you call this method after joining a channel.
   - Agora supports pushing media streams in RTMPS protocol to the CDN only when you enable transcoding.

   @param transcoding Sets the CDN live audio/video transcoding settings. See LiveTranscoding.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setLiveTranscoding(const LiveTranscoding& transcoding) AGORA_DEPRECATED_ATTRIBUTE = 0;
  /**
   * Starts pushing media streams to a CDN without transcoding.
   *
   * @since v3.6.0
   *
   * You can call this method to push a live audio-and-video stream to the specified CDN address. This method can push
   * media streams to only one CDN address at a time, so if you need to push streams to multiple addresses, call this
   * method multiple times.
   *
   * After you call this method, the SDK triggers the \ref IRtcEngineEventHandler::onRtmpStreamingStateChanged "onRtmpStreamingStateChanged"
   * callback on the local client to report the state of the streaming.
   *
   * @note
   * - Ensure that you enable the Media Push service before using this function. See Prerequisites in *Media Push*.
   * - Call this method after joining a channel.
   * - Only hosts in the `LIVE_BROADCASTING` profile can call this method.
   * - If you want to retry pushing streams after a failed push, make sure to call \ref IRtcEngine::stopRtmpStream "stopRtmpStream" first,
   * then call this method to retry pushing streams; otherwise, the SDK returns the same error code as the last failed push.
   *
   *
   * @param url The address of the CDN live streaming. The format is RTMP or RTMPS. The character length cannot exceed 1024 bytes.
   * Special characters such as Chinese characters are not supported.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *  - `ERR_INVALID_ARGUMENT(-2)`: url is null or the string length is 0.
   *  - `ERR_NOT_INITIALIZED(-7)`: The SDK is not initialized before calling this method.
   */
  virtual int startRtmpStreamWithoutTranscoding(const char* url) = 0;
  /**
   * Starts pushing media streams to a CDN and sets the transcoding configuration.
   *
   * @since v3.6.0
   *
   * You can call this method to push a live audio-and-video stream to the specified CDN address and set the transcoding
   * configuration. This method can push media streams to only one CDN address at a time, so if you need to push streams to
   * multiple addresses, call this method multiple times.
   *
   * After you call this method, the SDK triggers the \ref IRtcEngineEventHandler::onRtmpStreamingStateChanged "onRtmpStreamingStateChanged"
   * callback on the local client to report the state of the streaming.
   *
   * @note
   * - Ensure that you enable the Media Push service before using this function. See Prerequisites in *Media Push*.
   * - Call this method after joining a channel.
   * - Only hosts in the `LIVE_BROADCASTING` profile can call this method.
   * - If you want to retry pushing streams after a failed push, make sure to call \ref IRtcEngine::stopRtmpStream "stopRtmpStream" first,
   * then call this method to retry pushing streams; otherwise, the SDK returns the same error code as the last failed push.
   *
   *
   * @param url The address of the CDN live streaming. The format is RTMP or RTMPS. The character length cannot exceed 1024 bytes.
   * Special characters such as Chinese characters are not supported.
   * @param transcoding The transcoding configuration for CDN live streaming. See LiveTranscoding.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *  - `ERR_INVALID_ARGUMENT(-2)`: url is null or the string length is 0.
   *  - `ERR_NOT_INITIALIZED(-7)`: The SDK is not initialized before calling this method.
   */
  virtual int startRtmpStreamWithTranscoding(const char* url, const LiveTranscoding& transcoding) = 0;
  /**
   * Updates the transcoding configuration.
   *
   * @since v3.6.0
   *
   * After you start pushing media streams to CDN with transcoding, you can dynamically update the transcoding configuration according to the scenario.
   * The SDK triggers the \ref IRtcEngineEventHandler::onTranscodingUpdated "onTranscodingUpdated" callback after the
   * transcoding configuration is updated.
   *
   * @param transcoding The transcoding configuration for CDN live streaming. See LiveTranscoding.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int updateRtmpTranscoding(const LiveTranscoding& transcoding) = 0;
  /**
   * Stops pushing media streams to a CDN.
   *
   * @since v3.6.0
   *
   * You can call this method to stop the live stream on the specified CDN address.
   * This method can stop pushing media streams to only one CDN address at a time, so if you need to stop pushing streams to multiple addresses, call this method multiple times.
   *
   * After you call this method, the SDK triggers the \ref IRtcEngineEventHandler::onRtmpStreamingStateChanged "onRtmpStreamingStateChanged" callback on the local client to report the state of the streaming.
   *
   * @param url The address of the CDN live streaming. The format is RTMP or RTMPS.
   * The character length cannot exceed 1024 bytes. Special characters such as Chinese characters are not supported.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int stopRtmpStream(const char* url) = 0;

  /** **DEPRECATED** Adds a watermark image to the local video or CDN live stream.

   This method is deprecated from v2.9.1. Use \ref agora::rtc::IRtcEngine::addVideoWatermark(const char* watermarkUrl, const WatermarkOptions& options) "addVideoWatermark" [2/2] instead.

   This method adds a PNG watermark image to the local video stream for the capturing device, channel audience, and CDN live audience to view and capture.

   To add the PNG file to the CDN live publishing stream, see the \ref IRtcEngine::setLiveTranscoding "setLiveTranscoding" method.

   @param watermark Pointer to the watermark image to be added to the local video stream. See RtcImage.

   @note
   - The URL descriptions are different for the local video and CDN live streams:
      - In a local video stream, `url` in RtcImage refers to the absolute path of the added watermark image file in the local video stream.
      - In a CDN live stream, `url` in RtcImage refers to the URL address of the added watermark image in the CDN live streaming.
   - The source file of the watermark image must be in the PNG file format. If the width and height of the PNG file differ from your settings in this method, the PNG file will be cropped to conform to your settings.
   - The Agora SDK supports adding only one watermark image onto a local video or CDN live stream. The newly added watermark image replaces the previous one.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int addVideoWatermark(const RtcImage& watermark) = 0;

  /** Adds a watermark image to the local video.
   *
   * This method adds a PNG watermark image to the local video in the live streaming. Once the watermark image is added, all the audience in the channel (CDN audience included),
   * and the capturing device can see and capture it. Agora supports adding only one watermark image onto the local video, and the newly watermark image replaces the previous one.
   *
   * The watermark position depends on the settings in the \ref IRtcEngine::setVideoEncoderConfiguration "setVideoEncoderConfiguration" method:
   * - If the orientation mode of the encoding video is #ORIENTATION_MODE_FIXED_LANDSCAPE, or the landscape mode in #ORIENTATION_MODE_ADAPTIVE, the watermark uses the landscape orientation.
   * - If the orientation mode of the encoding video is #ORIENTATION_MODE_FIXED_PORTRAIT, or the portrait mode in #ORIENTATION_MODE_ADAPTIVE, the watermark uses the portrait orientation.
   * - When setting the watermark position, the region must be less than the dimensions set in the `setVideoEncoderConfiguration` method. Otherwise, the watermark image will be cropped.
   *
   * @note
   * - Ensure that you have called the \ref agora::rtc::IRtcEngine::enableVideo "enableVideo" method to enable the video module before calling this method.
   * - If you only want to add a watermark image to the local video for the audience in the CDN live streaming channel to see and capture, you can call this method or the \ref agora::rtc::IRtcEngine::setLiveTranscoding "setLiveTranscoding" method.
   * - This method supports adding a watermark image in the PNG file format only. Supported pixel formats of the PNG image are RGBA, RGB, Palette, Gray, and Alpha_gray.
   * - If the dimensions of the PNG image differ from your settings in this method, the image will be cropped or zoomed to conform to your settings.
   * - If you have enabled the local video preview by calling the \ref agora::rtc::IRtcEngine::startPreview "startPreview" method, you can use the `visibleInPreview` member in the WatermarkOptions class to set whether or not the watermark is visible in preview.
   * - If you have enabled the mirror mode for the local video, the watermark on the local video is also mirrored. To avoid mirroring the watermark, Agora recommends that you do not use the mirror and watermark functions for the local video at the same time. You can implement the watermark function in your application layer.
   *
   * @param watermarkUrl The local file path of the watermark image to be added.
   * This method supports adding a watermark image from the local absolute or relative file path.
   * On Android, Agora recommends passing a URI address or the path starts with `/assets/` in this parameter
   * @param options Pointer to the watermark's options to be added. See WatermarkOptions for more infomation.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int addVideoWatermark(const char* watermarkUrl, const WatermarkOptions& options) = 0;

  /** Removes the watermark image from the video stream added by the \ref agora::rtc::IRtcEngine::addVideoWatermark(const char* watermarkUrl, const WatermarkOptions& options) "addVideoWatermark" method.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int clearVideoWatermarks() = 0;

  /** Enables/Disables image enhancement and sets the options.
   *
   * @note
   * - Call this method after calling the \ref IRtcEngine::enableVideo "enableVideo" method.
   * - On Android, this method applies to Android 5.0 or later.
   * - Agora has updated the Agora image enhancement algorithm from v3.6.0 to enhance image enhancement effects and support sharpness adjustment.
   * If you want to experience optimized image enhancement effects or set the sharpness, integrate the following dynamic library into the project before calling this method:
   *  - Android: `libagora_video_process_extension.so`
   *  - iOS/macOS: `AgoraVideoProcessExtension.xcframework`
   *  - Windows: `libagora_video_process_extension.dll`
   *
   * @param enabled Determines whether to enable image enhancement:
   * - true: Enable image enhancement.
   * - false: (Default) Disables image enhancement.
   * @param options The image enhancement option. See BeautyOptions.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *  - `-4(ERR_NOT_SUPPORTED)`: The system version is earlier than Android 5.0, which does not support this function.
   */
  virtual int setBeautyEffectOptions(bool enabled, BeautyOptions options) = 0;
  /**
   * Sets low-light enhancement.
   *
   * @since v3.6.2
   *
   * The low-light enhancement feature can adaptively adjust the brightness value of the video captured in situations with low or uneven lighting, such as backlit, cloudy, or dark scenes. It restores or highlights the image details and improves the overall visual effect of the video.
   *
   * You can call this method to enable the low-light enhancement feature and set the options of the low-light enhancement effect.
   *
   * @note
   * - Before calling this method, ensure that you have integrated the following dynamic library into your project:
   *  - Android: `libagora_segmentation_extension.so`
   *  - iOS/macOS: `AgoraVideoSegmentationExtension.xcframework`
   *  - Windows: `libagora_segmentation_extension.dll`
   * - Call this method after \ref IRtcEngine::enableVideo "enableVideo".
   * - The low-light enhancement feature has certain performance requirements on devices. If your device overheats after you enable low-light enhancement, Agora recommends modifying the low-light enhancement options to a less performance-consuming level or disabling low-light enhancement entirely.
   *
   * @param enabled Sets whether to enable low-light enhancement:
   * - `true`: Enable.
   * - `false`: (Default) Disable.
   * @param options The low-light enhancement options. See LowLightEnhanceOptions.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setLowlightEnhanceOptions(bool enabled, LowLightEnhanceOptions options) = 0;
  /**
   * Sets video noise reduction.
   *
   * @since v3.6.2
   *
   * Underlit environments and low-end video capture devices can cause video images to contain significant noise, which affects video quality. In real-time interactive scenarios, video noise also consumes bitstream resources and reduces encoding efficiency during encoding.
   *
   * You can call this method to enable the video noise reduction feature and set the options of the video noise reduction effect.
   *
   * @note
   * - Before calling this method, ensure that you have integrated the following dynamic library into your project:
   *  - Android: `libagora_segmentation_extension.so`
   *  - iOS/macOS: `AgoraVideoSegmentationExtension.xcframework`
   *  - Windows: `libagora_segmentation_extension.dll`
   * - Call this method after \ref IRtcEngine::enableVideo "enableVideo".
   * - The video noise reduction feature has certain performance requirements on devices. If your device overheats after you enable video noise reduction, Agora recommends modifying the video noise reduction options to a less performance-consuming level or disabling video noise reduction entirely.
   *
   * @param enabled Sets whether to enable video noise reduction:
   * - `true`: Enable.
   * - `false`: (Default) Disable.
   * @param options The video noise reduction options. See VideoDenoiserOptions.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setVideoDenoiserOptions(bool enabled, VideoDenoiserOptions options) = 0;
  /**
   * Sets color enhancement.
   *
   * @since v3.6.2
   *
   * The video images captured by the camera can have color distortion. The color enhancement feature intelligently adjusts video characteristics such as saturation and contrast to enhance the video color richness and color reproduction, making the video more vivid.
   *
   * You can call this method to enable the color enhancement feature and set the options of the color enhancement effect.
   *
   * @note
   * - Before calling this method, ensure that you have integrated the following dynamic library into your project:
   *  - Android: `libagora_segmentation_extension.so`
   *  - iOS/macOS: `AgoraVideoSegmentationExtension.xcframework`
   *  - Windows: `libagora_segmentation_extension.dll`
   * - Call this method after \ref IRtcEngine::enableVideo "enableVideo".
   * - The color enhancement feature has certain performance requirements on devices. If your device overheats after you enable color enhancement, Agora recommends modifying the color enhancement options to a less performance-consuming level or disabling color enhancement entirely.
   *
   * @param enabled Sets whether to enable color enhancement:
   * - `true`: Enable.
   * - `false`: (Default) Disable.
   * @param options The color enhancement options. See ColorEnhanceOptions.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setColorEnhanceOptions(bool enabled, ColorEnhanceOptions options) = 0;
  /**
   * Enables/Disables the virtual background.
   *
   * Support for macOS and Windows as of v3.4.5 and Android and iOS as of v3.5.0.
   *
   * After enabling the virtual background feature, you can replace the original background image of the local user
   * with a custom background image. After the replacement, all users in the channel can see the custom background
   * image. You can find out from the
   * \ref IRtcEngineEventHandler::onVirtualBackgroundSourceEnabled "onVirtualBackgroundSourceEnabled" callback
   * whether the virtual background is successfully enabled or the cause of any errors.
   *
   * @note
   * - Before calling this method, ensure that you have integrated the following dynamic library into your project:
   *  - Android: `libagora_segmentation_extension.so`
   *  - iOS/macOS: `AgoraVideoSegmentationExtension.xcframework`
   *  - Windows: `libagora_segmentation_extension.dll`
   * - Call this method after \ref IRtcEngine::enableVideo "enableVideo".
   * - This functions requires a high-performance device. Agora recommends that you use this function on the
   * following devices:
   *  - Android: Devices with the following chips:
   *    - Snapdragon 700 series 750G and later
   *    - Snapdragon 800 series 835 and later
   *    - Dimensity 700 series 720 and later
   *    - Kirin 800 series 810 and later
   *    - Kirin 900 series 980 and later
   *  - iOS: Devices with an A9 chip and better, as follows:
   *    - iPhone 6S and later
   *    - iPad Air (3rd generation) and later
   *    - iPad (5th generation) and later
   *    - iPad Pro (1st generation) and later
   *    - iPad mini (5th generation) and later
   *  - macOS and Windows: Devices with an i5 CPU and better
   * - Agora recommends that you use this function in scenarios that meet the following conditions:
   *  - A high-definition camera device is used, and the environment is uniformly lit.
   *  - The captured video image is uncluttered, the user's portrait is half-length and largely unobstructed, and the
   * background is a single color that differs from the color of the user's clothing.
   * - The virtual background feature does not support video in the Texture format or video obtained from custom video capture by the Push method.
   *
   * @param enabled Sets whether to enable the virtual background:
   * - true: Enable.
   * - false: Disable.
   * @param backgroundSource The custom background image. See VirtualBackgroundSource.
   * Note: To adapt the resolution of the custom background image to the resolution of the SDK capturing video,
   * the SDK scales and crops
   * the custom background image while ensuring that the content of the custom background image is not distorted.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int enableVirtualBackground(bool enabled, VirtualBackgroundSource backgroundSource) = 0;

  /** Adds a voice or video stream URL address to the live streaming.

   The \ref IRtcEngineEventHandler::onStreamPublished "onStreamPublished" callback returns the inject status. If this method call is successful, the server pulls the voice or video stream and injects it into a live channel. This is applicable to scenarios where all audience members in the channel can watch a live show and interact with each other.

   The \ref agora::rtc::IRtcEngine::addInjectStreamUrl "addInjectStreamUrl" method call triggers the following callbacks:
   - The local client:
     - \ref agora::rtc::IRtcEngineEventHandler::onStreamInjectedStatus "onStreamInjectedStatus" , with the state of the injecting the online stream.
     - \ref agora::rtc::IRtcEngineEventHandler::onUserJoined "onUserJoined" (uid: 666), if the method call is successful and the online media stream is injected into the channel.
   - The remote client:
     - \ref agora::rtc::IRtcEngineEventHandler::onUserJoined "onUserJoined" (uid: 666), if the method call is successful and the online media stream is injected into the channel.

   @warning Agora will soon stop the service for injecting online media streams on the client. If you have not implemented this service, Agora recommends that you do not use it.

   @note
   - Ensure that you enable the RTMP Converter service before using this function. See *Prerequisites* in the advanced guide *Media Push*.
   - This method applies to the Native SDK v2.4.1 and later.
   - This method applies to the `LIVE_BROADCASTING` profile only.
   - You can inject only one media stream into the channel at the same time.
   - Ensure that you call this method after joining a channel.

   @param url Pointer to the URL address to be added to the ongoing streaming. Valid protocols are RTMP, HLS, and HTTP-FLV.
   - Supported audio codec type: AAC.
   - Supported video codec type: H264 (AVC).
   @param config Pointer to the InjectStreamConfig object that contains the configuration of the added voice or video stream.

   @return
   - 0: Success.
   - < 0: Failure.
      - #ERR_INVALID_ARGUMENT (-2): The injected URL does not exist. Call this method again to inject the stream and ensure that the URL is valid.
      - #ERR_NOT_READY (-3): The user is not in the channel.
      - #ERR_NOT_SUPPORTED (-4): The channel profile is not `LIVE_BROADCASTING`. Call the \ref agora::rtc::IRtcEngine::setChannelProfile "setChannelProfile" method and set the channel profile to `LIVE_BROADCASTING` before calling this method.
      - #ERR_NOT_INITIALIZED (-7): The SDK is not initialized. Ensure that the IRtcEngine object is initialized before calling this method.
   */
  virtual int addInjectStreamUrl(const char* url, const InjectStreamConfig& config) = 0;
  /** Starts to relay media streams across channels.
   *
   * After a successful method call, the SDK triggers the
   * \ref agora::rtc::IRtcEngineEventHandler::onChannelMediaRelayStateChanged
   *  "onChannelMediaRelayStateChanged" and
   * \ref agora::rtc::IRtcEngineEventHandler::onChannelMediaRelayEvent
   * "onChannelMediaRelayEvent" callbacks, and these callbacks return the
   * state and events of the media stream relay.
   * - If the
   * \ref agora::rtc::IRtcEngineEventHandler::onChannelMediaRelayStateChanged
   *  "onChannelMediaRelayStateChanged" callback returns
   * #RELAY_STATE_RUNNING (2) and #RELAY_OK (0), and the
   * \ref agora::rtc::IRtcEngineEventHandler::onChannelMediaRelayEvent
   * "onChannelMediaRelayEvent" callback returns
   * #RELAY_EVENT_PACKET_SENT_TO_DEST_CHANNEL (4), the host starts
   * sending data to the destination channel.
   * - If the
   * \ref agora::rtc::IRtcEngineEventHandler::onChannelMediaRelayStateChanged
   *  "onChannelMediaRelayStateChanged" callback returns
   * #RELAY_STATE_FAILURE (3), an exception occurs during the media stream
   * relay.
   *
   * @note
   * - Call this method after the \ref joinChannel() "joinChannel" method.
   * - This method takes effect only when you are a host in a
   * `LIVE_BROADCASTING` channel.
   * - After a successful method call, if you want to call this method
   * again, ensure that you call the
   * \ref stopChannelMediaRelay() "stopChannelMediaRelay" method to quit the
   * current relay.
   * - Contact sales-us@agora.io before implementing this function.
   * - We do not support string user accounts in this API.
   *
   * @param configuration The configuration of the media stream relay:
   * ChannelMediaRelayConfiguration.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int startChannelMediaRelay(const ChannelMediaRelayConfiguration& configuration) = 0;
  /** Updates the channels for media stream relay. After a successful
   * \ref startChannelMediaRelay() "startChannelMediaRelay" method call, if
   * you want to relay the media stream to more channels, or leave the
   * current relay channel, you can call the
   * \ref updateChannelMediaRelay() "updateChannelMediaRelay" method.
   *
   * After a successful method call, the SDK triggers the
   * \ref agora::rtc::IRtcEngineEventHandler::onChannelMediaRelayEvent
   *  "onChannelMediaRelayEvent" callback with the
   * #RELAY_EVENT_PACKET_UPDATE_DEST_CHANNEL (7) state code.
   *
   * @note Call this method after successfully calling the \ref startChannelMediaRelay() "startChannelMediaRelay" method
   * and receiving the \ref IRtcEngineEventHandler::onChannelMediaRelayStateChanged "onChannelMediaRelayStateChanged" (RELAY_STATE_RUNNING, RELAY_OK) callback;
   * otherwise, this method call fails.
   *
   * @param configuration The media stream relay configuration:
   * ChannelMediaRelayConfiguration.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int updateChannelMediaRelay(const ChannelMediaRelayConfiguration& configuration) = 0;

  /**
   * Pauses the media stream relay to all destination channels.
   *
   * @since v3.5.1
   *
   * After the cross-channel media stream relay starts, you can call this method
   * to pause relaying media streams to all destination channels; after the pause,
   * if you want to resume the relay, call \ref IRtcEngine::resumeAllChannelMediaRelay "resumeAllChannelMediaRelay".
   *
   * After a successful method call, the SDK triggers the
   * \ref IRtcEngineEventHandler::onChannelMediaRelayEvent "onChannelMediaRelayEvent"
   * callback to report whether the media stream relay is successfully paused.
   *
   * @note Call this method after the \ref IRtcEngine::startChannelMediaRelay "startChannelMediaRelay" method.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int pauseAllChannelMediaRelay() = 0;

  /** Resumes the media stream relay to all destination channels.
   *
   * @since v3.5.1
   *
   * After calling the \ref IRtcEngine::pauseAllChannelMediaRelay "pauseAllChannelMediaRelay" method,
   * you can call this method to resume relaying media streams to all destination channels.
   *
   * After a successful method call, the SDK triggers the
   * \ref IRtcEngineEventHandler::onChannelMediaRelayEvent "onChannelMediaRelayEvent"
   * callback to report whether the media stream relay is successfully resumed.
   *
   * @note Call this method after the \ref IRtcEngine::pauseAllChannelMediaRelay "pauseAllChannelMediaRelay" method.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int resumeAllChannelMediaRelay() = 0;

  /** Stops the media stream relay.
   *
   * Once the relay stops, the host quits all the destination
   * channels.
   *
   * After a successful method call, the SDK triggers the
   * \ref agora::rtc::IRtcEngineEventHandler::onChannelMediaRelayStateChanged
   *  "onChannelMediaRelayStateChanged" callback. If the callback returns
   * #RELAY_STATE_IDLE (0) and #RELAY_OK (0), the host successfully
   * stops the relay.
   *
   * @note
   * If the method call fails, the SDK triggers the
   * \ref agora::rtc::IRtcEngineEventHandler::onChannelMediaRelayStateChanged
   *  "onChannelMediaRelayStateChanged" callback with the
   * #RELAY_ERROR_SERVER_NO_RESPONSE (2) or
   * #RELAY_ERROR_SERVER_CONNECTION_LOST (8) error code. You can leave the
   * channel by calling the \ref leaveChannel() "leaveChannel" method, and
   * the media stream relay automatically stops.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int stopChannelMediaRelay() = 0;

  /** Removes the voice or video stream URL address from the live streaming.

   This method removes the URL address (added by the \ref IRtcEngine::addInjectStreamUrl "addInjectStreamUrl" method) from the live streaming.

   @warning Agora will soon stop the service for injecting online media streams on the client. If you have not implemented this service, Agora recommends that you do not use it.

   @note If this method is called successfully, the SDK triggers the \ref IRtcEngineEventHandler::onUserOffline "onUserOffline" callback and returns a stream uid of 666.

   @param url Pointer to the URL address of the injected stream to be removed.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int removeInjectStreamUrl(const char* url) = 0;
  virtual bool registerEventHandler(IRtcEngineEventHandler* eventHandler) = 0;
  virtual bool unregisterEventHandler(IRtcEngineEventHandler* eventHandler) = 0;
  /** Agora supports reporting and analyzing customized messages.
   *
   * @since v3.1.0
   *
   * This function is in the beta stage with a free trial. The ability provided in its beta test version is reporting a maximum of 10 message pieces within 6 seconds, with each message piece not exceeding 256 bytes and each string not exceeding 100 bytes.
   * To try out this function, contact [support@agora.io](mailto:support@agora.io) and discuss the format of customized messages with us.
   */
  virtual int sendCustomReportMessage(const char* id, const char* category, const char* event, const char* label, int value) = 0;
  /** Gets the current connection state of the SDK.

   @note You can call this method either before or after joining a channel.

   @return #CONNECTION_STATE_TYPE.
   */
  virtual CONNECTION_STATE_TYPE getConnectionState() = 0;

  /** Enables/Disables the super resolution feature for a remote user's video. (beta feature)
   *
   * @since v3.5.1
   *
   * This feature effectively boosts the resolution of a remote user's video seen by the local
   * user. If the original resolution of a remote user's video is a × b, the local user's device
   * can render the remote video at a resolution of 2a × 2b after you enable this feature.
   *
   * After calling this method, the SDK triggers the
   * \ref IRtcEngineEventHandler::onUserSuperResolutionEnabled "onUserSuperResolutionEnabled"
   * callback to report whether you have successfully enabled super resolution.
   *
   * @warning The super resolution feature requires extra system resources. To balance the visual experience and system consumption, the SDK poses the following restrictions:
   * - This feature can only be enabled for a single remote user.
   * - The original resolution of the remote user's video cannot exceed a certain range. If the local user use super resolution on Android,
   * the original resolution of the remote user's video cannot exceed 640 × 360 pixels; if the local user use super resolution on iOS,
   * the original resolution of the remote user's video cannot exceed 640 × 480 pixels.
   *
   * @warning If you exceed these limitations, the SDK triggers the
   * \ref IRtcEngineEventHandler::onWarning "onWarning" callback and returns the corresponding warning codes:
   * - #WARN_SUPER_RESOLUTION_STREAM_OVER_LIMITATION (1610): The original resolution of the remote user's video is beyond
   * the range where super resolution can be applied.
   * - #WARN_SUPER_RESOLUTION_USER_COUNT_OVER_LIMITATION (1611): Super resolution is already being used to boost another
   * remote user's video.
   * - #WARN_SUPER_RESOLUTION_DEVICE_NOT_SUPPORTED (1612): The device does not support using super resolution.
   *
   * @note
   * - This method is for Android and iOS only.
   * - Before calling this method, ensure that you have integrated the following dynamic library into your project:
   *  - Android: `libagora_super_resolution_extension.so`
   *  - iOS: `AgoraSuperResolutionExtension.xcframework`
   * - Because this method has certain system performance requirements, Agora recommends that you use the following devices or better:
   *  - Android:
   *    - VIVO: V1821A, NEX S, 1914A, 1916A, 1962A, 1824BA, X60, X60 Pro
   *    - OPPO: PCCM00, Find X3
   *    - OnePlus: A6000
   *    - Xiaomi: Mi 8, Mi 9, Mi 10, Mi 11, MIX3, Redmi K20 Pro
   *    - SAMSUNG: SM-G9600, SM-G9650, SM-N9600, SM-G9708, SM-G960U, SM-G9750, S20, S21
   *    - HUAWEI: SEA-AL00, ELE-AL00, VOG-AL00, YAL-AL10, HMA-AL00, EVR-AN00, nova 4, nova 5 Pro,
   * nova 6 5G, nova 7 5G, Mate 30, Mate 30 Pro, Mate 40, Mate 40 Pro, P40 P40 Pro, HUAWEI MediaPad M6, MatePad 10.8
   *  - iOS (iOS 12.0 or later):
   *      - iPhone XR
   *      - iPhone XS
   *      - iPhone XS Max
   *      - iPhone 11
   *      - iPhone 11 Pro
   *      - iPhone 11 Pro Max
   *      - iPhone 12
   *      - iPhone 12 mini
   *      - iPhone 12 Pro
   *      - iPhone 12 Pro Max
   *      - iPhone 12 SE (2nd generation)
   *      - iPad Pro 11-inch (3rd generation)
   *      - iPad Pro 12.9-inch (3rd generation)
   *      - iPad Air (3rd generation)
   *      - iPad Air (4th generation)
   *
   * @param userId The user ID of the remote user.
   * @param enable Determines whether to enable super resolution for the remote user's video:
   * - true: Enable super resolution.
   * - false: Disable super resolution.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *   - `-157 (ERR_MODULE_NOT_FOUND)`: The dynamic library for super resolution is not integrated.
   */
  virtual int enableRemoteSuperResolution(uid_t userId, bool enable) = 0;
  /** This method enables you to add synchronized metadata in the video stream for more diversified interactive live streaming, such as sending shopping links, digital coupons, and online quizzes.

  @note Call this method before the joinChannel method.

 @param observer The IMetadataObserver class. See the definition of IMetadataObserver for details.
 @param type See \ref IMetadataObserver::METADATA_TYPE "METADATA_TYPE". The SDK supports VIDEO_METADATA (0) only for now.

 @return
 - 0: Success.
 - < 0: Failure.
 */
  virtual int registerMediaMetadataObserver(IMetadataObserver* observer, IMetadataObserver::METADATA_TYPE type) = 0;
  /** Provides technical preview functionalities or special customizations by configuring the SDK with JSON options.

   The JSON options are not public by default. Agora is working on making commonly used JSON options public in a standard way.

   @param parameters Sets the parameter as a JSON string in the specified format.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setParameters(const char* parameters) = 0;

  // virtual int getMediaRecorder(IMediaRecorderObserver *observer, int sys_version = 0) = 0;

  // virtual int startRecording(const MediaRecorderConfiguration &config) = 0;

  // virtual int stopRecording() = 0;

  // virtual int releaseRecorder() = 0;
  /**
   * Customizes the local video renderer. (for Windows only)
   *
   * @since v3.5.0
   *
   * During a real-time audio and video interaction, the Agora SDK enables the default renderer to render local video.
   * If you want to customize the local video rendering, you can first customize the video renderer via the IVideoSink
   * class, and then call this method to use the custom video renderer to render the local video.
   *
   * @note You can call this method either before or after joining a channel.
   *
   * @param videoSink The custom video renderer. See IVideoSink.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setLocalVideoRenderer(IVideoSink* videoSink) = 0;
  /**
   * Customizes the remote video renderer. (for Windows only)
   *
   * @since v3.5.0
   *
   * During a real-time audio and video interaction, the Agora SDK enables the default renderer to render remote video.
   * If you want to customize the remote video rendering, you can first customize the video renderer via the IVideoSink
   * class, and then call this method to use the custom video renderer to render the remote video.
   *
   * @note You can call this method either before or after joining a channel.
   *
   * @param uid The user ID of the remote user.
   * @param videoSink The custom video renderer. See IVideoSink.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setRemoteVideoRenderer(uid_t uid, IVideoSink* videoSink) = 0;
  /// @cond nodoc
  virtual int setLocalAccessPoint(const LocalAccessPointConfiguration& config) = 0;
  /// @endcond
#if defined(__ANDROID__) || (defined(__APPLE__) && TARGET_OS_IOS)
  /**
   * Sets whether to enable the flash.
   *
   * @since v3.5.1
   *
   * @note
   * - Call this method after the camera is started.
   * - This method is for Android and iOS only.
   * - On iPads with system version 15, even if \ref IRtcEngine::isCameraTorchSupported "isCameraTorchSupported"
   * returns true, you might fail to successfully enable the flash by calling `setCameraTorchOn` due to
   * system issues.
   *
   * @param isOn Determines whether to enable the flash:
   * - true: Enable the flash.
   * - false: Disable the flash.
   *
   * @return
   * - 0: Success
   * - < 0: Failure
   */
  virtual int setCameraTorchOn(bool isOn) = 0;
  /**
   * Checks whether the device supports enabling the flash.
   *
   * @since v3.5.1
   *
   * The SDK uses the front camera by default, so if you call `isCameraTorchSupported` directly,
   * you can find out from the return value whether the device supports enabling the flash
   * when using the front camera. If you want to check whether the device supports enabling the
   * flash when using the rear camera, call \ref IRtcEngine::switchCamera "switchCamera"
   * to switch the camera used by the SDK to the rear camera, and then call `isCameraTorchSupported`.
   *
   * @note
   * - Call this method after the camera is started.
   * - This method is for Android and iOS only.
   * - On iPads with system version 15, even if `isCameraTorchSupported` returns true, you might
   * fail to successfully enable the flash by calling \ref IRtcEngine::setCameraTorchOn "setCameraTorchOn"
   * due to system issues.
   *
   *
   * @return
   * - true: The device supports enabling the flash.
   * - false: The device does not support enabling the flash.
   */
  virtual bool isCameraTorchSupported() = 0;

  /** Sets the camera zoom ratio.
   *
   * Ensure that you call this method after the camera starts, for example, by calling `startPreview` or `joinChannel`.
   *
   * @param factor Sets the camera zoom factor. The value ranges between 1.0 and the maximum zoom supported by the device.
   *
   * @return
   * - The set camera zoom factor, if this method call is successful.
   * - 0: Failure.
   */
  virtual int setCameraZoomFactor(float factor) = 0;
  /** Gets the maximum zoom ratio supported by the camera.
   *
   * Ensure that you call this method after the camera starts, for example, by calling `startPreview` or `joinChannel`.
   *
   * @return The maximum camera zoom factor.
   */
  virtual float getCameraMaxZoomFactor() = 0;
  /** Checks whether the camera zoom function is supported.
   *
   * Ensure that you call this method after the camera starts, for example, by calling `startPreview` or `joinChannel`.
   *
   * @return
   * - true: The device supports the camera zoom function.
   * - false: The device does not support the camera zoom function.
   */
  virtual bool isCameraZoomSupported() = 0;
  /** Checks whether the camera manual focus function is supported.
   *
   * Ensure that you call this method after the camera starts, for example, by calling `startPreview` or `joinChannel`.
   *
   * @return
   * - true: The device supports the camera manual focus function.
   * - false: The device does not support the camera manual focus function.
   */
  virtual bool isCameraFocusSupported() = 0;
  /** Checks whether the camera exposure function is supported.
   *
   * Ensure that you call this method after the camera starts, for example, by calling `startPreview` or `joinChannel`.
   *
   * @return
   * - true: The device supports the camera exposure function.
   * - false: The device does not support the camera exposure function.
   */
  virtual bool isCameraExposurePositionSupported() = 0;
  /** Checks whether the camera auto-face focus function is supported.
   *
   * Ensure that you call this method after the camera starts, for example, by calling `startPreview` or `joinChannel`.
   *
   * @return
   * - true: The device supports the camera auto-face focus function.
   * - false: The device does not support the camera auto-face focus function.
   */
  virtual bool isCameraAutoFocusFaceModeSupported() = 0;
  /** Sets the camera manual focus position.
   *
   * Ensure that you call this method after the camera starts, for example, by calling `startPreview` or `joinChannel`.
   *
   * A successful setCameraFocusPositionInPreview method call triggers the {@link IRtcEngineEventHandler#onCameraFocusAreaChanged onCameraFocusAreaChanged} callback on the local client.
   * @param positionX The horizontal coordinate of the touch point in the view.
   * @param positionY The vertical coordinate of the touch point in the view.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setCameraFocusPositionInPreview(float positionX, float positionY) = 0;
  /** Sets the camera exposure position.
   *
   * Ensure that you call this method after the camera starts, for example, by calling `startPreview` or `joinChannel`.
   *
   * A successful setCameraExposurePosition method call triggers the {@link IRtcEngineEventHandler#onCameraExposureAreaChanged onCameraExposureAreaChanged} callback on the local client.
   * @param positionXinView The horizontal coordinate of the touch point in the view.
   * @param positionYinView The vertical coordinate of the touch point in the view.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setCameraExposurePosition(float positionXinView, float positionYinView) = 0;
  /** Sets whether to enable face autofocus.
   *
   * The SDK disables face autofocus by default. To set face autofocus, call this method.
   *
   * @note
   * Call this method after the camera is started.
   *
   * @param enabled Determines whether to enable face autofocus:
   * - `true`: Enable face autofocus.
   * - `false`: Disable face autofocus.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setCameraAutoFocusFaceModeEnabled(bool enabled) = 0;
#endif

  /**
   * Takes a snapshot of a video stream.
   *
   * @since v3.5.2
   *
   * This method takes a snapshot of a video stream from the specified user, generates a JPG image,
   * and saves it to the specified path.
   *
   * The method is asynchronous, and the SDK has not taken the snapshot when the method call returns.
   * After a successful method call, the SDK triggers the \ref IRtcEngineEventHandler::onSnapshotTaken "onSnapshotTaken"
   * callback to report whether the snapshot is successfully taken as well as the details of the snapshot taken.
   *
   * @note
   * - Call this method after joining a channel.
   * - If the video of the specified user is pre-processed, for example, added with watermarks or image enhancement
   * effects, the generated snapshot also includes the pre-processing effects.
   *
   * @param channel The channel name.
   * @param uid The user ID of the user. Set `uid` as 0 if you want to take a snapshot of the local user's video.
   * @param filePath The local path (including the filename extensions) of the snapshot. For example,
   * `C:\Users\<user_name>\AppData\Local\Agora\<process_name>\example.jpg` on Windows,
   * `/App Sandbox/Library/Caches/example.jpg` on iOS, `～/Library/Logs/example.jpg` on macOS, and
   * `/storage/emulated/0/Android/data/<package name>/files/example.jpg` on Android. Ensure that the path you specify
   * exists and is writable.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int takeSnapshot(const char* channel, uid_t uid, const char* filePath) = 0;

  /// @cond nodoc
  virtual int enableContentInspect(bool enabled, const ContentInspectConfig& config) = 0;
  /// @endcond
};

class IRtcEngineParameter {
 public:
  virtual ~IRtcEngineParameter() {}
  /**
   * Releases all IRtcEngineParameter resources.
   */
  virtual void release() = 0;

  /** Sets the bool value of a specified key in the JSON format.

   @param key Pointer to the name of the key.
   @param value Sets the value.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setBool(const char* key, bool value) = 0;

  /** Sets the int value of a specified key in the JSON format.

   @param key Pointer to the name of the key.
   @param value Sets the value.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setInt(const char* key, int value) = 0;

  /** Sets the unsigned int value of a specified key in the JSON format.

   @param key Pointer to the name of the key.
   @param value Sets the value.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setUInt(const char* key, unsigned int value) = 0;

  /** Sets the double value of a specified key in the JSON format.

   @param key Pointer to the name of the key.
   @param value Sets the value.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setNumber(const char* key, double value) = 0;

  /** Sets the string value of a specified key in the JSON format.

   @param key Pointer to the name of the key.
   @param value Pointer to the set value.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setString(const char* key, const char* value) = 0;

  /** Sets the object value of a specified key in the JSON format.

   @param key Pointer to the name of the key.
   @param value Pointer to the set value.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setObject(const char* key, const char* value) = 0;

  /** Gets the bool value of a specified key in the JSON format.

   @param key Pointer to the name of the key.
   @param value Pointer to the retrieved value.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int getBool(const char* key, bool& value) = 0;

  /** Gets the int value of the JSON format.

   @param key Pointer to the name of the key.
   @param value Pointer to the retrieved value.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int getInt(const char* key, int& value) = 0;

  /** Gets the unsigned int value of a specified key in the JSON format.

   @param key Pointer to the name of the key.
   @param value Pointer to the retrieved value.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int getUInt(const char* key, unsigned int& value) = 0;

  /** Gets the double value of a specified key in the JSON format.

   @param key Pointer to the name of the key.
   @param value Pointer to the retrieved value.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int getNumber(const char* key, double& value) = 0;

  /** Gets the string value of a specified key in the JSON format.

   @param key Pointer to the name of the key.
   @param value Pointer to the retrieved value.

   @return
   - 0: Success.
   - < 0: Failure.
  */
  virtual int getString(const char* key, agora::util::AString& value) = 0;

  /** Gets a child object value of a specified key in the JSON format.

   @param key Pointer to the name of the key.
   @param value Pointer to the retrieved value.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int getObject(const char* key, agora::util::AString& value) = 0;

  /** Gets the array value of a specified key in the JSON format.

   @param key Pointer to the name of the key.
   @param value Pointer to the retrieved value.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int getArray(const char* key, agora::util::AString& value) = 0;

  /** Provides the technical preview functionalities or special customizations by configuring the SDK with JSON options.

   @param parameters Pointer to the set parameters in a JSON string.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setParameters(const char* parameters) = 0;

  /** Sets the profile to control the RTC engine.

   @param profile Pointer to the set profile.
   @param merge Sets whether to merge the profile data with the original value:
   - true: Merge the profile data with the original value.
   - false: Do not merge the profile data with the original value.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setProfile(const char* profile, bool merge) = 0;

  virtual int convertPath(const char* filePath, agora::util::AString& value) = 0;
};

#if !defined(__ANDROID__) && !(defined(__APPLE__) && TARGET_OS_IPHONE)
class AAudioDeviceManager : public agora::util::AutoPtr<IAudioDeviceManager> {
 public:
  AAudioDeviceManager(IRtcEngine* engine) { queryInterface(engine, AGORA_IID_AUDIO_DEVICE_MANAGER); }
};

class AVideoDeviceManager : public agora::util::AutoPtr<IVideoDeviceManager> {
 public:
  AVideoDeviceManager(IRtcEngine* engine) { queryInterface(engine, AGORA_IID_VIDEO_DEVICE_MANAGER); }
};
#endif

class AGORA_CPP_API AParameter : public agora::util::AutoPtr<IRtcEngineParameter> {
 public:
  AParameter(IRtcEngine& engine) { initialize(&engine); }
  AParameter(IRtcEngine* engine) { initialize(engine); }
  AParameter(IRtcEngineParameter* p) : agora::util::AutoPtr<IRtcEngineParameter>(p) {}

 private:
  bool initialize(IRtcEngine* engine) {
    IRtcEngineParameter* p = NULL;
    if (engine && !engine->queryInterface(AGORA_IID_RTC_ENGINE_PARAMETER, (void**)&p)) reset(p);
    return p != NULL;
  }
};
/** **DEPRECATED** The RtcEngineParameters class is deprecated, use the IRtcEngine class instead.
 */
class AGORA_CPP_API RtcEngineParameters {
 public:
  RtcEngineParameters(IRtcEngine& engine) : m_parameter(&engine) {}
  RtcEngineParameters(IRtcEngine* engine) : m_parameter(engine) {}

  int enableLocalVideo(bool enabled);
  int muteLocalVideoStream(bool mute);
  int muteAllRemoteVideoStreams(bool mute);
  int setDefaultMuteAllRemoteVideoStreams(bool mute);
  int muteRemoteVideoStream(uid_t uid, bool mute);
  int setPlaybackDeviceVolume(int volume /* [0,255] */);
  int startAudioRecording(const char* filePath, AUDIO_RECORDING_QUALITY_TYPE quality);
  int startAudioRecording(const char* filePath, int sampleRate, AUDIO_RECORDING_QUALITY_TYPE quality);
  int stopAudioRecording();
  int startAudioMixing(const char* filePath, bool loopback, bool replace, int cycle, int startPos = 0);
  int stopAudioMixing();
  int pauseAudioMixing();
  int resumeAudioMixing();
  int adjustAudioMixingVolume(int volume);
  int adjustAudioMixingPlayoutVolume(int volume);
  int getAudioMixingPlayoutVolume();
  int adjustAudioMixingPublishVolume(int volume);
  int getAudioMixingPublishVolume();
  int getAudioMixingDuration();
  int getAudioMixingCurrentPosition();
  int setAudioMixingPosition(int pos /*in ms*/);
  int setAudioMixingPitch(int pitch);
  int getEffectsVolume();
  int setEffectsVolume(int volume);
  int setVolumeOfEffect(int soundId, int volume);
  int playEffect(int soundId, const char* filePath, int loopCount, double pitch, double pan, int gain, bool publish = false);
  int stopEffect(int soundId);
  int stopAllEffects();
  int preloadEffect(int soundId, char* filePath);
  int unloadEffect(int soundId);
  int pauseEffect(int soundId);
  int pauseAllEffects();
  int resumeEffect(int soundId);
  int resumeAllEffects();
  int enableSoundPositionIndication(bool enabled);
  int setRemoteVoicePosition(uid_t uid, double pan, double gain);
  int setLocalVoicePitch(double pitch);
  int setLocalVoiceEqualization(AUDIO_EQUALIZATION_BAND_FREQUENCY bandFrequency, int bandGain);
  int setLocalVoiceReverb(AUDIO_REVERB_TYPE reverbKey, int value);
  int setLocalVoiceChanger(VOICE_CHANGER_PRESET voiceChanger);
  int setLocalVoiceReverbPreset(AUDIO_REVERB_PRESET reverbPreset);
  int setAudioEffectPreset(AUDIO_EFFECT_PRESET preset);
  int setVoiceBeautifierPreset(VOICE_BEAUTIFIER_PRESET preset);
  int setAudioEffectParameters(AUDIO_EFFECT_PRESET preset, int param1, int param2);
  int setVoiceBeautifierParameters(VOICE_BEAUTIFIER_PRESET preset, int param1, int param2);
  int pauseAudio();
  int resumeAudio();
  int setHighQualityAudioParameters(bool fullband, bool stereo, bool fullBitrate);
  int adjustRecordingSignalVolume(int volume /* [0, 400]: e.g. 50~0.5x 100~1x 400~4x */);
  int adjustPlaybackSignalVolume(int volume /* [0, 400] */);
  int enableAudioVolumeIndication(int interval, int smooth, bool report_vad);  // in ms: <= 0: disable, > 0: enable, interval in ms
  int enableLocalVoicePitchCallback(int interval);
  int muteLocalAudioStream(bool mute);
  int muteRemoteAudioStream(uid_t uid, bool mute);
  int muteAllRemoteAudioStreams(bool mute);
  int setVoiceConversionPreset(VOICE_CONVERSION_PRESET preset);
  int setDefaultMuteAllRemoteAudioStreams(bool mute);
  int setExternalAudioSource(bool enabled, int sampleRate, int channels);
  int setExternalAudioSink(bool enabled, int sampleRate, int channels);
  int setLogFile(const char* filePath);
  int setLogFilter(unsigned int filter);
  int setLogFileSize(unsigned int fileSizeInKBytes);
  int setLocalRenderMode(RENDER_MODE_TYPE renderMode);
  int setRemoteRenderMode(uid_t uid, RENDER_MODE_TYPE renderMode);
  int setCameraCapturerConfiguration(const CameraCapturerConfiguration& config);
  int enableDualStreamMode(bool enabled);
  int setRemoteVideoStreamType(uid_t uid, REMOTE_VIDEO_STREAM_TYPE streamType);
  int setRemoteDefaultVideoStreamType(REMOTE_VIDEO_STREAM_TYPE streamType);
  int setRecordingAudioFrameParameters(int sampleRate, int channel, RAW_AUDIO_FRAME_OP_MODE_TYPE mode, int samplesPerCall);
  int setPlaybackAudioFrameParameters(int sampleRate, int channel, RAW_AUDIO_FRAME_OP_MODE_TYPE mode, int samplesPerCall);
  int setMixedAudioFrameParameters(int sampleRate, int samplesPerCall);
  int enableWebSdkInteroperability(bool enabled);

  // only for live broadcast

  int setVideoQualityParameters(bool preferFrameRateOverImageQuality);
  int setLocalVideoMirrorMode(VIDEO_MIRROR_MODE_TYPE mirrorMode);
  int setLocalPublishFallbackOption(STREAM_FALLBACK_OPTIONS option);
  int setRemoteSubscribeFallbackOption(STREAM_FALLBACK_OPTIONS option);
#if (defined(__APPLE__) && TARGET_OS_MAC && !TARGET_OS_IPHONE) || defined(_WIN32)
  int enableLoopbackRecording(bool enabled, const char* deviceName = NULL);
#endif
  int setInEarMonitoringVolume(int volume);

 protected:
  AParameter& parameter() { return m_parameter; }
  int setParameters(const char* format, ...) {
    char buf[512];
    va_list args;
    va_start(args, format);
    vsnprintf(buf, sizeof(buf) - 1, format, args);
    va_end(args);
    return m_parameter ? m_parameter->setParameters(buf) : -ERR_NOT_INITIALIZED;
  }
  int setObject(const char* key, const char* format, ...) {
    char buf[512];
    va_list args;
    va_start(args, format);
    vsnprintf(buf, sizeof(buf) - 1, format, args);
    va_end(args);
    return m_parameter ? m_parameter->setObject(key, buf) : -ERR_NOT_INITIALIZED;
  }

 private:
  AParameter m_parameter;
};
/**
 * The format of the recording file.
 *
 * @since v3.5.2
 */
enum MediaRecorderContainerFormat {
  /**
   * 1: (Default) MP4.
   */
  FORMAT_MP4 = 1,
  /**
   * Reserved parameter.
   */
  FORMAT_FLV = 2,
};
/**
 * The recording content.
 *
 * @since v3.5.2
 */
enum MediaRecorderStreamType {
  /**
   * Only audio.
   */
  STREAM_TYPE_AUDIO = 0x01,
  /**
   * Only video.
   */
  STREAM_TYPE_VIDEO = 0x02,
  /**
   * (Default) Audio and video.
   */
  STREAM_TYPE_BOTH = STREAM_TYPE_AUDIO | STREAM_TYPE_VIDEO,
};
/**
 * The current recording state.
 *
 * @since v3.5.2
 */
enum RecorderState {
  /**
   * -1: An error occurs during the recording. See RecorderErrorCode for the reason.
   */
  RECORDER_STATE_ERROR = -1,
  /**
   * 2: The audio and video recording is started.
   */
  RECORDER_STATE_START = 2,
  /**
   * 3: The audio and video recording is stopped.
   */
  RECORDER_STATE_STOP = 3,
};
/**
 * The reason for the state change
 *
 * @since v3.5.2
 */
enum RecorderErrorCode {
  /**
   * 0: No error occurs.
   */
  RECORDER_ERROR_NONE = 0,
  /**
   * 1: The SDK fails to write the recorded data to a file.
   */
  RECORDER_ERROR_WRITE_FAILED = 1,
  /**
   * 2: The SDK does not detect audio and video streams to be recorded, or audio and video streams are interrupted for more than five seconds during recording.
   */
  RECORDER_ERROR_NO_STREAM = 2,
  /**
   * 3: The recording duration exceeds the upper limit.
   */
  RECORDER_ERROR_OVER_MAX_DURATION = 3,
  /**
   * 4: The recording configuration changes.
   */
  RECORDER_ERROR_CONFIG_CHANGED = 4,
  /**
   * 5: The SDK detects audio and video streams from users using versions of the SDK earlier than v3.0.0 in
   * the `COMMUNICATION` channel profile.
   */
  RECORDER_ERROR_CUSTOM_STREAM_DETECTED = 5,
};
/**
 * Configurations for the local audio and video recording.
 *
 * @since v3.5.2
 */
struct MediaRecorderConfiguration {
  /**
   * The absolute path (including the filename extensions) of the recording file.
   * For example, `C:\Users\<user_name>\AppData\Local\Agora\<process_name>\example.mp4` on Windows,
   * `/App Sandbox/Library/Caches/example.mp4` on iOS, `/Library/Logs/example.mp4` on macOS, and
   * `/storage/emulated/0/Android/data/<package name>/files/example.mp4` on Android.
   *
   * @note Ensure that the specified path exists and is writable.
   */
  const char* storagePath;
  /**
   * The format of the recording file. See \ref agora::rtc::MediaRecorderContainerFormat "MediaRecorderContainerFormat".
   */
  MediaRecorderContainerFormat containerFormat;
  /**
   * The recording content. See \ref agora::rtc::MediaRecorderStreamType "MediaRecorderStreamType".
   */
  MediaRecorderStreamType streamType;
  /**
   * The maximum recording duration, in milliseconds. The default value is 120000.
   */
  int maxDurationMs;
  /**
   * The interval (ms) of updating the recording information. The value range is
   * [1000,10000]. Based on the set value of `recorderInfoUpdateInterval`, the
   * SDK triggers the \ref IMediaRecorderObserver::onRecorderInfoUpdated "onRecorderInfoUpdated"
   * callback to report the updated recording information.
   */
  int recorderInfoUpdateInterval;

  MediaRecorderConfiguration() : storagePath(nullptr), containerFormat(FORMAT_MP4), streamType(STREAM_TYPE_BOTH), maxDurationMs(120000), recorderInfoUpdateInterval(0) {}
  MediaRecorderConfiguration(const char* path, MediaRecorderContainerFormat format, MediaRecorderStreamType type, int duration, int interval) : storagePath(path), containerFormat(format), streamType(type), maxDurationMs(duration), recorderInfoUpdateInterval(interval) {}
};
/**
 * Information for the recording file.
 *
 * @since v3.5.2
 */
struct RecorderInfo {
  /**
   * The absolute path of the recording file.
   */
  const char* fileName;
  /**
   * The recording duration, in milliseconds.
   */
  unsigned int durationMs;
  /**
   * The size in bytes of the recording file.
   */
  unsigned int fileSize;

  RecorderInfo() = default;
  RecorderInfo(const char* name, unsigned int dur, unsigned int size) : fileName(name), durationMs(dur), fileSize(size) {}
};

/**
 * The IMediaRecorderObserver class.
 *
 * @since v3.5.2
 */
class IMediaRecorderObserver {
 public:
  /**
   * Occurs when the recording state changes.
   *
   * @since v3.5.2
   *
   * When the local audio and video recording state changes, the SDK triggers this callback to report the current
   * recording state and the reason for the change.
   *
   * @param state The current recording state. See \ref agora::rtc::RecorderState "RecorderState".
   * @param error The reason for the state change. See \ref agora::rtc::RecorderErrorCode "RecorderErrorCode".
   */
  virtual void onRecorderStateChanged(RecorderState state, RecorderErrorCode error) = 0;
  /**
   * Occurs when the recording information is updated.
   *
   * @since v3.5.2
   *
   * After you successfully register this callback and enable the local audio and video recording, the SDK periodically triggers
   * the `onRecorderInfoUpdated` callback based on the set value of `recorderInfoUpdateInterval`. This callback reports the
   * filename, duration, and size of the current recording file.
   *
   * @param info Information for the recording file. See RecorderInfo.
   *
   */
  virtual void onRecorderInfoUpdated(const RecorderInfo& info){};
};
/**
 * The IMediaRecorder class, for recording the audio and video on the client. IMediaRecorder can record the
 * following content:
 * - The audio captured by the local microphone and encoded in AAC format.
 * - The video captured by the local camera and encoded by the SDK.
 *
 * @since v3.5.2
 *
 * @note In the `COMMUNICATION` channel profile, this function is unavailable when there are users using versions of
 * the SDK earlier than v3.0.0 in the channel.
 */
class IMediaRecorder {
 public:
  /**
   * Gets the IMediaRecorder object.
   *
   * @since v3.5.2
   *
   * @note Call this method after initializing the IRtcEngine object.
   *
   * @param engine IRtcEngine
   * @param callback IMediaRecorderObserver
   *
   * @return IMediaRecorder
   */
  AGORA_CPP_API static IMediaRecorder* getMediaRecorder(IRtcEngine* engine, IMediaRecorderObserver* callback);
  /**
   * Starts recording the local audio and video.
   *
   * @since v3.5.2
   *
   * After successfully getting the object, you can call this method to enable the recording of the local audio and video.
   *
   * This method can record the following content:
   * - The audio captured by the local microphone and encoded in AAC format.
   * - The video captured by the local camera and encoded by the SDK.
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
   *    - `-2(ERR_INVALID_ARGUMENT)`: The parameter is invalid. Ensure the following:
   *      - The specified path of the recording file exists and is writable.
   *      - The specified format of the recording file is supported.
   *      - The maximum recording duration is correctly set.
   *    - `-4(ERR_NOT_SUPPORTED)`: IRtcEngine does not support the request due to one of the following reasons:
   *      - The recording is ongoing.
   *      - The recording stops because an error occurs.
   *    - `-7(ERR_NOT_INITIALIZED)`: This method is called before the initialization of IRtcEngine. Ensure that you have
   * called \ref IMediaRecorder::getMediaRecorder "getMediaRecorder" before calling `startRecording`.
   */
  virtual int startRecording(const MediaRecorderConfiguration& config) = 0;
  /**
   * Stops recording the local audio and video.
   *
   * @since v3.5.2
   *
   * @note After calling \ref IMediaRecorder::startRecording "startRecording", if you want to stop the recording,
   * you must call `stopRecording`; otherwise, the generated recording files might not be playable.
   *
   *
   * @return
   * - 0(ERR_OK): Success.
   * - < 0: Failure:
   *  - `-7(ERR_NOT_INITIALIZED)`: This method is called before the initialization of IRtcEngine. Ensure that you have
   * called \ref IMediaRecorder::getMediaRecorder "getMediaRecorder" before calling `stopRecording`.
   */
  virtual int stopRecording() = 0;
  /**
   * Releases the IMediaRecorder object.
   *
   * @since v3.5.2
   *
   * This method releases the IRtcEngine object and all other resources used by the IMediaRecorder object. After calling
   * this method, if you want to enable the recording again, you must call
   * \ref IMediaRecorder::getMediaRecorder "getMediaRecorder" to get the IMediaRecorder object.
   */
  virtual void releaseRecorder() = 0;
};

}  // namespace rtc
}  // namespace agora

#define getAgoraRtcEngineVersion getAgoraSdkVersion

////////////////////////////////////////////////////////
/** \addtogroup createAgoraRtcEngine
 @{
 */
////////////////////////////////////////////////////////

/** Creates the IRtcEngine object and returns the pointer.
 *
 * @note The Agora RTC Native SDK supports creating only one `IRtcEngine` object for an app for now.
 *
 * @return Pointer to the IRtcEngine object.
 */
AGORA_API agora::rtc::IRtcEngine* AGORA_CALL createAgoraRtcEngine();

////////////////////////////////////////////////////////
/** @} */
////////////////////////////////////////////////////////

#define getAgoraRtcEngineErrorDescription getAgoraSdkErrorDescription
#define setAgoraRtcEngineExternalSymbolLoader setAgoraSdkExternalSymbolLoader

#endif
