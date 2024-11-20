// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names, deprecated_member_use_from_same_package, unused_element

part of 'agora_media_player_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerStreamInfo _$PlayerStreamInfoFromJson(Map<String, dynamic> json) =>
    PlayerStreamInfo(
      streamIndex: (json['streamIndex'] as num?)?.toInt(),
      streamType:
          $enumDecodeNullable(_$MediaStreamTypeEnumMap, json['streamType']),
      codecName: json['codecName'] as String?,
      language: json['language'] as String?,
      videoFrameRate: (json['videoFrameRate'] as num?)?.toInt(),
      videoBitRate: (json['videoBitRate'] as num?)?.toInt(),
      videoWidth: (json['videoWidth'] as num?)?.toInt(),
      videoHeight: (json['videoHeight'] as num?)?.toInt(),
      videoRotation: (json['videoRotation'] as num?)?.toInt(),
      audioSampleRate: (json['audioSampleRate'] as num?)?.toInt(),
      audioChannels: (json['audioChannels'] as num?)?.toInt(),
      audioBitsPerSample: (json['audioBitsPerSample'] as num?)?.toInt(),
      duration: (json['duration'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PlayerStreamInfoToJson(PlayerStreamInfo instance) =>
    <String, dynamic>{
      if (instance.streamIndex case final value?) 'streamIndex': value,
      if (_$MediaStreamTypeEnumMap[instance.streamType] case final value?)
        'streamType': value,
      if (instance.codecName case final value?) 'codecName': value,
      if (instance.language case final value?) 'language': value,
      if (instance.videoFrameRate case final value?) 'videoFrameRate': value,
      if (instance.videoBitRate case final value?) 'videoBitRate': value,
      if (instance.videoWidth case final value?) 'videoWidth': value,
      if (instance.videoHeight case final value?) 'videoHeight': value,
      if (instance.videoRotation case final value?) 'videoRotation': value,
      if (instance.audioSampleRate case final value?) 'audioSampleRate': value,
      if (instance.audioChannels case final value?) 'audioChannels': value,
      if (instance.audioBitsPerSample case final value?)
        'audioBitsPerSample': value,
      if (instance.duration case final value?) 'duration': value,
    };

const _$MediaStreamTypeEnumMap = {
  MediaStreamType.streamTypeUnknown: 0,
  MediaStreamType.streamTypeVideo: 1,
  MediaStreamType.streamTypeAudio: 2,
  MediaStreamType.streamTypeSubtitle: 3,
};

SrcInfo _$SrcInfoFromJson(Map<String, dynamic> json) => SrcInfo(
      bitrateInKbps: (json['bitrateInKbps'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$SrcInfoToJson(SrcInfo instance) => <String, dynamic>{
      if (instance.bitrateInKbps case final value?) 'bitrateInKbps': value,
      if (instance.name case final value?) 'name': value,
    };

CacheStatistics _$CacheStatisticsFromJson(Map<String, dynamic> json) =>
    CacheStatistics(
      fileSize: (json['fileSize'] as num?)?.toInt(),
      cacheSize: (json['cacheSize'] as num?)?.toInt(),
      downloadSize: (json['downloadSize'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CacheStatisticsToJson(CacheStatistics instance) =>
    <String, dynamic>{
      if (instance.fileSize case final value?) 'fileSize': value,
      if (instance.cacheSize case final value?) 'cacheSize': value,
      if (instance.downloadSize case final value?) 'downloadSize': value,
    };

PlayerPlaybackStats _$PlayerPlaybackStatsFromJson(Map<String, dynamic> json) =>
    PlayerPlaybackStats(
      videoFps: (json['videoFps'] as num?)?.toInt(),
      videoBitrateInKbps: (json['videoBitrateInKbps'] as num?)?.toInt(),
      audioBitrateInKbps: (json['audioBitrateInKbps'] as num?)?.toInt(),
      totalBitrateInKbps: (json['totalBitrateInKbps'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PlayerPlaybackStatsToJson(
        PlayerPlaybackStats instance) =>
    <String, dynamic>{
      if (instance.videoFps case final value?) 'videoFps': value,
      if (instance.videoBitrateInKbps case final value?)
        'videoBitrateInKbps': value,
      if (instance.audioBitrateInKbps case final value?)
        'audioBitrateInKbps': value,
      if (instance.totalBitrateInKbps case final value?)
        'totalBitrateInKbps': value,
    };

PlayerUpdatedInfo _$PlayerUpdatedInfoFromJson(Map<String, dynamic> json) =>
    PlayerUpdatedInfo(
      internalPlayerUuid: json['internalPlayerUuid'] as String?,
      deviceId: json['deviceId'] as String?,
      videoHeight: (json['videoHeight'] as num?)?.toInt(),
      videoWidth: (json['videoWidth'] as num?)?.toInt(),
      audioSampleRate: (json['audioSampleRate'] as num?)?.toInt(),
      audioChannels: (json['audioChannels'] as num?)?.toInt(),
      audioBitsPerSample: (json['audioBitsPerSample'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PlayerUpdatedInfoToJson(PlayerUpdatedInfo instance) =>
    <String, dynamic>{
      if (instance.internalPlayerUuid case final value?)
        'internalPlayerUuid': value,
      if (instance.deviceId case final value?) 'deviceId': value,
      if (instance.videoHeight case final value?) 'videoHeight': value,
      if (instance.videoWidth case final value?) 'videoWidth': value,
      if (instance.audioSampleRate case final value?) 'audioSampleRate': value,
      if (instance.audioChannels case final value?) 'audioChannels': value,
      if (instance.audioBitsPerSample case final value?)
        'audioBitsPerSample': value,
    };

MediaSource _$MediaSourceFromJson(Map<String, dynamic> json) => MediaSource(
      url: json['url'] as String?,
      uri: json['uri'] as String?,
      startPos: (json['startPos'] as num?)?.toInt(),
      autoPlay: json['autoPlay'] as bool?,
      enableCache: json['enableCache'] as bool?,
      enableMultiAudioTrack: json['enableMultiAudioTrack'] as bool?,
      isAgoraSource: json['isAgoraSource'] as bool?,
      isLiveSource: json['isLiveSource'] as bool?,
    );

Map<String, dynamic> _$MediaSourceToJson(MediaSource instance) =>
    <String, dynamic>{
      if (instance.url case final value?) 'url': value,
      if (instance.uri case final value?) 'uri': value,
      if (instance.startPos case final value?) 'startPos': value,
      if (instance.autoPlay case final value?) 'autoPlay': value,
      if (instance.enableCache case final value?) 'enableCache': value,
      if (instance.enableMultiAudioTrack case final value?)
        'enableMultiAudioTrack': value,
      if (instance.isAgoraSource case final value?) 'isAgoraSource': value,
      if (instance.isLiveSource case final value?) 'isLiveSource': value,
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

const _$MediaPlayerReasonEnumMap = {
  MediaPlayerReason.playerReasonNone: 0,
  MediaPlayerReason.playerReasonInvalidArguments: -1,
  MediaPlayerReason.playerReasonInternal: -2,
  MediaPlayerReason.playerReasonNoResource: -3,
  MediaPlayerReason.playerReasonInvalidMediaSource: -4,
  MediaPlayerReason.playerReasonUnknownStreamType: -5,
  MediaPlayerReason.playerReasonObjNotInitialized: -6,
  MediaPlayerReason.playerReasonCodecNotSupported: -7,
  MediaPlayerReason.playerReasonVideoRenderFailed: -8,
  MediaPlayerReason.playerReasonInvalidState: -9,
  MediaPlayerReason.playerReasonUrlNotFound: -10,
  MediaPlayerReason.playerReasonInvalidConnectionState: -11,
  MediaPlayerReason.playerReasonSrcBufferUnderflow: -12,
  MediaPlayerReason.playerReasonInterrupted: -13,
  MediaPlayerReason.playerReasonNotSupported: -14,
  MediaPlayerReason.playerReasonTokenExpired: -15,
  MediaPlayerReason.playerReasonIpExpired: -16,
  MediaPlayerReason.playerReasonUnknown: -17,
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
