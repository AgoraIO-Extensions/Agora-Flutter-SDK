/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include <stdbool.h>

#include "common.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef struct RteString RteString;

typedef enum RteErrorCode {
  kRteOk,
  kRteErrorDefault,
  kRteErrorInvalidArgument,
  kRteErrorInvalidOperation,
  kRteErrorNetworkError,
  kRteErrorAuthenticationFailed,
  kRteErrorStreamNotFound,
} RteErrorCode;

typedef struct RteError {
  RteErrorCode code;
  RteString *message;
} RteError;

AGORA_RTE_API_C RteError *RteErrorCreate();
AGORA_RTE_API_C bool RteErrorDestroy(RteError *err);

AGORA_RTE_API_C bool RteErrorInit(RteError *err);
AGORA_RTE_API_C bool RteErrorDeinit(RteError *err);

AGORA_RTE_API_C bool RteErrorCopy(RteError *dest, RteError *src);

AGORA_RTE_API_C bool RteErrorSet(RteError *err, RteErrorCode code,
                                const char *fmt, ...);
AGORA_RTE_API_C bool RteErrorOccurred(RteError *err);

#ifdef __cplusplus
}
#endif  // __cplusplus
