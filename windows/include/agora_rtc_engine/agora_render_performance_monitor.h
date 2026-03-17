#ifndef AGORA_RENDER_PERFORMANCE_MONITOR_H_
#define AGORA_RENDER_PERFORMANCE_MONITOR_H_

#include <cstdint>
#include <functional>
#include <map>
#include <mutex>
#include <vector>

namespace agora {
namespace rtc {
namespace flutter {

/*
/// Video rendering performance statistics.
struct AgoraRenderPerformanceStats {
    /// User ID of the video stream (0 for local, non-zero for remote).
    unsigned int uid;

    /// Input frame rate (frames received from SDK per second).
    double renderInputFps;

    /// Output frame rate (frames actually rendered per second).
    double renderOutputFps;

    /// Average frame interval (time between consecutive frames) in milliseconds.
    double renderFrameIntervalMs;

    /// Average rendering draw cost per frame in milliseconds.
    double renderDrawCostMs;

    /// Total number of frames received from SDK.
    int64_t totalFramesReceived;

    /// Total number of frames rendered.
    int64_t totalFramesRendered;

    /// Converts stats to map for Flutter communication.
    std::map<std::string, double> toDictionary() const;
};
*/

/// Delegate interface for performance statistics callbacks.
class AgoraRenderPerformanceDelegate {
public:
    virtual ~AgoraRenderPerformanceDelegate() = default;
    
    /// Called when raw frame statistics are available (immediate reporting).
    virtual void onRawFrameStats(const std::map<std::string, double>& rawStats) = 0;
};

/// Performance monitor for video rendering in Flutter Texture mode.
class AgoraRenderPerformanceMonitor {
public:
    AgoraRenderPerformanceMonitor();
    ~AgoraRenderPerformanceMonitor();

    /// Set performance callback delegate.
    void setDelegate(AgoraRenderPerformanceDelegate* delegate);

    /// Enable/disable performance monitoring (default: true).
    void setEnabled(bool enabled);

    /// Record a frame received event.
    /// Internally captures the current timestamp.
    void recordFrameReceived();

    /// Record a frame rendered interval event.
    /// Calculates the interval from the last rendered frame.
    void recordFrameRenderedInterval();

    /// Record the render draw cost value in milliseconds.
    void recordRenderDrawCostWithValue(double drawCostMs);

    /*
    /// Get current performance statistics.
    AgoraRenderPerformanceStats getCurrentStats();

    /// Force report with callback for final stats during disposal.
    void forceReportWithCallback(std::function<void(const AgoraRenderPerformanceStats&)> callback);
    */

    /// Reset all statistics.
    void reset();

private:
    void reportRawFrameStats();
    int64_t currentTimeMs();

    AgoraRenderPerformanceDelegate* delegate_;
    bool enabled_;

    int64_t totalFramesReceived_;
    int64_t totalFramesRendered_;

    /// Timestamp of last frame notification to Flutter (in milliseconds)
    int64_t last_frame_notify_time_ms_ = 0;
    /// Last calculated frame interval for immediate reporting
    double last_frame_interval_ms_ = 0.0;
    /// Last calculated draw cost for immediate reporting
    double last_draw_cost_ms_ = 0.0;

    std::mutex mutex_;
};

} // namespace flutter
} // namespace rtc
} // namespace agora

#endif // AGORA_RENDER_PERFORMANCE_MONITOR_H_

