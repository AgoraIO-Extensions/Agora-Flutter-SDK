import '/src/_serializable.dart';
import '/src/binding_forward_export.dart';
import '/src/agora_rte_enums.dart';
part 'agora_rte_player_config.g.dart';

/// Player configuration
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AgoraRtePlayerConfig implements AgoraSerializable {
  /// 是否自动播放
  @JsonKey(name: 'autoPlay')
  final bool? autoPlay;

  /// 播放速度
  @JsonKey(name: 'playbackSpeed')
  final int? playbackSpeed;

  /// 播出音频轨道索引
  @JsonKey(name: 'playoutAudioTrackIdx')
  final int? playoutAudioTrackIdx;

  /// 发布音频轨道索引
  @JsonKey(name: 'publishAudioTrackIdx')
  final int? publishAudioTrackIdx;

  /// 音频轨道索引
  @JsonKey(name: 'audioTrackIdx')
  final int? audioTrackIdx;

  /// 字幕轨道索引
  @JsonKey(name: 'subtitleTrackIdx')
  final int? subtitleTrackIdx;

  /// 外部字幕轨道索引
  @JsonKey(name: 'externalSubtitleTrackIdx')
  final int? externalSubtitleTrackIdx;

  /// 音频音调
  @JsonKey(name: 'audioPitch')
  final int? audioPitch;

  /// 播出音量
  @JsonKey(name: 'playoutVolume')
  final int? playoutVolume;

  /// 音频播放延迟
  @JsonKey(name: 'audioPlaybackDelay')
  final int? audioPlaybackDelay;

  /// 音频双声道模式
  @JsonKey(name: 'audioDualMonoMode')
  final int? audioDualMonoMode;

  /// 发布音量
  @JsonKey(name: 'publishVolume')
  final int? publishVolume;

  /// 循环次数
  @JsonKey(name: 'loopCount')
  final int? loopCount;

  /// JSON 参数
  @JsonKey(name: 'jsonParameter')
  final String? jsonParameter;

  /// ABR 订阅层
  @JsonKey(
    name: 'abrSubscriptionLayer',
    toJson: _abrSubscriptionLayerToJson,
    fromJson: _abrSubscriptionLayerFromJson,
  )
  final AgoraRteAbrSubscriptionLayer? abrSubscriptionLayer;

  /// ABR 回退层
  @JsonKey(
    name: 'abrFallbackLayer',
    toJson: _abrFallbackLayerToJson,
    fromJson: _abrFallbackLayerFromJson,
  )
  final AgoraRteAbrFallbackLayer? abrFallbackLayer;

  /// @nodoc
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

  /// @nodoc
  factory AgoraRtePlayerConfig.fromJson(Map<String, dynamic> json) =>
      _$AgoraRtePlayerConfigFromJson(json);

  /// @nodoc
  @override
  Map<String, dynamic> toJson() => _$AgoraRtePlayerConfigToJson(this);
}

// 枚举转换辅助函数
int? _abrSubscriptionLayerToJson(AgoraRteAbrSubscriptionLayer? layer) {
  return layer?.index;
}

AgoraRteAbrSubscriptionLayer? _abrSubscriptionLayerFromJson(Object? json) {
  if (json is int &&
      json >= 0 &&
      json < AgoraRteAbrSubscriptionLayer.values.length) {
    return AgoraRteAbrSubscriptionLayer.values[json];
  }
  return null;
}

int? _abrFallbackLayerToJson(AgoraRteAbrFallbackLayer? layer) {
  return layer?.index;
}

AgoraRteAbrFallbackLayer? _abrFallbackLayerFromJson(Object? json) {
  if (json is int &&
      json >= 0 &&
      json < AgoraRteAbrFallbackLayer.values.length) {
    return AgoraRteAbrFallbackLayer.values[json];
  }
  return null;
}
