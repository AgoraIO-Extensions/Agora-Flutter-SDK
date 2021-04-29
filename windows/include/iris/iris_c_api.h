//
// Created by LXH on 2021/1/14.
//

#ifndef IRIS_C_API_H
#define IRIS_C_API_H

#include "iris_base.h"

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

typedef void *IrisEnginePtr;
typedef void *IrisChannelPtr;
typedef void *IrisDeviceManagerPtr;
typedef void *IrisTestPtr;

IRIS_API IrisEnginePtr CreateIrisEngine();

IRIS_API void DestroyIrisEngine(IrisEnginePtr iris_engine);

IRIS_API void
SetIrisEngineEventHandler(IrisEnginePtr iris_engine,
                          struct IrisCEventHandler *iris_c_event_handler);

IRIS_API int CallIrisEngineApi(IrisEnginePtr iris_engine,
                               enum ApiTypeEngine api_type, const char *params,
                               char result[kBasicResultLength]);

IRIS_API int CallIrisEngineApiWithBuffer(IrisEnginePtr iris_engine,
                                         enum ApiTypeEngine api_type,
                                         const char *params, void *buffer,
                                         char result[kBasicResultLength]);

IRIS_API IrisChannelPtr GetIrisChannel(IrisEnginePtr iris_engine);

IRIS_API void
SetIrisChannelEventHandler(IrisChannelPtr iris_channel,
                           struct IrisCEventHandler *iris_c_event_handler);

IRIS_API int CallIrisChannelApi(IrisChannelPtr iris_channel,
                                enum ApiTypeChannel api_type,
                                const char *params,
                                char result[kBasicResultLength]);

IRIS_API int CallIrisChannelApiWithBuffer(IrisChannelPtr iris_channel,
                                          enum ApiTypeChannel api_type,
                                          const char *params, void *buffer,
                                          char result[kBasicResultLength]);

IRIS_API IrisDeviceManagerPtr GetIrisDeviceManager(IrisEnginePtr iris_engine);

IRIS_API int CallAudioDeviceApi(IrisDeviceManagerPtr iris_device_manager,
                                enum ApiTypeAudioDeviceManager api_type,
                                const char *params,
                                char result[kMaxResultLength]);

IRIS_API int CallVideoDeviceApi(IrisDeviceManagerPtr iris_device_manager,
                                enum ApiTypeVideoDeviceManager api_type,
                                const char *params,
                                char result[kMaxResultLength]);

IRIS_DEBUG_API void SetProxy(IrisTestPtr iris_test, IrisEnginePtr iris_engine);

#if defined(IRIS_DEBUG)
IRIS_DEBUG_API IrisTestPtr CreateIrisTest(const char *dump_file_path);

IRIS_DEBUG_API void DestroyIrisTest(IrisTestPtr iris_test);

IRIS_DEBUG_API void
BeginApiTestByFile(IrisTestPtr iris_test, const char *case_file_path,
                   struct IrisCEventHandler *iris_c_event_handler);

IRIS_DEBUG_API void
BeginApiTest(IrisTestPtr iris_test, const char *case_content,
             struct IrisCEventHandler *iris_c_event_handler);

IRIS_DEBUG_API void
BeginEventTestByFile(IrisTestPtr iris_test, const char *case_file_path,
                     struct IrisCEventHandler *iris_c_event_handler);

IRIS_DEBUG_API void
BeginEventTest(IrisTestPtr iris_test, const char *case_content,
               struct IrisCEventHandler *iris_c_event_handler);

IRIS_DEBUG_API void OnEventReceived(IrisTestPtr iris_test, const char *event,
                                    const char *data);
#endif

#ifdef __cplusplus
}
#endif

#endif// IRIS_C_API_H
