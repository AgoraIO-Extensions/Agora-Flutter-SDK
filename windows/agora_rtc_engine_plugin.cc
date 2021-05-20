#include "include/agora_rtc_engine/agora_rtc_engine_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

#include <flutter/event_channel.h>
#include <flutter/event_stream_handler_functions.h>
#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>
#include <flutter/texture_registrar.h>

#include <map>
#include <memory>
#include <sstream>
#include <vector>

#include "include/agora_rtc_engine/agora_rtc_channel_plugin.h"
#include "include/agora_rtc_engine/agora_texture_view_factory.h"
#include "third_party/iris/include/iris_rtc_engine.h"
#include "third_party/iris/include/iris_rtc_renderer.h"

namespace {
using namespace flutter;
using namespace agora::iris;
using namespace agora::iris::rtc;

class AgoraRtcEnginePlugin : public Plugin, public IrisEventHandler {
public:
  static void RegisterWithRegistrar(PluginRegistrarWindows *registrar);

  AgoraRtcEnginePlugin(PluginRegistrar *registrar);

  virtual ~AgoraRtcEnginePlugin();

public:
  virtual void OnEvent(const char *event, const char *data) override;

  virtual void OnEvent(const char *event, const char *data, const void *buffer,
                       unsigned int length) override;

private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(const MethodCall<EncodableValue> &method_call,
                        std::unique_ptr<MethodResult<EncodableValue>> result);

private:
  std::unique_ptr<EventSink<EncodableValue>> event_sink_;
  std::unique_ptr<IrisRtcEngine> engine_;
  std::unique_ptr<AgoraTextureViewFactory> factory_;
};

// static
void AgoraRtcEnginePlugin::RegisterWithRegistrar(
    PluginRegistrarWindows *registrar) {
  auto method_channel = std::make_unique<MethodChannel<EncodableValue>>(
      registrar->messenger(), "agora_rtc_engine",
      &StandardMethodCodec::GetInstance());
  auto event_channel = std::make_unique<EventChannel<EncodableValue>>(
      registrar->messenger(), "agora_rtc_engine/events",
      &StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<AgoraRtcEnginePlugin>(registrar);

  method_channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto &call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  auto handler = std::make_unique<StreamHandlerFunctions<EncodableValue>>(
      [plugin_pointer =
           plugin.get()](const EncodableValue *arguments,
                         std::unique_ptr<EventSink<EncodableValue>> &&events)
          -> std::unique_ptr<StreamHandlerError<EncodableValue>> {
        plugin_pointer->event_sink_ = std::move(events);
        return nullptr;
      },
      [plugin_pointer = plugin.get()](const EncodableValue *arguments)
          -> std::unique_ptr<StreamHandlerError<EncodableValue>> {
        plugin_pointer->event_sink_ = nullptr;
        return nullptr;
      });
  event_channel->SetStreamHandler(std::move(handler));

  AgoraRtcChannelPluginRegisterWithRegistrar(registrar, plugin->engine_.get());

  registrar->AddPlugin(std::move(plugin));
}

AgoraRtcEnginePlugin::AgoraRtcEnginePlugin(PluginRegistrar *registrar)
    : engine_(new IrisRtcEngine),
      factory_(new AgoraTextureViewFactory(registrar,
                                           engine_->raw_data()->renderer())) {
  engine_->SetEventHandler(this);
}

AgoraRtcEnginePlugin::~AgoraRtcEnginePlugin() {}

void AgoraRtcEnginePlugin::HandleMethodCall(
    const MethodCall<EncodableValue> &method_call,
    std::unique_ptr<MethodResult<EncodableValue>> result) {
  auto method = method_call.method_name();
  if (!method_call.arguments()) {
    result->Error("Bad Arguments", "Null arguments received");
    return;
  }
  if (method.compare("callApi") == 0) {
    auto arguments = std::get<EncodableMap>(*method_call.arguments());
    auto api_type = std::get<int32_t>(arguments[EncodableValue("apiType")]);
    auto &params = std::get<std::string>(arguments[EncodableValue("params")]);
    char res[kMaxResultLength];
    auto ret = engine_->CallApi(static_cast<ApiTypeEngine>(api_type),
                                params.c_str(), res);
    result->Success(EncodableValue(ret));
  } else if (method.compare("createTextureRender") == 0) {
    auto texture_id = factory_->CreateTextureRenderer();
    result->Success(EncodableValue(texture_id));
  } else if (method.compare("destroyTextureRender") == 0) {
    auto arguments = std::get<EncodableMap>(*method_call.arguments());
    auto texture_id = std::get<int64_t>(arguments[EncodableValue("id")]);
    factory_->DestoryTextureRenderer(texture_id);
    result->Success();
  } else {
    result->NotImplemented();
  }
}

void AgoraRtcEnginePlugin::OnEvent(const char *event, const char *data) {
  if (event_sink_) {
    EncodableMap ret = {{EncodableValue("methodName"), EncodableValue(event)},
                        {EncodableValue("data"), EncodableValue(data)}};
    event_sink_->Success(ret);
  }
}

void AgoraRtcEnginePlugin::OnEvent(const char *event, const char *data,
                                   const void *buffer, unsigned int length) {
  if (event_sink_) {
    std::vector<uint8_t> vector(length);
    if (buffer && length) {
      memcpy((void *)vector[0], buffer, length);
    }
    EncodableMap ret = {{EncodableValue("methodName"), EncodableValue(event)},
                        {EncodableValue("data"), EncodableValue(data)},
                        {EncodableValue("buffer"), EncodableValue(vector)}};
    event_sink_->Success(ret);
  }
}
} // namespace

void AgoraRtcEnginePluginRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  AgoraRtcEnginePlugin::RegisterWithRegistrar(
      PluginRegistrarManager::GetInstance()
          ->GetRegistrar<PluginRegistrarWindows>(registrar));
}
