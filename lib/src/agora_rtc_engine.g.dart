// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names, deprecated_member_use_from_same_package, unused_element

part of 'agora_rtc_engine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalVideoStats _$LocalVideoStatsFromJson(Map<String, dynamic> json) =>
    LocalVideoStats(
      uid: json['uid'] as int?,
      sentBitrate: json['sentBitrate'] as int?,
      sentFrameRate: json['sentFrameRate'] as int?,
      captureFrameRate: json['captureFrameRate'] as int?,
      captureFrameWidth: json['captureFrameWidth'] as int?,
      captureFrameHeight: json['captureFrameHeight'] as int?,
      regulatedCaptureFrameRate: json['regulatedCaptureFrameRate'] as int?,
      regulatedCaptureFrameWidth: json['regulatedCaptureFrameWidth'] as int?,
      regulatedCaptureFrameHeight: json['regulatedCaptureFrameHeight'] as int?,
      encoderOutputFrameRate: json['encoderOutputFrameRate'] as int?,
      encodedFrameWidth: json['encodedFrameWidth'] as int?,
      encodedFrameHeight: json['encodedFrameHeight'] as int?,
      rendererOutputFrameRate: json['rendererOutputFrameRate'] as int?,
      targetBitrate: json['targetBitrate'] as int?,
      targetFrameRate: json['targetFrameRate'] as int?,
      qualityAdaptIndication: $enumDecodeNullable(
          _$QualityAdaptIndicationEnumMap, json['qualityAdaptIndication']),
      encodedBitrate: json['encodedBitrate'] as int?,
      encodedFrameCount: json['encodedFrameCount'] as int?,
      codecType:
          $enumDecodeNullable(_$VideoCodecTypeEnumMap, json['codecType']),
      txPacketLossRate: json['txPacketLossRate'] as int?,
    );

Map<String, dynamic> _$LocalVideoStatsToJson(LocalVideoStats instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'sentBitrate': instance.sentBitrate,
      'sentFrameRate': instance.sentFrameRate,
      'captureFrameRate': instance.captureFrameRate,
      'captureFrameWidth': instance.captureFrameWidth,
      'captureFrameHeight': instance.captureFrameHeight,
      'regulatedCaptureFrameRate': instance.regulatedCaptureFrameRate,
      'regulatedCaptureFrameWidth': instance.regulatedCaptureFrameWidth,
      'regulatedCaptureFrameHeight': instance.regulatedCaptureFrameHeight,
      'encoderOutputFrameRate': instance.encoderOutputFrameRate,
      'encodedFrameWidth': instance.encodedFrameWidth,
      'encodedFrameHeight': instance.encodedFrameHeight,
      'rendererOutputFrameRate': instance.rendererOutputFrameRate,
      'targetBitrate': instance.targetBitrate,
      'targetFrameRate': instance.targetFrameRate,
      'qualityAdaptIndication':
          _$QualityAdaptIndicationEnumMap[instance.qualityAdaptIndication],
      'encodedBitrate': instance.encodedBitrate,
      'encodedFrameCount': instance.encodedFrameCount,
      'codecType': _$VideoCodecTypeEnumMap[instance.codecType],
      'txPacketLossRate': instance.txPacketLossRate,
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
  VideoCodecType.videoCodecVp9: 5,
  VideoCodecType.videoCodecGeneric: 6,
  VideoCodecType.videoCodecGenericH264: 7,
  VideoCodecType.videoCodecAv1: 12,
  VideoCodecType.videoCodecGenericJpeg: 20,
};

RemoteVideoStats _$RemoteVideoStatsFromJson(Map<String, dynamic> json) =>
    RemoteVideoStats(
      uid: json['uid'] as int?,
      delay: json['delay'] as int?,
      width: json['width'] as int?,
      height: json['height'] as int?,
      receivedBitrate: json['receivedBitrate'] as int?,
      decoderOutputFrameRate: json['decoderOutputFrameRate'] as int?,
      rendererOutputFrameRate: json['rendererOutputFrameRate'] as int?,
      frameLossRate: json['frameLossRate'] as int?,
      packetLossRate: json['packetLossRate'] as int?,
      rxStreamType:
          $enumDecodeNullable(_$VideoStreamTypeEnumMap, json['rxStreamType']),
      totalFrozenTime: json['totalFrozenTime'] as int?,
      frozenRate: json['frozenRate'] as int?,
      avSyncTimeMs: json['avSyncTimeMs'] as int?,
      totalActiveTime: json['totalActiveTime'] as int?,
      publishDuration: json['publishDuration'] as int?,
      superResolutionType: json['superResolutionType'] as int?,
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
      'frameLossRate': instance.frameLossRate,
      'packetLossRate': instance.packetLossRate,
      'rxStreamType': _$VideoStreamTypeEnumMap[instance.rxStreamType],
      'totalFrozenTime': instance.totalFrozenTime,
      'frozenRate': instance.frozenRate,
      'avSyncTimeMs': instance.avSyncTimeMs,
      'totalActiveTime': instance.totalActiveTime,
      'publishDuration': instance.publishDuration,
      'superResolutionType': instance.superResolutionType,
    };

const _$VideoStreamTypeEnumMap = {
  VideoStreamType.videoStreamHigh: 0,
  VideoStreamType.videoStreamLow: 1,
};

VideoCompositingLayout _$VideoCompositingLayoutFromJson(
        Map<String, dynamic> json) =>
    VideoCompositingLayout(
      canvasWidth: json['canvasWidth'] as int?,
      canvasHeight: json['canvasHeight'] as int?,
      backgroundColor: json['backgroundColor'] as String?,
      regions: (json['regions'] as List<dynamic>?)
          ?.map((e) => Region.fromJson(e as Map<String, dynamic>))
          .toList(),
      regionCount: json['regionCount'] as int?,
      appDataLength: json['appDataLength'] as int?,
    );

Map<String, dynamic> _$VideoCompositingLayoutToJson(
        VideoCompositingLayout instance) =>
    <String, dynamic>{
      'canvasWidth': instance.canvasWidth,
      'canvasHeight': instance.canvasHeight,
      'backgroundColor': instance.backgroundColor,
      'regions': instance.regions?.map((e) => e.toJson()).toList(),
      'regionCount': instance.regionCount,
      'appDataLength': instance.appDataLength,
    };

Region _$RegionFromJson(Map<String, dynamic> json) => Region(
      uid: json['uid'] as int?,
      x: (json['x'] as num?)?.toDouble(),
      y: (json['y'] as num?)?.toDouble(),
      width: (json['width'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      zOrder: json['zOrder'] as int?,
      alpha: (json['alpha'] as num?)?.toDouble(),
      renderMode:
          $enumDecodeNullable(_$RenderModeTypeEnumMap, json['renderMode']),
    );

Map<String, dynamic> _$RegionToJson(Region instance) => <String, dynamic>{
      'uid': instance.uid,
      'x': instance.x,
      'y': instance.y,
      'width': instance.width,
      'height': instance.height,
      'zOrder': instance.zOrder,
      'alpha': instance.alpha,
      'renderMode': _$RenderModeTypeEnumMap[instance.renderMode],
    };

const _$RenderModeTypeEnumMap = {
  RenderModeType.renderModeHidden: 1,
  RenderModeType.renderModeFit: 2,
  RenderModeType.renderModeAdaptive: 3,
};

InjectStreamConfig _$InjectStreamConfigFromJson(Map<String, dynamic> json) =>
    InjectStreamConfig(
      width: json['width'] as int?,
      height: json['height'] as int?,
      videoGop: json['videoGop'] as int?,
      videoFramerate: json['videoFramerate'] as int?,
      videoBitrate: json['videoBitrate'] as int?,
      audioSampleRate: $enumDecodeNullable(
          _$AudioSampleRateTypeEnumMap, json['audioSampleRate']),
      audioBitrate: json['audioBitrate'] as int?,
      audioChannels: json['audioChannels'] as int?,
    );

Map<String, dynamic> _$InjectStreamConfigToJson(InjectStreamConfig instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'videoGop': instance.videoGop,
      'videoFramerate': instance.videoFramerate,
      'videoBitrate': instance.videoBitrate,
      'audioSampleRate': _$AudioSampleRateTypeEnumMap[instance.audioSampleRate],
      'audioBitrate': instance.audioBitrate,
      'audioChannels': instance.audioChannels,
    };

const _$AudioSampleRateTypeEnumMap = {
  AudioSampleRateType.audioSampleRate32000: 32000,
  AudioSampleRateType.audioSampleRate44100: 44100,
  AudioSampleRateType.audioSampleRate48000: 48000,
};

PublisherConfiguration _$PublisherConfigurationFromJson(
        Map<String, dynamic> json) =>
    PublisherConfiguration(
      width: json['width'] as int?,
      height: json['height'] as int?,
      framerate: json['framerate'] as int?,
      bitrate: json['bitrate'] as int?,
      defaultLayout: json['defaultLayout'] as int?,
      lifecycle: json['lifecycle'] as int?,
      owner: json['owner'] as bool?,
      injectStreamWidth: json['injectStreamWidth'] as int?,
      injectStreamHeight: json['injectStreamHeight'] as int?,
      injectStreamUrl: json['injectStreamUrl'] as String?,
      publishUrl: json['publishUrl'] as String?,
      rawStreamUrl: json['rawStreamUrl'] as String?,
      extraInfo: json['extraInfo'] as String?,
    );

Map<String, dynamic> _$PublisherConfigurationToJson(
        PublisherConfiguration instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'framerate': instance.framerate,
      'bitrate': instance.bitrate,
      'defaultLayout': instance.defaultLayout,
      'lifecycle': instance.lifecycle,
      'owner': instance.owner,
      'injectStreamWidth': instance.injectStreamWidth,
      'injectStreamHeight': instance.injectStreamHeight,
      'injectStreamUrl': instance.injectStreamUrl,
      'publishUrl': instance.publishUrl,
      'rawStreamUrl': instance.rawStreamUrl,
      'extraInfo': instance.extraInfo,
    };

AudioTrackConfig _$AudioTrackConfigFromJson(Map<String, dynamic> json) =>
    AudioTrackConfig(
      enableLocalPlayback: json['enableLocalPlayback'] as bool?,
    );

Map<String, dynamic> _$AudioTrackConfigToJson(AudioTrackConfig instance) =>
    <String, dynamic>{
      'enableLocalPlayback': instance.enableLocalPlayback,
    };

CameraCapturerConfiguration _$CameraCapturerConfigurationFromJson(
        Map<String, dynamic> json) =>
    CameraCapturerConfiguration(
      cameraDirection: $enumDecodeNullable(
          _$CameraDirectionEnumMap, json['cameraDirection']),
      deviceId: json['deviceId'] as String?,
      format: json['format'] == null
          ? null
          : VideoFormat.fromJson(json['format'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CameraCapturerConfigurationToJson(
        CameraCapturerConfiguration instance) =>
    <String, dynamic>{
      'cameraDirection': _$CameraDirectionEnumMap[instance.cameraDirection],
      'deviceId': instance.deviceId,
      'format': instance.format?.toJson(),
    };

const _$CameraDirectionEnumMap = {
  CameraDirection.cameraRear: 0,
  CameraDirection.cameraFront: 1,
};

ScreenCaptureConfiguration _$ScreenCaptureConfigurationFromJson(
        Map<String, dynamic> json) =>
    ScreenCaptureConfiguration(
      isCaptureWindow: json['isCaptureWindow'] as bool?,
      displayId: json['displayId'] as int?,
      screenRect: json['screenRect'] == null
          ? null
          : Rectangle.fromJson(json['screenRect'] as Map<String, dynamic>),
      windowId: json['windowId'] as int?,
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
      'isCaptureWindow': instance.isCaptureWindow,
      'displayId': instance.displayId,
      'screenRect': instance.screenRect?.toJson(),
      'windowId': instance.windowId,
      'params': instance.params?.toJson(),
      'regionRect': instance.regionRect?.toJson(),
    };

AudioOptionsExternal _$AudioOptionsExternalFromJson(
        Map<String, dynamic> json) =>
    AudioOptionsExternal(
      enableAecExternalCustom: json['enable_aec_external_custom_'] as bool?,
      enableAgcExternalCustom: json['enable_agc_external_custom_'] as bool?,
      enableAnsExternalCustom: json['enable_ans_external_custom_'] as bool?,
      aecAggressivenessExternalCustom: $enumDecodeNullable(
          _$NlpAggressivenessEnumMap,
          json['aec_aggressiveness_external_custom_']),
      enableAecExternalLoopback: json['enable_aec_external_loopback_'] as bool?,
    );

Map<String, dynamic> _$AudioOptionsExternalToJson(
        AudioOptionsExternal instance) =>
    <String, dynamic>{
      'enable_aec_external_custom_': instance.enableAecExternalCustom,
      'enable_agc_external_custom_': instance.enableAgcExternalCustom,
      'enable_ans_external_custom_': instance.enableAnsExternalCustom,
      'aec_aggressiveness_external_custom_':
          _$NlpAggressivenessEnumMap[instance.aecAggressivenessExternalCustom],
      'enable_aec_external_loopback_': instance.enableAecExternalLoopback,
    };

const _$NlpAggressivenessEnumMap = {
  NlpAggressiveness.nlpNotSpecified: 0,
  NlpAggressiveness.nlpMild: 1,
  NlpAggressiveness.nlpNormal: 2,
  NlpAggressiveness.nlpAggressive: 3,
  NlpAggressiveness.nlpSuperAggressive: 4,
  NlpAggressiveness.nlpExtreme: 5,
};

Size _$SizeFromJson(Map<String, dynamic> json) => Size(
      width: json['width'] as int?,
      height: json['height'] as int?,
    );

Map<String, dynamic> _$SizeToJson(Size instance) => <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
    };

ThumbImageBuffer _$ThumbImageBufferFromJson(Map<String, dynamic> json) =>
    ThumbImageBuffer(
      length: json['length'] as int?,
      width: json['width'] as int?,
      height: json['height'] as int?,
    );

Map<String, dynamic> _$ThumbImageBufferToJson(ThumbImageBuffer instance) =>
    <String, dynamic>{
      'length': instance.length,
      'width': instance.width,
      'height': instance.height,
    };

ScreenCaptureSourceInfo _$ScreenCaptureSourceInfoFromJson(
        Map<String, dynamic> json) =>
    ScreenCaptureSourceInfo(
      type: $enumDecodeNullable(_$ScreenCaptureSourceTypeEnumMap, json['type']),
      sourceId: json['sourceId'] as int?,
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
    );

Map<String, dynamic> _$ScreenCaptureSourceInfoToJson(
        ScreenCaptureSourceInfo instance) =>
    <String, dynamic>{
      'type': _$ScreenCaptureSourceTypeEnumMap[instance.type],
      'sourceId': instance.sourceId,
      'sourceName': instance.sourceName,
      'thumbImage': instance.thumbImage?.toJson(),
      'iconImage': instance.iconImage?.toJson(),
      'processPath': instance.processPath,
      'sourceTitle': instance.sourceTitle,
      'primaryMonitor': instance.primaryMonitor,
      'isOccluded': instance.isOccluded,
    };

const _$ScreenCaptureSourceTypeEnumMap = {
  ScreenCaptureSourceType.screencapturesourcetypeUnknown: -1,
  ScreenCaptureSourceType.screencapturesourcetypeWindow: 0,
  ScreenCaptureSourceType.screencapturesourcetypeScreen: 1,
  ScreenCaptureSourceType.screencapturesourcetypeCustom: 2,
};

ChannelMediaOptions _$ChannelMediaOptionsFromJson(Map<String, dynamic> json) =>
    ChannelMediaOptions(
      publishCameraTrack: json['publishCameraTrack'] as bool?,
      publishSecondaryCameraTrack: json['publishSecondaryCameraTrack'] as bool?,
      publishAudioTrack: json['publishAudioTrack'] as bool?,
      publishScreenTrack: json['publishScreenTrack'] as bool?,
      publishSecondaryScreenTrack: json['publishSecondaryScreenTrack'] as bool?,
      publishCustomAudioTrack: json['publishCustomAudioTrack'] as bool?,
      publishCustomAudioSourceId: json['publishCustomAudioSourceId'] as int?,
      publishCustomAudioTrackEnableAec:
          json['publishCustomAudioTrackEnableAec'] as bool?,
      publishDirectCustomAudioTrack:
          json['publishDirectCustomAudioTrack'] as bool?,
      publishCustomAudioTrackAec: json['publishCustomAudioTrackAec'] as bool?,
      publishCustomVideoTrack: json['publishCustomVideoTrack'] as bool?,
      publishEncodedVideoTrack: json['publishEncodedVideoTrack'] as bool?,
      publishMediaPlayerAudioTrack:
          json['publishMediaPlayerAudioTrack'] as bool?,
      publishMediaPlayerVideoTrack:
          json['publishMediaPlayerVideoTrack'] as bool?,
      publishTrancodedVideoTrack: json['publishTrancodedVideoTrack'] as bool?,
      autoSubscribeAudio: json['autoSubscribeAudio'] as bool?,
      autoSubscribeVideo: json['autoSubscribeVideo'] as bool?,
      startPreview: json['startPreview'] as bool?,
      enableAudioRecordingOrPlayout:
          json['enableAudioRecordingOrPlayout'] as bool?,
      publishMediaPlayerId: json['publishMediaPlayerId'] as int?,
      clientRoleType:
          $enumDecodeNullable(_$ClientRoleTypeEnumMap, json['clientRoleType']),
      audienceLatencyLevel: $enumDecodeNullable(
          _$AudienceLatencyLevelTypeEnumMap, json['audienceLatencyLevel']),
      defaultVideoStreamType: $enumDecodeNullable(
          _$VideoStreamTypeEnumMap, json['defaultVideoStreamType']),
      channelProfile: $enumDecodeNullable(
          _$ChannelProfileTypeEnumMap, json['channelProfile']),
      audioDelayMs: json['audioDelayMs'] as int?,
      mediaPlayerAudioDelayMs: json['mediaPlayerAudioDelayMs'] as int?,
      token: json['token'] as String?,
      enableBuiltInMediaEncryption:
          json['enableBuiltInMediaEncryption'] as bool?,
      publishRhythmPlayerTrack: json['publishRhythmPlayerTrack'] as bool?,
      audioOptionsExternal: json['audioOptionsExternal'] == null
          ? null
          : AudioOptionsExternal.fromJson(
              json['audioOptionsExternal'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChannelMediaOptionsToJson(
        ChannelMediaOptions instance) =>
    <String, dynamic>{
      'publishCameraTrack': instance.publishCameraTrack,
      'publishSecondaryCameraTrack': instance.publishSecondaryCameraTrack,
      'publishAudioTrack': instance.publishAudioTrack,
      'publishScreenTrack': instance.publishScreenTrack,
      'publishSecondaryScreenTrack': instance.publishSecondaryScreenTrack,
      'publishCustomAudioTrack': instance.publishCustomAudioTrack,
      'publishCustomAudioSourceId': instance.publishCustomAudioSourceId,
      'publishCustomAudioTrackEnableAec':
          instance.publishCustomAudioTrackEnableAec,
      'publishDirectCustomAudioTrack': instance.publishDirectCustomAudioTrack,
      'publishCustomAudioTrackAec': instance.publishCustomAudioTrackAec,
      'publishCustomVideoTrack': instance.publishCustomVideoTrack,
      'publishEncodedVideoTrack': instance.publishEncodedVideoTrack,
      'publishMediaPlayerAudioTrack': instance.publishMediaPlayerAudioTrack,
      'publishMediaPlayerVideoTrack': instance.publishMediaPlayerVideoTrack,
      'publishTrancodedVideoTrack': instance.publishTrancodedVideoTrack,
      'autoSubscribeAudio': instance.autoSubscribeAudio,
      'autoSubscribeVideo': instance.autoSubscribeVideo,
      'startPreview': instance.startPreview,
      'enableAudioRecordingOrPlayout': instance.enableAudioRecordingOrPlayout,
      'publishMediaPlayerId': instance.publishMediaPlayerId,
      'clientRoleType': _$ClientRoleTypeEnumMap[instance.clientRoleType],
      'audienceLatencyLevel':
          _$AudienceLatencyLevelTypeEnumMap[instance.audienceLatencyLevel],
      'defaultVideoStreamType':
          _$VideoStreamTypeEnumMap[instance.defaultVideoStreamType],
      'channelProfile': _$ChannelProfileTypeEnumMap[instance.channelProfile],
      'audioDelayMs': instance.audioDelayMs,
      'mediaPlayerAudioDelayMs': instance.mediaPlayerAudioDelayMs,
      'token': instance.token,
      'enableBuiltInMediaEncryption': instance.enableBuiltInMediaEncryption,
      'publishRhythmPlayerTrack': instance.publishRhythmPlayerTrack,
      'audioOptionsExternal': instance.audioOptionsExternal?.toJson(),
    };

const _$ClientRoleTypeEnumMap = {
  ClientRoleType.clientRoleBroadcaster: 1,
  ClientRoleType.clientRoleAudience: 2,
};

const _$AudienceLatencyLevelTypeEnumMap = {
  AudienceLatencyLevelType.audienceLatencyLevelLowLatency: 1,
  AudienceLatencyLevelType.audienceLatencyLevelUltraLowLatency: 2,
  AudienceLatencyLevelType.audienceLatencyLevelHighLatency: 3,
};

const _$ChannelProfileTypeEnumMap = {
  ChannelProfileType.channelProfileCommunication: 0,
  ChannelProfileType.channelProfileLiveBroadcasting: 1,
  ChannelProfileType.channelProfileGame: 2,
  ChannelProfileType.channelProfileCloudGaming: 3,
  ChannelProfileType.channelProfileCommunication1v1: 4,
  ChannelProfileType.channelProfileLiveBroadcasting2: 5,
};

LocalAccessPointConfiguration _$LocalAccessPointConfigurationFromJson(
        Map<String, dynamic> json) =>
    LocalAccessPointConfiguration(
      ipList:
          (json['ipList'] as List<dynamic>?)?.map((e) => e as String).toList(),
      ipListSize: json['ipListSize'] as int?,
      domainList: (json['domainList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      domainListSize: json['domainListSize'] as int?,
      verifyDomainName: json['verifyDomainName'] as String?,
      mode: $enumDecodeNullable(_$LocalProxyModeEnumMap, json['mode']),
    );

Map<String, dynamic> _$LocalAccessPointConfigurationToJson(
        LocalAccessPointConfiguration instance) =>
    <String, dynamic>{
      'ipList': instance.ipList,
      'ipListSize': instance.ipListSize,
      'domainList': instance.domainList,
      'domainListSize': instance.domainListSize,
      'verifyDomainName': instance.verifyDomainName,
      'mode': _$LocalProxyModeEnumMap[instance.mode],
    };

const _$LocalProxyModeEnumMap = {
  LocalProxyMode.kConnectivityFirst: 0,
  LocalProxyMode.kLocalOnly: 1,
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
      'stopAudioMixing': instance.stopAudioMixing,
      'stopAllEffect': instance.stopAllEffect,
      'stopMicrophoneRecording': instance.stopMicrophoneRecording,
    };

RtcEngineContext _$RtcEngineContextFromJson(Map<String, dynamic> json) =>
    RtcEngineContext(
      appId: json['appId'] as String?,
      enableAudioDevice: json['enableAudioDevice'] as bool?,
      channelProfile: $enumDecodeNullable(
          _$ChannelProfileTypeEnumMap, json['channelProfile']),
      audioScenario: $enumDecodeNullable(
          _$AudioScenarioTypeEnumMap, json['audioScenario']),
      areaCode: json['areaCode'] as int?,
      logConfig: json['logConfig'] == null
          ? null
          : LogConfig.fromJson(json['logConfig'] as Map<String, dynamic>),
      threadPriority: $enumDecodeNullable(
          _$ThreadPriorityTypeEnumMap, json['threadPriority']),
      useExternalEglContext: json['useExternalEglContext'] as bool?,
    );

Map<String, dynamic> _$RtcEngineContextToJson(RtcEngineContext instance) =>
    <String, dynamic>{
      'appId': instance.appId,
      'enableAudioDevice': instance.enableAudioDevice,
      'channelProfile': _$ChannelProfileTypeEnumMap[instance.channelProfile],
      'audioScenario': _$AudioScenarioTypeEnumMap[instance.audioScenario],
      'areaCode': instance.areaCode,
      'logConfig': instance.logConfig?.toJson(),
      'threadPriority': _$ThreadPriorityTypeEnumMap[instance.threadPriority],
      'useExternalEglContext': instance.useExternalEglContext,
    };

const _$AudioScenarioTypeEnumMap = {
  AudioScenarioType.audioScenarioDefault: 0,
  AudioScenarioType.audioScenarioGameStreaming: 3,
  AudioScenarioType.audioScenarioChatroom: 5,
  AudioScenarioType.audioScenarioHighDefinition: 6,
  AudioScenarioType.audioScenarioChorus: 7,
  AudioScenarioType.audioScenarioNum: 8,
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
      uid: json['uid'] as int?,
      size: json['size'] as int?,
      timeStampMs: json['timeStampMs'] as int?,
    );

Map<String, dynamic> _$MetadataToJson(Metadata instance) => <String, dynamic>{
      'uid': instance.uid,
      'size': instance.size,
      'timeStampMs': instance.timeStampMs,
    };

DirectCdnStreamingStats _$DirectCdnStreamingStatsFromJson(
        Map<String, dynamic> json) =>
    DirectCdnStreamingStats(
      videoWidth: json['videoWidth'] as int?,
      videoHeight: json['videoHeight'] as int?,
      fps: json['fps'] as int?,
      videoBitrate: json['videoBitrate'] as int?,
      audioBitrate: json['audioBitrate'] as int?,
    );

Map<String, dynamic> _$DirectCdnStreamingStatsToJson(
        DirectCdnStreamingStats instance) =>
    <String, dynamic>{
      'videoWidth': instance.videoWidth,
      'videoHeight': instance.videoHeight,
      'fps': instance.fps,
      'videoBitrate': instance.videoBitrate,
      'audioBitrate': instance.audioBitrate,
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
      publishMediaPlayerId: json['publishMediaPlayerId'] as int?,
    );

Map<String, dynamic> _$DirectCdnStreamingMediaOptionsToJson(
        DirectCdnStreamingMediaOptions instance) =>
    <String, dynamic>{
      'publishCameraTrack': instance.publishCameraTrack,
      'publishMicrophoneTrack': instance.publishMicrophoneTrack,
      'publishCustomAudioTrack': instance.publishCustomAudioTrack,
      'publishCustomVideoTrack': instance.publishCustomVideoTrack,
      'publishMediaPlayerAudioTrack': instance.publishMediaPlayerAudioTrack,
      'publishMediaPlayerId': instance.publishMediaPlayerId,
    };

SDKBuildInfo _$SDKBuildInfoFromJson(Map<String, dynamic> json) => SDKBuildInfo(
      build: json['build'] as int?,
      version: json['version'] as String?,
    );

Map<String, dynamic> _$SDKBuildInfoToJson(SDKBuildInfo instance) =>
    <String, dynamic>{
      'build': instance.build,
      'version': instance.version,
    };

VideoDeviceInfo _$VideoDeviceInfoFromJson(Map<String, dynamic> json) =>
    VideoDeviceInfo(
      deviceId: json['deviceId'] as String?,
      deviceName: json['deviceName'] as String?,
    );

Map<String, dynamic> _$VideoDeviceInfoToJson(VideoDeviceInfo instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'deviceName': instance.deviceName,
    };

AudioDeviceInfo _$AudioDeviceInfoFromJson(Map<String, dynamic> json) =>
    AudioDeviceInfo(
      deviceId: json['deviceId'] as String?,
      deviceName: json['deviceName'] as String?,
    );

Map<String, dynamic> _$AudioDeviceInfoToJson(AudioDeviceInfo instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'deviceName': instance.deviceName,
    };

const _$MediaDeviceTypeEnumMap = {
  MediaDeviceType.unknownAudioDevice: -1,
  MediaDeviceType.audioPlayoutDevice: 0,
  MediaDeviceType.audioRecordingDevice: 1,
  MediaDeviceType.videoRenderDevice: 2,
  MediaDeviceType.videoCaptureDevice: 3,
  MediaDeviceType.audioApplicationPlayoutDevice: 4,
};

const _$AudioMixingStateTypeEnumMap = {
  AudioMixingStateType.audioMixingStatePlaying: 710,
  AudioMixingStateType.audioMixingStatePaused: 711,
  AudioMixingStateType.audioMixingStateStopped: 713,
  AudioMixingStateType.audioMixingStateFailed: 714,
  AudioMixingStateType.audioMixingStateCompleted: 715,
  AudioMixingStateType.audioMixingStateAllLoopsCompleted: 716,
};

const _$AudioMixingErrorTypeEnumMap = {
  AudioMixingErrorType.audioMixingErrorCanNotOpen: 701,
  AudioMixingErrorType.audioMixingErrorTooFrequentCall: 702,
  AudioMixingErrorType.audioMixingErrorInterruptedEof: 703,
  AudioMixingErrorType.audioMixingErrorOk: 0,
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

const _$MetadataTypeEnumMap = {
  MetadataType.unknownMetadata: -1,
  MetadataType.videoMetadata: 0,
};

const _$MaxMetadataSizeTypeEnumMap = {
  MaxMetadataSizeType.invalidMetadataSizeInByte: -1,
  MaxMetadataSizeType.defaultMetadataSizeInByte: 512,
  MaxMetadataSizeType.maxMetadataSizeInByte: 1024,
};

const _$DirectCdnStreamingErrorEnumMap = {
  DirectCdnStreamingError.directCdnStreamingErrorOk: 0,
  DirectCdnStreamingError.directCdnStreamingErrorFailed: 1,
  DirectCdnStreamingError.directCdnStreamingErrorAudioPublication: 2,
  DirectCdnStreamingError.directCdnStreamingErrorVideoPublication: 3,
  DirectCdnStreamingError.directCdnStreamingErrorNetConnect: 4,
  DirectCdnStreamingError.directCdnStreamingErrorBadName: 5,
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
