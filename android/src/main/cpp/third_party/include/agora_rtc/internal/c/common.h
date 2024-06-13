/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#if defined(_WIN32)

#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif  // !WIN32_LEAN_AND_MEAN
#if defined(__aarch64__)
#include <arm64intr.h>
#endif
#include <Windows.h>

#ifdef AGORARTC_EXPORT
#define AGORA_RTE_API_C __declspec(dllexport)
#else
#define AGORA_RTE_API_C __declspec(dllimport)
#endif  // AGORARTC_EXPORT

#define AGORA_CALL_C __cdecl

#elif defined(__APPLE__)

#include <TargetConditionals.h>

#define AGORA_RTE_API_C __attribute__((visibility("default")))

#elif defined(__ANDROID__) || defined(__linux__)

#define AGORA_RTE_API_C __attribute__((visibility("default")))

#else  // !_WIN32 && !__APPLE__ && !(__ANDROID__ || __linux__)

#define AGORA_RTE_API_C

#endif  // _WIN32

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef enum RteAreaCode {
  kRteAreaCodeCn = 0x00000001,
  kRteAreaCodeNa = 0x00000002,
  kRteAreaCodeEu = 0x00000004,
  kRteAreaCodeAs = 0x00000008,
  kRteAreaCodeJp = 0x00000010,
  kRteAreaCodeIn = 0x00000020,
  kRteAreaCodeGlob = 0xFFFFFFFF
} RteAreaCode;

#ifdef __cplusplus
}
#endif  // __cplusplus
