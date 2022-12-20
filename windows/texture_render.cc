#include "include/agora_rtc_engine/texture_render.h"

#include <functional>

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
}

TextureRender::~TextureRender()
{
    Dispose();
}

int64_t TextureRender::texture_id() { return texture_id_; }

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