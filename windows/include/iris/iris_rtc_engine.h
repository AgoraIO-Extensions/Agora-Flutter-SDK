//
// Created by LXH on 2021/1/14.
//

#ifndef IRIS_RTC_ENGINE_H_
#define IRIS_RTC_ENGINE_H_

#include "iris_rtc_base.h"
#include "iris_rtc_channel.h"
#include "iris_rtc_device_manager.h"
#include "iris_rtc_raw_data.h"

namespace agora {
namespace rtc {
class IRtcEngine;
}

namespace iris {
class IrisProxy;

namespace rtc {
class IRIS_CPP_API IrisRtcEngine {
 public:
  IrisRtcEngine();
  virtual ~IrisRtcEngine();

  void SetEventHandler(IrisEventHandler *event_handler);

  void SetProxy(IrisProxy *proxy);

  void EnableTest(agora::rtc::IRtcEngine *engine);

  int CallApi(ApiTypeEngine api_type, const char *params,
              char result[kBasicResultLength]);

  int CallApi(ApiTypeEngine api_type, const char *params, void *buffer,
              char result[kBasicResultLength]);

  IrisRtcDeviceManager *device_manager();

  IrisRtcChannel *channel();

  IrisRtcRawData *raw_data();

 private:
  IrisProxy *proxy_;
  class IrisRtcEngineImpl;
  IrisRtcEngineImpl *engine_;
};
}// namespace rtc
}// namespace iris
}// namespace agora

#endif// IRIS_RTC_ENGINE_H_
