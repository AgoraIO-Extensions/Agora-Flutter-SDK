/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include "c_error.h"
#include "../common.h"
#include "handle.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef struct RteLocalTrackInitialConfig {
    char placeholder;
} RteLocalTrackInitialConfig;

typedef struct RteLocalTrackConfig {
    char placeholder;
} RteLocalTrackConfig;

typedef struct RteLocalTrackInfo {
    char placeholder;
} RteLocalTrackInfo;

typedef struct RteLocalTrackObserver {
    char placeholder;
} RteLocalTrackObserver;

// @{
// Info
AGORA_RTE_API_C void RteLocalTrackInfoInit(RteLocalTrackInfo *info,
                                          RteError *err);
AGORA_RTE_API_C void RteLocalTrackInfoDeinit(RteLocalTrackInfo *info,
                                            RteError *err);
//}

AGORA_RTE_API_C void RteLocalTrackStart(RteLocalTrack *self,
                                       void (*cb)(RteLocalTrack *self,
                                                  void *cb_data, RteError *err),
                                       void *cb_data);
AGORA_RTE_API_C void RteLocalTrackStop(RteLocalTrack *self,
                                      void (*cb)(RteLocalTrack *self,
                                                 void *cb_data, RteError *err),
                                      void *cb_data);

AGORA_RTE_API_C void RteLocalTrackGetInfo(RteLocalTrack *self,
                                         RteLocalTrackInfo *info,
                                         RteError *err);

#ifdef __cplusplus
}
#endif  // __cplusplus
