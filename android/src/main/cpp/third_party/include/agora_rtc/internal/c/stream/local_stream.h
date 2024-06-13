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

typedef struct RteLocalStreamConfig {
  RteStreamConfig stream_config;
} RteLocalStreamConfig;

typedef struct RteLocalStreamStats {
  RteStreamStats stream_stats;
} RteLocalStreamStats;

typedef struct RteLocalStreamInfo {
  RteStreamInfo stream_info;
  bool has_subscribed;
} RteLocalStreamInfo;

AGORA_RTE_API_C void RteLocalStreamStatsInit(RteLocalStreamStats *stats,
                                            RteError *err);

AGORA_RTE_API_C void RteLocalStreamStatsDeinit(RteLocalStreamStats *stats,
                                              RteError *err);

#ifdef __cplusplus
}
#endif  // __cplusplus
