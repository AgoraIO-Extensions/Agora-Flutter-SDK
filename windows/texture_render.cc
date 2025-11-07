#include "include/agora_rtc_engine/texture_render.h"

#include <chrono>
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

    // Initialize performance monitor
    performance_monitor_ = std::make_unique<agora::rtc::flutter::AgoraRenderPerformanceMonitor>();
    performance_monitor_->setDelegate(this);
}

TextureRender::~TextureRender()
{
}

int64_t TextureRender::texture_id() { return texture_id_; }

void TextureRender::OnVideoFrameReceived(const void *videoFrame,
                                         const IrisRtcVideoFrameConfig &config,
                                         bool resize)
{
    // Record frame received timestamp for performance monitoring
    int64_t receiveTimestamp = std::chrono::duration_cast<std::chrono::milliseconds>(
        std::chrono::system_clock::now().time_since_epoch()).count();
    if (performance_monitor_) {
        performance_monitor_->recordFrameReceived(receiveTimestamp);
    }

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

        // Record render timestamp before copying data to measure frame interval more accurately
        int64_t renderTimestamp = std::chrono::duration_cast<std::chrono::milliseconds>(
            std::chrono::system_clock::now().time_since_epoch()).count();
        
        // Record processing start time for draw cost measurement
        int64_t processStartTime = std::chrono::duration_cast<std::chrono::microseconds>(
            std::chrono::system_clock::now().time_since_epoch()).count();

        std::copy(static_cast<uint8_t *>(video_frame->yBuffer), static_cast<uint8_t *>(video_frame->yBuffer) + data_size, buffer_.data());

        // Record processing end time and calculate draw cost
        int64_t processEndTime = std::chrono::duration_cast<std::chrono::microseconds>(
            std::chrono::system_clock::now().time_since_epoch()).count();
        double drawCostMs = (processEndTime - processStartTime) / 1000.0;

        // Record frame rendered with timestamp and draw cost
        if (performance_monitor_) {
            performance_monitor_->recordFrameRendered(renderTimestamp, drawCostMs);
        }

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
    // Store uid for performance reporting
    uid_ = uid;

    IrisRtcVideoFrameConfig config;
    config.uid = uid;
    config.video_source_type = videoSourceType;
    config.video_frame_format = agora::media::base::VIDEO_PIXEL_FORMAT::VIDEO_PIXEL_RGBA;
    config.observed_frame_position = agora::media::base::VIDEO_MODULE_POSITION::POSITION_POST_CAPTURER | agora::media::base::VIDEO_MODULE_POSITION::POSITION_PRE_RENDERER;
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

    // Clean up performance monitor
    if (performance_monitor_) {
        performance_monitor_->setDelegate(nullptr);
        performance_monitor_.reset();
    }

    const std::lock_guard<std::mutex> lock(buffer_mutex_);

    if (registrar_ && texture_id_ != -1)
    {
        auto self = this;
        registrar_->UnregisterTexture(texture_id_, [self]()
                                      { delete self; });

        registrar_ = nullptr;
        texture_id_ = -1;
    }
}

void TextureRender::onPerformanceStatsUpdated(const agora::rtc::flutter::AgoraRenderPerformanceStats& stats)
{
    if (!method_channel_) {
        return;
    }

    // Send performance stats to Flutter layer via method channel
    flutter::EncodableMap statsMap;
    auto dict = stats.toDictionary();
    
    for (const auto& pair : dict) {
        statsMap[EncodableValue(pair.first)] = EncodableValue(pair.second);
    }
    
    statsMap[EncodableValue("textureId")] = EncodableValue(static_cast<int64_t>(texture_id_));
    statsMap[EncodableValue("uid")] = EncodableValue(static_cast<int64_t>(uid_));

    method_channel_->InvokeMethod("onVideoRenderingPerformance", 
                                   std::make_unique<EncodableValue>(EncodableValue(statsMap)));
}