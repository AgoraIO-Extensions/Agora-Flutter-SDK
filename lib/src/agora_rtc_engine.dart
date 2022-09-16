import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_rtc_engine.g.dart';

@JsonEnum(alwaysCreate: true)
enum MediaDeviceType {
  @JsonValue(-1)
  unknownAudioDevice,

  @JsonValue(0)
  audioPlayoutDevice,

  @JsonValue(1)
  audioRecordingDevice,

  @JsonValue(2)
  videoRenderDevice,

  @JsonValue(3)
  videoCaptureDevice,

  @JsonValue(4)
  audioApplicationPlayoutDevice,
}

/// Extensions functions of [MediaDeviceType].
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

@JsonEnum(alwaysCreate: true)
enum AudioMixingStateType {
  @JsonValue(710)
  audioMixingStatePlaying,

  @JsonValue(711)
  audioMixingStatePaused,

  @JsonValue(713)
  audioMixingStateStopped,

  @JsonValue(714)
  audioMixingStateFailed,
}

/// Extensions functions of [AudioMixingStateType].
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

@JsonEnum(alwaysCreate: true)
enum AudioMixingReasonType {
  @JsonValue(701)
  audioMixingReasonCanNotOpen,

  @JsonValue(702)
  audioMixingReasonTooFrequentCall,

  @JsonValue(703)
  audioMixingReasonInterruptedEof,

  @JsonValue(721)
  audioMixingReasonOneLoopCompleted,

  @JsonValue(723)
  audioMixingReasonAllLoopsCompleted,

  @JsonValue(724)
  audioMixingReasonStoppedByUser,

  @JsonValue(0)
  audioMixingReasonOk,
}

/// Extensions functions of [AudioMixingReasonType].
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

@JsonEnum(alwaysCreate: true)
enum InjectStreamStatus {
  @JsonValue(0)
  injectStreamStatusStartSuccess,

  @JsonValue(1)
  injectStreamStatusStartAlreadyExists,

  @JsonValue(2)
  injectStreamStatusStartUnauthorized,

  @JsonValue(3)
  injectStreamStatusStartTimedout,

  @JsonValue(4)
  injectStreamStatusStartFailed,

  @JsonValue(5)
  injectStreamStatusStopSuccess,

  @JsonValue(6)
  injectStreamStatusStopNotFound,

  @JsonValue(7)
  injectStreamStatusStopUnauthorized,

  @JsonValue(8)
  injectStreamStatusStopTimedout,

  @JsonValue(9)
  injectStreamStatusStopFailed,

  @JsonValue(10)
  injectStreamStatusBroken,
}

/// Extensions functions of [InjectStreamStatus].
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

@JsonEnum(alwaysCreate: true)
enum AudioEqualizationBandFrequency {
  @JsonValue(0)
  audioEqualizationBand31,

  @JsonValue(1)
  audioEqualizationBand62,

  @JsonValue(2)
  audioEqualizationBand125,

  @JsonValue(3)
  audioEqualizationBand250,

  @JsonValue(4)
  audioEqualizationBand500,

  @JsonValue(5)
  audioEqualizationBand1k,

  @JsonValue(6)
  audioEqualizationBand2k,

  @JsonValue(7)
  audioEqualizationBand4k,

  @JsonValue(8)
  audioEqualizationBand8k,

  @JsonValue(9)
  audioEqualizationBand16k,
}

/// Extensions functions of [AudioEqualizationBandFrequency].
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

@JsonEnum(alwaysCreate: true)
enum AudioReverbType {
  @JsonValue(0)
  audioReverbDryLevel,

  @JsonValue(1)
  audioReverbWetLevel,

  @JsonValue(2)
  audioReverbRoomSize,

  @JsonValue(3)
  audioReverbWetDelay,

  @JsonValue(4)
  audioReverbStrength,
}

/// Extensions functions of [AudioReverbType].
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

@JsonEnum(alwaysCreate: true)
enum StreamFallbackOptions {
  @JsonValue(0)
  streamFallbackOptionDisabled,

  @JsonValue(1)
  streamFallbackOptionVideoStreamLow,

  @JsonValue(2)
  streamFallbackOptionAudioOnly,
}

/// Extensions functions of [StreamFallbackOptions].
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

@JsonEnum(alwaysCreate: true)
enum PriorityType {
  @JsonValue(50)
  priorityHigh,

  @JsonValue(100)
  priorityNormal,
}

/// Extensions functions of [PriorityType].
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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LocalVideoStats {
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

  @JsonKey(name: 'uid')
  final int? uid;

  @JsonKey(name: 'sentBitrate')
  final int? sentBitrate;

  @JsonKey(name: 'sentFrameRate')
  final int? sentFrameRate;

  @JsonKey(name: 'captureFrameRate')
  final int? captureFrameRate;

  @JsonKey(name: 'captureFrameWidth')
  final int? captureFrameWidth;

  @JsonKey(name: 'captureFrameHeight')
  final int? captureFrameHeight;

  @JsonKey(name: 'regulatedCaptureFrameRate')
  final int? regulatedCaptureFrameRate;

  @JsonKey(name: 'regulatedCaptureFrameWidth')
  final int? regulatedCaptureFrameWidth;

  @JsonKey(name: 'regulatedCaptureFrameHeight')
  final int? regulatedCaptureFrameHeight;

  @JsonKey(name: 'encoderOutputFrameRate')
  final int? encoderOutputFrameRate;

  @JsonKey(name: 'encodedFrameWidth')
  final int? encodedFrameWidth;

  @JsonKey(name: 'encodedFrameHeight')
  final int? encodedFrameHeight;

  @JsonKey(name: 'rendererOutputFrameRate')
  final int? rendererOutputFrameRate;

  @JsonKey(name: 'targetBitrate')
  final int? targetBitrate;

  @JsonKey(name: 'targetFrameRate')
  final int? targetFrameRate;

  @JsonKey(name: 'qualityAdaptIndication')
  final QualityAdaptIndication? qualityAdaptIndication;

  @JsonKey(name: 'encodedBitrate')
  final int? encodedBitrate;

  @JsonKey(name: 'encodedFrameCount')
  final int? encodedFrameCount;

  @JsonKey(name: 'codecType')
  final VideoCodecType? codecType;

  @JsonKey(name: 'txPacketLossRate')
  final int? txPacketLossRate;

  @JsonKey(name: 'captureBrightnessLevel')
  final CaptureBrightnessLevelType? captureBrightnessLevel;

  @JsonKey(name: 'dualStreamEnabled')
  final bool? dualStreamEnabled;
  factory LocalVideoStats.fromJson(Map<String, dynamic> json) =>
      _$LocalVideoStatsFromJson(json);
  Map<String, dynamic> toJson() => _$LocalVideoStatsToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RemoteVideoStats {
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

  @JsonKey(name: 'uid')
  final int? uid;

  @JsonKey(name: 'delay')
  final int? delay;

  @JsonKey(name: 'width')
  final int? width;

  @JsonKey(name: 'height')
  final int? height;

  @JsonKey(name: 'receivedBitrate')
  final int? receivedBitrate;

  @JsonKey(name: 'decoderOutputFrameRate')
  final int? decoderOutputFrameRate;

  @JsonKey(name: 'rendererOutputFrameRate')
  final int? rendererOutputFrameRate;

  @JsonKey(name: 'frameLossRate')
  final int? frameLossRate;

  @JsonKey(name: 'packetLossRate')
  final int? packetLossRate;

  @JsonKey(name: 'rxStreamType')
  final VideoStreamType? rxStreamType;

  @JsonKey(name: 'totalFrozenTime')
  final int? totalFrozenTime;

  @JsonKey(name: 'frozenRate')
  final int? frozenRate;

  @JsonKey(name: 'avSyncTimeMs')
  final int? avSyncTimeMs;

  @JsonKey(name: 'totalActiveTime')
  final int? totalActiveTime;

  @JsonKey(name: 'publishDuration')
  final int? publishDuration;

  @JsonKey(name: 'superResolutionType')
  final int? superResolutionType;
  factory RemoteVideoStats.fromJson(Map<String, dynamic> json) =>
      _$RemoteVideoStatsFromJson(json);
  Map<String, dynamic> toJson() => _$RemoteVideoStatsToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoCompositingLayout {
  const VideoCompositingLayout(
      {this.canvasWidth,
      this.canvasHeight,
      this.backgroundColor,
      this.regions,
      this.regionCount,
      this.appData,
      this.appDataLength});

  @JsonKey(name: 'canvasWidth')
  final int? canvasWidth;

  @JsonKey(name: 'canvasHeight')
  final int? canvasHeight;

  @JsonKey(name: 'backgroundColor')
  final String? backgroundColor;

  @JsonKey(name: 'regions')
  final List<Region>? regions;

  @JsonKey(name: 'regionCount')
  final int? regionCount;

  @JsonKey(name: 'appData', ignore: true)
  final Uint8List? appData;

  @JsonKey(name: 'appDataLength')
  final int? appDataLength;
  factory VideoCompositingLayout.fromJson(Map<String, dynamic> json) =>
      _$VideoCompositingLayoutFromJson(json);
  Map<String, dynamic> toJson() => _$VideoCompositingLayoutToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Region {
  const Region(
      {this.uid,
      this.x,
      this.y,
      this.width,
      this.height,
      this.zOrder,
      this.alpha,
      this.renderMode});

  @JsonKey(name: 'uid')
  final int? uid;

  @JsonKey(name: 'x')
  final double? x;

  @JsonKey(name: 'y')
  final double? y;

  @JsonKey(name: 'width')
  final double? width;

  @JsonKey(name: 'height')
  final double? height;

  @JsonKey(name: 'zOrder')
  final int? zOrder;

  @JsonKey(name: 'alpha')
  final double? alpha;

  @JsonKey(name: 'renderMode')
  final RenderModeType? renderMode;
  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);
  Map<String, dynamic> toJson() => _$RegionToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class InjectStreamConfig {
  const InjectStreamConfig(
      {this.width,
      this.height,
      this.videoGop,
      this.videoFramerate,
      this.videoBitrate,
      this.audioSampleRate,
      this.audioBitrate,
      this.audioChannels});

  @JsonKey(name: 'width')
  final int? width;

  @JsonKey(name: 'height')
  final int? height;

  @JsonKey(name: 'videoGop')
  final int? videoGop;

  @JsonKey(name: 'videoFramerate')
  final int? videoFramerate;

  @JsonKey(name: 'videoBitrate')
  final int? videoBitrate;

  @JsonKey(name: 'audioSampleRate')
  final AudioSampleRateType? audioSampleRate;

  @JsonKey(name: 'audioBitrate')
  final int? audioBitrate;

  @JsonKey(name: 'audioChannels')
  final int? audioChannels;
  factory InjectStreamConfig.fromJson(Map<String, dynamic> json) =>
      _$InjectStreamConfigFromJson(json);
  Map<String, dynamic> toJson() => _$InjectStreamConfigToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum RtmpStreamLifeCycleType {
  @JsonValue(1)
  rtmpStreamLifeCycleBind2channel,

  @JsonValue(2)
  rtmpStreamLifeCycleBind2owner,
}

/// Extensions functions of [RtmpStreamLifeCycleType].
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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class PublisherConfiguration {
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

  @JsonKey(name: 'width')
  final int? width;

  @JsonKey(name: 'height')
  final int? height;

  @JsonKey(name: 'framerate')
  final int? framerate;

  @JsonKey(name: 'bitrate')
  final int? bitrate;

  @JsonKey(name: 'defaultLayout')
  final int? defaultLayout;

  @JsonKey(name: 'lifecycle')
  final int? lifecycle;

  @JsonKey(name: 'owner')
  final bool? owner;

  @JsonKey(name: 'injectStreamWidth')
  final int? injectStreamWidth;

  @JsonKey(name: 'injectStreamHeight')
  final int? injectStreamHeight;

  @JsonKey(name: 'injectStreamUrl')
  final String? injectStreamUrl;

  @JsonKey(name: 'publishUrl')
  final String? publishUrl;

  @JsonKey(name: 'rawStreamUrl')
  final String? rawStreamUrl;

  @JsonKey(name: 'extraInfo')
  final String? extraInfo;
  factory PublisherConfiguration.fromJson(Map<String, dynamic> json) =>
      _$PublisherConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$PublisherConfigurationToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioTrackConfig {
  const AudioTrackConfig({this.enableLocalPlayback});

  @JsonKey(name: 'enableLocalPlayback')
  final bool? enableLocalPlayback;
  factory AudioTrackConfig.fromJson(Map<String, dynamic> json) =>
      _$AudioTrackConfigFromJson(json);
  Map<String, dynamic> toJson() => _$AudioTrackConfigToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum CameraDirection {
  @JsonValue(0)
  cameraRear,

  @JsonValue(1)
  cameraFront,
}

/// Extensions functions of [CameraDirection].
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

@JsonEnum(alwaysCreate: true)
enum CloudProxyType {
  @JsonValue(0)
  noneProxy,

  @JsonValue(1)
  udpProxy,

  @JsonValue(2)
  tcpProxy,
}

/// Extensions functions of [CloudProxyType].
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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CameraCapturerConfiguration {
  const CameraCapturerConfiguration(
      {this.cameraDirection,
      this.deviceId,
      this.format,
      this.followEncodeDimensionRatio});

  @JsonKey(name: 'cameraDirection')
  final CameraDirection? cameraDirection;

  @JsonKey(name: 'deviceId')
  final String? deviceId;

  @JsonKey(name: 'format')
  final VideoFormat? format;

  @JsonKey(name: 'followEncodeDimensionRatio')
  final bool? followEncodeDimensionRatio;
  factory CameraCapturerConfiguration.fromJson(Map<String, dynamic> json) =>
      _$CameraCapturerConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$CameraCapturerConfigurationToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ScreenCaptureConfiguration {
  const ScreenCaptureConfiguration(
      {this.isCaptureWindow,
      this.displayId,
      this.screenRect,
      this.windowId,
      this.params,
      this.regionRect});

  @JsonKey(name: 'isCaptureWindow')
  final bool? isCaptureWindow;

  @JsonKey(name: 'displayId')
  final int? displayId;

  @JsonKey(name: 'screenRect')
  final Rectangle? screenRect;

  @JsonKey(name: 'windowId')
  final int? windowId;

  @JsonKey(name: 'params')
  final ScreenCaptureParameters? params;

  @JsonKey(name: 'regionRect')
  final Rectangle? regionRect;
  factory ScreenCaptureConfiguration.fromJson(Map<String, dynamic> json) =>
      _$ScreenCaptureConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$ScreenCaptureConfigurationToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SIZE {
  const SIZE({this.width, this.height});

  @JsonKey(name: 'width')
  final int? width;

  @JsonKey(name: 'height')
  final int? height;
  factory SIZE.fromJson(Map<String, dynamic> json) => _$SIZEFromJson(json);
  Map<String, dynamic> toJson() => _$SIZEToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ThumbImageBuffer {
  const ThumbImageBuffer({this.buffer, this.length, this.width, this.height});

  @JsonKey(name: 'buffer', ignore: true)
  final Uint8List? buffer;

  @JsonKey(name: 'length')
  final int? length;

  @JsonKey(name: 'width')
  final int? width;

  @JsonKey(name: 'height')
  final int? height;
  factory ThumbImageBuffer.fromJson(Map<String, dynamic> json) =>
      _$ThumbImageBufferFromJson(json);
  Map<String, dynamic> toJson() => _$ThumbImageBufferToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum ScreenCaptureSourceType {
  @JsonValue(-1)
  screencapturesourcetypeUnknown,

  @JsonValue(0)
  screencapturesourcetypeWindow,

  @JsonValue(1)
  screencapturesourcetypeScreen,

  @JsonValue(2)
  screencapturesourcetypeCustom,
}

/// Extensions functions of [ScreenCaptureSourceType].
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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ScreenCaptureSourceInfo {
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

  @JsonKey(name: 'type')
  final ScreenCaptureSourceType? type;

  @JsonKey(name: 'sourceId')
  final int? sourceId;

  @JsonKey(name: 'sourceName')
  final String? sourceName;

  @JsonKey(name: 'thumbImage')
  final ThumbImageBuffer? thumbImage;

  @JsonKey(name: 'iconImage')
  final ThumbImageBuffer? iconImage;

  @JsonKey(name: 'processPath')
  final String? processPath;

  @JsonKey(name: 'sourceTitle')
  final String? sourceTitle;

  @JsonKey(name: 'primaryMonitor')
  final bool? primaryMonitor;

  @JsonKey(name: 'isOccluded')
  final bool? isOccluded;
  factory ScreenCaptureSourceInfo.fromJson(Map<String, dynamic> json) =>
      _$ScreenCaptureSourceInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ScreenCaptureSourceInfoToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AdvancedAudioOptions {
  const AdvancedAudioOptions({this.audioProcessingChannels});

  @JsonKey(name: 'audioProcessingChannels')
  final int? audioProcessingChannels;
  factory AdvancedAudioOptions.fromJson(Map<String, dynamic> json) =>
      _$AdvancedAudioOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$AdvancedAudioOptionsToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ImageTrackOptions {
  const ImageTrackOptions({this.imageUrl, this.fps, this.mirrorMode});

  @JsonKey(name: 'imageUrl')
  final String? imageUrl;

  @JsonKey(name: 'fps')
  final int? fps;

  @JsonKey(name: 'mirrorMode')
  final VideoMirrorModeType? mirrorMode;
  factory ImageTrackOptions.fromJson(Map<String, dynamic> json) =>
      _$ImageTrackOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$ImageTrackOptionsToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ChannelMediaOptions {
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

  @JsonKey(name: 'publishCameraTrack')
  final bool? publishCameraTrack;

  @JsonKey(name: 'publishSecondaryCameraTrack')
  final bool? publishSecondaryCameraTrack;

  @JsonKey(name: 'publishMicrophoneTrack')
  final bool? publishMicrophoneTrack;

  @JsonKey(name: 'publishScreenCaptureVideo')
  final bool? publishScreenCaptureVideo;

  @JsonKey(name: 'publishScreenCaptureAudio')
  final bool? publishScreenCaptureAudio;

  @JsonKey(name: 'publishScreenTrack')
  final bool? publishScreenTrack;

  @JsonKey(name: 'publishSecondaryScreenTrack')
  final bool? publishSecondaryScreenTrack;

  @JsonKey(name: 'publishCustomAudioTrack')
  final bool? publishCustomAudioTrack;

  @JsonKey(name: 'publishCustomAudioSourceId')
  final int? publishCustomAudioSourceId;

  @JsonKey(name: 'publishCustomAudioTrackEnableAec')
  final bool? publishCustomAudioTrackEnableAec;

  @JsonKey(name: 'publishDirectCustomAudioTrack')
  final bool? publishDirectCustomAudioTrack;

  @JsonKey(name: 'publishCustomAudioTrackAec')
  final bool? publishCustomAudioTrackAec;

  @JsonKey(name: 'publishCustomVideoTrack')
  final bool? publishCustomVideoTrack;

  @JsonKey(name: 'publishEncodedVideoTrack')
  final bool? publishEncodedVideoTrack;

  @JsonKey(name: 'publishMediaPlayerAudioTrack')
  final bool? publishMediaPlayerAudioTrack;

  @JsonKey(name: 'publishMediaPlayerVideoTrack')
  final bool? publishMediaPlayerVideoTrack;

  @JsonKey(name: 'publishTrancodedVideoTrack')
  final bool? publishTrancodedVideoTrack;

  @JsonKey(name: 'autoSubscribeAudio')
  final bool? autoSubscribeAudio;

  @JsonKey(name: 'autoSubscribeVideo')
  final bool? autoSubscribeVideo;

  @JsonKey(name: 'enableAudioRecordingOrPlayout')
  final bool? enableAudioRecordingOrPlayout;

  @JsonKey(name: 'publishMediaPlayerId')
  final int? publishMediaPlayerId;

  @JsonKey(name: 'clientRoleType')
  final ClientRoleType? clientRoleType;

  @JsonKey(name: 'audienceLatencyLevel')
  final AudienceLatencyLevelType? audienceLatencyLevel;

  @JsonKey(name: 'defaultVideoStreamType')
  final VideoStreamType? defaultVideoStreamType;

  @JsonKey(name: 'channelProfile')
  final ChannelProfileType? channelProfile;

  @JsonKey(name: 'audioDelayMs')
  final int? audioDelayMs;

  @JsonKey(name: 'mediaPlayerAudioDelayMs')
  final int? mediaPlayerAudioDelayMs;

  @JsonKey(name: 'token')
  final String? token;

  @JsonKey(name: 'enableBuiltInMediaEncryption')
  final bool? enableBuiltInMediaEncryption;

  @JsonKey(name: 'publishRhythmPlayerTrack')
  final bool? publishRhythmPlayerTrack;

  @JsonKey(name: 'isInteractiveAudience')
  final bool? isInteractiveAudience;

  @JsonKey(name: 'customVideoTrackId')
  final int? customVideoTrackId;

  @JsonKey(name: 'isAudioFilterable')
  final bool? isAudioFilterable;
  factory ChannelMediaOptions.fromJson(Map<String, dynamic> json) =>
      _$ChannelMediaOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$ChannelMediaOptionsToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum LocalProxyMode {
  @JsonValue(0)
  connectivityFirst,

  @JsonValue(1)
  localOnly,
}

/// Extensions functions of [LocalProxyMode].
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

@JsonEnum(alwaysCreate: true)
enum ProxyType {
  @JsonValue(0)
  noneProxyType,

  @JsonValue(1)
  udpProxyType,

  @JsonValue(2)
  tcpProxyType,

  @JsonValue(3)
  localProxyType,

  @JsonValue(4)
  tcpProxyAutoFallbackType,
}

/// Extensions functions of [ProxyType].
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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LocalAccessPointConfiguration {
  const LocalAccessPointConfiguration(
      {this.ipList,
      this.ipListSize,
      this.domainList,
      this.domainListSize,
      this.verifyDomainName,
      this.mode});

  @JsonKey(name: 'ipList')
  final List<String>? ipList;

  @JsonKey(name: 'ipListSize')
  final int? ipListSize;

  @JsonKey(name: 'domainList')
  final List<String>? domainList;

  @JsonKey(name: 'domainListSize')
  final int? domainListSize;

  @JsonKey(name: 'verifyDomainName')
  final String? verifyDomainName;

  @JsonKey(name: 'mode')
  final LocalProxyMode? mode;
  factory LocalAccessPointConfiguration.fromJson(Map<String, dynamic> json) =>
      _$LocalAccessPointConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$LocalAccessPointConfigurationToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LeaveChannelOptions {
  const LeaveChannelOptions(
      {this.stopAudioMixing, this.stopAllEffect, this.stopMicrophoneRecording});

  @JsonKey(name: 'stopAudioMixing')
  final bool? stopAudioMixing;

  @JsonKey(name: 'stopAllEffect')
  final bool? stopAllEffect;

  @JsonKey(name: 'stopMicrophoneRecording')
  final bool? stopMicrophoneRecording;
  factory LeaveChannelOptions.fromJson(Map<String, dynamic> json) =>
      _$LeaveChannelOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$LeaveChannelOptionsToJson(this);
}

class RtcEngineEventHandler {
  /// Construct the [RtcEngineEventHandler].
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

  final void Function(RtcConnection connection, int elapsed)?
      onJoinChannelSuccess;

  final void Function(RtcConnection connection, int elapsed)?
      onRejoinChannelSuccess;

  final void Function(String channel, int uid, ProxyType proxyType,
      String localProxyIp, int elapsed)? onProxyConnected;

  final void Function(ErrorCodeType err, String msg)? onError;

  final void Function(RtcConnection connection, int remoteUid,
      QualityType quality, int delay, int lost)? onAudioQuality;

  final void Function(LastmileProbeResult result)? onLastmileProbeResult;

  final void Function(RtcConnection connection, List<AudioVolumeInfo> speakers,
      int speakerNumber, int totalVolume)? onAudioVolumeIndication;

  final void Function(RtcConnection connection, RtcStats stats)? onLeaveChannel;

  final void Function(RtcConnection connection, RtcStats stats)? onRtcStats;

  final void Function(String deviceId, MediaDeviceType deviceType,
      MediaDeviceStateType deviceState)? onAudioDeviceStateChanged;

  final void Function()? onAudioMixingFinished;

  final void Function(int soundId)? onAudioEffectFinished;

  final void Function(String deviceId, MediaDeviceType deviceType,
      MediaDeviceStateType deviceState)? onVideoDeviceStateChanged;

  final void Function(MediaDeviceType deviceType)? onMediaDeviceChanged;

  final void Function(RtcConnection connection, int remoteUid,
      QualityType txQuality, QualityType rxQuality)? onNetworkQuality;

  final void Function(RtcConnection connection)? onIntraRequestReceived;

  final void Function(UplinkNetworkInfo info)? onUplinkNetworkInfoUpdated;

  final void Function(DownlinkNetworkInfo info)? onDownlinkNetworkInfoUpdated;

  final void Function(QualityType quality)? onLastmileQuality;

  final void Function(
          RtcConnection connection, int width, int height, int elapsed)?
      onFirstLocalVideoFrame;

  final void Function(RtcConnection connection, int elapsed)?
      onFirstLocalVideoFramePublished;

  final void Function(RtcConnection connection, int remoteUid, int width,
      int height, int elapsed)? onFirstRemoteVideoDecoded;

  final void Function(RtcConnection connection, VideoSourceType sourceType,
      int uid, int width, int height, int rotation)? onVideoSizeChanged;

  final void Function(VideoSourceType source, LocalVideoStreamState state,
      LocalVideoStreamError error)? onLocalVideoStateChanged;

  final void Function(
      RtcConnection connection,
      int remoteUid,
      RemoteVideoState state,
      RemoteVideoStateReason reason,
      int elapsed)? onRemoteVideoStateChanged;

  final void Function(RtcConnection connection, int remoteUid, int width,
      int height, int elapsed)? onFirstRemoteVideoFrame;

  final void Function(RtcConnection connection, int remoteUid, int elapsed)?
      onUserJoined;

  final void Function(RtcConnection connection, int remoteUid,
      UserOfflineReasonType reason)? onUserOffline;

  final void Function(RtcConnection connection, int remoteUid, bool muted)?
      onUserMuteAudio;

  final void Function(RtcConnection connection, int remoteUid, bool muted)?
      onUserMuteVideo;

  final void Function(RtcConnection connection, int remoteUid, bool enabled)?
      onUserEnableVideo;

  final void Function(RtcConnection connection, int remoteUid, int state)?
      onUserStateChanged;

  final void Function(RtcConnection connection, int remoteUid, bool enabled)?
      onUserEnableLocalVideo;

  final void Function(ErrorCodeType err, String api, String result)?
      onApiCallExecuted;

  final void Function(RtcConnection connection, LocalAudioStats stats)?
      onLocalAudioStats;

  final void Function(RtcConnection connection, RemoteAudioStats stats)?
      onRemoteAudioStats;

  final void Function(RtcConnection connection, LocalVideoStats stats)?
      onLocalVideoStats;

  final void Function(RtcConnection connection, RemoteVideoStats stats)?
      onRemoteVideoStats;

  final void Function()? onCameraReady;

  final void Function(int x, int y, int width, int height)?
      onCameraFocusAreaChanged;

  final void Function(int x, int y, int width, int height)?
      onCameraExposureAreaChanged;

  final void Function(int imageWidth, int imageHeight, Rectangle vecRectangle,
      int vecDistance, int numFaces)? onFacePositionChanged;

  final void Function()? onVideoStopped;

  final void Function(AudioMixingStateType state, AudioMixingReasonType reason)?
      onAudioMixingStateChanged;

  final void Function(
          RhythmPlayerStateType state, RhythmPlayerErrorType errorCode)?
      onRhythmPlayerStateChanged;

  final void Function(RtcConnection connection)? onConnectionLost;

  final void Function(RtcConnection connection)? onConnectionInterrupted;

  final void Function(RtcConnection connection)? onConnectionBanned;

  final void Function(RtcConnection connection, int remoteUid, int streamId,
      Uint8List data, int length, int sentTs)? onStreamMessage;

  final void Function(RtcConnection connection, int remoteUid, int streamId,
      ErrorCodeType code, int missed, int cached)? onStreamMessageError;

  final void Function(RtcConnection connection)? onRequestToken;

  final void Function(RtcConnection connection, String token)?
      onTokenPrivilegeWillExpire;

  final void Function(RtcConnection connection, int elapsed)?
      onFirstLocalAudioFramePublished;

  final void Function(RtcConnection connection, int userId, int elapsed)?
      onFirstRemoteAudioFrame;

  final void Function(RtcConnection connection, int uid, int elapsed)?
      onFirstRemoteAudioDecoded;

  final void Function(RtcConnection connection, LocalAudioStreamState state,
      LocalAudioStreamError error)? onLocalAudioStateChanged;

  final void Function(
      RtcConnection connection,
      int remoteUid,
      RemoteAudioState state,
      RemoteAudioStateReason reason,
      int elapsed)? onRemoteAudioStateChanged;

  final void Function(RtcConnection connection, int uid)? onActiveSpeaker;

  final void Function(ContentInspectResult result)? onContentInspectResult;

  final void Function(RtcConnection connection, int uid, String filePath,
      int width, int height, int errCode)? onSnapshotTaken;

  final void Function(RtcConnection connection, ClientRoleType oldRole,
      ClientRoleType newRole)? onClientRoleChanged;

  final void Function(
      RtcConnection connection,
      ClientRoleChangeFailedReason reason,
      ClientRoleType currentRole)? onClientRoleChangeFailed;

  final void Function(MediaDeviceType deviceType, int volume, bool muted)?
      onAudioDeviceVolumeChanged;

  final void Function(String url, RtmpStreamPublishState state,
      RtmpStreamPublishErrorType errCode)? onRtmpStreamingStateChanged;

  final void Function(String url, RtmpStreamingEvent eventCode)?
      onRtmpStreamingEvent;

  final void Function()? onTranscodingUpdated;

  final void Function(int routing)? onAudioRoutingChanged;

  final void Function(
          ChannelMediaRelayState state, ChannelMediaRelayError code)?
      onChannelMediaRelayStateChanged;

  final void Function(ChannelMediaRelayEvent code)? onChannelMediaRelayEvent;

  final void Function(bool isFallbackOrRecover)?
      onLocalPublishFallbackToAudioOnly;

  final void Function(int uid, bool isFallbackOrRecover)?
      onRemoteSubscribeFallbackToAudioOnly;

  final void Function(RtcConnection connection, int remoteUid, int delay,
      int lost, int rxKBitRate)? onRemoteAudioTransportStats;

  final void Function(RtcConnection connection, int remoteUid, int delay,
      int lost, int rxKBitRate)? onRemoteVideoTransportStats;

  final void Function(RtcConnection connection, ConnectionStateType state,
      ConnectionChangedReasonType reason)? onConnectionStateChanged;

  final void Function(RtcConnection connection, WlaccMessageReason reason,
      WlaccSuggestAction action, String wlAccMsg)? onWlAccMessage;

  final void Function(RtcConnection connection, WlAccStats currentStats,
      WlAccStats averageStats)? onWlAccStats;

  final void Function(RtcConnection connection, NetworkType type)?
      onNetworkTypeChanged;

  final void Function(RtcConnection connection, EncryptionErrorType errorType)?
      onEncryptionError;

  final void Function(PermissionType permissionType)? onPermissionError;

  final void Function(int uid, String userAccount)? onLocalUserRegistered;

  final void Function(int uid, UserInfo info)? onUserInfoUpdated;

  final void Function(RtcConnection connection, String requestId, bool success,
      UploadErrorReason reason)? onUploadLogResult;

  final void Function(
      String channel,
      int uid,
      StreamSubscribeState oldState,
      StreamSubscribeState newState,
      int elapseSinceLastState)? onAudioSubscribeStateChanged;

  final void Function(
      String channel,
      int uid,
      StreamSubscribeState oldState,
      StreamSubscribeState newState,
      int elapseSinceLastState)? onVideoSubscribeStateChanged;

  final void Function(
      String channel,
      StreamPublishState oldState,
      StreamPublishState newState,
      int elapseSinceLastState)? onAudioPublishStateChanged;

  final void Function(
      VideoSourceType source,
      String channel,
      StreamPublishState oldState,
      StreamPublishState newState,
      int elapseSinceLastState)? onVideoPublishStateChanged;

  final void Function(
          String provider, String extension, String key, String value)?
      onExtensionEvent;

  final void Function(String provider, String extension)? onExtensionStarted;

  final void Function(String provider, String extension)? onExtensionStopped;

  final void Function(
          String provider, String extension, int error, String message)?
      onExtensionError;

  final void Function(
          RtcConnection connection, int remoteUid, String userAccount)?
      onUserAccountUpdated;
}

abstract class VideoDeviceManager {
  Future<List<VideoDeviceInfo>> enumerateVideoDevices();

  Future<void> setDevice(String deviceIdUTF8);

  Future<String> getDevice();

  Future<void> numberOfCapabilities(String deviceIdUTF8);

  Future<VideoFormat> getCapability(
      {required String deviceIdUTF8, required int deviceCapabilityNumber});

  Future<void> startDeviceTest(int hwnd);

  Future<void> stopDeviceTest();

  Future<void> release();
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RtcEngineContext {
  const RtcEngineContext(
      {this.appId,
      this.channelProfile,
      this.audioScenario,
      this.areaCode,
      this.logConfig,
      this.threadPriority,
      this.useExternalEglContext});

  @JsonKey(name: 'appId')
  final String? appId;

  @JsonKey(name: 'channelProfile')
  final ChannelProfileType? channelProfile;

  @JsonKey(name: 'audioScenario')
  final AudioScenarioType? audioScenario;

  @JsonKey(name: 'areaCode')
  final int? areaCode;

  @JsonKey(name: 'logConfig')
  final LogConfig? logConfig;

  @JsonKey(name: 'threadPriority')
  final ThreadPriorityType? threadPriority;

  @JsonKey(name: 'useExternalEglContext')
  final bool? useExternalEglContext;
  factory RtcEngineContext.fromJson(Map<String, dynamic> json) =>
      _$RtcEngineContextFromJson(json);
  Map<String, dynamic> toJson() => _$RtcEngineContextToJson(this);
}

class MetadataObserver {
  /// Construct the [MetadataObserver].
  const MetadataObserver({
    this.onMetadataReceived,
  });

  final void Function(Metadata metadata)? onMetadataReceived;
}

@JsonEnum(alwaysCreate: true)
enum MetadataType {
  @JsonValue(-1)
  unknownMetadata,

  @JsonValue(0)
  videoMetadata,
}

/// Extensions functions of [MetadataType].
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

@JsonEnum(alwaysCreate: true)
enum MaxMetadataSizeType {
  @JsonValue(-1)
  invalidMetadataSizeInByte,

  @JsonValue(512)
  defaultMetadataSizeInByte,

  @JsonValue(1024)
  maxMetadataSizeInByte,
}

/// Extensions functions of [MaxMetadataSizeType].
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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Metadata {
  const Metadata({this.uid, this.size, this.buffer, this.timeStampMs});

  @JsonKey(name: 'uid')
  final int? uid;

  @JsonKey(name: 'size')
  final int? size;

  @JsonKey(name: 'buffer', ignore: true)
  final Uint8List? buffer;

  @JsonKey(name: 'timeStampMs')
  final int? timeStampMs;
  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);
  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum DirectCdnStreamingError {
  @JsonValue(0)
  directCdnStreamingErrorOk,

  @JsonValue(1)
  directCdnStreamingErrorFailed,

  @JsonValue(2)
  directCdnStreamingErrorAudioPublication,

  @JsonValue(3)
  directCdnStreamingErrorVideoPublication,

  @JsonValue(4)
  directCdnStreamingErrorNetConnect,

  @JsonValue(5)
  directCdnStreamingErrorBadName,
}

/// Extensions functions of [DirectCdnStreamingError].
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

@JsonEnum(alwaysCreate: true)
enum DirectCdnStreamingState {
  @JsonValue(0)
  directCdnStreamingStateIdle,

  @JsonValue(1)
  directCdnStreamingStateRunning,

  @JsonValue(2)
  directCdnStreamingStateStopped,

  @JsonValue(3)
  directCdnStreamingStateFailed,

  @JsonValue(4)
  directCdnStreamingStateRecovering,
}

/// Extensions functions of [DirectCdnStreamingState].
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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class DirectCdnStreamingStats {
  const DirectCdnStreamingStats(
      {this.videoWidth,
      this.videoHeight,
      this.fps,
      this.videoBitrate,
      this.audioBitrate});

  @JsonKey(name: 'videoWidth')
  final int? videoWidth;

  @JsonKey(name: 'videoHeight')
  final int? videoHeight;

  @JsonKey(name: 'fps')
  final int? fps;

  @JsonKey(name: 'videoBitrate')
  final int? videoBitrate;

  @JsonKey(name: 'audioBitrate')
  final int? audioBitrate;
  factory DirectCdnStreamingStats.fromJson(Map<String, dynamic> json) =>
      _$DirectCdnStreamingStatsFromJson(json);
  Map<String, dynamic> toJson() => _$DirectCdnStreamingStatsToJson(this);
}

class DirectCdnStreamingEventHandler {
  /// Construct the [DirectCdnStreamingEventHandler].
  const DirectCdnStreamingEventHandler({
    this.onDirectCdnStreamingStateChanged,
    this.onDirectCdnStreamingStats,
  });

  final void Function(
      DirectCdnStreamingState state,
      DirectCdnStreamingError error,
      String message)? onDirectCdnStreamingStateChanged;

  final void Function(DirectCdnStreamingStats stats)? onDirectCdnStreamingStats;
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class DirectCdnStreamingMediaOptions {
  const DirectCdnStreamingMediaOptions(
      {this.publishCameraTrack,
      this.publishMicrophoneTrack,
      this.publishCustomAudioTrack,
      this.publishCustomVideoTrack,
      this.publishMediaPlayerAudioTrack,
      this.publishMediaPlayerId,
      this.customVideoTrackId});

  @JsonKey(name: 'publishCameraTrack')
  final bool? publishCameraTrack;

  @JsonKey(name: 'publishMicrophoneTrack')
  final bool? publishMicrophoneTrack;

  @JsonKey(name: 'publishCustomAudioTrack')
  final bool? publishCustomAudioTrack;

  @JsonKey(name: 'publishCustomVideoTrack')
  final bool? publishCustomVideoTrack;

  @JsonKey(name: 'publishMediaPlayerAudioTrack')
  final bool? publishMediaPlayerAudioTrack;

  @JsonKey(name: 'publishMediaPlayerId')
  final int? publishMediaPlayerId;

  @JsonKey(name: 'customVideoTrackId')
  final int? customVideoTrackId;
  factory DirectCdnStreamingMediaOptions.fromJson(Map<String, dynamic> json) =>
      _$DirectCdnStreamingMediaOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$DirectCdnStreamingMediaOptionsToJson(this);
}

abstract class RtcEngine {
  Future<void> release({bool sync = false});

  Future<void> initialize(RtcEngineContext context);

  Future<SDKBuildInfo> getVersion();

  Future<String> getErrorDescription(int code);

  Future<void> updateChannelMediaOptions(ChannelMediaOptions options);

  Future<void> renewToken(String token);

  Future<void> setChannelProfile(ChannelProfileType profile);

  Future<void> stopEchoTest();

  Future<void> enableVideo();

  Future<void> disableVideo();

  Future<void> startLastmileProbeTest(LastmileProbeConfig config);

  Future<void> stopLastmileProbeTest();

  Future<void> setVideoEncoderConfiguration(VideoEncoderConfiguration config);

  Future<void> setBeautyEffectOptions(
      {required bool enabled,
      required BeautyOptions options,
      MediaSourceType type = MediaSourceType.primaryCameraSource});

  Future<void> setLowlightEnhanceOptions(
      {required bool enabled,
      required LowlightEnhanceOptions options,
      MediaSourceType type = MediaSourceType.primaryCameraSource});

  Future<void> setVideoDenoiserOptions(
      {required bool enabled,
      required VideoDenoiserOptions options,
      MediaSourceType type = MediaSourceType.primaryCameraSource});

  Future<void> setColorEnhanceOptions(
      {required bool enabled,
      required ColorEnhanceOptions options,
      MediaSourceType type = MediaSourceType.primaryCameraSource});

  Future<void> enableVirtualBackground(
      {required bool enabled,
      required VirtualBackgroundSource backgroundSource,
      required SegmentationProperty segproperty,
      MediaSourceType type = MediaSourceType.primaryCameraSource});

  Future<void> enableRemoteSuperResolution(
      {required int userId, required bool enable});

  Future<void> setupRemoteVideo(VideoCanvas canvas);

  Future<void> setupLocalVideo(VideoCanvas canvas);

  Future<void> enableAudio();

  Future<void> disableAudio();

  Future<void> setAudioScenario(AudioScenarioType scenario);

  Future<void> enableLocalAudio(bool enabled);

  Future<void> muteLocalAudioStream(bool mute);

  Future<void> muteAllRemoteAudioStreams(bool mute);

  Future<void> setDefaultMuteAllRemoteAudioStreams(bool mute);

  Future<void> muteRemoteAudioStream({required int uid, required bool mute});

  Future<void> muteLocalVideoStream(bool mute);

  Future<void> enableLocalVideo(bool enabled);

  Future<void> muteAllRemoteVideoStreams(bool mute);

  Future<void> setDefaultMuteAllRemoteVideoStreams(bool mute);

  Future<void> muteRemoteVideoStream({required int uid, required bool mute});

  Future<void> setRemoteVideoStreamType(
      {required int uid, required VideoStreamType streamType});

  Future<void> setRemoteVideoSubscriptionOptions(
      {required int uid, required VideoSubscriptionOptions options});

  Future<void> setRemoteDefaultVideoStreamType(VideoStreamType streamType);

  Future<void> setSubscribeAudioBlacklist(
      {required List<int> uidList, required int uidNumber});

  Future<void> setSubscribeAudioWhitelist(
      {required List<int> uidList, required int uidNumber});

  Future<void> setSubscribeVideoBlacklist(
      {required List<int> uidList, required int uidNumber});

  Future<void> setSubscribeVideoWhitelist(
      {required List<int> uidList, required int uidNumber});

  Future<void> enableAudioVolumeIndication(
      {required int interval, required int smooth, required bool reportVad});

  void registerAudioEncodedFrameObserver(
      {required AudioEncodedFrameObserverConfig config,
      required AudioEncodedFrameObserver observer});

  Future<void> stopAudioRecording();

  Future<MediaPlayer> createMediaPlayer();

  Future<void> destroyMediaPlayer(MediaPlayer mediaPlayer);

  Future<void> stopAudioMixing();

  Future<void> pauseAudioMixing();

  Future<void> resumeAudioMixing();

  Future<void> selectAudioTrack(int index);

  Future<int> getAudioTrackCount();

  Future<void> adjustAudioMixingVolume(int volume);

  Future<void> adjustAudioMixingPublishVolume(int volume);

  Future<int> getAudioMixingPublishVolume();

  Future<void> adjustAudioMixingPlayoutVolume(int volume);

  Future<int> getAudioMixingPlayoutVolume();

  Future<int> getAudioMixingDuration();

  Future<int> getAudioMixingCurrentPosition();

  Future<void> setAudioMixingPosition(int pos);

  Future<void> setAudioMixingDualMonoMode(AudioMixingDualMonoMode mode);

  Future<void> setAudioMixingPitch(int pitch);

  Future<int> getEffectsVolume();

  Future<void> setEffectsVolume(int volume);

  Future<void> preloadEffect(
      {required int soundId, required String filePath, int startPos = 0});

  Future<void> playEffect(
      {required int soundId,
      required String filePath,
      required int loopCount,
      required double pitch,
      required double pan,
      required int gain,
      bool publish = false,
      int startPos = 0});

  Future<void> playAllEffects(
      {required int loopCount,
      required double pitch,
      required double pan,
      required int gain,
      bool publish = false});

  Future<int> getVolumeOfEffect(int soundId);

  Future<void> setVolumeOfEffect({required int soundId, required int volume});

  Future<void> pauseEffect(int soundId);

  Future<void> pauseAllEffects();

  Future<void> resumeEffect(int soundId);

  Future<void> resumeAllEffects();

  Future<void> stopEffect(int soundId);

  Future<void> stopAllEffects();

  Future<void> unloadEffect(int soundId);

  Future<void> unloadAllEffects();

  Future<int> getEffectDuration(String filePath);

  Future<void> setEffectPosition({required int soundId, required int pos});

  Future<int> getEffectCurrentPosition(int soundId);

  Future<void> enableSoundPositionIndication(bool enabled);

  Future<void> setRemoteVoicePosition(
      {required int uid, required double pan, required double gain});

  Future<void> enableSpatialAudio(bool enabled);

  Future<void> setRemoteUserSpatialAudioParams(
      {required int uid, required SpatialAudioParams params});

  Future<void> setVoiceBeautifierPreset(VoiceBeautifierPreset preset);

  Future<void> setAudioEffectPreset(AudioEffectPreset preset);

  Future<void> setVoiceConversionPreset(VoiceConversionPreset preset);

  Future<void> setAudioEffectParameters(
      {required AudioEffectPreset preset,
      required int param1,
      required int param2});

  Future<void> setVoiceBeautifierParameters(
      {required VoiceBeautifierPreset preset,
      required int param1,
      required int param2});

  Future<void> setVoiceConversionParameters(
      {required VoiceConversionPreset preset,
      required int param1,
      required int param2});

  Future<void> setLocalVoicePitch(double pitch);

  Future<void> setLocalVoiceEqualization(
      {required AudioEqualizationBandFrequency bandFrequency,
      required int bandGain});

  Future<void> setLocalVoiceReverb(
      {required AudioReverbType reverbKey, required int value});

  Future<void> setLogFile(String filePath);

  Future<void> setLogFilter(LogFilterType filter);

  Future<void> setLogLevel(LogLevel level);

  Future<void> setLogFileSize(int fileSizeInKBytes);

  Future<void> uploadLogFile(String requestId);

  Future<void> setRemoteRenderMode(
      {required int uid,
      required RenderModeType renderMode,
      required VideoMirrorModeType mirrorMode});

  Future<void> setLocalVideoMirrorMode(VideoMirrorModeType mirrorMode);

  Future<void> enableEchoCancellationExternal(
      {required bool enabled, required int audioSourceDelay});

  Future<void> enableCustomAudioLocalPlayback(
      {required int sourceId, required bool enabled});

  Future<void> startPrimaryCustomAudioTrack(AudioTrackConfig config);

  Future<void> stopPrimaryCustomAudioTrack();

  Future<void> startSecondaryCustomAudioTrack(AudioTrackConfig config);

  Future<void> stopSecondaryCustomAudioTrack();

  Future<void> setRecordingAudioFrameParameters(
      {required int sampleRate,
      required int channel,
      required RawAudioFrameOpModeType mode,
      required int samplesPerCall});

  Future<void> setPlaybackAudioFrameParameters(
      {required int sampleRate,
      required int channel,
      required RawAudioFrameOpModeType mode,
      required int samplesPerCall});

  Future<void> setMixedAudioFrameParameters(
      {required int sampleRate,
      required int channel,
      required int samplesPerCall});

  Future<void> setPlaybackAudioFrameBeforeMixingParameters(
      {required int sampleRate, required int channel});

  Future<void> enableAudioSpectrumMonitor({int intervalInMS = 100});

  Future<void> disableAudioSpectrumMonitor();

  void registerAudioSpectrumObserver(AudioSpectrumObserver observer);

  void unregisterAudioSpectrumObserver(AudioSpectrumObserver observer);

  Future<void> adjustRecordingSignalVolume(int volume);

  Future<void> muteRecordingSignal(bool mute);

  Future<void> adjustPlaybackSignalVolume(int volume);

  Future<void> adjustUserPlaybackSignalVolume(
      {required int uid, required int volume});

  Future<void> setLocalPublishFallbackOption(StreamFallbackOptions option);

  Future<void> setRemoteSubscribeFallbackOption(StreamFallbackOptions option);

  Future<void> enableLoopbackRecording(
      {required bool enabled, String? deviceName});

  Future<void> adjustLoopbackSignalVolume(int volume);

  Future<int> getLoopbackRecordingVolume();

  Future<void> enableInEarMonitoring(
      {required bool enabled,
      required EarMonitoringFilterType includeAudioFilters});

  Future<void> setInEarMonitoringVolume(int volume);

  Future<void> loadExtensionProvider(
      {required String path, bool unloadAfterUse = false});

  Future<void> setExtensionProviderProperty(
      {required String provider, required String key, required String value});

  Future<void> enableExtension(
      {required String provider,
      required String extension,
      bool enable = true,
      MediaSourceType type = MediaSourceType.unknownMediaSource});

  Future<void> setExtensionProperty(
      {required String provider,
      required String extension,
      required String key,
      required String value,
      MediaSourceType type = MediaSourceType.unknownMediaSource});

  Future<String> getExtensionProperty(
      {required String provider,
      required String extension,
      required String key,
      required int bufLen,
      MediaSourceType type = MediaSourceType.unknownMediaSource});

  Future<void> setCameraCapturerConfiguration(
      CameraCapturerConfiguration config);

  Future<int> createCustomVideoTrack();

  Future<int> createCustomEncodedVideoTrack(SenderOptions senderOption);

  Future<void> destroyCustomVideoTrack(int videoTrackId);

  Future<void> destroyCustomEncodedVideoTrack(int videoTrackId);

  Future<void> switchCamera();

  Future<bool> isCameraZoomSupported();

  Future<bool> isCameraFaceDetectSupported();

  Future<bool> isCameraTorchSupported();

  Future<bool> isCameraFocusSupported();

  Future<bool> isCameraAutoFocusFaceModeSupported();

  Future<void> setCameraZoomFactor(double factor);

  Future<void> enableFaceDetection(bool enabled);

  Future<double> getCameraMaxZoomFactor();

  Future<void> setCameraFocusPositionInPreview(
      {required double positionX, required double positionY});

  Future<void> setCameraTorchOn(bool isOn);

  Future<void> setCameraAutoFocusFaceModeEnabled(bool enabled);

  Future<bool> isCameraExposurePositionSupported();

  Future<void> setCameraExposurePosition(
      {required double positionXinView, required double positionYinView});

  Future<bool> isCameraAutoExposureFaceModeSupported();

  Future<void> setCameraAutoExposureFaceModeEnabled(bool enabled);

  Future<void> setDefaultAudioRouteToSpeakerphone(bool defaultToSpeaker);

  Future<void> setEnableSpeakerphone(bool speakerOn);

  Future<bool> isSpeakerphoneEnabled();

  Future<List<ScreenCaptureSourceInfo>> getScreenCaptureSources(
      {required SIZE thumbSize,
      required SIZE iconSize,
      required bool includeScreen});

  Future<void> setAudioSessionOperationRestriction(
      AudioSessionOperationRestriction restriction);

  Future<void> startScreenCaptureByDisplayId(
      {required int displayId,
      required Rectangle regionRect,
      required ScreenCaptureParameters captureParams});

  Future<void> startScreenCaptureByScreenRect(
      {required Rectangle screenRect,
      required Rectangle regionRect,
      required ScreenCaptureParameters captureParams});

  Future<DeviceInfo> getAudioDeviceInfo();

  Future<void> startScreenCaptureByWindowId(
      {required int windowId,
      required Rectangle regionRect,
      required ScreenCaptureParameters captureParams});

  Future<void> setScreenCaptureContentHint(VideoContentHint contentHint);

  Future<void> setScreenCaptureScenario(ScreenScenarioType screenScenario);

  Future<void> updateScreenCaptureRegion(Rectangle regionRect);

  Future<void> updateScreenCaptureParameters(
      ScreenCaptureParameters captureParams);

  Future<void> startScreenCapture(ScreenCaptureParameters2 captureParams);

  Future<void> updateScreenCapture(ScreenCaptureParameters2 captureParams);

  Future<void> stopScreenCapture();

  Future<String> getCallId();

  Future<void> rate(
      {required String callId,
      required int rating,
      required String description});

  Future<void> complain({required String callId, required String description});

  Future<void> startRtmpStreamWithoutTranscoding(String url);

  Future<void> startRtmpStreamWithTranscoding(
      {required String url, required LiveTranscoding transcoding});

  Future<void> updateRtmpTranscoding(LiveTranscoding transcoding);

  Future<void> stopRtmpStream(String url);

  Future<void> startLocalVideoTranscoder(LocalTranscoderConfiguration config);

  Future<void> updateLocalTranscoderConfiguration(
      LocalTranscoderConfiguration config);

  Future<void> stopLocalVideoTranscoder();

  Future<void> startPrimaryCameraCapture(CameraCapturerConfiguration config);

  Future<void> startSecondaryCameraCapture(CameraCapturerConfiguration config);

  Future<void> stopPrimaryCameraCapture();

  Future<void> stopSecondaryCameraCapture();

  Future<void> setCameraDeviceOrientation(
      {required VideoSourceType type, required VideoOrientation orientation});

  Future<void> setScreenCaptureOrientation(
      {required VideoSourceType type, required VideoOrientation orientation});

  Future<void> startPrimaryScreenCapture(ScreenCaptureConfiguration config);

  Future<void> startSecondaryScreenCapture(ScreenCaptureConfiguration config);

  Future<void> stopPrimaryScreenCapture();

  Future<void> stopSecondaryScreenCapture();

  Future<ConnectionStateType> getConnectionState();

  void registerEventHandler(RtcEngineEventHandler eventHandler);

  void unregisterEventHandler(RtcEngineEventHandler eventHandler);

  Future<void> setRemoteUserPriority(
      {required int uid, required PriorityType userPriority});

  Future<void> setEncryptionMode(String encryptionMode);

  Future<void> setEncryptionSecret(String secret);

  Future<void> enableEncryption(
      {required bool enabled, required EncryptionConfig config});

  Future<void> sendStreamMessage(
      {required int streamId, required Uint8List data, required int length});

  Future<void> clearVideoWatermark();

  Future<void> clearVideoWatermarks();

  Future<void> addInjectStreamUrl(
      {required String url, required InjectStreamConfig config});

  Future<void> removeInjectStreamUrl(String url);

  Future<void> pauseAudio();

  Future<void> resumeAudio();

  Future<void> enableWebSdkInteroperability(bool enabled);

  Future<void> sendCustomReportMessage(
      {required String id,
      required String category,
      required String event,
      required String label,
      required int value});

  void registerMediaMetadataObserver(
      {required MetadataObserver observer, required MetadataType type});

  void unregisterMediaMetadataObserver(
      {required MetadataObserver observer, required MetadataType type});

  Future<void> startAudioFrameDump(
      {required String channelId,
      required int userId,
      required String location,
      required String uuid,
      required String passwd,
      required int durationMs,
      required bool autoUpload});

  Future<void> stopAudioFrameDump(
      {required String channelId,
      required int userId,
      required String location});

  Future<void> registerLocalUserAccount(
      {required String appId, required String userAccount});

  Future<void> joinChannelWithUserAccountEx(
      {required String token,
      required String channelId,
      required String userAccount,
      required ChannelMediaOptions options});

  Future<UserInfo> getUserInfoByUserAccount(String userAccount);

  Future<UserInfo> getUserInfoByUid(int uid);

  Future<void> startChannelMediaRelay(
      ChannelMediaRelayConfiguration configuration);

  Future<void> updateChannelMediaRelay(
      ChannelMediaRelayConfiguration configuration);

  Future<void> stopChannelMediaRelay();

  Future<void> pauseAllChannelMediaRelay();

  Future<void> resumeAllChannelMediaRelay();

  Future<void> setDirectCdnStreamingAudioConfiguration(
      AudioProfileType profile);

  Future<void> setDirectCdnStreamingVideoConfiguration(
      VideoEncoderConfiguration config);

  Future<void> startDirectCdnStreaming(
      {required DirectCdnStreamingEventHandler eventHandler,
      required String publishUrl,
      required DirectCdnStreamingMediaOptions options});

  Future<void> stopDirectCdnStreaming();

  Future<void> updateDirectCdnStreamingMediaOptions(
      DirectCdnStreamingMediaOptions options);

  Future<void> startRhythmPlayer(
      {required String sound1,
      required String sound2,
      required AgoraRhythmPlayerConfig config});

  Future<void> stopRhythmPlayer();

  Future<void> configRhythmPlayer(AgoraRhythmPlayerConfig config);

  Future<void> takeSnapshot({required int uid, required String filePath});

  Future<void> enableContentInspect(
      {required bool enabled, required ContentInspectConfig config});

  Future<void> adjustCustomAudioPublishVolume(
      {required int sourceId, required int volume});

  Future<void> adjustCustomAudioPlayoutVolume(
      {required int sourceId, required int volume});

  Future<void> setCloudProxy(CloudProxyType proxyType);

  Future<void> setLocalAccessPoint(LocalAccessPointConfiguration config);

  Future<AdvancedAudioOptions> setAdvancedAudioOptions();

  Future<void> setAVSyncSource({required String channelId, required int uid});

  Future<void> enableVideoImageSource(
      {required bool enable, required ImageTrackOptions options});

  Future<void> enableWirelessAccelerate(bool enabled);

  Future<void> joinChannel(
      {required String token,
      required String channelId,
      required int uid,
      required ChannelMediaOptions options});

  Future<void> leaveChannel({LeaveChannelOptions? options});

  Future<void> setClientRole(
      {required ClientRoleType role, ClientRoleOptions? options});

  Future<void> startEchoTest({int intervalInSeconds = 10});

  Future<void> startPreview(
      {VideoSourceType sourceType = VideoSourceType.videoSourceCameraPrimary});

  Future<void> stopPreview(
      {VideoSourceType sourceType = VideoSourceType.videoSourceCameraPrimary});

  Future<void> setAudioProfile(
      {required AudioProfileType profile,
      AudioScenarioType scenario = AudioScenarioType.audioScenarioDefault});

  Future<void> startAudioRecording(AudioRecordingConfiguration config);

  Future<void> startAudioMixing(
      {required String filePath,
      required bool loopback,
      required int cycle,
      int startPos = 0});

  Future<void> setLocalRenderMode(
      {required RenderModeType renderMode,
      VideoMirrorModeType mirrorMode =
          VideoMirrorModeType.videoMirrorModeAuto});

  Future<void> enableDualStreamMode(
      {required bool enabled,
      VideoSourceType sourceType = VideoSourceType.videoSourceCameraPrimary,
      SimulcastStreamConfig? streamConfig});

  Future<int> createDataStream(DataStreamConfig config);

  Future<void> addVideoWatermark(
      {required String watermarkUrl, required WatermarkOptions options});

  Future<void> joinChannelWithUserAccount(
      {required String token,
      required String channelId,
      required String userAccount,
      ChannelMediaOptions? options});

  AudioDeviceManager getAudioDeviceManager();

  VideoDeviceManager getVideoDeviceManager();

  MediaEngine getMediaEngine();

  MediaRecorder getMediaRecorder();

  LocalSpatialAudioEngine getLocalSpatialAudioEngine();

  Future<void> sendMetaData(
      {required Metadata metadata, required VideoSourceType sourceType});

  Future<void> setMaxMetadataSize(int size);

  void unregisterAudioEncodedFrameObserver(AudioEncodedFrameObserver observer);

  Future<void> setParameters(String parameters);
}

@JsonEnum(alwaysCreate: true)
enum QualityReportFormatType {
  @JsonValue(0)
  qualityReportJson,

  @JsonValue(1)
  qualityReportHtml,
}

/// Extensions functions of [QualityReportFormatType].
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

@JsonEnum(alwaysCreate: true)
enum MediaDeviceStateType {
  @JsonValue(0)
  mediaDeviceStateIdle,

  @JsonValue(1)
  mediaDeviceStateActive,

  @JsonValue(2)
  mediaDeviceStateDisabled,

  @JsonValue(4)
  mediaDeviceStateNotPresent,

  @JsonValue(8)
  mediaDeviceStateUnplugged,
}

/// Extensions functions of [MediaDeviceStateType].
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

@JsonEnum(alwaysCreate: true)
enum VideoProfileType {
  @JsonValue(0)
  videoProfileLandscape120p,

  @JsonValue(2)
  videoProfileLandscape120p3,

  @JsonValue(10)
  videoProfileLandscape180p,

  @JsonValue(12)
  videoProfileLandscape180p3,

  @JsonValue(13)
  videoProfileLandscape180p4,

  @JsonValue(20)
  videoProfileLandscape240p,

  @JsonValue(22)
  videoProfileLandscape240p3,

  @JsonValue(23)
  videoProfileLandscape240p4,

  @JsonValue(30)
  videoProfileLandscape360p,

  @JsonValue(32)
  videoProfileLandscape360p3,

  @JsonValue(33)
  videoProfileLandscape360p4,

  @JsonValue(35)
  videoProfileLandscape360p6,

  @JsonValue(36)
  videoProfileLandscape360p7,

  @JsonValue(37)
  videoProfileLandscape360p8,

  @JsonValue(38)
  videoProfileLandscape360p9,

  @JsonValue(39)
  videoProfileLandscape360p10,

  @JsonValue(100)
  videoProfileLandscape360p11,

  @JsonValue(40)
  videoProfileLandscape480p,

  @JsonValue(42)
  videoProfileLandscape480p3,

  @JsonValue(43)
  videoProfileLandscape480p4,

  @JsonValue(45)
  videoProfileLandscape480p6,

  @JsonValue(47)
  videoProfileLandscape480p8,

  @JsonValue(48)
  videoProfileLandscape480p9,

  @JsonValue(49)
  videoProfileLandscape480p10,

  @JsonValue(50)
  videoProfileLandscape720p,

  @JsonValue(52)
  videoProfileLandscape720p3,

  @JsonValue(54)
  videoProfileLandscape720p5,

  @JsonValue(55)
  videoProfileLandscape720p6,

  @JsonValue(60)
  videoProfileLandscape1080p,

  @JsonValue(62)
  videoProfileLandscape1080p3,

  @JsonValue(64)
  videoProfileLandscape1080p5,

  @JsonValue(66)
  videoProfileLandscape1440p,

  @JsonValue(67)
  videoProfileLandscape1440p2,

  @JsonValue(70)
  videoProfileLandscape4k,

  @JsonValue(72)
  videoProfileLandscape4k3,

  @JsonValue(1000)
  videoProfilePortrait120p,

  @JsonValue(1002)
  videoProfilePortrait120p3,

  @JsonValue(1010)
  videoProfilePortrait180p,

  @JsonValue(1012)
  videoProfilePortrait180p3,

  @JsonValue(1013)
  videoProfilePortrait180p4,

  @JsonValue(1020)
  videoProfilePortrait240p,

  @JsonValue(1022)
  videoProfilePortrait240p3,

  @JsonValue(1023)
  videoProfilePortrait240p4,

  @JsonValue(1030)
  videoProfilePortrait360p,

  @JsonValue(1032)
  videoProfilePortrait360p3,

  @JsonValue(1033)
  videoProfilePortrait360p4,

  @JsonValue(1035)
  videoProfilePortrait360p6,

  @JsonValue(1036)
  videoProfilePortrait360p7,

  @JsonValue(1037)
  videoProfilePortrait360p8,

  @JsonValue(1038)
  videoProfilePortrait360p9,

  @JsonValue(1039)
  videoProfilePortrait360p10,

  @JsonValue(1100)
  videoProfilePortrait360p11,

  @JsonValue(1040)
  videoProfilePortrait480p,

  @JsonValue(1042)
  videoProfilePortrait480p3,

  @JsonValue(1043)
  videoProfilePortrait480p4,

  @JsonValue(1045)
  videoProfilePortrait480p6,

  @JsonValue(1047)
  videoProfilePortrait480p8,

  @JsonValue(1048)
  videoProfilePortrait480p9,

  @JsonValue(1049)
  videoProfilePortrait480p10,

  @JsonValue(1050)
  videoProfilePortrait720p,

  @JsonValue(1052)
  videoProfilePortrait720p3,

  @JsonValue(1054)
  videoProfilePortrait720p5,

  @JsonValue(1055)
  videoProfilePortrait720p6,

  @JsonValue(1060)
  videoProfilePortrait1080p,

  @JsonValue(1062)
  videoProfilePortrait1080p3,

  @JsonValue(1064)
  videoProfilePortrait1080p5,

  @JsonValue(1066)
  videoProfilePortrait1440p,

  @JsonValue(1067)
  videoProfilePortrait1440p2,

  @JsonValue(1070)
  videoProfilePortrait4k,

  @JsonValue(1072)
  videoProfilePortrait4k3,

  @JsonValue(30)
  videoProfileDefault,
}

/// Extensions functions of [VideoProfileType].
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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SDKBuildInfo {
  const SDKBuildInfo({this.build, this.version});

  @JsonKey(name: 'build')
  final int? build;

  @JsonKey(name: 'version')
  final String? version;
  factory SDKBuildInfo.fromJson(Map<String, dynamic> json) =>
      _$SDKBuildInfoFromJson(json);
  Map<String, dynamic> toJson() => _$SDKBuildInfoToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoDeviceInfo {
  const VideoDeviceInfo({this.deviceId, this.deviceName});

  @JsonKey(name: 'deviceId')
  final String? deviceId;

  @JsonKey(name: 'deviceName')
  final String? deviceName;
  factory VideoDeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$VideoDeviceInfoFromJson(json);
  Map<String, dynamic> toJson() => _$VideoDeviceInfoToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioDeviceInfo {
  const AudioDeviceInfo({this.deviceId, this.deviceName});

  @JsonKey(name: 'deviceId')
  final String? deviceId;

  @JsonKey(name: 'deviceName')
  final String? deviceName;
  factory AudioDeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$AudioDeviceInfoFromJson(json);
  Map<String, dynamic> toJson() => _$AudioDeviceInfoToJson(this);
}
