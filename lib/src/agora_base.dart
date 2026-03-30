import '/src/_serializable.dart';
import '/src/binding_forward_export.dart';
part 'agora_base.g.dart';

/// Channel profile.
@JsonEnum(alwaysCreate: true)
enum ChannelProfileType {
  /// 0: Communication profile. Agora recommends using the live broadcasting profile for a better audio and video experience.
  @JsonValue(0)
  channelProfileCommunication,

  /// 1: (Default) Live broadcasting profile.
  @JsonValue(1)
  channelProfileLiveBroadcasting,

  /// 2: Gaming profile. Deprecated: Use channelProfileLiveBroadcasting instead.
  @JsonValue(2)
  channelProfileGame,

  /// 3: Interactive profile. This profile is optimized for low latency. If your scenario involves frequent interactions among users, this profile is recommended. Deprecated: Use channelProfileLiveBroadcasting instead.
  @JsonValue(3)
  channelProfileCloudGaming,

  /// @nodoc
  @JsonValue(4)
  channelProfileCommunication1v1,
}

/// @nodoc
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
  @JsonValue(1031)
  warnAdmRecordAudioLowlevel,

  /// @nodoc
  @JsonValue(1032)
  warnAdmPlayoutAudioLowlevel,

  /// @nodoc
  @JsonValue(1033)
  warnAdmRecordIsOccupied,

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
  @JsonValue(1055)
  warnAdmPopState,

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

/// @nodoc
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

/// Error codes.
///
/// Error codes indicate that the SDK has encountered an unrecoverable error requiring application intervention. For example, an error is returned when the camera fails to open, and the app needs to notify the user that the camera cannot be used.
@JsonEnum(alwaysCreate: true)
enum ErrorCodeType {
  /// 0: No error.
  @JsonValue(0)
  errOk,

  /// 1: General error (uncategorized error cause). Please try calling the method again.
  @JsonValue(1)
  errFailed,

  /// 2: Invalid parameter set in the method. For example, the specified channel name contains illegal characters. Please reset the parameters.
  @JsonValue(2)
  errInvalidArgument,

  /// 3: SDK is not ready. Possible reasons include: RtcEngine initialization failed. Please reinitialize RtcEngine.
  ///  User has not joined the channel when calling the method. Please check the method call logic.
  ///  User has not left the channel when calling rate or complain. Please check the method call logic.
  ///  Audio module is not enabled.
  ///  Incomplete assembly.
  @JsonValue(3)
  errNotReady,

  /// 4: The current state of RtcEngine does not support this operation. Possible reasons include:
  ///  When using built-in encryption, the encryption mode is incorrect or loading the external encryption library failed. Please check whether the encryption enum value is correct or reload the external encryption library.
  @JsonValue(4)
  errNotSupported,

  /// 5: This method call was rejected. Possible reasons include: RtcEngine initialization failed. Please reinitialize RtcEngine.
  ///  An empty string "" was set as the channel name when joining the channel. Please reset the channel name.
  ///  In multi-channel scenarios, the specified channel name already exists when calling joinChannelEx to join a channel. Please reset the channel name.
  @JsonValue(5)
  errRefused,

  /// 6: Buffer size is insufficient to hold the returned data.
  @JsonValue(6)
  errBufferTooSmall,

  /// 7: Method is called before RtcEngine is initialized. Please ensure that the RtcEngine object is created and initialized before calling this method.
  @JsonValue(7)
  errNotInitialized,

  /// 8: Invalid current state.
  @JsonValue(8)
  errInvalidState,

  /// 9: No permission to operate. Please check whether the user has granted the app permission to use audio and video devices.
  @JsonValue(9)
  errNoPermission,

  /// 10: Method call timed out. Some method calls require a result from the SDK. If the SDK takes too long to process the event and does not return within 10 seconds, this error occurs.
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

  /// 17: Joining the channel was rejected. Possible reasons include:
  ///  The user is already in the channel. It is recommended to determine whether the user is in the channel via the onConnectionStateChanged callback. Do not call this method again to join the channel unless receiving the connectionStateDisconnected (1) state.
  ///  After calling startEchoTest for a call test, the user attempts to join the channel without calling stopEchoTest to end the current test. After starting the call test, you must call stopEchoTest to end the test before joining the channel.
  @JsonValue(17)
  errJoinChannelRejected,

  /// 18: Failed to leave the channel. Possible reasons include:
  ///  The user has already left the channel before calling leaveChannel. Stop calling this method.
  ///  The user calls leaveChannel to exit the channel without having joined it. No further action is needed in this case.
  @JsonValue(18)
  errLeaveChannelRejected,

  /// 19: The resource is already in use and cannot be reused.
  @JsonValue(19)
  errAlreadyInUse,

  /// 20: SDK aborted the request, possibly due to too many requests.
  @JsonValue(20)
  errAborted,

  /// 21: Specific firewall settings on Windows caused RtcEngine initialization to fail and crash.
  @JsonValue(21)
  errInitNetEngine,

  /// 22: SDK failed to allocate resources, possibly because the app is using too many resources or system resources are exhausted.
  @JsonValue(22)
  errResourceLimited,

  /// 101: Invalid App ID. Please use a valid App ID to rejoin the channel.
  @JsonValue(101)
  errInvalidAppId,

  /// 102: Invalid channel name. Possible reason is incorrect data type set for the parameter. Please use a valid channel name to rejoin the channel.
  @JsonValue(102)
  errInvalidChannelName,

  /// 103: Unable to obtain server resources in the current region. Try specifying a different region when initializing RtcEngine.
  @JsonValue(103)
  errNoServerResources,

  /// 109: The current Token has expired and is no longer valid. Please request a new Token from the server and call renewToken to update it. Deprecated: This enum is deprecated. Use connectionChangedTokenExpired (9) in the onConnectionStateChanged callback instead.
  @JsonValue(109)
  errTokenExpired,

  /// Deprecated: This enum is deprecated. Use connectionChangedInvalidToken (8) in the onConnectionStateChanged callback instead. 110: Invalid Token. Common reasons include:
  ///  App certificate is enabled in the console, but App ID + Token authentication is not used. When the project enables the App certificate, Token authentication must be used.
  ///  The uid field used when generating the Token does not match the uid used when the user joins the channel.
  @JsonValue(110)
  errInvalidToken,

  /// 111: Network connection interrupted. SDK lost network connection for more than 4 seconds after establishing a connection with the server.
  @JsonValue(111)
  errConnectionInterrupted,

  /// 112: Network connection lost. The network was interrupted and the SDK could not reconnect to the server within 10 seconds.
  @JsonValue(112)
  errConnectionLost,

  /// 113: User is not in the channel when calling the sendStreamMessage method.
  @JsonValue(113)
  errNotInChannel,

  /// 114: The data length exceeds 1 KB when calling sendStreamMessage.
  @JsonValue(114)
  errSizeTooLarge,

  /// 115: The data sending frequency exceeds the limit (6 KB/s) when calling sendStreamMessage.
  @JsonValue(115)
  errBitrateLimit,

  /// 116: The number of data streams created exceeds the limit (5) when calling createDataStream.
  @JsonValue(116)
  errTooManyDataStreams,

  /// 117: Data stream sending timed out.
  @JsonValue(117)
  errStreamMessageTimeout,

  /// 119: Failed to switch user role. Please try rejoining the channel.
  @JsonValue(119)
  errSetClientRoleNotAuthorized,

  /// 120: Media stream decryption failed. Possibly due to an incorrect key used when the user joined the channel. Please check the key entered when joining the channel or guide the user to try rejoining.
  @JsonValue(120)
  errDecryptionFailed,

  /// 121: Invalid user ID.
  @JsonValue(121)
  errInvalidUserId,

  /// 122: Data stream decryption failed. Possibly due to an incorrect key used when the user joined the channel. Please check the key entered when joining the channel or guide the user to try rejoining.
  @JsonValue(122)
  errDatastreamDecryptionFailed,

  /// 123: The user is banned by the server.
  @JsonValue(123)
  errClientIsBannedByServer,

  /// 130: The SDK does not support pushing encrypted streams to CDN.
  @JsonValue(130)
  errEncryptedStreamNotAllowedPublish,

  /// @nodoc
  @JsonValue(131)
  errLicenseCredentialInvalid,

  /// 134: Invalid user account, possibly due to invalid parameters.
  @JsonValue(134)
  errInvalidUserAccount,

  /// @nodoc
  @JsonValue(157)
  errModuleNotFound,

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

  /// 200: Unsupported PCM format.
  @JsonValue(200)
  errPcmsendFormat,

  /// 201: Buffer overflow, PCM sending rate is too fast.
  @JsonValue(201)
  errPcmsendBufferoverflow,

  /// @nodoc
  @JsonValue(428)
  errLoginAlreadyLogin,

  /// 1001: Failed to load media engine.
  @JsonValue(1001)
  errLoadMediaEngine,

  /// 1005: Audio device error (unspecified). Please check whether the audio device is occupied by another application, or try rejoining the channel.
  @JsonValue(1005)
  errAdmGeneralError,

  /// 1008: Error initializing playback device. Please check whether the playback device is occupied by another application, or try rejoining the channel.
  @JsonValue(1008)
  errAdmInitPlayout,

  /// 1009: Error starting playback device. Please check whether the playback device is functioning properly.
  @JsonValue(1009)
  errAdmStartPlayout,

  /// 1010: Error stopping playback device.
  @JsonValue(1010)
  errAdmStopPlayout,

  /// 1011: Error initializing recording device. Please check whether the recording device is functioning properly, or try rejoining the channel.
  @JsonValue(1011)
  errAdmInitRecording,

  /// 1012: Error starting recording device. Please check whether the recording device is functioning properly.
  @JsonValue(1012)
  errAdmStartRecording,

  /// 1013: Error stopping recording device.
  @JsonValue(1013)
  errAdmStopRecording,

  /// 1501: No permission to use the camera. Please check whether camera permission is enabled.
  @JsonValue(1501)
  errVdmCameraNotAuthorized,
}

/// @nodoc
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

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum LicenseErrorType {
  /// @nodoc
  @JsonValue(1)
  licenseErrInvalid,

  /// @nodoc
  @JsonValue(2)
  licenseErrExpire,

  /// @nodoc
  @JsonValue(3)
  licenseErrMinutesExceed,

  /// @nodoc
  @JsonValue(4)
  licenseErrLimitedPeriod,

  /// @nodoc
  @JsonValue(5)
  licenseErrDiffDevices,

  /// @nodoc
  @JsonValue(99)
  licenseErrInternal,
}

/// @nodoc
extension LicenseErrorTypeExt on LicenseErrorType {
  /// @nodoc
  static LicenseErrorType fromValue(int value) {
    return $enumDecode(_$LicenseErrorTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$LicenseErrorTypeEnumMap[this]!;
  }
}

/// SDK's operation permissions for Audio Session.
@JsonEnum(alwaysCreate: true)
enum AudioSessionOperationRestriction {
  /// 0: No restriction. SDK can modify the Audio Session.
  @JsonValue(0)
  audioSessionOperationRestrictionNone,

  /// 1: SDK cannot change the Audio Session category.
  @JsonValue(1)
  audioSessionOperationRestrictionSetCategory,

  /// 2: SDK cannot change the Audio Session category, mode, or categoryOptions.
  @JsonValue(1 << 1)
  audioSessionOperationRestrictionConfigureSession,

  /// 4: When leaving the channel, the SDK keeps the Audio Session active, for example, to continue audio playback in the background.
  @JsonValue(1 << 2)
  audioSessionOperationRestrictionDeactivateSession,

  /// 128: Fully restricts the SDK's operation permissions for Audio Session. SDK cannot make any changes to the Audio Session.
  @JsonValue(1 << 7)
  audioSessionOperationRestrictionAll,
}

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

/// Reason for user going offline.
@JsonEnum(alwaysCreate: true)
enum UserOfflineReasonType {
  /// 0: User left voluntarily.
  @JsonValue(0)
  userOfflineQuit,

  /// 1: Timed out due to not receiving packets from the peer for a long time. Since the SDK uses an unreliable channel, it is also possible that the peer left the channel voluntarily, but the local side did not receive the leave message and mistakenly judged it as a timeout.
  @JsonValue(1)
  userOfflineDropped,

  /// 2: User switched role from host to audience.
  @JsonValue(2)
  userOfflineBecomeAudience,
}

/// @nodoc
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

/// Interface class.
@JsonEnum(alwaysCreate: true)
enum InterfaceIdType {
  /// 1: AudioDeviceManager interface class.
  @JsonValue(1)
  agoraIidAudioDeviceManager,

  /// 2: VideoDeviceManager interface class.
  @JsonValue(2)
  agoraIidVideoDeviceManager,

  /// 3: This interface class is deprecated.
  @JsonValue(3)
  agoraIidParameterEngine,

  /// 4: MediaEngine interface class.
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

  /// 8: This interface class is deprecated.
  @JsonValue(8)
  agoraIidSignalingEngine,

  /// @nodoc
  @JsonValue(9)
  agoraIidMediaEngineRegulator,

  /// 11: LocalSpatialAudioEngine interface class.
  @JsonValue(11)
  agoraIidLocalSpatialAudio,

  /// @nodoc
  @JsonValue(13)
  agoraIidStateSync,

  /// @nodoc
  @JsonValue(14)
  agoraIidMetaService,

  /// 15: MusicContentCenter interface class.
  @JsonValue(15)
  agoraIidMusicContentCenter,

  /// @nodoc
  @JsonValue(16)
  agoraIidH265Transcoder,
}

/// @nodoc
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

/// Network quality.
@JsonEnum(alwaysCreate: true)
enum QualityType {
  /// 0: Network quality is unknown.
  @JsonValue(0)
  qualityUnknown,

  /// 1: Excellent network quality.
  @JsonValue(1)
  qualityExcellent,

  /// 2: Subjectively similar to excellent, but bitrate may be slightly lower.
  @JsonValue(2)
  qualityGood,

  /// 3: Slightly impaired user experience but still allows communication.
  @JsonValue(3)
  qualityPoor,

  /// 4: Barely communicable but not smooth.
  @JsonValue(4)
  qualityBad,

  /// 5: Very poor network quality, communication is almost impossible.
  @JsonValue(5)
  qualityVbad,

  /// 6: Communication is completely impossible.
  @JsonValue(6)
  qualityDown,

  /// @nodoc
  @JsonValue(7)
  qualityUnsupported,

  /// 8: Network quality detection in progress.
  @JsonValue(8)
  qualityDetecting,
}

/// @nodoc
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

/// @nodoc
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

/// Video clockwise rotation information.
@JsonEnum(alwaysCreate: true)
enum VideoOrientation {
  /// 0: (Default) Rotates 0 degrees clockwise.
  @JsonValue(0)
  videoOrientation0,

  /// 90: Rotates 90 degrees clockwise.
  @JsonValue(90)
  videoOrientation90,

  /// 180: Rotates 180 degrees clockwise.
  @JsonValue(180)
  videoOrientation180,

  /// 270: Rotates 270 degrees clockwise.
  @JsonValue(270)
  videoOrientation270,
}

/// @nodoc
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
  /// 1: 1 fps.
  @JsonValue(1)
  frameRateFps1,

  /// 7: 7 fps.
  @JsonValue(7)
  frameRateFps7,

  /// 10: 10 fps.
  @JsonValue(10)
  frameRateFps10,

  /// 15: 15 fps.
  @JsonValue(15)
  frameRateFps15,

  /// 24: 24 fps.
  @JsonValue(24)
  frameRateFps24,

  /// 30: 30 fps.
  @JsonValue(30)
  frameRateFps30,

  /// 60: 60 fps. (Windows and macOS only)
  @JsonValue(60)
  frameRateFps60,
}

/// @nodoc
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
  @JsonValue(960)
  frameWidth960,
}

/// @nodoc
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
  @JsonValue(540)
  frameHeight540,
}

/// @nodoc
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

/// Video frame type.
@JsonEnum(alwaysCreate: true)
enum VideoFrameType {
  /// 0: Black frame.
  @JsonValue(0)
  videoFrameTypeBlankFrame,

  /// 3: Key frame.
  @JsonValue(3)
  videoFrameTypeKeyFrame,

  /// 4: Delta frame.
  @JsonValue(4)
  videoFrameTypeDeltaFrame,

  /// 5: B frame.
  @JsonValue(5)
  videoFrameTypeBFrame,

  /// 6: Droppable frame.
  @JsonValue(6)
  videoFrameTypeDroppableFrame,

  /// Unknown frame.
  @JsonValue(7)
  videoFrameTypeUnknow,
}

/// @nodoc
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

/// Orientation mode for video encoding.
@JsonEnum(alwaysCreate: true)
enum OrientationMode {
  /// 0: (Default) In this mode, the SDK outputs video with the same orientation as the captured video. The receiving end rotates the video based on the received rotation info. This mode is suitable when the receiver can adjust video orientation.
  ///  If the captured video is landscape, the output video is also landscape.
  ///  If the captured video is portrait, the output video is also portrait.
  @JsonValue(0)
  orientationModeAdaptive,

  /// 1: In this mode, the SDK outputs video in fixed landscape mode. If the captured video is portrait, the encoder crops it. This mode is suitable when the receiver cannot adjust video orientation, such as in CDN streaming scenarios.
  @JsonValue(1)
  orientationModeFixedLandscape,

  /// 2: In this mode, the SDK outputs video in fixed portrait mode. If the captured video is landscape, the encoder crops it. This mode is suitable when the receiver cannot adjust video orientation, such as in CDN streaming scenarios.
  @JsonValue(2)
  orientationModeFixedPortrait,
}

/// @nodoc
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

/// Video encoding degradation preference when bandwidth is limited.
@JsonEnum(alwaysCreate: true)
enum DegradationPreference {
  /// -1: (Default) Auto mode. The SDK automatically selects maintainFramerate, maintainBalanced, or maintainResolution based on your video scenario settings to achieve optimal overall quality experience (QoE).
  @JsonValue(-1)
  maintainAuto,

  /// 0: When bandwidth is limited, prioritize reducing video frame rate while maintaining resolution. This preference is suitable for scenarios prioritizing image quality. Deprecated: This enumeration is deprecated. Use other enumerations instead.
  @JsonValue(0)
  maintainQuality,

  /// 1: When bandwidth is limited, prioritize reducing video resolution while maintaining frame rate. This preference is suitable for scenarios prioritizing smoothness and allowing reduced image quality.
  @JsonValue(1)
  maintainFramerate,

  /// 2: When bandwidth is limited, reduce both video frame rate and resolution. The degradation level of maintainBalanced is lower than maintainQuality and maintainFramerate, suitable for scenarios with limited smoothness and image quality. The resolution of the locally sent video may change. Remote users must be able to handle this situation. See onVideoSizeChanged.
  @JsonValue(2)
  maintainBalanced,

  /// 3: When bandwidth is limited, prioritize reducing video frame rate while keeping resolution unchanged. This preference is suitable for scenarios prioritizing image quality.
  @JsonValue(3)
  maintainResolution,

  /// @nodoc
  @JsonValue(100)
  disabled,
}

/// @nodoc
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

/// Video dimensions.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoDimensions implements AgoraSerializable {
  /// @nodoc
  const VideoDimensions({this.width, this.height});

  /// Video width in pixels.
  @JsonKey(name: 'width')
  final int? width;

  /// Video height in pixels.
  @JsonKey(name: 'height')
  final int? height;

  /// @nodoc
  factory VideoDimensions.fromJson(Map<String, dynamic> json) =>
      _$VideoDimensionsFromJson(json);

  @override
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

/// Maximum frame rate supported by the screen sharing device.
@JsonEnum(alwaysCreate: true)
enum ScreenCaptureFramerateCapability {
  /// 0: Supports up to 15 fps.
  @JsonValue(0)
  screenCaptureFramerateCapability15Fps,

  /// 1: Supports up to 30 fps.
  @JsonValue(1)
  screenCaptureFramerateCapability30Fps,

  /// 2: Supports up to 60 fps.
  @JsonValue(2)
  screenCaptureFramerateCapability60Fps,
}

extension ScreenCaptureFramerateCapabilityExt
    on ScreenCaptureFramerateCapability {
  /// @nodoc
  static ScreenCaptureFramerateCapability fromValue(int value) {
    return $enumDecode(_$ScreenCaptureFramerateCapabilityEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$ScreenCaptureFramerateCapabilityEnumMap[this]!;
  }
}

/// Video codec capability level.
@JsonEnum(alwaysCreate: true)
enum VideoCodecCapabilityLevel {
  /// -1: Unsupported video type. Currently only H.264 and H.265 formats are supported. If the video is in another format, this value is returned.
  @JsonValue(-1)
  codecCapabilityLevelUnspecified,

  /// 5: Basic codec support, i.e., encoding and decoding for video up to 1080p and 30 fps.
  @JsonValue(5)
  codecCapabilityLevelBasicSupport,

  /// 10: Supports encoding and decoding for video up to 1080p and 30 fps.
  @JsonValue(10)
  codecCapabilityLevel1080p30fps,

  /// 20: Supports encoding and decoding for video up to 1080p and 60 fps.
  @JsonValue(20)
  codecCapabilityLevel1080p60fps,

  /// 30: Supports encoding and decoding for video up to 4K and 30 fps.
  @JsonValue(30)
  codecCapabilityLevel4k60fps,
}

/// @nodoc
extension VideoCodecCapabilityLevelExt on VideoCodecCapabilityLevel {
  /// @nodoc
  static VideoCodecCapabilityLevel fromValue(int value) {
    return $enumDecode(_$VideoCodecCapabilityLevelEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$VideoCodecCapabilityLevelEnumMap[this]!;
  }
}

/// Video codec format.
@JsonEnum(alwaysCreate: true)
enum VideoCodecType {
  /// 0: (Default) No specific codec format. The SDK automatically selects a suitable codec format based on the resolution of the current video stream and device performance.
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

  /// 6: Generic. This type is mainly used for transmitting raw video data (e.g., user-encrypted video frames). The video frames of this type are returned to the user via callback, and the user needs to decode and render them manually.
  @JsonValue(6)
  videoCodecGeneric,

  /// @nodoc
  @JsonValue(7)
  videoCodecGenericH264,

  /// @nodoc
  @JsonValue(12)
  videoCodecAv1,

  /// @nodoc
  @JsonValue(13)
  videoCodecVp9,

  /// 20: Generic JPEG. Requires less computing power and can be used on IoT devices with limited processing capabilities.
  @JsonValue(20)
  videoCodecGenericJpeg,
}

/// @nodoc
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

/// Camera focal length type.
///
/// (Android and iOS only)
@JsonEnum(alwaysCreate: true)
enum CameraFocalLengthType {
  /// 0: (Default) Standard lens.
  @JsonValue(0)
  cameraFocalLengthDefault,

  /// 1: Wide-angle lens.
  @JsonValue(1)
  cameraFocalLengthWideAngle,

  /// 2: Ultra-wide-angle lens.
  @JsonValue(2)
  cameraFocalLengthUltraWide,

  /// 3: (iOS only) Telephoto lens.
  @JsonValue(3)
  cameraFocalLengthTelephoto,
}

/// @nodoc
extension CameraFocalLengthTypeExt on CameraFocalLengthType {
  /// @nodoc
  static CameraFocalLengthType fromValue(int value) {
    return $enumDecode(_$CameraFocalLengthTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$CameraFocalLengthTypeEnumMap[this]!;
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

/// @nodoc
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
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SenderOptions implements AgoraSerializable {
  /// @nodoc
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

  @override
  Map<String, dynamic> toJson() => _$SenderOptionsToJson(this);
}

/// Audio codec format.
@JsonEnum(alwaysCreate: true)
enum AudioCodecType {
  /// 1: OPUS.
  @JsonValue(1)
  audioCodecOpus,

  /// 3: PCMA.
  @JsonValue(3)
  audioCodecPcma,

  /// 4: PCMU.
  @JsonValue(4)
  audioCodecPcmu,

  /// 5: G722.
  @JsonValue(5)
  audioCodecG722,

  /// 8: LC-AAC.
  @JsonValue(8)
  audioCodecAaclc,

  /// 9: HE-AAC.
  @JsonValue(9)
  audioCodecHeaac,

  /// 10: JC1.
  @JsonValue(10)
  audioCodecJc1,

  /// 11: HE-AAC v2.
  @JsonValue(11)
  audioCodecHeaac2,

  /// @nodoc
  @JsonValue(12)
  audioCodecLpcnet,

  /// @nodoc
  @JsonValue(13)
  audioCodecOpusmc,
}

/// @nodoc
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
  /// 0x010101: AAC encoding format, 16000 Hz sample rate, low quality. The file size of 10 minutes of audio is approximately 1.2 MB after encoding.
  @JsonValue(0x010101)
  audioEncodingTypeAac16000Low,

  /// 0x010102: AAC encoding format, 16000 Hz sample rate, medium quality. The file size of 10 minutes of audio is approximately 2 MB after encoding.
  @JsonValue(0x010102)
  audioEncodingTypeAac16000Medium,

  /// 0x010201: AAC encoding format, 32000 Hz sample rate, low quality. The file size of 10 minutes of audio is approximately 1.2 MB after encoding.
  @JsonValue(0x010201)
  audioEncodingTypeAac32000Low,

  /// 0x010202: AAC encoding format, 32000 Hz sample rate, medium quality. The file size of 10 minutes of audio is approximately 2 MB after encoding.
  @JsonValue(0x010202)
  audioEncodingTypeAac32000Medium,

  /// 0x010203: AAC encoding format, 32000 Hz sample rate, high quality. The file size of 10 minutes of audio is approximately 3.5 MB after encoding.
  @JsonValue(0x010203)
  audioEncodingTypeAac32000High,

  /// 0x010302: AAC encoding format, 48000 Hz sample rate, medium quality. The file size of 10 minutes of audio is approximately 2 MB after encoding.
  @JsonValue(0x010302)
  audioEncodingTypeAac48000Medium,

  /// 0x010303: AAC encoding format, 48000 Hz sample rate, high quality. The file size of 10 minutes of audio is approximately 3.5 MB after encoding.
  @JsonValue(0x010303)
  audioEncodingTypeAac48000High,

  /// 0x020101: OPUS encoding format, 16000 Hz sample rate, low quality. The file size of 10 minutes of audio is approximately 2 MB after encoding.
  @JsonValue(0x020101)
  audioEncodingTypeOpus16000Low,

  /// 0x020102: OPUS encoding format, 16000 Hz sample rate, medium quality. The file size of 10 minutes of audio is approximately 2 MB after encoding.
  @JsonValue(0x020102)
  audioEncodingTypeOpus16000Medium,

  /// 0x020302: OPUS encoding format, 48000 Hz sample rate, medium quality. The file size of 10 minutes of audio is approximately 2 MB after encoding.
  @JsonValue(0x020302)
  audioEncodingTypeOpus48000Medium,

  /// 0x020303: OPUS encoding format, 48000 Hz sample rate, high quality. The file size of 10 minutes of audio is approximately 3.5 MB after encoding.
  @JsonValue(0x020303)
  audioEncodingTypeOpus48000High,
}

/// @nodoc
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

/// Watermark fit mode.
@JsonEnum(alwaysCreate: true)
enum WatermarkFitMode {
  /// 0: Uses the positionInLandscapeMode and positionInPortraitMode values set in WatermarkOptions. The settings in WatermarkRatio are ignored.
  @JsonValue(0)
  fitModeCoverPosition,

  /// 1: Uses the value set in WatermarkRatio. The positionInLandscapeMode and positionInPortraitMode settings in WatermarkOptions are ignored.
  @JsonValue(1)
  fitModeUseImageRatio,
}

/// @nodoc
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
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class EncodedAudioFrameAdvancedSettings implements AgoraSerializable {
  /// @nodoc
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

  @override
  Map<String, dynamic> toJson() =>
      _$EncodedAudioFrameAdvancedSettingsToJson(this);
}

/// Information about the encoded audio.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class EncodedAudioFrameInfo implements AgoraSerializable {
  /// @nodoc
  const EncodedAudioFrameInfo(
      {this.codec,
      this.sampleRateHz,
      this.samplesPerChannel,
      this.numberOfChannels,
      this.advancedSettings,
      this.captureTimeMs});

  /// Audio codec type: AudioCodecType.
  @JsonKey(name: 'codec')
  final AudioCodecType? codec;

  /// Audio sample rate (Hz).
  @JsonKey(name: 'sampleRateHz')
  final int? sampleRateHz;

  /// Number of audio samples per channel.
  @JsonKey(name: 'samplesPerChannel')
  final int? samplesPerChannel;

  /// Number of channels.
  @JsonKey(name: 'numberOfChannels')
  final int? numberOfChannels;

  /// This feature is not supported yet.
  @JsonKey(name: 'advancedSettings')
  final EncodedAudioFrameAdvancedSettings? advancedSettings;

  /// Unix timestamp (ms) when the external encoded video frame was captured.
  @JsonKey(name: 'captureTimeMs')
  final int? captureTimeMs;

  /// @nodoc
  factory EncodedAudioFrameInfo.fromJson(Map<String, dynamic> json) =>
      _$EncodedAudioFrameInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EncodedAudioFrameInfoToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioPcmDataInfo implements AgoraSerializable {
  /// @nodoc
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

  @override
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

/// @nodoc
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

/// Video stream type.
@JsonEnum(alwaysCreate: true)
enum VideoStreamType {
  /// 0: High video stream, i.e., high-resolution and high-bitrate video stream.
  @JsonValue(0)
  videoStreamHigh,

  /// 1: Low video stream, i.e., low-resolution and low-bitrate video stream.
  @JsonValue(1)
  videoStreamLow,

  /// @nodoc
  @JsonValue(4)
  videoStreamLayer1,

  /// @nodoc
  @JsonValue(5)
  videoStreamLayer2,

  /// @nodoc
  @JsonValue(6)
  videoStreamLayer3,

  /// @nodoc
  @JsonValue(7)
  videoStreamLayer4,

  /// @nodoc
  @JsonValue(8)
  videoStreamLayer5,

  /// @nodoc
  @JsonValue(9)
  videoStreamLayer6,
}

/// @nodoc
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

/// Video subscription settings.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoSubscriptionOptions implements AgoraSerializable {
  /// @nodoc
  const VideoSubscriptionOptions({this.type, this.encodedFrameOnly});

  /// Type of video stream to subscribe to. Default is videoStreamHigh, which subscribes to the high-quality video stream. See VideoStreamType for details.
  @JsonKey(name: 'type')
  final VideoStreamType? type;

  /// Whether to subscribe only to encoded video streams: true : Subscribe only to encoded video data (structured data). The SDK does not decode or render the video data. false : (Default) Subscribe to both raw and encoded video data.
  @JsonKey(name: 'encodedFrameOnly')
  final bool? encodedFrameOnly;

  /// @nodoc
  factory VideoSubscriptionOptions.fromJson(Map<String, dynamic> json) =>
      _$VideoSubscriptionOptionsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$VideoSubscriptionOptionsToJson(this);
}

/// Maximum length of user account.
@JsonEnum(alwaysCreate: true)
enum MaxUserAccountLengthType {
  /// The maximum length of the user account is 255 characters.
  @JsonValue(256)
  maxUserAccountLength,
}

/// @nodoc
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

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum MaxCustomUserInfoLengthType {
  /// @nodoc
  @JsonValue(1024)
  maxCustomUserInfoLength,
}

/// @nodoc
extension MaxCustomUserInfoLengthTypeExt on MaxCustomUserInfoLengthType {
  /// @nodoc
  static MaxCustomUserInfoLengthType fromValue(int value) {
    return $enumDecode(_$MaxCustomUserInfoLengthTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$MaxCustomUserInfoLengthTypeEnumMap[this]!;
  }
}

/// Information about externally encoded video frames.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class EncodedVideoFrameInfo implements AgoraSerializable {
  /// @nodoc
  const EncodedVideoFrameInfo(
      {this.uid,
      this.codecType,
      this.width,
      this.height,
      this.framesPerSecond,
      this.frameType,
      this.rotation,
      this.trackId,
      this.captureTimeMs,
      this.decodeTimeMs,
      this.streamType,
      this.presentationMs});

  /// @nodoc
  @JsonKey(name: 'uid')
  final int? uid;

  /// Video codec type. See VideoCodecType. Default is videoCodecH264 (2).
  @JsonKey(name: 'codecType')
  final VideoCodecType? codecType;

  /// Width of the video frame (px).
  @JsonKey(name: 'width')
  final int? width;

  /// Height of the video frame (px).
  @JsonKey(name: 'height')
  final int? height;

  /// Frames per second.
  /// When this parameter is not 0, you can use it to calculate the Unix timestamp of the externally encoded video frame.
  @JsonKey(name: 'framesPerSecond')
  final int? framesPerSecond;

  /// Type of the video frame. See VideoFrameType.
  @JsonKey(name: 'frameType')
  final VideoFrameType? frameType;

  /// Rotation information of the video frame. See VideoOrientation.
  @JsonKey(name: 'rotation')
  final VideoOrientation? rotation;

  /// Reserved parameter.
  @JsonKey(name: 'trackId')
  final int? trackId;

  /// Unix timestamp (ms) when the external encoded video frame was captured.
  @JsonKey(name: 'captureTimeMs')
  final int? captureTimeMs;

  /// @nodoc
  @JsonKey(name: 'decodeTimeMs')
  final int? decodeTimeMs;

  /// Video stream type. See VideoStreamType.
  @JsonKey(name: 'streamType')
  final VideoStreamType? streamType;

  /// @nodoc
  @JsonKey(name: 'presentationMs')
  final int? presentationMs;

  /// @nodoc
  factory EncodedVideoFrameInfo.fromJson(Map<String, dynamic> json) =>
      _$EncodedVideoFrameInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EncodedVideoFrameInfoToJson(this);
}

/// Compression preference type for video encoding.
@JsonEnum(alwaysCreate: true)
enum CompressionPreference {
  /// -1: (Default) Automatic mode. The SDK automatically selects preferLowLatency or preferQuality based on your video scenario to provide the best user experience.
  @JsonValue(-1)
  preferCompressionAuto,

  /// 0: Low latency preference. The SDK compresses video frames to reduce latency. This preference is suitable for scenarios where smoothness is prioritized and some quality loss is acceptable.
  @JsonValue(0)
  preferLowLatency,

  /// 1: High quality preference. The SDK compresses video frames while maintaining video quality. This preference is suitable for scenarios where video quality is prioritized.
  @JsonValue(1)
  preferQuality,
}

/// @nodoc
extension CompressionPreferenceExt on CompressionPreference {
  /// @nodoc
  static CompressionPreference fromValue(int value) {
    return $enumDecode(_$CompressionPreferenceEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$CompressionPreferenceEnumMap[this]!;
  }
}

/// Video encoder preference.
@JsonEnum(alwaysCreate: true)
enum EncodingPreference {
  /// -1: Adaptive preference. The SDK automatically selects the optimal encoding type based on platform, device type, and other factors.
  @JsonValue(-1)
  preferAuto,

  /// 0: Software encoding preference. The SDK prefers using the software encoder for video encoding.
  @JsonValue(0)
  preferSoftware,

  /// 1: Hardware encoding preference. The SDK prefers using the hardware encoder for video encoding. If the device does not support hardware encoding, the SDK automatically switches to software encoding and reports the current encoder type via the hwEncoderAccelerating field in the onLocalVideoStats callback.
  @JsonValue(1)
  preferHardware,
}

/// @nodoc
extension EncodingPreferenceExt on EncodingPreference {
  /// @nodoc
  static EncodingPreference fromValue(int value) {
    return $enumDecode(_$EncodingPreferenceEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$EncodingPreferenceEnumMap[this]!;
  }
}

/// Advanced options for video encoding.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AdvanceOptions implements AgoraSerializable {
  /// @nodoc
  const AdvanceOptions(
      {this.encodingPreference, this.compressionPreference, this.encodeAlpha});

  /// Video encoder preference. See EncodingPreference.
  @JsonKey(name: 'encodingPreference')
  final EncodingPreference? encodingPreference;

  /// Compression preference for video encoding. See CompressionPreference.
  @JsonKey(name: 'compressionPreference')
  final CompressionPreference? compressionPreference;

  /// When the video frame contains Alpha channel data, sets whether to encode and send the Alpha data to the remote end: true : Encode and send the Alpha data. false : (Default) Do not encode and send the Alpha data.
  @JsonKey(name: 'encodeAlpha')
  final bool? encodeAlpha;

  /// @nodoc
  factory AdvanceOptions.fromJson(Map<String, dynamic> json) =>
      _$AdvanceOptionsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AdvanceOptionsToJson(this);
}

/// Mirror mode type.
@JsonEnum(alwaysCreate: true)
enum VideoMirrorModeType {
  /// 0: Mirror mode is determined by the SDK.
  ///  Local view mirror mode: If you use the front camera, local mirror mode is enabled by default; if you use the rear camera, it is disabled by default.
  ///  Remote user view mirror mode: Disabled by default.
  @JsonValue(0)
  videoMirrorModeAuto,

  /// 1: Enable mirror mode.
  @JsonValue(1)
  videoMirrorModeEnabled,

  /// 2: Disable mirror mode.
  @JsonValue(2)
  videoMirrorModeDisabled,
}

/// @nodoc
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

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum CameraFormatType {
  /// @nodoc
  @JsonValue(0)
  cameraFormatNv12,

  /// @nodoc
  @JsonValue(1)
  cameraFormatBgra,
}

/// @nodoc
extension CameraFormatTypeExt on CameraFormatType {
  /// @nodoc
  static CameraFormatType fromValue(int value) {
    return $enumDecode(_$CameraFormatTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$CameraFormatTypeEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum VideoModuleType {
  /// @nodoc
  @JsonValue(0)
  videoModuleCapturer,

  /// @nodoc
  @JsonValue(1)
  videoModuleSoftwareEncoder,

  /// @nodoc
  @JsonValue(2)
  videoModuleHardwareEncoder,

  /// @nodoc
  @JsonValue(3)
  videoModuleSoftwareDecoder,

  /// @nodoc
  @JsonValue(4)
  videoModuleHardwareDecoder,

  /// @nodoc
  @JsonValue(5)
  videoModuleRenderer,
}

/// @nodoc
extension VideoModuleTypeExt on VideoModuleType {
  /// @nodoc
  static VideoModuleType fromValue(int value) {
    return $enumDecode(_$VideoModuleTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$VideoModuleTypeEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum HdrCapability {
  /// @nodoc
  @JsonValue(-1)
  hdrCapabilityUnknown,

  /// @nodoc
  @JsonValue(0)
  hdrCapabilityUnsupported,

  /// @nodoc
  @JsonValue(1)
  hdrCapabilitySupported,
}

/// @nodoc
extension HdrCapabilityExt on HdrCapability {
  /// @nodoc
  static HdrCapability fromValue(int value) {
    return $enumDecode(_$HdrCapabilityEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$HdrCapabilityEnumMap[this]!;
  }
}

/// Codec capability bit mask.
@JsonEnum(alwaysCreate: true)
enum CodecCapMask {
  /// (0): Codec not supported.
  @JsonValue(0)
  codecCapMaskNone,

  /// (1 << 0): Supports hardware decoding.
  @JsonValue(1 << 0)
  codecCapMaskHwDec,

  /// (1 << 1): Supports hardware encoding.
  @JsonValue(1 << 1)
  codecCapMaskHwEnc,

  /// (1 << 2): Supports software decoding.
  @JsonValue(1 << 2)
  codecCapMaskSwDec,

  /// (1 << 3): Supports software encoding.
  @JsonValue(1 << 3)
  codecCapMaskSwEnc,
}

/// @nodoc
extension CodecCapMaskExt on CodecCapMask {
  /// @nodoc
  static CodecCapMask fromValue(int value) {
    return $enumDecode(_$CodecCapMaskEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$CodecCapMaskEnumMap[this]!;
  }
}

/// Codec capability levels.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CodecCapLevels implements AgoraSerializable {
  /// @nodoc
  const CodecCapLevels({this.hwDecodingLevel, this.swDecodingLevel});

  /// Hardware decoding capability level, indicating the device's ability to decode videos of different qualities using hardware. See VideoCodecCapabilityLevel.
  @JsonKey(name: 'hwDecodingLevel')
  final VideoCodecCapabilityLevel? hwDecodingLevel;

  /// Software decoding capability level, indicating the device's ability to decode videos of different qualities using software. See VideoCodecCapabilityLevel.
  @JsonKey(name: 'swDecodingLevel')
  final VideoCodecCapabilityLevel? swDecodingLevel;

  /// @nodoc
  factory CodecCapLevels.fromJson(Map<String, dynamic> json) =>
      _$CodecCapLevelsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CodecCapLevelsToJson(this);
}

/// Information about codec capabilities supported by the SDK.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CodecCapInfo implements AgoraSerializable {
  /// @nodoc
  const CodecCapInfo({this.codecType, this.codecCapMask, this.codecLevels});

  /// Video codec type. See VideoCodecType.
  @JsonKey(name: 'codecType')
  final VideoCodecType? codecType;

  /// Bit mask of codec types supported by the SDK. See CodecCapMask.
  @JsonKey(name: 'codecCapMask')
  final int? codecCapMask;

  /// Codec capability levels supported by the SDK. See CodecCapLevels.
  @JsonKey(name: 'codecLevels')
  final CodecCapLevels? codecLevels;

  /// @nodoc
  factory CodecCapInfo.fromJson(Map<String, dynamic> json) =>
      _$CodecCapInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CodecCapInfoToJson(this);
}

/// Focal length information supported by the camera, including camera direction and focal length type.
///
/// (Android and iOS only)
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class FocalLengthInfo implements AgoraSerializable {
  /// @nodoc
  const FocalLengthInfo({this.cameraDirection, this.focalLengthType});

  /// Camera direction. See CameraDirection.
  @JsonKey(name: 'cameraDirection')
  final int? cameraDirection;

  /// Focal length type. See CameraFocalLengthType.
  @JsonKey(name: 'focalLengthType')
  final CameraFocalLengthType? focalLengthType;

  /// @nodoc
  factory FocalLengthInfo.fromJson(Map<String, dynamic> json) =>
      _$FocalLengthInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FocalLengthInfoToJson(this);
}

/// Configuration for the video encoder.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoEncoderConfiguration implements AgoraSerializable {
  /// @nodoc
  const VideoEncoderConfiguration(
      {this.codecType,
      this.dimensions,
      this.frameRate,
      this.bitrate,
      this.minBitrate,
      this.orientationMode,
      this.degradationPreference,
      this.mirrorMode,
      this.advanceOptions});

  /// Video codec type. See VideoCodecType.
  @JsonKey(name: 'codecType')
  final VideoCodecType? codecType;

  /// Resolution (px) for video encoding. See VideoDimensions. This parameter is used to evaluate encoding quality and is expressed as width × height. The default value is 960 × 540. You can set the resolution as needed.
  @JsonKey(name: 'dimensions')
  final VideoDimensions? dimensions;

  /// Frame rate (fps) for video encoding. The default value is 15. See FrameRate.
  @JsonKey(name: 'frameRate')
  final int? frameRate;

  /// Bitrate for video encoding, in Kbps. You do not need to set this parameter. Keep the default value standardBitrate. The SDK automatically selects the optimal bitrate based on the resolution and frame rate you set. For the relationship between resolution and frame rate, see [Video Profile](https://docs.agora.io/en/video-calling/enhance-call-quality/configure-video-encoding).
  ///  standardBitrate (0): (Default) Standard bitrate mode.
  ///  compatibleBitrate (-1): Compatible bitrate mode. In general, Agora recommends not using this value.
  @JsonKey(name: 'bitrate')
  final int? bitrate;

  /// Minimum encoding bitrate, in Kbps.
  /// The SDK automatically adjusts the video encoding bitrate based on network conditions. Setting this parameter higher than the default forces the encoder to output higher-quality images, but may cause packet loss and video stuttering under poor network conditions. Unless you have specific requirements for video quality, Agora recommends not modifying this parameter. This parameter applies to live streaming only.
  @JsonKey(name: 'minBitrate')
  final int? minBitrate;

  /// Orientation mode for video encoding. See OrientationMode.
  @JsonKey(name: 'orientationMode')
  final OrientationMode? orientationMode;

  /// Encoding degradation preference when bandwidth is limited. See DegradationPreference. If this parameter is set to maintainFramerate (1) or maintainBalanced (2), you must also set orientationMode to orientationModeAdaptive (0), otherwise the setting will not take effect.
  @JsonKey(name: 'degradationPreference')
  final DegradationPreference? degradationPreference;

  /// Whether to enable mirror mode when sending encoded video. This only affects the video seen by remote users. See VideoMirrorModeType. Mirror mode is disabled by default.
  @JsonKey(name: 'mirrorMode')
  final VideoMirrorModeType? mirrorMode;

  /// Advanced options for video encoding. See AdvanceOptions.
  @JsonKey(name: 'advanceOptions')
  final AdvanceOptions? advanceOptions;

  /// @nodoc
  factory VideoEncoderConfiguration.fromJson(Map<String, dynamic> json) =>
      _$VideoEncoderConfigurationFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$VideoEncoderConfigurationToJson(this);
}

/// Data stream settings.
///
/// The table below shows the SDK behavior under different parameter settings: syncWithAudio ordered
/// SDK Behavior false false
/// The SDK immediately triggers the onStreamMessage callback upon receiving a data packet. true false
/// If the data packet delay is within the audio delay range, the SDK triggers the onStreamMessage callback synchronized with the audio packet during audio playback. If the delay exceeds the audio delay, the SDK triggers the callback immediately upon receiving the data packet, which may cause desynchronization between audio and data packets. false true
/// If the data packet delay is within 5 seconds, the SDK corrects the packet disorder. If the delay exceeds 5 seconds, the SDK discards the packet. true true
/// If the data packet delay is within the audio delay range, the SDK corrects the packet disorder. If the delay exceeds the audio delay, the SDK discards the packet.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class DataStreamConfig implements AgoraSerializable {
  /// @nodoc
  const DataStreamConfig({this.syncWithAudio, this.ordered});

  /// Whether to synchronize with the locally sent audio stream. true : The data stream is synchronized with the audio stream. Suitable for scenarios like lyrics synchronization. false : The data stream is not synchronized with the audio stream. Suitable for scenarios where data packets need to reach the receiver immediately. When synchronization is enabled, if the data packet delay is within the audio delay range, the SDK triggers the onStreamMessage callback synchronized with the audio packet during audio playback.
  @JsonKey(name: 'syncWithAudio')
  final bool? syncWithAudio;

  /// Whether to ensure the received data is in the same order as sent. true : Ensures the SDK outputs data packets in the same order as sent. false : Does not ensure the SDK outputs data packets in the same order as sent. Do not set this parameter to true if you require data packets to reach the receiver immediately.
  @JsonKey(name: 'ordered')
  final bool? ordered;

  /// @nodoc
  factory DataStreamConfig.fromJson(Map<String, dynamic> json) =>
      _$DataStreamConfigFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DataStreamConfigToJson(this);
}

/// Mode for sending video streams.
@JsonEnum(alwaysCreate: true)
enum SimulcastStreamMode {
  /// -1: By default, the low stream is not sent until a subscription request for the low stream is received from the receiver.
  @JsonValue(-1)
  autoSimulcastStream,

  /// 0: Never send the low stream.
  @JsonValue(0)
  disableSimulcastStream,

  /// 1: Always send the low stream.
  @JsonValue(1)
  enableSimulcastStream,
}

/// @nodoc
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

/// Configuration for the video low stream.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SimulcastStreamConfig implements AgoraSerializable {
  /// @nodoc
  const SimulcastStreamConfig({this.dimensions, this.kBitrate, this.framerate});

  /// Video dimensions. See VideoDimensions. The default value is 50% of the high stream.
  @JsonKey(name: 'dimensions')
  final VideoDimensions? dimensions;

  /// Video bitrate (Kbps). The default value is -1. You don't need to set this parameter. The SDK automatically selects the optimal bitrate based on the resolution and frame rate you set.
  @JsonKey(name: 'kBitrate')
  final int? kBitrate;

  /// Video frame rate (fps). The default value is 5.
  @JsonKey(name: 'framerate')
  final int? framerate;

  /// @nodoc
  factory SimulcastStreamConfig.fromJson(Map<String, dynamic> json) =>
      _$SimulcastStreamConfigFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SimulcastStreamConfigToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SimulcastConfig implements AgoraSerializable {
  /// @nodoc
  const SimulcastConfig({this.configs});

  /// @nodoc
  @JsonKey(name: 'configs')
  final List<StreamLayerConfig>? configs;

  /// @nodoc
  factory SimulcastConfig.fromJson(Map<String, dynamic> json) =>
      _$SimulcastConfigFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SimulcastConfigToJson(this);
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum StreamLayerIndex {
  /// @nodoc
  @JsonValue(0)
  streamLayer1,

  /// @nodoc
  @JsonValue(1)
  streamLayer2,

  /// @nodoc
  @JsonValue(2)
  streamLayer3,

  /// @nodoc
  @JsonValue(3)
  streamLayer4,

  /// @nodoc
  @JsonValue(4)
  streamLayer5,

  /// @nodoc
  @JsonValue(5)
  streamLayer6,

  /// @nodoc
  @JsonValue(6)
  streamLow,

  /// @nodoc
  @JsonValue(7)
  streamLayerCountMax,
}

/// @nodoc
extension StreamLayerIndexExt on StreamLayerIndex {
  /// @nodoc
  static StreamLayerIndex fromValue(int value) {
    return $enumDecode(_$StreamLayerIndexEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$StreamLayerIndexEnumMap[this]!;
  }
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class StreamLayerConfig implements AgoraSerializable {
  /// @nodoc
  const StreamLayerConfig({this.dimensions, this.framerate, this.enable});

  /// @nodoc
  @JsonKey(name: 'dimensions')
  final VideoDimensions? dimensions;

  /// @nodoc
  @JsonKey(name: 'framerate')
  final int? framerate;

  /// @nodoc
  @JsonKey(name: 'enable')
  final bool? enable;

  /// @nodoc
  factory StreamLayerConfig.fromJson(Map<String, dynamic> json) =>
      _$StreamLayerConfigFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StreamLayerConfigToJson(this);
}

/// The position of the target area relative to the entire screen or window. If not specified, it refers to the entire screen or window.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Rectangle implements AgoraSerializable {
  /// @nodoc
  const Rectangle({this.x, this.y, this.width, this.height});

  /// The horizontal offset of the top-left corner.
  @JsonKey(name: 'x')
  final int? x;

  /// The vertical offset of the top-left corner.
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

  @override
  Map<String, dynamic> toJson() => _$RectangleToJson(this);
}

/// Position and size of the watermark on the screen.
///
/// The position and size of the watermark on the screen are determined by xRatio, yRatio, and widthRatio :
///  (xRatio, yRatio) specify the coordinates of the top-left corner of the watermark, determining the distance from the top-left corner of the screen. widthRatio determines the width of the watermark.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class WatermarkRatio implements AgoraSerializable {
  /// @nodoc
  const WatermarkRatio({this.xRatio, this.yRatio, this.widthRatio});

  /// The x-coordinate of the top-left corner of the watermark. The origin is the top-left corner of the screen. The x-coordinate is the horizontal offset of the watermark's top-left corner relative to the origin. Value range: [0.0, 1.0], default is 0.
  @JsonKey(name: 'xRatio')
  final double? xRatio;

  /// The y-coordinate of the top-left corner of the watermark. The origin is the top-left corner of the screen. The y-coordinate is the vertical offset of the watermark's top-left corner relative to the origin. Value range: [0.0, 1.0], default is 0.
  @JsonKey(name: 'yRatio')
  final double? yRatio;

  /// The width of the watermark. The SDK calculates the proportional height of the watermark based on this value to ensure the image is not distorted when scaled. Value range: [0.0, 1.0], default is 0, meaning the watermark is not displayed.
  @JsonKey(name: 'widthRatio')
  final double? widthRatio;

  /// @nodoc
  factory WatermarkRatio.fromJson(Map<String, dynamic> json) =>
      _$WatermarkRatioFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WatermarkRatioToJson(this);
}

/// Configure watermark image.
///
/// Used to configure the watermark image to be added.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class WatermarkOptions implements AgoraSerializable {
  /// @nodoc
  const WatermarkOptions(
      {this.visibleInPreview,
      this.positionInLandscapeMode,
      this.positionInPortraitMode,
      this.watermarkRatio,
      this.mode});

  /// Whether the watermark is visible in the local preview view: true : (Default) The watermark is visible in the local preview view. false : The watermark is not visible in the local preview view.
  @JsonKey(name: 'visibleInPreview')
  final bool? visibleInPreview;

  /// When the watermark fit mode is fitModeCoverPosition, this parameter sets the area of the watermark image in landscape mode. See Rectangle.
  @JsonKey(name: 'positionInLandscapeMode')
  final Rectangle? positionInLandscapeMode;

  /// When the watermark fit mode is fitModeCoverPosition, this parameter sets the area of the watermark image in portrait mode. See Rectangle.
  @JsonKey(name: 'positionInPortraitMode')
  final Rectangle? positionInPortraitMode;

  /// When the watermark fit mode is fitModeUseImageRatio, this parameter sets the watermark coordinates in scaling mode. See WatermarkRatio.
  @JsonKey(name: 'watermarkRatio')
  final WatermarkRatio? watermarkRatio;

  /// The fit mode of the watermark. See WatermarkFitMode.
  @JsonKey(name: 'mode')
  final WatermarkFitMode? mode;

  /// @nodoc
  factory WatermarkOptions.fromJson(Map<String, dynamic> json) =>
      _$WatermarkOptionsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WatermarkOptionsToJson(this);
}

/// Call-related statistics.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RtcStats implements AgoraSerializable {
  /// @nodoc
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

  /// Call duration of the local user (seconds), cumulative value.
  @JsonKey(name: 'duration')
  final int? duration;

  /// Bytes sent.
  @JsonKey(name: 'txBytes')
  final int? txBytes;

  /// Bytes received.
  @JsonKey(name: 'rxBytes')
  final int? rxBytes;

  /// Audio bytes sent, cumulative value.
  @JsonKey(name: 'txAudioBytes')
  final int? txAudioBytes;

  /// Video bytes sent, cumulative value.
  @JsonKey(name: 'txVideoBytes')
  final int? txVideoBytes;

  /// Audio bytes received, cumulative value.
  @JsonKey(name: 'rxAudioBytes')
  final int? rxAudioBytes;

  /// Video bytes received, cumulative value.
  @JsonKey(name: 'rxVideoBytes')
  final int? rxVideoBytes;

  /// Sending bitrate (Kbps).
  @JsonKey(name: 'txKBitRate')
  final int? txKBitRate;

  /// Receiving bitrate (Kbps).
  @JsonKey(name: 'rxKBitRate')
  final int? rxKBitRate;

  /// Audio receiving bitrate (Kbps).
  @JsonKey(name: 'rxAudioKBitRate')
  final int? rxAudioKBitRate;

  /// Audio packet sending bitrate (Kbps).
  @JsonKey(name: 'txAudioKBitRate')
  final int? txAudioKBitRate;

  /// Video receiving bitrate (Kbps).
  @JsonKey(name: 'rxVideoKBitRate')
  final int? rxVideoKBitRate;

  /// Video sending bitrate (Kbps).
  @JsonKey(name: 'txVideoKBitRate')
  final int? txVideoKBitRate;

  /// Client-to-access-server latency (milliseconds).
  @JsonKey(name: 'lastmileDelay')
  final int? lastmileDelay;

  /// Number of users in the current channel.
  @JsonKey(name: 'userCount')
  final int? userCount;

  /// CPU usage (%) of the current app.
  ///  The cpuAppUsage reported in the onLeaveChannel callback is always 0.
  ///  Starting from Android 8.1, due to system limitations, you may not be able to obtain CPU usage via this property.
  @JsonKey(name: 'cpuAppUsage')
  final double? cpuAppUsage;

  /// CPU usage (%) of the current system.
  /// For Windows platform, in multi-core environments, this member indicates the average usage of multi-core CPUs. The calculation is (100 - CPU usage of system idle process shown in Task Manager)/100.
  ///  The cpuTotalUsage reported in the onLeaveChannel callback is always 0.
  @JsonKey(name: 'cpuTotalUsage')
  final double? cpuTotalUsage;

  /// Round-trip time from client to local router (ms). This property is enabled by default on devices running iOS versions earlier than 14, and disabled on iOS 14 and later.
  ///
  ///  To enable this property on iOS 14 and later, please [contact technical support](https://www.agora.io/cn/contact/).
  /// On Android, to obtain gatewayRtt, make sure you have added the android.permission.ACCESS_WIFI_STATE permission after </application> in your project's AndroidManifest.xml file.
  @JsonKey(name: 'gatewayRtt')
  final int? gatewayRtt;

  /// Memory usage ratio (%) of the current app. This value is for reference only. It may not be retrievable due to system limitations.
  @JsonKey(name: 'memoryAppUsageRatio')
  final double? memoryAppUsageRatio;

  /// Memory usage ratio (%) of the current system. This value is for reference only. It may not be retrievable due to system limitations.
  @JsonKey(name: 'memoryTotalUsageRatio')
  final double? memoryTotalUsageRatio;

  /// Memory usage of the current app (KB). This value is for reference only. It may not be retrievable due to system limitations.
  @JsonKey(name: 'memoryAppUsageInKbytes')
  final int? memoryAppUsageInKbytes;

  /// Time from starting to establish connection to successful connection (milliseconds). A value of 0 indicates invalid.
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

  /// Uplink packet loss rate (%) from client to server before applying anti-packet-loss technology.
  @JsonKey(name: 'txPacketLossRate')
  final int? txPacketLossRate;

  /// Downlink packet loss rate (%) from server to client before applying anti-packet-loss technology.
  @JsonKey(name: 'rxPacketLossRate')
  final int? rxPacketLossRate;

  /// @nodoc
  factory RtcStats.fromJson(Map<String, dynamic> json) =>
      _$RtcStatsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RtcStatsToJson(this);
}

/// User role in live broadcasting profile.
@JsonEnum(alwaysCreate: true)
enum ClientRoleType {
  /// 1: Broadcaster. A broadcaster can both send and receive streams.
  @JsonValue(1)
  clientRoleBroadcaster,

  /// 2: (Default) Audience. An audience member can only receive streams but cannot send them.
  @JsonValue(2)
  clientRoleAudience,
}

/// @nodoc
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

/// Local video quality adaptation since the last statistics (based on target frame rate and target bitrate).
@JsonEnum(alwaysCreate: true)
enum QualityAdaptIndication {
  /// 0: No change in local video quality.
  @JsonValue(0)
  adaptNone,

  /// 1: Local video quality improves due to increased network bandwidth.
  @JsonValue(1)
  adaptUpBandwidth,

  /// 2: Local video quality degrades due to decreased network bandwidth.
  @JsonValue(2)
  adaptDownBandwidth,
}

/// @nodoc
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

/// Latency level for audience in a live broadcast channel. This enum is effective only when the user role is set to clientRoleAudience.
@JsonEnum(alwaysCreate: true)
enum AudienceLatencyLevelType {
  /// 1: Low latency.
  @JsonValue(1)
  audienceLatencyLevelLowLatency,

  /// 2: (Default) Ultra-low latency.
  @JsonValue(2)
  audienceLatencyLevelUltraLowLatency,
}

/// @nodoc
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

/// User role property settings.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ClientRoleOptions implements AgoraSerializable {
  /// @nodoc
  const ClientRoleOptions({this.audienceLatencyLevel});

  /// Audience latency level. See AudienceLatencyLevelType.
  @JsonKey(name: 'audienceLatencyLevel')
  final AudienceLatencyLevelType? audienceLatencyLevel;

  /// @nodoc
  factory ClientRoleOptions.fromJson(Map<String, dynamic> json) =>
      _$ClientRoleOptionsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ClientRoleOptionsToJson(this);
}

/// The subjective experience quality of the local user when receiving remote audio.
@JsonEnum(alwaysCreate: true)
enum ExperienceQualityType {
  /// 0: Good subjective experience quality.
  @JsonValue(0)
  experienceQualityGood,

  /// 1: Poor subjective experience quality.
  @JsonValue(1)
  experienceQualityBad,
}

/// @nodoc
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

/// The reason for poor subjective experience quality of the local user when receiving remote audio.
@JsonEnum(alwaysCreate: true)
enum ExperiencePoorReason {
  /// 0: No reason, indicating good subjective experience quality.
  @JsonValue(0)
  experienceReasonNone,

  /// 1: Poor network condition of the remote user.
  @JsonValue(1)
  remoteNetworkQualityPoor,

  /// 2: Poor network condition of the local user.
  @JsonValue(2)
  localNetworkQualityPoor,

  /// 4: Weak Wi-Fi or mobile data signal of the local user.
  @JsonValue(4)
  wirelessSignalPoor,

  /// 8: Wi-Fi and Bluetooth are enabled simultaneously on the local device, causing signal interference and degraded audio transmission quality.
  @JsonValue(8)
  wifiBluetoothCoexist,
}

/// @nodoc
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

/// AI noise reduction mode.
@JsonEnum(alwaysCreate: true)
enum AudioAinsMode {
  /// 0: (Default) Balanced noise reduction mode. Choose this mode if you want a balanced effect between noise suppression and latency.
  @JsonValue(0)
  ainsModeBalanced,

  /// 1: Aggressive noise reduction mode. Suitable for scenarios with high noise suppression requirements, such as outdoor live streaming. This mode can significantly reduce noise but may slightly affect voice quality.
  @JsonValue(1)
  ainsModeAggressive,

  /// 2: Low-latency aggressive noise reduction mode. This mode has approximately half the latency of the weak and aggressive noise reduction modes. It is suitable for scenarios requiring both noise reduction and low latency, such as real-time chorus.
  @JsonValue(2)
  ainsModeUltralowlatency,
}

/// @nodoc
extension AudioAinsModeExt on AudioAinsMode {
  /// @nodoc
  static AudioAinsMode fromValue(int value) {
    return $enumDecode(_$AudioAinsModeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$AudioAinsModeEnumMap[this]!;
  }
}

/// Audio encoding attributes.
@JsonEnum(alwaysCreate: true)
enum AudioProfileType {
  /// 0: Default value.
  ///  In live broadcast: 48 kHz sample rate, music encoding, mono, max bitrate 64 Kbps.
  ///  In communication:
  ///  Windows: 16 kHz sample rate, voice encoding, mono, max bitrate 16 Kbps.
  ///  Android, macOS, iOS: 32 kHz sample rate, voice encoding, mono, max bitrate 18 Kbps.
  @JsonValue(0)
  audioProfileDefault,

  /// 1: 32 kHz sample rate, voice encoding, mono, max bitrate 18 Kbps.
  @JsonValue(1)
  audioProfileSpeechStandard,

  /// 2: 48 kHz sample rate, music encoding, mono, max bitrate 64 Kbps.
  @JsonValue(2)
  audioProfileMusicStandard,

  /// 3: 48 kHz sample rate, music encoding, stereo, max bitrate 80 Kbps.
  /// To enable stereo, you also need to call setAdvancedAudioOptions and set audioProcessingChannels to audioProcessingStereo in AdvancedAudioOptions.
  @JsonValue(3)
  audioProfileMusicStandardStereo,

  /// 4: 48 kHz sample rate, music encoding, mono, max bitrate 96 Kbps.
  @JsonValue(4)
  audioProfileMusicHighQuality,

  /// 5: 48 kHz sample rate, music encoding, stereo, max bitrate 128 Kbps.
  /// To enable stereo, you also need to call setAdvancedAudioOptions and set audioProcessingChannels to audioProcessingStereo in AdvancedAudioOptions.
  @JsonValue(5)
  audioProfileMusicHighQualityStereo,

  /// 6: 16 kHz sample rate, voice encoding, mono, applies echo cancellation algorithm AEC.
  @JsonValue(6)
  audioProfileIot,

  /// Enum boundary value.
  @JsonValue(7)
  audioProfileNum,
}

/// @nodoc
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

/// Audio scenarios.
@JsonEnum(alwaysCreate: true)
enum AudioScenarioType {
  /// 0: (default) Automatic scenario selection. Matches appropriate audio quality based on user role and audio route.
  @JsonValue(0)
  audioScenarioDefault,

  /// 3: High-quality audio scenario, suitable for music-centric use cases. For example: instrument practice.
  @JsonValue(3)
  audioScenarioGameStreaming,

  /// 5: Chatroom scenario, suitable for use cases where users frequently join and leave the mic. For example: education scenarios.
  @JsonValue(5)
  audioScenarioChatroom,

  /// 7: Chorus scenario. Suitable for real-time chorus with low latency under good network conditions.
  @JsonValue(7)
  audioScenarioChorus,

  /// 8: Meeting scenario, suitable for multi-person meetings focusing on voice.
  @JsonValue(8)
  audioScenarioMeeting,

  /// @nodoc
  @JsonValue(9)
  audioScenarioAiServer,

  /// 10: AI conversation scenario, only applicable for interactions with agents created using [Agora Conversational AI Engine](https://docs.agora.io/en/conversational-ai/overview/product-overview).
  @JsonValue(10)
  audioScenarioAiClient,

  /// Number of enumerations.
  @JsonValue(11)
  audioScenarioNum,
}

/// @nodoc
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

/// Video frame format.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoFormat implements AgoraSerializable {
  /// @nodoc
  const VideoFormat({this.width, this.height, this.fps});

  /// Width of the video frame (px). Default is 960.
  @JsonKey(name: 'width')
  final int? width;

  /// Height of the video frame (px). Default is 540.
  @JsonKey(name: 'height')
  final int? height;

  /// Frame rate of the video frame. Default is 15.
  @JsonKey(name: 'fps')
  final int? fps;

  /// @nodoc
  factory VideoFormat.fromJson(Map<String, dynamic> json) =>
      _$VideoFormatFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$VideoFormatToJson(this);
}

/// Content type for screen sharing.
@JsonEnum(alwaysCreate: true)
enum VideoContentHint {
  /// (Default) No specified content type.
  @JsonValue(0)
  contentHintNone,

  /// Content type is motion. Recommended when the shared content is video, movie, or video game.
  @JsonValue(1)
  contentHintMotion,

  /// Content type is details. Recommended when the shared content is image or text.
  @JsonValue(2)
  contentHintDetails,
}

/// @nodoc
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

/// Screen sharing scenario.
@JsonEnum(alwaysCreate: true)
enum ScreenScenarioType {
  /// 1: (Default) Document. In this scenario, image quality is prioritized and latency on the receiving end is reduced. Use this scenario when sharing documents, slides, or spreadsheets.
  @JsonValue(1)
  screenScenarioDocument,

  /// 2: Gaming. In this scenario, smoothness is prioritized. Use this scenario when sharing games.
  @JsonValue(2)
  screenScenarioGaming,

  /// 3: Video. In this scenario, smoothness is prioritized. Use this scenario when sharing movies or live video.
  @JsonValue(3)
  screenScenarioVideo,

  /// 4: Remote control. In this scenario, image quality is prioritized and latency on the receiving end is reduced. Use this scenario when sharing the desktop of a remotely controlled device.
  @JsonValue(4)
  screenScenarioRdc,
}

/// @nodoc
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

/// Video application scenario type.
@JsonEnum(alwaysCreate: true)
enum VideoApplicationScenarioType {
  /// 0: (Default) General scenario.
  @JsonValue(0)
  applicationScenarioGeneral,

  /// 1: Meeting scenario.
  @JsonValue(1)
  applicationScenarioMeeting,

  /// 2: 1v1 video call
  @JsonValue(2)
  applicationScenario1v1,

  /// 3: Live show
  @JsonValue(3)
  applicationScenarioLiveshow,
}

/// @nodoc
extension VideoApplicationScenarioTypeExt on VideoApplicationScenarioType {
  /// @nodoc
  static VideoApplicationScenarioType fromValue(int value) {
    return $enumDecode(_$VideoApplicationScenarioTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$VideoApplicationScenarioTypeEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum VideoQoePreferenceType {
  /// @nodoc
  @JsonValue(1)
  videoQoePreferenceBalance,

  /// @nodoc
  @JsonValue(2)
  videoQoePreferenceDelayFirst,

  /// @nodoc
  @JsonValue(3)
  videoQoePreferencePictureQualityFirst,

  /// @nodoc
  @JsonValue(4)
  videoQoePreferenceFluencyFirst,
}

/// @nodoc
extension VideoQoePreferenceTypeExt on VideoQoePreferenceType {
  /// @nodoc
  static VideoQoePreferenceType fromValue(int value) {
    return $enumDecode(_$VideoQoePreferenceTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$VideoQoePreferenceTypeEnumMap[this]!;
  }
}

/// Brightness level of locally captured video quality.
@JsonEnum(alwaysCreate: true)
enum CaptureBrightnessLevelType {
  /// -1: SDK did not detect the brightness level of the locally captured video. Please wait a few seconds and get the brightness level from the next captureBrightnessLevel callback.
  @JsonValue(-1)
  captureBrightnessLevelInvalid,

  /// 0: Brightness of the locally captured video is normal.
  @JsonValue(0)
  captureBrightnessLevelNormal,

  /// 1: Brightness of the locally captured video is too bright.
  @JsonValue(1)
  captureBrightnessLevelBright,

  /// 2: Brightness of the locally captured video is too dark.
  @JsonValue(2)
  captureBrightnessLevelDark,
}

/// @nodoc
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

/// Camera stabilization mode.
///
/// Camera stabilization effect increases in the order of 1 < 2 < 3, and the latency increases accordingly.
@JsonEnum(alwaysCreate: true)
enum CameraStabilizationMode {
  /// -1: (Default) Camera stabilization is off.
  @JsonValue(-1)
  cameraStabilizationModeOff,

  /// 0: Camera auto stabilization. The system automatically selects a stabilization mode based on the camera status. However, this mode has higher latency, so it is not recommended to use this enum.
  @JsonValue(0)
  cameraStabilizationModeAuto,

  /// 1: (Recommended) Level 1 camera stabilization.
  @JsonValue(1)
  cameraStabilizationModeLevel1,

  /// 2: Level 2 camera stabilization.
  @JsonValue(2)
  cameraStabilizationModeLevel2,

  /// 3: Level 3 camera stabilization.
  @JsonValue(3)
  cameraStabilizationModeLevel3,

  /// @nodoc
  @JsonValue(3)
  cameraStabilizationModeMaxLevel,
}

/// @nodoc
extension CameraStabilizationModeExt on CameraStabilizationMode {
  /// @nodoc
  static CameraStabilizationMode fromValue(int value) {
    return $enumDecode(_$CameraStabilizationModeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$CameraStabilizationModeEnumMap[this]!;
  }
}

/// Local audio state.
@JsonEnum(alwaysCreate: true)
enum LocalAudioStreamState {
  /// 0: Default initial state of local audio.
  @JsonValue(0)
  localAudioStreamStateStopped,

  /// 1: Local audio capture device started successfully.
  @JsonValue(1)
  localAudioStreamStateRecording,

  /// 2: First frame of local audio encoded successfully.
  @JsonValue(2)
  localAudioStreamStateEncoding,

  /// 3: Failed to start local audio.
  @JsonValue(3)
  localAudioStreamStateFailed,
}

/// @nodoc
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

/// Reasons for local audio state change.
@JsonEnum(alwaysCreate: true)
enum LocalAudioStreamReason {
  /// 0: Local audio is working properly.
  @JsonValue(0)
  localAudioStreamReasonOk,

  /// 1: Unknown reason for local audio failure. Suggest prompting the user to try rejoining the channel.
  @JsonValue(1)
  localAudioStreamReasonFailure,

  /// 2: No permission to start local audio capture device. Prompt the user to grant permission. Deprecated: This enum is deprecated. Use recordAudio in the onPermissionError callback instead.
  @JsonValue(2)
  localAudioStreamReasonDeviceNoPermission,

  /// 3: (Android and iOS only) Local audio capture device is in use. Prompt the user to check if the microphone is occupied by another app. Local audio capture will automatically resume about 5 seconds after the microphone becomes idle, or you can try rejoining the channel after it becomes idle.
  @JsonValue(3)
  localAudioStreamReasonDeviceBusy,

  /// 4: Local audio capture failed.
  @JsonValue(4)
  localAudioStreamReasonRecordFailure,

  /// 5: Local audio encoding failed.
  @JsonValue(5)
  localAudioStreamReasonEncodeFailure,

  /// 6: (Windows and macOS only) No local audio capture device. Prompt the user to check in the control panel whether the microphone is properly connected and working.
  @JsonValue(6)
  localAudioStreamReasonNoRecordingDevice,

  /// 7: (Windows and macOS only) No local audio playback device. Prompt the user to check in the control panel whether the speaker is properly connected and working.
  @JsonValue(7)
  localAudioStreamReasonNoPlayoutDevice,

  /// 8: (Android and iOS only) Local audio capture was interrupted by system call, smart assistant, or alarm. To resume local audio capture, ask the user to end the call, assistant, or alarm.
  @JsonValue(8)
  localAudioStreamReasonInterrupted,

  /// 9: (Windows only) Invalid ID for local audio capture device. Prompt the user to check the audio capture device ID.
  @JsonValue(9)
  localAudioStreamReasonRecordInvalidId,

  /// 10: (Windows only) Invalid ID for local audio playback device. Prompt the user to check the audio playback device ID.
  @JsonValue(10)
  localAudioStreamReasonPlayoutInvalidId,
}

/// @nodoc
extension LocalAudioStreamReasonExt on LocalAudioStreamReason {
  /// @nodoc
  static LocalAudioStreamReason fromValue(int value) {
    return $enumDecode(_$LocalAudioStreamReasonEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$LocalAudioStreamReasonEnumMap[this]!;
  }
}

/// Local video state.
@JsonEnum(alwaysCreate: true)
enum LocalVideoStreamState {
  /// 0: Default initial state of local video.
  @JsonValue(0)
  localVideoStreamStateStopped,

  /// 1: Local video capture device started successfully.
  @JsonValue(1)
  localVideoStreamStateCapturing,

  /// 2: First frame of local video encoded successfully.
  @JsonValue(2)
  localVideoStreamStateEncoding,

  /// 3: Failed to start local video.
  @JsonValue(3)
  localVideoStreamStateFailed,
}

/// @nodoc
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

/// Reason for local video state change.
@JsonEnum(alwaysCreate: true)
enum LocalVideoStreamReason {
  /// 0: Local video is in normal state.
  @JsonValue(0)
  localVideoStreamReasonOk,

  /// 1: Unknown error.
  @JsonValue(1)
  localVideoStreamReasonFailure,

  /// 2: No permission to start the local video capture device. Prompt the user to enable device permissions and rejoin the channel. Deprecated: This enum is deprecated. Use onPermissionError callback with camera instead.
  @JsonValue(2)
  localVideoStreamReasonDeviceNoPermission,

  /// 3: The local video capture device is currently in use. Prompt the user to check if the camera is occupied by another app or try rejoining the channel.
  @JsonValue(3)
  localVideoStreamReasonDeviceBusy,

  /// 4: Failed to capture local video. Prompt the user to check if the video capture device is working properly, whether the camera is occupied by another app, or try rejoining the channel.
  @JsonValue(4)
  localVideoStreamReasonCaptureFailure,

  /// 5: Failed to encode local video.
  @JsonValue(5)
  localVideoStreamReasonCodecNotSupport,

  /// 6: (iOS only) The app is in the background. Prompt the user that video capture cannot function properly while the app is in the background.
  @JsonValue(6)
  localVideoStreamReasonCaptureInbackground,

  /// 7: (iOS only) The current app window is in Slide Over, Split View, or Picture-in-Picture mode, and another app is using the camera. Prompt the user that video capture cannot function properly under these conditions.
  @JsonValue(7)
  localVideoStreamReasonCaptureMultipleForegroundApps,

  /// 8: Local video capture device not found. Check if the camera is properly connected and functioning, or try rejoining the channel.
  @JsonValue(8)
  localVideoStreamReasonDeviceNotFound,

  /// 9: (macOS and Windows only) The video capture device in use has been disconnected (e.g., unplugged).
  @JsonValue(9)
  localVideoStreamReasonDeviceDisconnected,

  /// 10: (macOS and Windows only) The SDK cannot find the video device in the device list. Check if the video device ID is valid.
  @JsonValue(10)
  localVideoStreamReasonDeviceInvalidId,

  /// 14: (Android only) Video capture interrupted. Possible reasons:
  ///  The camera is occupied by another app. Prompt the user to check if the camera is in use.
  ///  The app has been sent to the background. Use a foreground service notification to ensure video capture continues in the background.
  @JsonValue(14)
  localVideoStreamReasonDeviceInterrupt,

  /// 15: (Android only) Video capture device error. Prompt the user to turn the camera off and on again. If the issue persists, check for hardware failure.
  @JsonValue(15)
  localVideoStreamReasonDeviceFatalError,

  /// 101: The video capture device is unavailable due to excessive system pressure.
  @JsonValue(101)
  localVideoStreamReasonDeviceSystemPressure,

  /// 11: (macOS and Windows only) The window shared via startScreenCaptureByWindowId is minimized. The SDK cannot share minimized windows. Prompt the user to restore the window.
  @JsonValue(11)
  localVideoStreamReasonScreenCaptureWindowMinimized,

  /// 12: (macOS and Windows only) The window shared by window ID has been closed, or a fullscreen window shared by ID has exited fullscreen. After exiting fullscreen, remote users will not see the shared window. To avoid black screens, it is recommended to end the sharing session immediately.
  /// Common scenarios for this error code:
  ///  The local user closes the shared window.
  ///  The local user plays a slideshow and shares it. When the slideshow ends, the SDK reports this error code.
  ///  The local user views a web video or document in fullscreen, then shares it. When exiting fullscreen, the SDK reports this error code.
  @JsonValue(12)
  localVideoStreamReasonScreenCaptureWindowClosed,

  /// 13: (Windows only) The window to be shared is occluded by another window. The occluded part will appear black in the shared content.
  @JsonValue(13)
  localVideoStreamReasonScreenCaptureWindowOccluded,

  /// @nodoc
  @JsonValue(20)
  localVideoStreamReasonScreenCaptureWindowNotSupported,

  /// 21: (Windows and Android only) No data from the currently captured window.
  @JsonValue(21)
  localVideoStreamReasonScreenCaptureFailure,

  /// 22: (Windows and macOS only) No permission to capture the screen.
  @JsonValue(22)
  localVideoStreamReasonScreenCaptureNoPermission,

  /// 24: (Windows only) An unexpected error occurred during screen sharing (possibly due to failure to block a window), causing the screen sharing strategy to fall back. The sharing process itself is not affected. During screen sharing, if the SDK fails to block a specific window due to driver or hardware issues, it will report this event and automatically fall back to sharing the entire screen. If your use case requires blocking specific windows for privacy, listen for this event and implement additional privacy protections when triggered.
  @JsonValue(24)
  localVideoStreamReasonScreenCaptureAutoFallback,

  /// 25: (Windows only) The window being captured is hidden and not visible on the current screen.
  @JsonValue(25)
  localVideoStreamReasonScreenCaptureWindowHidden,

  /// 26: (Windows only) The window being captured has recovered from a hidden state.
  @JsonValue(26)
  localVideoStreamReasonScreenCaptureWindowRecoverFromHidden,

  /// 27: (macOS and Windows only) The window being captured has recovered from a minimized state.
  @JsonValue(27)
  localVideoStreamReasonScreenCaptureWindowRecoverFromMinimized,

  /// 28: (Windows only) Screen capture is paused. Common scenario: the screen may have switched to a secure desktop, such as a UAC dialog or Winlogon desktop.
  @JsonValue(28)
  localVideoStreamReasonScreenCapturePaused,

  /// 29: (Windows only) Screen capture has resumed from a paused state.
  @JsonValue(29)
  localVideoStreamReasonScreenCaptureResumed,

  /// 30: (Windows and macOS only) The display being captured has been disconnected. Prompt the user that screen sharing is paused and restart screen sharing.
  @JsonValue(30)
  localVideoStreamReasonScreenCaptureDisplayDisconnected,
}

/// @nodoc
extension LocalVideoStreamReasonExt on LocalVideoStreamReason {
  /// @nodoc
  static LocalVideoStreamReason fromValue(int value) {
    return $enumDecode(_$LocalVideoStreamReasonEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$LocalVideoStreamReasonEnumMap[this]!;
  }
}

/// Remote audio stream state.
@JsonEnum(alwaysCreate: true)
enum RemoteAudioState {
  /// 0: The default initial state of the remote audio. This state is reported in cases of remoteAudioReasonLocalMuted, remoteAudioReasonRemoteMuted, or remoteAudioReasonRemoteOffline.
  @JsonValue(0)
  remoteAudioStateStopped,

  /// 1: The local user has received the first packet of the remote audio.
  @JsonValue(1)
  remoteAudioStateStarting,

  /// 2: The remote audio stream is decoding and playing normally. This state is reported in cases of remoteAudioReasonNetworkRecovery, remoteAudioReasonLocalUnmuted, or remoteAudioReasonRemoteUnmuted.
  @JsonValue(2)
  remoteAudioStateDecoding,

  /// 3: The remote audio stream is frozen. This state is reported in the case of remoteAudioReasonNetworkCongestion.
  @JsonValue(3)
  remoteAudioStateFrozen,

  /// 4: The remote audio stream failed to play. This state is reported in the case of remoteAudioReasonInternal.
  @JsonValue(4)
  remoteAudioStateFailed,
}

/// @nodoc
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

/// Reason for remote audio stream state change.
@JsonEnum(alwaysCreate: true)
enum RemoteAudioStateReason {
  /// 0: This reason is reported when the audio state changes.
  @JsonValue(0)
  remoteAudioReasonInternal,

  /// 1: Network congestion.
  @JsonValue(1)
  remoteAudioReasonNetworkCongestion,

  /// 2: Network recovered.
  @JsonValue(2)
  remoteAudioReasonNetworkRecovery,

  /// 3: Local user stopped receiving remote audio stream or disabled the audio module.
  @JsonValue(3)
  remoteAudioReasonLocalMuted,

  /// 4: Local user resumed receiving remote audio stream or enabled the audio module.
  @JsonValue(4)
  remoteAudioReasonLocalUnmuted,

  /// 5: Remote user stopped sending audio stream or disabled the audio module.
  @JsonValue(5)
  remoteAudioReasonRemoteMuted,

  /// 6: Remote user resumed sending audio stream or enabled the audio module.
  @JsonValue(6)
  remoteAudioReasonRemoteUnmuted,

  /// 7: Remote user left the channel.
  @JsonValue(7)
  remoteAudioReasonRemoteOffline,

  /// @nodoc
  @JsonValue(8)
  remoteAudioReasonNoPacketReceive,

  /// @nodoc
  @JsonValue(9)
  remoteAudioReasonLocalPlayFailed,
}

/// @nodoc
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

/// Remote video stream state.
@JsonEnum(alwaysCreate: true)
enum RemoteVideoState {
  /// 0: The default initial state of the remote video. This state is reported in cases of remoteVideoStateReasonLocalMuted, remoteVideoStateReasonRemoteMuted, or remoteVideoStateReasonRemoteOffline.
  @JsonValue(0)
  remoteVideoStateStopped,

  /// 1: The local user has received the first packet of the remote video.
  @JsonValue(1)
  remoteVideoStateStarting,

  /// 2: The remote video stream is decoding and playing normally. This state is reported in cases of remoteVideoStateReasonNetworkRecovery, remoteVideoStateReasonLocalUnmuted, remoteVideoStateReasonRemoteUnmuted, or remoteVideoStateReasonAudioFallbackRecovery.
  @JsonValue(2)
  remoteVideoStateDecoding,

  /// 3: The remote video stream is frozen. This state is reported in cases of remoteVideoStateReasonNetworkCongestion or remoteVideoStateReasonAudioFallback.
  @JsonValue(3)
  remoteVideoStateFrozen,

  /// 4: The remote video stream failed to play. This state is reported in the case of remoteVideoStateReasonInternal.
  @JsonValue(4)
  remoteVideoStateFailed,
}

/// @nodoc
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

/// Reason for remote video stream state change.
@JsonEnum(alwaysCreate: true)
enum RemoteVideoStateReason {
  /// 0: This reason is reported when the video state changes.
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

  /// 8: Under poor network conditions, the remote audio and video stream falls back to audio only.
  @JsonValue(8)
  remoteVideoStateReasonAudioFallback,

  /// 9: When the network improves, the remote audio stream recovers to audio and video stream.
  @JsonValue(9)
  remoteVideoStateReasonAudioFallbackRecovery,

  /// @nodoc
  @JsonValue(10)
  remoteVideoStateReasonVideoStreamTypeChangeToLow,

  /// @nodoc
  @JsonValue(11)
  remoteVideoStateReasonVideoStreamTypeChangeToHigh,

  /// 12: (iOS only) The remote user's app has switched to the background.
  @JsonValue(12)
  remoteVideoStateReasonSdkInBackground,

  /// 13: The local video decoder does not support decoding the received remote video stream.
  @JsonValue(13)
  remoteVideoStateReasonCodecNotSupport,
}

/// @nodoc
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

/// @nodoc
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
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoTrackInfo implements AgoraSerializable {
  /// @nodoc
  const VideoTrackInfo(
      {this.isLocal,
      this.ownerUid,
      this.trackId,
      this.channelId,
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

  @override
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

/// @nodoc
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

/// User volume information.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioVolumeInfo implements AgoraSerializable {
  /// @nodoc
  const AudioVolumeInfo({this.uid, this.volume, this.vad, this.voicePitch});

  /// User ID.
  ///  In the local user's callback, uid is 0.
  ///  In the remote user's callback, uid is the ID of the remote user with the highest instantaneous volume (up to 3 users).
  @JsonKey(name: 'uid')
  final int? uid;

  /// User volume, range [0,255]. If the user mutes themselves (sets muteLocalAudioStream to true) but audio capture is enabled, the volume value represents the volume of the locally captured signal.
  @JsonKey(name: 'volume')
  final int? volume;

  /// vad does not report the voice status of remote users. For remote users, the value of vad is always 1.
  ///  To use this parameter, set reportVad to true when calling enableAudioVolumeIndication. Voice activity status of the local user.
  ///  0: No voice detected locally.
  ///  1: Voice detected locally.
  @JsonKey(name: 'vad')
  final int? vad;

  /// Voice pitch of the local user (Hz). Value range: [0.0, 4000.0]. voicePitch does not report the voice pitch of remote users. For remote users, the value of voicePitch is always 0.0.
  @JsonKey(name: 'voicePitch')
  final double? voicePitch;

  /// @nodoc
  factory AudioVolumeInfo.fromJson(Map<String, dynamic> json) =>
      _$AudioVolumeInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AudioVolumeInfoToJson(this);
}

/// Audio device information.
///
/// This class is only applicable to the Android platform.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class DeviceInfo implements AgoraSerializable {
  /// @nodoc
  const DeviceInfo({this.isLowLatencyAudioSupported});

  /// Whether ultra-low latency audio capture and playback is supported: true : Supported false : Not supported
  @JsonKey(name: 'isLowLatencyAudioSupported')
  final bool? isLowLatencyAudioSupported;

  /// @nodoc
  factory DeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DeviceInfoToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Packet implements AgoraSerializable {
  /// @nodoc
  const Packet({this.buffer, this.size});

  /// @nodoc
  @JsonKey(name: 'buffer', ignore: true)
  final Uint8List? buffer;

  /// @nodoc
  @JsonKey(name: 'size')
  final int? size;

  /// @nodoc
  factory Packet.fromJson(Map<String, dynamic> json) => _$PacketFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PacketToJson(this);
}

/// Sampling rate of the audio output during streaming.
@JsonEnum(alwaysCreate: true)
enum AudioSampleRateType {
  /// 32000: 32 kHz
  @JsonValue(32000)
  audioSampleRate32000,

  /// 44100: 44.1 kHz
  @JsonValue(44100)
  audioSampleRate44100,

  /// 48000: (default) 48 kHz
  @JsonValue(48000)
  audioSampleRate48000,
}

/// @nodoc
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

/// Codec type for transcoded output video stream.
@JsonEnum(alwaysCreate: true)
enum VideoCodecTypeForStream {
  /// 1: (Default) H.264.
  @JsonValue(1)
  videoCodecH264ForStream,

  /// 2: H.265.
  @JsonValue(2)
  videoCodecH265ForStream,
}

/// @nodoc
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

/// Codec profile for video in CDN streaming.
@JsonEnum(alwaysCreate: true)
enum VideoCodecProfileType {
  /// 66: Baseline profile, generally used for low-end or error-tolerant applications such as video calls and mobile videos.
  @JsonValue(66)
  videoCodecProfileBaseline,

  /// 77: Main profile, generally used in mainstream consumer electronics such as MP4 players, portable video players, PSP, iPad, etc.
  @JsonValue(77)
  videoCodecProfileMain,

  /// 100: (Default) High profile, generally used for broadcasting, video disc storage, and HDTV.
  @JsonValue(100)
  videoCodecProfileHigh,
}

/// @nodoc
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

/// Audio codec profile for stream output. Defaults to LC-AAC.
@JsonEnum(alwaysCreate: true)
enum AudioCodecProfileType {
  /// 0: (Default) LC-AAC profile.
  @JsonValue(0)
  audioCodecProfileLcAac,

  /// 1: HE-AAC profile.
  @JsonValue(1)
  audioCodecProfileHeAac,

  /// 2: HE-AAC v2 profile.
  @JsonValue(2)
  audioCodecProfileHeAacV2,
}

/// @nodoc
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
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LocalAudioStats implements AgoraSerializable {
  /// @nodoc
  const LocalAudioStats(
      {this.numChannels,
      this.sentSampleRate,
      this.sentBitrate,
      this.internalCodec,
      this.txPacketLossRate,
      this.audioDeviceDelay,
      this.audioPlayoutDelay,
      this.earMonitorDelay,
      this.aecEstimatedDelay});

  /// Number of audio channels.
  @JsonKey(name: 'numChannels')
  final int? numChannels;

  /// Sampling rate of the sent local audio, in Hz.
  @JsonKey(name: 'sentSampleRate')
  final int? sentSampleRate;

  /// Average bitrate of the sent local audio, in Kbps.
  @JsonKey(name: 'sentBitrate')
  final int? sentBitrate;

  /// Internal payload type.
  @JsonKey(name: 'internalCodec')
  final int? internalCodec;

  /// Packet loss rate (%) from the local end to the Agora edge server before network resilience is applied.
  @JsonKey(name: 'txPacketLossRate')
  final int? txPacketLossRate;

  /// Delay (ms) of the audio device module during audio playback or recording.
  @JsonKey(name: 'audioDeviceDelay')
  final int? audioDeviceDelay;

  /// @nodoc
  @JsonKey(name: 'audioPlayoutDelay')
  final int? audioPlayoutDelay;

  /// Ear monitor delay (ms), i.e., the delay from microphone input to headphone output.
  @JsonKey(name: 'earMonitorDelay')
  final int? earMonitorDelay;

  /// Acoustic Echo Cancellation (AEC) delay (ms), i.e., the delay estimated by the AEC module between audio playback and the signal captured locally.
  @JsonKey(name: 'aecEstimatedDelay')
  final int? aecEstimatedDelay;

  /// @nodoc
  factory LocalAudioStats.fromJson(Map<String, dynamic> json) =>
      _$LocalAudioStatsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LocalAudioStatsToJson(this);
}

/// The state of RTMP streaming.
@JsonEnum(alwaysCreate: true)
enum RtmpStreamPublishState {
  /// 0: Streaming has not started or has ended.
  @JsonValue(0)
  rtmpStreamPublishStateIdle,

  /// 1: Connecting to the streaming server and CDN server.
  @JsonValue(1)
  rtmpStreamPublishStateConnecting,

  /// 2: Streaming is in progress. This state is returned after successful streaming.
  @JsonValue(2)
  rtmpStreamPublishStateRunning,

  /// 3: Recovering the stream. When the CDN encounters an issue or the stream is briefly interrupted, the SDK automatically attempts to recover the stream and returns this state.
  ///  If recovery is successful, it transitions to rtmpStreamPublishStateRunning(2).
  ///  If the server fails or recovery is not successful within 60 seconds, it transitions to rtmpStreamPublishStateFailure(4). If 60 seconds is too long, you can also manually attempt reconnection.
  @JsonValue(3)
  rtmpStreamPublishStateRecovering,

  /// 4: Streaming failed. After failure, you can troubleshoot the error based on the returned error code.
  @JsonValue(4)
  rtmpStreamPublishStateFailure,

  /// 5: The SDK is disconnecting from the streaming server and CDN server. When you call the stopRtmpStream method to end streaming normally, the SDK reports the streaming state as rtmpStreamPublishStateDisconnecting, then rtmpStreamPublishStateIdle.
  @JsonValue(5)
  rtmpStreamPublishStateDisconnecting,
}

/// @nodoc
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

/// The reason for RTMP stream publishing state change.
@JsonEnum(alwaysCreate: true)
enum RtmpStreamPublishReason {
  /// 0: Stream published successfully.
  @JsonValue(0)
  rtmpStreamPublishReasonOk,

  /// 1: Invalid parameter. Please check whether the input parameters are correct.
  @JsonValue(1)
  rtmpStreamPublishReasonInvalidArgument,

  /// 2: The stream is encrypted and cannot be published.
  @JsonValue(2)
  rtmpStreamPublishReasonEncryptedStreamNotAllowed,

  /// 3: Publishing timed out and failed.
  @JsonValue(3)
  rtmpStreamPublishReasonConnectionTimeout,

  /// 4: An error occurred on the streaming server.
  @JsonValue(4)
  rtmpStreamPublishReasonInternalServerError,

  /// 5: An error occurred on the CDN server.
  @JsonValue(5)
  rtmpStreamPublishReasonRtmpServerError,

  /// 6: Streaming requests are too frequent.
  @JsonValue(6)
  rtmpStreamPublishReasonTooOften,

  /// 7: The number of streaming URLs for a single broadcaster has reached the limit of 10. Please remove some unused URLs before adding new ones.
  @JsonValue(7)
  rtmpStreamPublishReasonReachLimit,

  /// 8: The broadcaster is operating on a stream that does not belong to them. For example, updating or stopping another broadcaster's stream. Please check your app logic.
  @JsonValue(8)
  rtmpStreamPublishReasonNotAuthorized,

  /// 9: The server could not find the stream.
  @JsonValue(9)
  rtmpStreamPublishReasonStreamNotFound,

  /// 10: The streaming URL format is incorrect. Please check whether the format is valid.
  @JsonValue(10)
  rtmpStreamPublishReasonFormatNotSupported,

  /// 11: The user role is not broadcaster, and the user cannot use the streaming feature. Please check your application logic.
  @JsonValue(11)
  rtmpStreamPublishReasonNotBroadcaster,

  /// 13: The updateRtmpTranscoding method was called to update transcoding properties when not using transcoding streaming. Please check your application logic.
  @JsonValue(13)
  rtmpStreamPublishReasonTranscodingNoMixStream,

  /// 14: The broadcaster's network encountered an error.
  @JsonValue(14)
  rtmpStreamPublishReasonNetDown,

  /// @nodoc
  @JsonValue(15)
  rtmpStreamPublishReasonInvalidAppid,

  /// 16: Your project does not have permission to use the streaming service.
  @JsonValue(16)
  rtmpStreamPublishReasonInvalidPrivilege,

  /// 100: Streaming has ended normally. After you stop streaming, the SDK returns this value.
  @JsonValue(100)
  rtmpStreamUnpublishReasonOk,
}

/// @nodoc
extension RtmpStreamPublishReasonExt on RtmpStreamPublishReason {
  /// @nodoc
  static RtmpStreamPublishReason fromValue(int value) {
    return $enumDecode(_$RtmpStreamPublishReasonEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$RtmpStreamPublishReasonEnumMap[this]!;
  }
}

/// Events that occur during RTMP streaming.
@JsonEnum(alwaysCreate: true)
enum RtmpStreamingEvent {
  /// 1: Failed to add background image or watermark during RTMP streaming.
  @JsonValue(1)
  rtmpStreamingEventFailedLoadImage,

  /// 2: The streaming URL is already in use. If you want to start a new stream, please use a new streaming URL.
  @JsonValue(2)
  rtmpStreamingEventUrlAlreadyInUse,

  /// 3: Feature not supported.
  @JsonValue(3)
  rtmpStreamingEventAdvancedFeatureNotSupport,

  /// 4: Reserved parameter.
  @JsonValue(4)
  rtmpStreamingEventRequestTooOften,
}

/// @nodoc
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
///
/// Used to set the properties of watermark and background images in live video.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RtcImage implements AgoraSerializable {
  /// @nodoc
  const RtcImage(
      {this.url,
      this.x,
      this.y,
      this.width,
      this.height,
      this.zOrder,
      this.alpha});

  /// The HTTP/HTTPS URL of the image on the live video. The character length must not exceed 1024 bytes.
  @JsonKey(name: 'url')
  final String? url;

  /// The x-coordinate (px) of the image on the video frame, using the top-left corner of the output video frame as the origin.
  @JsonKey(name: 'x')
  final int? x;

  /// The y-coordinate (px) of the image on the video frame, using the top-left corner of the output video frame as the origin.
  @JsonKey(name: 'y')
  final int? y;

  /// The width (px) of the image on the video frame.
  @JsonKey(name: 'width')
  final int? width;

  /// The height (px) of the image on the video frame.
  @JsonKey(name: 'height')
  final int? height;

  /// The layer index of the watermark or background image. When adding one or more watermarks using a watermark array, you must assign a value to zOrder. The valid range is [1,255]; otherwise, the SDK will report an error. In other cases, zOrder is optional. The valid range is [0,255], with 0 as the default. 0 represents the bottom layer, and 255 represents the top layer.
  @JsonKey(name: 'zOrder')
  final int? zOrder;

  /// The transparency of the watermark or background image. The valid range is [0.0,1.0]:
  ///  0.0: Fully transparent.
  ///  1.0: (Default) Fully opaque.
  @JsonKey(name: 'alpha')
  final double? alpha;

  /// @nodoc
  factory RtcImage.fromJson(Map<String, dynamic> json) =>
      _$RtcImageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RtcImageToJson(this);
}

/// Advanced feature configuration for transcoding live streaming.
///
/// To use advanced transcoding live streaming features, please [contact sales](mailto:support@agora.io).
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LiveStreamAdvancedFeature implements AgoraSerializable {
  /// @nodoc
  const LiveStreamAdvancedFeature({this.featureName, this.opened});

  /// The name of the advanced transcoding live streaming feature, including LBHQ (low-bitrate high-definition video) and VEO (optimized video encoder).
  @JsonKey(name: 'featureName')
  final String? featureName;

  /// Whether to enable the advanced transcoding live streaming feature: true : Enable the advanced transcoding live streaming feature. false : (default) Disable the advanced transcoding live streaming feature.
  @JsonKey(name: 'opened')
  final bool? opened;

  /// @nodoc
  factory LiveStreamAdvancedFeature.fromJson(Map<String, dynamic> json) =>
      _$LiveStreamAdvancedFeatureFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LiveStreamAdvancedFeatureToJson(this);
}

/// Network connection state.
@JsonEnum(alwaysCreate: true)
enum ConnectionStateType {
  /// 1: Disconnected from the network. This state indicates the SDK is:
  ///  In the initialization phase before calling joinChannel.
  ///  Or in the phase after calling leaveChannel.
  @JsonValue(1)
  connectionStateDisconnected,

  /// 2: Connecting to the network. This state indicates the SDK is establishing a connection to the specified channel after calling joinChannel.
  ///  If the channel is joined successfully, the app receives the onConnectionStateChanged callback indicating the network state has changed to connectionStateConnected.
  ///  After establishing the connection, the SDK initializes media and calls back onJoinChannelSuccess when everything is ready.
  @JsonValue(2)
  connectionStateConnecting,

  /// 3: Network connected. This state indicates the user has joined the channel and can publish or subscribe to media streams. If the connection to the channel is lost due to network issues or switching, the SDK attempts to reconnect. The app receives the onConnectionStateChanged callback indicating the network state has changed to connectionStateReconnecting.
  @JsonValue(3)
  connectionStateConnected,

  /// 4: Reconnecting to the network. This state indicates the SDK had previously joined the channel but the connection was interrupted due to network issues. The SDK automatically attempts to rejoin the channel.
  ///  If the SDK fails to rejoin within 10 seconds, onConnectionLost is triggered. The SDK remains in the connectionStateReconnecting state and continues trying to rejoin.
  ///  If the SDK fails to rejoin the channel within 20 minutes after disconnection, the app receives the onConnectionStateChanged callback indicating the network state has changed to connectionStateFailed, and the SDK stops trying to reconnect.
  @JsonValue(4)
  connectionStateReconnecting,

  /// 5: Network connection failed. This state indicates the SDK has stopped trying to rejoin the channel and you need to call leaveChannel to leave.
  ///  If the user wants to rejoin the channel, call joinChannel again.
  ///  If the SDK is forbidden to join the channel due to the server using RESTful API, the app receives onConnectionStateChanged.
  @JsonValue(5)
  connectionStateFailed,
}

/// @nodoc
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

/// Settings for each host involved in transcoding and mixing.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TranscodingUser implements AgoraSerializable {
  /// @nodoc
  const TranscodingUser(
      {this.uid,
      this.x,
      this.y,
      this.width,
      this.height,
      this.zOrder,
      this.alpha,
      this.audioChannel});

  /// User ID of the host.
  @JsonKey(name: 'uid')
  final int? uid;

  /// X-coordinate (px) of the host video in the output video, with the top-left corner of the output video as the origin. Value range: [0, width], where width is set in LiveTranscoding.
  @JsonKey(name: 'x')
  final int? x;

  /// Y-coordinate (px) of the host video in the output video, with the top-left corner of the output video as the origin. Value range: [0, height], where height is set in LiveTranscoding.
  @JsonKey(name: 'y')
  final int? y;

  /// Width of the host video (px).
  @JsonKey(name: 'width')
  final int? width;

  /// Height of the host video (px).
  @JsonKey(name: 'height')
  final int? height;

  /// If the value is less than 0 or greater than 100, an errInvalidArgument error is returned.
  ///  Setting zOrder to 0 is supported. Layer number of the host video. Value range: [0,100].
  ///  0: (Default) Video is at the bottom layer.
  ///  100: Video is at the top layer.
  @JsonKey(name: 'zOrder')
  final int? zOrder;

  /// Transparency of the host video. Value range: [0.0, 1.0].
  ///  0.0: Fully transparent.
  ///  1.0: (Default) Fully opaque.
  @JsonKey(name: 'alpha')
  final double? alpha;

  /// When the value is not 0, a special player is required. Audio channel occupied by the host audio in the output audio. Default is 0. Value range: [0,5]: 0 : (Recommended) Default audio mixing setting, supports up to stereo, related to the host's upstream audio. 1 : Host audio in the FL channel of the output audio. If the host's upstream audio is multi-channel, the Agora server mixes it into mono. 2 : Host audio in the FC channel of the output audio. If the host's upstream audio is multi-channel, the Agora server mixes it into mono. 3 : Host audio in the FR channel of the output audio. If the host's upstream audio is multi-channel, the Agora server mixes it into mono. 4 : Host audio in the BL channel of the output audio. If the host's upstream audio is multi-channel, the Agora server mixes it into mono. 5 : Host audio in the BR channel of the output audio. If the host's upstream audio is multi-channel, the Agora server mixes it into mono. 0xFF or values greater than 5 : The host audio is muted, and the Agora server removes the host's audio.
  @JsonKey(name: 'audioChannel')
  final int? audioChannel;

  /// @nodoc
  factory TranscodingUser.fromJson(Map<String, dynamic> json) =>
      _$TranscodingUserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TranscodingUserToJson(this);
}

/// Transcoding properties for CDN live streaming.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LiveTranscoding implements AgoraSerializable {
  /// @nodoc
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

  /// Total width of the video stream in pixels. Default is 360.
  ///  For video streams, the value range is [64,1920]. If the value is less than 64, it is automatically adjusted to 64 by the Agora server; if it is greater than 1920, it is adjusted to 1920.
  ///  For audio-only streams, set both width and height to 0.
  @JsonKey(name: 'width')
  final int? width;

  /// Total height of the video stream in pixels. Default is 640.
  ///  For video streams, the value range is [64,1080]. If the value is less than 64, it is automatically adjusted to 64 by the Agora server; if it is greater than 1080, it is adjusted to 1080.
  ///  For audio-only streams, set both width and height to 0.
  @JsonKey(name: 'height')
  final int? height;

  /// Video encoding bitrate in Kbps. You do not need to set this parameter. Keep the default value standardBitrate. The SDK automatically matches the most appropriate bitrate based on the video resolution and frame rate you set. For the mapping between resolution and frame rate, see [Video Profile](https://docs.agora.io/en/video-calling/enhance-call-quality/configure-video-encoding).
  @JsonKey(name: 'videoBitrate')
  final int? videoBitrate;

  /// Frame rate of the output video for CDN live streaming. Value range is (0,30], in fps. Default is 15 fps. The Agora server adjusts any value above 30 fps to 30 fps.
  @JsonKey(name: 'videoFramerate')
  final int? videoFramerate;

  /// Deprecated. Not recommended. Low latency mode true : Low latency, video quality not guaranteed. false : (Default) High latency, video quality guaranteed.
  @JsonKey(name: 'lowLatency')
  final bool? lowLatency;

  /// GOP (Group of Pictures) of the output video for CDN live streaming, in frames. Default is 30.
  @JsonKey(name: 'videoGop')
  final int? videoGop;

  /// Encoding profile of the output video for CDN live streaming. Can be set to 66, 77, or 100. See VideoCodecProfileType. If you set this parameter to other values, the Agora server adjusts it to the default value.
  @JsonKey(name: 'videoCodecProfile')
  final VideoCodecProfileType? videoCodecProfile;

  /// Background color of the output video for CDN live streaming, in hexadecimal RGB integer format without the # sign. For example, 0xFFB6C1 represents light pink. Default is 0x000000 (black).
  @JsonKey(name: 'backgroundColor')
  final int? backgroundColor;

  /// Codec type of the output video for CDN live streaming. See VideoCodecTypeForStream.
  @JsonKey(name: 'videoCodecType')
  final VideoCodecTypeForStream? videoCodecType;

  /// Number of users in the video mix. Default is 0. Value range is [0,17].
  @JsonKey(name: 'userCount')
  final int? userCount;

  /// Users participating in video mixing for CDN live streaming. Supports up to 17 users simultaneously. See TranscodingUser.
  @JsonKey(name: 'transcodingUsers')
  final List<TranscodingUser>? transcodingUsers;

  /// Reserved parameter: Custom information sent to the CDN streaming client, used to populate SEI frames in H264/H265 video. Length limit: 4096 bytes.
  @JsonKey(name: 'transcodingExtraInfo')
  final String? transcodingExtraInfo;

  /// Metadata sent to the CDN client. Deprecated. Not recommended.
  @JsonKey(name: 'metadata')
  final String? metadata;

  /// Watermark on the live video. The image format must be PNG. See RtcImage.
  /// You can add one watermark or use an array to add multiple watermarks.
  @JsonKey(name: 'watermark')
  final List<RtcImage>? watermark;

  /// Number of watermarks on the live video. The total number of watermarks and background images must be between 0 and 10. This parameter is used together with watermark.
  @JsonKey(name: 'watermarkCount')
  final int? watermarkCount;

  /// Background image on the live video. The image format must be PNG. See RtcImage.
  /// You can add one background image or use an array to add multiple background images. This parameter is used together with backgroundImageCount.
  @JsonKey(name: 'backgroundImage')
  final List<RtcImage>? backgroundImage;

  /// Number of background images on the live video. The total number of watermarks and background images must be between 0 and 10. This parameter is used together with backgroundImage.
  @JsonKey(name: 'backgroundImageCount')
  final int? backgroundImageCount;

  /// Audio sample rate (Hz) of the output media stream for CDN streaming. See AudioSampleRateType.
  @JsonKey(name: 'audioSampleRate')
  final AudioSampleRateType? audioSampleRate;

  /// Bitrate of the output audio for CDN live streaming, in Kbps. Default is 48, maximum is 128.
  @JsonKey(name: 'audioBitrate')
  final int? audioBitrate;

  /// Number of audio channels in the output audio for CDN live streaming. Default is 1. Acceptable integer values are [1,5]. Recommended values are 1 or 2. Values 3, 4, and 5 require special player support:
  ///  1: (Default) Mono
  ///  2: Stereo
  ///  3: Three channels
  ///  4: Four channels
  ///  5: Five channels
  @JsonKey(name: 'audioChannels')
  final int? audioChannels;

  /// Audio codec profile of the output audio for CDN live streaming. See AudioCodecProfileType.
  @JsonKey(name: 'audioCodecProfile')
  final AudioCodecProfileType? audioCodecProfile;

  /// Advanced features for transcoding and streaming. See LiveStreamAdvancedFeature.
  @JsonKey(name: 'advancedFeatures')
  final List<LiveStreamAdvancedFeature>? advancedFeatures;

  /// Number of enabled advanced features. Default is 0.
  @JsonKey(name: 'advancedFeatureCount')
  final int? advancedFeatureCount;

  /// @nodoc
  factory LiveTranscoding.fromJson(Map<String, dynamic> json) =>
      _$LiveTranscodingFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LiveTranscodingToJson(this);
}

/// Video streams involved in local compositing.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TranscodingVideoStream implements AgoraSerializable {
  /// @nodoc
  const TranscodingVideoStream(
      {this.sourceType,
      this.remoteUserUid,
      this.imageUrl,
      this.mediaPlayerId,
      this.x,
      this.y,
      this.width,
      this.height,
      this.zOrder,
      this.alpha,
      this.mirror});

  /// Type of video source involved in local compositing. See VideoSourceType.
  @JsonKey(name: 'sourceType')
  final VideoSourceType? sourceType;

  /// Remote user ID. Use this parameter only when the video source type for local compositing is videoSourceRemote.
  @JsonKey(name: 'remoteUserUid')
  final int? remoteUserUid;

  /// Use this parameter only when the video source type for local compositing is an image. Path to the local image. Example paths:
  ///  Android: /storage/emulated/0/Pictures/image.png
  ///  iOS: /var/mobile/Containers/Data/Application/<APP-UUID>/Documents/image.png
  ///  macOS: ~/Pictures/image.png
  ///  Windows: C:\\Users\\{username}\\Pictures\\image.png
  @JsonKey(name: 'imageUrl')
  final String? imageUrl;

  /// (Optional) Media player ID. Set this parameter when sourceType is set to videoSourceMediaPlayer.
  @JsonKey(name: 'mediaPlayerId')
  final int? mediaPlayerId;

  /// Horizontal offset of the top-left corner of the video relative to the top-left corner (origin) of the canvas.
  @JsonKey(name: 'x')
  final int? x;

  /// Vertical offset of the top-left corner of the video relative to the top-left corner (origin) of the canvas.
  @JsonKey(name: 'y')
  final int? y;

  /// Width of the video involved in local compositing (px).
  @JsonKey(name: 'width')
  final int? width;

  /// Height of the video involved in local compositing (px).
  @JsonKey(name: 'height')
  final int? height;

  /// Layer number of the video involved in local compositing. Value range: [0,100].
  ///  0: (Default) Bottom layer.
  ///  100: Top layer.
  @JsonKey(name: 'zOrder')
  final int? zOrder;

  /// Transparency of the video involved in local compositing. Value range: [0.0,1.0]. 0.0 means fully transparent, 1.0 means fully opaque.
  @JsonKey(name: 'alpha')
  final double? alpha;

  /// This parameter takes effect only for video sources from the camera. Whether to mirror the video involved in local compositing: true : Mirror the video. false : (Default) Do not mirror the video.
  @JsonKey(name: 'mirror')
  final bool? mirror;

  /// @nodoc
  factory TranscodingVideoStream.fromJson(Map<String, dynamic> json) =>
      _$TranscodingVideoStreamFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TranscodingVideoStreamToJson(this);
}

/// Local video compositing configuration.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LocalTranscoderConfiguration implements AgoraSerializable {
  /// @nodoc
  const LocalTranscoderConfiguration(
      {this.streamCount,
      this.videoInputStreams,
      this.videoOutputConfiguration,
      this.syncWithPrimaryCamera});

  /// Number of video streams participating in local video compositing.
  @JsonKey(name: 'streamCount')
  final int? streamCount;

  /// Video streams participating in local video compositing. See TranscodingVideoStream.
  @JsonKey(name: 'videoInputStreams')
  final List<TranscodingVideoStream>? videoInputStreams;

  /// Encoding configuration of the composited video after local video compositing. See VideoEncoderConfiguration.
  @JsonKey(name: 'videoOutputConfiguration')
  final VideoEncoderConfiguration? videoOutputConfiguration;

  /// @nodoc
  @JsonKey(name: 'syncWithPrimaryCamera')
  final bool? syncWithPrimaryCamera;

  /// @nodoc
  factory LocalTranscoderConfiguration.fromJson(Map<String, dynamic> json) =>
      _$LocalTranscoderConfigurationFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LocalTranscoderConfigurationToJson(this);
}

/// Local video mixing error codes.
@JsonEnum(alwaysCreate: true)
enum VideoTranscoderError {
  /// 1: The specified video source has not started video capture. You need to create a video track for it and start video capture.
  @JsonValue(1)
  vtErrVideoSourceNotReady,

  /// 2: Invalid video source type. You need to reassign a supported video source type.
  @JsonValue(2)
  vtErrInvalidVideoSourceType,

  /// 3: Invalid image path. You need to reassign the correct image path.
  @JsonValue(3)
  vtErrInvalidImagePath,

  /// 4: Invalid image format. Ensure the image format is one of PNG, JPEG, or GIF.
  @JsonValue(4)
  vtErrUnsupportImageFormat,

  /// 5: Invalid resolution for the encoded video after mixing.
  @JsonValue(5)
  vtErrInvalidLayout,

  /// 20: Internal unknown error.
  @JsonValue(20)
  vtErrInternal,
}

/// @nodoc
extension VideoTranscoderErrorExt on VideoTranscoderError {
  /// @nodoc
  static VideoTranscoderError fromValue(int value) {
    return $enumDecode(_$VideoTranscoderErrorEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$VideoTranscoderErrorEnumMap[this]!;
  }
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MixedAudioStream implements AgoraSerializable {
  /// @nodoc
  const MixedAudioStream(
      {this.sourceType, this.remoteUserUid, this.channelId, this.trackId});

  /// @nodoc
  @JsonKey(name: 'sourceType')
  final AudioSourceType? sourceType;

  /// @nodoc
  @JsonKey(name: 'remoteUserUid')
  final int? remoteUserUid;

  /// @nodoc
  @JsonKey(name: 'channelId')
  final String? channelId;

  /// @nodoc
  @JsonKey(name: 'trackId')
  final int? trackId;

  /// @nodoc
  factory MixedAudioStream.fromJson(Map<String, dynamic> json) =>
      _$MixedAudioStreamFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MixedAudioStreamToJson(this);
}

/// Local audio mixing configuration.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LocalAudioMixerConfiguration implements AgoraSerializable {
  /// @nodoc
  const LocalAudioMixerConfiguration(
      {this.streamCount, this.audioInputStreams, this.syncWithLocalMic});

  /// Number of audio streams to be mixed locally.
  @JsonKey(name: 'streamCount')
  final int? streamCount;

  /// Audio sources to be mixed locally. See MixedAudioStream.
  @JsonKey(name: 'audioInputStreams')
  final List<MixedAudioStream>? audioInputStreams;

  /// Whether the mixed audio stream uses timestamps from the local microphone audio frames: true : (default) Uses timestamps from the local microphone audio frames. Set this value if you want all locally captured audio streams to stay synchronized. false : Does not use timestamps from the local microphone audio frames. The SDK uses the timestamp when the mixed audio frame is constructed.
  @JsonKey(name: 'syncWithLocalMic')
  final bool? syncWithLocalMic;

  /// @nodoc
  factory LocalAudioMixerConfiguration.fromJson(Map<String, dynamic> json) =>
      _$LocalAudioMixerConfigurationFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LocalAudioMixerConfigurationToJson(this);
}

/// Last mile network probe configuration.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LastmileProbeConfig implements AgoraSerializable {
  /// @nodoc
  const LastmileProbeConfig(
      {this.probeUplink,
      this.probeDownlink,
      this.expectedUplinkBitrate,
      this.expectedDownlinkBitrate});

  /// Whether to probe the uplink network. Some users, such as audience members in a live broadcast channel, do not need network probing: true : Probe the uplink network. false : Do not probe the uplink network.
  @JsonKey(name: 'probeUplink')
  final bool? probeUplink;

  /// Whether to probe the downlink network: true : Probe the downlink network. false : Do not probe the downlink network.
  @JsonKey(name: 'probeDownlink')
  final bool? probeDownlink;

  /// Expected maximum uplink bitrate in bps. Range: [100000,5000000]. It is recommended to refer to the bitrate value in setVideoEncoderConfiguration when setting this parameter.
  @JsonKey(name: 'expectedUplinkBitrate')
  final int? expectedUplinkBitrate;

  /// Expected maximum downlink bitrate in bps. Range: [100000,5000000].
  @JsonKey(name: 'expectedDownlinkBitrate')
  final int? expectedDownlinkBitrate;

  /// @nodoc
  factory LastmileProbeConfig.fromJson(Map<String, dynamic> json) =>
      _$LastmileProbeConfigFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LastmileProbeConfigToJson(this);
}

/// Status of last mile quality probe result.
@JsonEnum(alwaysCreate: true)
enum LastmileProbeResultState {
  /// 1: Indicates that the last mile probe result is complete.
  @JsonValue(1)
  lastmileProbeResultComplete,

  /// 2: Indicates that the last mile probe did not perform bandwidth estimation, so the result is incomplete. A possible reason is temporarily limited testing resources.
  @JsonValue(2)
  lastmileProbeResultIncompleteNoBwe,

  /// 3: Last mile probe was not performed. A possible reason is network disconnection.
  @JsonValue(3)
  lastmileProbeResultUnavailable,
}

/// @nodoc
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

/// Uplink or downlink last mile network probe result.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LastmileProbeOneWayResult implements AgoraSerializable {
  /// @nodoc
  const LastmileProbeOneWayResult(
      {this.packetLossRate, this.jitter, this.availableBandwidth});

  /// Packet loss rate.
  @JsonKey(name: 'packetLossRate')
  final int? packetLossRate;

  /// Network jitter (ms).
  @JsonKey(name: 'jitter')
  final int? jitter;

  /// Estimated available network bandwidth (bps).
  @JsonKey(name: 'availableBandwidth')
  final int? availableBandwidth;

  /// @nodoc
  factory LastmileProbeOneWayResult.fromJson(Map<String, dynamic> json) =>
      _$LastmileProbeOneWayResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LastmileProbeOneWayResultToJson(this);
}

/// Last mile uplink and downlink network quality probe result.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LastmileProbeResult implements AgoraSerializable {
  /// @nodoc
  const LastmileProbeResult(
      {this.state, this.uplinkReport, this.downlinkReport, this.rtt});

  /// The status of the last mile quality probe result. See: LastmileProbeResultState.
  @JsonKey(name: 'state')
  final LastmileProbeResultState? state;

  /// Uplink network quality report. See LastmileProbeOneWayResult.
  @JsonKey(name: 'uplinkReport')
  final LastmileProbeOneWayResult? uplinkReport;

  /// Downlink network quality report. See LastmileProbeOneWayResult.
  @JsonKey(name: 'downlinkReport')
  final LastmileProbeOneWayResult? downlinkReport;

  /// Round-trip time (ms).
  @JsonKey(name: 'rtt')
  final int? rtt;

  /// @nodoc
  factory LastmileProbeResult.fromJson(Map<String, dynamic> json) =>
      _$LastmileProbeResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LastmileProbeResultToJson(this);
}

/// Reason for changes in network connection state.
@JsonEnum(alwaysCreate: true)
enum ConnectionChangedReasonType {
  /// 0: Connecting to the network.
  @JsonValue(0)
  connectionChangedConnecting,

  /// 1: Successfully joined the channel.
  @JsonValue(1)
  connectionChangedJoinSuccess,

  /// 2: Network connection interrupted.
  @JsonValue(2)
  connectionChangedInterrupted,

  /// 3: Network connection is banned by the server. For example, this status is returned when a user is kicked out of the channel.
  @JsonValue(3)
  connectionChangedBannedByServer,

  /// 4: Failed to join the channel. If the SDK fails to join the channel after trying for 20 minutes, this status is returned and it stops trying to reconnect. Prompt the user to switch networks and try joining the channel again.
  @JsonValue(4)
  connectionChangedJoinFailed,

  /// 5: Left the channel.
  @JsonValue(5)
  connectionChangedLeaveChannel,

  /// 6: Invalid App ID. Use a valid App ID to rejoin the channel and ensure the App ID matches the one generated in the Agora Console.
  @JsonValue(6)
  connectionChangedInvalidAppId,

  /// 7: Invalid channel name. Use a valid channel name to rejoin the channel. A valid channel name is a string within 64 bytes. The supported character set includes 89 characters:
  @JsonValue(7)
  connectionChangedInvalidChannelName,

  /// 8: Invalid Token. Possible reasons include:
  ///  Your project has enabled App Certificate, but you joined the channel without using a Token.
  ///  The user ID specified when calling joinChannel does not match the one used when generating the Token.
  ///  The Token used to join the channel is different from the one generated. Ensure that:
  ///  When your project has enabled App Certificate, use a Token to join the channel.
  ///  The user ID specified when generating the Token matches the one used to join the channel.
  ///  The Token used to join the channel matches the one generated.
  @JsonValue(8)
  connectionChangedInvalidToken,

  /// 9: The current Token has expired. Generate a new Token on your server and use it to rejoin the channel.
  @JsonValue(9)
  connectionChangedTokenExpired,

  /// 10: This user is banned by the server. Possible reasons include:
  ///  The user has already joined the channel and calls the join API again, such as joinChannel, which returns this status. Stop calling the method.
  ///  The user tries to join a channel during a call test. Wait until the test ends before joining the channel.
  @JsonValue(10)
  connectionChangedRejectedByServer,

  /// 11: SDK attempts to reconnect due to proxy server settings.
  @JsonValue(11)
  connectionChangedSettingProxyServer,

  /// 12: Network connection state changed due to Token renewal.
  @JsonValue(12)
  connectionChangedRenewToken,

  /// 13: Client IP address changed. If this status occurs multiple times, prompt the user to switch networks and try rejoining the channel.
  @JsonValue(13)
  connectionChangedClientIpAddressChanged,

  /// 14: Keep-alive timeout between SDK and server, entering auto-reconnect state.
  @JsonValue(14)
  connectionChangedKeepAliveTimeout,

  /// 15: Successfully rejoined the channel.
  @JsonValue(15)
  connectionChangedRejoinSuccess,

  /// 16: SDK lost connection with the server.
  @JsonValue(16)
  connectionChangedLost,

  /// 17: Connection state changed due to echo test.
  @JsonValue(17)
  connectionChangedEchoTest,

  /// 18: Local IP address changed by user.
  @JsonValue(18)
  connectionChangedClientIpAddressChangedByUser,

  /// 19: Joined the same channel from different devices using the same UID.
  @JsonValue(19)
  connectionChangedSameUidLogin,

  /// 20: The number of broadcasters in the channel has reached the limit.
  @JsonValue(20)
  connectionChangedTooManyBroadcasters,

  /// @nodoc
  @JsonValue(21)
  connectionChangedLicenseValidationFailure,

  /// @nodoc
  @JsonValue(22)
  connectionChangedCertificationVeryfyFailure,

  /// @nodoc
  @JsonValue(23)
  connectionChangedStreamChannelNotAvailable,

  /// @nodoc
  @JsonValue(24)
  connectionChangedInconsistentAppid,
}

/// @nodoc
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

/// Reason for failing to switch user roles.
@JsonEnum(alwaysCreate: true)
enum ClientRoleChangeFailedReason {
  /// 1: The number of broadcasters in the channel has reached the limit. This enum is only reported when the 128-user feature is enabled. The broadcaster limit depends on the actual number configured when enabling the 128-user feature.
  @JsonValue(1)
  clientRoleChangeFailedTooManyBroadcasters,

  /// 2: The request is rejected by the server. It is recommended to prompt the user to try switching roles again.
  @JsonValue(2)
  clientRoleChangeFailedNotAuthorized,

  /// 3: The request timed out. It is recommended to prompt the user to check the network connection and try switching roles again. Deprecated: This enum value is deprecated as of v4.4.0 and is not recommended for use.
  @JsonValue(3)
  clientRoleChangeFailedRequestTimeOut,

  /// 4: Network connection lost. You can troubleshoot the specific cause of the network failure based on the reason reported by onConnectionStateChanged. Deprecated: This enum value is deprecated as of v4.4.0 and is not recommended for use.
  @JsonValue(4)
  clientRoleChangeFailedConnectionFailed,
}

/// @nodoc
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

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum WlaccMessageReason {
  /// @nodoc
  @JsonValue(0)
  wlaccMessageReasonWeakSignal,

  /// @nodoc
  @JsonValue(1)
  wlaccMessageReasonChannelCongestion,
}

/// @nodoc
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

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum WlaccSuggestAction {
  /// @nodoc
  @JsonValue(0)
  wlaccSuggestActionCloseToWifi,

  /// @nodoc
  @JsonValue(1)
  wlaccSuggestActionConnectSsid,

  /// @nodoc
  @JsonValue(2)
  wlaccSuggestActionCheck5g,

  /// @nodoc
  @JsonValue(3)
  wlaccSuggestActionModifySsid,
}

/// @nodoc
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

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class WlAccStats implements AgoraSerializable {
  /// @nodoc
  const WlAccStats(
      {this.e2eDelayPercent, this.frozenRatioPercent, this.lossRatePercent});

  /// @nodoc
  @JsonKey(name: 'e2eDelayPercent')
  final int? e2eDelayPercent;

  /// @nodoc
  @JsonKey(name: 'frozenRatioPercent')
  final int? frozenRatioPercent;

  /// @nodoc
  @JsonKey(name: 'lossRatePercent')
  final int? lossRatePercent;

  /// @nodoc
  factory WlAccStats.fromJson(Map<String, dynamic> json) =>
      _$WlAccStatsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WlAccStatsToJson(this);
}

/// Network connection type.
@JsonEnum(alwaysCreate: true)
enum NetworkType {
  /// -1: Network connection type is unknown.
  @JsonValue(-1)
  networkTypeUnknown,

  /// 0: Network connection is disconnected.
  @JsonValue(0)
  networkTypeDisconnected,

  /// 1: Network type is LAN.
  @JsonValue(1)
  networkTypeLan,

  /// 2: Network type is Wi-Fi (including hotspots).
  @JsonValue(2)
  networkTypeWifi,

  /// 3: Network type is 2G mobile network.
  @JsonValue(3)
  networkTypeMobile2g,

  /// 4: Network type is 3G mobile network.
  @JsonValue(4)
  networkTypeMobile3g,

  /// 5: Network type is 4G mobile network.
  @JsonValue(5)
  networkTypeMobile4g,

  /// 6: Network type is 5G mobile network.
  @JsonValue(6)
  networkTypeMobile5g,
}

/// @nodoc
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

/// View setup mode.
@JsonEnum(alwaysCreate: true)
enum VideoViewSetupMode {
  /// 0: (Default) Clears all added views and replaces with a new view.
  @JsonValue(0)
  videoViewSetupReplace,

  /// 1: Adds a view.
  @JsonValue(1)
  videoViewSetupAdd,

  /// 2: Removes a view. When you no longer need a view, it is recommended to set setupMode to videoViewSetupRemove in time to remove the view, otherwise it may lead to rendering resource leaks.
  @JsonValue(2)
  videoViewSetupRemove,
}

/// @nodoc
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

/// Properties of the video canvas object.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoCanvas implements AgoraSerializable {
  /// @nodoc
  const VideoCanvas(
      {this.uid,
      this.subviewUid,
      this.view,
      this.backgroundColor,
      this.renderMode,
      this.mirrorMode,
      this.setupMode,
      this.sourceType,
      this.mediaPlayerId,
      this.cropArea,
      this.enableAlphaMask,
      this.position});

  /// For Android and iOS platforms, when the video source is a composite video stream (videoSourceTranscoded), this parameter indicates the user ID that publishes the composite video stream.
  @JsonKey(name: 'uid')
  final int? uid;

  /// User ID that publishes a specific composite sub-video stream.
  @JsonKey(name: 'subviewUid')
  final int? subviewUid;

  /// Video display window. In a VideoCanvas, you can only set either view or surfaceTexture. If both are set, only the configuration in view takes effect.
  @JsonKey(name: 'view', readValue: readIntPtr)
  final int? view;

  /// Background color of the video canvas in RGBA format. The default is 0x00000000, which represents black.
  @JsonKey(name: 'backgroundColor')
  final int? backgroundColor;

  /// Video rendering mode. See RenderModeType.
  @JsonKey(name: 'renderMode')
  final RenderModeType? renderMode;

  /// View mirroring mode. See VideoMirrorModeType.
  ///  Local view mirroring mode: If you use the front camera, local view mirroring is enabled by default; if you use the rear camera, it is disabled by default.
  ///  Remote user view mirroring mode: Disabled by default.
  @JsonKey(name: 'mirrorMode')
  final VideoMirrorModeType? mirrorMode;

  /// View setup mode. See VideoViewSetupMode.
  @JsonKey(name: 'setupMode')
  final VideoViewSetupMode? setupMode;

  /// Type of video source. See VideoSourceType.
  @JsonKey(name: 'sourceType')
  final VideoSourceType? sourceType;

  /// Media player ID. You can get it through getMediaPlayerId.
  @JsonKey(name: 'mediaPlayerId')
  final int? mediaPlayerId;

  /// (Optional) Display area of the video frame. See Rectangle. width and height represent the pixel width and height of the video in this area. The default is null (width or height is 0), which means the actual resolution of the video frame is displayed.
  @JsonKey(name: 'cropArea')
  final Rectangle? cropArea;

  /// The receiver can only render alpha channel information when the sender enables the alpha transmission feature.
  ///  To enable alpha transmission, please [contact technical support](https://www.agora.io/cn/contact/). (Optional) Whether to enable alpha mask rendering: true : Enable alpha mask rendering. false : (Default) Disable alpha mask rendering. Alpha mask rendering can create images with transparency effects and extract portraits from videos. When used with other methods, it can achieve effects such as portrait picture-in-picture or watermark overlays.
  @JsonKey(name: 'enableAlphaMask')
  final bool? enableAlphaMask;

  /// Position of the video frame in the video pipeline. See VideoModulePosition.
  @JsonKey(name: 'position')
  final VideoModulePosition? position;

  /// @nodoc
  factory VideoCanvas.fromJson(Map<String, dynamic> json) =>
      _$VideoCanvasFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$VideoCanvasToJson(this);
}

/// Beauty effect options.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class BeautyOptions implements AgoraSerializable {
  /// @nodoc
  const BeautyOptions(
      {this.lighteningContrastLevel,
      this.lighteningLevel,
      this.smoothnessLevel,
      this.rednessLevel,
      this.sharpnessLevel});

  /// Contrast level, usually used together with lighteningLevel. The higher the value, the greater the contrast. See LighteningContrastLevel.
  @JsonKey(name: 'lighteningContrastLevel')
  final LighteningContrastLevel? lighteningContrastLevel;

  /// Whitening level, range is [0.0, 1.0], where 0.0 means original brightness. Default is 0.0. The higher the value, the higher the whitening level.
  @JsonKey(name: 'lighteningLevel')
  final double? lighteningLevel;

  /// Smoothing level, range is [0.0, 1.0], where 0.0 means original smoothness. Default is 0.0. The higher the value, the more smoothing is applied.
  @JsonKey(name: 'smoothnessLevel')
  final double? smoothnessLevel;

  /// Redness level, range is [0.0, 1.0], where 0.0 means original redness. Default is 0.0. The higher the value, the more redness is applied.
  @JsonKey(name: 'rednessLevel')
  final double? rednessLevel;

  /// Sharpness level, range is [0.0, 1.0], where 0.0 means original sharpness. Default is 0.0. The higher the value, the more sharpening is applied.
  @JsonKey(name: 'sharpnessLevel')
  final double? sharpnessLevel;

  /// @nodoc
  factory BeautyOptions.fromJson(Map<String, dynamic> json) =>
      _$BeautyOptionsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BeautyOptionsToJson(this);
}

/// Brightness contrast level.
@JsonEnum(alwaysCreate: true)
enum LighteningContrastLevel {
  /// 0: Low contrast.
  @JsonValue(0)
  lighteningContrastLow,

  /// 1: Normal contrast.
  @JsonValue(1)
  lighteningContrastNormal,

  /// 2: High contrast.
  @JsonValue(2)
  lighteningContrastHigh,
}

/// @nodoc
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

/// Filter effect options.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class FaceShapeAreaOptions implements AgoraSerializable {
  /// @nodoc
  const FaceShapeAreaOptions({this.shapeArea, this.shapeIntensity});

  /// Facial area. See FaceShapeArea.
  @JsonKey(name: 'shapeArea')
  final FaceShapeArea? shapeArea;

  /// Modification intensity. The definition of modification intensity (including direction, range, default value, etc.) varies by area. See FaceShapeArea.
  @JsonKey(name: 'shapeIntensity')
  final int? shapeIntensity;

  /// @nodoc
  factory FaceShapeAreaOptions.fromJson(Map<String, dynamic> json) =>
      _$FaceShapeAreaOptionsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FaceShapeAreaOptionsToJson(this);
}

/// Selects the specific facial area to adjust.
///
/// Since Available since v4.4.0.
@JsonEnum(alwaysCreate: true)
enum FaceShapeArea {
  /// (-1): Default value, indicates an invalid area. The face shaping effect is not applied.
  @JsonValue(-1)
  faceShapeAreaNone,

  /// (100): Head area, used to achieve a smaller head effect. Value range is [0, 100], default is 50. The larger the value, the more noticeable the adjustment.
  @JsonValue(100)
  faceShapeAreaHeadscale,

  /// (101): Forehead area, used to adjust the hairline height. Value range is [0, 100], default is 0. The larger the value, the more noticeable the adjustment.
  @JsonValue(101)
  faceShapeAreaForehead,

  /// (102): Face contour area, used to achieve a slimmer face effect. Value range is [0, 100], default is 0. The larger the value, the more noticeable the adjustment.
  @JsonValue(102)
  faceShapeAreaFacecontour,

  /// (103): Face length area, used to elongate the face. Value range is [-100, 100], default is 0. The greater the absolute value, the more noticeable the adjustment; negative values indicate the opposite direction.
  @JsonValue(103)
  faceShapeAreaFacelength,

  /// (104): Face width area, used to achieve a narrower face effect. Value range is [0, 100], default is 0. The larger the value, the more noticeable the adjustment.
  @JsonValue(104)
  faceShapeAreaFacewidth,

  /// (105): Cheekbone area, used to adjust cheekbone width. Value range is [0, 100], default is 0. The larger the value, the more noticeable the adjustment.
  @JsonValue(105)
  faceShapeAreaCheekbone,

  /// (106): Cheek area, used to adjust cheek width. Value range is [0, 100], default is 0. The larger the value, the more noticeable the adjustment.
  @JsonValue(106)
  faceShapeAreaCheek,

  /// (107): Jawbone area, used to adjust jawbone width. Value range is [0, 100], default is 0. The larger the value, the more noticeable the adjustment.
  @JsonValue(107)
  faceShapeAreaMandible,

  /// (108): Chin area, used to adjust chin length. Value range is [-100, 100], default is 0. The greater the absolute value, the more noticeable the adjustment; negative values indicate the opposite direction.
  @JsonValue(108)
  faceShapeAreaChin,

  /// (200): Eye area, used to achieve a bigger eye effect. Value range is [0, 100], default is 50. The larger the value, the more noticeable the adjustment.
  @JsonValue(200)
  faceShapeAreaEyescale,

  /// (201): Eye distance area, used to adjust the distance between the eyes. Value range is [-100, 100], default is 0. The greater the absolute value, the more noticeable the adjustment; negative values indicate the opposite direction.
  @JsonValue(201)
  faceShapeAreaEyedistance,

  /// (202): Eye position area, used to adjust the overall position of the eyes. Value range is [-100, 100], default is 0. The greater the absolute value, the more noticeable the adjustment; negative values indicate the opposite direction.
  @JsonValue(202)
  faceShapeAreaEyeposition,

  /// (203): Lower eyelid area, used to adjust the shape of the lower eyelid. Value range is [0, 100], default is 0. The larger the value, the more noticeable the adjustment.
  @JsonValue(203)
  faceShapeAreaLowereyelid,

  /// (204): Pupil area, used to adjust pupil size. Value range is [0, 100], default is 0. The larger the value, the more noticeable the adjustment.
  @JsonValue(204)
  faceShapeAreaEyepupils,

  /// (205): Inner eye corner area, used to adjust the shape of the inner eye corner. Value range is [-100, 100], default is 0. The greater the absolute value, the more noticeable the adjustment; negative values indicate the opposite direction.
  @JsonValue(205)
  faceShapeAreaEyeinnercorner,

  /// (206): Outer eye corner area, used to adjust the shape of the outer eye corner. Value range is [-100, 100], default is 0. The greater the absolute value, the more noticeable the adjustment; negative values indicate the opposite direction.
  @JsonValue(206)
  faceShapeAreaEyeoutercorner,

  /// (300): Nose length area, used to elongate the nose. Value range is [-100, 100], default is 0. The greater the absolute value, the more noticeable the adjustment; negative values indicate the opposite direction.
  @JsonValue(300)
  faceShapeAreaNoselength,

  /// (301): Nose width area, used to achieve a slimmer nose effect. Value range is [0, 100], default is 0. The larger the value, the more noticeable the slimming effect.
  @JsonValue(301)
  faceShapeAreaNosewidth,

  /// (302): Alar area, used to adjust the width of the alar. Value range is [0, 100], default is 10. The larger the value, the more noticeable the adjustment.
  @JsonValue(302)
  faceShapeAreaNosewing,

  /// (303): Nasal root area, used to adjust the height of the nasal root. Value range is [0, 100], default is 0. The larger the value, the more noticeable the adjustment.
  @JsonValue(303)
  faceShapeAreaNoseroot,

  /// (304): Nose bridge area, used to adjust the height of the nose bridge. Value range is [0, 100], default is 50. The larger the value, the more noticeable the adjustment.
  @JsonValue(304)
  faceShapeAreaNosebridge,

  /// (305): Nose tip area, used to adjust the shape of the nose tip. Value range is [0, 100], default is 50. The larger the value, the more noticeable the adjustment.
  @JsonValue(305)
  faceShapeAreaNosetip,

  /// (306): Overall nose area, used to adjust the overall nose shape. Value range is [-100, 100], default is 50. The greater the absolute value, the more noticeable the adjustment; negative values indicate the opposite direction.
  @JsonValue(306)
  faceShapeAreaNosegeneral,

  /// (400): Mouth area, used to achieve a larger mouth effect. Value range is [-100, 100], default is 20. The greater the absolute value, the more noticeable the adjustment; negative values indicate the opposite direction.
  @JsonValue(400)
  faceShapeAreaMouthscale,

  /// (401): Mouth position area, used to adjust the overall position of the mouth. Value range is [0, 100], default is 0. The larger the value, the more noticeable the adjustment.
  @JsonValue(401)
  faceShapeAreaMouthposition,

  /// (402): Smile corner area, used to adjust the degree of mouth corner lift. Value range is [0, 1], default is 0. The larger the value, the more noticeable the adjustment.
  @JsonValue(402)
  faceShapeAreaMouthsmile,

  /// (403): Lip shape area, used to adjust the shape of the lips. Value range is [0, 100], default is 0. The larger the value, the more noticeable the adjustment.
  @JsonValue(403)
  faceShapeAreaMouthlip,

  /// (500): Eyebrow position area, used to adjust the overall position of the eyebrows. Value range is [-100, 100], default is 0. The greater the absolute value, the more noticeable the adjustment; negative values indicate the opposite direction.
  @JsonValue(500)
  faceShapeAreaEyebrowposition,

  /// (501): Eyebrow thickness area, used to adjust eyebrow thickness. Value range is [-100, 100], default is 0. The larger the value, the more noticeable the adjustment.
  @JsonValue(501)
  faceShapeAreaEyebrowthickness,
}

/// @nodoc
extension FaceShapeAreaExt on FaceShapeArea {
  /// @nodoc
  static FaceShapeArea fromValue(int value) {
    return $enumDecode(_$FaceShapeAreaEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$FaceShapeAreaEnumMap[this]!;
  }
}

/// Face shaping style options.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class FaceShapeBeautyOptions implements AgoraSerializable {
  /// @nodoc
  const FaceShapeBeautyOptions({this.shapeStyle, this.styleIntensity});

  /// Face shaping style. See FaceShapeBeautyStyle.
  @JsonKey(name: 'shapeStyle')
  final FaceShapeBeautyStyle? shapeStyle;

  /// Face shaping style intensity. Value range is [0,100], with a default value of 0.0, indicating no face shaping effect. The higher the value, the more noticeable the modification.
  @JsonKey(name: 'styleIntensity')
  final int? styleIntensity;

  /// @nodoc
  factory FaceShapeBeautyOptions.fromJson(Map<String, dynamic> json) =>
      _$FaceShapeBeautyOptionsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FaceShapeBeautyOptionsToJson(this);
}

/// Face shaping style makeup effect options.
///
/// Since Available since v4.4.0.
@JsonEnum(alwaysCreate: true)
enum FaceShapeBeautyStyle {
  /// (0): (Default) Female style makeup effect.
  @JsonValue(0)
  faceShapeBeautyStyleFemale,

  /// (1): Male style makeup effect.
  @JsonValue(1)
  faceShapeBeautyStyleMale,

  /// (2): Natural style makeup effect, only minimal adjustments to facial features.
  @JsonValue(2)
  faceShapeBeautyStyleNatural,
}

/// @nodoc
extension FaceShapeBeautyStyleExt on FaceShapeBeautyStyle {
  /// @nodoc
  static FaceShapeBeautyStyle fromValue(int value) {
    return $enumDecode(_$FaceShapeBeautyStyleEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$FaceShapeBeautyStyleEnumMap[this]!;
  }
}

/// Filter effect options.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class FilterEffectOptions implements AgoraSerializable {
  /// @nodoc
  const FilterEffectOptions({this.path, this.strength});

  /// Local absolute path to the 3D cube map file used to implement custom filter effects. The referenced .cube file must strictly follow the Cube LUT (Lookup Table) specification, otherwise the filter effect will not take effect. Below is an example of a .cube file: LUT_3D_SIZE 32
  /// 0.0039215689 0 0.0039215682
  /// 0.0086021447 0.0037950677 0
  /// ...
  /// 0.0728652592 0.0039215689 0
  ///  The first line of the cube map file contains the LUT_3D_SIZE identifier, indicating the size of the 3D lookup table. Currently, only a LUT size of 32 is supported.
  ///  The SDK provides a built-in built_in_whiten_filter.cube file. Passing the absolute path of this file applies a whitening filter effect.
  @JsonKey(name: 'path')
  final String? path;

  /// Filter effect intensity. Value range is [0.0,1.0], where 0.0 indicates no filter effect. Default value is 0.5. The higher the value, the stronger the filter effect.
  @JsonKey(name: 'strength')
  final double? strength;

  /// @nodoc
  factory FilterEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$FilterEffectOptionsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FilterEffectOptionsToJson(this);
}

/// Low light enhancement options.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LowlightEnhanceOptions implements AgoraSerializable {
  /// @nodoc
  const LowlightEnhanceOptions({this.mode, this.level});

  /// Low light enhancement mode. See LowLightEnhanceMode.
  @JsonKey(name: 'mode')
  final LowLightEnhanceMode? mode;

  /// Low light enhancement level. See LowLightEnhanceLevel.
  @JsonKey(name: 'level')
  final LowLightEnhanceLevel? level;

  /// @nodoc
  factory LowlightEnhanceOptions.fromJson(Map<String, dynamic> json) =>
      _$LowlightEnhanceOptionsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LowlightEnhanceOptionsToJson(this);
}

/// Low-light enhancement mode.
@JsonEnum(alwaysCreate: true)
enum LowLightEnhanceMode {
  /// 0: (Default) Auto mode. The SDK automatically enables or disables the low-light enhancement feature based on ambient brightness to provide appropriate fill light and prevent overexposure.
  @JsonValue(0)
  lowLightEnhanceAuto,

  /// 1: Manual mode. You need to manually enable or disable the low-light enhancement feature.
  @JsonValue(1)
  lowLightEnhanceManual,
}

/// @nodoc
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

/// Low-light enhancement level.
@JsonEnum(alwaysCreate: true)
enum LowLightEnhanceLevel {
  /// 0: (Default) High-quality low-light enhancement. Processes video brightness, detail, and noise. Offers moderate performance consumption and processing speed, with optimal overall image quality.
  @JsonValue(0)
  lowLightEnhanceLevelHighQuality,

  /// 1: Performance-prioritized low-light enhancement. Processes video brightness and detail. Consumes less performance and processes faster.
  @JsonValue(1)
  lowLightEnhanceLevelFast,
}

/// @nodoc
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

/// Video denoising options.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoDenoiserOptions implements AgoraSerializable {
  /// @nodoc
  const VideoDenoiserOptions({this.mode, this.level});

  /// Video denoising mode.
  @JsonKey(name: 'mode')
  final VideoDenoiserMode? mode;

  /// Video denoising level.
  @JsonKey(name: 'level')
  final VideoDenoiserLevel? level;

  /// @nodoc
  factory VideoDenoiserOptions.fromJson(Map<String, dynamic> json) =>
      _$VideoDenoiserOptionsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$VideoDenoiserOptionsToJson(this);
}

/// Video denoising mode.
@JsonEnum(alwaysCreate: true)
enum VideoDenoiserMode {
  /// 0: (Default) Auto mode. The SDK automatically enables or disables video denoising based on ambient light brightness.
  @JsonValue(0)
  videoDenoiserAuto,

  /// 1: Manual mode. You need to manually enable or disable video denoising.
  @JsonValue(1)
  videoDenoiserManual,
}

/// @nodoc
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

/// Video denoising level.
@JsonEnum(alwaysCreate: true)
enum VideoDenoiserLevel {
  /// 0: (Default) Video denoising prioritizing image quality. Balances performance consumption and denoising effect. Moderate performance consumption and denoising speed, optimal overall image quality.
  @JsonValue(0)
  videoDenoiserLevelHighQuality,

  /// 1: Video denoising prioritizing performance. Focuses on saving performance at the cost of denoising effect. Lower performance consumption and faster denoising speed. To avoid noticeable trailing effects in processed video, it is recommended to use this setting when the camera is stationary.
  @JsonValue(1)
  videoDenoiserLevelFast,
}

/// @nodoc
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

/// Color enhancement options.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ColorEnhanceOptions implements AgoraSerializable {
  /// @nodoc
  const ColorEnhanceOptions({this.strengthLevel, this.skinProtectLevel});

  /// Color enhancement level. Value range is [0.0, 1.0]. 0.0 means no color enhancement is applied to the video. The higher the value, the stronger the color enhancement. Default is 0.5.
  @JsonKey(name: 'strengthLevel')
  final double? strengthLevel;

  /// Skin tone protection level. Value range is [0.0, 1.0]. 0.0 means no skin tone protection is applied. The higher the value, the stronger the protection. Default is 1.0.
  ///  When the color enhancement level is high, facial skin tones may appear distorted. You need to set the skin tone protection level.
  ///  A higher skin tone protection level slightly reduces the color enhancement effect. Therefore, to achieve the best color enhancement effect, it is recommended that you dynamically adjust strengthLevel and skinProtectLevel to achieve the optimal result.
  @JsonKey(name: 'skinProtectLevel')
  final double? skinProtectLevel;

  /// @nodoc
  factory ColorEnhanceOptions.fromJson(Map<String, dynamic> json) =>
      _$ColorEnhanceOptionsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ColorEnhanceOptionsToJson(this);
}

/// Custom background.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VirtualBackgroundSource implements AgoraSerializable {
  /// @nodoc
  const VirtualBackgroundSource(
      {this.backgroundSourceType, this.color, this.source, this.blurDegree});

  /// Custom background. See backgroundSourceType.
  @JsonKey(name: 'background_source_type')
  final BackgroundSourceType? backgroundSourceType;

  /// Color of the custom background image. The format is a hexadecimal integer defined in RGB, without the # symbol. For example, 0xFFB6C1 represents light pink. The default value is 0xFFFFFF, which represents white. The valid range is [0x000000, 0xffffff]. If the value is invalid, the SDK will replace the original background image with a white background. This parameter takes effect only when the custom background is one of the following types:
  ///  backgroundColor: The background image is a solid color image of the color passed in this parameter.
  ///  backgroundImg: If the image in source has a transparent background, the color passed in this parameter will be used to fill the transparent background.
  @JsonKey(name: 'color')
  final int? color;

  /// The absolute local path of the custom background. Supports PNG, JPG, MP4, AVI, MKV, and FLV formats. If the path is invalid, the SDK will use the original background image or a solid color background specified by color. This parameter takes effect only when the custom background type is backgroundImg or backgroundVideo.
  @JsonKey(name: 'source')
  final String? source;

  /// The blur level of the custom background image. This parameter takes effect only when the custom background type is backgroundBlur.
  @JsonKey(name: 'blur_degree')
  final BackgroundBlurDegree? blurDegree;

  /// @nodoc
  factory VirtualBackgroundSource.fromJson(Map<String, dynamic> json) =>
      _$VirtualBackgroundSourceFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$VirtualBackgroundSourceToJson(this);
}

/// Custom background.
@JsonEnum(alwaysCreate: true)
enum BackgroundSourceType {
  /// 0: Process the background as alpha data without replacement, only segmenting the portrait from the background. After setting this, you can call startLocalVideoTranscoder to achieve a picture-in-picture effect of the portrait.
  @JsonValue(0)
  backgroundNone,

  /// 1: (Default) Background is a solid color.
  @JsonValue(1)
  backgroundColor,

  /// 2: Background is an image in PNG or JPG format.
  @JsonValue(2)
  backgroundImg,

  /// 3: Background is a blurred version of the original.
  @JsonValue(3)
  backgroundBlur,

  /// 4: Background is a local video in formats such as MP4, AVI, MKV, FLV, etc.
  @JsonValue(4)
  backgroundVideo,
}

/// @nodoc
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

/// Degree of background blur for custom background images.
@JsonEnum(alwaysCreate: true)
enum BackgroundBlurDegree {
  /// 1: Low degree of background blur. Users can almost clearly see the background.
  @JsonValue(1)
  blurDegreeLow,

  /// 2: Medium degree of background blur. Users have some difficulty seeing the background clearly.
  @JsonValue(2)
  blurDegreeMedium,

  /// 3: (Default) High degree of background blur. Users can barely see the background.
  @JsonValue(3)
  blurDegreeHigh,
}

/// @nodoc
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

/// Processing properties for background images.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SegmentationProperty implements AgoraSerializable {
  /// @nodoc
  const SegmentationProperty({this.modelType, this.greenCapacity});

  /// Algorithm used for background processing. See SegModelType.
  @JsonKey(name: 'modelType')
  final SegModelType? modelType;

  /// Precision range for recognizing background color in the image. Value range is [0,1], default is 0.5. A larger value means a wider range of solid colors can be recognized. If the value is too large, solid colors within the portrait area or along its edges may also be recognized. You are advised to adjust this parameter dynamically based on the actual effect. This parameter takes effect only when modelType is set to segModelGreen.
  @JsonKey(name: 'greenCapacity')
  final double? greenCapacity;

  /// @nodoc
  factory SegmentationProperty.fromJson(Map<String, dynamic> json) =>
      _$SegmentationPropertyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SegmentationPropertyToJson(this);
}

/// Algorithm for background processing.
@JsonEnum(alwaysCreate: true)
enum SegModelType {
  /// 1: (Default) Background processing algorithm suitable for all scenarios.
  @JsonValue(1)
  segModelAi,

  /// 2: (Green screen only) Background processing algorithm suitable only for green screen backgrounds.
  @JsonValue(2)
  segModelGreen,
}

/// @nodoc
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

/// Types of custom audio capture tracks.
@JsonEnum(alwaysCreate: true)
enum AudioTrackType {
  /// @nodoc
  @JsonValue(-1)
  audioTrackInvalid,

  /// 0: Mixable audio track. Supports mixing with other audio streams (e.g., microphone-captured audio) before local playback or publishing to the channel. Has higher latency compared to non-mixable tracks.
  @JsonValue(0)
  audioTrackMixable,

  /// 1: Non-mixable audio track. Replaces microphone capture and does not support mixing with other audio streams. Has lower latency compared to mixable tracks. If audioTrackDirect is specified, you must set publishMicrophoneTrack in ChannelMediaOptions to false when calling joinChannel, otherwise joining the channel fails and returns error code -2.
  @JsonValue(1)
  audioTrackDirect,
}

/// @nodoc
extension AudioTrackTypeExt on AudioTrackType {
  /// @nodoc
  static AudioTrackType fromValue(int value) {
    return $enumDecode(_$AudioTrackTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$AudioTrackTypeEnumMap[this]!;
  }
}

/// Configuration options for custom audio tracks.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioTrackConfig implements AgoraSerializable {
  /// @nodoc
  const AudioTrackConfig(
      {this.enableLocalPlayback, this.enableAudioProcessing});

  /// Whether to enable local audio playback: true : (Default) Enable local audio playback. false : Disable local audio playback.
  @JsonKey(name: 'enableLocalPlayback')
  final bool? enableLocalPlayback;

  /// This setting only takes effect for custom audio capture tracks of type audioTrackDirect. Whether to enable the audio processing module: true : Enable the audio processing module, including echo cancellation (AEC), noise suppression (ANS), and automatic gain control (AGC). false : (Default) Do not enable the audio processing module.
  @JsonKey(name: 'enableAudioProcessing')
  final bool? enableAudioProcessing;

  /// @nodoc
  factory AudioTrackConfig.fromJson(Map<String, dynamic> json) =>
      _$AudioTrackConfigFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AudioTrackConfigToJson(this);
}

/// Preset voice beautifier options.
@JsonEnum(alwaysCreate: true)
enum VoiceBeautifierPreset {
  /// Original voice, i.e., disables voice beautifier effect.
  @JsonValue(0x00000000)
  voiceBeautifierOff,

  /// Magnetic (male). This setting is only effective for male voices. Do not use it for female voices, or the audio will be distorted.
  @JsonValue(0x01010100)
  chatBeautifierMagnetic,

  /// Fresh (female). This setting is only effective for female voices. Do not use it for male voices, or the audio will be distorted.
  @JsonValue(0x01010200)
  chatBeautifierFresh,

  /// Vibrant (female). This setting is only effective for female voices. Do not use it for male voices, or the audio will be distorted.
  @JsonValue(0x01010300)
  chatBeautifierVitality,

  /// Singing beautifier.
  ///  If you call setVoiceBeautifierPreset (singingBeautifier), you can beautify male voices and add a small-room reverb effect. Do not use it for female voices, or the audio will be distorted.
  ///  If you call setVoiceBeautifierParameters (singingBeautifier, param1, param2), you can beautify male or female voices and add reverb effects.
  @JsonValue(0x01020100)
  singingBeautifier,

  /// Vigorous.
  @JsonValue(0x01030100)
  timbreTransformationVigorous,

  /// Deep.
  @JsonValue(0x01030200)
  timbreTransformationDeep,

  /// Mellow.
  @JsonValue(0x01030300)
  timbreTransformationMellow,

  /// Falsetto.
  @JsonValue(0x01030400)
  timbreTransformationFalsetto,

  /// Full.
  @JsonValue(0x01030500)
  timbreTransformationFull,

  /// Clear.
  @JsonValue(0x01030600)
  timbreTransformationClear,

  /// Resounding.
  @JsonValue(0x01030700)
  timbreTransformationResounding,

  /// Ringing.
  @JsonValue(0x01030800)
  timbreTransformationRinging,

  /// Ultra-high audio quality, which makes audio clearer and more detailed.
  ///  For better results, it is recommended to set the profile parameter of setAudioProfile2 to audioProfileMusicHighQuality (4) or audioProfileMusicHighQualityStereo (5), and the scenario parameter to audioScenarioGameStreaming (3), before calling setVoiceBeautifierPreset.
  ///  If the user's audio capture device can highly reproduce audio details, it is recommended not to enable ultra-high audio quality, as the SDK may over-enhance the details and fail to achieve the desired effect.
  @JsonValue(0x01040100)
  ultraHighQualityVoice,
}

/// @nodoc
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

/// Preset audio effect options.
///
/// setAudioProfile profile
/// Preset audio effects profile
///  roomAcousticsVirtualStereo
///  roomAcoustics3dVoice
///  roomAcousticsVirtualSurroundSound audioProfileMusicHighQualityStereo or audioProfileMusicStandardStereo Other preset audio effects (excluding audioEffectOff) audioProfileMusicHighQuality or audioProfileMusicHighQualityStereo
@JsonEnum(alwaysCreate: true)
enum AudioEffectPreset {
  /// Original sound, i.e., disables voice effects.
  @JsonValue(0x00000000)
  audioEffectOff,

  /// KTV.
  @JsonValue(0x02010100)
  roomAcousticsKtv,

  /// Concert.
  @JsonValue(0x02010200)
  roomAcousticsVocalConcert,

  /// Studio.
  @JsonValue(0x02010300)
  roomAcousticsStudio,

  /// Phonograph.
  @JsonValue(0x02010400)
  roomAcousticsPhonograph,

  /// Virtual stereo, where the SDK renders mono audio into stereo sound.
  @JsonValue(0x02010500)
  roomAcousticsVirtualStereo,

  /// Spacious.
  @JsonValue(0x02010600)
  roomAcousticsSpacial,

  /// Ethereal.
  @JsonValue(0x02010700)
  roomAcousticsEthereal,

  /// 3D voice, where the SDK renders audio to surround the user. The surround cycle defaults to 10 seconds. After setting this effect, you can also call setAudioEffectParameters to modify the surround cycle. To experience the expected effect of 3D voice, users need to use audio playback devices that support stereo.
  @JsonValue(0x02010800)
  roomAcoustics3dVoice,

  /// Virtual surround sound, where the SDK simulates surround sound based on stereo channels to create an immersive effect. To experience the expected effect of virtual surround sound, users need to use audio playback devices that support stereo.
  @JsonValue(0x02010900)
  roomAcousticsVirtualSurroundSound,

  /// Chorus. Agora recommends using this in chorus scenarios to make vocals sound more spatial and three-dimensional.
  @JsonValue(0x02010D00)
  roomAcousticsChorus,

  /// Deep male voice. Recommended for processing male voices; otherwise, the effect may not be as expected.
  @JsonValue(0x02020100)
  voiceChangerEffectUncle,

  /// Elderly male. Recommended for processing male voices; otherwise, the effect may not be as expected.
  @JsonValue(0x02020200)
  voiceChangerEffectOldman,

  /// Boy. Recommended for processing male voices; otherwise, the effect may not be as expected.
  @JsonValue(0x02020300)
  voiceChangerEffectBoy,

  /// Young woman. Recommended for processing female voices; otherwise, the effect may not be as expected.
  @JsonValue(0x02020400)
  voiceChangerEffectSister,

  /// Girl. Recommended for processing female voices; otherwise, the effect may not be as expected.
  @JsonValue(0x02020500)
  voiceChangerEffectGirl,

  /// Pigsy.
  @JsonValue(0x02020600)
  voiceChangerEffectPigking,

  /// Hulk.
  @JsonValue(0x02020700)
  voiceChangerEffectHulk,

  /// R&B.
  @JsonValue(0x02030100)
  styleTransformationRnb,

  /// Pop.
  @JsonValue(0x02030200)
  styleTransformationPopular,

  /// Electronic voice, where the SDK corrects the pitch based on the natural major scale with C as the tonic. After setting this effect, you can also call setAudioEffectParameters to adjust the base scale and tonic pitch.
  @JsonValue(0x02040100)
  pitchCorrection,
}

/// @nodoc
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

/// Preset voice conversion options.
@JsonEnum(alwaysCreate: true)
enum VoiceConversionPreset {
  /// Original voice, i.e., disables voice conversion effect.
  @JsonValue(0x00000000)
  voiceConversionOff,

  /// Neutral. To avoid audio distortion, make sure to apply this effect only to female voices.
  @JsonValue(0x03010100)
  voiceChangerNeutral,

  /// Sweet. To avoid audio distortion, make sure to apply this effect only to female voices.
  @JsonValue(0x03010200)
  voiceChangerSweet,

  /// Steady. To avoid audio distortion, make sure to apply this effect only to male voices.
  @JsonValue(0x03010300)
  voiceChangerSolid,

  /// Deep. To avoid audio distortion, make sure to apply this effect only to male voices.
  @JsonValue(0x03010400)
  voiceChangerBass,

  /// @nodoc
  @JsonValue(0x03010500)
  voiceChangerCartoon,

  /// @nodoc
  @JsonValue(0x03010600)
  voiceChangerChildlike,

  /// @nodoc
  @JsonValue(0x03010700)
  voiceChangerPhoneOperator,

  /// @nodoc
  @JsonValue(0x03010800)
  voiceChangerMonster,

  /// @nodoc
  @JsonValue(0x03010900)
  voiceChangerTransformers,

  /// @nodoc
  @JsonValue(0x03010A00)
  voiceChangerGroot,

  /// @nodoc
  @JsonValue(0x03010B00)
  voiceChangerDarthVader,

  /// @nodoc
  @JsonValue(0x03010C00)
  voiceChangerIronLady,

  /// @nodoc
  @JsonValue(0x03010D00)
  voiceChangerShinChan,

  /// @nodoc
  @JsonValue(0x03010E00)
  voiceChangerGirlishMan,

  /// @nodoc
  @JsonValue(0x03010F00)
  voiceChangerChipmunk,
}

/// @nodoc
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

/// Preset headphone equalizer types.
@JsonEnum(alwaysCreate: true)
enum HeadphoneEqualizerPreset {
  /// Turn off headphone equalizer and listen to original audio.
  @JsonValue(0x00000000)
  headphoneEqualizerOff,

  /// Use over-ear headphone equalizer.
  @JsonValue(0x04000001)
  headphoneEqualizerOverear,

  /// Use in-ear headphone equalizer.
  @JsonValue(0x04000002)
  headphoneEqualizerInear,
}

/// @nodoc
extension HeadphoneEqualizerPresetExt on HeadphoneEqualizerPreset {
  /// @nodoc
  static HeadphoneEqualizerPreset fromValue(int value) {
    return $enumDecode(_$HeadphoneEqualizerPresetEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$HeadphoneEqualizerPresetEnumMap[this]!;
  }
}

/// AI tuner voice effect types.
@JsonEnum(alwaysCreate: true)
enum VoiceAiTunerType {
  /// 0: Mature male voice. A deep and magnetic male voice.
  @JsonValue(0)
  voiceAiTunerMatureMale,

  /// 1: Fresh male voice. A fresh and slightly sweet male voice.
  @JsonValue(1)
  voiceAiTunerFreshMale,

  /// 2: Elegant female voice. A deep and charming female voice.
  @JsonValue(2)
  voiceAiTunerElegantFemale,

  /// 3: Sweet girl voice. A high-pitched and cute female voice.
  @JsonValue(3)
  voiceAiTunerSweetFemale,

  /// 4: Warm male singing voice. A warm and melodious male voice.
  @JsonValue(4)
  voiceAiTunerWarmMaleSinging,

  /// 5: Gentle female singing voice. A soft and delicate female voice.
  @JsonValue(5)
  voiceAiTunerGentleFemaleSinging,

  /// 6: Husky male singing voice. A unique hoarse male voice.
  @JsonValue(6)
  voiceAiTunerHuskyMaleSinging,

  /// 7: Warm elegant female singing voice. A warm and mature female voice.
  @JsonValue(7)
  voiceAiTunerWarmElegantFemaleSinging,

  /// 8: Powerful male singing voice. A strong and forceful male voice.
  @JsonValue(8)
  voiceAiTunerPowerfulMaleSinging,

  /// 9: Dreamy female singing voice. A dreamy and soft female voice.
  @JsonValue(9)
  voiceAiTunerDreamyFemaleSinging,
}

/// @nodoc
extension VoiceAiTunerTypeExt on VoiceAiTunerType {
  /// @nodoc
  static VoiceAiTunerType fromValue(int value) {
    return $enumDecode(_$VoiceAiTunerTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$VoiceAiTunerTypeEnumMap[this]!;
  }
}

/// Audio configuration for screen sharing stream.
///
/// (flutter only) Only applicable when captureAudio is set to true.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ScreenAudioParameters implements AgoraSerializable {
  /// @nodoc
  const ScreenAudioParameters(
      {this.sampleRate,
      this.channels,
      this.captureSignalVolume,
      this.excludeCurrentProcessAudio});

  /// Audio sampling rate (Hz). Default is 16000.
  @JsonKey(name: 'sampleRate')
  final int? sampleRate;

  /// Number of audio channels. Default is 2, which means stereo.
  @JsonKey(name: 'channels')
  final int? channels;

  /// Captured system volume. Value range is [0,100]. Default is 100.
  @JsonKey(name: 'captureSignalVolume')
  final int? captureSignalVolume;

  /// @nodoc
  @JsonKey(name: 'excludeCurrentProcessAudio')
  final bool? excludeCurrentProcessAudio;

  /// @nodoc
  factory ScreenAudioParameters.fromJson(Map<String, dynamic> json) =>
      _$ScreenAudioParametersFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ScreenAudioParametersToJson(this);
}

/// Parameter configuration for screen sharing.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ScreenCaptureParameters implements AgoraSerializable {
  /// @nodoc
  const ScreenCaptureParameters(
      {this.captureAudio,
      this.audioParams,
      this.dimensions,
      this.frameRate,
      this.bitrate,
      this.captureMouseCursor,
      this.windowFocus,
      this.excludeWindowList,
      this.excludeWindowCount,
      this.highLightWidth,
      this.highLightColor,
      this.enableHighLight});

  /// @nodoc
  @JsonKey(name: 'captureAudio')
  final bool? captureAudio;

  /// @nodoc
  @JsonKey(name: 'audioParams')
  final ScreenAudioParameters? audioParams;

  /// When setting encoding resolution in a document sharing scenario (screenScenarioDocument), choose one of the following:
  ///  For optimal image quality, set the encoding resolution the same as the capture resolution.
  ///  For a balance between quality, bandwidth, and performance:
  ///  If capture resolution is greater than 1920 × 1080, set encoding resolution no lower than 1920 × 1080.
  ///  If capture resolution is less than 1920 × 1080, set encoding resolution no lower than 1280 × 720. Video encoding resolution of the screen sharing stream. See VideoDimensions. Default is 1920 × 1080, i.e., 2073600 pixels. This pixel count is used for billing. If the aspect ratio of the shared screen resolution differs from this setting, the SDK encodes according to the following strategy. Assuming dimensions is set to 1920 × 1080:
  ///  If the screen resolution is smaller than dimensions, e.g., 1000 × 1000, the SDK encodes at 1000 × 1000.
  ///  If the screen resolution is larger than dimensions, e.g., 2000 × 1500, the SDK encodes at the maximum resolution within dimensions that matches the screen's aspect ratio (4:3), i.e., 1440 × 1080.
  @JsonKey(name: 'dimensions')
  final VideoDimensions? dimensions;

  /// Frame rate of the shared video, in fps. Default is 5. It is recommended not to exceed 15.
  @JsonKey(name: 'frameRate')
  final int? frameRate;

  /// Bitrate of the shared video, in Kbps. Default is 0, meaning the SDK calculates a reasonable value based on the current screen resolution.
  @JsonKey(name: 'bitrate')
  final int? bitrate;

  /// Due to macOS system limitations, setting this parameter to false has no effect when sharing the screen (no impact when sharing a window). Whether to capture the mouse cursor during screen sharing: true : (Default) Capture mouse. false : Do not capture mouse.
  @JsonKey(name: 'captureMouseCursor')
  final bool? captureMouseCursor;

  /// Due to macOS system limitations, when setting this member to bring a window to the front, only the main window is brought to the front if the app has multiple windows. When calling startScreenCaptureByWindowId to share a window, whether to bring the window to the front: true : Bring to front. false : (Default) Do not bring to front.
  @JsonKey(name: 'windowFocus')
  final bool? windowFocus;

  /// List of window IDs to exclude. When calling startScreenCaptureByDisplayId to start screen sharing, you can use this parameter to exclude specific windows. You can also dynamically exclude windows by passing this parameter when calling updateScreenCaptureParameters to update screen sharing configuration.
  @JsonKey(name: 'excludeWindowList', readValue: readIntPtrList)
  final List<int>? excludeWindowList;

  /// Number of windows to exclude. On Windows, the maximum value is 24. If exceeded, window exclusion does not take effect.
  @JsonKey(name: 'excludeWindowCount')
  final int? excludeWindowCount;

  /// (macOS and Windows only) Width of the highlight border (px). Default is 5. Valid range is (0,50]. This parameter takes effect only when highLighted is set to true.
  @JsonKey(name: 'highLightWidth')
  final int? highLightWidth;

  /// (macOS and Windows only)
  ///  On Windows, specifies the ARGB color of the highlight. Default is 0xFF8CBF26.
  ///  On macOS, COLOR_CLASS refers to NSColor.
  @JsonKey(name: 'highLightColor')
  final int? highLightColor;

  /// When sharing a partial region of a window or screen, if this parameter is set to true, the SDK highlights the entire window or screen. (macOS and Windows only) Whether to highlight the shared window or screen: true : Highlight. false : (Default) Do not highlight.
  @JsonKey(name: 'enableHighLight')
  final bool? enableHighLight;

  /// @nodoc
  factory ScreenCaptureParameters.fromJson(Map<String, dynamic> json) =>
      _$ScreenCaptureParametersFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ScreenCaptureParametersToJson(this);
}

/// Audio recording quality.
@JsonEnum(alwaysCreate: true)
enum AudioRecordingQualityType {
  /// 0: Low quality. 32 kHz sample rate, file size for 10 minutes is about 1.2 MB.
  @JsonValue(0)
  audioRecordingQualityLow,

  /// 1: Medium quality. 32 kHz sample rate, file size for 10 minutes is about 2 MB.
  @JsonValue(1)
  audioRecordingQualityMedium,

  /// 2: High quality. 32 kHz sample rate, file size for 10 minutes is about 3.75 MB.
  @JsonValue(2)
  audioRecordingQualityHigh,

  /// 3: Ultra-high quality. 32 kHz sample rate, file size for 10 minutes is about 7.5 MB.
  @JsonValue(3)
  audioRecordingQualityUltraHigh,
}

/// @nodoc
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

/// Recording content. Set in startAudioRecording.
@JsonEnum(alwaysCreate: true)
enum AudioFileRecordingType {
  /// 1: Record only the local user's audio.
  @JsonValue(1)
  audioFileRecordingMic,

  /// 2: Record only the audio of all remote users.
  @JsonValue(2)
  audioFileRecordingPlayback,

  /// 3: Record the mixed audio of the local and all remote users.
  @JsonValue(3)
  audioFileRecordingMixed,
}

/// @nodoc
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

/// Audio encoding content.
@JsonEnum(alwaysCreate: true)
enum AudioEncodedFrameObserverPosition {
  /// 1: Encode only the local user's audio.
  @JsonValue(1)
  audioEncodedFrameObserverPositionRecord,

  /// 2: Encode only all remote users' audio.
  @JsonValue(2)
  audioEncodedFrameObserverPositionPlayback,

  /// 3: Encode the mixed audio of local and all remote users.
  @JsonValue(3)
  audioEncodedFrameObserverPositionMixed,
}

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
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioRecordingConfiguration implements AgoraSerializable {
  /// @nodoc
  const AudioRecordingConfiguration(
      {this.filePath,
      this.encode,
      this.sampleRate,
      this.fileRecordingType,
      this.quality,
      this.recordingChannel});

  /// The absolute path where the recording file is saved locally. Must include the file name and extension. For example: C:\music\audio.aac. Make sure the specified path exists and is writable.
  @JsonKey(name: 'filePath')
  final String? filePath;

  /// Specifies whether to encode the audio data: true : Encode the audio data using AAC. false : (Default) Do not encode the audio data; save the raw recorded audio data directly.
  @JsonKey(name: 'encode')
  final bool? encode;

  /// If you set this parameter to 44100 or 48000, to ensure recording quality, it is recommended to record in WAV format or use AAC files with quality set to audioRecordingQualityMedium or audioRecordingQualityHigh. Recording sample rate (Hz).
  ///  16000
  ///  32000 (default)
  ///  44100
  ///  48000
  @JsonKey(name: 'sampleRate')
  final int? sampleRate;

  /// Recording content. See AudioFileRecordingType.
  @JsonKey(name: 'fileRecordingType')
  final AudioFileRecordingType? fileRecordingType;

  /// Recording quality. See audiorecordingqualitytype. This parameter applies only to AAC files.
  @JsonKey(name: 'quality')
  final AudioRecordingQualityType? quality;

  /// The actual recorded audio channel depends on the captured audio channel:
  ///  If the captured audio is mono and recordingChannel is set to 2, the recorded audio will be stereo with duplicated mono data, not true stereo.
  ///  If the captured audio is stereo and recordingChannel is set to 1, the recorded audio will be mono with mixed stereo data. In addition, the integration scheme may affect the final recorded audio channel. If you want to record true stereo, please [contact technical support](https://www.agora.io/cn/contact/) for assistance. Number of audio channels to record. Supported values:
  ///  1: (Default) Mono.
  ///  2: Stereo.
  @JsonKey(name: 'recordingChannel')
  final int? recordingChannel;

  /// @nodoc
  factory AudioRecordingConfiguration.fromJson(Map<String, dynamic> json) =>
      _$AudioRecordingConfigurationFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AudioRecordingConfigurationToJson(this);
}

/// Observer settings for encoded audio.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioEncodedFrameObserverConfig implements AgoraSerializable {
  /// @nodoc
  const AudioEncodedFrameObserverConfig({this.postionType, this.encodingType});

  /// Audio encoding content. See AudioEncodedFrameObserverPosition.
  @JsonKey(name: 'postionType')
  final AudioEncodedFrameObserverPosition? postionType;

  /// Audio encoding type. See AudioEncodingType.
  @JsonKey(name: 'encodingType')
  final AudioEncodingType? encodingType;

  /// @nodoc
  factory AudioEncodedFrameObserverConfig.fromJson(Map<String, dynamic> json) =>
      _$AudioEncodedFrameObserverConfigFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$AudioEncodedFrameObserverConfigToJson(this);
}

/// Observer for encoded audio.
class AudioEncodedFrameObserver {
  /// @nodoc
  const AudioEncodedFrameObserver({
    this.onRecordAudioEncodedFrame,
    this.onPlaybackAudioEncodedFrame,
    this.onMixedAudioEncodedFrame,
  });

  /// Retrieves the audio encoded data of the local user.
  ///
  /// After calling registerAudioEncodedFrameObserver and setting the audio encoded content to audioEncodedFrameObserverPositionRecord, you can use this callback to get the audio encoded data of the local user.
  ///
  /// * [frameBuffer] Audio buffer.
  /// * [length] Length of the audio data in bytes.
  /// * [audioEncodedFrameInfo] Information about the encoded audio. See EncodedAudioFrameInfo.
  final void Function(Uint8List frameBuffer, int length,
      EncodedAudioFrameInfo audioEncodedFrameInfo)? onRecordAudioEncodedFrame;

  /// Retrieves the audio encoded data of all remote users.
  ///
  /// After calling registerAudioEncodedFrameObserver and setting the audio encoded content to audioEncodedFrameObserverPositionPlayback, you can use this callback to get the audio encoded data of all remote users.
  ///
  /// * [frameBuffer] Audio buffer.
  /// * [length] Length of the audio data in bytes.
  /// * [audioEncodedFrameInfo] Information about the encoded audio. See EncodedAudioFrameInfo.
  final void Function(Uint8List frameBuffer, int length,
      EncodedAudioFrameInfo audioEncodedFrameInfo)? onPlaybackAudioEncodedFrame;

  /// Retrieves the encoded audio data after mixing local and all remote users' audio.
  ///
  /// After calling registerAudioEncodedFrameObserver and setting the audio encoding content to audioEncodedFrameObserverPositionMixed, you can use this callback to get the mixed and encoded audio data from the local and all remote users.
  ///
  /// * [frameBuffer] Audio buffer.
  /// * [length] Length of the audio data in bytes.
  /// * [audioEncodedFrameInfo] Information about the encoded audio. See EncodedAudioFrameInfo.
  final void Function(Uint8List frameBuffer, int length,
      EncodedAudioFrameInfo audioEncodedFrameInfo)? onMixedAudioEncodedFrame;
}

/// Access region, i.e., the region of the server that the SDK connects to.
@JsonEnum(alwaysCreate: true)
enum AreaCode {
  /// Mainland China.
  @JsonValue(0x00000001)
  areaCodeCn,

  /// North America region.
  @JsonValue(0x00000002)
  areaCodeNa,

  /// Europe region.
  @JsonValue(0x00000004)
  areaCodeEu,

  /// Asia region excluding China.
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

/// @nodoc
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
  @JsonValue(0x00000400)
  areaCodeHkmc,

  /// @nodoc
  @JsonValue(0x00000800)
  areaCodeUs,

  /// @nodoc
  @JsonValue(0x00001000)
  areaCodeRu,

  /// @nodoc
  @JsonValue(0xFFFFFFFE)
  areaCodeOvs,
}

/// @nodoc
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

/// Error codes for media stream relay across channels.
@JsonEnum(alwaysCreate: true)
enum ChannelMediaRelayError {
  /// 0: Everything works fine.
  @JsonValue(0)
  relayOk,

  /// 1: Server error response.
  @JsonValue(1)
  relayErrorServerErrorResponse,

  /// 2: No response from the server.
  /// This error may be caused by poor network conditions. If this error is reported when initiating cross-channel media relay, you can try again later; if reported during the relay process, you can call the leaveChannel method to leave the channel.
  /// This error may also occur if the current App ID has not enabled cross-channel media relay. You can [contact technical support](https://www.agora.io/cn/contact/) to apply for enabling it.
  @JsonValue(2)
  relayErrorServerNoResponse,

  /// 3: SDK failed to get the service, possibly due to limited server resources.
  @JsonValue(3)
  relayErrorNoResourceAvailable,

  /// 4: Failed to initiate media stream relay across channels.
  @JsonValue(4)
  relayErrorFailedJoinSrc,

  /// 5: Failed to accept media stream relay across channels.
  @JsonValue(5)
  relayErrorFailedJoinDest,

  /// 6: Server failed to receive media stream relay across channels.
  @JsonValue(6)
  relayErrorFailedPacketReceivedFromSrc,

  /// 7: Server failed to send media stream relay across channels.
  @JsonValue(7)
  relayErrorFailedPacketSentToDest,

  /// 8: SDK disconnected from the server due to poor network quality. You can call the leaveChannel method to leave the current channel.
  @JsonValue(8)
  relayErrorServerConnectionLost,

  /// 9: Internal server error.
  @JsonValue(9)
  relayErrorInternalError,

  /// 10: Token of the source channel has expired.
  @JsonValue(10)
  relayErrorSrcTokenExpired,

  /// 11: Token of the destination channel has expired.
  @JsonValue(11)
  relayErrorDestTokenExpired,
}

/// @nodoc
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

/// State codes for media stream relay across channels.
@JsonEnum(alwaysCreate: true)
enum ChannelMediaRelayState {
  /// 0: Initial state. After successfully calling stopChannelMediaRelay to stop media stream relay across channels, onChannelMediaRelayStateChanged will return this state.
  @JsonValue(0)
  relayStateIdle,

  /// 1: SDK is attempting cross-channel connection.
  @JsonValue(1)
  relayStateConnecting,

  /// 2: Broadcaster in the source channel has successfully joined the destination channel.
  @JsonValue(2)
  relayStateRunning,

  /// 3: An error occurred. See the code parameter in onChannelMediaRelayStateChanged for error details.
  @JsonValue(3)
  relayStateFailure,
}

/// @nodoc
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

/// Channel media information.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ChannelMediaInfo implements AgoraSerializable {
  /// @nodoc
  const ChannelMediaInfo({this.uid, this.channelName, this.token});

  /// User ID.
  @JsonKey(name: 'uid')
  final int? uid;

  /// Channel name.
  @JsonKey(name: 'channelName')
  final String? channelName;

  /// Token used to join the channel.
  @JsonKey(name: 'token')
  final String? token;

  /// @nodoc
  factory ChannelMediaInfo.fromJson(Map<String, dynamic> json) =>
      _$ChannelMediaInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ChannelMediaInfoToJson(this);
}

/// Configuration information for media stream relay across channels.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ChannelMediaRelayConfiguration implements AgoraSerializable {
  /// @nodoc
  const ChannelMediaRelayConfiguration(
      {this.srcInfo, this.destInfos, this.destCount});

  /// Source channel information ChannelMediaInfo, which includes the following members: channelName : Name of the source channel. Default is NULL, which means the SDK fills in the current channel name. token : The token used to join the source channel. It is generated based on the channelName and uid you set in srcInfo.
  ///  If App Certificate is not enabled, you can set this parameter to the default value NULL, which means the SDK fills in the App ID.
  ///  If App Certificate is enabled, you must provide a token generated using the channelName and uid, and the uid must be 0. uid : The UID that identifies the media stream being relayed in the source channel. Default is 0. Do not modify.
  @JsonKey(name: 'srcInfo')
  final ChannelMediaInfo? srcInfo;

  /// If the token for any destination channel expires, all cross-channel relays will stop. Therefore, it is recommended that you set the same expiration duration for the tokens of all destination channels. Destination channel information ChannelMediaInfo, which includes the following members: channelName : Name of the destination channel. token : The token used to join the destination channel. It is generated based on the channelName and uid you set in destInfos.
  ///  If App Certificate is not enabled, you can set this parameter to the default value NULL, which means the SDK fills in the App ID.
  ///  If App Certificate is enabled, you must provide a token generated using the channelName and uid. uid : The UID that identifies the media stream being relayed in the destination channel. The value range is 0 to (2^32 - 1). Ensure it is different from all UIDs in the destination channel. Default is 0, which means the SDK assigns a UID randomly.
  @JsonKey(name: 'destInfos')
  final List<ChannelMediaInfo>? destInfos;

  /// Number of destination channels. Default is 0. Value range is [0,6]. This parameter should match the number of ChannelMediaInfo objects defined in destInfos.
  @JsonKey(name: 'destCount')
  final int? destCount;

  /// @nodoc
  factory ChannelMediaRelayConfiguration.fromJson(Map<String, dynamic> json) =>
      _$ChannelMediaRelayConfigurationFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ChannelMediaRelayConfigurationToJson(this);
}

/// Uplink network information.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class UplinkNetworkInfo implements AgoraSerializable {
  /// @nodoc
  const UplinkNetworkInfo({this.videoEncoderTargetBitrateBps});

  /// Target bitrate (bps) of the video encoder.
  @JsonKey(name: 'video_encoder_target_bitrate_bps')
  final int? videoEncoderTargetBitrateBps;

  /// @nodoc
  factory UplinkNetworkInfo.fromJson(Map<String, dynamic> json) =>
      _$UplinkNetworkInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UplinkNetworkInfoToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class DownlinkNetworkInfo implements AgoraSerializable {
  /// @nodoc
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

  @override
  Map<String, dynamic> toJson() => _$DownlinkNetworkInfoToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class PeerDownlinkInfo implements AgoraSerializable {
  /// @nodoc
  const PeerDownlinkInfo(
      {this.userId,
      this.streamType,
      this.currentDownscaleLevel,
      this.expectedBitrateBps});

  /// @nodoc
  @JsonKey(name: 'userId')
  final String? userId;

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

  @override
  Map<String, dynamic> toJson() => _$PeerDownlinkInfoToJson(this);
}

/// Built-in encryption mode.
///
/// It is recommended to use aes128Gcm2 or aes256Gcm2 encryption modes. These modes support salt and offer higher security.
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

  /// 7: (Default) 128-bit AES encryption, GCM mode. This encryption mode requires setting a salt (encryptionKdfSalt).
  @JsonValue(7)
  aes128Gcm2,

  /// 8: 256-bit AES encryption, GCM mode. This encryption mode requires setting a salt (encryptionKdfSalt).
  @JsonValue(8)
  aes256Gcm2,

  /// Enumeration value boundary.
  @JsonValue(9)
  modeEnd,
}

/// @nodoc
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

/// Configures built-in encryption mode and key.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class EncryptionConfig implements AgoraSerializable {
  /// @nodoc
  const EncryptionConfig(
      {this.encryptionMode,
      this.encryptionKey,
      this.encryptionKdfSalt,
      this.datastreamEncryptionEnabled});

  /// Built-in encryption mode. See EncryptionMode. It is recommended to use aes128Gcm2 or aes256Gcm2 encryption modes. These two modes support salt and offer higher security.
  @JsonKey(name: 'encryptionMode')
  final EncryptionMode? encryptionMode;

  /// Built-in encryption key, of type String, with no length limit. It is recommended to use a 32-byte key. If this parameter is not specified or set to NULL, built-in encryption cannot be enabled, and the SDK returns error code -2.
  @JsonKey(name: 'encryptionKey')
  final String? encryptionKey;

  /// Salt, 32 bytes in length. It is recommended to generate the salt on the server side using OpenSSL. This parameter takes effect only when using aes128Gcm2 or aes256Gcm2 encryption modes. In this case, ensure that the value provided for this parameter is not all 0.
  @JsonKey(name: 'encryptionKdfSalt', ignore: true)
  final Uint8List? encryptionKdfSalt;

  /// Whether to enable data stream encryption: true : Enable data stream encryption. false : (Default) Disable data stream encryption.
  @JsonKey(name: 'datastreamEncryptionEnabled')
  final bool? datastreamEncryptionEnabled;

  /// @nodoc
  factory EncryptionConfig.fromJson(Map<String, dynamic> json) =>
      _$EncryptionConfigFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EncryptionConfigToJson(this);
}

/// Built-in encryption error type.
@JsonEnum(alwaysCreate: true)
enum EncryptionErrorType {
  /// 0: Internal reason.
  @JsonValue(0)
  encryptionErrorInternalFailure,

  /// 1: Media stream decryption error. Make sure the encryption mode or key used by the sender and receiver is the same.
  @JsonValue(1)
  encryptionErrorDecryptionFailure,

  /// 2: Media stream encryption error.
  @JsonValue(2)
  encryptionErrorEncryptionFailure,

  /// 3: Data stream decryption error. Make sure the encryption mode or key used by the sender and receiver is the same.
  @JsonValue(3)
  encryptionErrorDatastreamDecryptionFailure,

  /// 4: Data stream encryption error.
  @JsonValue(4)
  encryptionErrorDatastreamEncryptionFailure,
}

/// @nodoc
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
  /// @nodoc
  @JsonValue(0)
  uploadSuccess,

  /// @nodoc
  @JsonValue(1)
  uploadNetError,

  /// @nodoc
  @JsonValue(2)
  uploadServerError,
}

/// @nodoc
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

/// Device permission types.
@JsonEnum(alwaysCreate: true)
enum PermissionType {
  /// 0: Permission for audio recording devices.
  @JsonValue(0)
  recordAudio,

  /// 1: Camera permission.
  @JsonValue(1)
  camera,

  /// (Android only) 2: Screen sharing permission.
  @JsonValue(2)
  screenCapture,
}

/// @nodoc
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

/// Subscribe state.
@JsonEnum(alwaysCreate: true)
enum StreamSubscribeState {
  /// 0: Initial subscribe state after joining the channel.
  @JsonValue(0)
  subStateIdle,

  /// 1: Subscription failed. Possible reasons:
  ///  Remote user:
  ///  Called muteLocalAudioStream (true) or muteLocalVideoStream (true) to stop sending local media streams.
  ///  Called disableAudio or disableVideo to disable local audio or video modules.
  ///  Called enableLocalAudio (false) or enableLocalVideo (false) to disable local audio or video capture.
  ///  User is an audience member.
  ///  Local user called the following methods to stop receiving remote media streams:
  ///  Called muteRemoteAudioStream (true), muteAllRemoteAudioStreams (true) to stop receiving remote audio streams.
  ///  Called muteRemoteVideoStream (true), muteAllRemoteVideoStreams (true) to stop receiving remote video streams.
  @JsonValue(1)
  subStateNoSubscribed,

  /// 2: Subscribing.
  @JsonValue(2)
  subStateSubscribing,

  /// 3: Remote stream received, subscription successful.
  @JsonValue(3)
  subStateSubscribed,
}

/// @nodoc
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

/// Publish state.
@JsonEnum(alwaysCreate: true)
enum StreamPublishState {
  /// 0: Initial publish state after joining the channel.
  @JsonValue(0)
  pubStateIdle,

  /// 1: Publish failed. Possible reasons:
  ///  The local user called muteLocalAudioStream (true) or muteLocalVideoStream (true) to stop sending local media streams.
  ///  The local user called disableAudio or disableVideo to disable local audio or video modules.
  ///  The local user called enableLocalAudio (false) or enableLocalVideo (false) to disable local audio or video capture.
  ///  The local user is an audience member.
  @JsonValue(1)
  pubStateNoPublished,

  /// 2: Publishing.
  @JsonValue(2)
  pubStatePublishing,

  /// 3: Published successfully.
  @JsonValue(3)
  pubStatePublished,
}

/// @nodoc
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

/// Configuration for audio and video echo test.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class EchoTestConfiguration implements AgoraSerializable {
  /// @nodoc
  const EchoTestConfiguration(
      {this.view,
      this.enableAudio,
      this.enableVideo,
      this.token,
      this.channelId,
      this.intervalInSeconds});

  /// The view used to render the local user's video. This parameter only applies to scenarios testing video devices. Make sure enableVideo is set to true.
  @JsonKey(name: 'view', readValue: readIntPtr)
  final int? view;

  /// Whether to enable the audio device: true : (Default) Enables the audio device. Set to true to test the audio device. false : Disables the audio device.
  @JsonKey(name: 'enableAudio')
  final bool? enableAudio;

  /// Whether to enable the video device. Video device detection is not supported yet. Set this parameter to false.
  @JsonKey(name: 'enableVideo')
  final bool? enableVideo;

  /// Token used to ensure the security of the audio and video echo test. If you have not enabled the App Certificate in the console, you do not need to set this parameter. If you have enabled the App Certificate, you must provide a Token, and the uid used to generate the Token must be 0xFFFFFFFF, and the channel name used must uniquely identify each echo test. For how to generate a Token on the server, refer to [Use Token for Authentication](https://docs.agora.io/en/video-calling/token-authentication/deploy-token-server).
  @JsonKey(name: 'token')
  final String? token;

  /// Channel name identifying each audio and video echo test. To ensure proper functioning of the echo test, the channel name used by each terminal user under the same project (App ID) on different devices must be unique.
  @JsonKey(name: 'channelId')
  final String? channelId;

  /// Sets the interval or delay for returning the audio and video echo test results. Value range is [2,10] in seconds. Default is 2 seconds.
  ///  For audio echo test, the result is returned at the interval you set.
  ///  For video echo test, the video is displayed briefly, then the delay gradually increases until it reaches the set value.
  @JsonKey(name: 'intervalInSeconds')
  final int? intervalInSeconds;

  /// @nodoc
  factory EchoTestConfiguration.fromJson(Map<String, dynamic> json) =>
      _$EchoTestConfigurationFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EchoTestConfigurationToJson(this);
}

/// User information.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class UserInfo implements AgoraSerializable {
  /// @nodoc
  const UserInfo({this.uid, this.userAccount, this.customUserInfo});

  /// User ID.
  @JsonKey(name: 'uid')
  final int? uid;

  /// User account. Length limit is MaxUserAccountLengthType.
  @JsonKey(name: 'userAccount')
  final String? userAccount;

  /// @nodoc
  @JsonKey(name: 'customUserInfo')
  final String? customUserInfo;

  /// @nodoc
  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

/// Ear monitoring audio filter type.
@JsonEnum(alwaysCreate: true)
enum EarMonitoringFilterType {
  /// 1<<0: Do not add audio filter to ear monitoring.
  @JsonValue((1 << 0))
  earMonitoringFilterNone,

  /// 1<<1: Add vocal effect audio filter to ear monitoring. If you implement features like voice beautification or sound effects, users can hear the processed sound through ear monitoring.
  @JsonValue((1 << 1))
  earMonitoringFilterBuiltInAudioFilters,

  /// 1<<2: Add noise suppression audio filter to ear monitoring.
  @JsonValue((1 << 2))
  earMonitoringFilterNoiseSuppression,

  /// 1<<15: Reuse the audio filter already applied on the sending end. Reusing the audio filter reduces CPU usage for ear monitoring but increases ear monitoring latency. Suitable for scenarios where lower CPU usage is required and latency is not critical.
  @JsonValue((1 << 15))
  earMonitoringFilterReusePostProcessingFilter,
}

/// @nodoc
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

/// @nodoc
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

/// Video encoding configuration for screen sharing stream.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ScreenVideoParameters implements AgoraSerializable {
  /// @nodoc
  const ScreenVideoParameters(
      {this.dimensions, this.frameRate, this.bitrate, this.contentHint});

  /// Resolution for video encoding. Default is 1280 × 720.
  @JsonKey(name: 'dimensions')
  final VideoDimensions? dimensions;

  /// Video encoding frame rate (fps). Default is 15.
  @JsonKey(name: 'frameRate')
  final int? frameRate;

  /// Video encoding bitrate (Kbps).
  @JsonKey(name: 'bitrate')
  final int? bitrate;

  /// Content type of the screen sharing video.
  @JsonKey(name: 'contentHint')
  final VideoContentHint? contentHint;

  /// @nodoc
  factory ScreenVideoParameters.fromJson(Map<String, dynamic> json) =>
      _$ScreenVideoParametersFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ScreenVideoParametersToJson(this);
}

/// Parameter configuration for screen sharing.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ScreenCaptureParameters2 implements AgoraSerializable {
  /// @nodoc
  const ScreenCaptureParameters2(
      {this.captureAudio,
      this.audioParams,
      this.captureVideo,
      this.videoParams});

  /// Due to system limitations, capturing system audio is only supported on Android API level 29 and above, i.e., Android 10 and above.
  ///  To improve the success rate of capturing system audio during screen sharing, ensure that you have called the setAudioScenario method and set the audio scenario to audioScenarioGameStreaming. Whether to capture system audio during screen sharing: true : Capture system audio. false : (Default) Do not capture system audio.
  @JsonKey(name: 'captureAudio')
  final bool? captureAudio;

  /// Audio configuration for the screen sharing stream. See ScreenAudioParameters. This parameter takes effect only when captureAudio is true.
  @JsonKey(name: 'audioParams')
  final ScreenAudioParameters? audioParams;

  /// Due to system limitations, screen capture is only supported on Android API level 21 and above, i.e., Android 5 and above. Whether to capture the screen during screen sharing: true : (Default) Capture screen. false : Do not capture screen.
  @JsonKey(name: 'captureVideo')
  final bool? captureVideo;

  /// Video encoding configuration for the screen sharing stream. See ScreenVideoParameters. This parameter takes effect only when captureVideo is true.
  @JsonKey(name: 'videoParams')
  final ScreenVideoParameters? videoParams;

  /// @nodoc
  factory ScreenCaptureParameters2.fromJson(Map<String, dynamic> json) =>
      _$ScreenCaptureParameters2FromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ScreenCaptureParameters2ToJson(this);
}

/// Rendering status of media frames.
@JsonEnum(alwaysCreate: true)
enum MediaTraceEvent {
  /// 0: Video frame rendered.
  @JsonValue(0)
  mediaTraceEventVideoRendered,

  /// 1: Video frame decoded.
  @JsonValue(1)
  mediaTraceEventVideoDecoded,
}

/// @nodoc
extension MediaTraceEventExt on MediaTraceEvent {
  /// @nodoc
  static MediaTraceEvent fromValue(int value) {
    return $enumDecode(_$MediaTraceEventEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$MediaTraceEventEnumMap[this]!;
  }
}

/// Metric information during video frame rendering.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoRenderingTracingInfo implements AgoraSerializable {
  /// @nodoc
  const VideoRenderingTracingInfo(
      {this.elapsedTime,
      this.start2JoinChannel,
      this.join2JoinSuccess,
      this.joinSuccess2RemoteJoined,
      this.remoteJoined2SetView,
      this.remoteJoined2UnmuteVideo,
      this.remoteJoined2PacketReceived});

  /// The time interval (ms) from calling startMediaRenderingTracing to triggering the onVideoRenderingTracingResult callback. It is recommended to call startMediaRenderingTracing before joining the channel.
  @JsonKey(name: 'elapsedTime')
  final int? elapsedTime;

  /// The time interval (ms) from calling startMediaRenderingTracing to calling joinChannel. A negative value indicates that startMediaRenderingTracing was called after joinChannel.
  @JsonKey(name: 'start2JoinChannel')
  final int? start2JoinChannel;

  /// The time interval (ms) from calling joinChannel1 or joinChannel to successfully joining the channel.
  @JsonKey(name: 'join2JoinSuccess')
  final int? join2JoinSuccess;

  /// If the local user calls startMediaRenderingTracing after the remote user has joined the channel, this value is 0 and has no reference value.
  ///  To improve the speed of remote user video display, it is recommended that the local user joins the channel after the remote user has joined to reduce this value.
  ///  If the local user calls startMediaRenderingTracing before successfully joining the channel, this is the time interval (ms) from the local user successfully joining the channel to the remote user joining the channel.
  ///  If the local user calls startMediaRenderingTracing after successfully joining the channel, this is the time interval (ms) from calling startMediaRenderingTracing to the remote user joining the channel.
  @JsonKey(name: 'joinSuccess2RemoteJoined')
  final int? joinSuccess2RemoteJoined;

  /// If the local user calls startMediaRenderingTracing after setting the remote view, this value is 0 and has no reference value.
  ///  To improve the speed of remote user video display, it is recommended to set the remote view before the remote user joins the channel, or immediately after the remote user joins, to reduce this value.
  ///  If the local user calls startMediaRenderingTracing before the remote user joins the channel, this is the time interval (ms) from the remote user joining the channel to the local user setting the remote view.
  ///  If the local user calls startMediaRenderingTracing after the remote user joins the channel, this is the time interval (ms) from calling startMediaRenderingTracing to setting the remote view.
  @JsonKey(name: 'remoteJoined2SetView')
  final int? remoteJoined2SetView;

  /// If startMediaRenderingTracing is called after subscribing to the remote video stream, this value is 0 and has no reference value.
  ///  To improve the speed of remote user video display, it is recommended that the local user subscribes to the remote video stream immediately after the remote user joins the channel to reduce this value.
  ///  If the local user calls startMediaRenderingTracing before the remote user joins the channel, this is the time interval (ms) from the remote user joining the channel to subscribing to the remote video stream.
  ///  If the local user calls startMediaRenderingTracing after the remote user joins the channel, this is the time interval (ms) from calling startMediaRenderingTracing to subscribing to the remote video stream.
  @JsonKey(name: 'remoteJoined2UnmuteVideo')
  final int? remoteJoined2UnmuteVideo;

  /// If startMediaRenderingTracing is called after receiving the remote video stream, this value is 0 and has no reference value.
  ///  To improve the speed of remote user video display, it is recommended that the remote user publishes the video stream immediately after joining the channel and the local user subscribes to the remote video stream immediately to reduce this value.
  ///  If the local user calls startMediaRenderingTracing before the remote user joins the channel, this is the time interval (ms) from the remote user joining the channel to the local user receiving the first remote data packet.
  ///  If the local user calls startMediaRenderingTracing after the remote user joins the channel, this is the time interval (ms) from calling startMediaRenderingTracing to receiving the first remote data packet.
  @JsonKey(name: 'remoteJoined2PacketReceived')
  final int? remoteJoined2PacketReceived;

  /// @nodoc
  factory VideoRenderingTracingInfo.fromJson(Map<String, dynamic> json) =>
      _$VideoRenderingTracingInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$VideoRenderingTracingInfoToJson(this);
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum ConfigFetchType {
  /// @nodoc
  @JsonValue(1)
  configFetchTypeInitialize,

  /// @nodoc
  @JsonValue(2)
  configFetchTypeJoinChannel,
}

/// @nodoc
extension ConfigFetchTypeExt on ConfigFetchType {
  /// @nodoc
  static ConfigFetchType fromValue(int value) {
    return $enumDecode(_$ConfigFetchTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$ConfigFetchTypeEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum LocalProxyMode {
  /// @nodoc
  @JsonValue(0)
  connectivityFirst,

  /// @nodoc
  @JsonValue(1)
  localOnly,
}

/// @nodoc
extension LocalProxyModeExt on LocalProxyMode {
  /// @nodoc
  static LocalProxyMode fromValue(int value) {
    return $enumDecode(_$LocalProxyModeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$LocalProxyModeEnumMap[this]!;
  }
}

/// Configuration information of the log server.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LogUploadServerInfo implements AgoraSerializable {
  /// @nodoc
  const LogUploadServerInfo(
      {this.serverDomain, this.serverPath, this.serverPort, this.serverHttps});

  /// Domain name of the log server.
  @JsonKey(name: 'serverDomain')
  final String? serverDomain;

  /// Storage path of the log on the server.
  @JsonKey(name: 'serverPath')
  final String? serverPath;

  /// Port of the log server.
  @JsonKey(name: 'serverPort')
  final int? serverPort;

  /// Whether the log server uses HTTPS protocol: true : Uses HTTPS protocol. false : Uses HTTP protocol.
  @JsonKey(name: 'serverHttps')
  final bool? serverHttps;

  /// @nodoc
  factory LogUploadServerInfo.fromJson(Map<String, dynamic> json) =>
      _$LogUploadServerInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LogUploadServerInfoToJson(this);
}

/// Advanced options for Local Access Point.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AdvancedConfigInfo implements AgoraSerializable {
  /// @nodoc
  const AdvancedConfigInfo({this.logUploadServer});

  /// Custom log upload server. By default, the SDK uploads logs to the Agora log server. You can use this parameter to change the log upload server. See LogUploadServerInfo.
  @JsonKey(name: 'logUploadServer')
  final LogUploadServerInfo? logUploadServer;

  /// @nodoc
  factory AdvancedConfigInfo.fromJson(Map<String, dynamic> json) =>
      _$AdvancedConfigInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AdvancedConfigInfoToJson(this);
}

/// Local Access Point configuration.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LocalAccessPointConfiguration implements AgoraSerializable {
  /// @nodoc
  const LocalAccessPointConfiguration(
      {this.ipList,
      this.ipListSize,
      this.domainList,
      this.domainListSize,
      this.verifyDomainName,
      this.mode,
      this.advancedConfig,
      this.disableAut});

  /// Internal IP address list of the Local Access Point. Either ipList or domainList must be provided.
  @JsonKey(name: 'ipList')
  final List<String>? ipList;

  /// Number of internal IP addresses for the Local Access Point. This value must match the number of IP addresses you provide.
  @JsonKey(name: 'ipListSize')
  final int? ipListSize;

  /// Domain name list of the Local Access Point. The SDK resolves the IP addresses of the Local Access Point based on the provided domain names. The domain resolution timeout is 10 seconds. Either ipList or domainList must be provided. If you specify both IP addresses and domain names, the SDK merges and deduplicates the resolved IPs and the specified IPs, then randomly connects to one IP for load balancing.
  @JsonKey(name: 'domainList')
  final List<String>? domainList;

  /// Number of domain names for the Local Access Point. This value must match the number of domain names you provide.
  @JsonKey(name: 'domainListSize')
  final int? domainListSize;

  /// Domain name used for internal certificate verification. If left empty, the SDK uses the default certificate verification domain secure-edge.local.
  @JsonKey(name: 'verifyDomainName')
  final String? verifyDomainName;

  /// Connection mode. See LocalProxyMode.
  @JsonKey(name: 'mode')
  final LocalProxyMode? mode;

  /// Advanced options for the Local Access Point. See AdvancedConfigInfo.
  @JsonKey(name: 'advancedConfig')
  final AdvancedConfigInfo? advancedConfig;

  /// @nodoc
  @JsonKey(name: 'disableAut')
  final bool? disableAut;

  /// @nodoc
  factory LocalAccessPointConfiguration.fromJson(Map<String, dynamic> json) =>
      _$LocalAccessPointConfigurationFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LocalAccessPointConfigurationToJson(this);
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum RecorderStreamType {
  /// @nodoc
  @JsonValue(0)
  rtc,

  /// @nodoc
  @JsonValue(1)
  preview,
}

/// @nodoc
extension RecorderStreamTypeExt on RecorderStreamType {
  /// @nodoc
  static RecorderStreamType fromValue(int value) {
    return $enumDecode(_$RecorderStreamTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$RecorderStreamTypeEnumMap[this]!;
  }
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RecorderStreamInfo implements AgoraSerializable {
  /// @nodoc
  const RecorderStreamInfo({this.channelId, this.uid, this.type});

  /// @nodoc
  @JsonKey(name: 'channelId')
  final String? channelId;

  /// @nodoc
  @JsonKey(name: 'uid')
  final int? uid;

  /// @nodoc
  @JsonKey(name: 'type')
  final RecorderStreamType? type;

  /// @nodoc
  factory RecorderStreamInfo.fromJson(Map<String, dynamic> json) =>
      _$RecorderStreamInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RecorderStreamInfoToJson(this);
}

/// Spatial audio parameters.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SpatialAudioParams implements AgoraSerializable {
  /// @nodoc
  const SpatialAudioParams(
      {this.speakerAzimuth,
      this.speakerElevation,
      this.speakerDistance,
      this.speakerOrientation,
      this.enableBlur,
      this.enableAirAbsorb,
      this.speakerAttenuation,
      this.enableDoppler});

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
  @JsonKey(name: 'speaker_attenuation')
  final double? speakerAttenuation;

  /// @nodoc
  @JsonKey(name: 'enable_doppler')
  final bool? enableDoppler;

  /// @nodoc
  factory SpatialAudioParams.fromJson(Map<String, dynamic> json) =>
      _$SpatialAudioParamsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SpatialAudioParamsToJson(this);
}

/// Layout information of a sub video stream in a composite stream.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoLayout implements AgoraSerializable {
  /// @nodoc
  const VideoLayout(
      {this.channelId,
      this.uid,
      this.strUid,
      this.x,
      this.y,
      this.width,
      this.height,
      this.videoState});

  /// Channel name to which the sub video stream belongs.
  @JsonKey(name: 'channelId')
  final String? channelId;

  /// User ID that publishes the sub video stream.
  @JsonKey(name: 'uid')
  final int? uid;

  /// Reserved parameter.
  @JsonKey(name: 'strUid')
  final String? strUid;

  /// The x-coordinate (px) of the sub video stream on the composite canvas. That is, the horizontal offset of the top-left corner of the sub video stream relative to the top-left corner (origin) of the composite canvas.
  @JsonKey(name: 'x')
  final int? x;

  /// The y-coordinate (px) of the sub video stream on the composite canvas. That is, the vertical offset of the top-left corner of the sub video stream relative to the top-left corner (origin) of the composite canvas.
  @JsonKey(name: 'y')
  final int? y;

  /// Width of the sub video stream (px).
  @JsonKey(name: 'width')
  final int? width;

  /// Height of the sub video stream (px)
  @JsonKey(name: 'height')
  final int? height;

  /// State of the sub video stream on the composite canvas.
  ///  0: Normal. The video stream is rendered on the composite canvas.
  ///  1: Placeholder. The video stream has no video frame and is displayed as a placeholder on the composite canvas.
  ///  2: Black image. The video stream is replaced with a black image.
  @JsonKey(name: 'videoState')
  final int? videoState;

  /// @nodoc
  factory VideoLayout.fromJson(Map<String, dynamic> json) =>
      _$VideoLayoutFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$VideoLayoutToJson(this);
}
