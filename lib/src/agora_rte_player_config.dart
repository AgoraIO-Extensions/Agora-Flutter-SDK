import '/src/_serializable.dart';
import '/src/binding_forward_export.dart';
import '/src/agora_rte_enums.dart';
part 'agora_rte_player_config.g.dart';

/// Player configuration.
///
/// Contains settings that control player behavior including auto-play, playback
/// speed, volume, audio/video track selection, loop count, and adaptive bitrate
/// (ABR) options.
///
/// Configuration can be set when creating a player with [AgoraRte.createPlayer],
/// or updated anytime using [AgoraRtePlayer.setConfigs].
///
/// Corresponds to native `AgoraRtePlayerConfig` (iOS) / `PlayerConfig` (Android).
///
/// **Since:** v4.4.0
///
/// **Example:**
/// ```dart
/// final config = AgoraRtePlayerConfig(
///   autoPlay: true,
///   playbackSpeed: 100,  // 1x speed
///   playoutVolume: 80,   // 80% volume
///   loopCount: 1,        // Play once
///   abrSubscriptionLayer: AgoraRteAbrSubscriptionLayer.high,
///   abrFallbackLayer: AgoraRteAbrFallbackLayer.low,
/// );
/// final player = await rte.createPlayer(config);
/// ```
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AgoraRtePlayerConfig implements AgoraSerializable {
  /// Whether to automatically start playback after successfully opening a URL.
  ///
  /// When `true`, playback starts automatically after [AgoraRtePlayer.openWithUrl]
  /// successfully completes. When `false`, you must manually call
  /// [AgoraRtePlayer.play] to start playback.
  ///
  /// **Default:** `true`
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'autoPlay')
  final bool? autoPlay;

  /// Playback speed percentage.
  ///
  /// Controls the speed of media playback. Valid range is `[50, 400]`:
  /// - `50` = 0.5x speed (half speed)
  /// - `100` = 1.0x speed (normal speed)
  /// - `200` = 2.0x speed (double speed)
  /// - `400` = 4.0x speed (maximum speed)
  ///
  /// This setting can be applied after calling [AgoraRtePlayer.openWithUrl].
  ///
  /// **Range:** [50, 400]
  ///
  /// **Default:** 100 (normal speed)
  ///
  /// **Since:** v4.5.1
  @JsonKey(name: 'playbackSpeed')
  final int? playbackSpeed;

  /// Index of the audio track to play locally.
  ///
  /// For media with multiple audio tracks, specifies which track to play.
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'playoutAudioTrackIdx')
  final int? playoutAudioTrackIdx;

  /// Index of the audio track to publish to remote users.
  ///
  /// For media with multiple audio tracks, specifies which track to publish.
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'publishAudioTrackIdx')
  final int? publishAudioTrackIdx;

  /// General audio track index.
  ///
  /// Sets both playout and publish audio track to the same index.
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'audioTrackIdx')
  final int? audioTrackIdx;

  /// Subtitle track index.
  ///
  /// For media with embedded subtitles, specifies which subtitle track to use.
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'subtitleTrackIdx')
  final int? subtitleTrackIdx;

  /// External subtitle track index.
  ///
  /// Index of an externally loaded subtitle track.
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'externalSubtitleTrackIdx')
  final int? externalSubtitleTrackIdx;

  /// Audio pitch adjustment.
  ///
  /// Adjusts the pitch of the audio without changing playback speed.
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'audioPitch')
  final int? audioPitch;

  /// Local playback volume.
  ///
  /// Controls the volume of audio playback on the local device. Valid range
  /// is `[0, 400]`:
  /// - `0` = Muted
  /// - `100` = Original volume
  /// - `400` = 4x amplification (maximum)
  ///
  /// **Range:** [0, 400]
  ///
  /// **Default:** 100 (original volume)
  ///
  /// **Since:** v4.5.1
  @JsonKey(name: 'playoutVolume')
  final int? playoutVolume;

  /// Audio playback delay in milliseconds.
  ///
  /// Adds a delay to audio playback, useful for synchronizing with video or
  /// other media streams.
  ///
  /// **Unit:** milliseconds
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'audioPlaybackDelay')
  final int? audioPlaybackDelay;

  /// Audio dual mono mode.
  ///
  /// Specifies how to handle dual mono audio channels.
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'audioDualMonoMode')
  final int? audioDualMonoMode;

  /// Publish volume.
  ///
  /// Controls the volume when publishing audio to remote users. Valid range
  /// is `[0, 100]`.
  ///
  /// **Range:** [0, 100]
  ///
  /// **Default:** 100
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'publishVolume')
  final int? publishVolume;

  /// Number of times to loop the media.
  ///
  /// Specifies how many times the media should play:
  /// - `1` = Play once (no looping)
  /// - `2` = Play twice
  /// - `-1` = Loop indefinitely until [AgoraRtePlayer.stop] is called
  ///
  /// When playback completes one loop, the [AgoraRtePlayerEvent.oneLoopPlaybackCompleted]
  /// event is triggered.
  ///
  /// **Default:** 1 (play once)
  ///
  /// **Since:** v4.5.1
  @JsonKey(name: 'loopCount')
  final int? loopCount;

  /// Advanced JSON parameters.
  ///
  /// Optional JSON-formatted string for setting advanced player options.
  /// Consult Agora support for available parameters and their usage.
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'jsonParameter')
  final String? jsonParameter;

  /// Adaptive bitrate (ABR) subscription layer.
  ///
  /// Specifies which quality layer to subscribe to when ABR is enabled.
  /// If ABR is not enabled, only [AgoraRteAbrSubscriptionLayer.high] and
  /// [AgoraRteAbrSubscriptionLayer.low] are available.
  ///
  /// After enabling ABR, you can switch between any available layer (high, low,
  /// layer1-layer6) based on network conditions or user preference.
  ///
  /// **Default:** [AgoraRteAbrSubscriptionLayer.high]
  ///
  /// **See also:** [AgoraRteAbrSubscriptionLayer]
  ///
  /// **Since:** v4.4.0
  @JsonKey(
    name: 'abrSubscriptionLayer',
    toJson: _abrSubscriptionLayerToJson,
    fromJson: _abrSubscriptionLayerFromJson,
  )
  final AgoraRteAbrSubscriptionLayer? abrSubscriptionLayer;

  /// Adaptive bitrate (ABR) fallback layer option.
  ///
  /// Determines how the player adapts to poor network conditions:
  /// - If ABR is not enabled: Can only set [AgoraRteAbrFallbackLayer.disabled],
  ///   [AgoraRteAbrFallbackLayer.low], or [AgoraRteAbrFallbackLayer.audioOnly]
  /// - If ABR is enabled: Can use all values including layer1-layer6 options
  ///
  /// When set to [AgoraRteAbrFallbackLayer.low] (default), the player will
  /// automatically switch to low quality video when network degrades. With
  /// [AgoraRteAbrFallbackLayer.audioOnly], it can fallback all the way to
  /// audio-only mode in very poor network conditions.
  ///
  /// **Default:** [AgoraRteAbrFallbackLayer.low]
  ///
  /// **See also:** [AgoraRteAbrFallbackLayer]
  ///
  /// **Since:** v4.4.0
  @JsonKey(
    name: 'abrFallbackLayer',
    toJson: _abrFallbackLayerToJson,
    fromJson: _abrFallbackLayerFromJson,
  )
  final AgoraRteAbrFallbackLayer? abrFallbackLayer;

  /// @nodoc
  const AgoraRtePlayerConfig({
    this.autoPlay,
    this.playbackSpeed,
    this.playoutAudioTrackIdx,
    this.publishAudioTrackIdx,
    this.audioTrackIdx,
    this.subtitleTrackIdx,
    this.externalSubtitleTrackIdx,
    this.audioPitch,
    this.playoutVolume,
    this.audioPlaybackDelay,
    this.audioDualMonoMode,
    this.publishVolume,
    this.loopCount,
    this.jsonParameter,
    this.abrSubscriptionLayer,
    this.abrFallbackLayer,
  });

  /// @nodoc
  factory AgoraRtePlayerConfig.fromJson(Map<String, dynamic> json) =>
      _$AgoraRtePlayerConfigFromJson(json);

  /// @nodoc
  @override
  Map<String, dynamic> toJson() => _$AgoraRtePlayerConfigToJson(this);
}

// Enum conversion helper functions
int? _abrSubscriptionLayerToJson(AgoraRteAbrSubscriptionLayer? layer) {
  return layer?.index;
}

AgoraRteAbrSubscriptionLayer? _abrSubscriptionLayerFromJson(Object? json) {
  if (json is int &&
      json >= 0 &&
      json < AgoraRteAbrSubscriptionLayer.values.length) {
    return AgoraRteAbrSubscriptionLayer.values[json];
  }
  return null;
}

int? _abrFallbackLayerToJson(AgoraRteAbrFallbackLayer? layer) {
  return layer?.index;
}

AgoraRteAbrFallbackLayer? _abrFallbackLayerFromJson(Object? json) {
  if (json is int &&
      json >= 0 &&
      json < AgoraRteAbrFallbackLayer.values.length) {
    return AgoraRteAbrFallbackLayer.values[json];
  }
  return null;
}
