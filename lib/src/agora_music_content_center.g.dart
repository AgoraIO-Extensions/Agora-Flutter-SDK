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

Map<String, dynamic> _$MusicChartInfoToJson(MusicChartInfo instance) =>
    <String, dynamic>{
      if (instance.chartName case final value?) 'chartName': value,
      if (instance.id case final value?) 'id': value,
    };

MusicCacheInfo _$MusicCacheInfoFromJson(Map<String, dynamic> json) =>
    MusicCacheInfo(
      songCode: (json['songCode'] as num?)?.toInt(),
      status:
          $enumDecodeNullable(_$MusicCacheStatusTypeEnumMap, json['status']),
    );

Map<String, dynamic> _$MusicCacheInfoToJson(MusicCacheInfo instance) =>
    <String, dynamic>{
      if (instance.songCode case final value?) 'songCode': value,
      if (_$MusicCacheStatusTypeEnumMap[instance.status] case final value?)
        'status': value,
    };

const _$MusicCacheStatusTypeEnumMap = {
  MusicCacheStatusType.musicCacheStatusTypeCached: 0,
  MusicCacheStatusType.musicCacheStatusTypeCaching: 1,
};

MvProperty _$MvPropertyFromJson(Map<String, dynamic> json) => MvProperty(
      resolution: json['resolution'] as String?,
      bandwidth: json['bandwidth'] as String?,
    );

Map<String, dynamic> _$MvPropertyToJson(MvProperty instance) =>
    <String, dynamic>{
      if (instance.resolution case final value?) 'resolution': value,
      if (instance.bandwidth case final value?) 'bandwidth': value,
    };

ClimaxSegment _$ClimaxSegmentFromJson(Map<String, dynamic> json) =>
    ClimaxSegment(
      startTimeMs: (json['startTimeMs'] as num?)?.toInt(),
      endTimeMs: (json['endTimeMs'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ClimaxSegmentToJson(ClimaxSegment instance) =>
    <String, dynamic>{
      if (instance.startTimeMs case final value?) 'startTimeMs': value,
      if (instance.endTimeMs case final value?) 'endTimeMs': value,
    };

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

Map<String, dynamic> _$MusicToJson(Music instance) => <String, dynamic>{
      if (instance.songCode case final value?) 'songCode': value,
      if (instance.name case final value?) 'name': value,
      if (instance.singer case final value?) 'singer': value,
      if (instance.poster case final value?) 'poster': value,
      if (instance.releaseTime case final value?) 'releaseTime': value,
      if (instance.durationS case final value?) 'durationS': value,
      if (instance.type case final value?) 'type': value,
      if (instance.pitchType case final value?) 'pitchType': value,
      if (instance.lyricCount case final value?) 'lyricCount': value,
      if (instance.lyricList case final value?) 'lyricList': value,
      if (instance.climaxSegmentCount case final value?)
        'climaxSegmentCount': value,
      if (instance.climaxSegmentList?.map((e) => e.toJson()).toList()
          case final value?)
        'climaxSegmentList': value,
      if (instance.mvPropertyCount case final value?) 'mvPropertyCount': value,
      if (instance.mvPropertyList?.map((e) => e.toJson()).toList()
          case final value?)
        'mvPropertyList': value,
    };

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
        MusicContentCenterConfiguration instance) =>
    <String, dynamic>{
      if (instance.appId case final value?) 'appId': value,
      if (instance.token case final value?) 'token': value,
      if (instance.mccUid case final value?) 'mccUid': value,
      if (instance.maxCacheSize case final value?) 'maxCacheSize': value,
      if (instance.mccDomain case final value?) 'mccDomain': value,
    };

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
