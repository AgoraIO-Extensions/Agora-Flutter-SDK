/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include "handle.h"
#include "../common.h"
#include "track/local_video_track.h"
#include "utils/rect.h"
#include "utils/string.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef enum RteScreenCaptureType {
  kRteScreenCaptureTypeScreen,
  kRteScreenCaptureTypeWindow,
} RteScreenCaptureType;

typedef void *RteWindow;
typedef void *RteMonitor;

typedef struct RteScreenVideoTrackConfig {
  RteLocalVideoTrackConfig local_video_track_config;

  RteScreenCaptureType type;
  bool has_type;

  RteWindow window;
  bool has_window;

  RteMonitor monitor;
  bool has_monitor;

  RteRect rect;
  bool has_rect;

  RteString *json_parameter;
  bool has_json_parameter;
} RteScreenVideoTrackConfig;

AGORA_RTE_API_C RteScreenVideoTrack RteScreenVideoTrackCreate(
    Rte *rte, RteScreenVideoTrackConfig *config, RteError *err);
AGORA_RTE_API_C void RteScreenVideoTrackDestroy(RteScreenVideoTrack *self,
                                               RteError *err);

AGORA_RTE_API_C void RteScreenVideoTrackGetConfigs(
    RteScreenVideoTrack *self, RteScreenVideoTrackConfig *config,
    RteError *err);
AGORA_RTE_API_C void RteScreenVideoTrackSetConfigs(
    RteScreenVideoTrack *self, RteScreenVideoTrackConfig *config,
    void (*cb)(RteScreenVideoTrack *track, void *cb_data, RteError *err),
    void *cb_data);

#ifdef __cplusplus
}
#endif  // __cplusplus
