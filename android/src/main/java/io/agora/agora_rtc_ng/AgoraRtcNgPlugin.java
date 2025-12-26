package io.agora.agora_rtc_ng;

import android.app.Activity;
import android.content.Context;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.io.IOException;
import java.lang.ref.WeakReference;
import java.util.HashMap;
import java.io.File;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class AgoraRtcNgPlugin implements FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware {

    private static final String TAG = "AgoraRtcNgPlugin";
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
        videoViewController = new VideoViewController(
                flutterPluginBinding.getTextureRegistry(),
                flutterPluginBinding.getBinaryMessenger());

        flutterPluginBinding.getPlatformViewRegistry().registerViewFactory(
                "AgoraTextureView",
                new AgoraPlatformViewFactory(
                        "AgoraTextureView",
                        flutterPluginBinding.getBinaryMessenger(),
                        new AgoraPlatformViewFactory.PlatformViewProviderTextureView(),
                        this.videoViewController));

        flutterPluginBinding.getPlatformViewRegistry().registerViewFactory(
                "AgoraSurfaceView",
                new AgoraPlatformViewFactory(
                        "AgoraSurfaceView",
                        flutterPluginBinding.getBinaryMessenger(),
                        new AgoraPlatformViewFactory.PlatformViewProviderSurfaceView(),
                        this.videoViewController));
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
        } else if ("androidInit".equals(call.method)) {
            // dart ffi DynamicLibrary.open do not trigger JNI_OnLoad in iris, so we need call java
            // System.loadLibrary here to trigger the JNI_OnLoad explicitly.
            System.loadLibrary("AgoraRtcWrapper");

            String externalFilesDir = getReliableStoragePath(applicationContext);
            final String finalPath = externalFilesDir;
            result.success(new HashMap<String, String>() {{
                put("externalFilesDir", finalPath);
            }});
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

    private String getReliableStoragePath(Context context) {
        if (context == null) {
            Log.e(TAG, "Context is null");
            return "";
        }

        try {
            File externalDir = context.getExternalFilesDir(null);
            if (isDirectoryUsable(externalDir)) {
                String path = externalDir.getAbsolutePath();
                Log.d(TAG, "Using external storage: " + path);
                return path;
            }
            Log.w(TAG, "External storage not usable");
        } catch (Exception e) {
            Log.e(TAG, "External storage error: " + e.getMessage());
        }

        try {
            File internalDir = context.getFilesDir();
            if (internalDir != null) {
                String path = internalDir.getAbsolutePath();
                Log.w(TAG, "Using internal storage (fallback): " + path);
                return path;
            }
        } catch (Exception e) {
            Log.e(TAG, "Internal storage error: " + e.getMessage());
        }

        Log.e(TAG, "All storage options failed, returning empty string");
        return "";
    }

    private boolean isDirectoryUsable(File dir) {
        if (dir == null) {
            return false;
        }

        if (!dir.exists()) {
            try {
                if (!dir.mkdirs() && !dir.exists()) {
                    Log.w(TAG, "Failed to create directory");
                    return false;
                }
            } catch (SecurityException e) {
                Log.e(TAG, "Security exception when creating directory: " + e.getMessage());
                return false;
            }
        }

        if (!dir.isDirectory()) {
            Log.w(TAG, "Path exists but is not a directory");
            return false;
        }

        if (!dir.canWrite()) {
            Log.w(TAG, "Directory is not writable");
            return false;
        }

        File testFile = new File(dir, ".agora_storage_test");
        try {
            if (testFile.createNewFile()) {
                testFile.delete();
                return true;
            }
            Log.w(TAG, "Cannot create test file in directory");
            return false;
        } catch (IOException e) {
            Log.e(TAG, "Write test failed: " + e.getMessage());
            return false;
        }
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        if (videoViewController != null) {
            videoViewController.onAttachedToActivity(binding);
        }
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        if (videoViewController != null) {
            videoViewController.onDetachedFromActivityForConfigChanges();
        }
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        if (videoViewController != null) {
            videoViewController.onReattachedToActivityForConfigChanges(binding);
        }
    }

    @Override
    public void onDetachedFromActivity() {
        if (videoViewController != null) {
            videoViewController.onDetachedFromActivity();
        }
    }
}
