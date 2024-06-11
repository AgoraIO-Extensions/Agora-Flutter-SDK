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
      status:
          $enumDecodeNullable(_$MusicCacheStatusTypeEnumMap, json['status']),
    );

Map<String, dynamic> _$MusicCacheInfoToJson(MusicCacheInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('songCode', instance.songCode);
  writeNotNull('status', _$MusicCacheStatusTypeEnumMap[instance.status]);
  return val;
}

const _$MusicCacheStatusTypeEnumMap = {
  MusicCacheStatusType.musicCacheStatusTypeCached: 0,
  MusicCacheStatusType.musicCacheStatusTypeCaching: 1,
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

MusicContentCenterConfiguration _$MusicContentCenterConfigurationFromJson(
        Map<String, dynamic> json) =>
    MusicContentCenterConfiguration(
      appId: json['appId'] as String?,
      token: json['token'] as String?,
      mccUid: (json['mccUid'] as num?)?.toInt(),
      maxCacheSize: (json['maxCacheSize'] as num?)?.toInt(),
      mccDomain: json['mccDomain'] as String?,
    );

Map<String, dynamic> _$MusicContentCenterConfigurationToJson(
    MusicContentCenterConfiguration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('appId', instance.appId);
  writeNotNull('token', instance.token);
  writeNotNull('mccUid', instance.mccUid);
  writeNotNull('maxCacheSize', instance.maxCacheSize);
  writeNotNull('mccDomain', instance.mccDomain);
  return val;
}

const _$MusicPlayModeEnumMap = {
  MusicPlayMode.kMusicPlayModeOriginal: 0,
  MusicPlayMode.kMusicPlayModeAccompany: 1,
  MusicPlayMode.kMusicPlayModeLeadSing: 2,
};

const _$PreloadStateEnumMap = {
  PreloadState.kPreloadStateCompleted: 0,
  PreloadState.kPreloadStateFailed: 1,
  PreloadState.kPreloadStatePreloading: 2,
  PreloadState.kPreloadStateRemoved: 3,
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
