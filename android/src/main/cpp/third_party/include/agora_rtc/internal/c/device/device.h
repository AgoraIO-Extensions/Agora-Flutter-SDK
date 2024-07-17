/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include "../common.h"
#include "utils/string.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef struct RteDeviceInfo {
  RteString *device_name;
  RteString *device_id;
} RteDeviceInfo;

AGORA_RTE_API_C void RteDeviceInfoInit(RteDeviceInfo *info, RteError *err);

AGORA_RTE_API_C void RteDeviceInfoDeinit(RteDeviceInfo *info, RteError *err);

#ifdef __cplusplus
}
#endif  // __cplusplus
