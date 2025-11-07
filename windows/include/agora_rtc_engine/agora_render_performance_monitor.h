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

/// Video rendering performance statistics.
struct AgoraRenderPerformanceStats {
    /// User ID of the video stream (0 for local, non-zero for remote).
    unsigned int uid;

    /// Input frame rate (frames received from SDK per second).
    double renderInputFps;

    /// Output frame rate (frames actually rendered per second).
    double renderOutputFps;

    /// Render interval variance (measure of smoothness, lower is better).
    double renderIntervalVariance;

    /// Average rendering draw cost per frame in milliseconds.
    double renderDrawCostMs;

    /// Total number of frames received from SDK.
    int64_t totalFramesReceived;

    /// Total number of frames rendered.
    int64_t totalFramesRendered;

    /// Converts stats to map for Flutter communication.
    std::map<std::string, double> toDictionary() const;
};

/// Delegate interface for performance statistics callbacks.
class AgoraRenderPerformanceDelegate {
public:
    virtual ~AgoraRenderPerformanceDelegate() = default;
    
    /// Called when performance statistics are updated.
    virtual void onPerformanceStatsUpdated(const AgoraRenderPerformanceStats& stats) = 0;
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

    /// Set report interval in milliseconds (default: 1000).
    void setReportIntervalMs(int64_t intervalMs);

    /// Record a frame received event with timestamp in milliseconds.
    void recordFrameReceived(int64_t timestamp);

    /// Record a frame rendered event with timestamp and draw cost in milliseconds.
    void recordFrameRendered(int64_t timestamp, double drawCost);

    /// Get current performance statistics.
    AgoraRenderPerformanceStats getCurrentStats();

    /// Reset all statistics.
    void reset();

private:
    static const int MAX_SAMPLE_SIZE = 100;

    void checkAndReportStats();
    AgoraRenderPerformanceStats computeStatsInternal();
    double calculateFPS(const std::vector<int64_t>& timestamps);
    double calculateIntervalVariance(const std::vector<int64_t>& timestamps);
    double calculateAverageDrawCost();
    int64_t currentTimeMs();

    AgoraRenderPerformanceDelegate* delegate_;
    bool enabled_;
    int64_t reportIntervalMs_;

    std::vector<int64_t> frameReceiveTimestamps_;
    std::vector<int64_t> frameRenderTimestamps_;
    std::vector<double> drawCostSamples_;
    int64_t totalFramesReceived_;
    int64_t totalFramesRendered_;
    int64_t lastReportTime_;

    std::mutex mutex_;
};

} // namespace flutter
} // namespace rtc
} // namespace agora

#endif // AGORA_RENDER_PERFORMANCE_MONITOR_H_

