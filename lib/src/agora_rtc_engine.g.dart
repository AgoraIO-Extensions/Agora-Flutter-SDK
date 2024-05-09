// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names, deprecated_member_use_from_same_package, unused_element

part of 'agora_rtc_engine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalVideoStats _$LocalVideoStatsFromJson(Map<String, dynamic> json) =>
    LocalVideoStats(
      uid: (json['uid'] as num?)?.toInt(),
      sentBitrate: (json['sentBitrate'] as num?)?.toInt(),
      sentFrameRate: (json['sentFrameRate'] as num?)?.toInt(),
      captureFrameRate: (json['captureFrameRate'] as num?)?.toInt(),
      captureFrameWidth: (json['captureFrameWidth'] as num?)?.toInt(),
      captureFrameHeight: (json['captureFrameHeight'] as num?)?.toInt(),
      regulatedCaptureFrameRate:
          (json['regulatedCaptureFrameRate'] as num?)?.toInt(),
      regulatedCaptureFrameWidth:
          (json['regulatedCaptureFrameWidth'] as num?)?.toInt(),
      regulatedCaptureFrameHeight:
          (json['regulatedCaptureFrameHeight'] as num?)?.toInt(),
      encoderOutputFrameRate: (json['encoderOutputFrameRate'] as num?)?.toInt(),
      encodedFrameWidth: (json['encodedFrameWidth'] as num?)?.toInt(),
      encodedFrameHeight: (json['encodedFrameHeight'] as num?)?.toInt(),
      rendererOutputFrameRate:
          (json['rendererOutputFrameRate'] as num?)?.toInt(),
      targetBitrate: (json['targetBitrate'] as num?)?.toInt(),
      targetFrameRate: (json['targetFrameRate'] as num?)?.toInt(),
      qualityAdaptIndication: $enumDecodeNullable(
          _$QualityAdaptIndicationEnumMap, json['qualityAdaptIndication']),
      encodedBitrate: (json['encodedBitrate'] as num?)?.toInt(),
      encodedFrameCount: (json['encodedFrameCount'] as num?)?.toInt(),
      codecType:
          $enumDecodeNullable(_$VideoCodecTypeEnumMap, json['codecType']),
      txPacketLossRate: (json['txPacketLossRate'] as num?)?.toInt(),
      captureBrightnessLevel: $enumDecodeNullable(
          _$CaptureBrightnessLevelTypeEnumMap, json['captureBrightnessLevel']),
      dualStreamEnabled: json['dualStreamEnabled'] as bool?,
      hwEncoderAccelerating: (json['hwEncoderAccelerating'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LocalVideoStatsToJson(LocalVideoStats instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uid', instance.uid);
  writeNotNull('sentBitrate', instance.sentBitrate);
  writeNotNull('sentFrameRate', instance.sentFrameRate);
  writeNotNull('captureFrameRate', instance.captureFrameRate);
  writeNotNull('captureFrameWidth', instance.captureFrameWidth);
  writeNotNull('captureFrameHeight', instance.captureFrameHeight);
  writeNotNull('regulatedCaptureFrameRate', instance.regulatedCaptureFrameRate);
  writeNotNull(
      'regulatedCaptureFrameWidth', instance.regulatedCaptureFrameWidth);
  writeNotNull(
      'regulatedCaptureFrameHeight', instance.regulatedCaptureFrameHeight);
  writeNotNull('encoderOutputFrameRate', instance.encoderOutputFrameRate);
  writeNotNull('encodedFrameWidth', instance.encodedFrameWidth);
  writeNotNull('encodedFrameHeight', instance.encodedFrameHeight);
  writeNotNull('rendererOutputFrameRate', instance.rendererOutputFrameRate);
  writeNotNull('targetBitrate', instance.targetBitrate);
  writeNotNull('targetFrameRate', instance.targetFrameRate);
  writeNotNull('qualityAdaptIndication',
      _$QualityAdaptIndicationEnumMap[instance.qualityAdaptIndication]);
  writeNotNull('encodedBitrate', instance.encodedBitrate);
  writeNotNull('encodedFrameCount', instance.encodedFrameCount);
  writeNotNull('codecType', _$VideoCodecTypeEnumMap[instance.codecType]);
  writeNotNull('txPacketLossRate', instance.txPacketLossRate);
  writeNotNull('captureBrightnessLevel',
      _$CaptureBrightnessLevelTypeEnumMap[instance.captureBrightnessLevel]);
  writeNotNull('dualStreamEnabled', instance.dualStreamEnabled);
  writeNotNull('hwEncoderAccelerating', instance.hwEncoderAccelerating);
  return val;
}

const _$QualityAdaptIndicationEnumMap = {
  QualityAdaptIndication.adaptNone: 0,
  QualityAdaptIndication.adaptUpBandwidth: 1,
  QualityAdaptIndication.adaptDownBandwidth: 2,
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

const _$CaptureBrightnessLevelTypeEnumMap = {
  CaptureBrightnessLevelType.captureBrightnessLevelInvalid: -1,
  CaptureBrightnessLevelType.captureBrightnessLevelNormal: 0,
  CaptureBrightnessLevelType.captureBrightnessLevelBright: 1,
  CaptureBrightnessLevelType.captureBrightnessLevelDark: 2,
};

RemoteAudioStats _$RemoteAudioStatsFromJson(Map<String, dynamic> json) =>
    RemoteAudioStats(
      uid: (json['uid'] as num?)?.toInt(),
      quality: (json['quality'] as num?)?.toInt(),
      networkTransportDelay: (json['networkTransportDelay'] as num?)?.toInt(),
      jitterBufferDelay: (json['jitterBufferDelay'] as num?)?.toInt(),
      audioLossRate: (json['audioLossRate'] as num?)?.toInt(),
      numChannels: (json['numChannels'] as num?)?.toInt(),
      receivedSampleRate: (json['receivedSampleRate'] as num?)?.toInt(),
      receivedBitrate: (json['receivedBitrate'] as num?)?.toInt(),
      totalFrozenTime: (json['totalFrozenTime'] as num?)?.toInt(),
      frozenRate: (json['frozenRate'] as num?)?.toInt(),
      mosValue: (json['mosValue'] as num?)?.toInt(),
      frozenRateByCustomPlcCount:
          (json['frozenRateByCustomPlcCount'] as num?)?.toInt(),
      plcCount: (json['plcCount'] as num?)?.toInt(),
      totalActiveTime: (json['totalActiveTime'] as num?)?.toInt(),
      publishDuration: (json['publishDuration'] as num?)?.toInt(),
      qoeQuality: (json['qoeQuality'] as num?)?.toInt(),
      qualityChangedReason: (json['qualityChangedReason'] as num?)?.toInt(),
      rxAudioBytes: (json['rxAudioBytes'] as num?)?.toInt(),
      e2eDelay: (json['e2eDelay'] as num?)?.toInt(),
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
  writeNotNull(
      'frozenRateByCustomPlcCount', instance.frozenRateByCustomPlcCount);
  writeNotNull('plcCount', instance.plcCount);
  writeNotNull('totalActiveTime', instance.totalActiveTime);
  writeNotNull('publishDuration', instance.publishDuration);
  writeNotNull('qoeQuality', instance.qoeQuality);
  writeNotNull('qualityChangedReason', instance.qualityChangedReason);
  writeNotNull('rxAudioBytes', instance.rxAudioBytes);
  writeNotNull('e2eDelay', instance.e2eDelay);
  return val;
}

RemoteVideoStats _$RemoteVideoStatsFromJson(Map<String, dynamic> json) =>
    RemoteVideoStats(
      uid: (json['uid'] as num?)?.toInt(),
      delay: (json['delay'] as num?)?.toInt(),
      e2eDelay: (json['e2eDelay'] as num?)?.toInt(),
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      receivedBitrate: (json['receivedBitrate'] as num?)?.toInt(),
      decoderOutputFrameRate: (json['decoderOutputFrameRate'] as num?)?.toInt(),
      rendererOutputFrameRate:
          (json['rendererOutputFrameRate'] as num?)?.toInt(),
      frameLossRate: (json['frameLossRate'] as num?)?.toInt(),
      packetLossRate: (json['packetLossRate'] as num?)?.toInt(),
      rxStreamType:
          $enumDecodeNullable(_$VideoStreamTypeEnumMap, json['rxStreamType']),
      totalFrozenTime: (json['totalFrozenTime'] as num?)?.toInt(),
      frozenRate: (json['frozenRate'] as num?)?.toInt(),
      avSyncTimeMs: (json['avSyncTimeMs'] as num?)?.toInt(),
      totalActiveTime: (json['totalActiveTime'] as num?)?.toInt(),
      publishDuration: (json['publishDuration'] as num?)?.toInt(),
      mosValue: (json['mosValue'] as num?)?.toInt(),
      rxVideoBytes: (json['rxVideoBytes'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RemoteVideoStatsToJson(RemoteVideoStats instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uid', instance.uid);
  writeNotNull('delay', instance.delay);
  writeNotNull('e2eDelay', instance.e2eDelay);
  writeNotNull('width', instance.width);
  writeNotNull('height', instance.height);
  writeNotNull('receivedBitrate', instance.receivedBitrate);
  writeNotNull('decoderOutputFrameRate', instance.decoderOutputFrameRate);
  writeNotNull('rendererOutputFrameRate', instance.rendererOutputFrameRate);
  writeNotNull('frameLossRate', instance.frameLossRate);
  writeNotNull('packetLossRate', instance.packetLossRate);
  writeNotNull('rxStreamType', _$VideoStreamTypeEnumMap[instance.rxStreamType]);
  writeNotNull('totalFrozenTime', instance.totalFrozenTime);
  writeNotNull('frozenRate', instance.frozenRate);
  writeNotNull('avSyncTimeMs', instance.avSyncTimeMs);
  writeNotNull('totalActiveTime', instance.totalActiveTime);
  writeNotNull('publishDuration', instance.publishDuration);
  writeNotNull('mosValue', instance.mosValue);
  writeNotNull('rxVideoBytes', instance.rxVideoBytes);
  return val;
}

const _$VideoStreamTypeEnumMap = {
  VideoStreamType.videoStreamHigh: 0,
  VideoStreamType.videoStreamLow: 1,
};

VideoCompositingLayout _$VideoCompositingLayoutFromJson(
        Map<String, dynamic> json) =>
    VideoCompositingLayout(
      canvasWidth: (json['canvasWidth'] as num?)?.toInt(),
      canvasHeight: (json['canvasHeight'] as num?)?.toInt(),
      backgroundColor: json['backgroundColor'] as String?,
      regions: (json['regions'] as List<dynamic>?)
          ?.map((e) => Region.fromJson(e as Map<String, dynamic>))
          .toList(),
      regionCount: (json['regionCount'] as num?)?.toInt(),
      appDataLength: (json['appDataLength'] as num?)?.toInt(),
    );

Map<String, dynamic> _$VideoCompositingLayoutToJson(
    VideoCompositingLayout instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('canvasWidth', instance.canvasWidth);
  writeNotNull('canvasHeight', instance.canvasHeight);
  writeNotNull('backgroundColor', instance.backgroundColor);
  writeNotNull('regions', instance.regions?.map((e) => e.toJson()).toList());
  writeNotNull('regionCount', instance.regionCount);
  writeNotNull('appDataLength', instance.appDataLength);
  return val;
}

Region _$RegionFromJson(Map<String, dynamic> json) => Region(
      uid: (json['uid'] as num?)?.toInt(),
      x: (json['x'] as num?)?.toDouble(),
      y: (json['y'] as num?)?.toDouble(),
      width: (json['width'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      zOrder: (json['zOrder'] as num?)?.toInt(),
      alpha: (json['alpha'] as num?)?.toDouble(),
      renderMode:
          $enumDecodeNullable(_$RenderModeTypeEnumMap, json['renderMode']),
    );

Map<String, dynamic> _$RegionToJson(Region instance) {
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
  writeNotNull('renderMode', _$RenderModeTypeEnumMap[instance.renderMode]);
  return val;
}

const _$RenderModeTypeEnumMap = {
  RenderModeType.renderModeHidden: 1,
  RenderModeType.renderModeFit: 2,
  RenderModeType.renderModeAdaptive: 3,
};

InjectStreamConfig _$InjectStreamConfigFromJson(Map<String, dynamic> json) =>
    InjectStreamConfig(
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      videoGop: (json['videoGop'] as num?)?.toInt(),
      videoFramerate: (json['videoFramerate'] as num?)?.toInt(),
      videoBitrate: (json['videoBitrate'] as num?)?.toInt(),
      audioSampleRate: $enumDecodeNullable(
          _$AudioSampleRateTypeEnumMap, json['audioSampleRate']),
      audioBitrate: (json['audioBitrate'] as num?)?.toInt(),
      audioChannels: (json['audioChannels'] as num?)?.toInt(),
    );

Map<String, dynamic> _$InjectStreamConfigToJson(InjectStreamConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('width', instance.width);
  writeNotNull('height', instance.height);
  writeNotNull('videoGop', instance.videoGop);
  writeNotNull('videoFramerate', instance.videoFramerate);
  writeNotNull('videoBitrate', instance.videoBitrate);
  writeNotNull('audioSampleRate',
      _$AudioSampleRateTypeEnumMap[instance.audioSampleRate]);
  writeNotNull('audioBitrate', instance.audioBitrate);
  writeNotNull('audioChannels', instance.audioChannels);
  return val;
}

const _$AudioSampleRateTypeEnumMap = {
  AudioSampleRateType.audioSampleRate32000: 32000,
  AudioSampleRateType.audioSampleRate44100: 44100,
  AudioSampleRateType.audioSampleRate48000: 48000,
};

PublisherConfiguration _$PublisherConfigurationFromJson(
        Map<String, dynamic> json) =>
    PublisherConfiguration(
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      framerate: (json['framerate'] as num?)?.toInt(),
      bitrate: (json['bitrate'] as num?)?.toInt(),
      defaultLayout: (json['defaultLayout'] as num?)?.toInt(),
      lifecycle: (json['lifecycle'] as num?)?.toInt(),
      owner: json['owner'] as bool?,
      injectStreamWidth: (json['injectStreamWidth'] as num?)?.toInt(),
      injectStreamHeight: (json['injectStreamHeight'] as num?)?.toInt(),
      injectStreamUrl: json['injectStreamUrl'] as String?,
      publishUrl: json['publishUrl'] as String?,
      rawStreamUrl: json['rawStreamUrl'] as String?,
      extraInfo: json['extraInfo'] as String?,
    );

Map<String, dynamic> _$PublisherConfigurationToJson(
    PublisherConfiguration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('width', instance.width);
  writeNotNull('height', instance.height);
  writeNotNull('framerate', instance.framerate);
  writeNotNull('bitrate', instance.bitrate);
  writeNotNull('defaultLayout', instance.defaultLayout);
  writeNotNull('lifecycle', instance.lifecycle);
  writeNotNull('owner', instance.owner);
  writeNotNull('injectStreamWidth', instance.injectStreamWidth);
  writeNotNull('injectStreamHeight', instance.injectStreamHeight);
  writeNotNull('injectStreamUrl', instance.injectStreamUrl);
  writeNotNull('publishUrl', instance.publishUrl);
  writeNotNull('rawStreamUrl', instance.rawStreamUrl);
  writeNotNull('extraInfo', instance.extraInfo);
  return val;
}

CameraCapturerConfiguration _$CameraCapturerConfigurationFromJson(
        Map<String, dynamic> json) =>
    CameraCapturerConfiguration(
      cameraDirection: $enumDecodeNullable(
          _$CameraDirectionEnumMap, json['cameraDirection']),
      cameraFocalLengthType: $enumDecodeNullable(
          _$CameraFocalLengthTypeEnumMap, json['cameraFocalLengthType']),
      deviceId: json['deviceId'] as String?,
      cameraId: json['cameraId'] as String?,
      followEncodeDimensionRatio: json['followEncodeDimensionRatio'] as bool?,
      format: json['format'] == null
          ? null
          : VideoFormat.fromJson(json['format'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CameraCapturerConfigurationToJson(
    CameraCapturerConfiguration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'cameraDirection', _$CameraDirectionEnumMap[instance.cameraDirection]);
  writeNotNull('cameraFocalLengthType',
      _$CameraFocalLengthTypeEnumMap[instance.cameraFocalLengthType]);
  writeNotNull('deviceId', instance.deviceId);
  writeNotNull('cameraId', instance.cameraId);
  writeNotNull(
      'followEncodeDimensionRatio', instance.followEncodeDimensionRatio);
  writeNotNull('format', instance.format?.toJson());
  return val;
}

const _$CameraDirectionEnumMap = {
  CameraDirection.cameraRear: 0,
  CameraDirection.cameraFront: 1,
};

const _$CameraFocalLengthTypeEnumMap = {
  CameraFocalLengthType.cameraFocalLengthDefault: 0,
  CameraFocalLengthType.cameraFocalLengthWideAngle: 1,
  CameraFocalLengthType.cameraFocalLengthUltraWide: 2,
  CameraFocalLengthType.cameraFocalLengthTelephoto: 3,
};

ScreenCaptureConfiguration _$ScreenCaptureConfigurationFromJson(
        Map<String, dynamic> json) =>
    ScreenCaptureConfiguration(
      isCaptureWindow: json['isCaptureWindow'] as bool?,
      displayId: (json['displayId'] as num?)?.toInt(),
      screenRect: json['screenRect'] == null
          ? null
          : Rectangle.fromJson(json['screenRect'] as Map<String, dynamic>),
      windowId: (json['windowId'] as num?)?.toInt(),
      params: json['params'] == null
          ? null
          : ScreenCaptureParameters.fromJson(
              json['params'] as Map<String, dynamic>),
      regionRect: json['regionRect'] == null
          ? null
          : Rectangle.fromJson(json['regionRect'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ScreenCaptureConfigurationToJson(
    ScreenCaptureConfiguration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('isCaptureWindow', instance.isCaptureWindow);
  writeNotNull('displayId', instance.displayId);
  writeNotNull('screenRect', instance.screenRect?.toJson());
  writeNotNull('windowId', instance.windowId);
  writeNotNull('params', instance.params?.toJson());
  writeNotNull('regionRect', instance.regionRect?.toJson());
  return val;
}

SIZE _$SIZEFromJson(Map<String, dynamic> json) => SIZE(
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SIZEToJson(SIZE instance) {
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

ThumbImageBuffer _$ThumbImageBufferFromJson(Map<String, dynamic> json) =>
    ThumbImageBuffer(
      length: (json['length'] as num?)?.toInt(),
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ThumbImageBufferToJson(ThumbImageBuffer instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('length', instance.length);
  writeNotNull('width', instance.width);
  writeNotNull('height', instance.height);
  return val;
}

ScreenCaptureSourceInfo _$ScreenCaptureSourceInfoFromJson(
        Map<String, dynamic> json) =>
    ScreenCaptureSourceInfo(
      type: $enumDecodeNullable(_$ScreenCaptureSourceTypeEnumMap, json['type']),
      sourceId: (json['sourceId'] as num?)?.toInt(),
      sourceName: json['sourceName'] as String?,
      thumbImage: json['thumbImage'] == null
          ? null
          : ThumbImageBuffer.fromJson(
              json['thumbImage'] as Map<String, dynamic>),
      iconImage: json['iconImage'] == null
          ? null
          : ThumbImageBuffer.fromJson(
              json['iconImage'] as Map<String, dynamic>),
      processPath: json['processPath'] as String?,
      sourceTitle: json['sourceTitle'] as String?,
      primaryMonitor: json['primaryMonitor'] as bool?,
      isOccluded: json['isOccluded'] as bool?,
      position: json['position'] == null
          ? null
          : Rectangle.fromJson(json['position'] as Map<String, dynamic>),
      minimizeWindow: json['minimizeWindow'] as bool?,
      sourceDisplayId: (json['sourceDisplayId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ScreenCaptureSourceInfoToJson(
    ScreenCaptureSourceInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', _$ScreenCaptureSourceTypeEnumMap[instance.type]);
  writeNotNull('sourceId', instance.sourceId);
  writeNotNull('sourceName', instance.sourceName);
  writeNotNull('thumbImage', instance.thumbImage?.toJson());
  writeNotNull('iconImage', instance.iconImage?.toJson());
  writeNotNull('processPath', instance.processPath);
  writeNotNull('sourceTitle', instance.sourceTitle);
  writeNotNull('primaryMonitor', instance.primaryMonitor);
  writeNotNull('isOccluded', instance.isOccluded);
  writeNotNull('position', instance.position?.toJson());
  writeNotNull('minimizeWindow', instance.minimizeWindow);
  writeNotNull('sourceDisplayId', instance.sourceDisplayId);
  return val;
}

const _$ScreenCaptureSourceTypeEnumMap = {
  ScreenCaptureSourceType.screencapturesourcetypeUnknown: -1,
  ScreenCaptureSourceType.screencapturesourcetypeWindow: 0,
  ScreenCaptureSourceType.screencapturesourcetypeScreen: 1,
  ScreenCaptureSourceType.screencapturesourcetypeCustom: 2,
};

AdvancedAudioOptions _$AdvancedAudioOptionsFromJson(
        Map<String, dynamic> json) =>
    AdvancedAudioOptions(
      audioProcessingChannels:
          (json['audioProcessingChannels'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AdvancedAudioOptionsToJson(
    AdvancedAudioOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('audioProcessingChannels', instance.audioProcessingChannels);
  return val;
}

ImageTrackOptions _$ImageTrackOptionsFromJson(Map<String, dynamic> json) =>
    ImageTrackOptions(
      imageUrl: json['imageUrl'] as String?,
      fps: (json['fps'] as num?)?.toInt(),
      mirrorMode:
          $enumDecodeNullable(_$VideoMirrorModeTypeEnumMap, json['mirrorMode']),
    );

Map<String, dynamic> _$ImageTrackOptionsToJson(ImageTrackOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('imageUrl', instance.imageUrl);
  writeNotNull('fps', instance.fps);
  writeNotNull('mirrorMode', _$VideoMirrorModeTypeEnumMap[instance.mirrorMode]);
  return val;
}

const _$VideoMirrorModeTypeEnumMap = {
  VideoMirrorModeType.videoMirrorModeAuto: 0,
  VideoMirrorModeType.videoMirrorModeEnabled: 1,
  VideoMirrorModeType.videoMirrorModeDisabled: 2,
};

ChannelMediaOptions _$ChannelMediaOptionsFromJson(Map<String, dynamic> json) =>
    ChannelMediaOptions(
      publishCameraTrack: json['publishCameraTrack'] as bool?,
      publishSecondaryCameraTrack: json['publishSecondaryCameraTrack'] as bool?,
      publishThirdCameraTrack: json['publishThirdCameraTrack'] as bool?,
      publishFourthCameraTrack: json['publishFourthCameraTrack'] as bool?,
      publishMicrophoneTrack: json['publishMicrophoneTrack'] as bool?,
      publishScreenCaptureVideo: json['publishScreenCaptureVideo'] as bool?,
      publishScreenCaptureAudio: json['publishScreenCaptureAudio'] as bool?,
      publishScreenTrack: json['publishScreenTrack'] as bool?,
      publishSecondaryScreenTrack: json['publishSecondaryScreenTrack'] as bool?,
      publishThirdScreenTrack: json['publishThirdScreenTrack'] as bool?,
      publishFourthScreenTrack: json['publishFourthScreenTrack'] as bool?,
      publishCustomAudioTrack: json['publishCustomAudioTrack'] as bool?,
      publishCustomAudioTrackId:
          (json['publishCustomAudioTrackId'] as num?)?.toInt(),
      publishCustomVideoTrack: json['publishCustomVideoTrack'] as bool?,
      publishEncodedVideoTrack: json['publishEncodedVideoTrack'] as bool?,
      publishMediaPlayerAudioTrack:
          json['publishMediaPlayerAudioTrack'] as bool?,
      publishMediaPlayerVideoTrack:
          json['publishMediaPlayerVideoTrack'] as bool?,
      publishTranscodedVideoTrack: json['publishTranscodedVideoTrack'] as bool?,
      publishMixedAudioTrack: json['publishMixedAudioTrack'] as bool?,
      publishLipSyncTrack: json['publishLipSyncTrack'] as bool?,
      autoSubscribeAudio: json['autoSubscribeAudio'] as bool?,
      autoSubscribeVideo: json['autoSubscribeVideo'] as bool?,
      enableAudioRecordingOrPlayout:
          json['enableAudioRecordingOrPlayout'] as bool?,
      publishMediaPlayerId: (json['publishMediaPlayerId'] as num?)?.toInt(),
      clientRoleType:
          $enumDecodeNullable(_$ClientRoleTypeEnumMap, json['clientRoleType']),
      audienceLatencyLevel: $enumDecodeNullable(
          _$AudienceLatencyLevelTypeEnumMap, json['audienceLatencyLevel']),
      defaultVideoStreamType: $enumDecodeNullable(
          _$VideoStreamTypeEnumMap, json['defaultVideoStreamType']),
      channelProfile: $enumDecodeNullable(
          _$ChannelProfileTypeEnumMap, json['channelProfile']),
      audioDelayMs: (json['audioDelayMs'] as num?)?.toInt(),
      mediaPlayerAudioDelayMs:
          (json['mediaPlayerAudioDelayMs'] as num?)?.toInt(),
      token: json['token'] as String?,
      enableBuiltInMediaEncryption:
          json['enableBuiltInMediaEncryption'] as bool?,
      publishRhythmPlayerTrack: json['publishRhythmPlayerTrack'] as bool?,
      isInteractiveAudience: json['isInteractiveAudience'] as bool?,
      customVideoTrackId: (json['customVideoTrackId'] as num?)?.toInt(),
      isAudioFilterable: json['isAudioFilterable'] as bool?,
    );

Map<String, dynamic> _$ChannelMediaOptionsToJson(ChannelMediaOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('publishCameraTrack', instance.publishCameraTrack);
  writeNotNull(
      'publishSecondaryCameraTrack', instance.publishSecondaryCameraTrack);
  writeNotNull('publishThirdCameraTrack', instance.publishThirdCameraTrack);
  writeNotNull('publishFourthCameraTrack', instance.publishFourthCameraTrack);
  writeNotNull('publishMicrophoneTrack', instance.publishMicrophoneTrack);
  writeNotNull('publishScreenCaptureVideo', instance.publishScreenCaptureVideo);
  writeNotNull('publishScreenCaptureAudio', instance.publishScreenCaptureAudio);
  writeNotNull('publishScreenTrack', instance.publishScreenTrack);
  writeNotNull(
      'publishSecondaryScreenTrack', instance.publishSecondaryScreenTrack);
  writeNotNull('publishThirdScreenTrack', instance.publishThirdScreenTrack);
  writeNotNull('publishFourthScreenTrack', instance.publishFourthScreenTrack);
  writeNotNull('publishCustomAudioTrack', instance.publishCustomAudioTrack);
  writeNotNull('publishCustomAudioTrackId', instance.publishCustomAudioTrackId);
  writeNotNull('publishCustomVideoTrack', instance.publishCustomVideoTrack);
  writeNotNull('publishEncodedVideoTrack', instance.publishEncodedVideoTrack);
  writeNotNull(
      'publishMediaPlayerAudioTrack', instance.publishMediaPlayerAudioTrack);
  writeNotNull(
      'publishMediaPlayerVideoTrack', instance.publishMediaPlayerVideoTrack);
  writeNotNull(
      'publishTranscodedVideoTrack', instance.publishTranscodedVideoTrack);
  writeNotNull('publishMixedAudioTrack', instance.publishMixedAudioTrack);
  writeNotNull('publishLipSyncTrack', instance.publishLipSyncTrack);
  writeNotNull('autoSubscribeAudio', instance.autoSubscribeAudio);
  writeNotNull('autoSubscribeVideo', instance.autoSubscribeVideo);
  writeNotNull(
      'enableAudioRecordingOrPlayout', instance.enableAudioRecordingOrPlayout);
  writeNotNull('publishMediaPlayerId', instance.publishMediaPlayerId);
  writeNotNull(
      'clientRoleType', _$ClientRoleTypeEnumMap[instance.clientRoleType]);
  writeNotNull('audienceLatencyLevel',
      _$AudienceLatencyLevelTypeEnumMap[instance.audienceLatencyLevel]);
  writeNotNull('defaultVideoStreamType',
      _$VideoStreamTypeEnumMap[instance.defaultVideoStreamType]);
  writeNotNull(
      'channelProfile', _$ChannelProfileTypeEnumMap[instance.channelProfile]);
  writeNotNull('audioDelayMs', instance.audioDelayMs);
  writeNotNull('mediaPlayerAudioDelayMs', instance.mediaPlayerAudioDelayMs);
  writeNotNull('token', instance.token);
  writeNotNull(
      'enableBuiltInMediaEncryption', instance.enableBuiltInMediaEncryption);
  writeNotNull('publishRhythmPlayerTrack', instance.publishRhythmPlayerTrack);
  writeNotNull('isInteractiveAudience', instance.isInteractiveAudience);
  writeNotNull('customVideoTrackId', instance.customVideoTrackId);
  writeNotNull('isAudioFilterable', instance.isAudioFilterable);
  return val;
}

const _$ClientRoleTypeEnumMap = {
  ClientRoleType.clientRoleBroadcaster: 1,
  ClientRoleType.clientRoleAudience: 2,
};

const _$AudienceLatencyLevelTypeEnumMap = {
  AudienceLatencyLevelType.audienceLatencyLevelLowLatency: 1,
  AudienceLatencyLevelType.audienceLatencyLevelUltraLowLatency: 2,
};

const _$ChannelProfileTypeEnumMap = {
  ChannelProfileType.channelProfileCommunication: 0,
  ChannelProfileType.channelProfileLiveBroadcasting: 1,
  ChannelProfileType.channelProfileGame: 2,
  ChannelProfileType.channelProfileCloudGaming: 3,
  ChannelProfileType.channelProfileCommunication1v1: 4,
};

LeaveChannelOptions _$LeaveChannelOptionsFromJson(Map<String, dynamic> json) =>
    LeaveChannelOptions(
      stopAudioMixing: json['stopAudioMixing'] as bool?,
      stopAllEffect: json['stopAllEffect'] as bool?,
      stopMicrophoneRecording: json['stopMicrophoneRecording'] as bool?,
    );

Map<String, dynamic> _$LeaveChannelOptionsToJson(LeaveChannelOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('stopAudioMixing', instance.stopAudioMixing);
  writeNotNull('stopAllEffect', instance.stopAllEffect);
  writeNotNull('stopMicrophoneRecording', instance.stopMicrophoneRecording);
  return val;
}

RtcEngineContext _$RtcEngineContextFromJson(Map<String, dynamic> json) =>
    RtcEngineContext(
      appId: json['appId'] as String?,
      channelProfile: $enumDecodeNullable(
          _$ChannelProfileTypeEnumMap, json['channelProfile']),
      license: json['license'] as String?,
      audioScenario: $enumDecodeNullable(
          _$AudioScenarioTypeEnumMap, json['audioScenario']),
      areaCode: (json['areaCode'] as num?)?.toInt(),
      logConfig: json['logConfig'] == null
          ? null
          : LogConfig.fromJson(json['logConfig'] as Map<String, dynamic>),
      threadPriority: $enumDecodeNullable(
          _$ThreadPriorityTypeEnumMap, json['threadPriority']),
      useExternalEglContext: json['useExternalEglContext'] as bool?,
      domainLimit: json['domainLimit'] as bool?,
      autoRegisterAgoraExtensions: json['autoRegisterAgoraExtensions'] as bool?,
    );

Map<String, dynamic> _$RtcEngineContextToJson(RtcEngineContext instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('appId', instance.appId);
  writeNotNull(
      'channelProfile', _$ChannelProfileTypeEnumMap[instance.channelProfile]);
  writeNotNull('license', instance.license);
  writeNotNull(
      'audioScenario', _$AudioScenarioTypeEnumMap[instance.audioScenario]);
  writeNotNull('areaCode', instance.areaCode);
  writeNotNull('logConfig', instance.logConfig?.toJson());
  writeNotNull(
      'threadPriority', _$ThreadPriorityTypeEnumMap[instance.threadPriority]);
  writeNotNull('useExternalEglContext', instance.useExternalEglContext);
  writeNotNull('domainLimit', instance.domainLimit);
  writeNotNull(
      'autoRegisterAgoraExtensions', instance.autoRegisterAgoraExtensions);
  return val;
}

const _$AudioScenarioTypeEnumMap = {
  AudioScenarioType.audioScenarioDefault: 0,
  AudioScenarioType.audioScenarioGameStreaming: 3,
  AudioScenarioType.audioScenarioChatroom: 5,
  AudioScenarioType.audioScenarioChorus: 7,
  AudioScenarioType.audioScenarioMeeting: 8,
  AudioScenarioType.audioScenarioNum: 9,
};

const _$ThreadPriorityTypeEnumMap = {
  ThreadPriorityType.lowest: 0,
  ThreadPriorityType.low: 1,
  ThreadPriorityType.normal: 2,
  ThreadPriorityType.high: 3,
  ThreadPriorityType.highest: 4,
  ThreadPriorityType.critical: 5,
};

Metadata _$MetadataFromJson(Map<String, dynamic> json) => Metadata(
      uid: (json['uid'] as num?)?.toInt(),
      size: (json['size'] as num?)?.toInt(),
      timeStampMs: (json['timeStampMs'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MetadataToJson(Metadata instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uid', instance.uid);
  writeNotNull('size', instance.size);
  writeNotNull('timeStampMs', instance.timeStampMs);
  return val;
}

DirectCdnStreamingStats _$DirectCdnStreamingStatsFromJson(
        Map<String, dynamic> json) =>
    DirectCdnStreamingStats(
      videoWidth: (json['videoWidth'] as num?)?.toInt(),
      videoHeight: (json['videoHeight'] as num?)?.toInt(),
      fps: (json['fps'] as num?)?.toInt(),
      videoBitrate: (json['videoBitrate'] as num?)?.toInt(),
      audioBitrate: (json['audioBitrate'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DirectCdnStreamingStatsToJson(
    DirectCdnStreamingStats instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('videoWidth', instance.videoWidth);
  writeNotNull('videoHeight', instance.videoHeight);
  writeNotNull('fps', instance.fps);
  writeNotNull('videoBitrate', instance.videoBitrate);
  writeNotNull('audioBitrate', instance.audioBitrate);
  return val;
}

DirectCdnStreamingMediaOptions _$DirectCdnStreamingMediaOptionsFromJson(
        Map<String, dynamic> json) =>
    DirectCdnStreamingMediaOptions(
      publishCameraTrack: json['publishCameraTrack'] as bool?,
      publishMicrophoneTrack: json['publishMicrophoneTrack'] as bool?,
      publishCustomAudioTrack: json['publishCustomAudioTrack'] as bool?,
      publishCustomVideoTrack: json['publishCustomVideoTrack'] as bool?,
      publishMediaPlayerAudioTrack:
          json['publishMediaPlayerAudioTrack'] as bool?,
      publishMediaPlayerId: (json['publishMediaPlayerId'] as num?)?.toInt(),
      customVideoTrackId: (json['customVideoTrackId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DirectCdnStreamingMediaOptionsToJson(
    DirectCdnStreamingMediaOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('publishCameraTrack', instance.publishCameraTrack);
  writeNotNull('publishMicrophoneTrack', instance.publishMicrophoneTrack);
  writeNotNull('publishCustomAudioTrack', instance.publishCustomAudioTrack);
  writeNotNull('publishCustomVideoTrack', instance.publishCustomVideoTrack);
  writeNotNull(
      'publishMediaPlayerAudioTrack', instance.publishMediaPlayerAudioTrack);
  writeNotNull('publishMediaPlayerId', instance.publishMediaPlayerId);
  writeNotNull('customVideoTrackId', instance.customVideoTrackId);
  return val;
}

ExtensionInfo _$ExtensionInfoFromJson(Map<String, dynamic> json) =>
    ExtensionInfo(
      mediaSourceType: $enumDecodeNullable(
          _$MediaSourceTypeEnumMap, json['mediaSourceType']),
      remoteUid: (json['remoteUid'] as num?)?.toInt(),
      channelId: json['channelId'] as String?,
      localUid: (json['localUid'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ExtensionInfoToJson(ExtensionInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'mediaSourceType', _$MediaSourceTypeEnumMap[instance.mediaSourceType]);
  writeNotNull('remoteUid', instance.remoteUid);
  writeNotNull('channelId', instance.channelId);
  writeNotNull('localUid', instance.localUid);
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
  MediaSourceType.speechDrivenVideoSource: 13,
  MediaSourceType.unknownMediaSource: 100,
};

SDKBuildInfo _$SDKBuildInfoFromJson(Map<String, dynamic> json) => SDKBuildInfo(
      build: (json['build'] as num?)?.toInt(),
      version: json['version'] as String?,
    );

Map<String, dynamic> _$SDKBuildInfoToJson(SDKBuildInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('build', instance.build);
  writeNotNull('version', instance.version);
  return val;
}

VideoDeviceInfo _$VideoDeviceInfoFromJson(Map<String, dynamic> json) =>
    VideoDeviceInfo(
      deviceId: json['deviceId'] as String?,
      deviceName: json['deviceName'] as String?,
    );

Map<String, dynamic> _$VideoDeviceInfoToJson(VideoDeviceInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('deviceId', instance.deviceId);
  writeNotNull('deviceName', instance.deviceName);
  return val;
}

AudioDeviceInfo _$AudioDeviceInfoFromJson(Map<String, dynamic> json) =>
    AudioDeviceInfo(
      deviceId: json['deviceId'] as String?,
      deviceTypeName: json['deviceTypeName'] as String?,
      deviceName: json['deviceName'] as String?,
    );

Map<String, dynamic> _$AudioDeviceInfoToJson(AudioDeviceInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('deviceId', instance.deviceId);
  writeNotNull('deviceTypeName', instance.deviceTypeName);
  writeNotNull('deviceName', instance.deviceName);
  return val;
}

const _$MediaDeviceTypeEnumMap = {
  MediaDeviceType.unknownAudioDevice: -1,
  MediaDeviceType.audioPlayoutDevice: 0,
  MediaDeviceType.audioRecordingDevice: 1,
  MediaDeviceType.videoRenderDevice: 2,
  MediaDeviceType.videoCaptureDevice: 3,
  MediaDeviceType.audioApplicationPlayoutDevice: 4,
  MediaDeviceType.audioVirtualPlayoutDevice: 5,
  MediaDeviceType.audioVirtualRecordingDevice: 6,
};

const _$AudioMixingStateTypeEnumMap = {
  AudioMixingStateType.audioMixingStatePlaying: 710,
  AudioMixingStateType.audioMixingStatePaused: 711,
  AudioMixingStateType.audioMixingStateStopped: 713,
  AudioMixingStateType.audioMixingStateFailed: 714,
};

const _$AudioMixingReasonTypeEnumMap = {
  AudioMixingReasonType.audioMixingReasonCanNotOpen: 701,
  AudioMixingReasonType.audioMixingReasonTooFrequentCall: 702,
  AudioMixingReasonType.audioMixingReasonInterruptedEof: 703,
  AudioMixingReasonType.audioMixingReasonOneLoopCompleted: 721,
  AudioMixingReasonType.audioMixingReasonAllLoopsCompleted: 723,
  AudioMixingReasonType.audioMixingReasonStoppedByUser: 724,
  AudioMixingReasonType.audioMixingReasonOk: 0,
};

const _$InjectStreamStatusEnumMap = {
  InjectStreamStatus.injectStreamStatusStartSuccess: 0,
  InjectStreamStatus.injectStreamStatusStartAlreadyExists: 1,
  InjectStreamStatus.injectStreamStatusStartUnauthorized: 2,
  InjectStreamStatus.injectStreamStatusStartTimedout: 3,
  InjectStreamStatus.injectStreamStatusStartFailed: 4,
  InjectStreamStatus.injectStreamStatusStopSuccess: 5,
  InjectStreamStatus.injectStreamStatusStopNotFound: 6,
  InjectStreamStatus.injectStreamStatusStopUnauthorized: 7,
  InjectStreamStatus.injectStreamStatusStopTimedout: 8,
  InjectStreamStatus.injectStreamStatusStopFailed: 9,
  InjectStreamStatus.injectStreamStatusBroken: 10,
};

const _$AudioEqualizationBandFrequencyEnumMap = {
  AudioEqualizationBandFrequency.audioEqualizationBand31: 0,
  AudioEqualizationBandFrequency.audioEqualizationBand62: 1,
  AudioEqualizationBandFrequency.audioEqualizationBand125: 2,
  AudioEqualizationBandFrequency.audioEqualizationBand250: 3,
  AudioEqualizationBandFrequency.audioEqualizationBand500: 4,
  AudioEqualizationBandFrequency.audioEqualizationBand1k: 5,
  AudioEqualizationBandFrequency.audioEqualizationBand2k: 6,
  AudioEqualizationBandFrequency.audioEqualizationBand4k: 7,
  AudioEqualizationBandFrequency.audioEqualizationBand8k: 8,
  AudioEqualizationBandFrequency.audioEqualizationBand16k: 9,
};

const _$AudioReverbTypeEnumMap = {
  AudioReverbType.audioReverbDryLevel: 0,
  AudioReverbType.audioReverbWetLevel: 1,
  AudioReverbType.audioReverbRoomSize: 2,
  AudioReverbType.audioReverbWetDelay: 3,
  AudioReverbType.audioReverbStrength: 4,
};

const _$StreamFallbackOptionsEnumMap = {
  StreamFallbackOptions.streamFallbackOptionDisabled: 0,
  StreamFallbackOptions.streamFallbackOptionVideoStreamLow: 1,
  StreamFallbackOptions.streamFallbackOptionAudioOnly: 2,
};

const _$PriorityTypeEnumMap = {
  PriorityType.priorityHigh: 50,
  PriorityType.priorityNormal: 100,
};

const _$RtmpStreamLifeCycleTypeEnumMap = {
  RtmpStreamLifeCycleType.rtmpStreamLifeCycleBind2channel: 1,
  RtmpStreamLifeCycleType.rtmpStreamLifeCycleBind2owner: 2,
};

const _$CloudProxyTypeEnumMap = {
  CloudProxyType.noneProxy: 0,
  CloudProxyType.udpProxy: 1,
  CloudProxyType.tcpProxy: 2,
};

const _$ProxyTypeEnumMap = {
  ProxyType.noneProxyType: 0,
  ProxyType.udpProxyType: 1,
  ProxyType.tcpProxyType: 2,
  ProxyType.localProxyType: 3,
  ProxyType.tcpProxyAutoFallbackType: 4,
  ProxyType.httpProxyType: 5,
  ProxyType.httpsProxyType: 6,
};

const _$FeatureTypeEnumMap = {
  FeatureType.videoVirtualBackground: 1,
  FeatureType.videoBeautyEffect: 2,
};

const _$MetadataTypeEnumMap = {
  MetadataType.unknownMetadata: -1,
  MetadataType.videoMetadata: 0,
};

const _$MaxMetadataSizeTypeEnumMap = {
  MaxMetadataSizeType.invalidMetadataSizeInByte: -1,
  MaxMetadataSizeType.defaultMetadataSizeInByte: 512,
  MaxMetadataSizeType.maxMetadataSizeInByte: 1024,
};

const _$DirectCdnStreamingReasonEnumMap = {
  DirectCdnStreamingReason.directCdnStreamingReasonOk: 0,
  DirectCdnStreamingReason.directCdnStreamingReasonFailed: 1,
  DirectCdnStreamingReason.directCdnStreamingReasonAudioPublication: 2,
  DirectCdnStreamingReason.directCdnStreamingReasonVideoPublication: 3,
  DirectCdnStreamingReason.directCdnStreamingReasonNetConnect: 4,
  DirectCdnStreamingReason.directCdnStreamingReasonBadName: 5,
};

const _$DirectCdnStreamingStateEnumMap = {
  DirectCdnStreamingState.directCdnStreamingStateIdle: 0,
  DirectCdnStreamingState.directCdnStreamingStateRunning: 1,
  DirectCdnStreamingState.directCdnStreamingStateStopped: 2,
  DirectCdnStreamingState.directCdnStreamingStateFailed: 3,
  DirectCdnStreamingState.directCdnStreamingStateRecovering: 4,
};

const _$QualityReportFormatTypeEnumMap = {
  QualityReportFormatType.qualityReportJson: 0,
  QualityReportFormatType.qualityReportHtml: 1,
};

const _$MediaDeviceStateTypeEnumMap = {
  MediaDeviceStateType.mediaDeviceStateIdle: 0,
  MediaDeviceStateType.mediaDeviceStateActive: 1,
  MediaDeviceStateType.mediaDeviceStateDisabled: 2,
  MediaDeviceStateType.mediaDeviceStateNotPresent: 4,
  MediaDeviceStateType.mediaDeviceStateUnplugged: 8,
};

const _$VideoProfileTypeEnumMap = {
  VideoProfileType.videoProfileLandscape120p: 0,
  VideoProfileType.videoProfileLandscape120p3: 2,
  VideoProfileType.videoProfileLandscape180p: 10,
  VideoProfileType.videoProfileLandscape180p3: 12,
  VideoProfileType.videoProfileLandscape180p4: 13,
  VideoProfileType.videoProfileLandscape240p: 20,
  VideoProfileType.videoProfileLandscape240p3: 22,
  VideoProfileType.videoProfileLandscape240p4: 23,
  VideoProfileType.videoProfileLandscape360p: 30,
  VideoProfileType.videoProfileLandscape360p3: 32,
  VideoProfileType.videoProfileLandscape360p4: 33,
  VideoProfileType.videoProfileLandscape360p6: 35,
  VideoProfileType.videoProfileLandscape360p7: 36,
  VideoProfileType.videoProfileLandscape360p8: 37,
  VideoProfileType.videoProfileLandscape360p9: 38,
  VideoProfileType.videoProfileLandscape360p10: 39,
  VideoProfileType.videoProfileLandscape360p11: 100,
  VideoProfileType.videoProfileLandscape480p: 40,
  VideoProfileType.videoProfileLandscape480p3: 42,
  VideoProfileType.videoProfileLandscape480p4: 43,
  VideoProfileType.videoProfileLandscape480p6: 45,
  VideoProfileType.videoProfileLandscape480p8: 47,
  VideoProfileType.videoProfileLandscape480p9: 48,
  VideoProfileType.videoProfileLandscape480p10: 49,
  VideoProfileType.videoProfileLandscape720p: 50,
  VideoProfileType.videoProfileLandscape720p3: 52,
  VideoProfileType.videoProfileLandscape720p5: 54,
  VideoProfileType.videoProfileLandscape720p6: 55,
  VideoProfileType.videoProfileLandscape1080p: 60,
  VideoProfileType.videoProfileLandscape1080p3: 62,
  VideoProfileType.videoProfileLandscape1080p5: 64,
  VideoProfileType.videoProfileLandscape1440p: 66,
  VideoProfileType.videoProfileLandscape1440p2: 67,
  VideoProfileType.videoProfileLandscape4k: 70,
  VideoProfileType.videoProfileLandscape4k3: 72,
  VideoProfileType.videoProfilePortrait120p: 1000,
  VideoProfileType.videoProfilePortrait120p3: 1002,
  VideoProfileType.videoProfilePortrait180p: 1010,
  VideoProfileType.videoProfilePortrait180p3: 1012,
  VideoProfileType.videoProfilePortrait180p4: 1013,
  VideoProfileType.videoProfilePortrait240p: 1020,
  VideoProfileType.videoProfilePortrait240p3: 1022,
  VideoProfileType.videoProfilePortrait240p4: 1023,
  VideoProfileType.videoProfilePortrait360p: 1030,
  VideoProfileType.videoProfilePortrait360p3: 1032,
  VideoProfileType.videoProfilePortrait360p4: 1033,
  VideoProfileType.videoProfilePortrait360p6: 1035,
  VideoProfileType.videoProfilePortrait360p7: 1036,
  VideoProfileType.videoProfilePortrait360p8: 1037,
  VideoProfileType.videoProfilePortrait360p9: 1038,
  VideoProfileType.videoProfilePortrait360p10: 1039,
  VideoProfileType.videoProfilePortrait360p11: 1100,
  VideoProfileType.videoProfilePortrait480p: 1040,
  VideoProfileType.videoProfilePortrait480p3: 1042,
  VideoProfileType.videoProfilePortrait480p4: 1043,
  VideoProfileType.videoProfilePortrait480p6: 1045,
  VideoProfileType.videoProfilePortrait480p8: 1047,
  VideoProfileType.videoProfilePortrait480p9: 1048,
  VideoProfileType.videoProfilePortrait480p10: 1049,
  VideoProfileType.videoProfilePortrait720p: 1050,
  VideoProfileType.videoProfilePortrait720p3: 1052,
  VideoProfileType.videoProfilePortrait720p5: 1054,
  VideoProfileType.videoProfilePortrait720p6: 1055,
  VideoProfileType.videoProfilePortrait1080p: 1060,
  VideoProfileType.videoProfilePortrait1080p3: 1062,
  VideoProfileType.videoProfilePortrait1080p5: 1064,
  VideoProfileType.videoProfilePortrait1440p: 1066,
  VideoProfileType.videoProfilePortrait1440p2: 1067,
  VideoProfileType.videoProfilePortrait4k: 1070,
  VideoProfileType.videoProfilePortrait4k3: 1072,
  VideoProfileType.videoProfileDefault: 30,
};
