// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names, deprecated_member_use_from_same_package, unused_element

part of 'agora_media_player_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerStreamInfo _$PlayerStreamInfoFromJson(Map<String, dynamic> json) =>
    PlayerStreamInfo(
      streamIndex: json['streamIndex'] as int?,
      streamType:
          $enumDecodeNullable(_$MediaStreamTypeEnumMap, json['streamType']),
      codecName: json['codecName'] as String?,
      language: json['language'] as String?,
      videoFrameRate: json['videoFrameRate'] as int?,
      videoBitRate: json['videoBitRate'] as int?,
      videoWidth: json['videoWidth'] as int?,
      videoHeight: json['videoHeight'] as int?,
      videoRotation: json['videoRotation'] as int?,
      audioSampleRate: json['audioSampleRate'] as int?,
      audioChannels: json['audioChannels'] as int?,
      audioBitsPerSample: json['audioBitsPerSample'] as int?,
      duration: json['duration'] as int?,
    );

Map<String, dynamic> _$PlayerStreamInfoToJson(PlayerStreamInfo instance) =>
    <String, dynamic>{
      'streamIndex': instance.streamIndex,
      'streamType': _$MediaStreamTypeEnumMap[instance.streamType],
      'codecName': instance.codecName,
      'language': instance.language,
      'videoFrameRate': instance.videoFrameRate,
      'videoBitRate': instance.videoBitRate,
      'videoWidth': instance.videoWidth,
      'videoHeight': instance.videoHeight,
      'videoRotation': instance.videoRotation,
      'audioSampleRate': instance.audioSampleRate,
      'audioChannels': instance.audioChannels,
      'audioBitsPerSample': instance.audioBitsPerSample,
      'duration': instance.duration,
    };

const _$MediaStreamTypeEnumMap = {
  MediaStreamType.streamTypeUnknown: 0,
  MediaStreamType.streamTypeVideo: 1,
  MediaStreamType.streamTypeAudio: 2,
  MediaStreamType.streamTypeSubtitle: 3,
};

SrcInfo _$SrcInfoFromJson(Map<String, dynamic> json) => SrcInfo(
      bitrateInKbps: json['bitrateInKbps'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$SrcInfoToJson(SrcInfo instance) => <String, dynamic>{
      'bitrateInKbps': instance.bitrateInKbps,
      'name': instance.name,
    };

PlayerUpdatedInfo _$PlayerUpdatedInfoFromJson(Map<String, dynamic> json) =>
    PlayerUpdatedInfo(
      playerId: json['playerId'] as String?,
      deviceId: json['deviceId'] as String?,
    );

Map<String, dynamic> _$PlayerUpdatedInfoToJson(PlayerUpdatedInfo instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'deviceId': instance.deviceId,
    };

const _$MediaPlayerStateEnumMap = {
  MediaPlayerState.playerStateIdle: 0,
  MediaPlayerState.playerStateOpening: 1,
  MediaPlayerState.playerStateOpenCompleted: 2,
  MediaPlayerState.playerStatePlaying: 3,
  MediaPlayerState.playerStatePaused: 4,
  MediaPlayerState.playerStatePlaybackCompleted: 5,
  MediaPlayerState.playerStatePlaybackAllLoopsCompleted: 6,
  MediaPlayerState.playerStateStopped: 7,
  MediaPlayerState.playerStatePausingInternal: 50,
  MediaPlayerState.playerStateStoppingInternal: 51,
  MediaPlayerState.playerStateSeekingInternal: 52,
  MediaPlayerState.playerStateGettingInternal: 53,
  MediaPlayerState.playerStateNoneInternal: 54,
  MediaPlayerState.playerStateDoNothingInternal: 55,
  MediaPlayerState.playerStateSetTrackInternal: 56,
  MediaPlayerState.playerStateFailed: 100,
};

const _$MediaPlayerErrorEnumMap = {
  MediaPlayerError.playerErrorNone: 0,
  MediaPlayerError.playerErrorInvalidArguments: -1,
  MediaPlayerError.playerErrorInternal: -2,
  MediaPlayerError.playerErrorNoResource: -3,
  MediaPlayerError.playerErrorInvalidMediaSource: -4,
  MediaPlayerError.playerErrorUnknownStreamType: -5,
  MediaPlayerError.playerErrorObjNotInitialized: -6,
  MediaPlayerError.playerErrorCodecNotSupported: -7,
  MediaPlayerError.playerErrorVideoRenderFailed: -8,
  MediaPlayerError.playerErrorInvalidState: -9,
  MediaPlayerError.playerErrorUrlNotFound: -10,
  MediaPlayerError.playerErrorInvalidConnectionState: -11,
  MediaPlayerError.playerErrorSrcBufferUnderflow: -12,
  MediaPlayerError.playerErrorInterrupted: -13,
  MediaPlayerError.playerErrorNotSupported: -14,
  MediaPlayerError.playerErrorTokenExpired: -15,
  MediaPlayerError.playerErrorIpExpired: -16,
  MediaPlayerError.playerErrorUnknown: -17,
};

const _$MediaPlayerEventEnumMap = {
  MediaPlayerEvent.playerEventSeekBegin: 0,
  MediaPlayerEvent.playerEventSeekComplete: 1,
  MediaPlayerEvent.playerEventSeekError: 2,
  MediaPlayerEvent.playerEventAudioTrackChanged: 5,
  MediaPlayerEvent.playerEventBufferLow: 6,
  MediaPlayerEvent.playerEventBufferRecover: 7,
  MediaPlayerEvent.playerEventFreezeStart: 8,
  MediaPlayerEvent.playerEventFreezeStop: 9,
  MediaPlayerEvent.playerEventSwitchBegin: 10,
  MediaPlayerEvent.playerEventSwitchComplete: 11,
  MediaPlayerEvent.playerEventSwitchError: 12,
  MediaPlayerEvent.playerEventFirstDisplayed: 13,
};

const _$PlayerPreloadEventEnumMap = {
  PlayerPreloadEvent.playerPreloadEventBegin: 0,
  PlayerPreloadEvent.playerPreloadEventComplete: 1,
  PlayerPreloadEvent.playerPreloadEventError: 2,
};

const _$MediaPlayerMetadataTypeEnumMap = {
  MediaPlayerMetadataType.playerMetadataTypeUnknown: 0,
  MediaPlayerMetadataType.playerMetadataTypeSei: 1,
};
