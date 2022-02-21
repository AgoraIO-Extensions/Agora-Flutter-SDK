#ifndef AGORA_TEXTURE_VIEW_FACTORY_H
#define AGORA_TEXTURE_VIEW_FACTORY_H

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar.h>
#include <flutter/standard_method_codec.h>
#include <flutter/texture_registrar.h>
#include <map>
#include <mutex>

#include "iris_rtc_raw_data.h"
#include "iris_video_processor.h"

class AgoraTextureViewFactory;

class TextureRenderer : public agora::iris::IrisVideoFrameBufferDelegate {
public:
  TextureRenderer(flutter::BinaryMessenger *messenger,
                  flutter::TextureRegistrar *registrar,
                  agora::iris::IrisVideoFrameBufferManager* renderer);
  ~TextureRenderer();

  int64_t texture_id();

  virtual void OnVideoFrameReceived(const IrisVideoFrame &video_frame,
                                    const IrisVideoFrameBufferConfig *config,
                                    bool resize) override;

private:
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);

  const FlutterDesktopPixelBuffer *CopyPixelBuffer(size_t width, size_t height);

public:
  flutter::TextureRegistrar *registrar_;
  agora::iris::IrisVideoFrameBufferManager* renderer_;
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
  AgoraTextureViewFactory(flutter::PluginRegistrar *registrar);
  ~AgoraTextureViewFactory();

  flutter::BinaryMessenger *messenger();

  flutter::TextureRegistrar *registrar();

  int64_t CreateTextureRenderer(agora::iris::IrisVideoFrameBufferManager *renderer);

  bool DestoryTextureRenderer(int64_t texture_id);

private:
  flutter::BinaryMessenger *messenger_;
  flutter::TextureRegistrar *registrar_;
  std::map<int64_t, std::unique_ptr<TextureRenderer>> renderers_;
};

#endif // AGORA_TEXTURE_VIEW_FACTORY_H
