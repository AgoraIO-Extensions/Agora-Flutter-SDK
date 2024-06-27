/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include "handle.h"
#include "../common.h"
#include "c_error.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef struct RteStream RteStream;

typedef enum RteTrackMediaType {
  kRteTrackMediaTypeAudio,
  kRteTrackMediaTypeVideo,
  kRteTrackMediaTypeData
} RteTrackMediaType;

typedef enum RteTrackSrc {
  kRteTrackSrcUnknown,
  kRteTrackSrcMix,
  kRteTrackSrcNetwork,
  kRteTrackSrcMicrophone,
  kRteTrackSrcLoopbackRecording,
  kRteTrackSrcCamera,
  kRteTrackSrcScreen,
  kRteTrackSrcCustom,
} RteTrackSrc;

typedef struct RteTrackConfig {
  char placeholder;
} RteTrackConfig;

typedef struct RteTrackInfo {
  RteStream *stream;
} RteTrackInfo;

// @{
// Info
AGORA_RTE_API_C void RteTrackInfoInit(RteTrackInfo *info, RteError *err);
AGORA_RTE_API_C void RteTrackInfoDeinit(RteTrackInfo *info, RteError *err);
//}

AGORA_RTE_API_C void RteTrackGetInfo(RteTrack *self, RteTrackInfo *info, RteError *err);

#ifdef __cplusplus
}
#endif  // __cplusplus
