import 'package:agora_rtc_engine/agora_rte_engine.dart';
import 'package:flutter/foundation.dart';
import 'agora_rte_enums.dart';
/// Rectangle area
class AgoraRteRect {
  final int? x;
  final int? y;
  final int? width;
  final int? height;

  const AgoraRteRect({
    this.x = 0,
    this.y = 0,
    this.width = 0,
    this.height = 0,
  });

  Map<String, dynamic> toJson() => {
        'x': x,
        'y': y,
        'width': width,
        'height': height,
      };

  factory AgoraRteRect.fromJson(Map<String, dynamic> json) => AgoraRteRect(
        x: json['x'] ?? 0,
        y: json['y'] ?? 0,
        width: json['width'] ?? 0,
        height: json['height'] ?? 0,
      );
}

/// View configuration
class AgoraRteViewConfig {
  final AgoraRteRect? cropArea;

  const AgoraRteViewConfig({this.cropArea});

  Map<String, dynamic> toJson() => {
        'cropArea': cropArea?.toJson(),
      };
}


/// Player statistics
class AgoraRtePlayerStats {
  final int? videoDecodeFrameRate;
  final int? videoRenderFrameRate;
  final int? videoBitrate;
  final int? audioBitrate;

  const AgoraRtePlayerStats({
    this.videoDecodeFrameRate = 0,
    this.videoRenderFrameRate = 0,
    this.videoBitrate = 0,
    this.audioBitrate = 0,
  });

  factory AgoraRtePlayerStats.fromJson(Map<String, dynamic> json) =>
      AgoraRtePlayerStats(
        videoDecodeFrameRate: json['videoDecodeFrameRate'] ?? 0,
        videoRenderFrameRate: json['videoRenderFrameRate'] ?? 0,
        videoBitrate: json['videoBitrate'] ?? 0,
        audioBitrate: json['audioBitrate'] ?? 0,
      );
}

/// Player information
class AgoraRtePlayerInfo {
  final int? state;
  final int? duration;
  final int? streamCount;
  final bool? hasAudio;
  final bool? hasVideo;
  final bool? isAudioMuted;
  final bool? isVideoMuted;
  final int? videoHeight;
  final int? videoWidth;
  final AgoraRteAbrSubscriptionLayer? abrSubscriptionLayer;
  final int? audioSampleRate;
  final int? audioChannels;
  final int? audioBitsPerSample;
  final String? currentUrl;

  const AgoraRtePlayerInfo({
    this.state = 0,
    this.duration = 0,
    this.streamCount = 0,
    this.hasAudio = false,
    this.hasVideo = false,
    this.isAudioMuted = false,
    this.isVideoMuted = false,
    this.videoHeight = 0,
    this.videoWidth = 0,
    this.abrSubscriptionLayer = AgoraRteAbrSubscriptionLayer.high,
    this.audioSampleRate = 0,
    this.audioChannels = 0,
    this.audioBitsPerSample = 0,
    this.currentUrl = '',
  });

  factory AgoraRtePlayerInfo.fromJson(Map<String, dynamic> json) =>
      AgoraRtePlayerInfo(
        state: json['state'] ?? 0,
        duration: json['duration'] ?? 0,
        streamCount: json['streamCount'] ?? 0,
        hasAudio: json['hasAudio'] ?? false,
        hasVideo: json['hasVideo'] ?? false,
        isAudioMuted: json['isAudioMuted'] ?? false,
        isVideoMuted: json['isVideoMuted'] ?? false,
        videoHeight: json['videoHeight'] ?? 0,
        videoWidth: json['videoWidth'] ?? 0,
        abrSubscriptionLayer: AgoraRteAbrSubscriptionLayer
            .values[json['abrSubscriptionLayer'] ?? 0],
        audioSampleRate: json['audioSampleRate'] ?? 0,
        audioChannels: json['audioChannels'] ?? 0,
        audioBitsPerSample: json['audioBitsPerSample'] ?? 0,
        currentUrl: json['currentUrl'] ?? '',
      );
}

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
