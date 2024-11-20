import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_music_content_center.g.dart';

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum MusicPlayMode {
  /// @nodoc
  @JsonValue(0)
  kMusicPlayModeOriginal,

  /// @nodoc
  @JsonValue(1)
  kMusicPlayModeAccompany,

  /// @nodoc
  @JsonValue(2)
  kMusicPlayModeLeadSing,
}

/// @nodoc
extension MusicPlayModeExt on MusicPlayMode {
  /// @nodoc
  static MusicPlayMode fromValue(int value) {
    return $enumDecode(_$MusicPlayModeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$MusicPlayModeEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum PreloadState {
  /// @nodoc
  @JsonValue(0)
  kPreloadStateCompleted,

  /// @nodoc
  @JsonValue(1)
  kPreloadStateFailed,

  /// @nodoc
  @JsonValue(2)
  kPreloadStatePreloading,

  /// @nodoc
  @JsonValue(3)
  kPreloadStateRemoved,
}

/// @nodoc
extension PreloadStateExt on PreloadState {
  /// @nodoc
  static PreloadState fromValue(int value) {
    return $enumDecode(_$PreloadStateEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$PreloadStateEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum MusicContentCenterStateReason {
  /// @nodoc
  @JsonValue(0)
  kMusicContentCenterReasonOk,

  /// @nodoc
  @JsonValue(1)
  kMusicContentCenterReasonError,

  /// @nodoc
  @JsonValue(2)
  kMusicContentCenterReasonGateway,

  /// @nodoc
  @JsonValue(3)
  kMusicContentCenterReasonPermissionAndResource,

  /// @nodoc
  @JsonValue(4)
  kMusicContentCenterReasonInternalDataParse,

  /// @nodoc
  @JsonValue(5)
  kMusicContentCenterReasonMusicLoading,

  /// @nodoc
  @JsonValue(6)
  kMusicContentCenterReasonMusicDecryption,

  /// @nodoc
  @JsonValue(7)
  kMusicContentCenterReasonHttpInternalError,
}

/// @nodoc
extension MusicContentCenterStateReasonExt on MusicContentCenterStateReason {
  /// @nodoc
  static MusicContentCenterStateReason fromValue(int value) {
    return $enumDecode(_$MusicContentCenterStateReasonEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$MusicContentCenterStateReasonEnumMap[this]!;
  }
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MusicChartInfo {
  /// @nodoc
  const MusicChartInfo({this.chartName, this.id});

  /// @nodoc
  @JsonKey(name: 'chartName')
  final String? chartName;

  /// @nodoc
  @JsonKey(name: 'id')
  final int? id;

  /// @nodoc
  factory MusicChartInfo.fromJson(Map<String, dynamic> json) =>
      _$MusicChartInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$MusicChartInfoToJson(this);
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum MusicCacheStatusType {
  /// @nodoc
  @JsonValue(0)
  musicCacheStatusTypeCached,

  /// @nodoc
  @JsonValue(1)
  musicCacheStatusTypeCaching,
}

/// @nodoc
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

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MusicCacheInfo {
  /// @nodoc
  const MusicCacheInfo({this.songCode, this.status});

  /// @nodoc
  @JsonKey(name: 'songCode')
  final int? songCode;

  /// @nodoc
  @JsonKey(name: 'status')
  final MusicCacheStatusType? status;

  /// @nodoc
  factory MusicCacheInfo.fromJson(Map<String, dynamic> json) =>
      _$MusicCacheInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$MusicCacheInfoToJson(this);
}

/// @nodoc
abstract class MusicChartCollection {
  /// @nodoc
  Future<int> getCount();

  /// @nodoc
  Future<MusicChartInfo> get(int index);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MvProperty {
  /// @nodoc
  const MvProperty({this.resolution, this.bandwidth});

  /// @nodoc
  @JsonKey(name: 'resolution')
  final String? resolution;

  /// @nodoc
  @JsonKey(name: 'bandwidth')
  final String? bandwidth;

  /// @nodoc
  factory MvProperty.fromJson(Map<String, dynamic> json) =>
      _$MvPropertyFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$MvPropertyToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ClimaxSegment {
  /// @nodoc
  const ClimaxSegment({this.startTimeMs, this.endTimeMs});

  /// @nodoc
  @JsonKey(name: 'startTimeMs')
  final int? startTimeMs;

  /// @nodoc
  @JsonKey(name: 'endTimeMs')
  final int? endTimeMs;

  /// @nodoc
  factory ClimaxSegment.fromJson(Map<String, dynamic> json) =>
      _$ClimaxSegmentFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ClimaxSegmentToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Music {
  /// @nodoc
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

  /// @nodoc
  @JsonKey(name: 'songCode')
  final int? songCode;

  /// @nodoc
  @JsonKey(name: 'name')
  final String? name;

  /// @nodoc
  @JsonKey(name: 'singer')
  final String? singer;

  /// @nodoc
  @JsonKey(name: 'poster')
  final String? poster;

  /// @nodoc
  @JsonKey(name: 'releaseTime')
  final String? releaseTime;

  /// @nodoc
  @JsonKey(name: 'durationS')
  final int? durationS;

  /// @nodoc
  @JsonKey(name: 'type')
  final int? type;

  /// @nodoc
  @JsonKey(name: 'pitchType')
  final int? pitchType;

  /// @nodoc
  @JsonKey(name: 'lyricCount')
  final int? lyricCount;

  /// @nodoc
  @JsonKey(name: 'lyricList')
  final List<int>? lyricList;

  /// @nodoc
  @JsonKey(name: 'climaxSegmentCount')
  final int? climaxSegmentCount;

  /// @nodoc
  @JsonKey(name: 'climaxSegmentList')
  final List<ClimaxSegment>? climaxSegmentList;

  /// @nodoc
  @JsonKey(name: 'mvPropertyCount')
  final int? mvPropertyCount;

  /// @nodoc
  @JsonKey(name: 'mvPropertyList')
  final List<MvProperty>? mvPropertyList;

  /// @nodoc
  factory Music.fromJson(Map<String, dynamic> json) => _$MusicFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$MusicToJson(this);
}

/// @nodoc
abstract class MusicCollection {
  /// @nodoc
  int getCount();

  /// @nodoc
  int getTotal();

  /// @nodoc
  int getPage();

  /// @nodoc
  int getPageSize();

  /// @nodoc
  Music getMusic(int index);
}

/// @nodoc
class MusicContentCenterEventHandler {
  /// @nodoc
  const MusicContentCenterEventHandler({
    this.onMusicChartsResult,
    this.onMusicCollectionResult,
    this.onLyricResult,
    this.onSongSimpleInfoResult,
    this.onPreLoadEvent,
  });

  /// @nodoc
  final void Function(String requestId, List<MusicChartInfo> result,
      MusicContentCenterStateReason reason)? onMusicChartsResult;

  /// @nodoc
  final void Function(String requestId, MusicCollection result,
      MusicContentCenterStateReason reason)? onMusicCollectionResult;

  /// @nodoc
  final void Function(String requestId, int songCode, String lyricUrl,
      MusicContentCenterStateReason reason)? onLyricResult;

  /// 音乐资源的详细信息回调。
  ///
  /// 当你调用 getSongSimpleInfo 获取某一音乐资源的详细信息后，SDK 会触发该回调。
  ///
  /// * [reason] 音乐内容中心的请求状态码，详见 MusicContentCenterStateReason 。
  /// * [requestId] The request ID. 本次请求的唯一标识。
  /// * [songCode] The code of the music, which is an unique identifier of the music.
  /// * [simpleInfo] 音乐资源的相关信息，包含下列内容：
  ///  副歌片段的开始和结束的时间（ms）
  ///  副歌片段的歌词下载地址
  ///  副歌片段时长（ms）
  ///  歌曲名称
  ///  歌手名
  final void Function(String requestId, int songCode, String simpleInfo,
      MusicContentCenterStateReason reason)? onSongSimpleInfoResult;

  /// @nodoc
  final void Function(
      String requestId,
      int songCode,
      int percent,
      String lyricUrl,
      PreloadState state,
      MusicContentCenterStateReason reason)? onPreLoadEvent;
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MusicContentCenterConfiguration {
  /// @nodoc
  const MusicContentCenterConfiguration(
      {this.appId, this.token, this.mccUid, this.maxCacheSize, this.mccDomain});

  /// @nodoc
  @JsonKey(name: 'appId')
  final String? appId;

  /// @nodoc
  @JsonKey(name: 'token')
  final String? token;

  /// @nodoc
  @JsonKey(name: 'mccUid')
  final int? mccUid;

  /// @nodoc
  @JsonKey(name: 'maxCacheSize')
  final int? maxCacheSize;

  /// @nodoc
  @JsonKey(name: 'mccDomain')
  final String? mccDomain;

  /// @nodoc
  factory MusicContentCenterConfiguration.fromJson(Map<String, dynamic> json) =>
      _$MusicContentCenterConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() =>
      _$MusicContentCenterConfigurationToJson(this);
}

/// @nodoc
abstract class MusicPlayer implements MediaPlayer {
  /// @nodoc
  Future<void> setPlayMode(MusicPlayMode mode);

  /// @nodoc
  Future<void> openWithSongCode({required int songCode, int startPos = 0});
}

/// @nodoc
abstract class MusicContentCenter {
  /// @nodoc
  Future<void> initialize(MusicContentCenterConfiguration configuration);

  /// @nodoc
  Future<void> renewToken(String token);

  /// @nodoc
  Future<void> release();

  /// @nodoc
  void registerEventHandler(MusicContentCenterEventHandler eventHandler);

  /// @nodoc
  void unregisterEventHandler();

  /// @nodoc
  Future<MusicPlayer?> createMusicPlayer();

  /// @nodoc
  Future<void> destroyMusicPlayer(MusicPlayer musicPlayer);

  /// @nodoc
  Future<String> getMusicCharts();

  /// @nodoc
  Future<String> getMusicCollectionByMusicChartId(
      {required int musicChartId,
      required int page,
      required int pageSize,
      String? jsonOption});

  /// @nodoc
  Future<String> searchMusic(
      {required String keyWord,
      required int page,
      required int pageSize,
      String? jsonOption});

  /// @nodoc
  Future<String> preload(int songCode);

  /// @nodoc
  Future<void> removeCache(int songCode);

  /// @nodoc
  Future<List<MusicCacheInfo>> getCaches(int cacheInfoSize);

  /// @nodoc
  Future<bool> isPreloaded(int songCode);

  /// @nodoc
  Future<String> getLyric({required int songCode, int lyricType = 0});

  /// @nodoc
  Future<String> getSongSimpleInfo(int songCode);

  /// @nodoc
  Future<int> getInternalSongCode(
      {required int songCode, required String jsonOption});
}
