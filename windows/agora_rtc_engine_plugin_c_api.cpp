#include "include/agora_rtc_engine/agora_rtc_engine_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "include/agora_rtc_engine/agora_rtc_engine_plugin.h"

void AgoraRtcEnginePluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  agora_rtc_ng::AgoraRtcEnginePlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
