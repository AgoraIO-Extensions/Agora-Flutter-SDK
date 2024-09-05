#pragma once

/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#include "handle.h"
#include "../common.h"
#include "c_error.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef struct RteRemoteTrackConfig {
    char placeholder;
} RteRemoteTrackConfig;

typedef struct RteRemoteTrackInfo {
    char placeholder;
} RteRemoteTrackInfo;

typedef struct RteRemoteTrackObserver {
    char placeholder;
} RteRemoteTrackObserver;

// @{
// Info
AGORA_RTE_API_C void RteRemoteTrackInfoInit(RteRemoteTrackInfo *info,
                                           RteError *err);
AGORA_RTE_API_C void RteRemoteTrackInfoDeinit(RteRemoteTrackInfo *info,
                                             RteError *err);
//}

AGORA_RTE_API_C void RteRemoteTrackGetInfo(RteRemoteTrack *self,
                                          RteRemoteTrackInfo *info,
                                          RteError *err);

#ifdef __cplusplus
}
#endif  // __cplusplus
