import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_media_player_types.g.dart';

/// @nodoc
const kMaxCharBufferLength = 50;

/// 播放器的状态。
///
@JsonEnum(alwaysCreate: true)
enum MediaPlayerState {
  /// 0: 默认状态。播放器会在你打开媒体文件之前和结束播放之后返回该状态码。
  @JsonValue(0)
  playerStateIdle,

  /// 正在打开媒体文件。
  @JsonValue(1)
  playerStateOpening,

  /// 成功打开媒体文件。
  @JsonValue(2)
  playerStateOpenCompleted,

  /// 正在播放。
  @JsonValue(3)
  playerStatePlaying,

  /// 暂停播放。
  @JsonValue(4)
  playerStatePaused,

  /// 播放完毕。
  @JsonValue(5)
  playerStatePlaybackCompleted,

  /// 循环播放已结束。
  @JsonValue(6)
  playerStatePlaybackAllLoopsCompleted,

  /// 播放已停止。
  @JsonValue(7)
  playerStateStopped,

  /// @nodoc
  @JsonValue(50)
  playerStatePausingInternal,

  /// @nodoc
  @JsonValue(51)
  playerStateStoppingInternal,

  /// @nodoc
  @JsonValue(52)
  playerStateSeekingInternal,

  /// @nodoc
  @JsonValue(53)
  playerStateGettingInternal,

  /// @nodoc
  @JsonValue(54)
  playerStateNoneInternal,

  /// @nodoc
  @JsonValue(55)
  playerStateDoNothingInternal,

  /// @nodoc
  @JsonValue(56)
  playerStateSetTrackInternal,

  /// 100: 播放失败。
  @JsonValue(100)
  playerStateFailed,
}

/// @nodoc
extension MediaPlayerStateExt on MediaPlayerState {
  /// @nodoc
  static MediaPlayerState fromValue(int value) {
    return $enumDecode(_$MediaPlayerStateEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$MediaPlayerStateEnumMap[this]!;
  }
}

/// 播放器的错误码。
///
@JsonEnum(alwaysCreate: true)
enum MediaPlayerError {
  /// 0: 没有错误。
  @JsonValue(0)
  playerErrorNone,

  /// -1: 不正确的参数。
  @JsonValue(-1)
  playerErrorInvalidArguments,

  /// -2: 内部错误。
  @JsonValue(-2)
  playerErrorInternal,

  /// -3: 没有 resource。
  @JsonValue(-3)
  playerErrorNoResource,

  /// -4: 无效的 resource。
  @JsonValue(-4)
  playerErrorInvalidMediaSource,

  /// -5: 未知的媒体流类型。
  @JsonValue(-5)
  playerErrorUnknownStreamType,

  /// -6: 对象没有初始化。
  @JsonValue(-6)
  playerErrorObjNotInitialized,

  /// -7: 解码器不支持该 codec。
  @JsonValue(-7)
  playerErrorCodecNotSupported,

  /// -8: 无效的 renderer。
  @JsonValue(-8)
  playerErrorVideoRenderFailed,

  /// -9: 播放器内部状态错误。
  @JsonValue(-9)
  playerErrorInvalidState,

  /// -10: 未找到该 URL。
  @JsonValue(-10)
  playerErrorUrlNotFound,

  /// -11: 播放器与 Agora 服务器的连接无效。
  @JsonValue(-11)
  playerErrorInvalidConnectionState,

  /// -12: 播放缓冲区数据不足。
  @JsonValue(-12)
  playerErrorSrcBufferUnderflow,

  /// -13: 播放被异常打断而结束。
  @JsonValue(-13)
  playerErrorInterrupted,

  /// -14: SDK 不支持的接口调用。
  @JsonValue(-14)
  playerErrorNotSupported,

  /// -15: 媒体资源网络路径的鉴权信息已过期。
  @JsonValue(-15)
  playerErrorTokenExpired,

  /// @nodoc
  @JsonValue(-16)
  playerErrorIpExpired,

  /// -17：未知错误。
  @JsonValue(-17)
  playerErrorUnknown,
}

/// @nodoc
extension MediaPlayerErrorExt on MediaPlayerError {
  /// @nodoc
  static MediaPlayerError fromValue(int value) {
    return $enumDecode(_$MediaPlayerErrorEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$MediaPlayerErrorEnumMap[this]!;
  }
}

/// 媒体流的类型。
///
@JsonEnum(alwaysCreate: true)
enum MediaStreamType {
  /// 0: 未知类型。
  @JsonValue(0)
  streamTypeUnknown,

  /// 1: 视频流。
  @JsonValue(1)
  streamTypeVideo,

  /// 2: 音频流。
  @JsonValue(2)
  streamTypeAudio,

  /// 3: 字幕流。
  @JsonValue(3)
  streamTypeSubtitle,
}

/// @nodoc
extension MediaStreamTypeExt on MediaStreamType {
  /// @nodoc
  static MediaStreamType fromValue(int value) {
    return $enumDecode(_$MediaStreamTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$MediaStreamTypeEnumMap[this]!;
  }
}

/// 播放器事件。
///
@JsonEnum(alwaysCreate: true)
enum MediaPlayerEvent {
  /// 0: 开始定位。
  @JsonValue(0)
  playerEventSeekBegin,

  /// 1: 完成定位。
  @JsonValue(1)
  playerEventSeekComplete,

  /// 2: 定位出错。
  @JsonValue(2)
  playerEventSeekError,

  /// 5: 当前音轨发生改变。
  @JsonValue(5)
  playerEventAudioTrackChanged,

  /// 6: 当前缓冲的数据不足以支持播放。
  @JsonValue(6)
  playerEventBufferLow,

  /// 7: 当前缓冲的数据刚好能支持播放。
  @JsonValue(7)
  playerEventBufferRecover,

  /// 8: 音频或视频出现卡顿。
  @JsonValue(8)
  playerEventFreezeStart,

  /// 9: 音频和视频均停止卡顿。
  @JsonValue(9)
  playerEventFreezeStop,

  /// 10: 开始切换媒体资源。
  @JsonValue(10)
  playerEventSwitchBegin,

  /// 11: 媒体资源切换完成。
  @JsonValue(11)
  playerEventSwitchComplete,

  /// 12: 媒体资源切换出错。
  @JsonValue(12)
  playerEventSwitchError,

  /// 13: 视频首帧出图。
  @JsonValue(13)
  playerEventFirstDisplayed,

  /// 14：达到可缓存文件的数量上限。
  @JsonValue(14)
  playerEventReachCacheFileMaxCount,

  /// 15：达到可缓存文件的大小上限。
  @JsonValue(15)
  playerEventReachCacheFileMaxSize,

  /// @nodoc
  @JsonValue(16)
  playerEventTryOpenStart,

  /// @nodoc
  @JsonValue(17)
  playerEventTryOpenSucceed,

  /// @nodoc
  @JsonValue(18)
  playerEventTryOpenFailed,
}

/// @nodoc
extension MediaPlayerEventExt on MediaPlayerEvent {
  /// @nodoc
  static MediaPlayerEvent fromValue(int value) {
    return $enumDecode(_$MediaPlayerEventEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$MediaPlayerEventEnumMap[this]!;
  }
}

/// 预加载媒体资源时发生的事件。
///
@JsonEnum(alwaysCreate: true)
enum PlayerPreloadEvent {
  /// 0: 开始预加载媒体资源。
  @JsonValue(0)
  playerPreloadEventBegin,

  /// 1: 预加载媒体资源完成。
  @JsonValue(1)
  playerPreloadEventComplete,

  /// 2: 预加载媒体资源出错。
  @JsonValue(2)
  playerPreloadEventError,
}

/// @nodoc
extension PlayerPreloadEventExt on PlayerPreloadEvent {
  /// @nodoc
  static PlayerPreloadEvent fromValue(int value) {
    return $enumDecode(_$PlayerPreloadEventEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$PlayerPreloadEventEnumMap[this]!;
  }
}

/// 播放器媒体流的所有信息。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class PlayerStreamInfo {
  /// @nodoc
  const PlayerStreamInfo(
      {this.streamIndex,
      this.streamType,
      this.codecName,
      this.language,
      this.videoFrameRate,
      this.videoBitRate,
      this.videoWidth,
      this.videoHeight,
      this.videoRotation,
      this.audioSampleRate,
      this.audioChannels,
      this.audioBitsPerSample,
      this.duration});

  /// 媒体流的索引值。
  @JsonKey(name: 'streamIndex')
  final int? streamIndex;

  /// 此条媒体流的类型。详见 MediaStreamType 。
  @JsonKey(name: 'streamType')
  final MediaStreamType? streamType;

  /// 此条媒体流的编码规格。
  @JsonKey(name: 'codecName')
  final String? codecName;

  /// 此条媒体流的语言。
  @JsonKey(name: 'language')
  final String? language;

  /// 该参数仅对视频流生效，表示视频帧率 (fps)。
  @JsonKey(name: 'videoFrameRate')
  final int? videoFrameRate;

  /// 该参数仅对视频流生效，表示视频码率 (bps)。
  @JsonKey(name: 'videoBitRate')
  final int? videoBitRate;

  /// 该参数仅对视频流生效，表示视频宽度 (pixel)。
  @JsonKey(name: 'videoWidth')
  final int? videoWidth;

  /// 该参数仅对视频流生效，表示视频高度 (pixel)。
  @JsonKey(name: 'videoHeight')
  final int? videoHeight;

  /// 该参数仅对视频流生效，表示旋转角度。
  @JsonKey(name: 'videoRotation')
  final int? videoRotation;

  /// 该参数仅对音频流生效，表示音频采样率 (Hz)。
  @JsonKey(name: 'audioSampleRate')
  final int? audioSampleRate;

  /// 该参数仅对音频流生效，表示声道数。
  @JsonKey(name: 'audioChannels')
  final int? audioChannels;

  /// 该参数仅对音频流生效，表示每个音频采样点的位数 (bit)。
  @JsonKey(name: 'audioBitsPerSample')
  final int? audioBitsPerSample;

  /// 媒体流的时长（秒）。
  @JsonKey(name: 'duration')
  final int? duration;

  /// @nodoc
  factory PlayerStreamInfo.fromJson(Map<String, dynamic> json) =>
      _$PlayerStreamInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$PlayerStreamInfoToJson(this);
}

/// 媒体资源播放时的视频码率相关信息。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SrcInfo {
  /// @nodoc
  const SrcInfo({this.bitrateInKbps, this.name});

  /// 媒体资源播放时的视频码率（Kbps）。
  @JsonKey(name: 'bitrateInKbps')
  final int? bitrateInKbps;

  /// 媒体资源的名字。
  @JsonKey(name: 'name')
  final String? name;

  /// @nodoc
  factory SrcInfo.fromJson(Map<String, dynamic> json) =>
      _$SrcInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$SrcInfoToJson(this);
}

/// 媒体附属信息数据类型。
///
@JsonEnum(alwaysCreate: true)
enum MediaPlayerMetadataType {
  /// 0: 未知类型。
  @JsonValue(0)
  playerMetadataTypeUnknown,

  /// 1: SEI （补充增强信息）类型。
  @JsonValue(1)
  playerMetadataTypeSei,
}

/// @nodoc
extension MediaPlayerMetadataTypeExt on MediaPlayerMetadataType {
  /// @nodoc
  static MediaPlayerMetadataType fromValue(int value) {
    return $enumDecode(_$MediaPlayerMetadataTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$MediaPlayerMetadataTypeEnumMap[this]!;
  }
}

/// 缓存文件的统计数据。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CacheStatistics {
  /// @nodoc
  const CacheStatistics({this.fileSize, this.cacheSize, this.downloadSize});

  /// 本次播放的媒体文件的大小，单位为字节。
  @JsonKey(name: 'fileSize')
  final int? fileSize;

  /// 本次播放的媒体文件需缓存的数据大小，单位为字节。
  @JsonKey(name: 'cacheSize')
  final int? cacheSize;

  /// 本次播放已下载的媒体文件大小，单位为字节。
  @JsonKey(name: 'downloadSize')
  final int? downloadSize;

  /// @nodoc
  factory CacheStatistics.fromJson(Map<String, dynamic> json) =>
      _$CacheStatisticsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$CacheStatisticsToJson(this);
}

/// 媒体播放器相关信息。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class PlayerUpdatedInfo {
  /// @nodoc
  const PlayerUpdatedInfo({this.playerId, this.deviceId, this.cacheStatistics});

  /// 播放器 ID，标识一个播放器。
  @JsonKey(name: 'playerId')
  final String? playerId;

  /// 设备 ID，标识一个设备。
  @JsonKey(name: 'deviceId')
  final String? deviceId;

  /// 当前缓存的媒体文件的相关统计数据。调用 openWithMediaSource 方法且设置 enableCache 成员为 true 后，当前缓存的媒体文件的相关统计数据会在媒体文件开始播放后每秒更新一次，详见 CacheStatistics 。
  @JsonKey(name: 'cacheStatistics')
  final CacheStatistics? cacheStatistics;

  /// @nodoc
  factory PlayerUpdatedInfo.fromJson(Map<String, dynamic> json) =>
      _$PlayerUpdatedInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$PlayerUpdatedInfoToJson(this);
}

/// 需播放的媒体文件的相关信息及播放设置。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MediaSource {
  /// @nodoc
  const MediaSource(
      {this.url,
      this.uri,
      this.startPos,
      this.autoPlay,
      this.enableCache,
      this.isAgoraSource,
      this.isLiveSource});

  /// 需要播放的媒体资源的 URL。如果你打开媒体资源为自定义媒体资源，则无需向 url 传值。
  @JsonKey(name: 'url')
  final String? url;

  /// 媒体文件的 URI（Uniform Resource Identifier），可用于标识媒体文件。
  @JsonKey(name: 'uri')
  final String? uri;

  /// 设置起始播放位置 (毫秒)，默认值为 0。
  @JsonKey(name: 'startPos')
  final int? startPos;

  /// 打开媒体文件后，是否开启自动播放： true：（默认）开启自动播放。false：关闭自动播放。如果你设置关闭自动播放，打开媒体文件后，还需再调用 play 方法来播放媒体文件。
  @JsonKey(name: 'autoPlay')
  final bool? autoPlay;

  /// 此次播放是否开启实时缓存功能： true：开启实时缓存。false：（默认）关闭实时缓存。如需开启实时缓存，请向 uri 传值，否则播放器会以媒体文件的 url 作为缓存索引。开启实时缓存后，播放器会预先缓存当前正在播放的媒体文件的部分数据到本地，当你下次播放该文件时播放器会直接从缓存中加载数据，可节省网络流量。当前缓存的媒体文件的相关统计数据会在媒体文件开始播放后每秒更新一次，详见 CacheStatistics 。
  @JsonKey(name: 'enableCache')
  final bool? enableCache;

  /// 打开的媒体资源是否为通过 Agora 融合 CDN 分发的直播或点播流：
  ///  true：打开的媒体资源是 Agora 融合 CDN 分发的直播或点播流。false：（默认）打开的媒体资源不是 Agora 融合 CDN 分发的直播或点播流。如果你需要打开的媒体资源为 Agora 融合 CDN 分发的直播流或点播流，请向 url 传入直播或点播流的 URL 并将 isAgoraSource 设置为 true，否则无需设置 isAgoraSource。
  @JsonKey(name: 'isAgoraSource')
  final bool? isAgoraSource;

  /// 打开的媒体资源是否为直播流： true：直播流。false：（默认）非直播流。如果你打开的媒体资源为直播流，Agora 推荐你将该参数设置为 true，可加快打开直播流的速度。仅当打开的媒体资源为直播流时，将 isLiveSource 设置为 true 后才可加快媒体资源的打开速度。
  @JsonKey(name: 'isLiveSource')
  final bool? isLiveSource;

  /// @nodoc
  factory MediaSource.fromJson(Map<String, dynamic> json) =>
      _$MediaSourceFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$MediaSourceToJson(this);
}
