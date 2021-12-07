//
// Created by LXH on 2021/1/21.
//

#ifndef IRIS_RTC_DEVICE_MANAGER_H_
#define IRIS_RTC_DEVICE_MANAGER_H_

#include "iris_delegate.h"
#include "iris_rtc_base.h"

namespace agora {
namespace rtc {

class IRtcEngine;

}

namespace iris {
namespace rtc {

class IRIS_CPP_API IIrisRtcAudioDeviceManager
    : public IrisDelegate<ApiTypeAudioDeviceManager> {
 public:
  using IrisDelegate::CallApi;

  void SetEventHandler(IrisEventHandler *event_handler) override;

  IrisEventHandler *GetEventHandler() override;

  int CallApi(ApiTypeAudioDeviceManager api_type, const char *params,
              void *buffer, unsigned int length, char *result) override;
};

class IRIS_CPP_API IIrisRtcVideoDeviceManager
    : public IrisDelegate<ApiTypeVideoDeviceManager> {
 public:
  using IrisDelegate::CallApi;

  void SetEventHandler(IrisEventHandler *event_handler) override;

  IrisEventHandler *GetEventHandler() override;

  int CallApi(ApiTypeVideoDeviceManager api_type, const char *params,
              void *buffer, unsigned int length, char *result) override;
};

class IRIS_CPP_API IIrisRtcDeviceManager : public IIrisRtcAudioDeviceManager,
                                           public IIrisRtcVideoDeviceManager {
 public:
  virtual void Initialize(agora::rtc::IRtcEngine *rtc_engine) = 0;

  virtual void Release() = 0;
};

class IRIS_CPP_API IrisRtcDeviceManager : public IIrisRtcDeviceManager {
 public:
  explicit IrisRtcDeviceManager(IIrisRtcDeviceManager *delegate = nullptr);
  ~IrisRtcDeviceManager() override;

  void Initialize(agora::rtc::IRtcEngine *rtc_engine) override;

  void Release() override;

  int CallApi(ApiTypeAudioDeviceManager api_type, const char *params,
              char result[kMaxResultLength]) override;

  int CallApi(ApiTypeVideoDeviceManager api_type, const char *params,
              char result[kMaxResultLength]) override;

 private:
  IIrisRtcDeviceManager *delegate_;
};

}// namespace rtc
}// namespace iris
}// namespace agora

#endif//IRIS_RTC_DEVICE_MANAGER_H_
