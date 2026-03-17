// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names, deprecated_member_use_from_same_package, unused_element

part of 'agora_media_base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtensionContext _$ExtensionContextFromJson(Map<String, dynamic> json) =>
    ExtensionContext(
      isValid: json['isValid'] as bool?,
      uid: (json['uid'] as num?)?.toInt(),
      providerName: json['providerName'] as String?,
      extensionName: json['extensionName'] as String?,
    );

Map<String, dynamic> _$ExtensionContextToJson(ExtensionContext instance) =>
    <String, dynamic>{
      if (instance.isValid case final value?) 'isValid': value,
      if (instance.uid case final value?) 'uid': value,
      if (instance.providerName case final value?) 'providerName': value,
      if (instance.extensionName case final value?) 'extensionName': value,
    };

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
      audioTrackNumber: (json['audio_track_number_'] as num?)?.toInt(),
      bytesPerSample: $enumDecodeNullable(
          _$BytesPerSampleEnumMap, json['bytes_per_sample']),
      data: (json['data_'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      isStereo: json['is_stereo_'] as bool?,
    );

Map<String, dynamic> _$AudioPcmFrameToJson(AudioPcmFrame instance) =>
    <String, dynamic>{
      if (instance.captureTimestamp case final value?)
        'capture_timestamp': value,
      if (instance.samplesPerChannel case final value?)
        'samples_per_channel_': value,
      if (instance.sampleRateHz case final value?) 'sample_rate_hz_': value,
      if (instance.numChannels case final value?) 'num_channels_': value,
      if (instance.audioTrackNumber case final value?)
        'audio_track_number_': value,
      if (_$BytesPerSampleEnumMap[instance.bytesPerSample] case final value?)
        'bytes_per_sample': value,
      if (instance.data case final value?) 'data_': value,
      if (instance.isStereo case final value?) 'is_stereo_': value,
    };

const _$BytesPerSampleEnumMap = {
  BytesPerSample.twoBytesPerSample: 2,
};

ColorSpace _$ColorSpaceFromJson(Map<String, dynamic> json) => ColorSpace(
      primaries: $enumDecodeNullable(_$PrimaryIDEnumMap, json['primaries']),
      transfer: $enumDecodeNullable(_$TransferIDEnumMap, json['transfer']),
      matrix: $enumDecodeNullable(_$MatrixIDEnumMap, json['matrix']),
      range: $enumDecodeNullable(_$RangeIDEnumMap, json['range']),
    );

Map<String, dynamic> _$ColorSpaceToJson(ColorSpace instance) =>
    <String, dynamic>{
      if (_$PrimaryIDEnumMap[instance.primaries] case final value?)
        'primaries': value,
      if (_$TransferIDEnumMap[instance.transfer] case final value?)
        'transfer': value,
      if (_$MatrixIDEnumMap[instance.matrix] case final value?) 'matrix': value,
      if (_$RangeIDEnumMap[instance.range] case final value?) 'range': value,
    };

const _$PrimaryIDEnumMap = {
  PrimaryID.primaryidBt709: 1,
  PrimaryID.primaryidUnspecified: 2,
  PrimaryID.primaryidBt470m: 4,
  PrimaryID.primaryidBt470bg: 5,
  PrimaryID.primaryidSmpte170m: 6,
  PrimaryID.primaryidSmpte240m: 7,
  PrimaryID.primaryidFilm: 8,
  PrimaryID.primaryidBt2020: 9,
  PrimaryID.primaryidSmptest428: 10,
  PrimaryID.primaryidSmptest431: 11,
  PrimaryID.primaryidSmptest432: 12,
  PrimaryID.primaryidJedecp22: 22,
};

const _$TransferIDEnumMap = {
  TransferID.transferidBt709: 1,
  TransferID.transferidUnspecified: 2,
  TransferID.transferidGamma22: 4,
  TransferID.transferidGamma28: 5,
  TransferID.transferidSmpte170m: 6,
  TransferID.transferidSmpte240m: 7,
  TransferID.transferidLinear: 8,
  TransferID.transferidLog: 9,
  TransferID.transferidLogSqrt: 10,
  TransferID.transferidIec6196624: 11,
  TransferID.transferidBt1361Ecg: 12,
  TransferID.transferidIec6196621: 13,
  TransferID.transferidBt202010: 14,
  TransferID.transferidBt202012: 15,
  TransferID.transferidSmptest2084: 16,
  TransferID.transferidSmptest428: 17,
  TransferID.transferidAribStdB67: 18,
};

const _$MatrixIDEnumMap = {
  MatrixID.matrixidRgb: 0,
  MatrixID.matrixidBt709: 1,
  MatrixID.matrixidUnspecified: 2,
  MatrixID.matrixidFcc: 4,
  MatrixID.matrixidBt470bg: 5,
  MatrixID.matrixidSmpte170m: 6,
  MatrixID.matrixidSmpte240m: 7,
  MatrixID.matrixidYcocg: 8,
  MatrixID.matrixidBt2020Ncl: 9,
  MatrixID.matrixidBt2020Cl: 10,
  MatrixID.matrixidSmpte2085: 11,
  MatrixID.matrixidCdncls: 12,
  MatrixID.matrixidCdcls: 13,
  MatrixID.matrixidBt2100Ictcp: 14,
};

const _$RangeIDEnumMap = {
  RangeID.rangeidInvalid: 0,
  RangeID.rangeidLimited: 1,
  RangeID.rangeidFull: 2,
  RangeID.rangeidDerived: 3,
};

Hdr10MetadataInfo _$Hdr10MetadataInfoFromJson(Map<String, dynamic> json) =>
    Hdr10MetadataInfo(
      redPrimaryX: (json['redPrimaryX'] as num?)?.toInt(),
      redPrimaryY: (json['redPrimaryY'] as num?)?.toInt(),
      greenPrimaryX: (json['greenPrimaryX'] as num?)?.toInt(),
      greenPrimaryY: (json['greenPrimaryY'] as num?)?.toInt(),
      bluePrimaryX: (json['bluePrimaryX'] as num?)?.toInt(),
      bluePrimaryY: (json['bluePrimaryY'] as num?)?.toInt(),
      whitePointX: (json['whitePointX'] as num?)?.toInt(),
      whitePointY: (json['whitePointY'] as num?)?.toInt(),
      maxMasteringLuminance: (json['maxMasteringLuminance'] as num?)?.toInt(),
      minMasteringLuminance: (json['minMasteringLuminance'] as num?)?.toInt(),
      maxContentLightLevel: (json['maxContentLightLevel'] as num?)?.toInt(),
      maxFrameAverageLightLevel:
          (json['maxFrameAverageLightLevel'] as num?)?.toInt(),
    );

Map<String, dynamic> _$Hdr10MetadataInfoToJson(Hdr10MetadataInfo instance) =>
    <String, dynamic>{
      if (instance.redPrimaryX case final value?) 'redPrimaryX': value,
      if (instance.redPrimaryY case final value?) 'redPrimaryY': value,
      if (instance.greenPrimaryX case final value?) 'greenPrimaryX': value,
      if (instance.greenPrimaryY case final value?) 'greenPrimaryY': value,
      if (instance.bluePrimaryX case final value?) 'bluePrimaryX': value,
      if (instance.bluePrimaryY case final value?) 'bluePrimaryY': value,
      if (instance.whitePointX case final value?) 'whitePointX': value,
      if (instance.whitePointY case final value?) 'whitePointY': value,
      if (instance.maxMasteringLuminance case final value?)
        'maxMasteringLuminance': value,
      if (instance.minMasteringLuminance case final value?)
        'minMasteringLuminance': value,
      if (instance.maxContentLightLevel case final value?)
        'maxContentLightLevel': value,
      if (instance.maxFrameAverageLightLevel case final value?)
        'maxFrameAverageLightLevel': value,
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
      fenceObject: (json['fenceObject'] as num?)?.toInt(),
      matrix: (json['matrix'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      metadataSize: (json['metadataSize'] as num?)?.toInt(),
      fillAlphaBuffer: json['fillAlphaBuffer'] as bool?,
      alphaStitchMode: $enumDecodeNullable(
          _$AlphaStitchModeEnumMap, json['alphaStitchMode']),
      d3d11Texture2d: (readIntPtr(json, 'd3d11Texture2d') as num?)?.toInt(),
      textureSliceIndex: (json['textureSliceIndex'] as num?)?.toInt(),
      hdr10MetadataInfo: json['hdr10MetadataInfo'] == null
          ? null
          : Hdr10MetadataInfo.fromJson(
              json['hdr10MetadataInfo'] as Map<String, dynamic>),
      colorSpace: json['colorSpace'] == null
          ? null
          : ColorSpace.fromJson(json['colorSpace'] as Map<String, dynamic>),
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
      if (instance.fenceObject case final value?) 'fenceObject': value,
      if (instance.matrix case final value?) 'matrix': value,
      if (instance.metadataSize case final value?) 'metadataSize': value,
      if (instance.fillAlphaBuffer case final value?) 'fillAlphaBuffer': value,
      if (_$AlphaStitchModeEnumMap[instance.alphaStitchMode] case final value?)
        'alphaStitchMode': value,
      if (instance.d3d11Texture2d case final value?) 'd3d11Texture2d': value,
      if (instance.textureSliceIndex case final value?)
        'textureSliceIndex': value,
      if (instance.hdr10MetadataInfo?.toJson() case final value?)
        'hdr10MetadataInfo': value,
      if (instance.colorSpace?.toJson() case final value?) 'colorSpace': value,
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
  VideoPixelFormat.videoCvpixelP010: 15,
  VideoPixelFormat.videoPixelI422: 16,
  VideoPixelFormat.videoTextureId3d11texture2d: 17,
  VideoPixelFormat.videoPixelI010: 18,
};

const _$EglContextTypeEnumMap = {
  EglContextType.eglContext10: 0,
  EglContextType.eglContext14: 1,
};

const _$AlphaStitchModeEnumMap = {
  AlphaStitchMode.noAlphaStitch: 0,
  AlphaStitchMode.alphaStitchUp: 1,
  AlphaStitchMode.alphaStitchBelow: 2,
  AlphaStitchMode.alphaStitchLeft: 3,
  AlphaStitchMode.alphaStitchRight: 4,
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
      alphaStitchMode: $enumDecodeNullable(
          _$AlphaStitchModeEnumMap, json['alphaStitchMode']),
      metaInfo: const VideoFrameMetaInfoConverter().fromJson(json['metaInfo']),
      hdr10MetadataInfo: json['hdr10MetadataInfo'] == null
          ? null
          : Hdr10MetadataInfo.fromJson(
              json['hdr10MetadataInfo'] as Map<String, dynamic>),
      colorSpace: json['colorSpace'] == null
          ? null
          : ColorSpace.fromJson(json['colorSpace'] as Map<String, dynamic>),
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
      if (_$AlphaStitchModeEnumMap[instance.alphaStitchMode] case final value?)
        'alphaStitchMode': value,
      if (const VideoFrameMetaInfoConverter().toJson(instance.metaInfo)
          case final value?)
        'metaInfo': value,
      if (instance.hdr10MetadataInfo?.toJson() case final value?)
        'hdr10MetadataInfo': value,
      if (instance.colorSpace?.toJson() case final value?) 'colorSpace': value,
    };

ContentInspectModule _$ContentInspectModuleFromJson(
        Map<String, dynamic> json) =>
    ContentInspectModule(
      type: $enumDecodeNullable(_$ContentInspectTypeEnumMap, json['type']),
      interval: (json['interval'] as num?)?.toInt(),
      position:
          $enumDecodeNullable(_$VideoModulePositionEnumMap, json['position']),
    );

Map<String, dynamic> _$ContentInspectModuleToJson(
        ContentInspectModule instance) =>
    <String, dynamic>{
      if (_$ContentInspectTypeEnumMap[instance.type] case final value?)
        'type': value,
      if (instance.interval case final value?) 'interval': value,
      if (_$VideoModulePositionEnumMap[instance.position] case final value?)
        'position': value,
    };

const _$ContentInspectTypeEnumMap = {
  ContentInspectType.contentInspectInvalid: 0,
  ContentInspectType.contentInspectModeration: 1,
  ContentInspectType.contentInspectSupervision: 2,
  ContentInspectType.contentInspectImageModeration: 3,
};

const _$VideoModulePositionEnumMap = {
  VideoModulePosition.positionPostCapturer: 1,
  VideoModulePosition.positionPreRenderer: 2,
  VideoModulePosition.positionPreEncoder: 4,
  VideoModulePosition.positionPostCapturerOrigin: 8,
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

SnapshotConfig _$SnapshotConfigFromJson(Map<String, dynamic> json) =>
    SnapshotConfig(
      filePath: json['filePath'] as String?,
      position:
          $enumDecodeNullable(_$VideoModulePositionEnumMap, json['position']),
    );

Map<String, dynamic> _$SnapshotConfigToJson(SnapshotConfig instance) =>
    <String, dynamic>{
      if (instance.filePath case final value?) 'filePath': value,
      if (_$VideoModulePositionEnumMap[instance.position] case final value?)
        'position': value,
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
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      fps: (json['fps'] as num?)?.toInt(),
      sampleRate: (json['sample_rate'] as num?)?.toInt(),
      channelNum: (json['channel_num'] as num?)?.toInt(),
      videoSourceType: $enumDecodeNullable(
          _$VideoSourceTypeEnumMap, json['videoSourceType']),
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
      if (instance.width case final value?) 'width': value,
      if (instance.height case final value?) 'height': value,
      if (instance.fps case final value?) 'fps': value,
      if (instance.sampleRate case final value?) 'sample_rate': value,
      if (instance.channelNum case final value?) 'channel_num': value,
      if (_$VideoSourceTypeEnumMap[instance.videoSourceType] case final value?)
        'videoSourceType': value,
    };

const _$MediaRecorderContainerFormatEnumMap = {
  MediaRecorderContainerFormat.formatMp4: 1,
};

const _$MediaRecorderStreamTypeEnumMap = {
  MediaRecorderStreamType.streamTypeAudio: 1,
  MediaRecorderStreamType.streamTypeVideo: 2,
  MediaRecorderStreamType.streamTypeBoth: 3,
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

const _$AudioSourceTypeEnumMap = {
  AudioSourceType.audioSourceMicrophone: 0,
  AudioSourceType.audioSourceCustom: 1,
  AudioSourceType.audioSourceMediaPlayer: 2,
  AudioSourceType.audioSourceLoopbackRecording: 3,
  AudioSourceType.audioSourceMixedStream: 4,
  AudioSourceType.audioSourceRemoteUser: 5,
  AudioSourceType.audioSourceRemoteChannel: 6,
  AudioSourceType.audioSourceUnknown: 100,
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

const _$ContentInspectResultEnumMap = {
  ContentInspectResult.contentInspectNeutral: 1,
  ContentInspectResult.contentInspectSexy: 2,
  ContentInspectResult.contentInspectPorn: 3,
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
