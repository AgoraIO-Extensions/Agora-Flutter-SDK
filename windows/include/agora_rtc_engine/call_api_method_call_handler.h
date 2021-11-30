#include "iris_rtc_engine.h"
#include <flutter/method_channel.h>
#include <flutter/standard_method_codec.h>

class CallApiMethodCallHandler
{
public:
  CallApiMethodCallHandler(agora::iris::rtc::IrisRtcEngine *engine);

  ~CallApiMethodCallHandler();

  virtual void HandleMethodCall(const flutter::MethodCall<flutter::EncodableValue> &method_call,
                                std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);

  virtual int32_t CallApi(int32_t api_type, const char *params,
                          char *result);

  virtual int32_t CallApi(int32_t api_type, const char *params, void *buffer,
                          char *result);

  virtual std::string CallApiError(int32_t ret);

protected:
  agora::iris::rtc::IrisRtcEngine *irisRtcEngine_;
};
