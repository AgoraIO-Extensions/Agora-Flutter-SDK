//
// Created by LXH on 2021/1/21.
//

#ifndef IRIS_RTC_DEVICE_MANAGER_H_
#define IRIS_RTC_DEVICE_MANAGER_H_

#include "iris_rtc_base.h"

namespace agora {
namespace rtc {
class IRtcEngine;
}

namespace iris {
class IrisProxy;

namespace rtc {
class IRIS_CPP_API IrisRtcDeviceManager {
 public:
  explicit IrisRtcDeviceManager(agora::rtc::IRtcEngine *engine);
  virtual ~IrisRtcDeviceManager();

  void SetProxy(IrisProxy *proxy);

  int CallApi(ApiTypeAudioDeviceManager api_type, const char *params,
              char result[kMaxResultLength]);

  int CallApi(ApiTypeVideoDeviceManager api_type, const char *params,
              char result[kMaxResultLength]);

 private:
  IrisProxy *proxy_;
  class IrisRtcDeviceManagerImpl;
  IrisRtcDeviceManagerImpl *device_manager_;
};
}// namespace rtc
}// namespace iris
}// namespace agora

#endif//IRIS_RTC_DEVICE_MANAGER_H_
