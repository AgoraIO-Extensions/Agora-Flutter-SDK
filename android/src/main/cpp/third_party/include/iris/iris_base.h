//
// Created by LXH on 2021/5/10.
//

#ifndef IRIS_BASE_H_
#define IRIS_BASE_H_

#include "iris_platform.h"

EXTERN_C_ENTER
#define kBasicResultLength 65536
#define kEventResultLenght 1024
#define kBasicStringLength 512
#define kDefaultLogFileSize 1024 * 1024 * 5

typedef enum IrisAppType {
  kAppTypeNative = 0,
  kAppTypeCocos = 1,
  kAppTypeUnity = 2,
  kAppTypeElectron = 3,
  kAppTypeFlutter = 4,
  kAppTypeUnreal = 5,
  kAppTypeXamarin = 6,
  kAppTypeApiCloud = 7,
  kAppTypeReactNative = 8,
  kAppTypePython = 9,
  kAppTypeCocosCreator = 10,
  kAppTypeRust = 11,
  kAppTypeCSharp = 12,
  kAppTypeCef = 13,
  kAppTypeUniApp = 14,
} IrisAppType;

typedef enum IrisLogLevel {
  LOG_LEVEL_TRACE = 0,
  LOG_LEVEL_DEBUG = 1,
  LOG_LEVEL_INFO = 2,
  LOG_LEVEL_WARN = 3,
  LOG_LEVEL_ERROR = 4,
  LOG_LEVEL_CRITICAL = 5,
  LOG_LEVEL_OFF = 6,
} IrisLogLevel;

IRIS_API void enableUseJsonArray(bool enable);

IRIS_API void InitIrisLogger(const char *path, int maxSize, IrisLogLevel level);

typedef struct EventParam {
  const char *event;
  const char *data;
  unsigned int data_size;
  char *result;
  void **buffer;
  unsigned int *length;
  unsigned int buffer_count;
} EventParam;

typedef EventParam ApiParam;

typedef void(IRIS_CALL *Func_Event)(EventParam *param);

typedef struct IrisCEventHandler {
  Func_Event OnEvent;
} IrisCEventHandler;

typedef void *IrisEventHandlerHandle;

EXTERN_C_LEAVE

#endif//IRIS_BASE_H_
