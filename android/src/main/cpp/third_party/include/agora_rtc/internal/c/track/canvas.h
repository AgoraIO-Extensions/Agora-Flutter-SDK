/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include "handle.h"
#include "../common.h"
#include "track/view.h"
#include "stream/stream.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef struct RteViewConfig RteViewConfig;


typedef enum RteVideoRenderMode {
    kRteVideoRenderModeHidden,
    kRteVideoRenderModeFit
} RteVideoRenderMode;

typedef struct RteCanvasInitialConfig {
    char placeholder;
} RteCanvasInitialConfig;


typedef struct RteCanvasConfig {

    RteVideoRenderMode render_mode;
    bool has_render_mode;

    RteVideoMirrorMode mirror_mode;
    bool has_mirror_mode;

    RteRect crop_area;
    bool has_crop_area;
} RteCanvasConfig;


// @{
// InitialConfig
AGORA_RTE_API_C void RteCanvasInitialConfigInit(RteCanvasInitialConfig *config,
                                             RteError *err);
AGORA_RTE_API_C void RteCanvasInitialConfigDeinit(RteCanvasInitialConfig *config,
                                               RteError *err);
// @}

// @{
// Config
AGORA_RTE_API_C void RteCanvasConfigInit(RteCanvasConfig *config, RteError *err);
AGORA_RTE_API_C void RteCanvasConfigDeinit(RteCanvasConfig *config,
                                          RteError *err);

AGORA_RTE_API_C void RteCanvasConfigSetVideoRenderMode(RteCanvasConfig *self, RteVideoRenderMode render_mode, RteError *err);

AGORA_RTE_API_C void RteCanvasConfigGetVideoRenderMode(RteCanvasConfig *self, RteVideoRenderMode *render_mode, RteError *err);

AGORA_RTE_API_C void RteCanvasConfigSetVideoMirrorMode(RteCanvasConfig *self, RteVideoMirrorMode mirror_mode, RteError *err);

AGORA_RTE_API_C void RteCanvasConfigGetVideoMirrorMode(RteCanvasConfig *self, RteVideoMirrorMode *mirror_mode, RteError *err);

AGORA_RTE_API_C void RteCanvasConfigSetCropArea(RteCanvasConfig *self, RteRect crop_area, RteError *err);

AGORA_RTE_API_C void RteCanvasConfigGetCropArea(RteCanvasConfig *self, RteRect *crop_area, RteError *err);

// @}

AGORA_RTE_API_C RteCanvas RteCanvasCreate(::Rte *rte, RteCanvasInitialConfig *config,
                                         RteError *err);
AGORA_RTE_API_C void RteCanvasDestroy(RteCanvas *self, RteError *err);

AGORA_RTE_API_C void RteCanvasGetConfigs(RteCanvas *self,
                                        RteCanvasConfig *config, RteError *err);
AGORA_RTE_API_C void RteCanvasSetConfigs(
    RteCanvas *self, RteCanvasConfig *config,
    void (*cb)(RteCanvas *canvas, void *cb_data, RteError *err), void *cb_data);

AGORA_RTE_API_C void RteCanvasAddView(
    RteCanvas *self, RteView *view, RteViewConfig *config,
    void (*cb)(RteCanvas *canvas, RteView *view, void *cb_data, RteError *err),
    void *cb_data);

AGORA_RTE_API_C void RteCanvasRemoveView(RteCanvas *self, RteView *view, RteViewConfig *config, RteError *err);

#ifdef __cplusplus
}
#endif  // __cplusplus
