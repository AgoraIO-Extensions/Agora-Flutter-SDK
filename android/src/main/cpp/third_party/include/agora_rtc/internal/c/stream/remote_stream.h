/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include <stddef.h>

#include "c_error.h"
#include "../common.h"
#include "stream/stream.h"
#include "track/track.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef struct RteRemoteStreamConfig {
  RteStreamConfig stream_config;
} RteRemoteStreamConfig;

typedef struct RteRemoteStreamStats {
  RteStreamStats stream_stats;
} RteRemoteStreamStats;

typedef struct RteRemoteStreamInfo {
  RteStreamInfo stream_info;

  bool has_audio;
  bool has_video;
  bool has_data;
  RteTrackSrc audio_track_src;
  RteTrackSrc video_track_src;
  RteTrackSrc audio_track_src_original;
  RteTrackSrc video_track_src_original;
  RteString *data_track_topics;
  size_t data_track_topic_cnt;
} RteRemoteStreamInfo;

AGORA_RTE_API_C void RteRemoteStreamStatsInit(RteRemoteStreamStats *stats,
                                             RteError *err);
AGORA_RTE_API_C void RteRemoteStreamStatsDeinit(RteRemoteStreamStats *stats,
                                               RteError *err);

#ifdef __cplusplus
}
#endif  // __cplusplus
