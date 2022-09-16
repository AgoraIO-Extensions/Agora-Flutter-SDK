import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_base.g.dart';

@JsonEnum(alwaysCreate: true)
enum ChannelProfileType {
  @JsonValue(0)
  channelProfileCommunication,

  @JsonValue(1)
  channelProfileLiveBroadcasting,

  @JsonValue(2)
  channelProfileGame,

  @JsonValue(3)
  channelProfileCloudGaming,

  @JsonValue(4)
  channelProfileCommunication1v1,
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

@JsonEnum(alwaysCreate: true)
enum WarnCodeType {
  @JsonValue(8)
  warnInvalidView,

  @JsonValue(16)
  warnInitVideo,

  @JsonValue(20)
  warnPending,

  @JsonValue(103)
  warnNoAvailableChannel,

  @JsonValue(104)
  warnLookupChannelTimeout,

  @JsonValue(105)
  warnLookupChannelRejected,

  @JsonValue(106)
  warnOpenChannelTimeout,

  @JsonValue(107)
  warnOpenChannelRejected,

  @JsonValue(111)
  warnSwitchLiveVideoTimeout,

  @JsonValue(118)
  warnSetClientRoleTimeout,

  @JsonValue(121)
  warnOpenChannelInvalidTicket,

  @JsonValue(122)
  warnOpenChannelTryNextVos,

  @JsonValue(131)
  warnChannelConnectionUnrecoverable,

  @JsonValue(132)
  warnChannelConnectionIpChanged,

  @JsonValue(133)
  warnChannelConnectionPortChanged,

  @JsonValue(134)
  warnChannelSocketError,

  @JsonValue(701)
  warnAudioMixingOpenError,

  @JsonValue(1014)
  warnAdmRuntimePlayoutWarning,

  @JsonValue(1016)
  warnAdmRuntimeRecordingWarning,

  @JsonValue(1019)
  warnAdmRecordAudioSilence,

  @JsonValue(1020)
  warnAdmPlayoutMalfunction,

  @JsonValue(1021)
  warnAdmRecordMalfunction,

  @JsonValue(1031)
  warnAdmRecordAudioLowlevel,

  @JsonValue(1032)
  warnAdmPlayoutAudioLowlevel,

  @JsonValue(1040)
  warnAdmWindowsNoDataReadyEvent,

  @JsonValue(1051)
  warnApmHowling,

  @JsonValue(1052)
  warnAdmGlitchState,

  @JsonValue(1053)
  warnAdmImproperSettings,

  @JsonValue(1322)
  warnAdmWinCoreNoRecordingDevice,

  @JsonValue(1323)
  warnAdmWinCoreNoPlayoutDevice,

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

@JsonEnum(alwaysCreate: true)
enum ErrorCodeType {
  @JsonValue(0)
  errOk,

  @JsonValue(1)
  errFailed,

  @JsonValue(2)
  errInvalidArgument,

  @JsonValue(3)
  errNotReady,

  @JsonValue(4)
  errNotSupported,

  @JsonValue(5)
  errRefused,

  @JsonValue(6)
  errBufferTooSmall,

  @JsonValue(7)
  errNotInitialized,

  @JsonValue(8)
  errInvalidState,

  @JsonValue(9)
  errNoPermission,

  @JsonValue(10)
  errTimedout,

  @JsonValue(11)
  errCanceled,

  @JsonValue(12)
  errTooOften,

  @JsonValue(13)
  errBindSocket,

  @JsonValue(14)
  errNetDown,

  @JsonValue(17)
  errJoinChannelRejected,

  @JsonValue(18)
  errLeaveChannelRejected,

  @JsonValue(19)
  errAlreadyInUse,

  @JsonValue(20)
  errAborted,

  @JsonValue(21)
  errInitNetEngine,

  @JsonValue(22)
  errResourceLimited,

  @JsonValue(101)
  errInvalidAppId,

  @JsonValue(102)
  errInvalidChannelName,

  @JsonValue(103)
  errNoServerResources,

  @JsonValue(109)
  errTokenExpired,

  @JsonValue(110)
  errInvalidToken,

  @JsonValue(111)
  errConnectionInterrupted,

  @JsonValue(112)
  errConnectionLost,

  @JsonValue(113)
  errNotInChannel,

  @JsonValue(114)
  errSizeTooLarge,

  @JsonValue(115)
  errBitrateLimit,

  @JsonValue(116)
  errTooManyDataStreams,

  @JsonValue(117)
  errStreamMessageTimeout,

  @JsonValue(119)
  errSetClientRoleNotAuthorized,

  @JsonValue(120)
  errDecryptionFailed,

  @JsonValue(121)
  errInvalidUserId,

  @JsonValue(123)
  errClientIsBannedByServer,

  @JsonValue(130)
  errEncryptedStreamNotAllowedPublish,

  @JsonValue(131)
  errLicenseCredentialInvalid,

  @JsonValue(134)
  errInvalidUserAccount,

  @JsonValue(157)
  errModuleNotFound,

  @JsonValue(157)
  errCertRaw,

  @JsonValue(158)
  errCertJsonPart,

  @JsonValue(159)
  errCertJsonInval,

  @JsonValue(160)
  errCertJsonNomem,

  @JsonValue(161)
  errCertCustom,

  @JsonValue(162)
  errCertCredential,

  @JsonValue(163)
  errCertSign,

  @JsonValue(164)
  errCertFail,

  @JsonValue(165)
  errCertBuf,

  @JsonValue(166)
  errCertNull,

  @JsonValue(167)
  errCertDuedate,

  @JsonValue(168)
  errCertRequest,

  @JsonValue(200)
  errPcmsendFormat,

  @JsonValue(201)
  errPcmsendBufferoverflow,

  @JsonValue(428)
  errLoginAlreadyLogin,

  @JsonValue(1001)
  errLoadMediaEngine,

  @JsonValue(1005)
  errAdmGeneralError,

  @JsonValue(1008)
  errAdmInitPlayout,

  @JsonValue(1009)
  errAdmStartPlayout,

  @JsonValue(1010)
  errAdmStopPlayout,

  @JsonValue(1011)
  errAdmInitRecording,

  @JsonValue(1012)
  errAdmStartRecording,

  @JsonValue(1013)
  errAdmStopRecording,

  @JsonValue(1501)
  errVdmCameraNotAuthorized,
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

@JsonEnum(alwaysCreate: true)
enum AudioSessionOperationRestriction {
  @JsonValue(0)
  audioSessionOperationRestrictionNone,

  @JsonValue(1)
  audioSessionOperationRestrictionSetCategory,

  @JsonValue(1 << 1)
  audioSessionOperationRestrictionConfigureSession,

  @JsonValue(1 << 2)
  audioSessionOperationRestrictionDeactivateSession,

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

@JsonEnum(alwaysCreate: true)
enum UserOfflineReasonType {
  @JsonValue(0)
  userOfflineQuit,

  @JsonValue(1)
  userOfflineDropped,

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

@JsonEnum(alwaysCreate: true)
enum InterfaceIdType {
  @JsonValue(1)
  agoraIidAudioDeviceManager,

  @JsonValue(2)
  agoraIidVideoDeviceManager,

  @JsonValue(3)
  agoraIidParameterEngine,

  @JsonValue(4)
  agoraIidMediaEngine,

  @JsonValue(5)
  agoraIidAudioEngine,

  @JsonValue(6)
  agoraIidVideoEngine,

  @JsonValue(7)
  agoraIidRtcConnection,

  @JsonValue(8)
  agoraIidSignalingEngine,

  @JsonValue(9)
  agoraIidMediaEngineRegulator,

  @JsonValue(10)
  agoraIidCloudSpatialAudio,

  @JsonValue(11)
  agoraIidLocalSpatialAudio,

  @JsonValue(12)
  agoraIidMediaRecorder,

  @JsonValue(13)
  agoraIidMusicContentCenter,
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

@JsonEnum(alwaysCreate: true)
enum QualityType {
  @JsonValue(0)
  qualityUnknown,

  @JsonValue(1)
  qualityExcellent,

  @JsonValue(2)
  qualityGood,

  @JsonValue(3)
  qualityPoor,

  @JsonValue(4)
  qualityBad,

  @JsonValue(5)
  qualityVbad,

  @JsonValue(6)
  qualityDown,

  @JsonValue(7)
  qualityUnsupported,

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

@JsonEnum(alwaysCreate: true)
enum FitModeType {
  @JsonValue(1)
  modeCover,

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

@JsonEnum(alwaysCreate: true)
enum VideoOrientation {
  @JsonValue(0)
  videoOrientation0,

  @JsonValue(90)
  videoOrientation90,

  @JsonValue(180)
  videoOrientation180,

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

@JsonEnum(alwaysCreate: true)
enum FrameRate {
  @JsonValue(1)
  frameRateFps1,

  @JsonValue(7)
  frameRateFps7,

  @JsonValue(10)
  frameRateFps10,

  @JsonValue(15)
  frameRateFps15,

  @JsonValue(24)
  frameRateFps24,

  @JsonValue(30)
  frameRateFps30,

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

@JsonEnum(alwaysCreate: true)
enum FrameWidth {
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

@JsonEnum(alwaysCreate: true)
enum FrameHeight {
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

@JsonEnum(alwaysCreate: true)
enum VideoFrameType {
  @JsonValue(0)
  videoFrameTypeBlankFrame,

  @JsonValue(3)
  videoFrameTypeKeyFrame,

  @JsonValue(4)
  videoFrameTypeDeltaFrame,

  @JsonValue(5)
  videoFrameTypeBFrame,

  @JsonValue(6)
  videoFrameTypeDroppableFrame,

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

@JsonEnum(alwaysCreate: true)
enum OrientationMode {
  @JsonValue(0)
  orientationModeAdaptive,

  @JsonValue(1)
  orientationModeFixedLandscape,

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

@JsonEnum(alwaysCreate: true)
enum DegradationPreference {
  @JsonValue(0)
  maintainQuality,

  @JsonValue(1)
  maintainFramerate,

  @JsonValue(2)
  maintainBalanced,

  @JsonValue(3)
  maintainResolution,

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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoDimensions {
  const VideoDimensions({this.width, this.height});

  @JsonKey(name: 'width')
  final int? width;

  @JsonKey(name: 'height')
  final int? height;
  factory VideoDimensions.fromJson(Map<String, dynamic> json) =>
      _$VideoDimensionsFromJson(json);
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

@JsonEnum(alwaysCreate: true)
enum VideoCodecType {
  @JsonValue(0)
  videoCodecNone,

  @JsonValue(1)
  videoCodecVp8,

  @JsonValue(2)
  videoCodecH264,

  @JsonValue(3)
  videoCodecH265,

  @JsonValue(6)
  videoCodecGeneric,

  @JsonValue(7)
  videoCodecGenericH264,

  @JsonValue(12)
  videoCodecAv1,

  @JsonValue(13)
  videoCodecVp9,

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

@JsonEnum(alwaysCreate: true)
enum TCcMode {
  @JsonValue(0)
  ccEnabled,

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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SenderOptions {
  const SenderOptions({this.ccMode, this.codecType, this.targetBitrate});

  @JsonKey(name: 'ccMode')
  final TCcMode? ccMode;

  @JsonKey(name: 'codecType')
  final VideoCodecType? codecType;

  @JsonKey(name: 'targetBitrate')
  final int? targetBitrate;
  factory SenderOptions.fromJson(Map<String, dynamic> json) =>
      _$SenderOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$SenderOptionsToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum AudioCodecType {
  @JsonValue(1)
  audioCodecOpus,

  @JsonValue(3)
  audioCodecPcma,

  @JsonValue(4)
  audioCodecPcmu,

  @JsonValue(5)
  audioCodecG722,

  @JsonValue(8)
  audioCodecAaclc,

  @JsonValue(9)
  audioCodecHeaac,

  @JsonValue(10)
  audioCodecJc1,

  @JsonValue(11)
  audioCodecHeaac2,

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

@JsonEnum(alwaysCreate: true)
enum AudioEncodingType {
  @JsonValue(0x010101)
  audioEncodingTypeAac16000Low,

  @JsonValue(0x010102)
  audioEncodingTypeAac16000Medium,

  @JsonValue(0x010201)
  audioEncodingTypeAac32000Low,

  @JsonValue(0x010202)
  audioEncodingTypeAac32000Medium,

  @JsonValue(0x010203)
  audioEncodingTypeAac32000High,

  @JsonValue(0x010302)
  audioEncodingTypeAac48000Medium,

  @JsonValue(0x010303)
  audioEncodingTypeAac48000High,

  @JsonValue(0x020101)
  audioEncodingTypeOpus16000Low,

  @JsonValue(0x020102)
  audioEncodingTypeOpus16000Medium,

  @JsonValue(0x020302)
  audioEncodingTypeOpus48000Medium,

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

@JsonEnum(alwaysCreate: true)
enum WatermarkFitMode {
  @JsonValue(0)
  fitModeCoverPosition,

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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class EncodedAudioFrameAdvancedSettings {
  const EncodedAudioFrameAdvancedSettings({this.speech, this.sendEvenIfEmpty});

  @JsonKey(name: 'speech')
  final bool? speech;

  @JsonKey(name: 'sendEvenIfEmpty')
  final bool? sendEvenIfEmpty;
  factory EncodedAudioFrameAdvancedSettings.fromJson(
          Map<String, dynamic> json) =>
      _$EncodedAudioFrameAdvancedSettingsFromJson(json);
  Map<String, dynamic> toJson() =>
      _$EncodedAudioFrameAdvancedSettingsToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class EncodedAudioFrameInfo {
  const EncodedAudioFrameInfo(
      {this.codec,
      this.sampleRateHz,
      this.samplesPerChannel,
      this.numberOfChannels,
      this.advancedSettings,
      this.captureTimeMs});

  @JsonKey(name: 'codec')
  final AudioCodecType? codec;

  @JsonKey(name: 'sampleRateHz')
  final int? sampleRateHz;

  @JsonKey(name: 'samplesPerChannel')
  final int? samplesPerChannel;

  @JsonKey(name: 'numberOfChannels')
  final int? numberOfChannels;

  @JsonKey(name: 'advancedSettings')
  final EncodedAudioFrameAdvancedSettings? advancedSettings;

  @JsonKey(name: 'captureTimeMs')
  final int? captureTimeMs;
  factory EncodedAudioFrameInfo.fromJson(Map<String, dynamic> json) =>
      _$EncodedAudioFrameInfoFromJson(json);
  Map<String, dynamic> toJson() => _$EncodedAudioFrameInfoToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioPcmDataInfo {
  const AudioPcmDataInfo(
      {this.samplesPerChannel,
      this.channelNum,
      this.samplesOut,
      this.elapsedTimeMs,
      this.ntpTimeMs});

  @JsonKey(name: 'samplesPerChannel')
  final int? samplesPerChannel;

  @JsonKey(name: 'channelNum')
  final int? channelNum;

  @JsonKey(name: 'samplesOut')
  final int? samplesOut;

  @JsonKey(name: 'elapsedTimeMs')
  final int? elapsedTimeMs;

  @JsonKey(name: 'ntpTimeMs')
  final int? ntpTimeMs;
  factory AudioPcmDataInfo.fromJson(Map<String, dynamic> json) =>
      _$AudioPcmDataInfoFromJson(json);
  Map<String, dynamic> toJson() => _$AudioPcmDataInfoToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum H264PacketizeMode {
  @JsonValue(0)
  nonInterleaved,

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

@JsonEnum(alwaysCreate: true)
enum VideoStreamType {
  @JsonValue(0)
  videoStreamHigh,

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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoSubscriptionOptions {
  const VideoSubscriptionOptions({this.type, this.encodedFrameOnly});

  @JsonKey(name: 'type')
  final VideoStreamType? type;

  @JsonKey(name: 'encodedFrameOnly')
  final bool? encodedFrameOnly;
  factory VideoSubscriptionOptions.fromJson(Map<String, dynamic> json) =>
      _$VideoSubscriptionOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$VideoSubscriptionOptionsToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class EncodedVideoFrameInfo {
  const EncodedVideoFrameInfo(
      {this.codecType,
      this.width,
      this.height,
      this.framesPerSecond,
      this.frameType,
      this.rotation,
      this.trackId,
      this.captureTimeMs,
      this.uid,
      this.streamType});

  @JsonKey(name: 'codecType')
  final VideoCodecType? codecType;

  @JsonKey(name: 'width')
  final int? width;

  @JsonKey(name: 'height')
  final int? height;

  @JsonKey(name: 'framesPerSecond')
  final int? framesPerSecond;

  @JsonKey(name: 'frameType')
  final VideoFrameType? frameType;

  @JsonKey(name: 'rotation')
  final VideoOrientation? rotation;

  @JsonKey(name: 'trackId')
  final int? trackId;

  @JsonKey(name: 'captureTimeMs')
  final int? captureTimeMs;

  @JsonKey(name: 'uid')
  final int? uid;

  @JsonKey(name: 'streamType')
  final VideoStreamType? streamType;
  factory EncodedVideoFrameInfo.fromJson(Map<String, dynamic> json) =>
      _$EncodedVideoFrameInfoFromJson(json);
  Map<String, dynamic> toJson() => _$EncodedVideoFrameInfoToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum VideoMirrorModeType {
  @JsonValue(0)
  videoMirrorModeAuto,

  @JsonValue(1)
  videoMirrorModeEnabled,

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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoEncoderConfiguration {
  const VideoEncoderConfiguration(
      {this.codecType,
      this.dimensions,
      this.frameRate,
      this.bitrate,
      this.minBitrate,
      this.orientationMode,
      this.degradationPreference,
      this.mirrorMode});

  @JsonKey(name: 'codecType')
  final VideoCodecType? codecType;

  @JsonKey(name: 'dimensions')
  final VideoDimensions? dimensions;

  @JsonKey(name: 'frameRate')
  final int? frameRate;

  @JsonKey(name: 'bitrate')
  final int? bitrate;

  @JsonKey(name: 'minBitrate')
  final int? minBitrate;

  @JsonKey(name: 'orientationMode')
  final OrientationMode? orientationMode;

  @JsonKey(name: 'degradationPreference')
  final DegradationPreference? degradationPreference;

  @JsonKey(name: 'mirrorMode')
  final VideoMirrorModeType? mirrorMode;
  factory VideoEncoderConfiguration.fromJson(Map<String, dynamic> json) =>
      _$VideoEncoderConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$VideoEncoderConfigurationToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class DataStreamConfig {
  const DataStreamConfig({this.syncWithAudio, this.ordered});

  @JsonKey(name: 'syncWithAudio')
  final bool? syncWithAudio;

  @JsonKey(name: 'ordered')
  final bool? ordered;
  factory DataStreamConfig.fromJson(Map<String, dynamic> json) =>
      _$DataStreamConfigFromJson(json);
  Map<String, dynamic> toJson() => _$DataStreamConfigToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum SimulcastStreamMode {
  @JsonValue(-1)
  autoSimulcastStream,

  @JsonValue(0)
  disableSimulcastStream,

  @JsonValue(1)
  enableSimulcastStream,
}

/// Extensions functions of [SimulcastStreamMode].
extension SimulcastStreamModeExt on SimulcastStreamMode {
  /// @nodoc
  static SimulcastStreamMode fromValue(int value) {
    return $enumDecode(_$SimulcastStreamModeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$SimulcastStreamModeEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SimulcastStreamConfig {
  const SimulcastStreamConfig({this.dimensions, this.bitrate, this.framerate});

  @JsonKey(name: 'dimensions')
  final VideoDimensions? dimensions;

  @JsonKey(name: 'bitrate')
  final int? bitrate;

  @JsonKey(name: 'framerate')
  final int? framerate;
  factory SimulcastStreamConfig.fromJson(Map<String, dynamic> json) =>
      _$SimulcastStreamConfigFromJson(json);
  Map<String, dynamic> toJson() => _$SimulcastStreamConfigToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Rectangle {
  const Rectangle({this.x, this.y, this.width, this.height});

  @JsonKey(name: 'x')
  final int? x;

  @JsonKey(name: 'y')
  final int? y;

  @JsonKey(name: 'width')
  final int? width;

  @JsonKey(name: 'height')
  final int? height;
  factory Rectangle.fromJson(Map<String, dynamic> json) =>
      _$RectangleFromJson(json);
  Map<String, dynamic> toJson() => _$RectangleToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class WatermarkRatio {
  const WatermarkRatio({this.xRatio, this.yRatio, this.widthRatio});

  @JsonKey(name: 'xRatio')
  final double? xRatio;

  @JsonKey(name: 'yRatio')
  final double? yRatio;

  @JsonKey(name: 'widthRatio')
  final double? widthRatio;
  factory WatermarkRatio.fromJson(Map<String, dynamic> json) =>
      _$WatermarkRatioFromJson(json);
  Map<String, dynamic> toJson() => _$WatermarkRatioToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class WatermarkOptions {
  const WatermarkOptions(
      {this.visibleInPreview,
      this.positionInLandscapeMode,
      this.positionInPortraitMode,
      this.watermarkRatio,
      this.mode});

  @JsonKey(name: 'visibleInPreview')
  final bool? visibleInPreview;

  @JsonKey(name: 'positionInLandscapeMode')
  final Rectangle? positionInLandscapeMode;

  @JsonKey(name: 'positionInPortraitMode')
  final Rectangle? positionInPortraitMode;

  @JsonKey(name: 'watermarkRatio')
  final WatermarkRatio? watermarkRatio;

  @JsonKey(name: 'mode')
  final WatermarkFitMode? mode;
  factory WatermarkOptions.fromJson(Map<String, dynamic> json) =>
      _$WatermarkOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$WatermarkOptionsToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RtcStats {
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

  @JsonKey(name: 'duration')
  final int? duration;

  @JsonKey(name: 'txBytes')
  final int? txBytes;

  @JsonKey(name: 'rxBytes')
  final int? rxBytes;

  @JsonKey(name: 'txAudioBytes')
  final int? txAudioBytes;

  @JsonKey(name: 'txVideoBytes')
  final int? txVideoBytes;

  @JsonKey(name: 'rxAudioBytes')
  final int? rxAudioBytes;

  @JsonKey(name: 'rxVideoBytes')
  final int? rxVideoBytes;

  @JsonKey(name: 'txKBitRate')
  final int? txKBitRate;

  @JsonKey(name: 'rxKBitRate')
  final int? rxKBitRate;

  @JsonKey(name: 'rxAudioKBitRate')
  final int? rxAudioKBitRate;

  @JsonKey(name: 'txAudioKBitRate')
  final int? txAudioKBitRate;

  @JsonKey(name: 'rxVideoKBitRate')
  final int? rxVideoKBitRate;

  @JsonKey(name: 'txVideoKBitRate')
  final int? txVideoKBitRate;

  @JsonKey(name: 'lastmileDelay')
  final int? lastmileDelay;

  @JsonKey(name: 'userCount')
  final int? userCount;

  @JsonKey(name: 'cpuAppUsage')
  final double? cpuAppUsage;

  @JsonKey(name: 'cpuTotalUsage')
  final double? cpuTotalUsage;

  @JsonKey(name: 'gatewayRtt')
  final int? gatewayRtt;

  @JsonKey(name: 'memoryAppUsageRatio')
  final double? memoryAppUsageRatio;

  @JsonKey(name: 'memoryTotalUsageRatio')
  final double? memoryTotalUsageRatio;

  @JsonKey(name: 'memoryAppUsageInKbytes')
  final int? memoryAppUsageInKbytes;

  @JsonKey(name: 'connectTimeMs')
  final int? connectTimeMs;

  @JsonKey(name: 'firstAudioPacketDuration')
  final int? firstAudioPacketDuration;

  @JsonKey(name: 'firstVideoPacketDuration')
  final int? firstVideoPacketDuration;

  @JsonKey(name: 'firstVideoKeyFramePacketDuration')
  final int? firstVideoKeyFramePacketDuration;

  @JsonKey(name: 'packetsBeforeFirstKeyFramePacket')
  final int? packetsBeforeFirstKeyFramePacket;

  @JsonKey(name: 'firstAudioPacketDurationAfterUnmute')
  final int? firstAudioPacketDurationAfterUnmute;

  @JsonKey(name: 'firstVideoPacketDurationAfterUnmute')
  final int? firstVideoPacketDurationAfterUnmute;

  @JsonKey(name: 'firstVideoKeyFramePacketDurationAfterUnmute')
  final int? firstVideoKeyFramePacketDurationAfterUnmute;

  @JsonKey(name: 'firstVideoKeyFrameDecodedDurationAfterUnmute')
  final int? firstVideoKeyFrameDecodedDurationAfterUnmute;

  @JsonKey(name: 'firstVideoKeyFrameRenderedDurationAfterUnmute')
  final int? firstVideoKeyFrameRenderedDurationAfterUnmute;

  @JsonKey(name: 'txPacketLossRate')
  final int? txPacketLossRate;

  @JsonKey(name: 'rxPacketLossRate')
  final int? rxPacketLossRate;
  factory RtcStats.fromJson(Map<String, dynamic> json) =>
      _$RtcStatsFromJson(json);
  Map<String, dynamic> toJson() => _$RtcStatsToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum VideoSourceType {
  @JsonValue(0)
  videoSourceCameraPrimary,

  @JsonValue(0)
  videoSourceCamera,

  @JsonValue(1)
  videoSourceCameraSecondary,

  @JsonValue(2)
  videoSourceScreenPrimary,

  @JsonValue(2)
  videoSourceScreen,

  @JsonValue(3)
  videoSourceScreenSecondary,

  @JsonValue(4)
  videoSourceCustom,

  @JsonValue(5)
  videoSourceMediaPlayer,

  @JsonValue(6)
  videoSourceRtcImagePng,

  @JsonValue(7)
  videoSourceRtcImageJpeg,

  @JsonValue(8)
  videoSourceRtcImageGif,

  @JsonValue(9)
  videoSourceRemote,

  @JsonValue(10)
  videoSourceTranscoded,

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

@JsonEnum(alwaysCreate: true)
enum ClientRoleType {
  @JsonValue(1)
  clientRoleBroadcaster,

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

@JsonEnum(alwaysCreate: true)
enum QualityAdaptIndication {
  @JsonValue(0)
  adaptNone,

  @JsonValue(1)
  adaptUpBandwidth,

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

@JsonEnum(alwaysCreate: true)
enum AudienceLatencyLevelType {
  @JsonValue(1)
  audienceLatencyLevelLowLatency,

  @JsonValue(2)
  audienceLatencyLevelUltraLowLatency,
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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ClientRoleOptions {
  const ClientRoleOptions({this.audienceLatencyLevel});

  @JsonKey(name: 'audienceLatencyLevel')
  final AudienceLatencyLevelType? audienceLatencyLevel;
  factory ClientRoleOptions.fromJson(Map<String, dynamic> json) =>
      _$ClientRoleOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$ClientRoleOptionsToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum ExperienceQualityType {
  @JsonValue(0)
  experienceQualityGood,

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

@JsonEnum(alwaysCreate: true)
enum ExperiencePoorReason {
  @JsonValue(0)
  experienceReasonNone,

  @JsonValue(1)
  remoteNetworkQualityPoor,

  @JsonValue(2)
  localNetworkQualityPoor,

  @JsonValue(4)
  wirelessSignalPoor,

  @JsonValue(8)
  wifiBluetoothCoexist,
}

/// Extensions functions of [ExperiencePoorReason].
extension ExperiencePoorReasonExt on ExperiencePoorReason {
  /// @nodoc
  static ExperiencePoorReason fromValue(int value) {
    return $enumDecode(_$ExperiencePoorReasonEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$ExperiencePoorReasonEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RemoteAudioStats {
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
      this.qoeQuality,
      this.qualityChangedReason});

  @JsonKey(name: 'uid')
  final int? uid;

  @JsonKey(name: 'quality')
  final int? quality;

  @JsonKey(name: 'networkTransportDelay')
  final int? networkTransportDelay;

  @JsonKey(name: 'jitterBufferDelay')
  final int? jitterBufferDelay;

  @JsonKey(name: 'audioLossRate')
  final int? audioLossRate;

  @JsonKey(name: 'numChannels')
  final int? numChannels;

  @JsonKey(name: 'receivedSampleRate')
  final int? receivedSampleRate;

  @JsonKey(name: 'receivedBitrate')
  final int? receivedBitrate;

  @JsonKey(name: 'totalFrozenTime')
  final int? totalFrozenTime;

  @JsonKey(name: 'frozenRate')
  final int? frozenRate;

  @JsonKey(name: 'mosValue')
  final int? mosValue;

  @JsonKey(name: 'totalActiveTime')
  final int? totalActiveTime;

  @JsonKey(name: 'publishDuration')
  final int? publishDuration;

  @JsonKey(name: 'qoeQuality')
  final int? qoeQuality;

  @JsonKey(name: 'qualityChangedReason')
  final int? qualityChangedReason;
  factory RemoteAudioStats.fromJson(Map<String, dynamic> json) =>
      _$RemoteAudioStatsFromJson(json);
  Map<String, dynamic> toJson() => _$RemoteAudioStatsToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum AudioProfileType {
  @JsonValue(0)
  audioProfileDefault,

  @JsonValue(1)
  audioProfileSpeechStandard,

  @JsonValue(2)
  audioProfileMusicStandard,

  @JsonValue(3)
  audioProfileMusicStandardStereo,

  @JsonValue(4)
  audioProfileMusicHighQuality,

  @JsonValue(5)
  audioProfileMusicHighQualityStereo,

  @JsonValue(6)
  audioProfileIot,

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

@JsonEnum(alwaysCreate: true)
enum AudioScenarioType {
  @JsonValue(0)
  audioScenarioDefault,

  @JsonValue(3)
  audioScenarioGameStreaming,

  @JsonValue(5)
  audioScenarioChatroom,

  @JsonValue(7)
  audioScenarioChorus,

  @JsonValue(8)
  audioScenarioMeeting,

  @JsonValue(9)
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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoFormat {
  const VideoFormat({this.width, this.height, this.fps});

  @JsonKey(name: 'width')
  final int? width;

  @JsonKey(name: 'height')
  final int? height;

  @JsonKey(name: 'fps')
  final int? fps;
  factory VideoFormat.fromJson(Map<String, dynamic> json) =>
      _$VideoFormatFromJson(json);
  Map<String, dynamic> toJson() => _$VideoFormatToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum VideoContentHint {
  @JsonValue(0)
  contentHintNone,

  @JsonValue(1)
  contentHintMotion,

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

@JsonEnum(alwaysCreate: true)
enum ScreenScenarioType {
  @JsonValue(1)
  screenScenarioDocument,

  @JsonValue(2)
  screenScenarioGaming,

  @JsonValue(3)
  screenScenarioVideo,

  @JsonValue(4)
  screenScenarioRdc,
}

/// Extensions functions of [ScreenScenarioType].
extension ScreenScenarioTypeExt on ScreenScenarioType {
  /// @nodoc
  static ScreenScenarioType fromValue(int value) {
    return $enumDecode(_$ScreenScenarioTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$ScreenScenarioTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum CaptureBrightnessLevelType {
  @JsonValue(-1)
  captureBrightnessLevelInvalid,

  @JsonValue(0)
  captureBrightnessLevelNormal,

  @JsonValue(1)
  captureBrightnessLevelBright,

  @JsonValue(2)
  captureBrightnessLevelDark,
}

/// Extensions functions of [CaptureBrightnessLevelType].
extension CaptureBrightnessLevelTypeExt on CaptureBrightnessLevelType {
  /// @nodoc
  static CaptureBrightnessLevelType fromValue(int value) {
    return $enumDecode(_$CaptureBrightnessLevelTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$CaptureBrightnessLevelTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum LocalAudioStreamState {
  @JsonValue(0)
  localAudioStreamStateStopped,

  @JsonValue(1)
  localAudioStreamStateRecording,

  @JsonValue(2)
  localAudioStreamStateEncoding,

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

@JsonEnum(alwaysCreate: true)
enum LocalAudioStreamError {
  @JsonValue(0)
  localAudioStreamErrorOk,

  @JsonValue(1)
  localAudioStreamErrorFailure,

  @JsonValue(2)
  localAudioStreamErrorDeviceNoPermission,

  @JsonValue(3)
  localAudioStreamErrorDeviceBusy,

  @JsonValue(4)
  localAudioStreamErrorRecordFailure,

  @JsonValue(5)
  localAudioStreamErrorEncodeFailure,

  @JsonValue(6)
  localAudioStreamErrorNoRecordingDevice,

  @JsonValue(7)
  localAudioStreamErrorNoPlayoutDevice,

  @JsonValue(8)
  localAudioStreamErrorInterrupted,

  @JsonValue(9)
  localAudioStreamErrorRecordInvalidId,

  @JsonValue(10)
  localAudioStreamErrorPlayoutInvalidId,
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

@JsonEnum(alwaysCreate: true)
enum LocalVideoStreamState {
  @JsonValue(0)
  localVideoStreamStateStopped,

  @JsonValue(1)
  localVideoStreamStateCapturing,

  @JsonValue(2)
  localVideoStreamStateEncoding,

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

@JsonEnum(alwaysCreate: true)
enum LocalVideoStreamError {
  @JsonValue(0)
  localVideoStreamErrorOk,

  @JsonValue(1)
  localVideoStreamErrorFailure,

  @JsonValue(2)
  localVideoStreamErrorDeviceNoPermission,

  @JsonValue(3)
  localVideoStreamErrorDeviceBusy,

  @JsonValue(4)
  localVideoStreamErrorCaptureFailure,

  @JsonValue(5)
  localVideoStreamErrorEncodeFailure,

  @JsonValue(6)
  localVideoStreamErrorCaptureInbackground,

  @JsonValue(7)
  localVideoStreamErrorCaptureMultipleForegroundApps,

  @JsonValue(8)
  localVideoStreamErrorDeviceNotFound,

  @JsonValue(9)
  localVideoStreamErrorDeviceDisconnected,

  @JsonValue(10)
  localVideoStreamErrorDeviceInvalidId,

  @JsonValue(101)
  localVideoStreamErrorDeviceSystemPressure,

  @JsonValue(11)
  localVideoStreamErrorScreenCaptureWindowMinimized,

  @JsonValue(12)
  localVideoStreamErrorScreenCaptureWindowClosed,

  @JsonValue(13)
  localVideoStreamErrorScreenCaptureWindowOccluded,

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

@JsonEnum(alwaysCreate: true)
enum RemoteAudioState {
  @JsonValue(0)
  remoteAudioStateStopped,

  @JsonValue(1)
  remoteAudioStateStarting,

  @JsonValue(2)
  remoteAudioStateDecoding,

  @JsonValue(3)
  remoteAudioStateFrozen,

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

@JsonEnum(alwaysCreate: true)
enum RemoteAudioStateReason {
  @JsonValue(0)
  remoteAudioReasonInternal,

  @JsonValue(1)
  remoteAudioReasonNetworkCongestion,

  @JsonValue(2)
  remoteAudioReasonNetworkRecovery,

  @JsonValue(3)
  remoteAudioReasonLocalMuted,

  @JsonValue(4)
  remoteAudioReasonLocalUnmuted,

  @JsonValue(5)
  remoteAudioReasonRemoteMuted,

  @JsonValue(6)
  remoteAudioReasonRemoteUnmuted,

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

@JsonEnum(alwaysCreate: true)
enum RemoteVideoState {
  @JsonValue(0)
  remoteVideoStateStopped,

  @JsonValue(1)
  remoteVideoStateStarting,

  @JsonValue(2)
  remoteVideoStateDecoding,

  @JsonValue(3)
  remoteVideoStateFrozen,

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

@JsonEnum(alwaysCreate: true)
enum RemoteVideoStateReason {
  @JsonValue(0)
  remoteVideoStateReasonInternal,

  @JsonValue(1)
  remoteVideoStateReasonNetworkCongestion,

  @JsonValue(2)
  remoteVideoStateReasonNetworkRecovery,

  @JsonValue(3)
  remoteVideoStateReasonLocalMuted,

  @JsonValue(4)
  remoteVideoStateReasonLocalUnmuted,

  @JsonValue(5)
  remoteVideoStateReasonRemoteMuted,

  @JsonValue(6)
  remoteVideoStateReasonRemoteUnmuted,

  @JsonValue(7)
  remoteVideoStateReasonRemoteOffline,

  @JsonValue(8)
  remoteVideoStateReasonAudioFallback,

  @JsonValue(9)
  remoteVideoStateReasonAudioFallbackRecovery,

  @JsonValue(10)
  remoteVideoStateReasonVideoStreamTypeChangeToLow,

  @JsonValue(11)
  remoteVideoStateReasonVideoStreamTypeChangeToHigh,

  @JsonValue(12)
  remoteVideoStateReasonSdkInBackground,
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

@JsonEnum(alwaysCreate: true)
enum RemoteUserState {
  @JsonValue((1 << 0))
  userStateMuteAudio,

  @JsonValue((1 << 1))
  userStateMuteVideo,

  @JsonValue((1 << 4))
  userStateEnableVideo,

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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoTrackInfo {
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

  @JsonKey(name: 'isLocal')
  final bool? isLocal;

  @JsonKey(name: 'ownerUid')
  final int? ownerUid;

  @JsonKey(name: 'trackId')
  final int? trackId;

  @JsonKey(name: 'channelId')
  final String? channelId;

  @JsonKey(name: 'streamType')
  final VideoStreamType? streamType;

  @JsonKey(name: 'codecType')
  final VideoCodecType? codecType;

  @JsonKey(name: 'encodedFrameOnly')
  final bool? encodedFrameOnly;

  @JsonKey(name: 'sourceType')
  final VideoSourceType? sourceType;

  @JsonKey(name: 'observationPosition')
  final int? observationPosition;
  factory VideoTrackInfo.fromJson(Map<String, dynamic> json) =>
      _$VideoTrackInfoFromJson(json);
  Map<String, dynamic> toJson() => _$VideoTrackInfoToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum RemoteVideoDownscaleLevel {
  @JsonValue(0)
  remoteVideoDownscaleLevelNone,

  @JsonValue(1)
  remoteVideoDownscaleLevel1,

  @JsonValue(2)
  remoteVideoDownscaleLevel2,

  @JsonValue(3)
  remoteVideoDownscaleLevel3,

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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioVolumeInfo {
  const AudioVolumeInfo({this.uid, this.volume, this.vad, this.voicePitch});

  @JsonKey(name: 'uid')
  final int? uid;

  @JsonKey(name: 'volume')
  final int? volume;

  @JsonKey(name: 'vad')
  final int? vad;

  @JsonKey(name: 'voicePitch')
  final double? voicePitch;
  factory AudioVolumeInfo.fromJson(Map<String, dynamic> json) =>
      _$AudioVolumeInfoFromJson(json);
  Map<String, dynamic> toJson() => _$AudioVolumeInfoToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class DeviceInfo {
  const DeviceInfo({this.isLowLatencyAudioSupported});

  @JsonKey(name: 'isLowLatencyAudioSupported')
  final bool? isLowLatencyAudioSupported;
  factory DeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceInfoToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Packet {
  const Packet({this.buffer, this.size});

  @JsonKey(name: 'buffer', ignore: true)
  final Uint8List? buffer;

  @JsonKey(name: 'size')
  final int? size;
  factory Packet.fromJson(Map<String, dynamic> json) => _$PacketFromJson(json);
  Map<String, dynamic> toJson() => _$PacketToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum AudioSampleRateType {
  @JsonValue(32000)
  audioSampleRate32000,

  @JsonValue(44100)
  audioSampleRate44100,

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

@JsonEnum(alwaysCreate: true)
enum VideoCodecTypeForStream {
  @JsonValue(1)
  videoCodecH264ForStream,

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

@JsonEnum(alwaysCreate: true)
enum VideoCodecProfileType {
  @JsonValue(66)
  videoCodecProfileBaseline,

  @JsonValue(77)
  videoCodecProfileMain,

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

@JsonEnum(alwaysCreate: true)
enum AudioCodecProfileType {
  @JsonValue(0)
  audioCodecProfileLcAac,

  @JsonValue(1)
  audioCodecProfileHeAac,

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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LocalAudioStats {
  const LocalAudioStats(
      {this.numChannels,
      this.sentSampleRate,
      this.sentBitrate,
      this.internalCodec,
      this.txPacketLossRate,
      this.audioDeviceDelay});

  @JsonKey(name: 'numChannels')
  final int? numChannels;

  @JsonKey(name: 'sentSampleRate')
  final int? sentSampleRate;

  @JsonKey(name: 'sentBitrate')
  final int? sentBitrate;

  @JsonKey(name: 'internalCodec')
  final int? internalCodec;

  @JsonKey(name: 'txPacketLossRate')
  final int? txPacketLossRate;

  @JsonKey(name: 'audioDeviceDelay')
  final int? audioDeviceDelay;
  factory LocalAudioStats.fromJson(Map<String, dynamic> json) =>
      _$LocalAudioStatsFromJson(json);
  Map<String, dynamic> toJson() => _$LocalAudioStatsToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum RtmpStreamPublishState {
  @JsonValue(0)
  rtmpStreamPublishStateIdle,

  @JsonValue(1)
  rtmpStreamPublishStateConnecting,

  @JsonValue(2)
  rtmpStreamPublishStateRunning,

  @JsonValue(3)
  rtmpStreamPublishStateRecovering,

  @JsonValue(4)
  rtmpStreamPublishStateFailure,

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

@JsonEnum(alwaysCreate: true)
enum RtmpStreamPublishErrorType {
  @JsonValue(0)
  rtmpStreamPublishErrorOk,

  @JsonValue(1)
  rtmpStreamPublishErrorInvalidArgument,

  @JsonValue(2)
  rtmpStreamPublishErrorEncryptedStreamNotAllowed,

  @JsonValue(3)
  rtmpStreamPublishErrorConnectionTimeout,

  @JsonValue(4)
  rtmpStreamPublishErrorInternalServerError,

  @JsonValue(5)
  rtmpStreamPublishErrorRtmpServerError,

  @JsonValue(6)
  rtmpStreamPublishErrorTooOften,

  @JsonValue(7)
  rtmpStreamPublishErrorReachLimit,

  @JsonValue(8)
  rtmpStreamPublishErrorNotAuthorized,

  @JsonValue(9)
  rtmpStreamPublishErrorStreamNotFound,

  @JsonValue(10)
  rtmpStreamPublishErrorFormatNotSupported,

  @JsonValue(11)
  rtmpStreamPublishErrorNotBroadcaster,

  @JsonValue(13)
  rtmpStreamPublishErrorTranscodingNoMixStream,

  @JsonValue(14)
  rtmpStreamPublishErrorNetDown,

  @JsonValue(15)
  rtmpStreamPublishErrorInvalidAppid,

  @JsonValue(16)
  rtmpStreamPublishErrorInvalidPrivilege,

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

@JsonEnum(alwaysCreate: true)
enum RtmpStreamingEvent {
  @JsonValue(1)
  rtmpStreamingEventFailedLoadImage,

  @JsonValue(2)
  rtmpStreamingEventUrlAlreadyInUse,

  @JsonValue(3)
  rtmpStreamingEventAdvancedFeatureNotSupport,

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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RtcImage {
  const RtcImage(
      {this.url,
      this.x,
      this.y,
      this.width,
      this.height,
      this.zOrder,
      this.alpha});

  @JsonKey(name: 'url')
  final String? url;

  @JsonKey(name: 'x')
  final int? x;

  @JsonKey(name: 'y')
  final int? y;

  @JsonKey(name: 'width')
  final int? width;

  @JsonKey(name: 'height')
  final int? height;

  @JsonKey(name: 'zOrder')
  final int? zOrder;

  @JsonKey(name: 'alpha')
  final double? alpha;
  factory RtcImage.fromJson(Map<String, dynamic> json) =>
      _$RtcImageFromJson(json);
  Map<String, dynamic> toJson() => _$RtcImageToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LiveStreamAdvancedFeature {
  const LiveStreamAdvancedFeature({this.featureName, this.opened});

  @JsonKey(name: 'featureName')
  final String? featureName;

  @JsonKey(name: 'opened')
  final bool? opened;
  factory LiveStreamAdvancedFeature.fromJson(Map<String, dynamic> json) =>
      _$LiveStreamAdvancedFeatureFromJson(json);
  Map<String, dynamic> toJson() => _$LiveStreamAdvancedFeatureToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum ConnectionStateType {
  @JsonValue(1)
  connectionStateDisconnected,

  @JsonValue(2)
  connectionStateConnecting,

  @JsonValue(3)
  connectionStateConnected,

  @JsonValue(4)
  connectionStateReconnecting,

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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TranscodingUser {
  const TranscodingUser(
      {this.uid,
      this.x,
      this.y,
      this.width,
      this.height,
      this.zOrder,
      this.alpha,
      this.audioChannel});

  @JsonKey(name: 'uid')
  final int? uid;

  @JsonKey(name: 'x')
  final int? x;

  @JsonKey(name: 'y')
  final int? y;

  @JsonKey(name: 'width')
  final int? width;

  @JsonKey(name: 'height')
  final int? height;

  @JsonKey(name: 'zOrder')
  final int? zOrder;

  @JsonKey(name: 'alpha')
  final double? alpha;

  @JsonKey(name: 'audioChannel')
  final int? audioChannel;
  factory TranscodingUser.fromJson(Map<String, dynamic> json) =>
      _$TranscodingUserFromJson(json);
  Map<String, dynamic> toJson() => _$TranscodingUserToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LiveTranscoding {
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

  @JsonKey(name: 'width')
  final int? width;

  @JsonKey(name: 'height')
  final int? height;

  @JsonKey(name: 'videoBitrate')
  final int? videoBitrate;

  @JsonKey(name: 'videoFramerate')
  final int? videoFramerate;

  @JsonKey(name: 'lowLatency')
  final bool? lowLatency;

  @JsonKey(name: 'videoGop')
  final int? videoGop;

  @JsonKey(name: 'videoCodecProfile')
  final VideoCodecProfileType? videoCodecProfile;

  @JsonKey(name: 'backgroundColor')
  final int? backgroundColor;

  @JsonKey(name: 'videoCodecType')
  final VideoCodecTypeForStream? videoCodecType;

  @JsonKey(name: 'userCount')
  final int? userCount;

  @JsonKey(name: 'transcodingUsers')
  final List<TranscodingUser>? transcodingUsers;

  @JsonKey(name: 'transcodingExtraInfo')
  final String? transcodingExtraInfo;

  @JsonKey(name: 'metadata')
  final String? metadata;

  @JsonKey(name: 'watermark')
  final List<RtcImage>? watermark;

  @JsonKey(name: 'watermarkCount')
  final int? watermarkCount;

  @JsonKey(name: 'backgroundImage')
  final List<RtcImage>? backgroundImage;

  @JsonKey(name: 'backgroundImageCount')
  final int? backgroundImageCount;

  @JsonKey(name: 'audioSampleRate')
  final AudioSampleRateType? audioSampleRate;

  @JsonKey(name: 'audioBitrate')
  final int? audioBitrate;

  @JsonKey(name: 'audioChannels')
  final int? audioChannels;

  @JsonKey(name: 'audioCodecProfile')
  final AudioCodecProfileType? audioCodecProfile;

  @JsonKey(name: 'advancedFeatures')
  final List<LiveStreamAdvancedFeature>? advancedFeatures;

  @JsonKey(name: 'advancedFeatureCount')
  final int? advancedFeatureCount;
  factory LiveTranscoding.fromJson(Map<String, dynamic> json) =>
      _$LiveTranscodingFromJson(json);
  Map<String, dynamic> toJson() => _$LiveTranscodingToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TranscodingVideoStream {
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

  @JsonKey(name: 'sourceType')
  final MediaSourceType? sourceType;

  @JsonKey(name: 'remoteUserUid')
  final int? remoteUserUid;

  @JsonKey(name: 'imageUrl')
  final String? imageUrl;

  @JsonKey(name: 'x')
  final int? x;

  @JsonKey(name: 'y')
  final int? y;

  @JsonKey(name: 'width')
  final int? width;

  @JsonKey(name: 'height')
  final int? height;

  @JsonKey(name: 'zOrder')
  final int? zOrder;

  @JsonKey(name: 'alpha')
  final double? alpha;

  @JsonKey(name: 'mirror')
  final bool? mirror;
  factory TranscodingVideoStream.fromJson(Map<String, dynamic> json) =>
      _$TranscodingVideoStreamFromJson(json);
  Map<String, dynamic> toJson() => _$TranscodingVideoStreamToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LocalTranscoderConfiguration {
  const LocalTranscoderConfiguration(
      {this.streamCount,
      this.videoInputStreams,
      this.videoOutputConfiguration});

  @JsonKey(name: 'streamCount')
  final int? streamCount;

  @JsonKey(name: 'VideoInputStreams')
  final List<TranscodingVideoStream>? videoInputStreams;

  @JsonKey(name: 'videoOutputConfiguration')
  final VideoEncoderConfiguration? videoOutputConfiguration;
  factory LocalTranscoderConfiguration.fromJson(Map<String, dynamic> json) =>
      _$LocalTranscoderConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$LocalTranscoderConfigurationToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LastmileProbeConfig {
  const LastmileProbeConfig(
      {this.probeUplink,
      this.probeDownlink,
      this.expectedUplinkBitrate,
      this.expectedDownlinkBitrate});

  @JsonKey(name: 'probeUplink')
  final bool? probeUplink;

  @JsonKey(name: 'probeDownlink')
  final bool? probeDownlink;

  @JsonKey(name: 'expectedUplinkBitrate')
  final int? expectedUplinkBitrate;

  @JsonKey(name: 'expectedDownlinkBitrate')
  final int? expectedDownlinkBitrate;
  factory LastmileProbeConfig.fromJson(Map<String, dynamic> json) =>
      _$LastmileProbeConfigFromJson(json);
  Map<String, dynamic> toJson() => _$LastmileProbeConfigToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum LastmileProbeResultState {
  @JsonValue(1)
  lastmileProbeResultComplete,

  @JsonValue(2)
  lastmileProbeResultIncompleteNoBwe,

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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LastmileProbeOneWayResult {
  const LastmileProbeOneWayResult(
      {this.packetLossRate, this.jitter, this.availableBandwidth});

  @JsonKey(name: 'packetLossRate')
  final int? packetLossRate;

  @JsonKey(name: 'jitter')
  final int? jitter;

  @JsonKey(name: 'availableBandwidth')
  final int? availableBandwidth;
  factory LastmileProbeOneWayResult.fromJson(Map<String, dynamic> json) =>
      _$LastmileProbeOneWayResultFromJson(json);
  Map<String, dynamic> toJson() => _$LastmileProbeOneWayResultToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LastmileProbeResult {
  const LastmileProbeResult(
      {this.state, this.uplinkReport, this.downlinkReport, this.rtt});

  @JsonKey(name: 'state')
  final LastmileProbeResultState? state;

  @JsonKey(name: 'uplinkReport')
  final LastmileProbeOneWayResult? uplinkReport;

  @JsonKey(name: 'downlinkReport')
  final LastmileProbeOneWayResult? downlinkReport;

  @JsonKey(name: 'rtt')
  final int? rtt;
  factory LastmileProbeResult.fromJson(Map<String, dynamic> json) =>
      _$LastmileProbeResultFromJson(json);
  Map<String, dynamic> toJson() => _$LastmileProbeResultToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum ConnectionChangedReasonType {
  @JsonValue(0)
  connectionChangedConnecting,

  @JsonValue(1)
  connectionChangedJoinSuccess,

  @JsonValue(2)
  connectionChangedInterrupted,

  @JsonValue(3)
  connectionChangedBannedByServer,

  @JsonValue(4)
  connectionChangedJoinFailed,

  @JsonValue(5)
  connectionChangedLeaveChannel,

  @JsonValue(6)
  connectionChangedInvalidAppId,

  @JsonValue(7)
  connectionChangedInvalidChannelName,

  @JsonValue(8)
  connectionChangedInvalidToken,

  @JsonValue(9)
  connectionChangedTokenExpired,

  @JsonValue(10)
  connectionChangedRejectedByServer,

  @JsonValue(11)
  connectionChangedSettingProxyServer,

  @JsonValue(12)
  connectionChangedRenewToken,

  @JsonValue(13)
  connectionChangedClientIpAddressChanged,

  @JsonValue(14)
  connectionChangedKeepAliveTimeout,

  @JsonValue(15)
  connectionChangedRejoinSuccess,

  @JsonValue(16)
  connectionChangedLost,

  @JsonValue(17)
  connectionChangedEchoTest,

  @JsonValue(18)
  connectionChangedClientIpAddressChangedByUser,

  @JsonValue(19)
  connectionChangedSameUidLogin,

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

@JsonEnum(alwaysCreate: true)
enum ClientRoleChangeFailedReason {
  @JsonValue(1)
  clientRoleChangeFailedTooManyBroadcasters,

  @JsonValue(2)
  clientRoleChangeFailedNotAuthorized,

  @JsonValue(3)
  clientRoleChangeFailedRequestTimeOut,

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

@JsonEnum(alwaysCreate: true)
enum WlaccMessageReason {
  @JsonValue(0)
  wlaccMessageReasonWeakSignal,

  @JsonValue(1)
  wlaccMessageReasonChannelCongestion,
}

/// Extensions functions of [WlaccMessageReason].
extension WlaccMessageReasonExt on WlaccMessageReason {
  /// @nodoc
  static WlaccMessageReason fromValue(int value) {
    return $enumDecode(_$WlaccMessageReasonEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$WlaccMessageReasonEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum WlaccSuggestAction {
  @JsonValue(0)
  wlaccSuggestActionCloseToWifi,

  @JsonValue(1)
  wlaccSuggestActionConnectSsid,

  @JsonValue(2)
  wlaccSuggestActionCheck5g,

  @JsonValue(3)
  wlaccSuggestActionModifySsid,
}

/// Extensions functions of [WlaccSuggestAction].
extension WlaccSuggestActionExt on WlaccSuggestAction {
  /// @nodoc
  static WlaccSuggestAction fromValue(int value) {
    return $enumDecode(_$WlaccSuggestActionEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$WlaccSuggestActionEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class WlAccStats {
  const WlAccStats(
      {this.e2eDelayPercent, this.frozenRatioPercent, this.lossRatePercent});

  @JsonKey(name: 'e2eDelayPercent')
  final int? e2eDelayPercent;

  @JsonKey(name: 'frozenRatioPercent')
  final int? frozenRatioPercent;

  @JsonKey(name: 'lossRatePercent')
  final int? lossRatePercent;
  factory WlAccStats.fromJson(Map<String, dynamic> json) =>
      _$WlAccStatsFromJson(json);
  Map<String, dynamic> toJson() => _$WlAccStatsToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum NetworkType {
  @JsonValue(-1)
  networkTypeUnknown,

  @JsonValue(0)
  networkTypeDisconnected,

  @JsonValue(1)
  networkTypeLan,

  @JsonValue(2)
  networkTypeWifi,

  @JsonValue(3)
  networkTypeMobile2g,

  @JsonValue(4)
  networkTypeMobile3g,

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

@JsonEnum(alwaysCreate: true)
enum VideoViewSetupMode {
  @JsonValue(0)
  videoViewSetupReplace,

  @JsonValue(1)
  videoViewSetupAdd,

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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoCanvas {
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

  @JsonKey(name: 'view')
  final int? view;

  @JsonKey(name: 'renderMode')
  final RenderModeType? renderMode;

  @JsonKey(name: 'mirrorMode')
  final VideoMirrorModeType? mirrorMode;

  @JsonKey(name: 'uid')
  final int? uid;

  @JsonKey(name: 'isScreenView')
  final bool? isScreenView;

  @JsonKey(name: 'priv', ignore: true)
  final Uint8List? priv;

  @JsonKey(name: 'priv_size')
  final int? privSize;

  @JsonKey(name: 'sourceType')
  final VideoSourceType? sourceType;

  @JsonKey(name: 'cropArea')
  final Rectangle? cropArea;

  @JsonKey(name: 'setupMode')
  final VideoViewSetupMode? setupMode;
  factory VideoCanvas.fromJson(Map<String, dynamic> json) =>
      _$VideoCanvasFromJson(json);
  Map<String, dynamic> toJson() => _$VideoCanvasToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class BeautyOptions {
  const BeautyOptions(
      {this.lighteningContrastLevel,
      this.lighteningLevel,
      this.smoothnessLevel,
      this.rednessLevel,
      this.sharpnessLevel});

  @JsonKey(name: 'lighteningContrastLevel')
  final LighteningContrastLevel? lighteningContrastLevel;

  @JsonKey(name: 'lighteningLevel')
  final double? lighteningLevel;

  @JsonKey(name: 'smoothnessLevel')
  final double? smoothnessLevel;

  @JsonKey(name: 'rednessLevel')
  final double? rednessLevel;

  @JsonKey(name: 'sharpnessLevel')
  final double? sharpnessLevel;
  factory BeautyOptions.fromJson(Map<String, dynamic> json) =>
      _$BeautyOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$BeautyOptionsToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum LighteningContrastLevel {
  @JsonValue(0)
  lighteningContrastLow,

  @JsonValue(1)
  lighteningContrastNormal,

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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LowlightEnhanceOptions {
  const LowlightEnhanceOptions({this.mode, this.level});

  @JsonKey(name: 'mode')
  final LowLightEnhanceMode? mode;

  @JsonKey(name: 'level')
  final LowLightEnhanceLevel? level;
  factory LowlightEnhanceOptions.fromJson(Map<String, dynamic> json) =>
      _$LowlightEnhanceOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$LowlightEnhanceOptionsToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum LowLightEnhanceMode {
  @JsonValue(0)
  lowLightEnhanceAuto,

  @JsonValue(1)
  lowLightEnhanceManual,
}

/// Extensions functions of [LowLightEnhanceMode].
extension LowLightEnhanceModeExt on LowLightEnhanceMode {
  /// @nodoc
  static LowLightEnhanceMode fromValue(int value) {
    return $enumDecode(_$LowLightEnhanceModeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$LowLightEnhanceModeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum LowLightEnhanceLevel {
  @JsonValue(0)
  lowLightEnhanceLevelHighQuality,

  @JsonValue(1)
  lowLightEnhanceLevelFast,
}

/// Extensions functions of [LowLightEnhanceLevel].
extension LowLightEnhanceLevelExt on LowLightEnhanceLevel {
  /// @nodoc
  static LowLightEnhanceLevel fromValue(int value) {
    return $enumDecode(_$LowLightEnhanceLevelEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$LowLightEnhanceLevelEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoDenoiserOptions {
  const VideoDenoiserOptions({this.mode, this.level});

  @JsonKey(name: 'mode')
  final VideoDenoiserMode? mode;

  @JsonKey(name: 'level')
  final VideoDenoiserLevel? level;
  factory VideoDenoiserOptions.fromJson(Map<String, dynamic> json) =>
      _$VideoDenoiserOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$VideoDenoiserOptionsToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum VideoDenoiserMode {
  @JsonValue(0)
  videoDenoiserAuto,

  @JsonValue(1)
  videoDenoiserManual,
}

/// Extensions functions of [VideoDenoiserMode].
extension VideoDenoiserModeExt on VideoDenoiserMode {
  /// @nodoc
  static VideoDenoiserMode fromValue(int value) {
    return $enumDecode(_$VideoDenoiserModeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$VideoDenoiserModeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum VideoDenoiserLevel {
  @JsonValue(0)
  videoDenoiserLevelHighQuality,

  @JsonValue(1)
  videoDenoiserLevelFast,

  @JsonValue(2)
  videoDenoiserLevelStrength,
}

/// Extensions functions of [VideoDenoiserLevel].
extension VideoDenoiserLevelExt on VideoDenoiserLevel {
  /// @nodoc
  static VideoDenoiserLevel fromValue(int value) {
    return $enumDecode(_$VideoDenoiserLevelEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$VideoDenoiserLevelEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ColorEnhanceOptions {
  const ColorEnhanceOptions({this.strengthLevel, this.skinProtectLevel});

  @JsonKey(name: 'strengthLevel')
  final double? strengthLevel;

  @JsonKey(name: 'skinProtectLevel')
  final double? skinProtectLevel;
  factory ColorEnhanceOptions.fromJson(Map<String, dynamic> json) =>
      _$ColorEnhanceOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$ColorEnhanceOptionsToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VirtualBackgroundSource {
  const VirtualBackgroundSource(
      {this.backgroundSourceType, this.color, this.source, this.blurDegree});

  @JsonKey(name: 'background_source_type')
  final BackgroundSourceType? backgroundSourceType;

  @JsonKey(name: 'color')
  final int? color;

  @JsonKey(name: 'source')
  final String? source;

  @JsonKey(name: 'blur_degree')
  final BackgroundBlurDegree? blurDegree;
  factory VirtualBackgroundSource.fromJson(Map<String, dynamic> json) =>
      _$VirtualBackgroundSourceFromJson(json);
  Map<String, dynamic> toJson() => _$VirtualBackgroundSourceToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum BackgroundSourceType {
  @JsonValue(1)
  backgroundColor,

  @JsonValue(2)
  backgroundImg,

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

@JsonEnum(alwaysCreate: true)
enum BackgroundBlurDegree {
  @JsonValue(1)
  blurDegreeLow,

  @JsonValue(2)
  blurDegreeMedium,

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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SegmentationProperty {
  const SegmentationProperty({this.modelType, this.greenCapacity});

  @JsonKey(name: 'modelType')
  final SegModelType? modelType;

  @JsonKey(name: 'greenCapacity')
  final double? greenCapacity;
  factory SegmentationProperty.fromJson(Map<String, dynamic> json) =>
      _$SegmentationPropertyFromJson(json);
  Map<String, dynamic> toJson() => _$SegmentationPropertyToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum SegModelType {
  @JsonValue(1)
  segModelAi,

  @JsonValue(2)
  segModelGreen,
}

/// Extensions functions of [SegModelType].
extension SegModelTypeExt on SegModelType {
  /// @nodoc
  static SegModelType fromValue(int value) {
    return $enumDecode(_$SegModelTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$SegModelTypeEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum VoiceBeautifierPreset {
  @JsonValue(0x00000000)
  voiceBeautifierOff,

  @JsonValue(0x01010100)
  chatBeautifierMagnetic,

  @JsonValue(0x01010200)
  chatBeautifierFresh,

  @JsonValue(0x01010300)
  chatBeautifierVitality,

  @JsonValue(0x01020100)
  singingBeautifier,

  @JsonValue(0x01030100)
  timbreTransformationVigorous,

  @JsonValue(0x01030200)
  timbreTransformationDeep,

  @JsonValue(0x01030300)
  timbreTransformationMellow,

  @JsonValue(0x01030400)
  timbreTransformationFalsetto,

  @JsonValue(0x01030500)
  timbreTransformationFull,

  @JsonValue(0x01030600)
  timbreTransformationClear,

  @JsonValue(0x01030700)
  timbreTransformationResounding,

  @JsonValue(0x01030800)
  timbreTransformationRinging,

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

@JsonEnum(alwaysCreate: true)
enum AudioEffectPreset {
  @JsonValue(0x00000000)
  audioEffectOff,

  @JsonValue(0x02010100)
  roomAcousticsKtv,

  @JsonValue(0x02010200)
  roomAcousticsVocalConcert,

  @JsonValue(0x02010300)
  roomAcousticsStudio,

  @JsonValue(0x02010400)
  roomAcousticsPhonograph,

  @JsonValue(0x02010500)
  roomAcousticsVirtualStereo,

  @JsonValue(0x02010600)
  roomAcousticsSpacial,

  @JsonValue(0x02010700)
  roomAcousticsEthereal,

  @JsonValue(0x02010800)
  roomAcoustics3dVoice,

  @JsonValue(0x02010900)
  roomAcousticsVirtualSurroundSound,

  @JsonValue(0x02020100)
  voiceChangerEffectUncle,

  @JsonValue(0x02020200)
  voiceChangerEffectOldman,

  @JsonValue(0x02020300)
  voiceChangerEffectBoy,

  @JsonValue(0x02020400)
  voiceChangerEffectSister,

  @JsonValue(0x02020500)
  voiceChangerEffectGirl,

  @JsonValue(0x02020600)
  voiceChangerEffectPigking,

  @JsonValue(0x02020700)
  voiceChangerEffectHulk,

  @JsonValue(0x02030100)
  styleTransformationRnb,

  @JsonValue(0x02030200)
  styleTransformationPopular,

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

@JsonEnum(alwaysCreate: true)
enum VoiceConversionPreset {
  @JsonValue(0x00000000)
  voiceConversionOff,

  @JsonValue(0x03010100)
  voiceChangerNeutral,

  @JsonValue(0x03010200)
  voiceChangerSweet,

  @JsonValue(0x03010300)
  voiceChangerSolid,

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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ScreenCaptureParameters {
  const ScreenCaptureParameters(
      {this.dimensions,
      this.frameRate,
      this.bitrate,
      this.captureMouseCursor,
      this.windowFocus,
      this.excludeWindowList,
      this.excludeWindowCount,
      this.highLightWidth,
      this.highLightColor,
      this.enableHighLight});

  @JsonKey(name: 'dimensions')
  final VideoDimensions? dimensions;

  @JsonKey(name: 'frameRate')
  final int? frameRate;

  @JsonKey(name: 'bitrate')
  final int? bitrate;

  @JsonKey(name: 'captureMouseCursor')
  final bool? captureMouseCursor;

  @JsonKey(name: 'windowFocus')
  final bool? windowFocus;

  @JsonKey(name: 'excludeWindowList')
  final List<int>? excludeWindowList;

  @JsonKey(name: 'excludeWindowCount')
  final int? excludeWindowCount;

  @JsonKey(name: 'highLightWidth')
  final int? highLightWidth;

  @JsonKey(name: 'highLightColor')
  final int? highLightColor;

  @JsonKey(name: 'enableHighLight')
  final bool? enableHighLight;
  factory ScreenCaptureParameters.fromJson(Map<String, dynamic> json) =>
      _$ScreenCaptureParametersFromJson(json);
  Map<String, dynamic> toJson() => _$ScreenCaptureParametersToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum AudioRecordingQualityType {
  @JsonValue(0)
  audioRecordingQualityLow,

  @JsonValue(1)
  audioRecordingQualityMedium,

  @JsonValue(2)
  audioRecordingQualityHigh,

  @JsonValue(3)
  audioRecordingQualityUltraHigh,
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

@JsonEnum(alwaysCreate: true)
enum AudioFileRecordingType {
  @JsonValue(1)
  audioFileRecordingMic,

  @JsonValue(2)
  audioFileRecordingPlayback,

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

@JsonEnum(alwaysCreate: true)
enum AudioEncodedFrameObserverPosition {
  @JsonValue(1)
  audioEncodedFrameObserverPositionRecord,

  @JsonValue(2)
  audioEncodedFrameObserverPositionPlayback,

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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioRecordingConfiguration {
  const AudioRecordingConfiguration(
      {this.filePath,
      this.encode,
      this.sampleRate,
      this.fileRecordingType,
      this.quality,
      this.recordingChannel});

  @JsonKey(name: 'filePath')
  final String? filePath;

  @JsonKey(name: 'encode')
  final bool? encode;

  @JsonKey(name: 'sampleRate')
  final int? sampleRate;

  @JsonKey(name: 'fileRecordingType')
  final AudioFileRecordingType? fileRecordingType;

  @JsonKey(name: 'quality')
  final AudioRecordingQualityType? quality;

  @JsonKey(name: 'recordingChannel')
  final int? recordingChannel;
  factory AudioRecordingConfiguration.fromJson(Map<String, dynamic> json) =>
      _$AudioRecordingConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$AudioRecordingConfigurationToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioEncodedFrameObserverConfig {
  const AudioEncodedFrameObserverConfig({this.postionType, this.encodingType});

  @JsonKey(name: 'postionType')
  final AudioEncodedFrameObserverPosition? postionType;

  @JsonKey(name: 'encodingType')
  final AudioEncodingType? encodingType;
  factory AudioEncodedFrameObserverConfig.fromJson(Map<String, dynamic> json) =>
      _$AudioEncodedFrameObserverConfigFromJson(json);
  Map<String, dynamic> toJson() =>
      _$AudioEncodedFrameObserverConfigToJson(this);
}

class AudioEncodedFrameObserver {
  /// Construct the [AudioEncodedFrameObserver].
  const AudioEncodedFrameObserver({
    this.onRecordAudioEncodedFrame,
    this.onPlaybackAudioEncodedFrame,
    this.onMixedAudioEncodedFrame,
  });

  final void Function(Uint8List frameBuffer, int length,
      EncodedAudioFrameInfo audioEncodedFrameInfo)? onRecordAudioEncodedFrame;

  final void Function(Uint8List frameBuffer, int length,
      EncodedAudioFrameInfo audioEncodedFrameInfo)? onPlaybackAudioEncodedFrame;

  final void Function(Uint8List frameBuffer, int length,
      EncodedAudioFrameInfo audioEncodedFrameInfo)? onMixedAudioEncodedFrame;
}

@JsonEnum(alwaysCreate: true)
enum AreaCode {
  @JsonValue(0x00000001)
  areaCodeCn,

  @JsonValue(0x00000002)
  areaCodeNa,

  @JsonValue(0x00000004)
  areaCodeEu,

  @JsonValue(0x00000008)
  areaCodeAs,

  @JsonValue(0x00000010)
  areaCodeJp,

  @JsonValue(0x00000020)
  areaCodeIn,

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

@JsonEnum(alwaysCreate: true)
enum AreaCodeEx {
  @JsonValue(0x00000040)
  areaCodeOc,

  @JsonValue(0x00000080)
  areaCodeSa,

  @JsonValue(0x00000100)
  areaCodeAf,

  @JsonValue(0x00000200)
  areaCodeKr,

  @JsonValue(0x00000400)
  areaCodeHkmc,

  @JsonValue(0x00000800)
  areaCodeUs,

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

@JsonEnum(alwaysCreate: true)
enum ChannelMediaRelayError {
  @JsonValue(0)
  relayOk,

  @JsonValue(1)
  relayErrorServerErrorResponse,

  @JsonValue(2)
  relayErrorServerNoResponse,

  @JsonValue(3)
  relayErrorNoResourceAvailable,

  @JsonValue(4)
  relayErrorFailedJoinSrc,

  @JsonValue(5)
  relayErrorFailedJoinDest,

  @JsonValue(6)
  relayErrorFailedPacketReceivedFromSrc,

  @JsonValue(7)
  relayErrorFailedPacketSentToDest,

  @JsonValue(8)
  relayErrorServerConnectionLost,

  @JsonValue(9)
  relayErrorInternalError,

  @JsonValue(10)
  relayErrorSrcTokenExpired,

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

@JsonEnum(alwaysCreate: true)
enum ChannelMediaRelayEvent {
  @JsonValue(0)
  relayEventNetworkDisconnected,

  @JsonValue(1)
  relayEventNetworkConnected,

  @JsonValue(2)
  relayEventPacketJoinedSrcChannel,

  @JsonValue(3)
  relayEventPacketJoinedDestChannel,

  @JsonValue(4)
  relayEventPacketSentToDestChannel,

  @JsonValue(5)
  relayEventPacketReceivedVideoFromSrc,

  @JsonValue(6)
  relayEventPacketReceivedAudioFromSrc,

  @JsonValue(7)
  relayEventPacketUpdateDestChannel,

  @JsonValue(8)
  relayEventPacketUpdateDestChannelRefused,

  @JsonValue(9)
  relayEventPacketUpdateDestChannelNotChange,

  @JsonValue(10)
  relayEventPacketUpdateDestChannelIsNull,

  @JsonValue(11)
  relayEventVideoProfileUpdate,

  @JsonValue(12)
  relayEventPauseSendPacketToDestChannelSuccess,

  @JsonValue(13)
  relayEventPauseSendPacketToDestChannelFailed,

  @JsonValue(14)
  relayEventResumeSendPacketToDestChannelSuccess,

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

@JsonEnum(alwaysCreate: true)
enum ChannelMediaRelayState {
  @JsonValue(0)
  relayStateIdle,

  @JsonValue(1)
  relayStateConnecting,

  @JsonValue(2)
  relayStateRunning,

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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ChannelMediaInfo {
  const ChannelMediaInfo({this.channelName, this.token, this.uid});

  @JsonKey(name: 'channelName')
  final String? channelName;

  @JsonKey(name: 'token')
  final String? token;

  @JsonKey(name: 'uid')
  final int? uid;
  factory ChannelMediaInfo.fromJson(Map<String, dynamic> json) =>
      _$ChannelMediaInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ChannelMediaInfoToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ChannelMediaRelayConfiguration {
  const ChannelMediaRelayConfiguration(
      {this.srcInfo, this.destInfos, this.destCount});

  @JsonKey(name: 'srcInfo')
  final ChannelMediaInfo? srcInfo;

  @JsonKey(name: 'destInfos')
  final List<ChannelMediaInfo>? destInfos;

  @JsonKey(name: 'destCount')
  final int? destCount;
  factory ChannelMediaRelayConfiguration.fromJson(Map<String, dynamic> json) =>
      _$ChannelMediaRelayConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$ChannelMediaRelayConfigurationToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class UplinkNetworkInfo {
  const UplinkNetworkInfo({this.videoEncoderTargetBitrateBps});

  @JsonKey(name: 'video_encoder_target_bitrate_bps')
  final int? videoEncoderTargetBitrateBps;
  factory UplinkNetworkInfo.fromJson(Map<String, dynamic> json) =>
      _$UplinkNetworkInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UplinkNetworkInfoToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class DownlinkNetworkInfo {
  const DownlinkNetworkInfo(
      {this.lastmileBufferDelayTimeMs,
      this.bandwidthEstimationBps,
      this.totalDownscaleLevelCount,
      this.peerDownlinkInfo,
      this.totalReceivedVideoCount});

  @JsonKey(name: 'lastmile_buffer_delay_time_ms')
  final int? lastmileBufferDelayTimeMs;

  @JsonKey(name: 'bandwidth_estimation_bps')
  final int? bandwidthEstimationBps;

  @JsonKey(name: 'total_downscale_level_count')
  final int? totalDownscaleLevelCount;

  @JsonKey(name: 'peer_downlink_info')
  final List<PeerDownlinkInfo>? peerDownlinkInfo;

  @JsonKey(name: 'total_received_video_count')
  final int? totalReceivedVideoCount;
  factory DownlinkNetworkInfo.fromJson(Map<String, dynamic> json) =>
      _$DownlinkNetworkInfoFromJson(json);
  Map<String, dynamic> toJson() => _$DownlinkNetworkInfoToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class PeerDownlinkInfo {
  const PeerDownlinkInfo(
      {this.uid,
      this.streamType,
      this.currentDownscaleLevel,
      this.expectedBitrateBps});

  @JsonKey(name: 'uid')
  final String? uid;

  @JsonKey(name: 'stream_type')
  final VideoStreamType? streamType;

  @JsonKey(name: 'current_downscale_level')
  final RemoteVideoDownscaleLevel? currentDownscaleLevel;

  @JsonKey(name: 'expected_bitrate_bps')
  final int? expectedBitrateBps;
  factory PeerDownlinkInfo.fromJson(Map<String, dynamic> json) =>
      _$PeerDownlinkInfoFromJson(json);
  Map<String, dynamic> toJson() => _$PeerDownlinkInfoToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum EncryptionMode {
  @JsonValue(1)
  aes128Xts,

  @JsonValue(2)
  aes128Ecb,

  @JsonValue(3)
  aes256Xts,

  @JsonValue(4)
  sm4128Ecb,

  @JsonValue(5)
  aes128Gcm,

  @JsonValue(6)
  aes256Gcm,

  @JsonValue(7)
  aes128Gcm2,

  @JsonValue(8)
  aes256Gcm2,

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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class EncryptionConfig {
  const EncryptionConfig(
      {this.encryptionMode, this.encryptionKey, this.encryptionKdfSalt});

  @JsonKey(name: 'encryptionMode')
  final EncryptionMode? encryptionMode;

  @JsonKey(name: 'encryptionKey')
  final String? encryptionKey;

  @JsonKey(name: 'encryptionKdfSalt', ignore: true)
  final Uint8List? encryptionKdfSalt;
  factory EncryptionConfig.fromJson(Map<String, dynamic> json) =>
      _$EncryptionConfigFromJson(json);
  Map<String, dynamic> toJson() => _$EncryptionConfigToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum EncryptionErrorType {
  @JsonValue(0)
  encryptionErrorInternalFailure,

  @JsonValue(1)
  encryptionErrorDecryptionFailure,

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

@JsonEnum(alwaysCreate: true)
enum UploadErrorReason {
  @JsonValue(0)
  uploadSuccess,

  @JsonValue(1)
  uploadNetError,

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

@JsonEnum(alwaysCreate: true)
enum PermissionType {
  @JsonValue(0)
  recordAudio,

  @JsonValue(1)
  camera,

  @JsonValue(2)
  screenCapture,
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

@JsonEnum(alwaysCreate: true)
enum MaxUserAccountLengthType {
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

@JsonEnum(alwaysCreate: true)
enum StreamSubscribeState {
  @JsonValue(0)
  subStateIdle,

  @JsonValue(1)
  subStateNoSubscribed,

  @JsonValue(2)
  subStateSubscribing,

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

@JsonEnum(alwaysCreate: true)
enum StreamPublishState {
  @JsonValue(0)
  pubStateIdle,

  @JsonValue(1)
  pubStateNoPublished,

  @JsonValue(2)
  pubStatePublishing,

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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class EchoTestConfiguration {
  const EchoTestConfiguration(
      {this.view,
      this.enableAudio,
      this.enableVideo,
      this.token,
      this.channelId});

  @JsonKey(name: 'view')
  final int? view;

  @JsonKey(name: 'enableAudio')
  final bool? enableAudio;

  @JsonKey(name: 'enableVideo')
  final bool? enableVideo;

  @JsonKey(name: 'token')
  final String? token;

  @JsonKey(name: 'channelId')
  final String? channelId;
  factory EchoTestConfiguration.fromJson(Map<String, dynamic> json) =>
      _$EchoTestConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$EchoTestConfigurationToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class UserInfo {
  const UserInfo({this.uid, this.userAccount});

  @JsonKey(name: 'uid')
  final int? uid;

  @JsonKey(name: 'userAccount')
  final String? userAccount;
  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum EarMonitoringFilterType {
  @JsonValue((1 << 0))
  earMonitoringFilterNone,

  @JsonValue((1 << 1))
  earMonitoringFilterBuiltInAudioFilters,

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

@JsonEnum(alwaysCreate: true)
enum ThreadPriorityType {
  @JsonValue(0)
  lowest,

  @JsonValue(1)
  low,

  @JsonValue(2)
  normal,

  @JsonValue(3)
  high,

  @JsonValue(4)
  highest,

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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ScreenVideoParameters {
  const ScreenVideoParameters(
      {this.dimensions, this.frameRate, this.bitrate, this.contentHint});

  @JsonKey(name: 'dimensions')
  final VideoDimensions? dimensions;

  @JsonKey(name: 'frameRate')
  final int? frameRate;

  @JsonKey(name: 'bitrate')
  final int? bitrate;

  @JsonKey(name: 'contentHint')
  final VideoContentHint? contentHint;
  factory ScreenVideoParameters.fromJson(Map<String, dynamic> json) =>
      _$ScreenVideoParametersFromJson(json);
  Map<String, dynamic> toJson() => _$ScreenVideoParametersToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ScreenAudioParameters {
  const ScreenAudioParameters(
      {this.sampleRate, this.channels, this.captureSignalVolume});

  @JsonKey(name: 'sampleRate')
  final int? sampleRate;

  @JsonKey(name: 'channels')
  final int? channels;

  @JsonKey(name: 'captureSignalVolume')
  final int? captureSignalVolume;
  factory ScreenAudioParameters.fromJson(Map<String, dynamic> json) =>
      _$ScreenAudioParametersFromJson(json);
  Map<String, dynamic> toJson() => _$ScreenAudioParametersToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ScreenCaptureParameters2 {
  const ScreenCaptureParameters2(
      {this.captureAudio,
      this.audioParams,
      this.captureVideo,
      this.videoParams});

  @JsonKey(name: 'captureAudio')
  final bool? captureAudio;

  @JsonKey(name: 'audioParams')
  final ScreenAudioParameters? audioParams;

  @JsonKey(name: 'captureVideo')
  final bool? captureVideo;

  @JsonKey(name: 'videoParams')
  final ScreenVideoParameters? videoParams;
  factory ScreenCaptureParameters2.fromJson(Map<String, dynamic> json) =>
      _$ScreenCaptureParameters2FromJson(json);
  Map<String, dynamic> toJson() => _$ScreenCaptureParameters2ToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SpatialAudioParams {
  const SpatialAudioParams(
      {this.speakerAzimuth,
      this.speakerElevation,
      this.speakerDistance,
      this.speakerOrientation,
      this.enableBlur,
      this.enableAirAbsorb,
      this.speakerAttenuation});

  @JsonKey(name: 'speaker_azimuth')
  final double? speakerAzimuth;

  @JsonKey(name: 'speaker_elevation')
  final double? speakerElevation;

  @JsonKey(name: 'speaker_distance')
  final double? speakerDistance;

  @JsonKey(name: 'speaker_orientation')
  final int? speakerOrientation;

  @JsonKey(name: 'enable_blur')
  final bool? enableBlur;

  @JsonKey(name: 'enable_air_absorb')
  final bool? enableAirAbsorb;

  @JsonKey(name: 'speaker_attenuation')
  final double? speakerAttenuation;
  factory SpatialAudioParams.fromJson(Map<String, dynamic> json) =>
      _$SpatialAudioParamsFromJson(json);
  Map<String, dynamic> toJson() => _$SpatialAudioParamsToJson(this);
}
