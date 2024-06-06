// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names, deprecated_member_use_from_same_package, unused_element

part of 'agora_base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoDimensions _$VideoDimensionsFromJson(Map<String, dynamic> json) =>
    VideoDimensions(
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
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
      targetBitrate: (json['targetBitrate'] as num?)?.toInt(),
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
      sampleRateHz: (json['sampleRateHz'] as num?)?.toInt(),
      samplesPerChannel: (json['samplesPerChannel'] as num?)?.toInt(),
      numberOfChannels: (json['numberOfChannels'] as num?)?.toInt(),
      advancedSettings: json['advancedSettings'] == null
          ? null
          : EncodedAudioFrameAdvancedSettings.fromJson(
              json['advancedSettings'] as Map<String, dynamic>),
      captureTimeMs: (json['captureTimeMs'] as num?)?.toInt(),
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
      samplesPerChannel: (json['samplesPerChannel'] as num?)?.toInt(),
      channelNum: (json['channelNum'] as num?)?.toInt(),
      samplesOut: (json['samplesOut'] as num?)?.toInt(),
      elapsedTimeMs: (json['elapsedTimeMs'] as num?)?.toInt(),
      ntpTimeMs: (json['ntpTimeMs'] as num?)?.toInt(),
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
      uid: (json['uid'] as num?)?.toInt(),
      codecType:
          $enumDecodeNullable(_$VideoCodecTypeEnumMap, json['codecType']),
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      framesPerSecond: (json['framesPerSecond'] as num?)?.toInt(),
      frameType:
          $enumDecodeNullable(_$VideoFrameTypeEnumMap, json['frameType']),
      rotation:
          $enumDecodeNullable(_$VideoOrientationEnumMap, json['rotation']),
      trackId: (json['trackId'] as num?)?.toInt(),
      captureTimeMs: (json['captureTimeMs'] as num?)?.toInt(),
      decodeTimeMs: (json['decodeTimeMs'] as num?)?.toInt(),
      streamType:
          $enumDecodeNullable(_$VideoStreamTypeEnumMap, json['streamType']),
      presentationMs: (json['presentationMs'] as num?)?.toInt(),
    );

Map<String, dynamic> _$EncodedVideoFrameInfoToJson(
    EncodedVideoFrameInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uid', instance.uid);
  writeNotNull('codecType', _$VideoCodecTypeEnumMap[instance.codecType]);
  writeNotNull('width', instance.width);
  writeNotNull('height', instance.height);
  writeNotNull('framesPerSecond', instance.framesPerSecond);
  writeNotNull('frameType', _$VideoFrameTypeEnumMap[instance.frameType]);
  writeNotNull('rotation', _$VideoOrientationEnumMap[instance.rotation]);
  writeNotNull('trackId', instance.trackId);
  writeNotNull('captureTimeMs', instance.captureTimeMs);
  writeNotNull('decodeTimeMs', instance.decodeTimeMs);
  writeNotNull('streamType', _$VideoStreamTypeEnumMap[instance.streamType]);
  writeNotNull('presentationMs', instance.presentationMs);
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

AdvanceOptions _$AdvanceOptionsFromJson(Map<String, dynamic> json) =>
    AdvanceOptions(
      encodingPreference: $enumDecodeNullable(
          _$EncodingPreferenceEnumMap, json['encodingPreference']),
      compressionPreference: $enumDecodeNullable(
          _$CompressionPreferenceEnumMap, json['compressionPreference']),
    );

Map<String, dynamic> _$AdvanceOptionsToJson(AdvanceOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('encodingPreference',
      _$EncodingPreferenceEnumMap[instance.encodingPreference]);
  writeNotNull('compressionPreference',
      _$CompressionPreferenceEnumMap[instance.compressionPreference]);
  return val;
}

const _$EncodingPreferenceEnumMap = {
  EncodingPreference.preferAuto: -1,
  EncodingPreference.preferSoftware: 0,
  EncodingPreference.preferHardware: 1,
};

const _$CompressionPreferenceEnumMap = {
  CompressionPreference.preferLowLatency: 0,
  CompressionPreference.preferQuality: 1,
};

CodecCapLevels _$CodecCapLevelsFromJson(Map<String, dynamic> json) =>
    CodecCapLevels(
      hwDecodingLevel: $enumDecodeNullable(
          _$VideoCodecCapabilityLevelEnumMap, json['hwDecodingLevel']),
      swDecodingLevel: $enumDecodeNullable(
          _$VideoCodecCapabilityLevelEnumMap, json['swDecodingLevel']),
    );

Map<String, dynamic> _$CodecCapLevelsToJson(CodecCapLevels instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('hwDecodingLevel',
      _$VideoCodecCapabilityLevelEnumMap[instance.hwDecodingLevel]);
  writeNotNull('swDecodingLevel',
      _$VideoCodecCapabilityLevelEnumMap[instance.swDecodingLevel]);
  return val;
}

const _$VideoCodecCapabilityLevelEnumMap = {
  VideoCodecCapabilityLevel.codecCapabilityLevelUnspecified: -1,
  VideoCodecCapabilityLevel.codecCapabilityLevelBasicSupport: 5,
  VideoCodecCapabilityLevel.codecCapabilityLevel1080p30fps: 10,
  VideoCodecCapabilityLevel.codecCapabilityLevel1080p60fps: 20,
  VideoCodecCapabilityLevel.codecCapabilityLevel4k60fps: 30,
};

CodecCapInfo _$CodecCapInfoFromJson(Map<String, dynamic> json) => CodecCapInfo(
      codecType:
          $enumDecodeNullable(_$VideoCodecTypeEnumMap, json['codecType']),
      codecCapMask: (json['codecCapMask'] as num?)?.toInt(),
      codecLevels: json['codecLevels'] == null
          ? null
          : CodecCapLevels.fromJson(
              json['codecLevels'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CodecCapInfoToJson(CodecCapInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('codecType', _$VideoCodecTypeEnumMap[instance.codecType]);
  writeNotNull('codecCapMask', instance.codecCapMask);
  writeNotNull('codecLevels', instance.codecLevels?.toJson());
  return val;
}

FocalLengthInfo _$FocalLengthInfoFromJson(Map<String, dynamic> json) =>
    FocalLengthInfo(
      cameraDirection: (json['cameraDirection'] as num?)?.toInt(),
      focalLengthType: $enumDecodeNullable(
          _$CameraFocalLengthTypeEnumMap, json['focalLengthType']),
    );

Map<String, dynamic> _$FocalLengthInfoToJson(FocalLengthInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('cameraDirection', instance.cameraDirection);
  writeNotNull('focalLengthType',
      _$CameraFocalLengthTypeEnumMap[instance.focalLengthType]);
  return val;
}

const _$CameraFocalLengthTypeEnumMap = {
  CameraFocalLengthType.cameraFocalLengthDefault: 0,
  CameraFocalLengthType.cameraFocalLengthWideAngle: 1,
  CameraFocalLengthType.cameraFocalLengthUltraWide: 2,
  CameraFocalLengthType.cameraFocalLengthTelephoto: 3,
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
      frameRate: (json['frameRate'] as num?)?.toInt(),
      bitrate: (json['bitrate'] as num?)?.toInt(),
      minBitrate: (json['minBitrate'] as num?)?.toInt(),
      orientationMode: $enumDecodeNullable(
          _$OrientationModeEnumMap, json['orientationMode']),
      degradationPreference: $enumDecodeNullable(
          _$DegradationPreferenceEnumMap, json['degradationPreference']),
      mirrorMode:
          $enumDecodeNullable(_$VideoMirrorModeTypeEnumMap, json['mirrorMode']),
      advanceOptions: json['advanceOptions'] == null
          ? null
          : AdvanceOptions.fromJson(
              json['advanceOptions'] as Map<String, dynamic>),
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
  writeNotNull('advanceOptions', instance.advanceOptions?.toJson());
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
      kBitrate: (json['kBitrate'] as num?)?.toInt(),
      framerate: (json['framerate'] as num?)?.toInt(),
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
  writeNotNull('kBitrate', instance.kBitrate);
  writeNotNull('framerate', instance.framerate);
  return val;
}

Rectangle _$RectangleFromJson(Map<String, dynamic> json) => Rectangle(
      x: (json['x'] as num?)?.toInt(),
      y: (json['y'] as num?)?.toInt(),
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
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
      duration: (json['duration'] as num?)?.toInt(),
      txBytes: (json['txBytes'] as num?)?.toInt(),
      rxBytes: (json['rxBytes'] as num?)?.toInt(),
      txAudioBytes: (json['txAudioBytes'] as num?)?.toInt(),
      txVideoBytes: (json['txVideoBytes'] as num?)?.toInt(),
      rxAudioBytes: (json['rxAudioBytes'] as num?)?.toInt(),
      rxVideoBytes: (json['rxVideoBytes'] as num?)?.toInt(),
      txKBitRate: (json['txKBitRate'] as num?)?.toInt(),
      rxKBitRate: (json['rxKBitRate'] as num?)?.toInt(),
      rxAudioKBitRate: (json['rxAudioKBitRate'] as num?)?.toInt(),
      txAudioKBitRate: (json['txAudioKBitRate'] as num?)?.toInt(),
      rxVideoKBitRate: (json['rxVideoKBitRate'] as num?)?.toInt(),
      txVideoKBitRate: (json['txVideoKBitRate'] as num?)?.toInt(),
      lastmileDelay: (json['lastmileDelay'] as num?)?.toInt(),
      userCount: (json['userCount'] as num?)?.toInt(),
      cpuAppUsage: (json['cpuAppUsage'] as num?)?.toDouble(),
      cpuTotalUsage: (json['cpuTotalUsage'] as num?)?.toDouble(),
      gatewayRtt: (json['gatewayRtt'] as num?)?.toInt(),
      memoryAppUsageRatio: (json['memoryAppUsageRatio'] as num?)?.toDouble(),
      memoryTotalUsageRatio:
          (json['memoryTotalUsageRatio'] as num?)?.toDouble(),
      memoryAppUsageInKbytes: (json['memoryAppUsageInKbytes'] as num?)?.toInt(),
      connectTimeMs: (json['connectTimeMs'] as num?)?.toInt(),
      firstAudioPacketDuration:
          (json['firstAudioPacketDuration'] as num?)?.toInt(),
      firstVideoPacketDuration:
          (json['firstVideoPacketDuration'] as num?)?.toInt(),
      firstVideoKeyFramePacketDuration:
          (json['firstVideoKeyFramePacketDuration'] as num?)?.toInt(),
      packetsBeforeFirstKeyFramePacket:
          (json['packetsBeforeFirstKeyFramePacket'] as num?)?.toInt(),
      firstAudioPacketDurationAfterUnmute:
          (json['firstAudioPacketDurationAfterUnmute'] as num?)?.toInt(),
      firstVideoPacketDurationAfterUnmute:
          (json['firstVideoPacketDurationAfterUnmute'] as num?)?.toInt(),
      firstVideoKeyFramePacketDurationAfterUnmute:
          (json['firstVideoKeyFramePacketDurationAfterUnmute'] as num?)
              ?.toInt(),
      firstVideoKeyFrameDecodedDurationAfterUnmute:
          (json['firstVideoKeyFrameDecodedDurationAfterUnmute'] as num?)
              ?.toInt(),
      firstVideoKeyFrameRenderedDurationAfterUnmute:
          (json['firstVideoKeyFrameRenderedDurationAfterUnmute'] as num?)
              ?.toInt(),
      txPacketLossRate: (json['txPacketLossRate'] as num?)?.toInt(),
      rxPacketLossRate: (json['rxPacketLossRate'] as num?)?.toInt(),
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

VideoFormat _$VideoFormatFromJson(Map<String, dynamic> json) => VideoFormat(
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      fps: (json['fps'] as num?)?.toInt(),
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
      ownerUid: (json['ownerUid'] as num?)?.toInt(),
      trackId: (json['trackId'] as num?)?.toInt(),
      channelId: json['channelId'] as String?,
      codecType:
          $enumDecodeNullable(_$VideoCodecTypeEnumMap, json['codecType']),
      encodedFrameOnly: json['encodedFrameOnly'] as bool?,
      sourceType:
          $enumDecodeNullable(_$VideoSourceTypeEnumMap, json['sourceType']),
      observationPosition: (json['observationPosition'] as num?)?.toInt(),
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
  VideoSourceType.videoSourceCameraThird: 11,
  VideoSourceType.videoSourceCameraFourth: 12,
  VideoSourceType.videoSourceScreenThird: 13,
  VideoSourceType.videoSourceScreenFourth: 14,
  VideoSourceType.videoSourceSpeechDriven: 15,
  VideoSourceType.videoSourceUnknown: 100,
};

AudioVolumeInfo _$AudioVolumeInfoFromJson(Map<String, dynamic> json) =>
    AudioVolumeInfo(
      uid: (json['uid'] as num?)?.toInt(),
      volume: (json['volume'] as num?)?.toInt(),
      vad: (json['vad'] as num?)?.toInt(),
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
      size: (json['size'] as num?)?.toInt(),
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
      numChannels: (json['numChannels'] as num?)?.toInt(),
      sentSampleRate: (json['sentSampleRate'] as num?)?.toInt(),
      sentBitrate: (json['sentBitrate'] as num?)?.toInt(),
      internalCodec: (json['internalCodec'] as num?)?.toInt(),
      txPacketLossRate: (json['txPacketLossRate'] as num?)?.toInt(),
      audioDeviceDelay: (json['audioDeviceDelay'] as num?)?.toInt(),
      audioPlayoutDelay: (json['audioPlayoutDelay'] as num?)?.toInt(),
      earMonitorDelay: (json['earMonitorDelay'] as num?)?.toInt(),
      aecEstimatedDelay: (json['aecEstimatedDelay'] as num?)?.toInt(),
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
  writeNotNull('audioPlayoutDelay', instance.audioPlayoutDelay);
  writeNotNull('earMonitorDelay', instance.earMonitorDelay);
  writeNotNull('aecEstimatedDelay', instance.aecEstimatedDelay);
  return val;
}

RtcImage _$RtcImageFromJson(Map<String, dynamic> json) => RtcImage(
      url: json['url'] as String?,
      x: (json['x'] as num?)?.toInt(),
      y: (json['y'] as num?)?.toInt(),
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      zOrder: (json['zOrder'] as num?)?.toInt(),
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
      uid: (json['uid'] as num?)?.toInt(),
      x: (json['x'] as num?)?.toInt(),
      y: (json['y'] as num?)?.toInt(),
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      zOrder: (json['zOrder'] as num?)?.toInt(),
      alpha: (json['alpha'] as num?)?.toDouble(),
      audioChannel: (json['audioChannel'] as num?)?.toInt(),
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
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      videoBitrate: (json['videoBitrate'] as num?)?.toInt(),
      videoFramerate: (json['videoFramerate'] as num?)?.toInt(),
      lowLatency: json['lowLatency'] as bool?,
      videoGop: (json['videoGop'] as num?)?.toInt(),
      videoCodecProfile: $enumDecodeNullable(
          _$VideoCodecProfileTypeEnumMap, json['videoCodecProfile']),
      backgroundColor: (json['backgroundColor'] as num?)?.toInt(),
      videoCodecType: $enumDecodeNullable(
          _$VideoCodecTypeForStreamEnumMap, json['videoCodecType']),
      userCount: (json['userCount'] as num?)?.toInt(),
      transcodingUsers: (json['transcodingUsers'] as List<dynamic>?)
          ?.map((e) => TranscodingUser.fromJson(e as Map<String, dynamic>))
          .toList(),
      transcodingExtraInfo: json['transcodingExtraInfo'] as String?,
      metadata: json['metadata'] as String?,
      watermark: (json['watermark'] as List<dynamic>?)
          ?.map((e) => RtcImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      watermarkCount: (json['watermarkCount'] as num?)?.toInt(),
      backgroundImage: (json['backgroundImage'] as List<dynamic>?)
          ?.map((e) => RtcImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      backgroundImageCount: (json['backgroundImageCount'] as num?)?.toInt(),
      audioSampleRate: $enumDecodeNullable(
          _$AudioSampleRateTypeEnumMap, json['audioSampleRate']),
      audioBitrate: (json['audioBitrate'] as num?)?.toInt(),
      audioChannels: (json['audioChannels'] as num?)?.toInt(),
      audioCodecProfile: $enumDecodeNullable(
          _$AudioCodecProfileTypeEnumMap, json['audioCodecProfile']),
      advancedFeatures: (json['advancedFeatures'] as List<dynamic>?)
          ?.map((e) =>
              LiveStreamAdvancedFeature.fromJson(e as Map<String, dynamic>))
          .toList(),
      advancedFeatureCount: (json['advancedFeatureCount'] as num?)?.toInt(),
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
          $enumDecodeNullable(_$VideoSourceTypeEnumMap, json['sourceType']),
      remoteUserUid: (json['remoteUserUid'] as num?)?.toInt(),
      imageUrl: json['imageUrl'] as String?,
      mediaPlayerId: (json['mediaPlayerId'] as num?)?.toInt(),
      x: (json['x'] as num?)?.toInt(),
      y: (json['y'] as num?)?.toInt(),
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      zOrder: (json['zOrder'] as num?)?.toInt(),
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

  writeNotNull('sourceType', _$VideoSourceTypeEnumMap[instance.sourceType]);
  writeNotNull('remoteUserUid', instance.remoteUserUid);
  writeNotNull('imageUrl', instance.imageUrl);
  writeNotNull('mediaPlayerId', instance.mediaPlayerId);
  writeNotNull('x', instance.x);
  writeNotNull('y', instance.y);
  writeNotNull('width', instance.width);
  writeNotNull('height', instance.height);
  writeNotNull('zOrder', instance.zOrder);
  writeNotNull('alpha', instance.alpha);
  writeNotNull('mirror', instance.mirror);
  return val;
}

LocalTranscoderConfiguration _$LocalTranscoderConfigurationFromJson(
        Map<String, dynamic> json) =>
    LocalTranscoderConfiguration(
      streamCount: (json['streamCount'] as num?)?.toInt(),
      videoInputStreams: (json['videoInputStreams'] as List<dynamic>?)
          ?.map(
              (e) => TranscodingVideoStream.fromJson(e as Map<String, dynamic>))
          .toList(),
      videoOutputConfiguration: json['videoOutputConfiguration'] == null
          ? null
          : VideoEncoderConfiguration.fromJson(
              json['videoOutputConfiguration'] as Map<String, dynamic>),
      syncWithPrimaryCamera: json['syncWithPrimaryCamera'] as bool?,
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
  writeNotNull('videoInputStreams',
      instance.videoInputStreams?.map((e) => e.toJson()).toList());
  writeNotNull(
      'videoOutputConfiguration', instance.videoOutputConfiguration?.toJson());
  writeNotNull('syncWithPrimaryCamera', instance.syncWithPrimaryCamera);
  return val;
}

LastmileProbeConfig _$LastmileProbeConfigFromJson(Map<String, dynamic> json) =>
    LastmileProbeConfig(
      probeUplink: json['probeUplink'] as bool?,
      probeDownlink: json['probeDownlink'] as bool?,
      expectedUplinkBitrate: (json['expectedUplinkBitrate'] as num?)?.toInt(),
      expectedDownlinkBitrate:
          (json['expectedDownlinkBitrate'] as num?)?.toInt(),
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
      packetLossRate: (json['packetLossRate'] as num?)?.toInt(),
      jitter: (json['jitter'] as num?)?.toInt(),
      availableBandwidth: (json['availableBandwidth'] as num?)?.toInt(),
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
      rtt: (json['rtt'] as num?)?.toInt(),
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
      e2eDelayPercent: (json['e2eDelayPercent'] as num?)?.toInt(),
      frozenRatioPercent: (json['frozenRatioPercent'] as num?)?.toInt(),
      lossRatePercent: (json['lossRatePercent'] as num?)?.toInt(),
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
      uid: (json['uid'] as num?)?.toInt(),
      subviewUid: (json['subviewUid'] as num?)?.toInt(),
      view: (json['view'] as num?)?.toInt(),
      backgroundColor: (json['backgroundColor'] as num?)?.toInt(),
      renderMode:
          $enumDecodeNullable(_$RenderModeTypeEnumMap, json['renderMode']),
      mirrorMode:
          $enumDecodeNullable(_$VideoMirrorModeTypeEnumMap, json['mirrorMode']),
      setupMode:
          $enumDecodeNullable(_$VideoViewSetupModeEnumMap, json['setupMode']),
      sourceType:
          $enumDecodeNullable(_$VideoSourceTypeEnumMap, json['sourceType']),
      mediaPlayerId: (json['mediaPlayerId'] as num?)?.toInt(),
      cropArea: json['cropArea'] == null
          ? null
          : Rectangle.fromJson(json['cropArea'] as Map<String, dynamic>),
      enableAlphaMask: json['enableAlphaMask'] as bool?,
      position:
          $enumDecodeNullable(_$VideoModulePositionEnumMap, json['position']),
    );

Map<String, dynamic> _$VideoCanvasToJson(VideoCanvas instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uid', instance.uid);
  writeNotNull('subviewUid', instance.subviewUid);
  writeNotNull('view', instance.view);
  writeNotNull('backgroundColor', instance.backgroundColor);
  writeNotNull('renderMode', _$RenderModeTypeEnumMap[instance.renderMode]);
  writeNotNull('mirrorMode', _$VideoMirrorModeTypeEnumMap[instance.mirrorMode]);
  writeNotNull('setupMode', _$VideoViewSetupModeEnumMap[instance.setupMode]);
  writeNotNull('sourceType', _$VideoSourceTypeEnumMap[instance.sourceType]);
  writeNotNull('mediaPlayerId', instance.mediaPlayerId);
  writeNotNull('cropArea', instance.cropArea?.toJson());
  writeNotNull('enableAlphaMask', instance.enableAlphaMask);
  writeNotNull('position', _$VideoModulePositionEnumMap[instance.position]);
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

const _$VideoModulePositionEnumMap = {
  VideoModulePosition.positionPostCapturer: 1,
  VideoModulePosition.positionPreRenderer: 2,
  VideoModulePosition.positionPreEncoder: 4,
  VideoModulePosition.positionPostCapturerOrigin: 8,
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
      color: (json['color'] as num?)?.toInt(),
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
  BackgroundSourceType.backgroundNone: 0,
  BackgroundSourceType.backgroundColor: 1,
  BackgroundSourceType.backgroundImg: 2,
  BackgroundSourceType.backgroundBlur: 3,
  BackgroundSourceType.backgroundVideo: 4,
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

AudioTrackConfig _$AudioTrackConfigFromJson(Map<String, dynamic> json) =>
    AudioTrackConfig(
      enableLocalPlayback: json['enableLocalPlayback'] as bool?,
    );

Map<String, dynamic> _$AudioTrackConfigToJson(AudioTrackConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('enableLocalPlayback', instance.enableLocalPlayback);
  return val;
}

ScreenCaptureParameters _$ScreenCaptureParametersFromJson(
        Map<String, dynamic> json) =>
    ScreenCaptureParameters(
      dimensions: json['dimensions'] == null
          ? null
          : VideoDimensions.fromJson(
              json['dimensions'] as Map<String, dynamic>),
      frameRate: (json['frameRate'] as num?)?.toInt(),
      bitrate: (json['bitrate'] as num?)?.toInt(),
      captureMouseCursor: json['captureMouseCursor'] as bool?,
      windowFocus: json['windowFocus'] as bool?,
      excludeWindowList: (json['excludeWindowList'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      excludeWindowCount: (json['excludeWindowCount'] as num?)?.toInt(),
      highLightWidth: (json['highLightWidth'] as num?)?.toInt(),
      highLightColor: (json['highLightColor'] as num?)?.toInt(),
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
      sampleRate: (json['sampleRate'] as num?)?.toInt(),
      fileRecordingType: $enumDecodeNullable(
          _$AudioFileRecordingTypeEnumMap, json['fileRecordingType']),
      quality: $enumDecodeNullable(
          _$AudioRecordingQualityTypeEnumMap, json['quality']),
      recordingChannel: (json['recordingChannel'] as num?)?.toInt(),
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
      uid: (json['uid'] as num?)?.toInt(),
      channelName: json['channelName'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$ChannelMediaInfoToJson(ChannelMediaInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uid', instance.uid);
  writeNotNull('channelName', instance.channelName);
  writeNotNull('token', instance.token);
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
      destCount: (json['destCount'] as num?)?.toInt(),
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
          (json['video_encoder_target_bitrate_bps'] as num?)?.toInt(),
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
      lastmileBufferDelayTimeMs:
          (json['lastmile_buffer_delay_time_ms'] as num?)?.toInt(),
      bandwidthEstimationBps:
          (json['bandwidth_estimation_bps'] as num?)?.toInt(),
      totalDownscaleLevelCount:
          (json['total_downscale_level_count'] as num?)?.toInt(),
      peerDownlinkInfo: (json['peer_downlink_info'] as List<dynamic>?)
          ?.map((e) => PeerDownlinkInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalReceivedVideoCount:
          (json['total_received_video_count'] as num?)?.toInt(),
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
      userId: json['userId'] as String?,
      streamType:
          $enumDecodeNullable(_$VideoStreamTypeEnumMap, json['stream_type']),
      currentDownscaleLevel: $enumDecodeNullable(
          _$RemoteVideoDownscaleLevelEnumMap, json['current_downscale_level']),
      expectedBitrateBps: (json['expected_bitrate_bps'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PeerDownlinkInfoToJson(PeerDownlinkInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('userId', instance.userId);
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
      datastreamEncryptionEnabled: json['datastreamEncryptionEnabled'] as bool?,
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
  writeNotNull(
      'datastreamEncryptionEnabled', instance.datastreamEncryptionEnabled);
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
      view: (json['view'] as num?)?.toInt(),
      enableAudio: json['enableAudio'] as bool?,
      enableVideo: json['enableVideo'] as bool?,
      token: json['token'] as String?,
      channelId: json['channelId'] as String?,
      intervalInSeconds: (json['intervalInSeconds'] as num?)?.toInt(),
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
  writeNotNull('intervalInSeconds', instance.intervalInSeconds);
  return val;
}

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      uid: (json['uid'] as num?)?.toInt(),
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
      frameRate: (json['frameRate'] as num?)?.toInt(),
      bitrate: (json['bitrate'] as num?)?.toInt(),
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
      sampleRate: (json['sampleRate'] as num?)?.toInt(),
      channels: (json['channels'] as num?)?.toInt(),
      captureSignalVolume: (json['captureSignalVolume'] as num?)?.toInt(),
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

VideoRenderingTracingInfo _$VideoRenderingTracingInfoFromJson(
        Map<String, dynamic> json) =>
    VideoRenderingTracingInfo(
      elapsedTime: (json['elapsedTime'] as num?)?.toInt(),
      start2JoinChannel: (json['start2JoinChannel'] as num?)?.toInt(),
      join2JoinSuccess: (json['join2JoinSuccess'] as num?)?.toInt(),
      joinSuccess2RemoteJoined:
          (json['joinSuccess2RemoteJoined'] as num?)?.toInt(),
      remoteJoined2SetView: (json['remoteJoined2SetView'] as num?)?.toInt(),
      remoteJoined2UnmuteVideo:
          (json['remoteJoined2UnmuteVideo'] as num?)?.toInt(),
      remoteJoined2PacketReceived:
          (json['remoteJoined2PacketReceived'] as num?)?.toInt(),
    );

Map<String, dynamic> _$VideoRenderingTracingInfoToJson(
    VideoRenderingTracingInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('elapsedTime', instance.elapsedTime);
  writeNotNull('start2JoinChannel', instance.start2JoinChannel);
  writeNotNull('join2JoinSuccess', instance.join2JoinSuccess);
  writeNotNull('joinSuccess2RemoteJoined', instance.joinSuccess2RemoteJoined);
  writeNotNull('remoteJoined2SetView', instance.remoteJoined2SetView);
  writeNotNull('remoteJoined2UnmuteVideo', instance.remoteJoined2UnmuteVideo);
  writeNotNull(
      'remoteJoined2PacketReceived', instance.remoteJoined2PacketReceived);
  return val;
}

LogUploadServerInfo _$LogUploadServerInfoFromJson(Map<String, dynamic> json) =>
    LogUploadServerInfo(
      serverDomain: json['serverDomain'] as String?,
      serverPath: json['serverPath'] as String?,
      serverPort: (json['serverPort'] as num?)?.toInt(),
      serverHttps: json['serverHttps'] as bool?,
    );

Map<String, dynamic> _$LogUploadServerInfoToJson(LogUploadServerInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('serverDomain', instance.serverDomain);
  writeNotNull('serverPath', instance.serverPath);
  writeNotNull('serverPort', instance.serverPort);
  writeNotNull('serverHttps', instance.serverHttps);
  return val;
}

AdvancedConfigInfo _$AdvancedConfigInfoFromJson(Map<String, dynamic> json) =>
    AdvancedConfigInfo(
      logUploadServer: json['logUploadServer'] == null
          ? null
          : LogUploadServerInfo.fromJson(
              json['logUploadServer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdvancedConfigInfoToJson(AdvancedConfigInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('logUploadServer', instance.logUploadServer?.toJson());
  return val;
}

LocalAccessPointConfiguration _$LocalAccessPointConfigurationFromJson(
        Map<String, dynamic> json) =>
    LocalAccessPointConfiguration(
      ipList:
          (json['ipList'] as List<dynamic>?)?.map((e) => e as String).toList(),
      ipListSize: (json['ipListSize'] as num?)?.toInt(),
      domainList: (json['domainList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      domainListSize: (json['domainListSize'] as num?)?.toInt(),
      verifyDomainName: json['verifyDomainName'] as String?,
      mode: $enumDecodeNullable(_$LocalProxyModeEnumMap, json['mode']),
      advancedConfig: json['advancedConfig'] == null
          ? null
          : AdvancedConfigInfo.fromJson(
              json['advancedConfig'] as Map<String, dynamic>),
      disableAut: json['disableAut'] as bool?,
    );

Map<String, dynamic> _$LocalAccessPointConfigurationToJson(
    LocalAccessPointConfiguration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ipList', instance.ipList);
  writeNotNull('ipListSize', instance.ipListSize);
  writeNotNull('domainList', instance.domainList);
  writeNotNull('domainListSize', instance.domainListSize);
  writeNotNull('verifyDomainName', instance.verifyDomainName);
  writeNotNull('mode', _$LocalProxyModeEnumMap[instance.mode]);
  writeNotNull('advancedConfig', instance.advancedConfig?.toJson());
  writeNotNull('disableAut', instance.disableAut);
  return val;
}

const _$LocalProxyModeEnumMap = {
  LocalProxyMode.connectivityFirst: 0,
  LocalProxyMode.localOnly: 1,
};

RecorderStreamInfo _$RecorderStreamInfoFromJson(Map<String, dynamic> json) =>
    RecorderStreamInfo(
      channelId: json['channelId'] as String?,
      uid: (json['uid'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RecorderStreamInfoToJson(RecorderStreamInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('channelId', instance.channelId);
  writeNotNull('uid', instance.uid);
  return val;
}

SpatialAudioParams _$SpatialAudioParamsFromJson(Map<String, dynamic> json) =>
    SpatialAudioParams(
      speakerAzimuth: (json['speaker_azimuth'] as num?)?.toDouble(),
      speakerElevation: (json['speaker_elevation'] as num?)?.toDouble(),
      speakerDistance: (json['speaker_distance'] as num?)?.toDouble(),
      speakerOrientation: (json['speaker_orientation'] as num?)?.toInt(),
      enableBlur: json['enable_blur'] as bool?,
      enableAirAbsorb: json['enable_air_absorb'] as bool?,
      speakerAttenuation: (json['speaker_attenuation'] as num?)?.toDouble(),
      enableDoppler: json['enable_doppler'] as bool?,
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
  writeNotNull('enable_doppler', instance.enableDoppler);
  return val;
}

VideoLayout _$VideoLayoutFromJson(Map<String, dynamic> json) => VideoLayout(
      channelId: json['channelId'] as String?,
      uid: (json['uid'] as num?)?.toInt(),
      strUid: json['strUid'] as String?,
      x: (json['x'] as num?)?.toInt(),
      y: (json['y'] as num?)?.toInt(),
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      videoState: (json['videoState'] as num?)?.toInt(),
    );

Map<String, dynamic> _$VideoLayoutToJson(VideoLayout instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('channelId', instance.channelId);
  writeNotNull('uid', instance.uid);
  writeNotNull('strUid', instance.strUid);
  writeNotNull('x', instance.x);
  writeNotNull('y', instance.y);
  writeNotNull('width', instance.width);
  writeNotNull('height', instance.height);
  writeNotNull('videoState', instance.videoState);
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
  ErrorCodeType.errDatastreamDecryptionFailed: 122,
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

const _$LicenseErrorTypeEnumMap = {
  LicenseErrorType.licenseErrInvalid: 1,
  LicenseErrorType.licenseErrExpire: 2,
  LicenseErrorType.licenseErrMinutesExceed: 3,
  LicenseErrorType.licenseErrLimitedPeriod: 4,
  LicenseErrorType.licenseErrDiffDevices: 5,
  LicenseErrorType.licenseErrInternal: 99,
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
  InterfaceIdType.agoraIidLocalSpatialAudio: 11,
  InterfaceIdType.agoraIidStateSync: 13,
  InterfaceIdType.agoraIidMetaService: 14,
  InterfaceIdType.agoraIidMusicContentCenter: 15,
  InterfaceIdType.agoraIidH265Transcoder: 16,
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
  FrameWidth.frameWidth960: 960,
};

const _$FrameHeightEnumMap = {
  FrameHeight.frameHeight540: 540,
};

const _$ScreenCaptureFramerateCapabilityEnumMap = {
  ScreenCaptureFramerateCapability.screenCaptureFramerateCapability15Fps: 0,
  ScreenCaptureFramerateCapability.screenCaptureFramerateCapability30Fps: 1,
  ScreenCaptureFramerateCapability.screenCaptureFramerateCapability60Fps: 2,
};

const _$H264PacketizeModeEnumMap = {
  H264PacketizeMode.nonInterleaved: 0,
  H264PacketizeMode.singleNalUnit: 1,
};

const _$MaxUserAccountLengthTypeEnumMap = {
  MaxUserAccountLengthType.maxUserAccountLength: 256,
};

const _$CodecCapMaskEnumMap = {
  CodecCapMask.codecCapMaskNone: 0,
  CodecCapMask.codecCapMaskHwDec: 1,
  CodecCapMask.codecCapMaskHwEnc: 2,
  CodecCapMask.codecCapMaskSwDec: 4,
  CodecCapMask.codecCapMaskSwEnc: 8,
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

const _$AudioAinsModeEnumMap = {
  AudioAinsMode.ainsModeBalanced: 0,
  AudioAinsMode.ainsModeAggressive: 1,
  AudioAinsMode.ainsModeUltralowlatency: 2,
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

const _$VideoApplicationScenarioTypeEnumMap = {
  VideoApplicationScenarioType.applicationScenarioGeneral: 0,
  VideoApplicationScenarioType.applicationScenarioMeeting: 1,
};

const _$VideoQoePreferenceTypeEnumMap = {
  VideoQoePreferenceType.videoQoePreferenceBalance: 1,
  VideoQoePreferenceType.videoQoePreferenceDelayFirst: 2,
  VideoQoePreferenceType.videoQoePreferencePictureQualityFirst: 3,
  VideoQoePreferenceType.videoQoePreferenceFluencyFirst: 4,
};

const _$CaptureBrightnessLevelTypeEnumMap = {
  CaptureBrightnessLevelType.captureBrightnessLevelInvalid: -1,
  CaptureBrightnessLevelType.captureBrightnessLevelNormal: 0,
  CaptureBrightnessLevelType.captureBrightnessLevelBright: 1,
  CaptureBrightnessLevelType.captureBrightnessLevelDark: 2,
};

const _$CameraStabilizationModeEnumMap = {
  CameraStabilizationMode.cameraStabilizationModeOff: -1,
  CameraStabilizationMode.cameraStabilizationModeAuto: 0,
  CameraStabilizationMode.cameraStabilizationModeLevel1: 1,
  CameraStabilizationMode.cameraStabilizationModeLevel2: 2,
  CameraStabilizationMode.cameraStabilizationModeLevel3: 3,
  CameraStabilizationMode.cameraStabilizationModeMaxLevel: 3,
};

const _$LocalAudioStreamStateEnumMap = {
  LocalAudioStreamState.localAudioStreamStateStopped: 0,
  LocalAudioStreamState.localAudioStreamStateRecording: 1,
  LocalAudioStreamState.localAudioStreamStateEncoding: 2,
  LocalAudioStreamState.localAudioStreamStateFailed: 3,
};

const _$LocalAudioStreamReasonEnumMap = {
  LocalAudioStreamReason.localAudioStreamReasonOk: 0,
  LocalAudioStreamReason.localAudioStreamReasonFailure: 1,
  LocalAudioStreamReason.localAudioStreamReasonDeviceNoPermission: 2,
  LocalAudioStreamReason.localAudioStreamReasonDeviceBusy: 3,
  LocalAudioStreamReason.localAudioStreamReasonRecordFailure: 4,
  LocalAudioStreamReason.localAudioStreamReasonEncodeFailure: 5,
  LocalAudioStreamReason.localAudioStreamReasonNoRecordingDevice: 6,
  LocalAudioStreamReason.localAudioStreamReasonNoPlayoutDevice: 7,
  LocalAudioStreamReason.localAudioStreamReasonInterrupted: 8,
  LocalAudioStreamReason.localAudioStreamReasonRecordInvalidId: 9,
  LocalAudioStreamReason.localAudioStreamReasonPlayoutInvalidId: 10,
};

const _$LocalVideoStreamStateEnumMap = {
  LocalVideoStreamState.localVideoStreamStateStopped: 0,
  LocalVideoStreamState.localVideoStreamStateCapturing: 1,
  LocalVideoStreamState.localVideoStreamStateEncoding: 2,
  LocalVideoStreamState.localVideoStreamStateFailed: 3,
};

const _$LocalVideoStreamReasonEnumMap = {
  LocalVideoStreamReason.localVideoStreamReasonOk: 0,
  LocalVideoStreamReason.localVideoStreamReasonFailure: 1,
  LocalVideoStreamReason.localVideoStreamReasonDeviceNoPermission: 2,
  LocalVideoStreamReason.localVideoStreamReasonDeviceBusy: 3,
  LocalVideoStreamReason.localVideoStreamReasonCaptureFailure: 4,
  LocalVideoStreamReason.localVideoStreamReasonCodecNotSupport: 5,
  LocalVideoStreamReason.localVideoStreamReasonCaptureInbackground: 6,
  LocalVideoStreamReason.localVideoStreamReasonCaptureMultipleForegroundApps: 7,
  LocalVideoStreamReason.localVideoStreamReasonDeviceNotFound: 8,
  LocalVideoStreamReason.localVideoStreamReasonDeviceDisconnected: 9,
  LocalVideoStreamReason.localVideoStreamReasonDeviceInvalidId: 10,
  LocalVideoStreamReason.localVideoStreamReasonDeviceInterrupt: 14,
  LocalVideoStreamReason.localVideoStreamReasonDeviceFatalError: 15,
  LocalVideoStreamReason.localVideoStreamReasonDeviceSystemPressure: 101,
  LocalVideoStreamReason.localVideoStreamReasonScreenCaptureWindowMinimized: 11,
  LocalVideoStreamReason.localVideoStreamReasonScreenCaptureWindowClosed: 12,
  LocalVideoStreamReason.localVideoStreamReasonScreenCaptureWindowOccluded: 13,
  LocalVideoStreamReason.localVideoStreamReasonScreenCaptureWindowNotSupported:
      20,
  LocalVideoStreamReason.localVideoStreamReasonScreenCaptureFailure: 21,
  LocalVideoStreamReason.localVideoStreamReasonScreenCaptureNoPermission: 22,
  LocalVideoStreamReason.localVideoStreamReasonScreenCaptureAutoFallback: 24,
  LocalVideoStreamReason.localVideoStreamReasonScreenCaptureWindowHidden: 25,
  LocalVideoStreamReason
      .localVideoStreamReasonScreenCaptureWindowRecoverFromHidden: 26,
  LocalVideoStreamReason
      .localVideoStreamReasonScreenCaptureWindowRecoverFromMinimized: 27,
  LocalVideoStreamReason.localVideoStreamReasonScreenCapturePaused: 28,
  LocalVideoStreamReason.localVideoStreamReasonScreenCaptureResumed: 29,
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
  RemoteAudioStateReason.remoteAudioReasonNoPacketReceive: 8,
  RemoteAudioStateReason.remoteAudioReasonLocalPlayFailed: 9,
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
  RemoteVideoStateReason.remoteVideoStateReasonCodecNotSupport: 13,
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

const _$RtmpStreamPublishReasonEnumMap = {
  RtmpStreamPublishReason.rtmpStreamPublishReasonOk: 0,
  RtmpStreamPublishReason.rtmpStreamPublishReasonInvalidArgument: 1,
  RtmpStreamPublishReason.rtmpStreamPublishReasonEncryptedStreamNotAllowed: 2,
  RtmpStreamPublishReason.rtmpStreamPublishReasonConnectionTimeout: 3,
  RtmpStreamPublishReason.rtmpStreamPublishReasonInternalServerError: 4,
  RtmpStreamPublishReason.rtmpStreamPublishReasonRtmpServerError: 5,
  RtmpStreamPublishReason.rtmpStreamPublishReasonTooOften: 6,
  RtmpStreamPublishReason.rtmpStreamPublishReasonReachLimit: 7,
  RtmpStreamPublishReason.rtmpStreamPublishReasonNotAuthorized: 8,
  RtmpStreamPublishReason.rtmpStreamPublishReasonStreamNotFound: 9,
  RtmpStreamPublishReason.rtmpStreamPublishReasonFormatNotSupported: 10,
  RtmpStreamPublishReason.rtmpStreamPublishReasonNotBroadcaster: 11,
  RtmpStreamPublishReason.rtmpStreamPublishReasonTranscodingNoMixStream: 13,
  RtmpStreamPublishReason.rtmpStreamPublishReasonNetDown: 14,
  RtmpStreamPublishReason.rtmpStreamPublishReasonInvalidAppid: 15,
  RtmpStreamPublishReason.rtmpStreamPublishReasonInvalidPrivilege: 16,
  RtmpStreamPublishReason.rtmpStreamUnpublishReasonOk: 100,
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

const _$VideoTranscoderErrorEnumMap = {
  VideoTranscoderError.vtErrVideoSourceNotReady: 1,
  VideoTranscoderError.vtErrInvalidVideoSourceType: 2,
  VideoTranscoderError.vtErrInvalidImagePath: 3,
  VideoTranscoderError.vtErrUnsupportImageFormat: 4,
  VideoTranscoderError.vtErrInvalidLayout: 5,
  VideoTranscoderError.vtErrInternal: 20,
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
  ConnectionChangedReasonType.connectionChangedLicenseValidationFailure: 21,
  ConnectionChangedReasonType.connectionChangedCertificationVeryfyFailure: 22,
  ConnectionChangedReasonType.connectionChangedStreamChannelNotAvailable: 23,
  ConnectionChangedReasonType.connectionChangedInconsistentAppid: 24,
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
  NetworkType.networkTypeMobile5g: 6,
};

const _$AudioTrackTypeEnumMap = {
  AudioTrackType.audioTrackInvalid: -1,
  AudioTrackType.audioTrackMixable: 0,
  AudioTrackType.audioTrackDirect: 1,
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
  AudioEffectPreset.roomAcousticsChorus: 33623296,
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
  VoiceConversionPreset.voiceChangerCartoon: 50398464,
  VoiceConversionPreset.voiceChangerChildlike: 50398720,
  VoiceConversionPreset.voiceChangerPhoneOperator: 50398976,
  VoiceConversionPreset.voiceChangerMonster: 50399232,
  VoiceConversionPreset.voiceChangerTransformers: 50399488,
  VoiceConversionPreset.voiceChangerGroot: 50399744,
  VoiceConversionPreset.voiceChangerDarthVader: 50400000,
  VoiceConversionPreset.voiceChangerIronLady: 50400256,
  VoiceConversionPreset.voiceChangerShinChan: 50400512,
  VoiceConversionPreset.voiceChangerGirlishMan: 50400768,
  VoiceConversionPreset.voiceChangerChipmunk: 50401024,
};

const _$HeadphoneEqualizerPresetEnumMap = {
  HeadphoneEqualizerPreset.headphoneEqualizerOff: 0,
  HeadphoneEqualizerPreset.headphoneEqualizerOverear: 67108865,
  HeadphoneEqualizerPreset.headphoneEqualizerInear: 67108866,
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
  EncryptionErrorType.encryptionErrorDatastreamDecryptionFailure: 3,
  EncryptionErrorType.encryptionErrorDatastreamEncryptionFailure: 4,
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
  EarMonitoringFilterType.earMonitoringFilterReusePostProcessingFilter: 32768,
};

const _$ThreadPriorityTypeEnumMap = {
  ThreadPriorityType.lowest: 0,
  ThreadPriorityType.low: 1,
  ThreadPriorityType.normal: 2,
  ThreadPriorityType.high: 3,
  ThreadPriorityType.highest: 4,
  ThreadPriorityType.critical: 5,
};

const _$MediaTraceEventEnumMap = {
  MediaTraceEvent.mediaTraceEventVideoRendered: 0,
  MediaTraceEvent.mediaTraceEventVideoDecoded: 1,
};

const _$ConfigFetchTypeEnumMap = {
  ConfigFetchType.configFetchTypeInitialize: 1,
  ConfigFetchType.configFetchTypeJoinChannel: 2,
};
