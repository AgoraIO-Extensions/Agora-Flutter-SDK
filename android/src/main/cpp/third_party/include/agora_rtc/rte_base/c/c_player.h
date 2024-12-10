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

/**
 * Player states.
 * When the player state changes, the state will be notified through the PlayerObserver::onStateChanged callback interface.
 * @since v4.4.0
 */
typedef enum RtePlayerState {
  /**
   * 0: Idle state.
   */
  kRtePlayerStateIdle,
  /**
   * 1: Opening state. This state is notified after calling rte::Player::OpenWithUrl().
   */
  kRtePlayerStateOpening,
  /**
   * 2: Open completed state. This state is notified after successfully calling rte::Player::OpenWithUrl().
   */
  kRtePlayerStateOpenCompleted,
  /**
   * 3: Playing state. This state is notified when audience members successfully subscribe to the broadcaster after opening an RTE URL.
   */
  kRtePlayerStatePlaying,
  /**
   * 4: Paused state. This state is notified when playback is paused.
   */
  kRtePlayerStatePaused,
  /**
   * 5: Playback completed state. This state is notified when the broadcaster stops streaming and leaves the live streaming room after playing the rte URL.
   */
  kRtePlayerStatePlaybackCompleted,
  /**
   * 6: Stopped state. This state is entered after the user calls Player::stop.
   */
  kRtePlayerStateStopped,
  /**
   * 7: Failed state. This state is entered when an internal error occurs.
   */
  kRtePlayerStateFailed
} RtePlayerState;

/**
 * Player events.
 * When an event occurs, it will be notified through the PlayerObserver::onEvent callback interface.
 * @since v4.4.0
 */
typedef enum RtePlayerEvent {
  /**
   * 0: Start seeking to a specified position for playback.
   */
  kRtePlayerEventSeekBegin,
  /**
   * 1: Seeking completes.
   */
  kRtePlayerEventSeekComplete,
  /**
   * 2: An error occurs when seeking to a new playback position.
   */
  kRtePlayerEventSeekError,
  /**
   * 3: The currently buffered data is not enough to support playback.
   */
  kRtePlayerEventBufferLow,
  /**
   * 4: The currently buffered data is just enough to support playback.
   */
  kRtePlayerEventBufferRecover,
  /**
   * 5: Audio or video playback starts freezing.
   */
  kRtePlayerEventFreezeStart,
  /**
   * 6: The audio or video playback resumes without freezing.
   */
  kRtePlayerEventFreezeStop,
  /**
   * 7: One loop playback completed.
   */
  kRtePlayerEventOneLoopPlaybackCompleted,
  /**
   * 8: URL authentication will expire.
   */
  kRtePlayerEventAuthenticationWillExpire,
  /**
   * 9: When the fallback option is enabled, ABR revert to the audio-only layer due to poor network.
   */
  kRtePlayerEventAbrFallbackToAudioOnlyLayer,
  /**
   * 10: ABR recovers from audio-only layer to video layer when fallback option is enabled.
   */
  kRtePlayerEventAbrRecoverFromAudioOnlyLayer
} RtePlayerEvent;

/**
 * ABR subscription layer.
 * This enumeration can be used to set the value of the abr_subscription_layer query parameter in the rte URL. 
 * It can also be used in the PlayerConfig::SetAbrSubscriptionLayer setting interface.
 * @since v4.4.0
 */
typedef enum RteAbrSubscriptionLayer {
  /**
   * 0: High-quality video stream, this layer has the highest resolution and bitrate.
   */
  kRteAbrSubscriptionHigh = 0,
  /**
   * 1: Low-quality video stream, this layer has the lowest resolution and bitrate.
   */
  kRteAbrSubscriptionLow = 1,
  /**
   * 2: Layer1 video stream, this layer has lower resolution and bitrate than that of the high-quality video stream.
   */
  kRteAbrSubscriptionLayer1 = 2,
  /**
   * 3: Layer2 video stream, this layer has lower resolution and bitrate than layer1.
   */
  kRteAbrSubscriptionLayer2 = 3,
  /**
   * 4: Layer3 video stream, this layer has lower resolution and bitrate than layer2.
   */
  kRteAbrSubscriptionLayer3 = 4,
  /**
   * 5: Layer4 video stream, this layer has lower resolution and bitrate than layer3.
   */
  kRteAbrSubscriptionLayer4 = 5,
  /**
   * 6: Layer5 video stream, this layer has lower resolution and bitrate than layer4.
   */
  kRteAbrSubscriptionLayer5 = 6,
  /**
   * 7: Layer6 video stream, this layer has lower resolution and bitrate than layer5.
   */
  kRteAbrSubscriptionLayer6 = 7,
} RteAbrSubscriptionLayer;


/**
 * ABR fallback layer.
 * This enumeration can be used to set the value of the abr_fallback_layer query parameter in the rte URL. 
 * It can also be used in the PlayerConfig::SetAbrFallbackLayer setting interface.
 * @since v4.4.0
 */
typedef enum RteAbrFallbackLayer {
  /**
   * 0: When the network quality is poor, it will not revert to a lower resolution stream. 
   * It may still revert to scalable video coding but will maintain the high-quality video resolution.
   */
  kRteAbrFallbackDisabled = 0,
  /**
   * 1: (Default) In a poor network environment, the receiver's SDK will receive the kRteAbrSubscriptionLow layer video stream.
   */
  kRteAbrFallbackLow = 1,
  /**
   * 2: In a poor network environment, the SDK may first receive the kRteAbrSubscriptionLow layer, 
   * and if the relevant layer exists, it will revert to kRteAbrSubscriptionLayer1 to kRteAbrSubscriptionLayer6. 
   * If the network environment is too poor to play video, the SDK will only receive audio.
   */
  kRteAbrFallbackAudioOnly = 2,
  /**
   * 3~8: If the receiving end sets the fallback option, the SDK will receive one of the layers from kRteAbrSubscriptionLayer1 to kRteAbrSubscriptionLayer6. 
   * The lower boundary of the fallback video stream is determined by the configured fallback option.
   */
  kRteAbrFallbackLayer1 = 3,
  kRteAbrFallbackLayer2 = 4,
  kRteAbrFallbackLayer3 = 5,
  kRteAbrFallbackLayer4 = 6,
  kRteAbrFallbackLayer5 = 7,
  kRteAbrFallbackLayer6 = 8,
} RteAbrFallbackLayer;

/**
 * Player information.
 * When playerInfo changes, it will be notified through the PlayerObserver::onPlayerInfoUpdated callback interface. 
 * It can also be actively obtained through the Player::GetInfo interface.
 * @since v4.4.0
 */
typedef struct RtePlayerInfo {
  /** 
   * Current player state
   */
  RtePlayerState state;
  /** 
   * Reserved parameter.
   */
  size_t duration;
  /** 
   * Reserved parameter.
   */
  size_t stream_count;
  /** 
   * Whether there is an audio stream. When opening an rte URL, it indicates whether the broadcaster has pushed audio.
   */
  bool has_audio;
  /** 
   * Whether there is a video stream. When opening an rte URL, it indicates whether the broadcaster has pushed video.
   */
  bool has_video;
  /** 
   * Whether the audio is muted. Indicates whether the audience has subscribed to the audio stream.
   */
  bool is_audio_muted;
  /** 
   * Whether the video is muted. Indicates whether the audience has subscribed to the video stream.
   */
  bool is_video_muted;
  /** 
   * Video resolution height
   */
  int video_height;
  /** 
   * Video resolution width
   */
  int video_width;
  /** 
   * The currently subscribed video layer
   */
  RteAbrSubscriptionLayer abr_subscription_layer;
  /** 
   * Audio sample rate
   */
  int audio_sample_rate;
  /** 
   * Number of audio channels
   */
  int audio_channels;
  /** 
   * Reserved parameter.
   */
  int audio_bits_per_sample;
} RtePlayerInfo;

/**
 * Player statistics.
 * Can be actively obtained through the Player::GetStats interface.
 * @since v4.4.0
 */
typedef struct RtePlayerStats {
  /**
   * Decoding frame rate
   */
  int video_decode_frame_rate;
  /**
   * Rendering frame rate
   */
  int video_render_frame_rate;
  /**
   * Video bitrate
   */
  int video_bitrate;

  /**
   * Audio bitrate
   */
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

  // live player options
  RteAbrSubscriptionLayer abr_subscription_layer;
  bool _abr_subscription_layer_is_set;

  RteAbrFallbackLayer abr_fallback_layer;
  bool _abr_fallback_layer_is_set;

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

AGORA_RTE_API_C void RtePlayerConfigSetAbrSubscriptionLayer(RtePlayerConfig *config,
                                                            RteAbrSubscriptionLayer abr_subscription_layer,
                                                            RteError *err);     

AGORA_RTE_API_C void RtePlayerConfigGetAbrSubscriptionLayer(RtePlayerConfig *config,
                                                            RteAbrSubscriptionLayer *abr_subscription_layer,
                                                            RteError *err); 

AGORA_RTE_API_C void RtePlayerConfigSetAbrFallbackLayer(RtePlayerConfig *config,
                                                        RteAbrFallbackLayer abr_fallback_layer,
                                                        RteError *err); 

AGORA_RTE_API_C void RtePlayerConfigGetAbrFallbackLayer(RtePlayerConfig *config,                                            
                                                        RteAbrFallbackLayer *abr_fallback_layer,
                                                        RteError *err);

AGORA_RTE_API_C RtePlayer RtePlayerCreate(Rte *self, RtePlayerInitialConfig *config,
                                         RteError *err);
AGORA_RTE_API_C void RtePlayerDestroy(RtePlayer *self, RteError *err);

AGORA_RTE_API_C bool RtePlayerPreloadWithUrl(RtePlayer *self, const char *url,
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

AGORA_RTE_API_C bool RtePlayerSetCanvas(RtePlayer *self, RteCanvas *canvas, RteError *err);

AGORA_RTE_API_C bool RtePlayerPlay(RtePlayer *self, RteError *err);
AGORA_RTE_API_C bool RtePlayerStop(RtePlayer *self, RteError *err);
AGORA_RTE_API_C bool RtePlayerPause(RtePlayer *self, RteError *err);
AGORA_RTE_API_C bool RtePlayerSeek(RtePlayer *self, uint64_t new_time,
                                  RteError *err);
                                  
AGORA_RTE_API_C bool RtePlayerMuteAudio(RtePlayer *self, bool mute, RteError *err);
AGORA_RTE_API_C bool RtePlayerMuteVideo(RtePlayer *self, bool mute, RteError *err);

AGORA_RTE_API_C uint64_t RtePlayerGetPosition(RtePlayer *self, RteError *err);
                                  
AGORA_RTE_API_C bool RtePlayerGetInfo(RtePlayer *self, RtePlayerInfo *info, RteError *err);

AGORA_RTE_API_C bool RtePlayerGetConfigs(RtePlayer *self,
                                        RtePlayerConfig *config, RteError *err);
AGORA_RTE_API_C bool RtePlayerSetConfigs(RtePlayer *self, RtePlayerConfig *config, RteError *err);


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
