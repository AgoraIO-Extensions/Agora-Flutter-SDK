import 'package:flutter/foundation.dart';
import 'agora_rte_enums.dart';
/// 矩形区域
class AgoraRteRect {
  final int x;
  final int y;
  final int width;
  final int height;

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

/// 视图配置
class AgoraRteViewConfig {
  final AgoraRteRect? cropArea;

  const AgoraRteViewConfig({this.cropArea});

  Map<String, dynamic> toJson() => {
        'cropArea': cropArea?.toJson(),
      };
}

/// RTE 配置
class AgoraRteConfig {
  final String? appId;
  final String? logFolder;
  final int? logFileSize;
  final int? areaCode;
  final String? cloudProxy;
  final String? jsonParameter;

  const AgoraRteConfig({
    this.appId,
    this.logFolder,
    this.logFileSize,
    this.areaCode,
    this.cloudProxy,
    this.jsonParameter,
  });

  Map<String, dynamic> toJson() => {
        'appId': appId,
        'logFolder': logFolder,
        'logFileSize': logFileSize,
        'areaCode': areaCode,
        'cloudProxy': cloudProxy,
        'jsonParameter': jsonParameter,
      };
}

/// 播放器配置
class AgoraRtePlayerConfig {
  final bool? autoPlay;
  final int? playbackSpeed;
  final int? playoutAudioTrackIdx;
  final int? publishAudioTrackIdx;
  final int? audioTrackIdx;
  final int? subtitleTrackIdx;
  final int? externalSubtitleTrackIdx;
  final int? audioPitch;
  final int? playoutVolume;
  final int? audioPlaybackDelay;
  final int? audioDualMonoMode;
  final int? publishVolume;
  final int? loopCount;
  final String? jsonParameter;
  final AgoraRteAbrSubscriptionLayer? abrSubscriptionLayer;
  final AgoraRteAbrFallbackLayer? abrFallbackLayer;

  const AgoraRtePlayerConfig({
    this.autoPlay,
    this.playbackSpeed,
    this.playoutAudioTrackIdx,
    this.publishAudioTrackIdx,
    this.audioTrackIdx,
    this.subtitleTrackIdx,
    this.externalSubtitleTrackIdx,
    this.audioPitch,
    this.playoutVolume,
    this.audioPlaybackDelay,
    this.audioDualMonoMode,
    this.publishVolume,
    this.loopCount,
    this.jsonParameter,
    this.abrSubscriptionLayer,
    this.abrFallbackLayer,
  });

  Map<String, dynamic> toJson() => {
        'autoPlay': autoPlay,
        'playbackSpeed': playbackSpeed,
        'playoutAudioTrackIdx': playoutAudioTrackIdx,
        'publishAudioTrackIdx': publishAudioTrackIdx,
        'audioTrackIdx': audioTrackIdx,
        'subtitleTrackIdx': subtitleTrackIdx,
        'externalSubtitleTrackIdx': externalSubtitleTrackIdx,
        'audioPitch': audioPitch,
        'playoutVolume': playoutVolume,
        'audioPlaybackDelay': audioPlaybackDelay,
        'audioDualMonoMode': audioDualMonoMode,
        'publishVolume': publishVolume,
        'loopCount': loopCount,
        'jsonParameter': jsonParameter,
        'abrSubscriptionLayer': abrSubscriptionLayer?.index,
        'abrFallbackLayer': abrFallbackLayer?.index,
      };
}

/// 画布配置
class AgoraRteCanvasConfig {
  final AgoraRteVideoRenderMode? videoRenderMode;
  final AgoraRteVideoMirrorMode? videoMirrorMode;
  final AgoraRteRect? cropArea;

  const AgoraRteCanvasConfig({
    this.videoRenderMode,
    this.videoMirrorMode,
    this.cropArea,
  });

  Map<String, dynamic> toJson() => {
        'videoRenderMode': videoRenderMode?.index,
        'videoMirrorMode': videoMirrorMode?.index,
        'cropArea': cropArea?.toJson(),
      };
}

/// 播放器统计数据
class AgoraRtePlayerStats {
  final int videoDecodeFrameRate;
  final int videoRenderFrameRate;
  final int videoBitrate;
  final int audioBitrate;

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

/// 播放器信息
class AgoraRtePlayerInfo {
  final int state;
  final int duration;
  final int streamCount;
  final bool hasAudio;
  final bool hasVideo;
  final bool isAudioMuted;
  final bool isVideoMuted;
  final int videoHeight;
  final int videoWidth;
  final AgoraRteAbrSubscriptionLayer abrSubscriptionLayer;
  final int audioSampleRate;
  final int audioChannels;
  final int audioBitsPerSample;
  final String currentUrl;

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

/// RTE 观察者回调
abstract class AgoraRteObserver {}

/// 播放器观察者回调
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

/// RTE 主接口
abstract class AgoraRte {
  Future<void> createFromBridge();
  Future<void> createWithConfig(AgoraRteConfig config);
  Future<void> initMediaEngine();
  Future<void> destroy();
  Future<void> setConfigs(AgoraRteConfig config);
  Future<AgoraRteConfig> getConfigs();
  Future<String> appId();
  Future<String> logFolder();
  Future<int> logFileSize();
  Future<int> areaCode();
  Future<String> cloudProxy();
  Future<String> jsonParameter();
  Future<void> registerObserver(AgoraRteObserver observer);
  Future<void> unregisterObserver(AgoraRteObserver observer);
}

/// RTE 播放器接口
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

/// RTE 画布接口
abstract class AgoraRteCanvas {
  String get canvasId;
  Future<void> setConfigs(AgoraRteCanvasConfig config);
  Future<AgoraRteCanvasConfig> getConfigs();
  Future<void> addView(int viewPtr, {AgoraRteViewConfig? config});
  Future<void> removeView(int viewPtr, {AgoraRteViewConfig? config});
}
