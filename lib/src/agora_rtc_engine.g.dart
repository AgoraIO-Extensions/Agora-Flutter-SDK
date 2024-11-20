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

Map<String, dynamic> _$LocalVideoStatsToJson(LocalVideoStats instance) =>
    <String, dynamic>{
      if (instance.uid case final value?) 'uid': value,
      if (instance.sentBitrate case final value?) 'sentBitrate': value,
      if (instance.sentFrameRate case final value?) 'sentFrameRate': value,
      if (instance.captureFrameRate case final value?)
        'captureFrameRate': value,
      if (instance.captureFrameWidth case final value?)
        'captureFrameWidth': value,
      if (instance.captureFrameHeight case final value?)
        'captureFrameHeight': value,
      if (instance.regulatedCaptureFrameRate case final value?)
        'regulatedCaptureFrameRate': value,
      if (instance.regulatedCaptureFrameWidth case final value?)
        'regulatedCaptureFrameWidth': value,
      if (instance.regulatedCaptureFrameHeight case final value?)
        'regulatedCaptureFrameHeight': value,
      if (instance.encoderOutputFrameRate case final value?)
        'encoderOutputFrameRate': value,
      if (instance.encodedFrameWidth case final value?)
        'encodedFrameWidth': value,
      if (instance.encodedFrameHeight case final value?)
        'encodedFrameHeight': value,
      if (instance.rendererOutputFrameRate case final value?)
        'rendererOutputFrameRate': value,
      if (instance.targetBitrate case final value?) 'targetBitrate': value,
      if (instance.targetFrameRate case final value?) 'targetFrameRate': value,
      if (_$QualityAdaptIndicationEnumMap[instance.qualityAdaptIndication]
          case final value?)
        'qualityAdaptIndication': value,
      if (instance.encodedBitrate case final value?) 'encodedBitrate': value,
      if (instance.encodedFrameCount case final value?)
        'encodedFrameCount': value,
      if (_$VideoCodecTypeEnumMap[instance.codecType] case final value?)
        'codecType': value,
      if (instance.txPacketLossRate case final value?)
        'txPacketLossRate': value,
      if (_$CaptureBrightnessLevelTypeEnumMap[instance.captureBrightnessLevel]
          case final value?)
        'captureBrightnessLevel': value,
      if (instance.dualStreamEnabled case final value?)
        'dualStreamEnabled': value,
      if (instance.hwEncoderAccelerating case final value?)
        'hwEncoderAccelerating': value,
    };

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

Map<String, dynamic> _$RemoteAudioStatsToJson(RemoteAudioStats instance) =>
    <String, dynamic>{
      if (instance.uid case final value?) 'uid': value,
      if (instance.quality case final value?) 'quality': value,
      if (instance.networkTransportDelay case final value?)
        'networkTransportDelay': value,
      if (instance.jitterBufferDelay case final value?)
        'jitterBufferDelay': value,
      if (instance.audioLossRate case final value?) 'audioLossRate': value,
      if (instance.numChannels case final value?) 'numChannels': value,
      if (instance.receivedSampleRate case final value?)
        'receivedSampleRate': value,
      if (instance.receivedBitrate case final value?) 'receivedBitrate': value,
      if (instance.totalFrozenTime case final value?) 'totalFrozenTime': value,
      if (instance.frozenRate case final value?) 'frozenRate': value,
      if (instance.mosValue case final value?) 'mosValue': value,
      if (instance.frozenRateByCustomPlcCount case final value?)
        'frozenRateByCustomPlcCount': value,
      if (instance.plcCount case final value?) 'plcCount': value,
      if (instance.totalActiveTime case final value?) 'totalActiveTime': value,
      if (instance.publishDuration case final value?) 'publishDuration': value,
      if (instance.qoeQuality case final value?) 'qoeQuality': value,
      if (instance.qualityChangedReason case final value?)
        'qualityChangedReason': value,
      if (instance.rxAudioBytes case final value?) 'rxAudioBytes': value,
      if (instance.e2eDelay case final value?) 'e2eDelay': value,
    };

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

Map<String, dynamic> _$RemoteVideoStatsToJson(RemoteVideoStats instance) =>
    <String, dynamic>{
      if (instance.uid case final value?) 'uid': value,
      if (instance.delay case final value?) 'delay': value,
      if (instance.e2eDelay case final value?) 'e2eDelay': value,
      if (instance.width case final value?) 'width': value,
      if (instance.height case final value?) 'height': value,
      if (instance.receivedBitrate case final value?) 'receivedBitrate': value,
      if (instance.decoderOutputFrameRate case final value?)
        'decoderOutputFrameRate': value,
      if (instance.rendererOutputFrameRate case final value?)
        'rendererOutputFrameRate': value,
      if (instance.frameLossRate case final value?) 'frameLossRate': value,
      if (instance.packetLossRate case final value?) 'packetLossRate': value,
      if (_$VideoStreamTypeEnumMap[instance.rxStreamType] case final value?)
        'rxStreamType': value,
      if (instance.totalFrozenTime case final value?) 'totalFrozenTime': value,
      if (instance.frozenRate case final value?) 'frozenRate': value,
      if (instance.avSyncTimeMs case final value?) 'avSyncTimeMs': value,
      if (instance.totalActiveTime case final value?) 'totalActiveTime': value,
      if (instance.publishDuration case final value?) 'publishDuration': value,
      if (instance.mosValue case final value?) 'mosValue': value,
      if (instance.rxVideoBytes case final value?) 'rxVideoBytes': value,
    };

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
        VideoCompositingLayout instance) =>
    <String, dynamic>{
      if (instance.canvasWidth case final value?) 'canvasWidth': value,
      if (instance.canvasHeight case final value?) 'canvasHeight': value,
      if (instance.backgroundColor case final value?) 'backgroundColor': value,
      if (instance.regions?.map((e) => e.toJson()).toList() case final value?)
        'regions': value,
      if (instance.regionCount case final value?) 'regionCount': value,
      if (instance.appDataLength case final value?) 'appDataLength': value,
    };

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

Map<String, dynamic> _$RegionToJson(Region instance) => <String, dynamic>{
      if (instance.uid case final value?) 'uid': value,
      if (instance.x case final value?) 'x': value,
      if (instance.y case final value?) 'y': value,
      if (instance.width case final value?) 'width': value,
      if (instance.height case final value?) 'height': value,
      if (instance.zOrder case final value?) 'zOrder': value,
      if (instance.alpha case final value?) 'alpha': value,
      if (_$RenderModeTypeEnumMap[instance.renderMode] case final value?)
        'renderMode': value,
    };

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

Map<String, dynamic> _$InjectStreamConfigToJson(InjectStreamConfig instance) =>
    <String, dynamic>{
      if (instance.width case final value?) 'width': value,
      if (instance.height case final value?) 'height': value,
      if (instance.videoGop case final value?) 'videoGop': value,
      if (instance.videoFramerate case final value?) 'videoFramerate': value,
      if (instance.videoBitrate case final value?) 'videoBitrate': value,
      if (_$AudioSampleRateTypeEnumMap[instance.audioSampleRate]
          case final value?)
        'audioSampleRate': value,
      if (instance.audioBitrate case final value?) 'audioBitrate': value,
      if (instance.audioChannels case final value?) 'audioChannels': value,
    };

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
        PublisherConfiguration instance) =>
    <String, dynamic>{
      if (instance.width case final value?) 'width': value,
      if (instance.height case final value?) 'height': value,
      if (instance.framerate case final value?) 'framerate': value,
      if (instance.bitrate case final value?) 'bitrate': value,
      if (instance.defaultLayout case final value?) 'defaultLayout': value,
      if (instance.lifecycle case final value?) 'lifecycle': value,
      if (instance.owner case final value?) 'owner': value,
      if (instance.injectStreamWidth case final value?)
        'injectStreamWidth': value,
      if (instance.injectStreamHeight case final value?)
        'injectStreamHeight': value,
      if (instance.injectStreamUrl case final value?) 'injectStreamUrl': value,
      if (instance.publishUrl case final value?) 'publishUrl': value,
      if (instance.rawStreamUrl case final value?) 'rawStreamUrl': value,
      if (instance.extraInfo case final value?) 'extraInfo': value,
    };

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
        CameraCapturerConfiguration instance) =>
    <String, dynamic>{
      if (_$CameraDirectionEnumMap[instance.cameraDirection] case final value?)
        'cameraDirection': value,
      if (_$CameraFocalLengthTypeEnumMap[instance.cameraFocalLengthType]
          case final value?)
        'cameraFocalLengthType': value,
      if (instance.deviceId case final value?) 'deviceId': value,
      if (instance.cameraId case final value?) 'cameraId': value,
      if (instance.followEncodeDimensionRatio case final value?)
        'followEncodeDimensionRatio': value,
      if (instance.format?.toJson() case final value?) 'format': value,
    };

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
      windowId: (readIntPtr(json, 'windowId') as num?)?.toInt(),
      params: json['params'] == null
          ? null
          : ScreenCaptureParameters.fromJson(
              json['params'] as Map<String, dynamic>),
      regionRect: json['regionRect'] == null
          ? null
          : Rectangle.fromJson(json['regionRect'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ScreenCaptureConfigurationToJson(
        ScreenCaptureConfiguration instance) =>
    <String, dynamic>{
      if (instance.isCaptureWindow case final value?) 'isCaptureWindow': value,
      if (instance.displayId case final value?) 'displayId': value,
      if (instance.screenRect?.toJson() case final value?) 'screenRect': value,
      if (instance.windowId case final value?) 'windowId': value,
      if (instance.params?.toJson() case final value?) 'params': value,
      if (instance.regionRect?.toJson() case final value?) 'regionRect': value,
    };

SIZE _$SIZEFromJson(Map<String, dynamic> json) => SIZE(
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SIZEToJson(SIZE instance) => <String, dynamic>{
      if (instance.width case final value?) 'width': value,
      if (instance.height case final value?) 'height': value,
    };

ThumbImageBuffer _$ThumbImageBufferFromJson(Map<String, dynamic> json) =>
    ThumbImageBuffer(
      length: (json['length'] as num?)?.toInt(),
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ThumbImageBufferToJson(ThumbImageBuffer instance) =>
    <String, dynamic>{
      if (instance.length case final value?) 'length': value,
      if (instance.width case final value?) 'width': value,
      if (instance.height case final value?) 'height': value,
    };

ScreenCaptureSourceInfo _$ScreenCaptureSourceInfoFromJson(
        Map<String, dynamic> json) =>
    ScreenCaptureSourceInfo(
      type: $enumDecodeNullable(_$ScreenCaptureSourceTypeEnumMap, json['type']),
      sourceId: (readIntPtr(json, 'sourceId') as num?)?.toInt(),
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
      sourceDisplayId: (readIntPtr(json, 'sourceDisplayId') as num?)?.toInt(),
    );

Map<String, dynamic> _$ScreenCaptureSourceInfoToJson(
        ScreenCaptureSourceInfo instance) =>
    <String, dynamic>{
      if (_$ScreenCaptureSourceTypeEnumMap[instance.type] case final value?)
        'type': value,
      if (instance.sourceId case final value?) 'sourceId': value,
      if (instance.sourceName case final value?) 'sourceName': value,
      if (instance.thumbImage?.toJson() case final value?) 'thumbImage': value,
      if (instance.iconImage?.toJson() case final value?) 'iconImage': value,
      if (instance.processPath case final value?) 'processPath': value,
      if (instance.sourceTitle case final value?) 'sourceTitle': value,
      if (instance.primaryMonitor case final value?) 'primaryMonitor': value,
      if (instance.isOccluded case final value?) 'isOccluded': value,
      if (instance.position?.toJson() case final value?) 'position': value,
      if (instance.minimizeWindow case final value?) 'minimizeWindow': value,
      if (instance.sourceDisplayId case final value?) 'sourceDisplayId': value,
    };

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
        AdvancedAudioOptions instance) =>
    <String, dynamic>{
      if (instance.audioProcessingChannels case final value?)
        'audioProcessingChannels': value,
    };

ImageTrackOptions _$ImageTrackOptionsFromJson(Map<String, dynamic> json) =>
    ImageTrackOptions(
      imageUrl: json['imageUrl'] as String?,
      fps: (json['fps'] as num?)?.toInt(),
      mirrorMode:
          $enumDecodeNullable(_$VideoMirrorModeTypeEnumMap, json['mirrorMode']),
    );

Map<String, dynamic> _$ImageTrackOptionsToJson(ImageTrackOptions instance) =>
    <String, dynamic>{
      if (instance.imageUrl case final value?) 'imageUrl': value,
      if (instance.fps case final value?) 'fps': value,
      if (_$VideoMirrorModeTypeEnumMap[instance.mirrorMode] case final value?)
        'mirrorMode': value,
    };

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

Map<String, dynamic> _$ChannelMediaOptionsToJson(
        ChannelMediaOptions instance) =>
    <String, dynamic>{
      if (instance.publishCameraTrack case final value?)
        'publishCameraTrack': value,
      if (instance.publishSecondaryCameraTrack case final value?)
        'publishSecondaryCameraTrack': value,
      if (instance.publishThirdCameraTrack case final value?)
        'publishThirdCameraTrack': value,
      if (instance.publishFourthCameraTrack case final value?)
        'publishFourthCameraTrack': value,
      if (instance.publishMicrophoneTrack case final value?)
        'publishMicrophoneTrack': value,
      if (instance.publishScreenCaptureVideo case final value?)
        'publishScreenCaptureVideo': value,
      if (instance.publishScreenCaptureAudio case final value?)
        'publishScreenCaptureAudio': value,
      if (instance.publishScreenTrack case final value?)
        'publishScreenTrack': value,
      if (instance.publishSecondaryScreenTrack case final value?)
        'publishSecondaryScreenTrack': value,
      if (instance.publishThirdScreenTrack case final value?)
        'publishThirdScreenTrack': value,
      if (instance.publishFourthScreenTrack case final value?)
        'publishFourthScreenTrack': value,
      if (instance.publishCustomAudioTrack case final value?)
        'publishCustomAudioTrack': value,
      if (instance.publishCustomAudioTrackId case final value?)
        'publishCustomAudioTrackId': value,
      if (instance.publishCustomVideoTrack case final value?)
        'publishCustomVideoTrack': value,
      if (instance.publishEncodedVideoTrack case final value?)
        'publishEncodedVideoTrack': value,
      if (instance.publishMediaPlayerAudioTrack case final value?)
        'publishMediaPlayerAudioTrack': value,
      if (instance.publishMediaPlayerVideoTrack case final value?)
        'publishMediaPlayerVideoTrack': value,
      if (instance.publishTranscodedVideoTrack case final value?)
        'publishTranscodedVideoTrack': value,
      if (instance.publishMixedAudioTrack case final value?)
        'publishMixedAudioTrack': value,
      if (instance.publishLipSyncTrack case final value?)
        'publishLipSyncTrack': value,
      if (instance.autoSubscribeAudio case final value?)
        'autoSubscribeAudio': value,
      if (instance.autoSubscribeVideo case final value?)
        'autoSubscribeVideo': value,
      if (instance.enableAudioRecordingOrPlayout case final value?)
        'enableAudioRecordingOrPlayout': value,
      if (instance.publishMediaPlayerId case final value?)
        'publishMediaPlayerId': value,
      if (_$ClientRoleTypeEnumMap[instance.clientRoleType] case final value?)
        'clientRoleType': value,
      if (_$AudienceLatencyLevelTypeEnumMap[instance.audienceLatencyLevel]
          case final value?)
        'audienceLatencyLevel': value,
      if (_$VideoStreamTypeEnumMap[instance.defaultVideoStreamType]
          case final value?)
        'defaultVideoStreamType': value,
      if (_$ChannelProfileTypeEnumMap[instance.channelProfile]
          case final value?)
        'channelProfile': value,
      if (instance.audioDelayMs case final value?) 'audioDelayMs': value,
      if (instance.mediaPlayerAudioDelayMs case final value?)
        'mediaPlayerAudioDelayMs': value,
      if (instance.token case final value?) 'token': value,
      if (instance.enableBuiltInMediaEncryption case final value?)
        'enableBuiltInMediaEncryption': value,
      if (instance.publishRhythmPlayerTrack case final value?)
        'publishRhythmPlayerTrack': value,
      if (instance.isInteractiveAudience case final value?)
        'isInteractiveAudience': value,
      if (instance.customVideoTrackId case final value?)
        'customVideoTrackId': value,
      if (instance.isAudioFilterable case final value?)
        'isAudioFilterable': value,
    };

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

Map<String, dynamic> _$LeaveChannelOptionsToJson(
        LeaveChannelOptions instance) =>
    <String, dynamic>{
      if (instance.stopAudioMixing case final value?) 'stopAudioMixing': value,
      if (instance.stopAllEffect case final value?) 'stopAllEffect': value,
      if (instance.stopMicrophoneRecording case final value?)
        'stopMicrophoneRecording': value,
    };

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

Map<String, dynamic> _$RtcEngineContextToJson(RtcEngineContext instance) =>
    <String, dynamic>{
      if (instance.appId case final value?) 'appId': value,
      if (_$ChannelProfileTypeEnumMap[instance.channelProfile]
          case final value?)
        'channelProfile': value,
      if (instance.license case final value?) 'license': value,
      if (_$AudioScenarioTypeEnumMap[instance.audioScenario] case final value?)
        'audioScenario': value,
      if (instance.areaCode case final value?) 'areaCode': value,
      if (instance.logConfig?.toJson() case final value?) 'logConfig': value,
      if (_$ThreadPriorityTypeEnumMap[instance.threadPriority]
          case final value?)
        'threadPriority': value,
      if (instance.useExternalEglContext case final value?)
        'useExternalEglContext': value,
      if (instance.domainLimit case final value?) 'domainLimit': value,
      if (instance.autoRegisterAgoraExtensions case final value?)
        'autoRegisterAgoraExtensions': value,
    };

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

Map<String, dynamic> _$MetadataToJson(Metadata instance) => <String, dynamic>{
      if (instance.uid case final value?) 'uid': value,
      if (instance.size case final value?) 'size': value,
      if (instance.timeStampMs case final value?) 'timeStampMs': value,
    };

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
        DirectCdnStreamingStats instance) =>
    <String, dynamic>{
      if (instance.videoWidth case final value?) 'videoWidth': value,
      if (instance.videoHeight case final value?) 'videoHeight': value,
      if (instance.fps case final value?) 'fps': value,
      if (instance.videoBitrate case final value?) 'videoBitrate': value,
      if (instance.audioBitrate case final value?) 'audioBitrate': value,
    };

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
        DirectCdnStreamingMediaOptions instance) =>
    <String, dynamic>{
      if (instance.publishCameraTrack case final value?)
        'publishCameraTrack': value,
      if (instance.publishMicrophoneTrack case final value?)
        'publishMicrophoneTrack': value,
      if (instance.publishCustomAudioTrack case final value?)
        'publishCustomAudioTrack': value,
      if (instance.publishCustomVideoTrack case final value?)
        'publishCustomVideoTrack': value,
      if (instance.publishMediaPlayerAudioTrack case final value?)
        'publishMediaPlayerAudioTrack': value,
      if (instance.publishMediaPlayerId case final value?)
        'publishMediaPlayerId': value,
      if (instance.customVideoTrackId case final value?)
        'customVideoTrackId': value,
    };

ExtensionInfo _$ExtensionInfoFromJson(Map<String, dynamic> json) =>
    ExtensionInfo(
      mediaSourceType: $enumDecodeNullable(
          _$MediaSourceTypeEnumMap, json['mediaSourceType']),
      remoteUid: (json['remoteUid'] as num?)?.toInt(),
      channelId: json['channelId'] as String?,
      localUid: (json['localUid'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ExtensionInfoToJson(ExtensionInfo instance) =>
    <String, dynamic>{
      if (_$MediaSourceTypeEnumMap[instance.mediaSourceType] case final value?)
        'mediaSourceType': value,
      if (instance.remoteUid case final value?) 'remoteUid': value,
      if (instance.channelId case final value?) 'channelId': value,
      if (instance.localUid case final value?) 'localUid': value,
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
  MediaSourceType.speechDrivenVideoSource: 13,
  MediaSourceType.unknownMediaSource: 100,
};

SDKBuildInfo _$SDKBuildInfoFromJson(Map<String, dynamic> json) => SDKBuildInfo(
      build: (json['build'] as num?)?.toInt(),
      version: json['version'] as String?,
    );

Map<String, dynamic> _$SDKBuildInfoToJson(SDKBuildInfo instance) =>
    <String, dynamic>{
      if (instance.build case final value?) 'build': value,
      if (instance.version case final value?) 'version': value,
    };

VideoDeviceInfo _$VideoDeviceInfoFromJson(Map<String, dynamic> json) =>
    VideoDeviceInfo(
      deviceId: json['deviceId'] as String?,
      deviceName: json['deviceName'] as String?,
    );

Map<String, dynamic> _$VideoDeviceInfoToJson(VideoDeviceInfo instance) =>
    <String, dynamic>{
      if (instance.deviceId case final value?) 'deviceId': value,
      if (instance.deviceName case final value?) 'deviceName': value,
    };

AudioDeviceInfo _$AudioDeviceInfoFromJson(Map<String, dynamic> json) =>
    AudioDeviceInfo(
      deviceId: json['deviceId'] as String?,
      deviceTypeName: json['deviceTypeName'] as String?,
      deviceName: json['deviceName'] as String?,
    );

Map<String, dynamic> _$AudioDeviceInfoToJson(AudioDeviceInfo instance) =>
    <String, dynamic>{
      if (instance.deviceId case final value?) 'deviceId': value,
      if (instance.deviceTypeName case final value?) 'deviceTypeName': value,
      if (instance.deviceName case final value?) 'deviceName': value,
    };

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
