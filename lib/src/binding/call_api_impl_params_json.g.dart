// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names, deprecated_member_use_from_same_package, unused_element

part of 'call_api_impl_params_json.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaPlayerGetDurationJson _$MediaPlayerGetDurationJsonFromJson(
        Map<String, dynamic> json) =>
    MediaPlayerGetDurationJson(
      (json['duration'] as num).toInt(),
    );

Map<String, dynamic> _$MediaPlayerGetDurationJsonToJson(
        MediaPlayerGetDurationJson instance) =>
    <String, dynamic>{
      'duration': instance.duration,
    };

MediaPlayerGetPlayPositionJson _$MediaPlayerGetPlayPositionJsonFromJson(
        Map<String, dynamic> json) =>
    MediaPlayerGetPlayPositionJson(
      (json['pos'] as num).toInt(),
    );

Map<String, dynamic> _$MediaPlayerGetPlayPositionJsonToJson(
        MediaPlayerGetPlayPositionJson instance) =>
    <String, dynamic>{
      'pos': instance.pos,
    };

MediaPlayerGetStreamCountJson _$MediaPlayerGetStreamCountJsonFromJson(
        Map<String, dynamic> json) =>
    MediaPlayerGetStreamCountJson(
      (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$MediaPlayerGetStreamCountJsonToJson(
        MediaPlayerGetStreamCountJson instance) =>
    <String, dynamic>{
      'count': instance.count,
    };

MediaPlayerGetStreamInfoJson _$MediaPlayerGetStreamInfoJsonFromJson(
        Map<String, dynamic> json) =>
    MediaPlayerGetStreamInfoJson(
      PlayerStreamInfo.fromJson(json['info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MediaPlayerGetStreamInfoJsonToJson(
        MediaPlayerGetStreamInfoJson instance) =>
    <String, dynamic>{
      'info': instance.info.toJson(),
    };

MediaPlayerGetMuteJson _$MediaPlayerGetMuteJsonFromJson(
        Map<String, dynamic> json) =>
    MediaPlayerGetMuteJson(
      json['muted'] as bool,
    );

Map<String, dynamic> _$MediaPlayerGetMuteJsonToJson(
        MediaPlayerGetMuteJson instance) =>
    <String, dynamic>{
      'muted': instance.muted,
    };

MediaPlayerGetPlayoutVolumeJson _$MediaPlayerGetPlayoutVolumeJsonFromJson(
        Map<String, dynamic> json) =>
    MediaPlayerGetPlayoutVolumeJson(
      (json['volume'] as num).toInt(),
    );

Map<String, dynamic> _$MediaPlayerGetPlayoutVolumeJsonToJson(
        MediaPlayerGetPlayoutVolumeJson instance) =>
    <String, dynamic>{
      'volume': instance.volume,
    };

MediaPlayerGetPublishSignalVolumeJson
    _$MediaPlayerGetPublishSignalVolumeJsonFromJson(
            Map<String, dynamic> json) =>
        MediaPlayerGetPublishSignalVolumeJson(
          (json['volume'] as num).toInt(),
        );

Map<String, dynamic> _$MediaPlayerGetPublishSignalVolumeJsonToJson(
        MediaPlayerGetPublishSignalVolumeJson instance) =>
    <String, dynamic>{
      'volume': instance.volume,
    };

MediaPlayerCacheManagerGetCacheDirJson
    _$MediaPlayerCacheManagerGetCacheDirJsonFromJson(
            Map<String, dynamic> json) =>
        MediaPlayerCacheManagerGetCacheDirJson(
          json['path'] as String,
        );

Map<String, dynamic> _$MediaPlayerCacheManagerGetCacheDirJsonToJson(
        MediaPlayerCacheManagerGetCacheDirJson instance) =>
    <String, dynamic>{
      'path': instance.path,
    };

MusicContentCenterGetMusicChartsJson
    _$MusicContentCenterGetMusicChartsJsonFromJson(Map<String, dynamic> json) =>
        MusicContentCenterGetMusicChartsJson(
          json['requestId'] as String,
        );

Map<String, dynamic> _$MusicContentCenterGetMusicChartsJsonToJson(
        MusicContentCenterGetMusicChartsJson instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
    };

MusicContentCenterGetMusicCollectionByMusicChartIdJson
    _$MusicContentCenterGetMusicCollectionByMusicChartIdJsonFromJson(
            Map<String, dynamic> json) =>
        MusicContentCenterGetMusicCollectionByMusicChartIdJson(
          json['requestId'] as String,
        );

Map<String, dynamic>
    _$MusicContentCenterGetMusicCollectionByMusicChartIdJsonToJson(
            MusicContentCenterGetMusicCollectionByMusicChartIdJson instance) =>
        <String, dynamic>{
          'requestId': instance.requestId,
        };

MusicContentCenterSearchMusicJson _$MusicContentCenterSearchMusicJsonFromJson(
        Map<String, dynamic> json) =>
    MusicContentCenterSearchMusicJson(
      json['requestId'] as String,
    );

Map<String, dynamic> _$MusicContentCenterSearchMusicJsonToJson(
        MusicContentCenterSearchMusicJson instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
    };

MusicContentCenterPreloadJson _$MusicContentCenterPreloadJsonFromJson(
        Map<String, dynamic> json) =>
    MusicContentCenterPreloadJson(
      json['requestId'] as String,
    );

Map<String, dynamic> _$MusicContentCenterPreloadJsonToJson(
        MusicContentCenterPreloadJson instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
    };

MusicContentCenterGetCachesJson _$MusicContentCenterGetCachesJsonFromJson(
        Map<String, dynamic> json) =>
    MusicContentCenterGetCachesJson(
      (json['cacheInfo'] as List<dynamic>)
          .map((e) => MusicCacheInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MusicContentCenterGetCachesJsonToJson(
        MusicContentCenterGetCachesJson instance) =>
    <String, dynamic>{
      'cacheInfo': instance.cacheInfo.map((e) => e.toJson()).toList(),
    };

MusicContentCenterGetLyricJson _$MusicContentCenterGetLyricJsonFromJson(
        Map<String, dynamic> json) =>
    MusicContentCenterGetLyricJson(
      json['requestId'] as String,
    );

Map<String, dynamic> _$MusicContentCenterGetLyricJsonToJson(
        MusicContentCenterGetLyricJson instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
    };

MusicContentCenterGetSongSimpleInfoJson
    _$MusicContentCenterGetSongSimpleInfoJsonFromJson(
            Map<String, dynamic> json) =>
        MusicContentCenterGetSongSimpleInfoJson(
          json['requestId'] as String,
        );

Map<String, dynamic> _$MusicContentCenterGetSongSimpleInfoJsonToJson(
        MusicContentCenterGetSongSimpleInfoJson instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
    };

MusicContentCenterGetInternalSongCodeJson
    _$MusicContentCenterGetInternalSongCodeJsonFromJson(
            Map<String, dynamic> json) =>
        MusicContentCenterGetInternalSongCodeJson(
          (json['internalSongCode'] as num).toInt(),
        );

Map<String, dynamic> _$MusicContentCenterGetInternalSongCodeJsonToJson(
        MusicContentCenterGetInternalSongCodeJson instance) =>
    <String, dynamic>{
      'internalSongCode': instance.internalSongCode,
    };

VideoDeviceManagerGetDeviceJson _$VideoDeviceManagerGetDeviceJsonFromJson(
        Map<String, dynamic> json) =>
    VideoDeviceManagerGetDeviceJson(
      json['deviceIdUTF8'] as String,
    );

Map<String, dynamic> _$VideoDeviceManagerGetDeviceJsonToJson(
        VideoDeviceManagerGetDeviceJson instance) =>
    <String, dynamic>{
      'deviceIdUTF8': instance.deviceIdUTF8,
    };

VideoDeviceManagerGetCapabilityJson
    _$VideoDeviceManagerGetCapabilityJsonFromJson(Map<String, dynamic> json) =>
        VideoDeviceManagerGetCapabilityJson(
          VideoFormat.fromJson(json['capability'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$VideoDeviceManagerGetCapabilityJsonToJson(
        VideoDeviceManagerGetCapabilityJson instance) =>
    <String, dynamic>{
      'capability': instance.capability.toJson(),
    };

RtcEngineQueryCodecCapabilityJson _$RtcEngineQueryCodecCapabilityJsonFromJson(
        Map<String, dynamic> json) =>
    RtcEngineQueryCodecCapabilityJson(
      (json['codecInfo'] as List<dynamic>)
          .map((e) => CodecCapInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RtcEngineQueryCodecCapabilityJsonToJson(
        RtcEngineQueryCodecCapabilityJson instance) =>
    <String, dynamic>{
      'codecInfo': instance.codecInfo.map((e) => e.toJson()).toList(),
    };

RtcEngineGetFaceShapeBeautyOptionsJson
    _$RtcEngineGetFaceShapeBeautyOptionsJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineGetFaceShapeBeautyOptionsJson(
          FaceShapeBeautyOptions.fromJson(
              json['options'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$RtcEngineGetFaceShapeBeautyOptionsJsonToJson(
        RtcEngineGetFaceShapeBeautyOptionsJson instance) =>
    <String, dynamic>{
      'options': instance.options.toJson(),
    };

RtcEngineGetFaceShapeAreaOptionsJson
    _$RtcEngineGetFaceShapeAreaOptionsJsonFromJson(Map<String, dynamic> json) =>
        RtcEngineGetFaceShapeAreaOptionsJson(
          FaceShapeAreaOptions.fromJson(
              json['options'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$RtcEngineGetFaceShapeAreaOptionsJsonToJson(
        RtcEngineGetFaceShapeAreaOptionsJson instance) =>
    <String, dynamic>{
      'options': instance.options.toJson(),
    };

RtcEngineUploadLogFileJson _$RtcEngineUploadLogFileJsonFromJson(
        Map<String, dynamic> json) =>
    RtcEngineUploadLogFileJson(
      json['requestId'] as String,
    );

Map<String, dynamic> _$RtcEngineUploadLogFileJsonToJson(
        RtcEngineUploadLogFileJson instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
    };

RtcEngineGetExtensionPropertyJson _$RtcEngineGetExtensionPropertyJsonFromJson(
        Map<String, dynamic> json) =>
    RtcEngineGetExtensionPropertyJson(
      json['value'] as String,
    );

Map<String, dynamic> _$RtcEngineGetExtensionPropertyJsonToJson(
        RtcEngineGetExtensionPropertyJson instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

RtcEngineGetAudioDeviceInfoJson _$RtcEngineGetAudioDeviceInfoJsonFromJson(
        Map<String, dynamic> json) =>
    RtcEngineGetAudioDeviceInfoJson(
      DeviceInfo.fromJson(json['deviceInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RtcEngineGetAudioDeviceInfoJsonToJson(
        RtcEngineGetAudioDeviceInfoJson instance) =>
    <String, dynamic>{
      'deviceInfo': instance.deviceInfo.toJson(),
    };

RtcEngineQueryCameraFocalLengthCapabilityJson
    _$RtcEngineQueryCameraFocalLengthCapabilityJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineQueryCameraFocalLengthCapabilityJson(
          (json['focalLengthInfos'] as List<dynamic>)
              .map((e) => FocalLengthInfo.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$RtcEngineQueryCameraFocalLengthCapabilityJsonToJson(
        RtcEngineQueryCameraFocalLengthCapabilityJson instance) =>
    <String, dynamic>{
      'focalLengthInfos':
          instance.focalLengthInfos.map((e) => e.toJson()).toList(),
    };

RtcEngineGetCallIdJson _$RtcEngineGetCallIdJsonFromJson(
        Map<String, dynamic> json) =>
    RtcEngineGetCallIdJson(
      json['callId'] as String,
    );

Map<String, dynamic> _$RtcEngineGetCallIdJsonToJson(
        RtcEngineGetCallIdJson instance) =>
    <String, dynamic>{
      'callId': instance.callId,
    };

RtcEngineCreateDataStreamJson _$RtcEngineCreateDataStreamJsonFromJson(
        Map<String, dynamic> json) =>
    RtcEngineCreateDataStreamJson(
      (json['streamId'] as num).toInt(),
    );

Map<String, dynamic> _$RtcEngineCreateDataStreamJsonToJson(
        RtcEngineCreateDataStreamJson instance) =>
    <String, dynamic>{
      'streamId': instance.streamId,
    };

RtcEngineGetUserInfoByUserAccountJson
    _$RtcEngineGetUserInfoByUserAccountJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineGetUserInfoByUserAccountJson(
          UserInfo.fromJson(json['userInfo'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$RtcEngineGetUserInfoByUserAccountJsonToJson(
        RtcEngineGetUserInfoByUserAccountJson instance) =>
    <String, dynamic>{
      'userInfo': instance.userInfo.toJson(),
    };

RtcEngineGetUserInfoByUidJson _$RtcEngineGetUserInfoByUidJsonFromJson(
        Map<String, dynamic> json) =>
    RtcEngineGetUserInfoByUidJson(
      UserInfo.fromJson(json['userInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RtcEngineGetUserInfoByUidJsonToJson(
        RtcEngineGetUserInfoByUidJson instance) =>
    <String, dynamic>{
      'userInfo': instance.userInfo.toJson(),
    };

RtcEngineQueryHDRCapabilityJson _$RtcEngineQueryHDRCapabilityJsonFromJson(
        Map<String, dynamic> json) =>
    RtcEngineQueryHDRCapabilityJson(
      $enumDecode(_$HdrCapabilityEnumMap, json['capability']),
    );

Map<String, dynamic> _$RtcEngineQueryHDRCapabilityJsonToJson(
        RtcEngineQueryHDRCapabilityJson instance) =>
    <String, dynamic>{
      'capability': _$HdrCapabilityEnumMap[instance.capability]!,
    };

const _$HdrCapabilityEnumMap = {
  HdrCapability.hdrCapabilityUnknown: -1,
  HdrCapability.hdrCapabilityUnsupported: 0,
  HdrCapability.hdrCapabilitySupported: 1,
};

RtcEngineExCreateDataStreamExJson _$RtcEngineExCreateDataStreamExJsonFromJson(
        Map<String, dynamic> json) =>
    RtcEngineExCreateDataStreamExJson(
      (json['streamId'] as num).toInt(),
    );

Map<String, dynamic> _$RtcEngineExCreateDataStreamExJsonToJson(
        RtcEngineExCreateDataStreamExJson instance) =>
    <String, dynamic>{
      'streamId': instance.streamId,
    };

RtcEngineExGetUserInfoByUserAccountExJson
    _$RtcEngineExGetUserInfoByUserAccountExJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineExGetUserInfoByUserAccountExJson(
          UserInfo.fromJson(json['userInfo'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$RtcEngineExGetUserInfoByUserAccountExJsonToJson(
        RtcEngineExGetUserInfoByUserAccountExJson instance) =>
    <String, dynamic>{
      'userInfo': instance.userInfo.toJson(),
    };

RtcEngineExGetUserInfoByUidExJson _$RtcEngineExGetUserInfoByUidExJsonFromJson(
        Map<String, dynamic> json) =>
    RtcEngineExGetUserInfoByUidExJson(
      UserInfo.fromJson(json['userInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RtcEngineExGetUserInfoByUidExJsonToJson(
        RtcEngineExGetUserInfoByUidExJson instance) =>
    <String, dynamic>{
      'userInfo': instance.userInfo.toJson(),
    };

RtcEngineExGetCallIdExJson _$RtcEngineExGetCallIdExJsonFromJson(
        Map<String, dynamic> json) =>
    RtcEngineExGetCallIdExJson(
      json['callId'] as String,
    );

Map<String, dynamic> _$RtcEngineExGetCallIdExJsonToJson(
        RtcEngineExGetCallIdExJson instance) =>
    <String, dynamic>{
      'callId': instance.callId,
    };

AudioDeviceManagerGetPlaybackDeviceJson
    _$AudioDeviceManagerGetPlaybackDeviceJsonFromJson(
            Map<String, dynamic> json) =>
        AudioDeviceManagerGetPlaybackDeviceJson(
          json['deviceId'] as String,
        );

Map<String, dynamic> _$AudioDeviceManagerGetPlaybackDeviceJsonToJson(
        AudioDeviceManagerGetPlaybackDeviceJson instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
    };

AudioDeviceManagerGetPlaybackDeviceVolumeJson
    _$AudioDeviceManagerGetPlaybackDeviceVolumeJsonFromJson(
            Map<String, dynamic> json) =>
        AudioDeviceManagerGetPlaybackDeviceVolumeJson(
          (json['volume'] as num).toInt(),
        );

Map<String, dynamic> _$AudioDeviceManagerGetPlaybackDeviceVolumeJsonToJson(
        AudioDeviceManagerGetPlaybackDeviceVolumeJson instance) =>
    <String, dynamic>{
      'volume': instance.volume,
    };

AudioDeviceManagerGetRecordingDeviceJson
    _$AudioDeviceManagerGetRecordingDeviceJsonFromJson(
            Map<String, dynamic> json) =>
        AudioDeviceManagerGetRecordingDeviceJson(
          json['deviceId'] as String,
        );

Map<String, dynamic> _$AudioDeviceManagerGetRecordingDeviceJsonToJson(
        AudioDeviceManagerGetRecordingDeviceJson instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
    };

AudioDeviceManagerGetRecordingDeviceVolumeJson
    _$AudioDeviceManagerGetRecordingDeviceVolumeJsonFromJson(
            Map<String, dynamic> json) =>
        AudioDeviceManagerGetRecordingDeviceVolumeJson(
          (json['volume'] as num).toInt(),
        );

Map<String, dynamic> _$AudioDeviceManagerGetRecordingDeviceVolumeJsonToJson(
        AudioDeviceManagerGetRecordingDeviceVolumeJson instance) =>
    <String, dynamic>{
      'volume': instance.volume,
    };

AudioDeviceManagerGetLoopbackDeviceJson
    _$AudioDeviceManagerGetLoopbackDeviceJsonFromJson(
            Map<String, dynamic> json) =>
        AudioDeviceManagerGetLoopbackDeviceJson(
          json['deviceId'] as String,
        );

Map<String, dynamic> _$AudioDeviceManagerGetLoopbackDeviceJsonToJson(
        AudioDeviceManagerGetLoopbackDeviceJson instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
    };

AudioDeviceManagerGetPlaybackDeviceMuteJson
    _$AudioDeviceManagerGetPlaybackDeviceMuteJsonFromJson(
            Map<String, dynamic> json) =>
        AudioDeviceManagerGetPlaybackDeviceMuteJson(
          json['mute'] as bool,
        );

Map<String, dynamic> _$AudioDeviceManagerGetPlaybackDeviceMuteJsonToJson(
        AudioDeviceManagerGetPlaybackDeviceMuteJson instance) =>
    <String, dynamic>{
      'mute': instance.mute,
    };

AudioDeviceManagerGetRecordingDeviceMuteJson
    _$AudioDeviceManagerGetRecordingDeviceMuteJsonFromJson(
            Map<String, dynamic> json) =>
        AudioDeviceManagerGetRecordingDeviceMuteJson(
          json['mute'] as bool,
        );

Map<String, dynamic> _$AudioDeviceManagerGetRecordingDeviceMuteJsonToJson(
        AudioDeviceManagerGetRecordingDeviceMuteJson instance) =>
    <String, dynamic>{
      'mute': instance.mute,
    };
