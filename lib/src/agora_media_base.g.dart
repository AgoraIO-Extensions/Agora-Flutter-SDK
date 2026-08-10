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

Map<String, dynamic> _$ExtensionContextToJson(ExtensionContext instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('isValid', instance.isValid);
  writeNotNull('uid', instance.uid);
  writeNotNull('providerName', instance.providerName);
  writeNotNull('extensionName', instance.extensionName);
  return val;
}

AudioParameters _$AudioParametersFromJson(Map<String, dynamic> json) =>
    AudioParameters(
      sampleRate: (json['sample_rate'] as num?)?.toInt(),
      channels: (json['channels'] as num?)?.toInt(),
      framesPerBuffer: (json['frames_per_buffer'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AudioParametersToJson(AudioParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sample_rate', instance.sampleRate);
  writeNotNull('channels', instance.channels);
  writeNotNull('frames_per_buffer', instance.framesPerBuffer);
  return val;
}

ContentInspectModule _$ContentInspectModuleFromJson(
        Map<String, dynamic> json) =>
    ContentInspectModule(
      type: $enumDecodeNullable(_$ContentInspectTypeEnumMap, json['type']),
      interval: (json['interval'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ContentInspectModuleToJson(
    ContentInspectModule instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', _$ContentInspectTypeEnumMap[instance.type]);
  writeNotNull('interval', instance.interval);
  return val;
}

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
    ContentInspectConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('extraInfo', instance.extraInfo);
  writeNotNull('serverConfig', instance.serverConfig);
  writeNotNull('modules', instance.modules?.map((e) => e.toJson()).toList());
  writeNotNull('moduleCount', instance.moduleCount);
  return val;
}

PacketOptions _$PacketOptionsFromJson(Map<String, dynamic> json) =>
    PacketOptions(
      timestamp: (json['timestamp'] as num?)?.toInt(),
      audioLevelIndication: (json['audioLevelIndication'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PacketOptionsToJson(PacketOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('timestamp', instance.timestamp);
  writeNotNull('audioLevelIndication', instance.audioLevelIndication);
  return val;
}

AudioEncodedFrameInfo _$AudioEncodedFrameInfoFromJson(
        Map<String, dynamic> json) =>
    AudioEncodedFrameInfo(
      sendTs: (json['sendTs'] as num?)?.toInt(),
      codec: (json['codec'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AudioEncodedFrameInfoToJson(
    AudioEncodedFrameInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sendTs', instance.sendTs);
  writeNotNull('codec', instance.codec);
  return val;
}

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

Map<String, dynamic> _$AudioPcmFrameToJson(AudioPcmFrame instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('capture_timestamp', instance.captureTimestamp);
  writeNotNull('samples_per_channel_', instance.samplesPerChannel);
  writeNotNull('sample_rate_hz_', instance.sampleRateHz);
  writeNotNull('num_channels_', instance.numChannels);
  writeNotNull('audio_track_number_', instance.audioTrackNumber);
  writeNotNull(
      'bytes_per_sample', _$BytesPerSampleEnumMap[instance.bytesPerSample]);
  writeNotNull('data_', instance.data);
  writeNotNull('is_stereo_', instance.isStereo);
  return val;
}

const _$BytesPerSampleEnumMap = {
  BytesPerSample.twoBytesPerSample: 2,
};

ColorSpace _$ColorSpaceFromJson(Map<String, dynamic> json) => ColorSpace(
      primaries: $enumDecodeNullable(_$PrimaryIDEnumMap, json['primaries']),
      transfer: $enumDecodeNullable(_$TransferIDEnumMap, json['transfer']),
      matrix: $enumDecodeNullable(_$MatrixIDEnumMap, json['matrix']),
      range: $enumDecodeNullable(_$RangeIDEnumMap, json['range']),
    );

Map<String, dynamic> _$ColorSpaceToJson(ColorSpace instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('primaries', _$PrimaryIDEnumMap[instance.primaries]);
  writeNotNull('transfer', _$TransferIDEnumMap[instance.transfer]);
  writeNotNull('matrix', _$MatrixIDEnumMap[instance.matrix]);
  writeNotNull('range', _$RangeIDEnumMap[instance.range]);
  return val;
}

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

Map<String, dynamic> _$Hdr10MetadataInfoToJson(Hdr10MetadataInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('redPrimaryX', instance.redPrimaryX);
  writeNotNull('redPrimaryY', instance.redPrimaryY);
  writeNotNull('greenPrimaryX', instance.greenPrimaryX);
  writeNotNull('greenPrimaryY', instance.greenPrimaryY);
  writeNotNull('bluePrimaryX', instance.bluePrimaryX);
  writeNotNull('bluePrimaryY', instance.bluePrimaryY);
  writeNotNull('whitePointX', instance.whitePointX);
  writeNotNull('whitePointY', instance.whitePointY);
  writeNotNull('maxMasteringLuminance', instance.maxMasteringLuminance);
  writeNotNull('minMasteringLuminance', instance.minMasteringLuminance);
  writeNotNull('maxContentLightLevel', instance.maxContentLightLevel);
  writeNotNull('maxFrameAverageLightLevel', instance.maxFrameAverageLightLevel);
  return val;
}

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

Map<String, dynamic> _$ExternalVideoFrameToJson(ExternalVideoFrame instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', _$VideoBufferTypeEnumMap[instance.type]);
  writeNotNull('format', _$VideoPixelFormatEnumMap[instance.format]);
  writeNotNull('stride', instance.stride);
  writeNotNull('height', instance.height);
  writeNotNull('cropLeft', instance.cropLeft);
  writeNotNull('cropTop', instance.cropTop);
  writeNotNull('cropRight', instance.cropRight);
  writeNotNull('cropBottom', instance.cropBottom);
  writeNotNull('rotation', instance.rotation);
  writeNotNull('timestamp', instance.timestamp);
  writeNotNull('eglType', _$EglContextTypeEnumMap[instance.eglType]);
  writeNotNull('textureId', instance.textureId);
  writeNotNull('fenceObject', instance.fenceObject);
  writeNotNull('matrix', instance.matrix);
  writeNotNull('metadataSize', instance.metadataSize);
  writeNotNull('fillAlphaBuffer', instance.fillAlphaBuffer);
  writeNotNull(
      'alphaStitchMode', _$AlphaStitchModeEnumMap[instance.alphaStitchMode]);
  writeNotNull('d3d11Texture2d', instance.d3d11Texture2d);
  writeNotNull('textureSliceIndex', instance.textureSliceIndex);
  writeNotNull('hdr10MetadataInfo', instance.hdr10MetadataInfo?.toJson());
  writeNotNull('colorSpace', instance.colorSpace?.toJson());
  return val;
}

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

Map<String, dynamic> _$VideoFrameToJson(VideoFrame instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', _$VideoPixelFormatEnumMap[instance.type]);
  writeNotNull('width', instance.width);
  writeNotNull('height', instance.height);
  writeNotNull('yStride', instance.yStride);
  writeNotNull('uStride', instance.uStride);
  writeNotNull('vStride', instance.vStride);
  writeNotNull('rotation', instance.rotation);
  writeNotNull('renderTimeMs', instance.renderTimeMs);
  writeNotNull('avsync_type', instance.avsyncType);
  writeNotNull('metadata_size', instance.metadataSize);
  writeNotNull('textureId', instance.textureId);
  writeNotNull('matrix', instance.matrix);
  writeNotNull(
      'alphaStitchMode', _$AlphaStitchModeEnumMap[instance.alphaStitchMode]);
  writeNotNull('metaInfo',
      const VideoFrameMetaInfoConverter().toJson(instance.metaInfo));
  writeNotNull('hdr10MetadataInfo', instance.hdr10MetadataInfo?.toJson());
  writeNotNull('colorSpace', instance.colorSpace?.toJson());
  return val;
}

SnapshotConfig _$SnapshotConfigFromJson(Map<String, dynamic> json) =>
    SnapshotConfig(
      filePath: json['filePath'] as String?,
      position:
          $enumDecodeNullable(_$VideoModulePositionEnumMap, json['position']),
    );

Map<String, dynamic> _$SnapshotConfigToJson(SnapshotConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('filePath', instance.filePath);
  writeNotNull('position', _$VideoModulePositionEnumMap[instance.position]);
  return val;
}

const _$VideoModulePositionEnumMap = {
  VideoModulePosition.positionPostCapturer: 1,
  VideoModulePosition.positionPreRenderer: 2,
  VideoModulePosition.positionPreEncoder: 4,
  VideoModulePosition.positionPostCapturerOrigin: 8,
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

Map<String, dynamic> _$AudioFrameToJson(AudioFrame instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', _$AudioFrameTypeEnumMap[instance.type]);
  writeNotNull('samplesPerChannel', instance.samplesPerChannel);
  writeNotNull(
      'bytesPerSample', _$BytesPerSampleEnumMap[instance.bytesPerSample]);
  writeNotNull('channels', instance.channels);
  writeNotNull('samplesPerSec', instance.samplesPerSec);
  writeNotNull('renderTimeMs', instance.renderTimeMs);
  writeNotNull('avsync_type', instance.avsyncType);
  writeNotNull('presentationMs', instance.presentationMs);
  writeNotNull('audioTrackNumber', instance.audioTrackNumber);
  writeNotNull('rtpTimestamp', instance.rtpTimestamp);
  return val;
}

const _$AudioFrameTypeEnumMap = {
  AudioFrameType.frameTypePcm16: 0,
};

AudioParams _$AudioParamsFromJson(Map<String, dynamic> json) => AudioParams(
      sampleRate: (json['sample_rate'] as num?)?.toInt(),
      channels: (json['channels'] as num?)?.toInt(),
      mode: $enumDecodeNullable(_$RawAudioFrameOpModeTypeEnumMap, json['mode']),
      samplesPerCall: (json['samples_per_call'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AudioParamsToJson(AudioParams instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sample_rate', instance.sampleRate);
  writeNotNull('channels', instance.channels);
  writeNotNull('mode', _$RawAudioFrameOpModeTypeEnumMap[instance.mode]);
  writeNotNull('samples_per_call', instance.samplesPerCall);
  return val;
}

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

Map<String, dynamic> _$AudioSpectrumDataToJson(AudioSpectrumData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('audioSpectrumData', instance.audioSpectrumData);
  writeNotNull('dataLength', instance.dataLength);
  return val;
}

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
    UserAudioSpectrumInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uid', instance.uid);
  writeNotNull('spectrumData', instance.spectrumData?.toJson());
  return val;
}

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
    MediaRecorderConfiguration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('storagePath', instance.storagePath);
  writeNotNull('containerFormat',
      _$MediaRecorderContainerFormatEnumMap[instance.containerFormat]);
  writeNotNull(
      'streamType', _$MediaRecorderStreamTypeEnumMap[instance.streamType]);
  writeNotNull('maxDurationMs', instance.maxDurationMs);
  writeNotNull(
      'recorderInfoUpdateInterval', instance.recorderInfoUpdateInterval);
  writeNotNull('width', instance.width);
  writeNotNull('height', instance.height);
  writeNotNull('fps', instance.fps);
  writeNotNull('sample_rate', instance.sampleRate);
  writeNotNull('channel_num', instance.channelNum);
  writeNotNull(
      'videoSourceType', _$VideoSourceTypeEnumMap[instance.videoSourceType]);
  return val;
}

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

Map<String, dynamic> _$RecorderInfoToJson(RecorderInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fileName', instance.fileName);
  writeNotNull('durationMs', instance.durationMs);
  writeNotNull('fileSize', instance.fileSize);
  return val;
}

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
