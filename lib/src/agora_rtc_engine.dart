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

  /// 2: Video rendering device (graphics card).
  @JsonValue(2)
  videoRenderDevice,

  /// 3: Video capturing device.
  @JsonValue(3)
  videoCaptureDevice,

  /// 4: Audio playback device for an app.
  @JsonValue(4)
  audioApplicationPlayoutDevice,

  /// (For macOS only) 5: Virtual audio playback device (virtual sound card).
  @JsonValue(5)
  audioVirtualPlayoutDevice,

  /// (For macOS only) 6: Virtual audio capturing device (virtual sound card).
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

/// The playback state of the music file.
@JsonEnum(alwaysCreate: true)
enum AudioMixingStateType {
  /// 710: The music file is playing.
  @JsonValue(710)
  audioMixingStatePlaying,

  /// 711: The music file pauses playing.
  @JsonValue(711)
  audioMixingStatePaused,

  /// 713: The music file stops playing. The possible reasons include: audioMixingReasonAllLoopsCompleted (723) audioMixingReasonStoppedByUser (724)
  @JsonValue(713)
  audioMixingStateStopped,

  /// 714: An error occurs during the playback of the audio mixing file. The possible reasons include: audioMixingReasonCanNotOpen (701) audioMixingReasonTooFrequentCall (702) audioMixingReasonInterruptedEof (703)
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

/// Options for handling audio and video stream fallback when network conditions are weak.
@JsonEnum(alwaysCreate: true)
enum StreamFallbackOptions {
  /// 0: No fallback processing is performed on audio and video streams, the quality of the audio and video streams cannot be guaranteed.
  @JsonValue(0)
  streamFallbackOptionDisabled,

  /// 1: Only receive low-quality (low resolution, low bitrate) video stream.
  @JsonValue(1)
  streamFallbackOptionVideoStreamLow,

  /// 2: When the network conditions are weak, try to receive the low-quality video stream first. If the video cannot be displayed due to extremely weak network environment, then fall back to receiving audio-only stream.
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

  /// The ID of the local user.
  @JsonKey(name: 'uid')
  final int? uid;

  /// The actual bitrate (Kbps) while sending the local video stream. This value does not include the bitrate for resending the video after packet loss.
  @JsonKey(name: 'sentBitrate')
  final int? sentBitrate;

  /// The actual frame rate (fps) while sending the local video stream. This value does not include the frame rate for resending the video after packet loss.
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

  /// The quality adaptation of the local video stream in the reported interval (based on the target frame rate and target bitrate). See QualityAdaptIndication.
  @JsonKey(name: 'qualityAdaptIndication')
  final QualityAdaptIndication? qualityAdaptIndication;

  /// The bitrate (Kbps) while encoding the local video stream. This value does not include the bitrate for resending the video after packet loss.
  @JsonKey(name: 'encodedBitrate')
  final int? encodedBitrate;

  /// The number of the sent video frames, represented by an aggregate value.
  @JsonKey(name: 'encodedFrameCount')
  final int? encodedFrameCount;

  /// The codec type of the local video. See VideoCodecType.
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
  ///  0: Software encoding is applied without acceleration.
  ///  1: Hardware encoding is applied for acceleration.
  @JsonKey(name: 'hwEncoderAccelerating')
  final int? hwEncoderAccelerating;

  /// @nodoc
  factory LocalVideoStats.fromJson(Map<String, dynamic> json) =>
      _$LocalVideoStatsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LocalVideoStatsToJson(this);
}

/// Audio statistics of the remote user.
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

  /// The quality of the audio stream sent by the user. See QualityType.
  @JsonKey(name: 'quality')
  final int? quality;

  /// The network delay (ms) from the sender to the receiver.
  @JsonKey(name: 'networkTransportDelay')
  final int? networkTransportDelay;

  /// The network delay (ms) from the audio receiver to the jitter buffer. When the receiving end is an audience member and audienceLatencyLevel of ClientRoleOptions is 1, this parameter does not take effect.
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

  /// The quality of the remote audio stream in the reported interval. The quality is determined by the Agora real-time audio MOS (Mean Opinion Score) measurement method. The return value range is [0, 500]. Dividing the return value by 100 gets the MOS score, which ranges from 0 to 5. The higher the score, the better the audio quality. The subjective perception of audio quality corresponding to the Agora real-time audio MOS scores is as follows: MOS score Perception of audio quality Greater than 4 Excellent. The audio sounds clear and smooth. From 3.5 to 4 Good. The audio has some perceptible impairment but still sounds clear. From 3 to 3.5 Fair. The audio freezes occasionally and requires attentive listening. From 2.5 to 3 Poor. The audio sounds choppy and requires considerable effort to understand. From 2 to 2.5 Bad. The audio has occasional noise. Consecutive audio dropouts occur, resulting in some information loss. The users can communicate only with difficulty. Less than 2 Very bad. The audio has persistent noise. Consecutive audio dropouts are frequent, resulting in severe information loss. Communication is nearly impossible.
  @JsonKey(name: 'mosValue')
  final int? mosValue;

  /// @nodoc
  @JsonKey(name: 'frozenRateByCustomPlcCount')
  final int? frozenRateByCustomPlcCount;

  /// @nodoc
  @JsonKey(name: 'plcCount')
  final int? plcCount;

  /// The total active time (ms) between the start of the audio call and the callback of the remote user. The active time refers to the total duration of the remote user without the mute state.
  @JsonKey(name: 'totalActiveTime')
  final int? totalActiveTime;

  /// The total duration (ms) of the remote audio stream.
  @JsonKey(name: 'publishDuration')
  final int? publishDuration;

  /// The Quality of Experience (QoE) of the local user when receiving a remote audio stream.
  @JsonKey(name: 'qoeQuality')
  final int? qoeQuality;

  /// Reasons why the QoE of the local user when receiving a remote audio stream is poor. See ExperiencePoorReason.
  @JsonKey(name: 'qualityChangedReason')
  final int? qualityChangedReason;

  /// @nodoc
  @JsonKey(name: 'rxAudioBytes')
  final int? rxAudioBytes;

  /// End-to-end audio delay (in milliseconds), which refers to the time from when the audio is captured by the remote user to when it is played by the local user.
  @JsonKey(name: 'e2eDelay')
  final int? e2eDelay;

  /// @nodoc
  factory RemoteAudioStats.fromJson(Map<String, dynamic> json) =>
      _$RemoteAudioStatsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RemoteAudioStatsToJson(this);
}

/// Statistics of the remote video stream.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RemoteVideoStats {
  /// @nodoc
  const RemoteVideoStats(
      {this.uid,
      this.delay,
      this.e2eDelay,
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
      this.mosValue,
      this.rxVideoBytes});

  /// The user ID of the remote user sending the video stream.
  @JsonKey(name: 'uid')
  final int? uid;

  /// Deprecated: In scenarios where audio and video are synchronized, you can get the video delay data from networkTransportDelay and jitterBufferDelay in RemoteAudioStats. The video delay (ms).
  @JsonKey(name: 'delay')
  final int? delay;

  /// End-to-end video latency (ms). That is, the time elapsed from the video capturing on the remote user's end to the receiving and rendering of the video on the local user's end.
  @JsonKey(name: 'e2eDelay')
  final int? e2eDelay;

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

  /// The type of the video stream. See VideoStreamType.
  @JsonKey(name: 'rxStreamType')
  final VideoStreamType? rxStreamType;

  /// The total freeze time (ms) of the remote video stream after the remote user joins the channel. In a video session where the frame rate is set to no less than 5 fps, video freeze occurs when the time interval between two adjacent renderable video frames is more than 500 ms.
  @JsonKey(name: 'totalFrozenTime')
  final int? totalFrozenTime;

  /// The total video freeze time as a percentage (%) of the total time the video is available. The video is considered available as long as that the remote user neither stops sending the video stream nor disables the video module after joining the channel.
  @JsonKey(name: 'frozenRate')
  final int? frozenRate;

  /// The amount of time (ms) that the audio is ahead of the video. If this value is negative, the audio is lagging behind the video.
  @JsonKey(name: 'avSyncTimeMs')
  final int? avSyncTimeMs;

  /// The total active time (ms) of the video. As long as the remote user or host neither stops sending the video stream nor disables the video module after joining the channel, the video is available.
  @JsonKey(name: 'totalActiveTime')
  final int? totalActiveTime;

  /// The total duration (ms) of the remote video stream.
  @JsonKey(name: 'publishDuration')
  final int? publishDuration;

  /// @nodoc
  @JsonKey(name: 'mosValue')
  final int? mosValue;

  /// @nodoc
  @JsonKey(name: 'rxVideoBytes')
  final int? rxVideoBytes;

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
///
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

/// The camera direction.
@JsonEnum(alwaysCreate: true)
enum CameraDirection {
  /// 0: The rear camera.
  @JsonValue(0)
  cameraRear,

  /// 1: (Default) The front camera.
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
      this.cameraFocalLengthType,
      this.deviceId,
      this.cameraId,
      this.followEncodeDimensionRatio,
      this.format});

  /// (Optional) The camera direction. See CameraDirection. This parameter is for Android and iOS only.
  @JsonKey(name: 'cameraDirection')
  final CameraDirection? cameraDirection;

  /// (Optional) The camera focal length type. See CameraFocalLengthType.
  ///  This parameter is for Android and iOS only.
  ///  To set the focal length type of the camera, it is only supported to specify the camera through cameraDirection, and not supported to specify it through cameraId.
  ///  For iOS devices equipped with multi-lens rear cameras, such as those featuring dual-camera (wide-angle and ultra-wide-angle) or triple-camera (wide-angle, ultra-wide-angle, and telephoto), you can use one of the following methods to capture video with an ultra-wide-angle perspective:
  ///  Method one: Set this parameter to cameraFocalLengthUltraWide (2) (ultra-wide lens).
  ///  Method two: Set this parameter to cameraFocalLengthDefault (0) (standard lens), then call setCameraZoomFactor to set the camera's zoom factor to a value less than 1.0, with the minimum setting being 0.5. The difference is that the size of the ultra-wide angle in method one is not adjustable, whereas method two supports adjusting the camera's zoom factor freely.
  @JsonKey(name: 'cameraFocalLengthType')
  final CameraFocalLengthType? cameraFocalLengthType;

  /// The camera ID. The maximum length is MaxDeviceIdLengthType. This parameter is for Windows and macOS only.
  @JsonKey(name: 'deviceId')
  final String? deviceId;

  /// (Optional) The camera ID. The default value is the camera ID of the front camera. You can get the camera ID through the Android native system API, see and for details.
  ///  This parameter is for Android only.
  ///  This parameter and cameraDirection are mutually exclusive in specifying the camera; you can choose one based on your needs. The differences are as follows:
  ///  Specifying the camera via cameraDirection is more straightforward. You only need to indicate the camera direction (front or rear), without specifying a specific camera ID; the SDK will retrieve and confirm the actual camera ID through Android native system APIs.
  ///  Specifying via cameraId allows for more precise identification of a particular camera. For devices with multiple cameras, where cameraDirection cannot recognize or access all available cameras, it is recommended to use cameraId to specify the desired camera ID directly.
  @JsonKey(name: 'cameraId')
  final String? cameraId;

  /// (Optional) Whether to follow the video aspect ratio set in setVideoEncoderConfiguration : true : (Default) Follow the set video aspect ratio. The SDK crops the captured video according to the set video aspect ratio and synchronously changes the local preview screen and the video frame in onCaptureVideoFrame and onPreEncodeVideoFrame. false : Do not follow the system default audio playback device. The SDK does not change the aspect ratio of the captured video frame.
  @JsonKey(name: 'followEncodeDimensionRatio')
  final bool? followEncodeDimensionRatio;

  /// (Optional) The format of the video frame. See VideoFormat.
  @JsonKey(name: 'format')
  final VideoFormat? format;

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

  /// Whether to capture the window on the screen: true : Capture the window. false : (Default) Capture the screen, not the window.
  @JsonKey(name: 'isCaptureWindow')
  final bool? isCaptureWindow;

  /// (macOS only) The display ID of the screen. This parameter takes effect only when you want to capture the screen on macOS.
  @JsonKey(name: 'displayId')
  final int? displayId;

  /// (Windows only) The relative position of the shared screen to the virtual screen. This parameter takes effect only when you want to capture the screen on Windows.
  @JsonKey(name: 'screenRect')
  final Rectangle? screenRect;

  /// (For Windows and macOS only) Window ID. This parameter takes effect only when you want to capture the window.
  @JsonKey(name: 'windowId')
  final int? windowId;

  /// (For Windows and macOS only) The screen capture configuration. See ScreenCaptureParameters.
  @JsonKey(name: 'params')
  final ScreenCaptureParameters? params;

  /// (For Windows and macOS only) The relative position of the shared region to the whole screen. See Rectangle. If you do not set this parameter, the SDK shares the whole screen. If the region you set exceeds the boundary of the screen, only the region within in the screen is shared. If you set width or height in Rectangle as 0, the whole screen is shared.
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

/// The image content of the thumbnail or icon. Set in ScreenCaptureSourceInfo.
///
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

/// The type of the shared target. Set in ScreenCaptureSourceInfo.
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
      this.position,
      this.minimizeWindow,
      this.sourceDisplayId});

  /// The type of the shared target. See ScreenCaptureSourceType.
  @JsonKey(name: 'type')
  final ScreenCaptureSourceType? type;

  /// The window ID for a window or the display ID for a screen.
  @JsonKey(name: 'sourceId')
  final int? sourceId;

  /// The name of the window or screen. UTF-8 encoding.
  @JsonKey(name: 'sourceName')
  final String? sourceName;

  /// The image content of the thumbnail. See ThumbImageBuffer.
  @JsonKey(name: 'thumbImage')
  final ThumbImageBuffer? thumbImage;

  /// The image content of the icon. See ThumbImageBuffer.
  @JsonKey(name: 'iconImage')
  final ThumbImageBuffer? iconImage;

  /// The process to which the window belongs. UTF-8 encoding.
  @JsonKey(name: 'processPath')
  final String? processPath;

  /// The title of the window. UTF-8 encoding.
  @JsonKey(name: 'sourceTitle')
  final String? sourceTitle;

  /// Determines whether the screen is the primary display: true : The screen is the primary display. false : The screen is not the primary display.
  @JsonKey(name: 'primaryMonitor')
  final bool? primaryMonitor;

  /// @nodoc
  @JsonKey(name: 'isOccluded')
  final bool? isOccluded;

  /// The position of a window relative to the entire screen space (including all shareable screens). See Rectangle.
  @JsonKey(name: 'position')
  final Rectangle? position;

  /// (For Windows only) Whether the window is minimized: true : The window is minimized. false : The window is not minimized.
  @JsonKey(name: 'minimizeWindow')
  final bool? minimizeWindow;

  /// (For Windows only) Screen ID where the window is located. If the window is displayed across multiple screens, this parameter indicates the ID of the screen with which the window has the largest intersection area. If the window is located outside of the visible screens, the value of this member is -2.
  @JsonKey(name: 'sourceDisplayId')
  final int? sourceDisplayId;

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

  /// The number of channels for audio preprocessing. See audioprocessingchannels.
  @JsonKey(name: 'audioProcessingChannels')
  final int? audioProcessingChannels;

  /// @nodoc
  factory AdvancedAudioOptions.fromJson(Map<String, dynamic> json) =>
      _$AdvancedAudioOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AdvancedAudioOptionsToJson(this);
}

/// Image configurations.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ImageTrackOptions {
  /// @nodoc
  const ImageTrackOptions({this.imageUrl, this.fps, this.mirrorMode});

  /// The image URL. Supported formats of images include JPEG, JPG, PNG and GIF. This method supports adding an image from the local absolute or relative file path. On the Android platform, adding images from /assets/ is not supported.
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
///
/// Agora supports publishing multiple audio streams and one video stream at the same time and in the same RtcConnection. For example, publishMicrophoneTrack, publishCustomAudioTrack, and publishMediaPlayerAudioTrack can be set as true at the same time, but only one of publishCameraTrack, publishScreenCaptureVideo, publishScreenTrack, publishCustomVideoTrack, or publishEncodedVideoTrack can be set as true. Agora recommends that you set member parameter values yourself according to your business scenario, otherwise the SDK will automatically assign values to member parameters.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ChannelMediaOptions {
  /// @nodoc
  const ChannelMediaOptions(
      {this.publishCameraTrack,
      this.publishSecondaryCameraTrack,
      this.publishThirdCameraTrack,
      this.publishFourthCameraTrack,
      this.publishMicrophoneTrack,
      this.publishScreenCaptureVideo,
      this.publishScreenCaptureAudio,
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
      this.isAudioFilterable});

  /// Whether to publish the video captured by the camera: true : Publish the video captured by the camera. false : Do not publish the video captured by the camera.
  @JsonKey(name: 'publishCameraTrack')
  final bool? publishCameraTrack;

  /// Whether to publish the video captured by the second camera: true : Publish the video captured by the second camera. false : Do not publish the video captured by the second camera.
  @JsonKey(name: 'publishSecondaryCameraTrack')
  final bool? publishSecondaryCameraTrack;

  /// Whether to publish the video captured by the third camera: true : Publish the video captured by the third camera. false : Do not publish the video captured by the third camera. This parameter is for Android, Windows and macOS only.
  @JsonKey(name: 'publishThirdCameraTrack')
  final bool? publishThirdCameraTrack;

  /// Whether to publish the video captured by the fourth camera: true : Publish the video captured by the fourth camera. false : Do not publish the video captured by the fourth camera. This parameter is for Android, Windows and macOS only.
  @JsonKey(name: 'publishFourthCameraTrack')
  final bool? publishFourthCameraTrack;

  /// Whether to publish the audio captured by the microphone: true : Publish the audio captured by the microphone. false : Do not publish the audio captured by the microphone.
  @JsonKey(name: 'publishMicrophoneTrack')
  final bool? publishMicrophoneTrack;

  /// Whether to publish the video captured from the screen: true : Publish the video captured from the screen. false : Do not publish the video captured from the screen. This parameter is for Android and iOS only.
  @JsonKey(name: 'publishScreenCaptureVideo')
  final bool? publishScreenCaptureVideo;

  /// Whether to publish the audio captured from the screen: true : Publish the audio captured from the screen. false : Publish the audio captured from the screen. This parameter is for Android and iOS only.
  @JsonKey(name: 'publishScreenCaptureAudio')
  final bool? publishScreenCaptureAudio;

  /// Whether to publish the video captured from the screen: true : Publish the video captured from the screen. false : Do not publish the video captured from the screen. This is for Windows and macOS only.
  @JsonKey(name: 'publishScreenTrack')
  final bool? publishScreenTrack;

  /// Whether to publish the video captured from the second screen: true : Publish the video captured from the second screen. false : Do not publish the video captured from the second screen.
  @JsonKey(name: 'publishSecondaryScreenTrack')
  final bool? publishSecondaryScreenTrack;

  /// Whether to publish the video captured from the third screen: true : Publish the captured video from the third screen. false : Do not publish the video captured from the third screen. This is for Windows and macOS only.
  @JsonKey(name: 'publishThirdScreenTrack')
  final bool? publishThirdScreenTrack;

  /// Whether to publish the video captured from the fourth screen: true : Publish the captured video from the fourth screen. false : Do not publish the video captured from the fourth screen. This is for Windows and macOS only.
  @JsonKey(name: 'publishFourthScreenTrack')
  final bool? publishFourthScreenTrack;

  /// Whether to publish the audio captured from a custom source: true : Publish the audio captured from the custom source. false : Do not publish the captured audio from a custom source.
  @JsonKey(name: 'publishCustomAudioTrack')
  final bool? publishCustomAudioTrack;

  /// The ID of the custom audio source to publish. The default value is 0. If you have set sourceNumber in setExternalAudioSource to a value greater than 1, the SDK creates the corresponding number of custom audio tracks and assigns an ID to each audio track, starting from 0.
  @JsonKey(name: 'publishCustomAudioTrackId')
  final int? publishCustomAudioTrackId;

  /// Whether to publish the video captured from a custom source: true : Publish the video captured from the custom source. false : Do not publish the captured video from a custom source.
  @JsonKey(name: 'publishCustomVideoTrack')
  final bool? publishCustomVideoTrack;

  /// Whether to publish the encoded video: true : Publish the encoded video. false : Do not publish the encoded video.
  @JsonKey(name: 'publishEncodedVideoTrack')
  final bool? publishEncodedVideoTrack;

  /// Whether to publish the audio from the media player: true : Publish the audio from the media player. false : Do not publish the audio from the media player.
  @JsonKey(name: 'publishMediaPlayerAudioTrack')
  final bool? publishMediaPlayerAudioTrack;

  /// Whether to publish the video from the media player: true : Publish the video from the media player. false : Do not publish the video from the media player.
  @JsonKey(name: 'publishMediaPlayerVideoTrack')
  final bool? publishMediaPlayerVideoTrack;

  /// Whether to publish the local transcoded video: true : Publish the local transcoded video. false : Do not publish the local transcoded video.
  @JsonKey(name: 'publishTranscodedVideoTrack')
  final bool? publishTranscodedVideoTrack;

  /// @nodoc
  @JsonKey(name: 'publishMixedAudioTrack')
  final bool? publishMixedAudioTrack;

  /// @nodoc
  @JsonKey(name: 'publishLipSyncTrack')
  final bool? publishLipSyncTrack;

  /// Whether to automatically subscribe to all remote audio streams when the user joins a channel: true : Subscribe to all remote audio streams. false : Do not automatically subscribe to any remote audio streams.
  @JsonKey(name: 'autoSubscribeAudio')
  final bool? autoSubscribeAudio;

  /// Whether to automatically subscribe to all remote video streams when the user joins the channel: true : Subscribe to all remote video streams. false : Do not automatically subscribe to any remote video streams.
  @JsonKey(name: 'autoSubscribeVideo')
  final bool? autoSubscribeVideo;

  /// Whether to enable audio capturing or playback: true : Enable audio capturing or playback. false : Do not enable audio capturing or playback. If you need to publish the audio streams captured by your microphone, ensure this parameter is set as true.
  @JsonKey(name: 'enableAudioRecordingOrPlayout')
  final bool? enableAudioRecordingOrPlayout;

  /// The ID of the media player to be published. The default value is 0.
  @JsonKey(name: 'publishMediaPlayerId')
  final int? publishMediaPlayerId;

  /// The user role. See ClientRoleType.
  @JsonKey(name: 'clientRoleType')
  final ClientRoleType? clientRoleType;

  /// The latency level of an audience member in interactive live streaming. See AudienceLatencyLevelType.
  @JsonKey(name: 'audienceLatencyLevel')
  final AudienceLatencyLevelType? audienceLatencyLevel;

  /// The default video-stream type. See VideoStreamType.
  @JsonKey(name: 'defaultVideoStreamType')
  final VideoStreamType? defaultVideoStreamType;

  /// The channel profile. See ChannelProfileType.
  @JsonKey(name: 'channelProfile')
  final ChannelProfileType? channelProfile;

  /// Delay (in milliseconds) for sending audio frames. You can use this parameter to set the delay of the audio frames that need to be sent, to ensure audio and video synchronization. To switch off the delay, set the value to 0.
  @JsonKey(name: 'audioDelayMs')
  final int? audioDelayMs;

  /// @nodoc
  @JsonKey(name: 'mediaPlayerAudioDelayMs')
  final int? mediaPlayerAudioDelayMs;

  /// (Optional) The token generated on your server for authentication.
  ///  This parameter takes effect only when calling updateChannelMediaOptions or updateChannelMediaOptionsEx.
  ///  Ensure that the App ID, channel name, and user name used for creating the token are the same as those used by the initialize method for initializing the RTC engine, and those used by the joinChannel and joinChannelEx methods for joining the channel.
  @JsonKey(name: 'token')
  final String? token;

  /// @nodoc
  @JsonKey(name: 'enableBuiltInMediaEncryption')
  final bool? enableBuiltInMediaEncryption;

  /// Whether to publish the sound of a metronome to remote users: true : Publish processed audio frames. Both the local user and remote users can hear the metronome. false : Do not publish the sound of the metronome. Only the local user can hear the metronome.
  @JsonKey(name: 'publishRhythmPlayerTrack')
  final bool? publishRhythmPlayerTrack;

  /// Whether to enable interactive mode: true : Enable interactive mode. Once this mode is enabled and the user role is set as audience, the user can receive remote video streams with low latency. false :Do not enable interactive mode. If this mode is disabled, the user receives the remote video streams in default settings.
  ///  This parameter only applies to co-streaming scenarios. The cohosts need to call the joinChannelEx method to join the other host's channel as an audience member, and set isInteractiveAudience to true.
  ///  This parameter takes effect only when the user role is clientRoleAudience.
  @JsonKey(name: 'isInteractiveAudience')
  final bool? isInteractiveAudience;

  /// The video track ID returned by calling the createCustomVideoTrack method. The default value is 0.
  @JsonKey(name: 'customVideoTrackId')
  final int? customVideoTrackId;

  /// Whether the audio stream being published is filtered according to the volume algorithm: true : The audio stream is filtered. If the audio stream filter is not enabled, this setting does not takes effect. false : The audio stream is not filtered. If you need to enable this function, contact.
  @JsonKey(name: 'isAudioFilterable')
  final bool? isAudioFilterable;

  /// @nodoc
  factory ChannelMediaOptions.fromJson(Map<String, dynamic> json) =>
      _$ChannelMediaOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ChannelMediaOptionsToJson(this);
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

/// The type of the advanced feature.
@JsonEnum(alwaysCreate: true)
enum FeatureType {
  /// 1: Virtual background.
  @JsonValue(1)
  videoVirtualBackground,

  /// 2: Image enhancement.
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

/// The options for leaving a channel.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LeaveChannelOptions {
  /// @nodoc
  const LeaveChannelOptions(
      {this.stopAudioMixing, this.stopAllEffect, this.stopMicrophoneRecording});

  /// Whether to stop playing and mixing the music file when a user leaves the channel. true : (Default) Stop playing and mixing the music file. false : Do not stop playing and mixing the music file.
  @JsonKey(name: 'stopAudioMixing')
  final bool? stopAudioMixing;

  /// Whether to stop playing all audio effects when a user leaves the channel. true : (Default) Stop playing all audio effects. false : Do not stop playing any audio effect.
  @JsonKey(name: 'stopAllEffect')
  final bool? stopAllEffect;

  /// Whether to stop microphone recording when a user leaves the channel. true : (Default) Stop microphone recording. false : Do not stop microphone recording.
  @JsonKey(name: 'stopMicrophoneRecording')
  final bool? stopMicrophoneRecording;

  /// @nodoc
  factory LeaveChannelOptions.fromJson(Map<String, dynamic> json) =>
      _$LeaveChannelOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LeaveChannelOptionsToJson(this);
}

/// The SDK uses the RtcEngineEventHandler interface to send event notifications to your app. Your app can get those notifications through methods that inherit this interface.
///
/// All methods in this interface have default (empty) implementation. You can choose to inherit events related to your app scenario.
///  In the callbacks, avoid implementing time-consuming tasks or calling APIs that may cause thread blocking (such as sendMessage). Otherwise, the SDK may not work properly.
///  The SDK no longer catches exceptions in the code logic that developers implement themselves in RtcEngineEventHandler class. You need to handle this exception yourself, otherwise the app may crash when the exception occurs.
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
    this.onExtensionEvent,
    this.onExtensionStarted,
    this.onExtensionStopped,
    this.onExtensionError,
    this.onSetRtmFlagResult,
  });

  /// Occurs when a user joins a channel.
  ///
  /// This callback notifies the application that a user joins a specified channel.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [elapsed] The time elapsed (ms) from the local user calling joinChannel until the SDK triggers this callback.
  final void Function(RtcConnection connection, int elapsed)?
      onJoinChannelSuccess;

  /// Occurs when a user rejoins the channel.
  ///
  /// When a user loses connection with the server because of network problems, the SDK automatically tries to reconnect and triggers this callback upon reconnection.
  ///
  /// * [elapsed] Time elapsed (ms) from the local user calling joinChannel until the SDK triggers this callback.
  final void Function(RtcConnection connection, int elapsed)?
      onRejoinChannelSuccess;

  /// Reports the proxy connection state.
  ///
  /// You can use this callback to listen for the state of the SDK connecting to a proxy. For example, when a user calls setCloudProxy and joins a channel successfully, the SDK triggers this callback to report the user ID, the proxy type connected, and the time elapsed fromthe user calling joinChannel until this callback is triggered.
  ///
  /// * [channel] The channel name.
  /// * [uid] The user ID.
  /// * [localProxyIp] Reserved for future use.
  /// * [elapsed] The time elapsed (ms) from the user calling joinChannel until this callback is triggered.
  final void Function(String channel, int uid, ProxyType proxyType,
      String localProxyIp, int elapsed)? onProxyConnected;

  /// Reports an error during SDK runtime.
  ///
  /// This callback indicates that an error (concerning network or media) occurs during SDK runtime. In most cases, the SDK cannot fix the issue and resume running. The SDK requires the app to take action or informs the user about the issue.
  ///
  /// * [err] Error code. See ErrorCodeType.
  /// * [msg] The error message.
  final void Function(ErrorCodeType err, String msg)? onError;

  /// Reports the statistics of the audio stream sent by each remote user.
  ///
  /// Deprecated: Use onRemoteAudioStats instead. The SDK triggers this callback once every two seconds to report the audio quality of each remote user who is sending an audio stream. If a channel has multiple users sending audio streams, the SDK triggers this callback as many times.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [remoteUid] The user ID of the remote user sending the audio stream.
  /// * [quality] Audio quality of the user. See QualityType.
  /// * [delay] The network delay (ms) from the sender to the receiver, including the delay caused by audio sampling pre-processing, network transmission, and network jitter buffering.
  /// * [lost] The packet loss rate (%) of the audio packet sent from the remote user to the receiver.
  final void Function(RtcConnection connection, int remoteUid,
      QualityType quality, int delay, int lost)? onAudioQuality;

  /// Reports the last mile network probe result.
  ///
  /// The SDK triggers this callback within 30 seconds after the app calls startLastmileProbeTest.
  ///
  /// * [result] The uplink and downlink last-mile network probe test result. See LastmileProbeResult.
  final void Function(LastmileProbeResult result)? onLastmileProbeResult;

  /// Reports the volume information of users.
  ///
  /// By default, this callback is disabled. You can enable it by calling enableAudioVolumeIndication. Once this callback is enabled and users send streams in the channel, the SDK triggers the onAudioVolumeIndication callback according to the time interval set in enableAudioVolumeIndication. The SDK triggers two independent onAudioVolumeIndication callbacks simultaneously, which separately report the volume information of the local user who sends a stream and the remote users (up to three) whose instantaneous volume is the highest. Once this callback is enabled, if the local user calls the muteLocalAudioStream method to mute, the SDK continues to report the volume indication of the local user. If a remote user whose volume is one of the three highest in the channel stops publishing the audio stream for 20 seconds, the callback excludes this user's information; if all remote users stop publishing audio streams for 20 seconds, the SDK stops triggering the callback for remote users.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [speakers] The volume information of the users. See AudioVolumeInfo. An empty speakers array in the callback indicates that no remote user is in the channel or is sending a stream.
  /// * [speakerNumber] The total number of users.
  ///  In the callback for the local user, if the local user is sending streams, the value of speakerNumber is 1.
  ///  In the callback for remote users, the value range of speakerNumber is [0,3]. If the number of remote users who send streams is greater than or equal to three, the value of speakerNumber is 3.
  /// * [totalVolume] The volume of the speaker. The value range is [0,255].
  ///  In the callback for the local user, totalVolume is the volume of the local user who sends a stream. In the callback for remote users, totalVolume is the sum of the volume of all remote users (up to three) whose instantaneous volume is the highest.
  final void Function(RtcConnection connection, List<AudioVolumeInfo> speakers,
      int speakerNumber, int totalVolume)? onAudioVolumeIndication;

  /// Occurs when a user leaves a channel.
  ///
  /// This callback notifies the app that the user leaves the channel by calling leaveChannel. From this callback, the app can get information such as the call duration and statistics.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [stats] The statistics of the call. See RtcStats.
  final void Function(RtcConnection connection, RtcStats stats)? onLeaveChannel;

  /// Reports the statistics about the current call.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [stats] Statistics of the RTC engine. See RtcStats.
  final void Function(RtcConnection connection, RtcStats stats)? onRtcStats;

  /// Occurs when the audio device state changes.
  ///
  /// This callback notifies the application that the system's audio device state is changed. For example, a headset is unplugged from the device. This method is for Windows and macOS only.
  ///
  /// * [deviceId] The device ID.
  /// * [deviceType] The device type. See MediaDeviceType.
  /// * [deviceState] The device state. See MediaDeviceStateType.
  final void Function(String deviceId, MediaDeviceType deviceType,
      MediaDeviceStateType deviceState)? onAudioDeviceStateChanged;

  /// Reports the playback progress of a music file.
  ///
  /// After you called the startAudioMixing method to play a music file, the SDK triggers this callback every two seconds to report the playback progress.
  ///
  /// * [position] The playback progress (ms).
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  final void Function(int position)? onAudioMixingPositionChanged;

  /// Occurs when the playback of the local music file finishes.
  ///
  /// Deprecated: Use onAudioMixingStateChanged instead. After you call startAudioMixing to play a local music file, this callback occurs when the playback finishes. If the call of startAudioMixing fails, the error code WARN_AUDIO_MIXING_OPEN_ERROR is returned.
  final void Function()? onAudioMixingFinished;

  /// Occurs when the playback of the local music file finishes.
  ///
  /// This callback occurs when the local audio effect file finishes playing.
  ///
  /// * [soundId] The ID of the audio effect. The ID of each audio effect file is unique.
  final void Function(int soundId)? onAudioEffectFinished;

  /// Occurs when the video device state changes.
  ///
  /// This callback reports the change of system video devices, such as being unplugged or removed. On a Windows device with an external camera for video capturing, the video disables once the external camera is unplugged. This callback is for Windows and macOS only.
  ///
  /// * [deviceId] The device ID.
  /// * [deviceType] Media device types. See MediaDeviceType.
  /// * [deviceState] Media device states. See MediaDeviceStateType.
  final void Function(String deviceId, MediaDeviceType deviceType,
      MediaDeviceStateType deviceState)? onVideoDeviceStateChanged;

  /// Reports the last mile network quality of each user in the channel.
  ///
  /// This callback reports the last mile network conditions of each user in the channel. Last mile refers to the connection between the local device and Agora's edge server. The SDK triggers this callback once every two seconds. If a channel includes multiple users, the SDK triggers this callback as many times. txQuality is when the user is not sending a stream; rxQuality is when the user is not receiving a stream.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [remoteUid] The user ID. The network quality of the user with this user ID is reported. If the uid is 0, the local network quality is reported.
  /// * [txQuality] Uplink network quality rating of the user in terms of the transmission bit rate, packet loss rate, average RTT (Round-Trip Time) and jitter of the uplink network. This parameter is a quality rating helping you understand how well the current uplink network conditions can support the selected video encoder configuration. For example, a 1000 Kbps uplink network may be adequate for video frames with a resolution of 640 × 480 and a frame rate of 15 fps in the LIVE_BROADCASTING profile, but might be inadequate for resolutions higher than 1280 × 720. See QualityType.
  /// * [rxQuality] Downlink network quality rating of the user in terms of packet loss rate, average RTT, and jitter of the downlink network. See QualityType.
  final void Function(RtcConnection connection, int remoteUid,
      QualityType txQuality, QualityType rxQuality)? onNetworkQuality;

  /// @nodoc
  final void Function(RtcConnection connection)? onIntraRequestReceived;

  /// Occurs when the uplink network information changes.
  ///
  /// The SDK triggers this callback when the uplink network information changes. This callback only applies to scenarios where you push externally encoded video data in H.264 format to the SDK.
  ///
  /// * [info] The uplink network information. See UplinkNetworkInfo.
  final void Function(UplinkNetworkInfo info)? onUplinkNetworkInfoUpdated;

  /// @nodoc
  final void Function(DownlinkNetworkInfo info)? onDownlinkNetworkInfoUpdated;

  /// Reports the last-mile network quality of the local user.
  ///
  /// This callback reports the last-mile network conditions of the local user before the user joins the channel. Last mile refers to the connection between the local device and Agora's edge server. Before the user joins the channel, this callback is triggered by the SDK once startLastmileProbeTest is called and reports the last-mile network conditions of the local user.
  ///
  /// * [quality] The last-mile network quality. qualityUnknown (0): The quality is unknown. qualityExcellent (1): The quality is excellent. qualityGood (2): The network quality seems excellent, but the bitrate can be slightly lower than excellent. qualityPoor (3): Users can feel the communication is slightly impaired. qualityBad (4): Users cannot communicate smoothly. qualityVbad (5): The quality is so bad that users can barely communicate. qualityDown (6): The network is down, and users cannot communicate at all. See QualityType.
  final void Function(QualityType quality)? onLastmileQuality;

  /// Occurs when the first local video frame is displayed on the local video view.
  ///
  /// The SDK triggers this callback when the first local video frame is displayed on the local video view.
  ///
  /// * [source] The type of the video source. See VideoSourceType.
  /// * [width] The width (px) of the first local video frame.
  /// * [height] The height (px) of the first local video frame.
  /// * [elapsed] The time elapsed (ms) from the local user calling joinChannel to join the channel to when the SDK triggers this callback. If startPreviewWithoutSourceType / startPreview is called before joining the channel, this parameter indicates the time elapsed from calling startPreviewWithoutSourceType or startPreview to when this event occurred.
  final void Function(
          VideoSourceType source, int width, int height, int elapsed)?
      onFirstLocalVideoFrame;

  /// Occurs when the first video frame is published.
  ///
  /// The SDK triggers this callback under one of the following circumstances:
  ///  The local client enables the video module and calls joinChannel to join the channel successfully.
  ///  The local client calls muteLocalVideoStream (true) and muteLocalVideoStream (false) in sequence.
  ///  The local client calls disableVideo and enableVideo in sequence.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [elapsed] Time elapsed (ms) from the local user calling joinChannel until this callback is triggered.
  final void Function(VideoSourceType source, int elapsed)?
      onFirstLocalVideoFramePublished;

  /// Occurs when the first remote video frame is received and decoded.
  ///
  /// The SDK triggers this callback under one of the following circumstances:
  ///  The remote user joins the channel and sends the video stream.
  ///  The remote user stops sending the video stream and re-sends it after 15 seconds. Reasons for such an interruption include:
  ///  The remote user leaves the channel.
  ///  The remote user drops offline.
  ///  The remote user calls disableVideo to disable video.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [remoteUid] The user ID of the remote user sending the video stream.
  /// * [width] The width (px) of the video stream.
  /// * [height] The height (px) of the video stream.
  /// * [elapsed] The time elapsed (ms) from the local user calling joinChannel until the SDK triggers this callback.
  final void Function(RtcConnection connection, int remoteUid, int width,
      int height, int elapsed)? onFirstRemoteVideoDecoded;

  /// Occurs when the video size or rotation of a specified user changes.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [sourceType] The type of the video source. See VideoSourceType.
  /// * [uid] The ID of the user whose video size or rotation changes. (The uid for the local user is 0. The video is the local user's video preview).
  /// * [width] The width (pixels) of the video stream.
  /// * [height] The height (pixels) of the video stream.
  /// * [rotation] The rotation information. The value range is [0,360). On the iOS platform, the parameter value is always 0.
  final void Function(RtcConnection connection, VideoSourceType sourceType,
      int uid, int width, int height, int rotation)? onVideoSizeChanged;

  /// Occurs when the local video stream state changes.
  ///
  /// When the status of the local video changes, the SDK triggers this callback to report the current local video state and the reason for the state change.
  ///
  /// * [source] The type of the video source. See VideoSourceType.
  /// * [state] The state of the local video, see LocalVideoStreamState.
  /// * [reason] The reasons for changes in local video state. See LocalVideoStreamReason.
  final void Function(VideoSourceType source, LocalVideoStreamState state,
      LocalVideoStreamReason reason)? onLocalVideoStateChanged;

  /// Occurs when the remote video stream state changes.
  ///
  /// This callback does not work properly when the number of users (in the communication profile) or hosts (in the live streaming channel) in a channel exceeds 17.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [remoteUid] The ID of the remote user whose video state changes.
  /// * [state] The state of the remote video. See RemoteVideoState.
  /// * [reason] The reason for the remote video state change. See RemoteVideoStateReason.
  /// * [elapsed] Time elapsed (ms) from the local user calling the joinChannel method until the SDK triggers this callback.
  final void Function(
      RtcConnection connection,
      int remoteUid,
      RemoteVideoState state,
      RemoteVideoStateReason reason,
      int elapsed)? onRemoteVideoStateChanged;

  /// Occurs when the renderer receives the first frame of the remote video.
  ///
  /// * [uid] The user ID of the remote user sending the video stream.
  /// * [connection] The connection information. See RtcConnection.
  /// * [width] The width (px) of the video stream.
  /// * [height] The height (px) of the video stream.
  /// * [elapsed] The time elapsed (ms) from the local user calling joinChannel until the SDK triggers this callback.
  final void Function(RtcConnection connection, int remoteUid, int width,
      int height, int elapsed)? onFirstRemoteVideoFrame;

  /// Occurs when a remote user (in the communication profile)/ host (in the live streaming profile) joins the channel.
  ///
  /// In a communication channel, this callback indicates that a remote user joins the channel. The SDK also triggers this callback to report the existing users in the channel when a user joins the channel.
  ///  In a live-broadcast channel, this callback indicates that a host joins the channel. The SDK also triggers this callback to report the existing hosts in the channel when a host joins the channel. Agora recommends limiting the number of hosts to 17. The SDK triggers this callback under one of the following circumstances:
  ///  A remote user/host joins the channel.
  ///  A remote user switches the user role to the host after joining the channel.
  ///  A remote user/host rejoins the channel after a network interruption.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [remoteUid] The ID of the user or host who joins the channel.
  /// * [elapsed] Time delay (ms) from the local user calling joinChannel until this callback is triggered.
  final void Function(RtcConnection connection, int remoteUid, int elapsed)?
      onUserJoined;

  /// Occurs when a remote user (in the communication profile)/ host (in the live streaming profile) leaves the channel.
  ///
  /// There are two reasons for users to become offline:
  ///  Leave the channel: When a user/host leaves the channel, the user/host sends a goodbye message. When this message is received, the SDK determines that the user/host leaves the channel.
  ///  Drop offline: When no data packet of the user or host is received for a certain period of time (20 seconds for the communication profile, and more for the live broadcast profile), the SDK assumes that the user/host drops offline. A poor network connection may lead to false detections. It's recommended to use the Agora RTM SDK for reliable offline detection.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [remoteUid] The ID of the user who leaves the channel or goes offline.
  /// * [reason] Reasons why the user goes offline: UserOfflineReasonType.
  final void Function(RtcConnection connection, int remoteUid,
      UserOfflineReasonType reason)? onUserOffline;

  /// Occurs when a remote user (in the communication profile) or a host (in the live streaming profile) stops/resumes sending the audio stream.
  ///
  /// The SDK triggers this callback when the remote user stops or resumes sending the audio stream by calling the muteLocalAudioStream method. This callback does not work properly when the number of users (in the communication profile) or hosts (in the live streaming channel) in a channel exceeds 17.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [remoteUid] The user ID.
  /// * [muted] Whether the remote user's audio stream is muted: true : User's audio stream is muted. false : User's audio stream is unmuted.
  final void Function(RtcConnection connection, int remoteUid, bool muted)?
      onUserMuteAudio;

  /// Occurs when a remote user stops or resumes publishing the video stream.
  ///
  /// When a remote user calls muteLocalVideoStream to stop or resume publishing the video stream, the SDK triggers this callback to report to the local user the state of the streams published by the remote user. This callback can be inaccurate when the number of users (in the communication profile) or hosts (in the live streaming profile) in a channel exceeds 17.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [remoteUid] The user ID of the remote user.
  /// * [muted] Whether the remote user stops publishing the video stream: true : The remote user stops publishing the video stream. false : The remote user resumes publishing the video stream.
  final void Function(RtcConnection connection, int remoteUid, bool muted)?
      onUserMuteVideo;

  /// Occurs when a remote user enables or disables the video module.
  ///
  /// Once the video module is disabled, the user can only use a voice call. The user cannot send or receive any video. The SDK triggers this callback when a remote user enables or disables the video module by calling the enableVideo or disableVideo method.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [remoteUid] The user ID of the remote user.
  /// * [enabled] true : The video module is enabled. false : The video module is disabled.
  final void Function(RtcConnection connection, int remoteUid, bool enabled)?
      onUserEnableVideo;

  /// @nodoc
  final void Function(RtcConnection connection, int remoteUid, int state)?
      onUserStateChanged;

  /// Occurs when a specific remote user enables/disables the local video capturing function.
  ///
  /// Deprecated: This callback is deprecated, use the following enumerations in the onRemoteVideoStateChanged callback: remoteVideoStateStopped (0) and remoteVideoStateReasonRemoteMuted (5). remoteVideoStateDecoding (2) and remoteVideoStateReasonRemoteUnmuted (6). The SDK triggers this callback when the remote user resumes or stops capturing the video stream by calling the enableLocalVideo method.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [remoteUid] The user ID of the remote user.
  /// * [enabled] Whether the specified remote user enables/disables local video capturing: true : The video module is enabled. Other users in the channel can see the video of this remote user. false : The video module is disabled. Other users in the channel can no longer receive the video stream from this remote user, while this remote user can still receive the video streams from other users.
  final void Function(RtcConnection connection, int remoteUid, bool enabled)?
      onUserEnableLocalVideo;

  /// Reports the transport-layer statistics of each remote audio stream.
  ///
  /// The SDK triggers this callback once every two seconds for each remote user who is sending audio streams. If a channel includes multiple remote users, the SDK triggers this callback as many times.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [stats] The statistics of the received remote audio streams. See RemoteAudioStats.
  final void Function(RtcConnection connection, RemoteAudioStats stats)?
      onRemoteAudioStats;

  /// Reports the statistics of the local audio stream.
  ///
  /// The SDK triggers this callback once every two seconds.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [stats] Local audio statistics. See LocalAudioStats.
  final void Function(RtcConnection connection, LocalAudioStats stats)?
      onLocalAudioStats;

  /// Reports the statistics of the local video stream.
  ///
  /// The SDK triggers this callback once every two seconds to report the statistics of the local video stream.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [stats] The statistics of the local video stream. See LocalVideoStats.
  final void Function(VideoSourceType source, LocalVideoStats stats)?
      onLocalVideoStats;

  /// Reports the statistics of the video stream sent by each remote users.
  ///
  /// Reports the statistics of the video stream from the remote users. The SDK triggers this callback once every two seconds for each remote user. If a channel has multiple users/hosts sending video streams, the SDK triggers this callback as many times.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [stats] Statistics of the remote video stream. See RemoteVideoStats.
  final void Function(RtcConnection connection, RemoteVideoStats stats)?
      onRemoteVideoStats;

  /// Occurs when the camera turns on and is ready to capture the video.
  ///
  /// Deprecated: Use localVideoStreamStateCapturing (1) in onLocalVideoStateChanged instead. This callback indicates that the camera has been successfully turned on and you can start to capture video.
  final void Function()? onCameraReady;

  /// Occurs when the camera focus area changes.
  ///
  /// The SDK triggers this callback when the local user changes the camera focus position by calling setCameraFocusPositionInPreview. This callback is for Android and iOS only.
  ///
  /// * [x] The x-coordinate of the changed camera focus area.
  /// * [y] The y-coordinate of the changed camera focus area.
  /// * [width] The width of the changed camera focus area.
  /// * [height] The height of the changed camera focus area.
  final void Function(int x, int y, int width, int height)?
      onCameraFocusAreaChanged;

  /// Occurs when the camera exposure area changes.
  ///
  /// The SDK triggers this callback when the local user changes the camera exposure position by calling setCameraExposurePosition. This callback is for Android and iOS only.
  final void Function(int x, int y, int width, int height)?
      onCameraExposureAreaChanged;

  /// Reports the face detection result of the local user.
  ///
  /// Once you enable face detection by calling enableFaceDetection (true), you can get the following information on the local user in real-time:
  ///  The width and height of the local video.
  ///  The position of the human face in the local view.
  ///  The distance between the human face and the screen. This value is based on the fitting calculation of the local video size and the position of the human face.
  ///  This callback is for Android and iOS only.
  ///  When it is detected that the face in front of the camera disappears, the callback will be triggered immediately. When no human face is detected, the frequency of this callback to be triggered wil be decreased to reduce power consumption on the local device.
  ///  The SDK stops triggering this callback when a human face is in close proximity to the screen.
  ///  On Android, the value of distance reported in this callback may be slightly different from the actual distance. Therefore, Agora does not recommend using it for accurate calculation.
  ///
  /// * [imageWidth] The width (px) of the video image captured by the local camera.
  /// * [imageHeight] The height (px) of the video image captured by the local camera.
  /// * [vecRectangle] The information of the detected human face. See Rectangle.
  /// * [vecDistance] The distance between the human face and the device screen (cm).
  /// * [numFaces] The number of faces detected. If the value is 0, it means that no human face is detected.
  final void Function(
      int imageWidth,
      int imageHeight,
      List<Rectangle> vecRectangle,
      List<int> vecDistance,
      int numFaces)? onFacePositionChanged;

  /// Occurs when the video stops playing.
  ///
  /// Deprecated: Use localVideoStreamStateStopped (0) in the onLocalVideoStateChanged callback instead. The application can use this callback to change the configuration of the view (for example, displaying other pictures in the view) after the video stops playing.
  final void Function()? onVideoStopped;

  /// Occurs when the playback state of the music file changes.
  ///
  /// This callback occurs when the playback state of the music file changes, and reports the current state and error code.
  ///
  /// * [state] The playback state of the music file. See AudioMixingStateType.
  /// * [reason] Error code. See AudioMixingReasonType.
  final void Function(AudioMixingStateType state, AudioMixingReasonType reason)?
      onAudioMixingStateChanged;

  /// Occurs when the state of virtual metronome changes.
  ///
  /// When the state of the virtual metronome changes, the SDK triggers this callback to report the current state of the virtual metronome. This callback indicates the state of the local audio stream and enables you to troubleshoot issues when audio exceptions occur. This callback is for Android and iOS only.
  ///
  /// * [state] For the current virtual metronome status, see RhythmPlayerStateType.
  /// * [errorCode] For the error codes and error messages related to virtual metronome errors, see RhythmPlayerReason.
  final void Function(RhythmPlayerStateType state, RhythmPlayerReason reason)?
      onRhythmPlayerStateChanged;

  /// Occurs when the SDK cannot reconnect to Agora's edge server 10 seconds after its connection to the server is interrupted.
  ///
  /// The SDK triggers this callback when it cannot connect to the server 10 seconds after calling the joinChannel method, regardless of whether it is in the channel. If the SDK fails to rejoin the channel 20 minutes after being disconnected from Agora's edge server, the SDK stops rejoining the channel.
  ///
  /// * [connection] The connection information. See RtcConnection.
  final void Function(RtcConnection connection)? onConnectionLost;

  /// Occurs when the connection between the SDK and the server is interrupted.
  ///
  /// Deprecated: Use onConnectionStateChanged instead. The SDK triggers this callback when it loses connection with the server for more than four seconds after the connection is established. After triggering this callback, the SDK tries to reconnect to the server. You can use this callback to implement pop-up reminders. The differences between this callback and onConnectionLost are as follow:
  ///  The SDK triggers the onConnectionInterrupted callback when it loses connection with the server for more than four seconds after it successfully joins the channel.
  ///  The SDK triggers the onConnectionLost callback when it loses connection with the server for more than 10 seconds, whether or not it joins the channel. If the SDK fails to rejoin the channel 20 minutes after being disconnected from Agora's edge server, the SDK stops rejoining the channel.
  ///
  /// * [connection] The connection information. See RtcConnection.
  final void Function(RtcConnection connection)? onConnectionInterrupted;

  /// Occurs when the connection is banned by the Agora server.
  ///
  /// Deprecated: Use onConnectionStateChanged instead.
  ///
  /// * [connection] The connection information. See RtcConnection.
  final void Function(RtcConnection connection)? onConnectionBanned;

  /// Occurs when the local user receives the data stream from the remote user.
  ///
  /// The SDK triggers this callback when the local user receives the stream message that the remote user sends by calling the sendStreamMessage method.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [uid] The ID of the remote user sending the message.
  /// * [streamId] The stream ID of the received message.
  /// * [data] The data received.
  /// * [length] The data length (byte).
  /// * [sentTs] The time when the data stream is sent.
  final void Function(RtcConnection connection, int remoteUid, int streamId,
      Uint8List data, int length, int sentTs)? onStreamMessage;

  /// Occurs when the local user does not receive the data stream from the remote user.
  ///
  /// The SDK triggers this callback when the local user fails to receive the stream message that the remote user sends by calling the sendStreamMessage method.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [remoteUid] The ID of the remote user sending the message.
  /// * [streamId] The stream ID of the received message.
  /// * [code] The error code. See ErrorCodeType.
  /// * [missed] The number of lost messages.
  /// * [cached] Number of incoming cached messages when the data stream is interrupted.
  final void Function(RtcConnection connection, int remoteUid, int streamId,
      ErrorCodeType code, int missed, int cached)? onStreamMessageError;

  /// Occurs when the token expires.
  ///
  /// The SDK triggers this callback if the token expires. When receiving this callback, you need to generate a new token on your token server and you can renew your token through one of the following ways:
  ///  In scenarios involving one channel:
  ///  Call renewToken to pass in the new token.
  ///  Call leaveChannel to leave the current channel and then pass in the new token when you call joinChannel to join a channel.
  ///  In scenarios involving mutiple channels: Call updateChannelMediaOptionsEx to pass in the new token.
  ///
  /// * [connection] The connection information. See RtcConnection.
  final void Function(RtcConnection connection)? onRequestToken;

  /// Occurs when the token expires in 30 seconds.
  ///
  /// When receiving this callback, you need to generate a new token on your token server and you can renew your token through one of the following ways:
  ///  In scenarios involving one channel:
  ///  Call renewToken to pass in the new token.
  ///  Call leaveChannel to leave the current channel and then pass in the new token when you call joinChannel to join a channel.
  ///  In scenarios involving mutiple channels: Call updateChannelMediaOptionsEx to pass in the new token.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [token] The token that is about to expire.
  final void Function(RtcConnection connection, String token)?
      onTokenPrivilegeWillExpire;

  /// @nodoc
  final void Function(RtcConnection connection, LicenseErrorType reason)?
      onLicenseValidationFailure;

  /// Occurs when the first audio frame is published.
  ///
  /// The SDK triggers this callback under one of the following circumstances:
  ///  The local client enables the audio module and calls joinChannel successfully.
  ///  The local client calls muteLocalAudioStream (true) and muteLocalAudioStream (false) in sequence.
  ///  The local client calls disableAudio and enableAudio in sequence.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [elapsed] Time elapsed (ms) from the local user calling joinChannel until the SDK triggers this callback.
  final void Function(RtcConnection connection, int elapsed)?
      onFirstLocalAudioFramePublished;

  /// Occurs when the SDK decodes the first remote audio frame for playback.
  ///
  /// Deprecated: Use onRemoteAudioStateChanged instead. The SDK triggers this callback under one of the following circumstances:
  ///  The remote user joins the channel and sends the audio stream for the first time.
  ///  The remote user's audio is offline and then goes online to re-send audio. It means the local user cannot receive audio in 15 seconds. Reasons for such an interruption include:
  ///  The remote user leaves channel.
  ///  The remote user drops offline.
  ///  The remote user calls muteLocalAudioStream to stop sending the audio stream.
  ///  The remote user calls disableAudio to disable audio.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [uid] The user ID of the remote user.
  /// * [elapsed] The time elapsed (ms) from the local user calling joinChannel until the SDK triggers this callback.
  final void Function(RtcConnection connection, int uid, int elapsed)?
      onFirstRemoteAudioDecoded;

  /// Occurs when the SDK receives the first audio frame from a specific remote user.
  ///
  /// Deprecated: Use onRemoteAudioStateChanged instead.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [userId] The user ID of the remote user.
  /// * [elapsed] The time elapsed (ms) from the local user calling joinChannel until the SDK triggers this callback.
  final void Function(RtcConnection connection, int userId, int elapsed)?
      onFirstRemoteAudioFrame;

  /// Occurs when the local audio stream state changes.
  ///
  /// When the state of the local audio stream changes (including the state of the audio capture and encoding), the SDK triggers this callback to report the current state. This callback indicates the state of the local audio stream, and allows you to troubleshoot issues when audio exceptions occur. When the state is localAudioStreamStateFailed (3), you can view the error information in the error parameter.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [state] The state of the local audio. See LocalAudioStreamState.
  /// * [reason] Reasons for local audio state changes. See LocalAudioStreamReason.
  final void Function(RtcConnection connection, LocalAudioStreamState state,
      LocalAudioStreamReason reason)? onLocalAudioStateChanged;

  /// Occurs when the remote audio state changes.
  ///
  /// When the audio state of a remote user (in a voice/video call channel) or host (in a live streaming channel) changes, the SDK triggers this callback to report the current state of the remote audio stream. This callback does not work properly when the number of users (in the communication profile) or hosts (in the live streaming channel) in a channel exceeds 17.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [remoteUid] The ID of the remote user whose audio state changes.
  /// * [state] The state of the remote audio. See RemoteAudioState.
  /// * [reason] The reason of the remote audio state change. See RemoteAudioStateReason.
  /// * [elapsed] Time elapsed (ms) from the local user calling the joinChannel method until the SDK triggers this callback.
  final void Function(
      RtcConnection connection,
      int remoteUid,
      RemoteAudioState state,
      RemoteAudioStateReason reason,
      int elapsed)? onRemoteAudioStateChanged;

  /// Occurs when the most active remote speaker is detected.
  ///
  /// After a successful call of enableAudioVolumeIndication, the SDK continuously detects which remote user has the loudest volume. During the current period, the remote user whose volume is detected as the loudest for the most times, is the most active user. When the number of users is no less than two and an active remote speaker exists, the SDK triggers this callback and reports the uid of the most active remote speaker.
  ///  If the most active remote speaker is always the same user, the SDK triggers the onActiveSpeaker callback only once.
  ///  If the most active remote speaker changes to another user, the SDK triggers this callback again and reports the uid of the new active remote speaker.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [uid] The user ID of the most active speaker.
  final void Function(RtcConnection connection, int uid)? onActiveSpeaker;

  /// @nodoc
  final void Function(ContentInspectResult result)? onContentInspectResult;

  /// Reports the result of taking a video snapshot.
  ///
  /// After a successful takeSnapshot method call, the SDK triggers this callback to report whether the snapshot is successfully taken as well as the details for the snapshot taken.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [uid] The user ID. One uid of 0 indicates the local user.
  /// * [filePath] The local path of the snapshot.
  /// * [width] The width (px) of the snapshot.
  /// * [height] The height (px) of the snapshot.
  /// * [errCode] The message that confirms success or gives the reason why the snapshot is not successfully taken:
  ///  0: Success.
  ///  < 0: Failure:
  ///  -1: The SDK fails to write data to a file or encode a JPEG image.
  ///  -2: The SDK does not find the video stream of the specified user within one second after the takeSnapshot method call succeeds. The possible reasons are: local capture stops, remote end stops publishing, or video data processing is blocked.
  ///  -3: Calling the takeSnapshot method too frequently.
  final void Function(RtcConnection connection, int uid, String filePath,
      int width, int height, int errCode)? onSnapshotTaken;

  /// Occurs when the user role switches during the interactive live streaming.
  ///
  /// The SDK triggers this callback when the local user switches their user role by calling setClientRole after joining the channel.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [oldRole] Role that the user switches from: ClientRoleType.
  /// * [newRole] Role that the user switches to: ClientRoleType.
  /// * [newRoleOptions] Properties of the role that the user switches to. See ClientRoleOptions.
  final void Function(
      RtcConnection connection,
      ClientRoleType oldRole,
      ClientRoleType newRole,
      ClientRoleOptions newRoleOptions)? onClientRoleChanged;

  /// Occurs when the user role switching fails in the interactive live streaming.
  ///
  /// In the live broadcasting channel profile, when the local user calls setClientRole to switch the user role after joining the channel but the switch fails, the SDK triggers this callback to report the reason for the failure and the current user role.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [reason] The reason for a user role switch failure. See ClientRoleChangeFailedReason.
  /// * [currentRole] Current user role. See ClientRoleType.
  final void Function(
      RtcConnection connection,
      ClientRoleChangeFailedReason reason,
      ClientRoleType currentRole)? onClientRoleChangeFailed;

  /// Reports the volume change of the audio device or app.
  ///
  /// Occurs when the volume on the playback device, audio capture device, or the volume of the app changes. This callback is for Windows and macOS only.
  ///
  /// * [deviceType] The device type. See MediaDeviceType.
  /// * [volume] The volume value. The range is [0, 255].
  /// * [muted] Whether the audio device is muted: true : The audio device is muted. false : The audio device is not muted.
  final void Function(MediaDeviceType deviceType, int volume, bool muted)?
      onAudioDeviceVolumeChanged;

  /// Occurs when the state of Media Push changes.
  ///
  /// When the state of Media Push changes, the SDK triggers this callback and reports the URL address and the current state of the Media Push. This callback indicates the state of the Media Push. When exceptions occur, you can troubleshoot issues by referring to the detailed error descriptions in the error code parameter.
  ///
  /// * [url] The URL address where the state of the Media Push changes.
  /// * [state] The current state of the Media Push. See RtmpStreamPublishState.
  /// * [reason] Reasons for the changes in the Media Push status. See RtmpStreamPublishReason.
  final void Function(String url, RtmpStreamPublishState state,
      RtmpStreamPublishReason reason)? onRtmpStreamingStateChanged;

  /// Reports events during the Media Push.
  ///
  /// * [url] The URL for Media Push.
  /// * [eventCode] The event code of Media Push. See RtmpStreamingEvent.
  final void Function(String url, RtmpStreamingEvent eventCode)?
      onRtmpStreamingEvent;

  /// Occurs when the publisher's transcoding is updated.
  ///
  /// When the LiveTranscoding class in the startRtmpStreamWithTranscoding method updates, the SDK triggers the onTranscodingUpdated callback to report the update information. If you call the startRtmpStreamWithTranscoding method to set the LiveTranscoding class for the first time, the SDK does not trigger this callback.
  final void Function()? onTranscodingUpdated;

  /// Occurs when the local audio route changes.
  ///
  /// This method is for Android, iOS and macOS only.
  ///
  /// * [routing] The current audio routing. See AudioRoute.
  final void Function(int routing)? onAudioRoutingChanged;

  /// Occurs when the state of the media stream relay changes.
  ///
  /// The SDK returns the state of the current media relay with any error message.
  ///
  /// * [state] The state code. See ChannelMediaRelayState.
  /// * [code] The error code of the channel media relay. See ChannelMediaRelayError.
  final void Function(
          ChannelMediaRelayState state, ChannelMediaRelayError code)?
      onChannelMediaRelayStateChanged;

  /// @nodoc
  final void Function(bool isFallbackOrRecover)?
      onLocalPublishFallbackToAudioOnly;

  /// Occurs when the remote media stream falls back to the audio-only stream due to poor network conditions or switches back to the video stream after the network conditions improve.
  ///
  /// If you call setRemoteSubscribeFallbackOption and set option to streamFallbackOptionAudioOnly, the SDK triggers this callback in the following situations:
  ///  The downstream network condition is poor, and the subscribed video stream is downgraded to audio-only stream.
  ///  The downstream network condition has improved, and the subscribed stream has been restored to video stream. Once the remote media stream switches to the low-quality video stream due to weak network conditions, you can monitor the stream switch between a high-quality and low-quality stream in the onRemoteVideoStats callback.
  ///
  /// * [uid] The user ID of the remote user.
  /// * [isFallbackOrRecover] true : The subscribed media stream falls back to audio-only due to poor network conditions. false : The subscribed media stream switches back to the video stream after the network conditions improve.
  final void Function(int uid, bool isFallbackOrRecover)?
      onRemoteSubscribeFallbackToAudioOnly;

  /// Reports the transport-layer statistics of each remote audio stream.
  ///
  /// Deprecated: Use onRemoteAudioStats instead. This callback reports the transport-layer statistics, such as the packet loss rate and network time delay after the local user receives an audio packet from a remote user. During a call, when the user receives the audio packet sent by the remote user, the callback is triggered every 2 seconds.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [remoteUid] The ID of the remote user sending the audio streams.
  /// * [delay] The network delay (ms) from the remote user to the receiver.
  /// * [lost] The packet loss rate (%) of the audio packet sent from the remote user to the receiver.
  /// * [rxKBitrate] The bitrate of the received audio (Kbps).
  final void Function(RtcConnection connection, int remoteUid, int delay,
      int lost, int rxKBitRate)? onRemoteAudioTransportStats;

  /// Reports the transport-layer statistics of each remote video stream.
  ///
  /// Deprecated: This callback is deprecated. Use onRemoteVideoStats instead. This callback reports the transport-layer statistics, such as the packet loss rate and network time delay after the local user receives a video packet from a remote user. During a call, when the user receives the video packet sent by the remote user/host, the callback is triggered every 2 seconds.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [remoteUid] The ID of the remote user sending the video packets.
  /// * [delay] The network delay (ms) from the sender to the receiver.
  /// * [lost] The packet loss rate (%) of the video packet sent from the remote user.
  /// * [rxKBitRate] The bitrate of the received video (Kbps).
  final void Function(RtcConnection connection, int remoteUid, int delay,
      int lost, int rxKBitRate)? onRemoteVideoTransportStats;

  /// Occurs when the network connection state changes.
  ///
  /// When the network connection state changes, the SDK triggers this callback and reports the current connection state and the reason for the change.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [state] The current connection state. See ConnectionStateType.
  /// * [reason] The reason for a connection state change. See ConnectionChangedReasonType.
  final void Function(RtcConnection connection, ConnectionStateType state,
      ConnectionChangedReasonType reason)? onConnectionStateChanged;

  /// @nodoc
  final void Function(RtcConnection connection, WlaccMessageReason reason,
      WlaccSuggestAction action, String wlAccMsg)? onWlAccMessage;

  /// @nodoc
  final void Function(RtcConnection connection, WlAccStats currentStats,
      WlAccStats averageStats)? onWlAccStats;

  /// Occurs when the local network type changes.
  ///
  /// This callback occurs when the connection state of the local user changes. You can get the connection state and reason for the state change in this callback. When the network connection is interrupted, this callback indicates whether the interruption is caused by a network type change or poor network conditions.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [type] The type of the local network connection. See NetworkType.
  final void Function(RtcConnection connection, NetworkType type)?
      onNetworkTypeChanged;

  /// Reports the built-in encryption errors.
  ///
  /// When encryption is enabled by calling enableEncryption, the SDK triggers this callback if an error occurs in encryption or decryption on the sender or the receiver side.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [errorType] Details about the error type. See EncryptionErrorType.
  final void Function(RtcConnection connection, EncryptionErrorType errorType)?
      onEncryptionError;

  /// Occurs when the SDK cannot get the device permission.
  ///
  /// When the SDK fails to get the device permission, the SDK triggers this callback to report which device permission cannot be got.
  ///
  /// * [permissionType] The type of the device permission. See PermissionType.
  final void Function(PermissionType permissionType)? onPermissionError;

  /// Occurs when the local user registers a user account.
  ///
  /// After the local user successfully calls registerLocalUserAccount to register the user account or calls joinChannelWithUserAccount to join a channel, the SDK triggers the callback and informs the local user's UID and User Account.
  ///
  /// * [uid] The ID of the local user.
  /// * [userAccount] The user account of the local user.
  final void Function(int uid, String userAccount)? onLocalUserRegistered;

  /// Occurs when the SDK gets the user ID and user account of the remote user.
  ///
  /// After a remote user joins the channel, the SDK gets the UID and user account of the remote user, caches them in a mapping table object, and triggers this callback on the local client.
  ///
  /// * [uid] The user ID of the remote user.
  /// * [info] The UserInfo object that contains the user ID and user account of the remote user. See UserInfo for details.
  final void Function(int uid, UserInfo info)? onUserInfoUpdated;

  /// @nodoc
  final void Function(
          RtcConnection connection, int remoteUid, String remoteUserAccount)?
      onUserAccountUpdated;

  /// Video frame rendering event callback.
  ///
  /// After calling the startMediaRenderingTracing method or joining the channel, the SDK triggers this callback to report the events of video frame rendering and the indicators during the rendering process. Developers can optimize the indicators to improve the efficiency of the first video frame rendering.
  ///
  /// * [connection] The connection information. See RtcConnection.
  /// * [uid] The user ID.
  /// * [currentEvent] The current video frame rendering event. See MediaTraceEvent.
  /// * [tracingInfo] The indicators during the video frame rendering process. Developers need to reduce the value of indicators as much as possible in order to improve the efficiency of the first video frame rendering. See VideoRenderingTracingInfo.
  final void Function(
      RtcConnection connection,
      int uid,
      MediaTraceEvent currentEvent,
      VideoRenderingTracingInfo tracingInfo)? onVideoRenderingTracingResult;

  /// Occurs when there's an error during the local video mixing.
  ///
  /// When you fail to call startLocalVideoTranscoder or updateLocalTranscoderConfiguration, the SDK triggers this callback to report the reason.
  ///
  /// * [stream] The video streams that cannot be mixed during video mixing. See TranscodingVideoStream.
  /// * [error] The reason for local video mixing error. See VideoTranscoderError.
  final void Function(
          TranscodingVideoStream stream, VideoTranscoderError error)?
      onLocalVideoTranscoderError;

  /// @nodoc
  final void Function(RtcConnection connection, String requestId, bool success,
      UploadErrorReason reason)? onUploadLogResult;

  /// Occurs when the audio subscribing state changes.
  ///
  /// * [channel] The channel name.
  /// * [uid] The user ID of the remote user.
  /// * [oldState] The previous subscribing status. See StreamSubscribeState.
  /// * [newState] The current subscribing status. See StreamSubscribeState.
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
  /// * [uid] The user ID of the remote user.
  /// * [oldState] The previous subscribing status. See StreamSubscribeState.
  /// * [newState] The current subscribing status. See StreamSubscribeState.
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
  /// * [oldState] The previous publishing state. See StreamPublishState.
  /// * [newState] The current publishing stat. See StreamPublishState.
  /// * [elapseSinceLastState] The time elapsed (ms) from the previous state to the current state.
  final void Function(
      String channel,
      StreamPublishState oldState,
      StreamPublishState newState,
      int elapseSinceLastState)? onAudioPublishStateChanged;

  /// Occurs when the video publishing state changes.
  ///
  /// * [channel] The channel name.
  /// * [source] The type of the video source. See VideoSourceType.
  /// * [oldState] The previous publishing state. See StreamPublishState.
  /// * [newState] The current publishing stat. See StreamPublishState.
  /// * [elapseSinceLastState] The time elapsed (ms) from the previous state to the current state.
  final void Function(
      VideoSourceType source,
      String channel,
      StreamPublishState oldState,
      StreamPublishState newState,
      int elapseSinceLastState)? onVideoPublishStateChanged;

  /// Occurs when the local user receives a mixed video stream carrying layout information.
  ///
  /// When the local user receives a mixed video stream sent by the video mixing server for the first time, or when there is a change in the layout information of the mixed stream, the SDK triggers this callback, reporting the layout information of each sub-video stream within the mixed video stream. This callback is for Android and iOS only.
  ///
  /// * [connection] The connection information. See RtcConnection.
  ///
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

  /// The event callback of the extension.
  ///
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
  ///
  /// The extension triggers this callback after it is successfully enabled.
  ///
  /// * [provider] The name of the extension provider.
  /// * [extName] The name of the extension.
  final void Function(String provider, String extension)? onExtensionStarted;

  /// Occurs when the extension is disabled.
  ///
  /// The extension triggers this callback after it is successfully destroyed.
  ///
  /// * [extName] The name of the extension.
  /// * [provider] The name of the extension provider.
  final void Function(String provider, String extension)? onExtensionStopped;

  /// Occurs when the extension runs incorrectly.
  ///
  /// In case of extension enabling failure or runtime errors, the extension triggers this callback and reports the error code along with the reasons.
  ///
  /// * [provider] The name of the extension provider.
  /// * [extension] The name of the extension.
  /// * [error] Error code. For details, see the extension documentation provided by the extension provider.
  /// * [message] Reason. For details, see the extension documentation provided by the extension provider.
  final void Function(
          String provider, String extension, int error, String message)?
      onExtensionError;

  /// @nodoc
  final void Function(RtcConnection connection, int code)? onSetRtmFlagResult;
}

/// Video device management methods.
abstract class VideoDeviceManager {
  /// Enumerates the video devices.
  ///
  /// This method is for Windows and macOS only.
  ///
  /// Returns
  /// Success: A VideoDeviceInfo array including all video devices in the system.
  ///  Failure: An empty array.
  Future<List<VideoDeviceInfo>> enumerateVideoDevices();

  /// Specifies the video capture device with the device ID.
  ///
  /// Plugging or unplugging a device does not change its device ID.
  ///  This method is for Windows and macOS only.
  ///
  /// * [deviceIdUTF8] The device ID. You can get the device ID by calling enumerateVideoDevices. The maximum length is MaxDeviceIdLengthType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setDevice(String deviceIdUTF8);

  /// Retrieves the current video capture device.
  ///
  /// This method is for Windows and macOS only.
  ///
  /// Returns
  /// The video capture device.
  Future<String> getDevice();

  /// Gets the number of video formats supported by the specified video capture device.
  ///
  /// This method is for Windows and macOS only. Video capture devices may support multiple video formats, and each format supports different combinations of video frame width, video frame height, and frame rate. You can call this method to get how many video formats the specified video capture device can support, and then call getCapability to get the specific video frame information in the specified video format.
  ///
  /// * [deviceIdUTF8] The ID of the video capture device.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  ≤ 0: Failure.
  Future<int> numberOfCapabilities(String deviceIdUTF8);

  /// Gets the detailed video frame information of the video capture device in the specified video format.
  ///
  /// This method is for Windows and macOS only. After calling numberOfCapabilities to get the number of video formats supported by the video capture device, you can call this method to get the specific video frame information supported by the specified index number.
  ///
  /// * [deviceIdUTF8] The ID of the video capture device.
  /// * [deviceCapabilityNumber] The index number of the video format. If the return value of numberOfCapabilities is i, the value range of this parameter is [0,i).
  ///
  /// Returns
  /// The specific information of the specified video format, including width (px), height (px), and frame rate (fps). See VideoFormat.
  Future<VideoFormat> getCapability(
      {required String deviceIdUTF8, required int deviceCapabilityNumber});

  /// @nodoc
  Future<void> startDeviceTest(int hwnd);

  /// @nodoc
  Future<void> stopDeviceTest();

  /// Releases all the resources occupied by the VideoDeviceManager object.
  ///
  /// This method is for Windows and macOS only.
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
      this.domainLimit,
      this.autoRegisterAgoraExtensions});

  /// The App ID issued by Agora for your project. Only users in apps with the same App ID can join the same channel and communicate with each other. An App ID can only be used to create one RtcEngine instance. To change your App ID, call release to destroy the current RtcEngine instance, and then create a new one.
  @JsonKey(name: 'appId')
  final String? appId;

  /// The channel profile. See ChannelProfileType.
  @JsonKey(name: 'channelProfile')
  final ChannelProfileType? channelProfile;

  /// @nodoc
  @JsonKey(name: 'license')
  final String? license;

  /// The audio scenarios. Under different audio scenarios, the device uses different volume types. See AudioScenarioType.
  @JsonKey(name: 'audioScenario')
  final AudioScenarioType? audioScenario;

  /// The region for connection. This is an advanced feature and applies to scenarios that have regional restrictions. The area codes support bitwise operation.
  @JsonKey(name: 'areaCode')
  final int? areaCode;

  /// The SDK log files are: agorasdk.log, agorasdk.1.log, agorasdk.2.log, agorasdk.3.log, and agorasdk.4.log.
  ///  The API call log files are: agoraapi.log, agoraapi.1.log, agoraapi.2.log, agoraapi.3.log, and agoraapi.4.log.
  ///  The default size of each SDK log file and API log file is 2,048 KB. These log files are encoded in UTF-8.
  ///  The SDK writes the latest logs in agorasdk.log or agoraapi.log.
  ///  When agorasdk.log is full, the SDK processes the log files in the following order:
  ///  Delete the agorasdk.4.log file (if any).
  ///  Rename agorasdk.3.log to agorasdk.4.log.
  ///  Rename agorasdk.2.log to agorasdk.3.log.
  ///  Rename agorasdk.1.log to agorasdk.2.log.
  ///  Create a new agorasdk.log file.
  ///  The overwrite rules for the agoraapi.log file are the same as for agorasdk.log. Sets the log file size. See LogConfig. By default, the SDK generates five SDK log files and five API call log files with the following rules:
  @JsonKey(name: 'logConfig')
  final LogConfig? logConfig;

  /// @nodoc
  @JsonKey(name: 'threadPriority')
  final ThreadPriorityType? threadPriority;

  /// @nodoc
  @JsonKey(name: 'useExternalEglContext')
  final bool? useExternalEglContext;

  /// Whether to enable domain name restriction: true : Enables the domain name restriction. This value is suitable for scenarios where IoT devices use IoT cards for network access. The SDK will only connect to servers in the domain name or IP whitelist that has been reported to the operator. false : (Default) Disables the domain name restriction. This value is suitable for most common scenarios.
  @JsonKey(name: 'domainLimit')
  final bool? domainLimit;

  /// Whether to automatically register the Agora extensions when initializing RtcEngine : true : (Default) Automatically register the Agora extensions when initializing RtcEngine. false : Do not register the Agora extensions when initializing RtcEngine. You need to call enableExtension to register the Agora extensions.
  @JsonKey(name: 'autoRegisterAgoraExtensions')
  final bool? autoRegisterAgoraExtensions;

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
  /// * [metadata] The metadata received. See Metadata.
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

  /// The user ID.
  ///  For the recipient: The ID of the remote user who sent the Metadata.
  ///  For the sender: Ignore it.
  @JsonKey(name: 'uid')
  final int? uid;

  /// The buffer size of the sent or received Metadata.
  @JsonKey(name: 'size')
  final int? size;

  /// The buffer address of the sent or received Metadata.
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

/// Reasons for the changes in CDN streaming status.
@JsonEnum(alwaysCreate: true)
enum DirectCdnStreamingReason {
  /// 0: No error.
  @JsonValue(0)
  directCdnStreamingReasonOk,

  /// 1: A general error; no specific reason. You can try to push the media stream again.
  @JsonValue(1)
  directCdnStreamingReasonFailed,

  /// 2: An error occurs when pushing audio streams. For example, the local audio capture device is not working properly, is occupied by another process, or does not get the permission required.
  @JsonValue(2)
  directCdnStreamingReasonAudioPublication,

  /// 3: An error occurs when pushing video streams. For example, the local video capture device is not working properly, is occupied by another process, or does not get the permission required.
  @JsonValue(3)
  directCdnStreamingReasonVideoPublication,

  /// 4: Fails to connect to the CDN.
  @JsonValue(4)
  directCdnStreamingReasonNetConnect,

  /// 5: The URL is already being used. Use a new URL for streaming.
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

/// The current CDN streaming state.
@JsonEnum(alwaysCreate: true)
enum DirectCdnStreamingState {
  /// 0: The initial state before the CDN streaming starts.
  @JsonValue(0)
  directCdnStreamingStateIdle,

  /// 1: Streams are being pushed to the CDN. The SDK returns this value when you call the startDirectCdnStreaming method to push streams to the CDN.
  @JsonValue(1)
  directCdnStreamingStateRunning,

  /// 2: Stops pushing streams to the CDN. The SDK returns this value when you call the stopDirectCdnStreaming method to stop pushing streams to the CDN.
  @JsonValue(2)
  directCdnStreamingStateStopped,

  /// 3: Fails to push streams to the CDN. You can troubleshoot the issue with the information reported by the onDirectCdnStreamingStateChanged callback, and then push streams to the CDN again.
  @JsonValue(3)
  directCdnStreamingStateFailed,

  /// 4: Tries to reconnect the Agora server to the CDN. The SDK attempts to reconnect a maximum of 10 times; if the connection is not restored, the streaming state becomes directCdnStreamingStateFailed.
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

/// The statistics of the current CDN streaming.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class DirectCdnStreamingStats {
  /// @nodoc
  const DirectCdnStreamingStats(
      {this.videoWidth,
      this.videoHeight,
      this.fps,
      this.videoBitrate,
      this.audioBitrate});

  /// The width (px) of the video frame.
  @JsonKey(name: 'videoWidth')
  final int? videoWidth;

  /// The height (px) of the video frame.
  @JsonKey(name: 'videoHeight')
  final int? videoHeight;

  /// The frame rate (fps) of the current video frame.
  @JsonKey(name: 'fps')
  final int? fps;

  /// The bitrate (bps) of the current video frame.
  @JsonKey(name: 'videoBitrate')
  final int? videoBitrate;

  /// The bitrate (bps) of the current audio frame.
  @JsonKey(name: 'audioBitrate')
  final int? audioBitrate;

  /// @nodoc
  factory DirectCdnStreamingStats.fromJson(Map<String, dynamic> json) =>
      _$DirectCdnStreamingStatsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$DirectCdnStreamingStatsToJson(this);
}

/// The DirectCdnStreamingEventHandler interface class is used by the SDK to send event notifications of CDN streaming to your app. Your app can get those notifications through methods that inherit this interface class.
class DirectCdnStreamingEventHandler {
  /// @nodoc
  const DirectCdnStreamingEventHandler({
    this.onDirectCdnStreamingStateChanged,
    this.onDirectCdnStreamingStats,
  });

  /// Occurs when the CDN streaming state changes.
  ///
  /// When the host directly pushes streams to the CDN, if the streaming state changes, the SDK triggers this callback to report the changed streaming state, error codes, and other information. You can troubleshoot issues by referring to this callback.
  ///
  /// * [state] The current CDN streaming state. See DirectCdnStreamingState.
  /// * [reason] Reasons for changes in the status of CDN streaming. See DirectCdnStreamingReason.
  /// * [message] The information about the changed streaming state.
  final void Function(
      DirectCdnStreamingState state,
      DirectCdnStreamingReason reason,
      String message)? onDirectCdnStreamingStateChanged;

  /// Reports the CDN streaming statistics.
  ///
  /// When the host directly pushes media streams to the CDN, the SDK triggers this callback every one second.
  ///
  /// * [stats] The statistics of the current CDN streaming. See DirectCdnStreamingStats.
  final void Function(DirectCdnStreamingStats stats)? onDirectCdnStreamingStats;
}

/// The media setting options for the host.
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

  /// Sets whether to publish the video captured by the camera: true : Publish the video captured by the camera. false : (Default) Do not publish the video captured by the camera.
  @JsonKey(name: 'publishCameraTrack')
  final bool? publishCameraTrack;

  /// Sets whether to publish the audio captured by the microphone: true : Publish the audio captured by the microphone. false : (Default) Do not publish the audio captured by the microphone.
  @JsonKey(name: 'publishMicrophoneTrack')
  final bool? publishMicrophoneTrack;

  /// Sets whether to publish the captured audio from a custom source: true : Publish the captured audio from a custom source. false : (Default) Do not publish the captured audio from the custom source.
  @JsonKey(name: 'publishCustomAudioTrack')
  final bool? publishCustomAudioTrack;

  /// Sets whether to publish the captured video from a custom source: true : Publish the captured video from a custom source. false : (Default) Do not publish the captured video from the custom source.
  @JsonKey(name: 'publishCustomVideoTrack')
  final bool? publishCustomVideoTrack;

  /// @nodoc
  @JsonKey(name: 'publishMediaPlayerAudioTrack')
  final bool? publishMediaPlayerAudioTrack;

  /// @nodoc
  @JsonKey(name: 'publishMediaPlayerId')
  final int? publishMediaPlayerId;

  /// The video track ID returned by calling the createCustomVideoTrack method. The default value is 0.
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
///
/// RtcEngine provides the main methods that your app can call. Before calling other APIs, you must call createAgoraRtcEngine to create an RtcEngine object.
abstract class RtcEngine {
  /// Initializes RtcEngine.
  ///
  /// All called methods provided by the RtcEngine class are executed asynchronously. Agora recommends calling these methods in the same thread.
  ///  Before calling other APIs, you must call createAgoraRtcEngine and initialize to create and initialize the RtcEngine object.
  ///  The SDK supports creating only one RtcEngine instance for an app.
  ///
  /// * [context] Configurations for the RtcEngine instance. See RtcEngineContext.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: Failure.
  ///  -1: A general error occurs (no specified reason).
  ///  -2: The parameter is invalid.
  ///  -7: The SDK is not initialized.
  ///  -22: The resource request failed. The SDK fails to allocate resources because your app consumes too much system resource or the system resources are insufficient.
  ///  -101: The App ID is invalid.
  Future<void> initialize(RtcEngineContext context);

  /// Gets the SDK version.
  ///
  /// Returns
  /// One SDKBuildInfo object.
  Future<SDKBuildInfo> getVersion();

  /// Gets the warning or error description.
  ///
  /// * [code] The error code or warning code reported by the SDK.
  ///
  /// Returns
  /// The specific error or warning description.
  Future<String> getErrorDescription(int code);

  /// Queries the video codec capabilities of the SDK.
  ///
  /// * [size] The size of CodecCapInfo.
  ///
  /// Returns
  /// One CodecCapInfo array indicating the video encoding capability of the device, if the method call succeeds.
  ///  If the call timeouts, please modify the call logic and do not invoke the method in the main thread.
  Future<List<CodecCapInfo>> queryCodecCapability(int size);

  /// Queries device score.
  ///
  /// Returns
  /// When the method call succeeds, it returns a value in the range of [0,100], indicating the current device's score. The larger the value, the stronger the device capability. Most devices are rated between 60 and 100. When the method call fails, the AgoraRtcException exception is thrown; and you need to catch the exception and handle it accordingly.
  ///  < 0: Failure.
  Future<int> queryDeviceScore();

  /// Preloads a channel with token, channelId, and uid.
  ///
  /// When audience members need to switch between different channels frequently, calling the method can help shortening the time of joining a channel, thus reducing the time it takes for audience members to hear and see the host. If you join a preloaded channel, leave it and want to rejoin the same channel, you do not need to call this method unless the token for preloading the channel expires. Failing to preload a channel does not mean that you can't join a channel, nor will it increase the time of joining a channel.
  ///
  /// * [token] The token generated on your server for authentication. When the token for preloading channels expires, you can update the token based on the number of channels you preload.
  ///  When preloading one channel, calling this method to pass in the new token.
  ///  When preloading more than one channels:
  ///  If you use a wildcard token for all preloaded channels, call updatePreloadChannelToken to update the token. When generating a wildcard token, ensure the user ID is not set as 0.
  ///  If you use different tokens to preload different channels, call this method to pass in your user ID, channel name and the new token.
  /// * [channelId] The channel name that you want to preload. This parameter signifies the channel in which users engage in real-time audio and video interaction. Under the premise of the same App ID, users who fill in the same channel ID enter the same channel for audio and video interaction. The string length must be less than 64 bytes. Supported characters (89 characters in total):
  ///  All lowercase English letters: a to z.
  ///  All uppercase English letters: A to Z.
  ///  All numeric characters: 0 to 9.
  ///  Space
  ///  "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","
  /// * [uid] The user ID. This parameter is used to identify the user in the channel for real-time audio and video interaction. You need to set and manage user IDs yourself, and ensure that each user ID in the same channel is unique. This parameter is a 32-bit unsigned integer. The value range is 1 to 2 32 -1. If the user ID is not assigned (or set to 0), the SDK assigns a random user ID and onJoinChannelSuccess returns it in the callback. Your application must record and maintain the returned user ID, because the SDK does not do so.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: Failure.
  ///  -7: The RtcEngine object has not been initialized. You need to initialize the RtcEngine object before calling this method.
  ///  -102: The channel name is invalid. You need to pass in a valid channel name and join the channel again.
  Future<void> preloadChannel(
      {required String token, required String channelId, required int uid});

  /// @nodoc
  Future<void> preloadChannelWithUserAccount(
      {required String token,
      required String channelId,
      required String userAccount});

  /// Updates the wildcard token for preloading channels.
  ///
  /// You need to maintain the life cycle of the wildcard token by yourself. When the token expires, you need to generate a new wildcard token and then call this method to pass in the new token.
  ///
  /// * [token] The new token.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> updatePreloadChannelToken(String token);

  /// Joins a channel with media options.
  ///
  /// This method enables users to join a channel. Users in the same channel can talk to each other, and multiple users in the same channel can start a group chat. Users with different App IDs cannot call each other. A successful call of this method triggers the following callbacks:
  ///  The local client: The onJoinChannelSuccess and onConnectionStateChanged callbacks.
  ///  The remote client: onUserJoined, if the user joining the channel is in the Communication profile or is a host in the Live-broadcasting profile. When the connection between the client and Agora's server is interrupted due to poor network conditions, the SDK tries reconnecting to the server. When the local client successfully rejoins the channel, the SDK triggers the onRejoinChannelSuccess callback on the local client.
  ///  This method allows users to join only one channel at a time.
  ///  Ensure that the app ID you use to generate the token is the same app ID that you pass in the initialize method; otherwise, you may fail to join the channel by token.
  ///  If you choose the Testing Mode (using an App ID for authentication) for your project and call this method to join a channel, you will automatically exit the channel after 24 hours.
  ///
  /// * [token] The token generated on your server for authentication. If you need to join different channels at the same time or switch between channels, Agora recommends using a wildcard token so that you don't need to apply for a new token every time joining a channel.
  /// * [channelId] The channel name. This parameter signifies the channel in which users engage in real-time audio and video interaction. Under the premise of the same App ID, users who fill in the same channel ID enter the same channel for audio and video interaction. The string length must be less than 64 bytes. Supported characters (89 characters in total):
  ///  All lowercase English letters: a to z.
  ///  All uppercase English letters: A to Z.
  ///  All numeric characters: 0 to 9.
  ///  Space
  ///  "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","
  /// * [uid] The user ID. This parameter is used to identify the user in the channel for real-time audio and video interaction. You need to set and manage user IDs yourself, and ensure that each user ID in the same channel is unique. This parameter is a 32-bit unsigned integer. The value range is 1 to 2 32 -1. If the user ID is not assigned (or set to 0), the SDK assigns a random user ID and onJoinChannelSuccess returns it in the callback. Your application must record and maintain the returned user ID, because the SDK does not do so.
  /// * [options] The channel media options. See ChannelMediaOptions.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: Failure.
  ///  -2: The parameter is invalid. For example, the token is invalid, the uid parameter is not set to an integer, or the value of a member in ChannelMediaOptions is invalid. You need to pass in a valid parameter and join the channel again.
  ///  -3: Failes to initialize the RtcEngine object. You need to reinitialize the RtcEngine object.
  ///  -7: The RtcEngine object has not been initialized. You need to initialize the RtcEngine object before calling this method.
  ///  -8: The internal state of the RtcEngine object is wrong. The typical cause is that you call this method to join the channel without calling startEchoTest to stop the test after calling stopEchoTest to start a call loop test. You need to call stopEchoTest before calling this method.
  ///  -17: The request to join the channel is rejected. The typical cause is that the user is in the channel. Agora recommends that you use the onConnectionStateChanged callback to determine whether the user exists in the channel. Do not call this method to join the channel unless you receive the connectionStateDisconnected (1) state.
  ///  -102: The channel name is invalid. You need to pass in a valid channelname in channelId to rejoin the channel.
  ///  -121: The user ID is invalid. You need to pass in a valid user ID in uid to rejoin the channel.
  Future<void> joinChannel(
      {required String token,
      required String channelId,
      required int uid,
      required ChannelMediaOptions options});

  /// Updates the channel media options after joining the channel.
  ///
  /// * [options] The channel media options. See ChannelMediaOptions.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> updateChannelMediaOptions(ChannelMediaOptions options);

  /// Sets channel options and leaves the channel.
  ///
  /// If you call release immediately after calling this method, the SDK does not trigger the onLeaveChannel callback.
  ///  If you have called joinChannelEx to join multiple channels, calling this method will leave the channels when calling joinChannel and joinChannelEx at the same time. This method will release all resources related to the session, leave the channel, that is, hang up or exit the call. This method can be called whether or not a call is currently in progress. After joining the channel, you must call this method or to end the call, otherwise, the next call cannot be started. This method call is asynchronous. When this method returns, it does not necessarily mean that the user has left the channel. After actually leaving the channel, the local user triggers the onLeaveChannel callback; after the user in the communication scenario and the host in the live streaming scenario leave the channel, the remote user triggers the onUserOffline callback.
  ///
  /// * [options] The options for leaving the channel. See LeaveChannelOptions.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> leaveChannel({LeaveChannelOptions? options});

  /// Renews the token.
  ///
  /// You can call this method to pass a new token to the SDK. A token will expire after a certain period of time, at which point the SDK will be unable to establish a connection with the server.
  ///
  /// * [token] The new token.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> renewToken(String token);

  /// Sets the channel profile.
  ///
  /// After initializing the SDK, the default channel profile is the live streaming profile. You can call this method to set the channel profile. The Agora SDK differentiates channel profiles and applies optimization algorithms accordingly. For example, it prioritizes smoothness and low latency for a video call and prioritizes video quality for interactive live video streaming.
  ///  To ensure the quality of real-time communication, Agora recommends that all users in a channel use the same channel profile.
  ///  This method must be called and set before joinChannel, and cannot be set again after joining the channel.
  ///
  /// * [profile] The channel profile. See ChannelProfileType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: Failure.
  ///  -2: The parameter is invalid.
  ///  -7: The SDK is not initialized.
  Future<void> setChannelProfile(ChannelProfileType profile);

  /// Sets the user role and level in an interactive live streaming channel.
  ///
  /// In the interactive live streaming profile, the SDK sets the user role as audience by default. You can call this method to set the user role as host. You can call this method either before or after joining a channel. If you call this method to set the user's role as the host before joining the channel and set the local video property through the setupLocalVideo method, the local video preview is automatically enabled when the user joins the channel. If you call this method to switch the user role after joining a channel, the SDK automatically does the following:
  ///  Calls muteLocalAudioStream and muteLocalVideoStream to change the publishing state.
  ///  Triggers onClientRoleChanged on the local client.
  ///  Triggers onUserJoined or onUserOffline on the remote client. This method applies to the interactive live streaming profile (the profile parameter of setChannelProfile is set as channelProfileLiveBroadcasting) only.
  ///
  /// * [role] The user role in the interactive live streaming. See ClientRoleType.
  /// * [options] The detailed options of a user, including the user level. See ClientRoleOptions.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setClientRole(
      {required ClientRoleType role, ClientRoleOptions? options});

  /// Starts an audio device loopback test.
  ///
  /// To test whether the user's local sending and receiving streams are normal, you can call this method to perform an audio and video call loop test, which tests whether the audio and video devices and the user's upstream and downstream networks are working properly. After starting the test, the user needs to make a sound or face the camera. The audio or video is output after about two seconds. If the audio playback is normal, the audio device and the user's upstream and downstream networks are working properly; if the video playback is normal, the video device and the user's upstream and downstream networks are working properly.
  ///  You can call this method either before or after joining a channel. When calling in a channel, make sure that no audio or video stream is being published.
  ///  After calling this method, call stopEchoTest to end the test; otherwise, the user cannot perform the next audio and video call loop test and cannot join the channel.
  ///  In live streaming scenarios, this method only applies to hosts.
  ///
  /// * [config] The configuration of the audio and video call loop test. See EchoTestConfiguration.
  ///
  /// Returns
  /// 0: Success.
  ///  < 0: Failure.
  Future<void> startEchoTest(EchoTestConfiguration config);

  /// Stops the audio call test.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> stopEchoTest();

  /// Enables or disables multi-camera capture.
  ///
  /// In scenarios where there are existing cameras to capture video, Agora recommends that you use the following steps to capture and publish video with multiple cameras:
  ///  Call this method to enable multi-channel camera capture.
  ///  Call startPreview to start the local video preview.
  ///  Call startCameraCapture, and set sourceType to start video capture with the second camera.
  ///  Call joinChannelEx, and set publishSecondaryCameraTrack to true to publish the video stream captured by the second camera in the channel. If you want to disable multi-channel camera capture, use the following steps:
  ///  Call stopCameraCapture.
  ///  Call this method with enabled set to false. You can call this method before and after startPreview to enable multi-camera capture:
  ///  If it is enabled before startPreview, the local video preview shows the image captured by the two cameras at the same time.
  ///  If it is enabled after startPreview, the SDK stops the current camera capture first, and then enables the primary camera and the second camera. The local video preview appears black for a short time, and then automatically returns to normal. This method applies to iOS only. When using this function, ensure that the system version is 13.0 or later. The minimum iOS device types that support multi-camera capture are as follows:
  ///  iPhone XR
  ///  iPhone XS
  ///  iPhone XS Max
  ///  iPad Pro 3rd generation and later
  ///
  /// * [enabled] Whether to enable multi-camera video capture mode: true : Enable multi-camera capture mode; the SDK uses multiple cameras to capture video. false : Disable multi-camera capture mode; the SDK uses a single camera to capture video.
  /// * [config] Capture configuration for the second camera. See CameraCapturerConfiguration.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> enableMultiCamera(
      {required bool enabled, required CameraCapturerConfiguration config});

  /// Enables the video module.
  ///
  /// The video module is disabled by default, call this method to enable it. If you need to disable the video module later, you need to call disableVideo.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> enableVideo();

  /// Disables the video module.
  ///
  /// This method is used to disable the video module.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> disableVideo();

  /// Enables the local video preview and specifies the video source for the preview.
  ///
  /// This method is used to start local video preview and specify the video source that appears in the preview screen.
  ///
  /// * [sourceType] The type of the video source. See VideoSourceType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> startPreview(
      {VideoSourceType sourceType = VideoSourceType.videoSourceCameraPrimary});

  /// Stops the local video preview.
  ///
  /// * [sourceType] The type of the video source. See VideoSourceType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: Failure.
  Future<void> stopPreview(
      {VideoSourceType sourceType = VideoSourceType.videoSourceCameraPrimary});

  /// Starts the last mile network probe test.
  ///
  /// This method starts the last-mile network probe test before joining a channel to get the uplink and downlink last mile network statistics, including the bandwidth, packet loss, jitter, and round-trip time (RTT). Once this method is enabled, the SDK returns the following callbacks: onLastmileQuality : The SDK triggers this callback within two seconds depending on the network conditions. This callback rates the network conditions and is more closely linked to the user experience. onLastmileProbeResult : The SDK triggers this callback within 30 seconds depending on the network conditions. This callback returns the real-time statistics of the network conditions and is more objective. This method must be called before joining the channel, and is used to judge and predict whether the current uplink network quality is good enough.
  ///  Do not call other methods before receiving the onLastmileQuality and onLastmileProbeResult callbacks. Otherwise, the callbacks may be interrupted.
  ///  A host should not call this method after joining a channel (when in a call).
  ///
  /// * [config] The configurations of the last-mile network probe test. See LastmileProbeConfig.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> startLastmileProbeTest(LastmileProbeConfig config);

  /// Stops the last mile network probe test.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> stopLastmileProbeTest();

  /// Sets the video encoder configuration.
  ///
  /// Sets the encoder configuration for the local video. Each configuration profile corresponds to a set of video parameters, including the resolution, frame rate, and bitrate.
  ///
  /// * [config] Video profile. See VideoEncoderConfiguration.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setVideoEncoderConfiguration(VideoEncoderConfiguration config);

  /// Sets the image enhancement options.
  ///
  /// Enables or disables image enhancement, and sets the options.
  ///  Call this method after calling enableVideo or startPreview.
  ///  This method relies on the image enhancement dynamic library libagora_clear_vision_extension.dll. If the dynamic library is deleted, the function cannot be enabled normally.
  ///  This feature has high requirements on device performance. When calling this method, the SDK automatically checks the capabilities of the current device.
  ///
  /// * [enabled] Whether to enable the image enhancement function: true : Enable the image enhancement function. false : (Default) Disable the image enhancement function.
  /// * [options] The image enhancement options. See BeautyOptions.
  /// * [type] Source type of the extension. See MediaSourceType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setBeautyEffectOptions(
      {required bool enabled,
      required BeautyOptions options,
      MediaSourceType type = MediaSourceType.primaryCameraSource});

  /// Sets low-light enhancement.
  ///
  /// The low-light enhancement feature can adaptively adjust the brightness value of the video captured in situations with low or uneven lighting, such as backlit, cloudy, or dark scenes. It restores or highlights the image details and improves the overall visual effect of the video. You can call this method to enable the color enhancement feature and set the options of the color enhancement effect.
  ///  Call this method after calling enableVideo.
  ///  Dark light enhancement has certain requirements for equipment performance. The low-light enhancement feature has certain performance requirements on devices. If your device overheats after you enable low-light enhancement, Agora recommends modifying the low-light enhancement options to a less performance-consuming level or disabling low-light enhancement entirely.
  ///  Both this method and setExtensionProperty can turn on low-light enhancement:
  ///  When you use the SDK to capture video, Agora recommends this method (this method only works for video captured by the SDK).
  ///  When you use an external video source to implement custom video capture, or send an external video source to the SDK, Agora recommends using setExtensionProperty.
  ///  This method relies on the image enhancement dynamic library libagora_clear_vision_extension.dll. If the dynamic library is deleted, the function cannot be enabled normally.
  ///
  /// * [enabled] Whether to enable low-light enhancement: true : Enable low-light enhancement. false : (Default) Disable low-light enhancement.
  /// * [options] The low-light enhancement options. See LowlightEnhanceOptions.
  /// * [type] The type of the video source. See MediaSourceType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setLowlightEnhanceOptions(
      {required bool enabled,
      required LowlightEnhanceOptions options,
      MediaSourceType type = MediaSourceType.primaryCameraSource});

  /// Sets video noise reduction.
  ///
  /// Underlit environments and low-end video capture devices can cause video images to contain significant noise, which affects video quality. In real-time interactive scenarios, video noise also consumes bitstream resources and reduces encoding efficiency during encoding. You can call this method to enable the video noise reduction feature and set the options of the video noise reduction effect.
  ///  Call this method after calling enableVideo.
  ///  Video noise reduction has certain requirements for equipment performance. If your device overheats after you enable video noise reduction, Agora recommends modifying the video noise reduction options to a less performance-consuming level or disabling video noise reduction entirely.
  ///  Both this method and setExtensionProperty can turn on video noise reduction function:
  ///  When you use the SDK to capture video, Agora recommends this method (this method only works for video captured by the SDK).
  ///  When you use an external video source to implement custom video capture, or send an external video source to the SDK, Agora recommends using setExtensionProperty.
  ///  This method relies on the image enhancement dynamic library libagora_clear_vision_extension.dll. If the dynamic library is deleted, the function cannot be enabled normally.
  ///
  /// * [enabled] Whether to enable video noise reduction: true : Enable video noise reduction. false : (Default) Disable video noise reduction.
  /// * [options] The video noise reduction options. See VideoDenoiserOptions.
  /// * [type] The type of the video source. See MediaSourceType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setVideoDenoiserOptions(
      {required bool enabled,
      required VideoDenoiserOptions options,
      MediaSourceType type = MediaSourceType.primaryCameraSource});

  /// Sets color enhancement.
  ///
  /// The video images captured by the camera can have color distortion. The color enhancement feature intelligently adjusts video characteristics such as saturation and contrast to enhance the video color richness and color reproduction, making the video more vivid. You can call this method to enable the color enhancement feature and set the options of the color enhancement effect.
  ///  Call this method after calling enableVideo.
  ///  The color enhancement feature has certain performance requirements on devices. With color enhancement turned on, Agora recommends that you change the color enhancement level to one that consumes less performance or turn off color enhancement if your device is experiencing severe heat problems.
  ///  Both this method and setExtensionProperty can enable color enhancement:
  ///  When you use the SDK to capture video, Agora recommends this method (this method only works for video captured by the SDK).
  ///  When you use an external video source to implement custom video capture, or send an external video source to the SDK, Agora recommends using setExtensionProperty.
  ///  This method relies on the image enhancement dynamic library libagora_clear_vision_extension.dll. If the dynamic library is deleted, the function cannot be enabled normally.
  ///
  /// * [enabled] Whether to enable color enhancement: true Enable color enhancement. false : (Default) Disable color enhancement.
  /// * [options] The color enhancement options. See ColorEnhanceOptions.
  /// * [type] The type of the video source. See MediaSourceType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setColorEnhanceOptions(
      {required bool enabled,
      required ColorEnhanceOptions options,
      MediaSourceType type = MediaSourceType.primaryCameraSource});

  /// Enables/Disables the virtual background.
  ///
  /// The virtual background feature enables the local user to replace their original background with a static image, dynamic video, blurred background, or portrait-background segmentation to achieve picture-in-picture effect. Once the virtual background feature is enabled, all users in the channel can see the custom background. Call this method after calling enableVideo or startPreview.
  ///  This feature has high requirements on device performance. When calling this method, the SDK automatically checks the capabilities of the current device. Agora recommends you use virtual background on devices with the following processors:
  ///  Snapdragon 700 series 750G and later
  ///  Snapdragon 800 series 835 and later
  ///  Dimensity 700 series 720 and later
  ///  Kirin 800 series 810 and later
  ///  Kirin 900 series 980 and later
  ///  Devices with an A9 chip and better, as follows:
  ///  iPhone 6S and later
  ///  iPad Air 3rd generation and later
  ///  iPad 5th generation and later
  ///  iPad Pro 1st generation and later
  ///  iPad mini 5th generation and later
  ///  Agora recommends that you use this feature in scenarios that meet the following conditions:
  ///  A high-definition camera device is used, and the environment is uniformly lit.
  ///  There are few objects in the captured video. Portraits are half-length and unobstructed. Ensure that the background is a solid color that is different from the color of the user's clothing.
  ///  This method relies on the virtual background dynamic library libagora_segmentation_extension.dll. If the dynamic library is deleted, the function cannot be enabled normally.
  ///
  /// * [enabled] Whether to enable virtual background: true : Enable virtual background. false : Disable virtual background.
  /// * [backgroundSource] The custom background. See VirtualBackgroundSource. To adapt the resolution of the custom background image to that of the video captured by the SDK, the SDK scales and crops the custom background image while ensuring that the content of the custom background image is not distorted.
  /// * [segproperty] Processing properties for background images. See SegmentationProperty.
  /// * [type] The type of the video source. See MediaSourceType. In this method, this parameter supports only the following two settings:
  ///  The default value is primaryCameraSource.
  ///  If you want to use the second camera to capture video, set this parameter to secondaryCameraSource.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> enableVirtualBackground(
      {required bool enabled,
      required VirtualBackgroundSource backgroundSource,
      required SegmentationProperty segproperty,
      MediaSourceType type = MediaSourceType.primaryCameraSource});

  /// Initializes the video view of a remote user.
  ///
  /// This method initializes the video view of a remote stream on the local device. It affects only the video view that the local user sees. Call this method to bind the remote video stream to a video view and to set the rendering and mirror modes of the video view. You need to specify the ID of the remote user in this method. If the remote user ID is unknown to the application, set it after the app receives the onUserJoined callback. To unbind the remote user from the view, set the view parameter to NULL. Once the remote user leaves the channel, the SDK unbinds the remote user. In the scenarios of custom layout for mixed videos on the mobile end, you can call this method and set a separate view for rendering each sub-video stream of the mixed video stream.
  ///  To update the rendering or mirror mode of the remote video view during a call, use the setRemoteRenderMode method.
  ///  If you use the Agora recording function, the recording client joins the channel as a placeholder client, triggering the onUserJoined callback. Do not bind the placeholder client to the app view because the placeholder client does not send any video streams. If your app does not recognize the placeholder client, bind the remote user to the view when the SDK triggers the onFirstRemoteVideoDecoded callback.
  ///
  /// * [canvas] The remote video view and settings. See VideoCanvas.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: Failure.
  Future<void> setupRemoteVideo(VideoCanvas canvas);

  /// Initializes the local video view.
  ///
  /// This method initializes the video view of a local stream on the local device. It affects only the video view that the local user sees, not the published local video stream. Call this method to bind the local video stream to a video view (view) and to set the rendering and mirror modes of the video view. After initialization, call this method to set the local video and then join the channel. The local video still binds to the view after you leave the channel. To unbind the local video from the view, set the view parameter as NULL. In real-time interactive scenarios, if you need to simultaneously view multiple preview frames in the local video preview, and each frame is at a different observation position along the video link, you can repeatedly call this method to set different view s and set different observation positions for each view. For example, by setting the video source to the camera and then configuring two view s with position setting to positionPostCapturerOrigin and positionPostCapturer, you can simultaneously preview the raw, unprocessed video frame and the video frame that has undergone preprocessing (image enhancement effects, virtual background, watermark) in the local video preview.
  ///  You can call this method either before or after joining a channel.
  ///  To update the rendering or mirror mode of the local video view during a call, use the setLocalRenderMode method.
  ///
  /// * [canvas] The local video view and settings. See VideoCanvas.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: Failure.
  Future<void> setupLocalVideo(VideoCanvas canvas);

  /// Sets video application scenarios.
  ///
  /// After successfully calling this method, the SDK will automatically enable the best practice strategies and adjust key performance metrics based on the specified scenario, to optimize the video experience. Ensure that you call this method before joining a channel.
  ///
  /// * [scenarioType] The type of video application scenario. See VideoApplicationScenarioType. If set to applicationScenarioMeeting (1), the SDK automatically enables the following strategies:
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
  ///  Bitrate: 500 Kbps
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setVideoScenario(VideoApplicationScenarioType scenarioType);

  /// @nodoc
  Future<void> setVideoQoEPreference(VideoQoePreferenceType qoePreference);

  /// Enables the audio module.
  ///
  /// The audio module is enabled by default After calling disableAudio to disable the audio module, you can call this method to re-enable it.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> enableAudio();

  /// Disables the audio module.
  ///
  /// The audio module is enabled by default, and you can call this method to disable the audio module.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> disableAudio();

  /// Sets the audio profile and audio scenario.
  ///
  /// * [profile] The audio profile, including the sampling rate, bitrate, encoding mode, and the number of channels. See AudioProfileType.
  /// * [scenario] The audio scenarios. Under different audio scenarios, the device uses different volume types. See AudioScenarioType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setAudioProfile(
      {required AudioProfileType profile,
      AudioScenarioType scenario = AudioScenarioType.audioScenarioDefault});

  /// Sets audio scenarios.
  ///
  /// * [scenario] The audio scenarios. Under different audio scenarios, the device uses different volume types. See AudioScenarioType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setAudioScenario(AudioScenarioType scenario);

  /// Enables or disables the local audio capture.
  ///
  /// The audio function is enabled by default when users joining a channel. This method disables or re-enables the local audio function to stop or restart local audio capturing. The difference between this method and muteLocalAudioStream are as follows: enableLocalAudio : Disables or re-enables the local audio capturing and processing. If you disable or re-enable local audio capturing using the enableLocalAudio method, the local user might hear a pause in the remote audio playback. muteLocalAudioStream : Sends or stops sending the local audio streams without affecting the audio capture status.
  ///
  /// * [enabled] true : (Default) Re-enable the local audio function, that is, to start the local audio capturing device (for example, the microphone). false : Disable the local audio function, that is, to stop local audio capturing.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> enableLocalAudio(bool enabled);

  /// Stops or resumes publishing the local audio stream.
  ///
  /// This method is used to control whether to publish the locally captured audio stream. If you call this method to stop publishing locally captured audio streams, the audio capturing device will still work and won't be affected.
  ///
  /// * [mute] Whether to stop publishing the local audio stream: true : Stops publishing the local audio stream. false : (Default) Resumes publishing the local audio stream.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> muteLocalAudioStream(bool mute);

  /// Stops or resumes subscribing to the audio streams of all remote users.
  ///
  /// After successfully calling this method, the local user stops or resumes subscribing to the audio streams of all remote users, including all subsequent users. By default, the SDK subscribes to the audio streams of all remote users when joining a channel. To modify this behavior, you can set autoSubscribeAudio to false when calling joinChannel to join the channel, which will cancel the subscription to the audio streams of all users upon joining the channel.
  ///
  /// * [mute] Whether to stop subscribing to the audio streams of all remote users: true : Stops subscribing to the audio streams of all remote users. false : (Default) Subscribes to the audio streams of all remote users by default.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> muteAllRemoteAudioStreams(bool mute);

  /// @nodoc
  Future<void> setDefaultMuteAllRemoteAudioStreams(bool mute);

  /// Stops or resumes subscribing to the audio stream of a specified user.
  ///
  /// * [uid] The user ID of the specified user.
  /// * [mute] Whether to subscribe to the specified remote user's audio stream. true : Stop subscribing to the audio stream of the specified user. false : (Default) Subscribe to the audio stream of the specified user.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> muteRemoteAudioStream({required int uid, required bool mute});

  /// Stops or resumes publishing the local video stream.
  ///
  /// This method is used to control whether to publish the locally captured video stream. If you call this method to stop publishing locally captured video streams, the video capturing device will still work and won't be affected. Compared to enableLocalVideo (false), which can also cancel the publishing of local video stream by turning off the local video stream capture, this method responds faster.
  ///
  /// * [mute] Whether to stop publishing the local video stream. true : Stop publishing the local video stream. false : (Default) Publish the local video stream.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> muteLocalVideoStream(bool mute);

  /// Enables/Disables the local video capture.
  ///
  /// This method disables or re-enables the local video capture, and does not affect receiving the remote video stream. After calling enableVideo, the local video capture is enabled by default. If you call enableLocalVideo (false) to disable local video capture within the channel, it also simultaneously stops publishing the video stream within the channel. If you want to restart video catpure, you can call enableLocalVideo (true) and then call updateChannelMediaOptions to set the options parameter to publish the locally captured video stream in the channel. After the local video capturer is successfully disabled or re-enabled, the SDK triggers the onRemoteVideoStateChanged callback on the remote client.
  ///  You can call this method either before or after joining a channel.
  ///  This method enables the internal engine and is valid after leaving the channel.
  ///
  /// * [enabled] Whether to enable the local video capture. true : (Default) Enable the local video capture. false : Disable the local video capture. Once the local video is disabled, the remote users cannot receive the video stream of the local user, while the local user can still receive the video streams of remote users. When set to false, this method does not require a local camera.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> enableLocalVideo(bool enabled);

  /// Stops or resumes subscribing to the video streams of all remote users.
  ///
  /// After successfully calling this method, the local user stops or resumes subscribing to the audio streams of all remote users, including all subsequent users. By default, the SDK subscribes to the video streams of all remote users when joining a channel. To modify this behavior, you can set autoSubscribeVideo to false when calling joinChannel to join the channel, which will cancel the subscription to the video streams of all users upon joining the channel.
  ///
  /// * [mute] Whether to stop subscribing to the video streams of all remote users. true : Stop subscribing to the video streams of all remote users. false : (Default) Subscribe to the audio streams of all remote users by default.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> muteAllRemoteVideoStreams(bool mute);

  /// @nodoc
  Future<void> setDefaultMuteAllRemoteVideoStreams(bool mute);

  /// Sets the default video stream type to subscribe to.
  ///
  /// The SDK will dynamically adjust the size of the corresponding video stream based on the size of the video window to save bandwidth and computing resources. The default aspect ratio of the low-quality video stream is the same as that of the high-quality video stream. According to the current aspect ratio of the high-quality video stream, the system will automatically allocate the resolution, frame rate, and bitrate of the low-quality video stream. The SDK defaults to enabling low-quality video stream adaptive mode (autoSimulcastStream) on the sending end, which means the sender does not actively send low-quality video stream. The receiver with the role of the host can initiate a low-quality video stream request by calling this method, and upon receiving the request, the sending end automatically starts sending the low-quality video stream.
  ///  Call this method before joining a channel. The SDK does not support changing the default subscribed video stream type after joining a channel.
  ///  If you call both this method and setRemoteVideoStreamType, the setting of setRemoteVideoStreamType takes effect.
  ///
  /// * [streamType] The default video-stream type. See VideoStreamType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setRemoteDefaultVideoStreamType(VideoStreamType streamType);

  /// Stops or resumes subscribing to the video stream of a specified user.
  ///
  /// * [uid] The user ID of the specified user.
  /// * [mute] Whether to subscribe to the specified remote user's video stream. true : Stop subscribing to the video streams of the specified user. false : (Default) Subscribe to the video stream of the specified user.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: Failure.
  Future<void> muteRemoteVideoStream({required int uid, required bool mute});

  /// Sets the video stream type to subscribe to.
  ///
  /// The SDK defaults to enabling low-quality video stream adaptive mode (autoSimulcastStream) on the sending end, which means the sender does not actively send low-quality video stream. The receiver with the role of the host can initiate a low-quality video stream request by calling this method, and upon receiving the request, the sending end automatically starts sending the low-quality video stream. The SDK will dynamically adjust the size of the corresponding video stream based on the size of the video window to save bandwidth and computing resources. The default aspect ratio of the low-quality video stream is the same as that of the high-quality video stream. According to the current aspect ratio of the high-quality video stream, the system will automatically allocate the resolution, frame rate, and bitrate of the low-quality video stream.
  ///  You can call this method either before or after joining a channel.
  ///  If the publisher has already called setDualStreamMode and set mode to disableSimulcastStream (never send low-quality video stream), calling this method will not take effect, you should call setDualStreamMode again on the sending end and adjust the settings.
  ///  Calling this method on the receiving end of the audience role will not take effect.
  ///  If you call both setRemoteVideoStreamType and setRemoteDefaultVideoStreamType, the settings in setRemoteVideoStreamType take effect.
  ///
  /// * [uid] The user ID.
  /// * [streamType] The video stream type, see VideoStreamType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setRemoteVideoStreamType(
      {required int uid, required VideoStreamType streamType});

  /// Options for subscribing to remote video streams.
  ///
  /// When a remote user has enabled dual-stream mode, you can call this method to choose the option for subscribing to the video streams sent by the remote user.
  ///  If you only register one VideoFrameObserver object, the SDK subscribes to the raw video data and encoded video data by default (the effect is equivalent to setting encodedFrameOnly to false).
  ///  If you only register one VideoEncodedFrameObserver object, the SDK only subscribes to the encoded video data by default (the effect is equivalent to setting encodedFrameOnly to true).
  ///  If you register one VideoFrameObserver object and one VideoEncodedFrameObserver object successively, the SDK subscribes to the encoded video data by default (the effect is equivalent to setting encodedFrameOnly to false).
  ///  If you call this method first with the options parameter set, and then register one VideoFrameObserver or VideoEncodedFrameObserver object, you need to call this method again and set the options parameter as described in the above two items to get the desired results. Agora recommends the following steps:
  ///  Set autoSubscribeVideo to false when calling joinChannel to join a channel.
  ///  Call this method after receiving the onUserJoined callback to set the subscription options for the specified remote user's video stream.
  ///  Call the muteRemoteVideoStream method to resume subscribing to the video stream of the specified remote user. If you set encodedFrameOnly to true in the previous step, the SDK triggers the onEncodedVideoFrameReceived callback locally to report the received encoded video frame information.
  ///
  /// * [uid] The user ID of the remote user.
  /// * [options] The video subscription options. See VideoSubscriptionOptions.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setRemoteVideoSubscriptionOptions(
      {required int uid, required VideoSubscriptionOptions options});

  /// Set the blocklist of subscriptions for audio streams.
  ///
  /// You can call this method to specify the audio streams of a user that you do not want to subscribe to.
  ///  You can call this method either before or after joining a channel.
  ///  The blocklist is not affected by the setting in muteRemoteAudioStream, muteAllRemoteAudioStreams, and autoSubscribeAudio in ChannelMediaOptions.
  ///  Once the blocklist of subscriptions is set, it is effective even if you leave the current channel and rejoin the channel.
  ///  If a user is added in the allowlist and blocklist at the same time, only the blocklist takes effect.
  ///
  /// * [uidList] The user ID list of users that you do not want to subscribe to. If you want to specify the audio streams of a user that you do not want to subscribe to, add the user ID in this list. If you want to remove a user from the blocklist, you need to call the setSubscribeAudioBlocklist method to update the user ID list; this means you only add the uid of users that you do not want to subscribe to in the new user ID list.
  /// * [uidNumber] The number of users in the user ID list.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setSubscribeAudioBlocklist(
      {required List<int> uidList, required int uidNumber});

  /// Sets the allowlist of subscriptions for audio streams.
  ///
  /// You can call this method to specify the audio streams of a user that you want to subscribe to.
  ///  If a user is added in the allowlist and blocklist at the same time, only the blocklist takes effect.
  ///  You can call this method either before or after joining a channel.
  ///  The allowlist is not affected by the setting in muteRemoteAudioStream, muteAllRemoteAudioStreams and autoSubscribeAudio in ChannelMediaOptions.
  ///  Once the allowlist of subscriptions is set, it is effective even if you leave the current channel and rejoin the channel.
  ///
  /// * [uidList] The user ID list of users that you want to subscribe to. If you want to specify the audio streams of a user for subscription, add the user ID in this list. If you want to remove a user from the allowlist, you need to call the setSubscribeAudioAllowlist method to update the user ID list; this means you only add the uid of users that you want to subscribe to in the new user ID list.
  /// * [uidNumber] The number of users in the user ID list.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setSubscribeAudioAllowlist(
      {required List<int> uidList, required int uidNumber});

  /// Set the blocklist of subscriptions for video streams.
  ///
  /// You can call this method to specify the video streams of a user that you do not want to subscribe to.
  ///  If a user is added in the allowlist and blocklist at the same time, only the blocklist takes effect.
  ///  Once the blocklist of subscriptions is set, it is effective even if you leave the current channel and rejoin the channel.
  ///  You can call this method either before or after joining a channel.
  ///  The blocklist is not affected by the setting in muteRemoteVideoStream, muteAllRemoteVideoStreams and autoSubscribeAudio in ChannelMediaOptions.
  ///
  /// * [uidList] The user ID list of users that you do not want to subscribe to. If you want to specify the video streams of a user that you do not want to subscribe to, add the user ID of that user in this list. If you want to remove a user from the blocklist, you need to call the setSubscribeVideoBlocklist method to update the user ID list; this means you only add the uid of users that you do not want to subscribe to in the new user ID list.
  /// * [uidNumber] The number of users in the user ID list.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setSubscribeVideoBlocklist(
      {required List<int> uidList, required int uidNumber});

  /// Set the allowlist of subscriptions for video streams.
  ///
  /// You can call this method to specify the video streams of a user that you want to subscribe to.
  ///  If a user is added in the allowlist and blocklist at the same time, only the blocklist takes effect.
  ///  Once the allowlist of subscriptions is set, it is effective even if you leave the current channel and rejoin the channel.
  ///  You can call this method either before or after joining a channel.
  ///  The allowlist is not affected by the setting in muteRemoteVideoStream, muteAllRemoteVideoStreams and autoSubscribeAudio in ChannelMediaOptions.
  ///
  /// * [uidList] The user ID list of users that you want to subscribe to. If you want to specify the video streams of a user for subscription, add the user ID of that user in this list. If you want to remove a user from the allowlist, you need to call the setSubscribeVideoAllowlist method to update the user ID list; this means you only add the uid of users that you want to subscribe to in the new user ID list.
  /// * [uidNumber] The number of users in the user ID list.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setSubscribeVideoAllowlist(
      {required List<int> uidList, required int uidNumber});

  /// Enables the reporting of users' volume indication.
  ///
  /// This method enables the SDK to regularly report the volume information to the app of the local user who sends a stream and remote users (three users at most) whose instantaneous volumes are the highest.
  ///
  /// * [interval] Sets the time interval between two consecutive volume indications:
  ///  ≤ 0: Disables the volume indication.
  ///  > 0: Time interval (ms) between two consecutive volume indications. Ensure this parameter is set to a value greater than 10, otherwise you will not receive the onAudioVolumeIndication callback. Agora recommends that this value is set as greater than 100.
  /// * [smooth] The smoothing factor that sets the sensitivity of the audio volume indicator. The value ranges between 0 and 10. The recommended value is 3. The greater the value, the more sensitive the indicator.
  /// * [reportVad] true : Enables the voice activity detection of the local user. Once it is enabled, the vad parameter of the onAudioVolumeIndication callback reports the voice activity status of the local user. false : (Default) Disables the voice activity detection of the local user. Once it is disabled, the vad parameter of the onAudioVolumeIndication callback does not report the voice activity status of the local user, except for the scenario where the engine automatically detects the voice activity of the local user.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> enableAudioVolumeIndication(
      {required int interval, required int smooth, required bool reportVad});

  /// Starts audio recording on the client and sets recording configurations.
  ///
  /// The Agora SDK allows recording during a call. After successfully calling this method, you can record the audio of users in the channel and get an audio recording file. Supported formats of the recording file are as follows:
  ///  WAV: High-fidelity files with typically larger file sizes. For example, if the sample rate is 32,000 Hz, the file size for 10-minute recording is approximately 73 MB.
  ///  AAC: Low-fidelity files with typically smaller file sizes. For example, if the sample rate is 32,000 Hz and the recording quality is audioRecordingQualityMedium, the file size for 10-minute recording is approximately 2 MB. Once the user leaves the channel, the recording automatically stops. Call this method after joining a channel.
  ///
  /// * [config] Recording configurations. See AudioRecordingConfiguration.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> startAudioRecording(AudioRecordingConfiguration config);

  /// Registers an encoded audio observer.
  ///
  /// Call this method after joining a channel.
  ///  You can call this method or startAudioRecording to set the recording type and quality of audio files, but Agora does not recommend using this method and startAudioRecording at the same time. Only the method called later will take effect.
  ///
  /// * [config] Observer settings for the encoded audio. See AudioEncodedFrameObserverConfig.
  /// * [observer] The encoded audio observer. See AudioEncodedFrameObserver.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  void registerAudioEncodedFrameObserver(
      {required AudioEncodedFrameObserverConfig config,
      required AudioEncodedFrameObserver observer});

  /// Stops the audio recording on the client.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> stopAudioRecording();

  /// Creates a media player instance.
  ///
  /// Returns
  /// The MediaPlayer instance, if the method call succeeds.
  ///  An empty pointer, if the method call fails.
  Future<MediaPlayer?> createMediaPlayer();

  /// Destroys the media player instance.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: Failure.
  Future<void> destroyMediaPlayer(MediaPlayer mediaPlayer);

  /// @nodoc
  Future<MediaRecorder?> createMediaRecorder(RecorderStreamInfo info);

  /// @nodoc
  Future<void> destroyMediaRecorder(MediaRecorder mediaRecorder);

  /// Starts playing the music file.
  ///
  /// This method mixes the specified local or online audio file with the audio from the microphone, or replaces the microphone's audio with the specified local or remote audio file. A successful method call triggers the onAudioMixingStateChanged (audioMixingStatePlaying) callback. When the audio mixing file playback finishes, the SDK triggers the onAudioMixingStateChanged (audioMixingStateStopped) callback on the local client.
  ///  You can call this method either before or after joining a channel. If you need to call startAudioMixing multiple times, ensure that the time interval between calling this method is more than 500 ms.
  ///  If the local music file does not exist, the SDK does not support the file format, or the the SDK cannot access the music file URL, the SDK reports 701.
  ///  For the audio file formats supported by this method, see What formats of audio files does the Agora RTC SDK support.
  ///
  /// * [filePath] File path:
  ///  Android: The file path, which needs to be accurate to the file name and suffix. Agora supports URL addresses, absolute paths, or file paths that start with /assets/. You might encounter permission issues if you use an absolute path to access a local file, so Agora recommends using a URI address instead. For example : content://com.android.providers.media.documents/document/audio%3A14441
  ///  Windows: The absolute path or URL address (including the suffixes of the filename) of the audio effect file. For example : C:\music\audio.mp4.
  ///  iOS or macOS: The absolute path or URL address (including the suffixes of the filename) of the audio effect file. For example: /var/mobile/Containers/Data/audio.mp4.
  /// * [loopback] Whether to only play music files on the local client: true : Only play music files on the local client so that only the local user can hear the music. false : Publish music files to remote clients so that both the local user and remote users can hear the music.
  /// * [cycle] The number of times the music file plays.
  ///  ≥ 0: The number of playback times. For example, 0 means that the SDK does not play the music file while 1 means that the SDK plays once.
  ///  -1: Play the audio file in an infinite loop.
  /// * [startPos] The playback position (ms) of the music file.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> startAudioMixing(
      {required String filePath,
      required bool loopback,
      required int cycle,
      int startPos = 0});

  /// Stops playing and mixing the music file.
  ///
  /// This method stops the audio mixing. Call this method when you are in a channel.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> stopAudioMixing();

  /// Pauses playing and mixing the music file.
  ///
  /// Call this method after joining a channel.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> pauseAudioMixing();

  /// Resumes playing and mixing the music file.
  ///
  /// This method resumes playing and mixing the music file. Call this method when you are in a channel.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> resumeAudioMixing();

  /// Selects the audio track used during playback.
  ///
  /// After getting the track index of the audio file, you can call this method to specify any track to play. For example, if different tracks of a multi-track file store songs in different languages, you can call this method to set the playback language.
  ///  For the supported formats of audio files, see.
  ///  You need to call this method after calling startAudioMixing and receiving the onAudioMixingStateChanged (audioMixingStatePlaying) callback.
  ///
  /// * [index] The audio track you want to specify. The value range is [0, getAudioTrackCount ()].
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> selectAudioTrack(int index);

  /// Gets the index of audio tracks of the current music file.
  ///
  /// You need to call this method after calling startAudioMixing and receiving the onAudioMixingStateChanged (audioMixingStatePlaying) callback.
  ///
  /// Returns
  /// The SDK returns the index of the audio tracks if the method call succeeds.
  ///  < 0: Failure.
  Future<int> getAudioTrackCount();

  /// Adjusts the volume during audio mixing.
  ///
  /// This method adjusts the audio mixing volume on both the local client and remote clients.
  ///  Call this method after startAudioMixing.
  ///
  /// * [volume] Audio mixing volume. The value ranges between 0 and 100. The default value is 100, which means the original volume.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> adjustAudioMixingVolume(int volume);

  /// Adjusts the volume of audio mixing for publishing.
  ///
  /// This method adjusts the volume of audio mixing for publishing (sending to other users). Call this method after calling startAudioMixing and receiving the onAudioMixingStateChanged (audioMixingStatePlaying) callback.
  ///
  /// * [volume] The volume of audio mixing for local playback. The value ranges between 0 and 100 (default). 100 represents the original volume.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> adjustAudioMixingPublishVolume(int volume);

  /// Retrieves the audio mixing volume for publishing.
  ///
  /// This method helps troubleshoot audio volume‑related issues. You need to call this method after calling startAudioMixing and receiving the onAudioMixingStateChanged (audioMixingStatePlaying) callback.
  ///
  /// Returns
  /// ≥ 0: The audio mixing volume, if this method call succeeds. The value range is [0,100].
  ///  < 0: Failure.
  Future<int> getAudioMixingPublishVolume();

  /// Adjusts the volume of audio mixing for local playback.
  ///
  /// Call this method after calling startAudioMixing and receiving the onAudioMixingStateChanged (audioMixingStatePlaying) callback.
  ///
  /// * [volume] The volume of audio mixing for local playback. The value ranges between 0 and 100 (default). 100 represents the original volume.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> adjustAudioMixingPlayoutVolume(int volume);

  /// Retrieves the audio mixing volume for local playback.
  ///
  /// This method helps troubleshoot audio volume‑related issues. You need to call this method after calling startAudioMixing and receiving the onAudioMixingStateChanged (audioMixingStatePlaying) callback.
  ///
  /// Returns
  /// ≥ 0: The audio mixing volume, if this method call succeeds. The value range is [0,100].
  ///  < 0: Failure.
  Future<int> getAudioMixingPlayoutVolume();

  /// Retrieves the duration (ms) of the music file.
  ///
  /// Retrieves the total duration (ms) of the audio. You need to call this method after calling startAudioMixing and receiving the onAudioMixingStateChanged (audioMixingStatePlaying) callback.
  ///
  /// Returns
  /// ≥ 0: The audio mixing duration, if this method call succeeds.
  ///  < 0: Failure.
  Future<int> getAudioMixingDuration();

  /// Retrieves the playback position (ms) of the music file.
  ///
  /// Retrieves the playback position (ms) of the audio. You need to call this method after calling startAudioMixing and receiving the onAudioMixingStateChanged (audioMixingStatePlaying) callback.
  ///  If you need to call getAudioMixingCurrentPosition multiple times, ensure that the time interval between calling this method is more than 500 ms.
  ///
  /// Returns
  /// ≥ 0: The current playback position (ms) of the audio mixing, if this method call succeeds. 0 represents that the current music file does not start playing.
  ///  < 0: Failure.
  Future<int> getAudioMixingCurrentPosition();

  /// Sets the audio mixing position.
  ///
  /// Call this method to set the playback position of the music file to a different starting position (the default plays from the beginning). You need to call this method after calling startAudioMixing and receiving the onAudioMixingStateChanged (audioMixingStatePlaying) callback.
  ///
  /// * [pos] Integer. The playback position (ms).
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setAudioMixingPosition(int pos);

  /// Sets the channel mode of the current audio file.
  ///
  /// In a stereo music file, the left and right channels can store different audio data. According to your needs, you can set the channel mode to original mode, left channel mode, right channel mode, or mixed channel mode. For example, in the KTV scenario, the left channel of the music file stores the musical accompaniment, and the right channel stores the singing voice. If you only need to listen to the accompaniment, call this method to set the channel mode of the music file to left channel mode; if you need to listen to the accompaniment and the singing voice at the same time, call this method to set the channel mode to mixed channel mode.
  ///  You need to call this method after calling startAudioMixing and receiving the onAudioMixingStateChanged (audioMixingStatePlaying) callback.
  ///  This method only applies to stereo audio files.
  ///
  /// * [mode] The channel mode. See AudioMixingDualMonoMode.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setAudioMixingDualMonoMode(AudioMixingDualMonoMode mode);

  /// Sets the pitch of the local music file.
  ///
  /// When a local music file is mixed with a local human voice, call this method to set the pitch of the local music file only. You need to call this method after calling startAudioMixing and receiving the onAudioMixingStateChanged (audioMixingStatePlaying) callback.
  ///
  /// * [pitch] Sets the pitch of the local music file by the chromatic scale. The default value is 0, which means keeping the original pitch. The value ranges from -12 to 12, and the pitch value between consecutive values is a chromatic value. The greater the absolute value of this parameter, the higher or lower the pitch of the local music file.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setAudioMixingPitch(int pitch);

  /// Sets the playback speed of the current audio file.
  ///
  /// Ensure you call this method after calling startAudioMixing receiving the onAudioMixingStateChanged callback reporting the state as audioMixingStatePlaying.
  ///
  /// * [speed] The playback speed. Agora recommends that you set this to a value between 50 and 400, defined as follows:
  ///  50: Half the original speed.
  ///  100: The original speed.
  ///  400: 4 times the original speed.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setAudioMixingPlaybackSpeed(int speed);

  /// Retrieves the volume of the audio effects.
  ///
  /// The volume is an integer ranging from 0 to 100. The default value is 100, which means the original volume. Call this method after playEffect.
  ///
  /// Returns
  /// Volume of the audio effects, if this method call succeeds.
  ///  < 0: Failure.
  Future<int> getEffectsVolume();

  /// Sets the volume of the audio effects.
  ///
  /// Call this method after playEffect.
  ///
  /// * [volume] The playback volume. The value range is [0, 100]. The default value is 100, which represents the original volume.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setEffectsVolume(int volume);

  /// Preloads a specified audio effect file into the memory.
  ///
  /// To ensure smooth communication, It is recommended that you limit the size of the audio effect file. You can call this method to preload the audio effect before calling joinChannel. For the audio file formats supported by this method, see What formats of audio files does the Agora RTC SDK support.
  ///
  /// * [soundId] The audio effect ID. The ID of each audio effect file is unique.
  /// * [filePath] File path:
  ///  Android: The file path, which needs to be accurate to the file name and suffix. Agora supports URL addresses, absolute paths, or file paths that start with /assets/. You might encounter permission issues if you use an absolute path to access a local file, so Agora recommends using a URI address instead. For example : content://com.android.providers.media.documents/document/audio%3A14441
  ///  Windows: The absolute path or URL address (including the suffixes of the filename) of the audio effect file. For example : C:\music\audio.mp4.
  ///  iOS or macOS: The absolute path or URL address (including the suffixes of the filename) of the audio effect file. For example: /var/mobile/Containers/Data/audio.mp4.
  /// * [startPos] The playback position (ms) of the audio effect file.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> preloadEffect(
      {required int soundId, required String filePath, int startPos = 0});

  /// Plays the specified local or online audio effect file.
  ///
  /// If you use this method to play an online audio effect file, Agora recommends that you cache the online audio effect file to your local device, call preloadEffect to preload the cached audio effect file into memory, and then call this method to play the audio effect. Otherwise, you might encounter playback failures or no sound during playback due to loading timeouts or failures. To play multiple audio effect files at the same time, call this method multiple times with different soundId and filePath. To achieve the optimal user experience, Agora recommends that do not playing more than three audio files at the same time. After the playback of an audio effect file completes, the SDK triggers the onAudioEffectFinished callback.
  ///
  /// * [soundId] The audio effect ID. The ID of each audio effect file is unique. If you have preloaded an audio effect into memory by calling preloadEffect, ensure that the value of this parameter is the same as that of soundId in preloadEffect.
  /// * [filePath] The absolute path or URL address (including the suffixes of the filename) of the audio effect file. For example, C:\music\audio.mp4. Supported audio formats include MP3, AAC, M4A, MP4, WAV, and 3GP. See supported audio formats. If you have preloaded an audio effect into memory by calling preloadEffect, ensure that the value of this parameter is the same as that of filePath in preloadEffect.
  /// * [loopCount] The number of times the audio effect loops.
  ///  ≥ 0: The number of playback times. For example, 1 means looping one time, which means playing the audio effect two times in total.
  ///  -1: Play the audio file in an infinite loop.
  /// * [pitch] The pitch of the audio effect. The value range is 0.5 to 2.0. The default value is 1.0, which means the original pitch. The lower the value, the lower the pitch.
  /// * [pan] The spatial position of the audio effect. The value ranges between -1.0 and 1.0:
  ///  -1.0: The audio effect is heard on the left of the user.
  ///  0.0: The audio effect is heard in front of the user.
  ///  1.0: The audio effect is heard on the right of the user.
  /// * [gain] The volume of the audio effect. The value range is 0.0 to 100.0. The default value is 100.0, which means the original volume. The smaller the value, the lower the volume.
  /// * [publish] Whether to publish the audio effect to the remote users: true : Publish the audio effect to the remote users. Both the local user and remote users can hear the audio effect. false : Do not publish the audio effect to the remote users. Only the local user can hear the audio effect.
  /// * [startPos] The playback position (ms) of the audio effect file.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: Failure.
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
  /// After calling preloadEffect multiple times to preload multiple audio effects into the memory, you can call this method to play all the specified audio effects for all users in the channel.
  ///
  /// * [loopCount] The number of times the audio effect loops:
  ///  -1: Play the audio effect files in an indefinite loop until you call stopEffect or stopAllEffects.
  ///  0: Play the audio effect once.
  ///  1: Play the audio effect twice.
  /// * [pitch] The pitch of the audio effect. The value ranges between 0.5 and 2.0. The default value is 1.0 (original pitch). The lower the value, the lower the pitch.
  /// * [pan] The spatial position of the audio effect. The value ranges between -1.0 and 1.0:
  ///  -1.0: The audio effect shows on the left.
  ///  0: The audio effect shows ahead.
  ///  1.0: The audio effect shows on the right.
  /// * [gain] The volume of the audio effect. The value range is [0, 100]. The default value is 100 (original volume). The smaller the value, the lower the volume.
  /// * [publish] Whether to publish the audio effect to the remote users: true : Publish the audio effect to the remote users. Both the local user and remote users can hear the audio effect. false : (Default) Do not publish the audio effect to the remote users. Only the local user can hear the audio effect.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> playAllEffects(
      {required int loopCount,
      required double pitch,
      required double pan,
      required int gain,
      bool publish = false});

  /// Gets the volume of a specified audio effect file.
  ///
  /// * [soundId] The ID of the audio effect file.
  ///
  /// Returns
  /// ≥ 0: Returns the volume of the specified audio effect, if the method call is successful. The value ranges between 0 and 100. 100 represents the original volume.
  ///  < 0: Failure.
  Future<int> getVolumeOfEffect(int soundId);

  /// Sets the volume of a specified audio effect.
  ///
  /// * [soundId] The ID of the audio effect. The ID of each audio effect file is unique.
  /// * [volume] The playback volume. The value range is [0, 100]. The default value is 100, which represents the original volume.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setVolumeOfEffect({required int soundId, required int volume});

  /// Pauses a specified audio effect file.
  ///
  /// * [soundId] The audio effect ID. The ID of each audio effect file is unique.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> pauseEffect(int soundId);

  /// Pauses all audio effects.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> pauseAllEffects();

  /// Resumes playing a specified audio effect.
  ///
  /// * [soundId] The audio effect ID. The ID of each audio effect file is unique.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> resumeEffect(int soundId);

  /// Resumes playing all audio effect files.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> resumeAllEffects();

  /// Stops playing a specified audio effect.
  ///
  /// * [soundId] The ID of the audio effect. Each audio effect has a unique ID.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> stopEffect(int soundId);

  /// Stops playing all audio effects.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> stopAllEffects();

  /// Releases a specified preloaded audio effect from the memory.
  ///
  /// * [soundId] The ID of the audio effect. Each audio effect has a unique ID.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> unloadEffect(int soundId);

  /// Releases a specified preloaded audio effect from the memory.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> unloadAllEffects();

  /// Retrieves the duration of the audio effect file.
  ///
  /// Call this method after joining a channel.
  ///
  /// * [filePath] File path:
  ///  Android: The file path, which needs to be accurate to the file name and suffix. Agora supports URL addresses, absolute paths, or file paths that start with /assets/. You might encounter permission issues if you use an absolute path to access a local file, so Agora recommends using a URI address instead. For example : content://com.android.providers.media.documents/document/audio%3A14441
  ///  Windows: The absolute path or URL address (including the suffixes of the filename) of the audio effect file. For example : C:\music\audio.mp4.
  ///  iOS or macOS: The absolute path or URL address (including the suffixes of the filename) of the audio effect file. For example: /var/mobile/Containers/Data/audio.mp4.
  ///
  /// Returns
  /// The total duration (ms) of the specified audio effect file, if the method call succeeds.
  ///  < 0: Failure.
  Future<int> getEffectDuration(String filePath);

  /// Sets the playback position of an audio effect file.
  ///
  /// After a successful setting, the local audio effect file starts playing at the specified position. Call this method after playEffect.
  ///
  /// * [soundId] The audio effect ID. The ID of each audio effect file is unique.
  /// * [pos] The playback position (ms) of the audio effect file.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setEffectPosition({required int soundId, required int pos});

  /// Retrieves the playback position of the audio effect file.
  ///
  /// Call this method after playEffect.
  ///
  /// * [soundId] The audio effect ID. The ID of each audio effect file is unique.
  ///
  /// Returns
  /// The playback position (ms) of the specified audio effect file, if the method call succeeds.
  ///  < 0: Failure.
  Future<int> getEffectCurrentPosition(int soundId);

  /// Enables or disables stereo panning for remote users.
  ///
  /// Ensure that you call this method before joining a channel to enable stereo panning for remote users so that the local user can track the position of a remote user by calling setRemoteVoicePosition.
  ///
  /// * [enabled] Whether to enable stereo panning for remote users: true : Enable stereo panning. false : Disable stereo panning.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> enableSoundPositionIndication(bool enabled);

  /// Sets the 2D position (the position on the horizontal plane) of the remote user's voice.
  ///
  /// This method sets the 2D position and volume of a remote user, so that the local user can easily hear and identify the remote user's position. When the local user calls this method to set the voice position of a remote user, the voice difference between the left and right channels allows the local user to track the real-time position of the remote user, creating a sense of space. This method applies to massive multiplayer online games, such as Battle Royale games.
  ///  For this method to work, enable stereo panning for remote users by calling the enableSoundPositionIndication method before joining a channel.
  ///  For the best voice positioning, Agora recommends using a wired headset.
  ///  Call this method after joining a channel.
  ///
  /// * [uid] The user ID of the remote user.
  /// * [pan] The voice position of the remote user. The value ranges from -1.0 to 1.0:
  ///  0.0: (Default) The remote voice comes from the front.
  ///  -1.0: The remote voice comes from the left.
  ///  1.0: The remote voice comes from the right.
  /// * [gain] The volume of the remote user. The value ranges from 0.0 to 100.0. The default value is 100.0 (the original volume of the remote user). The smaller the value, the lower the volume.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setRemoteVoicePosition(
      {required int uid, required double pan, required double gain});

  /// Enables or disables the spatial audio effect.
  ///
  /// After enabling the spatial audio effect, you can call setRemoteUserSpatialAudioParams to set the spatial audio effect parameters of the remote user.
  ///  You can call this method either before or after joining a channel.
  ///  This method relies on the spatial audio dynamic library libagora_spatial_audio_extension.dll. If the dynamic library is deleted, the function cannot be enabled normally.
  ///
  /// * [enabled] Whether to enable the spatial audio effect: true : Enable the spatial audio effect. false : Disable the spatial audio effect.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> enableSpatialAudio(bool enabled);

  /// Sets the spatial audio effect parameters of the remote user.
  ///
  /// Call this method after enableSpatialAudio. After successfully setting the spatial audio effect parameters of the remote user, the local user can hear the remote user with a sense of space.
  ///
  /// * [uid] The user ID. This parameter must be the same as the user ID passed in when the user joined the channel.
  /// * [params] The spatial audio parameters. See SpatialAudioParams.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setRemoteUserSpatialAudioParams(
      {required int uid, required SpatialAudioParams params});

  /// Sets a preset voice beautifier effect.
  ///
  /// Call this method to set a preset voice beautifier effect for the local user who sends an audio stream. After setting a voice beautifier effect, all users in the channel can hear the effect. You can set different voice beautifier effects for different scenarios. To achieve better vocal effects, it is recommended that you call the following APIs before calling this method:
  ///  Call setAudioScenario to set the audio scenario to high-quality audio scenario, namely audioScenarioGameStreaming (3).
  ///  Call setAudioProfile to set the profile parameter to audioProfileMusicHighQuality (4) or audioProfileMusicHighQualityStereo (5).
  ///  You can call this method either before or after joining a channel.
  ///  Do not set the profile parameter in setAudioProfile to audioProfileSpeechStandard (1) or audioProfileIot (6), or the method does not take effect.
  ///  This method has the best effect on human voice processing, and Agora does not recommend calling this method to process audio data containing music.
  ///  After calling setVoiceBeautifierPreset, Agora does not recommend calling the following methods, otherwise the effect set by setVoiceBeautifierPreset will be overwritten: setAudioEffectPreset setAudioEffectParameters setLocalVoicePitch setLocalVoiceEqualization setLocalVoiceReverb setVoiceBeautifierParameters setVoiceConversionPreset
  ///  This method relies on the voice beautifier dynamic library libagora_audio_beauty_extension.dll. If the dynamic library is deleted, the function cannot be enabled normally.
  ///
  /// * [preset] The preset voice beautifier effect options: VoiceBeautifierPreset.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setVoiceBeautifierPreset(VoiceBeautifierPreset preset);

  /// Sets an SDK preset audio effect.
  ///
  /// To achieve better vocal effects, it is recommended that you call the following APIs before calling this method:
  ///  Call setAudioScenario to set the audio scenario to high-quality audio scenario, namely audioScenarioGameStreaming (3).
  ///  Call setAudioProfile to set the profile parameter to audioProfileMusicHighQuality (4) or audioProfileMusicHighQualityStereo (5). Call this method to set an SDK preset audio effect for the local user who sends an audio stream. This audio effect does not change the gender characteristics of the original voice. After setting an audio effect, all users in the channel can hear the effect.
  ///  Do not set the profile parameter in setAudioProfile to audioProfileSpeechStandard (1) or audioProfileIot (6), or the method does not take effect.
  ///  You can call this method either before or after joining a channel.
  ///  If you call setAudioEffectPreset and set enumerators except for roomAcoustics3dVoice or pitchCorrection, do not call setAudioEffectParameters; otherwise, setAudioEffectPreset is overridden.
  ///  After calling setAudioEffectPreset, Agora does not recommend you to call the following methods, otherwise the effect set by setAudioEffectPreset will be overwritten: setVoiceBeautifierPreset setLocalVoicePitch setLocalVoiceEqualization setLocalVoiceReverb setVoiceBeautifierParameters setVoiceConversionPreset
  ///  This method relies on the voice beautifier dynamic library libagora_audio_beauty_extension.dll. If the dynamic library is deleted, the function cannot be enabled normally.
  ///
  /// * [preset] The options for SDK preset audio effects. See AudioEffectPreset.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setAudioEffectPreset(AudioEffectPreset preset);

  /// Sets a preset voice beautifier effect.
  ///
  /// To achieve better vocal effects, it is recommended that you call the following APIs before calling this method:
  ///  Call setAudioScenario to set the audio scenario to high-quality audio scenario, namely audioScenarioGameStreaming (3).
  ///  Call setAudioProfile to set the profile parameter to audioProfileMusicHighQuality (4) or audioProfileMusicHighQualityStereo (5). Call this method to set a preset voice beautifier effect for the local user who sends an audio stream. After setting an audio effect, all users in the channel can hear the effect. You can set different voice beautifier effects for different scenarios.
  ///  Do not set the profile parameter in setAudioProfile to audioProfileSpeechStandard (1) or audioProfileIot (6), or the method does not take effect.
  ///  You can call this method either before or after joining a channel.
  ///  This method has the best effect on human voice processing, and Agora does not recommend calling this method to process audio data containing music.
  ///  After calling setVoiceConversionPreset, Agora does not recommend you to call the following methods, otherwise the effect set by setVoiceConversionPreset will be overwritten: setAudioEffectPreset setAudioEffectParameters setVoiceBeautifierPreset setVoiceBeautifierParameters setLocalVoicePitch setLocalVoiceFormant setLocalVoiceEqualization setLocalVoiceReverb
  ///  This method relies on the voice beautifier dynamic library libagora_audio_beauty_extension.dll. If the dynamic library is deleted, the function cannot be enabled normally.
  ///
  /// * [preset] The options for the preset voice beautifier effects: VoiceConversionPreset.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: Failure.
  Future<void> setVoiceConversionPreset(VoiceConversionPreset preset);

  /// Sets parameters for SDK preset audio effects.
  ///
  /// To achieve better vocal effects, it is recommended that you call the following APIs before calling this method:
  ///  Call setAudioScenario to set the audio scenario to high-quality audio scenario, namely audioScenarioGameStreaming (3).
  ///  Call setAudioProfile to set the profile parameter to audioProfileMusicHighQuality (4) or audioProfileMusicHighQualityStereo (5). Call this method to set the following parameters for the local user who sends an audio stream:
  ///  3D voice effect: Sets the cycle period of the 3D voice effect.
  ///  Pitch correction effect: Sets the basic mode and tonic pitch of the pitch correction effect. Different songs have different modes and tonic pitches. Agora recommends bounding this method with interface elements to enable users to adjust the pitch correction interactively. After setting the audio parameters, all users in the channel can hear the effect.
  ///  Do not set the profile parameter in setAudioProfile to audioProfileSpeechStandard (1) or audioProfileIot (6), or the method does not take effect.
  ///  You can call this method either before or after joining a channel.
  ///  This method has the best effect on human voice processing, and Agora does not recommend calling this method to process audio data containing music.
  ///  After calling setAudioEffectParameters, Agora does not recommend you to call the following methods, otherwise the effect set by setAudioEffectParameters will be overwritten: setAudioEffectPreset setVoiceBeautifierPreset setLocalVoicePitch setLocalVoiceEqualization setLocalVoiceReverb setVoiceBeautifierParameters setVoiceConversionPreset
  ///
  /// * [preset] The options for SDK preset audio effects: roomAcoustics3dVoice, 3D voice effect:
  ///  You need to set the profile parameter in setAudioProfile to audioProfileMusicStandardStereo (3) or audioProfileMusicHighQualityStereo (5) before setting this enumerator; otherwise, the enumerator setting does not take effect.
  ///  If the 3D voice effect is enabled, users need to use stereo audio playback devices to hear the anticipated voice effect. pitchCorrection, Pitch correction effect:
  /// * [param1] If you set preset to roomAcoustics3dVoice, param1 sets the cycle period of the 3D voice effect. The value range is [1,60] and the unit is seconds. The default value is 10, indicating that the voice moves around you every 10 seconds.
  ///  If you set preset to pitchCorrection, param1 indicates the basic mode of the pitch correction effect: 1 : (Default) Natural major scale. 2 : Natural minor scale. 3 : Japanese pentatonic scale.
  /// * [param2] If you set preset to roomAcoustics3dVoice , you need to set param2 to 0.
  ///  If you set preset to pitchCorrection, param2 indicates the tonic pitch of the pitch correction effect: 1 : A 2 : A# 3 : B 4 : (Default) C 5 : C# 6 : D 7 : D# 8 : E 9 : F 10 : F# 11 : G 12 : G#
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setAudioEffectParameters(
      {required AudioEffectPreset preset,
      required int param1,
      required int param2});

  /// Sets parameters for the preset voice beautifier effects.
  ///
  /// To achieve better vocal effects, it is recommended that you call the following APIs before calling this method:
  ///  Call setAudioScenario to set the audio scenario to high-quality audio scenario, namely audioScenarioGameStreaming (3).
  ///  Call setAudioProfile to set the profile parameter to audioProfileMusicHighQuality (4) or audioProfileMusicHighQualityStereo (5). Call this method to set a gender characteristic and a reverberation effect for the singing beautifier effect. This method sets parameters for the local user who sends an audio stream. After setting the audio parameters, all users in the channel can hear the effect.
  ///  Do not set the profile parameter in setAudioProfile to audioProfileSpeechStandard (1) or audioProfileIot (6), or the method does not take effect.
  ///  You can call this method either before or after joining a channel.
  ///  This method has the best effect on human voice processing, and Agora does not recommend calling this method to process audio data containing music.
  ///  After calling setVoiceBeautifierParameters, Agora does not recommend calling the following methods, otherwise the effect set by setVoiceBeautifierParameters will be overwritten: setAudioEffectPreset setAudioEffectParameters setVoiceBeautifierPreset setLocalVoicePitch setLocalVoiceEqualization setLocalVoiceReverb setVoiceConversionPreset
  ///
  /// * [preset] The option for the preset audio effect: SINGING_BEAUTIFIER : The singing beautifier effect.
  /// * [param1] The gender characteristics options for the singing voice: 1 : A male-sounding voice. 2 : A female-sounding voice.
  /// * [param2] The reverberation effect options for the singing voice: 1 : The reverberation effect sounds like singing in a small room. 2 : The reverberation effect sounds like singing in a large room. 3 : The reverberation effect sounds like singing in a hall.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
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
  ///
  /// You can call this method either before or after joining a channel.
  ///
  /// * [pitch] The local voice pitch. The value range is [0.5,2.0]. The lower the value, the lower the pitch. The default value is 1.0 (no change to the pitch).
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setLocalVoicePitch(double pitch);

  /// Set the formant ratio to change the timbre of human voice.
  ///
  /// Formant ratio affects the timbre of voice. The smaller the value, the deeper the sound will be, and the larger, the sharper. You can call this method to set the formant ratio of local audio to change the timbre of human voice. After you set the formant ratio, all users in the channel can hear the changed voice. If you want to change the timbre and pitch of voice at the same time, Agora recommends using this method together with setLocalVoicePitch. You can call this method either before or after joining a channel.
  ///
  /// * [formantRatio] The formant ratio. The value range is [-1.0, 1.0]. The default value is 0.0, which means do not change the timbre of the voice. Agora recommends setting this value within the range of [-0.4, 0.6]. Otherwise, the voice may be seriously distorted.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setLocalVoiceFormant(double formantRatio);

  /// Sets the local voice equalization effect.
  ///
  /// You can call this method either before or after joining a channel.
  ///
  /// * [bandFrequency] The band frequency. The value ranges between 0 and 9; representing the respective 10-band center frequencies of the voice effects, including 31, 62, 125, 250, 500, 1k, 2k, 4k, 8k, and 16k Hz. See AudioEqualizationBandFrequency.
  /// * [bandGain] The gain of each band in dB. The value ranges between -15 and 15. The default value is 0.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setLocalVoiceEqualization(
      {required AudioEqualizationBandFrequency bandFrequency,
      required int bandGain});

  /// Sets the local voice reverberation.
  ///
  /// The SDK provides an easier-to-use method, setAudioEffectPreset, to directly implement preset reverb effects for such as pop, R&B, and KTV. You can call this method either before or after joining a channel.
  ///
  /// * [reverbKey] The reverberation key. Agora provides five reverberation keys, see AudioReverbType.
  /// * [value] The value of the reverberation key.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setLocalVoiceReverb(
      {required AudioReverbType reverbKey, required int value});

  /// Sets the preset headphone equalization effect.
  ///
  /// This method is mainly used in spatial audio effect scenarios. You can select the preset headphone equalizer to listen to the audio to achieve the expected audio experience. If the headphones you use already have a good equalization effect, you may not get a significant improvement when you call this method, and could even diminish the experience.
  ///
  /// * [preset] The preset headphone equalization effect. See HeadphoneEqualizerPreset.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setHeadphoneEQPreset(HeadphoneEqualizerPreset preset);

  /// Sets the low- and high-frequency parameters of the headphone equalizer.
  ///
  /// In a spatial audio effect scenario, if the preset headphone equalization effect is not achieved after calling the setHeadphoneEQPreset method, you can further adjust the headphone equalization effect by calling this method.
  ///
  /// * [lowGain] The low-frequency parameters of the headphone equalizer. The value range is [-10,10]. The larger the value, the deeper the sound.
  /// * [highGain] The high-frequency parameters of the headphone equalizer. The value range is [-10,10]. The larger the value, the sharper the sound.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setHeadphoneEQParameters(
      {required int lowGain, required int highGain});

  /// Sets the log file.
  ///
  /// Deprecated: Use the mLogConfig parameter in initialize method instead. Specifies an SDK output log file. The log file records all log data for the SDK’s operation. Ensure that the directory for the log file exists and is writable. Ensure that you call initialize immediately after calling the RtcEngine method, or the output log may not be complete.
  ///
  /// * [filePath] The complete path of the log files. These log files are encoded in UTF-8.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setLogFile(String filePath);

  /// Sets the log output level of the SDK.
  ///
  /// Deprecated: Use logConfig in initialize instead. This method sets the output log level of the SDK. You can use one or a combination of the log filter levels. The log level follows the sequence of logFilterOff, logFilterCritical, logFilterError, logFilterWarn, logFilterInfo, and logFilterDebug. Choose a level to see the logs preceding that level. If, for example, you set the log level to logFilterWarn, you see the logs within levels logFilterCritical, logFilterError and logFilterWarn.
  ///
  /// * [filter] The output log level of the SDK. See LogFilterType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setLogFilter(LogFilterType filter);

  /// Sets the output log level of the SDK.
  ///
  /// Deprecated: This method is deprecated. Use RtcEngineContext instead to set the log output level. Choose a level to see the logs preceding that level.
  ///
  /// * [level] The log level: LogLevel.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setLogLevel(LogLevel level);

  /// Sets the log file size.
  ///
  /// Deprecated: Use the logConfig parameter in initialize instead. By default, the SDK generates five SDK log files and five API call log files with the following rules:
  ///  The SDK log files are: agorasdk.log, agorasdk.1.log, agorasdk.2.log, agorasdk.3.log, and agorasdk.4.log.
  ///  The API call log files are: agoraapi.log, agoraapi.1.log, agoraapi.2.log, agoraapi.3.log, and agoraapi.4.log.
  ///  The default size of each SDK log file and API log file is 2,048 KB. These log files are encoded in UTF-8.
  ///  The SDK writes the latest logs in agorasdk.log or agoraapi.log.
  ///  When agorasdk.log is full, the SDK processes the log files in the following order:
  ///  Delete the agorasdk.4.log file (if any).
  ///  Rename agorasdk.3.log to agorasdk.4.log.
  ///  Rename agorasdk.2.log to agorasdk.3.log.
  ///  Rename agorasdk.1.log to agorasdk.2.log.
  ///  Create a new agorasdk.log file.
  ///  The overwrite rules for the agoraapi.log file are the same as for agorasdk.log. This method is used to set the size of the agorasdk.log file only and does not effect the agoraapi.log file.
  ///
  /// * [fileSizeInKBytes] The size (KB) of an agorasdk.log file. The value range is [128,20480]. The default value is 2,048 KB. If you set fileSizeInKByte smaller than 128 KB, the SDK automatically adjusts it to 128 KB; if you set fileSizeInKByte greater than 20,480 KB, the SDK automatically adjusts it to 20,480 KB.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setLogFileSize(int fileSizeInKBytes);

  /// @nodoc
  Future<String> uploadLogFile();

  /// @nodoc
  Future<void> writeLog({required LogLevel level, required String fmt});

  /// Updates the display mode of the local video view.
  ///
  /// After initializing the local video view, you can call this method to update its rendering and mirror modes. It affects only the video view that the local user sees, not the published local video stream.
  ///  Ensure that you have called the setupLocalVideo method to initialize the local video view before calling this method.
  ///  During a call, you can call this method as many times as necessary to update the display mode of the local video view.
  ///  This method only takes effect on the primary camera (primaryCameraSource). In scenarios involving custom video capture or the use of alternative video sources, you need to use setupLocalVideo instead of this method.
  ///
  /// * [renderMode] The local video display mode. See RenderModeType.
  /// * [mirrorMode] The mirror mode of the local video view. See VideoMirrorModeType. If you use a front camera, the SDK enables the mirror mode by default; if you use a rear camera, the SDK disables the mirror mode by default.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setLocalRenderMode(
      {required RenderModeType renderMode,
      VideoMirrorModeType mirrorMode =
          VideoMirrorModeType.videoMirrorModeAuto});

  /// Updates the display mode of the video view of a remote user.
  ///
  /// After initializing the video view of a remote user, you can call this method to update its rendering and mirror modes. This method affects only the video view that the local user sees.
  ///  Call this method after initializing the remote view by calling the setupRemoteVideo method.
  ///  During a call, you can call this method as many times as necessary to update the display mode of the video view of a remote user.
  ///
  /// * [uid] The user ID of the remote user.
  /// * [renderMode] The rendering mode of the remote user view.
  /// * [mirrorMode] The mirror mode of the remote user view. See VideoMirrorModeType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: Failure.
  Future<void> setRemoteRenderMode(
      {required int uid,
      required RenderModeType renderMode,
      required VideoMirrorModeType mirrorMode});

  /// Sets the local video mirror mode.
  ///
  /// Deprecated: This method is deprecated. Use setupLocalVideo or setLocalRenderMode instead.
  ///
  /// * [mirrorMode] The local video mirror mode. See VideoMirrorModeType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setLocalVideoMirrorMode(VideoMirrorModeType mirrorMode);

  /// Sets the dual-stream mode on the sender side and the low-quality video stream.
  ///
  /// Deprecated: This method is deprecated as of v4.2.0. Use setDualStreamMode instead. You can call this method to enable or disable the dual-stream mode on the publisher side. Dual streams are a pairing of a high-quality video stream and a low-quality video stream:
  ///  High-quality video stream: High bitrate, high resolution.
  ///  Low-quality video stream: Low bitrate, low resolution. After you enable dual-stream mode, you can call setRemoteVideoStreamType to choose to receive either the high-quality video stream or the low-quality video stream on the subscriber side.
  ///  This method is applicable to all types of streams from the sender, including but not limited to video streams collected from cameras, screen sharing streams, and custom-collected video streams.
  ///  If you need to enable dual video streams in a multi-channel scenario, you can call the enableDualStreamModeEx method.
  ///  You can call this method either before or after joining a channel.
  ///
  /// * [enabled] Whether to enable dual-stream mode: true : Enable dual-stream mode. false : (Default) Disable dual-stream mode.
  /// * [streamConfig] The configuration of the low-quality video stream. See SimulcastStreamConfig. When setting mode to disableSimulcastStream, setting streamConfig will not take effect.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> enableDualStreamMode(
      {required bool enabled, SimulcastStreamConfig? streamConfig});

  /// Sets dual-stream mode configuration on the sender side.
  ///
  /// The SDK defaults to enabling low-quality video stream adaptive mode (autoSimulcastStream) on the sender side, which means the sender does not actively send low-quality video stream. The receiving end with the role of the host can initiate a low-quality video stream request by calling setRemoteVideoStreamType, and upon receiving the request, the sending end automatically starts sending low-quality stream.
  ///  If you want to modify this behavior, you can call this method and set mode to disableSimulcastStream (never send low-quality video streams) or enableSimulcastStream (always send low-quality video streams).
  ///  If you want to restore the default behavior after making changes, you can call this method again with mode set to autoSimulcastStream. The difference and connection between this method and enableDualStreamMode is as follows:
  ///  When calling this method and setting mode to disableSimulcastStream, it has the same effect as calling enableDualStreamMode and setting enabled to false.
  ///  When calling this method and setting mode to enableSimulcastStream, it has the same effect as calling enableDualStreamMode and setting enabled to true.
  ///  Both methods can be called before and after joining a channel. If both methods are used, the settings in the method called later takes precedence.
  ///
  /// * [mode] The mode in which the video stream is sent. See SimulcastStreamMode.
  /// * [streamConfig] The configuration of the low-quality video stream. See SimulcastStreamConfig. When setting mode to disableSimulcastStream, setting streamConfig will not take effect.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setDualStreamMode(
      {required SimulcastStreamMode mode, SimulcastStreamConfig? streamConfig});

  /// Sets whether to enable the local playback of external audio source.
  ///
  /// Ensure you have called the createCustomAudioTrack method to create a custom audio track before calling this method. After calling this method to enable the local playback of external audio source, if you need to stop local playback, you can call this method again and set enabled to false. You can call adjustCustomAudioPlayoutVolume to adjust the local playback volume of the custom audio track.
  ///
  /// * [trackId] The audio track ID. Set this parameter to the custom audio track ID returned in createCustomAudioTrack.
  /// * [enabled] Whether to play the external audio source: true : Play the external audio source. false : (Default) Do not play the external source.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> enableCustomAudioLocalPlayback(
      {required int trackId, required bool enabled});

  /// Sets the format of the captured raw audio data.
  ///
  /// Sets the audio format for the onRecordAudioFrame callback.
  ///  Ensure that you call this method before joining a channel.
  ///  The SDK calculates the sampling interval based on the samplesPerCall, sampleRate and channel parameters set in this method. Sample interval (sec) = samplePerCall /(sampleRate × channel). Ensure that the sample interval ≥ 0.01 (s).
  ///
  /// * [sampleRate] The sample rate returned in the onRecordAudioFrame callback, which can be set as 8000, 16000, 32000, 44100, or 48000 Hz.
  /// * [channel] The number of channels returned in the onRecordAudioFrame callback:
  ///  1: Mono.
  ///  2: Stereo.
  /// * [mode] The use mode of the audio frame. See RawAudioFrameOpModeType.
  /// * [samplesPerCall] The number of data samples returned in the onRecordAudioFrame callback, such as 1024 for the Media Push.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: Failure.
  Future<void> setRecordingAudioFrameParameters(
      {required int sampleRate,
      required int channel,
      required RawAudioFrameOpModeType mode,
      required int samplesPerCall});

  /// Sets the audio data format for playback.
  ///
  /// Sets the data format for the onPlaybackAudioFrame callback.
  ///  Ensure that you call this method before joining a channel.
  ///  The SDK calculates the sampling interval based on the samplesPerCall, sampleRate and channel parameters set in this method. Sample interval (sec) = samplePerCall /(sampleRate × channel). Ensure that the sample interval ≥ 0.01 (s). The SDK triggers the onPlaybackAudioFrame callback according to the sampling interval.
  ///
  /// * [sampleRate] The sample rate returned in the onPlaybackAudioFrame callback, which can be set as 8000, 16000, 32000, 44100, or 48000 Hz.
  /// * [channel] The number of channels returned in the onPlaybackAudioFrame callback:
  ///  1: Mono.
  ///  2: Stereo.
  /// * [mode] The use mode of the audio frame. See RawAudioFrameOpModeType.
  /// * [samplesPerCall] The number of data samples returned in the onPlaybackAudioFrame callback, such as 1024 for the Media Push.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: Failure.
  Future<void> setPlaybackAudioFrameParameters(
      {required int sampleRate,
      required int channel,
      required RawAudioFrameOpModeType mode,
      required int samplesPerCall});

  /// Sets the audio data format reported by onMixedAudioFrame.
  ///
  /// * [sampleRate] The sample rate (Hz) of the audio data, which can be set as 8000, 16000, 32000, 44100, or 48000.
  /// * [channel] The number of channels of the audio data, which can be set as 1(Mono) or 2(Stereo).
  /// * [samplesPerCall] Sets the number of samples. In Media Push scenarios, set it as 1024.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setMixedAudioFrameParameters(
      {required int sampleRate,
      required int channel,
      required int samplesPerCall});

  /// Sets the format of the in-ear monitoring raw audio data.
  ///
  /// This method is used to set the in-ear monitoring audio data format reported by the onEarMonitoringAudioFrame callback.
  ///  Before calling this method, you need to call enableInEarMonitoring, and set includeAudioFilters to earMonitoringFilterBuiltInAudioFilters or earMonitoringFilterNoiseSuppression.
  ///  The SDK calculates the sampling interval based on the samplesPerCall, sampleRate and channel parameters set in this method. Sample interval (sec) = samplePerCall /(sampleRate × channel). Ensure that the sample interval ≥ 0.01 (s). The SDK triggers the onEarMonitoringAudioFrame callback according to the sampling interval.
  ///
  /// * [sampleRate] The sample rate of the audio data reported in the onEarMonitoringAudioFrame callback, which can be set as 8,000, 16,000, 32,000, 44,100, or 48,000 Hz.
  /// * [channel] The number of audio channels reported in the onEarMonitoringAudioFrame callback.
  ///  1: Mono.
  ///  2: Stereo.
  /// * [mode] The use mode of the audio frame. See RawAudioFrameOpModeType.
  /// * [samplesPerCall] The number of data samples reported in the onEarMonitoringAudioFrame callback, such as 1,024 for the Media Push.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: Failure.
  Future<void> setEarMonitoringAudioFrameParameters(
      {required int sampleRate,
      required int channel,
      required RawAudioFrameOpModeType mode,
      required int samplesPerCall});

  /// Sets the audio data format reported by onPlaybackAudioFrameBeforeMixing.
  ///
  /// * [sampleRate] The sample rate (Hz) of the audio data, which can be set as 8000, 16000, 32000, 44100, or 48000.
  /// * [channel] The number of channels of the audio data, which can be set as 1 (Mono) or 2 (Stereo).
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setPlaybackAudioFrameBeforeMixingParameters(
      {required int sampleRate, required int channel});

  /// Turns on audio spectrum monitoring.
  ///
  /// If you want to obtain the audio spectrum data of local or remote users, you can register the audio spectrum observer and enable audio spectrum monitoring. You can call this method either before or after joining a channel.
  ///
  /// * [intervalInMS] The interval (in milliseconds) at which the SDK triggers the onLocalAudioSpectrum and onRemoteAudioSpectrum callbacks. The default value is 100. Do not set this parameter to a value less than 10, otherwise calling this method would fail.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> enableAudioSpectrumMonitor({int intervalInMS = 100});

  /// Disables audio spectrum monitoring.
  ///
  /// After calling enableAudioSpectrumMonitor, if you want to disable audio spectrum monitoring, you can call this method. You can call this method either before or after joining a channel.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> disableAudioSpectrumMonitor();

  /// Register an audio spectrum observer.
  ///
  /// After successfully registering the audio spectrum observer and calling enableAudioSpectrumMonitor to enable the audio spectrum monitoring, the SDK reports the callback that you implement in the AudioSpectrumObserver class according to the time interval you set. You can call this method either before or after joining a channel.
  ///
  /// * [observer] The audio spectrum observer. See AudioSpectrumObserver.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  void registerAudioSpectrumObserver(AudioSpectrumObserver observer);

  /// Unregisters the audio spectrum observer.
  ///
  /// After calling registerAudioSpectrumObserver, if you want to disable audio spectrum monitoring, you can call this method. You can call this method either before or after joining a channel.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  void unregisterAudioSpectrumObserver(AudioSpectrumObserver observer);

  /// Adjusts the capturing signal volume.
  ///
  /// If you only need to mute the audio signal, Agora recommends that you use muteRecordingSignal instead.
  ///
  /// * [volume] The volume of the user. The value range is [0,400].
  ///  0: Mute.
  ///  100: (Default) The original volume.
  ///  400: Four times the original volume (amplifying the audio signals by four times).
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> adjustRecordingSignalVolume(int volume);

  /// Whether to mute the recording signal.
  ///
  /// * [mute] true : The media file is muted. false : (Default) Do not mute the recording signal. If you have already called adjustRecordingSignalVolume to adjust the volume, then when you call this method and set it to true, the SDK will record the current volume and mute it. To restore the previous volume, call this method again and set it to false.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> muteRecordingSignal(bool mute);

  /// Adjusts the playback signal volume of all remote users.
  ///
  /// This method is used to adjust the signal volume of all remote users mixed and played locally. If you need to adjust the signal volume of a specified remote user played locally, it is recommended that you call adjustUserPlaybackSignalVolume instead.
  ///
  /// * [volume] The volume of the user. The value range is [0,400].
  ///  0: Mute.
  ///  100: (Default) The original volume.
  ///  400: Four times the original volume (amplifying the audio signals by four times).
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> adjustPlaybackSignalVolume(int volume);

  /// Adjusts the playback signal volume of a specified remote user.
  ///
  /// You can call this method to adjust the playback volume of a specified remote user. To adjust the playback volume of different remote users, call the method as many times, once for each remote user.
  ///
  /// * [uid] The user ID of the remote user.
  /// * [volume] The volume of the user. The value range is [0,400].
  ///  0: Mute.
  ///  100: (Default) The original volume.
  ///  400: Four times the original volume (amplifying the audio signals by four times).
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> adjustUserPlaybackSignalVolume(
      {required int uid, required int volume});

  /// @nodoc
  Future<void> setLocalPublishFallbackOption(StreamFallbackOptions option);

  /// Sets the fallback option for the subscribed video stream based on the network conditions.
  ///
  /// An unstable network affects the audio and video quality in a video call or interactive live video streaming. If option is set as streamFallbackOptionVideoStreamLow or streamFallbackOptionAudioOnly, the SDK automatically switches the video from a high-quality stream to a low-quality stream or disables the video when the downlink network conditions cannot support both audio and video to guarantee the quality of the audio. Meanwhile, the SDK continuously monitors network quality and resumes subscribing to audio and video streams when the network quality improves. When the subscribed video stream falls back to an audio-only stream, or recovers from an audio-only stream to an audio-video stream, the SDK triggers the onRemoteSubscribeFallbackToAudioOnly callback. Ensure that you call this method before joining a channel.
  ///
  /// * [option] Fallback options for the subscribed stream. See StreamFallbackOptions.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setRemoteSubscribeFallbackOption(StreamFallbackOptions option);

  /// @nodoc
  Future<void> setHighPriorityUserList(
      {required List<int> uidList,
      required int uidNum,
      required StreamFallbackOptions option});

  /// Enables or disables extensions.
  ///
  /// * [provider] The name of the extension provider.
  /// * [extension] The name of the extension.
  /// * [enable] Whether to enable the extension: true : Enable the extension. false : Disable the extension.
  /// * [type] Source type of the extension. See MediaSourceType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> enableExtension(
      {required String provider,
      required String extension,
      bool enable = true,
      MediaSourceType type = MediaSourceType.unknownMediaSource});

  /// Sets the properties of the extension.
  ///
  /// After enabling the extension, you can call this method to set the properties of the extension.
  ///
  /// * [provider] The name of the extension provider.
  /// * [extension] The name of the extension.
  /// * [key] The key of the extension.
  /// * [value] The value of the extension key.
  /// * [type] Source type of the extension. See MediaSourceType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
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
  /// * [bufLen] Maximum length of the JSON string indicating the extension property. The maximum value is 512 bytes.
  /// * [type] Source type of the extension. See MediaSourceType.
  ///
  /// Returns
  /// The extension information, if the method call succeeds.
  ///  An empty string, if the method call fails.
  Future<String> getExtensionProperty(
      {required String provider,
      required String extension,
      required String key,
      required int bufLen,
      MediaSourceType type = MediaSourceType.unknownMediaSource});

  /// Enables loopback audio capturing.
  ///
  /// If you enable loopback audio capturing, the output of the sound card is mixed into the audio stream sent to the other end.
  ///  This method applies to the macOS and Windows only.
  ///  macOS does not support loopback audio capture of the default sound card. If you need to use this function, use a virtual sound card and pass its name to the deviceName parameter. Agora recommends using AgoraALD as the virtual sound card for audio capturing.
  ///  You can call this method either before or after joining a channel.
  ///  If you call the disableAudio method to disable the audio module, audio capturing will be disabled as well. If you need to enable audio capturing, call the enableAudio method to enable the audio module and then call the enableLoopbackRecording method.
  ///
  /// * [enabled] Sets whether to enable loopback audio capturing. true : Enable loopback audio capturing. false : (Default) Disable loopback audio capturing.
  /// * [deviceName] macOS: The device name of the virtual sound card. The default value is set to NULL, which means using AgoraALD for loopback audio capturing.
  ///  Windows: The device name of the sound card. The default is set to NULL, which means the SDK uses the sound card of your device for loopback audio capturing.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> enableLoopbackRecording(
      {required bool enabled, String? deviceName});

  /// Adjusts the volume of the signal captured by the sound card.
  ///
  /// After calling enableLoopbackRecording to enable loopback audio capturing, you can call this method to adjust the volume of the signal captured by the sound card.
  ///
  /// * [volume] Audio mixing volume. The value ranges between 0 and 100. The default value is 100, which means the original volume.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: Failure.
  Future<void> adjustLoopbackSignalVolume(int volume);

  /// @nodoc
  Future<int> getLoopbackRecordingVolume();

  /// Enables in-ear monitoring.
  ///
  /// This method enables or disables in-ear monitoring.
  ///  Users must use earphones (wired or Bluetooth) to hear the in-ear monitoring effect.
  ///  You can call this method either before or after joining a channel.
  ///
  /// * [enabled] Enables or disables in-ear monitoring. true : Enables in-ear monitoring. false : (Default) Disables in-ear monitoring.
  /// * [includeAudioFilters] The audio filter types of in-ear monitoring. See EarMonitoringFilterType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: Failure.
  ///  - 8: Make sure the current audio routing is Bluetooth or headset.
  Future<void> enableInEarMonitoring(
      {required bool enabled,
      required EarMonitoringFilterType includeAudioFilters});

  /// Sets the volume of the in-ear monitor.
  ///
  /// * [volume] The volume of the user. The value range is [0,400].
  ///  0: Mute.
  ///  100: (Default) The original volume.
  ///  400: Four times the original volume (amplifying the audio signals by four times).
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setInEarMonitoringVolume(int volume);

  /// Loads an extension.
  ///
  /// This method is used to add extensions external to the SDK (such as those from Extensions Marketplace and SDK extensions) to the SDK.
  ///
  /// * [path] The extension library path and name. For example: /library/libagora_segmentation_extension.dll.
  /// * [unloadAfterUse] Whether to uninstall the current extension when you no longer using it: true : Uninstall the extension when the RtcEngine is destroyed. false : (Rcommended) Do not uninstall the extension until the process terminates.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> loadExtensionProvider(
      {required String path, bool unloadAfterUse = false});

  /// Sets the properties of the extension provider.
  ///
  /// You can call this method to set the attributes of the extension provider and initialize the relevant parameters according to the type of the provider.
  ///
  /// * [provider] The name of the extension provider.
  /// * [key] The key of the extension.
  /// * [value] The value of the extension key.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setExtensionProviderProperty(
      {required String provider, required String key, required String value});

  /// Registers an extension.
  ///
  /// For extensions external to the SDK (such as those from Extensions Marketplace and SDK Extensions), you need to load them before calling this method. Extensions internal to the SDK (those included in the full SDK package) are automatically loaded and registered after the initialization of RtcEngine.
  ///
  /// * [provider] The name of the extension provider.
  /// * [extension] The name of the extension.
  /// * [type] Source type of the extension. See MediaSourceType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> registerExtension(
      {required String provider,
      required String extension,
      MediaSourceType type = MediaSourceType.unknownMediaSource});

  /// Sets the camera capture configuration.
  ///
  /// This method is for Android and iOS only.
  ///  Call this method before enabling local camera capture, such as before calling startPreview and joinChannel.
  ///  To adjust the camera focal length configuration, It is recommended to call queryCameraFocalLengthCapability first to check the device's focal length capabilities, and then configure based on the query results.
  ///  Due to limitations on some Android devices, even if you set the focal length type according to the results returned in queryCameraFocalLengthCapability, the settings may not take effect.
  ///
  /// * [config] The camera capture configuration. See CameraCapturerConfiguration. In this method, you do not need to set the deviceId parameter.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: Failure.
  Future<void> setCameraCapturerConfiguration(
      CameraCapturerConfiguration config);

  /// Creates a custom video track.
  ///
  /// To publish a custom video source, see the following steps:
  ///  Call this method to create a video track and get the video track ID.
  ///  Call joinChannel to join the channel. In ChannelMediaOptions, set customVideoTrackId to the video track ID that you want to publish, and set publishCustomVideoTrack to true.
  ///  Call pushVideoFrame and specify videoTrackId as the video track ID set in step 2. You can then publish the corresponding custom video source in the channel.
  ///
  /// Returns
  /// If the method call is successful, the video track ID is returned as the unique identifier of the video track.
  ///  If the method call fails, a negative value is returned.
  Future<int> createCustomVideoTrack();

  /// @nodoc
  Future<int> createCustomEncodedVideoTrack(SenderOptions senderOption);

  /// Destroys the specified video track.
  ///
  /// * [videoTrackId] The video track ID returned by calling the createCustomVideoTrack method.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> destroyCustomVideoTrack(int videoTrackId);

  /// @nodoc
  Future<void> destroyCustomEncodedVideoTrack(int videoTrackId);

  /// Switches between front and rear cameras.
  ///
  /// You can call this method to dynamically switch cameras based on the actual camera availability during the app's runtime, without having to restart the video stream or reconfigure the video source.
  ///  This method is for Android and iOS only.
  ///  This method must be called after the camera is successfully enabled, that is, after the SDK triggers the onLocalVideoStateChanged callback and returns the local video state as localVideoStreamStateCapturing (1).
  ///  This method only switches the camera for the video stream captured by the first camera, that is, the video source set to videoSourceCamera (0) when calling startCameraCapture.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> switchCamera();

  /// Checks whether the device supports camera zoom.
  ///
  /// This method must be called after the camera is successfully enabled, that is, after the SDK triggers the onLocalVideoStateChanged callback and returns the local video state as localVideoStreamStateCapturing (1).
  ///  This method is for Android and iOS only.
  ///
  /// Returns
  /// true : The device supports camera zoom. false : The device does not support camera zoom.
  Future<bool> isCameraZoomSupported();

  /// Checks whether the device camera supports face detection.
  ///
  /// This method must be called after the camera is successfully enabled, that is, after the SDK triggers the onLocalVideoStateChanged callback and returns the local video state as localVideoStreamStateCapturing (1).
  ///  This method is for Android and iOS only.
  ///
  /// Returns
  /// true : The device camera supports face detection. false : The device camera does not support face detection.
  Future<bool> isCameraFaceDetectSupported();

  /// Checks whether the device supports camera flash.
  ///
  /// This method must be called after the camera is successfully enabled, that is, after the SDK triggers the onLocalVideoStateChanged callback and returns the local video state as localVideoStreamStateCapturing (1).
  ///  This method is for Android and iOS only.
  ///  The app enables the front camera by default. If your front camera does not support flash, this method returns false. If you want to check whether the rear camera supports the flash function, call switchCamera before this method.
  ///  On iPads with system version 15, even if isCameraTorchSupported returns true, you might fail to successfully enable the flash by calling setCameraTorchOn due to system issues.
  ///
  /// Returns
  /// true : The device supports camera flash. false : The device does not support camera flash.
  Future<bool> isCameraTorchSupported();

  /// Check whether the device supports the manual focus function.
  ///
  /// This method must be called after the camera is successfully enabled, that is, after the SDK triggers the onLocalVideoStateChanged callback and returns the local video state as localVideoStreamStateCapturing (1).
  ///  This method is for Android and iOS only.
  ///
  /// Returns
  /// true : The device supports the manual focus function. false : The device does not support the manual focus function.
  Future<bool> isCameraFocusSupported();

  /// Checks whether the device supports the face auto-focus function.
  ///
  /// This method must be called after the camera is successfully enabled, that is, after the SDK triggers the onLocalVideoStateChanged callback and returns the local video state as localVideoStreamStateCapturing (1).
  ///  This method is for Android and iOS only.
  ///
  /// Returns
  /// true : The device supports the face auto-focus function. false : The device does not support the face auto-focus function.
  Future<bool> isCameraAutoFocusFaceModeSupported();

  /// Sets the camera zoom factor.
  ///
  /// For iOS devices equipped with multi-lens rear cameras, such as those featuring dual-camera (wide-angle and ultra-wide-angle) or triple-camera (wide-angle, ultra-wide-angle, and telephoto), you can call setCameraCapturerConfiguration first to set the cameraFocalLengthType as cameraFocalLengthDefault (0) (standard lens). Then, adjust the camera zoom factor to a value less than 1.0. This configuration allows you to capture video with an ultra-wide-angle perspective.
  ///  You must call this method after enableVideo. The setting result will take effect after the camera is successfully turned on, that is, after the SDK triggers the onLocalVideoStateChanged callback and returns the local video state as localVideoStreamStateCapturing (1).
  ///  This method is for Android and iOS only.
  ///
  /// * [factor] The camera zoom factor. For devices that do not support ultra-wide-angle, the value ranges from 1.0 to the maximum zoom factor; for devices that support ultra-wide-angle, the value ranges from 0.5 to the maximum zoom factor. You can get the maximum zoom factor supported by the device by calling the getCameraMaxZoomFactor method.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: if the method if failed.
  Future<void> setCameraZoomFactor(double factor);

  /// Enables or disables face detection for the local user.
  ///
  /// You can call this method either before or after joining a channel. This method is for Android and iOS only. Once face detection is enabled, the SDK triggers the onFacePositionChanged callback to report the face information of the local user, which includes the following:
  ///  The width and height of the local video.
  ///  The position of the human face in the local view.
  ///  The distance between the human face and the screen. This method needs to be called after the camera is started (for example, by calling startPreview or enableVideo ).
  ///
  /// * [enabled] Whether to enable face detection for the local user: true : Enable face detection. false : (Default) Disable face detection.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> enableFaceDetection(bool enabled);

  /// Gets the maximum zoom ratio supported by the camera.
  ///
  /// This method must be called after the camera is successfully enabled, that is, after the SDK triggers the onLocalVideoStateChanged callback and returns the local video state as localVideoStreamStateCapturing (1).
  ///  This method is for Android and iOS only.
  ///
  /// Returns
  /// The maximum zoom factor.
  Future<double> getCameraMaxZoomFactor();

  /// Sets the camera manual focus position.
  ///
  /// You must call this method after enableVideo. The setting result will take effect after the camera is successfully turned on, that is, after the SDK triggers the onLocalVideoStateChanged callback and returns the local video state as localVideoStreamStateCapturing (1).
  ///  This method is for Android and iOS only.
  ///  After a successful method call, the SDK triggers the onCameraFocusAreaChanged callback.
  ///
  /// * [positionX] The horizontal coordinate of the touchpoint in the view.
  /// * [positionY] The vertical coordinate of the touchpoint in the view.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setCameraFocusPositionInPreview(
      {required double positionX, required double positionY});

  /// Enables the camera flash.
  ///
  /// You must call this method after enableVideo. The setting result will take effect after the camera is successfully turned on, that is, after the SDK triggers the onLocalVideoStateChanged callback and returns the local video state as localVideoStreamStateCapturing (1).
  ///  This method is for Android and iOS only.
  ///
  /// * [isOn] Whether to turn on the camera flash: true : Turn on the flash. false : (Default) Turn off the flash.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setCameraTorchOn(bool isOn);

  /// Enables the camera auto-face focus function.
  ///
  /// By default, the SDK disables face autofocus on Android and enables face autofocus on iOS. To set face autofocus, call this method.
  ///  You must call this method after enableVideo. The setting result will take effect after the camera is successfully turned on, that is, after the SDK triggers the onLocalVideoStateChanged callback and returns the local video state as localVideoStreamStateCapturing (1).
  ///  This method is for Android and iOS only.
  ///
  /// * [enabled] Whether to enable face autofocus: true : Enable the camera auto-face focus function. false : Disable face autofocus.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setCameraAutoFocusFaceModeEnabled(bool enabled);

  /// Checks whether the device supports manual exposure.
  ///
  /// This method must be called after the camera is successfully enabled, that is, after the SDK triggers the onLocalVideoStateChanged callback and returns the local video state as localVideoStreamStateCapturing (1).
  ///  This method is for Android and iOS only.
  ///
  /// Returns
  /// true : The device supports manual exposure. false : The device does not support manual exposure.
  Future<bool> isCameraExposurePositionSupported();

  /// Sets the camera exposure position.
  ///
  /// You must call this method after enableVideo. The setting result will take effect after the camera is successfully turned on, that is, after the SDK triggers the onLocalVideoStateChanged callback and returns the local video state as localVideoStreamStateCapturing (1).
  ///  This method is for Android and iOS only.
  ///  After a successful method call, the SDK triggers the onCameraExposureAreaChanged callback.
  ///
  /// * [positionXinView] The horizontal coordinate of the touchpoint in the view.
  /// * [positionYinView] The vertical coordinate of the touchpoint in the view.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setCameraExposurePosition(
      {required double positionXinView, required double positionYinView});

  /// Queries whether the current camera supports adjusting exposure value.
  ///
  /// This method is for Android and iOS only.
  ///  This method must be called after the camera is successfully enabled, that is, after the SDK triggers the onLocalVideoStateChanged callback and returns the local video state as localVideoStreamStateCapturing (1).
  ///  Before calling setCameraExposureFactor, Agora recoomends that you call this method to query whether the current camera supports adjusting the exposure value.
  ///  By calling this method, you adjust the exposure value of the currently active camera, that is, the camera specified when calling setCameraCapturerConfiguration.
  ///
  /// Returns
  /// true : Success. false : Failure.
  Future<bool> isCameraExposureSupported();

  /// Sets the camera exposure value.
  ///
  /// Insufficient or excessive lighting in the shooting environment can affect the image quality of video capture. To achieve optimal video quality, you can use this method to adjust the camera's exposure value.
  ///  This method is for Android and iOS only.
  ///  You must call this method after enableVideo. The setting result will take effect after the camera is successfully turned on, that is, after the SDK triggers the onLocalVideoStateChanged callback and returns the local video state as localVideoStreamStateCapturing (1).
  ///  Before calling this method, Agora recommends calling isCameraExposureSupported to check whether the current camera supports adjusting the exposure value.
  ///  By calling this method, you adjust the exposure value of the currently active camera, that is, the camera specified when calling setCameraCapturerConfiguration.
  ///
  /// * [factor] The camera exposure value. The default value is 0, which means using the default exposure of the camera. The larger the value, the greater the exposure. When the video image is overexposed, you can reduce the exposure value; when the video image is underexposed and the dark details are lost, you can increase the exposure value. If the exposure value you specified is beyond the range supported by the device, the SDK will automatically adjust it to the actual supported range of the device. On Android, the value range is [-20.0, 20.0]. On iOS, the value range is [-8.0, 8.0].
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setCameraExposureFactor(double factor);

  /// Checks whether the device supports auto exposure.
  ///
  /// This method must be called after the camera is successfully enabled, that is, after the SDK triggers the onLocalVideoStateChanged callback and returns the local video state as localVideoStreamStateCapturing (1).
  ///  This method applies to iOS only.
  ///
  /// Returns
  /// true : The device supports auto exposure. false : The device does not support auto exposure.
  Future<bool> isCameraAutoExposureFaceModeSupported();

  /// Sets whether to enable auto exposure.
  ///
  /// You must call this method after enableVideo. The setting result will take effect after the camera is successfully turned on, that is, after the SDK triggers the onLocalVideoStateChanged callback and returns the local video state as localVideoStreamStateCapturing (1).
  ///  This method applies to iOS only.
  ///
  /// * [enabled] Whether to enable auto exposure: true : Enable auto exposure. false : Disable auto exposure.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setCameraAutoExposureFaceModeEnabled(bool enabled);

  /// Set the camera stabilization mode.
  ///
  /// This method applies to iOS only. The camera stabilization mode is off by default. You need to call this method to turn it on and set the appropriate stabilization mode.
  ///
  /// * [mode] Camera stabilization mode. See CameraStabilizationMode.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setCameraStabilizationMode(CameraStabilizationMode mode);

  /// Sets the default audio playback route.
  ///
  /// This method is for Android and iOS only.
  ///  Ensure that you call this method before joining a channel. If you need to change the audio route after joining a channel, call setEnableSpeakerphone. Most mobile phones have two audio routes: an earpiece at the top, and a speakerphone at the bottom. The earpiece plays at a lower volume, and the speakerphone at a higher volume. When setting the default audio route, you determine whether audio playback comes through the earpiece or speakerphone when no external audio device is connected. In different scenarios, the default audio routing of the system is also different. See the following:
  ///  Voice call: Earpiece.
  ///  Audio broadcast: Speakerphone.
  ///  Video call: Speakerphone.
  ///  Video broadcast: Speakerphone. You can call this method to change the default audio route. After a successful method call, the SDK triggers the onAudioRoutingChanged callback. The system audio route changes when an external audio device, such as a headphone or a Bluetooth audio device, is connected. See Audio Route for detailed change principles.
  ///
  /// * [defaultToSpeaker] Whether to set the speakerphone as the default audio route: true : Set the speakerphone as the default audio route. false : Set the earpiece as the default audio route.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setDefaultAudioRouteToSpeakerphone(bool defaultToSpeaker);

  /// Enables/Disables the audio route to the speakerphone.
  ///
  /// If the default audio route of the SDK or the setting in setDefaultAudioRouteToSpeakerphone cannot meet your requirements, you can call setEnableSpeakerphone to switch the current audio route. After a successful method call, the SDK triggers the onAudioRoutingChanged callback. For the default audio route in different scenarios, see Audio Route. This method only sets the audio route in the current channel and does not influence the default audio route. If the user leaves the current channel and joins another channel, the default audio route is used.
  ///  This method is for Android and iOS only.
  ///  Call this method after joining a channel.
  ///  If the user uses an external audio playback device such as a Bluetooth or wired headset, this method does not take effect, and the SDK plays audio through the external device. When the user uses multiple external devices, the SDK plays audio through the last connected device.
  ///
  /// * [speakerOn] Sets whether to enable the speakerphone or earpiece: true : Enable device state monitoring. The audio route is the speakerphone. false : Disable device state monitoring. The audio route is the earpiece.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setEnableSpeakerphone(bool speakerOn);

  /// Checks whether the speakerphone is enabled.
  ///
  /// This method is for Android and iOS only.
  ///  You can call this method either before or after joining a channel.
  ///
  /// Returns
  /// true : The speakerphone is enabled, and the audio plays from the speakerphone. false : The speakerphone is not enabled, and the audio plays from devices other than the speakerphone. For example, the headset or earpiece.
  Future<bool> isSpeakerphoneEnabled();

  /// Selects the audio playback route in communication audio mode.
  ///
  /// This method is used to switch the audio route from Bluetooth headphones to earpiece, wired headphones or speakers in communication audio mode (). After the method is called successfully, the SDK will trigger the onAudioRoutingChanged callback to report the modified route.
  ///  This method is for Android only.
  ///  Using this method and the setEnableSpeakerphone method at the same time may cause conflicts. Agora recommends that you use the setRouteInCommunicationMode method alone.
  ///
  /// * [route] The audio playback route you want to use:
  ///  -1: The default audio route.
  ///  0: Headphones with microphone.
  ///  1: Handset.
  ///  2: Headphones without microphone.
  ///  3: Device's built-in speaker.
  ///  4: (Not supported yet) External speakers.
  ///  5: Bluetooth headphones.
  ///  6: USB device.
  ///
  /// Returns
  /// Without practical meaning.
  Future<void> setRouteInCommunicationMode(int route);

  /// Check if the camera supports portrait center stage.
  ///
  /// This method is for iOS and macOS only. Before calling enableCameraCenterStage to enable portrait center stage, it is recommended to call this method to check if the current device supports the feature.
  ///
  /// Returns
  /// true : The current camera supports the portrait center stage. false : The current camera supports the portrait center stage.
  Future<bool> isCameraCenterStageSupported();

  /// Enables or disables portrait center stage.
  ///
  /// The portrait center stage feature is off by default. You need to call this method to turn it on. If you need to disable this feature, you need to call this method again and set enabled to false. This method is for iOS and macOS only.
  ///
  /// * [enabled] Whether to enable the portrait center stage: true : Enable portrait center stage. false : Disable portrait center stage.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> enableCameraCenterStage(bool enabled);

  /// Gets a list of shareable screens and windows.
  ///
  /// You can call this method before sharing a screen or window to get a list of shareable screens and windows, which enables a user to use thumbnails in the list to easily choose a particular screen or window to share. This list also contains important information such as window ID and screen ID, with which you can call startScreenCaptureByWindowId or startScreenCaptureByDisplayId to start the sharing. This method applies to macOS and Windows only.
  ///
  /// * [thumbSize] The target size of the screen or window thumbnail (the width and height are in pixels). The SDK scales the original image to make the length of the longest side of the image the same as that of the target size without distorting the original image. For example, if the original image is 400 × 300 and thumbSize is 100 × 100, the actual size of the thumbnail is 100 × 75. If the target size is larger than the original size, the thumbnail is the original image and the SDK does not scale it.
  /// * [iconSize] The target size of the icon corresponding to the application program (the width and height are in pixels). The SDK scales the original image to make the length of the longest side of the image the same as that of the target size without distorting the original image. For example, if the original image is 400 × 300 and iconSize is 100 × 100, the actual size of the icon is 100 × 75. If the target size is larger than the original size, the icon is the original image and the SDK does not scale it.
  /// * [includeScreen] Whether the SDK returns the screen information in addition to the window information: true : The SDK returns screen and window information. false : The SDK returns window information only.
  ///
  /// Returns
  /// The ScreenCaptureSourceInfo array.
  Future<List<ScreenCaptureSourceInfo>> getScreenCaptureSources(
      {required SIZE thumbSize,
      required SIZE iconSize,
      required bool includeScreen});

  /// Sets the operational permission of the SDK on the audio session.
  ///
  /// The SDK and the app can both configure the audio session by default. If you need to only use the app to configure the audio session, this method restricts the operational permission of the SDK on the audio session. You can call this method either before or after joining a channel. Once you call this method to restrict the operational permission of the SDK on the audio session, the restriction takes effect when the SDK needs to change the audio session.
  ///  This method is only available for iOS platforms.
  ///  This method does not restrict the operational permission of the app on the audio session.
  ///
  /// * [restriction] The operational permission of the SDK on the audio session. See AudioSessionOperationRestriction. This parameter is in bit mask format, and each bit corresponds to a permission.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setAudioSessionOperationRestriction(
      AudioSessionOperationRestriction restriction);

  /// Captures the screen by specifying the display ID.
  ///
  /// Captures the video stream of a screen or a part of the screen area. This method is for Windows and macOS only.
  ///
  /// * [displayId] The display ID of the screen to be shared. For the Windows platform, if you need to simultaneously share two screens (main screen and secondary screen), you can set displayId to -1 when calling this method.
  /// * [regionRect] (Optional) Sets the relative location of the region to the screen. Pass in nil to share the entire screen. See Rectangle.
  /// * [captureParams] Screen sharing configurations. The default video dimension is 1920 x 1080, that is, 2,073,600 pixels. Agora uses the value of this parameter to calculate the charges. See ScreenCaptureParameters.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> startScreenCaptureByDisplayId(
      {required int displayId,
      required Rectangle regionRect,
      required ScreenCaptureParameters captureParams});

  /// Captures the whole or part of a screen by specifying the screen rect.
  ///
  /// You can call this method either before or after joining the channel, with the following differences:
  ///  Call this method before joining a channel, and then call joinChannel to join a channel and set publishScreenTrack or publishSecondaryScreenTrack to true to start screen sharing.
  ///  Call this method after joining a channel, and then call updateChannelMediaOptions to join a channel and set publishScreenTrack or publishSecondaryScreenTrack to true to start screen sharing. Deprecated: This method is deprecated. Use startScreenCaptureByDisplayId instead. Agora strongly recommends using startScreenCaptureByDisplayId if you need to start screen sharing on a device connected to another display. This method shares a screen or part of the screen. You need to specify the area of the screen to be shared. This method applies to Windows only.
  ///
  /// * [screenRect] Sets the relative location of the screen to the virtual screen.
  /// * [regionRect] Sets the relative location of the region to the screen. If you do not set this parameter, the SDK shares the whole screen. See Rectangle. If the specified region overruns the screen, the SDK shares only the region within it; if you set width or height as 0, the SDK shares the whole screen.
  /// * [captureParams] The screen sharing encoding parameters. The default video resolution is 1920 × 1080, that is, 2,073,600 pixels. Agora uses the value of this parameter to calculate the charges. See ScreenCaptureParameters.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> startScreenCaptureByScreenRect(
      {required Rectangle screenRect,
      required Rectangle regionRect,
      required ScreenCaptureParameters captureParams});

  /// Gets the audio device information.
  ///
  /// After calling this method, you can get whether the audio device supports ultra-low-latency capture and playback.
  ///  This method is for Android only.
  ///  You can call this method either before or after joining a channel.
  ///
  /// Returns
  /// The DeviceInfo object that identifies the audio device information.
  ///  Not null: Success.
  ///  Null: Failure.
  Future<DeviceInfo> getAudioDeviceInfo();

  /// Captures the whole or part of a window by specifying the window ID.
  ///
  /// This method captures a window or part of the window. You need to specify the ID of the window to be captured. This method applies to the macOS and Windows only. This method supports window sharing of UWP (Universal Windows Platform) applications. Agora tests the mainstream UWP applications by using the lastest SDK, see details as follows:
  ///
  /// * [windowId] The ID of the window to be shared.
  /// * [regionRect] (Optional) Sets the relative location of the region to the screen. If you do not set this parameter, the SDK shares the whole screen. See Rectangle. If the specified region overruns the window, the SDK shares only the region within it; if you set width or height as 0, the SDK shares the whole window.
  /// * [captureParams] Screen sharing configurations. The default video resolution is 1920 × 1080, that is, 2,073,600 pixels. Agora uses the value of this parameter to calculate the charges. See ScreenCaptureParameters.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> startScreenCaptureByWindowId(
      {required int windowId,
      required Rectangle regionRect,
      required ScreenCaptureParameters captureParams});

  /// Sets the content hint for screen sharing.
  ///
  /// A content hint suggests the type of the content being shared, so that the SDK applies different optimization algorithms to different types of content. If you don't call this method, the default content hint is contentHintNone. You can call this method either before or after you start screen sharing.
  ///
  /// * [contentHint] The content hint for screen sharing. See VideoContentHint.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setScreenCaptureContentHint(VideoContentHint contentHint);

  /// Updates the screen capturing region.
  ///
  /// Call this method after starting screen sharing or window sharing.
  ///
  /// * [regionRect] The relative location of the screen-share area to the screen or window. If you do not set this parameter, the SDK shares the whole screen or window. See Rectangle. If the specified region overruns the screen or window, the SDK shares only the region within it; if you set width or height as 0, the SDK shares the whole screen or window.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> updateScreenCaptureRegion(Rectangle regionRect);

  /// Updates the screen capturing parameters.
  ///
  /// This method is for Windows and macOS only.
  ///  Call this method after starting screen sharing or window sharing.
  ///
  /// * [captureParams] The screen sharing encoding parameters. The default video resolution is 1920 × 1080, that is, 2,073,600 pixels. Agora uses the value of this parameter to calculate the charges. See ScreenCaptureParameters.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> updateScreenCaptureParameters(
      ScreenCaptureParameters captureParams);

  /// Starts screen capture.
  ///
  /// This method is for Android and iOS only.
  ///  The billing for the screen sharing stream is based on the dimensions in ScreenVideoParameters :
  ///  When you do not pass in a value, Agora bills you at 1280 × 720.
  ///  When you pass in a value, Agora bills you at that value. For billing examples, see.
  ///
  /// * [captureParams] The screen sharing encoding parameters. The default video dimension is 1920 x 1080, that is, 2,073,600 pixels. Agora uses the value of this parameter to calculate the charges. See ScreenCaptureParameters2.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> startScreenCapture(ScreenCaptureParameters2 captureParams);

  /// Updates the screen capturing parameters.
  ///
  /// If the system audio is not captured when screen sharing is enabled, and then you want to update the parameter configuration and publish the system audio, you can refer to the following steps:
  ///  Call this method, and set captureAudio to true.
  ///  Call updateChannelMediaOptions, and set publishScreenCaptureAudio to true to publish the audio captured by the screen.
  ///  This method is for Android and iOS only.
  ///  On the iOS platform, screen sharing is only available on iOS 12.0 and later.
  ///
  /// * [captureParams] The screen sharing encoding parameters. The default video resolution is 1920 × 1080, that is, 2,073,600 pixels. Agora uses the value of this parameter to calculate the charges. See ScreenCaptureParameters2.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> updateScreenCapture(ScreenCaptureParameters2 captureParams);

  /// Queries the highest frame rate supported by the device during screen sharing.
  ///
  /// Returns
  /// The highest frame rate supported by the device, if the method is called successfully. See ScreenCaptureFramerateCapability.
  ///  < 0: Failure.
  Future<int> queryScreenCaptureCapability();

  /// Queries the focal length capability supported by the camera.
  ///
  /// If you want to enable the wide-angle or ultra-wide-angle mode for camera capture, it is recommended to start by calling this method to check whether the device supports the required focal length capability. Then, adjust the camera's focal length configuration based on the query result by calling setCameraCapturerConfiguration, ensuring the best camera capture performance. This method is for Android and iOS only.
  ///
  /// Returns
  /// Returns an array of FocalLengthInfo objects, which contain the camera's orientation and focal length type.
  Future<List<FocalLengthInfo>> queryCameraFocalLengthCapability();

  /// Sets the screen sharing scenario.
  ///
  /// When you start screen sharing or window sharing, you can call this method to set the screen sharing scenario. The SDK adjusts the video quality and experience of the sharing according to the scenario. Agora recommends that you call this method before joining a channel.
  ///
  /// * [screenScenario] The screen sharing scenario. See ScreenScenarioType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setScreenCaptureScenario(ScreenScenarioType screenScenario);

  /// Stops screen capture.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> stopScreenCapture();

  /// Retrieves the call ID.
  ///
  /// When a user joins a channel on a client, a callId is generated to identify the call from the client. You can call this method to get the callId parameter, and pass it in when calling methods such as rate and complain. Call this method after joining a channel.
  ///
  /// Returns
  /// The current call ID.
  Future<String> getCallId();

  /// Allows a user to rate a call after the call ends.
  ///
  /// Ensure that you call this method after leaving a channel.
  ///
  /// * [callId] The current call ID. You can get the call ID by calling getCallId.
  /// * [rating] The value is between 1 (the lowest score) and 5 (the highest score).
  /// * [description] A description of the call. The string length should be less than 800 bytes.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> rate(
      {required String callId,
      required int rating,
      required String description});

  /// Allows a user to complain about the call quality after a call ends.
  ///
  /// This method allows users to complain about the quality of the call. Call this method after the user leaves the channel.
  ///
  /// * [callId] The current call ID. You can get the call ID by calling getCallId.
  /// * [description] A description of the call. The string length should be less than 800 bytes.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> complain({required String callId, required String description});

  /// Starts pushing media streams to a CDN without transcoding.
  ///
  /// Call this method after joining a channel.
  ///  Only hosts in the LIVE_BROADCASTING profile can call this method.
  ///  If you want to retry pushing streams after a failed push, make sure to call stopRtmpStream first, then call this method to retry pushing streams; otherwise, the SDK returns the same error code as the last failed push. Agora recommends that you use the server-side Media Push function. You can call this method to push an audio or video stream to the specified CDN address. This method can push media streams to only one CDN address at a time, so if you need to push streams to multiple addresses, call this method multiple times. After you call this method, the SDK triggers the onRtmpStreamingStateChanged callback on the local client to report the state of the streaming.
  ///
  /// * [url] The address of Media Push. The format is RTMP or RTMPS. The character length cannot exceed 1024 bytes. Special characters such as Chinese characters are not supported.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> startRtmpStreamWithoutTranscoding(String url);

  /// Starts Media Push and sets the transcoding configuration.
  ///
  /// Agora recommends that you use the server-side Media Push function. You can call this method to push a live audio-and-video stream to the specified CDN address and set the transcoding configuration. This method can push media streams to only one CDN address at a time, so if you need to push streams to multiple addresses, call this method multiple times. Under one Agora project, the maximum number of concurrent tasks to push media streams is 200 by default. If you need a higher quota, contact. After you call this method, the SDK triggers the onRtmpStreamingStateChanged callback on the local client to report the state of the streaming.
  ///  Call this method after joining a channel.
  ///  Only hosts in the LIVE_BROADCASTING profile can call this method.
  ///  If you want to retry pushing streams after a failed push, make sure to call stopRtmpStream first, then call this method to retry pushing streams; otherwise, the SDK returns the same error code as the last failed push.
  ///
  /// * [url] The address of Media Push. The format is RTMP or RTMPS. The character length cannot exceed 1024 bytes. Special characters such as Chinese characters are not supported.
  /// * [transcoding] The transcoding configuration for Media Push. See LiveTranscoding.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> startRtmpStreamWithTranscoding(
      {required String url, required LiveTranscoding transcoding});

  /// Updates the transcoding configuration.
  ///
  /// Agora recommends that you use the server-side Media Push function. After you start pushing media streams to CDN with transcoding, you can dynamically update the transcoding configuration according to the scenario. The SDK triggers the onTranscodingUpdated callback after the transcoding configuration is updated.
  ///
  /// * [transcoding] The transcoding configuration for Media Push. See LiveTranscoding.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> updateRtmpTranscoding(LiveTranscoding transcoding);

  /// Starts the local video mixing.
  ///
  /// After calling this method, you can merge multiple video streams into one video stream locally. For example, you can merge the video streams captured by the camera, screen sharing, media player, remote video, video files, images, etc. into one video stream, and then publish the mixed video stream to the channel.
  ///
  /// * [config] Configuration of the local video mixing, see LocalTranscoderConfiguration.
  ///  The maximum resolution of each video stream participating in the local video mixing is 4096 × 2160. If this limit is exceeded, video mixing does not take effect.
  ///  The maximum resolution of the mixed video stream is 4096 × 2160.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> startLocalVideoTranscoder(LocalTranscoderConfiguration config);

  /// Updates the local video mixing configuration.
  ///
  /// After calling startLocalVideoTranscoder, call this method if you want to update the local video mixing configuration. If you want to update the video source type used for local video mixing, such as adding a second camera or screen to capture video, you need to call this method after startCameraCapture or startScreenCaptureBySourceType.
  ///
  /// * [config] Configuration of the local video mixing, see LocalTranscoderConfiguration.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> updateLocalTranscoderConfiguration(
      LocalTranscoderConfiguration config);

  /// Stops pushing media streams to a CDN.
  ///
  /// Agora recommends that you use the server-side Media Push function. You can call this method to stop the live stream on the specified CDN address. This method can stop pushing media streams to only one CDN address at a time, so if you need to stop pushing streams to multiple addresses, call this method multiple times. After you call this method, the SDK triggers the onRtmpStreamingStateChanged callback on the local client to report the state of the streaming.
  ///
  /// * [url] The address of Media Push. The format is RTMP or RTMPS. The character length cannot exceed 1024 bytes. Special characters such as Chinese characters are not supported.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> stopRtmpStream(String url);

  /// Stops the local video mixing.
  ///
  /// After calling startLocalVideoTranscoder, call this method if you want to stop the local video mixing.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> stopLocalVideoTranscoder();

  /// Starts camera capture.
  ///
  /// You can call this method to start capturing video from one or more cameras by specifying sourceType. On the iOS platform, if you want to enable multi-camera capture, you need to call enableMultiCamera and set enabled to true before calling this method.
  ///
  /// * [sourceType] The type of the video source. See VideoSourceType.
  ///  On iOS devices, you can capture video from up to 2 cameras, provided the device has multiple cameras or supports external cameras.
  ///  On Android devices, you can capture video from up to 4 cameras, provided the device has multiple cameras or supports external cameras.
  ///  On the desktop platforms, you can capture video from up to 4 cameras.
  /// * [config] The configuration of the video capture. See CameraCapturerConfiguration. On the iOS platform, this parameter has no practical function. Use the config parameter in enableMultiCamera instead to set the video capture configuration.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> startCameraCapture(
      {required VideoSourceType sourceType,
      required CameraCapturerConfiguration config});

  /// Stops camera capture.
  ///
  /// After calling startCameraCapture to start capturing video through one or more cameras, you can call this method and set the sourceType parameter to stop the capture from the specified cameras. On the iOS platform, if you want to disable multi-camera capture, you need to call enableMultiCamera after calling this method and set enabled to false. If you are using the local video mixing function, calling this method can cause the local video mixing to be interrupted.
  ///
  /// * [sourceType] The type of the video source. See VideoSourceType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> stopCameraCapture(VideoSourceType sourceType);

  /// Sets the rotation angle of the captured video.
  ///
  /// This method applies to Windows only.
  ///  You must call this method after enableVideo. The setting result will take effect after the camera is successfully turned on, that is, after the SDK triggers the onLocalVideoStateChanged callback and returns the local video state as localVideoStreamStateCapturing (1).
  ///  When the video capture device does not have the gravity sensing function, you can call this method to manually adjust the rotation angle of the captured video.
  ///
  /// * [type] The video source type. See VideoSourceType.
  /// * [orientation] The clockwise rotation angle. See VideoOrientation.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setCameraDeviceOrientation(
      {required VideoSourceType type, required VideoOrientation orientation});

  /// @nodoc
  Future<void> setScreenCaptureOrientation(
      {required VideoSourceType type, required VideoOrientation orientation});

  /// Gets the current connection state of the SDK.
  ///
  /// You can call this method either before or after joining a channel.
  ///
  /// Returns
  /// The current connection state. See ConnectionStateType.
  Future<ConnectionStateType> getConnectionState();

  /// Adds event handlers
  ///
  /// The SDK uses the RtcEngineEventHandler class to send callbacks to the app. The app inherits the methods of this class to receive these callbacks. All methods in this class have default (empty) implementations. Therefore, apps only need to inherits callbacks according to the scenarios. In the callbacks, avoid time-consuming tasks or calling APIs that can block the thread, such as the sendStreamMessage method. Otherwise, the SDK may not work properly.
  ///
  /// * [eventHandler] Callback events to be added. See RtcEngineEventHandler.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  void registerEventHandler(RtcEngineEventHandler eventHandler);

  /// Removes the specified callback events.
  ///
  /// You can call this method too remove all added callback events.
  ///
  /// * [eventHandler] Callback events to be removed. See RtcEngineEventHandler.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  void unregisterEventHandler(RtcEngineEventHandler eventHandler);

  /// @nodoc
  Future<void> setRemoteUserPriority(
      {required int uid, required PriorityType userPriority});

  /// Sets the built-in encryption mode.
  ///
  /// Deprecated: Use enableEncryption instead. The SDK supports built-in encryption schemes, AES-128-GCM is supported by default. Call this method to use other encryption modes. All users in the same channel must use the same encryption mode and secret. Refer to the information related to the AES encryption algorithm on the differences between the encryption modes. Before calling this method, please call setEncryptionSecret to enable the built-in encryption function.
  ///
  /// * [encryptionMode] The following encryption modes:
  ///  " aes-128-xts ": 128-bit AES encryption, XTS mode.
  ///  " aes-128-ecb ": 128-bit AES encryption, ECB mode.
  ///  " aes-256-xts ": 256-bit AES encryption, XTS mode.
  ///  " sm4-128-ecb ": 128-bit SM4 encryption, ECB mode.
  ///  " aes-128-gcm ": 128-bit AES encryption, GCM mode.
  ///  " aes-256-gcm ": 256-bit AES encryption, GCM mode.
  ///  "": When this parameter is set as null, the encryption mode is set as " aes-128-gcm " by default.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setEncryptionMode(String encryptionMode);

  /// Enables built-in encryption with an encryption password before users join a channel.
  ///
  /// Deprecated: Use enableEncryption instead. Before joining the channel, you need to call this method to set the secret parameter to enable the built-in encryption. All users in the same channel should use the same secret. The secret is automatically cleared once a user leaves the channel. If you do not specify the secret or secret is set as null, the built-in encryption is disabled.
  ///  Do not use this method for Media Push.
  ///  For optimal transmission, ensure that the encrypted data size does not exceed the original data size + 16 bytes. 16 bytes is the maximum padding size for AES encryption.
  ///
  /// * [secret] The encryption password.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setEncryptionSecret(String secret);

  /// Enables or disables the built-in encryption.
  ///
  /// In scenarios requiring high security, Agora recommends calling this method to enable the built-in encryption before joining a channel. All users in the same channel must use the same encryption mode and encryption key. After the user leaves the channel, the SDK automatically disables the built-in encryption. To enable the built-in encryption, call this method before the user joins the channel again. If you enable the built-in encryption, you cannot use the Media Push function.
  ///
  /// * [enabled] Whether to enable built-in encryption: true : Enable the built-in encryption. false : (Default) Disable the built-in encryption.
  /// * [config] Built-in encryption configurations. See EncryptionConfig.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> enableEncryption(
      {required bool enabled, required EncryptionConfig config});

  /// Creates a data stream.
  ///
  /// Creates a data stream. Each user can create up to five data streams in a single channel.
  ///
  /// * [config] The configurations for the data stream. See DataStreamConfig.
  ///
  /// Returns
  /// ID of the created data stream, if the method call succeeds.
  ///  < 0: Failure.
  Future<int> createDataStream(DataStreamConfig config);

  /// Sends data stream messages.
  ///
  /// Sends data stream messages to all users in a channel. The SDK has the following restrictions on this method:
  ///  Up to 30 packets can be sent per second in a channel with each packet having a maximum size of 1 KB.
  ///  Each client can send up to 6 KB of data per second.
  ///  Each user can have up to five data streams simultaneously. A successful method call triggers the onStreamMessage callback on the remote client, from which the remote user gets the stream message. A failed method call triggers the onStreamMessageError callback on the remote client.
  ///  Ensure that you call createDataStream to create a data channel before calling this method.
  ///  In live streaming scenarios, this method only applies to hosts.
  ///
  /// * [streamId] The data stream ID. You can get the data stream ID by calling createDataStream.
  /// * [data] The message to be sent.
  /// * [length] The length of the data.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> sendStreamMessage(
      {required int streamId, required Uint8List data, required int length});

  /// Adds a watermark image to the local video.
  ///
  /// This method adds a PNG watermark image to the local video in the live streaming. Once the watermark image is added, all the audience in the channel (CDN audience included), and the capturing device can see and capture it. The Agora SDK supports adding only one watermark image onto a local video or CDN live stream. The newly added watermark image replaces the previous one. The watermark coordinates are dependent on the settings in the setVideoEncoderConfiguration method:
  ///  If the orientation mode of the encoding video (OrientationMode) is fixed landscape mode or the adaptive landscape mode, the watermark uses the landscape orientation.
  ///  If the orientation mode of the encoding video (OrientationMode) is fixed portrait mode or the adaptive portrait mode, the watermark uses the portrait orientation.
  ///  When setting the watermark position, the region must be less than the dimensions set in the setVideoEncoderConfiguration method; otherwise, the watermark image will be cropped.
  ///  Ensure that calling this method after enableVideo.
  ///  If you only want to add a watermark to the media push, you can call this method or the startRtmpStreamWithTranscoding method.
  ///  This method supports adding a watermark image in the PNG file format only. Supported pixel formats of the PNG image are RGBA, RGB, Palette, Gray, and Alpha_gray.
  ///  If the dimensions of the PNG image differ from your settings in this method, the image will be cropped or zoomed to conform to your settings.
  ///  If you have enabled the mirror mode for the local video, the watermark on the local video is also mirrored. To avoid mirroring the watermark, Agora recommends that you do not use the mirror and watermark functions for the local video at the same time. You can implement the watermark function in your application layer.
  ///
  /// * [watermarkUrl] The local file path of the watermark image to be added. This method supports adding a watermark image from the local absolute or relative file path.
  /// * [options] The options of the watermark image to be added. See WatermarkOptions.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> addVideoWatermark(
      {required String watermarkUrl, required WatermarkOptions options});

  /// Removes the watermark image from the video stream.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> clearVideoWatermarks();

  /// @nodoc
  Future<void> pauseAudio();

  /// @nodoc
  Future<void> resumeAudio();

  /// Enables interoperability with the Agora Web SDK (applicable only in the live streaming scenarios).
  ///
  /// Deprecated: The SDK automatically enables interoperability with the Web SDK, so you no longer need to call this method. You can call this method to enable or disable interoperability with the Agora Web SDK. If a channel has Web SDK users, ensure that you call this method, or the video of the Native user will be a black screen for the Web user. This method is only applicable in live streaming scenarios, and interoperability is enabled by default in communication scenarios.
  ///
  /// * [enabled] Whether to enable interoperability: true : Enable interoperability. false : (Default) Disable interoperability.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> enableWebSdkInteroperability(bool enabled);

  /// Reports customized messages.
  ///
  /// Agora supports reporting and analyzing customized messages. This function is in the beta stage with a free trial. The ability provided in its beta test version is reporting a maximum of 10 message pieces within 6 seconds, with each message piece not exceeding 256 bytes and each string not exceeding 100 bytes. To try out this function, contact and discuss the format of customized messages with us.
  Future<void> sendCustomReportMessage(
      {required String id,
      required String category,
      required String event,
      required String label,
      required int value});

  /// Registers the metadata observer.
  ///
  /// You need to implement the MetadataObserver class and specify the metadata type in this method. This method enables you to add synchronized metadata in the video stream for more diversified
  ///  live interactive streaming, such as sending shopping links, digital coupons, and online quizzes. Call this method before joinChannel.
  ///
  /// * [observer] The metadata observer. See MetadataObserver.
  /// * [type] The metadata type. The SDK currently only supports videoMetadata.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: Failure.
  void registerMediaMetadataObserver(
      {required MetadataObserver observer, required MetadataType type});

  /// Unregisters the specified metadata observer.
  ///
  /// * [observer] The metadata observer. See MetadataObserver.
  /// * [type] The metadata type. The SDK currently only supports videoMetadata.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: Failure.
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

  /// Sets whether to enable the AI ​​noise suppression function and set the noise suppression mode.
  ///
  /// You can call this method to enable AI noise suppression function. Once enabled, the SDK automatically detects and reduces stationary and non-stationary noise from your audio on the premise of ensuring the quality of human voice. Stationary noise refers to noise signal with constant average statistical properties and negligibly small fluctuations of level within the period of observation. Common sources of stationary noises are:
  ///  Television;
  ///  Air conditioner;
  ///  Machinery, etc. Non-stationary noise refers to noise signal with huge fluctuations of level within the period of observation; common sources of non-stationary noises are:
  ///  Thunder;
  ///  Explosion;
  ///  Cracking, etc.
  ///  Agora does not recommend enabling this function on devices running Android 6.0 and below.
  ///
  /// * [enabled] Whether to enable the AI noise suppression function: true : Enable the AI noise suppression. false : (Default) Disable the AI noise suppression.
  /// * [mode] The AI noise suppression modes. See AudioAinsMode.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setAINSMode(
      {required bool enabled, required AudioAinsMode mode});

  /// Registers a user account.
  ///
  /// Once registered, the user account can be used to identify the local user when the user joins the channel. After the registration is successful, the user account can identify the identity of the local user, and the user can use it to join the channel. After the user successfully registers a user account, the SDK triggers the onLocalUserRegistered callback on the local client, reporting the user ID and account of the local user. This method is optional. To join a channel with a user account, you can choose either of the following ways:
  ///  Call registerLocalUserAccount to create a user account, and then call joinChannelWithUserAccount to join the channel.
  ///  Call the joinChannelWithUserAccount method to join the channel. The difference between the two ways is that the time elapsed between calling the registerLocalUserAccount method and joining the channel is shorter than directly calling joinChannelWithUserAccount.
  ///  Ensure that you set the userAccount parameter; otherwise, this method does not take effect.
  ///  Ensure that the userAccount is unique in the channel.
  ///  To ensure smooth communication, use the same parameter type to identify the user. For example, if a user joins the channel with a user ID, then ensure all the other users use the user ID too. The same applies to the user account. If a user joins the channel with the Agora Web SDK, ensure that the ID of the user is set to the same parameter type.
  ///
  /// * [appId] The App ID of your project on Agora Console.
  /// * [userAccount] The user account. This parameter is used to identify the user in the channel for real-time audio and video engagement. You need to set and manage user accounts yourself and ensure that each user account in the same channel is unique. The maximum length of this parameter is 255 bytes. Ensure that you set this parameter and do not set it as NULL. Supported characters are as follow(89 in total):
  ///  The 26 lowercase English letters: a to z.
  ///  The 26 uppercase English letters: A to Z.
  ///  All numeric characters: 0 to 9.
  ///  Space
  ///  "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> registerLocalUserAccount(
      {required String appId, required String userAccount});

  /// Joins the channel with a user account, and configures whether to automatically subscribe to audio or video streams after joining the channel.
  ///
  /// To ensure smooth communication, use the same parameter type to identify the user. For example, if a user joins the channel with a user ID, then ensure all the other users use the user ID too. The same applies to the user account. If a user joins the channel with the Agora Web SDK, ensure that the ID of the user is set to the same parameter type.
  ///  If you choose the Testing Mode (using an App ID for authentication) for your project and call this method to join a channel, you will automatically exit the channel after 24 hours. This method allows a user to join the channel with the user account. After the user successfully joins the channel, the SDK triggers the following callbacks:
  ///  The local client: onLocalUserRegistered, onJoinChannelSuccess and onConnectionStateChanged callbacks.
  ///  The remote client: The onUserJoined callback, if the user is in the COMMUNICATION profile, and the onUserInfoUpdated callback if the user is a host in the LIVE_BROADCASTING profile. Once a user joins the channel, the user subscribes to the audio and video streams of all the other users in the channel by default, giving rise to usage and billing calculation. To stop subscribing to a specified stream or all remote streams, call the corresponding mute methods.
  ///
  /// * [token] The token generated on your server for authentication. If you need to join different channels at the same time or switch between channels, Agora recommends using a wildcard token so that you don't need to apply for a new token every time joining a channel.
  /// * [channelId] The channel name. This parameter signifies the channel in which users engage in real-time audio and video interaction. Under the premise of the same App ID, users who fill in the same channel ID enter the same channel for audio and video interaction. The string length must be less than 64 bytes. Supported characters (89 characters in total):
  ///  All lowercase English letters: a to z.
  ///  All uppercase English letters: A to Z.
  ///  All numeric characters: 0 to 9.
  ///  Space
  ///  "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","
  /// * [userAccount] The user account. This parameter is used to identify the user in the channel for real-time audio and video engagement. You need to set and manage user accounts yourself and ensure that each user account in the same channel is unique. The maximum length of this parameter is 255 bytes. Ensure that you set this parameter and do not set it as NULL. Supported characters are as follows(89 in total):
  ///  The 26 lowercase English letters: a to z.
  ///  The 26 uppercase English letters: A to Z.
  ///  All numeric characters: 0 to 9.
  ///  Space
  ///  "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","
  /// * [options] The channel media options. See ChannelMediaOptions.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: Failure.
  ///  -2: The parameter is invalid. For example, the token is invalid, the uid parameter is not set to an integer, or the value of a member in ChannelMediaOptions is invalid. You need to pass in a valid parameter and join the channel again.
  ///  -3: Failes to initialize the RtcEngine object. You need to reinitialize the RtcEngine object.
  ///  -7: The RtcEngine object has not been initialized. You need to initialize the RtcEngine object before calling this method.
  ///  -8: The internal state of the RtcEngine object is wrong. The typical cause is that you call this method to join the channel without calling startEchoTest to stop the test after calling stopEchoTest to start a call loop test. You need to call stopEchoTest before calling this method.
  ///  -17: The request to join the channel is rejected. The typical cause is that the user is in the channel. Agora recommends that you use the onConnectionStateChanged callback to determine whether the user exists in the channel. Do not call this method to join the channel unless you receive the connectionStateDisconnected (1) state.
  ///  -102: The channel name is invalid. You need to pass in a valid channelname in channelId to rejoin the channel.
  ///  -121: The user ID is invalid. You need to pass in a valid user ID in uid to rejoin the channel.
  Future<void> joinChannelWithUserAccount(
      {required String token,
      required String channelId,
      required String userAccount,
      ChannelMediaOptions? options});

  /// Joins the channel with a user account, and configures whether to automatically subscribe to audio or video streams after joining the channel.
  ///
  /// To ensure smooth communication, use the same parameter type to identify the user. For example, if a user joins the channel with a user ID, then ensure all the other users use the user ID too. The same applies to the user account. If a user joins the channel with the Agora Web SDK, ensure that the ID of the user is set to the same parameter type.
  ///  If you choose the Testing Mode (using an App ID for authentication) for your project and call this method to join a channel, you will automatically exit the channel after 24 hours. Once a user joins the channel, the user subscribes to the audio and video streams of all the other users in the channel by default, giving rise to usage and billing calculation. To stop subscribing to a specified stream or all remote streams, call the corresponding mute methods. This method allows a user to join the channel with the user account. After the user successfully joins the channel, the SDK triggers the following callbacks:
  ///  The local client: onLocalUserRegistered, onJoinChannelSuccess and onConnectionStateChanged callbacks.
  ///  The remote client: The onUserJoined callback, if the user is in the COMMUNICATION profile, and the onUserInfoUpdated callback if the user is a host in the LIVE_BROADCASTING profile.
  ///
  /// * [token] The token generated on your server for authentication. If you need to join different channels at the same time or switch between channels, Agora recommends using a wildcard token so that you don't need to apply for a new token every time joining a channel.
  /// * [channelId] The channel name. This parameter signifies the channel in which users engage in real-time audio and video interaction. Under the premise of the same App ID, users who fill in the same channel ID enter the same channel for audio and video interaction. The string length must be less than 64 bytes. Supported characters (89 characters in total):
  ///  All lowercase English letters: a to z.
  ///  All uppercase English letters: A to Z.
  ///  All numeric characters: 0 to 9.
  ///  Space
  ///  "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","
  /// * [userAccount] The user account. This parameter is used to identify the user in the channel for real-time audio and video engagement. You need to set and manage user accounts yourself and ensure that each user account in the same channel is unique. The maximum length of this parameter is 255 bytes. Ensure that you set this parameter and do not set it as NULL. Supported characters are as follows(89 in total):
  ///  The 26 lowercase English letters: a to z.
  ///  The 26 uppercase English letters: A to Z.
  ///  All numeric characters: 0 to 9.
  ///  Space
  ///  "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","
  /// * [options] The channel media options. See ChannelMediaOptions.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> joinChannelWithUserAccountEx(
      {required String token,
      required String channelId,
      required String userAccount,
      required ChannelMediaOptions options});

  /// Gets the user information by passing in the user account.
  ///
  /// After a remote user joins the channel, the SDK gets the user ID and account of the remote user, caches them in a mapping table object, and triggers the onUserInfoUpdated callback on the local client. After receiving the callback, you can call this method to get the user account of the remote user from the UserInfo object by passing in the user ID.
  ///
  /// * [userAccount] The user account.
  ///
  /// Returns
  /// A pointer to the UserInfo instance, if the method call succeeds.
  ///  If the call fails, returns NULL.
  Future<UserInfo> getUserInfoByUserAccount(String userAccount);

  /// Gets the user information by passing in the user ID.
  ///
  /// After a remote user joins the channel, the SDK gets the user ID and account of the remote user, caches them in a mapping table object, and triggers the onUserInfoUpdated callback on the local client. After receiving the callback, you can call this method to get the user account of the remote user from the UserInfo object by passing in the user ID.
  ///
  /// * [uid] The user ID.
  ///
  /// Returns
  /// A pointer to the UserInfo instance, if the method call succeeds.
  ///  If the call fails, returns NULL.
  Future<UserInfo> getUserInfoByUid(int uid);

  /// Starts relaying media streams across channels or updates channels for media relay.
  ///
  /// The first successful call to this method starts relaying media streams from the source channel to the destination channels. To relay the media stream to other channels, or exit one of the current media relays, you can call this method again to update the destination channels. This feature supports relaying media streams to a maximum of six destination channels. After a successful method call, the SDK triggers the onChannelMediaRelayStateChanged callback, and this callback returns the state of the media stream relay. Common states are as follows:
  ///  If the onChannelMediaRelayStateChanged callback returns relayStateRunning (2) and relayOk (0), it means that the SDK starts relaying media streams from the source channel to the destination channel.
  ///  If the onChannelMediaRelayStateChanged callback returns relayStateFailure (3), an exception occurs during the media stream relay.
  ///  Call this method after joining the channel.
  ///  This method takes effect only when you are a host in a live streaming channel.
  ///  The relaying media streams across channels function needs to be enabled by contacting.
  ///  Agora does not support string user accounts in this API.
  ///
  /// * [configuration] The configuration of the media stream relay. See ChannelMediaRelayConfiguration.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: Failure.
  ///  -1: A general error occurs (no specified reason).
  ///  -2: The parameter is invalid.
  ///  -7: The method call was rejected. It may be because the SDK has not been initialized successfully, or the user role is not a host.
  ///  -8: Internal state error. Probably because the user is not a broadcaster.
  Future<void> startOrUpdateChannelMediaRelay(
      ChannelMediaRelayConfiguration configuration);

  /// Stops the media stream relay. Once the relay stops, the host quits all the target channels.
  ///
  /// After a successful method call, the SDK triggers the onChannelMediaRelayStateChanged callback. If the callback reports relayStateIdle (0) and relayOk (0), the host successfully stops the relay. If the method call fails, the SDK triggers the onChannelMediaRelayStateChanged callback with the relayErrorServerNoResponse (2) or relayErrorServerConnectionLost (8) status code. You can call the leaveChannel method to leave the channel, and the media stream relay automatically stops.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: Failure.
  Future<void> stopChannelMediaRelay();

  /// Pauses the media stream relay to all target channels.
  ///
  /// After the cross-channel media stream relay starts, you can call this method to pause relaying media streams to all target channels; after the pause, if you want to resume the relay, call resumeAllChannelMediaRelay. Call this method after startOrUpdateChannelMediaRelay.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> pauseAllChannelMediaRelay();

  /// Resumes the media stream relay to all target channels.
  ///
  /// After calling the pauseAllChannelMediaRelay method, you can call this method to resume relaying media streams to all destination channels. Call this method after pauseAllChannelMediaRelay.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: Failure.
  Future<void> resumeAllChannelMediaRelay();

  /// Sets the audio profile of the audio streams directly pushed to the CDN by the host.
  ///
  /// When you set the publishMicrophoneTrack or publishCustomAudioTrack in the DirectCdnStreamingMediaOptions as true to capture audios, you can call this method to set the audio profile.
  ///
  /// * [profile] The audio profile, including the sampling rate, bitrate, encoding mode, and the number of channels. See AudioProfileType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setDirectCdnStreamingAudioConfiguration(
      AudioProfileType profile);

  /// Sets the video profile of the media streams directly pushed to the CDN by the host.
  ///
  /// This method only affects video streams captured by cameras or screens, or from custom video capture sources. That is, when you set publishCameraTrack or publishCustomVideoTrack in DirectCdnStreamingMediaOptions as true to capture videos, you can call this method to set the video profiles. If your local camera does not support the video resolution you set,the SDK automatically adjusts the video resolution to a value that is closest to your settings for capture, encoding or streaming, with the same aspect ratio as the resolution you set. You can get the actual resolution of the video streams through the onDirectCdnStreamingStats callback.
  ///
  /// * [config] Video profile. See VideoEncoderConfiguration. During CDN live streaming, Agora only supports setting OrientationMode as orientationModeFixedLandscape or orientationModeFixedPortrait.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setDirectCdnStreamingVideoConfiguration(
      VideoEncoderConfiguration config);

  /// Starts pushing media streams to the CDN directly.
  ///
  /// Aogra does not support pushing media streams to one URL repeatedly. Media options Agora does not support setting the value of publishCameraTrack and publishCustomVideoTrack as true, or the value of publishMicrophoneTrack and publishCustomAudioTrack as true at the same time. When choosing media setting options (DirectCdnStreamingMediaOptions), you can refer to the following examples: If you want to push audio and video streams published by the host to the CDN, the media setting options should be set as follows: publishCustomAudioTrack is set as true and call the pushAudioFrame method publishCustomVideoTrack is set as true and call the pushVideoFrame method publishCameraTrack is set as false (the default value) publishMicrophoneTrack is set as false (the default value) As of v4.2.0, Agora SDK supports audio-only live streaming. You can set publishCustomAudioTrack or publishMicrophoneTrack in DirectCdnStreamingMediaOptions as true and call pushAudioFrame to push audio streams. Agora only supports pushing one audio and video streams or one audio streams to CDN.
  ///
  /// * [eventHandler] See onDirectCdnStreamingStateChanged and onDirectCdnStreamingStats.
  /// * [publishUrl] The CDN live streaming URL.
  /// * [options] The media setting options for the host. See DirectCdnStreamingMediaOptions.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> startDirectCdnStreaming(
      {required DirectCdnStreamingEventHandler eventHandler,
      required String publishUrl,
      required DirectCdnStreamingMediaOptions options});

  /// Stops pushing media streams to the CDN directly.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> stopDirectCdnStreaming();

  /// @nodoc
  Future<void> updateDirectCdnStreamingMediaOptions(
      DirectCdnStreamingMediaOptions options);

  /// Enables the virtual metronome.
  ///
  /// In music education, physical education and other scenarios, teachers usually need to use a metronome so that students can practice with the correct beat. The meter is composed of a downbeat and upbeats. The first beat of each measure is called a downbeat, and the rest are called upbeats. In this method, you need to set the file path of the upbeat and downbeat, the number of beats per measure, the beat speed, and whether to send the sound of the metronome to remote users. After successfully calling this method, the SDK triggers the onRhythmPlayerStateChanged callback locally to report the status of the virtual metronome.
  ///  This method is for Android and iOS only.
  ///  After enabling the virtual metronome, the SDK plays the specified audio effect file from the beginning, and controls the playback duration of each file according to beatsPerMinute you set in AgoraRhythmPlayerConfig. For example, if you set beatsPerMinute as 60, the SDK plays one beat every second. If the file duration exceeds the beat duration, the SDK only plays the audio within the beat duration.
  ///  By default, the sound of the virtual metronome is published in the channel. If you do not want the sound to be heard by the remote users, you can set publishRhythmPlayerTrack in ChannelMediaOptions as false.
  ///
  /// * [sound1] The absolute path or URL address (including the filename extensions) of the file for the downbeat. For example, C:\music\audio.mp4. For the audio file formats supported by this method, see What formats of audio files does the Agora RTC SDK support.
  /// * [sound2] The absolute path or URL address (including the filename extensions) of the file for the upbeats. For example, C:\music\audio.mp4. For the audio file formats supported by this method, see What formats of audio files does the Agora RTC SDK support.
  /// * [config] The metronome configuration. See AgoraRhythmPlayerConfig.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> startRhythmPlayer(
      {required String sound1,
      required String sound2,
      required AgoraRhythmPlayerConfig config});

  /// Disables the virtual metronome.
  ///
  /// After calling startRhythmPlayer, you can call this method to disable the virtual metronome. This method is for Android and iOS only.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> stopRhythmPlayer();

  /// Configures the virtual metronome.
  ///
  /// This method is for Android and iOS only.
  ///  After enabling the virtual metronome, the SDK plays the specified audio effect file from the beginning, and controls the playback duration of each file according to beatsPerMinute you set in AgoraRhythmPlayerConfig. For example, if you set beatsPerMinute as 60, the SDK plays one beat every second. If the file duration exceeds the beat duration, the SDK only plays the audio within the beat duration.
  ///  By default, the sound of the virtual metronome is published in the channel. If you do not want the sound to be heard by the remote users, you can set publishRhythmPlayerTrack in ChannelMediaOptions as false. After calling startRhythmPlayer, you can call this method to reconfigure the virtual metronome. After successfully calling this method, the SDK triggers the onRhythmPlayerStateChanged callback locally to report the status of the virtual metronome.
  ///
  /// * [config] The metronome configuration. See AgoraRhythmPlayerConfig.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> configRhythmPlayer(AgoraRhythmPlayerConfig config);

  /// Takes a snapshot of a video stream.
  ///
  /// This method takes a snapshot of a video stream from the specified user, generates a JPG image, and saves it to the specified path. The method is asynchronous, and the SDK has not taken the snapshot when the method call returns. After a successful method call, the SDK triggers the onSnapshotTaken callback to report whether the snapshot is successfully taken, as well as the details for that snapshot.
  ///  Call this method after joining a channel.
  ///  When used for local video snapshots, this method takes a snapshot for the video streams specified in ChannelMediaOptions.
  ///  If the user's video has been preprocessed, for example, watermarked or beautified, the resulting snapshot includes the pre-processing effect.
  ///
  /// * [uid] The user ID. Set uid as 0 if you want to take a snapshot of the local user's video.
  /// * [filePath] The local path (including filename extensions) of the snapshot. For example:
  ///  Windows: C:\Users\<user_name>\AppData\Local\Agora\<process_name>\example.jpg
  ///  iOS: /App Sandbox/Library/Caches/example.jpg
  ///  macOS: ～/Library/Logs/example.jpg
  ///  Android: /storage/emulated/0/Android/data/<package name>/files/example.jpg Ensure that the path you specify exists and is writable.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> takeSnapshot({required int uid, required String filePath});

  /// Enables or disables video screenshot and upload.
  ///
  /// When video screenshot and upload function is enabled, the SDK takes screenshots and uploads videos sent by local users based on the type and frequency of the module you set in ContentInspectConfig. After video screenshot and upload, the Agora server sends the callback notification to your app server in HTTPS requests and sends all screenshots to the third-party cloud storage service. Before calling this method, ensure that you have contacted to activate the video screenshot upload service.
  ///
  /// * [enabled] Whether to enable video screenshot and upload : true : Enables video screenshot and upload. false : Disables video screenshot and upload.
  /// * [config] Configuration of video screenshot and upload. See ContentInspectConfig. When the video moderation module is set to video moderation via Agora self-developed extension(contentInspectSupervision), the video screenshot and upload dynamic library libagora_content_inspect_extension.dll is required. Deleting this library disables the screenshot and upload feature.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> enableContentInspect(
      {required bool enabled, required ContentInspectConfig config});

  /// Adjusts the volume of the custom audio track played remotely.
  ///
  /// Ensure you have called the createCustomAudioTrack method to create a custom audio track before calling this method. If you want to change the volume of the audio played remotely, you need to call this method again.
  ///
  /// * [trackId] The audio track ID. Set this parameter to the custom audio track ID returned in createCustomAudioTrack.
  /// * [volume] The volume of the audio source. The value can range from 0 to 100. 0 means mute; 100 means the original volume.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: Failure.
  Future<void> adjustCustomAudioPublishVolume(
      {required int trackId, required int volume});

  /// Adjusts the volume of the custom audio track played locally.
  ///
  /// Ensure you have called the createCustomAudioTrack method to create a custom audio track before calling this method. If you want to change the volume of the audio to be played locally, you need to call this method again.
  ///
  /// * [trackId] The audio track ID. Set this parameter to the custom audio track ID returned in createCustomAudioTrack.
  /// * [volume] The volume of the audio source. The value can range from 0 to 100. 0 means mute; 100 means the original volume.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: Failure.
  Future<void> adjustCustomAudioPlayoutVolume(
      {required int trackId, required int volume});

  /// Sets up cloud proxy service.
  ///
  /// When users' network access is restricted by a firewall, configure the firewall to allow specific IP addresses and ports provided by Agora; then, call this method to enable the cloud proxyType and set the cloud proxy type with the proxyType parameter. After successfully connecting to the cloud proxy, the SDK triggers the onConnectionStateChanged (connectionStateConnecting, connectionChangedSettingProxyServer) callback. To disable the cloud proxy that has been set, call the setCloudProxy (noneProxy). To change the cloud proxy type that has been set, call the setCloudProxy (noneProxy) first, and then call the setCloudProxy to set the proxyType you want.
  ///  Agora recommends that you call this method after joining a channel.
  ///  When a user is behind a firewall and uses the Force UDP cloud proxy, the services for Media Push and cohosting across channels are not available.
  ///  When you use the Force TCP cloud proxy, note that an error would occur when calling the startAudioMixing method to play online music files in the HTTP protocol. The services for Media Push and cohosting across channels use the cloud proxy with the TCP protocol.
  ///
  /// * [proxyType] The type of the cloud proxy. See CloudProxyType. This parameter is mandatory. The SDK reports an error if you do not pass in a value.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setCloudProxy(CloudProxyType proxyType);

  /// @nodoc
  Future<void> setLocalAccessPoint(LocalAccessPointConfiguration config);

  /// Sets audio advanced options.
  ///
  /// If you have advanced audio processing requirements, such as capturing and sending stereo audio, you can call this method to set advanced audio options. Call this method after calling joinChannel, enableAudio and enableLocalAudio.
  ///
  /// * [options] The advanced options for audio. See AdvancedAudioOptions.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setAdvancedAudioOptions(
      {required AdvancedAudioOptions options, int sourceType = 0});

  /// @nodoc
  Future<void> setAVSyncSource({required String channelId, required int uid});

  /// Sets whether to replace the current video feeds with images when publishing video streams.
  ///
  /// Agora recommends that you call this method after joining a channel. When publishing video streams, you can call this method to replace the current video feeds with custom images. Once you enable this function, you can select images to replace the video feeds through the ImageTrackOptions parameter. If you disable this function, the remote users see the video feeds that you publish.
  ///
  /// * [enable] Whether to replace the current video feeds with custom images: true : Replace the current video feeds with custom images. false : (Default) Do not replace the current video feeds with custom images.
  /// * [options] Image configurations. See ImageTrackOptions.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: Failure.
  Future<void> enableVideoImageSource(
      {required bool enable, required ImageTrackOptions options});

  /// Gets the current Monotonic Time of the SDK.
  ///
  /// Monotonic Time refers to a monotonically increasing time series whose value increases over time. The unit is milliseconds. In custom video capture and custom audio capture scenarios, in order to ensure audio and video synchronization, Agora recommends that you call this method to obtain the current Monotonic Time of the SDK, and then pass this value into the timestamp parameter in the captured video frame (VideoFrame) and audio frame (AudioFrame).
  ///
  /// Returns
  /// ≥0: The method call is successful, and returns the current Monotonic Time of the SDK (in milliseconds).
  ///  < 0: Failure.
  Future<int> getCurrentMonotonicTimeInMs();

  /// @nodoc
  Future<void> enableWirelessAccelerate(bool enabled);

  /// Gets the type of the local network connection.
  ///
  /// You can use this method to get the type of network in use at any stage. You can call this method either before or after joining a channel.
  ///
  /// Returns
  /// ≥ 0: The method call is successful, and the local network connection type is returned.
  ///  0: The SDK disconnects from the network.
  ///  1: The network type is LAN.
  ///  2: The network type is Wi-Fi (including hotspots).
  ///  3: The network type is mobile 2G.
  ///  4: The network type is mobile 3G.
  ///  5: The network type is mobile 4G.
  ///  6: The network type is mobile 5G.
  ///  < 0: The method call failed with an error code.
  ///  -1: The network type is unknown.
  Future<int> getNetworkType();

  /// Provides technical preview functionalities or special customizations by configuring the SDK with JSON options.
  ///
  /// * [parameters] Pointer to the set parameters in a JSON string.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setParameters(String parameters);

  /// Enables tracing the video frame rendering process.
  ///
  /// The SDK starts tracing the rendering status of the video frames in the channel from the moment this method is successfully called and reports information about the event through the onVideoRenderingTracingResult callback.
  ///  By default, the SDK starts tracing the video rendering event automatically when the local user successfully joins the channel. You can call this method at an appropriate time according to the actual application scenario to customize the tracing process.
  ///  After the local user leaves the current channel, the SDK automatically resets the time point to the next time when the user successfully joins the channel.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> startMediaRenderingTracing();

  /// Enables audio and video frame instant rendering.
  ///
  /// After successfully calling this method, the SDK enables the instant frame rendering mode, which can speed up the first frame rendering speed after the user joins the channel.
  ///  Once the instant rendering function is enabled, it can only be canceled by calling the release method to destroy the RtcEngine object.
  ///  In this mode, the SDK uses Agora's custom encryption algorithm to shorten the time required to establish transmission links, and the security is reduced compared to the standard DTLS (Datagram Transport Layer Security). If the application scenario requires higher security standards, Agora recommends that you do not use this method.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> enableInstantMediaRendering();

  /// Gets the current NTP (Network Time Protocol) time.
  ///
  /// In the real-time chorus scenario, especially when the downlink connections are inconsistent due to network issues among multiple receiving ends, you can call this method to obtain the current NTP time as the reference time, in order to align the lyrics and music of multiple receiving ends and achieve chorus synchronization.
  ///
  /// Returns
  /// The Unix timestamp (ms) of the current NTP time.
  Future<int> getNtpWallTimeInMs();

  /// Checks whether the device supports the specified advanced feature.
  ///
  /// Checks whether the capabilities of the current device meet the requirements for advanced features such as virtual background and image enhancement.
  ///
  /// * [type] The type of the advanced feature, see FeatureType.
  ///
  /// Returns
  /// true : The current device supports the specified feature. false : The current device does not support the specified feature.
  Future<bool> isFeatureAvailableOnDevice(FeatureType type);

  /// @nodoc
  Future<void> sendAudioMetadata(
      {required Uint8List metadata, required int length});

  /// Starts screen capture from the specified video source.
  ///
  /// This method applies to the macOS and Windows only.
  ///
  /// * [sourceType] The type of the video source. See VideoSourceType. On the macOS platform, this parameter can only be set to videoSourceScreen (2).
  /// * [config] The configuration of the captured screen. See ScreenCaptureConfiguration.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> startScreenCaptureBySourceType(
      {required VideoSourceType sourceType,
      required ScreenCaptureConfiguration config});

  /// Stops screen capture from the specified video source.
  ///
  /// This method applies to the macOS and Windows only.
  ///
  /// * [sourceType] The type of the video source. See VideoSourceType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> stopScreenCaptureBySourceType(VideoSourceType sourceType);

  /// Releases the RtcEngine instance.
  ///
  /// This method releases all resources used by the Agora SDK. Use this method for apps in which users occasionally make voice or video calls. When users do not make calls, you can free up resources for other operations. After a successful method call, you can no longer use any method or callback in the SDK anymore. If you want to use the real-time communication functions again, you must call createAgoraRtcEngine and initialize to create a new RtcEngine instance.
  ///  This method can be called synchronously. You need to wait for the resource of RtcEngine to be released before performing other operations (for example, create a new RtcEngine object). Therefore, Agora recommends calling this method in the child thread to avoid blocking the main thread.
  ///  Besides, Agora does not recommend you calling release in any callback of the SDK. Otherwise, the SDK cannot release the resources until the callbacks return results, which may result in a deadlock.
  ///
  /// * [sync] Whether the method is called synchronously: true : Synchronous call. false : Asynchronous call. Currently this method only supports synchronous calls. Do not set this parameter to this value.
  Future<void> release({bool sync = false});

  /// Enables the local video preview.
  ///
  /// You can call this method to enable local video preview.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> startPreviewWithoutSourceType();

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

  /// Gets MusicContentCenter.
  ///
  /// Returns
  /// One MusicContentCenter object.
  MusicContentCenter getMusicContentCenter();

  /// Gets one MediaEngine object.
  ///
  /// Make sure the RtcEngine is initialized before you call this method.
  ///
  /// Returns
  /// One MediaEngine object.
  MediaEngine getMediaEngine();

  /// Gets one LocalSpatialAudioEngine object.
  ///
  /// Make sure the RtcEngine is initialized before you call this method.
  ///
  /// Returns
  /// One LocalSpatialAudioEngine object.
  LocalSpatialAudioEngine getLocalSpatialAudioEngine();

  /// @nodoc
  H265Transcoder getH265Transcoder();

  /// Sends media metadata.
  ///
  /// If the metadata is sent successfully, the SDK triggers the onMetadataReceived callback on the receiver.
  ///
  /// * [metadata] Media metadata. See Metadata.
  /// * [sourceType] The type of the video source. See VideoSourceType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: Failure.
  Future<void> sendMetaData(
      {required Metadata metadata, required VideoSourceType sourceType});

  /// Sets the maximum size of the media metadata.
  ///
  /// After calling registerMediaMetadataObserver, you can call this method to set the maximum size of the media metadata.
  ///
  /// * [size] The maximum size of media metadata.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: Failure.
  Future<void> setMaxMetadataSize(int size);

  /// Unregisters the encoded audio frame observer.
  ///
  /// * [observer] The encoded audio observer. See AudioEncodedFrameObserver.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  void unregisterAudioEncodedFrameObserver(AudioEncodedFrameObserver observer);

  /// Gets the C++ handle of the Native SDK.
  ///
  /// This method retrieves the C++ handle of the SDK, which is used for registering the audio and video frame observer.
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

  /// 8: The device is unplugged.
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

  /// 38: 640 × 360, frame rate 15 fps, bitrate 800 Kbps. This profile applies only to the live streaming channel profile.
  @JsonValue(38)
  videoProfileLandscape360p9,

  /// 39: 640 × 360, frame rate 24 fps, bitrate 800 Kbps. This profile applies only to the live streaming channel profile.
  @JsonValue(39)
  videoProfileLandscape360p10,

  /// 100: 640 × 360, frame rate 24 fps, bitrate 1000 Kbps. This profile applies only to the live streaming channel profile.
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

  /// 1038: 360 × 640, frame rate 15 fps, bitrate 800 Kbps. This profile applies only to the live streaming channel profile.
  @JsonValue(1038)
  videoProfilePortrait360p9,

  /// 1039: 360 × 640, frame rate 24 fps, bitrate 800 Kbps. This profile applies only to the live streaming channel profile.
  @JsonValue(1039)
  videoProfilePortrait360p10,

  /// 1100: 360 × 640, frame rate 24 fps, bitrate 1000 Kbps. This profile applies only to the live streaming channel profile.
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

  /// SDK version information. String format, such as 6.0.0.
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

/// The AudioDeviceInfo class that contains the ID, name and type of the audio devices.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioDeviceInfo {
  /// @nodoc
  const AudioDeviceInfo({this.deviceId, this.deviceTypeName, this.deviceName});

  /// The device ID.
  @JsonKey(name: 'deviceId')
  final String? deviceId;

  /// Output parameter; indicates the type of audio devices, such as built-in, USB and HDMI.
  @JsonKey(name: 'deviceTypeName')
  final String? deviceTypeName;

  /// The device name.
  @JsonKey(name: 'deviceName')
  final String? deviceName;

  /// @nodoc
  factory AudioDeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$AudioDeviceInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AudioDeviceInfoToJson(this);
}
