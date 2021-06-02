#include "include/agora_rtc_engine/agora_rtc_device_manager_plugin.h"

// This must be included before many other Windows headers.
#include <string>
#include <windows.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

namespace {
using namespace flutter;
using namespace agora::iris;
using namespace agora::iris::rtc;

class AgoraRtcDeviceManagerPlugin : public Plugin {
public:
  static void RegisterWithRegistrar(PluginRegistrarWindows *registrar,
                                    IrisRtcEngine *engine);

  AgoraRtcDeviceManagerPlugin(PluginRegistrar *registrar,
                              IrisRtcEngine *engine);

  virtual ~AgoraRtcDeviceManagerPlugin();

private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(const MethodCall<EncodableValue> &method_call,
                        std::unique_ptr<MethodResult<EncodableValue>> result,
                        bool audio);

private:
  IrisRtcEngine *engine_;
};

// static
void AgoraRtcDeviceManagerPlugin::RegisterWithRegistrar(
    PluginRegistrarWindows *registrar, IrisRtcEngine *engine) {
  auto audio_method_channel = std::make_unique<MethodChannel<EncodableValue>>(
      registrar->messenger(), "agora_rtc_audio_device_manager",
      &StandardMethodCodec::GetInstance());
  auto video_method_channel = std::make_unique<MethodChannel<EncodableValue>>(
      registrar->messenger(), "agora_rtc_video_device_manager",
      &StandardMethodCodec::GetInstance());

  auto plugin =
      std::make_unique<AgoraRtcDeviceManagerPlugin>(registrar, engine);

  audio_method_channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto &call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result), true);
      });
  video_method_channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto &call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result), false);
      });

  registrar->AddPlugin(std::move(plugin));
}

AgoraRtcDeviceManagerPlugin::AgoraRtcDeviceManagerPlugin(
    PluginRegistrar *registrar, IrisRtcEngine *engine)
    : engine_(engine) {}

AgoraRtcDeviceManagerPlugin::~AgoraRtcDeviceManagerPlugin() {}

void AgoraRtcDeviceManagerPlugin::HandleMethodCall(
    const MethodCall<EncodableValue> &method_call,
    std::unique_ptr<MethodResult<EncodableValue>> result, bool audio) {
  auto method = method_call.method_name();
  if (!method_call.arguments()) {
    result->Error("Bad Arguments", "Null arguments received");
    return;
  }
  if (method.compare("callApi") == 0) {
    auto arguments = std::get<EncodableMap>(*method_call.arguments());
    auto api_type = std::get<int32_t>(arguments[EncodableValue("apiType")]);
    auto &params = std::get<std::string>(arguments[EncodableValue("params")]);
    char res[kMaxResultLength] = "";
    int ret = 0;
    if (audio) {
      ret = engine_->device_manager()->CallApi(
          static_cast<ApiTypeAudioDeviceManager>(api_type), params.c_str(),
          res);
    } else {
      ret = engine_->device_manager()->CallApi(
          static_cast<ApiTypeVideoDeviceManager>(api_type), params.c_str(),
          res);
    }

    if (ret == 0) {
      std::string res_str(res);
      if (res_str.empty()) {
        result->Success();
      } else {
        result->Success(EncodableValue(res_str));
      }
    } else if (ret > 0) {
      result->Success(EncodableValue(ret));
    } else {
      result->Error(std::to_string(ret));
    }
  } else {
    result->NotImplemented();
  }
}
} // namespace

void AgoraRtcDeviceManagerPluginRegisterWithRegistrar(
    PluginRegistrarWindows *registrar, IrisRtcEngine *engine) {
  AgoraRtcDeviceManagerPlugin::RegisterWithRegistrar(registrar, engine);
}
