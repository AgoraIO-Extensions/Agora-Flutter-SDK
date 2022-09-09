import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_base.g.dart';

/// 频道场景。
///
@JsonEnum(alwaysCreate: true)
enum ChannelProfileType {
  /// 0: 通信场景。当频道中只有两个用户时，建议使用该场景。
  @JsonValue(0)
  channelProfileCommunication,

  /// 1: 直播场景。直播场景。当频道中超过两个用户时，建议使用该场景。
  @JsonValue(1)
  channelProfileLiveBroadcasting,

  /// 2: （已废弃）游戏场景。
  @JsonValue(2)
  channelProfileGame,

  /// 3: 互动场景。该场景对延时进行了优化。如果你的场景中有用户需要频道互动， 建议使用该场景。
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

/// 错误代码。
/// 错误代码意味着 SDK 遇到不可恢复的错误，需要应用程序干预。例如：打开摄像头失败时会返回错误，app 需要提示用户不能使用摄像头。
@JsonEnum(alwaysCreate: true)
enum ErrorCodeType {
  /// 0：没有错误。
  @JsonValue(0)
  errOk,

  /// 1：一般性的错误（没有明确归类的错误原因）。请重新调用方法。
  @JsonValue(1)
  errFailed,

  /// 2：方法中设置了无效的参数。例如指定的频道名中含有非法字符。请重新设置参数。
  @JsonValue(2)
  errInvalidArgument,

  /// 3：SDK 尚未准备好。可能的原因有： RtcEngine 初始化失败。请重新初始化 RtcEngine。调用方法时用户尚未加入频道。请检查方法的调用逻辑。调用 rate 或 complain 方法时用户尚未离开频道。请检查方法的调用逻辑。音频模块未开启。程序集不完整。
  @JsonValue(3)
  errNotReady,

  /// 4：RtcEngine 当前状态不支持该操作。可能的原因有： 使用内置加密时，设置的加密模式不正确，或加载外部加密库失败。请检查加密的枚举值是否正确，或重新加载外部加密库。
  @JsonValue(4)
  errNotSupported,

  /// 5：方法调用被拒绝。可能的原因有： RtcEngine 初始化失败。请重新初始化 RtcEngine。在加入频道时，将频道名设为空字符 ""。请重新设置频道名。多频道场景下，在调用 joinChannelEx 方法加入频道时，设置的频道名已存在。请重新设置频道名。
  @JsonValue(5)
  errRefused,

  /// 6：缓冲区大小不足以存放返回的数据。
  @JsonValue(6)
  errBufferTooSmall,

  /// 7：RtcEngine 尚未初始化就调用方法。请确认在调用该方法前已创建 RtcEngine 对象并完成初始化。
  @JsonValue(7)
  errNotInitialized,

  /// @nodoc
  @JsonValue(8)
  errInvalidState,

  /// 9：没有操作权限。请检查用户是否授予了 app 音视频设备的使用权限。
  @JsonValue(9)
  errNoPermission,

  /// 10： 方法调用超时。有些方法调用需要 SDK 返回结果，如果 SDK 处理事件过长，超过 10 秒没有返回，会出现此错误。
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

  /// 17：加入频道被拒绝。可能的原因有： 用户已经在频道中。Agora 推荐通过 onConnectionStateChanged 回调判断用户是否在频道中。除收到 connectionStateDisconnected(1) 状态外，不要再次调用该方法加入频道。用户在调用 startEchoTest 进行通话测试后，未调用 stopEchoTest 结束当前测试就尝试加入频道。开始通话测试后，需要先调用 stopEchoTest 结束当前测试，再加入频道。
  @JsonValue(17)
  errJoinChannelRejected,

  /// 18：离开频道失败。可能的原因有： 调用 leaveChannel [1/2] 前，用户已离开频道。停止调用该方法即可。用户尚未加入频道，就调用 leaveChannel [1/2] 退出频道。这种情况下无需额外操作。
  @JsonValue(18)
  errLeaveChannelRejected,

  /// 19：资源已被占用，不能重复使用。
  @JsonValue(19)
  errAlreadyInUse,

  /// 20：SDK 放弃请求，可能由于请求的次数太多。
  @JsonValue(20)
  errAborted,

  /// 21：Windows 下特定的防火墙设置导致 RtcEngine 初始化失败然后崩溃。
  @JsonValue(21)
  errInitNetEngine,

  /// 22：SDK 分配资源失败，可能由于 app 占用资源过多或系统资源耗尽。
  @JsonValue(22)
  errResourceLimited,

  /// 101：不是有效的 App ID。请更换有效的 App ID 重新加入频道。
  @JsonValue(101)
  errInvalidAppId,

  /// 102：不是有效的频道名。可能的原因是设置的参数数据类型不正确。请更换有效的频道名重新加入频道。
  @JsonValue(102)
  errInvalidChannelName,

  /// 103：无法获取当前区域的服务器资源。请在初始化 RtcEngine 时尝试指定其他区域。
  @JsonValue(103)
  errNoServerResources,

  /// 109：当前使用的 Token 过期，不再有效。请在服务端申请生成新的 Token，并调用 renewToken 更新 Token。
  ///  弃用：该枚举已废弃。请改用 onConnectionStateChanged 回调中的 connectionChangedTokenExpired(9)。
  @JsonValue(109)
  errTokenExpired,

  /// 110：Token 无效。一般有以下原因：
  ///  在 Agora 控制台中启用了 App 证书，但未使用 App ID + Token 鉴权。当项目启用了 App 证书，就必须使用 Token 鉴权。生成 Token 时填入的 uid 字段，和用户加入频道时填入的 uid 不匹配。弃用：该枚举已废弃。请改用 onConnectionStateChanged 回调中的 connectionChangedInvalidToken(8)。
  @JsonValue(110)
  errInvalidToken,

  /// 111：网络连接中断。SDK 在和服务器建立连接后，失去网络连接超过 4 秒。
  @JsonValue(111)
  errConnectionInterrupted,

  /// 112：网络连接丢失。网络连接中断，且 SDK 无法在 10 秒内连接服务器。
  @JsonValue(112)
  errConnectionLost,

  /// 113：调用 sendStreamMessage 方法时用户不在频道内。
  @JsonValue(113)
  errNotInChannel,

  /// 114：在调用 sendStreamMessage 时，发送的数据长度大于 1 KB。
  @JsonValue(114)
  errSizeTooLarge,

  /// 115：在调用 sendStreamMessage 时，发送数据的频率超过限制（6 KB/s）。
  @JsonValue(115)
  errBitrateLimit,

  /// 116：在调用 createDataStream 时，创建的数据流超过限制（5 个）。
  @JsonValue(116)
  errTooManyDataStreams,

  /// 117：数据流发送超时。
  @JsonValue(117)
  errStreamMessageTimeout,

  /// 119：用户切换角色失败，请尝试重新加入频道。
  @JsonValue(119)
  errSetClientRoleNotAuthorized,

  /// 120：解密失败。可能是用户加入频道时使用了错误的密码。请检查用户加入频道时填入的密码，或引导用户尝试重新加入频道。
  @JsonValue(120)
  errDecryptionFailed,

  /// 121：该用户 ID 无效。
  @JsonValue(121)
  errInvalidUserId,

  /// 123：该用户被服务器禁止。
  @JsonValue(123)
  errClientIsBannedByServer,

  /// 130：SDK 不支持将加密过的流推到 CDN 上。
  @JsonValue(130)
  errEncryptedStreamNotAllowedPublish,

  /// @nodoc
  @JsonValue(131)
  errLicenseCredentialInvalid,

  /// 134：无效的 user account，可能是因为设置了无效的参数。
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

  /// 1001：加载媒体引擎失败。
  @JsonValue(1001)
  errLoadMediaEngine,

  /// 1005：音频设备出现错误（未指明何种错误）。请检查音频设备是否被其他应用占用，或者尝试重新进入频道。
  @JsonValue(1005)
  errAdmGeneralError,

  /// 1008：初始化播放设备出错。请检查播放设备是否被其他应用占用，或者尝试重新进入频道。
  @JsonValue(1008)
  errAdmInitPlayout,

  /// 1009：启动播放设备出错。请检查播放设备是否正常。
  @JsonValue(1009)
  errAdmStartPlayout,

  /// 1010：停止播放设备出错。
  @JsonValue(1010)
  errAdmStopPlayout,

  /// 1011：初始化录音设备出错。请检查录音设备是否正常，或者尝试重新进入频道。
  @JsonValue(1011)
  errAdmInitRecording,

  /// 1012：启动录音设备出错。请检查录音设备是否正常。
  @JsonValue(1012)
  errAdmStartRecording,

  /// 1013：停止录音设备出错。
  @JsonValue(1013)
  errAdmStopRecording,

  /// 1501：没有摄像头使用权限。请检查是否已经打开摄像头权限。
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

/// SDK 对 Audio Session 的操作权限。
///
@JsonEnum(alwaysCreate: true)
enum AudioSessionOperationRestriction {
  /// 没有限制，SDK 可以对 Audio Session 进行更改。
  @JsonValue(0)
  audioSessionOperationRestrictionNone,

  /// SDK 不能更改 Audio Session 的 category。
  @JsonValue(1)
  audioSessionOperationRestrictionSetCategory,

  /// SDK 不能更改 Audio Session 的 category、mode 或 categoryOptions。
  @JsonValue(1 << 1)
  audioSessionOperationRestrictionConfigureSession,

  /// 离开频道时，SDK 会保持 Audio Session 处于活动状态，例如在后台播放音频。
  @JsonValue(1 << 2)
  audioSessionOperationRestrictionDeactivateSession,

  /// 完全限制 SDK 对 Audio Session 的操作权限，SDK 不能再对 Audio Session 进行任何更改。
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

/// 用户离线原因。
///
@JsonEnum(alwaysCreate: true)
enum UserOfflineReasonType {
  /// 0: 用户主动离开。
  @JsonValue(0)
  userOfflineQuit,

  /// 1: 因过长时间收不到对方数据包，超时掉线。由于 SDK 使用的是不可靠通道，也有可能对方主动离开频道，但是本地没收到对方离开消息而误判为超时掉线。
  @JsonValue(1)
  userOfflineDropped,

  /// 2: 用户身份从主播切换为观众。
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

/// 接口类。
///
@JsonEnum(alwaysCreate: true)
enum InterfaceIdType {
  ///  AudioDeviceManager 接口类。
  @JsonValue(1)
  agoraIidAudioDeviceManager,

  ///  VideoDeviceManager 接口类。
  @JsonValue(2)
  agoraIidVideoDeviceManager,

  /// 该接口类已废弃。
  @JsonValue(3)
  agoraIidParameterEngine,

  ///  MediaEngine 接口类。
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

  ///  MediaRecorder 接口类。
  @JsonValue(12)
  agoraIidMediaRecorder,
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

/// 网络质量。
///
@JsonEnum(alwaysCreate: true)
enum QualityType {
  /// 0: 网络质量未知。
  @JsonValue(0)
  qualityUnknown,

  /// 1: 网络质量极好。
  @JsonValue(1)
  qualityExcellent,

  /// 2: 用户主观感觉和 excellent 差不多，但码率可能略低于 excellent。
  @JsonValue(2)
  qualityGood,

  /// 3: 用户主观感受有瑕疵但不影响沟通。
  @JsonValue(3)
  qualityPoor,

  /// 4: 勉强能沟通但不顺畅。
  @JsonValue(4)
  qualityBad,

  /// 5: 网络质量非常差，基本不能沟通。
  @JsonValue(5)
  qualityVbad,

  /// 6: 完全无法沟通。
  @JsonValue(6)
  qualityDown,

  /// 7: 暂时无法检测网络质量（未使用）。
  @JsonValue(7)
  qualityUnsupported,

  /// 8: 网络质量检测已开始还没完成。
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

/// 视频顺时针旋转信息。
///
@JsonEnum(alwaysCreate: true)
enum VideoOrientation {
  /// 0:（默认）顺时针旋转 0 度。
  @JsonValue(0)
  videoOrientation0,

  /// 90: 顺时针旋转 90 度。
  @JsonValue(90)
  videoOrientation90,

  /// 180: 顺时针旋转 180 度。
  @JsonValue(180)
  videoOrientation180,

  /// 270: 顺时针旋转 270 度。
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

/// 视频帧率。
///
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

  /// 60: 60 fps仅适用于 Windows 和 macOS 平台。
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
  @JsonValue(640)
  frameWidth640,
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
  @JsonValue(360)
  frameHeight360,
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

/// 视频帧类型。
///
@JsonEnum(alwaysCreate: true)
enum VideoFrameType {
  /// 0: 黑帧。
  @JsonValue(0)
  videoFrameTypeBlankFrame,

  /// 3: 关键帧。
  @JsonValue(3)
  videoFrameTypeKeyFrame,

  /// 4: Delta 帧。
  @JsonValue(4)
  videoFrameTypeDeltaFrame,

  /// 5: B 帧。
  @JsonValue(5)
  videoFrameTypeBFrame,

  /// 6: 丢弃帧。
  @JsonValue(6)
  videoFrameTypeDroppableFrame,

  /// 未知帧。
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

/// 视频编码的方向模式。
///
@JsonEnum(alwaysCreate: true)
enum OrientationMode {
  /// 0: （默认）该模式下 SDK 输出的视频方向与采集到的视频方向一致。接收端会根据收到的视频旋转信息对视频进行旋转。该模式适用于接收端可以调整视频方向的场景。如果采集的视频是横屏模式，则输出的视频也是横屏模式。如果采集的视频是竖屏模式，则输出的视频也是竖屏模式。
  @JsonValue(0)
  orientationModeAdaptive,

  /// 1: 该模式下 SDK 固定输出风景（横屏）模式的视频。如果采集到的视频是竖屏模式，则视频编码器会对其进行裁剪。该模式适用于当接收端无法调整视频方向时，如使用旁路推流场景下。
  @JsonValue(1)
  orientationModeFixedLandscape,

  /// 2: 该模式下 SDK 固定输出人像（竖屏）模式的视频，如果采集到的视频是横屏模式，则视频编码器会对其进行裁剪。该模式适用于当接收端无法调整视频方向时，如使用旁路推流场景下。
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

/// 带宽受限时的视频编码降级偏好。
///
@JsonEnum(alwaysCreate: true)
enum DegradationPreference {
  /// 0：（默认）带宽受限时，视频编码时优先降低视频帧率，维持视频质量不变。该降级偏好适用于画质优先的场景。通信（COMMUNICATION）场景下，本地发送的视频分辨率可能改变，远端用户需能处理这种情况， 详见 onVideoSizeChanged 。
  @JsonValue(0)
  maintainQuality,

  /// 1：带宽受限时，视频编码时优先降低视频质量，维持视频帧率不变。该降级偏好适用于流畅性优先且允许画质降低的场景。
  @JsonValue(1)
  maintainFramerate,

  /// 2：带宽受限时，视频编码时同时降低视频帧率和视频质量。maintainBalanced 的降幅比 maintainQuality 和 maintainFramerate 降幅更低，适用于流畅性和画质均有限的场景。本地发送的视频分辨率可能改变，远端用户需能处理这种情况，详见 onVideoSizeChanged 。
  @JsonValue(2)
  maintainBalanced,

  /// 3: 带宽受限时，视频编码时优先降低视频帧率。
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

/// 视频尺寸。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoDimensions {
  /// @nodoc
  const VideoDimensions({this.width, this.height});

  /// 视频宽度，单位为像素。
  @JsonKey(name: 'width')
  final int? width;

  /// 视频高度，单位为像素。
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

/// 视频编码格式。
///
@JsonEnum(alwaysCreate: true)
enum VideoCodecType {
  /// @nodoc
  @JsonValue(0)
  videoCodecNone,

  /// 1：标准 VP8。
  @JsonValue(1)
  videoCodecVp8,

  /// 2：标准 H.264。
  @JsonValue(2)
  videoCodecH264,

  /// 3：标准 H.265。
  @JsonValue(3)
  videoCodecH265,

  /// 6：Generic。本类型主要用于传输视频裸数据(比如用户已加密的视频帧)，该类型视频帧以回调的形式返回给用户，需要用户自行解码与渲染。
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

  /// 20：Generic JPEG。 本类型所需的算力较小，可用于算力有限的 IoT 设备。
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

/// 音频编解码格式。
///
@JsonEnum(alwaysCreate: true)
enum AudioCodecType {
  /// 1: OPUS。
  @JsonValue(1)
  audioCodecOpus,

  /// 3: PCMA。
  @JsonValue(3)
  audioCodecPcma,

  /// 4: PCMU。
  @JsonValue(4)
  audioCodecPcmu,

  /// 5: G722。
  @JsonValue(5)
  audioCodecG722,

  /// 8: LC-AAC。
  @JsonValue(8)
  audioCodecAaclc,

  /// 9: HE-AAC。
  @JsonValue(9)
  audioCodecHeaac,

  /// 10: JC1。
  @JsonValue(10)
  audioCodecJc1,

  /// 11: HE-AAC v2。
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

/// 音频编码类型。
///
@JsonEnum(alwaysCreate: true)
enum AudioEncodingType {
  /// AAC 编码格式，16000 Hz 采样率，低音质。音频时长为 10 分钟的文件编码后大小约为 1.2 MB。
  @JsonValue(0x010101)
  audioEncodingTypeAac16000Low,

  /// AAC 编码格式，16000 Hz 采样率，中音质。音频时长为 10 分钟的文件编码后大小约为 2 MB。
  @JsonValue(0x010102)
  audioEncodingTypeAac16000Medium,

  /// AAC 编码格式，32000 Hz 采样率，低音质。音频时长为 10 分钟的文件编码后大小约为 1.2 MB。
  @JsonValue(0x010201)
  audioEncodingTypeAac32000Low,

  /// AAC 编码格式，32000 Hz 采样率，中音质。音频时长为 10 分钟的文件编码后大小约为 2 MB。
  @JsonValue(0x010202)
  audioEncodingTypeAac32000Medium,

  /// AAC 编码格式，32000 Hz 采样率，高音质。音频时长为 10 分钟的文件编码后大小约为 3.5 MB。
  @JsonValue(0x010203)
  audioEncodingTypeAac32000High,

  /// AAC 编码格式，48000 Hz 采样率，中音质。音频时长为 10 分钟的文件编码后大小约为 2 MB。
  @JsonValue(0x010302)
  audioEncodingTypeAac48000Medium,

  /// AAC 编码格式，48000 Hz 采样率，高音质。音频时长为 10 分钟的文件编码后大小约为 3.5 MB。
  @JsonValue(0x010303)
  audioEncodingTypeAac48000High,

  /// OPUS 编码格式，16000 Hz 采样率，低音质。音频时长为 10 分钟的文件编码后大小约为 2 MB。
  @JsonValue(0x020101)
  audioEncodingTypeOpus16000Low,

  /// OPUS 编码格式，16000 Hz 采样率，中音质。音频时长为 10 分钟的文件编码后大小约为 2 MB。
  @JsonValue(0x020102)
  audioEncodingTypeOpus16000Medium,

  /// OPUS 编码格式，48000 Hz 采样率，中音质。音频时长为 10 分钟的文件编码后大小约为 2 MB。
  @JsonValue(0x020302)
  audioEncodingTypeOpus48000Medium,

  /// OPUS 编码格式，48000 Hz 采样率，高音质。音频时长为 10 分钟的文件编码后大小约为 3.5 MB。
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

/// 水印的适配模式。
///
@JsonEnum(alwaysCreate: true)
enum WatermarkFitMode {
  /// 使用你在 WatermarkOptions 中设置的 positionInLandscapeMode 和 positionInPortraitMode 值。此时 WatermarkRatio 中的设置无效。
  @JsonValue(0)
  fitModeCoverPosition,

  /// 使用你在 WatermarkRatio 中设置的值。此时 WatermarkOptions 中 positionInLandscapeMode 和 positionInPortraitMode 的设置无效。
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

/// 编码后音频的信息。
///
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

  /// 音频编码规格: AudioCodecType 。
  @JsonKey(name: 'codec')
  final AudioCodecType? codec;

  /// 音频采样率 (Hz)。
  @JsonKey(name: 'sampleRateHz')
  final int? sampleRateHz;

  /// 每个声道的音频采样数。
  @JsonKey(name: 'samplesPerChannel')
  final int? samplesPerChannel;

  /// 声道数。
  @JsonKey(name: 'numberOfChannels')
  final int? numberOfChannels;

  /// 该功能暂不支持。
  @JsonKey(name: 'advancedSettings')
  final EncodedAudioFrameAdvancedSettings? advancedSettings;

  /// 采集外部编码视频帧的 Unix 时间戳 (ms)。
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

/// 视频流类型。
///
@JsonEnum(alwaysCreate: true)
enum VideoStreamType {
  /// 0: 视频大流，即高分辨率、高码率视频流。
  @JsonValue(0)
  videoStreamHigh,

  /// 1: 视频小流，即低分辨率、低码率视频流。
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

/// 视频订阅设置。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoSubscriptionOptions {
  /// @nodoc
  const VideoSubscriptionOptions({this.type, this.encodedFrameOnly});

  /// 订阅的视频流类型，默认值为 videoStreamHigh，即订阅视频大流。详见 VideoStreamType 。
  @JsonKey(name: 'type')
  final VideoStreamType? type;

  /// 是否仅订阅编码后的视频流： true：仅订阅编码后的视频数据（结构化数据）。false：（默认）订阅原始视频数据。
  @JsonKey(name: 'encodedFrameOnly')
  final bool? encodedFrameOnly;

  /// @nodoc
  factory VideoSubscriptionOptions.fromJson(Map<String, dynamic> json) =>
      _$VideoSubscriptionOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$VideoSubscriptionOptionsToJson(this);
}

/// 外部编码视频帧的信息。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class EncodedVideoFrameInfo {
  /// @nodoc
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

  /// 视频编码类型，详见 VideoCodecType 。默认值为 videoCodecH264 (2)。
  @JsonKey(name: 'codecType')
  final VideoCodecType? codecType;

  /// 视频帧的宽度 (px)。
  @JsonKey(name: 'width')
  final int? width;

  /// 视频帧的高度 (px)。
  @JsonKey(name: 'height')
  final int? height;

  /// 每秒的视频帧数。当该参数不为 0 时，你可以用它计算外部编码视频帧的 Unix 时间戳。
  @JsonKey(name: 'framesPerSecond')
  final int? framesPerSecond;

  /// 视频帧的类型，详见 VideoFrameType 。
  @JsonKey(name: 'frameType')
  final VideoFrameType? frameType;

  /// 视频帧的旋转信息，详见 VideoOrientation 。
  @JsonKey(name: 'rotation')
  final VideoOrientation? rotation;

  /// 预留参数。
  @JsonKey(name: 'trackId')
  final int? trackId;

  /// 采集外部编码视频帧的 Unix 时间戳 (ms)。
  @JsonKey(name: 'captureTimeMs')
  final int? captureTimeMs;

  /// 推送外部编码视频帧的用户 ID。
  @JsonKey(name: 'uid')
  final int? uid;

  /// 视频流类型。详见 VideoStreamType 。
  @JsonKey(name: 'streamType')
  final VideoStreamType? streamType;

  /// @nodoc
  factory EncodedVideoFrameInfo.fromJson(Map<String, dynamic> json) =>
      _$EncodedVideoFrameInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$EncodedVideoFrameInfoToJson(this);
}

/// 镜像模式类型。
///
@JsonEnum(alwaysCreate: true)
enum VideoMirrorModeType {
  /// 0:（默认）由 SDK 决定镜像模式。
  @JsonValue(0)
  videoMirrorModeAuto,

  /// 1: 启用镜像模式。
  @JsonValue(1)
  videoMirrorModeEnabled,

  /// 2: 关闭镜像模式。
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

/// 视频编码器的配置。
///
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
      this.mirrorMode});

  /// 视频编码类型，详见 VideoCodecType 。
  @JsonKey(name: 'codecType')
  final VideoCodecType? codecType;

  /// 视频编码的分辨率（px），用于衡量编码质量，以长 × 宽表示。
  @JsonKey(name: 'dimensions')
  final VideoDimensions? dimensions;

  /// 视频编码的帧率(fps)，默认值为 15。详见 FrameRate 。
  @JsonKey(name: 'frameRate')
  final int? frameRate;

  /// 视频编码码率，单位为 Kbps。: (推荐) 标准码率模式。该模式下，视频的码率是基准码率的两倍。: 适配码率模式。该模式下，视频码率与基准码率一致。直播时如果选择该模式，视频帧率可能会低于设置的值。
  @JsonKey(name: 'bitrate')
  final int? bitrate;

  /// 最低编码码率，单位为 Kbps。SDK 会根据网络状况自动调整视频编码码率。将参数设为高于默认值可强制视频编码器输出高质量图片，但在网络状况不佳情况下可能导致网络丢包并影响视频播放的流畅度造成卡顿。因此如非对画质有特殊需求，声网建议不要修改该参数的值。该参数仅适用于直播场景。
  @JsonKey(name: 'minBitrate')
  final int? minBitrate;

  /// 视频编码的方向模式，详见 OrientationMode 。
  @JsonKey(name: 'orientationMode')
  final OrientationMode? orientationMode;

  /// 带宽受限时，视频编码降级偏好。详见 DegradationPreference 。
  @JsonKey(name: 'degradationPreference')
  final DegradationPreference? degradationPreference;

  /// 发送编码视频时是否开启镜像模式，只影响远端用户看到的视频画面。详见 VideoMirrorModeType 。默认关闭镜像模式。
  @JsonKey(name: 'mirrorMode')
  final VideoMirrorModeType? mirrorMode;

  /// @nodoc
  factory VideoEncoderConfiguration.fromJson(Map<String, dynamic> json) =>
      _$VideoEncoderConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$VideoEncoderConfigurationToJson(this);
}

/// 数据流设置。
/// 下表展示不同的参数设置下，SDK 的行为：
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class DataStreamConfig {
  /// @nodoc
  const DataStreamConfig({this.syncWithAudio, this.ordered});

  /// 是否与本地发送的音频流同步。 true: 数据流与音频流同步。false: 数据流与音频流不同步。 设置为与音频同步后，如果数据包的延迟在音频延迟的范围内，SDK 会在播放音频的同时触发与该音频包同步的 onStreamMessage 回调。 当需要数据包立刻到达接收端时，不能将该参数设置为 true。Agora 建议你仅在需要实现特殊场景，例如歌词同步时，设置为与音频同步。
  @JsonKey(name: 'syncWithAudio')
  final bool? syncWithAudio;

  /// 是否保证接收到的数据按发送的顺序排列。 true: 保证 SDK 按照发送方发送的顺序输出数据包。false: 不保证 SDK 按照发送方发送的顺序输出数据包。 当需要数据包立刻到达接收端时，不能将该参数设置为 true。
  @JsonKey(name: 'ordered')
  final bool? ordered;

  /// @nodoc
  factory DataStreamConfig.fromJson(Map<String, dynamic> json) =>
      _$DataStreamConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$DataStreamConfigToJson(this);
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum SimulcastStreamMode {
  /// @nodoc
  @JsonValue(-1)
  autoSimulcastStream,

  /// @nodoc
  @JsonValue(0)
  disableSimulcastStrem,

  /// @nodoc
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

/// 视频小流的配置。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SimulcastStreamConfig {
  /// @nodoc
  const SimulcastStreamConfig({this.dimensions, this.bitrate, this.framerate});

  /// 视频尺寸。详见 VideoDimensions 。默认值为 160 × 120。
  @JsonKey(name: 'dimensions')
  final VideoDimensions? dimensions;

  /// 视频码率 (Kbps)。默认值为 65。
  @JsonKey(name: 'bitrate')
  final int? bitrate;

  /// 视频帧率 (fps)。默认值为 5。
  @JsonKey(name: 'framerate')
  final int? framerate;

  /// @nodoc
  factory SimulcastStreamConfig.fromJson(Map<String, dynamic> json) =>
      _$SimulcastStreamConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$SimulcastStreamConfigToJson(this);
}

/// 目标区域相对于整个屏幕或窗口的位置，如不填，则表示整个屏幕或窗口。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Rectangle {
  /// @nodoc
  const Rectangle({this.x, this.y, this.width, this.height});

  /// 左上角的横向偏移。
  @JsonKey(name: 'x')
  final int? x;

  /// 左上角的纵向偏移。
  @JsonKey(name: 'y')
  final int? y;

  /// 目标区域的宽度。
  @JsonKey(name: 'width')
  final int? width;

  /// 目标区域的高度。
  @JsonKey(name: 'height')
  final int? height;

  /// @nodoc
  factory Rectangle.fromJson(Map<String, dynamic> json) =>
      _$RectangleFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RectangleToJson(this);
}

/// 水印在屏幕中的位置和大小。
/// 水印在屏幕中的位置和大小由 xRatio、yRatio 和 widthRatio 共同决定： (xRatio, yRatio) 指水印左上角的坐标，决定水印左上角到屏幕左上角的距离。widthRatio 决定水印的宽度。
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class WatermarkRatio {
  /// @nodoc
  const WatermarkRatio({this.xRatio, this.yRatio, this.widthRatio});

  /// 水印左上角的 x 坐标。以屏幕左上角为原点，x 坐标为水印左上角相对于原点的横向位移。取值范围为 [0.0,1.0]，默认值为 0。
  @JsonKey(name: 'xRatio')
  final double? xRatio;

  /// 水印左上角的 y 坐标。以屏幕左上角为原点，y 坐标为水印左上角相对于原点的纵向位移。取值范围为 [0.0,1.0]，默认值为 0。
  @JsonKey(name: 'yRatio')
  final double? yRatio;

  /// 水印的宽度。SDK 会根据该参数值计算出等比例的水印高度，确保放大或缩小后的水印图片不失真。取值范围为 [0.0,1.0]，默认值为 0，代表不显示水印。
  @JsonKey(name: 'widthRatio')
  final double? widthRatio;

  /// @nodoc
  factory WatermarkRatio.fromJson(Map<String, dynamic> json) =>
      _$WatermarkRatioFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$WatermarkRatioToJson(this);
}

/// 水印图片的设置。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class WatermarkOptions {
  /// @nodoc
  const WatermarkOptions(
      {this.visibleInPreview,
      this.positionInLandscapeMode,
      this.positionInPortraitMode,
      this.watermarkRatio,
      this.mode});

  /// 预留参数。
  @JsonKey(name: 'visibleInPreview')
  final bool? visibleInPreview;

  /// 水印的适配模式为 fitModeCoverPosition 时，用于设置横屏模式下水印图片的区域。详见 Rectangle 。
  @JsonKey(name: 'positionInLandscapeMode')
  final Rectangle? positionInLandscapeMode;

  /// 水印的适配模式为 fitModeCoverPosition 时，用于设置竖屏模式下水印图片的区域。详见 Rectangle 。
  @JsonKey(name: 'positionInPortraitMode')
  final Rectangle? positionInPortraitMode;

  /// 水印的适配模式为 fitModeUseImageRatio 时，该参数可设置缩放模式下的水印坐标。详见 WatermarkRatio 。
  @JsonKey(name: 'watermarkRatio')
  final WatermarkRatio? watermarkRatio;

  /// 水印的适配模式。详见 WatermarkFitMode 。
  @JsonKey(name: 'mode')
  final WatermarkFitMode? mode;

  /// @nodoc
  factory WatermarkOptions.fromJson(Map<String, dynamic> json) =>
      _$WatermarkOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$WatermarkOptionsToJson(this);
}

/// 通话相关的统计信息。
///
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

  /// 本地用户通话时长（秒），累计值。
  @JsonKey(name: 'duration')
  final int? duration;

  /// 发送字节数（bytes）。
  @JsonKey(name: 'txBytes')
  final int? txBytes;

  /// 接收字节数（bytes）。
  @JsonKey(name: 'rxBytes')
  final int? rxBytes;

  /// 发送音频字节数（bytes），累计值。
  @JsonKey(name: 'txAudioBytes')
  final int? txAudioBytes;

  /// 发送视频字节数（bytes），累计值。
  @JsonKey(name: 'txVideoBytes')
  final int? txVideoBytes;

  /// 接收音频字节数（bytes），累计值。
  @JsonKey(name: 'rxAudioBytes')
  final int? rxAudioBytes;

  /// 接收视频字节数（bytes），累计值。
  @JsonKey(name: 'rxVideoBytes')
  final int? rxVideoBytes;

  /// 发送码率（Kbps）。
  @JsonKey(name: 'txKBitRate')
  final int? txKBitRate;

  /// 接收码率（Kbps）。
  @JsonKey(name: 'rxKBitRate')
  final int? rxKBitRate;

  /// 音频接收码率 (Kbps）。
  @JsonKey(name: 'rxAudioKBitRate')
  final int? rxAudioKBitRate;

  /// 音频包的发送码率 (Kbps）。
  @JsonKey(name: 'txAudioKBitRate')
  final int? txAudioKBitRate;

  /// 视频接收码率 (Kbps）。
  @JsonKey(name: 'rxVideoKBitRate')
  final int? rxVideoKBitRate;

  /// 视频发送码率 (Kbps）。
  @JsonKey(name: 'txVideoKBitRate')
  final int? txVideoKBitRate;

  /// 客户端-接入服务器延时 (毫秒)。
  @JsonKey(name: 'lastmileDelay')
  final int? lastmileDelay;

  /// 当前频道内的用户人数。
  @JsonKey(name: 'userCount')
  final int? userCount;

  /// 当前 App 的 CPU 使用率 (%)。 onLeaveChannel 回调中报告的 cpuAppUsage 恒为 0。自 Android 8.1 起，因系统限制，你可能无法通过该属性获取 CPU 使用率。
  @JsonKey(name: 'cpuAppUsage')
  final double? cpuAppUsage;

  /// 当前系统的 CPU 使用率 (%)。对于 Windows 平台，在多核环境中，该成员指多核 CPU 的平均使用率。 计算方式为 (100 - 任务管理中显示的系统空闲进程 CPU)/100。 onLeaveChannel 回调中报告的 cpuTotalUsage 恒为 0。
  @JsonKey(name: 'cpuTotalUsage')
  final double? cpuTotalUsage;

  /// 客户端到本地路由器的往返时延 (ms)。
  ///  在 Android 平台上，如需获取 gatewayRtt，请确保已在项目 AndroidManifest.xml 文件的 </application> 后面添加 android.permission.ACCESS_WIFI_STATE 权限。
  @JsonKey(name: 'gatewayRtt')
  final int? gatewayRtt;

  /// 当前 App 的内存占比 (%)。该值仅作参考。受系统限制可能无法获取。
  @JsonKey(name: 'memoryAppUsageRatio')
  final double? memoryAppUsageRatio;

  /// 当前系统的内存占比 (%)。该值仅作参考。受系统限制可能无法获取。
  @JsonKey(name: 'memoryTotalUsageRatio')
  final double? memoryTotalUsageRatio;

  /// 当前 App 的内存大小 (KB)。该值仅作参考。受系统限制可能无法获取。
  @JsonKey(name: 'memoryAppUsageInKbytes')
  final int? memoryAppUsageInKbytes;

  /// 从开始建立连接到成功连接的时间（毫秒）。如报告 0，则表示无效。
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

  /// 使用抗丢包技术前，客户端上行发送到服务器丢包率 (%)。
  @JsonKey(name: 'txPacketLossRate')
  final int? txPacketLossRate;

  /// 使用抗丢包技术前，服务器下行发送到客户端丢包率 (%)。
  @JsonKey(name: 'rxPacketLossRate')
  final int? rxPacketLossRate;

  /// @nodoc
  factory RtcStats.fromJson(Map<String, dynamic> json) =>
      _$RtcStatsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RtcStatsToJson(this);
}

/// 视频源的类型。
///
@JsonEnum(alwaysCreate: true)
enum VideoSourceType {
  /// （默认）第一个摄像头。
  @JsonValue(0)
  videoSourceCameraPrimary,

  /// 摄像头。
  @JsonValue(0)
  videoSourceCamera,

  /// 第二个摄像头。
  @JsonValue(1)
  videoSourceCameraSecondary,

  /// 第一个屏幕。
  @JsonValue(2)
  videoSourceScreenPrimary,

  /// 屏幕。
  @JsonValue(2)
  videoSourceScreen,

  /// 第二个屏幕。
  @JsonValue(3)
  videoSourceScreenSecondary,

  /// 自定义的视频源。
  @JsonValue(4)
  videoSourceCustom,

  /// 媒体播放器共享的视频源。
  @JsonValue(5)
  videoSourceMediaPlayer,

  /// 视频源为 PNG 图片。
  @JsonValue(6)
  videoSourceRtcImagePng,

  /// 视频源为 JPEG 图片。
  @JsonValue(7)
  videoSourceRtcImageJpeg,

  /// 视频源为 GIF 图片。
  @JsonValue(8)
  videoSourceRtcImageGif,

  /// 视频源为网络获取的远端视频。
  @JsonValue(9)
  videoSourceRemote,

  /// 转码后的视频源。
  @JsonValue(10)
  videoSourceTranscoded,

  /// 未知的视频源。
  @JsonValue(100)
  videoSourceUnknown,
}

/// @nodoc
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

/// 直播场景里的用户角色。
///
@JsonEnum(alwaysCreate: true)
enum ClientRoleType {
  /// 1: 主播。主播可以发流也可以收流。
  @JsonValue(1)
  clientRoleBroadcaster,

  /// 2:（默认）观众。观众只能收流不能发流。
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

/// 自上次统计后本地视频质量的自适应情况（基于目标帧率和目标码率）。
///
@JsonEnum(alwaysCreate: true)
enum QualityAdaptIndication {
  /// 0：本地视频质量不变。
  @JsonValue(0)
  adaptNone,

  /// 1：因网络带宽增加，本地视频质量改善。
  @JsonValue(1)
  adaptUpBandwidth,

  /// 2：因网络带宽减少，本地视频质量变差。
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

/// 直播频道中观众的延时级别。该枚举仅在用户角色设为 clientRoleAudience 时才生效。
///
@JsonEnum(alwaysCreate: true)
enum AudienceLatencyLevelType {
  /// 1: 低延时。
  @JsonValue(1)
  audienceLatencyLevelLowLatency,

  /// 2:（默认）超低延时。
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

/// 用户角色具体设置。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ClientRoleOptions {
  /// @nodoc
  const ClientRoleOptions({this.audienceLatencyLevel});

  /// 观众端延时级别。详见 AudienceLatencyLevelType 。
  @JsonKey(name: 'audienceLatencyLevel')
  final AudienceLatencyLevelType? audienceLatencyLevel;

  /// @nodoc
  factory ClientRoleOptions.fromJson(Map<String, dynamic> json) =>
      _$ClientRoleOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ClientRoleOptionsToJson(this);
}

/// 接收远端音频时，本地用户的主观体验质量。
///
@JsonEnum(alwaysCreate: true)
enum ExperienceQualityType {
  /// 0: 主观体验质量较好。
  @JsonValue(0)
  experienceQualityGood,

  /// 1: 主观体验质量较差。
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

/// 接收远端音频时，本地用户主观体验质量较差的原因。
///
@JsonEnum(alwaysCreate: true)
enum ExperiencePoorReason {
  /// 0: 无原因，说明主观体验质量较好。
  @JsonValue(0)
  experienceReasonNone,

  /// 1: 远端用户的网络较差。
  @JsonValue(1)
  remoteNetworkQualityPoor,

  /// 2: 本地用户的网络较差。
  @JsonValue(2)
  localNetworkQualityPoor,

  /// 4: 本地用户的 Wi-FI 或者移动数据网络信号弱。
  @JsonValue(4)
  wirelessSignalPoor,

  /// 8: 本地用户同时开启 Wi-Fi 和蓝牙，二者信号互相干扰，导致音频传输质量下降。
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

/// 远端用户的音频统计数据。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RemoteAudioStats {
  /// @nodoc
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

  /// 远端用户的用户 ID。
  @JsonKey(name: 'uid')
  final int? uid;

  /// 远端用户发送的音频流质量。详见 QualityType 。
  @JsonKey(name: 'quality')
  final int? quality;

  /// 音频发送端到接收端的网络延迟（毫秒）。
  @JsonKey(name: 'networkTransportDelay')
  final int? networkTransportDelay;

  /// 音频接收端到网络抖动缓冲的网络延迟（毫秒）。
  ///  当接收端为观众且 ClientRoleOptions 的 audienceLatencyLevel 为 1 时，该参数不生效。
  @JsonKey(name: 'jitterBufferDelay')
  final int? jitterBufferDelay;

  /// 统计周期内的远端音频流的丢帧率 (%)。
  @JsonKey(name: 'audioLossRate')
  final int? audioLossRate;

  /// 声道数。
  @JsonKey(name: 'numChannels')
  final int? numChannels;

  /// 统计周期内接收到的远端音频流的采样率。
  @JsonKey(name: 'receivedSampleRate')
  final int? receivedSampleRate;

  /// 接收到的远端音频流在统计周期内的平均码率（Kbps）。
  @JsonKey(name: 'receivedBitrate')
  final int? receivedBitrate;

  /// 远端用户在加入频道后发生音频卡顿的累计时长（毫秒）。通话过程中，音频丢帧率达到 4% 即记为一次音频卡顿。
  @JsonKey(name: 'totalFrozenTime')
  final int? totalFrozenTime;

  /// 音频卡顿的累计时长占音频总有效时长的百分比 (%)。音频有效时长是指远端用户加入频道后音频未被停止发送或禁用的时长。
  @JsonKey(name: 'frozenRate')
  final int? frozenRate;

  /// 统计周期内，Agora 实时音频 MOS（平均主观意见分）评估方法对接收到的远端音频流的质量评分。返回值范围为 [0,500]。返回值除以 100 即可得到 MOS 分数，范围为 [0,5] 分，分数越高，音频质量越好。Agora 实时音频 MOS 评分对应的主观音质感受如下：MOS 分数音质感受大于 4 分音频质量佳，清晰流畅。3.5 - 4 分音频质量较好，偶有音质损伤，但依然清晰。3 - 3.5 分音频质量一般，偶有卡顿，不是非常流畅，需要一点注意力才能听清。2.5 - 3 分音频质量较差，卡顿频繁，需要集中精力才能听清。2 - 2.5 分音频质量很差，偶有杂音，部分语义丢失，难以交流。小于 2 分音频质量非常差，杂音频现，大量语义丢失，完全无法交流。
  @JsonKey(name: 'mosValue')
  final int? mosValue;

  /// 远端用户在音频通话开始到本次回调之间的有效时长（毫秒）。有效时长是指去除了远端用户进入静音状态的总时长。
  @JsonKey(name: 'totalActiveTime')
  final int? totalActiveTime;

  /// 远端音频流的累计发布时长（毫秒）。
  @JsonKey(name: 'publishDuration')
  final int? publishDuration;

  /// 接收远端音频时，本地用户的主观体验质量。
  @JsonKey(name: 'qoeQuality')
  final int? qoeQuality;

  /// 接收远端音频时，本地用户主观体验质量较差的原因。详见 ExperiencePoorReason 。
  @JsonKey(name: 'qualityChangedReason')
  final int? qualityChangedReason;

  /// @nodoc
  factory RemoteAudioStats.fromJson(Map<String, dynamic> json) =>
      _$RemoteAudioStatsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RemoteAudioStatsToJson(this);
}

/// 音频编码属性。
///
@JsonEnum(alwaysCreate: true)
enum AudioProfileType {
  /// 0: 默认值。 直播场景下：48 kHz 采样率，音乐编码，单声道，编码码率最大值为 64 Kbps。通信场景下：Windows 平台：16 kHz 采样率，语音编码，单声道，编码码率最大值为 16 Kbps。Android、macOS、iOS 平台：
  @JsonValue(0)
  audioProfileDefault,

  /// 1: 指定 32 kHz 采样率，语音编码，单声道，编码码率最大值为 18 Kbps。
  ///
  @JsonValue(1)
  audioProfileSpeechStandard,

  /// 2: 指定 48 kHz 采样率，音乐编码，单声道，编码码率最大值为 64 Kbps。
  ///
  @JsonValue(2)
  audioProfileMusicStandard,

  /// 3: 指定 48 kHz 采样率，音乐编码，双声道，编码码率最大值为 80 Kbps。如需实现立体声，你还需要调用 setAdvancedAudioOptions 并在 AdvancedAudioOptions 中设置 audioProcessingChannels 为 audioProcessingStereo。
  @JsonValue(3)
  audioProfileMusicStandardStereo,

  /// 4: 指定 48 kHz 采样率，音乐编码，单声道，编码码率最大值为 96 Kbps。
  @JsonValue(4)
  audioProfileMusicHighQuality,

  /// 5: 指定 48 kHz 采样率，音乐编码，双声道，编码码率最大值为 128 Kbps。如需实现立体声，你还需要调用 setAdvancedAudioOptions 并在 AdvancedAudioOptions 中设置 audioProcessingChannels 为 audioProcessingStereo。
  @JsonValue(5)
  audioProfileMusicHighQualityStereo,

  /// 6: 指定 16 kHz 采样率，语音编码，单声道，应用回声消除算法 AES。
  @JsonValue(6)
  audioProfileIot,

  /// 枚举值边界。
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

/// 音频场景。
///
@JsonEnum(alwaysCreate: true)
enum AudioScenarioType {
  /// 0: （默认）自动场景，根据用户角色和音频路由自动匹配合适的音质。
  @JsonValue(0)
  audioScenarioDefault,

  /// 3: 高音质场景，适用于音乐为主的场景。
  @JsonValue(3)
  audioScenarioGameStreaming,

  /// 5: 聊天室场景，适用于用户需要频繁上下麦的场景。该场景下，观众会收到申请麦克风权限的弹窗提示。
  @JsonValue(5)
  audioScenarioChatroom,

  /// 7: 合唱场景。适用于网络条件良好，要求极低延时的实时合唱场景。
  ///
  @JsonValue(7)
  audioScenarioChorus,

  /// 8: 会议场景，适用于人声为主的多人会议。
  @JsonValue(8)
  audioScenarioMeeting,

  /// 枚举的数量。
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

/// 视频帧格式。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoFormat {
  /// @nodoc
  const VideoFormat({this.width, this.height, this.fps});

  /// 视频帧的宽度（px）。
  @JsonKey(name: 'width')
  final int? width;

  /// 视频帧的高度（px）。
  @JsonKey(name: 'height')
  final int? height;

  /// 视频帧的帧率。
  @JsonKey(name: 'fps')
  final int? fps;

  /// @nodoc
  factory VideoFormat.fromJson(Map<String, dynamic> json) =>
      _$VideoFormatFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$VideoFormatToJson(this);
}

/// 屏幕共享的内容类型。
///
@JsonEnum(alwaysCreate: true)
enum VideoContentHint {
  /// （默认）无指定的内容类型。
  @JsonValue(0)
  contentHintNone,

  /// 内容类型为动画。当共享的内容是视频、电影或视频游戏时，推荐选择该内容类型。
  @JsonValue(1)
  contentHintMotion,

  /// 内容类型为细节。当共享的内容是图片或文字时，推荐选择该内容类型。
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

/// 屏幕共享的场景。
///
@JsonEnum(alwaysCreate: true)
enum ScreenScenarioType {
  /// 1:（默认）文档。该场景下，优先保障共享的画质，并降低了接收端看到共享视频的延时。如果你共享文档、幻灯片、表格，可以设置该场景。
  @JsonValue(1)
  screenScenarioDocument,

  /// 2: 游戏。该场景下，优先保障共享的流畅性。如果你共享游戏，可以设置该场景。
  @JsonValue(2)
  screenScenarioGaming,

  /// 3: 视频。该场景下，优先保障共享的流畅性。如果你共享电影、视频直播，可以设置该场景。
  @JsonValue(3)
  screenScenarioVideo,

  /// 4: 远程控制。该场景下，优先保障共享的画质，并降低了接收端看到共享视频的延时。如果你共享被远程控制的设备桌面，可以设置该场景。
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

/// 本地采集的画质亮度级别。
///
@JsonEnum(alwaysCreate: true)
enum CaptureBrightnessLevelType {
  /// -1: SDK 未检测出本地采集的画质亮度级别。请等待几秒，通过下一次回调的 captureBrightnessLevel 获取亮度级别。
  @JsonValue(-1)
  captureBrightnessLevelInvalid,

  /// 0: 本地采集的画质亮度正常。
  @JsonValue(0)
  captureBrightnessLevelNormal,

  /// 1: 本地采集的画质亮度偏亮。
  @JsonValue(1)
  captureBrightnessLevelBright,

  /// 2: 本地采集的画质亮度偏暗。
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

/// 本地音频状态。
///
@JsonEnum(alwaysCreate: true)
enum LocalAudioStreamState {
  /// 0: 本地音频默认初始状态。
  @JsonValue(0)
  localAudioStreamStateStopped,

  /// 1: 本地音频采集设备启动成功。
  @JsonValue(1)
  localAudioStreamStateRecording,

  /// 2: 本地音频首帧编码成功。
  @JsonValue(2)
  localAudioStreamStateEncoding,

  /// 3: 本地音频启动失败。
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

/// 本地音频出错原因。
///
@JsonEnum(alwaysCreate: true)
enum LocalAudioStreamError {
  /// 0：本地音频状态正常。
  @JsonValue(0)
  localAudioStreamErrorOk,

  /// 1：本地音频出错原因不明确。建议提示用户尝试重新加入频道。
  @JsonValue(1)
  localAudioStreamErrorFailure,

  /// 2：没有权限启动本地音频采集设备。请提示用户开启权限。
  ///  弃用：该枚举已废弃。请改用 onPermissionError 回调中的 recordAudio 。
  @JsonValue(2)
  localAudioStreamErrorDeviceNoPermission,

  /// 3：（仅适用于 Android 和 iOS）本地音频采集设备已经在使用中。请提示用户检查麦克风是否被其他应用占用。麦克风空闲约 5 秒后本地音频采集会自动恢复，你也可以在麦克风空闲后尝试重新加入频道。
  @JsonValue(3)
  localAudioStreamErrorDeviceBusy,

  /// 4：本地音频采集失败。
  @JsonValue(4)
  localAudioStreamErrorRecordFailure,

  /// 5：本地音频编码失败。
  @JsonValue(5)
  localAudioStreamErrorEncodeFailure,

  /// 6:（仅适用于 Windows）无本地音频采集设备。请提示用户在设备的控制面板中检查麦克风是否与设备连接正常，检查麦克风是否正常工作。
  @JsonValue(6)
  localAudioStreamErrorNoRecordingDevice,

  /// 7:（仅适用于 Windows）无本地音频播放设备。请提示用户在设备的控制面板中检查扬声器是否与设备连接正常，检查扬声器是否正常工作。
  @JsonValue(7)
  localAudioStreamErrorNoPlayoutDevice,

  /// 8:（仅适用于 Android 和 iOS）本地音频采集被系统来电、Siri、闹钟中断。如需恢复本地音频采集，请用户中止电话、Siri、闹钟。
  @JsonValue(8)
  localAudioStreamErrorInterrupted,

  /// 9：（仅适用于 Windows）本地音频采集设备的 ID 无效。请检查音频采集设备 ID。
  @JsonValue(9)
  localAudioStreamErrorRecordInvalidId,

  /// 10：（仅适用于 Windows）本地音频播放设备的 ID 无效。请检查音频播放设备 ID。
  @JsonValue(10)
  localAudioStreamErrorPlayoutInvalidId,
}

/// @nodoc
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

/// 本地视频状态。
///
@JsonEnum(alwaysCreate: true)
enum LocalVideoStreamState {
  /// 0: 本地视频默认初始状态。
  @JsonValue(0)
  localVideoStreamStateStopped,

  /// 1: 本地视频采集设备启动成功。
  @JsonValue(1)
  localVideoStreamStateCapturing,

  /// 2: 本地视频首帧编码成功。
  @JsonValue(2)
  localVideoStreamStateEncoding,

  /// 3: 本地视频启动失败。
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

/// 本地视频出错原因。
///
@JsonEnum(alwaysCreate: true)
enum LocalVideoStreamError {
  /// 0：本地视频状态正常。
  @JsonValue(0)
  localVideoStreamErrorOk,

  /// 1：出错原因不明确。
  @JsonValue(1)
  localVideoStreamErrorFailure,

  /// 2：没有权限启动本地视频采集设备。请提示用户开启权限再重新加入频道。
  ///  弃用：该枚举已废弃。请改用 onPermissionError 回调中的 camera 。
  @JsonValue(2)
  localVideoStreamErrorDeviceNoPermission,

  /// 3：本地视频采集设备正在使用中。请提示用户检查摄像头是否被其他应用占用。
  @JsonValue(3)
  localVideoStreamErrorDeviceBusy,

  /// 4：本地视频采集失败。请提示用户检查视频采集设备是否正常工作，检查摄像头是否被其他应用占用，或者尝试重新加入频道。
  @JsonValue(4)
  localVideoStreamErrorCaptureFailure,

  /// 5：本地视频编码失败。
  @JsonValue(5)
  localVideoStreamErrorEncodeFailure,

  /// 6：（仅适用于 iOS）应用处于后台。请提示用户应用处于后台时，无法正常进行视频采集。
  @JsonValue(6)
  localVideoStreamErrorCaptureInbackground,

  /// 7：（仅适用于 iOS）当前应用窗口处于侧拉、分屏、画中画模式，且其他应用正占用摄像头时，SDK 会报告该错误码。 请提示用户应用窗口处于侧拉、分屏、画中画模式，且其他应用正占用摄像头时，无法正常进行视频采集。
  @JsonValue(7)
  localVideoStreamErrorCaptureMultipleForegroundApps,

  /// 8：找不到本地视频采集设备。需检查摄像头是否与设备正常连接、摄像头是否正常工作，或者尝试重新加入频道。
  @JsonValue(8)
  localVideoStreamErrorDeviceNotFound,

  /// 9：（仅适用于 macOS）当前正在使用的视频采集设备已经断开连接（例如，被拔出）。
  @JsonValue(9)
  localVideoStreamErrorDeviceDisconnected,

  /// 10：（仅适用于 macOS 和 Windows）SDK 无法在视频设备列表中找到该视频设备。请检查视频设备 ID 是否有效。
  @JsonValue(10)
  localVideoStreamErrorDeviceInvalidId,

  /// 101：由于系统压力过大，导致当前视频采集设备不可用。
  @JsonValue(101)
  localVideoStreamErrorDeviceSystemPressure,

  /// 11：（仅适用于 macOS）调用 startScreenCaptureByWindowId 方法共享窗口时，共享窗口处于最小化的状态。SDK 无法共享被最小化的窗口。请在应用层对此类窗口取消最小化，例如，将窗口最大化。
  @JsonValue(11)
  localVideoStreamErrorScreenCaptureWindowMinimized,

  /// 12：（仅适用于 macOS 和 Windows）该错误码表示通过窗口 ID 共享的窗口已关闭，或通过窗口 ID 共享的全屏窗口已退出全屏。退出全屏模式后，远端用户将无法看到共享的窗口。为避免远端用户看到黑屏，Agora 建议你立即结束本次共享。报告该错误码的常见场景： 本地用户关闭共享的窗口时，SDK 会报告该错误码。本地用户先放映幻灯片，然后共享放映中的幻灯片。结束放映时，SDK 会报告该错误码。本地用户先全屏观看网页视频或网页文档，然后共享网页视频或网页文档。结束全屏时，SDK 会报告该错误码。
  @JsonValue(12)
  localVideoStreamErrorScreenCaptureWindowClosed,

  /// 13:（仅适用于 Windows）待共享的窗口被其他窗口遮挡住，被遮挡住的部分在共享时会被 SDK 涂黑。
  @JsonValue(13)
  localVideoStreamErrorScreenCaptureWindowOccluded,

  /// @nodoc
  @JsonValue(20)
  localVideoStreamErrorScreenCaptureWindowNotSupported,
}

/// @nodoc
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

/// 远端音频流状态。
///
@JsonEnum(alwaysCreate: true)
enum RemoteAudioState {
  /// 0: 远端音频默认初始状态。在 remoteAudioReasonLocalMuted、remoteAudioReasonRemoteMuted 或 remoteAudioReasonRemoteOffline 的情况下，会报告该状态。
  @JsonValue(0)
  remoteAudioStateStopped,

  /// 1: 本地用户已接收远端音频首包。
  @JsonValue(1)
  remoteAudioStateStarting,

  /// 2: 远端音频流正在解码，正常播放。在 remoteAudioReasonNetworkRecovery、remoteAudioReasonLocalUnmuted 或 remoteAudioReasonRemoteUnmuted 的情况下，会报告该状态。
  @JsonValue(2)
  remoteAudioStateDecoding,

  /// 3: 远端音频流卡顿。在 remoteAudioReasonNetworkCongestion 的情况下，会报告该状态。
  @JsonValue(3)
  remoteAudioStateFrozen,

  /// 4: 远端音频流播放失败。在 remoteAudioReasonInternal 的情况下，会报告该状态。
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

/// 远端音频流状态切换原因。
///
@JsonEnum(alwaysCreate: true)
enum RemoteAudioStateReason {
  /// 0: 音频状态发生改变时，会报告该原因。
  @JsonValue(0)
  remoteAudioReasonInternal,

  /// 1: 网络阻塞。
  @JsonValue(1)
  remoteAudioReasonNetworkCongestion,

  /// 2: 网络恢复正常。
  @JsonValue(2)
  remoteAudioReasonNetworkRecovery,

  /// 3: 本地用户停止接收远端音频流或本地用户禁用音频模块。
  @JsonValue(3)
  remoteAudioReasonLocalMuted,

  /// 4: 本地用户恢复接收远端音频流或本地用户启动音频模块。
  @JsonValue(4)
  remoteAudioReasonLocalUnmuted,

  /// 5: 远端用户停止发送音频流或远端用户禁用音频模块。
  @JsonValue(5)
  remoteAudioReasonRemoteMuted,

  /// 6: 远端用户恢复发送音频流或远端用户启用音频模块。
  @JsonValue(6)
  remoteAudioReasonRemoteUnmuted,

  /// 7: 远端用户离开频道。
  @JsonValue(7)
  remoteAudioReasonRemoteOffline,
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

/// 远端视频流状态。
///
@JsonEnum(alwaysCreate: true)
enum RemoteVideoState {
  /// 0: 远端视频默认初始状态。在 remoteVideoStateReasonLocalMuted、remoteVideoStateReasonRemoteMuted 或 remoteVideoStateReasonRemoteOffline 的情况下，会报告该状态。
  @JsonValue(0)
  remoteVideoStateStopped,

  /// 1: 本地用户已接收远端视频首包。
  @JsonValue(1)
  remoteVideoStateStarting,

  /// 2: 远端视频流正在解码，正常播放。在 remoteVideoStateReasonNetworkRecovery、remoteVideoStateReasonLocalUnmuted、remoteVideoStateReasonRemoteUnmuted 或 remoteVideoStateReasonAudioFallbackRecovery 的情况下，会报告该状态。
  @JsonValue(2)
  remoteVideoStateDecoding,

  /// 3: 远端视频流卡顿。在 remoteVideoStateReasonNetworkCongestion 或 remoteVideoStateReasonAudioFallback 的情况下，会报告该状态。
  @JsonValue(3)
  remoteVideoStateFrozen,

  /// 4: 远端视频流播放失败。在 remoteVideoStateReasonInternal 的情况下，会报告该状态。
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

/// 远端视频流状态切换原因。
///
@JsonEnum(alwaysCreate: true)
enum RemoteVideoStateReason {
  /// 0: 视频状态发生改变时，会报告该原因。
  @JsonValue(0)
  remoteVideoStateReasonInternal,

  /// 1: 网络阻塞。
  @JsonValue(1)
  remoteVideoStateReasonNetworkCongestion,

  /// 2: 网络恢复正常。
  @JsonValue(2)
  remoteVideoStateReasonNetworkRecovery,

  /// 3: 本地用户停止接收远端视频流或本地用户禁用视频模块。
  @JsonValue(3)
  remoteVideoStateReasonLocalMuted,

  /// 4: 本地用户恢复接收远端视频流或本地用户启动视频模块。
  @JsonValue(4)
  remoteVideoStateReasonLocalUnmuted,

  /// 5: 远端用户停止发送视频流或远端用户禁用视频模块。
  @JsonValue(5)
  remoteVideoStateReasonRemoteMuted,

  /// 6: 远端用户恢复发送视频流或远端用户启用视频模块。
  @JsonValue(6)
  remoteVideoStateReasonRemoteUnmuted,

  /// 7: 远端用户离开频道。
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

  /// @nodoc
  @JsonValue(12)
  remoteVideoStateReasonSdkInBackground,
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

/// 用户音量信息。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioVolumeInfo {
  /// @nodoc
  const AudioVolumeInfo({this.uid, this.volume, this.vad, this.voicePitch});

  /// 用户 ID。 在本地用户的回调中，uid 为 0。在远端用户的回调中，uid 为瞬时音量最高的远端用户（最多 3 位）的 ID。
  @JsonKey(name: 'uid')
  final int? uid;

  /// 用户的音量，取值范围为 [0,255]。
  @JsonKey(name: 'volume')
  final int? volume;

  /// 本地用户的人声状态。 0：本地无人声。1：本地有人声。vad 无法报告远端用户的人声状态。对于远端用户，vad 的值始终为 1。如需使用此参数，请在调用 enableAudioVolumeIndication 时设置 reportVad 为 true。
  @JsonKey(name: 'vad')
  final int? vad;

  /// 本地用户的人声音调（Hz）。取值范围为 [0.0,4000.0]。
  ///  voicePitch 无法报告远端用户的人声音调。对于远端用户，voicePitch 的值始终为 0.0。
  @JsonKey(name: 'voicePitch')
  final double? voicePitch;

  /// @nodoc
  factory AudioVolumeInfo.fromJson(Map<String, dynamic> json) =>
      _$AudioVolumeInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AudioVolumeInfoToJson(this);
}

/// 音频设备信息。
/// 该类仅适用于 Android 平台。
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class DeviceInfo {
  /// @nodoc
  const DeviceInfo({this.isLowLatencyAudioSupported});

  /// 是否支持极低延时音频采集和播放： true: 支持false: 不支持
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

/// 推流输出音频的采样率。
///
@JsonEnum(alwaysCreate: true)
enum AudioSampleRateType {
  /// 32000: 32 kHz
  @JsonValue(32000)
  audioSampleRate32000,

  /// 44100: 44.1 kHz
  @JsonValue(44100)
  audioSampleRate44100,

  /// 48000: （默认）48 kHz
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

/// 转码输出视频流的编解码类型。
///
@JsonEnum(alwaysCreate: true)
enum VideoCodecTypeForStream {
  /// 1：（默认）H.264。
  @JsonValue(1)
  videoCodecH264ForStream,

  /// 2：H.265。
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

/// 旁路推流输出视频的编解码规格。
///
@JsonEnum(alwaysCreate: true)
enum VideoCodecProfileType {
  /// 66: Baseline 级别的视频编码规格，一般用于低阶或需要额外容错的应用，比如视频通话、手机视频等。
  @JsonValue(66)
  videoCodecProfileBaseline,

  /// 77: Main 级别的视频编码规格，一般用于主流消费类电子产品，如 MP4、便携的视频播放器、PSP、iPad 等。
  @JsonValue(77)
  videoCodecProfileMain,

  /// 100: （默认）High 级别的视频编码规格，一般用于广播、视频碟片存储、高清电视。
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

/// 推流输出音频的编解码规格，默认为 LC-AAC。
///
@JsonEnum(alwaysCreate: true)
enum AudioCodecProfileType {
  /// 0: （默认）LC-AAC 规格。
  @JsonValue(0)
  audioCodecProfileLcAac,

  /// 1: HE-AAC 规格。
  @JsonValue(1)
  audioCodecProfileHeAac,

  /// 2: HE-AAC v2 规格。
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

/// 本地音频统计数据。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LocalAudioStats {
  /// @nodoc
  const LocalAudioStats(
      {this.numChannels,
      this.sentSampleRate,
      this.sentBitrate,
      this.internalCodec,
      this.txPacketLossRate,
      this.audioDeviceDelay});

  /// 声道数。
  @JsonKey(name: 'numChannels')
  final int? numChannels;

  /// 发送本地音频的采样率，单位为 Hz。
  @JsonKey(name: 'sentSampleRate')
  final int? sentSampleRate;

  /// 发送本地音频的码率平均值，单位为 Kbps。
  @JsonKey(name: 'sentBitrate')
  final int? sentBitrate;

  /// 内部的 payload 类型。
  @JsonKey(name: 'internalCodec')
  final int? internalCodec;

  /// 弱网对抗前本端到 Agora 边缘服务器的丢包率 (%)。
  @JsonKey(name: 'txPacketLossRate')
  final int? txPacketLossRate;

  /// 播放或录制音频时，音频设备模块的延时。
  @JsonKey(name: 'audioDeviceDelay')
  final int? audioDeviceDelay;

  /// @nodoc
  factory LocalAudioStats.fromJson(Map<String, dynamic> json) =>
      _$LocalAudioStatsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LocalAudioStatsToJson(this);
}

/// 推流状态。
///
@JsonEnum(alwaysCreate: true)
enum RtmpStreamPublishState {
  /// 0：推流未开始或已结束。
  @JsonValue(0)
  rtmpStreamPublishStateIdle,

  /// 1：正在连接 Agora 推流服务器和 CDN 服务器。
  @JsonValue(1)
  rtmpStreamPublishStateConnecting,

  /// 2：推流正在进行。成功推流后，会返回该状态。
  @JsonValue(2)
  rtmpStreamPublishStateRunning,

  /// 3：正在恢复推流。当 CDN 出现异常，或推流短暂中断时，SDK 会自动尝试恢复推流，并返回该状态。如成功恢复推流，则进入状态 rtmpStreamPublishStateRunning(2)。如服务器出错或 60 秒内未成功恢复，则进入状态 rtmpStreamPublishStateFailure(4)。如果觉得 60 秒太长，也可以主动尝试重连。
  @JsonValue(3)
  rtmpStreamPublishStateRecovering,

  /// 4：推流失败。失败后，你可以通过返回的错误码排查错误原因。
  @JsonValue(4)
  rtmpStreamPublishStateFailure,

  /// 5：SDK 正在与 Agora 推流服务器和 CDN 服务器断开连接。当你调用 stopRtmpStream 方法正常结束推流时，SDK 会依次报告推流状态为 rtmpStreamPublishStateDisconnecting、rtmpStreamPublishStateIdle。
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

/// 推流错误信息。
///
@JsonEnum(alwaysCreate: true)
enum RtmpStreamPublishErrorType {
  /// 0：推流成功。
  @JsonValue(0)
  rtmpStreamPublishErrorOk,

  /// 1：参数无效。请检查输入参数是否正确。
  @JsonValue(1)
  rtmpStreamPublishErrorInvalidArgument,

  /// 2：推流已加密，不能推流。
  @JsonValue(2)
  rtmpStreamPublishErrorEncryptedStreamNotAllowed,

  /// 3：推流超时未成功。
  @JsonValue(3)
  rtmpStreamPublishErrorConnectionTimeout,

  /// 4：推流服务器出现错误。
  @JsonValue(4)
  rtmpStreamPublishErrorInternalServerError,

  /// 5：CDN 服务器出现错误。
  @JsonValue(5)
  rtmpStreamPublishErrorRtmpServerError,

  /// 6：推流请求过于频繁。
  @JsonValue(6)
  rtmpStreamPublishErrorTooOften,

  /// 7：单个主播的推流地址数目达到上限 10。请删掉一些不用的推流地址再增加推流地址。
  @JsonValue(7)
  rtmpStreamPublishErrorReachLimit,

  /// 8：主播操作不属于自己的流。例如更新其他主播的流参数、停止其他主播的流。请检查 App 逻辑。
  @JsonValue(8)
  rtmpStreamPublishErrorNotAuthorized,

  /// 9：服务器未找到这个流。
  @JsonValue(9)
  rtmpStreamPublishErrorStreamNotFound,

  /// 10：推流地址格式有错误。请检查推流地址格式是否正确。
  @JsonValue(10)
  rtmpStreamPublishErrorFormatNotSupported,

  /// 11：用户角色不是主播，该用户无法使用推流功能。请检查你的应用代码逻辑。
  @JsonValue(11)
  rtmpStreamPublishErrorNotBroadcaster,

  /// 13：非转码推流情况下，调用了 updateRtmpTranscoding 方法更新转码属性。请检查你的应用代码逻辑。
  @JsonValue(13)
  rtmpStreamPublishErrorTranscodingNoMixStream,

  /// 14：主播的网络出错。
  @JsonValue(14)
  rtmpStreamPublishErrorNetDown,

  /// 15：你的 App ID 没有使用 Agora 推流服务的权限。
  @JsonValue(15)
  rtmpStreamPublishErrorInvalidAppid,

  /// @nodoc
  @JsonValue(16)
  rtmpStreamPublishErrorInvalidPrivilege,

  /// 100：推流已正常结束。当你结束推流后，SDK 会返回该值。
  @JsonValue(100)
  rtmpStreamUnpublishErrorOk,
}

/// @nodoc
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

/// 旁路推流时发生的事件。
///
@JsonEnum(alwaysCreate: true)
enum RtmpStreamingEvent {
  /// 1: 旁路推流时，添加背景图或水印出错。
  @JsonValue(1)
  rtmpStreamingEventFailedLoadImage,

  /// 2: 该推流 URL 已用于推流。如果你想开始新的推流，请使用新的推流 URL。
  @JsonValue(2)
  rtmpStreamingEventUrlAlreadyInUse,

  /// 3: 功能不支持。
  @JsonValue(3)
  rtmpStreamingEventAdvancedFeatureNotSupport,

  /// 4: 预留参数。
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

/// 图像属性。
/// 用于设置直播视频的水印和背景图片的属性。
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

  /// 直播视频上图片的 HTTP/HTTPS 地址。字符长度不得超过 1024 字节。
  @JsonKey(name: 'url')
  final String? url;

  /// 图片在视频画面上的 x 坐标 (pixel)，以输出视频画面的左上角为原点。
  @JsonKey(name: 'x')
  final int? x;

  /// 图片在视频画面上的 y 坐标 (pixel)，以输出视频画面的左上角为原点。
  @JsonKey(name: 'y')
  final int? y;

  /// 图片在视频画面上的宽度 (pixel)。
  @JsonKey(name: 'width')
  final int? width;

  /// 图片在视频画面上的高度 (pixel)。
  @JsonKey(name: 'height')
  final int? height;

  /// 水印或背景图的图层编号。使用水印数组添加单张或多张水印时，必须向 zOrder 传值，取值范围为 [1,255]，否则 SDK 会报错。其余情况，zOrder 可选传值，取值范围为 [0,255]，0 为默认值。0 代表图层的最下层，255 代表图层的最上层。
  @JsonKey(name: 'zOrder')
  final int? zOrder;

  /// 水印或背景图片的透明度。取值范围为 [0.0,1.0]： 0.0: 完全透明。1.0:（默认）完全不透明。
  @JsonKey(name: 'alpha')
  final double? alpha;

  /// @nodoc
  factory RtcImage.fromJson(Map<String, dynamic> json) =>
      _$RtcImageFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RtcImageToJson(this);
}

/// 转码推流的高级功能配置。
/// 如需使用转码推流高级功能，请联系 。
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LiveStreamAdvancedFeature {
  /// @nodoc
  const LiveStreamAdvancedFeature({this.featureName, this.opened});

  /// 转码推流高级功能的名称，包含 LBHQ（低码率的高清视频功能） 和 VEO（优化的视频编码器功能）。
  @JsonKey(name: 'featureName')
  final String? featureName;

  /// 是否启用转码推流的高级功能： true：开启转码推流的高级功能。false：（默认）关闭转码推流的高级功能。
  @JsonKey(name: 'opened')
  final bool? opened;

  /// @nodoc
  factory LiveStreamAdvancedFeature.fromJson(Map<String, dynamic> json) =>
      _$LiveStreamAdvancedFeatureFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LiveStreamAdvancedFeatureToJson(this);
}

/// 网络连接状态。
///
@JsonEnum(alwaysCreate: true)
enum ConnectionStateType {
  /// 1: 网络连接断开。该状态表示 SDK 处于: 调用 joinChannel [2/2] 加入频道前的初始化阶段。或调用 leaveChannel 后的离开频道阶段。
  @JsonValue(1)
  connectionStateDisconnected,

  /// 2: 建立网络连接中。该状态表示 SDK 在调用 joinChannel [2/2] 后正在与指定的频道建立连接。 如果成功加入频道，app 会收到 onConnectionStateChanged 回调，通知当前网络状态变成 connectionStateConnected。建立连接后，SDK 还会初始化媒体，一切就绪后会回调 onJoinChannelSuccess 。
  @JsonValue(2)
  connectionStateConnecting,

  /// 3: 网络已连接。该状态表示用户已经加入频道，可以在频道内发布或订阅媒体流。如果因网络断开或切换而导致 SDK 与频道的连接中断，SDK 会自动重连，此时 app 会收到
  ///  onConnectionStateChanged 回调，通知当前网络状态变成 connectionStateReconnecting。
  @JsonValue(3)
  connectionStateConnected,

  /// 4: 重新建立网络连接中。该状态表示 SDK 之前曾加入过频道，但因网络等原因连接中断了，此时 SDK 会自动尝试重新接入频道。 如果 SDK 无法在 10 秒内重新加入频道，则 onConnectionLost 会被触发，SDK 会一直保持在 connectionStateReconnecting 的状态，并不断尝试重新加入频道。如果 SDK 在断开连接后，20 分钟内还是没能重新加入频道，则应用程序会收到 onConnectionStateChanged 回调，通知 app 的网络状态进入 connectionStateFailed，SDK 停止尝试重连。
  @JsonValue(4)
  connectionStateReconnecting,

  /// 5: 网络连接失败。该状态表示 SDK 已不再尝试重新加入频道，需要调用 leaveChannel 离开频道。
  ///  如果用户还想重新加入频道，则需要再次调用 joinChannel [2/2]。如果 SDK 因服务器端使用 RESTful API 禁止加入频道，则 app 会收到 onConnectionStateChanged 。
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

/// 参与转码合流的每个主播的设置。
///
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

  /// 主播的用户 ID。
  @JsonKey(name: 'uid')
  final int? uid;

  /// 主播视频画面在输出视频画面的 x 坐标 (pixel)，以输出视频画面的左上角为原点。取值范围为[0,width]，width 为 LiveTranscoding 中设置的 width。
  @JsonKey(name: 'x')
  final int? x;

  /// 主播视频画面在输出视频画面的 y 坐标 (pixel)，以输出视频画面的左上角为原点。取值范围为[0,height]，height 为 LiveTranscoding 中设置的 height。
  @JsonKey(name: 'y')
  final int? y;

  /// 主播视频画面的宽 (pixel)。
  @JsonKey(name: 'width')
  final int? width;

  /// 主播视频画面的高 (pixel)。
  @JsonKey(name: 'height')
  final int? height;

  /// 主播视频画面的图层编号。取值范围为 [0,100]。
  ///  0:（默认）视频画面位于图层的最下层。100: 视频画面位于图层的最上层。如果取值小于 0 或大于 100，会返回错误 errInvalidArgument 。从 v2.3 开始，支持将 zOrder 设置为 0。
  @JsonKey(name: 'zOrder')
  final int? zOrder;

  /// 主播视频画面的透明度。取值范围为 [0.0,1.0]。
  ///  0.0: 完全透明。1.0:（默认）完全不透明。
  @JsonKey(name: 'alpha')
  final double? alpha;

  /// 主播音频在输出音频中占用的声道。默认值为 0，取值范围为 [0,5]：
  ///  0: （推荐）默认混音设置，最多支持双声道，与主播上行音频相关。1: 主播音频在输出音频的 FL 声道。如果主播上行音频是多声道，Agora 服务器会先把多声道混音成单声道。2: 主播音频在输出音频的 FC 声道。如果主播上行音频是多声道，Agora 服务器会先把多声道混音成单声道。3: 主播音频在输出音频的 FR 声道。如果主播上行音频是多声道，Agora 服务器会先把多声道混音成单声道。4: 主播音频在输出音频的 BL 声道。如果主播上行音频是多声道，Agora 服务器会先把多声道混音成单声道。5: 主播音频在输出音频的 BR 声道。如果主播上行音频是多声道，Agora 服务器会先把多声道混音成单声道。0xFF 或取值大于 5: 该主播音频静音，Agora 服务器移除该主播的音频。取值不为 0 时，需要使用特殊的播放器。
  @JsonKey(name: 'audioChannel')
  final int? audioChannel;

  /// @nodoc
  factory TranscodingUser.fromJson(Map<String, dynamic> json) =>
      _$TranscodingUserFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$TranscodingUserToJson(this);
}

/// 旁路推流的转码属性。
///
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

  /// 推流视频的总宽度，默认值 360，单位为像素。如果推视频流，width 取值范围为 [64,1920]。如果取值低于 64，Agora 服务器会自动调整为 64； 如果取值高于 1920，Agora 服务器会自动调整为 1920。如果推音频流，请将 width 和 height 设为 0。
  @JsonKey(name: 'width')
  final int? width;

  /// 推流视频的总高度，默认值 640，单位为像素。如果推视频流，height 取值范围为 [64,1080]。如果取值低于 64，Agora 服务器会自动调整为 64； 如果取值高于 1080，Agora 服务器会自动调整为 1080。如果推音频流，请将 width 和 height 设为 0。
  @JsonKey(name: 'height')
  final int? height;

  /// 用于旁路直播的输出视频的码率。单位为 Kbps。400 Kbps 为默认值。
  @JsonKey(name: 'videoBitrate')
  final int? videoBitrate;

  /// 用于旁路直播的输出视频的帧率。取值范围是 (0,30]，单位为 fps。15 fps 为默认值。Agora 服务器会将高于 30 fps 的帧率统一调整为 30 fps。
  @JsonKey(name: 'videoFramerate')
  final int? videoFramerate;

  /// 弃用Agora 不推荐使用。低延时模式true: 低延时，不保证画质。false:（默认值）高延时，保证画质。
  @JsonKey(name: 'lowLatency')
  final bool? lowLatency;

  /// 用于旁路直播的输出视频的 GOP（Group of Pictures)。单位为帧。默认值为 30。
  @JsonKey(name: 'videoGop')
  final int? videoGop;

  /// 用于旁路直播的输出视频的编码规格。可以设置为 66、77 或 100，详见 VideoCodecProfileType 。如果你把这个参数设为其他值，Agora 服务器会将其调整为默认值。
  @JsonKey(name: 'videoCodecProfile')
  final VideoCodecProfileType? videoCodecProfile;

  /// 用于旁路直播的输出视频的背景色，格式为 RGB 定义下的十六进制整数，不要带 # 号，如 0xFFB6C1 表示浅粉色。默认0x000000，黑色。
  @JsonKey(name: 'backgroundColor')
  final int? backgroundColor;

  /// 用于旁路直播的输出视频的编解码类型。详见 VideoCodecTypeForStream 。
  @JsonKey(name: 'videoCodecType')
  final VideoCodecTypeForStream? videoCodecType;

  /// 参与合图的用户数量，默认 0。取值范围为 [0,17]。
  @JsonKey(name: 'userCount')
  final int? userCount;

  /// 用于管理参与旁路直播的视频转码合图的用户。最多支持 17 人同时参与转码合图。详见 TranscodingUser 。
  @JsonKey(name: 'transcodingUsers')
  final List<TranscodingUser>? transcodingUsers;

  /// 预留参数：用户自定义的发送到旁路推流客户端的信息，用于填充 H264/H265 视频中 SEI 帧内容。长度限制：4096 字节。关于 SEI 的详细信息，详见 SEI 帧相关问题。
  @JsonKey(name: 'transcodingExtraInfo')
  final String? transcodingExtraInfo;

  /// 弃用已废弃，Agora 不推荐使用。发送给 CDN 客户端的 metadata。
  @JsonKey(name: 'metadata')
  final String? metadata;

  /// 直播视频上的水印。图片格式需为 PNG。详见 RtcImage 。你可以添加一个水印，或使用数组的方式添加多个水印。
  @JsonKey(name: 'watermark')
  final List<RtcImage>? watermark;

  /// 直播视频上的水印的数量。水印和背景图的总数量需大于等于 0 且小于等于 10。该参数与 watermark 搭配使用。
  @JsonKey(name: 'watermarkCount')
  final int? watermarkCount;

  /// 直播视频上的背景图。图片格式需为 PNG。详见 RtcImage 。你可以添加一张背景图，或使用数组的方式添加多张背景图。该参数与 backgroundImageCount 搭配使用。
  @JsonKey(name: 'backgroundImage')
  final List<RtcImage>? backgroundImage;

  /// 直播视频上的背景图的数量。水印和背景图的总数量需大于等于 0 且小于等于 10。该参数与 backgroundImage 搭配使用。
  @JsonKey(name: 'backgroundImageCount')
  final int? backgroundImageCount;

  /// 用于旁路推流的输出媒体流的音频采样率 (Hz)，详见 AudioSampleRateType 。
  @JsonKey(name: 'audioSampleRate')
  final AudioSampleRateType? audioSampleRate;

  /// 用于旁路直播的输出音频的码率。单位为 Kbps，默认值为 48，最大值为 128。
  @JsonKey(name: 'audioBitrate')
  final int? audioBitrate;

  /// 用于旁路直播的输出音频的声道数，默认值为 1。取值范围为 [1,5] 中的整型，建议取 1 或 2。3、4、5 需要特殊播放器支持： 1: （默认）单声道2: 双声道3: 三声道4: 四声道5: 五声道
  @JsonKey(name: 'audioChannels')
  final int? audioChannels;

  /// 用于旁路直播输出音频的编码规格。详见 AudioCodecProfileType 。
  ///
  @JsonKey(name: 'audioCodecProfile')
  final AudioCodecProfileType? audioCodecProfile;

  /// 转码推流的高级功能。详见 LiveStreamAdvancedFeature 。
  @JsonKey(name: 'advancedFeatures')
  final List<LiveStreamAdvancedFeature>? advancedFeatures;

  /// 开启的高级功能数量。默认值为 0。
  @JsonKey(name: 'advancedFeatureCount')
  final int? advancedFeatureCount;

  /// @nodoc
  factory LiveTranscoding.fromJson(Map<String, dynamic> json) =>
      _$LiveTranscodingFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LiveTranscodingToJson(this);
}

/// 参与本地合图的视频流。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TranscodingVideoStream {
  /// @nodoc
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

  /// 参与本地合图的视频源类型。详见 VideoSourceType 。
  @JsonKey(name: 'sourceType')
  final MediaSourceType? sourceType;

  /// 远端用户 ID。 请仅在参与本地合图的视频源类型为 videoSourceRemote 时，使用该参数。
  @JsonKey(name: 'remoteUserUid')
  final int? remoteUserUid;

  /// 图像的 URL。
  @JsonKey(name: 'imageUrl')
  final String? imageUrl;

  /// 参与本地合图的视频的左上角相对于合图画布左上角（原点）的横向位移。
  @JsonKey(name: 'x')
  final int? x;

  /// 参与本地合图的视频的左上角相对于合图画布左上角（原点）的纵向位移。
  @JsonKey(name: 'y')
  final int? y;

  /// 参与本地合图的视频的宽度 (px)。
  @JsonKey(name: 'width')
  final int? width;

  /// 参与本地合图的视频的高度 (px)。
  @JsonKey(name: 'height')
  final int? height;

  /// 参与本地合图的视频所属的图层的编号。取值范围为 [0,100]。 0:（默认值）图层在最下层。100: 图层在最上层。
  @JsonKey(name: 'zOrder')
  final int? zOrder;

  /// 参与本地合图的视频的透明度。取值范围为 [0.0,1.0]。 0.0 表示透明度为完全透明，1.0 表示透明度为完全不透明。
  @JsonKey(name: 'alpha')
  final double? alpha;

  /// 是否对参与本地合图的的视频进行镜像： true: 镜像。false: （默认值）不镜像。该参数仅对视频源类型为 CAMERA
  @JsonKey(name: 'mirror')
  final bool? mirror;

  /// @nodoc
  factory TranscodingVideoStream.fromJson(Map<String, dynamic> json) =>
      _$TranscodingVideoStreamFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$TranscodingVideoStreamToJson(this);
}

/// 本地合图的配置。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LocalTranscoderConfiguration {
  /// @nodoc
  const LocalTranscoderConfiguration(
      {this.streamCount,
      this.videoInputStreams,
      this.videoOutputConfiguration});

  /// 参与本地合图的视频流的数量。
  @JsonKey(name: 'streamCount')
  final int? streamCount;

  /// 参与本地合图的视频流。详见 TranscodingVideoStream 。
  @JsonKey(name: 'VideoInputStreams')
  final List<TranscodingVideoStream>? videoInputStreams;

  /// 本地合图后，合图视频的编码配置。详见 VideoEncoderConfiguration 。
  @JsonKey(name: 'videoOutputConfiguration')
  final VideoEncoderConfiguration? videoOutputConfiguration;

  /// @nodoc
  factory LocalTranscoderConfiguration.fromJson(Map<String, dynamic> json) =>
      _$LocalTranscoderConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LocalTranscoderConfigurationToJson(this);
}

/// Last mile 网络探测配置。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LastmileProbeConfig {
  /// @nodoc
  const LastmileProbeConfig(
      {this.probeUplink,
      this.probeDownlink,
      this.expectedUplinkBitrate,
      this.expectedDownlinkBitrate});

  /// 是否探测上行网络。有些用户，如直播频道中的普通观众，不需要进行网络探测:
  ///  true: 探测。false: 不探测。
  @JsonKey(name: 'probeUplink')
  final bool? probeUplink;

  /// 是否探测下行网络。
  ///  true: 探测。false: 不探测。
  @JsonKey(name: 'probeDownlink')
  final bool? probeDownlink;

  /// 用户期望的最高发送码率，单位为 bps，范围为 [100000,5000000]。Agora 推荐参考 setVideoEncoderConfiguration 中的码率值设置该参数的值。
  @JsonKey(name: 'expectedUplinkBitrate')
  final int? expectedUplinkBitrate;

  /// 用户期望的最高接收码率，单位为 bps，范围为 [100000,5000000]。
  @JsonKey(name: 'expectedDownlinkBitrate')
  final int? expectedDownlinkBitrate;

  /// @nodoc
  factory LastmileProbeConfig.fromJson(Map<String, dynamic> json) =>
      _$LastmileProbeConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LastmileProbeConfigToJson(this);
}

/// Last mile 质量探测结果的状态。
///
@JsonEnum(alwaysCreate: true)
enum LastmileProbeResultState {
  /// 1: 表示本次 last mile 质量探测的结果是完整的。
  @JsonValue(1)
  lastmileProbeResultComplete,

  /// 2: 表示本次 last mile 质量探测未进行带宽预测，因此结果不完整。一个可能的原因是测试资源暂时受限。
  @JsonValue(2)
  lastmileProbeResultIncompleteNoBwe,

  /// 3: 未进行 last mile 质量探测。一个可能的原因是网络连接中断。
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

/// 上行或下行 Last mile 网络质量探测结果。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LastmileProbeOneWayResult {
  /// @nodoc
  const LastmileProbeOneWayResult(
      {this.packetLossRate, this.jitter, this.availableBandwidth});

  /// 丢包率。
  @JsonKey(name: 'packetLossRate')
  final int? packetLossRate;

  /// 网络抖动 (ms)。
  @JsonKey(name: 'jitter')
  final int? jitter;

  /// 可用网络带宽预估 (bps)。
  @JsonKey(name: 'availableBandwidth')
  final int? availableBandwidth;

  /// @nodoc
  factory LastmileProbeOneWayResult.fromJson(Map<String, dynamic> json) =>
      _$LastmileProbeOneWayResultFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LastmileProbeOneWayResultToJson(this);
}

/// 上下行 Last mile 网络质量探测结果。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LastmileProbeResult {
  /// @nodoc
  const LastmileProbeResult(
      {this.state, this.uplinkReport, this.downlinkReport, this.rtt});

  /// Last mile 质量探测结果的状态。详见: LastmileProbeResultState 。
  @JsonKey(name: 'state')
  final LastmileProbeResultState? state;

  /// 上行网络质量报告。详见 LastmileProbeOneWayResult 。
  @JsonKey(name: 'uplinkReport')
  final LastmileProbeOneWayResult? uplinkReport;

  /// 下行网络质量报告。详见 LastmileProbeOneWayResult 。
  @JsonKey(name: 'downlinkReport')
  final LastmileProbeOneWayResult? downlinkReport;

  /// 往返时延 (ms)。
  @JsonKey(name: 'rtt')
  final int? rtt;

  /// @nodoc
  factory LastmileProbeResult.fromJson(Map<String, dynamic> json) =>
      _$LastmileProbeResultFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LastmileProbeResultToJson(this);
}

/// 网络连接状态发生变化的原因。
///
@JsonEnum(alwaysCreate: true)
enum ConnectionChangedReasonType {
  /// 0: 建立网络连接中。
  @JsonValue(0)
  connectionChangedConnecting,

  /// 1: 成功加入频道。
  @JsonValue(1)
  connectionChangedJoinSuccess,

  /// 2: 网络连接中断。
  @JsonValue(2)
  connectionChangedInterrupted,

  /// 3: 网络连接被服务器禁止。服务端踢人场景时会报这个错。
  @JsonValue(3)
  connectionChangedBannedByServer,

  /// 4: 加入频道失败。SDK 在尝试加入频道 20 分钟后还是没能加入频道，会返回该状态，并停止尝试重连。
  @JsonValue(4)
  connectionChangedJoinFailed,

  /// 5: 离开频道。
  @JsonValue(5)
  connectionChangedLeaveChannel,

  /// 6: 不是有效的 APP ID。请更换有效的 APP ID 重新加入频道。
  @JsonValue(6)
  connectionChangedInvalidAppId,

  /// 7: 不是有效的频道名。请更换有效的频道名重新加入频道。
  @JsonValue(7)
  connectionChangedInvalidChannelName,

  /// 8: 生成的 Token 无效。一般有以下原因： 在控制台上启用了 App Certificate，但加入频道未使用 Token。当启用了 App Certificate，必须使用 Token。在调用 joinChannel [2/2] 加入频道时指定的用户 ID 与生成 Token 时传入的用户 ID 不一致。
  @JsonValue(8)
  connectionChangedInvalidToken,

  /// 9: 当前使用的 Token 过期，不再有效，需要重新在你的服务端申请生成 Token。
  @JsonValue(9)
  connectionChangedTokenExpired,

  /// 10: 此用户被服务器禁止。一般有以下原因： 用户已进入频道，再次调用加入频道的 API，例如 joinChannel [2/2]，会返回此状态。停止调用该方法即可。用户在进行通话测试时尝试加入频道。等待通话测试结束后再加入频道即可。
  @JsonValue(10)
  connectionChangedRejectedByServer,

  /// 11: 由于设置了代理服务器，SDK 尝试重连。
  @JsonValue(11)
  connectionChangedSettingProxyServer,

  /// 12: 更新 Token 引起网络连接状态改变。
  @JsonValue(12)
  connectionChangedRenewToken,

  /// 13: 客户端 IP 地址变更，可能是由于网络类型，或网络运营商的 IP 或端口发生改变引起。
  @JsonValue(13)
  connectionChangedClientIpAddressChanged,

  /// 14: SDK 和服务器连接保活超时，进入自动重连状态。
  @JsonValue(14)
  connectionChangedKeepAliveTimeout,

  /// 15: 重新加入频道成功。
  @JsonValue(15)
  connectionChangedRejoinSuccess,

  /// 16: SDK 和服务器失去连接。
  @JsonValue(16)
  connectionChangedLost,

  /// 17: 连接状态变化由回声测试引起。
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

/// 切换用户角色失败的原因。
///
@JsonEnum(alwaysCreate: true)
enum ClientRoleChangeFailedReason {
  /// 1: 频道内主播人数达到上限。该枚举仅在开启 128 人功能后报告。主播人数的上限根据开启 128 人功能时实际配置的人数而定。
  @JsonValue(1)
  clientRoleChangeFailedTooManyBroadcasters,

  /// 2: 请求被服务端拒绝。建议提示用户重新尝试切换用户角色。
  @JsonValue(2)
  clientRoleChangeFailedNotAuthorized,

  /// 3: 请求超时。建议提示用户检查网络连接状况后重新尝试切换用户角色。
  @JsonValue(3)
  clientRoleChangeFailedRequestTimeOut,

  /// 4: 网络连接断开。可根据 onConnectionStateChanged 报告的 reason，排查网络连接失败的具体原因。
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

/// 网络连接类型。
///
@JsonEnum(alwaysCreate: true)
enum NetworkType {
  /// -1: 网络连接类型未知。
  @JsonValue(-1)
  networkTypeUnknown,

  /// 0: 网络连接已断开。
  @JsonValue(0)
  networkTypeDisconnected,

  /// 1: 网络类型为 LAN。
  @JsonValue(1)
  networkTypeLan,

  /// 2: 网络类型为 Wi-Fi (包含热点）。
  @JsonValue(2)
  networkTypeWifi,

  /// 3: 网络类型为 2G 移动网络。
  @JsonValue(3)
  networkTypeMobile2g,

  /// 4: 网络类型为 3G 移动网络。
  @JsonValue(4)
  networkTypeMobile3g,

  /// 5: 网络类型为 4G 移动网络。
  @JsonValue(5)
  networkTypeMobile4g,
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

/// 视频画布对象的属性。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoCanvas {
  /// @nodoc
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

  /// 视频显示窗口。
  @JsonKey(name: 'view')
  final int? view;

  /// 视频渲染模式，详见 RenderModeType 。
  @JsonKey(name: 'renderMode')
  final RenderModeType? renderMode;

  /// 视图镜像模式，详见 VideoMirrorModeType 。本地视图镜像模式：如果你使用前置摄像头，默认启动本地视图镜像模式；如果你使用后置摄像头，默认关闭本地视图镜像模式。远端用户视图镜像模式：默认关闭远端用户的镜像模式。
  @JsonKey(name: 'mirrorMode')
  final VideoMirrorModeType? mirrorMode;

  /// 用户 ID。
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

  /// 视频源的类型，详见 VideoSourceType 。
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

/// 美颜选项。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class BeautyOptions {
  /// @nodoc
  const BeautyOptions(
      {this.lighteningContrastLevel,
      this.lighteningLevel,
      this.smoothnessLevel,
      this.rednessLevel,
      this.sharpnessLevel});

  /// 对比度，常与 lighteningLevel 搭配使用。取值越大，明暗对比程度越大。详见 LighteningContrastLevel 。
  @JsonKey(name: 'lighteningContrastLevel')
  final LighteningContrastLevel? lighteningContrastLevel;

  /// 美白程度，取值范围为 [0.0,1.0]，其中 0.0 表示原始亮度，默认值为 0.0。取值越大，美白程度越大。
  @JsonKey(name: 'lighteningLevel')
  final double? lighteningLevel;

  /// 磨皮程度，取值范围为 [0.0,1.0]，其中 0.0 表示原始磨皮程度，默认值为 0.0。取值越大，磨皮程度越大。
  @JsonKey(name: 'smoothnessLevel')
  final double? smoothnessLevel;

  /// 红润度，取值范围为 [0.0,1.0]，其中 0.0 表示原始红润度，默认值为 0.0。取值越大，红润程度越大。
  @JsonKey(name: 'rednessLevel')
  final double? rednessLevel;

  /// 锐化程度，取值范围为 [0.0,1.0]，其中 0.0 表示原始锐度，默认值为 0.0。取值越大，锐化程度越大。
  @JsonKey(name: 'sharpnessLevel')
  final double? sharpnessLevel;

  /// @nodoc
  factory BeautyOptions.fromJson(Map<String, dynamic> json) =>
      _$BeautyOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$BeautyOptionsToJson(this);
}

/// 亮度明暗对比度。
///
@JsonEnum(alwaysCreate: true)
enum LighteningContrastLevel {
  /// 0：低对比度。
  @JsonValue(0)
  lighteningContrastLow,

  /// 1：正常对比度。
  @JsonValue(1)
  lighteningContrastNormal,

  /// 2：高对比度。
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

/// 暗光增强选项。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LowlightEnhanceOptions {
  /// @nodoc
  const LowlightEnhanceOptions({this.mode, this.level});

  /// 暗光增强模式。详见 LowLightEnhanceMode 。
  @JsonKey(name: 'mode')
  final LowLightEnhanceMode? mode;

  /// 暗光增强等级。详见 LowLightEnhanceLevel 。
  @JsonKey(name: 'level')
  final LowLightEnhanceLevel? level;

  /// @nodoc
  factory LowlightEnhanceOptions.fromJson(Map<String, dynamic> json) =>
      _$LowlightEnhanceOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LowlightEnhanceOptionsToJson(this);
}

/// 暗光增强模式。
///
@JsonEnum(alwaysCreate: true)
enum LowLightEnhanceMode {
  /// 0:（默认）自动模式。SDK 会根据环境光亮度自动开启或关闭暗光增强功能，以适时补光和防止过曝。
  @JsonValue(0)
  lowLightEnhanceAuto,

  /// 1：手动模式。用户需手动开启或关闭暗光增强功能。
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

/// 暗光增强等级。
///
@JsonEnum(alwaysCreate: true)
enum LowLightEnhanceLevel {
  /// 0:（默认）优先画质的暗光增强，会处理视频图像的亮度、细节、噪声，消耗的性能适中，处理速度适中，综合画质最优。
  @JsonValue(0)
  lowLightEnhanceLevelHighQuality,

  /// 1：优先性能的暗光增强，会处理视频图像的亮度、细节，消耗的性能较少，处理速度较快。
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

/// 视频降噪选项。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoDenoiserOptions {
  /// @nodoc
  const VideoDenoiserOptions({this.mode, this.level});

  /// 视频降噪模式。
  @JsonKey(name: 'mode')
  final VideoDenoiserMode? mode;

  /// 视频降噪等级。
  @JsonKey(name: 'level')
  final VideoDenoiserLevel? level;

  /// @nodoc
  factory VideoDenoiserOptions.fromJson(Map<String, dynamic> json) =>
      _$VideoDenoiserOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$VideoDenoiserOptionsToJson(this);
}

/// 视频降噪模式。
///
@JsonEnum(alwaysCreate: true)
enum VideoDenoiserMode {
  /// 0:（默认）自动模式。SDK 会根据环境光亮度自动开启或关闭视频降噪功能。
  @JsonValue(0)
  videoDenoiserAuto,

  /// 1：手动模式。用户需手动开启或关闭视频降噪功能。
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

/// 视频降噪等级。
///
@JsonEnum(alwaysCreate: true)
enum VideoDenoiserLevel {
  /// 0:（默认）优先画质的视频降噪。是在性能消耗和视频降噪效果中取平衡的等级。性能消耗适中，视频降噪速度适中，综合画质最优。
  @JsonValue(0)
  videoDenoiserLevelHighQuality,

  /// 1：优先性能的视频降噪。是在性能消耗和视频降噪效果中侧重于节省性能的等级。性能消耗较少，视频降噪速度较快。为避免处理后的视频有明显的拖影效果，Agora 推荐你在摄像头固定的情况下使用该设置。
  @JsonValue(1)
  videoDenoiserLevelFast,

  /// 2：强效的视频降噪。是在性能消耗和视频降噪效果中侧重于视频降噪效果的等级。性能消耗较多，视频降噪速度较慢，视频降噪效果较好。如果 videoDenoiserLevelHighQuality 不能满足你的视频降噪需求，你可以使用该设置。
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

/// 色彩增强选项。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ColorEnhanceOptions {
  /// @nodoc
  const ColorEnhanceOptions({this.strengthLevel, this.skinProtectLevel});

  /// 色彩增强程度。取值范围为 [0.0,1.0]。0.0 表示不对视频进行色彩增强。取值越大，色彩增强的程度越大。默认值为 0.5。
  @JsonKey(name: 'strengthLevel')
  final double? strengthLevel;

  /// 肤色保护程度。取值范围为 [0.0,1.0]。0.0 表示不对肤色进行保护。取值越大，肤色保护的程度越大。默认值为 1.0。当色彩增强程度较大时，人像肤色会明显失真，你需要设置肤色保护程度；肤色保护程度较大时，色彩增强效果会略微降低。
  ///  因此，为获取最佳的色彩增强效果，Agora 建议你动态调节 strengthLevel 和 skinProtectLevel 以实现最合适的效果。
  @JsonKey(name: 'skinProtectLevel')
  final double? skinProtectLevel;

  /// @nodoc
  factory ColorEnhanceOptions.fromJson(Map<String, dynamic> json) =>
      _$ColorEnhanceOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ColorEnhanceOptionsToJson(this);
}

/// 自定义的背景。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VirtualBackgroundSource {
  /// @nodoc
  const VirtualBackgroundSource(
      {this.backgroundSourceType, this.color, this.source, this.blurDegree});

  /// 自定义的背景图类型。详见 backgroundSourceType 。
  @JsonKey(name: 'background_source_type')
  final BackgroundSourceType? backgroundSourceType;

  /// 自定义的背景图颜色。格式为 RGB 定义下的十六进制整数，不要带 # 号，如 0xFFB6C1 表示浅粉色。 默认值为 0xFFFFFF，表示白色。 取值范围为 [0x000000，0xffffff]。如果取值非法，SDK 会用白色背景图替换原背景图。 该参数仅在自定义背景图类型为 backgroundColor 时生效。
  @JsonKey(name: 'color')
  final int? color;

  /// 自定义背景图的本地绝对路径。支持 PNG 和 JPG 格式。如果路径无效，SDK 会用白色背景图替换原背景图。 该参数仅在自定义背景图类型为 backgroundImg 时生效。
  @JsonKey(name: 'source')
  final String? source;

  /// 自定义背景图的模糊程度。该参数仅在自定义背景图类型为 backgroundBlur 时生效。
  @JsonKey(name: 'blur_degree')
  final BackgroundBlurDegree? blurDegree;

  /// @nodoc
  factory VirtualBackgroundSource.fromJson(Map<String, dynamic> json) =>
      _$VirtualBackgroundSourceFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$VirtualBackgroundSourceToJson(this);
}

/// 自定义的背景图类型。
///
@JsonEnum(alwaysCreate: true)
enum BackgroundSourceType {
  /// 1:（默认）背景图为纯色。
  @JsonValue(1)
  backgroundColor,

  /// 背景图为 PNG、JPG 格式的图片。
  @JsonValue(2)
  backgroundImg,

  /// 将虚化处理后的背景作为背景图。
  @JsonValue(3)
  backgroundBlur,
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

/// 自定义背景图的虚化程度。
///
@JsonEnum(alwaysCreate: true)
enum BackgroundBlurDegree {
  /// 1: 自定义背景图的虚化程度为低。用户差不多能看清背景。
  @JsonValue(1)
  blurDegreeLow,

  /// 自定义背景图的虚化程度为中。用户较难看清背景。
  @JsonValue(2)
  blurDegreeMedium,

  /// （默认）自定义背景图的虚化程度为高。用户很难看清背景。
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

/// 背景图像的处理属性。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SegmentationProperty {
  /// @nodoc
  const SegmentationProperty({this.modelType, this.greenCapacity});

  /// 进行背景处理的算法。详见 SegModelType 。
  @JsonKey(name: 'modelType')
  final SegModelType? modelType;

  /// 对画面中绿颜色（即不同程度的绿色）识别的精度范围。取值范围为 [0,1]，默认值为 0.5。取值越大，代表可识别的绿色范围越大。当该参数取值过大时，人像边缘和人像范围内的绿色也会被识别。Agora 推荐你根据实际效果动态调整该参数的值。该参数仅在 modelType 设置为 segModelGreen 时生效。
  @JsonKey(name: 'greenCapacity')
  final double? greenCapacity;

  /// @nodoc
  factory SegmentationProperty.fromJson(Map<String, dynamic> json) =>
      _$SegmentationPropertyFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$SegmentationPropertyToJson(this);
}

/// 进行背景处理的算法。
///
@JsonEnum(alwaysCreate: true)
enum SegModelType {
  /// 1: (默认) 适用于所有场景下的背景处理算法。
  @JsonValue(1)
  segModelAi,

  /// 2: 仅适用于绿幕背景下的背景处理算法。
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

/// 预设的美声效果选项。
///
@JsonEnum(alwaysCreate: true)
enum VoiceBeautifierPreset {
  /// 原声，即关闭美声效果。
  @JsonValue(0x00000000)
  voiceBeautifierOff,

  /// 磁性（男）。该设置仅对男声有效，请勿用于设置女声，否则音频会失真。
  @JsonValue(0x01010100)
  chatBeautifierMagnetic,

  /// 清新（女）。该设置仅对女声有效，请勿用于设置男声，否则音频会失真。
  @JsonValue(0x01010200)
  chatBeautifierFresh,

  /// 活力（女）。该设置仅对女声有效，请勿用于设置男声，否则音频会失真。
  @JsonValue(0x01010300)
  chatBeautifierVitality,

  /// 歌唱美声。如果调用 setVoiceBeautifierPreset (singingBeautifier)，你可以美化男声并添加歌声在小房间的混响效果。请勿用于设置女声，否则音频会失真。如果调用 setVoiceBeautifierParameters (singingBeautifier, param1, param2)，你可以美化男声或女声并添加混响效果。
  @JsonValue(0x01020100)
  singingBeautifier,

  /// 浑厚。
  @JsonValue(0x01030100)
  timbreTransformationVigorous,

  /// 低沉。
  @JsonValue(0x01030200)
  timbreTransformationDeep,

  /// 圆润。
  @JsonValue(0x01030300)
  timbreTransformationMellow,

  /// 假音。
  @JsonValue(0x01030400)
  timbreTransformationFalsetto,

  /// 饱满。
  @JsonValue(0x01030500)
  timbreTransformationFull,

  /// 清澈。
  @JsonValue(0x01030600)
  timbreTransformationClear,

  /// 高亢。
  @JsonValue(0x01030700)
  timbreTransformationResounding,

  /// 嘹亮。
  @JsonValue(0x01030800)
  timbreTransformationRinging,

  /// 超高音质，即让音频更清晰、细节更丰富。
  ///  为达到更好的效果，我们推荐在调用 setVoiceBeautifierPreset 前将 setAudioProfile [2/2] 的 profile 参数设置为 audioProfileMusicHighQuality(4) 或 audioProfileMusicHighQualityStereo(5)，且 scenario 参数设置为 audioScenarioGameStreaming(3)。如果用户的音频采集设备可以高度还原音频细节，Agora 建议你不要开启超高音质，否则 SDK 会过度还原音频细节，达不到预期效果。
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

/// 预设的音效选项。
/// 为获取更好的音效，Agora 建议在使用预设音效前，调用 setAudioProfile [1/2] 并按照如下推荐设置 profile 参数。
@JsonEnum(alwaysCreate: true)
enum AudioEffectPreset {
  /// 原声，即关闭人声音效。
  @JsonValue(0x00000000)
  audioEffectOff,

  /// KTV。
  @JsonValue(0x02010100)
  roomAcousticsKtv,

  /// 演唱会。
  @JsonValue(0x02010200)
  roomAcousticsVocalConcert,

  /// 录音棚。
  @JsonValue(0x02010300)
  roomAcousticsStudio,

  /// 留声机。
  @JsonValue(0x02010400)
  roomAcousticsPhonograph,

  /// 虚拟立体声，即 SDK 将单声道的音频渲染出双声道的音效。
  ///
  @JsonValue(0x02010500)
  roomAcousticsVirtualStereo,

  /// 空旷。
  @JsonValue(0x02010600)
  roomAcousticsSpacial,

  /// 空灵。
  @JsonValue(0x02010700)
  roomAcousticsEthereal,

  /// 3D 人声，即 SDK 将音频渲染出在用户周围环绕的效果。环绕周期默认为 10 秒。设置该音效后，你还可以调用 setAudioEffectParameters 修改环绕周期。启用 3D 人声后，用户需要使用支持双声道的音频播放设备才能听到预期效果。
  @JsonValue(0x02010800)
  roomAcoustics3dVoice,

  /// 虚拟环绕声，即 SDK 在双声道的基础上产生仿真的环绕声场，从而营造出具有环绕感的音效。 启用虚拟环绕声后，用户需要使用支持双声道的音频播放设备才能听到预期效果。
  @JsonValue(0x02010900)
  roomAcousticsVirtualSurroundSound,

  /// 大叔。建议用于处理男声，否则无法达到预期效果。
  @JsonValue(0x02020100)
  voiceChangerEffectUncle,

  /// 老年男性。建议用于处理男声，否则无法达到预期效果。
  @JsonValue(0x02020200)
  voiceChangerEffectOldman,

  /// 男孩。建议用于处理男声，否则无法达到预期效果。
  @JsonValue(0x02020300)
  voiceChangerEffectBoy,

  /// 少女。建议用于处理女声，否则无法达到预期效果。
  @JsonValue(0x02020400)
  voiceChangerEffectSister,

  /// 女孩。建议用于处理女声，否则无法达到预期效果。
  @JsonValue(0x02020500)
  voiceChangerEffectGirl,

  /// 猪八戒。
  @JsonValue(0x02020600)
  voiceChangerEffectPigking,

  /// 绿巨人。
  @JsonValue(0x02020700)
  voiceChangerEffectHulk,

  /// R&B。
  @JsonValue(0x02030100)
  styleTransformationRnb,

  /// 流行。
  @JsonValue(0x02030200)
  styleTransformationPopular,

  /// 电音，即 SDK 以主音音高为 C 的自然大调为基础修正音频的实际音高。设置该音效后，你还可以调用 setAudioEffectParameters 调整修音的基础调式和主音音高。
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

/// 预设的变声效果选项。
///
@JsonEnum(alwaysCreate: true)
enum VoiceConversionPreset {
  /// 原声，即关闭变声效果。
  @JsonValue(0x00000000)
  voiceConversionOff,

  /// 中性。为避免音频失真，请确保仅对女声设置该效果。
  @JsonValue(0x03010100)
  voiceChangerNeutral,

  /// 甜美。为避免音频失真，请确保仅对女声设置该效果。
  @JsonValue(0x03010200)
  voiceChangerSweet,

  /// 稳重。为避免音频失真，请确保仅对男声设置该效果。
  @JsonValue(0x03010300)
  voiceChangerSolid,

  /// 低沉。为避免音频失真，请确保仅对男声设置该效果。
  @JsonValue(0x03010400)
  voiceChangerBass,
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

/// 屏幕共享的参数配置。
///
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

  /// 编码共享视频的最大像素值。当共享的屏幕分辨率宽高比与该值设置不一致时，SDK 按如下策略进行编码。假设 dimensions 设为 1920 × 1080： 如果屏幕分辨率小于 dimensions，如 1000 × 1000，SDK 直接按 1000 × 1000 进行编码。如果屏幕分辨率大于 dimensions，如 2000 × 1500，SDK 按屏幕分辨率的宽高比，即 4:3，取 dimensions 以内的最大分辨率进行编码，即 1440 × 1080。
  @JsonKey(name: 'dimensions')
  final VideoDimensions? dimensions;

  /// 共享视频的帧率。单位为 fps；默认值为 5，建议不要超过 15。
  @JsonKey(name: 'frameRate')
  final int? frameRate;

  /// 共享视频的码率。单位为 Kbps；默认值为 0，表示 SDK 根据当前共享屏幕的分辨率计算出一个合理的值。
  @JsonKey(name: 'bitrate')
  final int? bitrate;

  /// 是否采集鼠标用于屏幕共享： true:（默认）采集鼠标。false: 不采集鼠标。
  @JsonKey(name: 'captureMouseCursor')
  final bool? captureMouseCursor;

  /// 调用 startScreenCaptureByWindowId 方法共享窗口时，是否将该窗口前置： true: 前置窗口。false:（默认）不前置窗口。
  @JsonKey(name: 'windowFocus')
  final bool? windowFocus;

  /// 待屏蔽窗口的 ID 列表。调用 startScreenCaptureByDisplayId 开启屏幕共享时，你可以通过该参数屏蔽指定的窗口。你可以在调用 updateScreenCaptureParameters 更新屏幕共享的配置参数时，通过该参数动态屏蔽指定的窗口。
  @JsonKey(name: 'excludeWindowList')
  final List<int>? excludeWindowList;

  /// 待屏蔽窗口的数量。
  @JsonKey(name: 'excludeWindowCount')
  final int? excludeWindowCount;

  /// （仅适用于 macOS）描边的宽度 (px)。默认值为 5，取值范围为 (0,50]。该参数仅在 highLighted 设置为 true 时生效。
  @JsonKey(name: 'highLightWidth')
  final int? highLightWidth;

  /// （仅适用于 macOS）描边的 RGBA 颜色。默认值为 0xFF8CBF26。在 macOS 平台上，COLOR_CLASS 指 NSColor。
  @JsonKey(name: 'highLightColor')
  final int? highLightColor;

  /// （仅适用于 macOS）是否对共享的窗口或屏幕进行描边：true: 描边。false: （默认）不描边。当你在共享窗口或屏幕的部分区域时，如果将该参数设置为 true，SDK 会对整个窗口或屏幕进行描边。
  @JsonKey(name: 'enableHighLight')
  final bool? enableHighLight;

  /// @nodoc
  factory ScreenCaptureParameters.fromJson(Map<String, dynamic> json) =>
      _$ScreenCaptureParametersFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ScreenCaptureParametersToJson(this);
}

/// 录音音质。
///
@JsonEnum(alwaysCreate: true)
enum AudioRecordingQualityType {
  /// 0: 低音质。采样率为 32 kHz，录制 10 分钟的文件大小为 1.2 M 左右。
  @JsonValue(0)
  audioRecordingQualityLow,

  /// 1: 中音质。采样率为 32 kHz，录制 10 分钟的文件大小为 2 M 左右。
  @JsonValue(1)
  audioRecordingQualityMedium,

  /// 2: 高音质。采样率为 32 kHz，录制 10 分钟的文件大小为 3.75 M 左右。
  @JsonValue(2)
  audioRecordingQualityHigh,

  /// 3: 超高音质。采样率为 32 KHz，录制 10 分钟的文件大小约为 7.5 M 左右。
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

/// 录音内容。在 startAudioRecording 中设置。
///
@JsonEnum(alwaysCreate: true)
enum AudioFileRecordingType {
  /// 1: 仅录制本地用户的音频。
  @JsonValue(1)
  audioFileRecordingMic,

  /// 2: 仅录制所有远端用户的音频。
  @JsonValue(2)
  audioFileRecordingPlayback,

  /// 3: 录制本地和所有远端用户混音后的音频。
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

/// 音频编码内容。
///
@JsonEnum(alwaysCreate: true)
enum AudioEncodedFrameObserverPosition {
  /// 1: 仅编码本地用户的音频。
  @JsonValue(1)
  audioEncodedFrameObserverPositionRecord,

  /// 2: 仅编码所有远端用户的音频。
  @JsonValue(2)
  audioEncodedFrameObserverPositionPlayback,

  /// 3: 编码本地和所有远端用户混音后的音频。
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

/// 录音配置。
///
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

  /// 录音文件在本地保存的绝对路径，需精确到文件名及格式。例如：C:\music\audio.mp4。 请确保你指定的路径存在并且可写。
  @JsonKey(name: 'filePath')
  final String? filePath;

  /// 设置是否编码音频数据：
  ///  true: 将音频数据用 AAC 编码。false:（默认）不编码音频数据，直接保存录制的音频数据。
  @JsonKey(name: 'encode')
  final bool? encode;

  /// 录音采样率（Hz）。
  ///  1600032000 （默认）4410048000如果把该参数设为 44100 或 48000，为保证录音效果，Agora 推荐录制 WAV 文件或 quality 为 audioRecordingQualityMedium 或 audioRecordingQualityHigh 的 AAC 文件。
  @JsonKey(name: 'sampleRate')
  final int? sampleRate;

  /// 录音内容。详见 AudioFileRecordingType 。
  @JsonKey(name: 'fileRecordingType')
  final AudioFileRecordingType? fileRecordingType;

  /// 录音音质。详见 audiorecordingqualitytype 。该参数仅适用于 AAC 文件。
  @JsonKey(name: 'quality')
  final AudioRecordingQualityType? quality;

  /// 录制的音频声道。目前支持如下取值：
  ///  1:（默认）单声道。2: 双声道。实际录制的音频声道与你采集的音频声道有关：
  ///  如果采集的音频为单声道，recordingChannel 设为 2， 则录制的音频为经过单声道数据拷贝后的双声道数据，而不是立体声。如果采集的音频为双声道，recordingChannel 设为 1，则录制的音频为经过双声道数据混合后的单声道数据。此外，集成方案也会影响最终录制的音频声道。因此，如果你希望录制立体声，请协助。
  @JsonKey(name: 'recordingChannel')
  final int? recordingChannel;

  /// @nodoc
  factory AudioRecordingConfiguration.fromJson(Map<String, dynamic> json) =>
      _$AudioRecordingConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AudioRecordingConfigurationToJson(this);
}

/// 编码后音频的观测器设置。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioEncodedFrameObserverConfig {
  /// @nodoc
  const AudioEncodedFrameObserverConfig({this.postionType, this.encodingType});

  /// 音频编码内容。详见 AudioEncodedFrameObserverPosition 。
  @JsonKey(name: 'postionType')
  final AudioEncodedFrameObserverPosition? postionType;

  /// 音频编码类型。详见 AudioEncodingType 。
  @JsonKey(name: 'encodingType')
  final AudioEncodingType? encodingType;

  /// @nodoc
  factory AudioEncodedFrameObserverConfig.fromJson(Map<String, dynamic> json) =>
      _$AudioEncodedFrameObserverConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() =>
      _$AudioEncodedFrameObserverConfigToJson(this);
}

/// 编码后音频的观测器。
///
class AudioEncodedFrameObserver {
  /// @nodoc
  const AudioEncodedFrameObserver({
    this.onRecordAudioEncodedFrame,
    this.onPlaybackAudioEncodedFrame,
    this.onMixedAudioEncodedFrame,
  });

  /// 获取本地用户的音频编码数据。
  /// 调用 registerAudioEncodedFrameObserver 并将音频编码内容设为 audioEncodedFrameObserverPositionRecord 后，你可以通过该回调获取本地用户的音频编码数据。
  ///
  /// * [channels] 声道数：
  ///  1：单声道。2：双声道。双声道的音频数据是交叉存储的。
  /// * [frameBuffer] 音频 buffer。
  /// * [length] 音频数据长度，单位为字节。
  /// * [audioEncodedFrameInfo] 编码后音频的信息。详见 EncodedAudioFrameInfo 。
  final void Function(Uint8List frameBuffer, int length,
      EncodedAudioFrameInfo audioEncodedFrameInfo)? onRecordAudioEncodedFrame;

  /// 获取所有远端用户的音频编码数据。
  /// 调用 registerAudioEncodedFrameObserver 并将音频编码内容设为 audioEncodedFrameObserverPositionPlayback 后，你可以通过该回调获取所有远端用户的音频编码数据。
  ///
  /// * [samplesPerSec] 音频采样率（Hz）。
  /// * [channels] 声道数： 1：单声道。
  ///  2：双声道。双声道的音频数据是交叉存储的。
  /// * [samplesPerChannel] 每声道的采样点数。
  /// * [frameBuffer] 音频 buffer。
  /// * [length] 音频数据长度，单位为字节。
  /// * [audioEncodedFrameInfo] 编码后音频的信息。详见 EncodedAudioFrameInfo 。
  final void Function(Uint8List frameBuffer, int length,
      EncodedAudioFrameInfo audioEncodedFrameInfo)? onPlaybackAudioEncodedFrame;

  /// 获取本地和所有远端用户混音后的音频编码数据。
  /// 调用 registerAudioEncodedFrameObserver 并将音频编码内容设为 audioEncodedFrameObserverPositionMixed 后，你可以通过该回调获取本地和所有远端用户混音、编码后的音频数据。
  ///
  /// * [samplesPerSec] 音频采样率（Hz）。
  /// * [channels] 声道数：
  ///  1：单声道。2：双声道。双声道的音频数据是交叉存储的。
  /// * [samplesPerChannel] 每声道的采样点数。
  /// * [frameBuffer] 音频 buffer。
  /// * [length] 音频数据长度，单位为字节。
  /// * [audioEncodedFrameInfo] 编码后音频的信息。详见 EncodedAudioFrameInfo 。
  final void Function(Uint8List frameBuffer, int length,
      EncodedAudioFrameInfo audioEncodedFrameInfo)? onMixedAudioEncodedFrame;
}

/// 访问区域，即 SDK 连接的服务器所在的区域。
///
@JsonEnum(alwaysCreate: true)
enum AreaCode {
  /// 中国大陆。
  @JsonValue(0x00000001)
  areaCodeCn,

  /// 北美区域。
  @JsonValue(0x00000002)
  areaCodeNa,

  /// 欧洲区域。
  @JsonValue(0x00000004)
  areaCodeEu,

  /// 除中国以外的亚洲区域。
  @JsonValue(0x00000008)
  areaCodeAs,

  /// 日本。
  @JsonValue(0x00000010)
  areaCodeJp,

  /// 印度。
  @JsonValue(0x00000020)
  areaCodeIn,

  /// 全球。
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

/// 跨频道媒体流转发出错的错误码。
///
@JsonEnum(alwaysCreate: true)
enum ChannelMediaRelayError {
  /// 0: 一切正常。
  @JsonValue(0)
  relayOk,

  /// 1: 服务器回应出错。
  @JsonValue(1)
  relayErrorServerErrorResponse,

  /// 2: 服务器无回应。你可以调用 leaveChannel 方法离开频道。该错误也可能是由于当前的 App ID 未开启跨频道连麦导致的。你可以申请开通跨频道连麦。
  @JsonValue(2)
  relayErrorServerNoResponse,

  /// 3: SDK 无法获取服务，可能是因为服务器资源有限导致。
  @JsonValue(3)
  relayErrorNoResourceAvailable,

  /// 4: 发起跨频道转发媒体流请求失败。
  @JsonValue(4)
  relayErrorFailedJoinSrc,

  /// 5: 接受跨频道转发媒体流请求失败。
  @JsonValue(5)
  relayErrorFailedJoinDest,

  /// 6: 服务器接收跨频道转发媒体流失败。
  @JsonValue(6)
  relayErrorFailedPacketReceivedFromSrc,

  /// 7: 服务器发送跨频道转发媒体流失败。
  @JsonValue(7)
  relayErrorFailedPacketSentToDest,

  /// 8: SDK 因网络质量不佳与服务器断开。你可以调用 leaveChannel 方法离开当前频道。
  @JsonValue(8)
  relayErrorServerConnectionLost,

  /// 9: 服务器内部出错。
  @JsonValue(9)
  relayErrorInternalError,

  /// 10: 源频道的 Token 已过期。
  @JsonValue(10)
  relayErrorSrcTokenExpired,

  /// 11: 目标频道的 Token 已过期。
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

/// 跨频道媒体流转发事件码。
///
@JsonEnum(alwaysCreate: true)
enum ChannelMediaRelayEvent {
  /// 0: 网络中断导致用户与服务器连接断开。
  @JsonValue(0)
  relayEventNetworkDisconnected,

  /// 1: 用户与服务器建立连接。
  @JsonValue(1)
  relayEventNetworkConnected,

  /// 2: 用户已加入源频道。
  @JsonValue(2)
  relayEventPacketJoinedSrcChannel,

  /// 3: 用户已加入目标频道。
  @JsonValue(3)
  relayEventPacketJoinedDestChannel,

  /// 4: SDK 开始向目标频道发送数据包。
  @JsonValue(4)
  relayEventPacketSentToDestChannel,

  /// 5: 服务器收到了频道发送的视频流。
  @JsonValue(5)
  relayEventPacketReceivedVideoFromSrc,

  /// 6: 服务器收到了频道发送的音频流。
  @JsonValue(6)
  relayEventPacketReceivedAudioFromSrc,

  /// 7: 目标频道已更新。
  @JsonValue(7)
  relayEventPacketUpdateDestChannel,

  /// 8: 内部原因导致目标频道更新失败。
  @JsonValue(8)
  relayEventPacketUpdateDestChannelRefused,

  /// 9: 目标频道未发生改变，即目标频道更新失败。
  @JsonValue(9)
  relayEventPacketUpdateDestChannelNotChange,

  /// 10: 目标频道名为 NULL。
  @JsonValue(10)
  relayEventPacketUpdateDestChannelIsNull,

  /// 11: 视频属性已发送至服务器。
  @JsonValue(11)
  relayEventVideoProfileUpdate,

  /// 12: 暂停向目标频道转发媒体流成功。
  @JsonValue(12)
  relayEventPauseSendPacketToDestChannelSuccess,

  /// 13: 暂停向目标频道转发媒体流失败。
  @JsonValue(13)
  relayEventPauseSendPacketToDestChannelFailed,

  /// 14: 恢复向目标频道转发媒体流成功。
  @JsonValue(14)
  relayEventResumeSendPacketToDestChannelSuccess,

  /// 15: 恢复向目标频道转发媒体流失败。
  @JsonValue(15)
  relayEventResumeSendPacketToDestChannelFailed,
}

/// @nodoc
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

/// 跨频道媒体流转发状态码。
///
@JsonEnum(alwaysCreate: true)
enum ChannelMediaRelayState {
  /// 0: 初始状态。在成功调用 stopChannelMediaRelay 停止跨频道媒体流转发后， onChannelMediaRelayStateChanged 会回调该状态。
  @JsonValue(0)
  relayStateIdle,

  /// 1: SDK 尝试跨频道。
  @JsonValue(1)
  relayStateConnecting,

  /// 2: 源频道主播成功加入目标频道。
  @JsonValue(2)
  relayStateRunning,

  /// 3: 发生异常，详见 onChannelMediaRelayStateChanged 的 code 参数提示的错误信息。
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

/// ChannelMediaInfo 类定义。
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ChannelMediaInfo {
  /// @nodoc
  const ChannelMediaInfo({this.channelName, this.token, this.uid});

  /// 频道名。
  @JsonKey(name: 'channelName')
  final String? channelName;

  /// 能加入频道的 Token。
  @JsonKey(name: 'token')
  final String? token;

  /// 用户 ID。
  @JsonKey(name: 'uid')
  final int? uid;

  /// @nodoc
  factory ChannelMediaInfo.fromJson(Map<String, dynamic> json) =>
      _$ChannelMediaInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ChannelMediaInfoToJson(this);
}

/// ChannelMediaRelayConfiguration 类定义。
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ChannelMediaRelayConfiguration {
  /// @nodoc
  const ChannelMediaRelayConfiguration(
      {this.srcInfo, this.destInfos, this.destCount});

  /// 源频道信息 ChannelMediaInfo ，包含如下成员： channelName：源频道名。默认值为 NULL，表示 SDK 填充当前的频道名。
  ///  uid：标识源频道中的转发媒体流的 UID。默认值为 0，表示 SDK 随机分配一个 uid。请确保设为 0。token：能加入源频道的 token。由你在 srcInfo 中设置的 channelName 和 uid 生成。 如未启用 App Certificate，可直接将该参数设为默认值 NULL，表示 SDK 填充 App ID。如已启用 App Certificate，则务必填入使用 channelName 和 uid 生成的 token，且其中的 uid 必须为 0。
  @JsonKey(name: 'srcInfo')
  final ChannelMediaInfo? srcInfo;

  /// 目标频道信息 ChannelMediaInfo，包含如下成员： channelName ：目标频道的频道名。uid：标识目标频道中的转发媒体流的 UID。取值范围为 0 到（2 32-1），请确保与目标频道中的所有 UID 不同。默认值为 0，表示 SDK 随机分配一个 UID。请确保不要将该参数设为目标频道的主播的 UID，并与目标频道中的所有 UID 都不同。token：能加入目标频道的 token。由你在 destInfos 中设置的 channelName 和 uid 生成。 如未启用 App Certificate，可直接将该参数设为默认值 NULL，表示 SDK 填充 App ID。如已启用 App Certificate，则务必填入使用 channelName 和 uid 生成的 token。
  @JsonKey(name: 'destInfos')
  final List<ChannelMediaInfo>? destInfos;

  /// 目标频道数量，默认值为 0，取值范围为 [0,4]。该参数应与你在 destInfo 中定义的 ChannelMediaInfo 数组的数目一致。
  ///
  @JsonKey(name: 'destCount')
  final int? destCount;

  /// @nodoc
  factory ChannelMediaRelayConfiguration.fromJson(Map<String, dynamic> json) =>
      _$ChannelMediaRelayConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ChannelMediaRelayConfigurationToJson(this);
}

/// 上行网络信息。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class UplinkNetworkInfo {
  /// @nodoc
  const UplinkNetworkInfo({this.videoEncoderTargetBitrateBps});

  /// 目标视频编码器的码率 (bps)。
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

/// 内置加密模式。
/// Agora 推荐使用 aes128Gcm2 或 aes256Gcm2 加密模式。这两种模式支持使用盐，安全性更高。
@JsonEnum(alwaysCreate: true)
enum EncryptionMode {
  /// 1: 128 位 AES 加密，XTS 模式。
  @JsonValue(1)
  aes128Xts,

  /// 2: 128 位 AES 加密，ECB 模式。
  @JsonValue(2)
  aes128Ecb,

  /// 3: 256 位 AES 加密，XTS 模式。
  @JsonValue(3)
  aes256Xts,

  /// 4: 128 位 SM4 加密，ECB 模式。
  @JsonValue(4)
  sm4128Ecb,

  /// 5: 128 位 AES 加密，GCM 模式。
  @JsonValue(5)
  aes128Gcm,

  /// 6: 256 位 AES 加密，GCM 模式。
  @JsonValue(6)
  aes256Gcm,

  /// 7:（默认）128 位 AES 加密，GCM 模式。该加密模式需要设置盐（encryptionKdfSalt）。
  @JsonValue(7)
  aes128Gcm2,

  /// 8: 256 位 AES 加密，GCM 模式。该加密模式需要设置盐（encryptionKdfSalt）。
  @JsonValue(8)
  aes256Gcm2,

  /// 枚举值边界。
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

/// 配置内置加密模式和密钥。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class EncryptionConfig {
  /// @nodoc
  const EncryptionConfig(
      {this.encryptionMode, this.encryptionKey, this.encryptionKdfSalt});

  /// 内置加密模式。详见 EncryptionMode 。Agora 推荐使用 aes128Gcm2 或 aes256Gcm2 加密模式。这两种模式支持使用盐，安全性更高。
  @JsonKey(name: 'encryptionMode')
  final EncryptionMode? encryptionMode;

  /// 内置加密密钥，字符串类型，长度无限制。Agora 推荐使用 32 字节的密钥。如果未指定该参数或将该参数设置为 NULL，则无法启用内置加密，且 SDK 会返回错误码 -2。
  @JsonKey(name: 'encryptionKey')
  final String? encryptionKey;

  /// 盐，长度为 32 字节。Agora 推荐你在服务端使用 OpenSSL 生成盐。只有在 aes128Gcm2 或 aes256Gcm2 加密模式下，该参数才生效。此时，需确保填入该参数的值不全为 0。
  @JsonKey(name: 'encryptionKdfSalt', ignore: true)
  final Uint8List? encryptionKdfSalt;

  /// @nodoc
  factory EncryptionConfig.fromJson(Map<String, dynamic> json) =>
      _$EncryptionConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$EncryptionConfigToJson(this);
}

/// 内置加密的错误类型。
///
@JsonEnum(alwaysCreate: true)
enum EncryptionErrorType {
  /// 0: 内部原因。
  @JsonValue(0)
  encryptionErrorInternalFailure,

  /// 1: 解密错误。请确保接收端和发送端使用的加密模式或密钥一致。
  @JsonValue(1)
  encryptionErrorDecryptionFailure,

  /// 2: 加密错误。
  @JsonValue(2)
  encryptionErrorEncryptionFailure,
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

/// 设备权限类型。
///
@JsonEnum(alwaysCreate: true)
enum PermissionType {
  /// 0: 音频采集设备的权限。
  @JsonValue(0)
  recordAudio,

  /// 1: 摄像头权限。
  @JsonValue(1)
  camera,

  /// @nodoc
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

/// 用户 User Account 的最大长度。
///
@JsonEnum(alwaysCreate: true)
enum MaxUserAccountLengthType {
  /// 用户 User Account 的最大长度为 255 个字符。
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

/// 订阅状态。
///
@JsonEnum(alwaysCreate: true)
enum StreamSubscribeState {
  /// 0: 加入频道后的初始订阅状态。
  @JsonValue(0)
  subStateIdle,

  /// 1: 订阅失败。可能是因为：远端用户：调用 muteLocalAudioStream (true) 或 muteLocalVideoStream (true) 停止发送本地媒体流。调用 disableAudio 或 disableVideo 关闭本地音频或视频模块。调用 enableLocalAudio (false) 或 enableLocalVideo (false) 关闭本地音频或视频采集。用户角色为观众。本地用户调用以下方法停止接收远端媒体流：调用 muteRemoteAudioStream (true)、 muteAllRemoteAudioStreams (true) 停止接收远端音频流。调用 muteRemoteVideoStream (true)、 muteAllRemoteVideoStreams (true) 停止接收远端视频流。
  @JsonValue(1)
  subStateNoSubscribed,

  /// 2: 正在订阅。
  @JsonValue(2)
  subStateSubscribing,

  /// 3: 收到了远端流，订阅成功。
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

/// 发布状态。
///
@JsonEnum(alwaysCreate: true)
enum StreamPublishState {
  /// 0: 加入频道后的初始发布状态。
  @JsonValue(0)
  pubStateIdle,

  /// 1: 发布失败。可能是因为：
  ///  本地用户调用 muteLocalAudioStream (true) 或 muteLocalVideoStream (true) 停止发送本地媒体流。本地用户调用 disableAudio 或 disableVideo 关闭本地音频或视频模块。本地用户调用 enableLocalAudio (false) 或 enableLocalVideo (false) 关闭本地音频或视频采集。本地用户角色为观众。
  @JsonValue(1)
  pubStateNoPublished,

  /// 2: 正在发布。
  @JsonValue(2)
  pubStatePublishing,

  /// 3: 发布成功。
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

/// 音视频通话回路测试的配置。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class EchoTestConfiguration {
  /// @nodoc
  const EchoTestConfiguration(
      {this.view,
      this.enableAudio,
      this.enableVideo,
      this.token,
      this.channelId});

  /// 用于渲染本地用户视频的视图。该参数仅适用于测试视频设备的场景，即该结构体中 enableVideo 为 true。
  @JsonKey(name: 'view')
  final int? view;

  /// 是否开启音频设备：
  ///  true: (默认) 开启音频设备。如需测试音频设备，请设为 true。false: 关闭音频设备。
  @JsonKey(name: 'enableAudio')
  final bool? enableAudio;

  /// 是否开启视频设备： true: (默认) 开启视频设备。如需测试视频设备，请设为 true。false: 关闭视频设备。
  @JsonKey(name: 'enableVideo')
  final bool? enableVideo;

  /// 用于保证音视频通话回路测试安全性的 Token。如果你在 Agora 控制台未启用 App 证书，则不需要向该参数传值；如果你在 Agora 控制台已启用 App 证书，则必须向该参数传入 Token，且在你生成 Token 时使用的 uid 必须为 0xFFFFFFFF，使用的频道名必须为标识每个音视频通话回路测试的频道名。服务端生成 Token 的方式请参考使用 Token 鉴权。
  @JsonKey(name: 'token')
  final String? token;

  /// 标识每个音视频通话回路测试的频道名。为保证回路测试功能正常，同一个项目（App ID） 的各终端用户在不同设备上做音视频通话回路测试时，传入的标识每个回路测试的频道名不能相同。
  @JsonKey(name: 'channelId')
  final String? channelId;

  /// @nodoc
  factory EchoTestConfiguration.fromJson(Map<String, dynamic> json) =>
      _$EchoTestConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$EchoTestConfigurationToJson(this);
}

/// 用户的信息。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class UserInfo {
  /// @nodoc
  const UserInfo({this.uid, this.userAccount});

  /// 用户 ID。
  @JsonKey(name: 'uid')
  final int? uid;

  /// 用户 Account。长度限制为 MaxUserAccountLengthType 。
  @JsonKey(name: 'userAccount')
  final String? userAccount;

  /// @nodoc
  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

/// 耳返 audio filter。
///
@JsonEnum(alwaysCreate: true)
enum EarMonitoringFilterType {
  /// 1<<0: 不在耳返中添加 audio filter。
  @JsonValue((1 << 0))
  earMonitoringFilterNone,

  /// 1<<1: 在耳返中添加人声效果 audio filter。如果你实现了美声、音效等功能，用户可以在耳返中听到添加效果后的声音。
  @JsonValue((1 << 1))
  earMonitoringFilterBuiltInAudioFilters,

  /// 1<<2: 在耳返中添加降噪 audio filter。
  @JsonValue((1 << 2))
  earMonitoringFilterNoiseSuppression,
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

/// 共享屏幕流的视频编码配置。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ScreenVideoParameters {
  /// @nodoc
  const ScreenVideoParameters(
      {this.dimensions, this.frameRate, this.bitrate, this.contentHint});

  /// 视频编码的分辨率。默认值为 1280 × 720。
  @JsonKey(name: 'dimensions')
  final VideoDimensions? dimensions;

  /// 视频编码帧率 (fps)。默认值为 15。
  @JsonKey(name: 'frameRate')
  final int? frameRate;

  /// 视频编码码率 (Kbps)。
  @JsonKey(name: 'bitrate')
  final int? bitrate;

  /// 屏幕共享视频的内容类型。
  @JsonKey(name: 'contentHint')
  final VideoContentHint? contentHint;

  /// @nodoc
  factory ScreenVideoParameters.fromJson(Map<String, dynamic> json) =>
      _$ScreenVideoParametersFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ScreenVideoParametersToJson(this);
}

/// 共享屏幕流的音频配置。
/// 仅适用于 captureAudio 为 true 的场景。
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ScreenAudioParameters {
  /// @nodoc
  const ScreenAudioParameters(
      {this.sampleRate, this.channels, this.captureSignalVolume});

  /// 音频采样率 (Hz)。默认值为 16000。
  @JsonKey(name: 'sampleRate')
  final int? sampleRate;

  /// 声道数。默认值为 2，表示双声道。
  @JsonKey(name: 'channels')
  final int? channels;

  /// 采集的系统音量。取值范围为 [0,100]。默认值为 100。
  @JsonKey(name: 'captureSignalVolume')
  final int? captureSignalVolume;

  /// @nodoc
  factory ScreenAudioParameters.fromJson(Map<String, dynamic> json) =>
      _$ScreenAudioParametersFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ScreenAudioParametersToJson(this);
}

/// 屏幕共享的参数配置。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ScreenCaptureParameters2 {
  /// @nodoc
  const ScreenCaptureParameters2(
      {this.captureAudio,
      this.audioParams,
      this.captureVideo,
      this.videoParams});

  /// 屏幕共享时是否采集系统音频：
  ///  true: 采集系统音频。false: （默认）不采集系统音频。受系统限制，采集系统音频仅适用于 Android API 级别为 29 及以上，即 Android 10 及以上。
  @JsonKey(name: 'captureAudio')
  final bool? captureAudio;

  /// 共享屏幕流的音频配置。详见 ScreenAudioParameters 。
  ///  该参数仅在 captureAudio 为 true 时生效。
  @JsonKey(name: 'audioParams')
  final ScreenAudioParameters? audioParams;

  /// 屏幕共享时是否采集屏幕：
  ///  true:（默认）采集屏幕。false: 不采集屏幕。受系统限制，采集屏幕仅适用于 Android API 级别为 21 及以上，即 Android 5 及以上。
  @JsonKey(name: 'captureVideo')
  final bool? captureVideo;

  /// 共享屏幕流的视频编码配置。详见 ScreenVideoParameters 。
  ///  该参数仅在 captureVideo 为 true 时生效。
  @JsonKey(name: 'videoParams')
  final ScreenVideoParameters? videoParams;

  /// @nodoc
  factory ScreenCaptureParameters2.fromJson(Map<String, dynamic> json) =>
      _$ScreenCaptureParameters2FromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ScreenCaptureParameters2ToJson(this);
}

/// @nodoc
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
      this.speakerAttenuation});

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
  factory SpatialAudioParams.fromJson(Map<String, dynamic> json) =>
      _$SpatialAudioParamsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$SpatialAudioParamsToJson(this);
}
