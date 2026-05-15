package io.agora.agora_rtc_ng;

import android.graphics.SurfaceTexture;
import android.os.Handler;
import android.os.Looper;
import android.view.Surface;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.TextureRegistry;

public class TextureRenderer implements AgoraRenderPerformanceDelegate {
    private final TextureRegistry.SurfaceTextureEntry flutterTexture;

    private final IrisRenderer irisRenderer;
    private final MethodChannel methodChannel;
    private final MethodChannel sharedMethodChannel;  // Shared channel from VideoViewController
    private final Handler handler;
    private SurfaceTexture flutterSurfaceTexture;
    private Surface renderSurface;
    private final long uid;
    private final long textureId;
    
    // Performance monitor
    private final AgoraRenderPerformanceMonitor performanceMonitor;

    public TextureRenderer(
            TextureRegistry textureRegistry,
            BinaryMessenger binaryMessenger,
            MethodChannel sharedMethodChannel,  // Pass shared channel
            long irisRtcRenderingHandle,
            long uid,
            String channelId,
            int videoSourceType, int videoViewSetupMode,
            boolean enableArgusCounters) {

        this.handler = new Handler(Looper.getMainLooper());
        this.uid = uid;
        this.sharedMethodChannel = sharedMethodChannel;

        this.flutterTexture = textureRegistry.createSurfaceTexture();
        this.textureId = flutterTexture.id();
        this.flutterSurfaceTexture = this.flutterTexture.surfaceTexture();

        this.renderSurface = new Surface(this.flutterSurfaceTexture);

        this.methodChannel = new MethodChannel(binaryMessenger, "agora_rtc_engine/texture_render_" + flutterTexture.id());

        // Initialize performance monitor
        this.performanceMonitor = new AgoraRenderPerformanceMonitor();
        this.performanceMonitor.setEnabled(enableArgusCounters);
        this.performanceMonitor.setDelegate(this);

        this.irisRenderer = new IrisRenderer(
                irisRtcRenderingHandle,
                uid,
                channelId,
                videoSourceType,
                videoViewSetupMode);
        this.irisRenderer.setCallback(new IrisRenderer.Callback() {
            @Override
            public void onSizeChanged(int width, int height) {
                final SurfaceTexture st = TextureRenderer.this.flutterSurfaceTexture;
                if (null != st) {
                    st.setDefaultBufferSize(width, height);
                }

                handler.post(() -> {
                    methodChannel.invokeMethod(
                            "onSizeChanged",
                            new HashMap<String, Integer>() {{
                                put("width", width);
                                put("height", height);
                            }});
                });
            }
        });
        
        // Set performance callback to bridge native performance data to monitor
        this.irisRenderer.setPerformanceCallback(new IrisRenderer.PerformanceCallback() {
            @Override
            public void onFrameReceived() {
                performanceMonitor.recordFrameReceived();
            }

            @Override
            public void onFrameRenderedInterval() {
                performanceMonitor.recordFrameRenderedInterval();
            }

            @Override
            public void onRenderDrawCost(double drawCostMs) {
                performanceMonitor.recordRenderDrawCostWithValue(drawCostMs);
            }
        });

        this.irisRenderer.startRenderingToSurface(renderSurface);
    }

    public long getTextureId() {
        return textureId;
    }

    public void dispose() {
        // Force report final stats with callback before cleanup
        final MethodChannel channel = this.sharedMethodChannel;
        final long texId = this.textureId;
        final long uidValue = this.uid;
        
        if (performanceMonitor != null) {
            performanceMonitor.dispose();
        }
        
        irisRenderer.stopRenderingToSurface();
        this.irisRenderer.setCallback(null);
        this.irisRenderer.setPerformanceCallback(null);
        
        // Clean up performance monitor
        if (performanceMonitor != null) {
            performanceMonitor.setDelegate(null);
            performanceMonitor.dispose();
        }
        
        if (renderSurface != null) {
            renderSurface.release();
            renderSurface = null;
            flutterSurfaceTexture = null;
        }
    }

    @Override
    public void onRawFrameStats(Map<String, Object> rawStats) {
        // Send performance stats to Flutter layer via shared method channel
        Map<String, Object> statsMap = new HashMap<>(rawStats);
        statsMap.put("textureId", textureId);
        statsMap.put("uid", uid);
        
        handler.post(() -> {
            sharedMethodChannel.invokeMethod("onVideoRenderingPerformance", statsMap);
        });
    }
}
