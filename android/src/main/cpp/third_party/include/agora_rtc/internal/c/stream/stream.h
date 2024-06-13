/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include <stdbool.h>

#include "c_error.h"
#include "handle.h"
#include "observer.h"
#include "../common.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef struct RteChannel RteChannel;
typedef struct Rte Rte;
typedef struct RteStream RteStream;

typedef struct RteStreamObserver RteStreamObserver;
struct RteStreamObserver {
  RteBaseObserver base_observer;
};

typedef enum RteStreamType {
  kRteStreamTypeRealTime,
  kRteStreamTypeCdn,
} RteStreamType;

typedef enum RteEncryptionMode {
  kRteEncryptionModeAes128Xts,
  kRteEncryptionModeAes128Ecb,
  kRteEncryptionModeAes128Gcm,
  kRteEncryptionModeAes128Gcm2,
  kRteEncryptionModeAes256Xts,
  kRteEncryptionModeAes256Gcm,
  kRteEncryptionModeAes256Gcm2,
  kRteEncryptionModeSm4128Ecb,
} RteEncryptionMode;

typedef enum RteAudioEncoderProfile {
  kRteAudioEncoderProfileDefault,
  kRteAudioEncoderProfileStdSpeech,
  kRteAudioEncoderProfileStdMusic,
  kRteAudioEncoderProfileStdStereoMusic,
  kRteAudioEncoderProfileHighQualityMusic,
  kRteAudioEncoderProfileHighQualityStereoMusic,
  kRteAudioEncoderProfileIot,
} RteAudioEncoderProfile;

typedef enum RteOrientationMode {
  kRteOrientationModeAdaptive,
  kRteOrientationModeFixedLandscape,
  kRteOrientationModeFixedPortrait,
} RteOrientationMode;

typedef enum RteVideoDegradationPreference {
  kRteVideoDegradationPreferenceMaintainFramerate,
  kRteVideoDegradationPreferenceMaintainBalanced,
  kRteVideoDegradationPreferenceMaintainResolution,
  kRteVideoDegradationPreferenceDisabled,
} RteVideoDegradationPreference;

typedef enum RteVideoMirrorMode {
  kRteVideoMirrorModeAuto,
  kRteVideoMirrorModeEnabled,
  kRteVideoMirrorModeDisabled,
} RteVideoMirrorMode;

typedef struct RteStreamConfig {
  RteStreamType type;
  bool has_type;

  RteString *stream_id;
  bool has_stream_id;

  RteEncryptionMode encryption_mode;
  bool has_encryption_mode;

  RteString *encryption_key;
  bool has_encryption_key;

  uint8_t encryption_kdf_salt[32];
  bool has_encryption_kdf_salt;

  RteAudioEncoderProfile audio_encoder_profile;
  bool has_audio_encoder_profile;

  uint32_t width;
  bool has_width;

  uint32_t height;
  bool has_height;

  uint32_t frame_rate;
  bool has_frame_rate;

  uint32_t min_bitrate;
  bool has_min_bitrate;

  RteOrientationMode orientation_mode;
  bool has_orientation_mode;

  RteVideoDegradationPreference degradation_preference;
  bool has_degradation_preference;

  RteVideoMirrorMode mirror_mode;
  bool has_mirror_mode;

  bool che_hw_decoding;
  bool has_che_hw_decoding;

  RteString *json_parameter;
  bool has_json_parameter;
} RteStreamConfig;

typedef struct RteStreamStats {
  int placeholder;
} RteStreamStats;

typedef struct RteStreamInfo {
  RteChannel channel;
  Rte rte;
} RteStreamInfo;

typedef struct RteStream {
  RteHandle handle;
} RteStream;

// @{
// Observer
AGORA_RTE_API_C RteStreamObserver *RteStreamObserverCreate(RteError *err);
AGORA_RTE_API_C void RteStreamObserverDestroy(RteStreamObserver *observer,
                                             RteError *err);
// @}

// @{
// Config
AGORA_RTE_API_C void RteStreamConfigInit(RteStreamConfig *config, RteError *err);
AGORA_RTE_API_C void RteStreamConfigDeinit(RteStreamConfig *config,
                                          RteError *err);

AGORA_RTE_API_C void RteStreamConfigSetChannel(RteStreamConfig *self,
                                              RteChannel *channel,
                                              RteError *err);

AGORA_RTE_API_C void RteStreamConfigSetStreamType(RteStreamConfig *self,
                                                 RteStreamType type,
                                                 RteError *err);
AGORA_RTE_API_C void RteStreamConfigGetStreamType(RteStreamConfig *self,
                                                 RteStreamType *type,
                                                 RteError *err);

AGORA_RTE_API_C void RteStreamConfigSetStreamId(RteStreamConfig *self,
                                               RteString *stream_id,
                                               RteError *err);
AGORA_RTE_API_C void RteStreamConfigGetStreamId(RteStreamConfig *self,
                                               RteString *stream_id,
                                               RteError *err);

AGORA_RTE_API_C void RteStreamConfigSetEncryptionMode(RteStreamConfig *self,
                                                     RteEncryptionMode mode,
                                                     RteError *err);
AGORA_RTE_API_C void RteStreamConfigGetEncryptionMode(RteStreamConfig *self,
                                                     RteEncryptionMode *mode,
                                                     RteError *err);

AGORA_RTE_API_C void RteStreamConfigSetEncryptionKey(RteStreamConfig *self,
                                                    RteString *encryption_key,
                                                    RteError *err);
AGORA_RTE_API_C void RteStreamConfigGetEncryptionKey(RteStreamConfig *self,
                                                    RteString *encryption_key,
                                                    RteError *err);

AGORA_RTE_API_C void RteStreamConfigSetEncryptionKdfSalt(
    RteStreamConfig *self, uint8_t *encryption_kdf_salt, RteError *err);
AGORA_RTE_API_C void RteStreamConfigGetEncryptionKdfSalt(
    RteStreamConfig *self, uint8_t *encryption_kdf_salt, RteError *err);

AGORA_RTE_API_C void RteStreamConfigSetAudioEncoderProfile(
    RteStreamConfig *self, RteAudioEncoderProfile profile, RteError *err);
AGORA_RTE_API_C void RteStreamConfigGetAudioEncoderProfile(
    RteStreamConfig *self, RteAudioEncoderProfile *profile, RteError *err);

AGORA_RTE_API_C void RteStreamConfigSetWidth(RteStreamConfig *self,
                                            uint32_t width, RteError *err);
AGORA_RTE_API_C void RteStreamConfigGetWidth(RteStreamConfig *self,
                                            uint32_t *width, RteError *err);
AGORA_RTE_API_C void RteStreamConfigSetHeight(RteStreamConfig *self,
                                             uint32_t height, RteError *err);
AGORA_RTE_API_C void RteStreamConfigGetHeight(RteStreamConfig *self,
                                             uint32_t *height, RteError *err);

AGORA_RTE_API_C void RteStreamConfigSetFrameRate(RteStreamConfig *self,
                                                uint32_t frame_rate,
                                                RteError *err);
AGORA_RTE_API_C void RteStreamConfigGetFrameRate(RteStreamConfig *self,
                                                uint32_t *frame_rate,
                                                RteError *err);

AGORA_RTE_API_C void RteStreamConfigSetMinBitRate(RteStreamConfig *self,
                                                 uint32_t min_bitrate,
                                                 RteError *err);
AGORA_RTE_API_C void RteStreamConfigGetMinBitRate(RteStreamConfig *self,
                                                 uint32_t *min_bitrate,
                                                 RteError *err);

AGORA_RTE_API_C void RteStreamConfigSetOrientationMode(
    RteStreamConfig *self, RteOrientationMode orientation_mode, RteError *err);
AGORA_RTE_API_C void RteStreamConfigGetOrientationMode(
    RteStreamConfig *self, RteOrientationMode *orientation_mode, RteError *err);

AGORA_RTE_API_C void RteStreamConfigSetVideoDegradationPreference(
    RteStreamConfig *self, RteVideoDegradationPreference degradation_preference,
    RteError *err);
AGORA_RTE_API_C void RteStreamConfigGetVideoDegradationPreference(
    RteStreamConfig *self,
    RteVideoDegradationPreference *degradation_preference, RteError *err);

AGORA_RTE_API_C void RteStreamConfigSetVideoMirrorMode(
    RteStreamConfig *self, RteVideoMirrorMode mirror_mode, RteError *err);
AGORA_RTE_API_C void RteStreamConfigGetVideoMirrorMode(
    RteStreamConfig *self, RteVideoMirrorMode *mirror_mode, RteError *err);

AGORA_RTE_API_C void RteStreamConfigSetCheHwDecoding(RteStreamConfig *self,
                                                    bool che_hw_decoding,
                                                    RteError *err);
AGORA_RTE_API_C void RteStreamConfigGetCheHwDecoding(RteStreamConfig *self,
                                                    bool *che_hw_decoding,
                                                    RteError *err);

AGORA_RTE_API_C void RteStreamConfigSetJsonParameter(RteStreamConfig *self,
                                                    RteString *json_parameter,
                                                    RteError *err);
AGORA_RTE_API_C void RteStreamConfigGetJsonParameter(RteStreamConfig *self,
                                                    RteString *json_parameter,
                                                    RteError *err);
// @}

// @{
// Info
AGORA_RTE_API_C void RteStreamInfoInit(RteStreamInfo *info, RteError *err);
AGORA_RTE_API_C void RteStreamInfoDeinit(RteStreamInfo *info, RteError *err);
// @}

AGORA_RTE_API_C void RteStreamGetInfo(RteStream *self, RteStreamInfo *info,
                                     RteError *err);

AGORA_RTE_API_C void RteStreamSetConfigs(
    RteStream *self, RteStreamConfig *config,
    void (*cb)(RteStream *stream, void *cb_data, RteError *err), void *cb_data);

AGORA_RTE_API_C bool RteStreamRegisterObserver(
    RteStream *self, RteStreamObserver *observer, RteError *err);

AGORA_RTE_API_C RteAudioTrack RteStreamGetAudioTrack(RteStream *self,
                                                    RteError *err);
AGORA_RTE_API_C void RteStreamAddAudioTrack(RteStream *self,
                                           RteAudioTrack *audio_track,
                                           RteError *err);
AGORA_RTE_API_C void RteStreamDelAudioTrack(RteStream *self,
                                           RteAudioTrack *audio_track,
                                           RteError *err);

AGORA_RTE_API_C RteVideoTrack RteStreamGetVideoTrack(RteStream *self,
                                                    RteError *err);
AGORA_RTE_API_C void RteStreamAddVideoTrack(RteStream *self,
                                           RteVideoTrack *video_track,
                                           RteError *err);
AGORA_RTE_API_C void RteStreamDelVideoTrack(RteStream *self,
                                           RteVideoTrack *video_track,
                                           RteError *err);

AGORA_RTE_API_C RteDataTrack RteStreamGetDataTrack(RteStream *self,
                                                  RteError *err);
AGORA_RTE_API_C void RteStreamAddDataTrack(RteStream *self,
                                          RteDataTrack *data_track,
                                          RteError *err);
AGORA_RTE_API_C void RteStreamDelDataTrack(RteStream *self,
                                          RteDataTrack *data_track,
                                          RteError *err);

#ifdef __cplusplus
}
#endif  // __cplusplus
