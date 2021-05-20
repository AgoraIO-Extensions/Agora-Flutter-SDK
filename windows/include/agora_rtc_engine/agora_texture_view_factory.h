#ifndef AGORA_TEXTURE_VIEW_FACTORY_H
#define AGORA_TEXTURE_VIEW_FACTORY_H

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar.h>
#include <flutter/standard_method_codec.h>
#include <flutter/texture_registrar.h>
#include <map>
#include <mutex>

#include "third_party/iris/include/iris_rtc_renderer.h"

class AgoraTextureViewFactory;

class TextureRenderer : public agora::iris::rtc::IrisRtcRendererDelegate {
public:
  TextureRenderer(AgoraTextureViewFactory *factory);
  ~TextureRenderer();

  int64_t texture_id();

  // 通过 IrisRendererDelegate 继承
  virtual void OnVideoFrameReceived(
      const agora::iris::rtc::IrisRtcVideoFrameObserver::VideoFrame
          &video_frame,
      bool resize) override;

private:
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);

  const FlutterDesktopPixelBuffer *CopyPixelBuffer(size_t width, size_t height);

public:
  AgoraTextureViewFactory *factory_;
  flutter::TextureVariant texture_;
  int64_t texture_id_;
  std::unique_ptr<flutter::MethodCall<flutter::EncodableValue>> channel_;
  unsigned int uid_;
  std::string channel_id_;
  std::mutex mutex_;
  FlutterDesktopPixelBuffer *pixel_buffer_;
};

class AgoraTextureViewFactory {
public:
  AgoraTextureViewFactory(flutter::PluginRegistrar *registrar,
                          agora::iris::rtc::IrisRtcRenderer *renderer);
  ~AgoraTextureViewFactory();

  flutter::BinaryMessenger *messenger();

  flutter::TextureRegistrar *registrar();

  agora::iris::rtc::IrisRtcRenderer *renderer();

  int64_t CreateTextureRenderer();

  bool DestoryTextureRenderer(int64_t texture_id);

private:
  flutter::BinaryMessenger *messenger_;
  flutter::TextureRegistrar *registrar_;
  agora::iris::rtc::IrisRtcRenderer *renderer_;
  std::map<int64_t, std::unique_ptr<TextureRenderer>> renderers_;
};

#endif // AGORA_TEXTURE_VIEW_FACTORY_H
