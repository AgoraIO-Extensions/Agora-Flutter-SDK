//
// Created by LXH on 2021/1/21.
//

#ifndef IRIS_INCLUDE_IRIS_IRIS_DEVICE_MANAGER_H_
#define IRIS_INCLUDE_IRIS_IRIS_DEVICE_MANAGER_H_

#include "iris_base.h"

namespace agora {
namespace iris {
class IRIS_CPP_API IrisDeviceManager {
 public:
  explicit IrisDeviceManager(void *rtc_engine);

  virtual ~IrisDeviceManager();

  void SetProxy(IrisProxy *proxy);

  int CallApi(ApiTypeAudioDeviceManager api_type, const char *params,
              char result[kMaxResultLength]);

  int CallApi(ApiTypeVideoDeviceManager api_type, const char *params,
              char result[kMaxResultLength]);

 private:
  IrisProxy *iris_proxy_;
  class IrisDeviceManagerImpl;
  IrisDeviceManagerImpl *iris_device_manager_;
};
}// namespace iris
}// namespace agora

#endif//IRIS_INCLUDE_IRIS_IRIS_DEVICE_MANAGER_H_
