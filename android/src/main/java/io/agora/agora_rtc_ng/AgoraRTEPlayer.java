package io.agora.agora_rtc_ng;

import android.os.Handler;
import android.os.Looper;
import io.agora.rte.Rte;
import io.agora.rte.Player;
import io.agora.rte.PlayerInitialConfig;
import io.agora.rte.PlayerConfig;
import io.agora.rte.PlayerInfo;
import io.agora.rte.PlayerStats;
import io.agora.rte.PlayerObserver;
import io.agora.rte.Canvas;
import io.agora.rte.Error;
import io.agora.rte.Constants;
import io.agora.rte.callback.AsyncCallback;
import io.agora.rte.callback.PlayerGetStatsCallback;
import io.agora.rte.exception.RteException;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**
 * RTE Player management class
 */
public class AgoraRTEPlayer {
    private final Rte rte;
    private final Map<String, Player> players = new HashMap<>();
    private final Map<String, PlayerObserver> playerObservers = new HashMap<>();
    private AgoraRTEPlayerObserverDelegate observerDelegate;
    private final Handler mainHandler;

    public AgoraRTEPlayer(Rte rte) {
        this.rte = rte;
        this.mainHandler = new Handler(Looper.getMainLooper());
    }

    public void setObserverDelegate(AgoraRTEPlayerObserverDelegate delegate) {
        this.observerDelegate = delegate;
    }

    public Map<String, Player> getPlayers() {
        return players;
    }

    /**
     * Preload URL
     */
    public static boolean preloadWithUrl(String url) {
        try {
            // Android SDK doesn't have static preload method, return true for now
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * Create player
     */
    public String createPlayer(Map<String, Object> config) {
        if (rte == null) {
            return null;
        }
        PlayerInitialConfig initialConfig = new PlayerInitialConfig();
        Player player = new Player(rte, initialConfig);
        
        String playerId = UUID.randomUUID().toString();
        players.put(playerId, player);
        
        // Apply config if provided
        if (config != null && !config.isEmpty()) {
            setConfigs(playerId, config);
        }
        
        return playerId;
    }

    /**
     * Destroy player
     */
    public boolean destroyPlayer(String playerId) {
        Player player = players.remove(playerId);
        if (player != null) {
            unregisterObserver(playerId);
            return true;
        }
        return false;
    }

    // --- Player Playback Control ---

    /**
     * Open URL
     */
    public boolean openUrl(String playerId, String url, long startTime, AsyncCallback completion) {
        Player player = players.get(playerId);
        if (player == null) {
            return false;
        }
        player.openWithUrl(url, startTime, completion);
        return true;
    }

    /**
     * Switch URL
     */
    public boolean switchWithUrl(String playerId, String url, boolean syncPts, AsyncCallback completion) {
        Player player = players.get(playerId);
        if (player == null) {
            return false;
        }
        player.switchWithUrl(url, syncPts, completion);
        return true;
    }

    /**
     * Set Canvas
     */
    public boolean setCanvas(String playerId, Canvas canvas) {
        Player player = players.get(playerId);
        if (player == null) {
            return false;
        }
        try {
            player.setCanvas(canvas);
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    /**
     * Play
     */
    public boolean play(String playerId) {
        Player player = players.get(playerId);
        if (player == null) {
            return false;
        }
        try {
            player.play();
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    /**
     * Pause
     */
    public boolean pause(String playerId) {
        Player player = players.get(playerId);
        if (player == null) {
            return false;
        }
        try {
            player.pause();
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    /**
     * Stop
     */
    public boolean stop(String playerId) {
        Player player = players.get(playerId);
        if (player == null) {
            return false;
        }
        try {
            player.stop();
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    /**
     * Seek
     */
    public boolean seek(String playerId, long position) {
        Player player = players.get(playerId);
        if (player == null) {
            return false;
        }
        try {
            player.seek(position);
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    /**
     * Mute audio
     */
    public boolean muteAudio(String playerId, boolean mute) {
        Player player = players.get(playerId);
        if (player == null) {
            return false;
        }
        try {
            player.muteAudio(mute);
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    /**
     * Mute video
     */
    public boolean muteVideo(String playerId, boolean mute) {
        Player player = players.get(playerId);
        if (player == null) {
            return false;
        }
        try {
            player.muteVideo(mute);
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    // --- Player Info ---

    /**
     * Get statistics
     */
    public void getStats(String playerId, PlayerGetStatsCallback callback) {
        Player player = players.get(playerId);
        if (player != null) {
            player.getStats(callback);
        }
    }

    /**
     * Get current time
     */
    public long getCurrentTime(String playerId) {
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

    /**
     * Get duration
     */
    public long getDuration(String playerId) {
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

    /**
     * Get player info
     */
    public Map<String, Object> getInfo(String playerId) {
        Player player = players.get(playerId);
        if (player != null) {
            try {
                PlayerInfo info = new PlayerInfo();
                player.getInfo(info);
                
                Map<String, Object> map = new HashMap<>();
                map.put("state", info.state());
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
                map.put("currentUrl", info.currentUrl() != null ? info.currentUrl() : "");
                return map;
            } catch (RteException e) {
                return null;
            }
        }
        return null;
    }

    // --- Player Config ---

    /**
     * Batch set configurations
     */
    public boolean setConfigs(String playerId, Map<String, Object> configMap) {
        Player player = players.get(playerId);
        if (player == null) {
            return false;
        }
        try {
            PlayerConfig playerConfig = new PlayerConfig();
            
            if (configMap.containsKey("autoPlay") && configMap.get("autoPlay") != null) {
                playerConfig.setAutoPlay((Boolean) configMap.get("autoPlay"));
            }
            if (configMap.containsKey("playbackSpeed") && configMap.get("playbackSpeed") != null) {
                playerConfig.setPlaybackSpeed(parseInt(configMap.get("playbackSpeed")));
            }
            if (configMap.containsKey("playoutAudioTrackIdx") && configMap.get("playoutAudioTrackIdx")!= null) {
                playerConfig.setPlayoutAudioTrackIdx(parseInt(configMap.get("playoutAudioTrackIdx")));
            }
            if (configMap.containsKey("publishAudioTrackIdx") && configMap.get("publishAudioTrackIdx") != null) {
                playerConfig.setPublishAudioTrackIdx(parseInt(configMap.get("publishAudioTrackIdx")));
            }
            if (configMap.containsKey("audioTrackIdx") && configMap.get("audioTrackIdx") != null) {
                playerConfig.setAudioTrackIdx(parseInt(configMap.get("audioTrackIdx")));
            }
            if (configMap.containsKey("subtitleTrackIdx") && configMap.get("subtitleTrackIdx") != null) {
                playerConfig.setSubtitleTrackIdx(parseInt(configMap.get("subtitleTrackIdx")));
            }
            if (configMap.containsKey("externalSubtitleTrackIdx") && configMap.get("externalSubtitleTrackIdx") != null) {
                playerConfig.setExternalSubtitleTrackIdx(parseInt(configMap.get("externalSubtitleTrackIdx")));
            }
            if (configMap.containsKey("audioPitch") && configMap.get("audioPitch") != null) {
                playerConfig.setAudioPitch(parseInt(configMap.get("audioPitch")));
            }
            if (configMap.containsKey("playoutVolume") && configMap.get("playoutVolume") != null) {
                playerConfig.setPlayoutVolume(parseInt(configMap.get("playoutVolume")));
            }
            if (configMap.containsKey("audioPlaybackDelay") && configMap.get("audioPlaybackDelay") != null) {
                playerConfig.setAudioPlaybackDelay(parseInt(configMap.get("audioPlaybackDelay")));
            }
            if (configMap.containsKey("audioDualMonoMode") && configMap.get("audioDualMonoMode") != null) {
                playerConfig.setAudioDualMonoMode(parseInt(configMap.get("audioDualMonoMode")));
            }
            if (configMap.containsKey("publishVolume") && configMap.get("publishVolume") != null) {
                playerConfig.setPublishVolume(parseInt(configMap.get("publishVolume")));
            }
            if (configMap.containsKey("loopCount") && configMap.get("loopCount") != null) {
                playerConfig.setLoopCount(parseInt(configMap.get("loopCount")));
            }
            if (configMap.containsKey("jsonParameter") && configMap.get("jsonParameter") != null) {
                playerConfig.setJsonParameter((String) configMap.get("jsonParameter"));
            }
            if (configMap.containsKey("abrSubscriptionLayer") && configMap.get("abrSubscriptionLayer") != null) {
                playerConfig.setAbrSubscriptionLayer(Constants.AbrSubscriptionLayer.fromInt(parseInt(configMap.get("abrSubscriptionLayer"))));
            }
            if (configMap.containsKey("abrFallbackLayer") && configMap.get("abrFallbackLayer") != null) {
                playerConfig.setAbrFallbackLayer(Constants.AbrFallbackLayer.fromInt(parseInt(configMap.get("abrFallbackLayer"))));
            }
            
            player.setConfigs(playerConfig);
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    /**
     * Get configurations
     */
    public Map<String, Object> getConfigs(String playerId) {
        Player player = players.get(playerId);
        if (player == null) {
            return null;
        }
        try {
            PlayerConfig config = new PlayerConfig();
            player.getConfigs(config);
            
            Map<String, Object> map = new HashMap<>();
            map.put("autoPlay", config.getAutoPlay());
            map.put("playbackSpeed", config.getPlaybackSpeed());
            map.put("playoutAudioTrackIdx", config.getPlayoutAudioTrackIdx());
            map.put("publishAudioTrackIdx", config.getPublishAudioTrackIdx());
            map.put("audioTrackIdx", config.getAudioTrackIdx());
            map.put("subtitleTrackIdx", config.getSubtitleTrackIdx());
            map.put("externalSubtitleTrackIdx", config.getExternalSubtitleTrackIdx());
            map.put("audioPitch", config.getAudioPitch());
            map.put("playoutVolume", config.getPlayoutVolume());
            map.put("audioPlaybackDelay", config.getAudioPlaybackDelay());
            map.put("audioDualMonoMode", config.getAudioDualMonoMode());
            map.put("publishVolume", config.getPublishVolume());
            map.put("loopCount", config.getLoopCount());
            map.put("jsonParameter", config.getJsonParameter() != null ? config.getJsonParameter() : "");
            map.put("abrSubscriptionLayer", Constants.AbrSubscriptionLayer.getValue(config.getAbrSubscriptionLayer()));
            map.put("abrFallbackLayer", Constants.AbrFallbackLayer.getValue(config.getAbrFallbackLayer()));
            return map;
        } catch (RteException e) {
            return null;
        }
    }

    // Individual Config Setters/Getters
    public boolean setAutoPlay(String playerId, boolean autoPlay) {
        Player player = players.get(playerId);
        if (player == null) return false;
        try {
            PlayerConfig config = new PlayerConfig();
            config.setAutoPlay(autoPlay);
            player.setConfigs(config);
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    public boolean getAutoPlay(String playerId) {
        Player player = players.get(playerId);
        if (player == null) return false;
        try {
            PlayerConfig config = new PlayerConfig();
            player.getConfigs(config);
            return config.getAutoPlay();
        } catch (RteException e) {
            return false;
        }
    }

    public boolean setPlaybackSpeed(String playerId, int speed) {
        Player player = players.get(playerId);
        if (player == null) return false;
        try {
            PlayerConfig config = new PlayerConfig();
            config.setPlaybackSpeed(speed);
            player.setConfigs(config);
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    public int getPlaybackSpeed(String playerId) {
        Player player = players.get(playerId);
        if (player == null) return 0;
        try {
            PlayerConfig config = new PlayerConfig();
            player.getConfigs(config);
            return config.getPlaybackSpeed();
        } catch (RteException e) {
            return 0;
        }
    }

    public boolean setPlayoutAudioTrackIdx(String playerId, int idx) {
        Player player = players.get(playerId);
        if (player == null) return false;
        try {
            PlayerConfig config = new PlayerConfig();
            config.setPlayoutAudioTrackIdx(idx);
            player.setConfigs(config);
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    public int getPlayoutAudioTrackIdx(String playerId) {
        Player player = players.get(playerId);
        if (player == null) return 0;
        try {
            PlayerConfig config = new PlayerConfig();
            player.getConfigs(config);
            return config.getPlayoutAudioTrackIdx();
        } catch (RteException e) {
            return 0;
        }
    }

    public boolean setPublishAudioTrackIdx(String playerId, int idx) {
        Player player = players.get(playerId);
        if (player == null) return false;
        try {
            PlayerConfig config = new PlayerConfig();
            config.setPublishAudioTrackIdx(idx);
            player.setConfigs(config);
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    public int getPublishAudioTrackIdx(String playerId) {
        Player player = players.get(playerId);
        if (player == null) return 0;
        try {
            PlayerConfig config = new PlayerConfig();
            player.getConfigs(config);
            return config.getPublishAudioTrackIdx();
        } catch (RteException e) {
            return 0;
        }
    }

    public boolean setAudioTrackIdx(String playerId, int idx) {
        Player player = players.get(playerId);
        if (player == null) return false;
        try {
            PlayerConfig config = new PlayerConfig();
            config.setAudioTrackIdx(idx);
            player.setConfigs(config);
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    public int getAudioTrackIdx(String playerId) {
        Player player = players.get(playerId);
        if (player == null) return 0;
        try {
            PlayerConfig config = new PlayerConfig();
            player.getConfigs(config);
            return config.getAudioTrackIdx();
        } catch (RteException e) {
            return 0;
        }
    }

    public boolean setSubtitleTrackIdx(String playerId, int idx) {
        Player player = players.get(playerId);
        if (player == null) return false;
        try {
            PlayerConfig config = new PlayerConfig();
            config.setSubtitleTrackIdx(idx);
            player.setConfigs(config);
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    public int getSubtitleTrackIdx(String playerId) {
        Player player = players.get(playerId);
        if (player == null) return 0;
        try {
            PlayerConfig config = new PlayerConfig();
            player.getConfigs(config);
            return config.getSubtitleTrackIdx();
        } catch (RteException e) {
            return 0;
        }
    }

    public boolean setExternalSubtitleTrackIdx(String playerId, int idx) {
        Player player = players.get(playerId);
        if (player == null) return false;
        try {
            PlayerConfig config = new PlayerConfig();
            config.setExternalSubtitleTrackIdx(idx);
            player.setConfigs(config);
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    public int getExternalSubtitleTrackIdx(String playerId) {
        Player player = players.get(playerId);
        if (player == null) return 0;
        try {
            PlayerConfig config = new PlayerConfig();
            player.getConfigs(config);
            return config.getExternalSubtitleTrackIdx();
        } catch (RteException e) {
            return 0;
        }
    }

    public boolean setAudioPitch(String playerId, int pitch) {
        Player player = players.get(playerId);
        if (player == null) return false;
        try {
            PlayerConfig config = new PlayerConfig();
            config.setAudioPitch(pitch);
            player.setConfigs(config);
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    public int getAudioPitch(String playerId) {
        Player player = players.get(playerId);
        if (player == null) return 0;
        try {
            PlayerConfig config = new PlayerConfig();
            player.getConfigs(config);
            return config.getAudioPitch();
        } catch (RteException e) {
            return 0;
        }
    }

    public boolean setPlayoutVolume(String playerId, int volume) {
        Player player = players.get(playerId);
        if (player == null) return false;
        try {
            PlayerConfig config = new PlayerConfig();
            config.setPlayoutVolume(volume);
            player.setConfigs(config);
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    public int getPlayoutVolume(String playerId) {
        Player player = players.get(playerId);
        if (player == null) return 0;
        try {
            PlayerConfig config = new PlayerConfig();
            player.getConfigs(config);
            return config.getPlayoutVolume();
        } catch (RteException e) {
            return 0;
        }
    }

    public boolean setAudioPlaybackDelay(String playerId, int delay) {
        Player player = players.get(playerId);
        if (player == null) return false;
        try {
            PlayerConfig config = new PlayerConfig();
            config.setAudioPlaybackDelay(delay);
            player.setConfigs(config);
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    public int getAudioPlaybackDelay(String playerId) {
        Player player = players.get(playerId);
        if (player == null) return 0;
        try {
            PlayerConfig config = new PlayerConfig();
            player.getConfigs(config);
            return config.getAudioPlaybackDelay();
        } catch (RteException e) {
            return 0;
        }
    }

    public boolean setAudioDualMonoMode(String playerId, int mode) {
        Player player = players.get(playerId);
        if (player == null) return false;
        try {
            PlayerConfig config = new PlayerConfig();
            config.setAudioDualMonoMode(mode);
            player.setConfigs(config);
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    public int getAudioDualMonoMode(String playerId) {
        Player player = players.get(playerId);
        if (player == null) return 0;
        try {
            PlayerConfig config = new PlayerConfig();
            player.getConfigs(config);
            return config.getAudioDualMonoMode();
        } catch (RteException e) {
            return 0;
        }
    }

    public boolean setPublishVolume(String playerId, int volume) {
        Player player = players.get(playerId);
        if (player == null) return false;
        try {
            PlayerConfig config = new PlayerConfig();
            config.setPublishVolume(volume);
            player.setConfigs(config);
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    public int getPublishVolume(String playerId) {
        Player player = players.get(playerId);
        if (player == null) return 0;
        try {
            PlayerConfig config = new PlayerConfig();
            player.getConfigs(config);
            return config.getPublishVolume();
        } catch (RteException e) {
            return 0;
        }
    }

    public boolean setLoopCount(String playerId, int count) {
        Player player = players.get(playerId);
        if (player == null) return false;
        try {
            PlayerConfig config = new PlayerConfig();
            config.setLoopCount(count);
            player.setConfigs(config);
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    public int getLoopCount(String playerId) {
        Player player = players.get(playerId);
        if (player == null) return 0;
        try {
            PlayerConfig config = new PlayerConfig();
            player.getConfigs(config);
            return config.getLoopCount();
        } catch (RteException e) {
            return 0;
        }
    }

    public boolean setJsonParameter(String playerId, String jsonParameter) {
        Player player = players.get(playerId);
        if (player == null) return false;
        try {
            PlayerConfig config = new PlayerConfig();
            config.setJsonParameter(jsonParameter);
            player.setConfigs(config);
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    public String getJsonParameter(String playerId) {
        Player player = players.get(playerId);
        if (player == null) return "";
        try {
            PlayerConfig config = new PlayerConfig();
            player.getConfigs(config);
            return config.getJsonParameter() != null ? config.getJsonParameter() : "";
        } catch (RteException e) {
            return "";
        }
    }

    public boolean setAbrSubscriptionLayer(String playerId, int layer) {
        Player player = players.get(playerId);
        if (player == null) return false;
        try {
            PlayerConfig config = new PlayerConfig();
            config.setAbrSubscriptionLayer(Constants.AbrSubscriptionLayer.fromInt(layer));
            player.setConfigs(config);
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    public int getAbrSubscriptionLayer(String playerId) {
        Player player = players.get(playerId);
        if (player == null) return 0;
        try {
            PlayerConfig config = new PlayerConfig();
            player.getConfigs(config);
            return Constants.AbrSubscriptionLayer.getValue(config.getAbrSubscriptionLayer());
        } catch (RteException e) {
            return 0;
        }
    }

    public boolean setAbrFallbackLayer(String playerId, int layer) {
        Player player = players.get(playerId);
        if (player == null) return false;
        try {
            PlayerConfig config = new PlayerConfig();
            config.setAbrFallbackLayer(Constants.AbrFallbackLayer.fromInt(layer));
            player.setConfigs(config);
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    public int getAbrFallbackLayer(String playerId) {
        Player player = players.get(playerId);
        if (player == null) return 0;
        try {
            PlayerConfig config = new PlayerConfig();
            player.getConfigs(config);
            return Constants.AbrFallbackLayer.getValue(config.getAbrFallbackLayer());
        } catch (RteException e) {
            return 0;
        }
    }

    // --- Player Observer ---

    /**
     * Register observer
     */
    public boolean registerObserver(String playerId) {
        Player player = players.get(playerId);
        if (player == null) {
            return false;
        }
        try {
            PlayerObserver observer = new PlayerObserver() {
                @Override
                public void onStateChanged(int oldState, int newState, Error error) {
                    if (observerDelegate != null) {
                        mainHandler.post(() -> {
                            observerDelegate.onStateChanged(
                                playerId,
                                oldState,
                                newState,
                                error != null ? Constants.ErrorCode.getValue(error.code()) : 0,
                                error != null ? error.message() : ""
                            );
                        });
                    }
                }

                @Override
                public void onPositionChanged(long currentTime, long utcTime) {
                    if (observerDelegate != null) {
                        mainHandler.post(() -> {
                            observerDelegate.onPositionChanged(playerId, currentTime, utcTime);
                        });
                    }
                }

                @Override
                public void onResolutionChanged(int width, int height) {
                    if (observerDelegate != null) {
                        mainHandler.post(() -> {
                            observerDelegate.onResolutionChanged(playerId, width, height);
                        });
                    }
                }

                @Override
                public void onEvent(int event) {
                    if (observerDelegate != null) {
                        mainHandler.post(() -> {
                            observerDelegate.onEvent(playerId, event);
                        });
                    }
                }

                @Override
                public void onMetadata(int type, byte[] data) {
                    if (observerDelegate != null) {
                        mainHandler.post(() -> {
                            observerDelegate.onMetadata(playerId, type, data);
                        });
                    }
                }

                @Override
                public void onPlayerInfoUpdated(PlayerInfo info) {
                    if (observerDelegate != null) {
                        mainHandler.post(() -> {
                            Map<String, Object> infoMap = infoToMap(info);
                            observerDelegate.onPlayerInfoUpdated(playerId, infoMap);
                        });
                    }
                }

                @Override
                public void onAudioVolumeIndication(int volume) {
                    if (observerDelegate != null) {
                        mainHandler.post(() -> {
                            observerDelegate.onAudioVolumeIndication(playerId, volume);
                        });
                    }
                }
            };
            playerObservers.put(playerId, observer);
            player.registerObserver(observer);
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    /**
     * Unregister observer
     */
    public boolean unregisterObserver(String playerId) {
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

    private int parseInt(Object obj) {
        if (obj instanceof Number) {
            return ((Number) obj).intValue();
        }
        if (obj instanceof String) {
            try {
                return Integer.parseInt((String) obj);
            } catch (Exception e) {
                return 0;
            }
        }
        return 0;
    }

    private Map<String, Object> infoToMap(PlayerInfo info) {
        Map<String, Object> map = new HashMap<>();
        if (info == null) return map;
        try {
            map.put("state", info.state());
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
            map.put("currentUrl", info.currentUrl() != null ? info.currentUrl() : "");
        } catch (Exception e) {
            // Ignore
        }
        return map;
    }
}
