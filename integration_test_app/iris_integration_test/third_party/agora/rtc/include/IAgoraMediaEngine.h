#ifndef AGORA_MEDIA_ENGINE_H
#define AGORA_MEDIA_ENGINE_H
#include <stdint.h>
#include "AgoraBase.h"

namespace agora {
namespace media {
/** **DEPRECATED** Type of audio device.
 */
enum MEDIA_SOURCE_TYPE {
  /** Audio playback device.
   */
  AUDIO_PLAYOUT_SOURCE = 0,
  /** Microphone.
   */
  AUDIO_RECORDING_SOURCE = 1,
};

/**
 * The channel mode. Set in \ref agora::rtc::IRtcEngine::setAudioMixingDualMonoMode "setAudioMixingDualMonoMode".
 *
 * @since v3.5.1
 */
enum AUDIO_MIXING_DUAL_MONO_MODE {
  /**
   * 0: Original mode.
   */
  AUDIO_MIXING_DUAL_MONO_AUTO = 0,
  /**
   * 1: Left channel mode. This mode replaces the audio of the right channel
   * with the audio of the left channel, which means the user can only hear
   * the audio of the left channel.
   */
  AUDIO_MIXING_DUAL_MONO_L = 1,
  /**
   * 2: Right channel mode. This mode replaces the audio of the left channel with
   * the audio of the right channel, which means the user can only hear the audio
   * of the right channel.
   */
  AUDIO_MIXING_DUAL_MONO_R = 2,
  /**
   * 3: Mixed channel mode. This mode mixes the audio of the left channel and
   * the right channel, which means the user can hear the audio of the left
   * channel and the right channel at the same time.
   */
  AUDIO_MIXING_DUAL_MONO_MIX = 3
};
/**
 * The push position of the external audio frame.
 * Set in \ref IMediaEngine::pushAudioFrame(int32_t, IAudioFrameObserver::AudioFrame*) "pushAudioFrame"
 * or \ref IMediaEngine::setExternalAudioSourceVolume "setExternalAudioSourceVolume".
 *
 * @since v3.5.1
 */
enum AUDIO_EXTERNAL_SOURCE_POSITION {
  /** 0: The position before local playback. If you need to play the external audio frame on the local client,
   * set this position.
   */
  AUDIO_EXTERNAL_PLAYOUT_SOURCE = 0,
  /** 1: The position after audio capture and before audio pre-processing. If you need the audio module of the SDK
   * to process the external audio frame, set this position.
   */
  AUDIO_EXTERNAL_RECORD_SOURCE_PRE_PROCESS = 1,
  /** 2: The position after audio pre-processing and before audio encoding. If you do not need the audio module of
   * the SDK to process the external audio frame, set this position.
   */
  AUDIO_EXTERNAL_RECORD_SOURCE_POST_PROCESS = 2,
};

/**
 * The IAudioFrameObserver class.
 */
class IAudioFrameObserver {
 public:
  IAudioFrameObserver() {}
  virtual ~IAudioFrameObserver() {}
  /** The frame type. */
  enum AUDIO_FRAME_TYPE {
    /** 0: PCM16. */
    FRAME_TYPE_PCM16 = 0,  // PCM 16bit little endian
  };
  /** Definition of AudioFrame */
  struct AudioFrame {
    /** The type of the audio frame. See #AUDIO_FRAME_TYPE
     */
    AUDIO_FRAME_TYPE type;
    /** The number of samples per channel in the audio frame.
     */
    int samples;  // number of samples for each channel in this frame
    /**The number of bytes per audio sample, which is usually 16-bit (2-byte).
     */
    int bytesPerSample;  // number of bytes per sample: 2 for PCM16
    /** The number of audio channels.
     - 1: Mono
     - 2: Stereo (the data is interleaved)
     */
    int channels;  // number of channels (data are interleaved if stereo)
    /** The sample rate.
     */
    int samplesPerSec;  // sampling rate
    /** The data buffer of the audio frame. When the audio frame uses a stereo channel, the data buffer is interleaved.
     The size of the data buffer is as follows: `buffer` = `samples` × `channels` × `bytesPerSample`.
     */
    void* buffer;  // data buffer
    /** The timestamp (ms) of the external audio frame. You can use this parameter for the following purposes:
     - Restore the order of the captured audio frame.
     - Synchronize audio and video frames in video-related scenarios, including where external video sources are used.
     */
    int64_t renderTimeMs;
    /** Reserved parameter.
     */
    int avsync_type;
  };

 public:
  /** Gets the captured audio frame.
   *
   * @note To ensure that the captured audio frame has the expected format,
   * Agora recommends that you
   * call \ref agora::rtc::IRtcEngine::setRecordingAudioFrameParameters "setRecordingAudioFrameParameters"
   * after calling \ref IMediaEngine::registerAudioFrameObserver "registerAudioFrameObserver" to
   * set the audio capturing format.
   *
   * @param audioFrame Pointer to AudioFrame.
   * @return
   * - true: Reserved for future use.
   * - false: Reserved for future use.
   */
  virtual bool onRecordAudioFrame(AudioFrame& audioFrame) = 0;
  /** Gets the audio playback frame for getting the audio.
   *
   * @note To ensure that the audio playback frame has the expected format, Agora
   * recommends that you call \ref agora::rtc::IRtcEngine::setPlaybackAudioFrameParameters "setPlaybackAudioFrameParameters"
   * after calling \ref IMediaEngine::registerAudioFrameObserver "registerAudioFrameObserver" to
   * set the audio playback format.
   *
   * @param audioFrame Pointer to AudioFrame.
   * @return
   * - true: Reserved for future use.
   * - false: Reserved for future use.
   */
  virtual bool onPlaybackAudioFrame(AudioFrame& audioFrame) = 0;
  /** Gets the mixed captured and playback audio frame.
   *
   * @note
   * - This callback only returns the single-channel data.
   * - To ensure that the mixed captured and playback audio frame has the
   * expected format, Agora recommends that you call
   * \ref agora::rtc::IRtcEngine::setMixedAudioFrameParameters "setMixedAudioFrameParameters"
   * after calling \ref IMediaEngine::registerAudioFrameObserver "registerAudioFrameObserver" to
   * set the mixed audio format.
   *
   * @param audioFrame Pointer to AudioFrame.
   * @return
   * - true: Reserved for future use.
   * - false: Reserved for future use.
   */
  virtual bool onMixedAudioFrame(AudioFrame& audioFrame) = 0;
  /** Gets the audio frame of a specified user before mixing.
   *
   * The SDK triggers this callback if \ref IAudioFrameObserver::isMultipleChannelFrameWanted "isMultipleChannelFrameWanted" returns false.
   *
   * @note To ensure that the audio playback frame has the expected format, Agora
   * recommends that you call \ref agora::rtc::IRtcEngine::setPlaybackAudioFrameParameters "setPlaybackAudioFrameParameters"
   * after calling \ref IMediaEngine::registerAudioFrameObserver "registerAudioFrameObserver" to
   * set the audio playback format.
   *
   * @param uid The user ID
   * @param audioFrame Pointer to AudioFrame.
   * @return
   * - true: Reserved for future use.
   * - false: Reserved for future use.
   */
  virtual bool onPlaybackAudioFrameBeforeMixing(unsigned int uid, AudioFrame& audioFrame) = 0;
  /** Determines whether to receive audio data from multiple channels.

   @since v3.0.1

   After you register the audio frame observer, the SDK triggers this callback every time it captures an audio frame.

   In the multi-channel scenario, if you want to get audio data from multiple channels,
   set the return value of this callback as true. After that, the SDK triggers the
   \ref IAudioFrameObserver::onPlaybackAudioFrameBeforeMixingEx "onPlaybackAudioFrameBeforeMixingEx" callback to send you the before-mixing
   audio data from various channels. You can also get the channel ID of each audio frame.

   @note
   - Once you set the return value of this callback as true, the SDK triggers
   only the \ref IAudioFrameObserver::onPlaybackAudioFrameBeforeMixingEx "onPlaybackAudioFrameBeforeMixingEx" callback
   to send the before-mixing audio frame. \ref IAudioFrameObserver::onPlaybackAudioFrameBeforeMixing "onPlaybackAudioFrameBeforeMixing" is not triggered.
   In the multi-channel scenario, Agora recommends setting the return value as true.
   - If you set the return value of this callback as false, the SDK triggers only the `onPlaybackAudioFrameBeforeMixing` callback to send the audio data.
   @return
   - `true`: Receive audio data from multiple channels.
   - `false`: Do not receive audio data from multiple channels.
   */
  virtual bool isMultipleChannelFrameWanted() { return false; }

  /** Gets the before-mixing playback audio frame from multiple channels.
   *
   * After you successfully register the audio frame observer, if you set the return
   * value of \ref IAudioFrameObserver::isMultipleChannelFrameWanted "isMultipleChannelFrameWanted" as true, the SDK triggers this callback each
   * time it receives a before-mixing audio frame from any of the channel.
   *
   * @note To ensure that the audio playback frame has the expected format, Agora
   * recommends that you call \ref agora::rtc::IRtcEngine::setPlaybackAudioFrameParameters "setPlaybackAudioFrameParameters"
   * after calling \ref IMediaEngine::registerAudioFrameObserver "registerAudioFrameObserver" to
   * set the audio playback format.
   *
   * @param channelId The channel ID of this audio frame.
   * @param uid The ID of the user sending this audio frame.
   * @param audioFrame The pointer to AudioFrame.
   * @return
   * - `true`: Reserved for future use.
   * - `false`: Reserved for future use.
   */
  virtual bool onPlaybackAudioFrameBeforeMixingEx(const char* channelId, unsigned int uid, AudioFrame& audioFrame) { return true; }
};

/**
 * The IVideoFrameObserver class.
 */
class IVideoFrameObserver {
 public:
  IVideoFrameObserver() {}
  virtual ~IVideoFrameObserver() {}
  /** The video frame type. */
  enum VIDEO_FRAME_TYPE {
    /**
     * 0: (Default) YUV 420
     */
    FRAME_TYPE_YUV420 = 0,  // YUV 420 format
    /**
     * 1: YUV 422
     */
    FRAME_TYPE_YUV422 = 1,  // YUV 422 format
    /**
     * 2: RGBA
     */
    FRAME_TYPE_RGBA = 2,  // RGBA format
  };
  /**
   * The frame position of the video observer.
   */
  enum VIDEO_OBSERVER_POSITION {
    /**
     * 1: The post-capturer position, which corresponds to the video data in the onCaptureVideoFrame callback.
     */
    POSITION_POST_CAPTURER = 1 << 0,
    /**
     * 2: The pre-renderer position, which corresponds to the video data in the onRenderVideoFrame callback.
     */
    POSITION_PRE_RENDERER = 1 << 1,
    /**
     * 4: The pre-encoder position, which corresponds to the video data in the onPreEncodeVideoFrame callback.
     */
    POSITION_PRE_ENCODER = 1 << 2,
  };
  /** Video frame information. The video data format is YUV 420. The buffer provides a pointer to a pointer. The interface cannot modify the pointer of the buffer, but can modify the content of the buffer only.
   */
  struct VideoFrame {
    VIDEO_FRAME_TYPE type;
    /** Video pixel width.
     */
    int width;  // width of video frame
    /** Video pixel height.
     */
    int height;  // height of video frame
    /**
     * For YUV data, the line span of the Y buffer; for RGBA data, the total data length.
     */
    int yStride;  // stride of Y data buffer
    /**
     * For YUV data, the line span of the U buffer; for RGBA data, the value is 0.
     */
    int uStride;  // stride of U data buffer
    /**
     * For YUV data, the line span of the V buffer; for RGBA data, the value is 0.
     */
    int vStride;  // stride of V data buffer
    /**
     * For YUV data, the pointer to the Y buffer; for RGBA data, the data buffer.
     */
    void* yBuffer;  // Y data buffer
    /**
     * For YUV data, the pointer to the U buffer; for RGBA data, the value is 0.
     */
    void* uBuffer;  // U data buffer
    /**
     * For YUV data, the pointer to the V buffer; for RGBA data, the value is 0.
     */
    void* vBuffer;  // V data buffer
    /** The clockwise rotation angle of the video frame. The supported values are 0, 90, 180, or 270 degrees.
     */
    int rotation;  // rotation of this frame (0, 90, 180, 270)
    /**
     * The Unix timestamp (ms) when the video frame is rendered. This timestamp can be used to guide the rendering of
     * the video frame. This parameter is required.
     */
    int64_t renderTimeMs;
    int avsync_type;
  };

 public:
  /** Occurs each time the SDK receives a video frame captured by the local camera.
   *
   * After you successfully register the video frame observer, the SDK triggers this callback each time a video frame is received. In this callback,
   * you can get the video data captured by the local camera. You can then pre-process the data according to your scenarios.
   *
   * After pre-processing, you can send the processed video data back to the SDK by setting the `videoFrame` parameter in this callback.
   *
   * @note
   * - This callback does not support sending processed RGBA video data back to the SDK.
   * - The video data that this callback gets has not been pre-processed, without the watermark, the cropped content, the rotation, and the image enhancement.
   *
   * @param videoFrame Pointer to VideoFrame.
   * @return
   * - true: Sets the SDK to receive the video frame.
   * - false: Sets the SDK to discard the video frame.
   */
  virtual bool onCaptureVideoFrame(VideoFrame& videoFrame) = 0;
  /** @since v3.0.0
   *
   * Occurs each time the SDK receives a video frame before encoding.
   *
   * After you successfully register the video frame observer, the SDK triggers this callback each time when it receives a video frame. In this callback, you can get the video data before encoding. You can then process the data according to your particular scenarios.
   *
   * After processing, you can send the processed video data back to the SDK by setting the `VideoFrame` parameter in this callback.
   *
   * @note
   * - As of v3.0.1, if you want to receive this callback, you also need to set `POSITION_PRE_ENCODE(1 << 2)` as a frame position in the \ref getObservedFramePosition "getObservedFramePosition" callback.
   * - The video data that this callback gets has been pre-processed, with its content cropped, rotated, and the image enhanced.
   * - This callback does not support sending processed RGBA video data back to the SDK.
   *
   * @param videoFrame A pointer to VideoFrame
   * @return
   * - true: Sets the SDK to receive the video frame.
   * - false: Sets the SDK to discard the video frame.
   */
  virtual bool onPreEncodeVideoFrame(VideoFrame& videoFrame) { return true; }
  /** Occurs each time the SDK receives a video frame sent by the remote user.
   *
   * After you successfully register the video frame observer and
   * \ref IVideoFrameObserver::isMultipleChannelFrameWanted "isMultipleChannelFrameWanted"
   * return false, the SDK triggers this callback each time a video frame is received.
   * In this callback, you can get the video data sent by the remote user. You can then
   * post-process the data according to your scenarios.
   *
   * After post-processing, you can send the processed data back to the SDK by setting the `videoFrame` parameter in this callback.
   *
   * @note
   * This callback does not support sending processed RGBA video data back to the SDK.
   *
   * @param uid ID of the remote user who sends the current video frame.
   * @param videoFrame Pointer to VideoFrame.
   * @return
   * - true: Sets the SDK to receive the video frame.
   * - false: Sets the SDK to discard the video frame.
   */
  virtual bool onRenderVideoFrame(unsigned int uid, VideoFrame& videoFrame) = 0;
  /** Occurs each time the SDK receives a video frame and prompts you to set the video format.
   *
   * YUV 420 is the default video format. If you want to receive other video formats, register this callback in the IVideoFrameObserver class.
   *
   * After you successfully register the video frame observer, the SDK triggers this callback each time it receives a video frame.
   * You need to set your preferred video data in the return value of this callback.
   *
   * @return Sets the video format: #VIDEO_FRAME_TYPE
   */
  virtual VIDEO_FRAME_TYPE getVideoFormatPreference() { return FRAME_TYPE_YUV420; }
  /** Occurs each time the SDK receives a video frame and prompts you whether to
   * rotate the raw video frame according to the rotation member in the VideoFrame class.
   *
   * The SDK does not rotate the raw video frame by default. If you want to receive
   * the raw video frame rotated according to the rotation member in the VideoFrame
   * class, register this callback in the IVideoFrameObserver class.
   *
   * After you successfully register the video frame observer, the SDK triggers this
   * callback each time it receives a video frame. You need to set whether to rotate
   * the raw video frame in the return value of this callback.
   *
   * @note This callback applies to the video frame in the YUV 420 and RGBA formats only.
   *
   * @return Sets whether to rotate the raw video frame:
   * - true: Rotate.
   * - false: (Default) Do not rotate.
   */
  virtual bool getRotationApplied() { return false; }
  /** Occurs each time the SDK receives a video frame and prompts you whether to mirror the raw video frame.
   *
   * The SDK does not mirror the raw video frame by default. If you want to receive the raw video frame mirrored, register this callback in the IVideoFrameObserver class.
   *
   * After you successfully register the video frame observer, the SDK triggers this callback each time a video frame is received.
   * You need to set whether to mirror the raw video frame in the return value of this callback.
   *
   * @note This callback applies to the video frame in the YUV 420 and RGBA formats only.
   *
   * @return Sets whether to mirror the raw video frame:
   * - true: Mirror.
   * - false: (Default) Do not mirror.
   */
  virtual bool getMirrorApplied() { return false; }
  /**
   * Sets whether to output the acquired video frame smoothly.
   *
   * @since v3.0.0
   *
   * @deprecated As of v3.2.0, this callback function no longer works. The SDK smooths the video frames output by `onRenderVideoFrame` and `onRenderVideoFrameEx` by default.
   *
   * If you want the video frames acquired from `onRenderVideoFrame`
   * or `onRenderVideoFrameEx` to be more evenly spaced, you can register the `getSmoothRenderingEnabled` callback in the `IVideoFrameObserver` class and set its return value as `true`.
   *
   * @note
   * - Register this callback before joining a channel.
   * - This callback applies to scenarios where the acquired video frame is self-rendered after being processed, not to scenarios where the video frame is sent back to the SDK after being processed.
   *
   * @return Set whether to smooth the video frames:
   * - true: Smooth the video frame.
   * - false: (Default) Do not smooth.
   */
  virtual bool getSmoothRenderingEnabled() AGORA_DEPRECATED_ATTRIBUTE { return false; }
  /**
   * Sets the frame position for the video observer.
   * @since v3.0.1
   *
   * After you successfully register the video observer, the SDK triggers this callback each time it receives a video frame. You can determine which position to observe by setting the return value.
   * The SDK provides 3 positions for observer. Each position corresponds to a callback function:
   * - `POSITION_POST_CAPTURER(1 << 0)`: The position after capturing the video data, which corresponds to the \ref onCaptureVideoFrame "onCaptureVideoFrame" callback.
   * - `POSITION_PRE_RENDERER(1 << 1)`: The position before receiving the remote video data, which corresponds to the \ref onRenderVideoFrame "onRenderVideoFrame" callback.
   * - `POSITION_PRE_ENCODER(1 << 2)`: The position before encoding the video data, which corresponds to the \ref onPreEncodeVideoFrame "onPreEncodeVideoFrame" callback.
   *
   * @note
   * - To observe multiple frame positions, use '|' (the OR operator).
   * - This callback observes `POSITION_POST_CAPTURER(1 << 0)` and `POSITION_PRE_RENDERER(1 << 1)` by default.
   * - To conserve the system consumption, you can reduce the number of frame positions that you want to observe.
   *
   * @return A bit mask that controls the frame position of the video observer: #VIDEO_OBSERVER_POSITION.
   *
   */
  virtual uint32_t getObservedFramePosition() { return static_cast<uint32_t>(POSITION_POST_CAPTURER | POSITION_PRE_RENDERER); }

  /** Determines whether to receive video data from multiple channels.

   @since v3.0.1

   After you register the video frame observer, the SDK triggers this callback
   every time it captures a video frame.

   In the multi-channel scenario, if you want to get video data from multiple channels,
   set the return value of this callback as true. After that, the SDK triggers the
   \ref IVideoFrameObserver::onRenderVideoFrameEx "onRenderVideoFrameEx" callback to send you
   the video data from various channels. You can also get the channel ID of each video frame.

   @note
   - Once you set the return value of this callback as true, the SDK triggers only the `onRenderVideoFrameEx` callback to
   send the video frame. \ref IVideoFrameObserver::onRenderVideoFrame "onRenderVideoFrame" will not be triggered. In the multi-channel scenario, Agora recommends setting the return value as true.
   - If you set the return value of this callback as false, the SDK triggers only the `onRenderVideoFrame` callback to send the video data.
   @return
   - `true`: Receive video data from multiple channels.
   - `false`: Do not receive video data from multiple channels.
   */
  virtual bool isMultipleChannelFrameWanted() { return false; }

  /** Gets the video frame from multiple channels.
   *
   * After you successfully register the video frame observer, if you set the return value of
   * \ref IVideoFrameObserver::isMultipleChannelFrameWanted "isMultipleChannelFrameWanted" as true, the SDK triggers this callback each time it receives a video frame
   * from any of the channel.
   *
   * You can process the video data retrieved from this callback according to your scenario, and send the
   * processed data back to the SDK using the `videoFrame` parameter in this callback.
   *
   * @note This callback does not support sending RGBA video data back to the SDK.
   *
   * @param channelId The channel ID of this video frame.
   * @param uid The ID of the user sending this video frame.
   * @param videoFrame The pointer to VideoFrame.
   * @return
   * - true: Sets the SDK to receive the video frame.
   * - false: Sets the SDK to discard the video frame.
   */
  virtual bool onRenderVideoFrameEx(const char* channelId, unsigned int uid, VideoFrame& videoFrame) { return true; }
};

class IVideoFrame {
 public:
  enum PLANE_TYPE { Y_PLANE = 0, U_PLANE = 1, V_PLANE = 2, NUM_OF_PLANES = 3 };
  enum VIDEO_TYPE {
    VIDEO_TYPE_UNKNOWN = 0,
    VIDEO_TYPE_I420 = 1,
    VIDEO_TYPE_IYUV = 2,
    VIDEO_TYPE_RGB24 = 3,
    VIDEO_TYPE_ABGR = 4,
    VIDEO_TYPE_ARGB = 5,
    VIDEO_TYPE_ARGB4444 = 6,
    VIDEO_TYPE_RGB565 = 7,
    VIDEO_TYPE_ARGB1555 = 8,
    VIDEO_TYPE_YUY2 = 9,
    VIDEO_TYPE_YV12 = 10,
    VIDEO_TYPE_UYVY = 11,
    VIDEO_TYPE_MJPG = 12,
    VIDEO_TYPE_NV21 = 13,
    VIDEO_TYPE_NV12 = 14,
    VIDEO_TYPE_BGRA = 15,
    VIDEO_TYPE_RGBA = 16,
    VIDEO_TYPE_I422 = 17,
  };
  virtual void release() = 0;
  virtual const unsigned char* buffer(PLANE_TYPE type) const = 0;

  /** Copies the frame.

   If the required size is larger than the allocated size, new buffers of the adequate size will be allocated.

   @param dest_frame Address of the returned destination frame. See IVideoFrame.
   @return
   - 0: Success.
   - -1: Failure.
   */
  virtual int copyFrame(IVideoFrame** dest_frame) const = 0;
  /** Converts the frame.

   @note The source and destination frames have equal heights.

   @param dst_video_type Type of the output video.
   @param dst_sample_size Required only for the parsing of M-JPEG.
   @param dst_frame Pointer to a destination frame. See IVideoFrame.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int convertFrame(VIDEO_TYPE dst_video_type, int dst_sample_size, unsigned char* dst_frame) const = 0;
  /** Gets the specified component in the YUV space.

   @param type Component type: #PLANE_TYPE
   */
  virtual int allocated_size(PLANE_TYPE type) const = 0;
  /** Gets the stride of the specified component in the YUV space.

   @param type Component type: #PLANE_TYPE
   */
  virtual int stride(PLANE_TYPE type) const = 0;
  /** Gets the width of the frame.
   */
  virtual int width() const = 0;
  /** Gets the height of the frame.
   */
  virtual int height() const = 0;
  /** Gets the timestamp (ms) of the frame.
   */
  virtual unsigned int timestamp() const = 0;
  /** Gets the render time (ms).
   */
  virtual int64_t render_time_ms() const = 0;
  /** Checks if a plane is of zero size.

   @return
   - true: The plane is of zero size.
   - false: The plane is not of zero size.
   */
  virtual bool IsZeroSize() const = 0;

  virtual VIDEO_TYPE GetVideoType() const = 0;
};
/** **DEPRECATED** */
class IExternalVideoRenderCallback {
 public:
  /** Occurs when the video view size has changed.
   */
  virtual void onViewSizeChanged(int width, int height) = 0;
  /** Occurs when the video view is destroyed.
   */
  virtual void onViewDestroyed() = 0;
};
/** **DEPRECATED** */
struct ExternalVideoRenerContext {
  IExternalVideoRenderCallback* renderCallback;
  /** Video display window.
   */
  void* view;
  /** Video display mode: \ref agora::rtc::RENDER_MODE_TYPE "RENDER_MODE_TYPE" */
  int renderMode;
  /** The image layer location.

   - 0: (Default) The image is at the bottom of the stack
   - 100: The image is at the top of the stack.

   @note If the value is set to below 0 or above 100, the #ERR_INVALID_ARGUMENT error occurs.
   */
  int zOrder;
  /** Video layout distance from the left.
   */
  float left;
  /** Video layout distance from the top.
   */
  float top;
  /** Video layout distance from the right.
   */
  float right;
  /** Video layout distance from the bottom.
   */
  float bottom;
};

class IExternalVideoRender {
 public:
  virtual void release() = 0;
  virtual int initialize() = 0;
  virtual int deliverFrame(const IVideoFrame& videoFrame, int rotation, bool mirrored) = 0;
};

class IExternalVideoRenderFactory {
 public:
  virtual IExternalVideoRender* createRenderInstance(const ExternalVideoRenerContext& context) = 0;
};

/** The external video frame.
 */
struct ExternalVideoFrame {
  /**
   * The data type of the video frame.
   *
   * @since v3.5.0
   */
  enum VIDEO_BUFFER_TYPE {
    /** 1: The data type is raw data.
     */
    VIDEO_BUFFER_RAW_DATA = 1,
    /**
     * 2: The data type is the pixel.
     */
    VIDEO_BUFFER_PIXEL_BUFFER = 2
  };

  /** The video pixel format.
   *
   * @note The SDK does not support the alpha channel, and discards any alpha value passed to the SDK.
   */
  enum VIDEO_PIXEL_FORMAT {
    /** 0: The video pixel format is unknown.
     */
    VIDEO_PIXEL_UNKNOWN = 0,
    /** 1: The video pixel format is I420.
     */
    VIDEO_PIXEL_I420 = 1,
    /** 2: The video pixel format is BGRA.
     */
    VIDEO_PIXEL_BGRA = 2,
    /** 3: The video pixel format is NV21.
     */
    VIDEO_PIXEL_NV21 = 3,
    /** 4: The video pixel format is RGBA.
     */
    VIDEO_PIXEL_RGBA = 4,
    /** 5: The video pixel format is IMC2.
     */
    VIDEO_PIXEL_IMC2 = 5,
    /** 7: The video pixel format is ARGB.
     */
    VIDEO_PIXEL_ARGB = 7,
    /** 8: The video pixel format is NV12.
     */
    VIDEO_PIXEL_NV12 = 8,
    /** 16: The video pixel format is I422.
     */
    VIDEO_PIXEL_I422 = 16,
    /** 17: The video pixel format is GL_TEXTURE_2D.
     */
    VIDEO_TEXTURE_2D = 17,
    /** 18: The video pixel format is GL_TEXTURE_OES.
     */
    VIDEO_TEXTURE_OES = 18,
  };

  /** The buffer type. See #VIDEO_BUFFER_TYPE
   */
  VIDEO_BUFFER_TYPE type;
  /** The pixel format. See #VIDEO_PIXEL_FORMAT
   */
  VIDEO_PIXEL_FORMAT format;
  /** The video buffer.
   */
  void* buffer;
  /** Line spacing of the incoming video frame, which must be in pixels instead of bytes. For textures, it is the width of the texture.
   */
  int stride;
  /** Height of the incoming video frame.
   */
  int height;
  /** [Raw data related parameter] The number of pixels trimmed from the left. The default value is 0.
   */
  int cropLeft;
  /** [Raw data related parameter] The number of pixels trimmed from the top. The default value is 0.
   */
  int cropTop;
  /** [Raw data related parameter] The number of pixels trimmed from the right. The default value is 0.
   */
  int cropRight;
  /** [Raw data related parameter] The number of pixels trimmed from the bottom. The default value is 0.
   */
  int cropBottom;
  /** [Raw data related parameter] The clockwise rotation of the video frame. You can set the rotation angle as 0, 90, 180, or 270. The default value is 0.
   */
  int rotation;
  /** Timestamp (ms) of the incoming video frame. An incorrect timestamp results in frame loss or unsynchronized audio and video.
   */
  long long timestamp;

  ExternalVideoFrame() : cropLeft(0), cropTop(0), cropRight(0), cropBottom(0), rotation(0) {}
};
/**
 * The video frame type.
 *
 * @since v3.4.5
 */
enum CODEC_VIDEO_FRAME_TYPE {
  /**
   * 0: (Default) A black frame
   */
  CODEC_VIDEO_FRAME_TYPE_BLANK_FRAME = 0,
  /**
   * 3: The keyframe
   */
  CODEC_VIDEO_FRAME_TYPE_KEY_FRAME = 3,
  /**
   * 4: The delta frame
   */
  CODEC_VIDEO_FRAME_TYPE_DELTA_FRAME = 4,
  /**
   * 5: The B-frame
   */
  CODEC_VIDEO_FRAME_TYPE_B_FRAME = 5,
  /**
   * Unknown frame
   */
  CODEC_VIDEO_FRAME_TYPE_UNKNOW
};

/**
 * The clockwise rotation angle of the video frame.
 *
 * @since v3.4.5
 */
enum VIDEO_ROTATION {
  /**
   * 0: 0 degree
   */
  VIDEO_ROTATION_0 = 0,
  /**
   * 90: 90 degrees
   */
  VIDEO_ROTATION_90 = 90,
  /**
   * 180: 180 degrees
   */
  VIDEO_ROTATION_180 = 180,
  /**
   * 270: 270 degrees
   */
  VIDEO_ROTATION_270 = 270
};

/**
 * The video codec type.
 *
 * @since v3.4.5
 */
enum VIDEO_CODEC_TYPE {
  /** 1: VP8 */
  VIDEO_CODEC_VP8 = 1,
  /** 2: (Default) H.264 */
  VIDEO_CODEC_H264 = 2,
  /** 3: Enhanced VP8 */
  VIDEO_CODEC_EVP = 3,
  /** 4: Enhanced H.264 */
  VIDEO_CODEC_E264 = 4,
};

/**
 * The VideoEncodedFrame struct.
 *
 * @since v3.4.5
 */
struct VideoEncodedFrame {
  VideoEncodedFrame() : codecType(VIDEO_CODEC_H264), width(0), height(0), buffer(nullptr), length(0), frameType(CODEC_VIDEO_FRAME_TYPE_BLANK_FRAME), rotation(VIDEO_ROTATION_0), renderTimeMs(0) {}
  /**
   * The video codec type. See #VIDEO_CODEC_TYPE.
   */
  VIDEO_CODEC_TYPE codecType;
  /**
   * The width (px) of the video.
   */
  int width;
  /**
   * The height (px) of the video.
   */
  int height;
  /**
   * The video buffer, which is in the `DirectByteBuffer` data type.
   */
  const uint8_t* buffer;
  /**
   * The length (in bytes) of the video buffer.
   */
  unsigned int length;
  /**
   * The video frame type. See #CODEC_VIDEO_FRAME_TYPE.
   */
  CODEC_VIDEO_FRAME_TYPE frameType;
  /**
   * The clockwise rotation angle of the video frame. See #VIDEO_ROTATION.
   */
  VIDEO_ROTATION rotation;
  /**
   * The Unix timestamp (ms) when the video frame is rendered. This timestamp
   * can be used to guide the rendering of the video frame. This parameter is required.
   */
  int64_t renderTimeMs;
};
/**
 * The IVideoEncodedFrameObserver class.
 *
 * @since v3.4.5
 */
class IVideoEncodedFrameObserver {
 public:
  /**
   * Gets the local encoded video frame.
   *
   * @since v3.4.5
   *
   * After you successfully register the local encoded video frame observer,
   * the SDK triggers this callback each time a video frame is received. You
   * can get the local encoded video frame in `videoEncodedFrame` and then
   * process the video data according to your scenario. After processing,
   * you can use `videoEncodedFrame` to pass the processed video data back to
   * the SDK.
   *
   * @param videoEncodedFrame The local encoded video frame. See VideoEncodedFrame.
   *
   * @return
   * - true: Reserved for future use.
   * - false: Reserved for future use.
   */
  virtual bool onVideoEncodedFrame(const VideoEncodedFrame& videoEncodedFrame) = 0;

  virtual ~IVideoEncodedFrameObserver() {}
};

class IMediaEngine {
 public:
  virtual ~IMediaEngine(){};
  virtual void release() = 0;
  /** Registers an audio frame observer object.

   This method is used to register an audio frame observer object (register a callback). This method is required to register callbacks when the engine is required to provide an \ref IAudioFrameObserver::onRecordAudioFrame "onRecordAudioFrame" or \ref IAudioFrameObserver::onPlaybackAudioFrame "onPlaybackAudioFrame" callback.

   @note Ensure that you call this method before joining a channel.

   @param observer Audio frame observer object instance. See IAudioFrameObserver. Set the value as NULL to release the
   audio observer object. Agora recommends calling `registerAudioFrameObserver(NULL)` after receiving the \ref agora::rtc::IRtcEngineEventHandler::onLeaveChannel "onLeaveChannel" callback.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int registerAudioFrameObserver(IAudioFrameObserver* observer) = 0;
  /** Registers a video frame observer object.
   *
   * You need to implement the IVideoFrameObserver class in this method, and register callbacks according to your scenarios.
   *
   * After you successfully register the video frame observer, the SDK triggers the registered callbacks each time a video frame is received.
   *
   * @note
   * - When handling the video data returned in the callbacks, pay attention to the changes in the `width` and `height` parameters,
   * which may be adapted under the following circumstances:
   *  - When the network condition deteriorates, the video resolution decreases incrementally.
   *  - If the user adjusts the video profile, the resolution of the video returned in the callbacks also changes.
   * - Ensure that you call this method before joining a channel.
   * @param observer Video frame observer object instance. If NULL is passed in, the registration is canceled.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int registerVideoFrameObserver(IVideoFrameObserver* observer) = 0;
  /** **DEPRECATED** */
  virtual int registerVideoRenderFactory(IExternalVideoRenderFactory* factory) = 0;
  /**
   * Pushes the external audio frame.
   *
   * @deprecated This method is deprecated. Use \ref IMediaEngine::pushAudioFrame(int32_t,IAudioFrameObserver::AudioFrame*) "pushAudioFrame" [3/3] instead.
   *
   * @param type Type of audio capture device: #MEDIA_SOURCE_TYPE.
   * @param frame Audio frame pointer: \ref IAudioFrameObserver::AudioFrame "AudioFrame".
   * @param wrap Whether to use the placeholder. We recommend setting the default value.
   * - true: Use.
   * - false: (Default) Not use.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int pushAudioFrame(MEDIA_SOURCE_TYPE type, IAudioFrameObserver::AudioFrame* frame, bool wrap) AGORA_DEPRECATED_ATTRIBUTE = 0;
  /** Pushes the external audio frame.
   *
   * @deprecated This method is deprecated. Use \ref IMediaEngine::pushAudioFrame(int32_t,IAudioFrameObserver::AudioFrame*) "pushAudioFrame" [3/3] instead.
   *
   * @param frame Pointer to the audio frame: \ref IAudioFrameObserver::AudioFrame "AudioFrame".
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int pushAudioFrame(IAudioFrameObserver::AudioFrame* frame) AGORA_DEPRECATED_ATTRIBUTE = 0;

  /**
   * Pushes the external audio frame to a specified position.
   *
   * @since v3.5.1
   *
   * According to your needs, you can push the external audio frame to one of three positions: after audio capture,
   * before audio encoding, or before local playback. You can call this method multiple times to push one audio frame
   * to multiple positions or multiple audio frames to different positions. For example, in the KTV scenario, you can
   * push the singing voice to after audio capture, so that the singing voice can be processed by the SDK audio module
   * and you can obtain a high-quality audio experience; you can also push the accompaniment to before audio encoding,
   * so that the accompaniment is not affected by the audio module of the SDK.
   *
   * @note Call this method after joining a channel.
   *
   * @param sourcePos The push position of the external audio frame. See #AUDIO_EXTERNAL_SOURCE_POSITION.
   * @param frame The external audio frame. See AudioFrame. The value range of the audio frame length (ms) is [10,60].
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *  - `-2 (ERR_INVALID_ARGUMENT)`: The parameter is invalid.
   *  - `-12 (ERR_TOO_OFTEN)`: The call frequency is too high, causing the internal buffer to overflow. Call this method again after 30-50 ms.
   */
  virtual int pushAudioFrame(int32_t sourcePos, IAudioFrameObserver::AudioFrame* frame) = 0;
  /**
   * Sets the volume of the external audio frame in the specified position.
   *
   * @since v3.5.1
   *
   * You can call this method multiple times to set the volume of external audio frames in different positions.
   * The volume setting takes effect for all external audio frames that are pushed to the specified position.
   *
   * @note Call this method after joining a channel.
   *
   * @param sourcePos The push position of the external audio frame. See #AUDIO_EXTERNAL_SOURCE_POSITION.
   * @param volume The volume of the external audio frame. The value range is [0,100]. The default value is 100, which
   * represents the original value.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   *  - `-2 (ERR_INVALID_ARGUMENT)`: The parameter is invalid.
   */
  virtual int setExternalAudioSourceVolume(int32_t sourcePos, int32_t volume) = 0;
  /** Pulls the remote audio data.
   *
   * Before calling this method, call the
   * \ref agora::rtc::IRtcEngine::setExternalAudioSink
   * "setExternalAudioSink(enabled: true)" method to enable and set the
   * external audio sink.
   *
   * After a successful method call, the app pulls the decoded and mixed
   * audio data for playback.
   *
   * @note
   * - Ensure that you call this method after joining a channel.
   * - Once you call the \ref agora::media::IMediaEngine::pullAudioFrame
   * "pullAudioFrame" method successfully, the app will not get any audio
   * data from the
   * \ref agora::media::IAudioFrameObserver::onPlaybackAudioFrame
   * "onPlaybackAudioFrame" callback.
   * - The difference between the
   * \ref agora::media::IAudioFrameObserver::onPlaybackAudioFrame
   * "onPlaybackAudioFrame" callback and the
   * \ref agora::media::IMediaEngine::pullAudioFrame "pullAudioFrame" method is as
   * follows:
   *  - `onPlaybackAudioFrame`: The SDK sends the audio data to the app through this callback.
   * Any delay in processing the audio frames may result in audio jitter.
   *  - `pullAudioFrame`: The app pulls the remote audio data. After setting the
   * audio data parameters, the SDK adjusts the frame buffer and avoids
   * problems caused by jitter in the external audio playback.
   *
   * @param frame Pointers to the audio frame.
   * See: \ref IAudioFrameObserver::AudioFrame "AudioFrame".
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int pullAudioFrame(IAudioFrameObserver::AudioFrame* frame) = 0;
  /** Configures the external video source.

  @note Ensure that you call this method before joining a channel.

  @param enable Sets whether to use the external video source:
  - true: Use the external video source.
  - false: (Default) Do not use the external video source.

  @param useTexture Sets whether to use texture as an input:
  - true: Use texture as an input.
  - false: (Default) Do not use texture as an input.

  @return
  - 0: Success.
  - < 0: Failure.
  */
  virtual int setExternalVideoSource(bool enable, bool useTexture) = 0;
  /** Pushes the video frame using the \ref ExternalVideoFrame "ExternalVideoFrame" and passes the video frame to the Agora SDK.

   @param frame Video frame to be pushed. See \ref ExternalVideoFrame "ExternalVideoFrame".

   @note In the `COMMUNICATION` profile, this method does not support video frames in the Texture format.

   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int pushVideoFrame(ExternalVideoFrame* frame) = 0;
  /**
   * Registers a local encoded video frame observer.
   *
   * @since v3.4.5
   *
   * After you successfully register the local encoded video frame observer,
   * the SDK triggers the callbacks that you have implemented in the
   * IVideoEncodedFrameObserver class each time a video frame is received.
   *
   * @note
   * - Ensure that you call this method before joining a channel.
   * - The width and height of the video obtained through the observer may
   * change due to poor network conditions and user-adjusted resolution.
   *
   * @param observer The local encoded video frame observer. See IVideoEncodedFrameObserver.
   * If null is passed, the observer registration is canceled.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int registerVideoEncodedFrameObserver(IVideoEncodedFrameObserver* observer) = 0;
};

}  // namespace media

}  // namespace agora

#endif  // AGORA_MEDIA_ENGINE_H
