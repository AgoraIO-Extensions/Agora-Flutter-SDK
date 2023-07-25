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

    private final MethodChannel methodChannel;
    private final PlatformRenderPool pool;

    VideoViewController(BinaryMessenger binaryMessenger) {
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

    private long createTextureRender() {
        return 0L;
    }

    private boolean destroyTextureRender(long textureId){
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

            case "createTextureRender":
            case "destroyTextureRender":
            case "updateTextureRenderData":
            default:
                result.notImplemented();
                break;
        }
    }

    public void dispose() {
        methodChannel.setMethodCallHandler(null);
    }
}
