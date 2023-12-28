
#pragma once

#include "iris_rtc_c_api.h"

struct IrisSpatialAudioZone {
  //the zone id
  int zoneSetId;
  //zone center point
  float position[3];
  //forward direction
  float forward[3];
  //right direction
  float right[3];
  //up direction
  float up[3];
  //the forward side length of the zone
  float forwardLength;
  //tehe right side length of the zone
  float rightLength;
  //the up side length of the zone
  float upLength;
  //the audio attenuation of zone
  float audioAttenuation;
};

EXTERN_C_ENTER

IRIS_API int IRIS_CALL ILocalSpatialAudioEngine_SetMaxAudioRecvCount(
    IrisApiEnginePtr enginePtr, int maxCount);

IRIS_API int IRIS_CALL ILocalSpatialAudioEngine_SetAudioRecvRange(
    IrisApiEnginePtr enginePtr, float range);

IRIS_API int IRIS_CALL ILocalSpatialAudioEngine_SetDistanceUnit(
    IrisApiEnginePtr enginePtr, float unit);

IRIS_API int IRIS_CALL ILocalSpatialAudioEngine_UpdateSelfPosition(
    IrisApiEnginePtr enginePtr, float positionX, float positionY,
    float positionZ, float axisForwardX, float axisForwardY, float axisForwardZ,
    float axisRightX, float axisRightY, float axisRightZ, float axisUpX,
    float axisUpY, float axisUpZ);

IRIS_API int IRIS_CALL ILocalSpatialAudioEngine_UpdateSelfPositionEx(
    IrisApiEnginePtr enginePtr, float positionX, float positionY,
    float positionZ, float axisForwardX, float axisForwardY, float axisForwardZ,
    float axisRightX, float axisRightY, float axisRightZ, float axisUpX,
    float axisUpY, float axisUpZ, char *channelId, unsigned int localUid);

IRIS_API int IRIS_CALL ILocalSpatialAudioEngine_UpdatePlayerPositionInfo(
    IrisApiEnginePtr enginePtr, int playerId, float positionX, float positionY,
    float positionZ, float forwardX, float forwardY, float forwardZ);

IRIS_API int IRIS_CALL ILocalSpatialAudioEngine_MuteLocalAudioStream(
    IrisApiEnginePtr enginePtr, bool mute);

IRIS_API int IRIS_CALL ILocalSpatialAudioEngine_MuteAllRemoteAudioStreams(
    IrisApiEnginePtr enginePtr, bool mute);

IRIS_API int IRIS_CALL ILocalSpatialAudioEngine_SetZones(
    IrisApiEnginePtr enginePtr, IrisSpatialAudioZone *zones,
    unsigned int zoneCount);

IRIS_API int IRIS_CALL ILocalSpatialAudioEngine_SetPlayerAttenuation(
    IrisApiEnginePtr enginePtr, int playerId, double attenuation,
    bool forceSet);

IRIS_API int IRIS_CALL ILocalSpatialAudioEngine_MuteRemoteAudioStream(
    IrisApiEnginePtr enginePtr, unsigned int uid, bool mute);

IRIS_API int IRIS_CALL ILocalSpatialAudioEngine_UpdateRemotePosition(
    IrisApiEnginePtr enginePtr, unsigned int uid, float positionX,
    float positionY, float positionZ, float forwardX, float forwardY,
    float forwardZ);

IRIS_API int IRIS_CALL ILocalSpatialAudioEngine_UpdateRemotePositionEx(
    IrisApiEnginePtr enginePtr, unsigned int uid, float positionX,
    float positionY, float positionZ, float forwardX, float forwardY,
    float forwardZ, char *channelId, unsigned int localUid);

IRIS_API int IRIS_CALL ILocalSpatialAudioEngine_RemoveRemotePosition(
    IrisApiEnginePtr enginePtr, unsigned int uid);

IRIS_API int IRIS_CALL ILocalSpatialAudioEngine_RemoveRemotePositionEx(
    IrisApiEnginePtr enginePtr, unsigned int uid, char *channelId,
    unsigned int localUid);

IRIS_API int IRIS_CALL
ILocalSpatialAudioEngine_ClearRemotePositions(IrisApiEnginePtr enginePtr);

IRIS_API int IRIS_CALL ILocalSpatialAudioEngine_ClearRemotePositionsEx(
    IrisApiEnginePtr enginePtr, char *channelId, unsigned int localUid);

IRIS_API int IRIS_CALL ILocalSpatialAudioEngine_SetRemoteAudioAttenuation(
    IrisApiEnginePtr enginePtr, unsigned int uid, double attenuation,
    bool forceSet);

EXTERN_C_LEAVE
