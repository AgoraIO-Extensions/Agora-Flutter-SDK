// This file is mainly used on integration test
#include "iris_rtc_engine_integration_test_helplers.h"
#include "fake_rtc_engine.h"
#include "iris_rtc_engine.h"
#include "iris_rtc_engine_call_api_recorder.h"
#include "iris_rtc_engine_integration_test_delegate.h"
#include <string>
#include <map>
#include <vector>

using namespace agora::iris::rtc;

IRIS_API void *SetIrisRtcEngineCallApiRecorder(IrisRtcEnginePtr engine_ptr,
                                               bool isMockChannel) {
  IrisRtcEngine *originEngine = reinterpret_cast<IrisRtcEngine *>(engine_ptr);
  IIrisRtcEngine *originDelegate = originEngine->GetDelegate();

  IrisRtcEngineCallApiRecoder *callApiRecorder =
      new IrisRtcEngineCallApiRecoder();

  IIrisRtcEngine *delegate;
  if (isMockChannel) {
    delegate = new IrisRtcEngineIntegrationTestDelegate(originDelegate, nullptr,
                                                        callApiRecorder);
  } else {
    delegate = new IrisRtcEngineIntegrationTestDelegate(
        originDelegate, callApiRecorder, nullptr);
  }
  originEngine->SetDelegate(delegate);

  agora::rtc::FakeRtcEngine *fakeRtcEngine = new agora::rtc::FakeRtcEngine();
  originEngine->Initialize(fakeRtcEngine);

  return callApiRecorder;
}

IRIS_API void ClearCallApiRecorder(void *call_api_recorder_ptr) {
  auto *apiRecoder =
      reinterpret_cast<IrisRtcEngineCallApiRecoder *>(call_api_recorder_ptr);
  apiRecoder->Clear();
}

IRIS_API void MockCallApiResult(void *call_api_recorder_ptr,
                                unsigned int api_type, const char *params,
                                const char *mockResult) {
  IrisRtcEngineCallApiRecoder *apiRecoder =
      reinterpret_cast<IrisRtcEngineCallApiRecoder *>(call_api_recorder_ptr);
  apiRecoder->MockCallApiResult(api_type, params, mockResult);
}

IRIS_API void MockCallApiReturnCode(void *call_api_recorder_ptr,
                                    unsigned int api_type, const char *params,
                                    int mockReturnCode) {
  IrisRtcEngineCallApiRecoder *apiRecoder =
      reinterpret_cast<IrisRtcEngineCallApiRecoder *>(call_api_recorder_ptr);
  apiRecoder->MockCallApiReturnCode(api_type, params, mockReturnCode);
}

IRIS_API void SetExplicitBufferSize(void *call_api_recorder_ptr,
                                    unsigned int api_type, const char *params,
                                    int size) {
  IrisRtcEngineCallApiRecoder *apiRecoder =
      reinterpret_cast<IrisRtcEngineCallApiRecoder *>(call_api_recorder_ptr);
  apiRecoder->SetExplicitBufferSize(api_type, params, size);
}

IRIS_API bool ExpectCalledApi(void *call_api_recorder_ptr,
                              unsigned int api_type, const char *params,
                              void *buffer, int buffer_size) {
  IrisRtcEngineCallApiRecoder *apiRecoder =
      reinterpret_cast<IrisRtcEngineCallApiRecoder *>(call_api_recorder_ptr);
  return apiRecoder->ExpectCalledApi(api_type, params, buffer, buffer_size);
}

IRIS_API void CallIrisEventHandlerOnEvent(void *engine_ptr, bool isMockChannel,
                                          const char *event, const char *data) {
  IrisRtcEngine *engine = reinterpret_cast<IrisRtcEngine *>(engine_ptr);
  if (isMockChannel) {
    engine->channel()->GetEventHandler()->OnEvent(event, data);
  } else {
    engine->GetEventHandler()->OnEvent(event, data);
  }
}

IRIS_API void
CallIrisEventHandlerOnEventWithBuffer(void *engine_ptr, bool isMockChannel,
                                      const char *event, const char *data,
                                      const void *buffer, unsigned int length) {
  IrisRtcEngine *engine = reinterpret_cast<IrisRtcEngine *>(engine_ptr);

  if (isMockChannel) {

    engine->channel()->GetEventHandler()->OnEvent(event, data, buffer, length);
  } else {

    engine->GetEventHandler()->OnEvent(event, data, buffer, length);
  }
}
