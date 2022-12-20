import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_music_content_center.g.dart';

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum PreloadStatusCode {
  /// @nodoc
  @JsonValue(0)
  kPreloadStatusCompleted,

  /// @nodoc
  @JsonValue(1)
  kPreloadStatusFailed,

  /// @nodoc
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

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum MusicContentCenterStatusCode {
  /// @nodoc
  @JsonValue(0)
  kMusicContentCenterStatusOk,

  /// @nodoc
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

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MusicContentCenterConfiguration {
  /// @nodoc
  const MusicContentCenterConfiguration({this.appId, this.token, this.mccUid});

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
