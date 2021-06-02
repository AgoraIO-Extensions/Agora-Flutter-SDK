#ifndef FLUTTER_PLUGIN_AGORA_RTC_DEVICE_MANAGER_PLUGIN_H_
#define FLUTTER_PLUGIN_AGORA_RTC_DEVICE_MANAGER_PLUGIN_H_

#include <flutter/plugin_registrar_windows.h>

#include "third_party/iris/include/iris_rtc_engine.h"

void AgoraRtcDeviceManagerPluginRegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar,
    agora::iris::rtc::IrisRtcEngine *engine);

#endif // FLUTTER_PLUGIN_AGORA_RTC_DEVICE_MANAGER_PLUGIN_H_
