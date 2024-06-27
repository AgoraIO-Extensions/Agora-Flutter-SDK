/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef union RteUuid {
  uint8_t bytes[16];
  uint32_t dwords[4];
  uint64_t qwords[2];
} RteUuid;

#ifdef __cplusplus
}
#endif  // __cplusplus
