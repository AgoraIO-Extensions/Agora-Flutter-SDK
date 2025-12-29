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
    dict["renderFrameIntervalMs"] = renderFrameIntervalMs;
    dict["renderDrawCostMs"] = renderDrawCostMs;
    dict["totalFramesReceived"] = static_cast<double>(totalFramesReceived);
    dict["totalFramesRendered"] = static_cast<double>(totalFramesRendered);
    return dict;
}

AgoraRenderPerformanceMonitor::AgoraRenderPerformanceMonitor()
    : delegate_(nullptr),
      enabled_(true),
      reportIntervalMs_(6000),
      totalFramesReceived_(0),
      totalFramesRendered_(0) {
    frameReceiveTimestamps_.reserve(MAX_SAMPLE_SIZE);
    frameRenderTimestamps_.reserve(MAX_SAMPLE_SIZE);
    frameIntervalSamples_.reserve(MAX_SAMPLE_SIZE);
    renderDrawCostSamples_.reserve(MAX_SAMPLE_SIZE);
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

void AgoraRenderPerformanceMonitor::recordFrameReceived() {
    if (!enabled_) return;

    int64_t nowMs = currentTimeMs();

    std::lock_guard<std::mutex> lock(mutex_);
    frameReceiveTimestamps_.push_back(nowMs);
    if (frameReceiveTimestamps_.size() > MAX_SAMPLE_SIZE) {
        frameReceiveTimestamps_.erase(frameReceiveTimestamps_.begin());
    }
    totalFramesReceived_++;

    checkAndReportStats();
}

void AgoraRenderPerformanceMonitor::recordFrameRenderedInterval() {
    if (!enabled_) return;

    int64_t nowMs = currentTimeMs();

    std::lock_guard<std::mutex> lock(mutex_);
    frameRenderTimestamps_.push_back(nowMs);
    if (frameRenderTimestamps_.size() > MAX_SAMPLE_SIZE) {
        frameRenderTimestamps_.erase(frameRenderTimestamps_.begin());
    }

    // Calculate frame interval (time between consecutive rendered frames)
    if (frameRenderTimestamps_.size() >= 2) {
        size_t size = frameRenderTimestamps_.size();
        int64_t intervalMs = frameRenderTimestamps_[size - 1] - frameRenderTimestamps_[size - 2];
        frameIntervalSamples_.push_back(static_cast<double>(intervalMs));
        if (frameIntervalSamples_.size() > MAX_SAMPLE_SIZE) {
            frameIntervalSamples_.erase(frameIntervalSamples_.begin());
        }
    }

    totalFramesRendered_++;

    checkAndReportStats();
}

void AgoraRenderPerformanceMonitor::recordRenderDrawCostWithValue(double drawCostMs) {
    if (!enabled_) return;

    std::lock_guard<std::mutex> lock(mutex_);
    renderDrawCostSamples_.push_back(drawCostMs);
    if (renderDrawCostSamples_.size() > MAX_SAMPLE_SIZE) {
        renderDrawCostSamples_.erase(renderDrawCostSamples_.begin());
    }
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
    stats.renderFrameIntervalMs = calculateAverageFrameInterval();
    stats.renderDrawCostMs = calculateAverageRenderDrawCost();
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

double AgoraRenderPerformanceMonitor::calculateAverageFrameInterval() {
    if (frameIntervalSamples_.empty()) return 0.0;

    double sum = std::accumulate(frameIntervalSamples_.begin(), frameIntervalSamples_.end(), 0.0);
    return sum / frameIntervalSamples_.size();
}

double AgoraRenderPerformanceMonitor::calculateAverageRenderDrawCost() {
    if (renderDrawCostSamples_.empty()) return 0.0;

    double sum = std::accumulate(renderDrawCostSamples_.begin(), renderDrawCostSamples_.end(), 0.0);
    return sum / renderDrawCostSamples_.size();
}

void AgoraRenderPerformanceMonitor::reset() {
    std::lock_guard<std::mutex> lock(mutex_);
    frameReceiveTimestamps_.clear();
    frameRenderTimestamps_.clear();
    frameIntervalSamples_.clear();
    renderDrawCostSamples_.clear();
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

