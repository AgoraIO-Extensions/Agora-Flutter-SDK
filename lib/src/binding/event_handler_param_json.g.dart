// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names, deprecated_member_use_from_same_package, unused_element

part of 'event_handler_param_json.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioEncodedFrameObserverOnRecordAudioEncodedFrameJson
    _$AudioEncodedFrameObserverOnRecordAudioEncodedFrameJsonFromJson(
            Map<String, dynamic> json) =>
        AudioEncodedFrameObserverOnRecordAudioEncodedFrameJson(
          length: (json['length'] as num?)?.toInt(),
          audioEncodedFrameInfo: json['audioEncodedFrameInfo'] == null
              ? null
              : EncodedAudioFrameInfo.fromJson(
                  json['audioEncodedFrameInfo'] as Map<String, dynamic>),
        );

Map<String, dynamic>
    _$AudioEncodedFrameObserverOnRecordAudioEncodedFrameJsonToJson(
        AudioEncodedFrameObserverOnRecordAudioEncodedFrameJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('length', instance.length);
  writeNotNull(
      'audioEncodedFrameInfo', instance.audioEncodedFrameInfo?.toJson());
  return val;
}

AudioEncodedFrameObserverOnPlaybackAudioEncodedFrameJson
    _$AudioEncodedFrameObserverOnPlaybackAudioEncodedFrameJsonFromJson(
            Map<String, dynamic> json) =>
        AudioEncodedFrameObserverOnPlaybackAudioEncodedFrameJson(
          length: (json['length'] as num?)?.toInt(),
          audioEncodedFrameInfo: json['audioEncodedFrameInfo'] == null
              ? null
              : EncodedAudioFrameInfo.fromJson(
                  json['audioEncodedFrameInfo'] as Map<String, dynamic>),
        );

Map<String, dynamic>
    _$AudioEncodedFrameObserverOnPlaybackAudioEncodedFrameJsonToJson(
        AudioEncodedFrameObserverOnPlaybackAudioEncodedFrameJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('length', instance.length);
  writeNotNull(
      'audioEncodedFrameInfo', instance.audioEncodedFrameInfo?.toJson());
  return val;
}

AudioEncodedFrameObserverOnMixedAudioEncodedFrameJson
    _$AudioEncodedFrameObserverOnMixedAudioEncodedFrameJsonFromJson(
            Map<String, dynamic> json) =>
        AudioEncodedFrameObserverOnMixedAudioEncodedFrameJson(
          length: (json['length'] as num?)?.toInt(),
          audioEncodedFrameInfo: json['audioEncodedFrameInfo'] == null
              ? null
              : EncodedAudioFrameInfo.fromJson(
                  json['audioEncodedFrameInfo'] as Map<String, dynamic>),
        );

Map<String, dynamic>
    _$AudioEncodedFrameObserverOnMixedAudioEncodedFrameJsonToJson(
        AudioEncodedFrameObserverOnMixedAudioEncodedFrameJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('length', instance.length);
  writeNotNull(
      'audioEncodedFrameInfo', instance.audioEncodedFrameInfo?.toJson());
  return val;
}

AudioPcmFrameSinkOnFrameJson _$AudioPcmFrameSinkOnFrameJsonFromJson(
        Map<String, dynamic> json) =>
    AudioPcmFrameSinkOnFrameJson(
      frame: json['frame'] == null
          ? null
          : AudioPcmFrame.fromJson(json['frame'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AudioPcmFrameSinkOnFrameJsonToJson(
    AudioPcmFrameSinkOnFrameJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('frame', instance.frame?.toJson());
  return val;
}

AudioFrameObserverBaseOnRecordAudioFrameJson
    _$AudioFrameObserverBaseOnRecordAudioFrameJsonFromJson(
            Map<String, dynamic> json) =>
        AudioFrameObserverBaseOnRecordAudioFrameJson(
          channelId: json['channelId'] as String?,
          audioFrame: json['audioFrame'] == null
              ? null
              : AudioFrame.fromJson(json['audioFrame'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$AudioFrameObserverBaseOnRecordAudioFrameJsonToJson(
    AudioFrameObserverBaseOnRecordAudioFrameJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('channelId', instance.channelId);
  writeNotNull('audioFrame', instance.audioFrame?.toJson());
  return val;
}

AudioFrameObserverBaseOnPlaybackAudioFrameJson
    _$AudioFrameObserverBaseOnPlaybackAudioFrameJsonFromJson(
            Map<String, dynamic> json) =>
        AudioFrameObserverBaseOnPlaybackAudioFrameJson(
          channelId: json['channelId'] as String?,
          audioFrame: json['audioFrame'] == null
              ? null
              : AudioFrame.fromJson(json['audioFrame'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$AudioFrameObserverBaseOnPlaybackAudioFrameJsonToJson(
    AudioFrameObserverBaseOnPlaybackAudioFrameJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('channelId', instance.channelId);
  writeNotNull('audioFrame', instance.audioFrame?.toJson());
  return val;
}

AudioFrameObserverBaseOnMixedAudioFrameJson
    _$AudioFrameObserverBaseOnMixedAudioFrameJsonFromJson(
            Map<String, dynamic> json) =>
        AudioFrameObserverBaseOnMixedAudioFrameJson(
          channelId: json['channelId'] as String?,
          audioFrame: json['audioFrame'] == null
              ? null
              : AudioFrame.fromJson(json['audioFrame'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$AudioFrameObserverBaseOnMixedAudioFrameJsonToJson(
    AudioFrameObserverBaseOnMixedAudioFrameJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('channelId', instance.channelId);
  writeNotNull('audioFrame', instance.audioFrame?.toJson());
  return val;
}

AudioFrameObserverBaseOnEarMonitoringAudioFrameJson
    _$AudioFrameObserverBaseOnEarMonitoringAudioFrameJsonFromJson(
            Map<String, dynamic> json) =>
        AudioFrameObserverBaseOnEarMonitoringAudioFrameJson(
          audioFrame: json['audioFrame'] == null
              ? null
              : AudioFrame.fromJson(json['audioFrame'] as Map<String, dynamic>),
        );

Map<String, dynamic>
    _$AudioFrameObserverBaseOnEarMonitoringAudioFrameJsonToJson(
        AudioFrameObserverBaseOnEarMonitoringAudioFrameJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('audioFrame', instance.audioFrame?.toJson());
  return val;
}

AudioFrameObserverOnPlaybackAudioFrameBeforeMixingJson
    _$AudioFrameObserverOnPlaybackAudioFrameBeforeMixingJsonFromJson(
            Map<String, dynamic> json) =>
        AudioFrameObserverOnPlaybackAudioFrameBeforeMixingJson(
          channelId: json['channelId'] as String?,
          uid: (json['uid'] as num?)?.toInt(),
          audioFrame: json['audioFrame'] == null
              ? null
              : AudioFrame.fromJson(json['audioFrame'] as Map<String, dynamic>),
        );

Map<String, dynamic>
    _$AudioFrameObserverOnPlaybackAudioFrameBeforeMixingJsonToJson(
        AudioFrameObserverOnPlaybackAudioFrameBeforeMixingJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('channelId', instance.channelId);
  writeNotNull('uid', instance.uid);
  writeNotNull('audioFrame', instance.audioFrame?.toJson());
  return val;
}

AudioSpectrumObserverOnLocalAudioSpectrumJson
    _$AudioSpectrumObserverOnLocalAudioSpectrumJsonFromJson(
            Map<String, dynamic> json) =>
        AudioSpectrumObserverOnLocalAudioSpectrumJson(
          data: json['data'] == null
              ? null
              : AudioSpectrumData.fromJson(
                  json['data'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$AudioSpectrumObserverOnLocalAudioSpectrumJsonToJson(
    AudioSpectrumObserverOnLocalAudioSpectrumJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data', instance.data?.toJson());
  return val;
}

AudioSpectrumObserverOnRemoteAudioSpectrumJson
    _$AudioSpectrumObserverOnRemoteAudioSpectrumJsonFromJson(
            Map<String, dynamic> json) =>
        AudioSpectrumObserverOnRemoteAudioSpectrumJson(
          spectrums: (json['spectrums'] as List<dynamic>?)
              ?.map((e) =>
                  UserAudioSpectrumInfo.fromJson(e as Map<String, dynamic>))
              .toList(),
          spectrumNumber: (json['spectrumNumber'] as num?)?.toInt(),
        );

Map<String, dynamic> _$AudioSpectrumObserverOnRemoteAudioSpectrumJsonToJson(
    AudioSpectrumObserverOnRemoteAudioSpectrumJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'spectrums', instance.spectrums?.map((e) => e.toJson()).toList());
  writeNotNull('spectrumNumber', instance.spectrumNumber);
  return val;
}

VideoEncodedFrameObserverOnEncodedVideoFrameReceivedJson
    _$VideoEncodedFrameObserverOnEncodedVideoFrameReceivedJsonFromJson(
            Map<String, dynamic> json) =>
        VideoEncodedFrameObserverOnEncodedVideoFrameReceivedJson(
          uid: (json['uid'] as num?)?.toInt(),
          length: (json['length'] as num?)?.toInt(),
          videoEncodedFrameInfo: json['videoEncodedFrameInfo'] == null
              ? null
              : EncodedVideoFrameInfo.fromJson(
                  json['videoEncodedFrameInfo'] as Map<String, dynamic>),
        );

Map<String, dynamic>
    _$VideoEncodedFrameObserverOnEncodedVideoFrameReceivedJsonToJson(
        VideoEncodedFrameObserverOnEncodedVideoFrameReceivedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uid', instance.uid);
  writeNotNull('length', instance.length);
  writeNotNull(
      'videoEncodedFrameInfo', instance.videoEncodedFrameInfo?.toJson());
  return val;
}

VideoFrameObserverOnCaptureVideoFrameJson
    _$VideoFrameObserverOnCaptureVideoFrameJsonFromJson(
            Map<String, dynamic> json) =>
        VideoFrameObserverOnCaptureVideoFrameJson(
          sourceType:
              $enumDecodeNullable(_$VideoSourceTypeEnumMap, json['sourceType']),
          videoFrame: json['videoFrame'] == null
              ? null
              : VideoFrame.fromJson(json['videoFrame'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$VideoFrameObserverOnCaptureVideoFrameJsonToJson(
    VideoFrameObserverOnCaptureVideoFrameJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sourceType', _$VideoSourceTypeEnumMap[instance.sourceType]);
  writeNotNull('videoFrame', instance.videoFrame?.toJson());
  return val;
}

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

VideoFrameObserverOnPreEncodeVideoFrameJson
    _$VideoFrameObserverOnPreEncodeVideoFrameJsonFromJson(
            Map<String, dynamic> json) =>
        VideoFrameObserverOnPreEncodeVideoFrameJson(
          sourceType:
              $enumDecodeNullable(_$VideoSourceTypeEnumMap, json['sourceType']),
          videoFrame: json['videoFrame'] == null
              ? null
              : VideoFrame.fromJson(json['videoFrame'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$VideoFrameObserverOnPreEncodeVideoFrameJsonToJson(
    VideoFrameObserverOnPreEncodeVideoFrameJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sourceType', _$VideoSourceTypeEnumMap[instance.sourceType]);
  writeNotNull('videoFrame', instance.videoFrame?.toJson());
  return val;
}

VideoFrameObserverOnMediaPlayerVideoFrameJson
    _$VideoFrameObserverOnMediaPlayerVideoFrameJsonFromJson(
            Map<String, dynamic> json) =>
        VideoFrameObserverOnMediaPlayerVideoFrameJson(
          videoFrame: json['videoFrame'] == null
              ? null
              : VideoFrame.fromJson(json['videoFrame'] as Map<String, dynamic>),
          mediaPlayerId: (json['mediaPlayerId'] as num?)?.toInt(),
        );

Map<String, dynamic> _$VideoFrameObserverOnMediaPlayerVideoFrameJsonToJson(
    VideoFrameObserverOnMediaPlayerVideoFrameJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('videoFrame', instance.videoFrame?.toJson());
  writeNotNull('mediaPlayerId', instance.mediaPlayerId);
  return val;
}

VideoFrameObserverOnRenderVideoFrameJson
    _$VideoFrameObserverOnRenderVideoFrameJsonFromJson(
            Map<String, dynamic> json) =>
        VideoFrameObserverOnRenderVideoFrameJson(
          channelId: json['channelId'] as String?,
          remoteUid: (json['remoteUid'] as num?)?.toInt(),
          videoFrame: json['videoFrame'] == null
              ? null
              : VideoFrame.fromJson(json['videoFrame'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$VideoFrameObserverOnRenderVideoFrameJsonToJson(
    VideoFrameObserverOnRenderVideoFrameJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('channelId', instance.channelId);
  writeNotNull('remoteUid', instance.remoteUid);
  writeNotNull('videoFrame', instance.videoFrame?.toJson());
  return val;
}

VideoFrameObserverOnTranscodedVideoFrameJson
    _$VideoFrameObserverOnTranscodedVideoFrameJsonFromJson(
            Map<String, dynamic> json) =>
        VideoFrameObserverOnTranscodedVideoFrameJson(
          videoFrame: json['videoFrame'] == null
              ? null
              : VideoFrame.fromJson(json['videoFrame'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$VideoFrameObserverOnTranscodedVideoFrameJsonToJson(
    VideoFrameObserverOnTranscodedVideoFrameJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('videoFrame', instance.videoFrame?.toJson());
  return val;
}

FaceInfoObserverOnFaceInfoJson _$FaceInfoObserverOnFaceInfoJsonFromJson(
        Map<String, dynamic> json) =>
    FaceInfoObserverOnFaceInfoJson(
      outFaceInfo: json['outFaceInfo'] as String?,
    );

Map<String, dynamic> _$FaceInfoObserverOnFaceInfoJsonToJson(
    FaceInfoObserverOnFaceInfoJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('outFaceInfo', instance.outFaceInfo);
  return val;
}

MediaRecorderObserverOnRecorderStateChangedJson
    _$MediaRecorderObserverOnRecorderStateChangedJsonFromJson(
            Map<String, dynamic> json) =>
        MediaRecorderObserverOnRecorderStateChangedJson(
          channelId: json['channelId'] as String?,
          uid: (json['uid'] as num?)?.toInt(),
          state: $enumDecodeNullable(_$RecorderStateEnumMap, json['state']),
          reason:
              $enumDecodeNullable(_$RecorderReasonCodeEnumMap, json['reason']),
        );

Map<String, dynamic> _$MediaRecorderObserverOnRecorderStateChangedJsonToJson(
    MediaRecorderObserverOnRecorderStateChangedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('channelId', instance.channelId);
  writeNotNull('uid', instance.uid);
  writeNotNull('state', _$RecorderStateEnumMap[instance.state]);
  writeNotNull('reason', _$RecorderReasonCodeEnumMap[instance.reason]);
  return val;
}

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

MediaRecorderObserverOnRecorderInfoUpdatedJson
    _$MediaRecorderObserverOnRecorderInfoUpdatedJsonFromJson(
            Map<String, dynamic> json) =>
        MediaRecorderObserverOnRecorderInfoUpdatedJson(
          channelId: json['channelId'] as String?,
          uid: (json['uid'] as num?)?.toInt(),
          info: json['info'] == null
              ? null
              : RecorderInfo.fromJson(json['info'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$MediaRecorderObserverOnRecorderInfoUpdatedJsonToJson(
    MediaRecorderObserverOnRecorderInfoUpdatedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('channelId', instance.channelId);
  writeNotNull('uid', instance.uid);
  writeNotNull('info', instance.info?.toJson());
  return val;
}

H265TranscoderObserverOnEnableTranscodeJson
    _$H265TranscoderObserverOnEnableTranscodeJsonFromJson(
            Map<String, dynamic> json) =>
        H265TranscoderObserverOnEnableTranscodeJson(
          result:
              $enumDecodeNullable(_$H265TranscodeResultEnumMap, json['result']),
        );

Map<String, dynamic> _$H265TranscoderObserverOnEnableTranscodeJsonToJson(
    H265TranscoderObserverOnEnableTranscodeJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('result', _$H265TranscodeResultEnumMap[instance.result]);
  return val;
}

const _$H265TranscodeResultEnumMap = {
  H265TranscodeResult.h265TranscodeResultUnknown: -1,
  H265TranscodeResult.h265TranscodeResultSuccess: 0,
  H265TranscodeResult.h265TranscodeResultRequestInvalid: 1,
  H265TranscodeResult.h265TranscodeResultUnauthorized: 2,
  H265TranscodeResult.h265TranscodeResultTokenExpired: 3,
  H265TranscodeResult.h265TranscodeResultForbidden: 4,
  H265TranscodeResult.h265TranscodeResultNotFound: 5,
  H265TranscodeResult.h265TranscodeResultConflicted: 6,
  H265TranscodeResult.h265TranscodeResultNotSupported: 7,
  H265TranscodeResult.h265TranscodeResultTooOften: 8,
  H265TranscodeResult.h265TranscodeResultServerInternalError: 9,
  H265TranscodeResult.h265TranscodeResultServiceUnavailable: 10,
};

H265TranscoderObserverOnQueryChannelJson
    _$H265TranscoderObserverOnQueryChannelJsonFromJson(
            Map<String, dynamic> json) =>
        H265TranscoderObserverOnQueryChannelJson(
          result:
              $enumDecodeNullable(_$H265TranscodeResultEnumMap, json['result']),
          originChannel: json['originChannel'] as String?,
          transcodeChannel: json['transcodeChannel'] as String?,
        );

Map<String, dynamic> _$H265TranscoderObserverOnQueryChannelJsonToJson(
    H265TranscoderObserverOnQueryChannelJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('result', _$H265TranscodeResultEnumMap[instance.result]);
  writeNotNull('originChannel', instance.originChannel);
  writeNotNull('transcodeChannel', instance.transcodeChannel);
  return val;
}

H265TranscoderObserverOnTriggerTranscodeJson
    _$H265TranscoderObserverOnTriggerTranscodeJsonFromJson(
            Map<String, dynamic> json) =>
        H265TranscoderObserverOnTriggerTranscodeJson(
          result:
              $enumDecodeNullable(_$H265TranscodeResultEnumMap, json['result']),
        );

Map<String, dynamic> _$H265TranscoderObserverOnTriggerTranscodeJsonToJson(
    H265TranscoderObserverOnTriggerTranscodeJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('result', _$H265TranscodeResultEnumMap[instance.result]);
  return val;
}

MediaPlayerVideoFrameObserverOnFrameJson
    _$MediaPlayerVideoFrameObserverOnFrameJsonFromJson(
            Map<String, dynamic> json) =>
        MediaPlayerVideoFrameObserverOnFrameJson(
          frame: json['frame'] == null
              ? null
              : VideoFrame.fromJson(json['frame'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$MediaPlayerVideoFrameObserverOnFrameJsonToJson(
    MediaPlayerVideoFrameObserverOnFrameJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('frame', instance.frame?.toJson());
  return val;
}

MediaPlayerSourceObserverOnPlayerSourceStateChangedJson
    _$MediaPlayerSourceObserverOnPlayerSourceStateChangedJsonFromJson(
            Map<String, dynamic> json) =>
        MediaPlayerSourceObserverOnPlayerSourceStateChangedJson(
          state: $enumDecodeNullable(_$MediaPlayerStateEnumMap, json['state']),
          reason:
              $enumDecodeNullable(_$MediaPlayerReasonEnumMap, json['reason']),
        );

Map<String, dynamic>
    _$MediaPlayerSourceObserverOnPlayerSourceStateChangedJsonToJson(
        MediaPlayerSourceObserverOnPlayerSourceStateChangedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('state', _$MediaPlayerStateEnumMap[instance.state]);
  writeNotNull('reason', _$MediaPlayerReasonEnumMap[instance.reason]);
  return val;
}

const _$MediaPlayerStateEnumMap = {
  MediaPlayerState.playerStateIdle: 0,
  MediaPlayerState.playerStateOpening: 1,
  MediaPlayerState.playerStateOpenCompleted: 2,
  MediaPlayerState.playerStatePlaying: 3,
  MediaPlayerState.playerStatePaused: 4,
  MediaPlayerState.playerStatePlaybackCompleted: 5,
  MediaPlayerState.playerStatePlaybackAllLoopsCompleted: 6,
  MediaPlayerState.playerStateStopped: 7,
  MediaPlayerState.playerStatePausingInternal: 50,
  MediaPlayerState.playerStateStoppingInternal: 51,
  MediaPlayerState.playerStateSeekingInternal: 52,
  MediaPlayerState.playerStateGettingInternal: 53,
  MediaPlayerState.playerStateNoneInternal: 54,
  MediaPlayerState.playerStateDoNothingInternal: 55,
  MediaPlayerState.playerStateSetTrackInternal: 56,
  MediaPlayerState.playerStateFailed: 100,
};

const _$MediaPlayerReasonEnumMap = {
  MediaPlayerReason.playerReasonNone: 0,
  MediaPlayerReason.playerReasonInvalidArguments: -1,
  MediaPlayerReason.playerReasonInternal: -2,
  MediaPlayerReason.playerReasonNoResource: -3,
  MediaPlayerReason.playerReasonInvalidMediaSource: -4,
  MediaPlayerReason.playerReasonUnknownStreamType: -5,
  MediaPlayerReason.playerReasonObjNotInitialized: -6,
  MediaPlayerReason.playerReasonCodecNotSupported: -7,
  MediaPlayerReason.playerReasonVideoRenderFailed: -8,
  MediaPlayerReason.playerReasonInvalidState: -9,
  MediaPlayerReason.playerReasonUrlNotFound: -10,
  MediaPlayerReason.playerReasonInvalidConnectionState: -11,
  MediaPlayerReason.playerReasonSrcBufferUnderflow: -12,
  MediaPlayerReason.playerReasonInterrupted: -13,
  MediaPlayerReason.playerReasonNotSupported: -14,
  MediaPlayerReason.playerReasonTokenExpired: -15,
  MediaPlayerReason.playerReasonIpExpired: -16,
  MediaPlayerReason.playerReasonUnknown: -17,
};

MediaPlayerSourceObserverOnPositionChangedJson
    _$MediaPlayerSourceObserverOnPositionChangedJsonFromJson(
            Map<String, dynamic> json) =>
        MediaPlayerSourceObserverOnPositionChangedJson(
          positionMs: (json['positionMs'] as num?)?.toInt(),
          timestampMs: (json['timestampMs'] as num?)?.toInt(),
        );

Map<String, dynamic> _$MediaPlayerSourceObserverOnPositionChangedJsonToJson(
    MediaPlayerSourceObserverOnPositionChangedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('positionMs', instance.positionMs);
  writeNotNull('timestampMs', instance.timestampMs);
  return val;
}

MediaPlayerSourceObserverOnPlayerEventJson
    _$MediaPlayerSourceObserverOnPlayerEventJsonFromJson(
            Map<String, dynamic> json) =>
        MediaPlayerSourceObserverOnPlayerEventJson(
          eventCode:
              $enumDecodeNullable(_$MediaPlayerEventEnumMap, json['eventCode']),
          elapsedTime: (json['elapsedTime'] as num?)?.toInt(),
          message: json['message'] as String?,
        );

Map<String, dynamic> _$MediaPlayerSourceObserverOnPlayerEventJsonToJson(
    MediaPlayerSourceObserverOnPlayerEventJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('eventCode', _$MediaPlayerEventEnumMap[instance.eventCode]);
  writeNotNull('elapsedTime', instance.elapsedTime);
  writeNotNull('message', instance.message);
  return val;
}

const _$MediaPlayerEventEnumMap = {
  MediaPlayerEvent.playerEventSeekBegin: 0,
  MediaPlayerEvent.playerEventSeekComplete: 1,
  MediaPlayerEvent.playerEventSeekError: 2,
  MediaPlayerEvent.playerEventAudioTrackChanged: 5,
  MediaPlayerEvent.playerEventBufferLow: 6,
  MediaPlayerEvent.playerEventBufferRecover: 7,
  MediaPlayerEvent.playerEventFreezeStart: 8,
  MediaPlayerEvent.playerEventFreezeStop: 9,
  MediaPlayerEvent.playerEventSwitchBegin: 10,
  MediaPlayerEvent.playerEventSwitchComplete: 11,
  MediaPlayerEvent.playerEventSwitchError: 12,
  MediaPlayerEvent.playerEventFirstDisplayed: 13,
  MediaPlayerEvent.playerEventReachCacheFileMaxCount: 14,
  MediaPlayerEvent.playerEventReachCacheFileMaxSize: 15,
  MediaPlayerEvent.playerEventTryOpenStart: 16,
  MediaPlayerEvent.playerEventTryOpenSucceed: 17,
  MediaPlayerEvent.playerEventTryOpenFailed: 18,
};

MediaPlayerSourceObserverOnMetaDataJson
    _$MediaPlayerSourceObserverOnMetaDataJsonFromJson(
            Map<String, dynamic> json) =>
        MediaPlayerSourceObserverOnMetaDataJson(
          length: (json['length'] as num?)?.toInt(),
        );

Map<String, dynamic> _$MediaPlayerSourceObserverOnMetaDataJsonToJson(
    MediaPlayerSourceObserverOnMetaDataJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('length', instance.length);
  return val;
}

MediaPlayerSourceObserverOnPlayBufferUpdatedJson
    _$MediaPlayerSourceObserverOnPlayBufferUpdatedJsonFromJson(
            Map<String, dynamic> json) =>
        MediaPlayerSourceObserverOnPlayBufferUpdatedJson(
          playCachedBuffer: (json['playCachedBuffer'] as num?)?.toInt(),
        );

Map<String, dynamic> _$MediaPlayerSourceObserverOnPlayBufferUpdatedJsonToJson(
    MediaPlayerSourceObserverOnPlayBufferUpdatedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('playCachedBuffer', instance.playCachedBuffer);
  return val;
}

MediaPlayerSourceObserverOnPreloadEventJson
    _$MediaPlayerSourceObserverOnPreloadEventJsonFromJson(
            Map<String, dynamic> json) =>
        MediaPlayerSourceObserverOnPreloadEventJson(
          src: json['src'] as String?,
          event:
              $enumDecodeNullable(_$PlayerPreloadEventEnumMap, json['event']),
        );

Map<String, dynamic> _$MediaPlayerSourceObserverOnPreloadEventJsonToJson(
    MediaPlayerSourceObserverOnPreloadEventJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('src', instance.src);
  writeNotNull('event', _$PlayerPreloadEventEnumMap[instance.event]);
  return val;
}

const _$PlayerPreloadEventEnumMap = {
  PlayerPreloadEvent.playerPreloadEventBegin: 0,
  PlayerPreloadEvent.playerPreloadEventComplete: 1,
  PlayerPreloadEvent.playerPreloadEventError: 2,
};

MediaPlayerSourceObserverOnCompletedJson
    _$MediaPlayerSourceObserverOnCompletedJsonFromJson(
            Map<String, dynamic> json) =>
        MediaPlayerSourceObserverOnCompletedJson();

Map<String, dynamic> _$MediaPlayerSourceObserverOnCompletedJsonToJson(
        MediaPlayerSourceObserverOnCompletedJson instance) =>
    <String, dynamic>{};

MediaPlayerSourceObserverOnAgoraCDNTokenWillExpireJson
    _$MediaPlayerSourceObserverOnAgoraCDNTokenWillExpireJsonFromJson(
            Map<String, dynamic> json) =>
        MediaPlayerSourceObserverOnAgoraCDNTokenWillExpireJson();

Map<String, dynamic>
    _$MediaPlayerSourceObserverOnAgoraCDNTokenWillExpireJsonToJson(
            MediaPlayerSourceObserverOnAgoraCDNTokenWillExpireJson instance) =>
        <String, dynamic>{};

MediaPlayerSourceObserverOnPlayerSrcInfoChangedJson
    _$MediaPlayerSourceObserverOnPlayerSrcInfoChangedJsonFromJson(
            Map<String, dynamic> json) =>
        MediaPlayerSourceObserverOnPlayerSrcInfoChangedJson(
          from: json['from'] == null
              ? null
              : SrcInfo.fromJson(json['from'] as Map<String, dynamic>),
          to: json['to'] == null
              ? null
              : SrcInfo.fromJson(json['to'] as Map<String, dynamic>),
        );

Map<String, dynamic>
    _$MediaPlayerSourceObserverOnPlayerSrcInfoChangedJsonToJson(
        MediaPlayerSourceObserverOnPlayerSrcInfoChangedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('from', instance.from?.toJson());
  writeNotNull('to', instance.to?.toJson());
  return val;
}

MediaPlayerSourceObserverOnPlayerInfoUpdatedJson
    _$MediaPlayerSourceObserverOnPlayerInfoUpdatedJsonFromJson(
            Map<String, dynamic> json) =>
        MediaPlayerSourceObserverOnPlayerInfoUpdatedJson(
          info: json['info'] == null
              ? null
              : PlayerUpdatedInfo.fromJson(
                  json['info'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$MediaPlayerSourceObserverOnPlayerInfoUpdatedJsonToJson(
    MediaPlayerSourceObserverOnPlayerInfoUpdatedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('info', instance.info?.toJson());
  return val;
}

MediaPlayerSourceObserverOnPlayerCacheStatsJson
    _$MediaPlayerSourceObserverOnPlayerCacheStatsJsonFromJson(
            Map<String, dynamic> json) =>
        MediaPlayerSourceObserverOnPlayerCacheStatsJson(
          stats: json['stats'] == null
              ? null
              : CacheStatistics.fromJson(json['stats'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$MediaPlayerSourceObserverOnPlayerCacheStatsJsonToJson(
    MediaPlayerSourceObserverOnPlayerCacheStatsJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('stats', instance.stats?.toJson());
  return val;
}

MediaPlayerSourceObserverOnPlayerPlaybackStatsJson
    _$MediaPlayerSourceObserverOnPlayerPlaybackStatsJsonFromJson(
            Map<String, dynamic> json) =>
        MediaPlayerSourceObserverOnPlayerPlaybackStatsJson(
          stats: json['stats'] == null
              ? null
              : PlayerPlaybackStats.fromJson(
                  json['stats'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$MediaPlayerSourceObserverOnPlayerPlaybackStatsJsonToJson(
    MediaPlayerSourceObserverOnPlayerPlaybackStatsJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('stats', instance.stats?.toJson());
  return val;
}

MediaPlayerSourceObserverOnAudioVolumeIndicationJson
    _$MediaPlayerSourceObserverOnAudioVolumeIndicationJsonFromJson(
            Map<String, dynamic> json) =>
        MediaPlayerSourceObserverOnAudioVolumeIndicationJson(
          volume: (json['volume'] as num?)?.toInt(),
        );

Map<String, dynamic>
    _$MediaPlayerSourceObserverOnAudioVolumeIndicationJsonToJson(
        MediaPlayerSourceObserverOnAudioVolumeIndicationJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('volume', instance.volume);
  return val;
}

MusicContentCenterEventHandlerOnMusicChartsResultJson
    _$MusicContentCenterEventHandlerOnMusicChartsResultJsonFromJson(
            Map<String, dynamic> json) =>
        MusicContentCenterEventHandlerOnMusicChartsResultJson(
          requestId: json['requestId'] as String?,
          result: (json['result'] as List<dynamic>?)
              ?.map((e) => MusicChartInfo.fromJson(e as Map<String, dynamic>))
              .toList(),
          reason: $enumDecodeNullable(
              _$MusicContentCenterStateReasonEnumMap, json['reason']),
        );

Map<String, dynamic>
    _$MusicContentCenterEventHandlerOnMusicChartsResultJsonToJson(
        MusicContentCenterEventHandlerOnMusicChartsResultJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('requestId', instance.requestId);
  writeNotNull('result', instance.result?.map((e) => e.toJson()).toList());
  writeNotNull(
      'reason', _$MusicContentCenterStateReasonEnumMap[instance.reason]);
  return val;
}

const _$MusicContentCenterStateReasonEnumMap = {
  MusicContentCenterStateReason.kMusicContentCenterReasonOk: 0,
  MusicContentCenterStateReason.kMusicContentCenterReasonError: 1,
  MusicContentCenterStateReason.kMusicContentCenterReasonGateway: 2,
  MusicContentCenterStateReason.kMusicContentCenterReasonPermissionAndResource:
      3,
  MusicContentCenterStateReason.kMusicContentCenterReasonInternalDataParse: 4,
  MusicContentCenterStateReason.kMusicContentCenterReasonMusicLoading: 5,
  MusicContentCenterStateReason.kMusicContentCenterReasonMusicDecryption: 6,
  MusicContentCenterStateReason.kMusicContentCenterReasonHttpInternalError: 7,
};

MusicContentCenterEventHandlerOnMusicCollectionResultJson
    _$MusicContentCenterEventHandlerOnMusicCollectionResultJsonFromJson(
            Map<String, dynamic> json) =>
        MusicContentCenterEventHandlerOnMusicCollectionResultJson(
          requestId: json['requestId'] as String?,
          reason: $enumDecodeNullable(
              _$MusicContentCenterStateReasonEnumMap, json['reason']),
        );

Map<String, dynamic>
    _$MusicContentCenterEventHandlerOnMusicCollectionResultJsonToJson(
        MusicContentCenterEventHandlerOnMusicCollectionResultJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('requestId', instance.requestId);
  writeNotNull(
      'reason', _$MusicContentCenterStateReasonEnumMap[instance.reason]);
  return val;
}

MusicContentCenterEventHandlerOnLyricResultJson
    _$MusicContentCenterEventHandlerOnLyricResultJsonFromJson(
            Map<String, dynamic> json) =>
        MusicContentCenterEventHandlerOnLyricResultJson(
          requestId: json['requestId'] as String?,
          songCode: (json['songCode'] as num?)?.toInt(),
          lyricUrl: json['lyricUrl'] as String?,
          reason: $enumDecodeNullable(
              _$MusicContentCenterStateReasonEnumMap, json['reason']),
        );

Map<String, dynamic> _$MusicContentCenterEventHandlerOnLyricResultJsonToJson(
    MusicContentCenterEventHandlerOnLyricResultJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('requestId', instance.requestId);
  writeNotNull('songCode', instance.songCode);
  writeNotNull('lyricUrl', instance.lyricUrl);
  writeNotNull(
      'reason', _$MusicContentCenterStateReasonEnumMap[instance.reason]);
  return val;
}

MusicContentCenterEventHandlerOnSongSimpleInfoResultJson
    _$MusicContentCenterEventHandlerOnSongSimpleInfoResultJsonFromJson(
            Map<String, dynamic> json) =>
        MusicContentCenterEventHandlerOnSongSimpleInfoResultJson(
          requestId: json['requestId'] as String?,
          songCode: (json['songCode'] as num?)?.toInt(),
          simpleInfo: json['simpleInfo'] as String?,
          reason: $enumDecodeNullable(
              _$MusicContentCenterStateReasonEnumMap, json['reason']),
        );

Map<String, dynamic>
    _$MusicContentCenterEventHandlerOnSongSimpleInfoResultJsonToJson(
        MusicContentCenterEventHandlerOnSongSimpleInfoResultJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('requestId', instance.requestId);
  writeNotNull('songCode', instance.songCode);
  writeNotNull('simpleInfo', instance.simpleInfo);
  writeNotNull(
      'reason', _$MusicContentCenterStateReasonEnumMap[instance.reason]);
  return val;
}

MusicContentCenterEventHandlerOnPreLoadEventJson
    _$MusicContentCenterEventHandlerOnPreLoadEventJsonFromJson(
            Map<String, dynamic> json) =>
        MusicContentCenterEventHandlerOnPreLoadEventJson(
          requestId: json['requestId'] as String?,
          songCode: (json['songCode'] as num?)?.toInt(),
          percent: (json['percent'] as num?)?.toInt(),
          lyricUrl: json['lyricUrl'] as String?,
          state: $enumDecodeNullable(_$PreloadStateEnumMap, json['state']),
          reason: $enumDecodeNullable(
              _$MusicContentCenterStateReasonEnumMap, json['reason']),
        );

Map<String, dynamic> _$MusicContentCenterEventHandlerOnPreLoadEventJsonToJson(
    MusicContentCenterEventHandlerOnPreLoadEventJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('requestId', instance.requestId);
  writeNotNull('songCode', instance.songCode);
  writeNotNull('percent', instance.percent);
  writeNotNull('lyricUrl', instance.lyricUrl);
  writeNotNull('state', _$PreloadStateEnumMap[instance.state]);
  writeNotNull(
      'reason', _$MusicContentCenterStateReasonEnumMap[instance.reason]);
  return val;
}

const _$PreloadStateEnumMap = {
  PreloadState.kPreloadStateCompleted: 0,
  PreloadState.kPreloadStateFailed: 1,
  PreloadState.kPreloadStatePreloading: 2,
  PreloadState.kPreloadStateRemoved: 3,
};

RtcEngineEventHandlerOnJoinChannelSuccessJson
    _$RtcEngineEventHandlerOnJoinChannelSuccessJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnJoinChannelSuccessJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          elapsed: (json['elapsed'] as num?)?.toInt(),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnJoinChannelSuccessJsonToJson(
    RtcEngineEventHandlerOnJoinChannelSuccessJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('elapsed', instance.elapsed);
  return val;
}

RtcEngineEventHandlerOnRejoinChannelSuccessJson
    _$RtcEngineEventHandlerOnRejoinChannelSuccessJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnRejoinChannelSuccessJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          elapsed: (json['elapsed'] as num?)?.toInt(),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnRejoinChannelSuccessJsonToJson(
    RtcEngineEventHandlerOnRejoinChannelSuccessJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('elapsed', instance.elapsed);
  return val;
}

RtcEngineEventHandlerOnProxyConnectedJson
    _$RtcEngineEventHandlerOnProxyConnectedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnProxyConnectedJson(
          channel: json['channel'] as String?,
          uid: (json['uid'] as num?)?.toInt(),
          proxyType: $enumDecodeNullable(_$ProxyTypeEnumMap, json['proxyType']),
          localProxyIp: json['localProxyIp'] as String?,
          elapsed: (json['elapsed'] as num?)?.toInt(),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnProxyConnectedJsonToJson(
    RtcEngineEventHandlerOnProxyConnectedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('channel', instance.channel);
  writeNotNull('uid', instance.uid);
  writeNotNull('proxyType', _$ProxyTypeEnumMap[instance.proxyType]);
  writeNotNull('localProxyIp', instance.localProxyIp);
  writeNotNull('elapsed', instance.elapsed);
  return val;
}

const _$ProxyTypeEnumMap = {
  ProxyType.noneProxyType: 0,
  ProxyType.udpProxyType: 1,
  ProxyType.tcpProxyType: 2,
  ProxyType.localProxyType: 3,
  ProxyType.tcpProxyAutoFallbackType: 4,
  ProxyType.httpProxyType: 5,
  ProxyType.httpsProxyType: 6,
};

RtcEngineEventHandlerOnErrorJson _$RtcEngineEventHandlerOnErrorJsonFromJson(
        Map<String, dynamic> json) =>
    RtcEngineEventHandlerOnErrorJson(
      err: $enumDecodeNullable(_$ErrorCodeTypeEnumMap, json['err']),
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$RtcEngineEventHandlerOnErrorJsonToJson(
    RtcEngineEventHandlerOnErrorJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('err', _$ErrorCodeTypeEnumMap[instance.err]);
  writeNotNull('msg', instance.msg);
  return val;
}

const _$ErrorCodeTypeEnumMap = {
  ErrorCodeType.errOk: 0,
  ErrorCodeType.errFailed: 1,
  ErrorCodeType.errInvalidArgument: 2,
  ErrorCodeType.errNotReady: 3,
  ErrorCodeType.errNotSupported: 4,
  ErrorCodeType.errRefused: 5,
  ErrorCodeType.errBufferTooSmall: 6,
  ErrorCodeType.errNotInitialized: 7,
  ErrorCodeType.errInvalidState: 8,
  ErrorCodeType.errNoPermission: 9,
  ErrorCodeType.errTimedout: 10,
  ErrorCodeType.errCanceled: 11,
  ErrorCodeType.errTooOften: 12,
  ErrorCodeType.errBindSocket: 13,
  ErrorCodeType.errNetDown: 14,
  ErrorCodeType.errJoinChannelRejected: 17,
  ErrorCodeType.errLeaveChannelRejected: 18,
  ErrorCodeType.errAlreadyInUse: 19,
  ErrorCodeType.errAborted: 20,
  ErrorCodeType.errInitNetEngine: 21,
  ErrorCodeType.errResourceLimited: 22,
  ErrorCodeType.errInvalidAppId: 101,
  ErrorCodeType.errInvalidChannelName: 102,
  ErrorCodeType.errNoServerResources: 103,
  ErrorCodeType.errTokenExpired: 109,
  ErrorCodeType.errInvalidToken: 110,
  ErrorCodeType.errConnectionInterrupted: 111,
  ErrorCodeType.errConnectionLost: 112,
  ErrorCodeType.errNotInChannel: 113,
  ErrorCodeType.errSizeTooLarge: 114,
  ErrorCodeType.errBitrateLimit: 115,
  ErrorCodeType.errTooManyDataStreams: 116,
  ErrorCodeType.errStreamMessageTimeout: 117,
  ErrorCodeType.errSetClientRoleNotAuthorized: 119,
  ErrorCodeType.errDecryptionFailed: 120,
  ErrorCodeType.errInvalidUserId: 121,
  ErrorCodeType.errDatastreamDecryptionFailed: 122,
  ErrorCodeType.errClientIsBannedByServer: 123,
  ErrorCodeType.errEncryptedStreamNotAllowedPublish: 130,
  ErrorCodeType.errLicenseCredentialInvalid: 131,
  ErrorCodeType.errInvalidUserAccount: 134,
  ErrorCodeType.errModuleNotFound: 157,
  ErrorCodeType.errCertRaw: 157,
  ErrorCodeType.errCertJsonPart: 158,
  ErrorCodeType.errCertJsonInval: 159,
  ErrorCodeType.errCertJsonNomem: 160,
  ErrorCodeType.errCertCustom: 161,
  ErrorCodeType.errCertCredential: 162,
  ErrorCodeType.errCertSign: 163,
  ErrorCodeType.errCertFail: 164,
  ErrorCodeType.errCertBuf: 165,
  ErrorCodeType.errCertNull: 166,
  ErrorCodeType.errCertDuedate: 167,
  ErrorCodeType.errCertRequest: 168,
  ErrorCodeType.errPcmsendFormat: 200,
  ErrorCodeType.errPcmsendBufferoverflow: 201,
  ErrorCodeType.errLoginAlreadyLogin: 428,
  ErrorCodeType.errLoadMediaEngine: 1001,
  ErrorCodeType.errAdmGeneralError: 1005,
  ErrorCodeType.errAdmInitPlayout: 1008,
  ErrorCodeType.errAdmStartPlayout: 1009,
  ErrorCodeType.errAdmStopPlayout: 1010,
  ErrorCodeType.errAdmInitRecording: 1011,
  ErrorCodeType.errAdmStartRecording: 1012,
  ErrorCodeType.errAdmStopRecording: 1013,
  ErrorCodeType.errVdmCameraNotAuthorized: 1501,
};

RtcEngineEventHandlerOnAudioQualityJson
    _$RtcEngineEventHandlerOnAudioQualityJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnAudioQualityJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          remoteUid: (json['remoteUid'] as num?)?.toInt(),
          quality: $enumDecodeNullable(_$QualityTypeEnumMap, json['quality']),
          delay: (json['delay'] as num?)?.toInt(),
          lost: (json['lost'] as num?)?.toInt(),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnAudioQualityJsonToJson(
    RtcEngineEventHandlerOnAudioQualityJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('remoteUid', instance.remoteUid);
  writeNotNull('quality', _$QualityTypeEnumMap[instance.quality]);
  writeNotNull('delay', instance.delay);
  writeNotNull('lost', instance.lost);
  return val;
}

const _$QualityTypeEnumMap = {
  QualityType.qualityUnknown: 0,
  QualityType.qualityExcellent: 1,
  QualityType.qualityGood: 2,
  QualityType.qualityPoor: 3,
  QualityType.qualityBad: 4,
  QualityType.qualityVbad: 5,
  QualityType.qualityDown: 6,
  QualityType.qualityUnsupported: 7,
  QualityType.qualityDetecting: 8,
};

RtcEngineEventHandlerOnLastmileProbeResultJson
    _$RtcEngineEventHandlerOnLastmileProbeResultJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnLastmileProbeResultJson(
          result: json['result'] == null
              ? null
              : LastmileProbeResult.fromJson(
                  json['result'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnLastmileProbeResultJsonToJson(
    RtcEngineEventHandlerOnLastmileProbeResultJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('result', instance.result?.toJson());
  return val;
}

RtcEngineEventHandlerOnAudioVolumeIndicationJson
    _$RtcEngineEventHandlerOnAudioVolumeIndicationJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnAudioVolumeIndicationJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          speakers: (json['speakers'] as List<dynamic>?)
              ?.map((e) => AudioVolumeInfo.fromJson(e as Map<String, dynamic>))
              .toList(),
          speakerNumber: (json['speakerNumber'] as num?)?.toInt(),
          totalVolume: (json['totalVolume'] as num?)?.toInt(),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnAudioVolumeIndicationJsonToJson(
    RtcEngineEventHandlerOnAudioVolumeIndicationJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('speakers', instance.speakers?.map((e) => e.toJson()).toList());
  writeNotNull('speakerNumber', instance.speakerNumber);
  writeNotNull('totalVolume', instance.totalVolume);
  return val;
}

RtcEngineEventHandlerOnLeaveChannelJson
    _$RtcEngineEventHandlerOnLeaveChannelJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnLeaveChannelJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          stats: json['stats'] == null
              ? null
              : RtcStats.fromJson(json['stats'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnLeaveChannelJsonToJson(
    RtcEngineEventHandlerOnLeaveChannelJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('stats', instance.stats?.toJson());
  return val;
}

RtcEngineEventHandlerOnRtcStatsJson
    _$RtcEngineEventHandlerOnRtcStatsJsonFromJson(Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnRtcStatsJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          stats: json['stats'] == null
              ? null
              : RtcStats.fromJson(json['stats'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnRtcStatsJsonToJson(
    RtcEngineEventHandlerOnRtcStatsJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('stats', instance.stats?.toJson());
  return val;
}

RtcEngineEventHandlerOnAudioDeviceStateChangedJson
    _$RtcEngineEventHandlerOnAudioDeviceStateChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnAudioDeviceStateChangedJson(
          deviceId: json['deviceId'] as String?,
          deviceType:
              $enumDecodeNullable(_$MediaDeviceTypeEnumMap, json['deviceType']),
          deviceState: $enumDecodeNullable(
              _$MediaDeviceStateTypeEnumMap, json['deviceState']),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnAudioDeviceStateChangedJsonToJson(
    RtcEngineEventHandlerOnAudioDeviceStateChangedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('deviceId', instance.deviceId);
  writeNotNull('deviceType', _$MediaDeviceTypeEnumMap[instance.deviceType]);
  writeNotNull(
      'deviceState', _$MediaDeviceStateTypeEnumMap[instance.deviceState]);
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

const _$MediaDeviceStateTypeEnumMap = {
  MediaDeviceStateType.mediaDeviceStateIdle: 0,
  MediaDeviceStateType.mediaDeviceStateActive: 1,
  MediaDeviceStateType.mediaDeviceStateDisabled: 2,
  MediaDeviceStateType.mediaDeviceStateNotPresent: 4,
  MediaDeviceStateType.mediaDeviceStateUnplugged: 8,
};

RtcEngineEventHandlerOnAudioMixingPositionChangedJson
    _$RtcEngineEventHandlerOnAudioMixingPositionChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnAudioMixingPositionChangedJson(
          position: (json['position'] as num?)?.toInt(),
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnAudioMixingPositionChangedJsonToJson(
        RtcEngineEventHandlerOnAudioMixingPositionChangedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('position', instance.position);
  return val;
}

RtcEngineEventHandlerOnAudioMixingFinishedJson
    _$RtcEngineEventHandlerOnAudioMixingFinishedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnAudioMixingFinishedJson();

Map<String, dynamic> _$RtcEngineEventHandlerOnAudioMixingFinishedJsonToJson(
        RtcEngineEventHandlerOnAudioMixingFinishedJson instance) =>
    <String, dynamic>{};

RtcEngineEventHandlerOnAudioEffectFinishedJson
    _$RtcEngineEventHandlerOnAudioEffectFinishedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnAudioEffectFinishedJson(
          soundId: (json['soundId'] as num?)?.toInt(),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnAudioEffectFinishedJsonToJson(
    RtcEngineEventHandlerOnAudioEffectFinishedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('soundId', instance.soundId);
  return val;
}

RtcEngineEventHandlerOnVideoDeviceStateChangedJson
    _$RtcEngineEventHandlerOnVideoDeviceStateChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnVideoDeviceStateChangedJson(
          deviceId: json['deviceId'] as String?,
          deviceType:
              $enumDecodeNullable(_$MediaDeviceTypeEnumMap, json['deviceType']),
          deviceState: $enumDecodeNullable(
              _$MediaDeviceStateTypeEnumMap, json['deviceState']),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnVideoDeviceStateChangedJsonToJson(
    RtcEngineEventHandlerOnVideoDeviceStateChangedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('deviceId', instance.deviceId);
  writeNotNull('deviceType', _$MediaDeviceTypeEnumMap[instance.deviceType]);
  writeNotNull(
      'deviceState', _$MediaDeviceStateTypeEnumMap[instance.deviceState]);
  return val;
}

RtcEngineEventHandlerOnNetworkQualityJson
    _$RtcEngineEventHandlerOnNetworkQualityJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnNetworkQualityJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          remoteUid: (json['remoteUid'] as num?)?.toInt(),
          txQuality:
              $enumDecodeNullable(_$QualityTypeEnumMap, json['txQuality']),
          rxQuality:
              $enumDecodeNullable(_$QualityTypeEnumMap, json['rxQuality']),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnNetworkQualityJsonToJson(
    RtcEngineEventHandlerOnNetworkQualityJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('remoteUid', instance.remoteUid);
  writeNotNull('txQuality', _$QualityTypeEnumMap[instance.txQuality]);
  writeNotNull('rxQuality', _$QualityTypeEnumMap[instance.rxQuality]);
  return val;
}

RtcEngineEventHandlerOnIntraRequestReceivedJson
    _$RtcEngineEventHandlerOnIntraRequestReceivedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnIntraRequestReceivedJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnIntraRequestReceivedJsonToJson(
    RtcEngineEventHandlerOnIntraRequestReceivedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  return val;
}

RtcEngineEventHandlerOnUplinkNetworkInfoUpdatedJson
    _$RtcEngineEventHandlerOnUplinkNetworkInfoUpdatedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnUplinkNetworkInfoUpdatedJson(
          info: json['info'] == null
              ? null
              : UplinkNetworkInfo.fromJson(
                  json['info'] as Map<String, dynamic>),
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnUplinkNetworkInfoUpdatedJsonToJson(
        RtcEngineEventHandlerOnUplinkNetworkInfoUpdatedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('info', instance.info?.toJson());
  return val;
}

RtcEngineEventHandlerOnDownlinkNetworkInfoUpdatedJson
    _$RtcEngineEventHandlerOnDownlinkNetworkInfoUpdatedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnDownlinkNetworkInfoUpdatedJson(
          info: json['info'] == null
              ? null
              : DownlinkNetworkInfo.fromJson(
                  json['info'] as Map<String, dynamic>),
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnDownlinkNetworkInfoUpdatedJsonToJson(
        RtcEngineEventHandlerOnDownlinkNetworkInfoUpdatedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('info', instance.info?.toJson());
  return val;
}

RtcEngineEventHandlerOnLastmileQualityJson
    _$RtcEngineEventHandlerOnLastmileQualityJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnLastmileQualityJson(
          quality: $enumDecodeNullable(_$QualityTypeEnumMap, json['quality']),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnLastmileQualityJsonToJson(
    RtcEngineEventHandlerOnLastmileQualityJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('quality', _$QualityTypeEnumMap[instance.quality]);
  return val;
}

RtcEngineEventHandlerOnFirstLocalVideoFrameJson
    _$RtcEngineEventHandlerOnFirstLocalVideoFrameJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnFirstLocalVideoFrameJson(
          source: $enumDecodeNullable(_$VideoSourceTypeEnumMap, json['source']),
          width: (json['width'] as num?)?.toInt(),
          height: (json['height'] as num?)?.toInt(),
          elapsed: (json['elapsed'] as num?)?.toInt(),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnFirstLocalVideoFrameJsonToJson(
    RtcEngineEventHandlerOnFirstLocalVideoFrameJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('source', _$VideoSourceTypeEnumMap[instance.source]);
  writeNotNull('width', instance.width);
  writeNotNull('height', instance.height);
  writeNotNull('elapsed', instance.elapsed);
  return val;
}

RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJson
    _$RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJson(
          source: $enumDecodeNullable(_$VideoSourceTypeEnumMap, json['source']),
          elapsed: (json['elapsed'] as num?)?.toInt(),
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJsonToJson(
        RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('source', _$VideoSourceTypeEnumMap[instance.source]);
  writeNotNull('elapsed', instance.elapsed);
  return val;
}

RtcEngineEventHandlerOnFirstRemoteVideoDecodedJson
    _$RtcEngineEventHandlerOnFirstRemoteVideoDecodedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnFirstRemoteVideoDecodedJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          remoteUid: (json['remoteUid'] as num?)?.toInt(),
          width: (json['width'] as num?)?.toInt(),
          height: (json['height'] as num?)?.toInt(),
          elapsed: (json['elapsed'] as num?)?.toInt(),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnFirstRemoteVideoDecodedJsonToJson(
    RtcEngineEventHandlerOnFirstRemoteVideoDecodedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('remoteUid', instance.remoteUid);
  writeNotNull('width', instance.width);
  writeNotNull('height', instance.height);
  writeNotNull('elapsed', instance.elapsed);
  return val;
}

RtcEngineEventHandlerOnVideoSizeChangedJson
    _$RtcEngineEventHandlerOnVideoSizeChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnVideoSizeChangedJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          sourceType:
              $enumDecodeNullable(_$VideoSourceTypeEnumMap, json['sourceType']),
          uid: (json['uid'] as num?)?.toInt(),
          width: (json['width'] as num?)?.toInt(),
          height: (json['height'] as num?)?.toInt(),
          rotation: (json['rotation'] as num?)?.toInt(),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnVideoSizeChangedJsonToJson(
    RtcEngineEventHandlerOnVideoSizeChangedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('sourceType', _$VideoSourceTypeEnumMap[instance.sourceType]);
  writeNotNull('uid', instance.uid);
  writeNotNull('width', instance.width);
  writeNotNull('height', instance.height);
  writeNotNull('rotation', instance.rotation);
  return val;
}

RtcEngineEventHandlerOnLocalVideoStateChangedJson
    _$RtcEngineEventHandlerOnLocalVideoStateChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnLocalVideoStateChangedJson(
          source: $enumDecodeNullable(_$VideoSourceTypeEnumMap, json['source']),
          state: $enumDecodeNullable(
              _$LocalVideoStreamStateEnumMap, json['state']),
          reason: $enumDecodeNullable(
              _$LocalVideoStreamReasonEnumMap, json['reason']),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnLocalVideoStateChangedJsonToJson(
    RtcEngineEventHandlerOnLocalVideoStateChangedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('source', _$VideoSourceTypeEnumMap[instance.source]);
  writeNotNull('state', _$LocalVideoStreamStateEnumMap[instance.state]);
  writeNotNull('reason', _$LocalVideoStreamReasonEnumMap[instance.reason]);
  return val;
}

const _$LocalVideoStreamStateEnumMap = {
  LocalVideoStreamState.localVideoStreamStateStopped: 0,
  LocalVideoStreamState.localVideoStreamStateCapturing: 1,
  LocalVideoStreamState.localVideoStreamStateEncoding: 2,
  LocalVideoStreamState.localVideoStreamStateFailed: 3,
};

const _$LocalVideoStreamReasonEnumMap = {
  LocalVideoStreamReason.localVideoStreamReasonOk: 0,
  LocalVideoStreamReason.localVideoStreamReasonFailure: 1,
  LocalVideoStreamReason.localVideoStreamReasonDeviceNoPermission: 2,
  LocalVideoStreamReason.localVideoStreamReasonDeviceBusy: 3,
  LocalVideoStreamReason.localVideoStreamReasonCaptureFailure: 4,
  LocalVideoStreamReason.localVideoStreamReasonCodecNotSupport: 5,
  LocalVideoStreamReason.localVideoStreamReasonCaptureInbackground: 6,
  LocalVideoStreamReason.localVideoStreamReasonCaptureMultipleForegroundApps: 7,
  LocalVideoStreamReason.localVideoStreamReasonDeviceNotFound: 8,
  LocalVideoStreamReason.localVideoStreamReasonDeviceDisconnected: 9,
  LocalVideoStreamReason.localVideoStreamReasonDeviceInvalidId: 10,
  LocalVideoStreamReason.localVideoStreamReasonDeviceInterrupt: 14,
  LocalVideoStreamReason.localVideoStreamReasonDeviceFatalError: 15,
  LocalVideoStreamReason.localVideoStreamReasonDeviceSystemPressure: 101,
  LocalVideoStreamReason.localVideoStreamReasonScreenCaptureWindowMinimized: 11,
  LocalVideoStreamReason.localVideoStreamReasonScreenCaptureWindowClosed: 12,
  LocalVideoStreamReason.localVideoStreamReasonScreenCaptureWindowOccluded: 13,
  LocalVideoStreamReason.localVideoStreamReasonScreenCaptureWindowNotSupported:
      20,
  LocalVideoStreamReason.localVideoStreamReasonScreenCaptureFailure: 21,
  LocalVideoStreamReason.localVideoStreamReasonScreenCaptureNoPermission: 22,
  LocalVideoStreamReason.localVideoStreamReasonScreenCaptureAutoFallback: 24,
  LocalVideoStreamReason.localVideoStreamReasonScreenCaptureWindowHidden: 25,
  LocalVideoStreamReason
      .localVideoStreamReasonScreenCaptureWindowRecoverFromHidden: 26,
  LocalVideoStreamReason
      .localVideoStreamReasonScreenCaptureWindowRecoverFromMinimized: 27,
  LocalVideoStreamReason.localVideoStreamReasonScreenCapturePaused: 28,
  LocalVideoStreamReason.localVideoStreamReasonScreenCaptureResumed: 29,
};

RtcEngineEventHandlerOnRemoteVideoStateChangedJson
    _$RtcEngineEventHandlerOnRemoteVideoStateChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnRemoteVideoStateChangedJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          remoteUid: (json['remoteUid'] as num?)?.toInt(),
          state: $enumDecodeNullable(_$RemoteVideoStateEnumMap, json['state']),
          reason: $enumDecodeNullable(
              _$RemoteVideoStateReasonEnumMap, json['reason']),
          elapsed: (json['elapsed'] as num?)?.toInt(),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnRemoteVideoStateChangedJsonToJson(
    RtcEngineEventHandlerOnRemoteVideoStateChangedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('remoteUid', instance.remoteUid);
  writeNotNull('state', _$RemoteVideoStateEnumMap[instance.state]);
  writeNotNull('reason', _$RemoteVideoStateReasonEnumMap[instance.reason]);
  writeNotNull('elapsed', instance.elapsed);
  return val;
}

const _$RemoteVideoStateEnumMap = {
  RemoteVideoState.remoteVideoStateStopped: 0,
  RemoteVideoState.remoteVideoStateStarting: 1,
  RemoteVideoState.remoteVideoStateDecoding: 2,
  RemoteVideoState.remoteVideoStateFrozen: 3,
  RemoteVideoState.remoteVideoStateFailed: 4,
};

const _$RemoteVideoStateReasonEnumMap = {
  RemoteVideoStateReason.remoteVideoStateReasonInternal: 0,
  RemoteVideoStateReason.remoteVideoStateReasonNetworkCongestion: 1,
  RemoteVideoStateReason.remoteVideoStateReasonNetworkRecovery: 2,
  RemoteVideoStateReason.remoteVideoStateReasonLocalMuted: 3,
  RemoteVideoStateReason.remoteVideoStateReasonLocalUnmuted: 4,
  RemoteVideoStateReason.remoteVideoStateReasonRemoteMuted: 5,
  RemoteVideoStateReason.remoteVideoStateReasonRemoteUnmuted: 6,
  RemoteVideoStateReason.remoteVideoStateReasonRemoteOffline: 7,
  RemoteVideoStateReason.remoteVideoStateReasonAudioFallback: 8,
  RemoteVideoStateReason.remoteVideoStateReasonAudioFallbackRecovery: 9,
  RemoteVideoStateReason.remoteVideoStateReasonVideoStreamTypeChangeToLow: 10,
  RemoteVideoStateReason.remoteVideoStateReasonVideoStreamTypeChangeToHigh: 11,
  RemoteVideoStateReason.remoteVideoStateReasonSdkInBackground: 12,
  RemoteVideoStateReason.remoteVideoStateReasonCodecNotSupport: 13,
};

RtcEngineEventHandlerOnFirstRemoteVideoFrameJson
    _$RtcEngineEventHandlerOnFirstRemoteVideoFrameJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnFirstRemoteVideoFrameJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          remoteUid: (json['remoteUid'] as num?)?.toInt(),
          width: (json['width'] as num?)?.toInt(),
          height: (json['height'] as num?)?.toInt(),
          elapsed: (json['elapsed'] as num?)?.toInt(),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnFirstRemoteVideoFrameJsonToJson(
    RtcEngineEventHandlerOnFirstRemoteVideoFrameJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('remoteUid', instance.remoteUid);
  writeNotNull('width', instance.width);
  writeNotNull('height', instance.height);
  writeNotNull('elapsed', instance.elapsed);
  return val;
}

RtcEngineEventHandlerOnUserJoinedJson
    _$RtcEngineEventHandlerOnUserJoinedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnUserJoinedJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          remoteUid: (json['remoteUid'] as num?)?.toInt(),
          elapsed: (json['elapsed'] as num?)?.toInt(),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnUserJoinedJsonToJson(
    RtcEngineEventHandlerOnUserJoinedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('remoteUid', instance.remoteUid);
  writeNotNull('elapsed', instance.elapsed);
  return val;
}

RtcEngineEventHandlerOnUserOfflineJson
    _$RtcEngineEventHandlerOnUserOfflineJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnUserOfflineJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          remoteUid: (json['remoteUid'] as num?)?.toInt(),
          reason: $enumDecodeNullable(
              _$UserOfflineReasonTypeEnumMap, json['reason']),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnUserOfflineJsonToJson(
    RtcEngineEventHandlerOnUserOfflineJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('remoteUid', instance.remoteUid);
  writeNotNull('reason', _$UserOfflineReasonTypeEnumMap[instance.reason]);
  return val;
}

const _$UserOfflineReasonTypeEnumMap = {
  UserOfflineReasonType.userOfflineQuit: 0,
  UserOfflineReasonType.userOfflineDropped: 1,
  UserOfflineReasonType.userOfflineBecomeAudience: 2,
};

RtcEngineEventHandlerOnUserMuteAudioJson
    _$RtcEngineEventHandlerOnUserMuteAudioJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnUserMuteAudioJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          remoteUid: (json['remoteUid'] as num?)?.toInt(),
          muted: json['muted'] as bool?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnUserMuteAudioJsonToJson(
    RtcEngineEventHandlerOnUserMuteAudioJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('remoteUid', instance.remoteUid);
  writeNotNull('muted', instance.muted);
  return val;
}

RtcEngineEventHandlerOnUserMuteVideoJson
    _$RtcEngineEventHandlerOnUserMuteVideoJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnUserMuteVideoJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          remoteUid: (json['remoteUid'] as num?)?.toInt(),
          muted: json['muted'] as bool?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnUserMuteVideoJsonToJson(
    RtcEngineEventHandlerOnUserMuteVideoJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('remoteUid', instance.remoteUid);
  writeNotNull('muted', instance.muted);
  return val;
}

RtcEngineEventHandlerOnUserEnableVideoJson
    _$RtcEngineEventHandlerOnUserEnableVideoJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnUserEnableVideoJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          remoteUid: (json['remoteUid'] as num?)?.toInt(),
          enabled: json['enabled'] as bool?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnUserEnableVideoJsonToJson(
    RtcEngineEventHandlerOnUserEnableVideoJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('remoteUid', instance.remoteUid);
  writeNotNull('enabled', instance.enabled);
  return val;
}

RtcEngineEventHandlerOnUserStateChangedJson
    _$RtcEngineEventHandlerOnUserStateChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnUserStateChangedJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          remoteUid: (json['remoteUid'] as num?)?.toInt(),
          state: (json['state'] as num?)?.toInt(),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnUserStateChangedJsonToJson(
    RtcEngineEventHandlerOnUserStateChangedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('remoteUid', instance.remoteUid);
  writeNotNull('state', instance.state);
  return val;
}

RtcEngineEventHandlerOnUserEnableLocalVideoJson
    _$RtcEngineEventHandlerOnUserEnableLocalVideoJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnUserEnableLocalVideoJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          remoteUid: (json['remoteUid'] as num?)?.toInt(),
          enabled: json['enabled'] as bool?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnUserEnableLocalVideoJsonToJson(
    RtcEngineEventHandlerOnUserEnableLocalVideoJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('remoteUid', instance.remoteUid);
  writeNotNull('enabled', instance.enabled);
  return val;
}

RtcEngineEventHandlerOnRemoteAudioStatsJson
    _$RtcEngineEventHandlerOnRemoteAudioStatsJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnRemoteAudioStatsJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          stats: json['stats'] == null
              ? null
              : RemoteAudioStats.fromJson(
                  json['stats'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnRemoteAudioStatsJsonToJson(
    RtcEngineEventHandlerOnRemoteAudioStatsJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('stats', instance.stats?.toJson());
  return val;
}

RtcEngineEventHandlerOnLocalAudioStatsJson
    _$RtcEngineEventHandlerOnLocalAudioStatsJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnLocalAudioStatsJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          stats: json['stats'] == null
              ? null
              : LocalAudioStats.fromJson(json['stats'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnLocalAudioStatsJsonToJson(
    RtcEngineEventHandlerOnLocalAudioStatsJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('stats', instance.stats?.toJson());
  return val;
}

RtcEngineEventHandlerOnLocalVideoStatsJson
    _$RtcEngineEventHandlerOnLocalVideoStatsJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnLocalVideoStatsJson(
          source: $enumDecodeNullable(_$VideoSourceTypeEnumMap, json['source']),
          stats: json['stats'] == null
              ? null
              : LocalVideoStats.fromJson(json['stats'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnLocalVideoStatsJsonToJson(
    RtcEngineEventHandlerOnLocalVideoStatsJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('source', _$VideoSourceTypeEnumMap[instance.source]);
  writeNotNull('stats', instance.stats?.toJson());
  return val;
}

RtcEngineEventHandlerOnRemoteVideoStatsJson
    _$RtcEngineEventHandlerOnRemoteVideoStatsJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnRemoteVideoStatsJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          stats: json['stats'] == null
              ? null
              : RemoteVideoStats.fromJson(
                  json['stats'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnRemoteVideoStatsJsonToJson(
    RtcEngineEventHandlerOnRemoteVideoStatsJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('stats', instance.stats?.toJson());
  return val;
}

RtcEngineEventHandlerOnCameraReadyJson
    _$RtcEngineEventHandlerOnCameraReadyJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnCameraReadyJson();

Map<String, dynamic> _$RtcEngineEventHandlerOnCameraReadyJsonToJson(
        RtcEngineEventHandlerOnCameraReadyJson instance) =>
    <String, dynamic>{};

RtcEngineEventHandlerOnCameraFocusAreaChangedJson
    _$RtcEngineEventHandlerOnCameraFocusAreaChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnCameraFocusAreaChangedJson(
          x: (json['x'] as num?)?.toInt(),
          y: (json['y'] as num?)?.toInt(),
          width: (json['width'] as num?)?.toInt(),
          height: (json['height'] as num?)?.toInt(),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnCameraFocusAreaChangedJsonToJson(
    RtcEngineEventHandlerOnCameraFocusAreaChangedJson instance) {
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

RtcEngineEventHandlerOnCameraExposureAreaChangedJson
    _$RtcEngineEventHandlerOnCameraExposureAreaChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnCameraExposureAreaChangedJson(
          x: (json['x'] as num?)?.toInt(),
          y: (json['y'] as num?)?.toInt(),
          width: (json['width'] as num?)?.toInt(),
          height: (json['height'] as num?)?.toInt(),
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnCameraExposureAreaChangedJsonToJson(
        RtcEngineEventHandlerOnCameraExposureAreaChangedJson instance) {
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

RtcEngineEventHandlerOnFacePositionChangedJson
    _$RtcEngineEventHandlerOnFacePositionChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnFacePositionChangedJson(
          imageWidth: (json['imageWidth'] as num?)?.toInt(),
          imageHeight: (json['imageHeight'] as num?)?.toInt(),
          vecRectangle: (json['vecRectangle'] as List<dynamic>?)
              ?.map((e) => Rectangle.fromJson(e as Map<String, dynamic>))
              .toList(),
          vecDistance: (json['vecDistance'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList(),
          numFaces: (json['numFaces'] as num?)?.toInt(),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnFacePositionChangedJsonToJson(
    RtcEngineEventHandlerOnFacePositionChangedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('imageWidth', instance.imageWidth);
  writeNotNull('imageHeight', instance.imageHeight);
  writeNotNull(
      'vecRectangle', instance.vecRectangle?.map((e) => e.toJson()).toList());
  writeNotNull('vecDistance', instance.vecDistance);
  writeNotNull('numFaces', instance.numFaces);
  return val;
}

RtcEngineEventHandlerOnVideoStoppedJson
    _$RtcEngineEventHandlerOnVideoStoppedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnVideoStoppedJson();

Map<String, dynamic> _$RtcEngineEventHandlerOnVideoStoppedJsonToJson(
        RtcEngineEventHandlerOnVideoStoppedJson instance) =>
    <String, dynamic>{};

RtcEngineEventHandlerOnAudioMixingStateChangedJson
    _$RtcEngineEventHandlerOnAudioMixingStateChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnAudioMixingStateChangedJson(
          state:
              $enumDecodeNullable(_$AudioMixingStateTypeEnumMap, json['state']),
          reason: $enumDecodeNullable(
              _$AudioMixingReasonTypeEnumMap, json['reason']),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnAudioMixingStateChangedJsonToJson(
    RtcEngineEventHandlerOnAudioMixingStateChangedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('state', _$AudioMixingStateTypeEnumMap[instance.state]);
  writeNotNull('reason', _$AudioMixingReasonTypeEnumMap[instance.reason]);
  return val;
}

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

RtcEngineEventHandlerOnRhythmPlayerStateChangedJson
    _$RtcEngineEventHandlerOnRhythmPlayerStateChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnRhythmPlayerStateChangedJson(
          state: $enumDecodeNullable(
              _$RhythmPlayerStateTypeEnumMap, json['state']),
          reason:
              $enumDecodeNullable(_$RhythmPlayerReasonEnumMap, json['reason']),
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnRhythmPlayerStateChangedJsonToJson(
        RtcEngineEventHandlerOnRhythmPlayerStateChangedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('state', _$RhythmPlayerStateTypeEnumMap[instance.state]);
  writeNotNull('reason', _$RhythmPlayerReasonEnumMap[instance.reason]);
  return val;
}

const _$RhythmPlayerStateTypeEnumMap = {
  RhythmPlayerStateType.rhythmPlayerStateIdle: 810,
  RhythmPlayerStateType.rhythmPlayerStateOpening: 811,
  RhythmPlayerStateType.rhythmPlayerStateDecoding: 812,
  RhythmPlayerStateType.rhythmPlayerStatePlaying: 813,
  RhythmPlayerStateType.rhythmPlayerStateFailed: 814,
};

const _$RhythmPlayerReasonEnumMap = {
  RhythmPlayerReason.rhythmPlayerReasonOk: 0,
  RhythmPlayerReason.rhythmPlayerReasonFailed: 1,
  RhythmPlayerReason.rhythmPlayerReasonCanNotOpen: 801,
  RhythmPlayerReason.rhythmPlayerReasonCanNotPlay: 802,
  RhythmPlayerReason.rhythmPlayerReasonFileOverDurationLimit: 803,
};

RtcEngineEventHandlerOnConnectionLostJson
    _$RtcEngineEventHandlerOnConnectionLostJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnConnectionLostJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnConnectionLostJsonToJson(
    RtcEngineEventHandlerOnConnectionLostJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  return val;
}

RtcEngineEventHandlerOnConnectionInterruptedJson
    _$RtcEngineEventHandlerOnConnectionInterruptedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnConnectionInterruptedJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnConnectionInterruptedJsonToJson(
    RtcEngineEventHandlerOnConnectionInterruptedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  return val;
}

RtcEngineEventHandlerOnConnectionBannedJson
    _$RtcEngineEventHandlerOnConnectionBannedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnConnectionBannedJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnConnectionBannedJsonToJson(
    RtcEngineEventHandlerOnConnectionBannedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  return val;
}

RtcEngineEventHandlerOnStreamMessageJson
    _$RtcEngineEventHandlerOnStreamMessageJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnStreamMessageJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          remoteUid: (json['remoteUid'] as num?)?.toInt(),
          streamId: (json['streamId'] as num?)?.toInt(),
          length: (json['length'] as num?)?.toInt(),
          sentTs: (json['sentTs'] as num?)?.toInt(),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnStreamMessageJsonToJson(
    RtcEngineEventHandlerOnStreamMessageJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('remoteUid', instance.remoteUid);
  writeNotNull('streamId', instance.streamId);
  writeNotNull('length', instance.length);
  writeNotNull('sentTs', instance.sentTs);
  return val;
}

RtcEngineEventHandlerOnStreamMessageErrorJson
    _$RtcEngineEventHandlerOnStreamMessageErrorJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnStreamMessageErrorJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          remoteUid: (json['remoteUid'] as num?)?.toInt(),
          streamId: (json['streamId'] as num?)?.toInt(),
          code: $enumDecodeNullable(_$ErrorCodeTypeEnumMap, json['code']),
          missed: (json['missed'] as num?)?.toInt(),
          cached: (json['cached'] as num?)?.toInt(),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnStreamMessageErrorJsonToJson(
    RtcEngineEventHandlerOnStreamMessageErrorJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('remoteUid', instance.remoteUid);
  writeNotNull('streamId', instance.streamId);
  writeNotNull('code', _$ErrorCodeTypeEnumMap[instance.code]);
  writeNotNull('missed', instance.missed);
  writeNotNull('cached', instance.cached);
  return val;
}

RtcEngineEventHandlerOnRequestTokenJson
    _$RtcEngineEventHandlerOnRequestTokenJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnRequestTokenJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnRequestTokenJsonToJson(
    RtcEngineEventHandlerOnRequestTokenJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  return val;
}

RtcEngineEventHandlerOnTokenPrivilegeWillExpireJson
    _$RtcEngineEventHandlerOnTokenPrivilegeWillExpireJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnTokenPrivilegeWillExpireJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          token: json['token'] as String?,
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnTokenPrivilegeWillExpireJsonToJson(
        RtcEngineEventHandlerOnTokenPrivilegeWillExpireJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('token', instance.token);
  return val;
}

RtcEngineEventHandlerOnLicenseValidationFailureJson
    _$RtcEngineEventHandlerOnLicenseValidationFailureJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnLicenseValidationFailureJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          reason:
              $enumDecodeNullable(_$LicenseErrorTypeEnumMap, json['reason']),
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnLicenseValidationFailureJsonToJson(
        RtcEngineEventHandlerOnLicenseValidationFailureJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('reason', _$LicenseErrorTypeEnumMap[instance.reason]);
  return val;
}

const _$LicenseErrorTypeEnumMap = {
  LicenseErrorType.licenseErrInvalid: 1,
  LicenseErrorType.licenseErrExpire: 2,
  LicenseErrorType.licenseErrMinutesExceed: 3,
  LicenseErrorType.licenseErrLimitedPeriod: 4,
  LicenseErrorType.licenseErrDiffDevices: 5,
  LicenseErrorType.licenseErrInternal: 99,
};

RtcEngineEventHandlerOnFirstLocalAudioFramePublishedJson
    _$RtcEngineEventHandlerOnFirstLocalAudioFramePublishedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnFirstLocalAudioFramePublishedJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          elapsed: (json['elapsed'] as num?)?.toInt(),
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnFirstLocalAudioFramePublishedJsonToJson(
        RtcEngineEventHandlerOnFirstLocalAudioFramePublishedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('elapsed', instance.elapsed);
  return val;
}

RtcEngineEventHandlerOnFirstRemoteAudioDecodedJson
    _$RtcEngineEventHandlerOnFirstRemoteAudioDecodedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnFirstRemoteAudioDecodedJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          uid: (json['uid'] as num?)?.toInt(),
          elapsed: (json['elapsed'] as num?)?.toInt(),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnFirstRemoteAudioDecodedJsonToJson(
    RtcEngineEventHandlerOnFirstRemoteAudioDecodedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('uid', instance.uid);
  writeNotNull('elapsed', instance.elapsed);
  return val;
}

RtcEngineEventHandlerOnFirstRemoteAudioFrameJson
    _$RtcEngineEventHandlerOnFirstRemoteAudioFrameJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnFirstRemoteAudioFrameJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          userId: (json['userId'] as num?)?.toInt(),
          elapsed: (json['elapsed'] as num?)?.toInt(),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnFirstRemoteAudioFrameJsonToJson(
    RtcEngineEventHandlerOnFirstRemoteAudioFrameJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('userId', instance.userId);
  writeNotNull('elapsed', instance.elapsed);
  return val;
}

RtcEngineEventHandlerOnLocalAudioStateChangedJson
    _$RtcEngineEventHandlerOnLocalAudioStateChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnLocalAudioStateChangedJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          state: $enumDecodeNullable(
              _$LocalAudioStreamStateEnumMap, json['state']),
          reason: $enumDecodeNullable(
              _$LocalAudioStreamReasonEnumMap, json['reason']),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnLocalAudioStateChangedJsonToJson(
    RtcEngineEventHandlerOnLocalAudioStateChangedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('state', _$LocalAudioStreamStateEnumMap[instance.state]);
  writeNotNull('reason', _$LocalAudioStreamReasonEnumMap[instance.reason]);
  return val;
}

const _$LocalAudioStreamStateEnumMap = {
  LocalAudioStreamState.localAudioStreamStateStopped: 0,
  LocalAudioStreamState.localAudioStreamStateRecording: 1,
  LocalAudioStreamState.localAudioStreamStateEncoding: 2,
  LocalAudioStreamState.localAudioStreamStateFailed: 3,
};

const _$LocalAudioStreamReasonEnumMap = {
  LocalAudioStreamReason.localAudioStreamReasonOk: 0,
  LocalAudioStreamReason.localAudioStreamReasonFailure: 1,
  LocalAudioStreamReason.localAudioStreamReasonDeviceNoPermission: 2,
  LocalAudioStreamReason.localAudioStreamReasonDeviceBusy: 3,
  LocalAudioStreamReason.localAudioStreamReasonRecordFailure: 4,
  LocalAudioStreamReason.localAudioStreamReasonEncodeFailure: 5,
  LocalAudioStreamReason.localAudioStreamReasonNoRecordingDevice: 6,
  LocalAudioStreamReason.localAudioStreamReasonNoPlayoutDevice: 7,
  LocalAudioStreamReason.localAudioStreamReasonInterrupted: 8,
  LocalAudioStreamReason.localAudioStreamReasonRecordInvalidId: 9,
  LocalAudioStreamReason.localAudioStreamReasonPlayoutInvalidId: 10,
};

RtcEngineEventHandlerOnRemoteAudioStateChangedJson
    _$RtcEngineEventHandlerOnRemoteAudioStateChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnRemoteAudioStateChangedJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          remoteUid: (json['remoteUid'] as num?)?.toInt(),
          state: $enumDecodeNullable(_$RemoteAudioStateEnumMap, json['state']),
          reason: $enumDecodeNullable(
              _$RemoteAudioStateReasonEnumMap, json['reason']),
          elapsed: (json['elapsed'] as num?)?.toInt(),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnRemoteAudioStateChangedJsonToJson(
    RtcEngineEventHandlerOnRemoteAudioStateChangedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('remoteUid', instance.remoteUid);
  writeNotNull('state', _$RemoteAudioStateEnumMap[instance.state]);
  writeNotNull('reason', _$RemoteAudioStateReasonEnumMap[instance.reason]);
  writeNotNull('elapsed', instance.elapsed);
  return val;
}

const _$RemoteAudioStateEnumMap = {
  RemoteAudioState.remoteAudioStateStopped: 0,
  RemoteAudioState.remoteAudioStateStarting: 1,
  RemoteAudioState.remoteAudioStateDecoding: 2,
  RemoteAudioState.remoteAudioStateFrozen: 3,
  RemoteAudioState.remoteAudioStateFailed: 4,
};

const _$RemoteAudioStateReasonEnumMap = {
  RemoteAudioStateReason.remoteAudioReasonInternal: 0,
  RemoteAudioStateReason.remoteAudioReasonNetworkCongestion: 1,
  RemoteAudioStateReason.remoteAudioReasonNetworkRecovery: 2,
  RemoteAudioStateReason.remoteAudioReasonLocalMuted: 3,
  RemoteAudioStateReason.remoteAudioReasonLocalUnmuted: 4,
  RemoteAudioStateReason.remoteAudioReasonRemoteMuted: 5,
  RemoteAudioStateReason.remoteAudioReasonRemoteUnmuted: 6,
  RemoteAudioStateReason.remoteAudioReasonRemoteOffline: 7,
  RemoteAudioStateReason.remoteAudioReasonNoPacketReceive: 8,
  RemoteAudioStateReason.remoteAudioReasonLocalPlayFailed: 9,
};

RtcEngineEventHandlerOnActiveSpeakerJson
    _$RtcEngineEventHandlerOnActiveSpeakerJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnActiveSpeakerJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          uid: (json['uid'] as num?)?.toInt(),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnActiveSpeakerJsonToJson(
    RtcEngineEventHandlerOnActiveSpeakerJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('uid', instance.uid);
  return val;
}

RtcEngineEventHandlerOnContentInspectResultJson
    _$RtcEngineEventHandlerOnContentInspectResultJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnContentInspectResultJson(
          result: $enumDecodeNullable(
              _$ContentInspectResultEnumMap, json['result']),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnContentInspectResultJsonToJson(
    RtcEngineEventHandlerOnContentInspectResultJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('result', _$ContentInspectResultEnumMap[instance.result]);
  return val;
}

const _$ContentInspectResultEnumMap = {
  ContentInspectResult.contentInspectNeutral: 1,
  ContentInspectResult.contentInspectSexy: 2,
  ContentInspectResult.contentInspectPorn: 3,
};

RtcEngineEventHandlerOnSnapshotTakenJson
    _$RtcEngineEventHandlerOnSnapshotTakenJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnSnapshotTakenJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          uid: (json['uid'] as num?)?.toInt(),
          filePath: json['filePath'] as String?,
          width: (json['width'] as num?)?.toInt(),
          height: (json['height'] as num?)?.toInt(),
          errCode: (json['errCode'] as num?)?.toInt(),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnSnapshotTakenJsonToJson(
    RtcEngineEventHandlerOnSnapshotTakenJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('uid', instance.uid);
  writeNotNull('filePath', instance.filePath);
  writeNotNull('width', instance.width);
  writeNotNull('height', instance.height);
  writeNotNull('errCode', instance.errCode);
  return val;
}

RtcEngineEventHandlerOnClientRoleChangedJson
    _$RtcEngineEventHandlerOnClientRoleChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnClientRoleChangedJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          oldRole:
              $enumDecodeNullable(_$ClientRoleTypeEnumMap, json['oldRole']),
          newRole:
              $enumDecodeNullable(_$ClientRoleTypeEnumMap, json['newRole']),
          newRoleOptions: json['newRoleOptions'] == null
              ? null
              : ClientRoleOptions.fromJson(
                  json['newRoleOptions'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnClientRoleChangedJsonToJson(
    RtcEngineEventHandlerOnClientRoleChangedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('oldRole', _$ClientRoleTypeEnumMap[instance.oldRole]);
  writeNotNull('newRole', _$ClientRoleTypeEnumMap[instance.newRole]);
  writeNotNull('newRoleOptions', instance.newRoleOptions?.toJson());
  return val;
}

const _$ClientRoleTypeEnumMap = {
  ClientRoleType.clientRoleBroadcaster: 1,
  ClientRoleType.clientRoleAudience: 2,
};

RtcEngineEventHandlerOnClientRoleChangeFailedJson
    _$RtcEngineEventHandlerOnClientRoleChangeFailedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnClientRoleChangeFailedJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          reason: $enumDecodeNullable(
              _$ClientRoleChangeFailedReasonEnumMap, json['reason']),
          currentRole:
              $enumDecodeNullable(_$ClientRoleTypeEnumMap, json['currentRole']),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnClientRoleChangeFailedJsonToJson(
    RtcEngineEventHandlerOnClientRoleChangeFailedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull(
      'reason', _$ClientRoleChangeFailedReasonEnumMap[instance.reason]);
  writeNotNull('currentRole', _$ClientRoleTypeEnumMap[instance.currentRole]);
  return val;
}

const _$ClientRoleChangeFailedReasonEnumMap = {
  ClientRoleChangeFailedReason.clientRoleChangeFailedTooManyBroadcasters: 1,
  ClientRoleChangeFailedReason.clientRoleChangeFailedNotAuthorized: 2,
  ClientRoleChangeFailedReason.clientRoleChangeFailedRequestTimeOut: 3,
  ClientRoleChangeFailedReason.clientRoleChangeFailedConnectionFailed: 4,
};

RtcEngineEventHandlerOnAudioDeviceVolumeChangedJson
    _$RtcEngineEventHandlerOnAudioDeviceVolumeChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnAudioDeviceVolumeChangedJson(
          deviceType:
              $enumDecodeNullable(_$MediaDeviceTypeEnumMap, json['deviceType']),
          volume: (json['volume'] as num?)?.toInt(),
          muted: json['muted'] as bool?,
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnAudioDeviceVolumeChangedJsonToJson(
        RtcEngineEventHandlerOnAudioDeviceVolumeChangedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('deviceType', _$MediaDeviceTypeEnumMap[instance.deviceType]);
  writeNotNull('volume', instance.volume);
  writeNotNull('muted', instance.muted);
  return val;
}

RtcEngineEventHandlerOnRtmpStreamingStateChangedJson
    _$RtcEngineEventHandlerOnRtmpStreamingStateChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnRtmpStreamingStateChangedJson(
          url: json['url'] as String?,
          state: $enumDecodeNullable(
              _$RtmpStreamPublishStateEnumMap, json['state']),
          reason: $enumDecodeNullable(
              _$RtmpStreamPublishReasonEnumMap, json['reason']),
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnRtmpStreamingStateChangedJsonToJson(
        RtcEngineEventHandlerOnRtmpStreamingStateChangedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('url', instance.url);
  writeNotNull('state', _$RtmpStreamPublishStateEnumMap[instance.state]);
  writeNotNull('reason', _$RtmpStreamPublishReasonEnumMap[instance.reason]);
  return val;
}

const _$RtmpStreamPublishStateEnumMap = {
  RtmpStreamPublishState.rtmpStreamPublishStateIdle: 0,
  RtmpStreamPublishState.rtmpStreamPublishStateConnecting: 1,
  RtmpStreamPublishState.rtmpStreamPublishStateRunning: 2,
  RtmpStreamPublishState.rtmpStreamPublishStateRecovering: 3,
  RtmpStreamPublishState.rtmpStreamPublishStateFailure: 4,
  RtmpStreamPublishState.rtmpStreamPublishStateDisconnecting: 5,
};

const _$RtmpStreamPublishReasonEnumMap = {
  RtmpStreamPublishReason.rtmpStreamPublishReasonOk: 0,
  RtmpStreamPublishReason.rtmpStreamPublishReasonInvalidArgument: 1,
  RtmpStreamPublishReason.rtmpStreamPublishReasonEncryptedStreamNotAllowed: 2,
  RtmpStreamPublishReason.rtmpStreamPublishReasonConnectionTimeout: 3,
  RtmpStreamPublishReason.rtmpStreamPublishReasonInternalServerError: 4,
  RtmpStreamPublishReason.rtmpStreamPublishReasonRtmpServerError: 5,
  RtmpStreamPublishReason.rtmpStreamPublishReasonTooOften: 6,
  RtmpStreamPublishReason.rtmpStreamPublishReasonReachLimit: 7,
  RtmpStreamPublishReason.rtmpStreamPublishReasonNotAuthorized: 8,
  RtmpStreamPublishReason.rtmpStreamPublishReasonStreamNotFound: 9,
  RtmpStreamPublishReason.rtmpStreamPublishReasonFormatNotSupported: 10,
  RtmpStreamPublishReason.rtmpStreamPublishReasonNotBroadcaster: 11,
  RtmpStreamPublishReason.rtmpStreamPublishReasonTranscodingNoMixStream: 13,
  RtmpStreamPublishReason.rtmpStreamPublishReasonNetDown: 14,
  RtmpStreamPublishReason.rtmpStreamPublishReasonInvalidAppid: 15,
  RtmpStreamPublishReason.rtmpStreamPublishReasonInvalidPrivilege: 16,
  RtmpStreamPublishReason.rtmpStreamUnpublishReasonOk: 100,
};

RtcEngineEventHandlerOnRtmpStreamingEventJson
    _$RtcEngineEventHandlerOnRtmpStreamingEventJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnRtmpStreamingEventJson(
          url: json['url'] as String?,
          eventCode: $enumDecodeNullable(
              _$RtmpStreamingEventEnumMap, json['eventCode']),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnRtmpStreamingEventJsonToJson(
    RtcEngineEventHandlerOnRtmpStreamingEventJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('url', instance.url);
  writeNotNull('eventCode', _$RtmpStreamingEventEnumMap[instance.eventCode]);
  return val;
}

const _$RtmpStreamingEventEnumMap = {
  RtmpStreamingEvent.rtmpStreamingEventFailedLoadImage: 1,
  RtmpStreamingEvent.rtmpStreamingEventUrlAlreadyInUse: 2,
  RtmpStreamingEvent.rtmpStreamingEventAdvancedFeatureNotSupport: 3,
  RtmpStreamingEvent.rtmpStreamingEventRequestTooOften: 4,
};

RtcEngineEventHandlerOnTranscodingUpdatedJson
    _$RtcEngineEventHandlerOnTranscodingUpdatedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnTranscodingUpdatedJson();

Map<String, dynamic> _$RtcEngineEventHandlerOnTranscodingUpdatedJsonToJson(
        RtcEngineEventHandlerOnTranscodingUpdatedJson instance) =>
    <String, dynamic>{};

RtcEngineEventHandlerOnAudioRoutingChangedJson
    _$RtcEngineEventHandlerOnAudioRoutingChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnAudioRoutingChangedJson(
          routing: (json['routing'] as num?)?.toInt(),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnAudioRoutingChangedJsonToJson(
    RtcEngineEventHandlerOnAudioRoutingChangedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('routing', instance.routing);
  return val;
}

RtcEngineEventHandlerOnChannelMediaRelayStateChangedJson
    _$RtcEngineEventHandlerOnChannelMediaRelayStateChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnChannelMediaRelayStateChangedJson(
          state: $enumDecodeNullable(
              _$ChannelMediaRelayStateEnumMap, json['state']),
          code: $enumDecodeNullable(
              _$ChannelMediaRelayErrorEnumMap, json['code']),
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnChannelMediaRelayStateChangedJsonToJson(
        RtcEngineEventHandlerOnChannelMediaRelayStateChangedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('state', _$ChannelMediaRelayStateEnumMap[instance.state]);
  writeNotNull('code', _$ChannelMediaRelayErrorEnumMap[instance.code]);
  return val;
}

const _$ChannelMediaRelayStateEnumMap = {
  ChannelMediaRelayState.relayStateIdle: 0,
  ChannelMediaRelayState.relayStateConnecting: 1,
  ChannelMediaRelayState.relayStateRunning: 2,
  ChannelMediaRelayState.relayStateFailure: 3,
};

const _$ChannelMediaRelayErrorEnumMap = {
  ChannelMediaRelayError.relayOk: 0,
  ChannelMediaRelayError.relayErrorServerErrorResponse: 1,
  ChannelMediaRelayError.relayErrorServerNoResponse: 2,
  ChannelMediaRelayError.relayErrorNoResourceAvailable: 3,
  ChannelMediaRelayError.relayErrorFailedJoinSrc: 4,
  ChannelMediaRelayError.relayErrorFailedJoinDest: 5,
  ChannelMediaRelayError.relayErrorFailedPacketReceivedFromSrc: 6,
  ChannelMediaRelayError.relayErrorFailedPacketSentToDest: 7,
  ChannelMediaRelayError.relayErrorServerConnectionLost: 8,
  ChannelMediaRelayError.relayErrorInternalError: 9,
  ChannelMediaRelayError.relayErrorSrcTokenExpired: 10,
  ChannelMediaRelayError.relayErrorDestTokenExpired: 11,
};

RtcEngineEventHandlerOnLocalPublishFallbackToAudioOnlyJson
    _$RtcEngineEventHandlerOnLocalPublishFallbackToAudioOnlyJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnLocalPublishFallbackToAudioOnlyJson(
          isFallbackOrRecover: json['isFallbackOrRecover'] as bool?,
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnLocalPublishFallbackToAudioOnlyJsonToJson(
        RtcEngineEventHandlerOnLocalPublishFallbackToAudioOnlyJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('isFallbackOrRecover', instance.isFallbackOrRecover);
  return val;
}

RtcEngineEventHandlerOnRemoteSubscribeFallbackToAudioOnlyJson
    _$RtcEngineEventHandlerOnRemoteSubscribeFallbackToAudioOnlyJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnRemoteSubscribeFallbackToAudioOnlyJson(
          uid: (json['uid'] as num?)?.toInt(),
          isFallbackOrRecover: json['isFallbackOrRecover'] as bool?,
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnRemoteSubscribeFallbackToAudioOnlyJsonToJson(
        RtcEngineEventHandlerOnRemoteSubscribeFallbackToAudioOnlyJson
            instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uid', instance.uid);
  writeNotNull('isFallbackOrRecover', instance.isFallbackOrRecover);
  return val;
}

RtcEngineEventHandlerOnRemoteAudioTransportStatsJson
    _$RtcEngineEventHandlerOnRemoteAudioTransportStatsJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnRemoteAudioTransportStatsJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          remoteUid: (json['remoteUid'] as num?)?.toInt(),
          delay: (json['delay'] as num?)?.toInt(),
          lost: (json['lost'] as num?)?.toInt(),
          rxKBitRate: (json['rxKBitRate'] as num?)?.toInt(),
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnRemoteAudioTransportStatsJsonToJson(
        RtcEngineEventHandlerOnRemoteAudioTransportStatsJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('remoteUid', instance.remoteUid);
  writeNotNull('delay', instance.delay);
  writeNotNull('lost', instance.lost);
  writeNotNull('rxKBitRate', instance.rxKBitRate);
  return val;
}

RtcEngineEventHandlerOnRemoteVideoTransportStatsJson
    _$RtcEngineEventHandlerOnRemoteVideoTransportStatsJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnRemoteVideoTransportStatsJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          remoteUid: (json['remoteUid'] as num?)?.toInt(),
          delay: (json['delay'] as num?)?.toInt(),
          lost: (json['lost'] as num?)?.toInt(),
          rxKBitRate: (json['rxKBitRate'] as num?)?.toInt(),
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnRemoteVideoTransportStatsJsonToJson(
        RtcEngineEventHandlerOnRemoteVideoTransportStatsJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('remoteUid', instance.remoteUid);
  writeNotNull('delay', instance.delay);
  writeNotNull('lost', instance.lost);
  writeNotNull('rxKBitRate', instance.rxKBitRate);
  return val;
}

RtcEngineEventHandlerOnConnectionStateChangedJson
    _$RtcEngineEventHandlerOnConnectionStateChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnConnectionStateChangedJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          state:
              $enumDecodeNullable(_$ConnectionStateTypeEnumMap, json['state']),
          reason: $enumDecodeNullable(
              _$ConnectionChangedReasonTypeEnumMap, json['reason']),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnConnectionStateChangedJsonToJson(
    RtcEngineEventHandlerOnConnectionStateChangedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('state', _$ConnectionStateTypeEnumMap[instance.state]);
  writeNotNull('reason', _$ConnectionChangedReasonTypeEnumMap[instance.reason]);
  return val;
}

const _$ConnectionStateTypeEnumMap = {
  ConnectionStateType.connectionStateDisconnected: 1,
  ConnectionStateType.connectionStateConnecting: 2,
  ConnectionStateType.connectionStateConnected: 3,
  ConnectionStateType.connectionStateReconnecting: 4,
  ConnectionStateType.connectionStateFailed: 5,
};

const _$ConnectionChangedReasonTypeEnumMap = {
  ConnectionChangedReasonType.connectionChangedConnecting: 0,
  ConnectionChangedReasonType.connectionChangedJoinSuccess: 1,
  ConnectionChangedReasonType.connectionChangedInterrupted: 2,
  ConnectionChangedReasonType.connectionChangedBannedByServer: 3,
  ConnectionChangedReasonType.connectionChangedJoinFailed: 4,
  ConnectionChangedReasonType.connectionChangedLeaveChannel: 5,
  ConnectionChangedReasonType.connectionChangedInvalidAppId: 6,
  ConnectionChangedReasonType.connectionChangedInvalidChannelName: 7,
  ConnectionChangedReasonType.connectionChangedInvalidToken: 8,
  ConnectionChangedReasonType.connectionChangedTokenExpired: 9,
  ConnectionChangedReasonType.connectionChangedRejectedByServer: 10,
  ConnectionChangedReasonType.connectionChangedSettingProxyServer: 11,
  ConnectionChangedReasonType.connectionChangedRenewToken: 12,
  ConnectionChangedReasonType.connectionChangedClientIpAddressChanged: 13,
  ConnectionChangedReasonType.connectionChangedKeepAliveTimeout: 14,
  ConnectionChangedReasonType.connectionChangedRejoinSuccess: 15,
  ConnectionChangedReasonType.connectionChangedLost: 16,
  ConnectionChangedReasonType.connectionChangedEchoTest: 17,
  ConnectionChangedReasonType.connectionChangedClientIpAddressChangedByUser: 18,
  ConnectionChangedReasonType.connectionChangedSameUidLogin: 19,
  ConnectionChangedReasonType.connectionChangedTooManyBroadcasters: 20,
  ConnectionChangedReasonType.connectionChangedLicenseValidationFailure: 21,
  ConnectionChangedReasonType.connectionChangedCertificationVeryfyFailure: 22,
  ConnectionChangedReasonType.connectionChangedStreamChannelNotAvailable: 23,
  ConnectionChangedReasonType.connectionChangedInconsistentAppid: 24,
};

RtcEngineEventHandlerOnWlAccMessageJson
    _$RtcEngineEventHandlerOnWlAccMessageJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnWlAccMessageJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          reason:
              $enumDecodeNullable(_$WlaccMessageReasonEnumMap, json['reason']),
          action:
              $enumDecodeNullable(_$WlaccSuggestActionEnumMap, json['action']),
          wlAccMsg: json['wlAccMsg'] as String?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnWlAccMessageJsonToJson(
    RtcEngineEventHandlerOnWlAccMessageJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('reason', _$WlaccMessageReasonEnumMap[instance.reason]);
  writeNotNull('action', _$WlaccSuggestActionEnumMap[instance.action]);
  writeNotNull('wlAccMsg', instance.wlAccMsg);
  return val;
}

const _$WlaccMessageReasonEnumMap = {
  WlaccMessageReason.wlaccMessageReasonWeakSignal: 0,
  WlaccMessageReason.wlaccMessageReasonChannelCongestion: 1,
};

const _$WlaccSuggestActionEnumMap = {
  WlaccSuggestAction.wlaccSuggestActionCloseToWifi: 0,
  WlaccSuggestAction.wlaccSuggestActionConnectSsid: 1,
  WlaccSuggestAction.wlaccSuggestActionCheck5g: 2,
  WlaccSuggestAction.wlaccSuggestActionModifySsid: 3,
};

RtcEngineEventHandlerOnWlAccStatsJson
    _$RtcEngineEventHandlerOnWlAccStatsJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnWlAccStatsJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          currentStats: json['currentStats'] == null
              ? null
              : WlAccStats.fromJson(
                  json['currentStats'] as Map<String, dynamic>),
          averageStats: json['averageStats'] == null
              ? null
              : WlAccStats.fromJson(
                  json['averageStats'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnWlAccStatsJsonToJson(
    RtcEngineEventHandlerOnWlAccStatsJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('currentStats', instance.currentStats?.toJson());
  writeNotNull('averageStats', instance.averageStats?.toJson());
  return val;
}

RtcEngineEventHandlerOnNetworkTypeChangedJson
    _$RtcEngineEventHandlerOnNetworkTypeChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnNetworkTypeChangedJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          type: $enumDecodeNullable(_$NetworkTypeEnumMap, json['type']),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnNetworkTypeChangedJsonToJson(
    RtcEngineEventHandlerOnNetworkTypeChangedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('type', _$NetworkTypeEnumMap[instance.type]);
  return val;
}

const _$NetworkTypeEnumMap = {
  NetworkType.networkTypeUnknown: -1,
  NetworkType.networkTypeDisconnected: 0,
  NetworkType.networkTypeLan: 1,
  NetworkType.networkTypeWifi: 2,
  NetworkType.networkTypeMobile2g: 3,
  NetworkType.networkTypeMobile3g: 4,
  NetworkType.networkTypeMobile4g: 5,
  NetworkType.networkTypeMobile5g: 6,
};

RtcEngineEventHandlerOnEncryptionErrorJson
    _$RtcEngineEventHandlerOnEncryptionErrorJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnEncryptionErrorJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          errorType: $enumDecodeNullable(
              _$EncryptionErrorTypeEnumMap, json['errorType']),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnEncryptionErrorJsonToJson(
    RtcEngineEventHandlerOnEncryptionErrorJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('errorType', _$EncryptionErrorTypeEnumMap[instance.errorType]);
  return val;
}

const _$EncryptionErrorTypeEnumMap = {
  EncryptionErrorType.encryptionErrorInternalFailure: 0,
  EncryptionErrorType.encryptionErrorDecryptionFailure: 1,
  EncryptionErrorType.encryptionErrorEncryptionFailure: 2,
  EncryptionErrorType.encryptionErrorDatastreamDecryptionFailure: 3,
  EncryptionErrorType.encryptionErrorDatastreamEncryptionFailure: 4,
};

RtcEngineEventHandlerOnPermissionErrorJson
    _$RtcEngineEventHandlerOnPermissionErrorJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnPermissionErrorJson(
          permissionType: $enumDecodeNullable(
              _$PermissionTypeEnumMap, json['permissionType']),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnPermissionErrorJsonToJson(
    RtcEngineEventHandlerOnPermissionErrorJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'permissionType', _$PermissionTypeEnumMap[instance.permissionType]);
  return val;
}

const _$PermissionTypeEnumMap = {
  PermissionType.recordAudio: 0,
  PermissionType.camera: 1,
  PermissionType.screenCapture: 2,
};

RtcEngineEventHandlerOnLocalUserRegisteredJson
    _$RtcEngineEventHandlerOnLocalUserRegisteredJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnLocalUserRegisteredJson(
          uid: (json['uid'] as num?)?.toInt(),
          userAccount: json['userAccount'] as String?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnLocalUserRegisteredJsonToJson(
    RtcEngineEventHandlerOnLocalUserRegisteredJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uid', instance.uid);
  writeNotNull('userAccount', instance.userAccount);
  return val;
}

RtcEngineEventHandlerOnUserInfoUpdatedJson
    _$RtcEngineEventHandlerOnUserInfoUpdatedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnUserInfoUpdatedJson(
          uid: (json['uid'] as num?)?.toInt(),
          info: json['info'] == null
              ? null
              : UserInfo.fromJson(json['info'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnUserInfoUpdatedJsonToJson(
    RtcEngineEventHandlerOnUserInfoUpdatedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uid', instance.uid);
  writeNotNull('info', instance.info?.toJson());
  return val;
}

RtcEngineEventHandlerOnUserAccountUpdatedJson
    _$RtcEngineEventHandlerOnUserAccountUpdatedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnUserAccountUpdatedJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          remoteUid: (json['remoteUid'] as num?)?.toInt(),
          remoteUserAccount: json['remoteUserAccount'] as String?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnUserAccountUpdatedJsonToJson(
    RtcEngineEventHandlerOnUserAccountUpdatedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('remoteUid', instance.remoteUid);
  writeNotNull('remoteUserAccount', instance.remoteUserAccount);
  return val;
}

RtcEngineEventHandlerOnVideoRenderingTracingResultJson
    _$RtcEngineEventHandlerOnVideoRenderingTracingResultJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnVideoRenderingTracingResultJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          uid: (json['uid'] as num?)?.toInt(),
          currentEvent: $enumDecodeNullable(
              _$MediaTraceEventEnumMap, json['currentEvent']),
          tracingInfo: json['tracingInfo'] == null
              ? null
              : VideoRenderingTracingInfo.fromJson(
                  json['tracingInfo'] as Map<String, dynamic>),
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnVideoRenderingTracingResultJsonToJson(
        RtcEngineEventHandlerOnVideoRenderingTracingResultJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('uid', instance.uid);
  writeNotNull('currentEvent', _$MediaTraceEventEnumMap[instance.currentEvent]);
  writeNotNull('tracingInfo', instance.tracingInfo?.toJson());
  return val;
}

const _$MediaTraceEventEnumMap = {
  MediaTraceEvent.mediaTraceEventVideoRendered: 0,
  MediaTraceEvent.mediaTraceEventVideoDecoded: 1,
};

RtcEngineEventHandlerOnLocalVideoTranscoderErrorJson
    _$RtcEngineEventHandlerOnLocalVideoTranscoderErrorJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnLocalVideoTranscoderErrorJson(
          stream: json['stream'] == null
              ? null
              : TranscodingVideoStream.fromJson(
                  json['stream'] as Map<String, dynamic>),
          error:
              $enumDecodeNullable(_$VideoTranscoderErrorEnumMap, json['error']),
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnLocalVideoTranscoderErrorJsonToJson(
        RtcEngineEventHandlerOnLocalVideoTranscoderErrorJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('stream', instance.stream?.toJson());
  writeNotNull('error', _$VideoTranscoderErrorEnumMap[instance.error]);
  return val;
}

const _$VideoTranscoderErrorEnumMap = {
  VideoTranscoderError.vtErrVideoSourceNotReady: 1,
  VideoTranscoderError.vtErrInvalidVideoSourceType: 2,
  VideoTranscoderError.vtErrInvalidImagePath: 3,
  VideoTranscoderError.vtErrUnsupportImageFormat: 4,
  VideoTranscoderError.vtErrInvalidLayout: 5,
  VideoTranscoderError.vtErrInternal: 20,
};

RtcEngineEventHandlerOnUploadLogResultJson
    _$RtcEngineEventHandlerOnUploadLogResultJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnUploadLogResultJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          requestId: json['requestId'] as String?,
          success: json['success'] as bool?,
          reason:
              $enumDecodeNullable(_$UploadErrorReasonEnumMap, json['reason']),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnUploadLogResultJsonToJson(
    RtcEngineEventHandlerOnUploadLogResultJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('requestId', instance.requestId);
  writeNotNull('success', instance.success);
  writeNotNull('reason', _$UploadErrorReasonEnumMap[instance.reason]);
  return val;
}

const _$UploadErrorReasonEnumMap = {
  UploadErrorReason.uploadSuccess: 0,
  UploadErrorReason.uploadNetError: 1,
  UploadErrorReason.uploadServerError: 2,
};

RtcEngineEventHandlerOnAudioSubscribeStateChangedJson
    _$RtcEngineEventHandlerOnAudioSubscribeStateChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnAudioSubscribeStateChangedJson(
          channel: json['channel'] as String?,
          uid: (json['uid'] as num?)?.toInt(),
          oldState: $enumDecodeNullable(
              _$StreamSubscribeStateEnumMap, json['oldState']),
          newState: $enumDecodeNullable(
              _$StreamSubscribeStateEnumMap, json['newState']),
          elapseSinceLastState: (json['elapseSinceLastState'] as num?)?.toInt(),
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnAudioSubscribeStateChangedJsonToJson(
        RtcEngineEventHandlerOnAudioSubscribeStateChangedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('channel', instance.channel);
  writeNotNull('uid', instance.uid);
  writeNotNull('oldState', _$StreamSubscribeStateEnumMap[instance.oldState]);
  writeNotNull('newState', _$StreamSubscribeStateEnumMap[instance.newState]);
  writeNotNull('elapseSinceLastState', instance.elapseSinceLastState);
  return val;
}

const _$StreamSubscribeStateEnumMap = {
  StreamSubscribeState.subStateIdle: 0,
  StreamSubscribeState.subStateNoSubscribed: 1,
  StreamSubscribeState.subStateSubscribing: 2,
  StreamSubscribeState.subStateSubscribed: 3,
};

RtcEngineEventHandlerOnVideoSubscribeStateChangedJson
    _$RtcEngineEventHandlerOnVideoSubscribeStateChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnVideoSubscribeStateChangedJson(
          channel: json['channel'] as String?,
          uid: (json['uid'] as num?)?.toInt(),
          oldState: $enumDecodeNullable(
              _$StreamSubscribeStateEnumMap, json['oldState']),
          newState: $enumDecodeNullable(
              _$StreamSubscribeStateEnumMap, json['newState']),
          elapseSinceLastState: (json['elapseSinceLastState'] as num?)?.toInt(),
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnVideoSubscribeStateChangedJsonToJson(
        RtcEngineEventHandlerOnVideoSubscribeStateChangedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('channel', instance.channel);
  writeNotNull('uid', instance.uid);
  writeNotNull('oldState', _$StreamSubscribeStateEnumMap[instance.oldState]);
  writeNotNull('newState', _$StreamSubscribeStateEnumMap[instance.newState]);
  writeNotNull('elapseSinceLastState', instance.elapseSinceLastState);
  return val;
}

RtcEngineEventHandlerOnAudioPublishStateChangedJson
    _$RtcEngineEventHandlerOnAudioPublishStateChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnAudioPublishStateChangedJson(
          channel: json['channel'] as String?,
          oldState: $enumDecodeNullable(
              _$StreamPublishStateEnumMap, json['oldState']),
          newState: $enumDecodeNullable(
              _$StreamPublishStateEnumMap, json['newState']),
          elapseSinceLastState: (json['elapseSinceLastState'] as num?)?.toInt(),
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnAudioPublishStateChangedJsonToJson(
        RtcEngineEventHandlerOnAudioPublishStateChangedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('channel', instance.channel);
  writeNotNull('oldState', _$StreamPublishStateEnumMap[instance.oldState]);
  writeNotNull('newState', _$StreamPublishStateEnumMap[instance.newState]);
  writeNotNull('elapseSinceLastState', instance.elapseSinceLastState);
  return val;
}

const _$StreamPublishStateEnumMap = {
  StreamPublishState.pubStateIdle: 0,
  StreamPublishState.pubStateNoPublished: 1,
  StreamPublishState.pubStatePublishing: 2,
  StreamPublishState.pubStatePublished: 3,
};

RtcEngineEventHandlerOnVideoPublishStateChangedJson
    _$RtcEngineEventHandlerOnVideoPublishStateChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnVideoPublishStateChangedJson(
          source: $enumDecodeNullable(_$VideoSourceTypeEnumMap, json['source']),
          channel: json['channel'] as String?,
          oldState: $enumDecodeNullable(
              _$StreamPublishStateEnumMap, json['oldState']),
          newState: $enumDecodeNullable(
              _$StreamPublishStateEnumMap, json['newState']),
          elapseSinceLastState: (json['elapseSinceLastState'] as num?)?.toInt(),
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnVideoPublishStateChangedJsonToJson(
        RtcEngineEventHandlerOnVideoPublishStateChangedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('source', _$VideoSourceTypeEnumMap[instance.source]);
  writeNotNull('channel', instance.channel);
  writeNotNull('oldState', _$StreamPublishStateEnumMap[instance.oldState]);
  writeNotNull('newState', _$StreamPublishStateEnumMap[instance.newState]);
  writeNotNull('elapseSinceLastState', instance.elapseSinceLastState);
  return val;
}

RtcEngineEventHandlerOnTranscodedStreamLayoutInfoJson
    _$RtcEngineEventHandlerOnTranscodedStreamLayoutInfoJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnTranscodedStreamLayoutInfoJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          uid: (json['uid'] as num?)?.toInt(),
          width: (json['width'] as num?)?.toInt(),
          height: (json['height'] as num?)?.toInt(),
          layoutCount: (json['layoutCount'] as num?)?.toInt(),
          layoutlist: (json['layoutlist'] as List<dynamic>?)
              ?.map((e) => VideoLayout.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnTranscodedStreamLayoutInfoJsonToJson(
        RtcEngineEventHandlerOnTranscodedStreamLayoutInfoJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('uid', instance.uid);
  writeNotNull('width', instance.width);
  writeNotNull('height', instance.height);
  writeNotNull('layoutCount', instance.layoutCount);
  writeNotNull(
      'layoutlist', instance.layoutlist?.map((e) => e.toJson()).toList());
  return val;
}

RtcEngineEventHandlerOnAudioMetadataReceivedJson
    _$RtcEngineEventHandlerOnAudioMetadataReceivedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnAudioMetadataReceivedJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          uid: (json['uid'] as num?)?.toInt(),
          length: (json['length'] as num?)?.toInt(),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnAudioMetadataReceivedJsonToJson(
    RtcEngineEventHandlerOnAudioMetadataReceivedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('uid', instance.uid);
  writeNotNull('length', instance.length);
  return val;
}

RtcEngineEventHandlerOnExtensionEventJson
    _$RtcEngineEventHandlerOnExtensionEventJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnExtensionEventJson(
          provider: json['provider'] as String?,
          extension: json['extension'] as String?,
          key: json['key'] as String?,
          value: json['value'] as String?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnExtensionEventJsonToJson(
    RtcEngineEventHandlerOnExtensionEventJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('provider', instance.provider);
  writeNotNull('extension', instance.extension);
  writeNotNull('key', instance.key);
  writeNotNull('value', instance.value);
  return val;
}

RtcEngineEventHandlerOnExtensionStartedJson
    _$RtcEngineEventHandlerOnExtensionStartedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnExtensionStartedJson(
          provider: json['provider'] as String?,
          extension: json['extension'] as String?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnExtensionStartedJsonToJson(
    RtcEngineEventHandlerOnExtensionStartedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('provider', instance.provider);
  writeNotNull('extension', instance.extension);
  return val;
}

RtcEngineEventHandlerOnExtensionStoppedJson
    _$RtcEngineEventHandlerOnExtensionStoppedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnExtensionStoppedJson(
          provider: json['provider'] as String?,
          extension: json['extension'] as String?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnExtensionStoppedJsonToJson(
    RtcEngineEventHandlerOnExtensionStoppedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('provider', instance.provider);
  writeNotNull('extension', instance.extension);
  return val;
}

RtcEngineEventHandlerOnExtensionErrorJson
    _$RtcEngineEventHandlerOnExtensionErrorJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnExtensionErrorJson(
          provider: json['provider'] as String?,
          extension: json['extension'] as String?,
          error: (json['error'] as num?)?.toInt(),
          message: json['message'] as String?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnExtensionErrorJsonToJson(
    RtcEngineEventHandlerOnExtensionErrorJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('provider', instance.provider);
  writeNotNull('extension', instance.extension);
  writeNotNull('error', instance.error);
  writeNotNull('message', instance.message);
  return val;
}

RtcEngineEventHandlerOnSetRtmFlagResultJson
    _$RtcEngineEventHandlerOnSetRtmFlagResultJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnSetRtmFlagResultJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          code: (json['code'] as num?)?.toInt(),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnSetRtmFlagResultJsonToJson(
    RtcEngineEventHandlerOnSetRtmFlagResultJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connection', instance.connection?.toJson());
  writeNotNull('code', instance.code);
  return val;
}

MetadataObserverOnMetadataReceivedJson
    _$MetadataObserverOnMetadataReceivedJsonFromJson(
            Map<String, dynamic> json) =>
        MetadataObserverOnMetadataReceivedJson(
          metadata: json['metadata'] == null
              ? null
              : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$MetadataObserverOnMetadataReceivedJsonToJson(
    MetadataObserverOnMetadataReceivedJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('metadata', instance.metadata?.toJson());
  return val;
}

DirectCdnStreamingEventHandlerOnDirectCdnStreamingStateChangedJson
    _$DirectCdnStreamingEventHandlerOnDirectCdnStreamingStateChangedJsonFromJson(
            Map<String, dynamic> json) =>
        DirectCdnStreamingEventHandlerOnDirectCdnStreamingStateChangedJson(
          state: $enumDecodeNullable(
              _$DirectCdnStreamingStateEnumMap, json['state']),
          reason: $enumDecodeNullable(
              _$DirectCdnStreamingReasonEnumMap, json['reason']),
          message: json['message'] as String?,
        );

Map<String, dynamic>
    _$DirectCdnStreamingEventHandlerOnDirectCdnStreamingStateChangedJsonToJson(
        DirectCdnStreamingEventHandlerOnDirectCdnStreamingStateChangedJson
            instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('state', _$DirectCdnStreamingStateEnumMap[instance.state]);
  writeNotNull('reason', _$DirectCdnStreamingReasonEnumMap[instance.reason]);
  writeNotNull('message', instance.message);
  return val;
}

const _$DirectCdnStreamingStateEnumMap = {
  DirectCdnStreamingState.directCdnStreamingStateIdle: 0,
  DirectCdnStreamingState.directCdnStreamingStateRunning: 1,
  DirectCdnStreamingState.directCdnStreamingStateStopped: 2,
  DirectCdnStreamingState.directCdnStreamingStateFailed: 3,
  DirectCdnStreamingState.directCdnStreamingStateRecovering: 4,
};

const _$DirectCdnStreamingReasonEnumMap = {
  DirectCdnStreamingReason.directCdnStreamingReasonOk: 0,
  DirectCdnStreamingReason.directCdnStreamingReasonFailed: 1,
  DirectCdnStreamingReason.directCdnStreamingReasonAudioPublication: 2,
  DirectCdnStreamingReason.directCdnStreamingReasonVideoPublication: 3,
  DirectCdnStreamingReason.directCdnStreamingReasonNetConnect: 4,
  DirectCdnStreamingReason.directCdnStreamingReasonBadName: 5,
};

DirectCdnStreamingEventHandlerOnDirectCdnStreamingStatsJson
    _$DirectCdnStreamingEventHandlerOnDirectCdnStreamingStatsJsonFromJson(
            Map<String, dynamic> json) =>
        DirectCdnStreamingEventHandlerOnDirectCdnStreamingStatsJson(
          stats: json['stats'] == null
              ? null
              : DirectCdnStreamingStats.fromJson(
                  json['stats'] as Map<String, dynamic>),
        );

Map<String, dynamic>
    _$DirectCdnStreamingEventHandlerOnDirectCdnStreamingStatsJsonToJson(
        DirectCdnStreamingEventHandlerOnDirectCdnStreamingStatsJson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('stats', instance.stats?.toJson());
  return val;
}
