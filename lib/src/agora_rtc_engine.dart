import 'package:agora_rtc_engine/src/binding_forward_export.dart';
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

  /// 2: Video rendering device.
  @JsonValue(2)
  videoRenderDevice,

  /// 3: Video capturing device.
  @JsonValue(3)
  videoCaptureDevice,

  /// 4: Audio playback device for an app.
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

/// The playback state of the music file.
@JsonEnum(alwaysCreate: true)
enum AudioMixingStateType {
  /// 710: The music file is playing.
  @JsonValue(710)
  audioMixingStatePlaying,

  /// 711: The music file pauses playing.
  @JsonValue(711)
  audioMixingStatePaused,

  /// 713: The music file stops playing.The possible reasons include:audioMixingReasonAllLoopsCompleted(723)audioMixingReasonStoppedByUser(724)
  @JsonValue(713)
  audioMixingStateStopped,

  /// 714: An error occurs during the playback of the audio mixing file.The possible reasons include:audioMixingReasonCanNotOpen(701)audioMixingReasonTooFrequentCall(702)audioMixingReasonInterruptedEof(703)
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

/// The reason why the playback state of the music file changes. Reported in the onAudioMixingStateChanged callback.
@JsonEnum(alwaysCreate: true)
enum AudioMixingReasonType {
  /// 701: The SDK cannot open the music file. For example, the local music file does not exist, the SDK does not support the file format, or the the SDK cannot access the music file URL.
  @JsonValue(701)
  audioMixingReasonCanNotOpen,

  /// 702: The SDK opens the music file too frequently. If you need to call startAudioMixing multiple times, ensure that the call interval is more than 500 ms.
  @JsonValue(702)
  audioMixingReasonTooFrequentCall,

  /// 703: The music file playback is interrupted.
  @JsonValue(703)
  audioMixingReasonInterruptedEof,

  /// 721: The music file completes a loop playback.
  @JsonValue(721)
  audioMixingReasonOneLoopCompleted,

  /// 723: The music file completes all loop playback.
  @JsonValue(723)
  audioMixingReasonAllLoopsCompleted,

  /// 724: Successfully call stopAudioMixing to stop playing the music file.
  @JsonValue(724)
  audioMixingReasonStoppedByUser,

  /// 0: The SDK opens music file successfully.
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

/// The statistics of the local video stream.
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
      this.dualStreamEnabled,
      this.hwEncoderAccelerating});

  /// The user ID of the local user.
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

  /// The width (px) for capturing the local video stream.
  @JsonKey(name: 'captureFrameWidth')
  final int? captureFrameWidth;

  /// The height (px) for capturing the local video stream.
  @JsonKey(name: 'captureFrameHeight')
  final int? captureFrameHeight;

  /// The frame rate (fps) adjusted by the built-in video capture adapter (regulator) of the SDK for capturing the local video stream. The regulator adjusts the frame rate of the video captured by the camera according to the video encoding configuration.
  @JsonKey(name: 'regulatedCaptureFrameRate')
  final int? regulatedCaptureFrameRate;

  /// The width (px) adjusted by the built-in video capture adapter (regulator) of the SDK for capturing the local video stream. The regulator adjusts the height and width of the video captured by the camera according to the video encoding configuration.
  @JsonKey(name: 'regulatedCaptureFrameWidth')
  final int? regulatedCaptureFrameWidth;

  /// The height (px) adjusted by the built-in video capture adapter (regulator) of the SDK for capturing the local video stream. The regulator adjusts the height and width of the video captured by the camera according to the video encoding configuration.
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

  /// The quality adaptation of the local video stream in the reported interval (based on the target frame rate and target bitrate). See QualityAdaptIndication .
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

  /// The brightness level of the video image captured by the local camera. See CaptureBrightnessLevelType.
  @JsonKey(name: 'captureBrightnessLevel')
  final CaptureBrightnessLevelType? captureBrightnessLevel;

  /// @nodoc
  @JsonKey(name: 'dualStreamEnabled')
  final bool? dualStreamEnabled;

  /// The local video encoding acceleration type.
  @JsonKey(name: 'hwEncoderAccelerating')
  final int? hwEncoderAccelerating;

  /// @nodoc
  factory LocalVideoStats.fromJson(Map<String, dynamic> json) =>
      _$LocalVideoStatsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LocalVideoStatsToJson(this);
}

/// Statistics of the remote video stream.
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
      this.superResolutionType,
      this.mosValue});

  /// The user ID of the remote user sending the video stream.
  @JsonKey(name: 'uid')
  final int? uid;

  /// Deprecated:In scenarios where audio and video are synchronized, you can get the video delay data from networkTransportDelay and jitterBufferDelay in RemoteAudioStats .The video delay (ms).
  @JsonKey(name: 'delay')
  final int? delay;

  /// The width (pixels) of the video.
  @JsonKey(name: 'width')
  final int? width;

  /// The height (pixels) of the video.
  @JsonKey(name: 'height')
  final int? height;

  /// The bitrate (Kbps) of the remote video received since the last count.
  @JsonKey(name: 'receivedBitrate')
  final int? receivedBitrate;

  /// The frame rate (fps) of decoding the remote video.
  @JsonKey(name: 'decoderOutputFrameRate')
  final int? decoderOutputFrameRate;

  /// The frame rate (fps) of rendering the remote video.
  @JsonKey(name: 'rendererOutputFrameRate')
  final int? rendererOutputFrameRate;

  /// The packet loss rate (%) of the remote video.
  @JsonKey(name: 'frameLossRate')
  final int? frameLossRate;

  /// The packet loss rate (%) of the remote video after using the anti-packet-loss technology.
  @JsonKey(name: 'packetLossRate')
  final int? packetLossRate;

  /// The type of the video stream. See VideoStreamType .
  @JsonKey(name: 'rxStreamType')
  final VideoStreamType? rxStreamType;

  /// The total freeze time (ms) of the remote video stream after the remote user joins the channel. In a video session where the frame rate is set to no less than 5 fps, video freeze occurs when the time interval between two adjacent renderable video frames is more than 500 ms.
  @JsonKey(name: 'totalFrozenTime')
  final int? totalFrozenTime;

  /// The total video freeze time as a percentage (%) of the total time the video is available. The video is considered available as long as that the remote user neither stops sending the video stream nor disables the video module after joining the channel.
  @JsonKey(name: 'frozenRate')
  final int? frozenRate;

  /// The amount of time (ms) that the audio is ahead of the video.If this value is negative, the audio is lagging behind the video.
  @JsonKey(name: 'avSyncTimeMs')
  final int? avSyncTimeMs;

  /// The total active time (ms) of the video.As long as the remote user or host neither stops sending the video stream nor disables the video module after joining the channel, the video is available.
  @JsonKey(name: 'totalActiveTime')
  final int? totalActiveTime;

  /// The total duration (ms) of the remote video stream.
  @JsonKey(name: 'publishDuration')
  final int? publishDuration;

  /// The state of super resolution:>0: Super resolution is enabled.=0: Super resolution is not enabled.
  @JsonKey(name: 'superResolutionType')
  final int? superResolutionType;

  /// @nodoc
  @JsonKey(name: 'mosValue')
  final int? mosValue;

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

/// The cloud proxy type.
@JsonEnum(alwaysCreate: true)
enum CloudProxyType {
  /// 0: The automatic mode. The SDK has this mode enabled by default. In this mode, the SDK attempts a direct connection to SD-RTN™ and automatically switches to TCP/TLS 443 if the attempt fails.
  @JsonValue(0)
  noneProxy,

  /// 1: The cloud proxy for the UDP protocol, that is, the Force UDP cloud proxy mode. In this mode, the SDK always transmits data over UDP.
  @JsonValue(1)
  udpProxy,

  /// 2: The cloud proxy for the TCP (encryption) protocol, that is, the Force TCP cloud proxy mode. In this mode, the SDK always transmits data over TCP/TLS 443.
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

/// The camera capturer preference.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CameraCapturerConfiguration {
  /// @nodoc
  const CameraCapturerConfiguration(
      {this.cameraDirection,
      this.deviceId,
      this.format,
      this.followEncodeDimensionRatio});

  /// This parameter applies to Android and iOS only.The camera direction. See CameraDirection .
  @JsonKey(name: 'cameraDirection')
  final CameraDirection? cameraDirection;

  /// This method applies to Windows only.The ID of the camera. The maximum length is MaxDeviceIdLengthType .
  @JsonKey(name: 'deviceId')
  final String? deviceId;

  /// The format of the video frame. See VideoFormat .
  @JsonKey(name: 'format')
  final VideoFormat? format;

  /// Whether to follow the video aspect ratio set in setVideoEncoderConfiguration :true: (Default) Follow the set video aspect ratio. The SDK crops the captured video according to the set video aspect ratio and synchronously changes the local preview screen and the video frame in onCaptureVideoFrame and onPreEncodeVideoFrame .false: Do not follow the set video aspect ratio. The SDK does not change the aspect ratio of the captured video frame.
  @JsonKey(name: 'followEncodeDimensionRatio')
  final bool? followEncodeDimensionRatio;

  /// @nodoc
  factory CameraCapturerConfiguration.fromJson(Map<String, dynamic> json) =>
      _$CameraCapturerConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$CameraCapturerConfigurationToJson(this);
}

/// The configuration of the captured screen.
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

  /// Whether to capture the window on the screen:true: Capture the window.false: (Default) Capture the screen, not the window.
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

  /// (For Windows and macOS only) The relative position of the shared region to the whole screen. See Rectangle .If you do not set this parameter, the SDK shares the whole screen. If the region you set exceeds the boundary of the screen, only the region within in the screen is shared. If you setwidth or height in Rectangle as 0, the whole screen is shared.
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

/// The image content of the thumbnail or icon. Set in ScreenCaptureSourceInfo .
/// The default image is in the ARGB format. If you need to use another format, you need to convert the image on your own.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ThumbImageBuffer {
  /// @nodoc
  const ThumbImageBuffer({this.buffer, this.length, this.width, this.height});

  /// The buffer of the thumbnail or icon.
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

  /// 1: The shared target is a screen of a particular monitor.
  @JsonValue(1)
  screencapturesourcetypeScreen,

  /// 2: Reserved parameter
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

/// The information about the specified shareable window or screen.
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
      this.isOccluded,
      this.minimizeWindow});

  /// The type of the shared target. See ScreenCaptureSourceType .
  @JsonKey(name: 'type')
  final ScreenCaptureSourceType? type;

  /// The window ID for a window or the display ID for a screen.
  @JsonKey(name: 'sourceId')
  final int? sourceId;

  /// The name of the window or screen. UTF-8 encoding.
  @JsonKey(name: 'sourceName')
  final String? sourceName;

  /// The image content of the thumbnail. See
  @JsonKey(name: 'thumbImage')
  final ThumbImageBuffer? thumbImage;

  /// The image content of the icon. See
  @JsonKey(name: 'iconImage')
  final ThumbImageBuffer? iconImage;

  /// The process to which the window belongs. UTF-8 encoding.
  @JsonKey(name: 'processPath')
  final String? processPath;

  /// The title of the window. UTF-8 encoding.
  @JsonKey(name: 'sourceTitle')
  final String? sourceTitle;

  /// Determines whether the screen is the primary display:true: The screen is the primary display.false: The screen is not the primary display.
  @JsonKey(name: 'primaryMonitor')
  final bool? primaryMonitor;

  /// @nodoc
  @JsonKey(name: 'isOccluded')
  final bool? isOccluded;

  /// (For Windows only) Whether the window is minimized:true: The window is minimized.false: The window is not minimized.
  @JsonKey(name: 'minimizeWindow')
  final bool? minimizeWindow;

  /// @nodoc
  factory ScreenCaptureSourceInfo.fromJson(Map<String, dynamic> json) =>
      _$ScreenCaptureSourceInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ScreenCaptureSourceInfoToJson(this);
}

/// The advanced options for audio.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AdvancedAudioOptions {
  /// @nodoc
  const AdvancedAudioOptions({this.audioProcessingChannels});

  /// The number of channels for audio preprocessing. See audioprocessingchannels .
  @JsonKey(name: 'audioProcessingChannels')
  final int? audioProcessingChannels;

  /// @nodoc
  factory AdvancedAudioOptions.fromJson(Map<String, dynamic> json) =>
      _$AdvancedAudioOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AdvancedAudioOptionsToJson(this);
}

/// Image configurations
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ImageTrackOptions {
  /// @nodoc
  const ImageTrackOptions({this.imageUrl, this.fps, this.mirrorMode});

  /// The URL of the image that you want to use to replace the video feeds. The image must be in PNG format. This method supports adding an image from the local absolute or relative file path.
  @JsonKey(name: 'imageUrl')
  final String? imageUrl;

  /// The frame rate of the video streams being published. The value range is [1,30]. The default value is 1.
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

/// The channel media options.
/// Agora supports publishing multiple audio streams and one video stream at the same time and in the same RtcConnection . For example, publishMicrophoneTrack, publishAudioTrack, publishCustomAudioTrack, and publishMediaPlayerAudioTrack can be set as true at the same time, but only one of publishCameraTrack, publishCustomVideoTrack, or publishEncodedVideoTrack can be set as true.
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

  /// Whether to publish the video captured by the camera:true: (Default) Publish the video captured by the camera.false: Do not publish the video captured by the camera.
  @JsonKey(name: 'publishCameraTrack')
  final bool? publishCameraTrack;

  /// Whether to publish the video captured by the second camera: true: Publish the video captured by the second camera. false: (Default) Do not publish the video captured by the second camera.
  @JsonKey(name: 'publishSecondaryCameraTrack')
  final bool? publishSecondaryCameraTrack;

  /// Whether to publish the audio captured by the microphone:true: (Default) Publish the audio captured by the microphone.false: Do not publish the audio captured by the microphone.
  @JsonKey(name: 'publishMicrophoneTrack')
  final bool? publishMicrophoneTrack;

  /// Whether to publish the video captured from the screen:true: Publish the video captured from the screen.false: (Default) Do not publish the captured video from the screen.This parameter applies to Android and iOS only.
  @JsonKey(name: 'publishScreenCaptureVideo')
  final bool? publishScreenCaptureVideo;

  /// Whether to publish the audio captured from the screen: true: Publish the audio captured from the screen. false: (Default) Do not publish the audio captured from the screen. This parameter applies to Android and iOS only.
  @JsonKey(name: 'publishScreenCaptureAudio')
  final bool? publishScreenCaptureAudio;

  /// Whether to publish the video captured from the screen: true: Publish the video captured from the screen. false: (Default) Do not publish the captured video from the screen.
  @JsonKey(name: 'publishScreenTrack')
  final bool? publishScreenTrack;

  /// Whether to publish the video captured from the second screen:true: Publish the captured video from the second screen.false: (Default) Do not publish the video captured from the second screen.
  @JsonKey(name: 'publishSecondaryScreenTrack')
  final bool? publishSecondaryScreenTrack;

  /// Whether to publish the audio captured from a custom source:true: Publish the captured audio from a custom source.false: (Default) Do not publish the audio captured from the custom source.
  @JsonKey(name: 'publishCustomAudioTrack')
  final bool? publishCustomAudioTrack;

  /// The ID of the custom audio source to publish. The default value is 0.If you have set the value of sourceNumber greater than 1 in setExternalAudioSource , the SDK creates the corresponding number of custom audio tracks and assigns an ID to each audio track starting from 0.
  @JsonKey(name: 'publishCustomAudioSourceId')
  final int? publishCustomAudioSourceId;

  /// Whether to enable AEC when publishing the audio captured from a custom source:true: Enable AEC when publishing the captured audio from a custom source.false: (Default) Do not enable AEC when publishing the audio captured from the custom source.
  @JsonKey(name: 'publishCustomAudioTrackEnableAec')
  final bool? publishCustomAudioTrackEnableAec;

  /// @nodoc
  @JsonKey(name: 'publishDirectCustomAudioTrack')
  final bool? publishDirectCustomAudioTrack;

  /// @nodoc
  @JsonKey(name: 'publishCustomAudioTrackAec')
  final bool? publishCustomAudioTrackAec;

  /// Whether to publish the video captured from a custom source:true: Publish the captured video from a custom source.false: (Default) Do not publish the video captured from the custom source.
  @JsonKey(name: 'publishCustomVideoTrack')
  final bool? publishCustomVideoTrack;

  /// Whether to publish the encoded video:true: Publish the encoded video.false: (Default) Do not publish the encoded video.
  @JsonKey(name: 'publishEncodedVideoTrack')
  final bool? publishEncodedVideoTrack;

  /// Whether to publish the audio from the media player:true: Publish the audio from the media player.false: (Default) Do not publish the audio from the media player.
  @JsonKey(name: 'publishMediaPlayerAudioTrack')
  final bool? publishMediaPlayerAudioTrack;

  /// Whether to publish the video from the media player:true: Publish the video from the media player.false: (Default) Do not publish the video from the media player.
  @JsonKey(name: 'publishMediaPlayerVideoTrack')
  final bool? publishMediaPlayerVideoTrack;

  /// Whether to publish the local transcoded video:true: Publish the local transcoded video.false: (Default) Do not publish the local transcoded video.
  @JsonKey(name: 'publishTrancodedVideoTrack')
  final bool? publishTrancodedVideoTrack;

  /// Whether to automatically subscribe to all remote audio streams when the user joins a channel:true: (Default) Subscribe to all remote audio streams.false: Do not automatically subscribe to any remote audio streams.
  @JsonKey(name: 'autoSubscribeAudio')
  final bool? autoSubscribeAudio;

  /// Whether to automatically subscribe to all remote video streams when the user joins the channel:true: (Default) Subscribe to all remote video streams.false: Do not automatically subscribe to any remote video streams.
  @JsonKey(name: 'autoSubscribeVideo')
  final bool? autoSubscribeVideo;

  /// Whether to enable audio capturing or playback:true: (Default) Enable audio capturing or playback.false: Do not enable audio capturing or playback.
  @JsonKey(name: 'enableAudioRecordingOrPlayout')
  final bool? enableAudioRecordingOrPlayout;

  /// The ID of the media player to be published. The default value is 0.
  @JsonKey(name: 'publishMediaPlayerId')
  final int? publishMediaPlayerId;

  /// The user role. See ClientRoleType .
  @JsonKey(name: 'clientRoleType')
  final ClientRoleType? clientRoleType;

  /// The latency level of an audience member in interactive live streaming. See AudienceLatencyLevelType .
  ///
  @JsonKey(name: 'audienceLatencyLevel')
  final AudienceLatencyLevelType? audienceLatencyLevel;

  /// The default video-stream type. See VideoStreamType .
  ///
  @JsonKey(name: 'defaultVideoStreamType')
  final VideoStreamType? defaultVideoStreamType;

  /// The channel profile. See ChannelProfileType .
  ///
  @JsonKey(name: 'channelProfile')
  final ChannelProfileType? channelProfile;

  /// @nodoc
  @JsonKey(name: 'audioDelayMs')
  final int? audioDelayMs;

  /// @nodoc
  @JsonKey(name: 'mediaPlayerAudioDelayMs')
  final int? mediaPlayerAudioDelayMs;

  /// (Optional) The token generated on your server for authentication. See This parameter takes effect only when calling updateChannelMediaOptions or updateChannelMediaOptionsEx .Ensure that the App ID, channel name, and user name used for creating the token are the same as those used by the initialize method for initializing the RTC engine, and those used by the joinChannel [2/2] and joinChannelEx methods for joining the channel.
  @JsonKey(name: 'token')
  final String? token;

  /// @nodoc
  @JsonKey(name: 'enableBuiltInMediaEncryption')
  final bool? enableBuiltInMediaEncryption;

  /// Whether to publish the sound of a metronome to remote users:true: (Default) Publish the sound of the metronome. Both the local user and remote users can hear the metronome.false: Do not publish the sound of the metronome. Only the local user can hear the metronome.
  @JsonKey(name: 'publishRhythmPlayerTrack')
  final bool? publishRhythmPlayerTrack;

  /// Whether to enable interactive mode:true: Enable interactive mode. Once this mode is enabled and the user role is set as audience, the user can receive remote video streams with low latency.false: (Default) Do not enable interactive mode. If this mode is disabled, the user receives the remote video streams in default settings.This parameter only applies to scenarios involving cohosting across channels. The cohosts need to call the joinChannelEx method to join the other host's channel as an audience member, and set isInteractiveAudience to true.This parameter takes effect only when the user role is clientRoleAudience.
  @JsonKey(name: 'isInteractiveAudience')
  final bool? isInteractiveAudience;

  /// The video track ID returned by calling createCustomVideoTrack the method. The default value is 0.
  @JsonKey(name: 'customVideoTrackId')
  final int? customVideoTrackId;

  /// Whether the audio stream being published is filtered according to the volume algorithm:true: (Default) The audio stream is filtered. If the audio stream filter is not enabled, this setting does not takes effect.false: The audio stream is not filtered.If you need to enable this function, contact .
  @JsonKey(name: 'isAudioFilterable')
  final bool? isAudioFilterable;

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

/// The cloud proxy type.
@JsonEnum(alwaysCreate: true)
enum ProxyType {
  /// 0: Reserved for future use.
  @JsonValue(0)
  noneProxyType,

  /// 1: The cloud proxy for the UDP protocol, that is, the Force UDP cloud proxy mode. In this mode, the SDK always transmits data over UDP.
  @JsonValue(1)
  udpProxyType,

  /// 2: The cloud proxy for the TCP (encryption) protocol, that is, the Force TCP cloud proxy mode. In this mode, the SDK always transmits data over TCP/TLS 443.
  @JsonValue(2)
  tcpProxyType,

  /// 3: Reserved for future use.
  @JsonValue(3)
  localProxyType,

  /// 4: Automatic mode. In this mode, the SDK attempts a direct connection to SD-RTN™ and automatically switches to TCP/TLS 443 if the attempt fails.
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
      this.advancedConfig});

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
  factory LocalAccessPointConfiguration.fromJson(Map<String, dynamic> json) =>
      _$LocalAccessPointConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LocalAccessPointConfigurationToJson(this);
}

/// The options for leaving a channel.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LeaveChannelOptions {
  /// @nodoc
  const LeaveChannelOptions(
      {this.stopAudioMixing, this.stopAllEffect, this.stopMicrophoneRecording});

  /// Whether to stop playing and mixing the music file when a user leaves the channel. true: (Default) Stop playing and mixing the music file.false: Do not stop playing and mixing the music file.
  @JsonKey(name: 'stopAudioMixing')
  final bool? stopAudioMixing;

  /// Whether to stop playing all audio effects when a user leaves the channel. true: (Default) Stop playing all audio effects.false: Do not stop playing any audio effect.
  @JsonKey(name: 'stopAllEffect')
  final bool? stopAllEffect;

  /// Whether to stop microphone recording when a user leaves the channel. true: (Default) Stop microphone recording.false: Do not stop microphone recording.
  @JsonKey(name: 'stopMicrophoneRecording')
  final bool? stopMicrophoneRecording;

  /// @nodoc
  factory LeaveChannelOptions.fromJson(Map<String, dynamic> json) =>
      _$LeaveChannelOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LeaveChannelOptionsToJson(this);
}

/// RtcEngineEventHandlerThe SDK uses the interface to send event notifications to your app. Your app can get those notifications through methods that inherit this interface.
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
    this.onAudioMixingPositionChanged,
    this.onAudioMixingFinished,
    this.onAudioEffectFinished,
    this.onVideoDeviceStateChanged,
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
    this.onLicenseValidationFailure,
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

  /// Occurs when a user joins a channel.
  /// This callback notifies the application that a user joins a specified channel.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [elapsed] The time elapsed (ms) from the local user calling joinChannel [2/2] until the SDK triggers this callback.
  final void Function(RtcConnection connection, int elapsed)?
      onJoinChannelSuccess;

  /// Occurs when a user rejoins the channel.
  /// When a user loses connection with the server because of network problems, the SDK automatically tries to reconnect and triggers this callback upon reconnection.
  ///
  /// * [elapsed] Time elapsed (ms) from the local user calling the joinChannel [1/2] or joinChannel [2/2] method until this callback is triggered.
  final void Function(RtcConnection connection, int elapsed)?
      onRejoinChannelSuccess;

  /// Reports the proxy connection state.
  /// You can use this callback to listen for the state of the SDK connecting to a proxy. For example, when a user calls setCloudProxy and joins a channel successfully, the SDK triggers this callback to report the user ID, the proxy type connected, and the time elapsed fromthe user calling joinChannel [1/2] until this callback is triggered.
  ///
  /// * [channel] The channel name.
  /// * [uid] The user ID.
  /// * [localProxyIp] Reserved for future use.
  /// * [elapsed] The time elapsed (ms) from the user calling joinChannel [1/2] until this callback is triggered.
  final void Function(String channel, int uid, ProxyType proxyType,
      String localProxyIp, int elapsed)? onProxyConnected;

  /// Reports an error during SDK runtime.
  /// This callback indicates that an error (concerning network or media) occurs during SDK runtime. In most cases, the SDK cannot fix the issue and resume running. The SDK requires the application to take action or informs the user about the issue.
  ///
  /// * [err] Error code. See ErrorCodeType .
  /// * [msg] The error message.
  final void Function(ErrorCodeType err, String msg)? onError;

  /// Reports the statistics of the audio stream from each remote user.
  /// Deprecated:Please use onRemoteAudioStats instead.The SDK triggers this callback once every two seconds to report the audio quality of each remote user/host sending an audio stream. If a channel has multiple users/hosts sending audio streams, the SDK triggers this callback as many times.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [remoteUid] The user ID of the remote user sending the audio stream.
  /// * [quality] Audio quality of the user. See QualityType .
  /// * [delay] The network delay (ms) from the sender to the receiver, including the delay caused by audio sampling pre-processing, network transmission, and network jitter buffering.
  /// * [lost] The packet loss rate (%) of the audio packet sent from the remote user.
  final void Function(RtcConnection connection, int remoteUid,
      QualityType quality, int delay, int lost)? onAudioQuality;

  /// Reports the last mile network probe result.
  /// The SDK triggers this callback within 30 seconds after the app calls startLastmileProbeTest .
  ///
  /// * [result] The uplink and downlink last-mile network probe test result. See LastmileProbeResult .
  final void Function(LastmileProbeResult result)? onLastmileProbeResult;

  /// Reports the volume information of users.
  /// By default, this callback is disabled. You can enable it by calling enableAudioVolumeIndication . Once this callback is enabled and users send streams in the channel, the SDK triggers the onAudioVolumeIndication callback according to the time interval set in enableAudioVolumeIndication. The SDK triggers two independent onAudioVolumeIndication callbacks simultaneously, which separately report the volume information of the local user who sends a stream and the remote users (up to three) whose instantaneous volume is the highest.Once this callback is enabled, if the local user calls the muteLocalAudioStream method for mute, the SDK continues to report the volume indication of the local user.20 seconds after a remote user whose volume is one of the three highest in the channel stops publishing the audio stream, the callback excludes this user's information; 20 seconds after all remote users stop publishing audio streams, the SDK stops triggering the callback for remote users.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [speakers] The volume information of the users. See AudioVolumeInfo . An empty speakers array in the callback indicates that no remote user is in the channel or sending a stream at the moment.
  /// * [speakerNumber] The total number of users.In the callback for the local user, if the local user is sending streams, the value of speakerNumber is 1.In the callback for remote users, the value range of speakerNumber is [0,3]. If the number of remote users who send streams is greater than or equal to three, the value of speakerNumber is 3.
  /// * [totalVolume] The volume of the speaker. The value ranges between 0 (lowest volume) and 255 (highest volume).In the callback for the local user, totalVolume is the volume of the local user who sends a stream.In the callback for remote users, totalVolume is the sum of the volume of the remote users (up to three) whose instantaneous volume are the highest.
  final void Function(RtcConnection connection, List<AudioVolumeInfo> speakers,
      int speakerNumber, int totalVolume)? onAudioVolumeIndication;

  /// Occurs when a user leaves a channel.
  /// This callback notifies the app that the user leaves the channel by calling leaveChannel . From this callback, the app can get information such as the call duration and quality statistics.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [stats] The statistics of the call. See RtcStats .
  final void Function(RtcConnection connection, RtcStats stats)? onLeaveChannel;

  /// Reports the statistics of the current call.
  /// The SDK triggers this callback once every two seconds after the user joins the channel.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [stats] Statistics of the RTC engine. See RtcStats .
  ///
  final void Function(RtcConnection connection, RtcStats stats)? onRtcStats;

  /// Occurs when the audio device state changes.
  /// This callback notifies the application that the system's audio device state is changed. For example, a headset is unplugged from the device.This method is for Windows and macOS only.
  ///
  /// * [deviceState] Media device states.
  /// * [deviceId] The device ID.
  /// * [deviceType] The device type. See MediaDeviceType .
  final void Function(String deviceId, MediaDeviceType deviceType,
      MediaDeviceStateType deviceState)? onAudioDeviceStateChanged;

  /// @nodoc
  final void Function(int position)? onAudioMixingPositionChanged;

  /// Occurs when the playback of the local music file finishes.
  /// Deprecated:Please use onAudioMixingStateChanged instead.After you call startAudioMixing to play a local music file, this callback occurs when the playback finishes. If the call startAudioMixing fails, the error code WARN_AUDIO_MIXING_OPEN_ERROR is returned.
  final void Function()? onAudioMixingFinished;

  /// Occurs when the playback of the local music file finishes.
  /// This callback occurs when the local audio effect file finishes playing.
  ///
  /// * [soundId] The audio effect ID. The ID of each audio effect file is unique.
  final void Function(int soundId)? onAudioEffectFinished;

  /// Occurs when the video device state changes.
  /// This callback reports the change of system video devices, such as being unplugged or removed. On a Windows device with an external camera for video capturing, the video disables once the external camera is unplugged.This callback is for Windows and macOS only.
  ///
  /// * [deviceId] The device ID.
  /// * [deviceType] Media device types. See MediaDeviceType .
  /// * [deviceState] Media device states.
  final void Function(String deviceId, MediaDeviceType deviceType,
      MediaDeviceStateType deviceState)? onVideoDeviceStateChanged;

  /// Reports the last mile network quality of each user in the channel.
  /// This callback reports the last mile network conditions of each user in the channel. Last mile refers to the connection between the local device and Agora's edge server.The SDK triggers this callback once every two seconds. If a channel includes multiple users, the SDK triggers this callback as many times.txQuality is rxQuality is
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [remoteUid] The user ID. The network quality of the user with this user ID is reported.
  /// * [txQuality] Uplink network quality rating of the user in terms of the transmission bit rate, packet loss rate, average RTT (Round-Trip Time) and jitter of the uplink network. This parameter is a quality rating helping you understand how well the current uplink network conditions can support the selected video encoder configuration. For example, a 1000 Kbps uplink network may be adequate for video frames with a resolution of 640 × 480 and a frame rate of 15 fps in the LIVE_BROADCASTING profile, but may be inadequate for resolutions higher than 1280 × 720. See QualityType .
  /// * [rxQuality] Downlink network quality rating of the user in terms of packet loss rate, average RTT, and jitter of the downlink network. See QualityType .
  final void Function(RtcConnection connection, int remoteUid,
      QualityType txQuality, QualityType rxQuality)? onNetworkQuality;

  /// @nodoc
  final void Function(RtcConnection connection)? onIntraRequestReceived;

  /// Occurs when the uplink network information changes.
  /// The SDK triggers this callback when the uplink network information changes.This callback only applies to scenarios where you push externally encoded video data in H.264 format to the SDK.
  ///
  /// * [info] The uplink network information. See UplinkNetworkInfo .
  final void Function(UplinkNetworkInfo info)? onUplinkNetworkInfoUpdated;

  /// @nodoc
  final void Function(DownlinkNetworkInfo info)? onDownlinkNetworkInfoUpdated;

  /// Reports the last-mile network quality of the local user.
  /// This callback reports the last-mile network conditions of the local user before the user joins the channel. Last mile refers to the connection between the local device and Agora's edge server.Before the user joins the channel, this callback is triggered by the SDK once startLastmileProbeTest is called and reports the last-mile network conditions of the local user.
  ///
  /// * [quality] The last-mile network quality.
  ///  qualityUnknown(0): The quality is unknown.
  ///  qualityExcellent(1): The quality is excellent.
  ///  qualityGood(2): The network quality seems excellent, but the bitrate can be slightly lower than excellent.
  ///  qualityPoor(3): Users can feel the communication is slightly impaired.
  ///  qualityBad(4): Users cannot communicate smoothly.
  ///  qualityVbad(5): The quality is so bad that users can barely communicate.
  ///  qualityDown(6): The network is down, and users cannot communicate at all.
  ///  See QualityType .
  final void Function(QualityType quality)? onLastmileQuality;

  /// Occurs when the first local video frame is displayed on the local video view.
  /// The SDK triggers this callback when the first local video frame is displayed on the local video view.
  ///
  /// * [source] The capture type of the custom video source. See VideoSourceType .
  /// * [connection] The connection information. See RtcConnection .
  /// * [width] The width (px) of the first local video frame.
  /// * [height] The height (px) of the first local video frame.
  /// * [elapsed] Time elapsed (ms) from the local user calling joinChannel [2/2] until the SDK triggers this callback. If you call startPreview before calling joinChannel [2/2], then this parameter is the time elapsed from calling the startPreview method until the SDK triggers this callback.
  final void Function(
          VideoSourceType source, int width, int height, int elapsed)?
      onFirstLocalVideoFrame;

  /// Occurs when the first video frame is published.
  /// The SDK triggers this callback under one of the following circumstances:The local client enables the video module and calls joinChannel [2/2] successfully.The local client calls muteLocalVideoStream (true) and muteLocalVideoStream(false) in sequence.The local client calls disableVideo and enableVideo in sequence.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [elapsed] Time elapsed (ms) from the local user calling joinChannel [2/2] until the SDK triggers this callback.
  final void Function(RtcConnection connection, int elapsed)?
      onFirstLocalVideoFramePublished;

  /// Occurs when the first remote video frame is received and decoded.
  /// The SDK triggers this callback under one of the following circumstances:The remote user joins the channel and sends the video stream.The remote user stops sending the video stream and re-sends it after 15 seconds. Reasons for such an interruption include:The remote user leaves the channel.The remote user drops offline.The remote user calls muteLocalVideoStream to stop sending the video stream.The remote user calls disableVideo to disable video.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [remoteUid] The ID of the remote user sending the video stream.
  /// * [width] The width (px) of the video stream.
  /// * [height] The height (px) of the video stream.
  /// * [elapsed] The time elapsed (ms) from the local user calling joinChannel [2/2] until the SDK triggers this callback.
  final void Function(RtcConnection connection, int remoteUid, int width,
      int height, int elapsed)? onFirstRemoteVideoDecoded;

  /// Occurs when the video size or rotation of a specified user changes.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [sourceType] The capture type of the custom video source. See VideoSourceType .
  /// * [uid] The ID of the user whose video size or rotation changes. (The uid for the local user is 0. The video is the local user's video preview).
  /// * [width] The width (pixels) of the video stream.
  /// * [height] The height (pixels) of the video stream.
  /// * [rotation] The rotation information. The value range is [0,360).
  final void Function(RtcConnection connection, VideoSourceType sourceType,
      int uid, int width, int height, int rotation)? onVideoSizeChanged;

  /// Occurs when the local video stream state changes.
  /// When the state of the local video stream changes (including the state of the video capture and encoding), the SDK triggers this callback to report the current state. This callback indicates the state of the local video stream, including camera capturing and video encoding, and allows you to troubleshoot issues when exceptions occur.The SDK triggers the onLocalVideoStateChanged callback with the state code of localVideoStreamStateFailed and error code of localVideoStreamErrorCaptureFailure in the following situations:The app switches to the background, and the system gets the camera resource.The camera starts normally, but does not output video frames for four consecutive seconds.When the camera outputs the captured video frames, if the video frames are the same for 15 consecutive frames, the SDK triggers the onLocalVideoStateChanged callback with the state code of localVideoStreamStateCapturing and error code of localVideoStreamErrorCaptureFailure. Note that the video frame duplication detection is only available for video frames with a resolution greater than 200 × 200, a frame rate greater than or equal to 10 fps, and a bitrate less than 20 Kbps.For some device models, the SDK does not trigger this callback when the state of the local video changes while the local video capturing device is in use, so you have to make your own timeout judgment.
  ///
  /// * [source] The capture type of the custom video source. See VideoSourceType .
  /// * [state] The state of the local video, see LocalVideoStreamState .
  /// * [error] The detailed error information, see LocalVideoStreamError .
  final void Function(VideoSourceType source, LocalVideoStreamState state,
      LocalVideoStreamError error)? onLocalVideoStateChanged;

  /// Occurs when the remote video stream state changes.
  /// This callback does not work properly when the number of users (in the communication profile) or hosts (in the live streaming channel) in a channel exceeds 17.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [remoteUid] The ID of the remote user whose video state changes.
  /// * [state] The state of the remote video, see RemoteVideoState .
  /// * [reason] The reason for the remote video state change, see RemoteVideoStateReason .
  /// * [elapsed] Time elapsed (ms) from the local user calling the joinChannel [2/2] method until the SDK triggers this callback.
  final void Function(
      RtcConnection connection,
      int remoteUid,
      RemoteVideoState state,
      RemoteVideoStateReason reason,
      int elapsed)? onRemoteVideoStateChanged;

  /// Occurs when the renderer receives the first frame of the remote video.
  ///
  /// * [uid] The ID of the remote user sending the video stream.
  /// * [connection] The connection information. See RtcConnection .
  /// * [width] The width (px) of the video stream.
  /// * [height] The height (px) of the video stream.
  /// * [elapsed] The time elapsed (ms) from the local user calling joinChannel [2/2] until the SDK triggers this callback.
  final void Function(RtcConnection connection, int remoteUid, int width,
      int height, int elapsed)? onFirstRemoteVideoFrame;

  /// Occurs when a remote user (COMMUNICATION)/ host (LIVE_BROADCASTING) joins the channel.
  /// In a communication channel, this callback indicates that a remote user joins the channel. The SDK also triggers this callback to report the existing users in the channel when a user joins the channel.In a live-broadcast channel, this callback indicates that a host joins the channel. The SDK also triggers this callback to report the existing hosts in the channel when a host joins the channel. Agora recommends limiting the number of hosts to 17.The SDK triggers this callback under one of the following circumstances:A remote user/host joins the channel by calling the joinChannel [2/2] method.A remote user switches the user role to the host after joining the channel.A remote user/host rejoins the channel after a network interruption.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [remoteUid] The ID of the user or host who joins the channel.
  /// * [elapsed] Time delay (ms) from the local user calling joinChannel [2/2] until this callback is triggered.
  final void Function(RtcConnection connection, int remoteUid, int elapsed)?
      onUserJoined;

  /// Occurs when a remote user (in the communication profile)/ host (in the live streaming profile) leaves the channel.
  /// There are two reasons for users to become offline:Leave the channel: When a user/host leaves the channel, the user/host sends a goodbye message. When this message is received, the SDK determines that the user/host leaves the channel.Drop offline: When no data packet of the user or host is received for a certain period of time (20 seconds for the communication profile, and more for the live broadcast profile), the SDK assumes that the user/host drops offline. A poor network connection may lead to false detections. It's recommended to use the Agora RTM SDK for reliable offline detection.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [remoteUid] The ID of the user who leaves the channel or goes offline.
  /// * [reason] Reasons why the user goes offline: UserOfflineReasonType .
  final void Function(RtcConnection connection, int remoteUid,
      UserOfflineReasonType reason)? onUserOffline;

  /// Occurs when a remote user (in the communication profile) or a host (in the live streaming profile) stops/resumes sending the audio stream.
  /// The SDK triggers this callback when the remote user stops or resumes sending the audio stream by calling the muteLocalAudioStream method.This callback does not work properly when the number of users (in the communication profile) or hosts (in the live streaming channel) in a channel exceeds 17.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [remoteUid] The user ID.
  /// * [muted] Whether the remote user's audio stream is muted/unmuted:true: User's audio stream is muted.false: User's audio stream is unmuted.
  final void Function(RtcConnection connection, int remoteUid, bool muted)?
      onUserMuteAudio;

  /// Occurs when a remote user stops/resumes publishing the video stream.
  /// When a remote user calls muteLocalVideoStream to stop or resume publishing the video stream, the SDK triggers this callback to report the state of the remote user's publishing stream to the local user.This callback can be inaccurate when the number of users (in the communication profile) or hosts (in the live streaming profile) in a channel exceeds 17.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [remoteUid] The user ID of the remote user.
  /// * [muted] Whether the remote user stops publishing the video stream:true: The remote user stops publishing the video stream.false: The remote user resumes publishing the video stream.
  final void Function(RtcConnection connection, int remoteUid, bool muted)?
      onUserMuteVideo;

  /// Occurs when a remote user enables/disables the video module.
  /// Once the video module is disabled, the user can only use a voice call. The user cannot send or receive any video.The SDK triggers this callback when a remote user enables or disables the video module by calling the enableVideo or disableVideo method.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [remoteUid] The user ID of the remote user.
  /// * [enabled] true: Enable.false: Disable.
  final void Function(RtcConnection connection, int remoteUid, bool enabled)?
      onUserEnableVideo;

  /// @nodoc
  final void Function(RtcConnection connection, int remoteUid, int state)?
      onUserStateChanged;

  /// Occurs when a specific remote user enables/disables the local video capturing function.
  /// The SDK triggers this callback when the remote user resumes or stops capturing the video stream by calling the enableLocalVideo method.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [remoteUid] The user ID of the remote user.
  /// * [enabled] Whether the specified remote user enables/disables the local video capturing function:true: Enable. Other users in the channel can see the video of this remote user.false: Disable. Other users in the channel can no longer receive the video stream from this remote user, while this remote user can still receive the video streams from other users.
  final void Function(RtcConnection connection, int remoteUid, bool enabled)?
      onUserEnableLocalVideo;

  /// Occurs when a method is executed by the SDK.
  /// Deprecated:Deprecated as of v4.1.0. This method can neither accurately characterize the specific API method nor represent the execution result of the API.Agora recommends getting the results of the API implementation through relevant channels and media callbacks. For example, after calling the enableLocalAudio method to enable the microphone, the status of the microphone is returned in the onLocalAudioStateChanged callback.
  ///
  /// * [err] The error code returned by the SDK when the method call fails. If the SDK returns 0, then the method call is successful.
  /// * [api] The method executed by the SDK.
  /// * [result] The result of the method call.
  final void Function(ErrorCodeType err, String api, String result)?
      onApiCallExecuted;

  /// Reports the statistics of the local audio stream.
  /// The SDK triggers this callback once every two seconds.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [stats] Local audio statistics. See LocalAudioStats .
  final void Function(RtcConnection connection, LocalAudioStats stats)?
      onLocalAudioStats;

  /// Reports the statistics of the audio stream sent by each remote users.
  /// The SDK triggers this callback once every two seconds. If a channel includes multiple users, the SDK triggers this callback as many times.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [stats] Statistics of the received remote audio stream. See RemoteAudioStats .
  final void Function(RtcConnection connection, RemoteAudioStats stats)?
      onRemoteAudioStats;

  /// Reports the statistics of the local video stream.
  /// The SDK triggers this callback once every two seconds to report the statistics of the local video stream.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [stats] The statistics of the local video stream. See LocalVideoStats .
  final void Function(RtcConnection connection, LocalVideoStats stats)?
      onLocalVideoStats;

  /// Reports the statistics of the video stream sent by each remote users.
  /// Reports the statistics of the video stream from the remote users. The SDK triggers this callback once every two seconds for each remote user. If a channel has multiple users/hosts sending video streams, the SDK triggers this callback as many times.
  ///
  /// * [stats] Statistics of the remote video stream.
  final void Function(RtcConnection connection, RemoteVideoStats stats)?
      onRemoteVideoStats;

  /// Occurs when the camera turns on and is ready to capture the video.
  /// Deprecated:Please use localVideoStreamStateCapturing(1) in onLocalVideoStateChanged instead.This callback indicates that the camera has been successfully turned on and you can start to capture video.
  final void Function()? onCameraReady;

  /// Occurs when the camera focus area changes.
  ///
  /// * [x] The x-coordinate of the changed focus area.
  /// * [y] The y-coordinate of the changed focus area.
  /// * [width] The width of the focus area that changes.
  /// * [height] The height of the focus area that changes.
  final void Function(int x, int y, int width, int height)?
      onCameraFocusAreaChanged;

  /// Occurs when the camera exposure area changes.
  final void Function(int x, int y, int width, int height)?
      onCameraExposureAreaChanged;

  /// Reports the face detection result of the local user.
  /// Once you enable face detection by calling enableFaceDetection (true), you can get the following information on the local user in real-time:The width and height of the local video.The position of the human face in the local view.The distance between the human face and the screen.This value is based on the fitting calculation of the local video size and the position of the human face.This callback is for Android and iOS only.When it is detected that the face in front of the camera disappears, the callback will be triggered immediately. When no human face is detected, the frequency of this callback to be rtriggered wil be decreased to reduce power consumption on the local device.The SDK stops triggering this callback when a human face is in close proximity to the screen.On Android, the value of distance reported in this callback may be slightly different from the actual distance. Therefore, Agora does not recommend using it for accurate calculation.
  ///
  /// * [imageWidth] The width (px) of the video image captured by the local camera.
  /// * [imageHeight] The height (px) of the video image captured by the local camera.
  /// * [vecRectangle] The information of the detected human face. See Rectangle .
  /// * [vecDistance] The distance between the human face and the device screen (cm).
  /// * [numFaces] The number of faces detected. If the value is 0, it means that no human face is detected.
  final void Function(int imageWidth, int imageHeight, Rectangle vecRectangle,
      int vecDistance, int numFaces)? onFacePositionChanged;

  /// Occurs when the video stops playing.
  /// Deprecated:Use localVideoStreamStateStopped(0) in the onLocalVideoStateChanged callback instead.The application can use this callback to change the configuration of the view (for example, displaying other pictures in the view) after the video stops playing.
  final void Function()? onVideoStopped;

  /// Occurs when the playback state of the music file changes.
  /// This callback occurs when the playback state of the music file changes, and reports the current state and error code.
  ///
  /// * [state] The playback state of the music file. See AudioMixingStateType .
  /// * [reason] Error code. See AudioMixingReasonType .
  final void Function(AudioMixingStateType state, AudioMixingReasonType reason)?
      onAudioMixingStateChanged;

  /// Occurs when the state of virtual metronome changes.
  /// When the state of the virtual metronome changes, the SDK triggers this callback to report the current state of the virtual metronome. This callback indicates the state of the local audio stream and enables you to troubleshoot issues when audio exceptions occur.This callback is for Android and iOS only.
  /// * [state] For the current virtual metronome status, see RhythmPlayerStateType.
  /// * [errorCode] For the error codes and error messages related to virtual metronome errors, see RhythmPlayerErrorType.
  final void Function(
          RhythmPlayerStateType state, RhythmPlayerErrorType errorCode)?
      onRhythmPlayerStateChanged;

  /// Occurs when the SDK cannot reconnect to Agora's edge server 10 seconds after its connection to the server is interrupted.
  /// The SDK triggers this callback when it cannot connect to the server 10 seconds after calling the joinChannel [2/2] method, regardless of whether it is in the channel. If the SDK fails to rejoin the channel within 20 minutes after disconnecting, the SDK will stop trying to reconnect.
  ///
  /// * [connection] The connection information. See RtcConnection .
  final void Function(RtcConnection connection)? onConnectionLost;

  /// Occurs when the connection between the SDK and the server is interrupted.
  /// Deprecated:Use onConnectionStateChanged instead.The SDK triggers this callback when it loses connection with the server for more than four seconds after the connection is established. After triggering this callback, the SDK tries to reconnect to the server. You can use this callback to implement pop-up reminders. The difference between this callback and onConnectionLost is:The SDK triggers the onConnectionInterrupted callback when it loses connection with the server for more than four seconds after it successfully joins the channel.The SDK triggers the onConnectionLost callback when it loses connection with the server for more than 10 seconds, whether or not it joins the channel.If the SDK fails to rejoin the channel 20 minutes after being disconnected from Agora's edge server, the SDK stops rejoining the channel.
  ///
  /// * [connection] The connection information. See RtcConnection .
  final void Function(RtcConnection connection)? onConnectionInterrupted;

  /// Occurs when the connection is banned by the Agora server.
  /// Deprecated:Please use onConnectionStateChanged instead.
  ///
  /// * [connection] The connection information. See RtcConnection .
  final void Function(RtcConnection connection)? onConnectionBanned;

  /// Occurs when the local user receives the data stream from the remote user.
  /// The SDK triggers this callback when the local user receives the stream message that the remote user sends by calling the sendStreamMessage method.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [uid] The ID of the remote user sending the message.
  /// * [streamId] The stream ID of the received message.
  /// * [data] received data.
  /// * [length] The data length (byte).
  /// * [sentTs] The time when the data stream is sent.
  final void Function(RtcConnection connection, int remoteUid, int streamId,
      Uint8List data, int length, int sentTs)? onStreamMessage;

  /// Occurs when the local user does not receive the data stream from the remote user.
  /// The SDK triggers this callback when the local user fails to receive the stream message that the remote user sends by calling the sendStreamMessage method.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [remoteUid] The ID of the remote user sending the message.
  /// * [streamId] The stream ID of the received message.
  /// * [code] The error code.
  /// * [missed] The number of lost messages.
  /// * [cached] Number of incoming cached messages when the data stream is interrupted.
  final void Function(RtcConnection connection, int remoteUid, int streamId,
      ErrorCodeType code, int missed, int cached)? onStreamMessageError;

  /// Occurs when the token expires.
  /// When the token expires during a call, the SDK triggers this callback to remind the app to renew the token.Once you receive this callback, generate a new token on your app server, and call joinChannel [2/2] to rejoin the channel.
  ///
  /// * [connection] The connection information. See RtcConnection .
  final void Function(RtcConnection connection)? onRequestToken;

  /// Occurs when the token expires in 30 seconds.
  /// When the token is about to expire in 30 seconds, the SDK triggers this callback to remind the app to renew the token.Upon receiving this callback, generate a new token on your server, and call renewToken to pass the new token to the SDK.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [token] The token that expires in 30 seconds.
  final void Function(RtcConnection connection, String token)?
      onTokenPrivilegeWillExpire;

  /// @nodoc
  final void Function(RtcConnection connection, LicenseErrorType reason)?
      onLicenseValidationFailure;

  /// Occurs when the first audio frame is published.
  /// The SDK triggers this callback under one of the following circumstances:The local client enables the audio module and calls joinChannel [2/2] successfully.The local client calls muteLocalAudioStream (true) and muteLocalAudioStream(false) in sequence.The local client calls disableAudio and enableAudio in sequence.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [elapsed] Time elapsed (ms) from the local user calling joinChannel [2/2] until the SDK triggers this callback.
  final void Function(RtcConnection connection, int elapsed)?
      onFirstLocalAudioFramePublished;

  /// Occurs when the first audio frame sent by a specified remote user is received.
  /// Deprecated:Use onRemoteAudioStateChanged instead.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [userId] The ID of the remote user sending the audio frames.
  /// * [elapsed] The time elapsed (ms) from the local user calling the joinChannel [2/2] method until the SDK triggers this callback.
  final void Function(RtcConnection connection, int userId, int elapsed)?
      onFirstRemoteAudioFrame;

  /// Occurs when the SDK decodes the first remote audio frame for playback.
  /// Deprecated:Use onRemoteAudioStateChanged instead.The SDK triggers this callback under one of the following circumstances:The remote user joins the channel and sends the audio stream.The remote user stops sending the audio stream and re-sends it after 15 seconds, and the possible reasons include:The remote user leaves the channel.The remote user is offline.The remote user calls muteLocalAudioStream to stop sending the video stream.The remote user calls disableAudio to disable video.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [uid] The user ID of the remote user.
  /// * [elapsed] The time elapsed (ms) from the local user calling the joinChannel [2/2] method until the SDK triggers this callback.
  final void Function(RtcConnection connection, int uid, int elapsed)?
      onFirstRemoteAudioDecoded;

  /// Occurs when the local audio stream state changes.
  /// When the state of the local audio stream changes (including the state of the audio capture and encoding), the SDK triggers this callback to report the current state. This callback indicates the state of the local audio stream, and allows you to troubleshoot issues when audio exceptions occur.When the state is localAudioStreamStateFailed (3), you can view the error information in the error parameter.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [state] The state of the local audio. See localaudiostreamstate .
  /// * [error] Local audio state error codes. See LocalAudioStreamError .
  final void Function(RtcConnection connection, LocalAudioStreamState state,
      LocalAudioStreamError error)? onLocalAudioStateChanged;

  /// Occurs when the remote audio state changes.
  /// When the audio state of a remote user (in a voice/video call channel) or host (in a live streaming channel) changes, the SDK triggers this callback to report the current state of the remote audio stream.This callback does not work properly when the number of users (in the communication profile) or hosts (in the live streaming channel) in a channel exceeds 17.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [remoteUid] The ID of the remote user whose audio state changes.
  /// * [state] The state of the remote audio. See RemoteAudioState .
  /// * [reason] The reason of the remote audio state change. See RemoteAudioStateReason .
  /// * [elapsed] Time elapsed (ms) from the local user calling the joinChannel [2/2] method until the SDK triggers this callback.
  final void Function(
      RtcConnection connection,
      int remoteUid,
      RemoteAudioState state,
      RemoteAudioStateReason reason,
      int elapsed)? onRemoteAudioStateChanged;

  /// Occurs when the most active remote speaker is detected.
  /// After a successful call of enableAudioVolumeIndication , the SDK continuously detects which remote user has the loudest volume. During the current period, the remote user, who is detected as the loudest for the most times, is the most active user.When the number of users is no less than two and an active remote speaker exists, the SDK triggers this callback and reports the uid of the most active remote speaker.If the most active remote speaker is always the same user, the SDK triggers the onActiveSpeaker callback only once.If the most active remote speaker changes to another user, the SDK triggers this callback again and reports the uid of the new active remote speaker.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [uid] The user ID of the most active remote speaker.
  final void Function(RtcConnection connection, int uid)? onActiveSpeaker;

  /// @nodoc
  final void Function(ContentInspectResult result)? onContentInspectResult;

  /// Reports the result of taking a video snapshot.
  /// After a successful takeSnapshot method call, the SDK triggers this callback to report whether the snapshot is successfully taken as well as the details for the snapshot taken.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [uid] The user ID. One uid of 0 indicates the local user.
  /// * [filePath] The local path of the snapshot.
  /// * [width] The width (px) of the snapshot.
  /// * [height] The height (px) of the snapshot.
  /// * [errCode] The message that confirms success or gives the reason why the snapshot is not successfully taken:0: Success.< 0: Failure:-1: The SDK fails to write data to a file or encode a JPEG image.-2: The SDK does not find the video stream of the specified user within one second after the takeSnapshot method call succeeds. The possible reasons are: local capture stops, remote end stops publishing, or video data processing is blocked.-3: Calling the takeSnapshot method too frequently.
  final void Function(RtcConnection connection, int uid, String filePath,
      int width, int height, int errCode)? onSnapshotTaken;

  /// Occurs when the user role switches during the interactive live streaming.
  /// The SDK triggers this callback when the local user switches their user role by calling setClientRole after joining the channel.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [oldRole] Role that the user switches from: ClientRoleType .
  /// * [newRole] Role that the user switches to: ClientRoleType .
  /// * [newRoleOptions] Properties of the role that the user switches to. See ClientRoleOptions .
  final void Function(
      RtcConnection connection,
      ClientRoleType oldRole,
      ClientRoleType newRole,
      ClientRoleOptions newRoleOptions)? onClientRoleChanged;

  /// Occurs when the user role switch fails in the interactive live streaming.
  /// In the live broadcasting channel profile, when the local user calls setClientRole [1/2] to switch their user role after joining the channel but the switch fails, the SDK triggers this callback to report the reason for the failure and the current user role.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [reason] The reason for a user role switch failure. See ClientRoleChangeFailedReason .
  /// * [currentRole] Current user role. See ClientRoleType .
  final void Function(
      RtcConnection connection,
      ClientRoleChangeFailedReason reason,
      ClientRoleType currentRole)? onClientRoleChangeFailed;

  /// Reports the volume change of the audio device or app.
  /// Occurs when the volume on the playback device, audio capture device, or the volume in the application changes.This callback is for Windows and macOS only.
  ///
  /// * [deviceType] The device type. See MediaDeviceType .
  /// * [volume] The volume value. The range is [0, 255].
  /// * [muted] Whether the audio device is muted:true: The audio device is muted.false: The audio device is not muted.
  final void Function(MediaDeviceType deviceType, int volume, bool muted)?
      onAudioDeviceVolumeChanged;

  /// Occurs when the media push state changes.
  /// When the media push state changes, the SDK triggers this callback and reports the URL address and the current state of the media push. This callback indicates the state of the media push. When exceptions occur, you can troubleshoot issues by referring to the detailed error descriptions in the error code parameter.
  ///
  /// * [url] The URL address where the state of the media push changes.
  /// * [state] The current state of the media push. See RtmpStreamPublishState .
  /// * [errCode] The detailed error information for the media push. See RtmpStreamPublishErrorType .
  final void Function(String url, RtmpStreamPublishState state,
      RtmpStreamPublishErrorType errCode)? onRtmpStreamingStateChanged;

  /// Reports events during the media push.
  ///
  /// * [url] The URL of media push.
  /// * [eventCode] The event code of media push. See RtmpStreamingEvent .
  final void Function(String url, RtmpStreamingEvent eventCode)?
      onRtmpStreamingEvent;

  /// Occurs when the publisher's transcoding is updated.
  /// When the LiveTranscoding class in the setLiveTranscoding method updates, the SDK triggers the onTranscodingUpdated callback to report the update information.If you call the setLiveTranscoding method to set the LiveTranscoding class for the first time, the SDK does not trigger this callback.
  final void Function()? onTranscodingUpdated;

  /// Occurs when the local audio route changes.
  /// This method is for Android, iOS and macOS only.
  ///
  /// * [routing] The current audio routing. See AudioRoute .
  final void Function(int routing)? onAudioRoutingChanged;

  /// Occurs when the state of the media stream relay changes.
  /// The SDK returns the state of the current media relay with any error message.
  ///
  /// * [state] The state code. See ChannelMediaRelayState .
  /// * [code] The error code of the channel media relay. See ChannelMediaRelayError .
  final void Function(
          ChannelMediaRelayState state, ChannelMediaRelayError code)?
      onChannelMediaRelayStateChanged;

  /// Reports events during the media stream relay.
  ///
  /// * [code] The event code of channel media relay. See ChannelMediaRelayEvent .
  final void Function(ChannelMediaRelayEvent code)? onChannelMediaRelayEvent;

  /// @nodoc
  final void Function(bool isFallbackOrRecover)?
      onLocalPublishFallbackToAudioOnly;

  /// @nodoc
  final void Function(int uid, bool isFallbackOrRecover)?
      onRemoteSubscribeFallbackToAudioOnly;

  /// Reports the transport-layer statistics of each remote audio stream.
  /// Deprecated:Please use onRemoteAudioStats instead.This callback reports the transport-layer statistics, such as the packet loss rate and network time delay, once every two seconds after the local user receives an audio packet from a remote user. During a call, when the user receives the video packet sent by the remote user/host, the callback is triggered every 2 seconds.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [remoteUid] The ID of the remote user sending the audio packets.
  /// * [delay] The network delay (ms) from the sender to the receiver.
  /// * [lost] The packet loss rate (%) of the audio packet sent from the remote user.
  /// * [rxKBitRate] The bitrate of the received audio (Kbps).
  final void Function(RtcConnection connection, int remoteUid, int delay,
      int lost, int rxKBitRate)? onRemoteAudioTransportStats;

  /// Reports the transport-layer statistics of each remote video stream.
  /// Deprecated:This callback is deprecated; use onRemoteVideoStats instead.This callback reports the transport-layer statistics, such as the packet loss rate and network time delay, once every two seconds after the local user receives a video packet from a remote user.During a call, when the user receives the video packet sent by the remote user/host, the callback is triggered every 2 seconds.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [remoteUid] The ID of the remote user sending the video packets.
  /// * [delay] The network delay (ms) from the sender to the receiver.
  /// * [lost] The packet loss rate (%) of the video packet sent from the remote user.
  /// * [rxKBitRate] The bitrate of the received video (Kbps).
  final void Function(RtcConnection connection, int remoteUid, int delay,
      int lost, int rxKBitRate)? onRemoteVideoTransportStats;

  /// Occurs when the network connection state changes.
  /// When the network connection state changes, the SDK triggers this callback and reports the current connection state and the reason for the change.
  ///
  /// * [state] The current connection state.
  /// * [reason] The reason for a connection state change.
  final void Function(RtcConnection connection, ConnectionStateType state,
      ConnectionChangedReasonType reason)? onConnectionStateChanged;

  /// @nodoc
  final void Function(RtcConnection connection, WlaccMessageReason reason,
      WlaccSuggestAction action, String wlAccMsg)? onWlAccMessage;

  /// @nodoc
  final void Function(RtcConnection connection, WlAccStats currentStats,
      WlAccStats averageStats)? onWlAccStats;

  /// Occurs when the local network type changes.
  /// This callback occurs when the connection state of the local user changes. You can get the connection state and reason for the state change in this callback. When the network connection is interrupted, this callback indicates whether the interruption is caused by a network type change or poor network conditions.
  ///
  /// * [connection] The connection information. See RtcConnection .
  /// * [type] The type of the local network connection. See NetworkType .
  final void Function(RtcConnection connection, NetworkType type)?
      onNetworkTypeChanged;

  /// Reports the built-in encryption errors.
  /// When encryption is enabled by calling enableEncryption , the SDK triggers this callback if an error occurs in encryption or decryption on the sender or the receiver side.
  ///
  /// * [connection] The connection information. See RtcConnection .
  ///
  final void Function(RtcConnection connection, EncryptionErrorType errorType)?
      onEncryptionError;

  /// Occurs when the SDK cannot get the device permission.
  /// When the SDK fails to get the device permission, the SDK triggers this callback to report which device permission cannot be got.This callback is for Android and iOS only.
  ///
  /// * [permissionType] The type of the device permission. See PermissionType .
  final void Function(PermissionType permissionType)? onPermissionError;

  /// Occurs when the local user registers a user account.
  /// After the local user successfully calls registerLocalUserAccount to register the user account or calls joinChannelWithUserAccount to join a channel, the SDK triggers the callback and informs the local user's UID and User Account.
  ///
  /// * [uid] The ID of the local user.
  /// * [userAccount] The user account of the local user.
  final void Function(int uid, String userAccount)? onLocalUserRegistered;

  /// Occurs when the SDK gets the user ID and user account of the remote user.
  /// After a remote user joins the channel, the SDK gets the UID and user account of the remote user, caches them in a mapping table object, and triggers this callback on the local client.
  ///
  /// * [uid] The user ID of the remote user.
  /// * [info] The UserInfo object that contains the user ID and user account of the remote user. See UserInfo for details.
  final void Function(int uid, UserInfo info)? onUserInfoUpdated;

  /// @nodoc
  final void Function(RtcConnection connection, String requestId, bool success,
      UploadErrorReason reason)? onUploadLogResult;

  /// Occurs when the audio subscribing state changes.
  ///
  /// * [channel] The channel name.
  /// * [uid] The user ID of the remote user.
  /// * [oldState] The previous subscribing status, see StreamSubscribeState for details.
  /// * [newState] The current subscribing status, see StreamSubscribeState for details.
  /// * [elapseSinceLastState] The time elapsed (ms) from the previous state to the current state.
  final void Function(
      String channel,
      int uid,
      StreamSubscribeState oldState,
      StreamSubscribeState newState,
      int elapseSinceLastState)? onAudioSubscribeStateChanged;

  /// Occurs when the video subscribing state changes.
  ///
  /// * [channel] The channel name.
  /// * [uid] The ID of the remote user.
  /// * [oldState] The previous subscribing status, see StreamSubscribeState for details.
  /// * [newState] The current subscribing status, see StreamSubscribeState for details.
  /// * [elapseSinceLastState] The time elapsed (ms) from the previous state to the current state.
  final void Function(
      String channel,
      int uid,
      StreamSubscribeState oldState,
      StreamSubscribeState newState,
      int elapseSinceLastState)? onVideoSubscribeStateChanged;

  /// Occurs when the audio publishing state changes.
  ///
  /// * [channel] The channel name.
  /// * [oldState] The previous subscribing status. See StreamPublishState .
  /// * [newState] The current subscribing status. See StreamPublishState.
  /// * [elapseSinceLastState] The time elapsed (ms) from the previous state to the current state.
  final void Function(
      String channel,
      StreamPublishState oldState,
      StreamPublishState newState,
      int elapseSinceLastState)? onAudioPublishStateChanged;

  /// Occurs when the video publishing state changes.
  ///
  /// * [channel] The channel name.
  /// * [source] The capture type of the custom video source. See VideoSourceType .
  /// * [oldState] For the previous publishing state, see StreamPublishState .
  /// * [newState] For the current publishing state, see StreamPublishState.
  /// * [elapseSinceLastState] The time elapsed (ms) from the previous state to the current state.
  final void Function(
      VideoSourceType source,
      String channel,
      StreamPublishState oldState,
      StreamPublishState newState,
      int elapseSinceLastState)? onVideoPublishStateChanged;

  /// The event callback of the extension.
  /// To listen for events while the extension is running, you need to register this callback.
  ///
  /// * [value] The value of the extension key.
  /// * [key] The key of the extension.
  /// * [provider] The name of the extension provider.
  /// * [extName] The name of the extension.
  final void Function(
          String provider, String extension, String key, String value)?
      onExtensionEvent;

  /// Occurs when the extension is enabled.
  /// After a successful call of enableExtension (true), the extension triggers this callback.
  ///
  /// * [provider] The name of the extension provider.
  /// * [extName] The name of the extension.
  final void Function(String provider, String extension)? onExtensionStarted;

  /// Occurs when the extension is disabled.
  /// After a successful call of enableExtension (false), this callback is triggered.
  ///
  /// * [extName] The name of the extension.
  /// * [provider] The name of the extension provider.
  final void Function(String provider, String extension)? onExtensionStopped;

  /// Occurs when the extension runs incorrectly.
  /// When calling enableExtension (true) fails or the extension runs in error, the extension triggers this callback and reports the error code and reason.
  ///
  /// * [provider] The name of the extension provider.
  /// * [extension] The name of the extension.
  /// * [error] Error code. For details, see the extension documentation provided by the extension provider.
  /// * [message] Reason. For details, see the extension documentation provided by the extension provider.
  final void Function(
          String provider, String extension, int error, String message)?
      onExtensionError;

  /// @nodoc
  final void Function(
          RtcConnection connection, int remoteUid, String userAccount)?
      onUserAccountUpdated;
}

/// Video device management methods.
abstract class VideoDeviceManager {
  /// Enumerates the video devices.
  ///
  /// Returns
  /// Success: A VideoDeviceInfo array including all video devices in the system.Failure: An empty array.
  Future<List<VideoDeviceInfo>> enumerateVideoDevices();

  /// Specifies the video capture device with the device ID.
  /// Plugging or unplugging a device does not change its device ID.
  ///
  /// * [deviceIdUTF8] The device ID. You can get the device ID by calling enumerateVideoDevices .The maximum length is MaxDeviceIdLengthType .
  Future<void> setDevice(String deviceIdUTF8);

  /// Retrieves the current video capture device.
  ///
  /// Returns
  /// The video capture device.
  Future<String> getDevice();

  /// Gets the number of video formats supported by the specified video capture device.
  /// Video capture devices may support multiple video formats, and each format supports different combinations of video frame width, video frame height, and frame rate.You can call this method to get how many video formats the specified video capture device can support, and then call getCapability to get the specific video frame information in the specified video format.
  ///
  /// * [deviceIdUTF8] The ID of the video capture device.
  Future<int> numberOfCapabilities(String deviceIdUTF8);

  /// Gets the detailed video frame information of the video capture device in the specified video format.
  /// After calling numberOfCapabilities to get the number of video formats supported by the video capture device, you can call this method to get the specific video frame information supported by the specified index number.
  ///
  /// * [deviceIdUTF8] The ID of the video capture device.
  /// * [deviceCapabilityNumber] The index number of the video format. If the return value of numberOfCapabilities is i, the value range of this parameter is [0,i).
  ///
  /// Returns
  /// The specific information of the specified video format, including width (px), height (px), and frame rate (fps). See VideoFormat .
  Future<VideoFormat> getCapability(
      {required String deviceIdUTF8, required int deviceCapabilityNumber});

  /// @nodoc
  Future<void> startDeviceTest(int hwnd);

  /// @nodoc
  Future<void> stopDeviceTest();

  /// Releases all the resources occupied by the VideoDeviceManager object.
  Future<void> release();
}

/// Configurations for the RtcEngineContext instance.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RtcEngineContext {
  /// @nodoc
  const RtcEngineContext(
      {this.appId,
      this.channelProfile,
      this.license,
      this.audioScenario,
      this.areaCode,
      this.logConfig,
      this.threadPriority,
      this.useExternalEglContext,
      this.domainLimit});

  /// The App ID issued by Agora for your project. Only users in apps with the same App ID can join the same channel and communicate with each other. An App ID can only be used to create one RtcEngine instance. To change your App ID, call release to destroy the current RtcEngine instance, and then create a new one.
  @JsonKey(name: 'appId')
  final String? appId;

  /// The channel profile. See ChannelProfileType .
  @JsonKey(name: 'channelProfile')
  final ChannelProfileType? channelProfile;

  /// @nodoc
  @JsonKey(name: 'license')
  final String? license;

  /// The audio scenarios. See AudioScenarioType . Under different audio scenarios, the device uses different volume types.
  @JsonKey(name: 'audioScenario')
  final AudioScenarioType? audioScenario;

  /// The region for connection. This is an advanced feature and applies to scenarios that have regional restrictions.  The area codes support bitwise operation.
  @JsonKey(name: 'areaCode')
  final int? areaCode;

  /// The SDK log files are: agorasdk.log, agorasdk.1.log, agorasdk.2.log, agorasdk.3.log, and agorasdk.4.log.The API call log files are: agoraapi.log, agoraapi.1.log, agoraapi.2.log, agoraapi.3.log, and agoraapi.4.log.The default size for each SDK log file is 1,024 KB; the default size for each API call log file is 2,048 KB. These log files are encoded in UTF-8.The SDK writes the latest logs in agorasdk.log or agoraapi.log.When agorasdk.log is full, the SDK processes the log files in the following order:Delete the agorasdk.4.log file (if any).Rename agorasdk.3.log to agorasdk.4.log.Rename agorasdk.2.log to agorasdk.3.log.Rename agorasdk.1.log to agorasdk.2.log.Create a new agorasdk.log file.The overwrite rules for the agoraapi.log file are the same as for agorasdk.log.The log files that the SDK outputs. See LogConfig .By default, the SDK generates five SDK log files and five API call log files with the following rules:
  @JsonKey(name: 'logConfig')
  final LogConfig? logConfig;

  /// @nodoc
  @JsonKey(name: 'threadPriority')
  final ThreadPriorityType? threadPriority;

  /// @nodoc
  @JsonKey(name: 'useExternalEglContext')
  final bool? useExternalEglContext;

  /// Whether to enable domain name restriction:true: Enables the domain name restriction. This value is suitable for scenarios where IoT devices use IoT cards for network access. The SDK will only connect to servers in the domain name or IP whitelist that has been reported to the operator.false: (Default) Disables the domain name restriction. This value is suitable for most common scenarios.
  @JsonKey(name: 'domainLimit')
  final bool? domainLimit;

  /// @nodoc
  factory RtcEngineContext.fromJson(Map<String, dynamic> json) =>
      _$RtcEngineContextFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RtcEngineContextToJson(this);
}

/// The metadata observer.
class MetadataObserver {
  /// @nodoc
  const MetadataObserver({
    this.onMetadataReceived,
  });

  /// Occurs when the local user receives the metadata.
  ///
  /// * [metadata] The metadata received, see Metadata .
  final void Function(Metadata metadata)? onMetadataReceived;
}

/// Metadata type of the observer. We only support video metadata for now.
@JsonEnum(alwaysCreate: true)
enum MetadataType {
  /// The type of metadata is unknown.
  @JsonValue(-1)
  unknownMetadata,

  /// The type of metadata is video.
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

/// Media metadata.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Metadata {
  /// @nodoc
  const Metadata({this.uid, this.size, this.buffer, this.timeStampMs});

  /// The user ID.For the recipient:the ID of the remote user who sent the Metadata.Ignore it for sender.
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

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class DirectCdnStreamingStats {
  /// @nodoc
  const DirectCdnStreamingStats(
      {this.videoWidth,
      this.videoHeight,
      this.fps,
      this.videoBitrate,
      this.audioBitrate});

  /// @nodoc
  @JsonKey(name: 'videoWidth')
  final int? videoWidth;

  /// @nodoc
  @JsonKey(name: 'videoHeight')
  final int? videoHeight;

  /// @nodoc
  @JsonKey(name: 'fps')
  final int? fps;

  /// @nodoc
  @JsonKey(name: 'videoBitrate')
  final int? videoBitrate;

  /// @nodoc
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

/// @nodoc
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

  /// @nodoc
  @JsonKey(name: 'publishCameraTrack')
  final bool? publishCameraTrack;

  /// @nodoc
  @JsonKey(name: 'publishMicrophoneTrack')
  final bool? publishMicrophoneTrack;

  /// @nodoc
  @JsonKey(name: 'publishCustomAudioTrack')
  final bool? publishCustomAudioTrack;

  /// @nodoc
  @JsonKey(name: 'publishCustomVideoTrack')
  final bool? publishCustomVideoTrack;

  /// @nodoc
  @JsonKey(name: 'publishMediaPlayerAudioTrack')
  final bool? publishMediaPlayerAudioTrack;

  /// @nodoc
  @JsonKey(name: 'publishMediaPlayerId')
  final int? publishMediaPlayerId;

  /// @nodoc
  @JsonKey(name: 'customVideoTrackId')
  final int? customVideoTrackId;

  /// @nodoc
  factory DirectCdnStreamingMediaOptions.fromJson(Map<String, dynamic> json) =>
      _$DirectCdnStreamingMediaOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$DirectCdnStreamingMediaOptionsToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ExtensionInfo {
  /// @nodoc
  const ExtensionInfo(
      {this.mediaSourceType, this.remoteUid, this.channelId, this.localUid});

  /// @nodoc
  @JsonKey(name: 'mediaSourceType')
  final MediaSourceType? mediaSourceType;

  /// @nodoc
  @JsonKey(name: 'remoteUid')
  final int? remoteUid;

  /// @nodoc
  @JsonKey(name: 'channelId')
  final String? channelId;

  /// @nodoc
  @JsonKey(name: 'localUid')
  final int? localUid;

  /// @nodoc
  factory ExtensionInfo.fromJson(Map<String, dynamic> json) =>
      _$ExtensionInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ExtensionInfoToJson(this);
}

/// The basic interface of the Agora SDK that implements the core functions of real-time communication.
/// RtcEngine provides the main methods that your app can call.
abstract class RtcEngine {
  /// Releases the RtcEngine instance.
  /// This method releases all resources used by the Agora SDK. Use this method for apps in which users occasionally make voice or video calls. When users do not make calls, you can free up resources for other operations.After a successful method call, you can no longer use any method or callback in the SDK anymore. If you want to use the real-time communication functions again, you must call createAgoraRtcEngine and initialize to create a new RtcEngine instance.If you want to create a new RtcEngine instance after destroyingthe current one, ensure that you wait till the release method execution to complete.
  ///
  /// * [sync] Whether the method is called synchronously:true: Synchronous call. Agora suggests calling this method in a sub-thread to avoid congestion in the main thread because the synchronous call and the app cannot move on to another task until the resources used by RtcEngine are released. Besides, you cannot call release in any method or callback of the SDK. Otherwise, the SDK cannot release the resources until the callbacks return results, which may result in a deadlock.false: Asynchronous call. Currently this method only supports synchronous calls, do not set this parameter to this value.
  Future<void> release({bool sync = false});

  /// Initializes RtcEngine.
  /// All called methods provided by the RtcEngine class are executed asynchronously. Agora recommends calling these methods in the same thread.Before calling other APIs, you must call createAgoraRtcEngine and initialize to create and initialize the RtcEngine object.The SDK supports creating only one RtcEngine instance for an app.
  ///
  /// * [context] Configurations for the RtcEngine instance. See RtcEngineContext .
  ///
  Future<void> initialize(RtcEngineContext context);

  /// Gets the SDK version.
  ///
  /// Returns
  /// An SDKBuildInfo object.
  Future<SDKBuildInfo> getVersion();

  /// Gets the warning or error description.
  ///
  /// * [code] The error code or warning code reported by the SDK.
  ///
  /// Returns
  /// The specific error or warning description.
  Future<String> getErrorDescription(int code);

  /// Joins a channel with media options.
  /// This method enables users to join a channel. Users in the same channel can talk to each other, and multiple users in the same channel can start a group chat. Users with different App IDs cannot call each other.A successful call of this method triggers the following callbacks: The local client: The onJoinChannelSuccess and onConnectionStateChanged callbacks.The remote client: onUserJoined , if the user joining the channel is in the Communication profile or is a host in the Live-broadcasting profile.When the connection between the client and Agora's server is interrupted due to poor network conditions, the SDK tries reconnecting to the server. When the local client successfully rejoins the channel, the SDK triggers the onRejoinChannelSuccess callback on the local client.This method allows users to join only one channel at a time.Ensure that the app ID you use to generate the token is the same app ID that you pass in the initialize method; otherwise, you may fail to join the channel by token.
  ///
  /// * [token] The token generated on your server for authentication.
  /// * [channelId] The channel name. This parameter signifies the channel in which users engage in real-time audio and video interaction. Under the premise of the same App ID, users who fill in the same channel ID enter the same channel for audio and video interaction. The string length must be less than 64 bytes. Supported characters:All lowercase English letters: a to z.All uppercase English letters: A to Z.All numeric characters: 0 to 9.Space"!", "#", "$", "%", "&amp;", "(", ")", "+", "-", ":", ";", "&lt;", "= ", ".", "&gt;", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","
  /// * [uid] The user ID. This parameter is used to identify the user in the channel for real-time audio and video interaction. You need to set and manage user IDs yourself, and ensure that each user ID in the same channel is unique. This parameter is a 32-bit unsigned integer. The value range is 1 to 232-1. If the user ID is not assigned (or set to 0), the SDK assigns a random user ID and returns it in the onJoinChannelSuccess callback. Your application must record and maintain the returned user ID, because the SDK does not do so.
  /// * [options] The channel media options. See ChannelMediaOptions .
  Future<void> joinChannel(
      {required String token,
      required String channelId,
      required int uid,
      required ChannelMediaOptions options});

  /// Updates the channel media options after joining the channel.
  ///
  /// * [options] The channel media options. See ChannelMediaOptions .
  Future<void> updateChannelMediaOptions(ChannelMediaOptions options);

  /// Leaves a channel.
  /// This method releases all resources related to the session.This method call is asynchronous. When this method returns, it does not necessarily mean that the user has left the channel.After joining the channel, you must call this method or leaveChannel to end the call, otherwise, the next call cannot be started.If you successfully call this method and leave the channel, the following callbacks are triggered:The local client: onLeaveChannel .The remote client: onUserOffline , if the user joining the channel is in the Communication profile, or is a host in the Live-broadcasting profile.If you call release immediately after calling this method, the SDK does not trigger the onLeaveChannel callback.
  /// * [options] The options for leaving the channel. See LeaveChannelOptions .
  Future<void> leaveChannel({LeaveChannelOptions? options});

  /// Gets a new token when the current token expires after a period of time.
  /// You can use this method to pass a new token to the SDK. A token expires after a certain period of time. In the following two cases, the app should call this method to pass in a new token. Failure to do so will result in the SDK disconnecting from the server.The SDK triggers the onTokenPrivilegeWillExpire callback.The onConnectionStateChanged callback reports connectionChangedTokenExpired(9).
  ///
  /// * [token] The new token.
  Future<void> renewToken(String token);

  /// Sets the channel profile.
  /// After initializing the SDK, the default channel profile is the live streaming profile. You can call this method to set the usage scenario of Agora channel. The Agora SDK differentiates channel profiles and applies optimization algorithms accordingly. For example, it prioritizes smoothness and low latency for a video call and prioritizes video quality for interactive live video streaming.To ensure the quality of real-time communication, Agora recommends that all users in a channel use the same channel profile.This method must be called and set before joinChannel [2/2], and cannot be set again after joining the channel.
  ///
  /// * [profile] The channel profile. See ChannelProfileType .
  Future<void> setChannelProfile(ChannelProfileType profile);

  /// Sets the user role and level in an interactive live streaming channel.
  /// In the interactive live streaming profile, the SDK sets the user role as audience by default. You can call this method to set the user role as host.You can call this method either before or after joining a channel.If you call this method to set the user's role as the host before joining the channel and set the local video property through the setupLocalVideo method, the local video preview is automatically enabled when the user joins the channel.If you call this method to switch the user role after joining a channel, the SDK automatically does the following:Calls muteLocalAudioStream and muteLocalVideoStream to change the publishing state.Triggers onClientRoleChanged on the local client.Triggers onUserJoined or onUserOffline on the remote client.This method applies to the interactive live streaming profile (the profile parameter of setChannelProfile is channelProfileLiveBroadcasting) only.
  ///
  /// * [role] The user role in the interactive live streaming. See ClientRoleType .
  /// * [options] The detailed options of a user, including the user level. See ClientRoleOptions .
  Future<void> setClientRole(
      {required ClientRoleType role, ClientRoleOptions? options});

  /// Starts an audio call test.
  /// This method starts an audio call test to determine whether the audio devices (for example, headset and speaker) and the network connection are working properly. To conduct the test, let the user speak for a while, and the recording is played back within the set interval. If the user can hear the recording within the interval, the audio devices and network connection are working properly.Call this method before joining a channel.After calling startEchoTest, you must call stopEchoTest to end the test. Otherwise, the app cannot perform the next echo test, and you cannot join the channel.In the live streaming channels, only a host can call this method.
  ///
  /// * [intervalInSeconds] The time interval (s) between when you speak and when the recording plays back. The value range is [2, 10], and the default value is 10.
  Future<void> startEchoTest({int intervalInSeconds = 10});

  /// Stops the audio call test.
  Future<void> stopEchoTest();

  /// Enables or disables multi-camera capture.
  /// In scenarios where there are existing cameras to capture video, Agora recommends that you use the following steps to capture and publish video with multiple cameras:Call this method to enable multi-channel camera capture.Call startPreview to start the local video preview.Call startSecondaryCameraCapture to start video capture with the second camera.Call joinChannelEx , and set publishSecondaryCameraTrack to true to publish the video stream captured by the second camera in the channel.If you want to disable multi-channel camera capture, use the following steps:Call stopSecondaryCameraCapture .Call this method with enabled set to false.You can call this method before and after startPreview to enable multi-camera capture:If it is enabled before startPreview, the local video preview shows the image captured by the two cameras at the same time.If it is enabled after startPreview, the SDK stops the current camera capture first, and then enables the primary camera and the second camera. The local video preview appears black for a short time, and then automatically returns to normal.When using this function, ensure that the system version is 13.0 or later.The minimum iOS device types that support multi-camera capture are as follows:iPhone XRiPhone XSiPhone XS MaxiPad Pro 3rd generation and later
  ///
  /// * [enabled] Whether to enable multi-camera video capture mode:true: Enable multi-camera capture mode; the SDK uses multiple cameras to capture video.false: Disable multi-camera capture mode; the SDK uses a single camera to capture video.
  /// * [config] Capture configuration for the second camera. See CameraCapturerConfiguration .
  Future<void> enableMultiCamera(
      {required bool enabled, required CameraCapturerConfiguration config});

  /// Enables the video module.
  /// Call this method either before joining a channel or during a call. If this method is called before joining a channel, the call starts in the video mode. Call disableVideo to disable the video mode.A successful call of this method triggers the onRemoteVideoStateChanged callback on the remote client.This method enables the internal engine and is valid after leaving the channel.This method resets the internal engine and takes some time to take effect. Agora recommends using the following API methods to control the video engine modules separately: enableLocalVideo : Whether to enable the camera to create the local video stream. muteLocalVideoStream : Whether to publish the local video stream. muteRemoteVideoStream : Whether to subscribe to and play the remote video stream. muteAllRemoteVideoStreams : Whether to subscribe to and play all remote video streams.
  Future<void> enableVideo();

  /// Disables the video module.
  /// This method disables video. You can call this method either before or after joining a channel. If you call it before joining a channel, an audio call starts when you join the channel. If you call it after joining a channel, a video call switches to an audio call. Call enableVideo to enable video.A successful call of this method triggers the onUserEnableVideo (false) callback on the remote client.This method affects the internal engine and can be called after leaving the channel.This method resets the internal engine and takes some time to take effect. Agora recommends using the following API methods to control the video engine modules separately: enableLocalVideo : Whether to enable the camera to create the local video stream. muteLocalVideoStream : Whether to publish the local video stream. muteRemoteVideoStream : Whether to subscribe to and play the remote video stream. muteAllRemoteVideoStreams : Whether to subscribe to and play all remote video streams.
  Future<void> disableVideo();

  /// Enables the local video preview and specifies the video source for the preview.
  /// This method starts the local video preview before joining the channel. Before calling this method, ensure that you do the following:
  ///  Call setupLocalVideo to set the local preview window.
  ///  Call enableVideo to enable the video. The local preview enables the mirror mode by default.After the local video preview is enabled, if you call leaveChannel to exit the channel, the local preview remains until you call stopPreview to disable it.The video source type set in this method needs to be consistent with the video source type of VideoCanvas you set in setupLocalVideo .
  ///
  /// * [sourceType] The type of the video frame, see VideoSourceType .
  Future<void> startPreview(
      {VideoSourceType sourceType = VideoSourceType.videoSourceCameraPrimary});

  /// Stops the local video preview.
  /// After calling startPreview to start the preview, if you want to close the local video preview, please call this method.Please call this method before joining a channel or after leaving a channel.
  /// * [sourceType] The type of the video frame, see VideoSourceType.
  Future<void> stopPreview(
      {VideoSourceType sourceType = VideoSourceType.videoSourceCameraPrimary});

  /// Starts the last mile network probe test.
  /// This method starts the last-mile network probe test before joining a channel to get the uplink and downlink last mile network statistics, including the bandwidth, packet loss, jitter, and round-trip time (RTT).Once this method is enabled, the SDK returns the following callbacks: onLastmileQuality : The SDK triggers this callback within two seconds depending on the network conditions. This callback rates the network conditions and is more closely linked to the user experience. onLastmileProbeResult : The SDK triggers this callback within 30 seconds depending on the network conditions. This callback returns the real-time statistics of the network conditions and is more objective.This method applies to the following scenarios:Before a user joins a channel, call this method to check the uplink network quality.In a live streaming channel, call this method to check the uplink network quality before an audience member switches to a host.Do not call other methods before receiving the onLastmileQuality and onLastmileProbeResult callbacks. Otherwise, the callbacks may be interrupted.A host should not call this method after joining a channel (when in a call).
  ///
  /// * [config] The configurations of the last-mile network probe test. See LastmileProbeConfig .
  Future<void> startLastmileProbeTest(LastmileProbeConfig config);

  /// Stops the last mile network probe test.
  Future<void> stopLastmileProbeTest();

  /// Sets the video encoder configuration.
  /// Sets the encoder configuration for the local video.You can call this method either before or after joining a channel. If you don't need to set the video encoder configuration after joining a channel,
  /// Agora recommends you calling this method before the enableVideo method to reduce the rendering time of the first video frame.
  ///
  /// * [config] Video profile. See VideoEncoderConfiguration .
  Future<void> setVideoEncoderConfiguration(VideoEncoderConfiguration config);

  /// Sets the image enhancement options.
  /// Enables or disables image enhancement, and sets the options.Call this method before calling enableVideo or startPreview .This method relies on the video enhancement dynamic library libagora_clear_vision_extension.dll. If the dynamic library is deleted, the function cannot be enabled normally.
  ///
  /// * [type] The type of the video source. See MediaSourceType .
  /// * [enabled] Whether to enable the image enhancement function:true: Enable the image enhancement function.false: (Default) Disable the image enhancement function.
  /// * [options] The image enhancement options. See BeautyOptions .
  Future<void> setBeautyEffectOptions(
      {required bool enabled,
      required BeautyOptions options,
      MediaSourceType type = MediaSourceType.primaryCameraSource});

  /// Sets low-light enhancement.
  /// The low-light enhancement feature can adaptively adjust the brightness value of the video captured in situations with low or uneven lighting, such as backlit, cloudy, or dark scenes. It restores or highlights the image details and improves the overall visual effect of the video.You can call this method to enable the color enhancement feature and set the options of the color enhancement effect.Call this method after calling enableVideo .Dark light enhancement has certain requirements for equipment performance. The low-light enhancement feature has certain performance requirements on devices. If your device overheats after you enable low-light enhancement, Agora recommends modifying the low-light enhancement options to a less performance-consuming level or disabling low-light enhancement entirely.Both this method and setExtensionProperty can turn on low-light enhancement:When you use the SDK to capture video, Agora recommends this method (this method only works for video captured by the SDK).When you use an external video source to implement custom video capture, or send an external video source to the SDK, Agora recommends using setExtensionProperty.This method relies on the video enhancement dynamic library libagora_clear_vision_extension.dll. If the dynamic library is deleted, the function cannot be enabled normally.
  ///
  /// * [enabled] Whether to enable low-light enhancement function:true: Enable low-light enhancement function.false: (Default) Disable low-light enhancement function.
  /// * [options] The low-light enhancement options. See LowlightEnhanceOptions .
  /// * [type] The type of the video source. See MediaSourceType .
  Future<void> setLowlightEnhanceOptions(
      {required bool enabled,
      required LowlightEnhanceOptions options,
      MediaSourceType type = MediaSourceType.primaryCameraSource});

  /// Sets video noise reduction.
  /// Underlit environments and low-end video capture devices can cause video images to contain significant noise, which affects video quality. In real-time interactive scenarios, video noise also consumes bitstream resources and reduces encoding efficiency during encoding.You can call this method to enable the video noise reduction feature and set the options of the video noise reduction effect.Call this method after calling enableVideo .Video noise reduction has certain requirements for equipment performance. If your device overheats after you enable video noise reduction, Agora recommends modifying the video noise reduction options to a less performance-consuming level or disabling video noise reduction entirely.Both this method and setExtensionProperty can turn on video noise reduction function:When you use the SDK to capture video, Agora recommends this method (this method only works for video captured by the SDK).When you use an external video source to implement custom video capture, or send an external video source to the SDK, Agora recommends using setExtensionProperty.This method relies on the video enhancement dynamic library libagora_clear_vision_extension.dll. If the dynamic library is deleted, the function cannot be enabled normally.
  ///
  /// * [type] The type of the video source. See MediaSourceType .
  /// * [enabled] Whether to enable video noise reduction:true: Enable video noise reduction.false: (Default) Disable video noise reduction.
  /// * [options] The video noise reduction options. See VideoDenoiserOptions .
  Future<void> setVideoDenoiserOptions(
      {required bool enabled,
      required VideoDenoiserOptions options,
      MediaSourceType type = MediaSourceType.primaryCameraSource});

  /// Sets color enhancement.
  /// The video images captured by the camera can have color distortion. The color enhancement feature intelligently adjusts video characteristics such as saturation and contrast to enhance the video color richness and color reproduction, making the video more vivid.You can call this method to enable the color enhancement feature and set the options of the color enhancement effect.Call this method after calling enableVideo .The color enhancement feature has certain performance requirements on devices. With color enhancement turned on, Agora recommends that you change the color enhancement level to one that consumes less performance or turn off color enhancement if your device is experiencing severe heat problems.Both this method and setExtensionProperty can enable color enhancement:When you use the SDK to capture video, Agora recommends this method (this method only works for video captured by the SDK).When you use an external video source to implement custom video capture, or send an external video source to the SDK, Agora recommends using setExtensionProperty.This method relies on the video enhancement dynamic library libagora_clear_vision_extension.dll. If the dynamic library is deleted, the function cannot be enabled normally.
  ///
  /// * [type] The type of the video source. See MediaSourceType .
  /// * [enabled] Whether to enable color enhancement:true Enable color enhancement.false: (Default) Disable color enhancement.
  /// * [options] The color enhancement options. See ColorEnhanceOptions .
  Future<void> setColorEnhanceOptions(
      {required bool enabled,
      required ColorEnhanceOptions options,
      MediaSourceType type = MediaSourceType.primaryCameraSource});

  /// Enables/Disables the virtual background.
  /// The virtual background function allows you to replace the original background image of the local user or to blur the background. After successfully enabling the virtual background function, all users in the channel can see the customized background.Call this method before calling enableVideo or startPreview .This function requires a high-performance device. Agora recommends that you use this function on devices with the following chips:Snapdragon 700 series 750G and laterSnapdragon 800 series 835 and laterDimensity 700 series 720 and laterKirin 800 series 810 and laterKirin 900 series 980 and laterDevices with an A9 chip and better, as follows:iPhone 6S and lateriPad Air 3rd generation and lateriPad 5th generation and lateriPad Pro 1st generation and lateriPad mini 5th generation and laterAgora recommends that you use this function in scenarios that meet the following conditions:A high-definition camera device is used, and the environment is uniformly lit.There are few objects in the captured video. Portraits are half-length and unobstructed. Ensure that the background is a solid color that is different from the color of the user's clothing.This method relies on the video enhancement dynamic library libagora_segmentation_extension.dll. If the dynamic library is deleted, the function cannot be enabled normally.
  ///
  /// * [enabled] Whether to enable virtual background:true: Enable virtual background.false: Disable virtual background.
  /// * [backgroundSource] The custom background image. See VirtualBackgroundSource . To adapt the resolution of the custom background image to that of the video captured by the SDK, the SDK scales and crops the custom background image while ensuring that the content of the custom background image is not distorted.
  /// * [segproperty] Processing properties for background images. See SegmentationProperty.
  /// * [type] The type of the video source. See MediaSourceType. In this method, this parameter supports only the following two settings: The default value is primaryCameraSource. If you want to use the second camera to capture video, set this parameter to secondaryCameraSource.
  Future<void> enableVirtualBackground(
      {required bool enabled,
      required VirtualBackgroundSource backgroundSource,
      required SegmentationProperty segproperty,
      MediaSourceType type = MediaSourceType.primaryCameraSource});

  /// Enables/Disables the super resolution algorithm for a remote user's video stream.
  /// This function can effectively improve the resolution of the remote video picture seen by the local user, that is, the width and height (pixels) of the video received by the specified remote user are enlarged to 2 times original size.After calling this method, you can confirm whether super resolution is successfully enabled through the remote video stream statistics ( RemoteVideoStats ) in the onRemoteVideoStats callback:If the parameter superResolutionType >0: Super resolution is enabled.If the parameter superResolutionType =0: Super resolution is not enabled.The super resolution feature requires extra system resources. To balance the visual experience and system consumption, this feature can only be enabled for a single remote user. If the local user uses super resolution on Android, the original resolution of the remote user's video cannot exceed 640 × 360 pixels; if the local user uses super resolution on iOS, the original resolution of the remote user's video cannot exceed 640 × 480 pixels.This method applies to Android and iOS only.This method relies on the super resolution dynamic library libagora_super_resolution_extension.so (Android); AgoraSuperResolutionExtension.xcframework (iOS). If the dynamic library is deleted, the function cannot be enabled normally.Because this method has certain system performance requirements, Agora recommends that you use the following devices or better:Android:VIVO: V1821A, NEX S, 1914A, 1916A, 1962A, 1824BA, X60, X60 ProOPPO: PCCM00, Find X3OnePlus: A6000Xiaomi: Mi 8, Mi 9, Mi 10, Mi 11, MIX3, Redmi K20 ProSAMSUNG: SM-G9600, SM-G9650, SM-N9600, SM-G9708, SM-G960U, SM-G9750, S20, S21HUAWEI: SEA-AL00, ELE-AL00, VOG-AL00, YAL-AL10, HMA-AL00, EVR-AN00, nova 4, nova 5 Pro, nova 6 5G, nova 7 5G, Mate 30, Mate 30 Pro, Mate 40, Mate 40 Pro, P40, P40 Pro, Huawei M6, MatePad 10.8iOS:iPhone XRiPhone XSiPhone XS MaxiPhone 11iPhone 11 ProiPhone 11 Pro MaxiPhone 12iPhone 12 miniiPhone 12 ProiPhone 12 Pro MaxiPhone 12 SE (2nd generation)iPad Pro 11-inch (3rd generation)iPad Pro 12.9-inch (3rd generation)iPad Air 3 (3rd generation)iPad Air 3 (4th generation)
  ///
  /// * [userId] The user ID of the remote user.
  /// * [enable] Whether to enable super resolution for the remote user’s video:true:Enable super resolution.false: Disable super resolution.
  Future<void> enableRemoteSuperResolution(
      {required int userId, required bool enable});

  /// Initializes the video view of a remote user.
  /// This method initializes the video view of a remote stream on the local device. It affects only the video view that the local user sees. Call this method to bind the remote video stream to a video view and to set the rendering and mirror modes of the video view.You need to specify the ID of the remote user in this method. If the remote user ID is unknown to the application, set it after the app receives the onUserJoined callback.To unbind the remote user from the view, set the view parameter to NULL.Once the remote user leaves the channel, the SDK unbinds the remote user.To update the rendering or mirror mode of the remote video view during a call, use the setRemoteRenderMode method.If you use the Agora recording feature, the recording client joins the channel as a dummy client, triggering the onUserJoined callback. Do not bind the dummy client to the app view because the dummy client does not send any video streams. If your app does not recognize the dummy client, bind the remote user to the view when the SDK triggers the onFirstRemoteVideoDecoded callback.
  ///
  /// * [canvas] The remote video view and settings. See VideoCanvas .
  Future<void> setupRemoteVideo(VideoCanvas canvas);

  /// Initializes the local video view.
  /// This method initializes the video view of a local stream on the local device. It affects only the video view that the local user sees, not the published local video stream. Call this method to bind the local video stream to a video view and to set the rendering and mirror modes of the video view.After initialization, call this method to set the local video and then join the channel. The local video still binds to the view after you leave the channel. To unbind the local video from the view, set the view parameter as NULL.You can call this method either before or after joining a channel.To update the rendering or mirror mode of the local video view during a call, use the setLocalRenderMode method.
  ///
  /// * [canvas] Local video display properties. See VideoCanvas .
  Future<void> setupLocalVideo(VideoCanvas canvas);

  /// Enables the audio module.
  /// The audio mode is enabled by default.This method enables the internal engine and can be called anytime after initialization. It is still valid after one leaves channel.This method enables the audio module and takes some time to take effect. Agora recommends using the following API methods to control the audio module separately: enableLocalAudio : Whether to enable the microphone to create the local audio stream. muteLocalAudioStream : Whether to publish the local audio stream. muteRemoteAudioStream : Whether to subscribe and play the remote audio stream. muteAllRemoteAudioStreams : Whether to subscribe to and play all remote audio streams.
  Future<void> enableAudio();

  /// Disables the audio module.
  /// This method disables the internal engine and can be called anytime after initialization. It is still valid after one leaves channel.This method resets the internal engine and takes some time to take effect. Agora recommends using the following API methods to control the audio modules separately: enableLocalAudio : Whether to enable the microphone to create the local audio stream. muteLocalAudioStream : Whether to publish the local audio stream. muteRemoteAudioStream : Whether to subscribe and play the remote audio stream. muteAllRemoteAudioStreams : Whether to subscribe to and play all remote audio streams.
  Future<void> disableAudio();

  /// Sets the audio parameters and application scenarios.
  /// You can call this method either before or after joining a channel.In scenarios requiring high-quality audio, such as online music tutoring, Agora recommends you set profile as audioProfileMusicHighQuality (4).If you want to set the audio scenario, call initialize and set RtcEngineContext struct.
  ///
  /// * [profile] The audio profile, including the sampling rate, bitrate, encoding mode, and the number of channels. See AudioProfileType .
  /// * [scenario] The audio scenarios. See AudioScenarioType.
  Future<void> setAudioProfile(
      {required AudioProfileType profile,
      AudioScenarioType scenario = AudioScenarioType.audioScenarioDefault});

  /// Sets audio scenarios.
  /// You can call this method either before or after joining a channel.
  /// * [scenario] The audio scenarios. See AudioScenarioType. Under different audio scenarios, the device uses different volume types.
  Future<void> setAudioScenario(AudioScenarioType scenario);

  /// Enables/Disables the local audio capture.
  /// The audio function is enabled by default. This method disables or re-enables the local audio function to stop or restart local audio capturing.This method does not affect receiving or playing the remote audio streams, and enableLocalAudio (false) is applicable to scenarios where the user wants to receive remote audio streams without sending any audio stream to other users in the channel.Once the local audio function is disabled or re-enabled, the SDK triggers the onLocalAudioStateChanged callback, which reports localAudioStreamStateStopped (0) or localAudioStreamStateRecording (1).This method is different from the muteLocalAudioStream method:enableLocalAudio: Disables/Re-enables the local audio capturing and processing. If you disable or re-enable local audio capturing using the enableLocalAudio method, the local user might hear a pause in the remote audio playback.muteLocalAudioStream: Sends/Stops sending the local audio streams.You can call this method either before or after joining a channel. Calling it before joining a channel only sets the device state, and it takes effect immediately after you join the channel.
  ///
  /// * [enabled] true: (Default) Re-enable the local audio function, that is, to start the local audio capturing device (for example, the microphone).false: Disable the local audio function, that is, to stop local audio capturing.
  Future<void> enableLocalAudio(bool enabled);

  /// Stops or resumes publishing the local audio stream.
  /// This method does not affect any ongoing audio recording, because it does not disable the audio capture device.
  ///
  /// * [mute] Whether to stop publishing the local audio stream.true: Stop publishing the local audio stream.false: (Default) Resumes publishing the local audio stream.
  Future<void> muteLocalAudioStream(bool mute);

  /// Stops or resumes subscribing to the audio streams of all remote users.
  /// After successfully calling this method, the local user stops or resumes subscribing to the audio streams of all remote users, including all subsequent users.Call this method after joining a channel.If you do not want to subscribe the audio streams of remote users before joining a channel, you can call joinChannel [2/2] and set autoSubscribeAudio as false.
  ///
  /// * [mute] Whether to stop subscribing to the audio streams of all remote users:true: Stop subscribing to the audio streams of all remote users.false: (Default) Subscribe to the audio streams of all remote users by default.
  Future<void> muteAllRemoteAudioStreams(bool mute);

  /// @nodoc
  Future<void> setDefaultMuteAllRemoteAudioStreams(bool mute);

  /// Cancels or resumes subscribing to the specified remote user's audio stream.
  /// Call this method after joining a channel.
  ///
  /// * [uid] The user ID of the specified user.
  /// * [mute] Whether to stop subscribing to the audio stream of the specified user.
  ///  true: Unsubscribe from the specified user's audio stream.false: (Default) Subscribes to the specified user's audio stream.
  Future<void> muteRemoteAudioStream({required int uid, required bool mute});

  /// Stops or resumes publishing the local video stream.
  /// A successful call of this method triggers the onUserMuteVideo callback on the remote client.This method executes faster than the enableLocalVideo (false) method, which controls the sending of the local video stream.This method does not affect any ongoing video recording, because it does not disable the camera.
  ///
  /// * [mute] Whether to stop publishing the local video stream.true: Stop publishing the local video stream.false: (Default) Publish the local video stream.
  Future<void> muteLocalVideoStream(bool mute);

  /// Enables/Disables the local video capture.
  /// This method disables or re-enables the local video capturer, and does not affect receiving the remote video stream.After calling enableVideo , the local video capturer is enabled by default. You can call enableLocalVideo (false) to disable the local video capturer. If you want to re-enable the local video, call enableLocalVideo(true).After the local video capturer is successfully disabled or re-enabled, the SDK triggers the onRemoteVideoStateChanged callback on the remote client.You can call this method either before or after joining a channel.This method enables the internal engine and is valid after leaving the channel.
  ///
  /// * [enabled] Whether to enable the local video capture.true: (Default) Enable the local video capture.false: Disables the local video capture. Once the local video is disabled, the remote users can no longer receive the video stream of this user, while this user can still receive the video streams of the other remote users. When set to false, this method does not require a local camera.
  Future<void> enableLocalVideo(bool enabled);

  /// Stops or resumes subscribing to the video streams of all remote users.
  /// After successfully calling this method, the local user stops or resumes subscribing to the audio streams of all remote users, including all subsequent users.Call this method after joining a channel.If you do not want to subscribe the video streams of remote users before joining a channel, you can call joinChannel [2/2] and set autoSubscribeVideo as false.
  ///
  /// * [mute] Whether to stop subscribing to the video streams of all remote users.true: Stop subscribing to the video streams of all remote users.false: (Default) Subscribe to the audio streams of all remote users by default.
  Future<void> muteAllRemoteVideoStreams(bool mute);

  /// @nodoc
  Future<void> setDefaultMuteAllRemoteVideoStreams(bool mute);

  /// Cancels or resumes subscribing to the specified remote user's video stream.
  /// Call this method after joining a channel.
  ///
  /// * [uid] The user ID of the specified user.
  /// * [mute] Whether to subscribe to the specified remote user's video stream.true: Unsubscribe from the specified user's video stream.false: (Default) Subscribes to the specified user's video stream.
  Future<void> muteRemoteVideoStream({required int uid, required bool mute});

  /// Sets the stream type of the remote video.
  /// Under limited network conditions, if the publisher has not disabled the dual-stream mode using enableDualStreamMode (false), the receiver can choose to receive either the high-quality video stream or the low-quality video stream. The high-quality video stream has a higher resolution and bitrate, and the low-quality video stream has a lower resolution and bitrate.By default, users receive the high-quality video stream. Call this method if you want to switch to the low-quality video stream. This method allows the app to adjust the corresponding video stream type based on the size of the video window to reduce the bandwidth and resources. The aspect ratio of the low-quality video stream is the same as the high-quality video stream. Once the resolution of the high-quality video stream is set, the system automatically sets the resolution, frame rate, and bitrate of the low-quality video stream.The SDK enables the low-quality video stream auto mode on the sender by default (not actively sending low-quality video streams). The host at the receiving end can call this method to initiate a low-quality video stream stream request on the receiving end, and the sender automatically switches to the low-quality video stream mode after receiving the request.The result of this method returns in the onApiCallExecuted callback.You can call this method either before or after joining a channel. If you call both setRemoteVideoStreamType and setRemoteDefaultVideoStreamType , the setting of setRemoteVideoStreamType takes effect.
  ///
  /// * [uid] The user ID.
  /// * [streamType] The video stream type: VideoStreamType .
  Future<void> setRemoteVideoStreamType(
      {required int uid, required VideoStreamType streamType});

  /// Options for subscribing to remote video streams.
  /// When a remote user has enabled dual-stream mode, you can call this method to choose the option for subscribing to the video streams sent by the remote user.If you only register one VideoFrameObserver object, the SDK subscribes to the raw video data and encoded video data by default (the effect is equivalent to setting encodedFrameOnly to false).If you only register one VideoEncodedFrameObserver object, the SDK only subscribes to the encoded video data by default (the effect is equivalent to setting encodedFrameOnly to true).If you register one VideoFrameObserver object and one VideoEncodedFrameObserver object successively, the SDK subscribes to the encoded video data by default (the effect is equivalent to setting encodedFrameOnly to false).If you call this method first with the options parameter set, and then register one VideoFrameObserver or VideoEncodedFrameObserver object, you need to call this method again and set the options parameter as described in the above two items to get the desired results.Agora recommends the following steps:Set autoSubscribeVideo to false when calling joinChannel [2/2] to join a channel.Call this method after receiving the onUserJoined callback to set the subscription options for the specified remote user's video stream.Call the muteRemoteVideoStream method to resume subscribing to the video stream of the specified remote user. If you set encodedFrameOnly to true in the previous step, the SDK triggers the onEncodedVideoFrameReceived callback locally to report the received encoded video frame information.
  ///
  /// * [uid] The user ID of the remote user.
  /// * [options] The video subscription options. See VideoSubscriptionOptions .
  Future<void> setRemoteVideoSubscriptionOptions(
      {required int uid, required VideoSubscriptionOptions options});

  /// Sets the default stream type of subscrption for remote video streams.
  /// The SDK enables the low-quality video stream auto mode on the sender by default (not actively sending low-quality video streams). The host at the receiving end can call this method to initiate a low-quality video stream stream request on the receiving end, and the sender automatically switches to the low-quality video stream mode after receiving the request.Under limited network conditions, if the publisher has not disabled the dual-stream mode using enableDualStreamMode (false), the receiver can choose to receive either the high-quality video stream or the low-quality video stream. The high-quality video stream has a higher resolution and bitrate, and the low-quality video stream has a lower resolution and bitrate.By default, users receive the high-quality video stream. Call this method if you want to switch to the low-quality video stream. This method allows the app to adjust the corresponding video stream type based on the size of the video window to reduce the bandwidth and resources. The aspect ratio of the low-quality video stream is the same as the high-quality video stream. Once the resolution of the high-quality video stream is set, the system automatically sets the resolution, frame rate, and bitrate of the low-quality video stream.The result of this method returns in the onApiCallExecuted callback.Call this method before joining a channel. Agora does not support changing the default subscribed video stream type after joining a channel.If you call both this method and setRemoteVideoStreamType , the SDK applies the settings in the setRemoteVideoStreamType method.
  ///
  /// * [streamType] The default video-stream type. See VideoStreamType .
  Future<void> setRemoteDefaultVideoStreamType(VideoStreamType streamType);

  /// Set the blocklist of subscriptions for audio streams.
  /// You can call this method to specify the audio streams of a user that you do not want to subscribe to.You can call this method either before or after joining a channel.The blocklist is not affected by the setting in muteRemoteAudioStream , muteAllRemoteAudioStreams , and autoSubscribeAudio in ChannelMediaOptions .Once the blocklist of subscriptions is set, it is effective even if you leave the current channel and rejoin the channel.If a user is added in the allowlist and blocklist at the same time, only the blocklist takes effect.
  ///
  /// * [uidList] The user ID list of users that you do not want to subscribe to.If you want to specify the audio streams of a user that you do not want to subscribe to, add the user ID in this list. If you want to remove a user from the blocklist, you need to call the setSubscribeAudioBlocklist method to update the user ID list; this means you only add the uid of users that you do not want to subscribe to in the new user ID list.
  /// * [uidNumber] The number of users in the user ID list.
  Future<void> setSubscribeAudioBlocklist(
      {required List<int> uidList, required int uidNumber});

  /// Sets the allowlist of subscriptions for audio streams.
  /// You can call this method to specify the audio streams of a user that you want to subscribe to.If a user is added in the allowlist and blocklist at the same time, only the blocklist takes effect.You can call this method either before or after joining a channel.The allowlist is not affected by the setting in muteRemoteAudioStream , muteAllRemoteAudioStreams and autoSubscribeAudio in ChannelMediaOptions .Once the allowlist of subscriptions is set, it is effective even if you leave the current channel and rejoin the channel.
  ///
  /// * [uidList] The user ID list of users that you want to subscribe to.If you want to specify the audio streams of a user for subscription, add the user ID in this list. If you want to remove a user from the allowlist, you need to call the setSubscribeAudioAllowlist method to update the user ID list; this means you only add the uid of users that you want to subscribe to in the new user ID list.
  /// * [uidNumber] The number of users in the user ID list.
  Future<void> setSubscribeAudioAllowlist(
      {required List<int> uidList, required int uidNumber});

  /// Set the blocklist of subscriptions for video streams.
  /// You can call this method to specify the video streams of a user that you do not want to subscribe to.If a user is added in the allowlist and blocklist at the same time, only the blocklist takes effect.Once the blocklist of subscriptions is set, it is effective even if you leave the current channel and rejoin the channel.You can call this method either before or after joining a channel.The blocklist is not affected by the setting in muteRemoteVideoStream , muteAllRemoteVideoStreams and autoSubscribeAudio in ChannelMediaOptions .
  ///
  /// * [uidNumber] The number of users in the user ID list.
  /// * [uidList] The user ID list of users that you do not want to subscribe to.If you want to specify the video streams of a user that you do not want to subscribe to, add the user ID of that user in this list. If you want to remove a user from the blocklist, you need to call the setSubscribeVideoBlocklist method to update the user ID list; this means you only add the uid of users that you do not want to subscribe to in the new user ID list.
  Future<void> setSubscribeVideoBlocklist(
      {required List<int> uidList, required int uidNumber});

  /// Set the allowlist of subscriptions for video streams.
  /// You can call this method to specify the video streams of a user that you want to subscribe to.If a user is added in the allowlist and blocklist at the same time, only the blocklist takes effect.
  ///  Once the allowlist of subscriptions is set, it is effective even if you leave the current channel and rejoin the channel.
  ///  You can call this method either before or after joining a channel.
  ///  The allowlist is not affected by the setting in muteRemoteVideoStream , muteAllRemoteVideoStreams and autoSubscribeAudio in ChannelMediaOptions .
  ///
  /// * [uidNumber] The number of users in the user ID list.
  /// * [uidList] The user ID list of users that you want to subscribe to.If you want to specify the video streams of a user for subscription, add the user ID of that user in this list. If you want to remove a user from the allowlist, you need to call the setSubscribeVideoAllowlist method to update the user ID list; this means you only add the uid of users that you want to subscribe to in the new user ID list.
  Future<void> setSubscribeVideoAllowlist(
      {required List<int> uidList, required int uidNumber});

  /// Enables the reporting of users' volume indication.
  /// This method enables the SDK to regularly report the volume information of the local user who sends a stream and remote users (up to three) whose instantaneous volumes are the highest to the app. Once you call this method and users send streams in the channel, the SDK triggers the onAudioVolumeIndication callback at the time interval set in this method.You can call this method either before or after joining a channel.
  ///
  /// * [interval] Sets the time interval between two consecutive volume indications:≤ 0: Disables the volume indication.> 0: Time interval (ms) between two consecutive volume indications. You need to set this parameter to an integer multiple of 200. If the value is lower than 200, the SDK automatically adjusts the value to 200.
  /// * [smooth] The smoothing factor sets the sensitivity of the audio volume indicator. The value ranges between 0 and 10. The recommended value is 3. The greater the value, the more sensitive the indicator.
  /// * [reportVad] true: Enable the voice activity detection of the local user. Once it is enabled,the vad parameter of the onAudioVolumeIndication callback reports the voice activity status of the local user.false: (Default) Disable the voice activity detection of the local user. Once it is disabled, the vad parameter of the onAudioVolumeIndication callback does not report the voice activity status of the local user, except for the scenario where the engine automatically detects the voice activity of the local user.
  Future<void> enableAudioVolumeIndication(
      {required int interval, required int smooth, required bool reportVad});

  /// Starts the audio recording on the client.
  /// The Agora SDK allows recording during a call. After successfully calling this method, you can record the audio of all the users in the channel and get an audio recording file. Supported formats of the recording file are as follows:WAV: High-fidelity files with typically larger file sizes. For example, the size of a WAV file with a sample rate of 32,000 Hz and a recording duration of 10 minutes is around 73 MB.AAC: Low-fidelity files with typically smaller file sizes. For example, if the sample rate is 32,000 Hz and the recording quality is audioRecordingQualityMedium, the file size for a 10-minute recording is approximately 2 MB.Once the user leaves the channel, the recording automatically stops.Call this method after joining a channel.
  ///
  /// * [config] Recording configuration. See AudioRecordingConfiguration .
  Future<void> startAudioRecording(AudioRecordingConfiguration config);

  /// Registers an encoded audio observer.
  /// Call this method after joining a channel.You can call this method or the startAudioRecording method to set the audio content and audio quality. Agora recommends not using this method and startAudioRecording at the same time; otherwise, only the method called later takes effect.
  ///
  /// * [config] Observer settings for the encoded audio. See AudioEncodedFrameObserverConfig .
  /// * [observer] The encoded audio observer. See AudioEncodedFrameObserver .
  void registerAudioEncodedFrameObserver(
      {required AudioEncodedFrameObserverConfig config,
      required AudioEncodedFrameObserver observer});

  /// Stops the audio recording on the client.
  Future<void> stopAudioRecording();

  /// Creates a media player instance.
  ///
  /// Returns
  /// The MediaPlayer instance, if the method call succeeds.An empty pointer , if the method call fails.
  Future<MediaPlayer> createMediaPlayer();

  /// Destroys the media player instance.
  Future<void> destroyMediaPlayer(MediaPlayer mediaPlayer);

  /// Starts playing the music file.
  /// This method mixes the specified local or online audio file with the audio from the microphone, or replaces the microphone's audio with the specified local or remote audio file. A successful method call triggers the onAudioMixingStateChanged (audioMixingStatePlaying) callback. When the audio mixing file playback finishes, the SDK triggers the onAudioMixingStateChanged(audioMixingStateStopped) callback on the local client.For the audio file formats supported by this method, see What formats of audio files the Agora RTC SDK support.You can call this method either before or after joining a channel. If you need to call startAudioMixing multiple times, ensure that the time interval between calling this method is more than 500 ms.If the local music file does not exist, the SDK does not support the file format, or the the SDK cannot access the music file URL, the SDK reports the warn code 701.
  ///
  /// * [filePath] File path:Android: The file path, which needs to be accurate to the file name and suffix. Agora supports using a URI address, an absolute path, or a path that starts with /assets/. You might encounter permission issues if you use an absolute path to access a local file, so Agora recommends using a URI address instead. For example: content://com.android.providers.media.documents/document/audio%3A14441.Windows: The absolute path or URL address (including the suffixes of the filename) of the audio effect file. For example: C:\music\audio.mp4.iOS or macOS: The absolute path or URL address (including the suffixes of the filename) of the audio effect file. For example: /var/mobile/Containers/Data/audio.mp4.
  /// * [loopback] Whether to only play music files on the local client:true: Only play music files on the local client so that only the local user can hear the music.false: Publish music files to remote clients so that both the local user and remote users can hear the music.
  /// * [cycle] The number of times the music file plays.≥ 0: The number of playback times. For example, 0 means that the SDK does not play the music file while 1 means that the SDK plays once.-1: Play the audio file in an infinite loop.
  /// * [startPos] The playback position (ms) of the music file.
  Future<void> startAudioMixing(
      {required String filePath,
      required bool loopback,
      required int cycle,
      int startPos = 0});

  /// Stops playing and mixing the music file.
  /// This method stops the audio mixing. Call this method when you are in a channel.
  Future<void> stopAudioMixing();

  /// Pauses playing the music file.
  /// Call this method after joining a channel.
  Future<void> pauseAudioMixing();

  /// Resumes playing and mixing the music file.
  /// This method resumes playing and mixing the music file. Call this method when you are in a channel.
  Future<void> resumeAudioMixing();

  /// Selects the audio track used during playback.
  /// After getting the track index of the audio file, you can call this method to specify any track to play. For example, if different tracks of a multi-track file store songs in different languages, you can call this method to set the playback language.For the supported formats of audio files, see .You need to call this method after calling startAudioMixing and receiving the onAudioMixingStateChanged (audioMixingStatePlaying) callback.
  ///
  /// * [index] The audio track you want to specify. The value range is [0, getAudioTrackCount ()].
  Future<void> selectAudioTrack(int index);

  /// Gets the index of audio tracks of the current music file.
  /// You need to call this method after calling startAudioMixing and receiving the onAudioMixingStateChanged(audioMixingStatePlaying) callback.
  ///
  /// Returns
  /// The SDK returns the index of the audio tracks if the method call succeeds.< 0: Failure.
  Future<int> getAudioTrackCount();

  /// Adjusts the volume during audio mixing.
  /// This method adjusts the audio mixing volume on both the local client and remote clients.Call this method after the startAudioMixing method.
  ///
  /// * [volume] Audio mixing volume. The value ranges between 0 and 100. The default value is 100, which means the original volume.
  Future<void> adjustAudioMixingVolume(int volume);

  /// Adjusts the volume of audio mixing for publishing.
  /// This method adjusts the audio mixing volume on the remote clients.Call this method after calling startAudioMixing and receiving the onAudioMixingStateChanged(audioMixingStatePlaying) callback.
  ///
  /// * [volume] The volume of audio mixing for local playback. The value ranges between 0 and 100 (default). 100 represents the original volume.
  Future<void> adjustAudioMixingPublishVolume(int volume);

  /// Retrieves the audio mixing volume for publishing.
  /// This method helps to troubleshoot audio volume‑related issues.You need to call this method after calling startAudioMixing and receiving the onAudioMixingStateChanged(audioMixingStatePlaying) callback.
  ///
  /// Returns
  /// The audio mixing volume, if this method call succeeds. The value range is [0,100].< 0: Failure.
  Future<int> getAudioMixingPublishVolume();

  /// Adjusts the volume of audio mixing for local playback.
  /// Call this method after calling startAudioMixing and receiving the onAudioMixingStateChanged(audioMixingStatePlaying) callback.
  ///
  /// * [volume] The volume of audio mixing for local playback. The value ranges between 0 and 100 (default). 100 represents the original volume.
  Future<void> adjustAudioMixingPlayoutVolume(int volume);

  /// Retrieves the audio mixing volume for local playback.
  /// This method retrieves the audio mixing volume for local playback. You can use it to troubleshoot audio volume related issues.You need to call this method after calling startAudioMixing and receiving the onAudioMixingStateChanged(audioMixingStatePlaying) callback.
  ///
  /// Returns
  /// The audio mixing volume, if this method call succeeds. The value range is [0,100].< 0: Failure.
  Future<int> getAudioMixingPlayoutVolume();

  /// Retrieves the duration (ms) of the music file.
  /// Retrieves the total duration (ms) of the audio file.You need to call this method after calling startAudioMixing and receiving the onAudioMixingStateChanged (audioMixingStatePlaying) callback.
  ///
  /// Returns
  /// ≥ 0: The audio mixing duration, if this method call succeeds.< 0: Failure.
  Future<int> getAudioMixingDuration();

  /// Retrieves the playback position (ms) of the music file.
  /// Retrieves the playback position (ms) of the audio.You need to call this method after calling startAudioMixing and receiving the onAudioMixingStateChanged(audioMixingStatePlaying) callback.If you need to call getAudioMixingCurrentPosition multiple times, ensure that the time interval between calling this method is more than 500 ms.
  ///
  /// Returns
  /// ≥ 0: The current playback position (ms) of the audio mixing, if this method call succeeds. 0 represents that the current music file does not start playing.< 0: Failure.
  Future<int> getAudioMixingCurrentPosition();

  /// Sets the audio mixing position.
  /// Call this method to set the playback position of the music file to a different starting position, rather than playing the file from the beginning.You need to call this method after calling startAudioMixing and receiving the onAudioMixingStateChanged(audioMixingStatePlaying) callback.
  ///
  /// * [pos] Integer. The playback position (ms).
  Future<void> setAudioMixingPosition(int pos);

  /// Sets the channel mode of the current audio file.
  /// In a stereo music file, the left and right channels can store different audio data. According to your needs, you can set the channel mode to original mode, left channel mode, right channel mode, or mixed channel mode. For example, in the KTV scenario, the left channel of the music file stores the musical accompaniment, and the right channel stores the singing voice. If you only need to listen to the accompaniment, call this method to set the channel mode of the music file to left channel mode; if you need to listen to the accompaniment and the singing voice at the same time, call this method to set the channel mode to mixed channel mode.Call this method after calling startAudioMixing and receiving the onAudioMixingStateChanged (audioMixingStatePlaying) callback.This method only applies to stereo audio files.
  ///
  /// * [mode] The channel mode. See AudioMixingDualMonoMode .
  ///
  Future<void> setAudioMixingDualMonoMode(AudioMixingDualMonoMode mode);

  /// Sets the pitch of the local music file.
  /// When a local music file is mixed with a local human voice, call this method to set the pitch of the local music file only.You need to call this method after calling startAudioMixing and receiving the onAudioMixingStateChanged(audioMixingStatePlaying) callback.
  ///
  /// * [pitch] Sets the pitch of the local music file by the chromatic scale. The default value is 0, which means keeping the original pitch. The value ranges from -12 to 12, and the pitch value between consecutive values is a chromatic value. The greater the absolute value of this parameter, the higher or lower the pitch of the local music file.
  Future<void> setAudioMixingPitch(int pitch);

  /// Retrieves the volume of the audio effects.
  /// The volume range is [0,100]. The default value is 100, the original volume.Call this method after the playEffect method.
  ///
  /// Returns
  /// Volume of the audio effects, if this method call succeeds.< 0: Failure.
  Future<int> getEffectsVolume();

  /// Sets the volume of the audio effects.
  /// Call this method after the playEffect method.
  ///
  /// * [volume] The playback volume. The value range is [0, 100]. The default value is 100, which represents the original volume.
  Future<void> setEffectsVolume(int volume);

  /// Preloads a specified audio effect file into the memory.
  /// To ensure smooth communication, limit the size of the audio effect file. Agora recommends using this method to preload the audio effect before calling joinChannel [2/2].This method does not support online audio effect files.For the audio file formats supported by this method, see What formats of audio files the Agora RTC SDK support.
  ///
  /// * [soundId] The audio effect ID. The ID of each audio effect file is unique.
  /// * [filePath] File path:Android: The file path, which needs to be accurate to the file name and suffix. Agora supports using a URI address, an absolute path, or a path that starts with /assets/. You might encounter permission issues if you use an absolute path to access a local file, so Agora recommends using a URI address instead. For example: content://com.android.providers.media.documents/document/audio%3A14441.Windows: The absolute path or URL address (including the suffixes of the filename) of the audio effect file. For example: C:\music\audio.mp4.iOS or macOS: The absolute path or URL address (including the suffixes of the filename) of the audio effect file. For example: /var/mobile/Containers/Data/audio.mp4.
  /// * [startPos] The playback position (ms) of the audio effect file.
  Future<void> preloadEffect(
      {required int soundId, required String filePath, int startPos = 0});

  /// Plays the specified local or online audio effect file.
  /// If you use this method to play an online audio effect file, Agora recommends that you cache the online audio effect file to your local device, call preloadEffect to preload the cached audio effect file into memory, and then call this method to play the audio effect. Otherwise, you might encounter playback failures or no sound during playback due to loading timeouts or failures.To play multiple audio effect files at the same time, call this method multiple times with different soundId and filePath. For a better user experience, Agora recommends playing no more than three audio effect files at the same time. After the playback of an audio effect file completes, the SDK triggers the onAudioEffectFinished callback.
  ///
  /// * [soundId] The audio effect ID. The ID of each audio effect file is unique.If you have preloaded an audio effect into memory by calling preloadEffect , ensure that the value of this parameter is the same as that of soundId in preloadEffect.
  /// * [filePath] The absolute path or URL address (including the suffixes of the filename) of the audio effect file. For example, C:\music\audio.mp4. Supported audio formats include MP3, AAC, M4A, MP4, WAV, and 3GP. See supported audio formats.If you have preloaded an audio effect into memory by calling preloadEffect , ensure that the value of this parameter is the same as that of filePath in preloadEffect.
  /// * [loopCount] The number of times the audio effect loops.≥ 0: The number of playback times. For example, 1 means looping one time, which means playing the audio effect two times in total.-1: Play the audio effect in an infinite loop.
  /// * [pitch] The pitch of the audio effect. The value range is 0.5 to 2.0. The default value is 1.0, which means the original pitch. The lower the value, the lower the pitch.
  /// * [pan] The spatial position of the audio effect. The value ranges between -1.0 and 1.0:-1.0: The audio effect is heard on the left of the user.0.0: The audio effect is heard in front of the user.1.0: The audio effect is heard on the right of the user.
  /// * [gain] The volume of the audio effect. The value range is 0.0 to 100.0. The default value is 100.0, which means the original volume. The smaller the value, the lower the volume.
  /// * [publish] Whether to publish the audio effect to the remote users:true: Publish the audio effect to the remote users. Both the local user and remote users can hear the audio effect.false: Do not publish the audio effect to the remote users. Only the local user can hear the audio effect.
  /// * [startPos] The playback position (ms) of the audio effect file.
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
  /// * [loopCount] The number of times the audio effect loops:-1: Play the audio effect in an indefinite loop until you call stopEffect or stopAllEffects .0: Play the audio effect once.1: Play the audio effect twice.
  /// * [pitch] The pitch of the audio effect. The value ranges between 0.5 and 2.0. The default value is 1.0 (original pitch). The lower the value, the lower the pitch.
  /// * [pan] The spatial position of the audio effect. The value ranges between -1.0 and 1.0:-1.0: The audio effect shows on the left.0: The audio effect shows ahead.1.0: The audio effect shows on the right.
  /// * [gain] The volume of the audio effect. The value range is [0, 100]. The default value is 100 (original volume). The smaller the value, the lower the volume.
  /// * [publish] Whether to publish the audio effect to the remote users:true: Publish the audio effect to the remote users. Both the local user and remote users can hear the audio effect.false: Do not publish the audio effect to the remote users. Only the local user can hear the audio effect.
  Future<void> playAllEffects(
      {required int loopCount,
      required double pitch,
      required double pan,
      required int gain,
      bool publish = false});

  /// Gets the volume of a specified audio effect.
  ///
  /// * [soundId] The ID of the audio effect.
  ///
  /// Returns
  /// The volume of the specified audio effect, if the method call succeeds. The value range is [0,100]. 100 represents the original volume. < 0: Failure.
  Future<int> getVolumeOfEffect(int soundId);

  /// Sets the volume of a specified audio effect.
  ///
  /// * [soundId] The audio effect ID. The ID of each audio effect file is unique.
  /// * [volume] The playback volume. The value range is [0, 100]. The default value is 100, which represents the original volume.
  Future<void> setVolumeOfEffect({required int soundId, required int volume});

  /// Pauses playing a specified audio effect file.
  ///
  /// * [soundId] The audio effect ID. The ID of each audio effect file is unique.
  Future<void> pauseEffect(int soundId);

  /// Pauses playing all audio effect files.
  Future<void> pauseAllEffects();

  /// Resumes playing a specified audio effect.
  ///
  /// * [soundId] The audio effect ID. The ID of each audio effect file is unique.
  Future<void> resumeEffect(int soundId);

  /// Resumes playing all audio effects.
  Future<void> resumeAllEffects();

  /// Stops playing a specified audio effect.
  ///
  /// * [soundId] The audio effect ID. The ID of each audio effect file is unique.
  Future<void> stopEffect(int soundId);

  /// Stops playing all audio effects.
  Future<void> stopAllEffects();

  /// Releases a specified preloaded audio effect from the memory.
  ///
  /// * [soundId] The audio effect ID. The ID of each audio effect file is unique.
  Future<void> unloadEffect(int soundId);

  /// Releases a specified preloaded audio effect from the memory.
  Future<void> unloadAllEffects();

  /// Retrieves the duration of the audio effect file.
  /// Call this method after joining a channel.
  ///
  /// * [filePath] File path:Android: The file path, which needs to be accurate to the file name and suffix. Agora supports using a URI address, an absolute path, or a path that starts with /assets/. You might encounter permission issues if you use an absolute path to access a local file, so Agora recommends using a URI address instead. For example: content://com.android.providers.media.documents/document/audio%3A14441.Windows: The absolute path or URL address (including the suffixes of the filename) of the audio effect file. For example: C:\music\audio.mp4.iOS or macOS: The absolute path or URL address (including the suffixes of the filename) of the audio effect file. For example: /var/mobile/Containers/Data/audio.mp4.
  ///
  /// Returns
  /// The total duration (ms) of the specified audio effect file, if the method call succeeds.< 0: Failure.
  Future<int> getEffectDuration(String filePath);

  /// Sets the playback position of an audio effect file.
  /// After a successful setting, the local audio effect file starts playing at the specified position.Call this method after playEffect.
  ///
  /// * [soundId] The audio effect ID. The ID of each audio effect file is unique.
  /// * [pos] The playback position (ms) of the audio effect file.
  Future<void> setEffectPosition({required int soundId, required int pos});

  /// Retrieves the playback position of the audio effect file.
  /// Call this method after the playEffect method.
  ///
  /// * [soundId] The audio effect ID. The ID of each audio effect file is unique.
  ///
  /// Returns
  /// The playback position (ms) of the specified audio effect file, if the method call succeeds.< 0: Failure.
  Future<int> getEffectCurrentPosition(int soundId);

  /// Enables/Disables stereo panning for remote users.
  /// Ensure that you call this method before joining a channel to enable stereo panning for remote users so that the local user can track the position of a remote user by calling setRemoteVoicePosition.
  ///
  /// * [enabled] Whether to enable stereo panning for remote users:true: Enable stereo panning.false: Disable stereo panning.
  Future<void> enableSoundPositionIndication(bool enabled);

  /// Sets the 2D position (the position on the horizontal plane) of the remote user's voice.
  /// This method sets the 2D position and volume of a remote user, so that the local user can easily hear and identify the remote user's position.When the local user calls this method to set the voice position of a remote user, the voice difference between the left and right channels allows the local user to track the real-time position of the remote user, creating a sense of space. This method applies to massive multiplayer online games, such as Battle Royale games.For this method to work, enable stereo panning for remote users by calling the enableSoundPositionIndication method before joining a channel.For the best voice positioning, Agora recommends using a wired headset.Call this method after joining a channel.
  ///
  /// * [uid] The user ID of the remote user.
  /// * [pan] The voice position of the remote user. The value ranges from -1.0 to 1.0:0.0: (Default) The remote voice comes from the front.-1.0: The remote voice comes from the left.1.0: The remote voice comes from the right.
  /// * [gain] The volume of the remote user. The value ranges from 0.0 to 100.0. The default value is 100.0 (the original volume of the remote user). The smaller the value, the lower the volume.
  Future<void> setRemoteVoicePosition(
      {required int uid, required double pan, required double gain});

  /// Enables or disables the spatial audio effect.
  /// After enabling the spatial audio effect, you can call setRemoteUserSpatialAudioParams to set the spatial audio effect parameters of the remote user.You can call this method either before or after joining a channel.This method relies on the spatial audio dynamic library libagora_spatial_audio_extension.dll. If the dynamic library is deleted, the function cannot be enabled normally.
  ///
  /// * [enabled] Whether to enable the spatial audio effect:true: Enable the spatial audio effect.false: Disable the spatial audio effect.
  Future<void> enableSpatialAudio(bool enabled);

  /// Sets the spatial audio effect parameters of the remote user.
  /// Call this method after enableSpatialAudio . After successfully setting the spatial audio effect parameters of the remote user, the local user can hear the remote user with a sense of space.
  ///
  /// * [uid] The user ID. This parameter must be the same as the user ID passed in when the user joined the channel.
  /// * [params] The spatial audio parameters. See SpatialAudioParams for details.
  Future<void> setRemoteUserSpatialAudioParams(
      {required int uid, required SpatialAudioParams params});

  /// Sets a preset voice beautifier effect.
  /// Call this method to set a preset voice beautifier effect for the local user who sends an audio stream. After setting a voice beautifier effect, all users in the channel can hear the effect. You can set different voice beautifier effects for different scenarios. For better voice effects, Agora recommends that you call setAudioProfile and set scenario to audioScenarioGameStreaming (3) and profile to audioProfileMusicHighQuality (4) or audioProfileMusicHighQualityStereo(5) before calling this method.You can call this method either before or after joining a channel.Do not set the profile parameter in setAudioProfile to audioProfileSpeechStandard(1) or audioProfileIot(6), or the method does not take effect.This method works best with the human voice. Agora does not recommend using this method for audio containing music.After calling setVoiceBeautifierPreset, Agora recommends not calling the following methods, because they can override settings in setVoiceBeautifierPreset: setAudioEffectPreset setAudioEffectParameters setLocalVoicePitch setLocalVoiceEqualization setLocalVoiceReverb setVoiceBeautifierParameters setVoiceConversionPreset This method relies on the voice beautifier dynamic library libagora_audio_beauty_extension.dll. If the dynamic library is deleted, the function cannot be enabled normally.
  ///
  /// * [preset] The preset voice beautifier effect options: VoiceBeautifierPreset .
  Future<void> setVoiceBeautifierPreset(VoiceBeautifierPreset preset);

  /// Sets an SDK preset audio effect.
  /// Call this method to set an SDK preset audio effect for the local user who sends an audio stream. This audio effect does not change the gender characteristics of the original voice. After setting an audio effect, all users in the channel can hear the effect.To get better audio effect quality, Agora recommends calling setAudioProfile and setting the scenario parameter as audioScenarioGameStreaming (3) before calling this method.You can call this method either before or after joining a channel.Do not set the profile parameter in setAudioProfile to audioProfileSpeechStandard(1) or audioProfileIot(6), or the method does not take effect.This method works best with the human voice. Agora does not recommend using this method for audio containing music.If you call setAudioEffectPreset and set enumerators except for roomAcoustics3dVoice or pitchCorrection, do not call setAudioEffectParameters ; otherwise, setAudioEffectPreset is overridden.After calling setAudioEffectPreset, Agora recommends not calling the following methods, or the settings in setAudioEffectPreset are overridden: setVoiceBeautifierPreset setLocalVoicePitch setLocalVoiceEqualization setLocalVoiceReverb setVoiceBeautifierParameters setVoiceConversionPreset This method relies on the voice beautifier dynamic library libagora_audio_beauty_extension.dll. If the dynamic library is deleted, the function cannot be enabled normally.
  ///
  /// * [preset] The options for SDK preset audio effects. See AudioEffectPreset .
  Future<void> setAudioEffectPreset(AudioEffectPreset preset);

  /// Sets a preset voice beautifier effect.
  /// Call this method to set a preset voice beautifier effect for the local user who sends an audio stream. After setting an audio effect, all users in the channel can hear the effect. You can set different voice beautifier effects for different scenarios. To achieve better audio effect quality, Agora recommends that you call setAudioProfile and set the profile to audioProfileMusicHighQuality (4) or audioProfileMusicHighQualityStereo (5) and scenario to audioScenarioGameStreaming(3) before calling this method.You can call this method either before or after joining a channel.Do not set the profile parameter in setAudioProfile to audioProfileSpeechStandard(1) or audioProfileIot(6), or the method does not take effect.This method works best with the human voice. Agora does not recommend using this method for audio containing music.After calling setVoiceConversionPreset, Agora recommends not calling the following methods, or the settings in setVoiceConversionPreset are overridden: setAudioEffectPreset setAudioEffectParameters setVoiceBeautifierPreset setVoiceBeautifierParameters setLocalVoicePitch setLocalVoiceEqualization setLocalVoiceReverb This method relies on the voice beautifier dynamic library libagora_audio_beauty_extension.dll. If the dynamic library is deleted, the function cannot be enabled normally.
  ///
  /// * [preset] The options for the preset voice beautifier effects: VoiceConversionPreset .
  Future<void> setVoiceConversionPreset(VoiceConversionPreset preset);

  /// Sets parameters for SDK preset audio effects.
  /// Call this method to set the following parameters for the local user who sends an audio stream:3D voice effect: Sets the cycle period of the 3D voice effect.Pitch correction effect: Sets the basic mode and tonic pitch of the pitch correction effect. Different songs have different modes and tonic pitches. Agora recommends bounding this method with interface elements to enable users to adjust the pitch correction interactively.After setting the audio parameters, all users in the channel can hear the effect.You can call this method either before or after joining a channel.To get better audio effect quality, Agora recommends calling and setting scenario in setAudioProfile as audioScenarioGameStreaming(3) before calling this method.Do not set the profile parameter in setAudioProfile to audioProfileSpeechStandard(1) or audioProfileIot(6), or the method does not take effect.This method works best with the human voice. Agora does not recommend using this method for audio containing music.After calling setAudioEffectParameters, Agora recommends not calling the following methods, or the settings in setAudioEffectParameters are overridden: setAudioEffectPreset setVoiceBeautifierPreset setLocalVoicePitch setLocalVoiceEqualization setLocalVoiceReverb setVoiceBeautifierParameters setVoiceConversionPreset
  ///
  /// * [preset] The options for SDK preset audio effects:roomAcoustics3dVoice, 3D voice effect:You need to set the profile parameter in setAudioProfile to audioProfileMusicStandardStereo(3) or audioProfileMusicHighQualityStereo(5) before setting this enumerator; otherwise, the enumerator setting does not take effect.If the 3D voice effect is enabled, users need to use stereo audio playback devices to hear the anticipated voice effect.pitchCorrection; pitch correction effect: To achieve better audio effect quality, Agora recommends setting the profile parameter in setAudioProfile to audioProfileMusicHighQuality(4) or audioProfileMusicHighQualityStereo(5) before setting this enumerator.
  /// * [param1] If you set preset to roomAcoustics3dVoice, param1 indicates the cycle period of the 3D voice effect. The value range is [1,60], in seconds. The default value is 10, indicating that the voice moves around you every 10 seconds. If you set preset to pitchCorrection, param1 indicates the basic mode of the pitch correction effect:1: (Default) Natural major scale.2: Natural minor scale.3: Japanese pentatonic scale.
  /// * [param2] If you set preset to roomAcoustics3dVoice, you need to set param2 to 0. If you set preset to pitchCorrection, param2 indicates the tonic pitch of the pitch correction effect:1: A2: A#3: B4: (Default) C5: C#6: D7: D#8: E9: F10: F#11: G12: G#
  Future<void> setAudioEffectParameters(
      {required AudioEffectPreset preset,
      required int param1,
      required int param2});

  /// Sets parameters for the preset voice beautifier effects.
  /// Call this method to set a gender characteristic and a reverberation effect for the singing beautifier effect. This method sets parameters for the local user who sends an audio stream. After setting the audio parameters, all users in the channel can hear the effect.For better voice effects, Agora recommends that you call setAudioProfile and set scenario to audioScenarioGameStreaming(3) and profile to audioProfileMusicHighQuality(4) or audioProfileMusicHighQualityStereo(5) before calling this method.You can call this method either before or after joining a channel.Do not set the profile parameter in setAudioProfile to audioProfileSpeechStandard(1)This method works best with the human voice. Agora does not recommend using this method for audio containing music.After calling setVoiceBeautifierParameters, Agora recommends not calling the following methods, because they can override settings in setVoiceBeautifierParameters: setAudioEffectPreset setAudioEffectParameters setVoiceBeautifierPreset setLocalVoicePitch setLocalVoiceEqualization setLocalVoiceReverb setVoiceConversionPreset
  ///
  /// * [preset] The option for the preset audio effect:SINGING_BEAUTIFIER: The singing beautifier effect.
  /// * [param1] The gender characteristics options for the singing voice:1: A male-sounding voice.2: A female-sounding voice.
  /// * [param2] The reverberation effect options for the singing voice:1: The reverberation effect sounds like singing in a small room.2: The reverberation effect sounds like singing in a large room.3: The reverberation effect sounds like singing in a hall.
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
  /// * [pitch] The local voice pitch. The value range is [0.5,2.0]. The lower the value, the lower the pitch. The default value is 1 (no change to the pitch).
  Future<void> setLocalVoicePitch(double pitch);

  /// Sets the local voice equalization effect.
  /// You can call this method either before or after joining a channel.
  ///
  /// * [bandFrequency] The band frequency. The value ranges between 0 and 9; representing the respective 10-band center frequencies of the voice effects, including 31, 62, 125, 250, 500, 1k, 2k, 4k, 8k, and 16k Hz.
  /// * [bandGain] The gain of each band in dB. The value ranges between -15 and 15. The default value is 0.
  Future<void> setLocalVoiceEqualization(
      {required AudioEqualizationBandFrequency bandFrequency,
      required int bandGain});

  /// Sets the local voice reverberation.
  /// The SDK also provides the setAudioEffectPreset method, which allows you to directly implement preset reverb effects for such as pop, R&B, and KTV.You can call this method either before or after joining a channel.
  ///
  /// * [reverbKey] The reverberation key. Agora provides five reverberation keys; see AudioReverbType for details.
  /// * [value] The value of the reverberation key.
  Future<void> setLocalVoiceReverb(
      {required AudioReverbType reverbKey, required int value});

  /// Sets the preset headphone equalization effect.
  /// This method is mainly used in spatial audio effect scenarios. You can select the preset headphone equalizer to listen to the audio to achieve the expected audio experience.If the headphones you use already have a good equalization effect, you may not get a significant improvement when you call this method, and could even diminish the experience.
  ///
  /// * [preset] The preset headphone equalization effect. See HeadphoneEqualizerPreset .
  Future<void> setHeadphoneEQPreset(HeadphoneEqualizerPreset preset);

  /// Sets the low- and high-frequency parameters of the headphone equalizer.
  /// In a spatial audio effect scenario, if the preset headphone equalization effect is not achieved after calling the setHeadphoneEQPreset method, you can further adjust the headphone equalization effect by calling this method.
  ///
  /// * [lowGain] The low-frequency parameters of the headphone equalizer. The value range is [-10,10]. The larger the value, the deeper the sound.
  /// * [highGain] The high-frequency parameters of the headphone equalizer. The value range is [-10,10]. The larger the value, the sharper the sound.
  Future<void> setHeadphoneEQParameters(
      {required int lowGain, required int highGain});

  /// Sets the log file.
  /// Deprecated:Use the mLogConfig parameter in initialize method instead.Specifies an SDK output log file. The log file records all log data for the SDK’s operation. Ensure that the directory for the log file exists and is writable.Ensure that you call this method immediately after calling the initialize method to initialize the RtcEngine , or the output log may not be complete.
  ///
  /// * [filePath] The complete path of the log files. These log files are encoded in UTF-8.
  Future<void> setLogFile(String filePath);

  /// Sets the log output level of the SDK.
  /// Deprecated:Use logConfig in initialize instead.This method sets the output log level of the SDK. You can use one or a combination of the log filter levels. The log level follows the sequence of logFilterOff, logFilterCritical, logFilterError, logFilterWarn, logFilterInfo, and logFilterDebug. Choose a level to see the logs preceding that level.If, for example, you set the log level to logFilterWarn, you see the logs within levels logFilterCritical, logFilterError, and logFilterWarn.
  ///
  /// * [filter] The output log level of the SDK. See LogFilterType .
  Future<void> setLogFilter(LogFilterType filter);

  /// Sets the output log level of the SDK.
  /// Deprecated:This method is deprecated. Use RtcEngineContext instead to set the log output level.Choose a level to see the logs preceding that level.
  ///
  /// * [level] The log level: LogLevel .
  Future<void> setLogLevel(LogLevel level);

  /// Sets the log file size.
  /// Deprecated:Use the logConfig parameter in initialize instead.By default, the SDK generates five SDK log files and five API call log files with the following rules:The SDK log files are: agorasdk.log, agorasdk.1.log, agorasdk.2.log, agorasdk.3.log, and agorasdk.4.log.The API call log files are: agoraapi.log, agoraapi.1.log, agoraapi.2.log, agoraapi.3.log, and agoraapi.4.log.The default size for each SDK log file is 1,024 KB; the default size for each API call log file is 2,048 KB. These log files are encoded in UTF-8.The SDK writes the latest logs in agorasdk.log or agoraapi.log.When agorasdk.log is full, the SDK processes the log files in the following order:Delete the agorasdk.4.log file (if any).Rename agorasdk.3.log to agorasdk.4.log.Rename agorasdk.2.log to agorasdk.3.log.Rename agorasdk.1.log to agorasdk.2.log.Create a new agorasdk.log file.The overwrite rules for the agoraapi.log file are the same as for agorasdk.log.This method is used to set the size of the agorasdk.log file only and does not effect the agoraapi.log file.
  ///
  /// * [fileSizeInKBytes] The size (KB) of an agorasdk.log file. The value range is [128,20480]. The default value is 1,024 KB. If you set fileSizeInKByte smaller than 128 KB, the SDK automatically adjusts it to 128 KB; if you set fileSizeInKByte greater than 20,480 KB, the SDK automatically adjusts it to 20,480 KB.
  Future<void> setLogFileSize(int fileSizeInKBytes);

  /// @nodoc
  Future<void> uploadLogFile(String requestId);

  /// Updates the display mode of the local video view.
  /// After initializing the local video view, you can call this method to update its rendering and mirror modes. It affects only the video view that the local user sees, not the published local video stream.Ensure that you have called the setupLocalVideo method to initialize the local video view before calling this method.During a call, you can call this method as many times as necessary to update the display mode of the local video view.
  ///
  /// * [renderMode] The local video display mode. See RenderModeType .
  /// * [mirrorMode] The rendering mode of the local video view. See VideoMirrorModeType .If you use a front camera, the SDK enables the mirror mode by default; if you use a rear camera, the SDK disables the mirror mode by default.
  Future<void> setLocalRenderMode(
      {required RenderModeType renderMode,
      VideoMirrorModeType mirrorMode =
          VideoMirrorModeType.videoMirrorModeAuto});

  /// Updates the display mode of the video view of a remote user.
  /// After initializing the video view of a remote user, you can call this method to update its rendering and mirror modes. This method affects only the video view that the local user sees.Please call this method after initializing the remote view by calling the setupRemoteVideo method.During a call, you can call this method as many times as necessary to update the display mode of the video view of a remote user.
  ///
  /// * [uid] The user ID of the remote user.
  /// * [renderMode] The rendering mode of the remote user view.
  /// * [mirrorMode] The mirror mode of the remote user view.
  Future<void> setRemoteRenderMode(
      {required int uid,
      required RenderModeType renderMode,
      required VideoMirrorModeType mirrorMode});

  /// Sets the local video mirror mode.
  /// Deprecated:This method is deprecated.Use setupLocalVideo or setLocalRenderMode instead.
  ///
  /// * [mirrorMode] The local video mirror mode. See VideoMirrorModeType .
  Future<void> setLocalVideoMirrorMode(VideoMirrorModeType mirrorMode);

  /// Enables or disables dual-stream mode.
  /// You can call this method to enable or disable the dual-stream mode on the publisher side. Dual streams are a pairing of a high-quality video stream and a low-quality video stream:High-quality video stream: High bitrate, high resolution.Low-quality video stream: Low bitrate, low resolution.After you enable dual-stream mode, you can call setRemoteVideoStreamType to choose to receive either the high-quality video stream or the low-quality video stream on the subscriber side.This method is applicable to all types of streams from the sender, including but not limited to video streams collected from cameras, screen sharing streams, and custom-collected video streams.If you need to enable dual video streams in a multi-channel scenario, you can call the enableDualStreamModeEx method.You can call this method either before or after joining a channel.
  ///
  /// * [streamConfig] The configuration of the low-quality video stream. See SimulcastStreamConfig.
  /// * [enabled] Whether to enable dual-stream mode:true: Enable dual-stream mode.false: Disable dual-stream mode.
  Future<void> enableDualStreamMode(
      {required bool enabled, SimulcastStreamConfig? streamConfig});

  /// Sets dual-stream mode configuration on the sender, and sets the low-quality video stream.
  /// The SDK enables the low-quality video stream auto mode on the sender by default, which is equivalent to calling this method and setting the mode to autoSimulcastStream. If you want to modify this behavior, you can call this method and modify the mode to disableSimulcastStream(always never send low-quality video streams) or enableSimulcastStream (always send low-quality video streams).
  ///
  /// * [streamConfig] The configuration of the low-quality video stream. See SimulcastStreamConfig .
  ///
  /// * [mode] The mode in which the video stream is sent. See SimulcastStreamMode .
  Future<void> setDualStreamMode(
      {required SimulcastStreamMode mode, SimulcastStreamConfig? streamConfig});

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

  /// Sets the format of the captured raw audio data.
  /// Sets the audio format for the onRecordAudioFrame callback.Ensure that you call this method before joining a channel.The SDK calculates the sampling interval based on the samplesPerCall, sampleRate and channel parameters set in this method.Sample interval = samplePerCall/(sampleRate × channel). Ensure that the sample interval ≥ 0.01 (s).
  ///
  /// * [sampleRate] The sample rate returned in the onRecordAudioFrame callback, which can be set as 8000, 16000, 32000, 44100, or 48000 Hz.
  /// * [channel] The number of channels returned in the onRecordAudioFrame callback:1: Mono.2: Stereo.
  /// * [mode] The use mode of the audio frame. See RawAudioFrameOpModeType .
  /// * [samplesPerCall] The number of data samples returned in the onRecordAudioFrame callback, such as 1024 for the Media Push.
  Future<void> setRecordingAudioFrameParameters(
      {required int sampleRate,
      required int channel,
      required RawAudioFrameOpModeType mode,
      required int samplesPerCall});

  /// Sets the audio data format for playback.
  /// Sets the data format for the onPlaybackAudioFrame callback.Ensure that you call this method before joining a channel.The SDK calculates the sampling interval based on the samplesPerCall, sampleRate and channel parameters set in this method.Sample interval = samplePerCall/(sampleRate × channel). Ensure that the sample interval ≥ 0.01 (s). The SDK triggers the onPlaybackAudioFrame callback according to the sampling interval.
  ///
  /// * [sampleRate] The sample rate returned in the onPlaybackAudioFrame callback, which can be set as 8000, 16000, 32000, 44100, or 48000 Hz.
  /// * [channel] The number of channels returned in the onPlaybackAudioFrame callback:1: Mono.2: Stereo.
  /// * [mode] The use mode of the audio frame. See RawAudioFrameOpModeType .
  /// * [samplesPerCall] The number of data samples returned in the onPlaybackAudioFrame callback, such as 1024 for the Media Push.
  Future<void> setPlaybackAudioFrameParameters(
      {required int sampleRate,
      required int channel,
      required RawAudioFrameOpModeType mode,
      required int samplesPerCall});

  /// Sets the audio data format reported by onMixedAudioFrame .
  ///
  /// * [sampleRate] The sample rate (Hz) of the audio data, which can be set as 8000, 16000, 32000, 44100, or 48000.
  /// * [channel] The number of channels of the audio data, which can be set as 1 (Mono) or 2 (Stereo).
  /// * [samplesPerCall] Sets the number of samples. In Media Push scenarios, set it as 1024.
  Future<void> setMixedAudioFrameParameters(
      {required int sampleRate,
      required int channel,
      required int samplesPerCall});

  /// Sets the format of the in-ear monitoring raw audio data.
  /// This method is used to set the in-ear monitoring audio data format reported by the onEarMonitoringAudioFrame callback.Before calling this method, you need to call enableInEarMonitoring , and set includeAudioFilters to earMonitoringFilterBuiltInAudioFilters or earMonitoringFilterNoiseSuppression.The SDK calculates the sampling interval based on the samplesPerCall, sampleRate and channel parameters set in this method.Sample interval (sec) = samplePerCall/(sampleRate × channel). Ensure that the sample interval ≥ 0.01 (s). The SDK triggers the onEarMonitoringAudioFrame callback according to the sampling interval.
  ///
  /// * [sampleRate] The sample rate of the audio data reported in the onEarMonitoringAudioFrame callback, which can be set as 8,000, 16,000, 32,000, 44,100, or 48,000 Hz.
  /// * [channel] The number of audio channels reported in the onEarMonitoringAudioFrame callback.1: Mono.2: Stereo.
  /// * [mode] The use mode of the audio frame. See RawAudioFrameOpModeType .
  /// * [samplesPerCall] The number of data samples reported in the onEarMonitoringAudioFrame callback, such as 1,024 for the Media Push.
  Future<void> setEarMonitoringAudioFrameParameters(
      {required int sampleRate,
      required int channel,
      required RawAudioFrameOpModeType mode,
      required int samplesPerCall});

  /// Sets the audio data format reported by onPlaybackAudioFrameBeforeMixing .
  ///
  /// * [sampleRate] The sample rate (Hz) of the audio data, which can be set as 8000, 16000, 32000, 44100, or 48000.
  /// * [channel] The number of channels of the external audio source, which can be set as 1(Mono) or 2(Stereo).
  Future<void> setPlaybackAudioFrameBeforeMixingParameters(
      {required int sampleRate, required int channel});

  /// Turns on audio spectrum monitoring.
  /// If you want to obtain the audio spectrum data of local or remote users, you can register the audio spectrum observer and enable audio spectrum monitoring.You can call this method either before or after joining a channel.
  ///
  /// * [intervalInMS] The interval (in milliseconds) at which the SDK triggers the onLocalAudioSpectrum and onRemoteAudioSpectrum callbacks. The default value is 100. Do not set this parameter to less than 10 milliseconds, otherwise the calling of this method fails.
  Future<void> enableAudioSpectrumMonitor({int intervalInMS = 100});

  /// Disables audio spectrum monitoring.
  /// After calling enableAudioSpectrumMonitor , if you want to disable audio spectrum monitoring, you can call this method.You can call this method either before or after joining a channel.
  Future<void> disableAudioSpectrumMonitor();

  /// Registers an audio spectrum observer.
  /// After successfully registering the audio spectrum observer and calling
  ///  enableAudioSpectrumMonitor to enable the audio spectrum monitoring, the SDK reports the callback that you implement in the AudioSpectrumObserver class at the time interval you set.You can call this method either before or after joining a channel.
  ///
  /// * [observer] The Audio spectrum observer. See AudioSpectrumObserver .
  void registerAudioSpectrumObserver(AudioSpectrumObserver observer);

  /// Unregisters the audio spectrum observer.
  /// After calling registerAudioSpectrumObserver , if you want to disable audio spectrum monitoring, you can call this method.You can call this method either before or after joining a channel.
  void unregisterAudioSpectrumObserver(AudioSpectrumObserver observer);

  /// Adjusts the capturing signal volume.
  /// You can call this method either before or after joining a channel.
  ///
  /// * [volume] The volume of the user. The value range is [0,400].0: Mute.100: (Default) The original volume.400: Four times the original volume (amplifying the audio signals by four times).
  Future<void> adjustRecordingSignalVolume(int volume);

  /// Whether to mute the recording signal.
  ///
  /// * [mute] true: Mute the recording signal.false: (Default) Do not mute the recording signal.
  Future<void> muteRecordingSignal(bool mute);

  /// Adjusts the playback signal volume of all remote users.
  /// This method adjusts the playback volume that is the mixed volume of all remote users.You can call this method either before or after joining a channel.
  ///
  /// * [volume] The volume of the user. The value range is [0,400].
  ///  0: Mute.
  ///  100: (Default) The original volume.
  ///  400: Four times the original volume (amplifying the audio signals by four times).
  Future<void> adjustPlaybackSignalVolume(int volume);

  /// Adjusts the playback signal volume of a specified remote user.
  /// You can call this method to adjust the playback volume of a specified remote user. To adjust the playback volume of different remote users, call the method as many times, once for each remote user.Call this method after joining a channel.The playback volume here refers to the mixed volume of a specified remote user.
  ///
  /// * [volume] Audio mixing volume. The value ranges between 0 and 100. The default value is 100, which means the original volume.
  /// * [uid] The user ID of the remote user.
  Future<void> adjustUserPlaybackSignalVolume(
      {required int uid, required int volume});

  /// @nodoc
  Future<void> setLocalPublishFallbackOption(StreamFallbackOptions option);

  /// @nodoc
  Future<void> setRemoteSubscribeFallbackOption(StreamFallbackOptions option);

  /// Enables loopback audio capture.
  /// If you enable loopback audio capture, the output of the sound card is mixed into the audio stream sent to the other end.Applies to the macOS and Windows platforms only.macOS does not support loopback audio capture of the default sound card. If you need to use this method, use a virtual sound card and pass its name to the deviceName parameter. Agora recommends that you use Soundflower for loopback audio capture.You can call this method either before or after joining a channel.
  ///
  /// * [enabled] Whether to enable loopback audio capture.true: Enable loopback audio capture.false: (Default) Disable loopback audio capture.
  /// * [deviceName] macOS: The device name of the virtual sound card. The default is set to null, which means the SDK uses Soundflower for loopback audio capture.Windows: The device name of the sound card. The default is set to null, which means the SDK uses the sound card of your device for loopback audio capture.
  Future<void> enableLoopbackRecording(
      {required bool enabled, String? deviceName});

  /// Adjusts the volume of the signal captured by the sound card.
  /// After calling enableLoopbackRecording to enable loopback audio capturing, you can call this method to adjust the volume of the signal captured by the sound card.
  ///
  /// * [volume] Audio mixing volume. The value ranges between 0 and 100. The default value is 100, which means the original volume.
  Future<void> adjustLoopbackSignalVolume(int volume);

  /// @nodoc
  Future<int> getLoopbackRecordingVolume();

  /// Enables in-ear monitoring.
  /// This method enables or disables in-ear monitoring.Users must use wired earphones to hear their own voices.You can call this method either before or after joining a channel.
  ///
  /// * [enabled] Enables or disables in-ear monitoring.true: Enables in-ear monitoring.false: (Default) Disables in-ear monitoring.
  /// * [includeAudioFilters] The audio filter of in-ear monitoring: See EarMonitoringFilterType .
  Future<void> enableInEarMonitoring(
      {required bool enabled,
      required EarMonitoringFilterType includeAudioFilters});

  /// Sets the volume of the in-ear monitor.
  /// This method applies to Android and iOS only.Users must use wired earphones to hear their own voices.You can call this method either before or after joining a channel.
  ///
  /// * [volume] The volume of the in-ear monitor. The value ranges between 0 and 100. The default value is 100.
  Future<void> setInEarMonitoringVolume(int volume);

  /// Adds an extension to the SDK.
  /// (For Windows and Android only)
  ///
  /// * [path] The extension library path and name. For example: /library/libagora_segmentation_extension.dll.
  /// * [unloadAfterUse] Whether to uninstall the current extension when you no longer using it:true: Uninstall the extension when the RtcEngine is destroyed.false: (Rcommended) Do not uninstall the extension until the process terminates.
  Future<void> loadExtensionProvider(
      {required String path, bool unloadAfterUse = false});

  /// Sets the properties of the extension provider.
  /// You can call this method to set the attributes of the extension provider and initialize the relevant parameters according to the type of the provider.Call this method after enableExtension , and before enabling the audio ( enableAudio / enableLocalAudio ) or the video ( enableVideo / enableLocalVideo ).
  ///
  /// * [value] The value of the extension key.
  /// * [key] The key of the extension.
  /// * [provider] The name of the extension provider.
  Future<void> setExtensionProviderProperty(
      {required String provider, required String key, required String value});

  /// Registers an extension.
  /// After the extension is loaded, you can call this method to register the extension.This method applies to Windows only.
  ///
  /// * [type] Type of media source. See MediaSourceType . In this method, this parameter supports only the following two settings:The default value is unknownMediaSource.If you want to use the second camera to capture video, set this parameter to secondaryCameraSource.
  /// * [extension] The name of the extension.
  /// * [provider] The name of the extension provider.
  Future<void> registerExtension(
      {required String provider,
      required String extension,
      MediaSourceType type = MediaSourceType.unknownMediaSource});

  /// Enables/Disables extensions.
  /// Ensure that you call this method before joining a channel.If you want to enable multiple extensions, you need to call this method multiple times.The data processing order of different extensions in the SDK is determined by the order in which the extensions are enabled. That is, the extension that is enabled first will process the data first.
  ///
  /// * [extension] The name of the extension.
  /// * [provider] The name of the extension provider.
  /// * [enable] Whether to enable the extension:true: Enable the extension.false: Disable the extension.
  /// * [type] Type of media source. See MediaSourceType . In this method, this parameter supports only the following two settings:The default value is unknownMediaSource.If you want to use the second camera to capture video, set this parameter to secondaryCameraSource.
  ///
  Future<void> enableExtension(
      {required String provider,
      required String extension,
      bool enable = true,
      MediaSourceType type = MediaSourceType.unknownMediaSource});

  /// Sets the properties of the extension.
  /// After enabling the extension, you can call this method to set the properties of the extension.
  ///
  /// * [provider] The name of the extension provider.
  /// * [extension] The name of the extension.
  /// * [key] The key of the extension.
  /// * [value] The value of the extension key.
  /// * [type] The type of the video source. See MediaSourceType .
  Future<void> setExtensionProperty(
      {required String provider,
      required String extension,
      required String key,
      required String value,
      MediaSourceType type = MediaSourceType.unknownMediaSource});

  /// Gets detailed information on the extensions.
  ///
  /// * [provider] The name of the extension provider.
  /// * [extension] The name of the extension.
  /// * [key] The key of the extension.
  /// * [type] Source type of the extension. See MediaSourceType .
  /// * [bufLen] Maximum length of the JSON string indicating the extension property. The maximum value is 512 bytes.
  ///
  /// Returns
  /// The extension information, if the method call succeeds.An empty string, if the method call fails.
  Future<String> getExtensionProperty(
      {required String provider,
      required String extension,
      required String key,
      required int bufLen,
      MediaSourceType type = MediaSourceType.unknownMediaSource});

  /// Sets the camera capture configuration.
  /// This method is for Android and iOS only.Call this method before calling joinChannel [2/2] , enableVideo , or enableLocalVideo , depending on which method you use to turn on your local camera.
  ///
  /// * [config] The camera capturer configuration. See CameraCapturerConfiguration .
  Future<void> setCameraCapturerConfiguration(
      CameraCapturerConfiguration config);

  /// Creates a customized video track.
  /// When you need to publish multiple custom captured videos in the channel, you can refer to the following steps:Call this method to create a video track and get the video track ID.In each channel's ChannelMediaOptions , set the customVideoTrackId parameter to the ID of the video track you want to publish, and set publishCustomVideoTrack to true.If you call pushVideoFrame , and specify customVideoTrackId as the videoTrackId set in step 2, you can publish the corresponding custom video source in multiple channels.
  ///
  /// Returns
  /// If the method call is successful, the video track ID is returned as the unique identifier of the video track.If the method call fails, a negative value is returned.
  Future<int> createCustomVideoTrack();

  /// @nodoc
  Future<int> createCustomEncodedVideoTrack(SenderOptions senderOption);

  /// Destroys the specified video track.
  ///
  /// * [videoTrackId] The video track ID returned by calling the createCustomVideoTrack method.
  Future<void> destroyCustomVideoTrack(int videoTrackId);

  /// @nodoc
  Future<void> destroyCustomEncodedVideoTrack(int videoTrackId);

  /// Switches between front and rear cameras.
  /// This method needs to be called after the camera is started (for example, by calling startPreview or joinChannel [2/2] ).This method is for Android and iOS only.
  Future<void> switchCamera();

  /// Checks whether the device supports camera zoom.
  /// Call this method after enabling the local camera, for example, by calling joinChannel [2/2] , enableVideo , or enableLocalVideo ,depending on which method you use to turn on your local camera.
  ///  This method is for Android and iOS only.
  ///
  /// Returns
  /// true: The device supports camera zoom.false: The device does not support camera zoom.
  Future<bool> isCameraZoomSupported();

  /// Checks whether the device camera supports face detection.
  /// Call this method after enabling the local camera, for example, by calling joinChannel [2/2] , enableVideo , or enableLocalVideo ,depending on which method you use to turn on your local camera.This method is for Android and iOS only.
  ///
  /// Returns
  /// true: The device camera supports face detection.false: The device camera does not support face detection.
  Future<bool> isCameraFaceDetectSupported();

  /// Checks whether the device supports camera flash.
  /// Call this method after enabling the local camera, for example, by calling joinChannel [2/2] , enableVideo , or enableLocalVideo ,depending on which method you use to turn on your local camera.This method is for Android and iOS only.The app enables the front camera by default. If your front camera does not support enabling the flash, this method returns false. If you want to check whether the rear camera supports the flash function, call switchCamera before this method.On iPads with system version 15, even if isCameraTorchSupported returns true, you might fail to successfully enable the flash by calling setCameraTorchOn due to system issues.
  ///
  /// Returns
  /// true: The device supports enabling the flash.false: The device does not support enabling the flash.
  Future<bool> isCameraTorchSupported();

  /// Check whether the device supports the manual focus function.
  /// Call this method after enabling the local camera, for example, by calling joinChannel [2/2] , enableVideo , or enableLocalVideo ,depending on which method you use to turn on your local camera.
  ///  This method is for Android and iOS only.
  ///
  /// Returns
  /// true: The device supports the manual focus function.false: The device does not support the manual focus function.
  Future<bool> isCameraFocusSupported();

  /// Checks whether the device supports the face auto-focus function.
  /// This method is for Android and iOS only.Call this method after enabling the local camera, for example, by calling joinChannel [2/2] , enableVideo , or enableLocalVideo ,depending on which method you use to turn on your local camera.
  ///
  /// Returns
  /// true: The device supports the face auto-focus function.false: The device does not support the face auto-focus function.
  Future<bool> isCameraAutoFocusFaceModeSupported();

  /// Sets the camera zoom ratio.
  /// This method is for Android and iOS only.Call this method before calling joinChannel [2/2] , enableVideo , or enableLocalVideo , depending on which method you use to turn on your local camera.
  ///
  /// * [factor] The camera zoom ratio. The value ranges between 1.0 and the maximum zoom supported by the device. You can get the maximum zoom ratio supported by the device by calling the getCameraMaxZoomFactor method.
  Future<void> setCameraZoomFactor(double factor);

  /// Enables/Disables face detection for the local user.
  /// You can call this method either before or after joining a channel.This method is for Android and iOS only.Once face detection is enabled, the SDK triggers the onFacePositionChanged callback to report the face information of the local user, which includes the following:The width and height of the local video.The position of the human face in the local view.The distance between the human face and the screen.This method needs to be called after the camera is started (for example, by calling startPreviewjoinChannel [2/2]).
  ///
  /// * [enabled] Whether to enable face detection for the local user:true: Enable face detection.false: (Default) Disable face detection.
  Future<void> enableFaceDetection(bool enabled);

  /// Gets the maximum zoom ratio supported by the camera.
  /// This method is for Android and iOS only.Call this method after enabling the local camera, for example, by calling joinChannel [2/2] , enableVideo , or enableLocalVideo , depending on which method you use to turn on your local camera.
  ///
  /// Returns
  /// The maximum zoom factor.
  Future<double> getCameraMaxZoomFactor();

  /// Sets the camera manual focus position.
  /// This method needs to be called after the camera is started (for example, by calling startPreview or joinChannel [2/2] ). After a successful method call, the SDK triggers the onCameraFocusAreaChanged callback.This method is for Android and iOS only.
  ///
  /// * [positionX] The horizontal coordinate of the touchpoint in the view.
  /// * [positionY] The vertical coordinate of the touchpoint in the view.
  Future<void> setCameraFocusPositionInPreview(
      {required double positionX, required double positionY});

  /// Enables the camera flash.
  /// This method is for Android and iOS only.Call this method before calling joinChannel [2/2] , enableVideo , or enableLocalVideo , depending on which method you use to turn on your local camera.
  ///
  /// * [isOn] Whether to turn on the camera flash:true: Turn on the flash.false: (Default) Turn off the flash.
  Future<void> setCameraTorchOn(bool isOn);

  /// Sets whether to enable face autofocus.
  /// By default, the SDK disables face autofocus on Android and enables face autofocus on iOS. To set face autofocus, call this method.This method is for Android and iOS only.Call this method after the camera is started, such as after joinChannel [2/2] , enableVideo , or enableLocalVideo .
  ///
  /// * [enabled] Whether to enable face autofocus:true: Enable face autofocus.false: Disable face autofocus.
  Future<void> setCameraAutoFocusFaceModeEnabled(bool enabled);

  /// Checks whether the device supports manual exposure.
  /// Call this method after enabling the local camera, for example, by calling joinChannel [2/2] , enableVideo , or enableLocalVideo ,depending on which method you use to turn on your local camera.This method is for Android and iOS only.
  ///
  /// Returns
  /// true: The device supports manual exposure.false: The device does not support manual exposure.
  Future<bool> isCameraExposurePositionSupported();

  /// Sets the camera exposure position.
  /// This method needs to be called after the camera is started (for example, by calling startPreview or joinChannel [2/2] ).After a successful method call, the SDK triggers the onCameraExposureAreaChanged callback.This method is for Android and iOS only.
  ///
  /// * [positionXinView] The horizontal coordinate of the touchpoint in the view.
  /// * [positionYinView] The vertical coordinate of the touchpoint in the view.
  Future<void> setCameraExposurePosition(
      {required double positionXinView, required double positionYinView});

  /// Checks whether the device supports auto exposure.
  /// Call this method after enabling the local camera, for example, by calling joinChannel [2/2] , enableVideo , or enableLocalVideo ,depending on which method you use to turn on your local camera.This method applies to iOS only.
  ///
  /// Returns
  /// true: The device supports auto exposure.false: The device does not support auto exposure.
  Future<bool> isCameraAutoExposureFaceModeSupported();

  /// Sets whether to enable auto exposure.
  /// This method applies to iOS only.Call this method before calling joinChannel [2/2] , enableVideo , or enableLocalVideo , depending on which method you use to turn on your local camera.
  ///
  /// * [enabled] Whether to enable auto exposure:
  ///  true: Enable auto exposure.false: Disable auto exposure.
  Future<void> setCameraAutoExposureFaceModeEnabled(bool enabled);

  /// Sets the default audio playback route.
  /// This method applies to Android and iOS only.Ensure that you call this method before joining a channel. If you need to change the audio route after joining a channel, call setEnableSpeakerphone .Most mobile phones have two audio routes: an earpiece at the top, and a speakerphone at the bottom. The earpiece plays at a lower volume, and the speakerphone at a higher volume. When setting the default audio route, you determine whether audio playback comes through the earpiece or speakerphone when no external audio device is connected.
  ///
  /// * [defaultToSpeaker] Whether to set the speakerphone as the default audio route:true: Set the speakerphone as the default audio route.false: Set the earpiece as the default audio route.
  Future<void> setDefaultAudioRouteToSpeakerphone(bool defaultToSpeaker);

  /// Enables/Disables the audio route to the speakerphone.
  /// This method is for Android and iOS only.After a successful method call, the SDK triggers the onAudioRoutingChanged callback.You can call this method before joining a channel, when in a channel, or after leaving a channel. However, Agora recommends calling this method only when you are in a channel to change the audio route temporarily.If you do not have a clear requirement for transient settings, Agora recommends calling setDefaultAudioRouteToSpeakerphone to set the audio route.Any user behavior or audio-related API call might change the transient setting of setEnableSpeakerphone.
  ///
  /// * [speakerOn] Whether to set the speakerphone as the default audio route:true: Set the speakerphone as the audio route temporarily.false: Do not set the speakerphone as the audio route.
  Future<void> setEnableSpeakerphone(bool speakerOn);

  /// Checks whether the speakerphone is enabled.
  /// This method is for Android and iOS only.You can call this method either before or after joining a channel.
  ///
  /// Returns
  /// true: The speakerphone is enabled, and the audio plays from the speakerphone.false: The speakerphone is not enabled, and the audio plays from devices other than the speakerphone. For example, the headset or earpiece.
  Future<bool> isSpeakerphoneEnabled();

  /// Gets a list of shareable screens and windows.
  /// You can call this method before sharing a screen or window to get a list of shareable screens and windows, which enables a user to use thumbnails in the list to choose a particular screen or window to share. This list also contains important information such as window ID and screen ID, with which you can call startScreenCaptureByWindowId or startScreenCaptureByDisplayId to start the sharing.
  ///
  /// * [thumbSize] The target size of the screen or window thumbnail (the width and height are in pixels). The SDK scales the original image to make the length of the longest side of the image the same as that of the target size without distorting the original image. For example, if the original image is 400 × 300 and thumbSize is 100 × 100, the actual size of the thumbnail is 100 × 75. If the target size is larger than the original size, the thumbnail is the original image and the SDK does not scale it.
  /// * [iconSize] The target size of the icon corresponding to the application program (the width and height are in pixels). The SDK scales the original image to make the length of the longest side of the image the same as that of the target size without distorting the original image. For example, if the original image is 400 × 300 and iconSize is 100 × 100, the actual size of the icon is 100 × 75. If the target size is larger than the original size, the icon is the original image and the SDK does not scale it.
  /// * [includeScreen] Whether the SDK returns the screen information in addition to the window information:true: The SDK returns screen and window information.false: The SDK returns the window information only.
  Future<List<ScreenCaptureSourceInfo>> getScreenCaptureSources(
      {required SIZE thumbSize,
      required SIZE iconSize,
      required bool includeScreen});

  /// @nodoc
  Future<void> setAudioSessionOperationRestriction(
      AudioSessionOperationRestriction restriction);

  /// Shares the screen by specifying the display ID.
  /// This method shares a screen or part of the screen.There are two ways to start screen sharing, you can choose one according to the actual needs:Call this method before joining a channel, and then call joinChannel [2/2] to join a channel and set publishScreenTrack or publishSecondaryScreenTrack to true to start screen sharing.Call this method after joining a channel, and then call updateChannelMediaOptions and set publishScreenTrack or publishSecondaryScreenTrack to true to start screen sharing.This method is for Windows and macOS only.
  ///
  /// * [displayId] The display ID of the screen to be shared.
  /// * [regionRect] (Optional) Sets the relative location of the region to the screen. If you do not set this parameter, the SDK shares the whole screen. See Rectangle . If the specified region overruns the screen, the SDK shares only the region within it; if you set width or height as 0, the SDK shares the whole screen.
  /// * [captureParams] Screen sharing configurations. The default video dimension is 1920 x 1080, that is, 2,073,600 pixels. Agora uses the value of this parameter to calculate the charges. See ScreenCaptureParameters .
  Future<void> startScreenCaptureByDisplayId(
      {required int displayId,
      required Rectangle regionRect,
      required ScreenCaptureParameters captureParams});

  /// Shares the whole or part of a screen by specifying the screen rect.
  /// There are two ways to start screen sharing, you can choose one according to the actual needs:
  ///  Call this method before joining a channel, and then call joinChannel [2/2] to join a channel and set publishScreenTrack or publishSecondaryScreenTrack to true to start screen sharing.
  ///  Call this method after joining a channel, and then call updateChannelMediaOptions and set publishScreenTrack or publishSecondaryScreenTrack to true to start screen sharing. Deprecated:This method is deprecated. Use startScreenCaptureByDisplayId instead. Agora strongly recommends using startScreenCaptureByDisplayId if you need to start screen sharing on a device connected to another display.This method shares a screen or part of the screen. You need to specify the area of the screen to be shared.This method applies to Windows only.
  ///
  /// * [screenRect] Sets the relative location of the screen to the virtual screen.
  /// * [regionRect]  Rectangle . If the specified region overruns the screen, the SDK shares only the region within it; if you set width or height as 0, the SDK shares the whole screen.
  /// * [captureParams] The screen sharing encoding parameters. The default video dimension is 1920 x 1080, that is, 2,073,600 pixels. Agora uses the value of this parameter to calculate the charges. See ScreenCaptureParameters .
  Future<void> startScreenCaptureByScreenRect(
      {required Rectangle screenRect,
      required Rectangle regionRect,
      required ScreenCaptureParameters captureParams});

  /// Gets the audio device information.
  /// After calling this method, you can get whether the audio device supports ultra-low-latency capture and playback.This method is for Android only.You can call this method either before or after joining a channel.
  ///
  /// Returns
  /// The DeviceInfo object that identifies the audio device information.Not null: Success.Null: Failure.
  Future<DeviceInfo> getAudioDeviceInfo();

  /// Shares the whole or part of a window by specifying the window ID.
  /// There are two ways to start screen sharing, you can choose one according to the actual needs:
  ///  Call this method before joining a channel, and then call joinChannel [2/2] to join a channel and set publishScreenTrack or publishSecondaryScreenTrack to true to start screen sharing.
  ///  Call this method after joining a channel, and then call updateChannelMediaOptions and set publishScreenTrack or publishSecondaryScreenTrack to true to start screen sharing. This method shares a window or part of the window. You need to specify the ID of the window to be shared.Applies to the macOS and Windows platforms only.The window sharing feature of the Agora SDK relies on WGC (Windows Graphics Capture) or GDI (Graphics Device Interface) capture, and WGC cannot be set to disable mouse capture on systems earlier than Windows 10 2004. Therefore, captureMouseCursor(false) might not work when you start window sharing on a device with a system earlier than Windows 10 2004. See ScreenCaptureParameters .This method supports window sharing of UWP (Universal Windows Platform) applications. Agora tests the mainstream UWP applications by using the lastest SDK, see details as follows:
  ///
  /// * [windowId] The ID of the window to be shared.
  /// * [regionRect] (Optional) Sets the relative location of the region to the screen. If you do not set this parameter, the SDK shares the whole screen. See Rectangle . If the specified region overruns the window, the SDK shares only the region within it; if you set width or height as 0, the SDK shares the whole window.
  /// * [captureParams] Screen sharing configurations. The default video dimension is 1920 x 1080, that is, 2,073,600 pixels. Agora uses the value of this parameter to calculate the charges. See ScreenCaptureParameters .
  Future<void> startScreenCaptureByWindowId(
      {required int windowId,
      required Rectangle regionRect,
      required ScreenCaptureParameters captureParams});

  /// Sets the content hint for screen sharing.
  /// A content hint suggests the type of the content being shared, so that the SDK applies different optimization algorithms to different types of content. If you don't call this method, the default content hint is contentHintNone.You can call this method either before or after you start screen sharing.
  ///
  /// * [contentHint] The content hint for screen sharing. See VideoContentHint .
  Future<void> setScreenCaptureContentHint(VideoContentHint contentHint);

  /// Sets the screen sharing scenario.
  /// When you start screen sharing or window sharing, you can call this method to set the screen sharing scenario. The SDK adjusts the video quality and experience of the sharing according to the scenario.This method applies to macOS and Windows only.
  ///
  /// * [screenScenario] The screen sharing scenario. See ScreenScenarioType .
  Future<void> setScreenCaptureScenario(ScreenScenarioType screenScenario);

  /// Updates the screen sharing region.
  /// Call this method after starting screen sharing or window sharing.
  ///
  /// * [regionRect] The relative location of the screen-share area to the screen or window. If you do not set this parameter, the SDK shares the whole screen or window. See Rectangle . If the specified region overruns the screen or window, the SDK shares only the region within it; if you set width or height as 0, the SDK shares the whole screen or window.
  Future<void> updateScreenCaptureRegion(Rectangle regionRect);

  /// Updates the screen sharing parameters.
  /// This method is for Windows and macOS only.Call this method after starting screen sharing or window sharing.
  ///
  /// * [captureParams] The screen sharing encoding parameters. The default video dimension is 1920 x 1080, that is, 2,073,600 pixels. Agora uses the value of this parameter to calculate the charges. See ScreenCaptureParameters
  Future<void> updateScreenCaptureParameters(
      ScreenCaptureParameters captureParams);

  /// Starts screen sharing.
  /// There are two ways to start screen sharing, you can choose one according to your needs:Call this method before joining a channel, then call joinChannel [2/2] to join channel and set publishScreenCaptureVideo to true to start screen sharing.Call this method after joining a channel, then call updateChannelMediaOptions and set publishScreenCaptureVideo to true to start screen sharing.This method applies to Android and iOS only.On the iOS platform, screen sharing is only available on iOS 12.0 and later.The billing for the screen sharing stream is based on the dimensions in ScreenVideoParameters. When you do not pass in a value, Agora bills you at 1280 × 720; when you pass a value in, Agora bills you at that value. If you are using the custom audio source instead of the SDK to capture audio, Agora recommends you add the keep-alive processing logic to your application to avoid screen sharing stopping when the application goes to the background.This feature requires high-performance device, and Agora recommends that you use it on iPhone X and later models.This method relies on the iOS screen sharing dynamic library AgoraReplayKitExtension.xcframework. If the dynamic library is deleted, screen sharing cannot be enabled normally.On the Android platform, make sure the user has granted the app screen capture permission.On Android 9 and later, to avoid the application being killed by the system after going to the background, Agora recommends you add the foreground service permission android.permission.FOREGROUND_SERVICE to the /app/Manifests/AndroidManifest.xml file.Due to performance limitations, screen sharing is not supported on Android TV.Due to system limitations, if you are using Huawei phones, do not adjust the video encoding resolution of the screen sharing stream during the screen sharing, or you could experience crashes.Due to system limitations, some Xiaomi devices do not support capturing system audio during screen sharing.To avoid system audio capture failure when screen sharing, Agora recommends that you set the audio application scenario to audioScenarioGameStreaming by using the setAudioScenario method before joining the channel.
  ///
  /// * [captureParams] The screen sharing encoding parameters. The default video dimension is 1920 x 1080, that is, 2,073,600 pixels. Agora uses the value of this parameter to calculate the charges. See ScreenCaptureParameters2 .
  Future<void> startScreenCapture(ScreenCaptureParameters2 captureParams);

  /// Updates the screen sharing parameters.
  /// If the system audio is not captured when screen sharing is enabled, and then you want to update the parameter configuration and publish the system audio, you can refer to the following steps:Call this method, and set captureAudio to true.Call updateChannelMediaOptions , and set publishScreenCaptureAudio to true to publish the audio captured by the screen.This method applies to Android and iOS only.On the iOS platform, screen sharing is only available on iOS 12.0 and later.
  ///
  /// * [captureParams] The screen sharing encoding parameters. The default video resolution is 1920 × 1080, that is, 2,073,600 pixels. Agora uses the value of this parameter to calculate the charges. See ScreenCaptureParameters2 .
  Future<void> updateScreenCapture(ScreenCaptureParameters2 captureParams);

  /// Stops screen sharing.
  Future<void> stopScreenCapture();

  /// Retrieves the call ID.
  /// When a user joins a channel on a client, a callId is generated to identify the call from the client. Some methods, such as rate and complain , must be called after the call ends to submit feedback to the SDK. These methods require the callId parameter.Call this method after joining a channel.
  ///
  /// Returns
  /// The current call ID.
  Future<String> getCallId();

  /// Allows a user to rate a call after the call ends.
  /// Ensure that you call this method after leaving a channel.
  ///
  /// * [callId] The current call ID. You can get the call ID by calling getCallId .
  /// * [rating] The rating of the call. The value is between 1 (lowest score) and 5 (highest score). If you set a value out of this range, the SDK returns the -2 (ERR_INVALID_ARGUMENT) error.
  /// * [description] A description of the call. The string length should be less than 800 bytes.
  Future<void> rate(
      {required String callId,
      required int rating,
      required String description});

  /// Allows a user to complain about the call quality after a call ends.
  /// This method allows users to complain about the quality of the call. Call this method after the user leaves the channel.
  ///
  /// * [callId] The current call ID. You can get the call ID by calling getCallId .
  /// * [description] A description of the call. The string length should be less than 800 bytes.
  Future<void> complain({required String callId, required String description});

  /// Starts Media Push without transcoding.
  /// Ensure that you enable the media push service before using this function.Call this method after joining a channel.Only hosts in the LIVE_BROADCASTING profile can call this method.If you want to retry pushing streams after a failed push, make sure to call stopRtmpStream first, then call this method to retry pushing streams; otherwise, the SDK returns the same error code as the last failed push.You can call this method to push an audio or video stream to the specified CDN address. This method can push media streams to only one CDN address at a time, so if you need to push streams to multiple addresses, call this method multiple times.After you call this method, the SDK triggers the onRtmpStreamingStateChanged callback on the local client to report the state of the Media Push.
  ///
  /// * [url] The address of media push. The format is RTMP or RTMPS. The character length cannot exceed 1024 bytes. Special characters such as Chinese characters are not supported.
  Future<void> startRtmpStreamWithoutTranscoding(String url);

  /// Starts Media Push and sets the transcoding configuration.
  /// You can call this method to push an audio or video stream to the specified CDN address and set the transcoding configuration. This method can push media streams to only one CDN address at a time, so if you need to push streams to multiple addresses, call this method multiple times.After you call this method, the SDK triggers the onRtmpStreamingStateChanged callback on the local client to report the state of the Media Push.Ensure that you enable the media push service before using this function.Call this method after joining a channel.Only hosts in the LIVE_BROADCASTING profile can call this method.If you want to retry pushing streams after a failed push, make sure to call stopRtmpStream first, then call this method to retry pushing streams; otherwise, the SDK returns the same error code as the last failed push.
  ///
  /// * [url] The address of media push. The format is RTMP or RTMPS. The character length cannot exceed 1024 bytes. Special characters such as Chinese characters are not supported.
  /// * [transcoding] The transcoding configuration for media push. See LiveTranscoding .
  Future<void> startRtmpStreamWithTranscoding(
      {required String url, required LiveTranscoding transcoding});

  /// Updates the transcoding configuration.
  /// After you start pushing media streams to CDN with transcoding, you can dynamically update the transcoding configuration according to the scenario. The SDK triggers the onTranscodingUpdated callback after the transcoding configuration is updated.
  ///
  /// * [transcoding] The transcoding configuration for media push. See LiveTranscoding .
  ///
  Future<void> updateRtmpTranscoding(LiveTranscoding transcoding);

  /// Stops pushing media streams to a CDN.
  /// You can call this method to stop the live stream on the specified CDN address. This method can stop pushing media streams to only one CDN address at a time, so if you need to stop pushing streams to multiple addresses, call this method multiple times.After you call this method, the SDK triggers the onRtmpStreamingStateChanged callback on the local client to report the state of the streaming.
  ///
  /// * [url] The address of media push. The format is RTMP or RTMPS. The character length cannot exceed 1024 bytes. Special characters such as Chinese characters are not supported.
  Future<void> stopRtmpStream(String url);

  /// Starts the local video mixing.
  /// After calling this method, you can merge multiple video streams into one video stream locally. Common scenarios include the following:In a live streaming scenario with cohosts or when using the Media Push function, you can locally mix the videos of multiple hosts into one.In scenarios where you capture multiple local video streams (for example, video captured by cameras, screen sharing streams, video files, or pictures), you can merge them into one video stream and then publish the mixed video stream after joining the channel.
  ///
  /// * [config] Configuration of the local video mixing. See LocalTranscoderConfiguration .
  Future<void> startLocalVideoTranscoder(LocalTranscoderConfiguration config);

  /// Update the local video mixing configuration.
  /// After calling startLocalVideoTranscoder , call this method if you want to update the local video mixing configuration.
  ///
  /// * [config] Configuration of the local video mixing, see LocalTranscoderConfiguration .
  Future<void> updateLocalTranscoderConfiguration(
      LocalTranscoderConfiguration config);

  /// Stops the local video mixing.
  /// After calling startLocalVideoTranscoder , call this method if you want to stop the local video mixing.
  Future<void> stopLocalVideoTranscoder();

  /// Starts video capture with a primary camera.
  ///
  /// * [config] The configuration of the video capture with a primary camera. See CameraCapturerConfiguration .
  Future<void> startPrimaryCameraCapture(CameraCapturerConfiguration config);

  /// Starts video capture with a secondary camera.
  ///
  /// * [config] The configuration of the video capture with a primary camera. See CameraCapturerConfiguration .
  Future<void> startSecondaryCameraCapture(CameraCapturerConfiguration config);

  /// Stops capturing video through a primary camera.
  /// You can call this method to stop capturing video through the primary camera after calling the startPrimaryCameraCapture .
  Future<void> stopPrimaryCameraCapture();

  ///  Stops capturing video through the second camera.
  /// startSecondaryCameraCapture You can call this method to stop capturing video through the second camera after calling the .On the iOS platform, if you want to disable multi-camera capture, you need to call enableMultiCamera after calling this method and set enabled to false.
  Future<void> stopSecondaryCameraCapture();

  /// Sets the rotation angle of the captured video.
  /// When the video capture device does not have the gravity sensing function, you can call this method to manually adjust the rotation angle of the captured video.
  ///
  /// * [type] The video source type. See VideoSourceType .
  /// * [orientation] The clockwise rotation angle. See VideoOrientation .
  ///
  Future<void> setCameraDeviceOrientation(
      {required VideoSourceType type, required VideoOrientation orientation});

  /// @nodoc
  Future<void> setScreenCaptureOrientation(
      {required VideoSourceType type, required VideoOrientation orientation});

  /// Starts sharing the primary screen.
  ///
  /// * [config] The configuration of the captured screen. See ScreenCaptureConfiguration .
  Future<void> startPrimaryScreenCapture(ScreenCaptureConfiguration config);

  /// Starts sharing a secondary screen.
  ///
  /// * [config] The configuration of the captured screen. See ScreenCaptureConfiguration .
  Future<void> startSecondaryScreenCapture(ScreenCaptureConfiguration config);

  /// Stop sharing the first screen.
  /// After calling startPrimaryScreenCapture , you can call this method to stop sharing the first screen.
  Future<void> stopPrimaryScreenCapture();

  /// Stops sharing the secondary screen.
  /// After calling startSecondaryScreenCapture , you can call this method to stop sharing the secondary screen.
  Future<void> stopSecondaryScreenCapture();

  /// Gets the current connection state of the SDK.
  /// You can call this method either before or after joining a channel.
  ///
  /// Returns
  /// The current connection state.
  Future<ConnectionStateType> getConnectionState();

  /// Adds event handlers.
  /// The SDK uses the RtcEngineEventHandler class to send callbacks to the app. The app inherits the methods of this class to receive these callbacks. All methods in this interface class have default (empty) implementations. Therefore, the application can only inherit some required events. In the callbacks, avoid time-consuming tasks or calling APIs that can block the thread, such as the sendStreamMessage method.
  /// Otherwise, the SDK may not work properly.
  ///
  /// * [eventHandler] Callback events to be added.
  void registerEventHandler(RtcEngineEventHandler eventHandler);

  /// Removes the specified IRtcEngineEventHandler instance.
  /// This method removes the specified callback handler. For callback events that you want to listen for only once, call this method to remove the relevant callback handler after you have received them.
  ///
  /// * [eventHandler] The callback handler to be deleted. See RtcEngineEventHandler .
  void unregisterEventHandler(RtcEngineEventHandler eventHandler);

  /// @nodoc
  Future<void> setRemoteUserPriority(
      {required int uid, required PriorityType userPriority});

  /// Sets the built-in encryption mode.
  /// Deprecated:Use enableEncryption instead.The Agora SDK supports built-in encryption, which is set to the AES-128-GCM mode by default. Call this method to use other encryption modes. All users in the same channel must use the same encryption mode and secret. Refer to the information related to the AES encryption algorithm on the differences between the encryption modes.Before calling this method, please call setEncryptionSecret to enable the built-in encryption function.
  ///
  /// * [encryptionMode] The following encryption modes:"aes-128-xts": 128-bit AES encryption, XTS mode."aes-128-ecb": 128-bit AES encryption, ECB mode."aes-256-xts": 256-bit AES encryption, XTS mode."sm4-128-ecb": 128-bit SM4 encryption, ECB mode."aes-128-gcm": 128-bit AES encryption, GCM mode."aes-256-gcm": 256-bit AES encryption, GCM mode."": When this parameter is set as null, the encryption mode is set as "aes-128-gcm" by default.
  Future<void> setEncryptionMode(String encryptionMode);

  /// Enables built-in encryption with an encryption password before users join a channel.
  /// Deprecated:This method is deprecated. Use enableEncryption instead.Before joining the channel, you need to call this method to set the secret parameter to enable the built-in encryption. All users in the same channel should use the same secret. The secret is automatically cleared once a user leaves the channel. If you do not specify the secret or secret is set as null, the built-in encryption is disabled.Do not use this method for CDN live streaming.For optimal transmission, ensure that the encrypted data size does not exceed the original data size + 16 bytes. 16 bytes is the maximum padding size for AES encryption.
  ///
  /// * [secret] The encryption password.
  Future<void> setEncryptionSecret(String secret);

  /// Enables/Disables the built-in encryption.
  /// In scenarios requiring high security, Agora recommends calling this method to enable the built-in encryption before joining a channel.All users in the same channel must use the same encryption mode and encryption key. After the user leaves the channel, the SDK automatically disables the built-in encryption. To enable the built-in encryption, call this method before the user joins the channel again.If you enable the built-in encryption, you cannot use the Media Push function.
  ///
  /// * [enabled] Whether to enable built-in encryption:true: Enable the built-in encryption.false: Disable the built-in encryption.
  /// * [config] Built-in encryption configurations. See EncryptionConfig .
  Future<void> enableEncryption(
      {required bool enabled, required EncryptionConfig config});

  /// Creates a data stream.
  /// Creates a data stream. Each user can create up to five data streams in a single channel.
  ///
  /// * [config] The configurations for the data stream. See DataStreamConfig .
  ///
  /// Returns
  /// ID of the created data stream, if the method call succeeds.< 0: Failure.
  Future<int> createDataStream(DataStreamConfig config);

  /// Sends data stream messages.
  /// Sends data stream messages to all users in a channel. The SDK has the following restrictions on this method:Up to 30 packets can be sent per second in a channel with each packet having a maximum size of 1 KB.Each client can send up to 6 KB of data per second.Each user can have up to five data streams simultaneously.A successful method call triggers the onStreamMessage callback on the remote client, from which the remote user gets the stream message.
  /// A failed method call triggers the onStreamMessageError callback on the remote client.Ensure that you call createDataStream to create a data channel before calling this method.In live streaming scenarios, this method only applies to hosts.
  ///
  /// * [streamId] The data stream ID. You can get the data stream ID by calling createDataStream.
  /// * [data] The data to be sent.
  /// * [length] The length of the data.
  Future<void> sendStreamMessage(
      {required int streamId, required Uint8List data, required int length});

  /// Adds a watermark image to the local video.
  /// This method adds a PNG watermark image to the local video in the live streaming. Once the watermark image is added, all the audience in the channel (CDN audience included), and the capturing device can see and capture it. Agora supports adding only one watermark image onto the local video, and the newly watermark image replaces the previous one.The watermark coordinates are dependent on the settings in the setVideoEncoderConfiguration method:If the orientation mode of the encoding video ( OrientationMode ) is fixed landscape mode or the adaptive landscape mode, the watermark uses the landscape orientation.If the orientation mode of the encoding video (OrientationMode) is fixed portrait mode or the adaptive portrait mode, the watermark uses the portrait orientation.When setting the watermark position, the region must be less than the dimensions set in the setVideoEncoderConfiguration method; otherwise, the watermark image will be cropped.Ensure that call this method after enableVideo .If you only want to add a watermark to the media push, you can call this method or the setLiveTranscoding method.This method supports adding a watermark image in the PNG file format only. Supported pixel formats of the PNG image are RGBA, RGB, Palette, Gray, and Alpha_gray.If the dimensions of the PNG image differ from your settings in this method, the image will be cropped or zoomed to conform to your settings.If you have enabled the local video preview by calling the startPreview method, you can use the visibleInPreview member to set whether or not the watermark is visible in the preview.If you have enabled the mirror mode for the local video, the watermark on the local video is also mirrored. To avoid mirroring the watermark, Agora recommends that you do not use the mirror and watermark functions for the local video at the same time. You can implement the watermark function in your application layer.
  ///
  /// * [watermarkUrl] The local file path of the watermark image to be added. This method supports adding a watermark image from the local absolute or relative file path.
  /// * [options] The options of the watermark image to be added.
  Future<void> addVideoWatermark(
      {required String watermarkUrl, required WatermarkOptions options});

  /// Removes the watermark image from the video stream.
  Future<void> clearVideoWatermarks();

  /// @nodoc
  Future<void> pauseAudio();

  /// @nodoc
  Future<void> resumeAudio();

  /// Enables interoperability with the Agora Web SDK (applicable only in the live streaming scenarios).
  /// Deprecated:The SDK automatically enables interoperability with the Web SDK, so you no longer need to call this method.This method enables or disables interoperability with the Agora Web SDK. If the channel has Web SDK users, ensure that you call this method, or the video of the Native user will be a black screen for the Web user.This method is only applicable in live streaming scenarios, and interoperability is enabled by default in communication scenarios.
  ///
  /// * [enabled] Whether to enable interoperability with the Agora Web SDK.true: Enable interoperability.false: (Default) Disable interoperability.
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
  ///  live interactive streaming, such as sending shopping links, digital coupons, and online quizzes.Call this method before joinChannel [2/2].
  ///
  /// * [observer] The metadata observer. See MetadataObserver .
  /// * [type] The metadata type. The SDK currently only supports videoMetadata.
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
  /// Once registered, the user account can be used to identify the local user when the user joins the channel. After the registration is successful, the user account can identify the identity of the local user, and the user can use it to join the channel.After the user successfully registers a user account, the SDK triggers the onLocalUserRegistered callback on the local client, reporting the user ID and user account of the local user.This method is optional. To join a channel with a user account, you can choose either of the following ways:Call registerLocalUserAccount to create a user account, and then call joinChannelWithUserAccount to join the channel.Call the joinChannelWithUserAccount method to join the channel.The difference between the two ways is that the time elapsed between calling the registerLocalUserAccount method and joining the channel is shorter than directly calling joinChannelWithUserAccount.Ensure that you set the userAccount parameter; otherwise, this method does not take effect.Ensure that the userAccount is unique in the channel.To ensure smooth communication, use the same parameter type to identify the user. For example, if a user joins the channel with a user ID, then ensure all the other users use the user ID too. The same applies to the user account. If a user joins the channel with the Agora Web SDK, ensure that the ID of the user is set to the same parameter type.
  ///
  /// * [appId] The App ID of your project on Agora Console.
  /// * [userAccount] The user account. This parameter is used to identify the user in the channel for real-time audio and video engagement. You need to set and manage user accounts yourself and ensure that each user account in the same channel is unique. The maximum length of this parameter is 255 bytes. Ensure that you set this parameter and do not set it as NULL. Supported characters are (89 in total):The 26 lowercase English letters: a to z.The 26 uppercase English letters: A to Z.All numeric characters: 0 to 9.Space"!", "#", "$", "%", "&amp;", "(", ")", "+", "-", ":", ";", "&lt;", "= ", ".", "&gt;", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","
  Future<void> registerLocalUserAccount(
      {required String appId, required String userAccount});

  /// Joins a channel with a User Account and Token.
  /// This method allows a user to join the channel with the user account and a token. After the user successfully joins the channel, the SDK triggers the following callbacks:The local client: onLocalUserRegistered , onJoinChannelSuccess and onConnectionStateChanged callbacks.The remote client: onUserJoined and onUserInfoUpdated , if the user joining the channel is in the communication profile or is a host in the live streaming profile.Once a user joins the channel, the user subscribes to the audio and video streams of all the other users in the channel by default, giving rise to usage and billing calculation. To stop subscribing to a specified stream or all remote streams, call the corresponding mute methods.To ensure smooth communication, use the same parameter type to identify the user. For example, if a user joins the channel with a user ID, then ensure all the other users use the user ID too. The same applies to the user account. If a user joins the channel with the Agora Web SDK, ensure that the ID of the user is set to the same parameter type.
  ///
  /// * [userAccount] The user account. This parameter is used to identify the user in the channel for real-time audio and video engagement. You need to set and manage user accounts yourself and ensure that each user account in the same channel is unique. The maximum length of this parameter is 255 bytes. Ensure that you set this parameter and do not set it as NULL. Supported characters are (89 in total):
  ///  The 26 lowercase English letters: a to z.
  ///  The 26 uppercase English letters: A to Z.
  ///  All numeric characters: 0 to 9.
  ///  Space
  ///  "!", "#", "$", "%", "&amp;", "(", ")", "+", "-", ":", ";", "&lt;", "= ", ".", "&gt;", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","
  /// * [token] The token generated on your server for authentication.
  /// * [channelId] The channel name. This parameter signifies the channel in which users engage in real-time audio and video interaction. Under the premise of the same App ID, users who fill in the same channel ID enter the same channel for audio and video interaction. The string length must be less than 64 bytes. Supported characters:All lowercase English letters: a to z.All uppercase English letters: A to Z.All numeric characters: 0 to 9.Space"!", "#", "$", "%", "&amp;", "(", ")", "+", "-", ":", ";", "&lt;", "= ", ".", "&gt;", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","
  /// * [options] The channel media options. See ChannelMediaOptions.
  Future<void> joinChannelWithUserAccount(
      {required String token,
      required String channelId,
      required String userAccount,
      ChannelMediaOptions? options});

  /// Joins the channel with a user account, and configures whether to automatically subscribe to audio or video streams after joining the channel.
  /// To ensure smooth communication, use the same parameter type to identify the user. For example, if a user joins the channel with a user ID, then ensure all the other users use the user ID too. The same applies to the user account. If a user joins the channel with the Agora Web SDK, ensure that the ID of the user is set to the same parameter type.Once a user joins the channel, the user subscribes to the audio and video streams of all the other users in the channel by default, giving rise to usage and billing calculation. To stop subscribing to a specified stream or all remote streams, call the corresponding mute methods.This method allows a user to join the channel with the user account. After the user successfully joins the channel, the SDK triggers the following callbacks:The local client: onLocalUserRegistered , onJoinChannelSuccess and onConnectionStateChanged callbacks.The remote client: The onUserJoined callback if the user is in the COMMUNICATION profile, and the onUserInfoUpdated callback if the user is a host in the LIVE_BROADCASTING profile.
  ///
  /// * [userAccount] The user account. This parameter is used to identify the user in the channel for real-time audio and video engagement. You need to set and manage user accounts yourself and ensure that each user account in the same channel is unique. The maximum length of this parameter is 255 bytes. Ensure that you set this parameter and do not set it as NULL. Supported characters are (89 in total):The 26 lowercase English letters: a to z.The 26 uppercase English letters: A to Z.All numeric characters: 0 to 9.Space"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "= ", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","
  /// * [token] The token generated on your server for authentication.
  /// * [channelId] The channel name. This parameter signifies the channel in which users engage in real-time audio and video interaction. Under the premise of the same App ID, users who fill in the same channel ID enter the same channel for audio and video interaction. The string length must be less than 64 bytes. Supported characters:All lowercase English letters: a to z.All uppercase English letters: A to Z.All numeric characters: 0 to 9.Space"!", "#", "$", "%", "&amp;", "(", ")", "+", "-", ":", ";", "&lt;", "= ", ".", "&gt;", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","
  /// * [options] The channel media options. See ChannelMediaOptions .
  Future<void> joinChannelWithUserAccountEx(
      {required String token,
      required String channelId,
      required String userAccount,
      required ChannelMediaOptions options});

  /// Gets the user information by passing in the User Account.
  /// After a remote user joins the channel, the SDK gets the UID and User Account of the remote user, caches them in a mapping table object, and triggers the onUserInfoUpdated callback on the local client. After receiving the callback, you can call this method to get the user account of the remote user from the UserInfo object by passing in the user ID.
  ///
  /// * [userAccount] The user account.
  ///
  /// Returns
  /// The UserInfo object that identifies the user information.A pointer to the UserInfo instance, if the method call succeeds.If the call fails, returns NULL.
  Future<UserInfo> getUserInfoByUserAccount(String userAccount);

  /// Gets the user information by passing in the user ID.
  /// After a remote user joins the channel, the SDK gets the UID and User Account of the remote user, caches them in a mapping table object, and triggers the onUserInfoUpdated callback on the local client. After receiving the callback, you can call this method to get the user account of the remote user from the UserInfo object by passing in the user ID.
  ///
  /// * [uid] The user ID.
  ///
  /// Returns
  /// The UserInfo object that identifies the user information.A pointer to the UserInfo instance, if the method call succeeds.If the call fails, returns NULL.
  Future<UserInfo> getUserInfoByUid(int uid);

  /// Starts relaying media streams across channels. This method can be used to implement scenarios such as co-host across channels.
  /// After a successful method call, the SDK triggers the onChannelMediaRelayStateChanged and onChannelMediaRelayEvent callbacks, and these callbacks return the state and events of the media stream relay.If the onChannelMediaRelayStateChanged callback returns relayStateRunning (2) and relayOk (0), and the onChannelMediaRelayEvent callback returns relayEventPacketSentToDestChannel (4), it means that the SDK starts relaying media streams between the source channel and the destination channel.If the onChannelMediaRelayStateChanged callback returnsrelayStateFailure (3), an exception occurs during the media stream relay.Call this method after joining the channel.This method takes effect only when you are a host in a live streaming channel.After a successful method call, if you want to call this method again, ensure that you call the stopChannelMediaRelay method to quit the current relay.The relaying media streams across channels function needs to be enabled.We do not support string user accounts in this API.
  ///
  /// * [configuration] The configuration of the media stream relay. See ChannelMediaRelayConfiguration .
  Future<void> startChannelMediaRelay(
      ChannelMediaRelayConfiguration configuration);

  /// Updates the channels for media stream relay.
  /// After the media relay starts, if you want to relay the media stream to more channels, or leave the current relay channel, you can call this method.After a successful method call, the SDK triggers the onChannelMediaRelayEvent callback with the relayEventPacketUpdateDestChannel (7) state code.Call the method after successfully calling the startChannelMediaRelay method and receiving onChannelMediaRelayStateChanged (relayStateRunning, relayOk); otherwise, the method call fails.
  ///
  /// * [configuration] The configuration of the media stream relay.
  Future<void> updateChannelMediaRelay(
      ChannelMediaRelayConfiguration configuration);

  /// Stops the media stream relay. Once the relay stops, the host quits all the destination channels.
  /// After a successful method call, the SDK triggers the onChannelMediaRelayStateChanged callback. If the callback reports relayStateIdle (0) and relayOk (0), the host successfully stops the relay.If the method call fails, the SDK triggers the onChannelMediaRelayStateChanged callback with the relayErrorServerNoResponse (2) or relayErrorServerConnectionLost (8) status code. You can call the leaveChannel method to leave the channel, and the media stream relay automatically stops.
  Future<void> stopChannelMediaRelay();

  /// Pauses the media stream relay to all destination channels.
  /// After the cross-channel media stream relay starts, you can call this method to pause relaying media streams to all destination channels; after the pause, if you want to resume the relay, call resumeAllChannelMediaRelay .After a successful method call, the SDK triggers the onChannelMediaRelayEvent callback to report whether the media stream relay is successfully paused.Call this method after the startChannelMediaRelay method.
  Future<void> pauseAllChannelMediaRelay();

  /// @nodoc
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

  /// Enables the virtual metronome.
  /// In music education, physical education and other scenarios, teachers usually need to use a metronome so that students can practice with the correct beat. The meter is composed of a downbeat and upbeats. The first beat of each measure is called a downbeat, and the rest are called upbeats.In this method, you need to set the file path of the upbeat and downbeat, the number of beats per measure, the beat speed, and whether to send the sound of the metronome to remote users.After successfully calling this method, the SDK triggers the onRhythmPlayerStateChanged callback locally to report the status of the virtual metronome.This method is for Android and iOS only.After enabling the virtual metronome, the SDK plays the specified audio effect file from the beginning, and controls the playback duration of each file according to beatsPerMinute you set in AgoraRhythmPlayerConfig . For example, if you set beatsPerMinute as 60, the SDK plays one beat every second. If the file duration exceeds the beat duration, the SDK only plays the audio within the beat duration.By default, the sound of the virtual metronome is published in the channel. If you do not want the sound to be heard by the remote users, you can set publishRhythmPlayerTrack in ChannelMediaOptions as false.
  ///
  /// * [sound1] The absolute path or URL address (including the filename extensions) of the file for the downbeat. For example, C:\music\audio.mp4. For the audio file formats supported by this method, see What formats of audio files does the Agora RTC SDK support.
  /// * [sound2] The absolute path or URL address (including the filename extensions) of the file for the upbeats. For example, C:\music\audio.mp4. For the audio file formats supported by this method, see What formats of audio files does the Agora RTC SDK support.
  /// * [config] The metronome configuration. See AgoraRhythmPlayerConfig .
  Future<void> startRhythmPlayer(
      {required String sound1,
      required String sound2,
      required AgoraRhythmPlayerConfig config});

  /// Disables the virtual metronome.
  /// After calling startRhythmPlayer , you can call this method to disable the virtual metronome.This method is for Android and iOS only.
  Future<void> stopRhythmPlayer();

  /// Configures the virtual metronome.
  /// This method is for Android and iOS only.
  ///  After enabling the virtual metronome, the SDK plays the specified audio effect file from the beginning, and controls the playback duration of each file according to beatsPerMinute you set in AgoraRhythmPlayerConfig . For example, if you set beatsPerMinute as 60, the SDK plays one beat every second. If the file duration exceeds the beat duration, the SDK only plays the audio within the beat duration.
  ///  By default, the sound of the virtual metronome is published in the channel. If you do not want the sound to be heard by the remote users, you can set publishRhythmPlayerTrack in ChannelMediaOptions as false.
  ///  After calling startRhythmPlayer , you can call this method to reconfigure the virtual metronome.After successfully calling this method, the SDK triggers the onRhythmPlayerStateChanged callback locally to report the status of the virtual metronome.
  ///
  /// * [config] The metronome configuration. See AgoraRhythmPlayerConfig .
  Future<void> configRhythmPlayer(AgoraRhythmPlayerConfig config);

  /// Takes a snapshot of a video stream.
  /// This method takes a snapshot of a video stream from the specified user, generates a JPG image, and saves it to the specified path.The method is asynchronous, and the SDK has not taken the snapshot when the method call returns. After a successful method call, the SDK triggers the onSnapshotTaken callback to report whether the snapshot is successfully taken, as well as the details for that snapshot.Call this method after joining a channel.This method takes a snapshot of the published video stream specified in ChannelMediaOptions .If the user's video has been preprocessed, for example, watermarked or beautified, the resulting snapshot includes the pre-processing effect.
  ///
  /// * [uid] The user ID. Set uid as 0 if you want to take a snapshot of the local user's video.
  /// * [filePath] The local path (including filename extensions) of the snapshot. For example:Windows: C:\Users\<user_name>\AppData\Local\Agora\<process_name>\example.jpgiOS: /App Sandbox/Library/Caches/example.jpgmacOS: ～/Library/Logs/example.jpgAndroid: /storage/emulated/0/Android/data/<package name>/files/example.jpgEnsure that the path you specify exists and is writable.
  Future<void> takeSnapshot({required int uid, required String filePath});

  /// Enables or disables video screenshot and upload.
  /// When video screenshot and upload function is enabled, the SDK takes screenshots and upload videos sent by local users based on the type and frequency of the module you set in ContentInspectConfig . After video screenshot and upload, the Agora server sends the callback notification to your app server in HTTPS requests and sends all screenshots to the third-party cloud storage service.Before calling this method, ensure that you contact to enbale Agora video screenshot and upload service. This method relies on the video content moderation library libagora_ci_extension.dll. If the dynamic library is deleted, the function cannot be enabled normally.
  ///
  /// * [enabled] Whether to enable video screenshot and uploadtrue: Enables video screenshot and upload. false: Disables video screenshot and upload.
  /// * [config] Configuration of video screenshot and upload. See ContentInspectConfig .
  Future<void> enableContentInspect(
      {required bool enabled, required ContentInspectConfig config});

  /// Adjusts the volume of the custom external audio source when it is published in the channel.
  /// Ensure you have called the setExternalAudioSource method to create an external audio track before calling this method.If you want to change the volume of the audio to be published, you need to call this method again.
  ///
  /// * [sourceId] The ID of external audio source. If you want to publish a custom external audio source, set this parameter to the ID of the corresponding custom audio track you want to publish.
  /// * [volume] The volume of the audio source. The value can range from 0 to 100. 0 means mute; 100 means the original volume.
  Future<void> adjustCustomAudioPublishVolume(
      {required int sourceId, required int volume});

  /// @nodoc
  Future<void> adjustCustomAudioPlayoutVolume(
      {required int sourceId, required int volume});

  /// Sets the Agora cloud proxy service.
  /// When users' network access is restricted by a firewall, configure the firewall to allow specific IP addresses and ports provided by Agora; then, call this method to enable the cloud proxy and set the cloud proxy type with the proxyType parameter.After successfully connecting to the cloud proxy, the SDK triggers the onConnectionStateChanged (connectionStateConnecting, connectionChangedSettingProxyServer) callback.To disable the cloud proxy that has been set, call the setCloudProxy (noneProxy).To change the cloud proxy type that has been set, call the setCloudProxy (noneProxy) first, and then call the setCloudProxy to set the proxyType you want.Agora recommends that you call this method before joining the channel or after leaving the channel.When a user is behind a firewall and uses the Force UDP cloud proxy, the services for the Media Push and cohosting across channels are not available.When you use the Force TCP cloud proxy, note that an error would occur when calling the startAudioMixing method to play online music files in the HTTP protocol. The services for the Media Push and cohosting across channels use the cloud proxy with the TCP protocol.
  ///
  /// * [proxyType] The type of the cloud proxy. See CloudProxyType .This parameter is mandatory. The SDK reports an error if you do not pass in a value.
  Future<void> setCloudProxy(CloudProxyType proxyType);

  /// @nodoc
  Future<void> setLocalAccessPoint(LocalAccessPointConfiguration config);

  /// Sets audio advanced options.
  /// If you have advanced audio processing requirements, such as capturing and sending stereo audio, you can call this method to set advanced audio options.This method is for Android and iOS only.Call this method after calling joinChannel [2/2] , enableAudio and enableLocalAudio .
  ///
  /// * [options] The advanced options for audio.  See AdvancedAudioOptions.
  ///
  Future<void> setAdvancedAudioOptions(
      {required AdvancedAudioOptions options, int sourceType = 0});

  /// @nodoc
  Future<void> setAVSyncSource({required String channelId, required int uid});

  /// Sets whether to replace the current video feeds with images when publishing video streams.
  /// Agora recommends that you call this method after joining a channel.When publishing video streams, you can call this method to replace the current video feeds with custom images.Once you enable this function, you can select images to replace the video feeds through the ImageTrackOptions parameter. If you disable this function, the remote users see the video feeds that you publish.
  ///
  /// * [enable] Whether to replace the current video feeds with custom images:true: Replace the current video feeds with custom images.false: (Default) Do not replace the current video feeds with custom images.
  /// * [options] Image configurations. See ImageTrackOptions .
  Future<void> enableVideoImageSource(
      {required bool enable, required ImageTrackOptions options});

  /// @nodoc
  Future<int> getCurrentMonotonicTimeInMs();

  /// @nodoc
  Future<void> enableWirelessAccelerate(bool enabled);

  /// Gets the type of the local network connection.
  /// You can use this method to get the type of network in use at any stage.You can call this method either before or after joining a channel.
  ///
  /// Returns
  /// ≥ 0: The method call is successful, and the local network connection type is returned.0: The SDK disconnects from the network.1: The network type is LAN.2: The network type is Wi-Fi (including hotspots).3: The network type is mobile 2G.4: The network type is mobile 3G.5: The network type is mobile 4G.6: The network type is mobile 5G.< 0: The method call failed with an error code.-1: The network type is unknown.
  Future<int> getNetworkType();

  /// Gets the AudioDeviceManager object to manage audio devices.
  ///
  /// Returns
  /// One AudioDeviceManager object.
  AudioDeviceManager getAudioDeviceManager();

  /// Gets the VideoDeviceManager object to manage video devices.
  ///
  /// Returns
  /// One VideoDeviceManager object.
  VideoDeviceManager getVideoDeviceManager();

  /// Gets MusicContentCenter .
  ///
  /// Returns
  /// One MusicContentCenter object.
  MusicContentCenter getMusicContentCenter();

  /// Gets one MediaEngine object.
  /// Make sure the RtcEngine is initialized before you call this method.
  ///
  /// Returns
  /// One MediaEngine object.
  MediaEngine getMediaEngine();

  /// Gets one MediaRecorder object.
  /// Make sure the RtcEngine is initialized before you call this method.
  ///
  /// Returns
  /// One MediaRecorder object.
  MediaRecorder getMediaRecorder();

  /// Gets one LocalSpatialAudioEngine object.
  /// Make sure the RtcEngine is initialized before you call this method.
  ///
  /// Returns
  /// One LocalSpatialAudioEngine object.
  LocalSpatialAudioEngine getLocalSpatialAudioEngine();

  /// Sends media affiliate information.
  /// If the media attachment information is successfully sent, the receiver will receive the onMetadataReceived callback.
  ///
  /// * [metadata] Media metadata. See Metadata .
  Future<void> sendMetaData(
      {required Metadata metadata, required VideoSourceType sourceType});

  /// Sets the maximum size of media metadata information.
  /// After calling registerMediaMetadataObserver , you can call this method to set the maximum size of media metadata information.
  ///
  /// * [size] Sets the maximum size of media metadata information.
  Future<void> setMaxMetadataSize(int size);

  /// Unregisters the encoded audio frame observer.
  ///
  /// * [observer] The encoded audio observer. See AudioEncodedFrameObserver .
  void unregisterAudioEncodedFrameObserver(AudioEncodedFrameObserver observer);

  /// Provides technical preview functionalities or special customizations by configuring the SDK with JSON options.
  ///
  /// * [parameters] Pointer to the set parameters in a JSON string.
  Future<void> setParameters(String parameters);

  /// Gets the C++ handle of the native SDK.
  /// This method retrieves the C++ handle of the SDK, for example for registering the audio and video frame observer.
  ///
  /// Returns
  /// The native handle of the SDK.
  Future<int> getNativeHandle();
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

/// Video profile.
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

  /// 38: 640 × 360, frame rate 15 fps, bitrate 800 Kbps.This profile applies only to the live streaming channel profile.
  @JsonValue(38)
  videoProfileLandscape360p9,

  /// 39: 640 × 360, frame rate 24 fps, bitrate 800 Kbps.This profile applies only to the live streaming channel profile.
  @JsonValue(39)
  videoProfileLandscape360p10,

  /// 100: 640 × 360, frame rate 24 fps, bitrate 1000 Kbps.This profile applies only to the live streaming channel profile.
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

  /// 1000: 120 × 160, frame rate 15 fps, bitrate 65 Kbps.
  @JsonValue(1000)
  videoProfilePortrait120p,

  /// 1002: 120 × 120, frame rate 15 fps, bitrate 50 Kbps.
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

  /// 1038: 360 × 640, frame rate 15 fps, bitrate 800 Kbps.This profile applies only to the live streaming channel profile.
  @JsonValue(1038)
  videoProfilePortrait360p9,

  /// 1039: 360 × 640, frame rate 24 fps, bitrate 800 Kbps.This profile applies only to the live streaming channel profile.
  @JsonValue(1039)
  videoProfilePortrait360p10,

  /// 1100: 360 × 640, frame rate 24 fps, bitrate 1000 Kbps.This profile applies only to the live streaming channel profile.
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

/// SDK version information.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SDKBuildInfo {
  /// @nodoc
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
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoDeviceInfo {
  /// @nodoc
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
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioDeviceInfo {
  /// @nodoc
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
