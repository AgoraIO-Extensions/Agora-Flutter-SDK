// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names, deprecated_member_use_from_same_package, unused_element

part of 'agora_media_base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioParameters _$AudioParametersFromJson(Map<String, dynamic> json) =>
    AudioParameters(
      sampleRate: (json['sample_rate'] as num?)?.toInt(),
      channels: (json['channels'] as num?)?.toInt(),
      framesPerBuffer: (json['frames_per_buffer'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AudioParametersToJson(AudioParameters instance) =>
    <String, dynamic>{
      if (instance.sampleRate case final value?) 'sample_rate': value,
      if (instance.channels case final value?) 'channels': value,
      if (instance.framesPerBuffer case final value?)
        'frames_per_buffer': value,
    };

ContentInspectModule _$ContentInspectModuleFromJson(
        Map<String, dynamic> json) =>
    ContentInspectModule(
      type: $enumDecodeNullable(_$ContentInspectTypeEnumMap, json['type']),
      interval: (json['interval'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ContentInspectModuleToJson(
        ContentInspectModule instance) =>
    <String, dynamic>{
      if (_$ContentInspectTypeEnumMap[instance.type] case final value?)
        'type': value,
      if (instance.interval case final value?) 'interval': value,
    };

const _$ContentInspectTypeEnumMap = {
  ContentInspectType.contentInspectInvalid: 0,
  ContentInspectType.contentInspectModeration: 1,
  ContentInspectType.contentInspectSupervision: 2,
  ContentInspectType.contentInspectImageModeration: 3,
};

ContentInspectConfig _$ContentInspectConfigFromJson(
        Map<String, dynamic> json) =>
    ContentInspectConfig(
      extraInfo: json['extraInfo'] as String?,
      serverConfig: json['serverConfig'] as String?,
      modules: (json['modules'] as List<dynamic>?)
          ?.map((e) => ContentInspectModule.fromJson(e as Map<String, dynamic>))
          .toList(),
      moduleCount: (json['moduleCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ContentInspectConfigToJson(
        ContentInspectConfig instance) =>
    <String, dynamic>{
      if (instance.extraInfo case final value?) 'extraInfo': value,
      if (instance.serverConfig case final value?) 'serverConfig': value,
      if (instance.modules?.map((e) => e.toJson()).toList() case final value?)
        'modules': value,
      if (instance.moduleCount case final value?) 'moduleCount': value,
    };

PacketOptions _$PacketOptionsFromJson(Map<String, dynamic> json) =>
    PacketOptions(
      timestamp: (json['timestamp'] as num?)?.toInt(),
      audioLevelIndication: (json['audioLevelIndication'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PacketOptionsToJson(PacketOptions instance) =>
    <String, dynamic>{
      if (instance.timestamp case final value?) 'timestamp': value,
      if (instance.audioLevelIndication case final value?)
        'audioLevelIndication': value,
    };

AudioEncodedFrameInfo _$AudioEncodedFrameInfoFromJson(
        Map<String, dynamic> json) =>
    AudioEncodedFrameInfo(
      sendTs: (json['sendTs'] as num?)?.toInt(),
      codec: (json['codec'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AudioEncodedFrameInfoToJson(
        AudioEncodedFrameInfo instance) =>
    <String, dynamic>{
      if (instance.sendTs case final value?) 'sendTs': value,
      if (instance.codec case final value?) 'codec': value,
    };

AudioPcmFrame _$AudioPcmFrameFromJson(Map<String, dynamic> json) =>
    AudioPcmFrame(
      captureTimestamp: (json['capture_timestamp'] as num?)?.toInt(),
      samplesPerChannel: (json['samples_per_channel_'] as num?)?.toInt(),
      sampleRateHz: (json['sample_rate_hz_'] as num?)?.toInt(),
      numChannels: (json['num_channels_'] as num?)?.toInt(),
      bytesPerSample: $enumDecodeNullable(
          _$BytesPerSampleEnumMap, json['bytes_per_sample']),
      data: (json['data_'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$AudioPcmFrameToJson(AudioPcmFrame instance) =>
    <String, dynamic>{
      if (instance.captureTimestamp case final value?)
        'capture_timestamp': value,
      if (instance.samplesPerChannel case final value?)
        'samples_per_channel_': value,
      if (instance.sampleRateHz case final value?) 'sample_rate_hz_': value,
      if (instance.numChannels case final value?) 'num_channels_': value,
      if (_$BytesPerSampleEnumMap[instance.bytesPerSample] case final value?)
        'bytes_per_sample': value,
      if (instance.data case final value?) 'data_': value,
    };

const _$BytesPerSampleEnumMap = {
  BytesPerSample.twoBytesPerSample: 2,
};

ExternalVideoFrame _$ExternalVideoFrameFromJson(Map<String, dynamic> json) =>
    ExternalVideoFrame(
      type: $enumDecodeNullable(_$VideoBufferTypeEnumMap, json['type']),
      format: $enumDecodeNullable(_$VideoPixelFormatEnumMap, json['format']),
      stride: (json['stride'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      cropLeft: (json['cropLeft'] as num?)?.toInt(),
      cropTop: (json['cropTop'] as num?)?.toInt(),
      cropRight: (json['cropRight'] as num?)?.toInt(),
      cropBottom: (json['cropBottom'] as num?)?.toInt(),
      rotation: (json['rotation'] as num?)?.toInt(),
      timestamp: (json['timestamp'] as num?)?.toInt(),
      eglType: $enumDecodeNullable(_$EglContextTypeEnumMap, json['eglType']),
      textureId: (json['textureId'] as num?)?.toInt(),
      matrix: (json['matrix'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      metadataSize: (json['metadata_size'] as num?)?.toInt(),
      fillAlphaBuffer: json['fillAlphaBuffer'] as bool?,
      textureSliceIndex: (json['texture_slice_index'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ExternalVideoFrameToJson(ExternalVideoFrame instance) =>
    <String, dynamic>{
      if (_$VideoBufferTypeEnumMap[instance.type] case final value?)
        'type': value,
      if (_$VideoPixelFormatEnumMap[instance.format] case final value?)
        'format': value,
      if (instance.stride case final value?) 'stride': value,
      if (instance.height case final value?) 'height': value,
      if (instance.cropLeft case final value?) 'cropLeft': value,
      if (instance.cropTop case final value?) 'cropTop': value,
      if (instance.cropRight case final value?) 'cropRight': value,
      if (instance.cropBottom case final value?) 'cropBottom': value,
      if (instance.rotation case final value?) 'rotation': value,
      if (instance.timestamp case final value?) 'timestamp': value,
      if (_$EglContextTypeEnumMap[instance.eglType] case final value?)
        'eglType': value,
      if (instance.textureId case final value?) 'textureId': value,
      if (instance.matrix case final value?) 'matrix': value,
      if (instance.metadataSize case final value?) 'metadata_size': value,
      if (instance.fillAlphaBuffer case final value?) 'fillAlphaBuffer': value,
      if (instance.textureSliceIndex case final value?)
        'texture_slice_index': value,
    };

const _$VideoBufferTypeEnumMap = {
  VideoBufferType.videoBufferRawData: 1,
  VideoBufferType.videoBufferArray: 2,
  VideoBufferType.videoBufferTexture: 3,
};

const _$VideoPixelFormatEnumMap = {
  VideoPixelFormat.videoPixelDefault: 0,
  VideoPixelFormat.videoPixelI420: 1,
  VideoPixelFormat.videoPixelBgra: 2,
  VideoPixelFormat.videoPixelNv21: 3,
  VideoPixelFormat.videoPixelRgba: 4,
  VideoPixelFormat.videoPixelNv12: 8,
  VideoPixelFormat.videoTexture2d: 10,
  VideoPixelFormat.videoTextureOes: 11,
  VideoPixelFormat.videoCvpixelNv12: 12,
  VideoPixelFormat.videoCvpixelI420: 13,
  VideoPixelFormat.videoCvpixelBgra: 14,
  VideoPixelFormat.videoPixelI422: 16,
  VideoPixelFormat.videoTextureId3d11texture2d: 17,
  VideoPixelFormat.videoPixelI010: 18,
};

const _$EglContextTypeEnumMap = {
  EglContextType.eglContext10: 0,
  EglContextType.eglContext14: 1,
};

VideoFrame _$VideoFrameFromJson(Map<String, dynamic> json) => VideoFrame(
      type: $enumDecodeNullable(_$VideoPixelFormatEnumMap, json['type']),
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      yStride: (json['yStride'] as num?)?.toInt(),
      uStride: (json['uStride'] as num?)?.toInt(),
      vStride: (json['vStride'] as num?)?.toInt(),
      rotation: (json['rotation'] as num?)?.toInt(),
      renderTimeMs: (json['renderTimeMs'] as num?)?.toInt(),
      avsyncType: (json['avsync_type'] as num?)?.toInt(),
      metadataSize: (json['metadata_size'] as num?)?.toInt(),
      textureId: (json['textureId'] as num?)?.toInt(),
      matrix: (json['matrix'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      metaInfo: const VideoFrameMetaInfoConverter().fromJson(json['metaInfo']),
    );

Map<String, dynamic> _$VideoFrameToJson(VideoFrame instance) =>
    <String, dynamic>{
      if (_$VideoPixelFormatEnumMap[instance.type] case final value?)
        'type': value,
      if (instance.width case final value?) 'width': value,
      if (instance.height case final value?) 'height': value,
      if (instance.yStride case final value?) 'yStride': value,
      if (instance.uStride case final value?) 'uStride': value,
      if (instance.vStride case final value?) 'vStride': value,
      if (instance.rotation case final value?) 'rotation': value,
      if (instance.renderTimeMs case final value?) 'renderTimeMs': value,
      if (instance.avsyncType case final value?) 'avsync_type': value,
      if (instance.metadataSize case final value?) 'metadata_size': value,
      if (instance.textureId case final value?) 'textureId': value,
      if (instance.matrix case final value?) 'matrix': value,
      if (const VideoFrameMetaInfoConverter().toJson(instance.metaInfo)
          case final value?)
        'metaInfo': value,
    };

AudioFrame _$AudioFrameFromJson(Map<String, dynamic> json) => AudioFrame(
      type: $enumDecodeNullable(_$AudioFrameTypeEnumMap, json['type']),
      samplesPerChannel: (json['samplesPerChannel'] as num?)?.toInt(),
      bytesPerSample:
          $enumDecodeNullable(_$BytesPerSampleEnumMap, json['bytesPerSample']),
      channels: (json['channels'] as num?)?.toInt(),
      samplesPerSec: (json['samplesPerSec'] as num?)?.toInt(),
      renderTimeMs: (json['renderTimeMs'] as num?)?.toInt(),
      avsyncType: (json['avsync_type'] as num?)?.toInt(),
      presentationMs: (json['presentationMs'] as num?)?.toInt(),
      audioTrackNumber: (json['audioTrackNumber'] as num?)?.toInt(),
      rtpTimestamp: (json['rtpTimestamp'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AudioFrameToJson(AudioFrame instance) =>
    <String, dynamic>{
      if (_$AudioFrameTypeEnumMap[instance.type] case final value?)
        'type': value,
      if (instance.samplesPerChannel case final value?)
        'samplesPerChannel': value,
      if (_$BytesPerSampleEnumMap[instance.bytesPerSample] case final value?)
        'bytesPerSample': value,
      if (instance.channels case final value?) 'channels': value,
      if (instance.samplesPerSec case final value?) 'samplesPerSec': value,
      if (instance.renderTimeMs case final value?) 'renderTimeMs': value,
      if (instance.avsyncType case final value?) 'avsync_type': value,
      if (instance.presentationMs case final value?) 'presentationMs': value,
      if (instance.audioTrackNumber case final value?)
        'audioTrackNumber': value,
      if (instance.rtpTimestamp case final value?) 'rtpTimestamp': value,
    };

const _$AudioFrameTypeEnumMap = {
  AudioFrameType.frameTypePcm16: 0,
};

AudioParams _$AudioParamsFromJson(Map<String, dynamic> json) => AudioParams(
      sampleRate: (json['sample_rate'] as num?)?.toInt(),
      channels: (json['channels'] as num?)?.toInt(),
      mode: $enumDecodeNullable(_$RawAudioFrameOpModeTypeEnumMap, json['mode']),
      samplesPerCall: (json['samples_per_call'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AudioParamsToJson(AudioParams instance) =>
    <String, dynamic>{
      if (instance.sampleRate case final value?) 'sample_rate': value,
      if (instance.channels case final value?) 'channels': value,
      if (_$RawAudioFrameOpModeTypeEnumMap[instance.mode] case final value?)
        'mode': value,
      if (instance.samplesPerCall case final value?) 'samples_per_call': value,
    };

const _$RawAudioFrameOpModeTypeEnumMap = {
  RawAudioFrameOpModeType.rawAudioFrameOpModeReadOnly: 0,
  RawAudioFrameOpModeType.rawAudioFrameOpModeReadWrite: 2,
};

AudioSpectrumData _$AudioSpectrumDataFromJson(Map<String, dynamic> json) =>
    AudioSpectrumData(
      audioSpectrumData: (json['audioSpectrumData'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      dataLength: (json['dataLength'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AudioSpectrumDataToJson(AudioSpectrumData instance) =>
    <String, dynamic>{
      if (instance.audioSpectrumData case final value?)
        'audioSpectrumData': value,
      if (instance.dataLength case final value?) 'dataLength': value,
    };

UserAudioSpectrumInfo _$UserAudioSpectrumInfoFromJson(
        Map<String, dynamic> json) =>
    UserAudioSpectrumInfo(
      uid: (json['uid'] as num?)?.toInt(),
      spectrumData: json['spectrumData'] == null
          ? null
          : AudioSpectrumData.fromJson(
              json['spectrumData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserAudioSpectrumInfoToJson(
        UserAudioSpectrumInfo instance) =>
    <String, dynamic>{
      if (instance.uid case final value?) 'uid': value,
      if (instance.spectrumData?.toJson() case final value?)
        'spectrumData': value,
    };

MediaRecorderConfiguration _$MediaRecorderConfigurationFromJson(
        Map<String, dynamic> json) =>
    MediaRecorderConfiguration(
      storagePath: json['storagePath'] as String?,
      containerFormat: $enumDecodeNullable(
          _$MediaRecorderContainerFormatEnumMap, json['containerFormat']),
      streamType: $enumDecodeNullable(
          _$MediaRecorderStreamTypeEnumMap, json['streamType']),
      maxDurationMs: (json['maxDurationMs'] as num?)?.toInt(),
      recorderInfoUpdateInterval:
          (json['recorderInfoUpdateInterval'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MediaRecorderConfigurationToJson(
        MediaRecorderConfiguration instance) =>
    <String, dynamic>{
      if (instance.storagePath case final value?) 'storagePath': value,
      if (_$MediaRecorderContainerFormatEnumMap[instance.containerFormat]
          case final value?)
        'containerFormat': value,
      if (_$MediaRecorderStreamTypeEnumMap[instance.streamType]
          case final value?)
        'streamType': value,
      if (instance.maxDurationMs case final value?) 'maxDurationMs': value,
      if (instance.recorderInfoUpdateInterval case final value?)
        'recorderInfoUpdateInterval': value,
    };

const _$MediaRecorderContainerFormatEnumMap = {
  MediaRecorderContainerFormat.formatMp4: 1,
};

const _$MediaRecorderStreamTypeEnumMap = {
  MediaRecorderStreamType.streamTypeAudio: 1,
  MediaRecorderStreamType.streamTypeVideo: 2,
  MediaRecorderStreamType.streamTypeBoth: 3,
};

RecorderInfo _$RecorderInfoFromJson(Map<String, dynamic> json) => RecorderInfo(
      fileName: json['fileName'] as String?,
      durationMs: (json['durationMs'] as num?)?.toInt(),
      fileSize: (json['fileSize'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RecorderInfoToJson(RecorderInfo instance) =>
    <String, dynamic>{
      if (instance.fileName case final value?) 'fileName': value,
      if (instance.durationMs case final value?) 'durationMs': value,
      if (instance.fileSize case final value?) 'fileSize': value,
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

const _$AudioRouteEnumMap = {
  AudioRoute.routeDefault: -1,
  AudioRoute.routeHeadset: 0,
  AudioRoute.routeEarpiece: 1,
  AudioRoute.routeHeadsetnomic: 2,
  AudioRoute.routeSpeakerphone: 3,
  AudioRoute.routeLoudspeaker: 4,
  AudioRoute.routeBluetoothDeviceHfp: 5,
  AudioRoute.routeUsb: 6,
  AudioRoute.routeHdmi: 7,
  AudioRoute.routeDisplayport: 8,
  AudioRoute.routeAirplay: 9,
  AudioRoute.routeBluetoothDeviceA2dp: 10,
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

const _$ContentInspectResultEnumMap = {
  ContentInspectResult.contentInspectNeutral: 1,
  ContentInspectResult.contentInspectSexy: 2,
  ContentInspectResult.contentInspectPorn: 3,
};

const _$AudioDualMonoModeEnumMap = {
  AudioDualMonoMode.audioDualMonoStereo: 0,
  AudioDualMonoMode.audioDualMonoL: 1,
  AudioDualMonoMode.audioDualMonoR: 2,
  AudioDualMonoMode.audioDualMonoMix: 3,
};

const _$RenderModeTypeEnumMap = {
  RenderModeType.renderModeHidden: 1,
  RenderModeType.renderModeFit: 2,
  RenderModeType.renderModeAdaptive: 3,
};

const _$CameraVideoSourceTypeEnumMap = {
  CameraVideoSourceType.cameraSourceFront: 0,
  CameraVideoSourceType.cameraSourceBack: 1,
  CameraVideoSourceType.videoSourceUnspecified: 2,
};

const _$MetaInfoKeyEnumMap = {
  MetaInfoKey.keyFaceCapture: 0,
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
  VideoModulePosition.positionPostCapturerOrigin: 8,
};

const _$AudioFramePositionEnumMap = {
  AudioFramePosition.audioFramePositionNone: 0,
  AudioFramePosition.audioFramePositionPlayback: 1,
  AudioFramePosition.audioFramePositionRecord: 2,
  AudioFramePosition.audioFramePositionMixed: 4,
  AudioFramePosition.audioFramePositionBeforeMixing: 8,
  AudioFramePosition.audioFramePositionEarMonitoring: 16,
};

const _$VideoFrameProcessModeEnumMap = {
  VideoFrameProcessMode.processModeReadOnly: 0,
  VideoFrameProcessMode.processModeReadWrite: 1,
};

const _$ExternalVideoSourceTypeEnumMap = {
  ExternalVideoSourceType.videoFrame: 0,
  ExternalVideoSourceType.encodedVideoFrame: 1,
};

const _$RecorderStateEnumMap = {
  RecorderState.recorderStateError: -1,
  RecorderState.recorderStateStart: 2,
  RecorderState.recorderStateStop: 3,
};

const _$RecorderReasonCodeEnumMap = {
  RecorderReasonCode.recorderReasonNone: 0,
  RecorderReasonCode.recorderReasonWriteFailed: 1,
  RecorderReasonCode.recorderReasonNoStream: 2,
  RecorderReasonCode.recorderReasonOverMaxDuration: 3,
  RecorderReasonCode.recorderReasonConfigChanged: 4,
};
