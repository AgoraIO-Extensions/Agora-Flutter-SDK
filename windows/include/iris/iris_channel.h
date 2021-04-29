//
// Created by LXH on 2021/1/19.
//

#ifndef IRIS_IRIS_CHANNEL_H
#define IRIS_IRIS_CHANNEL_H

#include "iris_base.h"
#include "iris_event_handler.h"

namespace agora {
namespace iris {
class IRIS_CPP_API IrisChannel {
 public:
  explicit IrisChannel(void *rtc_engine);

  virtual ~IrisChannel();

  void SetEventHandler(IrisEventHandler *iris_event_handler);

  void SetProxy(IrisProxy *proxy);

  int CallApi(ApiTypeChannel api_type, const char *params,
              char result[kBasicResultLength]);

  int CallApi(ApiTypeChannel api_type, const char *params, void *buffer,
              char result[kBasicResultLength]);

 private:
  IrisProxy *iris_proxy_;
  class IrisChannelImpl;
  IrisChannelImpl *iris_channel_;
};
}// namespace iris
}// namespace agora

#endif// IRIS_IRIS_CHANNEL_H
