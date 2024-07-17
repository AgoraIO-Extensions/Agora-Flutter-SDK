/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include "handle.h"
#include "../common.h"
#include "user/user.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef struct RteRemoteUserConfig {
  RteUserConfig user_config;
} RteRemoteUserConfig;

typedef struct RteRemoteUserInfo {
  RteUserInfo user_info;
} RteRemoteUserInfo;

typedef struct RteRemoteUserObserver {
  RteUserObserver user_observer;
} RteRemoteUserObserver;

// @{
// Config
AGORA_RTE_API_C void RteRemoteUserConfigInit(RteRemoteUserConfig *config,
                                            RteError *err);
AGORA_RTE_API_C void RteRemoteUserConfigDeinit(RteRemoteUserConfig *config,
                                              RteError *err);

AGORA_RTE_API_C void RteRemoteUserConfigSetJsonParameter(
    RteRemoteUserConfig *self, RteString *json_parameter, RteError *err);
AGORA_RTE_API_C void RteRemoteUserConfigGetJsonParameter(
    RteRemoteUserConfig *self, RteString *json_parameter, RteError *err);
// @}

// @{
// Info
AGORA_RTE_API_C void RteRemoteUserInfoInit(RteRemoteUserInfo *info,
                                          RteError *err);
AGORA_RTE_API_C void RteRemoteUserInfoDeinit(RteRemoteUserInfo *info,
                                            RteError *err);
// @}

AGORA_RTE_API_C void RteRemoteUserGetConfigs(RteRemoteUser *self,
                                            RteRemoteUserConfig *config,
                                            RteError *err);
AGORA_RTE_API_C void RteRemoteUserSetConfigs(
    RteRemoteUser *self, RteRemoteUserConfig *config,
    void (*cb)(RteRemoteUser *user, void *cb_data, RteError *err),
    void *cb_data);

AGORA_RTE_API_C void RteRemoteUserGetInfo(RteRemoteUser *self,
                                         RteRemoteUserInfo *info,
                                         RteError *err);

AGORA_RTE_API_C bool RteRemoteUserRegisterObserver(
    RteRemoteUser *self, RteRemoteUserObserver *observer, RteError *err);
AGORA_RTE_API_C bool RteRemoteUserUnregisterObserver(
    RteRemoteUser *self, RteRemoteUserObserver *observer, RteError *err);

AGORA_RTE_API_C RteRemoteUserObserver *RteRemoteUserObserverCreate(
    RteError *err);
AGORA_RTE_API_C void RteRemoteUserObserverDestroy(RteRemoteUserObserver *self,
                                                 RteError *err);

AGORA_RTE_API_C RteRemoteUser
RteRemoteUserObserverGetEventSrc(RteRemoteUserObserver *self, RteError *err);

#ifdef __cplusplus
}
#endif  // __cplusplus
