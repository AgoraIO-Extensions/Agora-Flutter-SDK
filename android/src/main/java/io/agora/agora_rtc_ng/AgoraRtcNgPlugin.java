package io.agora.agora_rtc_ng;

import android.content.Context;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.io.IOException;
import java.lang.ref.WeakReference;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class AgoraRtcNgPlugin implements FlutterPlugin, MethodChannel.MethodCallHandler {

    static {
        System.loadLibrary("AgoraRtcWrapper");
    }

    private MethodChannel channel;
    private WeakReference<FlutterPluginBinding> flutterPluginBindingRef;
    private VideoViewController videoViewController;
    @Nullable
    private Context applicationContext;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        applicationContext = flutterPluginBinding.getApplicationContext();
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "agora_rtc_ng");
        channel.setMethodCallHandler(this);
        flutterPluginBindingRef = new WeakReference<>(flutterPluginBinding);

        flutterPluginBinding.getPlatformViewRegistry().registerViewFactory(
                "AgoraTextureView",
                new AgoraPlatformViewFactory(
                        "AgoraTextureView",
                        flutterPluginBinding.getBinaryMessenger(),
                        new AgoraPlatformViewFactory.PlatformViewProviderTextureView()));

        flutterPluginBinding.getPlatformViewRegistry().registerViewFactory(
                "AgoraSurfaceView",
                new AgoraPlatformViewFactory(
                        "AgoraSurfaceView",
                        flutterPluginBinding.getBinaryMessenger(),
                        new AgoraPlatformViewFactory.PlatformViewProviderSurfaceView()));

        videoViewController = new VideoViewController(flutterPluginBinding.getBinaryMessenger());
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        applicationContext = null;
        channel.setMethodCallHandler(null);
        videoViewController.dispose();
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        if ("getAssetAbsolutePath".equals(call.method)) {
            getAssetAbsolutePath(call, result);
        } else if ("getExternalFilesDir".equals(call.method)) {
            if (applicationContext != null) {
                result.success(applicationContext.getExternalFilesDir(null).getAbsolutePath());
            } else {
                result.error("", "Application context is null", null);
            }
        } else {
            result.notImplemented();
        }
    }

    private void getAssetAbsolutePath(MethodCall call, MethodChannel.Result result) {
        final String path = call.arguments();

        if (path != null) {
            if (this.flutterPluginBindingRef.get() != null
            ) {
                final String assetKey = this.flutterPluginBindingRef.get()
                        .getFlutterAssets()
                        .getAssetFilePathByName(path);
                try {
                    this.flutterPluginBindingRef.get().getApplicationContext()
                            .getAssets()
                            .openFd(assetKey)
                            .close();
                    result.success("/assets/" + assetKey);
                    return;
                } catch (IOException e) {
                    result.error(e.getClass().getSimpleName(), e.getMessage(), e.getCause());
                    return;
                }
            }
        }
        result.error("IllegalArgumentException", "The parameter should not be null", null);
    }
}
