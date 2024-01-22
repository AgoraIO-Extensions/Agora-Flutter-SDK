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
  levelDebug = 1,
  levelInfo = 2,
  levelWarn = 3,
  levelErr = 4,
  levelCritical = 5,
  levelOff = 6,
} IrisLogLevel;

typedef enum IrisError {
  ERR_OK = 0,
  ERR_FAILED = 1,
  ERR_INVALID_ARGUMENT = 2,
  ERR_NOT_SUPPORTED = 4,
  ERR_NOT_INITIALIZED = 7,

  /*base from IRIS_VIDEO_PROCESS_ERR::ERR_NULL_POINTER=1*/
  ERR_NULL_POINTER = 1001,
  ERR_SIZE_NOT_MATCHING = 1002,
  ERR_BUFFER_EMPTY = 1005,
  ERR_FRAM_TYPE_NOT_MATCHING = 1006,
  ERR_ALREADY_REGISTERED = 1007,
  ERR_ALREADY_UNREGISTERED = 1008,
  ERR_API_NOT_REGISTERED = 1009,
} IrisError;

IRIS_API void enableUseJsonArray(bool enable);

void saveAppType(IrisAppType type);

IrisAppType getAppType();

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

typedef void *IrisHandle;
typedef IrisHandle IrisEventHandlerHandle;
typedef IrisHandle IrisApiEnginePtr;

EXTERN_C_LEAVE

#endif//IRIS_BASE_H_
