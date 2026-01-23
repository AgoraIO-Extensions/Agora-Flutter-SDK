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
import java.util.Locale;
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
                    final Map<String, Object> args = safeCastToMap(call.arguments);
                    Rational aspectRatio = null;
                    if (args.get("aspectRatioX") != null &&
                            args.get("aspectRatioY") != null) {
                        aspectRatio = new Rational(getIntValue(args, "aspectRatioX", 0),
                                getIntValue(args, "aspectRatioY", 0));
                    }
                    Boolean autoEnterEnabled = null;
                    if (args.get("autoEnterEnabled") != null) {
                        autoEnterEnabled = getBooleanValue(args, "autoEnterEnabled", false);
                    }
                    Rect sourceRectHint = null;
                    if (args.get("sourceRectHintLeft") != null &&
                            args.get("sourceRectHintTop") != null &&
                            args.get("sourceRectHintRight") != null &&
                            args.get("sourceRectHintBottom") != null) {
                        sourceRectHint =
                                new Rect(getIntValue(args, "sourceRectHintLeft", 0),
                                        getIntValue(args, "sourceRectHintTop", 0),
                                        getIntValue(args, "sourceRectHintRight", 0),
                                        getIntValue(args, "sourceRectHintBottom", 0));
                    }
                    Boolean seamlessResizeEnabled = null;
                    if (args.get("seamlessResizeEnabled") != null) {
                        seamlessResizeEnabled = getBooleanValue(args, "seamlessResizeEnabled", false);
                    }
                    Boolean useExternalStateMonitor = null;
                    if (args.get("useExternalStateMonitor") != null) {
                        useExternalStateMonitor = getBooleanValue(args, "useExternalStateMonitor", false);
                    }
                    Integer externalStateMonitorInterval = null;
                    if (args.get("externalStateMonitorInterval") != null) {
                        externalStateMonitorInterval = getIntValue(args, "externalStateMonitorInterval", 0);
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

    /**
     * Safely get int value from Map, avoiding NullPointerException
     */
    private int getIntValue(Map<String, Object> args, String key, int defaultValue) {
        Object value = args.get(key);
        if (value == null) {
            return defaultValue;
        }
        if (value instanceof Number) {
            return ((Number) value).intValue();
        }
        return defaultValue;
    }

    /**
     * Safely get long value from Map, avoiding NullPointerException
     */
    private long getLongValue(Map<String, Object> args, String key, long defaultValue) {
        Object value = args.get(key);
        if (value == null) {
            return defaultValue;
        }
        if (value instanceof Number) {
            return ((Number) value).longValue();
        }
        return defaultValue;
    }

    /**
     * Safely get boolean value from Map, avoiding NullPointerException
     */
    private boolean getBooleanValue(Map<String, Object> args, String key, boolean defaultValue) {
        Object value = args.get(key);
        if (value == null) {
            return defaultValue;
        }
        if (value instanceof Boolean) {
            return (Boolean) value;
        }
        return defaultValue;
    }

    /**
     * Safely cast Object to Map<String, Object>, avoiding ClassCastException
     */
    @SuppressWarnings("unchecked")
    private Map<String, Object> safeCastToMap(Object obj) {
        if (obj instanceof Map) {
            return (Map<String, Object>) obj;
        }
        return new HashMap<>();
    }

    private void handleRteMethodCall(@NonNull MethodCall call,
                                     @NonNull MethodChannel.Result result) {
        if (rteController == null) {
            result.error("RTE_ERROR", "RTE Controller not initialized", null);
            return;
        }

        try {
            final Map<String, Object> args = safeCastToMap(call.arguments);
            
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
                case "rteGetUseStringUid":
                    result.success(rteController.useStringUid());
                    break;
                case "rteSetAppId":
                    String appId = (String) args.get("appId");
                    result.success(rteController.setAppId(appId));
                    break;
                case "rteSetLogFolder":
                    String logFolder = (String) args.get("logFolder");
                    result.success(rteController.setLogFolder(logFolder));
                    break;
                case "rteSetLogFileSize":
                    int logFileSize = getIntValue(args, "logFileSize", 0);
                    result.success(rteController.setLogFileSize(logFileSize));
                    break;
                case "rteSetAreaCode":
                    int areaCode = getIntValue(args, "areaCode", 0);
                    result.success(rteController.setAreaCode(areaCode));
                    break;
                case "rteSetCloudProxy":
                    String cloudProxy = (String) args.get("cloudProxy");
                    result.success(rteController.setCloudProxy(cloudProxy));
                    break;
                case "rteSetJsonParameter":
                    String jsonParameter = (String) args.get("jsonParameter");
                    result.success(rteController.setJsonParameter(jsonParameter));
                    break;
                case "rteSetUseStringUid":
                    Object useStringUidObj = args.get("useStringUid");
                    boolean useStringUid = useStringUidObj instanceof Boolean ? 
                        ((Boolean) useStringUidObj) : false;
                    result.success(rteController.setUseStringUid(useStringUid));
                    break;
                case "rtePlayerCreate":
                    String playerId = rteController.createPlayer(args);
                    result.success(playerId != null ? playerId : "player_" + System.currentTimeMillis());
                    break;
                case "rtePlayerDestroy":
                    String playerIdForDestroy = (String) args.get("playerId");
                    result.success(rteController.destroyPlayer(playerIdForDestroy));
                    break;
                case "rteCanvasCreate":
                    String canvasId = rteController.createCanvas(args);
                    result.success(canvasId != null ? canvasId : "canvas_" + System.currentTimeMillis());
                    break;
                case "rteCanvasDestroy":
                    String canvasIdForDestroy = (String) args.get("canvasId");
                    result.success(rteController.destroyCanvas(canvasIdForDestroy));
                    break;
                case "rtePlayerOpenUrl":
                    String playerIdForOpen = (String) args.get("playerId");
                    String url = (String) args.get("url");
                    long startTime = getLongValue(args, "startTime", 0);
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
                    long position = getLongValue(args, "position", 0);
                    result.success(rteController.playerSeek(playerIdForSeek, position));
                    break;
                case "rtePlayerMuteAudio":
                    String playerIdForMuteAudio = (String) args.get("playerId");
                    boolean muteAudio = getBooleanValue(args, "mute", false);
                    result.success(rteController.playerMuteAudio(playerIdForMuteAudio, muteAudio));
                    break;
                case "rtePlayerMuteVideo":
                    String playerIdForMuteVideo = (String) args.get("playerId");
                    boolean muteVideo = getBooleanValue(args, "mute", false);
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
                                errorMsg = String.format(Locale.US, "RTE Error (code: %d, message: %s)", code, message);
                            } else {
                                errorMsg = String.format(Locale.US, "RTE Error (code: %d)", code);
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
                    Map<String, Object> playerConfig = safeCastToMap(args.get("config"));
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
                    Map<String, Object> canvasConfig = safeCastToMap(args.get("config"));
                    result.success(rteController.canvasSetConfig(canvasIdForSetConfig, canvasConfig));
                    break;
                case "rteCanvasGetConfigs":
                    rteController.canvasGetConfig((String) args.get("canvasId"), result);
                    break;
                case "rtePlayerOpenWithCustomSourceProvider":
                    String playerIdForCustomProvider = (String) args.get("playerId");
                    long provider = getLongValue(args, "provider", 0);
                    long startTimeForCustom = getLongValue(args, "startTime", 0);
                    rteController.playerOpenWithCustomSourceProvider(playerIdForCustomProvider, provider, startTimeForCustom, result);
                    break;
                case "rtePlayerOpenWithStream":
                    String playerIdForStream = (String) args.get("playerId");
                    long stream = getLongValue(args, "stream", 0);
                    rteController.playerOpenWithStream(playerIdForStream, stream, result);
                    break;
                case "rtePlayerSwitchWithUrl":
                    String playerIdForSwitch = (String) args.get("playerId");
                    String switchUrl = (String) args.get("url");
                    boolean syncPts = getBooleanValue(args, "syncPts", false);
                    result.success(rteController.playerSwitch(playerIdForSwitch, switchUrl, syncPts));
                    break;
                case "rteCanvasAddView":
                    String canvasIdForAddView = (String) args.get("canvasId");
                    long viewPtrForAdd = getLongValue(args, "viewPtr", 0);
                    Map<String, Object> configForAddView = safeCastToMap(args.get("config"));
                    result.success(rteController.canvasAddView(canvasIdForAddView, viewPtrForAdd, configForAddView));
                    break;
                case "rteCanvasRemoveView":
                    String canvasIdForRemoveView = (String) args.get("canvasId");
                    long viewPtrForRemove = getLongValue(args, "viewPtr", 0);
                    Map<String, Object> configForRemoveView = safeCastToMap(args.get("config"));
                    result.success(rteController.canvasRemoveView(canvasIdForRemoveView, viewPtrForRemove, configForRemoveView));
                    break;
                case "rtePlayerGetAutoPlay":
                    result.success(rteController.playerGetAutoPlay((String) args.get("playerId")));
                    break;
                case "rtePlayerSetAutoPlay":
                    String playerIdForAutoPlay = (String) args.get("playerId");
                    boolean autoPlay = getBooleanValue(args, "autoPlay", false);
                    result.success(rteController.playerSetAutoPlay(playerIdForAutoPlay, autoPlay));
                    break;
                case "rtePlayerGetPlaybackSpeed":
                    result.success(rteController.playerGetPlaybackSpeed((String) args.get("playerId")));
                    break;
                case "rtePlayerSetPlaybackSpeed":
                    String playerIdForSpeed = (String) args.get("playerId");
                    int speed = getIntValue(args, "speed", 0);
                    result.success(rteController.playerSetPlaybackSpeed(playerIdForSpeed, speed));
                    break;
                case "rtePlayerGetPlayoutAudioTrackIdx":
                    result.success(rteController.playerGetPlayoutAudioTrackIdx((String) args.get("playerId")));
                    break;
                case "rtePlayerSetPlayoutAudioTrackIdx":
                    String playerIdForPlayoutTrack = (String) args.get("playerId");
                    int playoutTrackIdx = getIntValue(args, "idx", 0);
                    result.success(rteController.playerSetPlayoutAudioTrackIdx(playerIdForPlayoutTrack, playoutTrackIdx));
                    break;
                case "rtePlayerGetPublishAudioTrackIdx":
                    result.success(rteController.playerGetPublishAudioTrackIdx((String) args.get("playerId")));
                    break;
                case "rtePlayerSetPublishAudioTrackIdx":
                    String playerIdForPublishTrack = (String) args.get("playerId");
                    int publishTrackIdx = getIntValue(args, "idx", 0);
                    result.success(rteController.playerSetPublishAudioTrackIdx(playerIdForPublishTrack, publishTrackIdx));
                    break;
                case "rtePlayerGetAudioTrackIdx":
                    result.success(rteController.playerGetAudioTrackIdx((String) args.get("playerId")));
                    break;
                case "rtePlayerSetAudioTrackIdx":
                    String playerIdForAudioTrack = (String) args.get("playerId");
                    int audioTrackIdx = getIntValue(args, "idx", 0);
                    result.success(rteController.playerSetAudioTrackIdx(playerIdForAudioTrack, audioTrackIdx));
                    break;
                case "rtePlayerGetSubtitleTrackIdx":
                    result.success(rteController.playerGetSubtitleTrackIdx((String) args.get("playerId")));
                    break;
                case "rtePlayerSetSubtitleTrackIdx":
                    String playerIdForSubtitleTrack = (String) args.get("playerId");
                    int subtitleTrackIdx = getIntValue(args, "idx", 0);
                    result.success(rteController.playerSetSubtitleTrackIdx(playerIdForSubtitleTrack, subtitleTrackIdx));
                    break;
                case "rtePlayerGetExternalSubtitleTrackIdx":
                    result.success(rteController.playerGetExternalSubtitleTrackIdx((String) args.get("playerId")));
                    break;
                case "rtePlayerSetExternalSubtitleTrackIdx":
                    String playerIdForExtSubtitleTrack = (String) args.get("playerId");
                    int extSubtitleTrackIdx = getIntValue(args, "idx", 0);
                    result.success(rteController.playerSetExternalSubtitleTrackIdx(playerIdForExtSubtitleTrack, extSubtitleTrackIdx));
                    break;
                case "rtePlayerGetAudioPitch":
                    result.success(rteController.playerGetAudioPitch((String) args.get("playerId")));
                    break;
                case "rtePlayerSetAudioPitch":
                    String playerIdForPitch = (String) args.get("playerId");
                    int pitch = getIntValue(args, "pitch", 0);
                    result.success(rteController.playerSetAudioPitch(playerIdForPitch, pitch));
                    break;
                case "rtePlayerGetPlayoutVolume":
                    result.success(rteController.playerGetPlayoutVolume((String) args.get("playerId")));
                    break;
                case "rtePlayerSetPlayoutVolume":
                    String playerIdForPlayoutVolume = (String) args.get("playerId");
                    int playoutVolume = getIntValue(args, "volume", 0);
                    result.success(rteController.playerSetPlayoutVolume(playerIdForPlayoutVolume, playoutVolume));
                    break;
                case "rtePlayerGetAudioPlaybackDelay":
                    result.success(rteController.playerGetAudioPlaybackDelay((String) args.get("playerId")));
                    break;
                case "rtePlayerSetAudioPlaybackDelay":
                    String playerIdForDelay = (String) args.get("playerId");
                    int delay = getIntValue(args, "delay", 0);
                    result.success(rteController.playerSetAudioPlaybackDelay(playerIdForDelay, delay));
                    break;
                case "rtePlayerGetAudioDualMonoMode":
                    result.success(rteController.playerGetAudioDualMonoMode((String) args.get("playerId")));
                    break;
                case "rtePlayerSetAudioDualMonoMode":
                    String playerIdForDualMono = (String) args.get("playerId");
                    int dualMonoMode = getIntValue(args, "mode", 0);
                    result.success(rteController.playerSetAudioDualMonoMode(playerIdForDualMono, dualMonoMode));
                    break;
                case "rtePlayerGetPublishVolume":
                    result.success(rteController.playerGetPublishVolume((String) args.get("playerId")));
                    break;
                case "rtePlayerSetPublishVolume":
                    String playerIdForPublishVolume = (String) args.get("playerId");
                    int publishVolume = getIntValue(args, "volume", 0);
                    result.success(rteController.playerSetPublishVolume(playerIdForPublishVolume, publishVolume));
                    break;
                case "rtePlayerGetLoopCount":
                    result.success(rteController.playerGetLoopCount((String) args.get("playerId")));
                    break;
                case "rtePlayerSetLoopCount":
                    String playerIdForLoopCount = (String) args.get("playerId");
                    int loopCount = getIntValue(args, "count", 0);
                    result.success(rteController.playerSetLoopCount(playerIdForLoopCount, loopCount));
                    break;
                case "rtePlayerGetJsonParameter":
                    result.success(rteController.playerGetJsonParameter((String) args.get("playerId")));
                    break;
                case "rtePlayerSetJsonParameter":
                    String playerIdForJsonParam = (String) args.get("playerId");
                    String playerJsonParameter = (String) args.get("jsonParameter");
                    result.success(rteController.playerSetJsonParameter(playerIdForJsonParam, playerJsonParameter));
                    break;
                case "rtePlayerGetAbrSubscriptionLayer":
                    result.success(rteController.playerGetAbrSubscriptionLayer((String) args.get("playerId")));
                    break;
                case "rtePlayerSetAbrSubscriptionLayer":
                    String playerIdForAbrSub = (String) args.get("playerId");
                    int abrSubLayer = getIntValue(args, "layer", 0);
                    result.success(rteController.playerSetAbrSubscriptionLayer(playerIdForAbrSub, abrSubLayer));
                    break;
                case "rtePlayerGetAbrFallbackLayer":
                    result.success(rteController.playerGetAbrFallbackLayer((String) args.get("playerId")));
                    break;
                case "rtePlayerSetAbrFallbackLayer":
                    String playerIdForAbrFallback = (String) args.get("playerId");
                    int abrFallbackLayer = getIntValue(args, "layer", 0);
                    result.success(rteController.playerSetAbrFallbackLayer(playerIdForAbrFallback, abrFallbackLayer));
                    break;
                // Canvas Individual Config Methods
                case "rteCanvasGetVideoRenderMode":
                    result.success(rteController.canvasGetVideoRenderMode((String) args.get("canvasId")));
                    break;
                case "rteCanvasSetVideoRenderMode":
                    String canvasIdForRenderMode = (String) args.get("canvasId");
                    int renderMode = getIntValue(args, "mode", 0);
                    result.success(rteController.canvasSetVideoRenderMode(canvasIdForRenderMode, renderMode));
                    break;
                case "rteCanvasGetVideoMirrorMode":
                    result.success(rteController.canvasGetVideoMirrorMode((String) args.get("canvasId")));
                    break;
                case "rteCanvasSetVideoMirrorMode":
                    String canvasIdForMirrorMode = (String) args.get("canvasId");
                    int mirrorMode = getIntValue(args, "mode", 0);
                    result.success(rteController.canvasSetVideoMirrorMode(canvasIdForMirrorMode, mirrorMode));
                    break;
                case "rteCanvasGetCropArea":
                    result.success(rteController.canvasGetCropArea((String) args.get("canvasId")));
                    break;
                case "rteCanvasSetCropArea":
                    String canvasIdForCrop = (String) args.get("canvasId");
                    int x = getIntValue(args, "x", 0);
                    int y = getIntValue(args, "y", 0);
                    int width = getIntValue(args, "width", 0);
                    int height = getIntValue(args, "height", 0);
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
