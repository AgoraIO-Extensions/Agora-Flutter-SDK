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

Map<String, dynamic> _$PlayerStreamInfoToJson(PlayerStreamInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('streamIndex', instance.streamIndex);
  writeNotNull('streamType', _$MediaStreamTypeEnumMap[instance.streamType]);
  writeNotNull('codecName', instance.codecName);
  writeNotNull('language', instance.language);
  writeNotNull('videoFrameRate', instance.videoFrameRate);
  writeNotNull('videoBitRate', instance.videoBitRate);
  writeNotNull('videoWidth', instance.videoWidth);
  writeNotNull('videoHeight', instance.videoHeight);
  writeNotNull('videoRotation', instance.videoRotation);
  writeNotNull('audioSampleRate', instance.audioSampleRate);
  writeNotNull('audioChannels', instance.audioChannels);
  writeNotNull('audioBitsPerSample', instance.audioBitsPerSample);
  writeNotNull('duration', instance.duration);
  return val;
}

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

Map<String, dynamic> _$SrcInfoToJson(SrcInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('bitrateInKbps', instance.bitrateInKbps);
  writeNotNull('name', instance.name);
  return val;
}

CacheStatistics _$CacheStatisticsFromJson(Map<String, dynamic> json) =>
    CacheStatistics(
      fileSize: json['fileSize'] as int?,
      cacheSize: json['cacheSize'] as int?,
      downloadSize: json['downloadSize'] as int?,
    );

Map<String, dynamic> _$CacheStatisticsToJson(CacheStatistics instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fileSize', instance.fileSize);
  writeNotNull('cacheSize', instance.cacheSize);
  writeNotNull('downloadSize', instance.downloadSize);
  return val;
}

PlayerUpdatedInfo _$PlayerUpdatedInfoFromJson(Map<String, dynamic> json) =>
    PlayerUpdatedInfo(
      playerId: json['playerId'] as String?,
      deviceId: json['deviceId'] as String?,
      cacheStatistics: json['cacheStatistics'] == null
          ? null
          : CacheStatistics.fromJson(
              json['cacheStatistics'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlayerUpdatedInfoToJson(PlayerUpdatedInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('playerId', instance.playerId);
  writeNotNull('deviceId', instance.deviceId);
  writeNotNull('cacheStatistics', instance.cacheStatistics?.toJson());
  return val;
}

MediaSource _$MediaSourceFromJson(Map<String, dynamic> json) => MediaSource(
      url: json['url'] as String?,
      uri: json['uri'] as String?,
      startPos: json['startPos'] as int?,
      autoPlay: json['autoPlay'] as bool?,
      enableCache: json['enableCache'] as bool?,
      isAgoraSource: json['isAgoraSource'] as bool?,
      isLiveSource: json['isLiveSource'] as bool?,
    );

Map<String, dynamic> _$MediaSourceToJson(MediaSource instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('url', instance.url);
  writeNotNull('uri', instance.uri);
  writeNotNull('startPos', instance.startPos);
  writeNotNull('autoPlay', instance.autoPlay);
  writeNotNull('enableCache', instance.enableCache);
  writeNotNull('isAgoraSource', instance.isAgoraSource);
  writeNotNull('isLiveSource', instance.isLiveSource);
  return val;
}

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
  MediaPlayerEvent.playerEventReachCacheFileMaxCount: 14,
  MediaPlayerEvent.playerEventReachCacheFileMaxSize: 15,
  MediaPlayerEvent.playerEventTryOpenStart: 16,
  MediaPlayerEvent.playerEventTryOpenSucceed: 17,
  MediaPlayerEvent.playerEventTryOpenFailed: 18,
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
