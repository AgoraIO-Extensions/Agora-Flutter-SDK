import 'package:json_annotation/json_annotation.dart';
import '/src/_serializable.dart';
import '/src/binding_forward_export.dart';
import 'agora_rte_enums.dart';
part 'agora_rte_config.g.dart';

/// RTE configuration
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AgoraRteConfig implements AgoraSerializable {
  @JsonKey(name: 'appId')
  final String? appId;
  @JsonKey(name: 'logFolder')
  final String? logFolder;
  @JsonKey(name: 'logFileSize')
  final int? logFileSize;
  @JsonKey(name: 'areaCode')
  final int? areaCode;
  @JsonKey(name: 'cloudProxy')
  final String? cloudProxy;
  @JsonKey(name: 'jsonParameter')
  final String? jsonParameter;
  @JsonKey(name: 'useStringUid')
  final bool? useStringUid;

  AgoraRteConfig({
    this.appId,
    this.logFolder,
    this.logFileSize,
    this.areaCode,
    this.cloudProxy,
    this.jsonParameter,
    this.useStringUid,
  });

  /// @nodoc
  factory AgoraRteConfig.fromJson(Map<String, dynamic> json) =>
      _$AgoraRteConfigFromJson(json);

  /// @nodoc
  @override
  Map<String, dynamic> toJson() => _$AgoraRteConfigToJson(this);
}

/// Rectangle area
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AgoraRteRect implements AgoraSerializable {
  @JsonKey(name: 'x')
  final int? x;
  @JsonKey(name: 'y')
  final int? y;
  @JsonKey(name: 'width')
  final int? width;
  @JsonKey(name: 'height')
  final int? height;

  const AgoraRteRect({
    this.x = 0,
    this.y = 0,
    this.width = 0,
    this.height = 0,
  });

  /// @nodoc
  factory AgoraRteRect.fromJson(Map<String, dynamic> json) =>
      _$AgoraRteRectFromJson(json);

  /// @nodoc
  @override
  Map<String, dynamic> toJson() => _$AgoraRteRectToJson(this);
}

/// View configuration
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AgoraRteViewConfig implements AgoraSerializable {
  @JsonKey(
    name: 'cropArea',
    toJson: _cropAreaToJson,
    fromJson: _cropAreaFromJson,
  )
  final AgoraRteRect? cropArea;

  const AgoraRteViewConfig({this.cropArea});

  /// @nodoc
  factory AgoraRteViewConfig.fromJson(Map<String, dynamic> json) =>
      _$AgoraRteViewConfigFromJson(json);

  /// @nodoc
  @override
  Map<String, dynamic> toJson() => _$AgoraRteViewConfigToJson(this);
}

/// Helper converters for AgoraRteViewConfig
Map<String, dynamic>? _cropAreaToJson(AgoraRteRect? rect) => rect?.toJson();
AgoraRteRect? _cropAreaFromJson(dynamic value) {
  if (value == null) return null;
  if (value is Map) {
    return AgoraRteRect.fromJson(Map<String, dynamic>.from(value));
  }
  return null;
}

/// Player statistics
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AgoraRtePlayerStats implements AgoraSerializable {
  @JsonKey(name: 'videoDecodeFrameRate')
  final int? videoDecodeFrameRate;
  @JsonKey(name: 'videoRenderFrameRate')
  final int? videoRenderFrameRate;
  @JsonKey(name: 'videoBitrate')
  final int? videoBitrate;
  @JsonKey(name: 'audioBitrate')
  final int? audioBitrate;

  const AgoraRtePlayerStats({
    this.videoDecodeFrameRate = 0,
    this.videoRenderFrameRate = 0,
    this.videoBitrate = 0,
    this.audioBitrate = 0,
  });

  /// @nodoc
  factory AgoraRtePlayerStats.fromJson(Map<String, dynamic> json) =>
      _$AgoraRtePlayerStatsFromJson(json);

  /// @nodoc
  @override
  Map<String, dynamic> toJson() => _$AgoraRtePlayerStatsToJson(this);
}

/// Player information
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AgoraRtePlayerInfo implements AgoraSerializable {
  @JsonKey(name: 'state')
  final int? state;
  @JsonKey(name: 'duration')
  final int? duration;
  @JsonKey(name: 'streamCount')
  final int? streamCount;
  @JsonKey(name: 'hasAudio')
  final bool? hasAudio;
  @JsonKey(name: 'hasVideo')
  final bool? hasVideo;
  @JsonKey(name: 'isAudioMuted')
  final bool? isAudioMuted;
  @JsonKey(name: 'isVideoMuted')
  final bool? isVideoMuted;
  @JsonKey(name: 'videoHeight')
  final int? videoHeight;
  @JsonKey(name: 'videoWidth')
  final int? videoWidth;
  @JsonKey(
    name: 'abrSubscriptionLayer',
    toJson: _abrSubscriptionLayerToJson,
    fromJson: _abrSubscriptionLayerFromJson,
  )
  final AgoraRteAbrSubscriptionLayer? abrSubscriptionLayer;
  @JsonKey(name: 'audioSampleRate')
  final int? audioSampleRate;
  @JsonKey(name: 'audioChannels')
  final int? audioChannels;
  @JsonKey(name: 'audioBitsPerSample')
  final int? audioBitsPerSample;
  @JsonKey(name: 'currentUrl')
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

  /// @nodoc
  factory AgoraRtePlayerInfo.fromJson(Map<String, dynamic> json) =>
      _$AgoraRtePlayerInfoFromJson(json);

  /// @nodoc
  @override
  Map<String, dynamic> toJson() => _$AgoraRtePlayerInfoToJson(this);
}

/// Helper converters for AgoraRtePlayerInfo
int? _abrSubscriptionLayerToJson(AgoraRteAbrSubscriptionLayer? layer) =>
    layer?.index;
AgoraRteAbrSubscriptionLayer? _abrSubscriptionLayerFromJson(dynamic value) {
  if (value == null) return null;
  if (value is int &&
      value >= 0 &&
      value < AgoraRteAbrSubscriptionLayer.values.length) {
    return AgoraRteAbrSubscriptionLayer.values[value];
  }
  return null;
}
