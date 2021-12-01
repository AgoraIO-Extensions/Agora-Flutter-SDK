// This file is mainly used on integration test
#ifndef IRIS_RTC_ENGINE_INTEGRATION_TEST_HELPERS_H_
#define IRIS_RTC_ENGINE_INTEGRATION_TEST_HELPERS_H_

#include "iris_rtc_c_api.h"

#ifdef __cplusplus
extern "C" {
#endif

/**
 * @brief Set a fake IrisProxy to IrisRtcEngine for mock purpose on 
 *        call Api integration test
 * 
 * @param engine_ptr The pointer of the IrisRtcEngine
 * @param isMockChannel Whether mock for IrisRtcChannel
 * @return The mock IrisProxyCallApi object pointer
 */
IRIS_API void *SetIrisProxyCallApi(IrisRtcEnginePtr engine_ptr,
                                   bool isMockChannel);

/**
 * @brief Destroy the IrisProxy which set by SetIrisProxyCallApi function
 * 
 * @param engine_ptr The pointer of the IrisRtcEngine
 * @param isMockChannel Whether mock for IrisRtcChannel
 * @param iris_proxy_ptr The mock IrisProxyCallApi object pointer
 */
IRIS_API void DestroyIrisProxyCallApi(IrisRtcEnginePtr engine_ptr,
                                      bool isMockChannel, void *iris_proxy_ptr);

IRIS_API void *GetIrisRtcEngineFromAndroidNativeHandle(
    void *android_iris_engine_native_handle);

/**
 * @brief Mock IrisRtcEngine call api result
 * 
 * @param iris_proxy_ptr The mock IrisProxyCallApi object pointer
 * @param api_type The ApiTypeEngine or ApiTypeChannel
 * @param params The params of call api
 * @param mockResult The mock result that set in integration test
 */
IRIS_API void IrisProxyMockCallApiResult(void *iris_proxy_ptr,
                                         unsigned int api_type,
                                         const char *params,
                                         const char *mockResult);

/**
 * @brief Mock IrisRtcEngine call api return code
 * 
 * @param iris_proxy_ptr The mock IrisProxyCallApi object pointer
 * @param api_type The ApiTypeEngine or ApiTypeChannel
 * @param params The params of call api
 * @param mockReturnCode The mock result that set in integration test
 * @return IRIS_API 
 */
IRIS_API void IrisProxyMockCallApiReturnCode(void *iris_proxy_ptr,
                                             unsigned int api_type,
                                             const char *params,
                                             int mockReturnCode);

/**
 * @brief Set the buffer size of the buffer for specific call api
 * 
 * @param iris_proxy_ptr The mock IrisProxyCallApi object pointer
 * @param api_type The ApiTypeEngine or ApiTypeChannel
 * @param params The params of call api
 * @param size The buffer size
 * @return IRIS_API 
 */
IRIS_API void IrisProxySetExplicitBufferSize(void *iris_proxy_ptr,
                                             unsigned int api_type,
                                             const char *params, int size);

/**
 * @brief Verify whether the call api function be called
 * 
 * @param iris_proxy_ptr The mock IrisProxyCallApi object pointer
 * @param api_type The ApiTypeEngine or ApiTypeChannel
 * @param params The params of call api
 * @param buffer The buffer of call api
 * @param buffer_size The buffer size of call api
 * @return true if the call api with specific api_type, params, buffer, buffer_size be called
 */
IRIS_API bool IrisProxyExpectCalledApi(void *iris_proxy_ptr,
                                       unsigned int api_type,
                                       const char *params, void *buffer,
                                       int buffer_size);

/**
 * @brief Set a fake IrisProxy to IrisRtcEngine for mock purpose on 
 *        event handler integration test
 * @param engine_ptr The pointer of the IrisRtcEngine
 * @param isMockChannel Whether mock for IrisRtcChannel
 * @return The mock IrisProxyCallApi object pointer 
 */
IRIS_API void *SetIrisProxyEventHandler(IrisRtcEnginePtr engine_ptr,
                                        bool isMockChannel);
/**
 * @brief Destroy the IrisProxy which set by SetIrisProxyEventHandler function
 * 
 * @param engine_ptr The pointer of the IrisRtcEngine
 * @param isMockChannel Whether mock for IrisRtcChannel
 * @param iris_proxy_ptr The mock IrisProxyCallApi object pointer
 */
IRIS_API void DestroyIrisProxyEventHandler(IrisRtcEnginePtr engine_ptr,
                                           bool isMockChannel,
                                           void *iris_proxy_ptr);

/**
 * @brief Call the onEvent function of EventHandler, to fire a event 
 *        callback explicitly in integration test
 * 
 * @param iris_proxy_ptr The mock IrisProxyCallApi object pointer
 * @param event The event parameter of onEvent function
 * @param data The data parameter of onEvent function
 */
IRIS_API void CallIrisProxyEventHandlerOnEvent(void *iris_proxy_ptr,
                                               const char *event,
                                               const char *data);

/**
 * @brief Call the onEvent function with buffer of EventHandler, to fire a event 
 *        callback explicitly in integration test
 * 
 * @param iris_proxy_ptr The mock IrisProxyCallApi object pointer
 * @param event The event parameter of onEvent function
 * @param data The data parameter of onEvent function
 * @param buffer The buffer parameter of onEvent function
 * @param length The length parameter of onEvent function
 */
IRIS_API void CallIrisProxyEventHandlerOnEventWithBuffer(void *iris_proxy_ptr,
                                                         const char *event,
                                                         const char *data,
                                                         const void *buffer,
                                                         unsigned int length);

#ifdef __cplusplus
}
#endif

#endif// IRIS_RTC_ENGINE_INTEGRATION_TEST_HELPERS_H_