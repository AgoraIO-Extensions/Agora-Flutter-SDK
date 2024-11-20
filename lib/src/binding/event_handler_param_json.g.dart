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
            AudioEncodedFrameObserverOnRecordAudioEncodedFrameJson instance) =>
        <String, dynamic>{
          if (instance.length case final value?) 'length': value,
          if (instance.audioEncodedFrameInfo?.toJson() case final value?)
            'audioEncodedFrameInfo': value,
        };

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

Map<String,
    dynamic> _$AudioEncodedFrameObserverOnPlaybackAudioEncodedFrameJsonToJson(
        AudioEncodedFrameObserverOnPlaybackAudioEncodedFrameJson instance) =>
    <String, dynamic>{
      if (instance.length case final value?) 'length': value,
      if (instance.audioEncodedFrameInfo?.toJson() case final value?)
        'audioEncodedFrameInfo': value,
    };

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
            AudioEncodedFrameObserverOnMixedAudioEncodedFrameJson instance) =>
        <String, dynamic>{
          if (instance.length case final value?) 'length': value,
          if (instance.audioEncodedFrameInfo?.toJson() case final value?)
            'audioEncodedFrameInfo': value,
        };

AudioPcmFrameSinkOnFrameJson _$AudioPcmFrameSinkOnFrameJsonFromJson(
        Map<String, dynamic> json) =>
    AudioPcmFrameSinkOnFrameJson(
      frame: json['frame'] == null
          ? null
          : AudioPcmFrame.fromJson(json['frame'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AudioPcmFrameSinkOnFrameJsonToJson(
        AudioPcmFrameSinkOnFrameJson instance) =>
    <String, dynamic>{
      if (instance.frame?.toJson() case final value?) 'frame': value,
    };

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
        AudioFrameObserverBaseOnRecordAudioFrameJson instance) =>
    <String, dynamic>{
      if (instance.channelId case final value?) 'channelId': value,
      if (instance.audioFrame?.toJson() case final value?) 'audioFrame': value,
    };

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
        AudioFrameObserverBaseOnPlaybackAudioFrameJson instance) =>
    <String, dynamic>{
      if (instance.channelId case final value?) 'channelId': value,
      if (instance.audioFrame?.toJson() case final value?) 'audioFrame': value,
    };

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
        AudioFrameObserverBaseOnMixedAudioFrameJson instance) =>
    <String, dynamic>{
      if (instance.channelId case final value?) 'channelId': value,
      if (instance.audioFrame?.toJson() case final value?) 'audioFrame': value,
    };

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
            AudioFrameObserverBaseOnEarMonitoringAudioFrameJson instance) =>
        <String, dynamic>{
          if (instance.audioFrame?.toJson() case final value?)
            'audioFrame': value,
        };

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
            AudioFrameObserverOnPlaybackAudioFrameBeforeMixingJson instance) =>
        <String, dynamic>{
          if (instance.channelId case final value?) 'channelId': value,
          if (instance.uid case final value?) 'uid': value,
          if (instance.audioFrame?.toJson() case final value?)
            'audioFrame': value,
        };

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
        AudioSpectrumObserverOnLocalAudioSpectrumJson instance) =>
    <String, dynamic>{
      if (instance.data?.toJson() case final value?) 'data': value,
    };

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
        AudioSpectrumObserverOnRemoteAudioSpectrumJson instance) =>
    <String, dynamic>{
      if (instance.spectrums?.map((e) => e.toJson()).toList() case final value?)
        'spectrums': value,
      if (instance.spectrumNumber case final value?) 'spectrumNumber': value,
    };

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

Map<String,
    dynamic> _$VideoEncodedFrameObserverOnEncodedVideoFrameReceivedJsonToJson(
        VideoEncodedFrameObserverOnEncodedVideoFrameReceivedJson instance) =>
    <String, dynamic>{
      if (instance.uid case final value?) 'uid': value,
      if (instance.length case final value?) 'length': value,
      if (instance.videoEncodedFrameInfo?.toJson() case final value?)
        'videoEncodedFrameInfo': value,
    };

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
        VideoFrameObserverOnCaptureVideoFrameJson instance) =>
    <String, dynamic>{
      if (_$VideoSourceTypeEnumMap[instance.sourceType] case final value?)
        'sourceType': value,
      if (instance.videoFrame?.toJson() case final value?) 'videoFrame': value,
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
        VideoFrameObserverOnPreEncodeVideoFrameJson instance) =>
    <String, dynamic>{
      if (_$VideoSourceTypeEnumMap[instance.sourceType] case final value?)
        'sourceType': value,
      if (instance.videoFrame?.toJson() case final value?) 'videoFrame': value,
    };

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
        VideoFrameObserverOnMediaPlayerVideoFrameJson instance) =>
    <String, dynamic>{
      if (instance.videoFrame?.toJson() case final value?) 'videoFrame': value,
      if (instance.mediaPlayerId case final value?) 'mediaPlayerId': value,
    };

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
        VideoFrameObserverOnRenderVideoFrameJson instance) =>
    <String, dynamic>{
      if (instance.channelId case final value?) 'channelId': value,
      if (instance.remoteUid case final value?) 'remoteUid': value,
      if (instance.videoFrame?.toJson() case final value?) 'videoFrame': value,
    };

VideoFrameObserverOnTranscodedVideoFrameJson
    _$VideoFrameObserverOnTranscodedVideoFrameJsonFromJson(
            Map<String, dynamic> json) =>
        VideoFrameObserverOnTranscodedVideoFrameJson(
          videoFrame: json['videoFrame'] == null
              ? null
              : VideoFrame.fromJson(json['videoFrame'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$VideoFrameObserverOnTranscodedVideoFrameJsonToJson(
        VideoFrameObserverOnTranscodedVideoFrameJson instance) =>
    <String, dynamic>{
      if (instance.videoFrame?.toJson() case final value?) 'videoFrame': value,
    };

FaceInfoObserverOnFaceInfoJson _$FaceInfoObserverOnFaceInfoJsonFromJson(
        Map<String, dynamic> json) =>
    FaceInfoObserverOnFaceInfoJson(
      outFaceInfo: json['outFaceInfo'] as String?,
    );

Map<String, dynamic> _$FaceInfoObserverOnFaceInfoJsonToJson(
        FaceInfoObserverOnFaceInfoJson instance) =>
    <String, dynamic>{
      if (instance.outFaceInfo case final value?) 'outFaceInfo': value,
    };

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
        MediaRecorderObserverOnRecorderStateChangedJson instance) =>
    <String, dynamic>{
      if (instance.channelId case final value?) 'channelId': value,
      if (instance.uid case final value?) 'uid': value,
      if (_$RecorderStateEnumMap[instance.state] case final value?)
        'state': value,
      if (_$RecorderReasonCodeEnumMap[instance.reason] case final value?)
        'reason': value,
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
        MediaRecorderObserverOnRecorderInfoUpdatedJson instance) =>
    <String, dynamic>{
      if (instance.channelId case final value?) 'channelId': value,
      if (instance.uid case final value?) 'uid': value,
      if (instance.info?.toJson() case final value?) 'info': value,
    };

H265TranscoderObserverOnEnableTranscodeJson
    _$H265TranscoderObserverOnEnableTranscodeJsonFromJson(
            Map<String, dynamic> json) =>
        H265TranscoderObserverOnEnableTranscodeJson(
          result:
              $enumDecodeNullable(_$H265TranscodeResultEnumMap, json['result']),
        );

Map<String, dynamic> _$H265TranscoderObserverOnEnableTranscodeJsonToJson(
        H265TranscoderObserverOnEnableTranscodeJson instance) =>
    <String, dynamic>{
      if (_$H265TranscodeResultEnumMap[instance.result] case final value?)
        'result': value,
    };

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
        H265TranscoderObserverOnQueryChannelJson instance) =>
    <String, dynamic>{
      if (_$H265TranscodeResultEnumMap[instance.result] case final value?)
        'result': value,
      if (instance.originChannel case final value?) 'originChannel': value,
      if (instance.transcodeChannel case final value?)
        'transcodeChannel': value,
    };

H265TranscoderObserverOnTriggerTranscodeJson
    _$H265TranscoderObserverOnTriggerTranscodeJsonFromJson(
            Map<String, dynamic> json) =>
        H265TranscoderObserverOnTriggerTranscodeJson(
          result:
              $enumDecodeNullable(_$H265TranscodeResultEnumMap, json['result']),
        );

Map<String, dynamic> _$H265TranscoderObserverOnTriggerTranscodeJsonToJson(
        H265TranscoderObserverOnTriggerTranscodeJson instance) =>
    <String, dynamic>{
      if (_$H265TranscodeResultEnumMap[instance.result] case final value?)
        'result': value,
    };

MediaPlayerVideoFrameObserverOnFrameJson
    _$MediaPlayerVideoFrameObserverOnFrameJsonFromJson(
            Map<String, dynamic> json) =>
        MediaPlayerVideoFrameObserverOnFrameJson(
          frame: json['frame'] == null
              ? null
              : VideoFrame.fromJson(json['frame'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$MediaPlayerVideoFrameObserverOnFrameJsonToJson(
        MediaPlayerVideoFrameObserverOnFrameJson instance) =>
    <String, dynamic>{
      if (instance.frame?.toJson() case final value?) 'frame': value,
    };

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
            MediaPlayerSourceObserverOnPlayerSourceStateChangedJson instance) =>
        <String, dynamic>{
          if (_$MediaPlayerStateEnumMap[instance.state] case final value?)
            'state': value,
          if (_$MediaPlayerReasonEnumMap[instance.reason] case final value?)
            'reason': value,
        };

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
        MediaPlayerSourceObserverOnPositionChangedJson instance) =>
    <String, dynamic>{
      if (instance.positionMs case final value?) 'positionMs': value,
      if (instance.timestampMs case final value?) 'timestampMs': value,
    };

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
        MediaPlayerSourceObserverOnPlayerEventJson instance) =>
    <String, dynamic>{
      if (_$MediaPlayerEventEnumMap[instance.eventCode] case final value?)
        'eventCode': value,
      if (instance.elapsedTime case final value?) 'elapsedTime': value,
      if (instance.message case final value?) 'message': value,
    };

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
        MediaPlayerSourceObserverOnMetaDataJson instance) =>
    <String, dynamic>{
      if (instance.length case final value?) 'length': value,
    };

MediaPlayerSourceObserverOnPlayBufferUpdatedJson
    _$MediaPlayerSourceObserverOnPlayBufferUpdatedJsonFromJson(
            Map<String, dynamic> json) =>
        MediaPlayerSourceObserverOnPlayBufferUpdatedJson(
          playCachedBuffer: (json['playCachedBuffer'] as num?)?.toInt(),
        );

Map<String, dynamic> _$MediaPlayerSourceObserverOnPlayBufferUpdatedJsonToJson(
        MediaPlayerSourceObserverOnPlayBufferUpdatedJson instance) =>
    <String, dynamic>{
      if (instance.playCachedBuffer case final value?)
        'playCachedBuffer': value,
    };

MediaPlayerSourceObserverOnPreloadEventJson
    _$MediaPlayerSourceObserverOnPreloadEventJsonFromJson(
            Map<String, dynamic> json) =>
        MediaPlayerSourceObserverOnPreloadEventJson(
          src: json['src'] as String?,
          event:
              $enumDecodeNullable(_$PlayerPreloadEventEnumMap, json['event']),
        );

Map<String, dynamic> _$MediaPlayerSourceObserverOnPreloadEventJsonToJson(
        MediaPlayerSourceObserverOnPreloadEventJson instance) =>
    <String, dynamic>{
      if (instance.src case final value?) 'src': value,
      if (_$PlayerPreloadEventEnumMap[instance.event] case final value?)
        'event': value,
    };

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
            MediaPlayerSourceObserverOnPlayerSrcInfoChangedJson instance) =>
        <String, dynamic>{
          if (instance.from?.toJson() case final value?) 'from': value,
          if (instance.to?.toJson() case final value?) 'to': value,
        };

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
        MediaPlayerSourceObserverOnPlayerInfoUpdatedJson instance) =>
    <String, dynamic>{
      if (instance.info?.toJson() case final value?) 'info': value,
    };

MediaPlayerSourceObserverOnPlayerCacheStatsJson
    _$MediaPlayerSourceObserverOnPlayerCacheStatsJsonFromJson(
            Map<String, dynamic> json) =>
        MediaPlayerSourceObserverOnPlayerCacheStatsJson(
          stats: json['stats'] == null
              ? null
              : CacheStatistics.fromJson(json['stats'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$MediaPlayerSourceObserverOnPlayerCacheStatsJsonToJson(
        MediaPlayerSourceObserverOnPlayerCacheStatsJson instance) =>
    <String, dynamic>{
      if (instance.stats?.toJson() case final value?) 'stats': value,
    };

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
        MediaPlayerSourceObserverOnPlayerPlaybackStatsJson instance) =>
    <String, dynamic>{
      if (instance.stats?.toJson() case final value?) 'stats': value,
    };

MediaPlayerSourceObserverOnAudioVolumeIndicationJson
    _$MediaPlayerSourceObserverOnAudioVolumeIndicationJsonFromJson(
            Map<String, dynamic> json) =>
        MediaPlayerSourceObserverOnAudioVolumeIndicationJson(
          volume: (json['volume'] as num?)?.toInt(),
        );

Map<String, dynamic>
    _$MediaPlayerSourceObserverOnAudioVolumeIndicationJsonToJson(
            MediaPlayerSourceObserverOnAudioVolumeIndicationJson instance) =>
        <String, dynamic>{
          if (instance.volume case final value?) 'volume': value,
        };

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
            MusicContentCenterEventHandlerOnMusicChartsResultJson instance) =>
        <String, dynamic>{
          if (instance.requestId case final value?) 'requestId': value,
          if (instance.result?.map((e) => e.toJson()).toList()
              case final value?)
            'result': value,
          if (_$MusicContentCenterStateReasonEnumMap[instance.reason]
              case final value?)
            'reason': value,
        };

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

Map<String,
    dynamic> _$MusicContentCenterEventHandlerOnMusicCollectionResultJsonToJson(
        MusicContentCenterEventHandlerOnMusicCollectionResultJson instance) =>
    <String, dynamic>{
      if (instance.requestId case final value?) 'requestId': value,
      if (_$MusicContentCenterStateReasonEnumMap[instance.reason]
          case final value?)
        'reason': value,
    };

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
        MusicContentCenterEventHandlerOnLyricResultJson instance) =>
    <String, dynamic>{
      if (instance.requestId case final value?) 'requestId': value,
      if (instance.songCode case final value?) 'songCode': value,
      if (instance.lyricUrl case final value?) 'lyricUrl': value,
      if (_$MusicContentCenterStateReasonEnumMap[instance.reason]
          case final value?)
        'reason': value,
    };

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

Map<String,
    dynamic> _$MusicContentCenterEventHandlerOnSongSimpleInfoResultJsonToJson(
        MusicContentCenterEventHandlerOnSongSimpleInfoResultJson instance) =>
    <String, dynamic>{
      if (instance.requestId case final value?) 'requestId': value,
      if (instance.songCode case final value?) 'songCode': value,
      if (instance.simpleInfo case final value?) 'simpleInfo': value,
      if (_$MusicContentCenterStateReasonEnumMap[instance.reason]
          case final value?)
        'reason': value,
    };

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
        MusicContentCenterEventHandlerOnPreLoadEventJson instance) =>
    <String, dynamic>{
      if (instance.requestId case final value?) 'requestId': value,
      if (instance.songCode case final value?) 'songCode': value,
      if (instance.percent case final value?) 'percent': value,
      if (instance.lyricUrl case final value?) 'lyricUrl': value,
      if (_$PreloadStateEnumMap[instance.state] case final value?)
        'state': value,
      if (_$MusicContentCenterStateReasonEnumMap[instance.reason]
          case final value?)
        'reason': value,
    };

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
        RtcEngineEventHandlerOnJoinChannelSuccessJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.elapsed case final value?) 'elapsed': value,
    };

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
        RtcEngineEventHandlerOnRejoinChannelSuccessJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.elapsed case final value?) 'elapsed': value,
    };

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
        RtcEngineEventHandlerOnProxyConnectedJson instance) =>
    <String, dynamic>{
      if (instance.channel case final value?) 'channel': value,
      if (instance.uid case final value?) 'uid': value,
      if (_$ProxyTypeEnumMap[instance.proxyType] case final value?)
        'proxyType': value,
      if (instance.localProxyIp case final value?) 'localProxyIp': value,
      if (instance.elapsed case final value?) 'elapsed': value,
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

RtcEngineEventHandlerOnErrorJson _$RtcEngineEventHandlerOnErrorJsonFromJson(
        Map<String, dynamic> json) =>
    RtcEngineEventHandlerOnErrorJson(
      err: $enumDecodeNullable(_$ErrorCodeTypeEnumMap, json['err']),
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$RtcEngineEventHandlerOnErrorJsonToJson(
        RtcEngineEventHandlerOnErrorJson instance) =>
    <String, dynamic>{
      if (_$ErrorCodeTypeEnumMap[instance.err] case final value?) 'err': value,
      if (instance.msg case final value?) 'msg': value,
    };

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
        RtcEngineEventHandlerOnAudioQualityJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.remoteUid case final value?) 'remoteUid': value,
      if (_$QualityTypeEnumMap[instance.quality] case final value?)
        'quality': value,
      if (instance.delay case final value?) 'delay': value,
      if (instance.lost case final value?) 'lost': value,
    };

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
        RtcEngineEventHandlerOnLastmileProbeResultJson instance) =>
    <String, dynamic>{
      if (instance.result?.toJson() case final value?) 'result': value,
    };

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
        RtcEngineEventHandlerOnAudioVolumeIndicationJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.speakers?.map((e) => e.toJson()).toList() case final value?)
        'speakers': value,
      if (instance.speakerNumber case final value?) 'speakerNumber': value,
      if (instance.totalVolume case final value?) 'totalVolume': value,
    };

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
        RtcEngineEventHandlerOnLeaveChannelJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.stats?.toJson() case final value?) 'stats': value,
    };

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
        RtcEngineEventHandlerOnRtcStatsJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.stats?.toJson() case final value?) 'stats': value,
    };

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
        RtcEngineEventHandlerOnAudioDeviceStateChangedJson instance) =>
    <String, dynamic>{
      if (instance.deviceId case final value?) 'deviceId': value,
      if (_$MediaDeviceTypeEnumMap[instance.deviceType] case final value?)
        'deviceType': value,
      if (_$MediaDeviceStateTypeEnumMap[instance.deviceState] case final value?)
        'deviceState': value,
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
            RtcEngineEventHandlerOnAudioMixingPositionChangedJson instance) =>
        <String, dynamic>{
          if (instance.position case final value?) 'position': value,
        };

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
        RtcEngineEventHandlerOnAudioEffectFinishedJson instance) =>
    <String, dynamic>{
      if (instance.soundId case final value?) 'soundId': value,
    };

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
        RtcEngineEventHandlerOnVideoDeviceStateChangedJson instance) =>
    <String, dynamic>{
      if (instance.deviceId case final value?) 'deviceId': value,
      if (_$MediaDeviceTypeEnumMap[instance.deviceType] case final value?)
        'deviceType': value,
      if (_$MediaDeviceStateTypeEnumMap[instance.deviceState] case final value?)
        'deviceState': value,
    };

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
        RtcEngineEventHandlerOnNetworkQualityJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.remoteUid case final value?) 'remoteUid': value,
      if (_$QualityTypeEnumMap[instance.txQuality] case final value?)
        'txQuality': value,
      if (_$QualityTypeEnumMap[instance.rxQuality] case final value?)
        'rxQuality': value,
    };

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
        RtcEngineEventHandlerOnIntraRequestReceivedJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
    };

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
            RtcEngineEventHandlerOnUplinkNetworkInfoUpdatedJson instance) =>
        <String, dynamic>{
          if (instance.info?.toJson() case final value?) 'info': value,
        };

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
            RtcEngineEventHandlerOnDownlinkNetworkInfoUpdatedJson instance) =>
        <String, dynamic>{
          if (instance.info?.toJson() case final value?) 'info': value,
        };

RtcEngineEventHandlerOnLastmileQualityJson
    _$RtcEngineEventHandlerOnLastmileQualityJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnLastmileQualityJson(
          quality: $enumDecodeNullable(_$QualityTypeEnumMap, json['quality']),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnLastmileQualityJsonToJson(
        RtcEngineEventHandlerOnLastmileQualityJson instance) =>
    <String, dynamic>{
      if (_$QualityTypeEnumMap[instance.quality] case final value?)
        'quality': value,
    };

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
        RtcEngineEventHandlerOnFirstLocalVideoFrameJson instance) =>
    <String, dynamic>{
      if (_$VideoSourceTypeEnumMap[instance.source] case final value?)
        'source': value,
      if (instance.width case final value?) 'width': value,
      if (instance.height case final value?) 'height': value,
      if (instance.elapsed case final value?) 'elapsed': value,
    };

RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJson
    _$RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          elapsed: (json['elapsed'] as num?)?.toInt(),
        );

Map<String,
    dynamic> _$RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJsonToJson(
        RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.elapsed case final value?) 'elapsed': value,
    };

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
        RtcEngineEventHandlerOnFirstRemoteVideoDecodedJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.remoteUid case final value?) 'remoteUid': value,
      if (instance.width case final value?) 'width': value,
      if (instance.height case final value?) 'height': value,
      if (instance.elapsed case final value?) 'elapsed': value,
    };

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
        RtcEngineEventHandlerOnVideoSizeChangedJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (_$VideoSourceTypeEnumMap[instance.sourceType] case final value?)
        'sourceType': value,
      if (instance.uid case final value?) 'uid': value,
      if (instance.width case final value?) 'width': value,
      if (instance.height case final value?) 'height': value,
      if (instance.rotation case final value?) 'rotation': value,
    };

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
        RtcEngineEventHandlerOnLocalVideoStateChangedJson instance) =>
    <String, dynamic>{
      if (_$VideoSourceTypeEnumMap[instance.source] case final value?)
        'source': value,
      if (_$LocalVideoStreamStateEnumMap[instance.state] case final value?)
        'state': value,
      if (_$LocalVideoStreamReasonEnumMap[instance.reason] case final value?)
        'reason': value,
    };

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
        RtcEngineEventHandlerOnRemoteVideoStateChangedJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.remoteUid case final value?) 'remoteUid': value,
      if (_$RemoteVideoStateEnumMap[instance.state] case final value?)
        'state': value,
      if (_$RemoteVideoStateReasonEnumMap[instance.reason] case final value?)
        'reason': value,
      if (instance.elapsed case final value?) 'elapsed': value,
    };

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
        RtcEngineEventHandlerOnFirstRemoteVideoFrameJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.remoteUid case final value?) 'remoteUid': value,
      if (instance.width case final value?) 'width': value,
      if (instance.height case final value?) 'height': value,
      if (instance.elapsed case final value?) 'elapsed': value,
    };

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
        RtcEngineEventHandlerOnUserJoinedJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.remoteUid case final value?) 'remoteUid': value,
      if (instance.elapsed case final value?) 'elapsed': value,
    };

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
        RtcEngineEventHandlerOnUserOfflineJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.remoteUid case final value?) 'remoteUid': value,
      if (_$UserOfflineReasonTypeEnumMap[instance.reason] case final value?)
        'reason': value,
    };

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
        RtcEngineEventHandlerOnUserMuteAudioJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.remoteUid case final value?) 'remoteUid': value,
      if (instance.muted case final value?) 'muted': value,
    };

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
        RtcEngineEventHandlerOnUserMuteVideoJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.remoteUid case final value?) 'remoteUid': value,
      if (instance.muted case final value?) 'muted': value,
    };

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
        RtcEngineEventHandlerOnUserEnableVideoJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.remoteUid case final value?) 'remoteUid': value,
      if (instance.enabled case final value?) 'enabled': value,
    };

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
        RtcEngineEventHandlerOnUserStateChangedJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.remoteUid case final value?) 'remoteUid': value,
      if (instance.state case final value?) 'state': value,
    };

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
        RtcEngineEventHandlerOnUserEnableLocalVideoJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.remoteUid case final value?) 'remoteUid': value,
      if (instance.enabled case final value?) 'enabled': value,
    };

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
        RtcEngineEventHandlerOnRemoteAudioStatsJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.stats?.toJson() case final value?) 'stats': value,
    };

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
        RtcEngineEventHandlerOnLocalAudioStatsJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.stats?.toJson() case final value?) 'stats': value,
    };

RtcEngineEventHandlerOnLocalVideoStatsJson
    _$RtcEngineEventHandlerOnLocalVideoStatsJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnLocalVideoStatsJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          stats: json['stats'] == null
              ? null
              : LocalVideoStats.fromJson(json['stats'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnLocalVideoStatsJsonToJson(
        RtcEngineEventHandlerOnLocalVideoStatsJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.stats?.toJson() case final value?) 'stats': value,
    };

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
        RtcEngineEventHandlerOnRemoteVideoStatsJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.stats?.toJson() case final value?) 'stats': value,
    };

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
        RtcEngineEventHandlerOnCameraFocusAreaChangedJson instance) =>
    <String, dynamic>{
      if (instance.x case final value?) 'x': value,
      if (instance.y case final value?) 'y': value,
      if (instance.width case final value?) 'width': value,
      if (instance.height case final value?) 'height': value,
    };

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
            RtcEngineEventHandlerOnCameraExposureAreaChangedJson instance) =>
        <String, dynamic>{
          if (instance.x case final value?) 'x': value,
          if (instance.y case final value?) 'y': value,
          if (instance.width case final value?) 'width': value,
          if (instance.height case final value?) 'height': value,
        };

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
        RtcEngineEventHandlerOnFacePositionChangedJson instance) =>
    <String, dynamic>{
      if (instance.imageWidth case final value?) 'imageWidth': value,
      if (instance.imageHeight case final value?) 'imageHeight': value,
      if (instance.vecRectangle?.map((e) => e.toJson()).toList()
          case final value?)
        'vecRectangle': value,
      if (instance.vecDistance case final value?) 'vecDistance': value,
      if (instance.numFaces case final value?) 'numFaces': value,
    };

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
        RtcEngineEventHandlerOnAudioMixingStateChangedJson instance) =>
    <String, dynamic>{
      if (_$AudioMixingStateTypeEnumMap[instance.state] case final value?)
        'state': value,
      if (_$AudioMixingReasonTypeEnumMap[instance.reason] case final value?)
        'reason': value,
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
            RtcEngineEventHandlerOnRhythmPlayerStateChangedJson instance) =>
        <String, dynamic>{
          if (_$RhythmPlayerStateTypeEnumMap[instance.state] case final value?)
            'state': value,
          if (_$RhythmPlayerReasonEnumMap[instance.reason] case final value?)
            'reason': value,
        };

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
        RtcEngineEventHandlerOnConnectionLostJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
    };

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
        RtcEngineEventHandlerOnConnectionInterruptedJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
    };

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
        RtcEngineEventHandlerOnConnectionBannedJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
    };

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
        RtcEngineEventHandlerOnStreamMessageJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.remoteUid case final value?) 'remoteUid': value,
      if (instance.streamId case final value?) 'streamId': value,
      if (instance.length case final value?) 'length': value,
      if (instance.sentTs case final value?) 'sentTs': value,
    };

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
        RtcEngineEventHandlerOnStreamMessageErrorJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.remoteUid case final value?) 'remoteUid': value,
      if (instance.streamId case final value?) 'streamId': value,
      if (_$ErrorCodeTypeEnumMap[instance.code] case final value?)
        'code': value,
      if (instance.missed case final value?) 'missed': value,
      if (instance.cached case final value?) 'cached': value,
    };

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
        RtcEngineEventHandlerOnRequestTokenJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
    };

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
            RtcEngineEventHandlerOnTokenPrivilegeWillExpireJson instance) =>
        <String, dynamic>{
          if (instance.connection?.toJson() case final value?)
            'connection': value,
          if (instance.token case final value?) 'token': value,
        };

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
            RtcEngineEventHandlerOnLicenseValidationFailureJson instance) =>
        <String, dynamic>{
          if (instance.connection?.toJson() case final value?)
            'connection': value,
          if (_$LicenseErrorTypeEnumMap[instance.reason] case final value?)
            'reason': value,
        };

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

Map<String,
    dynamic> _$RtcEngineEventHandlerOnFirstLocalAudioFramePublishedJsonToJson(
        RtcEngineEventHandlerOnFirstLocalAudioFramePublishedJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.elapsed case final value?) 'elapsed': value,
    };

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
        RtcEngineEventHandlerOnFirstRemoteAudioDecodedJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.uid case final value?) 'uid': value,
      if (instance.elapsed case final value?) 'elapsed': value,
    };

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
        RtcEngineEventHandlerOnFirstRemoteAudioFrameJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.userId case final value?) 'userId': value,
      if (instance.elapsed case final value?) 'elapsed': value,
    };

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
        RtcEngineEventHandlerOnLocalAudioStateChangedJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (_$LocalAudioStreamStateEnumMap[instance.state] case final value?)
        'state': value,
      if (_$LocalAudioStreamReasonEnumMap[instance.reason] case final value?)
        'reason': value,
    };

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
        RtcEngineEventHandlerOnRemoteAudioStateChangedJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.remoteUid case final value?) 'remoteUid': value,
      if (_$RemoteAudioStateEnumMap[instance.state] case final value?)
        'state': value,
      if (_$RemoteAudioStateReasonEnumMap[instance.reason] case final value?)
        'reason': value,
      if (instance.elapsed case final value?) 'elapsed': value,
    };

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
        RtcEngineEventHandlerOnActiveSpeakerJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.uid case final value?) 'uid': value,
    };

RtcEngineEventHandlerOnContentInspectResultJson
    _$RtcEngineEventHandlerOnContentInspectResultJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnContentInspectResultJson(
          result: $enumDecodeNullable(
              _$ContentInspectResultEnumMap, json['result']),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnContentInspectResultJsonToJson(
        RtcEngineEventHandlerOnContentInspectResultJson instance) =>
    <String, dynamic>{
      if (_$ContentInspectResultEnumMap[instance.result] case final value?)
        'result': value,
    };

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
        RtcEngineEventHandlerOnSnapshotTakenJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.uid case final value?) 'uid': value,
      if (instance.filePath case final value?) 'filePath': value,
      if (instance.width case final value?) 'width': value,
      if (instance.height case final value?) 'height': value,
      if (instance.errCode case final value?) 'errCode': value,
    };

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
        RtcEngineEventHandlerOnClientRoleChangedJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (_$ClientRoleTypeEnumMap[instance.oldRole] case final value?)
        'oldRole': value,
      if (_$ClientRoleTypeEnumMap[instance.newRole] case final value?)
        'newRole': value,
      if (instance.newRoleOptions?.toJson() case final value?)
        'newRoleOptions': value,
    };

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
        RtcEngineEventHandlerOnClientRoleChangeFailedJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (_$ClientRoleChangeFailedReasonEnumMap[instance.reason]
          case final value?)
        'reason': value,
      if (_$ClientRoleTypeEnumMap[instance.currentRole] case final value?)
        'currentRole': value,
    };

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
            RtcEngineEventHandlerOnAudioDeviceVolumeChangedJson instance) =>
        <String, dynamic>{
          if (_$MediaDeviceTypeEnumMap[instance.deviceType] case final value?)
            'deviceType': value,
          if (instance.volume case final value?) 'volume': value,
          if (instance.muted case final value?) 'muted': value,
        };

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
            RtcEngineEventHandlerOnRtmpStreamingStateChangedJson instance) =>
        <String, dynamic>{
          if (instance.url case final value?) 'url': value,
          if (_$RtmpStreamPublishStateEnumMap[instance.state] case final value?)
            'state': value,
          if (_$RtmpStreamPublishReasonEnumMap[instance.reason]
              case final value?)
            'reason': value,
        };

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
        RtcEngineEventHandlerOnRtmpStreamingEventJson instance) =>
    <String, dynamic>{
      if (instance.url case final value?) 'url': value,
      if (_$RtmpStreamingEventEnumMap[instance.eventCode] case final value?)
        'eventCode': value,
    };

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
        RtcEngineEventHandlerOnAudioRoutingChangedJson instance) =>
    <String, dynamic>{
      if (instance.routing case final value?) 'routing': value,
    };

RtcEngineEventHandlerOnChannelMediaRelayStateChangedJson
    _$RtcEngineEventHandlerOnChannelMediaRelayStateChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnChannelMediaRelayStateChangedJson(
          state: $enumDecodeNullable(
              _$ChannelMediaRelayStateEnumMap, json['state']),
          code: $enumDecodeNullable(
              _$ChannelMediaRelayErrorEnumMap, json['code']),
        );

Map<String,
    dynamic> _$RtcEngineEventHandlerOnChannelMediaRelayStateChangedJsonToJson(
        RtcEngineEventHandlerOnChannelMediaRelayStateChangedJson instance) =>
    <String, dynamic>{
      if (_$ChannelMediaRelayStateEnumMap[instance.state] case final value?)
        'state': value,
      if (_$ChannelMediaRelayErrorEnumMap[instance.code] case final value?)
        'code': value,
    };

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

Map<String,
    dynamic> _$RtcEngineEventHandlerOnLocalPublishFallbackToAudioOnlyJsonToJson(
        RtcEngineEventHandlerOnLocalPublishFallbackToAudioOnlyJson instance) =>
    <String, dynamic>{
      if (instance.isFallbackOrRecover case final value?)
        'isFallbackOrRecover': value,
    };

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
                instance) =>
        <String, dynamic>{
          if (instance.uid case final value?) 'uid': value,
          if (instance.isFallbackOrRecover case final value?)
            'isFallbackOrRecover': value,
        };

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
            RtcEngineEventHandlerOnRemoteAudioTransportStatsJson instance) =>
        <String, dynamic>{
          if (instance.connection?.toJson() case final value?)
            'connection': value,
          if (instance.remoteUid case final value?) 'remoteUid': value,
          if (instance.delay case final value?) 'delay': value,
          if (instance.lost case final value?) 'lost': value,
          if (instance.rxKBitRate case final value?) 'rxKBitRate': value,
        };

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
            RtcEngineEventHandlerOnRemoteVideoTransportStatsJson instance) =>
        <String, dynamic>{
          if (instance.connection?.toJson() case final value?)
            'connection': value,
          if (instance.remoteUid case final value?) 'remoteUid': value,
          if (instance.delay case final value?) 'delay': value,
          if (instance.lost case final value?) 'lost': value,
          if (instance.rxKBitRate case final value?) 'rxKBitRate': value,
        };

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
        RtcEngineEventHandlerOnConnectionStateChangedJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (_$ConnectionStateTypeEnumMap[instance.state] case final value?)
        'state': value,
      if (_$ConnectionChangedReasonTypeEnumMap[instance.reason]
          case final value?)
        'reason': value,
    };

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
        RtcEngineEventHandlerOnWlAccMessageJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (_$WlaccMessageReasonEnumMap[instance.reason] case final value?)
        'reason': value,
      if (_$WlaccSuggestActionEnumMap[instance.action] case final value?)
        'action': value,
      if (instance.wlAccMsg case final value?) 'wlAccMsg': value,
    };

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
        RtcEngineEventHandlerOnWlAccStatsJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.currentStats?.toJson() case final value?)
        'currentStats': value,
      if (instance.averageStats?.toJson() case final value?)
        'averageStats': value,
    };

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
        RtcEngineEventHandlerOnNetworkTypeChangedJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (_$NetworkTypeEnumMap[instance.type] case final value?) 'type': value,
    };

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
        RtcEngineEventHandlerOnEncryptionErrorJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (_$EncryptionErrorTypeEnumMap[instance.errorType] case final value?)
        'errorType': value,
    };

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
        RtcEngineEventHandlerOnPermissionErrorJson instance) =>
    <String, dynamic>{
      if (_$PermissionTypeEnumMap[instance.permissionType] case final value?)
        'permissionType': value,
    };

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
        RtcEngineEventHandlerOnLocalUserRegisteredJson instance) =>
    <String, dynamic>{
      if (instance.uid case final value?) 'uid': value,
      if (instance.userAccount case final value?) 'userAccount': value,
    };

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
        RtcEngineEventHandlerOnUserInfoUpdatedJson instance) =>
    <String, dynamic>{
      if (instance.uid case final value?) 'uid': value,
      if (instance.info?.toJson() case final value?) 'info': value,
    };

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
        RtcEngineEventHandlerOnUserAccountUpdatedJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.remoteUid case final value?) 'remoteUid': value,
      if (instance.remoteUserAccount case final value?)
        'remoteUserAccount': value,
    };

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
            RtcEngineEventHandlerOnVideoRenderingTracingResultJson instance) =>
        <String, dynamic>{
          if (instance.connection?.toJson() case final value?)
            'connection': value,
          if (instance.uid case final value?) 'uid': value,
          if (_$MediaTraceEventEnumMap[instance.currentEvent] case final value?)
            'currentEvent': value,
          if (instance.tracingInfo?.toJson() case final value?)
            'tracingInfo': value,
        };

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
            RtcEngineEventHandlerOnLocalVideoTranscoderErrorJson instance) =>
        <String, dynamic>{
          if (instance.stream?.toJson() case final value?) 'stream': value,
          if (_$VideoTranscoderErrorEnumMap[instance.error] case final value?)
            'error': value,
        };

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
        RtcEngineEventHandlerOnUploadLogResultJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.requestId case final value?) 'requestId': value,
      if (instance.success case final value?) 'success': value,
      if (_$UploadErrorReasonEnumMap[instance.reason] case final value?)
        'reason': value,
    };

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
            RtcEngineEventHandlerOnAudioSubscribeStateChangedJson instance) =>
        <String, dynamic>{
          if (instance.channel case final value?) 'channel': value,
          if (instance.uid case final value?) 'uid': value,
          if (_$StreamSubscribeStateEnumMap[instance.oldState]
              case final value?)
            'oldState': value,
          if (_$StreamSubscribeStateEnumMap[instance.newState]
              case final value?)
            'newState': value,
          if (instance.elapseSinceLastState case final value?)
            'elapseSinceLastState': value,
        };

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
            RtcEngineEventHandlerOnVideoSubscribeStateChangedJson instance) =>
        <String, dynamic>{
          if (instance.channel case final value?) 'channel': value,
          if (instance.uid case final value?) 'uid': value,
          if (_$StreamSubscribeStateEnumMap[instance.oldState]
              case final value?)
            'oldState': value,
          if (_$StreamSubscribeStateEnumMap[instance.newState]
              case final value?)
            'newState': value,
          if (instance.elapseSinceLastState case final value?)
            'elapseSinceLastState': value,
        };

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
            RtcEngineEventHandlerOnAudioPublishStateChangedJson instance) =>
        <String, dynamic>{
          if (instance.channel case final value?) 'channel': value,
          if (_$StreamPublishStateEnumMap[instance.oldState] case final value?)
            'oldState': value,
          if (_$StreamPublishStateEnumMap[instance.newState] case final value?)
            'newState': value,
          if (instance.elapseSinceLastState case final value?)
            'elapseSinceLastState': value,
        };

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
            RtcEngineEventHandlerOnVideoPublishStateChangedJson instance) =>
        <String, dynamic>{
          if (_$VideoSourceTypeEnumMap[instance.source] case final value?)
            'source': value,
          if (instance.channel case final value?) 'channel': value,
          if (_$StreamPublishStateEnumMap[instance.oldState] case final value?)
            'oldState': value,
          if (_$StreamPublishStateEnumMap[instance.newState] case final value?)
            'newState': value,
          if (instance.elapseSinceLastState case final value?)
            'elapseSinceLastState': value,
        };

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
            RtcEngineEventHandlerOnTranscodedStreamLayoutInfoJson instance) =>
        <String, dynamic>{
          if (instance.connection?.toJson() case final value?)
            'connection': value,
          if (instance.uid case final value?) 'uid': value,
          if (instance.width case final value?) 'width': value,
          if (instance.height case final value?) 'height': value,
          if (instance.layoutCount case final value?) 'layoutCount': value,
          if (instance.layoutlist?.map((e) => e.toJson()).toList()
              case final value?)
            'layoutlist': value,
        };

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
        RtcEngineEventHandlerOnAudioMetadataReceivedJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.uid case final value?) 'uid': value,
      if (instance.length case final value?) 'length': value,
    };

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
        RtcEngineEventHandlerOnExtensionEventJson instance) =>
    <String, dynamic>{
      if (instance.provider case final value?) 'provider': value,
      if (instance.extension case final value?) 'extension': value,
      if (instance.key case final value?) 'key': value,
      if (instance.value case final value?) 'value': value,
    };

RtcEngineEventHandlerOnExtensionStartedJson
    _$RtcEngineEventHandlerOnExtensionStartedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnExtensionStartedJson(
          provider: json['provider'] as String?,
          extension: json['extension'] as String?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnExtensionStartedJsonToJson(
        RtcEngineEventHandlerOnExtensionStartedJson instance) =>
    <String, dynamic>{
      if (instance.provider case final value?) 'provider': value,
      if (instance.extension case final value?) 'extension': value,
    };

RtcEngineEventHandlerOnExtensionStoppedJson
    _$RtcEngineEventHandlerOnExtensionStoppedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnExtensionStoppedJson(
          provider: json['provider'] as String?,
          extension: json['extension'] as String?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnExtensionStoppedJsonToJson(
        RtcEngineEventHandlerOnExtensionStoppedJson instance) =>
    <String, dynamic>{
      if (instance.provider case final value?) 'provider': value,
      if (instance.extension case final value?) 'extension': value,
    };

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
        RtcEngineEventHandlerOnExtensionErrorJson instance) =>
    <String, dynamic>{
      if (instance.provider case final value?) 'provider': value,
      if (instance.extension case final value?) 'extension': value,
      if (instance.error case final value?) 'error': value,
      if (instance.message case final value?) 'message': value,
    };

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
        RtcEngineEventHandlerOnSetRtmFlagResultJson instance) =>
    <String, dynamic>{
      if (instance.connection?.toJson() case final value?) 'connection': value,
      if (instance.code case final value?) 'code': value,
    };

MetadataObserverOnMetadataReceivedJson
    _$MetadataObserverOnMetadataReceivedJsonFromJson(
            Map<String, dynamic> json) =>
        MetadataObserverOnMetadataReceivedJson(
          metadata: json['metadata'] == null
              ? null
              : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$MetadataObserverOnMetadataReceivedJsonToJson(
        MetadataObserverOnMetadataReceivedJson instance) =>
    <String, dynamic>{
      if (instance.metadata?.toJson() case final value?) 'metadata': value,
    };

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
                instance) =>
        <String, dynamic>{
          if (_$DirectCdnStreamingStateEnumMap[instance.state]
              case final value?)
            'state': value,
          if (_$DirectCdnStreamingReasonEnumMap[instance.reason]
              case final value?)
            'reason': value,
          if (instance.message case final value?) 'message': value,
        };

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
            DirectCdnStreamingEventHandlerOnDirectCdnStreamingStatsJson
                instance) =>
        <String, dynamic>{
          if (instance.stats?.toJson() case final value?) 'stats': value,
        };
