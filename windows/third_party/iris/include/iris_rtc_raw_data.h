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
  virtual bool OnRecordAudioFrame(IrisRtcAudioFrame &audio_frame) = 0;

  virtual bool OnPlaybackAudioFrame(IrisRtcAudioFrame &audio_frame) = 0;

  virtual bool OnMixedAudioFrame(IrisRtcAudioFrame &audio_frame) = 0;

  virtual bool
  OnPlaybackAudioFrameBeforeMixing(unsigned int uid,
                                   IrisRtcAudioFrame &audio_frame) = 0;

  virtual bool IsMultipleChannelFrameWanted() { return false; }

  virtual bool
  OnPlaybackAudioFrameBeforeMixingEx(const char *channel_id, unsigned int uid,
                                     IrisRtcAudioFrame &audio_frame) {
    return false;
  };
};

class IrisRtcVideoFrameObserver {
 public:
  virtual bool OnCaptureVideoFrame(IrisRtcVideoFrame &video_frame) = 0;

  virtual bool OnPreEncodeVideoFrame(IrisRtcVideoFrame &video_frame) {
    return true;
  }

  virtual bool OnRenderVideoFrame(unsigned int uid,
                                  IrisRtcVideoFrame &video_frame) = 0;

  virtual VideoFrameType GetVideoFormatPreference() { return kFrameTypeYUV420; }

  virtual uint32_t GetObservedFramePosition() {
    return static_cast<uint32_t>(kPositionPostCapturer | kPositionPreRenderer);
  }

  virtual bool IsMultipleChannelFrameWanted() { return false; }

  virtual bool OnRenderVideoFrameEx(const char *channel_id, unsigned int uid,
                                    IrisRtcVideoFrame &video_frame) {
    return false;
  };
};

class IRIS_CPP_API IrisRtcRawData {
 public:
  IrisRtcRawData();
  virtual ~IrisRtcRawData();

  void Initialize(agora::rtc::IRtcEngine *rtc_engine);

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
