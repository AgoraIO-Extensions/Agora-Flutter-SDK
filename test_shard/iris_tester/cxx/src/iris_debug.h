#ifndef __IRIS_DEBUG_H__
#define __IRIS_DEBUG_H__

#include "iris_rtc_c_api.h"

IRIS_API IrisApiEnginePtr IRIS_CALL CreateDebugApiEngine();

IRIS_API void IRIS_CALL MockApiResult(const char *apiType, const char *param,
                                      int paramLength);

IRIS_API void IRIS_CALL MockApiReturnCode(const char *apiType, int code);

IRIS_API bool IRIS_CALL ExpectCalled(const char *func_name, const char *params,
                                     uint32_t paramLength, void **buffers,
                                     uint32_t buffer_count);

IRIS_API void IRIS_CALL FireEvent(const char *event_name);

#endif