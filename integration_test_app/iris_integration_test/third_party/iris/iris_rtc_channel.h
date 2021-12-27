//
// Created by LXH on 2021/1/19.
//

#ifndef IRIS_RTC_CHANNEL_H_
#define IRIS_RTC_CHANNEL_H_

#include "iris_delegate.h"
#include "iris_event_handler.h"
#include "iris_rtc_base.h"

namespace agora {
namespace rtc {

class IRtcEngine;

}

namespace iris {
namespace rtc {

class IRIS_CPP_API IIrisRtcChannel : public IrisDelegate<ApiTypeChannel> {
 public:
  using IrisDelegate::CallApi;

  virtual void Initialize(agora::rtc::IRtcEngine *engine) = 0;

  virtual void Release() = 0;

  virtual void RegisterEventHandler(const char *channel_id,
                                    IrisEventHandler *event_handler) = 0;

  virtual void UnRegisterEventHandler(const char *channel_id) = 0;

  virtual int CallApi(ApiTypeChannel api_type, const char *params, void *buffer,
                      char result[kBasicResultLength]) = 0;
};

class IRIS_CPP_API IrisRtcChannel : public IIrisRtcChannel {
 public:
  explicit IrisRtcChannel(IIrisRtcChannel *delegate = nullptr);
  ~IrisRtcChannel() override;

  void SetDelegate(IIrisRtcChannel *delegate);

  void Initialize(agora::rtc::IRtcEngine *engine) override;

  void Release() override;

  void SetEventHandler(IrisEventHandler *event_handler) override;

  IrisEventHandler *GetEventHandler() override;

  void RegisterEventHandler(const char *channel_id,
                            IrisEventHandler *event_handler) override;

  void UnRegisterEventHandler(const char *channel_id) override;

  int CallApi(ApiTypeChannel api_type, const char *params,
              char result[kBasicResultLength]) override;

  int CallApi(ApiTypeChannel api_type, const char *params, void *buffer,
              char result[kBasicResultLength]) override IRIS_DEPRECATED;

  int CallApi(ApiTypeChannel api_type, const char *params, void *buffer,
              unsigned int length, char *result) override;

 private:
  IIrisRtcChannel *delegate_;
};

}// namespace rtc
}// namespace iris
}// namespace agora

#endif//IRIS_RTC_CHANNEL_H_
