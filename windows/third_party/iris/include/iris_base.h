//
// Created by LXH on 2021/5/10.
//

#ifndef IRIS_BASE_H_
#define IRIS_BASE_H_

#if defined(__APPLE__)
#include <TargetConditionals.h>
#endif

#if defined(_WIN32)
#define IRIS_CALL __cdecl
#if defined(IRIS_EXPORT)
#define IRIS_API extern "C" __declspec(dllexport)
#define IRIS_CPP_API __declspec(dllexport)
#else
#define IRIS_API extern "C" __declspec(dllimport)
#define IRIS_CPP_API __declspec(dllimport)
#endif
#elif defined(__APPLE__)
#define IRIS_API __attribute__((visibility("default"))) extern "C"
#define IRIS_CPP_API __attribute__((visibility("default")))
#define IRIS_CALL
#elif defined(__ANDROID__) || defined(__linux__)
#define IRIS_API extern "C" __attribute__((visibility("default")))
#define IRIS_CPP_API __attribute__((visibility("default")))
#define IRIS_CALL
#else
#define IRIS_API extern "C"
#define IRIS_CPP_API
#define IRIS_CALL
#endif

#if defined(IRIS_DEBUG)
#define IRIS_DEBUG_API IRIS_API
#define IRIS_DEBUG_CPP_API IRIS_CPP_API
#else
#define IRIS_DEBUG_API
#define IRIS_DEBUG_CPP_API
#endif

#ifdef __cplusplus
extern "C" {
#endif

const int kBasicResultLength = 512;
const int kMaxResultLength = 2048;

IRIS_API unsigned int kValueType;

IRIS_API void InitIrisLogger(const char *tag, const char *path);

IRIS_API void UseJsonObject();

IRIS_API void UseJsonArray();

IRIS_API bool StrCpy_S(char *dst, const char *src,
                       int max_len = kBasicResultLength);

typedef struct IrisRect {
  double x;
  double y;
  double width;
  double height;
} IrisRect;

typedef struct IrisDisplay {
  unsigned int id;
  float scale;
  IrisRect bounds;
  IrisRect work_area;
  int rotation;
} IrisDisplay;

typedef struct IrisDisplayCollection {
  IrisDisplay *displays;
  unsigned int length;
} IrisDisplayCollection;

typedef struct IrisWindow {
  unsigned long id;
  char name[kBasicResultLength];
  char owner_name[kBasicResultLength];
  IrisRect bounds;
  IrisRect work_area;
} IrisWindow;

typedef struct IrisWindowCollection {
  IrisWindow *windows;
  unsigned int length;
} IrisWindowCollection;

#if (defined(__APPLE__) && TARGET_OS_MAC && !TARGET_OS_IPHONE)                 \
    || defined(_WIN32)
IRIS_API IrisDisplayCollection *EnumerateDisplays();

IRIS_API void FreeIrisDisplayCollection(IrisDisplayCollection *collection);

IRIS_API IrisWindowCollection *EnumerateWindows();

IRIS_API void FreeIrisWindowCollection(IrisWindowCollection *collection);
#endif

#ifdef __cplusplus
}
#endif

#endif//IRIS_BASE_H_
