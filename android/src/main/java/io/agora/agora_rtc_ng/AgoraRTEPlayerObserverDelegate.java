package io.agora.agora_rtc_ng;

/**
 * Player 观察者接口
 */
public interface AgoraRTEPlayerObserverDelegate {
    /**
     * 播放器状态改变回调
     */
    void onStateChanged(String playerId, int oldState, int newState, int errorCode, String errorMessage);

    /**
     * 播放位置改变回调
     */
    void onPositionChanged(String playerId, long currentTime, long utcTime);

    /**
     * 分辨率改变回调
     */
    void onResolutionChanged(String playerId, int width, int height);

    /**
     * 播放器事件回调
     */
    void onEvent(String playerId, int event);

    /**
     * 元数据回调
     */
    void onMetadata(String playerId, int type, byte[] data);

    /**
     * 播放器信息更新回调
     */
    void onPlayerInfoUpdated(String playerId, java.util.Map<String, Object> info);

    /**
     * 音频音量指示回调
     */
    void onAudioVolumeIndication(String playerId, int volume);
}
