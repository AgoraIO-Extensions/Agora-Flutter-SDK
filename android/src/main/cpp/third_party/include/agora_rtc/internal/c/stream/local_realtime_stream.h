/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include "../common.h"
#include "stream/local_stream.h"
#include "stream/realtime_stream.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef struct Rte Rte;
typedef struct RteChannel RteChannel;

typedef struct RteLocalRealTimeStreamConfig {
  RteRealTimeStreamConfig realtime_stream_config;
  RteLocalStreamConfig local_stream_config;
} RteLocalRealTimeStreamConfig;

AGORA_RTE_API_C RteLocalRealTimeStream RteLocalRealTimeStreamCreate(
    Rte *rte, RteLocalRealTimeStreamConfig *config, RteError *err);

AGORA_RTE_API_C void RteLocalRealTimeStreamDestroy(RteLocalRealTimeStream *self,
                                                  RteError *err);

#ifdef __cplusplus
}
#endif  // __cplusplus
