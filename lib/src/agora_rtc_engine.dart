import '/src/_serializable.dart';
import '/src/binding_forward_export.dart';
part 'agora_rtc_engine.g.dart';

/// Device type.
@JsonEnum(alwaysCreate: true)
enum MediaDeviceType {
  /// -1: Unknown device type.
  @JsonValue(-1)
  unknownAudioDevice,

  /// 0: Audio playback device.
  @JsonValue(0)
  audioPlayoutDevice,

  /// 1: Audio recording device.
  @JsonValue(1)
  audioRecordingDevice,

  /// 2: Video rendering device (GPU).
  @JsonValue(2)
  videoRenderDevice,

  /// 3: Video capture device.
  @JsonValue(3)
  videoCaptureDevice,

  /// 4: Audio application playback device.
  @JsonValue(4)
  audioApplicationPlayoutDevice,

  /// (macOS only) 5: Virtual audio playback device (virtual sound card).
  @JsonValue(5)
  audioVirtualPlayoutDevice,

  /// (macOS only) 6: Virtual audio recording device (virtual sound card).
  @JsonValue(6)
  audioVirtualRecordingDevice,
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

/// Music file playback state.
@JsonEnum(alwaysCreate: true)
enum AudioMixingStateType {
  /// 710: Music file is playing normally.
  @JsonValue(710)
  audioMixingStatePlaying,

  /// 711: Music file playback is paused.
  @JsonValue(711)
  audioMixingStatePaused,

  /// 713: Music file playback stopped.
  /// This state may be caused by:
  ///  audioMixingReasonAllLoopsCompleted(723)
  ///  audioMixingReasonStoppedByUser(724)
  @JsonValue(713)
  audioMixingStateStopped,

  /// 714: Music file playback error.
  /// This state may be caused by:
  ///  audioMixingReasonCanNotOpen(701)
  ///  audioMixingReasonTooFrequentCall(702)
  ///  audioMixingReasonInterruptedEof(703)
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

/// Reason for music file playback state change. Reported in the onAudioMixingStateChanged callback.
@JsonEnum(alwaysCreate: true)
enum AudioMixingReasonType {
  /// 701: Failed to open the music file. For example, the local file does not exist, the format is not supported, or the online music file URL is inaccessible.
  @JsonValue(701)
  audioMixingReasonCanNotOpen,

  /// 702: Music file is opened too frequently. If you need to call startAudioMixing multiple times, ensure the interval between calls is greater than 500 ms.
  @JsonValue(702)
  audioMixingReasonTooFrequentCall,

  /// 703: Music file playback interrupted.
  @JsonValue(703)
  audioMixingReasonInterruptedEof,

  /// 721: One loop of music file playback completed.
  @JsonValue(721)
  audioMixingReasonOneLoopCompleted,

  /// 723: All loops of music file playback completed.
  @JsonValue(723)
  audioMixingReasonAllLoopsCompleted,

  /// 724: Successfully stopped music file playback by calling stopAudioMixing.
  @JsonValue(724)
  audioMixingReasonStoppedByUser,

  /// @nodoc
  @JsonValue(726)
  audioMixingReasonResumedByUser,

  /// 0: Successfully opened the music file.
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

/// Center frequency of voice equalization bands.
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

/// Audio reverb types.
@JsonEnum(alwaysCreate: true)
enum AudioReverbType {
  /// 0: Original sound intensity, also known as the dry signal. Value range: [-20,10], unit: dB.
  @JsonValue(0)
  audioReverbDryLevel,

  /// 1: Early reflection signal intensity, also known as the wet signal. Value range: [-20,10], unit: dB.
  @JsonValue(1)
  audioReverbWetLevel,

  /// 2: Room size for the desired reverb effect. Generally, the larger the room, the stronger the reverb. Value range: [0,100], unit: dB.
  @JsonValue(2)
  audioReverbRoomSize,

  /// 3: Initial delay length of the wet signal. Value range: [0,200], unit: milliseconds.
  @JsonValue(3)
  audioReverbWetDelay,

  /// 4: Reverb strength duration. Value range: [0,100].
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

/// Options for audio and video stream fallback under poor network conditions.
@JsonEnum(alwaysCreate: true)
enum StreamFallbackOptions {
  /// 0: Do not fallback for audio and video streams, but the quality of the audio and video streams is not guaranteed.
  @JsonValue(0)
  streamFallbackOptionDisabled,

  /// 1: Receive only the low-quality video stream (low resolution and low bitrate).
  @JsonValue(1)
  streamFallbackOptionVideoStreamLow,

  /// 2: When network conditions are poor, try receiving only the low-quality video stream first; if the video cannot be displayed due to poor network, fallback to receiving only the subscribed audio stream.
  @JsonValue(2)
  streamFallbackOptionAudioOnly,

  /// @nodoc
  @JsonValue(3)
  streamFallbackOptionVideoStreamLayer1,

  /// @nodoc
  @JsonValue(4)
  streamFallbackOptionVideoStreamLayer2,

  /// @nodoc
  @JsonValue(5)
  streamFallbackOptionVideoStreamLayer3,

  /// @nodoc
  @JsonValue(6)
  streamFallbackOptionVideoStreamLayer4,

  /// @nodoc
  @JsonValue(7)
  streamFallbackOptionVideoStreamLayer5,

  /// @nodoc
  @JsonValue(8)
  streamFallbackOptionVideoStreamLayer6,
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

/// Statistics of the local video stream.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LocalVideoStats implements AgoraSerializable {
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
      this.hwEncoderAccelerating,
      this.simulcastDimensions});

  /// ID of the local user.
  @JsonKey(name: 'uid')
  final int? uid;

  /// Actual sending bitrate (Kbps) Excludes bitrate of retransmitted video after packet loss.
  @JsonKey(name: 'sentBitrate')
  final int? sentBitrate;

  /// Actual sending frame rate (fps). Excludes frame rate of retransmitted video after packet loss.
  @JsonKey(name: 'sentFrameRate')
  final int? sentFrameRate;

  /// Frame rate of local video capture (fps).
  @JsonKey(name: 'captureFrameRate')
  final int? captureFrameRate;

  /// Width of local video capture (px).
  @JsonKey(name: 'captureFrameWidth')
  final int? captureFrameWidth;

  /// Height of local video capture (px).
  @JsonKey(name: 'captureFrameHeight')
  final int? captureFrameHeight;

  /// Frame rate (fps) of video captured by the camera after adjustment by the SDK's built-in video capture adapter (regulator). The regulator adjusts the camera capture frame rate based on the video encoding configuration.
  @JsonKey(name: 'regulatedCaptureFrameRate')
  final int? regulatedCaptureFrameRate;

  /// Width (px) of video captured by the camera after adjustment by the SDK's built-in video capture adapter (regulator). The regulator adjusts the width and height of the camera capture video based on the video encoding configuration.
  @JsonKey(name: 'regulatedCaptureFrameWidth')
  final int? regulatedCaptureFrameWidth;

  /// Height (px) of video captured by the camera after adjustment by the SDK's built-in video capture adapter (regulator). The regulator adjusts the width and height of the camera capture video based on the video encoding configuration.
  @JsonKey(name: 'regulatedCaptureFrameHeight')
  final int? regulatedCaptureFrameHeight;

  /// Output frame rate of the local video encoder, in fps.
  @JsonKey(name: 'encoderOutputFrameRate')
  final int? encoderOutputFrameRate;

  /// Video encoding width (px).
  @JsonKey(name: 'encodedFrameWidth')
  final int? encodedFrameWidth;

  /// Video encoding height (px).
  @JsonKey(name: 'encodedFrameHeight')
  final int? encodedFrameHeight;

  /// Output frame rate of the local video renderer, in fps.
  @JsonKey(name: 'rendererOutputFrameRate')
  final int? rendererOutputFrameRate;

  /// Target encoding bitrate (Kbps) of the current encoder. This bitrate is estimated by the SDK based on the current network conditions.
  @JsonKey(name: 'targetBitrate')
  final int? targetBitrate;

  /// Target encoding frame rate (fps) of the current encoder.
  @JsonKey(name: 'targetFrameRate')
  final int? targetFrameRate;

  /// Adaptation status of local video quality (based on target frame rate and target bitrate) during the statistical cycle. See QualityAdaptIndication.
  @JsonKey(name: 'qualityAdaptIndication')
  final QualityAdaptIndication? qualityAdaptIndication;

  /// Video encoding bitrate (Kbps). Excludes bitrate of retransmitted video after packet loss.
  @JsonKey(name: 'encodedBitrate')
  final int? encodedBitrate;

  /// Number of video frames sent, cumulative value.
  @JsonKey(name: 'encodedFrameCount')
  final int? encodedFrameCount;

  /// Video codec type. See VideoCodecType.
  @JsonKey(name: 'codecType')
  final VideoCodecType? codecType;

  /// Video packet loss rate (%) from the local end to the Agora edge server before weak network recovery.
  @JsonKey(name: 'txPacketLossRate')
  final int? txPacketLossRate;

  /// Brightness level of locally captured video quality. See CaptureBrightnessLevelType.
  @JsonKey(name: 'captureBrightnessLevel')
  final CaptureBrightnessLevelType? captureBrightnessLevel;

  /// @nodoc
  @JsonKey(name: 'dualStreamEnabled')
  final bool? dualStreamEnabled;

  /// Local video encoding acceleration type.
  ///  0: Uses software encoding, no acceleration.
  ///  1: Uses hardware encoding for acceleration.
  @JsonKey(name: 'hwEncoderAccelerating')
  final int? hwEncoderAccelerating;

  /// @nodoc
  @JsonKey(name: 'simulcastDimensions')
  final List<VideoDimensions>? simulcastDimensions;

  /// @nodoc
  factory LocalVideoStats.fromJson(Map<String, dynamic> json) =>
      _$LocalVideoStatsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LocalVideoStatsToJson(this);
}

/// Audio statistics of the remote user.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RemoteAudioStats implements AgoraSerializable {
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
      this.frozenRateByCustomPlcCount,
      this.plcCount,
      this.totalActiveTime,
      this.publishDuration,
      this.qoeQuality,
      this.qualityChangedReason,
      this.rxAudioBytes,
      this.e2eDelay});

  /// The user ID of the remote user.
  @JsonKey(name: 'uid')
  final int? uid;

  /// The quality of the audio stream sent by the remote user. See QualityType.
  @JsonKey(name: 'quality')
  final int? quality;

  /// Network delay from the audio sender to the receiver (ms).
  @JsonKey(name: 'networkTransportDelay')
  final int? networkTransportDelay;

  /// Network delay from the audio receiver to the jitter buffer (ms). This parameter is not effective when the receiver is an audience member and audienceLatencyLevel in ClientRoleOptions is set to 1.
  @JsonKey(name: 'jitterBufferDelay')
  final int? jitterBufferDelay;

  /// Audio frame loss rate (%) of the remote audio stream during the reporting interval.
  @JsonKey(name: 'audioLossRate')
  final int? audioLossRate;

  /// Number of audio channels.
  @JsonKey(name: 'numChannels')
  final int? numChannels;

  /// Sampling rate of the received remote audio stream during the reporting interval.
  @JsonKey(name: 'receivedSampleRate')
  final int? receivedSampleRate;

  /// Average bitrate (Kbps) of the received remote audio stream during the reporting interval.
  @JsonKey(name: 'receivedBitrate')
  final int? receivedBitrate;

  /// Total duration (ms) of audio freezes experienced by the remote user after joining the channel. An audio freeze is counted when the audio frame loss rate exceeds 4%.
  @JsonKey(name: 'totalFrozenTime')
  final int? totalFrozenTime;

  /// Percentage (%) of the total freeze duration relative to the total valid audio duration. Valid audio duration refers to the time after the remote user joins the channel during which audio is not stopped or disabled.
  @JsonKey(name: 'frozenRate')
  final int? frozenRate;

  /// During the reporting interval, the quality score of the received remote audio stream evaluated by Agora's real-time audio MOS (Mean Opinion Score) method. The return value ranges from [0,500]. Divide the return value by 100 to get the MOS score in the range [0,5], where a higher score indicates better audio quality.
  /// The subjective audio quality corresponding to the Agora real-time audio MOS score is as follows: MOS Score Audio Quality Greater than 4 Excellent audio quality, clear and smooth. 3.5 - 4 Good audio quality, occasional impairments, but still clear. 3 - 3.5 Fair audio quality, occasional stuttering, not very smooth, requires some effort to understand. 2.5 - 3 Poor audio quality, frequent stuttering, requires focus to understand. 2 - 2.5 Very poor audio quality, occasional noise, partial semantic loss, difficult to communicate. Less than 2 Extremely poor audio quality, frequent noise, significant semantic loss, communication impossible.
  @JsonKey(name: 'mosValue')
  final int? mosValue;

  /// @nodoc
  @JsonKey(name: 'frozenRateByCustomPlcCount')
  final int? frozenRateByCustomPlcCount;

  /// @nodoc
  @JsonKey(name: 'plcCount')
  final int? plcCount;

  /// Total valid time (ms) from the start of the audio call to this callback for the remote user.
  /// Valid time excludes the total time the remote user was in a muted state.
  @JsonKey(name: 'totalActiveTime')
  final int? totalActiveTime;

  /// Total publishing duration (ms) of the remote audio stream.
  @JsonKey(name: 'publishDuration')
  final int? publishDuration;

  /// Subjective experience quality of the local user when receiving remote audio.
  @JsonKey(name: 'qoeQuality')
  final int? qoeQuality;

  /// Reason for poor subjective experience quality of the local user when receiving remote audio. See ExperiencePoorReason.
  @JsonKey(name: 'qualityChangedReason')
  final int? qualityChangedReason;

  /// @nodoc
  @JsonKey(name: 'rxAudioBytes')
  final int? rxAudioBytes;

  /// End-to-end audio delay (ms), i.e., the total time from when the remote user captures the audio to when the local user starts playing it.
  @JsonKey(name: 'e2eDelay')
  final int? e2eDelay;

  /// @nodoc
  factory RemoteAudioStats.fromJson(Map<String, dynamic> json) =>
      _$RemoteAudioStatsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RemoteAudioStatsToJson(this);
}

/// Statistics of the remote video stream.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RemoteVideoStats implements AgoraSerializable {
  /// @nodoc
  const RemoteVideoStats(
      {this.uid,
      this.delay,
      this.e2eDelay,
      this.width,
      this.height,
      this.receivedBitrate,
      this.decoderInputFrameRate,
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
      this.mosValue,
      this.rxVideoBytes});

  /// User ID that identifies which user's video stream it is.
  @JsonKey(name: 'uid')
  final int? uid;

  /// Delay (ms). Deprecated: In audio and video scenarios with audio-video sync mechanism, you can refer to the values of networkTransportDelay and jitterBufferDelay in RemoteAudioStats to understand video delay data.
  @JsonKey(name: 'delay')
  final int? delay;

  /// End-to-end video delay (ms), i.e., the total time from video capture by the remote user to video rendering by the local user.
  @JsonKey(name: 'e2eDelay')
  final int? e2eDelay;

  /// Video stream width (pixels).
  @JsonKey(name: 'width')
  final int? width;

  /// Video stream height (pixels).
  @JsonKey(name: 'height')
  final int? height;

  /// Bitrate received (Kbps) since last statistics.
  @JsonKey(name: 'receivedBitrate')
  final int? receivedBitrate;

  /// @nodoc
  @JsonKey(name: 'decoderInputFrameRate')
  final int? decoderInputFrameRate;

  /// Output frame rate of the remote video decoder, in fps.
  @JsonKey(name: 'decoderOutputFrameRate')
  final int? decoderOutputFrameRate;

  /// Output frame rate of the remote video renderer, in fps.
  @JsonKey(name: 'rendererOutputFrameRate')
  final int? rendererOutputFrameRate;

  /// Remote video frame loss rate (%).
  @JsonKey(name: 'frameLossRate')
  final int? frameLossRate;

  /// Packet loss rate (%) of the remote video after applying anti-packet-loss techniques.
  @JsonKey(name: 'packetLossRate')
  final int? packetLossRate;

  /// Video stream type, either high or low. See VideoStreamType.
  @JsonKey(name: 'rxStreamType')
  final VideoStreamType? rxStreamType;

  /// Total duration (ms) of video freezes experienced by the remote user after joining the channel. During a call, if the video frame rate is set to no less than 5 fps and the interval between two consecutive rendered frames exceeds 500 ms, it is counted as a video freeze.
  @JsonKey(name: 'totalFrozenTime')
  final int? totalFrozenTime;

  /// Percentage (%) of the total duration of video freezes experienced by the remote user after joining the channel relative to the total effective video duration. Effective video duration refers to the time after the remote user joins the channel during which the video is neither stopped nor disabled.
  @JsonKey(name: 'frozenRate')
  final int? frozenRate;

  /// Time (ms) that audio leads video. If the value is negative, it means audio lags behind video.
  @JsonKey(name: 'avSyncTimeMs')
  final int? avSyncTimeMs;

  /// Effective video duration (ms).
  /// The total effective video duration is the time during which the remote user or host has joined the channel and neither stopped sending the video stream nor disabled the video module.
  @JsonKey(name: 'totalActiveTime')
  final int? totalActiveTime;

  /// Total published duration (ms) of the remote video stream.
  @JsonKey(name: 'publishDuration')
  final int? publishDuration;

  /// Quality of the remote audio stream during the statistics period. The quality is measured using Agora's real-time audio MOS (Mean Opinion Score) method. The return value ranges from [0, 500]; divide by 100 to get the MOS score, ranging from 0 to 5. The higher the score, the better the audio quality. The subjective audio quality corresponding to the Agora MOS score is:
  ///  Greater than 4: Excellent audio quality, clear and smooth.
  ///  3.5 - 4: Good audio quality, occasional distortion but still clear.
  ///  3 - 3.5: Fair audio quality, occasional stuttering, not very smooth, requires some attention to hear clearly.
  ///  2.5 - 3: Poor audio quality, frequent stuttering, requires concentration to hear clearly.
  ///  2 - 2.5: Very poor audio quality, occasional noise, partial semantic loss, difficult to communicate.
  ///  Less than 2: Extremely poor audio quality, frequent noise, significant semantic loss, communication impossible.
  @JsonKey(name: 'mosValue')
  final int? mosValue;

  /// @nodoc
  @JsonKey(name: 'rxVideoBytes')
  final int? rxVideoBytes;

  /// @nodoc
  factory RemoteVideoStats.fromJson(Map<String, dynamic> json) =>
      _$RemoteVideoStatsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RemoteVideoStatsToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoCompositingLayout implements AgoraSerializable {
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

  @override
  Map<String, dynamic> toJson() => _$VideoCompositingLayoutToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Region implements AgoraSerializable {
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

  @override
  Map<String, dynamic> toJson() => _$RegionToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class InjectStreamConfig implements AgoraSerializable {
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

  @override
  Map<String, dynamic> toJson() => _$InjectStreamConfigToJson(this);
}

/// Lifecycle of server-side transcoding stream.
///
/// Deprecated Deprecated
@JsonEnum(alwaysCreate: true)
enum RtmpStreamLifeCycleType {
  /// Bound to the channel lifecycle. When all hosts leave the channel, the server-side transcoding stream stops after 30 seconds.
  @JsonValue(1)
  rtmpStreamLifeCycleBind2channel,

  /// Bound to the lifecycle of the host who starts the server-side transcoding stream. When the host leaves, the stream stops immediately.
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
class PublisherConfiguration implements AgoraSerializable {
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

  @override
  Map<String, dynamic> toJson() => _$PublisherConfigurationToJson(this);
}

/// Camera direction.
@JsonEnum(alwaysCreate: true)
enum CameraDirection {
  /// 0: Rear camera.
  @JsonValue(0)
  cameraRear,

  /// 1: (Default) Front camera.
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

/// Cloud proxy type.
@JsonEnum(alwaysCreate: true)
enum CloudProxyType {
  /// 0: Automatic mode. This is the default mode enabled by the SDK. In this mode, the SDK first attempts to connect to SD-RTN™. If the connection fails, it automatically switches to TLS 443.
  @JsonValue(0)
  noneProxy,

  /// 1: Cloud proxy using UDP protocol, also known as Force UDP mode. In this mode, the SDK always transmits data via UDP.
  @JsonValue(1)
  udpProxy,

  /// 2: Cloud proxy using TCP (encrypted) protocol, also known as Force TCP mode. In this mode, the SDK always transmits data via TLS 443.
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

/// Camera capture configuration.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CameraCapturerConfiguration implements AgoraSerializable {
  /// @nodoc
  const CameraCapturerConfiguration(
      {this.cameraDirection,
      this.cameraFocalLengthType,
      this.deviceId,
      this.cameraId,
      this.followEncodeDimensionRatio,
      this.format});

  /// (Optional) Camera direction. See CameraDirection. This parameter is only applicable to Android and iOS platforms.
  @JsonKey(name: 'cameraDirection')
  final CameraDirection? cameraDirection;

  /// (Optional) Camera focal length type. See CameraFocalLengthType.
  ///  This parameter is only applicable to Android and iOS.
  ///  To set the camera focal length type, you can only use cameraDirection to specify the camera. cameraId is not supported.
  ///  Some iOS devices have composite rear cameras, such as dual (wide and ultra-wide) or triple (wide, ultra-wide, and telephoto). For such composite lenses with ultra-wide capabilities, you can achieve ultra-wide capture using either of the following methods:
  ///  Method 1: Set this parameter to cameraFocalLengthUltraWide (2) (ultra-wide lens).
  ///  Method 2: Set this parameter to cameraFocalLengthDefault (0) (standard lens), then call setCameraZoomFactor to set the zoom factor to a value less than 1.0, with a minimum of 0.5. The difference is that Method 1 has a fixed ultra-wide view, while Method 2 allows flexible zoom adjustment.
  @JsonKey(name: 'cameraFocalLengthType')
  final CameraFocalLengthType? cameraFocalLengthType;

  /// (Optional) Camera ID. Maximum length is MaxDeviceIdLengthType. This parameter is only applicable to Windows and macOS.
  @JsonKey(name: 'deviceId')
  final String? deviceId;

  /// (Optional) Camera ID. Defaults to the front camera's ID. You can get the camera ID using Android native system APIs. See [Camera.open()](https://developer.android.google.cn/reference/android/hardware/Camera#open(int)) and [CameraManager.getCameraIdList()](https://developer.android.google.cn/reference/android/hardware/camera2/CameraManager?hl=en#getCameraIdList).
  ///  This parameter is only applicable to Android.
  ///  This parameter and cameraDirection are both used to specify the camera and are mutually exclusive. You can choose either one as needed. The differences are:
  ///  Using cameraDirection is simpler. You only need to specify the direction (front or rear), and the SDK will determine the actual camera ID via system APIs.
  ///  Using cameraId allows you to specify a particular camera more precisely. On multi-camera devices, cameraDirection may not detect or access all available cameras. In such cases, it's recommended to use cameraId to directly specify the desired camera ID.
  @JsonKey(name: 'cameraId')
  final String? cameraId;

  /// (Optional) Whether to follow the video aspect ratio set in setVideoEncoderConfiguration : true : (Default) Follow. The SDK crops the captured video to match the configured aspect ratio. This also affects local preview, onCaptureVideoFrame, and onPreEncodeVideoFrame. false : Do not follow. The SDK does not change the aspect ratio of the captured video frames.
  @JsonKey(name: 'followEncodeDimensionRatio')
  final bool? followEncodeDimensionRatio;

  /// (Optional) Video frame format. See VideoFormat.
  @JsonKey(name: 'format')
  final VideoFormat? format;

  /// @nodoc
  factory CameraCapturerConfiguration.fromJson(Map<String, dynamic> json) =>
      _$CameraCapturerConfigurationFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CameraCapturerConfigurationToJson(this);
}

/// Screen capture configuration.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ScreenCaptureConfiguration implements AgoraSerializable {
  /// @nodoc
  const ScreenCaptureConfiguration(
      {this.isCaptureWindow,
      this.displayId,
      this.screenRect,
      this.windowId,
      this.params,
      this.regionRect});

  /// Whether to capture a window on the screen: true : Capture window. false : (Default) Capture screen, not window.
  @JsonKey(name: 'isCaptureWindow')
  final bool? isCaptureWindow;

  /// (macOS only) Display ID of the screen. Use this parameter only when capturing the screen on Mac devices.
  @JsonKey(name: 'displayId')
  final int? displayId;

  /// (Windows only) Position of the screen to be shared relative to the virtual screen. Use this parameter only when capturing the screen on Windows devices.
  @JsonKey(name: 'screenRect')
  final Rectangle? screenRect;

  /// (Windows and macOS only) Window ID. Use this parameter only when capturing a window.
  @JsonKey(name: 'windowId')
  final int? windowId;

  /// (Windows and macOS only) Encoding parameter configuration for screen sharing stream. See ScreenCaptureParameters.
  @JsonKey(name: 'params')
  final ScreenCaptureParameters? params;

  /// (Windows and macOS only) Position of the region to be shared relative to the entire screen. See Rectangle. If not set, the entire screen is shared. If the specified region exceeds screen boundaries, only the content within the screen is shared. If width or height in Rectangle is set to 0, the entire screen is shared.
  @JsonKey(name: 'regionRect')
  final Rectangle? regionRect;

  /// @nodoc
  factory ScreenCaptureConfiguration.fromJson(Map<String, dynamic> json) =>
      _$ScreenCaptureConfigurationFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ScreenCaptureConfigurationToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SIZE implements AgoraSerializable {
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

  @override
  Map<String, dynamic> toJson() => _$SIZEToJson(this);
}

/// Image content of a thumbnail or icon. Set in ScreenCaptureSourceInfo.
///
/// The image is in ARGB format by default. If you need to use a different format, please convert it yourself.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ThumbImageBuffer implements AgoraSerializable {
  /// @nodoc
  const ThumbImageBuffer({this.buffer, this.length, this.width, this.height});

  /// Buffer of the thumbnail or icon.
  @JsonKey(name: 'buffer', ignore: true)
  final Uint8List? buffer;

  /// Length of the thumbnail or icon buffer in bytes.
  @JsonKey(name: 'length')
  final int? length;

  /// Actual width of the thumbnail or icon (px).
  @JsonKey(name: 'width')
  final int? width;

  /// Actual height of the thumbnail or icon (px).
  @JsonKey(name: 'height')
  final int? height;

  /// @nodoc
  factory ThumbImageBuffer.fromJson(Map<String, dynamic> json) =>
      _$ThumbImageBufferFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ThumbImageBufferToJson(this);
}

/// Type of the shared target. Set in ScreenCaptureSourceInfo.
@JsonEnum(alwaysCreate: true)
enum ScreenCaptureSourceType {
  /// -1: Unknown.
  @JsonValue(-1)
  screencapturesourcetypeUnknown,

  /// 0: The shared target is a window.
  @JsonValue(0)
  screencapturesourcetypeWindow,

  /// 1: The shared target is a display screen.
  @JsonValue(1)
  screencapturesourcetypeScreen,

  /// 2: Reserved parameter.
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

/// Information about shareable windows or screens.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ScreenCaptureSourceInfo implements AgoraSerializable {
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
      this.position,
      this.minimizeWindow,
      this.sourceDisplayId});

  /// Type of the sharing target. See ScreenCaptureSourceType.
  @JsonKey(name: 'type')
  final ScreenCaptureSourceType? type;

  /// For windows, represents the Window ID; for screens, represents the Display ID.
  @JsonKey(name: 'sourceId')
  final int? sourceId;

  /// Name of the window or screen. UTF-8 encoded.
  @JsonKey(name: 'sourceName')
  final String? sourceName;

  /// Image content of the thumbnail. See ThumbImageBuffer.
  @JsonKey(name: 'thumbImage')
  final ThumbImageBuffer? thumbImage;

  /// Image content of the icon. See ThumbImageBuffer.
  @JsonKey(name: 'iconImage')
  final ThumbImageBuffer? iconImage;

  /// Process to which the window belongs. UTF-8 encoded.
  @JsonKey(name: 'processPath')
  final String? processPath;

  /// Window title. UTF-8 encoded.
  @JsonKey(name: 'sourceTitle')
  final String? sourceTitle;

  /// Whether the screen is the primary display: true : The screen is the primary display. false : The screen is not the primary display.
  @JsonKey(name: 'primaryMonitor')
  final bool? primaryMonitor;

  /// @nodoc
  @JsonKey(name: 'isOccluded')
  final bool? isOccluded;

  /// Position of the window relative to the entire screen space (including all shareable screens). See Rectangle.
  @JsonKey(name: 'position')
  final Rectangle? position;

  /// (Windows only) Whether the window is minimized: true : The window is minimized. false : The window is not minimized.
  @JsonKey(name: 'minimizeWindow')
  final bool? minimizeWindow;

  /// (Windows only) ID of the screen where the window is located. If the window spans multiple screens, this indicates the screen with the largest intersection area. If the window is outside the visible screen area, the value is -2.
  @JsonKey(name: 'sourceDisplayId')
  final int? sourceDisplayId;

  /// @nodoc
  factory ScreenCaptureSourceInfo.fromJson(Map<String, dynamic> json) =>
      _$ScreenCaptureSourceInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ScreenCaptureSourceInfoToJson(this);
}

/// Advanced options for audio.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AdvancedAudioOptions implements AgoraSerializable {
  /// @nodoc
  const AdvancedAudioOptions({this.audioProcessingChannels});

  /// Number of channels for audio pre-processing. See audioprocessingchannels.
  @JsonKey(name: 'audioProcessingChannels')
  final int? audioProcessingChannels;

  /// @nodoc
  factory AdvancedAudioOptions.fromJson(Map<String, dynamic> json) =>
      _$AdvancedAudioOptionsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AdvancedAudioOptionsToJson(this);
}

/// Settings for placeholder image.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ImageTrackOptions implements AgoraSerializable {
  /// @nodoc
  const ImageTrackOptions({this.imageUrl, this.fps, this.mirrorMode});

  /// URL of the placeholder image. Currently supports JPEG, JPG, PNG, and GIF formats. You can add placeholder images from local absolute or relative paths. On Android, adding placeholder images from /assets/ is not supported.
  @JsonKey(name: 'imageUrl')
  final String? imageUrl;

  /// Video frame rate. Value range is [1,30]. Default value is 1.
  @JsonKey(name: 'fps')
  final int? fps;

  /// @nodoc
  @JsonKey(name: 'mirrorMode')
  final VideoMirrorModeType? mirrorMode;

  /// @nodoc
  factory ImageTrackOptions.fromJson(Map<String, dynamic> json) =>
      _$ImageTrackOptionsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ImageTrackOptionsToJson(this);
}

/// Channel media configuration options.
///
/// RtcConnection publishMicrophoneTrack publishCustomAudioTrack publishMediaPlayerAudioTrack true publishCameraTrack publishScreenCaptureVideo, publishScreenTrack, publishCustomVideoTrack publishEncodedVideoTrack true It is recommended that you configure the member parameters based on your business scenario. Otherwise, the SDK automatically assigns values to them.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ChannelMediaOptions implements AgoraSerializable {
  /// @nodoc
  const ChannelMediaOptions(
      {this.publishCameraTrack,
      this.publishSecondaryCameraTrack,
      this.publishThirdCameraTrack,
      this.publishFourthCameraTrack,
      this.publishMicrophoneTrack,
      this.publishScreenCaptureAudio,
      this.publishScreenCaptureVideo,
      this.publishScreenTrack,
      this.publishSecondaryScreenTrack,
      this.publishThirdScreenTrack,
      this.publishFourthScreenTrack,
      this.publishCustomAudioTrack,
      this.publishCustomAudioTrackId,
      this.publishCustomVideoTrack,
      this.publishEncodedVideoTrack,
      this.publishMediaPlayerAudioTrack,
      this.publishMediaPlayerVideoTrack,
      this.publishTranscodedVideoTrack,
      this.publishMixedAudioTrack,
      this.publishLipSyncTrack,
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
      this.isAudioFilterable,
      this.parameters,
      this.customUserInfo});

  /// Sets whether to publish the video captured by the camera: true : Publish the video captured by the camera. false : Do not publish the video captured by the camera.
  @JsonKey(name: 'publishCameraTrack')
  final bool? publishCameraTrack;

  /// Sets whether to publish the video captured by the second camera: true : Publish the video captured by the second camera. false : Do not publish the video captured by the second camera.
  @JsonKey(name: 'publishSecondaryCameraTrack')
  final bool? publishSecondaryCameraTrack;

  /// This parameter is only applicable to Android, Windows, and macOS platforms. Sets whether to publish the video captured by the third camera: true : Publish the video captured by the third camera. false : Do not publish the video captured by the third camera.
  @JsonKey(name: 'publishThirdCameraTrack')
  final bool? publishThirdCameraTrack;

  /// This parameter is only applicable to Android, Windows, and macOS platforms. Sets whether to publish the video captured by the fourth camera: true : Publish the video captured by the fourth camera. false : Do not publish the video captured by the fourth camera.
  @JsonKey(name: 'publishFourthCameraTrack')
  final bool? publishFourthCameraTrack;

  /// Sets whether to publish the audio captured by the microphone: true : Publish the audio captured by the microphone. false : Do not publish the audio captured by the microphone.
  @JsonKey(name: 'publishMicrophoneTrack')
  final bool? publishMicrophoneTrack;

  /// This parameter is only applicable to Android and iOS platforms. Sets whether to publish the audio captured from the screen: true : Publish the screen-captured audio. false : Do not publish the screen-captured audio.
  @JsonKey(name: 'publishScreenCaptureAudio')
  final bool? publishScreenCaptureAudio;

  /// This parameter is only applicable to Android and iOS platforms. Sets whether to publish the video captured from the screen: true : Publish the screen-captured video. false : Do not publish the screen-captured video.
  @JsonKey(name: 'publishScreenCaptureVideo')
  final bool? publishScreenCaptureVideo;

  /// This parameter is only applicable to Windows and macOS platforms. Sets whether to publish the video captured from the screen: true : Publish the screen-captured video. false : Do not publish the screen-captured video.
  @JsonKey(name: 'publishScreenTrack')
  final bool? publishScreenTrack;

  /// Sets whether to publish the video captured from the second screen: true : Publish the video captured from the second screen. false : Do not publish the video captured from the second screen.
  @JsonKey(name: 'publishSecondaryScreenTrack')
  final bool? publishSecondaryScreenTrack;

  /// This parameter is only applicable to Windows and macOS platforms. Sets whether to publish the video captured from the third screen: true : Publish the video captured from the third screen. false : Do not publish the video captured from the third screen.
  @JsonKey(name: 'publishThirdScreenTrack')
  final bool? publishThirdScreenTrack;

  /// This parameter is only applicable to Windows and macOS platforms. Sets whether to publish the video captured from the fourth screen: true : Publish the video captured from the fourth screen. false : Do not publish the video captured from the fourth screen.
  @JsonKey(name: 'publishFourthScreenTrack')
  final bool? publishFourthScreenTrack;

  /// Sets whether to publish custom captured audio: true : Publish the custom captured audio. false : Do not publish the custom captured audio.
  @JsonKey(name: 'publishCustomAudioTrack')
  final bool? publishCustomAudioTrack;

  /// ID of the custom audio track to be published. Default is 0. You can get the custom audio track ID via the createCustomAudioTrack method.
  @JsonKey(name: 'publishCustomAudioTrackId')
  final int? publishCustomAudioTrackId;

  /// Sets whether to publish custom captured video: true : Publish the custom captured video. false : Do not publish the custom captured video.
  @JsonKey(name: 'publishCustomVideoTrack')
  final bool? publishCustomVideoTrack;

  /// Sets whether to publish the encoded video: true : Publish the encoded video. false : Do not publish the encoded video.
  @JsonKey(name: 'publishEncodedVideoTrack')
  final bool? publishEncodedVideoTrack;

  /// Sets whether to publish the audio from the media player: true : Publish the media player's audio. false : Do not publish the media player's audio.
  @JsonKey(name: 'publishMediaPlayerAudioTrack')
  final bool? publishMediaPlayerAudioTrack;

  /// Sets whether to publish the video from the media player: true : Publish the media player's video. false : Do not publish the media player's video.
  @JsonKey(name: 'publishMediaPlayerVideoTrack')
  final bool? publishMediaPlayerVideoTrack;

  /// Sets whether to publish the local transcoded video: true : Publish the local transcoded video. false : Do not publish the local transcoded video.
  @JsonKey(name: 'publishTranscodedVideoTrack')
  final bool? publishTranscodedVideoTrack;

  /// Sets whether to publish the local audio mixing: true : Publish the local audio mixing. false : Do not publish the local audio mixing.
  @JsonKey(name: 'publishMixedAudioTrack')
  final bool? publishMixedAudioTrack;

  /// Sets whether to publish the video processed by the voice-driven plugin: true : Publish the video processed by the voice-driven plugin. false : (Default) Do not publish the video processed by the voice-driven plugin.
  @JsonKey(name: 'publishLipSyncTrack')
  final bool? publishLipSyncTrack;

  /// Sets whether to automatically subscribe to all audio streams: true : Automatically subscribe to all audio streams. false : Do not automatically subscribe to any audio streams.
  @JsonKey(name: 'autoSubscribeAudio')
  final bool? autoSubscribeAudio;

  /// Sets whether to automatically subscribe to all video streams: true : Automatically subscribe to all video streams. false : Do not automatically subscribe to any video streams.
  @JsonKey(name: 'autoSubscribeVideo')
  final bool? autoSubscribeVideo;

  /// If you need to publish the audio stream captured by the microphone, make sure this parameter is set to true. Sets whether to enable audio recording or playback: true : Enable audio recording or playback. false : Do not enable audio recording or playback.
  @JsonKey(name: 'enableAudioRecordingOrPlayout')
  final bool? enableAudioRecordingOrPlayout;

  /// ID of the media player to be published. Default is 0.
  @JsonKey(name: 'publishMediaPlayerId')
  final int? publishMediaPlayerId;

  /// User role. See ClientRoleType.
  @JsonKey(name: 'clientRoleType')
  final ClientRoleType? clientRoleType;

  /// Audience latency level. See AudienceLatencyLevelType.
  @JsonKey(name: 'audienceLatencyLevel')
  final AudienceLatencyLevelType? audienceLatencyLevel;

  /// Default video stream type to subscribe to: VideoStreamType.
  @JsonKey(name: 'defaultVideoStreamType')
  final VideoStreamType? defaultVideoStreamType;

  /// Channel profile. See ChannelProfileType.
  @JsonKey(name: 'channelProfile')
  final ChannelProfileType? channelProfile;

  /// Delay (in milliseconds) for sending audio frames. You can use this parameter to delay the audio frames to ensure audio-video synchronization.
  /// To disable the delay, set this parameter to 0.
  @JsonKey(name: 'audioDelayMs')
  final int? audioDelayMs;

  /// @nodoc
  @JsonKey(name: 'mediaPlayerAudioDelayMs')
  final int? mediaPlayerAudioDelayMs;

  /// (Optional) A dynamic key generated on the server for authentication. See [Token Authentication](https://doc.shengwang.cn/doc/rtc/flutter/basic-features/token-authentication).
  ///  This parameter only takes effect when calling updateChannelMediaOptions or updateChannelMediaOptionsEx.
  ///  Make sure the App ID, channel name, and user name used to generate the token are consistent with those used in the initialize method and the joinChannel or joinChannelEx methods.
  @JsonKey(name: 'token')
  final String? token;

  /// @nodoc
  @JsonKey(name: 'enableBuiltInMediaEncryption')
  final bool? enableBuiltInMediaEncryption;

  /// Sets whether to publish the virtual metronome sound to remote users: true : Publish. Both local and remote users can hear the metronome. false : Do not publish. Only the local user can hear the metronome.
  @JsonKey(name: 'publishRhythmPlayerTrack')
  final bool? publishRhythmPlayerTrack;

  /// This parameter is used for cross-room co-hosting scenarios. The co-host needs to call joinChannelEx to join the other host's channel as an audience member and set isInteractiveAudience to true.
  ///  This parameter only takes effect when the user role is clientRoleAudience. Whether to enable interactive audience mode: true : Enable interactive audience mode. Once enabled, the local user, as an interactive audience member, receives low-latency and smooth remote video. false : Do not enable interactive audience mode. The local user receives remote video with default settings as a regular audience member.
  @JsonKey(name: 'isInteractiveAudience')
  final bool? isInteractiveAudience;

  /// Video track ID returned by the createCustomVideoTrack method. Default is 0.
  @JsonKey(name: 'customVideoTrackId')
  final int? customVideoTrackId;

  /// To enable this feature, please [contact sales](https://www.shengwang.cn/contact-sales/). Sets whether the current audio stream participates in stream selection based on audio volume algorithm. true : Participate in audio volume-based stream selection. If the feature is not enabled, this parameter has no effect. false : Do not participate in audio volume-based stream selection.
  @JsonKey(name: 'isAudioFilterable')
  final bool? isAudioFilterable;

  /// @nodoc
  @JsonKey(name: 'parameters')
  final String? parameters;

  /// @nodoc
  @JsonKey(name: 'customUserInfo')
  final String? customUserInfo;

  /// @nodoc
  factory ChannelMediaOptions.fromJson(Map<String, dynamic> json) =>
      _$ChannelMediaOptionsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ChannelMediaOptionsToJson(this);
}

/// Proxy type.
@JsonEnum(alwaysCreate: true)
enum ProxyType {
  /// 0: Reserved parameter, not supported yet.
  @JsonValue(0)
  noneProxyType,

  /// 1: Cloud proxy with UDP protocol, i.e., Force UDP cloud proxy mode. In this mode, the SDK always transmits data via UDP protocol.
  @JsonValue(1)
  udpProxyType,

  /// 2: Cloud proxy with TCP (encrypted) protocol, i.e., Force TCP cloud proxy mode. In this mode, the SDK always transmits data via TLS 443.
  @JsonValue(2)
  tcpProxyType,

  /// 3: Reserved parameter, not supported yet.
  @JsonValue(3)
  localProxyType,

  /// 4: Auto mode. In this mode, the SDK first attempts to connect to SD-RTN™. If the connection fails, it automatically switches to TLS 443.
  @JsonValue(4)
  tcpProxyAutoFallbackType,

  /// @nodoc
  @JsonValue(5)
  httpProxyType,

  /// @nodoc
  @JsonValue(6)
  httpsProxyType,
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

/// Advanced feature types.
@JsonEnum(alwaysCreate: true)
enum FeatureType {
  /// 1: Virtual background feature.
  @JsonValue(1)
  videoVirtualBackground,

  /// 2: Beauty effect feature.
  @JsonValue(2)
  videoBeautyEffect,
}

/// @nodoc
extension FeatureTypeExt on FeatureType {
  /// @nodoc
  static FeatureType fromValue(int value) {
    return $enumDecode(_$FeatureTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$FeatureTypeEnumMap[this]!;
  }
}

/// Options for leaving a channel.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LeaveChannelOptions implements AgoraSerializable {
  /// @nodoc
  const LeaveChannelOptions(
      {this.stopAudioMixing,
      this.stopAllEffect,
      this.unloadAllEffect,
      this.stopMicrophoneRecording});

  /// Whether to stop playing music files and audio mixing when leaving the channel: true : (default) Stop playing music files and audio mixing. false : Do not stop playing music files and audio mixing.
  @JsonKey(name: 'stopAudioMixing')
  final bool? stopAudioMixing;

  /// Whether to stop playing sound effects when leaving the channel: true : (default) Stop playing sound effects. false : Do not stop playing sound effects.
  @JsonKey(name: 'stopAllEffect')
  final bool? stopAllEffect;

  /// @nodoc
  @JsonKey(name: 'unloadAllEffect')
  final bool? unloadAllEffect;

  /// Whether to stop microphone capture when leaving the channel: true : (default) Stop microphone capture. false : Do not stop microphone capture.
  @JsonKey(name: 'stopMicrophoneRecording')
  final bool? stopMicrophoneRecording;

  /// @nodoc
  factory LeaveChannelOptions.fromJson(Map<String, dynamic> json) =>
      _$LeaveChannelOptionsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LeaveChannelOptionsToJson(this);
}

/// The RtcEngineEventHandler interface class is used by the SDK to send event notifications to the app. The app receives SDK event notifications by inheriting the methods of this interface class.
///
/// All methods of this interface class have default (empty) implementations. The app can choose to inherit only the events of interest.
///  In callback methods, the app should not perform time-consuming operations or call APIs that may cause blocking (such as sendMessage), otherwise it may affect the operation of the SDK.
///  The SDK no longer catches exceptions in the custom logic implemented by developers in the RtcEngineEventHandler class callbacks. You need to handle such exceptions yourself, otherwise they may cause the app to crash.
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
    this.onRemoteAudioStats,
    this.onLocalAudioStats,
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
    this.onFirstRemoteAudioDecoded,
    this.onFirstRemoteAudioFrame,
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
    this.onUserAccountUpdated,
    this.onVideoRenderingTracingResult,
    this.onLocalVideoTranscoderError,
    this.onUploadLogResult,
    this.onAudioSubscribeStateChanged,
    this.onVideoSubscribeStateChanged,
    this.onAudioPublishStateChanged,
    this.onVideoPublishStateChanged,
    this.onTranscodedStreamLayoutInfo,
    this.onAudioMetadataReceived,
    this.onExtensionEventWithContext,
    this.onExtensionStartedWithContext,
    this.onExtensionStoppedWithContext,
    this.onExtensionErrorWithContext,
    this.onSetRtmFlagResult,
  });

  /// Callback when successfully joined a channel.
  ///
  /// This callback indicates that the client has successfully joined the specified channel.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [elapsed] Time elapsed (ms) from calling joinChannel until this event occurs.
  final void Function(RtcConnection connection, int elapsed)?
      onJoinChannelSuccess;

  /// Callback when successfully rejoined a channel.
  ///
  /// * [elapsed] Time interval (ms) from calling joinChannel to triggering this callback.
  final void Function(RtcConnection connection, int elapsed)?
      onRejoinChannelSuccess;

  /// Callback for proxy connection status.
  ///
  /// You can use this callback to monitor the SDK's connection status to the proxy. For example, when a user calls setCloudProxy to set the proxy and successfully joins a channel, the SDK triggers this callback to report the user ID, proxy type connected, and the time elapsed from calling joinChannel to triggering this callback.
  ///
  /// * [channel] Channel name.
  /// * [uid] User ID
  /// * [localProxyIp] Reserved parameter, currently not supported.
  /// * [elapsed] Time elapsed (in milliseconds) from calling joinChannel to the SDK triggering this callback.
  final void Function(String channel, int uid, ProxyType proxyType,
      String localProxyIp, int elapsed)? onProxyConnected;

  /// Callback when an error occurs.
  ///
  /// This callback indicates that a network or media-related error occurred during SDK runtime. In most cases, errors reported by the SDK mean it cannot recover automatically and requires app intervention or user notification.
  ///
  /// * [err] Error code. See ErrorCodeType.
  /// * [msg] Error description.
  final void Function(ErrorCodeType err, String msg)? onError;

  /// Callback for remote audio quality.
  ///
  /// Deprecated Deprecated: Use onRemoteAudioStats instead. This callback describes the audio quality of a remote user during a call and is triggered every 2 seconds for each remote user/host. If there are multiple remote users/hosts, the callback is triggered multiple times every 2 seconds.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [remoteUid] User ID of the sender of the audio stream.
  /// * [quality] Audio quality. See QualityType.
  /// * [delay] Delay (ms) from the sender to the receiver, including preprocessing, network transmission, and jitter buffer delay.
  /// * [lost] Packet loss rate (%) from the sender to the receiver.
  final void Function(RtcConnection connection, int remoteUid,
      QualityType quality, int delay, int lost)? onAudioQuality;

  /// Callback for the last mile uplink and downlink network quality probe report before the call.
  ///
  /// After calling startLastmileProbeTest, the SDK returns this callback within about 30 seconds.
  ///
  /// * [result] Uplink and downlink last mile quality probe result. See LastmileProbeResult.
  final void Function(LastmileProbeResult result)? onLastmileProbeResult;

  /// Callback for user audio volume indication.
  ///
  /// This callback is disabled by default. You can enable it using enableAudioVolumeIndication. Once enabled, as long as there are users publishing streams in the channel, the SDK triggers the onAudioVolumeIndication callback at the interval set in enableAudioVolumeIndication after joining the channel. Each time, two onAudioVolumeIndication callbacks are triggered: one reports the local user's volume information, and the other reports the volume information of the remote users (up to 3) with the highest instantaneous volume. After enabling this feature, if a user mutes themselves (by calling muteLocalAudioStream), the SDK continues to report the local user's volume indication callback.
  /// If the remote user with the highest instantaneous volume mutes themselves for 20 seconds, they will no longer be included in the remote volume indication callback. If all remote users mute themselves, the SDK stops reporting remote volume indication callbacks after 20 seconds.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [speakers] User volume information. See the AudioVolumeInfo array. If speakers is empty, it means no remote users are publishing streams or there are no remote users.
  /// * [speakerNumber] Number of users.
  ///  In the local user's callback, as long as the local user is publishing, speakerNumber is always 1.
  ///  In the remote users' callback, speakerNumber ranges from [0,3]. If there are more than 3 remote users publishing, speakerNumber is 3.
  /// * [totalVolume] Total mixed volume, range [0,255].
  ///  In the local user's callback, totalVolume is the local user's volume.
  ///  In the remote users' callback, totalVolume is the total mixed volume of the top 3 remote users with the highest instantaneous volume.
  final void Function(RtcConnection connection, List<AudioVolumeInfo> speakers,
      int speakerNumber, int totalVolume)? onAudioVolumeIndication;

  /// Callback when leaving a channel.
  ///
  /// You can use this callback to obtain information such as the total call duration and the amount of data sent and received by the SDK.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [stats] Call statistics. See RtcStats.
  final void Function(RtcConnection connection, RtcStats stats)? onLeaveChannel;

  /// Callback for current call statistics.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [stats] RTC engine statistics. See RtcStats.
  final void Function(RtcConnection connection, RtcStats stats)? onRtcStats;

  /// Occurs when the audio device state changes.
  ///
  /// Indicates that the system audio device state has changed, such as when a headset is unplugged. This method is only applicable to Windows and macOS.
  ///
  /// * [deviceId] The device ID.
  /// * [deviceType] The device type definition. See MediaDeviceType.
  /// * [deviceState] The device state. See MediaDeviceStateType.
  final void Function(String deviceId, MediaDeviceType deviceType,
      MediaDeviceStateType deviceState)? onAudioDeviceStateChanged;

  /// Reports the playback progress of the music file.
  ///
  /// After calling startAudioMixing to play a music file, the SDK triggers this callback once every second to report the current playback progress.
  ///
  /// * [position] The current playback progress of the music file, in ms.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  final void Function(int position)? onAudioMixingPositionChanged;

  /// Occurs when local music file playback ends.
  ///
  /// Deprecated Deprecated: Use onAudioMixingStateChanged instead. This callback is triggered when the local music file finishes playing after calling startAudioMixing. If startAudioMixing fails, it returns the error code WARN_AUDIO_MIXING_OPEN_ERROR.
  final void Function()? onAudioMixingFinished;

  /// Callback when a local audio effect file finishes playing.
  ///
  /// This callback is triggered when the audio effect finishes playing.
  ///
  /// * [soundId] The ID of the specified audio effect. Each audio effect has a unique ID.
  final void Function(int soundId)? onAudioEffectFinished;

  /// Callback when a video device changes.
  ///
  /// This callback indicates that the system video device state has changed, such as being unplugged or removed. If you are using an external camera for capture, unplugging it will interrupt the video. This callback is applicable only to Windows and macOS.
  ///
  /// * [deviceId] Device ID.
  /// * [deviceType] Device type. See MediaDeviceType.
  /// * [deviceState] Device state. See MediaDeviceStateType.
  final void Function(String deviceId, MediaDeviceType deviceType,
      MediaDeviceStateType deviceState)? onVideoDeviceStateChanged;

  /// Callback for the last mile uplink and downlink network quality report for each user during the call.
  ///
  /// This callback describes the last mile network status of each user during the call. The last mile refers to the network status from the device to the Agora edge server.
  /// This callback is triggered every 2 seconds. If there are multiple remote users, it is triggered multiple times every 2 seconds.
  /// This callback reports network quality via broadcast packets within the channel. Excessive broadcast packets may cause a broadcast storm. To avoid excessive data transmission due to broadcast storms, this callback supports reporting the network quality of up to 4 remote hosts simultaneously by default. If the user is not sending streams, txQuality is Unknown; if the user is not receiving streams, rxQuality is Unknown.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [remoteUid] User ID. Indicates the network quality report for the user with this ID. If the uid is 0, it reports the local user's network quality.
  /// * [txQuality] The user's uplink network quality, calculated based on the sending bitrate, uplink packet loss rate, average round-trip time, and network jitter. This value represents the current uplink network quality and helps determine whether the current video encoding settings are sustainable. For example, if the uplink bitrate is 1000 Kbps, it can support 640 × 480 resolution at 15 fps in a live broadcast scenario, but may struggle to support 1280 × 720 resolution. See QualityType.
  /// * [rxQuality] The user's downlink network quality, calculated based on the downlink packet loss rate, average round-trip time, and network jitter. See QualityType.
  final void Function(RtcConnection connection, int remoteUid,
      QualityType txQuality, QualityType rxQuality)? onNetworkQuality;

  /// @nodoc
  final void Function(RtcConnection connection)? onIntraRequestReceived;

  /// Callback for uplink network information changes.
  ///
  /// The SDK triggers this callback only when the uplink network information changes. This callback is applicable only when pushing externally encoded video data in H.264 format to the SDK.
  ///
  /// * [info] Uplink network information. See UplinkNetworkInfo.
  final void Function(UplinkNetworkInfo info)? onUplinkNetworkInfoUpdated;

  /// @nodoc
  final void Function(DownlinkNetworkInfo info)? onDownlinkNetworkInfoUpdated;

  /// Callback for the last mile uplink and downlink network quality report.
  ///
  /// This callback describes the result of the last mile network probe for the local user before joining the channel. The last mile refers to the network status from the device to the Agora edge server.
  /// Before joining the channel, after calling startLastmileProbeTest, the SDK triggers this callback to report the result of the last mile network probe for the local user.
  ///
  /// * [quality] Last mile network quality. See QualityType.
  final void Function(QualityType quality)? onLastmileQuality;

  /// Callback when the first local video frame is displayed.
  ///
  /// This callback is triggered by the SDK when the first local video frame is displayed in the local view.
  ///
  /// * [source] Type of video source. See VideoSourceType.
  /// * [width] Width (px) of the locally rendered video.
  /// * [height] Height (px) of the locally rendered video.
  /// * [elapsed] Time elapsed (ms) from calling joinChannel to the occurrence of this event. If startPreviewWithoutSourceType / startPreview is called before joining the channel, this parameter indicates the time from starting the local video preview to the occurrence of this event.
  final void Function(
          VideoSourceType source, int width, int height, int elapsed)?
      onFirstLocalVideoFrame;

  /// Callback when the first local video frame is published.
  ///
  /// The SDK triggers this callback in the following scenarios:
  ///  After successfully joining a channel with the local video module enabled.
  ///  After calling muteLocalVideoStream(true) and then muteLocalVideoStream(false).
  ///  After calling disableVideo and then enableVideo.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [elapsed] Time interval (ms) from calling joinChannel to triggering this callback.
  final void Function(RtcConnection connection, int elapsed)?
      onFirstLocalVideoFramePublished;

  /// Callback when the first remote video is received and decoded.
  ///
  /// The SDK triggers this callback in the following scenarios:
  ///  When the remote user sends video after coming online for the first time.
  ///  When the remote user sends video after going offline and then coming back online. Possible causes of such interruptions include:
  ///  The remote user leaves the channel.
  ///  The remote user gets disconnected.
  ///  The remote user calls the disableVideo method to disable the video module.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [remoteUid] User ID that specifies whose video stream it is.
  /// * [width] Width (px) of the video stream.
  /// * [height] Height (px) of the video stream.
  /// * [elapsed] Delay (ms) from the local call to joinChannel to the triggering of this callback.
  final void Function(RtcConnection connection, int remoteUid, int width,
      int height, int elapsed)? onFirstRemoteVideoDecoded;

  /// Callback when the size and rotation of local or remote video changes.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [sourceType] Type of video source. See VideoSourceType.
  /// * [uid] User ID whose video size or rotation has changed (uid is 0 for local user, indicating local video preview).
  /// * [width] Width of the video stream (pixels).
  /// * [height] Height of the video stream (pixels).
  /// * [rotation] Rotation information, value range [0,360). On iOS, this value is always 0.
  final void Function(RtcConnection connection, VideoSourceType sourceType,
      int uid, int width, int height, int rotation)? onVideoSizeChanged;

  /// Callback when the local video state changes.
  ///
  /// The SDK triggers this callback when the local video state changes, reporting the current state and the reason for the change.
  ///  Frame duplication detection only applies to video frames with resolution greater than 200 × 200, frame rate ≥ 10 fps, and bitrate < 20 Kbps.
  ///  If an exception occurs during video capture, in most cases you can troubleshoot it using the reason parameter in this callback. However, on some devices, when capture issues occur (e.g., freezing), the Android system does not throw any error callbacks, so the SDK cannot report the reason for the local video state change. In this case, you can determine whether no frames are being captured by checking if this callback reports state as localVideoStreamStateCapturing or localVideoStreamStateEncoding, and the captureFrameRate in the onLocalVideoStats callback is 0.
  ///
  /// * [source] Type of video source. See VideoSourceType.
  /// * [state] Local video state. See LocalVideoStreamState.
  /// * [reason] Reason for the local video state change. See LocalVideoStreamReason.
  final void Function(VideoSourceType source, LocalVideoStreamState state,
      LocalVideoStreamReason reason)? onLocalVideoStateChanged;

  /// Callback when the remote video state changes.
  ///
  /// This callback may be inaccurate when the number of users (in communication) or hosts (in live broadcast) in the channel exceeds 32.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [remoteUid] ID of the remote user whose video state changed.
  /// * [state] Remote video stream state. See RemoteVideoState.
  /// * [reason] Reason for the change in the remote video stream state. See RemoteVideoStateReason.
  /// * [elapsed] Time elapsed (ms) from the local user calling joinChannel to the occurrence of this event.
  final void Function(
      RtcConnection connection,
      int remoteUid,
      RemoteVideoState state,
      RemoteVideoStateReason reason,
      int elapsed)? onRemoteVideoStateChanged;

  /// Callback when the renderer receives the first remote video frame.
  ///
  /// This callback is only triggered when the SDK is used for rendering. If you use custom video rendering, this callback is not triggered, and you need to implement it using methods outside the SDK.
  ///
  /// * [uid] User ID that specifies whose video stream it is.
  /// * [connection] Connection information. See RtcConnection.
  /// * [width] Width (px) of the video stream.
  /// * [height] Height (px) of the video stream.
  /// * [elapsed] Time elapsed (ms) from the local call to joinChannel to the occurrence of this event.
  final void Function(RtcConnection connection, int remoteUid, int width,
      int height, int elapsed)? onFirstRemoteVideoFrame;

  /// Callback when a remote user (in communication) or host (in live streaming) joins the current channel.
  ///
  /// In communication scenarios, this callback indicates that a remote user has joined the channel. If other users are already in the channel, the newly joined user also receives callbacks for those existing users.
  ///  In live streaming scenarios, this callback indicates that a host has joined the channel. If other hosts are already in the channel, the newly joined user also receives callbacks for those existing hosts. It is recommended that the number of co-hosts does not exceed 32 (including no more than 17 video co-hosts).
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [remoteUid] The ID of the remote user/host who joined the channel.
  /// * [elapsed] The time elapsed (in milliseconds) from the local user calling joinChannel to the triggering of this callback.
  final void Function(RtcConnection connection, int remoteUid, int elapsed)?
      onUserJoined;

  /// Callback when a remote user (in communication) or host (in live streaming) leaves the current channel.
  ///
  /// Users leave the channel for the following reasons:
  ///  Normal departure: The remote user or host sends a 'goodbye' message and leaves the channel voluntarily.
  ///  Timeout disconnection: No data packets are received from the user within a certain time (20 seconds in communication scenarios, slightly longer in live streaming), and the user is considered offline. In poor network conditions, false positives may occur. It is recommended to use the RTM SDK for reliable offline detection.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [remoteUid] The ID of the remote user or host who went offline.
  /// * [reason] The reason why the remote user (in communication) or host (in live streaming) went offline. See UserOfflineReasonType.
  final void Function(RtcConnection connection, int remoteUid,
      UserOfflineReasonType reason)? onUserOffline;

  /// Occurs when a remote user (in communication) or host (in live streaming) stops or resumes sending audio stream.
  ///
  /// This callback is triggered when a remote user calls the muteLocalAudioStream method to disable or enable audio sending. When the number of users (in communication) or hosts (in live streaming) in the channel exceeds 32, this callback may be inaccurate.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [remoteUid] User ID.
  /// * [muted] Whether the user is muted: true : The user has muted the audio. false : The user has unmuted the audio.
  final void Function(RtcConnection connection, int remoteUid, bool muted)?
      onUserMuteAudio;

  /// Callback when a remote user stops or resumes publishing the video stream.
  ///
  /// When a remote user calls muteLocalVideoStream to stop or resume publishing the video stream, the SDK triggers this callback to report the remote user's stream status to the local user. This callback may be inaccurate when the number of users (in communication) or hosts (in live broadcast) in the channel exceeds 32.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [remoteUid] Remote user ID.
  /// * [muted] Whether the remote user stops publishing the video stream: true : Stops publishing the video stream. false : Publishes the video stream.
  final void Function(RtcConnection connection, int remoteUid, bool muted)?
      onUserMuteVideo;

  /// Callback when a remote user enables/disables the video module.
  ///
  /// Disabling the video function means the user can only make voice calls, cannot display or send their own video, and cannot receive or display others' video.
  /// This callback is triggered when a remote user calls the enableVideo or disableVideo method to enable or disable the video module.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [remoteUid] User ID indicating which user's video stream it is.
  /// * [enabled] true : The user has enabled the video function. false : The user has disabled the video function.
  final void Function(RtcConnection connection, int remoteUid, bool enabled)?
      onUserEnableVideo;

  /// @nodoc
  final void Function(RtcConnection connection, int remoteUid, int state)?
      onUserStateChanged;

  /// Callback when a remote user enables/disables local video capture.
  ///
  /// Deprecated Deprecated: This callback is deprecated. Use the following enums in the onRemoteVideoStateChanged callback instead: remoteVideoStateStopped (0) and remoteVideoStateReasonRemoteMuted (5). remoteVideoStateDecoding (2) and remoteVideoStateReasonRemoteUnmuted (6). This callback is triggered when a remote user calls the enableLocalVideo method to enable or disable video capture.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [remoteUid] User ID indicating which user's video stream it is.
  /// * [enabled] Whether the remote user enables video capture: true : The user has enabled the video function. Other users can receive this user's video stream. false : The user has disabled the video function. This user can still receive other users' video streams, but others cannot receive this user's video stream.
  final void Function(RtcConnection connection, int remoteUid, bool enabled)?
      onUserEnableLocalVideo;

  /// Callback with statistics of the remote audio stream during a call.
  ///
  /// This callback is triggered every 2 seconds for each remote user/host who is sending an audio stream. If multiple remote users/hosts are sending audio streams, this callback is triggered multiple times every 2 seconds.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [stats] Received remote audio statistics. See RemoteAudioStats.
  final void Function(RtcConnection connection, RemoteAudioStats stats)?
      onRemoteAudioStats;

  /// Callback with statistics of the local audio stream during a call.
  ///
  /// The SDK triggers this callback once every 2 seconds.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [stats] Local audio statistics. See LocalAudioStats.
  final void Function(RtcConnection connection, LocalAudioStats stats)?
      onLocalAudioStats;

  /// Callback with local video stream statistics.
  ///
  /// This callback provides statistics about the local device's video stream every 2 seconds.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [stats] Local video stream statistics. See LocalVideoStats.
  final void Function(RtcConnection connection, LocalVideoStats stats)?
      onLocalVideoStats;

  /// Callback for statistics of the remote video stream during a call.
  ///
  /// This callback reports end-to-end statistics of the remote video stream during a call. It is triggered every 2 seconds for each remote user/host. If there are multiple remote users/hosts, this callback is triggered multiple times every 2 seconds.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [stats] Statistics of the remote video. See RemoteVideoStats.
  final void Function(RtcConnection connection, RemoteVideoStats stats)?
      onRemoteVideoStats;

  /// Callback when the camera is ready.
  ///
  /// Deprecated Deprecated: Use onLocalVideoStateChanged with localVideoStreamStateCapturing(1) instead. This callback indicates that the camera has been successfully opened and video capture can start.
  final void Function()? onCameraReady;

  /// Callback when the camera focus area changes.
  ///
  /// This callback is triggered when the local user calls setCameraFocusPositionInPreview to change the focus position. This callback is applicable only to Android and iOS.
  ///
  /// * [x] The x coordinate of the changed focus area.
  /// * [y] The y coordinate of the changed focus area.
  /// * [width] The width of the changed focus area.
  /// * [height] The height of the changed focus area.
  final void Function(int x, int y, int width, int height)?
      onCameraFocusAreaChanged;

  /// Callback when the camera exposure area changes.
  ///
  /// This callback is triggered when the local user calls setCameraExposurePosition to change the exposure position. This callback is applicable only to Android and iOS.
  final void Function(int x, int y, int width, int height)?
      onCameraExposureAreaChanged;

  /// Reports local face detection results.
  ///
  /// After calling enableFaceDetection(true) to enable local face detection, you can use this callback to get the following face detection information in real time:
  ///  Size of the image captured by the camera
  ///  Position of the face in the view
  ///  Distance of the face from the device screen The distance of the face from the screen is estimated by the SDK based on the image size and face position in the view.
  ///  This callback is only available on Android and iOS platforms.
  ///  When the face in front of the camera disappears, this callback is triggered immediately. When no face is detected, the callback frequency is reduced to save device power.
  ///  When the face is too close to the screen, the SDK does not trigger this callback.
  ///  On Android, the distance value has some error margin. Do not use it for precise calculations.
  ///
  /// * [imageWidth] Width of the image captured by the camera (px).
  /// * [imageHeight] Height of the image captured by the camera (px).
  /// * [vecRectangle] Detected face information. See Rectangle.
  /// * [vecDistance] Distance between the face and the device screen (cm).
  /// * [numFaces] Number of faces detected. If 0, no face is detected.
  final void Function(
      int imageWidth,
      int imageHeight,
      List<Rectangle> vecRectangle,
      List<int> vecDistance,
      int numFaces)? onFacePositionChanged;

  /// Callback when video function is stopped.
  ///
  /// Deprecated Deprecated: Use localVideoStreamStateStopped (0) in the onLocalVideoStateChanged callback instead. If the app needs to perform other operations on the view after stopping video (such as displaying other content), you can do so in this callback.
  final void Function()? onVideoStopped;

  /// Occurs when the playback state of the music file changes.
  ///
  /// This callback is triggered when the playback state of the music file changes and reports the current playback state and error code.
  ///
  /// * [state] The playback state of the music file. See AudioMixingStateType.
  /// * [reason] The error code. See AudioMixingReasonType.
  final void Function(AudioMixingStateType state, AudioMixingReasonType reason)?
      onAudioMixingStateChanged;

  /// Callback when the state of the virtual metronome changes.
  ///
  /// Deprecated Deprecated since v4.6.2. When the state of the virtual metronome changes, the SDK triggers this callback to report the current state. If a fault occurs with the virtual metronome, this callback helps you understand the current state and the reason for the fault, allowing you to troubleshoot. This callback applies to Android and iOS only.
  ///
  /// * [state] The current state of the virtual metronome. See RhythmPlayerStateType.
  /// * [reason] The error code and message when the virtual metronome encounters an error. See RhythmPlayerReason.
  final void Function(RhythmPlayerStateType state, RhythmPlayerReason reason)?
      onRhythmPlayerStateChanged;

  /// Callback when the network connection is lost and the SDK fails to reconnect to the server within 10 seconds.
  ///
  /// After calling joinChannel, this callback is triggered if the SDK cannot connect to the server within 10 seconds, regardless of whether the user has joined the channel successfully. If the SDK still fails to rejoin the channel within 20 minutes after disconnection, it stops trying to reconnect.
  ///
  /// * [connection] Connection information. See RtcConnection.
  final void Function(RtcConnection connection)? onConnectionLost;

  /// Callback when the network connection is interrupted.
  ///
  /// Deprecated Deprecated: Use onConnectionStateChanged callback instead. This callback is triggered when the SDK loses connection to the server for more than 4 seconds after establishing a connection. After this event is triggered, the SDK will try to reconnect to the server. You can use this event to prompt the UI. The difference between this callback and onConnectionLost is: onConnectionInterrupted is triggered only after successfully joining a channel and when the SDK loses connection to the server for more than 4 seconds. onConnectionLost is triggered regardless of whether the user has joined a channel, as long as the SDK cannot connect to the server within 10 seconds. If the SDK still fails to rejoin the channel within 20 minutes after disconnection, it stops trying to reconnect.
  ///
  /// * [connection] Connection information. See RtcConnection.
  final void Function(RtcConnection connection)? onConnectionInterrupted;

  /// Callback when the network connection is banned by the server.
  ///
  /// Deprecated Deprecated: Use onConnectionStateChanged instead.
  ///
  /// * [connection] Connection information. See RtcConnection.
  final void Function(RtcConnection connection)? onConnectionBanned;

  /// Occurs when a stream message is received from a remote user.
  ///
  /// This callback indicates that the local user has received a stream message sent by a remote user using the sendStreamMessage method. If you need a more comprehensive solution for low-latency, high-concurrency, and scalable real-time messaging and state synchronization, we recommend using [Real-time Messaging](https://doc.shengwang.cn/doc/rtm2/flutter/landing-page).
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [remoteUid] The ID of the user who sent the message.
  /// * [streamId] The stream ID of the received message.
  /// * [data] The received data.
  /// * [length] The length of the data in bytes.
  /// * [sentTs] The timestamp when the data stream was sent.
  final void Function(RtcConnection connection, int remoteUid, int streamId,
      Uint8List data, int length, int sentTs)? onStreamMessage;

  /// Occurs when an error occurs in receiving a stream message from a remote user.
  ///
  /// This callback indicates that the local user failed to receive a stream message sent by a remote user using the sendStreamMessage method. If you need a more comprehensive solution for low-latency, high-concurrency, and scalable real-time messaging and state synchronization, we recommend using [Real-time Messaging](https://doc.shengwang.cn/doc/rtm2/flutter/landing-page).
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [remoteUid] The ID of the user who sent the message.
  /// * [streamId] The stream ID of the received message.
  /// * [code] The error code. See ErrorCodeType.
  /// * [missed] The number of lost messages.
  /// * [cached] The number of messages cached after the data stream was interrupted.
  final void Function(RtcConnection connection, int remoteUid, int streamId,
      ErrorCodeType code, int missed, int cached)? onStreamMessageError;

  /// Callback when the token has expired.
  ///
  /// During audio and video interaction, if the token becomes invalid, the SDK triggers this callback to report that the token has expired.
  /// When you receive this callback, you need to generate a new token on your server and update it using one of the following methods:
  ///  Single-channel scenario:
  ///  Call renewToken to pass in the new token.
  ///  Call leaveChannel to leave the current channel, then call joinChannel with the new token to rejoin.
  ///  Multi-channel scenario: Call updateChannelMediaOptionsEx with the new token.
  ///
  /// * [connection] Connection information. See RtcConnection.
  final void Function(RtcConnection connection)? onRequestToken;

  /// Callback when the token is about to expire in 30 seconds.
  ///
  /// When you receive this callback, you need to generate a new token on your server and update it using one of the following methods:
  ///  Single-channel scenario:
  ///  Call renewToken to pass in the new token.
  ///  Call leaveChannel to leave the current channel, then pass in the new token when calling joinChannel to rejoin the channel.
  ///  Multi-channel scenario: Call updateChannelMediaOptionsEx to pass in the new token.
  ///
  /// * [token] The token that is about to expire.
  final void Function(RtcConnection connection, String token)?
      onTokenPrivilegeWillExpire;

  /// @nodoc
  final void Function(RtcConnection connection, LicenseErrorType reason)?
      onLicenseValidationFailure;

  /// Callback when the first local audio frame is published.
  ///
  /// The SDK triggers this callback under the following circumstances:
  ///  After successfully joining a channel by calling joinChannel with local audio enabled.
  ///  After calling muteLocalAudioStream(true) followed by muteLocalAudioStream(false).
  ///  After calling disableAudio followed by enableAudio.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [elapsed] The time elapsed (in milliseconds) from calling the joinChannel method to triggering this callback.
  final void Function(RtcConnection connection, int elapsed)?
      onFirstLocalAudioFramePublished;

  /// Callback when the first remote audio frame is decoded.
  ///
  /// Deprecated Deprecated: Please use onRemoteAudioStateChanged instead. The SDK triggers this callback under the following circumstances:
  ///  When a remote user sends audio after joining the channel for the first time.
  ///  When a remote user resumes sending audio after going offline. Offline means no audio packets are received within 15 seconds, which may be caused by:
  ///  The remote user leaving the channel
  ///  The remote user going offline
  ///  The remote user calling muteLocalAudioStream to stop sending audio streams
  ///  The remote user calling disableAudio to disable audio
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [uid] Remote user ID.
  /// * [elapsed] The delay (in milliseconds) from the local user calling joinChannel to the triggering of this callback.
  final void Function(RtcConnection connection, int uid, int elapsed)?
      onFirstRemoteAudioDecoded;

  /// Callback when the first remote audio frame is received.
  ///
  /// Deprecated Deprecated: Please use onRemoteAudioStateChanged instead.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [userId] User ID of the remote user sending the audio frame.
  /// * [elapsed] The delay (in milliseconds) from the local user calling joinChannel to the triggering of this callback.
  final void Function(RtcConnection connection, int userId, int elapsed)?
      onFirstRemoteAudioFrame;

  /// Callback when the local audio state changes.
  ///
  /// When the local audio state changes (including microphone capture and audio encoding states), the SDK triggers this callback to report the current local audio state. This callback helps you diagnose issues by providing the current state and reason when a local audio failure occurs. When the state is localAudioStreamStateFailed (3), you can check the returned error information in the error parameter.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [state] Current local audio state. See LocalAudioStreamState.
  /// * [reason] Reason for the local audio state change. See LocalAudioStreamReason.
  final void Function(RtcConnection connection, LocalAudioStreamState state,
      LocalAudioStreamReason reason)? onLocalAudioStateChanged;

  /// Callback when the remote audio stream state changes.
  ///
  /// When the audio state of a remote user (in communication) or host (in live streaming) changes, the SDK triggers this callback to report the current remote audio stream state to the local user. When there are more than 32 users (in communication) or hosts (in live streaming) in the channel, this callback may be inaccurate.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [remoteUid] User ID of the remote user whose audio state changed.
  /// * [state] Remote audio stream state. See RemoteAudioState.
  /// * [reason] Specific reason for the remote audio stream state change. See RemoteAudioStateReason.
  /// * [elapsed] Time elapsed (in milliseconds) from the local user calling the joinChannel method to the occurrence of this event.
  final void Function(
      RtcConnection connection,
      int remoteUid,
      RemoteAudioState state,
      RemoteAudioStateReason reason,
      int elapsed)? onRemoteAudioStateChanged;

  /// Callback when the most active remote speaker is detected.
  ///
  /// After successfully calling enableAudioVolumeIndication, the SDK continuously monitors the remote user with the highest volume and counts how often the user is detected as having the highest volume. The remote user with the highest count during the current period is considered the most active speaker.
  /// When there are two or more users in the channel and a remote active speaker exists, the SDK triggers this callback and reports the uid of the most active remote speaker.
  ///  If the most active speaker remains the same, the SDK does not trigger onActiveSpeaker again.
  ///  If the most active speaker changes, the SDK triggers the callback again and reports the new uid.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [uid] ID of the most active remote speaker.
  final void Function(RtcConnection connection, int uid)? onActiveSpeaker;

  /// @nodoc
  final void Function(ContentInspectResult result)? onContentInspectResult;

  /// Callback for video snapshot result.
  ///
  /// After successfully calling takeSnapshot, the SDK triggers this callback to report whether the snapshot was successful and provide the snapshot details.
  ///
  /// * [uid] User ID. If uid is 0, it indicates the local user.
  /// * [connection] Connection information. See RtcConnection.
  /// * [filePath] The local path where the snapshot is saved.
  /// * [width] Image width (px).
  /// * [height] Image height (px).
  /// * [errCode] Indicates whether the snapshot was successful or the reason for failure.
  ///  0: Snapshot successful.
  ///  < 0: Snapshot failed.
  ///  -1: Failed to write file or JPEG encoding failed.
  ///  -2: No video frame received from the specified user within 1 second after calling takeSnapshot. Possible reasons include local capture stopped, remote user stopped publishing, or video data processing is blocked.
  ///  -3: takeSnapshot was called too frequently.
  final void Function(RtcConnection connection, int uid, String filePath,
      int width, int height, int errCode)? onSnapshotTaken;

  /// Callback when the user role or audience latency level is switched.
  ///
  /// This callback is not triggered if you call setClientRole before joining a channel and set the role to BROADCASTER.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [oldRole] Role before switching: ClientRoleType.
  /// * [newRole] Role after switching: ClientRoleType.
  /// * [newRoleOptions] Properties of the new role. See ClientRoleOptions.
  final void Function(
      RtcConnection connection,
      ClientRoleType oldRole,
      ClientRoleType newRole,
      ClientRoleOptions newRoleOptions)? onClientRoleChanged;

  /// Callback when user role change fails.
  ///
  /// When the user role change fails, you can use this callback to get the reason for the failure and the current user role.
  ///
  /// * [reason] The reason for the user role change failure. See ClientRoleChangeFailedReason.
  /// * [currentRole] The current user role. See ClientRoleType.
  /// * [connection] Connection information. See RtcConnection.
  final void Function(
      RtcConnection connection,
      ClientRoleChangeFailedReason reason,
      ClientRoleType currentRole)? onClientRoleChangeFailed;

  /// Occurs when the volume of the audio device or app changes.
  ///
  /// This callback is triggered when the volume of an audio playback or recording device or the app changes. This callback is only applicable to Windows and macOS.
  ///
  /// * [deviceType] The device type definition. See MediaDeviceType.
  /// * [volume] The volume, ranging from [0,255].
  /// * [muted] Whether the audio device is muted: true : The audio device is muted. false : The audio device is not muted.
  final void Function(MediaDeviceType deviceType, int volume, bool muted)?
      onAudioDeviceVolumeChanged;

  /// Callback when the RTMP streaming state changes.
  ///
  /// When the RTMP streaming state changes, the SDK triggers this callback and reports the URL and current streaming state. This callback helps streaming users understand the current streaming state. If an error occurs, you can use the returned error code to identify the cause and troubleshoot the issue.
  ///
  /// * [url] The URL of the stream whose state has changed.
  /// * [state] The current streaming state. See RtmpStreamPublishState.
  /// * [reason] The reason for the streaming state change. See RtmpStreamPublishReason.
  final void Function(String url, RtmpStreamPublishState state,
      RtmpStreamPublishReason reason)? onRtmpStreamingStateChanged;

  /// Callback for RTMP streaming events.
  ///
  /// * [url] The RTMP streaming URL.
  /// * [eventCode] The RTMP streaming event code. See RtmpStreamingEvent.
  final void Function(String url, RtmpStreamingEvent eventCode)?
      onRtmpStreamingEvent;

  /// Callback when the RTMP transcoding settings are updated.
  ///
  /// When the LiveTranscoding parameters in the startRtmpStreamWithTranscoding method are updated, the onTranscodingUpdated callback is triggered to notify the host. This callback is not triggered the first time you call startRtmpStreamWithTranscoding to set the LiveTranscoding parameters.
  final void Function()? onTranscodingUpdated;

  /// Callback when the audio routing changes.
  ///
  /// This callback is applicable only on Android, iOS, and macOS platforms.
  ///
  /// * [routing] The current audio route. See AudioRoute.
  final void Function(int routing)? onAudioRoutingChanged;

  /// Callback when the state of the channel media relay changes.
  ///
  /// This callback is triggered by the SDK when the state of the channel media relay changes, reporting the current relay state and related error information.
  ///
  /// * [state] The channel media relay state. See ChannelMediaRelayState.
  /// * [code] The error code of the channel media relay. See ChannelMediaRelayError.
  final void Function(
          ChannelMediaRelayState state, ChannelMediaRelayError code)?
      onChannelMediaRelayStateChanged;

  /// @nodoc
  final void Function(bool isFallbackOrRecover)?
      onLocalPublishFallbackToAudioOnly;

  /// Callback when the subscribed stream falls back to audio-only or recovers to audio and video.
  ///
  /// After you call setRemoteSubscribeFallbackOption and set option to streamFallbackOptionAudioOnly, this callback is triggered in the following situations:
  ///  When the downlink network condition is poor, the subscribed audio and video stream falls back to audio-only
  ///  When the downlink network condition improves, the subscribed audio-only stream recovers to audio and video When the subscribed stream falls back to a low-quality video stream due to poor network conditions, you can monitor the switching of remote video stream quality through the onRemoteVideoStats callback.
  ///
  /// * [uid] User ID of the remote user.
  /// * [isFallbackOrRecover] true : Due to poor network conditions, the subscribed stream has fallen back to audio-only. false : Due to improved network conditions, the subscribed stream has recovered to audio and video.
  final void Function(int uid, bool isFallbackOrRecover)?
      onRemoteSubscribeFallbackToAudioOnly;

  /// Reports the statistics of the remote audio stream transmission during a call.
  ///
  /// Deprecated:
  /// Use onRemoteAudioStats instead.
  /// This callback reports end-to-end network statistics of the remote user during a call. It calculates metrics based on audio packets and objectively reflects the current network status using data such as packet loss and network delay. During a call, when a user receives audio packets sent by a remote user/host, this callback is triggered every 2 seconds.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [remoteUid] The user ID specifying which user/host the audio packet belongs to.
  /// * [delay] The delay (ms) from the sender to the receiver for the audio packet.
  /// * [lost] The packet loss rate (%) from the sender to the receiver for the audio packet.
  /// * [rxKBitrate] The received bitrate (Kbps) of the remote audio packet.
  final void Function(RtcConnection connection, int remoteUid, int delay,
      int lost, int rxKBitRate)? onRemoteAudioTransportStats;

  /// Callback for transport statistics of the remote video stream during a call.
  ///
  /// Deprecated Deprecated: This callback is deprecated. Use onRemoteVideoStats instead. This callback reports end-to-end network statistics of the remote user during a call, calculated based on video packets. It objectively shows the current network status through data such as packet loss and network delay.
  /// During a call, this callback is triggered every 2 seconds after the user receives video packets sent by the remote user/host.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [remoteUid] User ID specifying which user/host the video packet belongs to.
  /// * [delay] Delay (ms) from the sender to the receiver for the video packet.
  /// * [lost] Packet loss rate (%) from the sender to the receiver for the video packet.
  /// * [rxKBitRate] Received bitrate (Kbps) of the remote video packet.
  final void Function(RtcConnection connection, int remoteUid, int delay,
      int lost, int rxKBitRate)? onRemoteVideoTransportStats;

  /// Callback when the network connection state changes.
  ///
  /// This callback is triggered when the network connection state changes and informs the user of the current connection state and the reason for the change.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [state] Current network connection state. See ConnectionStateType.
  /// * [reason] Reason for the change in network connection state. See ConnectionChangedReasonType.
  final void Function(RtcConnection connection, ConnectionStateType state,
      ConnectionChangedReasonType reason)? onConnectionStateChanged;

  /// @nodoc
  final void Function(RtcConnection connection, WlaccMessageReason reason,
      WlaccSuggestAction action, String wlAccMsg)? onWlAccMessage;

  /// @nodoc
  final void Function(RtcConnection connection, WlAccStats currentStats,
      WlAccStats averageStats)? onWlAccStats;

  /// Callback when the local network type changes.
  ///
  /// When the local network connection type changes, the SDK triggers this callback and specifies the current network connection type in the callback. You can use this callback to obtain the network type in use; when the connection is interrupted, this callback helps determine whether the cause is a network switch or poor network conditions.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [type] Local network connection type. See NetworkType.
  final void Function(RtcConnection connection, NetworkType type)?
      onNetworkTypeChanged;

  /// Callback when an error occurs with built-in encryption.
  ///
  /// After calling enableEncryption to enable encryption, if an encryption or decryption error occurs on the sender or receiver side, the SDK triggers this callback.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [errorType] Error type. See EncryptionErrorType.
  final void Function(RtcConnection connection, EncryptionErrorType errorType)?
      onEncryptionError;

  /// Callback when failing to obtain device permission.
  ///
  /// When the SDK fails to obtain device permission, it triggers this callback to report which device permission could not be obtained.
  ///
  /// * [permissionType] Device permission type. See PermissionType.
  final void Function(PermissionType permissionType)? onPermissionError;

  /// Callback when the local user successfully registers a User Account.
  ///
  /// When the local user successfully registers a User Account by calling registerLocalUserAccount, or joins a channel using joinChannelWithUserAccount, the SDK triggers this callback and reports the local user's UID and User Account.
  ///
  /// * [uid] The local user's ID.
  /// * [userAccount] The local user's User Account.
  final void Function(int uid, String userAccount)? onLocalUserRegistered;

  /// Callback when remote user information is updated.
  ///
  /// After a remote user joins the channel, the SDK obtains the user's UID and User Account, then caches a mapping table that includes the remote user's UID and User Account, and triggers this callback locally.
  ///
  /// * [uid] The ID of the remote user.
  /// * [info] The UserInfo object that identifies the user information, including the user's UID and User Account. See UserInfo class.
  final void Function(int uid, UserInfo info)? onUserInfoUpdated;

  /// @nodoc
  final void Function(
          RtcConnection connection, int remoteUid, String remoteUserAccount)?
      onUserAccountUpdated;

  /// Callback for video frame rendering events.
  ///
  /// After calling the startMediaRenderingTracing method or joining a channel, the SDK triggers this callback to report video frame rendering events and metrics during the rendering process. Developers can optimize based on these metrics to improve rendering efficiency.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [uid] User ID.
  /// * [currentEvent] Current video frame rendering event. See MediaTraceEvent.
  /// * [tracingInfo] Metrics during video frame rendering. Developers should minimize the metric values to improve rendering efficiency. See VideoRenderingTracingInfo.
  final void Function(
      RtcConnection connection,
      int uid,
      MediaTraceEvent currentEvent,
      VideoRenderingTracingInfo tracingInfo)? onVideoRenderingTracingResult;

  /// Callback for local video mixing error.
  ///
  /// When calling startLocalVideoTranscoder or updateLocalTranscoderConfiguration fails, the SDK triggers this callback to report the reason for the mixing failure.
  ///
  /// * [stream] The video stream that failed to mix. See TranscodingVideoStream.
  /// * [error] The reason for the local video mixing error. See VideoTranscoderError.
  final void Function(
          TranscodingVideoStream stream, VideoTranscoderError error)?
      onLocalVideoTranscoderError;

  /// @nodoc
  final void Function(RtcConnection connection, String requestId, bool success,
      UploadErrorReason reason)? onUploadLogResult;

  /// Callback for audio subscription state changes.
  ///
  /// * [channel] Channel name.
  /// * [uid] Remote user ID.
  /// * [oldState] Previous subscription state. See StreamSubscribeState.
  /// * [newState] Current subscription state. See StreamSubscribeState.
  /// * [elapseSinceLastState] Time elapsed between state changes (ms).
  final void Function(
      String channel,
      int uid,
      StreamSubscribeState oldState,
      StreamSubscribeState newState,
      int elapseSinceLastState)? onAudioSubscribeStateChanged;

  /// Callback for video subscription state changes.
  ///
  /// * [channel] Channel name.
  /// * [uid] Remote user ID.
  /// * [oldState] Previous subscription state. See StreamSubscribeState.
  /// * [newState] Current subscription state. See StreamSubscribeState.
  /// * [elapseSinceLastState] Time elapsed between state changes (ms).
  final void Function(
      String channel,
      int uid,
      StreamSubscribeState oldState,
      StreamSubscribeState newState,
      int elapseSinceLastState)? onVideoSubscribeStateChanged;

  /// Callback for audio publish state changes.
  ///
  /// * [channel] Channel name.
  /// * [oldState] Previous publish state. See StreamPublishState.
  /// * [newState] Current publish state. See StreamPublishState.
  /// * [elapseSinceLastState] Time elapsed between state changes (ms).
  final void Function(
      String channel,
      StreamPublishState oldState,
      StreamPublishState newState,
      int elapseSinceLastState)? onAudioPublishStateChanged;

  /// Callback for video publishing state change.
  ///
  /// * [channel] Channel name.
  /// * [source] Type of video source. See VideoSourceType.
  /// * [oldState] Previous publishing state. See StreamPublishState.
  /// * [newState] Current publishing state. See StreamPublishState.
  /// * [elapseSinceLastState] Interval between the two state changes (ms).
  final void Function(
      VideoSourceType source,
      String channel,
      StreamPublishState oldState,
      StreamPublishState newState,
      int elapseSinceLastState)? onVideoPublishStateChanged;

  /// Callback for received mixed stream with layout information.
  ///
  /// When the local client first receives a mixed video stream from the mixing server, or when the layout information of the mixed stream changes, the SDK triggers this callback to report the layout information of each sub-video stream in the mixed stream. This callback is applicable only to Android and iOS.
  ///
  /// * [connection] Connection information. See RtcConnection.
  /// * [uid] User ID of the mixed video stream publisher.
  /// * [width] Width (px) of the mixed video stream.
  /// * [height] Height (px) of the mixed video stream.
  /// * [layoutCount] Number of layout information entries in the mixed video stream.
  /// * [layoutlist] Detailed layout information of a mixed video stream. See VideoLayout.
  final void Function(
      RtcConnection connection,
      int uid,
      int width,
      int height,
      int layoutCount,
      List<VideoLayout> layoutlist)? onTranscodedStreamLayoutInfo;

  /// @nodoc
  final void Function(
          RtcConnection connection, int uid, Uint8List metadata, int length)?
      onAudioMetadataReceived;

  /// Plugin event callback.
  ///
  /// To listen for plugin events, you need to register this callback.
  ///
  /// * [context] Plugin context information. See ExtensionContext.
  /// * [key] Key of the plugin property.
  /// * [value] Value corresponding to the plugin property key.
  final void Function(ExtensionContext context, String key, String value)?
      onExtensionEventWithContext;

  /// Callback when the plugin is successfully enabled.
  ///
  /// This callback is triggered after the plugin is successfully enabled.
  ///
  /// * [context] Plugin context information. See ExtensionContext.
  final void Function(ExtensionContext context)? onExtensionStartedWithContext;

  /// Callback when the plugin is disabled.
  ///
  /// This callback is triggered after the plugin is successfully disabled.
  ///
  /// * [context] Plugin context information. See ExtensionContext.
  final void Function(ExtensionContext context)? onExtensionStoppedWithContext;

  /// Callback for extension errors.
  ///
  /// If enabling the extension fails or the extension encounters a runtime error, it triggers this callback to report the error code and reason.
  ///
  /// * [context] Extension context information. See ExtensionContext.
  /// * [error] Error code. See the documentation provided by the extension provider.
  /// * [message] Error reason. See the documentation provided by the extension provider.
  final void Function(ExtensionContext context, int error, String message)?
      onExtensionErrorWithContext;

  /// @nodoc
  final void Function(RtcConnection connection, int code)? onSetRtmFlagResult;
}

/// Methods for managing video devices.
abstract class VideoDeviceManager {
  /// Gets a list of all video devices on the system.
  ///
  /// This method is only applicable to Windows and macOS.
  ///
  /// Returns
  /// On success: Returns an array of VideoDeviceInfo containing all video devices on the system.
  ///  On failure: Returns an empty list.
  Future<List<VideoDeviceInfo>> enumerateVideoDevices();

  /// Specifies the video capture device by device ID.
  ///
  /// Plugging or unplugging a device does not change the device ID.
  ///  This method is applicable only to Windows and macOS.
  ///
  /// * [deviceIdUTF8] Device ID. You can get it by calling enumerateVideoDevices.
  /// The maximum length is MaxDeviceIdLengthType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setDevice(String deviceIdUTF8);

  /// Gets the currently used video capture device.
  ///
  /// This method is only applicable to Windows and macOS.
  ///
  /// Returns
  /// The video capture device.
  Future<String> getDevice();

  /// Gets the number of video formats supported by the specified video capturing device.
  ///
  /// A video capturing device may support multiple video formats, each with different combinations of frame width, frame height, and frame rate.
  /// You can call this method to get how many video formats the specified video capturing device supports, and then call getCapability to get detailed frame information for a specific video format. This method is only applicable to Windows and macOS.
  ///
  /// * [deviceIdUTF8] The ID of the video capturing device.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  ≤ 0: The method call fails. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<int> numberOfCapabilities(String deviceIdUTF8);

  /// Gets detailed video frame information for a video capture device under a specified video format.
  ///
  /// After calling numberOfCapabilities to get the number of supported video formats for a video capture device, you can call this method to get detailed video frame information for the specified index. This method is only applicable to Windows and macOS.
  ///
  /// * [deviceIdUTF8] The ID of the video capture device.
  /// * [deviceCapabilityNumber] The index of the video format. If the return value of numberOfCapabilities is i, then the valid range for this parameter is [0, i).
  ///
  /// Returns
  /// Detailed information of the specified video format, including width (px), height (px), and frame rate (fps). See VideoFormat.
  Future<VideoFormat> getCapability(
      {required String deviceIdUTF8, required int deviceCapabilityNumber});

  /// @nodoc
  Future<void> startDeviceTest(int hwnd);

  /// @nodoc
  Future<void> stopDeviceTest();

  /// Releases all resources occupied by the VideoDeviceManager object.
  ///
  /// This method is only applicable to Windows and macOS.
  Future<void> release();
}

/// Used to manage and configure video effects, such as beauty, makeup styles, and filters.
///
/// Since Available since v4.6.2.
abstract class VideoEffectObject {
  /// Adds or updates the effect for the specified video effect node and template.
  ///
  /// Since Available since v4.6.2. Priority rules:
  ///  Style makeup nodes take precedence over filter effect nodes.
  ///  To apply filter effects, you must first remove the style makeup effect node.
  ///
  /// * [nodeId] The unique identifier or combination of identifiers for the video effect node. See VideoEffectNodeId.
  /// * [templateName] Name of the effect template. If set to NULL or an empty string, the SDK loads the default configuration from the resource package.
  ///
  /// Returns
  /// 0: Method call succeeds.
  ///  < 0: Method call fails.
  Future<void> addOrUpdateVideoEffect(
      {required int nodeId, required String templateName});

  /// Removes the video effect for the specified node ID.
  ///
  /// Since Available since v4.6.2.
  ///
  /// * [nodeId] The unique identifier of the video effect node to be removed. See VideoEffectNodeId.
  ///
  /// Returns
  /// 0: Method call succeeds.
  ///  < 0: Method call fails.
  Future<void> removeVideoEffect(int nodeId);

  /// Performs an action on the specified video effect node.
  ///
  /// Since Available since v4.6.2.
  ///
  /// * [nodeId] The unique identifier of the video effect node.
  /// * [actionId] The action to perform. See VideoEffectAction.
  ///
  /// Returns
  /// 0: Method call succeeds.
  ///  < 0: Method call fails.
  Future<void> performVideoEffectAction(
      {required int nodeId, required VideoEffectAction actionId});

  /// Sets a float parameter for a video effect.
  ///
  /// Since Available since v4.6.2.
  ///
  /// * [option] The category of the parameter option.
  /// * [key] The key name of the parameter.
  /// * [param] The float value to set.
  ///
  /// Returns
  /// 0: Method call succeeds.
  ///  < 0: Method call fails.
  Future<void> setVideoEffectFloatParam(
      {required String option, required String key, required double param});

  /// setVideoEffectIntParam : Sets an integer parameter for a video effect.
  ///
  /// Since Available since v4.6.2.
  ///
  /// * [option] The category of the option to which the parameter belongs.
  /// * [key] The key name of the parameter.
  /// * [param] The integer parameter value to set.
  ///
  /// Returns
  /// 0: Method call succeeds.
  ///  < 0: Method call fails.
  Future<void> setVideoEffectIntParam(
      {required String option, required String key, required int param});

  /// Sets a boolean parameter for a video effect.
  ///
  /// Since Available since v4.6.2.
  ///
  /// * [option] The category of the parameter option.
  /// * [key] The key name of the parameter.
  /// * [param] The boolean value to set: true : Enables the option. false : Disables the option.
  ///
  /// Returns
  /// 0: Method call succeeds.
  ///  < 0: Method call fails.
  Future<void> setVideoEffectBoolParam(
      {required String option, required String key, required bool param});

  /// Gets the value of the specified float type parameter in a video effect.
  ///
  /// Since Available since v4.6.2.
  ///
  /// * [option] The category of the option to which the parameter belongs.
  /// * [key] The key name of the parameter.
  ///
  /// Returns
  /// If the parameter exists, returns the corresponding float value.
  ///  If the parameter does not exist or an error occurs, returns 0.0f.
  Future<double> getVideoEffectFloatParam(
      {required String option, required String key});

  /// Gets the integer parameter from the video effect.
  ///
  /// Since Available since v4.6.2.
  ///
  /// * [option] Category of the parameter option.
  /// * [key] Key name of the parameter.
  ///
  /// Returns
  /// If the parameter exists, returns the corresponding integer value.
  ///  If the parameter does not exist or an error occurs, returns 0.
  Future<int> getVideoEffectIntParam(
      {required String option, required String key});

  /// Gets the boolean parameter from the video effect.
  ///
  /// Since Available since v4.6.2.
  ///
  /// * [option] Category of the parameter option.
  /// * [key] Key name of the parameter.
  ///
  /// Returns
  /// true : The parameter is enabled. false : The parameter is not enabled or does not exist.
  Future<bool> getVideoEffectBoolParam(
      {required String option, required String key});
}

/// Video effect node types.
///
/// Since Available since v4.6.2.
@JsonEnum(alwaysCreate: true)
enum VideoEffectNodeId {
  /// (1): Beauty effect node.
  @JsonValue(1 << 0)
  beauty,

  /// (2): Style makeup effect node.
  @JsonValue(1 << 1)
  styleMakeup,

  /// (4): Filter effect node.
  @JsonValue(1 << 2)
  filter,

  /// @nodoc
  @JsonValue(1 << 3)
  sticker,
}

/// @nodoc
extension VideoEffectNodeIdExt on VideoEffectNodeId {
  /// @nodoc
  static VideoEffectNodeId fromValue(int value) {
    return $enumDecode(_$VideoEffectNodeIdEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$VideoEffectNodeIdEnumMap[this]!;
  }
}

/// Operation types for video effect nodes.
///
/// Since Available since v4.6.2.
@JsonEnum(alwaysCreate: true)
enum VideoEffectAction {
  /// (1): Save the current parameters of the video effect.
  @JsonValue(1)
  save,

  /// (2): Reset the video effect to default parameters.
  @JsonValue(2)
  reset,
}

/// @nodoc
extension VideoEffectActionExt on VideoEffectAction {
  /// @nodoc
  static VideoEffectAction fromValue(int value) {
    return $enumDecode(_$VideoEffectActionEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$VideoEffectActionEnumMap[this]!;
  }
}

/// Definition of RtcEngineContext.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RtcEngineContext implements AgoraSerializable {
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
      this.domainLimit,
      this.autoRegisterAgoraExtensions});

  /// The App ID issued by Agora to the app developer. Only apps using the same App ID can join the same channel for communication or live streaming. One App ID can only be used to create one RtcEngine. To change the App ID, you must first call release to destroy the current RtcEngine and then create a new one.
  @JsonKey(name: 'appId')
  final String? appId;

  /// Channel usage scenario. See ChannelProfileType.
  @JsonKey(name: 'channelProfile')
  final ChannelProfileType? channelProfile;

  /// @nodoc
  @JsonKey(name: 'license')
  final String? license;

  /// Audio scenario. Different audio scenarios correspond to different volume types on the device.
  /// See AudioScenarioType.
  @JsonKey(name: 'audioScenario')
  final AudioScenarioType? audioScenario;

  /// The region for accessing the server. This is an advanced setting suitable for scenarios with access security restrictions. Supported regions are listed in AreaCode. The region code supports bitwise operations.
  @JsonKey(name: 'areaCode')
  final int? areaCode;

  /// Sets the log files output by the SDK. See LogConfig.
  /// By default, the SDK generates 5 SDK log files and 5 API call log files, following these rules:
  @JsonKey(name: 'logConfig')
  final LogConfig? logConfig;

  /// @nodoc
  @JsonKey(name: 'threadPriority')
  final ThreadPriorityType? threadPriority;

  /// @nodoc
  @JsonKey(name: 'useExternalEglContext')
  final bool? useExternalEglContext;

  /// Whether to enable domain name restriction: true : Enable domain name restriction. This setting is suitable for IoT devices accessing the network using IoT SIM cards. The SDK will only connect to servers whose domain names or IPs are whitelisted and reported to the carrier. false : (default) Disable domain name restriction. This setting is suitable for most general scenarios.
  @JsonKey(name: 'domainLimit')
  final bool? domainLimit;

  /// Whether to automatically register Agora extensions when initializing RtcEngine : true : (default) Automatically register Agora extensions when initializing RtcEngine. false : Do not register Agora extensions when initializing RtcEngine. You need to call enableExtension to register the Agora extensions.
  @JsonKey(name: 'autoRegisterAgoraExtensions')
  final bool? autoRegisterAgoraExtensions;

  /// @nodoc
  factory RtcEngineContext.fromJson(Map<String, dynamic> json) =>
      _$RtcEngineContextFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RtcEngineContextToJson(this);
}

/// Metadata observer.
class MetadataObserver {
  /// @nodoc
  const MetadataObserver({
    this.onMetadataReceived,
  });

  /// Triggered when the receiver receives metadata.
  ///
  /// * [metadata] The received metadata. See Metadata.
  final void Function(Metadata metadata)? onMetadataReceived;
}

/// The type of Metadata for the observer. Currently, only video-type Metadata is supported.
@JsonEnum(alwaysCreate: true)
enum MetadataType {
  /// -1: Metadata type is unknown.
  @JsonValue(-1)
  unknownMetadata,

  /// 0: Metadata type is video.
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
class Metadata implements AgoraSerializable {
  /// @nodoc
  const Metadata(
      {this.channelId, this.uid, this.size, this.buffer, this.timeStampMs});

  /// Channel name.
  @JsonKey(name: 'channelId')
  final String? channelId;

  /// User ID.
  ///  For receivers: the ID of the remote user who sent this Metadata.
  ///  For senders: ignore this field.
  @JsonKey(name: 'uid')
  final int? uid;

  /// The buffer size of the received or sent Metadata.
  @JsonKey(name: 'size')
  final int? size;

  /// The buffer address of the received Metadata.
  @JsonKey(name: 'buffer', ignore: true)
  final Uint8List? buffer;

  /// The timestamp when the Metadata is sent, in milliseconds.
  @JsonKey(name: 'timeStampMs')
  final int? timeStampMs;

  /// @nodoc
  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}

/// Reason for CDN streaming state changes.
///
/// Deprecated Deprecated since v4.6.2.
@JsonEnum(alwaysCreate: true)
enum DirectCdnStreamingReason {
  /// 0: Streaming status is normal.
  @JsonValue(0)
  directCdnStreamingReasonOk,

  /// 1: General error with no specific reason. You can try streaming again.
  @JsonValue(1)
  directCdnStreamingReasonFailed,

  /// 2: Audio streaming error. For example, the local audio capture device is not working properly, occupied by another process, or lacks permission.
  @JsonValue(2)
  directCdnStreamingReasonAudioPublication,

  /// 3: Video streaming error. For example, the local video capture device is not working properly, occupied by another process, or lacks permission.
  @JsonValue(3)
  directCdnStreamingReasonVideoPublication,

  /// 4: Failed to connect to CDN.
  @JsonValue(4)
  directCdnStreamingReasonNetConnect,

  /// 5: The URL has already been used for streaming. Please use a new URL.
  @JsonValue(5)
  directCdnStreamingReasonBadName,
}

/// @nodoc
extension DirectCdnStreamingReasonExt on DirectCdnStreamingReason {
  /// @nodoc
  static DirectCdnStreamingReason fromValue(int value) {
    return $enumDecode(_$DirectCdnStreamingReasonEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$DirectCdnStreamingReasonEnumMap[this]!;
  }
}

/// Current CDN streaming state.
///
/// Deprecated Deprecated since v4.6.2.
@JsonEnum(alwaysCreate: true)
enum DirectCdnStreamingState {
  /// 0: Initial state, streaming has not started yet.
  @JsonValue(0)
  directCdnStreamingStateIdle,

  /// 1: Streaming is in progress. When you call startDirectCdnStreaming and streaming starts successfully, the SDK returns this value.
  @JsonValue(1)
  directCdnStreamingStateRunning,

  /// 2: Streaming has ended normally. When you call stopDirectCdnStreaming to stop streaming proactively, the SDK returns this value.
  @JsonValue(2)
  directCdnStreamingStateStopped,

  /// 3: Streaming failed. You can troubleshoot the issue using the information reported in the onDirectCdnStreamingStateChanged callback, and then restart streaming.
  @JsonValue(3)
  directCdnStreamingStateFailed,

  /// 4: Attempting to reconnect to the Agora server and CDN. Will retry up to 10 times. If reconnection still fails, the streaming state changes to directCdnStreamingStateFailed.
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

/// Statistics of the current CDN streaming.
///
/// Deprecated Deprecated since v4.6.2.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class DirectCdnStreamingStats implements AgoraSerializable {
  /// @nodoc
  const DirectCdnStreamingStats(
      {this.videoWidth,
      this.videoHeight,
      this.fps,
      this.videoBitrate,
      this.audioBitrate});

  /// Width of the video (px).
  @JsonKey(name: 'videoWidth')
  final int? videoWidth;

  /// Height of the video (px).
  @JsonKey(name: 'videoHeight')
  final int? videoHeight;

  /// Current video frame rate (fps).
  @JsonKey(name: 'fps')
  final int? fps;

  /// Current video bitrate (bps).
  @JsonKey(name: 'videoBitrate')
  final int? videoBitrate;

  /// Current audio bitrate (bps).
  @JsonKey(name: 'audioBitrate')
  final int? audioBitrate;

  /// @nodoc
  factory DirectCdnStreamingStats.fromJson(Map<String, dynamic> json) =>
      _$DirectCdnStreamingStatsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DirectCdnStreamingStatsToJson(this);
}

/// DirectCdnStreamingEventHandler interface class is used by the SDK to send CDN streaming event notifications to the app. The app receives SDK event notifications by inheriting methods of this interface.
class DirectCdnStreamingEventHandler {
  /// @nodoc
  const DirectCdnStreamingEventHandler({
    this.onDirectCdnStreamingStateChanged,
    this.onDirectCdnStreamingStats,
  });

  /// Callback for changes in CDN streaming state.
  ///
  /// After the host starts pushing streams directly to the CDN, when the streaming state changes, the SDK triggers this callback to report the new state, error code, and message. You can use this information for troubleshooting.
  ///
  /// * [state] Current streaming state. See DirectCdnStreamingState.
  /// * [reason] Reason for the change in streaming state. See DirectCdnStreamingReason.
  /// * [message] Message corresponding to the state change.
  final void Function(
      DirectCdnStreamingState state,
      DirectCdnStreamingReason reason,
      String message)? onDirectCdnStreamingStateChanged;

  /// Callback for CDN streaming statistics.
  ///
  /// During the process of pushing streams directly from the host to the CDN, the SDK triggers this callback once every second.
  ///
  /// * [stats] Current streaming statistics. See DirectCdnStreamingStats.
  final void Function(DirectCdnStreamingStats stats)? onDirectCdnStreamingStats;
}

/// Media options for the host.
///
/// Deprecated Deprecated since v4.6.2.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class DirectCdnStreamingMediaOptions implements AgoraSerializable {
  /// @nodoc
  const DirectCdnStreamingMediaOptions(
      {this.publishCameraTrack,
      this.publishMicrophoneTrack,
      this.publishCustomAudioTrack,
      this.publishCustomVideoTrack,
      this.publishMediaPlayerAudioTrack,
      this.publishMediaPlayerId,
      this.customVideoTrackId});

  /// Sets whether to publish video captured by the camera. true : Publish video captured by the camera. false : (Default) Do not publish video captured by the camera.
  @JsonKey(name: 'publishCameraTrack')
  final bool? publishCameraTrack;

  /// Sets whether to publish audio captured by the microphone. true : Publish audio captured by the microphone. false : (Default) Do not publish audio captured by the microphone.
  @JsonKey(name: 'publishMicrophoneTrack')
  final bool? publishMicrophoneTrack;

  /// Sets whether to publish custom captured audio. true : Publish custom captured audio. false : (Default) Do not publish custom captured audio.
  @JsonKey(name: 'publishCustomAudioTrack')
  final bool? publishCustomAudioTrack;

  /// Sets whether to publish custom captured video. true : Publish custom captured video. false : (Default) Do not publish custom captured video.
  @JsonKey(name: 'publishCustomVideoTrack')
  final bool? publishCustomVideoTrack;

  /// @nodoc
  @JsonKey(name: 'publishMediaPlayerAudioTrack')
  final bool? publishMediaPlayerAudioTrack;

  /// @nodoc
  @JsonKey(name: 'publishMediaPlayerId')
  final int? publishMediaPlayerId;

  /// The video track ID returned by the createCustomVideoTrack method. Default value is 0.
  @JsonKey(name: 'customVideoTrackId')
  final int? customVideoTrackId;

  /// @nodoc
  factory DirectCdnStreamingMediaOptions.fromJson(Map<String, dynamic> json) =>
      _$DirectCdnStreamingMediaOptionsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DirectCdnStreamingMediaOptionsToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ExtensionInfo implements AgoraSerializable {
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

  @override
  Map<String, dynamic> toJson() => _$ExtensionInfoToJson(this);
}

/// The base interface class of the RTC SDK that implements core real-time audio and video features.
///
/// RtcEngine provides the main methods for app calls.
/// You must call createAgoraRtcEngine to create a RtcEngine object before calling other APIs.
abstract class RtcEngine {
  /// Initializes the RtcEngine.
  ///
  /// All interface functions of the RtcEngine class are asynchronous unless otherwise specified. It is recommended to call the interfaces in the same thread.
  /// The SDK only supports creating one RtcEngine instance per App.
  ///
  /// * [context] Configuration for the RtcEngine instance. See RtcEngineContext.
  ///
  /// Returns
  /// No return value if the method call succeeds; if the method call fails, an AgoraRtcException is thrown, which you need to catch and handle. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and troubleshooting suggestions.
  ///  < 0: Failure.
  ///  -1: General error (not specifically categorized).
  ///  -2: Invalid parameter.
  ///  -7: SDK initialization failed.
  ///  -22: Resource allocation failed. This occurs when the App uses too many resources or system resources are exhausted.
  ///  -101: Invalid App ID.
  Future<void> initialize(RtcEngineContext context);

  /// Gets the SDK version.
  ///
  /// Returns
  /// SDKBuildInfo object.
  Future<SDKBuildInfo> getVersion();

  /// Gets the warning or error description.
  ///
  /// * [code] Error code reported by the SDK.
  ///
  /// Returns
  /// Specific error description.
  Future<String> getErrorDescription(int code);

  /// Queries the video codec capabilities supported by the SDK.
  ///
  /// * [size] The size of CodecCapInfo.
  ///
  /// Returns
  /// If the call succeeds, returns an array of CodecCapInfo, indicating the SDK's video encoding capabilities.
  ///  If the call times out, modify your call logic and avoid calling this method on the main thread.
  Future<List<CodecCapInfo>> queryCodecCapability(int size);

  /// Queries the device score level.
  ///
  /// Returns
  /// When the method call succeeds, it returns a value in the range [0,100], indicating the score level of the current device. A higher value indicates better device capability. Most devices score between 60 and 100. When the method call fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: The method call fails.
  Future<int> queryDeviceScore();

  /// Preloads a channel using token, channelId, and uid.
  ///
  /// Calling this method reduces the time it takes for an audience member to join a channel when switching channels frequently, thereby shortening the time to hear the first audio frame and see the first video frame from the host, and improving the audience's video experience.
  /// If the current channel has already been successfully preloaded, and the audience leaves and rejoins the channel, as long as the Token passed during preloading is still valid, re-preloading is not required. Preloading failure does not affect normal channel joining later, nor does it increase the time to join the channel.
  ///  When calling this method, ensure the user role is set to audience and the audio scenario is not chorus (audioScenarioChorus), otherwise preloading will not take effect.
  ///  Ensure the channel name, user ID, and Token passed during preloading are the same as those used when joining the channel later; otherwise, preloading will not take effect.
  ///  Currently, a single RtcEngine instance supports preloading up to 20 channels. If this limit is exceeded, only the latest 20 preloaded channels take effect.
  ///
  /// * [token] A dynamic key generated on your server for authentication. See [Token Authentication](https://doc.shengwang.cn/doc/rtc/flutter/basic-features/token-authentication).
  /// When the Token expires, depending on the number of preloaded channels, you can pass in a new Token for preloading in different ways:
  ///  For a single channel: call this method again with the new Token.
  ///  For multiple channels:
  ///  If you use a wildcard Token, call updatePreloadChannelToken to update the Token for all preloaded channels. When generating a wildcard Token, the user ID must not be set to 0. See [Wildcard Token](https://doc.shengwang.cn/doc/rtc/flutter/best-practice/wildcard-token).
  ///  If you use different Tokens: call this method and pass in your user ID, corresponding channel name, and the updated Token.
  /// * [channelId] The name of the channel to preload. This parameter identifies the channel for real-time audio and video communication. Under the same App ID, users who enter the same channel name will join the same channel for audio and video interaction.
  /// This parameter must be a string no longer than 64 bytes. Supported character set (89 characters total):
  ///  26 lowercase letters a~z
  ///  26 uppercase letters A~Z
  ///  10 digits 0~9
  ///  "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","
  /// * [uid] User ID. This parameter identifies the user in the real-time audio and video channel. You need to set and manage the user ID yourself and ensure it is unique within the same channel. This parameter is a 32-bit unsigned integer. Recommended range: 1 to 2^32-1. If not specified (i.e., set to 0), the SDK automatically assigns one and returns it in the onJoinChannelSuccess callback. The application must store and manage this return value, as the SDK does not maintain it.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: The method call fails. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  -7: The RtcEngine object is not initialized. You need to initialize the RtcEngine object before calling this method.
  ///  -102: Invalid channel name. You need to enter a valid channel name and rejoin the channel.
  Future<void> preloadChannel(
      {required String token, required String channelId, required int uid});

  /// Preloads a channel using token, channelId, and userAccount.
  ///
  /// Calling this method reduces the time it takes for an audience member to join a channel when switching channels frequently, thereby shortening the time to hear the first audio frame and see the first video frame from the host, and improving the audience's video experience.
  /// If the current channel has already been successfully preloaded, and the audience leaves and rejoins the channel, as long as the Token passed during preloading is still valid, re-preloading is not required. Preloading failure does not affect normal channel joining later, nor does it increase the time to join the channel.
  ///  When calling this method, ensure the user role is set to audience and the audio scenario is not chorus (audioScenarioChorus), otherwise preloading will not take effect.
  ///  Ensure the channel name, user account, and Token passed during preloading are the same as those used when joining the channel later; otherwise, preloading will not take effect.
  ///  Currently, a single RtcEngine instance supports preloading up to 20 channels. If this limit is exceeded, only the latest 20 preloaded channels take effect.
  ///
  /// * [token] A dynamic key generated on your server for authentication. See [Token Authentication](https://doc.shengwang.cn/doc/rtc/flutter/basic-features/token-authentication).
  /// When the Token expires, depending on the number of preloaded channels, you can pass in a new Token for preloading in different ways:
  ///  For a single channel: call this method again with the new Token.
  ///  For multiple channels:
  ///  If you use a wildcard Token, call updatePreloadChannelToken to update the Token for all preloaded channels. When generating a wildcard Token, the user ID must not be set to 0. See [Wildcard Token](https://doc.shengwang.cn/doc/rtc/flutter/best-practice/wildcard-token).
  ///  If you use different Tokens: call this method and pass in your user ID, corresponding channel name, and the updated Token.
  /// * [channelId] The name of the channel to preload. This parameter identifies the channel for real-time audio and video communication. Under the same App ID, users who enter the same channel name will join the same channel for audio and video interaction.
  /// This parameter must be a string no longer than 64 bytes. Supported character set (89 characters total):
  ///  26 lowercase letters a~z
  ///  26 uppercase letters A~Z
  ///  10 digits 0~9
  ///  "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","
  /// * [userAccount] User account. This parameter identifies the user in the real-time audio and video channel. You need to set and manage the user account yourself and ensure it is unique within the same channel. This parameter is required, must not exceed 255 bytes, and cannot be null. Supported character set (89 characters total):
  ///  26 lowercase letters a-z
  ///  26 uppercase letters A-Z
  ///  10 digits 0-9
  ///  Space
  ///  "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: The method call fails. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  -2: Invalid parameter. For example, the user account is empty. You need to enter a valid parameter and rejoin the channel.
  ///  -7: The RtcEngine object is not initialized. You need to initialize the RtcEngine object before calling this method.
  ///  -102: Invalid channel name. You need to enter a valid channel name and rejoin the channel.
  Future<void> preloadChannelWithUserAccount(
      {required String token,
      required String channelId,
      required String userAccount});

  /// Updates the wildcard token for the preloaded channel.
  ///
  /// You need to manage the lifecycle of the wildcard token yourself. When the wildcard token expires, you need to generate a new one on your server and pass it in using this method.
  ///
  /// * [token] The new token.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> updatePreloadChannelToken(String token);

  /// Sets media options and joins a channel.
  ///
  /// This method allows you to set media options when joining a channel, such as whether to publish audio and video streams in the channel. By default, users subscribe to all remote audio and video streams in the channel, which may incur usage and affect billing. If you want to unsubscribe, you can do so by setting the options parameter or using the corresponding mute methods.
  ///  This method only supports joining one channel at a time.
  ///  Apps with different App IDs cannot communicate with each other.
  ///  Before joining a channel, ensure that the App ID used to generate the Token is the same as the one used in the initialize method to initialize the engine. Otherwise, joining the channel using the Token will fail.
  ///
  /// * [token] The dynamic key generated on your server for authentication. See [Token Authentication](https://doc.shengwang.cn/doc/rtc/flutter/basic-features/token-authentication).
  ///  (Recommended) If your project enables security mode (i.e., uses APP ID + Token for authentication), this parameter is required.
  ///  If your project only enables debug mode (i.e., uses APP ID for authentication), you can join a channel without providing a Token. You will automatically leave the channel after 24 hours.
  ///  If you need to join multiple channels at once or frequently switch between channels, Agora recommends using a wildcard Token to avoid requesting a new Token from your server for each new channel. See [Wildcard Token](https://doc.shengwang.cn/doc/rtc/flutter/best-practice/wildcard-token).
  /// * [channelId] The channel name. This parameter identifies the channel for real-time audio and video interaction. Users with the same App ID and channel name will join the same channel. This parameter must be a string of up to 64 bytes. Supported character set (89 characters):
  ///  26 lowercase letters a~z
  ///  26 uppercase letters A~Z
  ///  10 digits 0~9
  ///  "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","
  /// * [uid] User ID. This parameter identifies the user in the real-time audio and video interaction channel. You must set and manage the user ID yourself and ensure that each user ID is unique within the same channel. This parameter is a 32-bit unsigned integer. Recommended range: 1 to 2^32-1. If not specified (i.e., set to 0), the SDK automatically assigns one and returns it in the onJoinChannelSuccess callback. The application must remember and maintain this return value; the SDK does not maintain it.
  /// * [options] Channel media options. See ChannelMediaOptions.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when it fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Method call failed. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  -2: Invalid parameters. For example, an invalid Token, uid is not an integer, or ChannelMediaOptions contains invalid values. Provide valid parameters and rejoin the channel.
  ///  -3: RtcEngine initialization failed. Reinitialize the RtcEngine object.
  ///  -7: RtcEngine not initialized. Initialize the RtcEngine object before calling this method.
  ///  -8: Internal state error in RtcEngine. Possible cause: startEchoTest was called but stopEchoTest was not called before joining the channel. Call stopEchoTest before this method.
  ///  -17: Join channel rejected. Possible cause: user is already in the channel. Use onConnectionStateChanged to check if the user is in the channel. Do not call this method again unless you receive connectionStateDisconnected (1).
  ///  -102: Invalid channel name. Provide a valid channelId and rejoin the channel.
  ///  -121: Invalid user ID. Provide a valid uid and rejoin the channel.
  Future<void> joinChannel(
      {required String token,
      required String channelId,
      required int uid,
      required ChannelMediaOptions options});

  /// Updates channel media options after joining the channel.
  ///
  /// * [options] Channel media options. See ChannelMediaOptions.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> updateChannelMediaOptions(ChannelMediaOptions options);

  /// Sets channel options and leaves the channel.
  ///
  /// After calling this method, the SDK stops audio and video interaction, leaves the current channel, and releases all session-related resources.
  /// After successfully joining a channel, you must call this method to end the call; otherwise, you cannot start a new call. If you have joined multiple channels using joinChannelEx, calling this method will leave all joined channels. This method is asynchronous. When the method returns, the user has not actually left the channel yet.
  /// If you call the release method immediately after this method, the SDK will not trigger the onLeaveChannel callback.
  ///
  /// * [options] Options for leaving the channel. See LeaveChannelOptions.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when it fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> leaveChannel({LeaveChannelOptions? options});

  /// Updates the token.
  ///
  /// This method is used to update the token. The token expires after a certain period, at which point the SDK cannot establish a connection with the server.
  ///
  /// * [token] The newly generated token.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> renewToken(String token);

  /// Sets the channel profile.
  ///
  /// You can call this method to set the channel profile. The SDK adopts different optimization strategies for different use cases, such as prioritizing video quality in live streaming scenarios. The default channel profile after SDK initialization is live streaming. To ensure real-time audio and video quality, all users in the same channel must use the same channel profile.
  ///
  /// * [profile] Channel profile. See ChannelProfileType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Failure. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  -2: Invalid parameter.
  ///  -7: SDK not initialized.
  Future<void> setChannelProfile(ChannelProfileType profile);

  /// Sets the user role and audience latency level in live streaming.
  ///
  /// By default, the SDK sets the user role to audience. You can call this method to set the user role to broadcaster. The user role (role) determines the user's privileges at the SDK level, such as whether they can publish streams. When the user role is set to broadcaster, the audience latency level only supports audienceLatencyLevelUltraLowLatency (ultra-low latency).
  /// If you call this method before joining a channel and set role to BROADCASTER, the local user will not receive the onClientRoleChanged callback.
  ///
  /// * [role] User role. See ClientRoleType. Users with the audience role cannot publish audio or video streams in the channel. When publishing in live streaming, make sure the user role is switched to broadcaster.
  /// * [options] User-specific settings, including user level. See ClientRoleOptions.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setClientRole(
      {required ClientRoleType role, ClientRoleOptions? options});

  /// Starts an audio and video call loop test.
  ///
  /// To test whether the user's local stream sending and receiving works properly, you can call this method to perform an audio and video call loop test, which checks whether the system's audio and video devices and the user's uplink and downlink networks are functioning correctly.
  /// After the test starts, the user needs to speak or face the camera. The audio or video will play back after about 2 seconds. If audio plays back correctly, it indicates that the system audio devices and the user's uplink and downlink networks are working properly; if video plays back correctly, it indicates that the system video devices and the user's uplink and downlink networks are working properly.
  ///  When calling this method in a channel, ensure that no audio or video stream is being published.
  ///  After calling this method, you must call stopEchoTest to end the test. Otherwise, the user cannot perform another loop test or join a channel.
  ///  In a live broadcast scenario, only hosts can call this method.
  ///
  /// * [config] Configuration for the audio and video call loop test. See EchoTestConfiguration.
  ///
  /// Returns
  /// 0: Success.
  ///  < 0: Failure. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> startEchoTest(EchoTestConfiguration config);

  /// Stops the audio call loopback test.
  ///
  /// After calling startEchoTest, you must call this method to end the test. Otherwise, the user cannot perform another audio/video loopback test or join a channel.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> stopEchoTest();

  /// Enables or disables multi-camera capture.
  ///
  /// In scenarios where a video is already being captured using a camera, Agora recommends the following steps to achieve multi-camera capture and publish video:
  ///  Call this method to enable multi-camera capture.
  ///  Call startPreview to start local video preview.
  ///  Call startCameraCapture and set sourceType to specify the second camera for capture.
  ///  Call joinChannelEx and set publishSecondaryCameraTrack to true to publish the second camera's video stream in the channel. To disable multi-camera capture, refer to the following steps:
  ///  Call stopCameraCapture.
  ///  Call this method and set enabled to false. This method is only applicable to iOS. When using multi-camera capture, ensure the system version is 13.0 or above. The minimum supported iOS device models for multi-camera capture are as follows:
  ///  iPhone XR
  ///  iPhone XS
  ///  iPhone XS Max
  ///  iPad Pro (3rd generation and later) You can call this method to enable multi-camera capture either before or after startPreview :
  ///  If called before startPreview, the local video preview will display feeds from both cameras simultaneously.
  ///  If called after startPreview, the SDK will stop the current camera capture first, then start both the original and the second camera. The local video preview may briefly go black before automatically recovering.
  ///
  /// * [enabled] Whether to enable multi-camera video capture mode: true : Enables multi-camera capture mode. The SDK uses multiple cameras to capture video. false : Disables multi-camera capture mode. The SDK uses only a single camera to capture video.
  /// * [config] Configuration for the second camera. See CameraCapturerConfiguration.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> enableMultiCamera(
      {required bool enabled, required CameraCapturerConfiguration config});

  /// Enables the video module.
  ///
  /// The video module is disabled by default. You need to call this method to enable it. To disable the video module later, call the disableVideo method.
  ///  This method sets the internal engine to an enabled state and remains effective after leaving the channel.
  ///  Calling this method resets the entire engine and may take longer to respond. You can use the following methods to control specific video functions as needed: enableLocalVideo : Whether to enable camera capture and create the local video stream. muteLocalVideoStream : Whether to publish the local video stream. muteRemoteVideoStream : Whether to receive and play the remote video stream. muteAllRemoteVideoStreams : Whether to receive and play all remote video streams.
  ///  When called in a channel, this method resets the settings of enableLocalVideo, muteRemoteVideoStream, and muteAllRemoteVideoStreams. Use with caution.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> enableVideo();

  /// Disables the video module.
  ///
  /// This method disables the video module.
  ///  This method sets the internal engine to a disabled state and remains effective after leaving the channel.
  ///  Calling this method resets the entire engine and may take longer to respond. You can use the following methods to control specific video functions as needed: enableLocalVideo : Whether to enable camera capture and create the local video stream. muteLocalVideoStream : Whether to publish the local video stream. muteRemoteVideoStream : Whether to receive and play the remote video stream. muteAllRemoteVideoStreams : Whether to receive and play all remote video streams.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> disableVideo();

  /// Starts video preview and specifies the video source.
  ///
  /// This method starts the local video preview and specifies the video source to appear in the preview.
  ///  Local preview enables mirror mode by default.
  ///  After leaving the channel, local preview remains active. You need to call stopPreview to stop the local preview.
  ///
  /// * [sourceType] Type of the video source. See VideoSourceType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> startPreview(
      {VideoSourceType sourceType = VideoSourceType.videoSourceCameraPrimary});

  /// Stops video preview.
  ///
  /// * [sourceType] Type of the video source. See VideoSourceType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Failure. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> stopPreview(
      {VideoSourceType sourceType = VideoSourceType.videoSourceCameraPrimary});

  /// Starts the last-mile network probe test before a call.
  ///
  /// Starts the last-mile network probe test to report the uplink and downlink bandwidth, packet loss, jitter, and round-trip time to the user.
  ///
  /// * [config] Configuration for the last-mile network probe. See LastmileProbeConfig.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> startLastmileProbeTest(LastmileProbeConfig config);

  /// Stops the last-mile network probe test before a call.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> stopLastmileProbeTest();

  /// Sets the video encoding attributes.
  ///
  /// Sets the encoding attributes for the local video. Each video encoding profile corresponds to a set of video parameters, including resolution, frame rate, and bitrate.
  ///  The config parameter of this method defines the maximum values achievable under ideal network conditions. If the network condition is poor, the video engine will not use this config to render the local video and will automatically downgrade to a more appropriate video configuration.
  ///
  /// * [config] Video encoding configuration. See VideoEncoderConfiguration.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setVideoEncoderConfiguration(VideoEncoderConfiguration config);

  /// Sets beauty effect options.
  ///
  /// Enables local beauty effects and sets the beauty effect options.
  ///  This method depends on the video enhancement dynamic library libagora_clear_vision_extension.dll. Deleting this library will cause the feature to fail to start.
  ///  This feature requires high device performance. When calling this method, the SDK automatically checks the current device capabilities.
  ///
  /// * [enabled] Whether to enable the beauty effect: true : Enable the beauty effect. false : (Default) Disable the beauty effect.
  /// * [options] Beauty options. See BeautyOptions for details.
  /// * [type] The media source type to which the effect is applied. See MediaSourceType. In this method, this parameter only supports the following two settings:
  ///  When capturing local video using the camera, keep the default value primaryCameraSource.
  ///  To use custom captured video, set this parameter to customVideoSource.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setBeautyEffectOptions(
      {required bool enabled,
      required BeautyOptions options,
      MediaSourceType type = MediaSourceType.primaryCameraSource});

  /// Sets face shaping effect options and specifies the media source.
  ///
  /// Call this method to enhance facial features such as slimming the face, enlarging eyes, slimming the nose, etc., using preset parameters in one go. You can also adjust the overall intensity of the effect. Face shaping is a value-added service. See [Billing Strategy](https://doc.shengwang.cn/doc/rtc/android/billing/billing-strategy) for pricing details.
  ///  On Android, this method is only supported on Android 4.4 and above.
  ///  This method depends on the video enhancement dynamic library libagora_clear_vision_extension.dll. Deleting this library will cause the feature to fail to start.
  ///  This feature requires high device performance. When calling this method, the SDK automatically checks the current device capabilities.
  ///
  /// * [enabled] Whether to enable the face shaping effect: true : Enable face shaping. false : (Default) Disable face shaping.
  /// * [options] Face shaping style options. See FaceShapeBeautyOptions.
  /// * [type] The media source type to which the effect is applied. See MediaSourceType. In this method, this parameter only supports the following two settings:
  ///  When capturing local video using the camera, keep the default value primaryCameraSource.
  ///  To use custom captured video, set this parameter to customVideoSource.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setFaceShapeBeautyOptions(
      {required bool enabled,
      required FaceShapeBeautyOptions options,
      MediaSourceType type = MediaSourceType.primaryCameraSource});

  /// Sets face shaping area options and specifies the media source.
  ///
  /// If the preset face shaping effects set with setFaceShapeBeautyOptions do not meet expectations, you can use this method to configure face shaping area options and fine-tune individual facial areas for more refined results. Face shaping is a value-added service. See [Billing Strategy](https://doc.shengwang.cn/doc/rtc/android/billing/billing-strategy) for pricing details.
  ///  On Android, this method is only supported on Android 4.4 and above.
  ///  This method depends on the video enhancement dynamic library libagora_clear_vision_extension.dll. Deleting this library will cause the feature to fail to start.
  ///  This feature requires high device performance. When calling this method, the SDK automatically checks the current device capabilities.
  ///
  /// * [options] Face shaping area options. See FaceShapeAreaOptions.
  /// * [type] The media source type to which the effect is applied. See MediaSourceType. In this method, this parameter only supports the following two settings:
  ///  When capturing local video using the camera, keep the default value primaryCameraSource.
  ///  To use custom captured video, set this parameter to customVideoSource.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setFaceShapeAreaOptions(
      {required FaceShapeAreaOptions options,
      MediaSourceType type = MediaSourceType.primaryCameraSource});

  /// Gets face shaping effect options.
  ///
  /// Call this method to get the current parameter settings of the face shaping effect.
  ///
  /// * [type] The media source type to which the effect is applied. See MediaSourceType. In this method, this parameter only supports the following two settings:
  ///  When capturing local video using the camera, keep the default value primaryCameraSource.
  ///  To use custom captured video, set this parameter to customVideoSource.
  ///
  /// Returns
  /// Returns a FaceShapeBeautyOptions object if the method call succeeds; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<FaceShapeBeautyOptions> getFaceShapeBeautyOptions(
      {MediaSourceType type = MediaSourceType.primaryCameraSource});

  /// Gets face shaping area options.
  ///
  /// Call this method to get the current parameter settings of the face shaping area.
  ///
  /// * [shapeArea] The face shaping area. See FaceShapeArea.
  /// * [type] The media source type to which the effect is applied. See MediaSourceType. In this method, this parameter only supports the following two settings:
  ///  When using the camera to capture local video, keep the default value primaryCameraSource.
  ///  To use custom captured video, set this parameter to customVideoSource.
  ///
  /// Returns
  /// If the method call succeeds, returns a FaceShapeAreaOptions object; if it fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<FaceShapeAreaOptions> getFaceShapeAreaOptions(
      {required FaceShapeArea shapeArea,
      MediaSourceType type = MediaSourceType.primaryCameraSource});

  /// Sets filter effect options and specifies the media source.
  ///
  /// This method depends on the video enhancement dynamic library libagora_clear_vision_extension.dll. If this library is removed, the feature cannot be enabled properly.
  ///  This feature has high performance requirements. When this method is called, the SDK automatically checks the current device capabilities.
  ///
  /// * [enabled] Whether to enable the filter effect: true : Enables the filter feature. false : (Default) Disables the filter feature.
  /// * [options] Filter options. See FilterEffectOptions.
  /// * [type] The type of media source to which the effect is applied. See MediaSourceType. In this method, this parameter only supports the following two settings:
  ///  When using the camera to capture local video, keep the default value primaryCameraSource.
  ///  If you want to use custom captured video, set this parameter to customVideoSource.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setFilterEffectOptions(
      {required bool enabled,
      required FilterEffectOptions options,
      MediaSourceType type = MediaSourceType.primaryCameraSource});

  /// Creates an IVideoEffectObject video effect object.
  ///
  /// Since Available since v4.6.2.
  ///
  /// * [bundlePath] Path to the video effect resource package.
  /// * [type] Media source type. See MediaSourceType.
  ///
  /// Returns
  /// If the method call succeeds, returns a pointer to the IVideoEffectObject object. See IVideoEffectObject.
  ///  If the method call fails, returns NULL.
  Future<VideoEffectObject?> createVideoEffectObject(
      {required String bundlePath,
      MediaSourceType type = MediaSourceType.primaryCameraSource});

  /// Destroys the video effect object.
  ///
  /// Since Available since v4.6.2.
  ///
  /// * [videoEffectObject] The video effect object to destroy. See VideoEffectObject.
  ///
  /// Returns
  /// 0: The method call succeeds.
  ///  < 0: The method call fails.
  Future<void> destroyVideoEffectObject(VideoEffectObject videoEffectObject);

  /// Sets the low-light enhancement feature.
  ///
  /// You can call this method to enable the low-light enhancement feature and configure its effects.
  ///  This method depends on the video enhancement dynamic library libagora_clear_vision_extension.dll. If this library is removed, the feature cannot be enabled properly.
  ///  Low-light enhancement has certain performance requirements. After enabling it, if the device experiences severe overheating, it is recommended to lower the enhancement level to a less performance-intensive one or disable the feature.
  ///  To achieve high-quality low-light enhancement (lowLightEnhanceLevelHighQuality), you must first call setVideoDenoiserOptions to enable video denoising. The corresponding settings are:
  ///  For automatic mode (LowLightEnhanceAuto), video denoising must be set to high quality (videoDenoiserLevelHighQuality) and automatic mode (videoDenoiserAuto).
  ///  For manual mode (LowLightEnhanceManual), video denoising must be set to high quality (videoDenoiserLevelHighQuality) and manual mode (videoDenoiserManual).
  ///
  /// * [enabled] Whether to enable the low-light enhancement feature: true : Enables low-light enhancement. false : (Default) Disables low-light enhancement.
  /// * [options] Low-light enhancement options for configuring the effect. See LowlightEnhanceOptions.
  /// * [type] The type of media source to which the effect is applied. See MediaSourceType. In this method, this parameter only supports the following two settings:
  ///  When using the camera to capture local video, keep the default value primaryCameraSource.
  ///  If you want to use custom captured video, set this parameter to customVideoSource.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setLowlightEnhanceOptions(
      {required bool enabled,
      required LowlightEnhanceOptions options,
      MediaSourceType type = MediaSourceType.primaryCameraSource});

  /// Sets the video denoising feature.
  ///
  /// You can call this method to enable the video denoising feature and configure its effects. If the denoising strength provided by this method does not meet your needs, Agora recommends calling the setBeautyEffectOptions method to enable the skin smoothing feature for better video denoising. Recommended BeautyOptions settings for strong denoising: lighteningContrastLevel : lighteningContrastNormal lighteningLevel : 0.0 smoothnessLevel : 0.5 rednessLevel : 0.0 sharpnessLevel : 0.1
  ///  This method depends on the video enhancement dynamic library libagora_clear_vision_extension.dll. If this library is removed, the feature cannot be enabled properly.
  ///  Video denoising has certain performance requirements. After enabling it, if the device experiences severe overheating, it is recommended to lower the denoising level to a less performance-intensive one or disable the feature.
  ///
  /// * [enabled] Whether to enable the video denoising feature: true : Enables video denoising. false : (Default) Disables video denoising.
  /// * [options] Video denoising options for configuring the effect. See VideoDenoiserOptions.
  /// * [type] The type of media source to which the effect is applied. See MediaSourceType. In this method, this parameter only supports the following two settings:
  ///  When using the camera to capture local video, keep the default value primaryCameraSource.
  ///  If you want to use custom captured video, set this parameter to customVideoSource.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setVideoDenoiserOptions(
      {required bool enabled,
      required VideoDenoiserOptions options,
      MediaSourceType type = MediaSourceType.primaryCameraSource});

  /// Sets the color enhancement feature.
  ///
  /// The video captured by the camera may suffer from color distortion. The color enhancement feature can intelligently adjust video characteristics such as saturation and contrast to improve color richness and accuracy, making the video more vivid.
  /// You can call this method to enable color enhancement and set the enhancement effect.
  ///  Call this method after enableVideo.
  ///  Color enhancement requires a certain level of device performance. After enabling it, if the device overheats or encounters other issues, it is recommended to lower the enhancement level or disable the feature.
  ///  This method depends on the video enhancement dynamic library libagora_clear_vision_extension.dll. Deleting this library will cause the feature to fail to start.
  ///
  /// * [enabled] Whether to enable the color enhancement feature: true : Enable color enhancement. false : (Default) Disable color enhancement.
  /// * [options] Color enhancement options used to configure the enhancement effect. See ColorEnhanceOptions.
  /// * [type] The media source type to which the effect is applied. See MediaSourceType. In this method, this parameter only supports the following two settings:
  ///  When capturing local video using the camera, keep the default value primaryCameraSource.
  ///  To use custom captured video, set this parameter to customVideoSource.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setColorEnhanceOptions(
      {required bool enabled,
      required ColorEnhanceOptions options,
      MediaSourceType type = MediaSourceType.primaryCameraSource});

  /// Enables/disables virtual background.
  ///
  /// The virtual background feature allows replacing the original background of the local user with a static image, dynamic video, blurring the background, or segmenting the portrait from the background to achieve picture-in-picture effects. After successfully enabling the virtual background feature, all users in the channel can see the customized background.
  /// Call this method after enableVideo or startPreview.
  ///  Using video as a virtual background may cause continuous memory usage growth, which can lead to app crashes. Therefore, try to reduce the resolution and frame rate of the video when using it.
  ///  This feature has high performance requirements. The SDK automatically checks the current device capability when calling this method. It is recommended to use it on devices with the following chipsets:
  ///  Snapdragon 700 series 750G and above
  ///  Snapdragon 800 series 835 and above
  ///  Dimensity 700 series 720 and above
  ///  Kirin 800 series 810 and above
  ///  Kirin 900 series 980 and above
  ///  Devices with A9 and above chips:
  ///  iPhone 6S and above
  ///  iPad Air 3rd generation and above
  ///  iPad 5th generation and above
  ///  iPad Pro 1st generation and above
  ///  iPad mini 5th generation and above
  ///  It is recommended to use this feature under the following conditions:
  ///  Using a high-definition camera and evenly lit environment.
  ///  The scene contains few objects, the user's portrait is half-body and mostly unobstructed, and the background color is relatively uniform and different from the user's clothing color.
  ///  This method depends on the virtual background dynamic library libagora_segmentation_extension.dll. Deleting this library will cause the feature to fail to start properly.
  ///
  /// * [enabled] Whether to enable virtual background: true : Enable virtual background. false : Disable virtual background.
  /// * [backgroundSource] The custom background. See VirtualBackgroundSource. To adapt the resolution of the custom background image to the SDK's video capture resolution, the SDK scales and crops the custom background image while preserving its aspect ratio.
  /// * [segproperty] Processing properties of the background image. See SegmentationProperty.
  /// * [type] The media source type to which the effect is applied. See MediaSourceType. In this method, this parameter only supports the following two settings:
  ///  When using the camera to capture local video, keep the default value primaryCameraSource.
  ///  To use custom captured video, set this parameter to customVideoSource.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> enableVirtualBackground(
      {required bool enabled,
      required VirtualBackgroundSource backgroundSource,
      required SegmentationProperty segproperty,
      MediaSourceType type = MediaSourceType.primaryCameraSource});

  /// Initializes the remote user view.
  ///
  /// This method binds a remote user to a display view and sets the rendering and mirror mode of the remote user view displayed locally. It only affects the video seen by the local user.
  /// You need to specify the remote user's ID when calling this method. Typically, you can set this before joining the channel. If the remote user ID is not available before joining, call this method upon receiving the onUserJoined callback.
  /// To unbind a view from a remote user, call this method and set view to null.
  /// After leaving the channel, the SDK clears the binding of the remote user view.
  /// In mobile custom composite layout scenarios, you can call this method to set a separate view for each sub-video stream of the composite video stream for rendering.
  ///  In Flutter, you do not need to call this method manually. Use AgoraVideoView to render local and remote views.
  ///  If you want to update the rendering or mirror mode of the remote user view during a call, use the setRemoteRenderMode method.
  ///  When using the recording service, since it does not send video streams, the app does not need to bind a view for it. If the app cannot identify the recording service, bind the remote user view upon receiving the onFirstRemoteVideoDecoded callback.
  ///
  /// * [canvas] Display properties of the remote video. See VideoCanvas.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Failure. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setupRemoteVideo(VideoCanvas canvas);

  /// Initializes the local view.
  ///
  /// This method initializes the local view and sets the display properties of the local user's video. It only affects the video seen by the local user and does not affect the publishing of the local video. Call this method to bind the display window (view) of the local video stream and set the rendering and mirror mode of the local user view.
  /// The binding remains effective after leaving the channel. To stop rendering or unbind, you can call this method and set the view parameter to NULL to stop rendering and clear the rendering cache.
  ///  In Flutter, you do not need to call this method manually. Use AgoraVideoView to render local and remote views.
  ///  If you only want to update the rendering or mirror mode of the local user view during a call, use the setLocalRenderMode method.
  ///
  /// * [canvas] Display properties of the local video. See VideoCanvas.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Failure. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setupLocalVideo(VideoCanvas canvas);

  /// Sets the video application scenario.
  ///
  /// After successfully calling this method to set the video application scenario, the SDK enables best practice strategies based on the specified scenario, automatically adjusting key performance indicators to optimize video experience quality. This method must be called before joining a channel.
  ///
  /// * [scenarioType] Video application scenario. See VideoApplicationScenarioType. applicationScenarioMeeting (1) is for meeting scenarios. If you have called setDualStreamMode to set the low stream to always off (disableSimulcastStream), the dynamic switching of the low stream does not take effect in meeting scenarios.
  /// This enum value applies only to broadcaster vs. broadcaster scenarios. The SDK enables the following strategies for this scenario:
  ///  For meeting scenarios that require higher bitrate for the low stream, multiple anti-weak network technologies are automatically enabled to enhance the low stream's resistance to poor networks and ensure smoothness when multiple streams are subscribed.
  ///  Real-time monitoring of the number of subscribers to the high stream on the receiving end, and dynamically adjusting the high stream configuration accordingly:
  ///  When no one subscribes to the high stream, the bitrate and frame rate of the high stream are automatically reduced to save uplink bandwidth and consumption.
  ///  When someone subscribes to the high stream, the high stream is reset to the VideoEncoderConfiguration set in the most recent call to setVideoEncoderConfiguration. If no configuration was previously set, the following values are used:
  ///  Video resolution: 1280 × 720 for desktop; 960 × 540 for mobile
  ///  Frame rate: 15 fps
  ///  Bitrate: 1600 Kbps for desktop; 1000 Kbps for mobile
  ///  Real-time monitoring of the number of subscribers to the low stream on the receiving end, and dynamically enabling or disabling the low stream:
  ///  When no one subscribes to the low stream, the low stream is automatically disabled to save uplink bandwidth and consumption.
  ///  When someone subscribes to the low stream, it is enabled and reset to the SimulcastStreamConfig set in the most recent call to setDualStreamMode. If no configuration was previously set, the following values are used:
  ///  Video resolution: 480 × 272
  ///  Frame rate: 15 fps
  ///  Bitrate: 500 Kbps applicationScenario1v1 (2) is for [1v1 video call](https://doc.shengwang.cn/doc/one-to-one-live/android/rtm/overview/product-overview) scenarios. The SDK optimizes strategies for low latency and high-quality experience in this scenario, improving performance such as image quality, first frame rendering time, latency on mid- to low-end devices, and smoothness under poor network conditions. applicationScenarioLiveshow (3) is for [showroom live streaming](https://doc.shengwang.cn/doc/showroom/android/overview/product-overview) scenarios. The SDK optimizes strategies for fast first frame rendering and high image clarity, such as enabling audio/video frame accelerated rendering by default to improve first frame experience (no need to call enableInstantMediaRendering separately), and enabling B-frames by default to ensure high image quality and transmission efficiency. It also enhances image quality and smoothness under poor network and low-end device conditions.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setVideoScenario(VideoApplicationScenarioType scenarioType);

  /// @nodoc
  Future<void> setVideoQoEPreference(VideoQoePreferenceType qoePreference);

  /// Enables the audio module.
  ///
  /// The audio module is enabled by default. If you have called disableAudio to disable the audio module, you can call this method to re-enable it.
  ///  Calling this method resets the entire engine and has a relatively slow response time. You can use the following methods to control specific audio module features based on your needs: enableLocalAudio : Whether to enable microphone capture and create a local audio stream. muteLocalAudioStream : Whether to publish the local audio stream. muteRemoteAudioStream : Whether to receive and play the remote audio stream. muteAllRemoteAudioStreams : Whether to receive and play all remote audio streams.
  ///  When calling this method in a channel, it resets the settings of enableLocalAudio, muteRemoteAudioStream, and muteAllRemoteAudioStreams. Use with caution.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> enableAudio();

  /// Disables the audio module.
  ///
  /// The audio module is enabled by default. You can call this method to disable the audio module. This method resets the entire engine and has a relatively slow response time. Therefore, Agora recommends using the following methods to control the audio module: enableLocalAudio : Whether to enable microphone capture and create a local audio stream. enableLoopbackRecording : Whether to enable sound card capture. muteLocalAudioStream : Whether to publish the local audio stream. muteRemoteAudioStream : Whether to receive and play the remote audio stream. muteAllRemoteAudioStreams : Whether to receive and play all remote audio streams.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> disableAudio();

  /// Sets the audio encoding profile and audio scenario.
  ///
  /// Due to iOS system limitations, some audio routes cannot be recognized in communication volume mode. Therefore, if you need to use an external sound card, it is recommended to set the audio scenario to the high-quality scenario audioScenarioGameStreaming (3). In this scenario, the SDK switches to media volume to avoid the issue.
  ///
  /// * [profile] Audio encoding profile, including sample rate, bitrate, encoding mode, and number of channels. See AudioProfileType.
  /// * [scenario] Audio scenario. The device volume type varies under different audio scenarios.
  /// See AudioScenarioType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setAudioProfile(
      {required AudioProfileType profile,
      AudioScenarioType scenario = AudioScenarioType.audioScenarioDefault});

  /// Sets the audio scenario.
  ///
  /// Due to iOS system limitations, some audio routes cannot be recognized in communication volume mode. Therefore, if you need to use an external sound card, it is recommended to set the audio scenario to the high-quality scenario audioScenarioGameStreaming (3). In this scenario, the SDK switches to media volume to avoid the issue.
  ///
  /// * [scenario] Audio scenario. The device volume type varies under different audio scenarios.
  /// See AudioScenarioType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setAudioScenario(AudioScenarioType scenario);

  /// Enables or disables local audio capture.
  ///
  /// When a user joins a channel, the audio function is enabled by default. This method can disable or re-enable the local audio function, that is, stop or restart local audio capture.
  /// The difference between this method and muteLocalAudioStream is: enableLocalAudio : Enables or disables local audio capture and processing. Using enableLocalAudio to disable or enable local capture will cause a brief interruption in hearing remote playback locally. muteLocalAudioStream : Stops or resumes sending the local audio stream without affecting the capture status.
  ///
  /// * [enabled] true : Re-enables the local audio function, i.e., enables local audio capture (default); false : Disables the local audio function, i.e., stops local audio capture.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> enableLocalAudio(bool enabled);

  /// Stops or resumes publishing the local audio stream.
  ///
  /// This method controls whether to publish the locally captured audio stream. Not publishing the local audio stream does not disable the audio capture device, so it does not affect the audio capture status.
  ///
  /// * [mute] Whether to stop publishing the local audio stream. true : Stop publishing. false : (Default) Publish.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> muteLocalAudioStream(bool mute);

  /// Stops or resumes subscribing to all remote users' audio streams.
  ///
  /// After this method is called successfully, the local user stops or resumes subscribing to all remote users' audio streams, including streams from users who join the channel after this method is called. By default, the SDK subscribes to all remote users' audio streams when joining a channel. To change this behavior, you can set autoSubscribeAudio to false when calling joinChannel, so that no audio streams are subscribed to upon joining.
  /// If you call enableAudio or disableAudio after this method, the later call takes effect.
  ///
  /// * [mute] Whether to stop subscribing to all remote users' audio streams: true : Stop subscribing to all remote users' audio streams. false : (Default) Subscribe to all remote users' audio streams.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> muteAllRemoteAudioStreams(bool mute);

  /// Stops or resumes subscribing to the audio stream of a specified remote user.
  ///
  /// * [uid] The user ID of the specified user.
  /// * [mute] Whether to stop subscribing to the audio stream of the specified remote user. true : Stop subscribing to the audio stream of the specified user. false : (Default) Subscribe to the audio stream of the specified user.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> muteRemoteAudioStream({required int uid, required bool mute});

  /// Stops or resumes publishing the local video stream.
  ///
  /// This method controls whether to publish the locally captured video stream. Not publishing the local video stream does not disable the video capture device, so it does not affect the video capture status.
  /// Compared to calling enableLocalVideo(false) to stop video capture and thus stop publishing, this method responds faster.
  ///
  /// * [mute] Whether to stop sending the local video stream. true : Stop sending the local video stream. false : (Default) Send the local video stream.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> muteLocalVideoStream(bool mute);

  /// Enables or disables local video capture.
  ///
  /// This method disables or re-enables local video capture and does not affect receiving remote video.
  /// After calling enableVideo, local video capture is enabled by default.
  /// If you call enableLocalVideo(false) in a channel to disable local video capture, it also stops publishing the video stream in the channel. To re-enable, call enableLocalVideo(true), then call updateChannelMediaOptions and set the options parameter to publish the captured video stream to the channel.
  /// After successfully enabling or disabling local video capture, the remote side receives the onRemoteVideoStateChanged callback.
  ///  This method can be called before or after joining a channel. However, settings made before joining only take effect after joining.
  ///  This method sets the internal engine to an enabled state and remains effective after leaving the channel.
  ///
  /// * [enabled] Whether to enable local video capture. true : (Default) Enable local video capture. false : Disable local video capture. After disabling, the remote user cannot receive the local video stream, but the local user can still receive the remote video stream. When set to false, this method does not require a local camera.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> enableLocalVideo(bool enabled);

  /// Stops or resumes subscribing to all remote users' video streams.
  ///
  /// After this method is called successfully, the local user stops or resumes subscribing to all remote users' video streams, including streams from users who join the channel after this method is called. By default, the SDK subscribes to all remote users' video streams when joining a channel. To change this behavior, you can set autoSubscribeVideo to false when calling joinChannel, so that no video streams are subscribed to upon joining.
  /// If you call enableVideo or disableVideo after this method, the later call takes effect.
  ///
  /// * [mute] Whether to stop subscribing to all remote users' video streams. true : Stop subscribing to all users' video streams. false : (Default) Subscribe to all users' video streams.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> muteAllRemoteVideoStreams(bool mute);

  /// Sets the default video stream type to subscribe to.
  ///
  /// Depending on the sender's default behavior and the specific settings of setDualStreamMode, the receiver's call to this method falls into the following cases:
  ///  By default, the SDK enables the small stream adaptive mode (autoSimulcastStream) on the sender side, meaning the sender only sends the high-quality stream. Only receivers with host role can call this method to request the low-quality stream. Once the sender receives the request, it starts sending the low-quality stream. All users in the channel can then call this method to switch to low-quality stream subscription mode.
  ///  If the sender calls setDualStreamMode and sets mode to disableSimulcastStream (never send low-quality stream), this method has no effect.
  ///  If the sender calls setDualStreamMode and sets mode to enableSimulcastStream (always send low-quality stream), both hosts and audience can call this method to switch to low-quality stream subscription mode. When receiving the low-quality stream, the SDK dynamically adjusts the video stream size according to the video window size to save bandwidth and computing resources. The default aspect ratio of the low-quality stream is consistent with the high-quality stream. Based on the current high-quality stream's aspect ratio, the system automatically assigns resolution, frame rate, and bitrate to the low-quality stream. If you call both this method and setRemoteVideoStreamType, the SDK uses the settings in setRemoteVideoStreamType.
  ///
  /// * [streamType] The default video stream type to subscribe to: VideoStreamType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setRemoteDefaultVideoStreamType(VideoStreamType streamType);

  /// Stops or resumes subscribing to the video stream of a specified remote user.
  ///
  /// * [uid] The user ID of the specified user.
  /// * [mute] Whether to stop subscribing to the video stream of the specified remote user. true : Stop subscribing to the video stream of the specified user. false : (Default) Subscribe to the video stream of the specified user.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Method call failed. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> muteRemoteVideoStream({required int uid, required bool mute});

  /// Sets the video stream type to subscribe to.
  ///
  /// Depending on the sender's default behavior and the specific settings of setDualStreamMode, the receiver's call to this method falls into the following cases:
  ///  By default, the SDK enables the small stream adaptive mode (autoSimulcastStream) on the sender side, meaning the sender only sends the high-quality stream. Only receivers with host role can call this method to request the low-quality stream. Once the sender receives the request, it starts sending the low-quality stream. All users in the channel can then call this method to switch to low-quality stream subscription mode.
  ///  If the sender calls setDualStreamMode and sets mode to disableSimulcastStream (never send low-quality stream), this method has no effect.
  ///  If the sender calls setDualStreamMode and sets mode to enableSimulcastStream (always send low-quality stream), both hosts and audience can call this method to switch to low-quality stream subscription mode. When receiving the low-quality stream, the SDK dynamically adjusts the video stream size according to the video window size to save bandwidth and computing resources. The default aspect ratio of the low-quality stream is consistent with the high-quality stream. Based on the current high-quality stream's aspect ratio, the system automatically assigns resolution, frame rate, and bitrate to the low-quality stream.
  ///  This method can be called before or after joining a channel.
  ///  If you call both this method and setRemoteDefaultVideoStreamType, the SDK uses the settings in this method.
  ///
  /// * [uid] User ID.
  /// * [streamType] Video stream type: VideoStreamType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setRemoteVideoStreamType(
      {required int uid, required VideoStreamType streamType});

  /// Sets the subscription options for the remote video stream.
  ///
  /// When the remote side sends dual streams, you can call this method to set the subscription options for the remote video stream. The SDK's default subscription behavior for remote video streams depends on the type of registered video observer:
  ///  If VideoFrameObserver is registered, the SDK subscribes to both raw and encoded data by default.
  ///  If VideoEncodedFrameObserver is registered, the SDK subscribes to encoded data only by default.
  ///  If both observers are registered, the SDK follows the most recently registered one. For example, if VideoFrameObserver is registered later, the SDK subscribes to both raw and encoded data by default. If you want to change the above default behavior or set different subscription options for different uid s, you can call this method.
  ///
  /// * [uid] Remote user ID.
  /// * [options] Video stream subscription settings. See VideoSubscriptionOptions.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setRemoteVideoSubscriptionOptions(
      {required int uid, required VideoSubscriptionOptions options});

  /// Sets the audio subscription blocklist.
  ///
  /// You can call this method to specify the audio streams you do not want to subscribe to.
  ///  This method can be called before or after joining a channel.
  ///  The audio subscription blocklist is not affected by muteRemoteAudioStream, muteAllRemoteAudioStreams, or autoSubscribeAudio in ChannelMediaOptions.
  ///  After setting the blocklist, if you leave and rejoin the channel, the blocklist remains effective.
  ///  If a user appears in both the audio subscription allowlist and blocklist, only the blocklist takes effect.
  ///
  /// * [uidList] The list of user IDs in the audio subscription blocklist.
  /// If you want to exclude a specific user's audio stream from being subscribed to, add that user's ID to this list. If you want to remove a user from the blocklist, call the setSubscribeAudioBlocklist method again and update the list of user IDs so that it no longer contains the uid of the user you want to remove.
  /// * [uidNumber] The number of users in the blocklist.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setSubscribeAudioBlocklist(
      {required List<int> uidList, required int uidNumber});

  /// Sets the audio subscription allowlist.
  ///
  /// You can call this method to specify the audio streams you want to subscribe to.
  ///  This method can be called before or after joining a channel.
  ///  The audio subscription allowlist is not affected by muteRemoteAudioStream, muteAllRemoteAudioStreams, or autoSubscribeAudio in ChannelMediaOptions.
  ///  After setting the allowlist, if you leave and rejoin the channel, the allowlist remains effective.
  ///  If a user appears in both the audio subscription allowlist and blocklist, only the blocklist takes effect.
  ///
  /// * [uidList] The list of user IDs in the audio subscription allowlist.
  /// If you want to subscribe to a specific user's audio stream, add that user's ID to this list. If you want to remove a user from the allowlist, call the setSubscribeAudioAllowlist method again and update the list of user IDs so that it no longer contains the uid of the user you want to remove.
  /// * [uidNumber] The number of users in the allowlist.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setSubscribeAudioAllowlist(
      {required List<int> uidList, required int uidNumber});

  /// Sets the video subscription blocklist.
  ///
  /// You can call this method to specify the video streams you do not want to subscribe to.
  ///  You can call this method either before or after joining a channel.
  ///  The video subscription blocklist is not affected by muteRemoteVideoStream, muteAllRemoteVideoStreams, or the autoSubscribeVideo setting in ChannelMediaOptions.
  ///  After setting the blocklist, it remains effective even if you leave and rejoin the channel.
  ///  If a user is in both the audio subscription blocklist and allowlist, only the blocklist takes effect.
  ///
  /// * [uidList] The user ID list of the video subscription blocklist.
  /// If you want to unsubscribe from the video stream of a specific publishing user, add that user's ID to this list. If you want to remove a user from the blocklist, you need to call the setSubscribeVideoBlocklist method again to update the user ID list of the subscription blocklist so that it no longer contains the uid of the user you want to remove.
  /// * [uidNumber] The number of users in the blocklist.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setSubscribeVideoBlocklist(
      {required List<int> uidList, required int uidNumber});

  /// Sets the video subscription allowlist.
  ///
  /// You can call this method to specify the video streams you want to subscribe to.
  ///  This method can be called before or after joining a channel.
  ///  The video subscription allowlist is not affected by muteRemoteVideoStream, muteAllRemoteVideoStreams, or autoSubscribeVideo in ChannelMediaOptions.
  ///  After setting the allowlist, if you leave and rejoin the channel, the allowlist remains effective.
  ///  If a user appears in both the audio subscription allowlist and blocklist, only the blocklist takes effect.
  ///
  /// * [uidList] The list of user IDs in the video subscription allowlist.
  /// If you want to subscribe only to a specific user's video stream, add that user's ID to this list. If you want to remove a user from the allowlist, call the setSubscribeVideoAllowlist method again and update the list of user IDs so that it no longer contains the uid of the user you want to remove.
  /// * [uidNumber] The number of users in the allowlist.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setSubscribeVideoAllowlist(
      {required List<int> uidList, required int uidNumber});

  /// Enables audio volume indication.
  ///
  /// This method allows the SDK to periodically report volume information of the local user who is sending a stream and up to 3 remote users with the highest instantaneous volume to the app.
  ///
  /// * [interval] The time interval for volume indication:
  ///  ≤ 0: Disables the volume indication.
  ///  > 0: The interval in milliseconds for volume indication. It is recommended to set it greater than 100 ms. Must not be less than 10 ms, otherwise the onAudioVolumeIndication callback will not be received.
  /// * [smooth] The smoothing factor that specifies the sensitivity of the volume indication. The range is [0,10], and the recommended value is 3. The larger the value, the more sensitive the fluctuation; the smaller the value, the smoother the fluctuation.
  /// * [reportVad] true : Enables local voice activity detection. When enabled, the vad parameter in the onAudioVolumeIndication callback reports whether voice is detected locally. false : (Default) Disables local voice activity detection. Unless the engine automatically detects local voice, the vad parameter in the onAudioVolumeIndication callback does not report local voice detection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> enableAudioVolumeIndication(
      {required int interval, required int smooth, required bool reportVad});

  /// @nodoc
  Future<void> startAudioRecording(AudioRecordingConfiguration config);

  /// Registers the audio encoded frame observer.
  ///
  /// Call this method after joining a channel.
  ///  Since this method and startAudioRecording both configure audio content and quality, it is not recommended to use them together. Otherwise, only the one called later takes effect.
  ///
  /// * [config] Configuration for the encoded audio observer. See AudioEncodedFrameObserverConfig.
  /// * [observer] Observer for encoded audio. See AudioEncodedFrameObserver.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  void registerAudioEncodedFrameObserver(
      {required AudioEncodedFrameObserverConfig config,
      required AudioEncodedFrameObserver observer});

  /// @nodoc
  Future<void> stopAudioRecording();

  /// @nodoc
  Future<MediaPlayer?> createMediaPlayer();

  /// Destroys the media player.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Failure. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> destroyMediaPlayer(MediaPlayer mediaPlayer);

  /// @nodoc
  Future<MediaRecorder?> createMediaRecorder(RecorderStreamInfo info);

  /// @nodoc
  Future<void> destroyMediaRecorder(MediaRecorder mediaRecorder);

  /// Starts playing a music file.
  ///
  /// See [Supported audio file formats](https://doc.shengwang.cn/faq/general-product-inquiry/audio-format) for the audio formats supported by this method. If the local music file does not exist, the file format is not supported, or the online music file URL cannot be accessed, the SDK reports audioMixingReasonCanNotOpen.
  ///  Using this method to play short sound effects may cause playback failure. To play sound effects, use playEffect instead.
  ///  If you need to call this method multiple times, make sure the interval between calls is more than 500 ms.
  ///  When calling this method on Android, note the following:
  ///  Make sure to use a device with Android 4.2 or above and API level no lower than 16.
  ///  If playing online music files, avoid using redirect URLs. Redirect URLs may not work on some devices.
  ///  If calling this method on an emulator, make sure the music file is under the /sdcard/ directory and in MP3 format.
  ///
  /// * [filePath] File path:
  ///  Android: File path, must include the file name and extension. Supports URL of online files, URI of local files, absolute paths, or paths starting with /assets/. Accessing local files via absolute path may cause permission issues. It is recommended to use URI. For example: content://com.android.providers.media.documents/document/audio%3A14441.
  ///  Windows: Absolute path or URL to the audio file, must include the file name and extension. For example: C:\music\audio.mp4.
  ///  iOS or macOS: Absolute path or URL to the audio file, must include the file name and extension. For example: /var/mobile/Containers/Data/audio.mp4.
  /// * [loopback] Whether to play the music file locally only: true : Play the music file locally only. Only the local user can hear the music. false : Publish the locally played music file to remote users. Both local and remote users can hear the music.
  /// * [cycle] Number of times to play the music file.
  ///  > 0: Number of times to play. For example, 1 means play once.
  ///  -1: Play in an infinite loop.
  /// * [startPos] The playback position of the music file, in milliseconds.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> startAudioMixing(
      {required String filePath,
      required bool loopback,
      required int cycle,
      int startPos = 0});

  /// Stops playing the music file.
  ///
  /// After calling startAudioMixing to play a music file, you can call this method to stop playback. If you only want to pause playback, call pauseAudioMixing instead.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> stopAudioMixing();

  /// Pauses the playback of the music file.
  ///
  /// After you call the startAudioMixing method to play a music file, call this method to pause the playback. To stop the playback, call stopAudioMixing.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> pauseAudioMixing();

  /// Resumes the playback of the music file.
  ///
  /// After you call pauseAudioMixing to pause the music file, call this method to resume playback.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> resumeAudioMixing();

  /// Specifies the playback audio track of the current music file.
  ///
  /// After obtaining the number of audio tracks in the music file, you can call this method to specify any track for playback. For example, if a multi-track file contains songs in different languages on different tracks, you can use this method to set the playback language of the music file.
  ///  For supported audio file formats, see [What audio formats does the RTC SDK support?](https://doc.shengwang.cn/faq/general-product-inquiry/audio-format).
  ///  You must call this method after calling startAudioMixing and receiving the onAudioMixingStateChanged(audioMixingStatePlaying) callback.
  ///
  /// * [index] The specified playback audio track. The value must be greater than or equal to 0 and less than the return value of getAudioTrackCount.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> selectAudioTrack(int index);

  /// Gets the audio track index of the current music file.
  ///
  /// You need to call this method after calling startAudioMixing and receiving the onAudioMixingStateChanged(audioMixingStatePlaying) callback.
  ///
  /// Returns
  /// When the method call succeeds, returns the audio track index of the current music file.
  ///  < 0: The method call fails. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<int> getAudioTrackCount();

  /// Adjusts the playback volume of the music file.
  ///
  /// This method adjusts the playback volume of the mixed music file for both local and remote playback. Calling this method does not affect the playback volume of sound effects set via the playEffect method.
  ///
  /// * [volume] Volume range of the music file is 0~100. 100 (default) is the original file volume.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> adjustAudioMixingVolume(int volume);

  /// Adjusts the remote playback volume of the music file.
  ///
  /// This method adjusts the remote playback volume of the mixed music file.
  ///
  /// * [volume] Volume of the music file. The range is [0,100], where 100 (default) is the original volume.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> adjustAudioMixingPublishVolume(int volume);

  /// Gets the remote playback volume of the music file.
  ///
  /// This interface helps developers troubleshoot volume-related issues. You need to call this method after calling startAudioMixing and receiving the onAudioMixingStateChanged(audioMixingStatePlaying) callback.
  ///
  /// Returns
  /// ≥ 0: The method call succeeds and returns the volume value, range is [0,100].
  ///  < 0: The method call fails. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<int> getAudioMixingPublishVolume();

  /// Adjusts the local playback volume of the music file.
  ///
  /// * [volume] Volume of the music file. The range is [0,100], where 100 (default) is the original volume.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> adjustAudioMixingPlayoutVolume(int volume);

  /// Gets the local playback volume of the music file.
  ///
  /// You can call this method to get the local playback volume of the mixed music file, which helps troubleshoot volume-related issues.
  ///
  /// Returns
  /// ≥ 0: The method call succeeds and returns the volume value, range is [0,100].
  ///  < 0: The method call fails. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<int> getAudioMixingPlayoutVolume();

  /// Gets the total duration of the music file.
  ///
  /// This method gets the total duration of the music file, in milliseconds.
  ///
  /// Returns
  /// ≥ 0: The method call succeeds and returns the duration of the music file.
  ///  < 0: The method call fails. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<int> getAudioMixingDuration();

  /// Gets the playback progress of the music file.
  ///
  /// This method gets the current playback progress of the music file, in milliseconds.
  ///  You need to call this method after calling startAudioMixing and receiving the onAudioMixingStateChanged(audioMixingStatePlaying) callback.
  ///  If you need to call getAudioMixingCurrentPosition multiple times, ensure the interval between calls is greater than 500 ms.
  ///
  /// Returns
  /// ≥ 0: The method call succeeds and returns the current playback progress of the music file (ms). 0 indicates the music file has not started playing.
  ///  < 0: The method call fails. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<int> getAudioMixingCurrentPosition();

  /// Sets the playback position of the music file.
  ///
  /// This method sets the playback position of the audio file, allowing you to play the file based on actual needs instead of playing it from start to finish.
  ///
  /// * [pos] Integer. The position on the progress bar, in milliseconds.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setAudioMixingPosition(int pos);

  /// Sets the channel mode of the current audio file.
  ///
  /// In stereo audio files, the left and right channels can store different audio data. Depending on your needs, you can set the channel mode to original, left channel, right channel, or mixed mode. This method applies to stereo audio files only.
  ///
  /// * [mode] The channel mode. See AudioMixingDualMonoMode.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setAudioMixingDualMonoMode(AudioMixingDualMonoMode mode);

  /// Adjusts the pitch of the locally played music file.
  ///
  /// When mixing local voice with a music file, call this method to adjust only the pitch of the music file.
  ///
  /// * [pitch] Adjusts the pitch of the locally played music file in semitone steps. The default value is 0, which means no pitch adjustment. The valid range is [-12, 12]. Each step represents a semitone difference. The greater the absolute value, the more the pitch is raised or lowered.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setAudioMixingPitch(int pitch);

  /// Sets the playback speed of the current music file.
  ///
  /// You must call this method after startAudioMixing and after receiving the onAudioMixingStateChanged callback reporting the playback state as audioMixingStatePlaying.
  ///
  /// * [speed] The playback speed of the music file. The recommended range is [50, 400], where:
  ///  50: 0.5x speed.
  ///  100: Original speed.
  ///  400: 4x speed.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setAudioMixingPlaybackSpeed(int speed);

  /// Gets the playback volume of audio effect files.
  ///
  /// The volume range is [0,100]. 100 (default) is the original file volume. You need to call this method after playEffect.
  ///
  /// Returns
  /// The volume of the audio effect file.
  ///  < 0: The method call fails. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<int> getEffectsVolume();

  /// Sets the playback volume of audio effect files.
  ///
  /// * [volume] Playback volume. The range is [0,100]. The default value is 100, representing the original volume.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setEffectsVolume(int volume);

  /// Loads the audio effect file into memory.
  ///
  /// To ensure smooth communication, pay attention to the size of the preloaded audio effect file.
  /// Supported formats for preloading audio files are listed in [What audio formats are supported by the RTC SDK](https://doc.shengwang.cn/faq/general-product-inquiry/audio-format).
  ///
  /// * [soundId] The ID of the audio effect. Each audio effect has a unique ID.
  /// * [filePath] File path:
  ///  Android: File path including file name and extension. Supports URL of online files, URI of local files, absolute paths, or paths starting with /assets/. Accessing local files via absolute path may cause permission issues. It is recommended to use URI to access local files. For example, content://com.android.providers.media.documents/document/audio%3A14441.
  ///  Windows: Absolute path or URL of the audio file, including file name and extension. For example, C:\music\audio.mp4.
  ///  iOS or macOS: Absolute path or URL of the audio file, including file name and extension. For example, /var/mobile/Containers/Data/audio.mp4.
  /// * [startPos] The start position for loading the audio effect file, in milliseconds.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> preloadEffect(
      {required int soundId, required String filePath, int startPos = 0});

  /// Plays the specified local or online audio effect file.
  ///
  /// You can call this method multiple times with different soundID and filePath to play multiple audio effect files simultaneously. For optimal user experience, it is recommended to play no more than 3 audio effect files at the same time. If you need to play an online audio effect file, Agora recommends caching the file to the local device first, then calling preloadEffect to preload the cached file into memory, and finally calling this method to play the effect. Otherwise, playback failure or no sound may occur due to timeout or failure in loading the online file.
  ///
  /// * [soundId] ID of the audio effect. Each audio effect has a unique ID. If you have loaded the audio effect into memory using preloadEffect, make sure this parameter matches the soundId set in preloadEffect.
  /// * [filePath] Path of the file to be played. Supports URL of online files or absolute path of local files. Must include file name and extension. Supported formats include MP3, AAC, M4A, MP4, WAV, 3GP, etc. If you have loaded the audio effect into memory using preloadEffect, make sure this parameter matches the filePath set in preloadEffect.
  /// * [loopCount] Number of times the audio effect is looped.
  ///  ≥ 0: Number of loops. For example, 1 means loop once, i.e., played twice in total.
  ///  -1: Loops indefinitely.
  /// * [pitch] Pitch of the audio effect. Value range is [0.5,2.0]. Default is 1.0, which represents the original pitch. The smaller the value, the lower the pitch.
  /// * [pan] Spatial position of the audio effect. Value range is [-1.0,1.0], for example:
  ///  -1.0: Audio effect appears on the left
  ///  0.0: Audio effect appears in the center
  ///  1.0: Audio effect appears on the right
  /// * [gain] Volume of the audio effect. Value range is [0.0,100.0]. Default is 100.0, which represents the original volume. The smaller the value, the lower the volume.
  /// * [publish] Whether to publish the audio effect to remote users: true : Publishes the audio effect to remote users. Both local and remote users can hear it. false : Does not publish the audio effect to remote users. Only local users can hear it.
  /// * [startPos] Playback position of the audio effect file in milliseconds.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: The method call fails. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> playEffect(
      {required int soundId,
      required String filePath,
      required int loopCount,
      required double pitch,
      required double pan,
      required int gain,
      bool publish = false,
      int startPos = 0});

  /// Plays all audio effect files.
  ///
  /// After calling preloadEffect multiple times to preload multiple audio effect files, you can call this method to play all preloaded audio effect files.
  ///
  /// * [loopCount] Number of times the audio effect file is looped:
  ///  -1: Loops indefinitely until stopEffect or stopAllEffects is called.
  ///  0: Plays once.
  ///  1: Plays twice.
  /// * [pitch] Pitch of the audio effect. Value range is [0.5,2.0]. Default is 1.0, which represents the original pitch. The smaller the value, the lower the pitch.
  /// * [pan] Spatial position of the audio effect. Value range is [-1.0,1.0]:
  ///  -1.0: Audio effect appears on the left.
  ///  0: Audio effect appears in the center.
  ///  1.0: Audio effect appears on the right.
  /// * [gain] Volume of the audio effect. Value range is [0,100]. 100 is the default and represents the original volume. The smaller the value, the lower the volume.
  /// * [publish] Whether to publish the audio effect to remote users: true : Publishes the audio effect to remote users. Both local and remote users can hear it. false : (Default) Does not publish the audio effect to remote users. Only local users can hear it.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> playAllEffects(
      {required int loopCount,
      required double pitch,
      required double pan,
      required int gain,
      bool publish = false});

  /// Gets the playback volume of the specified audio effect file.
  ///
  /// * [soundId] ID of the audio effect file.
  ///
  /// Returns
  /// ≥ 0: The method call succeeds and returns the playback volume. The volume range is [0,100]. 100 is the original volume.
  ///  < 0: The method call fails. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<int> getVolumeOfEffect(int soundId);

  /// Sets the playback volume of the specified audio effect file.
  ///
  /// * [soundId] The ID of the specified audio effect. Each audio effect has a unique ID.
  /// * [volume] Playback volume. The range is [0,100]. The default value is 100, representing the original volume.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setVolumeOfEffect({required int soundId, required int volume});

  /// Pauses playback of the audio effect file.
  ///
  /// * [soundId] ID of the audio effect. Each audio effect has a unique ID.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> pauseEffect(int soundId);

  /// Pauses playback of all audio effect files.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> pauseAllEffects();

  /// Resumes playback of the specified audio effect file.
  ///
  /// * [soundId] The ID of the audio effect. Each audio effect has a unique ID.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> resumeEffect(int soundId);

  /// Resumes playback of all audio effect files.
  ///
  /// After you call pauseAllEffects to pause all audio effects, you can call this method to resume playback.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> resumeAllEffects();

  /// Stops playback of the specified audio effect file.
  ///
  /// If you no longer need to play a specific audio effect file, you can call this method to stop playback. If you only need to pause playback, call pauseEffect.
  ///
  /// * [soundId] The ID of the specified audio effect file. Each audio effect file has a unique ID.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> stopEffect(int soundId);

  /// Stops playback of all audio effect files.
  ///
  /// If you no longer need to play audio effect files, you can call this method to stop playback. If you only need to pause playback, call pauseAllEffects.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> stopAllEffects();

  /// Releases a specific preloaded audio effect file from memory.
  ///
  /// After loading the audio effect file into memory using preloadEffect, call this method to release the audio effect file.
  ///
  /// * [soundId] The ID of the specified audio effect file. Each audio effect file has a unique ID.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> unloadEffect(int soundId);

  /// Releases all preloaded audio effect files from memory.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> unloadAllEffects();

  /// Gets the total duration of the specified sound effect file.
  ///
  /// This method must be called after joining a channel.
  ///
  /// * [filePath] File path:
  ///  Android: File path, must include the file name and extension. Supports URL of online files, URI of local files, absolute paths, or paths starting with /assets/. Accessing local files via absolute path may cause permission issues. It is recommended to use URI. For example: content://com.android.providers.media.documents/document/audio%3A14441.
  ///  Windows: Absolute path or URL to the audio file, must include the file name and extension. For example: C:\music\audio.mp4.
  ///  iOS or macOS: Absolute path or URL to the audio file, must include the file name and extension. For example: /var/mobile/Containers/Data/audio.mp4.
  ///
  /// Returns
  /// If the method call succeeds, returns the duration of the specified sound effect file (milliseconds).
  ///  < 0: The method call fails. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<int> getEffectDuration(String filePath);

  /// Sets the playback position of the specified audio effect file.
  ///
  /// After successful setting, the local audio effect file will start playing from the specified position. This method must be called after playEffect.
  ///
  /// * [soundId] The ID of the audio effect. Each audio effect has a unique ID.
  /// * [pos] The playback position of the audio effect file, in milliseconds.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setEffectPosition({required int soundId, required int pos});

  /// Gets the playback progress of the specified sound effect file.
  ///
  /// This method must be called after playEffect.
  ///
  /// * [soundId] The ID of the sound effect. Each sound effect has a unique ID.
  ///
  /// Returns
  /// If the method call succeeds, returns the playback progress of the specified sound effect file (milliseconds).
  ///  < 0: The method call fails. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<int> getEffectCurrentPosition(int soundId);

  /// Enables/disables stereo sound for remote users.
  ///
  /// To enable spatial audio positioning using setRemoteVoicePosition, make sure to call this method before joining the channel to enable stereo sound for remote users.
  ///
  /// * [enabled] Whether to enable stereo sound for remote users: true : Enable stereo sound. false : Disable stereo sound.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> enableSoundPositionIndication(bool enabled);

  /// Sets the 2D position of a remote user's voice on the horizontal plane.
  ///
  /// Sets the 2D position and volume of a remote user's voice to help the local user determine the direction of the sound.
  /// By calling this API to set the position of the remote user's voice, the difference between the left and right audio channels creates a sense of direction, allowing you to determine the real-time position of the remote user. In multiplayer online games, such as battle royale games, this method can effectively enhance the spatial awareness of game characters and simulate real-world scenarios.
  ///  You must call enableSoundPositionIndication to enable remote voice stereo before joining the channel.
  ///  For the best audio experience, it is recommended to use wired headphones when using this method.
  ///  This method must be called after joining the channel.
  ///
  /// * [uid] The ID of the remote user.
  /// * [pan] Sets the 2D position of the remote user's voice. The range is [-1.0, 1.0]:
  ///  (Default) 0.0: Voice appears in front.
  ///  -1.0: Voice appears on the left.
  ///  1.0: Voice appears on the right.
  /// * [gain] Sets the volume of the remote user's voice. The range is [0.0, 100.0], with a default value of 100.0, representing the original volume of the user. The smaller the value, the lower the volume.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when it fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setRemoteVoicePosition(
      {required int uid, required double pan, required double gain});

  /// Enables or disables spatial audio.
  ///
  /// After enabling spatial audio, you can call setRemoteUserSpatialAudioParams to set the spatial audio parameters for remote users.
  ///  This method can be called before or after joining a channel.
  ///  This method depends on the spatial audio dynamic library libagora_spatial_audio_extension.dll. Deleting this library will cause the feature to fail to enable properly.
  ///
  /// * [enabled] Whether to enable spatial audio: true : Enable spatial audio. false : Disable spatial audio.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> enableSpatialAudio(bool enabled);

  /// Sets the spatial audio parameters for a remote user.
  ///
  /// This method must be called after enableSpatialAudio. After successfully setting the spatial audio parameters for the remote user, the local user will perceive spatial sound from the remote user.
  ///
  /// * [uid] User ID. Must match the user ID used when joining the channel.
  /// * [params] Spatial audio parameters. See SpatialAudioParams.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when it fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setRemoteUserSpatialAudioParams(
      {required int uid, required SpatialAudioParams params});

  /// Sets the preset voice beautifier effect.
  ///
  /// Call this method to set a preset voice beautifier effect for the local user who is sending the stream. After setting the beautifier effect, all users in the channel can hear it. You can set different beautifier effects for users depending on the scenario.
  ///  Do not set the profile parameter of setAudioProfile to audioProfileSpeechStandard (1) or audioProfileIot (6), otherwise this method will not take effect.
  ///  This method provides optimal processing for vocals and is not recommended for audio data containing music.
  ///  After calling setVoiceBeautifierPreset, do not call the following methods, or the effect set by setVoiceBeautifierPreset will be overridden: setAudioEffectPreset setAudioEffectParameters setLocalVoicePitch setLocalVoiceEqualization setLocalVoiceReverb setVoiceBeautifierParameters setVoiceConversionPreset
  ///  This method depends on the voice beautifier dynamic library libagora_audio_beauty_extension.dll. If this library is deleted, the feature will not work properly.
  ///
  /// * [preset] The preset voice beautifier option. See VoiceBeautifierPreset.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setVoiceBeautifierPreset(VoiceBeautifierPreset preset);

  /// Sets the SDK preset voice effect.
  ///
  /// You can call this method to set the SDK preset voice effect for the local user who is sending the stream, without changing the gender characteristics of the original voice. After setting the effect, all users in the channel can hear it.
  ///  Do not set the profile parameter of setAudioProfile to audioProfileSpeechStandard (1) or audioProfileIot (6), otherwise this method will not take effect.
  ///  If you call setAudioEffectPreset and set an enum other than roomAcoustics3dVoice or pitchCorrection, do not call setAudioEffectParameters, otherwise the effect set by setAudioEffectPreset will be overridden.
  ///  After calling setAudioEffectPreset, it is not recommended to call the following methods, otherwise the effect set by setAudioEffectPreset will be overridden: setVoiceBeautifierPreset setLocalVoicePitch setLocalVoiceEqualization setLocalVoiceReverb setVoiceBeautifierParameters setVoiceConversionPreset
  ///  This method depends on the voice beautifier dynamic library libagora_audio_beauty_extension.dll. Deleting this library will cause the feature to not function properly.
  ///
  /// * [preset] Preset effect options. See AudioEffectPreset.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setAudioEffectPreset(AudioEffectPreset preset);

  /// Sets the preset voice conversion effect.
  ///
  /// Call this method to set a preset voice conversion effect provided by the SDK for the local user who is sending the stream. After setting the effect, all users in the channel can hear it. You can set different voice conversion effects for users depending on the scenario.
  ///  Do not set the profile parameter of setAudioProfile to audioProfileSpeechStandard (1) or audioProfileIot (6), otherwise this method will not take effect.
  ///  This method provides optimal processing for vocals and is not recommended for audio data containing music.
  ///  After calling setVoiceConversionPreset, do not call the following methods, or the effect set by setVoiceConversionPreset will be overridden: setAudioEffectPreset setAudioEffectParameters setVoiceBeautifierPreset setVoiceBeautifierParameters setLocalVoicePitch setLocalVoiceFormant setLocalVoiceEqualization setLocalVoiceReverb
  ///  This method depends on the voice beautifier dynamic library libagora_audio_beauty_extension.dll. If this library is deleted, the feature will not work properly.
  ///
  /// * [preset] The preset voice conversion option: VoiceConversionPreset.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Failure. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setVoiceConversionPreset(VoiceConversionPreset preset);

  /// Sets the parameters for SDK preset voice effects.
  ///
  /// You can call this method to configure the following settings for the local user who is sending the stream:
  ///  3D voice effect: Set the surround cycle of the 3D voice effect.
  ///  Pitch correction effect: Set the base scale and main pitch of the pitch correction effect. To allow users to adjust the pitch correction effect themselves, it is recommended to bind the base scale and main pitch configuration options to the UI elements of your app. After setting, all users in the channel can hear the effect. To achieve better voice effects, it is recommended that you perform the following operations before calling this method:
  ///  Call setAudioScenario to set the audio scenario to high-quality, i.e., audioScenarioGameStreaming (3).
  ///  Call setAudioProfile to set the profile to audioProfileMusicHighQuality (4) or audioProfileMusicHighQualityStereo (5).
  ///  This method can be called before and after joining a channel.
  ///  Do not set the profile parameter of setAudioProfile to audioProfileSpeechStandard (1) or audioProfileIot (6), otherwise this method will not take effect.
  ///  This method provides the best processing effect for voice. It is not recommended to use this method to process audio data that contains music.
  ///  After calling setAudioEffectParameters, it is not recommended to call the following methods, otherwise the effect set by setAudioEffectParameters will be overridden: setAudioEffectPreset setVoiceBeautifierPreset setLocalVoicePitch setLocalVoiceEqualization setLocalVoiceReverb setVoiceBeautifierParameters setVoiceConversionPreset
  ///  This method depends on the voice beautifier dynamic library libagora_audio_beauty_extension.dll. Deleting this library will cause the feature to not function properly.
  ///
  /// * [preset] SDK preset effects. The following settings are supported: roomAcoustics3dVoice, 3D voice effect.
  ///  Before using this enum, you need to set the profile parameter of setAudioProfile to audioProfileMusicStandardStereo (3) or audioProfileMusicHighQualityStereo (5), otherwise this enum setting is invalid.
  ///  After enabling 3D voice, users need to use audio playback devices that support stereo to hear the expected effect. pitchCorrection, pitch correction effect.
  /// * [param1] If preset is set to roomAcoustics3dVoice, then param1 indicates the surround cycle of the 3D voice effect. The range is [1,60] in seconds. The default value is 10, meaning the voice surrounds 360 degrees in 10 seconds.
  ///  If preset is set to pitchCorrection, then param1 indicates the base scale of the pitch correction effect: 1 : (Default) Natural major. 2 : Natural minor. 3 : Japanese scale.
  /// * [param2] If preset is set to roomAcoustics3dVoice, you need to set param2 to 0.
  ///  If preset is set to pitchCorrection, then param2 indicates the main pitch of the pitch correction effect: 1 : A 2 : A# 3 : B 4 : (Default) C 5 : C# 6 : D 7 : D# 8 : E 9 : F 10 : F# 11 : G 12 : G#
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setAudioEffectParameters(
      {required AudioEffectPreset preset,
      required int param1,
      required int param2});

  /// Sets the parameters for the preset voice beautifier effect.
  ///
  /// Call this method to set the gender characteristics and reverb effect for the singing beautifier. This method applies to the local user who is sending the stream. After setting, all users in the channel can hear the effect.
  /// To achieve better vocal quality, it is recommended to do the following before calling this method:
  ///  Call setAudioScenario to set the audio scenario to high-quality, i.e., audioScenarioGameStreaming (3).
  ///  Call setAudioProfile to set the profile to audioProfileMusicHighQuality (4) or audioProfileMusicHighQualityStereo (5).
  ///  This method can be called before or after joining a channel.
  ///  Do not set the profile parameter of setAudioProfile to audioProfileSpeechStandard (1) or audioProfileIot (6), otherwise this method will not take effect.
  ///  This method provides optimal processing for vocals and is not recommended for audio data containing music.
  ///  After calling setVoiceBeautifierParameters, do not call the following methods, or the effect set by setVoiceBeautifierParameters will be overridden: setAudioEffectPreset setAudioEffectParameters setVoiceBeautifierPreset setLocalVoicePitch setLocalVoiceEqualization setLocalVoiceReverb setVoiceConversionPreset
  ///  This method depends on the voice beautifier dynamic library libagora_audio_beauty_extension.dll. If this library is deleted, the feature will not work properly.
  ///
  /// * [preset] The preset audio effect: SINGING_BEAUTIFIER : Singing beautifier.
  /// * [param1] Gender characteristics of the singing voice: 1 : Male voice. 2 : Female voice.
  /// * [param2] Reverb effect of the singing voice: 1 : Reverb effect in a small room. 2 : Reverb effect in a large room. 3 : Reverb effect in a hall.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setVoiceBeautifierParameters(
      {required VoiceBeautifierPreset preset,
      required int param1,
      required int param2});

  /// @nodoc
  Future<void> setVoiceConversionParameters(
      {required VoiceConversionPreset preset,
      required int param1,
      required int param2});

  /// Sets the local voice pitch.
  ///
  /// * [pitch] Voice frequency. Can be set in the range [0.5, 2.0]. The smaller the value, the lower the pitch. The default value is 1.0, meaning no pitch change.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setLocalVoicePitch(double pitch);

  /// Sets the formant ratio to change the voice timbre.
  ///
  /// Formant ratio is a parameter that affects the timbre of the voice. The smaller the formant ratio, the deeper the voice; the larger the value, the sharper the voice. After setting the formant ratio, all users in the channel can hear the effect. If you want to change both timbre and pitch, Agora recommends using it together with setLocalVoicePitch.
  ///
  /// * [formantRatio] Formant ratio. The range is [-1.0, 1.0]. The default value is 0.0, meaning the original timbre is not changed. Agora recommends using values in the range [-0.4, 0.6]. Effects outside this range may not sound ideal.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setLocalVoiceFormant(double formantRatio);

  /// Sets the local voice equalization.
  ///
  /// * [bandFrequency] Index of the frequency band. The range is [0,9], representing 10 frequency bands. The corresponding center frequencies are [31, 62, 125, 250, 500, 1k, 2k, 4k, 8k, 16k] Hz. See AudioEqualizationBandFrequency.
  /// * [bandGain] Gain of each band in dB. The range for each value is [-15,15], with a default value of 0.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setLocalVoiceEqualization(
      {required AudioEqualizationBandFrequency bandFrequency,
      required int bandGain});

  /// Sets the local voice reverb effect.
  ///
  /// The SDK provides an easier method setAudioEffectPreset to directly apply preset reverb effects such as pop, R&B, KTV, etc. This method can be called before and after joining a channel.
  ///
  /// * [reverbKey] Reverb effect key. This method supports 5 reverb effect keys. See AudioReverbType.
  /// * [value] The value corresponding to each reverb effect key.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setLocalVoiceReverb(
      {required AudioReverbType reverbKey, required int value});

  /// Sets the preset headphone equalizer effect.
  ///
  /// This method is mainly used in spatial audio scenarios. You can select a preset headphone equalizer to listen to audio and achieve the desired audio experience. If your headphones already provide a good equalizing effect, calling this method may not significantly improve the experience and may even degrade it.
  ///
  /// * [preset] Preset headphone equalizer effect. See HeadphoneEqualizerPreset.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setHeadphoneEQPreset(HeadphoneEqualizerPreset preset);

  /// Sets the low-frequency and high-frequency parameters of the headphone equalizer.
  ///
  /// In spatial audio scenarios, if the preset headphone equalizer effect set by calling setHeadphoneEQPreset does not meet expectations, you can call this method to further adjust the headphone equalizer effect.
  ///
  /// * [lowGain] Low-frequency parameter of the headphone equalizer. Value range is [-10,10]. The higher the value, the deeper the sound.
  /// * [highGain] High-frequency parameter of the headphone equalizer. Value range is [-10,10]. The higher the value, the sharper the sound.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setHeadphoneEQParameters(
      {required int lowGain, required int highGain});

  /// Enables or disables the AI tuner feature.
  ///
  /// The AI tuner feature enhances audio quality and adjusts voice tone style.
  ///
  /// * [enabled] Whether to enable the AI tuner feature: true : Enable the AI tuner feature. false : (default) Disable the AI tuner feature.
  /// * [type] AI tuner effect type. See VoiceAiTunerType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> enableVoiceAITuner(
      {required bool enabled, required VoiceAiTunerType type});

  /// Sets the log file.
  ///
  /// Deprecated Deprecated: This method is deprecated. Set the log file path via the context parameter when calling initialize. Sets the output log file of the SDK. All logs generated during SDK runtime will be written to this file. The app must ensure that the specified directory exists and is writable.
  ///
  /// * [filePath] The full path of the log file. The log file is encoded in UTF-8.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setLogFile(String filePath);

  /// Sets the log output level.
  ///
  /// Deprecated Deprecated: Use logConfig in initialize instead. This method sets the log output level of the SDK. Different output levels can be used individually or in combination. The log levels in order are logFilterOff, logFilterCritical, logFilterError, logFilterWarn, logFilterInfo, and logFilterDebug.
  /// By selecting a level, you can see all logs at that level and above.
  /// For example, if you choose logFilterWarn, you will see logs at logFilterCritical, logFilterError, and logFilterWarn levels.
  ///
  /// * [filter] Log filter level. See LogFilterType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setLogFilter(LogFilterType filter);

  /// Sets the SDK log output level.
  ///
  /// Deprecated Deprecated: This method is deprecated. Set the log output level via the context parameter when calling initialize. By selecting a level, you can see the logs at that level.
  ///
  /// * [level] Log level. See LogLevel.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setLogLevel(LogLevel level);

  /// Sets the size of the SDK log file output.
  ///
  /// Deprecated Deprecated: This method is deprecated. Use the logConfig parameter in initialize instead to set the log file size. By default, the SDK generates 5 SDK log files and 5 API call log files with the following rules:
  ///  SDK log file names: agorasdk.log, agorasdk.1.log, agorasdk.2.log, agorasdk.3.log, agorasdk.4.log.
  ///  API call log file names: agoraapi.log, agoraapi.1.log, agoraapi.2.log, agoraapi.3.log, agoraapi.4.log.
  ///  Each SDK log file has a default size of 2,048 KB; API call log files also have a default size of 2,048 KB. All log files are UTF-8 encoded.
  ///  The latest logs are always written to agorasdk.log and agoraapi.log.
  ///  When agorasdk.log is full, the SDK performs the following operations:
  ///  Deletes agorasdk.4.log (if exists).
  ///  Renames agorasdk.3.log to agorasdk.4.log.
  ///  Renames agorasdk.2.log to agorasdk.3.log.
  ///  Renames agorasdk.1.log to agorasdk.2.log.
  ///  Creates a new agorasdk.log file.
  ///  The overwrite rule for agoraapi.log is the same as that of agorasdk.log. This method only sets the size of the agorasdk.log file and does not affect agoraapi.log.
  ///
  /// * [fileSizeInKBytes] The size of a single agorasdk.log file in KB. The valid range is [128, 20480], and the default value is 2,048 KB. If you set fileSizeInKByte to less than 128 KB, the SDK automatically adjusts it to 128 KB; if you set it to more than 20,480 KB, the SDK automatically adjusts it to 20,480 KB.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setLogFileSize(int fileSizeInKBytes);

  /// @nodoc
  Future<String> uploadLogFile();

  /// @nodoc
  Future<void> writeLog({required LogLevel level, required String fmt});

  /// Updates the local view display mode.
  ///
  /// After initializing the local user view, you can call this method to update the rendering and mirror mode of the local user view. This method only affects the video seen by the local user and does not affect the published video. This method only takes effect for the first camera (primaryCameraSource). In scenarios with custom video capture or other types of video sources, you need to use the setupLocalVideo method instead.
  ///
  /// * [renderMode] Local view display mode. See RenderModeType.
  /// * [mirrorMode] Mirror mode for the local view. See VideoMirrorModeType. If you use the front camera, the local user view mirror mode is enabled by default; if you use the rear camera, the mirror mode is disabled by default.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setLocalRenderMode(
      {required RenderModeType renderMode,
      VideoMirrorModeType mirrorMode =
          VideoMirrorModeType.videoMirrorModeAuto});

  /// Updates the display mode of the remote view.
  ///
  /// After initializing the remote user view, you can call this method to update the rendering and mirror mode of the remote user view displayed locally. This method only affects the video seen by the local user.
  ///  Call this method after initializing the remote view using the setupRemoteVideo method.
  ///  You can call this method multiple times during a call to update the display mode of the remote user view.
  ///
  /// * [uid] Remote user ID.
  /// * [renderMode] Rendering mode of the remote user view. See RenderModeType.
  /// * [mirrorMode] Mirror mode of the remote user view. See VideoMirrorModeType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Failure. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setRemoteRenderMode(
      {required int uid,
      required RenderModeType renderMode,
      required VideoMirrorModeType mirrorMode});

  /// Sets the maximum frame rate for local video rendering.
  ///
  /// * [sourceType] Type of video source. See VideoSourceType.
  /// * [targetFps] Maximum rendering frame rate (fps). Supported values: 1, 7, 10, 15, 24, 30, 60. You should set this parameter to a rendering frame rate lower than the actual video frame rate; otherwise, the setting will not take effect.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setLocalRenderTargetFps(
      {required VideoSourceType sourceType, required int targetFps});

  /// Sets the maximum frame rate for remote video rendering.
  ///
  /// * [targetFps] Maximum rendering frame rate (fps). Supported values: 1, 7, 10, 15, 24, 30, 60. You should set this parameter to a rendering frame rate lower than the actual video frame rate; otherwise, the setting will not take effect.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setRemoteRenderTargetFps(int targetFps);

  /// Sets the local video mirror mode.
  ///
  /// Deprecated Deprecated: This method is deprecated.
  ///
  /// * [mirrorMode] Local video mirror mode. See VideoMirrorModeType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setLocalVideoMirrorMode(VideoMirrorModeType mirrorMode);

  /// Enables or disables dual-stream mode on the sending end and configures the low-quality stream.
  ///
  /// Deprecated Deprecated: Deprecated since v4.2.0. Use setDualStreamMode instead. You can call this method on the sending end to enable or disable dual-stream mode. Dual-stream refers to high-quality and low-quality video streams:
  ///  High-quality stream: High resolution and high frame rate video stream.
  ///  Low-quality stream: Low resolution and low frame rate video stream. After enabling dual-stream mode, you can call setRemoteVideoStreamType on the receiving end to choose whether to receive the high-quality or low-quality stream.
  ///  This method applies to all types of streams sent by the sender, including but not limited to camera-captured video, screen sharing, and custom-captured video.
  ///  To enable dual-stream mode in multi-channel scenarios, call enableDualStreamModeEx.
  ///  This method can be called before or after joining a channel.
  ///
  /// * [enabled] Whether to enable dual-stream mode: true : Enable dual-stream mode. false : (Default) Disable dual-stream mode.
  /// * [streamConfig] Configuration for the low-quality stream. See SimulcastStreamConfig. When mode is set to disableSimulcastStream, setting streamConfig has no effect.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> enableDualStreamMode(
      {required bool enabled, SimulcastStreamConfig? streamConfig});

  /// Sets the dual-stream mode on the sender and configures the low-quality video stream.
  ///
  /// The SDK enables the adaptive low-quality stream mode (autoSimulcastStream) by default on the sender, meaning the sender does not actively send low-quality streams. Receivers with host roles can call setRemoteVideoStreamType to request low-quality streams. After receiving the request, the sender automatically starts sending low-quality streams.
  ///  If you want to change this behavior, you can call this method and set mode to disableSimulcastStream (never send low-quality streams) or enableSimulcastStream (always send low-quality streams).
  ///  If you want to revert to the default behavior after modification, call this method again and set mode to autoSimulcastStream. The differences and relationships between this method and enableDualStreamMode are as follows:
  ///  Calling this method and setting mode to disableSimulcastStream has the same effect as calling enableDualStreamMode with enabled set to false.
  ///  Calling this method and setting mode to enableSimulcastStream has the same effect as calling enableDualStreamMode with enabled set to true.
  ///  Both methods can be called before or after joining a channel. If both are used, the settings in the later call take effect.
  ///
  /// * [mode] The mode for sending video streams. See SimulcastStreamMode.
  /// * [streamConfig] The configuration of the low-quality video stream. See SimulcastStreamConfig. When mode is set to disableSimulcastStream, setting streamConfig has no effect.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setDualStreamMode(
      {required SimulcastStreamMode mode, SimulcastStreamConfig? streamConfig});

  /// @nodoc
  Future<void> setSimulcastConfig(SimulcastConfig simulcastConfig);

  /// Sets whether to play the external audio source locally.
  ///
  /// After calling this method to enable local playback of the externally captured audio source, to stop local playback, you can call this method again and set enabled to false.
  /// You can call adjustCustomAudioPlayoutVolume to adjust the local playback volume of the custom audio track. Before calling this method, make sure you have already called createCustomAudioTrack to create a custom audio track.
  ///
  /// * [trackId] Audio track ID. Set this parameter to the custom audio track ID returned by the createCustomAudioTrack method.
  /// * [enabled] Whether to play the external audio source locally: true : Play locally. false : (Default) Do not play locally.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> enableCustomAudioLocalPlayback(
      {required int trackId, required bool enabled});

  /// Sets the format of the raw audio data for capture.
  ///
  /// The SDK calculates the sampling interval using the samplesPerCall, sampleRate, and channel parameters in this method. The formula is: sampling interval = samplesPerCall / (sampleRate × channel). Ensure the sampling interval is no less than 0.01 seconds. The SDK triggers the onRecordAudioFrame callback based on this interval.
  ///
  /// * [sampleRate] The sample rate (Hz) of the audio data. You can set it to 8000, 16000, 32000, 44100, or 48000.
  /// * [channel] The number of audio channels. You can set it to 1 or 2:
  ///  1: Mono.
  ///  2: Stereo.
  /// * [mode] The usage mode of the audio frame. See RawAudioFrameOpModeType.
  /// * [samplesPerCall] The number of audio samples per call. Typically 1024 in scenarios like RTMP streaming.
  ///
  /// Returns
  /// This method returns no value if the call succeeds. If the method call fails, it throws an AgoraRtcException, which you need to catch and handle. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and troubleshooting suggestions.
  ///  < 0: Failure. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and troubleshooting suggestions.
  Future<void> setRecordingAudioFrameParameters(
      {required int sampleRate,
      required int channel,
      required RawAudioFrameOpModeType mode,
      required int samplesPerCall});

  /// Sets the format of the raw audio data for playback.
  ///
  /// The SDK calculates the sampling interval using the samplesPerCall, sampleRate, and channel parameters in this method. The formula is: sampling interval = samplesPerCall / (sampleRate × channel). Ensure the sampling interval is no less than 0.01 seconds. The SDK triggers the onPlaybackAudioFrame callback based on this interval.
  ///
  /// * [sampleRate] The sample rate (Hz) of the audio data. You can set it to 8000, 16000, 24000, 32000, 44100, or 48000.
  /// * [channel] The number of audio channels. You can set it to 1 or 2:
  ///  1: Mono.
  ///  2: Stereo.
  /// * [mode] The usage mode of the audio frame. See RawAudioFrameOpModeType.
  /// * [samplesPerCall] The number of audio samples per call. Typically 1024 in scenarios like RTMP streaming.
  ///
  /// Returns
  /// This method returns no value if the call succeeds. If the method call fails, it throws an AgoraRtcException, which you need to catch and handle. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and troubleshooting suggestions.
  ///  < 0: Failure. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and troubleshooting suggestions.
  Future<void> setPlaybackAudioFrameParameters(
      {required int sampleRate,
      required int channel,
      required RawAudioFrameOpModeType mode,
      required int samplesPerCall});

  /// Sets the format of the raw audio data after audio mixing for capture and playback.
  ///
  /// The SDK calculates the sampling interval using the samplesPerCall, sampleRate, and channel parameters in this method. The formula is: sampling interval = samplesPerCall / (sampleRate × channel). Ensure the sampling interval is no less than 0.01 seconds. The SDK triggers the onMixedAudioFrame callback based on this interval.
  ///
  /// * [sampleRate] The sample rate (Hz) of the audio data. You can set it to 8000, 16000, 32000, 44100, or 48000.
  /// * [channel] The number of audio channels. You can set it to 1 or 2:
  ///  1: Mono.
  ///  2: Stereo.
  /// * [samplesPerCall] The number of audio samples per call. Typically 1024 in scenarios like RTMP streaming.
  ///
  /// Returns
  /// This method returns no value if the call succeeds. If the method call fails, it throws an AgoraRtcException, which you need to catch and handle. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and troubleshooting suggestions.
  Future<void> setMixedAudioFrameParameters(
      {required int sampleRate,
      required int channel,
      required int samplesPerCall});

  /// Sets the data format for the onEarMonitoringAudioFrame callback.
  ///
  /// This method sets the data format for the onEarMonitoringAudioFrame callback.
  ///  Before calling this method, you need to call enableInEarMonitoring and set includeAudioFilters to earMonitoringFilterBuiltInAudioFilters or earMonitoringFilterNoiseSuppression.
  ///  The SDK calculates the sampling interval using the samplesPerCall, sampleRate, and channel parameters in this method. The formula is: sampling interval = samplesPerCall / (sampleRate × channel). Ensure the sampling interval is no less than 0.01 seconds. The SDK triggers the onEarMonitoringAudioFrame callback based on this interval.
  ///
  /// * [sampleRate] Sampling rate (Hz) of the audio reported in onEarMonitoringAudioFrame, can be set to 8000, 16000, 32000, 44100, or 48000.
  /// * [channel] Number of audio channels reported in onEarMonitoringAudioFrame, can be set to 1 or 2:
  ///  1: Mono.
  ///  2: Stereo.
  /// * [mode] Usage mode of the audio frame. See RawAudioFrameOpModeType.
  /// * [samplesPerCall] Number of audio samples reported in onEarMonitoringAudioFrame, typically 1024 in applications like push streaming.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: The method call fails. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setEarMonitoringAudioFrameParameters(
      {required int sampleRate,
      required int channel,
      required RawAudioFrameOpModeType mode,
      required int samplesPerCall});

  /// Sets the format of the raw audio playback data before mixing.
  ///
  /// The SDK triggers the onPlaybackAudioFrameBeforeMixing callback based on the sampling interval.
  ///
  /// * [sampleRate] The sample rate (Hz) of the audio data. You can set it to 8000, 16000, 32000, 44100, or 48000.
  /// * [channel] The number of audio channels. You can set it to 1 or 2:
  ///  1: Mono.
  ///  2: Stereo.
  /// * [samplesPerCall] Sets the number of audio samples returned in the onPlaybackAudioFrameBeforeMixing callback. In RTMP streaming scenarios, it is recommended to set this to 1024.
  ///
  /// Returns
  /// This method returns no value if the call succeeds. If the method call fails, it throws an AgoraRtcException, which you need to catch and handle. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and troubleshooting suggestions.
  Future<void> setPlaybackAudioFrameBeforeMixingParameters(
      {required int sampleRate, required int channel});

  /// Enables audio spectrum monitoring.
  ///
  /// If you want to obtain audio spectrum data of local or remote users, register an audio spectrum observer and enable audio spectrum monitoring. You can call this method either before or after joining a channel.
  ///
  /// * [intervalInMS] The time interval (in milliseconds) at which the SDK triggers the onLocalAudioSpectrum and onRemoteAudioSpectrum callbacks. The default value is 100 ms. The value must not be less than 10 ms, otherwise the method call fails.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> enableAudioSpectrumMonitor({int intervalInMS = 100});

  /// Disables audio spectrum monitoring.
  ///
  /// After calling enableAudioSpectrumMonitor, if you want to disable audio spectrum monitoring, call this method. This method can be called before or after joining a channel.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> disableAudioSpectrumMonitor();

  /// Registers an audio spectrum observer.
  ///
  /// After successfully registering an audio spectrum observer and calling enableAudioSpectrumMonitor to enable audio spectrum monitoring, the SDK reports the callbacks implemented in the AudioSpectrumObserver class at the interval you set. This method can be called before or after joining a channel.
  ///
  /// * [observer] Audio spectrum observer. See AudioSpectrumObserver.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  void registerAudioSpectrumObserver(AudioSpectrumObserver observer);

  /// Unregisters the audio spectrum observer.
  ///
  /// After calling registerAudioSpectrumObserver, if you want to unregister the audio spectrum observer, call this method. This method can be called before or after joining a channel.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  void unregisterAudioSpectrumObserver(AudioSpectrumObserver observer);

  /// Adjusts the volume of the audio recording signal.
  ///
  /// If you only need to mute the audio signal, it is recommended to use muteRecordingSignal.
  ///
  /// * [volume] Volume. The range is [0,400].
  ///  0: Mute.
  ///  100: (Default) Original volume.
  ///  400: 4 times the original volume, with built-in overflow protection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> adjustRecordingSignalVolume(int volume);

  /// Mutes the recording signal.
  ///
  /// If you have already called adjustRecordingSignalVolume to adjust the volume of the recorded audio signal, calling this method and setting it to true will cause the SDK to:
  ///  Record the adjusted volume.
  ///  Mute the recording signal. When you call this method again with false, the recording signal will be restored to the volume recorded by the SDK before muting.
  ///
  /// * [mute] true : Mute. false : (default) Original volume.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> muteRecordingSignal(bool mute);

  /// Adjusts the signal volume of all remote users for local playback.
  ///
  /// This method adjusts the signal volume of all remote users after mixing for local playback. If you need to adjust the signal volume of a specific remote user for local playback, it is recommended to call adjustUserPlaybackSignalVolume.
  ///
  /// * [volume] Volume, range is [0,400].
  ///  0: Mute.
  ///  100: (Default) Original volume.
  ///  400: 4 times the original volume, with built-in overflow protection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> adjustPlaybackSignalVolume(int volume);

  /// Adjusts the playback volume of a specified remote user locally.
  ///
  /// You can call this method during a call to adjust the playback volume of a specified remote user locally. To adjust the playback volume of multiple users, call this method multiple times.
  ///
  /// * [uid] The ID of the remote user.
  /// * [volume] The volume, with a range of [0,400].
  ///  0: Mute.
  ///  100: (Default) Original volume.
  ///  400: Four times the original volume, with built-in overflow protection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> adjustUserPlaybackSignalVolume(
      {required int uid, required int volume});

  /// @nodoc
  Future<void> setLocalPublishFallbackOption(StreamFallbackOptions option);

  /// Sets the fallback option for subscribed audio and video streams under poor network conditions.
  ///
  /// In poor network conditions, the quality of real-time audio and video communication may degrade. You can call this method and set option to streamFallbackOptionVideoStreamLow or streamFallbackOptionAudioOnly. The SDK will switch the video stream to a lower stream or disable the video stream when the downlink network is poor and audio/video quality is severely affected, to ensure audio quality. The SDK continuously monitors network quality and resumes the audio and video stream subscription when the network improves.
  /// When the subscription falls back to audio only or recovers to audio and video, the SDK triggers the onRemoteSubscribeFallbackToAudioOnly callback.
  ///
  /// * [option] Fallback option for the subscribed stream. See StreamFallbackOptions.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setRemoteSubscribeFallbackOption(StreamFallbackOptions option);

  /// @nodoc
  Future<void> setHighPriorityUserList(
      {required List<int> uidList,
      required int uidNum,
      required StreamFallbackOptions option});

  /// Enables or disables an extension.
  ///
  /// To enable multiple extensions, you need to call this method multiple times.
  ///  After this method is called successfully, no other extensions can be loaded.
  ///
  /// * [provider] The name of the extension provider.
  /// * [extension] The name of the extension.
  /// * [enable] Whether to enable the extension: true : Enable the extension. false : Disable the extension.
  /// * [type] The media source type of the extension. See MediaSourceType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> enableExtension(
      {required String provider,
      required String extension,
      bool enable = true,
      MediaSourceType type = MediaSourceType.unknownMediaSource});

  /// Sets an extension property.
  ///
  /// After enabling the extension, you can call this method to set its properties. To set properties for multiple extensions, call this method multiple times.
  ///
  /// * [provider] The name of the extension provider.
  /// * [extension] The name of the extension.
  /// * [key] The key of the extension property.
  /// * [value] The value corresponding to the extension property key.
  /// * [type] The media source type of the extension. See MediaSourceType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setExtensionProperty(
      {required String provider,
      required String extension,
      required String key,
      required String value,
      MediaSourceType type = MediaSourceType.unknownMediaSource});

  /// Retrieves detailed information about the extension.
  ///
  /// * [provider] The name of the extension provider.
  /// * [extension] The name of the extension.
  /// * [key] The key of the extension property.
  /// * [bufLen] The maximum length of the extension property JSON string. The maximum value is 512 bytes.
  /// * [type] The media source type of the extension. See MediaSourceType.
  ///
  /// Returns
  /// If the method call succeeds, returns the extension information.
  ///  If the method call fails, returns an empty string.
  Future<String> getExtensionProperty(
      {required String provider,
      required String extension,
      required String key,
      required int bufLen,
      MediaSourceType type = MediaSourceType.unknownMediaSource});

  /// Enables sound card capture.
  ///
  /// After enabling the sound card capture function, the sound played by the sound card is mixed into the local audio stream and can be sent to the remote side.
  ///  This method is only applicable to macOS and Windows platforms.
  ///  This method can be called before or after joining a channel.
  ///  If you call disableAudio to disable the audio module, the sound card capture function will also be disabled. To re-enable it, you must call enableAudio to enable the audio module, and then call enableLoopbackRecording again.
  ///
  /// * [enabled] Whether to enable sound card capture: true : Enable sound card capture; the virtual sound card name is displayed in System Sound > Output. false : (Default) Disable sound card capture; the virtual sound card name is not displayed in System Sound > Output.
  /// * [deviceName] macOS: Device name of the virtual sound card. Default is empty, which means using the AgoraALD virtual sound card for capture.
  ///  Windows: Device name of the sound card. Default is empty, which means using the built-in sound card of the device for capture.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> enableLoopbackRecording(
      {required bool enabled, String? deviceName});

  /// Adjusts the volume of the signal captured by the sound card.
  ///
  /// After calling enableLoopbackRecording to enable sound card capture, you can call this method to adjust the volume of the signal captured by the sound card.
  ///
  /// * [volume] The volume of the music file. The range is 0~100. 100 (default) represents the original volume of the file.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: The method call fails. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> adjustLoopbackSignalVolume(int volume);

  /// @nodoc
  Future<int> getLoopbackRecordingVolume();

  /// Enables in-ear monitoring.
  ///
  /// This method enables or disables in-ear monitoring. The user must use headphones (wired or Bluetooth) to hear the in-ear monitoring effect.
  ///
  /// * [enabled] Enable/disable in-ear monitoring: true : Enable in-ear monitoring. false : (Default) Disable in-ear monitoring.
  /// * [includeAudioFilters] The audio filter type for in-ear monitoring. See EarMonitoringFilterType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> enableInEarMonitoring(
      {required bool enabled,
      required EarMonitoringFilterType includeAudioFilters});

  /// Sets the in-ear monitoring volume.
  ///
  /// * [volume] Volume, range is [0,400].
  ///  0: Mute.
  ///  100: (default) Original volume.
  ///  400: 4 times the original volume, with overflow protection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setInEarMonitoringVolume(int volume);

  /// Loads an extension.
  ///
  /// This method adds external SDK extensions (such as marketplace or SDK extension plugins) into the SDK. To load multiple extensions, call this method multiple times.
  /// This method is available only on Windows and Android.
  ///
  /// * [path] The path and name of the extension dynamic library. For example: /library/libagora_segmentation_extension.dll.
  /// * [unloadAfterUse] Whether to automatically unload the extension after use: true : Automatically unloads the extension when RtcEngine is destroyed. false : Does not automatically unload the extension until the process exits (recommended).
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> loadExtensionProvider(
      {required String path, bool unloadAfterUse = false});

  /// Sets a property for the extension provider.
  ///
  /// You can call this method to set the properties of the extension provider and initialize related parameters based on the provider type. To set properties for multiple extension providers, call this method multiple times.
  ///
  /// * [provider] The name of the extension provider.
  /// * [key] The key of the extension property.
  /// * [value] The value corresponding to the extension property key.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setExtensionProviderProperty(
      {required String provider, required String key, required String value});

  /// Registers an extension.
  ///
  /// For external SDK extensions (such as marketplace or SDK extension plugins), after loading the extension, you need to call this method to register it. Internal SDK extensions (those included in the SDK package) are automatically loaded and registered after initializing RtcEngine, so you do not need to call this method.
  ///  To register multiple extensions, call this method multiple times.
  ///  The order in which different extensions process data in the SDK is determined by the registration order. That is, extensions registered earlier process data first.
  ///
  /// * [provider] The name of the extension provider.
  /// * [extension] The name of the extension.
  /// * [type] The media source type of the extension. See MediaSourceType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> registerExtension(
      {required String provider,
      required String extension,
      MediaSourceType type = MediaSourceType.unknownMediaSource});

  /// Sets the camera capture configuration.
  ///
  /// Before adjusting the camera focal length configuration, it is recommended to call queryCameraFocalLengthCapability to check the supported focal length capabilities of the device, and then configure accordingly.
  /// Due to limitations of some Android devices, the configuration may not take effect even if you set the focal length type based on the result of queryCameraFocalLengthCapability.
  ///
  /// * [config] Camera capture configuration. See CameraCapturerConfiguration. You do not need to set the deviceId parameter in this method.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Method call failed. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setCameraCapturerConfiguration(
      CameraCapturerConfiguration config);

  /// Creates a custom video track.
  ///
  /// When you need to publish custom captured video in a channel, follow these steps:
  ///  Call this method to create a video track and get the video track ID.
  ///  When calling joinChannel to join a channel, set customVideoTrackId in ChannelMediaOptions to the video track ID you want to publish and set publishCustomVideoTrack to true.
  ///  Call pushVideoFrame and specify videoTrackId as the video track ID from step 2 to publish the corresponding custom video source in the channel.
  ///
  /// Returns
  /// If the method call succeeds, returns the video track ID as the unique identifier of the video track.
  ///  If the method call fails, returns 0xffffffff. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<int> createCustomVideoTrack();

  /// @nodoc
  Future<int> createCustomEncodedVideoTrack(SenderOptions senderOption);

  /// Destroys the specified video track.
  ///
  /// * [videoTrackId] The video track ID returned by the createCustomVideoTrack method.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> destroyCustomVideoTrack(int videoTrackId);

  /// @nodoc
  Future<void> destroyCustomEncodedVideoTrack(int videoTrackId);

  /// Switches between front and rear cameras.
  ///
  /// You can call this method during app runtime to dynamically switch cameras based on the actual availability of cameras, without restarting the video stream or reconfiguring the video source. This method is applicable only to Android and iOS.
  /// This method only switches the camera for the first video stream captured by the camera, that is, the video source set to videoSourceCamera (0) when calling startCameraCapture.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> switchCamera();

  /// Checks whether the device supports camera zoom.
  ///
  /// This method is only applicable to Android and iOS.
  ///
  /// Returns
  /// true : The device supports camera zoom. false : The device does not support camera zoom.
  Future<bool> isCameraZoomSupported();

  /// Checks whether the device camera supports face detection.
  ///
  /// This method is only applicable to Android and iOS.
  ///  You must call this method after the SDK triggers the onLocalVideoStateChanged callback and the local video state returns localVideoStreamStateCapturing (1).
  ///
  /// Returns
  /// true : The device camera supports face detection. false : The device camera does not support face detection.
  Future<bool> isCameraFaceDetectSupported();

  /// Checks whether the device supports keeping the flashlight on.
  ///
  /// This method is only applicable to Android and iOS.
  ///  You must call this method after the SDK triggers the onLocalVideoStateChanged callback and the local video state returns localVideoStreamStateCapturing (1).
  ///  Typically, the app enables the front camera by default. If your front camera does not support keeping the flashlight on, this method returns false. If you want to check whether the rear camera supports keeping the flashlight on, you need to call switchCamera to switch the camera before using this method.
  ///  On iPads with system version 15, even if isCameraTorchSupported returns true, due to system issues, you may still fail to turn on the flashlight using setCameraTorchOn.
  ///
  /// Returns
  /// true : The device supports keeping the flashlight on. false : The device does not support keeping the flashlight on.
  Future<bool> isCameraTorchSupported();

  /// Checks whether the device supports manual focus.
  ///
  /// This method is only applicable to Android and iOS.
  ///  You must call this method after the SDK triggers the onLocalVideoStateChanged callback and the local video state returns localVideoStreamStateCapturing (1).
  ///
  /// Returns
  /// true : The device supports manual focus. false : The device does not support manual focus.
  Future<bool> isCameraFocusSupported();

  /// Checks whether the device supports face auto-focus.
  ///
  /// This method is only applicable to Android and iOS.
  ///  Call this method after the SDK triggers the onLocalVideoStateChanged callback and returns the local video state as localVideoStreamStateCapturing (1).
  ///
  /// Returns
  /// true : The device supports face auto-focus. false : The device does not support face auto-focus.
  Future<bool> isCameraAutoFocusFaceModeSupported();

  /// Sets the camera zoom factor.
  ///
  /// Some iOS devices use a composite rear camera consisting of multiple lenses, such as dual cameras (wide-angle and ultra-wide-angle) or triple cameras (wide-angle, ultra-wide-angle, and telephoto). For such composite lenses with ultra-wide-angle capability, you can call setCameraCapturerConfiguration to set cameraFocalLengthType to cameraFocalLengthDefault (0) (standard lens), and then call this method to set the camera zoom factor to a value less than 1.0 to achieve an ultra-wide-angle shooting effect.
  ///  This method is applicable only to Android and iOS.
  ///  You must call this method after enableVideo. The setting takes effect after the camera is successfully started, that is, when the SDK triggers the onLocalVideoStateChanged callback and returns the local video state as localVideoStreamStateCapturing (1).
  ///
  /// * [factor] Camera zoom factor. For devices that do not support ultra-wide-angle, the value ranges from 1.0 to the maximum zoom factor; for devices that support ultra-wide-angle, the value ranges from 0.5 to the maximum zoom factor. You can call getCameraMaxZoomFactor to get the maximum zoom factor supported by the device.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  Failure: return value < 0.
  Future<void> setCameraZoomFactor(double factor);

  /// Enables/disables local face detection.
  ///
  /// * [enabled] Whether to enable face detection: true : Enables face detection. false : (Default) Disables face detection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> enableFaceDetection(bool enabled);

  /// Gets the maximum zoom factor supported by the camera.
  ///
  /// This method is only applicable to Android and iOS.
  ///  Call this method after the SDK triggers the onLocalVideoStateChanged callback and returns the local video state as localVideoStreamStateCapturing (1).
  ///
  /// Returns
  /// The maximum zoom factor supported by the device camera.
  Future<double> getCameraMaxZoomFactor();

  /// Sets the manual focus position and triggers focusing.
  ///
  /// This method is applicable to Android and iOS only.
  ///  You must call this method after enableVideo. The setting takes effect after the camera is successfully turned on, i.e., after the SDK triggers the onLocalVideoStateChanged callback and the local video state is localVideoStreamStateCapturing (1).
  ///  After this method is successfully called, the local client triggers the onCameraFocusAreaChanged callback.
  ///
  /// * [positionX] The horizontal coordinate of the touch point relative to the view.
  /// * [positionY] The vertical coordinate of the touch point relative to the view.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setCameraFocusPositionInPreview(
      {required double positionX, required double positionY});

  /// Sets whether to turn on the flashlight.
  ///
  /// This method is applicable to Android and iOS only.
  ///  You must call this method after enableVideo. The setting takes effect after the camera is successfully turned on, i.e., after the SDK triggers the onLocalVideoStateChanged callback and the local video state is localVideoStreamStateCapturing (1).
  ///
  /// * [isOn] Whether to turn on the flashlight: true : Turn on the flashlight. false : (default) Turn off the flashlight.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setCameraTorchOn(bool isOn);

  /// Sets whether to enable face auto-focus.
  ///
  /// By default, the SDK disables face auto-focus on Android and enables it on iOS. If you want to manually set face auto-focus, call this method. This method is applicable to Android and iOS only.
  ///
  /// * [enabled] Whether to enable face auto-focus: true : Enable face auto-focus. false : Disable face auto-focus.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setCameraAutoFocusFaceModeEnabled(bool enabled);

  /// Checks whether the device supports manual exposure.
  ///
  /// This method is only applicable to Android and iOS.
  ///  Call this method after the SDK triggers the onLocalVideoStateChanged callback and returns the local video state as localVideoStreamStateCapturing (1).
  ///
  /// Returns
  /// true : The device supports manual exposure. false : The device does not support manual exposure.
  Future<bool> isCameraExposurePositionSupported();

  /// Sets the manual exposure position.
  ///
  /// This method is applicable to Android and iOS only.
  ///  You must call this method after enableVideo. The setting takes effect after the camera is successfully turned on, i.e., after the SDK triggers the onLocalVideoStateChanged callback and the local video state is localVideoStreamStateCapturing (1).
  ///  After this method is successfully called, the local client triggers the onCameraExposureAreaChanged callback.
  ///
  /// * [positionXinView] The horizontal coordinate of the touch point relative to the view.
  /// * [positionYinView] The vertical coordinate of the touch point relative to the view.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setCameraExposurePosition(
      {required double positionXinView, required double positionYinView});

  /// Checks whether the current camera supports exposure adjustment.
  ///
  /// This method is only applicable to Android and iOS.
  ///  You must call this method after the SDK triggers the onLocalVideoStateChanged callback and the local video state returns localVideoStreamStateCapturing (1).
  ///  It is recommended to call this method to check whether the current camera supports exposure adjustment before calling setCameraExposureFactor to adjust the exposure factor.
  ///  This method checks whether the currently used camera supports exposure adjustment, i.e., the camera specified when calling setCameraCapturerConfiguration.
  ///
  /// Returns
  /// true : The method call succeeds. false : The method call fails. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<bool> isCameraExposureSupported();

  /// Sets the exposure factor of the current camera.
  ///
  /// When the lighting in the shooting environment is insufficient or too bright, it affects the quality of video capture. To achieve better video effects, you can use this method to adjust the camera's exposure factor.
  ///  This method is applicable to Android and iOS only.
  ///  You must call this method after enableVideo. The setting takes effect after the camera is successfully turned on, i.e., after the SDK triggers the onLocalVideoStateChanged callback and the local video state is localVideoStreamStateCapturing (1).
  ///  It is recommended to call isCameraExposureSupported before using this method to check whether the current camera supports adjusting the exposure factor.
  ///  When you call this method, it sets the exposure factor for the currently used camera, which is the one specified in setCameraCapturerConfiguration.
  ///
  /// * [factor] Exposure factor of the camera. The default value is 0, which means using the camera's default exposure level. The larger the value, the higher the exposure. When the video image is overexposed, you can reduce the exposure factor; when the image is underexposed and dark details are lost, you can increase the exposure factor. If the specified exposure factor exceeds the supported range of the device, the SDK automatically adjusts it to the supported range.
  /// On Android, the range is [-20.0, 20.0]; on iOS, the range is [-8.0, 8.0].
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setCameraExposureFactor(double factor);

  /// Checks whether the device supports auto exposure.
  ///
  /// Returns
  /// true : The device supports auto exposure. false : The device does not support auto exposure.
  Future<bool> isCameraAutoExposureFaceModeSupported();

  /// Enables or disables the auto exposure feature.
  ///
  /// * [enabled] Whether to enable auto exposure: true : Enable auto exposure. false : Disable auto exposure.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setCameraAutoExposureFaceModeEnabled(bool enabled);

  /// Sets the camera stabilization mode.
  ///
  /// Camera stabilization mode is disabled by default. You need to call this method to enable it and set the appropriate stabilization mode. This method is for iOS only.
  ///  Camera stabilization only takes effect when the video resolution is greater than 1280 × 720.
  ///  The higher the stabilization level, the narrower the camera's field of view and the greater the camera delay. To ensure user experience, it is recommended to set the mode parameter to cameraStabilizationModeLevel1.
  ///
  /// * [mode] Camera stabilization mode. See CameraStabilizationMode.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setCameraStabilizationMode(CameraStabilizationMode mode);

  /// Sets the default audio route.
  ///
  /// Mobile devices typically have two audio routes: the earpiece at the top, which has lower volume, and the speaker at the bottom, which has higher volume. Setting the default audio route determines whether the system uses the earpiece or speaker to play audio when no external device is connected.
  /// The system default audio route varies by scenario:
  ///  Voice call: Earpiece
  ///  Voice live broadcast: Speaker
  ///  Video call: Speaker
  ///  Video live broadcast: Speaker Calling this API allows you to change the default audio route described above. This method is applicable only on Android and iOS platforms.
  /// After setting the default audio route using this method, the actual audio route may change depending on the connection of external audio devices (wired or Bluetooth headsets). See [Audio Routing](https://doc.shengwang.cn/doc/rtc/android/advanced-features/audio-route) for details.
  ///
  /// * [defaultToSpeaker] Whether to use the speaker as the default audio route: true : Set the default audio route to speaker. false : Set the default audio route to earpiece.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setDefaultAudioRouteToSpeakerphone(bool defaultToSpeaker);

  /// Enables or disables speakerphone playback.
  ///
  /// For the SDK's default audio routes in different scenarios, see [Audio Routing](https://doc.shengwang.cn/doc/rtc/android/advanced-features/audio-route). This method is applicable only on Android and iOS platforms.
  ///  This method only sets the audio route used by the user in the current channel and does not affect the SDK's default audio route. If the user leaves the current channel and joins a new one, the SDK's default audio route will still be used.
  ///  If the user uses external audio playback devices such as Bluetooth or wired headsets, this method has no effect. Audio will only be played through external devices. If multiple external devices are connected, audio is played through the last connected device.
  ///
  /// * [speakerOn] Whether to enable speakerphone playback: true : Enable. Audio is routed to the speaker. false : Disable. Audio is routed to the earpiece.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setEnableSpeakerphone(bool speakerOn);

  /// Checks whether the speakerphone is enabled.
  ///
  /// This method is applicable only on Android and iOS.
  ///
  /// Returns
  /// true : The speakerphone is enabled, and audio is routed to the speaker. false : The speakerphone is not enabled, and audio is routed to a non-speaker device (earpiece, headset, etc.).
  Future<bool> isSpeakerphoneEnabled();

  /// Selects the audio route in communication volume mode.
  ///
  /// This method is used in communication volume mode ([MODE_IN_COMMUNICATION](https://developer.android.google.cn/reference/kotlin/android/media/AudioManager?hl=en#mode_in_communication)) to switch the audio route from a Bluetooth headset to the earpiece, wired headset, or speaker. This method is applicable only on Android.
  /// Using this method together with setEnableSpeakerphone may cause conflicts. Agora recommends using setRouteInCommunicationMode alone.
  ///
  /// * [route] The desired audio route:
  ///  -1: System default audio route.
  ///  0: Headset with microphone.
  ///  1: Earpiece.
  ///  2: Headset without microphone.
  ///  3: Built-in speaker.
  ///  4: (Not supported) External speaker.
  ///  5: Bluetooth headset.
  ///  6: USB device.
  ///
  /// Returns
  /// No practical meaning.
  Future<void> setRouteInCommunicationMode(int route);

  /// Checks whether the camera supports Center Stage.
  ///
  /// Before calling enableCameraCenterStage to enable the Center Stage feature, it is recommended to call this method to check whether the current device supports Center Stage. This method is applicable to iOS and macOS only.
  ///
  /// Returns
  /// true : The current camera supports Center Stage. false : The current camera does not support Center Stage.
  Future<bool> isCameraCenterStageSupported();

  /// Enables or disables the Center Stage feature.
  ///
  /// The Center Stage feature is disabled by default. You need to call this method to enable it. To disable the feature, call this method again and set enabled to false. This method is applicable to iOS and macOS only.
  /// As this feature requires high device performance, you need to use it on the following or higher-end devices:
  ///  iPad:
  ///  12.9-inch iPad Pro (5th generation)
  ///  11-inch iPad Pro (3rd generation)
  ///  iPad (9th generation)
  ///  iPad mini (6th generation)
  ///  iPad Air (5th generation)
  ///  2020 M1 MacBook Pro 13-inch + iPhone 11 (using iPhone as an external camera for MacBook) Agora recommends that you call isCameraCenterStageSupported to check whether the current device supports Center Stage before enabling this feature.
  ///
  /// * [enabled] Whether to enable the Center Stage feature: true : Enable Center Stage. false : Disable Center Stage.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> enableCameraCenterStage(bool enabled);

  /// Gets the list of shareable screen and window objects.
  ///
  /// Before screen or window sharing, you can call this method to get a list of shareable screen and window objects, allowing users to select a screen or window to share via thumbnails in the list. The list contains important information such as window ID and screen ID. After obtaining the ID, you can call startScreenCaptureByWindowId or startScreenCaptureByDisplayId to start sharing. This method is only applicable to macOS and Windows.
  ///
  /// * [thumbSize] The target size (in pixels) of the thumbnail for the screen or window. The SDK scales the original image to match the longest side of the target size while maintaining the aspect ratio. For example, if the original size is 400 × 300 and thumbSize is 100 × 100, the actual thumbnail size is 100 × 75. If the target size is larger than the original, the thumbnail is the original image and no scaling is applied.
  /// * [iconSize] The target size (in pixels) of the icon corresponding to the application. The SDK scales the original image to match the longest side of the target size while maintaining the aspect ratio. For example, if the original size is 400 × 300 and iconSize is 100 × 100, the actual icon size is 100 × 75. If the target size is larger than the original, the icon is the original image and no scaling is applied.
  /// * [includeScreen] Whether the SDK returns screen information in addition to window information: true : SDK returns both screen and window information. false : SDK returns only window information.
  ///
  /// Returns
  /// An array of ScreenCaptureSourceInfo.
  Future<List<ScreenCaptureSourceInfo>> getScreenCaptureSources(
      {required SIZE thumbSize,
      required SIZE iconSize,
      required bool includeScreen});

  /// Sets the SDK's permission to operate the Audio Session.
  ///
  /// By default, both the SDK and the App have permission to operate the Audio Session. If you only want the App to operate the Audio Session, you can call this method to restrict the SDK's permission.
  /// This method can be called before or after joining a channel. Once called, the restriction takes effect when the SDK needs to modify the Audio Session.
  ///  This method is applicable to iOS only.
  ///  This method does not restrict the App's permission to operate the Audio Session.
  ///
  /// * [restriction] SDK's permission to operate the Audio Session. See AudioSessionOperationRestriction. This parameter is a bit mask, where each bit corresponds to a permission.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setAudioSessionOperationRestriction(
      AudioSessionOperationRestriction restriction);

  /// Starts capturing the video stream of the specified screen.
  ///
  /// Captures the video stream of a screen or a specific region of the screen. This method is only applicable to Windows and macOS.
  ///
  /// * [displayId] Specifies the ID of the screen to be shared. On Windows, if you want to share two screens (primary + secondary) simultaneously, you can set displayId to -1 when calling this method.
  /// * [regionRect] (Optional) Specifies the position of the region to be shared relative to the entire screen. To share the entire screen, set to nil.
  /// See Rectangle.
  /// * [captureParams] Configuration parameters for screen sharing. The default video encoding resolution is 1920 × 1080, i.e., 2,073,600 pixels. This pixel count is used for billing. See ScreenCaptureParameters. The video properties of the screen sharing stream only need to be configured through this parameter and are unrelated to setVideoEncoderConfiguration.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> startScreenCaptureByDisplayId(
      {required int displayId,
      required Rectangle regionRect,
      required ScreenCaptureParameters captureParams});

  /// Starts capturing the video stream of a specified screen region.
  ///
  /// Deprecated Deprecated: This method is deprecated. Use startScreenCaptureByDisplayId instead. If you need to enable screen sharing with external displays, it is strongly recommended to use startScreenCaptureByDisplayId. Shares a screen or a specific region of the screen. You need to specify the screen region to be shared in this method.
  /// This method can be called before or after joining a channel, with the following differences:
  ///  If you call this method before joining a channel, then call joinChannel to join the channel and set publishScreenTrack or publishSecondaryScreenTrack to true, screen sharing will start.
  ///  If you call this method after joining a channel, then call updateChannelMediaOptions to update the channel media options and set publishScreenTrack or publishSecondaryScreenTrack to true, screen sharing will start. This method is only applicable to Windows.
  ///
  /// * [screenRect] Specifies the position of the screen to be shared relative to the virtual screen.
  /// * [regionRect] Specifies the position of the region to be shared relative to the entire screen. If not set, the entire screen is shared. See Rectangle. If the specified region exceeds the screen boundary, only the content within the screen is shared. If width or height is set to 0, the entire screen is shared.
  /// * [captureParams] Configuration parameters for screen sharing encoding. The default resolution is 1920 x 1080, i.e., 2,073,600 pixels. This pixel count is used for billing. See ScreenCaptureParameters.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> startScreenCaptureByScreenRect(
      {required Rectangle screenRect,
      required Rectangle regionRect,
      required ScreenCaptureParameters captureParams});

  /// Gets audio device information.
  ///
  /// After calling this method, you can check whether the audio device supports ultra-low latency recording and playback.
  ///  This method is applicable to Android only.
  ///  This method can be called before or after joining a channel.
  ///
  /// Returns
  /// A DeviceInfo object containing audio device information.
  ///  Non-null: The method call succeeds.
  ///  Null: The method call fails. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<DeviceInfo> getAudioDeviceInfo();

  /// Starts capturing the video stream of a specified window.
  ///
  /// Shares a window or a specific region of the window. You need to specify the window ID to be shared in this method.
  /// This method supports sharing Universal Windows Platform (UWP) application windows. Agora has tested mainstream UWP applications using the latest SDK, with the following results: OS Version Application Compatible Version Supported Windows 10 Chrome 76.0.3809.100 No Office Word 18.1903.1152.0 Yes Office Excel 18.1903.1152.0 No Office PPT 18.1903.1152.0 Yes WPS Word 11.1.0.9145 Yes WPS Excel 11.1.0.9145 Yes WPS PPT 11.1.0.9145 Yes Built-in Media Player All versions Yes Windows 8 Chrome All versions Yes Office Word All versions Yes Office Excel All versions Yes Office PPT All versions Yes WPS Word 11.1.0.9098 Yes WPS Excel 11.1.0.9098 Yes WPS PPT 11.1.0.9098 Yes Built-in Media Player All versions Yes Windows 7 Chrome 73.0.3683.103 No Office Word All versions Yes Office Excel All versions Yes Office PPT All versions Yes WPS Word 11.1.0.9098 No WPS Excel 11.1.0.9098 No WPS PPT 11.1.0.9098 Yes Built-in Media Player All versions No This method is only applicable to macOS and Windows.
  /// The SDK's window sharing feature depends on WGC (Windows Graphics Capture) or GDI (Graphics Device Interface). On systems earlier than Windows 10 2004, WGC cannot disable mouse capture. Therefore, when sharing windows on such systems, captureMouseCursor(false) may not work as expected. See ScreenCaptureParameters.
  ///
  /// * [windowId] Specifies the ID of the window to be shared.
  /// * [regionRect] (Optional) Specifies the position of the region to be shared relative to the entire screen. If not set, the entire screen is shared. See Rectangle. If the specified region exceeds the window boundary, only the content within the window is shared. If width or height is 0, the entire window is shared.
  /// * [captureParams] Configuration parameters for screen sharing. The default resolution is 1920 x 1080, i.e., 2,073,600 pixels. This pixel count is used for billing. See ScreenCaptureParameters.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> startScreenCaptureByWindowId(
      {required int windowId,
      required Rectangle regionRect,
      required ScreenCaptureParameters captureParams});

  /// Sets the content type for screen sharing.
  ///
  /// The SDK uses different algorithms to optimize the sharing effect based on the content type. If you do not call this method, the SDK defaults the screen sharing content type to contentHintNone, meaning no specific content type is set. This method can be called before or after starting screen sharing.
  ///
  /// * [contentHint] The content type of the screen sharing. See VideoContentHint.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setScreenCaptureContentHint(VideoContentHint contentHint);

  /// Updates the region for screen capture.
  ///
  /// Call this method after screen or window sharing is enabled.
  ///
  /// * [regionRect] The position of the region to be shared relative to the entire screen or window. If not specified, the entire screen or window is shared. See Rectangle. If the set region exceeds the screen or window boundary, only the content within the screen or window is shared; if width or height is set to 0, the entire screen or window is shared.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> updateScreenCaptureRegion(Rectangle regionRect);

  /// Updates the parameter configuration for screen capture.
  ///
  /// This method is applicable to Windows and macOS only.
  ///  Call this method after screen or window sharing is enabled.
  ///
  /// * [captureParams] Encoding parameter configuration for screen sharing. See ScreenCaptureParameters. The video properties of the screen sharing stream should be set only through this parameter and are not related to setVideoEncoderConfiguration.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> updateScreenCaptureParameters(
      ScreenCaptureParameters captureParams);

  /// Starts screen capture.
  ///
  /// This method is only applicable to Android and iOS platforms.
  ///  Screen sharing stream billing is based on the dimensions value in ScreenVideoParameters :
  ///  If not specified, billing is based on 1280 × 720.
  ///  If specified, billing is based on the provided value.
  ///  On iOS, screen sharing is only supported on iOS 12.0 and above.
  ///  On iOS, if you use external audio capture instead of SDK audio capture, to prevent screen sharing from stopping when the app goes to the background, it is recommended to implement keep-alive logic.
  ///  On iOS, this feature requires high device performance. It is recommended to use it on iPhone X or later.
  ///  On iOS, this method depends on the screen sharing dynamic library AgoraReplayKitExtension.xcframework. Removing this library will cause screen sharing to fail.
  ///  On Android, if the user does not grant screen capture permission to the app, the SDK reports the onPermissionError(2) callback.
  ///  On Android 9 and above, to prevent the app from being killed when it goes to the background, add the foreground service permission android.permission.FOREGROUND_SERVICE in /app/Manifests/AndroidManifest.xml.
  ///  Due to Android performance limitations, screen sharing is not supported on Android TV.
  ///  Due to Android system limitations, avoid changing the screen sharing stream's video encoding resolution during sharing on Huawei devices to prevent crashes.
  ///  Due to Android system limitations, some Xiaomi devices do not support capturing system audio during screen sharing.
  ///  To improve the success rate of capturing system audio during screen sharing, it is recommended to call setAudioScenario and set the audio scenario to audioScenarioGameStreaming before joining the channel.
  ///
  /// * [captureParams] Encoding parameter configuration for screen sharing. See ScreenCaptureParameters2.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> startScreenCapture(ScreenCaptureParameters2 captureParams);

  /// Updates the parameter configuration for screen capture.
  ///
  /// If system audio is not captured when screen sharing is enabled and you want to update the configuration and publish system audio, follow these steps:
  ///  Call this method and set captureAudio to true.
  ///  Call updateChannelMediaOptions and set publishScreenCaptureAudio to true to publish the screen capture audio.
  ///  This method is applicable to Android and iOS only.
  ///  On iOS, screen sharing is supported only on iOS 12.0 and later.
  ///
  /// * [captureParams] Encoding parameter configuration for screen sharing. See ScreenCaptureParameters2.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> updateScreenCapture(ScreenCaptureParameters2 captureParams);

  /// Queries the maximum frame rate supported by the device during screen sharing.
  ///
  /// Returns
  /// If the method call succeeds, returns the maximum frame rate supported by the device. See ScreenCaptureFramerateCapability.
  ///  <0: The method call fails. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<int> queryScreenCaptureCapability();

  /// Queries the focal length capabilities supported by the camera.
  ///
  /// To enable wide-angle or ultra-wide-angle camera modes, it is recommended to call this method first to check whether the device supports the corresponding focal length capabilities. Then, based on the result, call setCameraCapturerConfiguration to adjust the camera's focal length configuration to achieve the best capturing effect. This method is only applicable to Android and iOS.
  ///
  /// Returns
  /// Returns an array of FocalLengthInfo objects, which contain the camera's orientation and focal length type.
  Future<List<FocalLengthInfo>> queryCameraFocalLengthCapability();

  /// Sets an external MediaProjection to capture screen video stream.
  ///
  /// After this method is successfully called, the external MediaProjection you set will replace the one applied by the SDK to capture the screen video stream.
  /// When screen sharing is stopped or RtcEngine is destroyed, the SDK automatically releases the MediaProjection. This method is applicable to Android only.
  /// You must obtain MediaProjection permission before calling this method.
  ///
  /// * [mediaProjection] A [MediaProjection](https://developer.android.com/reference/android/media/projection/MediaProjection) object used to capture screen video stream.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setExternalMediaProjection(int mediaProjection);

  /// Sets the screen sharing scenario.
  ///
  /// When starting screen or window sharing, you can call this method to set the screen sharing scenario. The SDK adjusts the quality of the shared screen based on the scenario you set. Agora recommends calling this method before joining a channel.
  ///
  /// * [screenScenario] The screen sharing scenario. See ScreenScenarioType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setScreenCaptureScenario(ScreenScenarioType screenScenario);

  /// Stops screen capture.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> stopScreenCapture();

  /// Gets the call ID.
  ///
  /// Each time the client joins a channel, a corresponding callId is generated to identify the current call. You can call this method to get the callId parameter, and then pass it in when calling methods such as rate and complain.
  ///
  /// Returns
  /// Call ID.
  Future<String> getCallId();

  /// Rates a call.
  ///
  /// This method must be called after the user leaves the channel.
  ///
  /// * [callId] The call ID. You can obtain this parameter by calling getCallId.
  /// * [rating] The rating for the call, from 1 (lowest) to 5 (highest).
  /// * [description] A description of the call. The length must be less than 800 bytes.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> rate(
      {required String callId,
      required int rating,
      required String description});

  /// Report call quality issues.
  ///
  /// This method allows users to report call quality issues. It must be called after leaving the channel.
  ///
  /// * [callId] Call ID. You can obtain this parameter by calling getCallId.
  /// * [description] Description of the call. The length should be less than 800 bytes.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> complain({required String callId, required String description});

  /// Starts pushing streams without transcoding.
  ///
  /// Agora recommends using the more comprehensive server-side streaming feature. See [Implement Server-Side Streaming](https://doc.shengwang.cn/doc/media-push/restful/landing-page).
  /// You can call this method to push live audio and video streams to a specified CDN streaming URL. This method can only push to one URL at a time. To push to multiple URLs, you must call this method multiple times.
  /// After calling this method, the SDK triggers the onRtmpStreamingStateChanged callback locally to report the streaming status.
  ///  Call this method after joining a channel.
  ///  Only hosts in live streaming scenarios can call this method.
  ///  If the stream fails to start and you want to restart it, you must call stopRtmpStream before calling this method again. Otherwise, the SDK returns the same error code as the previous failure.
  ///
  /// * [url] The CDN streaming URL. The format must be RTMP or RTMPS. The character length must not exceed 1024 bytes. Special characters such as Chinese are not supported.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> startRtmpStreamWithoutTranscoding(String url);

  /// Starts pushing streams with transcoding settings.
  ///
  /// Agora recommends using the more comprehensive server-side streaming feature. See [Implement Server-Side Streaming](https://doc.shengwang.cn/doc/media-push/restful/landing-page).
  /// You can call this method to push live audio and video streams to a specified CDN streaming URL with transcoding settings. This method can only push to one URL at a time. To push to multiple URLs, you must call this method multiple times.
  /// Each stream push represents a streaming task. The default maximum number of concurrent tasks is 200, meaning you can run up to 200 streaming tasks simultaneously under one Agora project. For higher quotas, please [contact technical support](https://ticket.shengwang.cn/).
  /// After calling this method, the SDK triggers the onRtmpStreamingStateChanged callback locally to report the streaming status.
  ///  Call this method after joining a channel.
  ///  Only hosts in live streaming scenarios can call this method.
  ///  If the stream fails to start and you want to restart it, you must call stopRtmpStream before calling this method again. Otherwise, the SDK returns the same error code as the previous failure.
  ///
  /// * [url] The CDN streaming URL. The format must be RTMP or RTMPS. The character length must not exceed 1024 bytes. Special characters such as Chinese are not supported.
  /// * [transcoding] The transcoding settings for the CDN stream. See LiveTranscoding.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> startRtmpStreamWithTranscoding(
      {required String url, required LiveTranscoding transcoding});

  /// Updates the RTMP transcoding configuration.
  ///
  /// Agora recommends using the more comprehensive server-side streaming feature. See [Implement Server-Side RTMP Streaming](https://doc.shengwang.cn/doc/media-push/restful/landing-page).
  /// After enabling transcoding streaming, you can dynamically update the transcoding configuration based on your scenario needs. After the transcoding configuration is updated, the SDK triggers the onTranscodingUpdated callback.
  ///
  /// * [transcoding] The transcoding configuration for RTMP streaming. See LiveTranscoding.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> updateRtmpTranscoding(LiveTranscoding transcoding);

  /// Starts local video mixing.
  ///
  /// After calling this method, you can merge multiple video streams locally into one stream. For example: merge video streams from camera capture, screen sharing, media player, remote video, video files, images, etc., into one stream, and then publish the mixed video stream to the channel.
  ///  Local video mixing consumes high CPU resources. Agora recommends enabling this feature on high-performance devices.
  ///  If you need to mix locally captured video streams, the SDK supports the following combinations:
  ///  On Windows, up to 4 camera video streams + 4 screen sharing streams can be mixed.
  ///  On macOS, up to 4 camera video streams + 1 screen sharing stream can be mixed.
  ///  On Android and iOS, up to 2 camera video streams (requires dual camera support or external camera support) + 1 screen sharing stream can be mixed.
  ///  When configuring mixing, ensure that the layer index of the camera video stream capturing the portrait is higher than that of the screen sharing stream, otherwise the portrait will be covered and not appear in the final mixed video stream.
  ///
  /// * [config] The configuration for local video mixing. See LocalTranscoderConfiguration.
  ///  The maximum resolution for each video stream involved in local mixing is 4096 × 2160. Exceeding this limit will cause mixing to fail.
  ///  The maximum resolution of the mixed video stream is 4096 × 2160.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> startLocalVideoTranscoder(LocalTranscoderConfiguration config);

  /// Updates local video mixing configuration.
  ///
  /// After calling startLocalVideoTranscoder, call this method if you want to update the local video mixing configuration. If you want to update the type of local video source used in mixing, such as adding a second camera or screen capture video, call this method after startCameraCapture or startScreenCaptureBySourceType.
  ///
  /// * [config] The configuration for local video mixing. See LocalTranscoderConfiguration.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> updateLocalTranscoderConfiguration(
      LocalTranscoderConfiguration config);

  /// Stops the CDN stream.
  ///
  /// Agora recommends using the more comprehensive server-side streaming feature. See [Implement Server-Side Streaming](https://doc.shengwang.cn/doc/media-push/restful/landing-page).
  /// You can call this method to stop live streaming to a specified CDN streaming URL. This method can only stop one stream at a time. To stop multiple streams, you must call this method multiple times.
  /// After calling this method, the SDK triggers the onRtmpStreamingStateChanged callback locally to report the streaming status.
  ///
  /// * [url] The CDN streaming URL. The format must be RTMP or RTMPS. The character length must not exceed 1024 bytes. Special characters such as Chinese are not supported.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> stopRtmpStream(String url);

  /// Stops local video mixing.
  ///
  /// After calling startLocalVideoTranscoder, call this method if you want to stop local video mixing.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> stopLocalVideoTranscoder();

  /// Starts local audio mixing.
  ///
  /// This method supports merging multiple local audio streams into a single audio stream. For example: merge audio from the local microphone, media player, sound card, remote audio streams, etc., into one stream and publish it to the channel.
  ///  If you want to mix local captured audio, you can set publishMixedAudioTrack in ChannelMediaOptions to true to publish the mixed audio stream to the channel.
  ///  If you want to mix remote audio streams, make sure the remote audio streams are published in the channel and subscribed. To ensure audio quality, it is recommended that no more than 10 audio streams participate in local mixing.
  ///
  /// * [config] Configuration for local audio mixing. See LocalAudioMixerConfiguration.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> startLocalAudioMixer(LocalAudioMixerConfiguration config);

  /// Updates the configuration of local audio mixing.
  ///
  /// After calling startLocalAudioMixer, if you want to update the configuration of local audio mixing, call this method. To ensure audio quality, it is recommended that no more than 10 audio streams participate in local mixing.
  ///
  /// * [config] Configuration for local audio mixing. See LocalAudioMixerConfiguration.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> updateLocalAudioMixerConfiguration(
      LocalAudioMixerConfiguration config);

  /// Stops local audio mixing.
  ///
  /// After calling startLocalAudioMixer, if you want to stop local audio mixing, call this method.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> stopLocalAudioMixer();

  /// Starts video capture using the camera.
  ///
  /// Call this method to start multiple camera captures simultaneously by specifying sourceType. On iOS, to enable multiple camera captures, you must call enableMultiCamera and set enabled to true before calling this method.
  ///
  /// * [sourceType] Type of video source. See VideoSourceType.
  ///  iOS devices support up to 2 video streams from camera capture (requires multi-camera or external camera support).
  ///  Android devices support up to 4 video streams from camera capture (requires multi-camera or external camera support).
  ///  Desktop supports up to 4 video streams from camera capture.
  /// * [config] Video capture configuration. See CameraCapturerConfiguration. On iOS, this parameter has no effect. Use the config parameter in enableMultiCamera to configure video capture settings.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> startCameraCapture(
      {required VideoSourceType sourceType,
      required CameraCapturerConfiguration config});

  /// Stops video capture using the camera.
  ///
  /// After calling startCameraCapture to start one or more camera capture streams, you can call this method with sourceType to stop one or more camera video captures. On iOS, to disable multiple camera captures, you must call enableMultiCamera and set enabled to false after calling this method.
  /// If you are using local video mixing, stopping video capture from the first camera using this method will interrupt the local video mixing.
  ///
  /// * [sourceType] Type of video source. See VideoSourceType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> stopCameraCapture(VideoSourceType sourceType);

  /// Sets the rotation angle of the captured video.
  ///
  /// This method is applicable to Windows only.
  ///  You must call this method after enableVideo. The setting takes effect after the camera is successfully turned on, i.e., after the SDK triggers the onLocalVideoStateChanged callback and the local video state is localVideoStreamStateCapturing (1).
  ///  When the video capture device does not have a gravity sensor, you can call this method to manually adjust the rotation angle of the captured video frame.
  ///
  /// * [type] Video source type. See VideoSourceType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setCameraDeviceOrientation(
      {required VideoSourceType type, required VideoOrientation orientation});

  /// @nodoc
  Future<void> setScreenCaptureOrientation(
      {required VideoSourceType type, required VideoOrientation orientation});

  /// Gets the current network connection state.
  ///
  /// Returns
  /// Current network connection state. See ConnectionStateType.
  Future<ConnectionStateType> getConnectionState();

  /// Adds the main callback event.
  ///
  /// The interface class RtcEngineEventHandler is used by the SDK to send callback event notifications to the App. The App receives SDK event notifications by inheriting methods from this interface class.
  /// All methods in the interface class have default (empty) implementations. The App can choose to inherit only the events it cares about.
  /// In callback methods, the App should not perform time-consuming tasks or call APIs that may block (e.g., sendStreamMessage), otherwise it may affect the operation of the SDK.
  ///
  /// * [eventHandler] The callback event to be added. See RtcEngineEventHandler.
  ///
  /// Returns
  /// No return value if the method call succeeds; if the method call fails, an AgoraRtcException is thrown, which you need to catch and handle. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and troubleshooting suggestions.
  void registerEventHandler(RtcEngineEventHandler eventHandler);

  /// Removes the specified callback event.
  ///
  /// This method removes all previously added callback events.
  ///
  /// * [eventHandler] The callback event to be removed. See RtcEngineEventHandler.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when it fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  void unregisterEventHandler(RtcEngineEventHandler eventHandler);

  /// @nodoc
  Future<void> setRemoteUserPriority(
      {required int uid, required PriorityType userPriority});

  /// Enable or disable built-in encryption.
  ///
  /// After the user leaves the channel, the SDK automatically disables encryption. To enable encryption again, you need to call this method before the user rejoins the channel.
  ///  All users in the same channel must set the same encryption mode and key when calling this method.
  ///  If built-in encryption is enabled, the CDN live streaming feature cannot be used.
  ///
  /// * [enabled] Whether to enable built-in encryption: true : Enable built-in encryption. false : (default) Disable built-in encryption.
  /// * [config] Configure the built-in encryption mode and key. See EncryptionConfig.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> enableEncryption(
      {required bool enabled, required EncryptionConfig config});

  /// Creates a data stream.
  ///
  /// If you need a more comprehensive, low-latency, high-concurrency, and scalable real-time messaging and state synchronization solution, we recommend using [Real-time Messaging](https://doc.shengwang.cn/doc/rtm2/flutter/landing-page).
  /// During the lifecycle of RtcEngine, each user can create up to 5 data streams. The data streams are destroyed when leaving the channel. If needed again, you must recreate them.
  ///
  /// * [config] Data stream configuration. See DataStreamConfig.
  ///
  /// Returns
  /// ID of the created data stream: method call succeeded.
  ///  < 0: method call failed. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<int> createDataStream(DataStreamConfig config);

  /// Sends a data stream.
  ///
  /// After calling createDataStream, you can call this method to send data stream messages to all users in the channel.
  /// The SDK imposes the following restrictions on this method:
  ///  Each client in the channel can have up to 5 data channels simultaneously, with a total sending bitrate limit of 30 KB/s shared among all channels.
  ///  Each data channel can send up to 60 packets per second, with each packet limited to 1 KB. After this method is successfully called, the remote side triggers the onStreamMessage callback, through which remote users can receive the stream message. If the call fails, the remote side triggers the onStreamMessageError callback. If you need a more comprehensive solution for low-latency, high-concurrency, and scalable real-time messaging and state synchronization, we recommend using [Real-time Messaging](https://doc.shengwang.cn/doc/rtm2/flutter/landing-page).
  ///  This method must be called after joining the channel and after calling createDataStream to create the data channel.
  ///  This method is only applicable to broadcaster users.
  ///
  /// * [streamId] The data stream ID. You can get it through createDataStream.
  /// * [data] The data to be sent.
  /// * [length] The length of the data.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> sendStreamMessage(
      {required int streamId, required Uint8List data, required int length});

  /// Adds a local video watermark.
  ///
  /// Deprecated Deprecated: This method is deprecated. Use addVideoWatermarkWithConfig instead. This method adds a PNG image as a watermark to the local published live video stream. Users in the same live channel, audience of the CDN live stream, and capture devices can all see or capture the watermark image. Currently, only one watermark can be added to the live video stream. Adding a new watermark replaces the previous one.
  /// The watermark coordinates depend on the settings in the setVideoEncoderConfiguration method:
  ///  If the video orientation (OrientationMode) is fixed to landscape or adaptive landscape mode, landscape coordinates are used.
  ///  If the video orientation (OrientationMode) is fixed to portrait or adaptive portrait mode, portrait coordinates are used.
  ///  When setting the watermark coordinates, the image area of the watermark must not exceed the video dimensions set in the setVideoEncoderConfiguration method. Otherwise, the exceeding part will be cropped.
  ///  You must call this method after calling enableVideo.
  ///  If you only want to add a watermark during CDN streaming, you can use this method or startRtmpStreamWithTranscoding to set the watermark.
  ///  The watermark image must be in PNG format. This method supports all pixel formats of PNG images: RGBA, RGB, Palette, Gray, and Alpha_gray.
  ///  If the size of the PNG image to be added does not match the size set in this method, the SDK scales or crops the PNG image to match the settings.
  ///  If you have set the local video to mirror mode, the local watermark will also be mirrored. To avoid mirrored watermark when local users view their own video, it is recommended not to use both mirror and watermark features on local video. Implement the local watermark feature at the application layer.
  ///
  /// * [watermarkUrl] The local path of the watermark image to be added. This method supports adding watermark images from local absolute/relative paths.
  /// * [options] Settings for the watermark image to be added. See WatermarkOptions.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> addVideoWatermark(
      {required String watermarkUrl, required WatermarkOptions options});

  /// Removes added video watermarks.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> clearVideoWatermarks();

  /// @nodoc
  Future<void> pauseAudio();

  /// @nodoc
  Future<void> resumeAudio();

  /// Enable interoperability with Web SDK (applicable only in live broadcast scenarios).
  ///
  /// Deprecated Deprecated: This method is deprecated. The SDK automatically enables interoperability with the Web SDK, so you do not need to call this method. This method enables or disables interoperability with the Web SDK. If users join the channel via Web SDK, make sure to call this method; otherwise, Web users may see a black screen when viewing the Native side.
  /// This method is only applicable in live broadcast scenarios. In communication scenarios, interoperability is enabled by default.
  ///
  /// * [enabled] Whether to enable interoperability with the Web SDK: true : Enable interoperability. false : (default) Disable interoperability.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> enableWebSdkInteroperability(bool enabled);

  /// Sends a custom report message.
  ///
  /// Agora provides a custom data reporting and analytics service. This service is currently in a free beta period. During the beta, you can report up to 10 data entries within 6 seconds. Each custom data entry must not exceed 256 bytes, and each string must not exceed 100 bytes. To try this service, please [contact sales](https://www.shengwang.cn/contact-sales/) to enable it and agree on the custom data format.
  Future<void> sendCustomReportMessage(
      {required String id,
      required String category,
      required String event,
      required String label,
      required int value});

  /// Registers a media metadata observer to receive or send metadata.
  ///
  /// You need to implement the MetadataObserver class yourself and specify the metadata type in this method. This method allows you to add synchronized metadata to the video stream for interactive live streaming scenarios such as sending shopping links, e-coupons, and online quizzes. Call this method before joinChannel.
  ///
  /// * [observer] The metadata observer. See MetadataObserver.
  /// * [type] The metadata type. Currently only videoMetadata is supported.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: The method call fails. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  void registerMediaMetadataObserver(
      {required MetadataObserver observer, required MetadataType type});

  /// Unregisters the media metadata observer.
  ///
  /// * [observer] The metadata observer. See MetadataObserver.
  /// * [type] The metadata type. Currently, only videoMetadata is supported.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Failure. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  void unregisterMediaMetadataObserver(
      {required MetadataObserver observer, required MetadataType type});

  /// @nodoc
  Future<void> startAudioFrameDump(
      {required String channelId,
      required int uid,
      required String location,
      required String uuid,
      required String passwd,
      required int durationMs,
      required bool autoUpload});

  /// @nodoc
  Future<void> stopAudioFrameDump(
      {required String channelId, required int uid, required String location});

  /// Enables or disables AI noise reduction and sets the noise reduction mode.
  ///
  /// You can call this method to enable the AI noise reduction feature. This feature intelligently detects and reduces various stationary and non-stationary background noises while maintaining voice quality, making human voices clearer.
  /// Stationary noise refers to noise with consistent frequency over time, such as:
  ///  TV noise
  ///  Air conditioner noise
  ///  Factory machine noise Non-stationary noise refers to noise that changes rapidly over time, such as:
  ///  Thunder
  ///  Explosions
  ///  Cracking sounds
  ///  This method depends on the AI noise reduction dynamic library. Deleting this library will prevent the feature from working properly. For the name of the AI noise reduction library, see [Plugin List](https://doc.shengwang.cn/doc/rtc/flutter/best-practice/reduce-app-size#%E6%8F%92%E4%BB%B6%E5%88%97%E8%A1%A8).
  ///  Currently, it is not recommended to enable this feature on devices running Android 6.0 or lower.
  ///
  /// * [enabled] Whether to enable AI noise reduction: true : Enable AI noise reduction. false : (default) Disable AI noise reduction.
  /// * [mode] Noise reduction mode. See AudioAinsMode.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setAINSMode(
      {required bool enabled, required AudioAinsMode mode});

  /// Registers the local user account.
  ///
  /// This method registers a user account for the local user. After successful registration, the user account can be used to identify the local user, who can then join a channel using it.
  /// This method is optional. If you want users to join a channel using a user account, you can implement it in either of the following ways:
  ///  Call registerLocalUserAccount to register the account first, then call joinChannelWithUserAccount to join the channel. This can reduce the time to join the channel.
  ///  Directly call joinChannelWithUserAccount to join the channel.
  ///  Ensure the userAccount set in this method is unique within the channel.
  ///  To ensure communication quality, make sure to use the same type of user identifier within a channel. That is, use either UID or user account consistently within the same channel. If users join the channel via Web SDK, ensure they use the same identifier type.
  ///
  /// * [appId] The App ID of your project registered in the console.
  /// * [userAccount] User account. This parameter identifies the user in the real-time audio and video channel. You need to set and manage the user account yourself and ensure it is unique within the same channel. This parameter is required, must not exceed 255 bytes, and cannot be null. Supported character set (89 characters total):
  ///  26 lowercase letters a-z
  ///  26 uppercase letters A-Z
  ///  10 digits 0-9
  ///  Space
  ///  "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> registerLocalUserAccount(
      {required String appId, required String userAccount});

  /// Joins a channel using a User Account and token, and sets channel media options.
  ///
  /// Before calling this method, if you have not registered a User Account using registerLocalUserAccount, the SDK automatically creates one for you when you join a channel using this method. To reduce the time it takes to join a channel, register the account first using registerLocalUserAccount, then call this method.
  ///
  /// After a user successfully joins a channel, they automatically subscribe to all audio and video streams from other users in the channel, which incurs usage and affects billing. To unsubscribe, call the corresponding mute methods. To ensure communication quality, make sure that all users in the channel use the same type of identifier, either UID or User Account. If users join the channel via the Web SDK, ensure they use the same identifier type.
  ///  This method only supports joining one channel at a time.
  ///  Apps with different App IDs cannot communicate with each other.
  ///  Before joining a channel, make sure the App ID used to generate the token is the same as the one used in the initialize method. Otherwise, joining the channel with the token will fail.
  ///
  /// * [token] The dynamic key generated on your server for authentication. See [Use Token Authentication](https://doc.shengwang.cn/doc/rtc/flutter/basic-features/token-authentication).
  ///  (Recommended) If your project has enabled secure mode (using APP ID + Token for authentication), this parameter is required.
  ///  If your project is in debug mode only (using APP ID for authentication), you can join the channel without a token. The user will automatically leave the channel after 24 hours.
  ///  If you need to join multiple channels or frequently switch between channels, Agora recommends using a wildcard token to avoid requesting a new token from your server every time. See [Use Wildcard Token](https://doc.shengwang.cn/doc/rtc/flutter/best-practice/wildcard-token).
  /// * [userAccount] The User Account of the user. This parameter identifies the user in the real-time audio/video interaction channel. You must manage and ensure the uniqueness of each User Account within the same channel. This parameter is required, must not exceed 255 bytes, and cannot be null. Supported character set (89 characters total):
  ///  26 lowercase letters a–z
  ///  26 uppercase letters A–Z
  ///  10 digits 0–9
  ///  Space
  ///  "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","
  /// * [options] Channel media configuration options. See ChannelMediaOptions.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when it fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: The method call fails. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  -2: Invalid parameter. For example, an illegal token is used, the uid parameter is not an integer, or a member value of ChannelMediaOptions is invalid. Provide valid parameters and rejoin the channel.
  ///  -3: RtcEngine initialization failed. Reinitialize the RtcEngine object.
  ///  -7: RtcEngine not initialized. Initialize RtcEngine before calling this method.
  ///  -8: Internal state error of RtcEngine. This may occur if you call this method after starting an echo test with startEchoTest but before stopping it with stopEchoTest. Call stopEchoTest before this method.
  ///  -17: Join channel rejected. Possibly because the user is already in the channel. Use the onConnectionStateChanged callback to check if the user is in the channel. Do not call this method again unless the state is connectionStateDisconnected (1).
  ///  -102: Invalid channel name. Provide a valid channelId and rejoin the channel.
  ///  -121: Invalid user ID. Provide a valid uid and rejoin the channel.
  Future<void> joinChannelWithUserAccount(
      {required String token,
      required String channelId,
      required String userAccount,
      ChannelMediaOptions? options});

  /// Joins a channel using a User Account and token, and sets channel media options.
  ///
  /// Before calling this method, if you have not registered a User Account using registerLocalUserAccount, the SDK automatically creates one for you when you join a channel using this method. To reduce the time it takes to join a channel, register the account first using registerLocalUserAccount, then call this method.
  ///
  /// After a user successfully joins a channel, they automatically subscribe to all audio and video streams from other users in the channel, which incurs usage and affects billing. To unsubscribe, set the options parameter or call the corresponding mute methods. To ensure communication quality, make sure that all users in the channel use the same type of identifier, either UID or User Account. If users join the channel via the Web SDK, ensure they use the same identifier type.
  ///  This method only supports joining one channel at a time.
  ///  Apps with different App IDs cannot communicate with each other.
  ///  Before joining a channel, make sure the App ID used to generate the token is the same as the one used in the initialize method. Otherwise, joining the channel with the token will fail.
  ///
  /// * [token] The dynamic key generated on your server for authentication. See [Use Token Authentication](https://doc.shengwang.cn/doc/rtc/flutter/basic-features/token-authentication).
  ///  (Recommended) If your project has enabled secure mode (using APP ID + Token for authentication), this parameter is required.
  ///  If your project is in debug mode only (using APP ID for authentication), you can join the channel without a token. The user will automatically leave the channel after 24 hours.
  ///  If you need to join multiple channels or frequently switch between channels, Agora recommends using a wildcard token to avoid requesting a new token from your server every time. See [Use Wildcard Token](https://doc.shengwang.cn/doc/rtc/flutter/best-practice/wildcard-token).
  /// * [userAccount] The User Account of the user. This parameter identifies the user in the real-time audio/video interaction channel. You must manage and ensure the uniqueness of each User Account within the same channel. This parameter is required, must not exceed 255 bytes, and cannot be null. Supported character set (89 characters total):
  ///  26 lowercase letters a–z
  ///  26 uppercase letters A–Z
  ///  10 digits 0–9
  ///  Space
  ///  "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","
  /// * [options] Channel media configuration options. See ChannelMediaOptions.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when it fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: The method call fails. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  -2: Invalid parameter. For example, an illegal token is used, the uid parameter is not an integer, or a member value of ChannelMediaOptions is invalid. Provide valid parameters and rejoin the channel.
  ///  -3: RtcEngine initialization failed. Reinitialize the RtcEngine object.
  ///  -7: RtcEngine not initialized. Initialize RtcEngine before calling this method.
  ///  -8: Internal state error of RtcEngine. This may occur if you call this method after starting an echo test with startEchoTest but before stopping it with stopEchoTest. Call stopEchoTest before this method.
  ///  -17: Join channel rejected. Possibly because the user is already in the channel. Use the onConnectionStateChanged callback to check if the user is in the channel. Do not call this method again unless the state is connectionStateDisconnected (1).
  ///  -102: Invalid channel name. Provide a valid channelId and rejoin the channel.
  ///  -121: Invalid user ID. Provide a valid uid and rejoin the channel.
  Future<void> joinChannelWithUserAccountEx(
      {required String token,
      required String channelId,
      required String userAccount,
      required ChannelMediaOptions options});

  /// Gets user information by User Account.
  ///
  /// After a remote user joins a channel, the SDK retrieves the UID and User Account of the remote user and caches a mapping table of UID and User Account. It then triggers the onUserInfoUpdated callback locally. After receiving this callback, call this method with the User Account to get the UserInfo object that contains the specified user's UID.
  ///
  /// * [userAccount] User Account of the user.
  ///
  /// Returns
  /// The UserInfo object, if the method call succeeds. null, if the method call fails.
  Future<UserInfo> getUserInfoByUserAccount(String userAccount);

  /// Gets user information by UID.
  ///
  /// After a remote user joins a channel, the SDK retrieves the UID and User Account of the remote user and caches a mapping table of UID and User Account. It then triggers the onUserInfoUpdated callback locally. After receiving this callback, call this method with the UID to get the UserInfo object that contains the specified user's User Account.
  ///
  /// * [uid] User ID.
  ///
  /// Returns
  /// The UserInfo object, if the method call succeeds. null, if the method call fails.
  Future<UserInfo> getUserInfoByUid(int uid);

  /// Starts or updates cross-channel media stream relay.
  ///
  /// The first successful call to this method starts the cross-channel media stream relay. To relay the stream to multiple destination channels or exit the current relay channels, you can call this method again to add or remove destination channels. This feature supports relaying media streams to up to 6 destination channels.
  /// After the method is successfully called, the SDK triggers the onChannelMediaRelayStateChanged callback to report the current state of the cross-channel media stream relay. Common states include:
  ///  If the onChannelMediaRelayStateChanged callback reports relayStateRunning (2) and relayOk (0), it indicates that the SDK has started relaying media streams between the source and destination channels.
  ///  If the onChannelMediaRelayStateChanged callback reports relayStateFailure (3), it indicates an exception occurred in the cross-channel media stream relay.
  ///  Call this method after successfully joining a channel.
  ///  In a live broadcast scenario, only users with the broadcaster role can call this method.
  ///  The cross-channel media stream relay feature requires [contacting technical support](https://ticket.shengwang.cn/) to enable.
  ///  This feature does not support String-type UIDs.
  ///
  /// * [configuration] Configuration for cross-channel media stream relay. See ChannelMediaRelayConfiguration.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Method call failed. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  -1: General error (not specifically classified).
  ///  -2: Invalid parameter.
  ///  -8: Internal state error. Possibly because the user role is not broadcaster.
  Future<void> startOrUpdateChannelMediaRelay(
      ChannelMediaRelayConfiguration configuration);

  /// Stops cross-channel media stream relay. Once stopped, the broadcaster leaves all destination channels.
  ///
  /// After the method is successfully called, the SDK triggers the onChannelMediaRelayStateChanged callback. If it reports relayStateIdle (0) and relayOk (0), it indicates that media stream relay has been stopped. If the method call fails, the SDK triggers the onChannelMediaRelayStateChanged callback and reports the status code relayErrorServerNoResponse (2) or relayErrorServerConnectionLost (8). You can call the leaveChannel method to leave the channel, and the cross-channel media stream relay will stop automatically.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Method call failed. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  -5: This method call was rejected. There is no ongoing cross-channel media stream relay.
  Future<void> stopChannelMediaRelay();

  /// Pauses media stream relay to all destination channels.
  ///
  /// After starting media stream relay across channels, if you want to pause relaying to all destination channels, you can call this method. To resume relaying, call resumeAllChannelMediaRelay. You must call this method after calling startOrUpdateChannelMediaRelay to start media stream relay across channels.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when it fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> pauseAllChannelMediaRelay();

  /// Resumes media stream relay to all destination channels.
  ///
  /// After calling the pauseAllChannelMediaRelay method, if you need to resume media stream relay to all destination channels, you can call this method. This method must be called after pauseAllChannelMediaRelay.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Method call failed. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  -5: This method call was rejected. There is no paused cross-channel media stream relay.
  Future<void> resumeAllChannelMediaRelay();

  /// Sets the audio encoding configuration when the host pushes the stream directly to the CDN.
  ///
  /// Deprecated Deprecated since v4.6.2. This method only takes effect for audio captured by the microphone or custom audio sources, that is, when publishMicrophoneTrack or publishCustomAudioTrack is set to true in DirectCdnStreamingMediaOptions.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setDirectCdnStreamingAudioConfiguration(
      AudioProfileType profile);

  /// Sets the video encoding properties when the host pushes streams directly to the CDN.
  ///
  /// Deprecated Deprecated since v4.6.2. This method only applies to video captured by the camera, screen sharing, or custom video sources. That is, it applies to video captured when publishCameraTrack or publishCustomVideoTrack is set to true in DirectCdnStreamingMediaOptions.
  /// If the video resolution you set exceeds the range supported by your camera device, the SDK adapts based on your settings and captures, encodes, and streams using the closest resolution with the same aspect ratio as your setting. You can get the actual resolution of the pushed video stream through the onDirectCdnStreamingStats callback.
  ///
  /// * [config] Video encoding configuration. See VideoEncoderConfiguration. When pushing streams directly to the CDN, the SDK currently only supports setting OrientationMode to landscape mode (orientationModeFixedLandscape) or portrait mode (orientationModeFixedPortrait).
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setDirectCdnStreamingVideoConfiguration(
      VideoEncoderConfiguration config);

  /// Starts pushing streams directly from the host to the CDN.
  ///
  /// Deprecated Deprecated since v4.6.2. The SDK does not support pushing to the same URL multiple times simultaneously.
  /// Media options:
  /// The SDK does not support publishCameraTrack and publishCustomVideoTrack being true at the same time, nor does it support publishMicrophoneTrack and publishCustomAudioTrack being true at the same time. You can set the media options (DirectCdnStreamingMediaOptions) based on your scenario. For example:
  /// If you want to push custom audio and video streams from the host:
  ///  Set publishCustomAudioTrack to true and call pushAudioFrame
  ///  Set publishCustomVideoTrack to true and call pushVideoFrame
  ///  Ensure publishCameraTrack is false (default)
  ///  Ensure publishMicrophoneTrack is false (default) Since v4.2.0, the SDK supports pushing audio-only streams. You can set publishCustomAudioTrack or publishMicrophoneTrack to true in DirectCdnStreamingMediaOptions, and call pushAudioFrame to push audio-only streams.
  ///
  /// * [eventHandler] See onDirectCdnStreamingStateChanged and onDirectCdnStreamingStats.
  /// * [publishUrl] CDN streaming URL.
  /// * [options] Media options for the host. See DirectCdnStreamingMediaOptions.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> startDirectCdnStreaming(
      {required DirectCdnStreamingEventHandler eventHandler,
      required String publishUrl,
      required DirectCdnStreamingMediaOptions options});

  /// Stops pushing streams directly from the host to the CDN.
  ///
  /// Deprecated Deprecated since v4.6.2.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> stopDirectCdnStreaming();

  /// @nodoc
  Future<void> updateDirectCdnStreamingMediaOptions(
      DirectCdnStreamingMediaOptions options);

  /// Starts the virtual metronome.
  ///
  /// Deprecated Deprecated since v4.6.2.
  ///  After enabling the virtual metronome, the SDK starts playing the specified audio files from the beginning and controls the duration of each file based on the beatsPerMinute you set in AgoraRhythmPlayerConfig. For example, if beatsPerMinute is set to 60, the SDK plays 1 beat per second. If the file duration exceeds the beat duration, the SDK only plays the portion that fits the beat duration.
  ///  By default, the sound of the virtual metronome is not published to remote users. If you want remote users to hear it, set publishRhythmPlayerTrack in ChannelMediaOptions to true after calling this method.
  ///
  /// * [sound1] The absolute path or URL of the strong beat file, including the file name and extension. For example, C:\music\audio.mp4. Supported audio formats: see [Supported audio formats for RTC SDK](https://doc.shengwang.cn/faq/general-product-inquiry/audio-format).
  /// * [sound2] The absolute path or URL of the weak beat file, including the file name and extension. For example, C:\music\audio.mp4. Supported audio formats: see [Supported audio formats for RTC SDK](https://doc.shengwang.cn/faq/general-product-inquiry/audio-format).
  /// * [config] Metronome configuration. See AgoraRhythmPlayerConfig.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> startRhythmPlayer(
      {required String sound1,
      required String sound2,
      required AgoraRhythmPlayerConfig config});

  /// Stops the virtual metronome.
  ///
  /// After calling startRhythmPlayer, you can call this method to stop the virtual metronome. This method applies to Android and iOS only.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> stopRhythmPlayer();

  /// Configures the virtual metronome.
  ///
  /// Deprecated Deprecated since v4.6.2.
  ///  After calling startRhythmPlayer, you can call this method to reconfigure the virtual metronome.
  ///  After enabling the virtual metronome, the SDK starts playing the specified audio files from the beginning and controls the duration of each file based on the beatsPerMinute you set in AgoraRhythmPlayerConfig. For example, if beatsPerMinute is set to 60, the SDK plays 1 beat per second. If the file duration exceeds the beat duration, the SDK only plays the portion that fits the beat duration.
  ///  By default, the sound of the virtual metronome is not published to remote users. If you want remote users to hear it, set publishRhythmPlayerTrack in ChannelMediaOptions to true after calling this method.
  ///
  /// * [config] Metronome configuration. See AgoraRhythmPlayerConfig.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> configRhythmPlayer(AgoraRhythmPlayerConfig config);

  /// Takes a snapshot of the video.
  ///
  /// This method takes a snapshot of the specified user's video stream, generates a JPG image, and saves it to the specified path.
  ///  This method is asynchronous. When the call returns, the SDK has not actually captured the snapshot.
  ///  When used for local video snapshot, it captures the video stream specified in ChannelMediaOptions.
  ///  If the user's video has undergone preprocessing, such as watermarking or beautification, the snapshot will include these effects.
  ///
  /// * [uid] User ID. Set to 0 to capture the local user's video.
  /// * [filePath] Make sure the directory exists and is writable. The local path to save the snapshot. The path must include the file name and format, for example:
  ///  Windows: C:\Users\<user_name>\AppData\Local\Agora\<process_name>\example.jpg
  ///  iOS: /App Sandbox/Library/Caches/example.jpg
  ///  macOS: ～/Library/Logs/example.jpg
  ///  Android: /storage/emulated/0/Android/data/<package name>/files/example.jpg
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> takeSnapshot({required int uid, required String filePath});

  /// Enables/disables local snapshot upload.
  ///
  /// After enabling local snapshot upload, the SDK takes and uploads snapshots of the video sent by the local user based on the module type and frequency set in ContentInspectConfig. After the snapshot is completed, the Agora server sends a callback notification to your server via HTTPS request and uploads all snapshots to your specified third-party cloud storage.
  ///  Before calling this method, ensure that the local snapshot upload service has been enabled in the Agora Console.
  ///  When using the Agora-developed plugin for snapshot upload (contentInspectSupervision) in the video moderation module, you must integrate the local snapshot upload dynamic library libagora_content_inspect_extension.dll. Deleting this library will prevent the local snapshot upload feature from working properly.
  ///
  /// * [enabled] Sets whether to enable local snapshot upload: true : Enable local snapshot upload. false : Disable local snapshot upload.
  /// * [config] Local snapshot upload configuration. See ContentInspectConfig.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> enableContentInspect(
      {required bool enabled, required ContentInspectConfig config});

  /// Adjusts the remote playback volume of a custom audio track.
  ///
  /// After calling this method to set the remote playback volume of the audio, if you want to adjust the volume again, you can call this method again. Before calling this method, make sure you have already called createCustomAudioTrack to create a custom audio track.
  ///
  /// * [trackId] Audio track ID. Set this parameter to the custom audio track ID returned by the createCustomAudioTrack method.
  /// * [volume] Playback volume of the custom audio capture. Range: [0,100]. 0 means mute, 100 means original volume.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Method call failed. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> adjustCustomAudioPublishVolume(
      {required int trackId, required int volume});

  /// Adjusts the local playback volume of a custom audio track.
  ///
  /// After calling this method to set the local playback volume of the audio, if you want to adjust the volume again, you can call this method again. Before calling this method, make sure you have already called createCustomAudioTrack to create a custom audio track.
  ///
  /// * [trackId] Audio track ID. Set this parameter to the custom audio track ID returned by the createCustomAudioTrack method.
  /// * [volume] Playback volume of the custom audio capture. Range: [0,100]. 0 means mute, 100 means original volume.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Method call failed. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> adjustCustomAudioPlayoutVolume(
      {required int trackId, required int volume});

  /// Sets the cloud proxy service.
  ///
  /// When the user's network is restricted by a firewall, you need to add the IP and port provided by Agora to the firewall whitelist, then call this method to enable the cloud proxy and set the proxy type via the proxyType parameter.
  /// After successfully connecting to the cloud proxy, the SDK triggers the onConnectionStateChanged (connectionStateConnecting, connectionChangedSettingProxyServer) callback.
  /// To disable an already set Force UDP or Force TCP cloud proxy, call setCloudProxy(noneProxy).
  /// To change the cloud proxy type, first call setCloudProxy(noneProxy), then call setCloudProxy with the desired proxyType value.
  ///  It is recommended to call this method outside the channel.
  ///  If the user is in an intranet firewall environment, the features of CDN streaming and cross-channel media relay are not available when using Force UDP cloud proxy.
  ///  When using Force UDP cloud proxy, the startAudioMixing method cannot play online audio files via HTTP. CDN streaming and cross-channel media relay use cloud proxy over TCP.
  ///
  /// * [proxyType] The cloud proxy type. See CloudProxyType.
  /// This parameter is required. If you do not assign a value, the SDK will report an error.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setCloudProxy(CloudProxyType proxyType);

  /// @nodoc
  Future<void> setLocalAccessPoint(LocalAccessPointConfiguration config);

  /// Sets advanced audio options.
  ///
  /// If you have advanced audio processing needs, such as collecting and sending stereo audio, you can call this method to set advanced audio options. You need to call this method before joinChannel, enableAudio, and enableLocalAudio.
  ///
  /// * [options] Advanced audio options. See AdvancedAudioOptions.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setAdvancedAudioOptions(
      {required AdvancedAudioOptions options, int sourceType = 0});

  /// @nodoc
  Future<void> setAVSyncSource({required String channelId, required int uid});

  /// Enables or disables the placeholder image streaming feature.
  ///
  /// When publishing a video stream, you can call this method to use a custom image to replace the current video stream for streaming.
  /// After enabling this feature, you can customize the placeholder image using the ImageTrackOptions parameter. After disabling the placeholder feature, remote users will still see the video stream you are currently publishing.
  ///
  /// * [enable] Whether to enable placeholder image streaming: true : Enable placeholder image streaming. false : (Default) Disable placeholder image streaming.
  /// * [options] Placeholder image settings. See ImageTrackOptions.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: The method call fails. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> enableVideoImageSource(
      {required bool enable, required ImageTrackOptions options});

  /// Gets the SDK's current monotonic time.
  ///
  /// Monotonic time refers to a monotonically increasing time sequence, whose value increases over time. The unit is milliseconds.
  /// In custom video capture and custom audio capture scenarios, to ensure audio-video synchronization, Agora recommends that you call this method to get the SDK's current monotonic time and then pass the value into the timestamp parameter of the captured VideoFrame or AudioFrame.
  ///
  /// Returns
  /// ≥ 0: The method call succeeds and returns the SDK's current monotonic time (milliseconds).
  ///  < 0: The method call fails. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<int> getCurrentMonotonicTimeInMs();

  /// @nodoc
  Future<void> enableWirelessAccelerate(bool enabled);

  /// Gets the local network connection type.
  ///
  /// You can call this method at any time to get the current network type in use. This method can be called before or after joining a channel.
  ///
  /// Returns
  /// ≥ 0: The method call succeeds and returns the local network connection type.
  ///  0: Network disconnected.
  ///  1: Network type is LAN.
  ///  2: Network type is Wi-Fi (including hotspot).
  ///  3: Network type is 2G mobile network.
  ///  4: Network type is 3G mobile network.
  ///  5: Network type is 4G mobile network.
  ///  6: Network type is 5G mobile network.
  ///  < 0: The method call fails and returns an error code.
  ///  -1: Unknown network connection type.
  Future<int> getNetworkType();

  /// JSON configuration information for the SDK, used to provide technical preview or customized features.
  ///
  /// * [parameters] Parameters in JSON string format.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setParameters(String parameters);

  /// Starts video frame rendering tracing.
  ///
  /// After this method is successfully called, the SDK uses the time of the call as the starting point and reports information related to video frame rendering through the onVideoRenderingTracingResult callback.
  ///  If you do not call this method, the SDK uses the time of calling joinChannel to join the channel as the starting point to begin tracing video rendering events automatically. You can call this method at an appropriate time based on your actual business scenario to customize the tracing.
  ///  After leaving the current channel, the SDK automatically resets the starting point to the time of the next channel join.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> startMediaRenderingTracing();

  /// Enables accelerated rendering of audio and video frames.
  ///
  /// After successfully calling this method, the SDK enables accelerated rendering mode for both video and audio, which speeds up the time to first frame and first sound after joining a channel. Both the host and audience need to call this method to enable accelerated rendering of audio and video frames to experience this feature.
  /// Once this method is successfully called, you can only disable accelerated rendering by calling the release method to destroy the RtcEngine object.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> enableInstantMediaRendering();

  /// Gets the current NTP (Network Time Protocol) time.
  ///
  /// In real-time chorus scenarios, especially when downlink inconsistency occurs across receiving ends due to network issues, you can call this method to get the current NTP time as the reference time to align lyrics and music across multiple receivers and achieve chorus synchronization.
  ///
  /// Returns
  /// Unix timestamp (milliseconds) of the current NTP time.
  Future<int> getNtpWallTimeInMs();

  /// Checks whether the device supports the specified advanced feature.
  ///
  /// Checks whether the current device meets the requirements for advanced features such as virtual background and beauty effects.
  ///
  /// * [type] The type of advanced feature. See FeatureType.
  ///
  /// Returns
  /// true : The device supports the specified advanced feature. false : The device does not support the specified advanced feature.
  Future<bool> isFeatureAvailableOnDevice(FeatureType type);

  /// @nodoc
  Future<void> sendAudioMetadata(
      {required Uint8List metadata, required int length});

  /// @nodoc
  Future<HdrCapability> queryHDRCapability(VideoModuleType videoModule);

  /// Starts screen capture and specifies the video source.
  ///
  /// This method is only applicable to macOS and Windows platforms.
  ///  If you use this method to start screen capture, you must call stopScreenCaptureBySourceType to stop it.
  ///  On Windows, up to 4 screen capture video streams are supported.
  ///  On macOS, only 1 screen capture video stream is supported.
  ///
  /// * [sourceType] The type of video source. See VideoSourceType. On macOS, only videoSourceScreen (2) is supported for this parameter.
  /// * [config] Screen capture configuration. See ScreenCaptureConfiguration.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> startScreenCaptureBySourceType(
      {required VideoSourceType sourceType,
      required ScreenCaptureConfiguration config});

  /// Stops screen capture for the specified video source.
  ///
  /// This method is only applicable to macOS and Windows.
  ///
  /// * [sourceType] The type of video source. See VideoSourceType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> stopScreenCaptureBySourceType(VideoSourceType sourceType);

  /// Destroys the RtcEngine object.
  ///
  /// This method releases all resources used by the SDK. Some Apps only use real-time audio and video communication when needed, and release resources when not needed for other operations. This method is suitable for such cases.
  /// After calling this method, you can no longer use other SDK methods and callbacks. To use real-time audio and video communication again, you must call createAgoraRtcEngine and initialize again to create a new RtcEngine object.
  ///  This method is a synchronous call. You must wait for the RtcEngine resources to be released before performing other operations (e.g., creating a new RtcEngine object), so it is recommended to call this method in a sub-thread to avoid blocking the main thread.
  ///  It is not recommended to call release within SDK callbacks, as the SDK must wait for the callback to return before recycling related object resources, which may cause a deadlock.
  ///
  /// * [sync] Whether this method is a synchronous call: true : This method is synchronous. false : This method is asynchronous. Currently, only synchronous calls are supported. Do not set this parameter to false.
  Future<void> release({bool sync = false});

  /// Starts video preview.
  ///
  /// This method starts the local video preview.
  ///  Local preview enables mirror mode by default.
  ///  After leaving the channel, local preview remains active. You need to call stopPreview to stop the local preview.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> startPreviewWithoutSourceType();

  /// Gets the AudioDeviceManager object to manage audio devices.
  ///
  /// Returns
  /// An AudioDeviceManager object.
  AudioDeviceManager getAudioDeviceManager();

  /// Gets a VideoDeviceManager object to manage video devices.
  ///
  /// Returns
  /// A VideoDeviceManager object.
  VideoDeviceManager getVideoDeviceManager();

  /// @nodoc
  MusicContentCenter getMusicContentCenter();

  /// Gets the MediaEngine object.
  ///
  /// This method must be called after initializing the RtcEngine object.
  ///
  /// Returns
  /// MediaEngine object.
  MediaEngine getMediaEngine();

  /// Gets the LocalSpatialAudioEngine object.
  ///
  /// You must call this method after initializing the RtcEngine object.
  ///
  /// Returns
  /// The LocalSpatialAudioEngine object.
  LocalSpatialAudioEngine getLocalSpatialAudioEngine();

  /// @nodoc
  H265Transcoder getH265Transcoder();

  /// Sends media metadata.
  ///
  /// If the metadata is sent successfully, the receiver receives the onMetadataReceived callback.
  ///
  /// * [metadata] The media metadata. See Metadata.
  /// * [sourceType] The type of video source. See VideoSourceType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: The method call fails. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> sendMetaData(
      {required Metadata metadata, required VideoSourceType sourceType});

  /// Sets the maximum size of media metadata.
  ///
  /// After calling registerMediaMetadataObserver, you can call this method to set the maximum size of media metadata.
  ///
  /// * [size] The maximum size of media metadata.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Failure. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setMaxMetadataSize(int size);

  /// Unregisters the audio encoded frame observer.
  ///
  /// * [observer] Audio encoded frame observer. See AudioEncodedFrameObserver.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  void unregisterAudioEncodedFrameObserver(AudioEncodedFrameObserver observer);

  /// Gets the C++ handle of the Native SDK.
  ///
  /// This method gets the C++ handle of the Native SDK engine, which is used in special scenarios including registering audio and video callbacks.
  ///
  /// Returns
  /// Native handle of the SDK engine.
  Future<int> getNativeHandle();

  /// Takes a video snapshot at the specified observation point.
  ///
  /// This method takes a snapshot of the specified user's video stream, generates a JPG image, and saves it to the specified path.
  ///  This method is asynchronous. When the call returns, the SDK has not actually captured the snapshot.
  ///  When used for local video snapshot, it captures the video stream specified in ChannelMediaOptions.
  ///
  /// * [uid] User ID. Set to 0 to capture the local user's video.
  /// * [config] Snapshot configuration. See SnapshotConfig.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> takeSnapshotWithConfig(
      {required int uid, required SnapshotConfig config});
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

/// Device state.
@JsonEnum(alwaysCreate: true)
enum MediaDeviceStateType {
  /// 0: Device is ready.
  @JsonValue(0)
  mediaDeviceStateIdle,

  /// 1: Device is in use.
  @JsonValue(1)
  mediaDeviceStateActive,

  /// 2: Device is disabled.
  @JsonValue(2)
  mediaDeviceStateDisabled,

  /// 3: Device is plugged in.
  @JsonValue(3)
  mediaDeviceStatePluggedIn,

  /// 4: Device is not present.
  @JsonValue(4)
  mediaDeviceStateNotPresent,

  /// 8: Device is unplugged.
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

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum VideoProfileType {
  /// @nodoc
  @JsonValue(0)
  videoProfileLandscape120p,

  /// @nodoc
  @JsonValue(2)
  videoProfileLandscape120p3,

  /// @nodoc
  @JsonValue(10)
  videoProfileLandscape180p,

  /// @nodoc
  @JsonValue(12)
  videoProfileLandscape180p3,

  /// @nodoc
  @JsonValue(13)
  videoProfileLandscape180p4,

  /// @nodoc
  @JsonValue(20)
  videoProfileLandscape240p,

  /// @nodoc
  @JsonValue(22)
  videoProfileLandscape240p3,

  /// @nodoc
  @JsonValue(23)
  videoProfileLandscape240p4,

  /// @nodoc
  @JsonValue(30)
  videoProfileLandscape360p,

  /// @nodoc
  @JsonValue(32)
  videoProfileLandscape360p3,

  /// @nodoc
  @JsonValue(33)
  videoProfileLandscape360p4,

  /// @nodoc
  @JsonValue(35)
  videoProfileLandscape360p6,

  /// @nodoc
  @JsonValue(36)
  videoProfileLandscape360p7,

  /// @nodoc
  @JsonValue(37)
  videoProfileLandscape360p8,

  /// @nodoc
  @JsonValue(38)
  videoProfileLandscape360p9,

  /// @nodoc
  @JsonValue(39)
  videoProfileLandscape360p10,

  /// @nodoc
  @JsonValue(100)
  videoProfileLandscape360p11,

  /// @nodoc
  @JsonValue(40)
  videoProfileLandscape480p,

  /// @nodoc
  @JsonValue(42)
  videoProfileLandscape480p3,

  /// @nodoc
  @JsonValue(43)
  videoProfileLandscape480p4,

  /// @nodoc
  @JsonValue(45)
  videoProfileLandscape480p6,

  /// @nodoc
  @JsonValue(47)
  videoProfileLandscape480p8,

  /// @nodoc
  @JsonValue(48)
  videoProfileLandscape480p9,

  /// @nodoc
  @JsonValue(49)
  videoProfileLandscape480p10,

  /// @nodoc
  @JsonValue(50)
  videoProfileLandscape720p,

  /// @nodoc
  @JsonValue(52)
  videoProfileLandscape720p3,

  /// @nodoc
  @JsonValue(54)
  videoProfileLandscape720p5,

  /// @nodoc
  @JsonValue(55)
  videoProfileLandscape720p6,

  /// @nodoc
  @JsonValue(60)
  videoProfileLandscape1080p,

  /// @nodoc
  @JsonValue(62)
  videoProfileLandscape1080p3,

  /// @nodoc
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

  /// @nodoc
  @JsonValue(1010)
  videoProfilePortrait180p,

  /// @nodoc
  @JsonValue(1012)
  videoProfilePortrait180p3,

  /// @nodoc
  @JsonValue(1013)
  videoProfilePortrait180p4,

  /// @nodoc
  @JsonValue(1020)
  videoProfilePortrait240p,

  /// @nodoc
  @JsonValue(1022)
  videoProfilePortrait240p3,

  /// @nodoc
  @JsonValue(1023)
  videoProfilePortrait240p4,

  /// @nodoc
  @JsonValue(1030)
  videoProfilePortrait360p,

  /// @nodoc
  @JsonValue(1032)
  videoProfilePortrait360p3,

  /// @nodoc
  @JsonValue(1033)
  videoProfilePortrait360p4,

  /// @nodoc
  @JsonValue(1035)
  videoProfilePortrait360p6,

  /// @nodoc
  @JsonValue(1036)
  videoProfilePortrait360p7,

  /// @nodoc
  @JsonValue(1037)
  videoProfilePortrait360p8,

  /// @nodoc
  @JsonValue(1038)
  videoProfilePortrait360p9,

  /// @nodoc
  @JsonValue(1039)
  videoProfilePortrait360p10,

  /// @nodoc
  @JsonValue(1100)
  videoProfilePortrait360p11,

  /// @nodoc
  @JsonValue(1040)
  videoProfilePortrait480p,

  /// @nodoc
  @JsonValue(1042)
  videoProfilePortrait480p3,

  /// @nodoc
  @JsonValue(1043)
  videoProfilePortrait480p4,

  /// @nodoc
  @JsonValue(1045)
  videoProfilePortrait480p6,

  /// @nodoc
  @JsonValue(1047)
  videoProfilePortrait480p8,

  /// @nodoc
  @JsonValue(1048)
  videoProfilePortrait480p9,

  /// @nodoc
  @JsonValue(1049)
  videoProfilePortrait480p10,

  /// @nodoc
  @JsonValue(1050)
  videoProfilePortrait720p,

  /// @nodoc
  @JsonValue(1052)
  videoProfilePortrait720p3,

  /// @nodoc
  @JsonValue(1054)
  videoProfilePortrait720p5,

  /// @nodoc
  @JsonValue(1055)
  videoProfilePortrait720p6,

  /// @nodoc
  @JsonValue(1060)
  videoProfilePortrait1080p,

  /// @nodoc
  @JsonValue(1062)
  videoProfilePortrait1080p3,

  /// @nodoc
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

  /// @nodoc
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
class SDKBuildInfo implements AgoraSerializable {
  /// @nodoc
  const SDKBuildInfo({this.build, this.version});

  /// SDK build number.
  @JsonKey(name: 'build')
  final int? build;

  /// SDK version number. Format is a string, such as 6.0.0.
  @JsonKey(name: 'version')
  final String? version;

  /// @nodoc
  factory SDKBuildInfo.fromJson(Map<String, dynamic> json) =>
      _$SDKBuildInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SDKBuildInfoToJson(this);
}

/// The VideoDeviceInfo class, contains the video device ID and device name.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoDeviceInfo implements AgoraSerializable {
  /// @nodoc
  const VideoDeviceInfo({this.deviceId, this.deviceName});

  /// Device ID.
  @JsonKey(name: 'deviceId')
  final String? deviceId;

  /// Device name.
  @JsonKey(name: 'deviceName')
  final String? deviceName;

  /// @nodoc
  factory VideoDeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$VideoDeviceInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$VideoDeviceInfoToJson(this);
}

/// The AudioDeviceInfo class, containing the audio device ID and device name.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioDeviceInfo implements AgoraSerializable {
  /// @nodoc
  const AudioDeviceInfo({this.deviceId, this.deviceTypeName, this.deviceName});

  /// Device ID.
  @JsonKey(name: 'deviceId')
  final String? deviceId;

  /// Audio device type, such as: built-in, USB, HDMI, etc.
  @JsonKey(name: 'deviceTypeName')
  final String? deviceTypeName;

  /// Device name.
  @JsonKey(name: 'deviceName')
  final String? deviceName;

  /// @nodoc
  factory AudioDeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$AudioDeviceInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AudioDeviceInfoToJson(this);
}
