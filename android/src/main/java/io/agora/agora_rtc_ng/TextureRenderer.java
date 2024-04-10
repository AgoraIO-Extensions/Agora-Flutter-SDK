package io.agora.agora_rtc_ng;

import android.graphics.SurfaceTexture;
import android.os.Handler;
import android.os.Looper;
import android.view.Surface;

import java.util.HashMap;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.TextureRegistry;

public class TextureRenderer {
    private final TextureRegistry.SurfaceTextureEntry flutterTexture;

    private final IrisRenderer irisRenderer;
    private final MethodChannel methodChannel;
    private final Handler handler;
    private SurfaceTexture flutterSurfaceTexture;
    private Surface renderSurface;

    public TextureRenderer(
            TextureRegistry textureRegistry,
            BinaryMessenger binaryMessenger,
            long irisRtcRenderingHandle,
            long uid,
            String channelId,
            int videoSourceType, int videoViewSetupMode) {

        this.handler = new Handler(Looper.getMainLooper());

        this.flutterTexture = textureRegistry.createSurfaceTexture();
        this.flutterSurfaceTexture = this.flutterTexture.surfaceTexture();

        this.renderSurface = new Surface(this.flutterSurfaceTexture);

        this.methodChannel = new MethodChannel(binaryMessenger, "agora_rtc_engine/texture_render_" + flutterTexture.id());

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

        this.irisRenderer.startRenderingToSurface(renderSurface);
    }

    public long getTextureId() {
        return flutterTexture.id();
    }

    public void dispose() {
        this.methodChannel.setMethodCallHandler(null);
        irisRenderer.stopRenderingToSurface();
        this.irisRenderer.setCallback(null);
        if (renderSurface != null) {
            renderSurface.release();
            renderSurface = null;
            flutterSurfaceTexture = null;
        }
    }
}
