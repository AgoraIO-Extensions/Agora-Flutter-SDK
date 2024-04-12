#include "include/agora_rtc_engine/texture_render.h"

#include <functional>

#include "AgoraMediaBase.h"

using namespace flutter;

TextureRender::TextureRender(flutter::BinaryMessenger *messenger,
                             flutter::TextureRegistrar *registrar,
                             agora::iris::IrisRtcRendering *iris_rtc_rendering)
    : registrar_(registrar),
      iris_rtc_rendering_(iris_rtc_rendering),
      delegate_id_(agora::iris::INVALID_DELEGATE_ID),
      is_dirty_(false)
{
    // Create flutter desktop pixelbuffer texture;
    texture_ =
        std::make_unique<flutter::TextureVariant>(flutter::PixelBufferTexture(
            [this](size_t width,
                   size_t height) -> const FlutterDesktopPixelBuffer *
            {
                return this->CopyPixelBuffer(width, height);
            }));

    texture_id_ = registrar_->RegisterTexture(texture_.get());

    method_channel_ = std::make_unique<MethodChannel<EncodableValue>>(
        messenger,
        "agora_rtc_engine/texture_render_" + std::to_string(texture_id_),
        &flutter::StandardMethodCodec::GetInstance());
}

TextureRender::~TextureRender()
{
    Dispose();
}

int64_t TextureRender::texture_id() { return texture_id_; }

void TextureRender::OnVideoFrameReceived(const void *videoFrame,
                                         const IrisRtcVideoFrameConfig &config,
                                         bool resize)
{
    std::lock_guard<std::mutex> lock_guard(buffer_mutex_);

    if (!is_dirty_)
    {
        const agora::media::base::VideoFrame *video_frame = static_cast<const agora::media::base::VideoFrame *>(videoFrame);

        const uint32_t bytes_per_pixel = 4;
        const uint32_t pixels_total = video_frame->width * video_frame->height;
        const uint32_t data_size = pixels_total * bytes_per_pixel;

        if (buffer_.size() != data_size)
        {
            buffer_.resize(data_size);

            flutter::EncodableMap args = {
                {EncodableValue("width"), EncodableValue(video_frame->width)},
                {EncodableValue("height"), EncodableValue(video_frame->height)}};
            method_channel_->InvokeMethod("onSizeChanged", std::make_unique<EncodableValue>(EncodableValue(args)));
        }

        std::copy(static_cast<uint8_t *>(video_frame->yBuffer), static_cast<uint8_t *>(video_frame->yBuffer) + data_size, buffer_.data());

        frame_width_ = video_frame->width;
        frame_height_ = video_frame->height;

        is_dirty_ = true;
    }
    if (TextureRegistered() && is_dirty_)
    {
        registrar_->MarkTextureFrameAvailable(texture_id_);
    }
}

const FlutterDesktopPixelBuffer *
TextureRender::CopyPixelBuffer(size_t width, size_t height)
{
    std::unique_lock<std::mutex> buffer_lock(buffer_mutex_);

    is_dirty_ = false;

    if (!TextureRegistered())
    {
        return nullptr;
    }

    if (frame_width_ == 0 || frame_height_ == 0)
    {
        return nullptr;
    }

    if (!flutter_desktop_pixel_buffer_)
    {
        flutter_desktop_pixel_buffer_ =
            std::make_unique<FlutterDesktopPixelBuffer>();

        // Unlocks mutex after texture is processed.
        flutter_desktop_pixel_buffer_->release_callback =
            [](void *release_context)
        {
            auto mutex = reinterpret_cast<std::mutex *>(release_context);
            mutex->unlock();
        };
    }

    flutter_desktop_pixel_buffer_->buffer = buffer_.data();
    flutter_desktop_pixel_buffer_->width = frame_width_;
    flutter_desktop_pixel_buffer_->height = frame_height_;

    // Releases unique_lock and set mutex pointer for release context.
    flutter_desktop_pixel_buffer_->release_context = buffer_lock.release();

    return flutter_desktop_pixel_buffer_.get();
}

void TextureRender::UpdateData(unsigned int uid, const std::string &channelId, unsigned int videoSourceType, unsigned int videoViewSetupMode)
{
    IrisRtcVideoFrameConfig config = EmptyIrisRtcVideoFrameConfig;
    config.uid = uid;
    config.video_source_type = videoSourceType;
    config.video_frame_format = agora::media::base::VIDEO_PIXEL_FORMAT::VIDEO_PIXEL_RGBA;
    if (!channelId.empty())
    {
        strcpy_s(config.channelId, channelId.c_str());
    }
    else
    {
        strcpy_s(config.channelId, "");
    }
    config.video_view_setup_mode = videoViewSetupMode;

    if (iris_rtc_rendering_)
    {
        delegate_id_ = iris_rtc_rendering_->AddVideoFrameObserverDelegate(config, this);
    }
}

void TextureRender::Dispose()
{
    if (iris_rtc_rendering_)
    {
        iris_rtc_rendering_->RemoveVideoFrameObserverDelegate(delegate_id_);
        iris_rtc_rendering_ = nullptr;
    }

    const std::lock_guard<std::mutex> lock(buffer_mutex_);

    if (registrar_ && texture_id_ != -1)
    {
        registrar_->UnregisterTexture(texture_id_);

        registrar_ = nullptr;
        texture_id_ = -1;
    }
}