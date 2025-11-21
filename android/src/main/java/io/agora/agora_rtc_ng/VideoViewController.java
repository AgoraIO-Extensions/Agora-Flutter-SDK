package io.agora.agora_rtc_ng;

import android.app.Activity;
import android.content.Context;
import android.view.View;

import androidx.annotation.NonNull;

import java.util.HashMap;
import java.util.Map;

import io.agora.iris.IrisApiEngine;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
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

public class VideoViewController implements MethodChannel.MethodCallHandler, ActivityAware {

    private final TextureRegistry textureRegistry;
    private final BinaryMessenger binaryMessenger;

    private final MethodChannel methodChannel;
    private final PlatformRenderPool pool;

    private final Map<Long, TextureRenderer> textureRendererMap = new HashMap<>();

    private SimpleRef currentActivityRef;

    VideoViewController(TextureRegistry textureRegistry, BinaryMessenger binaryMessenger) {
        IrisRenderer.log(2, "VideoViewController constructor called");
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
        IrisRenderer.log(2, "VideoViewController createPlatformRender method called with platformViewId: " + platformViewId);
        return this.pool.createView(platformViewId, context, viewProvider);
    }

    public boolean destroyPlatformRender(int platformRenderId) {
        IrisRenderer.log(2, "VideoViewController destroyPlatformRender method called with platformRenderId: " + platformRenderId);
        return this.pool.deViewRef(platformRenderId);
    }

    public boolean addPlatformRenderRef(int platformViewId) {
        IrisRenderer.log(2, "VideoViewController addPlatformRenderRef method called with platformViewId: " + platformViewId);
        return this.pool.addViewRef(platformViewId);
    }

    public boolean dePlatformRenderRef(int platformViewId) {
        IrisRenderer.log(2, "VideoViewController dePlatformRenderRef method called with platformViewId: " + platformViewId);
        return this.pool.deViewRef(platformViewId);
    }

    private long createTextureRender(
            long irisRtcRenderingHandle,
            long uid,
            String channelId,
            int videoSourceType,
            int videoViewSetupMode) {
        IrisRenderer.log(2, "VideoViewController createTextureRender method called with irisRtcRenderingHandle: " + irisRtcRenderingHandle + ", uid: " + uid + ", channelId: " + channelId + ", videoSourceType: " + videoSourceType + ", videoViewSetupMode: " + videoViewSetupMode);
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
        IrisRenderer.log(2, "VideoViewController destroyTextureRender method called with textureId: " + textureId);
        final TextureRenderer textureRenderer = textureRendererMap.get(textureId);
        if (textureRenderer != null) {
            IrisRenderer.log(2, "VideoViewController destroyTextureRender method called with textureRenderer: " + textureRenderer);
            textureRenderer.dispose();
            textureRendererMap.remove(textureId);
            IrisRenderer.log(2, "VideoViewController destroyTextureRender method returned success: " + true);
            return true;
        }

        IrisRenderer.log(2, "VideoViewController destroyTextureRender method returned success: " + false);
        return false;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        IrisRenderer.log(2, "VideoViewController onMethodCall method called with call: " + call.method);
        switch (call.method) {
            case "attachVideoFrameBufferManager":
                result.success(0);
                break;
            case "detachVideoFrameBufferManager":
                result.success(true);
                break;
            case "addPlatformRenderRef": {
                int platformViewId = (int) call.arguments;
                this.addPlatformRenderRef(platformViewId);
                result.success(true);
                break;
            }
            case "dePlatfromViewRef": {
                int platformViewId = (int) call.arguments;
                this.dePlatformRenderRef(platformViewId);
                result.success(true);
                break;
            }
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
                IrisRenderer.log(2, "VideoViewController destroyTextureRender method called with textureId: " + textureId);
                final boolean success = destroyTextureRender(textureId);
                result.success(success);
                break;
            }
            case "dispose": {
                IrisRenderer.log(2, "VideoViewController dispose method called");
                disposeAllRenderers();
                IrisRenderer.log(2, "VideoViewController dispose method returned success: " + true);
                result.success(true);
                break;
            }
            case "getCurrentActivityHandle": {
                if (currentActivityRef != null) {
                    result.success(currentActivityRef.getNativeHandle());
                } else {
                    IrisRenderer.log(2, "VideoViewController getCurrentActivityHandle method returned success: " + 0);
                    result.success(0);
                }

                break;
            }
            case "updateTextureRenderData":
            default:
                result.notImplemented();
                break;
        }
    }

    private void disposeAllRenderers() {
        IrisRenderer.log(2, "VideoViewController disposeAllRenderers method called");
        for (final TextureRenderer textureRenderer : textureRendererMap.values()) {
            IrisRenderer.log(2, "VideoViewController disposeAllRenderers method called with textureRenderer: " + textureRenderer);
            textureRenderer.dispose();
        }
        textureRendererMap.clear();
        IrisRenderer.log(2, "VideoViewController disposeAllRenderers method returned success: " + true);
    }

    /**
     * Flutter may convert a long to int type in java, we force parse a long value via this function
     */
    private long getLong(Object value) {
        return Long.parseLong(value.toString());
    }

    public void dispose() {
        IrisRenderer.log(2, "VideoViewController dispose method called");
        methodChannel.setMethodCallHandler(null);
        currentActivityRef = null;
        disposeAllRenderers();
        IrisRenderer.log(2, "VideoViewController dispose method returned success: " + true);
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        currentActivityRef = new SimpleRef(binding.getActivity());
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        currentActivityRef.releaseRef();
        currentActivityRef = null;
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        currentActivityRef = new SimpleRef(binding.getActivity());
    }

    @Override
    public void onDetachedFromActivity() {
        currentActivityRef.releaseRef();
        currentActivityRef = null;
    }
}
