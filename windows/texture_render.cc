#include "include/agora_rtc_ng/texture_render.h"

#include <functional>

#include "iris_rtc_raw_data.h"
#include "iris_rtc_raw_data.h"
#include "iris_video_processor_cxx.h"

using namespace flutter;
using namespace agora::iris;
using namespace agora::iris::rtc;

TextureRender::TextureRender(flutter::BinaryMessenger *messenger,
                             flutter::TextureRegistrar *registrar,
                             agora::iris::IrisVideoFrameBufferManager *videoFrameBufferManager)
    : registrar_(registrar),
      videoFrameBufferManager_(videoFrameBufferManager),
      texture_(PixelBufferTexture(std::bind(&TextureRender::CopyPixelBuffer,
                                            this,
                                            std::placeholders::_1,
                                            std::placeholders::_2))),
      pixel_buffer_(new FlutterDesktopPixelBuffer{nullptr, 0, 0})
{
    texture_id_ = registrar_->RegisterTexture(&texture_);
    // auto channel = std::make_unique<MethodChannel<EncodableValue>>(
    //     messenger,
    //     "agora_rtc_engine/texture_render_" + std::to_string(texture_id_),
    //     &flutter::StandardMethodCodec::GetInstance());
    // channel->SetMethodCallHandler([this](const auto &call, auto result)
    //                               { this->HandleMethodCall(call, std::move(result)); });
}

TextureRender::~TextureRender()
{
    Dispose();
}

int64_t TextureRender::texture_id() { return texture_id_; }

// void TextureRender::HandleMethodCall(
//     const flutter::MethodCall<flutter::EncodableValue> &method_call,
//     std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result)
// {
//     auto method = method_call.method_name();
//     if (!method_call.arguments())
//     {
//         result->Error("Bad Arguments", "Null arguments received");
//         return;
//     }
//     if (method.compare("setData") == 0)
//     {
//         auto arguments = std::get<flutter::EncodableMap>(*method_call.arguments());
//         auto data = std::get<flutter::EncodableMap>(
//             arguments[flutter::EncodableValue("data")]);
//         unsigned int uid = 0;
//         auto uid_int32 =
//             std::get_if<int32_t>(&data[flutter::EncodableValue("uid")]);
//         if (!uid_int32)
//         {
//             auto uid_int64 =
//                 std::get_if<int64_t>(&data[flutter::EncodableValue("uid")]);
//             uid = (unsigned int)*uid_int64;
//         }
//         else
//         {
//             uid = (unsigned int)*uid_int32;
//         }
//         auto channel_id =
//             std::get_if<std::string>(&data[flutter::EncodableValue("channelId")]);
//         if (uid_ != uid)
//         {
//             renderer_->DisableVideoFrameBuffer(this);
//         }
//         uid_ = uid;
//         if (channel_id)
//         {
//             channel_id_ = channel_id->c_str();
//         }
//         else
//         {
//             channel_id_ = "";
//         }

//         IrisVideoFrameBuffer buffer(kVideoFrameTypeRGBA, this);
//         IrisVideoFrameBufferConfig config;

//         config.id = uid_;
//         if (config.id == 0)
//         {
//             config.type = IrisVideoSourceType::kVideoSourceTypeCameraPrimary;
//         }
//         else
//         {
//             config.type = IrisVideoSourceType::kVideoSourceTypeRemote;
//         }
//         if (!channel_id_.empty())
//         {
//             strcpy_s(config.key, channel_id_.c_str());
//         }
//         else
//         {
//             strcpy_s(config.key, "");
//         }
//         renderer_->EnableVideoFrameBuffer(buffer, &config);

//         result->Success();
//     }
//     else if (method.compare("setRenderMode") == 0)
//     {
//     }
//     else if (method.compare("setMirrorMode") == 0)
//     {
//     }
// }

void TextureRender::OnVideoFrameReceived(const IrisVideoFrame &video_frame,
                                         const IrisVideoFrameBufferConfig *config,
                                         bool resize)
{
    std::lock_guard<std::mutex> lock_guard(mutex_);
    if (pixel_buffer_->width != video_frame.width ||
        pixel_buffer_->height != video_frame.height)
    {
        if (pixel_buffer_->buffer)
        {
            delete[] pixel_buffer_->buffer;
        }
        pixel_buffer_->buffer = new uint8_t[video_frame.y_buffer_length];
    }
    memcpy((void *)pixel_buffer_->buffer, video_frame.y_buffer,
           video_frame.y_buffer_length);
    pixel_buffer_->width = video_frame.width;
    pixel_buffer_->height = video_frame.height;
    registrar_->MarkTextureFrameAvailable(texture_id_);
}

const FlutterDesktopPixelBuffer *
TextureRender::CopyPixelBuffer(size_t width, size_t height)
{
    std::lock_guard<std::mutex> lock_guard(mutex_);
    return pixel_buffer_;
}

void TextureRender::UpdateData(unsigned int uid, const std::string &channelId, unsigned int videoSourceType)
{
    IrisVideoFrameBuffer buffer(kVideoFrameTypeRGBA, this, 16);
    IrisVideoFrameBufferConfig config;

    config.id = uid;
    config.type = (IrisVideoSourceType)videoSourceType; //::kVideoSourceTypeCameraPrimary;
    // if (config.id == 0)
    // {
    //     config.type = IrisVideoSourceType::kVideoSourceTypeCameraPrimary;
    // }
    // else
    // {
    //     config.type = IrisVideoSourceType::kVideoSourceTypeRemote;
    // }
    if (!channelId.empty())
    {
        strcpy_s(config.key, channelId.c_str());
    }
    else
    {
        strcpy_s(config.key, "");
    }
    videoFrameBufferManager_->EnableVideoFrameBuffer(buffer, &config);
}

void TextureRender::Dispose()
{
    if (videoFrameBufferManager_)
    {
        videoFrameBufferManager_->DisableVideoFrameBuffer(this);
    }

    if (texture_id_ != -1)
    {
        registrar_->UnregisterTexture(texture_id_);
        texture_id_ = -1;
    }

    if (pixel_buffer_)
    {
        if (pixel_buffer_->buffer)
        {
            delete[] pixel_buffer_->buffer;
        }
        delete pixel_buffer_;
        pixel_buffer_ = nullptr;
    }
}