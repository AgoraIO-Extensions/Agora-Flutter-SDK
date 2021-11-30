#include "include/agora_rtc_engine/agora_rtc_channel_plugin.h"
#include "include/agora_rtc_engine/call_api_method_call_handler.h"

// This must be included before many other Windows headers.
#include <windows.h>

#include <flutter/event_channel.h>
#include <flutter/event_stream_handler_functions.h>
#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

namespace
{
  using namespace flutter;
  using namespace agora::iris;
  using namespace agora::iris::rtc;

  class RtcChannelCallApiMethodCallHandler : public CallApiMethodCallHandler
  {
  public:
    RtcChannelCallApiMethodCallHandler(agora::iris::rtc::IrisRtcEngine *engine);
    int32_t CallApi(int32_t api_type, const char *params, char *result) override;
    int32_t CallApi(int32_t api_type,
                    const char *params,
                    void *buffer,
                    char *result) override;
  };

  RtcChannelCallApiMethodCallHandler::RtcChannelCallApiMethodCallHandler(
      agora::iris::rtc::IrisRtcEngine *engine) : CallApiMethodCallHandler(engine) {}

  int32_t RtcChannelCallApiMethodCallHandler::CallApi(int32_t api_type, const char *params,
                                                      char *result)
  {
    return irisRtcEngine_->channel()->CallApi(
        static_cast<ApiTypeChannel>(api_type), params, result);
  }

  int32_t RtcChannelCallApiMethodCallHandler::CallApi(int32_t api_type,
                                                      const char *params,
                                                      void *buffer,
                                                      char *result)
  {
    return irisRtcEngine_->channel()->CallApi(static_cast<ApiTypeChannel>(api_type),
                                              params, buffer, result);
  }

  class AgoraRtcChannelPlugin : public Plugin, public IrisEventHandler
  {
  public:
    static void RegisterWithRegistrar(PluginRegistrarWindows *registrar,
                                      IrisRtcEngine *engine);

    AgoraRtcChannelPlugin(PluginRegistrar *registrar, IrisRtcEngine *engine);

    virtual ~AgoraRtcChannelPlugin();

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
    std::unique_ptr<CallApiMethodCallHandler> callApiMethodCallHandler_;
    IrisRtcEngine *engine_;
  };

  // static
  void AgoraRtcChannelPlugin::RegisterWithRegistrar(
      PluginRegistrarWindows *registrar, IrisRtcEngine *engine)
  {
    auto method_channel = std::make_unique<MethodChannel<EncodableValue>>(
        registrar->messenger(), "agora_rtc_channel",
        &StandardMethodCodec::GetInstance());
    auto event_channel = std::make_unique<EventChannel<EncodableValue>>(
        registrar->messenger(), "agora_rtc_channel/events",
        &StandardMethodCodec::GetInstance());

    auto plugin = std::make_unique<AgoraRtcChannelPlugin>(registrar, engine);

    method_channel->SetMethodCallHandler(
        [plugin_pointer = plugin.get()](const auto &call, auto result)
        {
          plugin_pointer->HandleMethodCall(call, std::move(result));
        });

    auto handler = std::make_unique<StreamHandlerFunctions<EncodableValue>>(
        [plugin_pointer =
             plugin.get()](const EncodableValue *arguments,
                           std::unique_ptr<EventSink<EncodableValue>> &&events)
            -> std::unique_ptr<StreamHandlerError<EncodableValue>>
        {
          plugin_pointer->event_sink_ = std::move(events);
          return nullptr;
        },
        [plugin_pointer = plugin.get()](const EncodableValue *arguments)
            -> std::unique_ptr<StreamHandlerError<EncodableValue>>
        {
          plugin_pointer->event_sink_ = nullptr;
          return nullptr;
        });
    event_channel->SetStreamHandler(std::move(handler));

    registrar->AddPlugin(std::move(plugin));
  }

  AgoraRtcChannelPlugin::AgoraRtcChannelPlugin(PluginRegistrar *registrar,
                                               IrisRtcEngine *engine)
      : engine_(engine)
  {
    engine_->channel()->SetEventHandler(this);
    callApiMethodCallHandler_ = std::make_unique<CallApiMethodCallHandler>(engine_);
  }

  AgoraRtcChannelPlugin::~AgoraRtcChannelPlugin() {}

  void AgoraRtcChannelPlugin::HandleMethodCall(
      const MethodCall<EncodableValue> &method_call,
      std::unique_ptr<MethodResult<EncodableValue>> result)
  {
    callApiMethodCallHandler_->HandleMethodCall(method_call, std::move(result));
    // auto method = method_call.method_name();
    // if (!method_call.arguments())
    // {
    //   result->Error("Bad Arguments", "Null arguments received");
    //   return;
    // }
    // if (method.compare("callApi") == 0)
    // {
    //   auto arguments = std::get<EncodableMap>(*method_call.arguments());
    //   auto api_type = std::get<int32_t>(arguments[EncodableValue("apiType")]);
    //   auto &params = std::get<std::string>(arguments[EncodableValue("params")]);
    //   char res[kMaxResultLength] = "";
    //   auto ret = engine_->channel()->CallApi(
    //       static_cast<ApiTypeChannel>(api_type), params.c_str(), res);

    //   if (ret == 0)
    //   {
    //     std::string res_str(res);
    //     if (res_str.empty())
    //     {
    //       result->Success();
    //     }
    //     else
    //     {
    //       result->Success(EncodableValue(res_str));
    //     }
    //   }
    //   else if (ret > 0)
    //   {
    //     result->Success(EncodableValue(ret));
    //   }
    //   else
    //   {
    //     result->Error(std::to_string(ret));
    //   }
    // }
    // else if (method.compare("callApiWithBuffer") == 0)
    // {
    //   auto arguments = std::get<EncodableMap>(*method_call.arguments());
    //   auto api_type = std::get<int32_t>(arguments[EncodableValue("apiType")]);
    //   auto &params = std::get<std::string>(arguments[EncodableValue("params")]);
    //   auto &buffer =
    //       std::get<std::vector<uint8_t>>(arguments[EncodableValue("buffer")]);
    //   char res[kMaxResultLength] = "";
    //   auto ret =
    //       engine_->channel()->CallApi(static_cast<ApiTypeChannel>(api_type),
    //                                   params.c_str(), buffer.data(), res);

    //   if (ret == 0)
    //   {
    //     std::string res_str(res);
    //     if (res_str.empty())
    //     {
    //       result->Success();
    //     }
    //     else
    //     {
    //       result->Success(EncodableValue(res_str));
    //     }
    //   }
    //   else if (ret > 0)
    //   {
    //     result->Success(EncodableValue(ret));
    //   }
    //   else
    //   {
    //     result->Error(std::to_string(ret));
    //   }
    // }
    // else
    // {
    //   result->NotImplemented();
    // }
  }

  void AgoraRtcChannelPlugin::OnEvent(const char *event, const char *data)
  {
    if (event_sink_)
    {
      EncodableMap ret = {{EncodableValue("methodName"), EncodableValue(event)},
                          {EncodableValue("data"), EncodableValue(data)}};
      event_sink_->Success(ret);
    }
  }

  void AgoraRtcChannelPlugin::OnEvent(const char *event, const char *data,
                                      const void *buffer, unsigned int length)
  {
    if (event_sink_)
    {
      std::vector<uint8_t> vector(length);
      if (buffer && length)
      {
        memcpy(&vector[0], buffer, length);
      }
      EncodableMap ret = {{EncodableValue("methodName"), EncodableValue(event)},
                          {EncodableValue("data"), EncodableValue(data)},
                          {EncodableValue("buffer"), EncodableValue(vector)}};
      event_sink_->Success(ret);
    }
  }
} // namespace

void AgoraRtcChannelPluginRegisterWithRegistrar(
    PluginRegistrarWindows *registrar, IrisRtcEngine *engine)
{
  AgoraRtcChannelPlugin::RegisterWithRegistrar(registrar, engine);
}
