package io.agora.agora_rtc_ng;

import android.content.Context;
import android.view.SurfaceView;
import android.view.TextureView;
import android.view.View;
import android.widget.FrameLayout;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import io.agora.iris.IrisApiEngine;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class AgoraPlatformViewFactory extends PlatformViewFactory {

    private final String viewType;
    private final BinaryMessenger messenger;
    private final PlatformViewProvider viewProvider;

    AgoraPlatformViewFactory(
            String viewType,
            BinaryMessenger messenger,
            PlatformViewProvider viewProvider) {
        super(StandardMessageCodec.INSTANCE);
        this.viewType = viewType;
        this.messenger = messenger;
        this.viewProvider = viewProvider;
    }

    interface PlatformViewProvider {
        View provide(Context context);
    }

    public static class PlatformViewProviderTextureView implements PlatformViewProvider {

        @Override
        public View provide(Context context) {
            return new TextureView(context);
        }
    }

    public static class PlatformViewProviderSurfaceView implements PlatformViewProvider {

        @Override
        public View provide(Context context) {
            return new TextureView(context);
        }
    }

    static class AgoraPlatformView implements PlatformView, MethodChannel.MethodCallHandler {
        private View innerView;
        private FrameLayout parentView;

        private final MethodChannel methodChannel;


        private long platformViewPtr;

        AgoraPlatformView(Context context,
                          String viewType,
                          int viewId,
                          PlatformViewProvider viewProvider,
                          BinaryMessenger messenger) {
            methodChannel = new MethodChannel(messenger, "agora_rtc_ng/" + viewType + "_" + viewId);
            methodChannel.setMethodCallHandler(this);
            innerView = viewProvider.provide(context);
            parentView = new FrameLayout(context);
            parentView.addView(innerView);

            platformViewPtr = IrisApiEngine.GetJObjectAddress(innerView);
        }

        @Override
        public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
            if (call.method.equals("getNativeViewPtr")) {
                result.success(platformViewPtr);
            } else if (call.method.equals("deleteNativeViewPtr")) {
                if (platformViewPtr != 0L) {
                    IrisApiEngine.FreeJObjectByAddress(platformViewPtr);
                    platformViewPtr = 0;
                }
                parentView.removeAllViews();
                innerView = null;
                result.success(0);
            }
        }

        @Nullable
        @Override
        public View getView() {
            return parentView;
        }

        @Override
        public void dispose() {

        }
    }

    @NonNull
    @Override
    public PlatformView create(@Nullable Context context, int viewId, @Nullable Object args) {
        return new AgoraPlatformView(
                context,
                viewType,
                viewId,
                viewProvider,
                messenger
        );
    }
}
