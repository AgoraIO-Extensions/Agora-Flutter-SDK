#import <Foundation/Foundation.h>
#import "TextureRenderer.h"
#import <AgoraRtcWrapper/iris_video_processor_cxx.h>
#import <AgoraRtcWrapper/iris_rtc_raw_data.h>
#import <Foundation/Foundation.h>

using namespace agora::iris;
//using namespace agora::iris::rtc;

@interface TextureRender ()

@property(nonatomic, weak) NSObject<FlutterTextureRegistry> *textureRegistry;
@property(nonatomic, strong) FlutterMethodChannel *channel;
@property(nonatomic) CVPixelBufferRef buffer_cache;
@property(nonatomic) CVPixelBufferRef buffer_temp;
@property(nonatomic, strong) dispatch_semaphore_t lock;
@property(nonatomic) agora::iris::IrisVideoFrameBufferManager *videoFrameBufferManager;

@end

namespace {
class RendererDelegate : public IrisVideoFrameBufferDelegate {
public:
  RendererDelegate(void *renderer) : renderer_(renderer) {}

  void OnVideoFrameReceived(const IrisVideoFrame &video_frame,
                            const IrisVideoFrameBufferConfig *config,
                            bool resize) override {
    @autoreleasepool {
      TextureRender *renderer = (__bridge TextureRender *)renderer_;
      CVPixelBufferRef buffer = NULL;
      NSDictionary *dic = [NSDictionary
          dictionaryWithObjectsAndKeys:
               @(YES), kCVPixelBufferCGBitmapContextCompatibilityKey,
               @(YES), kCVPixelBufferCGImageCompatibilityKey,
               @(YES), kCVPixelBufferOpenGLCompatibilityKey,
               @(YES), kCVPixelBufferMetalCompatibilityKey, nil];

      NSDictionary *cvBufferProperties = @{
        (__bridge NSString *)kCVPixelBufferPixelFormatTypeKey: @(kCVPixelFormatType_32BGRA),
        (__bridge NSString *)kCVPixelBufferIOSurfacePropertiesKey: @{},
        (__bridge NSString *)kCVPixelBufferOpenGLCompatibilityKey: @YES,
        (__bridge NSString *)kCVPixelBufferMetalCompatibilityKey: @YES,
      };

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

@interface TextureRender ()

@property(nonatomic) RendererDelegate *delegate;

@end



@implementation TextureRender

- (instancetype) initWithTextureRegistry:(NSObject<FlutterTextureRegistry> *)textureRegistry
                               messenger:(NSObject<FlutterBinaryMessenger> *)messenger
                 videoFrameBufferManager:(void *)manager {
    self = [super init];
    if (self) {
      self.textureRegistry = textureRegistry;
        self.videoFrameBufferManager = (IrisVideoFrameBufferManager *)manager;
      self.textureId = [self.textureRegistry registerTexture:self];
      self.channel = [FlutterMethodChannel
          methodChannelWithName:
              [NSString stringWithFormat:@"agora_rtc_engine/texture_render_%lld",
                                         self.textureId]
                binaryMessenger:messenger];
//      self.renderer = renderer;
      self.lock = dispatch_semaphore_create(1);
      self.delegate = new ::RendererDelegate((__bridge void *)self);
//      __weak __typeof(self) weakSelf = self;
//      [self.channel setMethodCallHandler:^(FlutterMethodCall *_Nonnull call,
//                                           FlutterResult _Nonnull result) {
//        if (!weakSelf) {
//          return;
//        }
////        if ([@"setData" isEqualToString:call.method]) {
////          NSDictionary *data = call.arguments[@"data"];
////          NSNumber *uid = data[@"uid"];
////          NSString *channelId = data[@"channelId"];
////
////          IrisVideoFrameBuffer buffer(kVideoFrameTypeBGRA,
////                                            weakSelf.delegate);
////            IrisVideoFrameBufferConfig config;
////
////            config.id = [uid unsignedIntValue];
////            if (config.id == 0) {
////                config.type = IrisVideoSourceType::kVideoSourceTypeCameraPrimary;
////            } else {
////                config.type = IrisVideoSourceType::kVideoSourceTypeRemote;
////            }
////            if (channelId && (NSNull *)channelId != [NSNull null]) {
////                strcpy(config.key, [channelId UTF8String]);
////
////            } else {
////                strcpy(config.key, "");
////            }
//////            manager->EnableVideoFrameBuffer(buffer, &config);
////        }
//      }];
    }
    return self;
}

- (void)updateData:(NSNumber *)uid channelId:(NSString *)channelId videoSourceType:(NSNumber *)videoSourceType {
    IrisVideoFrameBuffer buffer(kVideoFrameTypeBGRA,
                                      self.delegate, 16);
      IrisVideoFrameBufferConfig config;
      
      config.id = [uid unsignedIntValue];
    config.type = (IrisVideoSourceType)[videoSourceType intValue];
    
//      if (config.id == 0) {
//          config.type = IrisVideoSourceType::kVideoSourceTypeCameraPrimary;
//      } else {
//          config.type = IrisVideoSourceType::kVideoSourceTypeRemote;
//      }
      if (channelId && (NSNull *)channelId != [NSNull null]) {
          strcpy(config.key, [channelId UTF8String]);
          
      } else {
          strcpy(config.key, "");
      }
    
    self.videoFrameBufferManager->EnableVideoFrameBuffer(buffer, &config);
}

- (void)dispose {
    self.videoFrameBufferManager->DisableVideoFrameBuffer(self.delegate);
    [self.textureRegistry unregisterTexture:self.textureId];
    if (self.buffer_cache) {
      CVPixelBufferRelease(self.buffer_cache);
    }
}

- (CVPixelBufferRef _Nullable)copyPixelBuffer {
    dispatch_semaphore_wait(self.lock, DISPATCH_TIME_FOREVER);
  //  CVPixelBufferRelease(self.buffer_temp);
    self.buffer_temp = self.buffer_cache;
    CVPixelBufferRetain(self.buffer_temp);
    dispatch_semaphore_signal(self.lock);
    return self.buffer_temp;
}

- (void)onTextureUnregistered:(NSObject<FlutterTexture> *)texture {
}

@end
    
