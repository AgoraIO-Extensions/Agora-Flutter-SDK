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

typedef struct RteCdnStreamConfig {
  RteStreamConfig stream_config;
} RteCdnStreamConfig;

typedef struct RteCdnStreamStats {
  RteStreamStats stream_stats;
} RteCdnStreamStats;

typedef struct RteCdnStreamInfo {
  RteStreamInfo stream_info;
} RteCdnStreamInfo;

AGORA_RTE_API_C void RteCdnStreamStatsInit(RteCdnStreamStats *stats,
                                          RteError *err);
AGORA_RTE_API_C void RteCdnStreamStatsDeinit(RteCdnStreamStats *stats,
                                            RteError *err);

#ifdef __cplusplus
}
#endif  // __cplusplus
