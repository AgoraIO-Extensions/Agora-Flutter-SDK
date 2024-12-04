#include "include/iris_tester/iris_tester_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "iris_tester_plugin.h"

void IrisTesterPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  iris_tester::IrisTesterPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
