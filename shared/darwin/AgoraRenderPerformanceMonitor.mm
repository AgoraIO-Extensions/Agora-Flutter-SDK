#import "AgoraRenderPerformanceMonitor.h"
#import "AgoraUtils.h"

static const int kMaxSampleSize = 100;

#pragma mark - AgoraRenderPerformanceStats

@implementation AgoraRenderPerformanceStats

- (NSDictionary *)toDictionary {
  return @{
    @"uid": @(self.uid),
    @"renderInputFps": @(self.renderInputFps),
    @"renderOutputFps": @(self.renderOutputFps),
    @"renderIntervalVariance": @(self.renderIntervalVariance),
    @"renderDrawCostMs": @(self.renderDrawCostMs),
    @"totalFramesReceived": @(self.totalFramesReceived),
    @"totalFramesRendered": @(self.totalFramesRendered)
  };
}

- (NSString *)description {
  return [NSString stringWithFormat:
          @"<AgoraRenderPerformanceStats: InFPS=%.1f, OutFPS=%.1f, Cost=%.2fms, "
          @"Variance=%.2f, Received=%lld, Rendered=%lld>",
          self.renderInputFps, self.renderOutputFps, self.renderDrawCostMs,
          self.renderIntervalVariance, self.totalFramesReceived,
          self.totalFramesRendered];
}

@end

#pragma mark - AgoraRenderPerformanceMonitor

@interface AgoraRenderPerformanceMonitor ()

@property(nonatomic, strong) NSMutableArray<NSNumber *> *frameReceiveTimestamps;
@property(nonatomic, strong) NSMutableArray<NSNumber *> *frameRenderTimestamps;
@property(nonatomic, strong) NSMutableArray<NSNumber *> *drawCostSamples;
@property(nonatomic, assign) int64_t totalFramesReceived;
@property(nonatomic, assign) int64_t totalFramesRendered;
@property(nonatomic, assign) int64_t lastReportTime;
@property(nonatomic, strong) dispatch_queue_t syncQueue;

@end

@implementation AgoraRenderPerformanceMonitor

- (instancetype)init {
  self = [super init];
  if (self) {
    _frameReceiveTimestamps = [NSMutableArray arrayWithCapacity:kMaxSampleSize];
    _frameRenderTimestamps = [NSMutableArray arrayWithCapacity:kMaxSampleSize];
    _drawCostSamples = [NSMutableArray arrayWithCapacity:kMaxSampleSize];
    _totalFramesReceived = 0;
    _totalFramesRendered = 0;
    _lastReportTime = [self currentTimeMs];
    _enabled = YES;
    _reportIntervalMs = 1000;  // Report once per second
    _syncQueue = dispatch_queue_create("io.agora.flutter.perf_monitor", DISPATCH_QUEUE_SERIAL);
  }
  return self;
}

- (int64_t)currentTimeMs {
  return (int64_t)([[NSDate date] timeIntervalSince1970] * 1000);
}

- (void)recordFrameReceived:(int64_t)timestamp {
  if (!self.enabled) return;
  
  dispatch_async(self.syncQueue, ^{
    [self.frameReceiveTimestamps addObject:@(timestamp)];
    if (self.frameReceiveTimestamps.count > kMaxSampleSize) {
      [self.frameReceiveTimestamps removeObjectAtIndex:0];
    }
    self.totalFramesReceived++;
    
    [self checkAndReportStats];
  });
}

- (void)recordFrameRendered:(int64_t)timestamp drawCost:(double)drawCost {
  if (!self.enabled) return;
  
  dispatch_async(self.syncQueue, ^{
    [self.frameRenderTimestamps addObject:@(timestamp)];
    if (self.frameRenderTimestamps.count > kMaxSampleSize) {
      [self.frameRenderTimestamps removeObjectAtIndex:0];
    }
    
    [self.drawCostSamples addObject:@(drawCost)];
    if (self.drawCostSamples.count > kMaxSampleSize) {
      [self.drawCostSamples removeObjectAtIndex:0];
    }
    
    self.totalFramesRendered++;
    
    [self checkAndReportStats];
  });
}

- (void)checkAndReportStats {
  int64_t now = [self currentTimeMs];
  int64_t timeSinceLastReport = now - self.lastReportTime;
  
  if (timeSinceLastReport >= self.reportIntervalMs) {
    self.lastReportTime = now;
    
    AgoraRenderPerformanceStats *stats = [self computeStatsInternal];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onPerformanceStatsUpdated:)]) {
      dispatch_async(dispatch_get_main_queue(), ^{
        [self.delegate onPerformanceStatsUpdated:stats];
      });
    }
  }
}

- (AgoraRenderPerformanceStats *)getCurrentStats {
  __block AgoraRenderPerformanceStats *stats = nil;
  dispatch_sync(self.syncQueue, ^{
    stats = [self computeStatsInternal];
  });
  return stats;
}

- (AgoraRenderPerformanceStats *)computeStatsInternal {
  AgoraRenderPerformanceStats *stats = [[AgoraRenderPerformanceStats alloc] init];
  
  stats.renderInputFps = [self calculateFPS:self.frameReceiveTimestamps];
  stats.renderOutputFps = [self calculateFPS:self.frameRenderTimestamps];
  stats.renderIntervalVariance = [self calculateIntervalVariance:self.frameRenderTimestamps];
  stats.renderDrawCostMs = [self calculateAverageDrawCost];
  stats.totalFramesReceived = self.totalFramesReceived;
  stats.totalFramesRendered = self.totalFramesRendered;
  
  return stats;
}

- (double)calculateFPS:(NSArray<NSNumber *> *)timestamps {
  if (timestamps.count < 2) return 0.0;
  
  int64_t first = [timestamps.firstObject longLongValue];
  int64_t last = [timestamps.lastObject longLongValue];
  double durationSeconds = (last - first) / 1000.0;
  
  if (durationSeconds <= 0) return 0.0;
  
  return (timestamps.count - 1) / durationSeconds;
}

- (double)calculateIntervalVariance:(NSArray<NSNumber *> *)timestamps {
  if (timestamps.count < 2) return 0.0;
  
  // Calculate intervals between consecutive timestamps
  NSMutableArray<NSNumber *> *intervals = [NSMutableArray array];
  for (NSInteger i = 1; i < timestamps.count; i++) {
    int64_t interval = [timestamps[i] longLongValue] - [timestamps[i-1] longLongValue];
    [intervals addObject:@(interval)];
  }
  
  // Calculate mean interval
  double sum = 0;
  for (NSNumber *interval in intervals) {
    sum += [interval doubleValue];
  }
  double mean = sum / intervals.count;
  
  // Calculate variance: sum of squared differences from mean
  double varianceSum = 0;
  for (NSNumber *interval in intervals) {
    double diff = [interval doubleValue] - mean;
    varianceSum += diff * diff;
  }
  
  return varianceSum / intervals.count;
}

- (double)calculateAverageDrawCost {
  if (self.drawCostSamples.count == 0) return 0.0;
  
  double sum = 0;
  for (NSNumber *cost in self.drawCostSamples) {
    sum += [cost doubleValue];
  }
  
  return sum / self.drawCostSamples.count;
}

- (void)reset {
  dispatch_async(self.syncQueue, ^{
    [self.frameReceiveTimestamps removeAllObjects];
    [self.frameRenderTimestamps removeAllObjects];
    [self.drawCostSamples removeAllObjects];
    self.totalFramesReceived = 0;
    self.totalFramesRendered = 0;
    self.lastReportTime = [self currentTimeMs];
  });
}

- (void)dealloc {
  // Cleanup handled by ARC
}

@end

