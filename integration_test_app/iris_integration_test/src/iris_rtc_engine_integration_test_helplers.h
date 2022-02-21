// This file is mainly used on integration test
#ifndef IRIS_RTC_ENGINE_INTEGRATION_TEST_HELPERS_H_
#define IRIS_RTC_ENGINE_INTEGRATION_TEST_HELPERS_H_

#include "iris_rtc_c_api.h"

#ifdef __cplusplus
extern "C" {
#endif

/**
 * @brief Set a IrisRtcEngineCallApiRecoder to IrisRtcEngine to record api called 
 *        on integration test
 * 
 * @param engine_ptr The pointer of the IrisRtcEngine
 * @param isMockChannel Whether mock for IrisRtcChannel
 * @return The mock IrisRtcEngineCallApiRecoder object pointer
 */
IRIS_API void *SetIrisRtcEngineCallApiRecorder(IrisRtcEnginePtr engine_ptr,
                                               bool isMockChannel);

/**
 * @brief Clear the IrisRtcEngineCallApiRecoder api call records which set by 
 *        SetIrisRtcEngineCallApiRecorder function
 * 
 * @param call_api_recorder_ptr The pointer of the IrisRtcEngineCallApiRecoder
 */
IRIS_API void ClearCallApiRecorder(void *call_api_recorder_ptr);

/**
 * @brief Mock IrisRtcEngine call api result
 * 
 * @param call_api_recorder_ptr The mock IrisRtcEngineCallApiRecoder object pointer
 * @param api_type The ApiTypeEngine or ApiTypeChannel
 * @param params The params of call api
 * @param mockResult The mock result that set in integration test
 */
IRIS_API void MockCallApiResult(void *call_api_recorder_ptr,
                                unsigned int api_type, const char *params,
                                const char *mockResult);

/**
 * @brief Mock IrisRtcEngine call api return code
 * 
 * @param call_api_recorder_ptr The mock IrisRtcEngineCallApiRecoder object pointer
 * @param api_type The ApiTypeEngine or ApiTypeChannel
 * @param params The params of call api
 * @param mockReturnCode The mock result that set in integration test
 */
IRIS_API void MockCallApiReturnCode(void *call_api_recorder_ptr,
                                    unsigned int api_type, const char *params,
                                    int mockReturnCode);

/**
 * @brief Set the buffer size of the buffer for specific call api
 * 
 * @param call_api_recorder_ptr The mock IrisRtcEngineCallApiRecoder object pointer
 * @param api_type The ApiTypeEngine or ApiTypeChannel
 * @param params The params of call api
 * @param size The buffer size
 * @return IRIS_API 
 */
IRIS_API void SetExplicitBufferSize(void *call_api_recorder_ptr,
                                    unsigned int api_type, const char *params,
                                    int size);

/**
 * @brief Verify whether the call api function be called
 * 
 * @param call_api_recorder_ptr The mock IrisRtcEngineCallApiRecoder object pointer
 * @param api_type The ApiTypeEngine or ApiTypeChannel
 * @param params The params of call api
 * @param buffer The buffer of call api
 * @param buffer_size The buffer size of call api
 * @return true if the call api with specific api_type, params, buffer, buffer_size be called
 */
IRIS_API bool ExpectCalledApi(void *call_api_recorder_ptr,
                              unsigned int api_type, const char *params,
                              void *buffer, int buffer_size);

/**
 * @brief Call the onEvent function of EventHandler, to fire a event 
 *        callback directly in integration test
 * 
 * @param engine_ptr The pointer of the IrisRtcEngine
 * @param event The event parameter of onEvent function
 * @param data The data parameter of onEvent function
 */
IRIS_API void CallIrisEventHandlerOnEvent(void *engine_ptr, bool isMockChannel,
                                          const char *event, const char *data);

/**
 * @brief Call the onEvent function with buffer of EventHandler, to fire a event 
 *        callback directly in integration test
 * 
 * @param engine_ptr The pointer of the IrisRtcEngine
 * @param event The event parameter of onEvent function
 * @param data The data parameter of onEvent function
 * @param buffer The buffer parameter of onEvent function
 * @param length The length parameter of onEvent function
 */
IRIS_API void
CallIrisEventHandlerOnEventWithBuffer(void *engine_ptr, bool isMockChannel,
                                      const char *event, const char *data,
                                      const void *buffer, unsigned int length);

#ifdef __cplusplus
}
#endif

#endif// IRIS_RTC_ENGINE_INTEGRATION_TEST_HELPERS_H_