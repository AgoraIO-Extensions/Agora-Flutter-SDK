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

Map<String, dynamic> _$VideoDimensionsToJson(VideoDimensions instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
    };

SenderOptions _$SenderOptionsFromJson(Map<String, dynamic> json) =>
    SenderOptions(
      ccMode: $enumDecodeNullable(_$TCcModeEnumMap, json['ccMode']),
      codecType:
          $enumDecodeNullable(_$VideoCodecTypeEnumMap, json['codecType']),
      targetBitrate: json['targetBitrate'] as int?,
    );

Map<String, dynamic> _$SenderOptionsToJson(SenderOptions instance) =>
    <String, dynamic>{
      'ccMode': _$TCcModeEnumMap[instance.ccMode],
      'codecType': _$VideoCodecTypeEnumMap[instance.codecType],
      'targetBitrate': instance.targetBitrate,
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
  VideoCodecType.videoCodecVp9: 5,
  VideoCodecType.videoCodecGeneric: 6,
  VideoCodecType.videoCodecGenericH264: 7,
  VideoCodecType.videoCodecAv1: 12,
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
      'speech': instance.speech,
      'sendEvenIfEmpty': instance.sendEvenIfEmpty,
    };

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
    );

Map<String, dynamic> _$EncodedAudioFrameInfoToJson(
        EncodedAudioFrameInfo instance) =>
    <String, dynamic>{
      'codec': _$AudioCodecTypeEnumMap[instance.codec],
      'sampleRateHz': instance.sampleRateHz,
      'samplesPerChannel': instance.samplesPerChannel,
      'numberOfChannels': instance.numberOfChannels,
      'advancedSettings': instance.advancedSettings?.toJson(),
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
      samplesPerChannel: json['samplesPerChannel'] as int?,
      channelNum: json['channelNum'] as int?,
      samplesOut: json['samplesOut'] as int?,
      elapsedTimeMs: json['elapsedTimeMs'] as int?,
      ntpTimeMs: json['ntpTimeMs'] as int?,
    );

Map<String, dynamic> _$AudioPcmDataInfoToJson(AudioPcmDataInfo instance) =>
    <String, dynamic>{
      'samplesPerChannel': instance.samplesPerChannel,
      'channelNum': instance.channelNum,
      'samplesOut': instance.samplesOut,
      'elapsedTimeMs': instance.elapsedTimeMs,
      'ntpTimeMs': instance.ntpTimeMs,
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
      renderTimeMs: json['renderTimeMs'] as int?,
      internalSendTs: json['internalSendTs'] as int?,
      uid: json['uid'] as int?,
      streamType:
          $enumDecodeNullable(_$VideoStreamTypeEnumMap, json['streamType']),
    );

Map<String, dynamic> _$EncodedVideoFrameInfoToJson(
        EncodedVideoFrameInfo instance) =>
    <String, dynamic>{
      'codecType': _$VideoCodecTypeEnumMap[instance.codecType],
      'width': instance.width,
      'height': instance.height,
      'framesPerSecond': instance.framesPerSecond,
      'frameType': _$VideoFrameTypeEnumMap[instance.frameType],
      'rotation': _$VideoOrientationEnumMap[instance.rotation],
      'trackId': instance.trackId,
      'renderTimeMs': instance.renderTimeMs,
      'internalSendTs': instance.internalSendTs,
      'uid': instance.uid,
      'streamType': _$VideoStreamTypeEnumMap[instance.streamType],
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

const _$VideoStreamTypeEnumMap = {
  VideoStreamType.videoStreamHigh: 0,
  VideoStreamType.videoStreamLow: 1,
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
        VideoEncoderConfiguration instance) =>
    <String, dynamic>{
      'codecType': _$VideoCodecTypeEnumMap[instance.codecType],
      'dimensions': instance.dimensions?.toJson(),
      'frameRate': instance.frameRate,
      'bitrate': instance.bitrate,
      'minBitrate': instance.minBitrate,
      'orientationMode': _$OrientationModeEnumMap[instance.orientationMode],
      'degradationPreference':
          _$DegradationPreferenceEnumMap[instance.degradationPreference],
      'mirrorMode': _$VideoMirrorModeTypeEnumMap[instance.mirrorMode],
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
      'syncWithAudio': instance.syncWithAudio,
      'ordered': instance.ordered,
    };

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
        SimulcastStreamConfig instance) =>
    <String, dynamic>{
      'dimensions': instance.dimensions?.toJson(),
      'bitrate': instance.bitrate,
      'framerate': instance.framerate,
    };

Rectangle _$RectangleFromJson(Map<String, dynamic> json) => Rectangle(
      x: json['x'] as int?,
      y: json['y'] as int?,
      width: json['width'] as int?,
      height: json['height'] as int?,
    );

Map<String, dynamic> _$RectangleToJson(Rectangle instance) => <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'width': instance.width,
      'height': instance.height,
    };

WatermarkRatio _$WatermarkRatioFromJson(Map<String, dynamic> json) =>
    WatermarkRatio(
      xRatio: (json['xRatio'] as num?)?.toDouble(),
      yRatio: (json['yRatio'] as num?)?.toDouble(),
      widthRatio: (json['widthRatio'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WatermarkRatioToJson(WatermarkRatio instance) =>
    <String, dynamic>{
      'xRatio': instance.xRatio,
      'yRatio': instance.yRatio,
      'widthRatio': instance.widthRatio,
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
      'visibleInPreview': instance.visibleInPreview,
      'positionInLandscapeMode': instance.positionInLandscapeMode?.toJson(),
      'positionInPortraitMode': instance.positionInPortraitMode?.toJson(),
      'watermarkRatio': instance.watermarkRatio?.toJson(),
      'mode': _$WatermarkFitModeEnumMap[instance.mode],
    };

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

Map<String, dynamic> _$RtcStatsToJson(RtcStats instance) => <String, dynamic>{
      'duration': instance.duration,
      'txBytes': instance.txBytes,
      'rxBytes': instance.rxBytes,
      'txAudioBytes': instance.txAudioBytes,
      'txVideoBytes': instance.txVideoBytes,
      'rxAudioBytes': instance.rxAudioBytes,
      'rxVideoBytes': instance.rxVideoBytes,
      'txKBitRate': instance.txKBitRate,
      'rxKBitRate': instance.rxKBitRate,
      'rxAudioKBitRate': instance.rxAudioKBitRate,
      'txAudioKBitRate': instance.txAudioKBitRate,
      'rxVideoKBitRate': instance.rxVideoKBitRate,
      'txVideoKBitRate': instance.txVideoKBitRate,
      'lastmileDelay': instance.lastmileDelay,
      'userCount': instance.userCount,
      'cpuAppUsage': instance.cpuAppUsage,
      'cpuTotalUsage': instance.cpuTotalUsage,
      'gatewayRtt': instance.gatewayRtt,
      'memoryAppUsageRatio': instance.memoryAppUsageRatio,
      'memoryTotalUsageRatio': instance.memoryTotalUsageRatio,
      'memoryAppUsageInKbytes': instance.memoryAppUsageInKbytes,
      'connectTimeMs': instance.connectTimeMs,
      'firstAudioPacketDuration': instance.firstAudioPacketDuration,
      'firstVideoPacketDuration': instance.firstVideoPacketDuration,
      'firstVideoKeyFramePacketDuration':
          instance.firstVideoKeyFramePacketDuration,
      'packetsBeforeFirstKeyFramePacket':
          instance.packetsBeforeFirstKeyFramePacket,
      'firstAudioPacketDurationAfterUnmute':
          instance.firstAudioPacketDurationAfterUnmute,
      'firstVideoPacketDurationAfterUnmute':
          instance.firstVideoPacketDurationAfterUnmute,
      'firstVideoKeyFramePacketDurationAfterUnmute':
          instance.firstVideoKeyFramePacketDurationAfterUnmute,
      'firstVideoKeyFrameDecodedDurationAfterUnmute':
          instance.firstVideoKeyFrameDecodedDurationAfterUnmute,
      'firstVideoKeyFrameRenderedDurationAfterUnmute':
          instance.firstVideoKeyFrameRenderedDurationAfterUnmute,
      'txPacketLossRate': instance.txPacketLossRate,
      'rxPacketLossRate': instance.rxPacketLossRate,
    };

ClientRoleOptions _$ClientRoleOptionsFromJson(Map<String, dynamic> json) =>
    ClientRoleOptions(
      audienceLatencyLevel: $enumDecodeNullable(
          _$AudienceLatencyLevelTypeEnumMap, json['audienceLatencyLevel']),
    );

Map<String, dynamic> _$ClientRoleOptionsToJson(ClientRoleOptions instance) =>
    <String, dynamic>{
      'audienceLatencyLevel':
          _$AudienceLatencyLevelTypeEnumMap[instance.audienceLatencyLevel],
    };

const _$AudienceLatencyLevelTypeEnumMap = {
  AudienceLatencyLevelType.audienceLatencyLevelLowLatency: 1,
  AudienceLatencyLevelType.audienceLatencyLevelUltraLowLatency: 2,
  AudienceLatencyLevelType.audienceLatencyLevelHighLatency: 3,
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
    );

Map<String, dynamic> _$RemoteAudioStatsToJson(RemoteAudioStats instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'quality': instance.quality,
      'networkTransportDelay': instance.networkTransportDelay,
      'jitterBufferDelay': instance.jitterBufferDelay,
      'audioLossRate': instance.audioLossRate,
      'numChannels': instance.numChannels,
      'receivedSampleRate': instance.receivedSampleRate,
      'receivedBitrate': instance.receivedBitrate,
      'totalFrozenTime': instance.totalFrozenTime,
      'frozenRate': instance.frozenRate,
      'mosValue': instance.mosValue,
      'totalActiveTime': instance.totalActiveTime,
      'publishDuration': instance.publishDuration,
      'qoeQuality': instance.qoeQuality,
    };

VideoFormat _$VideoFormatFromJson(Map<String, dynamic> json) => VideoFormat(
      width: json['width'] as int?,
      height: json['height'] as int?,
      fps: json['fps'] as int?,
    );

Map<String, dynamic> _$VideoFormatToJson(VideoFormat instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'fps': instance.fps,
    };

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

Map<String, dynamic> _$VideoTrackInfoToJson(VideoTrackInfo instance) =>
    <String, dynamic>{
      'isLocal': instance.isLocal,
      'ownerUid': instance.ownerUid,
      'trackId': instance.trackId,
      'channelId': instance.channelId,
      'streamType': _$VideoStreamTypeEnumMap[instance.streamType],
      'codecType': _$VideoCodecTypeEnumMap[instance.codecType],
      'encodedFrameOnly': instance.encodedFrameOnly,
      'sourceType': _$VideoSourceTypeEnumMap[instance.sourceType],
      'observationPosition': instance.observationPosition,
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
  VideoSourceType.videoSourceUnknown: 100,
};

AudioVolumeInfo _$AudioVolumeInfoFromJson(Map<String, dynamic> json) =>
    AudioVolumeInfo(
      uid: json['uid'] as int?,
      volume: json['volume'] as int?,
      vad: json['vad'] as int?,
      voicePitch: (json['voicePitch'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AudioVolumeInfoToJson(AudioVolumeInfo instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'volume': instance.volume,
      'vad': instance.vad,
      'voicePitch': instance.voicePitch,
    };

DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) => DeviceInfo(
      isLowLatencyAudioSupported: json['isLowLatencyAudioSupported'] as bool?,
    );

Map<String, dynamic> _$DeviceInfoToJson(DeviceInfo instance) =>
    <String, dynamic>{
      'isLowLatencyAudioSupported': instance.isLowLatencyAudioSupported,
    };

Packet _$PacketFromJson(Map<String, dynamic> json) => Packet(
      size: json['size'] as int?,
    );

Map<String, dynamic> _$PacketToJson(Packet instance) => <String, dynamic>{
      'size': instance.size,
    };

LocalAudioStats _$LocalAudioStatsFromJson(Map<String, dynamic> json) =>
    LocalAudioStats(
      numChannels: json['numChannels'] as int?,
      sentSampleRate: json['sentSampleRate'] as int?,
      sentBitrate: json['sentBitrate'] as int?,
      internalCodec: json['internalCodec'] as int?,
      txPacketLossRate: json['txPacketLossRate'] as int?,
    );

Map<String, dynamic> _$LocalAudioStatsToJson(LocalAudioStats instance) =>
    <String, dynamic>{
      'numChannels': instance.numChannels,
      'sentSampleRate': instance.sentSampleRate,
      'sentBitrate': instance.sentBitrate,
      'internalCodec': instance.internalCodec,
      'txPacketLossRate': instance.txPacketLossRate,
    };

RtcImage _$RtcImageFromJson(Map<String, dynamic> json) => RtcImage(
      url: json['url'] as String?,
      x: json['x'] as int?,
      y: json['y'] as int?,
      width: json['width'] as int?,
      height: json['height'] as int?,
      zOrder: json['zOrder'] as int?,
      alpha: (json['alpha'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RtcImageToJson(RtcImage instance) => <String, dynamic>{
      'url': instance.url,
      'x': instance.x,
      'y': instance.y,
      'width': instance.width,
      'height': instance.height,
      'zOrder': instance.zOrder,
      'alpha': instance.alpha,
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
      'featureName': instance.featureName,
      'opened': instance.opened,
    };

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

Map<String, dynamic> _$TranscodingUserToJson(TranscodingUser instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'x': instance.x,
      'y': instance.y,
      'width': instance.width,
      'height': instance.height,
      'zOrder': instance.zOrder,
      'alpha': instance.alpha,
      'audioChannel': instance.audioChannel,
    };

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

Map<String, dynamic> _$LiveTranscodingToJson(LiveTranscoding instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'videoBitrate': instance.videoBitrate,
      'videoFramerate': instance.videoFramerate,
      'lowLatency': instance.lowLatency,
      'videoGop': instance.videoGop,
      'videoCodecProfile':
          _$VideoCodecProfileTypeEnumMap[instance.videoCodecProfile],
      'backgroundColor': instance.backgroundColor,
      'videoCodecType':
          _$VideoCodecTypeForStreamEnumMap[instance.videoCodecType],
      'userCount': instance.userCount,
      'transcodingUsers':
          instance.transcodingUsers?.map((e) => e.toJson()).toList(),
      'transcodingExtraInfo': instance.transcodingExtraInfo,
      'metadata': instance.metadata,
      'watermark': instance.watermark?.map((e) => e.toJson()).toList(),
      'watermarkCount': instance.watermarkCount,
      'backgroundImage':
          instance.backgroundImage?.map((e) => e.toJson()).toList(),
      'backgroundImageCount': instance.backgroundImageCount,
      'audioSampleRate': _$AudioSampleRateTypeEnumMap[instance.audioSampleRate],
      'audioBitrate': instance.audioBitrate,
      'audioChannels': instance.audioChannels,
      'audioCodecProfile':
          _$AudioCodecProfileTypeEnumMap[instance.audioCodecProfile],
      'advancedFeatures':
          instance.advancedFeatures?.map((e) => e.toJson()).toList(),
      'advancedFeatureCount': instance.advancedFeatureCount,
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
        TranscodingVideoStream instance) =>
    <String, dynamic>{
      'sourceType': _$MediaSourceTypeEnumMap[instance.sourceType],
      'remoteUserUid': instance.remoteUserUid,
      'imageUrl': instance.imageUrl,
      'x': instance.x,
      'y': instance.y,
      'width': instance.width,
      'height': instance.height,
      'zOrder': instance.zOrder,
      'alpha': instance.alpha,
      'mirror': instance.mirror,
    };

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
        LocalTranscoderConfiguration instance) =>
    <String, dynamic>{
      'streamCount': instance.streamCount,
      'VideoInputStreams':
          instance.videoInputStreams?.map((e) => e.toJson()).toList(),
      'videoOutputConfiguration': instance.videoOutputConfiguration?.toJson(),
    };

LastmileProbeConfig _$LastmileProbeConfigFromJson(Map<String, dynamic> json) =>
    LastmileProbeConfig(
      probeUplink: json['probeUplink'] as bool?,
      probeDownlink: json['probeDownlink'] as bool?,
      expectedUplinkBitrate: json['expectedUplinkBitrate'] as int?,
      expectedDownlinkBitrate: json['expectedDownlinkBitrate'] as int?,
    );

Map<String, dynamic> _$LastmileProbeConfigToJson(
        LastmileProbeConfig instance) =>
    <String, dynamic>{
      'probeUplink': instance.probeUplink,
      'probeDownlink': instance.probeDownlink,
      'expectedUplinkBitrate': instance.expectedUplinkBitrate,
      'expectedDownlinkBitrate': instance.expectedDownlinkBitrate,
    };

LastmileProbeOneWayResult _$LastmileProbeOneWayResultFromJson(
        Map<String, dynamic> json) =>
    LastmileProbeOneWayResult(
      packetLossRate: json['packetLossRate'] as int?,
      jitter: json['jitter'] as int?,
      availableBandwidth: json['availableBandwidth'] as int?,
    );

Map<String, dynamic> _$LastmileProbeOneWayResultToJson(
        LastmileProbeOneWayResult instance) =>
    <String, dynamic>{
      'packetLossRate': instance.packetLossRate,
      'jitter': instance.jitter,
      'availableBandwidth': instance.availableBandwidth,
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
      rtt: json['rtt'] as int?,
    );

Map<String, dynamic> _$LastmileProbeResultToJson(
        LastmileProbeResult instance) =>
    <String, dynamic>{
      'state': _$LastmileProbeResultStateEnumMap[instance.state],
      'uplinkReport': instance.uplinkReport?.toJson(),
      'downlinkReport': instance.downlinkReport?.toJson(),
      'rtt': instance.rtt,
    };

const _$LastmileProbeResultStateEnumMap = {
  LastmileProbeResultState.lastmileProbeResultComplete: 1,
  LastmileProbeResultState.lastmileProbeResultIncompleteNoBwe: 2,
  LastmileProbeResultState.lastmileProbeResultUnavailable: 3,
};

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

Map<String, dynamic> _$VideoCanvasToJson(VideoCanvas instance) =>
    <String, dynamic>{
      'view': instance.view,
      'renderMode': _$RenderModeTypeEnumMap[instance.renderMode],
      'mirrorMode': _$VideoMirrorModeTypeEnumMap[instance.mirrorMode],
      'uid': instance.uid,
      'isScreenView': instance.isScreenView,
      'priv_size': instance.privSize,
      'sourceType': _$VideoSourceTypeEnumMap[instance.sourceType],
      'cropArea': instance.cropArea?.toJson(),
      'setupMode': _$VideoViewSetupModeEnumMap[instance.setupMode],
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
      'lighteningContrastLevel':
          _$LighteningContrastLevelEnumMap[instance.lighteningContrastLevel],
      'lighteningLevel': instance.lighteningLevel,
      'smoothnessLevel': instance.smoothnessLevel,
      'rednessLevel': instance.rednessLevel,
      'sharpnessLevel': instance.sharpnessLevel,
    };

const _$LighteningContrastLevelEnumMap = {
  LighteningContrastLevel.lighteningContrastLow: 0,
  LighteningContrastLevel.lighteningContrastNormal: 1,
  LighteningContrastLevel.lighteningContrastHigh: 2,
};

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
        VirtualBackgroundSource instance) =>
    <String, dynamic>{
      'background_source_type':
          _$BackgroundSourceTypeEnumMap[instance.backgroundSourceType],
      'color': instance.color,
      'source': instance.source,
      'blur_degree': _$BackgroundBlurDegreeEnumMap[instance.blurDegree],
    };

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

FishCorrectionParams _$FishCorrectionParamsFromJson(
        Map<String, dynamic> json) =>
    FishCorrectionParams(
      xCenter: (json['_x_center'] as num?)?.toDouble(),
      yCenter: (json['_y_center'] as num?)?.toDouble(),
      scaleFactor: (json['_scale_factor'] as num?)?.toDouble(),
      focalLength: (json['_focal_length'] as num?)?.toDouble(),
      polFocalLength: (json['_pol_focal_length'] as num?)?.toDouble(),
      splitHeight: (json['_split_height'] as num?)?.toDouble(),
      ss: (json['_ss'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$FishCorrectionParamsToJson(
        FishCorrectionParams instance) =>
    <String, dynamic>{
      '_x_center': instance.xCenter,
      '_y_center': instance.yCenter,
      '_scale_factor': instance.scaleFactor,
      '_focal_length': instance.focalLength,
      '_pol_focal_length': instance.polFocalLength,
      '_split_height': instance.splitHeight,
      '_ss': instance.ss,
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
    );

Map<String, dynamic> _$ScreenCaptureParametersToJson(
        ScreenCaptureParameters instance) =>
    <String, dynamic>{
      'dimensions': instance.dimensions?.toJson(),
      'frameRate': instance.frameRate,
      'bitrate': instance.bitrate,
      'captureMouseCursor': instance.captureMouseCursor,
      'windowFocus': instance.windowFocus,
      'excludeWindowList': instance.excludeWindowList,
      'excludeWindowCount': instance.excludeWindowCount,
    };

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
    );

Map<String, dynamic> _$AudioRecordingConfigurationToJson(
        AudioRecordingConfiguration instance) =>
    <String, dynamic>{
      'filePath': instance.filePath,
      'encode': instance.encode,
      'sampleRate': instance.sampleRate,
      'fileRecordingType':
          _$AudioFileRecordingTypeEnumMap[instance.fileRecordingType],
      'quality': _$AudioRecordingQualityTypeEnumMap[instance.quality],
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
      'postionType':
          _$AudioEncodedFrameObserverPositionEnumMap[instance.postionType],
      'encodingType': _$AudioEncodingTypeEnumMap[instance.encodingType],
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
      channelName: json['channelName'] as String?,
      token: json['token'] as String?,
      uid: json['uid'] as int?,
    );

Map<String, dynamic> _$ChannelMediaInfoToJson(ChannelMediaInfo instance) =>
    <String, dynamic>{
      'channelName': instance.channelName,
      'token': instance.token,
      'uid': instance.uid,
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
      destCount: json['destCount'] as int?,
    );

Map<String, dynamic> _$ChannelMediaRelayConfigurationToJson(
        ChannelMediaRelayConfiguration instance) =>
    <String, dynamic>{
      'srcInfo': instance.srcInfo?.toJson(),
      'destInfos': instance.destInfos?.map((e) => e.toJson()).toList(),
      'destCount': instance.destCount,
    };

UplinkNetworkInfo _$UplinkNetworkInfoFromJson(Map<String, dynamic> json) =>
    UplinkNetworkInfo(
      videoEncoderTargetBitrateBps:
          json['video_encoder_target_bitrate_bps'] as int?,
    );

Map<String, dynamic> _$UplinkNetworkInfoToJson(UplinkNetworkInfo instance) =>
    <String, dynamic>{
      'video_encoder_target_bitrate_bps': instance.videoEncoderTargetBitrateBps,
    };

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

Map<String, dynamic> _$DownlinkNetworkInfoToJson(
        DownlinkNetworkInfo instance) =>
    <String, dynamic>{
      'lastmile_buffer_delay_time_ms': instance.lastmileBufferDelayTimeMs,
      'bandwidth_estimation_bps': instance.bandwidthEstimationBps,
      'total_downscale_level_count': instance.totalDownscaleLevelCount,
      'peer_downlink_info':
          instance.peerDownlinkInfo?.map((e) => e.toJson()).toList(),
      'total_received_video_count': instance.totalReceivedVideoCount,
    };

PeerDownlinkInfo _$PeerDownlinkInfoFromJson(Map<String, dynamic> json) =>
    PeerDownlinkInfo(
      uid: json['uid'] as String?,
      streamType:
          $enumDecodeNullable(_$VideoStreamTypeEnumMap, json['stream_type']),
      currentDownscaleLevel: $enumDecodeNullable(
          _$RemoteVideoDownscaleLevelEnumMap, json['current_downscale_level']),
      expectedBitrateBps: json['expected_bitrate_bps'] as int?,
    );

Map<String, dynamic> _$PeerDownlinkInfoToJson(PeerDownlinkInfo instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'stream_type': _$VideoStreamTypeEnumMap[instance.streamType],
      'current_downscale_level':
          _$RemoteVideoDownscaleLevelEnumMap[instance.currentDownscaleLevel],
      'expected_bitrate_bps': instance.expectedBitrateBps,
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
    );

Map<String, dynamic> _$EncryptionConfigToJson(EncryptionConfig instance) =>
    <String, dynamic>{
      'encryptionMode': _$EncryptionModeEnumMap[instance.encryptionMode],
      'encryptionKey': instance.encryptionKey,
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

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      uid: json['uid'] as int?,
      userAccount: json['userAccount'] as String?,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'uid': instance.uid,
      'userAccount': instance.userAccount,
    };

SpatialAudioParams _$SpatialAudioParamsFromJson(Map<String, dynamic> json) =>
    SpatialAudioParams(
      speakerAzimuth: (json['speaker_azimuth'] as num?)?.toDouble(),
      speakerElevation: (json['speaker_elevation'] as num?)?.toDouble(),
      speakerDistance: (json['speaker_distance'] as num?)?.toDouble(),
      speakerOrientation: json['speaker_orientation'] as int?,
      enableBlur: json['enable_blur'] as bool?,
      enableAirAbsorb: json['enable_air_absorb'] as bool?,
    );

Map<String, dynamic> _$SpatialAudioParamsToJson(SpatialAudioParams instance) =>
    <String, dynamic>{
      'speaker_azimuth': instance.speakerAzimuth,
      'speaker_elevation': instance.speakerElevation,
      'speaker_distance': instance.speakerDistance,
      'speaker_orientation': instance.speakerOrientation,
      'enable_blur': instance.enableBlur,
      'enable_air_absorb': instance.enableAirAbsorb,
    };

const _$ChannelProfileTypeEnumMap = {
  ChannelProfileType.channelProfileCommunication: 0,
  ChannelProfileType.channelProfileLiveBroadcasting: 1,
  ChannelProfileType.channelProfileGame: 2,
  ChannelProfileType.channelProfileCloudGaming: 3,
  ChannelProfileType.channelProfileCommunication1v1: 4,
  ChannelProfileType.channelProfileLiveBroadcasting2: 5,
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
  WarnCodeType.warnAdmIosCategoryNotPlayandrecord: 1029,
  WarnCodeType.warnAdmIosSamplerateChange: 1030,
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
  ErrorCodeType.errNetNobufs: 15,
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
  ErrorCodeType.errWatermarkParam: 124,
  ErrorCodeType.errWatermarkPath: 125,
  ErrorCodeType.errWatermarkPng: 126,
  ErrorCodeType.errWatermarkrInfo: 127,
  ErrorCodeType.errWatermarkArgb: 128,
  ErrorCodeType.errWatermarkRead: 129,
  ErrorCodeType.errEncryptedStreamNotAllowedPublish: 130,
  ErrorCodeType.errLicenseCredentialInvalid: 131,
  ErrorCodeType.errInvalidUserAccount: 134,
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
  ErrorCodeType.errLogoutOther: 400,
  ErrorCodeType.errLogoutUser: 401,
  ErrorCodeType.errLogoutNet: 402,
  ErrorCodeType.errLogoutKicked: 403,
  ErrorCodeType.errLogoutPacket: 404,
  ErrorCodeType.errLogoutTokenExpired: 405,
  ErrorCodeType.errLogoutOldversion: 406,
  ErrorCodeType.errLogoutTokenWrong: 407,
  ErrorCodeType.errLogoutAlreadyLogout: 408,
  ErrorCodeType.errLoginOther: 420,
  ErrorCodeType.errLoginNet: 421,
  ErrorCodeType.errLoginFailed: 422,
  ErrorCodeType.errLoginCanceled: 423,
  ErrorCodeType.errLoginTokenExpired: 424,
  ErrorCodeType.errLoginOldVersion: 425,
  ErrorCodeType.errLoginTokenWrong: 426,
  ErrorCodeType.errLoginTokenKicked: 427,
  ErrorCodeType.errLoginAlreadyLogin: 428,
  ErrorCodeType.errJoinChannelOther: 440,
  ErrorCodeType.errSendMessageOther: 440,
  ErrorCodeType.errSendMessageTimeout: 441,
  ErrorCodeType.errQueryUsernumOther: 450,
  ErrorCodeType.errQueryUsernumTimeout: 451,
  ErrorCodeType.errQueryUsernumByuser: 452,
  ErrorCodeType.errLeaveChannelOther: 460,
  ErrorCodeType.errLeaveChannelKicked: 461,
  ErrorCodeType.errLeaveChannelByuser: 462,
  ErrorCodeType.errLeaveChannelLogout: 463,
  ErrorCodeType.errLeaveChannelDisconnected: 464,
  ErrorCodeType.errInviteOther: 470,
  ErrorCodeType.errInviteReinvite: 471,
  ErrorCodeType.errInviteNet: 472,
  ErrorCodeType.errInvitePeerOffline: 473,
  ErrorCodeType.errInviteTimeout: 474,
  ErrorCodeType.errInviteCantRecv: 475,
  ErrorCodeType.errLoadMediaEngine: 1001,
  ErrorCodeType.errStartCall: 1002,
  ErrorCodeType.errStartCamera: 1003,
  ErrorCodeType.errStartVideoRender: 1004,
  ErrorCodeType.errAdmGeneralError: 1005,
  ErrorCodeType.errAdmJavaResource: 1006,
  ErrorCodeType.errAdmSampleRate: 1007,
  ErrorCodeType.errAdmInitPlayout: 1008,
  ErrorCodeType.errAdmStartPlayout: 1009,
  ErrorCodeType.errAdmStopPlayout: 1010,
  ErrorCodeType.errAdmInitRecording: 1011,
  ErrorCodeType.errAdmStartRecording: 1012,
  ErrorCodeType.errAdmStopRecording: 1013,
  ErrorCodeType.errAdmRuntimePlayoutError: 1015,
  ErrorCodeType.errAdmRuntimeRecordingError: 1017,
  ErrorCodeType.errAdmRecordAudioFailed: 1018,
  ErrorCodeType.errAdmInitLoopback: 1022,
  ErrorCodeType.errAdmStartLoopback: 1023,
  ErrorCodeType.errAdmNoPermission: 1027,
  ErrorCodeType.errAdmRecordAudioIsActive: 1033,
  ErrorCodeType.errAdmAndroidJniJavaResource: 1101,
  ErrorCodeType.errAdmAndroidJniNoRecordFrequency: 1108,
  ErrorCodeType.errAdmAndroidJniNoPlaybackFrequency: 1109,
  ErrorCodeType.errAdmAndroidJniJavaStartRecord: 1111,
  ErrorCodeType.errAdmAndroidJniJavaStartPlayback: 1112,
  ErrorCodeType.errAdmAndroidJniJavaRecordError: 1115,
  ErrorCodeType.errAdmAndroidOpenslCreateEngine: 1151,
  ErrorCodeType.errAdmAndroidOpenslCreateAudioRecorder: 1153,
  ErrorCodeType.errAdmAndroidOpenslStartRecorderThread: 1156,
  ErrorCodeType.errAdmAndroidOpenslCreateAudioPlayer: 1157,
  ErrorCodeType.errAdmAndroidOpenslStartPlayerThread: 1160,
  ErrorCodeType.errAdmIosInputNotAvailable: 1201,
  ErrorCodeType.errAdmIosActivateSessionFail: 1206,
  ErrorCodeType.errAdmIosVpioInitFail: 1210,
  ErrorCodeType.errAdmIosVpioReinitFail: 1213,
  ErrorCodeType.errAdmIosVpioRestartFail: 1214,
  ErrorCodeType.errAdmIosSetRenderCallbackFail: 1219,
  ErrorCodeType.errAdmIosSessionSampleratrZero: 1221,
  ErrorCodeType.errAdmWinCoreInit: 1301,
  ErrorCodeType.errAdmWinCoreInitRecording: 1303,
  ErrorCodeType.errAdmWinCoreInitPlayout: 1306,
  ErrorCodeType.errAdmWinCoreInitPlayoutNull: 1307,
  ErrorCodeType.errAdmWinCoreStartRecording: 1309,
  ErrorCodeType.errAdmWinCoreCreateRecThread: 1311,
  ErrorCodeType.errAdmWinCoreCaptureNotStartup: 1314,
  ErrorCodeType.errAdmWinCoreCreateRenderThread: 1319,
  ErrorCodeType.errAdmWinCoreRenderNotStartup: 1320,
  ErrorCodeType.errAdmWinCoreNoRecordingDevice: 1322,
  ErrorCodeType.errAdmWinCoreNoPlayoutDevice: 1323,
  ErrorCodeType.errAdmWinWaveInit: 1351,
  ErrorCodeType.errAdmWinWaveInitRecording: 1353,
  ErrorCodeType.errAdmWinWaveInitMicrophone: 1354,
  ErrorCodeType.errAdmWinWaveInitPlayout: 1355,
  ErrorCodeType.errAdmWinWaveInitSpeaker: 1356,
  ErrorCodeType.errAdmWinWaveStartRecording: 1357,
  ErrorCodeType.errAdmWinWaveStartPlayout: 1358,
  ErrorCodeType.errAdmNoRecordingDevice: 1359,
  ErrorCodeType.errAdmNoPlayoutDevice: 1360,
  ErrorCodeType.errVdmCameraNotAuthorized: 1501,
  ErrorCodeType.errVdmWinDeviceInUse: 1502,
  ErrorCodeType.errVcmUnknownError: 1600,
  ErrorCodeType.errVcmEncoderInitError: 1601,
  ErrorCodeType.errVcmEncoderEncodeError: 1602,
  ErrorCodeType.errVcmEncoderSetError: 1603,
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
  AudioScenarioType.audioScenarioHighDefinition: 6,
  AudioScenarioType.audioScenarioChorus: 7,
  AudioScenarioType.audioScenarioNum: 8,
};

const _$VideoContentHintEnumMap = {
  VideoContentHint.contentHintNone: 0,
  VideoContentHint.contentHintMotion: 1,
  VideoContentHint.contentHintDetails: 2,
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
