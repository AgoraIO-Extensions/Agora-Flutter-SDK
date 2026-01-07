#import "AgoraRenderPerformanceMonitor.h"
#import "AgoraUtils.h"

static const int kMaxSampleSize = 100;

//#pragma mark - AgoraRenderPerformanceStats
//
//@implementation AgoraRenderPerformanceStats
//
//- (NSDictionary *)toDictionary {
//    return @{
//        @"uid": @(self.uid),
//        @"renderInputFps": @(self.renderInputFps),
//        @"renderOutputFps": @(self.renderOutputFps),
//        @"renderFrameIntervalMs": @(self.renderFrameIntervalMs),
//        @"renderDrawCostMs": @(self.renderDrawCostMs),
//        @"totalFramesReceived": @(self.totalFramesReceived),
//        @"totalFramesRendered": @(self.totalFramesRendered)
//    };
//}
//
//- (NSString *)description {
//    return [NSString stringWithFormat:
//            @"<AgoraRenderPerformanceStats: InFPS=%.1f, OutFPS=%.1f, Interval=%.2fms, "
//            @"drawCost=%.2fms, Received=%lld, Rendered=%lld>",
//            self.renderInputFps, self.renderOutputFps, self.renderFrameIntervalMs,
//            self.renderDrawCostMs, self.totalFramesReceived,
//            self.totalFramesRendered];
//}
//
//@end

#pragma mark - AgoraRenderPerformanceMonitor

@interface AgoraRenderPerformanceMonitor ()

//@property(nonatomic, strong) NSMutableArray<NSNumber *> *frameReceiveTimestamps;
//@property(nonatomic, strong) NSMutableArray<NSNumber *> *frameRenderTimestamps;
//@property(nonatomic, strong) NSMutableArray<NSNumber *> *frameIntervalSamples;
//@property(nonatomic, strong) NSMutableArray<NSNumber *> *renderDrawCostSamples;
@property(nonatomic, assign) int64_t totalFramesReceived;
@property(nonatomic, assign) int64_t totalFramesRendered;
//@property(nonatomic, assign) int64_t lastReportTime;
@property(nonatomic, strong) dispatch_queue_t syncQueue;
/// Timestamp of last frame notification to Flutter (in microseconds)
@property(nonatomic, assign) int64_t lastFrameNotifyTimeMicros;
/// Timestamp of last frame received (in microseconds) for render duration calculation
@property(nonatomic, assign) int64_t lastFrameReceivedTimeMicros;
/// Last calculated frame interval for immediate reporting
@property(nonatomic, assign) double lastFrameIntervalMs;
/// Last calculated draw cost for immediate reporting
@property(nonatomic, assign) double lastDrawCostMs;



@end

@implementation AgoraRenderPerformanceMonitor

- (instancetype)init {
    self = [super init];
    if (self) {
//        _frameReceiveTimestamps = [NSMutableArray arrayWithCapacity:kMaxSampleSize];
//        _frameRenderTimestamps = [NSMutableArray arrayWithCapacity:kMaxSampleSize];
//        _frameIntervalSamples = [NSMutableArray arrayWithCapacity:kMaxSampleSize];
//        _renderDrawCostSamples = [NSMutableArray arrayWithCapacity:kMaxSampleSize];
        _totalFramesReceived = 0;
        _totalFramesRendered = 0;
//        _lastReportTime = [self currentTimeMs];
        _enabled = YES;
        self.lastFrameReceivedTimeMicros = 0;
        _syncQueue = dispatch_queue_create("io.agora.flutter.perf_monitor", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (int64_t)currentTimeMs {
    return (int64_t)([[NSDate date] timeIntervalSince1970] * 1000);
}

- (void)recordFrameReceived {
    if (!self.enabled) return;
    
    // Capture timestamps: milliseconds for FPS, microseconds for render duration
    int64_t timestampMs = (int64_t)([[NSDate date] timeIntervalSince1970] * 1000);
    int64_t timestampMicros = (int64_t)([[NSDate date] timeIntervalSince1970] * 1000000);
    
    // Save the microsecond timestamp for render duration calculation
    self.lastFrameReceivedTimeMicros = timestampMicros;
    
    dispatch_async(self.syncQueue, ^{
//        [self.frameReceiveTimestamps addObject:@(timestampMs)];
//        if (self.frameReceiveTimestamps.count > kMaxSampleSize) {
//            [self.frameReceiveTimestamps removeObjectAtIndex:0];
//        }
        self.totalFramesReceived++;
    });
}

- (void)recordFrameRenderedInterval {
    if (!self.enabled) return;
    // Calculate frame interval as the time between consecutive frame notifications
    int64_t nowMicros = (int64_t)([[NSDate date] timeIntervalSince1970] * 1000000);
    double frameIntervalMs = 0.0;
    
    if (self.lastFrameNotifyTimeMicros > 0) {
        int64_t intervalMicros = nowMicros - self.lastFrameNotifyTimeMicros;
        frameIntervalMs = intervalMicros / 1000.0;  // Convert to milliseconds
    }
    
    self.lastFrameNotifyTimeMicros = nowMicros;
    self.lastFrameIntervalMs = frameIntervalMs;
    
    int64_t renderTimestamp = (int64_t)([[NSDate date] timeIntervalSince1970] * 1000);
    dispatch_async(self.syncQueue, ^{
//        [self.frameRenderTimestamps addObject:@(renderTimestamp)];
//        if (self.frameRenderTimestamps.count > kMaxSampleSize) {
//            [self.frameRenderTimestamps removeObjectAtIndex:0];
//        }
//        // Record frame interval (skip first frame which has 0 interval)
//        if (frameIntervalMs > 0) {
//            [self.frameIntervalSamples addObject:@(frameIntervalMs)];
//            if (self.frameIntervalSamples.count > kMaxSampleSize) {
//                [self.frameIntervalSamples removeObjectAtIndex:0];
//            }
//        }
        self.totalFramesRendered++;
        
        // Immediately report raw frame stats
        [self reportRawFrameStats];
    });
}

- (void)recordRenderDrawCost {
    if (!self.enabled) return;
    
    // Calculate render duration: from last frame received to now
    int64_t nowMicros = (int64_t)([[NSDate date] timeIntervalSince1970] * 1000000);
    
    // Only calculate if we have a valid frame received timestamp
    if (self.lastFrameReceivedTimeMicros > 0) {
        double durationMs = (nowMicros - self.lastFrameReceivedTimeMicros) / 1000.0;
        self.lastDrawCostMs = durationMs;
        
//        dispatch_async(self.syncQueue, ^{
//            [self.renderDrawCostSamples addObject:@(durationMs)];
//            if (self.renderDrawCostSamples.count > kMaxSampleSize) {
//                [self.renderDrawCostSamples removeObjectAtIndex:0];
//            }
//        });
    }
}



//- (AgoraRenderPerformanceStats *)getCurrentStats {
//    __block AgoraRenderPerformanceStats *stats = nil;
//    dispatch_sync(self.syncQueue, ^{
//        stats = [self computeStatsInternal:NO];  // Don't reset
//    });
//    return stats;
//}
//
//- (void)forceReportWithCallback:(void (^)(AgoraRenderPerformanceStats *stats))callback {
//    dispatch_async(self.syncQueue, ^{
//        AgoraRenderPerformanceStats *stats = [self computeStatsAndReset];  // Reset for final report
//        if (stats == nil) {
//            return;
//        }
//        if (callback) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                callback(stats);
//            });
//        }
//    });
//}
//
//// Compute stats and reset counters (for periodic/final reports)
//- (AgoraRenderPerformanceStats *)computeStatsAndReset {
//    return [self computeStatsInternal:YES];
//}

//// Internal method to compute stats with optional reset
//- (AgoraRenderPerformanceStats *)computeStatsInternal:(BOOL)shouldReset {
//    // This runs on syncQueue, so no additional synchronization needed
//    
//    // For immediate reporting mode, we don't calculate FPS here
//    // FPS calculation will be done in Dart layer
//    AgoraRenderPerformanceStats *stats = [[AgoraRenderPerformanceStats alloc] init];
//    stats.renderInputFps = 0.0;  // Will be calculated in Dart layer
//    stats.renderOutputFps = 0.0;  // Will be calculated in Dart layer
//    stats.renderFrameIntervalMs = [self calculateAverage:self.frameIntervalSamples];
//    stats.renderDrawCostMs = [self calculateAverage:self.renderDrawCostSamples];
//    stats.totalFramesReceived = self.totalFramesReceived;
//    stats.totalFramesRendered = self.totalFramesRendered;
//    
//    return stats;
//}

//- (double)calculateFPS:(NSArray<NSNumber *> *)timestamps {
//  if (timestamps.count < 2) return 0.0;
//
//  int64_t now = [self currentTimeMs];
//  int64_t windowMs = self.reportIntervalMs;
//
//  NSMutableArray *recentTimestamps = [NSMutableArray array];
//  for (NSNumber *ts in [timestamps reverseObjectEnumerator]) {
//    int64_t timestamp = [ts longLongValue];
//    if (now - timestamp <= windowMs) {
//      [recentTimestamps insertObject:ts atIndex:0];
//    } else {
//      break;
//    }
//  }
//
//  if (recentTimestamps.count < 2) return 0.0;
//
//  int64_t first = [recentTimestamps.firstObject longLongValue];
//  int64_t last = [recentTimestamps.lastObject longLongValue];
//  double durationSeconds = (last - first) / 1000.0;
//
//  if (durationSeconds <= 0) return 0.0;
//
//  return (recentTimestamps.count - 1) / durationSeconds;
//}

//- (double)calculateIntervalVariance:(NSArray<NSNumber *> *)timestamps {
//  if (timestamps.count < 2) return 0.0;
//
//  // Calculate intervals between consecutive timestamps
//  NSMutableArray<NSNumber *> *intervals = [NSMutableArray array];
//  for (NSInteger i = 1; i < timestamps.count; i++) {
//    int64_t interval = [timestamps[i] longLongValue] - [timestamps[i-1] longLongValue];
//    [intervals addObject:@(interval)];
//  }
//
//  // Calculate mean interval
//  double sum = 0;
//  for (NSNumber *interval in intervals) {
//    sum += [interval doubleValue];
//  }
//  double mean = sum / intervals.count;
//
//  // Calculate variance: sum of squared differences from mean
//  double varianceSum = 0;
//  for (NSNumber *interval in intervals) {
//    double diff = [interval doubleValue] - mean;
//    varianceSum += diff * diff;
//  }
//
//  return varianceSum / intervals.count;
//}

//- (double)calculateAverage:(NSArray<NSNumber *> *)samples {
//    if (samples.count == 0) return 0.0;
//    
//    double sum = 0;
//    for (NSNumber *value in samples) {
//        sum += [value doubleValue];
//    }
//    
//    return sum / samples.count;
//}

- (void)reportRawFrameStats {
    // This method runs on syncQueue, so no additional synchronization needed
    NSDictionary *rawStats = @{
        @"renderFrameIntervalMs": @(self.lastFrameIntervalMs),
        @"renderDrawCostMs": @(self.lastDrawCostMs),
        @"totalFramesReceived": @(self.totalFramesReceived),
        @"totalFramesRendered": @(self.totalFramesRendered)
    };
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onRawFrameStats:)]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate onRawFrameStats:rawStats];
        });
    }
}

- (void)dealloc {
    // Cleanup handled by ARC
}

@end

