import '/src/_serializable.dart';
import '/src/binding_forward_export.dart';
part 'agora_media_player_types.g.dart';

/// @nodoc
const kMaxCharBufferLength = 50;

/// Player states.
@JsonEnum(alwaysCreate: true)
enum MediaPlayerState {
  /// 0: Default state. Returned before opening a media file and after playback ends.
  @JsonValue(0)
  playerStateIdle,

  /// 1: Opening media file.
  @JsonValue(1)
  playerStateOpening,

  /// 2: Media file opened successfully.
  @JsonValue(2)
  playerStateOpenCompleted,

  /// 3: Playing.
  @JsonValue(3)
  playerStatePlaying,

  /// 4: Playback paused.
  @JsonValue(4)
  playerStatePaused,

  /// 5: Playback completed.
  @JsonValue(5)
  playerStatePlaybackCompleted,

  /// 6: Loop playback ended.
  @JsonValue(6)
  playerStatePlaybackAllLoopsCompleted,

  /// 7: Playback stopped.
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

  /// 100: Playback failed.
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

/// Reason for media player state change.
@JsonEnum(alwaysCreate: true)
enum MediaPlayerReason {
  /// 0: No error.
  @JsonValue(0)
  playerReasonNone,

  /// -1: Invalid arguments.
  @JsonValue(-1)
  playerReasonInvalidArguments,

  /// -2: Internal error.
  @JsonValue(-2)
  playerReasonInternal,

  /// -3: No resource.
  @JsonValue(-3)
  playerReasonNoResource,

  /// -4: Invalid resource.
  @JsonValue(-4)
  playerReasonInvalidMediaSource,

  /// -5: Unknown media stream type.
  @JsonValue(-5)
  playerReasonUnknownStreamType,

  /// -6: Object not initialized.
  @JsonValue(-6)
  playerReasonObjNotInitialized,

  /// -7: Codec not supported.
  @JsonValue(-7)
  playerReasonCodecNotSupported,

  /// -8: Invalid renderer.
  @JsonValue(-8)
  playerReasonVideoRenderFailed,

  /// -9: Invalid internal player state.
  @JsonValue(-9)
  playerReasonInvalidState,

  /// -10: URL not found.
  @JsonValue(-10)
  playerReasonUrlNotFound,

  /// -11: Invalid connection between player and Agora server.
  @JsonValue(-11)
  playerReasonInvalidConnectionState,

  /// -12: Insufficient playback buffer data.
  @JsonValue(-12)
  playerReasonSrcBufferUnderflow,

  /// -13: Playback was interrupted abnormally and ended.
  @JsonValue(-13)
  playerReasonInterrupted,

  /// -14: SDK does not support this API call.
  @JsonValue(-14)
  playerReasonNotSupported,

  /// -15: Authentication information for the media resource network path has expired.
  @JsonValue(-15)
  playerReasonTokenExpired,

  /// @nodoc
  @JsonValue(-16)
  playerReasonIpExpired,

  /// -17: Unknown error.
  @JsonValue(-17)
  playerReasonUnknown,
}

/// @nodoc
extension MediaPlayerReasonExt on MediaPlayerReason {
  /// @nodoc
  static MediaPlayerReason fromValue(int value) {
    return $enumDecode(_$MediaPlayerReasonEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$MediaPlayerReasonEnumMap[this]!;
  }
}

/// Media stream types.
@JsonEnum(alwaysCreate: true)
enum MediaStreamType {
  /// 0: Unknown type.
  @JsonValue(0)
  streamTypeUnknown,

  /// 1: Video stream.
  @JsonValue(1)
  streamTypeVideo,

  /// 2: Audio stream.
  @JsonValue(2)
  streamTypeAudio,

  /// 3: Subtitle stream.
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

/// Player events.
@JsonEnum(alwaysCreate: true)
enum MediaPlayerEvent {
  /// 0: Start seeking.
  @JsonValue(0)
  playerEventSeekBegin,

  /// 1: Seek completed.
  @JsonValue(1)
  playerEventSeekComplete,

  /// 2: Seek error.
  @JsonValue(2)
  playerEventSeekError,

  /// 5: Current audio track changed.
  @JsonValue(5)
  playerEventAudioTrackChanged,

  /// 6: The current buffer is insufficient for playback.
  @JsonValue(6)
  playerEventBufferLow,

  /// 7: The current buffer is just enough for playback.
  @JsonValue(7)
  playerEventBufferRecover,

  /// 8: Audio or video stuttering occurred.
  @JsonValue(8)
  playerEventFreezeStart,

  /// 9: Audio and video stuttering stopped.
  @JsonValue(9)
  playerEventFreezeStop,

  /// 10: Start switching media source.
  @JsonValue(10)
  playerEventSwitchBegin,

  /// 11: Media source switch completed.
  @JsonValue(11)
  playerEventSwitchComplete,

  /// 12: Media source switch error.
  @JsonValue(12)
  playerEventSwitchError,

  /// 13: First video frame displayed.
  @JsonValue(13)
  playerEventFirstDisplayed,

  /// 14: Reached the maximum number of cacheable files.
  @JsonValue(14)
  playerEventReachCacheFileMaxCount,

  /// 15: Reached the maximum size of cacheable files.
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

  /// @nodoc
  @JsonValue(19)
  playerEventHttpRedirect,
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

/// Events that occur during media resource preloading.
@JsonEnum(alwaysCreate: true)
enum PlayerPreloadEvent {
  /// 0: Start preloading media resource.
  @JsonValue(0)
  playerPreloadEventBegin,

  /// 1: Media resource preloading completed.
  @JsonValue(1)
  playerPreloadEventComplete,

  /// 2: Error occurred during media resource preloading.
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

/// All information of the player media stream.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class PlayerStreamInfo implements AgoraSerializable {
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

  /// The index of the media stream.
  @JsonKey(name: 'streamIndex')
  final int? streamIndex;

  /// The type of this media stream. See MediaStreamType.
  @JsonKey(name: 'streamType')
  final MediaStreamType? streamType;

  /// The codec specification of this media stream.
  @JsonKey(name: 'codecName')
  final String? codecName;

  /// The language of this media stream.
  @JsonKey(name: 'language')
  final String? language;

  /// Applies to video streams only. Indicates the video frame rate (fps).
  @JsonKey(name: 'videoFrameRate')
  final int? videoFrameRate;

  /// Applies to video streams only. Indicates the video bitrate (bps).
  @JsonKey(name: 'videoBitRate')
  final int? videoBitRate;

  /// Applies to video streams only. Indicates the video width (px).
  @JsonKey(name: 'videoWidth')
  final int? videoWidth;

  /// Applies to video streams only. Indicates the video height (px).
  @JsonKey(name: 'videoHeight')
  final int? videoHeight;

  /// Applies to video streams only. Indicates the rotation angle.
  @JsonKey(name: 'videoRotation')
  final int? videoRotation;

  /// Applies to audio streams only. Indicates the audio sample rate (Hz).
  @JsonKey(name: 'audioSampleRate')
  final int? audioSampleRate;

  /// Applies to audio streams only. Indicates the number of audio channels.
  @JsonKey(name: 'audioChannels')
  final int? audioChannels;

  /// Applies to audio streams only. Indicates the number of bits per audio sample (bit).
  @JsonKey(name: 'audioBitsPerSample')
  final int? audioBitsPerSample;

  /// The duration of the media stream (milliseconds).
  @JsonKey(name: 'duration')
  final int? duration;

  /// @nodoc
  factory PlayerStreamInfo.fromJson(Map<String, dynamic> json) =>
      _$PlayerStreamInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PlayerStreamInfoToJson(this);
}

/// Video bitrate information during media playback.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SrcInfo implements AgoraSerializable {
  /// @nodoc
  const SrcInfo({this.bitrateInKbps, this.name});

  /// Video bitrate during media playback (Kbps).
  @JsonKey(name: 'bitrateInKbps')
  final int? bitrateInKbps;

  /// Name of the media resource.
  @JsonKey(name: 'name')
  final String? name;

  /// @nodoc
  factory SrcInfo.fromJson(Map<String, dynamic> json) =>
      _$SrcInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SrcInfoToJson(this);
}

/// Media metadata types.
@JsonEnum(alwaysCreate: true)
enum MediaPlayerMetadataType {
  /// 0: Unknown type.
  @JsonValue(0)
  playerMetadataTypeUnknown,

  /// 1: SEI (Supplemental Enhancement Information) type.
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

/// Statistics of cached files.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CacheStatistics implements AgoraSerializable {
  /// @nodoc
  const CacheStatistics({this.fileSize, this.cacheSize, this.downloadSize});

  /// Size of the media file for this playback, in bytes.
  @JsonKey(name: 'fileSize')
  final int? fileSize;

  /// Size of the cached data of the media file for this playback, in bytes.
  @JsonKey(name: 'cacheSize')
  final int? cacheSize;

  /// Size of the downloaded media file for this playback, in bytes.
  @JsonKey(name: 'downloadSize')
  final int? downloadSize;

  /// @nodoc
  factory CacheStatistics.fromJson(Map<String, dynamic> json) =>
      _$CacheStatisticsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CacheStatisticsToJson(this);
}

/// Information related to the currently playing media resource.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class PlayerPlaybackStats implements AgoraSerializable {
  /// @nodoc
  const PlayerPlaybackStats(
      {this.videoFps,
      this.videoBitrateInKbps,
      this.audioBitrateInKbps,
      this.totalBitrateInKbps});

  /// Video frame rate, in fps.
  @JsonKey(name: 'videoFps')
  final int? videoFps;

  /// Video bitrate, in kbps.
  @JsonKey(name: 'videoBitrateInKbps')
  final int? videoBitrateInKbps;

  /// Audio bitrate, in kbps.
  @JsonKey(name: 'audioBitrateInKbps')
  final int? audioBitrateInKbps;

  /// Total bitrate of the media stream, in kbps.
  @JsonKey(name: 'totalBitrateInKbps')
  final int? totalBitrateInKbps;

  /// @nodoc
  factory PlayerPlaybackStats.fromJson(Map<String, dynamic> json) =>
      _$PlayerPlaybackStatsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PlayerPlaybackStatsToJson(this);
}

/// Information related to the media player.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class PlayerUpdatedInfo implements AgoraSerializable {
  /// @nodoc
  const PlayerUpdatedInfo(
      {this.internalPlayerUuid,
      this.deviceId,
      this.videoHeight,
      this.videoWidth,
      this.audioSampleRate,
      this.audioChannels,
      this.audioBitsPerSample});

  /// @nodoc
  @JsonKey(name: 'internalPlayerUuid')
  final String? internalPlayerUuid;

  /// Device ID, identifies a device.
  @JsonKey(name: 'deviceId')
  final String? deviceId;

  /// Video height (pixel).
  @JsonKey(name: 'videoHeight')
  final int? videoHeight;

  /// Video width (pixel).
  @JsonKey(name: 'videoWidth')
  final int? videoWidth;

  /// Audio sample rate (Hz).
  @JsonKey(name: 'audioSampleRate')
  final int? audioSampleRate;

  /// Number of audio channels.
  @JsonKey(name: 'audioChannels')
  final int? audioChannels;

  /// Number of bits per audio sample (bit).
  @JsonKey(name: 'audioBitsPerSample')
  final int? audioBitsPerSample;

  /// @nodoc
  factory PlayerUpdatedInfo.fromJson(Map<String, dynamic> json) =>
      _$PlayerUpdatedInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PlayerUpdatedInfoToJson(this);
}

/// Information and playback settings for the media file to be played.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MediaSource implements AgoraSerializable {
  /// @nodoc
  const MediaSource(
      {this.url,
      this.uri,
      this.startPos,
      this.autoPlay,
      this.enableCache,
      this.enableMultiAudioTrack,
      this.isAgoraSource,
      this.isLiveSource});

  /// URL of the media resource to be played.
  @JsonKey(name: 'url')
  final String? url;

  /// URI (Uniform Resource Identifier) of the media file, used to identify the media file.
  @JsonKey(name: 'uri')
  final String? uri;

  /// Start playback position in milliseconds. Default is 0.
  @JsonKey(name: 'startPos')
  final int? startPos;

  /// If you disable autoplay, call the play method to play the media file after opening it. Whether to enable autoplay after opening the media file: true : (default) Enable autoplay. false : Disable autoplay.
  @JsonKey(name: 'autoPlay')
  final bool? autoPlay;

  /// The SDK currently only supports caching for on-demand streams, not for on-demand streams transmitted via HLS protocol.
  ///  Before caching, assign a value to uri, otherwise the player uses the media file's url as the cache index.
  ///  After enabling real-time caching, the player pre-caches part of the currently playing media file locally. When you play the file again, the player loads data from the cache, saving network traffic. The statistics of the currently cached media file are updated every second after playback starts. See CacheStatistics. Whether to enable real-time caching for this playback: true : Enable real-time caching. false : (default) Disable real-time caching.
  @JsonKey(name: 'enableCache')
  final bool? enableCache;

  /// Whether to allow selecting different audio tracks for this playback: true : Allow selecting different audio tracks. false : (default) Do not allow selecting different audio tracks. If you need to set different audio tracks for local playback and publishing to remote, set this parameter to true and then call the selectMultiAudioTrack method to set the audio track.
  @JsonKey(name: 'enableMultiAudioTrack')
  final bool? enableMultiAudioTrack;

  /// If the media resource to be opened is a live or on-demand stream distributed via Agora Fusion CDN, pass the stream URL to url and set isAgoraSource to true. Otherwise, you do not need to set isAgoraSource. Whether the opened media resource is a live or on-demand stream distributed via Agora Fusion CDN: true : The media resource is a live or on-demand stream distributed via Agora Fusion CDN. false : (default) The media resource is not distributed via Agora Fusion CDN.
  @JsonKey(name: 'isAgoraSource')
  final bool? isAgoraSource;

  /// Only when the media resource is a live stream, setting isLiveSource to true can speed up opening the media resource. Whether the opened media resource is a live stream: true : Live stream. false : (default) Not a live stream. If the media resource is a live stream, it is recommended to set this parameter to true to speed up the opening of the live stream.
  @JsonKey(name: 'isLiveSource')
  final bool? isLiveSource;

  /// @nodoc
  factory MediaSource.fromJson(Map<String, dynamic> json) =>
      _$MediaSourceFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MediaSourceToJson(this);
}
