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
class IrisRtcDeviceManagerImpl;

class IRIS_CPP_API IrisRtcDeviceManager {
 public:
  explicit IrisRtcDeviceManager(IrisRtcDeviceManagerImpl *impl = nullptr);
  virtual ~IrisRtcDeviceManager();

  void Initialize(agora::rtc::IRtcEngine *engine);

  void Release();

  void SetAudioDeviceManagerProxy(IrisProxy *proxy);

  void SetVideoDeviceManagerProxy(IrisProxy *proxy);

  int CallApi(ApiTypeAudioDeviceManager api_type, const char *params,
              char result[kMaxResultLength]);

  int CallApi(ApiTypeVideoDeviceManager api_type, const char *params,
              char result[kMaxResultLength]);

 private:
  IrisProxy *adm_proxy_;
  IrisProxy *vdm_proxy_;
  IrisRtcDeviceManagerImpl *impl_;
};
}// namespace rtc
}// namespace iris
}// namespace agora

#endif//IRIS_RTC_DEVICE_MANAGER_H_
