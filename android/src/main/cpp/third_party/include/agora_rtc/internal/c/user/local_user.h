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
#include "utils/buf.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef struct RteLocalUserConfig {
  RteUserConfig user_config;
} RteLocalUserConfig;

typedef struct RteLocalUserInfo {
  RteUserInfo user_info;
} RteLocalUserInfo;

typedef struct RteLocalUserObserver RteLocalUserObserver;
struct RteLocalUserObserver {
  RteUserObserver base_observer;

  void (*on_user_message_received)(RteLocalUserObserver *self,
                                   RteString *publisher, RteBuf *message);
};

// @{
// Config
AGORA_RTE_API_C void RteLocalUserConfigInit(RteLocalUserConfig *config,
                                           RteError *err);
AGORA_RTE_API_C void RteLocalUserConfigDeinit(RteLocalUserConfig *config,
                                             RteError *err);

AGORA_RTE_API_C void RteLocalUserConfigSetUserId(RteLocalUserConfig *self,
                                                RteString *user_id,
                                                RteError *err);
AGORA_RTE_API_C void RteLocalUserConfigGetUserId(RteLocalUserConfig *self,
                                                RteString *user_id,
                                                RteError *err);

AGORA_RTE_API_C void RteLocalUserConfigSetUserName(RteLocalUserConfig *self,
                                                  RteString *user_name,
                                                  RteError *err);
AGORA_RTE_API_C void RteLocalUserConfigGetUserName(RteLocalUserConfig *self,
                                                  RteString *user_name,
                                                  RteError *err);

AGORA_RTE_API_C void RteLocalUserConfigSetUserToken(RteLocalUserConfig *self,
                                                   RteString *user_token,
                                                   RteError *err);
AGORA_RTE_API_C void RteLocalUserConfigGetUserToken(RteLocalUserConfig *self,
                                                   RteString *user_token,
                                                   RteError *err);

AGORA_RTE_API_C void RteLocalUserConfigSetJsonParameter(
    RteLocalUserConfig *self, RteString *json_parameter, RteError *err);
AGORA_RTE_API_C void RteLocalUserConfigGetJsonParameter(
    RteLocalUserConfig *self, RteString *json_parameter, RteError *err);
// @}

// @{
// Info
AGORA_RTE_API_C void RteLocalUserInfoInit(RteLocalUserInfo *info, RteError *err);
AGORA_RTE_API_C void RteLocalUserInfoDeinit(RteLocalUserInfo *info,
                                           RteError *err);
// @}

// @{
// Observer
AGORA_RTE_API_C RteLocalUserObserver *RteLocalUserObserverCreate(RteError *err);
AGORA_RTE_API_C void RteLocalUserObserverDestroy(RteLocalUserObserver *self,
                                                RteError *err);

AGORA_RTE_API_C RteLocalUser
RteLocalUserObserverGetEventSrc(RteLocalUserObserver *self, RteError *err);
// @}

RteLocalUser RteLocalUserCreate(Rte *self, RteLocalUserConfig *config,
                                RteError *err);
AGORA_RTE_API_C void RteLocalUserDestroy(RteLocalUser *self, RteError *err);

AGORA_RTE_API_C void RteLocalUserGetConfigs(RteLocalUser *self,
                                           RteLocalUserConfig *config,
                                           RteError *err);
AGORA_RTE_API_C void RteLocalUserSetConfigs(
    RteLocalUser *self, RteLocalUserConfig *config,
    void (*cb)(RteLocalUser *user, void *cb_data, RteError *err),
    void *cb_data);

AGORA_RTE_API_C void RteLocalUserGetInfo(RteLocalUser *self,
                                        RteLocalUserInfo *info, RteError *err);

AGORA_RTE_API_C void RteLocalUserLogin(RteLocalUser *self,
                                      void (*cb)(void *cb_data, RteError *err),
                                      void *cb_data);
AGORA_RTE_API_C void RteLocalUserLogout(RteLocalUser *self,
                                       void (*cb)(void *cb_data, RteError *err),
                                       void *cb_data);
AGORA_RTE_API_C bool RteLocalUserIsLogin(RteLocalUser *self);

AGORA_RTE_API_C void RteLocalUserPublishMessage(
    RteLocalUser *self, const char *user_name, RteBuf *message,
    void (*cb)(RteLocalUser *self, void *cb_data, RteError *err),
    void *cb_data);

AGORA_RTE_API_C bool RteLocalUserRegisterObserver(
    RteLocalUser *self, RteLocalUserObserver *observer, RteError *err);
AGORA_RTE_API_C bool RteLocalUserUnregisterObserver(
    RteLocalUser *self, RteLocalUserObserver *observer, RteError *err);

#ifdef __cplusplus
}
#endif  // __cplusplus
