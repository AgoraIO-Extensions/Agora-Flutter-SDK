// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names, deprecated_member_use_from_same_package, unused_element

part of 'event_handler_param_json.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RtcEngineEventHandlerOnJoinChannelSuccessJson
    _$RtcEngineEventHandlerOnJoinChannelSuccessJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnJoinChannelSuccessJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          elapsed: json['elapsed'] as int?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnJoinChannelSuccessJsonToJson(
        RtcEngineEventHandlerOnJoinChannelSuccessJson instance) =>
    <String, dynamic>{
      'connection': instance.connection?.toJson(),
      'elapsed': instance.elapsed,
    };

RtcEngineEventHandlerOnRejoinChannelSuccessJson
    _$RtcEngineEventHandlerOnRejoinChannelSuccessJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnRejoinChannelSuccessJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          elapsed: json['elapsed'] as int?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnRejoinChannelSuccessJsonToJson(
        RtcEngineEventHandlerOnRejoinChannelSuccessJson instance) =>
    <String, dynamic>{
      'connection': instance.connection?.toJson(),
      'elapsed': instance.elapsed,
    };

RtcEngineEventHandlerOnProxyConnectedJson
    _$RtcEngineEventHandlerOnProxyConnectedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnProxyConnectedJson(
          channel: json['channel'] as String?,
          uid: json['uid'] as int?,
          proxyType: $enumDecodeNullable(_$ProxyTypeEnumMap, json['proxyType']),
          localProxyIp: json['localProxyIp'] as String?,
          elapsed: json['elapsed'] as int?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnProxyConnectedJsonToJson(
        RtcEngineEventHandlerOnProxyConnectedJson instance) =>
    <String, dynamic>{
      'channel': instance.channel,
      'uid': instance.uid,
      'proxyType': _$ProxyTypeEnumMap[instance.proxyType],
      'localProxyIp': instance.localProxyIp,
      'elapsed': instance.elapsed,
    };

const _$ProxyTypeEnumMap = {
  ProxyType.noneProxyType: 0,
  ProxyType.udpProxyType: 1,
  ProxyType.tcpProxyType: 2,
  ProxyType.localProxyType: 3,
  ProxyType.tcpProxyAutoFallbackType: 4,
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
      'err': _$ErrorCodeTypeEnumMap[instance.err],
      'msg': instance.msg,
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
          remoteUid: json['remoteUid'] as int?,
          quality: $enumDecodeNullable(_$QualityTypeEnumMap, json['quality']),
          delay: json['delay'] as int?,
          lost: json['lost'] as int?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnAudioQualityJsonToJson(
        RtcEngineEventHandlerOnAudioQualityJson instance) =>
    <String, dynamic>{
      'connection': instance.connection?.toJson(),
      'remoteUid': instance.remoteUid,
      'quality': _$QualityTypeEnumMap[instance.quality],
      'delay': instance.delay,
      'lost': instance.lost,
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
      'result': instance.result?.toJson(),
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
          speakerNumber: json['speakerNumber'] as int?,
          totalVolume: json['totalVolume'] as int?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnAudioVolumeIndicationJsonToJson(
        RtcEngineEventHandlerOnAudioVolumeIndicationJson instance) =>
    <String, dynamic>{
      'connection': instance.connection?.toJson(),
      'speakers': instance.speakers?.map((e) => e.toJson()).toList(),
      'speakerNumber': instance.speakerNumber,
      'totalVolume': instance.totalVolume,
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
      'connection': instance.connection?.toJson(),
      'stats': instance.stats?.toJson(),
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
      'connection': instance.connection?.toJson(),
      'stats': instance.stats?.toJson(),
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
      'deviceId': instance.deviceId,
      'deviceType': _$MediaDeviceTypeEnumMap[instance.deviceType],
      'deviceState': _$MediaDeviceStateTypeEnumMap[instance.deviceState],
    };

const _$MediaDeviceTypeEnumMap = {
  MediaDeviceType.unknownAudioDevice: -1,
  MediaDeviceType.audioPlayoutDevice: 0,
  MediaDeviceType.audioRecordingDevice: 1,
  MediaDeviceType.videoRenderDevice: 2,
  MediaDeviceType.videoCaptureDevice: 3,
  MediaDeviceType.audioApplicationPlayoutDevice: 4,
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
          position: json['position'] as int?,
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnAudioMixingPositionChangedJsonToJson(
            RtcEngineEventHandlerOnAudioMixingPositionChangedJson instance) =>
        <String, dynamic>{
          'position': instance.position,
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
          soundId: json['soundId'] as int?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnAudioEffectFinishedJsonToJson(
        RtcEngineEventHandlerOnAudioEffectFinishedJson instance) =>
    <String, dynamic>{
      'soundId': instance.soundId,
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
      'deviceId': instance.deviceId,
      'deviceType': _$MediaDeviceTypeEnumMap[instance.deviceType],
      'deviceState': _$MediaDeviceStateTypeEnumMap[instance.deviceState],
    };

RtcEngineEventHandlerOnNetworkQualityJson
    _$RtcEngineEventHandlerOnNetworkQualityJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnNetworkQualityJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          remoteUid: json['remoteUid'] as int?,
          txQuality:
              $enumDecodeNullable(_$QualityTypeEnumMap, json['txQuality']),
          rxQuality:
              $enumDecodeNullable(_$QualityTypeEnumMap, json['rxQuality']),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnNetworkQualityJsonToJson(
        RtcEngineEventHandlerOnNetworkQualityJson instance) =>
    <String, dynamic>{
      'connection': instance.connection?.toJson(),
      'remoteUid': instance.remoteUid,
      'txQuality': _$QualityTypeEnumMap[instance.txQuality],
      'rxQuality': _$QualityTypeEnumMap[instance.rxQuality],
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
      'connection': instance.connection?.toJson(),
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
          'info': instance.info?.toJson(),
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
          'info': instance.info?.toJson(),
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
      'quality': _$QualityTypeEnumMap[instance.quality],
    };

RtcEngineEventHandlerOnFirstLocalVideoFrameJson
    _$RtcEngineEventHandlerOnFirstLocalVideoFrameJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnFirstLocalVideoFrameJson(
          source: $enumDecodeNullable(_$VideoSourceTypeEnumMap, json['source']),
          width: json['width'] as int?,
          height: json['height'] as int?,
          elapsed: json['elapsed'] as int?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnFirstLocalVideoFrameJsonToJson(
        RtcEngineEventHandlerOnFirstLocalVideoFrameJson instance) =>
    <String, dynamic>{
      'source': _$VideoSourceTypeEnumMap[instance.source],
      'width': instance.width,
      'height': instance.height,
      'elapsed': instance.elapsed,
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
  VideoSourceType.videoSourceUnknown: 100,
};

RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJson
    _$RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          elapsed: json['elapsed'] as int?,
        );

Map<String,
    dynamic> _$RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJsonToJson(
        RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJson instance) =>
    <String, dynamic>{
      'connection': instance.connection?.toJson(),
      'elapsed': instance.elapsed,
    };

RtcEngineEventHandlerOnFirstRemoteVideoDecodedJson
    _$RtcEngineEventHandlerOnFirstRemoteVideoDecodedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnFirstRemoteVideoDecodedJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          remoteUid: json['remoteUid'] as int?,
          width: json['width'] as int?,
          height: json['height'] as int?,
          elapsed: json['elapsed'] as int?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnFirstRemoteVideoDecodedJsonToJson(
        RtcEngineEventHandlerOnFirstRemoteVideoDecodedJson instance) =>
    <String, dynamic>{
      'connection': instance.connection?.toJson(),
      'remoteUid': instance.remoteUid,
      'width': instance.width,
      'height': instance.height,
      'elapsed': instance.elapsed,
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
          uid: json['uid'] as int?,
          width: json['width'] as int?,
          height: json['height'] as int?,
          rotation: json['rotation'] as int?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnVideoSizeChangedJsonToJson(
        RtcEngineEventHandlerOnVideoSizeChangedJson instance) =>
    <String, dynamic>{
      'connection': instance.connection?.toJson(),
      'sourceType': _$VideoSourceTypeEnumMap[instance.sourceType],
      'uid': instance.uid,
      'width': instance.width,
      'height': instance.height,
      'rotation': instance.rotation,
    };

RtcEngineEventHandlerOnLocalVideoStateChangedJson
    _$RtcEngineEventHandlerOnLocalVideoStateChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnLocalVideoStateChangedJson(
          source: $enumDecodeNullable(_$VideoSourceTypeEnumMap, json['source']),
          state: $enumDecodeNullable(
              _$LocalVideoStreamStateEnumMap, json['state']),
          error: $enumDecodeNullable(
              _$LocalVideoStreamErrorEnumMap, json['error']),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnLocalVideoStateChangedJsonToJson(
        RtcEngineEventHandlerOnLocalVideoStateChangedJson instance) =>
    <String, dynamic>{
      'source': _$VideoSourceTypeEnumMap[instance.source],
      'state': _$LocalVideoStreamStateEnumMap[instance.state],
      'error': _$LocalVideoStreamErrorEnumMap[instance.error],
    };

const _$LocalVideoStreamStateEnumMap = {
  LocalVideoStreamState.localVideoStreamStateStopped: 0,
  LocalVideoStreamState.localVideoStreamStateCapturing: 1,
  LocalVideoStreamState.localVideoStreamStateEncoding: 2,
  LocalVideoStreamState.localVideoStreamStateFailed: 3,
};

const _$LocalVideoStreamErrorEnumMap = {
  LocalVideoStreamError.localVideoStreamErrorOk: 0,
  LocalVideoStreamError.localVideoStreamErrorFailure: 1,
  LocalVideoStreamError.localVideoStreamErrorDeviceNoPermission: 2,
  LocalVideoStreamError.localVideoStreamErrorDeviceBusy: 3,
  LocalVideoStreamError.localVideoStreamErrorCaptureFailure: 4,
  LocalVideoStreamError.localVideoStreamErrorEncodeFailure: 5,
  LocalVideoStreamError.localVideoStreamErrorCaptureInbackground: 6,
  LocalVideoStreamError.localVideoStreamErrorCaptureMultipleForegroundApps: 7,
  LocalVideoStreamError.localVideoStreamErrorDeviceNotFound: 8,
  LocalVideoStreamError.localVideoStreamErrorDeviceDisconnected: 9,
  LocalVideoStreamError.localVideoStreamErrorDeviceInvalidId: 10,
  LocalVideoStreamError.localVideoStreamErrorDeviceSystemPressure: 101,
  LocalVideoStreamError.localVideoStreamErrorScreenCaptureWindowMinimized: 11,
  LocalVideoStreamError.localVideoStreamErrorScreenCaptureWindowClosed: 12,
  LocalVideoStreamError.localVideoStreamErrorScreenCaptureWindowOccluded: 13,
  LocalVideoStreamError.localVideoStreamErrorScreenCaptureWindowNotSupported:
      20,
  LocalVideoStreamError.localVideoStreamErrorScreenCaptureFailure: 21,
  LocalVideoStreamError.localVideoStreamErrorScreenCaptureNoPermission: 22,
};

RtcEngineEventHandlerOnRemoteVideoStateChangedJson
    _$RtcEngineEventHandlerOnRemoteVideoStateChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnRemoteVideoStateChangedJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          remoteUid: json['remoteUid'] as int?,
          state: $enumDecodeNullable(_$RemoteVideoStateEnumMap, json['state']),
          reason: $enumDecodeNullable(
              _$RemoteVideoStateReasonEnumMap, json['reason']),
          elapsed: json['elapsed'] as int?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnRemoteVideoStateChangedJsonToJson(
        RtcEngineEventHandlerOnRemoteVideoStateChangedJson instance) =>
    <String, dynamic>{
      'connection': instance.connection?.toJson(),
      'remoteUid': instance.remoteUid,
      'state': _$RemoteVideoStateEnumMap[instance.state],
      'reason': _$RemoteVideoStateReasonEnumMap[instance.reason],
      'elapsed': instance.elapsed,
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
};

RtcEngineEventHandlerOnFirstRemoteVideoFrameJson
    _$RtcEngineEventHandlerOnFirstRemoteVideoFrameJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnFirstRemoteVideoFrameJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          remoteUid: json['remoteUid'] as int?,
          width: json['width'] as int?,
          height: json['height'] as int?,
          elapsed: json['elapsed'] as int?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnFirstRemoteVideoFrameJsonToJson(
        RtcEngineEventHandlerOnFirstRemoteVideoFrameJson instance) =>
    <String, dynamic>{
      'connection': instance.connection?.toJson(),
      'remoteUid': instance.remoteUid,
      'width': instance.width,
      'height': instance.height,
      'elapsed': instance.elapsed,
    };

RtcEngineEventHandlerOnUserJoinedJson
    _$RtcEngineEventHandlerOnUserJoinedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnUserJoinedJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          remoteUid: json['remoteUid'] as int?,
          elapsed: json['elapsed'] as int?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnUserJoinedJsonToJson(
        RtcEngineEventHandlerOnUserJoinedJson instance) =>
    <String, dynamic>{
      'connection': instance.connection?.toJson(),
      'remoteUid': instance.remoteUid,
      'elapsed': instance.elapsed,
    };

RtcEngineEventHandlerOnUserOfflineJson
    _$RtcEngineEventHandlerOnUserOfflineJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnUserOfflineJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          remoteUid: json['remoteUid'] as int?,
          reason: $enumDecodeNullable(
              _$UserOfflineReasonTypeEnumMap, json['reason']),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnUserOfflineJsonToJson(
        RtcEngineEventHandlerOnUserOfflineJson instance) =>
    <String, dynamic>{
      'connection': instance.connection?.toJson(),
      'remoteUid': instance.remoteUid,
      'reason': _$UserOfflineReasonTypeEnumMap[instance.reason],
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
          remoteUid: json['remoteUid'] as int?,
          muted: json['muted'] as bool?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnUserMuteAudioJsonToJson(
        RtcEngineEventHandlerOnUserMuteAudioJson instance) =>
    <String, dynamic>{
      'connection': instance.connection?.toJson(),
      'remoteUid': instance.remoteUid,
      'muted': instance.muted,
    };

RtcEngineEventHandlerOnUserMuteVideoJson
    _$RtcEngineEventHandlerOnUserMuteVideoJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnUserMuteVideoJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          remoteUid: json['remoteUid'] as int?,
          muted: json['muted'] as bool?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnUserMuteVideoJsonToJson(
        RtcEngineEventHandlerOnUserMuteVideoJson instance) =>
    <String, dynamic>{
      'connection': instance.connection?.toJson(),
      'remoteUid': instance.remoteUid,
      'muted': instance.muted,
    };

RtcEngineEventHandlerOnUserEnableVideoJson
    _$RtcEngineEventHandlerOnUserEnableVideoJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnUserEnableVideoJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          remoteUid: json['remoteUid'] as int?,
          enabled: json['enabled'] as bool?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnUserEnableVideoJsonToJson(
        RtcEngineEventHandlerOnUserEnableVideoJson instance) =>
    <String, dynamic>{
      'connection': instance.connection?.toJson(),
      'remoteUid': instance.remoteUid,
      'enabled': instance.enabled,
    };

RtcEngineEventHandlerOnUserStateChangedJson
    _$RtcEngineEventHandlerOnUserStateChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnUserStateChangedJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          remoteUid: json['remoteUid'] as int?,
          state: json['state'] as int?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnUserStateChangedJsonToJson(
        RtcEngineEventHandlerOnUserStateChangedJson instance) =>
    <String, dynamic>{
      'connection': instance.connection?.toJson(),
      'remoteUid': instance.remoteUid,
      'state': instance.state,
    };

RtcEngineEventHandlerOnUserEnableLocalVideoJson
    _$RtcEngineEventHandlerOnUserEnableLocalVideoJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnUserEnableLocalVideoJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          remoteUid: json['remoteUid'] as int?,
          enabled: json['enabled'] as bool?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnUserEnableLocalVideoJsonToJson(
        RtcEngineEventHandlerOnUserEnableLocalVideoJson instance) =>
    <String, dynamic>{
      'connection': instance.connection?.toJson(),
      'remoteUid': instance.remoteUid,
      'enabled': instance.enabled,
    };

RtcEngineEventHandlerOnApiCallExecutedJson
    _$RtcEngineEventHandlerOnApiCallExecutedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnApiCallExecutedJson(
          err: $enumDecodeNullable(_$ErrorCodeTypeEnumMap, json['err']),
          api: json['api'] as String?,
          result: json['result'] as String?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnApiCallExecutedJsonToJson(
        RtcEngineEventHandlerOnApiCallExecutedJson instance) =>
    <String, dynamic>{
      'err': _$ErrorCodeTypeEnumMap[instance.err],
      'api': instance.api,
      'result': instance.result,
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
      'connection': instance.connection?.toJson(),
      'stats': instance.stats?.toJson(),
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
      'connection': instance.connection?.toJson(),
      'stats': instance.stats?.toJson(),
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
      'connection': instance.connection?.toJson(),
      'stats': instance.stats?.toJson(),
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
      'connection': instance.connection?.toJson(),
      'stats': instance.stats?.toJson(),
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
          x: json['x'] as int?,
          y: json['y'] as int?,
          width: json['width'] as int?,
          height: json['height'] as int?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnCameraFocusAreaChangedJsonToJson(
        RtcEngineEventHandlerOnCameraFocusAreaChangedJson instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'width': instance.width,
      'height': instance.height,
    };

RtcEngineEventHandlerOnCameraExposureAreaChangedJson
    _$RtcEngineEventHandlerOnCameraExposureAreaChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnCameraExposureAreaChangedJson(
          x: json['x'] as int?,
          y: json['y'] as int?,
          width: json['width'] as int?,
          height: json['height'] as int?,
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnCameraExposureAreaChangedJsonToJson(
            RtcEngineEventHandlerOnCameraExposureAreaChangedJson instance) =>
        <String, dynamic>{
          'x': instance.x,
          'y': instance.y,
          'width': instance.width,
          'height': instance.height,
        };

RtcEngineEventHandlerOnFacePositionChangedJson
    _$RtcEngineEventHandlerOnFacePositionChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnFacePositionChangedJson(
          imageWidth: json['imageWidth'] as int?,
          imageHeight: json['imageHeight'] as int?,
          vecRectangle: json['vecRectangle'] == null
              ? null
              : Rectangle.fromJson(
                  json['vecRectangle'] as Map<String, dynamic>),
          vecDistance: json['vecDistance'] as int?,
          numFaces: json['numFaces'] as int?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnFacePositionChangedJsonToJson(
        RtcEngineEventHandlerOnFacePositionChangedJson instance) =>
    <String, dynamic>{
      'imageWidth': instance.imageWidth,
      'imageHeight': instance.imageHeight,
      'vecRectangle': instance.vecRectangle?.toJson(),
      'vecDistance': instance.vecDistance,
      'numFaces': instance.numFaces,
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
      'state': _$AudioMixingStateTypeEnumMap[instance.state],
      'reason': _$AudioMixingReasonTypeEnumMap[instance.reason],
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
          errorCode: $enumDecodeNullable(
              _$RhythmPlayerErrorTypeEnumMap, json['errorCode']),
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnRhythmPlayerStateChangedJsonToJson(
            RtcEngineEventHandlerOnRhythmPlayerStateChangedJson instance) =>
        <String, dynamic>{
          'state': _$RhythmPlayerStateTypeEnumMap[instance.state],
          'errorCode': _$RhythmPlayerErrorTypeEnumMap[instance.errorCode],
        };

const _$RhythmPlayerStateTypeEnumMap = {
  RhythmPlayerStateType.rhythmPlayerStateIdle: 810,
  RhythmPlayerStateType.rhythmPlayerStateOpening: 811,
  RhythmPlayerStateType.rhythmPlayerStateDecoding: 812,
  RhythmPlayerStateType.rhythmPlayerStatePlaying: 813,
  RhythmPlayerStateType.rhythmPlayerStateFailed: 814,
};

const _$RhythmPlayerErrorTypeEnumMap = {
  RhythmPlayerErrorType.rhythmPlayerErrorOk: 0,
  RhythmPlayerErrorType.rhythmPlayerErrorFailed: 1,
  RhythmPlayerErrorType.rhythmPlayerErrorCanNotOpen: 801,
  RhythmPlayerErrorType.rhythmPlayerErrorCanNotPlay: 802,
  RhythmPlayerErrorType.rhythmPlayerErrorFileOverDurationLimit: 803,
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
      'connection': instance.connection?.toJson(),
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
      'connection': instance.connection?.toJson(),
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
      'connection': instance.connection?.toJson(),
    };

RtcEngineEventHandlerOnStreamMessageJson
    _$RtcEngineEventHandlerOnStreamMessageJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnStreamMessageJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          remoteUid: json['remoteUid'] as int?,
          streamId: json['streamId'] as int?,
          length: json['length'] as int?,
          sentTs: json['sentTs'] as int?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnStreamMessageJsonToJson(
        RtcEngineEventHandlerOnStreamMessageJson instance) =>
    <String, dynamic>{
      'connection': instance.connection?.toJson(),
      'remoteUid': instance.remoteUid,
      'streamId': instance.streamId,
      'length': instance.length,
      'sentTs': instance.sentTs,
    };

RtcEngineEventHandlerOnStreamMessageErrorJson
    _$RtcEngineEventHandlerOnStreamMessageErrorJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnStreamMessageErrorJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          remoteUid: json['remoteUid'] as int?,
          streamId: json['streamId'] as int?,
          code: $enumDecodeNullable(_$ErrorCodeTypeEnumMap, json['code']),
          missed: json['missed'] as int?,
          cached: json['cached'] as int?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnStreamMessageErrorJsonToJson(
        RtcEngineEventHandlerOnStreamMessageErrorJson instance) =>
    <String, dynamic>{
      'connection': instance.connection?.toJson(),
      'remoteUid': instance.remoteUid,
      'streamId': instance.streamId,
      'code': _$ErrorCodeTypeEnumMap[instance.code],
      'missed': instance.missed,
      'cached': instance.cached,
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
      'connection': instance.connection?.toJson(),
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
          'connection': instance.connection?.toJson(),
          'token': instance.token,
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
          'connection': instance.connection?.toJson(),
          'reason': _$LicenseErrorTypeEnumMap[instance.reason],
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
          elapsed: json['elapsed'] as int?,
        );

Map<String,
    dynamic> _$RtcEngineEventHandlerOnFirstLocalAudioFramePublishedJsonToJson(
        RtcEngineEventHandlerOnFirstLocalAudioFramePublishedJson instance) =>
    <String, dynamic>{
      'connection': instance.connection?.toJson(),
      'elapsed': instance.elapsed,
    };

RtcEngineEventHandlerOnFirstRemoteAudioFrameJson
    _$RtcEngineEventHandlerOnFirstRemoteAudioFrameJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnFirstRemoteAudioFrameJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          userId: json['userId'] as int?,
          elapsed: json['elapsed'] as int?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnFirstRemoteAudioFrameJsonToJson(
        RtcEngineEventHandlerOnFirstRemoteAudioFrameJson instance) =>
    <String, dynamic>{
      'connection': instance.connection?.toJson(),
      'userId': instance.userId,
      'elapsed': instance.elapsed,
    };

RtcEngineEventHandlerOnFirstRemoteAudioDecodedJson
    _$RtcEngineEventHandlerOnFirstRemoteAudioDecodedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnFirstRemoteAudioDecodedJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          uid: json['uid'] as int?,
          elapsed: json['elapsed'] as int?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnFirstRemoteAudioDecodedJsonToJson(
        RtcEngineEventHandlerOnFirstRemoteAudioDecodedJson instance) =>
    <String, dynamic>{
      'connection': instance.connection?.toJson(),
      'uid': instance.uid,
      'elapsed': instance.elapsed,
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
          error: $enumDecodeNullable(
              _$LocalAudioStreamErrorEnumMap, json['error']),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnLocalAudioStateChangedJsonToJson(
        RtcEngineEventHandlerOnLocalAudioStateChangedJson instance) =>
    <String, dynamic>{
      'connection': instance.connection?.toJson(),
      'state': _$LocalAudioStreamStateEnumMap[instance.state],
      'error': _$LocalAudioStreamErrorEnumMap[instance.error],
    };

const _$LocalAudioStreamStateEnumMap = {
  LocalAudioStreamState.localAudioStreamStateStopped: 0,
  LocalAudioStreamState.localAudioStreamStateRecording: 1,
  LocalAudioStreamState.localAudioStreamStateEncoding: 2,
  LocalAudioStreamState.localAudioStreamStateFailed: 3,
};

const _$LocalAudioStreamErrorEnumMap = {
  LocalAudioStreamError.localAudioStreamErrorOk: 0,
  LocalAudioStreamError.localAudioStreamErrorFailure: 1,
  LocalAudioStreamError.localAudioStreamErrorDeviceNoPermission: 2,
  LocalAudioStreamError.localAudioStreamErrorDeviceBusy: 3,
  LocalAudioStreamError.localAudioStreamErrorRecordFailure: 4,
  LocalAudioStreamError.localAudioStreamErrorEncodeFailure: 5,
  LocalAudioStreamError.localAudioStreamErrorNoRecordingDevice: 6,
  LocalAudioStreamError.localAudioStreamErrorNoPlayoutDevice: 7,
  LocalAudioStreamError.localAudioStreamErrorInterrupted: 8,
  LocalAudioStreamError.localAudioStreamErrorRecordInvalidId: 9,
  LocalAudioStreamError.localAudioStreamErrorPlayoutInvalidId: 10,
};

RtcEngineEventHandlerOnRemoteAudioStateChangedJson
    _$RtcEngineEventHandlerOnRemoteAudioStateChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnRemoteAudioStateChangedJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          remoteUid: json['remoteUid'] as int?,
          state: $enumDecodeNullable(_$RemoteAudioStateEnumMap, json['state']),
          reason: $enumDecodeNullable(
              _$RemoteAudioStateReasonEnumMap, json['reason']),
          elapsed: json['elapsed'] as int?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnRemoteAudioStateChangedJsonToJson(
        RtcEngineEventHandlerOnRemoteAudioStateChangedJson instance) =>
    <String, dynamic>{
      'connection': instance.connection?.toJson(),
      'remoteUid': instance.remoteUid,
      'state': _$RemoteAudioStateEnumMap[instance.state],
      'reason': _$RemoteAudioStateReasonEnumMap[instance.reason],
      'elapsed': instance.elapsed,
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
};

RtcEngineEventHandlerOnActiveSpeakerJson
    _$RtcEngineEventHandlerOnActiveSpeakerJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnActiveSpeakerJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          uid: json['uid'] as int?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnActiveSpeakerJsonToJson(
        RtcEngineEventHandlerOnActiveSpeakerJson instance) =>
    <String, dynamic>{
      'connection': instance.connection?.toJson(),
      'uid': instance.uid,
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
      'result': _$ContentInspectResultEnumMap[instance.result],
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
          uid: json['uid'] as int?,
          filePath: json['filePath'] as String?,
          width: json['width'] as int?,
          height: json['height'] as int?,
          errCode: json['errCode'] as int?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnSnapshotTakenJsonToJson(
        RtcEngineEventHandlerOnSnapshotTakenJson instance) =>
    <String, dynamic>{
      'connection': instance.connection?.toJson(),
      'uid': instance.uid,
      'filePath': instance.filePath,
      'width': instance.width,
      'height': instance.height,
      'errCode': instance.errCode,
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
      'connection': instance.connection?.toJson(),
      'oldRole': _$ClientRoleTypeEnumMap[instance.oldRole],
      'newRole': _$ClientRoleTypeEnumMap[instance.newRole],
      'newRoleOptions': instance.newRoleOptions?.toJson(),
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
      'connection': instance.connection?.toJson(),
      'reason': _$ClientRoleChangeFailedReasonEnumMap[instance.reason],
      'currentRole': _$ClientRoleTypeEnumMap[instance.currentRole],
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
          volume: json['volume'] as int?,
          muted: json['muted'] as bool?,
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnAudioDeviceVolumeChangedJsonToJson(
            RtcEngineEventHandlerOnAudioDeviceVolumeChangedJson instance) =>
        <String, dynamic>{
          'deviceType': _$MediaDeviceTypeEnumMap[instance.deviceType],
          'volume': instance.volume,
          'muted': instance.muted,
        };

RtcEngineEventHandlerOnRtmpStreamingStateChangedJson
    _$RtcEngineEventHandlerOnRtmpStreamingStateChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnRtmpStreamingStateChangedJson(
          url: json['url'] as String?,
          state: $enumDecodeNullable(
              _$RtmpStreamPublishStateEnumMap, json['state']),
          errCode: $enumDecodeNullable(
              _$RtmpStreamPublishErrorTypeEnumMap, json['errCode']),
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnRtmpStreamingStateChangedJsonToJson(
            RtcEngineEventHandlerOnRtmpStreamingStateChangedJson instance) =>
        <String, dynamic>{
          'url': instance.url,
          'state': _$RtmpStreamPublishStateEnumMap[instance.state],
          'errCode': _$RtmpStreamPublishErrorTypeEnumMap[instance.errCode],
        };

const _$RtmpStreamPublishStateEnumMap = {
  RtmpStreamPublishState.rtmpStreamPublishStateIdle: 0,
  RtmpStreamPublishState.rtmpStreamPublishStateConnecting: 1,
  RtmpStreamPublishState.rtmpStreamPublishStateRunning: 2,
  RtmpStreamPublishState.rtmpStreamPublishStateRecovering: 3,
  RtmpStreamPublishState.rtmpStreamPublishStateFailure: 4,
  RtmpStreamPublishState.rtmpStreamPublishStateDisconnecting: 5,
};

const _$RtmpStreamPublishErrorTypeEnumMap = {
  RtmpStreamPublishErrorType.rtmpStreamPublishErrorOk: 0,
  RtmpStreamPublishErrorType.rtmpStreamPublishErrorInvalidArgument: 1,
  RtmpStreamPublishErrorType.rtmpStreamPublishErrorEncryptedStreamNotAllowed: 2,
  RtmpStreamPublishErrorType.rtmpStreamPublishErrorConnectionTimeout: 3,
  RtmpStreamPublishErrorType.rtmpStreamPublishErrorInternalServerError: 4,
  RtmpStreamPublishErrorType.rtmpStreamPublishErrorRtmpServerError: 5,
  RtmpStreamPublishErrorType.rtmpStreamPublishErrorTooOften: 6,
  RtmpStreamPublishErrorType.rtmpStreamPublishErrorReachLimit: 7,
  RtmpStreamPublishErrorType.rtmpStreamPublishErrorNotAuthorized: 8,
  RtmpStreamPublishErrorType.rtmpStreamPublishErrorStreamNotFound: 9,
  RtmpStreamPublishErrorType.rtmpStreamPublishErrorFormatNotSupported: 10,
  RtmpStreamPublishErrorType.rtmpStreamPublishErrorNotBroadcaster: 11,
  RtmpStreamPublishErrorType.rtmpStreamPublishErrorTranscodingNoMixStream: 13,
  RtmpStreamPublishErrorType.rtmpStreamPublishErrorNetDown: 14,
  RtmpStreamPublishErrorType.rtmpStreamPublishErrorInvalidAppid: 15,
  RtmpStreamPublishErrorType.rtmpStreamPublishErrorInvalidPrivilege: 16,
  RtmpStreamPublishErrorType.rtmpStreamUnpublishErrorOk: 100,
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
      'url': instance.url,
      'eventCode': _$RtmpStreamingEventEnumMap[instance.eventCode],
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
          routing: json['routing'] as int?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnAudioRoutingChangedJsonToJson(
        RtcEngineEventHandlerOnAudioRoutingChangedJson instance) =>
    <String, dynamic>{
      'routing': instance.routing,
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
      'state': _$ChannelMediaRelayStateEnumMap[instance.state],
      'code': _$ChannelMediaRelayErrorEnumMap[instance.code],
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

RtcEngineEventHandlerOnChannelMediaRelayEventJson
    _$RtcEngineEventHandlerOnChannelMediaRelayEventJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnChannelMediaRelayEventJson(
          code: $enumDecodeNullable(
              _$ChannelMediaRelayEventEnumMap, json['code']),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnChannelMediaRelayEventJsonToJson(
        RtcEngineEventHandlerOnChannelMediaRelayEventJson instance) =>
    <String, dynamic>{
      'code': _$ChannelMediaRelayEventEnumMap[instance.code],
    };

const _$ChannelMediaRelayEventEnumMap = {
  ChannelMediaRelayEvent.relayEventNetworkDisconnected: 0,
  ChannelMediaRelayEvent.relayEventNetworkConnected: 1,
  ChannelMediaRelayEvent.relayEventPacketJoinedSrcChannel: 2,
  ChannelMediaRelayEvent.relayEventPacketJoinedDestChannel: 3,
  ChannelMediaRelayEvent.relayEventPacketSentToDestChannel: 4,
  ChannelMediaRelayEvent.relayEventPacketReceivedVideoFromSrc: 5,
  ChannelMediaRelayEvent.relayEventPacketReceivedAudioFromSrc: 6,
  ChannelMediaRelayEvent.relayEventPacketUpdateDestChannel: 7,
  ChannelMediaRelayEvent.relayEventPacketUpdateDestChannelRefused: 8,
  ChannelMediaRelayEvent.relayEventPacketUpdateDestChannelNotChange: 9,
  ChannelMediaRelayEvent.relayEventPacketUpdateDestChannelIsNull: 10,
  ChannelMediaRelayEvent.relayEventVideoProfileUpdate: 11,
  ChannelMediaRelayEvent.relayEventPauseSendPacketToDestChannelSuccess: 12,
  ChannelMediaRelayEvent.relayEventPauseSendPacketToDestChannelFailed: 13,
  ChannelMediaRelayEvent.relayEventResumeSendPacketToDestChannelSuccess: 14,
  ChannelMediaRelayEvent.relayEventResumeSendPacketToDestChannelFailed: 15,
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
      'isFallbackOrRecover': instance.isFallbackOrRecover,
    };

RtcEngineEventHandlerOnRemoteSubscribeFallbackToAudioOnlyJson
    _$RtcEngineEventHandlerOnRemoteSubscribeFallbackToAudioOnlyJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnRemoteSubscribeFallbackToAudioOnlyJson(
          uid: json['uid'] as int?,
          isFallbackOrRecover: json['isFallbackOrRecover'] as bool?,
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnRemoteSubscribeFallbackToAudioOnlyJsonToJson(
            RtcEngineEventHandlerOnRemoteSubscribeFallbackToAudioOnlyJson
                instance) =>
        <String, dynamic>{
          'uid': instance.uid,
          'isFallbackOrRecover': instance.isFallbackOrRecover,
        };

RtcEngineEventHandlerOnRemoteAudioTransportStatsJson
    _$RtcEngineEventHandlerOnRemoteAudioTransportStatsJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnRemoteAudioTransportStatsJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          remoteUid: json['remoteUid'] as int?,
          delay: json['delay'] as int?,
          lost: json['lost'] as int?,
          rxKBitRate: json['rxKBitRate'] as int?,
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnRemoteAudioTransportStatsJsonToJson(
            RtcEngineEventHandlerOnRemoteAudioTransportStatsJson instance) =>
        <String, dynamic>{
          'connection': instance.connection?.toJson(),
          'remoteUid': instance.remoteUid,
          'delay': instance.delay,
          'lost': instance.lost,
          'rxKBitRate': instance.rxKBitRate,
        };

RtcEngineEventHandlerOnRemoteVideoTransportStatsJson
    _$RtcEngineEventHandlerOnRemoteVideoTransportStatsJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnRemoteVideoTransportStatsJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          remoteUid: json['remoteUid'] as int?,
          delay: json['delay'] as int?,
          lost: json['lost'] as int?,
          rxKBitRate: json['rxKBitRate'] as int?,
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnRemoteVideoTransportStatsJsonToJson(
            RtcEngineEventHandlerOnRemoteVideoTransportStatsJson instance) =>
        <String, dynamic>{
          'connection': instance.connection?.toJson(),
          'remoteUid': instance.remoteUid,
          'delay': instance.delay,
          'lost': instance.lost,
          'rxKBitRate': instance.rxKBitRate,
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
      'connection': instance.connection?.toJson(),
      'state': _$ConnectionStateTypeEnumMap[instance.state],
      'reason': _$ConnectionChangedReasonTypeEnumMap[instance.reason],
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
  ConnectionChangedReasonType.connectionChangedLicenseVerifyFailed: 21,
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
      'connection': instance.connection?.toJson(),
      'reason': _$WlaccMessageReasonEnumMap[instance.reason],
      'action': _$WlaccSuggestActionEnumMap[instance.action],
      'wlAccMsg': instance.wlAccMsg,
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
      'connection': instance.connection?.toJson(),
      'currentStats': instance.currentStats?.toJson(),
      'averageStats': instance.averageStats?.toJson(),
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
      'connection': instance.connection?.toJson(),
      'type': _$NetworkTypeEnumMap[instance.type],
    };

const _$NetworkTypeEnumMap = {
  NetworkType.networkTypeUnknown: -1,
  NetworkType.networkTypeDisconnected: 0,
  NetworkType.networkTypeLan: 1,
  NetworkType.networkTypeWifi: 2,
  NetworkType.networkTypeMobile2g: 3,
  NetworkType.networkTypeMobile3g: 4,
  NetworkType.networkTypeMobile4g: 5,
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
      'connection': instance.connection?.toJson(),
      'errorType': _$EncryptionErrorTypeEnumMap[instance.errorType],
    };

const _$EncryptionErrorTypeEnumMap = {
  EncryptionErrorType.encryptionErrorInternalFailure: 0,
  EncryptionErrorType.encryptionErrorDecryptionFailure: 1,
  EncryptionErrorType.encryptionErrorEncryptionFailure: 2,
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
      'permissionType': _$PermissionTypeEnumMap[instance.permissionType],
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
          uid: json['uid'] as int?,
          userAccount: json['userAccount'] as String?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnLocalUserRegisteredJsonToJson(
        RtcEngineEventHandlerOnLocalUserRegisteredJson instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'userAccount': instance.userAccount,
    };

RtcEngineEventHandlerOnUserInfoUpdatedJson
    _$RtcEngineEventHandlerOnUserInfoUpdatedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnUserInfoUpdatedJson(
          uid: json['uid'] as int?,
          info: json['info'] == null
              ? null
              : UserInfo.fromJson(json['info'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnUserInfoUpdatedJsonToJson(
        RtcEngineEventHandlerOnUserInfoUpdatedJson instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'info': instance.info?.toJson(),
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
      'connection': instance.connection?.toJson(),
      'requestId': instance.requestId,
      'success': instance.success,
      'reason': _$UploadErrorReasonEnumMap[instance.reason],
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
          uid: json['uid'] as int?,
          oldState: $enumDecodeNullable(
              _$StreamSubscribeStateEnumMap, json['oldState']),
          newState: $enumDecodeNullable(
              _$StreamSubscribeStateEnumMap, json['newState']),
          elapseSinceLastState: json['elapseSinceLastState'] as int?,
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnAudioSubscribeStateChangedJsonToJson(
            RtcEngineEventHandlerOnAudioSubscribeStateChangedJson instance) =>
        <String, dynamic>{
          'channel': instance.channel,
          'uid': instance.uid,
          'oldState': _$StreamSubscribeStateEnumMap[instance.oldState],
          'newState': _$StreamSubscribeStateEnumMap[instance.newState],
          'elapseSinceLastState': instance.elapseSinceLastState,
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
          uid: json['uid'] as int?,
          oldState: $enumDecodeNullable(
              _$StreamSubscribeStateEnumMap, json['oldState']),
          newState: $enumDecodeNullable(
              _$StreamSubscribeStateEnumMap, json['newState']),
          elapseSinceLastState: json['elapseSinceLastState'] as int?,
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnVideoSubscribeStateChangedJsonToJson(
            RtcEngineEventHandlerOnVideoSubscribeStateChangedJson instance) =>
        <String, dynamic>{
          'channel': instance.channel,
          'uid': instance.uid,
          'oldState': _$StreamSubscribeStateEnumMap[instance.oldState],
          'newState': _$StreamSubscribeStateEnumMap[instance.newState],
          'elapseSinceLastState': instance.elapseSinceLastState,
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
          elapseSinceLastState: json['elapseSinceLastState'] as int?,
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnAudioPublishStateChangedJsonToJson(
            RtcEngineEventHandlerOnAudioPublishStateChangedJson instance) =>
        <String, dynamic>{
          'channel': instance.channel,
          'oldState': _$StreamPublishStateEnumMap[instance.oldState],
          'newState': _$StreamPublishStateEnumMap[instance.newState],
          'elapseSinceLastState': instance.elapseSinceLastState,
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
          elapseSinceLastState: json['elapseSinceLastState'] as int?,
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnVideoPublishStateChangedJsonToJson(
            RtcEngineEventHandlerOnVideoPublishStateChangedJson instance) =>
        <String, dynamic>{
          'source': _$VideoSourceTypeEnumMap[instance.source],
          'channel': instance.channel,
          'oldState': _$StreamPublishStateEnumMap[instance.oldState],
          'newState': _$StreamPublishStateEnumMap[instance.newState],
          'elapseSinceLastState': instance.elapseSinceLastState,
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
      'provider': instance.provider,
      'extension': instance.extension,
      'key': instance.key,
      'value': instance.value,
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
      'provider': instance.provider,
      'extension': instance.extension,
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
      'provider': instance.provider,
      'extension': instance.extension,
    };

RtcEngineEventHandlerOnExtensionErrorJson
    _$RtcEngineEventHandlerOnExtensionErrorJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnExtensionErrorJson(
          provider: json['provider'] as String?,
          extension: json['extension'] as String?,
          error: json['error'] as int?,
          message: json['message'] as String?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnExtensionErrorJsonToJson(
        RtcEngineEventHandlerOnExtensionErrorJson instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'extension': instance.extension,
      'error': instance.error,
      'message': instance.message,
    };

RtcEngineEventHandlerOnUserAccountUpdatedJson
    _$RtcEngineEventHandlerOnUserAccountUpdatedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnUserAccountUpdatedJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          remoteUid: json['remoteUid'] as int?,
          userAccount: json['userAccount'] as String?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnUserAccountUpdatedJsonToJson(
        RtcEngineEventHandlerOnUserAccountUpdatedJson instance) =>
    <String, dynamic>{
      'connection': instance.connection?.toJson(),
      'remoteUid': instance.remoteUid,
      'userAccount': instance.userAccount,
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
      'metadata': instance.metadata?.toJson(),
    };

DirectCdnStreamingEventHandlerOnDirectCdnStreamingStateChangedJson
    _$DirectCdnStreamingEventHandlerOnDirectCdnStreamingStateChangedJsonFromJson(
            Map<String, dynamic> json) =>
        DirectCdnStreamingEventHandlerOnDirectCdnStreamingStateChangedJson(
          state: $enumDecodeNullable(
              _$DirectCdnStreamingStateEnumMap, json['state']),
          error: $enumDecodeNullable(
              _$DirectCdnStreamingErrorEnumMap, json['error']),
          message: json['message'] as String?,
        );

Map<String, dynamic>
    _$DirectCdnStreamingEventHandlerOnDirectCdnStreamingStateChangedJsonToJson(
            DirectCdnStreamingEventHandlerOnDirectCdnStreamingStateChangedJson
                instance) =>
        <String, dynamic>{
          'state': _$DirectCdnStreamingStateEnumMap[instance.state],
          'error': _$DirectCdnStreamingErrorEnumMap[instance.error],
          'message': instance.message,
        };

const _$DirectCdnStreamingStateEnumMap = {
  DirectCdnStreamingState.directCdnStreamingStateIdle: 0,
  DirectCdnStreamingState.directCdnStreamingStateRunning: 1,
  DirectCdnStreamingState.directCdnStreamingStateStopped: 2,
  DirectCdnStreamingState.directCdnStreamingStateFailed: 3,
  DirectCdnStreamingState.directCdnStreamingStateRecovering: 4,
};

const _$DirectCdnStreamingErrorEnumMap = {
  DirectCdnStreamingError.directCdnStreamingErrorOk: 0,
  DirectCdnStreamingError.directCdnStreamingErrorFailed: 1,
  DirectCdnStreamingError.directCdnStreamingErrorAudioPublication: 2,
  DirectCdnStreamingError.directCdnStreamingErrorVideoPublication: 3,
  DirectCdnStreamingError.directCdnStreamingErrorNetConnect: 4,
  DirectCdnStreamingError.directCdnStreamingErrorBadName: 5,
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
          'stats': instance.stats?.toJson(),
        };

AudioEncodedFrameObserverOnRecordAudioEncodedFrameJson
    _$AudioEncodedFrameObserverOnRecordAudioEncodedFrameJsonFromJson(
            Map<String, dynamic> json) =>
        AudioEncodedFrameObserverOnRecordAudioEncodedFrameJson(
          length: json['length'] as int?,
          audioEncodedFrameInfo: json['audioEncodedFrameInfo'] == null
              ? null
              : EncodedAudioFrameInfo.fromJson(
                  json['audioEncodedFrameInfo'] as Map<String, dynamic>),
        );

Map<String, dynamic>
    _$AudioEncodedFrameObserverOnRecordAudioEncodedFrameJsonToJson(
            AudioEncodedFrameObserverOnRecordAudioEncodedFrameJson instance) =>
        <String, dynamic>{
          'length': instance.length,
          'audioEncodedFrameInfo': instance.audioEncodedFrameInfo?.toJson(),
        };

AudioEncodedFrameObserverOnPlaybackAudioEncodedFrameJson
    _$AudioEncodedFrameObserverOnPlaybackAudioEncodedFrameJsonFromJson(
            Map<String, dynamic> json) =>
        AudioEncodedFrameObserverOnPlaybackAudioEncodedFrameJson(
          length: json['length'] as int?,
          audioEncodedFrameInfo: json['audioEncodedFrameInfo'] == null
              ? null
              : EncodedAudioFrameInfo.fromJson(
                  json['audioEncodedFrameInfo'] as Map<String, dynamic>),
        );

Map<String,
    dynamic> _$AudioEncodedFrameObserverOnPlaybackAudioEncodedFrameJsonToJson(
        AudioEncodedFrameObserverOnPlaybackAudioEncodedFrameJson instance) =>
    <String, dynamic>{
      'length': instance.length,
      'audioEncodedFrameInfo': instance.audioEncodedFrameInfo?.toJson(),
    };

AudioEncodedFrameObserverOnMixedAudioEncodedFrameJson
    _$AudioEncodedFrameObserverOnMixedAudioEncodedFrameJsonFromJson(
            Map<String, dynamic> json) =>
        AudioEncodedFrameObserverOnMixedAudioEncodedFrameJson(
          length: json['length'] as int?,
          audioEncodedFrameInfo: json['audioEncodedFrameInfo'] == null
              ? null
              : EncodedAudioFrameInfo.fromJson(
                  json['audioEncodedFrameInfo'] as Map<String, dynamic>),
        );

Map<String, dynamic>
    _$AudioEncodedFrameObserverOnMixedAudioEncodedFrameJsonToJson(
            AudioEncodedFrameObserverOnMixedAudioEncodedFrameJson instance) =>
        <String, dynamic>{
          'length': instance.length,
          'audioEncodedFrameInfo': instance.audioEncodedFrameInfo?.toJson(),
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
      'channelId': instance.channelId,
      'audioFrame': instance.audioFrame?.toJson(),
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
      'channelId': instance.channelId,
      'audioFrame': instance.audioFrame?.toJson(),
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
      'channelId': instance.channelId,
      'audioFrame': instance.audioFrame?.toJson(),
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
          'audioFrame': instance.audioFrame?.toJson(),
        };

AudioFrameObserverOnPlaybackAudioFrameBeforeMixingJson
    _$AudioFrameObserverOnPlaybackAudioFrameBeforeMixingJsonFromJson(
            Map<String, dynamic> json) =>
        AudioFrameObserverOnPlaybackAudioFrameBeforeMixingJson(
          channelId: json['channelId'] as String?,
          uid: json['uid'] as int?,
          audioFrame: json['audioFrame'] == null
              ? null
              : AudioFrame.fromJson(json['audioFrame'] as Map<String, dynamic>),
        );

Map<String, dynamic>
    _$AudioFrameObserverOnPlaybackAudioFrameBeforeMixingJsonToJson(
            AudioFrameObserverOnPlaybackAudioFrameBeforeMixingJson instance) =>
        <String, dynamic>{
          'channelId': instance.channelId,
          'uid': instance.uid,
          'audioFrame': instance.audioFrame?.toJson(),
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
      'data': instance.data?.toJson(),
    };

AudioSpectrumObserverOnRemoteAudioSpectrumJson
    _$AudioSpectrumObserverOnRemoteAudioSpectrumJsonFromJson(
            Map<String, dynamic> json) =>
        AudioSpectrumObserverOnRemoteAudioSpectrumJson(
          spectrums: (json['spectrums'] as List<dynamic>?)
              ?.map((e) =>
                  UserAudioSpectrumInfo.fromJson(e as Map<String, dynamic>))
              .toList(),
          spectrumNumber: json['spectrumNumber'] as int?,
        );

Map<String, dynamic> _$AudioSpectrumObserverOnRemoteAudioSpectrumJsonToJson(
        AudioSpectrumObserverOnRemoteAudioSpectrumJson instance) =>
    <String, dynamic>{
      'spectrums': instance.spectrums?.map((e) => e.toJson()).toList(),
      'spectrumNumber': instance.spectrumNumber,
    };

VideoEncodedFrameObserverOnEncodedVideoFrameReceivedJson
    _$VideoEncodedFrameObserverOnEncodedVideoFrameReceivedJsonFromJson(
            Map<String, dynamic> json) =>
        VideoEncodedFrameObserverOnEncodedVideoFrameReceivedJson(
          uid: json['uid'] as int?,
          length: json['length'] as int?,
          videoEncodedFrameInfo: json['videoEncodedFrameInfo'] == null
              ? null
              : EncodedVideoFrameInfo.fromJson(
                  json['videoEncodedFrameInfo'] as Map<String, dynamic>),
        );

Map<String,
    dynamic> _$VideoEncodedFrameObserverOnEncodedVideoFrameReceivedJsonToJson(
        VideoEncodedFrameObserverOnEncodedVideoFrameReceivedJson instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'length': instance.length,
      'videoEncodedFrameInfo': instance.videoEncodedFrameInfo?.toJson(),
    };

VideoFrameObserverOnCaptureVideoFrameJson
    _$VideoFrameObserverOnCaptureVideoFrameJsonFromJson(
            Map<String, dynamic> json) =>
        VideoFrameObserverOnCaptureVideoFrameJson(
          videoFrame: json['videoFrame'] == null
              ? null
              : VideoFrame.fromJson(json['videoFrame'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$VideoFrameObserverOnCaptureVideoFrameJsonToJson(
        VideoFrameObserverOnCaptureVideoFrameJson instance) =>
    <String, dynamic>{
      'videoFrame': instance.videoFrame?.toJson(),
    };

VideoFrameObserverOnPreEncodeVideoFrameJson
    _$VideoFrameObserverOnPreEncodeVideoFrameJsonFromJson(
            Map<String, dynamic> json) =>
        VideoFrameObserverOnPreEncodeVideoFrameJson(
          videoFrame: json['videoFrame'] == null
              ? null
              : VideoFrame.fromJson(json['videoFrame'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$VideoFrameObserverOnPreEncodeVideoFrameJsonToJson(
        VideoFrameObserverOnPreEncodeVideoFrameJson instance) =>
    <String, dynamic>{
      'videoFrame': instance.videoFrame?.toJson(),
    };

VideoFrameObserverOnSecondaryCameraCaptureVideoFrameJson
    _$VideoFrameObserverOnSecondaryCameraCaptureVideoFrameJsonFromJson(
            Map<String, dynamic> json) =>
        VideoFrameObserverOnSecondaryCameraCaptureVideoFrameJson(
          videoFrame: json['videoFrame'] == null
              ? null
              : VideoFrame.fromJson(json['videoFrame'] as Map<String, dynamic>),
        );

Map<String,
    dynamic> _$VideoFrameObserverOnSecondaryCameraCaptureVideoFrameJsonToJson(
        VideoFrameObserverOnSecondaryCameraCaptureVideoFrameJson instance) =>
    <String, dynamic>{
      'videoFrame': instance.videoFrame?.toJson(),
    };

VideoFrameObserverOnSecondaryPreEncodeCameraVideoFrameJson
    _$VideoFrameObserverOnSecondaryPreEncodeCameraVideoFrameJsonFromJson(
            Map<String, dynamic> json) =>
        VideoFrameObserverOnSecondaryPreEncodeCameraVideoFrameJson(
          videoFrame: json['videoFrame'] == null
              ? null
              : VideoFrame.fromJson(json['videoFrame'] as Map<String, dynamic>),
        );

Map<String,
    dynamic> _$VideoFrameObserverOnSecondaryPreEncodeCameraVideoFrameJsonToJson(
        VideoFrameObserverOnSecondaryPreEncodeCameraVideoFrameJson instance) =>
    <String, dynamic>{
      'videoFrame': instance.videoFrame?.toJson(),
    };

VideoFrameObserverOnScreenCaptureVideoFrameJson
    _$VideoFrameObserverOnScreenCaptureVideoFrameJsonFromJson(
            Map<String, dynamic> json) =>
        VideoFrameObserverOnScreenCaptureVideoFrameJson(
          videoFrame: json['videoFrame'] == null
              ? null
              : VideoFrame.fromJson(json['videoFrame'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$VideoFrameObserverOnScreenCaptureVideoFrameJsonToJson(
        VideoFrameObserverOnScreenCaptureVideoFrameJson instance) =>
    <String, dynamic>{
      'videoFrame': instance.videoFrame?.toJson(),
    };

VideoFrameObserverOnPreEncodeScreenVideoFrameJson
    _$VideoFrameObserverOnPreEncodeScreenVideoFrameJsonFromJson(
            Map<String, dynamic> json) =>
        VideoFrameObserverOnPreEncodeScreenVideoFrameJson(
          videoFrame: json['videoFrame'] == null
              ? null
              : VideoFrame.fromJson(json['videoFrame'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$VideoFrameObserverOnPreEncodeScreenVideoFrameJsonToJson(
        VideoFrameObserverOnPreEncodeScreenVideoFrameJson instance) =>
    <String, dynamic>{
      'videoFrame': instance.videoFrame?.toJson(),
    };

VideoFrameObserverOnMediaPlayerVideoFrameJson
    _$VideoFrameObserverOnMediaPlayerVideoFrameJsonFromJson(
            Map<String, dynamic> json) =>
        VideoFrameObserverOnMediaPlayerVideoFrameJson(
          videoFrame: json['videoFrame'] == null
              ? null
              : VideoFrame.fromJson(json['videoFrame'] as Map<String, dynamic>),
          mediaPlayerId: json['mediaPlayerId'] as int?,
        );

Map<String, dynamic> _$VideoFrameObserverOnMediaPlayerVideoFrameJsonToJson(
        VideoFrameObserverOnMediaPlayerVideoFrameJson instance) =>
    <String, dynamic>{
      'videoFrame': instance.videoFrame?.toJson(),
      'mediaPlayerId': instance.mediaPlayerId,
    };

VideoFrameObserverOnSecondaryScreenCaptureVideoFrameJson
    _$VideoFrameObserverOnSecondaryScreenCaptureVideoFrameJsonFromJson(
            Map<String, dynamic> json) =>
        VideoFrameObserverOnSecondaryScreenCaptureVideoFrameJson(
          videoFrame: json['videoFrame'] == null
              ? null
              : VideoFrame.fromJson(json['videoFrame'] as Map<String, dynamic>),
        );

Map<String,
    dynamic> _$VideoFrameObserverOnSecondaryScreenCaptureVideoFrameJsonToJson(
        VideoFrameObserverOnSecondaryScreenCaptureVideoFrameJson instance) =>
    <String, dynamic>{
      'videoFrame': instance.videoFrame?.toJson(),
    };

VideoFrameObserverOnSecondaryPreEncodeScreenVideoFrameJson
    _$VideoFrameObserverOnSecondaryPreEncodeScreenVideoFrameJsonFromJson(
            Map<String, dynamic> json) =>
        VideoFrameObserverOnSecondaryPreEncodeScreenVideoFrameJson(
          videoFrame: json['videoFrame'] == null
              ? null
              : VideoFrame.fromJson(json['videoFrame'] as Map<String, dynamic>),
        );

Map<String,
    dynamic> _$VideoFrameObserverOnSecondaryPreEncodeScreenVideoFrameJsonToJson(
        VideoFrameObserverOnSecondaryPreEncodeScreenVideoFrameJson instance) =>
    <String, dynamic>{
      'videoFrame': instance.videoFrame?.toJson(),
    };

VideoFrameObserverOnRenderVideoFrameJson
    _$VideoFrameObserverOnRenderVideoFrameJsonFromJson(
            Map<String, dynamic> json) =>
        VideoFrameObserverOnRenderVideoFrameJson(
          channelId: json['channelId'] as String?,
          remoteUid: json['remoteUid'] as int?,
          videoFrame: json['videoFrame'] == null
              ? null
              : VideoFrame.fromJson(json['videoFrame'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$VideoFrameObserverOnRenderVideoFrameJsonToJson(
        VideoFrameObserverOnRenderVideoFrameJson instance) =>
    <String, dynamic>{
      'channelId': instance.channelId,
      'remoteUid': instance.remoteUid,
      'videoFrame': instance.videoFrame?.toJson(),
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
      'videoFrame': instance.videoFrame?.toJson(),
    };

MediaRecorderObserverOnRecorderStateChangedJson
    _$MediaRecorderObserverOnRecorderStateChangedJsonFromJson(
            Map<String, dynamic> json) =>
        MediaRecorderObserverOnRecorderStateChangedJson(
          state: $enumDecodeNullable(_$RecorderStateEnumMap, json['state']),
          error: $enumDecodeNullable(_$RecorderErrorCodeEnumMap, json['error']),
        );

Map<String, dynamic> _$MediaRecorderObserverOnRecorderStateChangedJsonToJson(
        MediaRecorderObserverOnRecorderStateChangedJson instance) =>
    <String, dynamic>{
      'state': _$RecorderStateEnumMap[instance.state],
      'error': _$RecorderErrorCodeEnumMap[instance.error],
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

MediaRecorderObserverOnRecorderInfoUpdatedJson
    _$MediaRecorderObserverOnRecorderInfoUpdatedJsonFromJson(
            Map<String, dynamic> json) =>
        MediaRecorderObserverOnRecorderInfoUpdatedJson(
          info: json['info'] == null
              ? null
              : RecorderInfo.fromJson(json['info'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$MediaRecorderObserverOnRecorderInfoUpdatedJsonToJson(
        MediaRecorderObserverOnRecorderInfoUpdatedJson instance) =>
    <String, dynamic>{
      'info': instance.info?.toJson(),
    };

MediaPlayerAudioFrameObserverOnFrameJson
    _$MediaPlayerAudioFrameObserverOnFrameJsonFromJson(
            Map<String, dynamic> json) =>
        MediaPlayerAudioFrameObserverOnFrameJson(
          frame: json['frame'] == null
              ? null
              : AudioPcmFrame.fromJson(json['frame'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$MediaPlayerAudioFrameObserverOnFrameJsonToJson(
        MediaPlayerAudioFrameObserverOnFrameJson instance) =>
    <String, dynamic>{
      'frame': instance.frame?.toJson(),
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
      'frame': instance.frame?.toJson(),
    };

MediaPlayerSourceObserverOnPlayerSourceStateChangedJson
    _$MediaPlayerSourceObserverOnPlayerSourceStateChangedJsonFromJson(
            Map<String, dynamic> json) =>
        MediaPlayerSourceObserverOnPlayerSourceStateChangedJson(
          state: $enumDecodeNullable(_$MediaPlayerStateEnumMap, json['state']),
          ec: $enumDecodeNullable(_$MediaPlayerErrorEnumMap, json['ec']),
        );

Map<String, dynamic>
    _$MediaPlayerSourceObserverOnPlayerSourceStateChangedJsonToJson(
            MediaPlayerSourceObserverOnPlayerSourceStateChangedJson instance) =>
        <String, dynamic>{
          'state': _$MediaPlayerStateEnumMap[instance.state],
          'ec': _$MediaPlayerErrorEnumMap[instance.ec],
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

const _$MediaPlayerErrorEnumMap = {
  MediaPlayerError.playerErrorNone: 0,
  MediaPlayerError.playerErrorInvalidArguments: -1,
  MediaPlayerError.playerErrorInternal: -2,
  MediaPlayerError.playerErrorNoResource: -3,
  MediaPlayerError.playerErrorInvalidMediaSource: -4,
  MediaPlayerError.playerErrorUnknownStreamType: -5,
  MediaPlayerError.playerErrorObjNotInitialized: -6,
  MediaPlayerError.playerErrorCodecNotSupported: -7,
  MediaPlayerError.playerErrorVideoRenderFailed: -8,
  MediaPlayerError.playerErrorInvalidState: -9,
  MediaPlayerError.playerErrorUrlNotFound: -10,
  MediaPlayerError.playerErrorInvalidConnectionState: -11,
  MediaPlayerError.playerErrorSrcBufferUnderflow: -12,
  MediaPlayerError.playerErrorInterrupted: -13,
  MediaPlayerError.playerErrorNotSupported: -14,
  MediaPlayerError.playerErrorTokenExpired: -15,
  MediaPlayerError.playerErrorIpExpired: -16,
  MediaPlayerError.playerErrorUnknown: -17,
};

MediaPlayerSourceObserverOnPositionChangedJson
    _$MediaPlayerSourceObserverOnPositionChangedJsonFromJson(
            Map<String, dynamic> json) =>
        MediaPlayerSourceObserverOnPositionChangedJson(
          positionMs: json['position_ms'] as int?,
        );

Map<String, dynamic> _$MediaPlayerSourceObserverOnPositionChangedJsonToJson(
        MediaPlayerSourceObserverOnPositionChangedJson instance) =>
    <String, dynamic>{
      'position_ms': instance.positionMs,
    };

MediaPlayerSourceObserverOnPlayerEventJson
    _$MediaPlayerSourceObserverOnPlayerEventJsonFromJson(
            Map<String, dynamic> json) =>
        MediaPlayerSourceObserverOnPlayerEventJson(
          eventCode:
              $enumDecodeNullable(_$MediaPlayerEventEnumMap, json['eventCode']),
          elapsedTime: json['elapsedTime'] as int?,
          message: json['message'] as String?,
        );

Map<String, dynamic> _$MediaPlayerSourceObserverOnPlayerEventJsonToJson(
        MediaPlayerSourceObserverOnPlayerEventJson instance) =>
    <String, dynamic>{
      'eventCode': _$MediaPlayerEventEnumMap[instance.eventCode],
      'elapsedTime': instance.elapsedTime,
      'message': instance.message,
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
          length: json['length'] as int?,
        );

Map<String, dynamic> _$MediaPlayerSourceObserverOnMetaDataJsonToJson(
        MediaPlayerSourceObserverOnMetaDataJson instance) =>
    <String, dynamic>{
      'length': instance.length,
    };

MediaPlayerSourceObserverOnPlayBufferUpdatedJson
    _$MediaPlayerSourceObserverOnPlayBufferUpdatedJsonFromJson(
            Map<String, dynamic> json) =>
        MediaPlayerSourceObserverOnPlayBufferUpdatedJson(
          playCachedBuffer: json['playCachedBuffer'] as int?,
        );

Map<String, dynamic> _$MediaPlayerSourceObserverOnPlayBufferUpdatedJsonToJson(
        MediaPlayerSourceObserverOnPlayBufferUpdatedJson instance) =>
    <String, dynamic>{
      'playCachedBuffer': instance.playCachedBuffer,
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
      'src': instance.src,
      'event': _$PlayerPreloadEventEnumMap[instance.event],
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
          'from': instance.from?.toJson(),
          'to': instance.to?.toJson(),
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
      'info': instance.info?.toJson(),
    };

MediaPlayerSourceObserverOnAudioVolumeIndicationJson
    _$MediaPlayerSourceObserverOnAudioVolumeIndicationJsonFromJson(
            Map<String, dynamic> json) =>
        MediaPlayerSourceObserverOnAudioVolumeIndicationJson(
          volume: json['volume'] as int?,
        );

Map<String, dynamic>
    _$MediaPlayerSourceObserverOnAudioVolumeIndicationJsonToJson(
            MediaPlayerSourceObserverOnAudioVolumeIndicationJson instance) =>
        <String, dynamic>{
          'volume': instance.volume,
        };

MusicContentCenterEventHandlerOnMusicChartsResultJson
    _$MusicContentCenterEventHandlerOnMusicChartsResultJsonFromJson(
            Map<String, dynamic> json) =>
        MusicContentCenterEventHandlerOnMusicChartsResultJson(
          requestId: json['requestId'] as String?,
          status: $enumDecodeNullable(
              _$MusicContentCenterStatusCodeEnumMap, json['status']),
          result: (json['result'] as List<dynamic>?)
              ?.map((e) => MusicChartInfo.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic>
    _$MusicContentCenterEventHandlerOnMusicChartsResultJsonToJson(
            MusicContentCenterEventHandlerOnMusicChartsResultJson instance) =>
        <String, dynamic>{
          'requestId': instance.requestId,
          'status': _$MusicContentCenterStatusCodeEnumMap[instance.status],
          'result': instance.result?.map((e) => e.toJson()).toList(),
        };

const _$MusicContentCenterStatusCodeEnumMap = {
  MusicContentCenterStatusCode.kMusicContentCenterStatusOk: 0,
  MusicContentCenterStatusCode.kMusicContentCenterStatusErr: 1,
};

MusicContentCenterEventHandlerOnMusicCollectionResultJson
    _$MusicContentCenterEventHandlerOnMusicCollectionResultJsonFromJson(
            Map<String, dynamic> json) =>
        MusicContentCenterEventHandlerOnMusicCollectionResultJson(
          requestId: json['requestId'] as String?,
          status: $enumDecodeNullable(
              _$MusicContentCenterStatusCodeEnumMap, json['status']),
        );

Map<String,
    dynamic> _$MusicContentCenterEventHandlerOnMusicCollectionResultJsonToJson(
        MusicContentCenterEventHandlerOnMusicCollectionResultJson instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      'status': _$MusicContentCenterStatusCodeEnumMap[instance.status],
    };

MusicContentCenterEventHandlerOnLyricResultJson
    _$MusicContentCenterEventHandlerOnLyricResultJsonFromJson(
            Map<String, dynamic> json) =>
        MusicContentCenterEventHandlerOnLyricResultJson(
          requestId: json['requestId'] as String?,
          lyricUrl: json['lyricUrl'] as String?,
        );

Map<String, dynamic> _$MusicContentCenterEventHandlerOnLyricResultJsonToJson(
        MusicContentCenterEventHandlerOnLyricResultJson instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      'lyricUrl': instance.lyricUrl,
    };

MusicContentCenterEventHandlerOnPreLoadEventJson
    _$MusicContentCenterEventHandlerOnPreLoadEventJsonFromJson(
            Map<String, dynamic> json) =>
        MusicContentCenterEventHandlerOnPreLoadEventJson(
          songCode: json['songCode'] as int?,
          percent: json['percent'] as int?,
          status:
              $enumDecodeNullable(_$PreloadStatusCodeEnumMap, json['status']),
          msg: json['msg'] as String?,
          lyricUrl: json['lyricUrl'] as String?,
        );

Map<String, dynamic> _$MusicContentCenterEventHandlerOnPreLoadEventJsonToJson(
        MusicContentCenterEventHandlerOnPreLoadEventJson instance) =>
    <String, dynamic>{
      'songCode': instance.songCode,
      'percent': instance.percent,
      'status': _$PreloadStatusCodeEnumMap[instance.status],
      'msg': instance.msg,
      'lyricUrl': instance.lyricUrl,
    };

const _$PreloadStatusCodeEnumMap = {
  PreloadStatusCode.kPreloadStatusCompleted: 0,
  PreloadStatusCode.kPreloadStatusFailed: 1,
  PreloadStatusCode.kPreloadStatusPreloading: 2,
};
