import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_rtc_engine.g.dart';

/// 设备类型。
///
@JsonEnum(alwaysCreate: true)
enum MediaDeviceType {
  /// -1: 设备类型未知。
  @JsonValue(-1)
  unknownAudioDevice,

  /// 0: 音频播放设备。
  @JsonValue(0)
  audioPlayoutDevice,

  /// 1: 音频采集设备。
  @JsonValue(1)
  audioRecordingDevice,

  /// 2: 视频渲染设备。
  @JsonValue(2)
  videoRenderDevice,

  /// 3: 视频采集设备。
  @JsonValue(3)
  videoCaptureDevice,

  /// 4: 音频应用播放设备。
  @JsonValue(4)
  audioApplicationPlayoutDevice,
}

/// @nodoc
extension MediaDeviceTypeExt on MediaDeviceType {
  /// @nodoc
  static MediaDeviceType fromValue(int value) {
    return $enumDecode(_$MediaDeviceTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$MediaDeviceTypeEnumMap[this]!;
  }
}

/// 音乐文件播放状态。
///
@JsonEnum(alwaysCreate: true)
enum AudioMixingStateType {
  /// 710: 音乐文件正常播放。
  @JsonValue(710)
  audioMixingStatePlaying,

  /// 711: 音乐文件暂停播放。
  @JsonValue(711)
  audioMixingStatePaused,

  /// 713: 音乐文件停止播放。该状态可能由以下原因导致： audioMixingReasonAllLoopsCompleted(723)audioMixingReasonStoppedByUser(724)
  @JsonValue(713)
  audioMixingStateStopped,

  /// 714: 音乐文件播放出错。该状态可能由以下原因导致： audioMixingReasonCanNotOpen(701)audioMixingReasonTooFrequentCall(702)audioMixingReasonInterruptedEof(703)
  @JsonValue(714)
  audioMixingStateFailed,
}

/// @nodoc
extension AudioMixingStateTypeExt on AudioMixingStateType {
  /// @nodoc
  static AudioMixingStateType fromValue(int value) {
    return $enumDecode(_$AudioMixingStateTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$AudioMixingStateTypeEnumMap[this]!;
  }
}

/// 音乐文件播放状态改变的原因。在 onAudioMixingStateChanged 回调中报告。
///
@JsonEnum(alwaysCreate: true)
enum AudioMixingReasonType {
  /// 701: 音乐文件打开出错。例如，本地音乐文件不存在、文件格式不支持或无法访问在线音乐文件 URL。
  @JsonValue(701)
  audioMixingReasonCanNotOpen,

  /// 702: 音乐文件打开太频繁。如需多次调用 startAudioMixing，请确保调用间隔大于 500 ms。
  @JsonValue(702)
  audioMixingReasonTooFrequentCall,

  /// 703: 音乐文件播放中断。
  @JsonValue(703)
  audioMixingReasonInterruptedEof,

  /// 721: 音乐文件完成一次循环播放。
  @JsonValue(721)
  audioMixingReasonOneLoopCompleted,

  /// 723: 音乐文件完成所有循环播放。
  @JsonValue(723)
  audioMixingReasonAllLoopsCompleted,

  /// 724: 成功调用 stopAudioMixing 停止播放音乐文件。
  @JsonValue(724)
  audioMixingReasonStoppedByUser,

  /// 0: 成功打开音乐文件。
  @JsonValue(0)
  audioMixingReasonOk,
}

/// @nodoc
extension AudioMixingReasonTypeExt on AudioMixingReasonType {
  /// @nodoc
  static AudioMixingReasonType fromValue(int value) {
    return $enumDecode(_$AudioMixingReasonTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$AudioMixingReasonTypeEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum InjectStreamStatus {
  /// @nodoc
  @JsonValue(0)
  injectStreamStatusStartSuccess,

  /// @nodoc
  @JsonValue(1)
  injectStreamStatusStartAlreadyExists,

  /// @nodoc
  @JsonValue(2)
  injectStreamStatusStartUnauthorized,

  /// @nodoc
  @JsonValue(3)
  injectStreamStatusStartTimedout,

  /// @nodoc
  @JsonValue(4)
  injectStreamStatusStartFailed,

  /// @nodoc
  @JsonValue(5)
  injectStreamStatusStopSuccess,

  /// @nodoc
  @JsonValue(6)
  injectStreamStatusStopNotFound,

  /// @nodoc
  @JsonValue(7)
  injectStreamStatusStopUnauthorized,

  /// @nodoc
  @JsonValue(8)
  injectStreamStatusStopTimedout,

  /// @nodoc
  @JsonValue(9)
  injectStreamStatusStopFailed,

  /// @nodoc
  @JsonValue(10)
  injectStreamStatusBroken,
}

/// @nodoc
extension InjectStreamStatusExt on InjectStreamStatus {
  /// @nodoc
  static InjectStreamStatus fromValue(int value) {
    return $enumDecode(_$InjectStreamStatusEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$InjectStreamStatusEnumMap[this]!;
  }
}

/// 语音音效均衡波段的中心频率。
///
@JsonEnum(alwaysCreate: true)
enum AudioEqualizationBandFrequency {
  /// 0: 31 Hz
  @JsonValue(0)
  audioEqualizationBand31,

  /// 1: 62 Hz
  @JsonValue(1)
  audioEqualizationBand62,

  /// 2: 125 Hz
  @JsonValue(2)
  audioEqualizationBand125,

  /// 3: 250 Hz
  @JsonValue(3)
  audioEqualizationBand250,

  /// 4: 500 Hz
  @JsonValue(4)
  audioEqualizationBand500,

  /// 5: 1 kHz
  @JsonValue(5)
  audioEqualizationBand1k,

  /// 6: 2 kHz
  @JsonValue(6)
  audioEqualizationBand2k,

  /// 7: 4 kHz
  @JsonValue(7)
  audioEqualizationBand4k,

  /// 8: 8 kHz
  @JsonValue(8)
  audioEqualizationBand8k,

  /// 9: 16 kHz
  @JsonValue(9)
  audioEqualizationBand16k,
}

/// @nodoc
extension AudioEqualizationBandFrequencyExt on AudioEqualizationBandFrequency {
  /// @nodoc
  static AudioEqualizationBandFrequency fromValue(int value) {
    return $enumDecode(_$AudioEqualizationBandFrequencyEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$AudioEqualizationBandFrequencyEnumMap[this]!;
  }
}

/// 音频混响类型。
///
@JsonEnum(alwaysCreate: true)
enum AudioReverbType {
  /// 0: 原始声音强度，即所谓的 dry signal，取值范围 [-20,10]，单位为 dB。
  @JsonValue(0)
  audioReverbDryLevel,

  /// 1: 早期反射信号强度，即所谓的 wet signal，取值范围 [-20,10]，单位为 dB。
  @JsonValue(1)
  audioReverbWetLevel,

  /// 2: 所需混响效果的房间尺寸，一般房间越大，混响越强，取值范围 [0,100]，单位为 dB。
  @JsonValue(2)
  audioReverbRoomSize,

  /// 3: Wet signal 的初始延迟长度，取值范围 [0,200]，单位为毫秒。
  @JsonValue(3)
  audioReverbWetDelay,

  /// 4: 混响持续的强度，取值范围为 [0,100]。
  @JsonValue(4)
  audioReverbStrength,
}

/// @nodoc
extension AudioReverbTypeExt on AudioReverbType {
  /// @nodoc
  static AudioReverbType fromValue(int value) {
    return $enumDecode(_$AudioReverbTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$AudioReverbTypeEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum StreamFallbackOptions {
  /// @nodoc
  @JsonValue(0)
  streamFallbackOptionDisabled,

  /// @nodoc
  @JsonValue(1)
  streamFallbackOptionVideoStreamLow,

  /// @nodoc
  @JsonValue(2)
  streamFallbackOptionAudioOnly,
}

/// @nodoc
extension StreamFallbackOptionsExt on StreamFallbackOptions {
  /// @nodoc
  static StreamFallbackOptions fromValue(int value) {
    return $enumDecode(_$StreamFallbackOptionsEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$StreamFallbackOptionsEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum PriorityType {
  /// @nodoc
  @JsonValue(50)
  priorityHigh,

  /// @nodoc
  @JsonValue(100)
  priorityNormal,
}

/// @nodoc
extension PriorityTypeExt on PriorityType {
  /// @nodoc
  static PriorityType fromValue(int value) {
    return $enumDecode(_$PriorityTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$PriorityTypeEnumMap[this]!;
  }
}

/// 本地视频流统计信息。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LocalVideoStats {
  /// @nodoc
  const LocalVideoStats(
      {this.uid,
      this.sentBitrate,
      this.sentFrameRate,
      this.captureFrameRate,
      this.captureFrameWidth,
      this.captureFrameHeight,
      this.regulatedCaptureFrameRate,
      this.regulatedCaptureFrameWidth,
      this.regulatedCaptureFrameHeight,
      this.encoderOutputFrameRate,
      this.encodedFrameWidth,
      this.encodedFrameHeight,
      this.rendererOutputFrameRate,
      this.targetBitrate,
      this.targetFrameRate,
      this.qualityAdaptIndication,
      this.encodedBitrate,
      this.encodedFrameCount,
      this.codecType,
      this.txPacketLossRate,
      this.captureBrightnessLevel,
      this.dualStreamEnabled});

  /// 本地用户的 ID。
  @JsonKey(name: 'uid')
  final int? uid;

  /// 实际发送码率 (Kbps) 不包含丢包后重传视频等的发送码率。
  @JsonKey(name: 'sentBitrate')
  final int? sentBitrate;

  /// 实际发送帧率 (fps)。 不包含丢包后重传视频等的发送帧率。
  @JsonKey(name: 'sentFrameRate')
  final int? sentFrameRate;

  /// 本地视频采集帧率 (fps)。
  @JsonKey(name: 'captureFrameRate')
  final int? captureFrameRate;

  /// 本地视频采集宽度 (px)。
  @JsonKey(name: 'captureFrameWidth')
  final int? captureFrameWidth;

  /// 本地视频采集高度 (px)。
  @JsonKey(name: 'captureFrameHeight')
  final int? captureFrameHeight;

  /// SDK 内置的视频采集适配器（regulator）调整后的摄像头采集视频帧率 (fps)。Regulator 根据视频编码配置对摄像头采集视频的帧率进行调整。
  @JsonKey(name: 'regulatedCaptureFrameRate')
  final int? regulatedCaptureFrameRate;

  /// SDK 内置的视频采集适配器（regulator）调整后的摄像头采集视频宽度 (px)。Regulator 根据视频编码配置对摄像头采集视频的宽高进行调整。
  @JsonKey(name: 'regulatedCaptureFrameWidth')
  final int? regulatedCaptureFrameWidth;

  /// SDK 内置的视频采集适配器（regulator）调整后的摄像头采集视频高度 (px)。Regulator 根据视频编码配置对摄像头采集视频的宽高进行调整。
  @JsonKey(name: 'regulatedCaptureFrameHeight')
  final int? regulatedCaptureFrameHeight;

  /// 本地视频编码器的输出帧率，单位为 fps。
  @JsonKey(name: 'encoderOutputFrameRate')
  final int? encoderOutputFrameRate;

  /// 视频编码宽度（px）。
  @JsonKey(name: 'encodedFrameWidth')
  final int? encodedFrameWidth;

  /// 视频编码高度（px）。
  @JsonKey(name: 'encodedFrameHeight')
  final int? encodedFrameHeight;

  /// 本地视频渲染器的输出帧率，单位为 fps。
  @JsonKey(name: 'rendererOutputFrameRate')
  final int? rendererOutputFrameRate;

  /// 当前编码器的目标编码码率 (Kbps)，该码率为 SDK 根据当前网络状况预估的一个值。
  @JsonKey(name: 'targetBitrate')
  final int? targetBitrate;

  /// 当前编码器的目标编码帧率 (fps)。
  @JsonKey(name: 'targetFrameRate')
  final int? targetFrameRate;

  /// 统计周期内本地视频质量（基于目标帧率和目标码率）的自适应情况。详见 QualityAdaptIndication 。
  @JsonKey(name: 'qualityAdaptIndication')
  final QualityAdaptIndication? qualityAdaptIndication;

  /// 视频编码码率（Kbps）。 不包含丢包后重传视频等的编码码率。
  @JsonKey(name: 'encodedBitrate')
  final int? encodedBitrate;

  /// 视频发送的帧数，累计值。
  @JsonKey(name: 'encodedFrameCount')
  final int? encodedFrameCount;

  /// 视频的编码类型。详见 VideoCodecType 。
  @JsonKey(name: 'codecType')
  final VideoCodecType? codecType;

  /// 弱网对抗前本端到 Agora 边缘服务器的视频丢包率 (%)。
  @JsonKey(name: 'txPacketLossRate')
  final int? txPacketLossRate;

  /// @nodoc
  @JsonKey(name: 'captureBrightnessLevel')
  final CaptureBrightnessLevelType? captureBrightnessLevel;

  /// @nodoc
  @JsonKey(name: 'dualStreamEnabled')
  final bool? dualStreamEnabled;

  /// @nodoc
  factory LocalVideoStats.fromJson(Map<String, dynamic> json) =>
      _$LocalVideoStatsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LocalVideoStatsToJson(this);
}

/// 远端视频流的统计信息。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RemoteVideoStats {
  /// @nodoc
  const RemoteVideoStats(
      {this.uid,
      this.delay,
      this.width,
      this.height,
      this.receivedBitrate,
      this.decoderOutputFrameRate,
      this.rendererOutputFrameRate,
      this.frameLossRate,
      this.packetLossRate,
      this.rxStreamType,
      this.totalFrozenTime,
      this.frozenRate,
      this.avSyncTimeMs,
      this.totalActiveTime,
      this.publishDuration,
      this.superResolutionType});

  /// 用户 ID，指定是哪个用户的视频流。
  @JsonKey(name: 'uid')
  final int? uid;

  /// 弃用：在有音画同步机制的音视频场景中，你可以参考 RemoteAudioStats 里的 networkTransportDelay 和 jitterBufferDelay 成员的值，了解视频的延迟数据。延时（毫秒）。
  @JsonKey(name: 'delay')
  final int? delay;

  /// 视频流宽（像素）。
  @JsonKey(name: 'width')
  final int? width;

  /// 视频流高（像素）。
  @JsonKey(name: 'height')
  final int? height;

  /// （上次统计后）接收到的码率(Kbps)。
  @JsonKey(name: 'receivedBitrate')
  final int? receivedBitrate;

  /// 远端视频解码器的输出帧率，单位为 fps。
  @JsonKey(name: 'decoderOutputFrameRate')
  final int? decoderOutputFrameRate;

  /// 远端视频渲染器的输出帧率，单位为 fps。
  @JsonKey(name: 'rendererOutputFrameRate')
  final int? rendererOutputFrameRate;

  /// 远端视频丢包率(%)。
  @JsonKey(name: 'frameLossRate')
  final int? frameLossRate;

  /// 远端视频在使用抗丢包技术之后的丢包率(%)。
  @JsonKey(name: 'packetLossRate')
  final int? packetLossRate;

  /// 视频流类型，大流或小流。详见 VideoStreamType 。
  @JsonKey(name: 'rxStreamType')
  final VideoStreamType? rxStreamType;

  /// 远端用户在加入频道后发生视频卡顿的累计时长（ms）。通话过程中，视频帧率设置不低于 5 fps 时，连续渲染的两帧视频之间间隔超过 500 ms，则记为一次视频卡顿。
  @JsonKey(name: 'totalFrozenTime')
  final int? totalFrozenTime;

  /// 远端用户在加入频道后发生视频卡顿的累计时长占视频总有效时长的百分比 (%)。视频有效时长是指远端用户加入频道后视频未被停止发送或禁用的时长。
  @JsonKey(name: 'frozenRate')
  final int? frozenRate;

  /// 音频超前视频的时间 (ms)。 如果为负值，则代表音频落后于视频。
  @JsonKey(name: 'avSyncTimeMs')
  final int? avSyncTimeMs;

  /// 视频有效时长（毫秒）。视频总有效时长是远端用户或主播加入频道后，既没有停止发送视频流，也没有禁用视频模块的通话时长。
  @JsonKey(name: 'totalActiveTime')
  final int? totalActiveTime;

  /// 远端视频流的累计发布时长（毫秒）。
  @JsonKey(name: 'publishDuration')
  final int? publishDuration;

  /// 超分辨率的开启状态： >0：超分辨率已开启。=0：超分辨率未开启。
  @JsonKey(name: 'superResolutionType')
  final int? superResolutionType;

  /// @nodoc
  factory RemoteVideoStats.fromJson(Map<String, dynamic> json) =>
      _$RemoteVideoStatsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RemoteVideoStatsToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoCompositingLayout {
  /// @nodoc
  const VideoCompositingLayout(
      {this.canvasWidth,
      this.canvasHeight,
      this.backgroundColor,
      this.regions,
      this.regionCount,
      this.appData,
      this.appDataLength});

  /// @nodoc
  @JsonKey(name: 'canvasWidth')
  final int? canvasWidth;

  /// @nodoc
  @JsonKey(name: 'canvasHeight')
  final int? canvasHeight;

  /// @nodoc
  @JsonKey(name: 'backgroundColor')
  final String? backgroundColor;

  /// @nodoc
  @JsonKey(name: 'regions')
  final List<Region>? regions;

  /// @nodoc
  @JsonKey(name: 'regionCount')
  final int? regionCount;

  /// @nodoc
  @JsonKey(name: 'appData', ignore: true)
  final Uint8List? appData;

  /// @nodoc
  @JsonKey(name: 'appDataLength')
  final int? appDataLength;

  /// @nodoc
  factory VideoCompositingLayout.fromJson(Map<String, dynamic> json) =>
      _$VideoCompositingLayoutFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$VideoCompositingLayoutToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Region {
  /// @nodoc
  const Region(
      {this.uid,
      this.x,
      this.y,
      this.width,
      this.height,
      this.zOrder,
      this.alpha,
      this.renderMode});

  /// @nodoc
  @JsonKey(name: 'uid')
  final int? uid;

  /// @nodoc
  @JsonKey(name: 'x')
  final double? x;

  /// @nodoc
  @JsonKey(name: 'y')
  final double? y;

  /// @nodoc
  @JsonKey(name: 'width')
  final double? width;

  /// @nodoc
  @JsonKey(name: 'height')
  final double? height;

  /// @nodoc
  @JsonKey(name: 'zOrder')
  final int? zOrder;

  /// @nodoc
  @JsonKey(name: 'alpha')
  final double? alpha;

  /// @nodoc
  @JsonKey(name: 'renderMode')
  final RenderModeType? renderMode;

  /// @nodoc
  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RegionToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class InjectStreamConfig {
  /// @nodoc
  const InjectStreamConfig(
      {this.width,
      this.height,
      this.videoGop,
      this.videoFramerate,
      this.videoBitrate,
      this.audioSampleRate,
      this.audioBitrate,
      this.audioChannels});

  /// @nodoc
  @JsonKey(name: 'width')
  final int? width;

  /// @nodoc
  @JsonKey(name: 'height')
  final int? height;

  /// @nodoc
  @JsonKey(name: 'videoGop')
  final int? videoGop;

  /// @nodoc
  @JsonKey(name: 'videoFramerate')
  final int? videoFramerate;

  /// @nodoc
  @JsonKey(name: 'videoBitrate')
  final int? videoBitrate;

  /// @nodoc
  @JsonKey(name: 'audioSampleRate')
  final AudioSampleRateType? audioSampleRate;

  /// @nodoc
  @JsonKey(name: 'audioBitrate')
  final int? audioBitrate;

  /// @nodoc
  @JsonKey(name: 'audioChannels')
  final int? audioChannels;

  /// @nodoc
  factory InjectStreamConfig.fromJson(Map<String, dynamic> json) =>
      _$InjectStreamConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$InjectStreamConfigToJson(this);
}

/// 服务端转码推流的生命周期。
/// 弃用
@JsonEnum(alwaysCreate: true)
enum RtmpStreamLifeCycleType {
  /// 跟频道生命周期绑定，即频道内所有主播离开，服务端转码推流会在 30 秒之后停止。
  @JsonValue(1)
  rtmpStreamLifeCycleBind2channel,

  /// 跟启动服务端转码推流的主播生命周期绑定，即该主播离开，服务端转码推流会立即停止。
  @JsonValue(2)
  rtmpStreamLifeCycleBind2owner,
}

/// @nodoc
extension RtmpStreamLifeCycleTypeExt on RtmpStreamLifeCycleType {
  /// @nodoc
  static RtmpStreamLifeCycleType fromValue(int value) {
    return $enumDecode(_$RtmpStreamLifeCycleTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$RtmpStreamLifeCycleTypeEnumMap[this]!;
  }
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class PublisherConfiguration {
  /// @nodoc
  const PublisherConfiguration(
      {this.width,
      this.height,
      this.framerate,
      this.bitrate,
      this.defaultLayout,
      this.lifecycle,
      this.owner,
      this.injectStreamWidth,
      this.injectStreamHeight,
      this.injectStreamUrl,
      this.publishUrl,
      this.rawStreamUrl,
      this.extraInfo});

  /// @nodoc
  @JsonKey(name: 'width')
  final int? width;

  /// @nodoc
  @JsonKey(name: 'height')
  final int? height;

  /// @nodoc
  @JsonKey(name: 'framerate')
  final int? framerate;

  /// @nodoc
  @JsonKey(name: 'bitrate')
  final int? bitrate;

  /// @nodoc
  @JsonKey(name: 'defaultLayout')
  final int? defaultLayout;

  /// @nodoc
  @JsonKey(name: 'lifecycle')
  final int? lifecycle;

  /// @nodoc
  @JsonKey(name: 'owner')
  final bool? owner;

  /// @nodoc
  @JsonKey(name: 'injectStreamWidth')
  final int? injectStreamWidth;

  /// @nodoc
  @JsonKey(name: 'injectStreamHeight')
  final int? injectStreamHeight;

  /// @nodoc
  @JsonKey(name: 'injectStreamUrl')
  final String? injectStreamUrl;

  /// @nodoc
  @JsonKey(name: 'publishUrl')
  final String? publishUrl;

  /// @nodoc
  @JsonKey(name: 'rawStreamUrl')
  final String? rawStreamUrl;

  /// @nodoc
  @JsonKey(name: 'extraInfo')
  final String? extraInfo;

  /// @nodoc
  factory PublisherConfiguration.fromJson(Map<String, dynamic> json) =>
      _$PublisherConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$PublisherConfigurationToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioTrackConfig {
  /// @nodoc
  const AudioTrackConfig({this.enableLocalPlayback});

  /// @nodoc
  @JsonKey(name: 'enableLocalPlayback')
  final bool? enableLocalPlayback;

  /// @nodoc
  factory AudioTrackConfig.fromJson(Map<String, dynamic> json) =>
      _$AudioTrackConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AudioTrackConfigToJson(this);
}

/// 摄像头方向。
///
@JsonEnum(alwaysCreate: true)
enum CameraDirection {
  /// 后置摄像头。
  @JsonValue(0)
  cameraRear,

  /// 前置摄像头。
  @JsonValue(1)
  cameraFront,
}

/// @nodoc
extension CameraDirectionExt on CameraDirection {
  /// @nodoc
  static CameraDirection fromValue(int value) {
    return $enumDecode(_$CameraDirectionEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$CameraDirectionEnumMap[this]!;
  }
}

/// 云代理类型。
///
@JsonEnum(alwaysCreate: true)
enum CloudProxyType {
  /// 0：自动模式。SDK 默认开启该模式。在该模式下，SDK 优先连接 SD-RTN™，如果连接失败，自动切换到 TLS 443。
  @JsonValue(0)
  noneProxy,

  /// 1：UDP 协议的云代理，即 Force UDP 云代理模式。在该模式下，SDK 始终通过 UDP 协议传输数据。
  @JsonValue(1)
  udpProxy,

  /// 2：TCP（加密）协议的云代理，即 Force TCP 云代理模式。在该模式下，SDK 始终通过 TLS 443 传输数据。
  @JsonValue(2)
  tcpProxy,
}

/// @nodoc
extension CloudProxyTypeExt on CloudProxyType {
  /// @nodoc
  static CloudProxyType fromValue(int value) {
    return $enumDecode(_$CloudProxyTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$CloudProxyTypeEnumMap[this]!;
  }
}

/// 摄像头采集配置。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CameraCapturerConfiguration {
  /// @nodoc
  const CameraCapturerConfiguration(
      {this.cameraDirection,
      this.deviceId,
      this.format,
      this.followEncodeDimensionRatio});

  /// 该参数仅适用于 Android 和 iOS 平台。摄像头方向设置。详见 CameraDirection 。
  @JsonKey(name: 'cameraDirection')
  final CameraDirection? cameraDirection;

  /// 最大长度为 MaxDeviceIdLengthType 。
  @JsonKey(name: 'deviceId')
  final String? deviceId;

  /// 详见 VideoFormat 。
  @JsonKey(name: 'format')
  final VideoFormat? format;

  /// @nodoc
  @JsonKey(name: 'followEncodeDimensionRatio')
  final bool? followEncodeDimensionRatio;

  /// @nodoc
  factory CameraCapturerConfiguration.fromJson(Map<String, dynamic> json) =>
      _$CameraCapturerConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$CameraCapturerConfigurationToJson(this);
}

/// 屏幕采集配置。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ScreenCaptureConfiguration {
  /// @nodoc
  const ScreenCaptureConfiguration(
      {this.isCaptureWindow,
      this.displayId,
      this.screenRect,
      this.windowId,
      this.params,
      this.regionRect});

  /// 是否采集屏幕上的窗口： true：采集窗口。false：（默认）采集屏幕，不采集窗口。
  @JsonKey(name: 'isCaptureWindow')
  final bool? isCaptureWindow;

  /// （仅适用于 macOS 平台）屏幕的 display ID。 请仅在 Mac 设备上采集屏幕时使用该参数。
  @JsonKey(name: 'displayId')
  final int? displayId;

  /// （仅适用于 Windows 平台）待共享的屏幕相对于虚拟屏的位置。 请仅在 Windows 设备上采集屏幕时使用该参数。
  @JsonKey(name: 'screenRect')
  final Rectangle? screenRect;

  /// （仅适用于 Windows 和 macOS 平台）窗口 ID。 请仅在采集窗口时使用该参数。
  @JsonKey(name: 'windowId')
  final int? windowId;

  /// （仅适用于 Windows 和 macOS 平台）屏幕共享流的编码参数配置。详见 ScreenCaptureParameters 。
  @JsonKey(name: 'params')
  final ScreenCaptureParameters? params;

  /// （仅适用于 Windows 和 macOS 平台）待共享区域相对于整个屏幕的位置。详见 Rectangle 。如不填，则表示共享整个屏幕。如果设置的共享区域超出了屏幕的边界，则只共享屏幕内的内容。 如果将 Rectangle 中的 width 或 height 设为 0 ，则共享整个屏幕。
  @JsonKey(name: 'regionRect')
  final Rectangle? regionRect;

  /// @nodoc
  factory ScreenCaptureConfiguration.fromJson(Map<String, dynamic> json) =>
      _$ScreenCaptureConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ScreenCaptureConfigurationToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SIZE {
  /// @nodoc
  const SIZE({this.width, this.height});

  /// @nodoc
  @JsonKey(name: 'width')
  final int? width;

  /// @nodoc
  @JsonKey(name: 'height')
  final int? height;

  /// @nodoc
  factory SIZE.fromJson(Map<String, dynamic> json) => _$SIZEFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$SIZEToJson(this);
}

/// 缩略图或图标的图像内容。在 ScreenCaptureSourceInfo 中设置。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ThumbImageBuffer {
  /// @nodoc
  const ThumbImageBuffer({this.buffer, this.length, this.width, this.height});

  /// 缩略图或图标的 buffer。
  @JsonKey(name: 'buffer', ignore: true)
  final Uint8List? buffer;

  /// 缩略图或图标的 buffer 长度，单位为字节。
  @JsonKey(name: 'length')
  final int? length;

  /// 缩略图或图标的实际宽度（px）。
  @JsonKey(name: 'width')
  final int? width;

  /// 缩略图或图标的实际高度（px）。
  @JsonKey(name: 'height')
  final int? height;

  /// @nodoc
  factory ThumbImageBuffer.fromJson(Map<String, dynamic> json) =>
      _$ThumbImageBufferFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ThumbImageBufferToJson(this);
}

/// 共享目标的类型。在 ScreenCaptureSourceInfo 中设置。
///
@JsonEnum(alwaysCreate: true)
enum ScreenCaptureSourceType {
  /// -1：未知。
  @JsonValue(-1)
  screencapturesourcetypeUnknown,

  /// 0：共享目标为某一个窗口。
  @JsonValue(0)
  screencapturesourcetypeWindow,

  /// 1：共享目标为某一个显示器的屏幕。
  @JsonValue(1)
  screencapturesourcetypeScreen,

  /// 2：预留参数。
  @JsonValue(2)
  screencapturesourcetypeCustom,
}

/// @nodoc
extension ScreenCaptureSourceTypeExt on ScreenCaptureSourceType {
  /// @nodoc
  static ScreenCaptureSourceType fromValue(int value) {
    return $enumDecode(_$ScreenCaptureSourceTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$ScreenCaptureSourceTypeEnumMap[this]!;
  }
}

/// 可共享窗口或屏幕的信息。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ScreenCaptureSourceInfo {
  /// @nodoc
  const ScreenCaptureSourceInfo(
      {this.type,
      this.sourceId,
      this.sourceName,
      this.thumbImage,
      this.iconImage,
      this.processPath,
      this.sourceTitle,
      this.primaryMonitor,
      this.isOccluded});

  /// 共享目标的类型。详见 ScreenCaptureSourceType 。
  @JsonKey(name: 'type')
  final ScreenCaptureSourceType? type;

  /// 对于窗口，表示窗口 ID（Window ID)；对于屏幕，表示屏幕 ID（Display ID）。
  @JsonKey(name: 'sourceId')
  final int? sourceId;

  /// 窗口或屏幕的名称。UTF-8 编码。
  @JsonKey(name: 'sourceName')
  final String? sourceName;

  /// 缩略图的图像内容。详见
  @JsonKey(name: 'thumbImage')
  final ThumbImageBuffer? thumbImage;

  /// 图标的图像内容。详见
  @JsonKey(name: 'iconImage')
  final ThumbImageBuffer? iconImage;

  /// 窗口所属的进程。UTF-8 编码。
  @JsonKey(name: 'processPath')
  final String? processPath;

  /// 窗口标题。UTF-8 编码。
  @JsonKey(name: 'sourceTitle')
  final String? sourceTitle;

  /// 屏幕是否为主显示屏： true: 是。false: 否。
  @JsonKey(name: 'primaryMonitor')
  final bool? primaryMonitor;

  /// @nodoc
  @JsonKey(name: 'isOccluded')
  final bool? isOccluded;

  /// @nodoc
  factory ScreenCaptureSourceInfo.fromJson(Map<String, dynamic> json) =>
      _$ScreenCaptureSourceInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ScreenCaptureSourceInfoToJson(this);
}

/// 音频的高级选项。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AdvancedAudioOptions {
  /// @nodoc
  const AdvancedAudioOptions({this.audioProcessingChannels});

  /// 音频前处理的声道数。详见 audioprocessingchannels 。
  @JsonKey(name: 'audioProcessingChannels')
  final int? audioProcessingChannels;

  /// @nodoc
  factory AdvancedAudioOptions.fromJson(Map<String, dynamic> json) =>
      _$AdvancedAudioOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AdvancedAudioOptionsToJson(this);
}

/// 垫片图片的设置选项。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ImageTrackOptions {
  /// @nodoc
  const ImageTrackOptions({this.imageUrl, this.fps, this.mirrorMode});

  /// 垫片图片的 URL，目前仅支持本地 PNG 格式的图片。支持从本地绝对路径或相对路径添加垫片图片。
  @JsonKey(name: 'imageUrl')
  final String? imageUrl;

  /// 视频帧率，取值范围为 [1,30]。默认值为 1。
  @JsonKey(name: 'fps')
  final int? fps;

  /// @nodoc
  @JsonKey(name: 'mirrorMode')
  final VideoMirrorModeType? mirrorMode;

  /// @nodoc
  factory ImageTrackOptions.fromJson(Map<String, dynamic> json) =>
      _$ImageTrackOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ImageTrackOptionsToJson(this);
}

/// 频道媒体设置选项。
/// Agora 支持在同一时间、同一 RtcConnection 中发布多路音频流、一路视频流。例如，publishCustomAudioTrack 和 publishMediaPlayerAudioTrack 可以同时为 true；
///  publishCameraTrack、publishCustomVideoTrack 或 publishEncodedVideoTrack 之中同一时间只能有一个为 true。
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ChannelMediaOptions {
  /// @nodoc
  const ChannelMediaOptions(
      {this.publishCameraTrack,
      this.publishSecondaryCameraTrack,
      this.publishMicrophoneTrack,
      this.publishScreenCaptureVideo,
      this.publishScreenCaptureAudio,
      this.publishScreenTrack,
      this.publishSecondaryScreenTrack,
      this.publishCustomAudioTrack,
      this.publishCustomAudioSourceId,
      this.publishCustomAudioTrackEnableAec,
      this.publishDirectCustomAudioTrack,
      this.publishCustomAudioTrackAec,
      this.publishCustomVideoTrack,
      this.publishEncodedVideoTrack,
      this.publishMediaPlayerAudioTrack,
      this.publishMediaPlayerVideoTrack,
      this.publishTrancodedVideoTrack,
      this.autoSubscribeAudio,
      this.autoSubscribeVideo,
      this.enableAudioRecordingOrPlayout,
      this.publishMediaPlayerId,
      this.clientRoleType,
      this.audienceLatencyLevel,
      this.defaultVideoStreamType,
      this.channelProfile,
      this.audioDelayMs,
      this.mediaPlayerAudioDelayMs,
      this.token,
      this.enableBuiltInMediaEncryption,
      this.publishRhythmPlayerTrack,
      this.isInteractiveAudience,
      this.customVideoTrackId,
      this.isAudioFilterable});

  /// 设置是否发布摄像头采集的视频：
  ///  true：（默认）发布摄像头采集的视频。false：不发布摄像头采集的视频。
  @JsonKey(name: 'publishCameraTrack')
  final bool? publishCameraTrack;

  /// 设置是否发布第二个摄像头采集的视频：
  ///  true：发布第二个摄像头采集的视频。false：（默认）不发布第二个摄像头采集的视频。
  @JsonKey(name: 'publishSecondaryCameraTrack')
  final bool? publishSecondaryCameraTrack;

  /// 设置是否发布采集到的音频：
  ///  true：（默认）发布采集到的音频。false：不发布采集到的音频。自 v4.0.0 起，该参数名称由 publishAudioTrack 改为 publishMicrophoneTrack。
  @JsonKey(name: 'publishMicrophoneTrack')
  final bool? publishMicrophoneTrack;

  /// 设置是否发布屏幕采集的视频：
  ///  true：发布屏幕采集到的视频。false：（默认）不发布屏幕采集到的视频。
  @JsonKey(name: 'publishScreenCaptureVideo')
  final bool? publishScreenCaptureVideo;

  /// 设置是否发布屏幕采集的音频：
  ///  true：发布屏幕采集到的音频。false：（默认）不发布屏幕采集到的音频。
  @JsonKey(name: 'publishScreenCaptureAudio')
  final bool? publishScreenCaptureAudio;

  /// 设置是否发布屏幕采集的视频：
  ///  true：发布屏幕采集到的视频。false：（默认）不发布屏幕采集到的视频。
  @JsonKey(name: 'publishScreenTrack')
  final bool? publishScreenTrack;

  /// 设置是否发布第二个屏幕采集的视频：
  ///  true：发布第二个屏幕采集到的视频。false：（默认）不发布第二个屏幕采集到的视频。
  @JsonKey(name: 'publishSecondaryScreenTrack')
  final bool? publishSecondaryScreenTrack;

  /// 设置是否发布自定义采集的音频：
  ///  true：发布自定义采集到的音频。false：（默认）不发布自定义采集到的音频。
  @JsonKey(name: 'publishCustomAudioTrack')
  final bool? publishCustomAudioTrack;

  /// 待发布的自定义音频源的 ID。默认值为 0。
  ///  如果你已在 setExternalAudioSource 中设置了 sourceNumber 大于 1，SDK 会创建对应数量的自采集音频轨道，并从 0 开始为每一个音频轨道分配一个 ID。
  @JsonKey(name: 'publishCustomAudioSourceId')
  final int? publishCustomAudioSourceId;

  /// 设置发布自定义采集的音频时是否启用 AEC：
  ///  true：发布自定义采集的音频时启用 AEC。false：（默认）发布自定义采集的音频时不启用 AEC。
  @JsonKey(name: 'publishCustomAudioTrackEnableAec')
  final bool? publishCustomAudioTrackEnableAec;

  /// @nodoc
  @JsonKey(name: 'publishDirectCustomAudioTrack')
  final bool? publishDirectCustomAudioTrack;

  /// @nodoc
  @JsonKey(name: 'publishCustomAudioTrackAec')
  final bool? publishCustomAudioTrackAec;

  /// 设置是否发布自定义采集的视频：
  ///  true：发布自定义采集的视频。false：（默认）不发布自定义采集到的视频。
  @JsonKey(name: 'publishCustomVideoTrack')
  final bool? publishCustomVideoTrack;

  /// 设置是否发布编码后的视频：
  ///  true：发布编码后的视频 。false：（默认）不发布编码后的视频。
  @JsonKey(name: 'publishEncodedVideoTrack')
  final bool? publishEncodedVideoTrack;

  /// 设置是否发布媒体播放器的音频：
  ///  true：发布媒体播放器的音频。false：（默认）不发布媒体播放器的音频。
  @JsonKey(name: 'publishMediaPlayerAudioTrack')
  final bool? publishMediaPlayerAudioTrack;

  /// 设置是否发布媒体播放器的视频：
  ///  true：发布媒体播放器的视频。false：（默认）不发布媒体播放器的视频。
  @JsonKey(name: 'publishMediaPlayerVideoTrack')
  final bool? publishMediaPlayerVideoTrack;

  /// 设置是否发布本地的转码视频：
  ///  true：发布本地的转码视频。false：（默认）不发布本地的转码视频。
  @JsonKey(name: 'publishTrancodedVideoTrack')
  final bool? publishTrancodedVideoTrack;

  /// 设置是否自动订阅所有音频流：
  ///  true：（默认）自动订阅所有音频流。false：不自动订阅任何音频流。
  @JsonKey(name: 'autoSubscribeAudio')
  final bool? autoSubscribeAudio;

  /// 设置是否自动订阅所有视频流：
  ///  true：（默认）自动订阅所有视频流。false：不自动订阅任何视频流。
  @JsonKey(name: 'autoSubscribeVideo')
  final bool? autoSubscribeVideo;

  /// 设置是否开启音频录制或播放：
  ///  true：（默认）开启音频录制和播放。false：不开启音频录制或播放。
  @JsonKey(name: 'enableAudioRecordingOrPlayout')
  final bool? enableAudioRecordingOrPlayout;

  /// 待发布的媒体播放器的 ID。默认值为 0。
  @JsonKey(name: 'publishMediaPlayerId')
  final int? publishMediaPlayerId;

  /// 用户角色。详见 ClientRoleType 。
  @JsonKey(name: 'clientRoleType')
  final ClientRoleType? clientRoleType;

  /// 观众端延时级别。详见 AudienceLatencyLevelType 。
  @JsonKey(name: 'audienceLatencyLevel')
  final AudienceLatencyLevelType? audienceLatencyLevel;

  /// 默认订阅的视频流类型: VideoStreamType 。
  ///
  @JsonKey(name: 'defaultVideoStreamType')
  final VideoStreamType? defaultVideoStreamType;

  /// 频道使用场景。详见 ChannelProfileType 。
  @JsonKey(name: 'channelProfile')
  final ChannelProfileType? channelProfile;

  /// @nodoc
  @JsonKey(name: 'audioDelayMs')
  final int? audioDelayMs;

  /// @nodoc
  @JsonKey(name: 'mediaPlayerAudioDelayMs')
  final int? mediaPlayerAudioDelayMs;

  /// （可选）在服务端生成的用于鉴权的动态密钥。详见该参数仅在调用 updateChannelMediaOptions 或 updateChannelMediaOptionsEx 时生效。请确保用于生成 token 的 App ID、频道名和用户名和 initialize 方法初始化引擎时用的 App ID，以及 joinChannel [2/2] 或 joinChannelEx 方法加入频道时设置的频道名和用户名是一致的。
  @JsonKey(name: 'token')
  final String? token;

  /// @nodoc
  @JsonKey(name: 'enableBuiltInMediaEncryption')
  final bool? enableBuiltInMediaEncryption;

  /// 设置是否发布虚拟节拍器声音至远端：
  ///  true：（默认）发布。本地用户和远端用户都能听到节拍器。false：不发布。只有本地用户能听到节拍器。
  @JsonKey(name: 'publishRhythmPlayerTrack')
  final bool? publishRhythmPlayerTrack;

  /// 是否开启互动模式：
  ///  true：开启互动模式。成功开启后，本地用户收到低延时和流畅的远端用户视频。false：（默认）不开启互动模式。本地用户收到默认设置的远端用户视频。该参数用于实现跨直播间连麦场景。连麦主播需要调用 joinChannelEx 方法，以观众身份加入对方的直播间，并将 isInteractiveAudience 设置为 true。仅当用户角色为 clientRoleAudience 时，该参数生效。
  @JsonKey(name: 'isInteractiveAudience')
  final bool? isInteractiveAudience;

  /// 调用 createCustomVideoTrack 方法返回的视频轨道 ID。默认值为 0。
  @JsonKey(name: 'customVideoTrackId')
  final int? customVideoTrackId;

  /// @nodoc
  @JsonKey(name: 'isAudioFilterable')
  final bool? isAudioFilterable;

  /// @nodoc
  factory ChannelMediaOptions.fromJson(Map<String, dynamic> json) =>
      _$ChannelMediaOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ChannelMediaOptionsToJson(this);
}

/// 与声网私有媒体服务器的连接模式。
///
@JsonEnum(alwaysCreate: true)
enum LocalProxyMode {
  /// 0：SDK 优先尝试连接指定的声网私有媒体服务器；如果无法连接到指定的声网私有媒体服务器，则连接声网 SD-RTN™。
  @JsonValue(0)
  connectivityFirst,

  /// 1：SDK 只尝试连接指定的声网私有媒体服务器。
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

/// 代理类型。
///
@JsonEnum(alwaysCreate: true)
enum ProxyType {
  /// 0: 预留参数，暂不支持。
  @JsonValue(0)
  noneProxyType,

  /// 1: UDP 协议的云代理，即 Force UDP 云代理模式。在该模式下，SDK 始终通过 UDP 协议传输数据。
  @JsonValue(1)
  udpProxyType,

  /// 2: TCP（加密）协议的云代理，即 Force TCP 云代理模式。在该模式下，SDK 始终通过 TLS 443 传输数据。
  @JsonValue(2)
  tcpProxyType,

  /// 3: 预留参数，暂不支持。
  @JsonValue(3)
  localProxyType,

  /// 4: 自动模式。在该模式下，SDK 优先连接 SD-RTN™，如果连接失败，自动切换为 TLS 443。
  @JsonValue(4)
  tcpProxyAutoFallbackType,
}

/// @nodoc
extension ProxyTypeExt on ProxyType {
  /// @nodoc
  static ProxyType fromValue(int value) {
    return $enumDecode(_$ProxyTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$ProxyTypeEnumMap[this]!;
  }
}

/// Local Access Point 配置。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LocalAccessPointConfiguration {
  /// @nodoc
  const LocalAccessPointConfiguration(
      {this.ipList,
      this.ipListSize,
      this.domainList,
      this.domainListSize,
      this.verifyDomainName,
      this.mode});

  /// Local Access Point 的对内 IP 地址列表。ipList 和 domainList 必须至少填一个。
  @JsonKey(name: 'ipList')
  final List<String>? ipList;

  /// Local Access Point 对内 IP 地址的数量。该参数的值必须和你填入的 IP 地址的数量一致。
  @JsonKey(name: 'ipListSize')
  final int? ipListSize;

  /// Local Access Point 的域名列表。SDK 会根据你填入的域名解析出 Local Access Point 的 IP 地址。域名解析的超时时间为 10 秒。ipList 和 domainList 必须至少填一个。如果你同时指定 IP 地址和域名，SDK 会将根据域名解析出来的 IP 地址和你指定的 IP 地址合并、去重，然后随机连接一个 IP 来实现负载均衡。
  @JsonKey(name: 'domainList')
  final List<String>? domainList;

  /// Local Access Point 域名的数量。该参数的值必须和你填入的域名的数量一致。
  @JsonKey(name: 'domainListSize')
  final int? domainListSize;

  /// 内网证书验证域名。如果传值为空，则用 SDK 默认的证书验证域名 secure-edge.local。
  @JsonKey(name: 'verifyDomainName')
  final String? verifyDomainName;

  /// 连接模式。详见 LocalProxyMode 。
  @JsonKey(name: 'mode')
  final LocalProxyMode? mode;

  /// @nodoc
  factory LocalAccessPointConfiguration.fromJson(Map<String, dynamic> json) =>
      _$LocalAccessPointConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LocalAccessPointConfigurationToJson(this);
}

/// 离开频道的选项。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LeaveChannelOptions {
  /// @nodoc
  const LeaveChannelOptions(
      {this.stopAudioMixing, this.stopAllEffect, this.stopMicrophoneRecording});

  /// 离开频道时，是否停止播放音乐文件及混音：
  ///  true：（默认）停止播放音乐文件及混音。false： 不停止播放音乐文件及混音。
  @JsonKey(name: 'stopAudioMixing')
  final bool? stopAudioMixing;

  /// 离开频道时，是否停止播放音效：
  ///  true：（默认）停止播放音效。false： 不停止播放音效。
  @JsonKey(name: 'stopAllEffect')
  final bool? stopAllEffect;

  /// 离开频道时，是否停止麦克风采集：
  ///  true：（默认）停止麦克风采集。false： 不停止麦克风采集。
  @JsonKey(name: 'stopMicrophoneRecording')
  final bool? stopMicrophoneRecording;

  /// @nodoc
  factory LeaveChannelOptions.fromJson(Map<String, dynamic> json) =>
      _$LeaveChannelOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LeaveChannelOptionsToJson(this);
}

/// RtcEngineEventHandler 接口类用于 SDK 向 app 发送事件通知，app 通过继承该接口类的方法获取 SDK 的事件通知。
///
class RtcEngineEventHandler {
  /// @nodoc
  const RtcEngineEventHandler({
    this.onJoinChannelSuccess,
    this.onRejoinChannelSuccess,
    this.onProxyConnected,
    this.onError,
    this.onAudioQuality,
    this.onLastmileProbeResult,
    this.onAudioVolumeIndication,
    this.onLeaveChannel,
    this.onRtcStats,
    this.onAudioDeviceStateChanged,
    this.onAudioMixingFinished,
    this.onAudioEffectFinished,
    this.onVideoDeviceStateChanged,
    this.onMediaDeviceChanged,
    this.onNetworkQuality,
    this.onIntraRequestReceived,
    this.onUplinkNetworkInfoUpdated,
    this.onDownlinkNetworkInfoUpdated,
    this.onLastmileQuality,
    this.onFirstLocalVideoFrame,
    this.onFirstLocalVideoFramePublished,
    this.onFirstRemoteVideoDecoded,
    this.onVideoSizeChanged,
    this.onLocalVideoStateChanged,
    this.onRemoteVideoStateChanged,
    this.onFirstRemoteVideoFrame,
    this.onUserJoined,
    this.onUserOffline,
    this.onUserMuteAudio,
    this.onUserMuteVideo,
    this.onUserEnableVideo,
    this.onUserStateChanged,
    this.onUserEnableLocalVideo,
    this.onApiCallExecuted,
    this.onLocalAudioStats,
    this.onRemoteAudioStats,
    this.onLocalVideoStats,
    this.onRemoteVideoStats,
    this.onCameraReady,
    this.onCameraFocusAreaChanged,
    this.onCameraExposureAreaChanged,
    this.onFacePositionChanged,
    this.onVideoStopped,
    this.onAudioMixingStateChanged,
    this.onRhythmPlayerStateChanged,
    this.onConnectionLost,
    this.onConnectionInterrupted,
    this.onConnectionBanned,
    this.onStreamMessage,
    this.onStreamMessageError,
    this.onRequestToken,
    this.onTokenPrivilegeWillExpire,
    this.onFirstLocalAudioFramePublished,
    this.onFirstRemoteAudioFrame,
    this.onFirstRemoteAudioDecoded,
    this.onLocalAudioStateChanged,
    this.onRemoteAudioStateChanged,
    this.onActiveSpeaker,
    this.onContentInspectResult,
    this.onSnapshotTaken,
    this.onClientRoleChanged,
    this.onClientRoleChangeFailed,
    this.onAudioDeviceVolumeChanged,
    this.onRtmpStreamingStateChanged,
    this.onRtmpStreamingEvent,
    this.onTranscodingUpdated,
    this.onAudioRoutingChanged,
    this.onChannelMediaRelayStateChanged,
    this.onChannelMediaRelayEvent,
    this.onLocalPublishFallbackToAudioOnly,
    this.onRemoteSubscribeFallbackToAudioOnly,
    this.onRemoteAudioTransportStats,
    this.onRemoteVideoTransportStats,
    this.onConnectionStateChanged,
    this.onWlAccMessage,
    this.onWlAccStats,
    this.onNetworkTypeChanged,
    this.onEncryptionError,
    this.onPermissionError,
    this.onLocalUserRegistered,
    this.onUserInfoUpdated,
    this.onUploadLogResult,
    this.onAudioSubscribeStateChanged,
    this.onVideoSubscribeStateChanged,
    this.onAudioPublishStateChanged,
    this.onVideoPublishStateChanged,
    this.onExtensionEvent,
    this.onExtensionStarted,
    this.onExtensionStopped,
    this.onExtensionError,
    this.onUserAccountUpdated,
  });

  /// 成功加入频道回调。
  /// 该回调方法表示该客户端成功加入了指定的频道。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [elapsed] 从本地调用 joinChannel [2/2] 开始到发生此事件过去的时间（毫秒）。
  final void Function(RtcConnection connection, int elapsed)?
      onJoinChannelSuccess;

  /// 成功重新加入频道回调。
  /// 有时候由于网络原因，客户端可能会和服务器失去连接，SDK 会进行自动重连，自动重连成功后触发此回调方法。
  ///
  /// * [elapsed] 从调用 joinChannel [1/2] 或 joinChannel [2/2] 方法到触发该回调的时间间隔（毫秒）。
  final void Function(RtcConnection connection, int elapsed)?
      onRejoinChannelSuccess;

  /// 代理连接状态回调。
  /// 通过该回调你可以监听 SDK 连接代理的状态。例如，当用户调用 setCloudProxy 设置代理并成功加入频道后， SDK 会触发该回调报告用户 ID、连接的代理类型和从调用 joinChannel [1/2] 到触发该回调经过的时间等。
  ///
  /// * [channel] 频道名称。
  /// * [uid] 用户 ID
  /// * [localProxyIp] 预留参数，暂不支持。
  /// * [elapsed] 从调用 joinChannel [1/2] 到 SDK 触发该回调的经过的时间（毫秒）。
  final void Function(String channel, int uid, ProxyType proxyType,
      String localProxyIp, int elapsed)? onProxyConnected;

  /// 发生错误回调。
  /// 该回调方法表示 SDK 运行时出现了网络或媒体相关的错误。通常情况下，SDK 上报的错误意味着 SDK 无法自动恢复，需要 app 干预或提示用户。
  ///
  /// * [err] 错误码。详见 ErrorCodeType 。
  /// * [msg] 错误描述。
  final void Function(ErrorCodeType err, String msg)? onError;

  /// 远端声音质量回调。
  /// 弃用：请改用 onRemoteAudioStats 。该回调描述远端用户在通话中的音频质量，针对每个远端用户/主播每 2 秒触发一次。如果远端同时存在多个用户/主播，该回调每 2 秒会被触发多次。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [remoteUid] 用户 ID，指定是谁发的音频流。
  /// * [quality] 语音质量。详见 QualityType 。
  /// * [delay] 音频包从发送端到接收端的延迟（毫秒），包括声音采样前处理、网络传输、网络抖动缓冲引起的延迟。
  /// * [lost] 音频包从发送端到接收端的丢包率 (%)。
  final void Function(RtcConnection connection, int remoteUid,
      QualityType quality, int delay, int lost)? onAudioQuality;

  /// 通话前网络上下行 Last mile 质量探测报告回调。
  /// 在调用 startLastmileProbeTest 之后，SDK 会在约 30 秒内返回该回调。
  ///
  /// * [result]  上下行 Last mile 质量探测结果。 详见: LastmileProbeResult 。
  final void Function(LastmileProbeResult result)? onLastmileProbeResult;

  /// 用户音量提示回调。
  /// 该回调默认禁用，你可以通过 enableAudioVolumeIndication 开启。 开启后，只要频道内有发流用户，SDK 会在加入频道后按 enableAudioVolumeIndication 中设置的时间间隔触发 onAudioVolumeIndication 回调。每次会触发两个 onAudioVolumeIndication 回调，一个报告本地发流用户的音量相关信息，另一个报告瞬时音量最高的远端用户（最多 3 位）的音量相关信息。启用该功能后，如果有用户将自己静音（调用了 muteLocalAudioStream ），SDK 会继续报告本地用户的音量提示回调。瞬时音量最高的远端用户静音后 20 秒，远端的音量提示回调中将不再包含该用户；如果远端所有用户都将自己静音，20 秒后 SDK 停止报告远端用户的音量提示回调。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [speakers] 用户音量信息，详见 AudioVolumeInfo 数组。如果 speakers 为空，则表示远端用户不发流或没有远端用户。
  /// * [speakerNumber] 用户数量。 在本地用户的回调中，只要本地用户在发流，speakerNumber 始终为 1。在远端用户的回调中，speakerNumber 取值范围为 [0,3]。如果远端发流用户数量大于 3，则此回调中 speakerNumber 值为 3。
  /// * [totalVolume] 混音后的总音量，取值范围为 [0,255]。 在本地用户的回调中，totalVolume 为本地发流用户的音量。在远端用户的回调中，totalVolume 为瞬时音量最高的远端用户（最多 3 位）混音后的总音量。
  final void Function(RtcConnection connection, List<AudioVolumeInfo> speakers,
      int speakerNumber, int totalVolume)? onAudioVolumeIndication;

  /// 离开频道回调。
  /// App 调用 leaveChannel 方法时，SDK 提示 app 离开频道成功。在该回调方法中，app 可以得到此次通话的总通话时长、SDK 收发数据的流量等信息。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [stats] 通话的统计数据: RtcStats 。
  final void Function(RtcConnection connection, RtcStats stats)? onLeaveChannel;

  /// 当前通话统计信息回调。
  /// SDK 定期向 App 报告当前通话的统计信息，每两秒触发一次。
  ///
  /// * [connection]  Connection 信息。详见 RtcConnection 。
  /// * [stats] RTC 引擎统计数据，详见
  ///  RtcStats
  ///  。
  ///
  final void Function(RtcConnection connection, RtcStats stats)? onRtcStats;

  /// 音频设备变化回调。
  /// 提示系统音频设备状态发生改变，比如耳机被拔出。该方法仅适用于 Windows 和 macOS 平台。
  ///
  /// * [deviceId] 设备 ID。
  /// * [deviceType] 设备类型定义。详见 MediaDeviceType 。
  /// * [deviceState] 设备状态定义。 macOS 平台： 0: 设备就绪。8: 设备被拔出。Windows 平台：详见 MediaDeviceStateType 。
  final void Function(String deviceId, MediaDeviceType deviceType,
      MediaDeviceStateType deviceState)? onAudioDeviceStateChanged;

  /// 本地音乐文件播放已结束回调。
  /// 弃用：请改用 onAudioMixingStateChanged 。当调用 startAudioMixing 播放本地音乐文件结束后，会触发该回调。如果调用 startAudioMixing 失败，会返回错误码 WARN_AUDIO_MIXING_OPEN_ERROR。
  final void Function()? onAudioMixingFinished;

  /// 本地音效文件播放已结束回调。
  /// 当播放音效结束后，会触发该回调。
  ///
  /// * [soundId] 指定音效的 ID。每个音效均有唯一的 ID。
  final void Function(int soundId)? onAudioEffectFinished;

  /// @nodoc
  final void Function(String deviceId, MediaDeviceType deviceType,
      MediaDeviceStateType deviceState)? onVideoDeviceStateChanged;

  /// @nodoc
  final void Function(MediaDeviceType deviceType)? onMediaDeviceChanged;

  /// 通话中每个用户的网络上下行 last mile 质量报告回调。
  /// 该回调描述每个用户在通话中的 last mile 网络状态，其中 last mile 是指设备到 Agora 边缘服务器的网络状态。该回调每 2 秒触发一次。如果远端有多个用户，该回调每 2 秒会被触发多次。用户不发流时，txQuality 为 rxQuality 为
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [remoteUid] 用户 ID。表示该回调报告的是持有该 ID 的用户的网络质量。
  /// * [txQuality] 该用户的上行网络质量，基于发送码率、上行丢包率、平均往返时延和网络抖动计算。 该值代表当前的上行网络质量，帮助判断是否可以支持当前设置的视频编码属性。 假设上行码率是 1000 Kbps，那么支持直播场景下 640 × 480 的分辨率、15 fps 的帧率没有问题，但是支持 1280 × 720 的分辨率就会有困难。 详见 QualityType 。
  /// * [rxQuality] 该用户的下行网络质量，基于下行网络的丢包率、平均往返延时和网络抖动计算。详见 QualityType 。
  final void Function(RtcConnection connection, int remoteUid,
      QualityType txQuality, QualityType rxQuality)? onNetworkQuality;

  /// @nodoc
  final void Function(RtcConnection connection)? onIntraRequestReceived;

  /// 上行网络信息变化回调。
  /// 只有当上行网络信息发生变化时，SDK 才会触发该回调。该回调仅适用于向 SDK 推送 H.264 格式的外部编码视频数据的场景。
  ///
  /// * [info] 上行网络信息，详见 UplinkNetworkInfo 。
  final void Function(UplinkNetworkInfo info)? onUplinkNetworkInfoUpdated;

  /// @nodoc
  final void Function(DownlinkNetworkInfo info)? onDownlinkNetworkInfoUpdated;

  /// 网络上下行 last mile 质量报告回调。
  /// 该回调描述本地用户在加入频道前的 last mile 网络探测的结果，其中 last mile 是指设备到 Agora 边缘服务器的网络状态。加入频道前，调用 startLastmileProbeTest 之后，SDK 触发该回调报告本地用户在加入频道前的 last mile 网络探测的结果。
  ///
  /// * [quality] Last mile 网络质量。
  ///  qualityUnknown (0)：质量未知。
  ///  qualityExcellent (1)：质量极好。
  ///  qualityGood (2)：用户主观感觉和极好差不多，但码率可能略低于极好。
  ///  qualityPoor (3)：用户主观感受有瑕疵但不影响沟通。
  ///  qualityBad (4)：勉强能沟通但不顺畅。
  ///  qualityVbad (5)：网络质量非常差，基本不能沟通。
  ///  qualityDown (6)：网络连接断开，完全无法沟通。
  ///  详见 QualityType 。
  final void Function(QualityType quality)? onLastmileQuality;

  /// 已显示本地视频首帧回调。
  /// 本地视频首帧显示在本地视图上时，SDK 会触发此回调。
  ///
  /// * [source] 视频源的类型。详见 VideoSourceType 。
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [width] 本地渲染视频的宽 (px) 。
  /// * [height] 本地渲染视频的高 (px)。
  /// * [elapsed] 从调用 joinChannel [2/2] 到发生此事件过去的时间（毫秒）。如果在 joinChannel [2/2] 前调用了 startPreview ，则是从 startPreview到发生此事件过去的时间。
  final void Function(
          RtcConnection connection, int width, int height, int elapsed)?
      onFirstLocalVideoFrame;

  /// 已发布本地视频首帧回调。
  /// SDK 会在以下三种时机触发该回调：
  ///  开启本地视频的情况下，调用 joinChannel [2/2] 成功加入频道后。调用 muteLocalVideoStream (true)，再调用 muteLocalVideoStream(false) 后。调用 disableVideo ，再调用 enableVideo 后。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [elapsed] 从调用 joinChannel [2/2] 方法到触发该回调的时间间隔（毫秒）。
  final void Function(RtcConnection connection, int elapsed)?
      onFirstLocalVideoFramePublished;

  /// 已接收到远端视频并完成解码回调。
  /// SDK 会在以下时机触发该回调：
  ///  远端用户首次上线后发送视频。远端用户视频离线再上线后发送视频。出现这种中断的可能原因包括：
  ///  远端用户离开频道。远端用户掉线。远端用户调用 muteLocalVideoStream 方法停止发送本地视频流。远端用户调用 disableVideo 方法关闭视频模块。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [remoteUid] 用户 ID，指定是哪个用户的视频流。
  /// * [width] 视频流宽（px）。
  /// * [height] 视频流高（px）。
  /// * [elapsed] 从本地调用 joinChannel [2/2] 开始到该回调触发的延迟（毫秒)。
  final void Function(RtcConnection connection, int remoteUid, int width,
      int height, int elapsed)? onFirstRemoteVideoDecoded;

  /// 本地或远端视频大小和旋转信息发生改变回调。
  ///
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [sourceType] 视频源的类型。详见 VideoSourceType 。
  /// * [uid] 图像尺寸和旋转信息发生变化的用户 ID（本地用户的 uid 为 0。此时视频为本地用户的视频预览）。
  /// * [width] 视频流的宽度（像素）。
  /// * [height] 视频流的高度（像素）。
  /// * [rotation] 旋转信息，取值范围 [0,360)。
  final void Function(RtcConnection connection, VideoSourceType sourceType,
      int uid, int width, int height, int rotation)? onVideoSizeChanged;

  /// 本地视频状态发生改变回调。
  /// 本地视频的状态发生改变时，SDK 会触发该回调返回当前的本地视频状态。你可以通过该回调了解当前视频的状态以及出现故障的原因，方便排查问题。 SDK 会在如下情况触发 onLocalVideoStateChanged 回调，状态为 localVideoStreamStateFailed，错误码为 localVideoStreamErrorCaptureFailure：
  ///  应用退到后台，系统回收摄像头。摄像头正常启动，但连续 4 秒都没有输出采集的视频。摄像头输出采集的视频帧时，如果连续 15 帧中，所有视频帧都一样，SDK 触发 onLocalVideoStateChanged 回调，状态为 localVideoStreamStateCapturing，错误码为 localVideoStreamErrorCaptureFailure。注意，帧重复检测仅针对分辨率大于 200 × 200、帧率大于等于 10 fps、码率小于 20 Kbps 的视频帧。对某些机型而言，当本地视频采集设备正在使用中时，SDK 不会在本地视频状态发生改变时触发该回调，你需要自行做超时判断。
  ///
  /// * [source] 视频源的类型。详见 VideoSourceType 。
  /// * [state] 本地视频状态，详见 LocalVideoStreamState 。
  /// * [error] 本地视频出错原因，详见 LocalVideoStreamError 。
  final void Function(VideoSourceType source, LocalVideoStreamState state,
      LocalVideoStreamError error)? onLocalVideoStateChanged;

  /// 远端视频状态发生改变回调。
  /// 频道内的用户（通信场景）或主播（直播场景）人数超过 17 人时，该回调可能不准确。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [remoteUid] 发生视频状态改变的远端用户 ID。
  /// * [state] 远端视频流状态，详见 RemoteVideoState 。
  /// * [reason] 远端视频流状态改变的具体原因，详见 RemoteVideoStateReason 。
  /// * [elapsed] 从本地用户调用 joinChannel [2/2] 方法到发生本事件经历的时间，单位为毫秒。
  final void Function(
      RtcConnection connection,
      int remoteUid,
      RemoteVideoState state,
      RemoteVideoStateReason reason,
      int elapsed)? onRemoteVideoStateChanged;

  /// 渲染器已接收首帧远端视频回调。
  ///
  ///
  /// * [uid] 用户 ID，指定是哪个用户的视频流。
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [width] 视频流宽（px）。
  /// * [height] 视频流高（px）。
  /// * [elapsed]  从本地调用 joinChannel [2/2] 到发生此事件过去的时间（毫秒)。
  final void Function(RtcConnection connection, int remoteUid, int width,
      int height, int elapsed)? onFirstRemoteVideoFrame;

  /// 远端用户（通信场景）/主播（直播场景）加入当前频道回调。
  /// 通信场景下，该回调提示有远端用户加入了频道。如果加入之前，已经有其他用户在频道中了，新加入的用户也会收到这些已有用户加入频道的回调。直播场景下，该回调提示有主播加入了频道。如果加入之前，已经有主播在频道中了，新加入的用户也会收到已有主播加入频道的回调。Agora 建议连麦主播不超过 17 人。该回调在如下情况下会被触发：
  ///  远端用户/主播调用 joinChannel [2/2] 方法加入频道。远端用户加入频道后将用户角色改变为主播。远端用户/主播网络中断后重新加入频道。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [remoteUid] 新加入频道的远端用户/主播 ID。
  /// * [elapsed] 从本地用户调用 joinChannel [2/2] 到该回调触发的延迟（毫秒)。
  ///
  final void Function(RtcConnection connection, int remoteUid, int elapsed)?
      onUserJoined;

  /// 远端用户（通信场景）/主播（直播场景）离开当前频道回调。
  /// 用户离开频道有两个原因：
  ///  正常离开：远端用户/主播会发送类似“再见”的消息。接收此消息后，判断用户离开频道。超时掉线：在一定时间内（通信场景为 20 秒，直播场景稍有延时），用户没有收到对方的任何数据包，则判定为对方掉线。在网络较差的情况下，有可能会误报。我们建议使用 Agora 云信令 SDK 来做可靠的掉线检测。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [remoteUid] 离线用户或主播的用户 ID。
  /// * [reason] 离线原因: UserOfflineReasonType 。
  final void Function(RtcConnection connection, int remoteUid,
      UserOfflineReasonType reason)? onUserOffline;

  /// 远端用户（通信场景）/主播（直播场景）停止或恢复发送音频流回调。
  /// 该回调是由远端用户调用 muteLocalAudioStream 方法关闭或开启音频发送触发的。频道内的用户（通信场景）或主播（直播场景）人数超过 17 人时，该回调可能不准确。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [remoteUid] 用户 ID。
  /// * [muted] 该用户是否静音：
  ///  true: 该用户已将音频静音。false: 该用户取消了音频静音。
  final void Function(RtcConnection connection, int remoteUid, bool muted)?
      onUserMuteAudio;

  /// 远端用户取消或恢复发布视频流回调。
  /// 当远端用户调用 muteLocalVideoStream 取消或恢复发布视频流时，SDK 会触发该回调向本地用户报告远端用户的发流状况。当频道内的用户（通信场景）或主播（直播场景）的人数超过 17 时，该回调可能不准确。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [remoteUid] 远端用户 ID。
  /// * [muted] 远端用户是否取消发布视频流：
  ///  true: 取消发布视频流。false: 发布视频流。
  final void Function(RtcConnection connection, int remoteUid, bool muted)?
      onUserMuteVideo;

  /// 远端用户开/关视频模块回调。
  /// 关闭视频功能是指该用户只能进行语音通话，不能显示、发送自己的视频，也不能接收、显示别人的视频。该回调是由远端用户调用 enableVideo 或 disableVideo 方法开启或关闭视频模块触发的。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [remoteUid] 用户 ID，提示是哪个用户的视频流。
  /// * [enabled] true: 该用户已启用视频功能。false: 该用户已关闭视频功能。
  final void Function(RtcConnection connection, int remoteUid, bool enabled)?
      onUserEnableVideo;

  /// @nodoc
  final void Function(RtcConnection connection, int remoteUid, int state)?
      onUserStateChanged;

  /// 远端用户开/关本地视频采集回调。
  /// 该回调是由远端用户调用 enableLocalVideo 方法开启或关闭视频采集触发的。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [remoteUid] 用户 ID，提示是哪个用户的视频流。
  /// * [enabled] 远端用户是否启用视频采集：
  ///  true: 该用户已启用视频功能。启用后，其他用户可以接收到该用户的视频流。false: 该用户已关闭视频功能。关闭后，该用户仍然可以接收其他用户的视频流，但其他用户接收不到该用户的视频流。
  final void Function(RtcConnection connection, int remoteUid, bool enabled)?
      onUserEnableLocalVideo;

  /// API 方法已执行回调。
  ///
  ///
  /// * [err] 当方法调用失败时 SDK 返回的错误码。如果该方法调用成功，SDK 会返回 0。
  /// * [api] SDK 执行的 API 方法。
  /// * [result] SDK 调用 API 的结果。
  final void Function(ErrorCodeType err, String api, String result)?
      onApiCallExecuted;

  /// 通话中本地音频流的统计信息回调。
  /// SDK 每 2 秒触发该回调一次。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [stats] 本地音频统计数据。详见 LocalAudioStats 。
  final void Function(RtcConnection connection, LocalAudioStats stats)?
      onLocalAudioStats;

  /// 通话中远端音频流的统计信息回调。
  /// 该回调针对每个发送音频流的远端用户/主播每 2 秒触发一次。如果远端有多个用户/主播发送音频流，该回调每 2 秒会被触发多次。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [stats] 接收到的远端音频统计数据，详见 RemoteAudioStats 。
  final void Function(RtcConnection connection, RemoteAudioStats stats)?
      onRemoteAudioStats;

  /// 本地视频流统计信息回调。
  /// 该回调描述本地设备发送视频流的统计信息，每 2 秒触发一次。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [stats] 本地视频流统计信息。详见 LocalVideoStats 。
  final void Function(RtcConnection connection, LocalVideoStats stats)?
      onLocalVideoStats;

  /// 通话中远端视频流的统计信息回调。
  /// 该回调描述远端用户在通话中端到端的视频流统计信息， 针对每个远端用户/主播每 2 秒触发一次。如果远端同时存在多个用户/主播， 该回调每 2 秒会被触发多次。
  ///
  /// * [stats] 远端视频统计数据。详见 RemoteVideoStats 。
  final void Function(RtcConnection connection, RemoteVideoStats stats)?
      onRemoteVideoStats;

  /// 摄像头就绪回调。
  /// 弃用:请改用 onLocalVideoStateChanged 中的 localVideoStreamStateCapturing(1)。该回调提示已成功打开摄像头，可以开始捕获视频。
  final void Function()? onCameraReady;

  /// 相机对焦区域已改变回调。
  ///
  ///
  /// * [x] 发生改变的对焦区域的 x 坐标。
  /// * [y] 发生改变的对焦区域的 y 坐标。
  /// * [width] 发生改变的对焦区域的宽度。
  /// * [height] 发生改变的对焦区域的高度。
  final void Function(int x, int y, int width, int height)?
      onCameraFocusAreaChanged;

  /// 摄像头曝光区域已改变回调。
  ///
  final void Function(int x, int y, int width, int height)?
      onCameraExposureAreaChanged;

  /// 报告本地人脸检测结果。
  /// 调用 enableFaceDetection (true) 开启本地人脸检测后，你可以通过该回调实时获取以下人脸检测的信息： 摄像头采集的画面大小人脸在 view 中的位置人脸距设备屏幕的距离其中，人脸距设备屏幕的距离由 SDK 通过摄像头采集的画面大小和人脸在 view 中的位置拟合计算得出。该回调仅适用于 Android 和 iOS 平台。当检测到摄像头前的人脸消失时，该回调会立刻触发；在无人脸的状态下，该回调触发频率会降低，以节省设备耗能。当人脸距离设备屏幕过近时，SDK 不会触发该回调。Android 平台上，人脸距设备屏幕的距离（distance）值有一定误差，请不要用它进行精确计算。
  ///
  /// * [imageWidth] 摄像头采集画面的宽度 (px)。
  /// * [imageHeight] 摄像头采集画面的高度 (px)。
  /// * [vecRectangle] 检测到的人脸信息。详见 Rectangle 。
  /// * [vecDistance] 人脸距设备屏幕的距离 (cm)。
  /// * [numFaces] 检测的人脸数量。如果为 0，则表示没有检测到人脸。
  final void Function(int imageWidth, int imageHeight, Rectangle vecRectangle,
      int vecDistance, int numFaces)? onFacePositionChanged;

  /// 视频功能已停止回调。
  /// 弃用：请改用 onLocalVideoStateChanged 回调中的 localVideoStreamStateStopped(0)。App 如需在停止视频后对 view 做其他处理（比如显示其他画面），可以在这个回调中进行。
  final void Function()? onVideoStopped;

  /// 音乐文件的播放状态已改变回调。
  /// 该回调在音乐文件播放状态发生改变时触发，并报告当前的播放状态和错误码。
  ///
  /// * [state] 音乐文件播放状态。详见 AudioMixingStateType 。
  /// * [reason] 错误码。详见 AudioMixingReasonType 。
  final void Function(AudioMixingStateType state, AudioMixingReasonType reason)?
      onAudioMixingStateChanged;

  /// @nodoc
  final void Function(
          RhythmPlayerStateType state, RhythmPlayerErrorType errorCode)?
      onRhythmPlayerStateChanged;

  /// 网络连接中断，且 SDK 无法在 10 秒内连接服务器回调。
  /// SDK 在调用 joinChannel [2/2] 后，无论是否加入成功，只要 10 秒和服务器无法连接就会触发该回调。如果 SDK 在断开连接后，20 分钟内还是没能重新加入频道，SDK 会停止尝试重连。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  final void Function(RtcConnection connection)? onConnectionLost;

  /// 网络连接中断回调。
  /// 弃用:请改用 onConnectionStateChanged 回调。SDK 在和服务器建立连接后，失去了网络连接超过 4 秒，会触发该回调。在触发事件后，SDK 会主动重连服务器，所以该事件可以用于 UI 提示。该回调与 onConnectionLost 的区别是：
  ///  onConnectionInterrupted 回调一定是发生在成功加入频道后，且 SDK 刚失去和服务器连接超过 4 秒时触发。onConnectionLost 回调是无论是否成功加入频道，只要 10 秒内和服务器无法建立连接都会触发。 如果 SDK 在断开连接后，20 分钟内还是没能重新加入频道，SDK 会停止尝试重连。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  final void Function(RtcConnection connection)? onConnectionInterrupted;

  /// 网络连接已被服务器禁止回调。
  /// 弃用: 请改用 onConnectionStateChanged 。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  final void Function(RtcConnection connection)? onConnectionBanned;

  /// 接收到对方数据流消息的回调。
  /// 该回调表示本地用户收到了远端用户调用 sendStreamMessage 方法发送的流消息。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [uid] 发送消息的用户 ID。
  /// * [streamId] 接收到的消息的 Stream ID。
  /// * [data] 接收到的数据。
  /// * [length] 数据长度，单位为字节。
  /// * [sentTs] 数据流发出的时间。
  final void Function(RtcConnection connection, int remoteUid, int streamId,
      Uint8List data, int length, int sentTs)? onStreamMessage;

  /// 接收对方数据流消息发生错误的回调。
  /// 该回调表示本地用户未收到远端用户调用 sendStreamMessage 方法发送的流消息。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [remoteUid] 发送消息的用户 ID。
  /// * [streamId] 接收到的消息的 Stream ID。
  /// * [code] 发生错误的错误码。
  /// * [missed] 丢失的消息数量。
  /// * [cached] 数据流中断时，后面缓存的消息数量。
  final void Function(RtcConnection connection, int remoteUid, int streamId,
      ErrorCodeType code, int missed, int cached)? onStreamMessageError;

  /// Token 已过期回调。
  /// 在通话过程中如果 Token 已失效，SDK 会触发该回调，提醒 app 更新 Token。
  ///  当收到该回调时，你需要重新在服务端生成新的 Token，然后调用 joinChannel [2/2] 重新加入频道。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  final void Function(RtcConnection connection)? onRequestToken;

  /// Token 服务将在30s内过期回调。
  /// 在通话过程中如果 Token 即将失效，SDK 会提前 30 秒触发该回调，提醒 app 更新 Token。
  ///  当收到该回调时，你需要重新在服务端生成新的 Token，然后调用 renewToken 将新生成的 Token 传给 SDK。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [token] 即将服务失效的 Token。
  final void Function(RtcConnection connection, String token)?
      onTokenPrivilegeWillExpire;

  /// 已发布本地音频首帧回调。
  /// SDK 会在以下时机触发该回调：
  ///  开启本地音频的情况下，调用 joinChannel [2/2] 成功加入频道后。调用 muteLocalAudioStream (true)，再调用 muteLocalAudioStream(false) 后。调用 disableAudio ，再调用 enableAudio 后。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [elapsed]  从调用 joinChannel [2/2] 方法到触发该回调的时间间隔（毫秒）。
  final void Function(RtcConnection connection, int elapsed)?
      onFirstLocalAudioFramePublished;

  /// 已接收远端音频首帧回调。
  /// 弃用：请改用 onRemoteAudioStateChanged 。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [userId] 发送音频帧的远端用户的用户 ID。
  /// * [elapsed] 从本地用户调用 joinChannel [2/2] 直至该回调触发的延迟，单位为毫秒。
  final void Function(RtcConnection connection, int userId, int elapsed)?
      onFirstRemoteAudioFrame;

  /// 已解码远端音频首帧的回调。
  /// 弃用：请改用 onRemoteAudioStateChanged 。SDK 会在以下时机触发该回调： 远端用户首次上线后发送音频。远端用户音频离线再上线发送音频。音频离线指本地在 15 秒内没有收到音频包，可能有如下原因： 远端用户离开频道远端用户掉线远端用户调用 muteLocalAudioStream 方法停止发送音频流远端用户调用 disableAudio 方法关闭音频
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [uid] 远端用户 ID。
  /// * [elapsed] 从本地用户调用 joinChannel [2/2] 直至该回调触发的延迟，单位为毫秒。
  final void Function(RtcConnection connection, int uid, int elapsed)?
      onFirstRemoteAudioDecoded;

  /// 本地音频状态发生改变回调。
  /// 本地音频的状态发生改变时（包括本地麦克风采集状态和音频编码状态），SDK 会触发该回调报告当前的本地音频状态。在本地音频出现故障时，该回调可以帮助你了解当前音频的状态以及出现故障的原因，方便你排查问题。
  ///  当状态为 localAudioStreamStateFailed (3) 时， 你可以在 error 参数中查看返回的错误信息。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [state] 当前的本地音频状态。详见 localaudiostreamstate 。
  /// * [error] 本地音频出错原因。详见 LocalAudioStreamError 。
  final void Function(RtcConnection connection, LocalAudioStreamState state,
      LocalAudioStreamError error)? onLocalAudioStateChanged;

  /// 远端音频流状态发生改变回调。
  /// 远端用户（通信场景）或主播（直播场景）的音频状态发生改变时，SDK 会触发该回调向本地用户报告当前的远端音频流状态。频道内的用户（通信场景）或主播（直播场景）人数超过 17 人时，该回调可能不准确。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [remoteUid] 发生音频状态改变的远端用户 ID。
  /// * [state]  远端音频流状态，详见 RemoteAudioState 。
  /// * [reason]  远端音频流状态改变的具体原因，详见 RemoteAudioStateReason 。
  /// * [elapsed]  从本地用户调用 joinChannel [2/2] 方法到发生本事件经历的时间，单位为毫秒。
  final void Function(
      RtcConnection connection,
      int remoteUid,
      RemoteAudioState state,
      RemoteAudioStateReason reason,
      int elapsed)? onRemoteAudioStateChanged;

  /// 监测到远端最活跃用户回调。
  /// 成功调用 enableAudioVolumeIndication 后，SDK 会持续监测音量最大的远端用户，并统计该用户被判断为音量最大者的次数。当前时间段内，该次数累积最多的远端用户为最活跃的用户。当频道内用户数量大于或等于 2 且有远端活跃用户时，SDK 会触发该回调并报告远端最活跃用户的 uid。
  ///  如果远端最活跃用户一直是同一位用户，则 SDK 不会再次触发 onActiveSpeaker 回调。如果远端最活跃用户有变化，则 SDK 会再次触发该回调并报告新的远端最活跃用户的 uid。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [uid] 远端最活跃用户的 ID。
  final void Function(RtcConnection connection, int uid)? onActiveSpeaker;

  /// 视频鉴黄结果回调。
  /// 调用 enableContentInspect 启用视频内容审核服务，并设置 ContentInspectConfig 中的 type 为 contentInspectModeration 后，SDK 会触发 onContentInspectResult 回调，报告鉴黄结果。
  ///
  /// * [result] 鉴黄结果。详见 ContentInspectResult 。
  final void Function(ContentInspectResult result)? onContentInspectResult;

  /// 视频截图结果回调。
  /// 成功调用 takeSnapshot 后，SDK 触发该回调报告截图是否成功和获取截图的详情。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [uid] 用户 ID。如果 uid 为 0，表示本地用户。
  /// * [filePath] 截图的本地保存路径。
  /// * [width] 图片宽度（px）。
  /// * [height] 图片高度（px）。
  /// * [errCode] 截图成功的提示或失败的原因。
  ///  0：截图成功。< 0: 截图失败。
  ///  -1：写入文件失败或 JPEG 编码失败。-2：takeSnapshot 方法调用成功后 1 秒内没有发现指定用户的视频流。-3：takeSnapshot 方法调用过于频繁。
  final void Function(RtcConnection connection, int uid, String filePath,
      int width, int height, int errCode)? onSnapshotTaken;

  /// 直播场景下用户角色已切换回调。
  /// 该回调是由本地用户在加入频道后调用 setClientRole 改变用户角色触发的。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [oldRole] 切换前的角色： ClientRoleType 。
  /// * [newRole] 切换后的角色： ClientRoleType 。
  final void Function(RtcConnection connection, ClientRoleType oldRole,
      ClientRoleType newRole)? onClientRoleChanged;

  /// 直播场景下切换用户角色失败回调。
  /// 直播场景下，本地用户加入频道后调用 setClientRole [1/2] 切换用户角色失败时，SDK 会触发该回调，报告切换失败的原因和当前的用户角色。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [reason] 切换用户角色失败的原因。详见 ClientRoleChangeFailedReason 。
  /// * [currentRole] 当前用户角色。详见 ClientRoleType 。
  final void Function(
      RtcConnection connection,
      ClientRoleChangeFailedReason reason,
      ClientRoleType currentRole)? onClientRoleChangeFailed;

  /// @nodoc
  final void Function(MediaDeviceType deviceType, int volume, bool muted)?
      onAudioDeviceVolumeChanged;

  /// 旁路推流状态发生改变回调。
  /// 旁路推流状态发生改变时，SDK会触发该回调，并在回调中明确状态发生改变的 URL 地址及当前推流状态。该回调方便推流用户了解当前的推流状态；推流出错时，你可以通过返回的错误码了解出错的原因，方便排查问题。
  ///
  /// * [url] 推流状态发生改变的 URL 地址。
  /// * [state] 当前的推流状态，详见 RtmpStreamPublishState 。
  /// * [errCode] 推流错误信息，详见 RtmpStreamPublishErrorType 。
  final void Function(String url, RtmpStreamPublishState state,
      RtmpStreamPublishErrorType errCode)? onRtmpStreamingStateChanged;

  /// 旁路推流事件回调。
  ///
  ///
  /// * [url] 旁路推流 URL。
  /// * [eventCode] 旁路推流事件码。详见 RtmpStreamingEvent 。
  final void Function(String url, RtmpStreamingEvent eventCode)?
      onRtmpStreamingEvent;

  /// 旁路推流转码设置已被更新回调。
  /// setLiveTranscoding 方法中的直播参数 LiveTranscoding 更新时，onTranscodingUpdated 回调会被触发并向主播报告更新信息。首次调用 setLiveTranscoding 方法设置转码参数 LiveTranscoding 时，不会触发此回调。
  final void Function()? onTranscodingUpdated;

  /// 音频路由已发生变化回调。
  /// 该回调仅适用于 Android、iOS 和 macOS 平台。
  ///
  /// * [routing] 当前的音频路由。详见 AudioRoute 。
  final void Function(int routing)? onAudioRoutingChanged;

  /// 跨频道媒体流转发状态发生改变回调。
  /// 当跨频道媒体流转发状态发生改变时，SDK 会触发该回调，并报告当前的转发状态以及相关的错误信息。
  ///
  /// * [state] 跨频道媒体流转发状态。详见 ChannelMediaRelayState 。
  /// * [code] 跨频道媒体流转发出错的错误码。详见 ChannelMediaRelayError 。
  final void Function(
          ChannelMediaRelayState state, ChannelMediaRelayError code)?
      onChannelMediaRelayStateChanged;

  /// 跨频道媒体流转发事件回调。
  ///
  ///
  /// * [code] 跨频道媒体流转发事件码。详见 ChannelMediaRelayEvent 。
  final void Function(ChannelMediaRelayEvent code)? onChannelMediaRelayEvent;

  /// @nodoc
  final void Function(bool isFallbackOrRecover)?
      onLocalPublishFallbackToAudioOnly;

  /// @nodoc
  final void Function(int uid, bool isFallbackOrRecover)?
      onRemoteSubscribeFallbackToAudioOnly;

  /// 通话中远端音频流传输的统计信息回调。
  /// 弃用：请改用 onRemoteAudioStats 。该回调描述远端用户通话中端到端的网络统计信息，通过音频包计算，用客观的数据，如丢包、 网络延迟等，展示当前网络状态。通话中，当用户收到远端用户/主播发送的音频数据包后 ，会每 2 秒触发一次该回调。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [remoteUid] 用户 ID，指定是哪个用户/主播的音频包。
  /// * [delay] 音频包从发送端到接收端的延时（毫秒）。
  /// * [lost] 音频包从发送端到接收端的丢包率 (%)。
  /// * [rxKBitrate] 远端音频包的接收码率（Kbps）。
  final void Function(RtcConnection connection, int remoteUid, int delay,
      int lost, int rxKBitRate)? onRemoteAudioTransportStats;

  /// 通话中远端视频流传输的统计信息回调。
  /// 弃用：该回调已被废弃，请改用 onRemoteVideoStats 。该回调描述远端用户通话中端到端的网络统计信息，通过视频包计算，用客观的数据，如丢包、 网络延迟等，展示当前网络状态。通话中，当用户收到远端用户/主播发送的视频数据包后，会每 2 秒触发一次该回调。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [remoteUid] 用户 ID，指定是哪个用户/主播的视频包。
  /// * [delay] 视频包从发送端到接收端的延时（毫秒）。
  /// * [lost] 视频包从发送端到接收端的丢包率 (%)。
  /// * [rxKBitRate] 远端视频包的接收码率（Kbps）。
  final void Function(RtcConnection connection, int remoteUid, int delay,
      int lost, int rxKBitRate)? onRemoteVideoTransportStats;

  /// 网络连接状态已改变回调。
  /// 该回调在网络连接状态发生改变的时候触发，并告知用户当前的网络连接状态和引起网络状态改变的原因。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [state] 当前网络连接状态。详见 ConnectionStateType 。
  /// * [reason] 引起当前网络连接状态改变的原因。详见 ConnectionChangedReasonType 。
  final void Function(RtcConnection connection, ConnectionStateType state,
      ConnectionChangedReasonType reason)? onConnectionStateChanged;

  /// @nodoc
  final void Function(RtcConnection connection, WlaccMessageReason reason,
      WlaccSuggestAction action, String wlAccMsg)? onWlAccMessage;

  /// @nodoc
  final void Function(RtcConnection connection, WlAccStats currentStats,
      WlAccStats averageStats)? onWlAccStats;

  /// 本地网络类型发生改变回调。
  /// 本地网络连接类型发生改变时，SDK 会触发该回调，并在回调中明确当前的网络连接类型。 你可以通过该回调获取正在使用的网络类型；当连接中断时，该回调能辨别引起中断的原因是网络切换还是网络条件不好。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [type] 本地网络连接类型。详见 NetworkType 。
  final void Function(RtcConnection connection, NetworkType type)?
      onNetworkTypeChanged;

  /// 内置加密出错回调。
  /// 调用 enableEncryption 开启加密后， 如果发流端、收流端出现加解密出错，SDK 会触发该回调。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [errorType] 错误类型，详见 EncryptionErrorType 。
  final void Function(RtcConnection connection, EncryptionErrorType errorType)?
      onEncryptionError;

  /// 获取设备权限出错回调。
  /// 无法获取设备权限时，SDK 会触发该回调，报告哪个设备的权限无法获取。该回调仅适用于 Android 和 iOS。
  ///
  /// * [permissionType] 设备权限类型。详见 PermissionType 。
  final void Function(PermissionType permissionType)? onPermissionError;

  /// 本地用户成功注册 User Account 回调。
  /// 本地用户成功调用 registerLocalUserAccount 方法注册用户 User Account，或调用 joinChannelWithUserAccount 加入频道后，SDK 会触发该回调，并告知本地用户的 UID 和 User Account。
  ///
  /// * [uid] 本地用户的 ID。
  /// * [userAccount] 本地用户的 User Account。
  final void Function(int uid, String userAccount)? onLocalUserRegistered;

  /// 远端用户信息已更新回调。
  /// 远端用户加入频道后， SDK 会获取到该远端用户的 UID 和 User Account，然后缓存一个包含了远端用户 UID 和 User Account 的 Mapping 表，并在本地触发该回调。
  ///
  /// * [uid] 远端用户 ID。
  /// * [info] 标识用户信息的 UserInfo 对象，包含用户 UID 和 User Account。详见 UserInfo 类。
  final void Function(int uid, UserInfo info)? onUserInfoUpdated;

  /// @nodoc
  final void Function(RtcConnection connection, String requestId, bool success,
      UploadErrorReason reason)? onUploadLogResult;

  /// 音频订阅状态发生改变回调。
  ///
  ///
  /// * [channel] 频道名。
  /// * [uid] 远端用户的 ID。
  /// * [oldState] 之前的订阅状态，详见 StreamSubscribeState 。
  /// * [newState] 当前的订阅状态，详见 StreamSubscribeState。
  /// * [elapseSinceLastState] 两次状态变化时间间隔（毫秒）。
  final void Function(
      String channel,
      int uid,
      StreamSubscribeState oldState,
      StreamSubscribeState newState,
      int elapseSinceLastState)? onAudioSubscribeStateChanged;

  /// 视频订阅状态发生改变回调。
  ///
  ///
  /// * [channel] 频道名。
  /// * [uid] 远端用户的 ID。
  ///
  ///
  /// * [elapseSinceLastState] 两次状态变化时间间隔（毫秒）。
  final void Function(
      String channel,
      int uid,
      StreamSubscribeState oldState,
      StreamSubscribeState newState,
      int elapseSinceLastState)? onVideoSubscribeStateChanged;

  /// 音频发布状态改变回调。
  ///
  ///
  /// * [channel] 频道名。
  /// * [oldState] 之前的发布状态，详见 StreamPublishState 。
  /// * [newState] 当前的发布状态，详见 StreamPublishState。
  /// * [elapseSinceLastState] 两次状态变化时间间隔（毫秒）。
  final void Function(
      String channel,
      StreamPublishState oldState,
      StreamPublishState newState,
      int elapseSinceLastState)? onAudioPublishStateChanged;

  /// 视频发布状态改变回调。
  ///
  ///
  /// * [channel] 频道名。
  /// * [source] 视频源的类型。详见 VideoSourceType 。
  /// * [oldState] 之前的发布状态，详见 StreamPublishState 。
  /// * [newState] 当前的发布状态，详见 StreamPublishState。
  /// * [elapseSinceLastState] 两次状态变化时间间隔（毫秒）。
  final void Function(
      VideoSourceType source,
      String channel,
      StreamPublishState oldState,
      StreamPublishState newState,
      int elapseSinceLastState)? onVideoPublishStateChanged;

  /// 插件事件回调。
  /// 为监听插件事件，你需要注册该回调。
  ///
  /// * [value] 插件属性 Key 对应的值。
  /// * [key] 插件属性的 Key。
  /// * [provider] 提供插件的服务商名称。
  /// * [extName] 插件名称。
  final void Function(
          String provider, String extension, String key, String value)?
      onExtensionEvent;

  /// 插件启用回调。
  /// 当调用 enableExtension (true) 启用插件成功时，插件会触发该回调。
  ///
  /// * [provider] 提供插件的服务商名称。
  /// * [extName] 插件名称。
  final void Function(String provider, String extension)? onExtensionStarted;

  /// 插件禁用回调。
  /// 当调用 enableExtension (false) 禁用插件成功时，插件会触发该回调。
  ///
  /// * [extName] 插件名称。
  /// * [provider] 提供插件的服务商名称。
  final void Function(String provider, String extension)? onExtensionStopped;

  /// 插件出错回调。
  /// 当调用 enableExtension (true) 启用插件失败或者插件运行出错时， 插件会触发该回调并上报错误码和错误原因。
  ///
  /// * [provider] 提供插件的服务商名称。
  /// * [extension] 插件的名称。
  /// * [error] 错误码。详见插件服务商提供的插件文档。
  /// * [message] 错误原因。详见插件服务商提供的插件文档。
  final void Function(
          String provider, String extension, int error, String message)?
      onExtensionError;

  /// @nodoc
  final void Function(
          RtcConnection connection, int remoteUid, String userAccount)?
      onUserAccountUpdated;
}

/// 视频设备管理方法。
///
abstract class VideoDeviceManager {
  /// 获取系统中所有的视频设备列表。
  ///
  ///
  /// Returns
  /// 方法调用成功：返回一个 VideoDeviceInfo 数组，其中包含系统中所有视频设备。方法调用失败: 返回空列表。
  Future<List<VideoDeviceInfo>> enumerateVideoDevices();

  /// 通过设备 ID 指定视频采集设备。
  /// 插拔设备不会改变设备 ID。
  ///
  /// * [deviceIdUTF8] 设备 ID。可通过调用 enumerateVideoDevices 方法获取。最大长度为 MaxDeviceIdLengthType 。
  Future<void> setDevice(String deviceIdUTF8);

  /// 获取当前使用的视频采集设备。
  ///
  ///
  /// Returns
  /// 视频采集设备。
  Future<String> getDevice();

  /// 获取指定视频采集设备支持的视频格式数量。
  /// 视频采集设备可能支持多种视频格式，每一种格式都支持不同的视频帧宽度、视频帧高度、帧率组合。你可以通过调用该方法，获取指定的视频采集设备可支持多少种视频格式，然后调用 getCapability 获取指定视频格式下的具体视频帧信息。
  ///
  /// * [deviceIdUTF8] 视频采集设备的 ID。
  Future<void> numberOfCapabilities(String deviceIdUTF8);

  /// 获取视频采集设备在指定的视频格式下的详细视频帧信息。
  /// 在调用 numberOfCapabilities 获取视频采集设备支持的视频格式数量后，你可以调用该方法获取指定索引号支持的具体视频帧信息。
  ///
  /// * [deviceIdUTF8] 视频采集设备的 ID。
  /// * [deviceCapabilityNumber] 视频格式的索引号。如果 numberOfCapabilities 的返回值为 i，则该参数取值范围为[0,i)。
  ///
  /// Returns
  /// 指定视频格式的具体信息，包括宽度（px），高度（px）和帧率（fps）。详见 VideoFormat 。
  Future<VideoFormat> getCapability(
      {required String deviceIdUTF8, required int deviceCapabilityNumber});

  /// @nodoc
  Future<void> startDeviceTest(int hwnd);

  /// @nodoc
  Future<void> stopDeviceTest();

  /// 释放 VideoDeviceManager 对象占用的所有资源。
  ///
  Future<void> release();
}

/// RtcEngineContext 定义。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RtcEngineContext {
  /// @nodoc
  const RtcEngineContext(
      {this.appId,
      this.channelProfile,
      this.audioScenario,
      this.areaCode,
      this.logConfig,
      this.threadPriority,
      this.useExternalEglContext});

  /// Agora 为 app 开发者签发的 App ID。 使用同一个 App ID 的 app 才能进入同一个频道进行通话或直播。一个 App ID 只能用于创建一个 RtcEngine。如需更换 App ID，必须先调用 release 销毁当前 RtcEngine 再重新创建。
  @JsonKey(name: 'appId')
  final String? appId;

  /// 频道使用场景。详见 ChannelProfileType 。
  @JsonKey(name: 'channelProfile')
  final ChannelProfileType? channelProfile;

  /// 音频场景。详见 AudioScenarioType 。不同的音频场景下，设备的音量类型是不同的。
  ///
  @JsonKey(name: 'audioScenario')
  final AudioScenarioType? audioScenario;

  /// 服务器的访问区域。该功能为高级设置，适用于有访问安全限制的场景。支持的区域详见 AreaCode 。区域码支持位操作。
  @JsonKey(name: 'areaCode')
  final int? areaCode;

  /// SDK 日志文件的名称分别为：agorasdk.log、agorasdk.1.log、agorasdk.2.log、agorasdk.3.log、agorasdk.4.log。
  ///  API 调用日志文件的名称分别为：agoraapi.log、agoraapi.1.log、agoraapi.2.log、agoraapi.3.log、agoraapi.4.log。
  ///  每个 SDK 日志文件的默认大小为 1,024 KB；API 调用日志文件的默认大小为 2,048 KB。日志文件均为 UTF-8 编码。
  ///  最新的日志永远写在 agorasdk.log 和 agoraapi.log 中。
  ///  当 agorasdk.log 写满后，SDK 会按照以下顺序对日志文件进行操作： 删除 agorasdk.4.log 文件（如有）。
  ///  将agorasdk.3.log 重命名为 agorasdk.4.log。
  ///  将agorasdk.2.log 重命名为 agorasdk.3.log。
  ///  将agorasdk.1.log 重命名为 agorasdk.2.log。
  ///  新建 agorasdk.log 文件。 agoraapi.log 文件的覆盖规则与 agorasdk.log 相同。 设置 Agora SDK 输出的日志文件。详见 LogConfig 。默认情况下，SDK 会生成 5 个 SDK 日志文件和 5 个 API 调用日志文件，规则如下：
  @JsonKey(name: 'logConfig')
  final LogConfig? logConfig;

  /// @nodoc
  @JsonKey(name: 'threadPriority')
  final ThreadPriorityType? threadPriority;

  /// @nodoc
  @JsonKey(name: 'useExternalEglContext')
  final bool? useExternalEglContext;

  /// @nodoc
  factory RtcEngineContext.fromJson(Map<String, dynamic> json) =>
      _$RtcEngineContextFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RtcEngineContextToJson(this);
}

/// Metadata 观测器。
///
class MetadataObserver {
  /// @nodoc
  const MetadataObserver({
    this.onMetadataReceived,
  });

  /// 接收端已收到 metadata。
  ///
  ///
  /// * [metadata] 接收到的 metadata，详见 Metadata 。
  final void Function(Metadata metadata)? onMetadataReceived;
}

/// 观测器的 Metadata 类型。当前仅支持视频类型的 Metadata 。
///
@JsonEnum(alwaysCreate: true)
enum MetadataType {
  /// Metadata 类型未知。
  @JsonValue(-1)
  unknownMetadata,

  /// Metadata 类型为视频。
  @JsonValue(0)
  videoMetadata,
}

/// @nodoc
extension MetadataTypeExt on MetadataType {
  /// @nodoc
  static MetadataType fromValue(int value) {
    return $enumDecode(_$MetadataTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$MetadataTypeEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum MaxMetadataSizeType {
  /// @nodoc
  @JsonValue(-1)
  invalidMetadataSizeInByte,

  /// @nodoc
  @JsonValue(512)
  defaultMetadataSizeInByte,

  /// @nodoc
  @JsonValue(1024)
  maxMetadataSizeInByte,
}

/// @nodoc
extension MaxMetadataSizeTypeExt on MaxMetadataSizeType {
  /// @nodoc
  static MaxMetadataSizeType fromValue(int value) {
    return $enumDecode(_$MaxMetadataSizeTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$MaxMetadataSizeTypeEnumMap[this]!;
  }
}

/// 媒体附属信息。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Metadata {
  /// @nodoc
  const Metadata({this.uid, this.size, this.buffer, this.timeStampMs});

  /// 用户 ID。 对于接收者：发送该 Metadata 的远端用户的 ID。对于发送者：请忽略。
  @JsonKey(name: 'uid')
  final int? uid;

  /// 接收到的或发送的 Metadata 的缓存大小。
  @JsonKey(name: 'size')
  final int? size;

  /// 接收到的或发送的 Metadata 的缓存地址。
  @JsonKey(name: 'buffer', ignore: true)
  final Uint8List? buffer;

  /// Metadata 的时间戳，单位为毫秒。
  @JsonKey(name: 'timeStampMs')
  final int? timeStampMs;

  /// @nodoc
  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}

/// CDN 推流出错原因。
///
@JsonEnum(alwaysCreate: true)
enum DirectCdnStreamingError {
  /// 0：推流状态正常。
  @JsonValue(0)
  directCdnStreamingErrorOk,

  /// 1：一般性错误，没有明确原因。你可以尝试重新推流。
  @JsonValue(1)
  directCdnStreamingErrorFailed,

  /// 2：音频推流出错。例如，本地音频采集设备未正常工作、被其他进程占用或没有使用权限。
  @JsonValue(2)
  directCdnStreamingErrorAudioPublication,

  /// 3：视频推流出错。例如，本地视频采集设备未正常工作、被其他进程占用或没有使用权限。
  @JsonValue(3)
  directCdnStreamingErrorVideoPublication,

  /// 4：连接 CDN 失败。
  @JsonValue(4)
  directCdnStreamingErrorNetConnect,

  /// 5：URL 已用于推流。请使用新的 URL。
  @JsonValue(5)
  directCdnStreamingErrorBadName,
}

/// @nodoc
extension DirectCdnStreamingErrorExt on DirectCdnStreamingError {
  /// @nodoc
  static DirectCdnStreamingError fromValue(int value) {
    return $enumDecode(_$DirectCdnStreamingErrorEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$DirectCdnStreamingErrorEnumMap[this]!;
  }
}

/// 当前 CDN 推流状态。
///
@JsonEnum(alwaysCreate: true)
enum DirectCdnStreamingState {
  /// 0：初始状态，即推流尚未开始。
  @JsonValue(0)
  directCdnStreamingStateIdle,

  /// 1：正在推流中。当你调用 startDirectCdnStreaming 成功推流时，SDK 会返回该值。
  @JsonValue(1)
  directCdnStreamingStateRunning,

  /// 2：推流已正常结束。当你调用 stopDirectCdnStreaming 主动停止推流时，SDK 会返回该值。
  @JsonValue(2)
  directCdnStreamingStateStopped,

  /// 3：推流失败。你可以通过 onDirectCdnStreamingStateChanged 回调报告的信息排查问题，然后重新推流。
  @JsonValue(3)
  directCdnStreamingStateFailed,

  /// 4：尝试重新连接 Agora 服务器和 CDN。最多尝试重连 10 次，如仍未成功恢复连接，则推流状态变为 directCdnStreamingStateFailed。
  @JsonValue(4)
  directCdnStreamingStateRecovering,
}

/// @nodoc
extension DirectCdnStreamingStateExt on DirectCdnStreamingState {
  /// @nodoc
  static DirectCdnStreamingState fromValue(int value) {
    return $enumDecode(_$DirectCdnStreamingStateEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$DirectCdnStreamingStateEnumMap[this]!;
  }
}

/// 当前 CDN 推流的统计数据。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class DirectCdnStreamingStats {
  /// @nodoc
  const DirectCdnStreamingStats(
      {this.videoWidth,
      this.videoHeight,
      this.fps,
      this.videoBitrate,
      this.audioBitrate});

  /// 视频的宽度（px）。
  @JsonKey(name: 'videoWidth')
  final int? videoWidth;

  /// 视频的高度（px）。
  @JsonKey(name: 'videoHeight')
  final int? videoHeight;

  /// 当前视频帧率（fps）。
  @JsonKey(name: 'fps')
  final int? fps;

  /// 当前视频码率（bps）。
  @JsonKey(name: 'videoBitrate')
  final int? videoBitrate;

  /// 当前音频码率（bps）。
  @JsonKey(name: 'audioBitrate')
  final int? audioBitrate;

  /// @nodoc
  factory DirectCdnStreamingStats.fromJson(Map<String, dynamic> json) =>
      _$DirectCdnStreamingStatsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$DirectCdnStreamingStatsToJson(this);
}

/// DirectCdnStreamingEventHandler 接口类用于 SDK 向 app 发送 CDN 推流的事件通知，app 通过继承该接口类的方法获取 SDK 的事件通知。
///
class DirectCdnStreamingEventHandler {
  /// @nodoc
  const DirectCdnStreamingEventHandler({
    this.onDirectCdnStreamingStateChanged,
    this.onDirectCdnStreamingStats,
  });

  /// @nodoc
  final void Function(
      DirectCdnStreamingState state,
      DirectCdnStreamingError error,
      String message)? onDirectCdnStreamingStateChanged;

  /// @nodoc
  final void Function(DirectCdnStreamingStats stats)? onDirectCdnStreamingStats;
}

/// 主播端的媒体选项。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class DirectCdnStreamingMediaOptions {
  /// @nodoc
  const DirectCdnStreamingMediaOptions(
      {this.publishCameraTrack,
      this.publishMicrophoneTrack,
      this.publishCustomAudioTrack,
      this.publishCustomVideoTrack,
      this.publishMediaPlayerAudioTrack,
      this.publishMediaPlayerId,
      this.customVideoTrackId});

  /// 设置是否发布摄像头采集的视频。
  ///  true: 发布摄像头采集的视频。false:（默认）不发布摄像头采集的视频。
  @JsonKey(name: 'publishCameraTrack')
  final bool? publishCameraTrack;

  /// 设置是否发布麦克风采集的音频。
  ///  true: 发布麦克风采集的音频。false:（默认）不发布麦克风采集的音频。
  @JsonKey(name: 'publishMicrophoneTrack')
  final bool? publishMicrophoneTrack;

  /// 设置是否发布自定义采集的音频。 true: 发布自定义采集的音频。false:（默认）不发布自定义采集的音频。
  @JsonKey(name: 'publishCustomAudioTrack')
  final bool? publishCustomAudioTrack;

  /// 设置是否发布自定义采集的视频。 true: 发布自定义采集的视频。false:（默认）不发布自定义采集的视频。
  @JsonKey(name: 'publishCustomVideoTrack')
  final bool? publishCustomVideoTrack;

  /// @nodoc
  @JsonKey(name: 'publishMediaPlayerAudioTrack')
  final bool? publishMediaPlayerAudioTrack;

  /// @nodoc
  @JsonKey(name: 'publishMediaPlayerId')
  final int? publishMediaPlayerId;

  /// 调用 createCustomVideoTrack 方法返回的视频轨道 ID。默认值为 0。
  @JsonKey(name: 'customVideoTrackId')
  final int? customVideoTrackId;

  /// @nodoc
  factory DirectCdnStreamingMediaOptions.fromJson(Map<String, dynamic> json) =>
      _$DirectCdnStreamingMediaOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$DirectCdnStreamingMediaOptionsToJson(this);
}

/// Agora RTC SDK 的基础接口类，实现实时音视频的主要功能。
/// RtcEngine 提供了 app 调用的主要方法。
abstract class RtcEngine {
  /// 销毁 RtcEngine 对象。
  /// 该方法释放 Agora SDK 使用的所有资源。有些 app 只在用户需要时才进行实时音视频通信，不需要时则将资源释放出来用于其他操作， 该方法适用于此类情况。调用该方法后，你将无法再使用 SDK 的其它方法和回调。如需再次使用实时音视频通信功能， 你必须依次重新调用 createAgoraRtcEngine 和 initialize 方法创建一个新的 RtcEngine 对象。如需在销毁后再次创建 RtcEngine 对象，需要等待 release 方法执行结束后再创建实例。
  ///
  /// * [sync] true: 该方法为同步调用。需要等待 RtcEngine 资源释放后才能执行其他操作，所以我们建议在子线程中调用该方法，避免主线程阻塞。此外，我们不建议在 SDK 的回调中调用 release，否则由于 SDK 要等待回调返回才能回收相关的对象资源，会造成死锁。SDK 会自动检测这种死锁并转为异步调用，但是检测本身会消耗额外的时间。false: 该方法为异步调用。不需要等待 RtcEngine 资源释放后就能执行其他操作。使用异步调用时要注意，不要在调用该方法后立即卸载 SDK 动态库，否则可能会因为 SDK 的清理线程还没有退出而崩溃。
  Future<void> release({bool sync = false});

  /// 初始化 RtcEngine。
  /// RtcEngine 类的所有接口函数，如无特殊说明，都是异步调用，对接口的调用建议在同一个线程进行。请确保在调用其他 API 前先调用 createAgoraRtcEngine 和 initialize 创建并初始化 RtcEngine。SDK 只支持每个 app 创建一个 RtcEngine 实例。
  ///
  /// * [context]  RtcEngine 实例的配置。详见 RtcEngineContext 。
  ///
  /// Returns
  /// 方法调用成功，返回一个 RtcEngine 对象。方法调用失败，返回错误码。
  Future<void> initialize(RtcEngineContext context);

  /// 获取 SDK 版本。
  ///
  ///
  /// Returns
  /// SDKBuildInfo 对象。
  Future<SDKBuildInfo> getVersion();

  /// 获取警告或错误描述。
  ///
  ///
  /// * [code] SDK 报告的错误码或警告码。
  ///
  /// Returns
  /// 具体的错误或警告描述。
  Future<String> getErrorDescription(int code);

  /// 加入频道后更新频道媒体选项。
  ///
  ///
  /// * [options ] 频道媒体选项，详见 ChannelMediaOptions 。
  Future<void> updateChannelMediaOptions(ChannelMediaOptions options);

  /// 更新 Token。
  /// 该方法用于更新 Token。Token 会在一定时间后失效。在以下两种情况下，app 应重新获取 Token，然后调用该方法传入新的 Token，否则 SDK 无法和服务器建立连接： 发生 onTokenPrivilegeWillExpire 回调时。 onConnectionStateChanged 回调报告 connectionChangedTokenExpired(9) 时。
  ///
  /// * [token] 新的 Token。
  Future<void> renewToken(String token);

  /// 设置频道场景。
  /// SDK 初始化后默认的频道场景为直播场景。你可以调用该方法设置 Agora 频道的使用场景。Agora SDK 会针对不同的使用场景采用不同的优化策略，如通信场景偏好流畅，直播场景偏好画质。为保证实时音视频质量，相同频道内的用户必须使用同一种频道场景。该方法必须在 joinChannel [2/2] 前调用和进行设置，进入频道后无法再设置。
  ///
  /// * [profile] 频道使用场景。详见 ChannelProfileType 。
  Future<void> setChannelProfile(ChannelProfileType profile);

  /// 停止语音通话回路测试。
  ///
  Future<void> stopEchoTest();

  /// 启用视频模块。
  /// 该方法可以在加入频道前或者通话中调用，在加入频道前调用则自动开启视频模块；在通话中调用则由音频模式切换为视频模式。调用 disableVideo 方法可关闭视频模式。成功调用该方法后，远端会触发 onRemoteVideoStateChanged 回调。该方法设置的是内部引擎为启用状态，在离开频道后仍然有效。该方法重置整个引擎，响应时间较慢，因此声网建议使用如下方法来控制视频模块： enableLocalVideo : 是否启动摄像头采集并创建本地视频流。 muteLocalVideoStream : 是否发布本地视频流。 muteRemoteVideoStream : 是否接收并播放远端视频流。 muteAllRemoteVideoStreams : 是否接收并播放所有远端视频流。
  Future<void> enableVideo();

  /// 关闭视频模块。
  /// 该方法用于关闭视频模块，可以在加入频道前或者通话中调用，在加入频道前调用，则自动开启纯音频模式，在通话中调用则由视频模式切换为纯音频模式。 调用 enableVideo 方法可开启视频模式。成功调用该方法后，远端会触发 onUserEnableVideo (false) 回调。该方法设置的是内部引擎为禁用状态，在离开频道后仍然有效。该方法重置整个引擎，响应时间较慢，因此声网建议使用如下方法来控制视频模块： enableLocalVideo : 是否启动摄像头采集并创建本地视频流。 muteLocalVideoStream : 是否发布本地视频流。 muteRemoteVideoStream : 是否接收并播放远端视频流。 muteAllRemoteVideoStreams : 是否接收并播放所有远端视频流。
  Future<void> disableVideo();

  /// 开始通话前网络质量探测。
  /// 开始通话前网络质量探测，向用户反馈上下行网络的带宽、丢包、网络抖动和往返时延数据。
  ///  启用该方法后，SDK 会依次返回如下 2 个回调：
  ///  onLastmileQuality ，视网络情况约 2 秒内返回。该回调通过打分反馈上下行网络质量，更贴近用户的主观感受。
  ///  onLastmileProbeResult ，视网络情况约 30 秒内返回。该回调通过具体数据反馈上下行网络质量，更加客观。 该方法主要用于以下两种场景：
  ///  用户加入频道前，可以调用该方法判断和预测目前的上行网络质量是否足够好。直播场景下，当用户角色想由观众切换为主播时，可以调用该方法判断和预测目前的上行网络质量是否足够好。
  ///  调用该方法后，在收到 onLastmileQuality 和 onLastmileProbeResult 回调之前请不要调用其他方法，否则可能会由于 API 操作过于频繁导致此方法无法执行。
  ///  在直播场景中，如果本地用户为主播，请勿加入频道后调用该方法。
  ///
  /// * [config] Last mile 网络探测配置，详见 LastmileProbeConfig 。
  ///
  Future<void> startLastmileProbeTest(LastmileProbeConfig config);

  /// 停止通话前网络质量探测。
  ///
  Future<void> stopLastmileProbeTest();

  /// 设置视频编码属性。
  /// 设置本地视频的编码属性。该方法在加入频道前后都能调用。如果用户在加入频道后不需要重新设置视频编码属性，则
  ///  Agora 建议在 enableVideo 前调用该方法，可以加快首帧出图的时间。
  ///
  /// * [config] 视频编码参数配置。详见 VideoEncoderConfiguration 。
  Future<void> setVideoEncoderConfiguration(VideoEncoderConfiguration config);

  /// 设置美颜效果选项。
  /// 开启本地美颜功能，并设置美颜效果选项。请在 enableVideo 或 startPreview 之后调用该方法。
  ///
  /// * [type] 媒体源类型，详见 MediaSourceType 。
  /// * [enabled] 是否开启美颜功能： true: 开启。false:（默认）关闭。
  /// * [options] 美颜选项，详细定义见 BeautyOptions 。
  Future<void> setBeautyEffectOptions(
      {required bool enabled,
      required BeautyOptions options,
      MediaSourceType type = MediaSourceType.primaryCameraSource});

  /// 设置暗光增强功能。
  /// 暗光增强功能可以在光线亮度偏低（如背光、阴天、暗场景）和亮度不均匀的环境下自适应调整视频画面的亮度值，恢复或凸显图像的细节信息，最终提升视频图像的整体视觉效果。你可以调用该方法开启暗光增强功能并设置暗光增强的效果。请在 enableVideo 后调用该方法。暗光增强对设备性能有一定要求。开启暗光增强后，如果设备出现严重发烫等问题，Agora 推荐你将暗光增强等级修改为消耗性能较少的等级或关闭暗光增强功能。该方法和 setExtensionProperty 均可开启暗光增强功能： 当你使用 SDK 采集视频时，Agora 推荐使用该方法（该方法只可对 SDK 采集的视频起作用）。当你使用外部的视频源实现自定义视频采集，或者将外部视频源发送给 SDK 时，Agora 推荐使用 setExtensionProperty 方法。
  ///
  /// * [enabled] 是否开启暗光增强功能：
  ///  true: 开启暗光增强功能。false:（默认）关闭暗光增强功能。
  /// * [options] 暗光增强选项，用于设置暗光增强的效果。详见 LowlightEnhanceOptions 。
  /// * [type] 媒体资源类型，详见 MediaSourceType 。
  Future<void> setLowlightEnhanceOptions(
      {required bool enabled,
      required LowlightEnhanceOptions options,
      MediaSourceType type = MediaSourceType.primaryCameraSource});

  /// 设置视频降噪功能。
  /// 采光不足的环境和低端视频采集设备会使视频图像含有明显的噪声，影响视频画质。在实时互动场景下，视频噪声还会在编码过程中占用码流资源并降低编码效率。你可以调用该方法开启视频降噪功能并设置视频降噪的效果。请在 enableVideo 后调用该方法。视频降噪对设备性能有一定要求。开启视频降噪后，如果设备出现严重发烫等问题，Agora 推荐你将视频降噪等级修改为消耗性能较少的等级或关闭视频降噪功能。该方法和 setExtensionProperty 均可开启视频降噪功能： 当你使用 SDK 采集视频时，Agora 推荐使用该方法（该方法只可对 SDK 采集的视频起作用）。当你使用外部的视频源实现自定义视频采集，或者将外部视频源发送给 SDK 时，Agora 推荐使用 setExtensionProperty 方法。
  ///
  /// * [type] 媒体资源类型，详见 MediaSourceType 。
  /// * [enabled]  是否开启视频降噪功能： true: 开启视频降噪功能。false:（默认）关闭视频降噪功能。
  /// * [options] 视频降噪选项，用于设置视频降噪的效果。详见 VideoDenoiserOptions 。
  Future<void> setVideoDenoiserOptions(
      {required bool enabled,
      required VideoDenoiserOptions options,
      MediaSourceType type = MediaSourceType.primaryCameraSource});

  /// 设置色彩增强功能。
  /// 摄像头采集到的视频画面可能存在色彩失真的现象。色彩增强功能可以通过智能调节饱和度和对比度等视频特性，提升视频色彩丰富度和色彩还原度，最终使视频画面更生动。你可以调用该方法开启色彩增强功能并设置色彩增强的效果。请在 enableVideo 后调用该方法。色彩增强对设备性能有一定要求。开启色彩增强后，如果设备出现严重发烫等问题，Agora 推荐你将色彩增强等级修改为消耗性能较少的等级或关闭色彩增强功能。该方法和 setExtensionProperty 均可开启色彩增强功能：
  ///  当你使用 SDK 采集视频时，Agora 推荐使用该方法（该方法只可对 SDK 采集的视频起作用）。当你使用外部的视频源实现自定义视频采集，或者将外部视频源发送给 SDK 时，Agora 推荐使用 setExtensionProperty 方法。
  ///
  /// * [type] 媒体资源类型，详见 MediaSourceType 。
  /// * [enabled] 是否开启色彩增强功能：
  ///  true：开启色彩增强功能。false：（默认）关闭色彩增强功能。
  /// * [options] 色彩增强选项，用于设置色彩增强的效果。详见 ColorEnhanceOptions 。
  Future<void> setColorEnhanceOptions(
      {required bool enabled,
      required ColorEnhanceOptions options,
      MediaSourceType type = MediaSourceType.primaryCameraSource});

  /// 开启/关闭虚拟背景。
  /// 虚拟背景功能支持你使用自定义的背景图替代本地用户原来的背景图或者将背景虚化处理。成功开启虚拟背景功能后，频道内所有用户都能看到自定义的背景。请在 enableVideo 或 startPreview 之后调用该方法。该功能对设备性能要求较高，Agora 推荐你在搭载如下芯片的设备上使用： 骁龙 700 系列 750G 及以上骁龙 800 系列 835 及以上天玑 700 系列 720 及以上麒麟 800 系列 810 及以上麒麟 900 系列 980 及以上搭载 A9 及以上芯片的如下设备： iPhone 6S 及以上iPad Air 第三代及以上iPad 第五代及以上iPad Pro 第一代及以上iPad mini 第五代及以上Agora 建议你在满足如下条件的场景中使用该功能： 使用高清摄像设备、摄像环境光照均匀。摄像画面中，物件较少，用户的人像为半身人像且基本无遮挡，背景色较单一且与用户着装颜色不同。
  ///
  /// * [enabled] 是否开启虚拟背景： true: 开启。false: 关闭。
  /// * [backgroundSource] 自定义的背景图。详见 VirtualBackgroundSource 。为将自定义背景图的分辨率与 SDK 的视频采集分辨率适配，SDK 会在保证自定义背景图不变形的前提下，对自定义背景图进行缩放和裁剪。
  Future<void> enableVirtualBackground(
      {required bool enabled,
      required VirtualBackgroundSource backgroundSource,
      required SegmentationProperty segproperty,
      MediaSourceType type = MediaSourceType.primaryCameraSource});

  /// 开启或关闭远端视频超分辨率。
  /// 该功能可以有效提升本地用户看到的远端视频画面的分辨率，即：将接收到的指定远端用户的视频宽和高（像素）均扩大为 2 倍。调用该方法后，通过 onRemoteVideoStats 回调中的远端视频统计数据（ RemoteVideoStats ），确认超分辨率是否成功开启：如果参数 superResolutionType >0：超分辨率已开启。如果参数 superResolutionType =0：超分辨率未开启。超分辨率功能会额外耗费系统资源。为平衡视觉体验和系统消耗，只可以对一个远端用户开启超分辨率，并且远端用户视频的原始分辨率在 Android 设备上不能超过 640 × 360，在 iOS 设备上不能超过 640 × 480。该方法仅适用于 Android 和 iOS 平台。调用该方法前，请确保你已经集成相应的动态库：
  ///  Android: libagora_super_resolution_extension.soiOS: AgoraSuperResolutionExtension.xcframework该方法对用户设备具有一定要求，Agora 推荐你使用如下或更好的设备：
  ///  Android:
  ///  VIVO：V1821A，NEX S，1914A，1916A，1962A，1824BA，X60，X60 ProOPPO：PCCM00，Find X3OnePlus：A6000Xiaomi：Mi 8，Mi 9，Mi 10，Mi 11，MIX3，Redmi K20 ProSAMSUNG：SM-G9600，SM-G9650，SM-N9600，SM-G9708，SM-G960U，SM-G9750，S20，S21HUAWEI：SEA-AL00，ELE-AL00，VOG-AL00，YAL-AL10，HMA-AL00，EVR-AN00，nova 4，nova 5 Pro，nova 6 5G，nova 7 5G，Mate 30，Mate 30 Pro，Mate 40，Mate 40 Pro，P40，P40 Pro，华为平板 M6，MatePad 10.8iOS:
  ///  iPhone XRiPhone XSiPhone XS MaxiPhone 11iPhone 11 ProiPhone 11 Pro MaxiPhone 12iPhone 12 miniiPhone 12 ProiPhone 12 Pro MaxiPhone 12 SE（第二代）iPad Pro 11-inch（第三代）iPad Pro 12.9-inch（第三代）iPad Air（第三代）iPad Air（第四代）
  ///
  /// * [userId] 远端用户 ID。
  /// * [enable] 是否对远端视频开启超分辨率：
  ///  true: 开启。false: 关闭。
  Future<void> enableRemoteSuperResolution(
      {required int userId, required bool enable});

  /// 初始化远端用户视图。
  /// 该方法绑定远端用户和显示视图，并设置远端用户视图在本地显示时的渲染模式和镜像模式，只影响本地用户看到的视频画面。调用该方法时需要指定远端视频的用户 ID，一般可以在进频道前提前设置好。如果无法在加入频道前得到远端用户的 ID，可以在收到 onUserJoined 回调时调用该方法。如需解除某个远端用户的绑定视图，可以调用该方法并将 view 设置为空。离开频道后，SDK 会清除远端用户视图的绑定关系。如果你希望在通话中更新远端用户视图的渲染或镜像模式，请使用 setRemoteRenderMode 方法。如果你使用了 Agora 录制服务，录制服务会作为一个哑客户端加入频道，因此也会触发 onUserJoined 回调。由于录制服务不会发送视频流，app 无需为它绑定视图。如果 app 无法识别哑客户端，可以在收到 onFirstRemoteVideoDecoded 回调时再绑定远端用户视图。
  ///
  /// * [canvas] 远端视频显示属性。详见 VideoCanvas 。
  Future<void> setupRemoteVideo(VideoCanvas canvas);

  /// 初始化本地视图。
  /// 该方法初始化本地视图并设置本地用户视频显示属性，只影响本地用户看到的视频画面，不影响本地发布视频。调用该方法绑定本地视频流的显示视窗(view)，并设置本地用户视图的渲染模式和镜像模式。在 App 开发中，通常在初始化后调用该方法进行本地视频设置，然后再加入频道。退出频道后，绑定仍然有效，如果需要解除绑定，可以调用该方法将参数 view 设为 NULL。该方法在加入频道前后都能调用。如果你希望在通话中更新本地用户视图的渲染或镜像模式，请使用 setLocalRenderMode 方法。
  ///
  /// * [canvas] 本地视频显示属性。详见 VideoCanvas 。
  Future<void> setupLocalVideo(VideoCanvas canvas);

  /// 启用音频模块。
  /// 启用音频模块（默认为开启状态）。该方法设置音频模块为启用状态，在频道内和频道外均可调用。在离开频道后仍然有效。该方法开启整个音频模块，响应时间较慢，因此 Agora 建议使用如下方法来控制音频模块： enableLocalAudio : 是否启动麦克风采集并创建本地音频流。 muteLocalAudioStream : 是否发布本地音频流。 muteRemoteAudioStream : 是否接收并播放远端音频流。 muteAllRemoteAudioStreams : 是否接收并播放所有远端音频流。
  Future<void> enableAudio();

  /// 关闭音频模块。
  /// 该方法设置内部引擎为禁用状态，在频道内和频道外均可调用。离开频道后仍然有效。该方法重置整个引擎，响应时间较慢，因此声网建议使用如下方法来控制音频模块： enableLocalAudio : 是否启动麦克风采集并创建本地音频流。 muteLocalAudioStream : 是否发布本地音频流。 muteRemoteAudioStream : 是否接收并播放远端音频流。 muteAllRemoteAudioStreams : 是否接收并播放所有远端音频流。
  Future<void> disableAudio();

  /// 设置音频场景。
  /// 该方法在加入频道前后均可调用。
  ///
  /// * [scenario] 音频场景。详见 AudioScenarioType 。不同的音频场景下，设备的音量类型是不同的。
  Future<void> setAudioScenario(AudioScenarioType scenario);

  /// 开关本地音频采集。
  /// 当用户加入频道时，音频功能默认是开启的。该方法可以关闭或重新开启本地音频功能，即停止或重新开始本地音频采集。该方法不影响接收远端音频流， enableLocalAudio (false) 适用于只听不发的用户场景。音频功能关闭或重新开启后，会收到 onLocalAudioStateChanged 回调，并报告 localAudioStreamStateStopped(0) 或 localAudioStreamStateRecording(1)。 该方法与 muteLocalAudioStream 的区别在于： enableLocalAudio: 开启或关闭本地音频采集及处理。使用 enableLocalAudio 关闭或开启本地采集后，本地听远端播放会有短暂中断。muteLocalAudioStream: 停止或继续发送本地音频流。该方法在加入频道前后均可调用。在加入频道前调用只能设置设备状态，在加入频道后才会立即生效。
  ///
  /// * [enabled] true: 重新开启本地音频功能，即开启本地音频采集（默认）；false: 关闭本地音频功能，即停止本地音频采集。
  Future<void> enableLocalAudio(bool enabled);

  /// 取消或恢复发布本地音频流。
  /// 该方法不影响音频采集状态，因为没有禁用音频采集设备。
  ///
  /// * [mute] 是否取消发布本地音频流。 true: 取消发布。false:（默认）发布。
  Future<void> muteLocalAudioStream(bool mute);

  /// 取消或恢复订阅所有远端用户的音频流。
  /// 成功调用该方法后，本地用户会取消或恢复订阅所有远端用户的音频流，包括在调用该方法后加入频道的用户的音频流。该方法需要在加入频道后调用。如果需要在加入频道前设置默认不订阅远端用户音频流，可以在调用 joinChannel [2/2] 加入频道时设置 autoSubscribeAudio 为 false。
  ///
  /// * [mute] 是否取消订阅所有远端用户的音频流： true: 取消订阅所有远端用户的音频流。false:（默认）订阅所有远端用户的音频流。
  Future<void> muteAllRemoteAudioStreams(bool mute);

  /// 默认取消或恢复订阅远端用户的音频流。
  /// 该方法需要在加入频道后调用。调用成功后，本地用户取消或恢复订阅调用时刻之后加入频道的远端用户。取消订阅音频流后，如果需要恢复订阅频道内的远端，可以进行如下操作：
  ///  如果需要恢复订阅单个用户的音频流，调用 muteRemoteAudioStream (false)，并指定你想要订阅的远端用户 ID。如果想恢复订阅多个用户的音频流，则需要多次调用 muteRemoteAudioStream (false)。
  ///
  /// * [mute] 是否默认取消订阅远端用户的音频流： true：默认取消订阅远端用户的音频流。false：（默认）默认订阅远端用户的音频流。
  Future<void> setDefaultMuteAllRemoteAudioStreams(bool mute);

  /// 取消或恢复订阅指定远端用户的音频流。
  /// 该方法需要在加入频道后调用。
  ///
  /// * [uid] 指定用户的用户 ID。
  /// * [mute] 是否取消订阅指定远端用户的音频流。
  ///  true: 取消订阅指定用户的音频流。false:（默认）订阅指定用户的音频流。
  Future<void> muteRemoteAudioStream({required int uid, required bool mute});

  /// 取消或恢复发布本地视频流。
  /// 成功调用该方法后，远端会触发 onUserMuteVideo 回调。相比于 enableLocalVideo (false) 用于控制本地视频流发送的方法，该方法响应速度更快。该方法不影响视频采集状态，没有禁用摄像头。
  ///
  /// * [mute] 是否取消发送本地视频流。
  ///  true: 取消发送本地视频流。false: （默认）发送本地视频流。
  Future<void> muteLocalVideoStream(bool mute);

  /// 开关本地视频采集。
  /// 该方法禁用或重新启用本地视频采集，不影响接收远端视频。调用 enableVideo 后，本地视频采集即默认开启。你可以调用 enableLocalVideo (false) 关闭本地视频采集。关闭后如果想要重新开启，则可调用 enableLocalVideo(true)。成功禁用或启用本地视频采集后，远端会触发 onRemoteVideoStateChanged 回调。该方法在加入频道前后都能调用。该方法设置内部引擎为启用状态，在离开频道后仍然有效。
  ///
  /// * [enabled] 是否开启本地视频采集。true:（默认）开启本地视频采集。false: 关闭本地视频采集。关闭后，远端用户会接收不到本地用户的视频流；但本地用户依然可以接收远端用户的视频流。设置为 false 时，该方法不需要本地有摄像头。
  Future<void> enableLocalVideo(bool enabled);

  /// 取消或恢复订阅所有远端用户的视频流。
  /// 成功调用该方法后，本地用户会取消或恢复订阅所有远端用户的视频流，包括在调用该方法后加入频道的用户的视频流。该方法需要在加入频道后调用。如果需要在加入频道前设置默认不订阅远端用户视频流，可以在调用 joinChannel [2/2] 加入频道时设置 autoSubscribeVideo 为 false。
  ///
  /// * [mute] 是否取消订阅所有远端用户的视频流。
  ///  true: 取消订阅所有用户的视频流。false:（默认）订阅所有用户的视频流。
  Future<void> muteAllRemoteVideoStreams(bool mute);

  /// 默认取消或恢复订阅远端用户的视频流。
  /// 该方法需要在加入频道后调用。调用成功后，本地用户取消或恢复订阅调用时刻之后加入频道的远端用户。取消订阅视频流后，如果需要恢复订阅频道内的远端用户，可以进行如下操作：
  ///  如果需要恢复订阅单个用户的视频流，调用 muteRemoteVideoStream (false)，并指定你想要订阅的远端用户 ID。如果想恢复订阅多个用户的视频流，则需要多次调用 muteRemoteVideoStream(false)。
  ///
  /// * [mute] 是否默认取消订阅远端用户的视频流： true: 默认取消订阅。false:（默认）默认订阅。
  Future<void> setDefaultMuteAllRemoteVideoStreams(bool mute);

  /// 取消或恢复订阅指定远端用户的视频流。
  /// 该方法需要在加入频道后调用。
  ///
  /// * [uid] 指定用户的用户 ID。
  /// * [mute] 是否取消订阅指定远端用户的视频流。 true: 取消订阅指定用户的视频流。false: （默认）订阅指定用户的视频流。
  Future<void> muteRemoteVideoStream({required int uid, required bool mute});

  /// 设置订阅的视频流类型。
  /// 在网络条件受限的情况下，如果发送端没有调用 enableDualStreamMode (false) 关闭双流模式，接收端可以选择接收大流还是小流。其中，大流为高分辨率高码率的视频流，小流则是低分辨率低码率的视频流。
  ///  正常情况下，用户默认接收大流。如需接收小流，可以调用本方法进行切换。SDK 会根据视频窗口的大小动态调整对应视频流的大小，以节约带宽和计算资源。视频小流默认的宽高比和视频大流的宽高比一致。根据当前大流的宽高比，系统会自动分配小流的分辨率、帧率及码率。
  ///  调用本方法的执行结果将在 onApiCallExecuted 中返回。 该方法在加入频道前后都能调用。如果既调用了 setRemoteVideoStreamType ，也调用了 setRemoteDefaultVideoStreamType ，则 SDK 以 setRemoteVideoStreamType 中的设置为准。
  ///
  /// * [uid] 用户 ID。
  /// * [streamType] 视频流类型: VideoStreamType 。
  Future<void> setRemoteVideoStreamType(
      {required int uid, required VideoStreamType streamType});

  /// @nodoc
  Future<void> setRemoteVideoSubscriptionOptions(
      {required int uid, required VideoSubscriptionOptions options});

  /// 设置默认订阅的视频流类型。
  /// 在网络条件受限的情况下，如果发送端没有调用 enableDualStreamMode (false) 关闭双流模式，接收端可以选择接收大流还是小流。其中，大流为高分辨率高码率的视频流，小流则是低分辨率低码率的视频流。正常情况下，用户默认接收大流。如需默认接收所有用户的视频小流，可以调用本方法进行切换。SDK 会根据视频窗口的大小动态调整对应视频流的大小，以节约带宽和计算资源。视频小流默认的宽高比和视频大流的宽高比一致。根据当前大流的宽高比，系统会自动分配小流的分辨率、帧率及码率。调用本方法的执行结果将在 onApiCallExecuted 中返回。该方法只能在加入频道前调用。Agora 不支持你在加入频道后修改默认订阅的视频流类型。如果你既调用了该方法，也调用了 setRemoteVideoStreamType ，则 SDK 以 setRemoteVideoStreamType 中的设置为准。
  ///
  /// * [streamType] 默认订阅的视频流类型: VideoStreamType 。
  Future<void> setRemoteDefaultVideoStreamType(VideoStreamType streamType);

  /// 设置音频订阅黑名单。
  /// 你可以调用该方法指定不订阅的音频流。该方法在加入频道前后均可调用。音频订阅黑名单不受 muteRemoteAudioStream 、 muteAllRemoteAudioStreams 以及 ChannelMediaOptions 中的 autoSubscribeAudio 影响。设置订阅黑名单后，如果离开当前频道后再重新加入频道，黑名单依然生效。如果某个用户同时在音频订阅黑名单和白名单中，仅订阅黑名单生效。
  ///
  /// * [uidList] 订阅黑名单的用户 ID 列表。如果你想指定不订阅某一发流用户的音频流，将该用户的 ID 加入此列表中。如果你想要将某一用户从订阅黑名单中移除，需要重新调用 setSubscribeAudioBlacklist 方法更新订阅黑名单的用户 ID 列表，使其不包含你想移除的用户的 uid。
  /// * [uidNumber] 黑名单用户 ID 列表中的用户数量。
  Future<void> setSubscribeAudioBlacklist(
      {required List<int> uidList, required int uidNumber});

  /// 设置音频订阅白名单。
  /// 你可以调用该方法指定想要订阅的音频流。如果某个用户同时在音频订阅黑名单和白名单中，仅订阅黑名单生效。该方法在加入频道前后均可调用。音频订阅白名单不受 muteRemoteAudioStream 、 muteAllRemoteAudioStreams 以及 ChannelMediaOptions 中的 autoSubscribeAudio 的影响。设置订阅白名单后，如果离开当前频道后再重新加入频道，白名单依然生效。
  ///
  /// * [uidList] 音频订阅白名单的用户 ID 列表。如果你想指定订阅某一发流用户的音频流，将该用户的 ID 加入此列表中。如果你想要将某一用户从订阅白名单中移除，需要重新调用 setSubscribeAudioWhitelist 方法更新音频订阅白名单的用户 ID 列表，使其不包含你想移除的用户的 uid。
  /// * [uidNumber] 白名单用户 ID 列表中的用户数量。
  Future<void> setSubscribeAudioWhitelist(
      {required List<int> uidList, required int uidNumber});

  /// 设置视频订阅黑名单。
  /// 你可以调用该方法指定不订阅的视频流。如果某个用户同时在音频订阅黑名单和白名单中，仅订阅黑名单生效。设置订阅黑名单后，如果离开当前频道后再重新加入频道，黑名单依然生效。该方法在加入频道前后均可调用。视频订阅黑名单不受 muteRemoteVideoStream 、 muteAllRemoteVideoStreams 以及 ChannelMediaOptions 中的 autoSubscribeVideo 的影响。
  ///
  /// * [uidNumber] 黑名单用户 ID 列表中的用户数量。
  /// * [uidList] 视频订阅黑名单的用户 ID 列表。如果你想指定不订阅某一发流用户的视频流，将该用户的 ID 加入此列表中。如果你想要将某一用户从订阅黑名单中移除，需要重新调用 setSubscribeVideoBlacklist 方法更新订阅黑名单的用户 ID 列表，使其不包含你想移除的用户的 uid。
  Future<void> setSubscribeVideoBlacklist(
      {required List<int> uidList, required int uidNumber});

  /// 设置视频订阅白名单。
  /// 你可以调用该方法指定想要订阅的视频流。如果某个用户同时在音频订阅黑名单和白名单中，仅订阅黑名单生效。设置订阅白名单后，如果离开当前频道后再重新加入频道，白名单依然生效。
  ///  该方法在加入频道前后均可调用。视频订阅白名单不受 muteRemoteVideoStream 、 muteAllRemoteVideoStreams 以及 ChannelMediaOptions 中的 autoSubscribeVideo 的影响。
  ///
  /// * [uidNumber] 白名单用户 ID 列表中的用户数量。
  /// * [uidList] 视频订阅白名单的用户 ID 列表。如果你想指定仅订阅某一发流用户的视频流，将该用户的 ID 加入此列表中。如果你想要将某一用户从订阅白名单中移除，需要重新调用 setSubscribeVideoWhitelist 方法更新音频订阅白名单的用户 ID 列表，使其不包含你想移除的用户的 uid。
  Future<void> setSubscribeVideoWhitelist(
      {required List<int> uidList, required int uidNumber});

  /// 启用用户音量提示。
  /// 该方法允许 SDK 定期向 app 报告本地发流用户和瞬时音量最高的远端用户（最多 3 位）的音量相关信息。启用该方法后，只要频道内有发流用户， SDK 会在加入频道后按设置的时间间隔触发 onAudioVolumeIndication 回调。该方法在加入频道前后都能调用。
  ///
  /// * [interval] 指定音量提示的时间间隔： ≤ 0: 禁用音量提示功能。> 0: 返回音量提示的间隔，单位为毫秒。该参数需要设为 200 的整数倍。如果取值低于 200，SDK 会自动调整为 200。
  /// * [smooth] 平滑系数，指定音量提示的灵敏度。取值范围为 [0,10]，建议值为 3。数字越大，波动越灵敏；数字越小，波动越平滑。
  /// * [reportVad] true：开启本地人声检测功能。开启后，onAudioVolumeIndication 回调的 vad 参数会报告是否在本地检测到人声。false：（默认）关闭本地人声检测功能。除引擎自动进行本地人声检测的场景外，onAudioVolumeIndication 回调的 vad 参数不会报告是否在本地检测到人声。
  Future<void> enableAudioVolumeIndication(
      {required int interval, required int smooth, required bool reportVad});

  /// 注册音频编码数据观测器。
  /// 请在加入频道后调用该方法。由于该方法和 startAudioRecording 都会设置音频内容和音质，Agora 不推荐该方法和 startAudioRecording 一起使用。否则，只有后调用的方法会生效。
  ///
  /// * [config] 编码后音频的观测器设置。详见 AudioEncodedFrameObserverConfig 。
  /// * [observer] 编码后音频的观测器。详见 AudioEncodedFrameObserver 。
  void registerAudioEncodedFrameObserver(
      {required AudioEncodedFrameObserverConfig config,
      required AudioEncodedFrameObserver observer});

  /// 停止客户端录音。
  ///
  Future<void> stopAudioRecording();

  /// 创建媒体播放器。
  ///
  ///
  /// Returns
  /// 方法调用成功：返回 MediaPlayer 对象。方法调用失败：返回空指针。
  Future<MediaPlayer> createMediaPlayer();

  /// 销毁媒体播放器。
  ///
  Future<void> destroyMediaPlayer(MediaPlayer mediaPlayer);

  /// 停止播放音乐文件。
  /// 该方法停止播放音乐文件。请在频道内调用该方法。
  Future<void> stopAudioMixing();

  /// 暂停播放音乐文件。
  /// 请在加入频道后调用该方法。
  Future<void> pauseAudioMixing();

  /// 恢复播放音乐文件。
  /// 该方法恢复混音，继续播放音乐文件。请在频道内调用该方法。
  Future<void> resumeAudioMixing();

  /// 指定当前音乐文件的播放音轨。
  /// 获取音乐文件的音轨数量后，你可以调用该方法指定任一音轨进行播放。例如，如果一个多音轨文件的不同音轨存放了不同语言的歌曲，则你可以调用该方法设置音乐文件的播放语言。该方法支持的音频文件格式见 。你需要在调用 startAudioMixing 并收到 onAudioMixingStateChanged (audioMixingStatePlaying) 回调后调用该方法。
  ///
  /// * [index] 指定的播放音轨。取值范围为 [0, getAudioTrackCount ()]。
  Future<void> selectAudioTrack(int index);

  /// 获取当前音乐文件的音轨索引。
  /// 你需要在调用 startAudioMixing 并收到 onAudioMixingStateChanged(audioMixingStatePlaying) 回调后调用该方法。
  ///
  /// Returns
  /// 方法调用成功时，返回当前音乐文件的音轨索引。< 0: 方法调用失败。
  Future<int> getAudioTrackCount();

  /// 调节音乐文件的播放音量。
  /// 该方法调节混音音乐文件在本端和远端的播放音量大小。该方法需要在 startAudioMixing 后调用。
  ///
  /// * [volume] 音乐文件音量范围为 0~100。100 （默认值）为原始文件音量。
  Future<void> adjustAudioMixingVolume(int volume);

  /// 调节音乐文件远端播放音量。
  /// 该方法调节混音音乐文件在远端的播放音量大小。你需要在调用 startAudioMixing 并收到 onAudioMixingStateChanged(audioMixingStatePlaying) 回调后调用该方法。
  ///
  /// * [volume] 音乐文件音量。取值范围为 [0,100]，100 （默认值）为原始音量。
  Future<void> adjustAudioMixingPublishVolume(int volume);

  /// 获取音乐文件的远端播放音量。
  /// 该接口可以方便开发者排查音量相关问题。你需要在调用 startAudioMixing 并收到 onAudioMixingStateChanged(audioMixingStatePlaying) 回调后调用该方法。
  ///
  /// Returns
  /// ≥ 0: 方法调用成功则返回音量值，范围为 [0,100]。< 0: 方法调用失败。
  Future<int> getAudioMixingPublishVolume();

  /// 调节音乐文件在本地播放的音量。
  /// 你需要在调用 startAudioMixing 并收到 onAudioMixingStateChanged(audioMixingStatePlaying) 回调后调用该方法。
  ///
  /// * [volume] 音乐文件音量。取值范围为 [0,100]，100 （默认值）为原始音量。
  Future<void> adjustAudioMixingPlayoutVolume(int volume);

  /// 获取音乐文件的本地播放音量。
  /// 该方法获取混音的音乐文件本地播放音量，方便排查音量相关问题。你需要在调用 startAudioMixing 并收到 onAudioMixingStateChanged(audioMixingStatePlaying) 回调后调用该方法。
  ///
  /// Returns
  /// ≥ 0: 方法调用成功则返回音量值，范围为 [0,100]。< 0: 方法调用失败。
  Future<int> getAudioMixingPlayoutVolume();

  /// 获取音乐文件总时长。
  /// 该方法获取音乐文件总时长，单位为毫秒。你需要在调用 startAudioMixing 并收到 onAudioMixingStateChanged (audioMixingStatePlaying) 回调后调用该方法。
  ///
  /// Returns
  /// ≥ 0: 方法调用成功返回音乐文件时长。< 0: 方法调用失败。
  Future<int> getAudioMixingDuration();

  /// 获取音乐文件的播放进度。
  /// 该方法获取当前音乐文件播放进度，单位为毫秒。你需要在调用 startAudioMixing 并收到 onAudioMixingStateChanged(audioMixingStatePlaying) 回调后调用该方法。如需多次调用 getAudioMixingCurrentPosition，请确保调用间隔大于 500 ms。
  ///
  /// Returns
  /// ≥ 0: 方法调用成功，返回当前音乐文件播放进度（ms）。0 表示当前音乐文件未开始播放。< 0: 方法调用失败。
  Future<int> getAudioMixingCurrentPosition();

  /// 设置音乐文件的播放位置。
  /// 该方法可以设置音频文件的播放位置，这样你可以根据实际情况播放文件，而非从头到尾播放整个文件。你需要在调用 startAudioMixing 并收到 onAudioMixingStateChanged(audioMixingStatePlaying) 回调后调用该方法。
  ///
  /// * [pos] 整数。进度条位置，单位为毫秒。
  Future<void> setAudioMixingPosition(int pos);

  /// 设置当前音频文件的声道模式。
  /// 在双声道音频文件中，左声道和右声道可以存储不同的音频数据。根据实际需要，你可以设置声道模式为原始模式、左声道模式、右声道模式或混合模式。例如，在 KTV 场景中，音频文件的左声道存储了伴奏，右声道存储了原唱的歌声。如果你只需听伴奏，调用该方法设置音频文件的声道模式为左声道模式；如果你需要同时听伴奏和原唱，调用该方法设置声道模式为混合模式。你需要在调用 startAudioMixing 并收到 onAudioMixingStateChanged (audioMixingStatePlaying) 回调后调用该方法。该方法仅适用于双声道的音频文件。
  ///
  /// * [mode] 声道模式。详见 AudioMixingDualMonoMode 。
  ///
  /// Returns
  /// 0: 方法调用成功< 0: 方法调用失败
  Future<void> setAudioMixingDualMonoMode(AudioMixingDualMonoMode mode);

  /// 调整本地播放的音乐文件的音调。
  /// 本地人声和播放的音乐文件混音时，调用该方法可以仅调节音乐文件的音调。你需要在调用 startAudioMixing 并收到 onAudioMixingStateChanged(audioMixingStatePlaying) 回调后调用该方法。
  ///
  /// * [pitch] 按半音音阶调整本地播放的音乐文件的音调，默认值为 0，即不调整音调。取值范围为 [-12,12]，每相邻两个值的音高距离相差半音。取值的绝对值越大，音调升高或降低得越多。
  Future<void> setAudioMixingPitch(int pitch);

  /// 获取音效文件的播放音量。
  /// 音量范围为 0~100。100 （默认值）为原始文件音量。该方法需要在 playEffect 后调用。
  ///
  /// Returns
  /// 音效文件的音量。< 0: 方法调用失败
  Future<int> getEffectsVolume();

  /// 设置音效文件的播放音量。
  /// 该方法需要在 playEffect 后调用。
  ///
  /// * [volume] 播放音量。取值范围为 [0,100]。默认值为 100，表示原始音量。
  Future<void> setEffectsVolume(int volume);

  /// 将音效文件加载至内存。
  /// 为保证通信畅通，请注意控制预加载音效文件的大小，并在 joinChannel [2/2] 前就使用该方法完成音效预加载。该方法不支持在线音频文件。该方法支持的音频文件格式见 Agora RTC SDK 支持播放哪些格式的音频文件。
  ///
  /// * [soundId] 音效的 ID。每个音效的 ID 具有唯一性。
  /// * [filePath] 文件路径： Android: 文件路径，需精确到文件名及后缀。支持在线文件的 URL 地址，本地文件的 URI 地址、绝对路径或以 /assets/ 开头的路径。
  ///  通过绝对路径访问本地文件可能会遇到权限问题，Agora 推荐使用 URI 地址访问本地文件。例如 content://com.android.providers.media.documents/document/audio%3A14441。Windows: 音频文件的绝对路径或 URL 地址，需精确到文件名及后缀。例如 C:\music\audio.mp4。iOS 或 macOS: 音频文件的绝对路径或 URL 地址，需精确到文件名及后缀。例如 /var/mobile/Containers/Data/audio.mp4。
  /// * [startPos] 音效文件加载的起始位置，单位为毫秒。
  Future<void> preloadEffect(
      {required int soundId, required String filePath, int startPos = 0});

  /// 播放指定的本地或在线音效文件。
  /// 你可以多次调用该方法，传入不同的 soundID 和 filePath，同时播放多个音效文件。为获得最佳用户体验，Agora 推荐同时播放的音效文件不超过 3 个。 音效文件播放结束后，SDK 会触发 onAudioEffectFinished 回调。
  ///  该方法需要在加入频道后调用。
  ///
  /// * [soundId] 音效的 ID。每个音效的 ID 具有唯一性。 如果你已通过 preloadEffect 将音效加载至内存，请确保该参数与 preloadEffect 中设置的 soundId 相同。
  /// * [filePath] 播放文件的绝对路径或 URL 地址，需精确到文件名及后缀。例如 C:\music\audio.mp4。支持的音频格式包括 MP3、AAC、M4A、MP4、WAV、3GP。详见支持的媒体格式。如果你已通过 preloadEffect 将音效加载至内存，请确保该参数与 preloadEffect 中设置的 filePath 相同。
  /// * [loopCount] 音效循环播放的次数。 ≥ 0: 循环播放次数。例如，1 表示循环播放 1 次，即总计播放 2 次。-1: 无限循环播放。
  /// * [pitch] 音效的音调，取值范围为 [0.5,2.0]。默认值为 1.0，表示原始音调。取值越小，则音调越低。
  /// * [pan] 音效的空间位置。取值范围为 [-1.0,1.0]，例如： -1.0：音效出现在左边0.0：音效出现在正前方 1.0：音效出现在右边
  /// * [gain] 音效的音量。取值范围为 [0.0,100.0]。默认值为 100.0，表示原始音量。取值越小，则音量越低。
  /// * [publish] 是否将音效发布至远端： true: 将音效发布至远端。本地用户和远端用户都能听到音效。false: 不将音效发布至远端。只有本地用户能听到音效。
  /// * [startPos] 音效文件的播放位置，单位为毫秒。
  Future<void> playEffect(
      {required int soundId,
      required String filePath,
      required int loopCount,
      required double pitch,
      required double pan,
      required int gain,
      bool publish = false,
      int startPos = 0});

  /// 播放所有音效文件。
  /// 多次调用 preloadEffect 预加载多个音效文件后，你可以调用本方法播放所有预加载的音效文件。
  ///
  /// * [loopCount] 音效文件循环播放的次数：
  ///  -1: 无限循环播放音效文件，直至调用 stopEffect 或 stopAllEffects 后停止。0: 播放音效文件一次。1: 播放音效文件两次。
  /// * [pitch] 音效的音调。取值范围为 [0.5,2.0]。默认值为 1.0，代表原始音调。取值越小，则音调越低。
  /// * [pan] 音效的空间位置。取值范围为 [-1.0,1.0]: -1.0: 音效出现在左边。0: 音效出现在正前边。1.0: 音效出现在右边。
  /// * [gain] 音效的音量。取值范围为 [0,100]。100 为默认值，代表原始音量。取值越小，则音量越低。
  /// * [publish] 是否将音效发布到远端：
  ///  true: 将音效发布到远端。本地和远端用户都能听到该音效。false: （默认）不将音效发布到远端。只能本地用户能听到该音效。
  Future<void> playAllEffects(
      {required int loopCount,
      required double pitch,
      required double pan,
      required int gain,
      bool publish = false});

  /// 获取指定音效文件的播放音量。
  ///
  ///
  /// * [soundId] 音效文件的 ID。
  ///
  /// Returns
  /// ≥ 0: 方法调用成功，返回播放音量。音量范围为 [0,100]。100 为原始音量。 < 0: 方法调用失败。
  Future<int> getVolumeOfEffect(int soundId);

  /// 实时调整音效文件的播放音量。
  ///
  ///
  /// * [soundId] 指定音效的 ID。每个音效均有唯一的 ID。
  /// * [volume] 播放音量。取值范围为 [0,100]。默认值为 100，表示原始音量。
  Future<void> setVolumeOfEffect({required int soundId, required int volume});

  /// 暂停音效文件播放。
  ///
  ///
  /// * [soundId] 音效的 ID。每个音效的 ID 具有唯一性。
  Future<void> pauseEffect(int soundId);

  /// 暂停所有音效文件播放。
  ///
  Future<void> pauseAllEffects();

  /// 恢复播放指定音效文件。
  ///
  ///
  /// * [soundId] 音效的 ID。每个音效的 ID 具有唯一性。
  Future<void> resumeEffect(int soundId);

  /// 恢复播放所有音效文件。
  ///
  Future<void> resumeAllEffects();

  /// 停止播放指定音效文件。
  ///
  ///
  /// * [soundId] 指定音效文件的 ID。每个音效文件均有唯一的 ID。
  Future<void> stopEffect(int soundId);

  /// 停止播放所有音效文件。
  ///
  Future<void> stopAllEffects();

  /// 从内存释放某个预加载的音效文件。
  ///
  ///
  /// * [soundId] 指定音效文件的 ID。每个音效文件均有唯一的 ID。
  Future<void> unloadEffect(int soundId);

  /// 从内存释放所有预加载音效文件。
  ///
  Future<void> unloadAllEffects();

  /// 获取指定音效文件总时长。
  /// 该方法需要在加入频道后调用。
  ///
  /// * [filePath] 文件路径： Android: 文件路径，需精确到文件名及后缀。支持在线文件的 URL 地址，本地文件的 URI 地址、绝对路径或以 /assets/ 开头的路径。
  ///  通过绝对路径访问本地文件可能会遇到权限问题，Agora 推荐使用 URI 地址访问本地文件。例如 content://com.android.providers.media.documents/document/audio%3A14441。
  ///  Windows: 音频文件的绝对路径或 URL 地址，需精确到文件名及后缀。例如 C:\music\audio.mp4。
  ///  iOS 或 macOS: 音频文件的绝对路径或 URL 地址，需精确到文件名及后缀。例如 /var/mobile/Containers/Data/audio.mp4。
  ///
  ///
  /// Returns
  /// 方法调用成功，返回指定音效文件时长（毫秒）。< 0：方法调用失败。
  Future<int> getEffectDuration(String filePath);

  /// 设置指定音效文件的播放位置。
  /// 成功设置后，本地音效文件会在指定位置开始播放。该方法需要在 playEffect 后调用。
  ///
  /// * [soundId] 音效的 ID。每个音效的 ID 具有唯一性。
  /// * [pos] 音效文件的播放位置，单位为毫秒。
  Future<void> setEffectPosition({required int soundId, required int pos});

  /// 获取指定音效文件的播放进度。
  /// 该方法需要在 playEffect 后调用。
  ///
  /// * [soundId] 音效的 ID。每个音效的 ID 具有唯一性。
  ///
  /// Returns
  /// 方法调用成功，返回指定音效文件的播放进度（毫秒）。< 0：方法调用失败。
  Future<int> getEffectCurrentPosition(int soundId);

  /// 开启/关闭远端用户的语音立体声。
  /// 如果想调用 setRemoteVoicePosition 实现听声辨位的功能，请确保在加入频道前调用该方法开启远端用户的语音立体声。
  ///
  /// * [enabled] 是否开启远端用户语音立体声： true: 开启语音立体声。false: 关闭语音立体声。
  Future<void> enableSoundPositionIndication(bool enabled);

  /// 设置远端用户声音的 2D 位置，即水平面位置。
  /// 设置远端用户声音的 2D 位置和音量，方便本地用户听声辨位。通过调用该接口设置远端用户声音出现的位置，左右声道的声音差异会产生声音的方位感，从而判断出远端用户的实时位置。在多人在线游戏场景，如吃鸡游戏中，该方法能有效增加游戏角色的方位感，模拟真实场景。使用该方法需要在加入频道前调用 enableSoundPositionIndication 开启远端用户的语音立体声。为获得最佳听觉体验，我们建议使用该方法时使用有线耳机。该方法需要在加入频道后调用。
  ///
  /// * [uid] 远端用户的 ID
  /// * [pan] 设置远端用户声音的 2D 位置，取值范围为 [-1.0,1.0]: (默认）0.0: 声音出现在正前方。-1.0: 声音出现在左边。1.0: 声音出现在右边。
  /// * [gain] 设置远端用户声音的音量，取值范围为 [0.0,100.0]，默认值为 100.0，表示该用户的原始音量。取值越小，则音量越低。
  Future<void> setRemoteVoicePosition(
      {required int uid, required double pan, required double gain});

  /// @nodoc
  Future<void> enableSpatialAudio(bool enabled);

  /// @nodoc
  Future<void> setRemoteUserSpatialAudioParams(
      {required int uid, required SpatialAudioParams params});

  /// 设置预设的美声效果。
  /// 调用该方法可以为本地发流用户设置预设的人声美化效果。设置美声效果后，频道内所有用户都能听到该效果。根据不同的场景，你可以为用户设置不同的美声效果。为获取更好的人声效果，Agora 推荐你在调用该方法前将 setAudioProfile [1/2] 的 scenario 设为 audioScenarioGameStreaming(3)，并将 profile 设为 audioProfileMusicHighQuality(4) 或 audioProfileMusicHighQualityStereo(5)。该方法在加入频道前后都能调用。请勿将 setAudioProfile [1/2] 的 profile 参数设置为 audioProfileSpeechStandard(1) 或 audioProfileIot(6)，否则该方法不生效。该方法对人声的处理效果最佳，Agora 不推荐调用该方法处理含音乐的音频数据。调用 setVoiceBeautifierPreset，Agora 不推荐调用以下方法，否则 setVoiceBeautifierPreset 设置的效果会被覆盖：
  ///  setAudioEffectPreset setAudioEffectParameters setLocalVoicePitch setLocalVoiceEqualization setLocalVoiceReverb setVoiceBeautifierParameters setVoiceConversionPreset
  ///
  /// * [preset] 预设的美声效果选项，详见 VoiceBeautifierPreset 。
  Future<void> setVoiceBeautifierPreset(VoiceBeautifierPreset preset);

  /// 设置 SDK 预设的人声音效。
  /// 调用该方法可以为本地发流用户设置 SDK 预设的人声音效，且不会改变原声的性别特征。设置音效后，频道内所有用户都能听到该效果。为获取更好的人声效果，Agora 推荐你在调用该方法前将 setAudioProfile [1/2] 的 scenario 设为 audioScenarioGameStreaming(3)。该方法在加入频道前后都能调用。请勿将 setAudioProfile [1/2] 的 profile 参数设置为 audioProfileSpeechStandard(1) 或 audioProfileIot(6)，否则该方法不生效。该方法对人声的处理效果最佳，Agora 不推荐调用该方法处理含音乐的音频数据。如果调用 setAudioEffectPreset 并设置除 roomAcoustics3dVoice 或 pitchCorrection 外的枚举，请勿再调用 setAudioEffectParameters ，否则 setAudioEffectPreset 设置的效果会被覆盖。调用 setAudioEffectPreset 后，Agora 不推荐调用以下方法，否则 setAudioEffectPreset 设置的效果会被覆盖： setVoiceBeautifierPreset setLocalVoicePitch setLocalVoiceEqualization setLocalVoiceReverb setVoiceBeautifierParameters setVoiceConversionPreset
  ///
  /// * [preset] 预设的音效选项，详见 AudioEffectPreset 。
  Future<void> setAudioEffectPreset(AudioEffectPreset preset);

  /// 设置预设的变声效果。
  /// 调用该方法可以为本地发流用户设置 SDK 预设的变声效果。设置变声效果后，频道内所有用户都能听到该效果。根据不同的场景，你可以为用户设置不同的变声效果。为获取更好的人声效果，Agora 推荐你在调用该方法前将 setAudioProfile [1/2] 的 profile 设为 audioProfileMusicHighQuality(4) 或 audioProfileMusicHighQualityStereo(5)，并将 scenario 设为 audioScenarioGameStreaming(3)。该方法在加入频道前后都能调用。请勿将 setAudioProfile [1/2] 的 profile 参数设置为 audioProfileSpeechStandard(1) 或 audioProfileIot(6)，否则该方法不生效。该方法对人声的处理效果最佳，Agora 不推荐调用该方法处理含音乐的音频数据。调用 setVoiceConversionPreset 后，Agora 不推荐调用以下方法，否则 setVoiceConversionPreset 设置的效果会被覆盖：
  ///  setAudioEffectPreset setAudioEffectParameters setVoiceBeautifierPreset setVoiceBeautifierParameters setLocalVoicePitch setLocalVoiceEqualization setLocalVoiceReverb
  ///
  /// * [preset] 预设的变声效果选项: VoiceConversionPreset 。
  Future<void> setVoiceConversionPreset(VoiceConversionPreset preset);

  /// 设置 SDK 预设人声音效的参数。
  /// 调用该方法可以对本地发流用户进行如下设置：
  ///  3D 人声音效：设置 3D 人声音效的环绕周期。电音音效：设置电音音效的基础调式和主音音高。为方便用户自行调节电音音效，Agora 推荐你将基础调式和主音音高配置选项与应用的 UI 元素绑定。设置后，频道内所有用户都能听到该效果。该方法在加入频道前后都能调用。为获取更好的人声效果，Agora 推荐你在调用该方法前将 setAudioProfile [1/2] 的 scenario 设为 audioScenarioGameStreaming(3)。请勿将 setAudioProfile [1/2] 的 profile 参数设置为 audioProfileSpeechStandard(1) 或 audioProfileIot(6)，否则该方法不生效。该方法对人声的处理效果最佳，Agora 不推荐调用该方法处理含音乐的音频数据。调用 setAudioEffectParameters 后，Agora 不推荐调用以下方法，否则 setAudioEffectParameters 设置的效果会被覆盖： setAudioEffectPreset setVoiceBeautifierPreset setLocalVoicePitch setLocalVoiceEqualization setLocalVoiceReverb setVoiceBeautifierParameters setVoiceConversionPreset
  ///
  /// * [preset] SDK 预设的音效，支持以下设置：
  ///  roomAcoustics3dVoice，3D 人声音效。
  ///  你需要在使用该枚举前将 setAudioProfile [1/2] 的 profile 参数设置 为 audioProfileMusicStandardStereo(3) 或 audioProfileMusicHighQualityStereo(5)，否则该枚举设置无效。启用 3D 人声后，用户需要使用支持双声道的音频播放设备才能听到预期效果。pitchCorrection，电音音效。为获取更好的人声效果，Agora 建议你在使用该枚举前将 setAudioProfile [1/2] 的 profile 参数设置为 audioProfileMusicHighQuality(4) 或 audioProfileMusicHighQualityStereo(5)。
  /// * [param1] 如果 preset 设为 roomAcoustics3dVoice ，则 param1 表示 3D 人声音效的环绕周期。取值范围为 [1,60]，单位为秒。默认值为 10，表示人声会 10 秒环绕 360 度。如果 preset 设为 pitchCorrection，则 param1 表示电音音效的基础调式：
  ///  1: （默认）自然大调。2: 自然小调。3: 和风小调。
  /// * [param2] 如果 preset 设为 roomAcoustics3dVoice，你需要将 param2 设置为 0。如果 preset 设为 pitchCorrection，则 param2 表示电音音效的主音音高： 1: A2: A#3: B4: (Default) C5: C#6: D7: D#8: E9: F10: F#11: G12: G#
  Future<void> setAudioEffectParameters(
      {required AudioEffectPreset preset,
      required int param1,
      required int param2});

  /// 设置预设美声效果的参数。
  /// 调用该方法可以设置歌唱美声效果的性别特征和混响效果。该方法对本地发流用户进行设置。设置后，频道内所有用户都能听到该效果。为获取更好的人声效果，Agora 推荐你在调用该方法前将 setAudioProfile [1/2] 的 scenario 设为 audioScenarioGameStreaming(3)，并将 profile 设为 audioProfileMusicHighQuality(4) 或 audioProfileMusicHighQualityStereo(5)。该方法在加入频道前后都能调用。请勿将 setAudioProfile [1/2] 的 profile 参数设置为 audioProfileSpeechStandard(1) 或 audioProfileIot(6)，否则该方法不生效。该方法对人声的处理效果最佳，Agora 不推荐调用该方法处理含音乐的音频数据。调用 setVoiceBeautifierParameters，Agora 不推荐调用以下方法，否则 setVoiceBeautifierParameters 设置的效果会被覆盖：
  ///  setAudioEffectPreset setAudioEffectParameters setVoiceBeautifierPreset setLocalVoicePitch setLocalVoiceEqualization setLocalVoiceReverb setVoiceConversionPreset
  ///
  /// * [preset] 预设的音效：
  ///  SINGING_BEAUTIFIER: 歌唱美声。
  /// * [param1] 歌声的性别特征：
  ///  1: 男声。2: 女声。
  /// * [param2] 歌声的混响效果：
  ///  1: 歌声在小房间的混响效果。2: 歌声在大房间的混响效果。3: 歌声在大厅的混响效果。
  Future<void> setVoiceBeautifierParameters(
      {required VoiceBeautifierPreset preset,
      required int param1,
      required int param2});

  /// @nodoc
  Future<void> setVoiceConversionParameters(
      {required VoiceConversionPreset preset,
      required int param1,
      required int param2});

  /// 设置本地语音音调。
  /// 该方法在加入频道前后都能调用。
  ///
  /// * [pitch] 语音频率。可以 [0.5,2.0] 范围内设置。取值越小，则音调越低。默认值为 1.0，表示不需要修改音调。
  Future<void> setLocalVoicePitch(double pitch);

  /// 设置本地语音音效均衡。
  /// 该方法在加入频道前后都能调用。
  ///
  /// * [bandFrequency] 频谱子带索引。取值范围是 [0,9]，分别代表音效的 10 个频带。对应的中心频率为 [31，62，125，250，500，1k，2k，4k，8k，16k] Hz。详见 AudioEqualizationBandFrequency 。
  /// * [bandGain] 每个 band 的增益，单位是 dB，每一个值的范围是 [-15,15]，默认值为 0。
  Future<void> setLocalVoiceEqualization(
      {required AudioEqualizationBandFrequency bandFrequency,
      required int bandGain});

  /// 设置本地音效混响。
  /// SDK 提供一个使用更为简便的方法 setAudioEffectPreset ，直接实现流行、R&B、KTV 等预置的混响效果。该方法在加入频道前后都能调用。
  ///
  /// * [reverbKey] 混响音效 Key。该方法共有 5 个混响音效 Key，详见 AudioReverbType 。
  /// * [value] 各混响音效 Key 所对应的值。
  Future<void> setLocalVoiceReverb(
      {required AudioReverbType reverbKey, required int value});

  /// 设置日志文件
  /// 弃用：此方法已废弃，请改用 initialize 中的 logConfig 参数设置日志文件路径 。设置 SDK 的输出 log 文件。SDK 运行时产生的所有 log 将写入该文件。App 必须保证指定的目录存在而且可写。如需调用本方法，请在调用 initialize 方法初始化 RtcEngine 对象后立即调用，否则输出日志可能不完整。
  ///
  /// * [filePath] 日志文件的完整路径。该日志文件为 UTF-8 编码。
  Future<void> setLogFile(String filePath);

  /// 设置日志输出等级。
  /// 弃用：请改用 initialize 中的 logConfig。该方法设置 Agora SDK 的输出日志输出等级。不同的输出等级可以单独或组合使用。日志级别顺序依次为 logFilterOff、logFilterCritical、logFilterError、logFilterWarn、logFilterInfo 和 logFilterDebug。
  ///  选择一个级别，你就可以看到在该级别之前所有级别的日志信息。例如，你选择 logFilterWarn 级别，就可以看到在 logFilterCritical、logFilterError 和 logFilterWarn 级别的日志信息。
  ///
  /// * [filter] 日志过滤等级。详见 LogFilterType 。
  Future<void> setLogFilter(LogFilterType filter);

  /// 设置 SDK 的日志输出级别。
  /// 弃用：该方法已经废弃。请改用 RtcEngineContext 设置日志输出级别。选择一个级别，你就可以看到该级别的日志信息。
  ///
  /// * [level] 日志级别: LogLevel 。
  Future<void> setLogLevel(LogLevel level);

  /// 设置 SDK 输出的日志文件的大小。
  /// 弃用：该方法已废弃，请改用 initialize 中的 logConfig 参数设置日志文件大小。默认情况下，SDK 会生成 5 个 SDK 日志文件和 5 个 API 调用日志文件，规则如下：SDK 日志文件的名称分别为：agorasdk.log、agorasdk.1.log、agorasdk.2.log、agorasdk.3.log、agorasdk.4.log。API 调用日志文件的名称分别为：agoraapi.log、agoraapi.1.log、agoraapi.2.log、agoraapi.3.log、agoraapi.4.log。每个 SDK 日志文件的默认大小为 1,024 KB；API 调用日志文件的默认大小为 2,048 KB。日志文件均为 UTF-8 编码。最新的日志永远写在 agorasdk.log 和 agoraapi.log 中。当 agorasdk.log 写满后，SDK 会按照以下顺序对日志文件进行操作： 删除 agorasdk.4.log 文件（如有）。将agorasdk.3.log 重命名为 agorasdk.4.log。将agorasdk.2.log 重命名为 agorasdk.3.log。将agorasdk.1.log 重命名为 agorasdk.2.log。新建 agorasdk.log 文件。agoraapi.log 文件的覆盖规则与 agorasdk.log 相同。该方法仅用于设置 agorasdk.log 文件的大小，对agoraapi.log不生效。
  ///
  /// * [fileSizeInKBytes] 单个 agorasdk.log 日志文件的大小，单位为 KB，取值范围为 [128,20480]，默认值为 1,024 KB。 如果你将 fileSizeInKByte 设为小于 128 KB，SDK 会自动调整到 128 KB；如果你将 fileSizeInKByte 设为大于 20,480 KB，SDK 会自动调整到 20,480 KB。
  Future<void> setLogFileSize(int fileSizeInKBytes);

  /// @nodoc
  Future<void> uploadLogFile(String requestId);

  /// 更新远端视图显示模式。
  /// 初始化远端用户视图后，你可以调用该方法更新远端用户视图在本地显示时的渲染和镜像模式。该方法只影响本地用户看到的视频画面。请在调用 setupRemoteVideo 方法初始化远端视图后，调用该方法。你可以在通话中多次调用该方法，多次更新远端用户视图的显示模式。
  ///
  /// * [uid] 远端用户 ID。
  /// * [renderMode] 远端用户视图的渲染模式，详见 RenderModeType 。
  /// * [mirrorMode] 远端用户视图的镜像模式，详见 VideoMirrorModeType 。
  Future<void> setRemoteRenderMode(
      {required int uid,
      required RenderModeType renderMode,
      required VideoMirrorModeType mirrorMode});

  /// 设置本地视频镜像。
  /// 弃用:该方法已废弃。请改用 setupLocalVideo 或 setLocalRenderMode 。
  ///
  /// * [mirrorMode] 本地视频镜像模式。详见 VideoMirrorModeType 。
  Future<void> setLocalVideoMirrorMode(VideoMirrorModeType mirrorMode);

  /// @nodoc
  Future<void> enableEchoCancellationExternal(
      {required bool enabled, required int audioSourceDelay});

  /// @nodoc
  Future<void> enableCustomAudioLocalPlayback(
      {required int sourceId, required bool enabled});

  /// @nodoc
  Future<void> startPrimaryCustomAudioTrack(AudioTrackConfig config);

  /// @nodoc
  Future<void> stopPrimaryCustomAudioTrack();

  /// @nodoc
  Future<void> startSecondaryCustomAudioTrack(AudioTrackConfig config);

  /// @nodoc
  Future<void> stopSecondaryCustomAudioTrack();

  /// 设置采集的原始音频数据格式。
  /// 该方法设置 onRecordAudioFrame 回调的采集音频格式。该方法需要在加入频道前调用。SDK 会通过该方法中的 samplesPerCall、sampleRate 和 channel 参数计算出采样间隔，计算公式为采样间隔 = samplesPerCall/(sampleRate × channel)。请确保采样间隔不小于 0.01 秒。
  ///
  /// * [sampleRate] onRecordAudioFrame 中返回数据的采样率，可设置为 8000、 16000、 32000、44100 或 48000。
  /// * [channel] onRecordAudioFrame 中返回数据的通道数，可设置为 1 或 2:
  ///  1: 单声道。2: 双声道。
  /// * [mode] 音频帧的使用模式，详见 RawAudioFrameOpModeType 。
  /// * [samplesPerCall] onRecordAudioFrame 中返回数据的采样点数，如旁路推流应用中通常为 1024。
  Future<void> setRecordingAudioFrameParameters(
      {required int sampleRate,
      required int channel,
      required RawAudioFrameOpModeType mode,
      required int samplesPerCall});

  /// 设置播放的音频格式。
  /// 该方法设置 onPlaybackAudioFrame 回调数据的格式。该方法需要在加入频道前调用。SDK 会通过该方法中的 samplesPerCall、sampleRate 和 channel 参数计算出采样间隔，计算公式为采样间隔 = samplesPerCall/(sampleRate × channel)。请确保采样间隔不小于 0.01 秒。SDK 会根据该采样间隔触发 onPlaybackAudioFrame 回调。
  ///
  /// * [sampleRate] onPlaybackAudioFrame 中返回数据的采样率，可设置为 8000、 16000、 32000、44100 或 48000。
  /// * [channel] onPlaybackAudioFrame 中返回数据的通道数，可设置为 1 或 2: 1: 单声道2: 双声道
  /// * [mode] 音频帧的使用模式，详见 RawAudioFrameOpModeType 。
  /// * [samplesPerCall] onPlaybackAudioFrame 中返回数据的采样点数，如旁路推流应用中通常为 1024。
  Future<void> setPlaybackAudioFrameParameters(
      {required int sampleRate,
      required int channel,
      required RawAudioFrameOpModeType mode,
      required int samplesPerCall});

  /// 设置 onMixedAudioFrame 报告的音频数据格式。
  ///
  ///
  /// * [sampleRate] 音频数据采样率 (Hz)，可设置为 8000、 16000、32000、 44100 或 48000。
  /// * [channel] 音频数据声道数，可设置为 1（单声道） 或 2（双声道）。
  /// * [samplesPerCall] 音频数据采样点数。旁路推流场景下通常设为 1024。
  Future<void> setMixedAudioFrameParameters(
      {required int sampleRate,
      required int channel,
      required int samplesPerCall});

  /// 设置 onPlaybackAudioFrameBeforeMixing 报告的音频数据格式。
  ///
  ///
  /// * [null] 音频数据采样率 (Hz)，可设置为 8000、 16000、32000、 44100 或 48000。
  /// * [channel] 音频数据声道数，可设置为 1（单声道） 或 2（双声道） 。
  Future<void> setPlaybackAudioFrameBeforeMixingParameters(
      {required int sampleRate, required int channel});

  /// 开启音频频谱监测。
  /// 如果你想获取本地或远端用户的音频频谱数据，请注册音频频谱观测器并开启音频频谱监测。该方法在加入频道前后均可调用。
  ///
  /// * [null] SDK 触发 onLocalAudioSpectrum 和 onRemoteAudioSpectrum 回调的时间间隔（毫秒）。 默认值为 100 毫秒。取值不得少于 10 毫秒，否则该方法会调用失败。
  Future<void> enableAudioSpectrumMonitor({int intervalInMS = 100});

  /// 关闭音频频谱监测。
  /// 调用 enableAudioSpectrumMonitor 后，如果你想关闭音频频谱监测，请调用该方法。该方法在加入频道前后均可调用。
  Future<void> disableAudioSpectrumMonitor();

  /// 注册音频频谱观测器。
  /// 成功注册音频频谱观测器并调用 enableAudioSpectrumMonitor 开启音频频谱监测后，SDK 会按照你设置的时间间隔报告你在 AudioSpectrumObserver 类中实现的回调。该方法在加入频道前后均可调用。
  ///
  /// * [observer] 音频频谱观测器。详见 AudioSpectrumObserver 。
  void registerAudioSpectrumObserver(AudioSpectrumObserver observer);

  /// 取消注册音频频谱观测器。
  /// 调用 registerAudioSpectrumObserver 后，如果你想取消注册音频频谱观测器，请调用该方法。该方法在加入频道前后均可调用。
  void unregisterAudioSpectrumObserver(AudioSpectrumObserver observer);

  /// 调节音频采集信号音量。
  /// 该方法在加入频道前后都能调用。
  ///
  /// * [volume] 音量，取值范围为 [0,400]。 0: 静音。100: （默认）原始音量。400: 原始音量的 4 倍，自带溢出保护。
  Future<void> adjustRecordingSignalVolume(int volume);

  /// 是否将录音信号静音。
  ///
  ///
  /// * [mute] true: 静音。false:（默认）不静音。
  Future<void> muteRecordingSignal(bool mute);

  /// 调节本地播放的所有远端用户信号音量。
  /// 该方法调节的是本地播放的所有远端用户混音后的音量。该方法在加入频道前后都能调用。
  ///
  /// * [volume] 音量，取值范围为 [0,400]。 0: 静音。
  ///  100: （默认）原始音量。
  ///  400: 原始音量的 4 倍，自带溢出保护。
  Future<void> adjustPlaybackSignalVolume(int volume);

  /// 调节本地播放的指定远端用户信号音量。
  /// 你可以在通话中调用该方法调节指定远端用户在本地播放的音量。如需调节多个用户在本地播放的音量，则需多次调用该方法。该方法需要在加入频道后调用。该方法调节的是本地播放的指定远端用户混音后的音量。
  ///
  /// * [volume] 音乐文件音量范围为 0~100。100 （默认值）为原始文件音量。
  /// * [uid] 远端用户 ID。
  Future<void> adjustUserPlaybackSignalVolume(
      {required int uid, required int volume});

  /// @nodoc
  Future<void> setLocalPublishFallbackOption(StreamFallbackOptions option);

  /// @nodoc
  Future<void> setRemoteSubscribeFallbackOption(StreamFallbackOptions option);

  /// 开启声卡采集。
  /// 启用声卡采集功能后，声卡播放的声音会被合到本地音频流中，从而可以发送到远端。该方法仅适用于 macOS 和 Windows 平台。macOS 系统默认声卡不支持采集功能，如果你需要使用该功能，请启用一个虚拟声卡，并将该虚拟声卡的名字传入 deviceName 参数。Agora 推荐你使用虚拟声卡 Soundflower 进行声卡采集。该方法在加入频道前后都能调用。
  ///
  /// * [enabled] 是否开启声卡采集: true: 开启声卡采集。false:（默认）关闭声卡采集。
  /// * [deviceName] macOS: 虚拟声卡的设备名。默认为空，代表使用 Soundflower 虚拟声卡进行采集。Windows: 声卡的设备名。默认为空，代表使用设备自带的声卡进行采集。
  Future<void> enableLoopbackRecording(
      {required bool enabled, String? deviceName});

  /// 调节声卡采集信号音量。
  /// 调用 enableLoopbackRecording 开启声卡采集后，你可以调用该方法调节声卡采集的信号音量。
  ///
  /// * [volume] 音乐文件音量范围为 0~100。100 （默认值）为原始文件音量。
  Future<void> adjustLoopbackSignalVolume(int volume);

  /// @nodoc
  Future<int> getLoopbackRecordingVolume();

  /// 开启耳返功能。
  /// 该方法打开或关闭耳返功能。
  ///
  /// * [enabled] 开启/关闭耳返功能: true: 开启耳返功能。false: （默认）关闭耳返功能。
  ///
  /// Returns
  /// 0: 方法调用成功。< 0: 方法调用失败。
  Future<void> enableInEarMonitoring(
      {required bool enabled,
      required EarMonitoringFilterType includeAudioFilters});

  /// 设置耳返音量。
  /// 该方法仅适用于 Android 和 iOS 平台。用户必须使用有线耳机才能听到耳返效果。该方法在加入频道前后都能调用。
  ///
  /// * [volume] 设置耳返音量，取值范围在 [0,100]。默认值为 100。
  Future<void> setInEarMonitoringVolume(int volume);

  /// 将插件添加到 SDK 中。
  /// 该方法仅适用于 Windows 和 Android。
  ///
  /// * [path] 插件的动态库路径和名称。例如：/library/libagora_segmentation_extension.dll。
  /// * [unloadAfterUse] 是否在插件使用完毕后自动卸载：
  ///  true: 当 RtcEngine 销毁时自动卸载插件。false: 不自动卸载插件，直到进程退出（推荐）。
  Future<void> loadExtensionProvider(
      {required String path, bool unloadAfterUse = false});

  /// 设置插件服务商的属性。
  /// 你可以调用该方法设置插件服务商的属性，并根据服务商的类型初始化相关参数。该方法需要在 enableExtension 之后、且启用音频（ enableAudio / enableLocalAudio ）或启用视频（ enableVideo / enableLocalVideo ）之前调用。
  ///
  /// * [value] 插件属性 Key 对应的值。
  /// * [key] 插件属性的 Key。
  /// * [provider] 提供插件的服务商名称。
  Future<void> setExtensionProviderProperty(
      {required String provider, required String key, required String value});

  /// 启用/禁用插件。
  /// 该方法需要在加入频道前调用。如果要开启多个插件，需要多次调用该方法。不同插件在 SDK 中处理数据的顺序由插件的开通顺序决定。即先开启的插件会先处理数据。
  ///
  /// * [extension] 插件的名称。
  /// * [provider] 提供插件的服务商名称。
  /// * [enable] 是否启用插件： true: 启用插件。false: 禁用插件。
  /// * [type] 媒体资源类型。详见 MediaSourceType 。
  ///  在该方法中，该参数仅支持以下两种设置：
  ///  默认值为 unknownMediaSource。如果要使用第二个摄像头采集视频，将该参数设置为 secondaryCameraSource。
  ///
  /// Returns
  /// 0: 方法调用成功< 0: 方法调用失败
  Future<void> enableExtension(
      {required String provider,
      required String extension,
      bool enable = true,
      MediaSourceType type = MediaSourceType.unknownMediaSource});

  /// 设置插件的属性。
  /// 开启插件后，你可以调用该方法设置插件的属性。
  ///
  /// * [provider] 提供插件的服务商名称。
  /// * [extension] 插件的名称。
  /// * [key] 插件属性的 Key。
  /// * [value] 插件属性 Key 对应的值。
  /// * [type] 媒体源类型，详见 MediaSourceType 。
  Future<void> setExtensionProperty(
      {required String provider,
      required String extension,
      required String key,
      required String value,
      MediaSourceType type = MediaSourceType.unknownMediaSource});

  /// 获取插件的详细信息。
  ///
  ///
  /// * [key] 插件属性的 Key。
  /// * [extension] 插件的名称。
  /// * [provider] 提供插件的服务商名称。
  /// * [sourceType] 插件的媒体源类型。详见 MediaSourceType 。
  /// * [buf_len] 插件属性 JSON 字符串的最大长度。最大值为 512 字节。
  ///
  /// Returns
  /// 0: 方法调用成功< 0: 方法调用失败
  Future<String> getExtensionProperty(
      {required String provider,
      required String extension,
      required String key,
      required int bufLen,
      MediaSourceType type = MediaSourceType.unknownMediaSource});

  /// 设置摄像头采集配置。
  /// 该方法仅适用于 Android 和 iOS。请在启动摄像头之前调用该方法，如 joinChannel [2/2] 、 enableVideo 或者 enableLocalVideo 之前。
  ///
  /// * [config] 摄像头采集配置，详见 CameraCapturerConfiguration 。
  ///
  Future<void> setCameraCapturerConfiguration(
      CameraCapturerConfiguration config);

  /// 创建一个自定义的视频轨道。
  /// 当你需要在频道中发布多路自定义采集视频时，可参考以下步骤：
  ///  调用该方法创建视频轨道并获得视频轨道 ID。在每个频道的 ChannelMediaOptions 中，将 customVideoTrackId 参数设置为你想要发布的视频轨道 ID，并将 publishCustomVideoTrack 设置为 true。
  ///
  /// Returns
  /// 方法调用成功，返回视频轨道 ID 作为该视频轨道的唯一标识。方法调用失败，返回负值。
  Future<int> createCustomVideoTrack();

  /// @nodoc
  Future<int> createCustomEncodedVideoTrack(SenderOptions senderOption);

  /// 销毁指定的视频轨道。
  ///
  ///
  /// * [videoTrackId] 调用 createCustomVideoTrack 方法返回的视频轨道 ID。
  Future<void> destroyCustomVideoTrack(int videoTrackId);

  /// @nodoc
  Future<void> destroyCustomEncodedVideoTrack(int videoTrackId);

  /// 切换前置/后置摄像头。
  /// 该方法需要在相机启动（如通过调用 startPreview 或 joinChannel [2/2] 实现）后调用。该方法仅适用于 Android 和 iOS。
  Future<void> switchCamera();

  /// 检测设备是否支持摄像头缩放功能。
  /// 请在启动摄像头之后调用该方法，如 joinChannel [2/2] 、 enableVideo 或者 enableLocalVideo 之后。该方法仅适用于 Android 和 iOS。
  ///
  /// Returns
  /// true: 设备支持相机缩放功能。false: 设备不支持相机缩放功能。
  Future<bool> isCameraZoomSupported();

  /// 检查设备摄像头是否支持人脸检测。
  /// 请在启动摄像头之后调用该方法，如 joinChannel [2/2] 、 enableVideo 或者 enableLocalVideo 之后。该方法仅适用于 Android。
  ///
  /// Returns
  /// true: 设备摄像头支持人脸检测。false: 设备摄像头不支持人脸检测。
  Future<bool> isCameraFaceDetectSupported();

  /// 检测设备是否支持闪光灯常开。
  /// 请在启动摄像头之后调用该方法，如 joinChannel [2/2] 、 enableVideo 或者 enableLocalVideo 之后。
  ///  该方法仅适用于 Android 和 iOS。一般情况下，app 默认开启前置摄像头，因此如果你的前置摄像头不支持闪光灯常开，直接使用该方法会返回 false。如果需要检查后置摄像头是否支持闪光灯常开，需要先使用 switchCamera 切换摄像头，再使用该方法。在系统版本 15 的 iPad 上，即使 isCameraTorchSupported 返回 true，也可能因系统问题导致你无法通过 setCameraTorchOn 成功开启闪光灯。
  ///
  /// Returns
  /// true: 设备支持闪光灯常开。false: 设备不支持闪光灯常开。
  Future<bool> isCameraTorchSupported();

  /// 检测设备是否支持手动对焦功能。
  /// 请在启动摄像头之后调用该方法，如 joinChannel [2/2] 、 enableVideo 或者 enableLocalVideo 之后。该方法仅适用于 Android 和 iOS。
  ///
  /// Returns
  /// true: 设备支持手动对焦功能。false: 设备不支持手动对焦功能。
  Future<bool> isCameraFocusSupported();

  /// 检测设备是否支持人脸对焦功能。
  /// 该方法仅适用于 Android 和 iOS。请在启动摄像头之后调用该方法，如 joinChannel [2/2] 、 enableVideo 或者 enableLocalVideo 之后。
  ///
  /// Returns
  /// true: 设备支持人脸对焦功能。false: 设备不支持人脸对焦功能。
  Future<bool> isCameraAutoFocusFaceModeSupported();

  /// 设置摄像头缩放比例。
  /// 该方法仅适用于 Android 和 iOS。请在启动摄像头之前调用该方法，如 joinChannel [2/2] 、 enableVideo 或者 enableLocalVideo 之前。
  ///
  /// * [factor] 相机缩放比例，有效范围从 1.0 到最大缩放比例。你可以通过 getCameraMaxZoomFactor 方法获取设备支持的最大缩放比例。
  Future<void> setCameraZoomFactor(double factor);

  /// 开启/关闭本地人脸检测。
  /// 该方法在加入频道前后都能调用。该方法仅适用于 Android 和 iOS。开启本地人脸检测后，SDK 会触发 onFacePositionChanged 回调向你报告人脸检测的信息： 摄像头采集的画面大小人脸在 view 中的位置人脸距设备屏幕的距离该方法需要在相机启动（如通过调用 startPreviewjoinChannel [2/2] 实现）后调用。
  ///
  /// * [enabled] 是否开启人脸检测： true：开启人脸检测。false：（默认）关闭人脸检测。
  Future<void> enableFaceDetection(bool enabled);

  /// 获取摄像头支持最大缩放比例。
  /// 该方法仅适用于 Android 和 iOS。请在启动摄像头之后调用该方法，如 joinChannel [2/2] 、 enableVideo 或者 enableLocalVideo 之后。
  ///
  /// Returns
  /// 设备摄像头支持的最大缩放比例。
  Future<double> getCameraMaxZoomFactor();

  /// 设置手动对焦位置，并触发对焦。
  /// 该方法需要在相机启动（如通过调用 startPreview 或 joinChannel [2/2] 实现）后调用。
  ///  成功调用该方法后，本地会触发 onCameraFocusAreaChanged 回调。该方法仅适用于 Android 和 iOS。
  ///
  /// * [positionX] 触摸点相对于视图的横坐标。
  /// * [positionY] 触摸点相对于视图的纵坐标。
  Future<void> setCameraFocusPositionInPreview(
      {required double positionX, required double positionY});

  /// 设置是否打开闪光灯。
  /// 该方法仅适用于 Android 和 iOS。请在启动摄像头之前调用该方法，如 joinChannel [2/2] 、 enableVideo 或者 enableLocalVideo 之前。
  ///
  /// * [isOn] 是否打开闪光灯： true: 打开闪光灯。false:（默认）关闭闪光灯。
  Future<void> setCameraTorchOn(bool isOn);

  /// 设置是否开启人脸对焦功能。
  /// SDK 默认在 Android 平台关闭人脸自动对焦，在 iOS 平台开启人脸自动对焦。如需自行设置人脸自动对焦，请调用该方法。该方法仅适用于 Android 和 iOS。该方法需在摄像头启动后调用，如 joinChannel [2/2] 、 enableVideo 或者 enableLocalVideo 之后。
  ///
  /// * [enabled] 是否开启人脸对焦： true: 开启人脸对焦功能。false: 关闭人脸对焦功能。
  Future<void> setCameraAutoFocusFaceModeEnabled(bool enabled);

  /// 检测设备是否支持手动曝光功能。
  /// 请在启动摄像头之后调用该方法，如 joinChannel [2/2] 、 enableVideo 或者 enableLocalVideo 之后。
  ///  该方法仅适用于 Android 和 iOS。
  ///
  /// Returns
  /// true: 设备支持手动曝光功能。false: 设备不支持手动曝光功能。
  Future<bool> isCameraExposurePositionSupported();

  /// 设置手动曝光位置。
  /// 该方法需要在相机启动（如通过调用 startPreview 或 joinChannel [2/2] 实现）后调用。成功调用该方法后，本地会触发 onCameraExposureAreaChanged 回调。该方法仅适用于 Android 和 iOS。
  ///
  /// * [positionXinView] 触摸点相对于视图的横坐标。
  /// * [positionYinView] 触摸点相对于视图的纵坐标。
  Future<void> setCameraExposurePosition(
      {required double positionXinView, required double positionYinView});

  /// 检测设备是否支持自动曝光功能。
  /// 该方法仅适用于 iOS。请在启动摄像头之前调用该方法，如 joinChannel [2/2] 、 enableVideo 或者 enableLocalVideo 之前。
  ///
  /// Returns
  /// true: 设备支持自动曝光功能。false: 设备不支持自动曝光功能。
  Future<bool> isCameraAutoExposureFaceModeSupported();

  /// 设置是否开启自动曝光功能。
  /// 该方法仅适用于 iOS。请在启动摄像头之前调用该方法，如 joinChannel [2/2] 、 enableVideo 或者 enableLocalVideo 之前。
  ///
  /// * [enabled] 是否开启自动曝光：
  ///  true: 开启自动曝光。false: 关闭自动曝光。
  Future<void> setCameraAutoExposureFaceModeEnabled(bool enabled);

  /// 设置默认的音频路由。
  /// 该方法仅适用于 Android 和 iOS 平台。该方法需要在加入频道前调用。如需在加入频道后切换音频路由，请调用 setEnableSpeakerphone 。手机设备一般有两个音频路由，一个是位于顶部的听筒，播放声音偏小；一个是位于底部的扬声器，播放声音偏大。设置默认的音频路由，就是在没有外接设备的前提下，设置系统使用听筒还是扬声器播放音频。
  ///
  /// * [defaultToSpeaker] 是否使用扬声器作为默认的音频路由：
  ///  true: 设置默认音频路由为扬声器。false: 设置默认音频路由为听筒。
  Future<void> setDefaultAudioRouteToSpeakerphone(bool defaultToSpeaker);

  /// 开启或关闭扬声器播放。
  /// 如果 SDK 默认的音频路由（见音频路由）或 setDefaultAudioRouteToSpeakerphone 的设置无法满足你的需求，你可以调用 setEnableSpeakerphone 切换当前的音频路由。成功改变音频路由后，SDK 会触发 onAudioRoutingChanged 回调。该方法只设置用户在当前频道内使用的音频路由，不会影响 SDK 默认的音频路由。如果用户离开当前频道并加入新的频道，则用户还是会使用 SDK 默认的音频路由。该方法仅适用于 Android 和 iOS 平台。该方法需要在加入频道后调用。如果用户使用了蓝牙耳机、有线耳机等外接音频播放设备，则该方法的设置无效，音频只会通过外接设备播放。当有多个外接设备时，音频会通过最后一个接入的设备播放。
  ///
  /// * [speakerOn] 设置是否开启扬声器播放： true: 开启。音频路由为扬声器。false: 关闭。音频路由为听筒。
  Future<void> setEnableSpeakerphone(bool speakerOn);

  /// 检查扬声器状态启用状态。
  /// 该方法仅适用于 Android 和 iOS。该方法在加入频道前后都能调用。
  ///
  /// Returns
  /// true: 扬声器已开启，语音会输出到扬声器。false: 扬声器未开启，语音会输出到非扬声器（听筒，耳机等）。
  Future<bool> isSpeakerphoneEnabled();

  /// 获取可共享的屏幕和窗口对象列表。
  /// 屏幕共享或窗口共享前，你可以调用该方法获取可共享的屏幕和窗口的对象列表，方便用户通过列表中的缩略图选择共享某个显示器的屏幕或某个窗口。列表中包含窗口 ID 和屏幕 ID 等重要信息，你可以获取到 ID 后再调用 startScreenCaptureByWindowId 或 startScreenCaptureByDisplayId 开启共享。
  ///
  /// * [thumbSize] 屏幕或窗口的缩略图的目标尺寸（宽高单位为像素）。 SDK 会在保证原图不变形的前提下，缩放原图，使图片最长边和目标尺寸的最长边的长度一致。例如，原图宽高为 400 × 300，thumbSize 为 100 x 100，缩略图实际尺寸为 100 × 75。如果目标尺寸大于原图尺寸，缩略图即为原图，SDK 不进行缩放操作。
  /// * [iconSize] 程序所对应的图标的目标尺寸（宽高单位为像素）。SDK 会在保证原图不变形的前提下，缩放原图，使图片最长边和目标尺寸的最长边的长度一致。例如，原图宽高为 400 × 300，iconSize 为 100 × 100，图标实际尺寸为 100 × 75。如果目标尺寸大于原图尺寸，图标即为原图，SDK 不进行缩放操作。
  /// * [includeScreen] 除了窗口信息外，SDK 是否返回屏幕信息：
  ///  true：SDK 返回屏幕和窗口信息。 false：SDK 仅返回窗口信息。
  Future<List<ScreenCaptureSourceInfo>> getScreenCaptureSources(
      {required SIZE thumbSize,
      required SIZE iconSize,
      required bool includeScreen});

  /// 设置 SDK 对 Audio Session 的操作权限。
  /// 默认情况下，SDK 和 app 对 Audio Session 都有操作权限。如果你只需使用 app 对 Audio Session 进行操作，你可以调用该方法限制 SDK 对 Audio Session 的操作权限。该方法在加入频道前后都能调用。一旦调用该方法限制了 SDK 对 Audio Session 的操作权限，该限制会在 SDK 需要更改 Audio Session 时生效。该方法仅适用于 iOS 平台。该方法不会限制 app 对 Audio Session 的操作权限。
  ///
  /// * [restriction] SDK 对 Audio Session 的操作权限，详见 AudioSessionOperationRestriction 。该参数为 Bit Mask，每个 Bit 对应一个权限。
  Future<void> setAudioSessionOperationRestriction(
      AudioSessionOperationRestriction restriction);

  /// 通过屏幕 ID 共享屏幕。
  /// 共享一个屏幕或该屏幕的部分区域。开启屏幕共享有如下两种方案，你可以根据实际场景进行选择：
  ///  在加入频道前调用该方法，然后调用 joinChannel [2/2] 加入频道并设置 publishScreenTrack 或 publishSecondaryScreenTrack 为 true，即可开始屏幕共享。在加入频道后调用该方法，然后调用 updateChannelMediaOptions 设置 publishScreenTrack 或 publishSecondaryScreenTrack 为 true，即可开始屏幕共享。该方法仅适用于 Windows 和 macOS。
  ///
  /// * [displayId] 指定待共享的屏幕 ID。
  ///
  /// * [regionRect] （可选）指定待共享区域相对于整个屏幕的位置。如不填，则表示共享整个屏幕。详见 Rectangle 。
  /// * [captureParams] 屏幕共享的参数配置。默认的视频编码分辨率为 1920 × 1080，即 2073600 像素。该像素值为计费标准。详见 ScreenCaptureParameters 。
  Future<void> startScreenCaptureByDisplayId(
      {required int displayId,
      required Rectangle regionRect,
      required ScreenCaptureParameters captureParams});

  /// 通过指定区域共享屏幕。
  /// 开启屏幕共享有如下两种方案，你可以根据实际场景进行选择： 在加入频道前调用该方法，然后调用 joinChannel [2/2] 加入频道并设置 publishScreenTrack 或 publishSecondaryScreenTrack 为 true，即可开始屏幕共享。
  ///  在加入频道后调用该方法，然后调用 updateChannelMediaOptions 设置 publishScreenTrack 或 publishSecondaryScreenTrack 为 true，即可开始屏幕共享。 弃用：该方法已废弃。请改用 startScreenCaptureByDisplayId 。如果你需要在设备外接其他显示屏的情况下开启屏幕共享，Agora 强烈建议你使用 startScreenCaptureByDisplayId。共享一个屏幕或该屏幕的部分区域。你需要在该方法中指定想要共享的屏幕区域。该方法仅适用于 Windows 平台。
  ///
  /// * [screenRect] 指定待共享的屏幕相对于虚拟屏的位置。
  /// * [regionRect]  Rectangle 。如果设置的共享区域超出了屏幕的边界，则只共享屏幕内的内容；如果将 width 或 height 设为 0 ，则共享整个屏幕。
  /// * [captureParams] 屏幕共享的编码参数配置。默认的分辨率为 1920 x 1080，即 2073600 像素。该像素值为计费标准。详见 ScreenCaptureParameters 。
  Future<void> startScreenCaptureByScreenRect(
      {required Rectangle screenRect,
      required Rectangle regionRect,
      required ScreenCaptureParameters captureParams});

  /// 获取音频设备信息。
  /// 调用该方法后，你可以获取音频设备是否支持极低延时采集和播放。该方法仅适用于 Android 平台。该方法在加入频道前后均可调用。
  ///
  /// Returns
  /// 包含音频设备信息的 DeviceInfo 对象。 非空：方法调用成功。空：方法调用失败。
  Future<DeviceInfo> getAudioDeviceInfo();

  /// 通过窗口 ID 共享窗口。
  /// 开启屏幕共享有如下两种方案，你可以根据实际场景进行选择： 在加入频道前调用该方法，然后调用 joinChannel [2/2] 加入频道并设置 publishScreenTrack 或 publishSecondaryScreenTrack 为 true，即可开始屏幕共享。
  ///  在加入频道后调用该方法，然后调用 updateChannelMediaOptions 设置 publishScreenTrack 或 publishSecondaryScreenTrack 为 true，即可开始屏幕共享。 共享一个窗口或该窗口的部分区域。用户需要在该方法中指定想要共享的窗口 ID。该方法仅适用于 macOS 和 Windows 平台。Agora SDK 的窗口共享功能依赖于 WGC（Windows Graphics Capture）或 GDI（Graphics Device Interface）采集，WGC 在早于 Windows 10 2004 的系统上无法设置关闭鼠标采集，因此，当你在搭载早于 Windows 10 2004 系统的设备上进行窗口共享时，可能出现 captureMouseCursor(false) 不生效的现象。详见 ScreenCaptureParameters 。该方法支持共享通用 Windows 平台（UWP）应用窗口。声网使用最新版 SDK 对主流的 UWP 应用进行了测试，结果如下：
  ///
  /// * [windowId] 指定待共享的窗口 ID。
  ///
  /// * [regionRect] （可选）指定待共享区域相对于整个屏幕的位置。如不填，则表示共享整个屏幕。详见 Rectangle 。如果设置的共享区域超出了窗口的边界，则只共享窗口内的内容；如果宽或高为 0，则共享整个窗口。
  /// * [captureParams] 屏幕共享的参数配置。默认的分辨率为 1920 x 1080，即 2073600 像素。该像素值为计费标准。详见 ScreenCaptureParameters 。
  Future<void> startScreenCaptureByWindowId(
      {required int windowId,
      required Rectangle regionRect,
      required ScreenCaptureParameters captureParams});

  /// 设置屏幕共享内容类型。
  /// Agora SDK 会根据不同的内容类型，使用不同的算法对共享效果进行优化。如果不调用该方法，SDK 会将屏幕共享的内容默认为 contentHintNone，即无指定的内容类型。该方法在开始屏幕共享前后都能调用。
  ///
  /// * [contentHint] 屏幕共享的内容类型。详见 VideoContentHint 。
  Future<void> setScreenCaptureContentHint(VideoContentHint contentHint);

  /// 设置屏幕共享的场景。
  /// 开启屏幕共享或窗口共享时，你可以调用该方法设置屏幕共享的场景，SDK 会根据你设置的场景调整共享画面的画质。
  ///  该方法仅适用于 macOS 和 Windows。
  ///
  /// * [screenScenario] 屏幕共享的场景，详见 ScreenScenarioType 。
  Future<void> setScreenCaptureScenario(ScreenScenarioType screenScenario);

  /// 更新屏幕共享区域。
  /// 请在开启屏幕共享或窗口共享后调用该方法。
  ///
  /// * [regionRect] 待共享区域相对于整个屏幕或窗口的位置，如不填，则表示共享整个屏幕或窗口。详见 Rectangle 。如果设置的共享区域超出了屏幕或窗口的边界，则只共享屏幕或窗口内的内容；如果将 width 或 height 设为 0，则共享整个屏幕或窗口。
  Future<void> updateScreenCaptureRegion(Rectangle regionRect);

  /// 更新屏幕共享的参数配置。
  /// 该方法适用于 Windows 和 macOS 平台。请在开启屏幕共享或窗口共享后调用该方法。
  ///
  /// * [captureParams] 屏幕共享的编码参数配置。默认的分辨率为 1920 x 1080，即 2073600 像素。该像素值为计费标准。详见 ScreenCaptureParameters
  Future<void> updateScreenCaptureParameters(
      ScreenCaptureParameters captureParams);

  /// 开始屏幕共享。
  /// 开启屏幕共享有如下两种方案，你可以根据实际场景进行选择： 在加入频道前调用该方法，然后调用 joinChannel [2/2] 加入频道并设置 publishScreenCaptureVideo true，即可开始屏幕共享。在加入频道后调用该方法，然后调用 updateChannelMediaOptions 设置 publishScreenCaptureVideotrue，即可开始屏幕共享。该方法适用于 Android 和 iOS 平台。
  ///
  /// * [captureParams] 屏幕共享的编码参数配置。默认的分辨率为 1920 x 1080，即 2,073,600 像素。该像素值为计费标准。详见 ScreenCaptureParameters2 。
  Future<void> startScreenCapture(ScreenCaptureParameters2 captureParams);

  /// 更新屏幕共享的参数配置。
  /// 该方法适用于 Android 和 iOS 平台。
  ///
  /// * [captureParams] 屏幕共享的编码参数配置。默认的分辨率为 1920 x 1080，即 2073600 像素。该像素值为计费标准。详见 ScreenCaptureParameters2 。
  Future<void> updateScreenCapture(ScreenCaptureParameters2 captureParams);

  /// 停止屏幕共享。
  ///
  Future<void> stopScreenCapture();

  /// 获取通话 ID。
  /// 客户端在每次加入频道后会生成一个对应的 callId，标识该客户端的此次通话。有些方法，如 rate 、 complain 等，需要在通话结束后调用，向 SDK 提交反馈。这些方法中需要填入指定的 callId 参数。该方法需要在加入频道后调用。
  ///
  /// Returns
  /// 通话 ID。
  Future<String> getCallId();

  /// 给通话评分。
  /// 该方法需要在用户离开频道后调用。
  ///
  /// * [callId] 通话 ID。你可以通过调用 getCallId 获取该参数。
  /// * [rating] 给通话的评分，最低 1 分，最高 5 分，如超过这个范围，SDK 会返回 -2(ERR_INVALID_ARGUMENT) 错误。
  /// * [description] 给通话的描述。长度应小于 800 字节。
  Future<void> rate(
      {required String callId,
      required int rating,
      required String description});

  /// 投诉通话质量。
  /// 该方法允许用户就通话质量进行投诉。需要在离开频道后调用。
  ///
  /// * [callId] 通话 ID。你可以通过调用 getCallId 获取该参数。
  /// * [description] 通话的描述。长度应小于 800 字节。
  Future<void> complain({required String callId, required String description});

  /// 开始非转码推流。
  /// 请确保已开通旁路推流服务。请在加入频道后调用该方法。只有直播场景下的主播才能调用该方法。调用该方法推流失败后，如果你想要重新推流，那么请你务必先调用 stopRtmpStream ，再调用该方法重推，否则 SDK 会返回与上次推流失败时一样的错误码。调用该方法，你可以向指定的旁路推流地址推送直播音视频流。该方法每次只能向一个地址推送媒体流，如果你需要向多个地址转码推流，则需多次调用该方法。调用该方法后，SDK 会在本地触发 onRtmpStreamingStateChanged 回调，报告推流的状态。
  ///
  /// * [url] 旁路推流地址。格式为 RTMP 或 RTMPS。字符长度不能超过 1024 字节。不支持中文字符等特殊字符。
  Future<void> startRtmpStreamWithoutTranscoding(String url);

  /// 开始旁路推流并设置转码属性。
  /// 调用该方法，你可以向指定的旁路推流地址推送直播音视频流并设置转码属性。该方法每次只能向一个地址推送媒体流，如果你需要向多个地址转码推流，则需多次调用该方法。调用该方法后，SDK 会在本地触发 onRtmpStreamingStateChanged 回调，报告推流的状态。请确保已开通旁路推流服务。请在加入频道后调用该方法。只有直播场景下的主播才能调用该方法。调用该方法推流失败后，如果你想要重新推流，那么请你务必先调用 stopRtmpStream ，再调用该方法重推，否则 SDK 会返回与上次推流失败时一样的错误码。
  ///
  /// * [url] 旁路推流地址。格式为 RTMP 或 RTMPS。字符长度不能超过 1024 字节。不支持中文字符等特殊字符。
  /// * [transcoding] 旁路推流的转码属性，详见 LiveTranscoding 类。
  Future<void> startRtmpStreamWithTranscoding(
      {required String url, required LiveTranscoding transcoding});

  /// 更新旁路推流转码属性。
  /// 开启转码推流后，你可以根据场景需求，动态更新转码属性。转码属性更新后，SDK 会触发 onTranscodingUpdated 回调。
  ///
  /// * [transcoding] 旁路推流的转码属性，详见 LiveTranscoding 类。
  Future<void> updateRtmpTranscoding(LiveTranscoding transcoding);

  /// 结束旁路推流。
  /// 调用该方法，你可以结束指定的旁路推流地址上的直播。该方法每次只能结束一个推流地址上的直播，如果你需要结束多个推流地址的直播，则需多次调用该方法。调用该方法后，SDK 会在本地触发 onRtmpStreamingStateChanged 回调，报告推流的状态。
  ///
  /// * [url] 旁路推流地址。格式为 RTMP 或 RTMPS。字符长度不能超过 1024 字节。不支持中文字符等特殊字符。
  Future<void> stopRtmpStream(String url);

  /// 开启本地合图。
  /// 调用该方法后，你可以在本地将多路视频流合并为一路视频流。常见场景如下：
  ///  在多主播直播场景或使用旁路推流功能时，你可以在本地将多个主播的画面合并为一个画面。将本地采集的多路视频流（例如：摄像头采集的视频、屏幕共享流、视频文件、图片等）合并为一路视频流，加入频道后推送已合图的视频流。
  ///
  /// * [config] 本地合图的配置，详见 LocalTranscoderConfiguration 。
  Future<void> startLocalVideoTranscoder(LocalTranscoderConfiguration config);

  /// 更新本地合图配置。
  /// 调用 startLocalVideoTranscoder 后，如果你希望更新本地合图配置，请调用该方法。
  ///
  /// * [config] 本地合图的配置，详见 LocalTranscoderConfiguration 。
  Future<void> updateLocalTranscoderConfiguration(
      LocalTranscoderConfiguration config);

  /// 停止本地合图。
  /// 调用 startLocalVideoTranscoder 后， 如果你希望停止本地合图，请调用该方法。
  Future<void> stopLocalVideoTranscoder();

  /// 开始通过第一个摄像头采集视频。
  ///
  ///
  /// * [config] 视频采集配置。详见 CameraCapturerConfiguration 。
  Future<void> startPrimaryCameraCapture(CameraCapturerConfiguration config);

  /// 开始通过第二个摄像头采集视频。
  ///
  ///
  /// * [config] 视频采集配置。详见 CameraCapturerConfiguration 。
  Future<void> startSecondaryCameraCapture(CameraCapturerConfiguration config);

  /// 停止通过第一个摄像头采集视频。
  /// 调用 startPrimaryCameraCapture 后，你可以调用本方法停止通过第一个摄像头采集视频。
  Future<void> stopPrimaryCameraCapture();

  /// 停止通过第二个摄像头采集视频。
  /// 调用 startSecondaryCameraCapture 后，你可以调用本方法停止通过第二个摄像头采集视频。
  Future<void> stopSecondaryCameraCapture();

  /// 设置采集视频的旋转角度。
  /// 当视频采集设备不带重力感应功能时，你可以调用该方法手动调整采集到的视频画面的旋转角度。
  ///
  /// * [null] 视频源类型，详见 VideoSourceType
  /// * [orientation] 顺时针旋转角度，详见 VideoOrientation
  ///
  /// Returns
  /// 0: 方法调用成功< 0: 方法调用失败
  Future<void> setCameraDeviceOrientation(
      {required VideoSourceType type, required VideoOrientation orientation});

  /// @nodoc
  Future<void> setScreenCaptureOrientation(
      {required VideoSourceType type, required VideoOrientation orientation});

  /// 开始共享第一个屏幕。
  ///
  ///
  /// * [config] 屏幕采集配置。详见 ScreenCaptureConfiguration 。
  Future<void> startPrimaryScreenCapture(ScreenCaptureConfiguration config);

  /// 开始共享第二个屏幕。
  ///
  ///
  /// * [config] 屏幕采集配置。详见 ScreenCaptureConfiguration 。
  Future<void> startSecondaryScreenCapture(ScreenCaptureConfiguration config);

  /// 停止共享第一个屏幕。
  /// 调用 startPrimaryScreenCapture 后，你可以调用本方法停止共享第一个屏幕。
  Future<void> stopPrimaryScreenCapture();

  /// 停止共享第二个屏幕。
  /// 调用 startSecondaryScreenCapture 后，你可以调用本方法停止共享第二个屏幕。
  Future<void> stopSecondaryScreenCapture();

  /// 获取当前网络连接状态。
  /// 该方法在加入频道前后都能调用。
  ///
  /// Returns
  /// 当前网络连接状态。详见 ConnectionStateType 。
  Future<ConnectionStateType> getConnectionState();

  /// 添加主回调事件。
  /// RtcEngineEventHandler 接口类用于 SDK 向 app 发送回调事件通知，app 通过继承该接口类的方法获取 SDK 的事件通知。
  ///  接口类的所有方法都有缺省（空）实现，app 可以根据需要只继承关心的事件。在回调方法中，app 不应该做耗时或者调用可能会引起阻塞的 API（如 sendStreamMessage），
  ///  否则可能影响 SDK 的运行。
  ///
  /// * [eventHandler] 待添加的回调事件，详见 RtcEngineEventHandler 。
  void registerEventHandler(RtcEngineEventHandler eventHandler);

  /// @nodoc
  void unregisterEventHandler(RtcEngineEventHandler eventHandler);

  /// @nodoc
  Future<void> setRemoteUserPriority(
      {required int uid, required PriorityType userPriority});

  /// 启用内置的加密方案。
  /// 弃用：请改用 enableEncryption 方法。Agora Video SDK 支持内置加密方案，默认支持 AES-128-GCM。如需采用其他加密方案，可以调用本方法。同一频道内的所有用户必须设置相同的加密方式和 secret 才能进行通话。关于这几种加密方式的区别，请参考 AES 加密算法的相关资料。在调用本方法前，请先调用 setEncryptionSecret 启用内置加密功能。
  ///
  /// * [encryptionMode] 加密模式： "aes-128-xts": 128 位 AES 加密，XTS 模式；"aes-128-ecb": 128 位 AES 加密，ECB 模式；"aes-256-xts": 256 位 AES 加密，XTS 模式；"sm4-128-ecb": 128 位 SM4 加密，ECB 模式；"aes-128-gcm": 128 位 AES 加密，GCM 模式；"aes-256-gcm": 256 位 AES 加密，GCM 模式；"": 设置为空字符串时，默认使用加密方式 "aes-128-gcm"。
  Future<void> setEncryptionMode(String encryptionMode);

  /// 启用内置加密，并设置数据加密密码。
  /// 弃用：请改用 enableEncryption 方法。在加入频道之前， app 需调用该方法指定 secret 来启用内置的加密功能，同一频道内的所有用户应设置相同的 secret。
  ///  当用户离开频道时，该频道的 secret 会自动清除。如果未指定 secret 或将 secret 设置为空，则无法激活加密功能。请不要在旁路推流时调用此方法。为保证最佳传输效果，请确保加密后的数据大小不超过原始数据大小 + 16 字节。16 字节是 AES 通用加密模式下最大填充块大小。
  ///
  /// * [secret] 加密密码。
  Future<void> setEncryptionSecret(String secret);

  /// 开启或关闭内置加密。
  /// 在安全要求较高的场景下，Agora 建议你在加入频道前，调用本方法开启内置加密。同一频道内所有用户必须使用相同的加密模式和密钥。用户离开频道后，SDK 会自动关闭加密。如需重新开启加密，你需要在用户再次加入频道前调用该方法。如果开启了内置加密，则不能使用旁路推流功能。
  ///
  /// * [enabled] 是否开启内置加密： true: 开启内置加密。false: 关闭内置加密。
  /// * [config] 配置内置加密模式和密钥。详见 EncryptionConfig 。
  Future<void> enableEncryption(
      {required bool enabled, required EncryptionConfig config});

  /// 发送数据流。
  /// 该方法发送数据流消息到频道内所有用户。SDK 对该方法的实现进行了如下限制： 频道内每秒最多能发送 30 个包，且每个包最大为 1 KB。每个客户端每秒最多能发送 6 KB 数据。频道内每人最多能同时有 5 个数据通道。成功调用该方法后，远端会触发 onStreamMessage 回调，远端用户可以在该回调中获取接收到的流消息；
  ///  若调用失败，远端会触发 onStreamMessageError 回调。请确保在调用该方法前，已调用 createDataStream 创建了数据通道。直播场景下，该方法仅适用于主播用户。
  ///
  /// * [streamId] 数据流 ID。可以通过 createDataStream 获取。
  /// * [data] 待发送的数据。
  /// * [length] 数据长度。
  Future<void> sendStreamMessage(
      {required int streamId, required Uint8List data, required int length});

  /// @nodoc
  Future<void> clearVideoWatermark();

  /// 删除已添加的视频水印。
  ///
  Future<void> clearVideoWatermarks();

  /// @nodoc
  Future<void> addInjectStreamUrl(
      {required String url, required InjectStreamConfig config});

  /// @nodoc
  Future<void> removeInjectStreamUrl(String url);

  /// @nodoc
  Future<void> pauseAudio();

  /// @nodoc
  Future<void> resumeAudio();

  /// 打开与 Web SDK 的互通（仅在直播场景适用）。
  /// 弃用:该方法已废弃，SDK 自动开启与 Web SDK 的互通，无需调用该方法开启。该方法打开或关闭与 Agora Web SDK 的互通。如果有用户通过 Web SDK 加入频道，请确保调用该方法，否则 Web 端用户看 Native 端的画面会是黑屏。该方法仅在直播场景下适用，通信场景下默认互通是打开的。
  ///
  /// * [enabled] 是否打开与 Agora Web SDK 的互通： true: 打开互通。false: (默认) 关闭互通。
  Future<void> enableWebSdkInteroperability(bool enabled);

  /// 发送自定义上报消息。
  /// 声网提供自定义数据上报和分析服务。该服务当前处于免费内测期。内测期提供的能力为 6 秒内最多上报 10 条数据，每条自定义数据不能超过 256 字节，每个字符串不能超过 100 字节。如需试用该服务，请联系 开通并商定自定义数据格式。
  Future<void> sendCustomReportMessage(
      {required String id,
      required String category,
      required String event,
      required String label,
      required int value});

  /// 注册媒体 metadata 观测器用于接收或发送 metadata。
  /// 你需要自行实现 MetadataObserver 类并在本方法中指定 metadata 类型。本方法允许你为视频流添加同步的 metadata，用于多样化的直播互动，如发送购物链接、电子优惠券和在线测试。请在 joinChannel [2/2] 前调用该方法。
  ///
  /// * [observer] metadata 观测器。详见 MetadataObserver 。
  /// * [type] metadata 类型。目前仅支持 videoMetadata。
  void registerMediaMetadataObserver(
      {required MetadataObserver observer, required MetadataType type});

  /// 取消注册媒体 metadata 观测器。
  ///
  void unregisterMediaMetadataObserver(
      {required MetadataObserver observer, required MetadataType type});

  /// @nodoc
  Future<void> startAudioFrameDump(
      {required String channelId,
      required int userId,
      required String location,
      required String uuid,
      required String passwd,
      required int durationMs,
      required bool autoUpload});

  /// @nodoc
  Future<void> stopAudioFrameDump(
      {required String channelId,
      required int userId,
      required String location});

  /// 注册本地用户 User Account。
  /// 该方法为本地用户注册一个 User Account。注册成功后，该 User Account 即可标识该本地用户的身份，用户可以使用它加入频道。成功注册 User Account 后，本地会触发 onLocalUserRegistered 回调，告知本地用户的 UID 和 User Account。该方法为可选。如果你希望用户使用 User Account 加入频道，可以选用以下两种方式： 先调用 registerLocalUserAccount 方法注册 Account，再调用 joinChannelWithUserAccount 方法加入频道。直接调用 joinChannelWithUserAccount 方法加入频道。两种方式的区别在于，提前调用 registerLocalUserAccount，可以缩短使用 joinChannelWithUserAccount 进入频道的时间。userAccount 不能为空，否则该方法不生效。请确保在该方法中设置的 userAccount 在频道中的唯一性。为保证通信质量，请确保频道内使用同一类型的数据标识用户身份。即同一频道内需要统一使用 UID 或 User Account。 如果有用户通过 Agora Web SDK 加入频道，请确保 Web 加入的用户也是同样类型。
  ///
  /// * [appId] 你的项目在 Agora 控制台注册的 App ID。
  /// * [userAccount] 用户 User Account。该参数用于标识实时音视频互动频道中的用户。你需要自行设置和管理用户的 User Account，并确保同一频道中每个用户的 User Account 是唯一的。该参数为必填，最大不超过 255 字节，不可填 NULL。以下为支持的字符集范围（共 89 个字符）： 26 个小写英文字母 a-z26 个大写英文字母 A-Z10 个数字 0-9空格"!"、"#"、"$"、"%"、"&"、"("、")"、"+"、"-"、":"、";"、"<"、"="、"."、">"、"?"、"@"、"["、"]"、"^"、"_"、"{"、"}"、"|"、"~"、","
  Future<void> registerLocalUserAccount(
      {required String appId, required String userAccount});

  /// 使用 User Account 加入频道，并设置是否自动订阅音频或视频流。
  /// 为保证通信质量，请确保频道内使用同一类型的数据标识用户身份。即同一频道内需要统一使用 UID 或 User Account。如果有用户通过 Agora Web SDK 加入频道，请确保 Web 加入的用户也是同样类型。用户成功加入频道后，默认订阅频道内所有其他用户的音频流和视频流，因此产生用量并影响计费。如果想取消订阅，可以通过调用相应的 mute 方法实现。该方法允许本地用户使用 User Account 加入频道。成功加入频道后，会触发以下回调：
  ///  本地： onLocalUserRegistered 、 onJoinChannelSuccess 和 onConnectionStateChanged 回调。远端：通信场景下的用户和直播场景下的主播加入频道后，远端会分别触发 onUserJoined 和 onUserInfoUpdated 回调。
  ///
  /// * [userAccount] 用户 User Account。该参数用于标识实时音视频互动频道中的用户。你需要自行设置和管理用户的 User Account，并确保同一频道中每个用户的 User Account 是唯一的。 该参数为必填，最大不超过 255 字节，不可填 NULL。以下为支持的字符集范围（共 89 个字符）： 26 个小写英文字母 a-z26 个大写英文字母 A-Z10 个数字 0-9空格"!"、"#"、"$"、"%"、"&"、"("、")"、"+"、"-"、":"、";"、"<"、"="、"."、">"、"?"、"@"、"["、"]"、"^"、"_"、"{"、"}"、"|"、"~"、","
  /// * [token] 在服务端生成的用于鉴权的动态密钥。详见。
  /// * [channelId] 频道名。该参数标识用户进行实时音视频互动的频道。App ID 一致的前提下，填入相同频道名的用户会进入同一个频道进行音视频互动。该参数为长度在 64 字节以内的字符串。以下为支持的字符集范围（共 89 个字符）:
  ///  26 个小写英文字母 a~z26 个大写英文字母 A~Z10 个数字 0~9空格"!"、"#"、"$"、"%"、"&"、"("、")"、"+"、"-"、":"、";"、"<"、"="、"."、">"、"?"、"@"、"["、"]"、"^"、"_"、"{"、"}"、"|"、"~"、","
  /// * [options] 频道媒体设置选项。详见 ChannelMediaOptions 。
  Future<void> joinChannelWithUserAccountEx(
      {required String token,
      required String channelId,
      required String userAccount,
      required ChannelMediaOptions options});

  /// 通过 User Account 获取用户信息。
  /// 远端用户加入频道后，SDK 会获取到该远端用户的 UID 和 User Account，然后缓存一个包含了远端用户 UID 和 User Account 的 Mapping 表，并在本地触发 onUserInfoUpdated 回调。收到这个回调后，你可以调用该方法，通过传入 UID 获取包含了指定用户 User Account 的 UserInfo 对象。
  ///
  /// * [userAccount] 用户 User Account。
  ///
  /// Returns
  /// 包含用户信息的 UserInfo 对象。 方法调用成功，返回 UserInfo 对象。
  ///  方法调用失败，则返回 NULL。
  Future<UserInfo> getUserInfoByUserAccount(String userAccount);

  /// 通过 UID 获取用户信息。
  /// 远端用户加入频道后，SDK 会获取到该远端用户的 UID 和 User Account，然后缓存一个包含了远端用户 UID 和 User Account 的 Mapping 表，并在本地触发 onUserInfoUpdated 回调。收到这个回调后，你可以调用该方法，通过传入 UID 获取包含了指定用户 User Account 的 UserInfo 对象。
  ///
  /// * [uid] 用户 ID。
  ///
  /// Returns
  /// 包含用户信息的 UserInfo 对象。方法调用成功，返回 UserInfo 对象。方法调用失败，则返回 NULL。
  Future<UserInfo> getUserInfoByUid(int uid);

  /// 开始跨频道媒体流转发。该方法可用于实现跨频道连麦等场景。
  /// 成功调用该方法后，SDK 会触发 onChannelMediaRelayStateChanged 和 onChannelMediaRelayEvent 回调，并在回调中报告当前的跨频道媒体流转发状态和事件。 如果 onChannelMediaRelayStateChanged 回调报告 relayStateRunning (2) 和 relayOk (0)，且 onChannelMediaRelayEvent 回调报告 relayEventPacketSentToDestChannel (4)， 则表示 SDK 开始在源频道和目标频道之间转发媒体流。如果 onChannelMediaRelayStateChanged 回调报告 relayStateFailure (3)， 则表示跨频道媒体流转发出现异常。请在成功加入频道后调用该方法。在直播场景中，只有角色为主播的用户才能调用该方法。成功调用该方法后，若你想再次调用该方法，必须先调用 stopChannelMediaRelay 方法退出当前的转发状态。跨频道媒体流转发功能需要开通。该功能不支持 String 型 UID。
  ///
  /// * [configuration] 跨频道媒体流转发参数配置。详见 ChannelMediaRelayConfiguration 。
  Future<void> startChannelMediaRelay(
      ChannelMediaRelayConfiguration configuration);

  /// 更新媒体流转发的频道。
  /// 成功开始跨频道转发媒体流后，如果你希望将流转发到多个目标频道，或退出当前的转发频道，可以调用该方法。成功调用该方法后，SDK 会触发 onChannelMediaRelayEvent 回调， 并在回调中报告状态码 relayEventPacketUpdateDestChannel (7)。请在成功调用 startChannelMediaRelay 方法并收到 onChannelMediaRelayStateChanged (relayStateRunning, relayOk) 后调用该方法；否则，方法调用会失败。
  ///
  /// * [configuration] 跨频道媒体流转发参数配置。详见 ChannelMediaRelayConfiguration 。
  Future<void> updateChannelMediaRelay(
      ChannelMediaRelayConfiguration configuration);

  /// 停止跨频道媒体流转发。一旦停止，主播会退出所有目标频道。
  /// 成功调用该方法后，SDK 会触发 onChannelMediaRelayStateChanged 回调。如果报告 relayStateIdle (0) 和 relayOk (0)，则表示已停止转发媒体流。
  ///  如果该方法调用不成功，SDK 会触发 onChannelMediaRelayStateChanged 回调，并报告状态码 relayErrorServerNoResponse (2) 或 relayErrorServerConnectionLost (8)。你可以调用 leaveChannel 方法离开频道，跨频道媒体流转发会自动停止。
  Future<void> stopChannelMediaRelay();

  /// 暂停向所有目标频道转发媒体流。
  /// 开始跨频道转发媒体流后，如果你需要暂停向所有频道转发媒体流，可以调用该方法；暂停后，如果要恢复跨频道媒体流转发，可以调用 resumeAllChannelMediaRelay 方法。成功调用该方法后，SDK 会触发 onChannelMediaRelayEvent 回调，并在回调中报告是否成功暂停媒体流转发。该方法需要在 startChannelMediaRelay 后调用。
  Future<void> pauseAllChannelMediaRelay();

  /// 恢复向所有目标频道转发媒体流。
  /// 调用 pauseAllChannelMediaRelay 方法后，如果你需要恢复向所有目标频道转发媒体流，可以调用该方法。成功调用该方法后，SDK 会触发 onChannelMediaRelayEvent 回调，并在回调中报告是否成功恢复媒体流转发。该方法需要在 pauseAllChannelMediaRelay 后调用。
  Future<void> resumeAllChannelMediaRelay();

  /// 设置主播端直接向 CDN 推流时的音频编码属性。
  /// 该方法仅对麦克风采集或自采集的音频有效，即对在 DirectCdnStreamingMediaOptions 中设置 publishMicrophoneTrack 或 publishCustomAudioTrack 为 true 时所采集的音频有效。
  ///
  /// * [profile] 音频编码属性，包含采样率、码率、编码模式和声道数。详见 AudioProfileType 。
  Future<void> setDirectCdnStreamingAudioConfiguration(
      AudioProfileType profile);

  /// 设置主播端直接向 CDN 推流时的视频编码属性。
  /// 该方法仅对摄像头采集、屏幕共享或自采集的视频有效。
  ///
  /// * [config] 视频编码参数配置。详见 VideoEncoderConfiguration 。
  Future<void> setDirectCdnStreamingVideoConfiguration(
      VideoEncoderConfiguration config);

  /// 设置主播端开始直接向 CDN 推流。
  /// Agora 不支持同一时间向同一个 URL 重复推流。媒体选项说明Agora 不支持 publishCameraTrack 和 publishCustomVideoTrack 同时为 true，也不支持 publishMicrophoneTrack 和 publishCustomAudioTrack 同时为 true。你可以根据场景需求设置媒体选项 ( DirectCdnStreamingMediaOptions )。示例如下：如果你想推送主播端采集的音视频流，请将媒体选项进行如下设置：publishCustomAudioTrack 设为 true 并调用 pushAudioFrame publishCustomVideoTrack 设为 true 并调用 pushVideoFrame 确保 publishCameraTrack 为 false(默认值)确保 publishMicrophoneTrack 为 false(默认值)
  ///
  /// * [eventHandler] 详见 onDirectCdnStreamingStateChanged 及 onDirectCdnStreamingStats 。
  /// * [publishUrl] CDN 推流 URL。
  /// * [options] 主播端的媒体选项。详见 DirectCdnStreamingMediaOptions 。
  Future<void> startDirectCdnStreaming(
      {required DirectCdnStreamingEventHandler eventHandler,
      required String publishUrl,
      required DirectCdnStreamingMediaOptions options});

  /// 设置主播端停止直接向 CDN 推流。
  ///
  Future<void> stopDirectCdnStreaming();

  /// @nodoc
  Future<void> updateDirectCdnStreamingMediaOptions(
      DirectCdnStreamingMediaOptions options);

  /// 开启虚拟节拍器。
  /// 在音乐教学、体育教学等场景中，老师通常需要使用节拍器，让学生跟着正确的节拍练习。 节拍由强拍和弱拍组成，每小节的第一拍称为强拍，其余称为弱拍。你需要在该方法中设置强拍和弱拍的文件路径、每小节的拍数、节拍速度以及是否将节拍器的声音发送至远端。该方法仅适用于 Android 和 iOS。开启虚拟节拍器后，SDK 会从头开始播放指定的音频文件，并根据你在 AgoraRhythmPlayerConfig 中设置的 beatsPerMinute 控制每个文件的播放时长。例如，将 beatsPerMinute 设为 60，则 SDK 会 1 秒播放 1 个节拍。如果文件时长超过了节拍时长，则 SDK 只播放节拍时长部分的音频。虚拟节拍器的声音默认会发布至远端，如果你不希望远端用户听到虚拟节拍器的声音，你可以将 ChannelMediaOptions 中的 publishRhythmPlayerTrack 设为 false。
  ///
  /// * [sound1] 强拍文件的绝对路径或 URL 地址，需精确到文件名及后缀。例如 C:\music\audio.mp4。支持的音频文件格式见 Agora RTC SDK 支持播放哪些格式的音频文件。
  ///
  /// * [sound2] 弱拍文件的绝对路径或 URL 地址，需精确到文件名及后缀。例如 C:\music\audio.mp4。支持的音频文件格式见 Agora RTC SDK 支持播放哪些格式的音频文件。
  ///
  /// * [config] 节拍器配置。详见 AgoraRhythmPlayerConfig 。
  Future<void> startRhythmPlayer(
      {required String sound1,
      required String sound2,
      required AgoraRhythmPlayerConfig config});

  /// 关闭虚拟节拍器。
  /// 调用 startRhythmPlayer 后，你可以调用该方法关闭虚拟节拍器。该方法仅适用于 Android 和 iOS。
  Future<void> stopRhythmPlayer();

  /// 配置虚拟节拍器。
  /// 该方法仅适用于 Android 和 iOS。开启虚拟节拍器后，SDK 会从头开始播放指定的音频文件，并根据你在 AgoraRhythmPlayerConfig 中设置的 beatsPerMinute 控制每个文件的播放时长。例如，将 beatsPerMinute 设为 60，则 SDK 会 1 秒播放 1 个节拍。如果文件时长超过了节拍时长，则 SDK 只播放节拍时长部分的音频。虚拟节拍器的声音默认会发布至远端，如果你不希望远端用户听到虚拟节拍器的声音，你可以将 ChannelMediaOptions 中的 publishRhythmPlayerTrack 设为 false。调用 startRhythmPlayer 后，你可以调用该方法重新配置虚拟节拍器。
  ///
  /// * [config] 节拍器配置。详见 AgoraRhythmPlayerConfig 。
  Future<void> configRhythmPlayer(AgoraRhythmPlayerConfig config);

  /// 获取视频截图。
  /// 该方法用于对指定用户的视频流进行截图，生成一张 JPG 格式的图片，并保存至指定的路径。该方法是异步操作，调用返回时 SDK 并没有真正获取截图。成功调用该方法后，SDK 会触发 onSnapshotTaken 回调报告截图是否成功和获取截图的详情。该方法需要在加入频道后调用。该方法对 ChannelMediaOptions 中指定发布的视频流进行截图。如果用户的视频经过前处理，例如，添加了水印或美颜，生成的截图会包含前处理效果。
  ///
  /// * [uid] 用户 ID。如果要对本地用户的视频截图，则设为 0。
  /// * [filePath] 截图的本地保存路径，需精确到文件名及格式， 例如：
  ///  Windows: C:\Users\<user_name>\AppData\Local\Agora\<process_name>\example.jpgiOS: /App Sandbox/Library/Caches/example.jpgmacOS: ～/Library/Logs/example.jpgAndroid: /storage/emulated/0/Android/data/<package name>/files/example.jpg请确保目录存在且可写。
  Future<void> takeSnapshot({required int uid, required String filePath});

  /// 开启/关闭视频内容审核。
  /// 开启视频内容审核后，SDK 会根据你在 ContentInspectConfig 中设置的内容审核模块类型和频率对本地用户发送的视频进行截图、审核和上传。审核完成后，Agora 内容审核服务器会以 HTTPS 请求的形式，向你的服务器发送审核结果，并将所有截图发送至你指定的第三方云存储。如果你将 ContentInspectModule 中的 type 设置为 contentInspectModeration（视频鉴黄），审核完成后，SDK 会触发 onContentInspectResult 回调，报告鉴黄结果。调用该方法前，请确保已开通 Agora 视频内容审核服务。
  ///
  /// * [enabled] 设置是否开启视频内容审核：
  ///  true：开启。false：关闭。
  /// * [config] 内容审核配置。详见 ContentInspectConfig 。
  Future<void> enableContentInspect(
      {required bool enabled, required ContentInspectConfig config});

  /// 调节自定义采集的外部音频源在远端播放的音量。
  /// 在调用该方法前，请确保你已经调用 setExternalAudioSource 方法创建自定义采集的音频轨道。调用该方法设置音频在远端播放的音量后，如果你想重新调整音量，你可以再次调用该方法。
  ///
  /// * [sourceId] 外部音频源的 ID。如果你要发布自定义的外部音频源，则将该参数设置为你想要发布的自定义音频轨道 ID。
  /// * [volume] 自定义采集音频的播放音量，取值范围为 [0,100]。0 表示静音，100 表示原始音量。
  Future<void> adjustCustomAudioPublishVolume(
      {required int sourceId, required int volume});

  /// @nodoc
  Future<void> adjustCustomAudioPlayoutVolume(
      {required int sourceId, required int volume});

  /// 设置 Agora 云代理服务。
  /// 当用户的网络访问受到防火墙限制时，你需要将 Agora 提供的 IP 和端口号添加到防火墙白名单，然后调用该方法开启云代理，并通过 proxyType 参数设置云代理类型。成功连接云代理后，SDK 会触发 onConnectionStateChanged (connectionStateConnecting, connectionChangedSettingProxyServer) 回调。
  ///  如果你想关闭已设置的 Force UDP 或 Force TCP 云代理，请调用 setCloudProxy (noneProxy)。如果你想更改已设置的云代理类型，请先调用 setCloudProxy (noneProxy)，再调用 setCloudProxy 并传入你期望的 proxyType 值。
  ///  Agora 推荐你在频道外调用该方法。如果用户处于内网防火墙环境下，使用 Force UDP 云代理时，旁路推流和跨频道媒体流转发功能不可用。使用 Force UDP 云代理时，调用 startAudioMixing 方法时无法播放 HTTP 协议的在线音频文件。旁路推流和跨频道媒体流转发功能会使用 TCP 协议的云代理。
  ///
  /// * [proxyType] 云代理类型，详见 CloudProxyType 。该参数为必填参数，如果你不赋值，SDK 会报错。
  Future<void> setCloudProxy(CloudProxyType proxyType);

  /// 配置与声网私有媒体服务器 Native 接入模块的连接。
  /// 成功部署声网私有媒体服务器并在内网终端集成 Agora Native SDK v4.0.0 后，你可以调用该方法指定 Local Access Point，给 SDK 分配 Native 接入模块。该方法仅在部署声网混合云方案后生效。你可以联系 了解和部署声网混合云。该方法需要在加入频道前调用。
  ///
  /// * [config] Local Access Point 配置。详见 LocalAccessPointConfiguration 。
  Future<void> setLocalAccessPoint(LocalAccessPointConfiguration config);

  /// 设置音频的高级选项。
  /// 如果你对音频处理有进阶需求，例如需要采集和发送立体声，可以调用该方法设置音频的高级选项。该方法仅适用于 Android 和 iOS 平台。你需要在 joinChannel [2/2] 、 enableAudio 和 enableLocalAudio 前调用该方法。
  ///
  /// Returns
  /// 音频的高级选项。详见 AdvancedAudioOptions 。
  Future<AdvancedAudioOptions> setAdvancedAudioOptions();

  /// 设置发流端音画同步。
  /// 同一用户可能使用两个设备分别发送音频流和视频流，为保证接收端听到和看到的音频和视频的时间同步性，你可以在视频发送端调用该方法，并传入音频发送端的频道名、用户 ID。 SDK 会以发送的音频流的时间戳为基准进行自动调节发送的视频流，以保证即使在两个发送端的上行网络情况不一致（如分别使用 Wi-Fi 和 4G 网络）的情况下，也能让接收到的音视频具有时间同步性。Agora 推荐你在加入频道前调用该方法。
  ///
  /// * [channelId] 标识音频发送端所在频道的频道名。
  /// * [uid] 音频发送端的用户 ID。
  Future<void> setAVSyncSource({required String channelId, required int uid});

  /// 设置是否开启垫片推流功能。
  /// Agora 推荐你在加入频道后调用该方法。在发布视频流时，你可以调用该方法使用自定义图片来替代当前发布的视频流画面进行推流。开启该功能后，你可以通过 ImageTrackOptions 参数自定义垫片图片；在你关闭垫片功能之后，远端用户看到的依旧是当前你发布的视频流画面。
  ///
  /// * [enable] 是否开启垫片推流：
  ///  true：开启垫片推流。false：（默认）关闭垫片推流。
  /// * [options] 垫片图片设置，详见 ImageTrackOptions 。
  Future<void> enableVideoImageSource(
      {required bool enable, required ImageTrackOptions options});

  /// @nodoc
  Future<void> enableWirelessAccelerate(bool enabled);

  /// 设置媒体选项并加入频道。
  /// 该方法让用户加入通话频道，在同一个频道内的用户可以互相通话，多个用户加入同一个频道，可以群聊。 使用不同 App ID 的 app 不能互通。成功调用该方法加入频道后会触发以下回调： 本地会触发 onJoinChannelSuccess 和 onConnectionStateChanged 回调。通信场景下的用户和直播场景下的主播加入频道后，远端会触发 onUserJoined 回调。在网络状况不理想的情况下，客户端可能会与 Agora 服务器失去连接；SDK 会自动尝试重连，重连成功后，本地会触发 onRejoinChannelSuccess 回调。该方法允许用户一次加入仅一个频道。请务必确保用于生成 Token 的 App ID 和 initialize 方法初始化引擎时用的是同一个 App ID，否则使用 Token 加入频道失败。
  ///
  /// * [token] 在服务端生成的用于鉴权的动态密钥。详见。
  /// * [channelId] 频道名。该参数标识用户进行实时音视频互动的频道。App ID 一致的前提下，填入相同频道名的用户会进入同一个频道进行音视频互动。该参数为长度在 64 字节以内的字符串。以下为支持的字符集范围（共 89 个字符）:
  ///  26 个小写英文字母 a~z26 个大写英文字母 A~Z10 个数字 0~9空格"!"、"#"、"$"、"%"、"&"、"("、")"、"+"、"-"、":"、";"、"<"、"="、"."、">"、"?"、"@"、"["、"]"、"^"、"_"、"{"、"}"、"|"、"~"、","
  /// * [uid] 用户 ID。该参数用于标识在实时音视频互动频道中的用户。你需要自行设置和管理用户 ID，并确保同一频道内的每个用户 ID 是唯一的。该参数为 32 位无符号整数。 建议设置范围：1 到 232-1。如果不指定（即设为 0），SDK 会自动分配一个，并在 onJoinChannelSuccess 回调中返回， app 层必须记住该返回值并维护，SDK 不对该返回值进行维护。
  /// * [options] 频道媒体设置选项。详见 ChannelMediaOptions 。
  Future<void> joinChannel(
      {required String token,
      required String channelId,
      required int uid,
      required ChannelMediaOptions options});

  /// 离开频道。
  /// 该方法会把会话相关的所有资源释放掉。该方法是异步操作，调用返回时并没有真正退出频道。成功加入频道后，必须调用本方法或者 leaveChannel 结束通话，否则无法开始下一次通话。成功调用该方法、并且离开频道后会触发以下回调：
  ///  本地： onLeaveChannel 回调。远端：通信场景下的用户和直播场景下的主播离开频道后，远端会触发 onUserOffline 回调。如果你调用了本方法后立即调用 release 方法，SDK 将无法触发 onLeaveChannel 回调。
  Future<void> leaveChannel({LeaveChannelOptions? options});

  /// 设置直播场景下的用户角色和级别。
  /// 直播场景下，SDK 会默认设置用户角色为观众，你可以调用该方法设置用户角色为主播。该方法在加入频道前后均可调用。如果你在加入频道前调用该方法设置用户角色为主播、并且通过 setupLocalVideo 方法设置了本地视频属性，则用户加入频道时会自动开启本地视频预览。如果你在加入频道后调用该方法切换用户角色，调用成功后，SDK 会自动进行如下操作：
  ///  调用 muteLocalAudioStream 和 muteLocalVideoStream 修改发布状态。本地触发 onClientRoleChanged 回调。远端触发 onUserJoined 或 onUserOffline 回调。该方法仅适用于直播场景（ setChannelProfile 中 profile 设为 channelProfileLiveBroadcasting）。
  ///
  /// * [role] 直播场景中的用户角色。详见 ClientRoleType 。
  /// * [options] 用户具体设置，包含用户级别。详见 ClientRoleOptions 。
  Future<void> setClientRole(
      {required ClientRoleType role, ClientRoleOptions? options});

  /// 开始语音通话回路测试。
  /// 该方法启动语音通话测试，目的是测试系统的音频设备（耳麦、扬声器等）和网络连接是否正常。在测试过程中，用户先说一段话，声音会在设置的时间间隔（单位为秒）后回放出来。如果用户能正常听到自己刚才说的话，就表示系统音频设备和网络连接都是正常的。请在加入频道前调用该方法。
  ///  调用 startEchoTest 后必须调用 stopEchoTest 以结束测试，否则不能进行下一次回声测试，也无法加入频道。
  ///  直播场景下，该方法仅能由用户角色为主播的用户调用。
  ///
  /// * [intervalInSeconds] 设置返回语音通话回路测试结果的时间间隔，取值范围为 [2,10]，单位为秒，默认为 10 秒。
  Future<void> startEchoTest({int intervalInSeconds = 10});

  /// 开启视频预览并指定预览的视频源。
  /// 该方法用于启动本地视频预览。调用该 API 前，必须： 调用 setupLocalVideo 设置预览窗口及属性。
  ///  调用 enableVideo 开启视频功能。 本地预览默认开启镜像功能。如果调用 leaveChannel 退出频道，本地预览依然处于开启状态，如需要关闭本地预览，需要调用 stopPreview 。该方法中设置的视频源类型需要跟 setupLocalVideo 中 VideoCanvas 的视频源类型一致。
  ///
  /// * [sourceType] 视频源的类型，详见 VideoSourceType 。
  Future<void> startPreview(
      {VideoSourceType sourceType = VideoSourceType.videoSourceCameraPrimary});

  /// 停止视频预览。
  /// 调用 startPreview 开启预览后，如果你想关闭本地视频预览，请调用该方法。请在加入频道前或离开频道后调用该方法。
  ///
  /// * [sourceType] 视频源的类型，详见 VideoSourceType 。
  Future<void> stopPreview(
      {VideoSourceType sourceType = VideoSourceType.videoSourceCameraPrimary});

  /// 设置音频编码属性。
  /// 该方法在加入频道前后均可调用。在有高音质需求的场景（例如音乐教学场景）中，建议将 profile 设置为 audioProfileMusicHighQuality (4)。如果你想设置音频应用场景，请调用 initialize 并设置 RtcEngineContext 结构体中的
  ///
  /// * [profile] 音频编码属性，包含采样率、码率、编码模式和声道数。详见 AudioProfileType 。
  Future<void> setAudioProfile(
      {required AudioProfileType profile,
      AudioScenarioType scenario = AudioScenarioType.audioScenarioDefault});

  /// 开始客户端录音。
  /// Agora SDK 支持通话过程中在客户端进行录音。调用该方法后，你可以录制频道内用户的音频，并得到一个录音文件。录音文件格式可以为: WAV: 音质保真度较高，文件较大。例如，采样率为 32000 Hz，录音时长为 10 分钟的文件大小约为 73 M。AAC: 音质保真度较低，文件较小。例如，采样率为 32000 Hz，录音音质为 audioRecordingQualityMedium，录音时长为 10 分钟的文件大小约为 2 M。用户离开频道后，录音会自动停止。该方法需要在加入频道后调用。
  ///
  /// * [config] 录音配置。详见 AudioRecordingConfiguration 。
  Future<void> startAudioRecording(AudioRecordingConfiguration config);

  /// 开始播放音乐文件。
  /// 该方法支持将本地或在线音乐文件和麦克风采集的音频进行混音或替换。成功播放音乐文件后，本地会触发 onAudioMixingStateChanged (audioMixingStatePlaying) 回调。播放结束后，本地会触发 onAudioMixingStateChanged(audioMixingStateStopped) 回调。该方法支持的音频文件格式见 Agora RTC SDK 支持播放哪些格式的音频文件。该方法在加入频道前后均可调用。如需多次调用 startAudioMixing，请确保调用间隔大于 500 ms。如果本地音乐文件不存在、文件格式不支持或无法访问在线音乐文件 URL，则 SDK 会报告警告码 701。
  ///
  /// * [filePath] 文件路径： Android: 文件路径，需精确到文件名及后缀。支持在线文件的 URL 地址，本地文件的 URI 地址、绝对路径或以 /assets/ 开头的路径。
  ///  通过绝对路径访问本地文件可能会遇到权限问题，Agora 推荐使用 URI 地址访问本地文件。例如 content://com.android.providers.media.documents/document/audio%3A14441。Windows: 音频文件的绝对路径或 URL 地址，需精确到文件名及后缀。例如 C:\music\audio.mp4。iOS 或 macOS: 音频文件的绝对路径或 URL 地址，需精确到文件名及后缀。例如 /var/mobile/Containers/Data/audio.mp4。
  /// * [loopback] 是否只在本地播放音乐文件： true: 只在本地播放音乐文件，只有本地用户能听到音乐。false: 将本地播放的音乐文件发布至远端，本地用户和远端用户都能听到音乐。
  /// * [cycle] 音乐文件的播放次数。
  ///  ≥ 0: 播放次数。例如，0 表示不播放；1 表示播放 1 次。-1: 无限循环播放。
  /// * [startPos] 音乐文件的播放位置，单位为毫秒。
  Future<void> startAudioMixing(
      {required String filePath,
      required bool loopback,
      required int cycle,
      int startPos = 0});

  /// 更新本地视图显示模式。
  /// 初始化本地用户视图后，你可以调用该方法更新本地用户视图的渲染和镜像模式。该方法只影响本地用户看到的视频画面，不影响本地发布视频。请在调用 setupLocalVideo 方法初始化本地视图后，调用该方法。你可以在通话中多次调用该方法，多次更新本地用户视图的显示模式。
  ///
  /// * [renderMode] 本地视图显示模式。详见 RenderModeType 。
  /// * [mirrorMode] 本地视图的镜像模式，详见 VideoMirrorModeType 。如果你使用前置摄像头，默认启动本地用户视图镜像模式；如果你使用后置摄像头，默认关闭本地视图镜像模式。
  Future<void> setLocalRenderMode(
      {required RenderModeType renderMode,
      VideoMirrorModeType mirrorMode =
          VideoMirrorModeType.videoMirrorModeAuto});

  /// 开关双流模式。
  /// 你可以在发流端调用该方法开启或关闭双流模式。双流指视频大流和视频小流： 视频大流：高分辨率、高帧率的视频流。
  ///  视频小流：低分辨率、低帧率的视频流。 开启双流模式后，你可以在收流端调用 setRemoteVideoStreamType 选择接收视频大流或视频小流。 该方法可以在加入频道前后调用。
  ///
  /// * [enabled] 是否开启双流模式： true: 开启双流模式。
  ///  false: 关闭双流模式。
  /// * [sourceType] 视频源的类型。详见 VideoSourceType 。
  ///
  /// * [streamConfig] 视频小流的配置。详见 SimulcastStreamConfig
  Future<void> enableDualStreamMode(
      {required bool enabled,
      VideoSourceType sourceType = VideoSourceType.videoSourceCameraPrimary,
      SimulcastStreamConfig? streamConfig});

  /// 创建数据流。
  /// 该方法用于创建数据流。每个用户在每个频道中最多只能创建 5 个数据流。
  ///
  /// * [config] 数据流设置。详见 DataStreamConfig 。
  ///
  /// Returns
  /// 创建的数据流的 ID：方法调用成功。< 0：方法调用失败。
  Future<int> createDataStream(DataStreamConfig config);

  /// 添加本地视频水印。
  /// 该方法将一张 PNG 图片作为水印添加到本地发布的直播视频流上，同一直播频道中的用户、旁路直播观众和采集设备都能看到或采集到该水印图片。
  ///  Agora 当前只支持在直播视频流中添加一个水印，后添加的水印会替换掉之前添加的水印。水印坐标和 setVideoEncoderConfiguration 方法中的设置有依赖关系： 如果视频编码方向（ OrientationMode ）固定为横屏或自适应模式下的横屏，那么水印使用横屏坐标。如果视频编码方向（OrientationMode）固定为竖屏或自适应模式下的竖屏，那么水印使用竖屏坐标。设置水印坐标时，水印的图像区域不能超出 setVideoEncoderConfiguration 方法中设置的视频尺寸，否则超出部分将被裁剪。你需要在调用 enableVideo 方法之后再调用该方法。如果你只是在旁路推流时添加水印，你可以使用该方法或 setLiveTranscoding 方法设置水印。待添加水印图片必须是 PNG 格式。该方法支持所有像素格式的 PNG 图片：RGBA、RGB、Palette、Gray 和 Alpha_gray。如果待添加的 PNG 图片的尺寸与你在该方法中设置的尺寸不一致，SDK 会对 PNG 图片进行缩放或裁剪，以与设置相符。如果你已经使用 startPreview 方法开启本地视频预览，那么该方法的 visibleInPreview 可设置水印在预览时是否可见。如果你已设置本地视频为镜像模式，那么此处的本地水印也为镜像。为避免本地用户看本地视频时的水印也被镜像，Agora 建议你不要对本地视频同时使用镜像和水印功能，请在应用层实现本地水印功能。
  ///
  /// * [watermarkUrl] 待添加的水印图片的本地路径。该方法支持从本地绝对/相对路径添加水印图片。
  /// * [options] 待添加的水印图片的设置选项，详见 WatermarkOptions 。
  Future<void> addVideoWatermark(
      {required String watermarkUrl, required WatermarkOptions options});

  /// 使用 User Account 和 Token 加入频道。
  /// 该方法允许本地用户使用 User Account 和 Token 加入频道。成功加入频道后，会触发以下回调：
  ///  本地： onLocalUserRegistered 、 onJoinChannelSuccess 和 onConnectionStateChanged 回调。通信场景下的用户和直播场景下的主播加入频道后，远端会依次触发 onUserJoined 和 onUserInfoUpdated 回调。用户成功加入频道后，默认订阅频道内所有其他用户的音频流和视频流，因此产生用量并影响计费。如果想取消订阅，可以通过调用相应的 mute 方法实现。为保证通信质量，请确保频道内使用同一类型的数据标识用户身份。即同一频道内需要统一使用 UID 或 User Account。如果有用户通过 Agora Web SDK 加入频道，请确保 Web 加入的用户也是同样类型。
  ///
  /// * [userAccount] 用户 User Account。该参数用于标识实时音视频互动频道中的用户。你需要自行设置和管理用户的 User Account，并确保同一频道中每个用户的 User Account 是唯一的。 该参数为必填，最大不超过 255 字节，不可填 NULL。以下为支持的字符集范围（共 89 个字符）： 26 个小写英文字母 a-z
  ///  26 个大写英文字母 A-Z
  ///  10 个数字 0-9
  ///  空格
  ///  "!"、"#"、"$"、"%"、"&"、"("、")"、"+"、"-"、":"、";"、"<"、"="、"."、">"、"?"、"@"、"["、"]"、"^"、"_"、"{"、"}"、"|"、"~"、","
  /// * [token] 在服务端生成的用于鉴权的动态密钥。详见。
  /// * [channelId] 频道名。该参数标识用户进行实时音视频互动的频道。App ID 一致的前提下，填入相同频道名的用户会进入同一个频道进行音视频互动。该参数为长度在 64 字节以内的字符串。以下为支持的字符集范围（共 89 个字符）: 26 个小写英文字母 a~z
  ///  26 个大写英文字母 A~Z
  ///  10 个数字 0~9
  ///  空格
  ///  "!"、"#"、"$"、"%"、"&"、"("、")"、"+"、"-"、":"、";"、"<"、"="、"."、">"、"?"、"@"、"["、"]"、"^"、"_"、"{"、"}"、"|"、"~"、","
  Future<void> joinChannelWithUserAccount(
      {required String token,
      required String channelId,
      required String userAccount,
      ChannelMediaOptions? options});

  /// 获取 AudioDeviceManager 对象，以管理音频设备。
  ///
  ///
  /// Returns
  /// 一个 AudioDeviceManager 对象。
  AudioDeviceManager getAudioDeviceManager();

  /// 获取 VideoDeviceManager 对象，以管理视频设备。
  ///
  ///
  /// Returns
  /// 一个 VideoDeviceManager 对象。
  VideoDeviceManager getVideoDeviceManager();

  /// 获取 MediaEngine 对象。
  /// 该方法需要在初始化 RtcEngine 对象后调用。
  ///
  /// Returns
  /// MediaEngine 对象。
  MediaEngine getMediaEngine();

  /// 获取 MediaRecorder 对象。
  /// 该方法需要在初始化 RtcEngine 对象后调用。
  ///
  /// Returns
  /// MediaRecorder 对象。
  MediaRecorder getMediaRecorder();

  /// 获取 LocalSpatialAudioEngine 对象。
  /// 该方法需要在初始化 RtcEngine 对象后调用。
  ///
  /// Returns
  /// 一个 LocalSpatialAudioEngine 对象。
  LocalSpatialAudioEngine getLocalSpatialAudioEngine();

  /// 发送媒体附属信息。
  /// 如果成功发送了媒体附属信息，接收端会收到 onMetadataReceived 回调。
  ///
  /// * [metadata] 媒体附属信息。详见 Metadata 。
  Future<void> sendMetaData(
      {required Metadata metadata, required VideoSourceType sourceType});

  /// 设置媒体附属信息的最大大小。
  /// 调用 registerMediaMetadataObserver 后，你可以调用本方法来设置媒体附属信息的最大大小。
  ///
  /// * [size] 媒体附属信息的最大大小。
  Future<void> setMaxMetadataSize(int size);

  /// 取消注册音频编码数据观测器。
  ///
  ///
  /// * [observer] 音频编码数据观测器。详见 AudioEncodedFrameObserver 。
  void unregisterAudioEncodedFrameObserver(AudioEncodedFrameObserver observer);

  /// 通过 JSON 配置 SDK 提供技术预览或特别定制功能。
  ///
  ///
  /// * [parameters] JSON 字符串形式的参数。
  Future<void> setParameters(String parameters);
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum QualityReportFormatType {
  /// @nodoc
  @JsonValue(0)
  qualityReportJson,

  /// @nodoc
  @JsonValue(1)
  qualityReportHtml,
}

/// @nodoc
extension QualityReportFormatTypeExt on QualityReportFormatType {
  /// @nodoc
  static QualityReportFormatType fromValue(int value) {
    return $enumDecode(_$QualityReportFormatTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$QualityReportFormatTypeEnumMap[this]!;
  }
}

/// 设备状态。
///
@JsonEnum(alwaysCreate: true)
enum MediaDeviceStateType {
  /// 0: 设备就绪。
  @JsonValue(0)
  mediaDeviceStateIdle,

  /// 1: 设备正在使用。
  @JsonValue(1)
  mediaDeviceStateActive,

  /// 2: 设备被禁用。
  @JsonValue(2)
  mediaDeviceStateDisabled,

  /// 4: 没有此设备。
  @JsonValue(4)
  mediaDeviceStateNotPresent,

  /// 8: 设备被拔出。
  @JsonValue(8)
  mediaDeviceStateUnplugged,
}

/// @nodoc
extension MediaDeviceStateTypeExt on MediaDeviceStateType {
  /// @nodoc
  static MediaDeviceStateType fromValue(int value) {
    return $enumDecode(_$MediaDeviceStateTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$MediaDeviceStateTypeEnumMap[this]!;
  }
}

/// 视频属性。
///
@JsonEnum(alwaysCreate: true)
enum VideoProfileType {
  /// 0：分辨率 160 × 120，帧率 15 fps，码率 65 Kbps。
  @JsonValue(0)
  videoProfileLandscape120p,

  /// 2：分辨率 120 × 120，帧率 15 fps，码率 50 Kbps。
  @JsonValue(2)
  videoProfileLandscape120p3,

  /// 10：分辨率 320 × 180，帧率 15 fps，码率 140 Kbps。
  @JsonValue(10)
  videoProfileLandscape180p,

  /// 12：分辨率 180 × 180，帧率 15 fps，码率 100 Kbps。
  @JsonValue(12)
  videoProfileLandscape180p3,

  /// 13：分辨率 240 × 180，帧率 15 fps，码率 120 Kbps。
  @JsonValue(13)
  videoProfileLandscape180p4,

  /// 20：分辨率 320 × 240，帧率 15 fps，码率 200 Kbps。
  @JsonValue(20)
  videoProfileLandscape240p,

  /// 22：分辨率 240 × 240，帧率 15 fps，码率 140 Kbps。
  @JsonValue(22)
  videoProfileLandscape240p3,

  /// 23：分辨率 424 × 240，帧率 15 fps，码率 220 Kbps。
  @JsonValue(23)
  videoProfileLandscape240p4,

  /// 30：分辨率 640 × 360，帧率 15 fps，码率 400 Kbps。
  @JsonValue(30)
  videoProfileLandscape360p,

  /// 32：分辨率 360 × 360，帧率 15 fps，码率 260 Kbps。
  @JsonValue(32)
  videoProfileLandscape360p3,

  /// 33：分辨率 640 × 360，帧率 30 fps，码率 600 Kbps。
  @JsonValue(33)
  videoProfileLandscape360p4,

  /// 35：分辨率 360 × 360，帧率 30 fps，码率 400 Kbps。
  @JsonValue(35)
  videoProfileLandscape360p6,

  /// 36：分辨率 480 × 360，帧率 15 fps，码率 320 Kbps。
  @JsonValue(36)
  videoProfileLandscape360p7,

  /// 37：分辨率 480 × 360，帧率 30 fps，码率 490 Kbps。
  @JsonValue(37)
  videoProfileLandscape360p8,

  /// 38：分辨率 640 × 360，帧率 15 fps，码率 800 Kbps。该视频属性仅适用于直播频道场景。
  @JsonValue(38)
  videoProfileLandscape360p9,

  /// 39：分辨率 640 × 360，帧率 24 fps，码率 800 Kbps。该视频属性仅适用于直播频道场景。
  @JsonValue(39)
  videoProfileLandscape360p10,

  /// 100: 分辨率 640 × 360，帧率 24 fps，码率 1000 Kbps。该视频属性仅适用于直播频道场景。
  @JsonValue(100)
  videoProfileLandscape360p11,

  /// 40：分辨率 640 × 480，帧率 15 fps，码率 500 Kbps。
  @JsonValue(40)
  videoProfileLandscape480p,

  /// 42：分辨率 480 × 480，帧率 15 fps，码率 400 Kbps。
  @JsonValue(42)
  videoProfileLandscape480p3,

  /// 43：分辨率 640 × 480，帧率 30 fps，码率 750 Kbps。
  @JsonValue(43)
  videoProfileLandscape480p4,

  /// 45：分辨率 480 × 480，帧率 30 fps，码率 600 Kbps。
  @JsonValue(45)
  videoProfileLandscape480p6,

  /// 47：分辨率 848 × 480，帧率 15 fps，码率 610 Kbps。
  @JsonValue(47)
  videoProfileLandscape480p8,

  /// 48：分辨率 848 × 480，帧率 30 fps，码率 930 Kbps。
  @JsonValue(48)
  videoProfileLandscape480p9,

  /// 49：分辨率 640 × 480，帧率 10 fps，码率 400 Kbps。
  @JsonValue(49)
  videoProfileLandscape480p10,

  /// 50：分辨率 1280 × 720，帧率 15 fps，码率 1130 Kbps。
  @JsonValue(50)
  videoProfileLandscape720p,

  /// 52：分辨率 1280 × 720，帧率 30 fps，码率 1710 Kbps。
  @JsonValue(52)
  videoProfileLandscape720p3,

  /// 54：分辨率 960 × 720，帧率 15 fps，码率 910 Kbps。
  @JsonValue(54)
  videoProfileLandscape720p5,

  /// 55：分辨率 960 × 720，帧率 30 fps，码率 1380 Kbps。
  @JsonValue(55)
  videoProfileLandscape720p6,

  /// 60：分辨率 1920 × 1080，帧率 15 fps，码率 2080 Kbps。
  @JsonValue(60)
  videoProfileLandscape1080p,

  /// 62：分辨率 1920 × 1080，帧率 30 fps，码率 3150 Kbps。
  @JsonValue(62)
  videoProfileLandscape1080p3,

  /// 64：分辨率 1920 × 1080，帧率 60 fps，码率 4780 Kbps。
  @JsonValue(64)
  videoProfileLandscape1080p5,

  /// @nodoc
  @JsonValue(66)
  videoProfileLandscape1440p,

  /// @nodoc
  @JsonValue(67)
  videoProfileLandscape1440p2,

  /// @nodoc
  @JsonValue(70)
  videoProfileLandscape4k,

  /// @nodoc
  @JsonValue(72)
  videoProfileLandscape4k3,

  /// 1000: 分辨率 120 × 160，帧率 15 fps，码率 65 Kbps。
  @JsonValue(1000)
  videoProfilePortrait120p,

  /// 1002: 分辨率 120 × 120，帧率 15 fps，码率 50 Kbps。
  @JsonValue(1002)
  videoProfilePortrait120p3,

  /// 1010: 分辨率 180 × 320，帧率 15 fps，码率 140 Kbps。
  @JsonValue(1010)
  videoProfilePortrait180p,

  /// 1012: 分辨率 180 × 180，帧率 15 fps，码率 100 Kbps。
  @JsonValue(1012)
  videoProfilePortrait180p3,

  /// 1013: 分辨率 180 × 240，帧率 15 fps，码率 120 Kbps。
  @JsonValue(1013)
  videoProfilePortrait180p4,

  /// 1020: 分辨率 240 × 320，帧率 15 fps，码率 200 Kbps。
  @JsonValue(1020)
  videoProfilePortrait240p,

  /// 1022: 分辨率 240 × 240，帧率 15 fps，码率 140 Kbps。
  @JsonValue(1022)
  videoProfilePortrait240p3,

  /// 1023: 分辨率 240 × 424，帧率 15 fps，码率 220 Kbps。
  @JsonValue(1023)
  videoProfilePortrait240p4,

  /// 1030: 分辨率 360 × 640，帧率 15 fps，码率 400 Kbps。
  @JsonValue(1030)
  videoProfilePortrait360p,

  /// 1032: 分辨率 360 × 360，帧率 15 fps，码率 260 Kbps。
  @JsonValue(1032)
  videoProfilePortrait360p3,

  /// 1033: 分辨率 360 × 640，帧率 30 fps，码率 600 Kbps。
  @JsonValue(1033)
  videoProfilePortrait360p4,

  /// 1035: 分辨率 360 × 360，帧率 30 fps，码率 400 Kbps。
  @JsonValue(1035)
  videoProfilePortrait360p6,

  /// 1036: 分辨率 360 × 480，帧率 15 fps，码率 320 Kbps。
  @JsonValue(1036)
  videoProfilePortrait360p7,

  /// 1037: 分辨率 360 × 480，帧率 30 fps，码率 490 Kbps。
  @JsonValue(1037)
  videoProfilePortrait360p8,

  /// 1038: 分辨率 360 × 640，帧率 15 fps，码率 800 Kbps。该视频属性仅适用于直播频道场景。
  @JsonValue(1038)
  videoProfilePortrait360p9,

  /// 1039: 分辨率 360 × 640，帧率 24 fps，码率 800 Kbps。该视频属性仅适用于直播频道场景。
  @JsonValue(1039)
  videoProfilePortrait360p10,

  /// 1100: 分辨率 360 × 640，帧率 24 fps，码率 1000 Kbps。该视频属性仅适用于直播频道场景。
  @JsonValue(1100)
  videoProfilePortrait360p11,

  /// 1040: 分辨率 480 × 640，帧率 15 fps，码率 500 Kbps。
  @JsonValue(1040)
  videoProfilePortrait480p,

  /// 1042: 分辨率 480 × 480，帧率 15 fps，码率 400 Kbps。
  @JsonValue(1042)
  videoProfilePortrait480p3,

  /// 1043: 分辨率 480 × 640，帧率 30 fps，码率 750 Kbps。
  @JsonValue(1043)
  videoProfilePortrait480p4,

  /// 1045: 分辨率 480 × 480，帧率 30 fps，码率 600 Kbps。
  @JsonValue(1045)
  videoProfilePortrait480p6,

  /// 1047: 分辨率 480 × 848，帧率 15 fps，码率 610 Kbps。
  @JsonValue(1047)
  videoProfilePortrait480p8,

  /// 1048: 分辨率 480 × 848，帧率 30 fps，码率 930 Kbps。
  @JsonValue(1048)
  videoProfilePortrait480p9,

  /// 1049: 分辨率 480 × 640，帧率 10 fps，码率 400 Kbps。
  @JsonValue(1049)
  videoProfilePortrait480p10,

  /// 1050: 分辨率 分辨率 720 × 1280，帧率 15 fps，码率 1130 Kbps。
  @JsonValue(1050)
  videoProfilePortrait720p,

  /// 1052: 分辨率 分辨率 720 × 1280，帧率 30 fps，码率 1710 Kbps。
  @JsonValue(1052)
  videoProfilePortrait720p3,

  /// 1054: 分辨率 720 × 960，帧率 15 fps，码率 910 Kbps。
  @JsonValue(1054)
  videoProfilePortrait720p5,

  /// 1055: 分辨率 720 × 960，帧率 30 fps，码率 1380 Kbps。
  @JsonValue(1055)
  videoProfilePortrait720p6,

  /// 1060: 分辨率 1080 × 1920，帧率 15 fps，码率 2080 Kbps。
  @JsonValue(1060)
  videoProfilePortrait1080p,

  /// 1062: 分辨率 1080 × 1920，帧率 30 fps，码率 3150 Kbps。
  @JsonValue(1062)
  videoProfilePortrait1080p3,

  /// 1064: 分辨率 1080 × 1920，帧率 60 fps，码率 4780 Kbps。
  @JsonValue(1064)
  videoProfilePortrait1080p5,

  /// @nodoc
  @JsonValue(1066)
  videoProfilePortrait1440p,

  /// @nodoc
  @JsonValue(1067)
  videoProfilePortrait1440p2,

  /// @nodoc
  @JsonValue(1070)
  videoProfilePortrait4k,

  /// @nodoc
  @JsonValue(1072)
  videoProfilePortrait4k3,

  /// （默认）分辨率 640 × 360，帧率 15 fps，码率 400 Kbps。
  @JsonValue(30)
  videoProfileDefault,
}

/// @nodoc
extension VideoProfileTypeExt on VideoProfileType {
  /// @nodoc
  static VideoProfileType fromValue(int value) {
    return $enumDecode(_$VideoProfileTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$VideoProfileTypeEnumMap[this]!;
  }
}

/// SDK 版本信息。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SDKBuildInfo {
  /// @nodoc
  const SDKBuildInfo({this.build, this.version});

  /// SDK 编译号。
  @JsonKey(name: 'build')
  final int? build;

  /// SDK 版本号。格式为字符串，如 4.0.0。
  @JsonKey(name: 'version')
  final String? version;

  /// @nodoc
  factory SDKBuildInfo.fromJson(Map<String, dynamic> json) =>
      _$SDKBuildInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$SDKBuildInfoToJson(this);
}

/// VideoDeviceInfo 类，包含视频设备的 ID 和设备名称。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoDeviceInfo {
  /// @nodoc
  const VideoDeviceInfo({this.deviceId, this.deviceName});

  /// 设备 ID。
  @JsonKey(name: 'deviceId')
  final String? deviceId;

  /// 设备名称。
  @JsonKey(name: 'deviceName')
  final String? deviceName;

  /// @nodoc
  factory VideoDeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$VideoDeviceInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$VideoDeviceInfoToJson(this);
}

/// AudioDeviceInfo 类，包含音频设备的 ID 和设备名称。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioDeviceInfo {
  /// @nodoc
  const AudioDeviceInfo({this.deviceId, this.deviceName});

  /// 设备 ID。
  @JsonKey(name: 'deviceId')
  final String? deviceId;

  /// 设备名称。
  @JsonKey(name: 'deviceName')
  final String? deviceName;

  /// @nodoc
  factory AudioDeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$AudioDeviceInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AudioDeviceInfoToJson(this);
}
