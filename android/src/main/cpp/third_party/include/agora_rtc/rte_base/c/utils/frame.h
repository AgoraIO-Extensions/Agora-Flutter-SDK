/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include <stddef.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef enum RteAudioFrameType {
  kRteAudioFrameTypePcm16,
} RteAudioFrameType;

typedef struct RteAudioFrame {
  RteAudioFrameType type;
  int samples_per_channel;
  int bytes_per_sample;
  int channels;
  int samples_per_sec;
  void *buffer;
  int64_t render_time_in_ms;
  int avsync_type;
  int64_t presentation_in_ms;
  size_t audio_track_number;
} RteAudioFrame;

#ifdef __cplusplus
}
#endif  // __cplusplus
