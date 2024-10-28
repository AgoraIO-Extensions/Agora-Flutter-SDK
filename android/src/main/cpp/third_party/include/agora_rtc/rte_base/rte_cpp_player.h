/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once
#include <functional>
#include <string>

#include "rte_base/c/c_rte.h"
#include "rte_base/c/c_player.h"

#include "rte_cpp_error.h"
#include "rte_cpp_callback_utils.h"
#include "rte_cpp_canvas.h"
#include "rte_cpp_string.h"
#include "rte_cpp_stream.h"

namespace rte {

using PlayerState = ::RtePlayerState;
using PlayerEvent = ::RtePlayerEvent;
using PlayerMetadataType = ::RtePlayerMetadataType;
using PlayerInfo = ::RtePlayerInfo;
using PlayerStats = ::RtePlayerStats;
using PlayerCustomSourceProvider = ::RtePlayerCustomSourceProvider;
using AbrSubscriptionLayer = ::RteAbrSubscriptionLayer;
using AbrFallbackLayer = ::RteAbrFallbackLayer;

class PlayerInitialConfig {};

static void onStateChanged(::RtePlayerObserver *observer,
                          RtePlayerState old_state, RtePlayerState new_state,
                          RteError *err);

static void onPositionChanged(::RtePlayerObserver *observer, uint64_t curr_time,
                            uint64_t utc_time);

static void onResolutionChanged(::RtePlayerObserver *observer, int width, int height);

static void onEvent(::RtePlayerObserver *observer, RtePlayerEvent event);

static void onMetadata(::RtePlayerObserver *observer, ::RtePlayerMetadataType type,
                    const uint8_t *data, size_t length);

static void onPlayerInfoUpdated(::RtePlayerObserver *observer, const RtePlayerInfo *info);

static void onAudioVolumeIndication(::RtePlayerObserver *observer, int32_t volume);


/**
 * The PlayerObserver class is used to observe the event of Player object.
 * @since v4.4.0
 * @technical preview
 */
class PlayerObserver {
 public:
  PlayerObserver() : c_player_observer(::RtePlayerObserverCreate(nullptr)) {

    c_player_observer->base_observer.me_in_target_lang = this;
    
    c_player_observer->on_state_changed = rte::onStateChanged;
    c_player_observer->on_position_changed = rte::onPositionChanged;
    c_player_observer->on_resolution_changed = rte::onResolutionChanged;
    c_player_observer->on_event = rte::onEvent;
    c_player_observer->on_metadata = rte::onMetadata;
    c_player_observer->on_player_info_updated = rte::onPlayerInfoUpdated;
    c_player_observer->on_audio_volume_indication = rte::onAudioVolumeIndication;
  }
  virtual ~PlayerObserver(){ RtePlayerObserverDestroy(c_player_observer, nullptr); }

  // @{
  PlayerObserver(PlayerObserver &other) = delete;
  PlayerObserver(PlayerObserver &&other) = delete;
  PlayerObserver &operator=(const PlayerObserver &cmd) = delete;
  PlayerObserver &operator=(PlayerObserver &&cmd) = delete;
  // @}

  /**
   * This callback will be triggered when the player state changed.
   * @since v4.4.0
   * @param old_state 
   * @param new_state 
   * @param err 
   * @technical preview
   */
  virtual void onStateChanged(PlayerState old_state, PlayerState new_state,
                    rte::Error *err) {};

  /**
   * This callback will be triggered when the playback position changed.
   * @since v4.4.0
   * @param curr_time 
   * @param utc_time 
   * @technical preview
   */
  virtual void onPositionChanged(uint64_t curr_time,
                      uint64_t utc_time) {};

  /**
   * This callback will be triggered when the resolution of the video changed.
   * @since v4.4.0
   * @param width 
   * @param height
   * @technical preview 
   */
  virtual void onResolutionChanged(int width, int height) {};

  /**
   * This callback will be triggered when the player event happened.
   * @since v4.4.0
   * @param event 
   * @technical preview
   */
  virtual void onEvent(PlayerEvent event) {};

  /**
   * This callback will be triggered when the player metadata received.
   * @since v4.4.0
   * @param type 
   * @param data 
   * @param length 
   * @technical preview
   */
  virtual void onMetadata(PlayerMetadataType type,
                      const uint8_t *data, size_t length) {};
  
  /**
   * This callback will be triggered when the player info updated.
   * @since v4.4.0
   * @param info 
   * @technical preview
   */
  virtual void onPlayerInfoUpdated(const PlayerInfo *info) {};

  /**
   * This callback will be triggered when the audio volume indication received.
   * @since v4.4.0
   * @param volume 
   * @technical preview
   */
  virtual void onAudioVolumeIndication(int32_t volume) {};

 private:
  friend class Player;

  ::RtePlayerObserver *c_player_observer;
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

/**
 * The PlayerConfig class is used to configure the Player object.
 * @since v4.4.0
 * @technical preview
 */
class PlayerConfig {
 public:
  PlayerConfig() { RtePlayerConfigInit(&c_player_config, nullptr); }
  ~PlayerConfig() { RtePlayerConfigDeinit(&c_player_config, nullptr); }

  // @{
  PlayerConfig(PlayerConfig &other) = delete;
  PlayerConfig(PlayerConfig &&other) = delete;
  PlayerConfig &operator=(PlayerConfig &&cmd) = delete;

  PlayerConfig &operator=(const PlayerConfig &other) {
    RtePlayerConfigCopy(&c_player_config, &other.c_player_config, nullptr);
    return *this;
  };

    PlayerConfig &operator=(const RtePlayerConfig* other) {
    RtePlayerConfigCopy(&c_player_config, other, nullptr);
    return *this;
  };
  // @}

  /**
   * Set the auto play parameter.
   * @since v4.4.0
   * @param auto_play 
   * @param err 
   * @return void
   * @technical preview
   */
  void SetAutoPlay(bool auto_play, Error *err = nullptr) {
    RtePlayerConfigSetAutoPlay(&c_player_config, auto_play,
                               err != nullptr ? err->get_underlying_impl() : nullptr);
  } 

  /**
   * Get the auto play parameter.
   * @since v4.4.0
   * @param err 
   * @return bool
   * @technical preview
   */
  bool GetAutoPlay(Error *err = nullptr) {
    bool auto_play;
    RtePlayerConfigGetAutoPlay(&c_player_config, &auto_play,
                               err != nullptr ? err->get_underlying_impl() : nullptr);
    return auto_play;
  }

  /**
   * Set the playback speed parameter.
   * @since v4.4.0
   * @param speed 
   * @param err
   * @return void
   * @technical preview
   */
  void SetPlaybackSpeed(int32_t speed, Error *err = nullptr) {
    RtePlayerConfigSetPlaybackSpeed(&c_player_config, speed,
                                    err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Get the playback speed parameter.
   * @since v4.4.0
   * @param err 
   * @return int32_t
   * @technical preview
   */
  int32_t GetPlaybackSpeed(Error *err = nullptr) {
    int32_t speed;
    RtePlayerConfigGetPlaybackSpeed(&c_player_config, &speed,
                                    err != nullptr ? err->get_underlying_impl() : nullptr);
    return speed;
  }

  /**
   * Set the playout audio track index parameter.
   * @since v4.4.0
   * @param idx 
   * @param err 
   * @return void
   * @technical preview
   */
  void SetPlayoutAudioTrackIdx(int idx, Error *err = nullptr) {
    RtePlayerConfigSetPlayoutAudioTrackIdx(&c_player_config, idx,
                                          err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Get the playout audio track index parameter.
   * @since v4.4.0
   * @param err 
   * @return int32_t
   * @technical preview
   */
  int32_t GetPlayoutAudioTrackIdx(Error *err = nullptr) {
    int32_t idx;
    RtePlayerConfigGetPlayoutAudioTrackIdx(&c_player_config, &idx,
                                          err != nullptr ? err->get_underlying_impl() : nullptr);
    return idx;
  }

  /**
   * Set the publish audio track index parameter.
   * @since v4.4.0
   * @param idx 
   * @param err 
   * @return void
   * @technical preview
   */
  void SetPublishAudioTrackIdx(int32_t idx, Error *err = nullptr) {
    RtePlayerConfigSetPublishAudioTrackIdx(&c_player_config, idx,
                                          err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Get the publish audio track index parameter.
   * @since v4.4.0
   * @param err 
   * @return int32_t
   * @technical preview
   */
  int32_t GetPublishAudioTrackIdx(Error *err = nullptr) {
    int32_t idx;
    RtePlayerConfigGetPublishAudioTrackIdx(&c_player_config, &idx,
                                          err != nullptr ? err->get_underlying_impl() : nullptr);
    return idx;
  }

  /**
   * Set the audio track index parameter.
   * @since v4.4.0
   * @param idx 
   * @param err 
   * @return void
   * @technical preview
   */
  void SetAudioTrackIdx(int32_t idx, Error *err = nullptr) {
    RtePlayerConfigSetAudioTrackIdx(&c_player_config, idx,
                                  err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Get the audio track index parameter.
   * @since v4.4.0
   * @param err 
   * @return int32_t
   * @technical preview
   */
  int32_t GetAudioTrackIdx(Error *err = nullptr) {
    int32_t idx;
    RtePlayerConfigGetAudioTrackIdx(&c_player_config, &idx,
                                  err != nullptr ? err->get_underlying_impl() : nullptr);
    return idx;
  }

  /**
   * Set the subtitle track index parameter.
   * @since v4.4.0
   * @param idx 
   * @param err 
   * @return void
   * @technical preview
   */
  void SetSubtitleTrackIdx(int32_t idx, Error *err = nullptr) {
    RtePlayerConfigSetSubtitleTrackIdx(&c_player_config, idx,
                                     err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Get the subtitle track index parameter.
   * @since v4.4.0
   * @param err 
   * @return int32_t
   * @technical preview
   */
  int32_t GetSubtitleTrackIdx(Error *err = nullptr) {
    int32_t idx;
    RtePlayerConfigGetSubtitleTrackIdx(&c_player_config, &idx,
                                     err != nullptr ? err->get_underlying_impl() : nullptr);
    return idx;
  }

  /**
   * Set the external subtitle track index parameter.
   * @since v4.4.0
   * @param idx 
   * @param err 
   * @return void
   * @technical preview
   */
  void SetExternalSubtitleTrackIdx(int32_t idx, Error *err = nullptr) {
    RtePlayerConfigSetExternalSubtitleTrackIdx(&c_player_config, idx,
                                           err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Get the external subtitle track index parameter.
   * @since v4.4.0
   * @param err 
   * @return int32_t
   * @technical preview
   */
  int32_t GetExternalSubtitleTrackIdx(Error *err = nullptr) {
    int32_t idx;
    RtePlayerConfigGetExternalSubtitleTrackIdx(&c_player_config, &idx,
                                           err != nullptr ? err->get_underlying_impl() : nullptr);
    return idx;
  }

  /**
   * Set the audio pitch parameter.
   * @since v4.4.0
   * @param audio_pitch 
   * @param err 
   * @return void
   * @technical preview
   */
  void SetAudioPitch(int32_t audio_pitch, Error *err = nullptr) {
    RtePlayerConfigSetAudioPitch(&c_player_config, audio_pitch,
                              err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Get the audio pitch parameter.
   * @since v4.4.0
   * @param err 
   * @return int32_t
   * @technical preview
   */
  int32_t GetAudioPitch(Error *err = nullptr) {
    int32_t audio_pitch;
    RtePlayerConfigGetAudioPitch(&c_player_config, &audio_pitch,
                              err != nullptr ? err->get_underlying_impl() : nullptr);
    return audio_pitch;
  }

  /**
   * Set the playout volume parameter.
   * @since v4.4.0
   * @param volume 
   * @param err 
   * @return void
   * @technical preview
   */
  void SetPlayoutVolume(int32_t volume, Error *err = nullptr) {
    RtePlayerConfigSetPlayoutVolume(&c_player_config, volume,
                                 err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Get the playout volume parameter.
   * @since v4.4.0
   * @param err 
   * @return int32_t
   * @technical preview
   */
  int32_t GetPlayoutVolume(Error *err = nullptr) {
    int32_t volume;
    RtePlayerConfigGetPlayoutVolume(&c_player_config, &volume,
                                 err != nullptr ? err->get_underlying_impl() : nullptr);
    return volume;
  }

  /**
   * Set the audio playback delay parameter.
   * @since v4.4.0
   * @param volume 
   * @param err 
   * @return void
   * @technical preview
   */
  void SetAudioPlaybackDelay(int32_t delay, Error *err = nullptr) {
    RtePlayerConfigSetAudioPlaybackDelay(&c_player_config, delay,
                                     err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Get the audio playback delay parameter.
   * @since v4.4.0
   * @param err 
   * @return int32_t
   * @technical preview
   */
  int32_t GetAudioPlaybackDelay(Error *err = nullptr) {
    int32_t delay;
    RtePlayerConfigGetAudioPlaybackDelay(&c_player_config, &delay,
                                     err != nullptr ? err->get_underlying_impl() : nullptr);
    return delay;
  }

  /**
   * Set the audio dual mono mode parameter.
   * @since v4.4.0
   * @param mode 
   * @param err 
   * @return void
   * @technical preview
   */
  void SetAudioDualMonoMode(RteAudioDualMonoMode mode, Error *err = nullptr) {
    RtePlayerConfigSetAudioDualMonoMode(&c_player_config, mode,
                                    err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Get the audio dual mono mode parameter.
   * @since v4.4.0
   * @param err 
   * @return RteAudioDualMonoMode
   * @technical preview
   */
  RteAudioDualMonoMode GetAudioDualMonoMode(Error *err = nullptr) {
    RteAudioDualMonoMode mode;
    RtePlayerConfigGetAudioDualMonoMode(&c_player_config, &mode,
                                    err != nullptr ? err->get_underlying_impl() : nullptr);
    return mode;
  }

  /**
   * Set the publish volume parameter.
   * @since v4.4.0
   * @param volume 
   * @param err 
   * @return void
   * @technical preview
   */
  void SetPublishVolume(int32_t volume, Error *err = nullptr) {
    RtePlayerConfigSetPublishVolume(&c_player_config, volume,
                                 err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Get the publish volume parameter.
   * @since v4.4.0
   * @param err 
   * @return int32_t
   * @technical preview
   */
  int32_t GetPublishVolume(Error *err = nullptr) {
    int32_t volume;
    RtePlayerConfigGetPublishVolume(&c_player_config, &volume,
                                 err != nullptr ? err->get_underlying_impl() : nullptr);
    return volume;
  }

  /**
   * Set the loop count parameter.
   * @since v4.4.0
   * @param count 
   * @param err 
   * @return void
   * @technical preview
   */
  void SetLoopCount(int32_t count, Error *err = nullptr) {
    RtePlayerConfigSetLoopCount(&c_player_config, count,
                             err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Get the loop count parameter.
   * @since v4.4.0
   * @param err 
   * @return int32_t
   * @technical preview
   */
  int32_t GetLoopCount(Error *err = nullptr) {
    int32_t count;
    RtePlayerConfigGetLoopCount(&c_player_config, &count,
                             err != nullptr ? err->get_underlying_impl() : nullptr);
    return count;
  }

  /**
   * Set the json parameter.
   * @since v4.4.0
   * @param json_parameter 
   * @param err
   * @return void
   * @technical preview
   */
  void SetJsonParameter(const char *json_parameter, Error *err = nullptr) {
    String str(json_parameter);
    RtePlayerConfigSetJsonParameter(&c_player_config, str.get_underlying_impl(), 
                                 err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Get the json parameter.
   * @since v4.4.0
   * @param err 
   * @return std::string
   * @technical preview
   */
  std::string GetJsonParameter(Error *err = nullptr) {
    String str;
    RtePlayerConfigGetJsonParameter(&c_player_config, str.get_underlying_impl(),
                                 err != nullptr ? err->get_underlying_impl() : nullptr);
    return std::string(str.Cstr());
  }

  /**
   * Set the abr subscription layer parameter.
   * @since v4.4.0
   * @param abr_subscription_layer 
   * @param err 
   * @return void
   * @technical preview
   */
  void SetAbrSubscriptionLayer(AbrSubscriptionLayer abr_subscription_layer, Error *err = nullptr) {
    RtePlayerConfigSetAbrSubscriptionLayer(&c_player_config, abr_subscription_layer,
                                 err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Get the abr subscription layer parameter.
   * @since v4.4.0
   * @param err 
   * @return AbrSubscriptionLayer
   * @technical preview
   */
  AbrSubscriptionLayer GetAbrSubscriptionLayer(Error *err = nullptr) {
    AbrSubscriptionLayer abr_subscription_layer;
    RtePlayerConfigGetAbrSubscriptionLayer(&c_player_config, &abr_subscription_layer,
                                 err != nullptr ? err->get_underlying_impl() : nullptr);
    return abr_subscription_layer;
  }

  /**
   * Set the abr fallback layer parameter.
   * @since v4.4.0
   * @param abr_fallback_layer 
   * @param err 
   * @return void
   * @technical preview
   */
  void SetAbrFallbackLayer(AbrFallbackLayer abr_fallback_layer, Error *err = nullptr) {
    RtePlayerConfigSetAbrFallbackLayer(&c_player_config, abr_fallback_layer,
                                 err != nullptr ? err->get_underlying_impl() : nullptr);
  }


  /**
   * Get the abr fallback layer parameter.
   * @since v4.4.0
   * @param err 
   * @return AbrFallbackLayer
   * @technical preview
   */
  AbrFallbackLayer GetAbrFallbackLayer(Error *err = nullptr) {
    AbrFallbackLayer abr_fallback_layer;
    RtePlayerConfigGetAbrFallbackLayer(&c_player_config, &abr_fallback_layer,
                                 err != nullptr ? err->get_underlying_impl() : nullptr);
    return abr_fallback_layer;
  }


  ::RtePlayerConfig* get_underlying_impl() { return &c_player_config; }

 private:
  friend class Player;

  ::RtePlayerConfig c_player_config;
};

/**
 * The Player class is used to play the url resource.
 * @since v4.4.0
 * @techinical preview
 */
class Player {
 public:
  explicit Player(Rte *self, PlayerInitialConfig *config = nullptr) 
  : c_player(::RtePlayerCreate(&self->c_rte, nullptr, nullptr)) {};
  ~Player() { 
      RtePlayerDestroy(&c_player, nullptr); 
  };

  Player(Player &other) = default;
  Player(Player &&other) = default;

  // @{
  Player &operator=(const Player &cmd) = delete;
  Player &operator=(Player &&cmd) = delete;
  // @}

  /**
   * Preload the url.
   * @since v4.4.0
   * @param url 
   * @param err 
   * @return bool
   * @technical preview
   */
  static bool PreloadWithUrl(const char* url, Error *err = nullptr)  {
    return RtePlayerPreloadWithUrl(nullptr, url, err != nullptr ? err->get_underlying_impl() : nullptr);
  };

  /**
   * Open a url.
   * @since v4.4.0
   * @param url 
   * @param start_time 
   * @param cb 
   * @return void
   * @technical preview
   */
  void OpenWithUrl(const char* url, uint64_t start_time, std::function<void(rte::Error* err)> cb)  {
    CallbackContext<Player>* callbackCtx = new CallbackContext<Player>(this, cb);
    RtePlayerOpenWithUrl(&c_player, url, start_time, &CallbackFunc<::RtePlayer, Player>, callbackCtx);
  };

  /**
   * Open a custom source provider.
   * @since v4.4.0
   * @param provider 
   * @param start_time 
   * @param cb 
   * @return void
   * @technical preview
   */
  void OpenWithCustomSourceProvider(PlayerCustomSourceProvider* provider, uint64_t start_time,
                                    std::function<void(rte::Error* err)> cb) {
    CallbackContext<Player>* callbackCtx = new CallbackContext<Player>(this, cb);
    RtePlayerOpenWithCustomSourceProvider(&c_player, provider, start_time, &CallbackFunc<::RtePlayer, Player>, callbackCtx); 
  };

  /**
   * Open a stream.
   * @since v4.4.0
   * @param stream 
   * @param cb 
   * @return void
   * @technical preview
   */
  void OpenWithStream(Stream* stream, std::function<void(rte::Error* err)> cb)  {
    CallbackContext<Player>* callbackCtx = new CallbackContext<Player>(this, cb);
    RtePlayerOpenWithStream(&c_player, stream != nullptr ? &stream->c_rte_stream : nullptr, &CallbackFunc<::RtePlayer, Player>, callbackCtx);
  };

  /**
   * Get the stats of player.
   * @since v4.4.0
   * @param cb 
   * @return void
   * @technical preview
   */
  void GetStats(std::function<void(rte::PlayerStats *stats, rte::Error *err)> cb){
    CallbackContextWithArgs<Player, rte::PlayerStats*> *ctx = new CallbackContextWithArgs<Player, rte::PlayerStats*>(this, cb);
    RtePlayerGetStats(&c_player, &CallbackFuncWithArgs<::RtePlayer, Player, rte::PlayerStats*>, ctx);
  }

  /**
   * Set the canvas.
   * @since v4.4.0
   * @param canvas 
   * @param err 
   * @return bool
   * @technical preview
   */
  bool SetCanvas(Canvas *canvas, Error *err = nullptr)  {
    return RtePlayerSetCanvas(&c_player, canvas != nullptr ? &canvas->c_canvas : nullptr, err != nullptr ? err->get_underlying_impl() : nullptr);
  };

  /**
   * Start to play.
   * @since v4.4.0
   * @param err 
   * @return bool
   * @technical preview
   */
  bool Play(Error *err = nullptr)  {
    return RtePlayerPlay(&c_player, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Stop the player.
   * @since v4.4.0
   * @param err 
   * @return bool
   * @technical preview
   */
  bool Stop(Error *err = nullptr)  {
    return RtePlayerStop(&c_player, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Pause the player.
   * @since v4.4.0
   * @param err 
   * @return bool
   * @technical preview
   */
  bool Pause(Error *err = nullptr)  {
    return RtePlayerPause(&c_player, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Seek the playback postion.
   * @since v4.4.0
   * @param new_time 
   * @param err 
   * @return true 
   * @return false
   * @technical preview
   */
  bool Seek(uint64_t new_time, Error *err = nullptr)  {
    return RtePlayerSeek(&c_player, new_time, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Mute/Unmute the audio.
   * @since v4.4.0
   * @param mute 
   * @param err 
   * @return bool
   * @technical preview
   */
  bool MuteAudio(bool mute, Error *err = nullptr)  {
    return RtePlayerMuteAudio(&c_player, mute, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Mute/Unmute the video.
   * @since v4.4.0
   * @param mute 
   * @param err 
   * @return bool
   * @technical preview
   */
  bool MuteVideo(bool mute, Error *err = nullptr)  {
    return RtePlayerMuteVideo(&c_player, mute, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Get the playback position.
   * @since v4.4.0
   * @param err 
   * @return uint64_t
   * @technical preview 
   */
  uint64_t GetPosition(Error *err = nullptr){
    return RtePlayerGetPosition(&c_player, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Get the PlayerInfo object.
   * @since v4.4.0
   * @param info 
   * @param err 
   * @return bool
   *  - true: Success.
   *  - false: Failure.
   * @technical preview 
   */
  bool GetInfo(PlayerInfo *info, Error *err = nullptr){
    return RtePlayerGetInfo(&c_player, info, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Get the PlayerConfig object.
   * @since v4.4.0
   * @param config 
   * @param err 
   * @return bool
   *  - true: Success.
   *  - false: Failure.
   * @technical preview
   */
  bool GetConfigs(PlayerConfig* config, Error *err = nullptr)  {
    return RtePlayerGetConfigs(&c_player, config->get_underlying_impl(), err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Set the PlayerConfig object.
   * @since v4.4.0
   * @param config 
   * @param err 
   * @return bool
   *  - true: Success.
   *  - false: Failure.
   * @technical preview
   */
  bool SetConfigs(PlayerConfig* config, Error *err = nullptr)  {
    return RtePlayerSetConfigs(&c_player, config->get_underlying_impl(), err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Register the observer.
   * @since v4.4.0
   * @param observer
   * @param err
   * @return bool
   * @technical preview
   */
  bool RegisterObserver(PlayerObserver *observer, Error *err = nullptr) {
    return RtePlayerRegisterObserver(
        &c_player, observer != nullptr ? observer->c_player_observer : nullptr, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Unregister the observer.
   * @since v4.4.0
   * @param observer
   * @param err
   * @return bool
   * @technical preview
   */
  bool UnregisterObserver(PlayerObserver *observer, Error *err = nullptr){
    return RtePlayerUnregisterObserver(&c_player, observer != nullptr ? observer->c_player_observer : nullptr,
                                err != nullptr ? err->get_underlying_impl() : nullptr);
  }

 private:
  ::RtePlayer c_player;
};

}  // namespace rte
