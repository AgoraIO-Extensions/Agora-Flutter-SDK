package io.agora.agora_rtc_ng;

/**
 * Player observer interface
 */
public interface AgoraRTEPlayerObserverDelegate {
    /**
     * Player state changed callback
     */
    void onStateChanged(String playerId, int oldState, int newState, int errorCode, String errorMessage);

    /**
     * Playback position changed callback
     */
    void onPositionChanged(String playerId, long currentTime, long utcTime);

    /**
     * Resolution changed callback
     */
    void onResolutionChanged(String playerId, int width, int height);

    /**
     * Player event callback
     */
    void onEvent(String playerId, int event);

    /**
     * Metadata callback
     */
    void onMetadata(String playerId, int type, byte[] data);

    /**
     * Player info updated callback
     */
    void onPlayerInfoUpdated(String playerId, java.util.Map<String, Object> info);

    /**
     * Audio volume indication callback
     */
    void onAudioVolumeIndication(String playerId, int volume);
}
