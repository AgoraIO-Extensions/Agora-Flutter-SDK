/// Generated by terra, DO NOT MODIFY BY HAND.

#ifndef FAKE_IMUSICPLAYER_INTERNAL_H_
#define FAKE_IMUSICPLAYER_INTERNAL_H_

#include "IAgoraMusicContentCenter.h"

namespace agora {
namespace rtc {
class FakeIMusicPlayerInternal : public agora::rtc::IMusicPlayer {
  virtual int initialize(base::IAgoraService *agora_service) override {
    return 0;
  }

  virtual int getMediaPlayerId() const override { return 0; }

  virtual int open(char const *url, int64_t startPos) override { return 0; }

  virtual int openWithCustomSource(
      int64_t startPos,
      media::base::IMediaPlayerCustomDataProvider *provider) override {
    return 0;
  }

  virtual int
  openWithMediaSource(media::base::MediaSource const &source) override {
    return 0;
  }

  virtual int play() override { return 0; }

  virtual int pause() override { return 0; }

  virtual int stop() override { return 0; }

  virtual int resume() override { return 0; }

  virtual int seek(int64_t newPos) override { return 0; }

  virtual int setAudioPitch(int pitch) override { return 0; }

  virtual int getDuration(int64_t &duration) override { return 0; }

  virtual int getPlayPosition(int64_t &pos) override { return 0; }

  virtual int getStreamCount(int64_t &count) override { return 0; }

  virtual int getStreamInfo(int64_t index,
                            media::base::PlayerStreamInfo *info) override {
    return 0;
  }

  virtual int setLoopCount(int loopCount) override { return 0; }

  virtual int setPlaybackSpeed(int speed) override { return 0; }

  virtual int selectAudioTrack(int index) override { return 0; }

  virtual int setPlayerOption(char const *key, int value) override { return 0; }

  virtual int setPlayerOption(char const *key, char const *value) override {
    return 0;
  }

  virtual int takeScreenshot(char const *filename) override { return 0; }

  virtual int selectInternalSubtitle(int index) override { return 0; }

  virtual int setExternalSubtitle(char const *url) override { return 0; }

  virtual media::base::MEDIA_PLAYER_STATE getState() override {
    return media::base::MEDIA_PLAYER_STATE::PLAYER_STATE_IDLE;
  }

  virtual int mute(bool muted) override { return 0; }

  virtual int getMute(bool &muted) override { return 0; }

  virtual int adjustPlayoutVolume(int volume) override { return 0; }

  virtual int getPlayoutVolume(int &volume) override { return 0; }

  virtual int adjustPublishSignalVolume(int volume) override { return 0; }

  virtual int getPublishSignalVolume(int &volume) override { return 0; }

  virtual int setView(media::base::view_t view) override { return 0; }

  virtual int setRenderMode(media::base::RENDER_MODE_TYPE renderMode) override {
    return 0;
  }

  virtual int registerPlayerSourceObserver(
      agora::rtc::IMediaPlayerSourceObserver *observer) override {
    return 0;
  }

  virtual int unregisterPlayerSourceObserver(
      agora::rtc::IMediaPlayerSourceObserver *observer) override {
    return 0;
  }

  virtual int registerAudioFrameObserver(
      media::base::IAudioFrameObserver *observer) override {
    return 0;
  }

  virtual int registerAudioFrameObserver(
      media::base::IAudioFrameObserver *observer,
      agora::rtc::RAW_AUDIO_FRAME_OP_MODE_TYPE mode) override {
    return 0;
  }

  virtual int unregisterAudioFrameObserver(
      media::base::IAudioFrameObserver *observer) override {
    return 0;
  }

  virtual int registerVideoFrameObserver(
      media::base::IVideoFrameObserver *observer) override {
    return 0;
  }

  virtual int unregisterVideoFrameObserver(
      agora::media::base::IVideoFrameObserver *observer) override {
    return 0;
  }

  virtual int registerMediaPlayerAudioSpectrumObserver(
      media::IAudioSpectrumObserver *observer, int intervalInMS) override {
    return 0;
  }

  virtual int unregisterMediaPlayerAudioSpectrumObserver(
      media::IAudioSpectrumObserver *observer) override {
    return 0;
  }

  virtual int
  setAudioDualMonoMode(agora::media::base::AUDIO_DUAL_MONO_MODE mode) override {
    return 0;
  }

  virtual char const *getPlayerSdkVersion() override { return ""; }

  virtual char const *getPlaySrc() override { return ""; }

  virtual int openWithAgoraCDNSrc(char const *src, int64_t startPos) override {
    return 0;
  }

  virtual int getAgoraCDNLineCount() override { return 0; }

  virtual int switchAgoraCDNLineByIndex(int index) override { return 0; }

  virtual int getCurrentAgoraCDNIndex() override { return 0; }

  virtual int enableAutoSwitchAgoraCDN(bool enable) override { return 0; }

  virtual int renewAgoraCDNSrcToken(char const *token, int64_t ts) override {
    return 0;
  }

  virtual int switchAgoraCDNSrc(char const *src, bool syncPts) override {
    return 0;
  }

  virtual int switchSrc(char const *src, bool syncPts) override { return 0; }

  virtual int preloadSrc(char const *src, int64_t startPos) override {
    return 0;
  }

  virtual int playPreloadedSrc(char const *src) override { return 0; }

  virtual int unloadSrc(char const *src) override { return 0; }

  virtual int
  setSpatialAudioParams(agora::SpatialAudioParams const &params) override {
    return 0;
  }

  virtual int setSoundPositionParams(float pan, float gain) override {
    return 0;
  }

  virtual int open(int64_t songCode, int64_t startPos) override { return 0; }
};

} // namespace rtc
} // namespace agora

#endif // FAKE_IMUSICPLAYER_INTERNAL_H_
