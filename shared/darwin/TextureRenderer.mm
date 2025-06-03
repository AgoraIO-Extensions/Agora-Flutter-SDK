#import "TextureRenderer.h"
#if defined(TARGET_OS_OSX) && TARGET_OS_OSX
#import "AgoraCVPixelBufferUtils.h"
#endif

#import <AgoraRtcKit/AgoraMediaBase.h>
#import <AgoraRtcKit/IAgoraMediaEngine.h>
#import <AgoraRtcWrapper/iris_rtc_rendering_cxx.h>
#import <Foundation/Foundation.h>

#import <memory.h>
#import <stdio.h>

using namespace agora::iris;

@interface TextureRender ()

@property(nonatomic, weak) NSObject<FlutterTextureRegistry> *textureRegistry;
@property(nonatomic, strong) FlutterMethodChannel *channel;
@property(nonatomic) agora::iris::IrisRtcRendering *irisRtcRendering;
@property(nonatomic, assign) int delegateId;

/// Tracks the latest pixel buffer sent from AVFoundation's sample buffer
/// delegate callback. Used to deliver the latest pixel buffer to the flutter
/// engine via the `copyPixelBuffer` API.
@property(readwrite, nonatomic) CVPixelBufferRef latestPixelBuffer;
/// The queue on which `latestPixelBuffer` property is accessed.
@property(strong, nonatomic) dispatch_queue_t pixelBufferSynchronizationQueue;

@end

namespace {
class RendererDelegate : public std::enable_shared_from_this<RendererDelegate>,
                         public agora::iris::VideoFrameObserverDelegate {
public:
  RendererDelegate(void *renderer)
      : renderer_(((__bridge TextureRender *)renderer)), pre_width_(0),
        pre_height_(0) {}

  void OnVideoFrameReceived(const void *videoFrame,
                            const IrisRtcVideoFrameConfig &config,
                            bool resize) override {
    TextureRender *strongRenderer = renderer_;
    if (!strongRenderer) {
      return;
    }

    std::weak_ptr<RendererDelegate> self_weak = shared_from_this();

    agora::media::base::VideoFrame *vf =
        (agora::media::base::VideoFrame *)videoFrame;

    if (vf->width == 0 || vf->height == 0) {
      return;
    }

    CVPixelBufferRef _Nullable pixelBuffer =
        reinterpret_cast<CVPixelBufferRef>(vf->pixelBuffer);
    if (!pixelBuffer) {
      return;
    }

    if (pre_width_ != vf->width || pre_height_ != vf->height) {
      pre_width_ = vf->width;
      pre_height_ = vf->height;

      // notify size changed on main thread, to avoid data race, we need to
      // copy the width and height to local variables.
      int temp_width = vf->width;
      int temp_height = vf->height;

      dispatch_async(dispatch_get_main_queue(), ^{
        std::shared_ptr<RendererDelegate> self_strong = self_weak.lock();
        if (!self_strong) {
          return;
        }

        TextureRender *strongRenderer = self_strong->renderer_;
        if (!strongRenderer) {
          return;
        }
        [strongRenderer.channel invokeMethod:@"onSizeChanged"
                                   arguments:@{
                                     @"width" : @(temp_width),
                                     @"height" : @(temp_height)
                                   }];
      });
    }

    __block CVPixelBufferRef previousPixelBuffer = nil;
    // Use `dispatch_sync` to avoid unnecessary context switch under common
    // non-contest scenarios;
    // Under rare contest scenarios, it will not block for too long since
    // the critical section is quite lightweight.
    //
    // Note: `dispatch_sync` will block the current thread, so we don't need
    // to check if the renderer is still valid before accessing its
    // properties.
    dispatch_sync(strongRenderer.pixelBufferSynchronizationQueue, ^{
      previousPixelBuffer = strongRenderer.latestPixelBuffer;
      // There has been a bug since RTC 4.4.0 that the pixel buffer ref count is not updated correctly,
      // which will cause the flutter engine copy the wrong pixel buffer to the skia texture.
      // So we need to copy the pixel buffer directly to work around this issue for now, after the issue is fixed,
      // we can revert to the original code.
#if defined(TARGET_OS_OSX) && TARGET_OS_OSX
      strongRenderer.latestPixelBuffer =
          [AgoraCVPixelBufferUtils copyCVPixelBuffer:pixelBuffer];
#else
      strongRenderer.latestPixelBuffer = CVPixelBufferRetain(pixelBuffer);
#endif
    });
    if (previousPixelBuffer) {
      CVPixelBufferRelease(previousPixelBuffer);
    }

    // notify new frame available on main thread
    dispatch_async(dispatch_get_main_queue(), ^{
      std::shared_ptr<RendererDelegate> self_strong = self_weak.lock();
      if (!self_strong) {
        return;
      }

      TextureRender *strongRenderer = self_strong->renderer_;
      if (!strongRenderer) {
        return;
      }
      [strongRenderer.textureRegistry
          textureFrameAvailable:strongRenderer.textureId];
    });
  }

public:
  __weak TextureRender *renderer_;
  int pre_width_;
  int pre_height_;
};
} // namespace

@interface TextureRender ()

@property(nonatomic) std::shared_ptr<RendererDelegate> delegate;

@end

@implementation TextureRender

- (instancetype)
    initWithTextureRegistry:(NSObject<FlutterTextureRegistry> *)textureRegistry
                  messenger:(NSObject<FlutterBinaryMessenger> *)messenger
     irisRtcRenderingHandle:(void *)irisRtcRenderingHandle {
  self = [super init];
  if (self) {
    self.textureRegistry = textureRegistry;
    self.irisRtcRendering =
        (agora::iris::IrisRtcRendering *)irisRtcRenderingHandle;
    self.textureId = [self.textureRegistry registerTexture:self];
    self.channel = [FlutterMethodChannel
        methodChannelWithName:
            [NSString stringWithFormat:@"agora_rtc_engine/texture_render_%lld",
                                       self.textureId]
              binaryMessenger:messenger];

    self.delegate = std::make_shared< ::RendererDelegate>((__bridge void *)self);
    self.latestPixelBuffer = nil;
    self.pixelBufferSynchronizationQueue = dispatch_queue_create(
        [[NSString stringWithFormat:@"io.agora.flutter.render_%lld", _textureId]
            UTF8String],
        nil);
  }
  return self;
}

- (void)updateData:(NSNumber *)uid
             channelId:(NSString *)channelId
       videoSourceType:(NSNumber *)videoSourceType
    videoViewSetupMode:(NSNumber *)videoViewSetupMode {
  IrisRtcVideoFrameConfig config;
  config.video_frame_format =
      agora::media::base::VIDEO_PIXEL_FORMAT::VIDEO_CVPIXEL_NV12;
  config.uid = [uid unsignedIntValue];
  config.video_source_type = [videoSourceType intValue];
  if (channelId && (NSNull *)channelId != [NSNull null]) {
    strcpy(config.channelId, [channelId UTF8String]);
  } else {
    strcpy(config.channelId, "");
  }
  config.video_view_setup_mode = [videoViewSetupMode intValue];
  config.observed_frame_position =
      agora::media::base::VIDEO_MODULE_POSITION::POSITION_POST_CAPTURER |
      agora::media::base::VIDEO_MODULE_POSITION::POSITION_PRE_RENDERER;

  self.delegateId = self.irisRtcRendering->AddVideoFrameObserverDelegate(
      config, self.delegate.get());
}

- (CVPixelBufferRef _Nullable)copyPixelBuffer {
  __block CVPixelBufferRef pixelBuffer = nil;
  // Use `dispatch_sync` because `copyPixelBuffer` API requires synchronous
  // return.
  dispatch_sync(self.pixelBufferSynchronizationQueue, ^{
    // No need weak self because it's dispatch_sync.
    pixelBuffer = self.latestPixelBuffer;
    self.latestPixelBuffer = nil;
  });
  return pixelBuffer;
}

- (void)dispose {
  if (self.irisRtcRendering) {
    self.irisRtcRendering->RemoveVideoFrameObserverDelegate(self.delegateId);
    self.irisRtcRendering = nil;
  }
  if (self.delegate) {
    self.delegate.reset();
  }
  if (self.textureRegistry) {
    [self.textureRegistry unregisterTexture:self.textureId];
    self.textureRegistry = nil;
  }
}

- (void)dealloc {
  if (self.irisRtcRendering) {
    // the delegateId is garenteed to be auto incremented, so we can just remove
    // the delegate by the id, no need to check if the delegate is still valid
    // or is belong to this TextureRender
    self.irisRtcRendering->RemoveVideoFrameObserverDelegate(self.delegateId);
    self.irisRtcRendering = nil;
  }

  dispatch_sync(self.pixelBufferSynchronizationQueue, ^{
    if (self.latestPixelBuffer) {
      CVPixelBufferRelease(self.latestPixelBuffer);
      self.latestPixelBuffer = nil;
    }
  });
}

@end
