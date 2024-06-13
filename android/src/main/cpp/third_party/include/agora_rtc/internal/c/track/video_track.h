/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include "handle.h"
#include "../common.h"
#include "track/track.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef enum RteVideoPipelinePosition {
  kRteVideoPipelinePositionLocalPostCapturer,
  kRteVideoPipelinePositionLocalPostFilters,
  kRteVideoPipelinePositionLocalPreEncoder,
  kRteVideoPipelinePositionRemotePreRenderer
} RteVideoPipelinePosition;

typedef struct RteVideoTrackConfig {
  RteTrackConfig track_config;
} RteVideoTrackConfig;

AGORA_RTE_API_C void RteVideoTrackSetCanvas(RteVideoTrack *self, RteCanvas *canvas,
                                   RteVideoPipelinePosition position,
                                   void (*cb)(RteVideoTrack *self,
                                              RteCanvas *canvas, void *cb_data,
                                              RteError *err),
                                   void *cb_data);

#ifdef __cplusplus
}
#endif  // __cplusplus
