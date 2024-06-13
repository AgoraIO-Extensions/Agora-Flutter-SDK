/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include <stddef.h>

#include "handle.h"
#include "observer.h"
#include "utils/string.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef struct Rte Rte;
typedef struct RteStream RteStream;
typedef struct RtePlayerInternal RtePlayerInternal;

typedef enum RtePlayerState {
  kRtePlayerStateIdle,
  kRtePlayerStateOpening,
  kRtePlayerStateOpenCompleted,
  kRtePlayerStatePlaying,
  kRtePlayerStatePaused,
  kRtePlayerStatePlaybackCompleted,
  kRtePlayerStateStopped,
  kRtePlayerStateFailed
} RtePlayerState;

typedef enum RtePlayerEvent {
  kRtePlayerEventSeekBegin,
  kRtePlayerEventSeekComplete,
  kRtePlayerEventSeekError,
  kRtePlayerEventBufferLow,
  kRtePlayerEventBufferRecover,
  kRtePlayerEventFreezeStart,
  kRtePlayerEventFreezeStop,
  kRtePlayerEventOneLoopPlaybackCompleted,
  kRtePlayerEventAuthenticationWillExpire
} RtePlayerEvent;

typedef struct RtePlayerInfo {
  RtePlayerState state;
  size_t duration;
  size_t stream_count;
  bool has_audio;
  bool has_video;
  bool is_audio_muted;
  bool is_video_muted;
  int video_height;
  int video_width;
  int audio_sample_rate;
  int audio_channels;
  int audio_bits_per_sample;
} RtePlayerInfo;


typedef struct RtePlayerStats {
    int video_decode_frame_rate;
    int video_render_frame_rate;
    int video_bitrate;

    int audio_bitrate;
} RtePlayerStats;

typedef struct RteMediaTrackInfo {
  void *placeholder;
} RteMediaTrackInfo;

typedef enum RtePlayerMetadataType {
  kRtePlayerMetadataTypeSei
} RtePlayerMetadataType;

typedef enum RteAudioDualMonoMode {
  RteAudioDualMonoStereo,
  RteAudioDualMonoLeft,
  RteAudioDualMonoRight,
  RteAudioDualMonoMix,
} RteAudioDualMonoMode;

typedef struct RtePlayerInitialConfig {
  bool enable_cache;
  bool _enable_cache_is_set;

  bool enable_multiple_audio_track;
  bool _enable_multiple_audio_track_is_set;

  bool is_agora_source;
  bool _is_agora_source_is_set;

  bool is_live_source;
  bool _is_live_source_is_set;
} RtePlayerInitialConfig;

typedef struct RtePlayerConfig {
  bool auto_play;
  bool _auto_play_is_set;

  int32_t speed;
  bool _speed_is_set;

  int32_t playout_audio_track_idx;
  bool _playout_audio_track_idx_is_set;

  int32_t publish_audio_track_idx;
  bool _publish_audio_track_idx_is_set;

  int32_t subtitle_track_idx;
  bool _subtitle_track_idx_is_set;

  int32_t external_subtitle_track_idx;
  bool _external_subtitle_track_idx_is_set;

  int32_t audio_pitch;
  bool _audio_pitch_is_set;

  int32_t playout_volume;
  bool _playout_volume_is_set;

  int32_t audio_playback_delay;
  bool _audio_playback_delay_is_set;

  RteAudioDualMonoMode audio_dual_mono_mode;
  bool _audio_dual_mono_mode_is_set;

  int32_t publish_volume;
  bool _publish_volume_is_set;

  int32_t loop_count;
  bool _loop_count_is_set;

  RteString *json_parameter;
  bool _json_parameter_is_set;
} RtePlayerConfig;

typedef struct RtePlayerCustomSourceProvider RtePlayerCustomSourceProvider;
struct RtePlayerCustomSourceProvider {
  void (*on_read_data)(RtePlayerCustomSourceProvider *self);
  void (*on_seek)(RtePlayerCustomSourceProvider *self);
};

typedef struct RtePlayerObserver RtePlayerObserver;
struct RtePlayerObserver {
  RteBaseObserver base_observer;

  void (*on_state_changed)(RtePlayerObserver *observer,
                           RtePlayerState old_state, RtePlayerState new_state,
                           RteError *err);
  void (*on_position_changed)(RtePlayerObserver *observer, uint64_t curr_time,
                              uint64_t utc_time);

  void (*on_resolution_changed)(RtePlayerObserver *observer, int width, int height);

  void (*on_event)(RtePlayerObserver *observer, RtePlayerEvent event);
  void (*on_metadata)(RtePlayerObserver *observer, RtePlayerMetadataType type,
                      const uint8_t *data, size_t length);

  void (*on_player_info_updated)(RtePlayerObserver *observer,
                                    const RtePlayerInfo *info);

  void (*on_audio_volume_indication)(RtePlayerObserver *observer,
                                         int32_t volume);
};

AGORA_RTE_API_C void RtePlayerInfoInit(RtePlayerInfo *info, RteError *err);
AGORA_RTE_API_C void RtePlayerInfoDeinit(RtePlayerInfo *info, RteError *err);

AGORA_RTE_API_C void RtePlayerStatsInit(RtePlayerStats *stats, RteError *err);
AGORA_RTE_API_C void RtePlayerStatsDeinit(RtePlayerStats *stats, RteError *err);

AGORA_RTE_API_C void RteMediaTrackInfoInit(RteMediaTrackInfo *info,
                                          RteError *err);
AGORA_RTE_API_C void RteMediaTrackInfoDeinit(RteMediaTrackInfo *info,
                                            RteError *err);

AGORA_RTE_API_C void RtePlayerInitialConfigInit(RtePlayerInitialConfig *config,
                                               RteError *err);

AGORA_RTE_API_C void RtePlayerInitialConfigDeinit(RtePlayerInitialConfig *config,
                                                 RteError *err);

AGORA_RTE_API_C void RtePlayerInitialConfigSetEnableCache(
    RtePlayerInitialConfig *config, bool enable_cache, RteError *err);

AGORA_RTE_API_C void RtePlayerInitialConfigGetEnableCache(
    RtePlayerInitialConfig *config, bool *enable_cache, RteError *err);

AGORA_RTE_API_C void RtePlayerInitialConfigSetEnableMultipleAudioTrack(
    RtePlayerInitialConfig *config, bool enable_multiple_audio_track,
    RteError *err);

AGORA_RTE_API_C void RtePlayerInitialConfigGetEnableMultipleAudioTrack(
    RtePlayerInitialConfig *config, bool *enable_multiple_audio_track,
    RteError *err);

AGORA_RTE_API_C void RtePlayerInitialConfigSetIsAgoraSource(
    RtePlayerInitialConfig *config, bool is_agora_source, RteError *err);

AGORA_RTE_API_C void RtePlayerInitialConfigGetIsAgoraSource(
    RtePlayerInitialConfig *config, bool *is_agora_source, RteError *err);

AGORA_RTE_API_C void RtePlayerInitialConfigSetIsLiveSource(
    RtePlayerInitialConfig *config, bool is_agora_source, RteError *err);

AGORA_RTE_API_C void RtePlayerInitialConfigGetIsLiveSource(
    RtePlayerInitialConfig *config, bool *is_agora_source, RteError *err);

AGORA_RTE_API_C void RtePlayerConfigInit(RtePlayerConfig *config, RteError *err);

AGORA_RTE_API_C void RtePlayerConfigDeinit(RtePlayerConfig *config,
                                          RteError *err);

AGORA_RTE_API_C void RtePlayerConfigCopy(RtePlayerConfig *dst,
                                        const RtePlayerConfig *src,
                                        RteError *err);

AGORA_RTE_API_C void RtePlayerConfigSetAutoPlay(RtePlayerConfig *config,
                                               bool auto_play, RteError *err);

AGORA_RTE_API_C void RtePlayerConfigGetAutoPlay(RtePlayerConfig *config,
                                               bool *auto_play, RteError *err);

AGORA_RTE_API_C void RtePlayerConfigSetPlaybackSpeed(RtePlayerConfig *config,
                                                    int32_t speed,
                                                    RteError *err);

AGORA_RTE_API_C void RtePlayerConfigGetPlaybackSpeed(RtePlayerConfig *config,
                                                    int32_t *speed,
                                                    RteError *err);

AGORA_RTE_API_C void RtePlayerConfigSetPlayoutAudioTrackIdx(
    RtePlayerConfig *config, int32_t idx, RteError *err);

AGORA_RTE_API_C void RtePlayerConfigGetPlayoutAudioTrackIdx(
    RtePlayerConfig *config, int32_t *idx, RteError *err);

AGORA_RTE_API_C void RtePlayerConfigSetPublishAudioTrackIdx(
    RtePlayerConfig *config, int32_t idx, RteError *err);

AGORA_RTE_API_C void RtePlayerConfigGetPublishAudioTrackIdx(
    RtePlayerConfig *config, int32_t *idx, RteError *err);

AGORA_RTE_API_C void RtePlayerConfigSetAudioTrackIdx(RtePlayerConfig *config,
                                                    int32_t idx, RteError *err);

AGORA_RTE_API_C void RtePlayerConfigGetAudioTrackIdx(RtePlayerConfig *config,
                                                    int32_t *idx,
                                                    RteError *err);

AGORA_RTE_API_C void RtePlayerConfigSetSubtitleTrackIdx(RtePlayerConfig *config,
                                                       int32_t idx,
                                                       RteError *err);

AGORA_RTE_API_C void RtePlayerConfigGetSubtitleTrackIdx(RtePlayerConfig *config,
                                                       int32_t *idx,
                                                       RteError *err);

AGORA_RTE_API_C void RtePlayerConfigSetExternalSubtitleTrackIdx(
    RtePlayerConfig *config, int32_t idx, RteError *err);

AGORA_RTE_API_C void RtePlayerConfigGetExternalSubtitleTrackIdx(
    RtePlayerConfig *config, int32_t *idx, RteError *err);

AGORA_RTE_API_C void RtePlayerConfigSetAudioPitch(RtePlayerConfig *config,
                                                 int32_t audio_pitch,
                                                 RteError *err);

AGORA_RTE_API_C void RtePlayerConfigGetAudioPitch(RtePlayerConfig *config,
                                                 int32_t *audio_pitch,
                                                 RteError *err);

AGORA_RTE_API_C void RtePlayerConfigSetPlayoutVolume(RtePlayerConfig *config,
                                                    int32_t volume,
                                                    RteError *err);

AGORA_RTE_API_C void RtePlayerConfigGetPlayoutVolume(RtePlayerConfig *config,
                                                    int32_t *volume,
                                                    RteError *err);

AGORA_RTE_API_C void RtePlayerConfigSetAudioPlaybackDelay(
    RtePlayerConfig *config, int32_t delay, RteError *err);

AGORA_RTE_API_C void RtePlayerConfigGetAudioPlaybackDelay(
    RtePlayerConfig *config, int32_t *delay, RteError *err);

AGORA_RTE_API_C void RtePlayerConfigSetAudioDualMonoMode(
    RtePlayerConfig *config, RteAudioDualMonoMode mode, RteError *err);

AGORA_RTE_API_C void RtePlayerConfigGetAudioDualMonoMode(
    RtePlayerConfig *config, RteAudioDualMonoMode *mode, RteError *err);

AGORA_RTE_API_C void RtePlayerConfigSetPublishVolume(RtePlayerConfig *config,
                                                    int32_t volume,
                                                    RteError *err);

AGORA_RTE_API_C void RtePlayerConfigGetPublishVolume(RtePlayerConfig *config,
                                                    int32_t *volume,
                                                    RteError *err);

AGORA_RTE_API_C void RtePlayerConfigSetLoopCount(RtePlayerConfig *config,
                                                int32_t loop_count,
                                                RteError *err);

AGORA_RTE_API_C void RtePlayerConfigGetLoopCount(RtePlayerConfig *config,
                                                int32_t *loop_count,
                                                RteError *err);

AGORA_RTE_API_C void RtePlayerConfigSetJsonParameter(RtePlayerConfig *config,
                                                    RteString *json_parameter,
                                                    RteError *err);

AGORA_RTE_API_C void RtePlayerConfigGetJsonParameter(RtePlayerConfig *config,
                                                    RteString *json_parameter,
                                                    RteError *err);

AGORA_RTE_API_C RtePlayer RtePlayerCreate(Rte *self, RtePlayerInitialConfig *config,
                                         RteError *err);
AGORA_RTE_API_C void RtePlayerDestroy(RtePlayer *self, RteError *err);

AGORA_RTE_API_C void RtePlayerPreloadWithUrl(RtePlayer *self, const char *url,
                                            RteError *err);

AGORA_RTE_API_C void RtePlayerOpenWithUrl(
    RtePlayer *self, const char *url, uint64_t start_time,
    void (*cb)(RtePlayer *self, void *cb_data, RteError *err), void *cb_data);

AGORA_RTE_API_C void RtePlayerOpenWithCustomSourceProvider(
    RtePlayer *self, RtePlayerCustomSourceProvider *provider,
    uint64_t start_time,
    void (*cb)(RtePlayer *self, void *cb_data, RteError *err), void *cb_data);

AGORA_RTE_API_C void RtePlayerOpenWithStream(RtePlayer *self, RteStream *stream,
                             void (*cb)(RtePlayer *self, void *cb_data,
                                        RteError *err),
                             void *cb_data);


AGORA_RTE_API_C void RtePlayerGetStats(RtePlayer *self, void (*cb)(RtePlayer *player, RtePlayerStats *stats, void *cb_data, RteError *err), void *cb_data);

AGORA_RTE_API_C void RtePlayerSetCanvas(RtePlayer *self, RteCanvas *canvas, RteError *err);

AGORA_RTE_API_C void RtePlayerPlay(RtePlayer *self, RteError *err);
AGORA_RTE_API_C void RtePlayerStop(RtePlayer *self, RteError *err);
AGORA_RTE_API_C void RtePlayerPause(RtePlayer *self, RteError *err);
AGORA_RTE_API_C void RtePlayerSeek(RtePlayer *self, uint64_t new_time,
                                  RteError *err);
                                  
AGORA_RTE_API_C void RtePlayerMuteAudio(RtePlayer *self, bool mute, RteError *err);
AGORA_RTE_API_C void RtePlayerMuteVideo(RtePlayer *self, bool mute, RteError *err);

AGORA_RTE_API_C uint64_t RtePlayerGetPosition(RtePlayer *self, RteError *err);
                                  
AGORA_RTE_API_C void RtePlayerGetInfo(RtePlayer *self, RtePlayerInfo *info, RteError *err);

AGORA_RTE_API_C void RtePlayerGetConfigs(RtePlayer *self,
                                        RtePlayerConfig *config, RteError *err);
AGORA_RTE_API_C void RtePlayerSetConfigs(
    RtePlayer *self, RtePlayerConfig *config,
    void (*cb)(RtePlayer *self, void *cb_data, RteError *err), void *cb_data);


AGORA_RTE_API_C bool RtePlayerRegisterObserver(
    RtePlayer *self, RtePlayerObserver *observer, RteError *err);
AGORA_RTE_API_C bool RtePlayerUnregisterObserver(RtePlayer *self,
                                                RtePlayerObserver *observer,
                                                RteError *err);

AGORA_RTE_API_C RtePlayerObserver *RtePlayerObserverCreate(RteError *err);
AGORA_RTE_API_C void RtePlayerObserverDestroy(RtePlayerObserver *observer,
                                             RteError *err);
AGORA_RTE_API_C RtePlayer
RtePlayerObserverGetEventSrc(RtePlayerObserver *observer, RteError *err);

AGORA_RTE_API_C RtePlayerCustomSourceProvider
RtePlayerCustomSourceProviderCreate(Rte *self, RteError *err);

AGORA_RTE_API_C void RtePlayerCustomSourceProviderDestroy(
    RtePlayerCustomSourceProvider *self, RteError *err);

#ifdef __cplusplus
}
#endif  // __cplusplus
