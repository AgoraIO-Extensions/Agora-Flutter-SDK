/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include "internal/c/c_rte.h"
#include "internal/c/bridge.h"

#include "rte_cpp_error.h"
#include "rte_cpp_callback_utils.h"
#include "rte_cpp_string.h"


struct RteObserver;
struct RteInitialConfig;
struct RteConfig;

namespace rte {

class Player;

class RteInitialConfig {
  ::RteInitialConfig *c_rte_init_cfg;
};

class RteObserver {
 public:
  RteObserver(): c_rte_observer(::RteObserverCreate(nullptr)) {
    c_rte_observer->base_observer.me_in_target_lang = this;}
  ~RteObserver() { RteObserverDestroy(c_rte_observer, nullptr); }

  // @{
  RteObserver(RteObserver &other) = delete;
  RteObserver(RteObserver &&other) = delete;
  RteObserver &operator=(const RteObserver &cmd) = delete;
  RteObserver &operator=(RteObserver &&cmd) = delete;
  // @}

 private:
  friend class Rte;

  ::RteObserver *c_rte_observer;
};

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

  void SetAppId(const char *app_id, Error *err){
    String str(app_id);
    RteConfigSetAppId(&c_rte_config, str.get_underlying_impl(), err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  const char* GetAppId(Error *err){
    String str;
    RteConfigGetAppId(&c_rte_config, str.get_underlying_impl(), err != nullptr ? err->get_underlying_impl() : nullptr);
    return str.Cstr();
  }

  void SetLogFolder(const char *log_folder, Error *err){
    String str(log_folder);
    RteConfigSetLogFolder(&c_rte_config, str.get_underlying_impl(), err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  const char* GetLogFolder(Error *err){
    String str;
    RteConfigGetLogFolder(&c_rte_config, str.get_underlying_impl(), err != nullptr ? err->get_underlying_impl() : nullptr);
    return str.Cstr();
  }

  void SetLogFileSize(size_t log_file_size, Error *err){
    RteConfigSetLogFileSize(&c_rte_config, log_file_size, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  size_t GetLogFileSize(Error *err){
    size_t log_file_size;
    RteConfigGetLogFileSize(&c_rte_config, &log_file_size, err != nullptr ? err->get_underlying_impl() : nullptr);
    return log_file_size;
  }

  void SetAreaCode(int32_t area_code, Error *err){
    RteConfigSetAreaCode(&c_rte_config, area_code, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  int32_t GetAreaCode(Error *err){
    int32_t area_code;
    RteConfigGetAreaCode(&c_rte_config, &area_code, err != nullptr ? err->get_underlying_impl() : nullptr);
    return area_code;
  }

  void SetCloudProxy(const char *cloud_proxy, Error *err){
    String str(cloud_proxy);
    RteConfigSetCloudProxy(&c_rte_config, str.get_underlying_impl(), err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  const char* GetCloudProxy(Error *err){
    String str;
    RteConfigGetCloudProxy(&c_rte_config, str.get_underlying_impl(), err != nullptr ? err->get_underlying_impl() : nullptr);
    return str.Cstr();
  }

  void SetJsonParameter(const char *json_parameter, Error *err){
    String str(json_parameter);
    RteConfigSetJsonParameter(&c_rte_config, str.get_underlying_impl(), err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  const char* GetJsonParameter(Error *err){
    String str;
    RteConfigGetJsonParameter(&c_rte_config, str.get_underlying_impl(), err != nullptr ? err->get_underlying_impl() : nullptr);
    return str.Cstr();
  }

 private:
  ::RteConfig* get_underlying_impl() { return &c_rte_config; }

 private:
  friend class Rte;
  ::RteConfig c_rte_config;
};

class Rte {
 public:

  static Rte GetFromBridge(Error* err = nullptr){
    Rte rte( RteGetFromBridge(err != nullptr ? err->get_underlying_impl() : nullptr));
    return rte;
  }

  explicit Rte(::RteInitialConfig *config = nullptr): c_rte(::RteCreate(config, nullptr)) {}
  ~Rte()=default;

  void Destroy(Error *err = nullptr) {
    RteDestroy(&c_rte, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  bool RegisterObserver(RteObserver *observer, Error *err){
    return RteRegisterObserver(&c_rte, observer->c_rte_observer, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  bool UnregisterObserver(RteObserver *observer, Error *err){
    return RteUnregisterObserver(&c_rte, observer->c_rte_observer,
                                err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  bool InitMediaEngine(std::function<void(Rte *self, void *cb_data, rte::Error *err)> cb, void *cb_data, Error *err = nullptr){
    auto* ctx = new CallbackContext<Rte>(this, cb, cb_data);
    return RteInitMediaEngine(&c_rte, &CallbackFunc<::Rte, Rte>, ctx, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  Rte(Rte &other) = default;
  Rte(Rte &&other) = default;

  // @{
  Rte &operator=(const Rte &cmd) = delete;
  Rte &operator=(Rte &&cmd) = delete;
  // @}

  void GetConfigs(Config *config, Error *err){
    RteGetConfigs(&c_rte, config != nullptr ? config->get_underlying_impl(): nullptr, err != nullptr ? err->get_underlying_impl() : nullptr);
  }
  bool SetConfigs(Config *config, std::function<void(Rte *self, void *cb_data, rte::Error *err)> cb, void *cb_data, Error *err = nullptr){
    CallbackContext<Rte>* callbackCtx = new CallbackContext<Rte>(this, cb, cb_data);
    return RteSetConfigs(&c_rte, config != nullptr ? config->get_underlying_impl(): nullptr, &CallbackFunc<::Rte, Rte>, callbackCtx, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

 private:

  explicit Rte(::Rte other) { c_rte = other; }
  
 private:
  friend class Player;
  friend class Canvas;

  ::Rte c_rte;

//   struct RteInitMediaEngineCtx {
//     RteInitMediaEngineCtx(InitMediaEngineCb cb, void *cb_data)
//         : cb(cb), cb_data(cb_data) {}

//     ~RteInitMediaEngineCtx() = default;

//     // @{
//     RteInitMediaEngineCtx(RteInitMediaEngineCtx &other) = delete;
//     RteInitMediaEngineCtx(RteInitMediaEngineCtx &&other) = delete;
//     RteInitMediaEngineCtx &operator=(const RteInitMediaEngineCtx &cmd) = delete;
//     RteInitMediaEngineCtx &operator=(RteInitMediaEngineCtx &&cmd) = delete;
//     // @}

//     InitMediaEngineCb cb;
//     void *cb_data;
//   };

//   static void RteInitMediaEngineCtxProxy(::Rte *self, void *cb_data,
//                                          ::RteError *err){
//   auto *ctx = static_cast<RteInitMediaEngineCtx *>(cb_data);

//   Rte rte;
//   rte.c_rte = *self;

//   Error cpp_err(err);
//   ctx->cb(&rte, ctx->cb_data, &cpp_err);

//   delete ctx;
// }
};

}  // namespace rte
