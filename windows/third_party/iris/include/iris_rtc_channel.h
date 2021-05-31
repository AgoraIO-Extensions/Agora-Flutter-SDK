//
// Created by LXH on 2021/1/19.
//

#ifndef IRIS_RTC_CHANNEL_H_
#define IRIS_RTC_CHANNEL_H_

#include "iris_event_handler.h"
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

class IRIS_CPP_API IrisRtcChannel {
 public:
  IrisRtcChannel();
  virtual ~IrisRtcChannel();

  void Initialize(agora::rtc::IRtcEngine *engine);

  void Release();

  void SetEventHandler(IrisEventHandler *event_handler);

  void RegisterEventHandler(const char *channel_id,
                            IrisEventHandler *event_handler);

  void UnRegisterEventHandler(const char *channel_id);

  void SetProxy(IrisProxy *proxy);

#if defined(IRIS_DEBUG)
  void EnableTest(test::IrisRtcTester *tester);
#endif

  int CallApi(ApiTypeChannel api_type, const char *params,
              char result[kBasicResultLength]);

  int CallApi(ApiTypeChannel api_type, const char *params, void *buffer,
              char result[kBasicResultLength]);

 private:
  IrisProxy *proxy_;
  class IrisRtcChannelImpl;
  IrisRtcChannelImpl *channel_;
};
}// namespace rtc
}// namespace iris
}// namespace agora

#endif//IRIS_RTC_CHANNEL_H_
