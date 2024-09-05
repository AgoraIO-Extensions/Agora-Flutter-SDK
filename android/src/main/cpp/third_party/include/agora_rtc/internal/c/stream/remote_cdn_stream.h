/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include "../common.h"
#include "stream/cdn_stream.h"
#include "stream/remote_stream.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef struct RteUser RteUser;
typedef struct RteTrack RteTrack;

typedef struct RteRemoteCdnStreamConfig {
  RteRemoteStreamConfig remote_stream_config;
  RteCdnStreamConfig cdn_stream_config;
} RteRemoteCdnStreamConfig;

AGORA_RTE_API_C void RteRemoteCdnStreamConfigInit(
    RteRemoteCdnStreamConfig *config, RteError *err);
AGORA_RTE_API_C void RteRemoteCdnStreamConfigDeinit(
    RteRemoteCdnStreamConfig *config, RteError *err);

AGORA_RTE_API_C void RteRemoteCdnStreamConfigSetUrl(
    RteRemoteCdnStreamConfig *self, RteString *url, RteError *err);
AGORA_RTE_API_C void RteRemoteCdnStreamConfigGetUrl(
    RteRemoteCdnStreamConfig *self, RteString *url, RteError *err);

AGORA_RTE_API_C void RteRemoteCdnStreamConfigSetJsonParameter(
    RteRemoteCdnStreamConfig *self, RteString *json_parameter, RteError *err);
AGORA_RTE_API_C void RteRemoteCdnStreamConfigGetJsonParameter(
    RteRemoteCdnStreamConfig *self, RteString *json_parameter, RteError *err);

AGORA_RTE_API_C RteRemoteCdnStream RteRemoteCdnStreamCreate(Rte *self,
                                                           RteError *err);
AGORA_RTE_API_C void RteRemoteCdnStreamDestroy(RteRemoteCdnStream *self,
                                              RteError *err);

AGORA_RTE_API_C void RteRemoteCdnStreamGetConfigs(
    RteRemoteCdnStream *self, RteRemoteCdnStreamConfig *config, RteError *err);
AGORA_RTE_API_C void RteRemoteCdnStreamSetConfigs(
    RteRemoteCdnStream *self, RteRemoteCdnStreamConfig *config,
    void (*cb)(RteRemoteCdnStream *stream, void *cb_data, RteError *err),
    void *cb_data);

#ifdef __cplusplus
}
#endif  // __cplusplus
