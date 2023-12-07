#ifndef __IRIS_PLATFORM_H__
#define __IRIS_PLATFORM_H__

#include <stdint.h>
#if defined(__APPLE__)
#include <TargetConditionals.h>
#endif

#ifdef __cplusplus
#define EXTERN_C extern "C"
#define EXTERN_C_ENTER extern "C" {
#define EXTERN_C_LEAVE }
#else
#define EXTERN_C
#define EXTERN_C_ENTER
#define EXTERN_C_LEAVE
#endif

#ifdef __GNUC__
#define AGORA_GCC_VERSION_AT_LEAST(x, y)                                       \
  (__GNUC__ > (x) || __GNUC__ == (x) && __GNUC_MINOR__ >= (y))
#else
#define AGORA_GCC_VERSION_AT_LEAST(x, y) 0
#endif

#if defined(_WIN32)
#define IRIS_CALL __cdecl
#if defined(IRIS_EXPORT)
#define IRIS_API EXTERN_C __declspec(dllexport)
#define IRIS_CPP_API __declspec(dllexport)
#else
#define IRIS_API EXTERN_C __declspec(dllimport)
#define IRIS_CPP_API __declspec(dllimport)
#endif
#elif defined(__APPLE__)
#if AGORA_GCC_VERSION_AT_LEAST(3, 3)
#define IRIS_API __attribute__((visibility("default"))) EXTERN_C
#define IRIS_CPP_API __attribute__((visibility("default")))
#else
#define IRIS_API EXTERN_C
#define IRIS_CPP_API
#endif
#define IRIS_CALL
#elif defined(__ANDROID__) || defined(__linux__)
#if AGORA_GCC_VERSION_AT_LEAST(3, 3)
#define IRIS_API EXTERN_C __attribute__((visibility("default")))
#define IRIS_CPP_API __attribute__((visibility("default")))
#else
#define IRIS_API EXTERN_C
#define IRIS_CPP_API
#endif
#define IRIS_CALL
#else
#define IRIS_API EXTERN_C
#define IRIS_CPP_API
#define IRIS_CALL
#endif

#if AGORA_GCC_VERSION_AT_LEAST(3, 1)
#define IRIS_DEPRECATED __attribute__((deprecated))
#elif defined(_MSC_VER)
#define IRIS_DEPRECATED
#else
#define IRIS_DEPRECATED
#endif

#if defined(__GUNC__)
#define COMPILER_IS_GCC
#if defined(__MINGW32__) || defined(__MINGW64__)
#define COMPILER_IS_MINGW
#endif
#if defined(__MSYS__)
#define COMPILER_ON_MSYS
#endif
#if defined(__CYGWIN__) || defined(__CYGWIN32__)
#define COMPILER_ON_CYGWIN
#endif
#if defined(__clang__)
#define COMPILER_IS_CLANG
#endif
#elif defined(_MSC_VER)
#define COMPILER_IS_MSVC
#else
#define COMPILER_IS_UNKNOWN
#endif

#if defined(_WIN32) || defined(WIN32)
#define OS_WIN
#elif defined(__APPLE__)
#if TARGET_IPHONE_SIMULATOR
#define OS_IPHONE_SIMULATOR
#elif TARGET_OS_MACCATALYST
#define OS_MAC_CATALYST
#elif TARGET_OS_IPHONE
#define OS_IPHONE
#elif TARGET_OS_MAC
#define OS_MAC
#else
#error "unknown apple platform"
#endif
#elif defined(__linux__) && defined(__ANDROID__)
#define OS_ANDROID
#elif defined(__linux__)
#define OS_LUNUX
#else
#error "unknown compiler"
#endif

#endif