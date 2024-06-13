/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include <stdbool.h>
#include <stddef.h>

#include "c_error.h"
#include "../common.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef struct RteBuf {
  void *data;
  size_t size;
  size_t capacity;
  bool own;
  void *user_data;
} RteBuf;

AGORA_RTE_API_C void RteBufReset(RteBuf *self, RteError *err);

AGORA_RTE_API_C void RteBufInit(RteBuf *self, size_t capacity, RteError *err);
AGORA_RTE_API_C void RteBufInitFromBuffer(RteBuf *self, void *buf, size_t size,
                                         RteError *err);
AGORA_RTE_API_C void RteBufInitFromBufferWithOffset(RteBuf *self, size_t offset,
                                                   void *buf, size_t size,
                                                   RteError *err);
AGORA_RTE_API_C void RteBufInitFromString(RteBuf *self, RteString *str,
                                         RteError *err);
AGORA_RTE_API_C void RteBufInitWithBuffer(RteBuf *self, void *buf, size_t size,
                                         int own, RteError *err);

AGORA_RTE_API_C RteBuf *RteBufCreate(RteError *err);
AGORA_RTE_API_C RteBuf *RteBufCreateWithCapacity(size_t capacity, RteError *err);

AGORA_RTE_API_C void RteBufDeinit(RteBuf *self, RteError *err);
AGORA_RTE_API_C void RteBufDestroy(RteBuf *self, RteError *err);

AGORA_RTE_API_C void RteBufReserve(RteBuf *self, size_t len, RteError *err);

AGORA_RTE_API_C void RteBufPush(RteBuf *self, const void *src, size_t size,
                               RteError *err);
AGORA_RTE_API_C void RteBufPop(RteBuf *self, void *dest, size_t size,
                              RteError *err);

AGORA_RTE_API_C void RteBufPeek(RteBuf *self, void *dest, size_t size,
                               RteError *err);

AGORA_RTE_API_C void RteBufDisown(RteBuf *self, RteError *err);

AGORA_RTE_API_C void RteBufAppendNullTerminator(RteBuf *self, RteError *err);

AGORA_RTE_API_C size_t RteBufGetSize(RteBuf *self, RteError *err);
AGORA_RTE_API_C size_t RteBufGetCapacity(RteBuf *self, RteError *err);

#ifdef __cplusplus
}
#endif  // __cplusplus
