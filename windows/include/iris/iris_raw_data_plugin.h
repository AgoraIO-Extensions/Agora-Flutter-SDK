//
// Created by LXH on 2021/4/21.
//

#ifndef IRIS_INCLUDE_IRIS_IRIS_RAW_DATA_PLUGIN_H_
#define IRIS_INCLUDE_IRIS_IRIS_RAW_DATA_PLUGIN_H_

#include "iris/IAVFramePlugin.h"
#include "iris/iris_raw_data.h"

namespace agora {
namespace iris {
const int kMaxPluginIdLength = 512;

class IRIS_CPP_API IrisRawDataPlugin : public IrisAudioFrameObserver,
                                       public IrisVideoFrameObserver {
 public:
  explicit IrisRawDataPlugin(const char plugin_id[kMaxPluginIdLength],
                             const char *plugin_path);

  virtual ~IrisRawDataPlugin();

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
                             const IrisAudioFrameObserver::AudioFrame &src);

  static void CopyVideoFrame(VideoPluginFrame &dest,
                             const IrisVideoFrameObserver::VideoFrame &src);

 private:
  char plugin_id_[kMaxPluginIdLength];
  void *plugin_dynamic_lib_;
  IAVFramePlugin *plugin_;
  bool enabled_;
};

class IRIS_CPP_API IrisRawDataPluginManager {
 public:
  explicit IrisRawDataPluginManager(IrisRawData *iris_raw_data);

  virtual ~IrisRawDataPluginManager();

  int CallApi(ApiTypeRawDataPlugin api_type, const char *params,
              char result[kMaxResultLength]);

 private:
  class IrisRawDataPluginManagerImpl;
  IrisRawDataPluginManagerImpl *iris_raw_data_plugin_manager_;
};
}// namespace iris
}// namespace agora

#endif//IRIS_INCLUDE_IRIS_IRIS_RAW_DATA_PLUGIN_H_
