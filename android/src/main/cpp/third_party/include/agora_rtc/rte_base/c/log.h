/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include <stddef.h>

#include "common.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef struct Rte Rte;
typedef struct RteError RteError;

typedef enum RteLogLevel {
  kRteLogInfo,
  kRteLogWarn,
  kRteLogError,
  kRteLogFatal,
} RteLogLevel;

AGORA_RTE_API_C void RteLog(Rte *self, RteLogLevel level, const char *func,
                           const char *file, size_t line, RteError *err,
                           const char *fmt, ...);

#define RTE_LOG(level, ...) \
  RteLog(NULL, level, __func__, __FILE__, __LINE__, NULL, __VA_ARGS__)

#define RTE_LOGI(...) \
  RteLog(NULL, kRteLogInfo, __func__, __FILE__, __LINE__, NULL, __VA_ARGS__)

#define RTE_LOGW(...) \
  RteLog(NULL, kRteLogWarn, __func__, __FILE__, __LINE__, NULL, __VA_ARGS__)

#define RTE_LOGE(...) \
  RteLog(NULL, kRteLogError, __func__, __FILE__, __LINE__, NULL, __VA_ARGS__)

#define RTE_LOGF(...) \
  RteLog(NULL, kRteLogFatal, __func__, __FILE__, __LINE__, NULL, __VA_ARGS__)

#ifdef __cplusplus
}
#endif  // __cplusplus
