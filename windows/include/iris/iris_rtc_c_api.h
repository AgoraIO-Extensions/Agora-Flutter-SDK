//
// Created by LXH on 2021/1/14.
//

#ifndef IRIS_RTC_C_API_H_
#define IRIS_RTC_C_API_H_

#include "iris_rtc_base.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef void(IRIS_CALL *FUNC_OnEvent)(const char *event, const char *data);

typedef void(IRIS_CALL *FUNC_OnEventWithBuffer)(const char *event,
                                                const char *data,
                                                const void *buffer,
                                                unsigned int length);

struct IrisCEventHandler {
  FUNC_OnEvent onEvent;
  FUNC_OnEventWithBuffer onEventWithBuffer;
};

typedef void *IrisRtcEnginePtr;
typedef void *IrisRtcChannelPtr;
typedef void *IrisRtcDeviceManagerPtr;
typedef void *IrisRtcTesterPtr;

IRIS_API IrisRtcEnginePtr
CreateIrisRtcEngine(EngineType type = kEngineTypeNormal);

IRIS_API void DestroyIrisRtcEngine(IrisRtcEnginePtr engine_ptr);

IRIS_API void
SetIrisRtcEngineEventHandler(IrisRtcEnginePtr engine_ptr,
                             struct IrisCEventHandler *event_handler);

IRIS_API int CallIrisRtcEngineApi(IrisRtcEnginePtr engine_ptr,
                                  enum ApiTypeEngine api_type,
                                  const char *params, char *result);

IRIS_API int CallIrisRtcEngineApiWithBuffer(IrisRtcEnginePtr engine_ptr,
                                            enum ApiTypeEngine api_type,
                                            const char *params, void *buffer,
                                            char *result);

IRIS_API IrisRtcChannelPtr GetIrisRtcChannel(IrisRtcEnginePtr engine_ptr);

IRIS_API void
SetIrisRtcChannelEventHandler(IrisRtcChannelPtr channel_ptr,
                              struct IrisCEventHandler *event_handler);

IRIS_API int CallIrisRtcChannelApi(IrisRtcChannelPtr channel_ptr,
                                   enum ApiTypeChannel api_type,
                                   const char *params, char *result);

IRIS_API int CallIrisRtcChannelApiWithBuffer(IrisRtcChannelPtr channel_ptr,
                                             enum ApiTypeChannel api_type,
                                             const char *params, void *buffer,
                                             char *result);

IRIS_API IrisRtcDeviceManagerPtr
GetIrisRtcDeviceManager(IrisRtcEnginePtr engine_ptr);

IRIS_API int
CallIrisRtcAudioDeviceManagerApi(IrisRtcDeviceManagerPtr device_manager_ptr,
                                 enum ApiTypeAudioDeviceManager api_type,
                                 const char *params, char *result);

IRIS_API int
CallIrisRtcVideoDeviceManagerApi(IrisRtcDeviceManagerPtr device_manager_ptr,
                                 enum ApiTypeVideoDeviceManager api_type,
                                 const char *params, char *result);

IRIS_DEBUG_API void SetProxy(IrisRtcTesterPtr tester_ptr,
                             IrisRtcEnginePtr engine_ptr);

#if defined(IRIS_DEBUG)
IRIS_DEBUG_API IrisRtcTesterPtr CreateIrisRtcTester(const char *dump_file_path);

IRIS_DEBUG_API void DestroyIrisRtcTester(IrisRtcTesterPtr tester_ptr);

IRIS_DEBUG_API void BeginApiTestByFile(IrisRtcTesterPtr tester_ptr,
                                       const char *case_file_path,
                                       struct IrisCEventHandler *event_handler);

IRIS_DEBUG_API void BeginApiTest(IrisRtcTesterPtr tester_ptr,
                                 const char *case_content,
                                 struct IrisCEventHandler *event_handler);

IRIS_DEBUG_API void
BeginEventTestByFile(IrisRtcTesterPtr tester_ptr, const char *case_file_path,
                     struct IrisCEventHandler *event_handler);

IRIS_DEBUG_API void BeginEventTest(IrisRtcTesterPtr tester_ptr,
                                   const char *case_content,
                                   struct IrisCEventHandler *event_handler);

IRIS_DEBUG_API void OnEventReceived(IrisRtcTesterPtr tester_ptr,
                                    const char *event, const char *data);
#endif

#ifdef __cplusplus
}
#endif

#endif//IRIS_RTC_C_API_H_
