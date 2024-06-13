/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include "c_error.h"
#include "../common.h"
#include "utils/rect.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef struct Rte Rte;
typedef struct RteCanvas RteCanvas;
typedef void *RteView;

typedef struct RteViewConfig {
  RteRect crop_area;
} RteViewConfig;

typedef struct RteViewInfo {
  RteCanvas *attached_canvas;
} RteViewInfo;

// @{
// Config
AGORA_RTE_API_C void RteViewConfigInit(RteViewConfig *config, RteError *err);
AGORA_RTE_API_C void RteViewConfigDeinit(RteViewConfig *config, RteError *err);

AGORA_RTE_API_C void RteViewConfigSetCropArea(RteViewConfig *self,
                                             RteRect crop_area, RteError *err);
AGORA_RTE_API_C void RteViewConfigGetCropArea(RteViewConfig *self,
                                             RteRect *crop_area, RteError *err);
// @}

// @{
// Info
AGORA_RTE_API_C void RteViewInfoInit(RteViewInfo *info, RteError *err);
AGORA_RTE_API_C void RteViewInfoDeinit(RteViewInfo *info, RteError *err);
// @}

AGORA_RTE_API_C RteView RteViewCreate(Rte *self, RteViewConfig *config,
                                     RteError *err);
AGORA_RTE_API_C void RteViewDestroy(RteView *self, RteError *err);

AGORA_RTE_API_C void RteViewGetInfo(RteView *self, RteViewInfo *info,
                                   RteError *err);

#ifdef __cplusplus
}
#endif  // __cplusplus
