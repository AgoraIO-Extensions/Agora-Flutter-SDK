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
      interval: json['interval'] as int?,
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
};

ContentInspectConfig _$ContentInspectConfigFromJson(
        Map<String, dynamic> json) =>
    ContentInspectConfig(
      extraInfo: json['extraInfo'] as String?,
      modules: (json['modules'] as List<dynamic>?)
          ?.map((e) => ContentInspectModule.fromJson(e as Map<String, dynamic>))
          .toList(),
      moduleCount: json['moduleCount'] as int?,
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
  writeNotNull('modules', instance.modules?.map((e) => e.toJson()).toList());
  writeNotNull('moduleCount', instance.moduleCount);
  return val;
}

PacketOptions _$PacketOptionsFromJson(Map<String, dynamic> json) =>
    PacketOptions(
      timestamp: json['timestamp'] as int?,
      audioLevelIndication: json['audioLevelIndication'] as int?,
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
      sendTs: json['sendTs'] as int?,
      codec: json['codec'] as int?,
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
      captureTimestamp: json['capture_timestamp'] as int?,
      samplesPerChannel: json['samples_per_channel_'] as int?,
      sampleRateHz: json['sample_rate_hz_'] as int?,
      numChannels: json['num_channels_'] as int?,
      bytesPerSample: $enumDecodeNullable(
          _$BytesPerSampleEnumMap, json['bytes_per_sample']),
      data: (json['data_'] as List<dynamic>?)?.map((e) => e as int).toList(),
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
  writeNotNull(
      'bytes_per_sample', _$BytesPerSampleEnumMap[instance.bytesPerSample]);
  writeNotNull('data_', instance.data);
  return val;
}

const _$BytesPerSampleEnumMap = {
  BytesPerSample.twoBytesPerSample: 2,
};

ExternalVideoFrame _$ExternalVideoFrameFromJson(Map<String, dynamic> json) =>
    ExternalVideoFrame(
      type: $enumDecodeNullable(_$VideoBufferTypeEnumMap, json['type']),
      format: $enumDecodeNullable(_$VideoPixelFormatEnumMap, json['format']),
      stride: json['stride'] as int?,
      height: json['height'] as int?,
      cropLeft: json['cropLeft'] as int?,
      cropTop: json['cropTop'] as int?,
      cropRight: json['cropRight'] as int?,
      cropBottom: json['cropBottom'] as int?,
      rotation: json['rotation'] as int?,
      timestamp: json['timestamp'] as int?,
      eglType: $enumDecodeNullable(_$EglContextTypeEnumMap, json['eglType']),
      textureId: json['textureId'] as int?,
      matrix: (json['matrix'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      metadataSize: json['metadata_size'] as int?,
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
  writeNotNull('matrix', instance.matrix);
  writeNotNull('metadata_size', instance.metadataSize);
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
  VideoPixelFormat.videoPixelI422: 16,
};

const _$EglContextTypeEnumMap = {
  EglContextType.eglContext10: 0,
  EglContextType.eglContext14: 1,
};

VideoFrame _$VideoFrameFromJson(Map<String, dynamic> json) => VideoFrame(
      type: $enumDecodeNullable(_$VideoPixelFormatEnumMap, json['type']),
      width: json['width'] as int?,
      height: json['height'] as int?,
      yStride: json['yStride'] as int?,
      uStride: json['uStride'] as int?,
      vStride: json['vStride'] as int?,
      rotation: json['rotation'] as int?,
      renderTimeMs: json['renderTimeMs'] as int?,
      avsyncType: json['avsync_type'] as int?,
      metadataSize: json['metadata_size'] as int?,
      textureId: json['textureId'] as int?,
      matrix: (json['matrix'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
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
  return val;
}

AudioFrame _$AudioFrameFromJson(Map<String, dynamic> json) => AudioFrame(
      type: $enumDecodeNullable(_$AudioFrameTypeEnumMap, json['type']),
      samplesPerChannel: json['samplesPerChannel'] as int?,
      bytesPerSample:
          $enumDecodeNullable(_$BytesPerSampleEnumMap, json['bytesPerSample']),
      channels: json['channels'] as int?,
      samplesPerSec: json['samplesPerSec'] as int?,
      renderTimeMs: json['renderTimeMs'] as int?,
      avsyncType: json['avsync_type'] as int?,
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
  return val;
}

const _$AudioFrameTypeEnumMap = {
  AudioFrameType.frameTypePcm16: 0,
};

AudioParams _$AudioParamsFromJson(Map<String, dynamic> json) => AudioParams(
      sampleRate: json['sample_rate'] as int?,
      channels: json['channels'] as int?,
      mode: $enumDecodeNullable(_$RawAudioFrameOpModeTypeEnumMap, json['mode']),
      samplesPerCall: json['samples_per_call'] as int?,
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
      dataLength: json['dataLength'] as int?,
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
      uid: json['uid'] as int?,
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
      maxDurationMs: json['maxDurationMs'] as int?,
      recorderInfoUpdateInterval: json['recorderInfoUpdateInterval'] as int?,
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

RecorderInfo _$RecorderInfoFromJson(Map<String, dynamic> json) => RecorderInfo(
      fileName: json['fileName'] as String?,
      durationMs: json['durationMs'] as int?,
      fileSize: json['fileSize'] as int?,
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

const _$AudioRouteEnumMap = {
  AudioRoute.routeDefault: -1,
  AudioRoute.routeHeadset: 0,
  AudioRoute.routeEarpiece: 1,
  AudioRoute.routeHeadsetnomic: 2,
  AudioRoute.routeSpeakerphone: 3,
  AudioRoute.routeLoudspeaker: 4,
  AudioRoute.routeHeadsetbluetooth: 5,
  AudioRoute.routeUsb: 6,
  AudioRoute.routeHdmi: 7,
  AudioRoute.routeDisplayport: 8,
  AudioRoute.routeAirplay: 9,
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

const _$MediaPlayerSourceTypeEnumMap = {
  MediaPlayerSourceType.mediaPlayerSourceDefault: 0,
  MediaPlayerSourceType.mediaPlayerSourceFullFeatured: 1,
  MediaPlayerSourceType.mediaPlayerSourceSimple: 2,
};

const _$VideoModulePositionEnumMap = {
  VideoModulePosition.positionPostCapturer: 1,
  VideoModulePosition.positionPreRenderer: 2,
  VideoModulePosition.positionPreEncoder: 4,
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

const _$RecorderErrorCodeEnumMap = {
  RecorderErrorCode.recorderErrorNone: 0,
  RecorderErrorCode.recorderErrorWriteFailed: 1,
  RecorderErrorCode.recorderErrorNoStream: 2,
  RecorderErrorCode.recorderErrorOverMaxDuration: 3,
  RecorderErrorCode.recorderErrorConfigChanged: 4,
};
