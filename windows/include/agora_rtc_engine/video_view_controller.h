#ifndef VIDEO_VIEW_CONTROLLER_H_
#define VIDEO_VIEW_CONTROLLER_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar.h>
#include <flutter/standard_method_codec.h>
#include <flutter/texture_registrar.h>
#include "texture_render.h"

#include <map>
#include <mutex>

class VideoViewController
{
private:
    flutter::BinaryMessenger *messenger_;
    flutter::TextureRegistrar *texture_registrar_;
    std::map<int64_t, std::unique_ptr<TextureRender>> renderers_;

    void HandleMethodCall(
        const flutter::MethodCall<flutter::EncodableValue> &method_call,
        std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);

    int64_t CreatePlatformRender();

    bool DestroyPlatformRender(int64_t platformRenderId);

    int64_t CreateTextureRender(
        const intptr_t &irisRtcRenderingHandle,
        unsigned int uid,
        const std::string &channelId,
        unsigned int videoSourceType, 
        unsigned int videoViewSetupMode);

    bool DestroyTextureRender(int64_t textureId);

    void Dispose();

public:
    VideoViewController(flutter::TextureRegistrar *texture_registrar, flutter::BinaryMessenger *messenger_);
    virtual ~VideoViewController();
};

#endif // VIDEO_VIEW_CONTROLLER_H_