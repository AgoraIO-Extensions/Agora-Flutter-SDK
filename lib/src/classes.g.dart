// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo()
    ..uid = json['uid'] as int
    ..userAccount = json['userAccount'] as String;
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'uid': instance.uid,
      'userAccount': instance.userAccount,
    };

VideoDimensions _$VideoDimensionsFromJson(Map<String, dynamic> json) {
  return VideoDimensions(
    json['width'] as int,
    json['height'] as int,
  );
}

Map<String, dynamic> _$VideoDimensionsToJson(VideoDimensions instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
    };

VideoEncoderConfiguration _$VideoEncoderConfigurationFromJson(
    Map<String, dynamic> json) {
  return VideoEncoderConfiguration(
    dimensions: json['dimensions'] == null
        ? null
        : VideoDimensions.fromJson(json['dimensions'] as Map<String, dynamic>),
    frameRate: _$enumDecodeNullable(_$VideoFrameRateEnumMap, json['frameRate']),
    minFrameRate:
        _$enumDecodeNullable(_$VideoFrameRateEnumMap, json['minFrameRate']),
    bitrate: json['bitrate'] as int,
    minBitrate: json['minBitrate'] as int,
    orientationMode: _$enumDecodeNullable(
        _$VideoOutputOrientationModeEnumMap, json['orientationMode']),
    degradationPrefer: _$enumDecodeNullable(
        _$DegradationPreferenceEnumMap, json['degradationPrefer']),
    mirrorMode:
        _$enumDecodeNullable(_$VideoMirrorModeEnumMap, json['mirrorMode']),
  );
}

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
  writeNotNull('degradationPrefer',
      _$DegradationPreferenceEnumMap[instance.degradationPrefer]);
  writeNotNull('mirrorMode', _$VideoMirrorModeEnumMap[instance.mirrorMode]);
  return val;
}

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$VideoFrameRateEnumMap = {
  VideoFrameRate.Min: -1,
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
  DegradationPreference.Balanced: 2,
};

const _$VideoMirrorModeEnumMap = {
  VideoMirrorMode.Auto: 0,
  VideoMirrorMode.Enabled: 1,
  VideoMirrorMode.Disabled: 2,
};

BeautyOptions _$BeautyOptionsFromJson(Map<String, dynamic> json) {
  return BeautyOptions(
    lighteningContrastLevel: _$enumDecodeNullable(
        _$LighteningContrastLevelEnumMap, json['lighteningContrastLevel']),
    lighteningLevel: (json['lighteningLevel'] as num)?.toDouble(),
    smoothnessLevel: (json['smoothnessLevel'] as num)?.toDouble(),
    rednessLevel: (json['rednessLevel'] as num)?.toDouble(),
  );
}

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

AgoraImage _$AgoraImageFromJson(Map<String, dynamic> json) {
  return AgoraImage(
    json['url'] as String,
    json['x'] as int,
    json['y'] as int,
    json['width'] as int,
    json['height'] as int,
  );
}

Map<String, dynamic> _$AgoraImageToJson(AgoraImage instance) =>
    <String, dynamic>{
      'url': instance.url,
      'x': instance.x,
      'y': instance.y,
      'width': instance.width,
      'height': instance.height,
    };

TranscodingUser _$TranscodingUserFromJson(Map<String, dynamic> json) {
  return TranscodingUser(
    json['uid'] as int,
    json['x'] as int,
    json['y'] as int,
    width: json['width'] as int,
    height: json['height'] as int,
    zOrder: json['zOrder'] as int,
    alpha: (json['alpha'] as num)?.toDouble(),
    audioChannel:
        _$enumDecodeNullable(_$AudioChannelEnumMap, json['audioChannel']),
  );
}

Map<String, dynamic> _$TranscodingUserToJson(TranscodingUser instance) {
  final val = <String, dynamic>{
    'uid': instance.uid,
    'x': instance.x,
    'y': instance.y,
    'width': instance.width,
    'height': instance.height,
    'zOrder': instance.zOrder,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('alpha', instance.alpha);
  val['audioChannel'] = _$AudioChannelEnumMap[instance.audioChannel];
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

Color _$ColorFromJson(Map<String, dynamic> json) {
  return Color(
    json['red'] as int,
    json['green'] as int,
    json['blue'] as int,
  );
}

Map<String, dynamic> _$ColorToJson(Color instance) => <String, dynamic>{
      'red': instance.red,
      'green': instance.green,
      'blue': instance.blue,
    };

LiveTranscoding _$LiveTranscodingFromJson(Map<String, dynamic> json) {
  return LiveTranscoding(
    (json['transcodingUsers'] as List)
        ?.map((e) => e == null
            ? null
            : TranscodingUser.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    width: json['width'] as int,
    height: json['height'] as int,
    videoBitrate: json['videoBitrate'] as int,
    videoFramerate:
        _$enumDecodeNullable(_$VideoFrameRateEnumMap, json['videoFramerate']),
    lowLatency: json['lowLatency'] as bool,
    videoGop: json['videoGop'] as int,
    watermark: json['watermark'] == null
        ? null
        : AgoraImage.fromJson(json['watermark'] as Map<String, dynamic>),
    backgroundImage: json['backgroundImage'] == null
        ? null
        : AgoraImage.fromJson(json['backgroundImage'] as Map<String, dynamic>),
    audioSampleRate: _$enumDecodeNullable(
        _$AudioSampleRateTypeEnumMap, json['audioSampleRate']),
    audioBitrate: json['audioBitrate'] as int,
    audioChannels:
        _$enumDecodeNullable(_$AudioChannelEnumMap, json['audioChannels']),
    audioCodecProfile: _$enumDecodeNullable(
        _$AudioCodecProfileTypeEnumMap, json['audioCodecProfile']),
    videoCodecProfile: _$enumDecodeNullable(
        _$VideoCodecProfileTypeEnumMap, json['videoCodecProfile']),
    backgroundColor: json['backgroundColor'] == null
        ? null
        : Color.fromJson(json['backgroundColor'] as Map<String, dynamic>),
    userConfigExtraInfo: json['userConfigExtraInfo'] as String,
  );
}

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
  writeNotNull('watermark', instance.watermark?.toJson());
  writeNotNull('backgroundImage', instance.backgroundImage?.toJson());
  writeNotNull('audioSampleRate',
      _$AudioSampleRateTypeEnumMap[instance.audioSampleRate]);
  writeNotNull('audioBitrate', instance.audioBitrate);
  writeNotNull('audioChannels', _$AudioChannelEnumMap[instance.audioChannels]);
  writeNotNull('audioCodecProfile',
      _$AudioCodecProfileTypeEnumMap[instance.audioCodecProfile]);
  writeNotNull('videoCodecProfile',
      _$VideoCodecProfileTypeEnumMap[instance.videoCodecProfile]);
  writeNotNull('backgroundColor', instance.backgroundColor?.toJson());
  writeNotNull('userConfigExtraInfo', instance.userConfigExtraInfo);
  val['transcodingUsers'] =
      instance.transcodingUsers?.map((e) => e?.toJson())?.toList();
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

ChannelMediaInfo _$ChannelMediaInfoFromJson(Map<String, dynamic> json) {
  return ChannelMediaInfo(
    json['uid'] as int,
    channelName: json['channelName'] as String,
    token: json['token'] as String,
  );
}

Map<String, dynamic> _$ChannelMediaInfoToJson(ChannelMediaInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('channelName', instance.channelName);
  writeNotNull('token', instance.token);
  val['uid'] = instance.uid;
  return val;
}

ChannelMediaRelayConfiguration _$ChannelMediaRelayConfigurationFromJson(
    Map<String, dynamic> json) {
  return ChannelMediaRelayConfiguration(
    json['srcInfo'] == null
        ? null
        : ChannelMediaInfo.fromJson(json['srcInfo'] as Map<String, dynamic>),
    (json['destInfos'] as List)
        ?.map((e) => e == null
            ? null
            : ChannelMediaInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ChannelMediaRelayConfigurationToJson(
        ChannelMediaRelayConfiguration instance) =>
    <String, dynamic>{
      'srcInfo': instance.srcInfo?.toJson(),
      'destInfos': instance.destInfos?.map((e) => e?.toJson())?.toList(),
    };

LastmileProbeConfig _$LastmileProbeConfigFromJson(Map<String, dynamic> json) {
  return LastmileProbeConfig(
    json['probeUplink'] as bool,
    json['probeDownlink'] as bool,
    json['expectedUplinkBitrate'] as int,
    json['expectedDownlinkBitrate'] as int,
  );
}

Map<String, dynamic> _$LastmileProbeConfigToJson(
        LastmileProbeConfig instance) =>
    <String, dynamic>{
      'probeUplink': instance.probeUplink,
      'probeDownlink': instance.probeDownlink,
      'expectedUplinkBitrate': instance.expectedUplinkBitrate,
      'expectedDownlinkBitrate': instance.expectedDownlinkBitrate,
    };

Rectangle _$RectangleFromJson(Map<String, dynamic> json) {
  return Rectangle(
    json['x'] as int,
    json['y'] as int,
    json['width'] as int,
    json['height'] as int,
  );
}

Map<String, dynamic> _$RectangleToJson(Rectangle instance) => <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'width': instance.width,
      'height': instance.height,
    };

WatermarkOptions _$WatermarkOptionsFromJson(Map<String, dynamic> json) {
  return WatermarkOptions(
    json['positionInLandscapeMode'] == null
        ? null
        : Rectangle.fromJson(
            json['positionInLandscapeMode'] as Map<String, dynamic>),
    json['positionInPortraitMode'] == null
        ? null
        : Rectangle.fromJson(
            json['positionInPortraitMode'] as Map<String, dynamic>),
    visibleInPreview: json['visibleInPreview'] as bool,
  );
}

Map<String, dynamic> _$WatermarkOptionsToJson(WatermarkOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('visibleInPreview', instance.visibleInPreview);
  val['positionInLandscapeMode'] = instance.positionInLandscapeMode?.toJson();
  val['positionInPortraitMode'] = instance.positionInPortraitMode?.toJson();
  return val;
}

LiveInjectStreamConfig _$LiveInjectStreamConfigFromJson(
    Map<String, dynamic> json) {
  return LiveInjectStreamConfig(
    width: json['width'] as int,
    height: json['height'] as int,
    videoGop: json['videoGop'] as int,
    videoFramerate:
        _$enumDecodeNullable(_$VideoFrameRateEnumMap, json['videoFramerate']),
    videoBitrate: json['videoBitrate'] as int,
    audioSampleRate: _$enumDecodeNullable(
        _$AudioSampleRateTypeEnumMap, json['audioSampleRate']),
    audioBitrate: json['audioBitrate'] as int,
    audioChannels:
        _$enumDecodeNullable(_$AudioChannelEnumMap, json['audioChannels']),
  );
}

Map<String, dynamic> _$LiveInjectStreamConfigToJson(
    LiveInjectStreamConfig instance) {
  final val = <String, dynamic>{
    'width': instance.width,
    'height': instance.height,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

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
    Map<String, dynamic> json) {
  return CameraCapturerConfiguration(
    _$enumDecodeNullable(
        _$CameraCaptureOutputPreferenceEnumMap, json['preference']),
    _$enumDecodeNullable(_$CameraDirectionEnumMap, json['cameraDirection']),
  );
}

Map<String, dynamic> _$CameraCapturerConfigurationToJson(
        CameraCapturerConfiguration instance) =>
    <String, dynamic>{
      'preference': _$CameraCaptureOutputPreferenceEnumMap[instance.preference],
      'cameraDirection': _$CameraDirectionEnumMap[instance.cameraDirection],
    };

const _$CameraCaptureOutputPreferenceEnumMap = {
  CameraCaptureOutputPreference.Auto: 0,
  CameraCaptureOutputPreference.Performance: 1,
  CameraCaptureOutputPreference.Preview: 2,
  CameraCaptureOutputPreference.Unkown: 3,
};

const _$CameraDirectionEnumMap = {
  CameraDirection.Rear: 0,
  CameraDirection.Front: 1,
};

ChannelMediaOptions _$ChannelMediaOptionsFromJson(Map<String, dynamic> json) {
  return ChannelMediaOptions(
    json['autoSubscribeAudio'] as bool,
    json['autoSubscribeVideo'] as bool,
  );
}

Map<String, dynamic> _$ChannelMediaOptionsToJson(
        ChannelMediaOptions instance) =>
    <String, dynamic>{
      'autoSubscribeAudio': instance.autoSubscribeAudio,
      'autoSubscribeVideo': instance.autoSubscribeVideo,
    };

EncryptionConfig _$EncryptionConfigFromJson(Map<String, dynamic> json) {
  return EncryptionConfig(
    _$enumDecodeNullable(_$EncryptionModeEnumMap, json['encryptionMode']),
    json['encryptionKey'] as String,
  );
}

Map<String, dynamic> _$EncryptionConfigToJson(EncryptionConfig instance) =>
    <String, dynamic>{
      'encryptionMode': _$EncryptionModeEnumMap[instance.encryptionMode],
      'encryptionKey': instance.encryptionKey,
    };

const _$EncryptionModeEnumMap = {
  EncryptionMode.None: 0,
  EncryptionMode.AES128XTS: 1,
  EncryptionMode.AES128ECB: 2,
  EncryptionMode.AES256XTS: 3,
  EncryptionMode.SM4128ECB: 4,
};

RtcStats _$RtcStatsFromJson(Map<String, dynamic> json) {
  return RtcStats()
    ..totalDuration = json['totalDuration'] as int
    ..txBytes = json['txBytes'] as int
    ..rxBytes = json['rxBytes'] as int
    ..txAudioBytes = json['txAudioBytes'] as int
    ..txVideoBytes = json['txVideoBytes'] as int
    ..rxAudioBytes = json['rxAudioBytes'] as int
    ..rxVideoBytes = json['rxVideoBytes'] as int
    ..txKBitRate = json['txKBitRate'] as int
    ..rxKBitRate = json['rxKBitRate'] as int
    ..txAudioKBitRate = json['txAudioKBitRate'] as int
    ..rxAudioKBitRate = json['rxAudioKBitRate'] as int
    ..txVideoKBitRate = json['txVideoKBitRate'] as int
    ..rxVideoKBitRate = json['rxVideoKBitRate'] as int
    ..users = json['users'] as int
    ..lastmileDelay = json['lastmileDelay'] as int
    ..txPacketLossRate = json['txPacketLossRate'] as int
    ..rxPacketLossRate = json['rxPacketLossRate'] as int
    ..cpuTotalUsage = (json['cpuTotalUsage'] as num)?.toDouble()
    ..cpuAppUsage = (json['cpuAppUsage'] as num)?.toDouble()
    ..gatewayRtt = json['gatewayRtt'] as int
    ..memoryAppUsageRatio = (json['memoryAppUsageRatio'] as num)?.toDouble()
    ..memoryTotalUsageRatio = (json['memoryTotalUsageRatio'] as num)?.toDouble()
    ..memoryAppUsageInKbytes = json['memoryAppUsageInKbytes'] as int;
}

Map<String, dynamic> _$RtcStatsToJson(RtcStats instance) => <String, dynamic>{
      'totalDuration': instance.totalDuration,
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
      'users': instance.users,
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

AudioVolumeInfo _$AudioVolumeInfoFromJson(Map<String, dynamic> json) {
  return AudioVolumeInfo()
    ..uid = json['uid'] as int
    ..volume = json['volume'] as int
    ..vad = json['vad'] as int
    ..channelId = json['channelId'] as String;
}

Map<String, dynamic> _$AudioVolumeInfoToJson(AudioVolumeInfo instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'volume': instance.volume,
      'vad': instance.vad,
      'channelId': instance.channelId,
    };

Rect _$RectFromJson(Map<String, dynamic> json) {
  return Rect()
    ..left = json['left'] as int
    ..top = json['top'] as int
    ..right = json['right'] as int
    ..bottom = json['bottom'] as int;
}

Map<String, dynamic> _$RectToJson(Rect instance) => <String, dynamic>{
      'left': instance.left,
      'top': instance.top,
      'right': instance.right,
      'bottom': instance.bottom,
    };

LastmileProbeOneWayResult _$LastmileProbeOneWayResultFromJson(
    Map<String, dynamic> json) {
  return LastmileProbeOneWayResult()
    ..packetLossRate = json['packetLossRate'] as int
    ..jitter = json['jitter'] as int
    ..availableBandwidth = json['availableBandwidth'] as int;
}

Map<String, dynamic> _$LastmileProbeOneWayResultToJson(
        LastmileProbeOneWayResult instance) =>
    <String, dynamic>{
      'packetLossRate': instance.packetLossRate,
      'jitter': instance.jitter,
      'availableBandwidth': instance.availableBandwidth,
    };

LastmileProbeResult _$LastmileProbeResultFromJson(Map<String, dynamic> json) {
  return LastmileProbeResult()
    ..state =
        _$enumDecodeNullable(_$LastmileProbeResultStateEnumMap, json['state'])
    ..rtt = json['rtt'] as int
    ..uplinkReport = json['uplinkReport'] == null
        ? null
        : LastmileProbeOneWayResult.fromJson(
            json['uplinkReport'] as Map<String, dynamic>)
    ..downlinkReport = json['downlinkReport'] == null
        ? null
        : LastmileProbeOneWayResult.fromJson(
            json['downlinkReport'] as Map<String, dynamic>);
}

Map<String, dynamic> _$LastmileProbeResultToJson(
        LastmileProbeResult instance) =>
    <String, dynamic>{
      'state': _$LastmileProbeResultStateEnumMap[instance.state],
      'rtt': instance.rtt,
      'uplinkReport': instance.uplinkReport?.toJson(),
      'downlinkReport': instance.downlinkReport?.toJson(),
    };

const _$LastmileProbeResultStateEnumMap = {
  LastmileProbeResultState.Complete: 1,
  LastmileProbeResultState.IncompleteNoBwe: 2,
  LastmileProbeResultState.Unavailable: 3,
};

LocalAudioStats _$LocalAudioStatsFromJson(Map<String, dynamic> json) {
  return LocalAudioStats()
    ..numChannels = json['numChannels'] as int
    ..sentSampleRate = json['sentSampleRate'] as int
    ..sentBitrate = json['sentBitrate'] as int;
}

Map<String, dynamic> _$LocalAudioStatsToJson(LocalAudioStats instance) =>
    <String, dynamic>{
      'numChannels': instance.numChannels,
      'sentSampleRate': instance.sentSampleRate,
      'sentBitrate': instance.sentBitrate,
    };

LocalVideoStats _$LocalVideoStatsFromJson(Map<String, dynamic> json) {
  return LocalVideoStats()
    ..sentBitrate = json['sentBitrate'] as int
    ..sentFrameRate = json['sentFrameRate'] as int
    ..encoderOutputFrameRate = json['encoderOutputFrameRate'] as int
    ..rendererOutputFrameRate = json['rendererOutputFrameRate'] as int
    ..targetBitrate = json['targetBitrate'] as int
    ..targetFrameRate = json['targetFrameRate'] as int
    ..qualityAdaptIndication = _$enumDecodeNullable(
        _$VideoQualityAdaptIndicationEnumMap, json['qualityAdaptIndication'])
    ..encodedBitrate = json['encodedBitrate'] as int
    ..encodedFrameWidth = json['encodedFrameWidth'] as int
    ..encodedFrameHeight = json['encodedFrameHeight'] as int
    ..encodedFrameCount = json['encodedFrameCount'] as int
    ..codecType =
        _$enumDecodeNullable(_$VideoCodecTypeEnumMap, json['codecType']);
}

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

RemoteAudioStats _$RemoteAudioStatsFromJson(Map<String, dynamic> json) {
  return RemoteAudioStats()
    ..uid = json['uid'] as int
    ..quality = _$enumDecodeNullable(_$NetworkQualityEnumMap, json['quality'])
    ..networkTransportDelay = json['networkTransportDelay'] as int
    ..jitterBufferDelay = json['jitterBufferDelay'] as int
    ..audioLossRate = json['audioLossRate'] as int
    ..numChannels = json['numChannels'] as int
    ..receivedSampleRate = json['receivedSampleRate'] as int
    ..receivedBitrate = json['receivedBitrate'] as int
    ..totalFrozenTime = json['totalFrozenTime'] as int
    ..frozenRate = json['frozenRate'] as int;
}

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

RemoteVideoStats _$RemoteVideoStatsFromJson(Map<String, dynamic> json) {
  return RemoteVideoStats()
    ..uid = json['uid'] as int
    ..delay = json['delay'] as int
    ..width = json['width'] as int
    ..height = json['height'] as int
    ..receivedBitrate = json['receivedBitrate'] as int
    ..decoderOutputFrameRate = json['decoderOutputFrameRate'] as int
    ..rendererOutputFrameRate = json['rendererOutputFrameRate'] as int
    ..packetLossRate = json['packetLossRate'] as int
    ..rxStreamType =
        _$enumDecodeNullable(_$VideoStreamTypeEnumMap, json['rxStreamType'])
    ..totalFrozenTime = json['totalFrozenTime'] as int
    ..frozenRate = json['frozenRate'] as int;
}

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
    };

const _$VideoStreamTypeEnumMap = {
  VideoStreamType.High: 0,
  VideoStreamType.Low: 1,
};

FacePositionInfo _$FacePositionInfoFromJson(Map<String, dynamic> json) {
  return FacePositionInfo()
    ..x = json['x'] as int
    ..y = json['y'] as int
    ..width = json['width'] as int
    ..height = json['height'] as int
    ..distance = json['distance'] as int;
}

Map<String, dynamic> _$FacePositionInfoToJson(FacePositionInfo instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'width': instance.width,
      'height': instance.height,
      'distance': instance.distance,
    };
