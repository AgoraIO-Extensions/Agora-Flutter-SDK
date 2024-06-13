/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include <stddef.h>

#include "../common.h"
#include "c_error.h"
#include "device/audio.h"
#include "handle.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef struct RteAudioDeviceManagerConfig {
    char placeholder;
} RteAudioDeviceManagerConfig;

typedef struct RteAudioDeviceManager {
    char placeholder;
} RteAudioDeviceManager;

AGORA_RTE_API_C void RteAudioDeviceManagerConfigInit(
    RteAudioDeviceManagerConfig *config, RteError *err);

AGORA_RTE_API_C void RteAudioDeviceManagerConfigDeInit(
    RteAudioDeviceManagerConfig *config, RteError *err);

AGORA_RTE_API_C void RteAudioDeviceManagerConfigSetJsonParameter(
    RteAudioDeviceManagerConfig *self, RteString *json_parameter,
    RteError *err);

AGORA_RTE_API_C void RteAudioDeviceManagerConfigGetJsonParameter(
    RteAudioDeviceManagerConfig *config, RteString *json_parameter,
    RteError *err);

typedef void (*RteAudioDeviceManagerSetConfigsCallback)(
    RteAudioDeviceManager *device_manager, RteAudioDeviceManagerConfig *config,
    void *cb_data, RteError *err);

AGORA_RTE_API_C RteAudioDeviceManager RteAudioDeviceManagerCreate(
    Rte *rte, RteAudioDeviceManagerConfig *config, RteError *err);
AGORA_RTE_API_C void RteAudioDeviceManagerDestroy(RteAudioDeviceManager *self,
                                                 RteError *err);

AGORA_RTE_API_C void RteAudioDeviceManagerGetConfigs(
    RteAudioDeviceManager *self, RteAudioDeviceManagerConfig *config,
    RteError *err);

AGORA_RTE_API_C void RteAudioDeviceManagerSetConfigs(
    RteAudioDeviceManager *self, RteAudioDeviceManagerConfig *config,
    RteAudioDeviceManagerSetConfigsCallback cb, void *cb_data);

typedef void (*RteAudioDeviceManagerEnumerateDevicesCallback)(
    RteAudioDeviceManager *mgr, RteAudioDevice *devices, size_t devices_cnt,
    void *cb_data, RteError *err);
AGORA_RTE_API_C void RteAudioDeviceManagerEnumerateDevices(
    RteAudioDeviceManager *self, RteAudioDeviceType type,
    RteAudioDeviceManagerEnumerateDevicesCallback cb, void *cb_data);

AGORA_RTE_API_C void RteAudioDeviceManagerSetVolume(RteAudioDeviceManager *self,
                                                   RteAudioDeviceType type,
                                                   uint32_t volume,
                                                   RteError *err);

AGORA_RTE_API_C void RteAudioDeviceManagerGetVolume(RteAudioDeviceManager *self,
                                                   RteAudioDeviceType type,
                                                   uint32_t *volume,
                                                   RteError *err);

typedef void (*RteAudioDeviceManagerSetCurrentDeviceCallback)(
    RteAudioDeviceManager *self, RteAudioDeviceType type,
    RteAudioDevice *device, void *cb_data, RteError *err);
AGORA_RTE_API_C void RteAudioDeviceManagerSetCurrentDevice(
    RteAudioDeviceManager *self, RteAudioDeviceType type,
    RteAudioDevice *device, RteAudioDeviceManagerSetCurrentDeviceCallback cb,
    void *cb_data);

AGORA_RTE_API_C RteAudioDevice RteAudioDeviceManagerGetCurrentDevice(
    RteAudioDeviceManager *self, RteAudioDeviceType type, RteError *err);

#if defined(__ANDROID__) || defined(TARGET_OS_IOS) || defined(UNIT_TEST_MOCK)
AGORA_RTE_API_C void RteAudioDeviceManagerUseSpeakerphoneByDefault(
    RteAudioDeviceManager *self, bool enable, RteError *err);

AGORA_RTE_API_C void RteAudioDeviceManagerUseSpeakerphone(
    RteAudioDeviceManager *self, bool enable, RteError *err);
#endif

#ifdef __cplusplus
}
#endif  // __cplusplus
