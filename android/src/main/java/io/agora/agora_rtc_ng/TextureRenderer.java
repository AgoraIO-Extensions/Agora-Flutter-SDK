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
    private final Handler handler;
    private SurfaceTexture flutterSurfaceTexture;
    private Surface renderSurface;
    private final long uid;
    
    // Performance monitor
    private final AgoraRenderPerformanceMonitor performanceMonitor;

    public TextureRenderer(
            TextureRegistry textureRegistry,
            BinaryMessenger binaryMessenger,
            long irisRtcRenderingHandle,
            long uid,
            String channelId,
            int videoSourceType, int videoViewSetupMode) {

        this.handler = new Handler(Looper.getMainLooper());
        this.uid = uid;

        this.flutterTexture = textureRegistry.createSurfaceTexture();
        this.flutterSurfaceTexture = this.flutterTexture.surfaceTexture();

        this.renderSurface = new Surface(this.flutterSurfaceTexture);

        this.methodChannel = new MethodChannel(binaryMessenger, "agora_rtc_engine/texture_render_" + flutterTexture.id());

        // Initialize performance monitor
        this.performanceMonitor = new AgoraRenderPerformanceMonitor();
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
            public void onFrameReceived(long timestamp) {
                performanceMonitor.recordFrameReceived(timestamp);
            }

            @Override
            public void onFrameRendered(long timestamp, double drawCost) {
                performanceMonitor.recordFrameRendered(timestamp, drawCost);
            }
        });

        this.irisRenderer.startRenderingToSurface(renderSurface);
    }

    public long getTextureId() {
        return flutterTexture.id();
    }

    public void dispose() {
        this.methodChannel.setMethodCallHandler(null);
        irisRenderer.stopRenderingToSurface();
        this.irisRenderer.setCallback(null);
        this.irisRenderer.setPerformanceCallback(null);
        
        // Clean up performance monitor
        if (performanceMonitor != null) {
            performanceMonitor.setDelegate(null);
        }
        
        if (renderSurface != null) {
            renderSurface.release();
            renderSurface = null;
            flutterSurfaceTexture = null;
        }
    }

    @Override
    public void onPerformanceStatsUpdated(AgoraRenderPerformanceStats stats) {
        // Send performance stats to Flutter layer via method channel
        Map<String, Object> statsMap = new HashMap<>(stats.toDictionary());
        statsMap.put("textureId", getTextureId());
        statsMap.put("uid", uid);
        
        handler.post(() -> {
            methodChannel.invokeMethod("onVideoRenderingPerformance", statsMap);
        });
    }
}
