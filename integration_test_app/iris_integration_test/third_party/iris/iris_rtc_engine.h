//
// Created by LXH on 2021/1/14.
//

#ifndef IRIS_RTC_ENGINE_H_
#define IRIS_RTC_ENGINE_H_

#include "iris_rtc_channel.h"
#include "iris_rtc_device_manager.h"
#include "iris_rtc_raw_data.h"

namespace agora {
namespace iris {
namespace rtc {

class IRIS_CPP_API IIrisRtcEngine : public IrisDelegate<ApiTypeEngine> {
 public:
  using IrisDelegate::CallApi;

  virtual void Initialize(agora::rtc::IRtcEngine *rtc_engine) = 0;

  virtual int CallApi(ApiTypeEngine api_type, const char *params, void *buffer,
                      char result[kBasicResultLength]) = 0;

  virtual IIrisRtcDeviceManager *device_manager() = 0;

  virtual IIrisRtcChannel *channel() = 0;

  virtual IrisRtcRawData *raw_data() = 0;

  virtual const char *log_path() { return ""; }

  virtual void *rtc_engine() { return nullptr; }
};

class IRIS_CPP_API IrisRtcEngine : public IIrisRtcEngine {
 public:
  explicit IrisRtcEngine(IIrisRtcEngine *delegate = nullptr,
                         EngineType type = kEngineTypeNormal,
                         const char *executable_path = nullptr);
  ~IrisRtcEngine() override;

  void Initialize(agora::rtc::IRtcEngine *rtc_engine) override;

  void SetDelegate(IIrisRtcEngine *delegate);

  IIrisRtcEngine *GetDelegate();

  void SetEventHandler(IrisEventHandler *event_handler) override;

  IrisEventHandler *GetEventHandler() override;

  int CallApi(ApiTypeEngine api_type, const char *params,
              char result[kBasicResultLength]) override;

  int CallApi(ApiTypeEngine api_type, const char *params, void *buffer,
              char result[kBasicResultLength]) override IRIS_DEPRECATED;

  int CallApi(ApiTypeEngine api_type, const char *params, void *buffer,
              unsigned int length, char result[kBasicResultLength]) override;

  IIrisRtcDeviceManager *device_manager() override;

  IIrisRtcChannel *channel() override;

  IrisRtcRawData *raw_data() override;

  void *rtc_engine() override;

 private:
  IIrisRtcEngine *delegate_;
};

}// namespace rtc
}// namespace iris
}// namespace agora

#endif//IRIS_RTC_ENGINE_H_
