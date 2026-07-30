import '/src/_serializable.dart';
import '/src/binding_forward_export.dart';
part 'agora_music_content_center.g.dart';

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum MusicContentCenterVendorID {
  /// @nodoc
  @JsonValue(1)
  kMusicContentCenterVendorDefault,

  /// @nodoc
  @JsonValue(2)
  kMusicContentCenterVendor2,
}

/// @nodoc
extension MusicContentCenterVendorIDExt on MusicContentCenterVendorID {
  /// @nodoc
  static MusicContentCenterVendorID fromValue(int value) {
    return $enumDecode(_$MusicContentCenterVendorIDEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$MusicContentCenterVendorIDEnumMap[this]!;
  }
}

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
enum MusicContentCenterState {
  /// @nodoc
  @JsonValue(0)
  kMusicContentCenterStatePreloadOk,

  /// @nodoc
  @JsonValue(1)
  kMusicContentCenterStatePreloadFailed,

  /// @nodoc
  @JsonValue(2)
  kMusicContentCenterStatePreloading,

  /// @nodoc
  @JsonValue(3)
  kMusicContentCenterStatePreloadRemoved,

  /// @nodoc
  @JsonValue(4)
  kMusicContentCenterStateStartScoreCompleted,

  /// @nodoc
  @JsonValue(5)
  kMusicContentCenterStateStartScoreFailed,
}

/// @nodoc
extension MusicContentCenterStateExt on MusicContentCenterState {
  /// @nodoc
  static MusicContentCenterState fromValue(int value) {
    return $enumDecode(_$MusicContentCenterStateEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$MusicContentCenterStateEnumMap[this]!;
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
class MusicChartInfo implements AgoraSerializable {
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

  @override
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

  /// @nodoc
  @JsonValue(2)
  musicCacheStatusTypeNoCached,

  /// @nodoc
  @JsonValue(3)
  musicCacheStatusTypeNoResource,
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
class MusicCacheInfo implements AgoraSerializable {
  /// @nodoc
  const MusicCacheInfo({this.songCode, this.musicStatus, this.lyricStatus});

  /// @nodoc
  @JsonKey(name: 'songCode')
  final int? songCode;

  /// @nodoc
  @JsonKey(name: 'musicStatus')
  final MusicCacheStatusType? musicStatus;

  /// @nodoc
  @JsonKey(name: 'lyricStatus')
  final MusicCacheStatusType? lyricStatus;

  /// @nodoc
  factory MusicCacheInfo.fromJson(Map<String, dynamic> json) =>
      _$MusicCacheInfoFromJson(json);

  @override
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
class MvProperty implements AgoraSerializable {
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

  @override
  Map<String, dynamic> toJson() => _$MvPropertyToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ClimaxSegment implements AgoraSerializable {
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

  @override
  Map<String, dynamic> toJson() => _$ClimaxSegmentToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Music implements AgoraSerializable {
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

  @override
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
@JsonEnum(alwaysCreate: true)
enum LyricSourceType {
  /// @nodoc
  @JsonValue(0)
  kLyricSourceXml,

  /// @nodoc
  @JsonValue(1)
  kLyricSourceLrc,

  /// @nodoc
  @JsonValue(2)
  kLyricSourceLrcWithPitches,

  /// @nodoc
  @JsonValue(3)
  kLyricSourceKrc,
}

/// @nodoc
extension LyricSourceTypeExt on LyricSourceType {
  /// @nodoc
  static LyricSourceType fromValue(int value) {
    return $enumDecode(_$LyricSourceTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$LyricSourceTypeEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum ScoreLevel {
  /// @nodoc
  @JsonValue(1)
  kScoreLevel1,

  /// @nodoc
  @JsonValue(2)
  kScoreLevel2,

  /// @nodoc
  @JsonValue(3)
  kScoreLevel3,

  /// @nodoc
  @JsonValue(4)
  kScoreLevel4,

  /// @nodoc
  @JsonValue(5)
  kScoreLevel5,
}

/// @nodoc
extension ScoreLevelExt on ScoreLevel {
  /// @nodoc
  static ScoreLevel fromValue(int value) {
    return $enumDecode(_$ScoreLevelEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$ScoreLevelEnumMap[this]!;
  }
}

/// @nodoc
abstract class Word {
  /// @nodoc
  Future<int> getBegin();

  /// @nodoc
  Future<int> getDuration();

  /// @nodoc
  Future<double> getRefPitch();

  /// @nodoc
  Future<String> getWord();

  /// @nodoc
  Future<int> getScore();
}

/// @nodoc
abstract class Sentence {
  /// @nodoc
  Future<String> getContent();

  /// @nodoc
  Future<int> getBegin();

  /// @nodoc
  Future<int> getDuration();

  /// @nodoc
  Future<Word?> getWord(int index);

  /// @nodoc
  Future<int> getWordCount();

  /// @nodoc
  Future<int> getScore();
}

/// @nodoc
abstract class LyricInfo {
  /// @nodoc
  Future<String> getName();

  /// @nodoc
  Future<String> getSinger();

  /// @nodoc
  Future<int> getPreludeEndPosition();

  /// @nodoc
  Future<int> getDuration();

  /// @nodoc
  Future<bool> getHasPitch();

  /// @nodoc
  Future<LyricSourceType> getSourceType();

  /// @nodoc
  Future<Sentence?> getSentence(int index);

  /// @nodoc
  Future<int> getSentenceCount();
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RawScoreData implements AgoraSerializable {
  /// @nodoc
  const RawScoreData({this.progressInMs, this.speakerPitch, this.pitchScore});

  /// @nodoc
  @JsonKey(name: 'progressInMs')
  final int? progressInMs;

  /// @nodoc
  @JsonKey(name: 'speakerPitch')
  final double? speakerPitch;

  /// @nodoc
  @JsonKey(name: 'pitchScore')
  final double? pitchScore;

  /// @nodoc
  factory RawScoreData.fromJson(Map<String, dynamic> json) =>
      _$RawScoreDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RawScoreDataToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LineScoreData implements AgoraSerializable {
  /// @nodoc
  const LineScoreData(
      {this.progressInMs,
      this.index,
      this.totalLines,
      this.pitchScore,
      this.cumulativePitchScore,
      this.energyScore});

  /// @nodoc
  @JsonKey(name: 'progressInMs')
  final int? progressInMs;

  /// @nodoc
  @JsonKey(name: 'index')
  final int? index;

  /// @nodoc
  @JsonKey(name: 'totalLines')
  final int? totalLines;

  /// @nodoc
  @JsonKey(name: 'pitchScore')
  final double? pitchScore;

  /// @nodoc
  @JsonKey(name: 'cumulativePitchScore')
  final double? cumulativePitchScore;

  /// @nodoc
  @JsonKey(name: 'energyScore')
  final double? energyScore;

  /// @nodoc
  factory LineScoreData.fromJson(Map<String, dynamic> json) =>
      _$LineScoreDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LineScoreDataToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CumulativeScoreData implements AgoraSerializable {
  /// @nodoc
  const CumulativeScoreData(
      {this.progressInMs, this.cumulativePitchScore, this.energyScore});

  /// @nodoc
  @JsonKey(name: 'progressInMs')
  final int? progressInMs;

  /// @nodoc
  @JsonKey(name: 'cumulativePitchScore')
  final double? cumulativePitchScore;

  /// @nodoc
  @JsonKey(name: 'energyScore')
  final double? energyScore;

  /// @nodoc
  factory CumulativeScoreData.fromJson(Map<String, dynamic> json) =>
      _$CumulativeScoreDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CumulativeScoreDataToJson(this);
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum ChargeMode {
  /// @nodoc
  @JsonValue(1)
  kChargeModeMonthly,

  /// @nodoc
  @JsonValue(2)
  kChargeModeOnce,
}

/// @nodoc
extension ChargeModeExt on ChargeMode {
  /// @nodoc
  static ChargeMode fromValue(int value) {
    return $enumDecode(_$ChargeModeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$ChargeModeEnumMap[this]!;
  }
}

/// @nodoc
class ScoreEventHandler {
  /// @nodoc
  const ScoreEventHandler({
    this.onPitch,
    this.onLineScore,
  });

  /// @nodoc
  final RawScoreData Function(int internalSongCode)? onPitch;

  /// @nodoc
  final LineScoreData Function(int internalSongCode)? onLineScore;
}

/// @nodoc
class MusicContentCenterEventHandler {
  /// @nodoc
  const MusicContentCenterEventHandler({
    this.onMusicChartsResult,
    this.onMusicCollectionResult,
    this.onLyricResult,
    this.onLyricInfoResult,
    this.onSongSimpleInfoResult,
    this.onPreLoadEvent,
    this.onStartScoreResult,
  });

  /// @nodoc
  final void Function(String requestId, List<MusicChartInfo> result,
      MusicContentCenterStateReason reason)? onMusicChartsResult;

  /// @nodoc
  final void Function(String requestId, MusicCollection result,
      MusicContentCenterStateReason reason)? onMusicCollectionResult;

  /// @nodoc
  final void Function(String requestId, int internalSongCode, String payload,
      MusicContentCenterStateReason reason)? onLyricResult;

  /// @nodoc
  final void Function(
      String requestId,
      int internalSongCode,
      LyricInfo lyricInfo,
      MusicContentCenterStateReason reason)? onLyricInfoResult;

  /// @nodoc
  final void Function(String requestId, int internalSongCode, String simpleInfo,
      MusicContentCenterStateReason reason)? onSongSimpleInfoResult;

  /// @nodoc
  final void Function(
      String requestId,
      int internalSongCode,
      int percent,
      String payload,
      MusicContentCenterState state,
      MusicContentCenterStateReason reason)? onPreLoadEvent;

  /// @nodoc
  final void Function(int internalSongCode, MusicContentCenterState state,
      MusicContentCenterStateReason reason)? onStartScoreResult;
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MusicContentCenterConfiguration implements AgoraSerializable {
  /// @nodoc
  const MusicContentCenterConfiguration(
      {this.maxCacheSize, this.scoreEventHandler, this.audioFrameObserver});

  /// @nodoc
  @JsonKey(name: 'maxCacheSize')
  final int? maxCacheSize;

  /// @nodoc
  @JsonKey(name: 'scoreEventHandler', ignore: true)
  final ScoreEventHandler? scoreEventHandler;

  /// @nodoc
  @JsonKey(name: 'audioFrameObserver', ignore: true)
  final AudioFrameObserver? audioFrameObserver;

  /// @nodoc
  factory MusicContentCenterConfiguration.fromJson(Map<String, dynamic> json) =>
      _$MusicContentCenterConfigurationFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$MusicContentCenterConfigurationToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MusicContentCenterVendorDefaultConfiguration
    implements AgoraSerializable {
  /// @nodoc
  const MusicContentCenterVendorDefaultConfiguration(
      {this.appId, this.token, this.userId, this.mccDomain});

  /// @nodoc
  @JsonKey(name: 'appId')
  final String? appId;

  /// @nodoc
  @JsonKey(name: 'token')
  final String? token;

  /// @nodoc
  @JsonKey(name: 'userId')
  final String? userId;

  /// @nodoc
  @JsonKey(name: 'mccDomain')
  final String? mccDomain;

  /// @nodoc
  factory MusicContentCenterVendorDefaultConfiguration.fromJson(
          Map<String, dynamic> json) =>
      _$MusicContentCenterVendorDefaultConfigurationFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$MusicContentCenterVendorDefaultConfigurationToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MusicContentCenterVendor2Configuration implements AgoraSerializable {
  /// @nodoc
  const MusicContentCenterVendor2Configuration(
      {this.appId,
      this.appKey,
      this.token,
      this.userId,
      this.roomId,
      this.deviceId,
      this.urlTokenExpireTime,
      this.chargeMode});

  /// @nodoc
  @JsonKey(name: 'appId')
  final String? appId;

  /// @nodoc
  @JsonKey(name: 'appKey')
  final String? appKey;

  /// @nodoc
  @JsonKey(name: 'token')
  final String? token;

  /// @nodoc
  @JsonKey(name: 'userId')
  final String? userId;

  /// @nodoc
  @JsonKey(name: 'roomId')
  final String? roomId;

  /// @nodoc
  @JsonKey(name: 'deviceId')
  final String? deviceId;

  /// @nodoc
  @JsonKey(name: 'urlTokenExpireTime')
  final int? urlTokenExpireTime;

  /// @nodoc
  @JsonKey(name: 'chargeMode')
  final int? chargeMode;

  /// @nodoc
  factory MusicContentCenterVendor2Configuration.fromJson(
          Map<String, dynamic> json) =>
      _$MusicContentCenterVendor2ConfigurationFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$MusicContentCenterVendor2ConfigurationToJson(this);
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
  Future<void> addVendor(
      {required MusicContentCenterVendorID vendorId,
      required String jsonVendorConfig});

  /// @nodoc
  Future<void> removeVendor(MusicContentCenterVendorID vendorId);

  /// @nodoc
  Future<void> renewToken(
      {required MusicContentCenterVendorID vendorId, required String token});

  /// @nodoc
  Future<void> release();

  /// @nodoc
  void registerEventHandler(MusicContentCenterEventHandler eventHandler);

  /// @nodoc
  void unregisterEventHandler(MusicContentCenterEventHandler eventHandler);

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
  void registerScoreEventHandler(ScoreEventHandler scoreEventHandler);

  /// @nodoc
  void unregisterScoreEventHandler(ScoreEventHandler scoreEventHandler);

  /// @nodoc
  Future<void> setScoreLevel(ScoreLevel level);

  /// @nodoc
  Future<void> startScore(int internalSongCode);

  /// @nodoc
  Future<void> stopScore();

  /// @nodoc
  Future<void> pauseScore();

  /// @nodoc
  Future<void> resumeScore();

  /// @nodoc
  Future<CumulativeScoreData> getCumulativeScoreData();

  /// @nodoc
  Future<void> removeCache(int internalSongCode);

  /// @nodoc
  Future<List<MusicCacheInfo>> getCaches(int cacheInfoSize);

  /// @nodoc
  Future<bool> isPreloaded(int internalSongCode);

  /// @nodoc
  Future<String> getLyric(
      {required int internalSongCode,
      LyricSourceType lyricType = LyricSourceType.kLyricSourceXml});

  /// @nodoc
  Future<String> getLyricInfo(int internalSongCode);

  /// @nodoc
  Future<String> getSongSimpleInfo(int internalSongCode);

  /// @nodoc
  Future<int> getInternalSongCode(
      {required MusicContentCenterVendorID vendorId,
      required String songCode,
      required String jsonOption});
}
