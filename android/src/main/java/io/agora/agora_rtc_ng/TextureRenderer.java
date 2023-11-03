package io.agora.agora_rtc_ng;

import android.graphics.SurfaceTexture;
import android.os.Handler;
import android.os.Looper;
import android.view.Surface;

import androidx.annotation.NonNull;

import java.util.HashMap;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.TextureRegistry;

public class TextureRenderer {
    private final TextureRegistry.SurfaceTextureEntry flutterTexture;

    private final IrisRenderer irisRenderer;
    private final MethodChannel methodChannel;
    private final Handler handler;
    private SurfaceTexture flutterSurfaceTexture;
    private Surface renderSurface;

    int width = 0;
    int height = 0;

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
        this.methodChannel.setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
                if (call.method.equals("setSizeNative")) {
                    if (call.arguments() == null) {
                        result.success(false);
                        return;
                    }

                    int width = 0;
                    int height = 0;
                    if (call.hasArgument("width")) {
                        width = call.argument("width");
                    }
                    if (call.hasArgument("height")) {
                        height = call.argument("height");
                    }

                    startRendering(width, height);

                    result.success(true);
                    return;
                }

                result.notImplemented();
            }
        });

        this.irisRenderer = new IrisRenderer(
                irisRtcRenderingHandle,
                uid,
                channelId,
                videoSourceType,
                videoViewSetupMode);
        this.irisRenderer.setCallback(new IrisRenderer.Callback() {
            @Override
            public void onSizeChanged(int width, int height) {
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
    }

    private void startRendering(int width, int height) {
        if (width == 0 && height == 0) {
            return;
        }

        final SurfaceTexture st = TextureRenderer.this.flutterSurfaceTexture;
        if (null == st) {
            return;
        }

        if (this.width != width || this.height != height) {
            st.setDefaultBufferSize(width, height);

            // Only call `irisRenderer.startRenderingToSurface` in the first time.
            if (this.width == 0 && this.height == 0) {
                this.irisRenderer.startRenderingToSurface(renderSurface);
            }

            this.width = width;
            this.height = height;
        }
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
