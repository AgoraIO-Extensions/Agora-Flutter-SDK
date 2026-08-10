import '/src/_serializable.dart';
import '/src/binding_forward_export.dart';

/// Class that provides media player functionality and supports multiple instances.
abstract class MediaPlayer {
  /// Gets the player ID.
  ///
  /// Returns
  /// If the method call succeeds, returns the player ID.
  ///  < 0: The method call fails. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  int getMediaPlayerId();

  /// Opens a media resource.
  ///
  /// This method is asynchronous.
  ///
  /// * [url] Sets the path of the media file. Supports both local and online files.
  /// * [startPos] Sets the start playback position in milliseconds. Default is 0.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> open({required String url, required int startPos});

  /// Opens a media resource and sets playback options.
  ///
  /// This method allows you to open different types of media resources, including custom media files, and configure playback settings. This method is asynchronous. To play the media file, call the play method after receiving the onPlayerSourceStateChanged callback reporting the state playerStateOpenCompleted.
  ///
  /// * [source] Media resource. See MediaSource.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Failure. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> openWithMediaSource(MediaSource source);

  /// Plays the media file.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> play();

  /// Pauses playback.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> pause();

  /// Stops playback.
  ///
  /// After calling this method to stop playback, you need to call open or openWithMediaSource to open the media resource again if you want to replay.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> stop();

  /// Resumes playback after pausing.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> resume();

  /// Seeks to the specified playback position in the media file.
  ///
  /// If you call seek after playback has completed (i.e., you received the onPlayerSourceStateChanged callback reporting the playback state as playerStatePlaybackCompleted or playerStatePlaybackAllLoopsCompleted), the SDK will automatically start playback from the specified position upon success. You will receive the onPlayerSourceStateChanged callback reporting the state as playerStatePlaying.
  ///  If you call seek while playback is paused, the SDK will seek to the specified position upon success. To start playback, call resume or play.
  ///
  /// * [newPos] The specified position (in milliseconds).
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> seek(int newPos);

  /// Adjusts the pitch of the currently playing media resource.
  ///
  /// You need to call this method after calling open.
  ///
  /// * [pitch] Adjusts the pitch of the locally played music file in semitone steps. The default value is 0, meaning no pitch adjustment. The valid range is [-12, 12], where each adjacent value differs by a semitone. The greater the absolute value, the more the pitch is increased or decreased.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setAudioPitch(int pitch);

  /// Gets the total duration of the media file.
  ///
  /// Returns
  /// Total duration of the media file (in milliseconds).
  Future<int> getDuration();

  /// Gets the current playback position.
  ///
  /// Returns
  /// If the method call succeeds, returns the current playback position (milliseconds).
  ///  < 0: The method call fails. See MediaPlayerReason.
  Future<int> getPlayPosition();

  /// Gets the number of media streams in the current media file.
  ///
  /// Call this method after open and after receiving the onPlayerSourceStateChanged callback reporting the playback state as playerStateOpenCompleted.
  ///
  /// Returns
  /// If the method call succeeds, returns the number of media streams in the media file.
  ///  < 0: The method call fails. See MediaPlayerReason.
  Future<int> getStreamCount();

  /// Gets media stream information by stream index.
  ///
  /// * [index] Media stream index. The value must be less than the return value of getStreamCount.
  ///
  /// Returns
  /// If the method call succeeds, returns the media stream information. See PlayerStreamInfo.
  ///  If the method call fails, returns NULL.
  Future<PlayerStreamInfo> getStreamInfo(int index);

  /// Sets loop playback.
  ///
  /// If you want to enable loop playback, call this method and set the number of loops.
  /// When loop playback ends, the SDK triggers the onPlayerSourceStateChanged callback to report the playback state as playerStatePlaybackAllLoopsCompleted.
  ///
  /// * [loopCount] Number of playback loops.
  ///  ≥0: Number of loops. For example, 0 means no loop, play once in total; 1 means loop once, play twice in total.
  ///  -1: Infinite loop.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setLoopCount(int loopCount);

  /// Sets the playback speed of the current audio file.
  ///
  /// You need to call this method after open.
  ///
  /// * [speed] Playback speed. Recommended range is [30, 400], where:
  ///  30: 0.3x speed.
  ///  100: original speed.
  ///  400: 4x speed.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setPlaybackSpeed(int speed);

  /// Specifies the audio track for the current audio file.
  ///
  /// After obtaining the audio track index of the audio file, you can call this method to select any track for playback. If different tracks in a multi-track file contain songs in different languages, you can call this method to set the playback language. You need to call this method after calling getStreamInfo to get the audio stream index.
  ///
  /// * [index] Index of the audio track.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> selectAudioTrack(int index);

  /// Selects the audio tracks for local playback and remote publishing.
  ///
  /// You can call this method to separately set the audio tracks for local playback and for publishing to the remote end.
  /// Before calling this method, you must open the media file using openWithMediaSource and set enableMultiAudioTrack to true via MediaSource.
  ///
  /// * [playoutTrackIndex] The index of the audio track used for local playback. You can get the index via getStreamInfo.
  /// * [publishTrackIndex] The index of the audio track used for publishing to the remote end. You can get the index via getStreamInfo.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: Failure.
  Future<void> selectMultiAudioTrack(
      {required int playoutTrackIndex, required int publishTrackIndex});

  /// @nodoc
  Future<void> takeScreenshot(String filename);

  /// @nodoc
  Future<void> selectInternalSubtitle(int index);

  /// @nodoc
  Future<void> setExternalSubtitle(String url);

  /// Gets the current state of the player.
  ///
  /// Returns
  /// The current state of the player. See MediaPlayerState.
  Future<MediaPlayerState> getState();

  /// Sets whether to mute.
  ///
  /// * [muted] Mute option. true : Mute. false : (Default) Do not mute.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> mute(bool muted);

  /// Gets whether the currently playing media file is muted.
  ///
  /// Returns
  /// true : The currently playing media file is muted. false : The currently playing media file is not muted.
  Future<bool> getMute();

  /// Adjusts the local playback volume.
  ///
  /// * [volume] Local playback volume, ranging from 0 to 100:
  ///  0: Mute.
  ///  100: (Default) Original playback volume of the media file.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> adjustPlayoutVolume(int volume);

  /// Gets the current local playback volume.
  ///
  /// Returns
  /// Returns the current local playback volume, ranging from 0 to 100:
  ///  0: Silent.
  ///  100: (Default) Original playback volume of the media file.
  Future<int> getPlayoutVolume();

  /// Adjusts the volume heard by remote users.
  ///
  /// After connecting to the Agora server, you can call this method to adjust the volume of the media file heard by remote users.
  ///
  /// * [volume] Signal volume, ranging from 0 to 400:
  ///  0: Mute.
  ///  100: (Default) Original volume of the media file.
  ///  400: Four times the original volume (with built-in overflow protection).
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> adjustPublishSignalVolume(int volume);

  /// Gets the volume heard by remote users.
  ///
  /// Returns
  /// ≥ 0: Remote playback volume of the media file.
  ///  < 0: The method call fails. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<int> getPublishSignalVolume();

  /// Sets the player rendering view.
  ///
  /// In Flutter, you do not need to call this method manually. Use AgoraVideoView to render local and remote views.
  ///
  /// * [view] Rendering view. On Windows, this is a window handle (HWND).
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setView(int view);

  /// Sets the rendering mode of the player view.
  ///
  /// * [renderMode] Rendering mode of the player view. See RenderModeType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setRenderMode(RenderModeType renderMode);

  /// Registers a playback observer.
  ///
  /// * [observer] Playback observer that reports events during playback. See MediaPlayerSourceObserver.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  void registerPlayerSourceObserver(MediaPlayerSourceObserver observer);

  /// Unregisters the playback observer.
  ///
  /// * [observer] Playback observer that reports events during playback. See MediaPlayerSourceObserver.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  void unregisterPlayerSourceObserver(MediaPlayerSourceObserver observer);

  /// Registers an audio frame observer.
  ///
  /// * [observer] Audio frame observer that monitors the reception of each audio frame. See AudioPcmFrameSink.
  /// * [mode] Usage mode of the audio frame. See RawAudioFrameOpModeType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  void registerAudioFrameObserver(
      {required AudioPcmFrameSink observer,
      RawAudioFrameOpModeType mode =
          RawAudioFrameOpModeType.rawAudioFrameOpModeReadOnly});

  /// Unregisters the audio frame observer.
  ///
  /// * [observer] Audio frame observer. See AudioPcmFrameSink.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  void unregisterAudioFrameObserver(AudioPcmFrameSink observer);

  /// Registers a video frame observer.
  ///
  /// You need to implement a MediaPlayerVideoFrameObserver class in this method and register its callbacks as needed based on your scenario. Once the video frame observer is successfully registered, the SDK triggers the registered callbacks upon capturing each video frame.
  ///
  /// * [observer] Video frame observer that monitors the reception of each video frame. See MediaPlayerVideoFrameObserver.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  void registerVideoFrameObserver(MediaPlayerVideoFrameObserver observer);

  /// Unregisters the video frame observer.
  ///
  /// * [observer] Video frame observer that monitors the reception of each video frame. See MediaPlayerVideoFrameObserver.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  void unregisterVideoFrameObserver(MediaPlayerVideoFrameObserver observer);

  /// @nodoc
  void registerMediaPlayerAudioSpectrumObserver(
      {required AudioSpectrumObserver observer, required int intervalInMS});

  /// @nodoc
  void unregisterMediaPlayerAudioSpectrumObserver(
      AudioSpectrumObserver observer);

  /// Sets the channel mode of the current audio file.
  ///
  /// In stereo audio files, the left and right channels can store different audio data. Depending on your needs, you can set the channel mode to original, left channel, right channel, or mixed mode. For example, in a KTV scenario, the left channel of an audio file stores the accompaniment, and the right channel stores the original vocal. If you only want to hear the accompaniment, call this method to set the channel mode to left channel; if you want to hear both the accompaniment and the original vocal, set the channel mode to mixed mode.
  ///  You need to call this method after calling open.
  ///  This method applies to stereo audio files only.
  ///
  /// * [mode] Channel mode. See AudioDualMonoMode.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setAudioDualMonoMode(AudioDualMonoMode mode);

  /// @nodoc
  Future<String> getPlayerSdkVersion();

  /// Gets the path of the media resource being played.
  ///
  /// Returns
  /// The path of the media resource being played.
  Future<String> getPlaySrc();

  /// @nodoc
  Future<void> openWithAgoraCDNSrc(
      {required String src, required int startPos});

  /// @nodoc
  Future<int> getAgoraCDNLineCount();

  /// @nodoc
  Future<void> switchAgoraCDNLineByIndex(int index);

  /// @nodoc
  Future<int> getCurrentAgoraCDNIndex();

  /// @nodoc
  Future<void> enableAutoSwitchAgoraCDN(bool enable);

  /// @nodoc
  Future<void> renewAgoraCDNSrcToken({required String token, required int ts});

  /// @nodoc
  Future<void> switchAgoraCDNSrc({required String src, bool syncPts = false});

  /// Switches the media resource.
  ///
  /// You can call this method to switch the bitrate of the media resource being played based on the current network conditions. For example:
  ///  When the network is poor, switch to a lower bitrate media resource.
  ///  When the network is good, switch to a higher bitrate media resource. After calling this method, if you receive the onPlayerEvent callback reporting the playerEventSwitchComplete event, the media resource has been switched successfully. If the switch fails, the SDK retries 3 times. If it still fails, you receive the onPlayerEvent callback reporting the playerEventSwitchError event, indicating an error occurred during the switch.
  ///  Make sure to call this method after open.
  ///  To ensure normal playback, note the following when calling this method:
  ///  Do not call this method while playback is paused.
  ///  Do not call seek during bitrate switching.
  ///  Ensure the playback position before switching does not exceed the total duration of the media resource to be switched.
  ///
  /// * [src] Network path of the media resource.
  /// * [syncPts] Whether to synchronize the start playback position before and after switching: true : Synchronize. false : (Default) Do not synchronize.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> switchSrc({required String src, bool syncPts = true});

  /// Preloads a media resource.
  ///
  /// You can call this method to preload a media resource into the playlist. To preload multiple media resources, call this method multiple times.
  /// After preloading succeeds, call playPreloadedSrc to play the media resource, or call stop to clear the playlist.
  ///  Before calling this method, make sure you have successfully called open or openWithMediaSource to open the media resource.
  ///  The SDK does not support preloading duplicate media resources into the playlist, but supports preloading the currently playing media resource again into the playlist.
  ///
  /// * [src] Network path of the media resource.
  /// * [startPos] Start position (in milliseconds) when playback begins after preloading into the playlist. Set to 0 when preloading a live stream.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> preloadSrc({required String src, required int startPos});

  /// Plays a preloaded media resource.
  ///
  /// After calling the preloadSrc method to preload a media resource into the playlist, you can call this method to play the preloaded media resource. After calling this method, if you receive the onPlayerSourceStateChanged callback reporting the state as playerStatePlaying, the playback is successful.
  /// If you want to change the preloaded media resource being played, you can call this method again and specify a new media resource path. If you want to replay the media resource, you need to call preloadSrc again to preload the media resource into the playlist before playing. To clear the playlist, call stop. If you call this method while playback is paused, it will take effect only after playback resumes.
  ///
  /// * [src] The URL of the media resource in the playlist. It must match the src set in the preloadSrc method; otherwise, playback will fail.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> playPreloadedSrc(String src);

  /// Releases the preloaded media resource.
  ///
  /// * [src] Network path of the media resource.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> unloadSrc(String src);

  /// Enables or disables spatial audio for the media player.
  ///
  /// After successfully setting the spatial audio parameters of the media player, the SDK enables spatial audio for the media player, allowing the local user to perceive spatial sound from media resources.
  /// To disable spatial audio for the media player, you need to set the params parameter to null.
  ///
  /// * [params] Spatial audio parameters for the media player. See SpatialAudioParams.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when it fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setSpatialAudioParams(SpatialAudioParams params);

  /// @nodoc
  Future<void> setSoundPositionParams(
      {required double pan, required double gain});

  /// @nodoc
  Future<int> getAudioBufferDelay();

  /// Sets media player options.
  ///
  /// The media player supports setting options using key and value.
  /// The difference between this method and setPlayerOptionInString is that this method uses an Int type for value, while setPlayerOptionInString uses a String type. The two cannot be mixed.
  ///
  /// * [key] Key value.
  /// * [value] Value.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setPlayerOptionInInt({required String key, required int value});

  /// Sets media player options.
  ///
  /// The media player supports setting options using key and value.
  /// The difference between this method and setPlayerOptionInInt is that this method uses a String type for value, while setPlayerOptionInInt uses an Int type. The two cannot be mixed.
  ///
  /// * [key] Key value.
  /// * [value] Value.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setPlayerOptionInString(
      {required String key, required String value});
}

/// This class provides methods for managing cached media files in the media player.
abstract class MediaPlayerCacheManager {
  /// Deletes all cached media files in the media player.
  ///
  /// This method does not delete cached media files that are currently playing.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Failure. See MediaPlayerReason.
  Future<void> removeAllCaches();

  /// Deletes the least recently used cached media file in the media player.
  ///
  /// When cached media files occupy too much space, you can call this method to clean up cache files. After calling this method, the SDK deletes the least recently used cached media file. When you call this method to delete cached media files, the currently playing cached media file will not be deleted.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Failure. See MediaPlayerReason.
  Future<void> removeOldCache();

  /// Deletes a specified cached media file.
  ///
  /// This method does not delete cached media files that are currently playing.
  ///
  /// * [uri] The URI (Uniform Resource Identifier) of the cache file to be deleted, which can be used to identify the media file.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Failure. See MediaPlayerReason.
  Future<void> removeCacheByUri(String uri);

  /// Sets the storage path for media files to be cached.
  ///
  /// This method must be called after initializing RtcEngine.
  ///
  /// * [path] The absolute path for storing cached files. Make sure the specified directory exists and is writable.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Failure. See MediaPlayerReason.
  Future<void> setCacheDir(String path);

  /// Sets the maximum number of cached media files.
  ///
  /// * [count] The maximum number of media files that can be cached. The default value is 1000.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Failure. See MediaPlayerReason.
  Future<void> setMaxCacheFileCount(int count);

  /// Sets the upper limit of the total cache size for media files.
  ///
  /// * [cacheSize] The total cache size limit for media files, in bytes. The default is 1 GB.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Failure. See MediaPlayerReason.
  Future<void> setMaxCacheFileSize(int cacheSize);

  /// Enables or disables the automatic cache file removal feature.
  ///
  /// When automatic cache file removal is enabled, if the number or total size of cached media files in the player exceeds the set limit, the SDK automatically removes the least recently used cache file.
  ///
  /// * [enable] Whether to enable automatic cache file removal: true : Enables automatic cache file removal. false : (Default) Disables automatic cache file removal.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Failure. See MediaPlayerReason.
  Future<void> enableAutoRemoveCache(bool enable);

  /// Gets the storage path of the cached files.
  ///
  /// If you have not called the setCacheDir method to customize the cache file storage path before calling this method, the method returns the SDK's default cache file storage path.
  ///
  /// * [length] Input parameter. The maximum length of the cache file storage path string.
  ///
  /// Returns
  /// On success, returns the storage path of the cached files.
  ///  < 0: Failure. See MediaPlayerReason.
  Future<String> getCacheDir(int length);

  /// Gets the maximum number of cache files set.
  ///
  /// The default maximum number of cache files in the SDK is 1000.
  ///
  /// Returns
  /// > 0: Success. Returns the maximum number of cache files.
  ///  < 0: Failure. See MediaPlayerReason.
  Future<int> getMaxCacheFileCount();

  /// Gets the maximum total cache size of cache files set.
  ///
  /// The default maximum total cache size of cache files in the SDK is 1GB. You can call the setMaxCacheFileSize method to customize the limit.
  ///
  /// Returns
  /// > 0: Success. Returns the maximum total cache size in bytes.
  ///  < 0: Failure. See MediaPlayerReason.
  Future<int> getMaxCacheFileSize();

  /// Gets the total number of currently cached media files.
  ///
  /// Returns
  /// ≥ 0: Success. Returns the total number of currently cached media files.
  ///  < 0: Failure. See MediaPlayerReason.
  Future<int> getCacheFileCount();
}

/// Video data observer for the media player.
///
/// You can call registerVideoFrameObserver to register or unregister the MediaPlayerVideoFrameObserver.
class MediaPlayerVideoFrameObserver {
  /// @nodoc
  const MediaPlayerVideoFrameObserver({
    this.onFrame,
  });

  /// Callback when a video frame is received.
  ///
  /// After registering the video observer, this callback is triggered every time a video frame is received, reporting video frame information.
  ///
  /// * [frame] Video frame information. See VideoFrame.
  final void Function(VideoFrame frame)? onFrame;
}
