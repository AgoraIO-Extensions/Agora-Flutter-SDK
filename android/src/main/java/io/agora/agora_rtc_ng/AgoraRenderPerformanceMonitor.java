package io.agora.agora_rtc_ng;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Delegate interface for performance statistics callbacks.
 */
interface AgoraRenderPerformanceDelegate {
    void onRawFrameStats(Map<String, Object> rawStats);
}

/**
 * Performance monitor for video rendering in Flutter Texture mode.
 */
public class AgoraRenderPerformanceMonitor {
    private static final int MAX_SAMPLE_SIZE = 100;

    private AgoraRenderPerformanceDelegate delegate;
    private boolean enabled = true;

    private long totalFramesReceived = 0;
    private long totalFramesRendered = 0;

    /// Timestamp of last frame notification to Flutter (in milliseconds)
    private long lastFrameNotifyTimeMs = 0;
    /// Timestamp of last frame received (in milliseconds) for render duration calculation
    private long lastFrameReceivedTimeMs = 0;
    /// Last calculated frame interval for immediate reporting
    private double lastFrameIntervalMs = 0;
    /// Last calculated draw cost for immediate reporting
    private double lastDrawCostMs = 0;

    private final Object lock = new Object();

    public AgoraRenderPerformanceMonitor() {
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

    /**
     * Record a frame received event for FPS calculation.
     */
    public void recordFrameReceived() {
        if (!enabled) return;

        long nowMs = System.currentTimeMillis();

        synchronized (lock) {
            lastFrameReceivedTimeMs = nowMs;
            totalFramesReceived++;
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
            double frameIntervalMs = 0.0;
            if (lastFrameNotifyTimeMs > 0) {
                frameIntervalMs = (double) (nowMs - lastFrameNotifyTimeMs);
            }
            lastFrameNotifyTimeMs = nowMs;
            lastFrameIntervalMs = frameIntervalMs;
            totalFramesRendered++;

            reportRawFrameStats();
        }
    }

    /**
     * Record render draw cost with a pre-calculated value (in milliseconds).
     * This is used when the draw cost is calculated in native code to avoid race conditions.
     */
    public void recordRenderDrawCostWithValue(double drawCostMs) {
        if (!enabled) return;

        synchronized (lock) {
            lastDrawCostMs = drawCostMs;
        }
    }

    private void reportRawFrameStats() {
        Map<String, Object> rawStats = new HashMap<>();
        rawStats.put("renderFrameIntervalMs", lastFrameIntervalMs);
        rawStats.put("renderDrawCostMs", lastDrawCostMs);
        rawStats.put("totalFramesReceived", totalFramesReceived);
        rawStats.put("totalFramesRendered", totalFramesRendered);

        if (delegate != null) {
            delegate.onRawFrameStats(rawStats);
        }
    }

    public void reset() {
        synchronized (lock) {
            totalFramesReceived = 0;
            totalFramesRendered = 0;
            lastFrameNotifyTimeMs = 0;
            lastFrameReceivedTimeMs = 0;
            lastFrameIntervalMs = 0;
            lastDrawCostMs = 0;
        }
    }

    public void dispose() {
        synchronized (lock) {
            delegate = null;
        }
    }
}

