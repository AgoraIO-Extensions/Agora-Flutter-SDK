/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once
#include <functional>

#include "internal/c/c_rte.h"
#include "internal/c/c_player.h"

#include "rte_cpp_error.h"
#include "rte_cpp_callback_utils.h"
#include "rte_cpp_canvas.h"
#include "rte_cpp_string.h"
#include "rte_cpp_stream.h"

struct RtePlayerObserver;

namespace rte {


using PlayerState = ::RtePlayerState;
using PlayerEvent = ::RtePlayerEvent;
using PlayerMetadataType = ::RtePlayerMetadataType;
using PlayerInfo = ::RtePlayerInfo;
using PlayerStats = ::RtePlayerStats;
using PlayerCustomSourceProvider = ::RtePlayerCustomSourceProvider;

class PlayerInitialConfig {};

static void onStateChanged(::RtePlayerObserver *observer,
                          RtePlayerState old_state, RtePlayerState new_state,
                          RteError *err);

static void onPositionChanged(::RtePlayerObserver *observer, uint64_t curr_time,
                            uint64_t utc_time);

static void onResolutionChanged(::RtePlayerObserver *observer, int width, int height);

static void onEvent(::RtePlayerObserver *observer, RtePlayerEvent event);

static void onMetadata(::RtePlayerObserver *observer, RtePlayerMetadataType type,
                    const uint8_t *data, size_t length);

static void onPlayerInfoUpdated(::RtePlayerObserver *observer, const RtePlayerInfo *info);

static void onAudioVolumeIndication(::RtePlayerObserver *observer, int32_t volume);


class PlayerObserver {
 public:
  PlayerObserver() : c_rte_observer(::RtePlayerObserverCreate(nullptr)) {

    c_rte_observer->base_observer.me_in_target_lang = this;
    
    c_rte_observer->on_state_changed = rte::onStateChanged;
    c_rte_observer->on_position_changed = rte::onPositionChanged;
    c_rte_observer->on_resolution_changed = rte::onResolutionChanged;
    c_rte_observer->on_event = rte::onEvent;
    c_rte_observer->on_metadata = rte::onMetadata;
    c_rte_observer->on_player_info_updated = rte::onPlayerInfoUpdated;
    c_rte_observer->on_audio_volume_indication = rte::onAudioVolumeIndication;
  }
  virtual ~PlayerObserver(){ RtePlayerObserverDestroy(c_rte_observer, nullptr); }

  // @{
  PlayerObserver(PlayerObserver &other) = delete;
  PlayerObserver(PlayerObserver &&other) = delete;
  PlayerObserver &operator=(const PlayerObserver &cmd) = delete;
  PlayerObserver &operator=(PlayerObserver &&cmd) = delete;
  // @}

  virtual void onStateChanged(PlayerState old_state, PlayerState new_state,
                    rte::Error *err) = 0;
  virtual void onPositionChanged(uint64_t curr_time,
                      uint64_t utc_time) = 0;
  virtual void onResolutionChanged(int width, int height) = 0;
  virtual void onEvent(PlayerEvent event) = 0;
  virtual void onMetadata(PlayerMetadataType type,
                      const uint8_t *data, size_t length) = 0;

  virtual void onPlayerInfoUpdated(const PlayerInfo *info) = 0;

  virtual void onAudioVolumeIndication(int32_t volume) = 0;

 private:
  friend class Player;

  ::RtePlayerObserver *c_rte_observer;
};

void onStateChanged(::RtePlayerObserver *observer,
                          RtePlayerState old_state, RtePlayerState new_state,
                          RteError *err){
  auto *player_observer = static_cast<PlayerObserver *>(observer->base_observer.me_in_target_lang);
  if (player_observer != nullptr){
    Error cpp_err(err);
    player_observer->onStateChanged(old_state, new_state, &cpp_err);
  }
}
void onPositionChanged(::RtePlayerObserver *observer, uint64_t curr_time,
                            uint64_t utc_time){
  auto *player_observer = static_cast<PlayerObserver *>(observer->base_observer.me_in_target_lang);
  if (player_observer != nullptr){
    player_observer->onPositionChanged(curr_time, utc_time);
    }
}

void onResolutionChanged(::RtePlayerObserver *observer, int width, int height){
  auto *player_observer = static_cast<PlayerObserver *>(observer->base_observer.me_in_target_lang);
  if (player_observer != nullptr){
    player_observer->onResolutionChanged(width, height);
  }
}

void onEvent(::RtePlayerObserver *observer, RtePlayerEvent event){
  auto *player_observer = static_cast<PlayerObserver *>(observer->base_observer.me_in_target_lang);
  if (player_observer != nullptr){
    player_observer->onEvent(event);
  }
  
}

void onMetadata(::RtePlayerObserver *observer, RtePlayerMetadataType type,
                    const uint8_t *data, size_t length){
  auto *player_observer = static_cast<PlayerObserver *>(observer->base_observer.me_in_target_lang);
  if (player_observer != nullptr){
    player_observer->onMetadata(type, data, length);
  }
}

void onPlayerInfoUpdated(::RtePlayerObserver *observer, const RtePlayerInfo *info){
  auto *player_observer = static_cast<PlayerObserver *>(observer->base_observer.me_in_target_lang);
  if (player_observer != nullptr){
    player_observer->onPlayerInfoUpdated(info);
  }
}

void onAudioVolumeIndication(::RtePlayerObserver *observer, int32_t volume){
  auto *player_observer = static_cast<PlayerObserver *>(observer->base_observer.me_in_target_lang);
  if (player_observer != nullptr){
    player_observer->onAudioVolumeIndication(volume);
  }
}

class PlayerConfig {
 public:
  PlayerConfig() { RtePlayerConfigInit(&c_rte_player_config, nullptr); }
  ~PlayerConfig() { RtePlayerConfigDeinit(&c_rte_player_config, nullptr); }

  // @{
  PlayerConfig(PlayerConfig &other) = delete;
  PlayerConfig(PlayerConfig &&other) = delete;
  PlayerConfig &operator=(const PlayerConfig &cmd) = delete;
  PlayerConfig &operator=(PlayerConfig &&cmd) = delete;
  // @}

  void SetAutoPlay(bool auto_play, Error *err) {
    RtePlayerConfigSetAutoPlay(&c_rte_player_config, auto_play,
                               err != nullptr ? err->get_underlying_impl() : nullptr);
  } 

  bool GetAutoPlay(Error *err) {
    bool auto_play;
    RtePlayerConfigGetAutoPlay(&c_rte_player_config, &auto_play,
                               err != nullptr ? err->get_underlying_impl() : nullptr);
    return auto_play;
  }

  void SetPlaybackSpeed(int32_t speed, Error *err) {
    RtePlayerConfigSetPlaybackSpeed(&c_rte_player_config, speed,
                                    err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  int32_t GetPlaybackSpeed(Error *err) {
    int32_t speed;
    RtePlayerConfigGetPlaybackSpeed(&c_rte_player_config, &speed,
                                    err != nullptr ? err->get_underlying_impl() : nullptr);
    return speed;
  }

  void SetPlayoutAudioTrackIdx(int idx, Error *err) {
    RtePlayerConfigSetPlayoutAudioTrackIdx(&c_rte_player_config, idx,
                                          err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  int32_t GetPlayoutAudioTrackIdx(Error *err) {
    int32_t idx;
    RtePlayerConfigGetPlayoutAudioTrackIdx(&c_rte_player_config, &idx,
                                          err != nullptr ? err->get_underlying_impl() : nullptr);
    return idx;
  }

  void SetPublishAudioTrackIdx(int32_t idx, Error *err) {
    RtePlayerConfigSetPublishAudioTrackIdx(&c_rte_player_config, idx,
                                          err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  int32_t GetPublishAudioTrackIdx(Error *err) {
    int32_t idx;
    RtePlayerConfigGetPublishAudioTrackIdx(&c_rte_player_config, &idx,
                                          err != nullptr ? err->get_underlying_impl() : nullptr);
    return idx;
  }

  void SetAudioTrackIdx(int32_t idx, Error *err) {
    RtePlayerConfigSetAudioTrackIdx(&c_rte_player_config, idx,
                                  err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  int32_t GetAudioTrackIdx(Error *err) {
    int32_t idx;
    RtePlayerConfigGetAudioTrackIdx(&c_rte_player_config, &idx,
                                  err != nullptr ? err->get_underlying_impl() : nullptr);
    return idx;
  }

  void SetSubtitleTrackIdx(int32_t idx, Error *err) {
    RtePlayerConfigSetSubtitleTrackIdx(&c_rte_player_config, idx,
                                     err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  int32_t GetSubtitleTrackIdx(Error *err) {
    int32_t idx;
    RtePlayerConfigGetSubtitleTrackIdx(&c_rte_player_config, &idx,
                                     err != nullptr ? err->get_underlying_impl() : nullptr);
    return idx;
  }

  void SetExternalSubtitleTrackIdx(int32_t idx, Error *err) {
    RtePlayerConfigSetExternalSubtitleTrackIdx(&c_rte_player_config, idx,
                                           err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  int32_t GetExternalSubtitleTrackIdx(Error *err) {
    int32_t idx;
    RtePlayerConfigGetExternalSubtitleTrackIdx(&c_rte_player_config, &idx,
                                           err != nullptr ? err->get_underlying_impl() : nullptr);
    return idx;
  }

  void SetAudioPitch(int32_t audio_pitch, Error *err) {
    RtePlayerConfigSetAudioPitch(&c_rte_player_config, audio_pitch,
                              err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  int32_t GetAudioPitch(Error *err) {
    int32_t audio_pitch;
    RtePlayerConfigGetAudioPitch(&c_rte_player_config, &audio_pitch,
                              err != nullptr ? err->get_underlying_impl() : nullptr);
    return audio_pitch;
  }

  void SetPlayoutVolume(int32_t volume, Error *err) {
    RtePlayerConfigSetPlayoutVolume(&c_rte_player_config, volume,
                                 err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  int32_t GetPlayoutVolume(Error *err) {
    int32_t volume;
    RtePlayerConfigGetPlayoutVolume(&c_rte_player_config, &volume,
                                 err != nullptr ? err->get_underlying_impl() : nullptr);
    return volume;
  }

  void SetAudioPlaybackDelay(int32_t delay, Error *err) {
    RtePlayerConfigSetAudioPlaybackDelay(&c_rte_player_config, delay,
                                     err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  int32_t GetAudioPlaybackDelay(Error *err) {
    int32_t delay;
    RtePlayerConfigGetAudioPlaybackDelay(&c_rte_player_config, &delay,
                                     err != nullptr ? err->get_underlying_impl() : nullptr);
    return delay;
  }

  void SetAudioDualMonoMode(RteAudioDualMonoMode mode, Error *err) {
    RtePlayerConfigSetAudioDualMonoMode(&c_rte_player_config, mode,
                                    err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  RteAudioDualMonoMode GetAudioDualMonoMode(Error *err) {
    RteAudioDualMonoMode mode;
    RtePlayerConfigGetAudioDualMonoMode(&c_rte_player_config, &mode,
                                    err != nullptr ? err->get_underlying_impl() : nullptr);
    return mode;
  }

  void SetPublishVolume(int32_t volume, Error *err) {
    RtePlayerConfigSetPublishVolume(&c_rte_player_config, volume,
                                 err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  int32_t GetPublishVolume(Error *err) {
    int32_t volume;
    RtePlayerConfigGetPublishVolume(&c_rte_player_config, &volume,
                                 err != nullptr ? err->get_underlying_impl() : nullptr);
    return volume;
  }

  void SetLoopCount(int32_t count, Error *err) {
    RtePlayerConfigSetLoopCount(&c_rte_player_config, count,
                             err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  int32_t GetLoopCount(Error *err) {
    int32_t count;
    RtePlayerConfigGetLoopCount(&c_rte_player_config, &count,
                             err != nullptr ? err->get_underlying_impl() : nullptr);
    return count;
  }

  void SetJsonParameter(const char *json_parameter, Error *err) {
    String str(json_parameter);
    RtePlayerConfigSetJsonParameter(&c_rte_player_config, str.get_underlying_impl(), 
                                 err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  const char *GetJsonParameter(Error *err) {
    String str;
    RtePlayerConfigGetJsonParameter(&c_rte_player_config, str.get_underlying_impl(),
                                 err != nullptr ? err->get_underlying_impl() : nullptr);
    return str.Cstr();
  }

 private:
  ::RtePlayerConfig* get_underlying_impl() { return &c_rte_player_config; }

 private:
  friend class Player;

  ::RtePlayerConfig c_rte_player_config;
};


class Player {
 public:
  explicit Player(Rte *self, PlayerInitialConfig *config = nullptr) 
  : c_rte(::RtePlayerCreate(&self->c_rte, nullptr, nullptr)) {};
  ~Player() { RtePlayerDestroy(&c_rte, nullptr); };

  void Destroy(Error *err = nullptr){
  RtePlayerDestroy(&c_rte, err != nullptr ? err->get_underlying_impl() : nullptr);
};

  Player(Player &other) = default;
  Player(Player &&other) = default;

  // @{
  Player &operator=(const Player &cmd) = delete;
  Player &operator=(Player &&cmd) = delete;
  // @}

  void PreloadWithUrl(const char* url, Error* err)  {
    RtePlayerPreloadWithUrl(&c_rte, url, err != nullptr ? err->get_underlying_impl() : nullptr);
  };

  void OpenWithUrl(const char* url, uint64_t start_time, std::function<void(Player* player, void* cb_data, rte::Error* err)> cb,
                    void* cb_data)  {
    CallbackContext<Player>* callbackCtx = new CallbackContext<Player>(this, cb, cb_data);
    RtePlayerOpenWithUrl(&c_rte, url, start_time, &CallbackFunc<::RtePlayer, Player>, callbackCtx);
  };

  void OpenWithCustomSourceProvider(PlayerCustomSourceProvider* provider, uint64_t start_time,
                                    std::function<void(Player* player, void* cb_data, rte::Error* err)> cb,
                                    void* cb_data) {
    CallbackContext<Player>* callbackCtx = new CallbackContext<Player>(this, cb, cb_data);
    RtePlayerOpenWithCustomSourceProvider(&c_rte, provider, start_time, &CallbackFunc<::RtePlayer, Player>, callbackCtx); 
  };


  void OpenWithStream(Stream* stream, std::function<void(Player* player, void* cb_data, rte::Error* err)> cb,
                      void* cb_data)  {
    CallbackContext<Player>* callbackCtx = new CallbackContext<Player>(this, cb, cb_data);
    RtePlayerOpenWithStream(&c_rte, stream != nullptr ? &stream->c_rte_stream : nullptr, &CallbackFunc<::RtePlayer, Player>, callbackCtx);
  };

  void GetStats(std::function<void(Player *player, rte::PlayerStats *stats, void *cb_data, rte::Error *err)> cb, void *cb_data){
    CallbackContextWithArgs<Player, rte::PlayerStats*> *ctx = new CallbackContextWithArgs<Player, rte::PlayerStats*>(this, cb, cb_data);
    RtePlayerGetStats(&c_rte, &CallbackFuncWithArgs<::RtePlayer, Player, rte::PlayerStats*>, ctx);
  }

  void SetCanvas(Canvas *canvas, Error *err)  {
    RtePlayerSetCanvas(&c_rte, canvas != nullptr ? &canvas->c_canvas : nullptr, err != nullptr ? err->get_underlying_impl() : nullptr);
  };

  void Play(Error* err)  {
    RtePlayerPlay(&c_rte, err != nullptr ? err->get_underlying_impl() : nullptr);
  }
  void Stop(Error* err)  {
    RtePlayerStop(&c_rte, err != nullptr ? err->get_underlying_impl() : nullptr);
  }
  void Pause(Error* err)  {
    RtePlayerPause(&c_rte, err != nullptr ? err->get_underlying_impl() : nullptr);
  }
  void Seek(uint64_t new_time, Error* err)  {
    RtePlayerSeek(&c_rte, new_time, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  void MuteAudio(bool mute, Error* err)  {
    RtePlayerMuteAudio(&c_rte, mute, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  void MuteVideo(bool mute, Error* err)  {
    RtePlayerMuteVideo(&c_rte, mute, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  uint64_t GetPosition(Error *err){
    return RtePlayerGetPosition(&c_rte, err != nullptr ? err->get_underlying_impl() : nullptr);
  }
  void GetInfo(PlayerInfo *info, Error *err){
    RtePlayerGetInfo(&c_rte, info, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  void GetConfigs(PlayerConfig* config, Error* err)  {
    RtePlayerGetConfigs(&c_rte, config->get_underlying_impl(), err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  void SetConfigs(PlayerConfig* config, std::function<void(Player* player, void* cb_data, rte::Error* err)> cb,
                  void* cb_data)  {

    rte::CallbackContext<Player>* callbackCtx = new CallbackContext<Player>(this, cb, cb_data);
    RtePlayerSetConfigs(&c_rte, config->get_underlying_impl(), &CallbackFunc<::RtePlayer, Player>, callbackCtx);
  }

  bool RegisterObserver(PlayerObserver *observer, Error *err) {
    return RtePlayerRegisterObserver(
        &c_rte, observer->c_rte_observer, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  void UnregisterObserver(PlayerObserver *observer, Error *err){
    RtePlayerUnregisterObserver(&c_rte, observer->c_rte_observer,
                                err != nullptr ? err->get_underlying_impl() : nullptr);
  }

 private:
  ::RtePlayer c_rte;
};

}  // namespace rte
