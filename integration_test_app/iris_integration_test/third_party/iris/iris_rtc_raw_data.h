//
// Created by LXH on 2021/3/1.
//

#ifndef IRIS_RTC_RAW_DATA_H_
#define IRIS_RTC_RAW_DATA_H_

#include "iris_event_handler.h"
#include "iris_rtc_base.h"
#include "iris_rtc_raw_data_plugin_manager.h"
#include <cstdint>

namespace agora {
namespace rtc {

class IRtcEngine;

}

namespace iris {
namespace rtc {

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

class IrisRtcPacketObserver : public IrisPacketObserver {};

class IRIS_CPP_API IIrisRtcRawData {
 public:
  virtual ~IIrisRtcRawData() = default;

  virtual void Initialize(agora::rtc::IRtcEngine *rtc_engine) = 0;

  virtual void Release() = 0;

  virtual IIrisRtcRawDataPluginManager *plugin_manager() = 0;
};

class IRIS_CPP_API IrisRtcRawData : public IIrisRtcRawData,
                                    public IrisCommonObserverManager {
 public:
  explicit IrisRtcRawData(IIrisRtcRawData *delegate = nullptr);
  ~IrisRtcRawData() override;

  void Initialize(agora::rtc::IRtcEngine *rtc_engine) override;

  void Release() override;

  IIrisRtcRawDataPluginManager *plugin_manager() override;

 private:
  IIrisRtcRawData *delegate_;
};

}// namespace rtc
}// namespace iris
}// namespace agora

#endif//IRIS_RTC_RAW_DATA_H_
