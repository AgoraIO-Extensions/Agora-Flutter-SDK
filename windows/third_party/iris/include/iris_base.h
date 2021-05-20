//
// Created by LXH on 2021/5/10.
//

#ifndef IRIS_BASE_H_
#define IRIS_BASE_H_

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

const int kBasicResultLength = 512;
const int kMaxResultLength = 2048;

#endif//IRIS_BASE_H_
