/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#include "c_error.h"
#include "common.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef struct RteMetadataConfig {
  bool record_ts;
  bool has_record_ts;

  bool record_owner;
  bool has_record_owner;

  RteString *lock_name;
  bool has_lock_name;

  RteString *json_parameter;
  bool has_json_parameter;
} RteMetadataConfig;

typedef struct RteMetadataItem {
  RteString *key;
  RteString *value;
  RteString *author;
  int64_t revision;
  int64_t update_timestamp;
} RteMetadataItem;

typedef struct RteMetadata {
  char placeholder;
} RteMetadata;

AGORA_RTE_API_C void RteMetadataConfigInit(RteMetadataConfig *config,
                                          RteError *err);
AGORA_RTE_API_C void RteMetadataConfigDeinit(RteMetadataConfig *config,
                                            RteError *err);

AGORA_RTE_API_C void RteMetadataConfigSetRecordTs(RteMetadataConfig *self,
                                                 bool record_ts, RteError *err);
AGORA_RTE_API_C void RteMetadataConfigGetRecordTs(RteMetadataConfig *self,
                                                 bool *record_ts,
                                                 RteError *err);

AGORA_RTE_API_C void RteMetadataConfigSetRecordOwner(RteMetadataConfig *self,
                                                    bool record_owner,
                                                    RteError *err);
AGORA_RTE_API_C void RteMetadataConfigGetRecordOwner(RteMetadataConfig *self,
                                                    bool *record_owner,
                                                    RteError *err);

AGORA_RTE_API_C void RteMetadataConfigSetJsonParameter(RteMetadataConfig *self,
                                                      RteString *json_parameter,
                                                      RteError *err);
AGORA_RTE_API_C void RteMetadataConfigGetJsonParameter(RteMetadataConfig *self,
                                                      RteString *json_parameter,
                                                      RteError *err);

AGORA_RTE_API_C void RteMetadataItemInit(RteMetadataItem *self, RteError *err);
AGORA_RTE_API_C void RteMetadataItemDeinit(RteMetadataItem *self, RteError *err);

AGORA_RTE_API_C void RteMetadataInit(RteMetadata *self, RteError *err);
AGORA_RTE_API_C void RteMetadataDeinit(RteMetadata *self, RteError *err);

AGORA_RTE_API_C void RteMetadataSetRevision(RteMetadata *self, int64_t revision,
                                           RteError *err);
AGORA_RTE_API_C void RteMetadataGetRevision(RteMetadata *self, int64_t *revision,
                                           RteError *err);

AGORA_RTE_API_C void RteMetadataClear(RteMetadata *self, RteError *err);

AGORA_RTE_API_C void RteMetadataAddItem(RteMetadata *self, RteMetadataItem *item,
                                       RteError *err);
AGORA_RTE_API_C size_t RteMetadataGetItems(RteMetadata *self,
                                          RteMetadataItem *items,
                                          size_t items_cnt, RteError *err);

#ifdef __cplusplus
}
#endif  // __cplusplus
