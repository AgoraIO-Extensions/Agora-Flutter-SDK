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
namespace iris {
class IrisProxy;

namespace rtc {
class IrisRtcEngineImpl;

class IRIS_CPP_API IrisRtcEngine {
 public:
  explicit IrisRtcEngine(EngineType type = kEngineTypeNormal,
                         const char *executable_path = nullptr,
                         IrisRtcEngineImpl *impl = nullptr);
  virtual ~IrisRtcEngine();

  void SetEventHandler(IrisEventHandler *event_handler);

  void SetProxy(IrisProxy *proxy);

  int CallApi(ApiTypeEngine api_type, const char *params,
              char result[kBasicResultLength]);

  int CallApi(ApiTypeEngine api_type, const char *params, void *buffer,
              char result[kBasicResultLength]);

  IrisRtcDeviceManager *device_manager();

  IrisRtcChannel *channel();

  IrisRtcRawData *raw_data();

 private:
  IrisProxy *proxy_;
  IrisRtcEngineImpl *impl_;
};

}// namespace rtc
}// namespace iris
}// namespace agora

#endif//IRIS_RTC_ENGINE_H_
