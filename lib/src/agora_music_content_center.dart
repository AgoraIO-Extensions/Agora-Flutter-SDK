import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_music_content_center.g.dart';

@JsonEnum(alwaysCreate: true)
enum PreloadStatusCode {
  @JsonValue(0)
  kPreloadStatusCompleted,

  @JsonValue(1)
  kPreloadStatusFailed,

  @JsonValue(2)
  kPreloadStatusPreloading,

  @JsonValue(3)
  kPreloadStatusRemoved,
}

/// Extensions functions of [PreloadStatusCode].
extension PreloadStatusCodeExt on PreloadStatusCode {
  /// @nodoc
  static PreloadStatusCode fromValue(int value) {
    return $enumDecode(_$PreloadStatusCodeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$PreloadStatusCodeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum MusicContentCenterStatusCode {
  @JsonValue(0)
  kMusicContentCenterStatusOk,

  @JsonValue(1)
  kMusicContentCenterStatusErr,

  @JsonValue(2)
  kMusicContentCenterStatusErrGateway,

  @JsonValue(3)
  kMusicContentCenterStatusErrPermissionAndResource,

  @JsonValue(4)
  kMusicContentCenterStatusErrInternalDataParse,

  @JsonValue(5)
  kMusicContentCenterStatusErrMusicLoading,

  @JsonValue(6)
  kMusicContentCenterStatusErrMusicDecryption,

  @JsonValue(7)
  kMusicContentCenterStatusErrHttpInternalError,
}

/// Extensions functions of [MusicContentCenterStatusCode].
extension MusicContentCenterStatusCodeExt on MusicContentCenterStatusCode {
  /// @nodoc
  static MusicContentCenterStatusCode fromValue(int value) {
    return $enumDecode(_$MusicContentCenterStatusCodeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$MusicContentCenterStatusCodeEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MusicChartInfo {
  const MusicChartInfo({this.chartName, this.id});

  @JsonKey(name: 'chartName')
  final String? chartName;

  @JsonKey(name: 'id')
  final int? id;
  factory MusicChartInfo.fromJson(Map<String, dynamic> json) =>
      _$MusicChartInfoFromJson(json);
  Map<String, dynamic> toJson() => _$MusicChartInfoToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum MusicCacheStatusType {
  @JsonValue(0)
  musicCacheStatusTypeCached,

  @JsonValue(1)
  musicCacheStatusTypeCaching,
}

/// Extensions functions of [MusicCacheStatusType].
extension MusicCacheStatusTypeExt on MusicCacheStatusType {
  /// @nodoc
  static MusicCacheStatusType fromValue(int value) {
    return $enumDecode(_$MusicCacheStatusTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$MusicCacheStatusTypeEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MusicCacheInfo {
  const MusicCacheInfo({this.songCode, this.status});

  @JsonKey(name: 'songCode')
  final int? songCode;

  @JsonKey(name: 'status')
  final MusicCacheStatusType? status;
  factory MusicCacheInfo.fromJson(Map<String, dynamic> json) =>
      _$MusicCacheInfoFromJson(json);
  Map<String, dynamic> toJson() => _$MusicCacheInfoToJson(this);
}

abstract class MusicChartCollection {
  Future<int> getCount();

  Future<MusicChartInfo> get(int index);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MvProperty {
  const MvProperty({this.resolution, this.bandwidth});

  @JsonKey(name: 'resolution')
  final String? resolution;

  @JsonKey(name: 'bandwidth')
  final String? bandwidth;
  factory MvProperty.fromJson(Map<String, dynamic> json) =>
      _$MvPropertyFromJson(json);
  Map<String, dynamic> toJson() => _$MvPropertyToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ClimaxSegment {
  const ClimaxSegment({this.startTimeMs, this.endTimeMs});

  @JsonKey(name: 'startTimeMs')
  final int? startTimeMs;

  @JsonKey(name: 'endTimeMs')
  final int? endTimeMs;
  factory ClimaxSegment.fromJson(Map<String, dynamic> json) =>
      _$ClimaxSegmentFromJson(json);
  Map<String, dynamic> toJson() => _$ClimaxSegmentToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Music {
  const Music(
      {this.songCode,
      this.name,
      this.singer,
      this.poster,
      this.releaseTime,
      this.durationS,
      this.type,
      this.pitchType,
      this.lyricCount,
      this.lyricList,
      this.climaxSegmentCount,
      this.climaxSegmentList,
      this.mvPropertyCount,
      this.mvPropertyList});

  @JsonKey(name: 'songCode')
  final int? songCode;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'singer')
  final String? singer;

  @JsonKey(name: 'poster')
  final String? poster;

  @JsonKey(name: 'releaseTime')
  final String? releaseTime;

  @JsonKey(name: 'durationS')
  final int? durationS;

  @JsonKey(name: 'type')
  final int? type;

  @JsonKey(name: 'pitchType')
  final int? pitchType;

  @JsonKey(name: 'lyricCount')
  final int? lyricCount;

  @JsonKey(name: 'lyricList')
  final List<int>? lyricList;

  @JsonKey(name: 'climaxSegmentCount')
  final int? climaxSegmentCount;

  @JsonKey(name: 'climaxSegmentList')
  final List<ClimaxSegment>? climaxSegmentList;

  @JsonKey(name: 'mvPropertyCount')
  final int? mvPropertyCount;

  @JsonKey(name: 'mvPropertyList')
  final List<MvProperty>? mvPropertyList;
  factory Music.fromJson(Map<String, dynamic> json) => _$MusicFromJson(json);
  Map<String, dynamic> toJson() => _$MusicToJson(this);
}

abstract class MusicCollection {
  int getCount();

  int getTotal();

  int getPage();

  int getPageSize();

  Music getMusic(int index);
}

class MusicContentCenterEventHandler {
  /// Construct the [MusicContentCenterEventHandler].
  const MusicContentCenterEventHandler({
    this.onMusicChartsResult,
    this.onMusicCollectionResult,
    this.onLyricResult,
    this.onSongSimpleInfoResult,
    this.onPreLoadEvent,
  });

  final void Function(String requestId, List<MusicChartInfo> result,
      MusicContentCenterStatusCode errorCode)? onMusicChartsResult;

  final void Function(String requestId, MusicCollection result,
      MusicContentCenterStatusCode errorCode)? onMusicCollectionResult;

  final void Function(String requestId, int songCode, String lyricUrl,
      MusicContentCenterStatusCode errorCode)? onLyricResult;

  final void Function(String requestId, int songCode, String simpleInfo,
      MusicContentCenterStatusCode errorCode)? onSongSimpleInfoResult;

  final void Function(
      String requestId,
      int songCode,
      int percent,
      String lyricUrl,
      PreloadStatusCode status,
      MusicContentCenterStatusCode errorCode)? onPreLoadEvent;
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MusicContentCenterConfiguration {
  const MusicContentCenterConfiguration(
      {this.appId, this.token, this.mccUid, this.maxCacheSize, this.mccDomain});

  @JsonKey(name: 'appId')
  final String? appId;

  @JsonKey(name: 'token')
  final String? token;

  @JsonKey(name: 'mccUid')
  final int? mccUid;

  @JsonKey(name: 'maxCacheSize')
  final int? maxCacheSize;

  @JsonKey(name: 'mccDomain')
  final String? mccDomain;
  factory MusicContentCenterConfiguration.fromJson(Map<String, dynamic> json) =>
      _$MusicContentCenterConfigurationFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MusicContentCenterConfigurationToJson(this);
}

abstract class MusicPlayer implements MediaPlayer {
  Future<void> openWithSongCode({required int songCode, int startPos = 0});
}

abstract class MusicContentCenter {
  Future<void> initialize(MusicContentCenterConfiguration configuration);

  Future<void> renewToken(String token);

  Future<void> release();

  void registerEventHandler(MusicContentCenterEventHandler eventHandler);

  void unregisterEventHandler();

  Future<MusicPlayer?> createMusicPlayer();

  Future<String> getMusicCharts();

  Future<String> getMusicCollectionByMusicChartId(
      {required int musicChartId,
      required int page,
      required int pageSize,
      String? jsonOption});

  Future<String> searchMusic(
      {required String keyWord,
      required int page,
      required int pageSize,
      String? jsonOption});

  Future<String> preload(int songCode);

  Future<void> removeCache(int songCode);

  Future<List<MusicCacheInfo>> getCaches(int cacheInfoSize);

  Future<bool> isPreloaded(int songCode);

  Future<String> getLyric({required int songCode, int lyricType = 0});

  Future<String> getSongSimpleInfo(int songCode);

  Future<int> getInternalSongCode(
      {required int songCode, required String jsonOption});
}
