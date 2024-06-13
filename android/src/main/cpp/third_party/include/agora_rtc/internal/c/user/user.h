/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include "c_error.h"
#include "handle.h"
#include "info.h"
#include "metadata.h"
#include "observer.h"
#include "../common.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef struct RteUserConfig {
    char placeholder;
} RteUserConfig;

typedef struct RteUserInfo {
  RteBaseInfo base_info;

  RteString *user_name;
  RteString *user_id;
} RteUserInfo;

typedef struct RteUserObserver {
  RteBaseObserver base_observer;
} RteUserObserver;

AGORA_RTE_API_C void RteUserConfigInit(RteUserConfig *config, RteError *err);
AGORA_RTE_API_C void RteUserConfigDeinit(RteUserConfig *config, RteError *err);

AGORA_RTE_API_C void RteUserConfigSetJsonParameter(RteUserConfig *self,
                                                  RteString *json_parameter,
                                                  RteError *err);
AGORA_RTE_API_C void RteUserConfigGetJsonParameter(RteUserConfig *self,
                                                  RteString *json_parameter,
                                                  RteError *err);

AGORA_RTE_API_C void RteUserInit(RteUser *self, RteUserConfig *config,
                                RteError *err);
AGORA_RTE_API_C void RteUserDeinit(RteUser *self, RteError *err);

AGORA_RTE_API_C void RteUserGetConfigs(RteUser *self, RteUserConfig *config,
                                      RteError *err);
AGORA_RTE_API_C void RteUserSetConfigs(RteUser *self, RteUserConfig *config,
                                      void (*cb)(RteUser *user, void *cb_data,
                                                 RteError *err),
                                      void *cb_data);

AGORA_RTE_API_C bool RteUserRegisterObserver(
    RteUser *self, RteUserObserver *observer,
    RteError *err);
AGORA_RTE_API_C bool RteUserUnregisterObserver(RteUser *self,
                                              RteUserObserver *observer,
                                              RteError *err);

AGORA_RTE_API_C void RteUserGetMetadata(RteUser *self, const char *user_name,
                                       void (*cb)(RteUser *self,
                                                  RteMetadata *items,
                                                  void *cb_data, RteError *err),
                                       void *cb_data);
AGORA_RTE_API_C void RteUserSubscribeMetadata(
    RteUser *self, const char *user_name,
    void (*cb)(RteUser *self, void *cb_data, RteError *err), void *cb_data);
AGORA_RTE_API_C void RteUserUnsubscribeMetadata(
    RteUser *self, const char *user_name,
    void (*cb)(RteUser *self, void *cb_data, RteError *err), void *cb_data);
AGORA_RTE_API_C void RteUserSetMetadata(
    RteUser *self, const char *user_name, RteMetadata *items,
    RteMetadataConfig *config,
    void (*cb)(RteUser *self, void *cb_data, RteError *err), void *cb_data);
AGORA_RTE_API_C void RteUserRemoveMetadata(
    RteUser *self, const char *user_name, RteMetadata *items,
    void (*cb)(RteUser *self, void *cb_data, RteError *err), void *cb_data);

#ifdef __cplusplus
}
#endif  // __cplusplus
