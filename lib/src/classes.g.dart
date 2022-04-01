// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names, deprecated_member_use_from_same_package, unused_element

part of 'classes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      json['uid'] as int,
      json['userAccount'] as String,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'uid': instance.uid,
      'userAccount': instance.userAccount,
    };

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

VideoEncoderConfiguration _$VideoEncoderConfigurationFromJson(
        Map<String, dynamic> json) =>
    VideoEncoderConfiguration(
      dimensions: json['dimensions'] == null
          ? null
          : VideoDimensions.fromJson(
              json['dimensions'] as Map<String, dynamic>),
      frameRate:
          $enumDecodeNullable(_$VideoFrameRateEnumMap, json['frameRate']),
      minFrameRate:
          $enumDecodeNullable(_$VideoFrameRateEnumMap, json['minFrameRate']),
      bitrate: json['bitrate'] as int?,
      minBitrate: json['minBitrate'] as int?,
      orientationMode: $enumDecodeNullable(
          _$VideoOutputOrientationModeEnumMap, json['orientationMode']),
      degradationPreference: $enumDecodeNullable(
          _$DegradationPreferenceEnumMap, json['degradationPreference']),
      mirrorMode:
          $enumDecodeNullable(_$VideoMirrorModeEnumMap, json['mirrorMode']),
    );

Map<String, dynamic> _$VideoEncoderConfigurationToJson(
    VideoEncoderConfiguration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('dimensions', instance.dimensions?.toJson());
  writeNotNull('frameRate', _$VideoFrameRateEnumMap[instance.frameRate]);
  writeNotNull('minFrameRate', _$VideoFrameRateEnumMap[instance.minFrameRate]);
  writeNotNull('bitrate', instance.bitrate);
  writeNotNull('minBitrate', instance.minBitrate);
  writeNotNull('orientationMode',
      _$VideoOutputOrientationModeEnumMap[instance.orientationMode]);
  writeNotNull('degradationPreference',
      _$DegradationPreferenceEnumMap[instance.degradationPreference]);
  writeNotNull('mirrorMode', _$VideoMirrorModeEnumMap[instance.mirrorMode]);
  return val;
}

const _$VideoFrameRateEnumMap = {
  VideoFrameRate.Fps1: 1,
  VideoFrameRate.Fps7: 7,
  VideoFrameRate.Fps10: 10,
  VideoFrameRate.Fps15: 15,
  VideoFrameRate.Fps24: 24,
  VideoFrameRate.Fps30: 30,
  VideoFrameRate.Fps60: 60,
};

const _$VideoOutputOrientationModeEnumMap = {
  VideoOutputOrientationMode.Adaptative: 0,
  VideoOutputOrientationMode.FixedLandscape: 1,
  VideoOutputOrientationMode.FixedPortrait: 2,
};

const _$DegradationPreferenceEnumMap = {
  DegradationPreference.MaintainQuality: 0,
  DegradationPreference.MaintainFramerate: 1,
  DegradationPreference.MaintainBalanced: 2,
};

const _$VideoMirrorModeEnumMap = {
  VideoMirrorMode.Auto: 0,
  VideoMirrorMode.Enabled: 1,
  VideoMirrorMode.Disabled: 2,
};

BeautyOptions _$BeautyOptionsFromJson(Map<String, dynamic> json) =>
    BeautyOptions(
      lighteningContrastLevel: $enumDecodeNullable(
          _$LighteningContrastLevelEnumMap, json['lighteningContrastLevel']),
      lighteningLevel: (json['lighteningLevel'] as num?)?.toDouble(),
      smoothnessLevel: (json['smoothnessLevel'] as num?)?.toDouble(),
      rednessLevel: (json['rednessLevel'] as num?)?.toDouble(),
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
  return val;
}

const _$LighteningContrastLevelEnumMap = {
  LighteningContrastLevel.Low: 0,
  LighteningContrastLevel.Normal: 1,
  LighteningContrastLevel.High: 2,
};

AgoraImage _$AgoraImageFromJson(Map<String, dynamic> json) => AgoraImage(
      json['url'] as String,
      x: json['x'] as int?,
      y: json['y'] as int?,
      width: json['width'] as int?,
      height: json['height'] as int?,
    );

Map<String, dynamic> _$AgoraImageToJson(AgoraImage instance) {
  final val = <String, dynamic>{
    'url': instance.url,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('x', instance.x);
  writeNotNull('y', instance.y);
  val['width'] = instance.width;
  val['height'] = instance.height;
  return val;
}

TranscodingUser _$TranscodingUserFromJson(Map<String, dynamic> json) =>
    TranscodingUser(
      json['uid'] as int,
      x: json['x'] as int?,
      y: json['y'] as int?,
      width: json['width'] as int?,
      height: json['height'] as int?,
      zOrder: json['zOrder'] as int?,
      alpha: (json['alpha'] as num?)?.toDouble(),
      audioChannel:
          $enumDecodeNullable(_$AudioChannelEnumMap, json['audioChannel']),
    );

Map<String, dynamic> _$TranscodingUserToJson(TranscodingUser instance) {
  final val = <String, dynamic>{
    'uid': instance.uid,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('x', instance.x);
  writeNotNull('y', instance.y);
  writeNotNull('width', instance.width);
  writeNotNull('height', instance.height);
  writeNotNull('zOrder', instance.zOrder);
  writeNotNull('alpha', instance.alpha);
  writeNotNull('audioChannel', _$AudioChannelEnumMap[instance.audioChannel]);
  return val;
}

const _$AudioChannelEnumMap = {
  AudioChannel.Channel0: 0,
  AudioChannel.Channel1: 1,
  AudioChannel.Channel2: 2,
  AudioChannel.Channel3: 3,
  AudioChannel.Channel4: 4,
  AudioChannel.Channel5: 5,
};

LiveTranscoding _$LiveTranscodingFromJson(Map<String, dynamic> json) =>
    LiveTranscoding(
      (json['transcodingUsers'] as List<dynamic>)
          .map((e) => TranscodingUser.fromJson(e as Map<String, dynamic>))
          .toList(),
      width: json['width'] as int?,
      height: json['height'] as int?,
      videoBitrate: json['videoBitrate'] as int?,
      videoFramerate:
          $enumDecodeNullable(_$VideoFrameRateEnumMap, json['videoFramerate']),
      lowLatency: json['lowLatency'] as bool?,
      videoGop: json['videoGop'] as int?,
      watermark: (json['watermark'] as List<dynamic>?)
          ?.map((e) => AgoraImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      backgroundImage: (json['backgroundImage'] as List<dynamic>?)
          ?.map((e) => AgoraImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      audioSampleRate: $enumDecodeNullable(
          _$AudioSampleRateTypeEnumMap, json['audioSampleRate']),
      audioBitrate: json['audioBitrate'] as int?,
      audioChannels:
          $enumDecodeNullable(_$AudioChannelEnumMap, json['audioChannels']),
      audioCodecProfile: $enumDecodeNullable(
          _$AudioCodecProfileTypeEnumMap, json['audioCodecProfile']),
      videoCodecProfile: $enumDecodeNullable(
          _$VideoCodecProfileTypeEnumMap, json['videoCodecProfile']),
      backgroundColor: json['backgroundColor'] as int?,
      videoCodecType: $enumDecodeNullable(
          _$VideoCodecTypeForStreamEnumMap, json['videoCodecType']),
      userConfigExtraInfo: json['userConfigExtraInfo'] as String?,
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
  writeNotNull(
      'videoFramerate', _$VideoFrameRateEnumMap[instance.videoFramerate]);
  writeNotNull('lowLatency', instance.lowLatency);
  writeNotNull('videoGop', instance.videoGop);
  writeNotNull(
      'watermark', instance.watermark?.map((e) => e.toJson()).toList());
  writeNotNull('backgroundImage',
      instance.backgroundImage?.map((e) => e.toJson()).toList());
  writeNotNull('audioSampleRate',
      _$AudioSampleRateTypeEnumMap[instance.audioSampleRate]);
  writeNotNull('audioBitrate', instance.audioBitrate);
  writeNotNull('audioChannels', _$AudioChannelEnumMap[instance.audioChannels]);
  writeNotNull('audioCodecProfile',
      _$AudioCodecProfileTypeEnumMap[instance.audioCodecProfile]);
  writeNotNull('videoCodecProfile',
      _$VideoCodecProfileTypeEnumMap[instance.videoCodecProfile]);
  writeNotNull('backgroundColor', instance.backgroundColor);
  writeNotNull('videoCodecType',
      _$VideoCodecTypeForStreamEnumMap[instance.videoCodecType]);
  writeNotNull('userConfigExtraInfo', instance.userConfigExtraInfo);
  val['transcodingUsers'] =
      instance.transcodingUsers.map((e) => e.toJson()).toList();
  return val;
}

const _$AudioSampleRateTypeEnumMap = {
  AudioSampleRateType.Type32000: 32000,
  AudioSampleRateType.Type44100: 44100,
  AudioSampleRateType.Type48000: 48000,
};

const _$AudioCodecProfileTypeEnumMap = {
  AudioCodecProfileType.LCAAC: 0,
  AudioCodecProfileType.HEAAC: 1,
};

const _$VideoCodecProfileTypeEnumMap = {
  VideoCodecProfileType.BaseLine: 66,
  VideoCodecProfileType.Main: 77,
  VideoCodecProfileType.High: 100,
};

const _$VideoCodecTypeForStreamEnumMap = {
  VideoCodecTypeForStream.H264: 1,
  VideoCodecTypeForStream.H265: 2,
};

ChannelMediaInfo _$ChannelMediaInfoFromJson(Map<String, dynamic> json) =>
    ChannelMediaInfo(
      json['channelName'] as String,
      json['uid'] as int,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$ChannelMediaInfoToJson(ChannelMediaInfo instance) {
  final val = <String, dynamic>{
    'channelName': instance.channelName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('token', instance.token);
  val['uid'] = instance.uid;
  return val;
}

ChannelMediaRelayConfiguration _$ChannelMediaRelayConfigurationFromJson(
        Map<String, dynamic> json) =>
    ChannelMediaRelayConfiguration(
      ChannelMediaInfo.fromJson(json['srcInfo'] as Map<String, dynamic>),
      (json['destInfos'] as List<dynamic>)
          .map((e) => ChannelMediaInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChannelMediaRelayConfigurationToJson(
        ChannelMediaRelayConfiguration instance) =>
    <String, dynamic>{
      'srcInfo': instance.srcInfo.toJson(),
      'destInfos': instance.destInfos.map((e) => e.toJson()).toList(),
    };

LastmileProbeConfig _$LastmileProbeConfigFromJson(Map<String, dynamic> json) =>
    LastmileProbeConfig(
      json['probeUplink'] as bool,
      json['probeDownlink'] as bool,
      json['expectedUplinkBitrate'] as int,
      json['expectedDownlinkBitrate'] as int,
    );

Map<String, dynamic> _$LastmileProbeConfigToJson(
        LastmileProbeConfig instance) =>
    <String, dynamic>{
      'probeUplink': instance.probeUplink,
      'probeDownlink': instance.probeDownlink,
      'expectedUplinkBitrate': instance.expectedUplinkBitrate,
      'expectedDownlinkBitrate': instance.expectedDownlinkBitrate,
    };

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
  return val;
}

LiveInjectStreamConfig _$LiveInjectStreamConfigFromJson(
        Map<String, dynamic> json) =>
    LiveInjectStreamConfig(
      width: json['width'] as int?,
      height: json['height'] as int?,
      videoGop: json['videoGop'] as int?,
      videoFramerate:
          $enumDecodeNullable(_$VideoFrameRateEnumMap, json['videoFramerate']),
      videoBitrate: json['videoBitrate'] as int?,
      audioSampleRate: $enumDecodeNullable(
          _$AudioSampleRateTypeEnumMap, json['audioSampleRate']),
      audioBitrate: json['audioBitrate'] as int?,
      audioChannels:
          $enumDecodeNullable(_$AudioChannelEnumMap, json['audioChannels']),
    );

Map<String, dynamic> _$LiveInjectStreamConfigToJson(
    LiveInjectStreamConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('width', instance.width);
  writeNotNull('height', instance.height);
  writeNotNull('videoGop', instance.videoGop);
  writeNotNull(
      'videoFramerate', _$VideoFrameRateEnumMap[instance.videoFramerate]);
  writeNotNull('videoBitrate', instance.videoBitrate);
  writeNotNull('audioSampleRate',
      _$AudioSampleRateTypeEnumMap[instance.audioSampleRate]);
  writeNotNull('audioBitrate', instance.audioBitrate);
  writeNotNull('audioChannels', _$AudioChannelEnumMap[instance.audioChannels]);
  return val;
}

CameraCapturerConfiguration _$CameraCapturerConfigurationFromJson(
        Map<String, dynamic> json) =>
    CameraCapturerConfiguration(
      preference: $enumDecodeNullable(
          _$CameraCaptureOutputPreferenceEnumMap, json['preference']),
      captureWidth: json['captureWidth'] as int?,
      captureHeight: json['captureHeight'] as int?,
      cameraDirection: $enumDecodeNullable(
          _$CameraDirectionEnumMap, json['cameraDirection']),
    );

Map<String, dynamic> _$CameraCapturerConfigurationToJson(
    CameraCapturerConfiguration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('preference',
      _$CameraCaptureOutputPreferenceEnumMap[instance.preference]);
  writeNotNull('captureWidth', instance.captureWidth);
  writeNotNull('captureHeight', instance.captureHeight);
  writeNotNull(
      'cameraDirection', _$CameraDirectionEnumMap[instance.cameraDirection]);
  return val;
}

const _$CameraCaptureOutputPreferenceEnumMap = {
  CameraCaptureOutputPreference.Auto: 0,
  CameraCaptureOutputPreference.Performance: 1,
  CameraCaptureOutputPreference.Preview: 2,
  CameraCaptureOutputPreference.Manual: 3,
};

const _$CameraDirectionEnumMap = {
  CameraDirection.Rear: 0,
  CameraDirection.Front: 1,
};

ChannelMediaOptions _$ChannelMediaOptionsFromJson(Map<String, dynamic> json) =>
    ChannelMediaOptions(
      autoSubscribeAudio: json['autoSubscribeAudio'] as bool?,
      autoSubscribeVideo: json['autoSubscribeVideo'] as bool?,
      publishLocalAudio: json['publishLocalAudio'] as bool?,
      publishLocalVideo: json['publishLocalVideo'] as bool?,
    );

Map<String, dynamic> _$ChannelMediaOptionsToJson(ChannelMediaOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('autoSubscribeAudio', instance.autoSubscribeAudio);
  writeNotNull('autoSubscribeVideo', instance.autoSubscribeVideo);
  writeNotNull('publishLocalAudio', instance.publishLocalAudio);
  writeNotNull('publishLocalVideo', instance.publishLocalVideo);
  return val;
}

EncryptionConfig _$EncryptionConfigFromJson(Map<String, dynamic> json) =>
    EncryptionConfig(
      encryptionMode:
          $enumDecodeNullable(_$EncryptionModeEnumMap, json['encryptionMode']),
      encryptionKey: json['encryptionKey'] as String?,
      encryptionKdfSalt: (json['encryptionKdfSalt'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
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
  writeNotNull('encryptionKdfSalt', instance.encryptionKdfSalt);
  return val;
}

const _$EncryptionModeEnumMap = {
  EncryptionMode.AES128XTS: 1,
  EncryptionMode.AES128ECB: 2,
  EncryptionMode.AES256XTS: 3,
  EncryptionMode.SM4128ECB: 4,
  EncryptionMode.AES128GCM: 5,
  EncryptionMode.AES256GCM: 6,
  EncryptionMode.AES128GCM2: 7,
  EncryptionMode.AES256GCM2: 8,
};

RtcStats _$RtcStatsFromJson(Map<String, dynamic> json) => RtcStats(
      json['duration'] as int,
      json['txBytes'] as int,
      json['rxBytes'] as int,
      json['txAudioBytes'] as int,
      json['txVideoBytes'] as int,
      json['rxAudioBytes'] as int,
      json['rxVideoBytes'] as int,
      json['txKBitRate'] as int,
      json['rxKBitRate'] as int,
      json['txAudioKBitRate'] as int,
      json['rxAudioKBitRate'] as int,
      json['txVideoKBitRate'] as int,
      json['rxVideoKBitRate'] as int,
      json['userCount'] as int,
      json['lastmileDelay'] as int,
      json['txPacketLossRate'] as int,
      json['rxPacketLossRate'] as int,
      (json['cpuTotalUsage'] as num).toDouble(),
      (json['cpuAppUsage'] as num).toDouble(),
      json['gatewayRtt'] as int,
      (json['memoryAppUsageRatio'] as num).toDouble(),
      (json['memoryTotalUsageRatio'] as num).toDouble(),
      json['memoryAppUsageInKbytes'] as int,
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
      'txAudioKBitRate': instance.txAudioKBitRate,
      'rxAudioKBitRate': instance.rxAudioKBitRate,
      'txVideoKBitRate': instance.txVideoKBitRate,
      'rxVideoKBitRate': instance.rxVideoKBitRate,
      'userCount': instance.userCount,
      'lastmileDelay': instance.lastmileDelay,
      'txPacketLossRate': instance.txPacketLossRate,
      'rxPacketLossRate': instance.rxPacketLossRate,
      'cpuTotalUsage': instance.cpuTotalUsage,
      'cpuAppUsage': instance.cpuAppUsage,
      'gatewayRtt': instance.gatewayRtt,
      'memoryAppUsageRatio': instance.memoryAppUsageRatio,
      'memoryTotalUsageRatio': instance.memoryTotalUsageRatio,
      'memoryAppUsageInKbytes': instance.memoryAppUsageInKbytes,
    };

AudioVolumeInfo _$AudioVolumeInfoFromJson(Map<String, dynamic> json) =>
    AudioVolumeInfo(
      json['uid'] as int,
      json['volume'] as int,
      json['vad'] as int,
      json['channelId'] as String,
    );

Map<String, dynamic> _$AudioVolumeInfoToJson(AudioVolumeInfo instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'volume': instance.volume,
      'vad': instance.vad,
      'channelId': instance.channelId,
    };

Rect _$RectFromJson(Map<String, dynamic> json) => Rect(
      x: json['x'] as int? ?? 0,
      y: json['y'] as int? ?? 0,
      width: json['width'] as int? ?? 0,
      height: json['height'] as int? ?? 0,
      left: json['left'] as int?,
      top: json['top'] as int?,
      right: json['right'] as int?,
      bottom: json['bottom'] as int?,
    );

Map<String, dynamic> _$RectToJson(Rect instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('left', instance.left);
  writeNotNull('top', instance.top);
  writeNotNull('right', instance.right);
  writeNotNull('bottom', instance.bottom);
  val['x'] = instance.x;
  val['y'] = instance.y;
  val['width'] = instance.width;
  val['height'] = instance.height;
  return val;
}

LastmileProbeOneWayResult _$LastmileProbeOneWayResultFromJson(
        Map<String, dynamic> json) =>
    LastmileProbeOneWayResult(
      json['packetLossRate'] as int,
      json['jitter'] as int,
      json['availableBandwidth'] as int,
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
      $enumDecode(_$LastmileProbeResultStateEnumMap, json['state']),
      json['rtt'] as int,
      LastmileProbeOneWayResult.fromJson(
          json['uplinkReport'] as Map<String, dynamic>),
      LastmileProbeOneWayResult.fromJson(
          json['downlinkReport'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LastmileProbeResultToJson(
        LastmileProbeResult instance) =>
    <String, dynamic>{
      'state': _$LastmileProbeResultStateEnumMap[instance.state],
      'rtt': instance.rtt,
      'uplinkReport': instance.uplinkReport.toJson(),
      'downlinkReport': instance.downlinkReport.toJson(),
    };

const _$LastmileProbeResultStateEnumMap = {
  LastmileProbeResultState.Complete: 1,
  LastmileProbeResultState.IncompleteNoBwe: 2,
  LastmileProbeResultState.Unavailable: 3,
};

LocalAudioStats _$LocalAudioStatsFromJson(Map<String, dynamic> json) =>
    LocalAudioStats(
      json['numChannels'] as int,
      json['sentSampleRate'] as int,
      json['sentBitrate'] as int,
      json['txPacketLossRate'] as int,
    );

Map<String, dynamic> _$LocalAudioStatsToJson(LocalAudioStats instance) =>
    <String, dynamic>{
      'numChannels': instance.numChannels,
      'sentSampleRate': instance.sentSampleRate,
      'sentBitrate': instance.sentBitrate,
      'txPacketLossRate': instance.txPacketLossRate,
    };

LocalVideoStats _$LocalVideoStatsFromJson(Map<String, dynamic> json) =>
    LocalVideoStats(
      json['sentBitrate'] as int,
      json['sentFrameRate'] as int,
      json['encoderOutputFrameRate'] as int,
      json['rendererOutputFrameRate'] as int,
      json['targetBitrate'] as int,
      json['targetFrameRate'] as int,
      $enumDecode(
          _$VideoQualityAdaptIndicationEnumMap, json['qualityAdaptIndication']),
      json['encodedBitrate'] as int,
      json['encodedFrameWidth'] as int,
      json['encodedFrameHeight'] as int,
      json['encodedFrameCount'] as int,
      $enumDecode(_$VideoCodecTypeEnumMap, json['codecType']),
      json['txPacketLossRate'] as int,
      json['captureFrameRate'] as int,
      $enumDecode(
          _$CaptureBrightnessLevelTypeEnumMap, json['captureBrightnessLevel']),
    );

Map<String, dynamic> _$LocalVideoStatsToJson(LocalVideoStats instance) =>
    <String, dynamic>{
      'sentBitrate': instance.sentBitrate,
      'sentFrameRate': instance.sentFrameRate,
      'encoderOutputFrameRate': instance.encoderOutputFrameRate,
      'rendererOutputFrameRate': instance.rendererOutputFrameRate,
      'targetBitrate': instance.targetBitrate,
      'targetFrameRate': instance.targetFrameRate,
      'qualityAdaptIndication':
          _$VideoQualityAdaptIndicationEnumMap[instance.qualityAdaptIndication],
      'encodedBitrate': instance.encodedBitrate,
      'encodedFrameWidth': instance.encodedFrameWidth,
      'encodedFrameHeight': instance.encodedFrameHeight,
      'encodedFrameCount': instance.encodedFrameCount,
      'codecType': _$VideoCodecTypeEnumMap[instance.codecType],
      'txPacketLossRate': instance.txPacketLossRate,
      'captureFrameRate': instance.captureFrameRate,
      'captureBrightnessLevel':
          _$CaptureBrightnessLevelTypeEnumMap[instance.captureBrightnessLevel],
    };

const _$VideoQualityAdaptIndicationEnumMap = {
  VideoQualityAdaptIndication.AdaptNone: 0,
  VideoQualityAdaptIndication.AdaptUpBandwidth: 1,
  VideoQualityAdaptIndication.AdaptDownBandwidth: 2,
};

const _$VideoCodecTypeEnumMap = {
  VideoCodecType.VP8: 1,
  VideoCodecType.H264: 2,
  VideoCodecType.EVP: 3,
  VideoCodecType.E264: 4,
};

const _$CaptureBrightnessLevelTypeEnumMap = {
  CaptureBrightnessLevelType.Invalid: -1,
  CaptureBrightnessLevelType.Normal: 0,
  CaptureBrightnessLevelType.Bright: 1,
  CaptureBrightnessLevelType.Dark: 2,
};

RemoteAudioStats _$RemoteAudioStatsFromJson(Map<String, dynamic> json) =>
    RemoteAudioStats(
      json['uid'] as int,
      $enumDecode(_$NetworkQualityEnumMap, json['quality']),
      json['networkTransportDelay'] as int,
      json['jitterBufferDelay'] as int,
      json['audioLossRate'] as int,
      json['numChannels'] as int,
      json['receivedSampleRate'] as int,
      json['receivedBitrate'] as int,
      json['totalFrozenTime'] as int,
      json['frozenRate'] as int,
      json['totalActiveTime'] as int,
      json['publishDuration'] as int,
      $enumDecode(_$ExperienceQualityTypeEnumMap, json['qoeQuality']),
      $enumDecode(_$ExperiencePoorReasonEnumMap, json['qualityChangedReason']),
      json['mosValue'] as int,
    );

Map<String, dynamic> _$RemoteAudioStatsToJson(RemoteAudioStats instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'quality': _$NetworkQualityEnumMap[instance.quality],
      'networkTransportDelay': instance.networkTransportDelay,
      'jitterBufferDelay': instance.jitterBufferDelay,
      'audioLossRate': instance.audioLossRate,
      'numChannels': instance.numChannels,
      'receivedSampleRate': instance.receivedSampleRate,
      'receivedBitrate': instance.receivedBitrate,
      'totalFrozenTime': instance.totalFrozenTime,
      'frozenRate': instance.frozenRate,
      'totalActiveTime': instance.totalActiveTime,
      'publishDuration': instance.publishDuration,
      'qoeQuality': _$ExperienceQualityTypeEnumMap[instance.qoeQuality],
      'qualityChangedReason':
          _$ExperiencePoorReasonEnumMap[instance.qualityChangedReason],
      'mosValue': instance.mosValue,
    };

const _$NetworkQualityEnumMap = {
  NetworkQuality.Unknown: 0,
  NetworkQuality.Excellent: 1,
  NetworkQuality.Good: 2,
  NetworkQuality.Poor: 3,
  NetworkQuality.Bad: 4,
  NetworkQuality.VBad: 5,
  NetworkQuality.Down: 6,
  NetworkQuality.Unsupported: 7,
  NetworkQuality.Detecting: 8,
};

const _$ExperienceQualityTypeEnumMap = {
  ExperienceQualityType.Good: 0,
  ExperienceQualityType.Bad: 1,
};

const _$ExperiencePoorReasonEnumMap = {
  ExperiencePoorReason.None: 0,
  ExperiencePoorReason.RemoteNetworkQualityPoor: 1,
  ExperiencePoorReason.LocalNetworkQualityPoor: 2,
  ExperiencePoorReason.WirelessSignalPoor: 4,
  ExperiencePoorReason.WifiBluetoothCoexist: 8,
};

RemoteVideoStats _$RemoteVideoStatsFromJson(Map<String, dynamic> json) =>
    RemoteVideoStats(
      json['uid'] as int,
      json['delay'] as int,
      json['width'] as int,
      json['height'] as int,
      json['receivedBitrate'] as int,
      json['decoderOutputFrameRate'] as int,
      json['rendererOutputFrameRate'] as int,
      json['packetLossRate'] as int,
      $enumDecode(_$VideoStreamTypeEnumMap, json['rxStreamType']),
      json['totalFrozenTime'] as int,
      json['frozenRate'] as int,
      json['totalActiveTime'] as int,
      json['publishDuration'] as int,
    );

Map<String, dynamic> _$RemoteVideoStatsToJson(RemoteVideoStats instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'delay': instance.delay,
      'width': instance.width,
      'height': instance.height,
      'receivedBitrate': instance.receivedBitrate,
      'decoderOutputFrameRate': instance.decoderOutputFrameRate,
      'rendererOutputFrameRate': instance.rendererOutputFrameRate,
      'packetLossRate': instance.packetLossRate,
      'rxStreamType': _$VideoStreamTypeEnumMap[instance.rxStreamType],
      'totalFrozenTime': instance.totalFrozenTime,
      'frozenRate': instance.frozenRate,
      'totalActiveTime': instance.totalActiveTime,
      'publishDuration': instance.publishDuration,
    };

const _$VideoStreamTypeEnumMap = {
  VideoStreamType.High: 0,
  VideoStreamType.Low: 1,
};

FacePositionInfo _$FacePositionInfoFromJson(Map<String, dynamic> json) =>
    FacePositionInfo(
      json['x'] as int,
      json['y'] as int,
      json['width'] as int,
      json['height'] as int,
      json['distance'] as int,
    );

Map<String, dynamic> _$FacePositionInfoToJson(FacePositionInfo instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'width': instance.width,
      'height': instance.height,
      'distance': instance.distance,
    };

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
  AudienceLatencyLevelType.LowLatency: 1,
  AudienceLatencyLevelType.UltraLowLatency: 2,
};

LogConfig _$LogConfigFromJson(Map<String, dynamic> json) => LogConfig(
      filePath: json['filePath'] as String?,
      fileSize: json['fileSize'] as int?,
      level: $enumDecodeNullable(_$LogLevelEnumMap, json['level']),
    );

Map<String, dynamic> _$LogConfigToJson(LogConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('filePath', instance.filePath);
  writeNotNull('fileSize', instance.fileSize);
  writeNotNull('level', _$LogLevelEnumMap[instance.level]);
  return val;
}

const _$LogLevelEnumMap = {
  LogLevel.None: 0,
  LogLevel.Info: 1,
  LogLevel.Warn: 2,
  LogLevel.Error: 4,
  LogLevel.Fatal: 8,
};

DataStreamConfig _$DataStreamConfigFromJson(Map<String, dynamic> json) =>
    DataStreamConfig(
      json['syncWithAudio'] as bool,
      json['ordered'] as bool,
    );

Map<String, dynamic> _$DataStreamConfigToJson(DataStreamConfig instance) =>
    <String, dynamic>{
      'syncWithAudio': instance.syncWithAudio,
      'ordered': instance.ordered,
    };

RtcEngineConfig _$RtcEngineConfigFromJson(Map<String, dynamic> json) =>
    RtcEngineConfig(
      json['appId'] as String,
      areaCode: (json['areaCode'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$AreaCodeEnumMap, e))
          .toList(),
      logConfig: json['logConfig'] == null
          ? null
          : LogConfig.fromJson(json['logConfig'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RtcEngineConfigToJson(RtcEngineConfig instance) {
  final val = <String, dynamic>{
    'appId': instance.appId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'areaCode', RtcEngineContext._$AreaCodeListToJson(instance.areaCode));
  writeNotNull('logConfig', instance.logConfig?.toJson());
  return val;
}

const _$AreaCodeEnumMap = {
  AreaCode.CN: 1,
  AreaCode.NA: 2,
  AreaCode.EU: 4,
  AreaCode.AS: 8,
  AreaCode.JP: 16,
  AreaCode.IN: 32,
  AreaCode.GLOB: 4294967295,
};

RtcEngineContext _$RtcEngineContextFromJson(Map<String, dynamic> json) =>
    RtcEngineContext(
      json['appId'] as String,
      areaCode: (json['areaCode'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$AreaCodeEnumMap, e))
          .toList(),
      logConfig: json['logConfig'] == null
          ? null
          : LogConfig.fromJson(json['logConfig'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RtcEngineContextToJson(RtcEngineContext instance) {
  final val = <String, dynamic>{
    'appId': instance.appId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'areaCode', RtcEngineContext._$AreaCodeListToJson(instance.areaCode));
  writeNotNull('logConfig', instance.logConfig?.toJson());
  return val;
}

RhythmPlayerConfig _$RhythmPlayerConfigFromJson(Map<String, dynamic> json) =>
    RhythmPlayerConfig(
      beatsPerMeasure: json['beatsPerMeasure'] as int?,
      beatsPerMinute: json['beatsPerMinute'] as int?,
      publish: json['publish'] as bool?,
    );

Map<String, dynamic> _$RhythmPlayerConfigToJson(RhythmPlayerConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('beatsPerMeasure', instance.beatsPerMeasure);
  writeNotNull('beatsPerMinute', instance.beatsPerMinute);
  writeNotNull('publish', instance.publish);
  return val;
}

AudioRecordingConfiguration _$AudioRecordingConfigurationFromJson(
        Map<String, dynamic> json) =>
    AudioRecordingConfiguration(
      json['filePath'] as String,
      recordingQuality: $enumDecodeNullable(
          _$AudioRecordingQualityEnumMap, json['recordingQuality']),
      recordingPosition: $enumDecodeNullable(
          _$AudioRecordingPositionEnumMap, json['recordingPosition']),
      recordingSampleRate: $enumDecodeNullable(
          _$AudioSampleRateTypeEnumMap, json['recordingSampleRate']),
    );

Map<String, dynamic> _$AudioRecordingConfigurationToJson(
    AudioRecordingConfiguration instance) {
  final val = <String, dynamic>{
    'filePath': instance.filePath,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('recordingQuality',
      _$AudioRecordingQualityEnumMap[instance.recordingQuality]);
  writeNotNull('recordingPosition',
      _$AudioRecordingPositionEnumMap[instance.recordingPosition]);
  writeNotNull('recordingSampleRate',
      _$AudioSampleRateTypeEnumMap[instance.recordingSampleRate]);
  return val;
}

const _$AudioRecordingQualityEnumMap = {
  AudioRecordingQuality.Low: 0,
  AudioRecordingQuality.Medium: 1,
  AudioRecordingQuality.High: 2,
};

const _$AudioRecordingPositionEnumMap = {
  AudioRecordingPosition.PositionMixedRecordingAndPlayback: 0,
  AudioRecordingPosition.PositionRecording: 1,
  AudioRecordingPosition.PositionMixedPlayback: 2,
};

VirtualBackgroundSource _$VirtualBackgroundSourceFromJson(
        Map<String, dynamic> json) =>
    VirtualBackgroundSource(
      backgroundSourceType: $enumDecodeNullable(
          _$VirtualBackgroundSourceTypeEnumMap, json['background_source_type']),
      color: json['color'] as int?,
      source: json['source'] as String?,
      blurDegree: $enumDecodeNullable(
              _$VirtualBackgroundBlurDegreeEnumMap, json['blur_degree']) ??
          VirtualBackgroundBlurDegree.High,
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
      _$VirtualBackgroundSourceTypeEnumMap[instance.backgroundSourceType]);
  writeNotNull('color', instance.color);
  writeNotNull('source', instance.source);
  val['blur_degree'] =
      _$VirtualBackgroundBlurDegreeEnumMap[instance.blurDegree];
  return val;
}

const _$VirtualBackgroundSourceTypeEnumMap = {
  VirtualBackgroundSourceType.Color: 1,
  VirtualBackgroundSourceType.Img: 2,
  VirtualBackgroundSourceType.Blur: 3,
};

const _$VirtualBackgroundBlurDegreeEnumMap = {
  VirtualBackgroundBlurDegree.Low: 1,
  VirtualBackgroundBlurDegree.Medium: 2,
  VirtualBackgroundBlurDegree.High: 3,
};

AudioFileInfo _$AudioFileInfoFromJson(Map<String, dynamic> json) =>
    AudioFileInfo(
      filePath: json['filePath'] as String,
      durationMs: json['durationMs'] as int,
    );

Map<String, dynamic> _$AudioFileInfoToJson(AudioFileInfo instance) =>
    <String, dynamic>{
      'filePath': instance.filePath,
      'durationMs': instance.durationMs,
    };

EchoTestConfiguration _$EchoTestConfigurationFromJson(
        Map<String, dynamic> json) =>
    EchoTestConfiguration(
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

  writeNotNull('enableAudio', instance.enableAudio);
  writeNotNull('enableVideo', instance.enableVideo);
  writeNotNull('token', instance.token);
  writeNotNull('channelId', instance.channelId);
  return val;
}

MediaDeviceInfo _$MediaDeviceInfoFromJson(Map<String, dynamic> json) =>
    MediaDeviceInfo(
      json['deviceId'] as String,
      json['deviceName'] as String,
    );

Map<String, dynamic> _$MediaDeviceInfoToJson(MediaDeviceInfo instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'deviceName': instance.deviceName,
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
  return val;
}

Metadata _$MetadataFromJson(Map<String, dynamic> json) => Metadata(
      json['uid'] as int,
      json['timeStampMs'] as int,
    );

Map<String, dynamic> _$MetadataToJson(Metadata instance) => <String, dynamic>{
      'uid': instance.uid,
      'timeStampMs': instance.timeStampMs,
    };

MediaRecorderConfiguration _$MediaRecorderConfigurationFromJson(
        Map<String, dynamic> json) =>
    MediaRecorderConfiguration(
      storagePath: json['storagePath'] as String?,
      containerFormat: $enumDecodeNullable(
              _$MediaRecorderContainerFormatEnumMap, json['containerFormat']) ??
          MediaRecorderContainerFormat.MP4,
      streamType: $enumDecodeNullable(
              _$MediaRecorderStreamTypeEnumMap, json['streamType']) ??
          MediaRecorderStreamType.Both,
      maxDurationMs: json['maxDurationMs'] as int? ?? 120000,
      recorderInfoUpdateInterval:
          json['recorderInfoUpdateInterval'] as int? ?? 0,
    );

Map<String, dynamic> _$MediaRecorderConfigurationToJson(
        MediaRecorderConfiguration instance) =>
    <String, dynamic>{
      'storagePath': instance.storagePath,
      'containerFormat':
          _$MediaRecorderContainerFormatEnumMap[instance.containerFormat],
      'streamType': _$MediaRecorderStreamTypeEnumMap[instance.streamType],
      'maxDurationMs': instance.maxDurationMs,
      'recorderInfoUpdateInterval': instance.recorderInfoUpdateInterval,
    };

const _$MediaRecorderContainerFormatEnumMap = {
  MediaRecorderContainerFormat.MP4: 1,
  MediaRecorderContainerFormat.FLV: 2,
};

const _$MediaRecorderStreamTypeEnumMap = {
  MediaRecorderStreamType.Audio: 1,
  MediaRecorderStreamType.Video: 2,
  MediaRecorderStreamType.Both: 3,
};

RecorderInfo _$RecorderInfoFromJson(Map<String, dynamic> json) => RecorderInfo(
      json['fileName'] as String,
      json['durationMs'] as int,
      json['fileSize'] as int,
    );

Map<String, dynamic> _$RecorderInfoToJson(RecorderInfo instance) =>
    <String, dynamic>{
      'fileName': instance.fileName,
      'durationMs': instance.durationMs,
      'fileSize': instance.fileSize,
    };

LocalAccessPointConfiguration _$LocalAccessPointConfigurationFromJson(
        Map<String, dynamic> json) =>
    LocalAccessPointConfiguration(
      ipList:
          (json['ipList'] as List<dynamic>?)?.map((e) => e as String).toList(),
      domainList: (json['domainList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      verifyDomainName: json['verifyDomainName'] as String?,
      mode: $enumDecodeNullable(_$LocalProxyModeEnumMap, json['mode']) ??
          LocalProxyMode.ConnectivityFirst,
    );

Map<String, dynamic> _$LocalAccessPointConfigurationToJson(
        LocalAccessPointConfiguration instance) =>
    <String, dynamic>{
      'ipList': instance.ipList,
      'domainList': instance.domainList,
      'verifyDomainName': instance.verifyDomainName,
      'mode': _$LocalProxyModeEnumMap[instance.mode],
    };

const _$LocalProxyModeEnumMap = {
  LocalProxyMode.ConnectivityFirst: 0,
  LocalProxyMode.LocalOnly: 1,
};

LowLightEnhanceOptions _$LowLightEnhanceOptionsFromJson(
        Map<String, dynamic> json) =>
    LowLightEnhanceOptions(
      mode: $enumDecodeNullable(_$LowLightEnhanceModeEnumMap, json['mode']) ??
          LowLightEnhanceMode.Auto,
      level:
          $enumDecodeNullable(_$LowLightEnhanceLevelEnumMap, json['level']) ??
              LowLightEnhanceLevel.HighQuality,
    );

Map<String, dynamic> _$LowLightEnhanceOptionsToJson(
        LowLightEnhanceOptions instance) =>
    <String, dynamic>{
      'mode': _$LowLightEnhanceModeEnumMap[instance.mode],
      'level': _$LowLightEnhanceLevelEnumMap[instance.level],
    };

const _$LowLightEnhanceModeEnumMap = {
  LowLightEnhanceMode.Auto: 0,
  LowLightEnhanceMode.Manual: 1,
};

const _$LowLightEnhanceLevelEnumMap = {
  LowLightEnhanceLevel.HighQuality: 0,
  LowLightEnhanceLevel.Fast: 1,
};

VideoDenoiserOptions _$VideoDenoiserOptionsFromJson(
        Map<String, dynamic> json) =>
    VideoDenoiserOptions(
      mode: $enumDecodeNullable(_$VideoDenoiserModeEnumMap, json['mode']) ??
          VideoDenoiserMode.Auto,
      level: $enumDecodeNullable(_$VideoDenoiserLevelEnumMap, json['level']) ??
          VideoDenoiserLevel.HighQuality,
    );

Map<String, dynamic> _$VideoDenoiserOptionsToJson(
        VideoDenoiserOptions instance) =>
    <String, dynamic>{
      'mode': _$VideoDenoiserModeEnumMap[instance.mode],
      'level': _$VideoDenoiserLevelEnumMap[instance.level],
    };

const _$VideoDenoiserModeEnumMap = {
  VideoDenoiserMode.Auto: 0,
  VideoDenoiserMode.Manual: 1,
};

const _$VideoDenoiserLevelEnumMap = {
  VideoDenoiserLevel.HighQuality: 0,
  VideoDenoiserLevel.Fast: 1,
  VideoDenoiserLevel.Strength: 2,
};

ColorEnhanceOptions _$ColorEnhanceOptionsFromJson(Map<String, dynamic> json) =>
    ColorEnhanceOptions(
      strengthLevel: (json['strengthLevel'] as num?)?.toDouble() ?? 0.0,
      skinProtectLevel: (json['skinProtectLevel'] as num?)?.toDouble() ?? 1.0,
    );

Map<String, dynamic> _$ColorEnhanceOptionsToJson(
        ColorEnhanceOptions instance) =>
    <String, dynamic>{
      'strengthLevel': instance.strengthLevel,
      'skinProtectLevel': instance.skinProtectLevel,
    };

ScreenCaptureInfo _$ScreenCaptureInfoFromJson(Map<String, dynamic> json) =>
    ScreenCaptureInfo(
      json['graphicsCardType'] as String,
      $enumDecode(_$ExcludeWindowErrorEnumMap, json['errCode']),
    );

Map<String, dynamic> _$ScreenCaptureInfoToJson(ScreenCaptureInfo instance) =>
    <String, dynamic>{
      'graphicsCardType': instance.graphicsCardType,
      'errCode': _$ExcludeWindowErrorEnumMap[instance.errCode],
    };

const _$ExcludeWindowErrorEnumMap = {
  ExcludeWindowError.Fail: -1,
  ExcludeWindowError.None: 0,
};

WlAccStats _$WlAccStatsFromJson(Map<String, dynamic> json) => WlAccStats(
      json['e2eDelayPercent'] as int,
      json['frozenRatioPercent'] as int,
      json['lossRatePercent'] as int,
    );

Map<String, dynamic> _$WlAccStatsToJson(WlAccStats instance) =>
    <String, dynamic>{
      'e2eDelayPercent': instance.e2eDelayPercent,
      'frozenRatioPercent': instance.frozenRatioPercent,
      'lossRatePercent': instance.lossRatePercent,
    };
