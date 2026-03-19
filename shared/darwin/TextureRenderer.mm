#import "TextureRenderer.h"
#import "AgoraCVPixelBufferUtils.h"
#import "TextureRenderLogger.h"

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

// Ring buffer to store recent renderTimeMs values for dump in STATS
static const int kRenderTimeBufSize = 64;

struct FrameStats {
  // --- OnVideoFrameReceived stats ---
  int64_t recv_count = 0;           // frames received in this window
  int64_t out_of_order_count = 0;   // renderTimeMs < previous
  int64_t stutter_count = 0;        // recv interval > 200ms
  int64_t burst_count = 0;          // recv interval < 5ms
  int64_t copy_fail_count = 0;      // copyCVPixelBuffer returned nil
  int64_t pixel_buffer_null = 0;    // vf->pixelBuffer was null

  double recv_min_interval_ms = 1e9;
  double recv_max_interval_ms = 0;
  double recv_sum_interval_ms = 0;

  int64_t first_render_time_ms = 0;
  int64_t last_render_time_ms = 0;

  // --- copyPixelBuffer stats (called by Flutter Engine raster thread) ---
  int64_t copy_pb_count = 0;        // total calls in this window
  int64_t copy_pb_nil_count = 0;    // returned nil (no frame ready)
  double copy_pb_min_interval_ms = 1e9;
  double copy_pb_max_interval_ms = 0;
  double copy_pb_sum_interval_ms = 0;

  // --- textureFrameAvailable stats ---
  int64_t notify_count = 0;         // times we notified Flutter Engine

  // --- renderTimeMs ring buffer (last N values for dump) ---
  int64_t render_time_buf[kRenderTimeBufSize] = {};
  int render_time_buf_pos = 0;
  int render_time_buf_count = 0;

  // Window timing
  uint64_t window_start_ns = 0;

  void reset(uint64_t now_ns) {
    recv_count = 0;
    out_of_order_count = 0;
    stutter_count = 0;
    burst_count = 0;
    copy_fail_count = 0;
    pixel_buffer_null = 0;
    recv_min_interval_ms = 1e9;
    recv_max_interval_ms = 0;
    recv_sum_interval_ms = 0;
    first_render_time_ms = 0;
    last_render_time_ms = 0;
    copy_pb_count = 0;
    copy_pb_nil_count = 0;
    copy_pb_min_interval_ms = 1e9;
    copy_pb_max_interval_ms = 0;
    copy_pb_sum_interval_ms = 0;
    notify_count = 0;
    render_time_buf_pos = 0;
    render_time_buf_count = 0;
    window_start_ns = now_ns;
  }

  void pushRenderTime(int64_t ms) {
    render_time_buf[render_time_buf_pos] = ms;
    render_time_buf_pos = (render_time_buf_pos + 1) % kRenderTimeBufSize;
    if (render_time_buf_count < kRenderTimeBufSize) render_time_buf_count++;
  }
};

class RendererDelegate : public std::enable_shared_from_this<RendererDelegate>,
                         public agora::iris::VideoFrameObserverDelegate {
public:
  RendererDelegate(void *renderer)
      : renderer_(((__bridge TextureRender *)renderer)), pre_width_(0),
        pre_height_(0), last_frame_time_ms_(0), total_recv_count_(0),
        last_recv_ns_(0), total_copy_pb_count_(0), total_copy_pb_nil_(0),
        last_copy_pb_ns_(0), total_notify_count_(0) {
    stats_.reset(clock_gettime_nsec_np(CLOCK_MONOTONIC));
  }

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

    uint64_t now_ns = clock_gettime_nsec_np(CLOCK_MONOTONIC);

    // --- out-of-order renderTimeMs ---
    if (vf->renderTimeMs < last_frame_time_ms_) {
      stats_.out_of_order_count++;
      [TextureRenderLogger log:@"TextureRender"
                       message:@"[%lld] WARN out_of_order: "
                               @"renderTimeMs=%lld, prev=%lld, "
                               @"delta=%lldms, total_recv=%lld",
                               strongRenderer.textureId, vf->renderTimeMs,
                               last_frame_time_ms_,
                               last_frame_time_ms_ - vf->renderTimeMs,
                               total_recv_count_];
      return;
    }

    // --- recv interval tracking ---
    if (last_recv_ns_ > 0) {
      double delta_ms = (double)(now_ns - last_recv_ns_) / 1e6;
      stats_.recv_sum_interval_ms += delta_ms;
      if (delta_ms < stats_.recv_min_interval_ms)
        stats_.recv_min_interval_ms = delta_ms;
      if (delta_ms > stats_.recv_max_interval_ms)
        stats_.recv_max_interval_ms = delta_ms;

      if (delta_ms > 200.0) {
        stats_.stutter_count++;
        [TextureRenderLogger
            log:@"TextureRender"
            message:@"[%lld] WARN recv_stutter: interval=%.1fms, "
                    @"renderTimeMs=%lld, total_recv=%lld",
                    strongRenderer.textureId, delta_ms, vf->renderTimeMs,
                    total_recv_count_];
      } else if (delta_ms < 5.0) {
        stats_.burst_count++;
        [TextureRenderLogger
            log:@"TextureRender"
            message:@"[%lld] WARN recv_burst: interval=%.1fms, "
                    @"renderTimeMs=%lld, total_recv=%lld",
                    strongRenderer.textureId, delta_ms, vf->renderTimeMs,
                    total_recv_count_];
      }
    }
    last_recv_ns_ = now_ns;

    last_frame_time_ms_ = vf->renderTimeMs;
    total_recv_count_++;
    stats_.recv_count++;
    stats_.pushRenderTime(vf->renderTimeMs);
    if (stats_.first_render_time_ms == 0) {
      stats_.first_render_time_ms = vf->renderTimeMs;
    }
    stats_.last_render_time_ms = vf->renderTimeMs;

    // --- periodic STATS dump: every 5 seconds ---
    double window_sec = (double)(now_ns - stats_.window_start_ns) / 1e9;
    if (window_sec >= 5.0 && stats_.recv_count > 0) {
      this->dumpStats(strongRenderer, window_sec);
      stats_.reset(now_ns);
    }

    CVPixelBufferRef _Nullable pixelBuffer =
        reinterpret_cast<CVPixelBufferRef>(vf->pixelBuffer);
    if (!pixelBuffer) {
      stats_.pixel_buffer_null++;
      [TextureRenderLogger
          log:@"TextureRender"
          message:@"[%lld] WARN pixel_buffer_null: "
                  @"renderTimeMs=%lld, total_recv=%lld",
                  strongRenderer.textureId, vf->renderTimeMs,
                  total_recv_count_];
      return;
    }

    if (pre_width_ != vf->width || pre_height_ != vf->height) {
      [TextureRenderLogger
          log:@"TextureRender"
          message:@"[%lld] size_changed: %dx%d -> %dx%d, "
                  @"renderTimeMs=%lld, total_recv=%lld",
                  strongRenderer.textureId,
                  pre_width_, pre_height_, vf->width, vf->height,
                  vf->renderTimeMs, total_recv_count_];

      pre_width_ = vf->width;
      pre_height_ = vf->height;

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
    dispatch_sync(strongRenderer.pixelBufferSynchronizationQueue, ^{
      previousPixelBuffer = strongRenderer.latestPixelBuffer;
      strongRenderer.latestPixelBuffer =
          [AgoraCVPixelBufferUtils copyCVPixelBuffer:pixelBuffer];

      if (!strongRenderer.latestPixelBuffer) {
        stats_.copy_fail_count++;
        [TextureRenderLogger
            log:@"TextureRender"
            message:@"[%lld] WARN copy_failed: "
                    @"copyCVPixelBuffer returned nil, "
                    @"renderTimeMs=%lld, total_recv=%lld",
                    strongRenderer.textureId, vf->renderTimeMs,
                    total_recv_count_];
      }
    });
    if (previousPixelBuffer) {
      CVPixelBufferRelease(previousPixelBuffer);
    }

    // notify Flutter Engine
    stats_.notify_count++;
    total_notify_count_++;
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

  void dumpStats(TextureRender *renderer, double windowSec) {
    double recv_avg = stats_.recv_count > 1
        ? stats_.recv_sum_interval_ms / (stats_.recv_count - 1) : 0;
    double recv_fps = stats_.recv_count / windowSec;

    double cpb_avg = stats_.copy_pb_count > 1
        ? stats_.copy_pb_sum_interval_ms / (stats_.copy_pb_count - 1) : 0;
    double cpb_fps = stats_.copy_pb_count / windowSec;

    // Build renderTimeMs sequence string (last N values)
    NSMutableString *rtSeq = [NSMutableString string];
    if (stats_.render_time_buf_count > 0) {
      int start = stats_.render_time_buf_count < kRenderTimeBufSize
          ? 0 : stats_.render_time_buf_pos;
      // Only dump last 16 to keep log line reasonable
      int dumpCount = stats_.render_time_buf_count > 16
          ? 16 : stats_.render_time_buf_count;
      int dumpStart = stats_.render_time_buf_count > 16
          ? (stats_.render_time_buf_pos - 16 + kRenderTimeBufSize) % kRenderTimeBufSize
          : start;
      for (int i = 0; i < dumpCount; i++) {
        int idx = (dumpStart + i) % kRenderTimeBufSize;
        if (i > 0) [rtSeq appendString:@","];
        [rtSeq appendFormat:@"%lld", stats_.render_time_buf[idx]];
      }
    }

    [TextureRenderLogger
        log:@"TextureRender"
        message:@"[%lld] STATS window=%.1fs | "
                @"recv: count=%lld fps=%.1f interval_ms(min/avg/max)=%.1f/%.1f/%.1f | "
                @"copyPixelBuffer: count=%lld fps=%.1f interval_ms(min/avg/max)=%.1f/%.1f/%.1f nil=%lld | "
                @"notify: count=%lld | "
                @"warn: ooo=%lld stutter=%lld burst=%lld copy_fail=%lld pb_null=%lld | "
                @"renderTimeMs: first=%lld last=%lld recent=[%@] | "
                @"totals: recv=%lld cpb=%lld cpb_nil=%lld notify=%lld",
                renderer.textureId, windowSec,
                // recv
                stats_.recv_count, recv_fps,
                stats_.recv_min_interval_ms, recv_avg, stats_.recv_max_interval_ms,
                // copyPixelBuffer
                stats_.copy_pb_count, cpb_fps,
                stats_.copy_pb_min_interval_ms, cpb_avg, stats_.copy_pb_max_interval_ms,
                stats_.copy_pb_nil_count,
                // notify
                stats_.notify_count,
                // warnings
                stats_.out_of_order_count, stats_.stutter_count,
                stats_.burst_count, stats_.copy_fail_count,
                stats_.pixel_buffer_null,
                // renderTimeMs
                stats_.first_render_time_ms, stats_.last_render_time_ms, rtSeq,
                // totals (lifetime)
                total_recv_count_, total_copy_pb_count_,
                total_copy_pb_nil_, total_notify_count_];
  }

  // Called from copyPixelBuffer (raster thread)
  void onCopyPixelBuffer(bool isNil) {
    uint64_t now_ns = clock_gettime_nsec_np(CLOCK_MONOTONIC);
    total_copy_pb_count_++;
    stats_.copy_pb_count++;

    if (last_copy_pb_ns_ > 0) {
      double delta_ms = (double)(now_ns - last_copy_pb_ns_) / 1e6;
      stats_.copy_pb_sum_interval_ms += delta_ms;
      if (delta_ms < stats_.copy_pb_min_interval_ms)
        stats_.copy_pb_min_interval_ms = delta_ms;
      if (delta_ms > stats_.copy_pb_max_interval_ms)
        stats_.copy_pb_max_interval_ms = delta_ms;
    }
    last_copy_pb_ns_ = now_ns;

    if (isNil) {
      total_copy_pb_nil_++;
      stats_.copy_pb_nil_count++;
    }
  }

public:
  __weak TextureRender *renderer_;
  int pre_width_;
  int pre_height_;
  int64_t last_frame_time_ms_;
  int64_t total_recv_count_;
  uint64_t last_recv_ns_;

  int64_t total_copy_pb_count_;
  int64_t total_copy_pb_nil_;
  uint64_t last_copy_pb_ns_;

  int64_t total_notify_count_;

  FrameStats stats_;
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

    self.delegate = std::make_shared<::RendererDelegate>((__bridge void *)self);
    self.latestPixelBuffer = nil;
    self.pixelBufferSynchronizationQueue = dispatch_queue_create(
        [[NSString stringWithFormat:@"io.agora.flutter.render_%lld", _textureId]
            UTF8String],
        nil);

    [TextureRenderLogger log:@"TextureRender"
                     message:@"[%lld] created", self.textureId];
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

  [TextureRenderLogger log:@"TextureRender"
                   message:@"[%lld] bindStream: uid=%u, channelId=%s, "
                           @"sourceType=%d, setupMode=%d",
                           self.textureId, config.uid, config.channelId,
                           config.video_source_type,
                           config.video_view_setup_mode];
}

- (CVPixelBufferRef _Nullable)copyPixelBuffer {
  __block CVPixelBufferRef pixelBuffer = nil;
  dispatch_sync(self.pixelBufferSynchronizationQueue, ^{
    if (self.latestPixelBuffer) {
      pixelBuffer = CVPixelBufferRetain(self.latestPixelBuffer);
    }
  });

  bool isNil = (pixelBuffer == nil);
  if (self.delegate) {
    self.delegate->onCopyPixelBuffer(isNil);
  }
  if (isNil) {
    [TextureRenderLogger log:@"TextureRender"
                     message:@"[%lld] WARN copyPixelBuffer_nil: "
                             @"engine requested frame but none available, "
                             @"total_cpb=%lld, total_nil=%lld",
                             self.textureId,
                             self.delegate ? self.delegate->total_copy_pb_count_ : 0,
                             self.delegate ? self.delegate->total_copy_pb_nil_ : 0];
  }
  return pixelBuffer;
}

- (void)dispose {
  [TextureRenderLogger log:@"TextureRender"
                   message:@"[%lld] dispose: total_recv=%lld, "
                           @"total_cpb=%lld, total_cpb_nil=%lld, "
                           @"total_notify=%lld",
                           self.textureId,
                           self.delegate ? self.delegate->total_recv_count_ : 0,
                           self.delegate ? self.delegate->total_copy_pb_count_ : 0,
                           self.delegate ? self.delegate->total_copy_pb_nil_ : 0,
                           self.delegate ? self.delegate->total_notify_count_ : 0];

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
