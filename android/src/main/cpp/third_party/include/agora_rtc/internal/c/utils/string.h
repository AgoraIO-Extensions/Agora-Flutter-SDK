/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include <stdarg.h>
#include <stdbool.h>
#include <stddef.h>

#include "../common.h"

#define RTE_STRING_PRE_BUF_SIZE 256

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef struct RteError RteError;
typedef struct RteString RteString;

AGORA_RTE_API_C RteString *RteStringCreate(RteError *err);
AGORA_RTE_API_C void RteStringDestroy(RteString *self, RteError *err);

AGORA_RTE_API_C void RteStringInit(RteString *self, RteError *err);
AGORA_RTE_API_C void RteStringInitWithCStr(RteString *self, const char *c_str,
                                          RteError *err);
AGORA_RTE_API_C void RteStringInitWithValue(RteString *self, RteError *err,
                                           const char *fmt, ...);
AGORA_RTE_API_C void RteStringDeinit(RteString *self, RteError *err);

AGORA_RTE_API_C void RteStringVSet(RteString *self, RteError *err,
                                  const char *fmt, va_list ap);

AGORA_RTE_API_C void RteStringReserve(RteString *self, size_t extra,
                                     RteError *err);

AGORA_RTE_API_C void RteStringCopy(RteString *self, const RteString *other,
                                  RteError *err);

AGORA_RTE_API_C bool RteStringIsEqual(const RteString *self,
                                     const RteString *other, RteError *err);
AGORA_RTE_API_C bool RteStringIsEqualCStr(const RteString *self,
                                         const char *other, RteError *err);

AGORA_RTE_API_C const char *RteStringCStr(const RteString *self, RteError *err);

#ifdef __cplusplus
}
#endif  // __cplusplus
