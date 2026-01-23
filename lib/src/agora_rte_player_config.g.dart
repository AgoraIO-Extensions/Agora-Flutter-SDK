// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names, deprecated_member_use_from_same_package, unused_element

part of 'agora_rte_player_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgoraRtePlayerConfig _$AgoraRtePlayerConfigFromJson(
        Map<String, dynamic> json) =>
    AgoraRtePlayerConfig(
      autoPlay: json['autoPlay'] as bool?,
      playbackSpeed: (json['playbackSpeed'] as num?)?.toInt(),
      playoutAudioTrackIdx: (json['playoutAudioTrackIdx'] as num?)?.toInt(),
      publishAudioTrackIdx: (json['publishAudioTrackIdx'] as num?)?.toInt(),
      audioTrackIdx: (json['audioTrackIdx'] as num?)?.toInt(),
      subtitleTrackIdx: (json['subtitleTrackIdx'] as num?)?.toInt(),
      externalSubtitleTrackIdx:
          (json['externalSubtitleTrackIdx'] as num?)?.toInt(),
      audioPitch: (json['audioPitch'] as num?)?.toInt(),
      playoutVolume: (json['playoutVolume'] as num?)?.toInt(),
      audioPlaybackDelay: (json['audioPlaybackDelay'] as num?)?.toInt(),
      audioDualMonoMode: (json['audioDualMonoMode'] as num?)?.toInt(),
      publishVolume: (json['publishVolume'] as num?)?.toInt(),
      loopCount: (json['loopCount'] as num?)?.toInt(),
      jsonParameter: json['jsonParameter'] as String?,
      abrSubscriptionLayer:
          _abrSubscriptionLayerFromJson(json['abrSubscriptionLayer']),
      abrFallbackLayer: _abrFallbackLayerFromJson(json['abrFallbackLayer']),
    );

Map<String, dynamic> _$AgoraRtePlayerConfigToJson(
    AgoraRtePlayerConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('autoPlay', instance.autoPlay);
  writeNotNull('playbackSpeed', instance.playbackSpeed);
  writeNotNull('playoutAudioTrackIdx', instance.playoutAudioTrackIdx);
  writeNotNull('publishAudioTrackIdx', instance.publishAudioTrackIdx);
  writeNotNull('audioTrackIdx', instance.audioTrackIdx);
  writeNotNull('subtitleTrackIdx', instance.subtitleTrackIdx);
  writeNotNull('externalSubtitleTrackIdx', instance.externalSubtitleTrackIdx);
  writeNotNull('audioPitch', instance.audioPitch);
  writeNotNull('playoutVolume', instance.playoutVolume);
  writeNotNull('audioPlaybackDelay', instance.audioPlaybackDelay);
  writeNotNull('audioDualMonoMode', instance.audioDualMonoMode);
  writeNotNull('publishVolume', instance.publishVolume);
  writeNotNull('loopCount', instance.loopCount);
  writeNotNull('jsonParameter', instance.jsonParameter);
  writeNotNull('abrSubscriptionLayer',
      _abrSubscriptionLayerToJson(instance.abrSubscriptionLayer));
  writeNotNull(
      'abrFallbackLayer', _abrFallbackLayerToJson(instance.abrFallbackLayer));
  return val;
}
