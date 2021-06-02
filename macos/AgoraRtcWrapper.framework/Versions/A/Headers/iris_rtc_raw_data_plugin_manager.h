//
// Created by LXH on 2021/4/21.
//

#ifndef IRIS_RTC_RAW_DATA_PLUGIN_MANAGER_H_
#define IRIS_RTC_RAW_DATA_PLUGIN_MANAGER_H_

#include "iris_proxy.h"
#include "iris_rtc_raw_data.h"
#include "iris_rtc_raw_data_plugin.h"

namespace agora {
namespace iris {
namespace rtc {
static const int kMaxPluginIdLength = 512;

class IRIS_CPP_API IrisRtcRawDataPlugin : public IrisRtcAudioFrameObserver,
                                          public IrisRtcVideoFrameObserver {
 public:
  explicit IrisRtcRawDataPlugin(const char plugin_id[kMaxPluginIdLength],
                                const char *plugin_path);
  virtual ~IrisRtcRawDataPlugin();

  const char *plugin_id();

  int Enable(bool enabled);

  int SetParameter(const char *parameter);

  const char *GetParameter(const char *key);

 public:
  bool OnRecordAudioFrame(IrisRtcAudioFrame &audio_frame) override;

  bool OnPlaybackAudioFrame(IrisRtcAudioFrame &audio_frame) override;

  bool OnMixedAudioFrame(IrisRtcAudioFrame &audio_frame) override;

  bool
  OnPlaybackAudioFrameBeforeMixing(unsigned int uid,
                                   IrisRtcAudioFrame &audio_frame) override;

  bool OnCaptureVideoFrame(IrisRtcVideoFrame &video_frame) override;

  bool OnRenderVideoFrame(unsigned int uid,
                          IrisRtcVideoFrame &video_frame) override;

 private:
  char plugin_id_[kMaxPluginIdLength];
  void *plugin_dynamic_lib_;
  IAVFramePlugin *plugin_;
  bool enabled_;
};

class IRIS_CPP_API IrisRtcRawDataPluginManager {
 public:
  explicit IrisRtcRawDataPluginManager(IrisRtcRawData *raw_data);
  virtual ~IrisRtcRawDataPluginManager();

  void SetProxy(IrisProxy *proxy);

  int CallApi(ApiTypeRawDataPluginManager api_type, const char *params,
              char result[kMaxResultLength]);

 private:
  IrisProxy *proxy_;
  class IrisRtcRawDataPluginManagerImpl;
  IrisRtcRawDataPluginManagerImpl *plugin_manager_;
};
}// namespace rtc
}// namespace iris
}// namespace agora

#endif//IRIS_RTC_RAW_DATA_PLUGIN_MANAGER_H_
