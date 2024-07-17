/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include <stdint.h>

#include "../common.h"
#include "track/remote_track.h"
#include "utils/frame.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef struct RteRemoteAudioTrackConfig {
  RteRemoteTrackConfig remote_track_config;

  uint32_t playback_volume;
  bool has_playback_volume;
} RteRemoteAudioTrackConfig;

typedef struct RteRemoteAudioTrackObserver RteRemoteAudioTrackObserver;
struct RteRemoteAudioTrackObserver {
  RteRemoteTrackObserver remote_track_observer;

  void (*on_frame)(RteRemoteAudioTrackObserver *self,
                   RteAudioFrame *audio_frame);
};

typedef struct RteRemoteAudioTrackInfo {
  RteRemoteTrackInfo remote_track_info;
} RteRemoteAudioTrackInfo;

// @{
// Config
AGORA_RTE_API_C void RteRemoteAudioTrackConfigInit(
    RteRemoteAudioTrackConfig *config, RteError *err);
AGORA_RTE_API_C void RteRemoteAudioTrackConfigDeinit(
    RteRemoteAudioTrackConfig *config, RteError *err);

AGORA_RTE_API_C void RteRemoteAudioTrackConfigSetPlaybackVolume(
    RteRemoteAudioTrackConfig *self, uint32_t volume, RteError *err);
AGORA_RTE_API_C void RteRemoteAudioTrackConfigGetPlaybackVolume(
    RteRemoteAudioTrackConfig *self, uint32_t *volume, RteError *err);

AGORA_RTE_API_C void RteRemoteAudioTrackConfigSetJsonParameter(
    RteRemoteAudioTrackConfig *self, RteString *json_parameter, RteError *err);
AGORA_RTE_API_C void RteRemoteAudioTrackConfigGetJsonParameter(
    RteRemoteAudioTrackConfig *self, RteString *json_parameter, RteError *err);
// @}

// @{
// Track observer
AGORA_RTE_API_C RteRemoteAudioTrackObserver *RteRemoteAudioTrackObserverCreate(
    RteError *err);
AGORA_RTE_API_C void RteRemoteAudioTrackObserverDestroy(
    RteRemoteAudioTrackObserver *self, RteError *err);
//}

AGORA_RTE_API_C void RteRemoteAudioTrackInit(RteRemoteAudioTrack *self,
                                            RteError *err);
AGORA_RTE_API_C void RteRemoteAudioTrackDeinit(RteRemoteAudioTrack *self,
                                              RteError *err);

AGORA_RTE_API_C void RteRemoteAudioTrackGetConfigs(
    RteRemoteAudioTrack *self, RteRemoteAudioTrackConfig *config,
    RteError *err);
AGORA_RTE_API_C void RteRemoteAudioTrackSetConfigs(
    RteRemoteAudioTrack *self, RteRemoteAudioTrackConfig *config,
    void (*cb)(RteRemoteAudioTrack *track, void *cb_data, RteError *err),
    void *cb_data);

AGORA_RTE_API_C void RteRemoteAudioTrackRegisterTrackObserver(
    RteRemoteAudioTrack *self, RteRemoteAudioTrackObserver *observer,
    void (*destroyer)(RteRemoteAudioTrackObserver *self, RteError *err),
    RteError *err);
AGORA_RTE_API_C void RteRemoteAudioTrackUnregisterTrackObserver(
    RteRemoteAudioTrack *self, RteRemoteAudioTrackObserver *observer,
    RteError *err);

#ifdef __cplusplus
}
#endif  // __cplusplus
