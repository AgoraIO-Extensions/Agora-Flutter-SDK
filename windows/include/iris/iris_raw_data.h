//
// Created by LXH on 2021/3/1.
//

#ifndef IRIS_INCLUDE_IRIS_IRIS_RAW_DATA_H_
#define IRIS_INCLUDE_IRIS_IRIS_RAW_DATA_H_

#include "iris_base.h"
#include "iris_event_handler.h"
#include <cstdint>

namespace agora {
namespace iris {
class IrisRawDataPluginManager;
class IrisRenderer;

class IrisAudioFrameObserver {
 public:
  enum AudioFrameType {
    kFrameTypePCM16,
  };

  class IRIS_CPP_API AudioFrame {
   public:
    AudioFrame();
    virtual ~AudioFrame();

   public:
    AudioFrameType type;
    int samples;
    int bytes_per_sample;
    int channels;
    int samples_per_sec;
    void *buffer;
    unsigned int buffer_length;
    int64_t render_time_ms;
    int av_sync_type;
  };

 public:
  virtual bool OnRecordAudioFrame(AudioFrame &audio_frame) = 0;

  virtual bool OnPlaybackAudioFrame(AudioFrame &audio_frame) = 0;

  virtual bool OnMixedAudioFrame(AudioFrame &audio_frame) = 0;

  virtual bool OnPlaybackAudioFrameBeforeMixing(unsigned int uid,
                                                AudioFrame &audio_frame) = 0;

  virtual bool IsMultipleChannelFrameWanted() { return false; }

  virtual bool OnPlaybackAudioFrameBeforeMixingEx(const char *channel_id,
                                                  unsigned int uid,
                                                  AudioFrame &audio_frame) {
    return false;
  };
};

class IrisVideoFrameObserver {
 public:
  enum VideoFrameType {
    kFrameTypeYUV420,
    kFrameTypeYUV422,
    kFrameTypeRGBA,
  };

  enum VideoObserverPosition {
    kPositionPostCapturer = 1 << 0,
    kPositionPreRenderer = 1 << 1,
    kPositionPreEncoder = 1 << 2,
  };

  class IRIS_CPP_API VideoFrame {
   public:
    VideoFrame();
    virtual ~VideoFrame();

    void ResizeBuffer();

    void ClearBuffer();

   public:
    VideoFrameType type;
    int width;
    int height;
    int y_stride;
    int u_stride;
    int v_stride;
    void *y_buffer;
    void *u_buffer;
    void *v_buffer;
    unsigned int y_buffer_length;
    unsigned int u_buffer_length;
    unsigned int v_buffer_length;
    int rotation;
    int64_t render_time_ms;
    int av_sync_type;
  };

 public:
  virtual bool OnCaptureVideoFrame(VideoFrame &video_frame) = 0;

  virtual bool OnPreEncodeVideoFrame(VideoFrame &video_frame) { return true; }

  virtual bool OnRenderVideoFrame(unsigned int uid,
                                  VideoFrame &video_frame) = 0;

  virtual VideoFrameType GetVideoFormatPreference() { return kFrameTypeYUV420; }

  virtual bool GetRotationApplied() { return false; }

  virtual bool GetMirrorApplied() { return false; }

  virtual bool GetSmoothRenderingEnabled() { return false; }

  virtual uint32_t GetObservedFramePosition() {
    return static_cast<uint32_t>(kPositionPostCapturer | kPositionPreRenderer);
  }

  virtual bool IsMultipleChannelFrameWanted() { return false; }

  virtual bool OnRenderVideoFrameEx(const char *channel_id, unsigned int uid,
                                    VideoFrame &video_frame) {
    return false;
  };
};

class IRIS_CPP_API IrisRawData {
 public:
  explicit IrisRawData(void *rtc_engine);

  virtual ~IrisRawData();

  void Initialize();

  void Release();

  void
  RegisterAudioFrameObserver(IrisAudioFrameObserver *iris_audio_frame_observer,
                             int order, const char *identifier);

  void UnRegisterAudioFrameObserver(const char *identifier);

  void
  RegisterVideoFrameObserver(IrisVideoFrameObserver *iris_video_frame_observer,
                             int order, const char *identifier);

  void UnRegisterVideoFrameObserver(const char *identifier);

  IrisRawDataPluginManager *iris_raw_data_plugin_manager();

  IrisRenderer *iris_renderer();

 private:
  class IrisRawDataImpl;
  IrisRawDataImpl *iris_raw_data_;
  IrisRawDataPluginManager *iris_raw_data_plugin_manager_;
};
}// namespace iris
}// namespace agora

#endif//IRIS_INCLUDE_IRIS_IRIS_RAW_DATA_H_
