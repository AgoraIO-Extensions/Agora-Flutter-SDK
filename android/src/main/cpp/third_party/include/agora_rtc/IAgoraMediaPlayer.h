//
//  Agora SDK
//
//  Copyright (c) 2020 Agora.io. All rights reserved.
//
#pragma once  // NOLINT(build/header_guard)

#include "AgoraBase.h"
#include "AgoraMediaBase.h"
#include "AgoraMediaPlayerTypes.h"
#include "AgoraRefPtr.h"

namespace agora {
namespace base {
class IAgoraService;
}
namespace rtc {

class ILocalAudioTrack;
class ILocalVideoTrack;
class IMediaPlayerSourceObserver;
class IMediaPlayerCustomDataProvider;

/**
 * The IMediaPlayerEntity class provides access to a media player entity. If yout want to playout
 * multiple media sources simultaneously, create multiple media player source objects.
 */
class IMediaPlayer : public RefCountInterface {
protected:
  virtual ~IMediaPlayer() {}

public:
  virtual int initialize(base::IAgoraService* agora_service) = 0;

  /**
   * Get unique media player id of the media player entity.
   * @return
   * - >= 0: The source id of this media player entity.
   * - < 0: Failure.
   */
  virtual int getMediaPlayerId() const = 0;

  /**
   * Opens a media file with a specified URL.
   * @param url The URL of the media file that you want to play.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int open(const char* url, int64_t startPos) = 0;

  /**
   * @brief Open a media file with a media file source.
   * @param source Media file source that you want to play, see `MediaSource`
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int openWithMediaSource(const media::base::MediaSource &source) = 0;

  /**
   * Plays the media file.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int play() = 0;

  /**
   * Pauses playing the media file.
   */
  virtual int pause() = 0;

  /**
   * Stops playing the current media file.
   */
  virtual int stop() = 0;

  /**
   * Resumes playing the media file.
   */
  virtual int resume() = 0;

  /**
   * Sets the current playback position of the media file.
   * @param newPos The new playback position (ms).
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int seek(int64_t newPos) = 0;
  
  /** Sets the pitch of the current media file.
   * @param pitch Sets the pitch of the local music file by chromatic scale. The default value is 0,
   * which means keeping the original pitch. The value ranges from -12 to 12, and the pitch value between
   * consecutive values is a chromatic value. The greater the absolute value of this parameter, the
   * higher or lower the pitch of the local music file.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setAudioPitch(int pitch) = 0;

  /**
   * Gets the duration of the media file.
   * @param duration A reference to the duration of the media file.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int getDuration(int64_t& duration) = 0;

  /**
   * Gets the current playback position of the media file.
   * @param currentPosition A reference to the current playback position (ms).
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int getPlayPosition(int64_t& pos) = 0;

  virtual int getStreamCount(int64_t& count) = 0;

  virtual int getStreamInfo(int64_t index, media::base::PlayerStreamInfo* info) = 0;

  /**
   * Sets whether to loop the media file for playback.
   * @param loopCount the number of times looping the media file.
   * - 0: Play the audio effect once.
   * - 1: Play the audio effect twice.
   * - -1: Play the audio effect in a loop indefinitely, until stopEffect() or stop() is called.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setLoopCount(int loopCount) = 0;

  /**
   * Change playback speed
   * @param speed the value of playback speed ref [50-400]
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setPlaybackSpeed(int speed) = 0;

  /**
   * Slect playback audio track of the media file
   * @param index the index of the audio track in media file
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int selectAudioTrack(int index) = 0;

  /**
   * Selects multi audio track of the media file for playback or publish to channel.
   * @param playoutTrackIndex The index of the audio track in media file for local playback.
   * @param publishTrackIndex The index of the audio track in the media file published to the remote.
   * 
   * @note
   * You can obtain the streamIndex of the audio track by calling getStreamInfo..
   * If you want to use selectMultiAudioTrack, you need to open the media file with openWithMediaSource and set enableMultiAudioTrack to true.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure. See {@link media::base::MEDIA_PLAYER_REASON MEDIA_PLAYER_REASON}.
   * - -2: Invalid argument. Argument must be greater than or equal to zero.
   * - -8: Invalid State.You must open the media file with openWithMediaSource and set enableMultiAudioTrack to true
   */
  virtual int selectMultiAudioTrack(int playoutTrackIndex, int publishTrackIndex) = 0;

  /**
   * change player option before play a file
   * @param key the key of the option param
   * @param value the value of option param
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setPlayerOption(const char* key, int value) = 0;

  /**
   * change player option before play a file
   * @param key the key of the option param
   * @param value the value of option param
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setPlayerOption(const char* key, const char* value) = 0;
  /**
   * take screenshot while playing  video
   * @param filename the filename of screenshot file
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int takeScreenshot(const char* filename) = 0;

  /**
   * select internal subtitles in video
   * @param index the index of the internal subtitles
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int selectInternalSubtitle(int index) = 0;

  /**
   * set an external subtitle for video
   * @param url The URL of the subtitle file that you want to load.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setExternalSubtitle(const char* url) = 0;

  virtual media::base::MEDIA_PLAYER_STATE getState() = 0;

  /**
   * @brief Turn mute on or off
   *
   * @param muted Whether to mute on
   * @return int < 0 on behalf of an error, the value corresponds to one of MEDIA_PLAYER_REASON
   */
  virtual int mute(bool muted) = 0;

  /**
   * @brief Get mute state
   *
   * @param[out] muted Whether is mute on
   * @return int < 0 on behalf of an error, the value corresponds to one of MEDIA_PLAYER_REASON
   */
  virtual int getMute(bool& muted) = 0;

  /**
   * @brief Adjust playback volume
   *
   * @param volume The volume value to be adjusted
   * The volume can be adjusted from 0 to 400:
   * 0: mute;
   * 100: original volume;
   * 400: Up to 4 times the original volume (with built-in overflow protection).
   * @return int < 0 on behalf of an error, the value corresponds to one of MEDIA_PLAYER_REASON
   */
  virtual int adjustPlayoutVolume(int volume) = 0;

  /**
   * @brief Get the current playback volume
   *
   * @param[out] volume
   * @return int < 0 on behalf of an error, the value corresponds to one of MEDIA_PLAYER_REASON
   */
  virtual int getPlayoutVolume(int& volume) = 0;

  /**
   * @brief adjust publish signal volume
   *
   * @return int < 0 on behalf of an error, the value corresponds to one of MEDIA_PLAYER_REASON
   */
  virtual int adjustPublishSignalVolume(int volume) = 0;

  /**
   * @brief get publish signal volume
   *
   * @return int < 0 on behalf of an error, the value corresponds to one of MEDIA_PLAYER_REASON
   */
  virtual int getPublishSignalVolume(int& volume) = 0;

  /**
   * @brief Set video rendering view
   *
   * @param view view object, windows platform is HWND
   * @return int < 0 on behalf of an error, the value corresponds to one of MEDIA_PLAYER_REASON
   */
  virtual int setView(media::base::view_t view) = 0;

  /**
   * @brief Set video display mode
   *
   * @param renderMode Video display mode
   * @return int < 0 on behalf of an error, the value corresponds to one of MEDIA_PLAYER_REASON
   */
  virtual int setRenderMode(media::base::RENDER_MODE_TYPE renderMode) = 0;

  /**
   * Registers a media player source observer.
   *
   * Once the media player source observer is registered, you can use the observer to monitor the state change of the media player.
   * @param observer The pointer to the IMediaPlayerSourceObserver object.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int registerPlayerSourceObserver(IMediaPlayerSourceObserver* observer) = 0;

  /**
   * Releases the media player source observer.
   * @param observer The pointer to the IMediaPlayerSourceObserver object.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int unregisterPlayerSourceObserver(IMediaPlayerSourceObserver* observer) = 0;

  /**
   * Register the audio frame observer.
   *
   * @param observer The pointer to the IAudioFrameObserver object.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int registerAudioFrameObserver(media::IAudioPcmFrameSink* observer) = 0;

  /**
   * Registers an audio observer.
   *
   * @param observer The audio observer, reporting the reception of each audio
   * frame. See
   * \ref media::IAudioPcmFrameSink "IAudioFrameObserver" for
   * details.
   * @param mode Use mode of the audio frame. See #RAW_AUDIO_FRAME_OP_MODE_TYPE.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int registerAudioFrameObserver(media::IAudioPcmFrameSink* observer,
                                         RAW_AUDIO_FRAME_OP_MODE_TYPE mode) = 0;

  /**
   * Releases the audio frame observer.
   * @param observer The pointer to the IAudioFrameObserver object.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int unregisterAudioFrameObserver(media::IAudioPcmFrameSink* observer) = 0;

  /**
   * @brief Register the player video observer
   *
   * @param observer observer object
   * @return int < 0 on behalf of an error, the value corresponds to one of MEDIA_PLAYER_REASON
   */
  virtual int registerVideoFrameObserver(media::base::IVideoFrameObserver* observer) = 0;

  /**
   * @brief UnRegister the player video observer
   *
   * @param observer observer object
   * @return int < 0 on behalf of an error, the value corresponds to one of MEDIA_PLAYER_REASON
   */
  virtual int unregisterVideoFrameObserver(agora::media::base::IVideoFrameObserver* observer) = 0;

   /**
   * Registers the audio frame spectrum observer.
   *
   * @param observer The pointer to the {@link media::base::IAudioSpectrumObserver  IAudioSpectrumObserver} object.
   * @param intervalInMS Sets the time interval(ms) between two consecutive audio spectrum callback.
   * The default value is 100. This param should be larger than 10.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int registerMediaPlayerAudioSpectrumObserver(media::IAudioSpectrumObserver* observer, int intervalInMS) = 0;

  /**
   * Releases the audio frame spectrum observer.
   * @param observer The pointer to the {@link media::base::IAudioSpectrumObserver IAudioSpectrumObserver} object.
   * @return
   * - 0: Success.
   * - < 0: Failure. 
   */
   virtual int unregisterMediaPlayerAudioSpectrumObserver(media::IAudioSpectrumObserver* observer) = 0;

  /**
   * @brief Set dual-mono output mode of the music file.
   * 
   * @param mode dual mono mode.  See #agora::media::AUDIO_DUAL_MONO_MODE
   */
  virtual int setAudioDualMonoMode(agora::media::base::AUDIO_DUAL_MONO_MODE mode) = 0;

  /**
    * get sdk version and build number of player SDK.
    * @return String of the SDK version.
    * 
    * @deprecated This method is deprecated.
   */
  virtual const char* getPlayerSdkVersion() = 0;

  /**
   * Get the current play src.
   * @return
   * - current play src of raw bytes.
   */
  virtual const char* getPlaySrc() = 0;


    /**
   * Open the Agora CDN media source.
   * @param src The src of the media file that you want to play.
   * @param startPos The  playback position (ms).
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int openWithAgoraCDNSrc(const char* src, int64_t startPos) = 0;

  /**
   * Gets the number of  Agora CDN lines.
   * @return
   * - > 0: number of CDN.
   * - <= 0: Failure.
   */
  virtual int getAgoraCDNLineCount() = 0;

  /**
   * Switch Agora CDN lines.
   * @param index Specific CDN line index.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int switchAgoraCDNLineByIndex(int index) = 0;

  /**
   * Gets the line of the current CDN.
   * @return
   * - >= 0: Specific line.
   * - < 0: Failure.
   */
  virtual int getCurrentAgoraCDNIndex() = 0;

  /**
   * Enable automatic CDN line switching.
   * @param enable Whether enable.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int enableAutoSwitchAgoraCDN(bool enable) = 0;

  /**
   * Update the CDN source token and timestamp.
   * @param token token.
   * @param ts ts.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int renewAgoraCDNSrcToken(const char* token, int64_t ts) = 0;

  /**
   * Switch the CDN source when open a media through "openWithAgoraCDNSrc" API
   * @param src Specific src.
   * @param syncPts Live streaming must be set to false.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int switchAgoraCDNSrc(const char* src, bool syncPts = false) = 0;

  /**
   * Switch the media source when open a media through "open" API
   * @param src Specific src.
   * @param syncPts Live streaming must be set to false.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int switchSrc(const char* src, bool syncPts = true) = 0;

  /**
   * Preload a media source
   * @param src Specific src.
   * @param startPos The starting position (ms) for playback. Default value is 0.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int preloadSrc(const char* src, int64_t startPos) = 0;

  /**
   * Play a pre-loaded media source
   * @param src Specific src.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int playPreloadedSrc(const char* src) = 0;

  /**
   * Unload a preloaded media source
   * @param src Specific src.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int unloadSrc(const char* src) = 0;

  /**
   * Set spatial audio params for the music file. It can be called after the media player
   * was created.
   *
   * @param params See #agora::SpatialAudioParams. If it's
   * not set, then the spatial audio will be disabled; or it will be enabled.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setSpatialAudioParams(const SpatialAudioParams& params) = 0;

  /**
   * Set sound position params for the music file. It can be called after the media player
   * was created.
   *
   *@param pan The sound position of the music file. The value ranges from -1.0 to 1.0:
   *- 0.0: the music sound comes from the front.
   *- -1.0: the music sound comes from the left.
   *- 1.0: the music sound comes from the right.
   *@param gain Gain of the music. The value ranges from 0.0 to 100.0. The default value is 100.0 (the original gain of the music). The smaller the value, the less the gain.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setSoundPositionParams(float pan, float gain) = 0;

};

/**
 * This class is used to set and manage the player cache, implemented in the
 * form of a singleton, independent of the player.
 */
class IMediaPlayerCacheManager {
public:
  /**
   * Delete the longest used cache file in order to release some of the cache file disk usage.
   * (usually used when the cache quota notification is received)
   * 
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int removeAllCaches() = 0;
  /**
   * Remove the latest media resource cache file.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int removeOldCache() = 0;
  /**
   * Remove the cache file by uri, setting by MediaSource.
   * @param uri URI，identify the uniqueness of the property, Set from `MeidaSource`
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int removeCacheByUri(const char *uri) = 0;
  /**
   * Set cache file path that files will be saved to.
   * @param path file path.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setCacheDir(const char *path) = 0;
  /**
   * Set the maximum number of cached files.
   * @param count maximum number of cached files.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setMaxCacheFileCount(int count) = 0;
  /**
   * Set the maximum size of cache file disk usage.
   * @param cacheSize total size of the largest cache file.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setMaxCacheFileSize(int64_t cacheSize) = 0;
  /**
   * Whether to automatically delete old cache files when the cache file usage reaches the limit.
   * @param enable enable the player to automatically clear the cache.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int enableAutoRemoveCache(bool enable) = 0;
  /**
   * Get the cache directory.
   * @param path cache path, recieve a pointer to be copied to.
   * @param length the length to be copied.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int getCacheDir(char* path, int length) = 0;
  /**
   * Get the maximum number of cached files.
   * @return
   * > 0: file count.
   * - < 0: Failure.
   */
  virtual int getMaxCacheFileCount() = 0;
  /**
   * Get the total size of the largest cache file
   * @return
   * > 0: file size.
   * - < 0: Failure.
   */
  virtual int64_t getMaxCacheFileSize() = 0;
  /**
   * Get the number of all cache files.
   * @return
   * > 0: file count.
   * - < 0: Failure.
   */
  virtual int getCacheFileCount() = 0;

  virtual ~IMediaPlayerCacheManager(){};
};

} //namespace rtc
} // namespace agora

AGORA_API agora::rtc::IMediaPlayerCacheManager* AGORA_CALL getMediaPlayerCacheManager();
