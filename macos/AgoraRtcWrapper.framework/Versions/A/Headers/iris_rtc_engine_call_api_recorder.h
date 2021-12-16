#ifndef IRIS_RTC_ENGINE_DELEGATE_MOCKS_H_
#define IRIS_RTC_ENGINE_DELEGATE_MOCKS_H_

#include "IAgoraRtcEngine.h"
#include "iris_delegate.h"
#include "iris_event_handler.h"
#include "iris_rtc_engine.h"
#include <cstring>
#include <map>
#include <vector>

using namespace agora::iris::rtc;

typedef struct ApiCall {
  unsigned int api_type;
  std::string params;
  void *buffer;
  unsigned int buffer_size;
} ApiCall;

typedef struct MockResultKey {
  unsigned int api_type;
  std::string params;

  bool operator<(const MockResultKey &k) const {
    return api_type < k.api_type && params < k.params;
  }
} MockResultKey;

/**
 * @brief A mock implementation of IrisProxy that help test the IrisRtcEngine call api
 *        function call on integration test.
 */
class IRIS_DEBUG_CPP_API IrisRtcEngineCallApiRecoder
    : public agora::iris::IrisDelegate<int> {

 public:
  IrisRtcEngineCallApiRecoder();

  ~IrisRtcEngineCallApiRecoder();

  void SetEventHandler(agora::iris::IrisEventHandler *event_handler) override {
    // Do nothing
  }

  agora::iris::IrisEventHandler *GetEventHandler() override {
    // Do nothing
    return nullptr;
  }

  int CallApi(int api_type, const char *params,
              char result[kBasicResultLength]) override;

  int CallApi(int api_type, const char *params, void *buffer,
              unsigned int length, char result[kBasicResultLength]) override;

  void Clear();

  void MockCallApiResult(unsigned int api_type, const char *params,
                         const char *mockResult);

  void MockCallApiReturnCode(unsigned int api_type, const char *params,
                             int mockReturnCode);

  void SetExplicitBufferSize(unsigned int api_type, const char *params,
                             int size);

  bool ExpectCalledApi(unsigned int api_type, const char *params, void *buffer,
                       int buffer_size);

 private:
  std::vector<ApiCall> apiCallQueue_;
  std::map<MockResultKey, std::string> mockResultMap_;
  std::map<MockResultKey, int> mockReturnCodeMap_;
  std::map<MockResultKey, int> explicitBufferSizeMap_;
};

#endif// IRIS_RTC_ENGINE_DELEGATE_MOCKS_H_