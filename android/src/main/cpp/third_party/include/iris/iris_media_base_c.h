//
// Created by LXH on 2021/7/20.
//

#ifndef IRIS_MEDIA_BASE_C_H_
#define IRIS_MEDIA_BASE_C_H_

#include "iris_base.h"
#include <stdint.h>

EXTERN_C_ENTER
typedef struct IrisMetadata {
  unsigned int uid;

  unsigned int size;

  unsigned char *buffer;

  long long timeStampMs;
} IrisMetadata;

typedef struct IrisPacket {
  const unsigned char *buffer;
  unsigned int size;
} IrisPacket;

EXTERN_C_LEAVE

#endif//IRIS_MEDIA_BASE_C_H_
