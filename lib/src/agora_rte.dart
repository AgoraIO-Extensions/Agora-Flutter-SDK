import 'package:flutter/foundation.dart';

/// RTE 错误代码
enum AgoraRteErrorCode {
  /// 0: 成功
  ok,

  /// 1: 默认错误，未具体分类
  errorDefault,

  /// 2: 调用 API 时传递的参数无效
  errorInvalidArgument,

  /// 3: 不支持的 API 操作
  errorInvalidOperation,

  /// 4: 网络错误
  errorNetworkError,

  /// 5: 身份验证失败
  errorAuthenticationFailed,

  /// 6: 未找到流
  errorStreamNotFound,
}

/// 播放器状态
enum AgoraRtePlayerState {
  /// 0: 空闲状态
  idle,

  /// 1: 正在打开
  opening,

  /// 2: 打开完成
  openCompleted,

  /// 3: 正在播放
  playing,

  /// 4: 已暂停
  paused,

  /// 5: 播放完成
  playbackCompleted,

  /// 6: 已停止
  stopped,

  /// 7: 失败状态
  failed,
}

/// 播放器事件
enum AgoraRtePlayerEvent {
  /// 0: 开始跳转到指定位置播放
  seekBegin,

  /// 1: 跳转完成
  seekComplete,

  /// 2: 跳转到新播放位置时发生错误
  seekError,

  /// 3: 当前缓存数据不足以支持播放
  bufferLow,

  /// 4: 当前缓存数据刚好足以支持播放
  bufferRecover,

  /// 5: 音频或视频播放开始卡顿
  freezeStart,

  /// 6: 音频或视频播放恢复，不再卡顿
  freezeStop,

  /// 7: 一轮循环播放完成
  oneLoopPlaybackCompleted,

  /// 8: URL 身份验证即将过期
  authenticationWillExpire,

  /// 9: 开启降级选项时，由于网络差，ABR 降级到纯音频层
  abrFallbackToAudioOnlyLayer,

  /// 10: 开启降级选项时，ABR 从纯音频层恢复到视频层
  abrRecoverFromAudioOnlyLayer,

  /// 11: 开始切换到新 URL
  switchBegin,

  /// 12: 切换到新 URL 完成
  switchComplete,

  /// 13: 切换到新 URL 时发生错误
  switchError,

  /// 14: 视频第一帧已显示
  firstDisplayed,

  /// 15: 缓存文件数量达到最大值
  reachCacheFileMaxCount,

  /// 16: 缓存文件大小达到最大值
  reachCacheFileMaxSize,

  /// 17: 开始尝试打开新 URL
  tryOpenStart,

  /// 18: 尝试打开新 URL 成功
  tryOpenSucceed,

  /// 19: 尝试打开新 URL 失败
  tryOpenFailed,

  /// 20: 音轨已更改
  audioTrackChanged,
}

/// 视频渲染模式
enum AgoraRteVideoRenderMode {
  /// 0: 隐藏模式，填满整个视图，超出部分将被裁剪
  hidden,

  /// 1: 适应模式，在视图内完整渲染整个图像
  fit,
}

/// 镜像模式
enum AgoraRteVideoMirrorMode {
  /// 0: SDK 决定镜像模式
  auto,

  /// 1: 启用镜像模式
  enabled,

  /// 2: 禁用镜像模式
  disabled,
}

/// 元数据类型
enum AgoraRtePlayerMetadataType {
  /// SEI 类型
  sei,
}

/// ABR 订阅层
enum AgoraRteAbrSubscriptionLayer {
  /// 0: 高质量视频流，分辨率和码率最高
  high,

  /// 1: 低质量视频流，分辨率和码率最低
  low,

  /// 2: Layer1 视频流，分辨率和码率低于高质量流
  layer1,

  /// 3: Layer2 视频流，分辨率和码率低于 layer1
  layer2,

  /// 4: Layer3 视频流，分辨率和码率低于 layer2
  layer3,

  /// 5: Layer4 视频流，分辨率和码率低于 layer3
  layer4,

  /// 6: Layer5 视频流，分辨率和码率低于 layer4
  layer5,

  /// 7: Layer6 视频流，分辨率和码率低于 layer5
  layer6,
}

/// ABR 降级层
enum AgoraRteAbrFallbackLayer {
  /// 0: 网络差时不降级到低分辨率流，可能降级到可伸缩视频编码但保持高质量分辨率
  disabled,

  /// 1: 网络差时接收低质量视频流
  low,

  /// 2: 网络差时先降级到低质量流，若存在则继续降级到音频层，若网络极差则仅接收音频
  audioOnly,

  /// 3: Layer1 降级
  layer1,

  /// 4: Layer2 降级
  layer2,

  /// 5: Layer3 降级
  layer3,

  /// 6: Layer4 降级
  layer4,

  /// 7: Layer5 降级
  layer5,

  /// 8: Layer6 降级
  layer6,
}

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
