// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names, deprecated_member_use_from_same_package, unused_element

part of 'agora_base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoDimensions _$VideoDimensionsFromJson(Map<String, dynamic> json) =>
    VideoDimensions(
      width: json['width'] as int?,
      height: json['height'] as int?,
    );

Map<String, dynamic> _$VideoDimensionsToJson(VideoDimensions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('width', instance.width);
  writeNotNull('height', instance.height);
  return val;
}

SenderOptions _$SenderOptionsFromJson(Map<String, dynamic> json) =>
    SenderOptions(
      ccMode: $enumDecodeNullable(_$TCcModeEnumMap, json['ccMode']),
      codecType:
          $enumDecodeNullable(_$VideoCodecTypeEnumMap, json['codecType']),
      targetBitrate: json['targetBitrate'] as int?,
    );

Map<String, dynamic> _$SenderOptionsToJson(SenderOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ccMode', _$TCcModeEnumMap[instance.ccMode]);
  writeNotNull('codecType', _$VideoCodecTypeEnumMap[instance.codecType]);
  writeNotNull('targetBitrate', instance.targetBitrate);
  return val;
}

const _$TCcModeEnumMap = {
  TCcMode.ccEnabled: 0,
  TCcMode.ccDisabled: 1,
};

const _$VideoCodecTypeEnumMap = {
  VideoCodecType.videoCodecNone: 0,
  VideoCodecType.videoCodecVp8: 1,
  VideoCodecType.videoCodecH264: 2,
  VideoCodecType.videoCodecH265: 3,
  VideoCodecType.videoCodecGeneric: 6,
  VideoCodecType.videoCodecGenericH264: 7,
  VideoCodecType.videoCodecAv1: 12,
  VideoCodecType.videoCodecVp9: 13,
  VideoCodecType.videoCodecGenericJpeg: 20,
};

EncodedAudioFrameAdvancedSettings _$EncodedAudioFrameAdvancedSettingsFromJson(
        Map<String, dynamic> json) =>
    EncodedAudioFrameAdvancedSettings(
      speech: json['speech'] as bool?,
      sendEvenIfEmpty: json['sendEvenIfEmpty'] as bool?,
    );

Map<String, dynamic> _$EncodedAudioFrameAdvancedSettingsToJson(
    EncodedAudioFrameAdvancedSettings instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('speech', instance.speech);
  writeNotNull('sendEvenIfEmpty', instance.sendEvenIfEmpty);
  return val;
}

EncodedAudioFrameInfo _$EncodedAudioFrameInfoFromJson(
        Map<String, dynamic> json) =>
    EncodedAudioFrameInfo(
      codec: $enumDecodeNullable(_$AudioCodecTypeEnumMap, json['codec']),
      sampleRateHz: json['sampleRateHz'] as int?,
      samplesPerChannel: json['samplesPerChannel'] as int?,
      numberOfChannels: json['numberOfChannels'] as int?,
      advancedSettings: json['advancedSettings'] == null
          ? null
          : EncodedAudioFrameAdvancedSettings.fromJson(
              json['advancedSettings'] as Map<String, dynamic>),
      captureTimeMs: json['captureTimeMs'] as int?,
    );

Map<String, dynamic> _$EncodedAudioFrameInfoToJson(
    EncodedAudioFrameInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('codec', _$AudioCodecTypeEnumMap[instance.codec]);
  writeNotNull('sampleRateHz', instance.sampleRateHz);
  writeNotNull('samplesPerChannel', instance.samplesPerChannel);
  writeNotNull('numberOfChannels', instance.numberOfChannels);
  writeNotNull('advancedSettings', instance.advancedSettings?.toJson());
  writeNotNull('captureTimeMs', instance.captureTimeMs);
  return val;
}

const _$AudioCodecTypeEnumMap = {
  AudioCodecType.audioCodecOpus: 1,
  AudioCodecType.audioCodecPcma: 3,
  AudioCodecType.audioCodecPcmu: 4,
  AudioCodecType.audioCodecG722: 5,
  AudioCodecType.audioCodecAaclc: 8,
  AudioCodecType.audioCodecHeaac: 9,
  AudioCodecType.audioCodecJc1: 10,
  AudioCodecType.audioCodecHeaac2: 11,
  AudioCodecType.audioCodecLpcnet: 12,
};

AudioPcmDataInfo _$AudioPcmDataInfoFromJson(Map<String, dynamic> json) =>
    AudioPcmDataInfo(
      samplesPerChannel: json['samplesPerChannel'] as int?,
      channelNum: json['channelNum'] as int?,
      samplesOut: json['samplesOut'] as int?,
      elapsedTimeMs: json['elapsedTimeMs'] as int?,
      ntpTimeMs: json['ntpTimeMs'] as int?,
    );

Map<String, dynamic> _$AudioPcmDataInfoToJson(AudioPcmDataInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('samplesPerChannel', instance.samplesPerChannel);
  writeNotNull('channelNum', instance.channelNum);
  writeNotNull('samplesOut', instance.samplesOut);
  writeNotNull('elapsedTimeMs', instance.elapsedTimeMs);
  writeNotNull('ntpTimeMs', instance.ntpTimeMs);
  return val;
}

VideoSubscriptionOptions _$VideoSubscriptionOptionsFromJson(
        Map<String, dynamic> json) =>
    VideoSubscriptionOptions(
      type: $enumDecodeNullable(_$VideoStreamTypeEnumMap, json['type']),
      encodedFrameOnly: json['encodedFrameOnly'] as bool?,
    );

Map<String, dynamic> _$VideoSubscriptionOptionsToJson(
    VideoSubscriptionOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', _$VideoStreamTypeEnumMap[instance.type]);
  writeNotNull('encodedFrameOnly', instance.encodedFrameOnly);
  return val;
}

const _$VideoStreamTypeEnumMap = {
  VideoStreamType.videoStreamHigh: 0,
  VideoStreamType.videoStreamLow: 1,
};

EncodedVideoFrameInfo _$EncodedVideoFrameInfoFromJson(
        Map<String, dynamic> json) =>
    EncodedVideoFrameInfo(
      codecType:
          $enumDecodeNullable(_$VideoCodecTypeEnumMap, json['codecType']),
      width: json['width'] as int?,
      height: json['height'] as int?,
      framesPerSecond: json['framesPerSecond'] as int?,
      frameType:
          $enumDecodeNullable(_$VideoFrameTypeEnumMap, json['frameType']),
      rotation:
          $enumDecodeNullable(_$VideoOrientationEnumMap, json['rotation']),
      trackId: json['trackId'] as int?,
      captureTimeMs: json['captureTimeMs'] as int?,
      uid: json['uid'] as int?,
      streamType:
          $enumDecodeNullable(_$VideoStreamTypeEnumMap, json['streamType']),
    );

Map<String, dynamic> _$EncodedVideoFrameInfoToJson(
    EncodedVideoFrameInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('codecType', _$VideoCodecTypeEnumMap[instance.codecType]);
  writeNotNull('width', instance.width);
  writeNotNull('height', instance.height);
  writeNotNull('framesPerSecond', instance.framesPerSecond);
  writeNotNull('frameType', _$VideoFrameTypeEnumMap[instance.frameType]);
  writeNotNull('rotation', _$VideoOrientationEnumMap[instance.rotation]);
  writeNotNull('trackId', instance.trackId);
  writeNotNull('captureTimeMs', instance.captureTimeMs);
  writeNotNull('uid', instance.uid);
  writeNotNull('streamType', _$VideoStreamTypeEnumMap[instance.streamType]);
  return val;
}

const _$VideoFrameTypeEnumMap = {
  VideoFrameType.videoFrameTypeBlankFrame: 0,
  VideoFrameType.videoFrameTypeKeyFrame: 3,
  VideoFrameType.videoFrameTypeDeltaFrame: 4,
  VideoFrameType.videoFrameTypeBFrame: 5,
  VideoFrameType.videoFrameTypeDroppableFrame: 6,
  VideoFrameType.videoFrameTypeUnknow: 7,
};

const _$VideoOrientationEnumMap = {
  VideoOrientation.videoOrientation0: 0,
  VideoOrientation.videoOrientation90: 90,
  VideoOrientation.videoOrientation180: 180,
  VideoOrientation.videoOrientation270: 270,
};

VideoEncoderConfiguration _$VideoEncoderConfigurationFromJson(
        Map<String, dynamic> json) =>
    VideoEncoderConfiguration(
      codecType:
          $enumDecodeNullable(_$VideoCodecTypeEnumMap, json['codecType']),
      dimensions: json['dimensions'] == null
          ? null
          : VideoDimensions.fromJson(
              json['dimensions'] as Map<String, dynamic>),
      frameRate: json['frameRate'] as int?,
      bitrate: json['bitrate'] as int?,
      minBitrate: json['minBitrate'] as int?,
      orientationMode: $enumDecodeNullable(
          _$OrientationModeEnumMap, json['orientationMode']),
      degradationPreference: $enumDecodeNullable(
          _$DegradationPreferenceEnumMap, json['degradationPreference']),
      mirrorMode:
          $enumDecodeNullable(_$VideoMirrorModeTypeEnumMap, json['mirrorMode']),
    );

Map<String, dynamic> _$VideoEncoderConfigurationToJson(
    VideoEncoderConfiguration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('codecType', _$VideoCodecTypeEnumMap[instance.codecType]);
  writeNotNull('dimensions', instance.dimensions?.toJson());
  writeNotNull('frameRate', instance.frameRate);
  writeNotNull('bitrate', instance.bitrate);
  writeNotNull('minBitrate', instance.minBitrate);
  writeNotNull(
      'orientationMode', _$OrientationModeEnumMap[instance.orientationMode]);
  writeNotNull('degradationPreference',
      _$DegradationPreferenceEnumMap[instance.degradationPreference]);
  writeNotNull('mirrorMode', _$VideoMirrorModeTypeEnumMap[instance.mirrorMode]);
  return val;
}

const _$OrientationModeEnumMap = {
  OrientationMode.orientationModeAdaptive: 0,
  OrientationMode.orientationModeFixedLandscape: 1,
  OrientationMode.orientationModeFixedPortrait: 2,
};

const _$DegradationPreferenceEnumMap = {
  DegradationPreference.maintainQuality: 0,
  DegradationPreference.maintainFramerate: 1,
  DegradationPreference.maintainBalanced: 2,
  DegradationPreference.maintainResolution: 3,
  DegradationPreference.disabled: 100,
};

const _$VideoMirrorModeTypeEnumMap = {
  VideoMirrorModeType.videoMirrorModeAuto: 0,
  VideoMirrorModeType.videoMirrorModeEnabled: 1,
  VideoMirrorModeType.videoMirrorModeDisabled: 2,
};

DataStreamConfig _$DataStreamConfigFromJson(Map<String, dynamic> json) =>
    DataStreamConfig(
      syncWithAudio: json['syncWithAudio'] as bool?,
      ordered: json['ordered'] as bool?,
    );

Map<String, dynamic> _$DataStreamConfigToJson(DataStreamConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('syncWithAudio', instance.syncWithAudio);
  writeNotNull('ordered', instance.ordered);
  return val;
}

SimulcastStreamConfig _$SimulcastStreamConfigFromJson(
        Map<String, dynamic> json) =>
    SimulcastStreamConfig(
      dimensions: json['dimensions'] == null
          ? null
          : VideoDimensions.fromJson(
              json['dimensions'] as Map<String, dynamic>),
      bitrate: json['bitrate'] as int?,
      framerate: json['framerate'] as int?,
    );

Map<String, dynamic> _$SimulcastStreamConfigToJson(
    SimulcastStreamConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('dimensions', instance.dimensions?.toJson());
  writeNotNull('bitrate', instance.bitrate);
  writeNotNull('framerate', instance.framerate);
  return val;
}

Rectangle _$RectangleFromJson(Map<String, dynamic> json) => Rectangle(
      x: json['x'] as int?,
      y: json['y'] as int?,
      width: json['width'] as int?,
      height: json['height'] as int?,
    );

Map<String, dynamic> _$RectangleToJson(Rectangle instance) {
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

WatermarkRatio _$WatermarkRatioFromJson(Map<String, dynamic> json) =>
    WatermarkRatio(
      xRatio: (json['xRatio'] as num?)?.toDouble(),
      yRatio: (json['yRatio'] as num?)?.toDouble(),
      widthRatio: (json['widthRatio'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WatermarkRatioToJson(WatermarkRatio instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('xRatio', instance.xRatio);
  writeNotNull('yRatio', instance.yRatio);
  writeNotNull('widthRatio', instance.widthRatio);
  return val;
}

WatermarkOptions _$WatermarkOptionsFromJson(Map<String, dynamic> json) =>
    WatermarkOptions(
      visibleInPreview: json['visibleInPreview'] as bool?,
      positionInLandscapeMode: json['positionInLandscapeMode'] == null
          ? null
          : Rectangle.fromJson(
              json['positionInLandscapeMode'] as Map<String, dynamic>),
      positionInPortraitMode: json['positionInPortraitMode'] == null
          ? null
          : Rectangle.fromJson(
              json['positionInPortraitMode'] as Map<String, dynamic>),
      watermarkRatio: json['watermarkRatio'] == null
          ? null
          : WatermarkRatio.fromJson(
              json['watermarkRatio'] as Map<String, dynamic>),
      mode: $enumDecodeNullable(_$WatermarkFitModeEnumMap, json['mode']),
    );

Map<String, dynamic> _$WatermarkOptionsToJson(WatermarkOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('visibleInPreview', instance.visibleInPreview);
  writeNotNull(
      'positionInLandscapeMode', instance.positionInLandscapeMode?.toJson());
  writeNotNull(
      'positionInPortraitMode', instance.positionInPortraitMode?.toJson());
  writeNotNull('watermarkRatio', instance.watermarkRatio?.toJson());
  writeNotNull('mode', _$WatermarkFitModeEnumMap[instance.mode]);
  return val;
}

const _$WatermarkFitModeEnumMap = {
  WatermarkFitMode.fitModeCoverPosition: 0,
  WatermarkFitMode.fitModeUseImageRatio: 1,
};

RtcStats _$RtcStatsFromJson(Map<String, dynamic> json) => RtcStats(
      duration: json['duration'] as int?,
      txBytes: json['txBytes'] as int?,
      rxBytes: json['rxBytes'] as int?,
      txAudioBytes: json['txAudioBytes'] as int?,
      txVideoBytes: json['txVideoBytes'] as int?,
      rxAudioBytes: json['rxAudioBytes'] as int?,
      rxVideoBytes: json['rxVideoBytes'] as int?,
      txKBitRate: json['txKBitRate'] as int?,
      rxKBitRate: json['rxKBitRate'] as int?,
      rxAudioKBitRate: json['rxAudioKBitRate'] as int?,
      txAudioKBitRate: json['txAudioKBitRate'] as int?,
      rxVideoKBitRate: json['rxVideoKBitRate'] as int?,
      txVideoKBitRate: json['txVideoKBitRate'] as int?,
      lastmileDelay: json['lastmileDelay'] as int?,
      userCount: json['userCount'] as int?,
      cpuAppUsage: (json['cpuAppUsage'] as num?)?.toDouble(),
      cpuTotalUsage: (json['cpuTotalUsage'] as num?)?.toDouble(),
      gatewayRtt: json['gatewayRtt'] as int?,
      memoryAppUsageRatio: (json['memoryAppUsageRatio'] as num?)?.toDouble(),
      memoryTotalUsageRatio:
          (json['memoryTotalUsageRatio'] as num?)?.toDouble(),
      memoryAppUsageInKbytes: json['memoryAppUsageInKbytes'] as int?,
      connectTimeMs: json['connectTimeMs'] as int?,
      firstAudioPacketDuration: json['firstAudioPacketDuration'] as int?,
      firstVideoPacketDuration: json['firstVideoPacketDuration'] as int?,
      firstVideoKeyFramePacketDuration:
          json['firstVideoKeyFramePacketDuration'] as int?,
      packetsBeforeFirstKeyFramePacket:
          json['packetsBeforeFirstKeyFramePacket'] as int?,
      firstAudioPacketDurationAfterUnmute:
          json['firstAudioPacketDurationAfterUnmute'] as int?,
      firstVideoPacketDurationAfterUnmute:
          json['firstVideoPacketDurationAfterUnmute'] as int?,
      firstVideoKeyFramePacketDurationAfterUnmute:
          json['firstVideoKeyFramePacketDurationAfterUnmute'] as int?,
      firstVideoKeyFrameDecodedDurationAfterUnmute:
          json['firstVideoKeyFrameDecodedDurationAfterUnmute'] as int?,
      firstVideoKeyFrameRenderedDurationAfterUnmute:
          json['firstVideoKeyFrameRenderedDurationAfterUnmute'] as int?,
      txPacketLossRate: json['txPacketLossRate'] as int?,
      rxPacketLossRate: json['rxPacketLossRate'] as int?,
    );

Map<String, dynamic> _$RtcStatsToJson(RtcStats instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('duration', instance.duration);
  writeNotNull('txBytes', instance.txBytes);
  writeNotNull('rxBytes', instance.rxBytes);
  writeNotNull('txAudioBytes', instance.txAudioBytes);
  writeNotNull('txVideoBytes', instance.txVideoBytes);
  writeNotNull('rxAudioBytes', instance.rxAudioBytes);
  writeNotNull('rxVideoBytes', instance.rxVideoBytes);
  writeNotNull('txKBitRate', instance.txKBitRate);
  writeNotNull('rxKBitRate', instance.rxKBitRate);
  writeNotNull('rxAudioKBitRate', instance.rxAudioKBitRate);
  writeNotNull('txAudioKBitRate', instance.txAudioKBitRate);
  writeNotNull('rxVideoKBitRate', instance.rxVideoKBitRate);
  writeNotNull('txVideoKBitRate', instance.txVideoKBitRate);
  writeNotNull('lastmileDelay', instance.lastmileDelay);
  writeNotNull('userCount', instance.userCount);
  writeNotNull('cpuAppUsage', instance.cpuAppUsage);
  writeNotNull('cpuTotalUsage', instance.cpuTotalUsage);
  writeNotNull('gatewayRtt', instance.gatewayRtt);
  writeNotNull('memoryAppUsageRatio', instance.memoryAppUsageRatio);
  writeNotNull('memoryTotalUsageRatio', instance.memoryTotalUsageRatio);
  writeNotNull('memoryAppUsageInKbytes', instance.memoryAppUsageInKbytes);
  writeNotNull('connectTimeMs', instance.connectTimeMs);
  writeNotNull('firstAudioPacketDuration', instance.firstAudioPacketDuration);
  writeNotNull('firstVideoPacketDuration', instance.firstVideoPacketDuration);
  writeNotNull('firstVideoKeyFramePacketDuration',
      instance.firstVideoKeyFramePacketDuration);
  writeNotNull('packetsBeforeFirstKeyFramePacket',
      instance.packetsBeforeFirstKeyFramePacket);
  writeNotNull('firstAudioPacketDurationAfterUnmute',
      instance.firstAudioPacketDurationAfterUnmute);
  writeNotNull('firstVideoPacketDurationAfterUnmute',
      instance.firstVideoPacketDurationAfterUnmute);
  writeNotNull('firstVideoKeyFramePacketDurationAfterUnmute',
      instance.firstVideoKeyFramePacketDurationAfterUnmute);
  writeNotNull('firstVideoKeyFrameDecodedDurationAfterUnmute',
      instance.firstVideoKeyFrameDecodedDurationAfterUnmute);
  writeNotNull('firstVideoKeyFrameRenderedDurationAfterUnmute',
      instance.firstVideoKeyFrameRenderedDurationAfterUnmute);
  writeNotNull('txPacketLossRate', instance.txPacketLossRate);
  writeNotNull('rxPacketLossRate', instance.rxPacketLossRate);
  return val;
}

ClientRoleOptions _$ClientRoleOptionsFromJson(Map<String, dynamic> json) =>
    ClientRoleOptions(
      audienceLatencyLevel: $enumDecodeNullable(
          _$AudienceLatencyLevelTypeEnumMap, json['audienceLatencyLevel']),
    );

Map<String, dynamic> _$ClientRoleOptionsToJson(ClientRoleOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('audienceLatencyLevel',
      _$AudienceLatencyLevelTypeEnumMap[instance.audienceLatencyLevel]);
  return val;
}

const _$AudienceLatencyLevelTypeEnumMap = {
  AudienceLatencyLevelType.audienceLatencyLevelLowLatency: 1,
  AudienceLatencyLevelType.audienceLatencyLevelUltraLowLatency: 2,
};

RemoteAudioStats _$RemoteAudioStatsFromJson(Map<String, dynamic> json) =>
    RemoteAudioStats(
      uid: json['uid'] as int?,
      quality: json['quality'] as int?,
      networkTransportDelay: json['networkTransportDelay'] as int?,
      jitterBufferDelay: json['jitterBufferDelay'] as int?,
      audioLossRate: json['audioLossRate'] as int?,
      numChannels: json['numChannels'] as int?,
      receivedSampleRate: json['receivedSampleRate'] as int?,
      receivedBitrate: json['receivedBitrate'] as int?,
      totalFrozenTime: json['totalFrozenTime'] as int?,
      frozenRate: json['frozenRate'] as int?,
      mosValue: json['mosValue'] as int?,
      totalActiveTime: json['totalActiveTime'] as int?,
      publishDuration: json['publishDuration'] as int?,
      qoeQuality: json['qoeQuality'] as int?,
      qualityChangedReason: json['qualityChangedReason'] as int?,
    );

Map<String, dynamic> _$RemoteAudioStatsToJson(RemoteAudioStats instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uid', instance.uid);
  writeNotNull('quality', instance.quality);
  writeNotNull('networkTransportDelay', instance.networkTransportDelay);
  writeNotNull('jitterBufferDelay', instance.jitterBufferDelay);
  writeNotNull('audioLossRate', instance.audioLossRate);
  writeNotNull('numChannels', instance.numChannels);
  writeNotNull('receivedSampleRate', instance.receivedSampleRate);
  writeNotNull('receivedBitrate', instance.receivedBitrate);
  writeNotNull('totalFrozenTime', instance.totalFrozenTime);
  writeNotNull('frozenRate', instance.frozenRate);
  writeNotNull('mosValue', instance.mosValue);
  writeNotNull('totalActiveTime', instance.totalActiveTime);
  writeNotNull('publishDuration', instance.publishDuration);
  writeNotNull('qoeQuality', instance.qoeQuality);
  writeNotNull('qualityChangedReason', instance.qualityChangedReason);
  return val;
}

VideoFormat _$VideoFormatFromJson(Map<String, dynamic> json) => VideoFormat(
      width: json['width'] as int?,
      height: json['height'] as int?,
      fps: json['fps'] as int?,
    );

Map<String, dynamic> _$VideoFormatToJson(VideoFormat instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('width', instance.width);
  writeNotNull('height', instance.height);
  writeNotNull('fps', instance.fps);
  return val;
}

VideoTrackInfo _$VideoTrackInfoFromJson(Map<String, dynamic> json) =>
    VideoTrackInfo(
      isLocal: json['isLocal'] as bool?,
      ownerUid: json['ownerUid'] as int?,
      trackId: json['trackId'] as int?,
      channelId: json['channelId'] as String?,
      streamType:
          $enumDecodeNullable(_$VideoStreamTypeEnumMap, json['streamType']),
      codecType:
          $enumDecodeNullable(_$VideoCodecTypeEnumMap, json['codecType']),
      encodedFrameOnly: json['encodedFrameOnly'] as bool?,
      sourceType:
          $enumDecodeNullable(_$VideoSourceTypeEnumMap, json['sourceType']),
      observationPosition: json['observationPosition'] as int?,
    );

Map<String, dynamic> _$VideoTrackInfoToJson(VideoTrackInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('isLocal', instance.isLocal);
  writeNotNull('ownerUid', instance.ownerUid);
  writeNotNull('trackId', instance.trackId);
  writeNotNull('channelId', instance.channelId);
  writeNotNull('streamType', _$VideoStreamTypeEnumMap[instance.streamType]);
  writeNotNull('codecType', _$VideoCodecTypeEnumMap[instance.codecType]);
  writeNotNull('encodedFrameOnly', instance.encodedFrameOnly);
  writeNotNull('sourceType', _$VideoSourceTypeEnumMap[instance.sourceType]);
  writeNotNull('observationPosition', instance.observationPosition);
  return val;
}

const _$VideoSourceTypeEnumMap = {
  VideoSourceType.videoSourceCameraPrimary: 0,
  VideoSourceType.videoSourceCamera: 0,
  VideoSourceType.videoSourceCameraSecondary: 1,
  VideoSourceType.videoSourceScreenPrimary: 2,
  VideoSourceType.videoSourceScreen: 2,
  VideoSourceType.videoSourceScreenSecondary: 3,
  VideoSourceType.videoSourceCustom: 4,
  VideoSourceType.videoSourceMediaPlayer: 5,
  VideoSourceType.videoSourceRtcImagePng: 6,
  VideoSourceType.videoSourceRtcImageJpeg: 7,
  VideoSourceType.videoSourceRtcImageGif: 8,
  VideoSourceType.videoSourceRemote: 9,
  VideoSourceType.videoSourceTranscoded: 10,
  VideoSourceType.videoSourceUnknown: 100,
};

AudioVolumeInfo _$AudioVolumeInfoFromJson(Map<String, dynamic> json) =>
    AudioVolumeInfo(
      uid: json['uid'] as int?,
      volume: json['volume'] as int?,
      vad: json['vad'] as int?,
      voicePitch: (json['voicePitch'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AudioVolumeInfoToJson(AudioVolumeInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uid', instance.uid);
  writeNotNull('volume', instance.volume);
  writeNotNull('vad', instance.vad);
  writeNotNull('voicePitch', instance.voicePitch);
  return val;
}

DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) => DeviceInfo(
      isLowLatencyAudioSupported: json['isLowLatencyAudioSupported'] as bool?,
    );

Map<String, dynamic> _$DeviceInfoToJson(DeviceInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'isLowLatencyAudioSupported', instance.isLowLatencyAudioSupported);
  return val;
}

Packet _$PacketFromJson(Map<String, dynamic> json) => Packet(
      size: json['size'] as int?,
    );

Map<String, dynamic> _$PacketToJson(Packet instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('size', instance.size);
  return val;
}

LocalAudioStats _$LocalAudioStatsFromJson(Map<String, dynamic> json) =>
    LocalAudioStats(
      numChannels: json['numChannels'] as int?,
      sentSampleRate: json['sentSampleRate'] as int?,
      sentBitrate: json['sentBitrate'] as int?,
      internalCodec: json['internalCodec'] as int?,
      txPacketLossRate: json['txPacketLossRate'] as int?,
      audioDeviceDelay: json['audioDeviceDelay'] as int?,
    );

Map<String, dynamic> _$LocalAudioStatsToJson(LocalAudioStats instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('numChannels', instance.numChannels);
  writeNotNull('sentSampleRate', instance.sentSampleRate);
  writeNotNull('sentBitrate', instance.sentBitrate);
  writeNotNull('internalCodec', instance.internalCodec);
  writeNotNull('txPacketLossRate', instance.txPacketLossRate);
  writeNotNull('audioDeviceDelay', instance.audioDeviceDelay);
  return val;
}

RtcImage _$RtcImageFromJson(Map<String, dynamic> json) => RtcImage(
      url: json['url'] as String?,
      x: json['x'] as int?,
      y: json['y'] as int?,
      width: json['width'] as int?,
      height: json['height'] as int?,
      zOrder: json['zOrder'] as int?,
      alpha: (json['alpha'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RtcImageToJson(RtcImage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('url', instance.url);
  writeNotNull('x', instance.x);
  writeNotNull('y', instance.y);
  writeNotNull('width', instance.width);
  writeNotNull('height', instance.height);
  writeNotNull('zOrder', instance.zOrder);
  writeNotNull('alpha', instance.alpha);
  return val;
}

LiveStreamAdvancedFeature _$LiveStreamAdvancedFeatureFromJson(
        Map<String, dynamic> json) =>
    LiveStreamAdvancedFeature(
      featureName: json['featureName'] as String?,
      opened: json['opened'] as bool?,
    );

Map<String, dynamic> _$LiveStreamAdvancedFeatureToJson(
    LiveStreamAdvancedFeature instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('featureName', instance.featureName);
  writeNotNull('opened', instance.opened);
  return val;
}

TranscodingUser _$TranscodingUserFromJson(Map<String, dynamic> json) =>
    TranscodingUser(
      uid: json['uid'] as int?,
      x: json['x'] as int?,
      y: json['y'] as int?,
      width: json['width'] as int?,
      height: json['height'] as int?,
      zOrder: json['zOrder'] as int?,
      alpha: (json['alpha'] as num?)?.toDouble(),
      audioChannel: json['audioChannel'] as int?,
    );

Map<String, dynamic> _$TranscodingUserToJson(TranscodingUser instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uid', instance.uid);
  writeNotNull('x', instance.x);
  writeNotNull('y', instance.y);
  writeNotNull('width', instance.width);
  writeNotNull('height', instance.height);
  writeNotNull('zOrder', instance.zOrder);
  writeNotNull('alpha', instance.alpha);
  writeNotNull('audioChannel', instance.audioChannel);
  return val;
}

LiveTranscoding _$LiveTranscodingFromJson(Map<String, dynamic> json) =>
    LiveTranscoding(
      width: json['width'] as int?,
      height: json['height'] as int?,
      videoBitrate: json['videoBitrate'] as int?,
      videoFramerate: json['videoFramerate'] as int?,
      lowLatency: json['lowLatency'] as bool?,
      videoGop: json['videoGop'] as int?,
      videoCodecProfile: $enumDecodeNullable(
          _$VideoCodecProfileTypeEnumMap, json['videoCodecProfile']),
      backgroundColor: json['backgroundColor'] as int?,
      videoCodecType: $enumDecodeNullable(
          _$VideoCodecTypeForStreamEnumMap, json['videoCodecType']),
      userCount: json['userCount'] as int?,
      transcodingUsers: (json['transcodingUsers'] as List<dynamic>?)
          ?.map((e) => TranscodingUser.fromJson(e as Map<String, dynamic>))
          .toList(),
      transcodingExtraInfo: json['transcodingExtraInfo'] as String?,
      metadata: json['metadata'] as String?,
      watermark: (json['watermark'] as List<dynamic>?)
          ?.map((e) => RtcImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      watermarkCount: json['watermarkCount'] as int?,
      backgroundImage: (json['backgroundImage'] as List<dynamic>?)
          ?.map((e) => RtcImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      backgroundImageCount: json['backgroundImageCount'] as int?,
      audioSampleRate: $enumDecodeNullable(
          _$AudioSampleRateTypeEnumMap, json['audioSampleRate']),
      audioBitrate: json['audioBitrate'] as int?,
      audioChannels: json['audioChannels'] as int?,
      audioCodecProfile: $enumDecodeNullable(
          _$AudioCodecProfileTypeEnumMap, json['audioCodecProfile']),
      advancedFeatures: (json['advancedFeatures'] as List<dynamic>?)
          ?.map((e) =>
              LiveStreamAdvancedFeature.fromJson(e as Map<String, dynamic>))
          .toList(),
      advancedFeatureCount: json['advancedFeatureCount'] as int?,
    );

Map<String, dynamic> _$LiveTranscodingToJson(LiveTranscoding instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('width', instance.width);
  writeNotNull('height', instance.height);
  writeNotNull('videoBitrate', instance.videoBitrate);
  writeNotNull('videoFramerate', instance.videoFramerate);
  writeNotNull('lowLatency', instance.lowLatency);
  writeNotNull('videoGop', instance.videoGop);
  writeNotNull('videoCodecProfile',
      _$VideoCodecProfileTypeEnumMap[instance.videoCodecProfile]);
  writeNotNull('backgroundColor', instance.backgroundColor);
  writeNotNull('videoCodecType',
      _$VideoCodecTypeForStreamEnumMap[instance.videoCodecType]);
  writeNotNull('userCount', instance.userCount);
  writeNotNull('transcodingUsers',
      instance.transcodingUsers?.map((e) => e.toJson()).toList());
  writeNotNull('transcodingExtraInfo', instance.transcodingExtraInfo);
  writeNotNull('metadata', instance.metadata);
  writeNotNull(
      'watermark', instance.watermark?.map((e) => e.toJson()).toList());
  writeNotNull('watermarkCount', instance.watermarkCount);
  writeNotNull('backgroundImage',
      instance.backgroundImage?.map((e) => e.toJson()).toList());
  writeNotNull('backgroundImageCount', instance.backgroundImageCount);
  writeNotNull('audioSampleRate',
      _$AudioSampleRateTypeEnumMap[instance.audioSampleRate]);
  writeNotNull('audioBitrate', instance.audioBitrate);
  writeNotNull('audioChannels', instance.audioChannels);
  writeNotNull('audioCodecProfile',
      _$AudioCodecProfileTypeEnumMap[instance.audioCodecProfile]);
  writeNotNull('advancedFeatures',
      instance.advancedFeatures?.map((e) => e.toJson()).toList());
  writeNotNull('advancedFeatureCount', instance.advancedFeatureCount);
  return val;
}

const _$VideoCodecProfileTypeEnumMap = {
  VideoCodecProfileType.videoCodecProfileBaseline: 66,
  VideoCodecProfileType.videoCodecProfileMain: 77,
  VideoCodecProfileType.videoCodecProfileHigh: 100,
};

const _$VideoCodecTypeForStreamEnumMap = {
  VideoCodecTypeForStream.videoCodecH264ForStream: 1,
  VideoCodecTypeForStream.videoCodecH265ForStream: 2,
};

const _$AudioSampleRateTypeEnumMap = {
  AudioSampleRateType.audioSampleRate32000: 32000,
  AudioSampleRateType.audioSampleRate44100: 44100,
  AudioSampleRateType.audioSampleRate48000: 48000,
};

const _$AudioCodecProfileTypeEnumMap = {
  AudioCodecProfileType.audioCodecProfileLcAac: 0,
  AudioCodecProfileType.audioCodecProfileHeAac: 1,
  AudioCodecProfileType.audioCodecProfileHeAacV2: 2,
};

TranscodingVideoStream _$TranscodingVideoStreamFromJson(
        Map<String, dynamic> json) =>
    TranscodingVideoStream(
      sourceType:
          $enumDecodeNullable(_$MediaSourceTypeEnumMap, json['sourceType']),
      remoteUserUid: json['remoteUserUid'] as int?,
      imageUrl: json['imageUrl'] as String?,
      x: json['x'] as int?,
      y: json['y'] as int?,
      width: json['width'] as int?,
      height: json['height'] as int?,
      zOrder: json['zOrder'] as int?,
      alpha: (json['alpha'] as num?)?.toDouble(),
      mirror: json['mirror'] as bool?,
    );

Map<String, dynamic> _$TranscodingVideoStreamToJson(
    TranscodingVideoStream instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sourceType', _$MediaSourceTypeEnumMap[instance.sourceType]);
  writeNotNull('remoteUserUid', instance.remoteUserUid);
  writeNotNull('imageUrl', instance.imageUrl);
  writeNotNull('x', instance.x);
  writeNotNull('y', instance.y);
  writeNotNull('width', instance.width);
  writeNotNull('height', instance.height);
  writeNotNull('zOrder', instance.zOrder);
  writeNotNull('alpha', instance.alpha);
  writeNotNull('mirror', instance.mirror);
  return val;
}

const _$MediaSourceTypeEnumMap = {
  MediaSourceType.audioPlayoutSource: 0,
  MediaSourceType.audioRecordingSource: 1,
  MediaSourceType.primaryCameraSource: 2,
  MediaSourceType.secondaryCameraSource: 3,
  MediaSourceType.primaryScreenSource: 4,
  MediaSourceType.secondaryScreenSource: 5,
  MediaSourceType.customVideoSource: 6,
  MediaSourceType.mediaPlayerSource: 7,
  MediaSourceType.rtcImagePngSource: 8,
  MediaSourceType.rtcImageJpegSource: 9,
  MediaSourceType.rtcImageGifSource: 10,
  MediaSourceType.remoteVideoSource: 11,
  MediaSourceType.transcodedVideoSource: 12,
  MediaSourceType.unknownMediaSource: 100,
};

LocalTranscoderConfiguration _$LocalTranscoderConfigurationFromJson(
        Map<String, dynamic> json) =>
    LocalTranscoderConfiguration(
      streamCount: json['streamCount'] as int?,
      videoInputStreams: (json['VideoInputStreams'] as List<dynamic>?)
          ?.map(
              (e) => TranscodingVideoStream.fromJson(e as Map<String, dynamic>))
          .toList(),
      videoOutputConfiguration: json['videoOutputConfiguration'] == null
          ? null
          : VideoEncoderConfiguration.fromJson(
              json['videoOutputConfiguration'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LocalTranscoderConfigurationToJson(
    LocalTranscoderConfiguration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('streamCount', instance.streamCount);
  writeNotNull('VideoInputStreams',
      instance.videoInputStreams?.map((e) => e.toJson()).toList());
  writeNotNull(
      'videoOutputConfiguration', instance.videoOutputConfiguration?.toJson());
  return val;
}

LastmileProbeConfig _$LastmileProbeConfigFromJson(Map<String, dynamic> json) =>
    LastmileProbeConfig(
      probeUplink: json['probeUplink'] as bool?,
      probeDownlink: json['probeDownlink'] as bool?,
      expectedUplinkBitrate: json['expectedUplinkBitrate'] as int?,
      expectedDownlinkBitrate: json['expectedDownlinkBitrate'] as int?,
    );

Map<String, dynamic> _$LastmileProbeConfigToJson(LastmileProbeConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('probeUplink', instance.probeUplink);
  writeNotNull('probeDownlink', instance.probeDownlink);
  writeNotNull('expectedUplinkBitrate', instance.expectedUplinkBitrate);
  writeNotNull('expectedDownlinkBitrate', instance.expectedDownlinkBitrate);
  return val;
}

LastmileProbeOneWayResult _$LastmileProbeOneWayResultFromJson(
        Map<String, dynamic> json) =>
    LastmileProbeOneWayResult(
      packetLossRate: json['packetLossRate'] as int?,
      jitter: json['jitter'] as int?,
      availableBandwidth: json['availableBandwidth'] as int?,
    );

Map<String, dynamic> _$LastmileProbeOneWayResultToJson(
    LastmileProbeOneWayResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('packetLossRate', instance.packetLossRate);
  writeNotNull('jitter', instance.jitter);
  writeNotNull('availableBandwidth', instance.availableBandwidth);
  return val;
}

LastmileProbeResult _$LastmileProbeResultFromJson(Map<String, dynamic> json) =>
    LastmileProbeResult(
      state:
          $enumDecodeNullable(_$LastmileProbeResultStateEnumMap, json['state']),
      uplinkReport: json['uplinkReport'] == null
          ? null
          : LastmileProbeOneWayResult.fromJson(
              json['uplinkReport'] as Map<String, dynamic>),
      downlinkReport: json['downlinkReport'] == null
          ? null
          : LastmileProbeOneWayResult.fromJson(
              json['downlinkReport'] as Map<String, dynamic>),
      rtt: json['rtt'] as int?,
    );

Map<String, dynamic> _$LastmileProbeResultToJson(LastmileProbeResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('state', _$LastmileProbeResultStateEnumMap[instance.state]);
  writeNotNull('uplinkReport', instance.uplinkReport?.toJson());
  writeNotNull('downlinkReport', instance.downlinkReport?.toJson());
  writeNotNull('rtt', instance.rtt);
  return val;
}

const _$LastmileProbeResultStateEnumMap = {
  LastmileProbeResultState.lastmileProbeResultComplete: 1,
  LastmileProbeResultState.lastmileProbeResultIncompleteNoBwe: 2,
  LastmileProbeResultState.lastmileProbeResultUnavailable: 3,
};

WlAccStats _$WlAccStatsFromJson(Map<String, dynamic> json) => WlAccStats(
      e2eDelayPercent: json['e2eDelayPercent'] as int?,
      frozenRatioPercent: json['frozenRatioPercent'] as int?,
      lossRatePercent: json['lossRatePercent'] as int?,
    );

Map<String, dynamic> _$WlAccStatsToJson(WlAccStats instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('e2eDelayPercent', instance.e2eDelayPercent);
  writeNotNull('frozenRatioPercent', instance.frozenRatioPercent);
  writeNotNull('lossRatePercent', instance.lossRatePercent);
  return val;
}

VideoCanvas _$VideoCanvasFromJson(Map<String, dynamic> json) => VideoCanvas(
      view: json['view'] as int?,
      renderMode:
          $enumDecodeNullable(_$RenderModeTypeEnumMap, json['renderMode']),
      mirrorMode:
          $enumDecodeNullable(_$VideoMirrorModeTypeEnumMap, json['mirrorMode']),
      uid: json['uid'] as int?,
      isScreenView: json['isScreenView'] as bool?,
      privSize: json['priv_size'] as int?,
      sourceType:
          $enumDecodeNullable(_$VideoSourceTypeEnumMap, json['sourceType']),
      cropArea: json['cropArea'] == null
          ? null
          : Rectangle.fromJson(json['cropArea'] as Map<String, dynamic>),
      setupMode:
          $enumDecodeNullable(_$VideoViewSetupModeEnumMap, json['setupMode']),
    );

Map<String, dynamic> _$VideoCanvasToJson(VideoCanvas instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('view', instance.view);
  writeNotNull('renderMode', _$RenderModeTypeEnumMap[instance.renderMode]);
  writeNotNull('mirrorMode', _$VideoMirrorModeTypeEnumMap[instance.mirrorMode]);
  writeNotNull('uid', instance.uid);
  writeNotNull('isScreenView', instance.isScreenView);
  writeNotNull('priv_size', instance.privSize);
  writeNotNull('sourceType', _$VideoSourceTypeEnumMap[instance.sourceType]);
  writeNotNull('cropArea', instance.cropArea?.toJson());
  writeNotNull('setupMode', _$VideoViewSetupModeEnumMap[instance.setupMode]);
  return val;
}

const _$RenderModeTypeEnumMap = {
  RenderModeType.renderModeHidden: 1,
  RenderModeType.renderModeFit: 2,
  RenderModeType.renderModeAdaptive: 3,
};

const _$VideoViewSetupModeEnumMap = {
  VideoViewSetupMode.videoViewSetupReplace: 0,
  VideoViewSetupMode.videoViewSetupAdd: 1,
  VideoViewSetupMode.videoViewSetupRemove: 2,
};

BeautyOptions _$BeautyOptionsFromJson(Map<String, dynamic> json) =>
    BeautyOptions(
      lighteningContrastLevel: $enumDecodeNullable(
          _$LighteningContrastLevelEnumMap, json['lighteningContrastLevel']),
      lighteningLevel: (json['lighteningLevel'] as num?)?.toDouble(),
      smoothnessLevel: (json['smoothnessLevel'] as num?)?.toDouble(),
      rednessLevel: (json['rednessLevel'] as num?)?.toDouble(),
      sharpnessLevel: (json['sharpnessLevel'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$BeautyOptionsToJson(BeautyOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('lighteningContrastLevel',
      _$LighteningContrastLevelEnumMap[instance.lighteningContrastLevel]);
  writeNotNull('lighteningLevel', instance.lighteningLevel);
  writeNotNull('smoothnessLevel', instance.smoothnessLevel);
  writeNotNull('rednessLevel', instance.rednessLevel);
  writeNotNull('sharpnessLevel', instance.sharpnessLevel);
  return val;
}

const _$LighteningContrastLevelEnumMap = {
  LighteningContrastLevel.lighteningContrastLow: 0,
  LighteningContrastLevel.lighteningContrastNormal: 1,
  LighteningContrastLevel.lighteningContrastHigh: 2,
};

LowlightEnhanceOptions _$LowlightEnhanceOptionsFromJson(
        Map<String, dynamic> json) =>
    LowlightEnhanceOptions(
      mode: $enumDecodeNullable(_$LowLightEnhanceModeEnumMap, json['mode']),
      level: $enumDecodeNullable(_$LowLightEnhanceLevelEnumMap, json['level']),
    );

Map<String, dynamic> _$LowlightEnhanceOptionsToJson(
    LowlightEnhanceOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('mode', _$LowLightEnhanceModeEnumMap[instance.mode]);
  writeNotNull('level', _$LowLightEnhanceLevelEnumMap[instance.level]);
  return val;
}

const _$LowLightEnhanceModeEnumMap = {
  LowLightEnhanceMode.lowLightEnhanceAuto: 0,
  LowLightEnhanceMode.lowLightEnhanceManual: 1,
};

const _$LowLightEnhanceLevelEnumMap = {
  LowLightEnhanceLevel.lowLightEnhanceLevelHighQuality: 0,
  LowLightEnhanceLevel.lowLightEnhanceLevelFast: 1,
};

VideoDenoiserOptions _$VideoDenoiserOptionsFromJson(
        Map<String, dynamic> json) =>
    VideoDenoiserOptions(
      mode: $enumDecodeNullable(_$VideoDenoiserModeEnumMap, json['mode']),
      level: $enumDecodeNullable(_$VideoDenoiserLevelEnumMap, json['level']),
    );

Map<String, dynamic> _$VideoDenoiserOptionsToJson(
    VideoDenoiserOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('mode', _$VideoDenoiserModeEnumMap[instance.mode]);
  writeNotNull('level', _$VideoDenoiserLevelEnumMap[instance.level]);
  return val;
}

const _$VideoDenoiserModeEnumMap = {
  VideoDenoiserMode.videoDenoiserAuto: 0,
  VideoDenoiserMode.videoDenoiserManual: 1,
};

const _$VideoDenoiserLevelEnumMap = {
  VideoDenoiserLevel.videoDenoiserLevelHighQuality: 0,
  VideoDenoiserLevel.videoDenoiserLevelFast: 1,
  VideoDenoiserLevel.videoDenoiserLevelStrength: 2,
};

ColorEnhanceOptions _$ColorEnhanceOptionsFromJson(Map<String, dynamic> json) =>
    ColorEnhanceOptions(
      strengthLevel: (json['strengthLevel'] as num?)?.toDouble(),
      skinProtectLevel: (json['skinProtectLevel'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ColorEnhanceOptionsToJson(ColorEnhanceOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('strengthLevel', instance.strengthLevel);
  writeNotNull('skinProtectLevel', instance.skinProtectLevel);
  return val;
}

VirtualBackgroundSource _$VirtualBackgroundSourceFromJson(
        Map<String, dynamic> json) =>
    VirtualBackgroundSource(
      backgroundSourceType: $enumDecodeNullable(
          _$BackgroundSourceTypeEnumMap, json['background_source_type']),
      color: json['color'] as int?,
      source: json['source'] as String?,
      blurDegree: $enumDecodeNullable(
          _$BackgroundBlurDegreeEnumMap, json['blur_degree']),
    );

Map<String, dynamic> _$VirtualBackgroundSourceToJson(
    VirtualBackgroundSource instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('background_source_type',
      _$BackgroundSourceTypeEnumMap[instance.backgroundSourceType]);
  writeNotNull('color', instance.color);
  writeNotNull('source', instance.source);
  writeNotNull(
      'blur_degree', _$BackgroundBlurDegreeEnumMap[instance.blurDegree]);
  return val;
}

const _$BackgroundSourceTypeEnumMap = {
  BackgroundSourceType.backgroundColor: 1,
  BackgroundSourceType.backgroundImg: 2,
  BackgroundSourceType.backgroundBlur: 3,
};

const _$BackgroundBlurDegreeEnumMap = {
  BackgroundBlurDegree.blurDegreeLow: 1,
  BackgroundBlurDegree.blurDegreeMedium: 2,
  BackgroundBlurDegree.blurDegreeHigh: 3,
};

SegmentationProperty _$SegmentationPropertyFromJson(
        Map<String, dynamic> json) =>
    SegmentationProperty(
      modelType: $enumDecodeNullable(_$SegModelTypeEnumMap, json['modelType']),
      greenCapacity: (json['greenCapacity'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SegmentationPropertyToJson(
    SegmentationProperty instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('modelType', _$SegModelTypeEnumMap[instance.modelType]);
  writeNotNull('greenCapacity', instance.greenCapacity);
  return val;
}

const _$SegModelTypeEnumMap = {
  SegModelType.segModelAi: 1,
  SegModelType.segModelGreen: 2,
};

ScreenCaptureParameters _$ScreenCaptureParametersFromJson(
        Map<String, dynamic> json) =>
    ScreenCaptureParameters(
      dimensions: json['dimensions'] == null
          ? null
          : VideoDimensions.fromJson(
              json['dimensions'] as Map<String, dynamic>),
      frameRate: json['frameRate'] as int?,
      bitrate: json['bitrate'] as int?,
      captureMouseCursor: json['captureMouseCursor'] as bool?,
      windowFocus: json['windowFocus'] as bool?,
      excludeWindowList: (json['excludeWindowList'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      excludeWindowCount: json['excludeWindowCount'] as int?,
      highLightWidth: json['highLightWidth'] as int?,
      highLightColor: json['highLightColor'] as int?,
      enableHighLight: json['enableHighLight'] as bool?,
    );

Map<String, dynamic> _$ScreenCaptureParametersToJson(
    ScreenCaptureParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('dimensions', instance.dimensions?.toJson());
  writeNotNull('frameRate', instance.frameRate);
  writeNotNull('bitrate', instance.bitrate);
  writeNotNull('captureMouseCursor', instance.captureMouseCursor);
  writeNotNull('windowFocus', instance.windowFocus);
  writeNotNull('excludeWindowList', instance.excludeWindowList);
  writeNotNull('excludeWindowCount', instance.excludeWindowCount);
  writeNotNull('highLightWidth', instance.highLightWidth);
  writeNotNull('highLightColor', instance.highLightColor);
  writeNotNull('enableHighLight', instance.enableHighLight);
  return val;
}

AudioRecordingConfiguration _$AudioRecordingConfigurationFromJson(
        Map<String, dynamic> json) =>
    AudioRecordingConfiguration(
      filePath: json['filePath'] as String?,
      encode: json['encode'] as bool?,
      sampleRate: json['sampleRate'] as int?,
      fileRecordingType: $enumDecodeNullable(
          _$AudioFileRecordingTypeEnumMap, json['fileRecordingType']),
      quality: $enumDecodeNullable(
          _$AudioRecordingQualityTypeEnumMap, json['quality']),
      recordingChannel: json['recordingChannel'] as int?,
    );

Map<String, dynamic> _$AudioRecordingConfigurationToJson(
    AudioRecordingConfiguration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('filePath', instance.filePath);
  writeNotNull('encode', instance.encode);
  writeNotNull('sampleRate', instance.sampleRate);
  writeNotNull('fileRecordingType',
      _$AudioFileRecordingTypeEnumMap[instance.fileRecordingType]);
  writeNotNull('quality', _$AudioRecordingQualityTypeEnumMap[instance.quality]);
  writeNotNull('recordingChannel', instance.recordingChannel);
  return val;
}

const _$AudioFileRecordingTypeEnumMap = {
  AudioFileRecordingType.audioFileRecordingMic: 1,
  AudioFileRecordingType.audioFileRecordingPlayback: 2,
  AudioFileRecordingType.audioFileRecordingMixed: 3,
};

const _$AudioRecordingQualityTypeEnumMap = {
  AudioRecordingQualityType.audioRecordingQualityLow: 0,
  AudioRecordingQualityType.audioRecordingQualityMedium: 1,
  AudioRecordingQualityType.audioRecordingQualityHigh: 2,
  AudioRecordingQualityType.audioRecordingQualityUltraHigh: 3,
};

AudioEncodedFrameObserverConfig _$AudioEncodedFrameObserverConfigFromJson(
        Map<String, dynamic> json) =>
    AudioEncodedFrameObserverConfig(
      postionType: $enumDecodeNullable(
          _$AudioEncodedFrameObserverPositionEnumMap, json['postionType']),
      encodingType:
          $enumDecodeNullable(_$AudioEncodingTypeEnumMap, json['encodingType']),
    );

Map<String, dynamic> _$AudioEncodedFrameObserverConfigToJson(
    AudioEncodedFrameObserverConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('postionType',
      _$AudioEncodedFrameObserverPositionEnumMap[instance.postionType]);
  writeNotNull(
      'encodingType', _$AudioEncodingTypeEnumMap[instance.encodingType]);
  return val;
}

const _$AudioEncodedFrameObserverPositionEnumMap = {
  AudioEncodedFrameObserverPosition.audioEncodedFrameObserverPositionRecord: 1,
  AudioEncodedFrameObserverPosition.audioEncodedFrameObserverPositionPlayback:
      2,
  AudioEncodedFrameObserverPosition.audioEncodedFrameObserverPositionMixed: 3,
};

const _$AudioEncodingTypeEnumMap = {
  AudioEncodingType.audioEncodingTypeAac16000Low: 65793,
  AudioEncodingType.audioEncodingTypeAac16000Medium: 65794,
  AudioEncodingType.audioEncodingTypeAac32000Low: 66049,
  AudioEncodingType.audioEncodingTypeAac32000Medium: 66050,
  AudioEncodingType.audioEncodingTypeAac32000High: 66051,
  AudioEncodingType.audioEncodingTypeAac48000Medium: 66306,
  AudioEncodingType.audioEncodingTypeAac48000High: 66307,
  AudioEncodingType.audioEncodingTypeOpus16000Low: 131329,
  AudioEncodingType.audioEncodingTypeOpus16000Medium: 131330,
  AudioEncodingType.audioEncodingTypeOpus48000Medium: 131842,
  AudioEncodingType.audioEncodingTypeOpus48000High: 131843,
};

ChannelMediaInfo _$ChannelMediaInfoFromJson(Map<String, dynamic> json) =>
    ChannelMediaInfo(
      channelName: json['channelName'] as String?,
      token: json['token'] as String?,
      uid: json['uid'] as int?,
    );

Map<String, dynamic> _$ChannelMediaInfoToJson(ChannelMediaInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('channelName', instance.channelName);
  writeNotNull('token', instance.token);
  writeNotNull('uid', instance.uid);
  return val;
}

ChannelMediaRelayConfiguration _$ChannelMediaRelayConfigurationFromJson(
        Map<String, dynamic> json) =>
    ChannelMediaRelayConfiguration(
      srcInfo: json['srcInfo'] == null
          ? null
          : ChannelMediaInfo.fromJson(json['srcInfo'] as Map<String, dynamic>),
      destInfos: (json['destInfos'] as List<dynamic>?)
          ?.map((e) => ChannelMediaInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      destCount: json['destCount'] as int?,
    );

Map<String, dynamic> _$ChannelMediaRelayConfigurationToJson(
    ChannelMediaRelayConfiguration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('srcInfo', instance.srcInfo?.toJson());
  writeNotNull(
      'destInfos', instance.destInfos?.map((e) => e.toJson()).toList());
  writeNotNull('destCount', instance.destCount);
  return val;
}

UplinkNetworkInfo _$UplinkNetworkInfoFromJson(Map<String, dynamic> json) =>
    UplinkNetworkInfo(
      videoEncoderTargetBitrateBps:
          json['video_encoder_target_bitrate_bps'] as int?,
    );

Map<String, dynamic> _$UplinkNetworkInfoToJson(UplinkNetworkInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('video_encoder_target_bitrate_bps',
      instance.videoEncoderTargetBitrateBps);
  return val;
}

DownlinkNetworkInfo _$DownlinkNetworkInfoFromJson(Map<String, dynamic> json) =>
    DownlinkNetworkInfo(
      lastmileBufferDelayTimeMs: json['lastmile_buffer_delay_time_ms'] as int?,
      bandwidthEstimationBps: json['bandwidth_estimation_bps'] as int?,
      totalDownscaleLevelCount: json['total_downscale_level_count'] as int?,
      peerDownlinkInfo: (json['peer_downlink_info'] as List<dynamic>?)
          ?.map((e) => PeerDownlinkInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalReceivedVideoCount: json['total_received_video_count'] as int?,
    );

Map<String, dynamic> _$DownlinkNetworkInfoToJson(DownlinkNetworkInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'lastmile_buffer_delay_time_ms', instance.lastmileBufferDelayTimeMs);
  writeNotNull('bandwidth_estimation_bps', instance.bandwidthEstimationBps);
  writeNotNull(
      'total_downscale_level_count', instance.totalDownscaleLevelCount);
  writeNotNull('peer_downlink_info',
      instance.peerDownlinkInfo?.map((e) => e.toJson()).toList());
  writeNotNull('total_received_video_count', instance.totalReceivedVideoCount);
  return val;
}

PeerDownlinkInfo _$PeerDownlinkInfoFromJson(Map<String, dynamic> json) =>
    PeerDownlinkInfo(
      uid: json['uid'] as String?,
      streamType:
          $enumDecodeNullable(_$VideoStreamTypeEnumMap, json['stream_type']),
      currentDownscaleLevel: $enumDecodeNullable(
          _$RemoteVideoDownscaleLevelEnumMap, json['current_downscale_level']),
      expectedBitrateBps: json['expected_bitrate_bps'] as int?,
    );

Map<String, dynamic> _$PeerDownlinkInfoToJson(PeerDownlinkInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uid', instance.uid);
  writeNotNull('stream_type', _$VideoStreamTypeEnumMap[instance.streamType]);
  writeNotNull('current_downscale_level',
      _$RemoteVideoDownscaleLevelEnumMap[instance.currentDownscaleLevel]);
  writeNotNull('expected_bitrate_bps', instance.expectedBitrateBps);
  return val;
}

const _$RemoteVideoDownscaleLevelEnumMap = {
  RemoteVideoDownscaleLevel.remoteVideoDownscaleLevelNone: 0,
  RemoteVideoDownscaleLevel.remoteVideoDownscaleLevel1: 1,
  RemoteVideoDownscaleLevel.remoteVideoDownscaleLevel2: 2,
  RemoteVideoDownscaleLevel.remoteVideoDownscaleLevel3: 3,
  RemoteVideoDownscaleLevel.remoteVideoDownscaleLevel4: 4,
};

EncryptionConfig _$EncryptionConfigFromJson(Map<String, dynamic> json) =>
    EncryptionConfig(
      encryptionMode:
          $enumDecodeNullable(_$EncryptionModeEnumMap, json['encryptionMode']),
      encryptionKey: json['encryptionKey'] as String?,
    );

Map<String, dynamic> _$EncryptionConfigToJson(EncryptionConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'encryptionMode', _$EncryptionModeEnumMap[instance.encryptionMode]);
  writeNotNull('encryptionKey', instance.encryptionKey);
  return val;
}

const _$EncryptionModeEnumMap = {
  EncryptionMode.aes128Xts: 1,
  EncryptionMode.aes128Ecb: 2,
  EncryptionMode.aes256Xts: 3,
  EncryptionMode.sm4128Ecb: 4,
  EncryptionMode.aes128Gcm: 5,
  EncryptionMode.aes256Gcm: 6,
  EncryptionMode.aes128Gcm2: 7,
  EncryptionMode.aes256Gcm2: 8,
  EncryptionMode.modeEnd: 9,
};

EchoTestConfiguration _$EchoTestConfigurationFromJson(
        Map<String, dynamic> json) =>
    EchoTestConfiguration(
      view: json['view'] as int?,
      enableAudio: json['enableAudio'] as bool?,
      enableVideo: json['enableVideo'] as bool?,
      token: json['token'] as String?,
      channelId: json['channelId'] as String?,
    );

Map<String, dynamic> _$EchoTestConfigurationToJson(
    EchoTestConfiguration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('view', instance.view);
  writeNotNull('enableAudio', instance.enableAudio);
  writeNotNull('enableVideo', instance.enableVideo);
  writeNotNull('token', instance.token);
  writeNotNull('channelId', instance.channelId);
  return val;
}

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      uid: json['uid'] as int?,
      userAccount: json['userAccount'] as String?,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uid', instance.uid);
  writeNotNull('userAccount', instance.userAccount);
  return val;
}

ScreenVideoParameters _$ScreenVideoParametersFromJson(
        Map<String, dynamic> json) =>
    ScreenVideoParameters(
      dimensions: json['dimensions'] == null
          ? null
          : VideoDimensions.fromJson(
              json['dimensions'] as Map<String, dynamic>),
      frameRate: json['frameRate'] as int?,
      bitrate: json['bitrate'] as int?,
      contentHint:
          $enumDecodeNullable(_$VideoContentHintEnumMap, json['contentHint']),
    );

Map<String, dynamic> _$ScreenVideoParametersToJson(
    ScreenVideoParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('dimensions', instance.dimensions?.toJson());
  writeNotNull('frameRate', instance.frameRate);
  writeNotNull('bitrate', instance.bitrate);
  writeNotNull('contentHint', _$VideoContentHintEnumMap[instance.contentHint]);
  return val;
}

const _$VideoContentHintEnumMap = {
  VideoContentHint.contentHintNone: 0,
  VideoContentHint.contentHintMotion: 1,
  VideoContentHint.contentHintDetails: 2,
};

ScreenAudioParameters _$ScreenAudioParametersFromJson(
        Map<String, dynamic> json) =>
    ScreenAudioParameters(
      sampleRate: json['sampleRate'] as int?,
      channels: json['channels'] as int?,
      captureSignalVolume: json['captureSignalVolume'] as int?,
    );

Map<String, dynamic> _$ScreenAudioParametersToJson(
    ScreenAudioParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sampleRate', instance.sampleRate);
  writeNotNull('channels', instance.channels);
  writeNotNull('captureSignalVolume', instance.captureSignalVolume);
  return val;
}

ScreenCaptureParameters2 _$ScreenCaptureParameters2FromJson(
        Map<String, dynamic> json) =>
    ScreenCaptureParameters2(
      captureAudio: json['captureAudio'] as bool?,
      audioParams: json['audioParams'] == null
          ? null
          : ScreenAudioParameters.fromJson(
              json['audioParams'] as Map<String, dynamic>),
      captureVideo: json['captureVideo'] as bool?,
      videoParams: json['videoParams'] == null
          ? null
          : ScreenVideoParameters.fromJson(
              json['videoParams'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ScreenCaptureParameters2ToJson(
    ScreenCaptureParameters2 instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('captureAudio', instance.captureAudio);
  writeNotNull('audioParams', instance.audioParams?.toJson());
  writeNotNull('captureVideo', instance.captureVideo);
  writeNotNull('videoParams', instance.videoParams?.toJson());
  return val;
}

SpatialAudioParams _$SpatialAudioParamsFromJson(Map<String, dynamic> json) =>
    SpatialAudioParams(
      speakerAzimuth: (json['speaker_azimuth'] as num?)?.toDouble(),
      speakerElevation: (json['speaker_elevation'] as num?)?.toDouble(),
      speakerDistance: (json['speaker_distance'] as num?)?.toDouble(),
      speakerOrientation: json['speaker_orientation'] as int?,
      enableBlur: json['enable_blur'] as bool?,
      enableAirAbsorb: json['enable_air_absorb'] as bool?,
      speakerAttenuation: (json['speaker_attenuation'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SpatialAudioParamsToJson(SpatialAudioParams instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('speaker_azimuth', instance.speakerAzimuth);
  writeNotNull('speaker_elevation', instance.speakerElevation);
  writeNotNull('speaker_distance', instance.speakerDistance);
  writeNotNull('speaker_orientation', instance.speakerOrientation);
  writeNotNull('enable_blur', instance.enableBlur);
  writeNotNull('enable_air_absorb', instance.enableAirAbsorb);
  writeNotNull('speaker_attenuation', instance.speakerAttenuation);
  return val;
}

const _$ChannelProfileTypeEnumMap = {
  ChannelProfileType.channelProfileCommunication: 0,
  ChannelProfileType.channelProfileLiveBroadcasting: 1,
  ChannelProfileType.channelProfileGame: 2,
  ChannelProfileType.channelProfileCloudGaming: 3,
  ChannelProfileType.channelProfileCommunication1v1: 4,
};

const _$WarnCodeTypeEnumMap = {
  WarnCodeType.warnInvalidView: 8,
  WarnCodeType.warnInitVideo: 16,
  WarnCodeType.warnPending: 20,
  WarnCodeType.warnNoAvailableChannel: 103,
  WarnCodeType.warnLookupChannelTimeout: 104,
  WarnCodeType.warnLookupChannelRejected: 105,
  WarnCodeType.warnOpenChannelTimeout: 106,
  WarnCodeType.warnOpenChannelRejected: 107,
  WarnCodeType.warnSwitchLiveVideoTimeout: 111,
  WarnCodeType.warnSetClientRoleTimeout: 118,
  WarnCodeType.warnOpenChannelInvalidTicket: 121,
  WarnCodeType.warnOpenChannelTryNextVos: 122,
  WarnCodeType.warnChannelConnectionUnrecoverable: 131,
  WarnCodeType.warnChannelConnectionIpChanged: 132,
  WarnCodeType.warnChannelConnectionPortChanged: 133,
  WarnCodeType.warnChannelSocketError: 134,
  WarnCodeType.warnAudioMixingOpenError: 701,
  WarnCodeType.warnAdmRuntimePlayoutWarning: 1014,
  WarnCodeType.warnAdmRuntimeRecordingWarning: 1016,
  WarnCodeType.warnAdmRecordAudioSilence: 1019,
  WarnCodeType.warnAdmPlayoutMalfunction: 1020,
  WarnCodeType.warnAdmRecordMalfunction: 1021,
  WarnCodeType.warnAdmRecordAudioLowlevel: 1031,
  WarnCodeType.warnAdmPlayoutAudioLowlevel: 1032,
  WarnCodeType.warnAdmWindowsNoDataReadyEvent: 1040,
  WarnCodeType.warnApmHowling: 1051,
  WarnCodeType.warnAdmGlitchState: 1052,
  WarnCodeType.warnAdmImproperSettings: 1053,
  WarnCodeType.warnAdmWinCoreNoRecordingDevice: 1322,
  WarnCodeType.warnAdmWinCoreNoPlayoutDevice: 1323,
  WarnCodeType.warnAdmWinCoreImproperCaptureRelease: 1324,
};

const _$ErrorCodeTypeEnumMap = {
  ErrorCodeType.errOk: 0,
  ErrorCodeType.errFailed: 1,
  ErrorCodeType.errInvalidArgument: 2,
  ErrorCodeType.errNotReady: 3,
  ErrorCodeType.errNotSupported: 4,
  ErrorCodeType.errRefused: 5,
  ErrorCodeType.errBufferTooSmall: 6,
  ErrorCodeType.errNotInitialized: 7,
  ErrorCodeType.errInvalidState: 8,
  ErrorCodeType.errNoPermission: 9,
  ErrorCodeType.errTimedout: 10,
  ErrorCodeType.errCanceled: 11,
  ErrorCodeType.errTooOften: 12,
  ErrorCodeType.errBindSocket: 13,
  ErrorCodeType.errNetDown: 14,
  ErrorCodeType.errJoinChannelRejected: 17,
  ErrorCodeType.errLeaveChannelRejected: 18,
  ErrorCodeType.errAlreadyInUse: 19,
  ErrorCodeType.errAborted: 20,
  ErrorCodeType.errInitNetEngine: 21,
  ErrorCodeType.errResourceLimited: 22,
  ErrorCodeType.errInvalidAppId: 101,
  ErrorCodeType.errInvalidChannelName: 102,
  ErrorCodeType.errNoServerResources: 103,
  ErrorCodeType.errTokenExpired: 109,
  ErrorCodeType.errInvalidToken: 110,
  ErrorCodeType.errConnectionInterrupted: 111,
  ErrorCodeType.errConnectionLost: 112,
  ErrorCodeType.errNotInChannel: 113,
  ErrorCodeType.errSizeTooLarge: 114,
  ErrorCodeType.errBitrateLimit: 115,
  ErrorCodeType.errTooManyDataStreams: 116,
  ErrorCodeType.errStreamMessageTimeout: 117,
  ErrorCodeType.errSetClientRoleNotAuthorized: 119,
  ErrorCodeType.errDecryptionFailed: 120,
  ErrorCodeType.errInvalidUserId: 121,
  ErrorCodeType.errClientIsBannedByServer: 123,
  ErrorCodeType.errEncryptedStreamNotAllowedPublish: 130,
  ErrorCodeType.errLicenseCredentialInvalid: 131,
  ErrorCodeType.errInvalidUserAccount: 134,
  ErrorCodeType.errModuleNotFound: 157,
  ErrorCodeType.errCertRaw: 157,
  ErrorCodeType.errCertJsonPart: 158,
  ErrorCodeType.errCertJsonInval: 159,
  ErrorCodeType.errCertJsonNomem: 160,
  ErrorCodeType.errCertCustom: 161,
  ErrorCodeType.errCertCredential: 162,
  ErrorCodeType.errCertSign: 163,
  ErrorCodeType.errCertFail: 164,
  ErrorCodeType.errCertBuf: 165,
  ErrorCodeType.errCertNull: 166,
  ErrorCodeType.errCertDuedate: 167,
  ErrorCodeType.errCertRequest: 168,
  ErrorCodeType.errPcmsendFormat: 200,
  ErrorCodeType.errPcmsendBufferoverflow: 201,
  ErrorCodeType.errLoginAlreadyLogin: 428,
  ErrorCodeType.errLoadMediaEngine: 1001,
  ErrorCodeType.errAdmGeneralError: 1005,
  ErrorCodeType.errAdmInitPlayout: 1008,
  ErrorCodeType.errAdmStartPlayout: 1009,
  ErrorCodeType.errAdmStopPlayout: 1010,
  ErrorCodeType.errAdmInitRecording: 1011,
  ErrorCodeType.errAdmStartRecording: 1012,
  ErrorCodeType.errAdmStopRecording: 1013,
  ErrorCodeType.errVdmCameraNotAuthorized: 1501,
};

const _$AudioSessionOperationRestrictionEnumMap = {
  AudioSessionOperationRestriction.audioSessionOperationRestrictionNone: 0,
  AudioSessionOperationRestriction.audioSessionOperationRestrictionSetCategory:
      1,
  AudioSessionOperationRestriction
      .audioSessionOperationRestrictionConfigureSession: 2,
  AudioSessionOperationRestriction
      .audioSessionOperationRestrictionDeactivateSession: 4,
  AudioSessionOperationRestriction.audioSessionOperationRestrictionAll: 128,
};

const _$UserOfflineReasonTypeEnumMap = {
  UserOfflineReasonType.userOfflineQuit: 0,
  UserOfflineReasonType.userOfflineDropped: 1,
  UserOfflineReasonType.userOfflineBecomeAudience: 2,
};

const _$InterfaceIdTypeEnumMap = {
  InterfaceIdType.agoraIidAudioDeviceManager: 1,
  InterfaceIdType.agoraIidVideoDeviceManager: 2,
  InterfaceIdType.agoraIidParameterEngine: 3,
  InterfaceIdType.agoraIidMediaEngine: 4,
  InterfaceIdType.agoraIidAudioEngine: 5,
  InterfaceIdType.agoraIidVideoEngine: 6,
  InterfaceIdType.agoraIidRtcConnection: 7,
  InterfaceIdType.agoraIidSignalingEngine: 8,
  InterfaceIdType.agoraIidMediaEngineRegulator: 9,
  InterfaceIdType.agoraIidCloudSpatialAudio: 10,
  InterfaceIdType.agoraIidLocalSpatialAudio: 11,
  InterfaceIdType.agoraIidMediaRecorder: 12,
  InterfaceIdType.agoraIidMusicContentCenter: 13,
};

const _$QualityTypeEnumMap = {
  QualityType.qualityUnknown: 0,
  QualityType.qualityExcellent: 1,
  QualityType.qualityGood: 2,
  QualityType.qualityPoor: 3,
  QualityType.qualityBad: 4,
  QualityType.qualityVbad: 5,
  QualityType.qualityDown: 6,
  QualityType.qualityUnsupported: 7,
  QualityType.qualityDetecting: 8,
};

const _$FitModeTypeEnumMap = {
  FitModeType.modeCover: 1,
  FitModeType.modeContain: 2,
};

const _$FrameRateEnumMap = {
  FrameRate.frameRateFps1: 1,
  FrameRate.frameRateFps7: 7,
  FrameRate.frameRateFps10: 10,
  FrameRate.frameRateFps15: 15,
  FrameRate.frameRateFps24: 24,
  FrameRate.frameRateFps30: 30,
  FrameRate.frameRateFps60: 60,
};

const _$FrameWidthEnumMap = {
  FrameWidth.frameWidth640: 640,
};

const _$FrameHeightEnumMap = {
  FrameHeight.frameHeight360: 360,
};

const _$H264PacketizeModeEnumMap = {
  H264PacketizeMode.nonInterleaved: 0,
  H264PacketizeMode.singleNalUnit: 1,
};

const _$SimulcastStreamModeEnumMap = {
  SimulcastStreamMode.autoSimulcastStream: -1,
  SimulcastStreamMode.disableSimulcastStream: 0,
  SimulcastStreamMode.enableSimulcastStream: 1,
};

const _$ClientRoleTypeEnumMap = {
  ClientRoleType.clientRoleBroadcaster: 1,
  ClientRoleType.clientRoleAudience: 2,
};

const _$QualityAdaptIndicationEnumMap = {
  QualityAdaptIndication.adaptNone: 0,
  QualityAdaptIndication.adaptUpBandwidth: 1,
  QualityAdaptIndication.adaptDownBandwidth: 2,
};

const _$ExperienceQualityTypeEnumMap = {
  ExperienceQualityType.experienceQualityGood: 0,
  ExperienceQualityType.experienceQualityBad: 1,
};

const _$ExperiencePoorReasonEnumMap = {
  ExperiencePoorReason.experienceReasonNone: 0,
  ExperiencePoorReason.remoteNetworkQualityPoor: 1,
  ExperiencePoorReason.localNetworkQualityPoor: 2,
  ExperiencePoorReason.wirelessSignalPoor: 4,
  ExperiencePoorReason.wifiBluetoothCoexist: 8,
};

const _$AudioProfileTypeEnumMap = {
  AudioProfileType.audioProfileDefault: 0,
  AudioProfileType.audioProfileSpeechStandard: 1,
  AudioProfileType.audioProfileMusicStandard: 2,
  AudioProfileType.audioProfileMusicStandardStereo: 3,
  AudioProfileType.audioProfileMusicHighQuality: 4,
  AudioProfileType.audioProfileMusicHighQualityStereo: 5,
  AudioProfileType.audioProfileIot: 6,
  AudioProfileType.audioProfileNum: 7,
};

const _$AudioScenarioTypeEnumMap = {
  AudioScenarioType.audioScenarioDefault: 0,
  AudioScenarioType.audioScenarioGameStreaming: 3,
  AudioScenarioType.audioScenarioChatroom: 5,
  AudioScenarioType.audioScenarioChorus: 7,
  AudioScenarioType.audioScenarioMeeting: 8,
  AudioScenarioType.audioScenarioNum: 9,
};

const _$ScreenScenarioTypeEnumMap = {
  ScreenScenarioType.screenScenarioDocument: 1,
  ScreenScenarioType.screenScenarioGaming: 2,
  ScreenScenarioType.screenScenarioVideo: 3,
  ScreenScenarioType.screenScenarioRdc: 4,
};

const _$CaptureBrightnessLevelTypeEnumMap = {
  CaptureBrightnessLevelType.captureBrightnessLevelInvalid: -1,
  CaptureBrightnessLevelType.captureBrightnessLevelNormal: 0,
  CaptureBrightnessLevelType.captureBrightnessLevelBright: 1,
  CaptureBrightnessLevelType.captureBrightnessLevelDark: 2,
};

const _$LocalAudioStreamStateEnumMap = {
  LocalAudioStreamState.localAudioStreamStateStopped: 0,
  LocalAudioStreamState.localAudioStreamStateRecording: 1,
  LocalAudioStreamState.localAudioStreamStateEncoding: 2,
  LocalAudioStreamState.localAudioStreamStateFailed: 3,
};

const _$LocalAudioStreamErrorEnumMap = {
  LocalAudioStreamError.localAudioStreamErrorOk: 0,
  LocalAudioStreamError.localAudioStreamErrorFailure: 1,
  LocalAudioStreamError.localAudioStreamErrorDeviceNoPermission: 2,
  LocalAudioStreamError.localAudioStreamErrorDeviceBusy: 3,
  LocalAudioStreamError.localAudioStreamErrorRecordFailure: 4,
  LocalAudioStreamError.localAudioStreamErrorEncodeFailure: 5,
  LocalAudioStreamError.localAudioStreamErrorNoRecordingDevice: 6,
  LocalAudioStreamError.localAudioStreamErrorNoPlayoutDevice: 7,
  LocalAudioStreamError.localAudioStreamErrorInterrupted: 8,
  LocalAudioStreamError.localAudioStreamErrorRecordInvalidId: 9,
  LocalAudioStreamError.localAudioStreamErrorPlayoutInvalidId: 10,
};

const _$LocalVideoStreamStateEnumMap = {
  LocalVideoStreamState.localVideoStreamStateStopped: 0,
  LocalVideoStreamState.localVideoStreamStateCapturing: 1,
  LocalVideoStreamState.localVideoStreamStateEncoding: 2,
  LocalVideoStreamState.localVideoStreamStateFailed: 3,
};

const _$LocalVideoStreamErrorEnumMap = {
  LocalVideoStreamError.localVideoStreamErrorOk: 0,
  LocalVideoStreamError.localVideoStreamErrorFailure: 1,
  LocalVideoStreamError.localVideoStreamErrorDeviceNoPermission: 2,
  LocalVideoStreamError.localVideoStreamErrorDeviceBusy: 3,
  LocalVideoStreamError.localVideoStreamErrorCaptureFailure: 4,
  LocalVideoStreamError.localVideoStreamErrorEncodeFailure: 5,
  LocalVideoStreamError.localVideoStreamErrorCaptureInbackground: 6,
  LocalVideoStreamError.localVideoStreamErrorCaptureMultipleForegroundApps: 7,
  LocalVideoStreamError.localVideoStreamErrorDeviceNotFound: 8,
  LocalVideoStreamError.localVideoStreamErrorDeviceDisconnected: 9,
  LocalVideoStreamError.localVideoStreamErrorDeviceInvalidId: 10,
  LocalVideoStreamError.localVideoStreamErrorDeviceSystemPressure: 101,
  LocalVideoStreamError.localVideoStreamErrorScreenCaptureWindowMinimized: 11,
  LocalVideoStreamError.localVideoStreamErrorScreenCaptureWindowClosed: 12,
  LocalVideoStreamError.localVideoStreamErrorScreenCaptureWindowOccluded: 13,
  LocalVideoStreamError.localVideoStreamErrorScreenCaptureWindowNotSupported:
      20,
};

const _$RemoteAudioStateEnumMap = {
  RemoteAudioState.remoteAudioStateStopped: 0,
  RemoteAudioState.remoteAudioStateStarting: 1,
  RemoteAudioState.remoteAudioStateDecoding: 2,
  RemoteAudioState.remoteAudioStateFrozen: 3,
  RemoteAudioState.remoteAudioStateFailed: 4,
};

const _$RemoteAudioStateReasonEnumMap = {
  RemoteAudioStateReason.remoteAudioReasonInternal: 0,
  RemoteAudioStateReason.remoteAudioReasonNetworkCongestion: 1,
  RemoteAudioStateReason.remoteAudioReasonNetworkRecovery: 2,
  RemoteAudioStateReason.remoteAudioReasonLocalMuted: 3,
  RemoteAudioStateReason.remoteAudioReasonLocalUnmuted: 4,
  RemoteAudioStateReason.remoteAudioReasonRemoteMuted: 5,
  RemoteAudioStateReason.remoteAudioReasonRemoteUnmuted: 6,
  RemoteAudioStateReason.remoteAudioReasonRemoteOffline: 7,
};

const _$RemoteVideoStateEnumMap = {
  RemoteVideoState.remoteVideoStateStopped: 0,
  RemoteVideoState.remoteVideoStateStarting: 1,
  RemoteVideoState.remoteVideoStateDecoding: 2,
  RemoteVideoState.remoteVideoStateFrozen: 3,
  RemoteVideoState.remoteVideoStateFailed: 4,
};

const _$RemoteVideoStateReasonEnumMap = {
  RemoteVideoStateReason.remoteVideoStateReasonInternal: 0,
  RemoteVideoStateReason.remoteVideoStateReasonNetworkCongestion: 1,
  RemoteVideoStateReason.remoteVideoStateReasonNetworkRecovery: 2,
  RemoteVideoStateReason.remoteVideoStateReasonLocalMuted: 3,
  RemoteVideoStateReason.remoteVideoStateReasonLocalUnmuted: 4,
  RemoteVideoStateReason.remoteVideoStateReasonRemoteMuted: 5,
  RemoteVideoStateReason.remoteVideoStateReasonRemoteUnmuted: 6,
  RemoteVideoStateReason.remoteVideoStateReasonRemoteOffline: 7,
  RemoteVideoStateReason.remoteVideoStateReasonAudioFallback: 8,
  RemoteVideoStateReason.remoteVideoStateReasonAudioFallbackRecovery: 9,
  RemoteVideoStateReason.remoteVideoStateReasonVideoStreamTypeChangeToLow: 10,
  RemoteVideoStateReason.remoteVideoStateReasonVideoStreamTypeChangeToHigh: 11,
  RemoteVideoStateReason.remoteVideoStateReasonSdkInBackground: 12,
};

const _$RemoteUserStateEnumMap = {
  RemoteUserState.userStateMuteAudio: 1,
  RemoteUserState.userStateMuteVideo: 2,
  RemoteUserState.userStateEnableVideo: 16,
  RemoteUserState.userStateEnableLocalVideo: 256,
};

const _$RtmpStreamPublishStateEnumMap = {
  RtmpStreamPublishState.rtmpStreamPublishStateIdle: 0,
  RtmpStreamPublishState.rtmpStreamPublishStateConnecting: 1,
  RtmpStreamPublishState.rtmpStreamPublishStateRunning: 2,
  RtmpStreamPublishState.rtmpStreamPublishStateRecovering: 3,
  RtmpStreamPublishState.rtmpStreamPublishStateFailure: 4,
  RtmpStreamPublishState.rtmpStreamPublishStateDisconnecting: 5,
};

const _$RtmpStreamPublishErrorTypeEnumMap = {
  RtmpStreamPublishErrorType.rtmpStreamPublishErrorOk: 0,
  RtmpStreamPublishErrorType.rtmpStreamPublishErrorInvalidArgument: 1,
  RtmpStreamPublishErrorType.rtmpStreamPublishErrorEncryptedStreamNotAllowed: 2,
  RtmpStreamPublishErrorType.rtmpStreamPublishErrorConnectionTimeout: 3,
  RtmpStreamPublishErrorType.rtmpStreamPublishErrorInternalServerError: 4,
  RtmpStreamPublishErrorType.rtmpStreamPublishErrorRtmpServerError: 5,
  RtmpStreamPublishErrorType.rtmpStreamPublishErrorTooOften: 6,
  RtmpStreamPublishErrorType.rtmpStreamPublishErrorReachLimit: 7,
  RtmpStreamPublishErrorType.rtmpStreamPublishErrorNotAuthorized: 8,
  RtmpStreamPublishErrorType.rtmpStreamPublishErrorStreamNotFound: 9,
  RtmpStreamPublishErrorType.rtmpStreamPublishErrorFormatNotSupported: 10,
  RtmpStreamPublishErrorType.rtmpStreamPublishErrorNotBroadcaster: 11,
  RtmpStreamPublishErrorType.rtmpStreamPublishErrorTranscodingNoMixStream: 13,
  RtmpStreamPublishErrorType.rtmpStreamPublishErrorNetDown: 14,
  RtmpStreamPublishErrorType.rtmpStreamPublishErrorInvalidAppid: 15,
  RtmpStreamPublishErrorType.rtmpStreamPublishErrorInvalidPrivilege: 16,
  RtmpStreamPublishErrorType.rtmpStreamUnpublishErrorOk: 100,
};

const _$RtmpStreamingEventEnumMap = {
  RtmpStreamingEvent.rtmpStreamingEventFailedLoadImage: 1,
  RtmpStreamingEvent.rtmpStreamingEventUrlAlreadyInUse: 2,
  RtmpStreamingEvent.rtmpStreamingEventAdvancedFeatureNotSupport: 3,
  RtmpStreamingEvent.rtmpStreamingEventRequestTooOften: 4,
};

const _$ConnectionStateTypeEnumMap = {
  ConnectionStateType.connectionStateDisconnected: 1,
  ConnectionStateType.connectionStateConnecting: 2,
  ConnectionStateType.connectionStateConnected: 3,
  ConnectionStateType.connectionStateReconnecting: 4,
  ConnectionStateType.connectionStateFailed: 5,
};

const _$ConnectionChangedReasonTypeEnumMap = {
  ConnectionChangedReasonType.connectionChangedConnecting: 0,
  ConnectionChangedReasonType.connectionChangedJoinSuccess: 1,
  ConnectionChangedReasonType.connectionChangedInterrupted: 2,
  ConnectionChangedReasonType.connectionChangedBannedByServer: 3,
  ConnectionChangedReasonType.connectionChangedJoinFailed: 4,
  ConnectionChangedReasonType.connectionChangedLeaveChannel: 5,
  ConnectionChangedReasonType.connectionChangedInvalidAppId: 6,
  ConnectionChangedReasonType.connectionChangedInvalidChannelName: 7,
  ConnectionChangedReasonType.connectionChangedInvalidToken: 8,
  ConnectionChangedReasonType.connectionChangedTokenExpired: 9,
  ConnectionChangedReasonType.connectionChangedRejectedByServer: 10,
  ConnectionChangedReasonType.connectionChangedSettingProxyServer: 11,
  ConnectionChangedReasonType.connectionChangedRenewToken: 12,
  ConnectionChangedReasonType.connectionChangedClientIpAddressChanged: 13,
  ConnectionChangedReasonType.connectionChangedKeepAliveTimeout: 14,
  ConnectionChangedReasonType.connectionChangedRejoinSuccess: 15,
  ConnectionChangedReasonType.connectionChangedLost: 16,
  ConnectionChangedReasonType.connectionChangedEchoTest: 17,
  ConnectionChangedReasonType.connectionChangedClientIpAddressChangedByUser: 18,
  ConnectionChangedReasonType.connectionChangedSameUidLogin: 19,
  ConnectionChangedReasonType.connectionChangedTooManyBroadcasters: 20,
};

const _$ClientRoleChangeFailedReasonEnumMap = {
  ClientRoleChangeFailedReason.clientRoleChangeFailedTooManyBroadcasters: 1,
  ClientRoleChangeFailedReason.clientRoleChangeFailedNotAuthorized: 2,
  ClientRoleChangeFailedReason.clientRoleChangeFailedRequestTimeOut: 3,
  ClientRoleChangeFailedReason.clientRoleChangeFailedConnectionFailed: 4,
};

const _$WlaccMessageReasonEnumMap = {
  WlaccMessageReason.wlaccMessageReasonWeakSignal: 0,
  WlaccMessageReason.wlaccMessageReasonChannelCongestion: 1,
};

const _$WlaccSuggestActionEnumMap = {
  WlaccSuggestAction.wlaccSuggestActionCloseToWifi: 0,
  WlaccSuggestAction.wlaccSuggestActionConnectSsid: 1,
  WlaccSuggestAction.wlaccSuggestActionCheck5g: 2,
  WlaccSuggestAction.wlaccSuggestActionModifySsid: 3,
};

const _$NetworkTypeEnumMap = {
  NetworkType.networkTypeUnknown: -1,
  NetworkType.networkTypeDisconnected: 0,
  NetworkType.networkTypeLan: 1,
  NetworkType.networkTypeWifi: 2,
  NetworkType.networkTypeMobile2g: 3,
  NetworkType.networkTypeMobile3g: 4,
  NetworkType.networkTypeMobile4g: 5,
};

const _$VoiceBeautifierPresetEnumMap = {
  VoiceBeautifierPreset.voiceBeautifierOff: 0,
  VoiceBeautifierPreset.chatBeautifierMagnetic: 16843008,
  VoiceBeautifierPreset.chatBeautifierFresh: 16843264,
  VoiceBeautifierPreset.chatBeautifierVitality: 16843520,
  VoiceBeautifierPreset.singingBeautifier: 16908544,
  VoiceBeautifierPreset.timbreTransformationVigorous: 16974080,
  VoiceBeautifierPreset.timbreTransformationDeep: 16974336,
  VoiceBeautifierPreset.timbreTransformationMellow: 16974592,
  VoiceBeautifierPreset.timbreTransformationFalsetto: 16974848,
  VoiceBeautifierPreset.timbreTransformationFull: 16975104,
  VoiceBeautifierPreset.timbreTransformationClear: 16975360,
  VoiceBeautifierPreset.timbreTransformationResounding: 16975616,
  VoiceBeautifierPreset.timbreTransformationRinging: 16975872,
  VoiceBeautifierPreset.ultraHighQualityVoice: 17039616,
};

const _$AudioEffectPresetEnumMap = {
  AudioEffectPreset.audioEffectOff: 0,
  AudioEffectPreset.roomAcousticsKtv: 33620224,
  AudioEffectPreset.roomAcousticsVocalConcert: 33620480,
  AudioEffectPreset.roomAcousticsStudio: 33620736,
  AudioEffectPreset.roomAcousticsPhonograph: 33620992,
  AudioEffectPreset.roomAcousticsVirtualStereo: 33621248,
  AudioEffectPreset.roomAcousticsSpacial: 33621504,
  AudioEffectPreset.roomAcousticsEthereal: 33621760,
  AudioEffectPreset.roomAcoustics3dVoice: 33622016,
  AudioEffectPreset.roomAcousticsVirtualSurroundSound: 33622272,
  AudioEffectPreset.voiceChangerEffectUncle: 33685760,
  AudioEffectPreset.voiceChangerEffectOldman: 33686016,
  AudioEffectPreset.voiceChangerEffectBoy: 33686272,
  AudioEffectPreset.voiceChangerEffectSister: 33686528,
  AudioEffectPreset.voiceChangerEffectGirl: 33686784,
  AudioEffectPreset.voiceChangerEffectPigking: 33687040,
  AudioEffectPreset.voiceChangerEffectHulk: 33687296,
  AudioEffectPreset.styleTransformationRnb: 33751296,
  AudioEffectPreset.styleTransformationPopular: 33751552,
  AudioEffectPreset.pitchCorrection: 33816832,
};

const _$VoiceConversionPresetEnumMap = {
  VoiceConversionPreset.voiceConversionOff: 0,
  VoiceConversionPreset.voiceChangerNeutral: 50397440,
  VoiceConversionPreset.voiceChangerSweet: 50397696,
  VoiceConversionPreset.voiceChangerSolid: 50397952,
  VoiceConversionPreset.voiceChangerBass: 50398208,
};

const _$AreaCodeEnumMap = {
  AreaCode.areaCodeCn: 1,
  AreaCode.areaCodeNa: 2,
  AreaCode.areaCodeEu: 4,
  AreaCode.areaCodeAs: 8,
  AreaCode.areaCodeJp: 16,
  AreaCode.areaCodeIn: 32,
  AreaCode.areaCodeGlob: 4294967295,
};

const _$AreaCodeExEnumMap = {
  AreaCodeEx.areaCodeOc: 64,
  AreaCodeEx.areaCodeSa: 128,
  AreaCodeEx.areaCodeAf: 256,
  AreaCodeEx.areaCodeKr: 512,
  AreaCodeEx.areaCodeHkmc: 1024,
  AreaCodeEx.areaCodeUs: 2048,
  AreaCodeEx.areaCodeOvs: 4294967294,
};

const _$ChannelMediaRelayErrorEnumMap = {
  ChannelMediaRelayError.relayOk: 0,
  ChannelMediaRelayError.relayErrorServerErrorResponse: 1,
  ChannelMediaRelayError.relayErrorServerNoResponse: 2,
  ChannelMediaRelayError.relayErrorNoResourceAvailable: 3,
  ChannelMediaRelayError.relayErrorFailedJoinSrc: 4,
  ChannelMediaRelayError.relayErrorFailedJoinDest: 5,
  ChannelMediaRelayError.relayErrorFailedPacketReceivedFromSrc: 6,
  ChannelMediaRelayError.relayErrorFailedPacketSentToDest: 7,
  ChannelMediaRelayError.relayErrorServerConnectionLost: 8,
  ChannelMediaRelayError.relayErrorInternalError: 9,
  ChannelMediaRelayError.relayErrorSrcTokenExpired: 10,
  ChannelMediaRelayError.relayErrorDestTokenExpired: 11,
};

const _$ChannelMediaRelayEventEnumMap = {
  ChannelMediaRelayEvent.relayEventNetworkDisconnected: 0,
  ChannelMediaRelayEvent.relayEventNetworkConnected: 1,
  ChannelMediaRelayEvent.relayEventPacketJoinedSrcChannel: 2,
  ChannelMediaRelayEvent.relayEventPacketJoinedDestChannel: 3,
  ChannelMediaRelayEvent.relayEventPacketSentToDestChannel: 4,
  ChannelMediaRelayEvent.relayEventPacketReceivedVideoFromSrc: 5,
  ChannelMediaRelayEvent.relayEventPacketReceivedAudioFromSrc: 6,
  ChannelMediaRelayEvent.relayEventPacketUpdateDestChannel: 7,
  ChannelMediaRelayEvent.relayEventPacketUpdateDestChannelRefused: 8,
  ChannelMediaRelayEvent.relayEventPacketUpdateDestChannelNotChange: 9,
  ChannelMediaRelayEvent.relayEventPacketUpdateDestChannelIsNull: 10,
  ChannelMediaRelayEvent.relayEventVideoProfileUpdate: 11,
  ChannelMediaRelayEvent.relayEventPauseSendPacketToDestChannelSuccess: 12,
  ChannelMediaRelayEvent.relayEventPauseSendPacketToDestChannelFailed: 13,
  ChannelMediaRelayEvent.relayEventResumeSendPacketToDestChannelSuccess: 14,
  ChannelMediaRelayEvent.relayEventResumeSendPacketToDestChannelFailed: 15,
};

const _$ChannelMediaRelayStateEnumMap = {
  ChannelMediaRelayState.relayStateIdle: 0,
  ChannelMediaRelayState.relayStateConnecting: 1,
  ChannelMediaRelayState.relayStateRunning: 2,
  ChannelMediaRelayState.relayStateFailure: 3,
};

const _$EncryptionErrorTypeEnumMap = {
  EncryptionErrorType.encryptionErrorInternalFailure: 0,
  EncryptionErrorType.encryptionErrorDecryptionFailure: 1,
  EncryptionErrorType.encryptionErrorEncryptionFailure: 2,
};

const _$UploadErrorReasonEnumMap = {
  UploadErrorReason.uploadSuccess: 0,
  UploadErrorReason.uploadNetError: 1,
  UploadErrorReason.uploadServerError: 2,
};

const _$PermissionTypeEnumMap = {
  PermissionType.recordAudio: 0,
  PermissionType.camera: 1,
  PermissionType.screenCapture: 2,
};

const _$MaxUserAccountLengthTypeEnumMap = {
  MaxUserAccountLengthType.maxUserAccountLength: 256,
};

const _$StreamSubscribeStateEnumMap = {
  StreamSubscribeState.subStateIdle: 0,
  StreamSubscribeState.subStateNoSubscribed: 1,
  StreamSubscribeState.subStateSubscribing: 2,
  StreamSubscribeState.subStateSubscribed: 3,
};

const _$StreamPublishStateEnumMap = {
  StreamPublishState.pubStateIdle: 0,
  StreamPublishState.pubStateNoPublished: 1,
  StreamPublishState.pubStatePublishing: 2,
  StreamPublishState.pubStatePublished: 3,
};

const _$EarMonitoringFilterTypeEnumMap = {
  EarMonitoringFilterType.earMonitoringFilterNone: 1,
  EarMonitoringFilterType.earMonitoringFilterBuiltInAudioFilters: 2,
  EarMonitoringFilterType.earMonitoringFilterNoiseSuppression: 4,
};

const _$ThreadPriorityTypeEnumMap = {
  ThreadPriorityType.lowest: 0,
  ThreadPriorityType.low: 1,
  ThreadPriorityType.normal: 2,
  ThreadPriorityType.high: 3,
  ThreadPriorityType.highest: 4,
  ThreadPriorityType.critical: 5,
};
