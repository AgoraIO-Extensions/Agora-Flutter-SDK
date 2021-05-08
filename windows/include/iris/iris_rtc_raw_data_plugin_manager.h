//
// Created by LXH on 2021/4/21.
//

#ifndef IRIS_RTC_RAW_DATA_PLUGIN_MANAGER_H_
#define IRIS_RTC_RAW_DATA_PLUGIN_MANAGER_H_

#include "iris_rtc_raw_data.h"
#include "iris_rtc_raw_data_plugin.h"

namespace agora {
namespace iris {
namespace rtc {
const int kMaxPluginIdLength = 512;

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

  bool OnRecordAudioFrame(AudioFrame &audio_frame) override;

  bool OnPlaybackAudioFrame(AudioFrame &audio_frame) override;

  bool OnMixedAudioFrame(AudioFrame &audio_frame) override;

  bool OnPlaybackAudioFrameBeforeMixing(unsigned int uid,
                                        AudioFrame &audio_frame) override;

  bool OnCaptureVideoFrame(VideoFrame &video_frame) override;

  bool OnRenderVideoFrame(unsigned int uid, VideoFrame &video_frame) override;

 private:
  static void CopyAudioFrame(AudioPluginFrame &dest,
                             const IrisRtcAudioFrameObserver::AudioFrame &src);

  static void CopyVideoFrame(VideoPluginFrame &dest,
                             const IrisRtcVideoFrameObserver::VideoFrame &src);

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

  int CallApi(ApiTypeRawDataPlugin api_type, const char *params,
              char result[kMaxResultLength]);

 private:
  class IrisRtcRawDataPluginManagerImpl;
  IrisRtcRawDataPluginManagerImpl *plugin_manager_;
};
}// namespace rtc
}// namespace iris
}// namespace agora

#endif//IRIS_RTC_RAW_DATA_PLUGIN_MANAGER_H_
