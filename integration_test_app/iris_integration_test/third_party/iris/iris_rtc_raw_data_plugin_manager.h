//
// Created by LXH on 2021/4/21.
//

#ifndef IRIS_RTC_RAW_DATA_PLUGIN_MANAGER_H_
#define IRIS_RTC_RAW_DATA_PLUGIN_MANAGER_H_

#include "iris_delegate.h"
#include "iris_rtc_base.h"

namespace agora {
namespace iris {
namespace rtc {

class IrisRtcRawData;

class IRIS_CPP_API IIrisRtcRawDataPluginManager
    : public IrisDelegate<ApiTypeRawDataPluginManager> {
 public:
  using IrisDelegate::CallApi;

  virtual void Initialize(IrisCommonObserverManager *manager) = 0;

  void SetEventHandler(IrisEventHandler *event_handler) override;

  IrisEventHandler *GetEventHandler() override;

  int CallApi(ApiTypeRawDataPluginManager api_type, const char *params,
              void *buffer, unsigned int length, char *result) override;
};

class IRIS_CPP_API IrisRtcRawDataPluginManager
    : public IIrisRtcRawDataPluginManager {
 public:
  explicit IrisRtcRawDataPluginManager(
      IIrisRtcRawDataPluginManager *delegate = nullptr);
  ~IrisRtcRawDataPluginManager() override;

  int CallApi(ApiTypeRawDataPluginManager api_type, const char *params,
              char result[kMaxResultLength]) override;

  void Initialize(IrisCommonObserverManager *manager) override;

 private:
  IIrisRtcRawDataPluginManager *delegate_;
};

}// namespace rtc
}// namespace iris
}// namespace agora

#endif//IRIS_RTC_RAW_DATA_PLUGIN_MANAGER_H_
