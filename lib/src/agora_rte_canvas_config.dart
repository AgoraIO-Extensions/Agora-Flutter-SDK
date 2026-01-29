import 'package:json_annotation/json_annotation.dart';
import 'package:agora_rtc_engine/src/agora_rte_enums.dart';
import 'package:agora_rtc_engine/src/agora_rte_config.dart';
import 'package:agora_rtc_engine/src/_serializable.dart';

part 'agora_rte_canvas_config.g.dart';

/// Helper converters for enum fields
int? _videoRenderModeToJson(AgoraRteVideoRenderMode? mode) => mode?.index;
AgoraRteVideoRenderMode? _videoRenderModeFromJson(dynamic value) {
  if (value == null) return null;
  if (value is int) return AgoraRteVideoRenderMode.values[value];
  return null;
}

int? _videoMirrorModeToJson(AgoraRteVideoMirrorMode? mode) => mode?.index;
AgoraRteVideoMirrorMode? _videoMirrorModeFromJson(dynamic value) {
  if (value == null) return null;
  if (value is int) return AgoraRteVideoMirrorMode.values[value];
  return null;
}

Map<String, dynamic>? _cropAreaToJson(AgoraRteRect? rect) => rect?.toJson();
AgoraRteRect? _cropAreaFromJson(dynamic value) {
  if (value == null) return null;
  if (value is Map) {
    return AgoraRteRect.fromJson(Map<String, dynamic>.from(value));
  }
  return null;
}

/// Canvas configuration
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AgoraRteCanvasConfig implements AgoraSerializable {
  @JsonKey(
    name: 'videoRenderMode',
    toJson: _videoRenderModeToJson,
    fromJson: _videoRenderModeFromJson,
  )
  final AgoraRteVideoRenderMode? videoRenderMode;

  @JsonKey(
    name: 'videoMirrorMode',
    toJson: _videoMirrorModeToJson,
    fromJson: _videoMirrorModeFromJson,
  )
  final AgoraRteVideoMirrorMode? videoMirrorMode;

  @JsonKey(
    name: 'cropArea',
    toJson: _cropAreaToJson,
    fromJson: _cropAreaFromJson,
  )
  final AgoraRteRect? cropArea;

  const AgoraRteCanvasConfig({
    this.videoRenderMode,
    this.videoMirrorMode,
    this.cropArea,
  });

  factory AgoraRteCanvasConfig.fromJson(Map<String, dynamic> json) =>
      _$AgoraRteCanvasConfigFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AgoraRteCanvasConfigToJson(this);
}
