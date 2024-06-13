/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include "device/device.h"
#include "handle.h"
#include "../common.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef struct RteAudioDevice RteAudioDevice;

typedef enum RteAudioDeviceType {
  kRteAudioDeviceTypePlayout,
  kRteAudioDeviceTypeRecording,
} RteAudioDeviceType;

typedef struct RteAudioDeviceInfo {
  RteDeviceInfo info;

  RteAudioDeviceType type;
} RteAudioDeviceInfo;

AGORA_RTE_API_C void RteAudioDeviceInfoInit(RteAudioDeviceInfo *info,
                                           RteError *err);
AGORA_RTE_API_C void RteAudioDeviceInfoDeinit(RteAudioDeviceInfo *info,
                                             RteError *err);

AGORA_RTE_API_C void RteAudioDeviceGetInfo(RteAudioDevice *self,
                                          RteAudioDeviceInfo *info,
                                          RteError *err);
#ifdef __cplusplus
}
#endif  // __cplusplus
