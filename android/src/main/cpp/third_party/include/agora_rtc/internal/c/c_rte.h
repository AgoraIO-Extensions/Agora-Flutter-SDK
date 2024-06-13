/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include <stdint.h>

#include "common.h"
#include "handle.h"
#include "observer.h"
#include "utils/string.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef struct RteRemoteStream RteRemoteStream;
typedef struct RteLocalStream RteLocalStream;

typedef struct RteInitialConfig {
  void *placeholder;
} RteInitialConfig;

typedef struct RteConfig {
  RteString *app_id;
  bool has_app_id;

  RteString *log_folder;
  bool has_log_folder;

  size_t log_file_size;
  bool has_log_file_size;

  int32_t area_code;
  bool has_area_code;

  RteString *cloud_proxy;
  bool has_cloud_proxy;

  RteString *json_parameter;
  bool has_json_parameter;
} RteConfig;

typedef struct RteObserver {
  RteBaseObserver base_observer;
} RteObserver;

AGORA_RTE_API_C void RteInitialConfigInit(RteInitialConfig *config, RteError *err);
AGORA_RTE_API_C void RteInitialConfigDeinit(RteInitialConfig *config, RteError *err);

AGORA_RTE_API_C void RteConfigInit(RteConfig *config, RteError *err);
AGORA_RTE_API_C void RteConfigDeinit(RteConfig *config, RteError *err);
AGORA_RTE_API_C void RteConfigCopy(RteConfig *dst, const RteConfig *src,
                                  RteError *err);

AGORA_RTE_API_C void RteConfigSetAppId(RteConfig *config, RteString *app_id,
                                      RteError *err);
AGORA_RTE_API_C void RteConfigGetAppId(RteConfig *config, RteString *app_id,
                                      RteError *err);

AGORA_RTE_API_C void RteConfigSetLogFolder(RteConfig *config,
                                          RteString *log_folder, RteError *err);
AGORA_RTE_API_C void RteConfigGetLogFolder(RteConfig *config,
                                          RteString *log_folder, RteError *err);

AGORA_RTE_API_C void RteConfigSetLogFileSize(RteConfig *config,
                                            size_t log_file_size,
                                            RteError *err);
AGORA_RTE_API_C void RteConfigGetLogFileSize(RteConfig *config,
                                            size_t *log_file_size,
                                            RteError *err);

AGORA_RTE_API_C void RteConfigSetAreaCode(RteConfig *config, int32_t area_code,
                                         RteError *err);
AGORA_RTE_API_C void RteConfigGetAreaCode(RteConfig *config, int32_t *area_code,
                                         RteError *err);

AGORA_RTE_API_C void RteConfigSetCloudProxy(RteConfig *config,
                                           RteString *cloud_proxy,
                                           RteError *err);
AGORA_RTE_API_C void RteConfigGetCloudProxy(RteConfig *config,
                                           RteString *cloud_proxy,
                                           RteError *err);

AGORA_RTE_API_C void RteConfigSetJsonParameter(RteConfig *config,
                                              RteString *json_parameter,
                                              RteError *err);
AGORA_RTE_API_C void RteConfigGetJsonParameter(RteConfig *config,
                                              RteString *json_parameter,
                                              RteError *err);

AGORA_RTE_API_C Rte RteCreate(RteInitialConfig *config, RteError *err);
AGORA_RTE_API_C void RteDestroy(Rte *self, RteError *err);

AGORA_RTE_API_C bool RteInitMediaEngine(Rte *self,
                                       void (*cb)(Rte *self, void *cb_data,
                                                  RteError *err),
                                       void *cb_data, RteError *err);

AGORA_RTE_API_C void RteGetConfigs(Rte *self, RteConfig *config, RteError *err);
AGORA_RTE_API_C bool RteSetConfigs(Rte *self, RteConfig *config,
                                  void (*cb)(Rte *self, void *cb_data,
                                             RteError *err),
                                  void *cb_data, RteError *err);

AGORA_RTE_API_C void RteRelayStream(RteChannel *src_channel,
                                   RteRemoteStream *src_stream,
                                   RteChannel *dest_channel,
                                   RteLocalStream *dest_stream,
                                   void (*cb)(void *cb_data, RteError *err),
                                   void *cb_data);

AGORA_RTE_API_C void RteRegisterExtension(
    Rte *self, RteString *provider_name, RteString *extension_name,
    void (*cb)(Rte *self, RteString *provider_name, RteString *extension_name,
               void *cb_data, RteError *err),
    void *cb_data);

AGORA_RTE_API_C void RteReportMessage(Rte *self, RteError *err, const char *fmt,
                                     ...);

AGORA_RTE_API_C bool RteRegisterObserver(Rte *self, RteObserver *observer, RteError *err);
AGORA_RTE_API_C bool RteUnregisterObserver(Rte *self, RteObserver *observer,
                                          RteError *err);

AGORA_RTE_API_C void RteStartLastMileProbeTest(Rte *self,
                                              void (*cb)(RteError *err));

AGORA_RTE_API_C RteObserver *RteObserverCreate(RteError *err);

AGORA_RTE_API_C void RteObserverDestroy(RteObserver *observer, RteError *err);

AGORA_RTE_API_C Rte RteObserverGetEventSrc(RteObserver *observer, RteError *err);

// @{
// Internal use only.
AGORA_RTE_API_C bool RteGlobalListIsEmpty();
// @}

#ifdef __cplusplus
}
#endif  // __cplusplus
