import 'package:json_annotation/json_annotation.dart';
import '/src/_serializable.dart';
import '/src/binding_forward_export.dart';
import 'agora_rte_enums.dart';
part 'agora_rte_config.g.dart';

/// RTE engine configuration.
///
/// Contains initial settings for the RTE (Real-Time Engagement) engine including
/// app ID, logging settings, regional routing, and proxy configuration.
///
/// This configuration must be provided when initializing the RTE engine via
/// [AgoraRte.createWithConfig].
///
/// Corresponds to native `AgoraRteConfig` (iOS) / `Config` (Android).
///
/// **Since:** v4.4.0
///
/// **Example:**
/// ```dart
/// final config = AgoraRteConfig(
///   appId: 'your_app_id_from_console',
///   logFolder: '/path/to/logs',
///   logFileSize: 10 * 1024 * 1024,  // 10 MB
///   areaCode: 0x00000001,  // North America
/// );
/// final rte = createAgoraRte();
/// await rte.createWithConfig(config);
/// ```
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AgoraRteConfig implements AgoraSerializable {
  /// Agora app ID obtained from Agora Console.
  ///
  /// The app ID identifies your project and organization. You must provide a
  /// valid app ID to use RTE services. Get your app ID from:
  /// https://console.agora.io/
  ///
  /// **Required:** Yes, must be set before calling [AgoraRte.createWithConfig]
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'appId')
  final String? appId;

  /// Directory path for storing log files.
  ///
  /// Specifies where the SDK should write log files. If not set, logs are
  /// written to the default platform-specific directory:
  /// - iOS: Application's `Documents` directory
  /// - Android: Application's external storage directory
  ///
  /// **Example:** `'/sdcard/my_app/logs'` (Android)
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'logFolder')
  final String? logFolder;

  /// Maximum size of a single log file in bytes.
  ///
  /// When a log file reaches this size, the SDK creates a new log file.
  /// This helps manage disk space usage.
  ///
  /// **Default:** Platform-specific default size
  ///
  /// **Example:** `10 * 1024 * 1024` (10 MB)
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'logFileSize')
  final int? logFileSize;

  /// Regional routing area code.
  ///
  /// Specifies which Agora server region(s) the SDK should connect to.
  /// This can improve connection quality by routing to geographically closer
  /// servers. Multiple regions can be combined using bitwise OR.
  ///
  /// Common values:
  /// - `0x00000001`: North America
  /// - `0x00000002`: Europe
  /// - `0x00000004`: Asia excluding China
  /// - `0x00000008`: China
  /// - `0xFFFFFFFF`: Global (default)
  ///
  /// **Default:** `0xFFFFFFFF` (Global)
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'areaCode')
  final int? areaCode;

  /// Cloud proxy configuration string.
  ///
  /// Enables connecting through a cloud proxy for environments with restricted
  /// network access (e.g., corporate firewalls). Consult Agora support for
  /// proxy configuration details.
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'cloudProxy')
  final String? cloudProxy;

  /// Advanced JSON parameters.
  ///
  /// Optional JSON-formatted string for setting advanced engine options.
  /// Consult Agora support for available parameters and their usage.
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'jsonParameter')
  final String? jsonParameter;

  /// Whether to use string UIDs instead of integer UIDs.
  ///
  /// When `true`, the RTE engine will use string-based user IDs.
  /// When `false` (default), integer UIDs are used.
  ///
  /// **Default:** `false`
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'useStringUid')
  final bool? useStringUid;

  AgoraRteConfig({
    this.appId,
    this.logFolder,
    this.logFileSize,
    this.areaCode,
    this.cloudProxy,
    this.jsonParameter,
    this.useStringUid,
  });

  /// @nodoc
  factory AgoraRteConfig.fromJson(Map<String, dynamic> json) =>
      _$AgoraRteConfigFromJson(json);

  /// @nodoc
  @override
  Map<String, dynamic> toJson() => _$AgoraRteConfigToJson(this);
}

/// A rectangular region.
///
/// Represents a rectangle defined by its top-left corner position (x, y) and
/// size (width, height). Used for defining crop areas, view layouts, and other
/// rectangular regions.
///
/// Coordinates are in pixels and relative to the parent region/view.
///
/// Corresponds to native `Rect` (iOS/Android).
///
/// **Since:** v4.4.0
///
/// **Example:**
/// ```dart
/// // Define a 1920x1080 crop area starting at origin
/// final cropArea = AgoraRteRect(
///   x: 0,
///   y: 0,
///   width: 1920,
///   height: 1080,
/// );
///
/// // Use with canvas config
/// final canvasConfig = AgoraRteCanvasConfig(cropArea: cropArea);
/// ```
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AgoraRteRect implements AgoraSerializable {
  /// X-coordinate of the top-left corner.
  ///
  /// Horizontal position in pixels, relative to the parent.
  ///
  /// **Default:** 0
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'x')
  final int? x;

  /// Y-coordinate of the top-left corner.
  ///
  /// Vertical position in pixels, relative to the parent.
  ///
  /// **Default:** 0
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'y')
  final int? y;

  /// Width of the rectangle in pixels.
  ///
  /// **Default:** 0
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'width')
  final int? width;

  /// Height of the rectangle in pixels.
  ///
  /// **Default:** 0
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'height')
  final int? height;

  const AgoraRteRect({
    this.x = 0,
    this.y = 0,
    this.width = 0,
    this.height = 0,
  });

  /// @nodoc
  factory AgoraRteRect.fromJson(Map<String, dynamic> json) =>
      _$AgoraRteRectFromJson(json);

  /// @nodoc
  @override
  Map<String, dynamic> toJson() => _$AgoraRteRectToJson(this);
}

/// Configuration for adding a view to a canvas.
///
/// Provides additional options when binding a native view to an RTE canvas using
/// [AgoraRteCanvas.addView]. Currently supports specifying a crop area.
///
/// Corresponds to native `ViewConfig` (iOS/Android).
///
/// **Since:** v4.4.0
///
/// **Example:**
/// ```dart
/// final viewConfig = AgoraRteViewConfig(
///   cropArea: AgoraRteRect(x: 100, y: 100, width: 800, height: 600),
/// );
/// await canvas.addView(viewPtr, config: viewConfig);
/// ```
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AgoraRteViewConfig implements AgoraSerializable {
  /// Crop area for the view.
  ///
  /// Defines a rectangular region within the video frame to display in this
  /// specific view. Only the pixels within this region will be rendered.
  ///
  /// If not set, the entire video frame is displayed based on the canvas's
  /// render mode.
  ///
  /// **See also:** [AgoraRteRect]
  ///
  /// **Since:** v4.4.0
  @JsonKey(
    name: 'cropArea',
    toJson: _cropAreaToJson,
    fromJson: _cropAreaFromJson,
  )
  final AgoraRteRect? cropArea;

  const AgoraRteViewConfig({this.cropArea});

  /// @nodoc
  factory AgoraRteViewConfig.fromJson(Map<String, dynamic> json) =>
      _$AgoraRteViewConfigFromJson(json);

  /// @nodoc
  @override
  Map<String, dynamic> toJson() => _$AgoraRteViewConfigToJson(this);
}

/// Helper converters for AgoraRteViewConfig
Map<String, dynamic>? _cropAreaToJson(AgoraRteRect? rect) => rect?.toJson();
AgoraRteRect? _cropAreaFromJson(dynamic value) {
  if (value == null) return null;
  if (value is Map) {
    return AgoraRteRect.fromJson(Map<String, dynamic>.from(value));
  }
  return null;
}

/// Player performance statistics.
///
/// Contains real-time playback statistics including frame rates and bitrates.
/// These statistics are typically reported through the
/// [AgoraRtePlayerObserver.onPlayerInfoUpdated] callback.
///
/// Use these metrics to monitor playback performance and diagnose issues like
/// frame drops or low bitrate.
///
/// Corresponds to native `PlayerStats` (iOS/Android).
///
/// **Since:** v4.4.0
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AgoraRtePlayerStats implements AgoraSerializable {
  /// Video decode frame rate in frames per second (fps).
  ///
  /// The rate at which video frames are being decoded. A low value may
  /// indicate performance issues or network problems.
  ///
  /// **Unit:** fps (frames per second)
  ///
  /// **Default:** 0
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'videoDecodeFrameRate')
  final int? videoDecodeFrameRate;

  /// Video render frame rate in frames per second (fps).
  ///
  /// The rate at which decoded video frames are being rendered to the screen.
  /// This should typically match the decode frame rate for smooth playback.
  ///
  /// **Unit:** fps (frames per second)
  ///
  /// **Default:** 0
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'videoRenderFrameRate')
  final int? videoRenderFrameRate;

  /// Video bitrate in bits per second (bps).
  ///
  /// The current bitrate of the video stream being received. This value
  /// fluctuates based on network conditions and ABR (adaptive bitrate) decisions.
  ///
  /// **Unit:** bps (bits per second)
  ///
  ///   **Default:** 0
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'videoBitrate')
  final int? videoBitrate;

  /// Audio bitrate in bits per second (bps).
  ///
  /// The current bitrate of the audio stream being received.
  ///
  /// **Unit:** bps (bits per second)
  ///
  /// **Default:** 0
  ///
  /// **Since:** v4.4.0
  final int? audioBitrate;

  const AgoraRtePlayerStats({
    this.videoDecodeFrameRate = 0,
    this.videoRenderFrameRate = 0,
    this.videoBitrate = 0,
    this.audioBitrate = 0,
  });

  /// @nodoc
  factory AgoraRtePlayerStats.fromJson(Map<String, dynamic> json) =>
      _$AgoraRtePlayerStatsFromJson(json);

  /// @nodoc
  @override
  Map<String, dynamic> toJson() => _$AgoraRtePlayerStatsToJson(this);
}

/// Player information.
///
/// Contains detailed information about the current state and properties of
/// an RTE player, including playback state, media duration, available tracks,
/// video dimensions, mute status, audio properties, and the currently playing URL.
///
/// This information is typically retrieved using [AgoraRtePlayer.getInfo] or
/// provided in the [AgoraRtePlayerObserver.onPlayerInfoUpdated] callback.
///
/// Corresponds to native `PlayerInfo` (iOS/Android).
///
/// **Since:** v4.4.0
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AgoraRtePlayerInfo implements AgoraSerializable {
  /// Current player state.
  ///
  /// The state value corresponds to [AgoraRtePlayerState] enum values:
  /// - `0`: [AgoraRtePlayerState.idle]
  /// - `1`: [AgoraRtePlayerState.opening]
  /// - `2`: [AgoraRtePlayerState.openCompleted]
  /// - `3`: [AgoraRtePlayerState.playing]
  /// - `4`: [AgoraRtePlayerState.paused]
  /// - `5`: [AgoraRtePlayerState.playbackCompleted]
  /// - `6`: [AgoraRtePlayerState.stopped]
  /// - `7`: [AgoraRtePlayerState.failed]
  ///
  /// **Default:** 0 ([AgoraRtePlayerState.idle])
  ///
  /// **See also:** [AgoraRtePlayerState]
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'state')
  final int? state;

  /// Total duration of the media in milliseconds.
  ///
  /// For live streams or unknown duration media, this value may be 0.
  ///
  /// **Unit:** milliseconds
  ///
  /// **Default:** 0
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'duration')
  final int? duration;

  /// Number of media streams in the content.
  ///
  /// Indicates how many separate streams are available (e.g., multiple
  /// audio tracks or subtitle tracks).
  ///
  /// **Default:** 0
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'streamCount')
  final int? streamCount;

  /// Whether the media contains an audio track.
  ///
  /// **Default:** `false`
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'hasAudio')
  final bool? hasAudio;

  /// Whether the media contains a video track.
  ///
  /// **Default:** `false`
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'hasVideo')
  final bool? hasVideo;

  /// Whether audio playback is currently muted.
  ///
  /// **Default:** `false`
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'isAudioMuted')
  final bool? isAudioMuted;

  /// Whether video rendering is currently muted (black screen).
  ///
  /// **Default:** `false`
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'isVideoMuted')
  final bool? isVideoMuted;

  /// Height of the video in pixels.
  ///
  /// **Unit:** pixels
  ///
  /// **Default:** 0
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'videoHeight')
  final int? videoHeight;

  /// Width of the video in pixels.
  ///
  /// **Unit:** pixels
  ///
  /// **Default:** 0
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'videoWidth')
  final int? videoWidth;

  /// Current ABR (adaptive bitrate) subscription layer.
  ///
  /// Indicates which video quality layer is currently being received.
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

  /// Audio sample rate in Hz.
  ///
  /// Common values: 44100 Hz, 48000 Hz.
  ///
  /// **Unit:** Hz (Hertz)
  ///
  /// **Default:** 0
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'audioSampleRate')
  final int? audioSampleRate;

  /// Number of audio channels.
  ///
  /// Common values:
  /// - `1`: Mono
  /// - `2`: Stereo
  ///
  /// **Default:** 0
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'audioChannels')
  final int? audioChannels;

  /// Audio bits per sample.
  ///
  /// Common values: 8, 16, 24, 32.
  ///
  /// **Unit:** bits
  ///
  /// **Default:** 0
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'audioBitsPerSample')
  final int? audioBitsPerSample;

  /// Currently playing media URL.
  ///
  /// The URL that was passed to [AgoraRtePlayer.openWithUrl] or
  /// [AgoraRtePlayer.switchWithUrl].
  ///
  /// **Default:** Empty string
  ///
  /// **Since:** v4.4.0
  @JsonKey(name: 'currentUrl')
  final String? currentUrl;

  const AgoraRtePlayerInfo({
    this.state = 0,
    this.duration = 0,
    this.streamCount = 0,
    this.hasAudio = false,
    this.hasVideo = false,
    this.isAudioMuted = false,
    this.isVideoMuted = false,
    this.videoHeight = 0,
    this.videoWidth = 0,
    this.abrSubscriptionLayer = AgoraRteAbrSubscriptionLayer.high,
    this.audioSampleRate = 0,
    this.audioChannels = 0,
    this.audioBitsPerSample = 0,
    this.currentUrl = '',
  });

  /// @nodoc
  factory AgoraRtePlayerInfo.fromJson(Map<String, dynamic> json) =>
      _$AgoraRtePlayerInfoFromJson(json);

  /// @nodoc
  @override
  Map<String, dynamic> toJson() => _$AgoraRtePlayerInfoToJson(this);
}

/// Helper converters for AgoraRtePlayerInfo
int? _abrSubscriptionLayerToJson(AgoraRteAbrSubscriptionLayer? layer) =>
    layer?.index;
AgoraRteAbrSubscriptionLayer? _abrSubscriptionLayerFromJson(dynamic value) {
  if (value == null) return null;
  if (value is int &&
      value >= 0 &&
      value < AgoraRteAbrSubscriptionLayer.values.length) {
    return AgoraRteAbrSubscriptionLayer.values[value];
  }
  return null;
}
