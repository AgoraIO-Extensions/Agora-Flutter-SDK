import 'package:agora_rtc_engine/src/binding_forward_export.dart';
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
/// An error code indicates that the SDK encountered an unrecoverable error that requires application intervention. For example, an error is returned when the camera fails to open, and the app needs to inform the user that the camera cannot be used.
@JsonEnum(alwaysCreate: true)
enum ErrorCodeType {
  /// 0: No error.
  @JsonValue(0)
  errOk,

  /// 1: General error with no classified reason. Try calling the method again.
  @JsonValue(1)
  errFailed,

  /// 2: An invalid parameter is used. For example, the specified channel name includes illegal characters. Reset the parameter.
  @JsonValue(2)
  errInvalidArgument,

  /// 3: The SDK is not ready. Possible reasons include the following:
  ///  The initialization of RtcEngine fails. Reinitialize the RtcEngine.
  ///  No user has joined the channel when the method is called. Check the code logic.
  ///  The user has not left the channel when the rate or complain method is called. Check the code logic.
  ///  The audio module is disabled.
  ///  The program is not complete.
  @JsonValue(3)
  errNotReady,

  /// 4: The RtcEngine does not support the request. Possible reasons include the following:
  ///  The built-in encryption mode is incorrect, or the SDK fails to load the external encryption library. Check the encryption mode setting, or reload the external encryption library.
  @JsonValue(4)
  errNotSupported,

  /// 5: The request is rejected. Possible reasons include the following:
  ///  The RtcEngine initialization fails. Reinitialize the RtcEngine.
  ///  The channel name is set as the empty string "" when joining the channel. Reset the channel name.
  ///  When the joinChannelEx method is called to join multiple channels, the specified channel name is already in use. Reset the channel name.
  @JsonValue(5)
  errRefused,

  /// 6: The buffer size is insufficient to store the returned data.
  @JsonValue(6)
  errBufferTooSmall,

  /// 7: A method is called before the initialization of RtcEngine. Ensure that the RtcEngine object is initialized before using this method.
  @JsonValue(7)
  errNotInitialized,

  /// 8: Invalid state.
  @JsonValue(8)
  errInvalidState,

  /// 9: Permission to access is not granted. Check whether your app has access to the audio and video device.
  @JsonValue(9)
  errNoPermission,

  /// 10: A timeout occurs. Some API calls require the SDK to return the execution result. This error occurs if the SDK takes too long (more than 10 seconds) to return the result.
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

  /// 17: The request to join the channel is rejected. Possible reasons include the following:
  ///  The user is already in the channel. Agora recommends that you use the onConnectionStateChanged callback to determine whether the user exists in the channel. Do not call this method to join the channel unless you receive the connectionStateDisconnected (1) state.
  ///  After calling startEchoTest for the call test, the user tries to join the channel without calling stopEchoTest to end the current test. To join a channel, the call test must be ended by calling stopEchoTest.
  @JsonValue(17)
  errJoinChannelRejected,

  /// 18: Fails to leave the channel. Possible reasons include the following:
  ///  The user has left the channel before calling the leaveChannel method. Stop calling this method to clear this error.
  ///  The user calls the leaveChannel method to leave the channel before joining the channel. In this case, no extra operation is needed.
  @JsonValue(18)
  errLeaveChannelRejected,

  /// 19: Resources are already in use.
  @JsonValue(19)
  errAlreadyInUse,

  /// 20: The request is abandoned by the SDK, possibly because the request has been sent too frequently.
  @JsonValue(20)
  errAborted,

  /// 21: The RtcEngine fails to initialize and has crashed because of specific Windows firewall settings.
  @JsonValue(21)
  errInitNetEngine,

  /// 22: The SDK fails to allocate resources because your app uses too many system resources or system resources are insufficient.
  @JsonValue(22)
  errResourceLimited,

  /// 101: The specified App ID is invalid. Rejoin the channel with a valid App ID.
  @JsonValue(101)
  errInvalidAppId,

  /// 102: The specified channel name is invalid. A possible reason is that the parameter's data type is incorrect. Rejoin the channel with a valid channel name.
  @JsonValue(102)
  errInvalidChannelName,

  /// 103: Fails to get server resources in the specified region. Try another region when initializing RtcEngine.
  @JsonValue(103)
  errNoServerResources,

  /// 109: The current token has expired. Apply for a new token on the server and call renewToken. Deprecated: This enumerator is deprecated. Use connectionChangedTokenExpired (9) in the onConnectionStateChanged callback instead.
  @JsonValue(109)
  errTokenExpired,

  /// 110: Invalid token. Typical reasons include the following:
  ///  App Certificate is enabled in Agora Console, but the code still uses App ID for authentication. Once App Certificate is enabled for a project, you must use token-based authentication.
  ///  The uid used to generate the token is not the same as the uid used to join the channel. Deprecated: This enumerator is deprecated. Use connectionChangedInvalidToken (8) in the onConnectionStateChanged callback instead.
  @JsonValue(110)
  errInvalidToken,

  /// 111: The network connection is interrupted. The SDK triggers this callback when it loses connection with the server for more than four seconds after the connection is established.
  @JsonValue(111)
  errConnectionInterrupted,

  /// 112: The network connection is lost. Occurs when the SDK cannot reconnect to Agora's edge server 10 seconds after its connection to the server is interrupted.
  @JsonValue(112)
  errConnectionLost,

  /// 113: The user is not in the channel when calling the sendStreamMessage method.
  @JsonValue(113)
  errNotInChannel,

  /// 114: The data size exceeds 1 KB when calling the sendStreamMessage method.
  @JsonValue(114)
  errSizeTooLarge,

  /// 115: The data bitrate exceeds 6 KB/s when calling the sendStreamMessage method.
  @JsonValue(115)
  errBitrateLimit,

  /// 116: More than five data streams are created when calling the createDataStream method.
  @JsonValue(116)
  errTooManyDataStreams,

  /// 117: The data stream transmission times out.
  @JsonValue(117)
  errStreamMessageTimeout,

  /// 119: Switching roles fails, try rejoining the channel.
  @JsonValue(119)
  errSetClientRoleNotAuthorized,

  /// 120: Media streams decryption fails. The user might use an incorrect password to join the channel. Check the entered password, or tell the user to try rejoining the channel.
  @JsonValue(120)
  errDecryptionFailed,

  /// 121: The user ID is invalid.
  @JsonValue(121)
  errInvalidUserId,

  /// 122: Data streams decryption fails. The user might use an incorrect password to join the channel. Check the entered password, or tell the user to try rejoining the channel.
  @JsonValue(122)
  errDatastreamDecryptionFailed,

  /// 123: The user is banned from the server.
  @JsonValue(123)
  errClientIsBannedByServer,

  /// 130: The SDK does not support pushing encrypted streams to CDN.
  @JsonValue(130)
  errEncryptedStreamNotAllowedPublish,

  /// @nodoc
  @JsonValue(131)
  errLicenseCredentialInvalid,

  /// 134: The user account is invalid, possibly because it contains invalid parameters.
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

  /// @nodoc
  @JsonValue(200)
  errPcmsendFormat,

  /// @nodoc
  @JsonValue(201)
  errPcmsendBufferoverflow,

  /// @nodoc
  @JsonValue(428)
  errLoginAlreadyLogin,

  /// 1001: The SDK fails to load the media engine.
  @JsonValue(1001)
  errLoadMediaEngine,

  /// 1005: A general error occurs (no specified reason). Check whether the audio device is already in use by another app, or try rejoining the channel.
  @JsonValue(1005)
  errAdmGeneralError,

  /// 1008: An error occurs when initializing the playback device. Check whether the playback device is already in use by another app, or try rejoining the channel.
  @JsonValue(1008)
  errAdmInitPlayout,

  /// 1009: An error occurs when starting the playback device. Check the playback device.
  @JsonValue(1009)
  errAdmStartPlayout,

  /// 1010: An error occurs when stopping the playback device.
  @JsonValue(1010)
  errAdmStopPlayout,

  /// 1011: An error occurs when initializing the recording device. Check the recording device, or try rejoining the channel.
  @JsonValue(1011)
  errAdmInitRecording,

  /// 1012: An error occurs when starting the recording device. Check the recording device.
  @JsonValue(1012)
  errAdmStartRecording,

  /// 1013: An error occurs when stopping the recording device.
  @JsonValue(1013)
  errAdmStopRecording,

  /// 1501: Permission to access the camera is not granted. Check whether permission to access the camera permission is granted.
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

/// The interface class.
@JsonEnum(alwaysCreate: true)
enum InterfaceIdType {
  /// 1: The AudioDeviceManager interface class.
  @JsonValue(1)
  agoraIidAudioDeviceManager,

  /// 2: The VideoDeviceManager interface class.
  @JsonValue(2)
  agoraIidVideoDeviceManager,

  /// This interface class is deprecated.
  @JsonValue(3)
  agoraIidParameterEngine,

  /// 4: The MediaEngine interface class.
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

  /// @nodoc
  @JsonValue(8)
  agoraIidSignalingEngine,

  /// @nodoc
  @JsonValue(9)
  agoraIidMediaEngineRegulator,

  /// @nodoc
  @JsonValue(11)
  agoraIidLocalSpatialAudio,

  /// @nodoc
  @JsonValue(13)
  agoraIidStateSync,

  /// @nodoc
  @JsonValue(14)
  agoraIidMetaService,

  /// @nodoc
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

  /// 7: Users cannot detect the network quality (not in use).
  @JsonValue(7)
  qualityUnsupported,

  /// 8: Detecting the network quality.
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

/// The video frame rate.
@JsonEnum(alwaysCreate: true)
enum FrameRate {
  /// 1: 1 fps
  @JsonValue(1)
  frameRateFps1,

  /// 7: 7 fps
  @JsonValue(7)
  frameRateFps7,

  /// 10: 10 fps
  @JsonValue(10)
  frameRateFps10,

  /// 15: 15 fps
  @JsonValue(15)
  frameRateFps15,

  /// 24: 24 fps
  @JsonValue(24)
  frameRateFps24,

  /// 30: 30 fps
  @JsonValue(30)
  frameRateFps30,

  /// 60: 60 fps For Windows and macOS only.
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

/// The video frame type.
@JsonEnum(alwaysCreate: true)
enum VideoFrameType {
  /// 0: A black frame.
  @JsonValue(0)
  videoFrameTypeBlankFrame,

  /// 3: Key frame.
  @JsonValue(3)
  videoFrameTypeKeyFrame,

  /// 4: Delta frame.
  @JsonValue(4)
  videoFrameTypeDeltaFrame,

  /// 5: The B frame.
  @JsonValue(5)
  videoFrameTypeBFrame,

  /// 6: A discarded frame.
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

/// Video output orientation mode.
@JsonEnum(alwaysCreate: true)
enum OrientationMode {
  /// 0: (Default) The output video always follows the orientation of the captured video. The receiver takes the rotational information passed on from the video encoder. This mode applies to scenarios where video orientation can be adjusted on the receiver.
  ///  If the captured video is in landscape mode, the output video is in landscape mode.
  ///  If the captured video is in portrait mode, the output video is in portrait mode.
  @JsonValue(0)
  orientationModeAdaptive,

  /// 1: In this mode, the SDK always outputs videos in landscape (horizontal) mode. If the captured video is in portrait mode, the video encoder crops it to fit the output. Applies to situations where the receiving end cannot process the rotational information. For example, CDN live streaming.
  @JsonValue(1)
  orientationModeFixedLandscape,

  /// 2: In this mode, the SDK always outputs video in portrait (portrait) mode. If the captured video is in landscape mode, the video encoder crops it to fit the output. Applies to situations where the receiving end cannot process the rotational information. For example, CDN live streaming.
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

/// Video degradation preferences when the bandwidth is a constraint.
@JsonEnum(alwaysCreate: true)
enum DegradationPreference {
  /// 0: (Default) Prefers to reduce the video frame rate while maintaining video resolution during video encoding under limited bandwidth. This degradation preference is suitable for scenarios where video quality is prioritized.
  @JsonValue(0)
  maintainQuality,

  /// 1: Reduces the video resolution while maintaining the video frame rate during video encoding under limited bandwidth. This degradation preference is suitable for scenarios where smoothness is prioritized and video quality is allowed to be reduced.
  @JsonValue(1)
  maintainFramerate,

  /// 2: Reduces the video frame rate and video resolution simultaneously during video encoding under limited bandwidth. The maintainBalanced has a lower reduction than maintainQuality and maintainFramerate, and this preference is suitable for scenarios where both smoothness and video quality are a priority. The resolution of the video sent may change, so remote users need to handle this issue. See onVideoSizeChanged.
  @JsonValue(2)
  maintainBalanced,

  /// 3: Reduces the video frame rate while maintaining the video resolution during video encoding under limited bandwidth. This degradation preference is suitable for scenarios where video quality is prioritized.
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

/// The video dimension.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoDimensions {
  /// @nodoc
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

/// The highest frame rate supported by the screen sharing device.
@JsonEnum(alwaysCreate: true)
enum ScreenCaptureFramerateCapability {
  /// 0: The device supports the frame rate of up to 15 fps.
  @JsonValue(0)
  screenCaptureFramerateCapability15Fps,

  /// 1: The device supports the frame rate of up to 30 fps.
  @JsonValue(1)
  screenCaptureFramerateCapability30Fps,

  /// 2: The device supports the frame rate of up to 60 fps.
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

/// The level of the codec capability.
@JsonEnum(alwaysCreate: true)
enum VideoCodecCapabilityLevel {
  /// -1: Unsupported video type. Currently, only H.264 and H.265 formats are supported. If the video is in another format, this value will be returned.
  @JsonValue(-1)
  codecCapabilityLevelUnspecified,

  /// 5: Supports encoding and decoding videos up to 1080p and 30 fps.
  @JsonValue(5)
  codecCapabilityLevelBasicSupport,

  /// 10: Supports encoding and decoding videos up to1080p and 30 fps.
  @JsonValue(10)
  codecCapabilityLevel1080p30fps,

  /// 20: Support encoding and decoding videos up to 1080p and 60 fps.
  @JsonValue(20)
  codecCapabilityLevel1080p60fps,

  /// 30: Support encoding and decoding videos up to 4K and 30 fps.
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

/// Video codec types.
@JsonEnum(alwaysCreate: true)
enum VideoCodecType {
  /// 0: (Default) Unspecified codec format. The SDK automatically matches the appropriate codec format based on the current video stream's resolution and device performance.
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

  /// 6: Generic. This type is used for transmitting raw video data, such as encrypted video frames. The SDK returns this type of video frames in callbacks, and you need to decode and render the frames yourself.
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

  /// 20: Generic JPEG. This type consumes minimum computing resources and applies to IoT devices.
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

/// The camera focal length types.
///
/// This enumeration class applies to Android and iOS only.
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

  /// 3: (For iOS only) Telephoto lens.
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
class SenderOptions {
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

  /// @nodoc
  Map<String, dynamic> toJson() => _$SenderOptionsToJson(this);
}

/// The codec type of audio.
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

/// The adaptation mode of the watermark.
@JsonEnum(alwaysCreate: true)
enum WatermarkFitMode {
  /// Use the positionInLandscapeMode and positionInPortraitMode values you set in WatermarkOptions. The settings in WatermarkRatio are invalid.
  @JsonValue(0)
  fitModeCoverPosition,

  /// Use the value you set in WatermarkRatio. The settings in positionInLandscapeMode and positionInPortraitMode in WatermarkOptions are invalid.
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
class EncodedAudioFrameAdvancedSettings {
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

  /// @nodoc
  Map<String, dynamic> toJson() =>
      _$EncodedAudioFrameAdvancedSettingsToJson(this);
}

/// Audio information after encoding.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class EncodedAudioFrameInfo {
  /// @nodoc
  const EncodedAudioFrameInfo(
      {this.codec,
      this.sampleRateHz,
      this.samplesPerChannel,
      this.numberOfChannels,
      this.advancedSettings,
      this.captureTimeMs});

  /// Audio Codec type: AudioCodecType.
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

  /// This function is currently not supported.
  @JsonKey(name: 'advancedSettings')
  final EncodedAudioFrameAdvancedSettings? advancedSettings;

  /// The Unix timestamp (ms) for capturing the external encoded video frames.
  @JsonKey(name: 'captureTimeMs')
  final int? captureTimeMs;

  /// @nodoc
  factory EncodedAudioFrameInfo.fromJson(Map<String, dynamic> json) =>
      _$EncodedAudioFrameInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$EncodedAudioFrameInfoToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioPcmDataInfo {
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

/// Video subscription options.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoSubscriptionOptions {
  /// @nodoc
  const VideoSubscriptionOptions({this.type, this.encodedFrameOnly});

  /// The video stream type that you want to subscribe to. The default value is videoStreamHigh, indicating that the high-quality video streams are subscribed. See VideoStreamType.
  @JsonKey(name: 'type')
  final VideoStreamType? type;

  /// Whether to subscribe to encoded video frames only: true : Subscribe to the encoded video data (structured data) only; the SDK does not decode or render raw video data. false : (Default) Subscribe to both raw video data and encoded video data.
  @JsonKey(name: 'encodedFrameOnly')
  final bool? encodedFrameOnly;

  /// @nodoc
  factory VideoSubscriptionOptions.fromJson(Map<String, dynamic> json) =>
      _$VideoSubscriptionOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$VideoSubscriptionOptionsToJson(this);
}

/// The maximum length of the user account.
@JsonEnum(alwaysCreate: true)
enum MaxUserAccountLengthType {
  /// The maximum length of the user account is 256 bytes.
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

/// Information about externally encoded video frames.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class EncodedVideoFrameInfo {
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

  /// The user ID to push the externally encoded video frame.
  @JsonKey(name: 'uid')
  final int? uid;

  /// The codec type of the local video stream. See VideoCodecType. The default value is videoCodecH264 (2).
  @JsonKey(name: 'codecType')
  final VideoCodecType? codecType;

  /// Width (pixel) of the video frame.
  @JsonKey(name: 'width')
  final int? width;

  /// Height (pixel) of the video frame.
  @JsonKey(name: 'height')
  final int? height;

  /// The number of video frames per second. When this parameter is not 0, you can use it to calculate the Unix timestamp of externally encoded video frames.
  @JsonKey(name: 'framesPerSecond')
  final int? framesPerSecond;

  /// The video frame type. See VideoFrameType.
  @JsonKey(name: 'frameType')
  final VideoFrameType? frameType;

  /// The rotation information of the video frame. See VideoOrientation.
  @JsonKey(name: 'rotation')
  final VideoOrientation? rotation;

  /// Reserved for future use.
  @JsonKey(name: 'trackId')
  final int? trackId;

  /// The Unix timestamp (ms) for capturing the external encoded video frames.
  @JsonKey(name: 'captureTimeMs')
  final int? captureTimeMs;

  /// @nodoc
  @JsonKey(name: 'decodeTimeMs')
  final int? decodeTimeMs;

  /// The type of video streams. See VideoStreamType.
  @JsonKey(name: 'streamType')
  final VideoStreamType? streamType;

  /// @nodoc
  @JsonKey(name: 'presentationMs')
  final int? presentationMs;

  /// @nodoc
  factory EncodedVideoFrameInfo.fromJson(Map<String, dynamic> json) =>
      _$EncodedVideoFrameInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$EncodedVideoFrameInfoToJson(this);
}

/// Compression preference for video encoding.
@JsonEnum(alwaysCreate: true)
enum CompressionPreference {
  /// 0: Low latency preference. The SDK compresses video frames to reduce latency. This preference is suitable for scenarios where smoothness is prioritized and reduced video quality is acceptable.
  @JsonValue(0)
  preferLowLatency,

  /// 1: (Default) High quality preference. The SDK compresses video frames while maintaining video quality. This preference is suitable for scenarios where video quality is prioritized.
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
  /// -1: Adaptive preference. The SDK automatically selects the optimal encoding type for encoding based on factors such as platform and device type.
  @JsonValue(-1)
  preferAuto,

  /// 0: Software coding preference. The SDK prefers software encoders for video encoding.
  @JsonValue(0)
  preferSoftware,

  /// 1: Hardware encoding preference. The SDK prefers a hardware encoder for video encoding. When the device does not support hardware encoding, the SDK automatically uses software encoding and reports the currently used video encoder type through hwEncoderAccelerating in the onLocalVideoStats callback.
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
class AdvanceOptions {
  /// @nodoc
  const AdvanceOptions({this.encodingPreference, this.compressionPreference});

  /// Video encoder preference. See EncodingPreference.
  @JsonKey(name: 'encodingPreference')
  final EncodingPreference? encodingPreference;

  /// Compression preference for video encoding. See CompressionPreference.
  @JsonKey(name: 'compressionPreference')
  final CompressionPreference? compressionPreference;

  /// @nodoc
  factory AdvanceOptions.fromJson(Map<String, dynamic> json) =>
      _$AdvanceOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AdvanceOptionsToJson(this);
}

/// Video mirror mode.
@JsonEnum(alwaysCreate: true)
enum VideoMirrorModeType {
  /// 0: The SDK determines the mirror mode.
  ///  For the mirror mode of the local video view: If you use a front camera, the SDK enables the mirror mode by default; if you use a rear camera, the SDK disables the mirror mode by default.
  ///  For the remote user: The mirror mode is disabled by default.
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

/// The bit mask of the codec type.
@JsonEnum(alwaysCreate: true)
enum CodecCapMask {
  /// (0): The device does not support encoding or decoding.
  @JsonValue(0)
  codecCapMaskNone,

  /// (1 << 0): The device supports hardware decoding.
  @JsonValue(1 << 0)
  codecCapMaskHwDec,

  /// (1 << 1): The device supports hardware encoding.
  @JsonValue(1 << 1)
  codecCapMaskHwEnc,

  /// (1 << 2): The device supports software decoding.
  @JsonValue(1 << 2)
  codecCapMaskSwDec,

  /// (1 << 3): The device supports software ecoding.
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

/// The level of the codec capability.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CodecCapLevels {
  /// @nodoc
  const CodecCapLevels({this.hwDecodingLevel, this.swDecodingLevel});

  /// Hardware decoding capability level, which represents the device's ability to perform hardware decoding on videos of different quality. See VideoCodecCapabilityLevel.
  @JsonKey(name: 'hwDecodingLevel')
  final VideoCodecCapabilityLevel? hwDecodingLevel;

  /// Software decoding capability level, which represents the device's ability to perform software decoding on videos of different quality. See VideoCodecCapabilityLevel.
  @JsonKey(name: 'swDecodingLevel')
  final VideoCodecCapabilityLevel? swDecodingLevel;

  /// @nodoc
  factory CodecCapLevels.fromJson(Map<String, dynamic> json) =>
      _$CodecCapLevelsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$CodecCapLevelsToJson(this);
}

/// The codec capability of the SDK.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CodecCapInfo {
  /// @nodoc
  const CodecCapInfo({this.codecType, this.codecCapMask, this.codecLevels});

  /// The video codec types. See VideoCodecType.
  @JsonKey(name: 'codecType')
  final VideoCodecType? codecType;

  /// Bit mask of the codec types in SDK. See CodecCapMask.
  @JsonKey(name: 'codecCapMask')
  final int? codecCapMask;

  /// Codec capability of the SDK. See CodecCapLevels.
  @JsonKey(name: 'codecLevels')
  final CodecCapLevels? codecLevels;

  /// @nodoc
  factory CodecCapInfo.fromJson(Map<String, dynamic> json) =>
      _$CodecCapInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$CodecCapInfoToJson(this);
}

/// Focal length information supported by the camera, including the camera direction and focal length type.
///
/// This enumeration class applies to Android and iOS only.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class FocalLengthInfo {
  /// @nodoc
  const FocalLengthInfo({this.cameraDirection, this.focalLengthType});

  /// The camera direction. See CameraDirection.
  @JsonKey(name: 'cameraDirection')
  final int? cameraDirection;

  /// The focal length type. See CameraFocalLengthType.
  @JsonKey(name: 'focalLengthType')
  final CameraFocalLengthType? focalLengthType;

  /// @nodoc
  factory FocalLengthInfo.fromJson(Map<String, dynamic> json) =>
      _$FocalLengthInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$FocalLengthInfoToJson(this);
}

/// Video encoder configurations.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoEncoderConfiguration {
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

  /// The codec type of the local video stream. See VideoCodecType.
  @JsonKey(name: 'codecType')
  final VideoCodecType? codecType;

  /// The dimensions of the encoded video (px). See VideoDimensions. This parameter measures the video encoding quality in the format of length × width. The default value is 960 × 540. You can set a custom value.
  @JsonKey(name: 'dimensions')
  final VideoDimensions? dimensions;

  /// The frame rate (fps) of the encoding video frame. The default value is 15. See FrameRate.
  @JsonKey(name: 'frameRate')
  final int? frameRate;

  /// The encoding bitrate (Kbps) of the video. This parameter does not need to be set; keeping the default value standardBitrate is sufficient. The SDK automatically matches the most suitable bitrate based on the video resolution and frame rate you have set. For the correspondence between video resolution and frame rate, see. standardBitrate (0): (Recommended) Standard bitrate mode. compatibleBitrate (-1): Adaptive bitrate mode. In general, Agora suggests that you do not use this value.
  @JsonKey(name: 'bitrate')
  final int? bitrate;

  /// The minimum encoding bitrate (Kbps) of the video. The SDK automatically adjusts the encoding bitrate to adapt to the network conditions. Using a value greater than the default value forces the video encoder to output high-quality images but may cause more packet loss and sacrifice the smoothness of the video transmission. Unless you have special requirements for image quality, Agora does not recommend changing this value. This parameter only applies to the interactive streaming profile.
  @JsonKey(name: 'minBitrate')
  final int? minBitrate;

  /// The orientation mode of the encoded video. See OrientationMode.
  @JsonKey(name: 'orientationMode')
  final OrientationMode? orientationMode;

  /// Video degradation preference under limited bandwidth. See DegradationPreference.
  @JsonKey(name: 'degradationPreference')
  final DegradationPreference? degradationPreference;

  /// Sets the mirror mode of the published local video stream. It only affects the video that the remote user sees. See VideoMirrorModeType. By default, the video is not mirrored.
  @JsonKey(name: 'mirrorMode')
  final VideoMirrorModeType? mirrorMode;

  /// Advanced options for video encoding. See AdvanceOptions.
  @JsonKey(name: 'advanceOptions')
  final AdvanceOptions? advanceOptions;

  /// @nodoc
  factory VideoEncoderConfiguration.fromJson(Map<String, dynamic> json) =>
      _$VideoEncoderConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$VideoEncoderConfigurationToJson(this);
}

/// The configurations for the data stream.
///
/// The following table shows the SDK behaviors under different parameter settings:
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class DataStreamConfig {
  /// @nodoc
  const DataStreamConfig({this.syncWithAudio, this.ordered});

  /// Whether to synchronize the data packet with the published audio packet. true : Synchronize the data packet with the audio packet. This setting is suitable for special scenarios such as lyrics synchronization. false : Do not synchronize the data packet with the audio packet. This setting is suitable for scenarios where data packets need to arrive at the receiving end immediately. When you set the data packet to synchronize with the audio, then if the data packet delay is within the audio delay, the SDK triggers the onStreamMessage callback when the synchronized audio packet is played out.
  @JsonKey(name: 'syncWithAudio')
  final bool? syncWithAudio;

  /// Whether the SDK guarantees that the receiver receives the data in the sent order. true : Guarantee that the receiver receives the data in the sent order. false : Do not guarantee that the receiver receives the data in the sent order. Do not set this parameter as true if you need the receiver to receive the data packet immediately.
  @JsonKey(name: 'ordered')
  final bool? ordered;

  /// @nodoc
  factory DataStreamConfig.fromJson(Map<String, dynamic> json) =>
      _$DataStreamConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$DataStreamConfigToJson(this);
}

/// The mode in which the video stream is sent.
@JsonEnum(alwaysCreate: true)
enum SimulcastStreamMode {
  /// -1: By default, do not send the low-quality video stream until a subscription request for the low-quality video stream is received from the receiving end, then automatically start sending low-quality video stream.
  @JsonValue(-1)
  autoSimulcastStream,

  /// 0: Never send low-quality video stream.
  @JsonValue(0)
  disableSimulcastStream,

  /// 1: Always send low-quality video stream.
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

/// The configuration of the low-quality video stream.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SimulcastStreamConfig {
  /// @nodoc
  const SimulcastStreamConfig({this.dimensions, this.kBitrate, this.framerate});

  /// The video dimension. See VideoDimensions. The default value is 50% of the high-quality video stream.
  @JsonKey(name: 'dimensions')
  final VideoDimensions? dimensions;

  /// Video receive bitrate (Kbps), represented by an instantaneous value. This parameter does not need to be set. The SDK automatically matches the most suitable bitrate based on the video resolution and frame rate you set.
  @JsonKey(name: 'kBitrate')
  final int? kBitrate;

  /// The frame rate (fps) of the local video. The default value is 5.
  @JsonKey(name: 'framerate')
  final int? framerate;

  /// @nodoc
  factory SimulcastStreamConfig.fromJson(Map<String, dynamic> json) =>
      _$SimulcastStreamConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$SimulcastStreamConfigToJson(this);
}

/// The location of the target area relative to the screen or window. If you do not set this parameter, the SDK selects the whole screen or window.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Rectangle {
  /// @nodoc
  const Rectangle({this.x, this.y, this.width, this.height});

  /// The horizontal offset from the top-left corner.
  @JsonKey(name: 'x')
  final int? x;

  /// The vertical offset from the top-left corner.
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
///
/// The position and size of the watermark on the screen are determined by xRatio, yRatio, and widthRatio :
///  (xRatio, yRatio) refers to the coordinates of the upper left corner of the watermark, which determines the distance from the upper left corner of the watermark to the upper left corner of the screen.
///  The widthRatio determines the width of the watermark.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class WatermarkRatio {
  /// @nodoc
  const WatermarkRatio({this.xRatio, this.yRatio, this.widthRatio});

  /// The x-coordinate of the upper left corner of the watermark. The horizontal position relative to the origin, where the upper left corner of the screen is the origin, and the x-coordinate is the upper left corner of the watermark. The value range is [0.0,1.0], and the default value is 0.
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
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class WatermarkOptions {
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

  /// When the adaptation mode of the watermark is fitModeCoverPosition, it is used to set the area of the watermark image in landscape mode. See Rectangle.
  @JsonKey(name: 'positionInLandscapeMode')
  final Rectangle? positionInLandscapeMode;

  /// When the adaptation mode of the watermark is fitModeCoverPosition, it is used to set the area of the watermark image in portrait mode. See Rectangle.
  @JsonKey(name: 'positionInPortraitMode')
  final Rectangle? positionInPortraitMode;

  /// When the watermark adaptation mode is fitModeUseImageRatio, this parameter is used to set the watermark coordinates. See WatermarkRatio.
  @JsonKey(name: 'watermarkRatio')
  final WatermarkRatio? watermarkRatio;

  /// The adaptation mode of the watermark. See WatermarkFitMode.
  @JsonKey(name: 'mode')
  final WatermarkFitMode? mode;

  /// @nodoc
  factory WatermarkOptions.fromJson(Map<String, dynamic> json) =>
      _$WatermarkOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$WatermarkOptionsToJson(this);
}

/// Statistics of a call session.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RtcStats {
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

  /// Call duration of the local user in seconds, represented by an aggregate value.
  @JsonKey(name: 'duration')
  final int? duration;

  /// The number of bytes sent.
  @JsonKey(name: 'txBytes')
  final int? txBytes;

  /// The number of bytes received.
  @JsonKey(name: 'rxBytes')
  final int? rxBytes;

  /// The total number of audio bytes sent, represented by an aggregate value.
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

  /// The actual bitrate (Kbps) while sending the local video stream.
  @JsonKey(name: 'txKBitRate')
  final int? txKBitRate;

  /// The receiving bitrate (Kbps).
  @JsonKey(name: 'rxKBitRate')
  final int? rxKBitRate;

  /// The bitrate (Kbps) of receiving the audio.
  @JsonKey(name: 'rxAudioKBitRate')
  final int? rxAudioKBitRate;

  /// The bitrate (Kbps) of sending the audio packet.
  @JsonKey(name: 'txAudioKBitRate')
  final int? txAudioKBitRate;

  /// The bitrate (Kbps) of receiving the video.
  @JsonKey(name: 'rxVideoKBitRate')
  final int? rxVideoKBitRate;

  /// The bitrate (Kbps) of sending the video.
  @JsonKey(name: 'txVideoKBitRate')
  final int? txVideoKBitRate;

  /// The client-to-server delay (milliseconds).
  @JsonKey(name: 'lastmileDelay')
  final int? lastmileDelay;

  /// The number of users in the channel.
  @JsonKey(name: 'userCount')
  final int? userCount;

  /// Application CPU usage (%).
  ///  The value of cpuAppUsage is always reported as 0 in the onLeaveChannel callback.
  ///  As of Android 8.1, you cannot get the CPU usage from this attribute due to system limitations.
  @JsonKey(name: 'cpuAppUsage')
  final double? cpuAppUsage;

  /// The system CPU usage (%). For Windows, in the multi-kernel environment, this member represents the average CPU usage. The value = (100 - System Idle Progress in Task Manager)/100.
  ///  The value of cpuTotalUsage is always reported as 0 in the onLeaveChannel callback.
  @JsonKey(name: 'cpuTotalUsage')
  final double? cpuTotalUsage;

  /// The round-trip time delay (ms) from the client to the local router. This property is disabled on devices running iOS 14 or later, and enabled on devices running versions earlier than iOS 14 by default. To enable this property on devices running iOS 14 or later,. On Android, to get gatewayRtt, ensure that you add the android.permission.ACCESS_WIFI_STATE permission after </application> in the AndroidManifest.xml file in your project.
  @JsonKey(name: 'gatewayRtt')
  final int? gatewayRtt;

  /// The memory ratio occupied by the app (%). This value is for reference only. Due to system limitations, you may not get this value.
  @JsonKey(name: 'memoryAppUsageRatio')
  final double? memoryAppUsageRatio;

  /// The memory occupied by the system (%). This value is for reference only. Due to system limitations, you may not get this value.
  @JsonKey(name: 'memoryTotalUsageRatio')
  final double? memoryTotalUsageRatio;

  /// The memory size occupied by the app (KB). This value is for reference only. Due to system limitations, you may not get this value.
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

/// The latency level of an audience member in interactive live streaming. This enum takes effect only when the user role is set to clientRoleAudience .
@JsonEnum(alwaysCreate: true)
enum AudienceLatencyLevelType {
  /// 1: Low latency.
  @JsonValue(1)
  audienceLatencyLevelLowLatency,

  /// 2: (Default) Ultra low latency.
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

/// Setting of user role properties.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ClientRoleOptions {
  /// @nodoc
  const ClientRoleOptions({this.audienceLatencyLevel});

  /// The latency level of an audience member in interactive live streaming. See AudienceLatencyLevelType.
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

  /// 1: The QoE of the local user is poor.
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

/// Reasons why the QoE of the local user when receiving a remote audio stream is poor.
@JsonEnum(alwaysCreate: true)
enum ExperiencePoorReason {
  /// 0: No reason, indicating a good QoE of the local user.
  @JsonValue(0)
  experienceReasonNone,

  /// 1: The remote user's network quality is poor.
  @JsonValue(1)
  remoteNetworkQualityPoor,

  /// 2: The local user's network quality is poor.
  @JsonValue(2)
  localNetworkQualityPoor,

  /// 4: The local user's Wi-Fi or mobile network signal is weak.
  @JsonValue(4)
  wirelessSignalPoor,

  /// 8: The local user enables both Wi-Fi and bluetooth, and their signals interfere with each other. As a result, audio transmission quality is undermined.
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

/// AI noise suppression modes.
@JsonEnum(alwaysCreate: true)
enum AudioAinsMode {
  /// 0: (Default) Balance mode. This mode allows for a balanced performance on noice suppression and time delay.
  @JsonValue(0)
  ainsModeBalanced,

  /// 1: Aggressive mode. In scenarios where high performance on noise suppression is required, such as live streaming outdoor events, this mode reduces nosie more dramatically, but may sometimes affect the original character of the audio.
  @JsonValue(1)
  ainsModeAggressive,

  /// 2: Aggressive mode with low latency. The noise suppression delay of this mode is about only half of that of the balance and aggressive modes. It is suitable for scenarios that have high requirements on noise suppression with low latency, such as sing together online in real time.
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

/// The audio profile.
@JsonEnum(alwaysCreate: true)
enum AudioProfileType {
  /// 0: The default audio profile.
  ///  For the interactive streaming profile: A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 64 Kbps.
  ///  For the communication profile:
  ///  Windows: A sample rate of 16 kHz, audio encoding, mono, and a bitrate of up to 16 Kbps. Android/macOS/iOS: A sample rate of 32 kHz, audio encoding, mono, and a bitrate of up to 18 Kbps.
  @JsonValue(0)
  audioProfileDefault,

  /// 1: A sample rate of 32 kHz, audio encoding, mono, and a bitrate of up to 18 Kbps.
  @JsonValue(1)
  audioProfileSpeechStandard,

  /// 2: A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 64 Kbps.
  @JsonValue(2)
  audioProfileMusicStandard,

  /// 3: A sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 80 Kbps. To implement stereo audio, you also need to call setAdvancedAudioOptions and set audioProcessingChannels to audioProcessingStereo in AdvancedAudioOptions.
  @JsonValue(3)
  audioProfileMusicStandardStereo,

  /// 4: A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 96 Kbps.
  @JsonValue(4)
  audioProfileMusicHighQuality,

  /// 5: A sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 128 Kbps. To implement stereo audio, you also need to call setAdvancedAudioOptions and set audioProcessingChannels to audioProcessingStereo in AdvancedAudioOptions.
  @JsonValue(5)
  audioProfileMusicHighQualityStereo,

  /// 6: A sample rate of 16 kHz, audio encoding, mono, and Acoustic Echo Cancellation (AES) enabled.
  @JsonValue(6)
  audioProfileIot,

  /// Enumerator boundary.
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

/// The audio scenarios.
@JsonEnum(alwaysCreate: true)
enum AudioScenarioType {
  /// 0: (Default) Automatic scenario match, where the SDK chooses the appropriate audio quality according to the user role and audio route.
  @JsonValue(0)
  audioScenarioDefault,

  /// 3: High-quality audio scenario, where users mainly play music. For example, instrument tutoring.
  @JsonValue(3)
  audioScenarioGameStreaming,

  /// 5: Chatroom scenario, where users need to frequently switch the user role or mute and unmute the microphone. For example, education scenarios. In this scenario, audience members receive a pop-up window to request permission of using microphones.
  @JsonValue(5)
  audioScenarioChatroom,

  /// 7: Real-time chorus scenario, where users have good network conditions and require ultra-low latency.
  @JsonValue(7)
  audioScenarioChorus,

  /// 8: Meeting scenario that mainly contains the human voice.
  @JsonValue(8)
  audioScenarioMeeting,

  /// The number of enumerations.
  @JsonValue(9)
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

/// The format of the video frame.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoFormat {
  /// @nodoc
  const VideoFormat({this.width, this.height, this.fps});

  /// The width (px) of the video frame. The default value is 960.
  @JsonKey(name: 'width')
  final int? width;

  /// The height (px) of the video frame. The default value is 540.
  @JsonKey(name: 'height')
  final int? height;

  /// The video frame rate (fps). The default value is 15.
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

/// The screen sharing scenario.
@JsonEnum(alwaysCreate: true)
enum ScreenScenarioType {
  /// 1: (Default) Document. This scenario prioritizes the video quality of screen sharing and reduces the latency of the shared video for the receiver. If you share documents, slides, and tables, you can set this scenario.
  @JsonValue(1)
  screenScenarioDocument,

  /// 2: Game. This scenario prioritizes the smoothness of screen sharing. If you share games, you can set this scenario.
  @JsonValue(2)
  screenScenarioGaming,

  /// 3: Video. This scenario prioritizes the smoothness of screen sharing. If you share movies or live videos, you can set this scenario.
  @JsonValue(3)
  screenScenarioVideo,

  /// 4: Remote control. This scenario prioritizes the video quality of screen sharing and reduces the latency of the shared video for the receiver. If you share the device desktop being remotely controlled, you can set this scenario.
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

/// The video application scenarios.
@JsonEnum(alwaysCreate: true)
enum VideoApplicationScenarioType {
  /// 0: (Default) The general scenario.
  @JsonValue(0)
  applicationScenarioGeneral,

  /// If set to applicationScenarioMeeting (1), the SDK automatically enables the following strategies:
  ///  In meeting scenarios where low-quality video streams are required to have a high bitrate, the SDK automatically enables multiple technologies used to deal with network congestions, to enhance the performance of the low-quality streams and to ensure the smooth reception by subscribers.
  ///  The SDK monitors the number of subscribers to the high-quality video stream in real time and dynamically adjusts its configuration based on the number of subscribers.
  ///  If nobody subscribers to the high-quality stream, the SDK automatically reduces its bitrate and frame rate to save upstream bandwidth.
  ///  If someone subscribes to the high-quality stream, the SDK resets the high-quality stream to the VideoEncoderConfiguration configuration used in the most recent calling of setVideoEncoderConfiguration. If no configuration has been set by the user previously, the following values are used:
  ///  Resolution: (Windows and macOS) 1280 × 720; (Android and iOS) 960 × 540
  ///  Frame rate: 15 fps
  ///  Bitrate: (Windows and macOS) 1600 Kbps; (Android and iOS) 1000 Kbps
  ///  The SDK monitors the number of subscribers to the low-quality video stream in real time and dynamically enables or disables it based on the number of subscribers. If the user has called setDualStreamMode to set that never send low-quality video stream (disableSimulcastStream), the dynamic adjustment of the low-quality stream in meeting scenarios will not take effect.
  ///  If nobody subscribes to the low-quality stream, the SDK automatically disables it to save upstream bandwidth.
  ///  If someone subscribes to the low-quality stream, the SDK enables the low-quality stream and resets it to the SimulcastStreamConfig configuration used in the most recent calling of setDualStreamMode. If no configuration has been set by the user previously, the following values are used:
  ///  Resolution: 480 × 272
  ///  Frame rate: 15 fps
  ///  Bitrate: 500 Kbps 1: The meeting scenario.
  @JsonValue(1)
  applicationScenarioMeeting,
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

/// The brightness level of the video image captured by the local camera.
@JsonEnum(alwaysCreate: true)
enum CaptureBrightnessLevelType {
  /// -1: The SDK does not detect the brightness level of the video image. Wait a few seconds to get the brightness level from captureBrightnessLevel in the next callback.
  @JsonValue(-1)
  captureBrightnessLevelInvalid,

  /// 0: The brightness level of the video image is normal.
  @JsonValue(0)
  captureBrightnessLevelNormal,

  /// 1: The brightness level of the video image is too bright.
  @JsonValue(1)
  captureBrightnessLevelBright,

  /// 2: The brightness level of the video image is too dark.
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

/// Camera stabilization modes.
///
/// The camera stabilization effect increases in the order of 1 < 2 < 3, and the latency will also increase accordingly.
@JsonEnum(alwaysCreate: true)
enum CameraStabilizationMode {
  /// -1: (Default) Camera stabilization mode off.
  @JsonValue(-1)
  cameraStabilizationModeOff,

  /// 0: Automatic camera stabilization. The system automatically selects a stabilization mode based on the status of the camera. However, the latency is relatively high in this mode, so it is recommended not to use this enumeration.
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

/// The state of the local audio.
@JsonEnum(alwaysCreate: true)
enum LocalAudioStreamState {
  /// 0: The local audio is in the initial state.
  @JsonValue(0)
  localAudioStreamStateStopped,

  /// 1: The local audio capturing device starts successfully.
  @JsonValue(1)
  localAudioStreamStateRecording,

  /// 2: The first audio frame encodes successfully.
  @JsonValue(2)
  localAudioStreamStateEncoding,

  /// 3: The local audio fails to start.
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

/// Reasons for local audio state changes.
@JsonEnum(alwaysCreate: true)
enum LocalAudioStreamReason {
  /// 0: The local audio is normal.
  @JsonValue(0)
  localAudioStreamReasonOk,

  /// 1: No specified reason for the local audio failure. Remind your users to try to rejoin the channel.
  @JsonValue(1)
  localAudioStreamReasonFailure,

  /// 2: No permission to use the local audio capturing device. Remind your users to grant permission. Deprecated: This enumerator is deprecated. Please use recordAudio in the onPermissionError callback instead.
  @JsonValue(2)
  localAudioStreamReasonDeviceNoPermission,

  /// 3: (Android and iOS only) The local audio capture device is already in use. Remind your users to check whether another application occupies the microphone. Local audio capture automatically resumes after the microphone is idle for about five seconds. You can also try to rejoin the channel after the microphone is idle.
  @JsonValue(3)
  localAudioStreamReasonDeviceBusy,

  /// 4: The local audio capture fails.
  @JsonValue(4)
  localAudioStreamReasonRecordFailure,

  /// 5: The local audio encoding fails.
  @JsonValue(5)
  localAudioStreamReasonEncodeFailure,

  /// 6: (Windows and macOS only) No local audio capture device. Remind your users to check whether the microphone is connected to the device properly in the control panel of the device or if the microphone is working properly.
  @JsonValue(6)
  localAudioStreamReasonNoRecordingDevice,

  /// 7: (Windows and macOS only) No local audio capture device. Remind your users to check whether the speaker is connected to the device properly in the control panel of the device or if the speaker is working properly.
  @JsonValue(7)
  localAudioStreamReasonNoPlayoutDevice,

  /// 8: (Android and iOS only) The local audio capture is interrupted by a system call, smart assistants, or alarm clock. Prompt your users to end the phone call, smart assistants, or alarm clock if the local audio capture is required.
  @JsonValue(8)
  localAudioStreamReasonInterrupted,

  /// 9: (Windows only) The ID of the local audio-capture device is invalid. Prompt the user to check the audio capture device ID.
  @JsonValue(9)
  localAudioStreamReasonRecordInvalidId,

  /// 10: (Windows only) The ID of the local audio-playback device is invalid. Prompt the user to check the audio playback device ID.
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

/// Reasons for local video state changes.
@JsonEnum(alwaysCreate: true)
enum LocalVideoStreamReason {
  /// 0: The local video is normal.
  @JsonValue(0)
  localVideoStreamReasonOk,

  /// 1: No specified reason for the local video failure.
  @JsonValue(1)
  localVideoStreamReasonFailure,

  /// 2: No permission to use the local video capturing device. Prompt the user to grant permissions and rejoin the channel. Deprecated: This enumerator is deprecated. Please use camera in the onPermissionError callback instead.
  @JsonValue(2)
  localVideoStreamReasonDeviceNoPermission,

  /// 3: The local video capturing device is in use. Prompt the user to check if the camera is being used by another app, or try to rejoin the channel.
  @JsonValue(3)
  localVideoStreamReasonDeviceBusy,

  /// 4: The local video capture fails. Prompt the user to check whether the video capture device is working properly, whether the camera is used by another app, or try to rejoin the channel.
  @JsonValue(4)
  localVideoStreamReasonCaptureFailure,

  /// 5: The local video encoding fails.
  @JsonValue(5)
  localVideoStreamReasonCodecNotSupport,

  /// 6: (iOS only) The app is in the background. Prompt the user that video capture cannot be performed normally when the app is in the background.
  @JsonValue(6)
  localVideoStreamReasonCaptureInbackground,

  /// 7: (iOS only) The current app window is running in Slide Over, Split View, or Picture in Picture mode, and another app is occupying the camera. Prompt the user that the app cannot capture video properly when it is running in Slide Over, Split View, or Picture in Picture mode and another app is occupying the camera.
  @JsonValue(7)
  localVideoStreamReasonCaptureMultipleForegroundApps,

  /// 8: Fails to find a local video capture device. Remind the user to check whether the camera is connected to the device properly or the camera is working properly, and then to rejoin the channel.
  @JsonValue(8)
  localVideoStreamReasonDeviceNotFound,

  /// 9: (macOS only) The video capture device currently in use is disconnected (such as being unplugged).
  @JsonValue(9)
  localVideoStreamReasonDeviceDisconnected,

  /// 10: (macOS and Windows only) The SDK cannot find the video device in the video device list. Check whether the ID of the video device is valid.
  @JsonValue(10)
  localVideoStreamReasonDeviceInvalidId,

  /// 14: (Android only) Video capture is interrupted. Possible reasons include the following:
  ///  The camera is being used by another app. Prompt the user to check if the camera is being used by another app.
  ///  The current app has been switched to the background. You can use foreground services to notify the operating system and ensure that the app can still collect video when it switches to the background.
  @JsonValue(14)
  localVideoStreamReasonDeviceInterrupt,

  /// 15: (Android only) The video capture device encounters an error. Prompt the user to close and restart the camera to restore functionality. If this operation does not solve the problem, check if the camera has a hardware failure.
  @JsonValue(15)
  localVideoStreamReasonDeviceFatalError,

  /// 101: The current video capture device is unavailable due to excessive system pressure.
  @JsonValue(101)
  localVideoStreamReasonDeviceSystemPressure,

  /// 11: (macOS and Windows only) The shared window is minimized when you call the startScreenCaptureByWindowId method to share a window. The SDK cannot share a minimized window. Please prompt the user to unminimize the shared window.
  @JsonValue(11)
  localVideoStreamReasonScreenCaptureWindowMinimized,

  /// 12: (macOS and Windows only) The error code indicates that a window shared by the window ID has been closed or a full-screen window shared by the window ID has exited full-screen mode. After exiting full-screen mode, remote users cannot see the shared window. To prevent remote users from seeing a black screen, Agora recommends that you immediately stop screen sharing. Common scenarios reporting this error code:
  ///  The local user closes the shared window.
  ///  The local user shows some slides in full-screen mode first, and then shares the windows of the slides. After the user exits full-screen mode, the SDK reports this error code.
  ///  The local user watches a web video or reads a web document in full-screen mode first, and then shares the window of the web video or document. After the user exits full-screen mode, the SDK reports this error code.
  @JsonValue(12)
  localVideoStreamReasonScreenCaptureWindowClosed,

  /// 13: (Windows only) The window being shared is overlapped by another window, so the overlapped area is blacked out by the SDK during window sharing.
  @JsonValue(13)
  localVideoStreamReasonScreenCaptureWindowOccluded,

  /// @nodoc
  @JsonValue(20)
  localVideoStreamReasonScreenCaptureWindowNotSupported,

  /// @nodoc
  @JsonValue(21)
  localVideoStreamReasonScreenCaptureFailure,

  /// 22: (Windows and macOS only) No permission for screen capture.
  @JsonValue(22)
  localVideoStreamReasonScreenCaptureNoPermission,

  /// 24: (Windows only) An unexpected error occurred during screen sharing (possibly due to window blocking failure), resulting in decreased performance, but the screen sharing process itself was not affected.
  @JsonValue(24)
  localVideoStreamReasonScreenCaptureAutoFallback,

  /// 25: (Windows only) The window for the current screen capture is hidden and not visible on the current screen.
  @JsonValue(25)
  localVideoStreamReasonScreenCaptureWindowHidden,

  /// 26: (Windows only) The window for screen capture has been restored from hidden state.
  @JsonValue(26)
  localVideoStreamReasonScreenCaptureWindowRecoverFromHidden,

  /// 27: (macOS and Windows only) The window for screen capture has been restored from the minimized state.
  @JsonValue(27)
  localVideoStreamReasonScreenCaptureWindowRecoverFromMinimized,

  /// 28: (Windows only) Screen capture has been paused. Common scenarios reporting this error code: The current screen may have been switched to a secure desktop, such as a UAC dialog box or Winlogon desktop.
  @JsonValue(28)
  localVideoStreamReasonScreenCapturePaused,

  /// 29: (Windows only) Screen capture has resumed from paused state.
  @JsonValue(29)
  localVideoStreamReasonScreenCaptureResumed,
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

/// Remote audio states.
@JsonEnum(alwaysCreate: true)
enum RemoteAudioState {
  /// 0: The local audio is in the initial state. The SDK reports this state in the case of remoteAudioReasonLocalMuted, remoteAudioReasonRemoteMuted or remoteAudioReasonRemoteOffline.
  @JsonValue(0)
  remoteAudioStateStopped,

  /// 1: The first remote audio packet is received.
  @JsonValue(1)
  remoteAudioStateStarting,

  /// 2: The remote audio stream is decoded and plays normally. The SDK reports this state in the case of remoteAudioReasonNetworkRecovery, remoteAudioReasonLocalUnmuted or remoteAudioReasonRemoteUnmuted.
  @JsonValue(2)
  remoteAudioStateDecoding,

  /// 3: The remote audio is frozen. The SDK reports this state in the case of remoteAudioReasonNetworkCongestion.
  @JsonValue(3)
  remoteAudioStateFrozen,

  /// 4: The remote audio fails to start. The SDK reports this state in the case of remoteAudioReasonInternal.
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

/// The state of the remote video stream.
@JsonEnum(alwaysCreate: true)
enum RemoteVideoState {
  /// 0: The remote video is in the initial state. The SDK reports this state in the case of remoteVideoStateReasonLocalMuted, remoteVideoStateReasonRemoteMuted, or remoteVideoStateReasonRemoteOffline.
  @JsonValue(0)
  remoteVideoStateStopped,

  /// 1: The first remote video packet is received.
  @JsonValue(1)
  remoteVideoStateStarting,

  /// 2: The remote video stream is decoded and plays normally. The SDK reports this state in the case of remoteVideoStateReasonNetworkRecovery, remoteVideoStateReasonLocalUnmuted, remoteVideoStateReasonRemoteUnmuted, or remoteVideoStateReasonAudioFallbackRecovery.
  @JsonValue(2)
  remoteVideoStateDecoding,

  /// 3: The remote video is frozen. The SDK reports this state in the case of remoteVideoStateReasonNetworkCongestion or remoteVideoStateReasonAudioFallback.
  @JsonValue(3)
  remoteVideoStateFrozen,

  /// 4: The remote video fails to start. The SDK reports this state in the case of remoteVideoStateReasonInternal.
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

/// The reason for the remote video state change.
@JsonEnum(alwaysCreate: true)
enum RemoteVideoStateReason {
  /// 0: The SDK reports this reason when the video state changes.
  @JsonValue(0)
  remoteVideoStateReasonInternal,

  /// 1: Network congestion.
  @JsonValue(1)
  remoteVideoStateReasonNetworkCongestion,

  /// 2: Network is recovered.
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

  /// 8: The remote audio-and-video stream falls back to the audio-only stream due to poor network conditions.
  @JsonValue(8)
  remoteVideoStateReasonAudioFallback,

  /// 9: The remote audio-only stream switches back to the audio-and-video stream after the network conditions improve.
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

  /// 13: The local video decoder does not support decoding the remote video stream.
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
class VideoTrackInfo {
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

/// The volume information of users.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioVolumeInfo {
  /// @nodoc
  const AudioVolumeInfo({this.uid, this.volume, this.vad, this.voicePitch});

  /// The user ID.
  ///  In the local user's callback, uid is 0.
  ///  In the remote users' callback, uid is the user ID of a remote user whose instantaneous volume is the highest.
  @JsonKey(name: 'uid')
  final int? uid;

  /// The volume of the user. The value ranges between 0 (the lowest volume) and 255 (the highest volume). If the local user enables audio capturing and calls muteLocalAudioStream and set it as true to mute, the value of volume indicates the volume of locally captured audio signal.
  @JsonKey(name: 'volume')
  final int? volume;

  /// Voice activity status of the local user.
  ///  0: The local user is not speaking.
  ///  1: The local user is speaking.
  ///  The vad parameter does not report the voice activity status of remote users. In a remote user's callback, the value of vad is always 1.
  ///  To use this parameter, you must set reportVad to true when calling enableAudioVolumeIndication.
  @JsonKey(name: 'vad')
  final int? vad;

  /// The voice pitch of the local user. The value ranges between 0.0 and 4000.0. The voicePitch parameter does not report the voice pitch of remote users. In the remote users' callback, the value of voicePitch is always 0.0.
  @JsonKey(name: 'voicePitch')
  final double? voicePitch;

  /// @nodoc
  factory AudioVolumeInfo.fromJson(Map<String, dynamic> json) =>
      _$AudioVolumeInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AudioVolumeInfoToJson(this);
}

/// The audio device information.
///
/// This class is for Android only.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class DeviceInfo {
  /// @nodoc
  const DeviceInfo({this.isLowLatencyAudioSupported});

  /// Whether the audio device supports ultra-low-latency capture and playback: true : The device supports ultra-low-latency capture and playback. false : The device does not support ultra-low-latency capture and playback.
  @JsonKey(name: 'isLowLatencyAudioSupported')
  final bool? isLowLatencyAudioSupported;

  /// @nodoc
  factory DeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$DeviceInfoToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Packet {
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

/// Video codec profile types.
@JsonEnum(alwaysCreate: true)
enum VideoCodecProfileType {
  /// 66: Baseline video codec profile; generally used for video calls on mobile phones.
  @JsonValue(66)
  videoCodecProfileBaseline,

  /// 77: Main video codec profile; generally used in mainstream electronics such as MP4 players, portable video players, PSP, and iPads.
  @JsonValue(77)
  videoCodecProfileMain,

  /// 100: (Default) High video codec profile; generally used in high-resolution live streaming or television.
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
class LocalAudioStats {
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

  /// The audio device module delay (ms) when playing or recording audio.
  @JsonKey(name: 'audioDeviceDelay')
  final int? audioDeviceDelay;

  /// @nodoc
  @JsonKey(name: 'audioPlayoutDelay')
  final int? audioPlayoutDelay;

  /// The ear monitor delay (ms), which is the delay from microphone input to headphone output.
  @JsonKey(name: 'earMonitorDelay')
  final int? earMonitorDelay;

  /// Acoustic echo cancellation (AEC) module estimated delay (ms), which is the signal delay between when audio is played locally before being locally captured.
  @JsonKey(name: 'aecEstimatedDelay')
  final int? aecEstimatedDelay;

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
  @JsonValue(0)
  rtmpStreamPublishStateIdle,

  /// 1: The streaming server and CDN server are being connected.
  @JsonValue(1)
  rtmpStreamPublishStateConnecting,

  /// 2: The RTMP or RTMPS streaming publishes. The SDK successfully publishes the RTMP or RTMPS streaming and returns this state.
  @JsonValue(2)
  rtmpStreamPublishStateRunning,

  /// 3: The RTMP or RTMPS streaming is recovering. When exceptions occur to the CDN, or the streaming is interrupted, the SDK tries to resume RTMP or RTMPS streaming and returns this state.
  ///  If the SDK successfully resumes the streaming, rtmpStreamPublishStateRunning (2) returns.
  ///  If the streaming does not resume within 60 seconds or server errors occur, rtmpStreamPublishStateFailure (4) returns. If you feel that 60 seconds is too long, you can also actively try to reconnect.
  @JsonValue(3)
  rtmpStreamPublishStateRecovering,

  /// 4: The RTMP or RTMPS streaming fails. After a failure, you can troubleshoot the cause of the error through the returned error code.
  @JsonValue(4)
  rtmpStreamPublishStateFailure,

  /// 5: The SDK is disconnecting from the Agora streaming server and CDN. When you call stopRtmpStream to stop the Media Push normally, the SDK reports the Media Push state as rtmpStreamPublishStateDisconnecting and rtmpStreamPublishStateIdle in sequence.
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

/// Reasons for changes in the status of RTMP or RTMPS streaming.
@JsonEnum(alwaysCreate: true)
enum RtmpStreamPublishReason {
  /// 0: The RTMP or RTMPS streaming has not started or has ended.
  @JsonValue(0)
  rtmpStreamPublishReasonOk,

  /// 1: Invalid argument used. Check the parameter setting.
  @JsonValue(1)
  rtmpStreamPublishReasonInvalidArgument,

  /// 2: The RTMP or RTMPS streaming is encrypted and cannot be published.
  @JsonValue(2)
  rtmpStreamPublishReasonEncryptedStreamNotAllowed,

  /// 3: Timeout for the RTMP or RTMPS streaming.
  @JsonValue(3)
  rtmpStreamPublishReasonConnectionTimeout,

  /// 4: An error occurs in Agora's streaming server.
  @JsonValue(4)
  rtmpStreamPublishReasonInternalServerError,

  /// 5: An error occurs in the CDN server.
  @JsonValue(5)
  rtmpStreamPublishReasonRtmpServerError,

  /// 6: The RTMP or RTMPS streaming publishes too frequently.
  @JsonValue(6)
  rtmpStreamPublishReasonTooOften,

  /// 7: The host publishes more than 10 URLs. Delete the unnecessary URLs before adding new ones.
  @JsonValue(7)
  rtmpStreamPublishReasonReachLimit,

  /// 8: The host manipulates other hosts' URLs. For example, the host updates or stops other hosts' streams. Check your app logic.
  @JsonValue(8)
  rtmpStreamPublishReasonNotAuthorized,

  /// 9: Agora's server fails to find the RTMP or RTMPS streaming.
  @JsonValue(9)
  rtmpStreamPublishReasonStreamNotFound,

  /// 10: The format of the RTMP or RTMPS streaming URL is not supported. Check whether the URL format is correct.
  @JsonValue(10)
  rtmpStreamPublishReasonFormatNotSupported,

  /// 11: The user role is not host, so the user cannot use the CDN live streaming function. Check your application code logic.
  @JsonValue(11)
  rtmpStreamPublishReasonNotBroadcaster,

  /// 13: The updateRtmpTranscoding method is called to update the transcoding configuration in a scenario where there is streaming without transcoding. Check your application code logic.
  @JsonValue(13)
  rtmpStreamPublishReasonTranscodingNoMixStream,

  /// 14: Errors occurred in the host's network.
  @JsonValue(14)
  rtmpStreamPublishReasonNetDown,

  /// @nodoc
  @JsonValue(15)
  rtmpStreamPublishReasonInvalidAppid,

  /// 16: Your project does not have permission to use streaming services.
  @JsonValue(16)
  rtmpStreamPublishReasonInvalidPrivilege,

  /// 100: The streaming has been stopped normally. After you stop the Media Push, the SDK returns this value.
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

/// Events during the Media Push.
@JsonEnum(alwaysCreate: true)
enum RtmpStreamingEvent {
  /// 1: An error occurs when you add a background image or a watermark image in the Media Push.
  @JsonValue(1)
  rtmpStreamingEventFailedLoadImage,

  /// 2: The streaming URL is already being used for Media Push. If you want to start new streaming, use a new streaming URL.
  @JsonValue(2)
  rtmpStreamingEventUrlAlreadyInUse,

  /// 3: The feature is not supported.
  @JsonValue(3)
  rtmpStreamingEventAdvancedFeatureNotSupport,

  /// 4: Reserved.
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
/// This class sets the properties of the watermark and background images in the live video.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RtcImage {
  /// @nodoc
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

  /// The x-coordinate (px) of the image on the video frame (taking the upper left corner of the video frame as the origin).
  @JsonKey(name: 'x')
  final int? x;

  /// The y-coordinate (px) of the image on the video frame (taking the upper left corner of the video frame as the origin).
  @JsonKey(name: 'y')
  final int? y;

  /// The width (px) of the image on the video frame.
  @JsonKey(name: 'width')
  final int? width;

  /// The height (px) of the image on the video frame.
  @JsonKey(name: 'height')
  final int? height;

  /// The layer index of the watermark or background image. When you use the watermark array to add a watermark or multiple watermarks, you must pass a value to zOrder in the range [1,255]; otherwise, the SDK reports an error. In other cases, zOrder can optionally be passed in the range [0,255], with 0 being the default value. 0 means the bottom layer and 255 means the top layer.
  @JsonKey(name: 'zOrder')
  final int? zOrder;

  /// The transparency of the watermark or background image. The range of the value is [0.0,1.0]:
  ///  0.0: Completely transparent.
  ///  1.0: (Default) Opaque.
  @JsonKey(name: 'alpha')
  final double? alpha;

  /// @nodoc
  factory RtcImage.fromJson(Map<String, dynamic> json) =>
      _$RtcImageFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RtcImageToJson(this);
}

/// The configuration for advanced features of the RTMP or RTMPS streaming with transcoding.
///
/// If you want to enable the advanced features of streaming with transcoding, contact.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LiveStreamAdvancedFeature {
  /// @nodoc
  const LiveStreamAdvancedFeature({this.featureName, this.opened});

  /// The feature names, including LBHQ (high-quality video with a lower bitrate) and VEO (optimized video encoder).
  @JsonKey(name: 'featureName')
  final String? featureName;

  /// Whether to enable the advanced features of streaming with transcoding: true : Enable the advanced features. false : (Default) Do not enable the advanced features.
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
  ///  Theinitial state before calling the joinChannel method.
  ///  The app calls the leaveChannel method.
  @JsonValue(1)
  connectionStateDisconnected,

  /// 2: The SDK is connecting to the Agora edge server. This state indicates that the SDK is establishing a connection with the specified channel after the app calls joinChannel.
  ///  If the SDK successfully joins the channel, it triggers the onConnectionStateChanged callback and the connection state switches to connectionStateConnected.
  ///  After the connection is established, the SDK also initializes the media and triggers onJoinChannelSuccess when everything is ready.
  @JsonValue(2)
  connectionStateConnecting,

  /// 3: The SDK is connected to the Agora edge server. This state also indicates that the user has joined a channel and can now publish or subscribe to a media stream in the channel. If the connection to the channel is lost because, for example, if the network is down or switched, the SDK automatically tries to reconnect and triggers onConnectionStateChanged callback, notifying that the current network state becomes connectionStateReconnecting.
  @JsonValue(3)
  connectionStateConnected,

  /// 4: The SDK keeps reconnecting to the Agora edge server. The SDK keeps rejoining the channel after being disconnected from a joined channel because of network issues.
  ///  If the SDK cannot rejoin the channel within 10 seconds, it triggers onConnectionLost, stays in the connectionStateReconnecting state, and keeps rejoining the channel.
  ///  If the SDK fails to rejoin the channel 20 minutes after being disconnected from the Agora edge server, the SDK triggers the onConnectionStateChanged callback, switches to the connectionStateFailed state, and stops rejoining the channel.
  @JsonValue(4)
  connectionStateReconnecting,

  /// 5: The SDK fails to connect to the Agora edge server or join the channel. This state indicates that the SDK stops trying to rejoin the channel. You must call leaveChannel to leave the channel.
  ///  You can call joinChannel to rejoin the channel.
  ///  If the SDK is banned from joining the channel by the Agora edge server through the RESTful API, the SDK triggers the onConnectionStateChanged callback.
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

/// Transcoding configurations of each host.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TranscodingUser {
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

  /// The user ID of the host.
  @JsonKey(name: 'uid')
  final int? uid;

  /// The x coordinate (pixel) of the host's video on the output video frame (taking the upper left corner of the video frame as the origin). The value range is [0, width], where width is the width set in LiveTranscoding.
  @JsonKey(name: 'x')
  final int? x;

  /// The y coordinate (pixel) of the host's video on the output video frame (taking the upper left corner of the video frame as the origin). The value range is [0, height], where height is the height set in LiveTranscoding.
  @JsonKey(name: 'y')
  final int? y;

  /// The width (pixel) of the host's video.
  @JsonKey(name: 'width')
  final int? width;

  /// The height (pixel) of the host's video.
  @JsonKey(name: 'height')
  final int? height;

  /// The layer index number of the host's video. The value range is [0, 100].
  ///  0: (Default) The host's video is the bottom layer.
  ///  100: The host's video is the top layer.
  ///  If the value is less than 0 or greater than 100, errInvalidArgument error is returned.
  ///  Setting zOrder to 0 is supported.
  @JsonKey(name: 'zOrder')
  final int? zOrder;

  /// The transparency of the host's video. The value range is [0.0,1.0].
  ///  0.0: Completely transparent.
  ///  1.0: (Default) Opaque.
  @JsonKey(name: 'alpha')
  final double? alpha;

  /// The audio channel used by the host's audio in the output audio. The default value is 0, and the value range is [0, 5]. 0 : (Recommended) The defaut setting, which supports dual channels at most and depends on the upstream of the host. 1 : The host's audio uses the FL audio channel. If the host's upstream uses multiple audio channels, the Agora server mixes them into mono first. 2 : The host's audio uses the FC audio channel. If the host's upstream uses multiple audio channels, the Agora server mixes them into mono first. 3 : The host's audio uses the FR audio channel. If the host's upstream uses multiple audio channels, the Agora server mixes them into mono first. 4 : The host's audio uses the BL audio channel. If the host's upstream uses multiple audio channels, the Agora server mixes them into mono first. 5 : The host's audio uses the BR audio channel. If the host's upstream uses multiple audio channels, the Agora server mixes them into mono first. 0xFF or a value greater than 5 : The host's audio is muted, and the Agora server removes the host's audio. If the value is not 0, a special player is required.
  @JsonKey(name: 'audioChannel')
  final int? audioChannel;

  /// @nodoc
  factory TranscodingUser.fromJson(Map<String, dynamic> json) =>
      _$TranscodingUserFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$TranscodingUserToJson(this);
}

/// Transcoding configurations for Media Push.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LiveTranscoding {
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

  /// The width of the video in pixels. The default value is 360.
  ///  When pushing video streams to the CDN, the value range of width is [64,1920]. If the value is less than 64, Agora server automatically adjusts it to 64; if the value is greater than 1920, Agora server automatically adjusts it to 1920.
  ///  When pushing audio streams to the CDN, set width and height as 0.
  @JsonKey(name: 'width')
  final int? width;

  /// The height of the video in pixels. The default value is 640.
  ///  When pushing video streams to the CDN, the value range of height is [64,1080]. If the value is less than 64, Agora server automatically adjusts it to 64; if the value is greater than 1080, Agora server automatically adjusts it to 1080.
  ///  When pushing audio streams to the CDN, set width and height as 0.
  @JsonKey(name: 'height')
  final int? height;

  /// The encoding bitrate (Kbps) of the video. This parameter does not need to be set; keeping the default value standardBitrate is sufficient. The SDK automatically matches the most suitable bitrate based on the video resolution and frame rate you have set. For the correspondence between video resolution and frame rate, see.
  @JsonKey(name: 'videoBitrate')
  final int? videoBitrate;

  /// Frame rate (fps) of the output video stream set for Media Push. The default value is 15. The value range is (0,30]. The Agora server adjusts any value over 30 to 30.
  @JsonKey(name: 'videoFramerate')
  final int? videoFramerate;

  /// Deprecated This member is deprecated. Latency mode: true : Low latency with unassured quality. false : (Default) High latency with assured quality.
  @JsonKey(name: 'lowLatency')
  final bool? lowLatency;

  /// GOP (Group of Pictures) in fps of the video frames for Media Push. The default value is 30.
  @JsonKey(name: 'videoGop')
  final int? videoGop;

  /// Video codec profile type for Media Push. Set it as 66, 77, or 100 (default). See VideoCodecProfileType for details. If you set this parameter to any other value, Agora adjusts it to the default value.
  @JsonKey(name: 'videoCodecProfile')
  final VideoCodecProfileType? videoCodecProfile;

  /// The background color in RGB hex value. Value only. Do not include a preceeding #. For example, 0xFFB6C1 (light pink). The default value is 0x000000 (black).
  @JsonKey(name: 'backgroundColor')
  final int? backgroundColor;

  /// Video codec profile types for Media Push. See VideoCodecTypeForStream.
  @JsonKey(name: 'videoCodecType')
  final VideoCodecTypeForStream? videoCodecType;

  /// The number of users in the Media Push. The value range is [0,17].
  @JsonKey(name: 'userCount')
  final int? userCount;

  /// Manages the user layout configuration in the Media Push. Agora supports a maximum of 17 transcoding users in a Media Push channel. See TranscodingUser.
  @JsonKey(name: 'transcodingUsers')
  final List<TranscodingUser>? transcodingUsers;

  /// Reserved property. Extra user-defined information to send SEI for the H.264/H.265 video stream to the CDN live client. Maximum length: 4096 bytes. For more information on SEI, see SEI-related questions.
  @JsonKey(name: 'transcodingExtraInfo')
  final String? transcodingExtraInfo;

  /// Deprecated Obsolete and not recommended for use. The metadata sent to the CDN client.
  @JsonKey(name: 'metadata')
  final String? metadata;

  /// The watermark on the live video. The image format needs to be PNG. See RtcImage. You can add one watermark, or add multiple watermarks using an array.
  @JsonKey(name: 'watermark')
  final List<RtcImage>? watermark;

  /// The number of watermarks on the live video. The total number of watermarks and background images can range from 0 to 10. This parameter is used with watermark.
  @JsonKey(name: 'watermarkCount')
  final int? watermarkCount;

  /// The number of background images on the live video. The image format needs to be PNG. See RtcImage. You can add a background image or use an array to add multiple background images. This parameter is used with backgroundImageCount.
  @JsonKey(name: 'backgroundImage')
  final List<RtcImage>? backgroundImage;

  /// The number of background images on the live video. The total number of watermarks and background images can range from 0 to 10. This parameter is used with backgroundImage.
  @JsonKey(name: 'backgroundImageCount')
  final int? backgroundImageCount;

  /// The audio sampling rate (Hz) of the output media stream. See AudioSampleRateType.
  @JsonKey(name: 'audioSampleRate')
  final AudioSampleRateType? audioSampleRate;

  /// Bitrate (Kbps) of the audio output stream for Media Push. The default value is 48, and the highest value is 128.
  @JsonKey(name: 'audioBitrate')
  final int? audioBitrate;

  /// The number of audio channels for Media Push. Agora recommends choosing 1 (mono), or 2 (stereo) audio channels. Special players are required if you choose 3, 4, or 5.
  ///  1: (Default) Mono
  ///  2: Stereo.
  ///  3: Three audio channels.
  ///  4: Four audio channels.
  ///  5: Five audio channels.
  @JsonKey(name: 'audioChannels')
  final int? audioChannels;

  /// Audio codec profile type for Media Push. See AudioCodecProfileType.
  @JsonKey(name: 'audioCodecProfile')
  final AudioCodecProfileType? audioCodecProfile;

  /// Advanced features of the Media Push with transcoding. See LiveStreamAdvancedFeature.
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

/// The video streams for local video mixing.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TranscodingVideoStream {
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

  /// The video source type for local video mixing. See VideoSourceType.
  @JsonKey(name: 'sourceType')
  final VideoSourceType? sourceType;

  /// The user ID of the remote user. Use this parameter only when the source type is videoSourceRemote for local video mixing.
  @JsonKey(name: 'remoteUserUid')
  final int? remoteUserUid;

  /// The URL of the image. Use this parameter only when the source type is the image for local video mixing.
  @JsonKey(name: 'imageUrl')
  final String? imageUrl;

  /// (Optional) Media player ID. Use the parameter only when you set sourceType to videoSourceMediaPlayer.
  @JsonKey(name: 'mediaPlayerId')
  final int? mediaPlayerId;

  /// The relative lateral displacement of the top left corner of the video for local video mixing to the origin (the top left corner of the canvas).
  @JsonKey(name: 'x')
  final int? x;

  /// The relative longitudinal displacement of the top left corner of the captured video to the origin (the top left corner of the canvas).
  @JsonKey(name: 'y')
  final int? y;

  /// The width (px) of the video for local video mixing on the canvas.
  @JsonKey(name: 'width')
  final int? width;

  /// The height (px) of the video for local video mixing on the canvas.
  @JsonKey(name: 'height')
  final int? height;

  /// The number of the layer to which the video for the local video mixing belongs. The value range is [0, 100].
  ///  0: (Default) The layer is at the bottom.
  ///  100: The layer is at the top.
  @JsonKey(name: 'zOrder')
  final int? zOrder;

  /// The transparency of the video for local video mixing. The value range is [0.0, 1.0]. 0.0 indicates that the video is completely transparent, and 1.0 indicates that it is opaque.
  @JsonKey(name: 'alpha')
  final double? alpha;

  /// Whether to mirror the video for the local video mixing. true : Mirror the video for the local video mixing. false : (Default) Do not mirror the video for the local video mixing. This parameter only takes effect on video source types that are cameras.
  @JsonKey(name: 'mirror')
  final bool? mirror;

  /// @nodoc
  factory TranscodingVideoStream.fromJson(Map<String, dynamic> json) =>
      _$TranscodingVideoStreamFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$TranscodingVideoStreamToJson(this);
}

/// The configuration of the video mixing on the local client.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LocalTranscoderConfiguration {
  /// @nodoc
  const LocalTranscoderConfiguration(
      {this.streamCount,
      this.videoInputStreams,
      this.videoOutputConfiguration,
      this.syncWithPrimaryCamera});

  /// The number of the video streams for the video mixing on the local client.
  @JsonKey(name: 'streamCount')
  final int? streamCount;

  /// The video streams for local video mixing. See TranscodingVideoStream.
  @JsonKey(name: 'videoInputStreams')
  final List<TranscodingVideoStream>? videoInputStreams;

  /// The encoding configuration of the mixed video stream after the local video mixing. See VideoEncoderConfiguration.
  @JsonKey(name: 'videoOutputConfiguration')
  final VideoEncoderConfiguration? videoOutputConfiguration;

  /// @nodoc
  @JsonKey(name: 'syncWithPrimaryCamera')
  final bool? syncWithPrimaryCamera;

  /// @nodoc
  factory LocalTranscoderConfiguration.fromJson(Map<String, dynamic> json) =>
      _$LocalTranscoderConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LocalTranscoderConfigurationToJson(this);
}

/// The error code of the local video mixing failure.
@JsonEnum(alwaysCreate: true)
enum VideoTranscoderError {
  /// 1: The selected video source has not started video capture. You need to create a video track for it and start video capture.
  @JsonValue(1)
  vtErrVideoSourceNotReady,

  /// 2: The video source type is invalid. You need to re-specify the supported video source type.
  @JsonValue(2)
  vtErrInvalidVideoSourceType,

  /// 3: The image path is invalid. You need to re-specify the correct image path.
  @JsonValue(3)
  vtErrInvalidImagePath,

  /// 4: The image format is invalid. Make sure the image format is one of PNG, JPEG, or GIF.
  @JsonValue(4)
  vtErrUnsupportImageFormat,

  /// 5: The video encoding resolution after video mixing is invalid.
  @JsonValue(5)
  vtErrInvalidLayout,

  /// 20: Unknown internal error.
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

/// Configurations of the last-mile network test.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LastmileProbeConfig {
  /// @nodoc
  const LastmileProbeConfig(
      {this.probeUplink,
      this.probeDownlink,
      this.expectedUplinkBitrate,
      this.expectedDownlinkBitrate});

  /// Sets whether to test the uplink network. Some users, for example, the audience members in a LIVE_BROADCASTING channel, do not need such a test. true : Test the uplink network. false : Do not test the uplink network.
  @JsonKey(name: 'probeUplink')
  final bool? probeUplink;

  /// Sets whether to test the downlink network: true : Test the downlink network. false : Do not test the downlink network.
  @JsonKey(name: 'probeDownlink')
  final bool? probeDownlink;

  /// The expected maximum uplink bitrate (bps) of the local user. The value range is [100000, 5000000]. Agora recommends referring to setVideoEncoderConfiguration to set the value.
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

/// Results of the uplink or downlink last-mile network test.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LastmileProbeOneWayResult {
  /// @nodoc
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
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LastmileProbeResult {
  /// @nodoc
  const LastmileProbeResult(
      {this.state, this.uplinkReport, this.downlinkReport, this.rtt});

  /// The status of the last-mile network tests. See LastmileProbeResultState.
  @JsonKey(name: 'state')
  final LastmileProbeResultState? state;

  /// Results of the uplink last-mile network test. See LastmileProbeOneWayResult.
  @JsonKey(name: 'uplinkReport')
  final LastmileProbeOneWayResult? uplinkReport;

  /// Results of the downlink last-mile network test. See LastmileProbeOneWayResult.
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

  /// 3: The connection between the SDK and the Agora edge server is banned by the Agora edge server. For example, when a user is kicked out of the channel, this status will be returned.
  @JsonValue(3)
  connectionChangedBannedByServer,

  /// 4: The SDK fails to join the channel. When the SDK fails to join the channel for more than 20 minutes, this code will be returned and the SDK stops reconnecting to the channel. You need to prompt the user to try to switch to another network and rejoin the channel.
  @JsonValue(4)
  connectionChangedJoinFailed,

  /// 5: The SDK has left the channel.
  @JsonValue(5)
  connectionChangedLeaveChannel,

  /// 6: The App ID is invalid. You need to rejoin the channel with a valid APP ID and make sure the App ID you are using is consistent with the one generated in the Agora Console.
  @JsonValue(6)
  connectionChangedInvalidAppId,

  /// 7: Invalid channel name. Rejoin the channel with a valid channel name. A valid channel name is a string of up to 64 bytes in length. Supported characters (89 characters in total):
  ///  All lowercase English letters: a to z.
  ///  All uppercase English letters: A to Z.
  ///  All numeric characters: 0 to 9.
  ///  Space
  ///  "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","
  @JsonValue(7)
  connectionChangedInvalidChannelName,

  /// 8: Invalid token. Possible reasons are as follows:
  ///  The App Certificate for the project is enabled in Agora Console, but you do not pass in a token when joining a channel.
  ///  The uid specified when calling joinChannel to join the channel is inconsistent with the uid passed in when generating the token.
  ///  The generated token and the token used to join the channel are not consistent. Ensure the following:
  ///  When your project enables App Certificate, you need to pass in a token to join a channel.
  ///  The user ID specified when generating the token is consistent with the user ID used when joining the channel.
  ///  The generated token is the same as the token passed in to join the channel.
  @JsonValue(8)
  connectionChangedInvalidToken,

  /// (9): The token currently being used has expired. You need to generate a new token on your server and rejoin the channel with the new token.
  @JsonValue(9)
  connectionChangedTokenExpired,

  /// 10: The connection is rejected by server. Possible reasons are as follows:
  ///  The user is already in the channel and still calls a method, for example, joinChannel, to join the channel. Stop calling this method to clear this error.
  ///  The user tries to join a channel while a test call is in progress. The user needs to join the channel after the call test ends.
  @JsonValue(10)
  connectionChangedRejectedByServer,

  /// 11: The connection state changed to reconnecting because the SDK has set a proxy server.
  @JsonValue(11)
  connectionChangedSettingProxyServer,

  /// 12: The connection state changed because the token is renewed.
  @JsonValue(12)
  connectionChangedRenewToken,

  /// (13): Client IP address changed. If you receive this code multiple times, You need to prompt the user to switch networks and try joining the channel again.
  @JsonValue(13)
  connectionChangedClientIpAddressChanged,

  /// 14: Timeout for the keep-alive of the connection between the SDK and the Agora edge server. The SDK tries to reconnect to the server automatically.
  @JsonValue(14)
  connectionChangedKeepAliveTimeout,

  /// 15: The user has rejoined the channel successfully.
  @JsonValue(15)
  connectionChangedRejoinSuccess,

  /// 16: The connection between the SDK and the server is lost.
  @JsonValue(16)
  connectionChangedLost,

  /// 17: The connection state changes due to the echo test.
  @JsonValue(17)
  connectionChangedEchoTest,

  /// 18: The local IP address was changed by the user.
  @JsonValue(18)
  connectionChangedClientIpAddressChangedByUser,

  /// 19: The user joined the same channel from different devices with the same UID.
  @JsonValue(19)
  connectionChangedSameUidLogin,

  /// 20: The number of hosts in the channel has reached the upper limit.
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

/// The reason for a user role switch failure.
@JsonEnum(alwaysCreate: true)
enum ClientRoleChangeFailedReason {
  /// 1: The number of hosts in the channel is already at the upper limit. This enumerator is reported only when the support for 128 users is enabled. The maximum number of hosts is based on the actual number of hosts configured when you enable the 128-user feature.
  @JsonValue(1)
  clientRoleChangeFailedTooManyBroadcasters,

  /// 2: The request is rejected by the Agora server. Agora recommends you prompt the user to try to switch their user role again.
  @JsonValue(2)
  clientRoleChangeFailedNotAuthorized,

  /// 3: The request is timed out. Agora recommends you prompt the user to check the network connection and try to switch their user role again.
  @JsonValue(3)
  clientRoleChangeFailedRequestTimeOut,

  /// 4: The SDK connection fails. You can use reason reported in the onConnectionStateChanged callback to troubleshoot the failure.
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
class WlAccStats {
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

  /// @nodoc
  Map<String, dynamic> toJson() => _$WlAccStatsToJson(this);
}

/// Network type.
@JsonEnum(alwaysCreate: true)
enum NetworkType {
  /// -1: The network type is unknown.
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

  /// 6: The network type is mobile 5G.
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

/// Setting mode of the view.
@JsonEnum(alwaysCreate: true)
enum VideoViewSetupMode {
  /// 0: (Default) Replaces a view.
  @JsonValue(0)
  videoViewSetupReplace,

  /// 1: Adds a view.
  @JsonValue(1)
  videoViewSetupAdd,

  /// 2: Deletes a view.
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

/// Attributes of the video canvas object.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoCanvas {
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

  /// The user ID.
  @JsonKey(name: 'uid')
  final int? uid;

  /// The ID of the user who publishes a specific sub-video stream within the mixed video stream.
  @JsonKey(name: 'subviewUid')
  final int? subviewUid;

  /// The video display window. In one VideoCanvas, you can only choose to set either view or surfaceTexture. If both are set, only the settings in view take effect.
  @JsonKey(name: 'view')
  final int? view;

  /// The background color of the video canvas in RGBA format. The default value is 0x00000000, which represents completely transparent black.
  @JsonKey(name: 'backgroundColor')
  final int? backgroundColor;

  /// The rendering mode of the video. See RenderModeType.
  @JsonKey(name: 'renderMode')
  final RenderModeType? renderMode;

  /// The mirror mode of the view. See VideoMirrorModeType.
  ///  For the mirror mode of the local video view: If you use a front camera, the SDK enables the mirror mode by default; if you use a rear camera, the SDK disables the mirror mode by default.
  ///  For the remote user: The mirror mode is disabled by default.
  @JsonKey(name: 'mirrorMode')
  final VideoMirrorModeType? mirrorMode;

  /// Setting mode of the view. See VideoViewSetupMode.
  @JsonKey(name: 'setupMode')
  final VideoViewSetupMode? setupMode;

  /// The type of the video source. See VideoSourceType.
  @JsonKey(name: 'sourceType')
  final VideoSourceType? sourceType;

  /// The ID of the media player. You can get the Device ID by calling getMediaPlayerId.
  @JsonKey(name: 'mediaPlayerId')
  final int? mediaPlayerId;

  /// (Optional) Display area of the video frame, see Rectangle. width and height represent the video pixel width and height of the area. The default value is null (width or height is 0), which means that the actual resolution of the video frame is displayed.
  @JsonKey(name: 'cropArea')
  final Rectangle? cropArea;

  /// (Optional) Whether the receiver enables alpha mask rendering: true : The receiver enables alpha mask rendering. false : (Default) The receiver disables alpha mask rendering. Alpha mask rendering can create images with transparent effects and extract portraits from videos. When used in combination with other methods, you can implement effects such as portrait-in-picture and watermarking.
  ///  The receiver can render alpha channel information only when the sender enables alpha transmission.
  ///  To enable alpha transmission,.
  @JsonKey(name: 'enableAlphaMask')
  final bool? enableAlphaMask;

  /// The observation position of the video frame in the video link. See VideoModulePosition.
  @JsonKey(name: 'position')
  final VideoModulePosition? position;

  /// @nodoc
  factory VideoCanvas.fromJson(Map<String, dynamic> json) =>
      _$VideoCanvasFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$VideoCanvasToJson(this);
}

/// Image enhancement options.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class BeautyOptions {
  /// @nodoc
  const BeautyOptions(
      {this.lighteningContrastLevel,
      this.lighteningLevel,
      this.smoothnessLevel,
      this.rednessLevel,
      this.sharpnessLevel});

  /// The contrast level, used with the lighteningLevel parameter. The larger the value, the greater the contrast between light and dark. See LighteningContrastLevel.
  @JsonKey(name: 'lighteningContrastLevel')
  final LighteningContrastLevel? lighteningContrastLevel;

  /// The brightening level, in the range [0.0,1.0], where 0.0 means the original brightening. The default value is 0.0. The higher the value, the greater the degree of brightening.
  @JsonKey(name: 'lighteningLevel')
  final double? lighteningLevel;

  /// The smoothness level, in the range [0.0,1.0], where 0.0 means the original smoothness. The default value is 0.0. The greater the value, the greater the smoothness level.
  @JsonKey(name: 'smoothnessLevel')
  final double? smoothnessLevel;

  /// The redness level, in the range [0.0,1.0], where 0.0 means the original redness. The default value is 0.0. The larger the value, the greater the redness level.
  @JsonKey(name: 'rednessLevel')
  final double? rednessLevel;

  /// The sharpness level, in the range [0.0,1.0], where 0.0 means the original sharpness. The default value is 0.0. The larger the value, the greater the sharpness level.
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
  /// 0: Low contrast level.
  @JsonValue(0)
  lighteningContrastLow,

  /// 1: (Default) Normal contrast level.
  @JsonValue(1)
  lighteningContrastNormal,

  /// 2: High contrast level.
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

/// The low-light enhancement options.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LowlightEnhanceOptions {
  /// @nodoc
  const LowlightEnhanceOptions({this.mode, this.level});

  /// The low-light enhancement mode. See LowLightEnhanceMode.
  @JsonKey(name: 'mode')
  final LowLightEnhanceMode? mode;

  /// The low-light enhancement level. See LowLightEnhanceLevel.
  @JsonKey(name: 'level')
  final LowLightEnhanceLevel? level;

  /// @nodoc
  factory LowlightEnhanceOptions.fromJson(Map<String, dynamic> json) =>
      _$LowlightEnhanceOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LowlightEnhanceOptionsToJson(this);
}

/// The low-light enhancement mode.
@JsonEnum(alwaysCreate: true)
enum LowLightEnhanceMode {
  /// 0: (Default) Automatic mode. The SDK automatically enables or disables the low-light enhancement feature according to the ambient light to compensate for the lighting level or prevent overexposure, as necessary.
  @JsonValue(0)
  lowLightEnhanceAuto,

  /// 1: Manual mode. Users need to enable or disable the low-light enhancement feature manually.
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

/// The low-light enhancement level.
@JsonEnum(alwaysCreate: true)
enum LowLightEnhanceLevel {
  /// 0: (Default) Promotes video quality during low-light enhancement. It processes the brightness, details, and noise of the video image. The performance consumption is moderate, the processing speed is moderate, and the overall video quality is optimal.
  @JsonValue(0)
  lowLightEnhanceLevelHighQuality,

  /// 1: Promotes performance during low-light enhancement. It processes the brightness and details of the video image. The processing speed is faster.
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

/// Video noise reduction options.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoDenoiserOptions {
  /// @nodoc
  const VideoDenoiserOptions({this.mode, this.level});

  /// Video noise reduction mode.
  @JsonKey(name: 'mode')
  final VideoDenoiserMode? mode;

  /// Video noise reduction level.
  @JsonKey(name: 'level')
  final VideoDenoiserLevel? level;

  /// @nodoc
  factory VideoDenoiserOptions.fromJson(Map<String, dynamic> json) =>
      _$VideoDenoiserOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$VideoDenoiserOptionsToJson(this);
}

/// Video noise reduction mode.
@JsonEnum(alwaysCreate: true)
enum VideoDenoiserMode {
  /// 0: (Default) Automatic mode. The SDK automatically enables or disables the video noise reduction feature according to the ambient light.
  @JsonValue(0)
  videoDenoiserAuto,

  /// 1: Manual mode. Users need to enable or disable the video noise reduction feature manually.
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

/// The video noise reduction level.
@JsonEnum(alwaysCreate: true)
enum VideoDenoiserLevel {
  /// 0: (Default) Promotes video quality during video noise reduction. balances performance consumption and video noise reduction quality. The performance consumption is moderate, the video noise reduction speed is moderate, and the overall video quality is optimal.
  @JsonValue(0)
  videoDenoiserLevelHighQuality,

  /// 1: Promotes reducing performance consumption during video noise reduction. prioritizes reducing performance consumption over video noise reduction quality. The performance consumption is lower, and the video noise reduction speed is faster. To avoid a noticeable shadowing effect (shadows trailing behind moving objects) in the processed video, Agora recommends that you use this settinging when the camera is fixed.
  @JsonValue(1)
  videoDenoiserLevelFast,

  /// 2: Enhanced video noise reduction. prioritizes video noise reduction quality over reducing performance consumption. The performance consumption is higher, the video noise reduction speed is slower, and the video noise reduction quality is better. If videoDenoiserLevelHighQuality is not enough for your video noise reduction needs, you can use this enumerator.
  @JsonValue(2)
  videoDenoiserLevelStrength,
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

/// The color enhancement options.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ColorEnhanceOptions {
  /// @nodoc
  const ColorEnhanceOptions({this.strengthLevel, this.skinProtectLevel});

  /// The level of color enhancement. The value range is [0.0, 1.0]. 0.0 is the default value, which means no color enhancement is applied to the video. The higher the value, the higher the level of color enhancement. The default value is 0.5.
  @JsonKey(name: 'strengthLevel')
  final double? strengthLevel;

  /// The level of skin tone protection. The value range is [0.0, 1.0]. 0.0 means no skin tone protection. The higher the value, the higher the level of skin tone protection. The default value is 1.0.
  ///  When the level of color enhancement is higher, the portrait skin tone can be significantly distorted, so you need to set the level of skin tone protection.
  ///  When the level of skin tone protection is higher, the color enhancement effect can be slightly reduced. Therefore, to get the best color enhancement effect, Agora recommends that you adjust strengthLevel and skinProtectLevel to get the most appropriate values.
  @JsonKey(name: 'skinProtectLevel')
  final double? skinProtectLevel;

  /// @nodoc
  factory ColorEnhanceOptions.fromJson(Map<String, dynamic> json) =>
      _$ColorEnhanceOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ColorEnhanceOptionsToJson(this);
}

/// The custom background.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VirtualBackgroundSource {
  /// @nodoc
  const VirtualBackgroundSource(
      {this.backgroundSourceType, this.color, this.source, this.blurDegree});

  /// The custom background. See backgroundSourceType.
  @JsonKey(name: 'background_source_type')
  final BackgroundSourceType? backgroundSourceType;

  /// The type of the custom background image. The color of the custom background image. The format is a hexadecimal integer defined by RGB, without the # sign, such as 0xFFB6C1 for light pink. The default value is 0xFFFFFF, which signifies white. The value range is [0x000000, 0xffffff]. If the value is invalid, the SDK replaces the original background image with a white background image. This parameter is only applicable to custom backgrounds of the following types: backgroundColor : The background image is a solid-colored image of the color passed in by the parameter. backgroundImg : If the image in source has a transparent background, the transparent background will be filled with the color passed in by the parameter.
  @JsonKey(name: 'color')
  final int? color;

  /// The local absolute path of the custom background image. Supports PNG, JPG, MP4, AVI, MKV, and FLV formats. If the path is invalid, the SDK will use either the original background image or the solid color image specified by color. This parameter takes effect only when the type of the custom background image is backgroundImg or backgroundVideo.
  @JsonKey(name: 'source')
  final String? source;

  /// The degree of blurring applied to the custom background image. This parameter takes effect only when the type of the custom background image is backgroundBlur.
  @JsonKey(name: 'blur_degree')
  final BackgroundBlurDegree? blurDegree;

  /// @nodoc
  factory VirtualBackgroundSource.fromJson(Map<String, dynamic> json) =>
      _$VirtualBackgroundSourceFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$VirtualBackgroundSourceToJson(this);
}

/// The custom background.
@JsonEnum(alwaysCreate: true)
enum BackgroundSourceType {
  /// 0: Process the background as alpha information without replacement, only separating the portrait and the background. After setting this value, you can call startLocalVideoTranscoder to implement the picture-in-picture effect.
  @JsonValue(0)
  backgroundNone,

  /// 1: (Default) The background image is a solid color.
  @JsonValue(1)
  backgroundColor,

  /// 2: The background is an image in PNG or JPG format.
  @JsonValue(2)
  backgroundImg,

  /// 3: The background is a blurred version of the original background.
  @JsonValue(3)
  backgroundBlur,

  /// 4: The background is a local video in MP4, AVI, MKV, FLV, or other supported formats.
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

/// The degree of blurring applied to the custom background image.
@JsonEnum(alwaysCreate: true)
enum BackgroundBlurDegree {
  /// 1: The degree of blurring applied to the custom background image is low. The user can almost see the background clearly.
  @JsonValue(1)
  blurDegreeLow,

  /// 2: The degree of blurring applied to the custom background image is medium. It is difficult for the user to recognize details in the background.
  @JsonValue(2)
  blurDegreeMedium,

  /// 3: (Default) The degree of blurring applied to the custom background image is high. The user can barely see any distinguishing features in the background.
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
class SegmentationProperty {
  /// @nodoc
  const SegmentationProperty({this.modelType, this.greenCapacity});

  /// The type of algorithms to user for background processing. See SegModelType.
  @JsonKey(name: 'modelType')
  final SegModelType? modelType;

  /// The accuracy range for recognizing background colors in the image. The value range is [0,1], and the default value is 0.5. The larger the value, the wider the range of identifiable shades of pure color. When the value of this parameter is too large, the edge of the portrait and the pure color in the portrait range are also detected. Agora recommends that you dynamically adjust the value of this parameter according to the actual effect. This parameter only takes effect when modelType is set to segModelGreen.
  @JsonKey(name: 'greenCapacity')
  final double? greenCapacity;

  /// @nodoc
  factory SegmentationProperty.fromJson(Map<String, dynamic> json) =>
      _$SegmentationPropertyFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$SegmentationPropertyToJson(this);
}

/// The type of algorithms to user for background processing.
@JsonEnum(alwaysCreate: true)
enum SegModelType {
  /// 1: (Default) Use the algorithm suitable for all scenarios.
  @JsonValue(1)
  segModelAi,

  /// 2: Use the algorithm designed specifically for scenarios with a green screen background.
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

/// The type of the audio track.
@JsonEnum(alwaysCreate: true)
enum AudioTrackType {
  /// @nodoc
  @JsonValue(-1)
  audioTrackInvalid,

  /// 0: Mixable audio tracks. This type of audio track supports mixing with other audio streams (such as audio streams captured by microphone) and playing locally or publishing to channels after mixing. The latency of mixable audio tracks is higher than that of direct audio tracks.
  @JsonValue(0)
  audioTrackMixable,

  /// 1: Direct audio tracks. This type of audio track will replace the audio streams captured by the microphone and does not support mixing with other audio streams. The latency of direct audio tracks is lower than that of mixable audio tracks. If audioTrackDirect is specified for this parameter, you must set publishMicrophoneTrack to false in ChannelMediaOptions when calling joinChannel to join the channel; otherwise, joining the channel fails and returns the error code -2.
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

/// The configuration of custom audio tracks.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioTrackConfig {
  /// @nodoc
  const AudioTrackConfig({this.enableLocalPlayback});

  /// Whether to enable the local audio-playback device: true : (Default) Enable the local audio-playback device. false : Do not enable the local audio-playback device.
  @JsonKey(name: 'enableLocalPlayback')
  final bool? enableLocalPlayback;

  /// @nodoc
  factory AudioTrackConfig.fromJson(Map<String, dynamic> json) =>
      _$AudioTrackConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AudioTrackConfigToJson(this);
}

/// The options for SDK preset voice beautifier effects.
@JsonEnum(alwaysCreate: true)
enum VoiceBeautifierPreset {
  /// Turn off voice beautifier effects and use the original voice.
  @JsonValue(0x00000000)
  voiceBeautifierOff,

  /// A more magnetic voice. Agora recommends using this enumerator to process a male-sounding voice; otherwise, you may experience vocal distortion.
  @JsonValue(0x01010100)
  chatBeautifierMagnetic,

  /// A fresher voice. Agora recommends using this enumerator to process a female-sounding voice; otherwise, you may experience vocal distortion.
  @JsonValue(0x01010200)
  chatBeautifierFresh,

  /// A more vital voice. Agora recommends using this enumerator to process a female-sounding voice; otherwise, you may experience vocal distortion.
  @JsonValue(0x01010300)
  chatBeautifierVitality,

  /// Singing beautifier effect.
  ///  If you call setVoiceBeautifierPreset (singingBeautifier), you can beautify a male-sounding voice and add a reverberation effect that sounds like singing in a small room. Agora recommends using this enumerator to process a male-sounding voice; otherwise, you might experience vocal distortion.
  ///  If you call setVoiceBeautifierParameters (singingBeautifier, param1, param2), you can beautify a male or female-sounding voice and add a reverberation effect.
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
  ///  To achieve better audio effect quality, Agora recommends that you set the profile of to audioProfileMusicHighQuality (4) or audioProfileMusicHighQualityStereo (5) and scenario to audioScenarioGameStreaming (3) before calling setVoiceBeautifierPreset.
  ///  If you have an audio capturing device that can already restore audio details to a high degree, Agora recommends that you do not enable ultra-high quality; otherwise, the SDK may over-restore audio details, and you may not hear the anticipated voice effect.
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

/// Preset audio effects.
///
/// To get better audio effects, Agora recommends calling setAudioProfile and setting the profile parameter as recommended below before using the preset audio effects.
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
  @JsonValue(0x02010500)
  roomAcousticsVirtualStereo,

  /// A more spatial voice effect.
  @JsonValue(0x02010600)
  roomAcousticsSpacial,

  /// A more ethereal voice effect.
  @JsonValue(0x02010700)
  roomAcousticsEthereal,

  /// A 3D voice effect that makes the voice appear to be moving around the user. The default cycle period is 10 seconds. After setting this effect, you can call setAudioEffectParameters to modify the movement period. If the 3D voice effect is enabled, users need to use stereo audio playback devices to hear the anticipated voice effect.
  @JsonValue(0x02010800)
  roomAcoustics3dVoice,

  /// Virtual surround sound, that is, the SDK generates a simulated surround sound field on the basis of stereo channels, thereby creating a surround sound effect. If the virtual surround sound is enabled, users need to use stereo audio playback devices to hear the anticipated audio effect.
  @JsonValue(0x02010900)
  roomAcousticsVirtualSurroundSound,

  /// The audio effect of chorus. Agora recommends using this effect in chorus scenarios to enhance the sense of depth and dimension in the vocals.
  @JsonValue(0x02010D00)
  roomAcousticsChorus,

  /// A middle-aged man's voice. Agora recommends using this preset to process a male-sounding voice; otherwise, you may not hear the anticipated voice effect.
  @JsonValue(0x02020100)
  voiceChangerEffectUncle,

  /// An older man's voice. Agora recommends using this preset to process a male-sounding voice; otherwise, you may not hear the anticipated voice effect.
  @JsonValue(0x02020200)
  voiceChangerEffectOldman,

  /// A boy's voice. Agora recommends using this preset to process a male-sounding voice; otherwise, you may not hear the anticipated voice effect.
  @JsonValue(0x02020300)
  voiceChangerEffectBoy,

  /// A young woman's voice. Agora recommends using this preset to process a female-sounding voice; otherwise, you may not hear the anticipated voice effect.
  @JsonValue(0x02020400)
  voiceChangerEffectSister,

  /// A girl's voice. Agora recommends using this preset to process a female-sounding voice; otherwise, you may not hear the anticipated voice effect.
  @JsonValue(0x02020500)
  voiceChangerEffectGirl,

  /// The voice of Pig King, a character in Journey to the West who has a voice like a growling bear.
  @JsonValue(0x02020600)
  voiceChangerEffectPigking,

  /// The Hulk's voice.
  @JsonValue(0x02020700)
  voiceChangerEffectHulk,

  /// The voice effect typical of R&B music.
  @JsonValue(0x02030100)
  styleTransformationRnb,

  /// The voice effect typical of popular music.
  @JsonValue(0x02030200)
  styleTransformationPopular,

  /// A pitch correction effect that corrects the user's pitch based on the pitch of the natural C major scale. After setting this voice effect, you can call setAudioEffectParameters to adjust the basic mode of tuning and the pitch of the main tone.
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
  /// The headphone equalizer is disabled, and the original audio is heard.
  @JsonValue(0x00000000)
  headphoneEqualizerOff,

  /// An equalizer is used for headphones.
  @JsonValue(0x04000001)
  headphoneEqualizerOverear,

  /// An equalizer is used for in-ear headphones.
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

/// Screen sharing configurations.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ScreenCaptureParameters {
  /// @nodoc
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

  /// The video encoding resolution of the screen sharing stream. See VideoDimensions. The default value is 1920 × 1080, that is, 2,073,600 pixels. Agora uses the value of this parameter to calculate the charges. If the screen dimensions are different from the value of this parameter, Agora applies the following strategies for encoding. Suppose dimensions is set to 1920 × 1080:
  ///  If the value of the screen dimensions is lower than that of dimensions, for example, 1000 × 1000 pixels, the SDK uses the screen dimensions, that is, 1000 × 1000 pixels, for encoding.
  ///  If the value of the screen dimensions is higher than that of dimensions, for example, 2000 × 1500, the SDK uses the maximum value under dimensions with the aspect ratio of the screen dimension (4:3) for encoding, that is, 1440 × 1080. When setting the encoding resolution in the scenario of sharing documents (screenScenarioDocument), choose one of the following two methods:
  ///  If you require the best image quality, it is recommended to set the encoding resolution to be the same as the capture resolution.
  ///  If you wish to achieve a relative balance between image quality, bandwidth, and system performance, then:
  ///  When the capture resolution is greater than 1920 × 1080, it is recommended that the encoding resolution is not less than 1920 × 1080.
  ///  When the capture resolution is less than 1920 × 1080, it is recommended that the encoding resolution is not less than 1280 × 720.
  @JsonKey(name: 'dimensions')
  final VideoDimensions? dimensions;

  /// The frame rate of the shared region. The frame rate (fps) of the shared region. The default value is 5. Agora does not recommend setting this to a value greater than 15.
  @JsonKey(name: 'frameRate')
  final int? frameRate;

  /// The bitrate of the shared region. The bitrate (Kbps) of the shared region. The default value is 0 (the SDK works out a bitrate according to the dimensions of the current screen).
  @JsonKey(name: 'bitrate')
  final int? bitrate;

  /// Whether to capture the mouse in screen sharing: true : (Default) Capture the mouse. false : Do not capture the mouse. Due to macOS system restrictions, setting this parameter to false is ineffective during screen sharing (it has no impact when sharing a window).
  @JsonKey(name: 'captureMouseCursor')
  final bool? captureMouseCursor;

  /// Whether to bring the window to the front when calling the startScreenCaptureByWindowId method to share it: true : Bring the window to the front. false : (Default) Do not bring the window to the front. Due to macOS system limitations, when setting this member to bring the window to the front, if the current app has multiple windows, only the main window will be brought to the front.
  @JsonKey(name: 'windowFocus')
  final bool? windowFocus;

  /// The ID list of the windows to be blocked. When calling startScreenCaptureByDisplayId to start screen sharing, you can use this parameter to block a specified window. When calling updateScreenCaptureParameters to update screen sharing configurations, you can use this parameter to dynamically block a specified window.
  @JsonKey(name: 'excludeWindowList')
  final List<int>? excludeWindowList;

  /// The number of windows to be excluded. On the Windows platform, the maximum value of this parameter is 24; if this value is exceeded, excluding the window fails.
  @JsonKey(name: 'excludeWindowCount')
  final int? excludeWindowCount;

  /// (For macOS and Windows only) The width (px) of the border. The default value is 5, and the value range is (0, 50]. This parameter only takes effect when highLighted is set to true.
  @JsonKey(name: 'highLightWidth')
  final int? highLightWidth;

  /// (For macOS and Windows only)
  ///  On Windows platforms, the color of the border in ARGB format. The default value is 0xFF8CBF26.
  ///  On macOS, COLOR_CLASS refers to NSColor.
  @JsonKey(name: 'highLightColor')
  final int? highLightColor;

  /// (For macOS and Windows only) Whether to place a border around the shared window or screen: true : Place a border. false : (Default) Do not place a border. When you share a part of a window or screen, the SDK places a border around the entire window or screen if you set this parameter to true.
  @JsonKey(name: 'enableHighLight')
  final bool? enableHighLight;

  /// @nodoc
  factory ScreenCaptureParameters.fromJson(Map<String, dynamic> json) =>
      _$ScreenCaptureParametersFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ScreenCaptureParametersToJson(this);
}

/// Recording quality.
@JsonEnum(alwaysCreate: true)
enum AudioRecordingQualityType {
  /// 0: Low quality. The sample rate is 32 kHz, and the file size is around 1.2 MB after 10 minutes of recording.
  @JsonValue(0)
  audioRecordingQualityLow,

  /// 1: Medium quality. The sample rate is 32 kHz, and the file size is around 2 MB after 10 minutes of recording.
  @JsonValue(1)
  audioRecordingQualityMedium,

  /// 2: High quality. The sample rate is 32 kHz, and the file size is around 3.75 MB after 10 minutes of recording.
  @JsonValue(2)
  audioRecordingQualityHigh,

  /// 3: Ultra high quality. The sample rate is 32 kHz, and the file size is around 7.5 MB after 10 minutes of recording.
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
  /// 1: Only records the audio of the local user.
  @JsonValue(1)
  audioFileRecordingMic,

  /// 2: Only records the audio of all remote users.
  @JsonValue(2)
  audioFileRecordingPlayback,

  /// 3: Records the mixed audio of the local and all remote users.
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

/// Recording configurations.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioRecordingConfiguration {
  /// @nodoc
  const AudioRecordingConfiguration(
      {this.filePath,
      this.encode,
      this.sampleRate,
      this.fileRecordingType,
      this.quality,
      this.recordingChannel});

  /// The absolute path (including the filename extensions) of the recording file. For example: C:\music\audio.aac. Ensure that the directory for the log files exists and is writable.
  @JsonKey(name: 'filePath')
  final String? filePath;

  /// Whether to encode the audio data: true : Encode audio data in AAC. false : (Default) Do not encode audio data, but save the recorded audio data directly.
  @JsonKey(name: 'encode')
  final bool? encode;

  /// Recording sample rate (Hz).
  ///  16000
  ///  (Default) 32000
  ///  44100
  ///  48000 If you set this parameter to 44100 or 48000, Agora recommends recording WAV files, or AAC files with quality set as audioRecordingQualityMedium or audioRecordingQualityHigh for better recording quality.
  @JsonKey(name: 'sampleRate')
  final int? sampleRate;

  /// The recording content. See AudioFileRecordingType.
  @JsonKey(name: 'fileRecordingType')
  final AudioFileRecordingType? fileRecordingType;

  /// Recording quality. See audiorecordingqualitytype. Note: This parameter applies to AAC files only.
  @JsonKey(name: 'quality')
  final AudioRecordingQualityType? quality;

  /// The audio channel of recording: The parameter supports the following values:
  ///  1: (Default) Mono.
  ///  2: Stereo. The actual recorded audio channel is related to the audio channel that you capture.
  ///  If the captured audio is mono and recordingChannel is 2, the recorded audio is the dual-channel data that is copied from mono data, not stereo.
  ///  If the captured audio is dual channel and recordingChannel is 1, the recorded audio is the mono data that is mixed by dual-channel data. The integration scheme also affects the final recorded audio channel. If you need to record in stereo, contact.
  @JsonKey(name: 'recordingChannel')
  final int? recordingChannel;

  /// @nodoc
  factory AudioRecordingConfiguration.fromJson(Map<String, dynamic> json) =>
      _$AudioRecordingConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AudioRecordingConfigurationToJson(this);
}

/// Observer settings for the encoded audio.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioEncodedFrameObserverConfig {
  /// @nodoc
  const AudioEncodedFrameObserverConfig({this.postionType, this.encodingType});

  /// Audio profile. See AudioEncodedFrameObserverPosition.
  @JsonKey(name: 'postionType')
  final AudioEncodedFrameObserverPosition? postionType;

  /// Audio encoding type. See AudioEncodingType.
  @JsonKey(name: 'encodingType')
  final AudioEncodingType? encodingType;

  /// @nodoc
  factory AudioEncodedFrameObserverConfig.fromJson(Map<String, dynamic> json) =>
      _$AudioEncodedFrameObserverConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() =>
      _$AudioEncodedFrameObserverConfigToJson(this);
}

/// The encoded audio observer.
class AudioEncodedFrameObserver {
  /// @nodoc
  const AudioEncodedFrameObserver({
    this.onRecordAudioEncodedFrame,
    this.onPlaybackAudioEncodedFrame,
    this.onMixedAudioEncodedFrame,
  });

  /// Gets the encoded audio data of the local user.
  ///
  /// After calling registerAudioEncodedFrameObserver and setting the encoded audio as audioEncodedFrameObserverPositionRecord, you can get the encoded audio data of the local user from this callback.
  ///
  /// * [channels] The number of channels.
  ///  1: Mono.
  ///  2: Stereo. If the channel uses stereo, the data is interleaved.
  /// * [frameBuffer] The audio buffer.
  /// * [length] The data length (byte).
  /// * [audioEncodedFrameInfo] Audio information after encoding. See EncodedAudioFrameInfo.
  final void Function(Uint8List frameBuffer, int length,
      EncodedAudioFrameInfo audioEncodedFrameInfo)? onRecordAudioEncodedFrame;

  /// Gets the encoded audio data of all remote users.
  ///
  /// After calling registerAudioEncodedFrameObserver and setting the encoded audio as audioEncodedFrameObserverPositionPlayback, you can get encoded audio data of all remote users through this callback.
  ///
  /// * [samplesPerSec] Recording sample rate (Hz).
  /// * [channels] The number of channels.
  ///  1: Mono.
  ///  2: Stereo. If the channel uses stereo, the data is interleaved.
  /// * [samplesPerChannel] The number of samples per channel in the audio frame.
  /// * [frameBuffer] The audio buffer.
  /// * [length] The data length (byte).
  /// * [audioEncodedFrameInfo] Audio information after encoding. See EncodedAudioFrameInfo.
  final void Function(Uint8List frameBuffer, int length,
      EncodedAudioFrameInfo audioEncodedFrameInfo)? onPlaybackAudioEncodedFrame;

  /// Gets the mixed and encoded audio data of the local and all remote users.
  ///
  /// After calling registerAudioEncodedFrameObserver and setting the audio profile as audioEncodedFrameObserverPositionMixed, you can get the mixed and encoded audio data of the local and all remote users through this callback.
  ///
  /// * [samplesPerSec] Recording sample rate (Hz).
  /// * [channels] The number of channels.
  ///  1: Mono.
  ///  2: Stereo. If the channel uses stereo, the data is interleaved.
  /// * [samplesPerChannel] The number of samples per channel in the audio frame.
  /// * [frameBuffer] The audio buffer.
  /// * [length] The data length (byte).
  /// * [audioEncodedFrameInfo] Audio information after encoding. See EncodedAudioFrameInfo.
  final void Function(Uint8List frameBuffer, int length,
      EncodedAudioFrameInfo audioEncodedFrameInfo)? onMixedAudioEncodedFrame;
}

/// The region for connection, which is the region where the server the SDK connects to is located.
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

/// The error code of the channel media relay.
@JsonEnum(alwaysCreate: true)
enum ChannelMediaRelayError {
  /// 0: No error.
  @JsonValue(0)
  relayOk,

  /// 1: An error occurs in the server response.
  @JsonValue(1)
  relayErrorServerErrorResponse,

  /// 2: No server response. This error may be caused by poor network connections. If this error occurs when initiating a channel media relay, you can try again later; if this error occurs during channel media relay, you can call leaveChannel to leave the channel. This error can also occur if the channel media relay service is not enabled in the project. You can contact to enable the service.
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

  /// 8: The SDK disconnects from the server due to poor network connections. You can call leaveChannel to leave the channel.
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

/// The state code of the channel media relay.
@JsonEnum(alwaysCreate: true)
enum ChannelMediaRelayState {
  /// 0: The initial state. After you successfully stop the channel media relay by calling stopChannelMediaRelay, the onChannelMediaRelayStateChanged callback returns this state.
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
class ChannelMediaInfo {
  /// @nodoc
  const ChannelMediaInfo({this.uid, this.channelName, this.token});

  /// The user ID.
  @JsonKey(name: 'uid')
  final int? uid;

  /// The channel name.
  @JsonKey(name: 'channelName')
  final String? channelName;

  /// The token that enables the user to join the channel.
  @JsonKey(name: 'token')
  final String? token;

  /// @nodoc
  factory ChannelMediaInfo.fromJson(Map<String, dynamic> json) =>
      _$ChannelMediaInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ChannelMediaInfoToJson(this);
}

/// Configuration of cross channel media relay.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ChannelMediaRelayConfiguration {
  /// @nodoc
  const ChannelMediaRelayConfiguration(
      {this.srcInfo, this.destInfos, this.destCount});

  /// The information of the source channel. See ChannelMediaInfo. It contains the following members: channelName : The name of the source channel. The default value is NULL, which means the SDK applies the name of the current channel. token : The token for joining the source channel. This token is generated with the channelName and uid you set in srcInfo.
  ///  If you have not enabled the App Certificate, set this parameter as the default value NULL, which means the SDK applies the App ID.
  ///  If you have enabled the App Certificate, you must use the token generated with the channelName and uid, and the uid must be set as 0. uid : The unique user ID to identify the relay stream in the source channel. Agora recommends leaving the default value of 0 unchanged.
  @JsonKey(name: 'srcInfo')
  final ChannelMediaInfo? srcInfo;

  /// The information of the target channel ChannelMediaInfo. It contains the following members: channelName : The name of the target channel. token : The token for joining the target channel. It is generated with the channelName and uid you set in destInfos.
  ///  If you have not enabled the App Certificate, set this parameter as the default value NULL, which means the SDK applies the App ID.
  ///  If you have enabled the App Certificate, you must use the token generated with the channelName and uid. If the token of any target channel expires, the whole media relay stops; hence Agora recommends that you specify the same expiration time for the tokens of all the target channels. uid : The unique user ID to identify the relay stream in the target channel. The value ranges from 0 to (2 32 -1). To avoid user ID conflicts, this user ID must be different from any other user ID in the target channel. The default value is 0, which means the SDK generates a random user ID.
  @JsonKey(name: 'destInfos')
  final List<ChannelMediaInfo>? destInfos;

  /// The number of target channels. The default value is 0, and the value range is from 0 to 6. Ensure that the value of this parameter corresponds to the number of ChannelMediaInfo structs you define in destInfo.
  @JsonKey(name: 'destCount')
  final int? destCount;

  /// @nodoc
  factory ChannelMediaRelayConfiguration.fromJson(Map<String, dynamic> json) =>
      _$ChannelMediaRelayConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ChannelMediaRelayConfigurationToJson(this);
}

/// The uplink network information.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class UplinkNetworkInfo {
  /// @nodoc
  const UplinkNetworkInfo({this.videoEncoderTargetBitrateBps});

  /// The target video encoder bitrate (bps).
  @JsonKey(name: 'video_encoder_target_bitrate_bps')
  final int? videoEncoderTargetBitrateBps;

  /// @nodoc
  factory UplinkNetworkInfo.fromJson(Map<String, dynamic> json) =>
      _$UplinkNetworkInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$UplinkNetworkInfoToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class DownlinkNetworkInfo {
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

  /// @nodoc
  Map<String, dynamic> toJson() => _$DownlinkNetworkInfoToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class PeerDownlinkInfo {
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

  /// @nodoc
  Map<String, dynamic> toJson() => _$PeerDownlinkInfoToJson(this);
}

/// The built-in encryption mode.
///
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

  /// Enumerator boundary.
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

/// Built-in encryption configurations.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class EncryptionConfig {
  /// @nodoc
  const EncryptionConfig(
      {this.encryptionMode,
      this.encryptionKey,
      this.encryptionKdfSalt,
      this.datastreamEncryptionEnabled});

  /// The built-in encryption mode. See EncryptionMode. Agora recommends using aes128Gcm2 or aes256Gcm2 encrypted mode. These two modes support the use of salt for higher security.
  @JsonKey(name: 'encryptionMode')
  final EncryptionMode? encryptionMode;

  /// Encryption key in string type with unlimited length. Agora recommends using a 32-byte key. If you do not set an encryption key or set it as NULL, you cannot use the built-in encryption, and the SDK returns -2.
  @JsonKey(name: 'encryptionKey')
  final String? encryptionKey;

  /// Salt, 32 bytes in length. Agora recommends that you use OpenSSL to generate salt on the server side. See Media Stream Encryption for details. This parameter takes effect only in aes128Gcm2 or aes256Gcm2 encrypted mode. In this case, ensure that this parameter is not 0.
  @JsonKey(name: 'encryptionKdfSalt', ignore: true)
  final Uint8List? encryptionKdfSalt;

  /// Whether to enable data stream encryption: true : Enable data stream encryption. false : (Default) Disable data stream encryption.
  @JsonKey(name: 'datastreamEncryptionEnabled')
  final bool? datastreamEncryptionEnabled;

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

  /// 1: Media stream decryption error. Ensure that the receiver and the sender use the same encryption mode and key.
  @JsonValue(1)
  encryptionErrorDecryptionFailure,

  /// 2: Media stream encryption error.
  @JsonValue(2)
  encryptionErrorEncryptionFailure,

  /// 3: Data stream decryption error. Ensure that the receiver and the sender use the same encryption mode and key.
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

/// The type of the device permission.
@JsonEnum(alwaysCreate: true)
enum PermissionType {
  /// 0: Permission for the audio capture device.
  @JsonValue(0)
  recordAudio,

  /// 1: Permission for the camera.
  @JsonValue(1)
  camera,

  /// (For Android only) 2: Permission for screen sharing.
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

/// The subscribing state.
@JsonEnum(alwaysCreate: true)
enum StreamSubscribeState {
  /// 0: The initial publishing state after joining the channel.
  @JsonValue(0)
  subStateIdle,

  /// 1: Fails to subscribe to the remote stream. Possible reasons:
  ///  The remote user:
  ///  Calls muteLocalAudioStream (true) or muteLocalVideoStream (true) to stop sending local media stream.
  ///  Calls disableAudio or disableVideo to disable the local audio or video module.
  ///  Calls enableLocalAudio (false) or enableLocalVideo (false) to disable local audio or video capture.
  ///  The role of the remote user is audience.
  ///  The local user calls the following methods to stop receiving remote streams:
  ///  Call muteRemoteAudioStream (true) or muteAllRemoteAudioStreams (true) to stop receiving the remote audio stream.
  ///  Call muteRemoteVideoStream (true) or muteAllRemoteVideoStreams (true) to stop receiving the remote video stream.
  @JsonValue(1)
  subStateNoSubscribed,

  /// 2: Subscribing.
  @JsonValue(2)
  subStateSubscribing,

  /// 3: The remote stream is received, and the subscription is successful.
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

/// The publishing state.
@JsonEnum(alwaysCreate: true)
enum StreamPublishState {
  /// 0: The initial publishing state after joining the channel.
  @JsonValue(0)
  pubStateIdle,

  /// 1: Fails to publish the local stream. Possible reasons:
  ///  The local user calls muteLocalAudioStream (true) or muteLocalVideoStream (true) to stop sending local media streams.
  ///  The local user calls disableAudio or disableVideo to disable the local audio or video module.
  ///  The local user calls enableLocalAudio (false) or enableLocalVideo (false) to disable the local audio or video capture.
  ///  The role of the local user is audience.
  @JsonValue(1)
  pubStateNoPublished,

  /// 2: Publishing.
  @JsonValue(2)
  pubStatePublishing,

  /// 3: Publishes successfully.
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

/// The configuration of the audio and video call loop test.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class EchoTestConfiguration {
  /// @nodoc
  const EchoTestConfiguration(
      {this.view,
      this.enableAudio,
      this.enableVideo,
      this.token,
      this.channelId,
      this.intervalInSeconds});

  /// The view used to render the local user's video. This parameter is only applicable to scenarios testing video devices, that is, when enableVideo is true.
  @JsonKey(name: 'view')
  final int? view;

  /// Whether to enable the audio device for the loop test: true : (Default) Enable the audio device. To test the audio device, set this parameter as true. false : Disable the audio device.
  @JsonKey(name: 'enableAudio')
  final bool? enableAudio;

  /// Whether to enable the video device for the loop test. Currently, video device loop test is not supported. Please set this parameter to false.
  @JsonKey(name: 'enableVideo')
  final bool? enableVideo;

  /// The token used to secure the audio and video call loop test. If you do not enable App Certificate in Agora Console, you do not need to pass a value in this parameter; if you have enabled App Certificate in Agora Console, you must pass a token in this parameter; the uid used when you generate the token must be 0xFFFFFFFF, and the channel name used must be the channel name that identifies each audio and video call loop tested. For server-side token generation, see.
  @JsonKey(name: 'token')
  final String? token;

  /// The channel name that identifies each audio and video call loop. To ensure proper loop test functionality, the channel name passed in to identify each loop test cannot be the same when users of the same project (App ID) perform audio and video call loop tests on different devices.
  @JsonKey(name: 'channelId')
  final String? channelId;

  /// Set the time interval or delay for returning the results of the audio and video loop test. The value range is [2,10], in seconds, with the default value being 2 seconds.
  ///  For audio loop tests, the test results will be returned according to the time interval you set.
  ///  For video loop tests, the video will be displayed in a short time, after which the delay will gradually increase until it reaches the delay you set.
  @JsonKey(name: 'intervalInSeconds')
  final int? intervalInSeconds;

  /// @nodoc
  factory EchoTestConfiguration.fromJson(Map<String, dynamic> json) =>
      _$EchoTestConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$EchoTestConfigurationToJson(this);
}

/// The information of the user.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class UserInfo {
  /// @nodoc
  const UserInfo({this.uid, this.userAccount});

  /// The user ID.
  @JsonKey(name: 'uid')
  final int? uid;

  /// User account. The maximum data length is MaxUserAccountLengthType.
  @JsonKey(name: 'userAccount')
  final String? userAccount;

  /// @nodoc
  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

/// The audio filter types of in-ear monitoring.
@JsonEnum(alwaysCreate: true)
enum EarMonitoringFilterType {
  /// 1<<0: No audio filter added to in-ear monitoring.
  @JsonValue((1 << 0))
  earMonitoringFilterNone,

  /// 1<<1: Add vocal effects audio filter to in-ear monitoring. If you implement functions such as voice beautifier and audio effect, users can hear the voice after adding these effects.
  @JsonValue((1 << 1))
  earMonitoringFilterBuiltInAudioFilters,

  /// 1<<2: Add noise suppression audio filter to in-ear monitoring.
  @JsonValue((1 << 2))
  earMonitoringFilterNoiseSuppression,

  /// 1<<15: Reuse the audio filter that has been processed on the sending end for in-ear monitoring. This enumerator reduces CPU usage while increasing in-ear monitoring latency, which is suitable for latency-tolerant scenarios requiring low CPU consumption.
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

/// The video configuration for the shared screen stream.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ScreenVideoParameters {
  /// @nodoc
  const ScreenVideoParameters(
      {this.dimensions, this.frameRate, this.bitrate, this.contentHint});

  /// The video encoding dimension. The default value is 1280 × 720.
  @JsonKey(name: 'dimensions')
  final VideoDimensions? dimensions;

  /// The video encoding frame rate (fps). The default value is 15.
  @JsonKey(name: 'frameRate')
  final int? frameRate;

  /// The video encoding bitrate (Kbps).
  @JsonKey(name: 'bitrate')
  final int? bitrate;

  /// The content hint for screen sharing.
  @JsonKey(name: 'contentHint')
  final VideoContentHint? contentHint;

  /// @nodoc
  factory ScreenVideoParameters.fromJson(Map<String, dynamic> json) =>
      _$ScreenVideoParametersFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ScreenVideoParametersToJson(this);
}

/// The audio configuration for the shared screen stream.
///
/// Only available where captureAudio is true.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ScreenAudioParameters {
  /// @nodoc
  const ScreenAudioParameters(
      {this.sampleRate, this.channels, this.captureSignalVolume});

  /// Audio sample rate (Hz). The default value is 16000.
  @JsonKey(name: 'sampleRate')
  final int? sampleRate;

  /// The number of audio channels. The default value is 2, which means stereo.
  @JsonKey(name: 'channels')
  final int? channels;

  /// The volume of the captured system audio. The value range is [0, 100]. The default value is 100.
  @JsonKey(name: 'captureSignalVolume')
  final int? captureSignalVolume;

  /// @nodoc
  factory ScreenAudioParameters.fromJson(Map<String, dynamic> json) =>
      _$ScreenAudioParametersFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ScreenAudioParametersToJson(this);
}

/// Screen sharing configurations.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ScreenCaptureParameters2 {
  /// @nodoc
  const ScreenCaptureParameters2(
      {this.captureAudio,
      this.audioParams,
      this.captureVideo,
      this.videoParams});

  /// Determines whether to capture system audio during screen sharing: true : Capture system audio. false : (Default) Do not capture system audio.
  ///  Due to system limitations, capturing system audio is only applicable to Android API level 29 and later (that is, Android 10 and later).
  ///  To improve the success rate of capturing system audio during screen sharing, ensure that you have called the setAudioScenario method and set the audio scenario to audioScenarioGameStreaming.
  @JsonKey(name: 'captureAudio')
  final bool? captureAudio;

  /// The audio configuration for the shared screen stream. See ScreenAudioParameters. This parameter only takes effect when captureAudio is true.
  @JsonKey(name: 'audioParams')
  final ScreenAudioParameters? audioParams;

  /// Whether to capture the screen when screen sharing: true : (Default) Capture the screen. false : Do not capture the screen. Due to system limitations, the capture screen is only applicable to Android API level 21 and above, that is, Android 5 and above.
  @JsonKey(name: 'captureVideo')
  final bool? captureVideo;

  /// The video configuration for the shared screen stream. See ScreenVideoParameters. This parameter only takes effect when captureVideo is true.
  @JsonKey(name: 'videoParams')
  final ScreenVideoParameters? videoParams;

  /// @nodoc
  factory ScreenCaptureParameters2.fromJson(Map<String, dynamic> json) =>
      _$ScreenCaptureParameters2FromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ScreenCaptureParameters2ToJson(this);
}

/// The rendering state of the media frame.
@JsonEnum(alwaysCreate: true)
enum MediaTraceEvent {
  /// 0: The video frame has been rendered.
  @JsonValue(0)
  mediaTraceEventVideoRendered,

  /// 1: The video frame has been decoded.
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

/// Indicators during video frame rendering progress.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoRenderingTracingInfo {
  /// @nodoc
  const VideoRenderingTracingInfo(
      {this.elapsedTime,
      this.start2JoinChannel,
      this.join2JoinSuccess,
      this.joinSuccess2RemoteJoined,
      this.remoteJoined2SetView,
      this.remoteJoined2UnmuteVideo,
      this.remoteJoined2PacketReceived});

  /// The time interval (ms) from startMediaRenderingTracing to SDK triggering the onVideoRenderingTracingResult callback. Agora recommends you call startMediaRenderingTracing before joining a channel.
  @JsonKey(name: 'elapsedTime')
  final int? elapsedTime;

  /// The time interval (ms) from startMediaRenderingTracing to joinChannel. A negative number indicates that startMediaRenderingTracing is called after calling joinChannel.
  @JsonKey(name: 'start2JoinChannel')
  final int? start2JoinChannel;

  /// The time interval (ms) from or joinChannel to successfully joining the channel.
  @JsonKey(name: 'join2JoinSuccess')
  final int? join2JoinSuccess;

  /// If the local user calls startMediaRenderingTracing before successfully joining the channel, this value is the time interval (ms) from the local user successfully joining the channel to the remote user joining the channel.
  ///  If the local user calls startMediaRenderingTracing after successfully joining the channel, the value is the time interval (ms) from startMediaRenderingTracing to when the remote user joins the channel.
  ///  If the local user calls startMediaRenderingTracing after the remote user joins the channel, the value is 0 and meaningless.
  ///  In order to reduce the time of rendering the first frame for remote users, Agora recommends that the local user joins the channel when the remote user is in the channel to reduce this value.
  @JsonKey(name: 'joinSuccess2RemoteJoined')
  final int? joinSuccess2RemoteJoined;

  /// If the local user calls startMediaRenderingTracing before the remote user joins the channel, this value is the time interval (ms) from when the remote user joins the channel to when the local user sets the remote view.
  ///  If the local user calls startMediaRenderingTracing after the remote user joins the channel, this value is the time interval (ms) from calling startMediaRenderingTracing to setting the remote view.
  ///  If the local user calls startMediaRenderingTracing after setting the remote view, the value is 0 and has no effect.
  ///  In order to reduce the time of rendering the first frame for remote users, Agora recommends that the local user sets the remote view before the remote user joins the channel, or sets the remote view immediately after the remote user joins the channel to reduce this value.
  @JsonKey(name: 'remoteJoined2SetView')
  final int? remoteJoined2SetView;

  /// If the local user calls startMediaRenderingTracing before the remote user joins the channel, this value is the time interval (ms) from the remote user joining the channel to subscribing to the remote video stream.
  ///  If the local user calls startMediaRenderingTracing after the remote user joins the channel, this value is the time interval (ms) from startMediaRenderingTracing to subscribing to the remote video stream.
  ///  If the local user calls startMediaRenderingTracing after subscribing to the remote video stream, the value is 0 and has no effect.
  ///  In order to reduce the time of rendering the first frame for remote users, Agora recommends that after the remote user joins the channel, the local user immediately subscribes to the remote video stream to reduce this value.
  @JsonKey(name: 'remoteJoined2UnmuteVideo')
  final int? remoteJoined2UnmuteVideo;

  /// If the local user calls startMediaRenderingTracing before the remote user joins the channel, this value is the time interval (ms) from when the remote user joins the channel to when the local user receives the remote video stream.
  ///  If the local user calls startMediaRenderingTracing after the remote user joins the channel, this value is the time interval (ms) from startMediaRenderingTracing to receiving the remote video stream.
  ///  If the local user calls startMediaRenderingTracing after receiving the remote video stream, the value is 0 and has no effect.
  ///  In order to reduce the time of rendering the first frame for remote users, Agora recommends that the remote user publishes video streams immediately after joining the channel, and the local user immediately subscribes to remote video streams to reduce this value.
  @JsonKey(name: 'remoteJoined2PacketReceived')
  final int? remoteJoined2PacketReceived;

  /// @nodoc
  factory VideoRenderingTracingInfo.fromJson(Map<String, dynamic> json) =>
      _$VideoRenderingTracingInfoFromJson(json);

  /// @nodoc
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

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LogUploadServerInfo {
  /// @nodoc
  const LogUploadServerInfo(
      {this.serverDomain, this.serverPath, this.serverPort, this.serverHttps});

  /// @nodoc
  @JsonKey(name: 'serverDomain')
  final String? serverDomain;

  /// @nodoc
  @JsonKey(name: 'serverPath')
  final String? serverPath;

  /// @nodoc
  @JsonKey(name: 'serverPort')
  final int? serverPort;

  /// @nodoc
  @JsonKey(name: 'serverHttps')
  final bool? serverHttps;

  /// @nodoc
  factory LogUploadServerInfo.fromJson(Map<String, dynamic> json) =>
      _$LogUploadServerInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LogUploadServerInfoToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AdvancedConfigInfo {
  /// @nodoc
  const AdvancedConfigInfo({this.logUploadServer});

  /// @nodoc
  @JsonKey(name: 'logUploadServer')
  final LogUploadServerInfo? logUploadServer;

  /// @nodoc
  factory AdvancedConfigInfo.fromJson(Map<String, dynamic> json) =>
      _$AdvancedConfigInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AdvancedConfigInfoToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LocalAccessPointConfiguration {
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

  /// @nodoc
  @JsonKey(name: 'ipList')
  final List<String>? ipList;

  /// @nodoc
  @JsonKey(name: 'ipListSize')
  final int? ipListSize;

  /// @nodoc
  @JsonKey(name: 'domainList')
  final List<String>? domainList;

  /// @nodoc
  @JsonKey(name: 'domainListSize')
  final int? domainListSize;

  /// @nodoc
  @JsonKey(name: 'verifyDomainName')
  final String? verifyDomainName;

  /// @nodoc
  @JsonKey(name: 'mode')
  final LocalProxyMode? mode;

  /// @nodoc
  @JsonKey(name: 'advancedConfig')
  final AdvancedConfigInfo? advancedConfig;

  /// @nodoc
  @JsonKey(name: 'disableAut')
  final bool? disableAut;

  /// @nodoc
  factory LocalAccessPointConfiguration.fromJson(Map<String, dynamic> json) =>
      _$LocalAccessPointConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LocalAccessPointConfigurationToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RecorderStreamInfo {
  /// @nodoc
  const RecorderStreamInfo({this.channelId, this.uid});

  /// @nodoc
  @JsonKey(name: 'channelId')
  final String? channelId;

  /// @nodoc
  @JsonKey(name: 'uid')
  final int? uid;

  /// @nodoc
  factory RecorderStreamInfo.fromJson(Map<String, dynamic> json) =>
      _$RecorderStreamInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RecorderStreamInfoToJson(this);
}

/// The spatial audio parameters.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SpatialAudioParams {
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

  /// @nodoc
  Map<String, dynamic> toJson() => _$SpatialAudioParamsToJson(this);
}

/// Layout information of a specific sub-video stream within the mixed stream.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoLayout {
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

  /// The channel name to which the sub-video stream belongs.
  @JsonKey(name: 'channelId')
  final String? channelId;

  /// User ID who published this sub-video stream.
  @JsonKey(name: 'uid')
  final int? uid;

  /// Reserved for future use.
  @JsonKey(name: 'strUid')
  final String? strUid;

  /// X-coordinate (px) of the sub-video stream on the mixing canvas. The relative lateral displacement of the top left corner of the video for video mixing to the origin (the top left corner of the canvas).
  @JsonKey(name: 'x')
  final int? x;

  /// Y-coordinate (px) of the sub-video stream on the mixing canvas. The relative longitudinal displacement of the top left corner of the captured video to the origin (the top left corner of the canvas).
  @JsonKey(name: 'y')
  final int? y;

  /// Width (px) of the sub-video stream.
  @JsonKey(name: 'width')
  final int? width;

  /// Heitht (px) of the sub-video stream.
  @JsonKey(name: 'height')
  final int? height;

  /// Status of the sub-video stream on the video mixing canvas.
  ///  0: Normal. The sub-video stream has been rendered onto the mixing canvas.
  ///  1: Placeholder image. The sub-video stream has no video frames and is displayed as a placeholder on the mixing canvas.
  ///  2: Black image. The sub-video stream is replaced by a black image.
  @JsonKey(name: 'videoState')
  final int? videoState;

  /// @nodoc
  factory VideoLayout.fromJson(Map<String, dynamic> json) =>
      _$VideoLayoutFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$VideoLayoutToJson(this);
}
