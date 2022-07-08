#include "include/agora_rtc_ng/agora_rtc_ng_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

// For getPlatformVersion; remove unless needed for your plugin implementation.
#include <VersionHelpers.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>
#include "include/agora_rtc_ng/video_view_controller.h"

#include <memory>
#include <sstream>
#include <filesystem>

namespace agora_rtc_ng
{

  class AgoraRtcNgPlugin : public flutter::Plugin
  {
  public:
    static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

    AgoraRtcNgPlugin(flutter::PluginRegistrarWindows *registrar);

    virtual ~AgoraRtcNgPlugin();

    // Disallow copy and assign.
    AgoraRtcNgPlugin(const AgoraRtcNgPlugin &) = delete;
    AgoraRtcNgPlugin &operator=(const AgoraRtcNgPlugin &) = delete;

  private:
    std::unique_ptr<VideoViewController> video_view_controller_;
    // Called when a method is called on this plugin's channel from Dart.
    void HandleMethodCall(
        const flutter::MethodCall<flutter::EncodableValue> &method_call,
        std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
  };

  // static
  void AgoraRtcNgPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarWindows *registrar)
  {
    auto channel =
        std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
            registrar->messenger(), "agora_rtc_ng",
            &flutter::StandardMethodCodec::GetInstance());

    auto plugin = std::make_unique<AgoraRtcNgPlugin>(registrar);

    channel->SetMethodCallHandler(
        [plugin_pointer = plugin.get()](const auto &call, auto result)
        {
          plugin_pointer->HandleMethodCall(call, std::move(result));
        });

    registrar->AddPlugin(std::move(plugin));
  }

  AgoraRtcNgPlugin::AgoraRtcNgPlugin(flutter::PluginRegistrarWindows *registrar)
  {
    video_view_controller_ = std::make_unique<VideoViewController>(
        registrar->texture_registrar(),
        registrar->messenger());
  }

  AgoraRtcNgPlugin::~AgoraRtcNgPlugin() {}

  void AgoraRtcNgPlugin::HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result)
  {
    if (method_call.method_name().compare("getAssetAbsolutePath") == 0)
    {
      auto asset_path = std::get<std::string>(*method_call.arguments());
      char exe_path[MAX_PATH];
      GetModuleFileNameA(NULL, exe_path, MAX_PATH);

      if (exe_path)
      {
        // The real asset path: <exe path>/data/flutter_assets/<asset_path>
        auto realPath = std::filesystem::path(exe_path).parent_path() / std::filesystem::path("data") / std::filesystem::path("flutter_assets") / std::filesystem::path(asset_path);
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

void AgoraRtcNgPluginRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar)
{
  agora_rtc_ng::AgoraRtcNgPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
