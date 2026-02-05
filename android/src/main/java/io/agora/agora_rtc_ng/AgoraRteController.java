package io.agora.agora_rtc_ng;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.view.View;
import io.flutter.plugin.common.MethodChannel;

import java.util.HashMap;
import java.util.Map;

// Android RTE Java API uses simplified class names (Rte, Config, Player) instead of AgoraRte* prefix
import io.agora.rte.Rte;
import io.agora.rte.Config;
import io.agora.rte.Error;
import io.agora.rte.Canvas;
import io.agora.rte.Constants;
import io.agora.rte.callback.AsyncCallback;
import io.agora.rte.callback.PlayerGetStatsCallback;
import io.agora.rte.exception.RteException;

public class AgoraRteController {
    private final Context context;
    private final MethodChannel channel;
    private final Handler mainHandler;
    private final VideoViewController videoViewController;

    private AgoraRTE rte;
    private AgoraRTEPlayer rtePlayer;
    private AgoraRTECanvas rteCanvas;

    public AgoraRteController(Context context, MethodChannel channel, VideoViewController videoViewController) {
        this.context = context;
        this.channel = channel;
        this.videoViewController = videoViewController;
        this.mainHandler = new Handler(Looper.getMainLooper());
        
        // Initialize RTE instance (but not the config/player/canvas until RTE is created)
        this.rte = new AgoraRTE();
    }

    // --- RTE Lifecycle ---

    public boolean createRteFromBridge() {
        boolean success = rte.getFromBridge();
        if (success && rte.getRteInstance() != null) {
            rtePlayer = new AgoraRTEPlayer(rte.getRteInstance());
            rteCanvas = new AgoraRTECanvas(rte.getRteInstance());
            // Set up observer delegate bridge
            setupPlayerObserverDelegate();
        }
        return success;
    }

    public boolean createRteWithConfig(Map<String, Object> config) {
        boolean success = rte.createWithConfig(config);
        if (success && rte.getRteInstance() != null) {
            rtePlayer = new AgoraRTEPlayer(rte.getRteInstance());
            rteCanvas = new AgoraRTECanvas(rte.getRteInstance());
            // Set up observer delegate bridge
            setupPlayerObserverDelegate();
        }
        return success;
    }

    public boolean initMediaEngine() {
        if (rte == null || rte.getRteInstance() == null) {
            return false;
        }
        return rte.initMediaEngine(new AsyncCallback() {
            @Override
            public void onResult(Error error) {
                runOnMainThread(() -> {
                    Map<String, Object> args = new HashMap<>();
                    if (error == null) {
                        args.put("error", null);
                    } else {
                        args.put("error", error.message());
                    }
                    channel.invokeMethod("rteInitMediaEngineCallback", args);
                });
            }
        });
    }

    @SuppressWarnings("UnusedReturnValue")
    public void destroyRte() {
        try {
            // Destroy all players and canvases first
            if (rtePlayer != null) {
                for (String playerId : rtePlayer.getPlayers().keySet()) {
                    // Ignore return value during cleanup - continue even if some fail
                    destroyPlayer(playerId);
                }
            }
            if (rteCanvas != null) {
                for (String canvasId : rteCanvas.getCanvases().keySet()) {
                    // Ignore return value during cleanup - continue even if some fail
                    destroyCanvas(canvasId);
                }
            }
            if (rte != null) {
                rte.destroy();
            }
        } catch (Throwable t) {
            // Ignore - ensure we clear state in finally so next initMediaEngine() fails as expected
        } finally {
            if (rte != null) {
                rte.forceClearInstance();
            }
            rtePlayer = null;
            rteCanvas = null;
        }
    }

    private void setupPlayerObserverDelegate() {
        if (rtePlayer != null) {
            rtePlayer.setObserverDelegate(new AgoraRTEPlayerObserverDelegate() {
                @Override
                public void onStateChanged(String playerId, int oldState, int newState, int errorCode, String errorMessage) {
                    runOnMainThread(() -> {
                        Map<String, Object> args = new HashMap<>();
                        args.put("playerId", playerId);
                        args.put("oldState", oldState);
                        args.put("newState", newState);
                        args.put("errorCode", errorCode);
                        args.put("errorMessage", errorMessage);
                        channel.invokeMethod("rtePlayerOnStateChanged", args);
                    });
                }

                @Override
                public void onPositionChanged(String playerId, long currentTime, long utcTime) {
                    runOnMainThread(() -> {
                        Map<String, Object> args = new HashMap<>();
                        args.put("playerId", playerId);
                        args.put("currentTime", currentTime);
                        args.put("utcTime", utcTime);
                        channel.invokeMethod("rtePlayerOnPositionChanged", args);
                    });
                }

                @Override
                public void onResolutionChanged(String playerId, int width, int height) {
                    runOnMainThread(() -> {
                        Map<String, Object> args = new HashMap<>();
                        args.put("playerId", playerId);
                        args.put("width", width);
                        args.put("height", height);
                        channel.invokeMethod("rtePlayerOnResolutionChanged", args);
                    });
                }

                @Override
                public void onEvent(String playerId, int event) {
                    runOnMainThread(() -> {
                        Map<String, Object> args = new HashMap<>();
                        args.put("playerId", playerId);
                        args.put("event", event);
                        channel.invokeMethod("rtePlayerOnEvent", args);
                    });
                }

                @Override
                public void onMetadata(String playerId, int type, byte[] data) {
                    runOnMainThread(() -> {
                        Map<String, Object> args = new HashMap<>();
                        args.put("playerId", playerId);
                        args.put("type", type);
                        args.put("data", data);
                        channel.invokeMethod("rtePlayerOnMetadata", args);
                    });
                }

                @Override
                public void onPlayerInfoUpdated(String playerId, Map<String, Object> info) {
                    runOnMainThread(() -> {
                        Map<String, Object> args = new HashMap<>();
                        args.put("playerId", playerId);
                        args.put("info", info);
                        channel.invokeMethod("rtePlayerOnPlayerInfoUpdated", args);
                    });
                }

                @Override
                public void onAudioVolumeIndication(String playerId, int volume) {
                    runOnMainThread(() -> {
                        Map<String, Object> args = new HashMap<>();
                        args.put("playerId", playerId);
                        args.put("volume", volume);
                        channel.invokeMethod("rtePlayerOnAudioVolumeIndication", args);
                    });
                }
            });
        }
    }

    // --- RTE Config ---

    public boolean setRteConfig(Map<String, Object> config) {
        if (rte == null) {
            return false;
        }
        return rte.setConfigs(config);
    }

    public Map<String, Object> getRteConfig() {
        if (rte == null) {
            return null;
        }
        return rte.getConfigs();
    }

    public String appId() {
        if (rte == null || rte.getRteInstance() == null) {
            return "";
        }
        try {
            Config config = new Config();
            rte.getRteInstance().getConfigs(config);
            String appId = config.getAppId();
            return appId != null ? appId : "";
        } catch (RteException e) {
            return "";
        }
    }

    public String logFolder() {
        if (rte == null || rte.getRteInstance() == null) {
            return "";
        }
        try {
            Config config = new Config();
            rte.getRteInstance().getConfigs(config);
            String logFolder = config.getLogFolder();
            return logFolder != null ? logFolder : "";
        } catch (RteException e) {
            return "";
        }
    }

    public int logFileSize() {
        if (rte == null || rte.getRteInstance() == null) {
            return 0;
        }
        try {
            Config config = new Config();
            rte.getRteInstance().getConfigs(config);
            return config.getLogFileSize();
        } catch (RteException e) {
            return 0;
        }
    }

    public int areaCode() {
        if (rte == null || rte.getRteInstance() == null) {
            return 0;
        }
        try {
            Config config = new Config();
            rte.getRteInstance().getConfigs(config);
            return config.getAreaCode();
        } catch (RteException e) {
            return 0;
        }
    }

    public String cloudProxy() {
        if (rte == null || rte.getRteInstance() == null) {
            return "";
        }
        try {
            Config config = new Config();
            rte.getRteInstance().getConfigs(config);
            String cloudProxy = config.getCloudProxy();
            return cloudProxy != null ? cloudProxy : "";
        } catch (RteException e) {
            return "";
        }
    }

    public String jsonParameter() {
        if (rte == null || rte.getRteInstance() == null) {
            return "";
        }
        try {
            Config config = new Config();
            rte.getRteInstance().getConfigs(config);
            String jsonParameter = config.getJsonParameter();
            return jsonParameter != null ? jsonParameter : "";
        } catch (RteException e) {
            return "";
        }
    }

    public boolean useStringUid() {
        if (rte == null || rte.getRteInstance() == null) {
            return false;
        }
        try {
            Config config = new Config();
            rte.getRteInstance().getConfigs(config);
            return config.getUseStringUid();
        } catch (RteException e) {
            return false;
        }
    }

    // RTE Config Setters
    public boolean setAppId(String appId) {
        if (rte == null) {
            return false;
        }
        Map<String, Object> configMap = new HashMap<>();
        configMap.put("appId", appId);
        return rte.setConfigs(configMap);
    }

    public boolean setLogFolder(String logFolder) {
        if (rte == null) {
            return false;
        }
        Map<String, Object> configMap = new HashMap<>();
        configMap.put("logFolder", logFolder);
        return rte.setConfigs(configMap);
    }

    public boolean setLogFileSize(int logFileSize) {
        if (rte == null) {
            return false;
        }
        Map<String, Object> configMap = new HashMap<>();
        configMap.put("logFileSize", logFileSize);
        return rte.setConfigs(configMap);
    }

    public boolean setAreaCode(int areaCode) {
        if (rte == null) {
            return false;
        }
        Map<String, Object> configMap = new HashMap<>();
        configMap.put("areaCode", areaCode);
        return rte.setConfigs(configMap);
    }

    public boolean setCloudProxy(String cloudProxy) {
        if (rte == null) {
            return false;
        }
        Map<String, Object> configMap = new HashMap<>();
        configMap.put("cloudProxy", cloudProxy);
        return rte.setConfigs(configMap);
    }

    public boolean setJsonParameter(String jsonParameter) {
        if (rte == null) {
            return false;
        }
        Map<String, Object> configMap = new HashMap<>();
        configMap.put("jsonParameter", jsonParameter);
        return rte.setConfigs(configMap);
    }

    public boolean setUseStringUid(boolean useStringUid) {
        if (rte == null) {
            return false;
        }
        Map<String, Object> configMap = new HashMap<>();
        configMap.put("useStringUid", useStringUid);
        return rte.setConfigs(configMap);
    }
    // --- Player Lifecycle ---

    public String createPlayer(Map<String, Object> config) {
        if (rtePlayer == null) {
            return null;
        }
        return rtePlayer.createPlayer(config);
    }

    public boolean destroyPlayer(String playerId) {
        if (rtePlayer == null) {
            return false;
        }
        return rtePlayer.destroyPlayer(playerId);
    }

    // --- Player Control ---

    public boolean playerOpenUrl(String playerId, String url, long startTime) {
        if (rtePlayer == null) {
            return false;
        }
        final String pid = playerId;
        return rtePlayer.openUrl(playerId, url, startTime, new AsyncCallback() {
            @Override
            public void onResult(Error error) {
                if (error != null && error.code() != null && Constants.ErrorCode.getValue(error.code()) != 0) {
                    runOnMainThread(() -> {
                        Map<String, Object> args = new HashMap<>();
                        args.put("playerId", pid);
                        args.put("errorCode", Constants.ErrorCode.getValue(error.code()));
                        args.put("errorMessage", error.message() != null ? error.message() : "");
                        channel.invokeMethod("rtePlayerOpenUrlCallback", args);
                    });
                }
            }
        });
    }
    
    public void playerOpenWithCustomSourceProvider(String playerId, long provider, long startTime, MethodChannel.Result result) {
        // Custom source provider needs proper implementation
        result.notImplemented(); 
    }
    
    public void playerOpenWithStream(String playerId, long stream, MethodChannel.Result result) {
        // Stream opening needs proper implementation
        result.notImplemented();
    }

    public boolean playerPlay(String playerId) {
        if (rtePlayer == null) {
            return false;
        }
        return rtePlayer.play(playerId);
    }

    public boolean playerPause(String playerId) {
        if (rtePlayer == null) {
            return false;
        }
        return rtePlayer.pause(playerId);
    }

    public boolean playerStop(String playerId) {
        if (rtePlayer == null) {
            return false;
        }
        return rtePlayer.stop(playerId);
    }

    public boolean playerSeek(String playerId, long position) {
        if (rtePlayer == null) {
            return false;
        }
        return rtePlayer.seek(playerId, position);
    }

    public boolean playerMuteAudio(String playerId, boolean mute) {
        if (rtePlayer == null) {
            return false;
        }
        return rtePlayer.muteAudio(playerId, mute);
    }

    public boolean playerMuteVideo(String playerId, boolean mute) {
        if (rtePlayer == null) {
            return false;
        }
        return rtePlayer.muteVideo(playerId, mute);
    }
    
    public boolean playerSwitch(String playerId, String url, boolean syncPts) {
        if (rtePlayer == null) {
            return false;
        }
        return rtePlayer.switchWithUrl(playerId, url, syncPts, new AsyncCallback() {
            @Override
            public void onResult(Error error) {
                // Result handled by observer
            }
        });
    }

    public boolean playerPreloadWithUrl(String url) {
        return AgoraRTEPlayer.preloadWithUrl(url);
    }

    public long playerGetDuration(String playerId) {
        if (rtePlayer == null) {
            return 0;
        }
        return rtePlayer.getDuration(playerId);
    }

    public long playerGetCurrentTime(String playerId) {
        if (rtePlayer == null) {
            return 0;
        }
        return rtePlayer.getCurrentTime(playerId);
    }

    public Map<String, Object> playerGetInfo(String playerId) {
        if (rtePlayer == null) {
            return null;
        }
        return rtePlayer.getInfo(playerId);
    }

    public interface PlayerGetStatsResultCallback {
        void onResult(Map<String, Object> stats, Error error);
    }

    public void playerGetStats(String playerId, PlayerGetStatsResultCallback callback) {
        if (rtePlayer == null) {
            if (callback != null) {
                callback.onResult(null, null);
            }
            return;
        }
        rtePlayer.getStats(playerId, new PlayerGetStatsCallback() {
            @Override
            public void onResult(io.agora.rte.PlayerStats stats, Error error) {
                if (callback != null) {
                    if (error != null && error.code() != null && Constants.ErrorCode.getValue(error.code()) != 0) {
                        callback.onResult(null, error);
                    } else if (stats != null) {
                        Map<String, Object> statsMap = new HashMap<>();
                        try {
                            statsMap.put("videoDecodeFrameRate", stats.videoDecodeFrameRate());
                            statsMap.put("videoRenderFrameRate", stats.videoRenderFrameRate());
                            statsMap.put("videoBitrate", stats.videoBitrate());
                            statsMap.put("audioBitrate", stats.audioBitrate());
                        } catch (Exception e) {
                            // If any method throws exception, continue with partial data
                        }
                        callback.onResult(statsMap, null);
                    } else {
                        callback.onResult(null, null);
                    }
                }
            }
        });
    }

    public boolean playerSetConfig(String playerId, Map<String, Object> config) {
        if (rtePlayer == null) {
            return false;
        }
        return rtePlayer.setConfigs(playerId, config);
    }

    public Map<String, Object> playerGetConfig(String playerId) {
        if (rtePlayer == null) {
            return null;
        }
        return rtePlayer.getConfigs(playerId);
    }
    
    // --- Player Observer ---

    public boolean playerRegisterObserver(String playerId) {
        if (rtePlayer == null) {
            return false;
        }
        return rtePlayer.registerObserver(playerId);
    }

    public boolean playerUnregisterObserver(String playerId) {
        if (rtePlayer == null) {
            return false;
        }
        return rtePlayer.unregisterObserver(playerId);
    }

    // --- Player Individual Config Methods ---
    public boolean playerGetAutoPlay(String playerId) {
        if (rtePlayer == null) {
            return false;
        }
        return rtePlayer.getAutoPlay(playerId);
    }

    public boolean playerSetAutoPlay(String playerId, boolean autoPlay) {
        if (rtePlayer == null) {
            return false;
        }
        return rtePlayer.setAutoPlay(playerId, autoPlay);
    }

    public int playerGetPlaybackSpeed(String playerId) {
        if (rtePlayer == null) {
            return 0;
        }
        return rtePlayer.getPlaybackSpeed(playerId);
    }

    public boolean playerSetPlaybackSpeed(String playerId, int speed) {
        if (rtePlayer == null) {
            return false;
        }
        return rtePlayer.setPlaybackSpeed(playerId, speed);
    }

    public int playerGetPlayoutAudioTrackIdx(String playerId) {
        if (rtePlayer == null) {
            return 0;
        }
        return rtePlayer.getPlayoutAudioTrackIdx(playerId);
    }

    public boolean playerSetPlayoutAudioTrackIdx(String playerId, int idx) {
        if (rtePlayer == null) {
            return false;
        }
        return rtePlayer.setPlayoutAudioTrackIdx(playerId, idx);
    }

    public int playerGetPublishAudioTrackIdx(String playerId) {
        if (rtePlayer == null) {
            return 0;
        }
        return rtePlayer.getPublishAudioTrackIdx(playerId);
    }

    public boolean playerSetPublishAudioTrackIdx(String playerId, int idx) {
        if (rtePlayer == null) {
            return false;
        }
        return rtePlayer.setPublishAudioTrackIdx(playerId, idx);
    }

    public int playerGetAudioTrackIdx(String playerId) {
        if (rtePlayer == null) {
            return 0;
        }
        return rtePlayer.getAudioTrackIdx(playerId);
    }

    public boolean playerSetAudioTrackIdx(String playerId, int idx) {
        if (rtePlayer == null) {
            return false;
        }
        return rtePlayer.setAudioTrackIdx(playerId, idx);
    }

    public int playerGetSubtitleTrackIdx(String playerId) {
        if (rtePlayer == null) {
            return 0;
        }
        return rtePlayer.getSubtitleTrackIdx(playerId);
    }

    public boolean playerSetSubtitleTrackIdx(String playerId, int idx) {
        if (rtePlayer == null) {
            return false;
        }
        return rtePlayer.setSubtitleTrackIdx(playerId, idx);
    }

    public int playerGetExternalSubtitleTrackIdx(String playerId) {
        if (rtePlayer == null) {
            return 0;
        }
        return rtePlayer.getExternalSubtitleTrackIdx(playerId);
    }

    public boolean playerSetExternalSubtitleTrackIdx(String playerId, int idx) {
        if (rtePlayer == null) {
            return false;
        }
        return rtePlayer.setExternalSubtitleTrackIdx(playerId, idx);
    }

    public int playerGetAudioPitch(String playerId) {
        if (rtePlayer == null) {
            return 0;
        }
        return rtePlayer.getAudioPitch(playerId);
    }

    public boolean playerSetAudioPitch(String playerId, int pitch) {
        if (rtePlayer == null) {
            return false;
        }
        return rtePlayer.setAudioPitch(playerId, pitch);
    }

    public int playerGetPlayoutVolume(String playerId) {
        if (rtePlayer == null) {
            return 0;
        }
        return rtePlayer.getPlayoutVolume(playerId);
    }

    public boolean playerSetPlayoutVolume(String playerId, int volume) {
        if (rtePlayer == null) {
            return false;
        }
        return rtePlayer.setPlayoutVolume(playerId, volume);
    }

    public int playerGetAudioPlaybackDelay(String playerId) {
        if (rtePlayer == null) {
            return 0;
        }
        return rtePlayer.getAudioPlaybackDelay(playerId);
    }

    public boolean playerSetAudioPlaybackDelay(String playerId, int delay) {
        if (rtePlayer == null) {
            return false;
        }
        return rtePlayer.setAudioPlaybackDelay(playerId, delay);
    }

    public int playerGetAudioDualMonoMode(String playerId) {
        if (rtePlayer == null) {
            return 0;
        }
        return rtePlayer.getAudioDualMonoMode(playerId);
    }

    public boolean playerSetAudioDualMonoMode(String playerId, int mode) {
        if (rtePlayer == null) {
            return false;
        }
        return rtePlayer.setAudioDualMonoMode(playerId, mode);
    }

    public int playerGetPublishVolume(String playerId) {
        if (rtePlayer == null) {
            return 0;
        }
        return rtePlayer.getPublishVolume(playerId);
    }

    public boolean playerSetPublishVolume(String playerId, int volume) {
        if (rtePlayer == null) {
            return false;
        }
        return rtePlayer.setPublishVolume(playerId, volume);
    }

    public int playerGetLoopCount(String playerId) {
        if (rtePlayer == null) {
            return 0;
        }
        return rtePlayer.getLoopCount(playerId);
    }

    public boolean playerSetLoopCount(String playerId, int count) {
        if (rtePlayer == null) {
            return false;
        }
        return rtePlayer.setLoopCount(playerId, count);
    }

    public String playerGetJsonParameter(String playerId) {
        if (rtePlayer == null) {
            return "";
        }
        return rtePlayer.getJsonParameter(playerId);
    }

    public boolean playerSetJsonParameter(String playerId, String jsonParameter) {
        if (rtePlayer == null) {
            return false;
        }
        return rtePlayer.setJsonParameter(playerId, jsonParameter);
    }

    public int playerGetAbrSubscriptionLayer(String playerId) {
        if (rtePlayer == null) {
            return 0;
        }
        return rtePlayer.getAbrSubscriptionLayer(playerId);
    }

    public boolean playerSetAbrSubscriptionLayer(String playerId, int layer) {
        if (rtePlayer == null) {
            return false;
        }
        return rtePlayer.setAbrSubscriptionLayer(playerId, layer);
    }

    public int playerGetAbrFallbackLayer(String playerId) {
        if (rtePlayer == null) {
            return 0;
        }
        return rtePlayer.getAbrFallbackLayer(playerId);
    }

    public boolean playerSetAbrFallbackLayer(String playerId, int layer) {
        if (rtePlayer == null) {
            return false;
        }
        return rtePlayer.setAbrFallbackLayer(playerId, layer);
    }

    // --- Canvas ---

    public String createCanvas(Map<String, Object> config) {
        if (rteCanvas == null) {
            return null;
        }
        return rteCanvas.createCanvas(config);
    }

    public boolean destroyCanvas(String canvasId) {
        if (rteCanvas == null) {
            return false;
        }
        return rteCanvas.destroyCanvas(canvasId);
    }

    public boolean canvasSetConfig(String canvasId, Map<String, Object> config) {
        if (rteCanvas == null) {
            return false;
        }
        return rteCanvas.setConfigs(canvasId, config);
    }
    
    public void canvasGetConfig(String canvasId, MethodChannel.Result result) {
        if (rteCanvas == null) {
            result.error("RTE_ERROR", "RTE instance not created", null);
            return;
        }
        Map<String, Object> config = rteCanvas.getConfigs(canvasId);
        if (config == null) {
            result.error("RTE_ERROR", "Canvas not found", null);
        } else {
            result.success(config);
        }
    }

    public boolean canvasAddView(String canvasId, View view, Map<String, Object> config) {
        if (rteCanvas == null) {
            return false;
        }
        return rteCanvas.addView(canvasId, view, config);
    }
    
    public boolean canvasAddView(String canvasId, long viewPtr, Map<String, Object> config) {
        if (rteCanvas == null || videoViewController == null) {
            Log.e("AgoraRteController", "canvasAddView failed: rteCanvas or videoViewController is null");
            return false;
        }
        View view = videoViewController.getViewByPtr(viewPtr);
        if (view == null) {
            Log.e("AgoraRteController", "canvasAddView failed: view not found for ptr " + viewPtr);
            return false;
        }
        Log.i("AgoraRteController", "canvasAddView success: adding view " + view + " to canvas " + canvasId);
        return rteCanvas.addView(canvasId, view, config);
    }

    public boolean canvasRemoveView(String canvasId, View view, Map<String, Object> config) {
        if (rteCanvas == null) {
            return false;
        }
        return rteCanvas.removeView(canvasId, view, config);
    }
    
    public boolean canvasRemoveView(String canvasId, long viewPtr, Map<String, Object> config) {
        if (rteCanvas == null || videoViewController == null) {
            return false;
        }
        View view = videoViewController.getViewByPtr(viewPtr);
        if (view == null) {
            return false;
        }
        return rteCanvas.removeView(canvasId, view, config);
    }

    public boolean playerSetCanvas(String playerId, String canvasId) {
        if (rtePlayer == null || rteCanvas == null) {
            return false;
        }
        Canvas canvas = rteCanvas.getCanvas(canvasId);
        if (canvas == null) {
            return false;
        }
        return rtePlayer.setCanvas(playerId, canvas);
    }

    // --- Canvas Individual Config Methods ---
    public int canvasGetVideoRenderMode(String canvasId) {
        if (rteCanvas == null) {
            return 0;
        }
        return rteCanvas.getVideoRenderMode(canvasId);
    }

    public boolean canvasSetVideoRenderMode(String canvasId, int mode) {
        if (rteCanvas == null) {
            return false;
        }
        return rteCanvas.setVideoRenderMode(canvasId, mode);
    }

    public int canvasGetVideoMirrorMode(String canvasId) {
        if (rteCanvas == null) {
            return 0;
        }
        return rteCanvas.getVideoMirrorMode(canvasId);
    }

    public boolean canvasSetVideoMirrorMode(String canvasId, int mode) {
        if (rteCanvas == null) {
            return false;
        }
        return rteCanvas.setVideoMirrorMode(canvasId, mode);
    }

    public Map<String, Object> canvasGetCropArea(String canvasId) {
        if (rteCanvas == null) {
            return null;
        }
        return rteCanvas.getCropArea(canvasId);
    }

    public boolean canvasSetCropArea(String canvasId, int x, int y, int width, int height) {
        if (rteCanvas == null) {
            return false;
        }
        return rteCanvas.setCropArea(canvasId, x, y, width, height);
    }

    // --- Helpers ---

    private void runOnMainThread(Runnable runnable) {
        if (mainHandler != null) {
            mainHandler.post(runnable);
        }
    }
}
