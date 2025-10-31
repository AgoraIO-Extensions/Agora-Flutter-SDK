#import <Foundation/Foundation.h>

#ifndef AgoraRenderPerformanceMonitor_h
#define AgoraRenderPerformanceMonitor_h

NS_ASSUME_NONNULL_BEGIN

/// Video rendering performance statistics.
@interface AgoraRenderPerformanceStats : NSObject

/// User ID of the video stream (0 for local, non-zero for remote).
@property(nonatomic, assign) unsigned int uid;

/// Input frame rate (frames received from SDK per second).
@property(nonatomic, assign) double renderInputFps;

/// Output frame rate (frames actually rendered per second).
@property(nonatomic, assign) double renderOutputFps;

/// Render interval variance (measure of smoothness, lower is better).
@property(nonatomic, assign) double renderIntervalVariance;

/// Average rendering draw cost per frame in milliseconds.
@property(nonatomic, assign) double renderDrawCostMs;

/// Total number of frames received from SDK.
@property(nonatomic, assign) int64_t totalFramesReceived;

/// Total number of frames rendered.
@property(nonatomic, assign) int64_t totalFramesRendered;

/// Converts stats to dictionary for Flutter communication.
- (NSDictionary *)toDictionary;

@end

/// Delegate protocol for performance statistics callbacks.
@protocol AgoraRenderPerformanceDelegate <NSObject>
@optional
/// Called when performance statistics are updated.
- (void)onPerformanceStatsUpdated:(AgoraRenderPerformanceStats *)stats;
@end

/// Performance monitor for video rendering in Flutter Texture mode.
@interface AgoraRenderPerformanceMonitor : NSObject

/// Performance callback delegate.
@property(nonatomic, weak, nullable) id<AgoraRenderPerformanceDelegate> delegate;

/// Enable/disable performance monitoring (default: YES).
@property(nonatomic, assign) BOOL enabled;

/// Report interval in milliseconds (default: 1000).
@property(nonatomic, assign) int64_t reportIntervalMs;

/// Initialize the performance monitor.
- (instancetype)init;

/// Record a frame received event with timestamp in milliseconds.
- (void)recordFrameReceived:(int64_t)timestamp;

/// Record a frame rendered event with timestamp and draw cost in milliseconds.
- (void)recordFrameRendered:(int64_t)timestamp drawCost:(double)drawCost;

/// Get current performance statistics.
- (AgoraRenderPerformanceStats *)getCurrentStats;

/// Reset all statistics.
- (void)reset;

@end

NS_ASSUME_NONNULL_END

#endif /* AgoraRenderPerformanceMonitor_h */

