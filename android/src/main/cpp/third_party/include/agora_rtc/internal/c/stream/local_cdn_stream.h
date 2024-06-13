/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include "../common.h"
#include "stream/cdn_stream.h"
#include "stream/local_stream.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef struct RteUser RteUser;
typedef struct RteTrack RteTrack;
typedef struct Rte Rte;
typedef struct RteChannel RteChannel;

typedef struct RteLocalCdnStreamConfig {
  RteCdnStreamConfig cdn_stream_config;
  RteLocalStreamConfig local_stream_config;
} RteLocalCdnStreamConfig;

AGORA_RTE_API_C void RteLocalCdnStreamConfigInit(RteLocalCdnStreamConfig *config,
                                                RteError *err);
AGORA_RTE_API_C void RteLocalCdnStreamConfigDeinit(
    RteLocalCdnStreamConfig *config, RteError *err);

AGORA_RTE_API_C void RteLocalCdnStreamConfigSetUrl(RteLocalCdnStreamConfig *self,
                                                  RteString *url,
                                                  RteError *err);
AGORA_RTE_API_C void RteLocalCdnStreamConfigGetUrl(RteLocalCdnStreamConfig *self,
                                                  RteString *url,
                                                  RteError *err);

AGORA_RTE_API_C void RteLocalCdnStreamConfigSetJsonParameter(
    RteLocalCdnStreamConfig *self, RteString *json_parameter, RteError *err);
AGORA_RTE_API_C void RteLocalCdnStreamConfigGetJsonParameter(
    RteLocalCdnStreamConfig *self, RteString *json_parameter, RteError *err);

AGORA_RTE_API_C RteLocalCdnStream RteLocalCdnStreamCreate(
    Rte *rte, RteLocalCdnStreamConfig *config, RteError *err);
AGORA_RTE_API_C void RteLocalCdnStreamDestroy(RteLocalCdnStream *self,
                                             RteError *err);

AGORA_RTE_API_C void RteLocalCdnStreamGetConfigs(RteLocalCdnStream *self,
                                                RteLocalCdnStreamConfig *config,
                                                RteError *err);
AGORA_RTE_API_C void RteLocalCdnStreamSetConfigs(
    RteLocalCdnStream *self, RteLocalCdnStreamConfig *config,
    void (*cb)(RteLocalCdnStream *stream, void *cb_data, RteError *err),
    void *cb_data);

#ifdef __cplusplus
}
#endif  // __cplusplus
