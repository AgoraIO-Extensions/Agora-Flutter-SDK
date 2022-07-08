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

    virtual void OnVideoFrameReceived(const IrisVideoFrame& video_frame,
        const IrisVideoFrameBufferConfig* config,
        bool resize) override;

    void UpdateData(unsigned int uid, const std::string &channelId, unsigned int videoSourceType);

    void Dispose();

private:
    // void HandleMethodCall(
    //     const flutter::MethodCall<flutter::EncodableValue> &method_call,
    //     std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);

    const FlutterDesktopPixelBuffer *CopyPixelBuffer(size_t width, size_t height);

public:
    flutter::TextureRegistrar *registrar_;
    agora::iris::IrisVideoFrameBufferManager *videoFrameBufferManager_;
    flutter::TextureVariant texture_;
    int64_t texture_id_ = -1;
    // std::unique_ptr<flutter::MethodCall<flutter::EncodableValue>> channel_;
    // unsigned int uid_;
    // std::string channel_id_;
    std::mutex mutex_;
    FlutterDesktopPixelBuffer *pixel_buffer_;
};

#endif // TEXTURE_RENDER_H_