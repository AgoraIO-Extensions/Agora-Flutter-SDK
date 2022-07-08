import 'package:agora_rtc_ng/src/binding_forward_export.dart';
part 'agora_base.g.dart';

/// The channel profile.
@JsonEnum(alwaysCreate: true)
enum ChannelProfileType {
  /// 0: Communication. Use this profile when there are only two users in the channel.
  @JsonValue(0)
  channelProfileCommunication,

  /// 1: Live streaming. Live streaming. Use this profile when there are more than two users in the channel.
  @JsonValue(1)
  channelProfileLiveBroadcasting,

  /// 2: Gaming. This profile is deprecated.
  @JsonValue(2)
  channelProfileGame,

  /// Cloud gaming. The scenario is optimized for latency. Use this profile if the use case requires frequent interactions between users.
  @JsonValue(3)
  channelProfileCloudGaming,

  /// @nodoc
  @JsonValue(4)
  channelProfileCommunication1v1,

  /// @nodoc
  @JsonValue(5)
  channelProfileLiveBroadcasting2,
}

/// Extensions functions of [ChannelProfileType].
extension ChannelProfileTypeExt on ChannelProfileType {
  /// @nodoc
  static ChannelProfileType fromValue(int value) {
    return $enumDecode(_$ChannelProfileTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$ChannelProfileTypeEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum WarnCodeType {
  /// @nodoc
  @JsonValue(8)
  warnInvalidView,

  /// @nodoc
  @JsonValue(16)
  warnInitVideo,

  /// @nodoc
  @JsonValue(20)
  warnPending,

  /// @nodoc
  @JsonValue(103)
  warnNoAvailableChannel,

  /// @nodoc
  @JsonValue(104)
  warnLookupChannelTimeout,

  /// @nodoc
  @JsonValue(105)
  warnLookupChannelRejected,

  /// @nodoc
  @JsonValue(106)
  warnOpenChannelTimeout,

  /// @nodoc
  @JsonValue(107)
  warnOpenChannelRejected,

  /// @nodoc
  @JsonValue(111)
  warnSwitchLiveVideoTimeout,

  /// @nodoc
  @JsonValue(118)
  warnSetClientRoleTimeout,

  /// @nodoc
  @JsonValue(121)
  warnOpenChannelInvalidTicket,

  /// @nodoc
  @JsonValue(122)
  warnOpenChannelTryNextVos,

  /// @nodoc
  @JsonValue(131)
  warnChannelConnectionUnrecoverable,

  /// @nodoc
  @JsonValue(132)
  warnChannelConnectionIpChanged,

  /// @nodoc
  @JsonValue(133)
  warnChannelConnectionPortChanged,

  /// @nodoc
  @JsonValue(134)
  warnChannelSocketError,

  /// @nodoc
  @JsonValue(701)
  warnAudioMixingOpenError,

  /// @nodoc
  @JsonValue(1014)
  warnAdmRuntimePlayoutWarning,

  /// @nodoc
  @JsonValue(1016)
  warnAdmRuntimeRecordingWarning,

  /// @nodoc
  @JsonValue(1019)
  warnAdmRecordAudioSilence,

  /// @nodoc
  @JsonValue(1020)
  warnAdmPlayoutMalfunction,

  /// @nodoc
  @JsonValue(1021)
  warnAdmRecordMalfunction,

  /// @nodoc
  @JsonValue(1029)
  warnAdmIosCategoryNotPlayandrecord,

  /// @nodoc
  @JsonValue(1030)
  warnAdmIosSamplerateChange,

  /// @nodoc
  @JsonValue(1031)
  warnAdmRecordAudioLowlevel,

  /// @nodoc
  @JsonValue(1032)
  warnAdmPlayoutAudioLowlevel,

  /// @nodoc
  @JsonValue(1040)
  warnAdmWindowsNoDataReadyEvent,

  /// @nodoc
  @JsonValue(1051)
  warnApmHowling,

  /// @nodoc
  @JsonValue(1052)
  warnAdmGlitchState,

  /// @nodoc
  @JsonValue(1053)
  warnAdmImproperSettings,

  /// @nodoc
  @JsonValue(1322)
  warnAdmWinCoreNoRecordingDevice,

  /// @nodoc
  @JsonValue(1323)
  warnAdmWinCoreNoPlayoutDevice,

  /// @nodoc
  @JsonValue(1324)
  warnAdmWinCoreImproperCaptureRelease,
}

/// Extensions functions of [WarnCodeType].
extension WarnCodeTypeExt on WarnCodeType {
  /// @nodoc
  static WarnCodeType fromValue(int value) {
    return $enumDecode(_$WarnCodeTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$WarnCodeTypeEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum ErrorCodeType {
  /// @nodoc
  @JsonValue(0)
  errOk,

  /// @nodoc
  @JsonValue(1)
  errFailed,

  /// @nodoc
  @JsonValue(2)
  errInvalidArgument,

  /// @nodoc
  @JsonValue(3)
  errNotReady,

  /// @nodoc
  @JsonValue(4)
  errNotSupported,

  /// @nodoc
  @JsonValue(5)
  errRefused,

  /// @nodoc
  @JsonValue(6)
  errBufferTooSmall,

  /// @nodoc
  @JsonValue(7)
  errNotInitialized,

  /// @nodoc
  @JsonValue(8)
  errInvalidState,

  /// @nodoc
  @JsonValue(9)
  errNoPermission,

  /// @nodoc
  @JsonValue(10)
  errTimedout,

  /// @nodoc
  @JsonValue(11)
  errCanceled,

  /// @nodoc
  @JsonValue(12)
  errTooOften,

  /// @nodoc
  @JsonValue(13)
  errBindSocket,

  /// @nodoc
  @JsonValue(14)
  errNetDown,

  /// @nodoc
  @JsonValue(15)
  errNetNobufs,

  /// @nodoc
  @JsonValue(17)
  errJoinChannelRejected,

  /// @nodoc
  @JsonValue(18)
  errLeaveChannelRejected,

  /// @nodoc
  @JsonValue(19)
  errAlreadyInUse,

  /// @nodoc
  @JsonValue(20)
  errAborted,

  /// @nodoc
  @JsonValue(21)
  errInitNetEngine,

  /// @nodoc
  @JsonValue(22)
  errResourceLimited,

  /// @nodoc
  @JsonValue(101)
  errInvalidAppId,

  /// @nodoc
  @JsonValue(102)
  errInvalidChannelName,

  /// @nodoc
  @JsonValue(103)
  errNoServerResources,

  /// @nodoc
  @JsonValue(109)
  errTokenExpired,

  /// @nodoc
  @JsonValue(110)
  errInvalidToken,

  /// @nodoc
  @JsonValue(111)
  errConnectionInterrupted,

  /// @nodoc
  @JsonValue(112)
  errConnectionLost,

  /// @nodoc
  @JsonValue(113)
  errNotInChannel,

  /// @nodoc
  @JsonValue(114)
  errSizeTooLarge,

  /// @nodoc
  @JsonValue(115)
  errBitrateLimit,

  /// @nodoc
  @JsonValue(116)
  errTooManyDataStreams,

  /// @nodoc
  @JsonValue(117)
  errStreamMessageTimeout,

  /// @nodoc
  @JsonValue(119)
  errSetClientRoleNotAuthorized,

  /// @nodoc
  @JsonValue(120)
  errDecryptionFailed,

  /// @nodoc
  @JsonValue(121)
  errInvalidUserId,

  /// @nodoc
  @JsonValue(123)
  errClientIsBannedByServer,

  /// @nodoc
  @JsonValue(124)
  errWatermarkParam,

  /// @nodoc
  @JsonValue(125)
  errWatermarkPath,

  /// @nodoc
  @JsonValue(126)
  errWatermarkPng,

  /// @nodoc
  @JsonValue(127)
  errWatermarkrInfo,

  /// @nodoc
  @JsonValue(128)
  errWatermarkArgb,

  /// @nodoc
  @JsonValue(129)
  errWatermarkRead,

  /// @nodoc
  @JsonValue(130)
  errEncryptedStreamNotAllowedPublish,

  /// @nodoc
  @JsonValue(131)
  errLicenseCredentialInvalid,

  /// @nodoc
  @JsonValue(134)
  errInvalidUserAccount,

  /// @nodoc
  @JsonValue(157)
  errCertRaw,

  /// @nodoc
  @JsonValue(158)
  errCertJsonPart,

  /// @nodoc
  @JsonValue(159)
  errCertJsonInval,

  /// @nodoc
  @JsonValue(160)
  errCertJsonNomem,

  /// @nodoc
  @JsonValue(161)
  errCertCustom,

  /// @nodoc
  @JsonValue(162)
  errCertCredential,

  /// @nodoc
  @JsonValue(163)
  errCertSign,

  /// @nodoc
  @JsonValue(164)
  errCertFail,

  /// @nodoc
  @JsonValue(165)
  errCertBuf,

  /// @nodoc
  @JsonValue(166)
  errCertNull,

  /// @nodoc
  @JsonValue(167)
  errCertDuedate,

  /// @nodoc
  @JsonValue(168)
  errCertRequest,

  /// @nodoc
  @JsonValue(200)
  errPcmsendFormat,

  /// @nodoc
  @JsonValue(201)
  errPcmsendBufferoverflow,

  /// @nodoc
  @JsonValue(400)
  errLogoutOther,

  /// @nodoc
  @JsonValue(401)
  errLogoutUser,

  /// @nodoc
  @JsonValue(402)
  errLogoutNet,

  /// @nodoc
  @JsonValue(403)
  errLogoutKicked,

  /// @nodoc
  @JsonValue(404)
  errLogoutPacket,

  /// @nodoc
  @JsonValue(405)
  errLogoutTokenExpired,

  /// @nodoc
  @JsonValue(406)
  errLogoutOldversion,

  /// @nodoc
  @JsonValue(407)
  errLogoutTokenWrong,

  /// @nodoc
  @JsonValue(408)
  errLogoutAlreadyLogout,

  /// @nodoc
  @JsonValue(420)
  errLoginOther,

  /// @nodoc
  @JsonValue(421)
  errLoginNet,

  /// @nodoc
  @JsonValue(422)
  errLoginFailed,

  /// @nodoc
  @JsonValue(423)
  errLoginCanceled,

  /// @nodoc
  @JsonValue(424)
  errLoginTokenExpired,

  /// @nodoc
  @JsonValue(425)
  errLoginOldVersion,

  /// @nodoc
  @JsonValue(426)
  errLoginTokenWrong,

  /// @nodoc
  @JsonValue(427)
  errLoginTokenKicked,

  /// @nodoc
  @JsonValue(428)
  errLoginAlreadyLogin,

  /// @nodoc
  @JsonValue(440)
  errJoinChannelOther,

  /// @nodoc
  @JsonValue(440)
  errSendMessageOther,

  /// @nodoc
  @JsonValue(441)
  errSendMessageTimeout,

  /// @nodoc
  @JsonValue(450)
  errQueryUsernumOther,

  /// @nodoc
  @JsonValue(451)
  errQueryUsernumTimeout,

  /// @nodoc
  @JsonValue(452)
  errQueryUsernumByuser,

  /// @nodoc
  @JsonValue(460)
  errLeaveChannelOther,

  /// @nodoc
  @JsonValue(461)
  errLeaveChannelKicked,

  /// @nodoc
  @JsonValue(462)
  errLeaveChannelByuser,

  /// @nodoc
  @JsonValue(463)
  errLeaveChannelLogout,

  /// @nodoc
  @JsonValue(464)
  errLeaveChannelDisconnected,

  /// @nodoc
  @JsonValue(470)
  errInviteOther,

  /// @nodoc
  @JsonValue(471)
  errInviteReinvite,

  /// @nodoc
  @JsonValue(472)
  errInviteNet,

  /// @nodoc
  @JsonValue(473)
  errInvitePeerOffline,

  /// @nodoc
  @JsonValue(474)
  errInviteTimeout,

  /// @nodoc
  @JsonValue(475)
  errInviteCantRecv,

  /// @nodoc
  @JsonValue(1001)
  errLoadMediaEngine,

  /// @nodoc
  @JsonValue(1002)
  errStartCall,

  /// @nodoc
  @JsonValue(1003)
  errStartCamera,

  /// @nodoc
  @JsonValue(1004)
  errStartVideoRender,

  /// @nodoc
  @JsonValue(1005)
  errAdmGeneralError,

  /// @nodoc
  @JsonValue(1006)
  errAdmJavaResource,

  /// @nodoc
  @JsonValue(1007)
  errAdmSampleRate,

  /// @nodoc
  @JsonValue(1008)
  errAdmInitPlayout,

  /// @nodoc
  @JsonValue(1009)
  errAdmStartPlayout,

  /// @nodoc
  @JsonValue(1010)
  errAdmStopPlayout,

  /// @nodoc
  @JsonValue(1011)
  errAdmInitRecording,

  /// @nodoc
  @JsonValue(1012)
  errAdmStartRecording,

  /// @nodoc
  @JsonValue(1013)
  errAdmStopRecording,

  /// @nodoc
  @JsonValue(1015)
  errAdmRuntimePlayoutError,

  /// @nodoc
  @JsonValue(1017)
  errAdmRuntimeRecordingError,

  /// @nodoc
  @JsonValue(1018)
  errAdmRecordAudioFailed,

  /// @nodoc
  @JsonValue(1022)
  errAdmInitLoopback,

  /// @nodoc
  @JsonValue(1023)
  errAdmStartLoopback,

  /// @nodoc
  @JsonValue(1027)
  errAdmNoPermission,

  /// @nodoc
  @JsonValue(1033)
  errAdmRecordAudioIsActive,

  /// @nodoc
  @JsonValue(1101)
  errAdmAndroidJniJavaResource,

  /// @nodoc
  @JsonValue(1108)
  errAdmAndroidJniNoRecordFrequency,

  /// @nodoc
  @JsonValue(1109)
  errAdmAndroidJniNoPlaybackFrequency,

  /// @nodoc
  @JsonValue(1111)
  errAdmAndroidJniJavaStartRecord,

  /// @nodoc
  @JsonValue(1112)
  errAdmAndroidJniJavaStartPlayback,

  /// @nodoc
  @JsonValue(1115)
  errAdmAndroidJniJavaRecordError,

  /// @nodoc
  @JsonValue(1151)
  errAdmAndroidOpenslCreateEngine,

  /// @nodoc
  @JsonValue(1153)
  errAdmAndroidOpenslCreateAudioRecorder,

  /// @nodoc
  @JsonValue(1156)
  errAdmAndroidOpenslStartRecorderThread,

  /// @nodoc
  @JsonValue(1157)
  errAdmAndroidOpenslCreateAudioPlayer,

  /// @nodoc
  @JsonValue(1160)
  errAdmAndroidOpenslStartPlayerThread,

  /// @nodoc
  @JsonValue(1201)
  errAdmIosInputNotAvailable,

  /// @nodoc
  @JsonValue(1206)
  errAdmIosActivateSessionFail,

  /// @nodoc
  @JsonValue(1210)
  errAdmIosVpioInitFail,

  /// @nodoc
  @JsonValue(1213)
  errAdmIosVpioReinitFail,

  /// @nodoc
  @JsonValue(1214)
  errAdmIosVpioRestartFail,

  /// @nodoc
  @JsonValue(1219)
  errAdmIosSetRenderCallbackFail,

  /// @nodoc
  @JsonValue(1221)
  errAdmIosSessionSampleratrZero,

  /// @nodoc
  @JsonValue(1301)
  errAdmWinCoreInit,

  /// @nodoc
  @JsonValue(1303)
  errAdmWinCoreInitRecording,

  /// @nodoc
  @JsonValue(1306)
  errAdmWinCoreInitPlayout,

  /// @nodoc
  @JsonValue(1307)
  errAdmWinCoreInitPlayoutNull,

  /// @nodoc
  @JsonValue(1309)
  errAdmWinCoreStartRecording,

  /// @nodoc
  @JsonValue(1311)
  errAdmWinCoreCreateRecThread,

  /// @nodoc
  @JsonValue(1314)
  errAdmWinCoreCaptureNotStartup,

  /// @nodoc
  @JsonValue(1319)
  errAdmWinCoreCreateRenderThread,

  /// @nodoc
  @JsonValue(1320)
  errAdmWinCoreRenderNotStartup,

  /// @nodoc
  @JsonValue(1322)
  errAdmWinCoreNoRecordingDevice,

  /// @nodoc
  @JsonValue(1323)
  errAdmWinCoreNoPlayoutDevice,

  /// @nodoc
  @JsonValue(1351)
  errAdmWinWaveInit,

  /// @nodoc
  @JsonValue(1353)
  errAdmWinWaveInitRecording,

  /// @nodoc
  @JsonValue(1354)
  errAdmWinWaveInitMicrophone,

  /// @nodoc
  @JsonValue(1355)
  errAdmWinWaveInitPlayout,

  /// @nodoc
  @JsonValue(1356)
  errAdmWinWaveInitSpeaker,

  /// @nodoc
  @JsonValue(1357)
  errAdmWinWaveStartRecording,

  /// @nodoc
  @JsonValue(1358)
  errAdmWinWaveStartPlayout,

  /// @nodoc
  @JsonValue(1359)
  errAdmNoRecordingDevice,

  /// @nodoc
  @JsonValue(1360)
  errAdmNoPlayoutDevice,

  /// @nodoc
  @JsonValue(1501)
  errVdmCameraNotAuthorized,

  /// @nodoc
  @JsonValue(1502)
  errVdmWinDeviceInUse,

  /// @nodoc
  @JsonValue(1600)
  errVcmUnknownError,

  /// @nodoc
  @JsonValue(1601)
  errVcmEncoderInitError,

  /// @nodoc
  @JsonValue(1602)
  errVcmEncoderEncodeError,

  /// @nodoc
  @JsonValue(1603)
  errVcmEncoderSetError,
}

/// Extensions functions of [ErrorCodeType].
extension ErrorCodeTypeExt on ErrorCodeType {
  /// @nodoc
  static ErrorCodeType fromValue(int value) {
    return $enumDecode(_$ErrorCodeTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$ErrorCodeTypeEnumMap[this]!;
  }
}

/// The operation permissions of the SDK on the audio session.
@JsonEnum(alwaysCreate: true)
enum AudioSessionOperationRestriction {
  /// No restriction, the SDK can change the audio session.
  @JsonValue(0)
  audioSessionOperationRestrictionNone,

  /// The SDK cannot change the audio session category.
  @JsonValue(1)
  audioSessionOperationRestrictionSetCategory,

  /// The SDK cannot change the audio session category, mode, or categoryOptions.
  @JsonValue(1 << 1)
  audioSessionOperationRestrictionConfigureSession,

  /// The SDK keeps the audio session active when the user leaves the channel, for example, to play an audio file in the background.
  @JsonValue(1 << 2)
  audioSessionOperationRestrictionDeactivateSession,

  /// Completely restricts the operation permissions of the SDK on the audio session; the SDK cannot change the audio session.
  @JsonValue(1 << 7)
  audioSessionOperationRestrictionAll,
}

/// Extensions functions of [AudioSessionOperationRestriction].
extension AudioSessionOperationRestrictionExt
    on AudioSessionOperationRestriction {
  /// @nodoc
  static AudioSessionOperationRestriction fromValue(int value) {
    return $enumDecode(_$AudioSessionOperationRestrictionEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$AudioSessionOperationRestrictionEnumMap[this]!;
  }
}

/// Reasons for a user being offline.
@JsonEnum(alwaysCreate: true)
enum UserOfflineReasonType {
  /// 0: The user quits the call.
  @JsonValue(0)
  userOfflineQuit,

  /// 1: The SDK times out and the user drops offline because no data packet is received within a certain period of time. If the user quits the call and the message is not passed to the SDK (due to an unreliable channel), the SDK assumes the user dropped offline.
  @JsonValue(1)
  userOfflineDropped,

  /// 2: The user switches the client role from the host to the audience.
  @JsonValue(2)
  userOfflineBecomeAudience,
}

/// Extensions functions of [UserOfflineReasonType].
extension UserOfflineReasonTypeExt on UserOfflineReasonType {
  /// @nodoc
  static UserOfflineReasonType fromValue(int value) {
    return $enumDecode(_$UserOfflineReasonTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$UserOfflineReasonTypeEnumMap[this]!;
  }
}

/// The interface class.
@JsonEnum(alwaysCreate: true)
enum InterfaceIdType {
  /// The AudioDeviceManager interface class.
  @JsonValue(1)
  agoraIidAudioDeviceManager,

  /// The VideoDeviceManager interface class.
  @JsonValue(2)
  agoraIidVideoDeviceManager,

  /// This interface class is deprecated.
  @JsonValue(3)
  agoraIidParameterEngine,

  /// @nodoc
  @JsonValue(4)
  agoraIidMediaEngine,

  /// @nodoc
  @JsonValue(5)
  agoraIidAudioEngine,

  /// @nodoc
  @JsonValue(6)
  agoraIidVideoEngine,

  /// @nodoc
  @JsonValue(7)
  agoraIidRtcConnection,

  /// This interface class is deprecated.
  @JsonValue(8)
  agoraIidSignalingEngine,

  /// @nodoc
  @JsonValue(9)
  agoraIidMediaEngineRegulator,

  /// @nodoc
  @JsonValue(10)
  agoraIidCloudSpatialAudio,

  /// @nodoc
  @JsonValue(11)
  agoraIidLocalSpatialAudio,
}

/// Extensions functions of [InterfaceIdType].
extension InterfaceIdTypeExt on InterfaceIdType {
  /// @nodoc
  static InterfaceIdType fromValue(int value) {
    return $enumDecode(_$InterfaceIdTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$InterfaceIdTypeEnumMap[this]!;
  }
}

/// Network quality types.
@JsonEnum(alwaysCreate: true)
enum QualityType {
  /// 0: The network quality is unknown.
  @JsonValue(0)
  qualityUnknown,

  /// 1: The network quality is excellent.
  @JsonValue(1)
  qualityExcellent,

  /// 2: The network quality is quite good, but the bitrate may be slightly lower than excellent.
  @JsonValue(2)
  qualityGood,

  /// 3: Users can feel the communication is slightly impaired.
  @JsonValue(3)
  qualityPoor,

  /// 4: Users cannot communicate smoothly.
  @JsonValue(4)
  qualityBad,

  /// 5: The quality is so bad that users can barely communicate.
  @JsonValue(5)
  qualityVbad,

  /// 6: The network is down and users cannot communicate at all.
  @JsonValue(6)
  qualityDown,

  /// @nodoc
  @JsonValue(7)
  qualityUnsupported,

  /// @nodoc
  @JsonValue(8)
  qualityDetecting,
}

/// Extensions functions of [QualityType].
extension QualityTypeExt on QualityType {
  /// @nodoc
  static QualityType fromValue(int value) {
    return $enumDecode(_$QualityTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$QualityTypeEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum FitModeType {
  /// @nodoc
  @JsonValue(1)
  modeCover,

  /// @nodoc
  @JsonValue(2)
  modeContain,
}

/// Extensions functions of [FitModeType].
extension FitModeTypeExt on FitModeType {
  /// @nodoc
  static FitModeType fromValue(int value) {
    return $enumDecode(_$FitModeTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$FitModeTypeEnumMap[this]!;
  }
}

/// The clockwise rotation of the video.
@JsonEnum(alwaysCreate: true)
enum VideoOrientation {
  /// 0: (Default) No rotation.
  @JsonValue(0)
  videoOrientation0,

  /// 90: 90 degrees.
  @JsonValue(90)
  videoOrientation90,

  /// 180: 180 degrees.
  @JsonValue(180)
  videoOrientation180,

  /// 270: 270 degrees.
  @JsonValue(270)
  videoOrientation270,
}

/// Extensions functions of [VideoOrientation].
extension VideoOrientationExt on VideoOrientation {
  /// @nodoc
  static VideoOrientation fromValue(int value) {
    return $enumDecode(_$VideoOrientationEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$VideoOrientationEnumMap[this]!;
  }
}

/// Video frame rate.
@JsonEnum(alwaysCreate: true)
enum FrameRate {
  /// 1:1 fps
  @JsonValue(1)
  frameRateFps1,

  /// 7:7fps
  @JsonValue(7)
  frameRateFps7,

  /// 10: 10fps
  @JsonValue(10)
  frameRateFps10,

  /// 15: 15fps
  @JsonValue(15)
  frameRateFps15,

  /// 24: 24fps
  @JsonValue(24)
  frameRateFps24,

  /// 30: 30fps
  @JsonValue(30)
  frameRateFps30,

  /// 60: 60fps
  /// For Windows and macOS only.
  @JsonValue(60)
  frameRateFps60,
}

/// Extensions functions of [FrameRate].
extension FrameRateExt on FrameRate {
  /// @nodoc
  static FrameRate fromValue(int value) {
    return $enumDecode(_$FrameRateEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$FrameRateEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum FrameWidth {
  /// @nodoc
  @JsonValue(640)
  frameWidth640,
}

/// Extensions functions of [FrameWidth].
extension FrameWidthExt on FrameWidth {
  /// @nodoc
  static FrameWidth fromValue(int value) {
    return $enumDecode(_$FrameWidthEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$FrameWidthEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum FrameHeight {
  /// @nodoc
  @JsonValue(360)
  frameHeight360,
}

/// Extensions functions of [FrameHeight].
extension FrameHeightExt on FrameHeight {
  /// @nodoc
  static FrameHeight fromValue(int value) {
    return $enumDecode(_$FrameHeightEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$FrameHeightEnumMap[this]!;
  }
}

/// The video frame type.
@JsonEnum(alwaysCreate: true)
enum VideoFrameType {
  /// 0: A black frame.
  @JsonValue(0)
  videoFrameTypeBlankFrame,

  /// 3: Keyframe.
  @JsonValue(3)
  videoFrameTypeKeyFrame,

  /// 4: Delta frame.
  @JsonValue(4)
  videoFrameTypeDeltaFrame,

  /// 5:The B frame.
  @JsonValue(5)
  videoFrameTypeBFrame,

  /// 6: A discarded frame.
  @JsonValue(6)
  videoFrameTypeDroppableFrame,

  /// Unknown frame.
  @JsonValue(7)
  videoFrameTypeUnknow,
}

/// Extensions functions of [VideoFrameType].
extension VideoFrameTypeExt on VideoFrameType {
  /// @nodoc
  static VideoFrameType fromValue(int value) {
    return $enumDecode(_$VideoFrameTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$VideoFrameTypeEnumMap[this]!;
  }
}

/// Video output orientation mode.
@JsonEnum(alwaysCreate: true)
enum OrientationMode {
  /// 0: (Default) The output video always follows the orientation of the captured video.
  /// The receiver takes the rotational information passed on from the video encoder. This mode applies to scenarios where video orientation can be adjusted on the receiver. If the captured video is in landscape mode, the output video is in landscape mode.
  /// If the captured video is in portrait mode, the output video is in portrait mode.
  @JsonValue(0)
  orientationModeAdaptive,

  /// 1: In this mode, the SDK always outputs videos in landscape (horizontal) mode. If the captured video is in portrait mode, the video encoder crops it to fit the output. Applies to situations where the receiving end cannot process the rotational information. For example, CDN live streaming.
  @JsonValue(1)
  orientationModeFixedLandscape,

  /// 2: In this mode, the SDK always outputs video in portrait (portrait) mode. If the captured video is in landscape mode, the video encoder crops it to fit the output.
  /// Applies to situations where the receiving end cannot process the rotational information. For example, CDN live streaming.
  @JsonValue(2)
  orientationModeFixedPortrait,
}

/// Extensions functions of [OrientationMode].
extension OrientationModeExt on OrientationMode {
  /// @nodoc
  static OrientationMode fromValue(int value) {
    return $enumDecode(_$OrientationModeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$OrientationModeEnumMap[this]!;
  }
}

/// Video degradation preferences when the bandwidth is a constraint.
@JsonEnum(alwaysCreate: true)
enum DegradationPreference {
  /// 0: (Default) Prefers to reduce the video frame rate while maintaining video quality during video encoding under limited bandwidth. This degradation preference is suitable for scenarios where video quality is prioritized.
  /// In the COMMUNICATION channel profile, the resolution of the video sent may change, so remote users need to handle this issue. See onVideoSizeChanged .
  @JsonValue(0)
  maintainQuality,

  /// 1: Prefers to reduce the video quality while maintaining the video frame rate during video encoding under limited bandwidth. This degradation preference is suitable for scenarios where smoothness is prioritized and video quality is allowed to be reduced.
  @JsonValue(1)
  maintainFramerate,

  ///
  @JsonValue(2)
  maintainBalanced,

  /// @nodoc
  @JsonValue(3)
  maintainResolution,

  /// @nodoc
  @JsonValue(100)
  disabled,
}

/// Extensions functions of [DegradationPreference].
extension DegradationPreferenceExt on DegradationPreference {
  /// @nodoc
  static DegradationPreference fromValue(int value) {
    return $enumDecode(_$DegradationPreferenceEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$DegradationPreferenceEnumMap[this]!;
  }
}

/// The video dimension.
@JsonSerializable(explicitToJson: true)
class VideoDimensions {
  /// Construct the [VideoDimensions].
  const VideoDimensions({this.width, this.height});

  /// The width (pixels) of the video.
  @JsonKey(name: 'width')
  final int? width;

  /// The height (pixels) of the video.
  @JsonKey(name: 'height')
  final int? height;

  /// @nodoc
  factory VideoDimensions.fromJson(Map<String, dynamic> json) =>
      _$VideoDimensionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$VideoDimensionsToJson(this);
}

/// @nodoc
const standardBitrate = 0;

/// @nodoc
const compatibleBitrate = -1;

/// @nodoc
const defaultMinBitrate = -1;

/// @nodoc
const defaultMinBitrateEqualToTargetBitrate = -2;

/// Video codec types.
@JsonEnum(alwaysCreate: true)
enum VideoCodecType {
  /// @nodoc
  @JsonValue(0)
  videoCodecNone,

  /// 1: Standard VP8.
  @JsonValue(1)
  videoCodecVp8,

  /// 2: Standard H.264.
  @JsonValue(2)
  videoCodecH264,

  /// 3: Standard H.265.
  @JsonValue(3)
  videoCodecH265,

  /// @nodoc
  @JsonValue(5)
  videoCodecVp9,

  /// 6: Generic.
  /// This type is used for transmitting raw video data, such as encrypted video frames. The SDK returns this type of video frames in callbacks, and you need to decode and render the frames yourself.
  @JsonValue(6)
  videoCodecGeneric,

  /// @nodoc
  @JsonValue(7)
  videoCodecGenericH264,

  /// @nodoc
  @JsonValue(12)
  videoCodecAv1,

  /// 20: Generic JPEG.This type consumes minimum computing resources and applies to IoT devices.
  @JsonValue(20)
  videoCodecGenericJpeg,
}

/// Extensions functions of [VideoCodecType].
extension VideoCodecTypeExt on VideoCodecType {
  /// @nodoc
  static VideoCodecType fromValue(int value) {
    return $enumDecode(_$VideoCodecTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$VideoCodecTypeEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum TCcMode {
  /// @nodoc
  @JsonValue(0)
  ccEnabled,

  /// @nodoc
  @JsonValue(1)
  ccDisabled,
}

/// Extensions functions of [TCcMode].
extension TCcModeExt on TCcMode {
  /// @nodoc
  static TCcMode fromValue(int value) {
    return $enumDecode(_$TCcModeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$TCcModeEnumMap[this]!;
  }
}

/// @nodoc
@JsonSerializable(explicitToJson: true)
class SenderOptions {
  /// Construct the [SenderOptions].
  const SenderOptions({this.ccMode, this.codecType, this.targetBitrate});

  /// @nodoc
  @JsonKey(name: 'ccMode')
  final TCcMode? ccMode;

  /// @nodoc
  @JsonKey(name: 'codecType')
  final VideoCodecType? codecType;

  /// @nodoc
  @JsonKey(name: 'targetBitrate')
  final int? targetBitrate;

  /// @nodoc
  factory SenderOptions.fromJson(Map<String, dynamic> json) =>
      _$SenderOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$SenderOptionsToJson(this);
}

/// The codec type of audio.
@JsonEnum(alwaysCreate: true)
enum AudioCodecType {
  /// 1: OPUS.
  @JsonValue(1)
  audioCodecOpus,

  /// @nodoc
  @JsonValue(3)
  audioCodecPcma,

  /// @nodoc
  @JsonValue(4)
  audioCodecPcmu,

  /// @nodoc
  @JsonValue(5)
  audioCodecG722,

  /// 8: LC-AAC.
  @JsonValue(8)
  audioCodecAaclc,

  /// 9: HE-AAC.
  @JsonValue(9)
  audioCodecHeaac,

  /// @nodoc
  @JsonValue(10)
  audioCodecJc1,

  /// 11: HE-AAC v2.
  @JsonValue(11)
  audioCodecHeaac2,

  /// @nodoc
  @JsonValue(12)
  audioCodecLpcnet,
}

/// Extensions functions of [AudioCodecType].
extension AudioCodecTypeExt on AudioCodecType {
  /// @nodoc
  static AudioCodecType fromValue(int value) {
    return $enumDecode(_$AudioCodecTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$AudioCodecTypeEnumMap[this]!;
  }
}

/// Audio encoding type.
@JsonEnum(alwaysCreate: true)
enum AudioEncodingType {
  /// AAC encoding format, 16000 Hz sampling rate, bass quality. A file with an audio duration of 10 minutes is approximately 1.2 MB after encoding.
  @JsonValue(0x010101)
  audioEncodingTypeAac16000Low,

  /// AAC encoding format, 16000 Hz sampling rate, medium sound quality. A file with an audio duration of 10 minutes is approximately 2 MB after encoding.
  @JsonValue(0x010102)
  audioEncodingTypeAac16000Medium,

  /// AAC encoding format, 32000 Hz sampling rate, bass quality. A file with an audio duration of 10 minutes is approximately 1.2 MB after encoding.
  @JsonValue(0x010201)
  audioEncodingTypeAac32000Low,

  /// AAC encoding format, 32000 Hz sampling rate, medium sound quality. A file with an audio duration of 10 minutes is approximately 2 MB after encoding.
  @JsonValue(0x010202)
  audioEncodingTypeAac32000Medium,

  /// AAC encoding format, 32000 Hz sampling rate, high sound quality. A file with an audio duration of 10 minutes is approximately 3.5 MB after encoding.
  @JsonValue(0x010203)
  audioEncodingTypeAac32000High,

  /// AAC encoding format, 48000 Hz sampling rate, medium sound quality. A file with an audio duration of 10 minutes is approximately 2 MB after encoding.
  @JsonValue(0x010302)
  audioEncodingTypeAac48000Medium,

  /// AAC encoding format, 48000 Hz sampling rate, high sound quality. A file with an audio duration of 10 minutes is approximately 3.5 MB after encoding.
  @JsonValue(0x010303)
  audioEncodingTypeAac48000High,

  /// OPUS encoding format, 16000 Hz sampling rate, bass quality. A file with an audio duration of 10 minutes is approximately 2 MB after encoding.
  @JsonValue(0x020101)
  audioEncodingTypeOpus16000Low,

  /// OPUS encoding format, 16000 Hz sampling rate, medium sound quality. A file with an audio duration of 10 minutes is approximately 2 MB after encoding.
  @JsonValue(0x020102)
  audioEncodingTypeOpus16000Medium,

  /// OPUS encoding format, 48000 Hz sampling rate, medium sound quality. A file with an audio duration of 10 minutes is approximately 2 MB after encoding.
  @JsonValue(0x020302)
  audioEncodingTypeOpus48000Medium,

  /// OPUS encoding format, 48000 Hz sampling rate, high sound quality. A file with an audio duration of 10 minutes is approximately 3.5 MB after encoding.
  @JsonValue(0x020303)
  audioEncodingTypeOpus48000High,
}

/// Extensions functions of [AudioEncodingType].
extension AudioEncodingTypeExt on AudioEncodingType {
  /// @nodoc
  static AudioEncodingType fromValue(int value) {
    return $enumDecode(_$AudioEncodingTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$AudioEncodingTypeEnumMap[this]!;
  }
}

/// The adaptation mode of the watermark.
@JsonEnum(alwaysCreate: true)
enum WatermarkFitMode {
  /// Use the positionInLandscapeMode and positionInPortraitMode values you set in WatermarkOptions . The settings in WatermarkRatio are invalid.
  @JsonValue(0)
  fitModeCoverPosition,

  /// Use the value you set in WatermarkRatio . The settings in positionInLandscapeMode and positionInPortraitMode in WatermarkOptions are invalid.
  @JsonValue(1)
  fitModeUseImageRatio,
}

/// Extensions functions of [WatermarkFitMode].
extension WatermarkFitModeExt on WatermarkFitMode {
  /// @nodoc
  static WatermarkFitMode fromValue(int value) {
    return $enumDecode(_$WatermarkFitModeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$WatermarkFitModeEnumMap[this]!;
  }
}

/// @nodoc
@JsonSerializable(explicitToJson: true)
class EncodedAudioFrameAdvancedSettings {
  /// Construct the [EncodedAudioFrameAdvancedSettings].
  const EncodedAudioFrameAdvancedSettings({this.speech, this.sendEvenIfEmpty});

  /// @nodoc
  @JsonKey(name: 'speech')
  final bool? speech;

  /// @nodoc
  @JsonKey(name: 'sendEvenIfEmpty')
  final bool? sendEvenIfEmpty;

  /// @nodoc
  factory EncodedAudioFrameAdvancedSettings.fromJson(
          Map<String, dynamic> json) =>
      _$EncodedAudioFrameAdvancedSettingsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() =>
      _$EncodedAudioFrameAdvancedSettingsToJson(this);
}

/// Audio information after encoding.
@JsonSerializable(explicitToJson: true)
class EncodedAudioFrameInfo {
  /// Construct the [EncodedAudioFrameInfo].
  const EncodedAudioFrameInfo(
      {this.codec,
      this.sampleRateHz,
      this.samplesPerChannel,
      this.numberOfChannels,
      this.advancedSettings});

  /// Audio Codec type: AudioCodecType .
  @JsonKey(name: 'codec')
  final AudioCodecType? codec;

  /// Audio sample rate (Hz).
  @JsonKey(name: 'sampleRateHz')
  final int? sampleRateHz;

  /// The number of audio samples per channel.
  @JsonKey(name: 'samplesPerChannel')
  final int? samplesPerChannel;

  /// The number of audio channels.
  @JsonKey(name: 'numberOfChannels')
  final int? numberOfChannels;

  /// This function is not currently supported.
  @JsonKey(name: 'advancedSettings')
  final EncodedAudioFrameAdvancedSettings? advancedSettings;

  /// @nodoc
  factory EncodedAudioFrameInfo.fromJson(Map<String, dynamic> json) =>
      _$EncodedAudioFrameInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$EncodedAudioFrameInfoToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true)
class AudioPcmDataInfo {
  /// Construct the [AudioPcmDataInfo].
  const AudioPcmDataInfo(
      {this.samplesPerChannel,
      this.channelNum,
      this.samplesOut,
      this.elapsedTimeMs,
      this.ntpTimeMs});

  /// @nodoc
  @JsonKey(name: 'samplesPerChannel')
  final int? samplesPerChannel;

  /// @nodoc
  @JsonKey(name: 'channelNum')
  final int? channelNum;

  /// @nodoc
  @JsonKey(name: 'samplesOut')
  final int? samplesOut;

  /// @nodoc
  @JsonKey(name: 'elapsedTimeMs')
  final int? elapsedTimeMs;

  /// @nodoc
  @JsonKey(name: 'ntpTimeMs')
  final int? ntpTimeMs;

  /// @nodoc
  factory AudioPcmDataInfo.fromJson(Map<String, dynamic> json) =>
      _$AudioPcmDataInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AudioPcmDataInfoToJson(this);
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum H264PacketizeMode {
  /// @nodoc
  @JsonValue(0)
  nonInterleaved,

  /// @nodoc
  @JsonValue(1)
  singleNalUnit,
}

/// Extensions functions of [H264PacketizeMode].
extension H264PacketizeModeExt on H264PacketizeMode {
  /// @nodoc
  static H264PacketizeMode fromValue(int value) {
    return $enumDecode(_$H264PacketizeModeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$H264PacketizeModeEnumMap[this]!;
  }
}

/// The type of video streams.
@JsonEnum(alwaysCreate: true)
enum VideoStreamType {
  /// 0: High-quality video stream.
  @JsonValue(0)
  videoStreamHigh,

  /// 1: Low-quality video stream.
  @JsonValue(1)
  videoStreamLow,
}

/// Extensions functions of [VideoStreamType].
extension VideoStreamTypeExt on VideoStreamType {
  /// @nodoc
  static VideoStreamType fromValue(int value) {
    return $enumDecode(_$VideoStreamTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$VideoStreamTypeEnumMap[this]!;
  }
}

/// The information about the external encoded video frame.
@JsonSerializable(explicitToJson: true)
class EncodedVideoFrameInfo {
  /// Construct the [EncodedVideoFrameInfo].
  const EncodedVideoFrameInfo(
      {this.codecType,
      this.width,
      this.height,
      this.framesPerSecond,
      this.frameType,
      this.rotation,
      this.trackId,
      this.renderTimeMs,
      this.internalSendTs,
      this.uid,
      this.streamType});

  /// The codec type of the local video stream. See VideoCodecType . The default value is videoCodecH264(2).
  @JsonKey(name: 'codecType')
  final VideoCodecType? codecType;

  /// The width (pixel) of the video frame.
  @JsonKey(name: 'width')
  final int? width;

  /// The height (pixel) of the video frame.
  @JsonKey(name: 'height')
  final int? height;

  /// The number of video frames per second.
  /// When this parameter is not 0, you can use it to calculate the Unix timestamp of the external encoded video frames.
  @JsonKey(name: 'framesPerSecond')
  final int? framesPerSecond;

  /// The video frame type, see VideoFrameType .
  @JsonKey(name: 'frameType')
  final VideoFrameType? frameType;

  /// The rotation information of the video frame, see VideoOrientation .
  @JsonKey(name: 'rotation')
  final VideoOrientation? rotation;

  /// Reserved for future use.
  @JsonKey(name: 'trackId')
  final int? trackId;

  /// The Unix timestamp (ms) when the video frame is rendered. This timestamp can be used to guide the rendering of the video frame. It is required.
  @JsonKey(name: 'renderTimeMs')
  final int? renderTimeMs;

  /// @nodoc
  @JsonKey(name: 'internalSendTs')
  final int? internalSendTs;

  /// The user ID to push the the external encoded video frame.
  @JsonKey(name: 'uid')
  final int? uid;

  /// The type of video streams.
  @JsonKey(name: 'streamType')
  final VideoStreamType? streamType;

  /// @nodoc
  factory EncodedVideoFrameInfo.fromJson(Map<String, dynamic> json) =>
      _$EncodedVideoFrameInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$EncodedVideoFrameInfoToJson(this);
}

/// Video mirror mode.
@JsonEnum(alwaysCreate: true)
enum VideoMirrorModeType {
  /// 0: (Default) The SDK determines the mirror mode.
  @JsonValue(0)
  videoMirrorModeAuto,

  /// 1: Enable mirror mode.
  @JsonValue(1)
  videoMirrorModeEnabled,

  /// 2: Disable mirror mode.
  @JsonValue(2)
  videoMirrorModeDisabled,
}

/// Extensions functions of [VideoMirrorModeType].
extension VideoMirrorModeTypeExt on VideoMirrorModeType {
  /// @nodoc
  static VideoMirrorModeType fromValue(int value) {
    return $enumDecode(_$VideoMirrorModeTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$VideoMirrorModeTypeEnumMap[this]!;
  }
}

/// Video encoder configurations.
@JsonSerializable(explicitToJson: true)
class VideoEncoderConfiguration {
  /// Construct the [VideoEncoderConfiguration].
  const VideoEncoderConfiguration(
      {this.codecType,
      this.dimensions,
      this.frameRate,
      this.bitrate,
      this.minBitrate,
      this.orientationMode,
      this.degradationPreference,
      this.mirrorMode});

  /// The codec type of the local video stream. See VideoCodecType .
  @JsonKey(name: 'codecType')
  final VideoCodecType? codecType;

  /// The dimensions of the encoded video (px). See VideoDimensions . This parameter measures the video encoding quality in the format of length × width. The default value is 640 × 360. You can set a custom value.
  @JsonKey(name: 'dimensions')
  final VideoDimensions? dimensions;

  /// The frame rate (fps) of the encoding video frame. The default value is 15. See FrameRate .
  @JsonKey(name: 'frameRate')
  final int? frameRate;

  /// The encoding bitrate (Kbps) of the video.  : (Recommended) Standard bitrate mode. In this mode, the video bitrate is twice the base bitrate.
  /// : Adaptive bitrate mode. In this mode, the video bitrate is the same as the base bitrate. If you choose this mode in the interactive streaming profile, the video frame rate may be lower than the set value.
  @JsonKey(name: 'bitrate')
  final int? bitrate;

  /// The minimum encoding bitrate (Kbps) of the video.
  /// The SDK automatically adjusts the encoding bitrate to adapt to the network conditions. Using a value greater than the default value forces the video encoder to output high-quality images but may cause more packet loss and sacrifice the smoothness of the video transmission. Unless you have special requirements for image quality, Agora does not recommend changing this value.
  /// This parameter only applies to the interactive streaming profile.
  @JsonKey(name: 'minBitrate')
  final int? minBitrate;

  /// The orientation mode of the encoded video. See OrientationMode .
  @JsonKey(name: 'orientationMode')
  final OrientationMode? orientationMode;

  /// Video degradation preference under limited bandwidth.
  @JsonKey(name: 'degradationPreference')
  final DegradationPreference? degradationPreference;

  /// Whether to enable mirroring mode when sending encoded video, only affects the video images seen by remote users. See VideoMirrorModeType .
  /// By default, the video is not mirrored.
  @JsonKey(name: 'mirrorMode')
  final VideoMirrorModeType? mirrorMode;

  /// @nodoc
  factory VideoEncoderConfiguration.fromJson(Map<String, dynamic> json) =>
      _$VideoEncoderConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$VideoEncoderConfigurationToJson(this);
}

/// The configurations for the data stream.
/// The following table shows the SDK behaviors under different parameter settings:
@JsonSerializable(explicitToJson: true)
class DataStreamConfig {
  /// Construct the [DataStreamConfig].
  const DataStreamConfig({this.syncWithAudio, this.ordered});

  /// Whether to synchronize the data packet with the published audio packet.
  /// true: Synchronize the data packet with the audio packet.
  /// false: Do not synchronize the data packet with the audio packet.
  /// When you set the data packet to synchronize with the audio, then if the data packet delay is within the audio delay, the SDK triggers the onStreamMessage callback when the synchronized audio packet is played out. Do not set this parameter as true if you need the receiver to receive the data packet immediately. Agora recommends that you set this parameter to `true` only when you need to implement specific functions, for example, lyric synchronization.
  @JsonKey(name: 'syncWithAudio')
  final bool? syncWithAudio;

  /// Whether the SDK guarantees that the receiver receives the data in the sent order.
  /// true: Guarantee that the receiver receives the data in the sent order.
  /// false: Do not guarantee that the receiver receives the data in the sent order.
  /// Do not set this parameter as true if you need the receiver to receive the data packet immediately.
  @JsonKey(name: 'ordered')
  final bool? ordered;

  /// @nodoc
  factory DataStreamConfig.fromJson(Map<String, dynamic> json) =>
      _$DataStreamConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$DataStreamConfigToJson(this);
}

/// The configuration of the low-quality video stream.
@JsonSerializable(explicitToJson: true)
class SimulcastStreamConfig {
  /// Construct the [SimulcastStreamConfig].
  const SimulcastStreamConfig({this.dimensions, this.bitrate, this.framerate});

  /// The video dimension.  The default value is 160 × 120.
  @JsonKey(name: 'dimensions')
  final VideoDimensions? dimensions;

  /// Video receive bitrate (Kbps). The default value is 65.
  @JsonKey(name: 'bitrate')
  final int? bitrate;

  /// The capture frame rate (fps) of the local video. The default value is 5.
  @JsonKey(name: 'framerate')
  final int? framerate;

  /// @nodoc
  factory SimulcastStreamConfig.fromJson(Map<String, dynamic> json) =>
      _$SimulcastStreamConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$SimulcastStreamConfigToJson(this);
}

/// The location of the target area relative to the screen or window. If you do not set this parameter, the SDK selects the whole screen or window.
@JsonSerializable(explicitToJson: true)
class Rectangle {
  /// Construct the [Rectangle].
  const Rectangle({this.x, this.y, this.width, this.height});

  /// x: The horizontal offset from the top-left corner.
  @JsonKey(name: 'x')
  final int? x;

  /// y: The vertical offset from the top-left corner.
  @JsonKey(name: 'y')
  final int? y;

  /// The width of the target area.
  @JsonKey(name: 'width')
  final int? width;

  /// The height of the target area.
  @JsonKey(name: 'height')
  final int? height;

  /// @nodoc
  factory Rectangle.fromJson(Map<String, dynamic> json) =>
      _$RectangleFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RectangleToJson(this);
}

/// The position and size of the watermark on the screen.
/// The position and size of the watermark on the screen are determined by xRatio, yRatio, and widthRatio:
/// (xRatio, yRatio) refers to the coordinates of the upper left corner of the watermark, which determines the distance from the upper left corner of the watermark to the upper left corner of the screen.
/// The widthRatio determines the width of the watermark.
@JsonSerializable(explicitToJson: true)
class WatermarkRatio {
  /// Construct the [WatermarkRatio].
  const WatermarkRatio({this.xRatio, this.yRatio, this.widthRatio});

  /// The x-coordinate of the upper left corner of the watermark. The x-coordinate of the upper left corner of the watermark. The horizontal position relative to the origin, where the upper left corner of the screen is the origin, and the x-coordinate is the upper left corner of the watermark. The value range is [0.0,1.0], and the default value is 0.
  @JsonKey(name: 'xRatio')
  final double? xRatio;

  /// The y-coordinate of the upper left corner of the watermark. The vertical position relative to the origin, where the upper left corner of the screen is the origin, and the y-coordinate is the upper left corner of the screen. The value range is [0.0,1.0], and the default value is 0.
  @JsonKey(name: 'yRatio')
  final double? yRatio;

  /// The width of the watermark. The SDK calculates the height of the watermark proportionally according to this parameter value to ensure that the enlarged or reduced watermark image is not distorted. The value range is [0,1], and the default value is 0, which means no watermark is displayed.
  @JsonKey(name: 'widthRatio')
  final double? widthRatio;

  /// @nodoc
  factory WatermarkRatio.fromJson(Map<String, dynamic> json) =>
      _$WatermarkRatioFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$WatermarkRatioToJson(this);
}

/// Configurations of the watermark image.
@JsonSerializable(explicitToJson: true)
class WatermarkOptions {
  /// Construct the [WatermarkOptions].
  const WatermarkOptions(
      {this.visibleInPreview,
      this.positionInLandscapeMode,
      this.positionInPortraitMode,
      this.watermarkRatio,
      this.mode});

  /// Reserved for future use.
  @JsonKey(name: 'visibleInPreview')
  final bool? visibleInPreview;

  /// When the adaptation mode of the watermark isfitModeCoverPosition, it is used to set the area of the watermark image in landscape mode. See Rectangle .
  @JsonKey(name: 'positionInLandscapeMode')
  final Rectangle? positionInLandscapeMode;

  /// When the adaptation mode of the watermark isfitModeCoverPosition , it is used to set the area of the watermark image in portrait mode. See Rectangle .
  @JsonKey(name: 'positionInPortraitMode')
  final Rectangle? positionInPortraitMode;

  /// When the watermark adaptation mode is fitModeUseImageRatio, this parameter is used to set the watermark coordinates. See WatermarkRatio .
  @JsonKey(name: 'watermarkRatio')
  final WatermarkRatio? watermarkRatio;

  /// The adaptation mode of the watermark. See WatermarkFitMode .
  @JsonKey(name: 'mode')
  final WatermarkFitMode? mode;

  /// @nodoc
  factory WatermarkOptions.fromJson(Map<String, dynamic> json) =>
      _$WatermarkOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$WatermarkOptionsToJson(this);
}

/// Statistics of the channel.
@JsonSerializable(explicitToJson: true)
class RtcStats {
  /// Construct the [RtcStats].
  const RtcStats(
      {this.duration,
      this.txBytes,
      this.rxBytes,
      this.txAudioBytes,
      this.txVideoBytes,
      this.rxAudioBytes,
      this.rxVideoBytes,
      this.txKBitRate,
      this.rxKBitRate,
      this.rxAudioKBitRate,
      this.txAudioKBitRate,
      this.rxVideoKBitRate,
      this.txVideoKBitRate,
      this.lastmileDelay,
      this.userCount,
      this.cpuAppUsage,
      this.cpuTotalUsage,
      this.gatewayRtt,
      this.memoryAppUsageRatio,
      this.memoryTotalUsageRatio,
      this.memoryAppUsageInKbytes,
      this.connectTimeMs,
      this.firstAudioPacketDuration,
      this.firstVideoPacketDuration,
      this.firstVideoKeyFramePacketDuration,
      this.packetsBeforeFirstKeyFramePacket,
      this.firstAudioPacketDurationAfterUnmute,
      this.firstVideoPacketDurationAfterUnmute,
      this.firstVideoKeyFramePacketDurationAfterUnmute,
      this.firstVideoKeyFrameDecodedDurationAfterUnmute,
      this.firstVideoKeyFrameRenderedDurationAfterUnmute,
      this.txPacketLossRate,
      this.rxPacketLossRate});

  /// Call duration of the local user in seconds, represented by an aggregate value.
  @JsonKey(name: 'duration')
  final int? duration;

  /// Total number of bytes transmitted, represented by an aggregate value.
  @JsonKey(name: 'txBytes')
  final int? txBytes;

  /// Total number of bytes received, represented by an aggregate value.
  @JsonKey(name: 'rxBytes')
  final int? rxBytes;

  /// Total number of audio bytes sent, represented by an aggregate value.
  @JsonKey(name: 'txAudioBytes')
  final int? txAudioBytes;

  /// The total number of video bytes sent, represented by an aggregate value.
  @JsonKey(name: 'txVideoBytes')
  final int? txVideoBytes;

  /// The total number of audio bytes received, represented by an aggregate value.
  @JsonKey(name: 'rxAudioBytes')
  final int? rxAudioBytes;

  /// The total number of video bytes received, represented by an aggregate value.
  @JsonKey(name: 'rxVideoBytes')
  final int? rxVideoBytes;

  /// Video transmission bitrate (Kbps), represented by an instantaneous value.
  @JsonKey(name: 'txKBitRate')
  final int? txKBitRate;

  /// The receiving bitrate (Kbps), represented by an instantaneous value.
  @JsonKey(name: 'rxKBitRate')
  final int? rxKBitRate;

  /// Audio receive bitrate (Kbps), represented by an instantaneous value.
  @JsonKey(name: 'rxAudioKBitRate')
  final int? rxAudioKBitRate;

  /// The bitrate (Kbps) of sending the audio packet.
  @JsonKey(name: 'txAudioKBitRate')
  final int? txAudioKBitRate;

  /// Video receive bitrate (Kbps), represented by an instantaneous value.
  @JsonKey(name: 'rxVideoKBitRate')
  final int? rxVideoKBitRate;

  /// The bitrate (Kbps) of sending the video.
  @JsonKey(name: 'txVideoKBitRate')
  final int? txVideoKBitRate;

  /// The client-to-server delay (ms).
  @JsonKey(name: 'lastmileDelay')
  final int? lastmileDelay;

  /// The number of users in the channel.
  @JsonKey(name: 'userCount')
  final int? userCount;

  /// Application CPU usage (%). The value of cpuTotalUsage is always reported as 0 in the onLeaveChannel callback.
  /// As of Android 8.1, you cannot get the CPU usage from this attribute due to system limitations.
  @JsonKey(name: 'cpuAppUsage')
  final double? cpuAppUsage;

  /// The system CPU usage (%).
  /// For Windows, in the multi-kernel environment, this member represents the average CPU usage. The value = (100 - System Idle Progress in Task Manager)/100. The value of cpuTotalUsage is always reported as 0 in the onLeaveChannel callback.
  @JsonKey(name: 'cpuTotalUsage')
  final double? cpuTotalUsage;

  /// The round-trip time delay (ms) from the client to the local router.On Android, to get gatewayRtt, ensure that you add the android.permission.ACCESS_WIFI_STATE permission after </application> in the AndroidManifest.xml file in your project.
  @JsonKey(name: 'gatewayRtt')
  final int? gatewayRtt;

  /// The memory ratio occupied by the app (%).
  /// This value is for reference only. Due to system limitations, you may not get this value.
  @JsonKey(name: 'memoryAppUsageRatio')
  final double? memoryAppUsageRatio;

  /// The memory occupied by the system (%).
  /// This value is for reference only. Due to system limitations, you may not get this value.
  @JsonKey(name: 'memoryTotalUsageRatio')
  final double? memoryTotalUsageRatio;

  /// The memory size occupied by the app (KB).
  /// This value is for reference only. Due to system limitations, you may not get this value.
  @JsonKey(name: 'memoryAppUsageInKbytes')
  final int? memoryAppUsageInKbytes;

  /// The duration (ms) between the SDK starts connecting and the connection is established. If the value reported is 0, it means invalid.
  @JsonKey(name: 'connectTimeMs')
  final int? connectTimeMs;

  /// @nodoc
  @JsonKey(name: 'firstAudioPacketDuration')
  final int? firstAudioPacketDuration;

  /// @nodoc
  @JsonKey(name: 'firstVideoPacketDuration')
  final int? firstVideoPacketDuration;

  /// @nodoc
  @JsonKey(name: 'firstVideoKeyFramePacketDuration')
  final int? firstVideoKeyFramePacketDuration;

  /// @nodoc
  @JsonKey(name: 'packetsBeforeFirstKeyFramePacket')
  final int? packetsBeforeFirstKeyFramePacket;

  /// @nodoc
  @JsonKey(name: 'firstAudioPacketDurationAfterUnmute')
  final int? firstAudioPacketDurationAfterUnmute;

  /// @nodoc
  @JsonKey(name: 'firstVideoPacketDurationAfterUnmute')
  final int? firstVideoPacketDurationAfterUnmute;

  /// @nodoc
  @JsonKey(name: 'firstVideoKeyFramePacketDurationAfterUnmute')
  final int? firstVideoKeyFramePacketDurationAfterUnmute;

  /// @nodoc
  @JsonKey(name: 'firstVideoKeyFrameDecodedDurationAfterUnmute')
  final int? firstVideoKeyFrameDecodedDurationAfterUnmute;

  /// @nodoc
  @JsonKey(name: 'firstVideoKeyFrameRenderedDurationAfterUnmute')
  final int? firstVideoKeyFrameRenderedDurationAfterUnmute;

  /// The packet loss rate (%) from the client to the Agora server before applying the anti-packet-loss algorithm.
  @JsonKey(name: 'txPacketLossRate')
  final int? txPacketLossRate;

  /// The packet loss rate (%) from the Agora server to the client before using the anti-packet-loss method.
  @JsonKey(name: 'rxPacketLossRate')
  final int? rxPacketLossRate;

  /// @nodoc
  factory RtcStats.fromJson(Map<String, dynamic> json) =>
      _$RtcStatsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RtcStatsToJson(this);
}

/// The capture type of the custom video source.
@JsonEnum(alwaysCreate: true)
enum VideoSourceType {
  /// @nodoc
  @JsonValue(0)
  videoSourceCameraPrimary,

  /// The camera.
  @JsonValue(0)
  videoSourceCamera,

  /// The secondary camera.
  @JsonValue(1)
  videoSourceCameraSecondary,

  /// The primary screen.
  @JsonValue(2)
  videoSourceScreenPrimary,

  /// The screen.
  @JsonValue(2)
  videoSourceScreen,

  /// The secondary screen.
  @JsonValue(3)
  videoSourceScreenSecondary,

  /// The custom video source.
  @JsonValue(4)
  videoSourceCustom,

  /// The video source from the media player.
  @JsonValue(5)
  videoSourceMediaPlayer,

  /// The video source is a PNG image.
  @JsonValue(6)
  videoSourceRtcImagePng,

  /// The video source is a JPEG image.
  @JsonValue(7)
  videoSourceRtcImageJpeg,

  /// The video source is a GIF image.
  @JsonValue(8)
  videoSourceRtcImageGif,

  /// The video source is remote video acquired by the network.
  @JsonValue(9)
  videoSourceRemote,

  /// A transcoded video source.
  @JsonValue(10)
  videoSourceTranscoded,

  /// An unknown video source.
  @JsonValue(100)
  videoSourceUnknown,
}

/// Extensions functions of [VideoSourceType].
extension VideoSourceTypeExt on VideoSourceType {
  /// @nodoc
  static VideoSourceType fromValue(int value) {
    return $enumDecode(_$VideoSourceTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$VideoSourceTypeEnumMap[this]!;
  }
}

/// The user role in the interactive live streaming.
@JsonEnum(alwaysCreate: true)
enum ClientRoleType {
  /// 1: Host. A host can both send and receive streams.
  @JsonValue(1)
  clientRoleBroadcaster,

  /// 2: (Default) Audience. An audience member can only receive streams.
  @JsonValue(2)
  clientRoleAudience,
}

/// Extensions functions of [ClientRoleType].
extension ClientRoleTypeExt on ClientRoleType {
  /// @nodoc
  static ClientRoleType fromValue(int value) {
    return $enumDecode(_$ClientRoleTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$ClientRoleTypeEnumMap[this]!;
  }
}

/// Quality change of the local video in terms of target frame rate and target bit rate since last count.
@JsonEnum(alwaysCreate: true)
enum QualityAdaptIndication {
  /// 0: The local video quality stays the same.
  @JsonValue(0)
  adaptNone,

  /// 1: The local video quality improves because the network bandwidth increases.
  @JsonValue(1)
  adaptUpBandwidth,

  /// 2: The local video quality deteriorates because the network bandwidth decreases.
  @JsonValue(2)
  adaptDownBandwidth,
}

/// Extensions functions of [QualityAdaptIndication].
extension QualityAdaptIndicationExt on QualityAdaptIndication {
  /// @nodoc
  static QualityAdaptIndication fromValue(int value) {
    return $enumDecode(_$QualityAdaptIndicationEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$QualityAdaptIndicationEnumMap[this]!;
  }
}

/// The latency level of an audience member in interactive live streaming. This enum takes effect only when the user role is set to clientRoleAudience .
@JsonEnum(alwaysCreate: true)
enum AudienceLatencyLevelType {
  /// 1: Low latency.
  @JsonValue(1)
  audienceLatencyLevelLowLatency,

  /// 2: (Default) Ultra low latency.
  @JsonValue(2)
  audienceLatencyLevelUltraLowLatency,

  /// @nodoc
  @JsonValue(3)
  audienceLatencyLevelHighLatency,
}

/// Extensions functions of [AudienceLatencyLevelType].
extension AudienceLatencyLevelTypeExt on AudienceLatencyLevelType {
  /// @nodoc
  static AudienceLatencyLevelType fromValue(int value) {
    return $enumDecode(_$AudienceLatencyLevelTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$AudienceLatencyLevelTypeEnumMap[this]!;
  }
}

/// The detailed options of a user.
@JsonSerializable(explicitToJson: true)
class ClientRoleOptions {
  /// Construct the [ClientRoleOptions].
  const ClientRoleOptions({this.audienceLatencyLevel});

  /// The latency level of an audience member in interactive live streaming. See AudienceLatencyLevelType .
  @JsonKey(name: 'audienceLatencyLevel')
  final AudienceLatencyLevelType? audienceLatencyLevel;

  /// @nodoc
  factory ClientRoleOptions.fromJson(Map<String, dynamic> json) =>
      _$ClientRoleOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ClientRoleOptionsToJson(this);
}

/// The Quality of Experience (QoE) of the local user when receiving a remote audio stream.
@JsonEnum(alwaysCreate: true)
enum ExperienceQualityType {
  /// 0: The QoE of the local user is good.
  @JsonValue(0)
  experienceQualityGood,

  /// 1: The QoE of the local user is poor
  @JsonValue(1)
  experienceQualityBad,
}

/// Extensions functions of [ExperienceQualityType].
extension ExperienceQualityTypeExt on ExperienceQualityType {
  /// @nodoc
  static ExperienceQualityType fromValue(int value) {
    return $enumDecode(_$ExperienceQualityTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$ExperienceQualityTypeEnumMap[this]!;
  }
}

/// Audio statistics of the remote user.
@JsonSerializable(explicitToJson: true)
class RemoteAudioStats {
  /// Construct the [RemoteAudioStats].
  const RemoteAudioStats(
      {this.uid,
      this.quality,
      this.networkTransportDelay,
      this.jitterBufferDelay,
      this.audioLossRate,
      this.numChannels,
      this.receivedSampleRate,
      this.receivedBitrate,
      this.totalFrozenTime,
      this.frozenRate,
      this.mosValue,
      this.totalActiveTime,
      this.publishDuration,
      this.qoeQuality});

  /// The user ID of the remote user.
  @JsonKey(name: 'uid')
  final int? uid;

  /// The quality of the audio stream sent by the user.  QualityType
  @JsonKey(name: 'quality')
  final int? quality;

  /// The network delay (ms) from the sender to the receiver.
  @JsonKey(name: 'networkTransportDelay')
  final int? networkTransportDelay;

  /// The network delay (ms) from the audio receiver to the jitter buffer. When the receiving end is an audience member andaudienceLatencyLevel of ClientRoleOptions is 1, this parameter does not take effect.
  @JsonKey(name: 'jitterBufferDelay')
  final int? jitterBufferDelay;

  /// The frame loss rate (%) of the remote audio stream in the reported interval.
  @JsonKey(name: 'audioLossRate')
  final int? audioLossRate;

  /// The number of audio channels.
  @JsonKey(name: 'numChannels')
  final int? numChannels;

  /// The sampling rate of the received audio stream in the reported interval.
  @JsonKey(name: 'receivedSampleRate')
  final int? receivedSampleRate;

  /// The average bitrate (Kbps) of the received audio stream in the reported interval.
  @JsonKey(name: 'receivedBitrate')
  final int? receivedBitrate;

  /// The total freeze time (ms) of the remote audio stream after the remote user joins the channel. In a session, audio freeze occurs when the audio frame loss rate reaches 4%.
  @JsonKey(name: 'totalFrozenTime')
  final int? totalFrozenTime;

  /// The total audio freeze time as a percentage (%) of the total time when the audio is available. The audio is considered available when the remote user neither stops sending the audio stream nor disables the audio module after joining the channel.
  @JsonKey(name: 'frozenRate')
  final int? frozenRate;

  /// The quality of the remote audio stream in the reported interval. The quality is determined by the Agora real-time audio MOS (Mean Opinion Score) measurement method. The return value range is [0, 500]. Dividing the return value by 100 gets the MOS score, which ranges from 0 to 5. The higher the score, the better the audio quality.
  /// The subjective perception of audio quality corresponding to the Agora real-time audio MOS scores is as follows: MOS score
  /// Perception of audio quality Greater than 4
  /// Excellent. The audio sounds clear and smooth. From 3.5 to 4
  /// Good. The audio has some perceptible impairment but still sounds clear. From 3 to 3.5
  /// Fair. The audio freezes occasionally and requires attentive listening. From 2.5 to 3
  /// Poor. The audio sounds choppy and requires considerable effort to understand. From 2 to 2.5
  /// Bad. The audio has occasional noise. Consecutive audio dropouts occur, resulting in some information loss. The users can communicate only with difficulty. Less than 2
  /// Very bad. The audio has persistent noise. Consecutive audio dropouts are frequent, resulting in severe information loss. Communication is nearly impossible.
  @JsonKey(name: 'mosValue')
  final int? mosValue;

  /// The total active time (ms) between the start of the audio call and the callback of the remote user.
  /// The active time refers to the total duration of the remote user without the mute state.
  @JsonKey(name: 'totalActiveTime')
  final int? totalActiveTime;

  /// The total duration (ms) of the remote audio stream.
  @JsonKey(name: 'publishDuration')
  final int? publishDuration;

  /// The Quality of Experience (QoE) of the local user when receiving a remote audio stream.
  @JsonKey(name: 'qoeQuality')
  final int? qoeQuality;

  /// @nodoc
  factory RemoteAudioStats.fromJson(Map<String, dynamic> json) =>
      _$RemoteAudioStatsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RemoteAudioStatsToJson(this);
}

/// The audio profile.
@JsonEnum(alwaysCreate: true)
enum AudioProfileType {
  /// 0: The default audio profile.
  /// For the interactive streaming profile: A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 64 Kbps.
  /// For the communication profile:
  /// Windows: A sample rate of 16 kHz, audio encoding, mono, and a bitrate of up to 16 Kbps.
  /// Android/macOS/iOS:
  @JsonValue(0)
  audioProfileDefault,

  /// 1: A sample rate of 32 kHz, audio encoding, mono, and a bitrate of up to 18 Kbps.
  @JsonValue(1)
  audioProfileSpeechStandard,

  /// 2: A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 64 Kbps.
  @JsonValue(2)
  audioProfileMusicStandard,

  /// 3: A sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 80 Kbps.To implement stereo audio, you also need to call setAdvancedAudioOptions and set audioProcessingChannels to AdvancedAudioOptions in audioProcessingStereo.
  @JsonValue(3)
  audioProfileMusicStandardStereo,

  /// 4: A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 96 Kbps.
  @JsonValue(4)
  audioProfileMusicHighQuality,

  /// 5: A sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 128 Kbps.To implement stereo audio, you also need to call setAdvancedAudioOptions and set audioProcessingChannels to AdvancedAudioOptions in audioProcessingStereo.
  @JsonValue(5)
  audioProfileMusicHighQualityStereo,

  ///
  @JsonValue(6)
  audioProfileIot,

  /// @nodoc
  @JsonValue(7)
  audioProfileNum,
}

/// Extensions functions of [AudioProfileType].
extension AudioProfileTypeExt on AudioProfileType {
  /// @nodoc
  static AudioProfileType fromValue(int value) {
    return $enumDecode(_$AudioProfileTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$AudioProfileTypeEnumMap[this]!;
  }
}

/// The audio scenario.
@JsonEnum(alwaysCreate: true)
enum AudioScenarioType {
  /// 0: (Default) Automatic scenario, where the SDK chooses the appropriate audio quality according to the user role and audio route.
  @JsonValue(0)
  audioScenarioDefault,

  /// 3: High-quality audio scenario, where users mainly play music.
  @JsonValue(3)
  audioScenarioGameStreaming,

  /// @nodoc
  @JsonValue(5)
  audioScenarioChatroom,

  /// 6: High-quality audio scenario, where users mainly play music.
  @JsonValue(6)
  audioScenarioHighDefinition,

  /// 7: Real-time chorus scenario, where users have good network conditions and require ultra-low latency.
  @JsonValue(7)
  audioScenarioChorus,

  /// @nodoc
  @JsonValue(8)
  audioScenarioNum,
}

/// Extensions functions of [AudioScenarioType].
extension AudioScenarioTypeExt on AudioScenarioType {
  /// @nodoc
  static AudioScenarioType fromValue(int value) {
    return $enumDecode(_$AudioScenarioTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$AudioScenarioTypeEnumMap[this]!;
  }
}

/// The format of the video frame.
@JsonSerializable(explicitToJson: true)
class VideoFormat {
  /// Construct the [VideoFormat].
  const VideoFormat({this.width, this.height, this.fps});

  /// The width (px) of the video frame.
  @JsonKey(name: 'width')
  final int? width;

  /// The height (px) of the video frame.
  @JsonKey(name: 'height')
  final int? height;

  /// The video frame rate (fps).
  @JsonKey(name: 'fps')
  final int? fps;

  /// @nodoc
  factory VideoFormat.fromJson(Map<String, dynamic> json) =>
      _$VideoFormatFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$VideoFormatToJson(this);
}

/// The content hint for screen sharing.
@JsonEnum(alwaysCreate: true)
enum VideoContentHint {
  /// (Default) No content hint.
  @JsonValue(0)
  contentHintNone,

  /// Motion-intensive content. Choose this option if you prefer smoothness or when you are sharing a video clip, movie, or video game.
  @JsonValue(1)
  contentHintMotion,

  /// Motionless content. Choose this option if you prefer sharpness or when you are sharing a picture, PowerPoint slides, or texts.
  @JsonValue(2)
  contentHintDetails,
}

/// Extensions functions of [VideoContentHint].
extension VideoContentHintExt on VideoContentHint {
  /// @nodoc
  static VideoContentHint fromValue(int value) {
    return $enumDecode(_$VideoContentHintEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$VideoContentHintEnumMap[this]!;
  }
}

/// The state of the local audio.
@JsonEnum(alwaysCreate: true)
enum LocalAudioStreamState {
  /// 0: The local audo is in the initial state.
  @JsonValue(0)
  localAudioStreamStateStopped,

  /// 1: The local audo capturing device starts successfully.
  @JsonValue(1)
  localAudioStreamStateRecording,

  /// 2: The first audo frame encodes successfully.
  @JsonValue(2)
  localAudioStreamStateEncoding,

  /// 3: The local audio fails to start.
  @JsonValue(3)
  localAudioStreamStateFailed,
}

/// Extensions functions of [LocalAudioStreamState].
extension LocalAudioStreamStateExt on LocalAudioStreamState {
  /// @nodoc
  static LocalAudioStreamState fromValue(int value) {
    return $enumDecode(_$LocalAudioStreamStateEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$LocalAudioStreamStateEnumMap[this]!;
  }
}

/// Local audio state error codes.
@JsonEnum(alwaysCreate: true)
enum LocalAudioStreamError {
  /// @nodoc
  @JsonValue(0)
  localAudioStreamErrorOk,

  /// @nodoc
  @JsonValue(1)
  localAudioStreamErrorFailure,

  /// @nodoc
  @JsonValue(2)
  localAudioStreamErrorDeviceNoPermission,

  /// @nodoc
  @JsonValue(3)
  localAudioStreamErrorDeviceBusy,

  /// @nodoc
  @JsonValue(4)
  localAudioStreamErrorRecordFailure,

  /// @nodoc
  @JsonValue(5)
  localAudioStreamErrorEncodeFailure,
}

/// Extensions functions of [LocalAudioStreamError].
extension LocalAudioStreamErrorExt on LocalAudioStreamError {
  /// @nodoc
  static LocalAudioStreamError fromValue(int value) {
    return $enumDecode(_$LocalAudioStreamErrorEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$LocalAudioStreamErrorEnumMap[this]!;
  }
}

/// Local video state types.
@JsonEnum(alwaysCreate: true)
enum LocalVideoStreamState {
  /// 0: The local video is in the initial state.
  @JsonValue(0)
  localVideoStreamStateStopped,

  /// 1: The local video capturing device starts successfully.
  @JsonValue(1)
  localVideoStreamStateCapturing,

  /// 2: The first video frame is successfully encoded.
  @JsonValue(2)
  localVideoStreamStateEncoding,

  /// 3: Fails to start the local video.
  @JsonValue(3)
  localVideoStreamStateFailed,
}

/// Extensions functions of [LocalVideoStreamState].
extension LocalVideoStreamStateExt on LocalVideoStreamState {
  /// @nodoc
  static LocalVideoStreamState fromValue(int value) {
    return $enumDecode(_$LocalVideoStreamStateEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$LocalVideoStreamStateEnumMap[this]!;
  }
}

/// Local video state error code.
@JsonEnum(alwaysCreate: true)
enum LocalVideoStreamError {
  /// 0: The local video is normal.
  @JsonValue(0)
  localVideoStreamErrorOk,

  /// 1: No specified reason for the local video failure.
  @JsonValue(1)
  localVideoStreamErrorFailure,

  /// 2: No permission to use the local video capturing device.
  @JsonValue(2)
  localVideoStreamErrorDeviceNoPermission,

  /// 3: The local video capturing device is in use.
  @JsonValue(3)
  localVideoStreamErrorDeviceBusy,

  /// 4: The local video capture fails. Check whether the capturing device is working properly.
  @JsonValue(4)
  localVideoStreamErrorCaptureFailure,

  /// 5: The local video encoding fails.
  @JsonValue(5)
  localVideoStreamErrorEncodeFailure,

  /// @nodoc
  @JsonValue(6)
  localVideoStreamErrorCaptureInbackground,

  /// @nodoc
  @JsonValue(7)
  localVideoStreamErrorCaptureMultipleForegroundApps,

  /// 8: Fails to find a local video capture device.
  @JsonValue(8)
  localVideoStreamErrorDeviceNotFound,

  /// @nodoc
  @JsonValue(9)
  localVideoStreamErrorDeviceDisconnected,

  /// @nodoc
  @JsonValue(10)
  localVideoStreamErrorDeviceInvalidId,

  /// @nodoc
  @JsonValue(101)
  localVideoStreamErrorDeviceSystemPressure,

  /// 11: When calling startScreenCaptureByWindowId to share the window, the shared window is in a minimized state.
  @JsonValue(11)
  localVideoStreamErrorScreenCaptureWindowMinimized,

  /// 12: The error code indicates that a window shared by the window ID has been closed, or a full-screen window shared by the window ID has exited full-screen mode. After exiting full-screen mode, remote users cannot see the shared window. To prevent remote users from seeing a black screen, Agora recommends that you immediately stop screen sharing.
  /// Common scenarios for reporting this error code:
  /// When the local user closes the shared window, the SDK reports this error code.
  /// The local user shows some slides in full-screen mode first, and then shares the windows of the slides. After the user exits full-screen mode, the SDK reports this error code.
  /// The local user watches a web video or reads a web document in full-screen mode first, and then shares the window of the web video or document. After the user exits full-screen mode, the SDK reports this error code.
  @JsonValue(12)
  localVideoStreamErrorScreenCaptureWindowClosed,

  /// @nodoc
  @JsonValue(13)
  localVideoStreamErrorScreenCaptureWindowOccluded,

  /// @nodoc
  @JsonValue(20)
  localVideoStreamErrorScreenCaptureWindowNotSupported,
}

/// Extensions functions of [LocalVideoStreamError].
extension LocalVideoStreamErrorExt on LocalVideoStreamError {
  /// @nodoc
  static LocalVideoStreamError fromValue(int value) {
    return $enumDecode(_$LocalVideoStreamErrorEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$LocalVideoStreamErrorEnumMap[this]!;
  }
}

/// Remote audio states.
@JsonEnum(alwaysCreate: true)
enum RemoteAudioState {
  /// 0: The remote audo is in the initial state. The SDK reports this state in the case of remoteAudioReasonLocalMuted, remoteAudioReasonRemoteMuted, or remoteAudioReasonRemoteOffline.
  @JsonValue(0)
  remoteAudioStateStopped,

  /// 1: The first remote audio packet is received.
  @JsonValue(1)
  remoteAudioStateStarting,

  /// 2: The remote audio stream is decoded and plays normally. The SDK reports this state in the case of remoteAudioReasonNetworkRecovery, remoteAudioReasonLocalUnmuted, or remoteAudioReasonRemoteUnmuted.
  @JsonValue(2)
  remoteAudioStateDecoding,

  /// 3: The remote audio is frozen. The SDK reports this state in the case of remoteAudioReasonNetworkCongestion.
  @JsonValue(3)
  remoteAudioStateFrozen,

  /// 4: The remote audio fails to start. The SDK reports this state in the case of remoteAudioReasonInternal.
  @JsonValue(4)
  remoteAudioStateFailed,
}

/// Extensions functions of [RemoteAudioState].
extension RemoteAudioStateExt on RemoteAudioState {
  /// @nodoc
  static RemoteAudioState fromValue(int value) {
    return $enumDecode(_$RemoteAudioStateEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$RemoteAudioStateEnumMap[this]!;
  }
}

/// The reason for the remote audio state change.
@JsonEnum(alwaysCreate: true)
enum RemoteAudioStateReason {
  /// 0: The SDK reports this reason when the audio state changes.
  @JsonValue(0)
  remoteAudioReasonInternal,

  /// 1: Network congestion.
  @JsonValue(1)
  remoteAudioReasonNetworkCongestion,

  /// 2: Network recovery.
  @JsonValue(2)
  remoteAudioReasonNetworkRecovery,

  /// 3: The local user stops receiving the remote audio stream or disables the audio module.
  @JsonValue(3)
  remoteAudioReasonLocalMuted,

  /// 4: The local user resumes receiving the remote audio stream or enables the audio module.
  @JsonValue(4)
  remoteAudioReasonLocalUnmuted,

  /// 5: The remote user stops sending the audio stream or disables the audio module.
  @JsonValue(5)
  remoteAudioReasonRemoteMuted,

  /// 6: The remote user resumes sending the audio stream or enables the audio module.
  @JsonValue(6)
  remoteAudioReasonRemoteUnmuted,

  /// 7: The remote user leaves the channel.
  @JsonValue(7)
  remoteAudioReasonRemoteOffline,
}

/// Extensions functions of [RemoteAudioStateReason].
extension RemoteAudioStateReasonExt on RemoteAudioStateReason {
  /// @nodoc
  static RemoteAudioStateReason fromValue(int value) {
    return $enumDecode(_$RemoteAudioStateReasonEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$RemoteAudioStateReasonEnumMap[this]!;
  }
}

/// The state of the remote video.
@JsonEnum(alwaysCreate: true)
enum RemoteVideoState {
  /// 0: The remote audo is in the initial state. The SDK reports this state in the case of remoteVideoStateReasonLocalMuted, remoteVideoStateReasonRemoteMuted, or remoteVideoStateReasonRemoteOffline.
  @JsonValue(0)
  remoteVideoStateStopped,

  /// 1: The first remote audio packet is received.
  @JsonValue(1)
  remoteVideoStateStarting,

  /// 2: The remote audio stream is decoded and plays normally. The SDK reports this state in the case of remoteVideoStateReasonNetworkRecovery, ,remoteVideoStateReasonLocalUnmuted,remoteVideoStateReasonRemoteUnmuted or remoteVideoStateReasonAudioFallbackRecovery.
  @JsonValue(2)
  remoteVideoStateDecoding,

  /// 3: The remote video is frozen. The SDK reports this state in the case of remoteVideoStateReasonNetworkCongestion or remoteVideoStateReasonAudioFallback.
  @JsonValue(3)
  remoteVideoStateFrozen,

  /// 4: The remote video fails to start. The SDK reports this state in the case of remoteVideoStateReasonInternal.
  @JsonValue(4)
  remoteVideoStateFailed,
}

/// Extensions functions of [RemoteVideoState].
extension RemoteVideoStateExt on RemoteVideoState {
  /// @nodoc
  static RemoteVideoState fromValue(int value) {
    return $enumDecode(_$RemoteVideoStateEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$RemoteVideoStateEnumMap[this]!;
  }
}

/// The reason for the remote audio state change.
@JsonEnum(alwaysCreate: true)
enum RemoteVideoStateReason {
  /// 0: The SDK reports this reason when the audio state changes.
  @JsonValue(0)
  remoteVideoStateReasonInternal,

  /// 1: Network congestion.
  @JsonValue(1)
  remoteVideoStateReasonNetworkCongestion,

  /// 2: Network recovery.
  @JsonValue(2)
  remoteVideoStateReasonNetworkRecovery,

  /// 3: The local user stops receiving the remote video stream or disables the video module.
  @JsonValue(3)
  remoteVideoStateReasonLocalMuted,

  /// 4: The local user resumes receiving the remote video stream or enables the video module.
  @JsonValue(4)
  remoteVideoStateReasonLocalUnmuted,

  /// 5: The remote user stops sending the video stream or disables the video module.
  @JsonValue(5)
  remoteVideoStateReasonRemoteMuted,

  /// 6: The remote user resumes sending the video stream or enables the video module.
  @JsonValue(6)
  remoteVideoStateReasonRemoteUnmuted,

  /// 7: The remote user leaves the channel.
  @JsonValue(7)
  remoteVideoStateReasonRemoteOffline,

  /// @nodoc
  @JsonValue(8)
  remoteVideoStateReasonAudioFallback,

  /// @nodoc
  @JsonValue(9)
  remoteVideoStateReasonAudioFallbackRecovery,

  /// @nodoc
  @JsonValue(10)
  remoteVideoStateReasonVideoStreamTypeChangeToLow,

  /// @nodoc
  @JsonValue(11)
  remoteVideoStateReasonVideoStreamTypeChangeToHigh,
}

/// Extensions functions of [RemoteVideoStateReason].
extension RemoteVideoStateReasonExt on RemoteVideoStateReason {
  /// @nodoc
  static RemoteVideoStateReason fromValue(int value) {
    return $enumDecode(_$RemoteVideoStateReasonEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$RemoteVideoStateReasonEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum RemoteUserState {
  /// @nodoc
  @JsonValue((1 << 0))
  userStateMuteAudio,

  /// @nodoc
  @JsonValue((1 << 1))
  userStateMuteVideo,

  /// @nodoc
  @JsonValue((1 << 4))
  userStateEnableVideo,

  /// @nodoc
  @JsonValue((1 << 8))
  userStateEnableLocalVideo,
}

/// Extensions functions of [RemoteUserState].
extension RemoteUserStateExt on RemoteUserState {
  /// @nodoc
  static RemoteUserState fromValue(int value) {
    return $enumDecode(_$RemoteUserStateEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$RemoteUserStateEnumMap[this]!;
  }
}

/// @nodoc
@JsonSerializable(explicitToJson: true)
class VideoTrackInfo {
  /// Construct the [VideoTrackInfo].
  const VideoTrackInfo(
      {this.isLocal,
      this.ownerUid,
      this.trackId,
      this.channelId,
      this.streamType,
      this.codecType,
      this.encodedFrameOnly,
      this.sourceType,
      this.observationPosition});

  /// @nodoc
  @JsonKey(name: 'isLocal')
  final bool? isLocal;

  /// @nodoc
  @JsonKey(name: 'ownerUid')
  final int? ownerUid;

  /// @nodoc
  @JsonKey(name: 'trackId')
  final int? trackId;

  /// @nodoc
  @JsonKey(name: 'channelId')
  final String? channelId;

  /// @nodoc
  @JsonKey(name: 'streamType')
  final VideoStreamType? streamType;

  /// @nodoc
  @JsonKey(name: 'codecType')
  final VideoCodecType? codecType;

  /// @nodoc
  @JsonKey(name: 'encodedFrameOnly')
  final bool? encodedFrameOnly;

  /// @nodoc
  @JsonKey(name: 'sourceType')
  final VideoSourceType? sourceType;

  /// @nodoc
  @JsonKey(name: 'observationPosition')
  final int? observationPosition;

  /// @nodoc
  factory VideoTrackInfo.fromJson(Map<String, dynamic> json) =>
      _$VideoTrackInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$VideoTrackInfoToJson(this);
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum RemoteVideoDownscaleLevel {
  /// @nodoc
  @JsonValue(0)
  remoteVideoDownscaleLevelNone,

  /// @nodoc
  @JsonValue(1)
  remoteVideoDownscaleLevel1,

  /// @nodoc
  @JsonValue(2)
  remoteVideoDownscaleLevel2,

  /// @nodoc
  @JsonValue(3)
  remoteVideoDownscaleLevel3,

  /// @nodoc
  @JsonValue(4)
  remoteVideoDownscaleLevel4,
}

/// Extensions functions of [RemoteVideoDownscaleLevel].
extension RemoteVideoDownscaleLevelExt on RemoteVideoDownscaleLevel {
  /// @nodoc
  static RemoteVideoDownscaleLevel fromValue(int value) {
    return $enumDecode(_$RemoteVideoDownscaleLevelEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$RemoteVideoDownscaleLevelEnumMap[this]!;
  }
}

/// The volume information of users.
@JsonSerializable(explicitToJson: true)
class AudioVolumeInfo {
  /// Construct the [AudioVolumeInfo].
  const AudioVolumeInfo({this.uid, this.volume, this.vad, this.voicePitch});

  /// The user ID. In the local user's callback, uid = 0.
  /// In the remote users' callback, uid is the user ID of a remote user whose instantaneous volume is one of the three highest.
  @JsonKey(name: 'uid')
  final int? uid;

  /// The volume of the user. The value ranges between 0 (the lowest volume) and 255 (the highest volume).
  @JsonKey(name: 'volume')
  final int? volume;

  /// Voice activity status of the local user. 0: The local user is not speaking.
  /// 1: The local user is speaking.
  /// The vad parameter does not report the voice activity status of remote users. In a remote user's callback, the value of vad is always 1.
  /// To use this parameter, you must set reportVad to true when calling enableAudioVolumeIndication .
  @JsonKey(name: 'vad')
  final int? vad;

  /// @nodoc
  @JsonKey(name: 'voicePitch')
  final double? voicePitch;

  /// @nodoc
  factory AudioVolumeInfo.fromJson(Map<String, dynamic> json) =>
      _$AudioVolumeInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AudioVolumeInfoToJson(this);
}

/// The audio device information.
/// This class is for Android only.
@JsonSerializable(explicitToJson: true)
class DeviceInfo {
  /// Construct the [DeviceInfo].
  const DeviceInfo({this.isLowLatencyAudioSupported});

  /// Whether the audio device supports ultra-low-latency capture and playback:
  /// true: The device supports ultra-low-latency capture and playback.
  /// false: The device does not support ultra-low-latency capture and playback.
  @JsonKey(name: 'isLowLatencyAudioSupported')
  final bool? isLowLatencyAudioSupported;

  /// @nodoc
  factory DeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$DeviceInfoToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true)
class Packet {
  /// Construct the [Packet].
  const Packet({this.buffer, this.size});

  /// /// @nodoc
  @JsonKey(name: 'buffer', ignore: true)
  final Uint8List? buffer;

  /// /// @nodoc
  @JsonKey(name: 'size')
  final int? size;

  /// @nodoc
  factory Packet.fromJson(Map<String, dynamic> json) => _$PacketFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$PacketToJson(this);
}

/// The audio sampling rate of the stream to be pushed to the CDN.
@JsonEnum(alwaysCreate: true)
enum AudioSampleRateType {
  /// 32000: 32 kHz
  @JsonValue(32000)
  audioSampleRate32000,

  /// 44100: 44.1 kHz
  @JsonValue(44100)
  audioSampleRate44100,

  /// 48000: (Default) 48 kHz
  @JsonValue(48000)
  audioSampleRate48000,
}

/// Extensions functions of [AudioSampleRateType].
extension AudioSampleRateTypeExt on AudioSampleRateType {
  /// @nodoc
  static AudioSampleRateType fromValue(int value) {
    return $enumDecode(_$AudioSampleRateTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$AudioSampleRateTypeEnumMap[this]!;
  }
}

/// The codec type of the output video.
@JsonEnum(alwaysCreate: true)
enum VideoCodecTypeForStream {
  /// 1: (Default) H.264.
  @JsonValue(1)
  videoCodecH264ForStream,

  /// 2: H.265.
  @JsonValue(2)
  videoCodecH265ForStream,
}

/// Extensions functions of [VideoCodecTypeForStream].
extension VideoCodecTypeForStreamExt on VideoCodecTypeForStream {
  /// @nodoc
  static VideoCodecTypeForStream fromValue(int value) {
    return $enumDecode(_$VideoCodecTypeForStreamEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$VideoCodecTypeForStreamEnumMap[this]!;
  }
}

/// Video codec profile types.
@JsonEnum(alwaysCreate: true)
enum VideoCodecProfileType {
  /// @nodoc
  @JsonValue(66)
  videoCodecProfileBaseline,

  /// @nodoc
  @JsonValue(77)
  videoCodecProfileMain,

  /// @nodoc
  @JsonValue(100)
  videoCodecProfileHigh,
}

/// Extensions functions of [VideoCodecProfileType].
extension VideoCodecProfileTypeExt on VideoCodecProfileType {
  /// @nodoc
  static VideoCodecProfileType fromValue(int value) {
    return $enumDecode(_$VideoCodecProfileTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$VideoCodecProfileTypeEnumMap[this]!;
  }
}

/// Self-defined audio codec profile.
@JsonEnum(alwaysCreate: true)
enum AudioCodecProfileType {
  /// 0: (Default) LC-AAC.
  @JsonValue(0)
  audioCodecProfileLcAac,

  /// 1: HE-AAC.
  @JsonValue(1)
  audioCodecProfileHeAac,

  /// 2: HE-AAC v2.
  @JsonValue(2)
  audioCodecProfileHeAacV2,
}

/// Extensions functions of [AudioCodecProfileType].
extension AudioCodecProfileTypeExt on AudioCodecProfileType {
  /// @nodoc
  static AudioCodecProfileType fromValue(int value) {
    return $enumDecode(_$AudioCodecProfileTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$AudioCodecProfileTypeEnumMap[this]!;
  }
}

/// Local audio statistics.
@JsonSerializable(explicitToJson: true)
class LocalAudioStats {
  /// Construct the [LocalAudioStats].
  const LocalAudioStats(
      {this.numChannels,
      this.sentSampleRate,
      this.sentBitrate,
      this.internalCodec,
      this.txPacketLossRate});

  /// The number of audio channels.
  @JsonKey(name: 'numChannels')
  final int? numChannels;

  /// The sampling rate (Hz) of sending the local user's audio stream.
  @JsonKey(name: 'sentSampleRate')
  final int? sentSampleRate;

  /// The average bitrate (Kbps) of sending the local user's audio stream.
  @JsonKey(name: 'sentBitrate')
  final int? sentBitrate;

  /// The internal payload codec.
  @JsonKey(name: 'internalCodec')
  final int? internalCodec;

  /// The packet loss rate (%) from the local client to the Agora server before applying the anti-packet loss strategies.
  @JsonKey(name: 'txPacketLossRate')
  final int? txPacketLossRate;

  /// @nodoc
  factory LocalAudioStats.fromJson(Map<String, dynamic> json) =>
      _$LocalAudioStatsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LocalAudioStatsToJson(this);
}

/// States of the Media Push.
@JsonEnum(alwaysCreate: true)
enum RtmpStreamPublishState {
  /// 0: The Media Push has not started or has ended.
  /// This state is also triggered after you remove a RTMP or RTMPS stream from the CDN by calling removePublishStreamUrl .
  @JsonValue(0)
  rtmpStreamPublishStateIdle,

  /// 1: The SDK is connecting to Agora's streaming server and the CDN server.
  /// This state is triggered after you call the addPublishStreamUrl method.
  @JsonValue(1)
  rtmpStreamPublishStateConnecting,

  /// 2: The RTMP or RTMPS streaming publishes. The SDK successfully publishes the RTMP or RTMPS streaming and returns this state.
  @JsonValue(2)
  rtmpStreamPublishStateRunning,

  /// 3: The RTMP or RTMPS streaming is recovering.
  /// When exceptions occur to the CDN, or the streaming is interrupted, the SDK tries to resume RTMP or RTMPS streaming and returns this state. If the SDK successfully resumes the streaming, rtmpStreamPublishStateRunning(2) returns. If the streaming does not resume within 60 seconds or server errors occur, rtmpStreamPublishStateFailure(4) returns.
  /// You can also reconnect to the server by calling the removePublishStreamUrl and addPublishStreamUrl methods.
  @JsonValue(3)
  rtmpStreamPublishStateRecovering,

  /// 3: Fails to push streams to the CDN.
  /// See the errCode parameter for the detailed error information.You can also call the addPublishStreamUrl method to publish the RTMP or RTMPS streaming again.
  @JsonValue(4)
  rtmpStreamPublishStateFailure,

  /// 5: The SDK is disconnecting from the Agora streaming server and CDN. When you call removePublishStreamUrl or stopRtmpStream to stop the streaming normally, the SDK reports the streaming state as rtmpStreamPublishStateDisconnecting and rtmpStreamPublishStateIdle in sequence.
  @JsonValue(5)
  rtmpStreamPublishStateDisconnecting,
}

/// Extensions functions of [RtmpStreamPublishState].
extension RtmpStreamPublishStateExt on RtmpStreamPublishState {
  /// @nodoc
  static RtmpStreamPublishState fromValue(int value) {
    return $enumDecode(_$RtmpStreamPublishStateEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$RtmpStreamPublishStateEnumMap[this]!;
  }
}

/// Error codes of the RTMP or RTMPS streaming.
@JsonEnum(alwaysCreate: true)
enum RtmpStreamPublishErrorType {
  /// 0: The RTMP or RTMPS streaming publishes successfully.
  @JsonValue(0)
  rtmpStreamPublishErrorOk,

  /// 1: Invalid argument used. Check the parameter setting. For example, if you do not call setLiveTranscoding to set the transcoding parameters before calling addPublishStreamUrl , the SDK returns this error.
  @JsonValue(1)
  rtmpStreamPublishErrorInvalidArgument,

  /// 2: The RTMP or RTMPS streaming is encrypted and cannot be published.
  @JsonValue(2)
  rtmpStreamPublishErrorEncryptedStreamNotAllowed,

  /// 3: Timeout for the RTMP or RTMPS streaming. Call the addPublishStreamUrl method to publish the streaming again.
  @JsonValue(3)
  rtmpStreamPublishErrorConnectionTimeout,

  /// 4: An error occurs in Agora's streaming server. Call the addPublishStreamUrl method to publish the streaming again.
  @JsonValue(4)
  rtmpStreamPublishErrorInternalServerError,

  /// 5: An error occurs in the CDN server.
  @JsonValue(5)
  rtmpStreamPublishErrorRtmpServerError,

  /// 6: Reserved parameter
  @JsonValue(6)
  rtmpStreamPublishErrorTooOften,

  /// 7: The host publishes more than 10 URLs. Delete the unnecessary URLs before adding new ones.
  @JsonValue(7)
  rtmpStreamPublishErrorReachLimit,

  /// 8: The host manipulates other hosts' URLs. For example, the host updates or stops other hosts' streams. Check your app logic.
  @JsonValue(8)
  rtmpStreamPublishErrorNotAuthorized,

  /// 9: Agora's server fails to find the RTMP or RTMPS streaming.
  @JsonValue(9)
  rtmpStreamPublishErrorStreamNotFound,

  /// 10: The format of the RTMP or RTMPS streaming URL is not supported. Check whether the URL format is correct.
  @JsonValue(10)
  rtmpStreamPublishErrorFormatNotSupported,

  /// 11: The user role is not host, so the user cannot use the CDN live streaming function. Check your app code logic.
  @JsonValue(11)
  rtmpStreamPublishErrorNotBroadcaster,

  /// 13: The updateRtmpTranscoding or setLiveTranscoding method is called to update the transcoding configuration in a scenario where there is streaming without transcoding. Check your app code logic.
  @JsonValue(13)
  rtmpStreamPublishErrorTranscodingNoMixStream,

  /// 14: Errors occurred in the host's network.
  @JsonValue(14)
  rtmpStreamPublishErrorNetDown,

  /// 15: Your App ID does not have permission to use the CDN live streaming function.
  @JsonValue(15)
  rtmpStreamPublishErrorInvalidAppid,

  /// 100: The streaming has been stopped normally. After you call removePublishStreamUrl to stop streaming, the SDK returns this value.
  @JsonValue(100)
  rtmpStreamUnpublishErrorOk,
}

/// Extensions functions of [RtmpStreamPublishErrorType].
extension RtmpStreamPublishErrorTypeExt on RtmpStreamPublishErrorType {
  /// @nodoc
  static RtmpStreamPublishErrorType fromValue(int value) {
    return $enumDecode(_$RtmpStreamPublishErrorTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$RtmpStreamPublishErrorTypeEnumMap[this]!;
  }
}

/// Events during the media push.
@JsonEnum(alwaysCreate: true)
enum RtmpStreamingEvent {
  /// 1: An error occurs when you add a background image or a watermark image in the media push.
  @JsonValue(1)
  rtmpStreamingEventFailedLoadImage,

  /// 2: The streaming URL is already being used for CDN live streaming.
  /// If you want to start new streaming, use a new streaming URL.
  @JsonValue(2)
  rtmpStreamingEventUrlAlreadyInUse,

  /// 3: The feature is not supported.
  @JsonValue(3)
  rtmpStreamingEventAdvancedFeatureNotSupport,

  /// 4: Reserved.
  @JsonValue(4)
  rtmpStreamingEventRequestTooOften,
}

/// Extensions functions of [RtmpStreamingEvent].
extension RtmpStreamingEventExt on RtmpStreamingEvent {
  /// @nodoc
  static RtmpStreamingEvent fromValue(int value) {
    return $enumDecode(_$RtmpStreamingEventEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$RtmpStreamingEventEnumMap[this]!;
  }
}

/// Image properties.
/// This class sets the properties of the watermark and background images in the live video.
@JsonSerializable(explicitToJson: true)
class RtcImage {
  /// Construct the [RtcImage].
  const RtcImage(
      {this.url,
      this.x,
      this.y,
      this.width,
      this.height,
      this.zOrder,
      this.alpha});

  /// The HTTP/HTTPS URL address of the image in the live video. The maximum length of this parameter is 1024 bytes.
  @JsonKey(name: 'url')
  final String? url;

  /// The x coordinate (pixel) of the image on the video frame (taking the upper left corner of the video frame as the origin).
  @JsonKey(name: 'x')
  final int? x;

  /// The y coordinate (pixel) of the image on the video frame (taking the upper left corner of the video frame as the origin).
  @JsonKey(name: 'y')
  final int? y;

  /// The width (pixel) of the image on the video frame.
  @JsonKey(name: 'width')
  final int? width;

  /// The height (pixel) of the image on the video frame.
  @JsonKey(name: 'height')
  final int? height;

  /// The layer index of the watermark or background image. When you use the watermark array to add a watermark or multiple watermarks, you must pass a value to zOrder in the range [1,255]; otherwise, the SDK reports an error. In other cases, zOrder can optionally be passed in the range [0,255], with 0 being the default value. 0 means the bottom layer and 255 means the top layer.
  @JsonKey(name: 'zOrder')
  final int? zOrder;

  /// The transparency of the watermark or background image. The value ranges between 0.0 and 1.0:
  /// 0.0: Completely transparent.
  /// 1.0: (Default) Opaque.
  @JsonKey(name: 'alpha')
  final double? alpha;

  /// @nodoc
  factory RtcImage.fromJson(Map<String, dynamic> json) =>
      _$RtcImageFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RtcImageToJson(this);
}

/// The configuration for advanced features of the RTMP or RTMPS streaming with transcoding.
/// If you want to enable the advanced features of streaming with transcoding, contact .
@JsonSerializable(explicitToJson: true)
class LiveStreamAdvancedFeature {
  /// Construct the [LiveStreamAdvancedFeature].
  const LiveStreamAdvancedFeature({this.featureName, this.opened});

  /// The feature names, including LBHQ (high-quality video with a lower bitrate) and VEO (optimized video encoder).
  @JsonKey(name: 'featureName')
  final String? featureName;

  /// Whether to enable the advanced features of streaming with transcoding:
  /// true: Enable the advanced features.
  /// false: (Default) Do not enable the advanced features.
  @JsonKey(name: 'opened')
  final bool? opened;

  /// @nodoc
  factory LiveStreamAdvancedFeature.fromJson(Map<String, dynamic> json) =>
      _$LiveStreamAdvancedFeatureFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LiveStreamAdvancedFeatureToJson(this);
}

/// Connection states.
@JsonEnum(alwaysCreate: true)
enum ConnectionStateType {
  /// 1: The SDK is disconnected from the Agora edge server. The state indicates the SDK is in one of the following phases:
  /// Theinitial state before calling the joinChannelWithOptions method.
  /// The app calls the leaveChannel method.
  @JsonValue(1)
  connectionStateDisconnected,

  /// 2: The SDK is connecting to the Agora edge server. This state indicates that the SDK is establishing a connection with the specified channel after the app calls joinChannelWithOptions.
  /// If the SDK successfully joins the channel, it triggers the onConnectionStateChanged callback and the connection state switches to connectionStateConnected.
  /// After the connection is established, the SDK also initializes the media and triggers onJoinChannelSuccess when everything is ready.
  @JsonValue(2)
  connectionStateConnecting,

  /// 3: The SDK is connected to the Agora edge server. This state also indicates that the user has joined a channel and can now publish or subscribe to a media stream in the channel. If the connection to the channel is lost because, for example, if the network is down or switched, the SDK automatically tries to reconnect and triggers:
  /// onConnectionStateChanged callback, notifying that the current network state becomes connectionStateReconnecting.
  @JsonValue(3)
  connectionStateConnected,

  /// 4: The SDK keeps reconnecting to the Agora edge server. The SDK keeps rejoining the channel after being disconnected from a joined channel because of network issues.
  /// If the SDK cannot rejoin the channel within 10 seconds, it triggers onConnectionLost , stays in the connectionStateReconnecting state, and keeps rejoining the channel.
  /// If the SDK fails to rejoin the channel 20 minutes after being disconnected from the Agora edge server, the SDK triggers the onConnectionStateChanged callback, switches to the connectionStateFailed state, and stops rejoining the channel.
  @JsonValue(4)
  connectionStateReconnecting,

  /// 5: The SDK fails to connect to the Agora edge server or join the channel. This state indicates that the SDK stops trying to rejoin the channel. You must call leaveChannel to leave the channel.
  /// You can call joinChannelWithOptions to rejoin the channel.
  /// If the SDK is banned from joining the channel by the Agora edge server through the RESTful API, the SDK triggers the onConnectionStateChanged callback.
  @JsonValue(5)
  connectionStateFailed,
}

/// Extensions functions of [ConnectionStateType].
extension ConnectionStateTypeExt on ConnectionStateType {
  /// @nodoc
  static ConnectionStateType fromValue(int value) {
    return $enumDecode(_$ConnectionStateTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$ConnectionStateTypeEnumMap[this]!;
  }
}

/// Transcoding configurations of each host.
@JsonSerializable(explicitToJson: true)
class TranscodingUser {
  /// Construct the [TranscodingUser].
  const TranscodingUser(
      {this.uid,
      this.x,
      this.y,
      this.width,
      this.height,
      this.zOrder,
      this.alpha,
      this.audioChannel});

  /// The user ID of the host.
  @JsonKey(name: 'uid')
  final int? uid;

  /// The x coordinate (pixel) of the host's video on the output video frame (taking the upper left corner of the video frame as the origin). The value range is [0, width], where width is thewidth set in LiveTranscoding .
  @JsonKey(name: 'x')
  final int? x;

  /// The y coordinate (pixel) of the host's video on the output video frame (taking the upper left corner of the video frame as the origin). The value range is [0, height], where height is the height set in LiveTranscoding .
  @JsonKey(name: 'y')
  final int? y;

  /// The width (pixel) of the host's video.
  @JsonKey(name: 'width')
  final int? width;

  /// The height (pixel) of the host's video.
  @JsonKey(name: 'height')
  final int? height;

  /// The number of the layer to which the video for the video mixing on the local client belongs. The value range is [0,100].
  /// 0: (Default) The layer is at the bottom.
  /// 100: The layer is at the top.
  /// If the value is less than 0 or greater than 100, the error ERR_INVALID_ARGUMENT is returned.
  /// Starting from v2.3, setting zOrder to 0 is supported.
  @JsonKey(name: 'zOrder')
  final int? zOrder;

  /// The transparency of the video for the video mixing on the local client. The value range is [0.0,1.0].
  /// 0.0: Completely transparent.
  /// 1.0: (Default) Opaque.
  @JsonKey(name: 'alpha')
  final double? alpha;

  /// The audio channel used by the host's audio in the output audio. The default value is 0, and the value range is [0, 5].
  /// 0: (Recommended) The defaut setting, which supports dual channels at most and depends on the upstream of the host.
  /// 1: The host's audio uses the FL audio channel. If the host's upstream uses multiple audio channels, the Agora server mixes them into mono first.
  /// 2: The host's audio uses the FC audio channel. If the host's upstream uses multiple audio channels, the Agora server mixes them into mono first.
  /// 3: The host's audio uses the FR audio channel. If the host's upstream uses multiple audio channels, the Agora server mixes them into mono first.
  /// 4: The host's audio uses the BL audio channel. If the host's upstream uses multiple audio channels, the Agora server mixes them into mono first.
  /// 5: The host's audio uses the BR audio channel. If the host's upstream uses multiple audio channels, the Agora server mixes them into mono first.
  /// 0xFF or a value greater than 5: The host's audio is muted, and the Agora server removes the host's audio. If the value is not 0, a special player is required.
  @JsonKey(name: 'audioChannel')
  final int? audioChannel;

  /// @nodoc
  factory TranscodingUser.fromJson(Map<String, dynamic> json) =>
      _$TranscodingUserFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$TranscodingUserToJson(this);
}

/// Transcoding configurations for Media Push.
@JsonSerializable(explicitToJson: true)
class LiveTranscoding {
  /// Construct the [LiveTranscoding].
  const LiveTranscoding(
      {this.width,
      this.height,
      this.videoBitrate,
      this.videoFramerate,
      this.lowLatency,
      this.videoGop,
      this.videoCodecProfile,
      this.backgroundColor,
      this.videoCodecType,
      this.userCount,
      this.transcodingUsers,
      this.transcodingExtraInfo,
      this.metadata,
      this.watermark,
      this.watermarkCount,
      this.backgroundImage,
      this.backgroundImageCount,
      this.audioSampleRate,
      this.audioBitrate,
      this.audioChannels,
      this.audioCodecProfile,
      this.advancedFeatures,
      this.advancedFeatureCount});

  /// The width of the video in pixels. The default value is 360. When pushing video streams to the CDN, the value range of width is [64,1920]. If the value is less than 64, Agora server automatically adjusts it to 64; if the value is greater than 1920, Agora server automatically adjusts it to 1920.
  /// When pushing audio streams to the CDN, set width and height as 0.
  @JsonKey(name: 'width')
  final int? width;

  /// The height of the video in pixels. The default value is 640. When pushing video streams to the CDN, the value range of height is [64,1080]. If the value is less than 64, Agora server automatically adjusts it to 64; if the value is greater than 1080, Agora server automatically adjusts it to 1080.
  /// When pushing audio streams to the CDN, set width and height as 0.
  @JsonKey(name: 'height')
  final int? height;

  /// Bitrate of the output video stream for Media Push in Kbps. The default value is 400 Kbps.
  @JsonKey(name: 'videoBitrate')
  final int? videoBitrate;

  /// @nodoc
  @JsonKey(name: 'videoFramerate')
  final int? videoFramerate;

  ///  Deprecated
  /// This parameter is deprecated. Latency mode: true: Low latency with unassured quality.
  /// false: (Default) High latency with assured quality.
  @JsonKey(name: 'lowLatency')
  final bool? lowLatency;

  /// GOP (Group of Pictures) in fps of the video frames for Media Push. The default value is 30.
  @JsonKey(name: 'videoGop')
  final int? videoGop;

  /// Video codec profile type for Media Push. Set it as 66, 77, or 100 (default). See VIDEO_CODEC_PROFILE_TYPE for details.
  /// If you set this parameter to any other value, Agora adjusts it to the default value.
  @JsonKey(name: 'videoCodecProfile')
  final VideoCodecProfileType? videoCodecProfile;

  /// The background color in RGB hex value. Value only. Do not include a preceeding #. For example, 0xFFB6C1 (light pink). The default value is 0x000000 (black).
  @JsonKey(name: 'backgroundColor')
  final int? backgroundColor;

  /// Video codec profile types for Media Push. See VideoCodecTypeForStream .
  @JsonKey(name: 'videoCodecType')
  final VideoCodecTypeForStream? videoCodecType;

  /// The number of users in the video mixing. The value range is [0,17].
  @JsonKey(name: 'userCount')
  final int? userCount;

  /// Manages the user layout configuration in the Media Push. Agora supports a maximum of 17 transcoding users in a Media Push channel. See TranscodingUser .
  @JsonKey(name: 'transcodingUsers')
  final List<TranscodingUser>? transcodingUsers;

  /// Reserved property. Extra user-defined information to send SEI for the H.264/H.265 video stream to the CDN client. Maximum length: 4096 bytes. For more information on SEI, see SEI-related questions.
  @JsonKey(name: 'transcodingExtraInfo')
  final String? transcodingExtraInfo;

  ///  Deprecated
  /// This parameter is deprecated. The metadata sent to the CDN client.
  @JsonKey(name: 'metadata')
  final String? metadata;

  /// The watermark on the live video. The image format needs to be PNG. See RtcImage .
  /// You can add one watermark, or add multiple watermarks using an array.
  @JsonKey(name: 'watermark')
  final List<RtcImage>? watermark;

  /// The number of watermarks on the live video. The total number of watermarks and background images can range from 0 to 10. This parameter is used with watermark.
  @JsonKey(name: 'watermarkCount')
  final int? watermarkCount;

  /// The number of background images on the live video. The image format needs to be PNG. See RtcImage .
  /// You can add a background image or use an array to add multiple background images. This parameter is used with backgroundImageCount.
  @JsonKey(name: 'backgroundImage')
  final List<RtcImage>? backgroundImage;

  /// The number of background images on the live video. The total number of watermarks and background images can range from 0 to 10. This parameter is used with backgroundImage.
  @JsonKey(name: 'backgroundImageCount')
  final int? backgroundImageCount;

  /// The audio sampling rate (Hz) of the output media stream. See AudioSampleRateType .
  @JsonKey(name: 'audioSampleRate')
  final AudioSampleRateType? audioSampleRate;

  /// Bitrate (Kbps) of the audio output stream for Media Push. The default value is 48, and the highest value is 128.
  @JsonKey(name: 'audioBitrate')
  final int? audioBitrate;

  /// The number of audio channels for Media Push. Agora recommends choosing 1 (mono), or 2 (stereo) audio channels. Special players are required if you choose 3, 4, or 5. 1: (Default) Mono.
  /// 2: Stereo.
  /// 3: Three audio channels.
  /// 4: Four audio channels.
  /// 5: Five audio channels.
  @JsonKey(name: 'audioChannels')
  final int? audioChannels;

  /// Audio codec profile type for Media Push. See AudioCodecProfileType .
  @JsonKey(name: 'audioCodecProfile')
  final AudioCodecProfileType? audioCodecProfile;

  /// Advanced features of the Media Push with transcoding. See LiveStreamAdvancedFeature .
  @JsonKey(name: 'advancedFeatures')
  final List<LiveStreamAdvancedFeature>? advancedFeatures;

  /// The number of enabled advanced features. The default value is 0.
  @JsonKey(name: 'advancedFeatureCount')
  final int? advancedFeatureCount;

  /// @nodoc
  factory LiveTranscoding.fromJson(Map<String, dynamic> json) =>
      _$LiveTranscodingFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LiveTranscodingToJson(this);
}

/// The video streams for the video mixing on the local client.
@JsonSerializable(explicitToJson: true)
class TranscodingVideoStream {
  /// Construct the [TranscodingVideoStream].
  const TranscodingVideoStream(
      {this.sourceType,
      this.remoteUserUid,
      this.imageUrl,
      this.x,
      this.y,
      this.width,
      this.height,
      this.zOrder,
      this.alpha,
      this.mirror});

  /// The source type of video for the video mixing on the local client. See VideoSourceType .
  @JsonKey(name: 'sourceType')
  final MediaSourceType? sourceType;

  /// The ID of the remote user.Use this parameter only when the source type of the video for the video mixingonthe local client is videoSourceRemote.
  @JsonKey(name: 'remoteUserUid')
  final int? remoteUserUid;

  /// The URL of the image.Use this parameter only when the source type of the video for the video mixing on the local client is
  @JsonKey(name: 'imageUrl')
  final String? imageUrl;

  /// The horizontal displacement of the top-left corner of the video for the video mixing on the client relative to the top-left corner (origin) of the canvas for this video mixing.
  @JsonKey(name: 'x')
  final int? x;

  /// The vertical displacement of the top-left corner of the video for the video mixing on the client relative to the top-left corner (origin) of the canvas for this video mixing.
  @JsonKey(name: 'y')
  final int? y;

  /// The width (px) of the video for the video mixing on the local client.
  @JsonKey(name: 'width')
  final int? width;

  /// The height (px) of the video for the video mixing on the local client.
  @JsonKey(name: 'height')
  final int? height;

  /// The number of the layer to which the video for the video mixing on the local client belongs. The value range is [0,100].
  /// 0: (Default) The layer is at the bottom.
  /// 100: The layer is at the top.
  @JsonKey(name: 'zOrder')
  final int? zOrder;

  /// The transparency of the video for the video mixing on the local client. The value range is [0.0,1.0]. 0.0 means the transparency is completely transparent. 1.0 means the transparency is opaque.
  @JsonKey(name: 'alpha')
  final double? alpha;

  /// Whether to mirror the video for the video mixing on the local client.
  /// true: Mirror the captured video.
  /// false: (Default) Do not mirror the captured video. The paramter only works for videos with the source type CAMERA
  @JsonKey(name: 'mirror')
  final bool? mirror;

  /// @nodoc
  factory TranscodingVideoStream.fromJson(Map<String, dynamic> json) =>
      _$TranscodingVideoStreamFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$TranscodingVideoStreamToJson(this);
}

/// The configuration of the video mixing on the local client.
@JsonSerializable(explicitToJson: true)
class LocalTranscoderConfiguration {
  /// Construct the [LocalTranscoderConfiguration].
  const LocalTranscoderConfiguration(
      {this.streamCount,
      this.videoInputStreams,
      this.videoOutputConfiguration});

  /// The number of the video streams for the video mixing on the local client.
  @JsonKey(name: 'streamCount')
  final int? streamCount;

  /// The video streams for the video mixing on the local client. See TranscodingVideoStream .
  @JsonKey(name: 'VideoInputStreams')
  final List<TranscodingVideoStream>? videoInputStreams;

  /// The encoding configuration of the mixed video stream after the video mixing on the local client. See VideoEncoderConfiguration .
  @JsonKey(name: 'videoOutputConfiguration')
  final VideoEncoderConfiguration? videoOutputConfiguration;

  /// @nodoc
  factory LocalTranscoderConfiguration.fromJson(Map<String, dynamic> json) =>
      _$LocalTranscoderConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LocalTranscoderConfigurationToJson(this);
}

/// Configurations of the last-mile network test.
@JsonSerializable(explicitToJson: true)
class LastmileProbeConfig {
  /// Construct the [LastmileProbeConfig].
  const LastmileProbeConfig(
      {this.probeUplink,
      this.probeDownlink,
      this.expectedUplinkBitrate,
      this.expectedDownlinkBitrate});

  /// Sets whether to test the uplink network. Some users, for example, the audience members in a LIVE_BROADCASTING channel, do not need such a test.
  /// true: Test.
  /// false: Not test.
  @JsonKey(name: 'probeUplink')
  final bool? probeUplink;

  /// Sets whether to test the downlink network:
  /// true: Test.
  /// false: Not test.
  @JsonKey(name: 'probeDownlink')
  final bool? probeDownlink;

  /// The expected maximum uplink bitrate (bps) of the local user. The value range is [100000, 5000000]. Agora recommends setVideoEncoderConfiguration referring to to set the value.
  @JsonKey(name: 'expectedUplinkBitrate')
  final int? expectedUplinkBitrate;

  /// The expected maximum downlink bitrate (bps) of the local user. The value range is [100000,5000000].
  @JsonKey(name: 'expectedDownlinkBitrate')
  final int? expectedDownlinkBitrate;

  /// @nodoc
  factory LastmileProbeConfig.fromJson(Map<String, dynamic> json) =>
      _$LastmileProbeConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LastmileProbeConfigToJson(this);
}

/// The status of the last-mile probe test.
@JsonEnum(alwaysCreate: true)
enum LastmileProbeResultState {
  /// 1: The last-mile network probe test is complete.
  @JsonValue(1)
  lastmileProbeResultComplete,

  /// 2: The last-mile network probe test is incomplete because the bandwidth estimation is not available due to limited test resources. One possible reason is that testing resources are temporarily limited.
  @JsonValue(2)
  lastmileProbeResultIncompleteNoBwe,

  /// 3: The last-mile network probe test is not carried out. Probably due to poor network conditions.
  @JsonValue(3)
  lastmileProbeResultUnavailable,
}

/// Extensions functions of [LastmileProbeResultState].
extension LastmileProbeResultStateExt on LastmileProbeResultState {
  /// @nodoc
  static LastmileProbeResultState fromValue(int value) {
    return $enumDecode(_$LastmileProbeResultStateEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$LastmileProbeResultStateEnumMap[this]!;
  }
}

/// Results of the uplink or downlink last-mile network test.
@JsonSerializable(explicitToJson: true)
class LastmileProbeOneWayResult {
  /// Construct the [LastmileProbeOneWayResult].
  const LastmileProbeOneWayResult(
      {this.packetLossRate, this.jitter, this.availableBandwidth});

  /// The packet loss rate (%).
  @JsonKey(name: 'packetLossRate')
  final int? packetLossRate;

  /// The network jitter (ms).
  @JsonKey(name: 'jitter')
  final int? jitter;

  /// The estimated available bandwidth (bps).
  @JsonKey(name: 'availableBandwidth')
  final int? availableBandwidth;

  /// @nodoc
  factory LastmileProbeOneWayResult.fromJson(Map<String, dynamic> json) =>
      _$LastmileProbeOneWayResultFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LastmileProbeOneWayResultToJson(this);
}

/// Results of the uplink and downlink last-mile network tests.
@JsonSerializable(explicitToJson: true)
class LastmileProbeResult {
  /// Construct the [LastmileProbeResult].
  const LastmileProbeResult(
      {this.state, this.uplinkReport, this.downlinkReport, this.rtt});

  /// The status of the last-mile probe test. See LastmileProbeResultState .
  @JsonKey(name: 'state')
  final LastmileProbeResultState? state;

  /// Results of the uplink last-mile network test. See LastmileProbeOneWayResult .
  @JsonKey(name: 'uplinkReport')
  final LastmileProbeOneWayResult? uplinkReport;

  /// Results of the downlink last-mile network test. See LastmileProbeOneWayResult .
  @JsonKey(name: 'downlinkReport')
  final LastmileProbeOneWayResult? downlinkReport;

  /// The round-trip time (ms).
  @JsonKey(name: 'rtt')
  final int? rtt;

  /// @nodoc
  factory LastmileProbeResult.fromJson(Map<String, dynamic> json) =>
      _$LastmileProbeResultFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LastmileProbeResultToJson(this);
}

/// Reasons causing the change of the connection state.
@JsonEnum(alwaysCreate: true)
enum ConnectionChangedReasonType {
  /// 0: The SDK is connecting to the Agora edge server.
  @JsonValue(0)
  connectionChangedConnecting,

  /// 1: The SDK has joined the channel successfully.
  @JsonValue(1)
  connectionChangedJoinSuccess,

  /// 2: The connection between the SDK and the Agora edge server is interrupted.
  @JsonValue(2)
  connectionChangedInterrupted,

  /// 3: The connection between the SDK and the Agora edge server is banned by the Agora edge server. This error occurs when the user is kicked out of the channel by the server.
  @JsonValue(3)
  connectionChangedBannedByServer,

  /// 4: The SDK fails to join the channel. When the SDK fails to join the channel for more than 20 minutes, this error occurs and the SDK stops reconnecting to the channel.
  @JsonValue(4)
  connectionChangedJoinFailed,

  /// 5: The SDK has left the channel.
  @JsonValue(5)
  connectionChangedLeaveChannel,

  /// 6: The connection failed because the App ID is not valid. Please rejoin the channel with a valid App ID.
  @JsonValue(6)
  connectionChangedInvalidAppId,

  /// 7: The connection failed since channel name is not valid. Please rejoin the channel with a valid channel name.
  @JsonValue(7)
  connectionChangedInvalidChannelName,

  /// 8: The connection failed because the token is not valid. Typical reasons include:
  /// The App Certificate for the project is enabled in Agora Console, but you do not use a token when joining the channel. If you enable the App Certificate, you must use a token to join the channel.
  /// Theuid specified when calling joinChannelWithOptions to join the channel is inconsistent with the uid passed in when generating the token.
  @JsonValue(8)
  connectionChangedInvalidToken,

  /// 9: The connection failed since token is expired.
  @JsonValue(9)
  connectionChangedTokenExpired,

  /// 10: The connection is rejected by server. Typical reasons include:
  /// The user is already in the channel and still calls a method, for example,joinChannelWithOptions, to join the channel. Stop calling this method to clear this error.
  /// The user tries to join the channel when calling for a call test. The user needs to call the channel after the call test ends.
  @JsonValue(10)
  connectionChangedRejectedByServer,

  /// 11: The connection state changed to reconnecting because the SDK has set a proxy server.
  @JsonValue(11)
  connectionChangedSettingProxyServer,

  /// 12: The connection state changed because the token is renewed.
  @JsonValue(12)
  connectionChangedRenewToken,

  /// 13: The IP address of the client has changed, possibly because the network type, IP address, or port has been changed.
  @JsonValue(13)
  connectionChangedClientIpAddressChanged,

  /// 14: Timeout for the keep-alive of the connection between the SDK and the Agora edge server. The connection state changes to .
  @JsonValue(14)
  connectionChangedKeepAliveTimeout,

  /// @nodoc
  @JsonValue(15)
  connectionChangedRejoinSuccess,

  /// @nodoc
  @JsonValue(16)
  connectionChangedLost,

  /// @nodoc
  @JsonValue(17)
  connectionChangedEchoTest,

  /// @nodoc
  @JsonValue(18)
  connectionChangedClientIpAddressChangedByUser,

  /// @nodoc
  @JsonValue(19)
  connectionChangedSameUidLogin,

  /// @nodoc
  @JsonValue(20)
  connectionChangedTooManyBroadcasters,
}

/// Extensions functions of [ConnectionChangedReasonType].
extension ConnectionChangedReasonTypeExt on ConnectionChangedReasonType {
  /// @nodoc
  static ConnectionChangedReasonType fromValue(int value) {
    return $enumDecode(_$ConnectionChangedReasonTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$ConnectionChangedReasonTypeEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum ClientRoleChangeFailedReason {
  /// @nodoc
  @JsonValue(1)
  clientRoleChangeFailedTooManyBroadcasters,

  /// @nodoc
  @JsonValue(2)
  clientRoleChangeFailedNotAuthorized,

  /// @nodoc
  @JsonValue(3)
  clientRoleChangeFailedRequestTimeOut,

  /// @nodoc
  @JsonValue(4)
  clientRoleChangeFailedConnectionFailed,
}

/// Extensions functions of [ClientRoleChangeFailedReason].
extension ClientRoleChangeFailedReasonExt on ClientRoleChangeFailedReason {
  /// @nodoc
  static ClientRoleChangeFailedReason fromValue(int value) {
    return $enumDecode(_$ClientRoleChangeFailedReasonEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$ClientRoleChangeFailedReasonEnumMap[this]!;
  }
}

/// Network types.
@JsonEnum(alwaysCreate: true)
enum NetworkType {
  /// -1: The network type is unknown.</pd>
  @JsonValue(-1)
  networkTypeUnknown,

  /// 0: The SDK disconnects from the network.
  @JsonValue(0)
  networkTypeDisconnected,

  /// 1: The network type is LAN.
  @JsonValue(1)
  networkTypeLan,

  /// 2: The network type is Wi-Fi (including hotspots).
  @JsonValue(2)
  networkTypeWifi,

  /// 3: The network type is mobile 2G.
  @JsonValue(3)
  networkTypeMobile2g,

  /// 4: The network type is mobile 3G.
  @JsonValue(4)
  networkTypeMobile3g,

  /// 5: The network type is mobile 4G.
  @JsonValue(5)
  networkTypeMobile4g,
}

/// Extensions functions of [NetworkType].
extension NetworkTypeExt on NetworkType {
  /// @nodoc
  static NetworkType fromValue(int value) {
    return $enumDecode(_$NetworkTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$NetworkTypeEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum VideoViewSetupMode {
  /// @nodoc
  @JsonValue(0)
  videoViewSetupReplace,

  /// @nodoc
  @JsonValue(1)
  videoViewSetupAdd,

  /// @nodoc
  @JsonValue(2)
  videoViewSetupRemove,
}

/// Extensions functions of [VideoViewSetupMode].
extension VideoViewSetupModeExt on VideoViewSetupMode {
  /// @nodoc
  static VideoViewSetupMode fromValue(int value) {
    return $enumDecode(_$VideoViewSetupModeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$VideoViewSetupModeEnumMap[this]!;
  }
}

/// Attributes of video canvas object.
@JsonSerializable(explicitToJson: true)
class VideoCanvas {
  /// Construct the [VideoCanvas].
  const VideoCanvas(
      {this.view,
      this.renderMode,
      this.mirrorMode,
      this.uid,
      this.isScreenView,
      this.priv,
      this.privSize,
      this.sourceType,
      this.cropArea,
      this.setupMode});

  /// Video display window.
  @JsonKey(name: 'view')
  final int? view;

  /// The rendering mode of the video. See RenderModeType .
  @JsonKey(name: 'renderMode')
  final RenderModeType? renderMode;

  /// The mirror mode of the view. See VideoMirrorModeType . For the mirror mode of the local video view: If you use a front camera, the SDK enables the mirror mode by default; if you use a rear camera, the SDK disables the mirror mode by default.
  /// For the remote user: The mirror mode is disabled by default.
  @JsonKey(name: 'mirrorMode')
  final VideoMirrorModeType? mirrorMode;

  /// The user ID.
  @JsonKey(name: 'uid')
  final int? uid;

  /// @nodoc
  @JsonKey(name: 'isScreenView')
  final bool? isScreenView;

  /// @nodoc
  @JsonKey(name: 'priv', ignore: true)
  final Uint8List? priv;

  /// @nodoc
  @JsonKey(name: 'priv_size')
  final int? privSize;

  /// The type of the video source, see VideoSourceType .
  @JsonKey(name: 'sourceType')
  final VideoSourceType? sourceType;

  /// @nodoc
  @JsonKey(name: 'cropArea')
  final Rectangle? cropArea;

  /// @nodoc
  @JsonKey(name: 'setupMode')
  final VideoViewSetupMode? setupMode;

  /// @nodoc
  factory VideoCanvas.fromJson(Map<String, dynamic> json) =>
      _$VideoCanvasFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$VideoCanvasToJson(this);
}

/// Image enhancement options.
@JsonSerializable(explicitToJson: true)
class BeautyOptions {
  /// Construct the [BeautyOptions].
  const BeautyOptions(
      {this.lighteningContrastLevel,
      this.lighteningLevel,
      this.smoothnessLevel,
      this.rednessLevel,
      this.sharpnessLevel});

  /// The contrast level, used with the lighteningLevel parameter. The larger the value, the greater the contrast between light and dark. See LighteningContrastLevel .
  @JsonKey(name: 'lighteningContrastLevel')
  final LighteningContrastLevel? lighteningContrastLevel;

  /// The brightness level. The value ranges from 0.0 (original) to 1.0. The default value is 0.0. The greater the value, the greater the degree of whitening.
  @JsonKey(name: 'lighteningLevel')
  final double? lighteningLevel;

  /// The value ranges from 0.0 (original) to 1.0. The default value is 0.0. The greater the value, the greater the degree of skin grinding.
  @JsonKey(name: 'smoothnessLevel')
  final double? smoothnessLevel;

  /// The redness level. The value ranges from 0.0 (original) to 1.0. The default value is 0.0. The larger the value, the greater the rosy degree.
  @JsonKey(name: 'rednessLevel')
  final double? rednessLevel;

  /// The sharpness level. The value ranges from 0.0 (original) to 1.0. The default value is 0.0. The larger the value, the greater the sharpening degree.
  @JsonKey(name: 'sharpnessLevel')
  final double? sharpnessLevel;

  /// @nodoc
  factory BeautyOptions.fromJson(Map<String, dynamic> json) =>
      _$BeautyOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$BeautyOptionsToJson(this);
}

/// The contrast level.
@JsonEnum(alwaysCreate: true)
enum LighteningContrastLevel {
  /// Low contrast level.
  @JsonValue(0)
  lighteningContrastLow,

  /// Normal contrast level.
  @JsonValue(1)
  lighteningContrastNormal,

  /// High contrast level.
  @JsonValue(2)
  lighteningContrastHigh,
}

/// Extensions functions of [LighteningContrastLevel].
extension LighteningContrastLevelExt on LighteningContrastLevel {
  /// @nodoc
  static LighteningContrastLevel fromValue(int value) {
    return $enumDecode(_$LighteningContrastLevelEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$LighteningContrastLevelEnumMap[this]!;
  }
}

/// The custom background image.
@JsonSerializable(explicitToJson: true)
class VirtualBackgroundSource {
  /// Construct the [VirtualBackgroundSource].
  const VirtualBackgroundSource(
      {this.backgroundSourceType, this.color, this.source, this.blurDegree});

  /// The type of the custom background image. See backgroundSourceType .
  @JsonKey(name: 'background_source_type')
  final BackgroundSourceType? backgroundSourceType;

  /// The color of the custom background image. The format is a hexadecimal integer defined by RGB, without the # sign, such as 0xFFB6C1 for light pink. The default value is 0xFFFFFF, which signifies white. The value range is [0x000000, 0xffffff]. If the value is invalid, the SDK replaces the original background image with a white background image.This parameter takes effect only when the type of the custom background image is backgroundColor.
  @JsonKey(name: 'color')
  final int? color;

  ///
  @JsonKey(name: 'source')
  final String? source;

  /// @nodoc
  @JsonKey(name: 'blur_degree')
  final BackgroundBlurDegree? blurDegree;

  /// @nodoc
  factory VirtualBackgroundSource.fromJson(Map<String, dynamic> json) =>
      _$VirtualBackgroundSourceFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$VirtualBackgroundSourceToJson(this);
}

/// The type of the custom background image.
@JsonEnum(alwaysCreate: true)
enum BackgroundSourceType {
  /// 1: (Default) The background image is a solid color.
  @JsonValue(1)
  backgroundColor,

  /// The background image is a file in PNG or JPG format.
  @JsonValue(2)
  backgroundImg,

  /// The background image is the blurred background.
  @JsonValue(3)
  backgroundBlur,
}

/// Extensions functions of [BackgroundSourceType].
extension BackgroundSourceTypeExt on BackgroundSourceType {
  /// @nodoc
  static BackgroundSourceType fromValue(int value) {
    return $enumDecode(_$BackgroundSourceTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$BackgroundSourceTypeEnumMap[this]!;
  }
}

/// The degree of blurring applied to the custom background image.
@JsonEnum(alwaysCreate: true)
enum BackgroundBlurDegree {
  /// 1: The degree of blurring applied to the custom background image is low. The user can almost see the background clearly.
  @JsonValue(1)
  blurDegreeLow,

  /// The degree of blurring applied to the custom background image is medium. It is difficult for the user to recognize details in the background.
  @JsonValue(2)
  blurDegreeMedium,

  /// (Default) The degree of blurring applied to the custom background image is high. The user can barely see any distinguishing features in the background.
  @JsonValue(3)
  blurDegreeHigh,
}

/// Extensions functions of [BackgroundBlurDegree].
extension BackgroundBlurDegreeExt on BackgroundBlurDegree {
  /// @nodoc
  static BackgroundBlurDegree fromValue(int value) {
    return $enumDecode(_$BackgroundBlurDegreeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$BackgroundBlurDegreeEnumMap[this]!;
  }
}

/// @nodoc
@JsonSerializable(explicitToJson: true)
class FishCorrectionParams {
  /// Construct the [FishCorrectionParams].
  const FishCorrectionParams(
      {this.xCenter,
      this.yCenter,
      this.scaleFactor,
      this.focalLength,
      this.polFocalLength,
      this.splitHeight,
      this.ss});

  /// @nodoc
  @JsonKey(name: '_x_center')
  final double? xCenter;

  /// @nodoc
  @JsonKey(name: '_y_center')
  final double? yCenter;

  /// @nodoc
  @JsonKey(name: '_scale_factor')
  final double? scaleFactor;

  /// @nodoc
  @JsonKey(name: '_focal_length')
  final double? focalLength;

  /// @nodoc
  @JsonKey(name: '_pol_focal_length')
  final double? polFocalLength;

  /// @nodoc
  @JsonKey(name: '_split_height')
  final double? splitHeight;

  /// @nodoc
  @JsonKey(name: '_ss')
  final List<double>? ss;

  /// @nodoc
  factory FishCorrectionParams.fromJson(Map<String, dynamic> json) =>
      _$FishCorrectionParamsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$FishCorrectionParamsToJson(this);
}

/// The options for SDK preset voice beautifier effects.
@JsonEnum(alwaysCreate: true)
enum VoiceBeautifierPreset {
  /// Turn off voice beautifier effects and use the original voice.
  @JsonValue(0x00000000)
  voiceBeautifierOff,

  /// A more magnetic voice.
  /// Agora recommends using this enumerator to process a male-sounding voice; otherwise, you may experience vocal distortion.
  @JsonValue(0x01010100)
  chatBeautifierMagnetic,

  /// A fresher voice.
  /// Agora recommends using this enumerator to process a female-sounding voice; otherwise, you may experience vocal distortion.
  @JsonValue(0x01010200)
  chatBeautifierFresh,

  /// A more vital voice.
  /// Agora recommends using this enumerator to process a female-sounding voice; otherwise, you may experience vocal distortion.
  @JsonValue(0x01010300)
  chatBeautifierVitality,

  /// Singing beautifier effect. If you call setVoiceBeautifierPreset (singingBeautifier), you can beautify a male-sounding voice and add a reverberation effect that sounds like singing in a small room. Agora recommends using this enumerator to process a male-sounding voice; otherwise, you might experience vocal distortion.
  /// If you call setVoiceBeautifierParameters (singingBeautifier, param1, param2), you can beautify a male- or female-sounding voice and add a reverberation effect.
  @JsonValue(0x01020100)
  singingBeautifier,

  /// A more vigorous voice.
  @JsonValue(0x01030100)
  timbreTransformationVigorous,

  /// A deep voice.
  @JsonValue(0x01030200)
  timbreTransformationDeep,

  /// A mellower voice.
  @JsonValue(0x01030300)
  timbreTransformationMellow,

  /// Falsetto.
  @JsonValue(0x01030400)
  timbreTransformationFalsetto,

  /// A fuller voice.
  @JsonValue(0x01030500)
  timbreTransformationFull,

  /// A clearer voice.
  @JsonValue(0x01030600)
  timbreTransformationClear,

  /// A more resounding voice.
  @JsonValue(0x01030700)
  timbreTransformationResounding,

  /// A more ringing voice.
  @JsonValue(0x01030800)
  timbreTransformationRinging,

  /// A ultra-high quality voice, which makes the audio clearer and restores more details.
  /// To achieve better audio effect quality, Agora recommends that you set the profile of setAudioProfile2 audioProfileMusicHighQuality (4) or audioProfileMusicHighQualityStereo (5) and scenario to audioScenarioHighDefinition(6) before calling setVoiceBeautifierPreset .
  /// If you have an audio capturing device that can already restore audio details to a high degree, Agora recommends that you do not enable ultra-high quality; otherwise, the SDK may over-restore audio details, and you may not hear the anticipated voice effect.
  @JsonValue(0x01040100)
  ultraHighQualityVoice,
}

/// Extensions functions of [VoiceBeautifierPreset].
extension VoiceBeautifierPresetExt on VoiceBeautifierPreset {
  /// @nodoc
  static VoiceBeautifierPreset fromValue(int value) {
    return $enumDecode(_$VoiceBeautifierPresetEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$VoiceBeautifierPresetEnumMap[this]!;
  }
}

/// Preset voice effects.
/// For better voice effects, Agora recommends settingthe profile parameter of setAudioProfile to audioProfileMusicHighQuality or audioProfileMusicHighQualityStereo before using the following presets: roomAcousticsKtv
/// roomAcousticsVocalConcert
/// roomAcousticsStudio
/// roomAcousticsPhonograph
/// roomAcousticsSpacial
/// roomAcousticsEthereal
/// voiceChangerEffectUncle
/// voiceChangerEffectOldman
/// voiceChangerEffectBoy
/// voiceChangerEffectSister
/// voiceChangerEffectGirl
/// voiceChangerEffectPigking
/// voiceChangerEffectHulk
/// pitchCorrection
@JsonEnum(alwaysCreate: true)
enum AudioEffectPreset {
  /// Turn off voice effects, that is, use the original voice.
  @JsonValue(0x00000000)
  audioEffectOff,

  /// The voice effect typical of a KTV venue.
  @JsonValue(0x02010100)
  roomAcousticsKtv,

  /// The voice effect typical of a concert hall.
  @JsonValue(0x02010200)
  roomAcousticsVocalConcert,

  /// The voice effect typical of a recording studio.
  @JsonValue(0x02010300)
  roomAcousticsStudio,

  /// The voice effect typical of a vintage phonograph.
  @JsonValue(0x02010400)
  roomAcousticsPhonograph,

  /// The virtual stereo effect, which renders monophonic audio as stereo audio.
  /// Before using this preset, set the profile parameter of setAudioProfile to audioProfileMusicHighQuality or audioProfileMusicHighQualityStereo; otherwise, the preset setting is invalid.
  @JsonValue(0x02010500)
  roomAcousticsVirtualStereo,

  /// A more spatial voice effect.
  @JsonValue(0x02010600)
  roomAcousticsSpacial,

  /// A more ethereal voice effect.
  @JsonValue(0x02010700)
  roomAcousticsEthereal,

  /// A 3D voice effect that makes the voice appear to be moving around the user. The default movement cycle is 10 seconds. After setting this effect, you can call to setAudioEffectParameters modify the movement period. Before using this preset, set the profile parameter of setAudioProfile to audioProfileMusicStandardStereo or audioProfileMusicHighQualityStereo; otherwise, the preset setting is invalid.
  /// If the 3D voice effect is enabled, users need to use stereo audio playback devices to hear the anticipated voice effect.
  @JsonValue(0x02010800)
  roomAcoustics3dVoice,

  /// A middle-aged man's voice.
  /// Agora recommends using this preset to process a male-sounding voice; otherwise, you may not hear the anticipated voice effect.
  @JsonValue(0x02020100)
  voiceChangerEffectUncle,

  /// A senior man's voice.
  /// Agora recommends using this preset to process a male-sounding voice; otherwise, you may not hear the anticipated voice effect.
  @JsonValue(0x02020200)
  voiceChangerEffectOldman,

  /// A boy's voice.
  /// Agora recommends using this preset to process a male-sounding voice; otherwise, you may not hear the anticipated voice effect.
  @JsonValue(0x02020300)
  voiceChangerEffectBoy,

  /// A young woman's voice.
  /// Agora recommends using this preset to process a female-sounding voice; otherwise, you may not hear the anticipated voice effect.
  @JsonValue(0x02020400)
  voiceChangerEffectSister,

  /// A girl's voice.
  /// Agora recommends using this preset to process a female-sounding voice; otherwise, you may not hear the anticipated voice effect.
  @JsonValue(0x02020500)
  voiceChangerEffectGirl,

  /// The voice of Pig King, a character in Journey to the West who has a voice like a growling bear.
  @JsonValue(0x02020600)
  voiceChangerEffectPigking,

  /// The Hulk's voice.
  @JsonValue(0x02020700)
  voiceChangerEffectHulk,

  /// The voice effect typical of R&B music.
  /// Before using this preset, set the profile parameter of setAudioProfile to audioProfileMusicHighQuality or audioProfileMusicHighQualityStereo; otherwise, the preset setting is invalid.
  @JsonValue(0x02030100)
  styleTransformationRnb,

  /// The voice effect typical of popular music.
  /// Before using this preset, set the profile parameter of setAudioProfile to audioProfileMusicHighQuality or audioProfileMusicHighQualityStereo; otherwise, the preset setting is invalid.
  @JsonValue(0x02030200)
  styleTransformationPopular,

  /// A pitch correction effect that corrects the user's pitch based on the pitch of the natural C major scale. After setting this voice effect, you can call setAudioEffectParameters to adjust the basic mode of tuning and the pitch of the main tone.
  @JsonValue(0x02040100)
  pitchCorrection,
}

/// Extensions functions of [AudioEffectPreset].
extension AudioEffectPresetExt on AudioEffectPreset {
  /// @nodoc
  static AudioEffectPreset fromValue(int value) {
    return $enumDecode(_$AudioEffectPresetEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$AudioEffectPresetEnumMap[this]!;
  }
}

/// The options for SDK preset voice conversion effects.
@JsonEnum(alwaysCreate: true)
enum VoiceConversionPreset {
  /// Turn off voice conversion effects and use the original voice.
  @JsonValue(0x00000000)
  voiceConversionOff,

  /// A gender-neutral voice. To avoid audio distortion, ensure that you use this enumerator to process a female-sounding voice.
  @JsonValue(0x03010100)
  voiceChangerNeutral,

  /// A sweet voice. To avoid audio distortion, ensure that you use this enumerator to process a female-sounding voice.
  @JsonValue(0x03010200)
  voiceChangerSweet,

  /// A steady voice. To avoid audio distortion, ensure that you use this enumerator to process a male-sounding voice.
  @JsonValue(0x03010300)
  voiceChangerSolid,

  /// A deep voice. To avoid audio distortion, ensure that you use this enumerator to process a male-sounding voice.
  @JsonValue(0x03010400)
  voiceChangerBass,
}

/// Extensions functions of [VoiceConversionPreset].
extension VoiceConversionPresetExt on VoiceConversionPreset {
  /// @nodoc
  static VoiceConversionPreset fromValue(int value) {
    return $enumDecode(_$VoiceConversionPresetEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$VoiceConversionPresetEnumMap[this]!;
  }
}

/// Screen sharing configurations.
@JsonSerializable(explicitToJson: true)
class ScreenCaptureParameters {
  /// Construct the [ScreenCaptureParameters].
  const ScreenCaptureParameters(
      {this.dimensions,
      this.frameRate,
      this.bitrate,
      this.captureMouseCursor,
      this.windowFocus,
      this.excludeWindowList,
      this.excludeWindowCount});

  /// The maximum dimensions of encoding the shared region.  The default value is 1920 x 1080, that is, 2,073,600 pixels. Agora uses the value of this parameter to calculate the charges. VideoDimensions
  /// If the aspect ratio is different between the encoding dimensions and screen dimensions, Agora applies the following algorithms for encoding. Suppose dimensions are 1920 x 1080:
  /// If the value of the screen dimensions is lower than that of dimensions, for example, 1000 x 1000 pixels, the SDK uses 1000 x 1000 pixels for encoding.
  /// If the value of the screen dimensions is higher than that of dimensions, for example, 2000 x 1500, the SDK uses the maximum value under dimensions with the aspect ratio of the screen dimension (4:3) for encoding, that is, 1440 x 1080.
  @JsonKey(name: 'dimensions')
  final VideoDimensions? dimensions;

  /// On Windows and macOS, it represents the video encoding frame rate (fps) of the shared screen stream. The frame rate (fps) of the shared region. The default value is 5. We do not recommend setting this to a value greater than 15.
  @JsonKey(name: 'frameRate')
  final int? frameRate;

  /// On Windows and macOS, it represents the video encoding bitrate of the shared screen stream. The bitrate (Kbps) of the shared region. The default value is 0 (the SDK works out a bitrate according to the dimensions of the current screen).
  @JsonKey(name: 'bitrate')
  final int? bitrate;

  /// Whether to capture the mouse in screen sharing:
  /// true: (Default) Capture the mouse.
  /// false: Do not capture the mouse.
  @JsonKey(name: 'captureMouseCursor')
  final bool? captureMouseCursor;

  ///  startScreenCaptureByWindowId Whether to bring the window to the front when calling the method to share it:
  /// true:Bring the window to the front.
  /// false: (Default) Do not bring the window to the front.
  @JsonKey(name: 'windowFocus')
  final bool? windowFocus;

  /// A list of IDs of windows to be blocked. When calling startScreenCaptureByScreenRect to start screen sharing, you can use this parameter to block a specified window. When calling to updateScreenCaptureParameters update screen sharing configurations, you can use this parameter to dynamically block the specified windows during screen sharing.
  @JsonKey(name: 'excludeWindowList')
  final List<int>? excludeWindowList;

  /// The number of windows to be blocked.
  @JsonKey(name: 'excludeWindowCount')
  final int? excludeWindowCount;

  /// @nodoc
  factory ScreenCaptureParameters.fromJson(Map<String, dynamic> json) =>
      _$ScreenCaptureParametersFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ScreenCaptureParametersToJson(this);
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum AudioRecordingQualityType {
  /// @nodoc
  @JsonValue(0)
  audioRecordingQualityLow,

  /// @nodoc
  @JsonValue(1)
  audioRecordingQualityMedium,

  /// @nodoc
  @JsonValue(2)
  audioRecordingQualityHigh,
}

/// Extensions functions of [AudioRecordingQualityType].
extension AudioRecordingQualityTypeExt on AudioRecordingQualityType {
  /// @nodoc
  static AudioRecordingQualityType fromValue(int value) {
    return $enumDecode(_$AudioRecordingQualityTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$AudioRecordingQualityTypeEnumMap[this]!;
  }
}

/// Recording quality.
@JsonEnum(alwaysCreate: true)
enum AudioFileRecordingType {
  /// @nodoc
  @JsonValue(1)
  audioFileRecordingMic,

  /// @nodoc
  @JsonValue(2)
  audioFileRecordingPlayback,

  /// @nodoc
  @JsonValue(3)
  audioFileRecordingMixed,
}

/// Extensions functions of [AudioFileRecordingType].
extension AudioFileRecordingTypeExt on AudioFileRecordingType {
  /// @nodoc
  static AudioFileRecordingType fromValue(int value) {
    return $enumDecode(_$AudioFileRecordingTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$AudioFileRecordingTypeEnumMap[this]!;
  }
}

/// Audio profile.
@JsonEnum(alwaysCreate: true)
enum AudioEncodedFrameObserverPosition {
  /// 1: Only records the audio of the local user.
  @JsonValue(1)
  audioEncodedFrameObserverPositionRecord,

  /// 2: Only records the audio of all remote users.
  @JsonValue(2)
  audioEncodedFrameObserverPositionPlayback,

  /// 3: Records the mixed audio of the local and all remote users.
  @JsonValue(3)
  audioEncodedFrameObserverPositionMixed,
}

/// Extensions functions of [AudioEncodedFrameObserverPosition].
extension AudioEncodedFrameObserverPositionExt
    on AudioEncodedFrameObserverPosition {
  /// @nodoc
  static AudioEncodedFrameObserverPosition fromValue(int value) {
    return $enumDecode(_$AudioEncodedFrameObserverPositionEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$AudioEncodedFrameObserverPositionEnumMap[this]!;
  }
}

/// Recording configuration.
@JsonSerializable(explicitToJson: true)
class AudioRecordingConfiguration {
  /// Construct the [AudioRecordingConfiguration].
  const AudioRecordingConfiguration(
      {this.filePath,
      this.encode,
      this.sampleRate,
      this.fileRecordingType,
      this.quality});

  /// The absolute path (including the filename extensions) of the recording file. For example: C:\music\audio.mp4. Ensure that the path for the recording file exists and is writable.
  @JsonKey(name: 'filePath')
  final String? filePath;

  /// Whether to encode the audio data: true
  /// : Encode audio data in AAC.
  /// false
  /// : (Default) Do not encode audio data, but save the recorded audio data directly.
  @JsonKey(name: 'encode')
  final bool? encode;

  /// Recording sample rate (Hz). 16000
  /// (Default) 32000
  /// 44100
  /// 48000 If you set this parameter to 44100 or 48000, Agora recommends recording WAV files, or AAC files with quality to be AgoraAudioRecordingQualityMedium or AgoraAudioRecordingQualityHigh for better recording quality.
  @JsonKey(name: 'sampleRate')
  final int? sampleRate;

  /// Recording content. See AudioFileRecordingType .
  @JsonKey(name: 'fileRecordingType')
  final AudioFileRecordingType? fileRecordingType;

  /// Recording quality. See audiorecordingqualitytype . This parameter applies to AAC files only.
  @JsonKey(name: 'quality')
  final AudioRecordingQualityType? quality;

  /// @nodoc
  factory AudioRecordingConfiguration.fromJson(Map<String, dynamic> json) =>
      _$AudioRecordingConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AudioRecordingConfigurationToJson(this);
}

/// Observer settings for encoded audio.
@JsonSerializable(explicitToJson: true)
class AudioEncodedFrameObserverConfig {
  /// Construct the [AudioEncodedFrameObserverConfig].
  const AudioEncodedFrameObserverConfig({this.postionType, this.encodingType});

  /// Audio profile. See AudioEncodedFrameObserverPosition .
  @JsonKey(name: 'postionType')
  final AudioEncodedFrameObserverPosition? postionType;

  /// Audio encoding type. See AudioEncodingType .
  @JsonKey(name: 'encodingType')
  final AudioEncodingType? encodingType;

  /// @nodoc
  factory AudioEncodedFrameObserverConfig.fromJson(Map<String, dynamic> json) =>
      _$AudioEncodedFrameObserverConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() =>
      _$AudioEncodedFrameObserverConfigToJson(this);
}

/// The region for connection, i.e., the region where the server the SDK connects to is located.
@JsonEnum(alwaysCreate: true)
enum AreaCode {
  /// Mainland China.
  @JsonValue(0x00000001)
  areaCodeCn,

  /// North America.
  @JsonValue(0x00000002)
  areaCodeNa,

  /// Europe.
  @JsonValue(0x00000004)
  areaCodeEu,

  /// Asia, excluding Mainland China.
  @JsonValue(0x00000008)
  areaCodeAs,

  /// Japan.
  @JsonValue(0x00000010)
  areaCodeJp,

  /// India.
  @JsonValue(0x00000020)
  areaCodeIn,

  /// Global.
  @JsonValue((0xFFFFFFFF))
  areaCodeGlob,
}

/// Extensions functions of [AreaCode].
extension AreaCodeExt on AreaCode {
  /// @nodoc
  static AreaCode fromValue(int value) {
    return $enumDecode(_$AreaCodeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$AreaCodeEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum AreaCodeEx {
  /// @nodoc
  @JsonValue(0x00000040)
  areaCodeOc,

  /// @nodoc
  @JsonValue(0x00000080)
  areaCodeSa,

  /// @nodoc
  @JsonValue(0x00000100)
  areaCodeAf,

  /// @nodoc
  @JsonValue(0x00000200)
  areaCodeKr,

  /// @nodoc
  @JsonValue(0xFFFFFFFE)
  areaCodeOvs,
}

/// Extensions functions of [AreaCodeEx].
extension AreaCodeExExt on AreaCodeEx {
  /// @nodoc
  static AreaCodeEx fromValue(int value) {
    return $enumDecode(_$AreaCodeExEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$AreaCodeExEnumMap[this]!;
  }
}

/// The error code of the channel media relay.
@JsonEnum(alwaysCreate: true)
enum ChannelMediaRelayError {
  /// 0: No error.
  @JsonValue(0)
  relayOk,

  /// 1: An error occurs in the server response.
  @JsonValue(1)
  relayErrorServerErrorResponse,

  /// 2: No server response.
  /// You can call leaveChannel to leave the channel.
  /// This error can also occur if your project has not enabled co-host token authentication. You can to enable the service for cohosting across channels before starting a channel media relay.
  @JsonValue(2)
  relayErrorServerNoResponse,

  /// 3: The SDK fails to access the service, probably due to limited resources of the server.
  @JsonValue(3)
  relayErrorNoResourceAvailable,

  /// 4: Fails to send the relay request.
  @JsonValue(4)
  relayErrorFailedJoinSrc,

  /// 5: Fails to accept the relay request.
  @JsonValue(5)
  relayErrorFailedJoinDest,

  /// 6: The server fails to receive the media stream.
  @JsonValue(6)
  relayErrorFailedPacketReceivedFromSrc,

  /// 7: The server fails to send the media stream.
  @JsonValue(7)
  relayErrorFailedPacketSentToDest,

  /// 8: The SDK disconnects from the server due to poor network connections. You can call leaveChannel method to leave the channel.
  @JsonValue(8)
  relayErrorServerConnectionLost,

  /// 9: An internal error occurs in the server.
  @JsonValue(9)
  relayErrorInternalError,

  /// 10: The token of the source channel has expired.
  @JsonValue(10)
  relayErrorSrcTokenExpired,

  /// 11: The token of the destination channel has expired.
  @JsonValue(11)
  relayErrorDestTokenExpired,
}

/// Extensions functions of [ChannelMediaRelayError].
extension ChannelMediaRelayErrorExt on ChannelMediaRelayError {
  /// @nodoc
  static ChannelMediaRelayError fromValue(int value) {
    return $enumDecode(_$ChannelMediaRelayErrorEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$ChannelMediaRelayErrorEnumMap[this]!;
  }
}

/// The event code of channel media relay.
@JsonEnum(alwaysCreate: true)
enum ChannelMediaRelayEvent {
  /// 0: The user disconnects from the server due to a poor network connection.
  @JsonValue(0)
  relayEventNetworkDisconnected,

  /// 1: The user is connected to the server.
  @JsonValue(1)
  relayEventNetworkConnected,

  /// 2: The user joins the source channel.
  @JsonValue(2)
  relayEventPacketJoinedSrcChannel,

  /// 3: The user joins the destination channel.
  @JsonValue(3)
  relayEventPacketJoinedDestChannel,

  /// 4: The SDK starts relaying the media stream to the destination channel.
  @JsonValue(4)
  relayEventPacketSentToDestChannel,

  /// 5: The server receives the audio stream from the source channel.
  @JsonValue(5)
  relayEventPacketReceivedVideoFromSrc,

  /// 6: The server receives the audio stream from the source channel.
  @JsonValue(6)
  relayEventPacketReceivedAudioFromSrc,

  /// 7: The destination channel is updated.
  @JsonValue(7)
  relayEventPacketUpdateDestChannel,

  /// 8: The destination channel update fails due to internal reasons.
  @JsonValue(8)
  relayEventPacketUpdateDestChannelRefused,

  /// 9: The destination channel does not change, which means that the destination channel fails to be updated.
  @JsonValue(9)
  relayEventPacketUpdateDestChannelNotChange,

  /// 10: The destination channel name is NULL.
  @JsonValue(10)
  relayEventPacketUpdateDestChannelIsNull,

  /// 11: The video profile is sent to the server.
  @JsonValue(11)
  relayEventVideoProfileUpdate,

  /// 12: The SDK successfully pauses relaying the media stream to destination channels.
  @JsonValue(12)
  relayEventPauseSendPacketToDestChannelSuccess,

  /// 13: The SDK fails to pause relaying the media stream to destination channels.
  @JsonValue(13)
  relayEventPauseSendPacketToDestChannelFailed,

  /// 14: The SDK successfully resumes relaying the media stream to destination channels.
  @JsonValue(14)
  relayEventResumeSendPacketToDestChannelSuccess,

  /// 15: The SDK fails to resume relaying the media stream to destination channels.
  @JsonValue(15)
  relayEventResumeSendPacketToDestChannelFailed,
}

/// Extensions functions of [ChannelMediaRelayEvent].
extension ChannelMediaRelayEventExt on ChannelMediaRelayEvent {
  /// @nodoc
  static ChannelMediaRelayEvent fromValue(int value) {
    return $enumDecode(_$ChannelMediaRelayEventEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$ChannelMediaRelayEventEnumMap[this]!;
  }
}

/// The state code of the channel media relay.
@JsonEnum(alwaysCreate: true)
enum ChannelMediaRelayState {
  /// 0: The initial state. After you successfullystop the channel media relay by calling stopChannelMediaRelay , the onChannelMediaRelayStateChanged callback returns this state.
  @JsonValue(0)
  relayStateIdle,

  /// 1: The SDK tries to relay the media stream to the destination channel.
  @JsonValue(1)
  relayStateConnecting,

  /// 2: The SDK successfully relays the media stream to the destination channel.
  @JsonValue(2)
  relayStateRunning,

  /// 3: An error occurs. See code in onChannelMediaRelayStateChanged for the error code.
  @JsonValue(3)
  relayStateFailure,
}

/// Extensions functions of [ChannelMediaRelayState].
extension ChannelMediaRelayStateExt on ChannelMediaRelayState {
  /// @nodoc
  static ChannelMediaRelayState fromValue(int value) {
    return $enumDecode(_$ChannelMediaRelayStateEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$ChannelMediaRelayStateEnumMap[this]!;
  }
}

/// The definition of ChannelMediaInfo.
@JsonSerializable(explicitToJson: true)
class ChannelMediaInfo {
  /// Construct the [ChannelMediaInfo].
  const ChannelMediaInfo({this.channelName, this.token, this.uid});

  /// The channel name.
  @JsonKey(name: 'channelName')
  final String? channelName;

  /// The token that enables the user to join the channel.
  @JsonKey(name: 'token')
  final String? token;

  /// The user ID.
  @JsonKey(name: 'uid')
  final int? uid;

  /// @nodoc
  factory ChannelMediaInfo.fromJson(Map<String, dynamic> json) =>
      _$ChannelMediaInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ChannelMediaInfoToJson(this);
}

/// The definition of ChannelMediaRelayConfiguration.
@JsonSerializable(explicitToJson: true)
class ChannelMediaRelayConfiguration {
  /// Construct the [ChannelMediaRelayConfiguration].
  const ChannelMediaRelayConfiguration(
      {this.srcInfo, this.destInfos, this.destCount});

  /// The information of the source channel ChannelMediaInfo . It contains the following members:
  /// channelName: The name of the source channel. The default value is NULL, which means the SDK applies the name of the current channel.
  /// uid: The unique ID to identify the relay stream in the source channel. The default value is 0, which means the SDK generates a random uid. You must set it as 0.
  /// token: The token for joining the source channel. It is generated with the channelName and uid you set in srcInfo.
  /// If you have not enabled the App Certificate, set this parameter as the default value NULL, which means the SDK applies the App ID.
  /// If you have enabled the App Certificate, you must use the token generated with the channelName and uid, and the uid must be set as 0.
  @JsonKey(name: 'srcInfo')
  final ChannelMediaInfo? srcInfo;

  /// The information of the destination channel ChannelMediaInfo. It contains the following members:
  /// channelName : The name of the destination channel.
  /// uid: The unique ID to identify the relay stream in the destination channel. The value ranges from 0 to (232-1). To avoid UID conflicts, this UID must be different from any other UID in the destination channel. The default value is 0, which means the SDK generates a random UID. Do not set this parameter as the UID of the host in the destination channel, and ensure that this UID is different from any other UID in the channel.
  /// token: The token for joining the destination channel. It is generated with the channelName and uid you set in destInfos.
  /// If you have not enabled the App Certificate, set this parameter as the default value NULL, which means the SDK applies the App ID.
  /// If you have enabled the App Certificate, you must use the token generated with the channelName and uid.
  @JsonKey(name: 'destInfos')
  final List<ChannelMediaInfo>? destInfos;

  /// The number of destination channels. The default value is 0, and the value range is from 0 to 4. Ensure that the value of this parameter corresponds to the number of ChannelMediaInfo structs you define in destInfo.
  @JsonKey(name: 'destCount')
  final int? destCount;

  /// @nodoc
  factory ChannelMediaRelayConfiguration.fromJson(Map<String, dynamic> json) =>
      _$ChannelMediaRelayConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ChannelMediaRelayConfigurationToJson(this);
}

/// The uplink network information.
@JsonSerializable(explicitToJson: true)
class UplinkNetworkInfo {
  /// Construct the [UplinkNetworkInfo].
  const UplinkNetworkInfo({this.videoEncoderTargetBitrateBps});

  /// @nodoc
  @JsonKey(name: 'video_encoder_target_bitrate_bps')
  final int? videoEncoderTargetBitrateBps;

  /// @nodoc
  factory UplinkNetworkInfo.fromJson(Map<String, dynamic> json) =>
      _$UplinkNetworkInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$UplinkNetworkInfoToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true)
class DownlinkNetworkInfo {
  /// Construct the [DownlinkNetworkInfo].
  const DownlinkNetworkInfo(
      {this.lastmileBufferDelayTimeMs,
      this.bandwidthEstimationBps,
      this.totalDownscaleLevelCount,
      this.peerDownlinkInfo,
      this.totalReceivedVideoCount});

  /// @nodoc
  @JsonKey(name: 'lastmile_buffer_delay_time_ms')
  final int? lastmileBufferDelayTimeMs;

  /// @nodoc
  @JsonKey(name: 'bandwidth_estimation_bps')
  final int? bandwidthEstimationBps;

  /// @nodoc
  @JsonKey(name: 'total_downscale_level_count')
  final int? totalDownscaleLevelCount;

  /// @nodoc
  @JsonKey(name: 'peer_downlink_info')
  final List<PeerDownlinkInfo>? peerDownlinkInfo;

  /// @nodoc
  @JsonKey(name: 'total_received_video_count')
  final int? totalReceivedVideoCount;

  /// @nodoc
  factory DownlinkNetworkInfo.fromJson(Map<String, dynamic> json) =>
      _$DownlinkNetworkInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$DownlinkNetworkInfoToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true)
class PeerDownlinkInfo {
  /// Construct the [PeerDownlinkInfo].
  const PeerDownlinkInfo(
      {this.uid,
      this.streamType,
      this.currentDownscaleLevel,
      this.expectedBitrateBps});

  /// @nodoc
  @JsonKey(name: 'uid')
  final String? uid;

  /// @nodoc
  @JsonKey(name: 'stream_type')
  final VideoStreamType? streamType;

  /// @nodoc
  @JsonKey(name: 'current_downscale_level')
  final RemoteVideoDownscaleLevel? currentDownscaleLevel;

  /// @nodoc
  @JsonKey(name: 'expected_bitrate_bps')
  final int? expectedBitrateBps;

  /// @nodoc
  factory PeerDownlinkInfo.fromJson(Map<String, dynamic> json) =>
      _$PeerDownlinkInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$PeerDownlinkInfoToJson(this);
}

/// The built-in encryption mode.
/// Agora recommends using aes128Gcm2 or aes256Gcm2 encrypted mode. These two modes support the use of salt for higher security.
@JsonEnum(alwaysCreate: true)
enum EncryptionMode {
  /// 1: 128-bit AES encryption, XTS mode.
  @JsonValue(1)
  aes128Xts,

  /// 2: 128-bit AES encryption, ECB mode.
  @JsonValue(2)
  aes128Ecb,

  /// 3: 256-bit AES encryption, XTS mode.
  @JsonValue(3)
  aes256Xts,

  /// 4: 128-bit SM4 encryption, ECB mode.
  @JsonValue(4)
  sm4128Ecb,

  /// 5: 128-bit AES encryption, GCM mode.
  @JsonValue(5)
  aes128Gcm,

  /// 6: 256-bit AES encryption, GCM mode.
  @JsonValue(6)
  aes256Gcm,

  /// 7: (Default) 128-bit AES encryption, GCM mode. This encryption mode requires the setting of salt (encryptionKdfSalt).
  @JsonValue(7)
  aes128Gcm2,

  /// 8: 256-bit AES encryption, GCM mode. This encryption mode requires the setting of salt (encryptionKdfSalt).
  @JsonValue(8)
  aes256Gcm2,

  /// Enumeration boundary.
  @JsonValue(9)
  modeEnd,
}

/// Extensions functions of [EncryptionMode].
extension EncryptionModeExt on EncryptionMode {
  /// @nodoc
  static EncryptionMode fromValue(int value) {
    return $enumDecode(_$EncryptionModeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$EncryptionModeEnumMap[this]!;
  }
}

/// Built-in encryption configurations.
@JsonSerializable(explicitToJson: true)
class EncryptionConfig {
  /// Construct the [EncryptionConfig].
  const EncryptionConfig(
      {this.encryptionMode, this.encryptionKey, this.encryptionKdfSalt});

  /// The built-in encryption mode. See EncryptionMode . Agora recommends using aes128Gcm2 or aes256Gcm2 encrypted mode. These two modes support the use of salt for higher security.
  @JsonKey(name: 'encryptionMode')
  final EncryptionMode? encryptionMode;

  /// Encryption key in string type with unlimited length. Agora recommends using a 32-byte key.
  /// If you do not set an encryption key or set it as NULL, you cannot use the built-in encryption, and the SDK returns -2.
  @JsonKey(name: 'encryptionKey')
  final String? encryptionKey;

  /// Salt, 32 bytes in length. Agora recommends that you use OpenSSL to generate salt on the server side. See Media Stream Encryption for details.
  /// This parameter takes effect only in aes128Gcm2 or aes256Gcm2 encrypted mode. In this case, ensure that this parameter is not 0.
  @JsonKey(name: 'encryptionKdfSalt', ignore: true)
  final Uint8List? encryptionKdfSalt;

  /// @nodoc
  factory EncryptionConfig.fromJson(Map<String, dynamic> json) =>
      _$EncryptionConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$EncryptionConfigToJson(this);
}

/// Encryption error type.
@JsonEnum(alwaysCreate: true)
enum EncryptionErrorType {
  /// 0: Internal reason.
  @JsonValue(0)
  encryptionErrorInternalFailure,

  /// 1: Decryption errors.
  /// Ensure that the receiver and the sender use the same encryption mode and key.
  @JsonValue(1)
  encryptionErrorDecryptionFailure,

  /// 2: Encryption errors.
  @JsonValue(2)
  encryptionErrorEncryptionFailure,
}

/// Extensions functions of [EncryptionErrorType].
extension EncryptionErrorTypeExt on EncryptionErrorType {
  /// @nodoc
  static EncryptionErrorType fromValue(int value) {
    return $enumDecode(_$EncryptionErrorTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$EncryptionErrorTypeEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum UploadErrorReason {
  /// /// @nodoc
  @JsonValue(0)
  uploadSuccess,

  /// /// @nodoc
  @JsonValue(1)
  uploadNetError,

  /// /// @nodoc
  @JsonValue(2)
  uploadServerError,
}

/// Extensions functions of [UploadErrorReason].
extension UploadErrorReasonExt on UploadErrorReason {
  /// @nodoc
  static UploadErrorReason fromValue(int value) {
    return $enumDecode(_$UploadErrorReasonEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$UploadErrorReasonEnumMap[this]!;
  }
}

/// The type of the device permission.
@JsonEnum(alwaysCreate: true)
enum PermissionType {
  /// 0: Permission for the audio capture device.
  @JsonValue(0)
  recordAudio,

  /// 1: Permission for the camera.
  @JsonValue(1)
  camera,
}

/// Extensions functions of [PermissionType].
extension PermissionTypeExt on PermissionType {
  /// @nodoc
  static PermissionType fromValue(int value) {
    return $enumDecode(_$PermissionTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$PermissionTypeEnumMap[this]!;
  }
}

/// The maximum length of the user account.
@JsonEnum(alwaysCreate: true)
enum MaxUserAccountLengthType {
  /// The maximum length of the user account is 256 bytes.
  @JsonValue(256)
  maxUserAccountLength,
}

/// Extensions functions of [MaxUserAccountLengthType].
extension MaxUserAccountLengthTypeExt on MaxUserAccountLengthType {
  /// @nodoc
  static MaxUserAccountLengthType fromValue(int value) {
    return $enumDecode(_$MaxUserAccountLengthTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$MaxUserAccountLengthTypeEnumMap[this]!;
  }
}

/// The subscribing state.
@JsonEnum(alwaysCreate: true)
enum StreamSubscribeState {
  /// 0: The initial publishing state after joining the channel.
  @JsonValue(0)
  subStateIdle,

  /// 1: Fails to subscribe to the remote stream. Possible reasons:
  /// Remote users:
  /// Calls muteLocalAudioStream (true) or muteLocalVideoStream (true) to stop sending local media streams.
  /// Calls disableAudio or disableVideo to disable the local audio or video module.
  /// Calls enableLocalAudio (false) or enableLocalVideo (false) to disable local audio or video capture.
  /// The role of the local user is audience. The local user calls the following method to stop receiving the remote media stream:
  /// Call muteRemoteAudioStream (true), muteAllRemoteAudioStreams (true) or setDefaultMuteAllRemoteAudioStreams (true) to stop receiving the remote audio stream.
  /// Call muteRemoteVideoStream (true), muteAllRemoteVideoStreams (true) or setDefaultMuteAllRemoteVideoStreams (true) to stop receiving the remote video stream.
  @JsonValue(1)
  subStateNoSubscribed,

  /// 2: Publishing.
  @JsonValue(2)
  subStateSubscribing,

  /// 3: The remote stream is received, and the subscription is successful.
  @JsonValue(3)
  subStateSubscribed,
}

/// Extensions functions of [StreamSubscribeState].
extension StreamSubscribeStateExt on StreamSubscribeState {
  /// @nodoc
  static StreamSubscribeState fromValue(int value) {
    return $enumDecode(_$StreamSubscribeStateEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$StreamSubscribeStateEnumMap[this]!;
  }
}

/// The publishing state.
@JsonEnum(alwaysCreate: true)
enum StreamPublishState {
  /// 0: The initial publishing state after joining the channel.
  @JsonValue(0)
  pubStateIdle,

  /// 1: Fails to publish the local stream. Possible reasons:
  /// Local user calls muteLocalAudioStream (true) or muteLocalVideoStream (true) to stop sending local media streams.
  /// The local user calls disableAudio or disableVideo to disable the local audio or video module.
  /// The local user calls enableLocalAudio (false) or enableLocalVideo (false) to disable the local audio or video capture.
  /// The role of the local user is audience.
  @JsonValue(1)
  pubStateNoPublished,

  /// 2: Publishing.
  @JsonValue(2)
  pubStatePublishing,

  /// 3: Publishes successfully.
  @JsonValue(3)
  pubStatePublished,
}

/// Extensions functions of [StreamPublishState].
extension StreamPublishStateExt on StreamPublishState {
  /// @nodoc
  static StreamPublishState fromValue(int value) {
    return $enumDecode(_$StreamPublishStateEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$StreamPublishStateEnumMap[this]!;
  }
}

/// The information of the user.
@JsonSerializable(explicitToJson: true)
class UserInfo {
  /// Construct the [UserInfo].
  const UserInfo({this.uid, this.userAccount});

  /// The user ID.
  @JsonKey(name: 'uid')
  final int? uid;

  /// User account. The maximum data length is MaxUserAccountLengthType .
  @JsonKey(name: 'userAccount')
  final String? userAccount;

  /// @nodoc
  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

/// The audio filter of in-ear monitoring.
@JsonEnum(alwaysCreate: true)
enum EarMonitoringFilterType {
  /// 1: Do not add an audio filter to the in-ear monitor.
  @JsonValue((1 << 0))
  earMonitoringFilterNone,

  /// 2: Add an audio filter to the in-ear monitor.
  /// If you implement functions such as voice beautifier and audio effect, users can hear the voice after adding these effects.
  @JsonValue((1 << 1))
  earMonitoringFilterBuiltInAudioFilters,

  /// 4: Enable noise suppression to the in-ear monitor.
  @JsonValue((1 << 2))
  earMonitoringFilterNoiseSuppression,
}

/// Extensions functions of [EarMonitoringFilterType].
extension EarMonitoringFilterTypeExt on EarMonitoringFilterType {
  /// @nodoc
  static EarMonitoringFilterType fromValue(int value) {
    return $enumDecode(_$EarMonitoringFilterTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$EarMonitoringFilterTypeEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum ThreadPriorityType {
  /// @nodoc
  @JsonValue(0)
  lowest,

  /// @nodoc
  @JsonValue(1)
  low,

  /// @nodoc
  @JsonValue(2)
  normal,

  /// @nodoc
  @JsonValue(3)
  high,

  /// @nodoc
  @JsonValue(4)
  highest,

  /// @nodoc
  @JsonValue(5)
  critical,
}

/// Extensions functions of [ThreadPriorityType].
extension ThreadPriorityTypeExt on ThreadPriorityType {
  /// @nodoc
  static ThreadPriorityType fromValue(int value) {
    return $enumDecode(_$ThreadPriorityTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$ThreadPriorityTypeEnumMap[this]!;
  }
}

/// @nodoc
@JsonSerializable(explicitToJson: true)
class SpatialAudioParams {
  /// Construct the [SpatialAudioParams].
  const SpatialAudioParams(
      {this.speakerAzimuth,
      this.speakerElevation,
      this.speakerDistance,
      this.speakerOrientation,
      this.enableBlur,
      this.enableAirAbsorb});

  /// @nodoc
  @JsonKey(name: 'speaker_azimuth')
  final double? speakerAzimuth;

  /// @nodoc
  @JsonKey(name: 'speaker_elevation')
  final double? speakerElevation;

  /// @nodoc
  @JsonKey(name: 'speaker_distance')
  final double? speakerDistance;

  /// @nodoc
  @JsonKey(name: 'speaker_orientation')
  final int? speakerOrientation;

  /// @nodoc
  @JsonKey(name: 'enable_blur')
  final bool? enableBlur;

  /// @nodoc
  @JsonKey(name: 'enable_air_absorb')
  final bool? enableAirAbsorb;

  /// @nodoc
  factory SpatialAudioParams.fromJson(Map<String, dynamic> json) =>
      _$SpatialAudioParamsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$SpatialAudioParamsToJson(this);
}
