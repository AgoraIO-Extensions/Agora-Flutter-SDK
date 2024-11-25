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
   * Set the App ID Parameter, which is used to initialize the engine. This field value needs to be set before calling Rte::InitMediaEngine to initialize the engine.
   * If not set, the default value is an empty string.
   * @since  v4.4.0
   * @param app_id Your project's App ID
   * @param err Possible return of the following ErrorCode
   * - kRteOk: Success
   * - kRteErrorInvalidArgument: Indicates that the app_id parameter is empty.
   * @return void
   */
  void SetAppId(const char *app_id, Error *err = nullptr){
    String str(app_id);
    RteConfigSetAppId(&c_rte_config, str.get_underlying_impl(), err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Get the App ID Parameter.
   * @since  v4.4.0
   * @param err Possible return of the following ErrorCode
   * - kRteOk: Success
   * @return std::string The AppId value
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
   * Set Json format parameters, usually used to set some private parameters supported by rte.
   * @since v4.4.0
   * @param json_parameter json format parameter set
   * @param err Possible return of the following ErrorCode
   * - kRteOk: Success
   * - kRteErrorInvalidArgument: Indicates that the json_parameter parameter is empty.
   * @return void
   */

  void SetJsonParameter(const char *json_parameter, Error *err = nullptr){
    String str(json_parameter);
    RteConfigSetJsonParameter(&c_rte_config, str.get_underlying_impl(), err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Get the currently configured private parameters of the Rte.
   * 
   * @since v4.4.0
   * @param err Possible return of the following error codes:
   * - kRteOk: Success
   * @return std::string Returns the set JSON format parameter set.
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
 */
class Rte {
 public:

  /**
   * Create an Rte object from the rtc bridge. Used in scenarios where the rtc engine has already been initialized, 
   * which can save the operation of initializing the rte engine.
   * @since v4.4.0
   * @param err Possible return values for ErrorCode:
   *  - kRteOk: Success
   *  - kRteErrorInvalidOperation: Indicates that the rtc engine instance has not been created or the rtc engine has not been initialized. 
   *    Unable to bridge rte from rtc engine.
   * @return Rte object. If the Rte object is invalid, subsequent operations on Rte will return an error.
   */
  static Rte GetFromBridge(Error* err = nullptr){
    Rte rte( RteGetFromBridge(err != nullptr ? err->get_underlying_impl() : nullptr));
    return rte;
  }

  /**
   * Construct an Rte object.
   * @since v4.4.0
   * @param config Rte object initialization configuration object.
   */
  explicit Rte(InitialConfig *config = nullptr): c_rte(::RteCreate(config != nullptr ? &config->c_rte_init_cfg : nullptr, nullptr)) {}
  ~Rte(){Destroy();};

  /**
   * Construct a new Rte object.
   * 
   * @param other 
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
   * Register an RTE observer.
   * @since v4.4.0
   * @param observer The object that observes RTE callback events.
   * @param err Possible return values for ErrorCode:
   *  - kRteOk: Success
   *  - kRteErrorInvalidOperation: The corresponding internal RTE object has been destroyed or is invalid.
   *  - kRteErrorInvalidArgument: The registered observer object is null.
   * @return bool
   *  - true: Registration is successful.
   *  - false: Registration failed.
   * @technical preview
   */
  bool RegisterObserver(Observer *observer, Error *err = nullptr){
    return RteRegisterObserver(&c_rte, observer != nullptr ? observer->c_rte_observer : nullptr, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Unregister the RTE observer object.
   * @since v4.4.0
   * @param observer The object that observes RTE callback events.
   * @param err Possible return values for ErrorCode:
   *  - kRteOk: Success
   *  - kRteErrorInvalidOperation: The corresponding internal RTE object has been destroyed or is invalid.
   *  - kRteErrorInvalidArgument: The unregistered observer object is null.
   * @return bool
   *  - true: Unregistration is successful.
   *  - false: Unregistration failed.
   * @technical preview
   */
  bool UnregisterObserver(Observer *observer, Error *err = nullptr){
    return RteUnregisterObserver(&c_rte, observer != nullptr ? observer->c_rte_observer : nullptr,
                                err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Initialize the media engine.
   * 
   * @param cb Asynchronous callback function that returns the result of engine initialization.
   *  - @param err Possible return values for ErrorCode:
   *    - kRteOk: Success
   *    - kRteErrorDefault: Engine initialization failed, specific error reason can be obtained through Error.Message().
   *    - kRteErrorInvalidOperation: Rte object created through GetFromBridge, initialization is not allowed.
   *
   * @param err Possible return values for ErrorCode:
   *  - kRteOk: Success
   *  - kRteErrorDefault: Engine initialization failed, specific error description can be obtained through Error.Message().
   *  - kRteErrorInvalidOperation: The corresponding internal Rte object has been destroyed or is invalid.
   * @return bool Returns whether the asynchronous operation was successfully placed in the asynchronous operation queue, not whether the initialization action was successful.
   *  - true: Asynchronous initialization action executed normally.
   *  - false: Asynchronous initialization action did not execute normally.
   */
  bool InitMediaEngine(std::function<void(rte::Error *err)> cb, Error *err = nullptr){
    auto* ctx = new CallbackContext<Rte>(this, cb);
    return RteInitMediaEngine(&c_rte, &CallbackFunc<::Rte, Rte>, ctx, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

/**
 * Get the configuration of Rte object.
 * @since v4.4.0
 * @param config The object used to get the rte config configuration.
 * @param err Possible return values for ErrorCode:
 *  - kRteOk: Success
 *  - kRteErrorInvalidOperation: The corresponding internal Rte object has been destroyed or is invalid.
 *  - kRteErrorInvalidArgument: The passed config object is null.
 * @return bool Returns the result of getting the configuration information.
 *  - true: Successfully retrieved.
 *  - false: Failed to retrieve.
 */
  bool GetConfigs(Config *config, Error *err = nullptr){
    return RteGetConfigs(&c_rte, config != nullptr ? config->get_underlying_impl(): nullptr, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Configure the Rte object.
   * @since v4.4.0
   * @param config The object used to set the rte config configuration.
   * @param err Possible return values for ErrorCode:
   *  - kRteOk: Success
   *  - kRteErrorInvalidOperation: The corresponding internal Rte object has been destroyed or is invalid.
   *  - kRteErrorInvalidArgument: The passed config object is null.
   * @return bool Returns the result of setting the configuration information.
   *  - true: Successfully set the configuration.
   *  - false: Failed to set the configuration.
   */
  bool SetConfigs(Config *config, Error *err = nullptr){
    return RteSetConfigs(&c_rte, config != nullptr ? config->get_underlying_impl(): nullptr, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Destroy the Rte object. The operation will release all resources used by the Rte object.
   * @since v4.4.0
   * @param err Possible return values for ErrorCode:
   *  - kRteOk: Success
   *  - kRteErrorInvalidOperation: The corresponding internal Rte object has been destroyed or is invalid.
   * @return bool Returns the result of destroying the Rte object.
   *  - true: Successfully destroyed.
   *  - false: Failed to destroy.
   */
  bool Destroy(Error *err = nullptr){
    return RteDestroy(&c_rte, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

 private:

  explicit Rte(::Rte other) { c_rte = other; }
  
 private:
  friend class Player;
  friend class Canvas;

  ::Rte c_rte;
};

}  // namespace rte
