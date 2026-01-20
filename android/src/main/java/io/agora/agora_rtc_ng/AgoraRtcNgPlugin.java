package io.agora.agora_rtc_ng;

import android.app.Activity;
import android.content.Context;
import android.graphics.Rect;
import android.os.Build;
import android.util.Rational;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import io.agora.iris.pip.AgoraPIPActivityProxy;
import io.agora.iris.pip.AgoraPIPController;
import io.agora.rte.Constants;
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
    private AgoraRteController rteController;
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
        
        rteController = new AgoraRteController(applicationContext, channel, videoViewController);
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
        } else if (call.method.startsWith("rte")) {
            handleRteMethodCall(call, result);
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
                                AgoraPIPController.PIPState state, String error) {
                            // put state into a json object
                            channel.invokeMethod("pipStateChanged",
                                    new HashMap<String, Object>() {
                                        {
                                            put("state", state.getValue());
                                            put("error", error != null ? error : "");
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

    private void handleRteMethodCall(@NonNull MethodCall call,
                                     @NonNull MethodChannel.Result result) {
        if (rteController == null) {
            result.error("RTE_ERROR", "RTE Controller not initialized", null);
            return;
        }

        try {
            final Map<String, Object> args = call.arguments instanceof Map ? 
                (Map<String, Object>) call.arguments : new HashMap<>();
            
            switch (call.method) {
                case "rteCreateFromBridge":
                    result.success(rteController.createRteFromBridge());
                    break;
                case "rteCreateWithConfig":
                    result.success(rteController.createRteWithConfig(args));
                    break;
                case "rteInitMediaEngine":
                    result.success(rteController.initMediaEngine());
                    break;
                case "rteDestroy":
                    rteController.destroyRte();
                    result.success(null);
                    break;
                case "rteSetConfigs":
                    result.success(rteController.setRteConfig(args));
                    break;
                case "rteGetConfigs":
                    result.success(rteController.getRteConfig());
                    break;
                case "rteGetAppId":
                    result.success(rteController.appId());
                    break;
                case "rteGetLogFolder":
                    result.success(rteController.logFolder());
                    break;
                case "rteGetLogFileSize":
                    result.success(rteController.logFileSize());
                    break;
                case "rteGetAreaCode":
                    result.success(rteController.areaCode());
                    break;
                case "rteGetCloudProxy":
                    result.success(rteController.cloudProxy());
                    break;
                case "rteGetJsonParameter":
                    result.success(rteController.jsonParameter());
                    break;
                case "rteRegisterObserver":
                    result.success(rteController.registerRteObserver());
                    break;
                case "rteUnregisterObserver":
                    result.success(rteController.unregisterRteObserver());
                    break;
                case "rtePlayerCreate":
                    String playerId = rteController.createPlayer(args);
                    result.success(playerId != null ? playerId : "player_" + System.currentTimeMillis());
                    break;
                case "rteCanvasCreate":
                    String canvasId = rteController.createCanvas(args);
                    result.success(canvasId != null ? canvasId : "canvas_" + System.currentTimeMillis());
                    break;
                case "rtePlayerOpenUrl":
                    String playerIdForOpen = (String) args.get("playerId");
                    String url = (String) args.get("url");
                    long startTime = args.get("startTime") != null ? 
                        ((Number) args.get("startTime")).longValue() : 0;
                    result.success(rteController.playerOpenUrl(playerIdForOpen, url, startTime));
                    break;
                case "rtePlayerPlay":
                    result.success(rteController.playerPlay((String) args.get("playerId")));
                    break;
                case "rtePlayerStop":
                    result.success(rteController.playerStop((String) args.get("playerId")));
                    break;
                case "rtePlayerPause":
                    result.success(rteController.playerPause((String) args.get("playerId")));
                    break;
                case "rtePlayerSeek":
                    String playerIdForSeek = (String) args.get("playerId");
                    long position = ((Number) args.get("position")).longValue();
                    result.success(rteController.playerSeek(playerIdForSeek, position));
                    break;
                case "rtePlayerMuteAudio":
                    String playerIdForMuteAudio = (String) args.get("playerId");
                    boolean muteAudio = (boolean) args.get("mute");
                    result.success(rteController.playerMuteAudio(playerIdForMuteAudio, muteAudio));
                    break;
                case "rtePlayerMuteVideo":
                    String playerIdForMuteVideo = (String) args.get("playerId");
                    boolean muteVideo = (boolean) args.get("mute");
                    result.success(rteController.playerMuteVideo(playerIdForMuteVideo, muteVideo));
                    break;
                case "rtePlayerGetCurrentTime":
                    result.success(rteController.playerGetCurrentTime((String) args.get("playerId")));
                    break;
                case "rtePlayerGetInfo":
                    result.success(rteController.playerGetInfo((String) args.get("playerId")));
                    break;
                case "rtePlayerGetStats":
                    String playerIdForStats = (String) args.get("playerId");
                    rteController.playerGetStats(playerIdForStats, (stats, err) -> {
                        if (err != null) {
                            int code = Constants.ErrorCode.getValue(err.code());
                            String message = err.message();
                            String errorMsg;
                            if (message != null && !message.isEmpty()) {
                                errorMsg = String.format("RTE Error (code: %d, message: %s)", code, message);
                            } else {
                                errorMsg = String.format("RTE Error (code: %d)", code);
                            }
                            result.error("RTE_ERROR", errorMsg, null);
                        } else if (stats != null) {
                            result.success(stats);
                        } else {
                            result.error("RTE_ERROR", "RTE player not initialized or stats unavailable", null);
                        }
                    });
                    break;
                case "rtePlayerSetCanvas":
                    String playerIdForCanvas = (String) args.get("playerId");
                    String canvasIdForPlayer = (String) args.get("canvasId");
                    result.success(rteController.playerSetCanvas(playerIdForCanvas, canvasIdForPlayer));
                    break;
                case "rtePlayerSetConfigs":
                    String playerIdForSetConfig = (String) args.get("playerId");
                    Map<String, Object> playerConfig = (Map<String, Object>) args.get("config");
                    result.success(rteController.playerSetConfig(playerIdForSetConfig, playerConfig));
                    break;
                case "rtePlayerGetConfigs":
                    result.success(rteController.playerGetConfig((String) args.get("playerId")));
                    break;
                case "rtePlayerRegisterObserver":
                    result.success(rteController.playerRegisterObserver((String) args.get("playerId")));
                    break;
                case "rtePlayerUnregisterObserver":
                    result.success(rteController.playerUnregisterObserver((String) args.get("playerId")));
                    break;
                case "rteCanvasSetConfigs":
                    String canvasIdForSetConfig = (String) args.get("canvasId");
                    Map<String, Object> canvasConfig = (Map<String, Object>) args.get("config");
                    result.success(rteController.canvasSetConfig(canvasIdForSetConfig, canvasConfig));
                    break;
                case "rteCanvasGetConfigs":
                    rteController.canvasGetConfig((String) args.get("canvasId"), result);
                    break;
                case "rtePlayerOpenWithCustomSourceProvider":
                    String playerIdForCustomProvider = (String) args.get("playerId");
                    long provider = args.get("provider") != null ? 
                        ((Number) args.get("provider")).longValue() : 0;
                    long startTimeForCustom = args.get("startTime") != null ? 
                        ((Number) args.get("startTime")).longValue() : 0;
                    rteController.playerOpenWithCustomSourceProvider(playerIdForCustomProvider, provider, startTimeForCustom, result);
                    break;
                case "rtePlayerOpenWithStream":
                    String playerIdForStream = (String) args.get("playerId");
                    long stream = args.get("stream") != null ? 
                        ((Number) args.get("stream")).longValue() : 0;
                    rteController.playerOpenWithStream(playerIdForStream, stream, result);
                    break;
                case "rtePlayerSwitchWithUrl":
                    String playerIdForSwitch = (String) args.get("playerId");
                    String switchUrl = (String) args.get("url");
                    boolean syncPts = args.get("syncPts") != null ? 
                        (boolean) args.get("syncPts") : false;
                    result.success(rteController.playerSwitch(playerIdForSwitch, switchUrl, syncPts));
                    break;
                case "rteCanvasAddView":
                    String canvasIdForAddView = (String) args.get("canvasId");
                    long viewPtrForAdd = args.get("viewPtr") != null ? 
                        ((Number) args.get("viewPtr")).longValue() : 0;
                    Map<String, Object> configForAddView = args.get("config") != null ? 
                        (Map<String, Object>) args.get("config") : new HashMap<>();
                    result.success(rteController.canvasAddView(canvasIdForAddView, viewPtrForAdd, configForAddView));
                    break;
                case "rteCanvasRemoveView":
                    String canvasIdForRemoveView = (String) args.get("canvasId");
                    long viewPtrForRemove = args.get("viewPtr") != null ? 
                        ((Number) args.get("viewPtr")).longValue() : 0;
                    Map<String, Object> configForRemoveView = args.get("config") != null ? 
                        (Map<String, Object>) args.get("config") : new HashMap<>();
                    result.success(rteController.canvasRemoveView(canvasIdForRemoveView, viewPtrForRemove, configForRemoveView));
                    break;
                // Player Individual Config Methods
                case "rtePlayerGetAutoPlay":
                    result.success(rteController.playerGetAutoPlay((String) args.get("playerId")));
                    break;
                case "rtePlayerSetAutoPlay":
                    String playerIdForAutoPlay = (String) args.get("playerId");
                    boolean autoPlay = args.get("autoPlay") != null ? 
                        ((Boolean) args.get("autoPlay")) : false;
                    result.success(rteController.playerSetAutoPlay(playerIdForAutoPlay, autoPlay));
                    break;
                case "rtePlayerGetPlaybackSpeed":
                    result.success(rteController.playerGetPlaybackSpeed((String) args.get("playerId")));
                    break;
                case "rtePlayerSetPlaybackSpeed":
                    String playerIdForSpeed = (String) args.get("playerId");
                    int speed = args.get("speed") != null ? 
                        ((Number) args.get("speed")).intValue() : 0;
                    result.success(rteController.playerSetPlaybackSpeed(playerIdForSpeed, speed));
                    break;
                case "rtePlayerGetPlayoutAudioTrackIdx":
                    result.success(rteController.playerGetPlayoutAudioTrackIdx((String) args.get("playerId")));
                    break;
                case "rtePlayerSetPlayoutAudioTrackIdx":
                    String playerIdForPlayoutTrack = (String) args.get("playerId");
                    int playoutTrackIdx = args.get("idx") != null ? 
                        ((Number) args.get("idx")).intValue() : 0;
                    result.success(rteController.playerSetPlayoutAudioTrackIdx(playerIdForPlayoutTrack, playoutTrackIdx));
                    break;
                case "rtePlayerGetPublishAudioTrackIdx":
                    result.success(rteController.playerGetPublishAudioTrackIdx((String) args.get("playerId")));
                    break;
                case "rtePlayerSetPublishAudioTrackIdx":
                    String playerIdForPublishTrack = (String) args.get("playerId");
                    int publishTrackIdx = args.get("idx") != null ? 
                        ((Number) args.get("idx")).intValue() : 0;
                    result.success(rteController.playerSetPublishAudioTrackIdx(playerIdForPublishTrack, publishTrackIdx));
                    break;
                case "rtePlayerGetAudioTrackIdx":
                    result.success(rteController.playerGetAudioTrackIdx((String) args.get("playerId")));
                    break;
                case "rtePlayerSetAudioTrackIdx":
                    String playerIdForAudioTrack = (String) args.get("playerId");
                    int audioTrackIdx = args.get("idx") != null ? 
                        ((Number) args.get("idx")).intValue() : 0;
                    result.success(rteController.playerSetAudioTrackIdx(playerIdForAudioTrack, audioTrackIdx));
                    break;
                case "rtePlayerGetSubtitleTrackIdx":
                    result.success(rteController.playerGetSubtitleTrackIdx((String) args.get("playerId")));
                    break;
                case "rtePlayerSetSubtitleTrackIdx":
                    String playerIdForSubtitleTrack = (String) args.get("playerId");
                    int subtitleTrackIdx = args.get("idx") != null ? 
                        ((Number) args.get("idx")).intValue() : 0;
                    result.success(rteController.playerSetSubtitleTrackIdx(playerIdForSubtitleTrack, subtitleTrackIdx));
                    break;
                case "rtePlayerGetExternalSubtitleTrackIdx":
                    result.success(rteController.playerGetExternalSubtitleTrackIdx((String) args.get("playerId")));
                    break;
                case "rtePlayerSetExternalSubtitleTrackIdx":
                    String playerIdForExtSubtitleTrack = (String) args.get("playerId");
                    int extSubtitleTrackIdx = args.get("idx") != null ? 
                        ((Number) args.get("idx")).intValue() : 0;
                    result.success(rteController.playerSetExternalSubtitleTrackIdx(playerIdForExtSubtitleTrack, extSubtitleTrackIdx));
                    break;
                case "rtePlayerGetAudioPitch":
                    result.success(rteController.playerGetAudioPitch((String) args.get("playerId")));
                    break;
                case "rtePlayerSetAudioPitch":
                    String playerIdForPitch = (String) args.get("playerId");
                    int pitch = args.get("pitch") != null ? 
                        ((Number) args.get("pitch")).intValue() : 0;
                    result.success(rteController.playerSetAudioPitch(playerIdForPitch, pitch));
                    break;
                case "rtePlayerGetPlayoutVolume":
                    result.success(rteController.playerGetPlayoutVolume((String) args.get("playerId")));
                    break;
                case "rtePlayerSetPlayoutVolume":
                    String playerIdForPlayoutVolume = (String) args.get("playerId");
                    int playoutVolume = args.get("volume") != null ? 
                        ((Number) args.get("volume")).intValue() : 0;
                    result.success(rteController.playerSetPlayoutVolume(playerIdForPlayoutVolume, playoutVolume));
                    break;
                case "rtePlayerGetAudioPlaybackDelay":
                    result.success(rteController.playerGetAudioPlaybackDelay((String) args.get("playerId")));
                    break;
                case "rtePlayerSetAudioPlaybackDelay":
                    String playerIdForDelay = (String) args.get("playerId");
                    int delay = args.get("delay") != null ? 
                        ((Number) args.get("delay")).intValue() : 0;
                    result.success(rteController.playerSetAudioPlaybackDelay(playerIdForDelay, delay));
                    break;
                case "rtePlayerGetAudioDualMonoMode":
                    result.success(rteController.playerGetAudioDualMonoMode((String) args.get("playerId")));
                    break;
                case "rtePlayerSetAudioDualMonoMode":
                    String playerIdForDualMono = (String) args.get("playerId");
                    int dualMonoMode = args.get("mode") != null ? 
                        ((Number) args.get("mode")).intValue() : 0;
                    result.success(rteController.playerSetAudioDualMonoMode(playerIdForDualMono, dualMonoMode));
                    break;
                case "rtePlayerGetPublishVolume":
                    result.success(rteController.playerGetPublishVolume((String) args.get("playerId")));
                    break;
                case "rtePlayerSetPublishVolume":
                    String playerIdForPublishVolume = (String) args.get("playerId");
                    int publishVolume = args.get("volume") != null ? 
                        ((Number) args.get("volume")).intValue() : 0;
                    result.success(rteController.playerSetPublishVolume(playerIdForPublishVolume, publishVolume));
                    break;
                case "rtePlayerGetLoopCount":
                    result.success(rteController.playerGetLoopCount((String) args.get("playerId")));
                    break;
                case "rtePlayerSetLoopCount":
                    String playerIdForLoopCount = (String) args.get("playerId");
                    int loopCount = args.get("count") != null ? 
                        ((Number) args.get("count")).intValue() : 0;
                    result.success(rteController.playerSetLoopCount(playerIdForLoopCount, loopCount));
                    break;
                case "rtePlayerGetJsonParameter":
                    result.success(rteController.playerGetJsonParameter((String) args.get("playerId")));
                    break;
                case "rtePlayerSetJsonParameter":
                    String playerIdForJsonParam = (String) args.get("playerId");
                    String jsonParameter = (String) args.get("jsonParameter");
                    result.success(rteController.playerSetJsonParameter(playerIdForJsonParam, jsonParameter));
                    break;
                case "rtePlayerGetAbrSubscriptionLayer":
                    result.success(rteController.playerGetAbrSubscriptionLayer((String) args.get("playerId")));
                    break;
                case "rtePlayerSetAbrSubscriptionLayer":
                    String playerIdForAbrSub = (String) args.get("playerId");
                    int abrSubLayer = args.get("layer") != null ? 
                        ((Number) args.get("layer")).intValue() : 0;
                    result.success(rteController.playerSetAbrSubscriptionLayer(playerIdForAbrSub, abrSubLayer));
                    break;
                case "rtePlayerGetAbrFallbackLayer":
                    result.success(rteController.playerGetAbrFallbackLayer((String) args.get("playerId")));
                    break;
                case "rtePlayerSetAbrFallbackLayer":
                    String playerIdForAbrFallback = (String) args.get("playerId");
                    int abrFallbackLayer = args.get("layer") != null ? 
                        ((Number) args.get("layer")).intValue() : 0;
                    result.success(rteController.playerSetAbrFallbackLayer(playerIdForAbrFallback, abrFallbackLayer));
                    break;
                // Canvas Individual Config Methods
                case "rteCanvasGetVideoRenderMode":
                    result.success(rteController.canvasGetVideoRenderMode((String) args.get("canvasId")));
                    break;
                case "rteCanvasSetVideoRenderMode":
                    String canvasIdForRenderMode = (String) args.get("canvasId");
                    int renderMode = args.get("mode") != null ? 
                        ((Number) args.get("mode")).intValue() : 0;
                    result.success(rteController.canvasSetVideoRenderMode(canvasIdForRenderMode, renderMode));
                    break;
                case "rteCanvasGetVideoMirrorMode":
                    result.success(rteController.canvasGetVideoMirrorMode((String) args.get("canvasId")));
                    break;
                case "rteCanvasSetVideoMirrorMode":
                    String canvasIdForMirrorMode = (String) args.get("canvasId");
                    int mirrorMode = args.get("mode") != null ? 
                        ((Number) args.get("mode")).intValue() : 0;
                    result.success(rteController.canvasSetVideoMirrorMode(canvasIdForMirrorMode, mirrorMode));
                    break;
                case "rteCanvasGetCropArea":
                    result.success(rteController.canvasGetCropArea((String) args.get("canvasId")));
                    break;
                case "rteCanvasSetCropArea":
                    String canvasIdForCrop = (String) args.get("canvasId");
                    int x = args.get("x") != null ? 
                        ((Number) args.get("x")).intValue() : 0;
                    int y = args.get("y") != null ? 
                        ((Number) args.get("y")).intValue() : 0;
                    int width = args.get("width") != null ? 
                        ((Number) args.get("width")).intValue() : 0;
                    int height = args.get("height") != null ? 
                        ((Number) args.get("height")).intValue() : 0;
                    result.success(rteController.canvasSetCropArea(canvasIdForCrop, x, y, width, height));
                    break;
                default:
                    result.notImplemented();
            }
        } catch (Exception e) {
            result.error("RTE_ERROR", e.getMessage(), e.getCause());
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
