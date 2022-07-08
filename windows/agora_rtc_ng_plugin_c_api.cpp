#include "include/agora_rtc_ng/agora_rtc_ng_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "include/agora_rtc_ng/agora_rtc_ng_plugin.h"

void AgoraRtcNgPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  agora_rtc_ng::AgoraRtcNgPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
