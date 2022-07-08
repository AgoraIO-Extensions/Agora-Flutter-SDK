import 'package:agora_rtc_ng/src/binding_forward_export.dart';
part 'agora_media_player_types.g.dart';

/// @nodoc
const kMaxCharBufferLength = 50;

/// The playback state.
@JsonEnum(alwaysCreate: true)
enum MediaPlayerState {
  /// 0: The default state.
  /// The media player returns this state code before you open the media resource or after you stop the playback.
  @JsonValue(0)
  playerStateIdle,

  /// Opening the media resource.
  @JsonValue(1)
  playerStateOpening,

  /// Opens the media resource successfully.
  @JsonValue(2)
  playerStateOpenCompleted,

  /// The media resource is playing.
  @JsonValue(3)
  playerStatePlaying,

  /// Pauses the playback.
  @JsonValue(4)
  playerStatePaused,

  /// The playback finishes.
  @JsonValue(5)
  playerStatePlaybackCompleted,

  /// The loop finishes.
  @JsonValue(6)
  playerStatePlaybackAllLoopsCompleted,

  /// The playback stops.
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

  /// 100: The media player fails to play the media resource.
  @JsonValue(100)
  playerStateFailed,
}

/// Extensions functions of [MediaPlayerState].
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

/// Error codes of the media player.
@JsonEnum(alwaysCreate: true)
enum MediaPlayerError {
  /// 0: No error.
  @JsonValue(0)
  playerErrorNone,

  /// -1: Invalid arguments.
  @JsonValue(-1)
  playerErrorInvalidArguments,

  /// @nodoc
  @JsonValue(-2)
  playerErrorInternal,

  /// -3: No resource.
  @JsonValue(-3)
  playerErrorNoResource,

  /// -4: Invalid media resource.
  @JsonValue(-4)
  playerErrorInvalidMediaSource,

  /// -5: The type of the media stream is unknown.
  @JsonValue(-5)
  playerErrorUnknownStreamType,

  /// -6: The object is not initialized.
  @JsonValue(-6)
  playerErrorObjNotInitialized,

  /// -7: The codec is not supported.
  @JsonValue(-7)
  playerErrorCodecNotSupported,

  /// -8: Invalid renderer.
  @JsonValue(-8)
  playerErrorVideoRenderFailed,

  /// -9: An error with the internal state of the player occurs.
  @JsonValue(-9)
  playerErrorInvalidState,

  /// -10: The URL of the media resource can not be found.
  @JsonValue(-10)
  playerErrorUrlNotFound,

  /// -11: Invalid connection between the player and Agora's server.
  @JsonValue(-11)
  playerErrorInvalidConnectionState,

  /// -12: The playback buffer is insufficient.
  @JsonValue(-12)
  playerErrorSrcBufferUnderflow,

  /// -13: The playback is interrupted.
  @JsonValue(-13)
  playerErrorInterrupted,

  /// -14: The SDK does support the method being called.
  @JsonValue(-14)
  playerErrorNotSupported,

  /// @nodoc
  @JsonValue(-15)
  playerErrorTokenExpired,

  /// @nodoc
  @JsonValue(-16)
  playerErrorIpExpired,

  /// -17: An unknown error.
  @JsonValue(-17)
  playerErrorUnknown,
}

/// Extensions functions of [MediaPlayerError].
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

/// The type of the media stream.
@JsonEnum(alwaysCreate: true)
enum MediaStreamType {
  /// 0: The type is unknown.
  @JsonValue(0)
  streamTypeUnknown,

  /// 1: The video stream.
  @JsonValue(1)
  streamTypeVideo,

  /// 2: The audio stream.
  @JsonValue(2)
  streamTypeAudio,

  /// 3: The subtitle stream.
  @JsonValue(3)
  streamTypeSubtitle,
}

/// Extensions functions of [MediaStreamType].
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

/// Media player events.
@JsonEnum(alwaysCreate: true)
enum MediaPlayerEvent {
  /// 0: The player begins to seek to a new playback position.
  @JsonValue(0)
  playerEventSeekBegin,

  /// 1: The player finishes seeking to a new playback position.
  @JsonValue(1)
  playerEventSeekComplete,

  /// 2: An error occurs when seeking to a new playback position.
  @JsonValue(2)
  playerEventSeekError,

  /// 5: The audio track used by the player has been changed.
  @JsonValue(5)
  playerEventAudioTrackChanged,

  /// 6: The currently buffered data is not enough to support playback.
  @JsonValue(6)
  playerEventBufferLow,

  /// 7: The currently buffered data is just enough to support playback.
  @JsonValue(7)
  playerEventBufferRecover,

  /// 8: The audio or video playback freezes.
  @JsonValue(8)
  playerEventFreezeStart,

  /// 9: The audio or video playback resumes without freezing.
  @JsonValue(9)
  playerEventFreezeStop,

  /// 10: The player starts switching the media resource.
  @JsonValue(10)
  playerEventSwitchBegin,

  /// 11: Media resource switching is complete.
  @JsonValue(11)
  playerEventSwitchComplete,

  /// 12: Media resource switching error.
  @JsonValue(12)
  playerEventSwitchError,

  /// 13: The first video frame is rendered.
  @JsonValue(13)
  playerEventFirstDisplayed,
}

/// Extensions functions of [MediaPlayerEvent].
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

/// Events that occur when media resources are preloaded.
@JsonEnum(alwaysCreate: true)
enum PlayerPreloadEvent {
  /// 0: Starts preloading media resources.
  @JsonValue(0)
  playerPreloadEventBegin,

  /// 1: Preloading media resources is complete.
  @JsonValue(1)
  playerPreloadEventComplete,

  /// 2: An error occurs when preloading media resources.
  @JsonValue(2)
  playerPreloadEventError,
}

/// Extensions functions of [PlayerPreloadEvent].
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

/// The detailed information of the media stream.
@JsonSerializable(explicitToJson: true)
class PlayerStreamInfo {
  /// Construct the [PlayerStreamInfo].
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

  /// The type of the media stream. See MediaStreamType .
  @JsonKey(name: 'streamType')
  final MediaStreamType? streamType;

  /// The codec of the media stream.
  @JsonKey(name: 'codecName')
  final String? codecName;

  /// The language of the media stream.
  @JsonKey(name: 'language')
  final String? language;

  /// This parameter only takes effect for video streams, and indicates the video frame rate (fps).
  @JsonKey(name: 'videoFrameRate')
  final int? videoFrameRate;

  /// @nodoc
  @JsonKey(name: 'videoBitRate')
  final int? videoBitRate;

  /// This parameter only takes effect for video streams, and indicates the video width (pixel).
  @JsonKey(name: 'videoWidth')
  final int? videoWidth;

  /// This parameter only takes effect for video streams, and indicates the video height (pixel).
  @JsonKey(name: 'videoHeight')
  final int? videoHeight;

  /// This parameter only takes effect for video streams, and indicates the video rotation angle.
  @JsonKey(name: 'videoRotation')
  final int? videoRotation;

  /// This parameter only takes effect for audio streams, and indicates the audio sample rate (Hz).
  @JsonKey(name: 'audioSampleRate')
  final int? audioSampleRate;

  /// This parameter only takes effect for audio streams, and indicates the audio channel number.
  @JsonKey(name: 'audioChannels')
  final int? audioChannels;

  /// This parameter only takes effect for audio streams, and indicates the bit number of each audio sample.
  @JsonKey(name: 'audioBitsPerSample')
  final int? audioBitsPerSample;

  /// The total duration (s) of the media stream.
  @JsonKey(name: 'duration')
  final int? duration;

  /// @nodoc
  factory PlayerStreamInfo.fromJson(Map<String, dynamic> json) =>
      _$PlayerStreamInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$PlayerStreamInfoToJson(this);
}

/// Information about the video bitrate of the media resource being played.
@JsonSerializable(explicitToJson: true)
class SrcInfo {
  /// Construct the [SrcInfo].
  const SrcInfo({this.bitrateInKbps, this.name});

  /// The video bitrate (Kbps) of the media resource being played.
  @JsonKey(name: 'bitrateInKbps')
  final int? bitrateInKbps;

  /// The name of the media resource.
  @JsonKey(name: 'name')
  final String? name;

  /// @nodoc
  factory SrcInfo.fromJson(Map<String, dynamic> json) =>
      _$SrcInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$SrcInfoToJson(this);
}

/// The type of media metadata.
@JsonEnum(alwaysCreate: true)
enum MediaPlayerMetadataType {
  /// 0: The type is unknown.
  @JsonValue(0)
  playerMetadataTypeUnknown,

  /// 1: The type is SEI.
  @JsonValue(1)
  playerMetadataTypeSei,
}

/// Extensions functions of [MediaPlayerMetadataType].
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

/// Information related to the media player.
@JsonSerializable(explicitToJson: true)
class PlayerUpdatedInfo {
  /// Construct the [PlayerUpdatedInfo].
  const PlayerUpdatedInfo({this.playerId, this.deviceId});

  /// The ID of a media player.
  @JsonKey(name: 'playerId')
  final String? playerId;

  /// The ID of a deivce.
  @JsonKey(name: 'deviceId')
  final String? deviceId;

  /// @nodoc
  factory PlayerUpdatedInfo.fromJson(Map<String, dynamic> json) =>
      _$PlayerUpdatedInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$PlayerUpdatedInfoToJson(this);
}
