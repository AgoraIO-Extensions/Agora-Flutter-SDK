/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include "track/local_track.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef struct RteLocalVideoTrackInitialConfig {
  RteLocalTrackInitialConfig local_track_initial_config;
} RteLocalVideoTrackInitialConfig;

typedef struct RteLocalVideoTrackConfig {
  RteLocalTrackConfig local_track_config;
} RteLocalVideoTrackConfig;

#ifdef __cplusplus
}
#endif  // __cplusplus
