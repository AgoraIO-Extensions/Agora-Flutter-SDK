/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include "../common.h"
#include "track/local_track.h"
#include "utils/frame.h"
#include "utils/string.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef struct RteLocalAudioTrackConfig {
  RteLocalTrackConfig local_track_config;
} RteLocalAudioTrackConfig;

typedef struct RteLocalAudioTrackObserver RteLocalAudioTrackObserver;
struct RteLocalAudioTrackObserver {
  RteLocalTrackObserver local_track_observer;

  void (*on_frame)(RteLocalAudioTrackObserver *self,
                   RteAudioFrame *audio_frame);
};

typedef struct RteLocalAudioTrackInfo {
  RteLocalTrackInfo local_track_info;
} RteLocalAudioTrackInfo;

// @{
// Config
AGORA_RTE_API_C void RteLocalAudioTrackConfigInit(
    RteLocalAudioTrackConfig *config, RteError *err);
AGORA_RTE_API_C void RteLocalAudioTrackConfigDeinit(
    RteLocalAudioTrackConfig *config, RteError *err);

AGORA_RTE_API_C void RteLocalAudioTrackConfigSetPublishVolume(
    RteLocalAudioTrackConfig *self, uint32_t volume, RteError *err);
AGORA_RTE_API_C void RteLocalAudioTrackConfigGetPublishVolume(
    RteLocalAudioTrackConfig *self, uint32_t *volume, RteError *err);

AGORA_RTE_API_C void RteLocalAudioTrackConfigSetLoopbackVolume(
    RteLocalAudioTrackConfig *self, uint32_t volume, RteError *err);
AGORA_RTE_API_C void RteLocalAudioTrackConfigGetLoopbackVolume(
    RteLocalAudioTrackConfig *self, uint32_t *volume, RteError *err);

AGORA_RTE_API_C void RteLocalAudioTrackConfigSetEnableLoopbackFilter(
    RteLocalAudioTrackConfig *self, bool enable_loopback_filter, RteError *err);
AGORA_RTE_API_C void RteLocalAudioTrackConfigGetEnableLoopbackFilter(
    RteLocalAudioTrackConfig *self, bool *enable_loopback_filter,
    RteError *err);

AGORA_RTE_API_C void RteLocalAudioTrackConfigSetEnablePublishFilter(
    RteLocalAudioTrackConfig *self, bool enable_publish_filter, RteError *err);
AGORA_RTE_API_C void RteLocalAudioTrackConfigGetEnablePublishFilter(
    RteLocalAudioTrackConfig *self, bool *enable_publish_filter, RteError *err);

AGORA_RTE_API_C void RteLocalAudioTrackConfigSetJsonParameter(
    RteLocalAudioTrackConfig *self, RteString *json_parameter, RteError *err);
AGORA_RTE_API_C void RteLocalAudioTrackConfigGetJsonParameter(
    RteLocalAudioTrackConfig *self, RteString *json_parameter, RteError *err);
// @}

// @{
// Track observer
AGORA_RTE_API_C RteLocalAudioTrackObserver *RteLocalAudioTrackObserverCreate(
    RteError *err);
AGORA_RTE_API_C void RteLocalAudioTrackObserverDestroy(
    RteLocalAudioTrackObserver *self, RteError *err);
//}

AGORA_RTE_API_C void RteLocalAudioTrackInit(RteLocalAudioTrack *self,
                                           RteError *err);
AGORA_RTE_API_C void RteLocalAudioTrackDeinit(RteLocalAudioTrack *self,
                                             RteError *err);

AGORA_RTE_API_C void RteLocalAudioTrackGetConfigs(
    RteLocalAudioTrack *self, RteLocalAudioTrackConfig *config, RteError *err);
AGORA_RTE_API_C void RteLocalAudioTrackSetConfigs(
    RteLocalAudioTrack *self, RteLocalAudioTrackConfig *config,
    void (*cb)(RteLocalAudioTrack *track, void *cb_data, RteError *err),
    void *cb_data);

AGORA_RTE_API_C void RteLocalAudioTrackEnableLoopback(RteLocalAudioTrack *self,
                                                     RteError *err);

AGORA_RTE_API_C void RteLocalAudioTrackRegisterTrackObserver(
    RteLocalAudioTrack *self, RteLocalAudioTrackObserver *observer,
    void (*destroyer)(RteLocalAudioTrackObserver *self, RteError *err),
    RteError *err);
AGORA_RTE_API_C void RteLocalAudioTrackUnregisterTrackObserver(
    RteLocalAudioTrack *self, RteLocalAudioTrackObserver *observer,
    RteError *err);

#ifdef __cplusplus
}
#endif  // __cplusplus
