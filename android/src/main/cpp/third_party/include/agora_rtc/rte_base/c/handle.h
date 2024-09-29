/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include <stdbool.h>

#include "utils/uuid.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef struct RteHandle {
  RteUuid uuid;
} RteHandle;

typedef struct Rte {
  RteHandle handle;
} Rte;

typedef struct RtePlayer {
  RteHandle handle;
} RtePlayer;

typedef struct RteChannel {
  RteHandle handle;
} RteChannel;

typedef struct RteUser {
  RteHandle handle;
} RteUser;

typedef struct RteLocalUser {
  RteHandle handle;
} RteLocalUser;

typedef struct RteRemoteUser {
  RteHandle handle;
} RteRemoteUser;

typedef struct RteTrack {
  RteHandle handle;
} RteTrack;

typedef struct RteLocalTrack {
  RteHandle handle;
} RteLocalTrack;

typedef struct RteRemoteTrack {
  RteHandle handle;
} RteRemoteTrack;

typedef struct RteVideoTrack {
  RteHandle handle;
} RteVideoTrack;

typedef struct RteAudioTrack {
  RteHandle handle;
} RteAudioTrack;

typedef struct RteDataTrack {
  RteHandle handle;
} RteDataTrack;

typedef struct RteLocalVideoTrack {
  RteHandle handle;
} RteLocalVideoTrack;

typedef struct RteRemoteVideoTrack {
  RteHandle handle;
} RteRemoteVideoTrack;

typedef struct RteCameraVideoTrack {
  RteHandle handle;
} RteCameraVideoTrack;

typedef struct RteMixedVideoTrack {
  RteHandle handle;
} RteMixedVideoTrack;

typedef struct RteScreenVideoTrack {
  RteHandle handle;
} RteScreenVideoTrack;

typedef struct RteLocalAudioTrack {
  RteHandle handle;
} RteLocalAudioTrack;

typedef struct RteRemoteAudioTrack {
  RteHandle handle;
} RteRemoteAudioTrack;

typedef struct RteMicAudioTrack {
  RteHandle handle;
} RteMicAudioTrack;

typedef struct RteLocalDataTrack {
  RteHandle handle;
} RteLocalDataTrack;

typedef struct RteRemoteDataTrack {
  RteHandle handle;
} RteRemoteDataTrack;

typedef struct RteCanvas {
  RteHandle handle;
} RteCanvas;

typedef struct RteAudioDevice {
  RteHandle handle;
} RteAudioDevice;

typedef struct RteVideoDevice {
  RteHandle handle;
} RteVideoDevice;

typedef struct RteRealTimeStream {
  RteHandle handle;
} RteRealTimeStream;

typedef struct RteCdnStream {
  RteHandle handle;
} RteCdnStream;

typedef struct RteLocalStream {
  RteHandle handle;
} RteLocalStream;

typedef struct RteRemoteStream {
  RteHandle handle;
} RteRemoteStream;

typedef struct RteLocalCdnStream {
  RteHandle handle;
} RteLocalCdnStream;

typedef struct RteLocalRealTimeStream {
  RteHandle handle;
} RteLocalRealTimeStream;

typedef struct RteRemoteCdnStream {
  RteHandle handle;
} RteRemoteCdnStream;

typedef struct RteRemoteRealTimeStream {
  RteHandle handle;
} RteRemoteRealTimeStream;

#ifdef __cplusplus
}
#endif  // __cplusplus
