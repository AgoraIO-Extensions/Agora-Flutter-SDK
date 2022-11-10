import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_music_content_center.g.dart';

/// 音乐资源的加载状态。
///
@JsonEnum(alwaysCreate: true)
enum PreloadStatusCode {
  /// 0：音乐资源加载完成。
  @JsonValue(0)
  kPreloadStatusCompleted,

  /// 1：音乐资源加载失败。
  @JsonValue(1)
  kPreloadStatusFailed,

  /// 2：音乐资源正在加载中。
  @JsonValue(2)
  kPreloadStatusPreloading,
}

/// @nodoc
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

/// 音乐内容中心的请求状态码。
///
@JsonEnum(alwaysCreate: true)
enum MusicContentCenterStatusCode {
  /// 0：请求成功。
  @JsonValue(0)
  kMusicContentCenterStatusOk,

  /// 1：请求失败。
  @JsonValue(1)
  kMusicContentCenterStatusErr,
}

/// @nodoc
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

/// 音乐榜单的详细信息。
///
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
abstract class MusicChartCollection {
  /// @nodoc
  Future<int> getCount();

  /// @nodoc
  Future<MusicChartInfo> get(int index);
}

/// MV 的属性。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MvProperty {
  /// @nodoc
  const MvProperty({this.resolution, this.bandwidth});

  /// MV 的分辨率。
  @JsonKey(name: 'resolution')
  final String? resolution;

  /// MV 的带宽，单位为 Kbps。
  @JsonKey(name: 'bandwidth')
  final String? bandwidth;

  /// @nodoc
  factory MvProperty.fromJson(Map<String, dynamic> json) =>
      _$MvPropertyFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$MvPropertyToJson(this);
}

/// 音乐高潮片段设置。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ClimaxSegment {
  /// @nodoc
  const ClimaxSegment({this.startTimeMs, this.endTimeMs});

  /// 音乐高潮片段的开始时间点，单位毫秒。
  @JsonKey(name: 'startTimeMs')
  final int? startTimeMs;

  /// 音乐高潮片段的结束时间点，单位毫秒。
  @JsonKey(name: 'endTimeMs')
  final int? endTimeMs;

  /// @nodoc
  factory ClimaxSegment.fromJson(Map<String, dynamic> json) =>
      _$ClimaxSegmentFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ClimaxSegmentToJson(this);
}

/// 音乐资源的详细信息。
///
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

  /// 音乐资源的编号，用于标识一个音乐资源。
  @JsonKey(name: 'songCode')
  final int? songCode;

  /// 音乐资源名称。
  @JsonKey(name: 'name')
  final String? name;

  /// 歌手名。
  @JsonKey(name: 'singer')
  final String? singer;

  /// 音乐资源海报的下载地址。
  @JsonKey(name: 'poster')
  final String? poster;

  /// 音乐资源发布的时间。
  @JsonKey(name: 'releaseTime')
  final String? releaseTime;

  /// @nodoc
  @JsonKey(name: 'durationS')
  final int? durationS;

  /// 音乐资源类型： 1：左声道伴奏，右声道原唱的单音轨纯音频音源。2：只有伴唱的单音轨纯音频音源。3：只有原唱的单音轨纯音频音源。4：既有多音轨纯音频又有多音轨 MV 资源的音源。5：只有多音轨 MV 资源的音源。6：既有多音轨纯音频又有多音轨 MV 资源的音源（该音源受数字版权保护）。
  @JsonKey(name: 'type')
  final int? type;

  /// 歌曲是否支持演唱评分功能： 1：歌曲支持演唱评分功能。2：歌曲不支持演唱评分功能。
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

/// 音乐资源列表的详细信息。
///
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
    this.onPreLoadEvent,
  });

  /// @nodoc
  final void Function(String requestId, MusicContentCenterStatusCode status,
      List<MusicChartInfo> result)? onMusicChartsResult;

  /// @nodoc
  final void Function(String requestId, MusicContentCenterStatusCode status,
      MusicCollection result)? onMusicCollectionResult;

  /// @nodoc
  final void Function(String requestId, String lyricUrl)? onLyricResult;

  /// @nodoc
  final void Function(int songCode, int percent, PreloadStatusCode status,
      String msg, String lyricUrl)? onPreLoadEvent;
}

/// 音乐内容中心的设置。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MusicContentCenterConfiguration {
  /// @nodoc
  const MusicContentCenterConfiguration({this.appId, this.token, this.mccUid});

  /// 已启用内容中心的项目的 App ID。
  @JsonKey(name: 'appId')
  final String? appId;

  /// @nodoc
  @JsonKey(name: 'token')
  final String? token;

  /// 使用音乐内容中心的用户 ID，该 ID 可以和你加入 RTC 频道时使用的 uid 一致，但不能为 0。
  @JsonKey(name: 'mccUid')
  final int? mccUid;

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
  Future<MusicPlayer> createMusicPlayer();

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
  Future<void> preload({required int songCode, String? jsonOption});

  /// @nodoc
  Future<bool> isPreloaded(int songCode);

  /// @nodoc
  Future<String> getLyric({required int songCode, int lyricType = 0});
}
