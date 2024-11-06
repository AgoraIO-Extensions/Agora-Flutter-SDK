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
   * Player state callback. This function is called when the player state changes.
   * @since v4.4.0
   * @param old_state The old state.
   * @param new_state The new state.
   * @param err Possible return values for ErrorCode. Only when the new_state value is kRtePlayerStateFailed, you need to check the value of this parameter.
   *  - kRteErrorDefault. For specific reasons, see Error.Message, including the following situations:
   *    - Failed to connect to the channel.
   *  - kRteErrorInvalidArgument.
   *    - Invalid appid.
   *    - Invalid channelid.
   *    - Invalid uid.
   *  - kRteErrorAuthenticationFailed.
   *    - Invalid token.
   *    - Token expired.
   *  - kRteErrorStreamNotFound. After entering the channel, no stream was received from the broadcaster for more than 10 seconds.
   * @return void
   */
  virtual void onStateChanged(PlayerState old_state, PlayerState new_state,
                    rte::Error *err) {};

  /**
   * This callback will be triggered when the playback position changed.
   * @since v4.4.0
   * @param curr_time 
   * @param utc_time 
   */
  virtual void onPositionChanged(uint64_t curr_time,
                      uint64_t utc_time) {};

  /**
   * Video resolution change callback.
   * @since v4.4.0
   * @param width The width of the video frame.
   * @param height The height of the video frame.
   * @return void
   */
  virtual void onResolutionChanged(int width, int height) {};

  /**
   * Event callback.
   * @since v4.4.0
   * @param event The event notified by the callback. Refer to the rte::PlayerEvent type. Currently, the following events can be handled accordingly:
   * - kRtePlayerEventFreezeStart: Indicates that stuttering has occurred or shows a loading animation.
   * - kRtePlayerEventFreezeStop: Indicates that stuttering has ended or stops the loading animation.
   * - kRtePlayerEventAuthenticationWillExpire: Regenerate the token, use the new token to construct the RTE URL, and call Player::OpenWithUrl to refresh the token.
   * - kRtePlayerEventAbrFallbackToAudioOnlyLayer: Indicates that due to network reasons, it has fallen back to audio-only mode.
   * - kRtePlayerEventAbrRecoverFromAudioOnlyLayer: Indicates that it has recovered from audio-only mode to video mode.
   * @return void
   */
  virtual void onEvent(PlayerEvent event) {};

  /**
   * Metadata callback.
   * @since v4.4.0
   * @param type The type of metadata.
   * @param data The metadata buffer.
   * @param length The length of the metadata.
   * @return void
   */
  virtual void onMetadata(PlayerMetadataType type,
                      const uint8_t *data, size_t length) {};
  
  /**
   * Player information update callback. This is called when fields in rte::PlayerInfo are updated.
   * @since v4.4.0
   * @param info The current PlayerInfo information.
   * @return void 
   */
  virtual void onPlayerInfoUpdated(const PlayerInfo *info) {};

  /**
   * Broadcaster audio volume update callback.
   * @since v4.4.0
   * @param volume The current volume of the Broadcaster. The value range is [0, 255].
   * @return void
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
  * Whether to automatically play after a successful call to Player::OpenWithUrl.
  * If not set, the default value is true.
  * @since v4.4.0
  * @param auto_play 
  * - true: Automatically start streaming and playing after a successful opening.
  * - false: After a successful open with OpenWithUrl, you need to actively call Player::Play() to play the audio and video stream.
  * @param err Possible return values for ErrorCode:
  *   - kRteOk: Success
  * @return void
  */
  void SetAutoPlay(bool auto_play, Error *err = nullptr) {
    RtePlayerConfigSetAutoPlay(&c_player_config, auto_play,
                               err != nullptr ? err->get_underlying_impl() : nullptr);
  } 

 /**
  * Get the auto-play setting.
  * @since v4.4.0
  * @param err Possible return values for ErrorCode:
  *   - kRteOk: Success  
  * @return bool Returns whether auto-play is enabled.
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
   * Set player private parameters. This parameter setting can be done according to actual needs, referring to the suggestions of Agora SA.
   * @since v4.4.0
   * @param json_parameter JSON formatted string
   * @param err Possible return values for ErrorCode:
   *  - kRteOk: Success
   *  - kRteErrorInvalidArgument: Indicates that the json_parameter parameter is empty.
   * @return void
   */
  void SetJsonParameter(const char *json_parameter, Error *err = nullptr) {
    String str(json_parameter);
    RtePlayerConfigSetJsonParameter(&c_player_config, str.get_underlying_impl(), 
                                 err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Get the currently configured private parameters of the player.
   * @since v4.4.0
   * @param err Possible return values for ErrorCode:
   *  - kRteOk: Success
   * @return std::string 
   */
  std::string GetJsonParameter(Error *err = nullptr) {
    String str;
    RtePlayerConfigGetJsonParameter(&c_player_config, str.get_underlying_impl(),
                                 err != nullptr ? err->get_underlying_impl() : nullptr);
    return std::string(str.Cstr());
  }

  /**
   * Set the ABR subscription layer.
   * If ABR is not enabled, the audience can only switch the high and low video stream  in the origin channel. After enabling it, the audience can switch any layer in the abr channel.
   * @since v4.4.0
   * @param abr_subscription_layer The layer to subscribe to. Refer to the rte::AbrSubscriptionLayer enumeration values for details.
   * @param err Possible return values for ErrorCode:
   *  - kRteOk: Success
   *  - kRteErrorInvalidArgument: An illegal AbrSubscriptionLayer value was set.
   * @return void
   */
  void SetAbrSubscriptionLayer(AbrSubscriptionLayer abr_subscription_layer, Error *err = nullptr) {
    RtePlayerConfigSetAbrSubscriptionLayer(&c_player_config, abr_subscription_layer,
                                 err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Get the ABR subscription layer.
   * @since v4.4.0
   * @param err Possible return values for ErrorCode:
   *  - kRteOk: Success
   * @return AbrSubscriptionLayer The currently set subscription layer.
   */
  AbrSubscriptionLayer GetAbrSubscriptionLayer(Error *err = nullptr) {
    AbrSubscriptionLayer abr_subscription_layer;
    RtePlayerConfigGetAbrSubscriptionLayer(&c_player_config, &abr_subscription_layer,
                                 err != nullptr ? err->get_underlying_impl() : nullptr);
    return abr_subscription_layer;
  }

  /**
   * Set the ABR fallback layer option.
   * If ABR is not enabled, after calling this method, the audience can only set kRteAbrFallbackDisabled ~ kRteAbrFallbackAudioOnly in the original channel. 
   * After enabling it, the audience can switch all values of AbrFallbackLayer in the abr channel.
   * @since v4.4.0
   * @param abr_fallback_layer The ABR fallback option to set.
   * @param err Possible return values for ErrorCode:
   *  - kRteOk: Success
   *  - kRteErrorInvalidArgument: An illegal AbrFallbackLayer value was set. Check the value of the passed abr_fallback_layer parameter.
   * @return void
   */
  void SetAbrFallbackLayer(AbrFallbackLayer abr_fallback_layer, Error *err = nullptr) {
    RtePlayerConfigSetAbrFallbackLayer(&c_player_config, abr_fallback_layer,
                                 err != nullptr ? err->get_underlying_impl() : nullptr);
  }


  /**
   * Get the ABR fallback layer option.
   * @since v4.4.0
   * @param err Possible return values for ErrorCode:
   *  - kRteOk: Success
   * @return AbrFallbackLayer The currently set ABR fallback option.
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
 * The Player class can be used to play URL resources.
 * @since v4.4.0
 */
class Player {
 public:
/**
 * Construct a Player object.
 * @since v4.4.0
 * @param rte Rte object.
 * @param config PlayerInitialConfig initialization configuration object. Currently, a null pointer can be passed.
 */
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
   * Preload URL, only valid for rte type URLs. This interface can speed up the OpenWithUrl operation. Up to 20 URLs can be preloaded. If the limit is exceeded, new preloads will replace old ones.
   * @since v4.4.0
   * @param url rte type URL
   * @param err Possible return values for ErrorCode:
   *  - kRteOk: Success
   *  - kRteErrorInvalidArgument: The passed URL is empty or has an invalid format.
   * @return bool Whether the preload operation was successful.
   *  - true: Successfully preload the Rte URL.
   *  - false: Failed to preload the Rte URL.
   */
  static bool PreloadWithUrl(const char* url, Error *err = nullptr)  {
    return RtePlayerPreloadWithUrl(nullptr, url, err != nullptr ? err->get_underlying_impl() : nullptr);
  };

  /** 
   * Open URL resource. Currently, only rte URLs are supported, and cdn URLs and files are not supported.
   * This interface can also be used to refresh the token of an already opened URL.
   * For URL format definition and token refresh method description, refer to the doc:
   *  https://doc.shengwang.cn/doc/rtc/android/best-practice/playing-url
   * @since v4.4.0
   * @param url The URL resource to open
   * @param start_time Start time [currently not supported]
   * @param cb Callback to asynchronously notify the result of the open operation. If an error occurs during open, it will enter the kRtePlayerStateFailed state. You need to call the Stop method before calling OpenWithUrl again.
   *    @param err Possible return values for ErrorCode. At this time, the new_state value corresponds to kRtePlayerStateFailed.
   *      - kRteOk: Success
   *      - kRteErrorDefault: For specific reasons, see Error.Message, including the following situations:
   *        - Failed to connect to the channel
   *      - kRteErrorInvalidArgument:
   *        - Invalid appid
   *        - Invalid channelid
   *        - Invalid uid
   *      - kRteErrorAuthenticationFailed:
   *        - Invalid token
   *        - Token expired
   *      - kRteErrorInvalidOperation:
   *        - Engine not initialized
   * @return void
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
   * Get player playback statistics.
   * @since v4.4.0
   * @param cb Asynchronous callback for statistical data.
   *    @param stats Statistical values.
   *    @param err Possible return values for ErrorCode:
   *      - kRteOk: Success
   * @return void
   */
  void GetStats(std::function<void(rte::PlayerStats *stats, rte::Error *err)> cb){
    CallbackContextWithArgs<Player, rte::PlayerStats*> *ctx = new CallbackContextWithArgs<Player, rte::PlayerStats*>(this, cb);
    RtePlayerGetStats(&c_player, &CallbackFuncWithArgs<::RtePlayer, Player, rte::PlayerStats*>, ctx);
  }

  /**
   * Set canvas. After the stream is successfully pulled, the video frame will be rendered on the set canvas.
   * @since v4.4.0
   * @param canvas The canvas object used to render video frames.
   * @param err Possible return values for ErrorCode:
   *  - kRteOk: Success
   *  - kRteErrorInvalidArgument: The canvas is null.
   *  - kRteErrorInvalidOperation: The corresponding internal Player object has been destroyed or is invalid.
   * @return bool The result of the SetCanvas operation. If it fails, you can check the specific error through err.
   *  - true: Successfully set the canvas.
   *  - false: Failed to set the canvas.
   */
  bool SetCanvas(Canvas *canvas, Error *err = nullptr)  {
    return RtePlayerSetCanvas(&c_player, canvas != nullptr ? &canvas->c_canvas : nullptr, err != nullptr ? err->get_underlying_impl() : nullptr);
  };

  /**
   * Start stream playback.
   * @since v4.4.0
   * @param err Possible return values for ErrorCode:
   *  - kRteOk: Success
   *  - kRteErrorInvalidOperation: The corresponding internal Player object has been destroyed or is invalid.
   * @return bool The result of the Play operation. If it fails, you can check the specific error through err.
   *  - true: Successfully play.
   *  - false: Failed to play.
   */
  bool Play(Error *err = nullptr)  {
    return RtePlayerPlay(&c_player, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Stop playback.
   * @since v4.4.0
   * @param err Possible return values for ErrorCode:
   *  - kRteOk: Success
   *  - kRteErrorInvalidOperation: The corresponding internal Player object has been destroyed or is invalid.
   * @return bool The result of the Stop operation. If it fails, you can check the specific error through err.
   *  - true: Successfully stop.
   *  - false: Failed to stop.
   */
  bool Stop(Error *err = nullptr)  {
    return RtePlayerStop(&c_player, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Pause playback.
   * @since v4.4.0
   * @param err Possible return values for ErrorCode:
   *  - kRteOk: Success
   *  - kRteErrorInvalidOperation: The corresponding internal Player object has been destroyed or is invalid.
   * @return bool The result of the Pause operation. If it fails, you can check the specific error through err.
   *  - true: Successfully pause.
   *  - false: Failed to pause.
   */
  bool Pause(Error *err = nullptr)  {
    return RtePlayerPause(&c_player, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Seek the playback position.
   * @since v4.4.0
   * @param new_time The new playback position to seek to.
   * @param err Possible return values for ErrorCode:
   *  - kRteOk: Success
   *  - kRteErrorInvalidOperation: The corresponding internal Player object has been destroyed or is invalid.
   * @return bool The result of the Seek operation. If it fails, you can check the specific error through err.
   *  - true: Successfully Seek.
   *  - false: Failed to Seek.
   * @technical preview
   */
  bool Seek(uint64_t new_time, Error *err = nullptr)  {
    return RtePlayerSeek(&c_player, new_time, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Mute/unmute audio separately.
   * @since v4.4.0
   * @param mute Whether to mute.
   * @param err Possible return values for ErrorCode:
   *  - kRteOk: Success
   *  - kRteErrorInvalidOperation: The corresponding internal Player object has been destroyed or is invalid.
   * @return bool The result of the MuteAudio operation. If it fails, you can check the specific error through err.
   *  - true: The mute operation was successful.
   *  - false: The mute operation failed.
   */
  bool MuteAudio(bool mute, Error *err = nullptr)  {
    return RtePlayerMuteAudio(&c_player, mute, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Mute/unmute video separately.
   * @since v4.4.0
   * @param mute Whether to mute.
   * @param err Possible return values for ErrorCode:
   *  - kRteOk: Success
   *  - kRteErrorInvalidOperation: The corresponding internal Player object has been destroyed or is invalid.
   * @return bool The result of the MuteVideo operation. If it fails, you can check the specific error through err.
   *  - true: The mute operation was successful.
   *  - false: The mute operation failedl.
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
   * Get player information.
   * @since v4.4.0
   * @param info The object used to receive player information. After the interface call is successful, the player information will be copied to the info object.
   * @param err Possible return values for ErrorCode:
   *  - kRteOk: Success
   *  - kRteErrorInvalidOperation: The corresponding internal Player object has been destroyed or is invalid.
   *  - kRteErrorInvalidArgument: The info object is null.
   * @return bool The result of the GetInfo operation. If it fails, you can check the specific error through err.
   *  - true: Successfully get the player information.
   *  - false: Failed to get the player information.
   */
  bool GetInfo(PlayerInfo *info, Error *err = nullptr){
    return RtePlayerGetInfo(&c_player, info, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Get the configuration of Player object.
   * @since v4.4.0
   * @param config The object used to receive PlayerConfig information.
   * @param err Possible return values for ErrorCode:
   *  - kRteOk: Success
   *  - kRteErrorInvalidOperation: The corresponding internal Player object has been destroyed or is invalid.
   *  - kRteErrorInvalidArgument: The config object is null.
   * @return bool The result of the GetConfigs operation. If it fails, you can check the specific error through err.
   *  - true: Successfully get the configuration.
   *  - false: Failed to get the configuration.
   */
  bool GetConfigs(PlayerConfig* config, Error *err = nullptr)  {
    return RtePlayerGetConfigs(&c_player, config->get_underlying_impl(), err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Configure the Player object.
   * @since v4.4.0
   * @param config The object used to change the player configuration.
   * @param err Possible return values for ErrorCode:
   *  - kRteOk: Success
   *  - kRteErrorInvalidOperation: The corresponding internal Player object has been destroyed or is invalid.
   *  - kRteErrorInvalidArgument: The config object is null.
   * @return bool The result of the SetConfigs operation. If it fails, you can check the specific error through err.
   *  - true: Successfully set the configuration.
   *  - false: Failed to set the configuration.
   */
  bool SetConfigs(PlayerConfig* config, Error *err = nullptr)  {
    return RtePlayerSetConfigs(&c_player, config->get_underlying_impl(), err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Register player observer.
   * @since v4.4.0
   * @param observer The object used to receive player-related callbacks.
   * @param err Possible return values for ErrorCode:
   *  - kRteOk: Success
   *  - kRteErrorInvalidOperation: The corresponding internal Player object has been destroyed or is invalid.
   *  - kRteErrorInvalidArgument: The observer object is null.
   * @return bool The result of the RegisterObserver operation. If it fails, you can check the specific error through err.
   *  - true: Successfully register the observer.
   *  - false: Failed to register the observer.
   */
  bool RegisterObserver(PlayerObserver *observer, Error *err = nullptr) {
    return RtePlayerRegisterObserver(
        &c_player, observer != nullptr ? observer->c_player_observer : nullptr, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

/**
 * Unregister player observer.
 * @since v4.4.0
 * @param observer The object used to receive player-related callbacks.
 * @param err Possible return values for ErrorCode:
 *  - kRteOk: Success
 *  - kRteErrorInvalidOperation: The corresponding internal Player object has been destroyed or is invalid.
 *  - kRteErrorInvalidArgument: The observer object is null.
 * @return bool The result of the UnregisterObserver operation. If it fails, you can check the specific error through err.
 *  - true: Successfully unregister the observer.
 * - false: Failed to unregister the observer.
 */
  bool UnregisterObserver(PlayerObserver *observer, Error *err = nullptr){
    return RtePlayerUnregisterObserver(&c_player, observer != nullptr ? observer->c_player_observer : nullptr,
                                err != nullptr ? err->get_underlying_impl() : nullptr);
  }

 private:
  ::RtePlayer c_player;
};

}  // namespace rte
