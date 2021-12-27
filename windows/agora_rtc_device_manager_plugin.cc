#include "include/agora_rtc_engine/agora_rtc_device_manager_plugin.h"
#include "include/agora_rtc_engine/call_api_method_call_handler.h"

// This must be included before many other Windows headers.
#include <string>
#include <windows.h>
#include <memory>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

namespace
{
  using namespace flutter;
  using namespace agora::iris;
  using namespace agora::iris::rtc;

  class RtcDeviceManagerAudioCallApiMethodCallHandler : public CallApiMethodCallHandler
  {

  public:
    RtcDeviceManagerAudioCallApiMethodCallHandler(
        agora::iris::rtc::IrisRtcEngine *engine) : CallApiMethodCallHandler(engine) {}

    int32_t CallApi(int32_t api_type, const char *params,
                    char *result) override
    {
      return reinterpret_cast<IrisRtcDeviceManager *>(irisRtcEngine_->device_manager())->CallApi(static_cast<ApiTypeAudioDeviceManager>(api_type), params, result);
    }
  };

  class RtcDeviceManagerVideoCallApiMethodCallHandler : public CallApiMethodCallHandler
  {

  public:
    RtcDeviceManagerVideoCallApiMethodCallHandler(
        agora::iris::rtc::IrisRtcEngine *engine) : CallApiMethodCallHandler(engine) {}

    int32_t CallApi(int32_t api_type, const char *params,
                    char *result) override
    {
      return reinterpret_cast<IrisRtcDeviceManager *>(irisRtcEngine_->device_manager())->CallApi(static_cast<ApiTypeVideoDeviceManager>(api_type), params, result);
    }
  };

  class AgoraRtcDeviceManagerPlugin : public Plugin
  {
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
    std::unique_ptr<CallApiMethodCallHandler> audioCallApiMethodCallHandler_;
    std::unique_ptr<CallApiMethodCallHandler> videoCallApiMethodCallHandler_;
  };

  // static
  void AgoraRtcDeviceManagerPlugin::RegisterWithRegistrar(
      PluginRegistrarWindows *registrar, IrisRtcEngine *engine)
  {
    auto audio_method_channel = std::make_unique<MethodChannel<EncodableValue>>(
        registrar->messenger(), "agora_rtc_audio_device_manager",
        &StandardMethodCodec::GetInstance());
    auto video_method_channel = std::make_unique<MethodChannel<EncodableValue>>(
        registrar->messenger(), "agora_rtc_video_device_manager",
        &StandardMethodCodec::GetInstance());

    auto plugin =
        std::make_unique<AgoraRtcDeviceManagerPlugin>(registrar, engine);

    audio_method_channel->SetMethodCallHandler(
        [plugin_pointer = plugin.get()](const auto &call, auto result)
        {
          plugin_pointer->HandleMethodCall(call, std::move(result), true);
        });
    video_method_channel->SetMethodCallHandler(
        [plugin_pointer = plugin.get()](const auto &call, auto result)
        {
          plugin_pointer->HandleMethodCall(call, std::move(result), false);
        });

    registrar->AddPlugin(std::move(plugin));
  }

  AgoraRtcDeviceManagerPlugin::AgoraRtcDeviceManagerPlugin(
      PluginRegistrar *registrar, IrisRtcEngine *engine)
      : engine_(engine)
  {
    audioCallApiMethodCallHandler_ = std::make_unique<RtcDeviceManagerAudioCallApiMethodCallHandler>(engine_);
    videoCallApiMethodCallHandler_ = std::make_unique<RtcDeviceManagerVideoCallApiMethodCallHandler>(engine_);
  }

  AgoraRtcDeviceManagerPlugin::~AgoraRtcDeviceManagerPlugin() {}

  void AgoraRtcDeviceManagerPlugin::HandleMethodCall(
      const MethodCall<EncodableValue> &method_call,
      std::unique_ptr<MethodResult<EncodableValue>> result, bool audio)
  {
    auto method = method_call.method_name();
    if (!method_call.arguments())
    {
      result->Error("Bad Arguments", "Null arguments received");
      return;
    }

    if (audio)
    {
      audioCallApiMethodCallHandler_.get()->HandleMethodCall(method_call, std::move(result));
    }
    else
    {
      videoCallApiMethodCallHandler_.get()->HandleMethodCall(method_call, std::move(result));
    }
  }
} // namespace

void AgoraRtcDeviceManagerPluginRegisterWithRegistrar(
    PluginRegistrarWindows *registrar, IrisRtcEngine *engine)
{
  AgoraRtcDeviceManagerPlugin::RegisterWithRegistrar(registrar, engine);
}
