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

Map<String, dynamic> _$VideoDimensionsToJson(VideoDimensions instance) =>
    <String, dynamic>{
      if (instance.width case final value?) 'width': value,
      if (instance.height case final value?) 'height': value,
    };

SenderOptions _$SenderOptionsFromJson(Map<String, dynamic> json) =>
    SenderOptions(
      ccMode: $enumDecodeNullable(_$TCcModeEnumMap, json['ccMode']),
      codecType:
          $enumDecodeNullable(_$VideoCodecTypeEnumMap, json['codecType']),
      targetBitrate: (json['targetBitrate'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SenderOptionsToJson(SenderOptions instance) =>
    <String, dynamic>{
      if (_$TCcModeEnumMap[instance.ccMode] case final value?) 'ccMode': value,
      if (_$VideoCodecTypeEnumMap[instance.codecType] case final value?)
        'codecType': value,
      if (instance.targetBitrate case final value?) 'targetBitrate': value,
    };

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
        EncodedAudioFrameAdvancedSettings instance) =>
    <String, dynamic>{
      if (instance.speech case final value?) 'speech': value,
      if (instance.sendEvenIfEmpty case final value?) 'sendEvenIfEmpty': value,
    };

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
        EncodedAudioFrameInfo instance) =>
    <String, dynamic>{
      if (_$AudioCodecTypeEnumMap[instance.codec] case final value?)
        'codec': value,
      if (instance.sampleRateHz case final value?) 'sampleRateHz': value,
      if (instance.samplesPerChannel case final value?)
        'samplesPerChannel': value,
      if (instance.numberOfChannels case final value?)
        'numberOfChannels': value,
      if (instance.advancedSettings?.toJson() case final value?)
        'advancedSettings': value,
      if (instance.captureTimeMs case final value?) 'captureTimeMs': value,
    };

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

Map<String, dynamic> _$AudioPcmDataInfoToJson(AudioPcmDataInfo instance) =>
    <String, dynamic>{
      if (instance.samplesPerChannel case final value?)
        'samplesPerChannel': value,
      if (instance.channelNum case final value?) 'channelNum': value,
      if (instance.samplesOut case final value?) 'samplesOut': value,
      if (instance.elapsedTimeMs case final value?) 'elapsedTimeMs': value,
      if (instance.ntpTimeMs case final value?) 'ntpTimeMs': value,
    };

VideoSubscriptionOptions _$VideoSubscriptionOptionsFromJson(
        Map<String, dynamic> json) =>
    VideoSubscriptionOptions(
      type: $enumDecodeNullable(_$VideoStreamTypeEnumMap, json['type']),
      encodedFrameOnly: json['encodedFrameOnly'] as bool?,
    );

Map<String, dynamic> _$VideoSubscriptionOptionsToJson(
        VideoSubscriptionOptions instance) =>
    <String, dynamic>{
      if (_$VideoStreamTypeEnumMap[instance.type] case final value?)
        'type': value,
      if (instance.encodedFrameOnly case final value?)
        'encodedFrameOnly': value,
    };

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
        EncodedVideoFrameInfo instance) =>
    <String, dynamic>{
      if (instance.uid case final value?) 'uid': value,
      if (_$VideoCodecTypeEnumMap[instance.codecType] case final value?)
        'codecType': value,
      if (instance.width case final value?) 'width': value,
      if (instance.height case final value?) 'height': value,
      if (instance.framesPerSecond case final value?) 'framesPerSecond': value,
      if (_$VideoFrameTypeEnumMap[instance.frameType] case final value?)
        'frameType': value,
      if (_$VideoOrientationEnumMap[instance.rotation] case final value?)
        'rotation': value,
      if (instance.trackId case final value?) 'trackId': value,
      if (instance.captureTimeMs case final value?) 'captureTimeMs': value,
      if (instance.decodeTimeMs case final value?) 'decodeTimeMs': value,
      if (_$VideoStreamTypeEnumMap[instance.streamType] case final value?)
        'streamType': value,
      if (instance.presentationMs case final value?) 'presentationMs': value,
    };

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

Map<String, dynamic> _$AdvanceOptionsToJson(AdvanceOptions instance) =>
    <String, dynamic>{
      if (_$EncodingPreferenceEnumMap[instance.encodingPreference]
          case final value?)
        'encodingPreference': value,
      if (_$CompressionPreferenceEnumMap[instance.compressionPreference]
          case final value?)
        'compressionPreference': value,
    };

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

Map<String, dynamic> _$CodecCapLevelsToJson(CodecCapLevels instance) =>
    <String, dynamic>{
      if (_$VideoCodecCapabilityLevelEnumMap[instance.hwDecodingLevel]
          case final value?)
        'hwDecodingLevel': value,
      if (_$VideoCodecCapabilityLevelEnumMap[instance.swDecodingLevel]
          case final value?)
        'swDecodingLevel': value,
    };

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

Map<String, dynamic> _$CodecCapInfoToJson(CodecCapInfo instance) =>
    <String, dynamic>{
      if (_$VideoCodecTypeEnumMap[instance.codecType] case final value?)
        'codecType': value,
      if (instance.codecCapMask case final value?) 'codecCapMask': value,
      if (instance.codecLevels?.toJson() case final value?)
        'codecLevels': value,
    };

FocalLengthInfo _$FocalLengthInfoFromJson(Map<String, dynamic> json) =>
    FocalLengthInfo(
      cameraDirection: (json['cameraDirection'] as num?)?.toInt(),
      focalLengthType: $enumDecodeNullable(
          _$CameraFocalLengthTypeEnumMap, json['focalLengthType']),
    );

Map<String, dynamic> _$FocalLengthInfoToJson(FocalLengthInfo instance) =>
    <String, dynamic>{
      if (instance.cameraDirection case final value?) 'cameraDirection': value,
      if (_$CameraFocalLengthTypeEnumMap[instance.focalLengthType]
          case final value?)
        'focalLengthType': value,
    };

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
        VideoEncoderConfiguration instance) =>
    <String, dynamic>{
      if (_$VideoCodecTypeEnumMap[instance.codecType] case final value?)
        'codecType': value,
      if (instance.dimensions?.toJson() case final value?) 'dimensions': value,
      if (instance.frameRate case final value?) 'frameRate': value,
      if (instance.bitrate case final value?) 'bitrate': value,
      if (instance.minBitrate case final value?) 'minBitrate': value,
      if (_$OrientationModeEnumMap[instance.orientationMode] case final value?)
        'orientationMode': value,
      if (_$DegradationPreferenceEnumMap[instance.degradationPreference]
          case final value?)
        'degradationPreference': value,
      if (_$VideoMirrorModeTypeEnumMap[instance.mirrorMode] case final value?)
        'mirrorMode': value,
      if (instance.advanceOptions?.toJson() case final value?)
        'advanceOptions': value,
    };

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

Map<String, dynamic> _$DataStreamConfigToJson(DataStreamConfig instance) =>
    <String, dynamic>{
      if (instance.syncWithAudio case final value?) 'syncWithAudio': value,
      if (instance.ordered case final value?) 'ordered': value,
    };

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
        SimulcastStreamConfig instance) =>
    <String, dynamic>{
      if (instance.dimensions?.toJson() case final value?) 'dimensions': value,
      if (instance.kBitrate case final value?) 'kBitrate': value,
      if (instance.framerate case final value?) 'framerate': value,
    };

Rectangle _$RectangleFromJson(Map<String, dynamic> json) => Rectangle(
      x: (json['x'] as num?)?.toInt(),
      y: (json['y'] as num?)?.toInt(),
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RectangleToJson(Rectangle instance) => <String, dynamic>{
      if (instance.x case final value?) 'x': value,
      if (instance.y case final value?) 'y': value,
      if (instance.width case final value?) 'width': value,
      if (instance.height case final value?) 'height': value,
    };

WatermarkRatio _$WatermarkRatioFromJson(Map<String, dynamic> json) =>
    WatermarkRatio(
      xRatio: (json['xRatio'] as num?)?.toDouble(),
      yRatio: (json['yRatio'] as num?)?.toDouble(),
      widthRatio: (json['widthRatio'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WatermarkRatioToJson(WatermarkRatio instance) =>
    <String, dynamic>{
      if (instance.xRatio case final value?) 'xRatio': value,
      if (instance.yRatio case final value?) 'yRatio': value,
      if (instance.widthRatio case final value?) 'widthRatio': value,
    };

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

Map<String, dynamic> _$WatermarkOptionsToJson(WatermarkOptions instance) =>
    <String, dynamic>{
      if (instance.visibleInPreview case final value?)
        'visibleInPreview': value,
      if (instance.positionInLandscapeMode?.toJson() case final value?)
        'positionInLandscapeMode': value,
      if (instance.positionInPortraitMode?.toJson() case final value?)
        'positionInPortraitMode': value,
      if (instance.watermarkRatio?.toJson() case final value?)
        'watermarkRatio': value,
      if (_$WatermarkFitModeEnumMap[instance.mode] case final value?)
        'mode': value,
    };

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

Map<String, dynamic> _$RtcStatsToJson(RtcStats instance) => <String, dynamic>{
      if (instance.duration case final value?) 'duration': value,
      if (instance.txBytes case final value?) 'txBytes': value,
      if (instance.rxBytes case final value?) 'rxBytes': value,
      if (instance.txAudioBytes case final value?) 'txAudioBytes': value,
      if (instance.txVideoBytes case final value?) 'txVideoBytes': value,
      if (instance.rxAudioBytes case final value?) 'rxAudioBytes': value,
      if (instance.rxVideoBytes case final value?) 'rxVideoBytes': value,
      if (instance.txKBitRate case final value?) 'txKBitRate': value,
      if (instance.rxKBitRate case final value?) 'rxKBitRate': value,
      if (instance.rxAudioKBitRate case final value?) 'rxAudioKBitRate': value,
      if (instance.txAudioKBitRate case final value?) 'txAudioKBitRate': value,
      if (instance.rxVideoKBitRate case final value?) 'rxVideoKBitRate': value,
      if (instance.txVideoKBitRate case final value?) 'txVideoKBitRate': value,
      if (instance.lastmileDelay case final value?) 'lastmileDelay': value,
      if (instance.userCount case final value?) 'userCount': value,
      if (instance.cpuAppUsage case final value?) 'cpuAppUsage': value,
      if (instance.cpuTotalUsage case final value?) 'cpuTotalUsage': value,
      if (instance.gatewayRtt case final value?) 'gatewayRtt': value,
      if (instance.memoryAppUsageRatio case final value?)
        'memoryAppUsageRatio': value,
      if (instance.memoryTotalUsageRatio case final value?)
        'memoryTotalUsageRatio': value,
      if (instance.memoryAppUsageInKbytes case final value?)
        'memoryAppUsageInKbytes': value,
      if (instance.connectTimeMs case final value?) 'connectTimeMs': value,
      if (instance.firstAudioPacketDuration case final value?)
        'firstAudioPacketDuration': value,
      if (instance.firstVideoPacketDuration case final value?)
        'firstVideoPacketDuration': value,
      if (instance.firstVideoKeyFramePacketDuration case final value?)
        'firstVideoKeyFramePacketDuration': value,
      if (instance.packetsBeforeFirstKeyFramePacket case final value?)
        'packetsBeforeFirstKeyFramePacket': value,
      if (instance.firstAudioPacketDurationAfterUnmute case final value?)
        'firstAudioPacketDurationAfterUnmute': value,
      if (instance.firstVideoPacketDurationAfterUnmute case final value?)
        'firstVideoPacketDurationAfterUnmute': value,
      if (instance.firstVideoKeyFramePacketDurationAfterUnmute
          case final value?)
        'firstVideoKeyFramePacketDurationAfterUnmute': value,
      if (instance.firstVideoKeyFrameDecodedDurationAfterUnmute
          case final value?)
        'firstVideoKeyFrameDecodedDurationAfterUnmute': value,
      if (instance.firstVideoKeyFrameRenderedDurationAfterUnmute
          case final value?)
        'firstVideoKeyFrameRenderedDurationAfterUnmute': value,
      if (instance.txPacketLossRate case final value?)
        'txPacketLossRate': value,
      if (instance.rxPacketLossRate case final value?)
        'rxPacketLossRate': value,
    };

ClientRoleOptions _$ClientRoleOptionsFromJson(Map<String, dynamic> json) =>
    ClientRoleOptions(
      audienceLatencyLevel: $enumDecodeNullable(
          _$AudienceLatencyLevelTypeEnumMap, json['audienceLatencyLevel']),
    );

Map<String, dynamic> _$ClientRoleOptionsToJson(ClientRoleOptions instance) =>
    <String, dynamic>{
      if (_$AudienceLatencyLevelTypeEnumMap[instance.audienceLatencyLevel]
          case final value?)
        'audienceLatencyLevel': value,
    };

const _$AudienceLatencyLevelTypeEnumMap = {
  AudienceLatencyLevelType.audienceLatencyLevelLowLatency: 1,
  AudienceLatencyLevelType.audienceLatencyLevelUltraLowLatency: 2,
};

VideoFormat _$VideoFormatFromJson(Map<String, dynamic> json) => VideoFormat(
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      fps: (json['fps'] as num?)?.toInt(),
    );

Map<String, dynamic> _$VideoFormatToJson(VideoFormat instance) =>
    <String, dynamic>{
      if (instance.width case final value?) 'width': value,
      if (instance.height case final value?) 'height': value,
      if (instance.fps case final value?) 'fps': value,
    };

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

Map<String, dynamic> _$VideoTrackInfoToJson(VideoTrackInfo instance) =>
    <String, dynamic>{
      if (instance.isLocal case final value?) 'isLocal': value,
      if (instance.ownerUid case final value?) 'ownerUid': value,
      if (instance.trackId case final value?) 'trackId': value,
      if (instance.channelId case final value?) 'channelId': value,
      if (_$VideoCodecTypeEnumMap[instance.codecType] case final value?)
        'codecType': value,
      if (instance.encodedFrameOnly case final value?)
        'encodedFrameOnly': value,
      if (_$VideoSourceTypeEnumMap[instance.sourceType] case final value?)
        'sourceType': value,
      if (instance.observationPosition case final value?)
        'observationPosition': value,
    };

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

Map<String, dynamic> _$AudioVolumeInfoToJson(AudioVolumeInfo instance) =>
    <String, dynamic>{
      if (instance.uid case final value?) 'uid': value,
      if (instance.volume case final value?) 'volume': value,
      if (instance.vad case final value?) 'vad': value,
      if (instance.voicePitch case final value?) 'voicePitch': value,
    };

DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) => DeviceInfo(
      isLowLatencyAudioSupported: json['isLowLatencyAudioSupported'] as bool?,
    );

Map<String, dynamic> _$DeviceInfoToJson(DeviceInfo instance) =>
    <String, dynamic>{
      if (instance.isLowLatencyAudioSupported case final value?)
        'isLowLatencyAudioSupported': value,
    };

Packet _$PacketFromJson(Map<String, dynamic> json) => Packet(
      size: (json['size'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PacketToJson(Packet instance) => <String, dynamic>{
      if (instance.size case final value?) 'size': value,
    };

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

Map<String, dynamic> _$LocalAudioStatsToJson(LocalAudioStats instance) =>
    <String, dynamic>{
      if (instance.numChannels case final value?) 'numChannels': value,
      if (instance.sentSampleRate case final value?) 'sentSampleRate': value,
      if (instance.sentBitrate case final value?) 'sentBitrate': value,
      if (instance.internalCodec case final value?) 'internalCodec': value,
      if (instance.txPacketLossRate case final value?)
        'txPacketLossRate': value,
      if (instance.audioDeviceDelay case final value?)
        'audioDeviceDelay': value,
      if (instance.audioPlayoutDelay case final value?)
        'audioPlayoutDelay': value,
      if (instance.earMonitorDelay case final value?) 'earMonitorDelay': value,
      if (instance.aecEstimatedDelay case final value?)
        'aecEstimatedDelay': value,
    };

RtcImage _$RtcImageFromJson(Map<String, dynamic> json) => RtcImage(
      url: json['url'] as String?,
      x: (json['x'] as num?)?.toInt(),
      y: (json['y'] as num?)?.toInt(),
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      zOrder: (json['zOrder'] as num?)?.toInt(),
      alpha: (json['alpha'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RtcImageToJson(RtcImage instance) => <String, dynamic>{
      if (instance.url case final value?) 'url': value,
      if (instance.x case final value?) 'x': value,
      if (instance.y case final value?) 'y': value,
      if (instance.width case final value?) 'width': value,
      if (instance.height case final value?) 'height': value,
      if (instance.zOrder case final value?) 'zOrder': value,
      if (instance.alpha case final value?) 'alpha': value,
    };

LiveStreamAdvancedFeature _$LiveStreamAdvancedFeatureFromJson(
        Map<String, dynamic> json) =>
    LiveStreamAdvancedFeature(
      featureName: json['featureName'] as String?,
      opened: json['opened'] as bool?,
    );

Map<String, dynamic> _$LiveStreamAdvancedFeatureToJson(
        LiveStreamAdvancedFeature instance) =>
    <String, dynamic>{
      if (instance.featureName case final value?) 'featureName': value,
      if (instance.opened case final value?) 'opened': value,
    };

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

Map<String, dynamic> _$TranscodingUserToJson(TranscodingUser instance) =>
    <String, dynamic>{
      if (instance.uid case final value?) 'uid': value,
      if (instance.x case final value?) 'x': value,
      if (instance.y case final value?) 'y': value,
      if (instance.width case final value?) 'width': value,
      if (instance.height case final value?) 'height': value,
      if (instance.zOrder case final value?) 'zOrder': value,
      if (instance.alpha case final value?) 'alpha': value,
      if (instance.audioChannel case final value?) 'audioChannel': value,
    };

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

Map<String, dynamic> _$LiveTranscodingToJson(LiveTranscoding instance) =>
    <String, dynamic>{
      if (instance.width case final value?) 'width': value,
      if (instance.height case final value?) 'height': value,
      if (instance.videoBitrate case final value?) 'videoBitrate': value,
      if (instance.videoFramerate case final value?) 'videoFramerate': value,
      if (instance.lowLatency case final value?) 'lowLatency': value,
      if (instance.videoGop case final value?) 'videoGop': value,
      if (_$VideoCodecProfileTypeEnumMap[instance.videoCodecProfile]
          case final value?)
        'videoCodecProfile': value,
      if (instance.backgroundColor case final value?) 'backgroundColor': value,
      if (_$VideoCodecTypeForStreamEnumMap[instance.videoCodecType]
          case final value?)
        'videoCodecType': value,
      if (instance.userCount case final value?) 'userCount': value,
      if (instance.transcodingUsers?.map((e) => e.toJson()).toList()
          case final value?)
        'transcodingUsers': value,
      if (instance.transcodingExtraInfo case final value?)
        'transcodingExtraInfo': value,
      if (instance.metadata case final value?) 'metadata': value,
      if (instance.watermark?.map((e) => e.toJson()).toList() case final value?)
        'watermark': value,
      if (instance.watermarkCount case final value?) 'watermarkCount': value,
      if (instance.backgroundImage?.map((e) => e.toJson()).toList()
          case final value?)
        'backgroundImage': value,
      if (instance.backgroundImageCount case final value?)
        'backgroundImageCount': value,
      if (_$AudioSampleRateTypeEnumMap[instance.audioSampleRate]
          case final value?)
        'audioSampleRate': value,
      if (instance.audioBitrate case final value?) 'audioBitrate': value,
      if (instance.audioChannels case final value?) 'audioChannels': value,
      if (_$AudioCodecProfileTypeEnumMap[instance.audioCodecProfile]
          case final value?)
        'audioCodecProfile': value,
      if (instance.advancedFeatures?.map((e) => e.toJson()).toList()
          case final value?)
        'advancedFeatures': value,
      if (instance.advancedFeatureCount case final value?)
        'advancedFeatureCount': value,
    };

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
        TranscodingVideoStream instance) =>
    <String, dynamic>{
      if (_$VideoSourceTypeEnumMap[instance.sourceType] case final value?)
        'sourceType': value,
      if (instance.remoteUserUid case final value?) 'remoteUserUid': value,
      if (instance.imageUrl case final value?) 'imageUrl': value,
      if (instance.mediaPlayerId case final value?) 'mediaPlayerId': value,
      if (instance.x case final value?) 'x': value,
      if (instance.y case final value?) 'y': value,
      if (instance.width case final value?) 'width': value,
      if (instance.height case final value?) 'height': value,
      if (instance.zOrder case final value?) 'zOrder': value,
      if (instance.alpha case final value?) 'alpha': value,
      if (instance.mirror case final value?) 'mirror': value,
    };

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
        LocalTranscoderConfiguration instance) =>
    <String, dynamic>{
      if (instance.streamCount case final value?) 'streamCount': value,
      if (instance.videoInputStreams?.map((e) => e.toJson()).toList()
          case final value?)
        'videoInputStreams': value,
      if (instance.videoOutputConfiguration?.toJson() case final value?)
        'videoOutputConfiguration': value,
      if (instance.syncWithPrimaryCamera case final value?)
        'syncWithPrimaryCamera': value,
    };

LastmileProbeConfig _$LastmileProbeConfigFromJson(Map<String, dynamic> json) =>
    LastmileProbeConfig(
      probeUplink: json['probeUplink'] as bool?,
      probeDownlink: json['probeDownlink'] as bool?,
      expectedUplinkBitrate: (json['expectedUplinkBitrate'] as num?)?.toInt(),
      expectedDownlinkBitrate:
          (json['expectedDownlinkBitrate'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LastmileProbeConfigToJson(
        LastmileProbeConfig instance) =>
    <String, dynamic>{
      if (instance.probeUplink case final value?) 'probeUplink': value,
      if (instance.probeDownlink case final value?) 'probeDownlink': value,
      if (instance.expectedUplinkBitrate case final value?)
        'expectedUplinkBitrate': value,
      if (instance.expectedDownlinkBitrate case final value?)
        'expectedDownlinkBitrate': value,
    };

LastmileProbeOneWayResult _$LastmileProbeOneWayResultFromJson(
        Map<String, dynamic> json) =>
    LastmileProbeOneWayResult(
      packetLossRate: (json['packetLossRate'] as num?)?.toInt(),
      jitter: (json['jitter'] as num?)?.toInt(),
      availableBandwidth: (json['availableBandwidth'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LastmileProbeOneWayResultToJson(
        LastmileProbeOneWayResult instance) =>
    <String, dynamic>{
      if (instance.packetLossRate case final value?) 'packetLossRate': value,
      if (instance.jitter case final value?) 'jitter': value,
      if (instance.availableBandwidth case final value?)
        'availableBandwidth': value,
    };

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

Map<String, dynamic> _$LastmileProbeResultToJson(
        LastmileProbeResult instance) =>
    <String, dynamic>{
      if (_$LastmileProbeResultStateEnumMap[instance.state] case final value?)
        'state': value,
      if (instance.uplinkReport?.toJson() case final value?)
        'uplinkReport': value,
      if (instance.downlinkReport?.toJson() case final value?)
        'downlinkReport': value,
      if (instance.rtt case final value?) 'rtt': value,
    };

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

Map<String, dynamic> _$WlAccStatsToJson(WlAccStats instance) =>
    <String, dynamic>{
      if (instance.e2eDelayPercent case final value?) 'e2eDelayPercent': value,
      if (instance.frozenRatioPercent case final value?)
        'frozenRatioPercent': value,
      if (instance.lossRatePercent case final value?) 'lossRatePercent': value,
    };

VideoCanvas _$VideoCanvasFromJson(Map<String, dynamic> json) => VideoCanvas(
      uid: (json['uid'] as num?)?.toInt(),
      subviewUid: (json['subviewUid'] as num?)?.toInt(),
      view: (readIntPtr(json, 'view') as num?)?.toInt(),
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

Map<String, dynamic> _$VideoCanvasToJson(VideoCanvas instance) =>
    <String, dynamic>{
      if (instance.uid case final value?) 'uid': value,
      if (instance.subviewUid case final value?) 'subviewUid': value,
      if (instance.view case final value?) 'view': value,
      if (instance.backgroundColor case final value?) 'backgroundColor': value,
      if (_$RenderModeTypeEnumMap[instance.renderMode] case final value?)
        'renderMode': value,
      if (_$VideoMirrorModeTypeEnumMap[instance.mirrorMode] case final value?)
        'mirrorMode': value,
      if (_$VideoViewSetupModeEnumMap[instance.setupMode] case final value?)
        'setupMode': value,
      if (_$VideoSourceTypeEnumMap[instance.sourceType] case final value?)
        'sourceType': value,
      if (instance.mediaPlayerId case final value?) 'mediaPlayerId': value,
      if (instance.cropArea?.toJson() case final value?) 'cropArea': value,
      if (instance.enableAlphaMask case final value?) 'enableAlphaMask': value,
      if (_$VideoModulePositionEnumMap[instance.position] case final value?)
        'position': value,
    };

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

Map<String, dynamic> _$BeautyOptionsToJson(BeautyOptions instance) =>
    <String, dynamic>{
      if (_$LighteningContrastLevelEnumMap[instance.lighteningContrastLevel]
          case final value?)
        'lighteningContrastLevel': value,
      if (instance.lighteningLevel case final value?) 'lighteningLevel': value,
      if (instance.smoothnessLevel case final value?) 'smoothnessLevel': value,
      if (instance.rednessLevel case final value?) 'rednessLevel': value,
      if (instance.sharpnessLevel case final value?) 'sharpnessLevel': value,
    };

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
        LowlightEnhanceOptions instance) =>
    <String, dynamic>{
      if (_$LowLightEnhanceModeEnumMap[instance.mode] case final value?)
        'mode': value,
      if (_$LowLightEnhanceLevelEnumMap[instance.level] case final value?)
        'level': value,
    };

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
        VideoDenoiserOptions instance) =>
    <String, dynamic>{
      if (_$VideoDenoiserModeEnumMap[instance.mode] case final value?)
        'mode': value,
      if (_$VideoDenoiserLevelEnumMap[instance.level] case final value?)
        'level': value,
    };

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

Map<String, dynamic> _$ColorEnhanceOptionsToJson(
        ColorEnhanceOptions instance) =>
    <String, dynamic>{
      if (instance.strengthLevel case final value?) 'strengthLevel': value,
      if (instance.skinProtectLevel case final value?)
        'skinProtectLevel': value,
    };

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
        VirtualBackgroundSource instance) =>
    <String, dynamic>{
      if (_$BackgroundSourceTypeEnumMap[instance.backgroundSourceType]
          case final value?)
        'background_source_type': value,
      if (instance.color case final value?) 'color': value,
      if (instance.source case final value?) 'source': value,
      if (_$BackgroundBlurDegreeEnumMap[instance.blurDegree] case final value?)
        'blur_degree': value,
    };

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
        SegmentationProperty instance) =>
    <String, dynamic>{
      if (_$SegModelTypeEnumMap[instance.modelType] case final value?)
        'modelType': value,
      if (instance.greenCapacity case final value?) 'greenCapacity': value,
    };

const _$SegModelTypeEnumMap = {
  SegModelType.segModelAi: 1,
  SegModelType.segModelGreen: 2,
};

AudioTrackConfig _$AudioTrackConfigFromJson(Map<String, dynamic> json) =>
    AudioTrackConfig(
      enableLocalPlayback: json['enableLocalPlayback'] as bool?,
    );

Map<String, dynamic> _$AudioTrackConfigToJson(AudioTrackConfig instance) =>
    <String, dynamic>{
      if (instance.enableLocalPlayback case final value?)
        'enableLocalPlayback': value,
    };

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
      excludeWindowList:
          (readIntPtrList(json, 'excludeWindowList') as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList(),
      excludeWindowCount: (json['excludeWindowCount'] as num?)?.toInt(),
      highLightWidth: (json['highLightWidth'] as num?)?.toInt(),
      highLightColor: (json['highLightColor'] as num?)?.toInt(),
      enableHighLight: json['enableHighLight'] as bool?,
    );

Map<String, dynamic> _$ScreenCaptureParametersToJson(
        ScreenCaptureParameters instance) =>
    <String, dynamic>{
      if (instance.dimensions?.toJson() case final value?) 'dimensions': value,
      if (instance.frameRate case final value?) 'frameRate': value,
      if (instance.bitrate case final value?) 'bitrate': value,
      if (instance.captureMouseCursor case final value?)
        'captureMouseCursor': value,
      if (instance.windowFocus case final value?) 'windowFocus': value,
      if (instance.excludeWindowList case final value?)
        'excludeWindowList': value,
      if (instance.excludeWindowCount case final value?)
        'excludeWindowCount': value,
      if (instance.highLightWidth case final value?) 'highLightWidth': value,
      if (instance.highLightColor case final value?) 'highLightColor': value,
      if (instance.enableHighLight case final value?) 'enableHighLight': value,
    };

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
        AudioRecordingConfiguration instance) =>
    <String, dynamic>{
      if (instance.filePath case final value?) 'filePath': value,
      if (instance.encode case final value?) 'encode': value,
      if (instance.sampleRate case final value?) 'sampleRate': value,
      if (_$AudioFileRecordingTypeEnumMap[instance.fileRecordingType]
          case final value?)
        'fileRecordingType': value,
      if (_$AudioRecordingQualityTypeEnumMap[instance.quality]
          case final value?)
        'quality': value,
      if (instance.recordingChannel case final value?)
        'recordingChannel': value,
    };

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
        AudioEncodedFrameObserverConfig instance) =>
    <String, dynamic>{
      if (_$AudioEncodedFrameObserverPositionEnumMap[instance.postionType]
          case final value?)
        'postionType': value,
      if (_$AudioEncodingTypeEnumMap[instance.encodingType] case final value?)
        'encodingType': value,
    };

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

Map<String, dynamic> _$ChannelMediaInfoToJson(ChannelMediaInfo instance) =>
    <String, dynamic>{
      if (instance.uid case final value?) 'uid': value,
      if (instance.channelName case final value?) 'channelName': value,
      if (instance.token case final value?) 'token': value,
    };

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
        ChannelMediaRelayConfiguration instance) =>
    <String, dynamic>{
      if (instance.srcInfo?.toJson() case final value?) 'srcInfo': value,
      if (instance.destInfos?.map((e) => e.toJson()).toList() case final value?)
        'destInfos': value,
      if (instance.destCount case final value?) 'destCount': value,
    };

UplinkNetworkInfo _$UplinkNetworkInfoFromJson(Map<String, dynamic> json) =>
    UplinkNetworkInfo(
      videoEncoderTargetBitrateBps:
          (json['video_encoder_target_bitrate_bps'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UplinkNetworkInfoToJson(UplinkNetworkInfo instance) =>
    <String, dynamic>{
      if (instance.videoEncoderTargetBitrateBps case final value?)
        'video_encoder_target_bitrate_bps': value,
    };

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

Map<String, dynamic> _$DownlinkNetworkInfoToJson(
        DownlinkNetworkInfo instance) =>
    <String, dynamic>{
      if (instance.lastmileBufferDelayTimeMs case final value?)
        'lastmile_buffer_delay_time_ms': value,
      if (instance.bandwidthEstimationBps case final value?)
        'bandwidth_estimation_bps': value,
      if (instance.totalDownscaleLevelCount case final value?)
        'total_downscale_level_count': value,
      if (instance.peerDownlinkInfo?.map((e) => e.toJson()).toList()
          case final value?)
        'peer_downlink_info': value,
      if (instance.totalReceivedVideoCount case final value?)
        'total_received_video_count': value,
    };

PeerDownlinkInfo _$PeerDownlinkInfoFromJson(Map<String, dynamic> json) =>
    PeerDownlinkInfo(
      userId: json['userId'] as String?,
      streamType:
          $enumDecodeNullable(_$VideoStreamTypeEnumMap, json['stream_type']),
      currentDownscaleLevel: $enumDecodeNullable(
          _$RemoteVideoDownscaleLevelEnumMap, json['current_downscale_level']),
      expectedBitrateBps: (json['expected_bitrate_bps'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PeerDownlinkInfoToJson(PeerDownlinkInfo instance) =>
    <String, dynamic>{
      if (instance.userId case final value?) 'userId': value,
      if (_$VideoStreamTypeEnumMap[instance.streamType] case final value?)
        'stream_type': value,
      if (_$RemoteVideoDownscaleLevelEnumMap[instance.currentDownscaleLevel]
          case final value?)
        'current_downscale_level': value,
      if (instance.expectedBitrateBps case final value?)
        'expected_bitrate_bps': value,
    };

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

Map<String, dynamic> _$EncryptionConfigToJson(EncryptionConfig instance) =>
    <String, dynamic>{
      if (_$EncryptionModeEnumMap[instance.encryptionMode] case final value?)
        'encryptionMode': value,
      if (instance.encryptionKey case final value?) 'encryptionKey': value,
      if (instance.datastreamEncryptionEnabled case final value?)
        'datastreamEncryptionEnabled': value,
    };

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
      view: (readIntPtr(json, 'view') as num?)?.toInt(),
      enableAudio: json['enableAudio'] as bool?,
      enableVideo: json['enableVideo'] as bool?,
      token: json['token'] as String?,
      channelId: json['channelId'] as String?,
      intervalInSeconds: (json['intervalInSeconds'] as num?)?.toInt(),
    );

Map<String, dynamic> _$EchoTestConfigurationToJson(
        EchoTestConfiguration instance) =>
    <String, dynamic>{
      if (instance.view case final value?) 'view': value,
      if (instance.enableAudio case final value?) 'enableAudio': value,
      if (instance.enableVideo case final value?) 'enableVideo': value,
      if (instance.token case final value?) 'token': value,
      if (instance.channelId case final value?) 'channelId': value,
      if (instance.intervalInSeconds case final value?)
        'intervalInSeconds': value,
    };

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      uid: (json['uid'] as num?)?.toInt(),
      userAccount: json['userAccount'] as String?,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      if (instance.uid case final value?) 'uid': value,
      if (instance.userAccount case final value?) 'userAccount': value,
    };

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
        ScreenVideoParameters instance) =>
    <String, dynamic>{
      if (instance.dimensions?.toJson() case final value?) 'dimensions': value,
      if (instance.frameRate case final value?) 'frameRate': value,
      if (instance.bitrate case final value?) 'bitrate': value,
      if (_$VideoContentHintEnumMap[instance.contentHint] case final value?)
        'contentHint': value,
    };

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
        ScreenAudioParameters instance) =>
    <String, dynamic>{
      if (instance.sampleRate case final value?) 'sampleRate': value,
      if (instance.channels case final value?) 'channels': value,
      if (instance.captureSignalVolume case final value?)
        'captureSignalVolume': value,
    };

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
        ScreenCaptureParameters2 instance) =>
    <String, dynamic>{
      if (instance.captureAudio case final value?) 'captureAudio': value,
      if (instance.audioParams?.toJson() case final value?)
        'audioParams': value,
      if (instance.captureVideo case final value?) 'captureVideo': value,
      if (instance.videoParams?.toJson() case final value?)
        'videoParams': value,
    };

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
        VideoRenderingTracingInfo instance) =>
    <String, dynamic>{
      if (instance.elapsedTime case final value?) 'elapsedTime': value,
      if (instance.start2JoinChannel case final value?)
        'start2JoinChannel': value,
      if (instance.join2JoinSuccess case final value?)
        'join2JoinSuccess': value,
      if (instance.joinSuccess2RemoteJoined case final value?)
        'joinSuccess2RemoteJoined': value,
      if (instance.remoteJoined2SetView case final value?)
        'remoteJoined2SetView': value,
      if (instance.remoteJoined2UnmuteVideo case final value?)
        'remoteJoined2UnmuteVideo': value,
      if (instance.remoteJoined2PacketReceived case final value?)
        'remoteJoined2PacketReceived': value,
    };

LogUploadServerInfo _$LogUploadServerInfoFromJson(Map<String, dynamic> json) =>
    LogUploadServerInfo(
      serverDomain: json['serverDomain'] as String?,
      serverPath: json['serverPath'] as String?,
      serverPort: (json['serverPort'] as num?)?.toInt(),
      serverHttps: json['serverHttps'] as bool?,
    );

Map<String, dynamic> _$LogUploadServerInfoToJson(
        LogUploadServerInfo instance) =>
    <String, dynamic>{
      if (instance.serverDomain case final value?) 'serverDomain': value,
      if (instance.serverPath case final value?) 'serverPath': value,
      if (instance.serverPort case final value?) 'serverPort': value,
      if (instance.serverHttps case final value?) 'serverHttps': value,
    };

AdvancedConfigInfo _$AdvancedConfigInfoFromJson(Map<String, dynamic> json) =>
    AdvancedConfigInfo(
      logUploadServer: json['logUploadServer'] == null
          ? null
          : LogUploadServerInfo.fromJson(
              json['logUploadServer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdvancedConfigInfoToJson(AdvancedConfigInfo instance) =>
    <String, dynamic>{
      if (instance.logUploadServer?.toJson() case final value?)
        'logUploadServer': value,
    };

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
        LocalAccessPointConfiguration instance) =>
    <String, dynamic>{
      if (instance.ipList case final value?) 'ipList': value,
      if (instance.ipListSize case final value?) 'ipListSize': value,
      if (instance.domainList case final value?) 'domainList': value,
      if (instance.domainListSize case final value?) 'domainListSize': value,
      if (instance.verifyDomainName case final value?)
        'verifyDomainName': value,
      if (_$LocalProxyModeEnumMap[instance.mode] case final value?)
        'mode': value,
      if (instance.advancedConfig?.toJson() case final value?)
        'advancedConfig': value,
      if (instance.disableAut case final value?) 'disableAut': value,
    };

const _$LocalProxyModeEnumMap = {
  LocalProxyMode.connectivityFirst: 0,
  LocalProxyMode.localOnly: 1,
};

RecorderStreamInfo _$RecorderStreamInfoFromJson(Map<String, dynamic> json) =>
    RecorderStreamInfo(
      channelId: json['channelId'] as String?,
      uid: (json['uid'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RecorderStreamInfoToJson(RecorderStreamInfo instance) =>
    <String, dynamic>{
      if (instance.channelId case final value?) 'channelId': value,
      if (instance.uid case final value?) 'uid': value,
    };

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

Map<String, dynamic> _$SpatialAudioParamsToJson(SpatialAudioParams instance) =>
    <String, dynamic>{
      if (instance.speakerAzimuth case final value?) 'speaker_azimuth': value,
      if (instance.speakerElevation case final value?)
        'speaker_elevation': value,
      if (instance.speakerDistance case final value?) 'speaker_distance': value,
      if (instance.speakerOrientation case final value?)
        'speaker_orientation': value,
      if (instance.enableBlur case final value?) 'enable_blur': value,
      if (instance.enableAirAbsorb case final value?)
        'enable_air_absorb': value,
      if (instance.speakerAttenuation case final value?)
        'speaker_attenuation': value,
      if (instance.enableDoppler case final value?) 'enable_doppler': value,
    };

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

Map<String, dynamic> _$VideoLayoutToJson(VideoLayout instance) =>
    <String, dynamic>{
      if (instance.channelId case final value?) 'channelId': value,
      if (instance.uid case final value?) 'uid': value,
      if (instance.strUid case final value?) 'strUid': value,
      if (instance.x case final value?) 'x': value,
      if (instance.y case final value?) 'y': value,
      if (instance.width case final value?) 'width': value,
      if (instance.height case final value?) 'height': value,
      if (instance.videoState case final value?) 'videoState': value,
    };

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
