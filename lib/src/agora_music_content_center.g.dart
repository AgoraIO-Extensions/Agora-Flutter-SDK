// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names, deprecated_member_use_from_same_package, unused_element

part of 'agora_music_content_center.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicChartInfo _$MusicChartInfoFromJson(Map<String, dynamic> json) =>
    MusicChartInfo(
      chartName: json['chartName'] as String?,
      id: json['id'] as int?,
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
      startTimeMs: json['startTimeMs'] as int?,
      endTimeMs: json['endTimeMs'] as int?,
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
      songCode: json['songCode'] as int?,
      name: json['name'] as String?,
      singer: json['singer'] as String?,
      poster: json['poster'] as String?,
      releaseTime: json['releaseTime'] as String?,
      durationS: json['durationS'] as int?,
      type: json['type'] as int?,
      pitchType: json['pitchType'] as int?,
      lyricCount: json['lyricCount'] as int?,
      lyricList:
          (json['lyricList'] as List<dynamic>?)?.map((e) => e as int).toList(),
      climaxSegmentCount: json['climaxSegmentCount'] as int?,
      climaxSegmentList: (json['climaxSegmentList'] as List<dynamic>?)
          ?.map((e) => ClimaxSegment.fromJson(e as Map<String, dynamic>))
          .toList(),
      mvPropertyCount: json['mvPropertyCount'] as int?,
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
      rtmToken: json['rtmToken'] as String?,
      mccUid: json['mccUid'] as int?,
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
  writeNotNull('rtmToken', instance.rtmToken);
  writeNotNull('mccUid', instance.mccUid);
  return val;
}

const _$PreloadStatusCodeEnumMap = {
  PreloadStatusCode.kPreloadStatusCompleted: 0,
  PreloadStatusCode.kPreloadStatusFailed: 1,
  PreloadStatusCode.kPreloadStatusPreloading: 2,
};

const _$MusicContentCenterStatusCodeEnumMap = {
  MusicContentCenterStatusCode.kMusicContentCenterStatusOk: 0,
  MusicContentCenterStatusCode.kMusicContentCenterStatusErr: 1,
};
