#include "include/agora_rtc_engine/agora_rtc_engine_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

// For getPlatformVersion; remove unless needed for your plugin implementation.
#include <VersionHelpers.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>
#include <flutter/texture_registrar.h>

#include <map>
#include <memory>
#include <sstream>

#include "include/agora_rtc_engine/agora_texture_view_factory.h"
#include "include/iris/iris_engine.h"
#include "include/iris/iris_renderer.h"

namespace {
using namespace agora::iris;

class AgoraRtcEnginePlugin : public flutter::Plugin {
public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  AgoraRtcEnginePlugin(flutter::PluginRegistrar *registrar);

  virtual ~AgoraRtcEnginePlugin();

private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);

private:
  std::unique_ptr<IrisEngine> engine_;
  std::unique_ptr<AgoraTextureViewFactory> factory_;
};

// static
void AgoraRtcEnginePlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar) {
  auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          registrar->messenger(), "agora_rtc_engine",
          &flutter::StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<AgoraRtcEnginePlugin>(registrar);

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto &call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  registrar->AddPlugin(std::move(plugin));
}

AgoraRtcEnginePlugin::AgoraRtcEnginePlugin(flutter::PluginRegistrar *registrar)
    : engine_(new IrisEngine),
      factory_(new AgoraTextureViewFactory(
          registrar, engine_->iris_raw_data()->iris_renderer())) {}

AgoraRtcEnginePlugin::~AgoraRtcEnginePlugin() {}

void AgoraRtcEnginePlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue> &method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
  auto method = method_call.method_name();
  if (!method_call.arguments()) {
    result->Error("Bad Arguments", "Null arguments received");
    return;
  }
  if (method.compare("callApi") == 0) {
    auto arguments = std::get<flutter::EncodableMap>(*method_call.arguments());
    auto api_type =
        std::get<int32_t>(arguments[flutter::EncodableValue("apiType")]);
    auto &params =
        std::get<std::string>(arguments[flutter::EncodableValue("params")]);
    char res[kMaxResultLength];
    auto ret = engine_->CallApi(static_cast<ApiTypeEngine>(api_type),
                                params.c_str(), res);
    result->Success(flutter::EncodableValue(ret));
  } else if (method.compare("createTextureRender") == 0) {
    auto texture_id = factory_->CreateTextureRenderer();
    result->Success(flutter::EncodableValue(texture_id));
  } else if (method.compare("destroyTextureRender") == 0) {
    auto arguments = std::get<flutter::EncodableMap>(*method_call.arguments());
    auto texture_id =
        std::get<int64_t>(arguments[flutter::EncodableValue("id")]);
    factory_->DestoryTextureRenderer(texture_id);
    result->Success();
  } else {
    result->NotImplemented();
  }
}
} // namespace

void AgoraRtcEnginePluginRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  AgoraRtcEnginePlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
