package io.agora.agora_rtc_ng;

import android.content.Context;
import android.opengl.EGL14;
import android.opengl.EGLConfig;
import android.opengl.EGLContext;
import android.opengl.EGLDisplay;
import android.opengl.EGLSurface;
import android.opengl.GLES20;
import android.view.Surface;
import android.view.SurfaceHolder;
import android.view.TextureView;
import android.view.SurfaceView;
import android.view.View;
import android.widget.FrameLayout;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.Map;

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

    static class ClearSurfaceCallback implements SurfaceHolder.Callback {
        @Override
        public void surfaceCreated(@NonNull SurfaceHolder holder) {
            try {
                clear(holder.getSurface());
            } catch (RuntimeException ignored) {
            }
        }

        @Override
        public void surfaceChanged(@NonNull SurfaceHolder holder, int format, int width, int height) {
        }

        @Override
        public void surfaceDestroyed(@NonNull SurfaceHolder holder) {
        }

        private static void clear(Surface surface) {
            if (surface == null || !surface.isValid()) {
                return;
            }
            EGLDisplay display = EGL14.eglGetDisplay(EGL14.EGL_DEFAULT_DISPLAY);
            int[] version = new int[2];
            if (display == null || display == EGL14.EGL_NO_DISPLAY
                    || !EGL14.eglInitialize(display, version, 0, version, 1)) {
                return;
            }
            int[] configAttribs = {
                    EGL14.EGL_RED_SIZE, 8,
                    EGL14.EGL_GREEN_SIZE, 8,
                    EGL14.EGL_BLUE_SIZE, 8,
                    EGL14.EGL_RENDERABLE_TYPE, EGL14.EGL_OPENGL_ES2_BIT,
                    EGL14.EGL_SURFACE_TYPE, EGL14.EGL_WINDOW_BIT,
                    EGL14.EGL_NONE
            };
            EGLConfig[] configs = new EGLConfig[1];
            int[] numConfigs = new int[1];
            if (!EGL14.eglChooseConfig(display, configAttribs, 0, configs, 0, 1, numConfigs, 0)
                    || numConfigs[0] <= 0 || configs[0] == null) {
                return;
            }
            int[] contextAttribs = {EGL14.EGL_CONTEXT_CLIENT_VERSION, 2, EGL14.EGL_NONE};
            EGLContext context = EGL14.eglCreateContext(
                    display, configs[0], EGL14.EGL_NO_CONTEXT, contextAttribs, 0);
            if (context == null || context == EGL14.EGL_NO_CONTEXT) {
                return;
            }
            EGLDisplay prevDisplay = EGL14.eglGetCurrentDisplay();
            EGLContext prevContext = EGL14.eglGetCurrentContext();
            EGLSurface prevDraw = EGL14.eglGetCurrentSurface(EGL14.EGL_DRAW);
            EGLSurface prevRead = EGL14.eglGetCurrentSurface(EGL14.EGL_READ);
            EGLSurface eglSurface = EGL14.EGL_NO_SURFACE;
            boolean current = false;
            try {
                EGLSurface created = EGL14.eglCreateWindowSurface(
                        display, configs[0], surface, new int[]{EGL14.EGL_NONE}, 0);
                if (created == null || created == EGL14.EGL_NO_SURFACE) {
                    return;
                }
                eglSurface = created;
                current = EGL14.eglMakeCurrent(display, eglSurface, eglSurface, context);
                if (current) {
                    GLES20.glClearColor(0f, 0f, 0f, 1f);
                    GLES20.glClear(GLES20.GL_COLOR_BUFFER_BIT);
                    EGL14.eglSwapBuffers(display, eglSurface);
                }
            } finally {
                if (current) {
                    restoreCurrent(display, prevDisplay, prevDraw, prevRead, prevContext);
                }
                if (eglSurface != EGL14.EGL_NO_SURFACE) {
                    EGL14.eglDestroySurface(display, eglSurface);
                }
                EGL14.eglDestroyContext(display, context);
            }
        }

        private static void restoreCurrent(EGLDisplay display, EGLDisplay prevDisplay, EGLSurface prevDraw,
                                           EGLSurface prevRead, EGLContext prevContext) {
            if (prevContext != null && prevContext != EGL14.EGL_NO_CONTEXT
                    && prevDisplay != null && prevDisplay != EGL14.EGL_NO_DISPLAY
                    && EGL14.eglMakeCurrent(prevDisplay, prevDraw, prevRead, prevContext)) {
                return;
            }
            EGL14.eglMakeCurrent(display, EGL14.EGL_NO_SURFACE, EGL14.EGL_NO_SURFACE, EGL14.EGL_NO_CONTEXT);
        }
    }

    static class AgoraPlatformView implements PlatformView, MethodChannel.MethodCallHandler {
        private View innerView;
        private FrameLayout parentView;
        private ClearSurfaceCallback clearSurfaceCallback;

        private final MethodChannel methodChannel;

        private final VideoViewController controller;

        private SimpleRef viewRef;

        private final int platformViewId;

        AgoraPlatformView(Context context,
                          String viewType,
                          int viewId,
                          PlatformViewProvider viewProvider,
                          BinaryMessenger messenger,
                          VideoViewController controller,
                          boolean useAndroidSurfaceViewHdr) {
            methodChannel = new MethodChannel(messenger, "agora_rtc_ng/" + viewType + "_" + viewId);
            methodChannel.setMethodCallHandler(this);
            this.controller = controller;
            this.platformViewId = viewId;
            this.viewRef = controller.createPlatformRender(viewId, context, viewProvider);

            innerView = (View) viewRef.getValue();
            if (useAndroidSurfaceViewHdr && innerView instanceof SurfaceView) {
                clearSurfaceCallback = new ClearSurfaceCallback();
                ((SurfaceView) innerView).getHolder().addCallback(clearSurfaceCallback);
            }
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
            if (clearSurfaceCallback != null) {
                ((SurfaceView) innerView).getHolder().removeCallback(clearSurfaceCallback);
                clearSurfaceCallback = null;
            }
            parentView.removeAllViews();
            parentView = null;
            innerView = null;
        }
    }

    @NonNull
    @Override
    public PlatformView create(@Nullable Context context, int viewId, @Nullable Object args) {
        boolean useAndroidSurfaceViewHdr = args instanceof Map
                && Boolean.TRUE.equals(((Map<?, ?>) args).get("useAndroidSurfaceViewHdr"));
        return new AgoraPlatformView(
                context,
                viewType,
                viewId,
                viewProvider,
                messenger,
                this.controller,
                useAndroidSurfaceViewHdr
        );
    }
}
