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

RtcEngineEventHandlerOnWarningJson _$RtcEngineEventHandlerOnWarningJsonFromJson(
        Map<String, dynamic> json) =>
    RtcEngineEventHandlerOnWarningJson(
      warn: $enumDecodeNullable(_$WarnCodeTypeEnumMap, json['warn']),
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$RtcEngineEventHandlerOnWarningJsonToJson(
        RtcEngineEventHandlerOnWarningJson instance) =>
    <String, dynamic>{
      'warn': _$WarnCodeTypeEnumMap[instance.warn],
      'msg': instance.msg,
    };

const _$WarnCodeTypeEnumMap = {
  WarnCodeType.warnInvalidView: 8,
  WarnCodeType.warnInitVideo: 16,
  WarnCodeType.warnPending: 20,
  WarnCodeType.warnNoAvailableChannel: 103,
  WarnCodeType.warnLookupChannelTimeout: 104,
  WarnCodeType.warnLookupChannelRejected: 105,
  WarnCodeType.warnOpenChannelTimeout: 106,
  WarnCodeType.warnOpenChannelRejected: 107,
  WarnCodeType.warnSwitchLiveVideoTimeout: 111,
  WarnCodeType.warnSetClientRoleTimeout: 118,
  WarnCodeType.warnOpenChannelInvalidTicket: 121,
  WarnCodeType.warnOpenChannelTryNextVos: 122,
  WarnCodeType.warnChannelConnectionUnrecoverable: 131,
  WarnCodeType.warnChannelConnectionIpChanged: 132,
  WarnCodeType.warnChannelConnectionPortChanged: 133,
  WarnCodeType.warnChannelSocketError: 134,
  WarnCodeType.warnAudioMixingOpenError: 701,
  WarnCodeType.warnAdmRuntimePlayoutWarning: 1014,
  WarnCodeType.warnAdmRuntimeRecordingWarning: 1016,
  WarnCodeType.warnAdmRecordAudioSilence: 1019,
  WarnCodeType.warnAdmPlayoutMalfunction: 1020,
  WarnCodeType.warnAdmRecordMalfunction: 1021,
  WarnCodeType.warnAdmIosCategoryNotPlayandrecord: 1029,
  WarnCodeType.warnAdmIosSamplerateChange: 1030,
  WarnCodeType.warnAdmRecordAudioLowlevel: 1031,
  WarnCodeType.warnAdmPlayoutAudioLowlevel: 1032,
  WarnCodeType.warnAdmWindowsNoDataReadyEvent: 1040,
  WarnCodeType.warnApmHowling: 1051,
  WarnCodeType.warnAdmGlitchState: 1052,
  WarnCodeType.warnAdmImproperSettings: 1053,
  WarnCodeType.warnAdmWinCoreNoRecordingDevice: 1322,
  WarnCodeType.warnAdmWinCoreNoPlayoutDevice: 1323,
  WarnCodeType.warnAdmWinCoreImproperCaptureRelease: 1324,
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
  ErrorCodeType.errNetNobufs: 15,
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
  ErrorCodeType.errWatermarkParam: 124,
  ErrorCodeType.errWatermarkPath: 125,
  ErrorCodeType.errWatermarkPng: 126,
  ErrorCodeType.errWatermarkrInfo: 127,
  ErrorCodeType.errWatermarkArgb: 128,
  ErrorCodeType.errWatermarkRead: 129,
  ErrorCodeType.errEncryptedStreamNotAllowedPublish: 130,
  ErrorCodeType.errLicenseCredentialInvalid: 131,
  ErrorCodeType.errInvalidUserAccount: 134,
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
  ErrorCodeType.errLogoutOther: 400,
  ErrorCodeType.errLogoutUser: 401,
  ErrorCodeType.errLogoutNet: 402,
  ErrorCodeType.errLogoutKicked: 403,
  ErrorCodeType.errLogoutPacket: 404,
  ErrorCodeType.errLogoutTokenExpired: 405,
  ErrorCodeType.errLogoutOldversion: 406,
  ErrorCodeType.errLogoutTokenWrong: 407,
  ErrorCodeType.errLogoutAlreadyLogout: 408,
  ErrorCodeType.errLoginOther: 420,
  ErrorCodeType.errLoginNet: 421,
  ErrorCodeType.errLoginFailed: 422,
  ErrorCodeType.errLoginCanceled: 423,
  ErrorCodeType.errLoginTokenExpired: 424,
  ErrorCodeType.errLoginOldVersion: 425,
  ErrorCodeType.errLoginTokenWrong: 426,
  ErrorCodeType.errLoginTokenKicked: 427,
  ErrorCodeType.errLoginAlreadyLogin: 428,
  ErrorCodeType.errJoinChannelOther: 440,
  ErrorCodeType.errSendMessageOther: 440,
  ErrorCodeType.errSendMessageTimeout: 441,
  ErrorCodeType.errQueryUsernumOther: 450,
  ErrorCodeType.errQueryUsernumTimeout: 451,
  ErrorCodeType.errQueryUsernumByuser: 452,
  ErrorCodeType.errLeaveChannelOther: 460,
  ErrorCodeType.errLeaveChannelKicked: 461,
  ErrorCodeType.errLeaveChannelByuser: 462,
  ErrorCodeType.errLeaveChannelLogout: 463,
  ErrorCodeType.errLeaveChannelDisconnected: 464,
  ErrorCodeType.errInviteOther: 470,
  ErrorCodeType.errInviteReinvite: 471,
  ErrorCodeType.errInviteNet: 472,
  ErrorCodeType.errInvitePeerOffline: 473,
  ErrorCodeType.errInviteTimeout: 474,
  ErrorCodeType.errInviteCantRecv: 475,
  ErrorCodeType.errLoadMediaEngine: 1001,
  ErrorCodeType.errStartCall: 1002,
  ErrorCodeType.errStartCamera: 1003,
  ErrorCodeType.errStartVideoRender: 1004,
  ErrorCodeType.errAdmGeneralError: 1005,
  ErrorCodeType.errAdmJavaResource: 1006,
  ErrorCodeType.errAdmSampleRate: 1007,
  ErrorCodeType.errAdmInitPlayout: 1008,
  ErrorCodeType.errAdmStartPlayout: 1009,
  ErrorCodeType.errAdmStopPlayout: 1010,
  ErrorCodeType.errAdmInitRecording: 1011,
  ErrorCodeType.errAdmStartRecording: 1012,
  ErrorCodeType.errAdmStopRecording: 1013,
  ErrorCodeType.errAdmRuntimePlayoutError: 1015,
  ErrorCodeType.errAdmRuntimeRecordingError: 1017,
  ErrorCodeType.errAdmRecordAudioFailed: 1018,
  ErrorCodeType.errAdmInitLoopback: 1022,
  ErrorCodeType.errAdmStartLoopback: 1023,
  ErrorCodeType.errAdmNoPermission: 1027,
  ErrorCodeType.errAdmRecordAudioIsActive: 1033,
  ErrorCodeType.errAdmAndroidJniJavaResource: 1101,
  ErrorCodeType.errAdmAndroidJniNoRecordFrequency: 1108,
  ErrorCodeType.errAdmAndroidJniNoPlaybackFrequency: 1109,
  ErrorCodeType.errAdmAndroidJniJavaStartRecord: 1111,
  ErrorCodeType.errAdmAndroidJniJavaStartPlayback: 1112,
  ErrorCodeType.errAdmAndroidJniJavaRecordError: 1115,
  ErrorCodeType.errAdmAndroidOpenslCreateEngine: 1151,
  ErrorCodeType.errAdmAndroidOpenslCreateAudioRecorder: 1153,
  ErrorCodeType.errAdmAndroidOpenslStartRecorderThread: 1156,
  ErrorCodeType.errAdmAndroidOpenslCreateAudioPlayer: 1157,
  ErrorCodeType.errAdmAndroidOpenslStartPlayerThread: 1160,
  ErrorCodeType.errAdmIosInputNotAvailable: 1201,
  ErrorCodeType.errAdmIosActivateSessionFail: 1206,
  ErrorCodeType.errAdmIosVpioInitFail: 1210,
  ErrorCodeType.errAdmIosVpioReinitFail: 1213,
  ErrorCodeType.errAdmIosVpioRestartFail: 1214,
  ErrorCodeType.errAdmIosSetRenderCallbackFail: 1219,
  ErrorCodeType.errAdmIosSessionSampleratrZero: 1221,
  ErrorCodeType.errAdmWinCoreInit: 1301,
  ErrorCodeType.errAdmWinCoreInitRecording: 1303,
  ErrorCodeType.errAdmWinCoreInitPlayout: 1306,
  ErrorCodeType.errAdmWinCoreInitPlayoutNull: 1307,
  ErrorCodeType.errAdmWinCoreStartRecording: 1309,
  ErrorCodeType.errAdmWinCoreCreateRecThread: 1311,
  ErrorCodeType.errAdmWinCoreCaptureNotStartup: 1314,
  ErrorCodeType.errAdmWinCoreCreateRenderThread: 1319,
  ErrorCodeType.errAdmWinCoreRenderNotStartup: 1320,
  ErrorCodeType.errAdmWinCoreNoRecordingDevice: 1322,
  ErrorCodeType.errAdmWinCoreNoPlayoutDevice: 1323,
  ErrorCodeType.errAdmWinWaveInit: 1351,
  ErrorCodeType.errAdmWinWaveInitRecording: 1353,
  ErrorCodeType.errAdmWinWaveInitMicrophone: 1354,
  ErrorCodeType.errAdmWinWaveInitPlayout: 1355,
  ErrorCodeType.errAdmWinWaveInitSpeaker: 1356,
  ErrorCodeType.errAdmWinWaveStartRecording: 1357,
  ErrorCodeType.errAdmWinWaveStartPlayout: 1358,
  ErrorCodeType.errAdmNoRecordingDevice: 1359,
  ErrorCodeType.errAdmNoPlayoutDevice: 1360,
  ErrorCodeType.errVdmCameraNotAuthorized: 1501,
  ErrorCodeType.errVdmWinDeviceInUse: 1502,
  ErrorCodeType.errVcmUnknownError: 1600,
  ErrorCodeType.errVcmEncoderInitError: 1601,
  ErrorCodeType.errVcmEncoderEncodeError: 1602,
  ErrorCodeType.errVcmEncoderSetError: 1603,
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

RtcEngineEventHandlerOnMediaDeviceChangedJson
    _$RtcEngineEventHandlerOnMediaDeviceChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnMediaDeviceChangedJson(
          deviceType:
              $enumDecodeNullable(_$MediaDeviceTypeEnumMap, json['deviceType']),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnMediaDeviceChangedJsonToJson(
        RtcEngineEventHandlerOnMediaDeviceChangedJson instance) =>
    <String, dynamic>{
      'deviceType': _$MediaDeviceTypeEnumMap[instance.deviceType],
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
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          width: json['width'] as int?,
          height: json['height'] as int?,
          elapsed: json['elapsed'] as int?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnFirstLocalVideoFrameJsonToJson(
        RtcEngineEventHandlerOnFirstLocalVideoFrameJson instance) =>
    <String, dynamic>{
      'connection': instance.connection?.toJson(),
      'width': instance.width,
      'height': instance.height,
      'elapsed': instance.elapsed,
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

RtcEngineEventHandlerOnVideoSourceFrameSizeChangedJson
    _$RtcEngineEventHandlerOnVideoSourceFrameSizeChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnVideoSourceFrameSizeChangedJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          sourceType:
              $enumDecodeNullable(_$VideoSourceTypeEnumMap, json['sourceType']),
          width: json['width'] as int?,
          height: json['height'] as int?,
        );

Map<String, dynamic>
    _$RtcEngineEventHandlerOnVideoSourceFrameSizeChangedJsonToJson(
            RtcEngineEventHandlerOnVideoSourceFrameSizeChangedJson instance) =>
        <String, dynamic>{
          'connection': instance.connection?.toJson(),
          'sourceType': _$VideoSourceTypeEnumMap[instance.sourceType],
          'width': instance.width,
          'height': instance.height,
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
          uid: json['uid'] as int?,
          width: json['width'] as int?,
          height: json['height'] as int?,
          rotation: json['rotation'] as int?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnVideoSizeChangedJsonToJson(
        RtcEngineEventHandlerOnVideoSizeChangedJson instance) =>
    <String, dynamic>{
      'connection': instance.connection?.toJson(),
      'uid': instance.uid,
      'width': instance.width,
      'height': instance.height,
      'rotation': instance.rotation,
    };

RtcEngineEventHandlerOnLocalVideoStateChangedJson
    _$RtcEngineEventHandlerOnLocalVideoStateChangedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnLocalVideoStateChangedJson(
          connection: json['connection'] == null
              ? null
              : RtcConnection.fromJson(
                  json['connection'] as Map<String, dynamic>),
          state: $enumDecodeNullable(
              _$LocalVideoStreamStateEnumMap, json['state']),
          errorCode: $enumDecodeNullable(
              _$LocalVideoStreamErrorEnumMap, json['errorCode']),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnLocalVideoStateChangedJsonToJson(
        RtcEngineEventHandlerOnLocalVideoStateChangedJson instance) =>
    <String, dynamic>{
      'connection': instance.connection?.toJson(),
      'state': _$LocalVideoStreamStateEnumMap[instance.state],
      'errorCode': _$LocalVideoStreamErrorEnumMap[instance.errorCode],
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
          errorCode: $enumDecodeNullable(
              _$AudioMixingErrorTypeEnumMap, json['errorCode']),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnAudioMixingStateChangedJsonToJson(
        RtcEngineEventHandlerOnAudioMixingStateChangedJson instance) =>
    <String, dynamic>{
      'state': _$AudioMixingStateTypeEnumMap[instance.state],
      'errorCode': _$AudioMixingErrorTypeEnumMap[instance.errorCode],
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
          filePath: json['filePath'] as String?,
          width: json['width'] as int?,
          height: json['height'] as int?,
          errCode: json['errCode'] as int?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnSnapshotTakenJsonToJson(
        RtcEngineEventHandlerOnSnapshotTakenJson instance) =>
    <String, dynamic>{
      'connection': instance.connection?.toJson(),
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
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnClientRoleChangedJsonToJson(
        RtcEngineEventHandlerOnClientRoleChangedJson instance) =>
    <String, dynamic>{
      'connection': instance.connection?.toJson(),
      'oldRole': _$ClientRoleTypeEnumMap[instance.oldRole],
      'newRole': _$ClientRoleTypeEnumMap[instance.newRole],
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

RtcEngineEventHandlerOnStreamPublishedJson
    _$RtcEngineEventHandlerOnStreamPublishedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnStreamPublishedJson(
          url: json['url'] as String?,
          error: $enumDecodeNullable(_$ErrorCodeTypeEnumMap, json['error']),
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnStreamPublishedJsonToJson(
        RtcEngineEventHandlerOnStreamPublishedJson instance) =>
    <String, dynamic>{
      'url': instance.url,
      'error': _$ErrorCodeTypeEnumMap[instance.error],
    };

RtcEngineEventHandlerOnStreamUnpublishedJson
    _$RtcEngineEventHandlerOnStreamUnpublishedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnStreamUnpublishedJson(
          url: json['url'] as String?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnStreamUnpublishedJsonToJson(
        RtcEngineEventHandlerOnStreamUnpublishedJson instance) =>
    <String, dynamic>{
      'url': instance.url,
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
          extName: json['ext_name'] as String?,
          key: json['key'] as String?,
          value: json['value'] as String?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnExtensionEventJsonToJson(
        RtcEngineEventHandlerOnExtensionEventJson instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'ext_name': instance.extName,
      'key': instance.key,
      'value': instance.value,
    };

RtcEngineEventHandlerOnExtensionStartedJson
    _$RtcEngineEventHandlerOnExtensionStartedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnExtensionStartedJson(
          provider: json['provider'] as String?,
          extName: json['ext_name'] as String?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnExtensionStartedJsonToJson(
        RtcEngineEventHandlerOnExtensionStartedJson instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'ext_name': instance.extName,
    };

RtcEngineEventHandlerOnExtensionStoppedJson
    _$RtcEngineEventHandlerOnExtensionStoppedJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnExtensionStoppedJson(
          provider: json['provider'] as String?,
          extName: json['ext_name'] as String?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnExtensionStoppedJsonToJson(
        RtcEngineEventHandlerOnExtensionStoppedJson instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'ext_name': instance.extName,
    };

RtcEngineEventHandlerOnExtensionErroredJson
    _$RtcEngineEventHandlerOnExtensionErroredJsonFromJson(
            Map<String, dynamic> json) =>
        RtcEngineEventHandlerOnExtensionErroredJson(
          provider: json['provider'] as String?,
          extName: json['ext_name'] as String?,
          error: json['error'] as int?,
          msg: json['msg'] as String?,
        );

Map<String, dynamic> _$RtcEngineEventHandlerOnExtensionErroredJsonToJson(
        RtcEngineEventHandlerOnExtensionErroredJson instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'ext_name': instance.extName,
      'error': instance.error,
      'msg': instance.msg,
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
          position: json['position'] as int?,
        );

Map<String, dynamic> _$MediaPlayerSourceObserverOnPositionChangedJsonToJson(
        MediaPlayerSourceObserverOnPositionChangedJson instance) =>
    <String, dynamic>{
      'position': instance.position,
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
