#include "include/agora_rtc_engine/agora_render_performance_monitor.h"

#include <chrono>
#include <cmath>
#include <numeric>
#include <thread>

namespace agora {
namespace rtc {
namespace flutter {

/*
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
*/

AgoraRenderPerformanceMonitor::AgoraRenderPerformanceMonitor()
    : delegate_(nullptr),
      enabled_(true),
      totalFramesReceived_(0),
      totalFramesRendered_(0) {
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

void AgoraRenderPerformanceMonitor::recordFrameReceived() {
    if (!enabled_) return;

    int64_t nowMs = currentTimeMs();

    std::lock_guard<std::mutex> lock(mutex_);
    totalFramesReceived_++;
}

void AgoraRenderPerformanceMonitor::recordFrameRenderedInterval() {
    if (!enabled_) return;

    int64_t nowMs = currentTimeMs();

    std::lock_guard<std::mutex> lock(mutex_);
    
    double frameIntervalMs = 0.0;
    if (last_frame_notify_time_ms_ > 0) {
        frameIntervalMs = static_cast<double>(nowMs - last_frame_notify_time_ms_);
    }
    last_frame_notify_time_ms_ = nowMs;
    last_frame_interval_ms_ = frameIntervalMs;
    
    totalFramesRendered_++;
    reportRawFrameStats();
}

void AgoraRenderPerformanceMonitor::recordRenderDrawCostWithValue(double drawCostMs) {
    if (!enabled_) return;

    std::lock_guard<std::mutex> lock(mutex_);
    last_draw_cost_ms_ = drawCostMs;
}

void AgoraRenderPerformanceMonitor::reportRawFrameStats() {
    std::map<std::string, double> rawStats;
    rawStats["renderFrameIntervalMs"] = last_frame_interval_ms_;
    rawStats["renderDrawCostMs"] = last_draw_cost_ms_;
    rawStats["totalFramesReceived"] = static_cast<double>(totalFramesReceived_);
    rawStats["totalFramesRendered"] = static_cast<double>(totalFramesRendered_);
    
    if (delegate_) {
        delegate_->onRawFrameStats(rawStats);
    }
}

void AgoraRenderPerformanceMonitor::reset() {
    std::lock_guard<std::mutex> lock(mutex_);
    totalFramesReceived_ = 0;
    totalFramesRendered_ = 0;
    last_frame_notify_time_ms_ = 0;
    last_frame_interval_ms_ = 0.0;
    last_draw_cost_ms_ = 0.0;
}

int64_t AgoraRenderPerformanceMonitor::currentTimeMs() {
    return std::chrono::duration_cast<std::chrono::milliseconds>(
        std::chrono::system_clock::now().time_since_epoch()).count();
}

} // namespace flutter
} // namespace rtc
} // namespace agora

