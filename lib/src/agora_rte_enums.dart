/// RTE enum definitions.
///
/// This file contains all RTE-related enum types that correspond to the
/// native SDK enums defined in the iOS and Android SDKs.
///
/// The native SDK enums are defined in:
/// - iOS: `AgoraRtcKit/AgoraRteEnumerates.h`
/// - Android: Similar enum definitions in the Java/Kotlin layer
///
/// **Since:** v4.4.0

/// RTE error codes.
///
/// These error codes are returned by various RTE APIs to indicate the result
/// of operations. Check the error code in callbacks or catch exceptions to
/// handle different error scenarios.
///
/// Corresponds to native `AgoraRteErrorCode` (iOS) / `RteErrorCode` (Android).
///
/// **Since:** v4.4.0
enum AgoraRteErrorCode {
  /// Success.
  ///
  /// The operation completed successfully.
  ///
  /// **Native value:** 0
  ok,

  /// Default error.
  ///
  /// A general error that is not specifically categorized. Check the error
  /// message for more details about the specific failure.
  ///
  /// **Native value:** 1
  errorDefault,

  /// Invalid argument.
  ///
  /// An invalid parameter was passed when calling the API. This usually
  /// indicates:
  /// - A null or empty required parameter
  /// - A parameter value outside the valid range
  /// - Incompatible parameter combinations
  ///
  /// **Native value:** 2
  errorInvalidArgument,

  /// Invalid operation.
  ///
  /// The requested operation is not supported or not allowed in the current
  /// state. For example:
  /// - Calling a method before initialization
  /// - Attempting an operation on a destroyed object
  /// - Using a feature on an unsupported platform
  ///
  /// **Native value:** 3
  errorInvalidOperation,

  /// Network error.
  ///
  /// A network-related error occurred, such as connection failure or timeout.
  ///
  /// **Native value:** 4
  errorNetworkError,

  /// Authentication failed.
  ///
  /// Authentication failed due to invalid credentials. This typically means:
  /// - Invalid or expired token
  /// - Invalid app ID
  /// - Incorrect channel credentials
  ///
  /// **Native value:** 5
  errorAuthenticationFailed,

  /// Stream not found.
  ///
  /// The requested stream could not be found. This happens when:
  /// - The broadcaster has left the channel
  /// - No stream is being published to the channel
  /// - The stream was interrupted
  ///
  /// **Native value:** 6
  errorStreamNotFound,
}

/// Player state.
///
/// Represents the current state of an RTE player. State changes are notified
/// through the [AgoraRtePlayerObserver.onStateChanged] callback.
///
/// **State transitions:**
/// ```
/// idle → opening → openCompleted → playing
///                                ↓         ↓
///                              paused  stopped/failed
///                                ↓
///                           playbackCompleted
/// ```
///
/// Corresponds to native `AgoraRtePlayerState` (iOS) / `PlayerState` (Android).
///
/// **Since:** v4.4.0
enum AgoraRtePlayerState {
  /// Idle state.
  ///
  /// The initial state of the player, before any URL has been opened.
  ///
  /// **Native value:** 0
  idle,

  /// Opening state.
  ///
  /// This state is entered after calling [AgoraRtePlayer.openWithUrl] and
  /// before the open operation completes.
  ///
  /// **Native value:** 1
  opening,

  /// Open completed state.
  ///
  /// The URL has been successfully opened and the player is ready to play.
  /// If `autoPlay` is enabled, playback will start automatically.
  ///
  /// **Native value:** 2
  openCompleted,

  /// Playing state.
  ///
  /// The player is actively playing the media content.
  ///
  /// **Native value:** 3
  playing,

  /// Paused state.
  ///
  /// Playback has been paused via [AgoraRtePlayer.pause].
  ///
  /// **Native value:** 4
  paused,

  /// Playback completed state.
  ///
  /// The media has finished playing to the end. For looped playback, this
  /// state may not be reached if [loopCount] is set to infinite (-1).
  ///
  /// **Native value:** 5
  playbackCompleted,

  /// Stopped state.
  ///
  /// The player has been stopped via [AgoraRtePlayer.stop]. The player must
  /// be stopped before opening a new URL if an error occurred.
  ///
  /// **Native value:** 6
  stopped,

  /// Failed state.
  ///
  /// An error has occurred during playback. Check the error parameter in
  /// [AgoraRtePlayerObserver.onStateChanged] for details. Call
  /// [AgoraRtePlayer.stop] before attempting to open a new URL.
  ///
  /// **Native value:** 7
  failed,
}

/// Player events.
///
/// Notifies about player events such as seeking, buffering, switching URLs, etc.
/// Events are delivered through the [AgoraRtePlayerObserver.onEvent] callback.
///
/// Corresponds to native `AgoraRtePlayerEvent` (iOS) / `PlayerEvent` (Android).
///
/// **Since:** v4.4.0
enum AgoraRtePlayerEvent {
  /// Seek operation started.
  ///
  /// Notified when seeking to a specified playback position begins.
  ///
  /// **Native value:** 0
  seekBegin,

  /// Seek operation completed.
  ///
  /// Notified when seeking to a specified playback position completes successfully.
  ///
  /// **Native value:** 1
  seekComplete,

  /// Seek operation failed.
  ///
  /// An error occurred while seeking to a new playback position.
  ///
  /// **Native value:** 2
  seekError,

  /// Buffer level low.
  ///
  /// The currently buffered data is insufficient to support smooth playback.
  /// You may want to show a loading indicator.
  ///
  /// **Native value:** 3
  bufferLow,

  /// Buffer level recovered.
  ///
  /// The buffered data is now sufficient to resume smooth playback.
  /// You can hide the loading indicator when this event is received.
  ///
  /// **Native value:** 4
  bufferRecover,

  /// Playback freeze started.
  ///
  /// Audio or video playback has started to freeze or stutter. Consider
  /// showing a loading indicator to inform the user.
  ///
  /// **Native value:** 5
  freezeStart,

  /// Playback freeze ended.
  ///
  /// Audio or video playback has recovered and is no longer freezing.
  ///
  /// **Native value:** 6
  freezeStop,

  /// One loop playback completed.
  ///
  /// Notified when one iteration of loop playback has finished. Only relevant
  /// when [loopCount] is greater than 1.
  ///
  /// **Native value:** 7
  oneLoopPlaybackCompleted,

  /// Authentication will expire.
  ///
  /// The URL authentication (token) will expire soon. You should:
  /// 1. Generate a new token
  /// 2. Construct a new RTE URL with the updated token
  /// 3. Call [AgoraRtePlayer.openWithUrl] to refresh the token
  ///
  /// **Native value:** 8
  authenticationWillExpire,

  /// ABR fallback to audio-only.
  ///
  /// Due to poor network conditions, adaptive bitrate (ABR) has degraded to
  /// audio-only mode. Video will resume when network improves.
  ///
  /// Consider showing a message to inform the user that only audio is playing.
  ///
  /// **Native value:** 9
  abrFallbackToAudioOnlyLayer,

  /// ABR recovered from audio-only.
  ///
  /// Network conditions have improved and playback has recovered from audio-only
  /// mode back to video mode.
  ///
  /// **Native value:** 10
  abrRecoverFromAudioOnlyLayer,

  /// URL switch started.
  ///
  /// Switching to a new URL has started (via [AgoraRtePlayer.switchWithUrl]).
  ///
  /// **Native value:** 11
  switchBegin,

  /// URL switch completed.
  ///
  /// Successfully switched to the new URL.
  ///
  /// **Native value:** 12
  switchComplete,

  /// URL switch failed.
  ///
  /// An error occurred while switching to a new URL.
  ///
  /// **Native value:** 13
  switchError,

  /// First video frame displayed.
  ///
  /// The first video frame has been rendered on screen.
  ///
  /// **Native value:** 14
  firstDisplayed,

  /// Cache file count limit reached.
  ///
  /// The number of cached files has reached the maximum allowed.
  ///
  /// **Native value:** 15
  reachCacheFileMaxCount,

  /// Cache file size limit reached.
  ///
  /// The total size of cached files has reached the maximum allowed.
  ///
  /// **Native value:** 16
  reachCacheFileMaxSize,

  /// Trying to open URL.
  ///
  /// An attempt to open a new URL has started.
  ///
  /// **Native value:** 17
  tryOpenStart,

  /// Successfully opened URL.
  ///
  /// The URL was successfully opened after one or more attempts.
  ///
  /// **Native value:** 18
  tryOpenSucceed,

  /// Failed to open URL.
  ///
  /// All attempts to open the URL have failed.
  ///
  /// **Native value:** 19
  tryOpenFailed,

  /// Audio track changed.
  ///
  /// The current audio track has changed.
  ///
  /// **Native value:** 20
  audioTrackChanged,
}

/// Video render mode.
///
/// Determines how video is displayed within the rendering view when the video
/// aspect ratio doesn't match the view aspect ratio.
///
/// Corresponds to native `AgoraRteVideoRenderMode` (iOS) / `VideoRenderMode` (Android).
///
/// **Since:** v4.4.0
enum AgoraRteVideoRenderMode {
  /// Hidden mode.
  ///
  /// Scales the video to fill the entire view, cropping any parts that exceed
  /// the view boundaries. This ensures the view is completely filled, but some
  /// content may be hidden.
  ///
  /// **Use when:** You want to avoid black bars and ensure the view is filled.
  ///
  /// **Native value:** 0
  hidden,

  /// Fit mode.
  ///
  /// Scales the video to fit entirely within the view, maintaining the aspect
  /// ratio. This may result in letter-boxing (black bars) if the aspect ratios
  /// don't match.
  ///
  /// **Use when:** You want to display the entire video content without cropping.
  ///
  /// **Native value:** 1
  fit,
}

/// Video mirror mode.
///
/// Controls whether the video should be mirrored (horizontally flipped) during
/// rendering.
///
/// Corresponds to native `AgoraRteVideoMirrorMode` (iOS) / `VideoMirrorMode` (Android).
///
/// **Since:** v4.4.0
enum AgoraRteVideoMirrorMode {
  /// Auto mode.
  ///
  /// The SDK automatically decides whether to enable mirroring based on the
  /// video source. Typically, the front camera is mirrored while the rear
  /// camera and screen share are not.
  ///
  /// **Native value:** 0
  auto,

  /// Mirror enabled.
  ///
  /// Always mirror (horizontally flip) the video.
  ///
  /// **Native value:** 1
  enabled,

  /// Mirror disabled.
  ///
  /// Never mirror the video, always display as-is.
  ///
  /// **Native value:** 2
  disabled,
}

/// Metadata type.
///
/// Specifies the type of metadata received through
/// [AgoraRtePlayerObserver.onMetadata].
///
/// Corresponds to native `AgoraRtePlayerMetadataType` (iOS) / `PlayerMetadataType` (Android).
///
/// **Since:** v4.4.0
enum AgoraRtePlayerMetadataType {
  /// SEI (Supplemental Enhancement Information) metadata.
  ///
  /// SEI data embedded in the video stream, typically used for carrying
  /// custom information like timestamps or application-specific data.
  ///
  /// **Native value:** 0
  sei,
}

/// ABR subscription layer.
///
/// Specifies which video quality layer to subscribe to when using adaptive
/// bitrate (ABR). This can be set in the RTE URL query parameter
/// `abr_subscription_layer` or via [AgoraRtePlayerConfig.abrSubscriptionLayer].
///
/// If ABR is not enabled, only high and low layers are available.
///
/// Corresponds to native `AgoraRteAbrSubscriptionLayer` (iOS) / `AbrSubscriptionLayer` (Android).
///
/// **Since:** v4.4.0
enum AgoraRteAbrSubscriptionLayer {
  /// High quality layer.
  ///
  /// Highest resolution and bitrate video stream.
  ///
  /// **Native value:** 0
  high,

  /// Low quality layer.
  ///
  /// Lowest resolution and bitrate video stream.
  ///
  /// **Native value:** 1
  low,

  /// Layer 1.
  ///
  /// Resolution and bitrate lower than high quality but higher than low quality.
  /// Only available when ABR is enabled.
  ///
  /// **Native value:** 2
  layer1,

  /// Layer 2.
  ///
  /// Resolution and bitrate lower than layer1.
  /// Only available when ABR is enabled.
  ///
  /// **Native value:** 3
  layer2,

  /// Layer 3.
  ///
  /// Resolution and bitrate lower than layer2.
  /// Only available when ABR is enabled.
  ///
  /// **Native value:** 4
  layer3,

  /// Layer 4.
  ///
  /// Resolution and bitrate lower than layer3.
  /// Only available when ABR is enabled.
  ///
  /// **Native value:** 5
  layer4,

  /// Layer 5.
  ///
  /// Resolution and bitrate lower than layer4.
  /// Only available when ABR is enabled.
  ///
  /// **Native value:** 6
  layer5,

  /// Layer 6.
  ///
  /// Resolution and bitrate lower than layer5.
  /// Only available when ABR is enabled.
  ///
  /// **Native value:** 7
  layer6,
}

/// ABR fallback layer.
///
/// Specifies how the player should adapt to poor network conditions when using
/// adaptive bitrate (ABR). This can be set in the RTE URL query parameter
/// `abr_fallback_layer` or via [AgoraRtePlayerConfig.abrFallbackLayer].
///
/// If ABR is not enabled, only disabled, low, and audioOnly options are available.
///
/// Corresponds to native `AgoraRteAbrFallbackLayer` (iOS) / `AbrFallbackLayer` (Android).
///
/// **Since:** v4.4.0
enum AgoraRteAbrFallbackLayer {
  /// Fallback disabled.
  ///
  /// When network quality is poor, do not automatically switch to a lower
  /// quality stream. May still use scalable video coding (SVC) but will
  /// maintain the high quality video resolution.
  ///
  /// **Use when:** You want to maintain video quality even if this causes buffering.
  ///
  /// **Native value:** 0
  disabled,

  /// Fallback to low quality.
  ///
  /// Default setting. In poor network conditions, automatically switch to the
  /// low quality video stream.
  ///
  /// **Native value:** 1
  low,

  /// Fallback to audio-only.
  ///
  /// In poor network conditions, first fallback to the low quality layer.
  /// If network continues to degrade, fallback through intermediate layers
  /// (layer1-layer6 if they exist). In extremely poor network conditions,
  /// fallback to audio-only mode.
  ///
  /// **Use when:** You want to maintain the connection even if video quality must be
  /// sacrificed.
  ///
  /// **Native value:** 2
  audioOnly,

  /// Fallback to layer 1.
  ///
  /// In poor network conditions, the lowest fallback layer is layer1.
  /// Only available when ABR is enabled and the relevant layer exists.
  ///
  /// **Native value:** 3
  layer1,

  /// Fallback to layer 2.
  ///
  /// In poor network conditions, the lowest fallback layer is layer2.
  /// Only available when ABR is enabled and the relevant layer exists.
  ///
  /// **Native value:** 4
  layer2,

  /// Fallback to layer 3.
  ///
  /// In poor network conditions, the lowest fallback layer is layer3.
  /// Only available when ABR is enabled and the relevant layer exists.
  ///
  /// **Native value:** 5
  layer3,

  /// Fallback to layer 4.
  ///
  /// In poor network conditions, the lowest fallback layer is layer4.
  /// Only available when ABR is enabled and the relevant layer exists.
  ///
  /// **Native value:** 6
  layer4,

  /// Fallback to layer 5.
  ///
  /// In poor network conditions, the lowest fallback layer is layer5.
  /// Only available when ABR is enabled and the relevant layer exists.
  ///
  /// **Native value:** 7
  layer5,

  /// Fallback to layer 6.
  ///
  /// In poor network conditions, the lowest fallback layer is layer6.
  /// Only available when ABR is enabled and the relevant layer exists.
  ///
  /// **Native value:** 8
  layer6,
}
