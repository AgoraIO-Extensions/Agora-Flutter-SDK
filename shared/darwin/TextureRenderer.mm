#import "TextureRenderer.h"
#import "AgoraCVPixelBufferUtils.h"

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
        pre_height_(0), last_frame_time_ms_(0) {}

  void OnVideoFrameReceived(const void *videoFrame,
                            const IrisRtcVideoFrameConfig &config,
                            bool resize) override {
    // agora::iris::WriteIrisLog(agora::iris::LOG_LEVEL_INFO, "OnVideoFrameReceived: %d %d", config.uid, config.video_source_type);
    TextureRender *strongRenderer = renderer_;
    if (!strongRenderer) {
      return;
    }
   
    std::weak_ptr<RendererDelegate> self_weak = shared_from_this();

    agora::media::base::VideoFrame *vf =
        (agora::media::base::VideoFrame *)videoFrame;

    if (vf->width == 0 || vf->height == 0) {
      WriteIrisLogInternal(IrisLogLevel::levelInfo, "[TextureRender] OnVideoFrameReceived: width or height is 0");
      return;
    }

    if (vf->renderTimeMs < last_frame_time_ms_) {
      WriteIrisLogInternal(IrisLogLevel::levelInfo, "[TextureRender] OnVideoFrameReceived: frame dropped: current time %@ ms, last frame time %@ ms", @(vf->renderTimeMs), @(last_frame_time_ms_));
      return;
    }

    last_frame_time_ms_ = vf->renderTimeMs;

    CVPixelBufferRef _Nullable pixelBuffer =
        reinterpret_cast<CVPixelBufferRef>(vf->pixelBuffer);
    if (!pixelBuffer) {
      WriteIrisLogInternal(IrisLogLevel::levelInfo, "[TextureRender] OnVideoFrameReceived: pixel buffer is nil");
      return;
    }

    if (pre_width_ != vf->width || pre_height_ != vf->height) {
      WriteIrisLogInternal(IrisLogLevel::levelInfo, "[TextureRender] OnVideoFrameReceived: size changed: %d %d", vf->width, vf->height);
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
        WriteIrisLogInternal(IrisLogLevel::levelInfo, "[TextureRender] onSizeChanged callback: %d %d", temp_width, temp_height);
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
      // There has been a bug since RTC 4.4.0 that the pixel buffer ref count is
      // not updated correctly, which will cause the flutter engine copy the
      // wrong pixel buffer to the skia texture. So we need to copy the pixel
      // buffer directly to work around this issue for now, after the issue is
      // fixed, we can revert to the original code.
      strongRenderer.latestPixelBuffer =
          [AgoraCVPixelBufferUtils copyCVPixelBuffer:pixelBuffer];
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
  int64_t last_frame_time_ms_;
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
    WriteIrisLogInternal(IrisLogLevel::levelInfo, "[TextureRender] init method called");
    self.textureRegistry = textureRegistry;
    self.irisRtcRendering =
        (agora::iris::IrisRtcRendering *)irisRtcRenderingHandle;
    self.textureId = [self.textureRegistry registerTexture:self];
    WriteIrisLogInternal(IrisLogLevel::levelInfo, "[TextureRender] registered textureId: %lld", self.textureId);
    self.channel = [FlutterMethodChannel
        methodChannelWithName:
            [NSString stringWithFormat:@"agora_rtc_engine/texture_render_%lld",
                                       self.textureId]
              binaryMessenger:messenger];

    self.delegate = std::make_shared<::RendererDelegate>((__bridge void *)self);
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

  WriteIrisLogInternal(IrisLogLevel::levelInfo, "[TextureRender] updateData uid: %u, channelId: %s, sourceType: %d, mode: %d", config.uid, config.channelId, config.video_source_type, config.video_view_setup_mode);

  self.delegateId = self.irisRtcRendering->AddVideoFrameObserverDelegate(
      config, self.delegate.get());
  WriteIrisLogInternal(IrisLogLevel::levelInfo, "[TextureRender] AddVideoFrameObserverDelegate returned delegateId: %d", self.delegateId);
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
  // Too frequent to log every frame copy
  // agora::iris::WriteIrisLog(agora::iris::LOG_LEVEL_INFO, "[TextureRender] copyPixelBuffer %p", pixelBuffer);
  return pixelBuffer;
}

- (void)dispose {
  WriteIrisLogInternal(IrisLogLevel::levelInfo, "[TextureRender] dispose method called");
  if (self.irisRtcRendering) {
    WriteIrisLogInternal(IrisLogLevel::levelInfo, "[TextureRender] removing delegateId: %d", self.delegateId);
    self.irisRtcRendering->RemoveVideoFrameObserverDelegate(self.delegateId);
    self.irisRtcRendering = nil;
  }
  if (self.delegate) {
    self.delegate.reset();
  }
  if (self.textureRegistry) {
    WriteIrisLogInternal(IrisLogLevel::levelInfo, "[TextureRender] unregisterTexture: %lld", self.textureId);
    [self.textureRegistry unregisterTexture:self.textureId];
    self.textureRegistry = nil;
  }
}

- (void)dealloc {
  WriteIrisLogInternal(IrisLogLevel::levelInfo, "[TextureRender] dealloc method called");
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
