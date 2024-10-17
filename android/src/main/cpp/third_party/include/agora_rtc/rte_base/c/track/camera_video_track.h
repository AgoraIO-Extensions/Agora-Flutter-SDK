/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include "rte_base/c/handle.h"
#include "rte_base/c/common.h"
#include "rte_base/c/track/local_video_track.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef struct Rte Rte;

typedef struct RteCameraVideoTrackInitialConfig {
  RteLocalVideoTrackInitialConfig local_video_track_initial_config;
} RteCameraVideoTrackInitialConfig;

typedef struct RteCameraVideoTrackConfig {
  RteLocalVideoTrackConfig local_video_track_config;
} RteCameraVideoTrackConfig;

AGORA_RTE_API_C RteCameraVideoTrack RteCameraVideoTrackCreate(
    Rte *rte, RteCameraVideoTrackConfig *config, RteError *err);
AGORA_RTE_API_C void RteCameraVideoTrackDestroy(RteCameraVideoTrack *self,
                                       RteError *err);

#ifdef __cplusplus
}
#endif  // __cplusplus
