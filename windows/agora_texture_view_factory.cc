#include "include/agora_rtc_engine/agora_texture_view_factory.h"

#include <functional>

#include "iris_rtc_raw_data.h"
#include "iris_rtc_raw_data.h"
#include "iris_video_processor.h"

using namespace flutter;
using namespace agora::iris;
using namespace agora::iris::rtc;

TextureRenderer::TextureRenderer(flutter::BinaryMessenger *messenger,
                                 flutter::TextureRegistrar *registrar,
                                 agora::iris::IrisVideoFrameBufferManager *renderer)
    : registrar_(registrar), renderer_(renderer),
      texture_(PixelBufferTexture(std::bind(&TextureRenderer::CopyPixelBuffer,
                                            this, std::placeholders::_1,
                                            std::placeholders::_2))),
      uid_(0), pixel_buffer_(new FlutterDesktopPixelBuffer{nullptr, 0, 0})
{
  texture_id_ = registrar_->RegisterTexture(&texture_);
  auto channel = std::make_unique<MethodChannel<EncodableValue>>(
      messenger,
      "agora_rtc_engine/texture_render_" + std::to_string(texture_id_),
      &flutter::StandardMethodCodec::GetInstance());
  channel->SetMethodCallHandler([this](const auto &call, auto result)
                                { this->HandleMethodCall(call, std::move(result)); });
}

TextureRenderer::~TextureRenderer()
{
  renderer_->DisableVideoFrameBuffer(this);
  registrar_->UnregisterTexture(texture_id_);
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

int64_t TextureRenderer::texture_id() { return texture_id_; }

void TextureRenderer::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue> &method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result)
{
  auto method = method_call.method_name();
  if (!method_call.arguments())
  {
    result->Error("Bad Arguments", "Null arguments received");
    return;
  }
  if (method.compare("setData") == 0)
  {
    auto arguments = std::get<flutter::EncodableMap>(*method_call.arguments());
    auto data = std::get<flutter::EncodableMap>(
        arguments[flutter::EncodableValue("data")]);
    unsigned int uid = 0;
    auto uid_int32 =
        std::get_if<int32_t>(&data[flutter::EncodableValue("uid")]);
    if (!uid_int32)
    {
      auto uid_int64 =
          std::get_if<int64_t>(&data[flutter::EncodableValue("uid")]);
      uid = (unsigned int)*uid_int64;
    }
    else
    {
      uid = (unsigned int)*uid_int32;
    }
    auto channel_id =
        std::get_if<std::string>(&data[flutter::EncodableValue("channelId")]);
    if (uid_ != uid)
    {
      renderer_->DisableVideoFrameBuffer(this);
    }
    uid_ = uid;
    if (channel_id)
    {
      channel_id_ = channel_id->c_str();
    }
    else
    {
      channel_id_ = "";
    }
    
    IrisVideoFrameBuffer buffer(kVideoFrameTypeRGBA, this);
    IrisVideoFrameBufferConfig config;

    config.id = uid_;
    if (config.id == 0)
    {
      config.type = IrisVideoSourceType::kVideoSourceTypeCameraPrimary;
    }
    else
    {
      config.type = IrisVideoSourceType::kVideoSourceTypeRemote;
    }
    if (!channel_id_.empty())
    {
      strcpy_s(config.key, channel_id_.c_str());
    }
    else
    {
      strcpy_s(config.key, "");
    }
    renderer_->EnableVideoFrameBuffer(buffer, &config);

    result->Success();
  }
  else if (method.compare("setRenderMode") == 0)
  {
  }
  else if (method.compare("setMirrorMode") == 0)
  {
  }
}

void TextureRenderer::OnVideoFrameReceived(const IrisVideoFrame &video_frame,
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
TextureRenderer::CopyPixelBuffer(size_t width, size_t height)
{
  std::lock_guard<std::mutex> lock_guard(mutex_);
  return pixel_buffer_;
}

AgoraTextureViewFactory::AgoraTextureViewFactory(PluginRegistrar *registrar)
    : messenger_(registrar->messenger()),
      registrar_(registrar->texture_registrar()) {}

AgoraTextureViewFactory::~AgoraTextureViewFactory() {}

int64_t
AgoraTextureViewFactory::CreateTextureRenderer(IrisVideoFrameBufferManager *renderer)
{
  std::unique_ptr<TextureRenderer> texture(
      new TextureRenderer(messenger_, registrar_, renderer));
  int64_t texture_id = texture->texture_id();
  renderers_[texture_id] = std::move(texture);
  return texture_id;
}

bool AgoraTextureViewFactory::DestoryTextureRenderer(int64_t texture_id)
{
  auto it = renderers_.find(texture_id);
  if (it != renderers_.end())
  {
    renderers_.erase(it);
    return true;
  }
  return false;
}
