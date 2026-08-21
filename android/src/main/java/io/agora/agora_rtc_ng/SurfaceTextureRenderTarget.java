package io.agora.agora_rtc_ng;

import android.graphics.SurfaceTexture;
import android.os.Handler;
import android.os.Looper;

import java.util.HashMap;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.TextureRegistry;

class SurfaceTextureRenderTarget {
    private final TextureRegistry.SurfaceTextureEntry flutterTexture;
    private final SimpleRef surfaceTextureRef;
    private final MethodChannel methodChannel;
    private final Handler handler;
    private final SurfaceTexture flutterSurfaceTexture;
    private final IrisRenderer irisRenderer;

    SurfaceTextureRenderTarget(
            TextureRegistry textureRegistry,
            BinaryMessenger binaryMessenger,
            long irisRtcRenderingHandle,
            long uid,
            String channelId,
            int videoSourceType,
            int videoViewSetupMode) {
        this.handler = new Handler(Looper.getMainLooper());
        this.flutterTexture = textureRegistry.createSurfaceTexture();
        this.flutterSurfaceTexture = this.flutterTexture.surfaceTexture();
        this.surfaceTextureRef = new SimpleRef(this.flutterSurfaceTexture);
        this.methodChannel = new MethodChannel(
                binaryMessenger,
                "agora_rtc_engine/texture_render_" + flutterTexture.id());
        this.irisRenderer = new IrisRenderer(
                irisRtcRenderingHandle,
                uid,
                channelId,
                videoSourceType,
                videoViewSetupMode);
        this.irisRenderer.setCallback(new IrisRenderer.Callback() {
            @Override
            public void onSizeChanged(int width, int height) {
                final SurfaceTexture st = SurfaceTextureRenderTarget.this.flutterSurfaceTexture;
                if (st != null) {
                    st.setDefaultBufferSize(width, height);
                }

                handler.post(() -> methodChannel.invokeMethod(
                        "onSizeChanged",
                        new HashMap<String, Integer>() {{
                            put("width", width);
                            put("height", height);
                        }}));
            }
        });
        this.irisRenderer.startObservingTextureSize();
    }

    long getTextureId() {
        return flutterTexture.id();
    }

    long getSurfaceTextureHandle() {
        return surfaceTextureRef.getNativeHandle();
    }

    void dispose() {
        methodChannel.setMethodCallHandler(null);
        irisRenderer.stopObservingTextureSize();
        irisRenderer.setCallback(null);
        surfaceTextureRef.releaseRef();
        flutterTexture.release();
    }
}
