//
// Created by LXH on 2021/11/30.
//

#ifndef RTC_EVENT_HANDLER_TEST_H_
#define RTC_EVENT_HANDLER_TEST_H_

#include "iris_base.h"
#include "iris_rtc_c_api.h"

#ifdef __cplusplus
extern "C" {
#endif

IRIS_API void CallRtcEngineEvents(IrisRtcEnginePtr engine,
                                  const char *event_name);

IRIS_API void CallRtcChannelEvents(IrisRtcChannelPtr channel,
                                   const char *event_name);

#ifdef __cplusplus
};
#endif

#endif//RTC_EVENT_HANDLER_TEST_H_
