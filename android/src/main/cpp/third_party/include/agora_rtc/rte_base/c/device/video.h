/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include "rte_base/c/device/device.h"
#include "rte_base/c/common.h"
#include "rte_base/c/handle.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef enum RteVideoDeviceType {
  kRteVideoDeviceTypeCapturing
} RteVideoDeviceType;

typedef struct RteVideoDeviceInfo {
  RteDeviceInfo base;

  RteVideoDeviceType type;
} RteVideoDeviceInfo;

AGORA_RTE_API_C void RteVideoDeviceInfoInit(RteVideoDeviceInfo *info,
                                           RteError *err);
AGORA_RTE_API_C void RteVideoDeviceInfoDeinit(RteVideoDeviceInfo *info,
                                             RteError *err);

AGORA_RTE_API_C void RteVideoDeviceGetInfo(RteVideoDevice *self,
                                          RteVideoDeviceInfo *info,
                                          RteError *err);
#ifdef __cplusplus
}
#endif  // __cplusplus
