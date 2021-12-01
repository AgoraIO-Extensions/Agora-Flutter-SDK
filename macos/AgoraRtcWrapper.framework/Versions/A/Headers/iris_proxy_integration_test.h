#include "internal/log/iris_logger.h"
#include "iris_event_handler.h"
#include "iris_proxy.h"
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
class IRIS_DEBUG_CPP_API IrisProxyCallApi : public agora::iris::IrisProxy {

 public:
  IrisProxyCallApi();

  ~IrisProxyCallApi();

  void SetEventHandler(agora::iris::IrisEventHandler *event_handler) override {
    // Do nothing
  }

  int CallApi(unsigned int api_type, const char *params, char *result) override;

  int CallApi(unsigned int api_type, const char *params, void *buffer,
              char *result) override;

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

/**
 * @brief A mock implementation of IrisProxy that help test the IrisRtcEngine event handler
 *        callback function call on integration test.
 */
class IRIS_DEBUG_CPP_API IrisProxyEventHandler : public agora::iris::IrisProxy {

 public:
  IrisProxyEventHandler();

  ~IrisProxyEventHandler();

  void SetEventHandler(agora::iris::IrisEventHandler *event_handler) override;

  void CallEventHandlerOnEvent(const char *event, const char *data);

  void CallEventHandlerOnEventWithBuffer(const char *event, const char *data,
                                         const void *buffer,
                                         unsigned int length);

  int CallApi(unsigned int api_type, const char *params,
              char *result) override {
    // Do nothing
    return 0;
  }

  int CallApi(unsigned int api_type, const char *params, void *buffer,
              char *result) override {
    // Do nothing
    return 0;
  }

 private:
  agora::iris::IrisEventHandler *event_handler_;
};