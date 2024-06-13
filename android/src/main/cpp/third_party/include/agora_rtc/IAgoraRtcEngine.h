//
//  Agora Rtc Engine SDK
//
//  Copyright (c) 2018 Agora.io. All rights reserved.
//
#pragma once

#include "AgoraBase.h"
#include "AgoraMediaBase.h"
#include "IAgoraLog.h"
#include "AgoraOptional.h"
#include "IAudioDeviceManager.h"
#include "IAgoraRhythmPlayer.h"
#include "IAgoraMediaEngine.h"
#include "IAgoraH265Transcoder.h"

namespace agora {
namespace rtm {
class IStreamChannel;
}
namespace rtc {

template <typename T>
static void SetFrom(Optional<T>* s, const Optional<T>& o) {
  if (o) {
    *s = o;
  }
}

template <typename T>
static void ReplaceBy(Optional<T>* s, const Optional<T>& o) {
  *s = o;
}

//class IAudioDeviceManager;

/**
 * The media device types.
 */
enum MEDIA_DEVICE_TYPE {
  /**
   * -1: Unknown device type.
   */
  UNKNOWN_AUDIO_DEVICE = -1,
  /**
   * 0: The audio playback device.
   */
  AUDIO_PLAYOUT_DEVICE = 0,
  /**
   * 1: The audio recording device.
   */
  AUDIO_RECORDING_DEVICE = 1,
  /**
   * 2: The video renderer.
   */
  VIDEO_RENDER_DEVICE = 2,
  /**
   * 3: The video capturer.
   */
  VIDEO_CAPTURE_DEVICE = 3,
  /**
   * 4: The audio playback device of the app.
   */
  AUDIO_APPLICATION_PLAYOUT_DEVICE = 4,
  /**
   * 5: The virtual audio playback device.
   */
  AUDIO_VIRTUAL_PLAYOUT_DEVICE = 5,
  /**
   * 6: The virtual audio recording device.
   */
  AUDIO_VIRTUAL_RECORDING_DEVICE = 6,
};

/**
 The playback state of the music file.
 */
enum AUDIO_MIXING_STATE_TYPE {
 /** 710: The music file is playing. */
  AUDIO_MIXING_STATE_PLAYING = 710,
  /** 711: The music file pauses playing. */
  AUDIO_MIXING_STATE_PAUSED = 711,
  /** 713: The music file stops playing. */
  AUDIO_MIXING_STATE_STOPPED = 713,
  /** 714: An error occurs during the playback of the audio mixing file.
   */
  AUDIO_MIXING_STATE_FAILED = 714,
};

/**
 The reson codes of the local user's audio mixing file.
 */
enum AUDIO_MIXING_REASON_TYPE {
  /** 701: The SDK cannot open the audio mixing file. */
  AUDIO_MIXING_REASON_CAN_NOT_OPEN = 701,
  /** 702: The SDK opens the audio mixing file too frequently. */
  AUDIO_MIXING_REASON_TOO_FREQUENT_CALL = 702,
  /** 703: The audio mixing file playback is interrupted. */
  AUDIO_MIXING_REASON_INTERRUPTED_EOF = 703,
  /** 715: The audio mixing file is played once. */
  AUDIO_MIXING_REASON_ONE_LOOP_COMPLETED = 721,
  /** 716: The audio mixing file is all played out. */
  AUDIO_MIXING_REASON_ALL_LOOPS_COMPLETED = 723,
  /** 716: The audio mixing file stopped by user */
  AUDIO_MIXING_REASON_STOPPED_BY_USER = 724,
  /** 0: The SDK can open the audio mixing file. */
  AUDIO_MIXING_REASON_OK = 0,
};

/**
 * The status of importing an external video stream in a live broadcast.
 */
enum INJECT_STREAM_STATUS {
  /**
   * 0: The media stream is injected successfully.
   */
  INJECT_STREAM_STATUS_START_SUCCESS = 0,
  /**
   * 1: The media stream already exists.
   */
  INJECT_STREAM_STATUS_START_ALREADY_EXISTS = 1,
  /**
   * 2: The media stream injection is unauthorized.
   */
  INJECT_STREAM_STATUS_START_UNAUTHORIZED = 2,
  /**
   * 3: Timeout occurs when injecting a media stream.
   */
  INJECT_STREAM_STATUS_START_TIMEDOUT = 3,
  /**
   * 4: The media stream injection fails.
   */
  INJECT_STREAM_STATUS_START_FAILED = 4,
  /**
   * 5: The media stream stops being injected successfully.
   */
  INJECT_STREAM_STATUS_STOP_SUCCESS = 5,
  /**
   * 6: The media stream injection that you want to stop is found.
   */
  INJECT_STREAM_STATUS_STOP_NOT_FOUND = 6,
  /**
   * 7: You are not authorized to stop the media stream injection.
   */
  INJECT_STREAM_STATUS_STOP_UNAUTHORIZED = 7,
  /**
   * 8: Timeout occurs when you stop injecting the media stream.
   */
  INJECT_STREAM_STATUS_STOP_TIMEDOUT = 8,
  /**
   * 9: Stopping injecting the media stream fails.
   */
  INJECT_STREAM_STATUS_STOP_FAILED = 9,
  /**
   * 10: The media stream is broken.
   */
  INJECT_STREAM_STATUS_BROKEN = 10,
};

/**
 * The audio equalization band frequency.
 */
enum AUDIO_EQUALIZATION_BAND_FREQUENCY {
  /**
   * 0: 31 Hz.
   */
  AUDIO_EQUALIZATION_BAND_31 = 0,
  /**
   * 1: 62 Hz.
   */
  AUDIO_EQUALIZATION_BAND_62 = 1,
  /**
   * 2: 125 Hz.
   */
  AUDIO_EQUALIZATION_BAND_125 = 2,
  /**
   * 3: 250 Hz.
   */
  AUDIO_EQUALIZATION_BAND_250 = 3,
  /**
   * 4: 500 Hz.
   */
  AUDIO_EQUALIZATION_BAND_500 = 4,
  /**
   * 5: 1 KHz.
   */
  AUDIO_EQUALIZATION_BAND_1K = 5,
  /**
   * 6: 2 KHz.
   */
  AUDIO_EQUALIZATION_BAND_2K = 6,
  /**
   * 7: 4 KHz.
   */
  AUDIO_EQUALIZATION_BAND_4K = 7,
  /**
   * 8: 8 KHz.
   */
  AUDIO_EQUALIZATION_BAND_8K = 8,
  /**
   * 9: 16 KHz.
   */
  AUDIO_EQUALIZATION_BAND_16K = 9,
};

/**
 * The audio reverberation type.
 */
enum AUDIO_REVERB_TYPE {
  /**
   * 0: (-20 to 10 dB), the level of the dry signal.
   */
  AUDIO_REVERB_DRY_LEVEL = 0,
  /**
   * 1: (-20 to 10 dB), the level of the early reflection signal (wet signal).
   */
  AUDIO_REVERB_WET_LEVEL = 1,
  /**
   * 2: (0 to 100 dB), the room size of the reflection.
   */
  AUDIO_REVERB_ROOM_SIZE = 2,
  /**
   * 3: (0 to 200 ms), the length of the initial delay of the wet signal in ms.
   */
  AUDIO_REVERB_WET_DELAY = 3,
  /**
   * 4: (0 to 100), the strength of the late reverberation.
   */
  AUDIO_REVERB_STRENGTH = 4,
};

enum STREAM_FALLBACK_OPTIONS {
  /** 0: No fallback operation to a lower resolution stream when the network
     condition is poor. Fallback to Scalable Video Coding (e.g. SVC)
     is still possible, but the resolution remains in high stream.
     The stream quality cannot be guaranteed. */
  STREAM_FALLBACK_OPTION_DISABLED = 0,
  /** 1: (Default) Under poor network conditions, the receiver SDK will receive
     agora::rtc::VIDEO_STREAM_LOW. You can only set this option in
     RtcEngineParameters::setRemoteSubscribeFallbackOption. Nothing happens when
     you set this in RtcEngineParameters::setLocalPublishFallbackOption. */
  STREAM_FALLBACK_OPTION_VIDEO_STREAM_LOW = 1,
  /** 2: Under poor network conditions, the SDK may receive agora::rtc::VIDEO_STREAM_LOW first,
     then agora::rtc::VIDEO_STREAM_LAYER_1 to agora::rtc::VIDEO_STREAM_LAYER_6 if the related layer exists.
     If the network still does not allow displaying the video, the SDK will receive audio only. */
  STREAM_FALLBACK_OPTION_AUDIO_ONLY = 2,
  /** 3~8: If the receiver SDK uses RtcEngineParameters::setRemoteSubscribeFallbackOption，it will receive
     one of the streams from agora::rtc::VIDEO_STREAM_LAYER_1 to agora::rtc::VIDEO_STREAM_LAYER_6
     if the related layer exists when the network condition is poor. The lower bound of fallback depends on
     the STREAM_FALLBACK_OPTION_VIDEO_STREAM_LAYER_X. */
  STREAM_FALLBACK_OPTION_VIDEO_STREAM_LAYER_1 = 3,
  STREAM_FALLBACK_OPTION_VIDEO_STREAM_LAYER_2 = 4,
  STREAM_FALLBACK_OPTION_VIDEO_STREAM_LAYER_3 = 5,
  STREAM_FALLBACK_OPTION_VIDEO_STREAM_LAYER_4 = 6,
  STREAM_FALLBACK_OPTION_VIDEO_STREAM_LAYER_5 = 7,
  STREAM_FALLBACK_OPTION_VIDEO_STREAM_LAYER_6 = 8,
};

enum PRIORITY_TYPE {
  /** 50: High priority.
   */
  PRIORITY_HIGH = 50,
  /** 100: (Default) normal priority.
   */
  PRIORITY_NORMAL = 100,
};

struct RtcConnection;

/** Statistics of the local video stream.
 */
struct LocalVideoStats
{
  /**
  * ID of the local user.
  */
  uid_t uid;
  /** The actual bitrate (Kbps) while sending the local video stream.
    * @note This value does not include the bitrate for resending the video after packet loss.
    */
  int sentBitrate;
  /** The actual frame rate (fps) while sending the local video stream.
    * @note This value does not include the frame rate for resending the video after packet loss.
    */
  int sentFrameRate;
  /** The capture frame rate (fps) of the local video.
    */
  int captureFrameRate;
  /** The width of the capture frame (px).
    */
  int captureFrameWidth;
  /** The height of the capture frame (px).
    */
  int captureFrameHeight;
  /**
    * The regulated frame rate of capture frame rate according to video encoder configuration.
    */
  int regulatedCaptureFrameRate;
  /**
    * The regulated frame width (pixel) of capture frame width according to video encoder configuration.
    */
  int regulatedCaptureFrameWidth;
  /**
    * The regulated frame height (pixel) of capture frame height according to video encoder configuration.
    */
  int regulatedCaptureFrameHeight;
  /** The output frame rate (fps) of the local video encoder.
    */
  int encoderOutputFrameRate;
  /** The width of the encoding frame (px).
    */
  int encodedFrameWidth;
  /** The height of the encoding frame (px).
    */
  int encodedFrameHeight;
  /** The output frame rate (fps) of the local video renderer.
    */
  int rendererOutputFrameRate;
  /** The target bitrate (Kbps) of the current encoder. This is an estimate made by the SDK based on the current network conditions.
    */
  int targetBitrate;
  /** The target frame rate (fps) of the current encoder.
    */
  int targetFrameRate;
  /** Quality adaption of the local video stream in the reported interval (based on the target frame
    * rate and target bitrate). See #QUALITY_ADAPT_INDICATION.
    */
  QUALITY_ADAPT_INDICATION qualityAdaptIndication;
  /** The bitrate (Kbps) while encoding the local video stream.
    * @note This value does not include the bitrate for resending the video after packet loss.
    */
  int encodedBitrate;
  /** The number of the sent video frames, represented by an aggregate value.
    */
  int encodedFrameCount;
  /** The codec type of the local video. See #VIDEO_CODEC_TYPE.
    */
  VIDEO_CODEC_TYPE codecType;
  /**
    * The video packet loss rate (%) from the local client to the Agora server before applying the anti-packet loss strategies.
    */
  unsigned short txPacketLossRate;
  /** The brightness level of the video image captured by the local camera. See #CAPTURE_BRIGHTNESS_LEVEL_TYPE.
    */
  CAPTURE_BRIGHTNESS_LEVEL_TYPE captureBrightnessLevel;
  /**
    * Whether we send dual stream now.
    */
  bool dualStreamEnabled;
  /** The hwEncoderAccelerating of the local video:
    * - software = 0.
    * - hardware = 1.
    */
  int hwEncoderAccelerating;
  /** The dimensions of the simulcast streams's encoding frame.
    */
  VideoDimensions simulcastDimensions[SimulcastConfig::STREAM_LAYER_COUNT_MAX];
};

/**
 * Audio statistics of the remote user.
 */
struct RemoteAudioStats
{
  /**
   * User ID of the remote user sending the audio stream.
   */
  uid_t uid;
  /**
   * The quality of the remote audio: #QUALITY_TYPE.
   */
  int quality;
  /**
   * The network delay (ms) from the sender to the receiver.
   */
  int networkTransportDelay;
  /**
   * The network delay (ms) from the receiver to the jitter buffer.
   * @note When the receiving end is an audience member and `audienceLatencyLevel` of `ClientRoleOptions`
   * is 1, this parameter does not take effect.
   */
  int jitterBufferDelay;
  /**
   * The audio frame loss rate in the reported interval.
   */
  int audioLossRate;
  /**
   * The number of channels.
   */
  int numChannels;
  /**
   * The sample rate (Hz) of the remote audio stream in the reported interval.
   */
  int receivedSampleRate;
  /**
   * The average bitrate (Kbps) of the remote audio stream in the reported
   * interval.
   */
  int receivedBitrate;
  /**
   * The total freeze time (ms) of the remote audio stream after the remote
   * user joins the channel.
   *
   * In a session, audio freeze occurs when the audio frame loss rate reaches 4%.
   */
  int totalFrozenTime;
  /**
   * The total audio freeze time as a percentage (%) of the total time when the
   * audio is available.
   */
  int frozenRate;
  /**
   * The quality of the remote audio stream as determined by the Agora
   * real-time audio MOS (Mean Opinion Score) measurement method in the
   * reported interval. The return value ranges from 0 to 500. Dividing the
   * return value by 100 gets the MOS score, which ranges from 0 to 5. The
   * higher the score, the better the audio quality.
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
  /**
   * If the packet loss concealment (PLC) occurs for N consecutive times, freeze is considered as PLC occurring for M consecutive times.
   * freeze cnt = (n_plc - n) / m
   */
  uint32_t frozenRateByCustomPlcCount;
  /**
   * The number of audio packet loss concealment
   */
  uint32_t plcCount;

  /**
   * The total time (ms) when the remote user neither stops sending the audio
   * stream nor disables the audio module after joining the channel.
   */
  int totalActiveTime;
  /**
   * The total publish duration (ms) of the remote audio stream.
   */
  int publishDuration;
  /**
   * Quality of experience (QoE) of the local user when receiving a remote audio stream. See #EXPERIENCE_QUALITY_TYPE.
   */
  int qoeQuality;
  /**
   * The reason for poor QoE of the local user when receiving a remote audio stream. See #EXPERIENCE_POOR_REASON.
   */
  int qualityChangedReason;
  /**
   * The total number of audio bytes received (bytes), inluding the FEC bytes, represented by an aggregate value.
   */
  unsigned int rxAudioBytes;
  /**
   * The end-to-end delay (ms) from the sender to the receiver.
   */
  int e2eDelay;

  RemoteAudioStats()
      : uid(0),
        quality(0),
        networkTransportDelay(0),
        jitterBufferDelay(0),
        audioLossRate(0),
        numChannels(0),
        receivedSampleRate(0),
        receivedBitrate(0),
        totalFrozenTime(0),
        frozenRate(0),
        mosValue(0),
        frozenRateByCustomPlcCount(0),
        plcCount(0),
        totalActiveTime(0),
        publishDuration(0),
        qoeQuality(0),
        qualityChangedReason(0),
        rxAudioBytes(0),
        e2eDelay(0) {}
};

/**
 * The statistics of the remote video stream.
 */
struct RemoteVideoStats {
  /**
   * ID of the remote user sending the video stream.
   */
  uid_t uid;
  /**
   * @deprecated Time delay (ms).
   *
   * In scenarios where audio and video is synchronized, you can use the
   * value of `networkTransportDelay` and `jitterBufferDelay` in `RemoteAudioStats`
   * to know the delay statistics of the remote video.
   */
  int delay __deprecated;
  /**
   * End-to-end delay from video capturer to video renderer. Hardware capture or render delay is excluded.
   */
  int e2eDelay;
  /**
   * The width (pixels) of the video stream.
   */
  int width;
  /**
   * The height (pixels) of the video stream.
   */
  int height;
  /**
   * Bitrate (Kbps) received since the last count.
   */
  int receivedBitrate;
  /** The decoder input frame rate (fps) of the remote video.
   */
  int decoderInputFrameRate;
  /** The decoder output frame rate (fps) of the remote video.
   */
  int decoderOutputFrameRate;
  /** The render output frame rate (fps) of the remote video.
   */
  int rendererOutputFrameRate;
  /** The video frame loss rate (%) of the remote video stream in the reported interval.
   */
  int frameLossRate;
  /** Packet loss rate (%) of the remote video stream after using the anti-packet-loss method.
   */
  int packetLossRate;
  /**
   * The type of the remote video stream: #VIDEO_STREAM_TYPE.
   */
  VIDEO_STREAM_TYPE rxStreamType;
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
   The offset (ms) between audio and video stream. A positive value indicates the audio leads the
   video, and a negative value indicates the audio lags the video.
   */
  int avSyncTimeMs;
  /**
   * The total time (ms) when the remote user neither stops sending the audio
   * stream nor disables the audio module after joining the channel.
   */
  int totalActiveTime;
  /**
   * The total publish duration (ms) of the remote audio stream.
   */
  int publishDuration;
  /**
   * The quality of the remote video stream in the reported interval. 
   * The quality is determined by the Agora real-time video MOS (Mean Opinion Score) measurement method. 
   * The return value range is [0, 500]. 
   * Dividing the return value by 100 gets the MOS score, which ranges from 0 to 5. The higher the score, the better the video quality.
   * @note For textured video data, this parameter always returns 0.
   */
  int mosValue;
  /**
   * The total number of video bytes received (bytes), inluding the FEC bytes, represented by an aggregate value.
   */
  unsigned int rxVideoBytes;
};

struct VideoCompositingLayout {
  struct Region {
    /** User ID of the user whose video is to be displayed in the region.
     */
    uid_t uid;
    /** Horizontal position of the region on the screen.
     */
    double x;  // [0,1]
    /** Vertical position of the region on the screen.
     */
    double y;  // [0,1]
    /**
     Actual width of the region.
    */
    double width;  // [0,1]
    /** Actual height of the region. */
    double height;  // [0,1]
    /** 0 means the region is at the bottom, and 100 means the region is at the
     * top.
     */
    int zOrder;  // optional, [0, 100] //0 (default): bottom most, 100: top most

    /** 0 means the region is transparent, and 1 means the region is opaque. The
     * default value is 1.0.
     */
    double alpha;

    media::base::RENDER_MODE_TYPE renderMode;  // RENDER_MODE_HIDDEN: Crop, RENDER_MODE_FIT: Zoom to fit

    Region()
        : uid(0),
          x(0),
          y(0),
          width(0),
          height(0),
          zOrder(0),
          alpha(1.0),
          renderMode(media::base::RENDER_MODE_HIDDEN) {}
  };

  /** Ignore this parameter. The width of the canvas is set by
   agora::rtc::IRtcEngine::configPublisher, and not by
   agora::rtc::VideoCompositingLayout::canvasWidth.
  */
  int canvasWidth;
  /** Ignore this parameter. The height of the canvas is set by
   agora::rtc::IRtcEngine::configPublisher, and not by
   agora::rtc::VideoCompositingLayout::canvasHeight.
  */
  int canvasHeight;
  /** Enter any of the 6-digit symbols defined in RGB.
   */
  const char* backgroundColor;  // e.g. "#C0C0C0" in RGB
  /** Region array. Each host in the channel can have a region to display the
   * video on the screen.
   */
  const Region* regions;
  /** Number of users in the channel.
   */
  int regionCount;
  /** User-defined data.
   */
  const char* appData;
  /** Length of the user-defined data.
   */
  int appDataLength;

  VideoCompositingLayout()
      : canvasWidth(0),
        canvasHeight(0),
        backgroundColor(OPTIONAL_NULLPTR),
        regions(NULL),
        regionCount(0),
        appData(OPTIONAL_NULLPTR),
        appDataLength(0) {}
};

/** The definition of InjectStreamConfig.
 */
struct InjectStreamConfig {
  /** Width of the stream to be added into the broadcast. The default value is
  0; same width as the original stream.
  */
  int width;
  /** Height of the stream to be added into the broadcast. The default value is
  0; same height as the original stream.
  */
  int height;
  /** Video GOP of the stream to be added into the broadcast. The default value
  is 30.
  */
  int videoGop;
  /** Video frame rate of the stream to be added into the broadcast. The
  default value is 15 fps.
  */
  int videoFramerate;
  /** Video bitrate of the stream to be added into the broadcast. The default
  value is 400 Kbps.
  */
  int videoBitrate;
  /** Audio-sampling rate of the stream to be added into the broadcast:
  #AUDIO_SAMPLE_RATE_TYPE. The default value is 48000.
  */
  AUDIO_SAMPLE_RATE_TYPE audioSampleRate;
  /** Audio bitrate of the stream to be added into the broadcast. The default
  value is 48.
  */
  int audioBitrate;
  /** Audio channels to be added into the broadcast. The default value is 1.
  */
  int audioChannels;

  // width / height default set to 0 means pull the stream with its original
  // resolution
  InjectStreamConfig()
      : width(0),
        height(0),
        videoGop(30),
        videoFramerate(15),
        videoBitrate(400),
        audioSampleRate(AUDIO_SAMPLE_RATE_48000),
        audioBitrate(48),
        audioChannels(1) {}
};

/** The video stream lifecycle of CDN Live.
 */
enum RTMP_STREAM_LIFE_CYCLE_TYPE {
  /** Bound to the channel lifecycle.
  */
  RTMP_STREAM_LIFE_CYCLE_BIND2CHANNEL = 1,
  /** Bound to the owner identity of the RTMP stream.
  */
  RTMP_STREAM_LIFE_CYCLE_BIND2OWNER = 2,
};

/** The definition of PublisherConfiguration.
*/
struct PublisherConfiguration {
  /** Width of the output data stream set for CDN Live. The default value is
  360.
  */
  int width;
  /** Height of the output data stream set for CDN Live. The default value is
  640.
  */
  int height;
  /** Frame rate of the output data stream set for CDN Live. The default value
  is 15 fps.
  */
  int framerate;
  /** Bitrate of the output data stream set for CDN Live. The default value is
  500 Kbps.
  */
  int bitrate;
  /** The default layout:
  - 0: Tile horizontally
  - 1: Layered windows
  - 2: Tile vertically
  */
  int defaultLayout;
  /** The video stream lifecycle of CDN Live: RTMP_STREAM_LIFE_CYCLE_TYPE
  */
  int lifecycle;
  /** Whether the current user is the owner of the RTMP stream:
  - True: Yes (default). The push-stream configuration takes effect.
  - False: No. The push-stream configuration will not work.
  */
  bool owner;
  /** Width of the stream to be injected. Set it as 0.
  */
  int injectStreamWidth;
  /** Height of the stream to be injected. Set it as 0.
  */
  int injectStreamHeight;
  /** URL address of the stream to be injected to the channel.
  */
  const char* injectStreamUrl;
  /** Push-stream URL address for the picture-in-picture layouts. The default
  value is NULL.
  */
  const char* publishUrl;
  /** Push-stream URL address of the original stream which does not require
  picture-blending. The default value is NULL.
  */
  const char* rawStreamUrl;
  /** Reserved field. The default value is NULL.
  */
  const char* extraInfo;

  PublisherConfiguration()
      : width(640),
        height(360),
        framerate(15),
        bitrate(500),
        defaultLayout(1),
        lifecycle(RTMP_STREAM_LIFE_CYCLE_BIND2CHANNEL),
        owner(true),
        injectStreamWidth(0),
        injectStreamHeight(0),
        injectStreamUrl(NULL),
        publishUrl(NULL),
        rawStreamUrl(NULL),
        extraInfo(NULL) {}
};

/**
 * The camera direction.
 */
enum CAMERA_DIRECTION {
  /** The rear camera. */
  CAMERA_REAR = 0,
  /** The front camera. */
  CAMERA_FRONT = 1,
};

/** The cloud proxy type.
 *
 * @since v3.3.0
 */
enum CLOUD_PROXY_TYPE {
  /** 0: Do not use the cloud proxy.
   */
  NONE_PROXY = 0,
  /** 1: The cloud proxy for the UDP protocol.
   */
  UDP_PROXY = 1,
  /// @cond
  /** 2: The cloud proxy for the TCP (encrypted) protocol.
   */
  TCP_PROXY = 2,
  /// @endcond
};

/** Camera capturer configuration.*/
struct CameraCapturerConfiguration {
  /** Camera direction settings (for Android/iOS only). See: #CAMERA_DIRECTION. */
#if defined(__ANDROID__) || (defined(__APPLE__) && TARGET_OS_IOS)
  /**
   * The camera direction.
   */
  Optional<CAMERA_DIRECTION> cameraDirection;

  /*- CAMERA_FOCAL_LENGTH_TYPE.CAMERA_FOCAL_LENGTH_DEFAULT:
  For iOS, if iPhone/iPad has 3 or 2 back camera, it means combination of triple (wide + ultra wide + telephoto) camera
  or dual wide(wide + ultra wide) camera.In this situation, you can apply for ultra wide len by set smaller zoom fator
  and bigger zoom fator for telephoto len.Otherwise, it always means wide back/front camera.

  - CAMERA_FOCAL_LENGTH_TYPE.CAMERA_FOCAL_LENGTH_WIDE_ANGLE:wide camera
  - CAMERA_FOCAL_LENGTH_TYPE.CAMERA_FOCAL_LENGTH_ULTRA_WIDE:ultra wide camera
  - CAMERA_FOCAL_LENGTH_TYPE.CAMERA_FOCAL_LENGTH_TELEPHOTO:telephoto camera*/
  Optional<CAMERA_FOCAL_LENGTH_TYPE> cameraFocalLengthType;
#else
  /** For windows. The device ID of the playback device. */
  Optional<const char *> deviceId;
#endif

#if defined(__ANDROID__)
  /**
   * The camera id.
   */
  Optional<const char *> cameraId;
#endif
  Optional<bool> followEncodeDimensionRatio;
    /** The video format. See VideoFormat. */
  VideoFormat format;
  CameraCapturerConfiguration() : format(VideoFormat(0, 0, 0)) {}
};
/**
 * The configuration of the captured screen.
 */
struct ScreenCaptureConfiguration {
  /**
   * Whether to capture the window on the screen:
   * - `true`: Capture the window.
   * - `false`: (Default) Capture the screen, not the window.
   */
  bool isCaptureWindow; // true - capture window, false - capture display
  /**
   * (macOS only) The display ID of the screen.
   */
  uint32_t displayId;
  /**
   * (Windows only) The relative position of the shared screen to the virtual screen.
   * @note This parameter takes effect only when you want to capture the screen on Windows.
   */
  Rectangle screenRect; //Windows only
  /**
   * (For Windows and macOS only) The window ID.
   * @note This parameter takes effect only when you want to capture the window.
   */
  view_t windowId;
  /**
   * (For Windows and macOS only) The screen capture configuration. For details, see ScreenCaptureParameters.
   */
  ScreenCaptureParameters params;
  /**
   * (For Windows and macOS only) The relative position of the shared region to the whole screen. For details, see Rectangle.
   *
   * If you do not set this parameter, the SDK shares the whole screen. If the region you set exceeds the boundary of the
   * screen, only the region within in the screen is shared. If you set width or height in Rectangle as 0, the whole
   * screen is shared.
   */
  Rectangle regionRect;

  ScreenCaptureConfiguration() : isCaptureWindow(false), displayId(0), windowId(0) {}
};

#if (defined(__APPLE__) && TARGET_OS_MAC && !TARGET_OS_IPHONE)
/** The size of the screen shot to the screen or window.
 */
struct SIZE {
  /** The width of the screen shot.
   */
  int width;
  /** The width of the screen shot.
   */
  int height;

  SIZE() : width(0), height(0) {}
  SIZE(int ww, int hh) : width(ww), height(hh) {}
};
#endif

#if defined(_WIN32) || (defined(__APPLE__) && TARGET_OS_MAC && !TARGET_OS_IPHONE)
/**
 * The image content of the thumbnail or icon.
 * @note The default image is in the RGBA format. If you need to use another format, you need to convert the image on
 * your own.
 */
struct ThumbImageBuffer {
  /**
   * The buffer of the thumbnail ot icon.
   */
  const char* buffer;
  /**
   * The buffer length of the thumbnail or icon, in bytes.
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
 * The type of the shared target. Set in ScreenCaptureSourceInfo.
 */
enum ScreenCaptureSourceType {
  /** -1: Unknown type. */
  ScreenCaptureSourceType_Unknown = -1,
  /** 0: The shared target is a window.*/
  ScreenCaptureSourceType_Window = 0,
  /** 1: The shared target is a screen of a particular monitor.*/
  ScreenCaptureSourceType_Screen = 1,
  /** 2: Reserved parameter.*/
  ScreenCaptureSourceType_Custom = 2,
};
/** The information about the specified shareable window or screen. It is returned in IScreenCaptureSourceList. */
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
  bool isOccluded;
  /**
   * The relative position of the shared region to the screen space (A virtual space include all the screens). See Rectangle.
   */
  Rectangle position;
#if defined(_WIN32)
  /**
   * Determines whether the window is minimized.
   */
  bool minimizeWindow;
  /**
   * The display ID to the window of interest.
   * If the window intersects one or more display monitor rectangles, the return value is an valid
   * ID to the display monitor that has the largest area of intersection with the window, Otherwise
   * the return value is -2.
   */
  view_t sourceDisplayId;
  ScreenCaptureSourceInfo() : type(ScreenCaptureSourceType_Unknown), sourceId(nullptr), sourceName(nullptr),
                              processPath(nullptr), sourceTitle(nullptr), primaryMonitor(false), isOccluded(false), minimizeWindow(false), sourceDisplayId((view_t)-2) {}
#else
  ScreenCaptureSourceInfo() : type(ScreenCaptureSourceType_Unknown), sourceId(nullptr), sourceName(nullptr), processPath(nullptr), sourceTitle(nullptr), primaryMonitor(false), isOccluded(false) {}
#endif
};
/**
 * The IScreenCaptureSourceList class. This class is returned in the getScreenCaptureSources method.
 */
class IScreenCaptureSourceList {
 protected:
  virtual ~IScreenCaptureSourceList(){};

 public:
  /**
   * Gets the number of shareable cpp and screens.
   *
   * @return The number of shareable cpp and screens.
   */
  virtual unsigned int getCount() = 0;
  /**
   * Gets information about the specified shareable window or screen.
   *
   * After you get IScreenCaptureSourceList, you can pass in the index value of the specified shareable window or
   * screen to get information about that window or screen from ScreenCaptureSourceInfo.
   *
   * @param index The index of the specified shareable window or screen. The value range is [0, getCount()).
   * @return ScreenCaptureSourceInfo The information of the specified window or screen.
   */
  virtual ScreenCaptureSourceInfo getSourceInfo(unsigned int index) = 0;
  /**
   * Releases IScreenCaptureSourceList.
   *
   * After you get the list of shareable cpp and screens, to avoid memory leaks, call this method to release
   * IScreenCaptureSourceList instead of deleting IScreenCaptureSourceList directly.
   */
  virtual void release() = 0;
};
#endif // _WIN32 || (__APPLE__ && !TARGET_OS_IPHONE && TARGET_OS_MAC)
/**
 * The advanced options for audio.
 */
struct AdvancedAudioOptions {
  /**
   * Audio processing channels, only support 1 or 2.
   */
   Optional<int> audioProcessingChannels;

   AdvancedAudioOptions() {}
  ~AdvancedAudioOptions() {}
};

struct ImageTrackOptions {
  const char* imageUrl;
  int fps;
  VIDEO_MIRROR_MODE_TYPE mirrorMode;
  ImageTrackOptions() : imageUrl(NULL), fps(1), mirrorMode(VIDEO_MIRROR_MODE_DISABLED) {}
};

/**
 * The channel media options.
 *
 * Agora supports publishing multiple audio streams and one video stream at the same time and in the same RtcConnection.
 * For example, `publishAudioTrack`, `publishCustomAudioTrack` and `publishMediaPlayerAudioTrack` can be true at the same time;
 * but only one of `publishCameraTrack`, `publishScreenTrack`, `publishCustomVideoTrack`, and `publishEncodedVideoTrack` can be
 * true at the same time.
 */
struct ChannelMediaOptions {
  /**
   * Whether to publish the video of the camera track.
   * - `true`: (Default) Publish the video track of the camera capturer.
   * - `false`: Do not publish the video track of the camera capturer.
   */
  Optional<bool> publishCameraTrack;
  /**
   * Whether to publish the video of the secondary camera track.
   * - `true`: Publish the video track of the secondary camera capturer.
   * - `false`: (Default) Do not publish the video track of the secondary camera capturer.
   */
  Optional<bool> publishSecondaryCameraTrack;
    /**
   * Whether to publish the video of the third camera track.
   * - `true`:  Publish the video track of the third camera capturer.
   * - `false`: (Default) Do not publish the video track of the third camera capturer.
   */
  Optional<bool> publishThirdCameraTrack;
  /**
   * Whether to publish the video of the fourth camera track.
   * - `true`:  Publish the video track of the fourth camera capturer.
   * - `false`: (Default) Do not publish the video track of the fourth camera capturer.
   */
  Optional<bool> publishFourthCameraTrack;
  /**
   * Whether to publish the recorded audio.
   * - `true`: (Default) Publish the recorded audio.
   * - `false`: Do not publish the recorded audio.
   */
  Optional<bool> publishMicrophoneTrack;

  #if defined(__ANDROID__) || (defined(TARGET_OS_IPHONE) && TARGET_OS_IPHONE)
  /**
   * Whether to publish the video track of the screen capturer:
   * - `true`: Publish the video track of the screen capture.
   * - `false`: (Default) Do not publish the video track of the screen capture.
   */
  Optional<bool> publishScreenCaptureVideo;
  /**
   * Whether to publish the audio track of the screen capturer:
   * - `true`: Publish the video audio of the screen capturer.
   * - `false`: (Default) Do not publish the audio track of the screen capturer.
   */
  Optional<bool> publishScreenCaptureAudio;
  #else
  /**
   * Whether to publish the captured video from the screen:
   * - `true`: PPublish the captured video from the screen.
   * - `false`: (Default) Do not publish the captured video from the screen.
   */
  Optional<bool> publishScreenTrack;
  /**
   * Whether to publish the captured video from the secondary screen:
   * - true: Publish the captured video from the secondary screen.
   * - false: (Default) Do not publish the captured video from the secondary screen.
   */
  Optional<bool> publishSecondaryScreenTrack;
    /**
   * Whether to publish the captured video from the third screen:
   * - true: Publish the captured video from the third screen.
   * - false: (Default) Do not publish the captured video from the third screen.
   */
  Optional<bool> publishThirdScreenTrack;
  /**
   * Whether to publish the captured video from the fourth screen:
   * - true: Publish the captured video from the fourth screen.
   * - false: (Default) Do not publish the captured video from the fourth screen.
   */
  Optional<bool> publishFourthScreenTrack;
  #endif

  /**
   * Whether to publish the captured audio from a custom source:
   * - true: Publish the captured audio from a custom source.
   * - false: (Default) Do not publish the captured audio from the custom source.
   */
  Optional<bool> publishCustomAudioTrack;
  /**
   * The custom audio track id. The default value is 0.
   */
  Optional<int> publishCustomAudioTrackId;
  /**
   * Whether to publish the captured video from a custom source:
   * - `true`: Publish the captured video from a custom source.
   * - `false`: (Default) Do not publish the captured video from the custom source.
   */
  Optional<bool> publishCustomVideoTrack;
  /**
   * Whether to publish the encoded video:
   * - `true`: Publish the encoded video.
   * - `false`: (Default) Do not publish the encoded video.
   */
  Optional<bool> publishEncodedVideoTrack;
  /**
  * Whether to publish the audio from the media player:
  * - `true`: Publish the audio from the media player.
  * - `false`: (Default) Do not publish the audio from the media player.
  */
  Optional<bool> publishMediaPlayerAudioTrack;
  /**
  * Whether to publish the video from the media player:
  * - `true`: Publish the video from the media player.
  * - `false`: (Default) Do not publish the video from the media player.
  */
  Optional<bool> publishMediaPlayerVideoTrack;
  /**
  * Whether to publish the local transcoded video track.
  * - `true`: Publish the video track of local transcoded video track.
  * - `false`: (Default) Do not publish the local transcoded video track.
  */
  Optional<bool> publishTranscodedVideoTrack;
    /**
  * Whether to publish the local mixed track.
  * - `true`: Publish the audio track of local mixed track.
  * - `false`: (Default) Do not publish the local mixed track.
  */
  Optional<bool> publishMixedAudioTrack;
  /**
   * Whether to publish the local lip sync video track.
   * - `true`: Publish the video track of local lip sync  video track.
   * - `false`: (Default) Do not publish the local lip sync  video track.
   */
  Optional<bool> publishLipSyncTrack;
  /**
   * Whether to automatically subscribe to all remote audio streams when the user joins a channel:
   * - `true`: (Default) Subscribe to all remote audio streams.
   * - `false`: Do not subscribe to any remote audio stream.
   */
  Optional<bool> autoSubscribeAudio;
  /**
   * Whether to subscribe to all remote video streams when the user joins the channel:
   * - `true`: (Default) Subscribe to all remote video streams.
   * - `false`: Do not subscribe to any remote video stream.
   */
  Optional<bool> autoSubscribeVideo;
  /**
   * Whether to enable audio capturing or playback.
   * - `true`: (Default) Enable audio capturing and playback.
   * - `false`: Do not enable audio capturing or playback.
   */
  Optional<bool> enableAudioRecordingOrPlayout;
  /**
  * The ID of the media player to be published. The default value is 0.
  */
  Optional<int> publishMediaPlayerId;
  /**
   * The client role type. See \ref CLIENT_ROLE_TYPE.
   * Default is CLIENT_ROLE_AUDIENCE.
   */
  Optional<CLIENT_ROLE_TYPE> clientRoleType;
  /**
   * The audience latency level type. See #AUDIENCE_LATENCY_LEVEL_TYPE.
   */
  Optional<AUDIENCE_LATENCY_LEVEL_TYPE> audienceLatencyLevel;
  /**
   * The default video stream type. See \ref VIDEO_STREAM_TYPE.
   * Default is VIDEO_STREAM_HIGH.
   */
  Optional<VIDEO_STREAM_TYPE> defaultVideoStreamType;
  /**
   * The channel profile. See \ref CHANNEL_PROFILE_TYPE.
   * Default is CHANNEL_PROFILE_LIVE_BROADCASTING.
   */
  Optional<CHANNEL_PROFILE_TYPE> channelProfile;
  /**
   * The delay in ms for sending audio frames. This is used for explicit control of A/V sync.
   * To switch off the delay, set the value to zero.
   */
  Optional<int> audioDelayMs;
  /**
   * The delay in ms for sending media player audio frames. This is used for explicit control of A/V sync.
   * To switch off the delay, set the value to zero.
   */
  Optional<int> mediaPlayerAudioDelayMs;
  /**
   * (Optional) The token generated on your server for authentication.
   * @note
   * - This parameter takes effect only when calling `updateChannelMediaOptions` or `updateChannelMediaOptionsEx`.
   * - Ensure that the App ID, channel name, and user name used for creating the token are the same ones as those
   * used by the initialize method for initializing the RTC engine, and those used by the `joinChannel [2/2]`
   * and `joinChannelEx` methods for joining the channel.
   */
  Optional<const char*> token;
  /**
   * Whether to enable media packet encryption:
   * - `true`: Yes.
   * - `false`: (Default) No.
   *
   * @note This parameter is ignored when calling `updateChannelMediaOptions`.
   */
  Optional<bool> enableBuiltInMediaEncryption;
  /**
   * Whether to publish the sound of the rhythm player to remote users:
   * - `true`: (Default) Publish the sound of the rhythm player.
   * - `false`: Do not publish the sound of the rhythm player.
   */
  Optional<bool> publishRhythmPlayerTrack;
  /**
   * Whether the user is an interactive audience member in the channel.
   * - `true`: Enable low lentancy and smooth video when joining as an audience.
   * - `false`: (Default) Use default settings for audience role.
   * @note This mode is only used for audience. In PK mode, client might join one channel as broadcaster, and join
   * another channel as interactive audience to achieve low lentancy and smooth video from remote user.
   */
  Optional<bool> isInteractiveAudience;
  /**
   * The custom video track id which will used to publish or preview.
   * You can get the VideoTrackId after calling createCustomVideoTrack() of IRtcEngine.
   */
  Optional<video_track_id_t> customVideoTrackId;
  /**
   * Whether local audio stream can be filtered.
   * - `true`: (Default) Can be filtered when audio level is low.
   * - `false`: Do not Filter this audio stream.
   */
  Optional<bool> isAudioFilterable;

  /** Provides the technical preview functionalities or special customizations by configuring the SDK with JSON options.
      Pointer to the set parameters in a JSON string.
    * @technical preview 
   */
  Optional<const char*> parameters;

  ChannelMediaOptions() {}
  ~ChannelMediaOptions() {}

  void SetAll(const ChannelMediaOptions& change) {
#define SET_FROM(X) SetFrom(&X, change.X)

      SET_FROM(publishCameraTrack);
      SET_FROM(publishSecondaryCameraTrack);
      SET_FROM(publishThirdCameraTrack);
      SET_FROM(publishFourthCameraTrack);      
      SET_FROM(publishMicrophoneTrack);
#if defined(__ANDROID__) || (defined(TARGET_OS_IPHONE) && TARGET_OS_IPHONE)
      SET_FROM(publishScreenCaptureVideo);
      SET_FROM(publishScreenCaptureAudio);
#else
      SET_FROM(publishScreenTrack);
      SET_FROM(publishSecondaryScreenTrack);
      SET_FROM(publishThirdScreenTrack);
      SET_FROM(publishFourthScreenTrack);
#endif
      SET_FROM(publishTranscodedVideoTrack);
      SET_FROM(publishMixedAudioTrack);
      SET_FROM(publishLipSyncTrack);
      SET_FROM(publishCustomAudioTrack);
      SET_FROM(publishCustomAudioTrackId);
      SET_FROM(publishCustomVideoTrack);
      SET_FROM(publishEncodedVideoTrack);
      SET_FROM(publishMediaPlayerAudioTrack);
      SET_FROM(publishMediaPlayerVideoTrack);
      SET_FROM(autoSubscribeAudio);
      SET_FROM(autoSubscribeVideo);
      SET_FROM(publishMediaPlayerId);
      SET_FROM(enableAudioRecordingOrPlayout);
      SET_FROM(clientRoleType);
      SET_FROM(audienceLatencyLevel);
      SET_FROM(defaultVideoStreamType);
      SET_FROM(channelProfile);
      SET_FROM(audioDelayMs);
      SET_FROM(mediaPlayerAudioDelayMs);
      SET_FROM(token);
      SET_FROM(enableBuiltInMediaEncryption);
      SET_FROM(publishRhythmPlayerTrack);
      SET_FROM(customVideoTrackId);
      SET_FROM(isAudioFilterable);
      SET_FROM(isInteractiveAudience);
      SET_FROM(parameters);
#undef SET_FROM
  }

  bool operator==(const ChannelMediaOptions& o) const {
#define BEGIN_COMPARE() bool b = true
#define ADD_COMPARE(X) b = (b && (X == o.X))
#define END_COMPARE()

      BEGIN_COMPARE();
      ADD_COMPARE(publishCameraTrack);
      ADD_COMPARE(publishSecondaryCameraTrack);
      ADD_COMPARE(publishThirdCameraTrack);
      ADD_COMPARE(publishFourthCameraTrack);
      ADD_COMPARE(publishMicrophoneTrack);
#if defined(__ANDROID__) || (defined(TARGET_OS_IPHONE) && TARGET_OS_IPHONE)
      ADD_COMPARE(publishScreenCaptureVideo);
      ADD_COMPARE(publishScreenCaptureAudio);
#else
      ADD_COMPARE(publishScreenTrack);
      ADD_COMPARE(publishSecondaryScreenTrack);
      ADD_COMPARE(publishThirdScreenTrack);
      ADD_COMPARE(publishFourthScreenTrack);
#endif
      ADD_COMPARE(publishTranscodedVideoTrack);
      ADD_COMPARE(publishMixedAudioTrack);
      ADD_COMPARE(publishLipSyncTrack);
      ADD_COMPARE(publishCustomAudioTrack);
      ADD_COMPARE(publishCustomAudioTrackId);
      ADD_COMPARE(publishCustomVideoTrack);
      ADD_COMPARE(publishEncodedVideoTrack);
      ADD_COMPARE(publishMediaPlayerAudioTrack);
      ADD_COMPARE(publishMediaPlayerVideoTrack);
      ADD_COMPARE(autoSubscribeAudio);
      ADD_COMPARE(autoSubscribeVideo);
      ADD_COMPARE(publishMediaPlayerId);
      ADD_COMPARE(enableAudioRecordingOrPlayout);
      ADD_COMPARE(clientRoleType);
      ADD_COMPARE(audienceLatencyLevel);
      ADD_COMPARE(defaultVideoStreamType);
      ADD_COMPARE(channelProfile);
      ADD_COMPARE(audioDelayMs);
      ADD_COMPARE(mediaPlayerAudioDelayMs);
      ADD_COMPARE(token);
      ADD_COMPARE(enableBuiltInMediaEncryption);
      ADD_COMPARE(publishRhythmPlayerTrack);
      ADD_COMPARE(customVideoTrackId);
      ADD_COMPARE(isAudioFilterable);
      ADD_COMPARE(isInteractiveAudience);
      ADD_COMPARE(parameters);
      END_COMPARE();

#undef BEGIN_COMPARE
#undef ADD_COMPARE
#undef END_COMPARE
      return b;
  }

  ChannelMediaOptions& operator=(const ChannelMediaOptions& replace) {
    if (this != &replace) {
#define REPLACE_BY(X) ReplaceBy(&X, replace.X)

        REPLACE_BY(publishCameraTrack);
        REPLACE_BY(publishSecondaryCameraTrack);
        REPLACE_BY(publishThirdCameraTrack);
        REPLACE_BY(publishFourthCameraTrack);
        REPLACE_BY(publishMicrophoneTrack);
#if defined(__ANDROID__) || (defined(TARGET_OS_IPHONE) && TARGET_OS_IPHONE)
        REPLACE_BY(publishScreenCaptureVideo);
        REPLACE_BY(publishScreenCaptureAudio);
#else
        REPLACE_BY(publishScreenTrack);
        REPLACE_BY(publishSecondaryScreenTrack);
        REPLACE_BY(publishThirdScreenTrack);
        REPLACE_BY(publishFourthScreenTrack);
#endif
        REPLACE_BY(publishTranscodedVideoTrack);
        REPLACE_BY(publishMixedAudioTrack);
        REPLACE_BY(publishLipSyncTrack);
        REPLACE_BY(publishCustomAudioTrack);
        REPLACE_BY(publishCustomAudioTrackId);
        REPLACE_BY(publishCustomVideoTrack);
        REPLACE_BY(publishEncodedVideoTrack);
        REPLACE_BY(publishMediaPlayerAudioTrack);
        REPLACE_BY(publishMediaPlayerVideoTrack);
        REPLACE_BY(autoSubscribeAudio);
        REPLACE_BY(autoSubscribeVideo);
        REPLACE_BY(publishMediaPlayerId);
        REPLACE_BY(enableAudioRecordingOrPlayout);
        REPLACE_BY(clientRoleType);
        REPLACE_BY(audienceLatencyLevel);
        REPLACE_BY(defaultVideoStreamType);
        REPLACE_BY(channelProfile);
        REPLACE_BY(audioDelayMs);
        REPLACE_BY(mediaPlayerAudioDelayMs);
        REPLACE_BY(token);
        REPLACE_BY(enableBuiltInMediaEncryption);
        REPLACE_BY(publishRhythmPlayerTrack);
        REPLACE_BY(customVideoTrackId);
        REPLACE_BY(isAudioFilterable);
        REPLACE_BY(isInteractiveAudience);
        REPLACE_BY(parameters);
#undef REPLACE_BY
    }
    return *this;
  }
};

enum PROXY_TYPE {
  /** 0: Do not use the cloud proxy.
   */
  NONE_PROXY_TYPE = 0,
  /** 1: The cloud proxy for the UDP protocol.
   */
  UDP_PROXY_TYPE = 1,
  /** 2: The cloud proxy for the TCP (encrypted) protocol.
   */
  TCP_PROXY_TYPE = 2,
  /** 3: The local proxy.
   */
  LOCAL_PROXY_TYPE = 3,
  /** 4: auto fallback to tcp cloud proxy
   */
  TCP_PROXY_AUTO_FALLBACK_TYPE = 4,
  /** 5: The http proxy.
   */
  HTTP_PROXY_TYPE = 5,
  /** 6: The https proxy.
   */
  HTTPS_PROXY_TYPE = 6,
};

enum FeatureType {
  VIDEO_VIRTUAL_BACKGROUND = 1,
  VIDEO_BEAUTY_EFFECT = 2,
};

/**
 * The options for leaving a channel.
 */
struct LeaveChannelOptions {
  /**
   * Whether to stop playing and mixing the music file when a user leaves the channel.
   * - `true`: (Default) Stop playing and mixing the music file.
   * - `false`: Do not stop playing and mixing the music file.
   */
  bool stopAudioMixing;
  /**
   * Whether to stop playing all audio effects when a user leaves the channel.
   * - `true`: (Default) Stop playing all audio effects.
   * - `false`: Do not stop playing any audio effect.
   */
  bool stopAllEffect;
  /**
   * Whether to stop microphone recording when a user leaves the channel.
   * - `true`: (Default) Stop microphone recording.
   * - `false`: Do not stop microphone recording.
   */
  bool stopMicrophoneRecording;

  LeaveChannelOptions() : stopAudioMixing(true), stopAllEffect(true), stopMicrophoneRecording(true) {}
};

/**
 * The IRtcEngineEventHandler class.
 *
 * The SDK uses this class to send callback event notifications to the app, and the app inherits
 * the methods in this class to retrieve these event notifications.
 *
 * All methods in this class have their default (empty)  implementations, and the app can inherit
 * only some of the required events instead of all. In the callback methods, the app should avoid
 * time-consuming tasks or calling blocking APIs, otherwise the SDK may not work properly.
 */
class IRtcEngineEventHandler {
 public:
  virtual ~IRtcEngineEventHandler() {}

  virtual const char* eventHandlerType() const { return "event_handler"; }

  /**
   * Occurs when a user joins a channel.
   *
   * This callback notifies the application that a user joins a specified channel.
   *
   * @param channel The channel name.
   * @param uid The ID of the user who joins the channel.
   * @param elapsed The time elapsed (ms) from the local user calling joinChannel until the SDK triggers this callback.
   */
  virtual void onJoinChannelSuccess(const char* channel, uid_t uid, int elapsed) {
    (void)channel;
    (void)uid;
    (void)elapsed;
  }

  /**
   * Occurs when a user rejoins the channel.
   *
   * When a user loses connection with the server because of network problems, the SDK automatically tries to reconnect
   * and triggers this callback upon reconnection.
   *
   * @param channel The channel name.
   * @param uid The ID of the user who rejoins the channel.
   * @param elapsed Time elapsed (ms) from the local user calling the joinChannel method until this callback is triggered.
   */
  virtual void onRejoinChannelSuccess(const char* channel, uid_t uid, int elapsed) {
    (void)channel;
    (void)uid;
    (void)elapsed;
  }

  /** Occurs when join success after calling \ref IRtcEngine::setLocalAccessPoint "setLocalAccessPoint" or \ref IRtcEngine::setCloudProxy "setCloudProxy"
  @param channel Channel name.
  @param uid  User ID of the user joining the channel.
  @param proxyType type of proxy agora sdk connected, proxyType will be NONE_PROXY_TYPE if not connected to proxy(fallback).
  @param localProxyIp local proxy ip. if not join local proxy, it will be "".
  @param elapsed Time elapsed (ms) from the user calling the \ref IRtcEngine::joinChannel "joinChannel" method until the SDK triggers this callback.
   */
  virtual void onProxyConnected(const char* channel, uid_t uid, PROXY_TYPE proxyType, const char* localProxyIp, int elapsed) {
    (void)channel;
    (void)uid;
    (void)proxyType;
    (void)localProxyIp;
    (void)elapsed;
  }

  /** An error occurs during the SDK runtime.

  @param err The error code: #ERROR_CODE_TYPE.
  @param msg The detailed error message.
  */
  virtual void onError(int err, const char* msg) {
    (void)err;
    (void)msg;
  }

  /** Reports the statistics of the audio stream from each remote
  user/broadcaster.

  @deprecated This callback is deprecated. Use onRemoteAudioStats instead.

  The SDK triggers this callback once every two seconds to report the audio
  quality of each remote user/host sending an audio stream. If a channel has
  multiple remote users/hosts sending audio streams, the SDK triggers this
  callback as many times.

  @param uid The user ID of the remote user sending the audio stream.
  @param quality The audio quality of the user: #QUALITY_TYPE
  @param delay The network delay (ms) from the sender to the receiver, including the delay caused by audio sampling pre-processing, network transmission, and network jitter buffering.
  @param lost The audio packet loss rate (%) from the sender to the receiver.
  */
  virtual void onAudioQuality(uid_t uid, int quality, unsigned short delay, unsigned short lost) __deprecated {
    (void)uid;
    (void)quality;
    (void)delay;
    (void)lost;
  }

  /** Reports the result of the last-mile network probe result.
   *
   * The SDK triggers this callback within 30 seconds after the app calls the `startLastmileProbeTest` method.
   * @param result The uplink and downlink last-mile network probe test result: LastmileProbeResult.
   */
  virtual void onLastmileProbeResult(const LastmileProbeResult& result) {
      (void)result;
  }

  /**
   * Reports the volume information of users.
   *
   * By default, this callback is disabled. You can enable it by calling `enableAudioVolumeIndication`. Once this
   * callback is enabled and users send streams in the channel, the SDK triggers the `onAudioVolumeIndication`
   * callback at the time interval set in `enableAudioVolumeIndication`. The SDK triggers two independent
   * `onAudioVolumeIndication` callbacks simultaneously, which separately report the volume information of the
   * local user who sends a stream and the remote users (up to three) whose instantaneous volume is the highest.
   *
   * @note After you enable this callback, calling muteLocalAudioStream affects the SDK's behavior as follows:
   * - If the local user stops publishing the audio stream, the SDK stops triggering the local user's callback.
   * - 20 seconds after a remote user whose volume is one of the three highest stops publishing the audio stream,
   * the callback excludes this user's information; 20 seconds after all remote users stop publishing audio streams,
   * the SDK stops triggering the callback for remote users.
   *
   * @param speakers The volume information of the users, see AudioVolumeInfo. An empty `speakers` array in the
   * callback indicates that no remote user is in the channel or sending a stream at the moment.
   * @param speakerNumber The total number of speakers.
   * - In the local user's callback, when the local user sends a stream, `speakerNumber` is 1.
   * - In the callback for remote users, the value range of speakerNumber is [0,3]. If the number of remote users who
   * send streams is greater than or equal to three, the value of `speakerNumber` is 3.
   * @param totalVolume The volume of the speaker. The value ranges between 0 (lowest volume) and 255 (highest volume).
   * - In the local user's callback, `totalVolume` is the volume of the local user who sends a stream.
   * - In the remote users' callback, `totalVolume` is the sum of all remote users (up to three) whose instantaneous
   * volume is the highest. If the user calls `startAudioMixing`, `totalVolume` is the volume after audio mixing.
   */
  virtual void onAudioVolumeIndication(const AudioVolumeInfo* speakers, unsigned int speakerNumber,
                                       int totalVolume) {
    (void)speakers;
    (void)speakerNumber;
    (void)totalVolume;
  }

  /**
   * Occurs when a user leaves a channel.
   *
   * This callback notifies the app that the user leaves the channel by calling `leaveChannel`. From this callback,
   * the app can get information such as the call duration and quality statistics.
   *
   * @param stats The statistics on the call: RtcStats.
   */
  virtual void onLeaveChannel(const RtcStats& stats) { (void)stats; }

  /**
   * Reports the statistics of the current call.
   *
   * The SDK triggers this callback once every two seconds after the user joins the channel.
   *
   * @param stats The statistics of the current call: RtcStats.
   */
  virtual void onRtcStats(const RtcStats& stats) { (void)stats; }

  /** Occurs when the audio device state changes.

   This callback notifies the application that the system's audio device state
   is changed. For example, a headset is unplugged from the device.

   @param deviceId The device ID.
   @param deviceType The device type: #MEDIA_DEVICE_TYPE.
   @param deviceState The device state:
   - On macOS:
     - 0: The device is ready for use.
     - 8: The device is not connected.
   - On Windows: #MEDIA_DEVICE_STATE_TYPE.
   */
  virtual void onAudioDeviceStateChanged(const char* deviceId, int deviceType, int deviceState) {
    (void)deviceId;
    (void)deviceType;
    (void)deviceState;
  }

  /**
   * @brief Reports current AudioMixing progress.
   *
   * The callback occurs once every one second during the playback and reports the current playback progress.
   * @param position Current AudioMixing progress (millisecond).
   */
  virtual void onAudioMixingPositionChanged(int64_t position) {}

  /** Occurs when the audio mixing file playback finishes.
   @deprecated This method is deprecated, use onAudioMixingStateChanged instead.

   After you call startAudioMixing to play a local music file, this callback occurs when the playback finishes.
   If the startAudioMixing method call fails, the SDK returns the error code 701.
   */
  virtual void onAudioMixingFinished() __deprecated {}

  /**
   * Occurs when the playback of the local audio effect file finishes.
   *
   * This callback occurs when the local audio effect file finishes playing.
   *
   * @param soundId The audio effect ID. The ID of each audio effect file is unique.
   */
  virtual void onAudioEffectFinished(int soundId) {}

  /** Occurs when the video device state changes.

   This callback notifies the application that the system's video device state
   is changed.

   @param deviceId Pointer to the device ID.
   @param deviceType Device type: #MEDIA_DEVICE_TYPE.
   @param deviceState Device state: #MEDIA_DEVICE_STATE_TYPE.
   */
  virtual void onVideoDeviceStateChanged(const char* deviceId, int deviceType, int deviceState) {
    (void)deviceId;
    (void)deviceType;
    (void)deviceState;
  }

  /**
   * Reports the last mile network quality of each user in the channel.
   *
   * This callback reports the last mile network conditions of each user in the channel. Last mile refers to the
   * connection between the local device and Agora's edge server.
   *
   * The SDK triggers this callback once every two seconds. If a channel includes multiple users, the SDK triggers
   * this callback as many times.
   *
   * @note `txQuality` is UNKNOWN when the user is not sending a stream; `rxQuality` is UNKNOWN when the user is not
   * receiving a stream.
   *
   * @param uid The user ID. The network quality of the user with this user ID is reported.
   * @param txQuality Uplink network quality rating of the user in terms of the transmission bit rate, packet loss rate,
   * average RTT (Round-Trip Time) and jitter of the uplink network. This parameter is a quality rating helping you
   * understand how well the current uplink network conditions can support the selected video encoder configuration.
   * For example, a 1000 Kbps uplink network may be adequate for video frames with a resolution of 640 × 480 and a frame
   * rate of 15 fps in the LIVE_BROADCASTING profile, but may be inadequate for resolutions higher than 1280 × 720.
   * See #QUALITY_TYPE.
   * @param rxQuality Downlink network quality rating of the user in terms of packet loss rate, average RTT, and jitter
   * of the downlink network. See #QUALITY_TYPE.
   */
  virtual void onNetworkQuality(uid_t uid, int txQuality, int rxQuality) {
    (void)uid;
    (void)txQuality;
    (void)rxQuality;
  }

  /**
   * Occurs when intra request from remote user is received.
   *
   * This callback is triggered once remote user needs one Key frame.
   *
   */
  virtual void onIntraRequestReceived() {}

  /**
   * Occurs when uplink network info is updated.
   *
   * The SDK triggers this callback when the uplink network information changes.
   *
   * @note This callback only applies to scenarios where you push externally encoded
   * video data in H.264 format to the SDK.
   *
   * @param info The uplink network information. See UplinkNetworkInfo.
   */
  virtual void onUplinkNetworkInfoUpdated(const UplinkNetworkInfo& info) {
    (void)info;
  }

  /**
   * Occurs when downlink network info is updated.
   *
   * This callback is used for notifying user to switch major/minor stream if needed.
   *
   * @param info The downlink network info collections.
   */
  virtual void onDownlinkNetworkInfoUpdated(const DownlinkNetworkInfo& info) {
    (void)info;
  }

  /**
   * Reports the last-mile network quality of the local user.
   *
   * This callback reports the last-mile network conditions of the local user before the user joins
   * the channel. Last mile refers to the connection between the local device and Agora's edge server.
   *
   * When the user is not in a channel and the last-mile network test is enabled
   * (by calling `startLastmileProbeTest`), this callback function is triggered
   * to update the app on the network connection quality of the local user.
   *
   * @param quality The last mile network quality. See #QUALITY_TYPE.
   */
  virtual void onLastmileQuality(int quality) { (void)quality; }

  /** Occurs when the first local video frame is rendered on the local video view.
   *
   * @param source The video source: #VIDEO_SOURCE_TYPE.
   * @param width The width (px) of the first local video frame.
   * @param height The height (px) of the first local video frame.
   * @param elapsed Time elapsed (ms) from the local user calling the `joinChannel`
   * method until the SDK triggers this callback. If you call the `startPreview` method before calling
   * the `joinChannel` method, then `elapsed` is the time elapsed from calling the
   * `startPreview` method until the SDK triggers this callback.
   */
  virtual void onFirstLocalVideoFrame(VIDEO_SOURCE_TYPE source, int width, int height, int elapsed) {
    (void)source;
    (void)width;
    (void)height;
    (void)elapsed;
  }

  /** Occurs when the first local video frame is published.
   * The SDK triggers this callback under one of the following circumstances:
   * - The local client enables the video module and calls `joinChannel` successfully.
   * - The local client calls `muteLocalVideoStream(true)` and muteLocalVideoStream(false) in sequence.
   * - The local client calls `disableVideo` and `enableVideo` in sequence.
   * - The local client calls `pushVideoFrame` to successfully push the video frame to the SDK.
   * @param source The video source type.
   * @param elapsed The time elapsed (ms) from the local user calling joinChannel` to the SDK triggers
   * this callback.
  */
  virtual void onFirstLocalVideoFramePublished(VIDEO_SOURCE_TYPE source, int elapsed) {
    (void)source;
    (void)elapsed;
  }

  /** Occurs when the first remote video frame is received and decoded.

  The SDK triggers this callback under one of the following circumstances:
  - The remote user joins the channel and sends the video stream.
  - The remote user stops sending the video stream and re-sends it after 15 seconds. Reasons for such an interruption include:
   - The remote user leaves the channel.
   - The remote user drops offline.
   - The remote user calls `muteLocalVideoStream` to stop sending the video stream.
   - The remote user calls `disableVideo` to disable video.

  @param uid The user ID of the remote user sending the video stream.
  @param width The width (pixels) of the video stream.
  @param height The height (pixels) of the video stream.
  @param elapsed The time elapsed (ms) from the local user calling `joinChannel`
  until the SDK triggers this callback.
  */
  virtual void onFirstRemoteVideoDecoded(uid_t uid, int width, int height, int elapsed) __deprecated {
    (void)uid;
    (void)width;
    (void)height;
    (void)elapsed;
  }

  /**
   * Occurs when the local or remote video size or rotation has changed.
   * @param sourceType The video source type: #VIDEO_SOURCE_TYPE.
   * @param uid The user ID. 0 indicates the local user.
   * @param width The new width (pixels) of the video.
   * @param height The new height (pixels) of the video.
   * @param rotation The rotation information of the video.
   */
  virtual void onVideoSizeChanged(VIDEO_SOURCE_TYPE sourceType, uid_t uid, int width, int height, int rotation) {
    (void)uid;
    (void)width;
    (void)height;
    (void)rotation;
  }  

  /** Occurs when the local video stream state changes.
   *
   * When the state of the local video stream changes (including the state of the video capture and
   * encoding), the SDK triggers this callback to report the current state. This callback indicates
   * the state of the local video stream, including camera capturing and video encoding, and allows
   * you to troubleshoot issues when exceptions occur.
   *
   * The SDK triggers the onLocalVideoStateChanged callback with the state code of `LOCAL_VIDEO_STREAM_STATE_FAILED`
   * and error code of `LOCAL_VIDEO_STREAM_REASON_CAPTURE_FAILURE` in the following situations:
   * - The app switches to the background, and the system gets the camera resource.
   * - The camera starts normally, but does not output video for four consecutive seconds.
   *
   * When the camera outputs the captured video frames, if the video frames are the same for 15
   * consecutive frames, the SDK triggers the `onLocalVideoStateChanged` callback with the state code
   * of `LOCAL_VIDEO_STREAM_STATE_CAPTURING` and error code of `LOCAL_VIDEO_STREAM_REASON_CAPTURE_FAILURE`.
   * Note that the video frame duplication detection is only available for video frames with a resolution
   * greater than 200 × 200, a frame rate greater than or equal to 10 fps, and a bitrate less than 20 Kbps.
   *
   * @note For some device models, the SDK does not trigger this callback when the state of the local
   * video changes while the local video capturing device is in use, so you have to make your own
   * timeout judgment.
   *
   * @param source The video source type: #VIDEO_SOURCE_TYPE.
   * @param state The state of the local video. See #LOCAL_VIDEO_STREAM_STATE.
   * @param reason The detailed error information. See #LOCAL_VIDEO_STREAM_REASON.
   */
  virtual void onLocalVideoStateChanged(VIDEO_SOURCE_TYPE source, LOCAL_VIDEO_STREAM_STATE state, LOCAL_VIDEO_STREAM_REASON reason) {
    (void)source;
    (void)state;
    (void)reason;
  }

  /**
   * Occurs when the remote video state changes.
   *
   * @note This callback does not work properly when the number of users (in the voice/video call
   * channel) or hosts (in the live streaming channel) in the channel exceeds 17.
   *
   * @param uid The ID of the user whose video state has changed.
   * @param state The remote video state: #REMOTE_VIDEO_STATE.
   * @param reason The reason of the remote video state change: #REMOTE_VIDEO_STATE_REASON.
   * @param elapsed The time elapsed (ms) from the local client calling `joinChannel` until this callback is triggered.
   */
  virtual void onRemoteVideoStateChanged(uid_t uid, REMOTE_VIDEO_STATE state, REMOTE_VIDEO_STATE_REASON reason, int elapsed) {
    (void)uid;
    (void)state;
    (void)reason;
    (void)elapsed;
  }

  /** Occurs when the renderer receives the first frame of the remote video.
   *
   * @param uid The user ID of the remote user sending the video stream.
   * @param width The width (px) of the video frame.
   * @param height The height (px) of the video stream.
   * @param elapsed The time elapsed (ms) from the local user calling `joinChannel` until the SDK triggers this callback.
   */
  virtual void onFirstRemoteVideoFrame(uid_t uid, int width, int height, int elapsed) {
    (void)uid;
    (void)width;
    (void)height;
    (void)elapsed;
  }

  /**
   * Occurs when a remote user or broadcaster joins the channel.
   *
   * - In the COMMUNICATION channel profile, this callback indicates that a remote user joins the channel.
   * The SDK also triggers this callback to report the existing users in the channel when a user joins the
   * channel.
   * In the LIVE_BROADCASTING channel profile, this callback indicates that a host joins the channel. The
   * SDK also triggers this callback to report the existing hosts in the channel when a host joins the
   * channel. Agora recommends limiting the number of hosts to 17.
   *
   * The SDK triggers this callback under one of the following circumstances:
   * - A remote user/host joins the channel by calling the `joinChannel` method.
   * - A remote user switches the user role to the host after joining the channel.
   * - A remote user/host rejoins the channel after a network interruption.
   *
   * @param uid The ID of the remote user or broadcaster joining the channel.
   * @param elapsed The time elapsed (ms) from the local user calling `joinChannel` or `setClientRole`
   * until this callback is triggered.
  */
  virtual void onUserJoined(uid_t uid, int elapsed) {
    (void)uid;
    (void)elapsed;
  }

  /**
   * Occurs when a remote user or broadcaster goes offline.
   *
   * There are two reasons for a user to go offline:
   * - Leave the channel: When the user leaves the channel, the user sends a goodbye message. When this
   * message is received, the SDK determines that the user leaves the channel.
   * - Drop offline: When no data packet of the user is received for a certain period of time, the SDK assumes
   * that the user drops offline. A poor network connection may lead to false detection, so we recommend using
   * the RTM SDK for reliable offline detection.
   * - The user switches the user role from a broadcaster to an audience.
   *
   * @param uid The ID of the remote user or broadcaster who leaves the channel or drops offline.
   * @param reason The reason why the remote user goes offline: #USER_OFFLINE_REASON_TYPE.
   */
  virtual void onUserOffline(uid_t uid, USER_OFFLINE_REASON_TYPE reason) {
    (void)uid;
    (void)reason;
  }

  /** Occurs when a remote user's audio stream playback pauses/resumes.

     The SDK triggers this callback when the remote user stops or resumes sending the audio stream by
     calling the `muteLocalAudioStream` method.

     @note This callback can be inaccurate when the number of users (in the `COMMUNICATION` profile) or hosts (in the `LIVE_BROADCASTING` profile) in the channel exceeds 17.

     @param uid The user ID.
     @param muted Whether the remote user's audio stream is muted/unmuted:
     - true: Muted.
     - false: Unmuted.
     */
  virtual void onUserMuteAudio(uid_t uid, bool muted) {
    (void)uid;
    (void)muted;
  }

  /** Occurs when a remote user pauses or resumes sending the video stream.
   *
   * When a remote user calls `muteLocalVideoStream` to stop or resume publishing the video stream, the
   * SDK triggers this callback to report the state of the remote user's publishing stream to the local
   * user.

   @note This callback is invalid when the number of users or broadacasters in a
   channel exceeds 20.

   @param userId ID of the remote user.
   @param muted Whether the remote user stops publishing the video stream:
   - true: The remote user has paused sending the video stream.
   - false: The remote user has resumed sending the video stream.
   */
  virtual void onUserMuteVideo(uid_t uid, bool muted) {
    (void)uid;
    (void)muted;
  }

  /** Occurs when a remote user enables or disables the video module.

  Once the video function is disabled, the users cannot see any video.

  The SDK triggers this callback when a remote user enables or disables the video module by calling the
  `enableVideo` or `disableVideo` method.

  @param uid The ID of the remote user.
  @param enabled Whether the video of the remote user is enabled:
  - true: The remote user has enabled video.
  - false: The remote user has disabled video.
  */
  virtual void onUserEnableVideo(uid_t uid, bool enabled) {
    (void)uid;
    (void)enabled;
  }

  /**
   * Occurs when the remote user audio or video state is updated.
   * @param uid The uid of the remote user.
   * @param state The remote user's audio or video state: #REMOTE_USER_STATE.
   */
  virtual void onUserStateChanged(uid_t uid, REMOTE_USER_STATE state) {
    (void)uid;
    (void)state;
  }

  /** Occurs when a remote user enables or disables local video capturing.

  The SDK triggers this callback when the remote user resumes or stops capturing the video stream by
  calling the `enableLocalVideo` method.

  @param uid The ID of the remote user.
  @param enabled Whether the specified remote user enables/disables local video:
  - `true`: The remote user has enabled local video capturing.
  - `false`: The remote user has disabled local video capturing.
  */
  virtual void onUserEnableLocalVideo(uid_t uid, bool enabled) __deprecated {
    (void)uid;
    (void)enabled;
  }

  /** Reports the statistics of the audio stream from each remote user/host.

   The SDK triggers this callback once every two seconds for each remote user who is sending audio
   streams. If a channel includes multiple remote users, the SDK triggers this callback as many times.

   @param stats Statistics of the received remote audio streams. See RemoteAudioStats.
   */
  virtual void onRemoteAudioStats(const RemoteAudioStats& stats) {
    (void)stats;
  }

  /** Reports the statistics of the local audio stream.
   *
   * The SDK triggers this callback once every two seconds.
   *
   * @param stats The statistics of the local audio stream.
   * See LocalAudioStats.
   */
  virtual void onLocalAudioStats(const LocalAudioStats& stats) {
    (void)stats;
  }

  /** Reports the statistics of the local video stream.
   *
   * The SDK triggers this callback once every two seconds for each
   * user/host. If there are multiple users/hosts in the channel, the SDK
   * triggers this callback as many times.
   *
   * @note If you have called the `enableDualStreamMode`
   * method, this callback reports the statistics of the high-video
   * stream (high bitrate, and high-resolution video stream).
   *
   * @param source The video source type. See #VIDEO_SOURCE_TYPE.
   * @param stats Statistics of the local video stream. See LocalVideoStats.
   */
  virtual void onLocalVideoStats(VIDEO_SOURCE_TYPE source, const LocalVideoStats& stats) {
    (void)source;
    (void)stats;
  }

  /** Reports the statistics of the video stream from each remote user/host.
   *
   * The SDK triggers this callback once every two seconds for each remote user. If a channel has
   * multiple users/hosts sending video streams, the SDK triggers this callback as many times.
   *
   * @param stats Statistics of the remote video stream. See
   * RemoteVideoStats.
   */
  virtual void onRemoteVideoStats(const RemoteVideoStats& stats) {
    (void)stats;
  }

  /**
   * Occurs when the camera turns on and is ready to capture the video.
   * @deprecated Use `LOCAL_VIDEO_STREAM_STATE_CAPTURING(1)` in onLocalVideoStateChanged instead.
   * This callback indicates that the camera has been successfully turned on and you can start to capture video.
   */
  virtual void onCameraReady() __deprecated {}

  /**
   * Occurs when the camera focus area changes.
   *
   * @note This method is for Andriod and iOS only.
   *
   * @param x The x coordinate of the changed camera focus area.
   * @param y The y coordinate of the changed camera focus area.
   * @param width The width of the changed camera focus area.
   * @param height The height of the changed camera focus area.
   */
  virtual void onCameraFocusAreaChanged(int x, int y, int width, int height) {
    (void)x;
    (void)y;
    (void)width;
    (void)height;
  }
  /**
   * Occurs when the camera exposure area changes.
   *
   * @param x The x coordinate of the changed camera exposure area.
   * @param y The y coordinate of the changed camera exposure area.
   * @param width The width of the changed camera exposure area.
   * @param height The height of the changed exposure area.
   */
  virtual void onCameraExposureAreaChanged(int x, int y, int width, int height) {
    (void)x;
    (void)y;
    (void)width;
    (void)height;
  }
#if defined(__ANDROID__) || (defined(__APPLE__) && TARGET_OS_IOS)
  /**
   * Reports the face detection result of the local user.
   *
   * Once you enable face detection by calling enableFaceDetection(true), you can get the following
   * information on the local user in real-time:
   * - The width and height of the local video.
   * - The position of the human face in the local view.
   * - The distance between the human face and the screen.
   *
   * This value is based on the fitting calculation of the local video size and the position of the human face.
   *
   * @note
   * - This callback is for Android and iOS only.
   * - When it is detected that the face in front of the camera disappears, the callback will be
   * triggered immediately. In the state of no face, the trigger frequency of the callback will be
   * reduced to save power consumption on the local device.
   * - The SDK stops triggering this callback when a human face is in close proximity to the screen.
   * On Android, the value of `distance` reported in this callback may be slightly different from the
   * actual distance. Therefore, Agora does not recommend using it for accurate calculation.
   *
   * @param imageWidth The width (px) of the video image captured by the local camera.
   * @param imageHeight The height (px) of the video image captured by the local camera.
   * @param vecRectangle A Rectangle array of length 'numFaces', which represents the position and size of the human face on the local video：
   * - x: The x-coordinate (px) of the human face in the local view. Taking the top left corner of the view as the origin, the x-coordinate represents the horizontal position of the human face relative to the origin.
   * - y: The y-coordinate (px) of the human face in the local view. Taking the top left corner of the view as the origin, the y-coordinate represents the vertical position of the human face relative to the origin.
   * - width: The width (px) of the human face in the captured view.
   * - height: The height (px) of the human face in the captured view.
   * @param vecDistance An int array of length 'numFaces', which represents distance (cm) between the human face and the screen.
   * @param numFaces The number of faces detected. If the value is 0, it means that no human face is detected.
   */
  virtual void onFacePositionChanged(int imageWidth, int imageHeight,
                                     const Rectangle* vecRectangle, const int* vecDistance,
                                     int numFaces) {
    (void) imageWidth;
    (void) imageHeight;
    (void) vecRectangle;
    (void) vecDistance;
    (void) numFaces;
  }
#endif
  /**
   * Occurs when the video stops playing.
   * @deprecated Use `LOCAL_VIDEO_STREAM_STATE_STOPPED(0)` in the onLocalVideoStateChanged callback instead.
   *
   * The app can use this callback to change the configuration of the view (for example, displaying
   * other pictures in the view) after the video stops playing.
   */
  virtual void onVideoStopped() __deprecated {}

  /** Occurs when the playback state of the music file changes.
   *
   * This callback occurs when the playback state of the music file changes, and reports the current state and error code.

   @param state The playback state of the music file. See #AUDIO_MIXING_STATE_TYPE.
   @param reason The reason for the change of the music file playback state. See #AUDIO_MIXING_REASON_TYPE.
   */
  virtual void onAudioMixingStateChanged(AUDIO_MIXING_STATE_TYPE state, AUDIO_MIXING_REASON_TYPE reason) {
    (void)state;
    (void)reason;
  }

  /** Occurs when the state of the rhythm player changes.
   When you call the \ref IRtcEngine::startRhythmPlayer "startRhythmPlayer"
   method and the state of rhythm player changes, the SDK triggers this
   callback.

   @param state The state code. See #RHYTHM_PLAYER_STATE_TYPE.
   @param reason The error code. See #RHYTHM_PLAYER_REASON.
   */
  virtual void onRhythmPlayerStateChanged(RHYTHM_PLAYER_STATE_TYPE state, RHYTHM_PLAYER_REASON reason) {
    (void)state;
    (void)reason;
  }

  /**
   * Occurs when the SDK cannot reconnect to the server 10 seconds after its connection to the server is
   * interrupted.
   *
   * The SDK triggers this callback when it cannot connect to the server 10 seconds after calling
   * `joinChannel`, regardless of whether it is in the channel or not. If the SDK fails to rejoin
   * the channel 20 minutes after being disconnected from Agora's edge server, the SDK stops rejoining the channel.
   */
  virtual void onConnectionLost() {}

  /** Occurs when the connection between the SDK and the server is interrupted.
   * @deprecated Use `onConnectionStateChanged` instead.

  The SDK triggers this callback when it loses connection with the serer for more
  than 4 seconds after the connection is established. After triggering this
  callback, the SDK tries to reconnect to the server. If the reconnection fails
  within a certain period (10 seconds by default), the onConnectionLost()
  callback is triggered. If the SDK fails to rejoin the channel 20 minutes after
  being disconnected from Agora's edge server, the SDK stops rejoining the channel.

  */
  virtual void onConnectionInterrupted() __deprecated {}

  /** Occurs when your connection is banned by the Agora Server.
   * @deprecated Use `onConnectionStateChanged` instead.
   */
  virtual void onConnectionBanned() __deprecated {}

  /** Occurs when the local user receives the data stream from the remote user.
   *
   * The SDK triggers this callback when the user receives the data stream that another user sends
   * by calling the \ref agora::rtc::IRtcEngine::sendStreamMessage "sendStreamMessage" method.
   *
   * @param uid ID of the user who sends the data stream.
   * @param streamId The ID of the stream data.
   * @param data The data stream.
   * @param length The length (byte) of the data stream.
   * @param sentTs The time when the data stream sent.
   */
  virtual void onStreamMessage(uid_t uid, int streamId, const char* data, size_t length, uint64_t sentTs) {
    (void)uid;
    (void)streamId;
    (void)data;
    (void)length;
    (void)sentTs;
  }

  /** Occurs when the local user does not receive the data stream from the remote user.
   *
   * The SDK triggers this callback when the user fails to receive the data stream that another user sends
   * by calling the \ref agora::rtc::IRtcEngine::sendStreamMessage "sendStreamMessage" method.
   *
   * @param uid ID of the user who sends the data stream.
   * @param streamId The ID of the stream data.
   * @param code The error code.
   * @param missed The number of lost messages.
   * @param cached The number of incoming cached messages when the data stream is
   * interrupted.
   */
  virtual void onStreamMessageError(uid_t uid, int streamId, int code, int missed, int cached) {
    (void)uid;
    (void)streamId;
    (void)code;
    (void)missed;
    (void)cached;
  }

  /**
   * Occurs when the token expires.
   *
   * When the token expires during a call, the SDK triggers this callback to remind the app to renew the token.
   *
   * Upon receiving this callback, generate a new token at your app server and call
   * `joinChannel` to pass the new token to the SDK.
   *
   */
  virtual void onRequestToken() {}

  /**
   * Occurs when the token will expire in 30 seconds.
   *
   * When the token is about to expire in 30 seconds, the SDK triggers this callback to remind the app to renew the token.

   * Upon receiving this callback, generate a new token at your app server and call
   * \ref IRtcEngine::renewToken "renewToken" to pass the new Token to the SDK.
   *
   *
   * @param token The token that will expire in 30 seconds.
   */
  virtual void onTokenPrivilegeWillExpire(const char* token) {
    (void)token;
  }

  /**
   * Occurs when connection license verification fails.
   *
   * You can know the reason accordding to error code
   */
  virtual void onLicenseValidationFailure(LICENSE_ERROR_TYPE error) {
    (void)error;
  }

  /** Occurs when the first local audio frame is published.
   *
   * The SDK triggers this callback under one of the following circumstances:
   * - The local client enables the audio module and calls `joinChannel` successfully.
   * - The local client calls `muteLocalAudioStream(true)` and `muteLocalAudioStream(false)` in sequence.
   * - The local client calls `disableAudio` and `enableAudio` in sequence.
   * - The local client calls `pushAudioFrame` to successfully push the audio frame to the SDK.
   *
   * @param elapsed The time elapsed (ms) from the local user calling `joinChannel` to the SDK triggers this callback.
   */
  virtual void onFirstLocalAudioFramePublished(int elapsed) {
    (void)elapsed;
  }

  /**
   * Occurs when the SDK decodes the first remote audio frame for playback.
   *
   * @deprecated Use `onRemoteAudioStateChanged` instead.
   * The SDK triggers this callback under one of the following circumstances:
   * - The remote user joins the channel and sends the audio stream for the first time.
   * - The remote user's audio is offline and then goes online to re-send audio. It means the local user cannot
   * receive audio in 15 seconds. Reasons for such an interruption include:
   *   - The remote user leaves channel.
   *   - The remote user drops offline.
   *   - The remote user calls muteLocalAudioStream to stop sending the audio stream.
   *   - The remote user calls disableAudio to disable audio.
   * @param uid User ID of the remote user sending the audio stream.
   * @param elapsed The time elapsed (ms) from the loca user calling `joinChannel`
   * until this callback is triggered.
   */
  virtual void onFirstRemoteAudioDecoded(uid_t uid, int elapsed) __deprecated {
    (void)uid;
    (void)elapsed;
  }

  /** Occurs when the SDK receives the first audio frame from a specific remote user.
   * @deprecated Use `onRemoteAudioStateChanged` instead.
   *
   * @param uid ID of the remote user.
   * @param elapsed The time elapsed (ms) from the loca user calling `joinChannel`
   * until this callback is triggered.
   */
  virtual void onFirstRemoteAudioFrame(uid_t uid, int elapsed) __deprecated {
    (void)uid;
    (void)elapsed;
  }

  /** Occurs when the local audio state changes.
   *
   * When the state of the local audio stream changes (including the state of the audio capture and encoding), the SDK
   * triggers this callback to report the current state. This callback indicates the state of the local audio stream,
   * and allows you to troubleshoot issues when audio exceptions occur.
   *
   * @note
   * When the state is `LOCAL_AUDIO_STREAM_STATE_FAILED(3)`, see the `error`
   * parameter for details.
   *
   * @param state State of the local audio. See #LOCAL_AUDIO_STREAM_STATE.
   * @param reason The reason information of the local audio.
   * See #LOCAL_AUDIO_STREAM_REASON.
   */
  virtual void onLocalAudioStateChanged(LOCAL_AUDIO_STREAM_STATE state, LOCAL_AUDIO_STREAM_REASON reason) {
    (void)state;
    (void)reason;
  }

  /** Occurs when the remote audio state changes.
   *
   * When the audio state of a remote user (in the voice/video call channel) or host (in the live streaming channel)
   * changes, the SDK triggers this callback to report the current state of the remote audio stream.
   *
   * @note This callback does not work properly when the number of users (in the voice/video call channel) or hosts
   * (in the live streaming channel) in the channel exceeds 17.
   *
   * @param uid ID of the remote user whose audio state changes.
   * @param state State of the remote audio. See #REMOTE_AUDIO_STATE.
   * @param reason The reason of the remote audio state change.
   * See #REMOTE_AUDIO_STATE_REASON.
   * @param elapsed Time elapsed (ms) from the local user calling the
   * `joinChannel` method until the SDK
   * triggers this callback.
   */
  virtual void onRemoteAudioStateChanged(uid_t uid, REMOTE_AUDIO_STATE state, REMOTE_AUDIO_STATE_REASON reason, int elapsed) {
    (void)uid;
    (void)state;
    (void)reason;
    (void)elapsed;
  }

  /**
   * Occurs when an active speaker is detected.
   *
   * After a successful call of `enableAudioVolumeIndication`, the SDK continuously detects which remote user has the
   * loudest volume. During the current period, the remote user, who is detected as the loudest for the most times,
   * is the most active user.
   *
   * When the number of users is no less than two and an active remote speaker exists, the SDK triggers this callback and reports the uid of the most active remote speaker.
   * - If the most active remote speaker is always the same user, the SDK triggers the `onActiveSpeaker` callback only once.
   * - If the most active remote speaker changes to another user, the SDK triggers this callback again and reports the uid of the new active remote speaker.
   *
   * @param userId The ID of the active speaker. A `uid` of 0 means the local user.
   */
  virtual void onActiveSpeaker(uid_t uid) { 
    (void)uid;
  }

  /** Reports result of content inspection.
   *
   * @param result The result of content inspection: #CONTENT_INSPECT_RESULT.
   */
  virtual void onContentInspectResult(media::CONTENT_INSPECT_RESULT result) { (void)result; }

  /** Reports the result of taking a video snapshot.
   *
   * After a successful `takeSnapshot` method call, the SDK triggers this callback to report whether the snapshot is
   * successfully taken, as well as the details for that snapshot.
   *
   * @param uid The user ID. A `uid` of 0 indicates the local user.
   * @param filePath The local path of the snapshot.
   * @param width The width (px) of the snapshot.
   * @param height The height (px) of the snapshot.
   * @param errCode The message that confirms success or gives the reason why the snapshot is not successfully taken:
   * - 0: Success.
   * - &lt; 0: Failure.
   *   - -1: The SDK fails to write data to a file or encode a JPEG image.
   *   - -2: The SDK does not find the video stream of the specified user within one second after the `takeSnapshot` method call succeeds.
   *   - -3: Calling the `takeSnapshot` method too frequently. Call the `takeSnapshot` method after receiving the `onSnapshotTaken`
   * callback from the previous call.
   */
  virtual void onSnapshotTaken(uid_t uid, const char* filePath, int width, int height, int errCode) {
    (void)uid;
    (void)filePath;
    (void)width;
    (void)height;
    (void)errCode;
  }

  /**
   * Occurs when the user role switches in the interactive live streaming.
   *
   * @param oldRole The old role of the user: #CLIENT_ROLE_TYPE.
   * @param newRole The new role of the user: #CLIENT_ROLE_TYPE.
   * @param newRoleOptions The client role options of the new role: #ClientRoleOptions.
   */
  virtual void onClientRoleChanged(CLIENT_ROLE_TYPE oldRole, CLIENT_ROLE_TYPE newRole, const ClientRoleOptions& newRoleOptions) {
    (void)oldRole;
    (void)newRole;
    (void)newRoleOptions;
  }

  /**
   * Occurs when the user role in a Live-Broadcast channel fails to switch, for example, from a broadcaster
   * to an audience or vice versa.
   *
   * @param reason The reason for failing to change the client role: #CLIENT_ROLE_CHANGE_FAILED_REASON.
   * @param currentRole The current role of the user: #CLIENT_ROLE_TYPE.
   */
  virtual void onClientRoleChangeFailed(CLIENT_ROLE_CHANGE_FAILED_REASON reason, CLIENT_ROLE_TYPE currentRole) {
    (void)reason;
    (void)currentRole;
  }

  /** Occurs when the audio device volume changes.
   @param deviceType The device type, see #MEDIA_DEVICE_TYPE
   @param volume The volume of the audio device.
   @param muted Whether the audio device is muted:
   - true: The audio device is muted.
   - false: The audio device is not muted.
   */
  virtual void onAudioDeviceVolumeChanged(MEDIA_DEVICE_TYPE deviceType, int volume, bool muted) {
    (void)deviceType;
    (void)volume;
    (void)muted;
  }

  /**
   * Occurs when the state of the RTMP streaming changes.
   *
   * When the media push state changes, the SDK triggers this callback and reports the URL address and the current state
   * of the media push. This callback indicates the state of the media push. When exceptions occur, you can troubleshoot
   * issues by referring to the detailed error descriptions in the error code.
   *
   * @param url The URL address where the state of the media push changes.
   * @param state The current state of the media push: #RTMP_STREAM_PUBLISH_STATE.
   * @param reason The detailed error information for the media push: #RTMP_STREAM_PUBLISH_REASON.
   */
  virtual void onRtmpStreamingStateChanged(const char* url, RTMP_STREAM_PUBLISH_STATE state,
                                           RTMP_STREAM_PUBLISH_REASON reason) {
    (void)url;
    (void)state;
    (void)reason;
  }

  /** Reports events during the media push.
   *
   * @param url The URL for media push.
   * @param eventCode The event code of media push. See RTMP_STREAMING_EVENT for details.
   */
  virtual void onRtmpStreamingEvent(const char* url, RTMP_STREAMING_EVENT eventCode) {
    (void)url;
    (void)eventCode;
  }

  /**
   * Occurs when the publisher's transcoding settings are updated.
   *
   * When the `LiveTranscoding` class in \ref IRtcEngine::setLiveTranscoding "setLiveTranscoding"
   * updates, the SDK triggers this callback to report the update information.
   *
   * @note
   * If you call the `setLiveTranscoding` method to set the `LiveTranscoding` class for the first time, the SDK
   * does not trigger this callback.
   */
  virtual void onTranscodingUpdated() {}

  /** Occurs when the local audio route changes (for Android, iOS, and macOS only).

   The SDK triggers this callback when the local audio route switches to an
   earpiece, speakerphone, headset, or Bluetooth device.
   @param routing The current audio output routing:
   - -1: Default.
   - 0: Headset.
   - 1: Earpiece.
   - 2: Headset with no microphone.
   - 3: Speakerphone.
   - 4: Loudspeaker.
   - 5: Bluetooth headset.
   */
  virtual void onAudioRoutingChanged(int routing) { (void)routing; }

  /**
   * Occurs when the state of the media stream relay changes.
   *
   * The SDK reports the state of the current media relay and possible error messages in this
   * callback.
   *
   * @param state The state code:
   * - `RELAY_STATE_IDLE(0)`: The SDK is initializing.
   * - `RELAY_STATE_CONNECTING(1)`: The SDK tries to relay the media stream to the destination
   * channel.
   * - `RELAY_STATE_RUNNING(2)`: The SDK successfully relays the media stream to the destination
   * channel.
   * - `RELAY_STATE_FAILURE(3)`: A failure occurs. See the details in `code`.
   * @param code The error code:
   * - `RELAY_OK(0)`: The state is normal.
   * - `RELAY_ERROR_SERVER_ERROR_RESPONSE(1)`: An error occurs in the server response.
   * - `RELAY_ERROR_SERVER_NO_RESPONSE(2)`: No server response. You can call the leaveChannel method
   * to leave the channel.
   * - `RELAY_ERROR_NO_RESOURCE_AVAILABLE(3)`: The SDK fails to access the service, probably due to
   * limited resources of the server.
   * - `RELAY_ERROR_FAILED_JOIN_SRC(4)`: Fails to send the relay request.
   * - `RELAY_ERROR_FAILED_JOIN_DEST(5)`: Fails to accept the relay request.
   * - `RELAY_ERROR_FAILED_PACKET_RECEIVED_FROM_SRC(6)`: The server fails to receive the media
   * stream.
   * - `RELAY_ERROR_FAILED_PACKET_SENT_TO_DEST(7)`: The server fails to send the media stream.
   * - `RELAY_ERROR_SERVER_CONNECTION_LOST(8)`: The SDK disconnects from the server due to poor
   * network connections. You can call the leaveChannel method to leave the channel.
   * - `RELAY_ERROR_INTERNAL_ERROR(9)`: An internal error occurs in the server.
   * - `RELAY_ERROR_SRC_TOKEN_EXPIRED(10)`: The token of the source channel has expired.
   * - `RELAY_ERROR_DEST_TOKEN_EXPIRED(11)`: The token of the destination channel has expired.
   */
  virtual void onChannelMediaRelayStateChanged(int state, int code) {
    (void)state;
    (void)code;
  }

  /**
   * Occurs when the published media stream falls back to an audio-only stream due to poor network conditions or
   * switches back to video stream after the network conditions improve.
   *
   * If you call `setLocalPublishFallbackOption` and set `option` as `STREAM_FALLBACK_OPTION_AUDIO_ONLY(2)`, this
   * callback is triggered when the locally published stream falls back to audio-only mode due to poor uplink
   * conditions, or when the audio stream switches back to the video after the uplink network condition improves.
   * Once the published stream falls back to audio only, the remote app receives the `onRemoteVideoStateChanged` callback.
   *
   * @param isFallbackOrRecover Whether the published stream fell back to audio-only or switched back to the video:
   * - `true`: The published stream fell back to audio-only due to poor network conditions.
   * - `false`: The published stream switched back to the video after the network conditions improved.
   */
  virtual void onLocalPublishFallbackToAudioOnly(bool isFallbackOrRecover) {
    (void)isFallbackOrRecover;
  }

  /**
   * Occurs when the remote media stream falls back to audio-only stream due to poor network conditions or
   * switches back to video stream after the network conditions improve.
   *
   * If you call `setRemoteSubscribeFallbackOption` and set `option` as `STREAM_FALLBACK_OPTION_AUDIO_ONLY(2)`, this
   * callback is triggered when the remotely subscribed media stream falls back to audio-only mode due to poor downlink
   * conditions, or when the remotely subscribed media stream switches back to the video after the downlink network
   * condition improves.
   *
   * @note Once the remote media stream is switched to the low stream due to poor network conditions, you can monitor
   * the stream switch between a high and low stream in the `onRemoteVideoStats` callback.
   *
   * @param uid ID of the remote user sending the stream.
   * @param isFallbackOrRecover Whether the remote media stream fell back to audio-only or switched back to the video:
   * - `true`: The remote media stream fell back to audio-only due to poor network conditions.
   * - `false`: The remote media stream switched back to the video stream after the network conditions improved.
   */
  virtual void onRemoteSubscribeFallbackToAudioOnly(uid_t uid, bool isFallbackOrRecover) {
    (void)uid;
    (void)isFallbackOrRecover;
  }

  /** Reports the transport-layer statistics of each remote audio stream.
   * @deprecated Use `onRemoteAudioStats` instead.

  This callback reports the transport-layer statistics, such as the packet loss rate and network time delay, once every
  two seconds after the local user receives an audio packet from a remote user. During a call, when the user receives
  the audio packet sent by the remote user/host, the callback is triggered every 2 seconds.

  @param uid ID of the remote user whose audio data packet is received.
  @param delay The network time delay (ms) from the sender to the receiver.
  @param lost The Packet loss rate (%) of the audio packet sent from the remote
  user.
  @param rxKBitRate Received bitrate (Kbps) of the audio packet sent from the
  remote user.
  */
  virtual void onRemoteAudioTransportStats(uid_t uid, unsigned short delay, unsigned short lost, unsigned short rxKBitRate) __deprecated {
    (void)uid;
    (void)delay;
    (void)lost;
    (void)rxKBitRate;
  }

  /** Reports the transport-layer statistics of each remote video stream.
   * @deprecated Use `onRemoteVideoStats` instead.

  This callback reports the transport-layer statistics, such as the packet loss rate and network time
  delay, once every two seconds after the local user receives a video packet from a remote user.

  During a call, when the user receives the video packet sent by the remote user/host, the callback is
  triggered every 2 seconds.

  @param uid ID of the remote user whose video packet is received.
  @param delay The network time delay (ms) from the remote user sending the
  video packet to the local user.
  @param lost The packet loss rate (%) of the video packet sent from the remote
  user.
  @param rxKBitRate The bitrate (Kbps) of the video packet sent from
  the remote user.
  */
  virtual void onRemoteVideoTransportStats(uid_t uid, unsigned short delay, unsigned short lost, unsigned short rxKBitRate) __deprecated {
    (void)uid;
    (void)delay;
    (void)lost;
    (void)rxKBitRate;
  }

  /** Occurs when the network connection state changes.
   *
   * When the network connection state changes, the SDK triggers this callback and reports the current
   * connection state and the reason for the change.

  @param state The current connection state. See #CONNECTION_STATE_TYPE.
  @param reason The reason for a connection state change. See #CONNECTION_CHANGED_REASON_TYPE.
   */
  virtual void onConnectionStateChanged(
      CONNECTION_STATE_TYPE state, CONNECTION_CHANGED_REASON_TYPE reason) {
    (void)state;
    (void)reason;
  }

  /** Occurs when the WIFI message need be sent to the user.
   *
   * @param reason The reason of notifying the user of a message.
   * @param action Suggest an action for the user.
   * @param wlAccMsg The message content of notifying the user.
   */
  virtual void onWlAccMessage(WLACC_MESSAGE_REASON reason, WLACC_SUGGEST_ACTION action, const char* wlAccMsg) {
    (void)reason;
    (void)action;
    (void)wlAccMsg;
  }

  /** Occurs when SDK statistics wifi acceleration optimization effect.
   *
   * @param currentStats Instantaneous value of optimization effect.
   * @param averageStats Average value of cumulative optimization effect.
   */
  virtual void onWlAccStats(const WlAccStats& currentStats, const WlAccStats& averageStats) {
    (void)currentStats;
    (void)averageStats;
  }

  /** Occurs when the local network type changes.
   *
   * This callback occurs when the connection state of the local user changes. You can get the
   * connection state and reason for the state change in this callback. When the network connection
   * is interrupted, this callback indicates whether the interruption is caused by a network type
   * change or poor network conditions.

  @param type The type of the local network connection. See #NETWORK_TYPE.
   */
  virtual void onNetworkTypeChanged(NETWORK_TYPE type) {
    (void)type;
  }

  /** Reports the built-in encryption errors.
   *
   * When encryption is enabled by calling `enableEncryption`, the SDK triggers this callback if an
   * error occurs in encryption or decryption on the sender or the receiver side.

  @param errorType The error type. See #ENCRYPTION_ERROR_TYPE.
   */
  virtual void onEncryptionError(ENCRYPTION_ERROR_TYPE errorType) {
    (void)errorType;
  }

  /** Occurs when the SDK cannot get the device permission.
   *
   * When the SDK fails to get the device permission, the SDK triggers this callback to report which
   * device permission cannot be got.
   *
   * @note This method is for Android and iOS only.

  @param permissionType The type of the device permission. See #PERMISSION_TYPE.
  */
  virtual void onPermissionError(PERMISSION_TYPE permissionType) {
    (void)permissionType;
  }

  /** Occurs when the local user registers a user account.
   *
   * After the local user successfully calls `registerLocalUserAccount` to register the user account
   * or calls `joinChannelWithUserAccount` to join a channel, the SDK triggers the callback and
   * informs the local user's UID and User Account.

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

  /**
   * Occurs when the user account is updated.
   *
   * @param uid The user ID.
   * @param userAccount The user account.
   */
  virtual void onUserAccountUpdated(uid_t uid, const char* userAccount){
    (void)uid;
    (void)userAccount;
  }

  /**
   * Reports the tracing result of video rendering event of the user.
   * 
   * @param uid The user ID.
   * @param currentEvent The current event of the tracing result: #MEDIA_TRACE_EVENT.
   * @param tracingInfo The tracing result: #VideoRenderingTracingInfo.
   */
  virtual void onVideoRenderingTracingResult(uid_t uid, MEDIA_TRACE_EVENT currentEvent, VideoRenderingTracingInfo tracingInfo) {
    (void)uid;
    (void)currentEvent;
    (void)tracingInfo;
  }

  /**
   * Occurs when local video transcoder stream has an error.
   *
   * @param stream Stream type of TranscodingVideoStream.
   * @param error Error code of VIDEO_TRANSCODER_ERROR.
   */
  virtual void onLocalVideoTranscoderError(const TranscodingVideoStream& stream, VIDEO_TRANSCODER_ERROR error){
    (void)stream;
    (void)error;
  }

  /**
   * Reports the user log upload result
   * @param requestId RequestId of the upload
   * @param success Is upload success
   * @param reason Reason of the upload, 0: OK, 1 Network Error, 2 Server Error.
   */
  virtual void onUploadLogResult(const char* requestId, bool success, UPLOAD_ERROR_REASON reason) {
    (void)requestId;
    (void)success;
    (void)reason;
  }

  /**
   * Occurs when the audio subscribing state changes.
   *
   * @param channel The name of the channel.
   * @param uid The ID of the remote user.
   * @param oldState The previous subscribing status: #STREAM_SUBSCRIBE_STATE.
   * @param newState The current subscribing status: #STREAM_SUBSCRIBE_STATE.
   * @param elapseSinceLastState The time elapsed (ms) from the previous state to the current state.
   */
  virtual void onAudioSubscribeStateChanged(const char* channel, uid_t uid, STREAM_SUBSCRIBE_STATE oldState, STREAM_SUBSCRIBE_STATE newState, int elapseSinceLastState) {
    (void)channel;
    (void)uid;
    (void)oldState;
    (void)newState;
    (void)elapseSinceLastState;
  }

  /**
   * Occurs when the video subscribing state changes.
   *
   * @param channel The name of the channel.
   * @param uid The ID of the remote user.
   * @param oldState The previous subscribing status: #STREAM_SUBSCRIBE_STATE.
   * @param newState The current subscribing status: #STREAM_SUBSCRIBE_STATE.
   * @param elapseSinceLastState The time elapsed (ms) from the previous state to the current state.
   */
  virtual void onVideoSubscribeStateChanged(const char* channel, uid_t uid, STREAM_SUBSCRIBE_STATE oldState, STREAM_SUBSCRIBE_STATE newState, int elapseSinceLastState) {
    (void)channel;
    (void)uid;
    (void)oldState;
    (void)newState;
    (void)elapseSinceLastState;
  }

  /**
   * Occurs when the audio publishing state changes.
   *
   * @param channel The name of the channel.
   * @param oldState The previous publishing state: #STREAM_PUBLISH_STATE.
   * @param newState The current publishing state: #STREAM_PUBLISH_STATE.
   * @param elapseSinceLastState The time elapsed (ms) from the previous state to the current state.
   */
  virtual void onAudioPublishStateChanged(const char* channel, STREAM_PUBLISH_STATE oldState, STREAM_PUBLISH_STATE newState, int elapseSinceLastState) {
    (void)channel;
    (void)oldState;
    (void)newState;
    (void)elapseSinceLastState;
  }

  /**
   * Occurs when the video publishing state changes.
   *
   * @param source The video source type.
   * @param channel The name of the channel.
   * @param oldState The previous publishing state: #STREAM_PUBLISH_STATE.
   * @param newState The current publishing state: #STREAM_PUBLISH_STATE.
   * @param elapseSinceLastState The time elapsed (ms) from the previous state to the current state.
   */
  virtual void onVideoPublishStateChanged(VIDEO_SOURCE_TYPE source, const char* channel, STREAM_PUBLISH_STATE oldState, STREAM_PUBLISH_STATE newState, int elapseSinceLastState) {
    (void)source;
    (void)channel;
    (void)oldState;
    (void)newState;
    (void)elapseSinceLastState;
  }

  /**
   * Occurs when receive a video transcoder stream which has video layout info.
   *
   * @param uid user id of the transcoded stream.
   * @param width width of the transcoded stream.
   * @param height height of the transcoded stream.
   * @param layoutCount count of layout info in the transcoded stream.
   * @param layoutlist video layout info list of the transcoded stream.
   */
  virtual void onTranscodedStreamLayoutInfo(uid_t uid, int width, int height, int layoutCount,const VideoLayout* layoutlist) {
    (void)uid;
    (void)width;
    (void)height;
    (void)layoutCount;
    (void)layoutlist;
  }

  /**
   * Occurs when the SDK receives audio metadata.
   * @since v4.3.1
   * @param uid ID of the remote user.
   * @param metadata The pointer of metadata
   * @param length Size of metadata
   * @technical preview 
   */
  virtual void onAudioMetadataReceived(uid_t uid, const char* metadata, size_t length) {
    (void)uid;
    (void)metadata;
    (void)length;
  }
    
  /**
   * The event callback of the extension.
   *
   * To listen for events while the extension is running, you need to register this callback.
   * 
   * @param context The context of the extension.
   * @param key The key of the extension.
   * @param value The value of the extension key.
   */
  virtual void onExtensionEventWithContext(const ExtensionContext &context, const char* key, const char* value) {
    (void)context;
    (void)key;
    (void)value;
  }

  /**
   * Occurs when the extension is enabled.
   * 
   * After a successful creation of filter , the extension triggers this callback.
   * 
   * @param context The context of the extension.
   */
  virtual void onExtensionStartedWithContext(const ExtensionContext &context) {
    (void)context;
  }

  /**
   * Occurs when the extension is disabled.
   * 
   * After a successful destroy filter, the extension triggers this callback.
   * 
   * @param context The context of the extension.
   */
  virtual void onExtensionStoppedWithContext(const ExtensionContext &context) {
    (void)context;
  }

  /**
   * Occurs when the extension runs incorrectly.
   * 
   * When the extension runs in error, the extension triggers
   * this callback and reports the error code and reason.
   *
   * @param context The context of the extension.
   * @param error The error code. For details, see the extension documentation provided by the extension provider.
   * @param message The error message. For details, see the extension documentation provided by the extension provider.
   */
  virtual void onExtensionErrorWithContext(const ExtensionContext &context, int error, const char* message) {
    (void)context;
    (void)error;
    (void)message;
  }

  /**
   * Occurs when the SDK receives RTM setting change response.
   *
   * @technical preview
   * @param code The error code.
   */
  virtual void onSetRtmFlagResult(int code) {
    (void)code;
  }
};

/**
 * The IVideoDeviceCollection class. You can get information related to video devices through this interface.
 */
class IVideoDeviceCollection {
 public:
  virtual ~IVideoDeviceCollection() {}

  /**
   * Gets the total number of the indexed video capture devices in the system.
   *
   * @return The total number of the indexed video capture devices.
   */
  virtual int getCount() = 0;

  /**
   * Specifies a device with the device ID.
   *
   * @param deviceIdUTF8 The device ID. The maximum length is #MAX_DEVICE_ID_LENGTH_TYPE. Plugging or
   * unplugging the audio device does not change the value of deviceId.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setDevice(const char deviceIdUTF8[MAX_DEVICE_ID_LENGTH]) = 0;

  /**
   * Gets a specified piece of information about an indexed video device.
   *
   * @param index The index value of the video device. The value of this parameter must be less than the value returned in `getCount`.
   * @param deviceNameUTF8 The name of the device. The maximum length is #MAX_DEVICE_ID_LENGTH.
   * @param deviceIdUTF8 The device ID of the video device. The maximum length is #MAX_DEVICE_ID_LENGTH.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int getDevice(int index, char deviceNameUTF8[MAX_DEVICE_ID_LENGTH],
                        char deviceIdUTF8[MAX_DEVICE_ID_LENGTH]) = 0;

  /**
   * Releases all the resources occupied by the IVideoDeviceCollection object.
   */
  virtual void release() = 0;
};

/**
 * The IVideoDeviceManager class.
 */
class IVideoDeviceManager {
 public:
  virtual ~IVideoDeviceManager() {}
  /**
   * Enumerates the video devices.
   *
   * This method returns an `IVideoDeviceCollection` object including all video devices in the system.
   * With the `IVideoDeviceCollection` object, the application can enumerate video devices. The
   * application must call the release method to release the returned object after using it.
   *
   * @return
   * - Success: An `IVideoDeviceCollection` object including all video devices in the system.
   * - Failure: NULL.
   */
  virtual IVideoDeviceCollection* enumerateVideoDevices() = 0;

  /**
   * Specifies the video capture device with the device ID.
   *
   * @param deviceIdUTF8 he device ID. You can get the device ID by calling `enumerateVideoDevices`.
   * The maximum length is #MAX_DEVICE_ID_LENGTH.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setDevice(const char deviceIdUTF8[MAX_DEVICE_ID_LENGTH]) = 0;

  /**
   * Retrieves the current video capture device.
   * @param deviceIdUTF8 Output parameter. The device ID. The maximum length is #MAX_DEVICE_ID_LENGTH_TYPE.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int getDevice(char deviceIdUTF8[MAX_DEVICE_ID_LENGTH]) = 0;

#if defined(_WIN32) || (defined(__linux__) && !defined(__ANDROID__)) || \
    (defined(__APPLE__) && TARGET_OS_MAC && !TARGET_OS_IPHONE)
  /**
   * Gets the number of video formats supported by the specified video capture device.
   *
   * Video capture devices may support multiple video formats, and each format supports different
   * combinations of video frame width, video frame height, and frame rate.
   *
   * You can call this method to get how many video formats the specified video capture device can
   * support, and then call `getCapability` to get the specific video frame information in the
   * specified video format.
   *
   * @param deviceIdUTF8 The ID of the video capture device.
   *
   * @return
   * - 0: Success. Returns the number of video formats supported by this device. For example: If the
   * specified camera supports 10 different video formats, the return value is 10.
   * - < 0: Failure.
   */
  virtual int numberOfCapabilities(const char* deviceIdUTF8) = 0;

  /**
   * Gets the detailed video frame information of the video capture device in the specified video format.
   *
   * After calling `numberOfCapabilities` to get the number of video formats supported by the video capture
   * device, you can call this method to get the specific video frame information supported by the
   * specified index number.
   *
   * @param deviceIdUTF8 ID of the video capture device.
   * @param deviceCapabilityNumber The index number of the video format. If the return value of `numberOfCapabilities`
   * is i, the value range of this parameter is [0,i).
   * @param capability Output parameter. Indicates the specific information of the specified video format,
   * including width (px), height (px), and frame rate (fps). See VideoFormat.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int getCapability(const char* deviceIdUTF8, const uint32_t deviceCapabilityNumber, VideoFormat& capability) = 0;
#endif
  /**
   * Starts the video capture device test.
   *
   * This method tests whether the video capture device works properly.
   * Before calling this method, ensure that you have already called
   * \ref IRtcEngine::enableVideo "enableVideo", and the HWND window handle of
   * the incoming parameter is valid.
   *
   * @param hwnd An Output parameter that specifies the window handle to display the video.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int startDeviceTest(view_t hwnd) = 0;

  /**
   * Stops the video capture device test.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int stopDeviceTest() = 0;

  /**
   * Releases all the resources occupied by the `IVideoDeviceManager` object.
   */
  virtual void release() = 0;
};

/**
 * The context of IRtcEngine.
 */
struct RtcEngineContext {
  /**
   * The event handler for IRtcEngine.
   */
  IRtcEngineEventHandler* eventHandler;
  /**
   * The App ID issued by Agora for your project. Only users in apps with the same App ID can join the
   * same channel and communicate with each other. An App ID can only be used to create one `IRtcEngine`
   * instance. To change your App ID, call release to destroy the current IRtcEngine instance, and then
   * create a new one.
   */
  const char* appId;
  /**
   * - For Android, it is the context of Activity or Application.
   * - For Windows, it is the window handle of app. Once set, this parameter enables you to plug
   * or unplug the video devices while they are powered.
   */
  void* context;
  /**
   * The channel profile. See #CHANNEL_PROFILE_TYPE.
   */
  CHANNEL_PROFILE_TYPE channelProfile;

  /**
   * The license used for verification when connectting channel. Charge according to the license
   */
  const char* license;

  /**
   * The audio application scenario. See #AUDIO_SCENARIO_TYPE.
   *
   * @note Agora recommends the following scenarios:
   * - `AUDIO_SCENARIO_DEFAULT(0)`
   * - `AUDIO_SCENARIO_GAME_STREAMING(3)`
   */
  AUDIO_SCENARIO_TYPE audioScenario;
  /**
   * The region for connection. This is an advanced feature and applies to scenarios that have regional restrictions.
   *
   * For the regions that Agora supports, see #AREA_CODE. The area codes support bitwise operation.
   *
   * After specifying the region, the app integrated with the Agora SDK connects to the Agora servers
   * within that region.
   */
  unsigned int areaCode;

  /**
   * The log files that the SDK outputs. See LogConfig.
   *
   * By default, the SDK generates five SDK log files and five API call log files with the following rules:
   * - The SDK log files are: `agorasdk.log`, `agorasdk.1.log`, `agorasdk.2.log`, `agorasdk.3.log`, and `agorasdk.4.log`.
   * - The API call log files are: `agoraapi.log`, `agoraapi.1.log`, `agoraapi.2.log`, `agoraapi.3.log`, and `agoraapi.4.log`.
   * - The default size for each SDK log file is 1,024 KB; the default size for each API call log file is 2,048 KB. These log files are encoded in UTF-8.
   * - The SDK writes the latest logs in `agorasdk.log` or `agoraapi.log`.
   * - When `agorasdk.log` is full, the SDK processes the log files in the following order:
   *   - Delete the `agorasdk.4.log` file (if any).
   *   - Rename `agorasdk.3.log` to `agorasdk.4.log`.
   *   - Rename `agorasdk.2.log` to `agorasdk.3.log`.
   *   - Rename `agorasdk.1.log` to `agorasdk.2.log`.
   *   - Create a new `agorasdk.log` file.
   */
  commons::LogConfig logConfig;

  /**
   * Thread priority for SDK common threads
   */
  Optional<THREAD_PRIORITY_TYPE> threadPriority;

  /**
   * Whether to use egl context in the current thread as sdk‘s root egl context,
   * which is shared by all egl related modules. eg. camera capture, video renderer.
   *
   * @note
   * This property applies to Android only.
   */
  bool useExternalEglContext;

  /**
   * Determines whether to enable domain limit
   * -true: only connect to servers which already parsed by DNS
   * -false: (Default) connect to servers with no limit
   */
  bool domainLimit;

  /**
   * Whether to automatically register Agora extensions when initializing RtcEngine.
   * -true: (Default) Automatically register Agora extensions.
   * -false: Do not automatically register Agora extensions. The user calls EnableExtension to manually register an Agora extension.
   */
  bool autoRegisterAgoraExtensions;

  RtcEngineContext()
      : eventHandler(NULL), appId(NULL), context(NULL), channelProfile(CHANNEL_PROFILE_LIVE_BROADCASTING),
        license(NULL), audioScenario(AUDIO_SCENARIO_DEFAULT), areaCode(AREA_CODE_GLOB),
        logConfig(), useExternalEglContext(false), domainLimit(false), autoRegisterAgoraExtensions(true) {}
};

/** Definition of IMetadataObserver
*/
class IMetadataObserver {
public:
    virtual ~IMetadataObserver() {}

    /** The metadata type.
     *
     * @note We only support video metadata for now.
     */
    enum METADATA_TYPE
    {
        /** -1: (Not supported) Unknown.
         */
        UNKNOWN_METADATA = -1,
        /** 0: (Supported) Video metadata.
         */
        VIDEO_METADATA = 0,
    };
    /**
      * The maximum metadata size.
      */
    enum MAX_METADATA_SIZE_TYPE
    {
        INVALID_METADATA_SIZE_IN_BYTE = -1,
        DEFAULT_METADATA_SIZE_IN_BYTE = 512,
        MAX_METADATA_SIZE_IN_BYTE = 1024
    };

    /** Metadata.
     */
    struct Metadata
    {
        /** The channel ID of the `metadata`.
         */
        const char* channelId;
        /** The User ID that sent the metadata.
         * - For the receiver: The user ID of the user who sent the `metadata`.
         * - For the sender: Ignore this value.
         */
        unsigned int uid;
        /** The buffer size of the sent or received `metadata`.
         */
        unsigned int size;
        /** The buffer address of the sent or received `metadata`.
         */
        unsigned char *buffer;
        /** The NTP timestamp (ms) when the metadata is sent.
         *  @note If the receiver is audience, the receiver cannot get the NTP timestamp (ms).
         */
        long long timeStampMs;

         Metadata() : channelId(NULL), uid(0), size(0), buffer(NULL), timeStampMs(0) {}
    };

   /** Occurs when the SDK requests the maximum size of the metadata.
    *
    *
    * After successfully complete the registration by calling `registerMediaMetadataObserver`, the SDK
    * triggers this callback once every video frame is sent. You need to specify the maximum size of
    * the metadata in the return value of this callback.
    *
    * @return The maximum size of the buffer of the metadata that you want to use. The highest value is
    * 1024 bytes. Ensure that you set the return value.
    */
    virtual int getMaxMetadataSize() { return DEFAULT_METADATA_SIZE_IN_BYTE; }

    /** Occurs when the local user receives the metadata.

     @note Ensure that the size of the metadata does not exceed the value set in the `getMaxMetadataSize` callback.

     @param metadata The metadata that the user wants to send. For details, see Metadata.
     @param source_type The video data type: #VIDEO_SOURCE_TYPE.
     @return
     - true:  Send.
     - false: Do not send.
     */
    virtual bool onReadyToSendMetadata(Metadata &metadata, VIDEO_SOURCE_TYPE source_type) = 0;

    /** Occurs when the local user receives the metadata.
     *
     * @param metadata The metadata received. See Metadata.
     *
     * @note If the receiver is audience, the receiver cannot get the NTP timestamp (ms)
     * that the metadata sends.
     */
    virtual void onMetadataReceived(const Metadata& metadata) = 0;
};

// The reason codes for media streaming
// GENERATED_JAVA_ENUM_PACKAGE: io.agora.streaming
enum DIRECT_CDN_STREAMING_REASON {
  // No error occurs.
  DIRECT_CDN_STREAMING_REASON_OK = 0,
  // A general error occurs (no specified reason).
  DIRECT_CDN_STREAMING_REASON_FAILED = 1,
  // Audio publication error.
  DIRECT_CDN_STREAMING_REASON_AUDIO_PUBLICATION = 2,
  // Video publication error.
  DIRECT_CDN_STREAMING_REASON_VIDEO_PUBLICATION = 3,

  DIRECT_CDN_STREAMING_REASON_NET_CONNECT = 4,
  // Already exist stream name.
  DIRECT_CDN_STREAMING_REASON_BAD_NAME = 5,
};

// The connection state of media streaming
// GENERATED_JAVA_ENUM_PACKAGE: io.agora.streaming
enum DIRECT_CDN_STREAMING_STATE {

  DIRECT_CDN_STREAMING_STATE_IDLE = 0,

  DIRECT_CDN_STREAMING_STATE_RUNNING = 1,

  DIRECT_CDN_STREAMING_STATE_STOPPED = 2,

  DIRECT_CDN_STREAMING_STATE_FAILED = 3,

  DIRECT_CDN_STREAMING_STATE_RECOVERING = 4,
};

/**
 * The statistics of the Direct Cdn Streams.
 */
struct DirectCdnStreamingStats {
    /**
     * Width of the video pushed by rtmp.
     */
    int videoWidth;

    /**
     * Height of the video pushed by rtmp.
     */
    int videoHeight;

    /**
     * The frame rate of the video pushed by rtmp.
     */
    int fps;

    /**
     * Real-time bit rate of the video streamed by rtmp.
     */
    int videoBitrate;

    /**
     * Real-time bit rate of the audio pushed by rtmp.
     */
    int audioBitrate;
};

/**
 * The event handler for direct cdn streaming
 *
 */
class IDirectCdnStreamingEventHandler {
 public:
  virtual ~IDirectCdnStreamingEventHandler() {}

  /**
   * Event callback of direct cdn streaming
   * @param state Current status
   * @param reason Reason Code
   * @param message Message
   */
  virtual void onDirectCdnStreamingStateChanged(DIRECT_CDN_STREAMING_STATE state, DIRECT_CDN_STREAMING_REASON reason, const char* message)  {
    (void)state;
    (void)reason;
    (void)message;
  };

  virtual void onDirectCdnStreamingStats(const DirectCdnStreamingStats& stats)  {
    (void)stats;
  };
};

/**
 * The channel media options.
 */
struct DirectCdnStreamingMediaOptions {
  /**
   * Determines whether to publish the video of the camera track.
   * - true: Publish the video track of the camera capturer.
   * - false: (Default) Do not publish the video track of the camera capturer.
   */
  Optional<bool> publishCameraTrack;
  /**
   * Determines whether to publish the recorded audio.
   * - true: Publish the recorded audio.
   * - false: (Default) Do not publish the recorded audio.
   */
  Optional<bool> publishMicrophoneTrack;
  /**
   * Determines whether to publish the audio of the custom audio track.
   * - true: Publish the audio of the custom audio track.
   * - false: (Default) Do not publish the audio of the custom audio track.
   */
  Optional<bool> publishCustomAudioTrack;
  /**
   * Determines whether to publish the video of the custom video track.
   * - true: Publish the video of the custom video track.
   * - false: (Default) Do not publish the video of the custom video track.
   */
  Optional<bool> publishCustomVideoTrack;
  /**
  * Determines whether to publish the audio track of media player source.
  * - true: Publish the audio track of media player source.
  * - false: (Default) Do not publish the audio track of media player source.
  */
  Optional<bool> publishMediaPlayerAudioTrack;
  /**
  * Determines which media player source should be published.
  * You can get the MediaPlayerId after calling getMediaPlayerId() of AgoraMediaPlayer.
  */
  Optional<int> publishMediaPlayerId;
  /**
   * The custom video track id which will used to publish.
   * You can get the VideoTrackId after calling createCustomVideoTrack() of IRtcEngine.
   */
  Optional<video_track_id_t> customVideoTrackId;

  DirectCdnStreamingMediaOptions() {}
  ~DirectCdnStreamingMediaOptions() {}

  void SetAll(const DirectCdnStreamingMediaOptions& change) {
#define SET_FROM(X) SetFrom(&X, change.X)
      SET_FROM(publishCameraTrack);
      SET_FROM(publishMicrophoneTrack);
      SET_FROM(publishCustomAudioTrack);
      SET_FROM(publishCustomVideoTrack);
      SET_FROM(publishMediaPlayerAudioTrack);
      SET_FROM(publishMediaPlayerId);
      SET_FROM(customVideoTrackId);
#undef SET_FROM
  }

  bool operator==(const DirectCdnStreamingMediaOptions& o) const {
#define BEGIN_COMPARE() bool b = true
#define ADD_COMPARE(X) b = (b && (X == o.X))
#define END_COMPARE()

      BEGIN_COMPARE();
      ADD_COMPARE(publishCameraTrack);
      ADD_COMPARE(publishMicrophoneTrack);
      ADD_COMPARE(publishCustomAudioTrack);
      ADD_COMPARE(publishCustomVideoTrack);
      ADD_COMPARE(publishMediaPlayerAudioTrack);
      ADD_COMPARE(customVideoTrackId);
      ADD_COMPARE(publishMediaPlayerId);
      END_COMPARE();

#undef BEGIN_COMPARE
#undef ADD_COMPARE
#undef END_COMPARE
      return b;
  }

  DirectCdnStreamingMediaOptions& operator=(const DirectCdnStreamingMediaOptions& replace) {
    if (this != &replace) {
#define REPLACE_BY(X) ReplaceBy(&X, replace.X)

        REPLACE_BY(publishCameraTrack);
        REPLACE_BY(publishMicrophoneTrack);
        REPLACE_BY(publishCustomAudioTrack);
        REPLACE_BY(publishCustomVideoTrack);
        REPLACE_BY(publishMediaPlayerAudioTrack);
        REPLACE_BY(customVideoTrackId);
        REPLACE_BY(publishMediaPlayerId);
#undef REPLACE_BY
    }
    return *this;
  }
};

/**
 * The information for extension.
 */
struct ExtensionInfo {
  /**
   * The type of media device.
   */
  agora::media::MEDIA_SOURCE_TYPE mediaSourceType;

  /**
   * The id of the remote user on which the extension works.
   *
   * @note remoteUid = 0 means that the extension works on all remote streams.
   */
  uid_t remoteUid;

  /**
   *  The unique channel name for the AgoraRTC session in the string format. The string
   * length must be less than 64 bytes. Supported character scopes are:
   * - All lowercase English letters: a to z.
   * - All uppercase English letters: A to Z.
   * - All numeric characters: 0 to 9.
   * - The space character.
   * - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+",
   * "-",
   * ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
   */
  const char* channelId;

  /**
   * User ID: A 32-bit unsigned integer ranging from 1 to (2^32-1). It must be unique.
   */
  uid_t localUid;

  ExtensionInfo() : mediaSourceType(agora::media::UNKNOWN_MEDIA_SOURCE), remoteUid(0), channelId(NULL), localUid(0) {}
};

class IMediaPlayer;
class IMediaRecorder;

/**
 * The IRtcEngine class, which is the basic interface of the Agora SDK that implements the core functions of real-time communication.
 *
 * `IRtcEngine` provides the main methods that your app can call.
 *
 */
class IRtcEngine : public agora::base::IEngineBase {
 public:
  /**
   * Releases the IRtcEngine object.
   *
   * This method releases all resources used by the Agora SDK. Use this method for apps in which users
   * occasionally make voice or video calls. When users do not make calls, you can free up resources for
   * other operations.
   *
   * After a successful method call, you can no longer use any method or callback in the SDK anymore.
   * If you want to use the real-time communication functions again, you must call `createAgoraRtcEngine`
   * and `initialize` to create a new `IRtcEngine` instance.
   *
   * @note If you want to create a new `IRtcEngine` instance after destroying the current one, ensure
   * that you wait till the `release` method execution to complete.
   *
   * @param sync Determines whether this method is a synchronous call.
   * - `true`: This method is a synchronous call, which means that the result of this method call
   * returns after the IRtcEngine object resources are released. Do not call this method
   * in any callback generated by the SDK, or it may result in a deadlock.
   * - `false`: This method is an asynchronous call. The result returns immediately even when the
   * IRtcEngine object resources are not released.
   *
   */
  AGORA_CPP_API static void release(bool sync = false);

  /**
   * Initializes `IRtcEngine`.
   *
   * All called methods provided by the `IRtcEngine` class are executed asynchronously. Agora
   * recommends calling these methods in the same thread.
   *
   * @note
   * - Before calling other APIs, you must call `createAgoraRtcEngine` and `initialize `to create and
   * initialize the `IRtcEngine` object.
   * - The SDK supports creating only one `IRtcEngine` instance for an app.
   *
   * @param context The RtcEngineContext object.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int initialize(const RtcEngineContext& context) = 0;

  /**
   * Gets the pointer to the specified interface.
   *
   * @param iid The ID of the interface. See #INTERFACE_ID_TYPE for details.
   * @param inter Output parameter. The pointer to the specified interface.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int queryInterface(INTERFACE_ID_TYPE iid, void** inter) = 0;


  /**
   * Gets the SDK version.
   * @param build The build number.
   * @return The version of the current SDK in the string format.
   */
  virtual const char* getVersion(int* build) = 0;

  /**
   * Gets the warning or error description.
   * @param code The error code or warning code reported by the SDK.
   * @return The specific error or warning description.
   */
  virtual const char* getErrorDescription(int code) = 0;

  /**
   * Queries the capacity of the current device codec.
   *
   * @param codec_info An array of the codec cap information: CodecCapInfo.
   * @param size The array size.
   * @return 
   * 0: Success.
   * < 0: Failure.
   */
  virtual int queryCodecCapability(CodecCapInfo* codecInfo, int& size) = 0;

    /**
   * Queries the score of the current device.
   *
   * @return 
   * > 0: If the value is greater than 0, it means that the device score has been retrieved and represents the score value.
   * Most devices score between 60-100, with higher scores indicating better performance.
   * 
   * < 0: Failure.
   */
  virtual int queryDeviceScore() = 0;

  /**
   * Preload a channel.
   *
   * This method enables users to preload a channel.
   *
   * A successful call of this method will reduce the time of joining the same channel.
   *
   * Note:
   *  1. The SDK supports preloading up to 20 channels. Once the preloaded channels exceed the limit, the SDK will keep the latest 20 available.
   *  2. Renew the token of the preloaded channel by calling this method with the same 'channelId' and 'uid'.
   *
   * @param token The token generated on your server for authentication.
   * @param channelId The channel name. This parameter signifies the channel in which users engage in
   * real-time audio and video interaction. Under the premise of the same App ID, users who fill in
   * the same channel ID enter the same channel for audio and video interaction. The string length
   * must be less than 64 bytes. Supported character scopes are:
   * - All lowercase English letters: a to z.
   * - All uppercase English letters: A to Z.
   * - All numeric characters: 0 to 9.
   * - The space character.
   * - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-",
   * ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
   * @param uid The user ID. This parameter is used to identify the user in the channel for real-time
   * audio and video interaction. You need to set and manage user IDs yourself, and ensure that each
   * user ID in the same channel is unique. This parameter is a 32-bit unsigned integer. The value
   * range is 1 to 2<h>32</h>-1. If the user ID is not assigned (or set to 0), the SDK assigns a random user
   * ID and returns it in the onJoinChannelSuccess callback. Your application must record and maintain
   * the returned user ID, because the SDK does not do so.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *   - -7: The IRtcEngine object has not been initialized. You need to initialize the IRtcEngine
   * object before calling this method.
   *   - -102: The channel name is invalid. You need to pass in a valid channel name in channelId to
   * preload the channel again.
   */
  virtual int preloadChannel(const char* token, const char* channelId, uid_t uid) = 0;

  /**
   * Preload a channel.
   *
   * This method enables users to preload a channel.
   *
   * A successful call of this method will reduce the time of joining the same channel.
   *
   * Note:
   *  1. The SDK supports preloading up to 20 channels. Once the preloaded channels exceed the limit, the SDK will keep the latest 20 available.
   *  2. Renew the token of the preloaded channel by calling this method with the same 'channelId' and 'userAccount'.
   *
   * @param token The token generated on your server for authentication.
   * @param channelId The channel name. This parameter signifies the channel in which users engage in
   * real-time audio and video interaction. Under the premise of the same App ID, users who fill in
   * the same channel ID enter the same channel for audio and video interaction. The string length
   * must be less than 64 bytes. Supported character scopes are:
   * - All lowercase English letters: a to z.
   * - All uppercase English letters: A to Z.
   * - All numeric characters: 0 to 9.
   * - The space character.
   * - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-",
   * ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
   * @param userAccount The user account. The maximum length of this parameter is 255 bytes. Ensure that you set this parameter and do not set it as null. Supported character scopes are:
   * - All lowercase English letters: a to z.
   * - All uppercase English letters: A to Z.
   * - All numeric characters: 0 to 9.
   * - The space character.
   * - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *   - -2: The parameter is invalid. For example, the userAccount parameter is empty.
   * You need to pass in a valid parameter and preload the channel again.
   *   - -7: The IRtcEngine object has not been initialized. You need to initialize the IRtcEngine
   * object before calling this method.
   *   - -102: The channel name is invalid. You need to pass in a valid channel name in channelId to
   * preload the channel again.
   */
  virtual int preloadChannelWithUserAccount(const char* token, const char* channelId, const char* userAccount) = 0;

  /**
   * Update token of the preloaded channels.
   *
   * An easy way to update all preloaded channels' tokens, if all preloaded channels use the same token.
   *
   * If preloaded channels use different tokens, we need to call the 'preloadChannel' method with the same 'channelId'
   * and 'uid' or 'userAccount' to update the corresponding token.
   *
   * @param token The token generated on your server for authentication.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *   - -2: The token is invalid. You need to pass in a valid token and update the token again.
   *   - -7: The IRtcEngine object has not been initialized. You need to initialize the IRtcEngine
   * object before calling this method.
   */
  virtual int updatePreloadChannelToken(const char* token) = 0;

  /**
   * Joins a channel.
   *
   * This method enables users to join a channel. Users in the same channel can talk to each other,
   * and multiple users in the same channel can start a group chat. Users with different App IDs
   * cannot call each other.
   *
   * A successful call of this method triggers the following callbacks:
   * - The local client: The `onJoinChannelSuccess` and `onConnectionStateChanged` callbacks.
   * - The remote client: `onUserJoined`, if the user joining the channel is in the Communication
   * profile or is a host in the Live-broadcasting profile.
   *
   * When the connection between the client and Agora's server is interrupted due to poor network
   * conditions, the SDK tries reconnecting to the server. When the local client successfully rejoins
   * the channel, the SDK triggers the `onRejoinChannelSuccess` callback on the local client.
   *
   * @note Once a user joins the channel, the user subscribes to the audio and video streams of all
   * the other users in the channel by default, giving rise to usage and billing calculation. To
   * stop subscribing to a specified stream or all remote streams, call the corresponding `mute` methods.
   *
   * @param token The token generated on your server for authentication.
   * @param channelId The channel name. This parameter signifies the channel in which users engage in
   * real-time audio and video interaction. Under the premise of the same App ID, users who fill in
   * the same channel ID enter the same channel for audio and video interaction. The string length
   * must be less than 64 bytes. Supported character scopes are:
   * - All lowercase English letters: a to z.
   * - All uppercase English letters: A to Z.
   * - All numeric characters: 0 to 9.
   * - The space character.
   * - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-",
   * ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
   * @param info (Optional) Reserved for future use.
   * @param uid The user ID. This parameter is used to identify the user in the channel for real-time
   * audio and video interaction. You need to set and manage user IDs yourself, and ensure that each
   * user ID in the same channel is unique. This parameter is a 32-bit unsigned integer. The value
   * range is 1 to 2<h>32</h>-1. If the user ID is not assigned (or set to 0), the SDK assigns a random user
   * ID and returns it in the onJoinChannelSuccess callback. Your application must record and maintain
   * the returned user ID, because the SDK does not do so.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *   - -2: The parameter is invalid. For example, the token is invalid, the uid parameter is not set
   * to an integer, or the value of a member in the `ChannelMediaOptions` structure is invalid. You need
   * to pass in a valid parameter and join the channel again.
   *   - -3: Failes to initialize the `IRtcEngine` object. You need to reinitialize the IRtcEngine object.
   *   - -7: The IRtcEngine object has not been initialized. You need to initialize the IRtcEngine
   * object before calling this method.
   *   - -8: The internal state of the IRtcEngine object is wrong. The typical cause is that you call
   * this method to join the channel without calling `stopEchoTest` to stop the test after calling
   * `startEchoTest` to start a call loop test. You need to call `stopEchoTest` before calling this method.
   *   - -17: The request to join the channel is rejected. The typical cause is that the user is in the
   * channel. Agora recommends using the `onConnectionStateChanged` callback to get whether the user is
   * in the channel. Do not call this method to join the channel unless you receive the
   * `CONNECTION_STATE_DISCONNECTED(1)` state.
   *   - -102: The channel name is invalid. You need to pass in a valid channel name in channelId to
   * rejoin the channel.
   *   - -121: The user ID is invalid. You need to pass in a valid user ID in uid to rejoin the channel.
   */
  virtual int joinChannel(const char* token, const char* channelId, const char* info, uid_t uid) = 0;

  /**
   * Joins a channel with media options.
   *
   * This method enables users to join a channel. Users in the same channel can talk to each other,
   * and multiple users in the same channel can start a group chat. Users with different App IDs
   * cannot call each other.
   *
   * A successful call of this method triggers the following callbacks:
   * - The local client: The `onJoinChannelSuccess` and `onConnectionStateChanged` callbacks.
   * - The remote client: `onUserJoined`, if the user joining the channel is in the Communication
   * profile or is a host in the Live-broadcasting profile.
   *
   * When the connection between the client and Agora's server is interrupted due to poor network
   * conditions, the SDK tries reconnecting to the server. When the local client successfully rejoins
   * the channel, the SDK triggers the `onRejoinChannelSuccess` callback on the local client.
   *
   * Compared to `joinChannel`, this method adds the options parameter to configure whether to
   * automatically subscribe to all remote audio and video streams in the channel when the user
   * joins the channel. By default, the user subscribes to the audio and video streams of all
   * the other users in the channel, giving rise to usage and billings. To unsubscribe, set the
   * `options` parameter or call the `mute` methods accordingly.
   *
   * @note
   * - This method allows users to join only one channel at a time.
   * - Ensure that the app ID you use to generate the token is the same app ID that you pass in the
   * `initialize` method; otherwise, you may fail to join the channel by token.
   *
   * @param token The token generated on your server for authentication.
   *
   * @param channelId The channel name. This parameter signifies the channel in which users engage in
   * real-time audio and video interaction. Under the premise of the same App ID, users who fill in
   * the same channel ID enter the same channel for audio and video interaction. The string length
   * must be less than 64 bytes. Supported character scopes are:
   * - All lowercase English letters: a to z.
   * - All uppercase English letters: A to Z.
   * - All numeric characters: 0 to 9.
   * - The space character.
   * - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-",
   * ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
   * @param uid The user ID. This parameter is used to identify the user in the channel for real-time
   * audio and video interaction. You need to set and manage user IDs yourself, and ensure that each
   * user ID in the same channel is unique. This parameter is a 32-bit unsigned integer. The value
   * range is 1 to 2<h>32</h>-1. If the user ID is not assigned (or set to 0), the SDK assigns a random user
   * ID and returns it in the `onJoinChannelSuccess` callback. Your application must record and maintain
   * the returned user ID, because the SDK does not do so.
   * @param options The channel media options: ChannelMediaOptions.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *   - -2: The parameter is invalid. For example, the token is invalid, the uid parameter is not set
   * to an integer, or the value of a member in the `ChannelMediaOptions` structure is invalid. You need
   * to pass in a valid parameter and join the channel again.
   *   - -3: Failes to initialize the `IRtcEngine` object. You need to reinitialize the IRtcEngine object.
   *   - -7: The IRtcEngine object has not been initialized. You need to initialize the IRtcEngine
   * object before calling this method.
   *   - -8: The internal state of the IRtcEngine object is wrong. The typical cause is that you call
   * this method to join the channel without calling `stopEchoTest` to stop the test after calling
   * `startEchoTest` to start a call loop test. You need to call `stopEchoTest` before calling this method.
   *   - -17: The request to join the channel is rejected. The typical cause is that the user is in the
   * channel. Agora recommends using the `onConnectionStateChanged` callback to get whether the user is
   * in the channel. Do not call this method to join the channel unless you receive the
   * `CONNECTION_STATE_DISCONNECTED(1)` state.
   *   - -102: The channel name is invalid. You need to pass in a valid channel name in channelId to
   * rejoin the channel.
   *   - -121: The user ID is invalid. You need to pass in a valid user ID in uid to rejoin the channel.
   */
  virtual int joinChannel(const char* token, const char* channelId, uid_t uid, const ChannelMediaOptions& options) = 0;

  /**
   *  Updates the channel media options after joining the channel.
   *
   * @param options The channel media options: ChannelMediaOptions.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int updateChannelMediaOptions(const ChannelMediaOptions& options) = 0;

  /**
   * Leaves the channel.
   *
   * This method allows a user to leave the channel, for example, by hanging up or exiting a call.
   *
   * This method is an asynchronous call, which means that the result of this method returns even before
   * the user has not actually left the channel. Once the user successfully leaves the channel, the
   * SDK triggers the \ref IRtcEngineEventHandler::onLeaveChannel "onLeaveChannel" callback.
   *
   * @note
   * If you call \ref release "release" immediately after this method, the leaveChannel process will be
   * interrupted, and the SDK will not trigger the `onLeaveChannel` callback.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int leaveChannel() = 0;

  /**
   * Leaves the channel.
   *
   * @param options The leave channel options.
   *
   * This method allows a user to leave the channel, for example, by hanging up or exiting a call.
   *
   * This method is an asynchronous call, which means that the result of this method returns even before
   * the user has not actually left the channel. Once the user successfully leaves the channel, the
   * SDK triggers the \ref IRtcEngineEventHandler::onLeaveChannel "onLeaveChannel" callback.
   *
   * @note
   * If you call \ref release "release" immediately after this method, the leaveChannel process will be
   * interrupted, and the SDK will not trigger the `onLeaveChannel` callback.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int leaveChannel(const LeaveChannelOptions& options) = 0;

  /**
   * Renews the token.
   *
   * Once a token is enabled and used, it expires after a certain period of time.
   *
   * Under the following circumstances, generate a new token on your server, and then call this method to
   * renew it. Failure to do so results in the SDK disconnecting from the server.
   * - The \ref IRtcEngineEventHandler onTokenPrivilegeWillExpire "onTokenPrivilegeWillExpire" callback is triggered;
   * - The \ref IRtcEngineEventHandler::onRequestToken "onRequestToken" callback is triggered;
   * - The `ERR_TOKEN_EXPIRED(-109)` error is reported.
   *
   * @param token The new token.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int renewToken(const char* token) = 0;

  /**
   * Sets the channel profile.
   *
   * The IRtcEngine differentiates channel profiles and applies different optimization algorithms accordingly.
   * For example, it prioritizes smoothness and low latency for a video call, and prioritizes video quality
   * for a video broadcast.
   *
   * @note
   * - To ensure the quality of real-time communication, we recommend that all users in a channel use the
   * same channel profile.
   * - Call this method before calling `joinChannel`. You cannot set the channel profile
   * once you have joined the channel.
   *
   * @param profile The channel profile: #CHANNEL_PROFILE_TYPE.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *  - -8(ERR_INVALID_STATE): The current status is invalid, only allowed to be called when the connection is disconnected.
   */
  virtual int setChannelProfile(CHANNEL_PROFILE_TYPE profile) = 0;

  /**
   * Sets the role of a user.
   *
   * This method sets the user role as either BROADCASTER or AUDIENCE (default).
   * - The broadcaster sends and receives streams.
   * - The audience receives streams only.
   *
   * By default, all users are audience regardless of the channel profile.
   * Call this method to change the user role to BROADCASTER so that the user can
   * send a stream.
   *
   * @note
   * After calling the setClientRole() method to CLIENT_ROLE_AUDIENCE, the SDK stops audio recording.
   * However, CLIENT_ROLE_AUDIENCE will keep audio recording with AUDIO_SCENARIO_CHATROOM(5).
   * Normally, app developer can also use mute api to achieve the same result, and we implement
   * this 'non-orthogonal' behavior only to make API backward compatible.
   *
   * @param role The role of the client: #CLIENT_ROLE_TYPE.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setClientRole(CLIENT_ROLE_TYPE role) = 0;

  /** Sets the role of the user, such as a host or an audience (default), before joining a channel in the live interactive streaming.
    *
    * This method can be used to switch the user role in the live interactive streaming after the user joins a channel.
    *
    * In the `LIVE_BROADCASTING` profile, when a user switches user roles after joining a channel, a successful \ref agora::rtc::IRtcEngine::setClientRole "setClientRole" method call triggers the following callbacks:
    * - The local client: \ref agora::rtc::IRtcEngineEventHandler::onClientRoleChanged "onClientRoleChanged"
    * - The remote client: \ref agora::rtc::IRtcEngineEventHandler::onUserJoined "onUserJoined" or \ref agora::rtc::IRtcEngineEventHandler::onUserOffline "onUserOffline" (BECOME_AUDIENCE)
    *
    * @note
    * This method applies only to the `LIVE_BROADCASTING` profile.
    *
    * @param role Sets the role of the user. See #CLIENT_ROLE_TYPE.
    * @param options Sets the audience latency level of the user. See #ClientRoleOptions.
    *
    * @return
    * - 0(ERR_OK): Success.
    * - < 0: Failure.
    *  - -1(ERR_FAILED): A general error occurs (no specified reason).
    *  - -2(ERR_INALID_ARGUMENT): The parameter is invalid.
    *  - -7(ERR_NOT_INITIALIZED): The SDK is not initialized.
    *  - -8(ERR_INVALID_STATE): The channel profile is not `LIVE_BROADCASTING`.
    */
  virtual int setClientRole(CLIENT_ROLE_TYPE role, const ClientRoleOptions& options) = 0;

  /** Starts a video call test.
   *
   * @param config: configuration for video call test.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int startEchoTest(const EchoTestConfiguration& config) = 0;

  /** Stops the audio call test.
  @return int

  - 0: Success.
  - < 0: Failure.
  */
  virtual int stopEchoTest() = 0;

#if defined(__APPLE__) && TARGET_OS_IOS
  /** Enables the SDK use AVCaptureMultiCamSession or AVCaptureSession. Applies to iOS 13.0+ only.
   * @param enabled Whether to enable multi-camera when capturing video:
   * - true: Enable multi-camera, and the SDK uses AVCaptureMultiCamSession.
   * - false: Disable multi-camera, and the SDK uses AVCaptureSession.
   * @param config The config for secondary camera capture session. See #CameraCapturerConfiguration.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int enableMultiCamera(bool enabled, const CameraCapturerConfiguration& config) = 0;
#endif
  /**
   * Enables the video.
   *
   * You can call this method either before joining a channel or during a call.
   * If you call this method before entering a channel, the service starts the video; if you call it
   * during a call, the audio call switches to a video call.
   *
   * @note
   * This method controls the underlying states of the Engine. It is still
   * valid after one leaves the channel.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int enableVideo() = 0;

  /**
   * Disables the video.
   *
   * This method stops capturing the local video and receiving any remote video.
   * To enable the local preview function, call \ref enableLocalVideo "enableLocalVideo" (true).
   * @return int
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int disableVideo() = 0;

  /**
   * Starts the local video preview before joining a channel.
   *
   * Once you call this method to start the local video preview, if you leave
   * the channel by calling \ref leaveChannel "leaveChannel", the local video preview remains until
   * you call \ref stopPreview "stopPreview" to disable it.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int startPreview() = 0;

  /**
   * Starts the local video preview for specific source type.
   * @param sourceType - The video source type.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int startPreview(VIDEO_SOURCE_TYPE sourceType) = 0;

  /**
   * Stops the local video preview and the video.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int stopPreview() = 0;

  /**
   * Stops the local video preview for specific source type.
   * @param sourceType - The video source type.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int stopPreview(VIDEO_SOURCE_TYPE sourceType) = 0;

  /** Starts the last-mile network probe test.

  This method starts the last-mile network probe test before joining a channel
  to get the uplink and downlink last-mile network statistics, including the
  bandwidth, packet loss, jitter, and round-trip time (RTT).

  Call this method to check the uplink network quality before users join a
  channel or before an audience switches to a host. Once this method is
  enabled, the SDK returns the following callbacks:
  - \ref IRtcEngineEventHandler::onLastmileQuality "onLastmileQuality": the
  SDK triggers this callback depending on the network
  conditions. This callback rates the network conditions and is more closely
  linked to the user experience.
  - \ref IRtcEngineEventHandler::onLastmileProbeResult "onLastmileProbeResult":
  the SDK triggers this callback within 30 seconds depending on the network
  conditions. This callback returns the real-time statistics of the network
  conditions and is more objective.

  @note
  - Do not call other methods before receiving the
  \ref IRtcEngineEventHandler::onLastmileQuality "onLastmileQuality" and
  \ref IRtcEngineEventHandler::onLastmileProbeResult "onLastmileProbeResult"
  callbacks. Otherwise, the callbacks may be interrupted.
  - In the Live-broadcast profile, a host should not call this method after
  joining a channel.

  @param config Sets the configurations of the last-mile network probe test. See
  LastmileProbeConfig.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int startLastmileProbeTest(const LastmileProbeConfig& config) = 0;

  /** Stops the last-mile network probe test. */
  virtual int stopLastmileProbeTest() = 0;

  /**
   * Sets the video encoder configuration.
   *
   * Each configuration profile corresponds to a set of video parameters, including
   * the resolution, frame rate, and bitrate.
   *
   * The parameters specified in this method are the maximum values under ideal network conditions.
   * If the video engine cannot render the video using the specified parameters due
   * to poor network conditions, the parameters further down the list are considered
   * until a successful configuration is found.
   *
   * @param config The local video encoder configuration: VideoEncoderConfiguration.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setVideoEncoderConfiguration(const VideoEncoderConfiguration& config) = 0;

  /** Enables/Disables image enhancement and sets the options.
   *
   * @note Call this method after calling the \ref IRtcEngine::enableVideo "enableVideo" method.
   *
   * @param enabled Sets whether or not to enable image enhancement:
   * - true: enables image enhancement.
   * - false: disables image enhancement.
   * @param options Sets the image enhancement option. See BeautyOptions.
   */
  virtual int setBeautyEffectOptions(bool enabled, const BeautyOptions& options, agora::media::MEDIA_SOURCE_TYPE type = agora::media::PRIMARY_CAMERA_SOURCE) = 0;
  /** Enables/Disables face shape and sets the beauty options.
   *
   * @note Call this method after calling the \ref IRtcEngine::enableVideo "enableVideo" method.
   *
   * @param enabled Sets whether or not to enable face shape:
   * - true: enables face shape.
   * - false: disables face shape.
   * @param options Sets the face shape beauty option. See FaceShapeBeautyOptions.
   */
  virtual int setFaceShapeBeautyOptions(bool enabled, const FaceShapeBeautyOptions& options, agora::media::MEDIA_SOURCE_TYPE type = agora::media::PRIMARY_CAMERA_SOURCE) = 0;
  /** Enables/Disables face shape and sets the area options.
   *
   * @note Call this method after calling the \ref IRtcEngine::setFaceShapeBeautyOptions "setFaceShapeBeautyOptions" method.
   *
   * @param options Sets the face shape area option. See FaceShapeAreaOptions.
   */
  virtual int setFaceShapeAreaOptions(const FaceShapeAreaOptions& options, agora::media::MEDIA_SOURCE_TYPE type = agora::media::PRIMARY_CAMERA_SOURCE) = 0;
  
  /** Gets the face shape beauty options.
   *
   * @note Call this method after calling the \ref IRtcEngine::enableVideo "enableVideo" method.
   *
   * @param options Gets the face shape beauty option. See FaceShapeBeautyOptions.
   */
  virtual int getFaceShapeBeautyOptions(FaceShapeBeautyOptions& options, agora::media::MEDIA_SOURCE_TYPE type = agora::media::PRIMARY_CAMERA_SOURCE) = 0;
  
  /** Gets the face shape area options.
   *
   * @note Call this method after calling the \ref IRtcEngine::enableVideo "enableVideo" method.
   *
   * @param shapeArea  The face area. See FaceShapeAreaOptions::FACE_SHAPE_AREA.
   * @param options Gets the face area beauty option. See FaceShapeAreaOptions.
   */
  virtual int getFaceShapeAreaOptions(agora::rtc::FaceShapeAreaOptions::FACE_SHAPE_AREA shapeArea, FaceShapeAreaOptions& options, agora::media::MEDIA_SOURCE_TYPE type = agora::media::PRIMARY_CAMERA_SOURCE) = 0;
  
  /**
   * Sets low-light enhancement.
   *
   * @since v4.0.0
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
   * @param options The low-light enhancement options. See LowlightEnhanceOptions.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setLowlightEnhanceOptions(bool enabled, const LowlightEnhanceOptions& options, agora::media::MEDIA_SOURCE_TYPE type = agora::media::PRIMARY_CAMERA_SOURCE) = 0;
  /**
   * Sets video noise reduction.
   *
   * @since v4.0.0
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
  virtual int setVideoDenoiserOptions(bool enabled, const VideoDenoiserOptions& options, agora::media::MEDIA_SOURCE_TYPE type = agora::media::PRIMARY_CAMERA_SOURCE) = 0;
  /**
   * Sets color enhancement.
   *
   * @since v4.0.0
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
  virtual int setColorEnhanceOptions(bool enabled, const ColorEnhanceOptions& options, agora::media::MEDIA_SOURCE_TYPE type = agora::media::PRIMARY_CAMERA_SOURCE) = 0;

  /**
   * Enables/Disables the virtual background. (beta function)
   *
   * @since v3.7.200
   *
   * After enabling the virtual background function, you can replace the original background image of the local user
   * with a custom background image. After the replacement, all users in the channel can see the custom background
   * image.
   *
   * @note
   * - Before calling this method, ensure that you have integrated the
   * `libagora_segmentation_extension.dll` (Windows)/`AgoraVideoSegmentationExtension.framework` (macOS) dynamic
   * library into the project folder.
   * - Call this method after \ref IRtcEngine::enableVideo "enableVideo".
   * - This function requires a high-performance device. Agora recommends that you use this function on devices with
   * an i5 CPU and better.
   * - Agora recommends that you use this function in scenarios that meet the following conditions:
   *  - A high-definition camera device is used, and the environment is uniformly lit.
   *  - The captured video image is uncluttered, the user's portrait is half-length and largely unobstructed, and the
   * background is a single color that differs from the color of the user's clothing.
   *
   * @param enabled Sets whether to enable the virtual background:
   * - true: Enable.
   * - false: Disable.
   * @param backgroundSource The custom background image. See VirtualBackgroundSource. **Note**: To adapt the
   * resolution of the custom background image to the resolution of the SDK capturing video, the SDK scales and crops
   * the custom background image while ensuring that the content of the custom background image is not distorted.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int enableVirtualBackground(bool enabled, VirtualBackgroundSource backgroundSource, SegmentationProperty segproperty, agora::media::MEDIA_SOURCE_TYPE type = agora::media::PRIMARY_CAMERA_SOURCE) = 0;

  /**
   * Initializes the video view of a remote user.
   *
   * This method initializes the video view of a remote stream on the local device. It affects only the
   * video view that the local user sees.
   *
   * Usually the app should specify the `uid` of the remote video in the method call before the
   * remote user joins the channel. If the remote `uid` is unknown to the app, set it later when the
   * app receives the \ref IRtcEngineEventHandler::onUserJoined "onUserJoined" callback.
   *
   * To unbind the remote user from the view, set `view` in VideoCanvas as `null`.
   *
   * @note
   * Ensure that you call this method in the UI thread.
   *
   * @param canvas The remote video view settings: VideoCanvas.
   * @return int
   *  VIRTUAL_BACKGROUND_SOURCE_STATE_REASON_SUCCESS = 0,
   *  VIRTUAL_BACKGROUND_SOURCE_STATE_REASON_IMAGE_NOT_EXIST = -1,
   *  VIRTUAL_BACKGROUND_SOURCE_STATE_REASON_COLOR_FORMAT_NOT_SUPPORTED = -2,
   *  VIRTUAL_BACKGROUND_SOURCE_STATE_REASON_DEVICE_NOT_SUPPORTED = -3,
   */
  virtual int setupRemoteVideo(const VideoCanvas& canvas) = 0;

  /**
   * Initializes the local video view.
   *
   * This method initializes the video view of the local stream on the local device. It affects only
   * the video view that the local user sees, not the published local video stream.
   *
   * To unbind the local video from the view, set `view` in VideoCanvas as `null`.
   *
   * @note
   * Call this method before joining a channel.
   *
   * @param canvas The local video view setting: VideoCanvas.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setupLocalVideo(const VideoCanvas& canvas) = 0;

  /**
   * Sets the Video application scenario.
   *
   * @since v4.2.0
   *
   * You can call this method to set the expected video scenario.
   * The SDK will optimize the video experience for each scenario you set.
   *
   *
   * @param scenarioType The video application scenario. See #ApplicationScenarioType.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   * - ERR_FAILED (1): A general error occurs (no specified reason).
   * - ERR_NOT_SUPPORTED (4): Unable to set video application scenario.
   * - ERR_NOT_INITIALIZED (7): The SDK is not initialized.
   */
  virtual int setVideoScenario(VIDEO_APPLICATION_SCENARIO_TYPE scenarioType) = 0;

    /**
   * Sets the video qoe preference.
   *
   * @since v4.2.1
   *
   * You can call this method to set the expected QoE Preference.
   * The SDK will optimize the video experience for each preference you set.
   *
   *
   * @param qoePreference The qoe preference type. See #VIDEO_QOE_PREFERENCE_TYPE.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   * - ERR_FAILED (1): A general error occurs (no specified reason).
   * - ERR_NOT_SUPPORTED (4): Unable to set video application scenario.
   * - ERR_NOT_INITIALIZED (7): The SDK is not initialized.
   */
  virtual int setVideoQoEPreference(VIDEO_QOE_PREFERENCE_TYPE qoePreference) = 0;

  /**
   * Enables the audio.
   *
   * The audio is enabled by default.
   *
   * @note
   * This method controls the underlying states of the Engine. It is still
   * valid after one leaves channel.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int enableAudio() = 0;

  /**
   * Disables the audio.
   *
   * @note
   * This method controls the underlying states of the Engine. It is still
   * valid after one leaves channel.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int disableAudio() = 0;
  
  /**
   * Sets the audio parameters and application scenarios.
   *
   * @deprecated This method is deprecated. You can use the
   * \ref IRtcEngine::setAudioProfile(AUDIO_PROFILE_TYPE) "setAudioProfile"
   * method instead. To set the audio scenario, call the \ref IRtcEngine::initialize "initialize"
   * method and pass value in the `audioScenario` member in the RtcEngineContext struct.
   *
   * @note
   * - Call this method before calling the `joinChannel` method.
   * - In scenarios requiring high-quality audio, we recommend setting `profile` as `MUSIC_HIGH_QUALITY`(4)
   * and `scenario` as `AUDIO_SCENARIO_GAME_STREAMING`(3).
   *
   * @param profile Sets the sample rate, bitrate, encoding mode, and the number of channels:
   * #AUDIO_PROFILE_TYPE.
   * @param scenario Sets the audio application scenarios: #AUDIO_SCENARIO_TYPE.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setAudioProfile(AUDIO_PROFILE_TYPE profile, AUDIO_SCENARIO_TYPE scenario) __deprecated = 0;

  /**
   * Sets the audio profile.
   *
   * @note
   * - Call this method before calling the `joinChannel` method.
   * - In scenarios requiring high-quality audio, Agora recommends setting `profile` as `MUSIC_HIGH_QUALITY`(4).
   * - To set the audio scenario, call the \ref IRtcEngine::initialize "initialize"
   * method and pass value in the `audioScenario` member in the RtcEngineContext struct.
   *
   * @param profile The audio profile, such as the sample rate, bitrate and codec type: #AUDIO_PROFILE_TYPE.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setAudioProfile(AUDIO_PROFILE_TYPE profile) = 0;
  /**
   * Set the audio scenario.
   *
   * @param scenario The audio scenario: #AUDIO_SCENARIO_TYPE.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setAudioScenario(AUDIO_SCENARIO_TYPE scenario) = 0;
  /**
   * Enables or disables the local audio capture.
   *
   * The audio function is enabled by default. This method disables or re-enables the
   * local audio function, that is, to stop or restart local audio capture and
   * processing.
   *
   * This method does not affect receiving or playing the remote audio streams,
   * and `enableLocalAudio` (false) is applicable to scenarios where the user wants
   * to receive remote audio streams without sending any audio stream to other users
   * in the channel.
   *
   * @param enabled Determines whether to disable or re-enable the local audio function:
   * - true: (Default) Re-enable the local audio function, that is, to start local
   * audio capture and processing.
   * - false: Disable the local audio function, that is, to stop local audio
   * capture and processing.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int enableLocalAudio(bool enabled) = 0;

  /**
   Stops or resumes sending the local audio stream.

   After calling this method successfully, the SDK triggers the
   \ref IRtcEngineEventHandler::onRemoteAudioStateChanged "onRemoteAudioStateChanged"
   callback with the following parameters:
   - REMOTE_AUDIO_STATE_STOPPED(0) and REMOTE_AUDIO_REASON_REMOTE_MUTED(5).
   - REMOTE_AUDIO_STATE_DECODING(2) and REMOTE_AUDIO_REASON_REMOTE_UNMUTED(6).

   @note
   - When `mute` is set as `true`, this method does not disable the
   microphone, which does not affect any ongoing recording.
   - If you call \ref IRtcEngine::setChannelProfile "setChannelProfile" after
   this method, the SDK resets whether or not to mute the local audio
   according to the channel profile and user role. Therefore, we recommend
   calling this method after the `setChannelProfile` method.

   @param mute Determines whether to send or stop sending the local audio stream:
   - true: Stop sending the local audio stream.
   - false: (Default) Send the local audio stream.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int muteLocalAudioStream(bool mute) = 0;

  /**
   Stops or resumes receiving all remote audio stream.

   This method works for all remote users that join or will join a channel
   using the `joinChannel` method. It is
   equivalent to the `autoSubscribeAudio` member in the ChannelMediaOptions
   class.
   - Ensure that you call this method after joining a channel.
   - If you call muteAllRemoteAudioStreams(true) after joining a channel, the
   local use stops receiving any audio stream from any user in the channel,
   including any user who joins the channel after you call this method.
   - If you call muteAllRemoteAudioStreams(true) after leaving a channel, the
   local user does not receive any audio stream the next time the user joins a
   channel.

   After you successfully call muteAllRemoteAudioStreams(true), you can take
   the following actions:
   - To resume receiving all remote audio streams, call
   muteAllRemoteAudioStreams(false).
   - To resume receiving the audio stream of a specified user, call
   muteRemoteAudioStream(uid, false), where uid is the ID of the user whose
   audio stream you want to resume receiving.

   @note
   - The result of calling this method is affected by calling
   \ref IRtcEngine::enableAudio "enableAudio" and
   \ref IRtcEngine::disableAudio "disableAudio". Settings in
   muteAllRemoteAudioStreams stop taking effect if either of the following occurs:
     - Calling `enableAudio` after muteAllRemoteAudioStreams(true).
     - Calling `disableAudio` after muteAllRemoteAudioStreams(false).
   - This method only works for the channel created by calling
   `joinChannel`. To set whether to receive remote
   audio streams for a specific channel, Agora recommends using
   `autoSubscribeAudio` in the ChannelMediaOptions class.
   @param mute Whether to stop receiving remote audio streams:
   - true: Stop receiving any remote audio stream.
   - false: (Default) Resume receiving all remote audio streams.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int muteAllRemoteAudioStreams(bool mute) = 0;

  /**
   * Stops or resumes receiving the audio stream of a specified user.
   *
   * @note
   * You can call this method before or after joining a channel. If a user
   * leaves a channel, the settings in this method become invalid.
   *
   * @param uid The ID of the specified user.
   * @param mute Whether to stop receiving the audio stream of the specified user:
   * - true: Stop receiving the audio stream of the specified user.
   * - false: (Default) Resume receiving the audio stream of the specified user.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int muteRemoteAudioStream(uid_t uid, bool mute) = 0;

  /**
   * Stops or resumes sending the local video stream.
   *
   * @param mute Determines whether to send or stop sending the local video stream:
   * - true: Stop sending the local video stream.
   * - false: (Default) Send the local video stream.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int muteLocalVideoStream(bool mute) = 0;

  /**
   * Disables or re-enables the local video capture.
   *
   * Once you enable the video using \ref enableVideo "enableVideo", the local video is enabled
   * by default. This method disables or re-enables the local video capture.
   *
   * `enableLocalVideo(false)` applies to scenarios when the user wants to watch the remote video
   * without sending any video stream to the other user.
   *
   * @note
   * Call this method after `enableVideo`. Otherwise, this method may not work properly.
   *
   * @param enabled Determines whether to disable or re-enable the local video, including
   * the capturer, renderer, and sender:
   * - true:  (Default) Re-enable the local video.
   * - false: Disable the local video. Once the local video is disabled, the remote
   * users can no longer receive the video stream of this user, while this user
   * can still receive the video streams of other remote users. When you set
   * `enabled` as `false`, this method does not require a local camera.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int enableLocalVideo(bool enabled) = 0;

  /** Stops or resumes receiving all remote video streams.

   This method works for all remote users that join or will join a channel
   using the `joinChannel` method. It is
   equivalent to the `autoSubscribeVideo` member in the ChannelMediaOptions
   class.
   - Ensure that you call this method after joining a channel.
   - If you call muteAllRemoteVideoStreams(true) after joining a channel, the
   local use stops receiving any video stream from any user in the channel,
   including any user who joins the channel after you call this method.
   - If you call muteAllRemoteVideoStreams(true) after leaving a channel,
   the local user does not receive any video stream the next time the user
   joins a channel.

   After you successfully call muteAllRemoteVideoStreams(true), you can take
   the following actions:
   - To resume receiving all remote video streams, call
   muteAllRemoteVideoStreams(false).
   - To resume receiving the video stream of a specified user, call
   muteRemoteVideoStream(uid, false), where uid is the ID of the user whose
   video stream you want to resume receiving.

   @note
   - The result of calling this method is affected by calling
   \ref IRtcEngine::enableVideo "enableVideo" and
   \ref IRtcEngine::disableVideo "disableVideo". Settings in
   muteAllRemoteVideoStreams stop taking effect if either of the following occurs:
     - Calling `enableVideo` after muteAllRemoteVideoStreams(true).
     - Calling `disableVideo` after muteAllRemoteVideoStreams(false).
   - This method only works for the channel created by calling `joinChannel`.
   To set whether to receive remote audio streams for a specific channel, Agora
   recommends using `autoSubscribeVideo` in the ChannelMediaOptions class.
   @param mute Whether to stop receiving remote video streams:
   - true: Stop receiving any remote video stream.
   - false: (Default) Resume receiving all remote video streams.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int muteAllRemoteVideoStreams(bool mute) = 0;

  /**
   * Sets the default stream type of the remote video if the remote user has enabled dual-stream.
   *
   * @param streamType Sets the default video stream type: #VIDEO_STREAM_TYPE.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setRemoteDefaultVideoStreamType(VIDEO_STREAM_TYPE streamType) = 0;

  /**
   * Stops or resumes receiving the video stream of a specified user.
   *
   * @note
   * You can call this method before or after joining a channel. If a user
   * leaves a channel, the settings in this method become invalid.
   *
   * @param uid The ID of the specified user.
   * @param mute Whether to stop receiving the video stream of the specified user:
   * - true: Stop receiving the video stream of the specified user.
   * - false: (Default) Resume receiving the video stream of the specified user.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int muteRemoteVideoStream(uid_t uid, bool mute) = 0;

  /**
   * Sets the remote video stream type.
   *
   * If the remote user has enabled the dual-stream mode, by default the SDK receives the high-stream video by
   * Call this method to switch to the low-stream video.
   *
   * @note
   * This method applies to scenarios where the remote user has enabled the dual-stream mode using
   * \ref enableDualStreamMode "enableDualStreamMode"(true) before joining the channel.
   *
   * @param uid ID of the remote user sending the video stream.
   * @param streamType Sets the video stream type: #VIDEO_STREAM_TYPE.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setRemoteVideoStreamType(uid_t uid, VIDEO_STREAM_TYPE streamType) = 0;

  /**
   * Sets the remote video subscription options
   *
   *
   * @param uid ID of the remote user sending the video stream.
   * @param options Sets the video subscription options.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setRemoteVideoSubscriptionOptions(uid_t uid, const VideoSubscriptionOptions &options) = 0;

  /**
   * Sets the blocklist of subscribe remote stream audio.
   *
   * @param uidList The id list of users whose audio you do not want to subscribe to.
   * @param uidNumber The number of uid in uidList.
   *
   * @note
   * If uid is in uidList, the remote user's audio will not be subscribed,
   * even if muteRemoteAudioStream(uid, false) and muteAllRemoteAudioStreams(false) are operated.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setSubscribeAudioBlocklist(uid_t* uidList, int uidNumber) = 0;

  /**
   * Sets the allowlist of subscribe remote stream audio.
   *
   * @param uidList The id list of users whose audio you want to subscribe to.
   * @param uidNumber The number of uid in uidList.
   *
   * @note
   * If uid is in uidList, the remote user's audio will be subscribed,
   * even if muteRemoteAudioStream(uid, true) and muteAllRemoteAudioStreams(true) are operated.
   *
   * If a user is in the blocklist and allowlist at the same time, only the blocklist takes effect.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setSubscribeAudioAllowlist(uid_t* uidList, int uidNumber) = 0;

  /**
   * Sets the blocklist of subscribe remote stream video.
   *
   * @param uidList The id list of users whose video you do not want to subscribe to.
   * @param uidNumber The number of uid in uidList.
   *
   * @note
   * If uid is in uidList, the remote user's video will not be subscribed,
   * even if muteRemoteVideoStream(uid, false) and muteAllRemoteVideoStreams(false) are operated.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setSubscribeVideoBlocklist(uid_t* uidList, int uidNumber) = 0;

  /**
   * Sets the allowlist of subscribe remote stream video.
   *
   * @param uidList The id list of users whose video you want to subscribe to.
   * @param uidNumber The number of uid in uidList.
   *
   * @note
   * If uid is in uidList, the remote user's video will be subscribed,
   * even if muteRemoteVideoStream(uid, true) and muteAllRemoteVideoStreams(true) are operated.
   *
   * If a user is in the blocklist and allowlist at the same time, only the blocklist takes effect.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setSubscribeVideoAllowlist(uid_t* uidList, int uidNumber) = 0;

  /**
   * Enables the `onAudioVolumeIndication` callback to report on which users are speaking
   * and the speakers' volume.
   *
   * Once the \ref IRtcEngineEventHandler::onAudioVolumeIndication "onAudioVolumeIndication"
   * callback is enabled, the SDK returns the volume indication in the at the time interval set
   * in `enableAudioVolumeIndication`, regardless of whether any user is speaking in the channel.
   *
   * @param interval Sets the time interval between two consecutive volume indications:
   * - <= 0: Disables the volume indication.
   * - > 0: Time interval (ms) between two consecutive volume indications,
   * and should be integral multiple of 200 (less than 200 will be set to 200).
   * @param smooth The smoothing factor that sets the sensitivity of the audio volume
   * indicator. The value range is [0, 10]. The greater the value, the more sensitive the
   * indicator. The recommended value is 3.
   * @param reportVad
   * - `true`: Enable the voice activity detection of the local user. Once it is enabled, the `vad` parameter of the
   * `onAudioVolumeIndication` callback reports the voice activity status of the local user.
   * - `false`: (Default) Disable the voice activity detection of the local user. Once it is disabled, the `vad` parameter
   * of the `onAudioVolumeIndication` callback does not report the voice activity status of the local user, except for
   * the scenario where the engine automatically detects the voice activity of the local user.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int enableAudioVolumeIndication(int interval, int smooth, bool reportVad) = 0;

  /** Starts an audio recording.

  The SDK allows recording during a call, which supports either one of the
  following two formats:

  - .wav: Large file size with high sound fidelity
  - .aac: Small file size with low sound fidelity

  Ensure that the directory to save the recording file exists and is writable.
  This method is usually called after the joinChannel() method.
  The recording automatically stops when the leaveChannel() method is
  called.

  @param filePath Full file path of the recording file. The string of the file
  name is in UTF-8 code.
  @param quality Sets the audio recording quality: #AUDIO_RECORDING_QUALITY_TYPE.
  @return
  - 0: Success.
  - < 0: Failure.
  */
  virtual int startAudioRecording(const char* filePath,
                                  AUDIO_RECORDING_QUALITY_TYPE quality) = 0;
  /** Starts an audio recording.

  The SDK allows recording during a call, which supports either one of the
  following two formats:

  - .wav: Large file size with high sound fidelity
  - .aac: Small file size with low sound fidelity

  Ensure that the directory to save the recording file exists and is writable.
  This method is usually called after the joinChannel() method.
  The recording automatically stops when the leaveChannel() method is
  called.

  @param filePath Full file path of the recording file. The string of the file
  name is in UTF-8 code.
  @param sampleRate Sample rate, value should be 16000, 32000, 44100, or 48000.
  @param quality Sets the audio recording quality: #AUDIO_RECORDING_QUALITY_TYPE.
  @return
  - 0: Success.
  - < 0: Failure.
  */
  virtual int startAudioRecording(const char* filePath,
                                  int sampleRate,
                                  AUDIO_RECORDING_QUALITY_TYPE quality) = 0;

  /** Starts an audio recording.

  The SDK allows recording during a call, which supports either one of the
  following two formats:

  - .wav: Large file size with high sound fidelity
  - .aac: Small file size with low sound fidelity

  Ensure that the directory to save the recording file exists and is writable.
  This method is usually called after the joinChannel() method.
  The recording automatically stops when the leaveChannel() method is
  called.

  @param config Audio recording config.
  @return
  - 0: Success.
  - < 0: Failure.
  */
  virtual int startAudioRecording(const AudioRecordingConfiguration& config) = 0;

  /** register encoded audio frame observer
   @return
  - 0: Success.
  - < 0: Failure.
   */
  virtual int registerAudioEncodedFrameObserver(const AudioEncodedFrameObserverConfig& config,  IAudioEncodedFrameObserver *observer) = 0;

  /** Stops the audio recording on the client.

  The recording automatically stops when the leaveChannel() method is called.

  @return
  - 0: Success.
  - < 0: Failure.
  */
  virtual int stopAudioRecording() = 0;

    /**
   * Creates a media player source object and return its pointer. If full featured
   * media player source is supported, it will create it, or it will create a simple
   * media player.
   *
   * @return
   * - The pointer to \ref rtc::IMediaPlayerSource "IMediaPlayerSource",
   *   if the method call succeeds.
   * - The empty pointer NULL, if the method call fails.
   */
  virtual agora_refptr<IMediaPlayer> createMediaPlayer() = 0;

  /**
   * Destroy a media player source instance.
   * If a media player source instance is destroyed, the video and audio of it cannot
   * be published.
   *
   * @param media_player The pointer to \ref rtc::IMediaPlayerSource.
   *
   * @return
   * - >0: The id of media player source instance.
   * - < 0: Failure.
   */
  virtual int destroyMediaPlayer(agora_refptr<IMediaPlayer> media_player) = 0;

  /**
   * Creates a media recorder object and return its pointer.
   *
   * @param info The RecorderStreamInfo object. It contains the user ID and the channel name.
   * 
   * @return
   * - The pointer to \ref rtc::IMediaRecorder "IMediaRecorder",
   *   if the method call succeeds.
   * - The empty pointer NULL, if the method call fails.
   */
  virtual agora_refptr<IMediaRecorder> createMediaRecorder(const RecorderStreamInfo& info) = 0;

  /**
   * Destroy a media recorder object.
   *
   * @param mediaRecorder The pointer to \ref rtc::IMediaRecorder.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int destroyMediaRecorder(agora_refptr<IMediaRecorder> mediaRecorder) = 0;

  /** Starts playing and mixing the music file.

  This method mixes the specified local audio file with the audio stream from
  the microphone. You can choose whether the other user can hear the local
  audio playback and specify the number of playback loops. This method also
  supports online music playback.

  After calling this method successfully, the SDK triggers the

  \ref IRtcEngineEventHandler::onAudioMixingStateChanged "onAudioMixingStateChanged" (PLAY)
  callback on the local client.
  When the audio mixing file playback finishes after calling this method, the
  SDK triggers the
  \ref IRtcEngineEventHandler::onAudioMixingStateChanged "onAudioMixingStateChanged" (STOPPED)
  callback on the local client.

  @note
  - Call this method after joining a channel, otherwise issues may occur.
  - If the local audio mixing file does not exist, or if the SDK does not
  support the file format or cannot access the music file URL, the SDK returns
  #WARN_AUDIO_MIXING_OPEN_ERROR (701).
  - If you want to play an online music file, ensure that the time interval
  between calling this method is more than 100 ms, or the
  `AUDIO_MIXING_ERROR_TOO_FREQUENT_CALL(702)` error code occurs.

  @param filePath Pointer to the absolute path (including the suffixes of the
  filename) of the local or online audio file to mix, for example, c:/music/au
  dio.mp4. Supported audio formats: 3GP, ASF, ADTS, AVI, MP3, MP4, MPEG-4,
  SAMI, and WAVE.
  @param loopback Sets which user can hear the audio mixing:
  - true: Only the local user can hear the audio mixing.
  - false: Both users can hear the audio mixing.

  @param cycle Sets the number of playback loops:
  - Positive integer: Number of playback loops.
  - `-1`: Infinite playback loops.

  @return
  - 0: Success.
  - < 0: Failure.
  */
  virtual int startAudioMixing(const char* filePath, bool loopback, int cycle) = 0;

  /** Starts playing and mixing the music file.

  This method mixes the specified local audio file with the audio stream from
  the microphone. You can choose whether the other user can hear the local
  audio playback and specify the number of playback loops. This method also
  supports online music playback.

  After calling this method successfully, the SDK triggers the

  \ref IRtcEngineEventHandler::onAudioMixingStateChanged "onAudioMixingStateChanged" (PLAY)
  callback on the local client.
  When the audio mixing file playback finishes after calling this method, the
  SDK triggers the
  \ref IRtcEngineEventHandler::onAudioMixingStateChanged "onAudioMixingStateChanged" (STOPPED)
  callback on the local client.

  @note
  - Call this method after joining a channel, otherwise issues may occur.
  - If the local audio mixing file does not exist, or if the SDK does not
  support the file format or cannot access the music file URL, the SDK returns
  #WARN_AUDIO_MIXING_OPEN_ERROR (701).
  - If you want to play an online music file, ensure that the time interval
  between calling this method is more than 100 ms, or the
  `AUDIO_MIXING_ERROR_TOO_FREQUENT_CALL(702)` error code occurs.

  @param filePath Pointer to the absolute path (including the suffixes of the
  filename) of the local or online audio file to mix, for example, c:/music/au
  dio.mp4. Supported audio formats: 3GP, ASF, ADTS, AVI, MP3, MP4, MPEG-4,
  SAMI, and WAVE.
  @param loopback Sets which user can hear the audio mixing:
  - true: Only the local user can hear the audio mixing.
  - false: Both users can hear the audio mixing.

  @param cycle Sets the number of playback loops:
  - Positive integer: Number of playback loops.
  - `-1`: Infinite playback loops.

  @param startPos The playback position (ms) of the music file.

  @return
  - 0: Success.
  - < 0: Failure.
  */
  virtual int startAudioMixing(const char* filePath, bool loopback, int cycle, int startPos) = 0;

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

  /** Resumes playing and mixing the music file.

  Call this method when you are in a channel.

  @return
  - 0: Success.
  - < 0: Failure.
  */
  virtual int resumeAudioMixing() = 0;

  /** Select audio track for the music file.

  Call this method when you are in a channel.

  @return
  - 0: Success.
  - < 0: Failure.
  */
  virtual int selectAudioTrack(int index) = 0;
  /** Get audio track count of the music file.

   Call this method when you are in a channel.

   @return
   - &ge; 0: Audio track count of the music file, if the method call is successful.
   - < 0: Failure.
   */
  virtual int getAudioTrackCount() = 0;

  /** Adjusts the volume during audio mixing.

  Call this method when you are in a channel.

  @note This method does not affect the volume of audio effect file playback
  invoked by the \ref IRtcEngine::playEffect "playEffect" method.

  @param volume The audio mixing volume. The value ranges between 0 and 100
  (default).

  @return
  - 0: Success.
  - < 0: Failure.
  */
  virtual int adjustAudioMixingVolume(int volume) = 0;

  /** Adjusts the audio mixing volume for publishing (for remote users).
   @note Call this method when you are in a channel.
   @param volume Audio mixing volume for publishing. The value ranges between 0 and 100 (default).
   @return
    - 0: Success.
    - < 0: Failure.
   */
  virtual int adjustAudioMixingPublishVolume(int volume) = 0;

  /** Retrieves the audio mixing volume for publishing.
   This method helps troubleshoot audio volume related issues.
   @note Call this method when you are in a channel.
   @return
    - &ge; 0: The audio mixing volume for publishing, if this method call succeeds. The value range is [0,100].
    - < 0: Failure.
   */
  virtual int getAudioMixingPublishVolume() = 0;

  /** Adjusts the audio mixing volume for local playback.
   @note Call this method when you are in a channel.
   @param volume Audio mixing volume for local playback. The value ranges between 0 and 100 (default).
   @return
    - 0: Success.
    - < 0: Failure.
   */
  virtual int adjustAudioMixingPlayoutVolume(int volume) = 0;

  /** Retrieves the audio mixing volume for local playback.
   This method helps troubleshoot audio volume related issues.
   @note Call this method when you are in a channel.
   @return
    - &ge; 0: The audio mixing volume, if this method call succeeds. The value range is [0,100].
    - < 0: Failure.
   */
  virtual int getAudioMixingPlayoutVolume() = 0;

  /** Gets the duration (ms) of the music file.

   Call this API when you are in a channel.

   @return
   - Returns the audio mixing duration, if the method call is successful.
   - < 0: Failure.
   */
  virtual int getAudioMixingDuration() = 0;

  /** Gets the playback position (ms) of the music file.

   Call this method when you are in a channel.

   @return
   - &ge; 0: The current playback position of the audio mixing, if this method
   call succeeds.
   - < 0: Failure.
   */
  virtual int getAudioMixingCurrentPosition() = 0;

  /** Sets the playback position of the music file to a different starting
   position (the default plays from the beginning).

   @param pos The playback starting position (ms) of the audio mixing file.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setAudioMixingPosition(int pos /*in ms*/) = 0;

  /** In dual-channel music files, different audio data can be stored on the left and right channels.
   * According to actual needs, you can set the channel mode as the original mode,
   * the left channel mode, the right channel mode or the mixed mode

   @param mode The mode of channel mode

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setAudioMixingDualMonoMode(media::AUDIO_MIXING_DUAL_MONO_MODE mode) = 0;

  /** Sets the pitch of the local music file.
   *
   * When a local music file is mixed with a local human voice, call this method to set the pitch of the local music file only.
   *
   * @note Call this method after calling \ref IRtcEngine::startAudioMixing "startAudioMixing" and
   * receiving the \ref IRtcEngineEventHandler::onAudioMixingStateChanged "onAudioMixingStateChanged" (AUDIO_MIXING_STATE_PLAYING) callback.
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

  /**
   * Sets the playback speed of the current music file.
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
  
  /**
   * Gets the volume of audio effects.
   *
   * @return
   * - &ge; 0: The volume of audio effects. The value ranges between 0 and 100 (original volume).
   * - < 0: Failure.
   */
  virtual int getEffectsVolume() = 0;
  /** Sets the volume of audio effects.
   *
   * @param volume The volume of audio effects. The value ranges between 0
   * and 100 (original volume).
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setEffectsVolume(int volume) = 0;
  /** Preloads a specified audio effect.
   *
   * This method preloads only one specified audio effect into the memory each time
   * it is called. To preload multiple audio effects, call this method multiple times.
   *
   * After preloading, you can call \ref IRtcEngine::playEffect "playEffect"
   * to play the preloaded audio effect or call
   * \ref IRtcEngine::playAllEffects "playAllEffects" to play all the preloaded
   * audio effects.
   *
   * @note
   * - To ensure smooth communication, limit the size of the audio effect file.
   * - Agora recommends calling this method before joining the channel.
   *
   * @param soundId The ID of the audio effect.
   * @param filePath The absolute path of the local audio effect file or the URL
   * of the online audio effect file. Supported audio formats: mp3, mp4, m4a, aac,
   * 3gp, mkv, and wav.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int preloadEffect(int soundId, const char* filePath, int startPos = 0) = 0;
  /** Plays a specified audio effect.
   *
   * After calling \ref IRtcEngine::preloadEffect "preloadEffect", you can call
   * this method to play the specified audio effect for all users in
   * the channel.
   *
   * This method plays only one specified audio effect each time it is called.
   * To play multiple audio effects, call this method multiple times.
   *
   * @note
   * - Agora recommends playing no more than three audio effects at the same time.
   * - The ID and file path of the audio effect in this method must be the same
   * as that in the \ref IRtcEngine::preloadEffect "preloadEffect" method.
   *
   * @param soundId The ID of the audio effect.
   * @param filePath The absolute path of the local audio effect file or the URL
   * of the online audio effect file. Supported audio formats: mp3, mp4, m4a, aac,
   * 3gp, mkv, and wav.
   * @param loopCount The number of times the audio effect loops:
   * - `-1`: Play the audio effect in an indefinite loop until
   * \ref IRtcEngine::stopEffect "stopEffect" or
   * \ref IRtcEngine::stopAllEffects "stopAllEffects"
   * - `0`: Play the audio effect once.
   * - `1`: Play the audio effect twice.
   * @param pitch The pitch of the audio effect. The value ranges between 0.5 and 2.0.
   * The default value is `1.0` (original pitch). The lower the value, the lower the pitch.
   * @param pan The spatial position of the audio effect. The value ranges between -1.0 and 1.0:
   * - `-1.0`: The audio effect displays to the left.
   * - `0.0`: The audio effect displays ahead.
   * - `1.0`: The audio effect displays to the right.
   * @param gain The volume of the audio effect. The value ranges between 0 and 100.
   * The default value is `100` (original volume). The lower the value, the lower
   * the volume of the audio effect.
   * @param publish Sets whether to publish the audio effect to the remote:
   * - true: Publish the audio effect to the remote.
   * - false: (Default) Do not publish the audio effect to the remote.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int playEffect(int soundId, const char* filePath, int loopCount, double pitch, double pan, int gain, bool publish = false, int startPos = 0) = 0;
  /** Plays all audio effects.
   *
   * After calling \ref IRtcEngine::preloadEffect "preloadEffect" multiple times
   * to preload multiple audio effects into the memory, you can call this
   * method to play all the specified audio effects for all users in
   * the channel.
   *
   * @param loopCount The number of times the audio effect loops:
   * - `-1`: Play the audio effect in an indefinite loop until
   * \ref IRtcEngine::stopEffect "stopEffect" or
   * \ref IRtcEngine::stopAllEffects "stopAllEffects"
   * - `0`: Play the audio effect once.
   * - `1`: Play the audio effect twice.
   * @param pitch The pitch of the audio effect. The value ranges between 0.5 and 2.0.
   * The default value is `1.0` (original pitch). The lower the value, the lower the pitch.
   * @param pan The spatial position of the audio effect. The value ranges between -1.0 and 1.0:
   * - `-1.0`: The audio effect displays to the left.
   * - `0.0`: The audio effect displays ahead.
   * - `1.0`: The audio effect displays to the right.
   * @param gain The volume of the audio effect. The value ranges between 0 and 100.
   * The default value is `100` (original volume). The lower the value, the lower
   * the volume of the audio effect.
   * @param publish Sets whether to publish the audio effect to the remote:
   * - true: Publish the audio effect to the remote.
   * - false: (Default) Do not publish the audio effect to the remote.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int playAllEffects(int loopCount, double pitch, double pan, int gain, bool publish = false) = 0;

  /** Gets the volume of the specified audio effect.
   *
   * @param soundId The ID of the audio effect.
   *
   * @return
   * - &ge; 0: The volume of the specified audio effect. The value ranges
   * between 0 and 100 (original volume).
   * - < 0: Failure.
   */
  virtual int getVolumeOfEffect(int soundId) = 0;

  /** Sets the volume of the specified audio effect.
   *
   * @param soundId The ID of the audio effect.
   * @param volume The volume of the specified audio effect. The value ranges
   * between 0 and 100 (original volume).
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setVolumeOfEffect(int soundId, int volume) = 0;
  /** Pauses playing the specified audio effect.
   *
   * @param soundId The ID of the audio effect.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int pauseEffect(int soundId) = 0;
  /** Pauses playing audio effects.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int pauseAllEffects() = 0;
  /** Resumes playing the specified audio effect.
   *
   * @param soundId The ID of the audio effect.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int resumeEffect(int soundId) = 0;
  /** Resumes playing audio effects.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int resumeAllEffects() = 0;
  /** Stops playing the specified audio effect.
   *
   * @param soundId The ID of the audio effect.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int stopEffect(int soundId) = 0;
  /** Stops playing audio effects.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int stopAllEffects() = 0;
  /** Releases the specified preloaded audio effect from the memory.
   *
   * @param soundId The ID of the audio effect.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int unloadEffect(int soundId) = 0;
  /** Releases preloaded audio effects from the memory.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int unloadAllEffects() = 0;
  /**
   * Gets the duration of the audio effect file.
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
  /** Enables/Disables stereo panning for remote users.

   Ensure that you call this method before joinChannel to enable stereo panning for remote users so that the local user can track the position of a remote user by calling \ref agora::rtc::IRtcEngine::setRemoteVoicePosition "setRemoteVoicePosition".

   @param enabled Sets whether or not to enable stereo panning for remote users:
   - true: enables stereo panning.
   - false: disables stereo panning.

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

  /** enable spatial audio

   @param enabled enable/disable spatial audio:
   - true: enable spatial audio.
   - false: disable spatial audio.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int enableSpatialAudio(bool enabled) = 0;

  /** Sets remote user parameters for spatial audio

   @param uid The ID of the remote user.
   @param param spatial audio parameters: SpatialAudioParams.

   @return int
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setRemoteUserSpatialAudioParams(uid_t uid, const agora::SpatialAudioParams& params) = 0;

  /** Sets an SDK preset voice beautifier effect.
   *
   * Call this method to set an SDK preset voice beautifier effect for the local user who sends an
   * audio stream. After setting a voice beautifier effect, all users in the channel can hear the
   * effect.
   *
   * You can set different voice beautifier effects for different scenarios. See *Set the Voice
   * Beautifier and Audio Effects*.
   *
   * To achieve better audio effect quality, Agora recommends calling \ref
   * IRtcEngine::setAudioProfile "setAudioProfile" and setting the `scenario` parameter to
   * `AUDIO_SCENARIO_GAME_STREAMING(3)` and the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * calling this method.
   *
   * @note
   * - You can call this method either before or after joining a channel.
   * - Do not set the `profile` parameter of \ref IRtcEngine::setAudioProfile "setAudioProfile" to
   * `AUDIO_PROFILE_SPEECH_STANDARD(1)` or `AUDIO_PROFILE_IOT(6)`; otherwise, this method call
   * fails.
   * - This method works best with the human voice. Agora does not recommend using this method for
   * audio containing music.
   * - After calling this method, Agora recommends not calling the following methods, because they
   * can override \ref IRtcEngine::setAudioEffectParameters "setAudioEffectParameters":
   *  - \ref IRtcEngine::setAudioEffectPreset "setAudioEffectPreset"
   *  - \ref IRtcEngine::setVoiceBeautifierPreset "setVoiceBeautifierPreset"
   *  - \ref IRtcEngine::setLocalVoicePitch "setLocalVoicePitch"
   *  - \ref IRtcEngine::setLocalVoiceEqualization "setLocalVoiceEqualization"
   *  - \ref IRtcEngine::setLocalVoiceReverb "setLocalVoiceReverb"
   *  - \ref IRtcEngine::setVoiceBeautifierParameters "setVoiceBeautifierParameters"
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
   * Call this method to set an SDK preset audio effect for the local user who sends an audio
   * stream. This audio effect does not change the gender characteristics of the original voice.
   * After setting an audio effect, all users in the channel can hear the effect.
   *
   * You can set different audio effects for different scenarios. See *Set the Voice Beautifier and
   * Audio Effects*.
   *
   * To achieve better audio effect quality, Agora recommends calling \ref
   * IRtcEngine::setAudioProfile "setAudioProfile" and setting the `scenario` parameter to
   * `AUDIO_SCENARIO_GAME_STREAMING(3)` before calling this method.
   *
   * @note
   * - You can call this method either before or after joining a channel.
   * - Do not set the profile `parameter` of `setAudioProfile` to `AUDIO_PROFILE_SPEECH_STANDARD(1)`
   * or `AUDIO_PROFILE_IOT(6)`; otherwise, this method call fails.
   * - This method works best with the human voice. Agora does not recommend using this method for
   * audio containing music.
   * - If you call this method and set the `preset` parameter to enumerators except
   * `ROOM_ACOUSTICS_3D_VOICE` or `PITCH_CORRECTION`, do not call \ref
   * IRtcEngine::setAudioEffectParameters "setAudioEffectParameters"; otherwise,
   * `setAudioEffectParameters` overrides this method.
   * - After calling this method, Agora recommends not calling the following methods, because they
   * can override `setAudioEffectPreset`:
   *  - \ref IRtcEngine::setVoiceBeautifierPreset "setVoiceBeautifierPreset"
   *  - \ref IRtcEngine::setLocalVoicePitch "setLocalVoicePitch"
   *  - \ref IRtcEngine::setLocalVoiceEqualization "setLocalVoiceEqualization"
   *  - \ref IRtcEngine::setLocalVoiceReverb "setLocalVoiceReverb"
   *  - \ref IRtcEngine::setVoiceBeautifierParameters "setVoiceBeautifierParameters"
   *
   * @param preset The options for SDK preset audio effects. See #AUDIO_EFFECT_PRESET.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setAudioEffectPreset(AUDIO_EFFECT_PRESET preset) = 0;

  /** Sets an SDK preset voice conversion.
   *
   * Call this method to set an SDK preset voice conversion for the local user who sends an audio
   * stream. After setting an voice conversion, all users in the channel can hear the effect.
   *
   * You can set different voice conversion for different scenarios. See *Set the Voice Beautifier and
   * Audio Effects*.
   *
   * To achieve better voice conversion quality, Agora recommends calling \ref
   * IRtcEngine::setAudioProfile "setAudioProfile" and setting the `scenario` parameter to
   * `AUDIO_SCENARIO_GAME_STREAMING(3)` before calling this method.
   *
   * @note
   * - You can call this method either before or after joining a channel.
   * - Do not set the profile `parameter` of `setAudioProfile` to `AUDIO_PROFILE_SPEECH_STANDARD(1)`
   * or `AUDIO_PROFILE_IOT(6)`; otherwise, this method call fails.
   * - This method works best with the human voice. Agora does not recommend using this method for
   * audio containing music.
   * - If you call this method and set the `preset` parameter to enumerators,
   * - After calling this method, Agora recommends not calling the following methods, because they
   * can override `setVoiceConversionPreset`:
   *  - \ref IRtcEngine::setVoiceBeautifierPreset "setVoiceBeautifierPreset"
   *  - \ref IRtcEngine::setAudioEffectPreset "setAudioEffectPreset"
   *  - \ref IRtcEngine::setLocalVoicePitch "setLocalVoicePitch"
   *  - \ref IRtcEngine::setLocalVoiceFormant "setLocalVoiceFormant"
   *  - \ref IRtcEngine::setLocalVoiceEqualization "setLocalVoiceEqualization"
   *  - \ref IRtcEngine::setLocalVoiceReverb "setLocalVoiceReverb"
   *  - \ref IRtcEngine::setVoiceBeautifierParameters "setVoiceBeautifierParameters"
   *  - \ref IRtcEngine::setAudioEffectParameters "setAudioEffectParameters"
   *
   * @param preset The options for SDK preset voice conversion. See #VOICE_CONVERSION_PRESET.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setVoiceConversionPreset(VOICE_CONVERSION_PRESET preset) = 0;

  /** Sets parameters for SDK preset audio effects.
   *
   * Call this method to set the following parameters for the local user who send an audio stream:
   * - 3D voice effect: Sets the cycle period of the 3D voice effect.
   * - Pitch correction effect: Sets the basic mode and tonic pitch of the pitch correction effect.
   * Different songs have different modes and tonic pitches. Agora recommends bounding this method
   * with interface elements to enable users to adjust the pitch correction interactively.
   *
   * After setting parameters, all users in the channel can hear the relevant effect.
   *
   * You can call this method directly or after \ref IRtcEngine::setAudioEffectPreset
   * "setAudioEffectPreset". If you call this method after \ref IRtcEngine::setAudioEffectPreset
   * "setAudioEffectPreset", ensure that you set the preset parameter of `setAudioEffectPreset` to
   * `ROOM_ACOUSTICS_3D_VOICE` or `PITCH_CORRECTION` and then call this method to set the same
   * enumerator; otherwise, this method overrides `setAudioEffectPreset`.
   *
   * @note
   * - You can call this method either before or after joining a channel.
   * - To achieve better audio effect quality, Agora recommends calling \ref
   * IRtcEngine::setAudioProfile "setAudioProfile" and setting the `scenario` parameter to
   * `AUDIO_SCENARIO_GAME_STREAMING(3)` before calling this method.
   * - Do not set the `profile` parameter of \ref IRtcEngine::setAudioProfile "setAudioProfile" to
   * `AUDIO_PROFILE_SPEECH_STANDARD(1)` or `AUDIO_PROFILE_IOT(6)`; otherwise, this method call
   * fails.
   * - This method works best with the human voice. Agora does not recommend using this method for
   * audio containing music.
   * - After calling this method, Agora recommends not calling the following methods, because they
   * can override `setAudioEffectParameters`:
   *  - \ref IRtcEngine::setAudioEffectPreset "setAudioEffectPreset"
   *  - \ref IRtcEngine::setVoiceBeautifierPreset "setVoiceBeautifierPreset"
   *  - \ref IRtcEngine::setLocalVoicePitch "setLocalVoicePitch"
   *  - \ref IRtcEngine::setLocalVoiceEqualization "setLocalVoiceEqualization"
   *  - \ref IRtcEngine::setLocalVoiceReverb "setLocalVoiceReverb"
   *  - \ref IRtcEngine::setVoiceBeautifierParameters "setVoiceBeautifierParameters"
   * @param preset The options for SDK preset audio effects:
   * - 3D voice effect: `ROOM_ACOUSTICS_3D_VOICE`.
   *  - Call \ref IRtcEngine::setAudioProfile "setAudioProfile" and set the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_STANDARD_STEREO(3)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator; otherwise, the enumerator setting does not take effect.
   *  - If the 3D voice effect is enabled, users need to use stereo audio playback devices to hear
   * the anticipated voice effect.
   * - Pitch correction effect: `PITCH_CORRECTION`. To achieve better audio effect quality, Agora
   * recommends calling \ref IRtcEngine::setAudioProfile "setAudioProfile" and setting the `profile`
   * parameter to `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before setting this enumerator.
   * @param param1
   * - If you set `preset` to `ROOM_ACOUSTICS_3D_VOICE`, the `param1` sets the cycle period of the
   * 3D voice effect. The value range is [1,60] and the unit is a second. The default value is 10
   * seconds, indicating that the voice moves around you every 10 seconds.
   * - If you set `preset` to `PITCH_CORRECTION`, `param1` sets the basic mode of the pitch
   * correction effect:
   *  - `1`: (Default) Natural major scale.
   *  - `2`: Natural minor scale.
   *  - `3`: Japanese pentatonic scale.
   * @param param2
   * - If you set `preset` to `ROOM_ACOUSTICS_3D_VOICE`, you need to set `param2` to `0`.
   * - If you set `preset` to `PITCH_CORRECTION`, `param2` sets the tonic pitch of the pitch
   * correction effect:
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
   * Call this method to set a gender characteristic and a reverberation effect for the singing
   * beautifier effect. This method sets parameters for the local user who sends an audio stream.
   *
   * After you call this method successfully, all users in the channel can hear the relevant effect.
   *
   * To achieve better audio effect quality, before you call this method, Agora recommends calling
   * \ref IRtcEngine::setAudioProfile "setAudioProfile", and setting the `scenario` parameter as
   * `AUDIO_SCENARIO_GAME_STREAMING(3)` and the `profile` parameter as
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)`.
   *
   * @note
   * - You can call this method either before or after joining a channel.
   * - Do not set the `profile` parameter of \ref IRtcEngine::setAudioProfile "setAudioProfile" as
   * `AUDIO_PROFILE_SPEECH_STANDARD(1)` or `AUDIO_PROFILE_IOT(6)`; otherwise, this method call does
   * not take effect.
   * - This method works best with the human voice. Agora does not recommend using this method for
   * audio containing music.
   * - After you call this method, Agora recommends not calling the following methods, because they
   * can override `setVoiceBeautifierParameters`:
   *    - \ref IRtcEngine::setAudioEffectPreset "setAudioEffectPreset"
   *    - \ref IRtcEngine::setAudioEffectParameters "setAudioEffectParameters"
   *    - \ref IRtcEngine::setVoiceBeautifierPreset "setVoiceBeautifierPreset"
   *    - \ref IRtcEngine::setLocalVoicePitch "setLocalVoicePitch"
   *    - \ref IRtcEngine::setLocalVoiceEqualization "setLocalVoiceEqualization"
   *    - \ref IRtcEngine::setLocalVoiceReverb "setLocalVoiceReverb"
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
  virtual int setVoiceBeautifierParameters(VOICE_BEAUTIFIER_PRESET preset,
                                            int param1, int param2) = 0;

  /** Set parameters for SDK preset voice conversion.
   *
   * @note
   * - reserved interface
   *
   * @param preset The options for SDK preset audio effects. See #VOICE_CONVERSION_PRESET.
   * @param param1 reserved.
   * @param param2 reserved.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setVoiceConversionParameters(VOICE_CONVERSION_PRESET preset,
                                            int param1, int param2) = 0;

  /** Changes the voice pitch of the local speaker.

  @param pitch The voice pitch. The value ranges between 0.5 and 2.0. The lower
  the value, the lower the voice pitch. The default value is 1.0 (no change to
  the local voice pitch).

  @return
  - 0: Success.
  - -1: Failure.
  */
  virtual int setLocalVoicePitch(double pitch) = 0;

  /** Changes the voice formant ratio for local speaker.

  @param formantRatio The voice formant ratio. The value ranges between -1.0 and 1.0. 
  The lower the value, the deeper the sound, and the higher the value, the more it 
  sounds like a child. The default value is 0.0 (the local user's voice will not be changed).

  @return
  - 0: Success.
  - -1: Failure.
  */
  virtual int setLocalVoiceFormant(double formantRatio) = 0;

  /** Sets the local voice equalization effect.

  @param bandFrequency The band frequency ranging from 0 to 9, representing the
  respective 10-band center frequencies of the voice effects, including 31, 62,
  125, 500, 1k, 2k, 4k, 8k, and 16k Hz.
  @param bandGain  Gain of each band in dB. The value ranges from -15 to 15. The
  default value is 0.
  @return
  - 0: Success.
  - -1: Failure.
  */
  virtual int setLocalVoiceEqualization(AUDIO_EQUALIZATION_BAND_FREQUENCY bandFrequency, int bandGain) = 0;

  /** Sets the local voice reverberation.

  @param reverbKey The reverberation key: #AUDIO_REVERB_TYPE.
  @param value The value of the reverberation key: #AUDIO_REVERB_TYPE.
  @return
  - 0: Success.
  - -1: Failure.
  */
  virtual int setLocalVoiceReverb(AUDIO_REVERB_TYPE reverbKey, int value) = 0;
  /** Sets preset audio playback effect for remote headphones after remote audio is mixed.

  @param preset The preset key: #HEADPHONE_EQUALIZER_PRESET.
  - HEADPHONE_EQUALIZER_OFF = 0x00000000 : Turn off the eualizer effect for headphones.
  - HEADPHONE_EQUALIZER_OVEREAR = 0x04000001 : For over-ear headphones only.
  - HEADPHONE_EQUALIZER_INEAR = 0x04000002 : For in-ear headphones only.
  @return
  - 0: Success.
  - < 0: Failure.
    - -1(ERR_FAILED): A general error occurs (no specified reason).
  */
  virtual int setHeadphoneEQPreset(HEADPHONE_EQUALIZER_PRESET preset) = 0;

  /** Sets the parameters of audio playback effect for remote headphones after remote audio is mixed.

  @param lowGain The higher the parameter value, the deeper the sound. The value range is [-10,10].
  @param highGain The higher the parameter value, the sharper the sound. The value range is [-10,10].
  @return
  - 0: Success.
  - < 0: Failure.
    - -1(ERR_FAILED): A general error occurs (no specified reason).
  */
  virtual int setHeadphoneEQParameters(int lowGain, int highGain) = 0;

  /** Enables or disables the voice AI tuner.
   *
   * @param enabled Determines whether to enable the voice AI tuner:
   * - true: Enable the voice AI tuner
   * - false: (default) Disable the voice AI tuner.
   *
   * @param type. The options for SDK voice AI tuner types. See #VOICE_AI_TUNER_TYPE.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int enableVoiceAITuner(bool enabled, VOICE_AI_TUNER_TYPE type) = 0;

  /** **DEPRECATED** Specifies an SDK output log file.
   *
   * The log file records all log data for the SDK’s operation. Ensure that the
   * directory for the log file exists and is writable.
   *
   * @note
   * Ensure that you call this method immediately after \ref initialize "initialize",
   * or the output log may not be complete.
   *
   * @param filePath File path of the log file. The string of the log file is in UTF-8.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setLogFile(const char* filePath) = 0;

  /**
   * Sets the output log filter level of the SDK.
   *
   * You can use one or a combination of the filters. The log filter level follows the
   * sequence of `OFF`, `CRITICAL`, `ERROR`, `WARNING`, `INFO`, and `DEBUG`. Choose a filter level
   * and you will see logs preceding that filter level. For example, if you set the log filter level to
   * `WARNING`, you see the logs within levels `CRITICAL`, `ERROR`, and `WARNING`.
   *
   * @param filter The log filter level:
   * - `LOG_FILTER_DEBUG(0x80f)`: Output all API logs. Set your log filter as DEBUG
   * if you want to get the most complete log file.
   * - `LOG_FILTER_INFO(0x0f)`: Output logs of the CRITICAL, ERROR, WARNING, and INFO
   * level. We recommend setting your log filter as this level.
   * - `LOG_FILTER_WARNING(0x0e)`: Output logs of the CRITICAL, ERROR, and WARNING level.
   * - `LOG_FILTER_ERROR(0x0c)`: Output logs of the CRITICAL and ERROR level.
   * - `LOG_FILTER_CRITICAL(0x08)`: Output logs of the CRITICAL level.
   * - `LOG_FILTER_OFF(0)`: Do not output any log.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setLogFilter(unsigned int filter) = 0;

  /**
   * Sets the output log level of the SDK.
   *
   * You can set the SDK to ouput the log files of the specified level.
   *
   * @param level The log level:
   * - `LOG_LEVEL_NONE (0x0000)`: Do not output any log file.
   * - `LOG_LEVEL_INFO (0x0001)`: (Recommended) Output log files of the INFO level.
   * - `LOG_LEVEL_WARN (0x0002)`: Output log files of the WARN level.
   * - `LOG_LEVEL_ERROR (0x0004)`: Output log files of the ERROR level.
   * - `LOG_LEVEL_FATAL (0x0008)`: Output log files of the FATAL level.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setLogLevel(commons::LOG_LEVEL level) = 0;

  /**
   * Sets the log file size (KB).
   *
   * The SDK has two log files, each with a default size of 512 KB. If you set
   * `fileSizeInBytes` as 1024 KB, the SDK outputs log files with a total
   * maximum size of 2 MB.
   * If the total size of the log files exceed the set value,
   * the new output log files overwrite the old output log files.
   *
   * @param fileSizeInKBytes The SDK log file size (KB).
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setLogFileSize(unsigned int fileSizeInKBytes) = 0;

  /** Upload current log file immediately to server.
   *  only use this when an error occurs
   *  block before log file upload success or timeout.
   *
   *  @return
   *  - 0: Success.
   *  - < 0: Failure.
   */
  virtual int uploadLogFile(agora::util::AString& requestId) = 0;

   /** * Write the log to SDK . @technical preview
   *
   * You can Write the log to SDK log files of the specified level.
   *
   * @param level The log level:
   * - `LOG_LEVEL_NONE (0x0000)`: Do not output any log file.
   * - `LOG_LEVEL_INFO (0x0001)`: (Recommended) Output log files of the INFO level.
   * - `LOG_LEVEL_WARN (0x0002)`: Output log files of the WARN level.
   * - `LOG_LEVEL_ERROR (0x0004)`: Output log files of the ERROR level.
   * - `LOG_LEVEL_FATAL (0x0008)`: Output log files of the FATAL level.
   *
   *  @return
   *  - 0: Success.
   *  - < 0: Failure.
   */
  virtual int writeLog(commons::LOG_LEVEL level, const char* fmt, ...) = 0;

  /**
   * Updates the display mode of the local video view.
   *
   * After initializing the local video view, you can call this method to  update its rendering mode.
   * It affects only the video view that the local user sees, not the published local video stream.
   *
   * @note
   * - Ensure that you have called \ref setupLocalVideo "setupLocalVideo" to initialize the local video
   * view before this method.
   * - During a call, you can call this method as many times as necessary to update the local video view.
   *
   * @param renderMode Sets the local display mode. See #RENDER_MODE_TYPE.
   * @param mirrorMode Sets the local mirror mode. See #VIDEO_MIRROR_MODE_TYPE.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setLocalRenderMode(media::base::RENDER_MODE_TYPE renderMode, VIDEO_MIRROR_MODE_TYPE mirrorMode) = 0;

  /**
   * Updates the display mode of the video view of a remote user.
   *
   * After initializing the video view of a remote user, you can call this method to update its
   * rendering and mirror modes. This method affects only the video view that the local user sees.
   *
   * @note
   * - Ensure that you have called \ref setupRemoteVideo "setupRemoteVideo" to initialize the remote video
   * view before calling this method.
   * - During a call, you can call this method as many times as necessary to update the display mode
   * of the video view of a remote user.
   *
   * @param uid ID of the remote user.
   * @param renderMode Sets the remote display mode. See #RENDER_MODE_TYPE.
   * @param mirrorMode Sets the mirror type. See #VIDEO_MIRROR_MODE_TYPE.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setRemoteRenderMode(uid_t uid, media::base::RENDER_MODE_TYPE renderMode,
                                  VIDEO_MIRROR_MODE_TYPE mirrorMode) = 0;

  // The following APIs are either deprecated and going to deleted.

  /**
   * Updates the display mode of the local video view.
   *
   * After initializing the local video view, you can call this method to  update its rendering mode.
   * It affects only the video view that the local user sees, not the published local video stream.
   *
   * @note
   * - Ensure that you have called \ref setupLocalVideo "setupLocalVideo" to initialize the local video
   * view before this method.
   * - During a call, you can call this method as many times as necessary to update the local video view.
   *
   * @param renderMode Sets the local display mode. See #RENDER_MODE_TYPE.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setLocalRenderMode(media::base::RENDER_MODE_TYPE renderMode) __deprecated = 0;

  /**
   * Sets the local video mirror mode.
   *
   * Use this method before calling the \ref startPreview "startPreview" method, or the mirror mode
   * does not take effect until you call the `startPreview` method again.
   * @param mirrorMode Sets the local video mirror mode. See #VIDEO_MIRROR_MODE_TYPE.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setLocalVideoMirrorMode(VIDEO_MIRROR_MODE_TYPE mirrorMode) __deprecated = 0;

  /**
   * Enables or disables the dual video stream mode.
   *
   * If dual-stream mode is enabled, the subscriber can choose to receive the high-stream
   * (high-resolution high-bitrate video stream) or low-stream (low-resolution low-bitrate video stream)
   * video using \ref setRemoteVideoStreamType "setRemoteVideoStreamType".
   *
   * @param enabled
   * - true: Enable the dual-stream mode.
   * - false: (default) Disable the dual-stream mode.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int enableDualStreamMode(bool enabled) __deprecated = 0;

  /**
   * Enables or disables the dual video stream mode.
   *
   * If dual-stream mode is enabled, the subscriber can choose to receive the high-stream
   * (high-resolution high-bitrate video stream) or low-stream (low-resolution low-bitrate video stream)
   * video using \ref setRemoteVideoStreamType "setRemoteVideoStreamType".
   *
   * @param enabled
   * - true: Enable the dual-stream mode.
   * - false: (default) Disable the dual-stream mode.
   * @param streamConfig
   * - The minor stream config
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int enableDualStreamMode(bool enabled, const SimulcastStreamConfig& streamConfig) __deprecated = 0;


  /**
   * Enables, disables or auto enable the dual video stream mode.
   *
   * If dual-stream mode is enabled, the subscriber can choose to receive the high-stream
   * (high-resolution high-bitrate video stream) or low-stream (low-resolution low-bitrate video stream)
   * video using \ref setRemoteVideoStreamType "setRemoteVideoStreamType".
   *
   * @param mode
   * - The dual stream mode
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setDualStreamMode(SIMULCAST_STREAM_MODE mode) = 0;

  /**
   * Sets the multi-layer video stream configuration.
   *
   * If multi-layer is configured, the subscriber can choose to receive the coresponding layer
   * of video stream using {@link setRemoteVideoStreamType setRemoteVideoStreamType}.
   *
   * @param simulcastConfig
   * - The configuration for multi-layer video stream. It includes seven layers, ranging from
   *   STREAM_LAYER_1 to STREAM_LOW. A maximum of 3 layers can be enabled simultaneously.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   * @technical preview
   */
  virtual int setSimulcastConfig(const SimulcastConfig& simulcastConfig) = 0;

  /**
   * Enables, disables or auto enable the dual video stream mode.
   *
   * If dual-stream mode is enabled, the subscriber can choose to receive the high-stream
   * (high-resolution high-bitrate video stream) or low-stream (low-resolution low-bitrate video stream)
   * video using \ref setRemoteVideoStreamType "setRemoteVideoStreamType".
   *
   * @param mode Dual stream mode: #SIMULCAST_STREAM_MODE.
   * @param streamConfig Configurations of the low stream: SimulcastStreamConfig.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setDualStreamMode(SIMULCAST_STREAM_MODE mode, const SimulcastStreamConfig& streamConfig) = 0;

  /**
   * Sets the external audio track.
   *
   * @note
   * Ensure that you call this method before joining the channel.
   *
   * @param trackId custom audio track id.
   * @param enabled Determines whether to local playback the external audio track:
   * - true: Local playback the external audio track.
   * - false: Local don`t playback the external audio track.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int enableCustomAudioLocalPlayback(track_id_t trackId, bool enabled) = 0;

  /**
   * Sets the audio recording format for the
   * \ref agora::media::IAudioFrameObserver::onRecordAudioFrame "onRecordAudioFrame" callback.
   *
   * @param sampleRate The sample rate (Hz) of the audio data returned in the `onRecordAudioFrame` callback, which can set be
   * as 8000, 16000, 32000, 44100, or 48000.
   * @param channel The number of audio channels of the audio data returned in the `onRecordAudioFrame` callback, which can
   * be set as 1 or 2:
   * - 1: Mono.
   * - 2: Stereo.
   * @param mode This mode is deprecated.
   * @param samplesPerCall not support. Sampling points in the called data returned in
   * onRecordAudioFrame(). For example, it is usually set as 1024 for stream
   * pushing.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setRecordingAudioFrameParameters(int sampleRate, int channel,
                                               RAW_AUDIO_FRAME_OP_MODE_TYPE mode,
                                               int samplesPerCall) = 0;

  /**
   * Sets the audio playback format for the
   * \ref agora::media::IAudioFrameObserver::onPlaybackAudioFrame "onPlaybackAudioFrame" callback.
   *
   * @param sampleRate Sets the sample rate (Hz) of the audio data returned in the `onPlaybackAudioFrame` callback,
   * which can set be as 8000, 16000, 32000, 44100, or 48000.
   * @param channel The number of channels of the audio data returned in the `onPlaybackAudioFrame` callback, which
   * can be set as 1 or 2:
   * - 1: Mono
   * - 2: Stereo
   * @param mode Deprecated. The use mode of the onPlaybackAudioFrame() callback:
   * agora::rtc::RAW_AUDIO_FRAME_OP_MODE_TYPE.
   * @param samplesPerCall not support. Sampling points in the called data returned in
   * onPlaybackAudioFrame(). For example, it is usually set as 1024 for stream
   * pushing.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setPlaybackAudioFrameParameters(int sampleRate, int channel,
                                              RAW_AUDIO_FRAME_OP_MODE_TYPE mode,
                                              int samplesPerCall) = 0;

  /**
   * Sets the mixed audio format for the
   * \ref agora::media::IAudioFrameObserver::onMixedAudioFrame "onMixedAudioFrame" callback.
   *
  * @param sampleRate The sample rate (Hz) of the audio data returned in the `onMixedAudioFrame` callback, which can set
  * be as 8000, 16000, 32000, 44100, or 48000.
  * @param channel The number of channels of the audio data in `onMixedAudioFrame` callback, which can be set as 1 or 2:
  * - 1: Mono
  * - 2: Stereo
  * @param samplesPerCall not support. Sampling points in the called data returned in
  * `onMixedAudioFrame`. For example, it is usually set as 1024 for stream pushing.
  * @return
  * - 0: Success.
  * - < 0: Failure.
  */
  virtual int setMixedAudioFrameParameters(int sampleRate, int channel, int samplesPerCall) = 0;

  /**
   * Sets the audio ear monitoring format for the
   * \ref agora::media::IAudioFrameObserver::onEarMonitoringAudioFrame "onEarMonitoringAudioFrame" callback.
   *
   * @param sampleRate Sets the sample rate (Hz) of the audio data returned in the `onEarMonitoringAudioFrame` callback,
   * which can set be as 8000, 16000, 32000, 44100, or 48000.
   * @param channel The number of channels of the audio data returned in the `onEarMonitoringAudioFrame` callback, which
   * can be set as 1 or 2:
   * - 1: Mono
   * - 2: Stereo
   * @param mode Deprecated. The use mode of the onEarMonitoringAudioFrame() callback:
   * agora::rtc::RAW_AUDIO_FRAME_OP_MODE_TYPE.
   * @param samplesPerCall not support. Sampling points in the called data returned in
   * onEarMonitoringAudioFrame(). For example, it is usually set as 1024 for stream
   * pushing.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setEarMonitoringAudioFrameParameters(int sampleRate, int channel,
                                                   RAW_AUDIO_FRAME_OP_MODE_TYPE mode,
                                                   int samplesPerCall) = 0;

  /**
   * Sets the audio playback format before mixing in the
   * \ref agora::media::IAudioFrameObserver::onPlaybackAudioFrameBeforeMixing "onPlaybackAudioFrameBeforeMixing"
   * callback.
   *
   * @param sampleRate The sample rate (Hz) of the audio data returned in
   * `onPlaybackAudioFrameBeforeMixing`, which can set be as 8000, 16000, 32000, 44100, or 48000.
   * @param channel Number of channels of the audio data returned in `onPlaybackAudioFrameBeforeMixing`,
   * which can be set as 1 or 2:
   * - 1: Mono
   * - 2: Stereo
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setPlaybackAudioFrameBeforeMixingParameters(int sampleRate, int channel) = 0;

  /**
   * Enable the audio spectrum monitor.
   *
   * @param intervalInMS Sets the time interval(ms) between two consecutive audio spectrum callback.
   * The default value is 100. This param should be larger than 10.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int enableAudioSpectrumMonitor(int intervalInMS = 100) = 0;
  /**
   * Disalbe the audio spectrum monitor.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int disableAudioSpectrumMonitor() = 0;

  /**
   * Registers an audio spectrum observer.
   *
   * You need to implement the `IAudioSpectrumObserver` class in this method, and register the following callbacks
   * according to your scenario:
   * - \ref agora::media::IAudioSpectrumObserver::onAudioSpectrumComputed "onAudioSpectrumComputed": Occurs when
   * the SDK receives the audio data and at set intervals.
   *
   * @param observer A pointer to the audio spectrum observer: \ref agora::media::IAudioSpectrumObserver
   * "IAudioSpectrumObserver".
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int registerAudioSpectrumObserver(agora::media::IAudioSpectrumObserver * observer) = 0;
  /**
   * Releases the audio spectrum observer.
   *
   * @param observer The pointer to the audio spectrum observer: \ref agora::media::IAudioSpectrumObserver
   * "IAudioSpectrumObserver".
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int unregisterAudioSpectrumObserver(agora::media::IAudioSpectrumObserver * observer) = 0;

  /** Adjusts the recording volume.

  @param volume The recording volume, which ranges from 0 to 400:

  - 0: Mute the recording volume.
  - 100: The Original volume.
  - 400: (Maximum) Four times the original volume with signal clipping
  protection.

  @return
  - 0: Success.
  - < 0: Failure.
  */
  virtual int adjustRecordingSignalVolume(int volume) = 0;

  /**
   * Mute or resume recording signal volume.
   *
   * @param mute Determines whether to mute or resume the recording signal volume.
   * - true: Mute the recording signal volume.
   * - false: (Default) Resume the recording signal volume.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int muteRecordingSignal(bool mute) = 0;

  /** Adjusts the playback volume.

  @param volume The playback volume, which ranges from 0 to 400:

  - 0: Mute the recoridng volume.
  - 100: The Original volume.
  - 400: (Maximum) Four times the original volume with signal clipping
  protection.

  @return
  - 0: Success.
  - < 0: Failure.
  */
  virtual int adjustPlaybackSignalVolume(int volume) = 0;

  /*
   * Adjust the playback volume of the user specified by uid.
   *
   * You can call this method to adjust the playback volume of the user specified by uid
   * in call. If you want to adjust playback volume of the multi user, you can call this
   * this method multi times.
   *
   * @note
   * Please call this method after join channel.
   * This method adjust the playback volume of specified user.
   *
   * @param uid Remote user ID.
   * @param volume The playback volume of the specified remote user. The value ranges between 0 and 400, including the following:
   * 0: Mute.
   * 100: (Default) Original volume.
   * 400: Four times the original volume with signal-clipping protection.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int adjustUserPlaybackSignalVolume(uid_t uid, int volume) = 0;

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

  /** Sets the high priority user list and their fallback level in weak network condition.
   * @note
   * - This method can be called before and after joining a channel.
   * - If a subscriber is set to high priority, this stream only fallback to lower stream after all normal priority users fallback to their fallback level on weak network condition if needed.
   *
   * @param uidList The high priority user list.
   * @param uidNum The size of uidList.
   * @param option The fallback level of high priority users.
   *
   * @return int
   * - 0 : Success.
   * - <0 : Failure.
   */
  virtual int setHighPriorityUserList(uid_t* uidList, int uidNum, STREAM_FALLBACK_OPTIONS option) = 0;

  /**
   * Enable/Disable an extension.
   * By calling this function, you can dynamically enable/disable the extension without changing the pipeline.
   * For example, enabling/disabling Extension_A means the data will be adapted/bypassed by Extension_A.
   *
   * NOTE: For compatibility reasons, if you haven't call registerExtension,
   * enableExtension will automatically register the specified extension.
   * We suggest you call registerExtension explicitly.
   *
   * @param provider The name of the extension provider, e.g. agora.io.
   * @param extension The name of the extension, e.g. agora.beauty.
   * @param extensionInfo The information for extension.
   * @param enable Whether to enable the extension:
   * - true: (Default) Enable the extension.
   * - false: Disable the extension.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int enableExtension(const char* provider, const char* extension, const ExtensionInfo& extensionInfo, bool enable = true) = 0;

  /**
   * Sets the properties of an extension.
   *
   * @param provider The name of the extension provider, e.g. agora.io.
   * @param extension The name of the extension, e.g. agora.beauty.
   * @param extensionInfo The information for extension.
   * @param key The key of the extension.
   * @param value The JSON formatted value of the extension key.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setExtensionProperty(const char* provider, const char* extension, const ExtensionInfo& extensionInfo, const char* key, const char* value) = 0;

  /**
   * Gets the properties of an extension.
   *
   * @param provider The name of the extension provider, e.g. agora.io.
   * @param extension The name of the extension, e.g. agora.beauty.
   * @param extensionInfo The information for extension.
   * @param key The key of the extension.
   * @param value The value of the extension key.
   * @param buf_len Maximum length of the JSON string indicating the extension property.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int getExtensionProperty(const char* provider, const char* extension, const ExtensionInfo& extensionInfo, const char* key, char* value, int buf_len)  = 0;

  /** Enables loopback recording.
   *
   * If you enable loopback recording, the output of the default sound card is mixed into
   * the audio stream sent to the other end.
   *
   * @note This method is for Windows only.
   *
   * @param enabled Sets whether to enable/disable loopback recording.
   * - true: Enable loopback recording.
   * - false: (Default) Disable loopback recording.
   * @param deviceName Pointer to the device name of the sound card. The default value is NULL (the default sound card).
   * - This method is for macOS and Windows only.
   * - macOS does not support loopback capturing of the default sound card. If you need to use this method,
   * please use a virtual sound card and pass its name to the deviceName parameter. Agora has tested and recommends using soundflower.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int enableLoopbackRecording(bool enabled, const char* deviceName = NULL) = 0;


  /** Adjusts the loopback recording volume.

  @param volume The loopback volume, which ranges from 0 to 100:

  - 0: Mute the recoridng volume.
  - 100: The Original volume.
  protection.

  @return
  - 0: Success.
  - < 0: Failure.
  */
  virtual int adjustLoopbackSignalVolume(int volume) = 0;

  /** Retrieves the audio volume for recording loopback.
  @note Call this method when you are in a channel.
  @return
  - &ge; 0: The audio volume for loopback, if this method call succeeds. The value range is [0,100].
  - < 0: Failure.
  */
  virtual int getLoopbackRecordingVolume() = 0;

  /**
   * Enables in-ear monitoring.
   *
   * @param enabled Determines whether to enable in-ear monitoring.
   * - true: Enable.
   * - false: (Default) Disable.
   * @param includeAudioFilters The type of the ear monitoring: #EAR_MONITORING_FILTER_TYPE
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int enableInEarMonitoring(bool enabled, int includeAudioFilters) = 0;

  /**
   * Sets the volume of the in-ear monitor.
   *
   * @param volume Sets the volume of the in-ear monitor. The value ranges
   * between 0 and 100 (default).
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setInEarMonitoringVolume(int volume) = 0;

#if defined (_WIN32) || defined(__linux__) || defined(__ANDROID__)
  virtual int loadExtensionProvider(const char* path, bool unload_after_use = false) = 0;
#endif

  /**
   * Sets the provider property of an extension.
   *
   * @param provider The name of the extension provider, e.g. agora.io.
   * @param key The key of the extension.
   * @param value The JSON formatted value of the extension key.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setExtensionProviderProperty(const char* provider, const char* key, const char* value) = 0;

  /**
   * Registers an extension. Normally you should call this function immediately after engine initialization.
   * Once an extension is registered, the SDK will automatically create and add it to the pipeline.
   *
   * @param provider The name of the extension provider, e.g. agora.io.
   * @param extension The name of the extension, e.g. agora.beauty.
   * @param type The source type of the extension, e.g. PRIMARY_CAMERA_SOURCE. The default is UNKNOWN_MEDIA_SOURCE.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int registerExtension(const char* provider, const char* extension, agora::media::MEDIA_SOURCE_TYPE type = agora::media::UNKNOWN_MEDIA_SOURCE) = 0;

  /**
   * Enable/Disable an extension.
   * By calling this function, you can dynamically enable/disable the extension without changing the pipeline.
   * For example, enabling/disabling Extension_A means the data will be adapted/bypassed by Extension_A.
   *
   * NOTE: For compatibility reasons, if you haven't call registerExtension,
   * enableExtension will automatically register the specified extension.
   * We suggest you call registerExtension explicitly.
   *
   * @param provider The name of the extension provider, e.g. agora.io.
   * @param extension The name of the extension, e.g. agora.beauty.
   * @param enable Whether to enable the extension:
   * - true: (Default) Enable the extension.
   * - false: Disable the extension.
   * @param type The source type of the extension, e.g. PRIMARY_CAMERA_SOURCE. The default is UNKNOWN_MEDIA_SOURCE.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int enableExtension(const char* provider, const char* extension, bool enable=true, agora::media::MEDIA_SOURCE_TYPE type = agora::media::UNKNOWN_MEDIA_SOURCE) = 0;

  /**
   * Sets the properties of an extension.
   *
   * @param provider The name of the extension provider, e.g. agora.io.
   * @param extension The name of the extension, e.g. agora.beauty.
   * @param key The key of the extension.
   * @param value The JSON formatted value of the extension key.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setExtensionProperty(
      const char* provider, const char* extension,
      const char* key, const char* value, agora::media::MEDIA_SOURCE_TYPE type = agora::media::UNKNOWN_MEDIA_SOURCE) = 0;

  /**
   * Gets the properties of an extension.
   *
   * @param provider The name of the extension provider, e.g. agora.io.
   * @param extension The name of the extension, e.g. agora.beauty.
   * @param key The key of the extension.
   * @param value The value of the extension key.
   * @param buf_len Maximum length of the JSON string indicating the extension property.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int getExtensionProperty(
      const char* provider, const char* extension,
      const char* key, char* value, int buf_len, agora::media::MEDIA_SOURCE_TYPE type = agora::media::UNKNOWN_MEDIA_SOURCE) = 0;

  /** Sets the camera capture configuration.
   * @note Call this method before enabling the local camera.
   * That said, you can call this method before calling \ref IRtcEngine::joinChannel "joinChannel",
   * \ref IRtcEngine::enableVideo "enableVideo", or \ref IRtcEngine::enableLocalVideo "enableLocalVideo",
   * depending on which method you use to turn on your local camera.
   *
   * @param config Sets the camera capturer configuration. See CameraCapturerConfiguration.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setCameraCapturerConfiguration(const CameraCapturerConfiguration& config) = 0;

  /**
   * Get an custom video track id created by internal,which could used to publish or preview
   *
   * @return
   * - > 0: the useable video track id.
   * - < 0: Failure.
   */
  virtual video_track_id_t createCustomVideoTrack() = 0;

  /**
   * Get an custom encoded video track id created by internal,which could used to publish or preview
   *
   * @return
   * - > 0: the useable video track id.
   * - < 0: Failure.
   */
  virtual video_track_id_t createCustomEncodedVideoTrack(const SenderOptions& sender_option) = 0;

  /**
   * destroy a created custom video track id
   *
   * @param video_track_id The video track id which was created by createCustomVideoTrack
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int destroyCustomVideoTrack(video_track_id_t video_track_id) = 0;

  /**
   * destroy a created custom encoded video track id
   *
   * @param video_track_id The video track id which was created by createCustomEncodedVideoTrack
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int destroyCustomEncodedVideoTrack(video_track_id_t video_track_id) = 0;

#if defined(__ANDROID__) || (defined(__APPLE__) && TARGET_OS_IOS)
  /**
   * Switches between front and rear cameras.
   *
   * @note This method applies to Android and iOS only.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int switchCamera() = 0;

  /**
   * Checks whether the camera zoom function is supported.
   *
   * @return
   * - true: The camera zoom function is supported.
   * - false: The camera zoom function is not supported.
   */
  virtual bool isCameraZoomSupported() = 0;

  /**
   * Checks whether the camera face detect is supported.
   *
   * @return
   * - true: The camera face detect is supported.
   * - false: The camera face detect is not supported.
   */
  virtual bool isCameraFaceDetectSupported() = 0;

  /**
   * Checks whether the camera flash function is supported.
   *
   * @return
   * - true: The camera flash function is supported.
   * - false: The camera flash function is not supported.
   */
  virtual bool isCameraTorchSupported() = 0;

  /**
   * Checks whether the camera manual focus function is supported.
   *
   * @return
   * - true: The camera manual focus function is supported.
   * - false: The camera manual focus function is not supported.
   */
  virtual bool isCameraFocusSupported() = 0;

  /**
   * Checks whether the camera auto focus function is supported.
   *
   * @return
   * - true: The camera auto focus function is supported.
   * - false: The camera auto focus function is not supported.
   */
  virtual bool isCameraAutoFocusFaceModeSupported() = 0;

  /**
   * Sets the camera zoom ratio.
   *
   * @param factor The camera zoom factor. It ranges from 1.0 to the maximum zoom
   * supported by the camera.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setCameraZoomFactor(float factor) = 0;

  /**
   * Sets the camera face detection.
   *
   * @param enabled The camera face detection enabled.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int enableFaceDetection(bool enabled) = 0;

  /**
   * Gets the maximum zoom ratio supported by the camera.
   * @return The maximum zoom ratio supported by the camera.
   */
  virtual float getCameraMaxZoomFactor() = 0;

  /**
   * Sets the manual focus position.
   *
   * @param positionX The horizontal coordinate of the touch point in the view.
   * @param positionY The vertical coordinate of the touch point in the view.
   * @return
   * - 0: Success.
   * - < 0: Failure.
  */
  virtual int setCameraFocusPositionInPreview(float positionX, float positionY) = 0;

  /**
   * Enables the camera flash.
   *
   * @param isOn Determines whether to enable the camera flash.
   * - true: Enable the flash.
   * - false: Do not enable the flash.
   */
  virtual int setCameraTorchOn(bool isOn) = 0;

  /**
   * Enables the camera auto focus face function.
   *
   * @param enabled Determines whether to enable the camera auto focus face mode.
   * - true: Enable the auto focus face function.
   * - false: Do not enable the auto focus face function.
   */
  virtual int setCameraAutoFocusFaceModeEnabled(bool enabled) = 0;

  /** Checks whether the camera exposure function is supported.
   *
   * Ensure that you call this method after the camera starts, for example, by calling `startPreview` or `joinChannel`.
   *
   * @since v2.3.2.
   * @return
   * <ul>
   *     <li>true: The device supports the camera exposure function.</li>
   *     <li>false: The device does not support the camera exposure function.</li>
   * </ul>
   */
  virtual bool isCameraExposurePositionSupported() = 0;

  /** Sets the camera exposure position.
   *
   * Ensure that you call this method after the camera starts, for example, by calling `startPreview` or `joinChannel`.
   *
   * A successful setCameraExposurePosition method call triggers the {@link IRtcEngineEventHandler#onCameraExposureAreaChanged onCameraExposureAreaChanged} callback on the local client.
   * @since v2.3.2.
   * @param positionXinView The horizontal coordinate of the touch point in the view.
   * @param positionYinView The vertical coordinate of the touch point in the view.
   *
   * @return
   * <ul>
   *     <li>0: Success.</li>
   *     <li>< 0: Failure.</li>
   * </ul>
   */
  virtual int setCameraExposurePosition(float positionXinView, float positionYinView) = 0;

  /**
  * Returns whether exposure value adjusting is supported by the current device.
  * Exposure compensation is in auto exposure mode.
  * @since v4.2.2
  * @note
  * This method only supports Android and iOS.
  * This interface returns valid values only after the device is initialized.
  *
  * @return
  * - true: exposure value adjusting is supported.
  * - false: exposure value adjusting is not supported or device is not initialized.
  */
  virtual bool isCameraExposureSupported() = 0;

  /**
   * Sets the camera exposure ratio.
   * @since v4.2.2
   * @param factor The camera zoom factor. The recommended camera exposure factor ranging from -8.0 to 8.0 for iOS,
   *        and -20.0 to 20.0 for Android.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setCameraExposureFactor(float factor) = 0;

#if defined(__APPLE__)
  /**
   * Checks whether the camera auto exposure function is supported.
   *
   * @return
   * - true: The camera auto exposure function is supported.
   * - false: The camera auto exposure function is not supported.
   */
  virtual bool isCameraAutoExposureFaceModeSupported() = 0;


  /**
   * Enables the camera auto exposure face function.
   *
   * @param enabled Determines whether to enable the camera auto exposure face mode.
   * - true: Enable the auto exposure face function.
   * - false: Do not enable the auto exposure face function.
   */
  virtual int setCameraAutoExposureFaceModeEnabled(bool enabled) = 0;

  /**
   * set camera stabilization mode.If open stabilization mode, fov will be smaller and capture latency will be longer.
   *
   * @param mode specifies the camera stabilization mode.
   */
  virtual int setCameraStabilizationMode(CAMERA_STABILIZATION_MODE mode) = 0;
#endif

  /** Sets the default audio route (for Android and iOS only).

   Most mobile phones have two audio routes: an earpiece at the top, and a
   speakerphone at the bottom. The earpiece plays at a lower volume, and the
   speakerphone at a higher volume.

   When setting the default audio route, you determine whether audio playback
   comes through the earpiece or speakerphone when no external audio device is
   connected.

   Depending on the scenario, Agora uses different default audio routes:
   - Voice call: Earpiece
   - Audio broadcast: Speakerphone
   - Video call: Speakerphone
   - Video broadcast: Speakerphone

   Call this method before, during, or after a call, to change the default
   audio route. When the audio route changes, the SDK triggers the
   \ref IRtcEngineEventHandler::onAudioRoutingChanged "onAudioRoutingChanged"
   callback.

   @note The system audio route changes when an external audio device, such as
   a headphone or a Bluetooth audio device, is connected. See *Principles for changing the audio route*.

   @param defaultToSpeaker Whether to set the speakerphone as the default audio
   route:
   - true: Set the speakerphone as the default audio route.
   - false: Do not set the speakerphone as the default audio route.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setDefaultAudioRouteToSpeakerphone(bool defaultToSpeaker) = 0;

  /** Enables/Disables the speakerphone temporarily (for Android and iOS only).

   When the audio route changes, the SDK triggers the
   \ref IRtcEngineEventHandler::onAudioRoutingChanged "onAudioRoutingChanged"
   callback.

   You can call this method before, during, or after a call. However, Agora
   recommends calling this method only when you are in a channel to change
   the audio route temporarily.

   @note This method sets the audio route temporarily. Plugging in or
   unplugging a headphone, or the SDK re-enabling the audio device module
   (ADM) to adjust the media volume in some scenarios relating to audio, leads
   to a change in the audio route. See *Principles for changing the audio
   route*.

   @param speakerOn Whether to set the speakerphone as the temporary audio
   route:
   - true: Set the speakerphone as the audio route temporarily. (For iOS only:
   calling setEnableSpeakerphone(true) does not change the audio route to the
   speakerphone if a headphone or a Bluetooth audio device is connected.)
   - false: Do not set the speakerphone as the audio route.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setEnableSpeakerphone(bool speakerOn) = 0;

  /** Checks whether the speakerphone is enabled (for Android and iOS only).

   @return
   - true: The speakerphone is enabled, and the audio plays from the speakerphone.
   - false: The speakerphone is not enabled, and the audio plays from devices
   other than the speakerphone. For example, the headset or earpiece.
   */
  virtual bool isSpeakerphoneEnabled() = 0;

    /** Select preferred route for android communication mode

   @param route The preferred route. For example, when a Bluetooth headset is connected,
   you can use this API to switch the route to a wired headset.
   @return meanless, route switch result is pass through CallbackOnRoutingChanged
   */
  virtual int setRouteInCommunicationMode(int route) = 0;

#endif  // __ANDROID__ || (__APPLE__ && TARGET_OS_IOS)

#if defined(__APPLE__)
  /**
   * Checks whether the center stage is supported. Use this method after starting the camera.
   *
   * @return
   * - true: The center stage is supported.
   * - false: The center stage is not supported.
   */
  virtual bool isCameraCenterStageSupported() = 0;

  /** Enables the camera Center Stage.
   * @param enabled enable Center Stage:
   * - true: Enable Center Stage.
   * - false: Disable Center Stage.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int enableCameraCenterStage(bool enabled) = 0;
#endif

#if defined(_WIN32) || (defined(__APPLE__) && TARGET_OS_MAC && !TARGET_OS_IPHONE)
  /** Get \ref ScreenCaptureSourceInfo list including available windows and screens.
    *
    * @param thumbSize Set expected size for thumb, image will be scaled accordingly. For windows, SIZE is defined in windef.h.
    * @param iconSize Set expected size for icon, image will be scaled accordingly. For windows, SIZE is defined in windef.h.
    * @param includeScreen Determines whether to include screens info.
    * - true: sources will have screens info
    * - false: source will only have windows info
    * @return
    * - IScreenCaptureSourceList* a pointer to an instance of IScreenCaptureSourceList
    */
  virtual IScreenCaptureSourceList* getScreenCaptureSources(const SIZE& thumbSize, const SIZE& iconSize, const bool includeScreen) = 0;
#endif // _WIN32 || (__APPLE__ && !TARGET_OS_IPHONE && TARGET_OS_MAC)
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
#endif // __APPLE__ && TARGET_OS_IOS

#if defined(_WIN32) || (defined(__APPLE__) && !TARGET_OS_IPHONE && TARGET_OS_MAC)

  /** Shares the whole or part of a screen by specifying the display ID.

  @note This method applies to macOS only.

  @param  displayId The display ID of the screen to be shared. This parameter
  specifies which screen you want to share. For information on how to get the
  displayId, see the advanced guide: Share the Screen.
  @param regionRect (Optional) Sets the relative location of the region to the
  screen. NIL means sharing the whole screen. See Rectangle.
  If the specified region overruns the screen, the SDK shares only the region
  within it; if you set width or height as 0, the SDK shares the whole screen.
  @param captureParams Sets the screen sharing encoding parameters. See
  ScreenCaptureParameters.

  @return
  - 0: Success.
  - < 0: Failure:
  - ERR_INVALID_ARGUMENT (2): The argument is invalid.
  - ERR_NOT_INITIALIZED (7): You have not initialized IRtcEngine when try to start screen capture.
  */
  virtual int startScreenCaptureByDisplayId(uint32_t displayId, const Rectangle& regionRect,
                                            const ScreenCaptureParameters& captureParams) = 0;

#endif  // __APPLE__ && TARGET_OS_MAC && !TARGET_OS_IPHONE

#if defined(_WIN32)
  /**
   * Shares the whole or part of a screen by specifying the screen rect.
   *
   * @deprecated This method is deprecated, use \ref IRtcEngine::startScreenCaptureByDisplayId "startScreenCaptureByDisplayId" instead. Agora strongly recommends using `startScreenCaptureByDisplayId` if you need to start screen sharing on a device connected to another display.
   *
   * @note This method applies to Windows only.
   *
   * @param screenRect Sets the relative location of the screen to the virtual
   * screen. For information on how to get screenRect, see the advanced guide:
   * Share the Screen.
   * @param regionRect (Optional) Sets the relative location of the region to the
   * screen. NULL means sharing the whole screen. See Rectangle.
   * If the specified region overruns the screen, the SDK shares only the region
   * within it; if you set width or height as 0, the SDK shares the whole screen.
   * @param captureParams Sets the screen sharing encoding parameters. See
   * ScreenCaptureParameters.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure:
   * - ERR_INVALID_ARGUMENT (2): The argument is invalid.
   * - ERR_NOT_INITIALIZED (7): You have not initialized IRtcEngine when try to start screen capture.
  */
  virtual int startScreenCaptureByScreenRect(const Rectangle& screenRect,
                                             const Rectangle& regionRect,
                                             const ScreenCaptureParameters& captureParams) __deprecated = 0;
#endif

#if defined(__ANDROID__)
  /**
   * Gets the the Audio device Info
   * @return
   * - 0: Success.
   * - < 0: Failure..
   */
  virtual int getAudioDeviceInfo(DeviceInfo& deviceInfo) = 0;
#endif  // __ANDROID__

#if defined(_WIN32) || (defined(__APPLE__) && TARGET_OS_MAC && !TARGET_OS_IPHONE)

 /** Shares the whole or part of a window by specifying the window ID.
  *
  * @param windowId The ID of the window to be shared. For information on how to
  * get the windowId, see the advanced guide *Share Screen*.
  * @param regionRect (Optional) The relative location of the region to the
  * window. NULL means sharing the whole window. See Rectangle. If the
  * specified region overruns the window, the SDK shares only the region within
  * it; if you set width or height as 0, the SDK shares the whole window.
  * @param captureParams The window sharing encoding parameters. See
  * ScreenCaptureParameters.
  *
  * @return
  * - 0: Success.
  * - < 0: Failure:
  * - ERR_INVALID_ARGUMENT (2): The argument is invalid.
  * - ERR_NOT_INITIALIZED (7): You have not initialized IRtcEngine when try to start screen capture.
  */
  virtual int startScreenCaptureByWindowId(view_t windowId, const Rectangle& regionRect,
                                           const ScreenCaptureParameters& captureParams) = 0;

  /**
   * Sets the content hint for screen sharing.
   *
   * A content hint suggests the type of the content being shared, so that the SDK applies different
   * optimization algorithm to different types of content.
   *
   * @param contentHint Sets the content hint for screen sharing: #VIDEO_CONTENT_HINT.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure:
   * - ERR_NOT_SUPPORTED (4): unable to set screencapture content hint
   * - ERR_FAILED (1): A general error occurs (no specified reason).
   * - ERR_NOT_INITIALIZED (7): You have not initialized IRtcEngine when set screen capture content hint.
   */
  virtual int setScreenCaptureContentHint(VIDEO_CONTENT_HINT contentHint) = 0;

  /**
   * Updates the screen sharing region.
   *
   * @param regionRect Sets the relative location of the region to the screen or
   * window. NULL means sharing the whole screen or window. See Rectangle.
   * If the specified region overruns the screen or window, the SDK shares only
   * the region within it; if you set width or height as 0, the SDK shares the
   * whole screen or window.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure:
   * - ERR_NOT_SUPPORTED (4): unable to update screen capture region
   * - ERR_FAILED (1): A general error occurs (no specified reason).
   * - ERR_NOT_INITIALIZED (7): You have not initialized IRtcEngine when update screen capture regoin.
   */
  virtual int updateScreenCaptureRegion(const Rectangle& regionRect) = 0;

  /**
   * Updates the screen sharing parameters.
   *
   * @param captureParams Sets the screen sharing encoding parameters: ScreenCaptureParameters.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   * - ERR_NOT_SUPPORTED (4): unable to update screen capture parameters
   * - ERR_INVALID_ARGUMENT (2): The argument is invalid.
   * - ERR_FAILED (1): A general error occurs (no specified reason).
   * - ERR_NOT_INITIALIZED (7): You have not initialized IRtcEngine when update screen capture parameters.
   */
  virtual int updateScreenCaptureParameters(const ScreenCaptureParameters& captureParams) = 0;
#endif // _WIN32 || (__APPLE__ && !TARGET_OS_IPHONE && TARGET_OS_MAC)

#if defined(__ANDROID__) || (defined(__APPLE__) && TARGET_OS_IOS)
  /**
   * Starts screen sharing.
   *
   * @param captureParams The configuration of the screen sharing. See {@link
   *     ScreenCaptureParameters ScreenCaptureParameters}.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int startScreenCapture(const ScreenCaptureParameters2& captureParams) = 0;

  /**
   * Updates the screen sharing configuration.
   *
   * @param captureParams The configuration of the screen sharing. See {@link
   *     ScreenCaptureParameters ScreenCaptureParameters}.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int updateScreenCapture(const ScreenCaptureParameters2& captureParams) = 0;
    
   /**
   * Queries the ability of screen sharing to support the maximum frame rate.
   *
   * @since v4.2.0
   * 
   * @return
   * - 0: support 15 fps, Low devices.
   * - 1: support 30 fps, Usually low - to mid-range devices.
   * - 2: support 60 fps, Advanced devices.
   * - < 0: Failure.
   */
  virtual int queryScreenCaptureCapability() = 0;

  /**
   * Query all focal attributes supported by the camera.
   * 
   * @param focalLengthInfos The camera supports the collection of focal segments.Ensure the size of array is not less than 8.
   * 
   * @param size The camera supports the size of the focal segment set. Ensure the size is not less than 8.
   * 
   * @return
   * - 0: Success.
   * - < 0: Failure..
   */
  virtual int queryCameraFocalLengthCapability(agora::rtc::FocalLengthInfo* focalLengthInfos, int& size) = 0;
#endif

#if defined(_WIN32) || defined(__APPLE__) || defined(__ANDROID__)
  /**
   * Sets the screen sharing scenario.
   *
   *
   * When you start screen sharing or window sharing, you can call this method to set the screen sharing scenario. The SDK adjusts the video quality and experience of the sharing according to the scenario.
   *
   *
   * @param screenScenario The screen sharing scenario. See #SCREEN_SCENARIO_TYPE.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   * - ERR_NOT_SUPPORTED (4): unable to set screencapture scenario
   * - ERR_FAILED (1): A general error occurs (no specified reason).
   * - ERR_NOT_INITIALIZED (7): You have not initialized IRtcEngine when set screencapture scenario.
   */
  virtual int setScreenCaptureScenario(SCREEN_SCENARIO_TYPE screenScenario) = 0;
  
  /**
   * Stops the screen sharing.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int stopScreenCapture() = 0;
#endif  // _WIN32 || (__APPLE__ && !TARGET_OS_IPHONE && TARGET_OS_MAC) || __ANDROID__

  /**
   * Gets the current call ID.
   *
   * When a user joins a channel on a client, a `callId` is generated to identify
   * the call.
   *
   * After a call ends, you can call `rate` or `complain` to gather feedback from the customer.
   * These methods require a `callId` parameter. To use these feedback methods, call the this
   * method first to retrieve the `callId` during the call, and then pass the value as an
   * argument in the `rate` or `complain` method after the call ends.
   *
   * @param callId The reference to the call ID.
   * @return
   * - The call ID if the method call is successful.
   * - < 0: Failure.
  */
  virtual int getCallId(agora::util::AString& callId) = 0;

  /**
   * Allows a user to rate the call.
   *
   * It is usually called after the call ends.
   *
   * @param callId The call ID retrieved from the \ref getCallId "getCallId" method.
   * @param rating The rating of the call between 1 (the lowest score) to 5 (the highest score).
   * @param description (Optional) The description of the rating. The string length must be less than
   * 800 bytes.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int rate(const char* callId, int rating, const char* description) = 0;  // 0~10

  /**
   * Allows a user to complain about the call quality.
   *
   * This method is usually called after the call ends.
   *
   * @param callId The call ID retrieved from the `getCallId` method.
   * @param description (Optional) The description of the complaint. The string length must be less than
   * 800 bytes.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int complain(const char* callId, const char* description) = 0;

  /** Publishes the local stream without transcoding to a specified CDN live RTMP address.  (CDN live only.)

    * The SDK returns the result of this method call in the \ref IRtcEngineEventHandler::onStreamPublished "onStreamPublished" callback.

    * The \ref agora::rtc::IRtcEngine::startRtmpStreamWithoutTranscoding "startRtmpStreamWithoutTranscoding" method call triggers the \ref agora::rtc::IRtcEngineEventHandler::onRtmpStreamingStateChanged "onRtmpStreamingStateChanged" callback on the local client to report the state of adding a local stream to the CDN.
    * @note
    * - Ensure that the user joins the channel before calling this method.
    * - This method adds only one stream RTMP URL address each time it is called.
    * - The RTMP URL address must not contain special characters, such as Chinese language characters.
    * - This method applies to Live Broadcast only.

    * @param url The CDN streaming URL in the RTMP format. The maximum length of this parameter is 1024 bytes.

    * @return
    * - 0: Success.
    * - < 0: Failure.
    *   - #ERR_INVALID_ARGUMENT (2): The RTMP URL address is NULL or has a string length of 0.
    *   - #ERR_NOT_INITIALIZED (7): You have not initialized the RTC engine when publishing the stream.
    *   - #ERR_ALREADY_IN_USE (19): This streaming URL is already in use. Use a new streaming URL for CDN streaming.
    */
  virtual int startRtmpStreamWithoutTranscoding(const char* url) = 0;

  /** Publishes the local stream with transcoding to a specified CDN live RTMP address.  (CDN live only.)

    * The SDK returns the result of this method call in the \ref IRtcEngineEventHandler::onStreamPublished "onStreamPublished" callback.

    * The \ref agora::rtc::IRtcEngine::startRtmpStreamWithTranscoding "startRtmpStreamWithTranscoding" method call triggers the \ref agora::rtc::IRtcEngineEventHandler::onRtmpStreamingStateChanged "onRtmpStreamingStateChanged" callback on the local client to report the state of adding a local stream to the CDN.
    * @note
    * - Ensure that the user joins the channel before calling this method.
    * - This method adds only one stream RTMP URL address each time it is called.
    * - The RTMP URL address must not contain special characters, such as Chinese language characters.
    * - This method applies to Live Broadcast only.

    * @param url The CDN streaming URL in the RTMP format. The maximum length of this parameter is 1024 bytes.
    * @param transcoding Sets the CDN live audio/video transcoding settings.  See LiveTranscoding.

    * @return
    * - 0: Success.
    * - < 0: Failure.
    *   - #ERR_INVALID_ARGUMENT (2): The RTMP URL address is NULL or has a string length of 0.
    *   - #ERR_NOT_INITIALIZED (7): You have not initialized the RTC engine when publishing the stream.
    *   - #ERR_ALREADY_IN_USE (19): This streaming URL is already in use. Use a new streaming URL for CDN streaming.
    */
  virtual int startRtmpStreamWithTranscoding(const char* url, const LiveTranscoding& transcoding) = 0;

  /** Update the video layout and audio settings for CDN live. (CDN live only.)
    * @note This method applies to Live Broadcast only.

    * @param transcoding Sets the CDN live audio/video transcoding settings. See LiveTranscoding.

    * @return
    * - 0: Success.
    * - < 0: Failure.
    */
  virtual int updateRtmpTranscoding(const LiveTranscoding& transcoding) = 0;

  virtual int startLocalVideoTranscoder(const LocalTranscoderConfiguration& config) = 0;
  virtual int updateLocalTranscoderConfiguration(const LocalTranscoderConfiguration& config) = 0;

  /** Stop an RTMP stream with transcoding or without transcoding from the CDN. (CDN live only.)

    * This method removes the RTMP URL address (added by the \ref IRtcEngine::startRtmpStreamWithoutTranscoding "startRtmpStreamWithoutTranscoding" method
    * or IRtcEngine::startRtmpStreamWithTranscoding "startRtmpStreamWithTranscoding" method) from a CDN live stream.
    * The SDK returns the result of this method call in the \ref IRtcEngineEventHandler::onStreamUnpublished "onStreamUnpublished" callback.

    * The \ref agora::rtc::IRtcEngine::stopRtmpStream "stopRtmpStream" method call triggers the \ref agora::rtc::IRtcEngineEventHandler::onRtmpStreamingStateChanged "onRtmpStreamingStateChanged" callback on the local client to report the state of removing an RTMP stream from the CDN.
    * @note
    * - This method removes only one RTMP URL address each time it is called.
    * - The RTMP URL address must not contain special characters, such as Chinese language characters.
    * - This method applies to Live Broadcast only.

    * @param url The RTMP URL address to be removed. The maximum length of this parameter is 1024 bytes.

    * @return
    * - 0: Success.
    * - < 0: Failure.
    */
  virtual int stopRtmpStream(const char* url) = 0;

  virtual int stopLocalVideoTranscoder() = 0;
  /**
   * Starts video capture with a camera.
   *
   * @param config The configuration of the video capture with a primary camera. For details, see CameraCaptureConfiguration.
   * @param sourceType Source type of camera. See #VIDEO_SOURCE_TYPE.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int startCameraCapture(VIDEO_SOURCE_TYPE sourceType, const CameraCapturerConfiguration& config) = 0;

  /**
   * Stops capturing video through camera.
   *
   * You can call this method to stop capturing video through the first camera after calling `startCameraCapture`.
   *
   * @param sourceType Source type of camera. See #VIDEO_SOURCE_TYPE.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int stopCameraCapture(VIDEO_SOURCE_TYPE sourceType) = 0;
  /**
   * Sets the rotation angle of the video captured by the camera.
   *
   * When the video capture device does not have the gravity sensing function, you can call this method to manually adjust the rotation angle of the captured video.
   *
   * @param type The video source type. See #VIDEO_SOURCE_TYPE.
   * @param orientation The clockwise rotation angle. See #VIDEO_ORIENTATION.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setCameraDeviceOrientation(VIDEO_SOURCE_TYPE type, VIDEO_ORIENTATION orientation) = 0;
  /**
   * Sets the rotation angle of the video captured by the screen.
   *
   * When the screen capture device does not have the gravity sensing function, you can call this method to manually adjust the rotation angle of the captured video.
   *
   * @param type The video source type. See #VIDEO_SOURCE_TYPE.
   * @param orientation The clockwise rotation angle. See #VIDEO_ORIENTATION.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setScreenCaptureOrientation(VIDEO_SOURCE_TYPE type, VIDEO_ORIENTATION orientation) = 0;

  /**
   * Starts sharing a screen.
   *
   * @param config The configuration of the captured screen. For details, see ScreenCaptureConfiguration.
   * @param sourceType source type of screen. See #VIDEO_SOURCE_TYPE.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int startScreenCapture(VIDEO_SOURCE_TYPE sourceType, const ScreenCaptureConfiguration& config) = 0;

  /**
   * Stop sharing the screen.
   *
   * After calling `startScreenCapture`, you can call this method to stop sharing the first screen.
   * 
   * @param sourceType source type of screen. See #VIDEO_SOURCE_TYPE.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int stopScreenCapture(VIDEO_SOURCE_TYPE sourceType) = 0;

  /** Gets the current connection state of the SDK.

   @return #CONNECTION_STATE_TYPE.
   */
  virtual CONNECTION_STATE_TYPE getConnectionState() = 0;

  // The following APIs are not implemented yet.
  virtual bool registerEventHandler(IRtcEngineEventHandler* eventHandler) = 0;
  virtual bool unregisterEventHandler(IRtcEngineEventHandler* eventHandler) = 0;
  virtual int setRemoteUserPriority(uid_t uid, PRIORITY_TYPE userPriority) = 0;

  /**
   * Registers a packet observer.
   *
   * The Agora Native SDK allows your app to register a packet observer to
   * receive events whenever a voice or video packet is transmitting.
   *
   * @param observer The IPacketObserver object.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int registerPacketObserver(IPacketObserver* observer) = 0;


  /** Enables/Disables the built-in encryption.
   *
   * In scenarios requiring high security, Agora recommends calling this method to enable the built-in encryption before joining a channel.
   *
   * All users in the same channel must use the same encryption mode and encryption key. Once all users leave the channel, the encryption key of this channel is automatically cleared.
   *
   * @note
   * - If you enable the built-in encryption, you cannot use the RTMP streaming function.
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

  /** Creates a data stream.
   *
   * You can call this method to create a data stream and improve the
   * reliability and ordering of data tranmission.
   *
   * @note
   * - Ensure that you set the same value for `reliable` and `ordered`.
   * - Each user can only create a maximum of 5 data streams during a RtcEngine
   * lifecycle.
   * - The data channel allows a data delay of up to 5 seconds. If the receiver
   * does not receive the data stream within 5 seconds, the data channel reports
   * an error.
   *
   * @param[out] streamId The ID of the stream data.
   * @param reliable Sets whether the recipients are guaranteed to receive
   * the data stream from the sender within five seconds:
   * - true: The recipients receive the data stream from the sender within
   * five seconds. If the recipient does not receive the data stream within
   * five seconds, an error is reported to the application.
   * - false: There is no guarantee that the recipients receive the data stream
   * within five seconds and no error message is reported for any delay or
   * missing data stream.
   * @param ordered Sets whether the recipients receive the data stream
   * in the sent order:
   * - true: The recipients receive the data stream in the sent order.
   * - false: The recipients do not receive the data stream in the sent order.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int createDataStream(int* streamId, bool reliable, bool ordered) = 0;

  /** Creates a data stream.
   *
   * Each user can create up to five data streams during the lifecycle of the IChannel.
   * @param streamId The ID of the created data stream.
   * @param config  The config of data stream.
   * @return int
   * - Returns 0: Success.
   * - < 0: Failure.
   */
  virtual int createDataStream(int* streamId, const DataStreamConfig& config) = 0;

  /** Sends a data stream.
   *
   * After calling \ref IRtcEngine::createDataStream "createDataStream", you can call
   * this method to send a data stream to all users in the channel.
   *
   * The SDK has the following restrictions on this method:
   * - Up to 60 packets can be sent per second in a channel with each packet having a maximum size of 1 KB.
   * - Each client can send up to 30 KB of data per second.
   * - Each user can have up to five data streams simultaneously.
   *
   * After the remote user receives the data stream within 5 seconds, the SDK triggers the
   * \ref IRtcEngineEventHandler::onStreamMessage "onStreamMessage" callback on
   * the remote client. After the remote user does not receive the data stream within 5 seconds,
   * the SDK triggers the \ref IRtcEngineEventHandler::onStreamMessageError "onStreamMessageError"
   * callback on the remote client.
   *
   * @note
   * - Call this method after calling \ref IRtcEngine::createDataStream "createDataStream".
   * - This method applies only to the `COMMUNICATION` profile or to
   * the hosts in the `LIVE_BROADCASTING` profile. If an audience in the
   * `LIVE_BROADCASTING` profile calls this method, the audience may be switched to a host.
   *
   * @param streamId The ID of the stream data.
   * @param data The data stream.
   * @param length The length (byte) of the data stream.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int sendStreamMessage(int streamId, const char* data, size_t length) = 0;

  /** **DEPRECATED** Adds a watermark image to the local video or CDN live stream.

   This method is not recommend, Use \ref agora::rtc::IRtcEngine::addVideoWatermark(const char* watermarkUrl, const WatermarkOptions& options) "addVideoWatermark"2 instead.

   This method adds a PNG watermark image to the local video stream for the recording device, channel audience, and CDN live audience to view and capture.

   To add the PNG file to the CDN live publishing stream, see the \ref IRtcEngine::setLiveTranscoding "setLiveTranscoding" method.

   @param watermark Pointer to the watermark image to be added to the local video stream. See RtcImage.

   @note
   - The URL descriptions are different for the local video and CDN live streams:
      - In a local video stream, `url` in RtcImage refers to the absolute path of the added watermark image file in the local video stream.
      - In a CDN live stream, `url` in RtcImage refers to the URL address of the added watermark image in the CDN live broadcast.
   - The source file of the watermark image must be in the PNG file format. If the width and height of the PNG file differ from your settings in this method, the PNG file will be cropped to conform to your settings.
   - The Agora SDK supports adding only one watermark image onto a local video or CDN live stream. The newly added watermark image replaces the previous one.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int addVideoWatermark(const RtcImage& watermark) __deprecated = 0;

  /** Adds a watermark image to the local video.

   This method adds a PNG watermark image to the local video in a live broadcast. Once the watermark image is added, all the audience in the channel (CDN audience included),
   and the recording device can see and capture it. Agora supports adding only one watermark image onto the local video, and the newly watermark image replaces the previous one.

   The watermark position depends on the settings in the \ref IRtcEngine::setVideoEncoderConfiguration "setVideoEncoderConfiguration" method:
   - If the orientation mode of the encoding video is #ORIENTATION_MODE_FIXED_LANDSCAPE, or the landscape mode in #ORIENTATION_MODE_ADAPTIVE, the watermark uses the landscape orientation.
   - If the orientation mode of the encoding video is #ORIENTATION_MODE_FIXED_PORTRAIT, or the portrait mode in #ORIENTATION_MODE_ADAPTIVE, the watermark uses the portrait orientation.
   - When setting the watermark position, the region must be less than the dimensions set in the `setVideoEncoderConfiguration` method. Otherwise, the watermark image will be cropped.

   @note
   - Ensure that you have called the \ref agora::rtc::IRtcEngine::enableVideo "enableVideo" method to enable the video module before calling this method.
   - If you only want to add a watermark image to the local video for the audience in the CDN live broadcast channel to see and capture, you can call this method or the \ref agora::rtc::IRtcEngine::setLiveTranscoding "setLiveTranscoding" method.
   - This method supports adding a watermark image in the PNG file format only. Supported pixel formats of the PNG image are RGBA, RGB, Palette, Gray, and Alpha_gray.
   - If the dimensions of the PNG image differ from your settings in this method, the image will be cropped or zoomed to conform to your settings.
   - If you have enabled the local video preview by calling the \ref agora::rtc::IRtcEngine::startPreview "startPreview" method, you can use the `visibleInPreview` member in the WatermarkOptions class to set whether or not the watermark is visible in preview.
   - If you have enabled the mirror mode for the local video, the watermark on the local video is also mirrored. To avoid mirroring the watermark, Agora recommends that you do not use the mirror and watermark functions for the local video at the same time. You can implement the watermark function in your application layer.

   @param watermarkUrl The local file path of the watermark image to be added. This method supports adding a watermark image from the local absolute or relative file path.
   @param options Pointer to the watermark's options to be added. See WatermarkOptions for more infomation.

   @return int
   - 0: Success.
   - < 0: Failure.
   */
  virtual int addVideoWatermark(const char* watermarkUrl, const WatermarkOptions& options) = 0;

  /** Removes the watermark image on the video stream added by
  addVideoWatermark().

  @return
  - 0: Success.
  - < 0: Failure.
  */
  virtual int clearVideoWatermarks() = 0;

  // The following APIs are either deprecated and going to deleted.

  /** @deprecated Use disableAudio() instead.

   Disables the audio function in the channel.

   @return int
   - 0: Success.
   - < 0: Failure.
   */
   virtual int pauseAudio() __deprecated = 0;
   /** @deprecated Use enableAudio() instead.

   Resumes the audio function in the channel.

   @return int
   - 0: Success.
   - < 0: Failure.
   */
   virtual int resumeAudio() __deprecated = 0;

  /**
   * Enables interoperability with the Agora Web SDK (Live Broadcast only).
   *
   * @deprecated The Agora NG SDK enables the interoperablity with the Web SDK.
   *
   * Use this method when the channel profile is Live Broadcast. Interoperability
   * with the Agora Web SDK is enabled by default when the channel profile is
   * Communication.
   *
   * @param enabled Determines whether to enable interoperability with the Agora Web SDK.
   * - true: (Default) Enable interoperability with the Agora Native SDK.
   * - false: Disable interoperability with the Agora Native SDK.
   *
   * @return int
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int enableWebSdkInteroperability(bool enabled) __deprecated = 0;

  /** Agora supports reporting and analyzing customized messages.
   *
   * This function is in the beta stage with a free trial. The ability provided
   * in its beta test version is reporting a maximum of 10 message pieces within
   * 6 seconds, with each message piece not exceeding 256 bytes.
   *
   * To try out this function, contact [support@agora.io](mailto:support@agora.io)
   * and discuss the format of customized messages with us.
   */
  virtual int sendCustomReportMessage(const char* id, const char* category, const char* event, const char* label, int value) = 0;

  /** Registers the metadata observer.

   You need to implement the IMetadataObserver class and specify the metadata type
   in this method. This method enables you to add synchronized metadata in the video
   stream for more diversified live interactive streaming, such as sending
   shopping links, digital coupons, and online quizzes.

   A successful call of this method triggers
   the \ref agora::rtc::IMetadataObserver::getMaxMetadataSize "getMaxMetadataSize" callback.

   @note
   - Call this method before the `joinChannel` method.
   - This method applies to the `LIVE_BROADCASTING` channel profile.

   @param observer IMetadataObserver.
   @param type The metadata type. See \ref IMetadataObserver::METADATA_TYPE "METADATA_TYPE". The SDK supports VIDEO_METADATA (0) only for now.

   @return
   - 0: Success.
   - < 0: Failure.
  */
  virtual int registerMediaMetadataObserver(IMetadataObserver *observer, IMetadataObserver::METADATA_TYPE type) = 0;

  /** Unregisters the metadata observer.
   @param observer IMetadataObserver.
   @param type The metadata type. See \ref IMetadataObserver::METADATA_TYPE "METADATA_TYPE". The SDK supports VIDEO_METADATA (0) only for now.

   @return
   - 0: Success.
   - < 0: Failure.
  */
  virtual int unregisterMediaMetadataObserver(IMetadataObserver* observer, IMetadataObserver::METADATA_TYPE type) = 0;

  /** Start audio frame dump.

   Optional `location` is: "pre_apm_proc", "apm", "pre_send_proc", "filter", "enc", "tx_mixer",
                         "at_record", "atw_record" for audio sending.
                         "dec", "mixed", "play", "rx_mixer", "playback_mixer", "pcm_source_playback_mixer",
                         "pre_play_proc", "at_playout", "atw_playout" for audio receiving.

   */
  virtual int startAudioFrameDump(const char* channel_id, uid_t uid, const char* location, const char* uuid, const char* passwd, long duration_ms, bool auto_upload) = 0;

  /**
   * Stops the audio frame dump.
   */
  virtual int stopAudioFrameDump(const char* channel_id, uid_t uid, const char* location) = 0;

 /**
   * Enables/Disables Agora AI Noise Suppression(AINS) with preset mode.
   *
   * @param enabled Sets whether or not to enable AINS.
   * - true: Enables the AINS.
   * - false: Disables the AINS.
   * @param mode The preset AINS mode, range is [0,1,2]:
   * 0: AINS mode with soft suppression level.
   * 1: AINS mode with aggressive suppression level.
   * 2: AINS mode with aggressive suppression level and low algorithm latency.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setAINSMode(bool enabled,  AUDIO_AINS_MODE mode) = 0;

  /** Registers a user account.
   *
   * Once registered, the user account can be used to identify the local user when the user joins the channel.
   * After the user successfully registers a user account, the SDK triggers the \ref agora::rtc::IRtcEngineEventHandler::onLocalUserRegistered "onLocalUserRegistered" callback on the local client,
   * reporting the user ID and user account of the local user.
   *
   * To join a channel with a user account, you can choose either of the following:
   *
   * - Call the \ref agora::rtc::IRtcEngine::registerLocalUserAccount "registerLocalUserAccount" method to create a user account, and then the \ref agora::rtc::IRtcEngine::joinChannelWithUserAccount "joinChannelWithUserAccount" method to join the channel.
   * - Call the \ref agora::rtc::IRtcEngine::joinChannelWithUserAccount "joinChannelWithUserAccount" method to join the channel.
   *
   * The difference between the two is that for the former, the time elapsed between calling the \ref agora::rtc::IRtcEngine::joinChannelWithUserAccount "joinChannelWithUserAccount" method
   * and joining the channel is shorter than the latter.
   *
   * @note
   * - Ensure that you set the `userAccount` parameter. Otherwise, this method does not take effect.
   * - Ensure that the value of the `userAccount` parameter is unique in the channel.
   * - To ensure smooth communication, use the same parameter type to identify the user. For example, if a user joins the channel with a user ID, then ensure all the other users use the user ID too. The same applies to the user account. If a user joins the channel with the Agora Web SDK, ensure that the uid of the user is set to the same parameter type.
   *
   * @param appId The App ID of your project.
   * @param userAccount The user account. The maximum length of this parameter is 255 bytes. Ensure that you set this parameter and do not set it as null. Supported character scopes are:
   * - All lowercase English letters: a to z.
   * - All uppercase English letters: A to Z.
   * - All numeric characters: 0 to 9.
   * - The space character.
   * - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int registerLocalUserAccount(const char* appId, const char* userAccount) = 0;

  /** Joins the channel with a user account.
   *
   * After the user successfully joins the channel, the SDK triggers the following callbacks:
   *
   * - The local client: \ref agora::rtc::IRtcEngineEventHandler::onLocalUserRegistered "onLocalUserRegistered" and \ref agora::rtc::IRtcEngineEventHandler::onJoinChannelSuccess "onJoinChannelSuccess" .
   * - The remote client: \ref agora::rtc::IRtcEngineEventHandler::onUserJoined "onUserJoined" and \ref agora::rtc::IRtcEngineEventHandler::onUserInfoUpdated "onUserInfoUpdated" , if the user joining the channel is in the `COMMUNICATION` profile, or is a host in the `LIVE_BROADCASTING` profile.
   *
   * @note To ensure smooth communication, use the same parameter type to identify the user. For example, if a user joins the channel with a user ID, then ensure all the other users use the user ID too. The same applies to the user account.
   * If a user joins the channel with the Agora Web SDK, ensure that the uid of the user is set to the same parameter type.
   *
   * @param token The token generated at your server:
   * - For low-security requirements: You can use the temporary token generated at Console. For details, see [Get a temporary toke](https://docs.agora.io/en/Voice/token?platform=All%20Platforms#get-a-temporary-token).
   * - For high-security requirements: Set it as the token generated at your server. For details, see [Get a token](https://docs.agora.io/en/Voice/token?platform=All%20Platforms#get-a-token).
   * @param channelId The channel name. The maximum length of this parameter is 64 bytes. Supported character scopes are:
   * - All lowercase English letters: a to z.
   * - All uppercase English letters: A to Z.
   * - All numeric characters: 0 to 9.
   * - The space character.
   * - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
   * @param userAccount The user account. The maximum length of this parameter is 255 bytes. Ensure that you set this parameter and do not set it as null. Supported character scopes are:
   * - All lowercase English letters: a to z.
   * - All uppercase English letters: A to Z.
   * - All numeric characters: 0 to 9.
   * - The space character.
   * - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int joinChannelWithUserAccount(const char* token, const char* channelId, const char* userAccount) = 0;

  /** Joins the channel with a user account.
   *
   * After the user successfully joins the channel, the SDK triggers the following callbacks:
   *
   * - The local client: \ref agora::rtc::IRtcEngineEventHandler::onLocalUserRegistered "onLocalUserRegistered" and \ref agora::rtc::IRtcEngineEventHandler::onJoinChannelSuccess "onJoinChannelSuccess" .
   * - The remote client: \ref agora::rtc::IRtcEngineEventHandler::onUserJoined "onUserJoined" and \ref agora::rtc::IRtcEngineEventHandler::onUserInfoUpdated "onUserInfoUpdated" , if the user joining the channel is in the `COMMUNICATION` profile, or is a host in the `LIVE_BROADCASTING` profile.
   *
   * @note To ensure smooth communication, use the same parameter type to identify the user. For example, if a user joins the channel with a user ID, then ensure all the other users use the user ID too. The same applies to the user account.
   * If a user joins the channel with the Agora Web SDK, ensure that the uid of the user is set to the same parameter type.
   *
   * @param token The token generated at your server:
   * - For low-security requirements: You can use the temporary token generated at Console. For details, see [Get a temporary toke](https://docs.agora.io/en/Voice/token?platform=All%20Platforms#get-a-temporary-token).
   * - For high-security requirements: Set it as the token generated at your server. For details, see [Get a token](https://docs.agora.io/en/Voice/token?platform=All%20Platforms#get-a-token).
   * @param channelId The channel name. The maximum length of this parameter is 64 bytes. Supported character scopes are:
   * - All lowercase English letters: a to z.
   * - All uppercase English letters: A to Z.
   * - All numeric characters: 0 to 9.
   * - The space character.
   * - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
   * @param userAccount The user account. The maximum length of this parameter is 255 bytes. Ensure that you set this parameter and do not set it as null. Supported character scopes are:
   * - All lowercase English letters: a to z.
   * - All uppercase English letters: A to Z.
   * - All numeric characters: 0 to 9.
   * - The space character.
   * - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
   * @param options  The channel media options: \ref agora::rtc::ChannelMediaOptions::ChannelMediaOptions "ChannelMediaOptions"
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int joinChannelWithUserAccount(const char* token, const char* channelId, const char* userAccount, const ChannelMediaOptions& options) = 0;

  /** Joins the channel with a user account.
   *
   * After the user successfully joins the channel, the SDK triggers the following callbacks:
   *
   * - The local client: \ref agora::rtc::IRtcEngineEventHandler::onLocalUserRegistered "onLocalUserRegistered" and \ref agora::rtc::IRtcEngineEventHandler::onJoinChannelSuccess "onJoinChannelSuccess" .
   * - The remote client: \ref agora::rtc::IRtcEngineEventHandler::onUserJoined "onUserJoined" and \ref agora::rtc::IRtcEngineEventHandler::onUserInfoUpdated "onUserInfoUpdated" , if the user joining the channel is in the `COMMUNICATION` profile, or is a host in the `LIVE_BROADCASTING` profile.
   *
   * @note To ensure smooth communication, use the same parameter type to identify the user. For example, if a user joins the channel with a user ID, then ensure all the other users use the user ID too. The same applies to the user account.
   * If a user joins the channel with the Agora Web SDK, ensure that the uid of the user is set to the same parameter type.
   *
   * @param token The token generated at your server:
   * - For low-security requirements: You can use the temporary token generated at Console. For details, see [Get a temporary toke](https://docs.agora.io/en/Voice/token?platform=All%20Platforms#get-a-temporary-token).
   * - For high-security requirements: Set it as the token generated at your server. For details, see [Get a token](https://docs.agora.io/en/Voice/token?platform=All%20Platforms#get-a-token).
   * @param channelId The channel name. The maximum length of this parameter is 64 bytes. Supported character scopes are:
   * - All lowercase English letters: a to z.
   * - All uppercase English letters: A to Z.
   * - All numeric characters: 0 to 9.
   * - The space character.
   * - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
   * @param userAccount The user account. The maximum length of this parameter is 255 bytes. Ensure that you set this parameter and do not set it as null. Supported character scopes are:
   * - All lowercase English letters: a to z.
   * - All uppercase English letters: A to Z.
   * - All numeric characters: 0 to 9.
   * - The space character.
   * - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
   * @param options  The channel media options: \ref agora::rtc::ChannelMediaOptions::ChannelMediaOptions "ChannelMediaOptions"
   * @param eventHandler The pointer to the IRtcEngine event handler: IRtcEngineEventHandler.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int joinChannelWithUserAccountEx(const char* token, const char* channelId,
                                           const char* userAccount, const ChannelMediaOptions& options,
                                           IRtcEngineEventHandler* eventHandler) = 0;

  /** Gets the user information by passing in the user account.
   *
   * After a remote user joins the channel, the SDK gets the user ID and user account of the remote user, caches them
   * in a mapping table object (`userInfo`), and triggers the \ref agora::rtc::IRtcEngineEventHandler::onUserInfoUpdated "onUserInfoUpdated" callback on the local client.
   *
   * After receiving the o\ref agora::rtc::IRtcEngineEventHandler::onUserInfoUpdated "onUserInfoUpdated" callback, you can call this method to get the user ID of the
   * remote user from the `userInfo` object by passing in the user account.
   *
   * @param userAccount The user account of the user. Ensure that you set this parameter.
   * @param [in,out] userInfo  A userInfo object that identifies the user:
   * - Input: A userInfo object.
   * - Output: A userInfo object that contains the user account and user ID of the user.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int getUserInfoByUserAccount(const char* userAccount, rtc::UserInfo* userInfo) = 0;

  /** Gets the user information by passing in the user ID.
   *
   * After a remote user joins the channel, the SDK gets the user ID and user account of the remote user,
   * caches them in a mapping table object (`userInfo`), and triggers the \ref agora::rtc::IRtcEngineEventHandler::onUserInfoUpdated "onUserInfoUpdated" callback on the local client.
   *
   * After receiving the \ref agora::rtc::IRtcEngineEventHandler::onUserInfoUpdated "onUserInfoUpdated" callback, you can call this method to get the user account of the remote user
   * from the `userInfo` object by passing in the user ID.
   *
   * @param uid The user ID of the remote user. Ensure that you set this parameter.
   * @param[in,out] userInfo A userInfo object that identifies the user:
   * - Input: A userInfo object.
   * - Output: A userInfo object that contains the user account and user ID of the user.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int getUserInfoByUid(uid_t uid, rtc::UserInfo* userInfo) = 0;

  /** Starts relaying media streams across channels or updates the channels for media relay.
    *
    * After a successful method call, the SDK triggers the
    * \ref agora::rtc::IRtcEngineEventHandler::onChannelMediaRelayStateChanged
    *  "onChannelMediaRelayStateChanged" callback, and this callback return the state of the media stream relay.
    * - If the
    * \ref agora::rtc::IRtcEngineEventHandler::onChannelMediaRelayStateChanged
    *  "onChannelMediaRelayStateChanged" callback returns
    * #RELAY_STATE_RUNNING (2) and #RELAY_OK (0), the host starts sending data to the destination channel.
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
    * - Contact sales-us@agora.io before implementing this function.
    * - We do not support string user accounts in this API.
    *
    * @since v4.2.0
    * @param configuration The configuration of the media stream relay:
    * ChannelMediaRelayConfiguration.
    *
    * @return
    * - 0: Success.
    * - < 0: Failure.
    *   - -1(ERR_FAILED): A general error occurs (no specified reason).
    *   - -2(ERR_INVALID_ARGUMENT): The argument is invalid.
    *   - -5(ERR_REFUSED): The request is rejected.
    *   - -8(ERR_INVALID_STATE): The current status is invalid, only allowed to be called when the role is the broadcaster.
  **/
  virtual int startOrUpdateChannelMediaRelay(const ChannelMediaRelayConfiguration &configuration) = 0;

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
    * #RELAY_ERROR_SERVER_CONNECTION_LOST (8) state code. You can leave the
    * channel by calling the \ref leaveChannel() "leaveChannel" method, and
    * the media stream relay automatically stops.
    *
    * @return
    * - 0: Success.
    * - < 0: Failure.
    *   - -1(ERR_FAILED): A general error occurs (no specified reason).
    *   - -2(ERR_INVALID_ARGUMENT): The argument is invalid.
    *   - -5(ERR_REFUSED): The request is rejected.
    *   - -7(ERR_NOT_INITIALIZED): cross channel media streams are not relayed.
    */
  virtual int stopChannelMediaRelay() = 0;

  /** pause the channels for media stream relay.
   * @return
   * - 0: Success.
   * - < 0: Failure.
     *   - -1(ERR_FAILED): A general error occurs (no specified reason).
     *   - -2(ERR_INVALID_ARGUMENT): The argument is invalid.
     *   - -5(ERR_REFUSED): The request is rejected.
     *   - -7(ERR_NOT_INITIALIZED): cross channel media streams are not relayed.
   */
  virtual int pauseAllChannelMediaRelay() = 0;

  /** resume the channels for media stream relay.
   * @return
   * - 0: Success.
   * - < 0: Failure.
     *   - -1(ERR_FAILED): A general error occurs (no specified reason).
     *   - -2(ERR_INVALID_ARGUMENT): The argument is invalid.
     *   - -5(ERR_REFUSED): The request is rejected.
     *   - -7(ERR_NOT_INITIALIZED): cross channel media streams are not relayed.
   */
  virtual int resumeAllChannelMediaRelay() = 0;

  /** Set audio parameters for direct streaming to CDN
   *
   * @note
   * Must call this api before "startDirectCdnStreaming"
   *
   * @param profile Sets the sample rate, bitrate, encoding mode, and the number of channels:
   * #AUDIO_PROFILE_TYPE.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setDirectCdnStreamingAudioConfiguration(AUDIO_PROFILE_TYPE profile) = 0;

  /** Set video parameters for direct streaming to CDN
   *
   * Each configuration profile corresponds to a set of video parameters, including
   * the resolution, frame rate, and bitrate.
   *
   * @note
   * Must call this api before "startDirectCdnStreaming"
   *
   * @param config The local video encoder configuration: VideoEncoderConfiguration.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setDirectCdnStreamingVideoConfiguration(const VideoEncoderConfiguration& config) = 0;

  /** Start direct cdn streaming
   *
   * @param eventHandler A pointer to the direct cdn streaming event handler: \ref agora::rtc::IDirectCdnStreamingEventHandler
   * "IDirectCdnStreamingEventHandler".
   * @param publishUrl The url of the cdn used to publish the stream.
   * @param options The direct cdn streaming media options: DirectCdnStreamingMediaOptions.
   * This API must pass an audio-related option, and temporarily cannot pass more than one. 
   * For video-related options, you can either choose to not pass any, or only one.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int startDirectCdnStreaming(IDirectCdnStreamingEventHandler* eventHandler,
                                      const char* publishUrl, const DirectCdnStreamingMediaOptions& options) = 0;

  /** Stop direct cdn streaming
   *
   * @note
   * This method is synchronous.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int stopDirectCdnStreaming() = 0;

  /** Change the media source during the pushing
   *
   * @note
   * This method is temporarily not supported.
   *
   * @param options The direct cdn streaming media options: DirectCdnStreamingMediaOptions.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int updateDirectCdnStreamingMediaOptions(const DirectCdnStreamingMediaOptions& options) = 0;

  /** Enables the rhythm player.
   *
   * @param sound1 The absolute path or URL address (including the filename extensions) of the file for the downbeat.
   * @param sound2 The absolute path or URL address (including the filename extensions) of the file for the upbeats.
   * @param config The configuration of rhythm player.
   *
   * @return int
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int startRhythmPlayer(const char* sound1, const char* sound2, const AgoraRhythmPlayerConfig& config) = 0;

  /** Disables the rhythm player.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int stopRhythmPlayer() = 0;

  /** Configures the rhythm player.
   *
   * @param config The configuration of rhythm player.
   *
   * @return int
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int configRhythmPlayer(const AgoraRhythmPlayerConfig& config) = 0;

  /**
   * Takes a snapshot of a video stream.
   *
   * This method takes a snapshot of a video stream from the specified user, generates a JPG
   * image, and saves it to the specified path.
   *
   * The method is asynchronous, and the SDK has not taken the snapshot when the method call
   * returns. After a successful method call, the SDK triggers the `onSnapshotTaken` callback
   * to report whether the snapshot is successfully taken, as well as the details for that
   * snapshot.
   *
   * @note
   * - Call this method after joining a channel.
   * - This method takes a snapshot of the published video stream specified in `ChannelMediaOptions`.
   * - If the user's video has been preprocessed, for example, watermarked or beautified, the resulting
   * snapshot includes the pre-processing effect.
   *
   * @param uid The user ID. Set uid as 0 if you want to take a snapshot of the local user's video.
   * @param filePath The local path (including filename extensions) of the snapshot. For example:
   * - Windows: `C:\Users\<user_name>\AppData\Local\Agora\<process_name>\example.jpg`
   * - iOS: `/App Sandbox/Library/Caches/example.jpg`
   * - macOS: `～/Library/Logs/example.jpg`
   * - Android: `/storage/emulated/0/Android/data/<package name>/files/example.jpg`
   *
   * Ensure that the path you specify exists and is writable.
   * @return
   * - 0 : Success.
   * - < 0 : Failure.
   */
  virtual int takeSnapshot(uid_t uid, const char* filePath)  = 0;

    /** Enables the content inspect.
    @param enabled Whether to enable content inspect:
    - `true`: Yes.
    - `false`: No.
    @param config The configuration for the content inspection.
    @return
    - 0: Success.
    - < 0: Failure.
    */
  virtual int enableContentInspect(bool enabled, const media::ContentInspectConfig &config) = 0;
  /*
   * Adjust the custom audio publish volume by track id.
   * @param trackId custom audio track id.
   * @param volume The volume, range is [0,100]:
   * 0: mute, 100: The original volume
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int adjustCustomAudioPublishVolume(track_id_t trackId, int volume) = 0;

  /*
   * Adjust the custom audio playout volume by track id.
   * @param trackId custom audio track id.
   * @param volume The volume, range is [0,100]:
   * 0: mute, 100: The original volume
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int adjustCustomAudioPlayoutVolume(track_id_t trackId, int volume) = 0;

  /** Sets the Agora cloud proxy service.
   *
   * @since v3.3.0
   *
   * When the user's firewall restricts the IP address and port, refer to *Use Cloud Proxy* to add the specific
   * IP addresses and ports to the firewall allowlist; then, call this method to enable the cloud proxy and set
   * the `proxyType` parameter as `UDP_PROXY(1)`, which is the cloud proxy for the UDP protocol.
   *
   * After a successfully cloud proxy connection, the SDK triggers
   * the \ref IRtcEngineEventHandler::onConnectionStateChanged "onConnectionStateChanged" (CONNECTION_STATE_CONNECTING, CONNECTION_CHANGED_SETTING_PROXY_SERVER) callback.
   *
   * To disable the cloud proxy that has been set, call `setCloudProxy(NONE_PROXY)`. To change the cloud proxy type that has been set,
   * call `setCloudProxy(NONE_PROXY)` first, and then call `setCloudProxy`, and pass the value that you expect in `proxyType`.
   *
   * @note
   * - Agora recommends that you call this method before joining the channel or after leaving the channel.
   * - For the SDK v3.3.x, the services for pushing streams to CDN and co-hosting across channels are not available
   * when you use the cloud proxy for the UDP protocol. For the SDK v3.4.0 and later, the services for pushing streams
   * to CDN and co-hosting across channels are not available when the user is in a network environment with a firewall
   * and uses the cloud proxy for the UDP protocol.
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
  /** set local access point addresses in local proxy mode. use this method before join channel.

   @param config The LocalAccessPointConfiguration class, See the definition of LocalAccessPointConfiguration for details.

   @return
   - 0: Success
   - < 0: Failure
   */
  virtual int setLocalAccessPoint(const LocalAccessPointConfiguration& config) = 0;

  /** set advanced audio options.
   @param options The AdvancedAudioOptions class, See the definition of AdvancedAudioOptions for details.

   @return
   - 0: Success
   - < 0: Failure
   */
  virtual int setAdvancedAudioOptions(AdvancedAudioOptions& options, int sourceType = 0) = 0;

  /** Bind local user and a remote user as an audio&video sync group. The remote user is defined by cid and uid.
   *  There’s a usage limit that local user must be a video stream sender. On the receiver side, media streams from same sync group will be time-synced
   *
   * @param channelId The channel id
   * @param uid The user ID of the remote user to be bound with (local user)
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setAVSyncSource(const char* channelId, uid_t uid) = 0;

  /**
   * @brief enable or disable video image source to replace the current video source published or resume it
   *
   * @param enable true for enable, false for disable
   * @param options options for image track
   */
  virtual int enableVideoImageSource(bool enable, const ImageTrackOptions& options) = 0;

  /*
   * Get monotonic time in ms which can be used by capture time,
   * typical scenario is as follows:
   *
   *  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   *  |  // custom audio/video base capture time, e.g. the first audio/video capture time.             |
   *  |  int64_t custom_capture_time_base;                                                             |
   *  |                                                                                                |
   *  |  int64_t agora_monotonic_time = getCurrentMonotonicTimeInMs();                                 |
   *  |                                                                                                |
   *  |  // offset is fixed once calculated in the begining.                                           |
   *  |  const int64_t offset = agora_monotonic_time - custom_capture_time_base;                       |
   *  |                                                                                                |
   *  |  // realtime_custom_audio/video_capture_time is the origin capture time that customer provided.|
   *  |  // actual_audio/video_capture_time is the actual capture time transfered to sdk.              |
   *  |  int64_t actual_audio_capture_time = realtime_custom_audio_capture_time + offset;              |
   *  |  int64_t actual_video_capture_time = realtime_custom_video_capture_time + offset;              |
   *  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   *
   * @return
   * - >= 0: Success.
   * - < 0: Failure.
   */
  virtual int64_t getCurrentMonotonicTimeInMs() = 0;

  /**
   * Turns WIFI acceleration on or off.
   *
   * @note
   * - This method is called before and after joining a channel.
   * - Users check the WIFI router app for information about acceleration. Therefore, if this interface is invoked, the caller accepts that the caller's name will be displayed to the user in the WIFI router application on behalf of the caller.
   *
   * @param enabled
   * - true：Turn WIFI acceleration on.
   * - false：Turn WIFI acceleration off.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int enableWirelessAccelerate(bool enabled) = 0;

  /**
  * get network type value
  *
  * @return
  * - 0: DISCONNECTED.
  * - 1: LAN.
  * - 2: WIFI.
  * - 3: MOBILE_2G.
  * - 4: MOBILE_3G.
  * - 5: MOBILE_4G.
  * - 6: MOBILE_5G.
  * - -1: UNKNOWN.
  */

  virtual int getNetworkType() = 0;

  /** Provides the technical preview functionalities or special customizations by configuring the SDK with JSON options.

   @param parameters Pointer to the set parameters in a JSON string.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int setParameters(const char* parameters) = 0;

  /**
   @brief Start tracing media rendering events.
   @since v4.1.1
   @discussion
   - SDK will trace media rendering events when this API is called.
   - The tracing result can be obtained through callback `IRtcEngineEventHandler::onVideoRenderingTracingResult`
   @note
   - By default, SDK will trace media rendering events when `IRtcEngine::joinChannel` is called.
   - The start point of event tracing will be reset after leaving channel.
   @return
   - 0: Success.
   - < 0: Failure.
    - -7(ERR_NOT_INITIALIZED): The SDK is not initialized. Initialize the `IRtcEngine` instance before calling this method.
   */
  virtual int startMediaRenderingTracing() = 0;

  /**
   @brief Enable instant media rendering.
   @since v4.1.1
   @discussion
   - This method enable SDK to render video or playout audio faster.
   @note
   - Once enable this mode, we should destroy rtc engine to disable it.
   - Enable this mode, will sacrifice some part of experience.
   @return
   - 0: Success.
   - < 0: Failure.
    - -7(ERR_NOT_INITIALIZED): The SDK is not initialized. Initialize the `IRtcEngine` instance before calling this method.
   */
  virtual int enableInstantMediaRendering() = 0;

  /**
   * Return current NTP(unix timestamp) time in milliseconds.
   */
  virtual uint64_t getNtpWallTimeInMs() = 0;

  /** 
   * @brief Whether the target feature is available for the device.
   * @since v4.3.0
   * @param type The feature type. See FeatureType.
   * @return
   * - true: available.
   * - false: not available.
   */
  virtual bool isFeatureAvailableOnDevice(FeatureType type) = 0;

  /**
   * @brief send audio metadata
   * @since v4.3.1
   * @param metadata The pointer of metadata
   * @param length Size of metadata
   * @return
   * - 0: success
   * - <0: failure
   * @technical preview
  */
  virtual int sendAudioMetadata(const char* metadata, size_t length) = 0;
};

// The following types are either deprecated or not implmented yet.
enum QUALITY_REPORT_FORMAT_TYPE {
  /** 0: The quality report in JSON format,
   */
  QUALITY_REPORT_JSON = 0,
  /** 1: The quality report in HTML format.
   */
  QUALITY_REPORT_HTML = 1,
};

/** Media device states. */
enum MEDIA_DEVICE_STATE_TYPE {
  /** 0: The device is ready for use.
   */
  MEDIA_DEVICE_STATE_IDLE = 0,
  /** 1: The device is active.
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
  MEDIA_DEVICE_STATE_UNPLUGGED = 8
};

enum VIDEO_PROFILE_TYPE {
  /** 0: 160 x 120  @ 15 fps */      // res       fps
  VIDEO_PROFILE_LANDSCAPE_120P = 0,  // 160x120   15
  /** 2: 120 x 120 @ 15 fps */
  VIDEO_PROFILE_LANDSCAPE_120P_3 = 2,   // 120x120   15
                                        /** 10: 320 x 180 @ 15 fps */
  VIDEO_PROFILE_LANDSCAPE_180P = 10,    // 320x180   15
                                        /** 12: 180 x 180  @ 15 fps */
  VIDEO_PROFILE_LANDSCAPE_180P_3 = 12,  // 180x180   15
                                        /** 13: 240 x 180 @ 15 fps */
  VIDEO_PROFILE_LANDSCAPE_180P_4 = 13,  // 240x180   15
                                        /** 20: 320 x 240 @ 15 fps */
  VIDEO_PROFILE_LANDSCAPE_240P = 20,    // 320x240   15
  /** 22: 240 x 240 @ 15 fps */
  VIDEO_PROFILE_LANDSCAPE_240P_3 = 22,  // 240x240   15
  /** 23: 424 x 240 @ 15 fps */
  VIDEO_PROFILE_LANDSCAPE_240P_4 = 23,  // 424x240   15
  /** 30: 640 x 360 @ 15 fps */
  VIDEO_PROFILE_LANDSCAPE_360P = 30,  // 640x360   15
  /** 32: 360 x 360 @ 15 fps */
  VIDEO_PROFILE_LANDSCAPE_360P_3 = 32,  // 360x360   15
  /** 33: 640 x 360 @ 30 fps */
  VIDEO_PROFILE_LANDSCAPE_360P_4 = 33,  // 640x360   30
  /** 35: 360 x 360 @ 30 fps */
  VIDEO_PROFILE_LANDSCAPE_360P_6 = 35,  // 360x360   30
  /** 36: 480 x 360 @ 15 fps */
  VIDEO_PROFILE_LANDSCAPE_360P_7 = 36,  // 480x360   15
  /** 37: 480 x 360 @ 30 fps */
  VIDEO_PROFILE_LANDSCAPE_360P_8 = 37,  // 480x360   30
  /** 38: 640 x 360 @ 15 fps */
  VIDEO_PROFILE_LANDSCAPE_360P_9 = 38,   // 640x360   15
                                         /** 39: 640 x 360 @ 24 fps */
  VIDEO_PROFILE_LANDSCAPE_360P_10 = 39,  // 640x360   24
  /** 100: 640 x 360 @ 24 fps */
  VIDEO_PROFILE_LANDSCAPE_360P_11 = 100,  // 640x360   24
  /** 40: 640 x 480 @ 15 fps */
  VIDEO_PROFILE_LANDSCAPE_480P = 40,  // 640x480   15
  /** 42: 480 x 480 @ 15 fps */
  VIDEO_PROFILE_LANDSCAPE_480P_3 = 42,  // 480x480   15
  /** 43: 640 x 480 @ 30 fps */
  VIDEO_PROFILE_LANDSCAPE_480P_4 = 43,  // 640x480   30
                                        /** 45: 480 x 480 @ 30 fps */
  VIDEO_PROFILE_LANDSCAPE_480P_6 = 45,  // 480x480   30
  /** 47: 848 x 480 @ 15 fps */
  VIDEO_PROFILE_LANDSCAPE_480P_8 = 47,  // 848x480   15
                                        /** 48: 848 x 480 @ 30 fps */
  VIDEO_PROFILE_LANDSCAPE_480P_9 = 48,  // 848x480   30
  /** 49: 640 x 480 @ 10 fps */
  VIDEO_PROFILE_LANDSCAPE_480P_10 = 49,  // 640x480   10
  /** 50: 1280 x 720 @ 15 fps */
  VIDEO_PROFILE_LANDSCAPE_720P = 50,  // 1280x720  15
  /** 52: 1280 x 720 @ 30 fps */
  VIDEO_PROFILE_LANDSCAPE_720P_3 = 52,  // 1280x720  30
  /** 54: 960 x 720 @ 15 fps */
  VIDEO_PROFILE_LANDSCAPE_720P_5 = 54,  // 960x720   15
  /** 55: 960 x 720 @ 30 fps */
  VIDEO_PROFILE_LANDSCAPE_720P_6 = 55,  // 960x720   30
  /** 60: 1920 x 1080 @ 15 fps */
  VIDEO_PROFILE_LANDSCAPE_1080P = 60,  // 1920x1080 15
  /** 62: 1920 x 1080 @ 30 fps */
  VIDEO_PROFILE_LANDSCAPE_1080P_3 = 62,  // 1920x1080 30
  /** 64: 1920 x 1080 @ 60 fps */
  VIDEO_PROFILE_LANDSCAPE_1080P_5 = 64,  // 1920x1080 60
  /** 66: 2560 x 1440 @ 30 fps */
  VIDEO_PROFILE_LANDSCAPE_1440P = 66,  // 2560x1440 30
  /** 67: 2560 x 1440 @ 60 fps */
  VIDEO_PROFILE_LANDSCAPE_1440P_2 = 67,  // 2560x1440 60
  /** 70: 3840 x 2160 @ 30 fps */
  VIDEO_PROFILE_LANDSCAPE_4K = 70,  // 3840x2160 30
  /** 72: 3840 x 2160 @ 60 fps */
  VIDEO_PROFILE_LANDSCAPE_4K_3 = 72,     // 3840x2160 60
                                         /** 1000: 120 x 160 @ 15 fps */
  VIDEO_PROFILE_PORTRAIT_120P = 1000,    // 120x160   15
                                         /** 1002: 120 x 120 @ 15 fps */
  VIDEO_PROFILE_PORTRAIT_120P_3 = 1002,  // 120x120   15
                                         /** 1010: 180 x 320 @ 15 fps */
  VIDEO_PROFILE_PORTRAIT_180P = 1010,    // 180x320   15
  /** 1012: 180 x 180 @ 15 fps */
  VIDEO_PROFILE_PORTRAIT_180P_3 = 1012,  // 180x180   15
  /** 1013: 180 x 240 @ 15 fps */
  VIDEO_PROFILE_PORTRAIT_180P_4 = 1013,  // 180x240   15
  /** 1020: 240 x 320 @ 15 fps */
  VIDEO_PROFILE_PORTRAIT_240P = 1020,  // 240x320   15
  /** 1022: 240 x 240 @ 15 fps */
  VIDEO_PROFILE_PORTRAIT_240P_3 = 1022,  // 240x240   15
  /** 1023: 240 x 424 @ 15 fps */
  VIDEO_PROFILE_PORTRAIT_240P_4 = 1023,  // 240x424   15
  /** 1030: 360 x 640 @ 15 fps */
  VIDEO_PROFILE_PORTRAIT_360P = 1030,  // 360x640   15
  /** 1032: 360 x 360 @ 15 fps */
  VIDEO_PROFILE_PORTRAIT_360P_3 = 1032,  // 360x360   15
  /** 1033: 360 x 640 @ 30 fps */
  VIDEO_PROFILE_PORTRAIT_360P_4 = 1033,  // 360x640   30
                                         /** 1035: 360 x 360 @ 30 fps */
  VIDEO_PROFILE_PORTRAIT_360P_6 = 1035,  // 360x360   30
  /** 1036: 360 x 480 @ 15 fps */
  VIDEO_PROFILE_PORTRAIT_360P_7 = 1036,  // 360x480   15
  /** 1037: 360 x 480 @ 30 fps */
  VIDEO_PROFILE_PORTRAIT_360P_8 = 1037,  // 360x480   30
                                         /** 1038: 360 x 640 @ 15 fps */
  VIDEO_PROFILE_PORTRAIT_360P_9 = 1038,  // 360x640   15
  /** 1039: 360 x 640 @ 24 fps */
  VIDEO_PROFILE_PORTRAIT_360P_10 = 1039,  // 360x640   24
  /** 1100: 360 x 640 @ 24 fps */
  VIDEO_PROFILE_PORTRAIT_360P_11 = 1100,  // 360x640   24
  /** 1040: 480 x 640 @ 15 fps */
  VIDEO_PROFILE_PORTRAIT_480P = 1040,  // 480x640   15
  /** 1042: 480 x 480 @ 15 fps */
  VIDEO_PROFILE_PORTRAIT_480P_3 = 1042,  // 480x480   15
  /** 1043: 480 x 640 @ 30 fps */
  VIDEO_PROFILE_PORTRAIT_480P_4 = 1043,  // 480x640   30
                                         /** 1045: 480 x 480 @ 30 fps */
  VIDEO_PROFILE_PORTRAIT_480P_6 = 1045,  // 480x480   30
                                         /** 1047: 480 x 848 @ 15 fps */
  VIDEO_PROFILE_PORTRAIT_480P_8 = 1047,  // 480x848   15
  /** 1048: 480 x 848 @ 30 fps */
  VIDEO_PROFILE_PORTRAIT_480P_9 = 1048,  // 480x848   30
  /** 1049: 480 x 640 @ 10 fps */
  VIDEO_PROFILE_PORTRAIT_480P_10 = 1049,  // 480x640   10
  /** 1050: 720 x 1280 @ 15 fps */
  VIDEO_PROFILE_PORTRAIT_720P = 1050,  // 720x1280  15
  /** 1052: 720 x 1280 @ 30 fps */
  VIDEO_PROFILE_PORTRAIT_720P_3 = 1052,  // 720x1280  30
  /** 1054: 720 x 960 @ 15 fps */
  VIDEO_PROFILE_PORTRAIT_720P_5 = 1054,  // 720x960   15
                                         /** 1055: 720 x 960 @ 30 fps */
  VIDEO_PROFILE_PORTRAIT_720P_6 = 1055,  // 720x960   30
  /** 1060: 1080 x 1920 @ 15 fps */
  VIDEO_PROFILE_PORTRAIT_1080P = 1060,    // 1080x1920 15
                                          /** 1062: 1080 x 1920 @ 30 fps */
  VIDEO_PROFILE_PORTRAIT_1080P_3 = 1062,  // 1080x1920 30
                                          /** 1064: 1080 x 1920 @ 60 fps */
  VIDEO_PROFILE_PORTRAIT_1080P_5 = 1064,  // 1080x1920 60
  /** 1066: 1440 x 2560 @ 30 fps */
  VIDEO_PROFILE_PORTRAIT_1440P = 1066,  // 1440x2560 30
  /** 1067: 1440 x 2560 @ 60 fps */
  VIDEO_PROFILE_PORTRAIT_1440P_2 = 1067,  // 1440x2560 60
                                          /** 1070: 2160 x 3840 @ 30 fps */
  VIDEO_PROFILE_PORTRAIT_4K = 1070,       // 2160x3840 30
  /** 1072: 2160 x 3840 @ 60 fps */
  VIDEO_PROFILE_PORTRAIT_4K_3 = 1072,  // 2160x3840 60
  /** Default 640 x 360 @ 15 fps */
  VIDEO_PROFILE_DEFAULT = VIDEO_PROFILE_LANDSCAPE_360P,
};

class AAudioDeviceManager : public agora::util::AutoPtr<IAudioDeviceManager> {
 public:
  AAudioDeviceManager(IRtcEngine* engine) {
    queryInterface(engine, AGORA_IID_AUDIO_DEVICE_MANAGER);
  }
};

class AVideoDeviceManager : public agora::util::AutoPtr<IVideoDeviceManager> {
 public:
  AVideoDeviceManager(IRtcEngine* engine) {
    queryInterface(engine, AGORA_IID_VIDEO_DEVICE_MANAGER);
  }
};

}  // namespace rtc
}  // namespace agora

/** Gets the SDK version number.

@param build Build number of Agora the SDK.
* @return String of the SDK version.
*/
#define getAgoraRtcEngineVersion getAgoraSdkVersion

////////////////////////////////////////////////////////
/** \addtogroup createAgoraRtcEngine
 @{
 */
////////////////////////////////////////////////////////

/** Creates the RTC engine object and returns the pointer.

* @return Pointer of the RTC engine object.
*/
AGORA_API agora::rtc::IRtcEngine* AGORA_CALL createAgoraRtcEngine();

////////////////////////////////////////////////////////
/** @} */
////////////////////////////////////////////////////////

/** Creates the RTC engine object and returns the pointer.

 @param err Error Code.
* @return Description of the Error Code: agora::ERROR_CODE_TYPE
*/
#define getAgoraRtcEngineErrorDescription getAgoraSdkErrorDescription
#define setAgoraRtcEngineExternalSymbolLoader setAgoraSdkExternalSymbolLoader
