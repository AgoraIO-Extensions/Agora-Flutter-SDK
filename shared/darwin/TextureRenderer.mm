#import <Foundation/Foundation.h>
#import "TextureRenderer.h"
#import <AgoraRtcWrapper/iris_rtc_rendering_cxx.h>
#import <AgoraRtcKit/IAgoraMediaEngine.h>
#import <AgoraRtcKit/AgoraMediaBase.h>

#import <stdio.h>

using namespace agora::iris;

@interface TextureRender ()

@property(nonatomic, weak) NSObject<FlutterTextureRegistry> *textureRegistry;
@property(nonatomic, strong) FlutterMethodChannel *channel;
@property(nonatomic) CVPixelBufferRef buffer_cache;
@property(nonatomic, strong) dispatch_semaphore_t lock;
@property(nonatomic) agora::iris::IrisRtcRendering *irisRtcRendering;
@property(nonatomic, assign) int delegateId;
@property(nonatomic, assign) BOOL isDirtyBuffer;

@end

namespace {
class RendererDelegate : public agora::iris::VideoFrameObserverDelegate {
public:
  RendererDelegate(void *renderer) : renderer_(renderer) { }
    
  void OnVideoFrameReceived(const void *videoFrame,
                            const IrisRtcVideoFrameConfig &config, bool resize) override {
    @autoreleasepool {
        TextureRender *renderer = (__bridge TextureRender *)renderer_;
        
        agora::media::base::VideoFrame *vf = (agora::media::base::VideoFrame *)videoFrame;
        
        if (vf->width == 0 || vf->height == 0) {
            return;
        }
        
        CVPixelBufferRef _Nullable pixelBuffer = reinterpret_cast<CVPixelBufferRef>(vf->pixelBuffer);
        if (pixelBuffer) {
            if (resize) {
              int tmpWidth = vf->width;
              int tmpHeight = vf->height;
              dispatch_async(dispatch_get_main_queue(), ^{
                  [renderer.channel invokeMethod:@"onSizeChanged"
                                     arguments:@{@"width": @(tmpWidth),
                                                 @"height": @(tmpHeight)}];
              });
            }
            
            dispatch_semaphore_wait(renderer.lock, DISPATCH_TIME_FOREVER);
            if (!renderer.isDirtyBuffer) {
                // Ensure the previous retained `CVPixelBufferRef` be released.
                if (renderer.buffer_cache) {
                    CVBufferRelease(renderer.buffer_cache);
                }
                
                renderer.buffer_cache = CVPixelBufferRetain(pixelBuffer);
                renderer.isDirtyBuffer = YES;
            }
            dispatch_semaphore_signal(renderer.lock);
            
            if (renderer.isDirtyBuffer) {
                [renderer.textureRegistry textureFrameAvailable:renderer.textureId];
            }
        }
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
                  irisRtcRenderingHandle:(void *)irisRtcRenderingHandle {
    self = [super init];
    if (self) {
      self.textureRegistry = textureRegistry;
      self.irisRtcRendering = (agora::iris::IrisRtcRendering *)irisRtcRenderingHandle;
      self.textureId = [self.textureRegistry registerTexture:self];
      self.channel = [FlutterMethodChannel
          methodChannelWithName:
              [NSString stringWithFormat:@"agora_rtc_engine/texture_render_%lld",
                                         self.textureId]
                binaryMessenger:messenger];

      self.lock = dispatch_semaphore_create(1);
        
      self.delegate = new ::RendererDelegate((__bridge void *)self);
      self.buffer_cache = NULL;
      self.isDirtyBuffer = YES;
    }
    return self;
}

- (void)updateData:(NSNumber *)uid channelId:(NSString *)channelId videoSourceType:(NSNumber *)videoSourceType videoViewSetupMode:(NSNumber *)videoViewSetupMode {
    IrisRtcVideoFrameConfig config = EmptyIrisRtcVideoFrameConfig;
    config.video_frame_format = agora::media::base::VIDEO_PIXEL_FORMAT::VIDEO_CVPIXEL_NV12;
    config.uid = [uid unsignedIntValue];
    config.video_source_type = [videoSourceType intValue];
    if (channelId && (NSNull *)channelId != [NSNull null]) {
      strcpy(config.channelId, [channelId UTF8String]);
    } else {
      strcpy(config.channelId, "");
    }
    config.video_view_setup_mode = [videoViewSetupMode intValue];
    
    self.delegateId = self.irisRtcRendering->AddVideoFrameObserverDelegate(config, self.delegate);
}

- (void)dispose {
    self.irisRtcRendering->RemoveVideoFrameObserverDelegate(self.delegateId);
    if (self.delegate) {
        delete self.delegate;
        self.delegate = NULL;
    }
    [self.textureRegistry unregisterTexture:self.textureId];
    if (self.isDirtyBuffer) {
      CVPixelBufferRelease(self.buffer_cache);
      self.buffer_cache = NULL;
    }
}

- (CVPixelBufferRef _Nullable)copyPixelBuffer {
    dispatch_semaphore_wait(self.lock, DISPATCH_TIME_FOREVER);
    CVPixelBufferRef buffer_temp = CVPixelBufferRetain(self.buffer_cache);
    self.isDirtyBuffer = NO;
    dispatch_semaphore_signal(self.lock);
    
    return buffer_temp;
}

- (void)onTextureUnregistered:(NSObject<FlutterTexture> *)texture {
}

@end
    
