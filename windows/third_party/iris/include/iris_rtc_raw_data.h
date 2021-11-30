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
class IrisVideoFrameBufferManager;

namespace rtc {
class IrisRtcRawDataPluginManager;

class IrisRtcAudioFrameObserver : public IrisAudioFrameObserver {
 public:
  bool OnRecordAudioFrame(IrisAudioFrame &audio_frame) override = 0;

  virtual bool OnPlaybackAudioFrame(IrisAudioFrame &audio_frame) = 0;

  virtual bool OnMixedAudioFrame(IrisAudioFrame &audio_frame) = 0;

  virtual bool
  OnPlaybackAudioFrameBeforeMixing(unsigned int uid,
                                   IrisAudioFrame &audio_frame) = 0;

  virtual bool IsMultipleChannelFrameWanted() { return false; }

  virtual bool OnPlaybackAudioFrameBeforeMixingEx(const char *channel_id,
                                                  unsigned int uid,
                                                  IrisAudioFrame &audio_frame) {
    return false;
  };
};

class IrisRtcVideoFrameObserver : public IrisVideoFrameObserver {
 public:
  bool OnCaptureVideoFrame(IrisVideoFrame &video_frame) override = 0;

  virtual bool OnPreEncodeVideoFrame(IrisVideoFrame &video_frame) {
    return true;
  }

  virtual bool OnRenderVideoFrame(unsigned int uid,
                                  IrisVideoFrame &video_frame) = 0;

  virtual uint32_t GetObservedFramePosition() {
    return static_cast<uint32_t>(kPositionPostCapturer | kPositionPreRenderer);
  }

  virtual bool IsMultipleChannelFrameWanted() { return false; }

  virtual bool OnRenderVideoFrameEx(const char *channel_id, unsigned int uid,
                                    IrisVideoFrame &video_frame) {
    return false;
  };
};

class IRIS_CPP_API IrisRtcRawData : public IrisMediaFrameObserverManager {
 public:
  IrisRtcRawData();
  ~IrisRtcRawData() override;

  void Initialize(agora::rtc::IRtcEngine *rtc_engine);

  void Release();

  IrisRtcRawDataPluginManager *plugin_manager();

 private:
  class Impl;
  Impl *impl_;
  IrisRtcRawDataPluginManager *plugin_manager_;
};
}// namespace rtc
}// namespace iris
}// namespace agora

#endif//IRIS_RTC_RAW_DATA_H_
