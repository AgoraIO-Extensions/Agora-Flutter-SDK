//
// Created by LXH on 2021/1/14.
//

#ifndef IRIS_RTC_C_API_H_
#define IRIS_RTC_C_API_H_

#include "iris_rtc_base.h"

EXTERN_C_ENTER

typedef enum IRIS_API_ERROR_CODE_TYPE {
  IRIS_API_NOT_CREATE = 666666,
} IRIS_API_ERROR_CODE_TYPE;

typedef void *IrisApiEnginePtr;

IRIS_API int IRIS_CALL CallIrisApi(IrisApiEnginePtr engine_ptr,
                                   ApiParam *param);
/// IrisRtcEngine

IRIS_API IrisApiEnginePtr IRIS_CALL CreateIrisApiEngine(void *rtcEngine);

IRIS_API void IRIS_CALL DestroyIrisApiEngine(IrisApiEnginePtr engine_ptr);

IRIS_API IrisEventHandlerHandle IRIS_CALL
CreateIrisEventHandler(IrisCEventHandler *event_handler);

IRIS_API void IRIS_CALL DestroyIrisEventHandler(IrisEventHandlerHandle handler);

EXTERN_C_LEAVE

#endif//IRIS_RTC_C_API_H_
