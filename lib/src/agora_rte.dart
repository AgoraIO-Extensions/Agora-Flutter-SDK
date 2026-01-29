import 'package:agora_rtc_engine/agora_rte_engine.dart';
import 'package:flutter/foundation.dart';
export 'agora_rte_config.dart' show AgoraRteRect, AgoraRteViewConfig, AgoraRtePlayerStats, AgoraRtePlayerInfo;

/// RTE observer callback
abstract class AgoraRteObserver {}

/// Player observer callback
abstract class AgoraRtePlayerObserver {
  void onStateChanged(AgoraRtePlayerState oldState, AgoraRtePlayerState newState,
      AgoraRteErrorCode? error);
  void onPositionChanged(int currentTime, int utcTime);
  void onResolutionChanged(int width, int height);
  void onEvent(AgoraRtePlayerEvent event);
  void onMetadata(AgoraRtePlayerMetadataType type, Uint8List data);
  void onPlayerInfoUpdated(AgoraRtePlayerInfo info);
  void onAudioVolumeIndication(int volume);
}

/// RTE main interface
abstract class AgoraRte {
  // Future<void> createFromBridge();
  Future<void> createWithConfig(AgoraRteConfig config);
  Future<void> initMediaEngine();
  Future<void> destroy();
  Future<void> setConfigs(AgoraRteConfig config);
  Future<AgoraRteConfig> getConfigs();

  /// Create player
  Future<AgoraRtePlayer> createPlayer(AgoraRtePlayerConfig config);

  /// Destroy player
  Future<void> destroyPlayer(String playerId);

  /// Create canvas
  Future<AgoraRteCanvas> createCanvas(AgoraRteCanvasConfig config);

  /// Destroy canvas
  Future<void> destroyCanvas(String canvasId);
}

/// RTE player interface
abstract class AgoraRtePlayer {
  String get playerId;
  static Future<void> preloadWithUrl(String url) async {}
  Future<void> openWithUrl(String url, int startTime);
  Future<void> openWithCustomSourceProvider(dynamic provider, int startTime);
  Future<void> openWithStream(dynamic stream);
  Future<void> switchWithUrl(String url, bool syncPts);
  Future<AgoraRtePlayerStats> getStats();
  Future<void> setCanvas(AgoraRteCanvas canvas);
  Future<void> play();
  Future<void> stop();
  Future<void> pause();
  Future<void> seek(int newTime);
  Future<void> muteAudio(bool mute);
  Future<void> muteVideo(bool mute);
  Future<int> getPosition();
  Future<AgoraRtePlayerInfo> getInfo();
  Future<void> setConfigs(AgoraRtePlayerConfig config);
  Future<AgoraRtePlayerConfig> getConfigs();
  Future<void> registerObserver(AgoraRtePlayerObserver observer);
  Future<void> unregisterObserver(AgoraRtePlayerObserver observer);
}
/// RTE canvas interface
abstract class AgoraRteCanvas {
  String get canvasId;
  Future<void> setConfigs(AgoraRteCanvasConfig config);
  Future<AgoraRteCanvasConfig> getConfigs();
  Future<void> addView(int viewPtr, {AgoraRteViewConfig? config});
  Future<void> removeView(int viewPtr, {AgoraRteViewConfig? config});
}
