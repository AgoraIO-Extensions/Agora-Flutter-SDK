#include "include/agora_rtc_engine/agora_render_performance_monitor.h"

#include <chrono>
#include <cmath>
#include <numeric>

namespace agora {
namespace rtc {
namespace flutter {

std::map<std::string, double> AgoraRenderPerformanceStats::toDictionary() const {
    std::map<std::string, double> dict;
    dict["uid"] = static_cast<double>(uid);
    dict["renderInputFps"] = renderInputFps;
    dict["renderOutputFps"] = renderOutputFps;
    dict["renderIntervalVariance"] = renderIntervalVariance;
    dict["renderDrawCostMs"] = renderDrawCostMs;
    dict["totalFramesReceived"] = static_cast<double>(totalFramesReceived);
    dict["totalFramesRendered"] = static_cast<double>(totalFramesRendered);
    return dict;
}

AgoraRenderPerformanceMonitor::AgoraRenderPerformanceMonitor()
    : delegate_(nullptr),
      enabled_(true),
      reportIntervalMs_(1000),
      totalFramesReceived_(0),
      totalFramesRendered_(0) {
    frameReceiveTimestamps_.reserve(MAX_SAMPLE_SIZE);
    frameRenderTimestamps_.reserve(MAX_SAMPLE_SIZE);
    drawCostSamples_.reserve(MAX_SAMPLE_SIZE);
    lastReportTime_ = currentTimeMs();
}

AgoraRenderPerformanceMonitor::~AgoraRenderPerformanceMonitor() {
    delegate_ = nullptr;
}

void AgoraRenderPerformanceMonitor::setDelegate(AgoraRenderPerformanceDelegate* delegate) {
    std::lock_guard<std::mutex> lock(mutex_);
    delegate_ = delegate;
}

void AgoraRenderPerformanceMonitor::setEnabled(bool enabled) {
    std::lock_guard<std::mutex> lock(mutex_);
    enabled_ = enabled;
}

void AgoraRenderPerformanceMonitor::setReportIntervalMs(int64_t intervalMs) {
    std::lock_guard<std::mutex> lock(mutex_);
    reportIntervalMs_ = intervalMs;
}

void AgoraRenderPerformanceMonitor::recordFrameReceived(int64_t timestamp) {
    if (!enabled_) return;

    std::lock_guard<std::mutex> lock(mutex_);
    frameReceiveTimestamps_.push_back(timestamp);
    if (frameReceiveTimestamps_.size() > MAX_SAMPLE_SIZE) {
        frameReceiveTimestamps_.erase(frameReceiveTimestamps_.begin());
    }
    totalFramesReceived_++;

    checkAndReportStats();
}

void AgoraRenderPerformanceMonitor::recordFrameRendered(int64_t timestamp, double drawCost) {
    if (!enabled_) return;

    std::lock_guard<std::mutex> lock(mutex_);
    frameRenderTimestamps_.push_back(timestamp);
    if (frameRenderTimestamps_.size() > MAX_SAMPLE_SIZE) {
        frameRenderTimestamps_.erase(frameRenderTimestamps_.begin());
    }

    drawCostSamples_.push_back(drawCost);
    if (drawCostSamples_.size() > MAX_SAMPLE_SIZE) {
        drawCostSamples_.erase(drawCostSamples_.begin());
    }

    totalFramesRendered_++;

    checkAndReportStats();
}

void AgoraRenderPerformanceMonitor::checkAndReportStats() {
    int64_t now = currentTimeMs();
    int64_t timeSinceLastReport = now - lastReportTime_;

    if (timeSinceLastReport >= reportIntervalMs_) {
        lastReportTime_ = now;

        AgoraRenderPerformanceStats stats = computeStatsInternal();

        if (delegate_) {
            delegate_->onPerformanceStatsUpdated(stats);
        }
    }
}

AgoraRenderPerformanceStats AgoraRenderPerformanceMonitor::getCurrentStats() {
    std::lock_guard<std::mutex> lock(mutex_);
    return computeStatsInternal();
}

AgoraRenderPerformanceStats AgoraRenderPerformanceMonitor::computeStatsInternal() {
    AgoraRenderPerformanceStats stats;
    stats.uid = 0; // Will be set by caller
    stats.renderInputFps = calculateFPS(frameReceiveTimestamps_);
    stats.renderOutputFps = calculateFPS(frameRenderTimestamps_);
    stats.renderIntervalVariance = calculateIntervalVariance(frameRenderTimestamps_);
    stats.renderDrawCostMs = calculateAverageDrawCost();
    stats.totalFramesReceived = totalFramesReceived_;
    stats.totalFramesRendered = totalFramesRendered_;
    return stats;
}

double AgoraRenderPerformanceMonitor::calculateFPS(const std::vector<int64_t>& timestamps) {
    if (timestamps.size() < 2) return 0.0;

    int64_t first = timestamps.front();
    int64_t last = timestamps.back();
    double durationSeconds = (last - first) / 1000.0;

    if (durationSeconds <= 0) return 0.0;

    return (timestamps.size() - 1) / durationSeconds;
}

double AgoraRenderPerformanceMonitor::calculateIntervalVariance(const std::vector<int64_t>& timestamps) {
    if (timestamps.size() < 2) return 0.0;

    // Calculate intervals between consecutive timestamps
    std::vector<int64_t> intervals;
    intervals.reserve(timestamps.size() - 1);
    for (size_t i = 1; i < timestamps.size(); i++) {
        intervals.push_back(timestamps[i] - timestamps[i - 1]);
    }

    // Calculate mean interval
    double sum = std::accumulate(intervals.begin(), intervals.end(), 0.0);
    double mean = sum / intervals.size();

    // Calculate variance: sum of squared differences from mean
    double varianceSum = 0.0;
    for (int64_t interval : intervals) {
        double diff = interval - mean;
        varianceSum += diff * diff;
    }

    return varianceSum / intervals.size();
}

double AgoraRenderPerformanceMonitor::calculateAverageDrawCost() {
    if (drawCostSamples_.empty()) return 0.0;

    double sum = std::accumulate(drawCostSamples_.begin(), drawCostSamples_.end(), 0.0);
    return sum / drawCostSamples_.size();
}

void AgoraRenderPerformanceMonitor::reset() {
    std::lock_guard<std::mutex> lock(mutex_);
    frameReceiveTimestamps_.clear();
    frameRenderTimestamps_.clear();
    drawCostSamples_.clear();
    totalFramesReceived_ = 0;
    totalFramesRendered_ = 0;
    lastReportTime_ = currentTimeMs();
}

int64_t AgoraRenderPerformanceMonitor::currentTimeMs() {
    return std::chrono::duration_cast<std::chrono::milliseconds>(
        std::chrono::system_clock::now().time_since_epoch()).count();
}

} // namespace flutter
} // namespace rtc
} // namespace agora

