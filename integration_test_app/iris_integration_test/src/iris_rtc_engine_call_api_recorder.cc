#include "iris_rtc_engine_call_api_recorder.h"


IrisRtcEngineCallApiRecoder::IrisRtcEngineCallApiRecoder() {}

IrisRtcEngineCallApiRecoder::~IrisRtcEngineCallApiRecoder() {}

void IrisRtcEngineCallApiRecoder::Clear() {
  for (std::vector<ApiCall>::iterator it = apiCallQueue_.begin();
       it != apiCallQueue_.end(); ++it) {
    if (it->buffer) { free(it->buffer); }
  }
  apiCallQueue_.clear();

  mockResultMap_.clear();
  mockReturnCodeMap_.clear();
}

void IrisRtcEngineCallApiRecoder::MockCallApiResult(unsigned int api_type,
                                                    const char *params,
                                                    const char *mockResult) {
  MockResultKey key;
  key.api_type = api_type;
  if (params) { key.params = std::string(params); }

  mockResultMap_.insert(std::make_pair(key, std::string(mockResult)));
}

void IrisRtcEngineCallApiRecoder::MockCallApiReturnCode(unsigned int api_type,
                                                        const char *params,
                                                        int mockReturnCode) {
  MockResultKey key;
  key.api_type = api_type;
  if (params) { key.params = std::string(params); }

  mockReturnCodeMap_.insert(std::make_pair(key, mockReturnCode));
}

void IrisRtcEngineCallApiRecoder::SetExplicitBufferSize(unsigned int api_type,
                                                        const char *params,
                                                        int size) {
  MockResultKey key;
  key.api_type = api_type;
  if (params) { key.params = std::string(params); }
  explicitBufferSizeMap_.insert(std::make_pair(key, size));
}

bool IrisRtcEngineCallApiRecoder::ExpectCalledApi(unsigned int api_type,
                                                  const char *params,
                                                  void *buffer,
                                                  int buffer_size) {
  for (std::vector<ApiCall>::iterator it = apiCallQueue_.begin();
       it != apiCallQueue_.end(); ++it) {
    if (it->api_type == api_type) {
      bool isParamsEq = it->params == std::string(params);
      bool isBufferEq = true;
      if (buffer) {
        isBufferEq = it->buffer_size == buffer_size
            && memcmp(it->buffer, buffer, buffer_size) == 0;
      }

      return isParamsEq && isBufferEq;
    }
  }
  return false;
}

int IrisRtcEngineCallApiRecoder::CallApi(int api_type, const char *params,
                                         char result[kBasicResultLength]) {
  // IRIS_LOG_D("IrisRtcEngineCallApiRecoder CallApi2 api_type {} params {}",
  //            api_type, params);
  return CallApi(api_type, params, nullptr, 0, result);
}

int IrisRtcEngineCallApiRecoder::CallApi(int api_type, const char *params,
                                         void *buffer, unsigned int length,
                                         char result[kBasicResultLength]) {
  // IRIS_LOG_D("IrisRtcEngineCallApiRecoder CallApi3 api_type {} params {}",
  //            api_type, params);

  ApiCall apiCall;
  apiCall.api_type = api_type;
  apiCall.params = std::string(params);

  MockResultKey key;
  key.api_type = api_type;
  if (params) { key.params = std::string(params); }

  if (buffer) {
    if (explicitBufferSizeMap_.find(key) != explicitBufferSizeMap_.end()) {
      int bufferSize = explicitBufferSizeMap_[key];
      unsigned char *tmp = static_cast<unsigned char *>(buffer);

      unsigned char *copyBytes = (unsigned char *) malloc(bufferSize);
      memcpy(copyBytes, tmp, bufferSize);
      apiCall.buffer = copyBytes;
      apiCall.buffer_size = bufferSize;
    }
  } else {
    apiCall.buffer = nullptr;
    apiCall.buffer_size = 0;
  }

  apiCallQueue_.push_back(apiCall);

  if (mockResultMap_.find(key) != mockResultMap_.end()) {
    strcpy(result, mockResultMap_[key].c_str());
  }

  if (mockReturnCodeMap_.find(key) != mockReturnCodeMap_.end()) {
    return mockReturnCodeMap_[key];
  }

  return 0;
}