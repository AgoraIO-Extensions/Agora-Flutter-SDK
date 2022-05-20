#import "AgoraTextureViewFactory.h"
#import <AgoraRtcWrapper/iris_rtc_raw_data.h>
#import <AgoraRtcWrapper/iris_video_processor.h>
#import <Foundation/Foundation.h>

using namespace agora::iris;
using namespace agora::iris::rtc;

@interface TextureRenderer : NSObject <FlutterTexture>
@property(nonatomic, weak) NSObject<FlutterTextureRegistry> *textureRegistry;
@property(nonatomic, assign) int64_t textureId;
@property(nonatomic, strong) FlutterMethodChannel *channel;
@property(nonatomic) CVPixelBufferRef buffer_cache;
@property(nonatomic) CVPixelBufferRef buffer_temp;
@property(nonatomic) IrisVideoFrameBufferManager *renderer;
@property(nonatomic, strong) dispatch_semaphore_t lock;

- (instancetype)
    initWithTextureRegistry:(NSObject<FlutterTextureRegistry> *)textureRegistry
                  messenger:(NSObject<FlutterBinaryMessenger> *)messenger
                   renderer:(IrisVideoFrameBufferManager *)renderer;

- (void)destroy;
@end

namespace {
class RendererDelegate : public IrisVideoFrameBufferDelegate {
public:
  RendererDelegate(void *renderer) : renderer_(renderer) {}

  void OnVideoFrameReceived(const IrisVideoFrame &video_frame,
                            const IrisVideoFrameBufferConfig *config,
                            bool resize) override {
    @autoreleasepool {
      TextureRenderer *renderer = (__bridge TextureRenderer *)renderer_;
      CVPixelBufferRef buffer = NULL;
      NSDictionary *dic = [NSDictionary
          dictionaryWithObjectsAndKeys:
              @(YES), kCVPixelBufferCGBitmapContextCompatibilityKey, @(YES),
              kCVPixelBufferCGImageCompatibilityKey, @(YES),
              kCVPixelBufferOpenGLCompatibilityKey, @(YES),
                           kCVPixelBufferMetalCompatibilityKey, nil];
      CVPixelBufferCreate(kCFAllocatorDefault, video_frame.width,
                          video_frame.height, kCVPixelFormatType_32BGRA,
                          (__bridge CFDictionaryRef)dic, &buffer);

      CVPixelBufferLockBaseAddress(buffer, 0);
      void *copyBaseAddress = CVPixelBufferGetBaseAddress(buffer);
      memcpy(copyBaseAddress, video_frame.y_buffer,
             video_frame.y_buffer_length);
      CVPixelBufferUnlockBaseAddress(buffer, 0);

      dispatch_semaphore_wait(renderer.lock, DISPATCH_TIME_FOREVER);
      if (renderer.buffer_cache) {
        CVPixelBufferRelease(renderer.buffer_cache);
      }
      renderer.buffer_cache = buffer;
      dispatch_semaphore_signal(renderer.lock);

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
                   renderer:(IrisVideoFrameBufferManager *)renderer {
  self = [super init];
  if (self) {
    self.textureRegistry = textureRegistry;
    self.textureId = [self.textureRegistry registerTexture:self];
    self.channel = [FlutterMethodChannel
        methodChannelWithName:
            [NSString stringWithFormat:@"agora_rtc_engine/texture_render_%lld",
                                       self.textureId]
              binaryMessenger:messenger];
    self.renderer = renderer;
    self.lock = dispatch_semaphore_create(1);
    self.delegate = new ::RendererDelegate((__bridge void *)self);
    __weak __typeof(self) weakSelf = self;
    [self.channel setMethodCallHandler:^(FlutterMethodCall *_Nonnull call,
                                         FlutterResult _Nonnull result) {
      if (!weakSelf) {
        return;
      }
      if ([@"setData" isEqualToString:call.method]) {
        NSDictionary *data = call.arguments[@"data"];
        NSNumber *uid = data[@"uid"];
        NSString *channelId = data[@"channelId"];

        IrisVideoFrameBuffer buffer(kVideoFrameTypeBGRA,
                                          weakSelf.delegate);
          IrisVideoFrameBufferConfig config;
          
          config.id = [uid unsignedIntValue];
          if (config.id == 0) {
              config.type = IrisVideoSourceType::kVideoSourceTypeCameraPrimary;
          } else {
              config.type = IrisVideoSourceType::kVideoSourceTypeRemote;
          }
          if (channelId && (NSNull *)channelId != [NSNull null]) {
              strcpy(config.key, [channelId UTF8String]);
              
          } else {
              strcpy(config.key, "");
          }
          renderer->EnableVideoFrameBuffer(buffer, &config);
      }
    }];
  }
  return self;
}

- (void)dealloc {
  [self destroy];
  if (self.buffer_cache) {
    CVPixelBufferRelease(self.buffer_cache);
  }
//  if (self.buffer_temp) {
//    CVPixelBufferRelease(self.buffer_temp);
//  }
}

- (void)destroy {
  self.renderer->DisableVideoFrameBuffer(self.delegate);
  [self.textureRegistry unregisterTexture:self.textureId];
}

- (CVPixelBufferRef)copyPixelBuffer {
  dispatch_semaphore_wait(self.lock, DISPATCH_TIME_FOREVER);
//  CVPixelBufferRelease(self.buffer_temp);
  self.buffer_temp = self.buffer_cache;
  CVPixelBufferRetain(self.buffer_temp);
  dispatch_semaphore_signal(self.lock);
  return self.buffer_temp;
//    return nil;
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
                     renderer:(IrisVideoFrameBufferManager *)renderer];
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
