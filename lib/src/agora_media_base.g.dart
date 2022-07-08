// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names, deprecated_member_use_from_same_package, unused_element

part of 'agora_media_base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioParameters _$AudioParametersFromJson(Map<String, dynamic> json) =>
    AudioParameters(
      sampleRate: json['sample_rate'] as int?,
      channels: json['channels'] as int?,
      framesPerBuffer: json['frames_per_buffer'] as int?,
    );

Map<String, dynamic> _$AudioParametersToJson(AudioParameters instance) =>
    <String, dynamic>{
      'sample_rate': instance.sampleRate,
      'channels': instance.channels,
      'frames_per_buffer': instance.framesPerBuffer,
    };

PacketOptions _$PacketOptionsFromJson(Map<String, dynamic> json) =>
    PacketOptions(
      timestamp: json['timestamp'] as int?,
      audioLevelIndication: json['audioLevelIndication'] as int?,
    );

Map<String, dynamic> _$PacketOptionsToJson(PacketOptions instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'audioLevelIndication': instance.audioLevelIndication,
    };

AdvancedAudioOptions _$AdvancedAudioOptionsFromJson(
        Map<String, dynamic> json) =>
    AdvancedAudioOptions(
      audioProcessingChannels: $enumDecodeNullable(
          _$AudioProcessingChannelsEnumMap, json['audioProcessingChannels']),
    );

Map<String, dynamic> _$AdvancedAudioOptionsToJson(
        AdvancedAudioOptions instance) =>
    <String, dynamic>{
      'audioProcessingChannels':
          _$AudioProcessingChannelsEnumMap[instance.audioProcessingChannels],
    };

const _$AudioProcessingChannelsEnumMap = {
  AudioProcessingChannels.audioProcessingMono: 1,
  AudioProcessingChannels.audioProcessingStereo: 2,
};

AudioEncodedFrameInfo _$AudioEncodedFrameInfoFromJson(
        Map<String, dynamic> json) =>
    AudioEncodedFrameInfo(
      sendTs: json['sendTs'] as int?,
      codec: json['codec'] as int?,
    );

Map<String, dynamic> _$AudioEncodedFrameInfoToJson(
        AudioEncodedFrameInfo instance) =>
    <String, dynamic>{
      'sendTs': instance.sendTs,
      'codec': instance.codec,
    };

AudioPcmFrame _$AudioPcmFrameFromJson(Map<String, dynamic> json) =>
    AudioPcmFrame(
      captureTimestamp: json['capture_timestamp'] as int?,
      samplesPerChannel: json['samples_per_channel_'] as int?,
      sampleRateHz: json['sample_rate_hz_'] as int?,
      numChannels: json['num_channels_'] as int?,
      bytesPerSample: $enumDecodeNullable(
          _$BytesPerSampleEnumMap, json['bytes_per_sample']),
      data: (json['data_'] as List<dynamic>?)?.map((e) => e as int).toList(),
    );

Map<String, dynamic> _$AudioPcmFrameToJson(AudioPcmFrame instance) =>
    <String, dynamic>{
      'capture_timestamp': instance.captureTimestamp,
      'samples_per_channel_': instance.samplesPerChannel,
      'sample_rate_hz_': instance.sampleRateHz,
      'num_channels_': instance.numChannels,
      'bytes_per_sample': _$BytesPerSampleEnumMap[instance.bytesPerSample],
      'data_': instance.data,
    };

const _$BytesPerSampleEnumMap = {
  BytesPerSample.twoBytesPerSample: 2,
};

AudioSpectrumData _$AudioSpectrumDataFromJson(Map<String, dynamic> json) =>
    AudioSpectrumData(
      audioSpectrumData: (json['audioSpectrumData'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      dataLength: json['dataLength'] as int?,
    );

Map<String, dynamic> _$AudioSpectrumDataToJson(AudioSpectrumData instance) =>
    <String, dynamic>{
      'audioSpectrumData': instance.audioSpectrumData,
      'dataLength': instance.dataLength,
    };

UserAudioSpectrumInfo _$UserAudioSpectrumInfoFromJson(
        Map<String, dynamic> json) =>
    UserAudioSpectrumInfo(
      uid: json['uid'] as int?,
      spectrumData: json['spectrumData'] == null
          ? null
          : AudioSpectrumData.fromJson(
              json['spectrumData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserAudioSpectrumInfoToJson(
        UserAudioSpectrumInfo instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'spectrumData': instance.spectrumData?.toJson(),
    };

ContentInspectModule _$ContentInspectModuleFromJson(
        Map<String, dynamic> json) =>
    ContentInspectModule(
      type: $enumDecodeNullable(_$ContentInspectTypeEnumMap, json['type']),
      frequency: json['frequency'] as int?,
    );

Map<String, dynamic> _$ContentInspectModuleToJson(
        ContentInspectModule instance) =>
    <String, dynamic>{
      'type': _$ContentInspectTypeEnumMap[instance.type],
      'frequency': instance.frequency,
    };

const _$ContentInspectTypeEnumMap = {
  ContentInspectType.contentInspectInvalide: 0,
  ContentInspectType.contentInspectModeration: 1,
  ContentInspectType.contentInspectSupervise: 2,
};

ContentInspectConfig _$ContentInspectConfigFromJson(
        Map<String, dynamic> json) =>
    ContentInspectConfig(
      enable: json['enable'] as bool?,
      deviceWork: json['DeviceWork'] as bool?,
      cloudWork: json['CloudWork'] as bool?,
      deviceworkType: $enumDecodeNullable(
          _$ContentInspectDeviceTypeEnumMap, json['DeviceworkType']),
      extraInfo: json['extraInfo'] as String?,
      modules: (json['modules'] as List<dynamic>?)
          ?.map((e) => ContentInspectModule.fromJson(e as Map<String, dynamic>))
          .toList(),
      moduleCount: json['moduleCount'] as int?,
    );

Map<String, dynamic> _$ContentInspectConfigToJson(
        ContentInspectConfig instance) =>
    <String, dynamic>{
      'enable': instance.enable,
      'DeviceWork': instance.deviceWork,
      'CloudWork': instance.cloudWork,
      'DeviceworkType':
          _$ContentInspectDeviceTypeEnumMap[instance.deviceworkType],
      'extraInfo': instance.extraInfo,
      'modules': instance.modules?.map((e) => e.toJson()).toList(),
      'moduleCount': instance.moduleCount,
    };

const _$ContentInspectDeviceTypeEnumMap = {
  ContentInspectDeviceType.contentInspectDeviceInvalid: 0,
  ContentInspectDeviceType.contentInspectDeviceAgora: 1,
  ContentInspectDeviceType.contentInspectDeviceHive: 2,
  ContentInspectDeviceType.contentInspectDeviceTupu: 3,
};

SnapShotConfig _$SnapShotConfigFromJson(Map<String, dynamic> json) =>
    SnapShotConfig(
      channel: json['channel'] as String?,
      uid: json['uid'] as int?,
      filePath: json['filePath'] as String?,
    );

Map<String, dynamic> _$SnapShotConfigToJson(SnapShotConfig instance) =>
    <String, dynamic>{
      'channel': instance.channel,
      'uid': instance.uid,
      'filePath': instance.filePath,
    };

const _$AudioRouteEnumMap = {
  AudioRoute.routeDefault: -1,
  AudioRoute.routeHeadset: 0,
  AudioRoute.routeEarpiece: 1,
  AudioRoute.routeHeadsetnomic: 2,
  AudioRoute.routeSpeakerphone: 3,
  AudioRoute.routeLoudspeaker: 4,
  AudioRoute.routeHeadsetbluetooth: 5,
  AudioRoute.routeHdmi: 6,
  AudioRoute.routeUsb: 7,
};

const _$NlpAggressivenessEnumMap = {
  NlpAggressiveness.nlpNotSpecified: 0,
  NlpAggressiveness.nlpMild: 1,
  NlpAggressiveness.nlpNormal: 2,
  NlpAggressiveness.nlpAggressive: 3,
  NlpAggressiveness.nlpSuperAggressive: 4,
  NlpAggressiveness.nlpExtreme: 5,
};

const _$RawAudioFrameOpModeTypeEnumMap = {
  RawAudioFrameOpModeType.rawAudioFrameOpModeReadOnly: 0,
  RawAudioFrameOpModeType.rawAudioFrameOpModeReadWrite: 2,
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

const _$AudioDualMonoModeEnumMap = {
  AudioDualMonoMode.audioDualMonoStereo: 0,
  AudioDualMonoMode.audioDualMonoL: 1,
  AudioDualMonoMode.audioDualMonoR: 2,
  AudioDualMonoMode.audioDualMonoMix: 3,
};

const _$VideoPixelFormatEnumMap = {
  VideoPixelFormat.videoPixelUnknown: 0,
  VideoPixelFormat.videoPixelI420: 1,
  VideoPixelFormat.videoPixelBgra: 2,
  VideoPixelFormat.videoPixelNv21: 3,
  VideoPixelFormat.videoPixelRgba: 4,
  VideoPixelFormat.videoPixelNv12: 8,
  VideoPixelFormat.videoTexture2d: 10,
  VideoPixelFormat.videoTextureOes: 11,
  VideoPixelFormat.videoPixelI422: 16,
};

const _$RenderModeTypeEnumMap = {
  RenderModeType.renderModeHidden: 1,
  RenderModeType.renderModeFit: 2,
  RenderModeType.renderModeAdaptive: 3,
};

const _$EglContextTypeEnumMap = {
  EglContextType.eglContext10: 0,
  EglContextType.eglContext14: 1,
};

const _$VideoBufferTypeEnumMap = {
  VideoBufferType.videoBufferRawData: 1,
  VideoBufferType.videoBufferArray: 2,
  VideoBufferType.videoBufferTexture: 3,
};

const _$MediaPlayerSourceTypeEnumMap = {
  MediaPlayerSourceType.mediaPlayerSourceDefault: 0,
  MediaPlayerSourceType.mediaPlayerSourceFullFeatured: 1,
  MediaPlayerSourceType.mediaPlayerSourceSimple: 2,
};

const _$VideoModulePositionEnumMap = {
  VideoModulePosition.positionPostCapturer: 1,
  VideoModulePosition.positionPreRenderer: 2,
  VideoModulePosition.positionPreEncoder: 4,
  VideoModulePosition.positionPostFilters: 8,
};

const _$AudioFrameTypeEnumMap = {
  AudioFrameType.frameTypePcm16: 0,
};

const _$VideoFrameProcessModeEnumMap = {
  VideoFrameProcessMode.processModeReadOnly: 0,
  VideoFrameProcessMode.processModeReadWrite: 1,
};

const _$ContentInspectResultEnumMap = {
  ContentInspectResult.contentInspectNeutral: 1,
  ContentInspectResult.contentInspectSexy: 2,
  ContentInspectResult.contentInspectPorn: 3,
};

const _$ExternalVideoSourceTypeEnumMap = {
  ExternalVideoSourceType.videoFrame: 0,
  ExternalVideoSourceType.encodedVideoFrame: 1,
};
