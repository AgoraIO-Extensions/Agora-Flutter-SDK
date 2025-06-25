package io.agora.agora_rtc_ng;

import android.app.Activity;
import android.content.Context;
import android.graphics.Rect;
import android.os.Build;
import android.util.Rational;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import io.agora.pip.AgoraPIPActivityProxy;
import io.agora.pip.AgoraPIPController;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import java.io.IOException;
import java.lang.ref.WeakReference;
import java.util.HashMap;
import java.util.Map;

public class AgoraRtcNgPlugin implements FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware {

    private MethodChannel channel;
    private WeakReference<FlutterPluginBinding> flutterPluginBindingRef;
    private VideoViewController videoViewController;
    private AgoraPIPController pipController;
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

            result.success(true);
        } else if (call.method.startsWith("pip")) {
            handlePipMethodCall(call, result);
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

    private void initPipController(@NonNull ActivityPluginBinding binding) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {

            Activity activity = binding.getActivity();
            if (!(activity instanceof AgoraPIPActivityProxy)) {
                return;
            }

            if (pipController != null) {
                pipController.dispose();
            }

            pipController = new AgoraPIPController(
                    (AgoraPIPActivityProxy) activity,
                    new AgoraPIPController.PIPStateChangedListener() {
                        @Override
                        public void onPIPStateChangedListener(
                                AgoraPIPController.PIPState state) {
                            // put state into a json object
                            channel.invokeMethod("pipStateChanged",
                                    new HashMap<String, Object>() {
                                        {
                                            put("state", state.getValue());
                                        }
                                    });
                        }
                    });
        }
    }

    private void handlePipMethodCall(@NonNull MethodCall call,
                                     @NonNull MethodChannel.Result result) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O ||
                pipController == null) {
            result.error("IllegalStateException", "PiP is not supported",
                    "Picture-in-Picture mode is not available on this device (requires Android 8.0 or higher) or the main activity does not implement AgoraPIPActivityProxy");
            return;
        }

        try {
            switch (call.method) {
                case "pipIsSupported":
                    result.success(pipController.isSupported());
                    break;
                case "pipIsAutoEnterSupported":
                    result.success(pipController.isAutoEnterSupported());
                    break;
                case "pipIsActivated":
                    result.success(pipController.isActivated());
                    break;
                case "pipSetup":
                    final Map<?, ?> args = (Map<?, ?>) call.arguments;
                    Rational aspectRatio = null;
                    if (args.get("aspectRatioX") != null &&
                            args.get("aspectRatioY") != null) {
                        aspectRatio = new Rational((int) args.get("aspectRatioX"),
                                (int) args.get("aspectRatioY"));
                    }
                    Boolean autoEnterEnabled = null;
                    if (args.get("autoEnterEnabled") != null) {
                        autoEnterEnabled = (boolean) args.get("autoEnterEnabled");
                    }
                    Rect sourceRectHint = null;
                    if (args.get("sourceRectHintLeft") != null &&
                            args.get("sourceRectHintTop") != null &&
                            args.get("sourceRectHintRight") != null &&
                            args.get("sourceRectHintBottom") != null) {
                        sourceRectHint =
                                new Rect((int) args.get("sourceRectHintLeft"),
                                        (int) args.get("sourceRectHintTop"),
                                        (int) args.get("sourceRectHintRight"),
                                        (int) args.get("sourceRectHintBottom"));
                    }
                    Boolean seamlessResizeEnabled = null;
                    if (args.get("seamlessResizeEnabled") != null) {
                        seamlessResizeEnabled =
                                (boolean) args.get("seamlessResizeEnabled");
                    }
                    Boolean useExternalStateMonitor = null;
                    if (args.get("useExternalStateMonitor") != null) {
                        useExternalStateMonitor =
                                (boolean) args.get("useExternalStateMonitor");
                    }
                    Integer externalStateMonitorInterval = null;
                    if (args.get("externalStateMonitorInterval") != null) {
                        externalStateMonitorInterval =
                                (int) args.get("externalStateMonitorInterval");
                    }

                    result.success(pipController.setup(
                            aspectRatio, autoEnterEnabled, sourceRectHint,
                            seamlessResizeEnabled, useExternalStateMonitor,
                            externalStateMonitorInterval));
                    break;
                case "pipStart":
                    result.success(pipController.start());
                    break;
                case "pipStop":
                    pipController.stop();
                    result.success(null);
                    break;
                case "pipDispose":
                    pipController.dispose();
                    result.success(null);
                    break;
                default:
                    result.notImplemented();
            }
        } catch (Exception e) {
            result.error(e.getClass().getSimpleName(), e.getMessage(),
                    e.getCause());
        }
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        initPipController(binding);
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        // do nothing
    }

    @Override
    public void onReattachedToActivityForConfigChanges(
            @NonNull ActivityPluginBinding binding) {
        initPipController(binding);
    }

    @Override
    public void onDetachedFromActivity() {
        // do nothing
    }
}
