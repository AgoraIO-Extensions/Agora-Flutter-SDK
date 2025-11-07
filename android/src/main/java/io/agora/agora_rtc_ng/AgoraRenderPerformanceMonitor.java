package io.agora.agora_rtc_ng;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Video rendering performance statistics.
 */
class AgoraRenderPerformanceStats {
    public long uid;
    public double renderInputFps;
    public double renderOutputFps;
    public double renderIntervalVariance;
    public double renderDrawCostMs;
    public long totalFramesReceived;
    public long totalFramesRendered;

    public Map<String, Object> toDictionary() {
        Map<String, Object> map = new HashMap<>();
        map.put("uid", uid);
        map.put("renderInputFps", renderInputFps);
        map.put("renderOutputFps", renderOutputFps);
        map.put("renderIntervalVariance", renderIntervalVariance);
        map.put("renderDrawCostMs", renderDrawCostMs);
        map.put("totalFramesReceived", totalFramesReceived);
        map.put("totalFramesRendered", totalFramesRendered);
        return map;
    }

    @Override
    public String toString() {
        return String.format(
            "AgoraRenderPerformanceStats: InFPS=%.1f, OutFPS=%.1f, Cost=%.2fms, " +
            "Variance=%.2f, Received=%d, Rendered=%d",
            renderInputFps, renderOutputFps, renderDrawCostMs,
            renderIntervalVariance, totalFramesReceived, totalFramesRendered
        );
    }
}

/**
 * Delegate interface for performance statistics callbacks.
 */
interface AgoraRenderPerformanceDelegate {
    void onPerformanceStatsUpdated(AgoraRenderPerformanceStats stats);
}

/**
 * Performance monitor for video rendering in Flutter Texture mode.
 */
public class AgoraRenderPerformanceMonitor {
    private static final int MAX_SAMPLE_SIZE = 100;

    private AgoraRenderPerformanceDelegate delegate;
    private boolean enabled = true;
    private long reportIntervalMs = 1000; // Report once per second

    private final List<Long> frameReceiveTimestamps = new ArrayList<>();
    private final List<Long> frameRenderTimestamps = new ArrayList<>();
    private final List<Double> drawCostSamples = new ArrayList<>();
    private long totalFramesReceived = 0;
    private long totalFramesRendered = 0;
    private long lastReportTime;

    private final Object lock = new Object();

    public AgoraRenderPerformanceMonitor() {
        this.lastReportTime = System.currentTimeMillis();
    }

    public void setDelegate(AgoraRenderPerformanceDelegate delegate) {
        synchronized (lock) {
            this.delegate = delegate;
        }
    }

    public void setEnabled(boolean enabled) {
        synchronized (lock) {
            this.enabled = enabled;
        }
    }

    public void setReportIntervalMs(long intervalMs) {
        synchronized (lock) {
            this.reportIntervalMs = intervalMs;
        }
    }

    /**
     * Record a frame received event with timestamp in milliseconds.
     */
    public void recordFrameReceived(long timestamp) {
        if (!enabled) return;

        synchronized (lock) {
            frameReceiveTimestamps.add(timestamp);
            if (frameReceiveTimestamps.size() > MAX_SAMPLE_SIZE) {
                frameReceiveTimestamps.remove(0);
            }
            totalFramesReceived++;

            checkAndReportStats();
        }
    }

    /**
     * Record a frame rendered event with timestamp and draw cost in milliseconds.
     */
    public void recordFrameRendered(long timestamp, double drawCost) {
        if (!enabled) return;

        synchronized (lock) {
            frameRenderTimestamps.add(timestamp);
            if (frameRenderTimestamps.size() > MAX_SAMPLE_SIZE) {
                frameRenderTimestamps.remove(0);
            }

            drawCostSamples.add(drawCost);
            if (drawCostSamples.size() > MAX_SAMPLE_SIZE) {
                drawCostSamples.remove(0);
            }

            totalFramesRendered++;

            checkAndReportStats();
        }
    }

    private void checkAndReportStats() {
        long now = System.currentTimeMillis();
        long timeSinceLastReport = now - lastReportTime;

        if (timeSinceLastReport >= reportIntervalMs) {
            lastReportTime = now;

            AgoraRenderPerformanceStats stats = computeStatsInternal();

            if (delegate != null) {
                delegate.onPerformanceStatsUpdated(stats);
            }
        }
    }

    /**
     * Get current performance statistics.
     */
    public AgoraRenderPerformanceStats getCurrentStats() {
        synchronized (lock) {
            return computeStatsInternal();
        }
    }

    private AgoraRenderPerformanceStats computeStatsInternal() {
        AgoraRenderPerformanceStats stats = new AgoraRenderPerformanceStats();

        stats.renderInputFps = calculateFPS(frameReceiveTimestamps);
        stats.renderOutputFps = calculateFPS(frameRenderTimestamps);
        stats.renderIntervalVariance = calculateIntervalVariance(frameRenderTimestamps);
        stats.renderDrawCostMs = calculateAverageDrawCost();
        stats.totalFramesReceived = totalFramesReceived;
        stats.totalFramesRendered = totalFramesRendered;

        return stats;
    }

    private double calculateFPS(List<Long> timestamps) {
        if (timestamps.size() < 2) return 0.0;

        long first = timestamps.get(0);
        long last = timestamps.get(timestamps.size() - 1);
        double durationSeconds = (last - first) / 1000.0;

        if (durationSeconds <= 0) return 0.0;

        return (timestamps.size() - 1) / durationSeconds;
    }

    private double calculateIntervalVariance(List<Long> timestamps) {
        if (timestamps.size() < 2) return 0.0;

        // Calculate intervals between consecutive timestamps
        List<Long> intervals = new ArrayList<>();
        for (int i = 1; i < timestamps.size(); i++) {
            long interval = timestamps.get(i) - timestamps.get(i - 1);
            intervals.add(interval);
        }

        // Calculate mean interval
        double sum = 0;
        for (long interval : intervals) {
            sum += interval;
        }
        double mean = sum / intervals.size();

        // Calculate variance: sum of squared differences from mean
        double varianceSum = 0;
        for (long interval : intervals) {
            double diff = interval - mean;
            varianceSum += diff * diff;
        }

        return varianceSum / intervals.size();
    }

    private double calculateAverageDrawCost() {
        if (drawCostSamples.isEmpty()) return 0.0;

        double sum = 0;
        for (double cost : drawCostSamples) {
            sum += cost;
        }

        return sum / drawCostSamples.size();
    }

    /**
     * Reset all statistics.
     */
    public void reset() {
        synchronized (lock) {
            frameReceiveTimestamps.clear();
            frameRenderTimestamps.clear();
            drawCostSamples.clear();
            totalFramesReceived = 0;
            totalFramesRendered = 0;
            lastReportTime = System.currentTimeMillis();
        }
    }
}

