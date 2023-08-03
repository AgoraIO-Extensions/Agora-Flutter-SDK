//
// Created by LXH on 2021/1/14.
//

#ifndef IRIS_RTC_ENGINE_H_
#define IRIS_RTC_ENGINE_H_

namespace agora {
namespace iris {
namespace rtc {

class IRIS_DEBUG_CPP_API IIrisRtcEngine : public IModule {
 public:
  virtual IModule *device_manager() = 0;

  virtual IModule *media_player() = 0;

  virtual IModule *local_audio_engine() = 0;

  virtual IModule *cloud_audio_engine() = 0;

  virtual IModule *media_recorder() = 0;

  virtual IModule *media_player_cache_manager() = 0;

  virtual IModule *music_center() = 0;
};

}// namespace rtc
}// namespace iris
}// namespace agora

#endif//IRIS_RTC_ENGINE_H_
