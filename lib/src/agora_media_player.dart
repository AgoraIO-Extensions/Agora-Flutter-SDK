import 'package:agora_rtc_engine/src/binding_forward_export.dart';

abstract class MediaPlayer {
  int getMediaPlayerId();

  Future<void> open({required String url, required int startPos});

  Future<void> openWithMediaSource(MediaSource source);

  Future<void> play();

  Future<void> pause();

  Future<void> stop();

  Future<void> resume();

  Future<void> seek(int newPos);

  Future<void> setAudioPitch(int pitch);

  Future<int> getDuration();

  Future<int> getPlayPosition();

  Future<int> getStreamCount();

  Future<PlayerStreamInfo> getStreamInfo(int index);

  Future<void> setLoopCount(int loopCount);

  Future<void> setPlaybackSpeed(int speed);

  Future<void> selectAudioTrack(int index);

  Future<void> takeScreenshot(String filename);

  Future<void> selectInternalSubtitle(int index);

  Future<void> setExternalSubtitle(String url);

  Future<MediaPlayerState> getState();

  Future<void> mute(bool muted);

  Future<bool> getMute();

  Future<void> adjustPlayoutVolume(int volume);

  Future<int> getPlayoutVolume();

  Future<void> adjustPublishSignalVolume(int volume);

  Future<int> getPublishSignalVolume();

  Future<void> setView(int view);

  Future<void> setRenderMode(RenderModeType renderMode);

  void registerPlayerSourceObserver(MediaPlayerSourceObserver observer);

  void unregisterPlayerSourceObserver(MediaPlayerSourceObserver observer);

  void registerMediaPlayerAudioSpectrumObserver(
      {required AudioSpectrumObserver observer, required int intervalInMS});

  void unregisterMediaPlayerAudioSpectrumObserver(
      AudioSpectrumObserver observer);

  Future<void> setAudioDualMonoMode(AudioDualMonoMode mode);

  Future<String> getPlayerSdkVersion();

  Future<String> getPlaySrc();

  Future<void> openWithAgoraCDNSrc(
      {required String src, required int startPos});

  Future<int> getAgoraCDNLineCount();

  Future<void> switchAgoraCDNLineByIndex(int index);

  Future<int> getCurrentAgoraCDNIndex();

  Future<void> enableAutoSwitchAgoraCDN(bool enable);

  Future<void> renewAgoraCDNSrcToken({required String token, required int ts});

  Future<void> switchAgoraCDNSrc({required String src, bool syncPts = false});

  Future<void> switchSrc({required String src, bool syncPts = true});

  Future<void> preloadSrc({required String src, required int startPos});

  Future<void> playPreloadedSrc(String src);

  Future<void> unloadSrc(String src);

  Future<void> setSpatialAudioParams(SpatialAudioParams params);

  Future<void> setSoundPositionParams(
      {required double pan, required double gain});

  void registerAudioFrameObserver(MediaPlayerAudioFrameObserver observer);

  void unregisterAudioFrameObserver(MediaPlayerAudioFrameObserver observer);

  void registerVideoFrameObserver(MediaPlayerVideoFrameObserver observer);

  void unregisterVideoFrameObserver(MediaPlayerVideoFrameObserver observer);

  Future<void> setPlayerOptionInInt({required String key, required int value});

  Future<void> setPlayerOptionInString(
      {required String key, required String value});
}

abstract class MediaPlayerCacheManager {
  Future<void> removeAllCaches();

  Future<void> removeOldCache();

  Future<void> removeCacheByUri(String uri);

  Future<void> setCacheDir(String path);

  Future<void> setMaxCacheFileCount(int count);

  Future<void> setMaxCacheFileSize(int cacheSize);

  Future<void> enableAutoRemoveCache(bool enable);

  Future<String> getCacheDir(int length);

  Future<int> getMaxCacheFileCount();

  Future<int> getMaxCacheFileSize();

  Future<int> getCacheFileCount();
}

class MediaPlayerAudioFrameObserver {
  /// Construct the [MediaPlayerAudioFrameObserver].
  const MediaPlayerAudioFrameObserver({
    this.onFrame,
  });

  final void Function(AudioPcmFrame frame)? onFrame;
}

class MediaPlayerVideoFrameObserver {
  /// Construct the [MediaPlayerVideoFrameObserver].
  const MediaPlayerVideoFrameObserver({
    this.onFrame,
  });

  final void Function(VideoFrame frame)? onFrame;
}
