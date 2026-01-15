package io.agora.agora_rtc_ng;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.view.View;
import io.flutter.plugin.common.MethodChannel;

import java.util.HashMap;
import java.util.Map;

// Android RTE Java API uses simplified class names (Rte, Config, Player) instead of AgoraRte* prefix
import io.agora.rte.Rte;
import io.agora.rte.InitialConfig;
import io.agora.rte.Config;
import io.agora.rte.Error;
import io.agora.rte.Observer;
import io.agora.rte.Player;
import io.agora.rte.PlayerInitialConfig;
import io.agora.rte.PlayerConfig;
import io.agora.rte.PlayerInfo;
import io.agora.rte.PlayerStats;
import io.agora.rte.PlayerObserver;
import io.agora.rte.PlayerCustomSourceProvider;
import io.agora.rte.Stream;
import io.agora.rte.Canvas;
import io.agora.rte.CanvasInitialConfig;
import io.agora.rte.CanvasConfig;
import io.agora.rte.ViewConfig;
import io.agora.rte.Constants;
import io.agora.rte.callback.AsyncCallback;
import io.agora.rte.callback.PlayerGetStatsCallback;
import io.agora.rte.exception.RteException;

public class AgoraRteController {
    private final Context context;
    private final MethodChannel channel;
    private final Handler mainHandler;

    private Rte rteInstance; // Android uses Rte instance, not static AgoraRteSdk
    private final Map<String, Player> players = new HashMap<>();
    private final Map<String, Canvas> canvases = new HashMap<>();
    private final Map<String, PlayerObserver> playerObservers = new HashMap<>();

    public AgoraRteController(Context context, MethodChannel channel) {
        this.context = context;
        this.channel = channel;
        this.mainHandler = new Handler(Looper.getMainLooper());
    }

    // --- RTE Lifecycle ---

    public boolean createRteFromBridge() {
        try {
            rteInstance = Rte.getFromBridge();
            return rteInstance != null;
        } catch (RteException e) {
            return false;
        }
    }

    public boolean createRteWithConfig(Map<String, Object> config) {
        InitialConfig initialConfig = new InitialConfig();
        rteInstance = new Rte(initialConfig);
        
        if (config != null && !config.isEmpty()) {
            return setRteConfig(config);
        }
        return true;
    }

    public boolean initMediaEngine() {
        if (rteInstance == null) {
            return false;
        }
        try {
            rteInstance.initMediaEngine(new AsyncCallback() {
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
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    public void destroyRte() {
        if (rteInstance == null) {
            return;
        }
        
        for (String playerId : players.keySet()) {
            destroyPlayer(playerId);
        }
        players.clear();
        
        for (String canvasId : canvases.keySet()) {
            destroyCanvas(canvasId);
        }
        canvases.clear();
        
        try {
            rteInstance.destroy();
        } catch (RteException e) {
            // Ignore
        }
        rteInstance = null;
    }

    // --- RTE Config ---

    public boolean setRteConfig(Map<String, Object> config) {
        if (rteInstance == null) {
            return false;
        }
        try {
            Config rteConfig = new Config();
            if (config.containsKey("appId")) {
                rteConfig.setAppId((String) config.get("appId"));
            }
            if (config.containsKey("logFolder")) {
                rteConfig.setLogFolder((String) config.get("logFolder"));
            }
            if (config.containsKey("logFileSize")) {
                rteConfig.setLogFileSize(parseInt(config.get("logFileSize")));
            }
            if (config.containsKey("areaCode")) {
                rteConfig.setAreaCode(parseInt(config.get("areaCode")));
            }
            if (config.containsKey("cloudProxy")) {
                rteConfig.setCloudProxy((String) config.get("cloudProxy"));
            }
            if (config.containsKey("jsonParameter")) {
                rteConfig.setJsonParameter((String) config.get("jsonParameter"));
            }
            
            rteInstance.setConfigs(rteConfig);
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    public Map<String, Object> getRteConfig() {
        if (rteInstance == null) {
            return null;
        }
        try {
            Config config = new Config();
            rteInstance.getConfigs(config);
            
            Map<String, Object> map = new HashMap<>();
            map.put("appId", config.getAppId());
            map.put("logFolder", config.getLogFolder());
            map.put("logFileSize", config.getLogFileSize());
            map.put("areaCode", config.getAreaCode());
            map.put("cloudProxy", config.getCloudProxy());
            map.put("jsonParameter", config.getJsonParameter());
            return map;
        } catch (RteException e) {
            return null;
        }
    }

    public String appId() {
        if (rteInstance == null) {
            return "";
        }
        try {
            Config config = new Config();
            rteInstance.getConfigs(config);
            String appId = config.getAppId();
            return appId != null ? appId : "";
        } catch (RteException e) {
            return "";
        }
    }

    public String logFolder() {
        if (rteInstance == null) {
            return "";
        }
        try {
            Config config = new Config();
            rteInstance.getConfigs(config);
            String logFolder = config.getLogFolder();
            return logFolder != null ? logFolder : "";
        } catch (RteException e) {
            return "";
        }
    }

    public int logFileSize() {
        if (rteInstance == null) {
            return 0;
        }
        try {
            Config config = new Config();
            rteInstance.getConfigs(config);
            return config.getLogFileSize();
        } catch (RteException e) {
            return 0;
        }
    }

    public int areaCode() {
        if (rteInstance == null) {
            return 0;
        }
        try {
            Config config = new Config();
            rteInstance.getConfigs(config);
            return config.getAreaCode();
        } catch (RteException e) {
            return 0;
        }
    }

    public String cloudProxy() {
        if (rteInstance == null) {
            return "";
        }
        try {
            Config config = new Config();
            rteInstance.getConfigs(config);
            String cloudProxy = config.getCloudProxy();
            return cloudProxy != null ? cloudProxy : "";
        } catch (RteException e) {
            return "";
        }
    }

    public String jsonParameter() {
        if (rteInstance == null) {
            return "";
        }
        try {
            Config config = new Config();
            rteInstance.getConfigs(config);
            String jsonParameter = config.getJsonParameter();
            return jsonParameter != null ? jsonParameter : "";
        } catch (RteException e) {
            return "";
        }
    }

    public boolean registerRteObserver() {
        // TODO: Implement general RTE observer if needed
        return true;
    }

    public boolean unregisterRteObserver() {
        // TODO: Implement general RTE observer if needed
        return true;
    }

    // --- Player Lifecycle ---

    public String createPlayer(Map<String, Object> config) {
        if (rteInstance == null) {
            return null;
        }
        PlayerInitialConfig initialConfig = new PlayerInitialConfig();
        Player player = new Player(rteInstance, initialConfig);
        String playerId = String.valueOf(player.hashCode());
        players.put(playerId, player);
        
        if (config != null) {
            playerSetConfig(playerId, config);
        }
        return playerId;
    }

    public boolean destroyPlayer(String playerId) {
        Player player = players.remove(playerId);
        if (player != null) {
            playerUnregisterObserver(playerId);
            // Player destruction is handled by finalize() in Android SDK
            return true;
        }
        return false;
    }

    // --- Player Control ---

    public boolean playerOpenUrl(String playerId, String url, long startTime) {
        Player player = players.get(playerId);
        if (player != null) {
            player.openWithUrl(url, startTime, new AsyncCallback() {
                @Override
                public void onResult(Error error) {
                    // Result handled by observer
                }
            });
            return true;
        }
        return false;
    }
    
    public void playerOpenWithCustomSourceProvider(String playerId, long provider, long startTime, MethodChannel.Result result) {
        Player player = players.get(playerId);
        if (player == null) {
            result.error("PLAYER_NOT_FOUND", "Player not found", null);
            return;
        }
        // Custom source provider needs proper implementation
        result.notImplemented(); 
    }
    
    public void playerOpenWithStream(String playerId, long stream, MethodChannel.Result result) {
        Player player = players.get(playerId);
        if (player == null) {
            result.error("PLAYER_NOT_FOUND", "Player not found", null);
            return;
        }
        // Stream opening needs proper implementation
        result.notImplemented();
    }

    public boolean playerPlay(String playerId) {
        Player player = players.get(playerId);
        if (player != null) {
            try {
                player.play();
                return true;
            } catch (RteException e) {
                return false;
            }
        }
        return false;
    }

    public boolean playerPause(String playerId) {
        Player player = players.get(playerId);
        if (player != null) {
            try {
                player.pause();
                return true;
            } catch (RteException e) {
                return false;
            }
        }
        return false;
    }

    public boolean playerStop(String playerId) {
        Player player = players.get(playerId);
        if (player != null) {
            try {
                player.stop();
                return true;
            } catch (RteException e) {
                return false;
            }
        }
        return false;
    }

    public boolean playerSeek(String playerId, long position) {
        Player player = players.get(playerId);
        if (player != null) {
            try {
                player.seek(position);
                return true;
            } catch (RteException e) {
                return false;
            }
        }
        return false;
    }

    public boolean playerMuteAudio(String playerId, boolean mute) {
        Player player = players.get(playerId);
        if (player != null) {
            try {
                player.muteAudio(mute);
                return true;
            } catch (RteException e) {
                return false;
            }
        }
        return false;
    }

    public boolean playerMuteVideo(String playerId, boolean mute) {
        Player player = players.get(playerId);
        if (player != null) {
            try {
                player.muteVideo(mute);
                return true;
            } catch (RteException e) {
                return false;
            }
        }
        return false;
    }
    
    public boolean playerSwitch(String playerId, String url, boolean syncPts) {
        Player player = players.get(playerId);
        if (player != null) {
            player.switchWithUrl(url, syncPts, new AsyncCallback() {
                @Override
                public void onResult(Error error) {
                    // Result handled by observer
                }
            });
            return true;
        }
        return false;
    }

    public long playerGetDuration(String playerId) {
        Player player = players.get(playerId);
        if (player != null) {
            try {
                PlayerInfo info = new PlayerInfo();
                player.getInfo(info);
                return info.duration();
            } catch (RteException e) {
                return 0;
            }
        }
        return 0;
    }

    public long playerGetCurrentTime(String playerId) {
        Player player = players.get(playerId);
        if (player != null) {
            try {
                return player.getPosition();
            } catch (RteException e) {
                return 0;
            }
        }
        return 0;
    }

    public Map<String, Object> playerGetInfo(String playerId) {
        Player player = players.get(playerId);
        if (player != null) {
            try {
                PlayerInfo info = new PlayerInfo();
                player.getInfo(info);
                
                Map<String, Object> map = new HashMap<>();
                map.put("state", info.state()); // state() returns int directly
                map.put("duration", info.duration());
                map.put("streamCount", info.streamCount());
                map.put("hasAudio", info.hasAudio());
                map.put("hasVideo", info.hasVideo());
                map.put("isAudioMuted", info.isAudioMuted());
                map.put("isVideoMuted", info.isVideoMuted());
                map.put("videoHeight", info.videoHeight());
                map.put("videoWidth", info.videoWidth());
                map.put("audioSampleRate", info.audioSampleRate());
                map.put("audioChannels", info.audioChannels());
                map.put("audioBitsPerSample", info.audioBitsPerSample());
                map.put("abrSubscriptionLayer", Constants.AbrSubscriptionLayer.getValue(info.abrSubscriptionLayer()));
                map.put("currentUrl", info.currentUrl());
                return map;
            } catch (RteException e) {
                return null;
            }
        }
        return null;
    }

    public Map<String, Object> playerGetStats(String playerId) {
        Player player = players.get(playerId);
        if (player != null) {
            player.getStats(new PlayerGetStatsCallback() {
                @Override
                public void onResult(PlayerStats stats, Error error) {
                    // Stats are returned asynchronously, need to handle via callback
                    // For now, return null and handle via observer if needed
                }
            });
            // Note: Stats are async, this method returns null
            // Consider using callback-based approach
            return null;
        }
        return null;
    }

    public boolean playerSetConfig(String playerId, Map<String, Object> config) {
        Player player = players.get(playerId);
        if (player != null) {
            try {
                PlayerConfig playerConfig = new PlayerConfig();
                if (config.containsKey("autoPlay")) {
                    playerConfig.setAutoPlay((Boolean) config.get("autoPlay"));
                }
                if (config.containsKey("playbackSpeed")) {
                    playerConfig.setPlaybackSpeed(parseInt(config.get("playbackSpeed")));
                }
                if (config.containsKey("playoutVolume")) {
                    playerConfig.setPlayoutVolume(parseInt(config.get("playoutVolume")));
                }
                if (config.containsKey("loopCount")) {
                    playerConfig.setLoopCount(parseInt(config.get("loopCount")));
                }
                if (config.containsKey("jsonParameter")) {
                    playerConfig.setJsonParameter((String) config.get("jsonParameter"));
                }
                // Add other properties as needed
                
                player.setConfigs(playerConfig);
                return true;
            } catch (RteException e) {
                return false;
            }
        }
        return false;
    }

    public Map<String, Object> playerGetConfig(String playerId) {
        Player player = players.get(playerId);
        if (player != null) {
            try {
                PlayerConfig config = new PlayerConfig();
                player.getConfigs(config);
                
                Map<String, Object> map = new HashMap<>();
                try {
                    map.put("autoPlay", config.getAutoPlay());
                    map.put("playbackSpeed", config.getPlaybackSpeed());
                    map.put("playoutVolume", config.getPlayoutVolume());
                    map.put("loopCount", config.getLoopCount());
                    map.put("jsonParameter", config.getJsonParameter());
                } catch (RteException e) {
                    // Individual getter failed, return partial map
                }
                return map;
            } catch (RteException e) {
                return null;
            }
        }
        return null;
    }
    
    // --- Player Observer ---

    public boolean playerRegisterObserver(String playerId) {
        Player player = players.get(playerId);
        if (player != null) {
            try {
                PlayerObserver observer = new PlayerObserver() {
                    @Override
                    public void onStateChanged(int oldState, int newState, Error error) {
                        runOnMainThread(() -> {
                           Map<String, Object> args = new HashMap<>();
                           args.put("playerId", playerId);
                           args.put("oldState", oldState);
                           args.put("newState", newState);
                           args.put("errorCode", error != null ? Constants.ErrorCode.getValue(error.code()) : 0);
                           args.put("errorMessage", error != null ? error.message() : "");
                           channel.invokeMethod("onStateChanged", args);
                        });
                    }

                    @Override
                    public void onPositionChanged(long currentTime, long utcTime) {
                        runOnMainThread(() -> {
                            Map<String, Object> args = new HashMap<>();
                            args.put("playerId", playerId);
                            args.put("currentTime", currentTime);
                            args.put("utcTime", utcTime);
                            channel.invokeMethod("onPositionChanged", args);
                        });
                    }

                    @Override
                    public void onResolutionChanged(int width, int height) {
                        runOnMainThread(() -> {
                            Map<String, Object> args = new HashMap<>();
                            args.put("playerId", playerId);
                            args.put("width", width);
                            args.put("height", height);
                            channel.invokeMethod("onResolutionChanged", args);
                        });
                    }

                    @Override
                    public void onEvent(int event) {
                        runOnMainThread(() -> {
                            Map<String, Object> args = new HashMap<>();
                            args.put("playerId", playerId);
                            args.put("event", event);
                            channel.invokeMethod("onEvent", args);
                        });
                    }

                    @Override
                    public void onMetadata(int type, byte[] data) {
                        runOnMainThread(() -> {
                            Map<String, Object> args = new HashMap<>();
                            args.put("playerId", playerId);
                            args.put("type", type);
                            args.put("data", data);
                            channel.invokeMethod("onMetadata", args);
                        });
                    }

                    @Override
                    public void onPlayerInfoUpdated(PlayerInfo info) {
                        runOnMainThread(() -> {
                            Map<String, Object> args = new HashMap<>();
                            args.put("playerId", playerId);
                            args.put("info", infoToMap(info));
                            channel.invokeMethod("onPlayerInfoUpdated", args);
                        });
                    }

                    @Override
                    public void onAudioVolumeIndication(int volume) {
                        runOnMainThread(() -> {
                            Map<String, Object> args = new HashMap<>();
                            args.put("playerId", playerId);
                            args.put("volume", volume);
                            channel.invokeMethod("onAudioVolumeIndication", args);
                        });
                    }
                };
                playerObservers.put(playerId, observer);
                player.registerObserver(observer);
                return true;
            } catch (RteException e) {
                return false;
            }
        }
        return false;
    }

    public boolean playerUnregisterObserver(String playerId) {
        Player player = players.get(playerId);
        PlayerObserver observer = playerObservers.remove(playerId);
        if (player != null && observer != null) {
            try {
                player.unregisterObserver(observer);
                return true;
            } catch (RteException e) {
                return false;
            }
        }
        return false;
    }

    // --- Canvas ---

    public String createCanvas(Map<String, Object> config) {
        if (rteInstance == null) {
            return null;
        }
        CanvasInitialConfig initialConfig = new CanvasInitialConfig();
        Canvas canvas = new Canvas(rteInstance, initialConfig);
        
        String canvasId = String.valueOf(canvas.hashCode());
        canvases.put(canvasId, canvas);
        
        if (config != null) {
            canvasSetConfig(canvasId, config);
        }
        return canvasId;
    }

    public boolean destroyCanvas(String canvasId) {
        Canvas canvas = canvases.remove(canvasId);
        // Canvas destruction is handled by finalize() in Android SDK
        return canvas != null;
    }

    public boolean canvasSetConfig(String canvasId, Map<String, Object> config) {
        Canvas canvas = canvases.get(canvasId);
        if (canvas != null) {
            try {
                CanvasConfig c = new CanvasConfig();
                if (config.containsKey("videoRenderMode")) {
                    c.setVideoRenderMode(Constants.VideoRenderMode.fromInt(parseInt(config.get("videoRenderMode"))));
                }
                if (config.containsKey("videoMirrorMode")) {
                    c.setVideoMirrorMode(Constants.VideoMirrorMode.fromInt(parseInt(config.get("videoMirrorMode"))));
                }
                canvas.setConfigs(c);
                return true;
            } catch (RteException e) {
                return false;
            }
        }
        return false;
    }
    
    public void canvasGetConfig(String canvasId, MethodChannel.Result result) {
        Canvas canvas = canvases.get(canvasId);
        if (canvas != null) {
            try {
                CanvasConfig c = new CanvasConfig();
                canvas.getConfigs(c);
                
                Map<String, Object> map = new HashMap<>();
                map.put("videoRenderMode", c.getVideoRenderMode() != null ? Constants.VideoRenderMode.getValue(c.getVideoRenderMode()) : 0);
                map.put("videoMirrorMode", c.getVideoMirrorMode() != null ? Constants.VideoMirrorMode.getValue(c.getVideoMirrorMode()) : 0);
                result.success(map);
                return;
            } catch (RteException e) {
                result.success(null);
                return;
            }
        }
        result.success(null);
    }

    public boolean canvasAddView(String canvasId, View view, Map<String, Object> config) {
        Canvas canvas = canvases.get(canvasId);
        if (canvas != null) {
            try {
                ViewConfig viewConfig = new ViewConfig();
                canvas.addView(view, viewConfig);
                return true;
            } catch (RteException e) {
                return false;
            }
        }
        return false;
    }
    
    public boolean canvasAddView(String canvasId, long viewPtr, Map<String, Object> config) {
        // Android uses View objects, not viewPtr
        return false;
    }

    public boolean canvasRemoveView(String canvasId, View view, Map<String, Object> config) {
        Canvas canvas = canvases.get(canvasId);
        if (canvas != null) {
            try {
                ViewConfig viewConfig = new ViewConfig();
                canvas.removeView(view, viewConfig);
                return true;
            } catch (RteException e) {
                return false;
            }
        }
        return false;
    }
    
    public boolean canvasRemoveView(String canvasId, long viewPtr, Map<String, Object> config) {
        // Android uses View objects, not viewPtr
        return false;
    }

    public boolean playerSetCanvas(String playerId, String canvasId) {
        Player player = players.get(playerId);
        Canvas canvas = canvases.get(canvasId);
        if (player != null && canvas != null) {
            try {
                player.setCanvas(canvas);
                return true;
            } catch (RteException e) {
                return false;
            }
        }
        return false;
    }

    // --- Helpers ---

    private void runOnMainThread(Runnable runnable) {
        if (mainHandler != null) {
            mainHandler.post(runnable);
        }
    }

    private int parseInt(Object obj) {
        if (obj instanceof Number) return ((Number) obj).intValue();
        if (obj instanceof String) {
            try { return Integer.parseInt((String) obj); } catch (Exception e) { return 0; }
        }
        return 0;
    }
    
    private Map<String, Object> infoToMap(PlayerInfo info) {
        Map<String, Object> map = new HashMap<>();
        if (info == null) return map;
        try {
            map.put("state", info.state()); // state() returns int directly
            map.put("duration", info.duration());
            map.put("streamCount", info.streamCount());
            map.put("hasAudio", info.hasAudio());
            map.put("hasVideo", info.hasVideo());
            map.put("isAudioMuted", info.isAudioMuted());
            map.put("isVideoMuted", info.isVideoMuted());
            map.put("videoHeight", info.videoHeight());
            map.put("videoWidth", info.videoWidth());
            map.put("audioSampleRate", info.audioSampleRate());
            map.put("audioChannels", info.audioChannels());
            map.put("audioBitsPerSample", info.audioBitsPerSample());
            map.put("abrSubscriptionLayer", Constants.AbrSubscriptionLayer.getValue(info.abrSubscriptionLayer()));
            map.put("currentUrl", info.currentUrl());
        } catch (Exception e) {
            // Ignore
        }
        return map;
    }
}
