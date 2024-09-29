/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include "rte_base/c/common.h"
#include "rte_base/c/stream/realtime_stream.h"
#include "rte_base/c/stream/remote_stream.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef struct Rte Rte;
typedef struct RteChannel RteChannel;

typedef struct RteRemoteRealTimeStreamConfig {
  RteRemoteStreamConfig remote_stream_config;
  RteRealTimeStreamConfig realtime_stream_config;
} RteRemoteRealTimeStreamConfig;

AGORA_RTE_API_C RteRemoteRealTimeStream RteRemoteRealTimeStreamCreate(
    Rte *rte, RteRemoteRealTimeStreamConfig *config, RteError *err);
AGORA_RTE_API_C void RteRemoteRealTimeStreamDestroy(
    RteRemoteRealTimeStream *self, RteError *err);

#ifdef __cplusplus
}
#endif  // __cplusplus
