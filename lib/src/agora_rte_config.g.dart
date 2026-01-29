// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names, deprecated_member_use_from_same_package, unused_element

part of 'agora_rte_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgoraRteConfig _$AgoraRteConfigFromJson(Map<String, dynamic> json) =>
    AgoraRteConfig(
      appId: json['appId'] as String?,
      logFolder: json['logFolder'] as String?,
      logFileSize: (json['logFileSize'] as num?)?.toInt(),
      areaCode: (json['areaCode'] as num?)?.toInt(),
      cloudProxy: json['cloudProxy'] as String?,
      jsonParameter: json['jsonParameter'] as String?,
      useStringUid: json['useStringUid'] as bool?,
    );

Map<String, dynamic> _$AgoraRteConfigToJson(AgoraRteConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('appId', instance.appId);
  writeNotNull('logFolder', instance.logFolder);
  writeNotNull('logFileSize', instance.logFileSize);
  writeNotNull('areaCode', instance.areaCode);
  writeNotNull('cloudProxy', instance.cloudProxy);
  writeNotNull('jsonParameter', instance.jsonParameter);
  writeNotNull('useStringUid', instance.useStringUid);
  return val;
}

AgoraRteRect _$AgoraRteRectFromJson(Map<String, dynamic> json) => AgoraRteRect(
      x: (json['x'] as num?)?.toInt() ?? 0,
      y: (json['y'] as num?)?.toInt() ?? 0,
      width: (json['width'] as num?)?.toInt() ?? 0,
      height: (json['height'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$AgoraRteRectToJson(AgoraRteRect instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('x', instance.x);
  writeNotNull('y', instance.y);
  writeNotNull('width', instance.width);
  writeNotNull('height', instance.height);
  return val;
}

AgoraRteViewConfig _$AgoraRteViewConfigFromJson(Map<String, dynamic> json) =>
    AgoraRteViewConfig(
      cropArea: _cropAreaFromJson(json['cropArea']),
    );

Map<String, dynamic> _$AgoraRteViewConfigToJson(AgoraRteViewConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('cropArea', _cropAreaToJson(instance.cropArea));
  return val;
}

AgoraRtePlayerStats _$AgoraRtePlayerStatsFromJson(Map<String, dynamic> json) =>
    AgoraRtePlayerStats(
      videoDecodeFrameRate:
          (json['videoDecodeFrameRate'] as num?)?.toInt() ?? 0,
      videoRenderFrameRate:
          (json['videoRenderFrameRate'] as num?)?.toInt() ?? 0,
      videoBitrate: (json['videoBitrate'] as num?)?.toInt() ?? 0,
      audioBitrate: (json['audioBitrate'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$AgoraRtePlayerStatsToJson(AgoraRtePlayerStats instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('videoDecodeFrameRate', instance.videoDecodeFrameRate);
  writeNotNull('videoRenderFrameRate', instance.videoRenderFrameRate);
  writeNotNull('videoBitrate', instance.videoBitrate);
  writeNotNull('audioBitrate', instance.audioBitrate);
  return val;
}

AgoraRtePlayerInfo _$AgoraRtePlayerInfoFromJson(Map<String, dynamic> json) =>
    AgoraRtePlayerInfo(
      state: (json['state'] as num?)?.toInt() ?? 0,
      duration: (json['duration'] as num?)?.toInt() ?? 0,
      streamCount: (json['streamCount'] as num?)?.toInt() ?? 0,
      hasAudio: json['hasAudio'] as bool? ?? false,
      hasVideo: json['hasVideo'] as bool? ?? false,
      isAudioMuted: json['isAudioMuted'] as bool? ?? false,
      isVideoMuted: json['isVideoMuted'] as bool? ?? false,
      videoHeight: (json['videoHeight'] as num?)?.toInt() ?? 0,
      videoWidth: (json['videoWidth'] as num?)?.toInt() ?? 0,
      abrSubscriptionLayer: json['abrSubscriptionLayer'] == null
          ? AgoraRteAbrSubscriptionLayer.high
          : _abrSubscriptionLayerFromJson(json['abrSubscriptionLayer']),
      audioSampleRate: (json['audioSampleRate'] as num?)?.toInt() ?? 0,
      audioChannels: (json['audioChannels'] as num?)?.toInt() ?? 0,
      audioBitsPerSample: (json['audioBitsPerSample'] as num?)?.toInt() ?? 0,
      currentUrl: json['currentUrl'] as String? ?? '',
    );

Map<String, dynamic> _$AgoraRtePlayerInfoToJson(AgoraRtePlayerInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('state', instance.state);
  writeNotNull('duration', instance.duration);
  writeNotNull('streamCount', instance.streamCount);
  writeNotNull('hasAudio', instance.hasAudio);
  writeNotNull('hasVideo', instance.hasVideo);
  writeNotNull('isAudioMuted', instance.isAudioMuted);
  writeNotNull('isVideoMuted', instance.isVideoMuted);
  writeNotNull('videoHeight', instance.videoHeight);
  writeNotNull('videoWidth', instance.videoWidth);
  writeNotNull('abrSubscriptionLayer',
      _abrSubscriptionLayerToJson(instance.abrSubscriptionLayer));
  writeNotNull('audioSampleRate', instance.audioSampleRate);
  writeNotNull('audioChannels', instance.audioChannels);
  writeNotNull('audioBitsPerSample', instance.audioBitsPerSample);
  writeNotNull('currentUrl', instance.currentUrl);
  return val;
}
