//
// Created by LXH on 2021/3/1.
//

#ifndef IRIS_RTC_RAW_DATA_H_
#define IRIS_RTC_RAW_DATA_H_

#include "iris_event_handler.h"
#include "iris_rtc_base.h"
#include <cstdint>

namespace agora {
namespace rtc {
class IRtcEngine;
}

namespace iris {
namespace rtc {
class IrisRtcRawDataPluginManager;
class IrisRtcRenderer;

class IrisRtcAudioFrameObserver {
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

class IrisRtcVideoFrameObserver {
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

class IRIS_CPP_API IrisRtcRawData {
 public:
  explicit IrisRtcRawData(agora::rtc::IRtcEngine *rtc_engine);
  virtual ~IrisRtcRawData();

  void Initialize();

  void Release();

  void RegisterAudioFrameObserver(IrisRtcAudioFrameObserver *observer,
                                  int order, const char *identifier);

  void UnRegisterAudioFrameObserver(const char *identifier);

  void RegisterVideoFrameObserver(IrisRtcVideoFrameObserver *observer,
                                  int order, const char *identifier);

  void UnRegisterVideoFrameObserver(const char *identifier);

  IrisRtcRawDataPluginManager *plugin_manager();

  IrisRtcRenderer *renderer();

 private:
  class IrisRtcRawDataImpl;
  IrisRtcRawDataImpl *raw_data_;
  IrisRtcRawDataPluginManager *plugin_manager_;
};
}// namespace rtc
}// namespace iris
}// namespace agora

#endif//IRIS_RTC_RAW_DATA_H_
