#include "include/agora_rtc_engine/agora_rtc_engine_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

// For getPlatformVersion; remove unless needed for your plugin implementation.
#include <VersionHelpers.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>
#include "include/agora_rtc_engine/video_view_controller.h"

#include <memory>
#include <sstream>
#include <filesystem>

namespace agora_rtc_ng
{

  class AgoraRtcEnginePlugin : public flutter::Plugin
  {
  public:
    static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

    AgoraRtcEnginePlugin(flutter::PluginRegistrarWindows *registrar);

    virtual ~AgoraRtcEnginePlugin();

    // Disallow copy and assign.
    AgoraRtcEnginePlugin(const AgoraRtcEnginePlugin &) = delete;
    AgoraRtcEnginePlugin &operator=(const AgoraRtcEnginePlugin &) = delete;

  private:
    std::unique_ptr<VideoViewController> video_view_controller_;
    // Called when a method is called on this plugin's channel from Dart.
    void HandleMethodCall(
        const flutter::MethodCall<flutter::EncodableValue> &method_call,
        std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
  };

  // static
  void AgoraRtcEnginePlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarWindows *registrar)
  {
    auto channel =
        std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
            registrar->messenger(), "agora_rtc_ng",
            &flutter::StandardMethodCodec::GetInstance());

    auto plugin = std::make_unique<AgoraRtcEnginePlugin>(registrar);

    channel->SetMethodCallHandler(
        [plugin_pointer = plugin.get()](const auto &call, auto result)
        {
          plugin_pointer->HandleMethodCall(call, std::move(result));
        });

    registrar->AddPlugin(std::move(plugin));
  }

  AgoraRtcEnginePlugin::AgoraRtcEnginePlugin(flutter::PluginRegistrarWindows *registrar)
  {
    video_view_controller_ = std::make_unique<VideoViewController>(
        registrar->texture_registrar(),
        registrar->messenger());
  }

  AgoraRtcEnginePlugin::~AgoraRtcEnginePlugin() {}

  void AgoraRtcEnginePlugin::HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result)
  {
    if (method_call.method_name().compare("getAssetAbsolutePath") == 0)
    {
      const auto *asset_path = std::get_if<std::string>(method_call.arguments());
      if (!asset_path)
      {
        result->Error("Invalid arguments", "No asset_path provided.");
        return;
      }

      char exe_path[MAX_PATH];
      GetModuleFileNameA(NULL, exe_path, MAX_PATH);

      if (exe_path)
      {
        // The real asset path: <exe path>/data/flutter_assets/<asset_path>
        auto realPath = std::filesystem::path(exe_path).parent_path() / std::filesystem::path("data") / std::filesystem::path("flutter_assets") / std::filesystem::path(*asset_path);
        result->Success(flutter::EncodableValue(realPath.u8string()));
      }
      else
      {
        result->Error("File not found", "No such file or dictionary");
      }
    }
    else
    {
      result->NotImplemented();
    }
  }

} // namespace agora_rtc_ng

void AgoraRtcEnginePluginRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar)
{
  agora_rtc_ng::AgoraRtcEnginePlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
