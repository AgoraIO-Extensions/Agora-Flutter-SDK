#ifndef TEXTURE_RENDER_H_
#define TEXTURE_RENDER_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar.h>
#include <flutter/standard_method_codec.h>
#include <flutter/texture_registrar.h>
#include <map>
#include <mutex>

#include "iris_rtc_raw_data.h"
#include "iris_video_processor_cxx.h"

class TextureRender : public agora::iris::IrisVideoFrameBufferDelegate
{
public:
    TextureRender(flutter::BinaryMessenger *messenger,
                  flutter::TextureRegistrar *registrar,
                  agora::iris::IrisVideoFrameBufferManager *videoFrameBufferManager);
    virtual ~TextureRender();

    int64_t texture_id();

    virtual void OnVideoFrameReceived(const IrisVideoFrame &video_frame,
                                      const IrisVideoFrameBufferConfig *config,
                                      bool resize) override;

    void UpdateData(unsigned int uid, const std::string &channelId, unsigned int videoSourceType);

    // Checks if texture registrar, texture id and texture are available.
    bool TextureRegistered()
    {
        return registrar_ && texture_ && texture_id_ > -1;
    }

private:
    const FlutterDesktopPixelBuffer *CopyPixelBuffer(size_t width, size_t height);

public:
    flutter::TextureRegistrar *registrar_;
    agora::iris::IrisVideoFrameBufferManager *videoFrameBufferManager_;
    std::unique_ptr<flutter::MethodChannel<flutter::EncodableValue>> method_channel_;

    int64_t texture_id_ = -1;

    uint32_t frame_width_ = 0;
    uint32_t frame_height_ = 0;

    std::mutex buffer_mutex_;
    std::vector<uint8_t> buffer_;
    std::unique_ptr<flutter::TextureVariant> texture_;
    std::unique_ptr<FlutterDesktopPixelBuffer> flutter_desktop_pixel_buffer_ =
        nullptr;
};

#endif // TEXTURE_RENDER_H_