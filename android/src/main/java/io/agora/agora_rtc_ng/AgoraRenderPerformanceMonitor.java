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
    public double renderFrameIntervalMs;
    public double renderDrawCostMs;
    public long totalFramesReceived;
    public long totalFramesRendered;

    public Map<String, Object> toDictionary() {
        Map<String, Object> map = new HashMap<>();
        map.put("uid", uid);
        map.put("renderInputFps", renderInputFps);
        map.put("renderOutputFps", renderOutputFps);
        map.put("renderFrameIntervalMs", renderFrameIntervalMs);
        map.put("renderDrawCostMs", renderDrawCostMs);
        map.put("totalFramesReceived", totalFramesReceived);
        map.put("totalFramesRendered", totalFramesRendered);
        return map;
    }

    @Override
    public String toString() {
        return String.format(
            "<AgoraRenderPerformanceStats: InFPS=%.1f, OutFPS=%.1f, Interval=%.2fms, " +
            "drawCost=%.2fms, Received=%d, Rendered=%d>",
            renderInputFps, renderOutputFps, renderFrameIntervalMs,
            renderDrawCostMs, totalFramesReceived, totalFramesRendered
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
    private long reportIntervalMs = 6000; // Report once per second

    private final List<Long> frameReceiveTimestamps = new ArrayList<>();
    private final List<Long> frameRenderTimestamps = new ArrayList<>();
    private final List<Double> frameIntervalSamples = new ArrayList<>();
    private final List<Double> renderDrawCostSamples = new ArrayList<>();
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
     * Record a frame received event for FPS calculation.
     */
    public void recordFrameReceived() {
        if (!enabled) return;

        long nowMs = System.currentTimeMillis();

        synchronized (lock) {
            frameReceiveTimestamps.add(nowMs);
            if (frameReceiveTimestamps.size() > MAX_SAMPLE_SIZE) {
                frameReceiveTimestamps.remove(0);
            }
            totalFramesReceived++;

            checkAndReportStats();
        }
    }

    /**
     * Record a frame rendered event (textureFrameAvailable notification).
     * Calculates frame interval from the last notification.
     */
    public void recordFrameRenderedInterval() {
        if (!enabled) return;

        long nowMs = System.currentTimeMillis();

        synchronized (lock) {
            frameRenderTimestamps.add(nowMs);
            if (frameRenderTimestamps.size() > MAX_SAMPLE_SIZE) {
                frameRenderTimestamps.remove(0);
            }

            // Calculate frame interval (time between consecutive textureFrameAvailable calls)
            if (frameRenderTimestamps.size() >= 2) {
                int size = frameRenderTimestamps.size();
                long intervalMs = frameRenderTimestamps.get(size - 1) - frameRenderTimestamps.get(size - 2);
                frameIntervalSamples.add((double) intervalMs);
                if (frameIntervalSamples.size() > MAX_SAMPLE_SIZE) {
                    frameIntervalSamples.remove(0);
                }
            }

            totalFramesRendered++;

            checkAndReportStats();
        }
    }

    /**
     * Record render draw cost with a pre-calculated value (in milliseconds).
     * This is used when the draw cost is calculated in native code to avoid race conditions.
     */
    public void recordRenderDrawCostWithValue(double drawCostMs) {
        if (!enabled) return;

        synchronized (lock) {
            renderDrawCostSamples.add(drawCostMs);
            if (renderDrawCostSamples.size() > MAX_SAMPLE_SIZE) {
                renderDrawCostSamples.remove(0);
            }
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
        stats.renderFrameIntervalMs = calculateAverageFrameInterval();
        stats.renderDrawCostMs = calculateAverageRenderDrawCost();
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

    private double calculateAverageFrameInterval() {
        if (frameIntervalSamples.isEmpty()) return 0.0;

        double sum = 0;
        for (double interval : frameIntervalSamples) {
            sum += interval;
        }

        return sum / frameIntervalSamples.size();
    }

    private double calculateAverageRenderDrawCost() {
        if (renderDrawCostSamples.isEmpty()) return 0.0;

        double sum = 0;
        for (double cost : renderDrawCostSamples) {
            sum += cost;
        }

        return sum / renderDrawCostSamples.size();
    }

    /**
     * Reset all statistics.
     */
    public void reset() {
        synchronized (lock) {
            frameReceiveTimestamps.clear();
            frameRenderTimestamps.clear();
            frameIntervalSamples.clear();
            renderDrawCostSamples.clear();
            totalFramesReceived = 0;
            totalFramesRendered = 0;
            lastReportTime = System.currentTimeMillis();
        }
    }
}

