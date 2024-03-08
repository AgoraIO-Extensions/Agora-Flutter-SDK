#include "include/agora_rtc_engine/video_view_controller.h"

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar.h>
#include <flutter/standard_method_codec.h>
#include <flutter/texture_registrar.h>
#include <map>
#include <mutex>

#include <iris_rtc_c_api.h>

template <typename T>
static bool GetValueFromEncodableMap(const flutter::EncodableMap *map,
                                     const char *key, T &out)
{
  auto iter = map->find(flutter::EncodableValue(key));
  if (iter != map->end() && !iter->second.IsNull())
  {
    if (auto *value = std::get_if<T>(&iter->second))
    {
      out = *value;
      return true;
    }
  }
  return false;
}

VideoViewController::VideoViewController(
    flutter::TextureRegistrar *texture_registrar,
    flutter::BinaryMessenger *messenger) : texture_registrar_(texture_registrar),
                                           messenger_(messenger)
{
  auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          messenger_, "agora_rtc_ng/video_view_controller",
          &flutter::StandardMethodCodec::GetInstance());

  channel->SetMethodCallHandler([this](const auto &call, auto result)
                                { this->HandleMethodCall(call, std::move(result)); });
}

VideoViewController::~VideoViewController()
{
}

void VideoViewController::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue> &method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result)
{
  auto method = method_call.method_name();

  if (method.compare("createTextureRender") == 0)
  {
    const auto *arguments = std::get_if<flutter::EncodableMap>(method_call.arguments());
    if (!arguments)
    {
      result->Error("Invalid arguments", "Invalid argument type.");
      return;
    }

    int64_t irisRtcRenderingHandle;
    {
      auto iter = arguments->find(flutter::EncodableValue(flutter::EncodableValue("irisRtcRenderingHandle")));
      if (iter != arguments->end() && !iter->second.IsNull())
      {
        // The `irisRtcRenderingHandle` maybe in 32-bit on some devices, we need call `LongValue` explictly
        irisRtcRenderingHandle = iter->second.LongValue();
      }
      else
      {
        result->Error("Invalid arguments", "No irisRtcRenderingHandle provided.");
        return;
      }
    }

    int64_t uid;
    {
      auto iter = arguments->find(flutter::EncodableValue(flutter::EncodableValue("uid")));
      if (iter != arguments->end() && !iter->second.IsNull())
      {
        // The uid may between 32-bit and 64-bit value, we need call `LongValue` explictly
        uid = iter->second.LongValue();
      }
      else
      {
        result->Error("Invalid arguments", "No uid provided.");
        return;
      }
    }

    std::string channelId;
    if (!GetValueFromEncodableMap(arguments, "channelId", channelId))
    {
      result->Error("Invalid arguments", "No channelId provided.");
      return;
    }

    int32_t videoSourceType;
    if (!GetValueFromEncodableMap(arguments, "videoSourceType", videoSourceType))
    {
      result->Error("Invalid arguments", "No videoSourceType provided.");
      return;
    }

    int32_t videoViewSetupMode;
    if (!GetValueFromEncodableMap(arguments, "videoViewSetupMode", videoViewSetupMode))
    {
      result->Error("Invalid arguments", "No videoViewSetupMode provided.");
      return;
    }

    auto textureId = CreateTextureRender(irisRtcRenderingHandle, static_cast<unsigned int>(uid), channelId, videoSourceType, videoViewSetupMode);

    result->Success(flutter::EncodableValue(textureId));
  }
  else if (method.compare("destroyTextureRender") == 0)
  {
    const auto *textureId = std::get_if<int64_t>(method_call.arguments());
    if (!textureId)
    {
      result->Error("Invalid arguments", "No textureId provided.");
      return;
    }

    DestroyTextureRender(*textureId);

    result->Success(flutter::EncodableValue(true));
  }
  else if (method.compare("dispose") == 0)
  {
    Dispose();
    result->Success(flutter::EncodableValue(true));
  }
  else if (method.compare("updateTextureRenderData") == 0)
  {
  }
}

int64_t VideoViewController::CreatePlatformRender()
{
  return 0;
}

bool VideoViewController::DestroyPlatformRender(int64_t platformRenderId)
{
  return false;
}

int64_t VideoViewController::CreateTextureRender(
    const intptr_t &irisRtcRenderingHandle,
    unsigned int uid,
    const std::string &channelId,
    unsigned int videoSourceType,
    unsigned int videoViewSetupMode)
{
  agora::iris::IrisRtcRendering *iris_rtc_rendering = reinterpret_cast<agora::iris::IrisRtcRendering *>(irisRtcRenderingHandle);
  std::unique_ptr<TextureRender> textureRender = std::make_unique<TextureRender>(
      messenger_,
      texture_registrar_,
      iris_rtc_rendering);
  int64_t texture_id = textureRender->texture_id();

  textureRender.get()->UpdateData(uid, channelId, videoSourceType, videoViewSetupMode);

  renderers_[texture_id] = std::move(textureRender);
  return texture_id;
}

bool VideoViewController::DestroyTextureRender(int64_t textureId)
{
  auto it = renderers_.find(textureId);
  if (it != renderers_.end())
  {
    it->second->Dispose();
    renderers_.erase(it);
    return true;
  }
  return false;
}

void VideoViewController::Dispose()
{
  for (const auto &entry : renderers_)
  {
    entry.second->Dispose();
  }
  renderers_.clear();
}