import 'package:agora_rtc_engine/src/binding_forward_export.dart';

/// This class provides media player functions and supports multiple instances.
abstract class MediaPlayer {
  /// Gets the ID of the media player.
  ///
  /// Returns
  /// ≥ 0: Success. The ID of the media player.< 0: Failure.
  int getMediaPlayerId();

  /// Opens the media resource.
  /// This method is called asynchronously.If you need to play a media file, make sure you receive the onPlayerSourceStateChanged callback reporting playerStateOpenCompleted before calling the play method to play the file.
  ///
  /// * [url] The path of the media file. Both local path and online path are supported.On the Android platform, if you need to open a file in URI format, use open .
  /// * [startPos] The starting position (ms) for playback. Default value is 0.
  Future<void> open({required String url, required int startPos});

  /// Opens a media file and configures the playback scenarios.
  /// This method supports opening media files of different sources, including a custom media source, and allows you to configure the playback scenarios.
  ///
  /// * [source] Media resources. See MediaSource .
  ///
  Future<void> openWithMediaSource(MediaSource source);

  /// Plays the media file.
  /// After calling open or seek, you can call this method to play the media file.
  Future<void> play();

  /// Pauses the playback.
  Future<void> pause();

  /// Stops playing the media track.
  Future<void> stop();

  /// Resumes playing the media file.
  Future<void> resume();

  /// Seeks to a new playback position.
  /// After successfully calling this method, you will receive the onPlayerEvent callback, reporting the result of the seek operation to the new playback position.To play the media file from a specific position, do the following:Call this method to seek to the position you want to begin playback.Call the play method to play the media file.
  ///
  /// * [newPos] The new playback position (ms).
  Future<void> seek(int newPos);

  /// Sets the pitch of the current media resource.
  /// Call this method after calling open .
  ///
  /// * [pitch] Sets the pitch of the local music file by the chromatic scale. The default value is 0, which means keeping the original pitch. The value ranges from -12 to 12, and the pitch value between consecutive values is a chromatic value. The greater the absolute value of this parameter, the higher or lower the pitch of the local music file.
  Future<void> setAudioPitch(int pitch);

  /// Gets the duration of the media resource.
  ///
  /// Returns
  /// The total duration (ms) of the media file.
  Future<int> getDuration();

  /// Gets current local playback progress.
  ///
  /// Returns
  /// Returns the current playback progress (ms) if the call succeeds.< 0: Failure. See MediaPlayerError .
  Future<int> getPlayPosition();

  /// Gets the number of the media streams in the media resource.
  /// Call this method after calling open .
  ///
  /// Returns
  /// The number of the media streams in the media resource if the method call succeeds.< 0: Failure. See MediaPlayerError .
  Future<int> getStreamCount();

  /// Gets the detailed information of the media stream.
  /// Call this method after calling getStreamCount .
  ///
  /// * [index] The index of the media stream.
  ///
  /// Returns
  /// If the call succeeds, returns the detailed information of the media stream. See PlayerStreamInfo .If the call fails, returns NULL.
  Future<PlayerStreamInfo> getStreamInfo(int index);

  /// Sets the loop playback.
  /// If you want to loop, call this method and set the number of the loops.When the loop finishes, the SDK triggers onPlayerSourceStateChanged and reports the playback state as playerStatePlaybackAllLoopsCompleted.
  ///
  /// * [loopCount] The number of times the audio effect loops:
  Future<void> setLoopCount(int loopCount);

  /// Sets the channel mode of the current audio file.
  /// Call this method after calling open .
  ///
  /// * [speed] The playback speed. Agora recommends that you limit this value to between 50 and 400, defined as follows:50: Half the original speed.100: The original speed.400: 4 times the original speed.
  Future<void> setPlaybackSpeed(int speed);

  /// Selects the audio track used during playback.
  /// After getting the track index of the audio file, you can call this method to specify any track to play. For example, if different tracks of a multi-track file store songs in different languages, you can call this method to set the playback language.You need to call this method after calling getStreamInfo to get the audio stream index value.
  ///
  /// * [index] The index of the audio track.
  Future<void> selectAudioTrack(int index);

  /// Sets the private options for the media player.
  /// The media player supports setting private options by key and value. Under normal circumstances, you do not need to know the private option settings, and just use the default option settings.Ensure that you call this method before open .If you need to push streams with SEI into the CDN, callsetPlayerOptionInInt ("sei_data_with_uuid", 1); otherwise, the loss of SEI might occurs.
  ///
  /// * [key] The key of the option.
  /// * [value] The value of the key.
  Future<void> setPlayerOptionInInt({required String key, required int value});

  /// @nodoc
  Future<void> setPlayerOptionInString(
      {required String key, required String value});

  /// @nodoc
  Future<void> takeScreenshot(String filename);

  /// @nodoc
  Future<void> selectInternalSubtitle(int index);

  /// @nodoc
  Future<void> setExternalSubtitle(String url);

  /// Gets current playback state.
  ///
  /// Returns
  /// The current playback state. See MediaPlayerState .
  Future<MediaPlayerState> getState();

  /// Sets whether to mute the media file.
  ///
  /// * [muted] Whether to mute the media file:true: Mute the media file.false: (Default) Unmute the media file.
  Future<void> mute(bool muted);

  /// Reports whether the media resource is muted.
  ///
  /// Returns
  /// true: Reports whether the media resource is muted.false: Reports whether the media resource is muted.
  Future<bool> getMute();

  /// Adjusts the local playback volume.
  ///
  /// * [volume] The local playback volume, which ranges from 0 to 100:0: Mute.100: (Default) The original volume.
  Future<void> adjustPlayoutVolume(int volume);

  /// Gets the local playback volume.
  ///
  /// Returns
  /// The local playback volume, which ranges from 0 to 100.0: Mute.100: (Default) The original volume.
  Future<int> getPlayoutVolume();

  /// Adjusts the volume of the media file for publishing.
  /// After connected to the Agora server, you can call this method to adjust the volume of the media file heard by the remote user.
  ///
  /// * [volume] The volume, which ranges from 0 to 400:0: Mute.100: (Default) The original volume.400: Four times the original volume (amplifying the audio signals by four times).
  Future<void> adjustPublishSignalVolume(int volume);

  /// Gets the volume of the media file for publishing.
  ///
  /// Returns
  /// The remote playback volume, if the method call succeeds.< 0: Failure.
  Future<int> getPublishSignalVolume();

  /// Sets the view.
  Future<void> setView(int view);

  /// Sets the render mode of the media player.
  ///
  /// * [renderMode] Sets the render mode of the view. See RenderModeType .
  Future<void> setRenderMode(RenderModeType renderMode);

  /// Registers a media player observer.
  ///
  /// * [observer] The player observer, listening for events during the playback. See MediaPlayerSourceObserver .
  void registerPlayerSourceObserver(MediaPlayerSourceObserver observer);

  /// Releases a media player observer.
  ///
  /// * [observer] The player observer, listening for events during the playback. See MediaPlayerSourceObserver .
  void unregisterPlayerSourceObserver(MediaPlayerSourceObserver observer);

  /// @nodoc
  void registerMediaPlayerAudioSpectrumObserver(
      {required AudioSpectrumObserver observer, required int intervalInMS});

  /// @nodoc
  void unregisterMediaPlayerAudioSpectrumObserver(
      AudioSpectrumObserver observer);

  /// Sets the channel mode of the current audio file.
  /// In a stereo music file, the left and right channels can store different audio data. According to your needs, you can set the channel mode to original mode, left channel mode, right channel mode, or mixed channel mode. For example, in the KTV scenario, the left channel of the music file stores the musical accompaniment, and the right channel stores the singing voice. If you only need to listen to the accompaniment, call this method to set the channel mode of the music file to left channel mode; if you need to listen to the accompaniment and the singing voice at the same time, call this method to set the channel mode to mixed channel mode.Call this method after calling open .This method only applies to stereo audio files.
  ///
  /// * [mode] The channel mode. See AudioDualMonoMode .
  Future<void> setAudioDualMonoMode(AudioDualMonoMode mode);

  /// @nodoc
  Future<String> getPlayerSdkVersion();

  /// @nodoc
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

  /// Switches the media resource being played.
  /// You can call this method to switch the media resource to be played according to the current network status. For example:When the network is poor, the media resource to be played is switched to a media resource address with a lower bitrate.When the network is good, the media resource to be played is switched to a media resource address with a higher bitrate.After calling this method, if you receive the onPlayerEvent event in the playerEventSwitchComplete callback, the switch is successful; If you receive the onPlayerEvent event in the playerEventSwitchError callback, the switch fails.Ensure that you call this method after open .To ensure normal playback, pay attention to the following when calling this method:Do not call this method when playback is paused.Do not call the seek method during switching.Before switching the media resource, make sure that the playback position does not exceed the total duration of the media resource to be switched.
  ///
  /// * [src] The URL of the media resource.
  /// * [syncPts] Whether to synchronize the playback position (ms) before and after the switch:true: Synchronize the playback position before and after the switch.false: (Default) Do not synchronize the playback position before and after the switch.Make sure to set this parameter as false if you need to play live streams, or the switch fails. If you need to play on-demand streams, you can set the value of this parameter according to your scenarios.
  ///
  Future<void> switchSrc({required String src, bool syncPts = true});

  /// Preloads a media resource.
  /// You can call this method to preload a media resource into the playlist. If you need to preload multiple media resources, you can call this method multiple times.If the preload is successful and you want to play the media resource, call playPreloadedSrc ; if you want to clear the playlist, call stop .Agora does not support preloading duplicate media resources to the playlist. However, you can preload the media resources that are being played to the playlist again.
  ///
  /// * [src] The URL of the media resource.
  /// * [startPos] The starting position (ms) for playing after the media resource is preloaded to the playlist. When preloading a live stream, set this parameter to 0.
  Future<void> preloadSrc({required String src, required int startPos});

  /// Plays preloaded media resources.
  /// After calling the preloadSrc method to preload the media resource into the playlist, you can call this method to play the preloaded media resource. After calling this method, if you receive the onPlayerSourceStateChanged callback which reports the playerStatePlaying state, the playback is successful.If you want to change the preloaded media resource to be played, you can call this method again and specify the URL of the new media resource that you want to preload. If you want to replay the media resource, you need to call preloadSrc to preload the media resource to the playlist again before playing. If you want to clear the playlist, call the stop method.If you call this method when playback is paused, this method does not take effect until playback is resumed.
  ///
  /// * [src] The URL of the media resource in the playlist must be consistent with the src set by the preloadSrc method; otherwise, the media resource cannot be played.
  Future<void> playPreloadedSrc(String src);

  /// Unloads media resources that are preloaded.
  /// This method cannot release the media resource being played.
  ///
  /// * [src] The URL of the media resource.
  Future<void> unloadSrc(String src);

  /// Enables or disables the spatial audio effect for the media player.
  /// After successfully setting the spatial audio effect parameters of the media player, the SDK enables the spatial audio effect for the media player, and the local user can hear the media resources with a sense of space.If you need to disable the spatial audio effect for the media player, set the params parameter to null.
  ///
  /// * [params] The spatial audio effect parameters of the media player. See SpatialAudioParams for details.
  Future<void> setSpatialAudioParams(SpatialAudioParams params);

  /// @nodoc
  Future<void> setSoundPositionParams(
      {required double pan, required double gain});

  /// Registers an audio frame observer object.
  /// You need to implement the MediaPlayerAudioFrameObserver class in this method and register callbacks according to your scenarios. After you successfully register the video frame observer, the SDK triggers the registered callbacks each time a video frame is received.
  ///
  /// * [observer] The audio frame observer, reporting the reception of each audio frame. See MediaPlayerAudioFrameObserver .
  void registerAudioFrameObserver(MediaPlayerAudioFrameObserver observer);

  /// Unregisters an audio observer.
  ///
  /// * [observer] The audio observer. See MediaPlayerAudioFrameObserver .
  void unregisterAudioFrameObserver(MediaPlayerAudioFrameObserver observer);

  /// Registers a video frame observer object.
  /// You need to implement the MediaPlayerVideoFrameObserver class in this method and register callbacks according to your scenarios. After you successfully register the video frame observer, the SDK triggers the registered callbacks each time a video frame is received.
  ///
  /// * [observer] The video observer, reporting the reception of each video frame. See MediaPlayerVideoFrameObserver .
  void registerVideoFrameObserver(MediaPlayerVideoFrameObserver observer);

  /// Unregisters the video frame observer.
  ///
  /// * [observer] The video observer, reporting the reception of each video frame. See MediaPlayerVideoFrameObserver .
  void unregisterVideoFrameObserver(MediaPlayerVideoFrameObserver observer);
}

/// This class provides methods to manage cached media files.
abstract class MediaPlayerCacheManager {
  /// Deletes all cached media files in the media player.
  /// The cached media file currently being played will not be deleted.
  Future<void> removeAllCaches();

  /// Deletes a cached media file that is the least recently used.
  /// You can call this method to delete a cached media file when the storage space for the cached files is about to reach its limit. After you call this method, the SDK deletes the cached media file that is least used.The cached media file currently being played will not be deleted.
  Future<void> removeOldCache();

  /// Deletes a cached media file.
  /// The cached media file currently being played will not be deleted.
  ///
  /// * [uri] The URI (Uniform Resource Identifier) of the media file to be deleted.
  Future<void> removeCacheByUri(String uri);

  /// Sets the storage path for the media files that you want to cache.
  /// Make sure RtcEngine is initialized before you call this method.
  ///
  /// * [path] The absolute path of the media files to be cached. Ensure that the directory for the media files exists and is writable.
  Future<void> setCacheDir(String path);

  /// Sets the maximum number of media files that can be cached.
  ///
  /// * [count] The maximum number of media files that can be cached. The default value is 1,000.
  Future<void> setMaxCacheFileCount(int count);

  /// Sets the maximum size of the aggregate storage space for cached media files.
  ///
  /// * [cacheSize] The maximum size (bytes) of the aggregate storage space for cached media files. The default value is 1 GB.
  Future<void> setMaxCacheFileSize(int cacheSize);

  /// Sets whether to delete cached media files automatically.
  /// If you enable this function to remove cached media files automatically, when the cached media files exceed either the number or size limit you set, the SDK automatically deletes the least recently used cache file.
  ///
  /// * [enable] Whether to enable the SDK to delete cached media files automatically:true: Delete cached media files automatically.false: (Default) Do not delete cached media files automatically.
  Future<void> enableAutoRemoveCache(bool enable);

  /// Gets the storage path of the cached media files.
  /// If you have not called the setCacheDir method to set the storage path for the media files to be cached before calling this method, you get the default storage path used by the SDK.
  ///
  /// * [length] An input parameter; the maximum length of the cache file storage path string.
  ///
  /// Returns
  /// The call succeeds, and the SDK returns the storage path of the cached media files.< 0: Failure. See MediaPlayerError .
  Future<String> getCacheDir(int length);

  /// Gets the maximum number of media files that can be cached.
  /// By default, the maximum number of media files that can be cached is 1,000.
  ///
  /// Returns
  /// > 0: The call succeeds and returns the maximum number of media files that can be cached.< 0: Failure. See MediaPlayerError .
  Future<int> getMaxCacheFileCount();

  /// Gets the maximum size of the aggregate storage space for cached media files.
  /// By default, the maximum size of the aggregate storage space for cached media files is 1 GB. You can call the setMaxCacheFileSize method to set the limit according to your scenarios.
  ///
  /// Returns
  /// > 0: The call succeeds and returns the maximum size (in bytes) of the aggregate storage space for cached media files.< 0: Failure. See MediaPlayerError .
  Future<int> getMaxCacheFileSize();

  /// Gets the number of media files that are cached.
  ///
  /// Returns
  /// ≥ 0: The call succeeds and returns the number of media files that are cached.< 0: Failure. See MediaPlayerError .
  Future<int> getCacheFileCount();
}

/// The audio frame observer for the media player.
class MediaPlayerAudioFrameObserver {
  /// @nodoc
  const MediaPlayerAudioFrameObserver({
    this.onFrame,
  });

  /// Occurs each time the player receives an audio frame.
  /// After registering the audio frame observer, the callback occurs every time the player receives an audio frame, reporting the detailed information of the audio frame.
  ///
  /// * [frame] Audio frame information. See AudioPcmFrame .
  final void Function(AudioPcmFrame frame)? onFrame;
}

/// The video frame observer for the media player.
class MediaPlayerVideoFrameObserver {
  /// @nodoc
  const MediaPlayerVideoFrameObserver({
    this.onFrame,
  });

  /// Occurs each time the player receives a video frame.
  /// After registering the video frame observer, the callback occurs every time the player receives a video frame, reporting the detailed information of the video frame.
  ///
  /// * [frame] Video frame information. See VideoFrame .
  final void Function(VideoFrame frame)? onFrame;
}
