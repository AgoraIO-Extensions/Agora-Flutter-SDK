package io.agora.agora_rtc_ng;

import android.content.Context;
import android.view.TextureView;
import android.view.SurfaceView;
import android.view.View;
import android.widget.FrameLayout;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

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

    private final VideoViewController controller;

    AgoraPlatformViewFactory(
            String viewType,
            BinaryMessenger messenger,
            PlatformViewProvider viewProvider,
            VideoViewController controller) {
        super(StandardMessageCodec.INSTANCE);
        this.viewType = viewType;
        this.messenger = messenger;
        this.viewProvider = viewProvider;
        this.controller = controller;
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
            return new SurfaceView(context);
        }
    }

    static class AgoraPlatformView implements PlatformView, MethodChannel.MethodCallHandler {
        private View innerView;
        private FrameLayout parentView;

        private final MethodChannel methodChannel;

        private final VideoViewController controller;

        private SimpleRef viewRef;

        private final int platformViewId;

        AgoraPlatformView(Context context,
                          String viewType,
                          int viewId,
                          PlatformViewProvider viewProvider,
                          BinaryMessenger messenger,
                          VideoViewController controller) {
            methodChannel = new MethodChannel(messenger, "agora_rtc_ng/" + viewType + "_" + viewId);
            methodChannel.setMethodCallHandler(this);
            this.controller = controller;
            this.platformViewId = viewId;
            this.viewRef = controller.createPlatformRender(viewId, context, viewProvider);

            innerView = (View) viewRef.getValue();
            parentView = new FrameLayout(context);
            parentView.addView(innerView);
        }

        @Override
        public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
            if (call.method.equals("getNativeViewPtr")) {
                long platformViewPtr = 0L;
                if (viewRef != null) {
                    this.controller.addPlatformRenderRef(this.platformViewId);
                    platformViewPtr = viewRef.getNativeHandle();
                }

                result.success(platformViewPtr);
            } else if (call.method.equals("deleteNativeViewPtr")) {
                // Do nothing.
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
            this.controller.dePlatformRenderRef(this.platformViewId);
            viewRef = null;
            parentView.removeAllViews();
            parentView = null;
            innerView = null;
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
                messenger,
                this.controller
        );
    }
}
