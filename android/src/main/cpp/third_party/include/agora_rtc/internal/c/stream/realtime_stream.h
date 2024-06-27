/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include "c_error.h"
#include "../common.h"
#include "stream/stream.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef struct RteRealTimeStreamConfig {
  RteStreamConfig stream_config;
} RteRealTimeStreamConfig;

typedef struct RteRealTimeStreamStats {
  RteStreamStats stream_stats;
} RteRealTimeStreamStats;

typedef struct RteRealTimeStreamInfo {
  RteStreamInfo stream_info;
} RteRealTimeStreamInfo;

AGORA_RTE_API_C void RteRealTimeStreamStatsInit(RteRealTimeStreamStats *stats,
                                               RteError *err);

AGORA_RTE_API_C void RteRealTimeStreamStatsDeinit(RteRealTimeStreamStats *stats,
                                                 RteError *err);

#ifdef __cplusplus
}
#endif  // __cplusplus
