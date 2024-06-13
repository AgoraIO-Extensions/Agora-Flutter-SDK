/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include <stddef.h>

#include "c_error.h"
#include "device/video.h"
#include "handle.h"
#include "../common.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef struct RteVideoDeviceManagerConfig {
    char placeholder;
} RteVideoDeviceManagerConfig;

typedef struct RteVideoDeviceManager {
    char placeholder;
} RteVideoDeviceManager;

AGORA_RTE_API_C void RteVideoDeviceManagerConfigInit(
    RteVideoDeviceManagerConfig *config, RteError *err);
AGORA_RTE_API_C void RteVideoDeviceManagerConfigDeinit(
    RteVideoDeviceManagerConfig *config, RteError *err);
AGORA_RTE_API_C void RteVideoDeviceManagerConfigSetJsonParameter(
    RteVideoDeviceManagerConfig *config, RteString *json_parameter,
    RteError *err);
AGORA_RTE_API_C void RteVideoDeviceManagerConfigGetJsonParameter(
    RteVideoDeviceManagerConfig *config, RteString *json_parameter,
    RteError *err);

typedef void (*RteVideoDeviceManagerSetConfigsCallback)(
    RteVideoDeviceManager *device_manager, RteVideoDeviceManagerConfig *config,
    void *cb_data, RteError *err);

typedef void (*RteVideoDeviceManagerEnumerateDevicesCallback)(
    RteVideoDeviceManager *device_manager, RteVideoDevice *devices,
    size_t devices_cnt, void *cb_data, RteError *err);

AGORA_RTE_API_C RteVideoDeviceManager RteVideoDeviceManagerCreate(
    Rte *rte, RteVideoDeviceManagerConfig *config, RteError *err);
AGORA_RTE_API_C void RteVideoDeviceManagerDestroy(RteVideoDeviceManager *self,
                                                 RteError *err);
AGORA_RTE_API_C void RteVideoDeviceManagerGetConfigs(
    RteVideoDeviceManager *self, RteVideoDeviceManagerConfig *config,
    RteError *err);
AGORA_RTE_API_C void RteVideoDeviceManagerSetConfigs(
    RteVideoDeviceManager *self, RteVideoDeviceManagerConfig *config,
    RteVideoDeviceManagerSetConfigsCallback callback, void *cb_data);
AGORA_RTE_API_C void RteVideoDeviceManagerEnumerateDevices(
    RteVideoDeviceManager *self, RteVideoDeviceType type,
    RteVideoDeviceManagerEnumerateDevicesCallback cb, void *cb_data);
AGORA_RTE_API_C void RteVideoDeviceManagerSetCurrentDevice(
    RteVideoDeviceManager *self, RteVideoDevice *device, RteError *err);
AGORA_RTE_API_C RteVideoDevice RteVideoDeviceManagerGetCurrentDevice(
    RteVideoDeviceManager *self, RteVideoDeviceType type, RteError *err);

#ifdef __cplusplus
}
#endif  // __cplusplus
