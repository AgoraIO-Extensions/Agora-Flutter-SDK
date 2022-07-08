#include "include/agora_rtc_ng/video_view_controller.h"

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar.h>
#include <flutter/standard_method_codec.h>
#include <flutter/texture_registrar.h>
#include <map>
#include <mutex>

#include <iris_rtc_cxx_api.h>
#include "iris_rtc_raw_data.h"
#include "iris_video_processor_cxx.h"

VideoViewController::VideoViewController(
    flutter::TextureRegistrar *texture_registrar,
    flutter::BinaryMessenger *messenger) : texture_registrar_(texture_registrar),
                                           messenger_(messenger)
{
    auto channel =
        std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
            messenger_, "agora_rtc_ng/video_view_controller",
            &flutter::StandardMethodCodec::GetInstance());

    // auto plugin = std::make_unique<AgoraRtcFlutterPlugin>();
    videoFrameBufferManager_ = new agora::iris::IrisVideoFrameBufferManager;

    channel->SetMethodCallHandler([this](const auto &call, auto result)
                                  { this->HandleMethodCall(call, std::move(result)); });
}

VideoViewController::~VideoViewController()
{
    DeleteVideoFrameBufferManagerIfNeed();
}

void VideoViewController::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue> &method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result)
{
    auto method = method_call.method_name();
    // if (!method_call.arguments())
    // {
    //     result->Error("Bad Arguments", "Null arguments received");
    //     return;
    // }
    // if (method.compare("setData") == 0)
    // {
    //     auto arguments = std::get<flutter::EncodableMap>(*method_call.arguments());
    //     auto data = std::get<flutter::EncodableMap>(
    //         arguments[flutter::EncodableValue("data")]);
    //     unsigned int uid = 0;
    //     auto uid_int32 =
    //         std::get_if<int32_t>(&data[flutter::EncodableValue("uid")]);
    //     if (!uid_int32)
    //     {
    //         auto uid_int64 =
    //             std::get_if<int64_t>(&data[flutter::EncodableValue("uid")]);
    //         uid = (unsigned int)*uid_int64;
    //     }
    //     else
    //     {
    //         uid = (unsigned int)*uid_int32;
    //     }
    //     auto channel_id =
    //         std::get_if<std::string>(&data[flutter::EncodableValue("channelId")]);
    //     if (uid_ != uid)
    //     {
    //         renderer_->DisableVideoFrameBuffer(this);
    //     }
    //     uid_ = uid;
    //     if (channel_id)
    //     {
    //         channel_id_ = channel_id->c_str();
    //     }
    //     else
    //     {
    //         channel_id_ = "";
    //     }

    //     IrisVideoFrameBuffer buffer(kVideoFrameTypeRGBA, this);
    //     IrisVideoFrameBufferConfig config;

    //     config.id = uid_;
    //     if (config.id == 0)
    //     {
    //         config.type = IrisVideoSourceType::kVideoSourceTypeCameraPrimary;
    //     }
    //     else
    //     {
    //         config.type = IrisVideoSourceType::kVideoSourceTypeRemote;
    //     }
    //     if (!channel_id_.empty())
    //     {
    //         strcpy_s(config.key, channel_id_.c_str());
    //     }
    //     else
    //     {
    //         strcpy_s(config.key, "");
    //     }
    //     renderer_->EnableVideoFrameBuffer(buffer, &config);

    //     result->Success();
    // }
    // else
    if (method.compare("attachVideoFrameBufferManager") == 0)
    {
        intptr_t irisRtcEnginePtr = std::get<intptr_t>(*method_call.arguments());
        IrisApiEngine *irisApiEngine = reinterpret_cast<IrisApiEngine *>(irisRtcEnginePtr);
        irisApiEngine->Attach(videoFrameBufferManager_);
        result->Success(flutter::EncodableValue(true));
    }
    else if (method.compare("detachVideoFrameBufferManager") == 0)
    {
        intptr_t irisRtcEnginePtr = std::get<intptr_t>(*method_call.arguments());
        IrisApiEngine *irisApiEngine = reinterpret_cast<IrisApiEngine *>(irisRtcEnginePtr);
        irisApiEngine->Detach(videoFrameBufferManager_);

        // DeleteVideoFrameBufferManagerIfNeed();
        result->Success(flutter::EncodableValue(true));
    }
    else if (method.compare("createTextureRender") == 0)
    {
        auto arguments = std::get<flutter::EncodableMap>(*method_call.arguments());
        auto uidValue = arguments[flutter::EncodableValue("uid")];
        auto uid = uidValue.LongValue();
        auto &channelId = std::get<std::string>(arguments[flutter::EncodableValue("channelId")]);
        auto videoSourceType = std::get<int32_t>(arguments[flutter::EncodableValue("videoSourceType")]);

        auto textureId = CreateTextureRender(static_cast<unsigned int>(uid), channelId, videoSourceType);

        result->Success(flutter::EncodableValue(textureId));
    }
    else if (method.compare("destroyTextureRender") == 0)
    {
        int64_t textureId = std::get<int64_t>(*method_call.arguments());

        DestroyTextureRender(textureId);

        result->Success(flutter::EncodableValue(true));
    }
    else if (method.compare("updateTextureRenderData") == 0)
    {
    }
}

void VideoViewController::DeleteVideoFrameBufferManagerIfNeed()
{
    if (videoFrameBufferManager_)
    {
        delete videoFrameBufferManager_;
        videoFrameBufferManager_ = nullptr;
    }

    renderers_.clear();
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
    unsigned int uid,
    const std::string &channelId,
    unsigned int videoSourceType)
{
    std::unique_ptr<TextureRender> textureRender = std::make_unique<TextureRender>(
        messenger_,
        texture_registrar_,
        videoFrameBufferManager_);
    int64_t texture_id = textureRender->texture_id();

    textureRender.get()->UpdateData(uid, channelId, videoSourceType);

    renderers_[texture_id] = std::move(textureRender);
    return texture_id;
}

bool VideoViewController::DestroyTextureRender(int64_t textureId)
{
    auto it = renderers_.find(textureId);
    if (it != renderers_.end())
    {
        it->second.get()->Dispose();

        renderers_.erase(it);
        return true;
    }
    return false;
}