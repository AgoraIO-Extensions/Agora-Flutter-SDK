//
// Created by LXH on 2021/1/14.
//

#ifndef IRIS_IRIS_ENGINE_H
#define IRIS_IRIS_ENGINE_H

#include "iris_base.h"
#include "iris_channel.h"
#include "iris_device_manager.h"
#include "iris_raw_data.h"

namespace agora {
namespace rtc {
class IRtcEngine;
}

namespace iris {
class IRIS_CPP_API IrisEngine {
 public:
  IrisEngine();

  virtual ~IrisEngine();

  void SetEventHandler(IrisEventHandler *iris_event_handler);

  void SetProxy(IrisProxy *proxy);

  void EnableTest(rtc::IRtcEngine *engine);

  int CallApi(ApiTypeEngine api_type, const char *params,
              char result[kBasicResultLength]);

  int CallApi(ApiTypeEngine api_type, const char *params, void *buffer,
              char result[kBasicResultLength]);

  IrisDeviceManager *iris_device_manager();

  IrisChannel *iris_channel();

  IrisRawData *iris_raw_data();

 private:
  IrisProxy *iris_proxy_;
  class IrisEngineImpl;
  IrisEngineImpl *iris_engine_;
};
}// namespace iris
}// namespace agora

#endif// IRIS_IRIS_ENGINE_H
