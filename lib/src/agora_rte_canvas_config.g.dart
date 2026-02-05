// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names, deprecated_member_use_from_same_package, unused_element

part of 'agora_rte_canvas_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgoraRteCanvasConfig _$AgoraRteCanvasConfigFromJson(
        Map<String, dynamic> json) =>
    AgoraRteCanvasConfig(
      videoRenderMode: _videoRenderModeFromJson(json['videoRenderMode']),
      videoMirrorMode: _videoMirrorModeFromJson(json['videoMirrorMode']),
      cropArea: _cropAreaFromJson(json['cropArea']),
    );

Map<String, dynamic> _$AgoraRteCanvasConfigToJson(
    AgoraRteCanvasConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'videoRenderMode', _videoRenderModeToJson(instance.videoRenderMode));
  writeNotNull(
      'videoMirrorMode', _videoMirrorModeToJson(instance.videoMirrorMode));
  writeNotNull('cropArea', _cropAreaToJson(instance.cropArea));
  return val;
}
