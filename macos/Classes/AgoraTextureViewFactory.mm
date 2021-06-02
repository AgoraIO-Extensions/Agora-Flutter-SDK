#import "AgoraTextureViewFactory.h"
#import <AgoraRtcWrapper/iris_rtc_renderer.h>
#import <Foundation/Foundation.h>

using namespace agora::iris::rtc;

@interface TextureRenderer : NSObject <FlutterTexture>
@property(nonatomic, weak) NSObject<FlutterTextureRegistry> *textureRegistry;
@property(nonatomic, assign) int64_t textureId;
@property(nonatomic, strong) FlutterMethodChannel *channel;
@property(nonatomic) CVPixelBufferRef buffer;
@property(nonatomic) IrisRtcRenderer *renderer;

- (instancetype)
    initWithTextureRegistry:(NSObject<FlutterTextureRegistry> *)textureRegistry
                  messenger:(NSObject<FlutterBinaryMessenger> *)messenger
                   renderer:(IrisRtcRenderer *)renderer;

- (void)destroy;
@end

namespace {
class RendererDelegate : public IrisRtcRendererDelegate {
public:
  RendererDelegate(void *renderer) : renderer_(renderer) {}

  void OnVideoFrameReceived(const IrisRtcVideoFrame &video_frame,
                            unsigned int uid, const char *channel_id,
                            bool resize) override {
    @autoreleasepool {
      TextureRenderer *renderer = (__bridge TextureRenderer *)renderer_;
      CVPixelBufferRef buffer = NULL;
      NSDictionary *dic =
          [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithBool:YES],
                            kCVPixelBufferCGImageCompatibilityKey,
                            [NSNumber numberWithBool:YES],
                            kCVPixelBufferCGBitmapContextCompatibilityKey,
                            [NSNumber numberWithBool:YES],
                            kCVPixelBufferMetalCompatibilityKey, nil];
      CVPixelBufferCreate(kCFAllocatorDefault, video_frame.width,
                          video_frame.height, kCVPixelFormatType_32BGRA,
                          (__bridge CFDictionaryRef)dic, &buffer);

      CVPixelBufferLockBaseAddress(buffer, 0);
      void *copyBaseAddress = CVPixelBufferGetBaseAddress(buffer);
      memcpy(copyBaseAddress, video_frame.y_buffer,
             video_frame.y_buffer_length);
      CVPixelBufferUnlockBaseAddress(buffer, 0);

      CVPixelBufferRelease(renderer.buffer);
      renderer.buffer = buffer;
      CVBufferRetain(renderer.buffer);
      CVPixelBufferRelease(buffer);
      [renderer.textureRegistry textureFrameAvailable:renderer.textureId];
    }
  }

public:
  void *renderer_;
};
}

@interface TextureRenderer ()
@property(nonatomic) RendererDelegate *delegate;
@end

@implementation TextureRenderer
- (instancetype)
    initWithTextureRegistry:(NSObject<FlutterTextureRegistry> *)textureRegistry
                  messenger:(NSObject<FlutterBinaryMessenger> *)messenger
                   renderer:(IrisRtcRenderer *)renderer {
  self = [super init];
  if (self) {
    self.textureRegistry = textureRegistry;
    self.renderer = renderer;
    self.delegate = new ::RendererDelegate((__bridge void *)self);
    self.textureId = [self.textureRegistry registerTexture:self];
    self.channel = [FlutterMethodChannel
        methodChannelWithName:
            [NSString stringWithFormat:@"agora_rtc_engine/texture_render_%lld",
                                       self.textureId]
              binaryMessenger:messenger];
    __weak typeof(self) weakSelf = self;
    [self.channel setMethodCallHandler:^(FlutterMethodCall *_Nonnull call,
                                         FlutterResult _Nonnull result) {
      if (!weakSelf) {
        return;
      }
      if ([@"setData" isEqualToString:call.method]) {
        NSDictionary *data = call.arguments[@"data"];
        NSNumber *uid = data[@"uid"];
        NSString *channelId = data[@"channelId"];

        IrisRtcRendererCacheConfig config(kVideoFrameTypeBGRA,
                                          weakSelf.delegate);
        renderer->EnableVideoFrameCache(
            config, [uid unsignedIntValue],
            (channelId && (NSNull *)channelId != [NSNull null])
                ? [channelId UTF8String]
                : "");
      }
    }];
  }
  return self;
}

- (void)dealloc {
  [self destroy];
}

- (void)destroy {
  [self.channel setMethodCallHandler:nil];
  self.renderer->DisableVideoFrameCache(self.delegate);
  [self.textureRegistry unregisterTexture:self.textureId];
}

- (CVPixelBufferRef)copyPixelBuffer {
  return self.buffer;
}

- (void)onTextureUnregistered:(NSObject<FlutterTexture> *)texture {
}
@end

@interface AgoraTextureViewFactory ()
@property(nonatomic, weak) NSObject<FlutterTextureRegistry> *registrar;
@property(nonatomic, weak) NSObject<FlutterBinaryMessenger> *messenger;
@property(nonatomic, strong)
    NSMutableDictionary<NSNumber *, TextureRenderer *> *renderers;
@end

@implementation AgoraTextureViewFactory
- (instancetype)initWithRegistrar:
    (NSObject<FlutterPluginRegistrar> *)registrar {
  self = [super init];
  if (self) {
    self.registrar = [registrar textures];
    self.messenger = [registrar messenger];
    self.renderers = [NSMutableDictionary new];
  }
  return self;
}

- (int64_t)createTextureRenderer:(void *)renderer {
  TextureRenderer *texture = [[TextureRenderer alloc]
      initWithTextureRegistry:self.registrar
                    messenger:self.messenger
                     renderer:(IrisRtcRenderer *)renderer];
  int64_t textureId = [texture textureId];
  self.renderers[@(textureId)] = texture;
  return textureId;
}

- (BOOL)destroyTextureRenderer:(int64_t)textureId {
  TextureRenderer *texture = [self.renderers objectForKey:@(textureId)];
  if (texture != nil) {
    [texture destroy];
    [self.renderers removeObjectForKey:@(textureId)];
    return YES;
  }
  return NO;
}
@end
