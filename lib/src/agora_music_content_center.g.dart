// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names, deprecated_member_use_from_same_package, unused_element

part of 'agora_music_content_center.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicChartInfo _$MusicChartInfoFromJson(Map<String, dynamic> json) =>
    MusicChartInfo(
      chartName: json['chartName'] as String?,
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MusicChartInfoToJson(MusicChartInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('chartName', instance.chartName);
  writeNotNull('id', instance.id);
  return val;
}

MusicCacheInfo _$MusicCacheInfoFromJson(Map<String, dynamic> json) =>
    MusicCacheInfo(
      songCode: (json['songCode'] as num?)?.toInt(),
      musicStatus: $enumDecodeNullable(
          _$MusicCacheStatusTypeEnumMap, json['musicStatus']),
      lyricStatus: $enumDecodeNullable(
          _$MusicCacheStatusTypeEnumMap, json['lyricStatus']),
    );

Map<String, dynamic> _$MusicCacheInfoToJson(MusicCacheInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('songCode', instance.songCode);
  writeNotNull(
      'musicStatus', _$MusicCacheStatusTypeEnumMap[instance.musicStatus]);
  writeNotNull(
      'lyricStatus', _$MusicCacheStatusTypeEnumMap[instance.lyricStatus]);
  return val;
}

const _$MusicCacheStatusTypeEnumMap = {
  MusicCacheStatusType.musicCacheStatusTypeCached: 0,
  MusicCacheStatusType.musicCacheStatusTypeCaching: 1,
  MusicCacheStatusType.musicCacheStatusTypeNoCached: 2,
  MusicCacheStatusType.musicCacheStatusTypeNoResource: 3,
};

MvProperty _$MvPropertyFromJson(Map<String, dynamic> json) => MvProperty(
      resolution: json['resolution'] as String?,
      bandwidth: json['bandwidth'] as String?,
    );

Map<String, dynamic> _$MvPropertyToJson(MvProperty instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('resolution', instance.resolution);
  writeNotNull('bandwidth', instance.bandwidth);
  return val;
}

ClimaxSegment _$ClimaxSegmentFromJson(Map<String, dynamic> json) =>
    ClimaxSegment(
      startTimeMs: (json['startTimeMs'] as num?)?.toInt(),
      endTimeMs: (json['endTimeMs'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ClimaxSegmentToJson(ClimaxSegment instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('startTimeMs', instance.startTimeMs);
  writeNotNull('endTimeMs', instance.endTimeMs);
  return val;
}

Music _$MusicFromJson(Map<String, dynamic> json) => Music(
      songCode: (json['songCode'] as num?)?.toInt(),
      name: json['name'] as String?,
      singer: json['singer'] as String?,
      poster: json['poster'] as String?,
      releaseTime: json['releaseTime'] as String?,
      durationS: (json['durationS'] as num?)?.toInt(),
      type: (json['type'] as num?)?.toInt(),
      pitchType: (json['pitchType'] as num?)?.toInt(),
      lyricCount: (json['lyricCount'] as num?)?.toInt(),
      lyricList: (json['lyricList'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      climaxSegmentCount: (json['climaxSegmentCount'] as num?)?.toInt(),
      climaxSegmentList: (json['climaxSegmentList'] as List<dynamic>?)
          ?.map((e) => ClimaxSegment.fromJson(e as Map<String, dynamic>))
          .toList(),
      mvPropertyCount: (json['mvPropertyCount'] as num?)?.toInt(),
      mvPropertyList: (json['mvPropertyList'] as List<dynamic>?)
          ?.map((e) => MvProperty.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MusicToJson(Music instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('songCode', instance.songCode);
  writeNotNull('name', instance.name);
  writeNotNull('singer', instance.singer);
  writeNotNull('poster', instance.poster);
  writeNotNull('releaseTime', instance.releaseTime);
  writeNotNull('durationS', instance.durationS);
  writeNotNull('type', instance.type);
  writeNotNull('pitchType', instance.pitchType);
  writeNotNull('lyricCount', instance.lyricCount);
  writeNotNull('lyricList', instance.lyricList);
  writeNotNull('climaxSegmentCount', instance.climaxSegmentCount);
  writeNotNull('climaxSegmentList',
      instance.climaxSegmentList?.map((e) => e.toJson()).toList());
  writeNotNull('mvPropertyCount', instance.mvPropertyCount);
  writeNotNull('mvPropertyList',
      instance.mvPropertyList?.map((e) => e.toJson()).toList());
  return val;
}

RawScoreData _$RawScoreDataFromJson(Map<String, dynamic> json) => RawScoreData(
      progressInMs: (json['progressInMs'] as num?)?.toInt(),
      speakerPitch: (json['speakerPitch'] as num?)?.toDouble(),
      pitchScore: (json['pitchScore'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RawScoreDataToJson(RawScoreData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('progressInMs', instance.progressInMs);
  writeNotNull('speakerPitch', instance.speakerPitch);
  writeNotNull('pitchScore', instance.pitchScore);
  return val;
}

LineScoreData _$LineScoreDataFromJson(Map<String, dynamic> json) =>
    LineScoreData(
      progressInMs: (json['progressInMs'] as num?)?.toInt(),
      index: (json['index'] as num?)?.toInt(),
      totalLines: (json['totalLines'] as num?)?.toInt(),
      pitchScore: (json['pitchScore'] as num?)?.toDouble(),
      cumulativePitchScore: (json['cumulativePitchScore'] as num?)?.toDouble(),
      energyScore: (json['energyScore'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$LineScoreDataToJson(LineScoreData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('progressInMs', instance.progressInMs);
  writeNotNull('index', instance.index);
  writeNotNull('totalLines', instance.totalLines);
  writeNotNull('pitchScore', instance.pitchScore);
  writeNotNull('cumulativePitchScore', instance.cumulativePitchScore);
  writeNotNull('energyScore', instance.energyScore);
  return val;
}

CumulativeScoreData _$CumulativeScoreDataFromJson(Map<String, dynamic> json) =>
    CumulativeScoreData(
      progressInMs: (json['progressInMs'] as num?)?.toInt(),
      cumulativePitchScore: (json['cumulativePitchScore'] as num?)?.toDouble(),
      energyScore: (json['energyScore'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CumulativeScoreDataToJson(CumulativeScoreData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('progressInMs', instance.progressInMs);
  writeNotNull('cumulativePitchScore', instance.cumulativePitchScore);
  writeNotNull('energyScore', instance.energyScore);
  return val;
}

MusicContentCenterConfiguration _$MusicContentCenterConfigurationFromJson(
        Map<String, dynamic> json) =>
    MusicContentCenterConfiguration(
      maxCacheSize: (json['maxCacheSize'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MusicContentCenterConfigurationToJson(
    MusicContentCenterConfiguration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('maxCacheSize', instance.maxCacheSize);
  return val;
}

MusicContentCenterVendorDefaultConfiguration
    _$MusicContentCenterVendorDefaultConfigurationFromJson(
            Map<String, dynamic> json) =>
        MusicContentCenterVendorDefaultConfiguration(
          appId: json['appId'] as String?,
          token: json['token'] as String?,
          userId: json['userId'] as String?,
          mccDomain: json['mccDomain'] as String?,
        );

Map<String, dynamic> _$MusicContentCenterVendorDefaultConfigurationToJson(
    MusicContentCenterVendorDefaultConfiguration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('appId', instance.appId);
  writeNotNull('token', instance.token);
  writeNotNull('userId', instance.userId);
  writeNotNull('mccDomain', instance.mccDomain);
  return val;
}

MusicContentCenterVendor2Configuration
    _$MusicContentCenterVendor2ConfigurationFromJson(
            Map<String, dynamic> json) =>
        MusicContentCenterVendor2Configuration(
          appId: json['appId'] as String?,
          appKey: json['appKey'] as String?,
          token: json['token'] as String?,
          userId: json['userId'] as String?,
          roomId: json['roomId'] as String?,
          deviceId: json['deviceId'] as String?,
          urlTokenExpireTime: (json['urlTokenExpireTime'] as num?)?.toInt(),
          chargeMode: (json['chargeMode'] as num?)?.toInt(),
        );

Map<String, dynamic> _$MusicContentCenterVendor2ConfigurationToJson(
    MusicContentCenterVendor2Configuration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('appId', instance.appId);
  writeNotNull('appKey', instance.appKey);
  writeNotNull('token', instance.token);
  writeNotNull('userId', instance.userId);
  writeNotNull('roomId', instance.roomId);
  writeNotNull('deviceId', instance.deviceId);
  writeNotNull('urlTokenExpireTime', instance.urlTokenExpireTime);
  writeNotNull('chargeMode', instance.chargeMode);
  return val;
}

const _$MusicContentCenterVendorIDEnumMap = {
  MusicContentCenterVendorID.kMusicContentCenterVendorDefault: 1,
  MusicContentCenterVendorID.kMusicContentCenterVendor2: 2,
};

const _$MusicPlayModeEnumMap = {
  MusicPlayMode.kMusicPlayModeOriginal: 0,
  MusicPlayMode.kMusicPlayModeAccompany: 1,
  MusicPlayMode.kMusicPlayModeLeadSing: 2,
};

const _$MusicContentCenterStateEnumMap = {
  MusicContentCenterState.kMusicContentCenterStatePreloadOk: 0,
  MusicContentCenterState.kMusicContentCenterStatePreloadFailed: 1,
  MusicContentCenterState.kMusicContentCenterStatePreloading: 2,
  MusicContentCenterState.kMusicContentCenterStatePreloadRemoved: 3,
  MusicContentCenterState.kMusicContentCenterStateStartScoreCompleted: 4,
  MusicContentCenterState.kMusicContentCenterStateStartScoreFailed: 5,
};

const _$MusicContentCenterStateReasonEnumMap = {
  MusicContentCenterStateReason.kMusicContentCenterReasonOk: 0,
  MusicContentCenterStateReason.kMusicContentCenterReasonError: 1,
  MusicContentCenterStateReason.kMusicContentCenterReasonGateway: 2,
  MusicContentCenterStateReason.kMusicContentCenterReasonPermissionAndResource:
      3,
  MusicContentCenterStateReason.kMusicContentCenterReasonInternalDataParse: 4,
  MusicContentCenterStateReason.kMusicContentCenterReasonMusicLoading: 5,
  MusicContentCenterStateReason.kMusicContentCenterReasonMusicDecryption: 6,
  MusicContentCenterStateReason.kMusicContentCenterReasonHttpInternalError: 7,
};

const _$LyricSourceTypeEnumMap = {
  LyricSourceType.kLyricSourceXml: 0,
  LyricSourceType.kLyricSourceLrc: 1,
  LyricSourceType.kLyricSourceLrcWithPitches: 2,
  LyricSourceType.kLyricSourceKrc: 3,
};

const _$ScoreLevelEnumMap = {
  ScoreLevel.kScoreLevel1: 1,
  ScoreLevel.kScoreLevel2: 2,
  ScoreLevel.kScoreLevel3: 3,
  ScoreLevel.kScoreLevel4: 4,
  ScoreLevel.kScoreLevel5: 5,
};

const _$ChargeModeEnumMap = {
  ChargeMode.kChargeModeMonthly: 1,
  ChargeMode.kChargeModeOnce: 2,
};
