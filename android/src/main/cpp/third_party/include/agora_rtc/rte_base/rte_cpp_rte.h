/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once
#include <string>
#include "rte_base/c/c_rte.h"
#include "rte_base/c/bridge.h"

#include "rte_cpp_error.h"
#include "rte_cpp_callback_utils.h"
#include "rte_cpp_string.h"

struct RteObserver;
struct RteInitialConfig;
struct RteConfig;

namespace rte {

class Player;

/**
 * The InitialConfig class is used to initialize the Rte object.
 * @since v4.4.0
 * @technical preview
 */
class InitialConfig {
 public:
  InitialConfig() { RteInitialConfigInit(&c_rte_init_cfg, nullptr); }
  ~InitialConfig() { RteInitialConfigDeinit(&c_rte_init_cfg, nullptr);}

 private:
  friend class Rte;
  ::RteInitialConfig c_rte_init_cfg;
};

/**
 * The Observer class is used to observe the event of Rte object.
 * @since v4.4.0
 * @technical preview
 */
class Observer {
 public:
  Observer(): c_rte_observer(::RteObserverCreate(nullptr)) {
    c_rte_observer->base_observer.me_in_target_lang = this;}
  ~Observer() { RteObserverDestroy(c_rte_observer, nullptr); }

  // @{
  Observer(Observer &other) = delete;
  Observer(Observer &&other) = delete;
  Observer &operator=(const Observer &cmd) = delete;
  Observer &operator=(Observer &&cmd) = delete;
  // @}

 private:
  friend class Rte;

  ::RteObserver *c_rte_observer;
};

/**
 * The Config class is used to configure the Rte object.
 * @since v4.4.0
 * @technical preview
 */
class Config {
 public:
  Config() {RteConfigInit(&c_rte_config, nullptr);}
  ~Config() {RteConfigDeinit(&c_rte_config, nullptr);}

  // @{
  Config(Config &other) = delete;
  Config(Config &&other) = delete;
  Config &operator=(const Config &cmd) = delete;
  Config &operator=(Config &&cmd) = delete;
  // @}

  /**
   * Set the App Id Parameter
   * @since v4.4.0
   * @param app_id 
   * @param err 
   * @technical preview
   */
  void SetAppId(const char *app_id, Error *err = nullptr){
    String str(app_id);
    RteConfigSetAppId(&c_rte_config, str.get_underlying_impl(), err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Get the App Id Parameter
   * @since v4.4.0
   * @param err 
   * @return const char* 
   * @technical preview
   */
  std::string GetAppId(Error *err = nullptr){
    String str;
    RteConfigGetAppId(&c_rte_config, str.get_underlying_impl(), err != nullptr ? err->get_underlying_impl() : nullptr);
    return std::string(str.Cstr());
  }


  /**
   * Set the Log Folder Parameter
   * @since v4.4.0
   * @param log_folder 
   * @param err 
   * @technical preview
   */
  void SetLogFolder(const char *log_folder, Error *err = nullptr){
    String str(log_folder);
    RteConfigSetLogFolder(&c_rte_config, str.get_underlying_impl(), err != nullptr ? err->get_underlying_impl() : nullptr);
  }


  /**
   * Get the Log Folder Parameter
   * @since v4.4.0
   * @param err 
   * @return const char* 
   * @technical preview
   */
  std::string GetLogFolder(Error *err = nullptr){
    String str;
    RteConfigGetLogFolder(&c_rte_config, str.get_underlying_impl(), err != nullptr ? err->get_underlying_impl() : nullptr);
    return std::string(str.Cstr());
  }

  /**
   * Set the Log File Size Parameter
   * @since v4.4.0
   * @param log_file_size 
   * @param err 
   * @technical preview
   */
  void SetLogFileSize(size_t log_file_size, Error *err = nullptr){
    RteConfigSetLogFileSize(&c_rte_config, log_file_size, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Get the Log File Size Parameter
   * @since v4.4.0
   * @param err 
   * @return size_t 
   * @technical preview
   */
  size_t GetLogFileSize(Error *err = nullptr){
    size_t log_file_size;
    RteConfigGetLogFileSize(&c_rte_config, &log_file_size, err != nullptr ? err->get_underlying_impl() : nullptr);
    return log_file_size;
  }

  /**
   * Set the Area Code Parameter
   * @since v4.4.0
   * @param area_code 
   * @param err 
   * @technical preview
   */
  void SetAreaCode(int32_t area_code, Error *err = nullptr){
    RteConfigSetAreaCode(&c_rte_config, area_code, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Get the Area Code Parameter
   * @since v4.4.0
   * @param err 
   * @return int32_t 
   * @technical preview
   */
  int32_t GetAreaCode(Error *err = nullptr){
    int32_t area_code;
    RteConfigGetAreaCode(&c_rte_config, &area_code, err != nullptr ? err->get_underlying_impl() : nullptr);
    return area_code;
  }

  /**
   * Set the Cloud Proxy Parameter
   * @since v4.4.0
   * @param cloud_proxy 
   * @param err 
   * @technical preview
   */
  void SetCloudProxy(const char *cloud_proxy, Error *err = nullptr){
    String str(cloud_proxy);
    RteConfigSetCloudProxy(&c_rte_config, str.get_underlying_impl(), err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Get the Cloud Proxy Parameter
   * @since v4.4.0
   * @param err 
   * @return const char* 
   * @technical preview
   */
  std::string GetCloudProxy(Error *err = nullptr){
    String str;
    RteConfigGetCloudProxy(&c_rte_config, str.get_underlying_impl(), err != nullptr ? err->get_underlying_impl() : nullptr);
    return std::string(str.Cstr());
  }

  /**
   * Set the Json Parameter
   * @since v4.4.0
   * @param json_parameter 
   * @param err
   * @technical preview
   */
  void SetJsonParameter(const char *json_parameter, Error *err = nullptr){
    String str(json_parameter);
    RteConfigSetJsonParameter(&c_rte_config, str.get_underlying_impl(), err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Get the Json Parameter 
   * @since v4.4.0
   * @param err 
   * @return const char* 
   * @technical preview
   */
  std::string GetJsonParameter(Error *err = nullptr){
    String str;
    RteConfigGetJsonParameter(&c_rte_config, str.get_underlying_impl(), err != nullptr ? err->get_underlying_impl() : nullptr);
    return std::string(str.Cstr());
  }

 private:
  ::RteConfig* get_underlying_impl() { return &c_rte_config; }

 private:
  friend class Rte;
  ::RteConfig c_rte_config;
};

/**
 * The Rte class, which is the base interface of the Agora Real Time Engagement SDK.
 * @since v4.4.0
 * @technical preview
 */
class Rte {
 public:

  /**
   * Create a new Rte object via the bridge method.
   * 
   * @param err 
   * @return Rte 
   * @technical preview
   */
  static Rte GetFromBridge(Error* err = nullptr){
    Rte rte( RteGetFromBridge(err != nullptr ? err->get_underlying_impl() : nullptr));
    return rte;
  }

  /**
   * Construct a new Rte object.
   * 
   * @param config 
   * @technical preview
   */
  explicit Rte(InitialConfig *config = nullptr): c_rte(::RteCreate(config != nullptr ? &config->c_rte_init_cfg : nullptr, nullptr)) {}
  ~Rte(){RteDestroy(&c_rte, nullptr);};

  /**
   * Construct a new Rte object.
   * 
   * @param other 
   * @technical preview
   */
  Rte(Rte &&other) : c_rte(other.c_rte) {
    other.c_rte = {};
  }

  // @{
  Rte(Rte &other) = delete;
  Rte &operator=(const Rte &other) = delete;
  Rte &operator=(Rte &&other) = delete;
  // @}

  /**
   * Register the observer.
   * 
   * @param observer 
   * @param err 
   * @return bool
   * @technical preview
   */
  bool RegisterObserver(Observer *observer, Error *err = nullptr){
    return RteRegisterObserver(&c_rte, observer != nullptr ? observer->c_rte_observer : nullptr, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Unregister the observer.
   * 
   * @param observer 
   * @param err 
   * @return bool
   * @technical preview
   */
  bool UnregisterObserver(Observer *observer, Error *err = nullptr){
    return RteUnregisterObserver(&c_rte, observer != nullptr ? observer->c_rte_observer : nullptr,
                                err != nullptr ? err->get_underlying_impl() : nullptr);
  }


  /**
   * Initialize the media engine.
   * 
   * @param cb 
   * @param err 
   * @return bool
   * @technical preview
   */
  bool InitMediaEngine(std::function<void(rte::Error *err)> cb, Error *err = nullptr){
    auto* ctx = new CallbackContext<Rte>(this, cb);
    return RteInitMediaEngine(&c_rte, &CallbackFunc<::Rte, Rte>, ctx, err != nullptr ? err->get_underlying_impl() : nullptr);
  }


  /**
   * Get the Configs object.
   * 
   * @param config 
   * @param err 
   * @return bool 
   * @technical preview
   */
  bool GetConfigs(Config *config, Error *err = nullptr){
    return RteGetConfigs(&c_rte, config != nullptr ? config->get_underlying_impl(): nullptr, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Set the Configs object.
   * 
   * @param config 
   * @param err 
   * @return true 
   * @return false 
   * @technical preview
   */
  bool SetConfigs(Config *config, Error *err = nullptr){
    return RteSetConfigs(&c_rte, config != nullptr ? config->get_underlying_impl(): nullptr, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

 private:

  explicit Rte(::Rte other) { c_rte = other; }
  
 private:
  friend class Player;
  friend class Canvas;

  ::Rte c_rte;
};

}  // namespace rte
