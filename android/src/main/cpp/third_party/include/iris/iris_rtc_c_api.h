//
// Created by LXH on 2021/1/14.
//

#ifndef IRIS_RTC_C_API_H_
#define IRIS_RTC_C_API_H_

#include "iris_base.h"
#include "iris_platform.h"

EXTERN_C_ENTER

typedef enum IRIS_API_ERROR_CODE_TYPE {
  IRIS_API_NOT_CREATE = 666666,
} IRIS_API_ERROR_CODE_TYPE;

IRIS_API int IRIS_CALL CallIrisApi(IrisApiEnginePtr api_engine,
                                   ApiParam *param);

IRIS_API IrisApiEnginePtr IRIS_CALL CreateIrisApiEngine(IrisHandle rtc_engine);

IRIS_API void IRIS_CALL DestroyIrisApiEngine(IrisApiEnginePtr api_engine);

IRIS_API IrisEventHandlerHandle IRIS_CALL
CreateIrisEventHandler(IrisCEventHandler *c_event_handler);

IRIS_API void IRIS_CALL DestroyIrisEventHandler(IrisEventHandlerHandle handler);

EXTERN_C_LEAVE

#endif//IRIS_RTC_C_API_H_
