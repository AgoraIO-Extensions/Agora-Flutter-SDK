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
    private long reportIntervalMs = 6000; // Report once per 6 seconds

    private final List<Long> frameReceiveTimestamps = new ArrayList<>();
    private final List<Long> frameRenderTimestamps = new ArrayList<>();
    private final List<Double> frameIntervalSamples = new ArrayList<>();
    private final List<Double> renderDrawCostSamples = new ArrayList<>();
    private long totalFramesReceived = 0;
    private long totalFramesRendered = 0;
    private long lastReportTime;

    // Period counters for accurate FPS calculation
    private long periodFramesReceived = 0;
    private long periodFramesRendered = 0;
    private long periodStartTime;

    // Timer for periodic reporting
    private java.util.Timer reportTimer;
    private final Object lock = new Object();

    public AgoraRenderPerformanceMonitor() {
        this.lastReportTime = System.currentTimeMillis();
        this.periodStartTime = System.currentTimeMillis();
        startReportTimer();
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
            // Restart timer with new interval
            stopReportTimer();
            startReportTimer();
        }
    }

    private void startReportTimer() {
        if (reportTimer != null) {
            return; // Already running
        }
        
        reportTimer = new java.util.Timer("AgoraPerformanceReportTimer", true);
        reportTimer.scheduleAtFixedRate(new java.util.TimerTask() {
            @Override
            public void run() {
                performPeriodicReport();
            }
        }, reportIntervalMs, reportIntervalMs);
    }

    private void stopReportTimer() {
        if (reportTimer != null) {
            reportTimer.cancel();
            reportTimer = null;
        }
    }

    private void performPeriodicReport() {
        synchronized (lock) {
            AgoraRenderPerformanceStats stats = computeStatsAndReset();
            if (stats != null && delegate != null) {
                delegate.onPerformanceStatsUpdated(stats);
            }
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
            periodFramesReceived++; // Increment period counter
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
            periodFramesRendered++; // Increment period counter
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

    /**
     * Get current performance statistics without resetting counters.
     */
    public AgoraRenderPerformanceStats getCurrentStats() {
        synchronized (lock) {
            return computeStatsInternal(false);
        }
    }

    /**
     * Force report with callback for final stats during disposal.
     */
    public void forceReportWithCallback(java.util.function.Consumer<AgoraRenderPerformanceStats> callback) {
        synchronized (lock) {
            AgoraRenderPerformanceStats stats = computeStatsAndReset();
            if (stats != null && callback != null) {
                callback.accept(stats);
            }
        }
    }

    private AgoraRenderPerformanceStats computeStatsAndReset() {
        return computeStatsInternal(true);
    }

    private AgoraRenderPerformanceStats computeStatsInternal(boolean shouldReset) {
        long now = System.currentTimeMillis();
        long actualPeriodDuration = now - periodStartTime;

        if (actualPeriodDuration <= 0) {
            return null; // Avoid division by zero
        }

        // Calculate FPS based on frame counts in this period
        double periodDurationSeconds = actualPeriodDuration / 1000.0;
        double inputFps = periodFramesReceived / periodDurationSeconds;
        double outputFps = periodFramesRendered / periodDurationSeconds;

        AgoraRenderPerformanceStats stats = new AgoraRenderPerformanceStats();
        stats.renderInputFps = inputFps;
        stats.renderOutputFps = outputFps;
        stats.renderFrameIntervalMs = calculateAverageFrameInterval();
        stats.renderDrawCostMs = calculateAverageRenderDrawCost();
        stats.totalFramesReceived = totalFramesReceived;
        stats.totalFramesRendered = totalFramesRendered;

        // Reset period counters only if requested
        if (shouldReset) {
            periodFramesReceived = 0;
            periodFramesRendered = 0;
            periodStartTime = now;
        }

        return stats;
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
            periodFramesReceived = 0;
            periodFramesRendered = 0;
            lastReportTime = System.currentTimeMillis();
            periodStartTime = System.currentTimeMillis();
        }
    }

    /**
     * Clean up resources.
     */
    public void dispose() {
        stopReportTimer();
        synchronized (lock) {
            delegate = null;
        }
    }
}

