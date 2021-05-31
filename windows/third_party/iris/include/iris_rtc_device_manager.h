//
// Created by LXH on 2021/1/21.
//

#ifndef IRIS_RTC_DEVICE_MANAGER_H_
#define IRIS_RTC_DEVICE_MANAGER_H_

#include "iris_rtc_base.h"

namespace agora {
namespace rtc {
class IRtcEngine;
}// namespace rtc

namespace iris {
class IrisProxy;

namespace rtc {
#if defined(IRIS_DEBUG)
namespace test {
class IrisRtcTester;
}
#endif

class IRIS_CPP_API IrisRtcDeviceManager {
 public:
  IrisRtcDeviceManager();
  virtual ~IrisRtcDeviceManager();

  void Initialize(agora::rtc::IRtcEngine *engine);

  void Release();

  void SetAudioDeviceManagerProxy(IrisProxy *proxy);

  void SetVideoDeviceManagerProxy(IrisProxy *proxy);

#if defined(IRIS_DEBUG)
  void EnableTest(test::IrisRtcTester *tester);
#endif

  int CallApi(ApiTypeAudioDeviceManager api_type, const char *params,
              char result[kMaxResultLength]);

  int CallApi(ApiTypeVideoDeviceManager api_type, const char *params,
              char result[kMaxResultLength]);

 private:
  IrisProxy *audio_device_manager_proxy_;
  IrisProxy *video_device_manager_proxy_;
  class IrisRtcDeviceManagerImpl;
  IrisRtcDeviceManagerImpl *device_manager_;
};
}// namespace rtc
}// namespace iris
}// namespace agora

#endif//IRIS_RTC_DEVICE_MANAGER_H_
