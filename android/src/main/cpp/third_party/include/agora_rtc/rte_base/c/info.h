/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include "c_error.h"
#include "common.h"
#include "handle.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef struct RteBaseInfo {
  Rte rte;
} RteBaseInfo;

AGORA_RTE_API_C void RteBaseInfoInit(RteBaseInfo *info, RteError *err);

AGORA_RTE_API_C void RteBaseInfoDeinit(RteBaseInfo *info, RteError *err);

#ifdef __cplusplus
}
#endif  // __cplusplus
