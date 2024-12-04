#ifndef FLUTTER_PLUGIN_IRIS_TESTER_PLUGIN_H_
#define FLUTTER_PLUGIN_IRIS_TESTER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace iris_tester {

class IrisTesterPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  IrisTesterPlugin();

  virtual ~IrisTesterPlugin();

  // Disallow copy and assign.
  IrisTesterPlugin(const IrisTesterPlugin&) = delete;
  IrisTesterPlugin& operator=(const IrisTesterPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace iris_tester

#endif  // FLUTTER_PLUGIN_IRIS_TESTER_PLUGIN_H_
