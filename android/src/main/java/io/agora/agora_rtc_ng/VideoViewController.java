package io.agora.agora_rtc_ng;

import android.content.Context;
import android.view.View;

import androidx.annotation.NonNull;

import java.util.HashMap;
import java.util.Map;

import io.agora.iris.IrisApiEngine;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.TextureRegistry;

class SimpleRef {
    private Object value;
    private int refCount;
    private long nativeHandle;

    SimpleRef(Object value) {
        this.value = value;
        this.refCount = 1;
        this.nativeHandle = IrisApiEngine.GetJObjectAddress(this.value);
    }

    int getRefCount() {
        return this.refCount;
    }

    Object getValue() {
        return value;
    }

    long getNativeHandle() {
        return this.nativeHandle;
    }

    void addRef() {
        ++this.refCount;
    }

    void deRef() {
        --this.refCount;
    }

    void releaseRef() {
        IrisApiEngine.FreeJObjectByAddress(this.nativeHandle);
        this.nativeHandle = 0L;
        this.value = null;
        this.refCount = 0;
    }
}

class PlatformRenderPool {

    private final Map<Integer, SimpleRef> renders = new HashMap<>();

    SimpleRef createView(int platformViewId,
                         Context context,
                         AgoraPlatformViewFactory.PlatformViewProvider viewProvider) {
        final View view = viewProvider.provide(context);

        final SimpleRef simpleRef = new SimpleRef(view);
        renders.put(platformViewId, simpleRef);

        return simpleRef;
    }

    boolean addViewRef(int platformViewId) {
        if (renders.containsKey(platformViewId)) {
            final SimpleRef simpleRef = renders.get(platformViewId);

            //noinspection ConstantConditions
            simpleRef.addRef();
            return true;
        }
        return false;
    }

    boolean deViewRef(int platformViewId) {
        if (renders.containsKey(platformViewId)) {
            final SimpleRef simpleRef = renders.get(platformViewId);

            //noinspection ConstantConditions
            simpleRef.deRef();

            if (simpleRef.getRefCount() <= 0) {
                simpleRef.releaseRef();
                renders.remove(platformViewId);
            }

            return true;
        }

        return false;
    }
}

public class VideoViewController implements MethodChannel.MethodCallHandler {

    private final TextureRegistry textureRegistry;
    private final BinaryMessenger binaryMessenger;

    private final MethodChannel methodChannel;
    private final PlatformRenderPool pool;

    private final Map<Long, TextureRenderer> textureRendererMap = new HashMap<>();

    VideoViewController(TextureRegistry textureRegistry, BinaryMessenger binaryMessenger) {
        this.textureRegistry = textureRegistry;
        this.binaryMessenger = binaryMessenger;
        methodChannel = new MethodChannel(binaryMessenger, "agora_rtc_ng/video_view_controller");
        methodChannel.setMethodCallHandler(this);
        pool = new PlatformRenderPool();
    }

    public SimpleRef createPlatformRender(
            int platformViewId,
            Context context,
            AgoraPlatformViewFactory.PlatformViewProvider viewProvider) {
        return this.pool.createView(platformViewId, context, viewProvider);
    }

    public boolean destroyPlatformRender(int platformRenderId) {
        return this.pool.deViewRef(platformRenderId);
    }

    public boolean addPlatformRenderRef(int platformViewId) {
        return this.pool.addViewRef(platformViewId);
    }

    public boolean dePlatformRenderRef(int platformViewId) {
        return this.pool.deViewRef(platformViewId);
    }

    private long createTextureRender(
            long irisRtcRenderingHandle,
            long uid,
            String channelId,
            int videoSourceType,
            int videoViewSetupMode) {
        final TextureRenderer textureRenderer = new TextureRenderer(
                textureRegistry,
                binaryMessenger,
                irisRtcRenderingHandle,
                uid,
                channelId,
                videoSourceType,
                videoViewSetupMode);
        final long textureId = textureRenderer.getTextureId();
        textureRendererMap.put(textureId, textureRenderer);

        return textureId;
    }

    private boolean destroyTextureRender(long textureId) {
        final TextureRenderer textureRenderer = textureRendererMap.get(textureId);
        if (textureRenderer != null) {
            textureRenderer.dispose();
            textureRendererMap.remove(textureId);
            return true;
        }

        return false;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case "attachVideoFrameBufferManager":
                result.success(0);
                break;
            case "detachVideoFrameBufferManager":
                result.success(true);
                break;
            case "dePlatfromViewRef":
                int platformViewId = (int) call.arguments;
                this.dePlatformRenderRef(platformViewId);
                result.success(true);
                break;
            case "createTextureRender": {
                final Map<?, ?> args = (Map<?, ?>) call.arguments;

                @SuppressWarnings("ConstantConditions") final long irisRtcRenderingHandle = getLong(args.get("irisRtcRenderingHandle"));
                @SuppressWarnings("ConstantConditions") final long uid = getLong(args.get("uid"));
                final String channelId = (String) args.get("channelId");
                final int videoSourceType = (int) args.get("videoSourceType");
                final int videoViewSetupMode = (int) args.get("videoViewSetupMode");

                final long textureId = createTextureRender(
                        irisRtcRenderingHandle,
                        uid,
                        channelId,
                        videoSourceType,
                        videoViewSetupMode);
                result.success(textureId);
                break;
            }
            case "destroyTextureRender": {
                final long textureId = getLong(call.arguments);
                final boolean success = destroyTextureRender(textureId);
                result.success(success);
                break;
            }
            case "dispose": {
                disposeAllRenderers();
                result.success(true);
                break;
            }
            case "updateTextureRenderData":
            default:
                result.notImplemented();
                break;
        }
    }

    private void disposeAllRenderers() {
        for (final TextureRenderer textureRenderer : textureRendererMap.values()) {
            textureRenderer.dispose();
        }
        textureRendererMap.clear();
    }

    /**
     * Flutter may convert a long to int type in java, we force parse a long value via this function
     */
    private long getLong(Object value) {
        return Long.parseLong(value.toString());
    }

    public void dispose() {
        methodChannel.setMethodCallHandler(null);
    }
}
