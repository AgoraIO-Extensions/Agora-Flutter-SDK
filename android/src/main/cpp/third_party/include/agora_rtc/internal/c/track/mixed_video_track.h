#pragma once

/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#include <stddef.h>

#include "handle.h"
#include "../common.h"
#include "track/local_video_track.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef struct RteLayout RteLayout;

typedef struct RteMixedVideoTrackConfig {
  RteLocalVideoTrackConfig local_video_track_config;
} RteMixedVideoTrackConfig;

AGORA_RTE_API_C size_t
RteMixedVideoTrackGetLayoutsCount(RteMixedVideoTrack *self, RteError *err);
AGORA_RTE_API_C void RteMixedVideoTrackGetLayouts(RteMixedVideoTrack *self,
                                                 RteLayout *layouts,
                                                 size_t start_idx,
                                                 size_t layouts_cnt,
                                                 RteError *err);

#ifdef __cplusplus
}
#endif  // __cplusplus
