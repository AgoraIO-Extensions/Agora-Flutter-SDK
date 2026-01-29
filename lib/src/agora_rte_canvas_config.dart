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

/// Canvas configuration.
///
/// Controls how video is rendered on a canvas, including render mode (how video
/// is scaled), mirror mode (horizontal flipping), and crop area.
///
/// Configuration can be set when creating a canvas with [AgoraRte.createCanvas],
/// or updated anytime using [AgoraRteCanvas.setConfigs].
///
/// Corresponds to native `AgoraRteCanvasConfig` (iOS) / `CanvasConfig` (Android).
///
/// **Since:** v4.4.0
///
/// **Example:**
/// ```dart
/// final canvasConfig = AgoraRteCanvasConfig(
///   videoRenderMode: AgoraRteVideoRenderMode.fit,
///   videoMirrorMode: AgoraRteVideoMirrorMode.enabled,
///   cropArea: AgoraRteRect(x: 0, y: 0, width: 1920, height: 1080),
/// );
/// final canvas = await rte.createCanvas(canvasConfig);
/// ```
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AgoraRteCanvasConfig implements AgoraSerializable {
  /// Video render mode.
  ///
  /// Determines how the video is scaled and displayed within the view:
  /// - [AgoraRteVideoRenderMode.hidden]: Fills the view completely, cropping
  ///   excess content. Use when you want no black bars.
  /// - [AgoraRteVideoRenderMode.fit]: Fits entire video within the view,
  ///   potentially adding letter-boxing. Use when you want to see all content.
  ///
  /// **Default:** [AgoraRteVideoRenderMode.hidden]
  ///
  /// **See also:** [AgoraRteVideoRenderMode]
  ///
  /// **Since:** v4.4.0
  @JsonKey(
    name: 'videoRenderMode',
    toJson: _videoRenderModeToJson,
    fromJson: _videoRenderModeFromJson,
  )
  final AgoraRteVideoRenderMode? videoRenderMode;

  /// Video mirror mode.
  ///
  /// Controls whether the video is horizontally flipped:
  /// - [AgoraRteVideoMirrorMode.auto]: SDK decides based on video source
  ///   (front camera is typically mirrored, rear camera is not)
  /// - [AgoraRteVideoMirrorMode.enabled]: Always mirror the video
  /// - [AgoraRteVideoMirrorMode.disabled]: Never mirror the video
  ///
  /// **Default:** [AgoraRteVideoMirrorMode.auto]
  ///
  /// **See also:** [AgoraRteVideoMirrorMode]
  ///
  /// **Since:** v4.4.0
  @JsonKey(
    name: 'videoMirrorMode',
    toJson: _videoMirrorModeToJson,
    fromJson: _videoMirrorModeFromJson,
  )
  final AgoraRteVideoMirrorMode? videoMirrorMode;

  /// Crop area for video rendering.
  ///
  /// Defines a rectangular region within the video frame to display. Only the
  /// pixels within this region will be rendered. Useful for displaying a specific
  /// portion of the video (e.g., cropping to a specific area of interest).
  ///
  /// If not set, the entire video frame is displayed.
  ///
  /// **See also:** [AgoraRteRect]
  ///
  /// **Since:** v4.4.0
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
