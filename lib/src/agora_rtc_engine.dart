import 'package:agora_rtc_ng/src/binding_forward_export.dart';
part 'agora_rtc_engine.g.dart';

/// Media device types.
@JsonEnum(alwaysCreate: true)
enum MediaDeviceType {
  /// -1: Unknown device type.
  @JsonValue(-1)
  unknownAudioDevice,

  /// 0: Audio playback device.
  @JsonValue(0)
  audioPlayoutDevice,

  /// 1: Audio capturing device.
  @JsonValue(1)
  audioRecordingDevice,

  /// 2: Video renderer.
  @JsonValue(2)
  videoRenderDevice,

  /// 3: Video capturer.
  @JsonValue(3)
  videoCaptureDevice,

  /// @nodoc
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

/// The playback state of the music file.
@JsonEnum(alwaysCreate: true)
enum AudioMixingStateType {
  /// 710: The music file is playing.
  @JsonValue(710)
  audioMixingStatePlaying,

  /// 711: The music file pauses playing.
  @JsonValue(711)
  audioMixingStatePaused,

  /// 713: The music file stops playing.
  @JsonValue(713)
  audioMixingStateStopped,

  /// 714: An error occurs during the playback of the audio mixing file.
  @JsonValue(714)
  audioMixingStateFailed,

  /// @nodoc
  @JsonValue(715)
  audioMixingStateCompleted,

  /// @nodoc
  @JsonValue(716)
  audioMixingStateAllLoopsCompleted,
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

/// Errors that may occur when playing a music file.
@JsonEnum(alwaysCreate: true)
enum AudioMixingErrorType {
  /// The SDK cannot open the music file.
  @JsonValue(701)
  audioMixingErrorCanNotOpen,

  /// The SDK opens the music file too frequently.
  @JsonValue(702)
  audioMixingErrorTooFrequentCall,

  /// The playback of the music file is interrupted.
  @JsonValue(703)
  audioMixingErrorInterruptedEof,

  /// 710: The music file is playing.
  @JsonValue(0)
  audioMixingErrorOk,
}

/// Extensions functions of [AudioMixingErrorType].
extension AudioMixingErrorTypeExt on AudioMixingErrorType {
  /// @nodoc
  static AudioMixingErrorType fromValue(int value) {
    return $enumDecode(_$AudioMixingErrorTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$AudioMixingErrorTypeEnumMap[this]!;
  }
}

/// States of importing an external video stream in the interactive live streaming.
@JsonEnum(alwaysCreate: true)
enum InjectStreamStatus {
  /// 0: The external video stream is imported successfully.
  @JsonValue(0)
  injectStreamStatusStartSuccess,

  /// 1: The external video stream already exists.
  @JsonValue(1)
  injectStreamStatusStartAlreadyExists,

  /// 2: The external video stream to be imported is unauthorized.
  @JsonValue(2)
  injectStreamStatusStartUnauthorized,

  /// 3: A timeout occurs when importing the external video stream.
  @JsonValue(3)
  injectStreamStatusStartTimedout,

  /// 4: The SDK fails to import the external video stream.
  @JsonValue(4)
  injectStreamStatusStartFailed,

  /// 5: The SDK successfully stops importing the external video stream.
  @JsonValue(5)
  injectStreamStatusStopSuccess,

  /// 6: The external video stream to be stopped importing is not found.
  @JsonValue(6)
  injectStreamStatusStopNotFound,

  /// 7: The external video stream to be stopped importing is unauthorized.
  @JsonValue(7)
  injectStreamStatusStopUnauthorized,

  /// 8: A timeout occurs when stopping importing the external video stream.
  @JsonValue(8)
  injectStreamStatusStopTimedout,

  /// 9: The SDK fails to stop importing the external video stream.
  @JsonValue(9)
  injectStreamStatusStopFailed,

  /// 10: The external video stream is corrupted.
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

/// The midrange frequency for audio equalization.
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

/// Audio reverberation types.
@JsonEnum(alwaysCreate: true)
enum AudioReverbType {
  /// 0: The level of the dry signal (dB). The value is between -20 and 10.
  @JsonValue(0)
  audioReverbDryLevel,

  /// 1: The level of the early reflection signal (wet signal) (dB). The value is between -20 and 10.
  @JsonValue(1)
  audioReverbWetLevel,

  /// 2: The room size of the reflection. The value is between 0 and 100.
  @JsonValue(2)
  audioReverbRoomSize,

  /// 3: The length of the initial delay of the wet signal (ms). The value is between 0 and 200.
  @JsonValue(3)
  audioReverbWetDelay,

  /// 4: The reverberation strength. The value is between 0 and 100.
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

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum StreamFallbackOptions {
  /// /// @nodoc
  @JsonValue(0)
  streamFallbackOptionDisabled,

  /// /// @nodoc
  @JsonValue(1)
  streamFallbackOptionVideoStreamLow,

  /// /// @nodoc
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

/// The statistics of the local video stream.
@JsonSerializable(explicitToJson: true)
class LocalVideoStats {
  /// Construct the [LocalVideoStats].
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
      this.txPacketLossRate});

  /// The ID of the local user.
  @JsonKey(name: 'uid')
  final int? uid;

  /// The actual bitrate (Kbps) while sending the local video stream.This value does not include the bitrate for resending the video after packet loss.
  @JsonKey(name: 'sentBitrate')
  final int? sentBitrate;

  /// The actual frame rate (fps) while sending the local video stream.This value does not include the frame rate for resending the video after packet loss.
  @JsonKey(name: 'sentFrameRate')
  final int? sentFrameRate;

  /// The frame rate (fps) for capturing the local video stream.
  @JsonKey(name: 'captureFrameRate')
  final int? captureFrameRate;

  /// @nodoc
  @JsonKey(name: 'captureFrameWidth')
  final int? captureFrameWidth;

  /// @nodoc
  @JsonKey(name: 'captureFrameHeight')
  final int? captureFrameHeight;

  /// @nodoc
  @JsonKey(name: 'regulatedCaptureFrameRate')
  final int? regulatedCaptureFrameRate;

  /// @nodoc
  @JsonKey(name: 'regulatedCaptureFrameWidth')
  final int? regulatedCaptureFrameWidth;

  /// @nodoc
  @JsonKey(name: 'regulatedCaptureFrameHeight')
  final int? regulatedCaptureFrameHeight;

  /// The output frame rate (fps) of the local video encoder.
  @JsonKey(name: 'encoderOutputFrameRate')
  final int? encoderOutputFrameRate;

  /// The width of the encoded video (px).
  @JsonKey(name: 'encodedFrameWidth')
  final int? encodedFrameWidth;

  /// The height of the encoded video (px).
  @JsonKey(name: 'encodedFrameHeight')
  final int? encodedFrameHeight;

  /// The output frame rate (fps) of the local video renderer.
  @JsonKey(name: 'rendererOutputFrameRate')
  final int? rendererOutputFrameRate;

  /// The target bitrate (Kbps) of the current encoder. This is an estimate made by the SDK based on the current network conditions.
  @JsonKey(name: 'targetBitrate')
  final int? targetBitrate;

  /// The target frame rate (fps) of the current encoder.
  @JsonKey(name: 'targetFrameRate')
  final int? targetFrameRate;

  /// Quality adaption of the local video stream in the reported interval (based on the target frame rate and target bitrate). See QualityAdaptIndication .
  @JsonKey(name: 'qualityAdaptIndication')
  final QualityAdaptIndication? qualityAdaptIndication;

  /// The bitrate (Kbps) while encoding the local video stream.This value does not include the bitrate for resending the video after packet loss.
  @JsonKey(name: 'encodedBitrate')
  final int? encodedBitrate;

  /// The number of the sent video frames, represented by an aggregate value.
  @JsonKey(name: 'encodedFrameCount')
  final int? encodedFrameCount;

  /// The codec type of the local video. See VideoCodecType .
  @JsonKey(name: 'codecType')
  final VideoCodecType? codecType;

  /// The video packet loss rate (%) from the local client to the Agora server before applying the anti-packet loss strategies.
  @JsonKey(name: 'txPacketLossRate')
  final int? txPacketLossRate;

  /// @nodoc
  factory LocalVideoStats.fromJson(Map<String, dynamic> json) =>
      _$LocalVideoStatsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LocalVideoStatsToJson(this);
}

/// The statistics of the remote video stream.
@JsonSerializable(explicitToJson: true)
class RemoteVideoStats {
  /// Construct the [RemoteVideoStats].
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

  /// The ID of the remote user sending the video stream.
  @JsonKey(name: 'uid')
  final int? uid;

  ///  Deprecated:
  /// In scenarios where audio and video are synchronized, you can get the video delay datafrom networkTransportDelay and jitterBufferDelay in RemoteAudioStats . Delay (ms).
  @JsonKey(name: 'delay')
  final int? delay;

  /// Width (pixels) of the video stream.
  @JsonKey(name: 'width')
  final int? width;

  /// Height (pixels) of the video stream.
  @JsonKey(name: 'height')
  final int? height;

  /// Bitrate (Kbps) received since the last count.
  @JsonKey(name: 'receivedBitrate')
  final int? receivedBitrate;

  /// The decoder output frame rate (fps) of the remote video.
  @JsonKey(name: 'decoderOutputFrameRate')
  final int? decoderOutputFrameRate;

  /// The render output frame rate (fps) of the remote video.
  @JsonKey(name: 'rendererOutputFrameRate')
  final int? rendererOutputFrameRate;

  /// Remote video packet loss rate (%).
  @JsonKey(name: 'frameLossRate')
  final int? frameLossRate;

  /// Packet loss rate (%) of the remote video stream after using the anti-packet-loss method.
  @JsonKey(name: 'packetLossRate')
  final int? packetLossRate;

  /// The type of the remote video stream. See VideoStreamType .
  @JsonKey(name: 'rxStreamType')
  final VideoStreamType? rxStreamType;

  /// The total freeze time (ms) of the remote video stream after the remote user joins the channel. In a video session where the frame rate is set to no less than 5 fps, video freeze occurs when the time interval between two adjacent renderable video frames is more than 500 ms.
  @JsonKey(name: 'totalFrozenTime')
  final int? totalFrozenTime;

  /// The total video freeze time as a percentage (%) of the total time when the video is available. The video is considered available when the remote user neither stops sending the audio stream nor disables the audio module after joining the channel.
  @JsonKey(name: 'frozenRate')
  final int? frozenRate;

  /// The amount of time (ms) that the audio is ahead of the video.If this value is negative, the audio is lagging behind the video.
  @JsonKey(name: 'avSyncTimeMs')
  final int? avSyncTimeMs;

  /// The total freeze time (ms) of the remote video stream after the remote user joins the channel.
  /// The total effective duration of the video is the duration of the call after the remote user or host joins the channel and neither stops sending the video stream nor disables the video module.
  @JsonKey(name: 'totalActiveTime')
  final int? totalActiveTime;

  /// The total duration (ms) of the remote video stream.
  @JsonKey(name: 'publishDuration')
  final int? publishDuration;

  /// The state of super resolution:
  /// >0: Super resolution is enabled.
  /// =0: Super resolution is not enabled.
  @JsonKey(name: 'superResolutionType')
  final int? superResolutionType;

  /// @nodoc
  factory RemoteVideoStats.fromJson(Map<String, dynamic> json) =>
      _$RemoteVideoStatsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RemoteVideoStatsToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true)
class VideoCompositingLayout {
  /// Construct the [VideoCompositingLayout].
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
@JsonSerializable(explicitToJson: true)
class Region {
  /// Construct the [Region].
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

/// Configurations of injecting an external audio or video stream.
@JsonSerializable(explicitToJson: true)
class InjectStreamConfig {
  /// Construct the [InjectStreamConfig].
  const InjectStreamConfig(
      {this.width,
      this.height,
      this.videoGop,
      this.videoFramerate,
      this.videoBitrate,
      this.audioSampleRate,
      this.audioBitrate,
      this.audioChannels});

  /// The width of the external video stream after injecting. The default value is 0, which represents the same width as the original.
  @JsonKey(name: 'width')
  final int? width;

  /// The height of the external video stream after injecting. The default value is 0, which represents the same height as the original.
  @JsonKey(name: 'height')
  final int? height;

  /// The GOP (in frames) of injecting the external video stream. The default value is 30.
  @JsonKey(name: 'videoGop')
  final int? videoGop;

  /// @nodoc
  @JsonKey(name: 'videoFramerate')
  final int? videoFramerate;

  /// The bitrate (Kbps) of injecting the external video stream. The default value is 400 Kbps.
  /// The bitrate setting is closely linked to the video resolution. If the bitrate you set is beyond a reasonable range, the SDK sets it within a reasonable range.
  @JsonKey(name: 'videoBitrate')
  final int? videoBitrate;

  /// The sampling rate (Hz) of injecting the external audio stream. The default value is 48000 Hz. See AudioSampleRateType .
  /// Agora recommends using the default value.
  @JsonKey(name: 'audioSampleRate')
  final AudioSampleRateType? audioSampleRate;

  /// The bitrate (Kbps) of injecting the external audio stream. The default value is 48 Kbps.
  /// Agora recommends using the default value.
  @JsonKey(name: 'audioBitrate')
  final int? audioBitrate;

  /// The number of channels of the external audio stream after injecting.
  /// 1: (Default) Mono.
  /// 2: Stereo. Agora recommends using the default value.
  @JsonKey(name: 'audioChannels')
  final int? audioChannels;

  /// @nodoc
  factory InjectStreamConfig.fromJson(Map<String, dynamic> json) =>
      _$InjectStreamConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$InjectStreamConfigToJson(this);
}

/// Lifecycle of the CDN live video stream.
/// Deprecated
@JsonEnum(alwaysCreate: true)
enum RtmpStreamLifeCycleType {
  /// Bind to the channel lifecycle. If all hosts leave the channel, the CDN live streaming stops after 30 seconds.
  @JsonValue(1)
  rtmpStreamLifeCycleBind2channel,

  /// Bind to the owner of the RTMP stream. If the owner leaves the channel, the CDN live streaming stops immediately.
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

/// @nodoc
@JsonSerializable(explicitToJson: true)
class PublisherConfiguration {
  /// Construct the [PublisherConfiguration].
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
@JsonSerializable(explicitToJson: true)
class AudioTrackConfig {
  /// Construct the [AudioTrackConfig].
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

/// The camera direction.
@JsonEnum(alwaysCreate: true)
enum CameraDirection {
  /// The rear camera.
  @JsonValue(0)
  cameraRear,

  /// The front camera.
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

/// The cloud proxy type.
@JsonEnum(alwaysCreate: true)
enum CloudProxyType {
  /// 0: The automatic mode. In this mode, the SDK attempts a direct connection to SD-RTN™ and automatically switches to TCP/TLS 443 if the attempt fails.
  @JsonValue(0)
  noneProxy,

  /// 1: The cloud proxy for the UDP protocol, that is, the Force UDP cloud proxy mode. In this mode, the SDK always transmits data over UDP.
  @JsonValue(1)
  udpProxy,

  /// 2: The cloud proxy for the TCP (encryption) protocol, that is, the Force TCP cloud proxy mode. In this mode, the SDK always transmits data over TCP/TLS 443.
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

/// The camera capturer preference.
@JsonSerializable(explicitToJson: true)
class CameraCapturerConfiguration {
  /// Construct the [CameraCapturerConfiguration].
  const CameraCapturerConfiguration(
      {this.cameraDirection, this.deviceId, this.format});

  /// This parameter applies to Android and iOS only.The camera direction.  CameraDirection
  @JsonKey(name: 'cameraDirection')
  final CameraDirection? cameraDirection;

  /// The device ID of the playback device. The maximum length is MaxDeviceIdLengthType .
  @JsonKey(name: 'deviceId')
  final String? deviceId;

  /// See VideoFormat .
  @JsonKey(name: 'format')
  final VideoFormat? format;

  /// @nodoc
  factory CameraCapturerConfiguration.fromJson(Map<String, dynamic> json) =>
      _$CameraCapturerConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$CameraCapturerConfigurationToJson(this);
}

/// The configuration of the captured screen.
@JsonSerializable(explicitToJson: true)
class ScreenCaptureConfiguration {
  /// Construct the [ScreenCaptureConfiguration].
  const ScreenCaptureConfiguration(
      {this.isCaptureWindow,
      this.displayId,
      this.screenRect,
      this.windowId,
      this.params,
      this.regionRect});

  /// Whether to capture the window on the screen:
  /// true: Capture the window.
  /// false: (Default) Capture the screen, not the window.
  @JsonKey(name: 'isCaptureWindow')
  final bool? isCaptureWindow;

  /// (macOS only) The display ID of the screen.This parameter takes effect only when you want to capture the screen on macOS.
  @JsonKey(name: 'displayId')
  final int? displayId;

  /// (Windows only) The relative position of the shared screen to the virtual screen.This parameter takes effect only when you want to capture the screen on Windows.
  @JsonKey(name: 'screenRect')
  final Rectangle? screenRect;

  /// (For Windows and macOS only) Window ID.This parameter takes effect only when you want to capture the window.
  @JsonKey(name: 'windowId')
  final int? windowId;

  /// (For Windows and macOS only) The screen capture configuration. See ScreenCaptureParameters .
  @JsonKey(name: 'params')
  final ScreenCaptureParameters? params;

  /// (For Windows and macOS only) The relative position of the shared region to the whole screen. See Rectangle .
  /// If you do not set this parameter, the SDK shares the whole screen. If the region you set exceeds the boundary of the screen, only the region within in the screen is shared. If you setwidth or height in Rectangle as 0, the whole screen is shared.
  @JsonKey(name: 'regionRect')
  final Rectangle? regionRect;

  /// @nodoc
  factory ScreenCaptureConfiguration.fromJson(Map<String, dynamic> json) =>
      _$ScreenCaptureConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ScreenCaptureConfigurationToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true)
class AudioOptionsExternal {
  /// Construct the [AudioOptionsExternal].
  const AudioOptionsExternal(
      {this.enableAecExternalCustom,
      this.enableAgcExternalCustom,
      this.enableAnsExternalCustom,
      this.aecAggressivenessExternalCustom,
      this.enableAecExternalLoopback});

  /// @nodoc
  @JsonKey(name: 'enable_aec_external_custom_')
  final bool? enableAecExternalCustom;

  /// @nodoc
  @JsonKey(name: 'enable_agc_external_custom_')
  final bool? enableAgcExternalCustom;

  /// @nodoc
  @JsonKey(name: 'enable_ans_external_custom_')
  final bool? enableAnsExternalCustom;

  /// @nodoc
  @JsonKey(name: 'aec_aggressiveness_external_custom_')
  final NlpAggressiveness? aecAggressivenessExternalCustom;

  /// @nodoc
  @JsonKey(name: 'enable_aec_external_loopback_')
  final bool? enableAecExternalLoopback;

  /// @nodoc
  factory AudioOptionsExternal.fromJson(Map<String, dynamic> json) =>
      _$AudioOptionsExternalFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AudioOptionsExternalToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true)
class Size {
  /// Construct the [Size].
  const Size({this.width, this.height});

  /// /// @nodoc
  @JsonKey(name: 'width')
  final int? width;

  /// /// @nodoc
  @JsonKey(name: 'height')
  final int? height;

  /// @nodoc
  factory Size.fromJson(Map<String, dynamic> json) => _$SizeFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$SizeToJson(this);
}

/// The image content of the thumbnail or icon. Set in ScreenCaptureSourceInfo .
/// The default image is in the RGBA format. If you need to use another format, you need to convert the image on your own.
@JsonSerializable(explicitToJson: true)
class ThumbImageBuffer {
  /// Construct the [ThumbImageBuffer].
  const ThumbImageBuffer({this.buffer, this.length, this.width, this.height});

  /// The buffer of the thumbnail ot icon.
  @JsonKey(name: 'buffer', ignore: true)
  final Uint8List? buffer;

  /// The buffer length of the thumbnail or icon, in bytes.
  @JsonKey(name: 'length')
  final int? length;

  /// The actual width (px) of the thumbnail or icon.
  @JsonKey(name: 'width')
  final int? width;

  /// The actual height (px) of the thumbnail or icon.
  @JsonKey(name: 'height')
  final int? height;

  /// @nodoc
  factory ThumbImageBuffer.fromJson(Map<String, dynamic> json) =>
      _$ThumbImageBufferFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ThumbImageBufferToJson(this);
}

/// The type of the shared target. Set in ScreenCaptureSourceInfo .
@JsonEnum(alwaysCreate: true)
enum ScreenCaptureSourceType {
  /// -1: Unknown type.
  @JsonValue(-1)
  screencapturesourcetypeUnknown,

  /// 0: The shared target is a window.
  @JsonValue(0)
  screencapturesourcetypeWindow,

  /// 1: The share target is the screen of a particular monitor.
  @JsonValue(1)
  screencapturesourcetypeScreen,

  /// 6: Reserved parameter
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

/// The information about the specified shareable window or screen.
@JsonSerializable(explicitToJson: true)
class ScreenCaptureSourceInfo {
  /// Construct the [ScreenCaptureSourceInfo].
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

  /// The type of the shared target. See ScreenCaptureSourceType .
  @JsonKey(name: 'type')
  final ScreenCaptureSourceType? type;

  /// The window ID for a window or the display ID for a screen.
  @JsonKey(name: 'sourceId')
  final int? sourceId;

  /// The name of the window or screen. UTF-8 encoding.
  @JsonKey(name: 'sourceName')
  final String? sourceName;

  /// The image content of the thumbnail. See ThumbImageBuffer .
  @JsonKey(name: 'thumbImage')
  final ThumbImageBuffer? thumbImage;

  /// The image content of the icon. See ThumbImageBuffer .
  @JsonKey(name: 'iconImage')
  final ThumbImageBuffer? iconImage;

  /// The process to which the window belongs. UTF-8 encoding.
  @JsonKey(name: 'processPath')
  final String? processPath;

  /// The title of the window. UTF-8 encoding.
  @JsonKey(name: 'sourceTitle')
  final String? sourceTitle;

  /// Determines whether the screen is the primary display:
  /// true: The screen is the primary display.
  /// false: The screen is not the primary display.
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

/// The channel media options.
/// Agora supports publishing multiple audio streams and one video stream at the same time and in the same RtcConnection . For example, publishAudioTrack, publishCustomAudioTrack and publishMediaPlayerAudioTrack can be true at the same time; but only one of publishCameraTrack, publishScreenTrack, publishCustomVideoTrack, and publishEncodedVideoTrack can be true at the same time.
@JsonSerializable(explicitToJson: true)
class ChannelMediaOptions {
  /// Construct the [ChannelMediaOptions].
  const ChannelMediaOptions(
      {this.publishCameraTrack,
      this.publishSecondaryCameraTrack,
      this.publishAudioTrack,
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
      this.startPreview,
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
      this.audioOptionsExternal});

  /// Whether to publish the video captured by the camera:
  /// true: (Default) Publish the video captured by the camera.
  /// false: Do not publish the video captured by the camera.
  @JsonKey(name: 'publishCameraTrack')
  final bool? publishCameraTrack;

  /// Whether to publish the video captured by the second camera:
  /// true: (Default) Publish the video captured by the second camera.
  /// false: Do not publish the video captured by the second camera.
  @JsonKey(name: 'publishSecondaryCameraTrack')
  final bool? publishSecondaryCameraTrack;

  /// Whether to publish the captured audio:
  /// true: (Default) Publish the captured audio.
  /// false: Do not publish the captured audio.
  @JsonKey(name: 'publishAudioTrack')
  final bool? publishAudioTrack;

  /// Whether to publish the captured video from the screen:
  /// true: Publish the captured video from the screen.
  /// false: (Default) Do not publish the captured video from the screen.
  @JsonKey(name: 'publishScreenTrack')
  final bool? publishScreenTrack;

  /// Whether to publish the captured video from the secondary screen:
  /// true: Publish the captured video from the second screen.
  /// false: (Default) Do not publish the captured video from the second screen.
  @JsonKey(name: 'publishSecondaryScreenTrack')
  final bool? publishSecondaryScreenTrack;

  /// Whether to publish the captured audio from a custom source:
  /// true: Publish the captured audio from a custom source.
  /// false: (Default) Do not publish the captured audio from the custom source.
  @JsonKey(name: 'publishCustomAudioTrack')
  final bool? publishCustomAudioTrack;

  /// The ID of the custom audio source to publish. The default value is 0.
  @JsonKey(name: 'publishCustomAudioSourceId')
  final int? publishCustomAudioSourceId;

  /// Whether to enable AEC when publishing the captured audio from a custom source:
  /// true Enable AEC when publishing the captured audio from a custom source.
  /// false : (Default) Do not enable AEC when publishing the captured audio from a custom source.
  @JsonKey(name: 'publishCustomAudioTrackEnableAec')
  final bool? publishCustomAudioTrackEnableAec;

  /// @nodoc
  @JsonKey(name: 'publishDirectCustomAudioTrack')
  final bool? publishDirectCustomAudioTrack;

  /// @nodoc
  @JsonKey(name: 'publishCustomAudioTrackAec')
  final bool? publishCustomAudioTrackAec;

  /// Whether to publish the captured video from a custom source:
  /// true: Publish the captured video from a custom source.
  /// false: (Default) Do not publish the captured video from the custom source.
  @JsonKey(name: 'publishCustomVideoTrack')
  final bool? publishCustomVideoTrack;

  /// Whether to publish the encoded video:
  /// true: Publish the encoded video.
  /// false: (Default) Do not publish the encoded video.
  @JsonKey(name: 'publishEncodedVideoTrack')
  final bool? publishEncodedVideoTrack;

  /// Whether to publish the audio from the media player:
  /// true: Publish the audio from the media player.
  /// false: (Default) Do not publish the audio from the media player.
  @JsonKey(name: 'publishMediaPlayerAudioTrack')
  final bool? publishMediaPlayerAudioTrack;

  /// Whether to publish the video from the media player:
  /// true: Publish the video from the media player.
  /// false: (Default) Do not publish the video from the media player.
  @JsonKey(name: 'publishMediaPlayerVideoTrack')
  final bool? publishMediaPlayerVideoTrack;

  /// Whether to publish the local transcoded video.
  /// true: Publish the local transcoded video.
  /// false: (Default) Do not publish the local transcoded video.
  @JsonKey(name: 'publishTrancodedVideoTrack')
  final bool? publishTrancodedVideoTrack;

  /// Whether to automatically subscribe to all remote audio streams when the user joins a channel:
  /// true: (Default) Subscribe to all remote audio streams.
  /// false: Do not subscribe to any remote audio stream.
  @JsonKey(name: 'autoSubscribeAudio')
  final bool? autoSubscribeAudio;

  /// Whether to subscribe to all remote video streams when the user joins the channel:
  /// true: (Default) Subscribe to all remote video streams.
  /// false: Do not subscribe to any remote video stream.
  @JsonKey(name: 'autoSubscribeVideo')
  final bool? autoSubscribeVideo;

  /// @nodoc
  @JsonKey(name: 'startPreview')
  final bool? startPreview;

  /// Whether to enable audio capturing or playback.
  /// true: (Default) Enable audio capturing and playback.
  /// false Do not enable audio capturing or playback.
  @JsonKey(name: 'enableAudioRecordingOrPlayout')
  final bool? enableAudioRecordingOrPlayout;

  /// The ID of the media player to be published. The default value is 0.
  @JsonKey(name: 'publishMediaPlayerId')
  final int? publishMediaPlayerId;

  ///
  @JsonKey(name: 'clientRoleType')
  final ClientRoleType? clientRoleType;

  /// @nodoc
  @JsonKey(name: 'audienceLatencyLevel')
  final AudienceLatencyLevelType? audienceLatencyLevel;

  /// The default video-stream type, see VideoStreamType .
  @JsonKey(name: 'defaultVideoStreamType')
  final VideoStreamType? defaultVideoStreamType;

  /// The channel profile. See ChannelProfileType .
  @JsonKey(name: 'channelProfile')
  final ChannelProfileType? channelProfile;

  /// The delay in ms for sending audio frames. This is used for explicit control of A/V sync.
  /// To switch off the delay, set the value to 0.
  @JsonKey(name: 'audioDelayMs')
  final int? audioDelayMs;

  /// @nodoc
  @JsonKey(name: 'mediaPlayerAudioDelayMs')
  final int? mediaPlayerAudioDelayMs;

  /// (Optional) The token generated on your server for authentication. This parameter takes effect only when calling updateChannelMediaOptions or updateChannelMediaOptionsEx .
  /// Ensure that the App ID, channel name, and user name used for creating the token are the same ones as those used by the initialize method for initializing the RTC engine, and those used by the joinChannelWithOptions and joinChannelEx methods for joining the channel.
  @JsonKey(name: 'token')
  final String? token;

  /// @nodoc
  @JsonKey(name: 'enableBuiltInMediaEncryption')
  final bool? enableBuiltInMediaEncryption;

  /// @nodoc
  @JsonKey(name: 'publishRhythmPlayerTrack')
  final bool? publishRhythmPlayerTrack;

  /// @nodoc
  @JsonKey(name: 'audioOptionsExternal')
  final AudioOptionsExternal? audioOptionsExternal;

  /// @nodoc
  factory ChannelMediaOptions.fromJson(Map<String, dynamic> json) =>
      _$ChannelMediaOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ChannelMediaOptionsToJson(this);
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum LocalProxyMode {
  /// @nodoc
  @JsonValue(0)
  kConnectivityFirst,

  /// @nodoc
  @JsonValue(1)
  kLocalOnly,
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

/// @nodoc
@JsonSerializable(explicitToJson: true)
class LocalAccessPointConfiguration {
  /// Construct the [LocalAccessPointConfiguration].
  const LocalAccessPointConfiguration(
      {this.ipList,
      this.ipListSize,
      this.domainList,
      this.domainListSize,
      this.verifyDomainName,
      this.mode});

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
  factory LocalAccessPointConfiguration.fromJson(Map<String, dynamic> json) =>
      _$LocalAccessPointConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LocalAccessPointConfigurationToJson(this);
}

/// The options for leaving a channel.
@JsonSerializable(explicitToJson: true)
class LeaveChannelOptions {
  /// Construct the [LeaveChannelOptions].
  const LeaveChannelOptions(
      {this.stopAudioMixing, this.stopAllEffect, this.stopMicrophoneRecording});

  /// Whether to stop playing and mixing the music file when a user leaves the channel. true: (Default) Stop playing and mixing the music file.
  /// false: Do not stop playing and mixing the music file.
  @JsonKey(name: 'stopAudioMixing')
  final bool? stopAudioMixing;

  /// Whether to stop playing all audio effects when a user leaves the channel. true: (Default) Stop playing all audio effects.
  /// false: Do not stop playing any audio effect.
  @JsonKey(name: 'stopAllEffect')
  final bool? stopAllEffect;

  /// Whether to stop microphone recording when a user leaves the channel. true: (Default) Stop microphone recording.
  /// false: Do not stop microphone recording.
  @JsonKey(name: 'stopMicrophoneRecording')
  final bool? stopMicrophoneRecording;

  /// @nodoc
  factory LeaveChannelOptions.fromJson(Map<String, dynamic> json) =>
      _$LeaveChannelOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LeaveChannelOptionsToJson(this);
}

/// The SDK uses the RtcEngineEventHandler interface to send event notifications to your app. Your app can get those notifications through methods that inherit this interface.
class RtcEngineEventHandler {
  /// Construct the [RtcEngineEventHandler].
  const RtcEngineEventHandler({
    this.onJoinChannelSuccess,
    this.onRejoinChannelSuccess,
    this.onWarning,
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
    this.onVideoSourceFrameSizeChanged,
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
    this.onStreamPublished,
    this.onStreamUnpublished,
    this.onTranscodingUpdated,
    this.onAudioRoutingChanged,
    this.onChannelMediaRelayStateChanged,
    this.onChannelMediaRelayEvent,
    this.onLocalPublishFallbackToAudioOnly,
    this.onRemoteSubscribeFallbackToAudioOnly,
    this.onRemoteAudioTransportStats,
    this.onRemoteVideoTransportStats,
    this.onConnectionStateChanged,
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
    this.onExtensionErrored,
    this.onUserAccountUpdated,
  });

  /// Occurs when a user joins a channel.
  /// This callback notifies the application that a user joins a specified channel.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [elapsed] The time elapsed (ms) from the local user calling joinChannelWithOptions until the SDK triggers this callback.None
  final void Function(RtcConnection connection, int elapsed)?
      onJoinChannelSuccess;

  /// Occurs when a user rejoins the channel.
  /// When a user loses connection with the server because of network problems, the SDK automatically tries to reconnect and triggers this callback upon reconnection.
  ///
  /// * [elapsed] The time elapsed (ms) from the local user trying to rejoin the channel until the SDK triggers this callback.None
  final void Function(RtcConnection connection, int elapsed)?
      onRejoinChannelSuccess;

  /// /// @nodoc
  final void Function(WarnCodeType warn, String msg)? onWarning;

  /// /// @nodoc
  final void Function(ErrorCodeType err, String msg)? onError;

  /// Reports the statistics of the audio stream from each remote user.
  /// Deprecated:
  /// Please use onRemoteAudioStats instead.
  /// The SDK triggers this callback once every two seconds to report the audio quality of each remote user/host sending an audio stream. If a channel has multiple users/hosts sending audio streams, the SDK triggers this callback as many times.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [remoteUid] The user ID of the remote user sending the audio stream.None
  ///
  /// * [quality] Audio quality of the user. See QualityType .None
  ///
  /// * [delay] The network delay (ms) from the sender to the receiver, including the delay caused by audio sampling pre-processing, network transmission, and network jitter buffering.None
  ///
  /// * [lost] The packet loss rate (%) of the audio packet sent from the remote user.None
  final void Function(RtcConnection connection, int remoteUid,
      QualityType quality, int delay, int lost)? onAudioQuality;

  /// Reports the last mile network probe result.
  /// The SDK triggers this callback within 30 seconds after the app calls startLastmileProbeTest .
  ///
  /// * [result] The uplink and downlink last-mile network probe test result. See LastmileProbeResult .None
  final void Function(LastmileProbeResult result)? onLastmileProbeResult;

  /// Reports the volume information of users.
  /// By default, this callback is disabled. You can enable it by calling enableAudioVolumeIndication . Once this callback is enabled and users send streams in the channel, the SDK triggers the onAudioVolumeIndication callback at the time interval set in enableAudioVolumeIndication. The SDK triggers two independent onAudioVolumeIndication callbacks simultaneously, which separately report the volume information of the local user who sends a stream and the remote users (up to three) whose instantaneous volume is the highest.
  /// After you enable this callback, calling muteLocalAudioStream affects the SDK's behavior as follows:
  /// If the local user stops publishing the audio stream, the SDK stops triggering the local user's callback.
  /// 20 seconds after a remote user whose volume is one of the three highest stops publishing the audio stream, the callback excludes this user's information; 20 seconds after all remote users stop publishing audio streams, the SDK stops triggering the callback for remote users.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [speakers] The volume information of the users, see AudioVolumeInfo . Ifan empty speakers array in the callback indicates that no remote user is in the channel or sending a stream at the moment.None
  ///
  /// * [speakerNumber] The total number of users.
  ///  In the local user's callback, when the local user sends a stream, speakerNumber is 1.
  ///  In the callback for remote users, the value range of speakerNumber is [0,3]. If the number of remote users who send streams is greater than or equal to three, the value of speakerNumber is 3. None
  ///
  /// * [totalVolume] The volume of the speaker. The value ranges between 0 (lowest volume) and 255 (highest volume).
  ///  In the callback for the local user, totalVolume is the volume of the local user who sends a stream.
  ///  In the callback for remote users, totalVolume is the sum of the volume of all remote users (up to three) whose instantaneous volume is the highest. None
  final void Function(RtcConnection connection, List<AudioVolumeInfo> speakers,
      int speakerNumber, int totalVolume)? onAudioVolumeIndication;

  /// Occurs when a user leaves a channel.
  /// This callback notifies the app that the user leaves the channel by calling leaveChannel . From this callback, the app can get information such as the call duration and quality statistics.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [stats] The statistics of the call. See RtcStats .None
  final void Function(RtcConnection connection, RtcStats stats)? onLeaveChannel;

  /// Reports the statistics of the current call.
  /// The SDK triggers this callback once every two seconds after the user joins the channel.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [stats] Statistics of the RTC engine. See RtcStats . None
  final void Function(RtcConnection connection, RtcStats stats)? onRtcStats;

  /// Occurs when the audio device state changes.
  /// This callback notifies the application that the system's audio device state is changed. For example, a headset is unplugged from the device.
  /// This method is for Windows and macOS only.
  ///
  /// * [deviceId] The device ID.None
  ///
  /// * [deviceType] The evice type. See MediaDeviceType .None
  ///
  /// * [deviceState] The device state.
  ///  On macOS:
  ///  0: The device is ready for use.
  ///  8: The device is not connected. On Windows: see MediaDeviceStateType .None
  final void Function(String deviceId, MediaDeviceType deviceType,
      MediaDeviceStateType deviceState)? onAudioDeviceStateChanged;

  /// Occurs when the playback of the local music file finishes.
  /// Deprecated:
  /// Please use onAudioMixingStateChanged instead. After you call startAudioMixing to play a local music file, this callback occurs when the playback finishes. If the call startAudioMixing fails, the error code WARN_AUDIO_MIXING_OPEN_ERROR is returned.
  final void Function()? onAudioMixingFinished;

  /// Occurs when the playback of the local music file finishes.
  /// This callback occurs when the local audio effect file finishes playing.
  ///
  /// * [soundId] The audio effect ID. The ID of each audio effect file is unique.None
  final void Function(int soundId)? onAudioEffectFinished;

  /// /// @nodoc
  final void Function(String deviceId, MediaDeviceType deviceType,
      MediaDeviceStateType deviceState)? onVideoDeviceStateChanged;

  /// @nodoc
  final void Function(MediaDeviceType deviceType)? onMediaDeviceChanged;

  /// Reports the last mile network quality of each user in the channel.
  /// This callback reports the last mile network conditions of each user in the channel. Last mile refers to the connection between the local device and Agora's edge server.
  /// The SDK triggers this callback once every two seconds. If a channel includes multiple users, the SDK triggers this callback as many times.
  /// txQuality is rxQuality is
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [remoteUid] The user ID. The network quality of the user with this user ID is reported.None
  ///
  /// * [txQuality] Uplink network quality rating of the user in terms of the transmission bit rate, packet loss rate, average RTT (Round-Trip Time) and jitter of the uplink network. This parameter is a quality rating helping you understand how well the current uplink network conditions can support the selected video encoder configuration. For example, a 1000 Kbps uplink network may be adequate for video frames with a resolution of 640 × 480 and a frame rate of 15 fps in the LIVE_BROADCASTING profile, but may be inadequate for resolutions higher than 1280 × 720. See QualityType .None
  ///
  /// * [rxQuality] Downlink network quality rating of the user in terms of packet loss rate, average RTT, and jitter of the downlink network. See QualityType .None
  final void Function(RtcConnection connection, int remoteUid,
      QualityType txQuality, QualityType rxQuality)? onNetworkQuality;

  /// @nodoc
  final void Function(RtcConnection connection)? onIntraRequestReceived;

  /// Occurs when the uplink network information changes.
  /// The SDK triggers this callback when the uplink network information changes.
  /// This callback only applies to scenarios where you push externally encoded video data in H.264 format to the SDK.
  ///
  /// * [info] The uplink network information. See UplinkNetworkInfo .None
  final void Function(UplinkNetworkInfo info)? onUplinkNetworkInfoUpdated;

  /// @nodoc
  final void Function(DownlinkNetworkInfo info)? onDownlinkNetworkInfoUpdated;

  /// Reports the last-mile network quality of the local user.
  /// This callback reports the last-mile network conditions of the local user before the user joins the channel. Last mile refers to the connection between the local device and Agora's edge server.
  /// Before the user joins the channel, this callback is triggered by the SDK once startLastmileProbeTest is called and reports the last-mile network conditions of the local user.
  ///
  /// * [quality] The last-mile network quality.
  ///  qualityUnknown(0): The quality is unknown.
  ///  qualityExcellent(1): The quality is excellent.
  ///  qualityGood(2): The network quality seems excellent, but the bitrate can be slightly lower than excellent.
  ///  qualityPoor(3): Users can feel the communication is slightly impaired.
  ///  qualityBad(4): Users cannot communicate smoothly.
  ///  qualityVbad(5): The quality is so bad that users can barely communicate.
  ///  qualityDown(6): The network is down, and users cannot communicate at all.
  ///  See QualityType .None
  final void Function(QualityType quality)? onLastmileQuality;

  /// Occurs when the first local video frame is displayed on the local video view.
  /// This callback is triggered when the first local video frame is displayed on the local view.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [width] The width (px) of the first local video frame.None
  ///
  /// * [height] The height (px) of the first local video frame.None
  ///
  /// * [elapsed] The time elapsed (ms) from the local user calling joinChannelWithOptions until the SDK triggers this callback. If you call startPreview before calling joinChannelWithOptions, then this parameter is the time elapsed from calling the startPreview method until the SDK triggers this callback.None
  final void Function(
          RtcConnection connection, int width, int height, int elapsed)?
      onFirstLocalVideoFrame;

  /// Occurs when the first video frame is published.
  /// The SDK triggers this callback under one of the following circumstances:
  /// The local client enables the video module and calls joinChannelWithOptions successfully.
  /// The local client calls muteLocalVideoStream (true) and muteLocalVideoStream(false) in sequence.
  /// The local client calls disableVideo and enableVideo in sequence.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [elapsed] Time elapsed (ms) from the local user calling the joinChannelWithOptions method until this callback is triggered.None
  final void Function(RtcConnection connection, int elapsed)?
      onFirstLocalVideoFramePublished;

  /// @nodoc
  final void Function(RtcConnection connection, VideoSourceType sourceType,
      int width, int height)? onVideoSourceFrameSizeChanged;

  /// Occurs when the first remote video frame is received and decoded.
  /// The SDK triggers this callback under one of the following circumstances:
  /// The remote user joins the channel and sends the video stream.
  /// The remote user stops sending the video stream and re-sends it after 15 seconds. Reasons for such an interruption include:
  /// The remote user leaves the channel.
  /// The remote user drops offline.
  /// The remote user calls muteLocalVideoStream to stop sending the video stream.
  /// The remote user calls disableVideo to disable video.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [remoteUid] The ID of the remote user sending the video stream.None
  ///
  /// * [width] The width (px) of the video stream.None
  ///
  /// * [height] The height (px) of the video stream.None
  ///
  /// * [elapsed] The time elapsed (ms) from the local user calling joinChannelWithOptions until the SDK triggers this callback.None
  final void Function(RtcConnection connection, int remoteUid, int width,
      int height, int elapsed)? onFirstRemoteVideoDecoded;

  /// Occurs when the video size or rotation of a specified user changes.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [uid] The ID of the user whose video size or rotation changes. (The uid for the local user is 0. The video is the local user's video preview).None
  ///
  /// * [width] New width (pixels) of the video.None
  ///
  /// * [height] New height (pixels) of the video.None
  ///
  /// * [rotation] New rotation of the video [0 to 360).None
  final void Function(RtcConnection connection, int uid, int width, int height,
      int rotation)? onVideoSizeChanged;

  /// Occurs when the local video stream state changes.
  /// When the state of the local video stream changes, the SDK triggers this callback to report the current state. This callback indicates the state of the local video stream and allows you to troubleshoot issues when exceptions occur.
  /// The SDK triggers the onLocalVideoStateChanged callback with the state code of localVideoStreamStateFailed and error code of localVideoStreamErrorCaptureFailure in the following situations:
  /// The app switches to the background, and the system gets the camera resource.
  /// The camera starts normally, but does not output vide frames for four consecutive seconds. When the camera outputs the captured video frames, if the video frames are the same for 15 consecutive frames, the SDK triggers the onLocalVideoStateChanged callback with the state code of localVideoStreamStateCapturing and error code of localVideoStreamErrorCaptureFailure. Note that the video frame duplication detection is only available for video frames with a resolution greater than 200 × 200, a frame rate greater than or equal to 10 fps, and a bitrate less than 20 Kbps.
  /// For some device models, the SDK does not trigger this callback when the state of the local video changes while the local video capturing device is in use, so you have to make your own timeout judgment.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [state] The state of the local video. See LocalVideoStreamState .None
  ///
  /// * [errorCode] The detailed error information. See LocalVideoStreamError .None
  final void Function(RtcConnection connection, LocalVideoStreamState state,
      LocalVideoStreamError errorCode)? onLocalVideoStateChanged;

  /// Occurs when the remote video stream state changes.
  /// This callback can be inaccurate when the number of users (in the communication profile) or hosts (in the live broadcasting profile) in a channel exceeds 17.
  ///
  /// * [uid] The ID of the remote user whose video state changes.None
  ///
  /// * [state] The state of the remote video, see RemoteVideoState .None
  ///
  /// * [reason] The reason for the remote video state change, see RemoteVideoStateReason .None
  ///
  /// * [elapsed] Time elapsed (ms) from the local user callingjoinChannelWithOptions the method until the SDK triggers this callback.None
  final void Function(
      RtcConnection connection,
      int remoteUid,
      RemoteVideoState state,
      RemoteVideoStateReason reason,
      int elapsed)? onRemoteVideoStateChanged;

  /// Occurs when the renderer receives the first frame of the remote video.
  ///
  /// * [uid] The ID of the remote user sending the video stream.None
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [width] The width (px) of the video stream.None
  ///
  /// * [height] The height (px) of the video stream.None
  ///
  /// * [elapsed] The time elapsed (ms) from the local user calling joinChannelWithOptions until the SDK triggers this callback.None
  final void Function(RtcConnection connection, int remoteUid, int width,
      int height, int elapsed)? onFirstRemoteVideoFrame;

  /// Occurs when a remote user (in the communication profile)/ host (in the live streaming profile) leaves the channel.
  /// In a communication channel, this callback indicates that a remote user joins the channel. The SDK also triggers this callback to report the existing users in the channel when a user joins the channel.
  /// In a live-broadcast channel, this callback indicates that a host joins the channel. The SDK also triggers this callback to report the existing hosts in the channel when a host joins the channel. Agora recommends limiting the number of hosts to 17. The SDK triggers this callback under one of the following circumstances:
  /// A remote user/hostjoinChannelWithOptions joins the channel by calling the method.
  /// A remote user switches the user role to the host after joining the channel.
  /// A remote user/host rejoins the channel after a network interruption.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [remoteUid] The ID of the user or host who joins the channel.None
  ///
  /// * [elapsed] Time delay (ms) fromjoinChannelWithOptions the local user calling until this callback is triggered.None
  final void Function(RtcConnection connection, int remoteUid, int elapsed)?
      onUserJoined;

  /// Occurs when a remote user (in the communication profile)/ host (in the live streaming profile) leaves the channel.
  /// There are two reasons for users to become offline:
  /// Leave the channel: When a user/host leaves the channel, the user/host sends a goodbye message. When this message is received, the SDK determines that the user/host leaves the channel.
  /// Drop offline: When no data packet of the user or host is received for a certain period of time (20 seconds for the communication profile, and more for the live broadcast profile), the SDK assumes that the user/host drops offline. A poor network connection may lead to false detections. It's recommended to use the Agora RTM SDK for reliable offline detection.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [remoteUid] The ID of the user who leaves the channel or goes offline.None
  ///
  /// * [reason] Reasons why the user goes offline: UserOfflineReasonType .None
  final void Function(RtcConnection connection, int remoteUid,
      UserOfflineReasonType reason)? onUserOffline;

  /// Occurs when a remote user (in the communication profile)/ host (in the live streaming profile) joins the channel.
  /// The SDK triggers this callback when the remote user stops or resumes sending the audio stream by calling the muteLocalAudioStream method.
  /// This callback can be inaccurate when the number of users (in the communication profile) or hosts (in the live broadcasting profile) in a channel exceeds 17.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [remoteUid] The user ID.None
  ///
  /// * [muted] Whether the remote user's audio stream is muted/unmuted:
  ///  true: Muted.
  ///  false: Unmuted.None
  final void Function(RtcConnection connection, int remoteUid, bool muted)?
      onUserMuteAudio;

  /// Occurs when a remote user stops or resumes publishing the video stream.
  /// When a remote user calls muteLocalVideoStream to stop or resume publishing the video stream, the SDK triggers this callback to report the state of the remote user's publishing stream to the local user.
  /// This callback can be inaccurate when the number of users (in the communication profile) or hosts (in the live broadcasting profile) in a channel exceeds 17.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [remoteUid] The user ID of the remote user.None
  ///
  /// * [muted] Whether the remote user stops publishing the video stream:
  ///  true: Stop publishing the local video stream.
  ///  false: Publish the video stream.None
  final void Function(RtcConnection connection, int remoteUid, bool muted)?
      onUserMuteVideo;

  /// Occurs when a remote user enables/disables the video module.
  /// Once the video module is disabled, the user can only use a voice call. The user cannot send or receive any video.
  /// The SDK triggers this callback when a remote user enables or disables the video module by calling the enableVideo or disableVideo method.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [remoteUid] The user ID of the remote user.None
  ///
  /// * [enabled] true: Enable.
  ///  false: Disable.None
  final void Function(RtcConnection connection, int remoteUid, bool enabled)?
      onUserEnableVideo;

  /// @nodoc
  final void Function(RtcConnection connection, int remoteUid, int state)?
      onUserStateChanged;

  /// Occurs when a specific remote user enables/disables the local video capturing function.
  /// The SDK triggers this callback when the remote user resumes or stops capturing the video stream by calling the enableLocalVideo method.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [remoteUid] The user ID of the remote user.None
  ///
  /// * [enabled] Whether the specified remote user enables/disables the local video capturing function: true: Enable. Other users in the channel can see the video of this remote user.
  ///  false: Disable. Other users in the channel can no longer receive the video stream from this remote user, while this remote user can still receive the video streams from other users. None
  final void Function(RtcConnection connection, int remoteUid, bool enabled)?
      onUserEnableLocalVideo;

  /// Occurs when a method is executed by the SDK.
  ///
  /// * [err] The error code returned by the SDK when the method call fails. If the SDK returns 0, then the method call is successful.None
  ///
  /// * [api] The method executed by the SDK.None
  ///
  /// * [result] The result of the method call.None
  final void Function(ErrorCodeType err, String api, String result)?
      onApiCallExecuted;

  /// Reports the statistics of the local audio stream.
  /// The SDK triggers this callback once every two seconds.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [stats] Local audio statistics. See LocalAudioStats .None
  final void Function(RtcConnection connection, LocalAudioStats stats)?
      onLocalAudioStats;

  /// Reports the statistics of the audio stream sent by each remote users.
  /// The SDK triggers this callback once every two seconds. If a channel includes multiple users, the SDK triggers this callback as many times.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [stats] Statistics of the received remote audio stream. See RemoteAudioStats .None
  final void Function(RtcConnection connection, RemoteAudioStats stats)?
      onRemoteAudioStats;

  /// Reports the statistics of the local video stream.
  /// The SDK triggers this callback once every two seconds to report the statistics of the local video stream.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [stats] The statistics of the local video stream. See LocalVideoStats .None
  final void Function(RtcConnection connection, LocalVideoStats stats)?
      onLocalVideoStats;

  /// Reports the statistics of the video stream sent by each remote users.
  /// Reports the statistics of the video stream from the remote users. The SDK triggers this callback once every two seconds for each remote user. If a channel has multiple users/hosts sending video streams, the SDK triggers this callback as many times.
  ///
  /// * [stats] Statistics of the remote video stream. None
  final void Function(RtcConnection connection, RemoteVideoStats stats)?
      onRemoteVideoStats;

  /// Occurs when the camera turns on and is ready to capture the video.
  /// Deprecated: Please use localVideoStreamStateCapturing(1) in onLocalVideoStateChanged instead.
  /// This callback indicates that the camera has been successfully turned on and you can start to capture video.
  final void Function()? onCameraReady;

  /// Occurs when the camera focus area changes.
  ///
  /// * [x] The x-coordinate of the changed focus area.None
  ///
  /// * [y] The y-coordinate of the changed focus area.None
  ///
  /// * [width] The width of the focus area that changes.None
  ///
  /// * [height] The height of the focus area that changes.None
  final void Function(int x, int y, int width, int height)?
      onCameraFocusAreaChanged;

  /// Occurs when the camera exposure area changes.
  final void Function(int x, int y, int width, int height)?
      onCameraExposureAreaChanged;

  /// Reports the face detection result of the local user.
  /// Once you enable face detection by calling enableFaceDetection (true), you can get the following information on the local user in real-time:
  /// The width and height of the local video.
  /// The position of the human face in the local view.
  /// The distance between the human face and the screen. This value is based on the fitting calculation of the local video size and the position of the human face. This callback is for Android and iOS only.
  /// When it is detected that the face in front of the camera disappears, the callback will be triggered immediately. When no human face is detected, the frequency of this callback to be rtriggered wil be decreased to reduce power consumption on the local device.
  /// The SDK stops triggering this callback when a human face is in close proximity to the screen.
  /// On Android, the value of distance reported in this callback may be slightly different from the actual distance. Therefore, Agora does not recommend using it for accurate calculation.
  ///
  /// * [imageWidth] The width (px) of the video image captured by the local camera.None
  ///
  /// * [imageHeight] The height (px) of the video image captured by the local camera.None
  ///
  /// * [vecRectangle] None
  ///
  /// * [vecDistance] The distance between the human face and the device screen (cm).None
  ///
  /// * [numFaces] The number of faces detected. If the value is 0, it means that no human face is detected.None
  final void Function(int imageWidth, int imageHeight, Rectangle vecRectangle,
      int vecDistance, int numFaces)? onFacePositionChanged;

  /// Occurs when the video stops playing.
  /// Deprecated:
  /// Please use localVideoStreamStateStopped(0) in the onLocalVideoStateChanged callback instead. The application can use this callback to change the configuration of the view (for example, displaying other pictures in the view) after the video stops playing.
  final void Function()? onVideoStopped;

  /// Occurs when the playback state of the music file changes.
  /// This callback occurs when the playback state of the music file changes, and reports the current state and error code.
  ///
  /// * [state] The playback state of the music file. See AudioMixingStateType .None
  ///
  /// * [errorCode] The error code. See AudioMixingErrorType .None
  final void Function(
          AudioMixingStateType state, AudioMixingErrorType errorCode)?
      onAudioMixingStateChanged;

  /// @nodoc
  final void Function(
          RhythmPlayerStateType state, RhythmPlayerErrorType errorCode)?
      onRhythmPlayerStateChanged;

  /// Occurs when the SDK cannot reconnect to Agora's edge server 10 seconds after its connection to the server is interrupted.
  /// The SDK triggers this callback when it cannot connect to the server 10 seconds after calling the joinChannelWithOptions method, regardless of whether it is in the channel. If the SDK fails to rejoin the channel within 20 minutes after disconnecting, the SDK will stop trying to reconnect.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  final void Function(RtcConnection connection)? onConnectionLost;

  /// Occurs when the connection between the SDK and the server is interrupted.
  /// Deprecated:
  /// Use onConnectionStateChanged instead. The SDK triggers this callback when it loses connection with the server for more than four seconds after the connection is established. After triggering this callback, the SDK tries to reconnect to the server. You can use this callback to implement pop-up reminders. The difference between this callback and onConnectionLost is:
  /// The SDK triggers the onConnectionInterrupted callback when it loses connection with the server for more than four seconds after it successfully joins the channel.
  /// The SDK triggers the onConnectionLost callback when it loses connection with the server for more than 10 seconds, whether or not it joins the channel.
  /// If the SDK fails to rejoin the channel 20 minutes after being disconnected from Agora's edge server, the SDK stops rejoining the channel.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  final void Function(RtcConnection connection)? onConnectionInterrupted;

  /// Occurs when the connection is banned by the Agora server.
  /// Deprecated:
  /// Please use onConnectionStateChanged instead.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  final void Function(RtcConnection connection)? onConnectionBanned;

  /// Occurs when the local user receives the data stream from the remote user.
  /// The SDK triggers this callback when the local user receives the stream message that the remote user sends by calling the sendStreamMessage method.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [uid] The ID of the remote user sending the message.None
  ///
  /// * [streamId] The stream ID of the received message.None
  ///
  /// * [data] received data.None
  ///
  /// * [length] The data length (byte).None
  ///
  /// * [sentTs] The time when the data stream is sent.None
  final void Function(RtcConnection connection, int remoteUid, int streamId,
      Uint8List data, int length, int sentTs)? onStreamMessage;

  /// Occurs when the local user receives the data stream from the remote user.
  /// The SDK triggers this callback when the local user fails to receive the stream sendStreamMessage message that the remote user sends by calling the method.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [remoteUid] The ID of the remote user sending the message.None
  ///
  /// * [streamId] The stream ID of the received message.None
  ///
  /// * [code] The error code.None
  ///
  /// * [missed] The number of lost messages.None
  ///
  /// * [cached] Number of incoming cached messages when the data stream is interrupted.None
  final void Function(RtcConnection connection, int remoteUid, int streamId,
      ErrorCodeType code, int missed, int cached)? onStreamMessageError;

  /// Occurs when the token expires.
  /// When the token expires during a call, the SDK triggers this callback to remind the app to renew the token.
  /// Once you receive this callback, generate a new token on your app server, and call to joinChannelWithOptions rejoin the channel.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  final void Function(RtcConnection connection)? onRequestToken;

  /// Occurs when the token expires in 30 seconds.
  /// When the token is about to expire in 30 seconds, the SDK triggers this callback to remind the app to renew the token.
  /// Upon receiving this callback, generate a new token on your server, and call renewToken to pass the new token to the SDK.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [token] The token that expires in 30 seconds.None
  final void Function(RtcConnection connection, String token)?
      onTokenPrivilegeWillExpire;

  /// Occurs when the first audio frame is published.
  /// The SDK triggers this callback under one of the following circumstances:
  /// The local client enables the audio module and calls joinChannelWithOptions successfully.
  /// The local client calls muteLocalAudioStream (true) and muteLocalAudioStream(false) in sequence.
  /// The local client calls disableAudio and enableAudio in sequence.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [elapsed] Time elapsed (ms) from the local user calling the joinChannelWithOptions method until this callback is triggered.None
  final void Function(RtcConnection connection, int elapsed)?
      onFirstLocalAudioFramePublished;

  /// Occurs when the first audio frame sent by a specified remote user is received.
  /// Deprecated:
  /// Use instead. onRemoteAudioStateChanged
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [userId] The ID of the remote user sending the audio frames.None
  ///
  /// * [elapsed] The time elapsed (ms) from the local user calling the joinChannelWithOptions method until the SDK triggers this callback.None
  final void Function(RtcConnection connection, int userId, int elapsed)?
      onFirstRemoteAudioFrame;

  /// Occurs when the first audio frame sent by a specified remote user is received.
  /// Deprecated:
  /// Use onRemoteAudioStateChanged instead. The SDK triggers this callback under one of the following circumstances:
  /// The remote user joins the channel and sends the audio stream.
  /// The remote user stops sending the audio stream and re-sends it after 15 seconds, and the possible reasons include:
  /// The remote user leaves the channel.
  /// The remote user is offline.
  /// The remote user calls muteLocalAudioStream to stop sending the video stream.
  /// The remote user calls disableAudio to disable video.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [uid] The user ID of the remote user.None
  ///
  /// * [elapsed] The time elapsed (ms) from the local user calling the joinChannelWithOptions method until the SDK triggers this callback.None
  final void Function(RtcConnection connection, int uid, int elapsed)?
      onFirstRemoteAudioDecoded;

  /// Occurs when the local audio stream state changes.
  /// When the state of the local audio stream changes (including the state of the audio capture and encoding), the SDK triggers this callback to report the current state. This callback indicates the state of the local audio stream, and allows you to troubleshoot issues when audio exceptions occur.
  /// When the state is localAudioStreamStateFailed (3), you can view the error information in the error parameter.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [state] The state of the local audio. See localaudiostreamstate .None
  ///
  /// * [error] Local audio state error codes. See LocalAudioStreamError .None
  final void Function(RtcConnection connection, LocalAudioStreamState state,
      LocalAudioStreamError error)? onLocalAudioStateChanged;

  /// Occurs when the remote audio state changes.
  /// This callback indicates the state change of the remote audio stream.
  /// This callback can be inaccurate when the number of users (in the communication profile) or hosts (in the live broadcasting profile) in a channel exceeds 17.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [remoteUid] The ID of the remote user whose audio state changes.None
  ///
  /// * [state] The state of the remote audio, see RemoteAudioState .None
  ///
  /// * [reason] The reason of the remote audio state change, see RemoteAudioStateReason .None
  ///
  /// * [elapsed] Time elapsed (ms) from the local user calling the joinChannelWithOptions method until the SDK triggers this callback.None
  final void Function(
      RtcConnection connection,
      int remoteUid,
      RemoteAudioState state,
      RemoteAudioStateReason reason,
      int elapsed)? onRemoteAudioStateChanged;

  /// Occurs when the most active remote speaker is detected.
  /// After a successful call of enableAudioVolumeIndication , the SDK continuously detects which remote user has the loudest volume. During the current period, the remote user, who is detected as the loudest for the most times, is the most active user.
  /// When the number of users is no less than two and an active remote speaker exists, the SDK triggers this callback and reports the uid of the most active remote speaker.
  /// If the most active remote speaker is always the same user, the SDK triggers the onActiveSpeaker callback only once.
  /// If the most active remote speaker changes to another user, the SDK triggers this callback again and reports the uid of the new active remote speaker.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [uid] The user ID of the most active remote speaker.None
  final void Function(RtcConnection connection, int uid)? onActiveSpeaker;

  /// @nodoc
  final void Function(ContentInspectResult result)? onContentInspectResult;

  /// @nodoc
  final void Function(RtcConnection connection, String filePath, int width,
      int height, int errCode)? onSnapshotTaken;

  /// Occurs when the user role switches in the interactive live streaming.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [oldRole] Role that the user switches from: ClientRoleType .None
  ///
  /// * [newRole] Role that the user switches to: ClientRoleType .None
  final void Function(RtcConnection connection, ClientRoleType oldRole,
      ClientRoleType newRole)? onClientRoleChanged;

  /// @nodoc
  final void Function(
      RtcConnection connection,
      ClientRoleChangeFailedReason reason,
      ClientRoleType currentRole)? onClientRoleChangeFailed;

  /// @nodoc
  final void Function(MediaDeviceType deviceType, int volume, bool muted)?
      onAudioDeviceVolumeChanged;

  /// Occurs when the media push state changes.
  /// When the media push state changes, the SDK triggers this callback and reports the URL address and the current state of the media push. This callback indicates the state of the media push. When exceptions occur, you can troubleshoot issues by referring to the detailed error descriptions in the error code.
  ///
  /// * [url] The URL address where the state of the media push changes.None
  ///
  /// * [state] The current state of the media push. See RtmpStreamPublishState .None
  ///
  /// * [errCode] The detailed error information for the media push. See RtmpStreamPublishErrorType .None
  final void Function(String url, RtmpStreamPublishState state,
      RtmpStreamPublishErrorType errCode)? onRtmpStreamingStateChanged;

  /// Reports events during the media push.
  ///
  /// * [url] The URL for media push.None
  ///
  /// * [eventCode] The event code of media push. See RtmpStreamingEvent .None
  final void Function(String url, RtmpStreamingEvent eventCode)?
      onRtmpStreamingEvent;

  /// Occurs when an RTMP or RTMPS stream is published.
  /// Deprecated:
  /// Please use onRtmpStreamingStateChanged instead. Reports the result of publishing an RTMP or RTMPS stream.
  ///
  /// * [url] The CDN streaming URL.None
  ///
  /// * [error] Error codes of the RTMP or RTMPS streaming.
  ///  ERR_OK (0): The publishing succeeds.
  ///  ERR_FAILED (1): The publishing fails.
  ///  ERR_INVALID_ARGUMENT (-2): Invalid argument used.
  ///  If you do not call setLiveTranscoding to configure
  ///  LiveTranscoding before calling addPublishStreamUrl , the SDK reports
  ///  ERR_INVALID_ARGUMENT.
  ///  ERR_TIMEDOUT (10): The publishing timed out.
  ///  ERR_ALREADY_IN_USE (19): The chosen URL address is
  ///  already in use for CDN live streaming.
  ///  ERR_ENCRYPTED_STREAM_NOT_ALLOWED_PUBLISH (130): You
  ///  cannot publish an encrypted stream.
  ///  ERR_PUBLISH_STREAM_CDN_ERROR (151): CDN related
  ///  error. Remove the original URL address and add a new one by calling
  ///  the removePublishStreamUrl and addPublishStreamUrl methods.
  ///  ERR_PUBLISH_STREAM_NUM_REACH_LIMIT (152): The host
  ///  manipulates more than 10 URLs. Delete the unnecessary URLs before
  ///  adding new ones.
  ///  ERR_PUBLISH_STREAM_NOT_AUTHORIZED (153): The host
  ///  manipulates other hosts' URLs. Please check your app logic.
  ///  ERR_PUBLISH_STREAM_INTERNAL_SERVER_ERROR (154): An
  ///  error occurs in Agora's streaming server. Call the removePublishStreamUrl method to publish the streaming
  ///  again.
  ///  ERR_PUBLISH_STREAM_FORMAT_NOT_SUPPORTED (156): The
  ///  format of the CDN streaming URL is not supported. Check whether the
  ///  URL format is correct. None
  final void Function(String url, ErrorCodeType error)? onStreamPublished;

  /// Occurs when the media push stops.
  /// Deprecated:
  /// Please use onRtmpStreamingStateChanged instead.
  ///
  /// * [url] Removes an RTMP or RTMPS URL of the media push.None
  final void Function(String url)? onStreamUnpublished;

  /// Occurs when the publisher's transcoding is updated.
  /// setLiveTranscoding When the class in the method LiveTranscoding updates, theonTranscodingUpdated SDK triggers the callback to report the update information.
  /// If you callsetLiveTranscoding the method to set the class for the first timeLiveTranscoding, the SDK does not trigger this callback.
  final void Function()? onTranscodingUpdated;

  /// Occurs when the local audio route changes.
  /// This method is for Android, iOS and macOS only.
  ///
  /// * [routing] The current audio routing. See AudioRoute .None
  final void Function(int routing)? onAudioRoutingChanged;

  /// Occurs when the state of the media stream relay changes.
  /// The SDK returns the state of the current media relay with any error message.
  ///
  /// * [state] The state code. See ChannelMediaRelayState .None
  ///
  /// * [code] The error code of the channel media relay. See ChannelMediaRelayError .None
  final void Function(
          ChannelMediaRelayState state, ChannelMediaRelayError code)?
      onChannelMediaRelayStateChanged;

  /// Reports events during the media stream relay.
  ///
  /// * [code] The event code of channel media relay. See ChannelMediaRelayEvent .None
  final void Function(ChannelMediaRelayEvent code)? onChannelMediaRelayEvent;

  /// @nodoc
  final void Function(bool isFallbackOrRecover)?
      onLocalPublishFallbackToAudioOnly;

  /// @nodoc
  final void Function(int uid, bool isFallbackOrRecover)?
      onRemoteSubscribeFallbackToAudioOnly;

  /// Reports the transport-layer statistics of each remote audio stream.
  /// Deprecated:
  /// Please use onRemoteAudioStats instead.
  /// This callback reports the transport-layer statistics, such as the packet loss rate and network time delay, once every two seconds after the local user receives an audio packet from a remote user. During a call, when the user receives the video packet sent by the remote user/host, the callback is triggered every 2 seconds.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [remoteUid] The ID of the remote user sending the audio packets.None
  ///
  /// * [delay] The network delay (ms) from the sender to the receiver.None
  ///
  /// * [lost] The packet loss rate (%) of the audio packet sent from the remote user.None
  ///
  /// * [rxKBitRate] The bitrate of the received audio (Kbps).None
  final void Function(RtcConnection connection, int remoteUid, int delay,
      int lost, int rxKBitRate)? onRemoteAudioTransportStats;

  /// Reports the transport-layer statistics of each remote video stream.
  /// Deprecated:
  /// This callback is deprecated, use onRemoteVideoStats instead. This callback reports the transport-layer statistics, such as the packet loss rate and network time delay, once every two seconds after the local user receives a video packet from a remote user.
  /// During a call, when the user receives the video packet sent by the remote user/host, the callback is triggered every 2 seconds.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [remoteUid] The ID of the remote user sending the video packets.None
  ///
  /// * [delay] The network delay (ms) from the sender to the receiver.None
  ///
  /// * [lost] The packet loss rate (%) of the video packet sent from the remote user.None
  ///
  /// * [rxKBitRate] The bitrate of the received video (Kbps).None
  final void Function(RtcConnection connection, int remoteUid, int delay,
      int lost, int rxKBitRate)? onRemoteVideoTransportStats;

  /// Occurs when the network connection state changes.
  /// When the network connection state changes, the SDK triggers this callback and reports the current connection state and the reason for the change.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [state] The current connection state.  ConnectionStateType None
  ///
  /// * [reason] The reason for a connection state change. See ConnectionChangedReasonType .None
  final void Function(RtcConnection connection, ConnectionStateType state,
      ConnectionChangedReasonType reason)? onConnectionStateChanged;

  /// Occurs when the local network type changes.
  /// This callback occurs when the connection state of the local user changes. You can get the connection state and reason for the state change in this callback. When the network connection is interrupted, this callback indicates whether the interruption is caused by a network type change or poor network conditions.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [type] Network types: See NetworkType .None
  final void Function(RtcConnection connection, NetworkType type)?
      onNetworkTypeChanged;

  /// Reports the built-in encryption errors.
  /// When encryption is enabled by calling enableEncryption , the SDK triggers this callback if an error occurs in encryption or decryption on the sender or the receiver side.
  ///
  /// * [connection] The connection information. See RtcConnection .None
  ///
  /// * [errorType] None
  final void Function(RtcConnection connection, EncryptionErrorType errorType)?
      onEncryptionError;

  /// Occurs when the SDK cannot get the device permission.
  /// When the SDK fails to get the device permission, the SDK triggers this callback to report which device permission cannot be got.
  /// This method is for Android and iOS only.
  ///
  /// * [permissionType] The type of the device permission. See PermissionType .None
  final void Function(PermissionType permissionType)? onPermissionError;

  /// Occurs when the local user registers a user account.
  /// After the local user successfully calls registerLocalUserAccount to register the user account or calls joinChannelWithUserAccount to join a channel, the SDK triggers the callback and informs the local user's UID and User Account.
  ///
  /// * [uid] The ID of the local user.None
  ///
  /// * [userAccount] The user account of the local user.None
  final void Function(int uid, String userAccount)? onLocalUserRegistered;

  /// Occurs when the SDK gets the user ID and user account of the remote user.
  /// After a remote user joins the channel, the SDK gets the UID and user account of the remote user, caches them in a mapping table object, and triggers this callback on the local client.
  ///
  /// * [uid] The user ID of the remote user.None
  ///
  /// * [info] The UserInfo object that contains the user ID and user account of the remote user. See for details UserInfo .None
  final void Function(int uid, UserInfo info)? onUserInfoUpdated;

  /// @nodoc
  final void Function(RtcConnection connection, String requestId, bool success,
      UploadErrorReason reason)? onUploadLogResult;

  /// Occurs when the audio subscribing state changes.
  ///
  /// * [channel] The channel name.None
  ///
  /// * [uid] The user ID of the remote user.None
  ///
  /// * [oldState] The previous subscribing status. See StreamSubscribeState .None
  ///
  /// * [newState] The current subscribing status. See StreamSubscribeState.None
  ///
  /// * [elapseSinceLastState] The time elapsed (ms) from the previous state to the current state.None
  final void Function(
      String channel,
      int uid,
      StreamSubscribeState oldState,
      StreamSubscribeState newState,
      int elapseSinceLastState)? onAudioSubscribeStateChanged;

  /// Occurs when the video subscribing state changes.
  ///
  /// * [channel] The channel name.None
  ///
  /// * [uid] The user ID of the remote user.None
  ///
  /// * [oldState] The previous subscribing status. See StreamSubscribeState .None
  ///
  /// * [newState] The current subscribing status. See StreamSubscribeState.None
  ///
  /// * [elapseSinceLastState] The time elapsed (ms) from the previous state to the current state.None
  final void Function(
      String channel,
      int uid,
      StreamSubscribeState oldState,
      StreamSubscribeState newState,
      int elapseSinceLastState)? onVideoSubscribeStateChanged;

  /// Occurs when the audio publishing state changes.
  ///
  /// * [channel] The channel name.None
  ///
  /// * [oldState] The previous subscribing status. See StreamPublishState .None
  ///
  /// * [newState] The current subscribing status. See StreamPublishState.None
  ///
  /// * [elapseSinceLastState] The time elapsed (ms) from the previous state to the current state.None
  final void Function(
      String channel,
      StreamPublishState oldState,
      StreamPublishState newState,
      int elapseSinceLastState)? onAudioPublishStateChanged;

  /// Occurs when the video publishing state changes.
  ///
  /// * [channel] The channel name.None
  ///
  /// * [oldState] The previous subscribing status. See StreamPublishState .None
  ///
  /// * [newState] The current subscribing status. See StreamPublishState.None
  ///
  /// * [elapseSinceLastState] The time elapsed (ms) from the previous state to the current state.None
  final void Function(
      String channel,
      StreamPublishState oldState,
      StreamPublishState newState,
      int elapseSinceLastState)? onVideoPublishStateChanged;

  /// The event callback of the extension.
  /// To listen for events while the extension is running, you need to register this callback.
  ///
  /// * [value] The value of the extension key.None
  ///
  /// * [key] The key of the extension.None
  ///
  /// * [provider] The name of the extension provider.None
  ///
  /// * [extName] The name of the extension.None
  final void Function(
          String provider, String extName, String key, String value)?
      onExtensionEvent;

  /// Occurs when the extension is enabled.
  /// After a successful call of enableExtension (true), this callback is triggered.
  ///
  /// * [provider] The name of the extension provider.None
  ///
  /// * [extName] The name of the extension.None
  final void Function(String provider, String extName)? onExtensionStarted;

  /// Occurs when the extension is disabled.
  /// After a successful call of enableExtension (false), this callback is triggered.
  ///
  /// * [extName] The name of the extension.None
  ///
  /// * [provider] The name of the extension provider.None
  final void Function(String provider, String extName)? onExtensionStopped;

  /// Occurs when the extension runs incorrectly.
  /// When calling enableExtension (true) fails or the extension runs in error, the extension triggers this callback and reports the error code and reason.
  ///
  /// * [provider] The name of the extension provider.None
  ///
  /// * [extName] The name of the extension.None
  ///
  /// * [error] The error code. For details, see the extension documentation provided by the extension provider.None
  ///
  /// * [msg] Reason. For details, see the extension documentation provided by the extension provider.None
  final void Function(String provider, String extName, int error, String msg)?
      onExtensionErrored;

  /// @nodoc
  final void Function(
          RtcConnection connection, int remoteUid, String userAccount)?
      onUserAccountUpdated;
}

/// Video device management methods.
abstract class VideoDeviceManager {
  /// Enumerates the video devices.
  ///
  /// ## Return
  /// Success: A VideoDeviceInfo array including all video devices in the system.
  /// Failure: An empty array.
  Future<List<VideoDeviceInfo>> enumerateVideoDevices();

  /// Specifies the video capture device with the device ID.
  /// Plugging or unplugging a device does not change its device ID.
  ///
  /// * [deviceIdUTF8] The device ID. You can get the device ID by calling enumerateVideoDevices .
  ///  The maximum length is MaxDeviceIdLengthType .None
  Future<void> setDevice(String deviceIdUTF8);

  /// Retrieves the current video capture device.
  ///
  /// ## Return
  /// The video capture device.
  Future<String> getDevice();

  /// @nodoc
  Future<void> startDeviceTest(int hwnd);

  /// @nodoc
  Future<void> stopDeviceTest();

  /// Releases all the resources occupied by the VideoDeviceManager object.
  Future<void> release();
}

/// Definition of RtcEngineContext.
@JsonSerializable(explicitToJson: true)
class RtcEngineContext {
  /// Construct the [RtcEngineContext].
  const RtcEngineContext(
      {this.appId,
      this.enableAudioDevice,
      this.channelProfile,
      this.audioScenario,
      this.areaCode,
      this.logConfig,
      this.threadPriority,
      this.useExternalEglContext});

  /// The App ID issued by Agora for your project. Only users in apps with the same App ID can join the same channel and communicate with each other. An App ID can only be used to create one RtcEngine instance. To change your App ID, call release to destroy the current RtcEngine instance, and then create a new one.
  @JsonKey(name: 'appId')
  final String? appId;

  /// @nodoc
  @JsonKey(name: 'enableAudioDevice')
  final bool? enableAudioDevice;

  /// The channel profile. See ChannelProfileType .
  @JsonKey(name: 'channelProfile')
  final ChannelProfileType? channelProfile;

  /// The audio scenario. Under different audio scenarios, the device uses different volume types.
  @JsonKey(name: 'audioScenario')
  final AudioScenarioType? audioScenario;

  /// The region for connection. This is an advanced feature and applies to scenarios that have regional restrictions. For the regions that Agora supports, see AreaCode . The area codes support bitwise operation.After specifying the region, the app integrated with the Agora SDK connects to the Agora servers within that region.
  @JsonKey(name: 'areaCode')
  final int? areaCode;

  /// The SDK log files are: agorasdk.log, agorasdk.1.log, agorasdk.2.log, agorasdk.3.log, and agorasdk.4.log.
  /// The API call log files are: agoraapi.log, agoraapi.1.log, agoraapi.2.log, agoraapi.3.log, and agoraapi.4.log.
  /// The default size for each SDK log file is 1,024 KB; the default size for each API call log file is 2,048 KB. These log files are encoded in UTF-8.
  /// The SDK writes the latest logs in agorasdk.log or agoraapi.log.
  /// When agorasdk.log is full, the SDK processes the log files in the following order:
  /// Delete the agorasdk.4.log file (if any).
  /// Rename agorasdk.3.log to agorasdk.4.log.
  /// Rename agorasdk.2.log to agorasdk.3.log.
  /// Rename agorasdk.1.log to agorasdk.2.log.
  /// Create a new agorasdk.log file. The overwrite rules for the agoraapi.log file are the same as for agorasdk.log. The log files that the SDK outputs. See LogConfig .
  /// By default, the SDK generates five SDK log files and five API call log files with the following rules:
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

/// The metadata observer.
class MetadataObserver {
  /// Construct the [MetadataObserver].
  const MetadataObserver({
    this.onMetadataReceived,
  });

  /// Occurs when the local user receives the metadata.
  ///
  /// * [metadata] The metadata received, see Metadata .None
  final void Function(Metadata metadata)? onMetadataReceived;
}

/// Metadata type of the observer. We only support video Metadata for now.
@JsonEnum(alwaysCreate: true)
enum MetadataType {
  /// The type of metadata is unknown.
  @JsonValue(-1)
  unknownMetadata,

  /// The type of metadata is video.
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

/// Media metadata.
@JsonSerializable(explicitToJson: true)
class Metadata {
  /// Construct the [Metadata].
  const Metadata({this.uid, this.size, this.buffer, this.timeStampMs});

  /// The user ID.
  /// For the recipient:the ID of the remote user who sent the Metadata.
  /// Ignore it for sender.
  @JsonKey(name: 'uid')
  final int? uid;

  /// Buffer size for received or sent Metadata.
  @JsonKey(name: 'size')
  final int? size;

  /// The buffer address of the received or sent Metadata.
  @JsonKey(name: 'buffer', ignore: true)
  final Uint8List? buffer;

  /// The timestamp (ms) of Metadata.
  @JsonKey(name: 'timeStampMs')
  final int? timeStampMs;

  /// @nodoc
  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum DirectCdnStreamingError {
  /// @nodoc
  @JsonValue(0)
  directCdnStreamingErrorOk,

  /// @nodoc
  @JsonValue(1)
  directCdnStreamingErrorFailed,

  /// @nodoc
  @JsonValue(2)
  directCdnStreamingErrorAudioPublication,

  /// @nodoc
  @JsonValue(3)
  directCdnStreamingErrorVideoPublication,

  /// @nodoc
  @JsonValue(4)
  directCdnStreamingErrorNetConnect,

  /// @nodoc
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

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum DirectCdnStreamingState {
  /// @nodoc
  @JsonValue(0)
  directCdnStreamingStateIdle,

  /// @nodoc
  @JsonValue(1)
  directCdnStreamingStateRunning,

  /// @nodoc
  @JsonValue(2)
  directCdnStreamingStateStopped,

  /// @nodoc
  @JsonValue(3)
  directCdnStreamingStateFailed,

  /// @nodoc
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

/// @nodoc
@JsonSerializable(explicitToJson: true)
class DirectCdnStreamingStats {
  /// Construct the [DirectCdnStreamingStats].
  const DirectCdnStreamingStats(
      {this.videoWidth,
      this.videoHeight,
      this.fps,
      this.videoBitrate,
      this.audioBitrate});

  /// /// @nodoc
  @JsonKey(name: 'videoWidth')
  final int? videoWidth;

  /// /// @nodoc
  @JsonKey(name: 'videoHeight')
  final int? videoHeight;

  /// /// @nodoc
  @JsonKey(name: 'fps')
  final int? fps;

  /// /// @nodoc
  @JsonKey(name: 'videoBitrate')
  final int? videoBitrate;

  /// /// @nodoc
  @JsonKey(name: 'audioBitrate')
  final int? audioBitrate;

  /// @nodoc
  factory DirectCdnStreamingStats.fromJson(Map<String, dynamic> json) =>
      _$DirectCdnStreamingStatsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$DirectCdnStreamingStatsToJson(this);
}

/// @nodoc
class DirectCdnStreamingEventHandler {
  /// Construct the [DirectCdnStreamingEventHandler].
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

/// @nodoc
@JsonSerializable(explicitToJson: true)
class DirectCdnStreamingMediaOptions {
  /// Construct the [DirectCdnStreamingMediaOptions].
  const DirectCdnStreamingMediaOptions(
      {this.publishCameraTrack,
      this.publishMicrophoneTrack,
      this.publishCustomAudioTrack,
      this.publishCustomVideoTrack,
      this.publishMediaPlayerAudioTrack,
      this.publishMediaPlayerId});

  /// /// @nodoc
  @JsonKey(name: 'publishCameraTrack')
  final bool? publishCameraTrack;

  /// @nodoc
  @JsonKey(name: 'publishMicrophoneTrack')
  final bool? publishMicrophoneTrack;

  /// /// @nodoc
  @JsonKey(name: 'publishCustomAudioTrack')
  final bool? publishCustomAudioTrack;

  /// /// @nodoc
  @JsonKey(name: 'publishCustomVideoTrack')
  final bool? publishCustomVideoTrack;

  /// @nodoc
  @JsonKey(name: 'publishMediaPlayerAudioTrack')
  final bool? publishMediaPlayerAudioTrack;

  /// @nodoc
  @JsonKey(name: 'publishMediaPlayerId')
  final int? publishMediaPlayerId;

  /// @nodoc
  factory DirectCdnStreamingMediaOptions.fromJson(Map<String, dynamic> json) =>
      _$DirectCdnStreamingMediaOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$DirectCdnStreamingMediaOptionsToJson(this);
}

/// The basic interface of the Agora SDK that implements the core functions of real-time communication.
/// RtcEngine provides the main methods that your app can call.
abstract class RtcEngine {
  /// Releases the RtcEngine instance.
  /// This method releases all resources used by the Agora SDK. Use this method for apps in which users occasionally make voice or video calls. When users do not make calls, you can free up resources for other operations.
  /// After a successful method call, you can no longer use any method or callback in the SDK anymore. If you want to use the real-time communication functions again, you must call createAgoraRtcEngine and initialize to create a new RtcEngine instance.
  /// If you want to create a new RtcEngine instance after destroying the current one, ensure that you wait till the release method execution to complete.
  ///
  /// * [sync] true: Synchronous call. Agora suggests calling this method in a sub-thread to avoid congestion in the main thread because the synchronous call and the app cannot move on to another task until the resources used by RtcEngine are released. Besides, you cannot call release in any method or callback of the SDK. Otherwise, the SDK cannot release the resources until the callbacks return results, which may result in a deadlock. The SDK automatically detects the deadlock and converts this method into an asynchronous call, causing the test to take additional time.
  ///  false: Asynchronous call. The app can move on to another task, no matter the resources used by RtcEngine are released or not. Do not immediately uninstall the SDK's dynamic library after the call; otherwise, it may cause a crash due to the SDK clean-up thread not quitting.None
  Future<void> release({bool sync = false});

  /// Initializes RtcEngine.
  /// All called methods provided by the RtcEngine class are executed asynchronously. Agora recommends calling these methods in the same thread. Before calling other APIs, you must call createAgoraRtcEngine and RtcEngine to create and initialize the initialize object.
  /// The SDK supports creating only one RtcEngine instance for an app.
  ///
  /// * [context] Configurations for the RtcEngine instance. See RtcEngineContext .None
  ///
  /// ## Return
  /// The RtcEngine instance, if the method call succeeds.
  /// An error code, if the call fails.
  Future<void> initialize(RtcEngineContext context);

  /// Gets the SDK version.
  ///
  /// ## Return
  /// The SDK version number. The format is a string. See SDKBuildInfo .
  Future<SDKBuildInfo> getVersion();

  /// Gets the warning or error description.
  ///
  /// * [code] The error code or warning code reported by the SDK.None
  ///
  /// ## Return
  /// The specific error or warning description.
  Future<String> getErrorDescription(int code);

  /// Updates the channel media options after joining the channel.
  ///
  /// * [options] The channel media options. See ChannelMediaOptions .None
  Future<void> updateChannelMediaOptions(ChannelMediaOptions options);

  /// Gets a new token when the current token expires after a period of time.
  /// You can use this method to pass a new token to the SDK. A token expires after a certain period of time. In the following two cases, the app should call this method to pass in a new token. Failure to do so will result in the SDK disconnecting from the server.
  /// The SDK triggers the onTokenPrivilegeWillExpire callback.
  /// The onConnectionStateChanged callback reports connectionChangedTokenExpired(9).
  ///
  /// * [token] The new token.None
  Future<void> renewToken(String token);

  /// Sets the channel profile.
  /// To ensure the quality of real-time communication, Agora recommends that all users in a channel use the same channel profile.
  /// This method must be called and set before joinChannelWithOptions, and cannot be set again after joining the channel.
  ///
  /// * [profile] The channel profile. See ChannelProfileType .None
  Future<void> setChannelProfile(ChannelProfileType profile);

  /// Stops the audio call test.
  Future<void> stopEchoTest();

  /// Enables the video module.
  /// Call this method either before joining a channel or during a call. If this method is called before joining a channel, the call starts in the video mode. Call disableVideo to disable the video mode.
  /// A successful call of this method triggers the onRemoteVideoStateChanged callback on the remote client. This method enables the internal engine and is valid after leaving the channel.
  /// This method resets the internal engine and takes some time to take effect. Agora recommends using the following API methods to control the video engine modules separately:
  /// enableLocalVideo : Whether to enable the camera to create the local video stream.
  /// muteLocalVideoStream : Whether to publish the local video stream.
  /// muteRemoteVideoStream : Whether to subscribe to and play the remote video stream.
  /// muteAllRemoteVideoStreams : Whether to subscribe to and play all remote video streams.
  Future<void> enableVideo();

  /// Disables the video module.
  /// This method disables video. You can call this method either before or after joining a channel. If you call it before joining a channel, an audio call starts when you join the channel. If you call it after joining a channel, a video call switches to an audio call. Call enableVideo to enable video.
  /// A successful call of this method triggers the onUserEnableVideo (false)callback on the remote client. This method affects the internal engine and can be called after leaving the channel.
  /// This method resets the internal engine and takes some time to take effect. Agora recommends using the following API methods to control the video engine modules separately:
  /// enableLocalVideo : Whether to enable the camera to create the local video stream.
  /// muteLocalVideoStream : Whether to publish the local video stream.
  /// muteRemoteVideoStream : Whether to subscribe to and play the remote video stream.
  /// muteAllRemoteVideoStreams : Whether to subscribe to and play all remote video streams.
  Future<void> disableVideo();

  /// Starts the last mile network probe test.
  /// This method starts the last-mile network probe test before joining a channel to get the uplink and downlink last mile network statistics, including the bandwidth, packet loss, jitter, and round-trip time (RTT).
  /// Once this method is enabled, the SDK returns the following callbacks:
  /// onLastmileQuality : The SDK triggers this callback within two seconds depending on the network conditions. This callback rates the network conditions and is more closely linked to the user experience.
  /// onLastmileProbeResult : The SDK triggers this callback within 30 seconds depending on the network conditions. This callback returns the real-time statistics of the network conditions and is more objective. This method applies to the following scenarios:
  /// Before a user joins a channel, call this method to check the uplink network quality.
  /// In a live streaming channel, call this method to check the uplink network quality before an audience member switches to a host.
  /// Do not call other methods before receiving the onLastmileQuality and onLastmileProbeResult callbacks. Otherwise, the callbacks may be interrupted.
  /// A host should not call this method after joining a channel (when in a call).
  ///
  /// * [config] The configurations of the last-mile network probe test. See LastmileProbeConfig .None
  Future<void> startLastmileProbeTest(LastmileProbeConfig config);

  /// Stops the last mile network probe test.
  Future<void> stopLastmileProbeTest();

  /// Sets the video encoder configuration.
  /// Sets the encoder configuration for the local video.
  /// You can call this method either before or after joining a channel. If you don't need to set the video encoder configuration after joining a channel,
  /// Agora recommends you calling this method before the enableVideo method to reduce the rendering time of the first video frame.
  ///
  /// * [config] Video profile. See VideoEncoderConfiguration .None
  Future<void> setVideoEncoderConfiguration(VideoEncoderConfiguration config);

  /// Sets the image enhancement options.
  /// Enables or disables image enhancement, and sets the options.
  /// Enabling the image enhancement function involves a series of method calls. The calling sequence is as follows:
  /// Call loadExtensionProvider (libagora_video_process_extension.dll) during RtcEngine initialization to specify the extension library path.
  /// Call enableExtension (agora, beauty, true) to enable the extension.
  /// Call enableVideo to enable the video module.
  /// Call this method to enable the image enhancement function.
  ///
  /// * [type] The type of the video source, see MediaSourceType .None
  ///
  /// * [enabled] Whether to enable the image enhancement function:
  ///  true: Enable the image enhancement function.
  ///  false: (Default) Disable the image enhancement function.None
  ///
  /// * [options] The image enhancement options. See BeautyOptions .None
  Future<void> setBeautyEffectOptions(
      {required bool enabled,
      required BeautyOptions options,
      MediaSourceType type = MediaSourceType.primaryCameraSource});

  /// Enables/Disables the virtual background (beta feature).
  /// The virtual background function allows you to replace the original background image of the local user or to blur the background. After successfully enabling the virtual background function, all users in the channel can see the customized background.
  /// Enabling the virtual background function involves a series of method calls. The calling sequence is as follows:
  /// Call loadExtensionProvider (libagora_segmentation_extension.dll) during RtcEngine initialization to specify the extension's library path.
  /// Call enableExtension (agora_segmentation, PortraitSegmentation, true) to enable the extension.
  /// Call enableVideo to enable the video module.
  /// Call this method to enable the virtual background function.
  /// This function requires a high-performance device. Agora recommends that you use this function on devices with the following chips:
  /// Snapdragon 700 series 750G and later
  /// Snapdragon 800 series 835 and later
  /// Dimensity 700 series 720 and later
  /// Kirin 800 series 810 and later
  /// Kirin 900 series 980 and later
  /// Devices with an A9 chip and better, as follows:
  /// iPhone 6S and later
  /// iPad Air 3rd generation and later
  /// iPad 5th generation and later
  /// iPad Pro 1st generation and later
  /// iPad mini 5th generation and later Agora recommends that you use this function in scenarios that meet the following conditions:
  /// A high-definition camera device is used, and the environment is uniformly lit.
  /// The captured video image is uncluttered, the user's portrait is half-length and largely unobstructed, and the background is a single color that differs from the color of the user's clothing.
  ///
  /// * [enabled] Whether to enable virtual background:
  ///  true: Enable the image enhancement function.
  ///  false: Disable virtual background.None
  ///
  /// * [backgroundSource] The custom background image. See VirtualBackgroundSource . To adapt the resolution of the custom background image to that of the video captured by the SDK, the SDK scales and crops the custom background image while ensuring that the content of the custom background image is not distorted.None
  Future<void> enableVirtualBackground(
      {required bool enabled,
      required VirtualBackgroundSource backgroundSource});

  /// Enables/Disables the super resolution algorithm for a remote user's video stream.
  /// This feature effectively boosts the resolution of a remote user's video seen by the local user. If the original resolution of a remote user's video is a × b, the local user's device can render the remote video at a resolution of 2a × 2b.
  /// After calling this method, you can confirm whether super resolution is successfully enabled through the remote video stream statistics ( RemoteVideoStats ) in the onRemoteVideoStats callback:
  /// If the parameter superResolutionType >0: Super resolution is enabled.
  /// If parameter superResolutionType =0: Super resolution is not enabled. The super resolution feature requires extra system resources. To balance the visual experience and system consumption, this feature can only be enabled for a single remote user. If the local user uses super resolution on Android, the original resolution of the remote user's video cannot exceed 640 × 360 pixels; if the local user uses super resolution on iOS, the original resolution of the remote user's video cannot exceed 640 × 480 pixels.
  /// This method is for Android and iOS only.
  /// Before calling this method, ensure that you have integrated the following dynamic libraries:
  /// Android: libagora_super_resolution_extension.so
  /// iOS: AgoraSuperResolutionExtension.xcframework Because this method has certain system performance requirements, Agora recommends that you use the following devices or better:
  /// Android:
  /// VIVO: V1821A, NEX S, 1914A, 1916A, 1962A, 1824BA, X60, X60 Pro
  /// OPPO: PCCM00, Find X3
  /// OnePlus: A6000
  /// Xiaomi: Mi 8, Mi 9, Mi 10, Mi 11, MIX3, Redmi K20 Pro
  /// SAMSUNG: SM-G9600, SM-G9650, SM-N9600, SM-G9708, SM-G960U, SM-G9750, S20, S21
  /// HUAWEI: SEA-AL00, ELE-AL00, VOG-AL00, YAL-AL10, HMA-AL00, EVR-AN00, nova 4, nova 5 Pro, nova 6 5G, nova 7 5G, Mate 30, Mate 30 Pro, Mate 40, Mate 40 Pro, P40, P40 Pro, Huawei M6, MatePad 10.8 iOS:
  /// iPhone XR
  /// iPhone XS
  /// iPhone XS Max
  /// iPhone 11
  /// iPhone 11 Pro
  /// iPhone 11 Pro Max
  /// iPhone 12
  /// iPhone 12 mini
  /// iPhone 12 Pro
  /// iPhone 12 Pro Max
  /// iPhone 12 SE (2nd generation)
  /// iPad Pro 11-inch (3rd generation)
  /// iPad Pro 12.9-inch (3rd generation)
  /// iPad Air 3 (3rd generation)
  /// iPad Air 3 (4th generation)
  ///
  /// * [userId] The user ID of the remote user.None
  ///
  /// * [enable] Whether to enable super resolution for the remote user’s video:
  ///  true: Enable the image enhancement function.
  ///  false: Disable virtual background.None
  Future<void> enableRemoteSuperResolution(
      {required int userId, required bool enable});

  /// Initializes the video view of a remote user.
  /// This method initializes the video view of a remote stream on the local device. It affects only the video view that the local user sees. Call this method to bind the remote video stream to a video view and to set the rendering and mirror modes of the video view.
  /// You need to specify the ID of the remote user in this method. If the remote user ID is unknown to the application, set it after the app receives the onUserJoined callback.
  /// To unbind the remote user from the view, set the view parameter to NULL.
  /// Once the remote user leaves the channel, the SDK unbinds the remote user. To update the rendering or mirror mode of the remote video view during a call, use the setRemoteRenderMode method.
  /// If you use the Agora recording feature, the recording client joins the channel as a dummy client, triggering the onUserJoined callback. Do not bind the dummy client to the app view because the dummy client does not send any video streams. If your app does not recognize the dummy client, bind the remote user to the view when the SDK triggers the onFirstRemoteVideoDecoded callback.
  ///
  /// * [canvas] The remote video view and settings. See VideoCanvas .None
  Future<void> setupRemoteVideo(VideoCanvas canvas);

  /// Initializes the local video view.
  /// This method initializes the video view of a local stream on the local device. It affects only the video view that the local user sees, not the published local video stream. Call this method to bind the local video stream to a video view and to set the rendering and mirror modes of the video view.
  /// After initialization, call this method to set the local video and then join the channel. The local video still binds to the view after you leave the channel. To unbind the local video from the view, set the view parameter as .NULL You can call this method either before or after joining a channel.
  /// To update the rendering or mirror mode of the local video view during a call, use the setLocalRenderMode [2/2] method.
  ///
  /// * [canvas] Local video display properties. See VideoCanvas .None
  Future<void> setupLocalVideo(VideoCanvas canvas);

  /// Enables the audio module.
  /// The audio mode is enabled by default. This method enables the internal engine and can be called anytime after initialization. It is still valid after one leaves channel.
  /// This method enables the audio module and takes some time to take effect. Agora recommends using the following API methods to control the audio module separately:
  /// enableLocalAudio : Whether to enable the microphone to create the local audio stream.
  /// muteLocalAudioStream : Whether to publish the local audio stream.
  /// muteRemoteAudioStream : Whether to subscribe and play the remote audio stream.
  /// muteAllRemoteAudioStreams : Whether to subscribe to and play all remote audio streams.
  Future<void> enableAudio();

  /// Disables the audio module.
  /// This method disables the internal engine and can be called anytime after initialization. It is still valid after one leaves channel.
  /// This method resets the internal engine and takes some time to take effect. Agora recommends using the following API methods to control the audio modules separately:
  /// enableLocalAudio : Whether to enable the microphone to create the local audio stream.
  /// muteLocalAudioStream : Whether to publish the local audio stream.
  /// muteRemoteAudioStream : Whether to subscribe and play the remote audio stream.
  /// muteAllRemoteAudioStreams : Whether to subscribe to and play all remote audio streams.
  Future<void> disableAudio();

  /// Enables/Disables the local audio capture.
  /// The audio function is enabled by default. This method disables or re-enables the local audio function to stop or restart local audio capturing.
  /// This method does not affect receiving or playing the remote audio streams, and enableLocalAudio (false) is applicable to scenarios where the user wants to receive remote audio streams without sending any audio stream to other users in the channel.
  /// Once the local audio function is disabled or re-enabled, the SDK triggers the onLocalAudioStateChanged callback, which reports localAudioStreamStateStopped (0) or localAudioStreamStateRecording (1). This method is different from the muteLocalAudioStream method:
  /// enableLocalAudio: Disables/Re-enables the local audio capturing and processing. If you disable or re-enable local audio capturing using the enableLocalAudio method, the local user might hear a pause in the remote audio playback.
  /// muteLocalAudioStream: Sends/Stops sending the local audio streams. You can call this method either before or after joining a channel. Calling it before joining a channel only sets the device state, and it takes effect immediately after you join the channel.
  ///
  /// * [enabled]  true: (Default) Re-enable the local audio function, that is, to start the local audio capturing device (for example, the microphone).
  ///  false: Disable the local audio function, that is, to stop local audio capturing. None
  Future<void> enableLocalAudio(bool enabled);

  /// Stops or resumes publishing the local audio stream.
  /// This method does not affect any ongoing audio recording, because it does not disable the audio capture device.
  ///
  /// * [mute] Whether to stop publishing the local audio stream.
  ///  true: Stop publishing the local audio stream.
  ///  false: (Default) Resumes publishing the local audio stream. None
  Future<void> muteLocalAudioStream(bool mute);

  /// Stops or resumes subscribing to the audio streams of all remote users.
  /// After successfully calling this method, the local user stops or resumes subscribing to the audio streams of all remote users, including all subsequent users. Call this method after joining a channel.
  ///
  /// * [mute] Whether to stop subscribing to the audio streams of all remote users:
  ///  true: Stop subscribing to the audio streams of all remote users.
  ///  false: (Default) Subscribe to the audio streams of all remote users by default. None
  Future<void> muteAllRemoteAudioStreams(bool mute);

  /// Stops or resumes subscribing to the audio streams of all remote users by default.
  /// Call this method after joining a channel. After successfully calling this method, the local user stops or resumes subscribing to the audio streams of all subsequent users. If you need to resume subscribing to the audio streams of remote users in the channel after calling this method, do the following:
  /// To resume subscribing to the audio stream of a specified user, call muteRemoteAudioStream (false), and specify the user ID.
  /// To resume subscribing to the audio streams of multiple remote users, call muteRemoteAudioStream(false) multiple times.
  ///
  /// * [mute] Whether to stop subscribing to the audio streams of all remote users by default.
  ///  true: Stop subscribing to the audio streams of all remote users by default.
  ///  false: (Default) Subscribe to the audio streams of all remote users by default. None
  Future<void> setDefaultMuteAllRemoteAudioStreams(bool mute);

  /// Cancels or resumes subscribing to the specified remote user's audio stream.
  /// Call this method after joining a channel.
  ///
  /// * [uid] The user ID of the specified user.None
  ///
  /// * [mute] Whether to stop subscribing to the audio stream of the specified user. true: Unsubscribe from the specified user's audio stream.
  ///  false: (Default) Subscribes to the specified user's audio stream. None
  Future<void> muteRemoteAudioStream({required int uid, required bool mute});

  /// Stops or resumes publishing the local video stream.
  /// A successful call of this method triggers the onUserMuteVideo callback on the remote client. This method executes faster than the enableLocalVideo (false) method, which controls the sending of the local video stream.
  /// This method does not affect any ongoing video recording, because it does not disable the camera.
  ///
  /// * [mute] Whether to stop publishing the local video stream.
  ///  true: Stop publishing the local video stream.
  ///  false: (Default) Publish the local video stream. None
  Future<void> muteLocalVideoStream(bool mute);

  /// Enables/Disables the local video capture.
  /// This method disables or re-enables the local video capturer, and does not affect receiving the remote video stream.
  /// After calling enableVideo , the local video capturer is enabled by default. You can call enableLocalVideo (false) to disable the local video capturer. If you want to re-enable the local video, call enableLocalVideo(true).
  /// After the local video capturer is successfully disabled or re-enabled, the SDK triggers the onRemoteVideoStateChanged callback on the remote client. You can call this method either before or after joining a channel.
  /// This method enables the internal engine and is valid after leaving the channel.
  ///
  /// * [enabled] Whether to enable the local video capture. true: (Default) Enable the local video capture.
  ///  false: Disables the local video capture. Once the local video is disabled, the remote users can no longer receive the video stream of this user, while this user can still receive the video streams of the other remote users. falseWhen set to , this method does not require a local camera.None
  Future<void> enableLocalVideo(bool enabled);

  /// Stops or resumes subscribing to the video streams of all remote users.
  /// After successfully calling this method, the local user stops or resumes subscribing to the audio streams of all remote users, including all subsequent users. Call this method after joining a channel.
  ///
  /// * [mute] Whether to stop subscribing to the video streams of all remote users.
  ///  true: Stop subscribing to the video streams of all remote users.
  ///  false: (Default) Subscribe to the audio streams of all remote users by default. None
  Future<void> muteAllRemoteVideoStreams(bool mute);

  /// Stops or resumes subscribing to the video streams of all remote users by default.
  /// Call this method after joining a channel. After successfully calling this method, the local user stops or resumes subscribing to the audio streams of all subsequent users. If you need to resume subscribing to the audio streams of remote users in the channel after calling this method, do the following:
  /// To resume subscribing to the audio stream of a specified user, call muteRemoteVideoStream (false), and specify the user ID.
  /// To resume subscribing to the audio streams of multiple remote users, call muteRemoteVideoStream(false) multiple times.
  ///
  /// * [mute] Whether to stop subscribing to the audio streams of all remote users by default.
  ///  true: Stop subscribing to the audio streams of all remote users by default.
  ///  false: (Default) Resume subscribing to the audio streams of all remote users by default. None
  Future<void> setDefaultMuteAllRemoteVideoStreams(bool mute);

  /// Cancels or resumes subscribing to the specified remote user's video stream.
  /// Call this method after joining a channel.
  ///
  /// * [uid] The user ID of the specified user.None
  ///
  /// * [mute] Whether to subscribe to the specified remote user's video stream.
  ///  true: Unsubscribe from the specified user's video stream.
  ///  false: (Default) Subscribes to the specified user's video stream. None
  Future<void> muteRemoteVideoStream({required int uid, required bool mute});

  /// Sets the stream type of the remote video.
  /// Under limited network conditions, if the publisher has not disabled the dual-stream mode using enableDualStreamMode (false), the receiver can choose to receive either the high-quality video stream (the high resolution, and high bitrate video stream) or the low-quality video stream (the low resolution, and low bitrate video stream). The high-quality video stream has a higher resolution and bitrate, and the low-quality video stream has a lower resolution and bitrate.
  /// By default, users receive the high-quality video stream. Call this method if you want to switch to the low-quality video stream. This method allows the app to adjust the corresponding video stream type based on the size of the video window to reduce the bandwidth and resources. The aspect ratio of the low-quality video stream is the same as the high-quality video stream. Once the resolution of the high-quality video stream is set, the system automatically sets the resolution, frame rate, and bitrate of the low-quality video stream.
  /// The method result returns in the onApiCallExecuted callback.
  /// You can call this method either before or after joining a channel. If you call both setRemoteVideoStreamType and setRemoteDefaultVideoStreamType , the setting of setRemoteVideoStreamType takes effect.
  ///
  /// * [uid] The user ID.None
  ///
  /// * [streamType] The video stream type: VideoStreamType .None
  Future<void> setRemoteVideoStreamType(
      {required int uid, required VideoStreamType streamType});

  /// Sets the default video-stream type of the remotely subscribed video stream when the remote user sends dual streams.
  /// Under limited network conditions, if the publisher has not disabled the dual-stream mode using enableDualStreamMode (false), the receiver can choose to receive either the high-quality video stream or the low-quality video stream. The high-quality video stream has a higher resolution and bitrate, and the low-quality video stream has a lower resolution and bitrate.
  /// By default, users receive the high-quality video stream. Call this method if you want to switch to the low-quality video stream. This method allows the app to adjust the corresponding video stream type based on the size of the video window to reduce the bandwidth and resources. The aspect ratio of the low-quality video stream is the same as the high-quality video stream. Once the resolution of the high-quality video stream is set, the system automatically sets the resolution, frame rate, and bitrate of the low-quality video stream.
  /// The result of this method is returned in the onApiCallExecuted callback. Call this method before joining a channel. Agora does not support you to change the default subscribed video stream type after joining a channel.
  /// If you call both this method and setRemoteVideoStreamType , the SDK applies the settings in the setRemoteVideoStreamType method.
  ///
  /// * [streamType] The default video-stream type, see VideoStreamType .None
  Future<void> setRemoteDefaultVideoStreamType(VideoStreamType streamType);

  /// Enables the reporting of users' volume indication.
  /// This method enables the SDK to regularly report the volume information of the local user who sends a stream and remote users (up to three) whose instantaneous volumes are the highest to the app. Once you call this method and users send streams in the channel, the SDK triggers the onAudioVolumeIndication callback at the time interval set in this method.
  /// You can call this method either before or after joining a channel.
  ///
  /// * [interval] Sets the time interval between two consecutive volume indications:
  ///  ≤ 0: Disables the volume indication.
  ///  > 0: Time interval (ms) between two consecutive volume indications. You need to set this parameter to an integer multiple of 200. If the value is lower than 200, the SDK automatically adjusts the value to 200.None
  ///
  /// * [smooth] The smoothing factor sets the sensitivity of the audio volume indicator. The value ranges between 0 and 10. The recommended value is 3. The greater the value, the more sensitive the indicator.None
  ///
  /// * [reportVad] true: Enable the voice activity detection of the local user. Once it is enabled,the vad parameter of the onAudioVolumeIndication callback reports the voice activity status of the local user.
  ///  false: (Default) Disable the voice activity detection of the local user. Once it is disabled, the vad parameter of the onAudioVolumeIndication callbackdoes not report the voice activity status of the local user, except for the scenario where the engine automatically detects the voice activity of the local user.None
  Future<void> enableAudioVolumeIndication(
      {required int interval, required int smooth, required bool reportVad});

  /// Stops the audio recording on the client.
  Future<void> stopAudioRecording();

  /// Creates a media player instance.
  ///
  /// ## Return
  /// The MediaPlayer instance, if the method call succeeds.
  /// An empty pointer, if the method call fails.
  Future<MediaPlayer> createMediaPlayer();

  /// Destroys the media player instance.
  Future<void> destroyMediaPlayer(MediaPlayer mediaPlayer);

  /// Stops playing and mixing the music file.
  /// This method stops the audio mixing. Call this method when you are in a channel.
  Future<void> stopAudioMixing();

  /// Pauses playing the music file.
  /// Call this method after joining a channel.
  Future<void> pauseAudioMixing();

  /// Resumes playing and mixing the music file.
  /// This method resumes playing and mixing the music file. Call this method when you are in a channel.
  Future<void> resumeAudioMixing();

  /// Adjusts the volume during audio mixing.
  /// This method adjusts the audio mixing volume on both the local client and remote clients. Call this method after the startAudioMixing method.
  ///
  /// * [volume] Audio mixing volume. The value ranges between 0 and 100. The default value is 100, the original volume.None
  Future<void> adjustAudioMixingVolume(int volume);

  /// Adjusts the volume of audio mixing for publishing.
  /// This method adjusts the audio mixing volume on the remote clients. Call this method after calling startAudioMixing and receiving the onAudioMixingStateChanged(audioMixingStatePlaying) callback.
  ///
  /// * [volume] The volume of audio mixing for local playback. The value ranges between 0 and 100 (default). 100 represents the original volume.None
  Future<void> adjustAudioMixingPublishVolume(int volume);

  /// Retrieves the audio mixing volume for publishing.
  /// This method helps troubleshoot audio volume‑related issues.
  /// You need to call this method after calling startAudioMixing and receiving the onAudioMixingStateChanged(audioMixingStatePlaying) callback.
  ///
  /// ## Return
  /// ≥ 0: The audio mixing volume, if this method call succeeds. The value range is [0,100].
  /// < 0: Failure.
  Future<int> getAudioMixingPublishVolume();

  /// Adjusts the volume of audio mixing for local playback.
  /// Call this method after calling startAudioMixing and receiving the onAudioMixingStateChanged(audioMixingStatePlaying) callback.
  ///
  /// * [volume] The volume of audio mixing for local playback. The value ranges between 0 and 100 (default). 100 represents the original volume.None
  Future<void> adjustAudioMixingPlayoutVolume(int volume);

  /// Retrieves the audio mixing volume for local playback.
  /// This method retrieves the audio mixing volume for local playback. You can use it to troubleshoot audio volume related issues. You need to call this method after calling startAudioMixing and receiving the onAudioMixingStateChanged(audioMixingStatePlaying) callback.
  ///
  /// ## Return
  /// ≥ 0: The audio mixing volume, if this method call succeeds. The value range is [0,100].
  /// < 0: Failure.
  Future<int> getAudioMixingPlayoutVolume();

  /// Retrieves the duration (ms) of the music file.
  /// Retrieves the total duration (ms) of the audio. You need to call this method after calling startAudioMixing and receiving the onAudioMixingStateChanged (audioMixingStatePlaying) callback.
  ///
  /// ## Return
  /// ≥ 0: The audio mixing duration, if this method call succeeds.
  /// < 0: Failure.
  Future<int> getAudioMixingDuration();

  /// Retrieves the playback position (ms) of the music file.
  /// This method retrieves the playback position (ms) of the current music file. You need to call this method after calling startAudioMixing and receiving the onAudioMixingStateChanged(audioMixingStatePlaying) callback.
  /// If you need to call getAudioMixingCurrentPosition multiple times, ensure that the call interval is longer than 500 ms.
  ///
  /// ## Return
  /// ≥ 0: The current playback position (ms) of the audio mixing, if this method call succeeds. 0 represents that the current music file does not start playing.
  /// < 0: Failure.
  Future<int> getAudioMixingCurrentPosition();

  /// Sets the audio mixing position.
  /// Call this method to set the playback position of the music file to a different starting position, rather than playing the file from the beginning.
  /// You need to call this method after calling startAudioMixing and receiving the onAudioMixingStateChanged(audioMixingStatePlaying) callback.
  ///
  /// * [pos] Integer. The playback position (ms).None
  Future<void> setAudioMixingPosition(int pos);

  /// Sets the pitch of the local music file.
  /// When a local music file is mixed with a local human voice, call this method to set the pitch of the local music file only.
  /// You need to call this method after calling startAudioMixing and receiving the onAudioMixingStateChanged(audioMixingStatePlaying) callback.
  ///
  /// * [pitch] Sets the pitch of the local music file by the chromatic scale. The default value is 0, which means keeping the original pitch. The value ranges from -12 to 12, and the pitch value between consecutive values is a chromatic value. The greater the absolute value of this parameter, the higher or lower the pitch of the local music file.None
  Future<void> setAudioMixingPitch(int pitch);

  /// Retrieves the volume of the audio effects.
  /// The volume range is [0,100]. The default value is 100, the original volume.
  /// Call this method after the playEffect method.
  ///
  /// ## Return
  /// Volume of the audio effects, if this method call succeeds.
  /// < 0: Failure.
  Future<int> getEffectsVolume();

  /// Sets the volume of the audio effects.
  /// Call this method after the playEffect method.
  ///
  /// * [volume] The playback volume. The value range is [0, 100]. The default value is 100, which represents the original volume.None
  Future<void> setEffectsVolume(int volume);

  /// Preloads a specified audio effect file into the memory.
  /// To ensure smooth communication, limit the size of the audio effect file. Wer ecommend using this method to preload the audio effect before calling joinChannelWithOptions. This method does not support online audio effect files.
  /// For the audio file formats supported by this method, see What formats of audio files the Agora RTC SDK support.
  ///
  /// * [soundId] The audio effect ID. The ID of each audio effect file is unique.None
  ///
  /// * [filePath] File path:
  ///  Android: The file path, which needs to be accurate to the file name and suffix. Agora supports using a URI address, an absolute path, or a path that starts with /assets/. You might encounter permission issues if you use an absolute path to access a local file, so Agora recommends using a URI address instead. For example: content://com.android.providers.media.documents/document/audio%3A14441
  ///  Windows: The absolute path or URL address (including the suffixes of the filename) of the audio effect file. For example: C:\music\audio.mp4.
  ///  iOS or macOS: The absolute path or URL address (including the suffixes of the filename) of the audio effect file. For example: /var/mobile/Containers/Data/audio.mp4.None
  ///
  /// * [startPos] The playback position (ms) of the audio effect file.None
  Future<void> preloadEffect(
      {required int soundId, required String filePath, int startPos = 0});

  /// Plays the specified local or online sound effect file.
  /// To play multiple audio effect files at the same time, call this method multiple times with different soundId and filePath. For the best user experience, Agora recommends playing no more than three audio effect files at the same time. After the playback of an audio effect file completes, the SDK triggers the onAudioEffectFinished callback.Call this method after joining a channel.
  ///
  /// * [soundId] The audio effect ID. The ID of each audio effect file is unique.If you have loaded the audio effect into memory via preloadEffect , make sure this parameter is the same as the soundId set in preloadEffect. None
  ///
  /// * [filePath] Windows: The absolute path or URL address (including the suffixes of the filename) of the audio effect file. For example: C:\music\audio.mp4. Supported audio formats include MP3, AAC, M4A, MP4, WAV, and 3GP. See supported audio formats.
  ///  If you have loaded the audio effect into memory via preloadEffect , make sure this parameter is the same as the filePath set in preloadEffect. None
  ///
  /// * [loopCount] The number of times the audio effect loops.
  ///  ≥ 0: The number of playback times. For example, 1 means loop one time, which means playing the audio effect two times in total.
  ///  -1: Play the music file in an infinite loop. None
  ///
  /// * [pitch] The pitch of the audio effect. The value range is 0.5 to 2.0. The default value is 1.0, which means the original pitch. The lower the value, the lower the pitch.None
  ///
  /// * [pan] The spatial position of the audio effect. The value ranges between -1.0 and 1.0, where:
  ///  -1.0: The audio effect displays to the left.
  ///  0.0: The audio effect displays ahead.
  ///  1.0: The audio effect displays to the right. None
  ///
  /// * [gain] The volume of the audio effect. The value range is 0.0 to 100.0. The default value is 100.0, which means the original volume. The smaller the value, the lower the volume.None
  ///
  /// * [publish] Whether to publish the audio effect to the remote users.
  ///  true: Publish the audio effect to the remote users. Both the local user and remote users can hear the audio effect.
  ///  false: Do not publish the audio effect to the remote users. Only the local user can hear the audio effect. None
  ///
  /// * [startPos] The playback position (ms) of the audio effect file.None
  Future<void> playEffect(
      {required int soundId,
      required String filePath,
      required int loopCount,
      required double pitch,
      required double pan,
      required int gain,
      bool publish = false,
      int startPos = 0});

  /// Plays all audio effects.
  /// After calling preloadEffect multiple times to preload multiple audio effects into the memory, you can call this method to play all the specified audio effects for all users in the channel.
  ///
  /// * [loopCount] The number of times the audio effect loops:
  ///  -1: Play the audio effect in an indefinite loop until you call stopEffect or stopAllEffects .
  ///  0: Play the audio effect once.
  ///  1: Play the audio effect twice.None
  ///
  /// * [pitch] The pitch of the audio effect. The value ranges between 0.5 and 2.0. The default value is 1.0 (original pitch). The lower the value, the lower the pitch.None
  ///
  /// * [pan] The spatial position of the audio effect. The value ranges between -1.0 and 1.0:
  ///  -1.0: The audio effect shows on the left.
  ///  0: The audio effect shows ahead.
  ///  1.0: The audio effect shows on the right.None
  ///
  /// * [gain] The volume of the audio effect. The value range is [0, 100]. The default value is 100 (original volume). The smaller the value, the lower the volume.None
  ///
  /// * [publish] Whether to publish the audio effect to the remote users:
  ///  true: Publish the audio effect to the remote users. Both the local user and remote users can hear the audio effect.
  ///  false: Do not publish the audio effect to the remote users. Only the local user can hear the audio effect.None
  Future<void> playAllEffects(
      {required int loopCount,
      required double pitch,
      required double pan,
      required int gain,
      bool publish = false});

  /// Gets the volume of a specified audio effect.
  ///
  /// * [soundId] The ID of the audio effect.None
  ///
  /// ## Return
  /// ≥ 0: The volume of the specified audio effect, if the method call succeeds. The value range is [0,100]. 100 represents the original volume.
  /// < 0: Failure.
  Future<int> getVolumeOfEffect(int soundId);

  /// Sets the volume of a specified audio effect.
  ///
  /// * [soundId] The audio effect ID. The ID of each audio effect file is unique.None
  ///
  /// * [volume] The playback volume. The value range is [0, 100]. The default value is 100, which represents the original volume.None
  Future<void> setVolumeOfEffect({required int soundId, required int volume});

  /// Pauses playing a specified audio effect file.
  ///
  /// * [soundId] The audio effect ID. The ID of each audio effect file is unique.None
  Future<void> pauseEffect(int soundId);

  /// Pauses playing all audio effect files.
  Future<void> pauseAllEffects();

  /// Resumes playing a specified audio effect.
  ///
  /// * [soundId] The audio effect ID. The ID of each audio effect file is unique.None
  Future<void> resumeEffect(int soundId);

  /// Resumes playing all audio effects.
  Future<void> resumeAllEffects();

  /// Stops playing a specified audio effect.
  ///
  /// * [soundId] The audio effect ID. The ID of each audio effect file is unique.None
  Future<void> stopEffect(int soundId);

  /// Stops playing all audio effects.
  Future<void> stopAllEffects();

  /// Releases a specified preloaded audio effect from the memory.
  ///
  /// * [soundId] The audio effect ID. The ID of each audio effect file is unique.None
  Future<void> unloadEffect(int soundId);

  /// Releases a specified preloaded audio effect from the memory.
  Future<void> unloadAllEffects();

  /// Enables/Disables stereo panning for remote users.
  /// Ensure that you call this method before joining a channel to enable stereo panning for remote users so that the local user can track the position of a remote user by calling setRemoteVoicePosition.
  ///
  /// * [enabled] Whether to enable stereo panning for remote users:
  ///  true: Enable stereo panning.
  ///  false: Disable stereo panning.None
  Future<void> enableSoundPositionIndication(bool enabled);

  /// Sets the 2D position (the position on the horizontal plane) of the remote user's voice.
  /// This method sets the 2D position and volume of a remote user, so that the local user can easily hear and identify the remote user's position.
  /// When the local user calls this method to set the voice position of a remote user, the voice difference between the left and right channels allows the local user to track the real-time position of the remote user, creating a sense of space. This method applies to massive multiplayer online games, such as Battle Royale games. For this method to work, enable stereo panning for remote users by calling the enableSoundPositionIndication method before joining a channel.
  /// For the best voice positioning, Agora recommends using a wired headset.
  /// Call this method after joining a channel.
  ///
  /// * [uid] The user ID of the remote user.None
  ///
  /// * [pan] The voice position of the remote user. The value ranges from -1.0 to 1.0:
  ///  0.0: (Default) The remote voice comes from the front.
  ///  -1.0: The remote voice comes from the left.
  ///  1.0: The remote voice comes from the right.None
  ///
  /// * [gain] The volume of the remote user. The value ranges from 0.0 to 100.0. The default value is 100.0 (the original volume of the remote user). The smaller the value, the lower the volume.None
  Future<void> setRemoteVoicePosition(
      {required int uid, required double pan, required double gain});

  /// @nodoc
  Future<void> enableSpatialAudio(bool enabled);

  /// @nodoc
  Future<void> setRemoteUserSpatialAudioParams(
      {required int uid, required SpatialAudioParams params});

  /// Sets a preset voice beautifier effect.
  /// Call this method to set a preset voice beautifier effect for the local user who sends an audio stream. After setting a voice beautifier effect, all users in the channel can hear the effect. You can set different voice beautifier effects for different scenarios.
  /// For better voice effects, Agora recommends that you call setAudioProfile and set scenario to audioScenarioGameStreaming(3) and profile to audioProfileMusicHighQuality(4) or audioProfileMusicHighQualityStereo(5) before calling this method. You can call this method either before or after joining a channel.
  /// Do not set the profile parameter in setAudioProfile to audioProfileSpeechStandard(1) or audioProfileIot(6), or the method does not take effect.
  /// This method works best with the human voice. Agora does not recommend using this method for audio containing music.
  /// After calling setVoiceBeautifierPreset , Agora recommends not calling the following methods, because they can override settings in setVoiceBeautifierPreset:
  /// setAudioEffectPreset
  /// setAudioEffectParameters
  /// setLocalVoicePitch
  /// setLocalVoiceEqualization
  /// setLocalVoiceReverb
  /// setVoiceBeautifierParameters
  /// setVoiceConversionPreset
  ///
  /// * [preset] The preset voice beautifier effect options: VoiceBeautifierPreset .None
  Future<void> setVoiceBeautifierPreset(VoiceBeautifierPreset preset);

  /// Sets an SDK preset audio effect.
  /// Call this method to set an SDK preset audio effect for the local user who sends an audio stream. This audio effect does not change the gender characteristics of the original voice. After setting an audio effect, all users in the channel can hear the effect.
  /// To get better audio effect quality, Agora recommends calling and setting scenario in setAudioProfile as audioScenarioGameStreaming(3) before calling this method. You can call this method either before or after joining a channel.
  /// Do not set the profile parameter in setAudioProfile to audioProfileSpeechStandard(1)audioProfileIot or (6), or the method does not take effect.
  /// This method works best with the human voice. Agora does not recommend using this method for audio containing music.
  /// If you call setAudioEffectPreset, you need to set preset as roomAcoustics3dVoice or pitchCorrection, and do not call setAudioEffectParameters ; otherwise, setAudioEffectPreset is overridden.
  /// After calling setAudioEffectPreset, Agora recommends not calling the following methods, or the settings in setAudioEffectPreset are overridden:
  /// setVoiceBeautifierPreset
  /// setLocalVoicePitch
  /// setLocalVoiceEqualization
  /// setLocalVoiceReverb
  /// setVoiceBeautifierParameters
  /// setVoiceConversionPreset
  ///
  /// * [preset] The options for SDK preset audio effects. See AudioEffectPreset .None
  Future<void> setAudioEffectPreset(AudioEffectPreset preset);

  /// Sets a preset voice beautifier effect.
  /// Call this method to set a preset voice beautifier effect for the local user who sends an audio stream. After setting an audio effect, all users in the channel can hear the effect. You can set different voice beautifier effects for different scenarios.
  /// To achieve better audio effect quality, Agora recommends that you call setAudioProfile and set the profile to audioProfileMusicHighQuality(4) or audioProfileMusicHighQualityStereo(5) and scenario to audioScenarioGameStreaming(3) before calling this method. You can call this method either before or after joining a channel.
  /// Do not set the profile parameter in setAudioProfile to audioProfileSpeechStandard(1) or audioProfileIot(6), or the method does not take effect.
  /// This method works best with the human voice. Agora does not recommend using this method for audio containing music.
  /// After calling setVoiceConversionPreset , Agora recommends not calling the following methods, or the settings in setVoiceConversionPreset are overridden:
  /// setAudioEffectPreset
  /// setAudioEffectParameters
  /// setVoiceBeautifierPreset
  /// setVoiceBeautifierParameters
  /// setLocalVoicePitch
  /// setLocalVoiceEqualization
  /// setLocalVoiceReverb
  ///
  /// * [preset] The options for the preset voice beautifier effects: VoiceConversionPreset .None
  Future<void> setVoiceConversionPreset(VoiceConversionPreset preset);

  /// Sets parameters for SDK preset audio effects.
  /// Call this method to set the following parameters for the local user who sends an audio stream:
  /// 3D voice effect: Sets the cycle period of the 3D voice effect.
  /// Pitch correction effect: Sets the basic mode and tonic pitch of the pitch correction effect. Different songs have different modes and tonic pitches. Agora recommends bounding this method with interface elements to enable users to adjust the pitch correction interactively. After setting the audio parameters, all users in the channel can hear the effect. You can call this method either before or after joining a channel.
  /// To get better audio effect quality, Agora recommends calling and setting scenario in setAudioProfile as audioScenarioGameStreaming(3) before calling this method.
  /// Do not set the profile parameter in setAudioProfile to audioProfileSpeechStandard(1)audioProfileIot or (6), or the method does not take effect.
  /// This method works best with the human voice. Agora does not recommend using this method for audio containing music.
  /// After calling setAudioEffectParameters, Agora recommends not calling the following methods, or the settings in setAudioEffectParameters are overridden:
  /// setAudioEffectPreset
  /// setVoiceBeautifierPreset
  /// setLocalVoicePitch
  /// setLocalVoiceEqualization
  /// setLocalVoiceReverb
  /// setVoiceBeautifierParameters
  /// setVoiceConversionPreset
  ///
  /// * [preset] The options for SDK preset audio effects:
  ///  roomAcoustics3dVoice, 3D voice effect:
  ///  You need to set the profile parameter in setAudioProfile to audioProfileMusicStandardStereo(3) or audioProfileMusicHighQualityStereo(5) before setting this enumerator; otherwise, the enumerator setting does not take effect.
  ///  If the 3D voice effect is enabled, users need to use stereo audio playback devices to hear the anticipated voice effect. pitchCorrection, Pitch correction effect: To achieve better audio effect quality, Agora recommends setting the profile parameter in setAudioProfile to audioProfileMusicHighQuality(4) or audioProfileMusicHighQualityStereo(5) before setting this enumerator.None
  ///
  /// * [param1] If you set preset to roomAcoustics3dVoice , param1 indicates the cycle period of the 3D voice effect. The value range is [1,60], in seconds. The default value is 10, indicating that the voice moves around you every 10 seconds.
  ///  If you set preset to pitchCorrection , param1 indicates the basic mode of the pitch correction effect:
  ///  1: (Default) Natural major scale.
  ///  2: Natural minor scale.
  ///  3: Japanese pentatonic scale. None
  ///
  /// * [param2] If you set preset to roomAcoustics3dVoice, you need to set param2 to 0.
  ///  If you set preset to pitchCorrection, param2 indicates the tonic pitch of the pitch correction effect:
  ///  1: A
  ///  2: A#
  ///  3: B
  ///  4: (Default) C
  ///  5: C#
  ///  6: D
  ///  7: D#
  ///  8: E
  ///  9: F
  ///  10: F#
  ///  11: G
  ///  12: G# None
  Future<void> setAudioEffectParameters(
      {required AudioEffectPreset preset,
      required int param1,
      required int param2});

  /// Sets parameters for the preset voice beautifier effects.
  /// Call this method to set a gender characteristic and a reverberation effect for the singing beautifier effect. This method sets parameters for the local user who sends an audio stream. After setting the audio parameters, all users in the channel can hear the effect.
  /// For better voice effects, Agora recommends that you call setAudioProfile and set scenario to audioScenarioGameStreaming(3) and profile to audioProfileMusicHighQuality(4) or audioProfileMusicHighQualityStereo(5) before calling this method. You can call this method either before or after joining a channel.
  /// Do not set the profile parameter in setAudioProfile to audioProfileSpeechStandard(1) or audioProfileIot(6), or the method does not take effect.
  /// This method works best with the human voice. Agora does not recommend using this method for audio containing music.
  /// After calling setVoiceBeautifierParameters, Agora recommends not calling the following methods, because they can override settings in setVoiceBeautifierParameters:
  /// setAudioEffectPreset
  /// setAudioEffectParameters
  /// setVoiceBeautifierPreset
  /// setLocalVoicePitch
  /// setLocalVoiceEqualization
  /// setLocalVoiceReverb
  /// setVoiceConversionPreset
  ///
  /// * [preset] The option for the preset audio effect:
  ///  SINGING_BEAUTIFIER: The singing beautifier effect.None
  ///
  /// * [param1] The gender characteristics options for the singing voice:
  ///  1: A male-sounding voice.
  ///  2: A female-sounding voice.None
  ///
  /// * [param2] The reverberation effect options for the singing voice:
  ///  1: The reverberation effect sounds like singing in a small room.
  ///  2: The reverberation effect sounds like singing in a large room.
  ///  3: The reverberation effect sounds like singing in a hall.None
  Future<void> setVoiceBeautifierParameters(
      {required VoiceBeautifierPreset preset,
      required int param1,
      required int param2});

  /// @nodoc
  Future<void> setVoiceConversionParameters(
      {required VoiceConversionPreset preset,
      required int param1,
      required int param2});

  /// Changes the voice pitch of the local speaker.
  /// You can call this method either before or after joining a channel.
  ///
  /// * [pitch] The local voice pitch. The value range is [0.5,2.0]. The lower the value, the lower the pitch. The default value is 1 (no change to the pitch).None
  Future<void> setLocalVoicePitch(double pitch);

  /// Sets the local voice equalization effect.
  /// You can call this method either before or after joining a channel.
  ///
  /// * [bandFrequency] The band frequency. The value ranges between 0 and 9; representing the respective 10-band center frequencies of the voice effects, including 31, 62, 125, 250, 500, 1k, 2k, 4k, 8k, and 16k Hz. None
  ///
  /// * [bandGain] The gain of each band in dB. The value ranges between -15 and 15. The default value is 0.None
  Future<void> setLocalVoiceEqualization(
      {required AudioEqualizationBandFrequency bandFrequency,
      required int bandGain});

  /// Sets the local voice reverberation.
  /// The SDK provides an easier-to-use method, setAudioEffectPreset , to directly implement preset reverb effects for such as pop, R&B, and KTV.
  /// You can call this method either before or after joining a channel.
  ///
  /// * [reverbKey] The reverberation key. Agora provides five reverberation keys, see AudioReverbType .None
  ///
  /// * [value] The value of the reverberation key.None
  Future<void> setLocalVoiceReverb(
      {required AudioReverbType reverbKey, required int value});

  /// Set the log file
  /// Deprecated:
  /// Use the mLogConfig parameter in initialize method instead. Specifies an SDK output log file. The log file records all log data for the SDK’s operation. Ensure that the directory for the log file exists and is writable. Ensure that you call this method immediately after calling the RtcEngine initialize method, or the output log may not be complete.
  ///
  /// * [filePath] The complete path of the log files. These log files are encoded in UTF-8.None
  Future<void> setLogFile(String filePath);

  /// Sets the log output level of the SDK.
  /// Deprecated:
  /// Use logConfig in initialize instead. This method sets the output log level of the SDK. You can use one or a combination of the log filter levels. The log level follows the sequence of logFilterOff, logFilterCritical, logFilterError, logFilterWarn, logFilterInfo, and logFilterDebug. Choose a level to see the logs preceding that level.
  /// If, for example, you set the log level to logFilterWarn, you see the logs within levels logFilterCritical, logFilterError, and logFilterWarn.
  ///
  /// * [filter] The output log level of the SDK. See LogFilterType .None
  Future<void> setLogFilter(LogFilterType filter);

  /// Sets the output log level of the SDK.
  /// Deprecated:
  /// This method is deprecated. Use RtcEngineContext instead to set the log output level. Choose a level to see the logs preceding that level.
  ///
  /// * [level] The log level: LogLevel .None
  Future<void> setLogLevel(LogLevel level);

  /// Sets the log file size.
  /// Deprecated:
  /// Use the logConfig parameter in initialize instead. By default, the SDK generates five SDK log files and five API call log files with the following rules: The SDK log files are: agorasdk.log, agorasdk.1.log, agorasdk.2.log, agorasdk.3.log, and agorasdk.4.log.
  /// The API call log files are: agoraapi.log, agoraapi.1.log, agoraapi.2.log, agoraapi.3.log, and agoraapi.4.log.
  /// The default size for each SDK log file is 1,024 KB; the default size for each API call log file is 2,048 KB. These log files are encoded in UTF-8.
  /// The SDK writes the latest logs in agorasdk.log or agoraapi.log.
  /// When agorasdk.log is full, the SDK processes the log files in the following order:
  /// Delete the agorasdk.4.log file (if any).
  /// Rename agorasdk.3.log to agorasdk.4.log.
  /// Rename agorasdk.2.log to agorasdk.3.log.
  /// Rename agorasdk.1.log to agorasdk.2.log.
  /// Create a new agorasdk.log file. The overwrite rules for the agoraapi.log file are the same as for agorasdk.log. This method is used to set the size of the agorasdk.log file only and does not effect the agoraapi.log file.
  ///
  /// * [fileSizeInKBytes] The size (KB) of an agorasdk.log file. The value range is [128,20480]. The default value is 1,024 KB. If you set fileSizeInKByte smaller than 128 KB, the SDK automatically adjusts it to 128 KB; if you set fileSizeInKByte greater than 20,480 KB, the SDK automatically adjusts it to 20,480 KB.None
  Future<void> setLogFileSize(int fileSizeInKBytes);

  /// @nodoc
  Future<void> uploadLogFile(String requestId);

  /// Updates the display mode of the video view of a remote user.
  /// After initializing the video view of a remote user, you can call this method to update its rendering and mirror modes. This method affects only the video view that the local user sees. Please call this method after initializing the remote view by calling the setupRemoteVideo method.
  /// During a call, you can call this method as many times as necessary to update the display mode of the video view of a remote user.
  ///
  /// * [uid] The user ID of the remote user.None
  ///
  /// * [renderMode] The rendering mode of the remote user view. None
  ///
  /// * [mirrorMode] The mirror mode of the remote user view. None
  Future<void> setRemoteRenderMode(
      {required int uid,
      required RenderModeType renderMode,
      required VideoMirrorModeType mirrorMode});

  /// Sets the local video mirror mode.
  /// Deprecated:
  /// This method is deprecated.
  /// Use setupLocalVideo or setLocalRenderMode [2/2] instead.
  ///
  /// * [mirrorMode] The local video mirror mode. See VideoMirrorModeType .None
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

  /// @nodoc
  Future<void> setRecordingAudioFrameParameters(
      {required int sampleRate,
      required int channel,
      required RawAudioFrameOpModeType mode,
      required int samplesPerCall});

  /// @nodoc
  Future<void> setPlaybackAudioFrameParameters(
      {required int sampleRate,
      required int channel,
      required RawAudioFrameOpModeType mode,
      required int samplesPerCall});

  /// @nodoc
  Future<void> setMixedAudioFrameParameters(
      {required int sampleRate,
      required int channel,
      required int samplesPerCall});

  /// @nodoc
  Future<void> setPlaybackAudioFrameBeforeMixingParameters(
      {required int sampleRate, required int channel});

  /// @nodoc
  Future<void> enableAudioSpectrumMonitor({int intervalInMS = 100});

  /// @nodoc
  Future<void> disableAudioSpectrumMonitor();

  /// Adjusts the capturing signal volume.
  /// You can call this method either before or after joining a channel.
  ///
  /// * [volume] The volume of the user. The value range is [0,400].
  ///  0: Mute.
  ///  100: (Default) The original volume.
  ///  400: Four times the original volume (amplifying the audio signals by four times). None
  Future<void> adjustRecordingSignalVolume(int volume);

  /// Whether to mute the recording signal.
  ///
  /// * [mute] true: Mute the recording signal.
  ///  false: (Default) Do not mute the recording signal.None
  Future<void> muteRecordingSignal(bool mute);

  /// Adjusts the playback signal volume of all remote users.
  /// This method adjusts the playback volume that is the mixed volume of all remote users.
  /// You can call this method either before or after joining a channel.
  ///
  /// * [volume] The volume of the user. The value range is [0,400].
  ///  0: Mute.
  ///  100: (Default) The original volume.
  ///  400: Four times the original volume (amplifying the audio signals by four times). None
  Future<void> adjustPlaybackSignalVolume(int volume);

  /// Adjusts the playback signal volume of a specified remote user.
  /// You can call this method to adjust the playback volume of a specified remote user. To adjust the playback volume of different remote users, call the method as many times, once for each remote user. Call this method after joining a channel.
  /// The playback volume here refers to the mixed volume of a specified remote user.
  ///
  /// * [volume] Audio mixing volume. The value ranges between 0 and 100. The default value is 100, the original volume.None
  ///
  /// * [uid] The user ID of the remote user.None
  Future<void> adjustUserPlaybackSignalVolume(
      {required int uid, required int volume});

  /// @nodoc
  Future<void> setLocalPublishFallbackOption(StreamFallbackOptions option);

  /// @nodoc
  Future<void> setRemoteSubscribeFallbackOption(StreamFallbackOptions option);

  /// Enables loopback audio capture.
  /// If you enable loopback audio capture, the output of the sound card is mixed into the audio stream sent to the other end. Applies to the macOS and Windows platforms only.
  /// macOS does not support loopback audio capture of the default sound card. If you need to use this method, use a virtual sound card and pass its name to the deviceName parameter. Agora recommends that you use Soundflower for loopback audio capture.
  /// You can call this method either before or after joining a channel.
  ///
  /// * [enabled] Whether to enable loopback audio capture.
  ///  true: Enable loopback audio capture.
  ///  false: (Default) Disable loopback audio capture.None
  ///
  /// * [deviceName] macOS: The device name of the virtual sound card. The default is set to null, which means the SDK uses Soundflower for loopback audio capture.
  ///  Windows: The device name of the sound card. The default is set to null, which means the SDK uses the sound card of your device for loopback audio capture.None
  Future<void> enableLoopbackRecording(
      {required bool enabled, String? deviceName});

  /// Adjusts the volume of the signal captured by the sound card.
  /// After calling enableLoopbackRecording to enable loopback audio capturing, you can call this method to adjust the volume of the signal captured by the sound card.
  ///
  /// * [volume] Audio mixing volume. The value ranges between 0 and 100. The default value is 100, the original volume.None
  Future<void> adjustLoopbackRecordingVolume(int volume);

  /// @nodoc
  Future<int> getLoopbackRecordingVolume();

  /// Enables in-ear monitoring.
  /// This method enables or disables in-ear monitoring.
  ///
  /// * [enabled] Enables in-ear monitoring.
  ///  true: Enables in-ear monitoring.
  ///  false: (Default) Disables in-ear monitoring.None
  ///
  /// * [includeAudioFilters] None
  ///
  /// ## Return
  /// 0: Success.
  /// < 0: Failure.
  Future<void> enableInEarMonitoring(
      {required bool enabled,
      required EarMonitoringFilterType includeAudioFilters});

  /// Sets the volume of the in-ear monitor.
  /// This method is for Android and iOS only.
  /// Users must use wired earphones to hear their own voices.
  /// You can call this method either before or after joining a channel.
  ///
  /// * [volume] Sets the volume of the in-ear monitor. The value ranges between 0 and 100. The default value is 100.None
  Future<void> setInEarMonitoringVolume(int volume);

  /// Adds an extension to the SDK.
  /// This method applies to Windows only.
  ///
  /// * [path] The extension library path and name. For example: /library/libagora_segmentation_extension.dll.None
  Future<void> loadExtensionProvider(String path);

  /// Sets the properties of the extension provider.
  /// You can call this method to set the attributes of the extension provider and initialize the relevant parameters according to the type of the provider. Call this method after enableExtension , and before enabling the audio ( enableAudio / enableLocalAudio ) or the video ( enableVideo / enableLocalVideo ).
  ///
  /// * [value] The value of the extension key.None
  ///
  /// * [key] The key of the extension.None
  ///
  /// * [provider] The name of the extension provider.None
  Future<void> setExtensionProviderProperty(
      {required String provider, required String key, required String value});

  /// Enables/Disables extensions.
  /// Ensure that you call this method before joining a channel. If you want to enable multiple extensions, you need to call this method multiple times.
  /// The data processing order of different extensions in the SDK is determined by the order in which the extensions are enabled. That is, the extension that is enabled first will process the data first.
  ///
  /// * [extension] The name of the extension.None
  ///
  /// * [provider] The name of the extension provider.None
  ///
  /// * [enable] Whether to enable the extension:
  ///  true: Enable the extension.
  ///  false: Disable the extension. None
  ///
  /// * [type] Type of media source. See MediaSourceType .In this method, this parameter supports only the following two settings:
  ///  The default value is unknownMediaSource.
  ///  If you want to use the second camera to capture video, set this parameter to secondaryCameraSource.None
  ///
  /// ## Return
  /// 0: Success.
  /// < 0: Failure.
  Future<void> enableExtension(
      {required String provider,
      required String extension,
      bool enable = true,
      MediaSourceType type = MediaSourceType.unknownMediaSource});

  /// Sets the properties of the extension.
  /// After enabling the extension, you can call this method to set the properties of the extension.
  ///
  /// * [provider] The name of the extension provider.None
  ///
  /// * [extension] The name of the extension.None
  ///
  /// * [key] The key of the extension.None
  ///
  /// * [value] The value of the extension key.None
  ///
  /// * [type] The type of the video source, see MediaSourceType .None
  Future<void> setExtensionProperty(
      {required String provider,
      required String extension,
      required String key,
      required String value,
      MediaSourceType type = MediaSourceType.unknownMediaSource});

  /// @nodoc
  Future<String> getExtensionProperty(
      {required String provider,
      required String extension,
      required String key,
      required int bufLen,
      MediaSourceType type = MediaSourceType.unknownMediaSource});

  /// Sets the camera capture configuration.
  /// This method is for Android and iOS only.
  /// Call this method before calling joinChannelWithOptions , enableVideo , or enableLocalVideo , depending on which method you use to turn on your local camera.
  ///
  /// * [config] The camera capturer configuration. See CameraCapturerConfiguration .None
  Future<void> setCameraCapturerConfiguration(
      CameraCapturerConfiguration config);

  /// Switches between front and rear cameras.
  /// This method needs to be called after the camera is started (for example, by calling startPreview or joinChannelWithOptions ). This method is for Android and iOS only.
  Future<void> switchCamera();

  /// Checks whether the device supports camera zoom.
  /// This method is for Android and iOS only.
  /// Call this method before calling joinChannelWithOptions , enableVideo , or enableLocalVideo , depending on which method you use to turn on your local camera.
  ///
  /// ## Return
  /// true: The device supports camera zoom.
  /// false: The device does not support camera zoom.
  Future<bool> isCameraZoomSupported();

  /// Checks whether the device camera supports face detection.
  /// This method is for Android only.
  ///
  /// ## Return
  /// true: The device camera supports face detection.
  /// false: The device camera does not support face detection.
  Future<bool> isCameraFaceDetectSupported();

  /// Checks whether the device supports enabling the flash.
  /// This method needs to be called after the camera is started (for example, by calling startPreview or joinChannelWithOptions ). This method is for Android and iOS only.
  /// The app enables the front camera by default. If your front camera does not support enabling the flash, this method returns false. If you want to check whether the rear camera supports enabling the flash, call switchCamera to switch the camera to the rear camera, and then call this method.
  /// On iPads with system version 15, even if isCameraTorchSupported returns true, you might fail to successfully enable the flash by calling setCameraTorchOn due to system issues.
  ///
  /// ## Return
  /// true: The device supports enabling the flash.
  /// false: The device does not support enabling the flash.
  Future<bool> isCameraTorchSupported();

  /// Check whether the device supports the manual focus function.
  /// This method is for Android and iOS only.
  /// Call this method before calling joinChannelWithOptions , enableVideo , or enableLocalVideo , depending on which method you use to turn on your local camera.
  ///
  /// ## Return
  /// true: The device supports the manual focus function.
  /// false: The device does not support the manual focus function.
  Future<bool> isCameraFocusSupported();

  /// Checks whether the device supports the face auto-focus function.
  /// This method is for Android and iOS only.
  /// Call this method before calling joinChannelWithOptions , enableVideo , or enableLocalVideo , depending on which method you use to turn on your local camera.
  ///
  /// ## Return
  /// true: The device supports the face auto-focus function.
  /// false: The device does not support the face auto-focus function.
  Future<bool> isCameraAutoFocusFaceModeSupported();

  /// Set the camera zoom ratio.
  /// This method is for Android and iOS only.
  /// Call this method before calling joinChannelWithOptions , enableVideo , or enableLocalVideo , depending on which method you use to turn on your local camera.
  ///
  /// * [factor] The camera zoom ratio. The value ranges between 1.0 and the maximum zoom supported by the device. You can get the maximum zoom ratio supported by the device by calling the getCameraMaxZoomFactor method.None
  Future<void> setCameraZoomFactor(double factor);

  /// Enables/Disables face detection for the local user.
  /// You can call this method either before or after joining a channel.
  /// This method is for Android and iOS only.
  /// Once face detection is enabled, the SDK triggers the onFacePositionChanged callback toreport the face information of the local user, which includes the following:
  /// The width and height of the local video.
  /// The position of the human face in the local view.
  /// The distance between the human face and the screen. This method needs to be called after the camera is started (for example, by calling startPreview joinChannelWithOptions).
  ///
  /// * [enabled] Whether to enable face detection for the local user:
  ///  true: Enable face detection.
  ///  false: (Default) Disable face detection.None
  Future<void> enableFaceDetection(bool enabled);

  /// Gets the maximum zoom ratio supported by the camera.
  /// This method is for Android and iOS only.
  /// Call this method after enabling the local camera, for example, by calling joinChannelWithOptions , enableVideo , or enableLocalVideo , depending on which method you use to turn on your local camera.
  ///
  /// ## Return
  /// The maximum zoom factor.
  Future<double> getCameraMaxZoomFactor();

  /// Sets the camera manual focus position.
  /// This method needs to be called after the camera is started (for example, by calling startPreview or joinChannelWithOptions ). After a successful method call, the SDK triggers the onCameraFocusAreaChanged callback.
  /// This method is for Android and iOS only.
  ///
  /// * [positionX] The horizontal coordinate of the touchpoint in the view.None
  ///
  /// * [positionY] The vertical coordinate of the touchpoint in the view.None
  Future<void> setCameraFocusPositionInPreview(
      {required double positionX, required double positionY});

  /// Enables the camera flash.
  /// This method is for Android and iOS only.
  /// Call this method before calling joinChannelWithOptions , enableVideo , or enableLocalVideo , depending on which method you use to turn on your local camera.
  ///
  /// * [isOn] Whether to turn on the camera flash:
  ///  true: Turn on the flash.
  ///  false: (Default) Turn off the flash. None
  Future<void> setCameraTorchOn(bool isOn);

  /// Sets whether to enable face autofocus.
  /// By default, the SDK disables face autofocus on Android and enables face autofocus on iOS. To set face autofocus, call this method. This method is for Android and iOS only.
  /// Call this method after the camera is started, such as after joinChannelWithOptions , enableVideo , or enableLocalVideo .
  ///
  /// * [enabled] Whether to enable face autofocus:
  ///  true: Enable face autofocus.
  ///  false: Disable face autofocus. None
  Future<void> setCameraAutoFocusFaceModeEnabled(bool enabled);

  /// Checks whether the device supports manual exposure.
  /// This method is for Android and iOS only.
  /// Call this method before calling joinChannelWithOptions , enableVideo , or enableLocalVideo , depending on which method you use to turn on your local camera.
  ///
  /// ## Return
  /// true: The device supports manual exposure.
  /// false: The device does not support manual exposure.
  Future<bool> isCameraExposurePositionSupported();

  /// Set the camera exposure position.
  /// This method needs to be called after the camera is started (for example, by calling startPreview or joinChannelWithOptions ).
  /// After a successful method call, the SDK triggers the onCameraExposureAreaChanged callback.
  /// This method is for Android and iOS only.
  ///
  /// * [positionXinView] The horizontal coordinate of the touchpoint in the view.None
  ///
  /// * [positionYinView] The vertical coordinate of the touchpoint in the view.None
  Future<void> setCameraExposurePosition(
      {required double positionXinView, required double positionYinView});

  /// Checks whether the device supports auto exposure.
  /// This method applies to iOS only.
  /// Call this method before calling joinChannelWithOptions , enableVideo , or enableLocalVideo , depending on which method you use to turn on your local camera.
  ///
  /// ## Return
  /// true: The device supports auto exposure.
  /// false: The device does not support auto exposure.
  Future<bool> isCameraAutoExposureFaceModeSupported();

  /// Sets whether to enable auto exposure.
  /// This method applies to iOS only.
  /// Call this method before calling joinChannelWithOptions , enableVideo , or enableLocalVideo , depending on which method you use to turn on your local camera.
  ///
  /// * [enabled] Whether to enable auto exposure: true: Enable auto exposure.
  ///  false: Disable auto exposure. None
  Future<void> setCameraAutoExposureFaceModeEnabled(bool enabled);

  /// Sets the default audio playback route
  /// This method is for Android and iOS only. Most mobile phones have two audio routes: an earpiece at the top, and a speakerphone at the bottom. The earpiece plays at a lower volume, and the speakerphone at a higher volume. When setting the default audio route, you determine whether audio playback comes through the earpiece or speakerphone when no external audio device is connected.
  ///
  /// * [defaultToSpeaker] Whether to set the speakerphone as the default audio route:
  ///  true: Set the speakerphone as the default audio route.
  ///  false: Set the earpiece as the default audio route.None
  Future<void> setDefaultAudioRouteToSpeakerphone(bool defaultToSpeaker);

  /// Enables/Disables the speakerphone temporarily.
  /// This method is for Android and iOS only.
  /// After a successful method call, the SDK triggers the onAudioRoutingChanged callback.
  /// You can call this method before joining a channel, when in a channel, or after leaving a channel. However, Agora recommends calling this method only when you are in a channel to change the audio route temporarily. If you do not have a clear requirement for transient settings, Agora recommends calling the steady API setDefaultAudioRouteToSpeakerphone to set the audio route.
  /// Any user behavior or audio-related API call might change the transient setting of setEnableSpeakerphone.
  ///
  /// * [speakerOn] Whether to set the speakerphone as the default audio route:
  ///  true: Set the speakerphone as the audio route temporarily.
  ///  false: Do not set the speakerphone as the audio route. None
  Future<void> setEnableSpeakerphone(bool speakerOn);

  /// Checks whether the speakerphone is enabled.
  /// This method is for Android and iOS only.
  /// You can call this method either before or after joining a channel.
  ///
  /// ## Return
  /// true: The speakerphone is enabled, and the audio plays from the speakerphone.
  /// false: The speakerphone is not enabled, and the audio plays from devices other than the speakerphone. For example, the headset or earpiece.
  Future<bool> isSpeakerphoneEnabled();

  /// Gets a list of shareable screens and windows.
  /// You can call this method before sharing a screen or window to get a list of shareable screens and windows, which enables a user to use thumbnails in the list to choose a particular screen or window to share. This list also contains important information such as window ID and screen ID, with which you can call startScreenCaptureByWindowId
  /// This method applies to Windows only.
  ///
  /// * [thumbSize] The target size of the screen or window thumbnail (the width and height are in pixels).  The SDK scales the original image to make the length of the longest side of the image the same as that of the target size without distorting the original image. For example, if the original image is 400 × 300 and thumbSize is 100 × 100, the actual size of the thumbnail is 100 × 75. If the target size is larger than the original size, the thumbnail is the original image and the SDK does not scale it.None
  ///
  /// * [iconSize] The target size of the icon corresponding to the application program (the width and height are in pixels).  The SDK scales the original image to make the length of the longest side of the image the same as that of the target size without distorting the original image. For example, if the original image is 400 × 300 and iconSize is 100 × 100, the actual size of the icon is 100 × 75. If the target size is larger than the original size, the icon is the original image and the SDK does not scale it.None
  ///
  /// * [includeScreen] Whether the SDK returns the screen information in addition to the window information:
  ///  true: The SDK returns the screen and window information.
  ///  false: The SDK returns the window information only.None
  Future<List<ScreenCaptureSourceInfo>> getScreenCaptureSources(
      {required Size thumbSize,
      required Size iconSize,
      required bool includeScreen});

  /// Sets the operation permissions of the SDK on the Audio Session.
  /// By default, both the SDK and the app have permission to operate the Audio Session. If you only need to use the app to operate the Audio Session, you can call this method to restrict the SDK's operation permissions to the Audio Session.
  /// You can call this method either before or after joining a channel. Once this method is called to restrict the SDK's operation permissions to the Audio Session, the restriction taks effect when the SDK needs to change the Audio Session. This method applies to iOS only.
  /// This method does not affect the operation permissions of the app on the Audio Session.
  ///
  /// * [restriction] The operation permissions of the SDK on the audio session, see AudioSessionOperationRestriction . This parameter is Bit Mask, and each Bit corresponds to a permission.None
  Future<void> setAudioSessionOperationRestriction(
      AudioSessionOperationRestriction restriction);

  /// Shares the screen by specifying the display ID.
  /// There are two ways to start screen sharing, you can choose one according to the actual needs:
  /// Call this method before joining a channel, and then call joinChannelWithOptions to join a channel and set publishScreenTrack true to start screen sharing.
  /// Call this method after joining a channel, and then call updateChannelMediaOptions and set publishScreenTrack true to start screen sharing. This method shares a screen or part of the screen. You need to specify the ID of the screen to be shared in this method. This method applies to macOS only.
  ///
  /// * [displayId] The display ID of the screen to be shared. This parameter specifies which screen you want to share.None
  ///
  /// * [regionRect] (Optional) Sets the relative location of the region to the screen. If you do not set this parameter, the SDK shares the whole screen. See Rectangle . If the specified region overruns the screen, the SDK shares only the region within it; if you set width or height as 0, the SDK shares the whole screen.None
  ///
  /// * [captureParams] Screen sharing configurations. The default video dimension is 1920 x 1080, that is, 2,073,600 pixels. Agora uses the value of this parameter to calculate the charges. See ScreenCaptureParameters .None
  Future<void> startScreenCaptureByDisplayId(
      {required int displayId,
      required Rectangle regionRect,
      required ScreenCaptureParameters captureParams});

  /// Shares the whole or part of a screen by specifying the screen rect.
  /// There are two ways to start screen sharing, you can choose one according to the actual needs:
  /// Call this method before joining a channel, and then call joinChannelWithOptions to join a channel and set publishScreenTrack true to start screen sharing.
  /// Call this method after joining a channel, and then call updateChannelMediaOptions and set publishScreenTrack true to start screen sharing. This method shares a screen or part of the screen. You need to specify the area of the screen to be shared.
  /// This method applies to Windows only.
  ///
  /// * [screenRect] Sets the relative location of the screen to the virtual screen.None
  ///
  /// * [regionRect]  Rectangle . If the specified region overruns the screen, the SDK shares only the region within it; if you set width or height as 0, the SDK shares the whole screen.None
  ///
  /// * [captureParams] The screen sharing encoding parameters. The default video dimension is 1920 x 1080, that is, 2,073,600 pixels. Agora uses the value of this parameter to calculate the charges. See ScreenCaptureParameters .None
  Future<void> startScreenCaptureByScreenRect(
      {required Rectangle screenRect,
      required Rectangle regionRect,
      required ScreenCaptureParameters captureParams});

  /// Gets the audio device information.
  /// After calling this method, you can get whether the audio device supports ultra-low-latency capture and playback. This method is for Android only.
  /// You can call this method either before or after joining a channel.
  ///
  /// ## Return
  /// The DeviceInfo object that identifies the audio device information.
  /// Not null: Success.
  /// Null: Failure.
  Future<DeviceInfo> getAudioDeviceInfo();

  /// Shares the whole or part of a window by specifying the window ID.
  /// There are two ways to start screen sharing, you can choose one according to the actual needs:
  /// Call this method before joining a channel, and then call joinChannelWithOptions to join a channel and set publishScreenTrack true to start screen sharing.
  /// Call this method after joining a channel, and then call updateChannelMediaOptions and set publishScreenTrack true to start screen sharing. This method shares a window or part of the window. You need to specify the ID of the window to be shared.
  /// Applies to the macOS and Windows platforms only.
  /// This method supports window sharing of UWP (Universal Windows Platform) applications. Agora tests the mainstream UWP applications by using the lastest SDK, see details as follows:
  ///
  /// * [windowId] The ID of the window to be shared.None
  ///
  /// * [regionRect] (Optional) Sets the relative location of the region to the screen. If you do not set this parameter, the SDK shares the whole screen. See Rectangle . If the specified region overruns the window, the SDK shares only the region within it; if you set width or height as 0, the SDK shares the whole window.None
  ///
  /// * [captureParams] Screen sharing configurations. The default video dimension is 1920 x 1080, that is, 2,073,600 pixels. Agora uses the value of this parameter to calculate the charges. See ScreenCaptureParameters .None
  Future<void> startScreenCaptureByWindowId(
      {required int windowId,
      required Rectangle regionRect,
      required ScreenCaptureParameters captureParams});

  /// Sets the content hint for screen sharing.
  /// A content hint suggests the type of the content being shared, so that the SDK applies different optimization algorithms to different types of content. If you don't call this method, the default content hint is contentHintNone.
  /// You can call this method either before or after you start screen sharing.
  ///
  /// * [contentHint] The content hint for screen sharing. See VideoContentHint .None
  Future<void> setScreenCaptureContentHint(VideoContentHint contentHint);

  /// Updates the screen sharing region.
  ///
  /// * [regionRect] The relative location of the screen-share area to the screen or window. If you do not set this parameter, the SDK shares the whole screen or window. See Rectangle . If the specified region overruns the screen or window, the SDK shares only the region within it; if you set width or height as 0, the SDK shares the whole screen or window.None
  Future<void> updateScreenCaptureRegion(Rectangle regionRect);

  /// Updates the screen sharing parameters.
  ///
  /// * [captureParams] The screen sharing encoding parameters. The default video dimension is 1920 x 1080, that is, 2,073,600 pixels. Agora uses the value of this parameter to calculate the charges. See ScreenCaptureParameters .None
  Future<void> updateScreenCaptureParameters(
      ScreenCaptureParameters captureParams);

  /// Stops screen sharing.
  Future<void> stopScreenCapture();

  /// Retrieves the call ID.
  /// When a user joins a channel on a client, a callId is generated to identify the call from the client. Some methods, for example, rate and complain ,
  /// need to be called after a call ends. These methods require the callId parameter.
  /// Call this method after joining a channel.
  ///
  /// ## Return
  /// The current call ID.
  Future<String> getCallId();

  /// Allows a user to rate a call after the call ends.
  /// Ensure that you call this method after leaving a channel.
  ///
  /// * [callId] The current call ID. You can get the call ID by calling getCallId .None
  ///
  /// * [rating] The rating of the call. The value is between 1 (lowest score) and 5 (highest score). If you set a value out of this range, the SDK returns the -2 (ERR_INVALID_ARGUMENT) error.None
  ///
  /// * [description] None
  Future<void> rate(
      {required String callId,
      required int rating,
      required String description});

  /// Allows a user to complain about the call quality after a call ends.
  /// This method allows users to complain about the quality of the call. Call this method after the user leaves the channel.
  ///
  /// * [callId] The current call ID. You can get the call ID by calling getCallId .None
  ///
  /// * [description] None
  Future<void> complain({required String callId, required String description});

  /// Publishes the local stream to a specified CDN live streaming URL.
  /// Deprecated:
  /// This method is deprecated. Use startRtmpStreamWithoutTranscoding or startRtmpStreamWithTranscoding instead according to your needs. After calling this method, you can push media streams in RTMP or RTMPS protocol to the CDN. The SDK triggers the onRtmpStreamingStateChanged callback on the local client to report the state of adding a local stream to the CDN. Call this method after joining a channel.
  /// Ensure that the Media Push function is enabled.
  /// This method takes effect only when you are a host in live interactive streaming.
  /// This method adds only one streaming URL to the CDN each time it is called. To push multiple URLs, call this method multiple times.
  ///
  /// * [url] The Media Push URL in the RTMP or RTMPS format. The maximum length of this parameter is 1024 bytes. The URL address must not contain special characters, such as Chinese language characters.None
  ///
  /// * [transcodingEnabled] Whether to enable transcoding. Transcoding in a CDN live streaming converts the audio and video streams before pushing them to the CDN server. It applies to scenarios where a channel has multiple broadcasters and composite layout is needed.
  ///  true: Enable transcoding.
  ///  false: Disable transcoding. If you set this parameter as true, ensurethat you call the setLiveTranscoding method before calling this method. None
  Future<void> addPublishStreamUrl(
      {required String url, required bool transcodingEnabled});

  /// Removes an RTMP or RTMPS stream from the CDN.
  /// Deprecated:
  /// This method is deprecated. This method is deprecated. Use stopRtmpStream instead. After a successful method call, the SDK triggers the onRtmpStreamingStateChanged callback on the local client to report the result of deleting the URL. Before calling this method, make sure that the media push function has been enabled.
  /// This method takes effect only when you are a host in live interactive streaming.
  /// Call this method after joining a channel.
  /// This method removes only one media push URL each time it is called. To remove multiple URLs, call this method multiple times.
  ///
  /// * [url] The media push URL in the RTMP or RTMPS format. The maximum length of this parameter is 1024 bytes. The media push URL must not contain special characters, such as Chinese characters.None
  Future<void> removePublishStreamUrl(String url);

  /// Sets the transcoding configurations for Media Push.
  /// Deprecated:
  /// This method is deprecated. Use startRtmpStreamWithTranscoding or updateRtmpTranscoding instead according to your needs. This method sets the video layout and audio settings for Media Push. The SDK triggers the onTranscodingUpdated callback when you call this method to update the transcoding settings. This method takes effect only when you are a host in live interactive streaming.
  /// Ensure that you enable the RTMP Converter service before using this function. See Prerequisites in the advanced guide Push Streams to CDN.
  /// If you call this method to set the transcoding configuration for the first time, the SDK does not trigger the onTranscodingUpdated callback.
  /// Call this method after joining a channel.
  ///
  /// * [transcoding] The transcoding configurations for Media Push. See LiveTranscoding.None
  Future<void> setLiveTranscoding(LiveTranscoding transcoding);

  /// Starts pushing media streams to a CDN without transcoding.
  /// You can call this method to push a live audio-and-video stream to the specified CDN address and set the transcoding configuration. This method can push media streams to only one CDN address at a time, so if you need to push streams to multiple addresses, call this method multiple times.
  /// After you call this method, the SDK triggers the onRtmpStreamingStateChanged callback on the local client to report the state of the streaming. Call this method after joining a channel.
  /// Only hosts in the LIVE_BROADCASTING profile can call this method.
  /// If you want to retry pushing streams after a failed push, make sure to call stopRtmpStream first, then call this method to retry pushing streams; otherwise, the SDK returns the same error code as the last failed push.
  ///
  /// * [url] The address of Media Push. The format is RTMP or RTMPS. The character length cannot exceed 1024 bytes. Special characters such as Chinese characters are not supported.None
  Future<void> startRtmpStreamWithoutTranscoding(String url);

  /// Starts Media Push and sets the transcoding configuration.
  /// You can call this method to push a live audio-and-video stream to the specified CDN address and set the transcoding configuration. This method can push media streams to only one CDN address at a time, so if you need to push streams to multiple addresses, call this method multiple times.
  /// After you call this method, the SDK triggers the onRtmpStreamingStateChanged callback on the local client to report the state of the streaming. Call this method after joining a channel.
  /// Only hosts in the LIVE_BROADCASTING profile can call this method.
  /// If you want to retry pushing streams after a failed push, make sure to call stopRtmpStream first, then call this method to retry pushing streams; otherwise, the SDK returns the same error code as the last failed push.
  ///
  /// * [url] The address of Media Push. The format is RTMP or RTMPS. The character length cannot exceed 1024 bytes. Special characters such as Chinese characters are not supported.None
  ///
  /// * [transcoding] The transcoding configuration for Media Push. See LiveTranscoding .None
  Future<void> startRtmpStreamWithTranscoding(
      {required String url, required LiveTranscoding transcoding});

  /// Updates the transcoding configuration.
  /// After you start pushing media streams to CDN with transcoding, you can dynamically update the transcoding configuration according to the scenario. The SDK triggers the onTranscodingUpdated callback after the transcoding configuration is updated.
  ///
  /// * [transcoding] The transcoding configuration for Media Push. See LiveTranscoding .None
  Future<void> updateRtmpTranscoding(LiveTranscoding transcoding);

  /// Stops pushing media streams to a CDN.
  /// You can call this method to stop the live stream on the specified CDN address. This method can stop pushing media streams to only one CDN address at a time, so if you need to stop pushing streams to multiple addresses, call this method multiple times.
  /// After you call this method, the SDK triggers the onRtmpStreamingStateChanged callback on the local client to report the state of the streaming.
  ///
  /// * [url] The address of Media Push. The format is RTMP or RTMPS. The character length cannot exceed 1024 bytes. Special characters such as Chinese characters are not supported.None
  Future<void> stopRtmpStream(String url);

  /// @nodoc
  Future<void> startLocalVideoTranscoder(LocalTranscoderConfiguration config);

  /// @nodoc
  Future<void> updateLocalTranscoderConfiguration(
      LocalTranscoderConfiguration config);

  /// @nodoc
  Future<void> stopLocalVideoTranscoder();

  /// Starts video capture with a primary camera.
  ///
  /// * [config] The configuration of the video capture with a primary camera. See CameraCapturerConfiguration .None
  Future<void> startPrimaryCameraCapture(CameraCapturerConfiguration config);

  /// Starts video capture with a secondary camera.
  ///
  /// * [config] The configuration of the video capture with a primary camera. See CameraCapturerConfiguration .None
  Future<void> startSecondaryCameraCapture(CameraCapturerConfiguration config);

  /// Stops capturing video through a primary camera.
  /// You can call this method to stop capturing video through the primary camera after calling the startPrimaryCameraCapture .
  Future<void> stopPrimaryCameraCapture();

  ///  Stops capturing video through the secondary camera.
  /// You can call this method to stop capturing video through the secondary camera after calling the startSecondaryCameraCapture .
  Future<void> stopSecondaryCameraCapture();

  /// Sets the rotation angle of the captured video.
  /// When the video capture device does not have the gravity sensing function, you can call this method to manually adjust the rotation angle of the captured video.
  ///
  /// * [type] The video source type. See VideoSourceType .None
  ///
  /// * [orientation] The clockwise rotation angle. See VideoOrientation .None
  ///
  /// ## Return
  /// 0: Success.
  /// < 0: Failure.
  Future<void> setCameraDeviceOrientation(
      {required VideoSourceType type, required VideoOrientation orientation});

  /// @nodoc
  Future<void> setScreenCaptureOrientation(
      {required VideoSourceType type, required VideoOrientation orientation});

  /// Stop sharing the first screen.
  ///
  /// * [config] The configuration of the captured screen. See ScreenCaptureConfiguration .None
  Future<void> startPrimaryScreenCapture(ScreenCaptureConfiguration config);

  /// Starts sharing a secondary screen.
  ///
  /// * [config] The configuration of the captured screen. See ScreenCaptureConfiguration .None
  Future<void> startSecondaryScreenCapture(ScreenCaptureConfiguration config);

  /// Stop sharing the first screen.
  /// After calling startPrimaryScreenCapture , you can call this method to stop sharing the first screen.
  Future<void> stopPrimaryScreenCapture();

  /// Stop sharing the secondary screen.
  /// After calling startSecondaryScreenCapture , you can call this method to stop sharing the secondary screen.
  Future<void> stopSecondaryScreenCapture();

  /// Gets the current connection state of the SDK.
  /// You can call this method either before or after joining a channel.
  ///
  /// ## Return
  /// The current connection state.  ConnectionStateType
  Future<ConnectionStateType> getConnectionState();

  /// Adds event handlers.
  /// The SDK uses the RtcEngineEventHandler class to send callbacks to the app. The app inherits the methods of this class to receive these callbacks. All methods in this interface class have default (empty) implementations. Therefore, the application can only inherit some required events. In the callbacks, avoid time-consuming tasks or calling APIs that can block the thread, such as the sendStreamMessage method.
  /// Otherwise, the SDK may not work properly.
  ///
  /// * [eventHandler] Callback events to be added. None
  void registerEventHandler(RtcEngineEventHandler eventHandler);

  /// Removes the specified IRtcEngineEventHandler instance.
  /// This method removes the specified callback handler. For callback events that you want to listen for only once, call this method to remove the relevant callback handler after you have received them.
  ///
  /// * [eventHandler] The callback handler to be deleted. See RtcEngineEventHandler .None
  void unregisterEventHandler(RtcEngineEventHandler eventHandler);

  /// @nodoc
  Future<void> setRemoteUserPriority(
      {required int uid, required PriorityType userPriority});

  /// Sets the built-in encryption mode.
  /// Deprecated:
  /// Use enableEncryption instead. The Agora SDK supports built-in encryption, which is set to the AES-128-GCM mode by default. Call this method to use other encryption modes. All users in the same channel must use the same encryption mode and secret. Refer to the information related to the AES encryption algorithm on the differences between the encryption modes.
  /// Before calling this method, please call setEncryptionSecret to enable the built-in encryption function.
  ///
  /// * [encryptionMode] The following encryption modes:
  ///  "aes-128-xts": 128-bit AES encryption, XTS mode.
  ///  "aes-128-ecb": 128-bit AES encryption, ECB mode.
  ///  "aes-256-xts": 256-bit AES encryption, XTS mode.
  ///  "sm4-128-ecb": 128-bit SM4 encryption, ECB mode.
  ///  "aes-128-gcm": 128-bit AES encryption, GCM mode.
  ///  "aes-256-gcm": 256-bit AES encryption, GCM mode.
  ///  "": When this parameter is set as null, the encryption mode is set as "aes-128-gcm" by default. None
  Future<void> setEncryptionMode(String encryptionMode);

  /// Enables built-in encryption with an encryption password before users join a channel.
  /// Deprecated:
  /// Use enableEncryption instead. Before joining the channel, you need to call this method to set the secret parameter to enable the built-in encryption. All users in the same channel should use the same secret. The secret is automatically cleared once a user leaves the channel. If you do not specify the secret or secret is set as null, the built-in encryption is disabled. Do not use this method for CDN live streaming.
  /// For optimal transmission, ensure that the encrypted data size does not exceed the original data size + 16 bytes. 16 bytes is the maximum padding size for AES encryption.
  ///
  /// * [secret] The encryption password.None
  Future<void> setEncryptionSecret(String secret);

  /// Enables/Disables the built-in encryption.
  /// In scenarios requiring high security, Agora recommends calling this method to enable the built-in encryption before joining a channel.
  /// All users in the same channel must use the same encryption mode and encryption key. After the user leaves the channel, the SDK automatically disables the built-in encryption. To enable the built-in encryption, call this method before the user joins the channel again.
  /// If you enable the built-in encryption, you cannot use the media push function.
  ///
  /// * [enabled] Whether to enable built-in encryption:
  ///  true: Enable the built-in encryption.
  ///  false: Disable the built-in encryption. None
  ///
  /// * [config] Built-in encryption configurations. See EncryptionConfig .None
  Future<void> enableEncryption(
      {required bool enabled, required EncryptionConfig config});

  /// Sends data stream messages.
  /// Sends data stream messages to all users in a channel. The SDK has the following restrictions on this method:
  /// Up to 30 packets can be sent per second in a channel with each packet having a maximum size of 1 KB.
  /// Each client can send up to 6 KB of data per second.
  /// Each user can have up to five data streams simultaneously. A successful method call triggers the onStreamMessage callback on the remote client, from which the remote user gets the stream message.
  /// A failed method call triggers the onStreamMessageError callback on the remote client. Ensure that you call createDataStream to create a data channel before calling this method.
  /// In live streaming scenarios, this method only applies to hosts.
  ///
  /// * [streamId] The data stream ID. You can get the data stream ID by calling createDataStream.None
  ///
  /// * [data] The data to be sent.None
  ///
  /// * [length] The length of the data.None
  Future<void> sendStreamMessage(
      {required int streamId, required Uint8List data, required int length});

  /// @nodoc
  Future<void> clearVideoWatermark();

  /// Removes the watermark image from the video stream.
  Future<void> clearVideoWatermarks();

  /// Injects an online media stream to a live streaming channel.
  /// This method takes effect only when you are a host in a live streaming channel.
  /// Only one online media stream can be injected into the same channel at the same time.
  /// Call this method after joining a channel.
  ///
  /// * [url] The URL address to be added to the ongoing streaming. Valid protocols are RTMP, HLS, and HTTP-FLV. Supported audio codec type: AAC.
  ///  Supported video codec type: H264 (AVC). None
  ///
  /// * [config] The configuration information for the added video stream. See InjectStreamConfig .None
  Future<void> addInjectStreamUrl(
      {required String url, required InjectStreamConfig config});

  /// Removes the external media stream URL address from the live streaming.
  /// After a successful method, the SDK triggers the onUserOffline callback with the uid of 666.
  ///
  /// * [url] The URL address of the injected stream to be removed.None
  Future<void> removeInjectStreamUrl(String url);

  /// @nodoc
  Future<void> pauseAudio();

  /// @nodoc
  Future<void> resumeAudio();

  /// Enables interoperability with the Agora Web SDK (applicable only in the live streaming scenarios).
  /// Deprecated:
  /// The SDK automatically enables interoperability with the Web SDK, so you no longer need to call this method. This method enables or disables interoperability with the Agora Web SDK. If the channel has Web SDK users, ensure that you call this method, or the video of the Native user will be a black screen for the Web user.
  /// This method is only applicable in live streaming scenarios, and interoperability is enabled by default in communication scenarios.
  ///
  /// * [enabled] Whether to enable interoperability with the Agora Web SDK.
  ///  true: Enable interoperability.
  ///  false: (Default) Disable interoperability.None
  Future<void> enableWebSdkInteroperability(bool enabled);

  /// Reports customized messages.
  /// Agora supports reporting and analyzing customized messages. This function is in the beta stage with a free trial. The ability provided in its beta test version is reporting a maximum of 10 message pieces within 6 seconds, with each message piece not exceeding 256 bytes and each string not exceeding 100 bytes. To try out this function, contact and discuss the format of customized messages with us.
  Future<void> sendCustomReportMessage(
      {required String id,
      required String category,
      required String event,
      required String label,
      required int value});

  /// Registers the metadata observer.
  /// You need to implement the MetadataObserver class and specify the metadata type in this method. This method enables you to add synchronized metadata in the video stream for more diversified
  /// live interactive streaming, such as sending shopping links, digital coupons, and online quizzes.
  /// A successful call of this method triggers the getMaxMetadataSize callback.
  /// Call this method before joinChannelWithOptions.
  ///
  /// * [observer] The metadata observer. See MetadataObserver .None
  ///
  /// * [type] The metadata type. The SDK currently only supports videoMetadata. None
  void registerMediaMetadataObserver(
      {required MetadataObserver observer, required MetadataType type});

  /// Unregisters the specified metadata observer.
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

  /// Registers a user account.
  /// Once registered, the user account can be used to identify the local user when the user joins the channel. After the registration is successful, the user account can identify the identity of the local user, and the user can use it to join the channel.
  /// After the user successfully registers a user account, the SDK triggers the onLocalUserRegistered callback on the local client, reporting the user ID and user account of the local user.
  /// This method is optional. To join a channel with a user account, you can choose either of the following ways:
  /// Call registerLocalUserAccount to create a user account, and then call joinChannelWithUserAccount to join the channel.
  /// Call the joinChannelWithUserAccount method to join the channel. The difference between the two ways is that the time elapsed between calling the registerLocalUserAccount method and joining the channel is shorter than directly calling joinChannelWithUserAccount. Ensure that you set the userAccount parameter; otherwise, this method does not take effect.
  /// Ensure that the userAccount is unique in the channel.
  /// To ensure smooth communication, use the same parameter type to identify the user. For example, if a user joins the channel with a user ID, then ensure all the other users use the user ID too. The same applies to the user account. If a user joins the channel with the Agora Web SDK, ensure that the ID of the user is set to the same parameter type.
  ///
  /// * [appId] The App ID of your project on Agora Console.None
  ///
  /// * [userAccount] The user account. This parameter is used to identify the user in the channel for real-time audio and video engagement. You need to set and manage user accounts yourself and ensure that each user account in the same channel is unique. The maximum length of this parameter is 255 bytes. Ensure that you set this parameter and do not set it as NULL. Supported characters are (89 in total):
  ///  The 26 lowercase English letters: a to z.
  ///  The 26 uppercase English letters: A to Z.
  ///  All numeric characters: 0 to 9.
  ///  Space
  ///  "!", "#", "$", "%", "&amp;", "(", ")", "+", "-", ":", ";", "&lt;", "= ", ".", "&gt;", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", "," None
  Future<void> registerLocalUserAccount(
      {required String appId, required String userAccount});

  /// @nodoc
  Future<void> joinChannelWithUserAccountEx(
      {required String token,
      required String channelId,
      required String userAccount,
      required ChannelMediaOptions options});

  /// Gets the user information by passing in the user account.
  /// After a remote user joins the channel, the SDK gets the UID and user account of the remote user, caches them in a mapping table object, and triggers the onUserInfoUpdated callback on the local client. After receiving the callback, you can call this method to get the user account of the remote user from the UserInfo object by passing in the user ID.
  ///
  /// ## Return
  /// The UserInfo object that identifies the user information. Not null: Success.
  /// Null: Failure.
  Future<UserInfo> getUserInfoByUserAccount(String userAccount);

  /// Gets the user information by passing in the user ID.
  /// After a remote user joins the channel, the SDK gets the UID and user account of the remote user, caches them in a mapping table object, and triggers the onUserInfoUpdated callback on the local client. After receiving the callback, you can call this method to get the user account of the remote user from the UserInfo object by passing in the user ID.
  ///
  /// * [uid] None
  ///
  /// ## Return
  /// The UserInfo object that identifies the user information. Not null: Success.
  /// Null: Failure.
  Future<UserInfo> getUserInfoByUid(int uid);

  /// Starts relaying media streams across channels. This method can be used to implement scenarios such as co-host across channels.
  /// After a successful method call, the SDK triggers the onChannelMediaRelayStateChanged and onChannelMediaRelayEvent callbacks, and these callbacks return the state and events of the media stream relay.
  /// If the onChannelMediaRelayStateChanged callback returns relayStateRunning (2) and relayOk (0), and the onChannelMediaRelayEvent callback returns relayEventPacketSentToDestChannel (4), it means that the SDK starts relaying media streams between the source channel and the destination channel.
  /// If the onChannelMediaRelayStateChanged callback returns relayStateFailure (3), an exception occurs during the media stream relay.
  /// Call this method after joining the channel.
  /// This method takes effect only when you are a host in a live streaming channel.
  /// After a successful method call, if you want to call this method again, ensure that you call the stopChannelMediaRelay method to quit the current relay.
  /// You need to contact support before implementing this function.
  /// We do not support string type of UID in this API.
  ///
  /// * [configuration] The configuration of the media stream relay. See ChannelMediaRelayConfiguration .None
  Future<void> startChannelMediaRelay(
      ChannelMediaRelayConfiguration configuration);

  /// Updates the channels for media stream relay.
  /// After the media relay starts, if you want to relay the media stream to more channels, or leave the current relay channel, you can call this method.
  /// After a successful method call, the SDK triggers the onChannelMediaRelayEvent callback with the relayEventPacketUpdateDestChannel (7) state code.
  /// Call the method after successfully calling the startChannelMediaRelay method and receiving onChannelMediaRelayStateChanged (relayStateRunning, relayOk); otherwise, the method call fails.
  ///
  /// * [configuration] The configuration of the media stream relay. None
  Future<void> updateChannelMediaRelay(
      ChannelMediaRelayConfiguration configuration);

  /// Stops the media stream relay. Once the relay stops, the host quits all the destination channels.
  /// After a successful method call, the SDK triggers the onChannelMediaRelayStateChanged callback. If the callback reports relayStateIdle (0) and relayOk (0), the host successfully stops the relay.
  /// If the method call fails, the SDK triggers the onChannelMediaRelayStateChanged callback with the relayErrorServerNoResponse (2) or relayErrorServerConnectionLost (8) status code. You can call the leaveChannel method to leave the channel, and the media stream relay automatically stops.
  Future<void> stopChannelMediaRelay();

  /// Pauses the media stream relay to all destination channels.
  /// After the cross-channel media stream relay starts, you can call this method to pause relaying media streams to all destination channels; after the pause, if you want to resume the relay, call resumeAllChannelMediaRelay .
  /// After a successful method call, the SDK triggers the onChannelMediaRelayEvent callback to report whether the media stream relay is successfully paused.
  /// Call this method after the startChannelMediaRelay method.
  Future<void> pauseAllChannelMediaRelay();

  /// Resumes the media stream relay to all destination channels.
  /// After calling the pauseAllChannelMediaRelay method, you can call this method to resume relaying media streams to all destination channels.
  /// After a successful method call, the SDK triggers the onChannelMediaRelayEvent callback to report whether the media stream relay is successfully resumed.
  /// Call this method after the pauseAllChannelMediaRelay method.
  Future<void> resumeAllChannelMediaRelay();

  /// @nodoc
  Future<void> setDirectCdnStreamingAudioConfiguration(
      AudioProfileType profile);

  /// @nodoc
  Future<void> setDirectCdnStreamingVideoConfiguration(
      VideoEncoderConfiguration config);

  /// @nodoc
  Future<void> startDirectCdnStreaming(
      {required DirectCdnStreamingEventHandler eventHandler,
      required String publishUrl,
      required DirectCdnStreamingMediaOptions options});

  /// @nodoc
  Future<void> stopDirectCdnStreaming();

  /// @nodoc
  Future<void> updateDirectCdnStreamingMediaOptions(
      DirectCdnStreamingMediaOptions options);

  /// @nodoc
  Future<void> takeSnapshot(SnapShotConfig config);

  /// @nodoc
  Future<void> setContentInspect(ContentInspectConfig config);

  /// @nodoc
  Future<void> switchChannel({required String token, required String channel});

  /// Enables the virtual metronome.
  /// In music education, physical education and other scenarios, teachers usually need to use a metronome so that students can practice with the correct beat. The meter is composed of a downbeat and upbeats. The first beat of each measure is called a downbeat, and the rest are called upbeats.
  /// In this method, you need to set the paths of the upbeat and downbeat files, the number of beats per measure, the tempo, and whether to send the sound of the metronome to remote users. This method is for Android and iOS only.
  /// After enabling the virtual metronome, the SDK plays the specified audio effect file from the beginning, and controls the playback duration of each file according to beatsPerMinute you set in AgoraRhythmPlayerConfig . For example, if you set beatsPerMinute as 60, the SDK plays one beat every second. If the file duration exceeds the beat duration, the SDK only plays the audio within the beat duration.
  ///
  /// * [sound1] The absolute path or URL address (including the filename extensions) of the file for the downbeat. For example: C:\music\audio.mp4. For the audio file formats supported by this method, see What formats of audio files does the Agora RTC SDK support.None
  ///
  /// * [sound2] The absolute path or URL address (including the filename extensions) of the file for the upbeats. For example: C:\music\audio.mp4. For the audio file formats supported by this method, see What formats of audio files does the Agora RTC SDK support.None
  ///
  /// * [config] The metronome configuration. See AgoraRhythmPlayerConfig .None
  Future<void> startRhythmPlayer(
      {required String sound1,
      required String sound2,
      required AgoraRhythmPlayerConfig config});

  /// Disables the virtual metronome.
  /// After calling startRhythmPlayer , you can call this method to disable the virtual metronome.
  /// This method is for Android and iOS only.
  Future<void> stopRhythmPlayer();

  /// Configures the virtual metronome.
  /// This method is for Android and iOS only.
  /// After enabling the virtual metronome, the SDK plays the specified audio effect file from the beginning, and controls the playback duration of each file according to beatsPerMinute you set in AgoraRhythmPlayerConfig . For example, if you set beatsPerMinute as 60, the SDK plays one beat every second. If the file duration exceeds the beat duration, the SDK only plays the audio within the beat duration.
  /// After calling startRhythmPlayer , you can call this method to reconfigure the virtual metronome.
  ///
  /// * [config] The metronome configuration. See AgoraRhythmPlayerConfig .None
  Future<void> configRhythmPlayer(AgoraRhythmPlayerConfig config);

  /// @nodoc
  Future<void> adjustCustomAudioPublishVolume(
      {required int sourceId, required int volume});

  /// @nodoc
  Future<void> adjustCustomAudioPlayoutVolume(
      {required int sourceId, required int volume});

  /// Sets the Agora cloud proxy service.
  /// When users' network access is restricted by a firewall, , configure the firewall to allow specific IP addresses and ports provided by Agora; then, call this method to enable the cloud proxy and set the cloud proxy type with the proxyType parameter.
  /// After successfully connecting to the cloud proxy, the SDK triggers the onConnectionStateChanged (connectionStateConnecting, connectionChangedSettingProxyServer) callback.
  /// To disable the cloud proxy that has been set, call the setCloudProxy (noneProxy).
  /// To change the cloud proxy type that has been set, call the setCloudProxy (noneProxy) first, and then call the setCloudProxy to set the proxyType you want. Agora recommends that you call this method before joining the channel or after leaving the channel.
  /// When a user is behind a firewall and uses the Force UDP cloud proxy, the services for Media Push and cohosting across channels are not available.
  /// When you use the Force TCP cloud proxy, note that an error would occur when calling the startAudioMixing method to play online music files in the HTTP protocol. The services for Media Push and cohosting across channels use the cloud proxy with the TCP protocol.
  ///
  /// * [proxyType] The type of the cloud proxy. See CloudProxyType .
  ///  This parameter is mandatory. The SDK reports an error if you do not pass in a value.None
  Future<void> setCloudProxy(CloudProxyType proxyType);

  /// @nodoc
  Future<void> setLocalAccessPoint(LocalAccessPointConfiguration config);

  /// @nodoc
  Future<void> enableFishCorrection(
      {required bool enabled, required FishCorrectionParams params});

  /// Sets audio advanced options.
  /// If you have advanced audio processing requirements, such as capturing and sending stereo audio, you can call this method to set advanced audio options. This method is for Android and iOS only.
  /// Call this method after calling joinChannelWithOptions , enableAudio and enableLocalAudio .
  ///
  /// ## Return
  /// The advanced options for audio. See AdvancedAudioOptions .
  Future<AdvancedAudioOptions> setAdvancedAudioOptions();

  /// Sets the pitch of the local music file.
  /// The same user may use two devices to send audio streams and video streams respectively. To ensure the time synchronization of the audio and video heard and seen by the receiver, you can call this method on the video sender and pass in the channel of the audio sender. name, user ID. The SDK will automatically adjust the sent video stream based on the timestamp of the sent audio stream to ensure that even when the upstream network conditions of the two senders are inconsistent (such as using Wi-Fi and 4G networks respectively), the The received audio and video have time synchronization.
  /// Agora recommends calling this method before .
  ///
  /// * [channelId] Identifies the channel name of the channel where the audio sender is located.None
  ///
  /// * [uid] User ID of the audio sender.None
  Future<void> setAVSyncSource({required String channelId, required int uid});

  /// Joins a channel.
  /// When the connection between the client and Agora's server is interrupted due to poor network conditions, the SDK tries reconnecting to the server. When the local client successfully rejoins the channel, the SDK triggers the onRejoinChannelSuccess callback on the local client.
  /// A successful call of this method triggers the following callbacks:
  /// The local client: The onJoinChannelSuccess and onConnectionStateChanged callbacks.
  /// The remote client: onUserJoined , if the user joining the channel is in the Communication profile or is a host in the Live-broadcasting profile. This method enables users to join a channel. Users in the same channel can talk to each other, and multiple users in the same channel can start a group chat. Users with different App IDs cannot call each other.
  /// Once a user joins the channel, the user subscribes to the audio and video streams of all the other users in the channel by default, giving rise to usage and billing calculation. To stop subscribing to a specified stream or all remote streams, call the corresponding mute methods.
  ///
  /// * [channelId] The channel name. This parameter signifies the channel in which users engage in real-time audio and video interaction. Under the premise of the same App ID, users who fill in the same channel ID enter the same channel for audio and video interaction. The string length must be less than 64 bytes. Supported characters:
  ///  All lowercase English letters: a to z.
  ///  All uppercase English letters: A to Z.
  ///  All numeric characters: 0 to 9.
  ///  Space
  ///  "!", "#", "$", "%", "&amp;", "(", ")", "+", "-", ":", ";", "&lt;", "= ", ".", "&gt;", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", "," None
  ///
  /// * [token] The token generated on your server for authentication. See None
  ///
  /// * [info] (Optional) Reserved for future use.None
  ///
  /// * [uid] The user ID. This parameter is used to identify the user in the channel for real-time audio and video interaction. You need to set and manage user IDs yourself, and ensure that each user ID in the same channel is unique. This parameter is a 32-bit unsigned integer. The value range is 1 to 232-1. If the user ID is not assigned (or set to 0), the SDK assigns a random user ID and returns it in the onJoinChannelSuccess callback. Your application must record and maintain the returned user ID, because the SDK does not do so.None
  Future<void> joinChannel(
      {required String token,
      required String channelId,
      required String info,
      required int uid});

  /// Joins a channel with media options.
  /// This method enables users to join a channel. Users in the same channel can talk to each other, and multiple users in the same channel can start a group chat. Users with different App IDs cannot call each other.
  /// A successful call of this method triggers the following callbacks:
  /// The local client: The onJoinChannelSuccess and onConnectionStateChanged callbacks.
  /// The remote client: onUserJoined , if the user joining the channel is in the Communication profile or is a host in the Live-broadcasting profile. When the connection between the client and Agora's server is interrupted due to poor network conditions, the SDK tries reconnecting to the server. When the local client successfully rejoins the channel, the SDK triggers the onRejoinChannelSuccess callback on the local client. This method allows users to join only one channel at a time.
  /// Ensure that the app ID you use to generate the token is the same app ID that you pass in the initialize method; otherwise, you may fail to join the channel by token.
  ///
  /// * [token] The token generated on your server for authentication. See None
  ///
  /// * [channelId] The channel name. This parameter signifies the channel in which users engage in real-time audio and video interaction. Under the premise of the same App ID, users who fill in the same channel ID enter the same channel for audio and video interaction. The string length must be less than 64 bytes. Supported characters:
  ///  All lowercase English letters: a to z.
  ///  All uppercase English letters: A to Z.
  ///  All numeric characters: 0 to 9.
  ///  Space
  ///  "!", "#", "$", "%", "&amp;", "(", ")", "+", "-", ":", ";", "&lt;", "= ", ".", "&gt;", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", "," None
  ///
  /// * [uid] The user ID. This parameter is used to identify the user in the channel for real-time audio and video interaction. You need to set and manage user IDs yourself, and ensure that each user ID in the same channel is unique. This parameter is a 32-bit unsigned integer. The value range is 1 to 232-1. If the user ID is not assigned (or set to 0), the SDK assigns a random user ID and returns it in the onJoinChannelSuccess callback. Your application must record and maintain the returned user ID, because the SDK does not do so.None
  ///
  /// * [options] The channel media options. See ChannelMediaOptions .None
  Future<void> joinChannelWithOptions(
      {required String token,
      required String channelId,
      required int uid,
      required ChannelMediaOptions options});

  /// Leaves a channel.
  /// If you call release immediately after calling this method, the SDK does not trigger the onLeaveChannel callback.
  /// If you call this method during a CDN live streaming, the SDK automatically calls the removePublishStreamUrl method.
  /// This method lets the user leave the channel, for example, by hanging up or exiting the call.
  /// After joining the channel, you must call this method or leaveChannel to end the call, otherwise, the next call cannot be started.
  /// No matter whether you are currently in a call or not, you can call this method without side effects. This method releases all resources related to the session.
  /// This method call is asynchronous. When this method returns, it does not necessarily mean that the user has left the channel. After you leave the channel, the SDK triggers the onLeaveChannel callback. A successful call of this method triggers the following callbacks: The local client: onLeaveChannel
  /// The remote client: onUserOffline , if the user joining the channel is in the COMMUNICATION profile, or is a host in the LIVE_BROADCASTING profile.
  ///
  /// * [options] The options for leaving the channel. See LeaveChannelOptions .None
  Future<void> leaveChannel({LeaveChannelOptions? options});

  /// Sets the user role and level in an interactive live streaming channel.
  /// In the interactive live streaming profile, the SDK sets the user role as audience by default. You can call this method to set the user role as host.
  /// You can call this method either before or after joining a channel.
  /// If you call this method to set the user's role as the host before joining the channel and set the local video property through the setupLocalVideo method, the local video preview is automatically enabled when the user joins the channel.
  /// If you call this method to switch the user role after joining a channel, the SDK automatically does the following:
  /// Calls muteLocalAudioStream and muteLocalVideoStream to change the publishing state.
  /// Triggers onClientRoleChanged on the local client.
  /// Triggers onUserJoined or onUserOffline on the remote client. This method applies to the interactive live streaming profile (the profile parameter of setChannelProfile is channelProfileLiveBroadcasting) only.
  ///
  /// * [role] The user role in the interactive live streaming. See ClientRoleType .None
  ///
  /// * [options] The detailed options of a user, including the user level. See ClientRoleOptions .None
  Future<void> setClientRole(
      {required ClientRoleType role, ClientRoleOptions? options});

  /// Starts an audio call test.
  /// This method starts an audio call test to determine whether the audio devices (for example, headset and speaker) and the network connection are working properly. To conduct the test, let the user speak for a while, and the recording is played back within the set interval. If the user can hear the recording within the interval, the audio devices and network connection are working properly. Call this method before joining a channel.
  /// After calling startEchoTest, you must call stopEchoTest to end the test. Otherwise, the app cannot perform the next echo test, and you cannot join the channel.
  /// In the live streaming channels, only a host can call this method.
  ///
  /// * [intervalInSeconds] The time interval (s) between when you speak and when the recording plays back. The value range is [2, 10], and the default value is 10.None
  Future<void> startEchoTest({int intervalInSeconds = 10});

  /// Enables the local video preview and specifies the video source for the preview.
  /// The local preview enables the mirror mode by default.
  /// After the local video preview is enabled, if you call leaveChannel to exit the channel, the local preview remains until you call stopPreview to disable it.
  /// The video source type set in this method needs to be consistent with the video source type of VideoCanvas you set in setupLocalVideo .
  ///
  /// * [sourceType] The type of the video source, see VideoSourceType .None
  Future<void> startPreview(
      {VideoSourceType sourceType = VideoSourceType.videoSourceCameraPrimary});

  /// Stops the local video preview.
  /// After calling startPreview to start the preview, if you want to close the local video preview, please call this method.
  /// Please call this method before joining a channel or after leaving a channel.
  ///
  /// * [sourceType] The type of the video source, see VideoSourceType .None
  Future<void> stopPreview(
      {VideoSourceType sourceType = VideoSourceType.videoSourceCameraPrimary});

  /// Sets the audio profile and audio scenario.
  /// You can call this method either before or after joining a channel.
  /// In scenarios requiring high-quality audio, such as online music tutoring, Agora recommends you set profile as audioProfileMusicHighQuality(4), and scenario as audioScenarioGameStreaming(3) or audioScenarioHighDefinition(6).
  ///
  /// * [profile] The audio profile, including the sampling rate, bitrate, encoding mode, and the number of channels. See AudioProfileType .None
  ///
  /// * [scenario] The audio scenario. Under different audio scenarios, the device uses different volume types.None
  Future<void> setAudioProfile(
      {required AudioProfileType profile,
      AudioScenarioType scenario = AudioScenarioType.audioScenarioDefault});

  /// Stops the audio recording on the client.
  /// The Agora SDK allows recording during a call. After successfully calling this method, you can record the audio of all the users in the channel and get an audio recording file. Supported formats of the recording file are as follows:
  /// WAV: High-fidelity files with typically larger file sizes. For example, the size of a WAV file with a sample rate of 32,000 Hz and a recording duration of 10 minutes is around 73 MB.
  /// AAC: Low-fidelity files with typically smaller file sizes. For example, if the sample rate is 32,000 Hz and the recording quality is audioRecordingQualityMedium, the file size for 10-minute recording is approximately 2 MB. Once the user leaves the channel, the recording automatically stops.
  /// Call this method after joining a channel.
  ///
  /// * [config] Recording configuration. See AudioRecordingConfiguration .None
  Future<void> startAudioRecording(AudioRecordingConfiguration config);

  /// Starts playing the music file.
  /// This method mixes the specified local or online audio file with the audio from the microphone, or replaces the microphone's audio with the specified local or remote audio file. A successful method call triggers the onAudioMixingStateChanged (audioMixingStatePlaying) callback. When the audio mixing file playback finishes, the SDK triggers the onAudioMixingStateChanged(audioMixingStateStopped) callback on the local client. For the audio file formats supported by this method, see What formats of audio files the Agora RTC SDK support.
  /// You can call this method either before or after joining a channel. If you need to call startAudioMixing multiple times, ensure that the call interval is longer than 500 ms.
  /// If the local music file does not exist, the SDK does not support the file format, or the the SDK cannot access the music file URL, the SDK reports (701).
  ///
  /// * [filePath] File path:
  ///  Android: The file path, which needs to be accurate to the file name and suffix. Agora supports using a URI address, an absolute path, or a path that starts with /assets/. You might encounter permission issues if you use an absolute path to access a local file, so Agora recommends using a URI address instead. For example: content://com.android.providers.media.documents/document/audio%3A14441
  ///  Windows: The absolute path or URL address (including the suffixes of the filename) of the audio effect file. For example: C:\music\audio.mp4.
  ///  iOS or macOS: The absolute path or URL address (including the suffixes of the filename) of the audio effect file. For example: /var/mobile/Containers/Data/audio.mp4.None
  ///
  /// * [loopback] Whether to play music files only on the local client:
  ///  true: Only play music files on the local client so that only the local user can hear the music.
  ///  false: Publish music files to remote clients so that both the local user and remote users can hear the music. None
  ///
  /// * [replace] Whether to replace the audio captured by the microphone with a music file:
  ///  true: Replace the audio captured by the microphone with a music file. Users can only hear the music.
  ///  false: Do not replace the audio captured by the microphone with a music file. Users can hear both music and audio captured by the microphone. None
  ///
  /// * [cycle] The number of times the music file plays.
  ///  ≥ 0: The number of playback times. For example, 0 means that the SDK does not play the music file while 1 means that the SDK plays once.
  ///  -1: Play the music file in an infinite loop. None
  ///
  /// * [startPos] The playback position (ms) of the music file.None
  Future<void> startAudioMixing(
      {required String filePath,
      required bool loopback,
      required bool replace,
      required int cycle,
      int startPos = 0});

  /// @nodoc
  Future<void> setLocalRenderMode(
      {required RenderModeType renderMode,
      VideoMirrorModeType mirrorMode =
          VideoMirrorModeType.videoMirrorModeAuto});

  /// Enables/Disables dual-stream mode.
  /// You can call this method to enable or disable the dual-stream mode on the publisher side. Dual streams are a hybrid of a high-quality video stream and a low-quality video stream:
  /// High-quality video stream: High bitrate, high resolution.
  /// Low-quality video stream: Low bitrate, low resolution. After you enable the dual-stream mode, you can call setRemoteVideoStreamType to choose toreceive the high-quality video stream or low-quality video stream on the subscriber side. You can call this method either before or after joining a channel.
  ///
  /// * [enabled] Whether to enable dual-stream mode.
  ///  true: Enable dual-stream mode.
  ///  false: Disable dual-stream mode. None
  ///
  /// * [sourceType] The capture type of the custom video source. See VideoSourceType .None
  ///
  /// * [streamConfig] The configuration of the low-quality video stream. See SimulcastStreamConfig .None
  Future<void> enableDualStreamMode(
      {required bool enabled,
      VideoSourceType sourceType = VideoSourceType.videoSourceCameraPrimary,
      SimulcastStreamConfig? streamConfig});

  /// Creates a data stream.
  /// Creates a data stream. Each user can create up to five data streams in a single channel.
  ///
  /// * [config] The configurations for the data stream. See DataStreamConfig .None
  ///
  /// ## Return
  /// ID of the created data stream, if the method call succeeds.
  /// < 0: Failure.
  Future<int> createDataStream(DataStreamConfig config);

  /// Adds a watermark image to the local video.
  /// This method adds a PNG watermark image to the local video in the live streaming. Once the watermark image is added, all the audience in the channel (CDN audience included), and the capturing device can see and capture it. Agora supports adding only one watermark image onto the local video, and the newly watermark image replaces the previous one.
  /// The watermark coordinatesare dependent on the settings in the setVideoEncoderConfiguration method:
  /// If the orientation mode of the encoding video ( OrientationMode ) is fixed landscape mode or the adaptive landscape mode, the watermark uses the landscape orientation.
  /// If the orientation mode of the encoding video (OrientationMode) is fixed portrait mode or the adaptive portrait mode, the watermark uses the portrait orientation.
  /// When setting the watermark position, the region must be less than thesetVideoEncoderConfiguration dimensions set in the method; otherwise, the watermark image will be cropped.
  /// Ensure that call this method after enableVideo .
  /// If you only want to add a watermark to the media push, you can call this method or the setLiveTranscoding method.
  /// This method supports adding a watermark image in the PNG file format only. Supported pixel formats of the PNG image are RGBA, RGB, Palette, Gray, and Alpha_gray.
  /// If the dimensions of the PNG image differ from your settings in this method, the image will be cropped or zoomed to conform to your settings.
  /// If you have enabledthe local video preview by calling the startPreview method, you can use the visibleInPreview member to set whether or not the watermark is visible in the preview.
  /// If you have enabled the mirror mode for the local video, the watermark on the local video is also mirrored. To avoid mirroring the watermark, Agora recommends that you do not use the mirror and watermark functions for the local video at the same time. You can implement the watermark function in your application layer.
  ///
  /// * [watermarkUrl] The local file path of the watermark image to be added. This method supports adding a watermark image from the local absolute or relative file path.None
  ///
  /// * [options] The options of the watermark image to be added. None
  Future<void> addVideoWatermark(
      {required String watermarkUrl, required WatermarkOptions options});

  /// Joins the channel with a user account, and configures whether to automatically subscribe to audio or video streams after joining the channel.
  /// This method allows a user to join the channel with the user account. After the user successfully joins the channel, the SDK triggers the following callbacks:
  /// The local client: onLocalUserRegistered , onJoinChannelSuccess and onConnectionStateChanged callbacks.
  /// The remote client: The onUserJoined callback if the user is in the COMMUNICATION profile, and the onUserInfoUpdated callback if the user is a host in the LIVE_BROADCASTING profile. Once a user joins the channel, the user subscribes to the audio and video streams of all the other users in the channel by default, giving rise to usage and billing calculation. To stop subscribing to a specified stream or all remote streams, call the corresponding mute methods.
  /// To ensure smooth communication, use the same parameter type to identify the user. For example, if a user joins the channel with a user ID, then ensure all the other users use the user ID too. The same applies to the user account. If a user joins the channel with the Agora Web SDK, ensure that the ID of the user is set to the same parameter type.
  ///
  /// * [options] The channel media options. See ChannelMediaOptions .None
  ///
  /// * [token] The token generated on your server for authentication. See None
  ///
  /// * [channelId] The channel name. This parameter signifies the channel in which users engage in real-time audio and video interaction. Under the premise of the same App ID, users who fill in the same channel ID enter the same channel for audio and video interaction. The string length must be less than 64 bytes. Supported characters:
  ///  All lowercase English letters: a to z.
  ///  All uppercase English letters: A to Z.
  ///  All numeric characters: 0 to 9.
  ///  Space
  ///  "!", "#", "$", "%", "&amp;", "(", ")", "+", "-", ":", ";", "&lt;", "= ", ".", "&gt;", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", "," None
  ///
  /// * [userAccount] The user account. This parameter is used to identify the user in the channel for real-time audio and video engagement. You need to set and manage user accounts yourself and ensure that each user account in the same channel is unique. The maximum length of this parameter is 255 bytes. Ensure that you set this parameter and do not set it as NULL. Supported characters are (89 in total):
  ///  The 26 lowercase English letters: a to z.
  ///  The 26 uppercase English letters: A to Z.
  ///  All numeric characters: 0 to 9.
  ///  Space
  ///  "!", "#", "$", "%", "&amp;", "(", ")", "+", "-", ":", ";", "&lt;", "= ", ".", "&gt;", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", "," None
  Future<void> joinChannelWithUserAccount(
      {required String token,
      required String channelId,
      required String userAccount,
      ChannelMediaOptions? options});

  /// Gets the AudioDeviceManager object to manage audio devices.
  ///
  /// ## Return
  /// A AudioDeviceManager object.
  AudioDeviceManager getAudioDeviceManager();

  /// Gets the VideoDeviceManager object to manage video devices.
  ///
  /// ## Return
  /// A VideoDeviceManager object.
  VideoDeviceManager getVideoDeviceManager();

  /// Sends media affiliate information.
  /// If the media attachment information is successfully sent, the receiver will receive the onMetadataReceived callback.
  ///
  /// * [metadata] Media metadata. See Metadata .None
  Future<void> sendMetaData(
      {required Metadata metadata, required VideoSourceType sourceType});

  /// Sets the maximum size of media metadata information.
  /// After calling registerMediaMetadataObserver , you can call this method to set the maximum size of media metadata information.
  ///
  /// * [size] Sets the maximum size of media metadata information.None
  Future<void> setMaxMetadataSize(int size);
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

/// Media device states.
@JsonEnum(alwaysCreate: true)
enum MediaDeviceStateType {
  /// 0: The device is ready for use.
  @JsonValue(0)
  mediaDeviceStateIdle,

  /// 1: The device is in use.
  @JsonValue(1)
  mediaDeviceStateActive,

  /// 2: The device is disabled.
  @JsonValue(2)
  mediaDeviceStateDisabled,

  /// 4: The device is not found.
  @JsonValue(4)
  mediaDeviceStateNotPresent,

  /// 8: The device is not connected.
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

/// The video profile.
@JsonEnum(alwaysCreate: true)
enum VideoProfileType {
  /// 0: 160 × 120, frame rate 15 fps, bitrate 65 Kbps.
  @JsonValue(0)
  videoProfileLandscape120p,

  /// 2: 120 × 120, frame rate 15 fps, bitrate 50 Kbps.
  @JsonValue(2)
  videoProfileLandscape120p3,

  /// 10: 320 × 180, frame rate 15 fps, bitrate 140 Kbps.
  @JsonValue(10)
  videoProfileLandscape180p,

  /// 12: 180 × 180, frame rate 15 fps, bitrate 100 Kbps.
  @JsonValue(12)
  videoProfileLandscape180p3,

  /// 13: 240 × 180, frame rate 15 fps, bitrate 120 Kbps.
  @JsonValue(13)
  videoProfileLandscape180p4,

  /// 20: 320 × 240, frame rate 15 fps, bitrate 200 Kbps.
  @JsonValue(20)
  videoProfileLandscape240p,

  /// 22: 240 × 240, frame rate 15 fps, bitrate 140 Kbps.
  @JsonValue(22)
  videoProfileLandscape240p3,

  /// 23: 424 × 240, frame rate 15 fps, bitrate 220 Kbps.
  @JsonValue(23)
  videoProfileLandscape240p4,

  /// 30: 640 × 360, frame rate 15 fps, bitrate 400 Kbps.
  @JsonValue(30)
  videoProfileLandscape360p,

  /// 32: 360 × 360, frame rate 15 fps, bitrate 260 Kbps.
  @JsonValue(32)
  videoProfileLandscape360p3,

  /// 33: 640 × 360, frame rate 30 fps, bitrate 600 Kbps.
  @JsonValue(33)
  videoProfileLandscape360p4,

  /// 35: 360 × 360, frame rate 30 fps, bitrate 400 Kbps.
  @JsonValue(35)
  videoProfileLandscape360p6,

  /// 36: 480 × 360, frame rate 15 fps, bitrate 320 Kbps.
  @JsonValue(36)
  videoProfileLandscape360p7,

  /// 37: 480 × 360, frame rate 30 fps, bitrate 490 Kbps.
  @JsonValue(37)
  videoProfileLandscape360p8,

  /// 38: 640 × 360, frame rate 15 fps, bitrate 800 Kbps.
  /// This profile applies only to the live streaming channel profile.
  @JsonValue(38)
  videoProfileLandscape360p9,

  /// 39: 640 × 360, frame rate 24 fps, bitrate 800 Kbps.
  /// This profile applies only to the live streaming channel profile.
  @JsonValue(39)
  videoProfileLandscape360p10,

  /// 100: 640 × 360, frame rate 24 fps, bitrate 1000 Kbps.
  /// This profile applies only to the live streaming channel profile.
  @JsonValue(100)
  videoProfileLandscape360p11,

  /// 40: 640 × 480, frame rate 15 fps, bitrate 500 Kbps.
  @JsonValue(40)
  videoProfileLandscape480p,

  /// 42: 480 × 480, frame rate 15 fps, bitrate 400 Kbps.
  @JsonValue(42)
  videoProfileLandscape480p3,

  /// 43: 640 × 480, frame rate 30 fps, bitrate 750 Kbps.
  @JsonValue(43)
  videoProfileLandscape480p4,

  /// 45: 480 × 480, frame rate 30 fps, bitrate 600 Kbps.
  @JsonValue(45)
  videoProfileLandscape480p6,

  /// 47: 848 × 480, frame rate 15 fps, bitrate 610 Kbps.
  @JsonValue(47)
  videoProfileLandscape480p8,

  /// 48: 848 × 480, frame rate 30 fps, bitrate 930 Kbps.
  @JsonValue(48)
  videoProfileLandscape480p9,

  /// 49: 640 × 480, frame rate 10 fps, bitrate 400 Kbps.
  @JsonValue(49)
  videoProfileLandscape480p10,

  /// 50: 1280 × 720, frame rate 15 fps, bitrate 1130 Kbps.
  @JsonValue(50)
  videoProfileLandscape720p,

  /// 52: 1280 × 720, frame rate 30 fps, bitrate 1710 Kbps.
  @JsonValue(52)
  videoProfileLandscape720p3,

  /// 54: 960 × 720, frame rate 15 fps, bitrate 910 Kbps.
  @JsonValue(54)
  videoProfileLandscape720p5,

  /// 55: 960 × 720, frame rate 30 fps, bitrate 1380 Kbps.
  @JsonValue(55)
  videoProfileLandscape720p6,

  /// 60: 1920 × 1080, frame rate 15 fps, bitrate 2080 Kbps.
  @JsonValue(60)
  videoProfileLandscape1080p,

  /// 60: 1920 × 1080, frame rate 30 fps, bitrate 3150 Kbps.
  @JsonValue(62)
  videoProfileLandscape1080p3,

  /// 64: 1920 × 1080, frame rate 60 fps, bitrate 4780 Kbps.
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

  /// @nodoc
  @JsonValue(1000)
  videoProfilePortrait120p,

  /// @nodoc
  @JsonValue(1002)
  videoProfilePortrait120p3,

  /// 1010: 180 × 320, frame rate 15 fps, bitrate 140 Kbps.
  @JsonValue(1010)
  videoProfilePortrait180p,

  /// 1012: 180 × 180, frame rate 15 fps, bitrate 100 Kbps.
  @JsonValue(1012)
  videoProfilePortrait180p3,

  /// 1013: 180 × 240, frame rate 15 fps, bitrate 120 Kbps.
  @JsonValue(1013)
  videoProfilePortrait180p4,

  /// 1020: 240 × 320, frame rate 15 fps, bitrate 200 Kbps.
  @JsonValue(1020)
  videoProfilePortrait240p,

  /// 1022: 240 × 240, frame rate 15 fps, bitrate 140 Kbps.
  @JsonValue(1022)
  videoProfilePortrait240p3,

  /// 1023: 240 × 424, frame rate 15 fps, bitrate 220 Kbps.
  @JsonValue(1023)
  videoProfilePortrait240p4,

  /// 1030: 360 × 640, frame rate 15 fps, bitrate 400 Kbps.
  @JsonValue(1030)
  videoProfilePortrait360p,

  /// 1032: 360 × 360, frame rate 15 fps, bitrate 260 Kbps.
  @JsonValue(1032)
  videoProfilePortrait360p3,

  /// 1033: 360 × 640, frame rate 15 fps, bitrate 600 Kbps.
  @JsonValue(1033)
  videoProfilePortrait360p4,

  /// 1035: 360 × 360, frame rate 30 fps, bitrate 400 Kbps.
  @JsonValue(1035)
  videoProfilePortrait360p6,

  /// 1036: 360 × 480, frame rate 15 fps, bitrate 320 Kbps.
  @JsonValue(1036)
  videoProfilePortrait360p7,

  /// 1037: 360 × 480, frame rate 30 fps, bitrate 490 Kbps.
  @JsonValue(1037)
  videoProfilePortrait360p8,

  /// 1038: 360 × 640, frame rate 15 fps, bitrate 800 Kbps.
  /// This profile applies only to the live streaming channel profile.
  @JsonValue(1038)
  videoProfilePortrait360p9,

  /// 1039: 360 × 640, frame rate 24 fps, bitrate 800 Kbps.
  /// This profile applies only to the live streaming channel profile.
  @JsonValue(1039)
  videoProfilePortrait360p10,

  /// 1100: 360 × 640, frame rate 24 fps, bitrate 1000 Kbps.
  /// This profile applies only to the live streaming channel profile.
  @JsonValue(1100)
  videoProfilePortrait360p11,

  /// 1040: 480 × 640, frame rate 15 fps, bitrate 500 Kbps.
  @JsonValue(1040)
  videoProfilePortrait480p,

  /// 1042: 480 × 480, frame rate 15 fps, bitrate 400 Kbps.
  @JsonValue(1042)
  videoProfilePortrait480p3,

  /// 1043: 480 × 640, frame rate 30 fps, bitrate 750 Kbps.
  @JsonValue(1043)
  videoProfilePortrait480p4,

  /// 1045: 480 × 480, frame rate 30 fps, bitrate 600 Kbps.
  @JsonValue(1045)
  videoProfilePortrait480p6,

  /// 1047: 480 × 848, frame rate 15 fps, bitrate 610 Kbps.
  @JsonValue(1047)
  videoProfilePortrait480p8,

  /// 1048: 480 × 848, frame rate 30 fps, bitrate 930 Kbps.
  @JsonValue(1048)
  videoProfilePortrait480p9,

  /// 1049: 480 × 640, frame rate 10 fps, bitrate 400 Kbps.
  @JsonValue(1049)
  videoProfilePortrait480p10,

  /// 1050: 720 × 1280, frame rate 15 fps, bitrate 1130 Kbps.
  @JsonValue(1050)
  videoProfilePortrait720p,

  /// 1052: 720 × 1280, frame rate 30 fps, bitrate 1710 Kbps.
  @JsonValue(1052)
  videoProfilePortrait720p3,

  /// 1054: 720 × 960, frame rate 15 fps, bitrate 910 Kbps.
  @JsonValue(1054)
  videoProfilePortrait720p5,

  /// 1055: 720 × 960, frame rate 30 fps, bitrate 1380 Kbps.
  @JsonValue(1055)
  videoProfilePortrait720p6,

  /// 1060: 1080 × 1920, frame rate 15 fps, bitrate 2080 Kbps.
  @JsonValue(1060)
  videoProfilePortrait1080p,

  /// 1062: 1080 × 1920, frame rate 30 fps, bitrate 3150 Kbps.
  @JsonValue(1062)
  videoProfilePortrait1080p3,

  /// 1064: 1080 × 1920, frame rate 60 fps, bitrate 4780 Kbps.
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

  /// (Default) 640 × 360, frame rate 15 fps, bitrate 400 Kbps.
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

/// SDK version information.
@JsonSerializable(explicitToJson: true)
class SDKBuildInfo {
  /// Construct the [SDKBuildInfo].
  const SDKBuildInfo({this.build, this.version});

  /// SDK build index.
  @JsonKey(name: 'build')
  final int? build;

  /// SDK version information. String, such as 4.0.0.
  @JsonKey(name: 'version')
  final String? version;

  /// @nodoc
  factory SDKBuildInfo.fromJson(Map<String, dynamic> json) =>
      _$SDKBuildInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$SDKBuildInfoToJson(this);
}

/// The VideoDeviceInfo class that contains the ID and device name of the video devices.
@JsonSerializable(explicitToJson: true)
class VideoDeviceInfo {
  /// Construct the [VideoDeviceInfo].
  const VideoDeviceInfo({this.deviceId, this.deviceName});

  /// The device ID.
  @JsonKey(name: 'deviceId')
  final String? deviceId;

  /// The device name.
  @JsonKey(name: 'deviceName')
  final String? deviceName;

  /// @nodoc
  factory VideoDeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$VideoDeviceInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$VideoDeviceInfoToJson(this);
}

/// The AudioDeviceInfo class that contains the ID and device name of the audio devices.
@JsonSerializable(explicitToJson: true)
class AudioDeviceInfo {
  /// Construct the [AudioDeviceInfo].
  const AudioDeviceInfo({this.deviceId, this.deviceName});

  /// The device ID.
  @JsonKey(name: 'deviceId')
  final String? deviceId;

  /// The device name.
  @JsonKey(name: 'deviceName')
  final String? deviceName;

  /// @nodoc
  factory AudioDeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$AudioDeviceInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AudioDeviceInfoToJson(this);
}
