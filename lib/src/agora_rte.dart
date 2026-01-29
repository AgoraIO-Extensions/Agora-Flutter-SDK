import 'package:agora_rtc_engine/agora_rte_engine.dart';
import 'package:flutter/foundation.dart';
export 'agora_rte_config.dart' show AgoraRteRect, AgoraRteViewConfig, AgoraRtePlayerStats, AgoraRtePlayerInfo;

/// RTE engine observer.
///
/// Receives RTE engine-level events and notifications. Currently a placeholder
/// for future RTE lifecycle callbacks.
///
/// Corresponds to native `AgoraRTEDelegate` (iOS) / RTE callbacks (Android).
///
/// **Since:** v4.4.0
abstract class AgoraRteObserver {}

/// RTE player observer.
///
/// Implement this interface to receive player event callbacks including state
/// changes, playback position updates, resolution changes, player events,
/// metadata, player info updates, and audio volume indications.
///
/// Register the observer using [AgoraRtePlayer.registerObserver] and unregister
/// using [AgoraRtePlayer.unregisterObserver].
///
/// Corresponds to native `AgoraRtePlayerObserver` (iOS) / `PlayerObserver` (Android).
///
/// **Since:** v4.4.0
///
/// **Example:**
/// ```dart
/// class MyPlayerObserver extends AgoraRtePlayerObserver {
///   @override
///   void onStateChanged(AgoraRtePlayerState oldState,
///       AgoraRtePlayerState newState, AgoraRteErrorCode? error) {
///     print('Player state: $oldState -> $newState');
///     if (error != null && error != AgoraRteErrorCode.ok) {
///       print('Error: $error');
///     }
///   }
///
///   @override
///   void onPositionChanged(int currentTime, int utcTime) {
///     print('Position: $currentTime ms');
///   }
///
///   // Implement other callbacks...
/// }
///
/// final observer = MyPlayerObserver();
/// await player.registerObserver(observer);
/// ```
abstract class AgoraRtePlayerObserver {
  /// Called when the player state changes.
  ///
  /// This callback is triggered whenever the player transitions between states
  /// such as idle, opening, playing, paused, stopped, or failed.
  ///
  /// **Parameters:**
  /// - [oldState]: The previous state before the transition.
  /// - [newState]: The new state after the transition.
  /// - [error]: Error code if the state change is due to an error. If the
  ///   transition was successful, this will be [AgoraRteErrorCode.ok] or `null`.
  ///
  /// **Example Usage:**
  /// ```dart
  /// @override
  /// void onStateChanged(AgoraRtePlayerState oldState,
  ///     AgoraRtePlayerState newState, AgoraRteErrorCode? error) {
  ///   if (newState == AgoraRtePlayerState.failed) {
  ///     print('Player failed with error: $error');
  ///   } else if (newState == AgoraRtePlayerState.playing) {
  ///     print('Playback started successfully');
  ///   }
  /// }
  /// ```
  ///
  /// **See also:**
  /// - [AgoraRtePlayerState]
  /// - [AgoraRteErrorCode]
  ///
  /// **Since:** v4.4.0
  void onStateChanged(AgoraRtePlayerState oldState, AgoraRtePlayerState newState,
      AgoraRteErrorCode? error);

  /// Called when the playback position updates.
  ///
  /// This callback is triggered periodically during playback (typically every
  /// 1 second) to report the current playback position.
  ///
  /// **Parameters:**
  /// - [currentTime]: Current playback position in milliseconds from the start
  ///   of the media.
  /// - [utcTime]: UTC timestamp in milliseconds. For RTE URLs, this represents
  ///   the absolute UTC time of the current frame. For regular URLs, this may
  ///   be 0.
  ///
  /// **Example Usage:**
  /// ```dart
  /// @override
  /// void onPositionChanged(int currentTime, int utcTime) {
  ///   setState(() {
  ///     _currentPosition = currentTime;
  ///   });
  /// }
  /// ```
  ///
  /// **Since:** v4.4.0
  void onPositionChanged(int currentTime, int utcTime);

  /// Called when the video resolution changes.
  ///
  /// This callback is triggered when the video dimensions change, which can
  /// happen due to ABR layer switching, video track changes, or when the first
  /// frame is decoded.
  ///
  /// **Parameters:**
  /// - [width]: New video width in pixels.
  /// - [height]: New video height in pixels.
  ///
  /// **Example Usage:**
  /// ```dart
  /// @override
  /// void onResolutionChanged(int width, int height) {
  ///   print('Video resolution changed to: ${width}x$height');
  /// }
  /// ```
  ///
  /// **Since:** v4.4.0
  void onResolutionChanged(int width, int height);

  /// Called when a player event occurs.
  ///
  /// Player events include seeking, buffering, URL switching, first frame
  /// display, cache limits, and network fallback events.
  ///
  /// **Parameters:**
  /// - [event]: The event that occurred. See [AgoraRtePlayerEvent] for all
  ///   possible events.
  ///
  /// **Example Usage:**
  /// ```dart
  /// @override
  /// void onEvent(AgoraRtePlayerEvent event) {
  ///   switch (event) {
  ///     case AgoraRtePlayerEvent.bufferLow:
  ///       setState(() => _isBuffering = true);
  ///       break;
  ///     case AgoraRtePlayerEvent.bufferRecover:
  ///       setState(() => _isBuffering = false);
  ///       break;
  ///     case AgoraRtePlayerEvent.authenticationWillExpire:
  ///       _refreshToken();
  ///       break;
  ///   }
  /// }
  /// ```
  ///
  /// **See also:** [AgoraRtePlayerEvent]
  ///
  /// **Since:** v4.4.0
  void onEvent(AgoraRtePlayerEvent event);

  /// Called when metadata is received from the media stream.
  ///
  /// Metadata such as SEI (Supplemental Enhancement Information) embedded in
  /// the video stream is delivered through this callback.
  ///
  /// **Parameters:**
  /// - [type]: The type of metadata received.
  /// - [data]: The raw metadata bytes.
  ///
  /// **Example Usage:**
  /// ```dart
  /// @override
  /// void onMetadata(AgoraRtePlayerMetadataType type, Uint8List data) {
  ///   if (type == AgoraRtePlayerMetadataType.sei) {
  ///     final seiString = utf8.decode(data);
  ///     print('Received SEI: $seiString');
  ///   }
  /// }
  /// ```
  ///
  /// **See also:** [AgoraRtePlayerMetadataType]
  ///
  /// **Since:** v4.4.0
  void onMetadata(AgoraRtePlayerMetadataType type, Uint8List data);

  /// Called when player information is updated.
  ///
  /// This callback reports changes to player information such as media duration,
  /// available tracks, video dimensions, mute status, audio properties, and
  /// current URL.
  ///
  /// **Parameters:**
  /// - [info]: Updated player information.
  ///
  /// **Example Usage:**
  /// ```dart
  /// @override
  /// void onPlayerInfoUpdated(AgoraRtePlayerInfo info) {
  ///   print('Duration: ${info.duration} ms');
  ///   print('Video: ${info.videoWidth}x${info.videoHeight}');
  /// }
  /// ```
  ///
  /// **See also:** [AgoraRtePlayerInfo]
  ///
  /// **Since:** v4.4.0
  void onPlayerInfoUpdated(AgoraRtePlayerInfo info);

  /// Called periodically with the current audio volume level.
  ///
  /// This callback is triggered at regular intervals (typically every 200ms)
  /// to report the audio volume level.
  ///
  /// **Parameters:**
  /// - [volume]: Audio volume level in range [0, 255], where 0 is silent and
  ///   255 is maximum volume.
  ///
  /// **Example Usage:**
  /// ```dart
  /// @override
  /// void onAudioVolumeIndication(int volume) {
  ///   setState(() {
  ///     _volumeLevel = volume / 255.0;
  ///   });
  /// }
  /// ```
  ///
  /// **Since:** v4.4.0
  void onAudioVolumeIndication(int volume);
}

/// RTE main interface.
///
/// The main entry point for RTE (Real-Time Engagement) functionality. Manages
/// the RTE engine lifecycle including initialization, configuration, and
/// creation/destruction of players and canvases.
///
/// Obtain an instance using [createAgoraRte]. The lifecycle pattern is:
/// 1. Create RTE instance with [createAgoraRte]
/// 2. Initialize with [createWithConfig]
/// 3. Initialize media engine with [initMediaEngine]
/// 4. Create players and canvases as needed
/// 5. Clean up with [destroy] when done
///
/// Corresponds to native `AgoraRTE` (iOS) / `Rte` (Android).
///
/// **Since:** v4.4.0
///
/// **Example:**
/// ```dart
/// // Initialize RTE
/// final rte = createAgoraRte();
/// await rte.createWithConfig(AgoraRteConfig(appId: 'your_app_id'));
/// await rte.initMediaEngine();
///
/// // Create player and canvas
/// final player = await rte.createPlayer(AgoraRtePlayerConfig());
/// final canvas = await rte.createCanvas(AgoraRteCanvasConfig());
///
/// // Clean up
/// await rte.destroyPlayer(player.playerId);
/// await rte.destroyCanvas(canvas.canvasId);
/// await rte.destroy();
/// ```
abstract class AgoraRte {
  /// Initializes the RTE engine with the given configuration.
  ///
  /// This must be called before using any other RTE functionality. The [config]
  /// must include a valid [AgoraRteConfig.appId].
  ///
  /// **Parameters:**
  /// - [config]: Engine configuration including app ID, logging settings, and
  ///   regional routing options.
  ///
  /// **Possible Errors:**
  /// - [AgoraRteErrorCode.errorInvalidArgument]: Invalid configuration (e.g., empty app ID).
  ///
  /// **See also:**
  /// - [AgoraRteConfig]
  /// - [initMediaEngine]
  ///
  /// **Since:** v4.4.0
  Future<void> createWithConfig(AgoraRteConfig config);

  /// Initializes the media engine.
  ///
  /// This must be called after [createWithConfig] and before creating any
  /// players or starting playback. It initializes internal media components
  /// required for audio/video processing.
  ///
  /// **Possible Errors:**
  /// - [AgoraRteErrorCode.errorInvalidOperation]: Called before [createWithConfig].
  ///
  /// **Since:** v4.4.0
  Future<void> initMediaEngine();

  /// Destroys the RTE instance and releases all resources.
  ///
  /// Call this when you're done using RTE to free system resources. After
  /// calling this, you must create a new RTE instance to use RTE again.
  ///
  /// This automatically destroys all associated players and canvases.
  ///
  /// **Since:** v4.4.0
  Future<void> destroy();

  /// Updates the RTE engine configuration.
  ///
  /// Allows changing configuration settings after initialization. Not all
  /// settings can be changed at runtime.
  ///
  /// **Parameters:**
  /// - [config]: New configuration values to apply.
  ///
  /// **Since:** v4.4.0
  Future<void> setConfigs(AgoraRteConfig config);

  /// Retrieves the current RTE engine configuration.
  ///
  /// **Returns:**
  /// The current configuration settings.
  ///
  /// **Since:** v4.4.0
  Future<AgoraRteConfig> getConfigs();

  /// Creates a new RTE player.
  ///
  /// Creates a player instance for media playback. You can create multiple
  /// players simultaneously.
  ///
  /// **Parameters:**
  /// - [config]: Initial player configuration including auto-play, playback
  ///   speed, volume, and ABR settings.
  ///
  /// **Returns:**
  /// A new [AgoraRtePlayer] instance.
  ///
  /// **Possible Errors:**
  /// - [AgoraRteErrorCode.errorInvalidOperation]: Media engine not initialized.
  ///
  /// **See also:**
  /// - [AgoraRtePlayerConfig]
  /// - [destroyPlayer]
  ///
  /// **Since:** v4.4.0
  Future<AgoraRtePlayer> createPlayer(AgoraRtePlayerConfig config);

  /// Destroys a player and releases its resources.
  ///
  /// **Parameters:**
  /// - [playerId]: The unique identifier of the player to destroy, obtained
  ///   from [AgoraRtePlayer.playerId].
  ///
  /// **Since:** v4.4.0
  Future<void> destroyPlayer(String playerId);

  /// Creates a new RTE canvas for video rendering.
  ///
  /// Creates a canvas that can be used to render video content. You can create
  /// multiple canvases for multi-view scenarios.
  ///
  /// **Parameters:**
  /// - [config]: Initial canvas configuration including render mode, mirror
  ///   mode, and crop area.
  ///
  /// **Returns:**
  /// A new [AgoraRteCanvas] instance.
  ///
  /// **See also:**
  /// - [AgoraRteCanvasConfig]
  /// - [destroyCanvas]
  ///
  /// **Since:** v4.4.0
  Future<AgoraRteCanvas> createCanvas(AgoraRteCanvasConfig config);

  /// Destroys a canvas and releases its resources.
  ///
  /// **Parameters:**
  /// - [canvasId]: The unique identifier of the canvas to destroy, obtained
  ///   from [AgoraRteCanvas.canvasId].
  ///
  /// **Since:** v4.4.0
  Future<void> destroyCanvas(String canvasId);
}

/// RTE player interface.
///
/// Controls media playback including opening URLs or streams, playing, pausing,
/// stopping, seeking, muting, and retrieving playback statistics and information.
///
/// Create a player using [AgoraRte.createPlayer]. A typical workflow is:
/// 1. Create player with [AgoraRte.createPlayer]
/// 2. Create and set canvas with [setCanvas]
/// 3. Register observer with [registerObserver]
/// 4. Open media with [openWithUrl]
/// 5. Control playback with [play], [pause], [stop], [seek]
/// 6. Clean up with [AgoraRte.destroyPlayer]
///
/// Corresponds to native `AgoraRTEPlayer` (iOS) / `Player` (Android).
///
/// **Since:** v4.4.0
abstract class AgoraRtePlayer {
  /// Unique identifier of this player.
  ///
  /// Use this ID when calling [AgoraRte.destroyPlayer].
  ///
  /// **Since:** v4.4.0
  String get playerId;

  /// Preloads a URL for faster subsequent playback.
  ///
  /// Call this static method to download and cache media content before calling
  /// [openWithUrl]. This can reduce the time between opening and playing.
  ///
  /// A maximum of 20 URLs can be preloaded simultaneously.
  ///
  /// **Parameters:**
  /// - [url]: The media URL to preload (RTE URL or standard HTTP/HTTPS URL).
  ///
  /// **Possible Errors:**
  /// - [AgoraRteErrorCode.errorInvalidArgument]: Invalid URL format.
  ///
  /// **Since:** v4.4.0
  static Future<void> preloadWithUrl(String url) async {}

  /// Opens and optionally starts playing media from a URL.
  ///
  /// Opens an RTE URL or standard media URL (HTTP/HTTPS). For RTE URLs, the
  /// format is: `rte://host/app/stream?params`
  ///
  /// Supported URL parameters include:
  /// - `token`: Authentication token
  /// - `abr_subscription_layer`: Quality layer to subscribe to
  /// - `abr_fallback_layer`: Fallback behavior on poor network
  ///
  /// If [AgoraRtePlayerConfig.autoPlay] is `true` (default), playback starts
  /// automatically after opening completes. Otherwise, call [play] manually.
  ///
  /// When the token is about to expire, [AgoraRtePlayerObserver.onEvent] will
  /// be called with [AgoraRtePlayerEvent.authenticationWillExpire]. Generate a
  /// new token and call this method again with the updated URL to refresh.
  ///
  /// **Parameters:**
  /// - [url]: The media URL to open.
  /// - [startTime]: Playback start position in milliseconds. For live streams,
  ///   this parameter is ignored.
  ///
  /// **Possible Errors:**
  /// - [AgoraRteErrorCode.errorInvalidArgument]: Invalid URL format.
  /// - [AgoraRteErrorCode.errorNetworkError]: Network connection failed.
  /// - [AgoraRteErrorCode.errorAuthenticationFailed]: Invalid or expired token.
  /// - [AgoraRteErrorCode.errorStreamNotFound]: Stream not found or not published.
  ///
  /// **See also:**
  /// - [switchWithUrl]
  /// - [play]
  /// - [AgoraRtePlayerEvent.authenticationWillExpire]
  ///
  /// **Since:** v4.4.0
  Future<void> openWithUrl(String url, int startTime);

  /// Opens media from a custom source provider.
  ///
  /// Allows providing custom media data through a source provider interface.
  ///
  /// **Parameters:**
  /// - [provider]: Custom source provider implementation.
  /// - [startTime]: Playback start position in milliseconds.
  ///
  /// **Since:** v4.4.0
  Future<void> openWithCustomSourceProvider(dynamic provider, int startTime);

  /// Opens media from an RTE stream object.
  ///
  /// **Parameters:**
  /// - [stream]: RTE stream object to play.
  ///
  /// **Since:** v4.4.0
  Future<void> openWithStream(dynamic stream);

  /// Switches playback to a new URL without interruption.
  ///
  /// Seamlessly switches from the current URL to a new one. This is useful for:
  /// - Switching between different quality layers
  /// - Changing from one stream to another
  /// - Handling failover scenarios
  ///
  /// **Note:** This method only works for non-RTE URLs (standard HTTP/HTTPS).
  /// For RTE URLs, use [openWithUrl] to switch streams.
  ///
  /// **Parameters:**
  /// - [url]: The new URL to switch to.
  /// - [syncPts]: Whether to synchronize presentation timestamps (PTS) between
  ///   the old and new streams. Set to `true` for seamless switching.
  ///
  /// **Possible Errors:**
  /// - [AgoraRteErrorCode.errorInvalidOperation]: Called on an RTE URL.
  /// - [AgoraRteErrorCode.errorNetworkError]: Failed to open new URL.
  ///
  /// **Since:** v4.4.0
  Future<void> switchWithUrl(String url, bool syncPts);

  /// Retrieves current playback statistics.
  ///
  /// Returns real-time statistics including video decode/render frame rates
  /// and audio/video bitrates.
  ///
  /// **Returns:**
  /// Current player statistics.
  ///
  /// **See also:** [AgoraRtePlayerStats]
  ///
  /// **Since:** v4.4.0
  Future<AgoraRtePlayerStats> getStats();

  /// Sets the canvas for video rendering.
  ///
  /// Associates this player with a canvas. Video frames will be rendered to
  /// all views added to the canvas.
  ///
  /// **Parameters:**
  /// - [canvas]: The canvas to use for rendering. Pass `null` to unbind.
  ///
  /// **Since:** v4.4.0
  Future<void> setCanvas(AgoraRteCanvas canvas);

  /// Starts or resumes playback.
  ///
  /// If the player is paused, this resumes playback. If [openWithUrl] was
  /// called with [AgoraRtePlayerConfig.autoPlay] set to `false`, this starts
  /// playback.
  ///
  /// **Since:** v4.4.0
  Future<void> play();

  /// Stops playback and resets the player.
  ///
  /// After stopping, the player returns to the idle state. You must call
  /// [openWithUrl] again to play new content.
  ///
  /// **Since:** v4.4.0
  Future<void> stop();

  /// Pauses playback.
  ///
  /// Call [play] to resume from the paused position.
  ///
  /// **Since:** v4.4.0
  Future<void> pause();

  /// Seeks to a specific playback position.
  ///
  /// For on-demand content, seeks to the specified position. For live streams
  /// and RTE URLs, seeking may not be supported or may have limitations.
  ///
  /// **Parameters:**
  /// - [newTime]: Target position in milliseconds.
  ///
  /// **Possible Errors:**
  /// - [AgoraRteErrorCode.errorInvalidOperation]: Seeking not supported for
  ///   this media type.
  ///
  /// **Since:** v4.4.0
  Future<void> seek(int newTime);

  /// Mutes or unmutes audio playback.
  ///
  /// **Parameters:**
  /// - [mute]: `true` to mute audio, `false` to unmute.
  ///
  /// **Since:** v4.4.0
  Future<void> muteAudio(bool mute);

  /// Mutes or unmutes video rendering.
  ///
  /// When video is muted, a black screen is displayed.
  ///
  /// **Parameters:**
  /// - [mute]: `true` to mute video, `false` to unmute.
  ///
  /// **Since:** v4.4.0
  Future<void> muteVideo(bool mute);

  /// Gets the current playback position.
  ///
  /// Returns the current position in milliseconds from the start of the media.
  /// For RTE URLs, this may return the UTC timestamp.
  ///
  /// **Returns:**
  /// Current playback position in milliseconds.
  ///
  /// **Since:** v4.4.0
  Future<int> getPosition();

  /// Retrieves detailed player information.
  ///
  /// Returns comprehensive information about the current player state including
  /// media duration, tracks, dimensions, mute status, and audio properties.
  ///
  /// **Returns:**
  /// Current player information.
  ///
  /// **See also:** [AgoraRtePlayerInfo]
  ///
  /// **Since:** v4.4.0
  Future<AgoraRtePlayerInfo> getInfo();

  /// Updates player configuration.
  ///
  /// Allows changing player settings such as playback speed, volume, and ABR
  /// layer after the player is created.
  ///
  /// **Parameters:**
  /// - [config]: New configuration values to apply.
  ///
  /// **Since:** v4.4.0
  Future<void> setConfigs(AgoraRtePlayerConfig config);

  /// Retrieves the current player configuration.
  ///
  /// **Returns:**
  /// Current player configuration.
  ///
  /// **Since:** v4.4.0
  Future<AgoraRtePlayerConfig> getConfigs();

  /// Registers an observer to receive player event callbacks.
  ///
  /// Multiple observers can be registered. All registered observers will
  /// receive callbacks.
  ///
  /// **Parameters:**
  /// - [observer]: The observer to register.
  ///
  /// **See also:**
  /// - [AgoraRtePlayerObserver]
  /// - [unregisterObserver]
  ///
  /// **Since:** v4.4.0
  Future<void> registerObserver(AgoraRtePlayerObserver observer);

  /// Unregisters a previously registered observer.
  ///
  /// **Parameters:**
  /// - [observer]: The observer to unregister.
  ///
  /// **Since:** v4.4.0
  Future<void> unregisterObserver(AgoraRtePlayerObserver observer);
}

/// RTE canvas interface.
///
/// Manages video rendering by controlling which native views display video
/// content and how the video is rendered (scaling, mirroring, cropping).
///
/// Create a canvas using [AgoraRte.createCanvas]. A typical workflow is:
/// 1. Create canvas with [AgoraRte.createCanvas]
/// 2. Associate with player using [AgoraRtePlayer.setCanvas]
/// 3. Add native view(s) with [addView]
/// 4. Configure rendering with [setConfigs]
/// 5. Remove views with [removeView] when done
/// 6. Clean up with [AgoraRte.destroyCanvas]
///
/// Corresponds to native `AgoraRTECanvas` (iOS) / `Canvas` (Android).
///
/// **Since:** v4.4.0
abstract class AgoraRteCanvas {
  /// Unique identifier of this canvas.
  ///
  /// Use this ID when calling [AgoraRte.destroyCanvas].
  ///
  /// **Since:** v4.4.0
  String get canvasId;

  /// Updates canvas configuration.
  ///
  /// Changes rendering settings such as render mode (fit/hidden), mirror mode,
  /// and crop area.
  ///
  /// **Parameters:**
  /// - [config]: New configuration values to apply.
  ///
  /// **See also:** [AgoraRteCanvasConfig]
  ///
  /// **Since:** v4.4.0
  Future<void> setConfigs(AgoraRteCanvasConfig config);

  /// Retrieves the current canvas configuration.
  ///
  /// **Returns:**
  /// Current canvas configuration.
  ///
  /// **Since:** v4.4.0
  Future<AgoraRteCanvasConfig> getConfigs();

  /// Adds a native view to the canvas for video rendering.
  ///
  /// The native view pointer is typically obtained from a platform view
  /// (UiKitView on iOS or AndroidView on Android). Use [AgoraRteVideoView]
  /// widget for automatic view management.
  ///
  /// **Parameters:**
  /// - [viewPtr]: Native view pointer (memory address of the view).
  /// - [config]: Optional view-specific configuration such as crop area.
  ///
  /// **See also:**
  /// - [AgoraRteVideoView]
  /// - [removeView]
  ///
  /// **Since:** v4.4.0
  Future<void> addView(int viewPtr, {AgoraRteViewConfig? config});

  /// Removes a native view from the canvas.
  ///
  /// Unbinds the view so it no longer displays video content from this canvas.
  ///
  /// **Parameters:**
  /// - [viewPtr]: Native view pointer that was previously added.
  /// - [config]: Optional configuration (currently unused).
  ///
  /// **Since:** v4.4.0
  Future<void> removeView(int viewPtr, {AgoraRteViewConfig? config});
}
