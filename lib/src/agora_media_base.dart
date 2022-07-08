import 'package:agora_rtc_ng/src/binding_forward_export.dart';
part 'agora_media_base.g.dart';

/// @nodoc
const defaultConnectionId = 0;

/// @nodoc
const dummyConnectionId = 4294967295;

/// The type of the audio route.
@JsonEnum(alwaysCreate: true)
enum AudioRoute {
  /// -1: Default audio route.
  @JsonValue(-1)
  routeDefault,

  /// Audio output routing is a headset with microphone.
  @JsonValue(0)
  routeHeadset,

  /// 1: The audio route is an earpiece.
  @JsonValue(1)
  routeEarpiece,

  /// 2: The audio route is a headset without a microphone.
  @JsonValue(2)
  routeHeadsetnomic,

  /// 3: The audio route is the speaker that comes with the device.
  @JsonValue(3)
  routeSpeakerphone,

  /// @nodoc
  @JsonValue(4)
  routeLoudspeaker,

  /// 5: The audio route is a bluetooth headset.
  @JsonValue(5)
  routeHeadsetbluetooth,

  /// @nodoc
  @JsonValue(6)
  routeHdmi,

  /// @nodoc
  @JsonValue(7)
  routeUsb,
}

/// Extensions functions of [AudioRoute].
extension AudioRouteExt on AudioRoute {
  /// @nodoc
  static AudioRoute fromValue(int value) {
    return $enumDecode(_$AudioRouteEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$AudioRouteEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum NlpAggressiveness {
  /// @nodoc
  @JsonValue(0)
  nlpNotSpecified,

  /// @nodoc
  @JsonValue(1)
  nlpMild,

  /// @nodoc
  @JsonValue(2)
  nlpNormal,

  /// @nodoc
  @JsonValue(3)
  nlpAggressive,

  /// @nodoc
  @JsonValue(4)
  nlpSuperAggressive,

  /// @nodoc
  @JsonValue(5)
  nlpExtreme,
}

/// Extensions functions of [NlpAggressiveness].
extension NlpAggressivenessExt on NlpAggressiveness {
  /// @nodoc
  static NlpAggressiveness fromValue(int value) {
    return $enumDecode(_$NlpAggressivenessEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$NlpAggressivenessEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum BytesPerSample {
  /// @nodoc
  @JsonValue(2)
  twoBytesPerSample,
}

/// Extensions functions of [BytesPerSample].
extension BytesPerSampleExt on BytesPerSample {
  /// @nodoc
  static BytesPerSample fromValue(int value) {
    return $enumDecode(_$BytesPerSampleEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$BytesPerSampleEnumMap[this]!;
  }
}

/// @nodoc
@JsonSerializable(explicitToJson: true)
class AudioParameters {
  /// Construct the [AudioParameters].
  const AudioParameters({this.sampleRate, this.channels, this.framesPerBuffer});

  /// @nodoc
  @JsonKey(name: 'sample_rate')
  final int? sampleRate;

  /// @nodoc
  @JsonKey(name: 'channels')
  final int? channels;

  /// @nodoc
  @JsonKey(name: 'frames_per_buffer')
  final int? framesPerBuffer;

  /// @nodoc
  factory AudioParameters.fromJson(Map<String, dynamic> json) =>
      _$AudioParametersFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AudioParametersToJson(this);
}

/// The use mode of the audio data.
@JsonEnum(alwaysCreate: true)
enum RawAudioFrameOpModeType {
  /// 0: Read-only mode:
  @JsonValue(0)
  rawAudioFrameOpModeReadOnly,

  /// 2: Read and write mode:
  @JsonValue(2)
  rawAudioFrameOpModeReadWrite,
}

/// Extensions functions of [RawAudioFrameOpModeType].
extension RawAudioFrameOpModeTypeExt on RawAudioFrameOpModeType {
  /// @nodoc
  static RawAudioFrameOpModeType fromValue(int value) {
    return $enumDecode(_$RawAudioFrameOpModeTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$RawAudioFrameOpModeTypeEnumMap[this]!;
  }
}

/// Media source type.
@JsonEnum(alwaysCreate: true)
enum MediaSourceType {
  /// 0: Audio playback device.
  @JsonValue(0)
  audioPlayoutSource,

  /// 1: Audio capturing device.
  @JsonValue(1)
  audioRecordingSource,

  /// @nodoc
  @JsonValue(2)
  primaryCameraSource,

  /// @nodoc
  @JsonValue(3)
  secondaryCameraSource,

  /// @nodoc
  @JsonValue(4)
  primaryScreenSource,

  /// @nodoc
  @JsonValue(5)
  secondaryScreenSource,

  /// @nodoc
  @JsonValue(6)
  customVideoSource,

  /// @nodoc
  @JsonValue(7)
  mediaPlayerSource,

  /// @nodoc
  @JsonValue(8)
  rtcImagePngSource,

  /// @nodoc
  @JsonValue(9)
  rtcImageJpegSource,

  /// @nodoc
  @JsonValue(10)
  rtcImageGifSource,

  /// @nodoc
  @JsonValue(11)
  remoteVideoSource,

  /// @nodoc
  @JsonValue(12)
  transcodedVideoSource,

  /// @nodoc
  @JsonValue(100)
  unknownMediaSource,
}

/// Extensions functions of [MediaSourceType].
extension MediaSourceTypeExt on MediaSourceType {
  /// @nodoc
  static MediaSourceType fromValue(int value) {
    return $enumDecode(_$MediaSourceTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$MediaSourceTypeEnumMap[this]!;
  }
}

/// @nodoc
const kMaxCodecNameLength = 50;

/// @nodoc
@JsonSerializable(explicitToJson: true)
class PacketOptions {
  /// Construct the [PacketOptions].
  const PacketOptions({this.timestamp, this.audioLevelIndication});

  /// @nodoc
  @JsonKey(name: 'timestamp')
  final int? timestamp;

  /// @nodoc
  @JsonKey(name: 'audioLevelIndication')
  final int? audioLevelIndication;

  /// @nodoc
  factory PacketOptions.fromJson(Map<String, dynamic> json) =>
      _$PacketOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$PacketOptionsToJson(this);
}

/// The number of channels for audio preprocessing.
/// In scenarios that require enhanced realism, such as concerts, local users might need to capture stereo audio and send stereo signals to remote users. For example, the singer, guitarist, and drummer are standing in different positions on the stage. The audio capture device captures their stereo audio and sends stereo signals to remote users. Remote users can hear the song, guitar, and drum from different directions as if they were at the auditorium.
/// You can set the dual-channel processing to implement stereo audio in this class. Agora recommends the following settings:
/// Preprocessing: call setAdvancedAudioOptions and set audioProcessingChannels to AdvancedAudioOptions (2) in audioProcessingStereo.
/// Post-processing: call setAudioProfile2 profile to audioProfileMusicStandardStereo (3) or audioProfileMusicHighQualityStereo (5).
/// The stereo setting only takes effect when the SDK uses the media volume.
@JsonEnum(alwaysCreate: true)
enum AudioProcessingChannels {
  /// 1: (Default) Mono.
  @JsonValue(1)
  audioProcessingMono,

  /// 2: Stereo (two channels).
  @JsonValue(2)
  audioProcessingStereo,
}

/// Extensions functions of [AudioProcessingChannels].
extension AudioProcessingChannelsExt on AudioProcessingChannels {
  /// @nodoc
  static AudioProcessingChannels fromValue(int value) {
    return $enumDecode(_$AudioProcessingChannelsEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$AudioProcessingChannelsEnumMap[this]!;
  }
}

/// The advanced options for audio.
@JsonSerializable(explicitToJson: true)
class AdvancedAudioOptions {
  /// Construct the [AdvancedAudioOptions].
  const AdvancedAudioOptions({this.audioProcessingChannels});

  /// The number of channels for audio preprocessing. See audioprocessingchannels .
  @JsonKey(name: 'audioProcessingChannels')
  final AudioProcessingChannels? audioProcessingChannels;

  /// @nodoc
  factory AdvancedAudioOptions.fromJson(Map<String, dynamic> json) =>
      _$AdvancedAudioOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AdvancedAudioOptionsToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true)
class AudioEncodedFrameInfo {
  /// Construct the [AudioEncodedFrameInfo].
  const AudioEncodedFrameInfo({this.sendTs, this.codec});

  /// @nodoc
  @JsonKey(name: 'sendTs')
  final int? sendTs;

  /// @nodoc
  @JsonKey(name: 'codec')
  final int? codec;

  /// @nodoc
  factory AudioEncodedFrameInfo.fromJson(Map<String, dynamic> json) =>
      _$AudioEncodedFrameInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AudioEncodedFrameInfoToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true)
class AudioPcmFrame {
  /// Construct the [AudioPcmFrame].
  const AudioPcmFrame(
      {this.captureTimestamp,
      this.samplesPerChannel,
      this.sampleRateHz,
      this.numChannels,
      this.bytesPerSample,
      this.data});

  /// @nodoc
  @JsonKey(name: 'capture_timestamp')
  final int? captureTimestamp;

  /// @nodoc
  @JsonKey(name: 'samples_per_channel_')
  final int? samplesPerChannel;

  /// @nodoc
  @JsonKey(name: 'sample_rate_hz_')
  final int? sampleRateHz;

  /// @nodoc
  @JsonKey(name: 'num_channels_')
  final int? numChannels;

  /// @nodoc
  @JsonKey(name: 'bytes_per_sample')
  final BytesPerSample? bytesPerSample;

  /// @nodoc
  @JsonKey(name: 'data_')
  final List<int>? data;

  /// @nodoc
  factory AudioPcmFrame.fromJson(Map<String, dynamic> json) =>
      _$AudioPcmFrameFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AudioPcmFrameToJson(this);
}

/// The channel mode.
@JsonEnum(alwaysCreate: true)
enum AudioDualMonoMode {
  /// 0: Original mode.
  @JsonValue(0)
  audioDualMonoStereo,

  /// 1: Left channel mode. This mode replaces the audio of the right channel with the audio of the left channel, which means the user can only hear the audio of the left channel.
  @JsonValue(1)
  audioDualMonoL,

  /// 2: Right channel mode. This mode replaces the audio of the left channel with the audio of the right channel, which means the user can only hear the audio of the right channel.
  @JsonValue(2)
  audioDualMonoR,

  /// 3: Mixed channel mode. This mode mixes the audio of the left channel and the right channel, which means the user can hear the audio of the left channel and the right channel at the same time.
  @JsonValue(3)
  audioDualMonoMix,
}

/// Extensions functions of [AudioDualMonoMode].
extension AudioDualMonoModeExt on AudioDualMonoMode {
  /// @nodoc
  static AudioDualMonoMode fromValue(int value) {
    return $enumDecode(_$AudioDualMonoModeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$AudioDualMonoModeEnumMap[this]!;
  }
}

/// The video pixel format.
@JsonEnum(alwaysCreate: true)
enum VideoPixelFormat {
  /// @nodoc
  @JsonValue(0)
  videoPixelUnknown,

  /// 1: The format is I420.
  @JsonValue(1)
  videoPixelI420,

  /// 2: The format is BGRA.
  @JsonValue(2)
  videoPixelBgra,

  /// @nodoc
  @JsonValue(3)
  videoPixelNv21,

  /// @nodoc
  @JsonValue(4)
  videoPixelRgba,

  /// 8: The format is NV12.
  @JsonValue(8)
  videoPixelNv12,

  /// @nodoc
  @JsonValue(10)
  videoTexture2d,

  /// @nodoc
  @JsonValue(11)
  videoTextureOes,

  /// @nodoc
  @JsonValue(16)
  videoPixelI422,
}

/// Extensions functions of [VideoPixelFormat].
extension VideoPixelFormatExt on VideoPixelFormat {
  /// @nodoc
  static VideoPixelFormat fromValue(int value) {
    return $enumDecode(_$VideoPixelFormatEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$VideoPixelFormatEnumMap[this]!;
  }
}

/// Video display modes.
@JsonEnum(alwaysCreate: true)
enum RenderModeType {
  /// 1: Uniformly scale the video until one of its dimension fits the boundary (zoomed to fit). The window is filled. One dimension of the video might have clipped contents.
  @JsonValue(1)
  renderModeHidden,

  /// 2: Uniformly scale the video until one of its dimension fits the boundary (zoomed to fit). Priority is to ensuring that all video content is displayed. Areas that are not filled due to disparity in the aspect ratio are filled with black.
  @JsonValue(2)
  renderModeFit,

  ///  Deprecated:
  /// 3: This mode is deprecated.
  @JsonValue(3)
  renderModeAdaptive,
}

/// Extensions functions of [RenderModeType].
extension RenderModeTypeExt on RenderModeType {
  /// @nodoc
  static RenderModeType fromValue(int value) {
    return $enumDecode(_$RenderModeTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$RenderModeTypeEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum EglContextType {
  /// @nodoc
  @JsonValue(0)
  eglContext10,

  /// @nodoc
  @JsonValue(1)
  eglContext14,
}

/// Extensions functions of [EglContextType].
extension EglContextTypeExt on EglContextType {
  /// @nodoc
  static EglContextType fromValue(int value) {
    return $enumDecode(_$EglContextTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$EglContextTypeEnumMap[this]!;
  }
}

/// The video buffer type.
@JsonEnum(alwaysCreate: true)
enum VideoBufferType {
  /// 1: The video buffer in the format of raw data.
  @JsonValue(1)
  videoBufferRawData,

  /// @nodoc
  @JsonValue(2)
  videoBufferArray,

  /// @nodoc
  @JsonValue(3)
  videoBufferTexture,
}

/// Extensions functions of [VideoBufferType].
extension VideoBufferTypeExt on VideoBufferType {
  /// @nodoc
  static VideoBufferType fromValue(int value) {
    return $enumDecode(_$VideoBufferTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$VideoBufferTypeEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum MediaPlayerSourceType {
  /// @nodoc
  @JsonValue(0)
  mediaPlayerSourceDefault,

  /// @nodoc
  @JsonValue(1)
  mediaPlayerSourceFullFeatured,

  /// @nodoc
  @JsonValue(2)
  mediaPlayerSourceSimple,
}

/// Extensions functions of [MediaPlayerSourceType].
extension MediaPlayerSourceTypeExt on MediaPlayerSourceType {
  /// @nodoc
  static MediaPlayerSourceType fromValue(int value) {
    return $enumDecode(_$MediaPlayerSourceTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$MediaPlayerSourceTypeEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum VideoModulePosition {
  /// @nodoc
  @JsonValue(1 << 0)
  positionPostCapturer,

  /// @nodoc
  @JsonValue(1 << 1)
  positionPreRenderer,

  /// @nodoc
  @JsonValue(1 << 2)
  positionPreEncoder,

  /// @nodoc
  @JsonValue(1 << 3)
  positionPostFilters,
}

/// Extensions functions of [VideoModulePosition].
extension VideoModulePositionExt on VideoModulePosition {
  /// @nodoc
  static VideoModulePosition fromValue(int value) {
    return $enumDecode(_$VideoModulePositionEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$VideoModulePositionEnumMap[this]!;
  }
}

/// Audio frame type.
@JsonEnum(alwaysCreate: true)
enum AudioFrameType {
  /// 0: PCM 16
  @JsonValue(0)
  frameTypePcm16,
}

/// Extensions functions of [AudioFrameType].
extension AudioFrameTypeExt on AudioFrameType {
  /// @nodoc
  static AudioFrameType fromValue(int value) {
    return $enumDecode(_$AudioFrameTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$AudioFrameTypeEnumMap[this]!;
  }
}

/// The audio spectrum data.
@JsonSerializable(explicitToJson: true)
class AudioSpectrumData {
  /// Construct the [AudioSpectrumData].
  const AudioSpectrumData({this.audioSpectrumData, this.dataLength});

  /// The audio spectrum data. Agora divides the audio frequency into 160 frequency domains, and reports the energy value of each frequency domain through this parameter. The value range of each energy type is [0, 1].
  @JsonKey(name: 'audioSpectrumData')
  final List<double>? audioSpectrumData;

  /// The length of the audio spectrum data in byte.
  @JsonKey(name: 'dataLength')
  final int? dataLength;

  /// @nodoc
  factory AudioSpectrumData.fromJson(Map<String, dynamic> json) =>
      _$AudioSpectrumDataFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AudioSpectrumDataToJson(this);
}

/// Audio spectrum information of the remote user.
@JsonSerializable(explicitToJson: true)
class UserAudioSpectrumInfo {
  /// Construct the [UserAudioSpectrumInfo].
  const UserAudioSpectrumInfo({this.uid, this.spectrumData});

  /// The user ID of the remote user.
  @JsonKey(name: 'uid')
  final int? uid;

  /// Audio spectrum information of the remote user.  AudioSpectrumData
  @JsonKey(name: 'spectrumData')
  final AudioSpectrumData? spectrumData;

  /// @nodoc
  factory UserAudioSpectrumInfo.fromJson(Map<String, dynamic> json) =>
      _$UserAudioSpectrumInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$UserAudioSpectrumInfoToJson(this);
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum VideoFrameProcessMode {
  /// @nodoc
  @JsonValue(0)
  processModeReadOnly,

  /// @nodoc
  @JsonValue(1)
  processModeReadWrite,
}

/// Extensions functions of [VideoFrameProcessMode].
extension VideoFrameProcessModeExt on VideoFrameProcessMode {
  /// @nodoc
  static VideoFrameProcessMode fromValue(int value) {
    return $enumDecode(_$VideoFrameProcessModeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$VideoFrameProcessModeEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum ContentInspectResult {
  /// @nodoc
  @JsonValue(1)
  contentInspectNeutral,

  /// @nodoc
  @JsonValue(2)
  contentInspectSexy,

  /// @nodoc
  @JsonValue(3)
  contentInspectPorn,
}

/// Extensions functions of [ContentInspectResult].
extension ContentInspectResultExt on ContentInspectResult {
  /// @nodoc
  static ContentInspectResult fromValue(int value) {
    return $enumDecode(_$ContentInspectResultEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$ContentInspectResultEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum ContentInspectDeviceType {
  /// @nodoc
  @JsonValue(0)
  contentInspectDeviceInvalid,

  /// @nodoc
  @JsonValue(1)
  contentInspectDeviceAgora,

  /// @nodoc
  @JsonValue(2)
  contentInspectDeviceHive,

  /// @nodoc
  @JsonValue(3)
  contentInspectDeviceTupu,
}

/// Extensions functions of [ContentInspectDeviceType].
extension ContentInspectDeviceTypeExt on ContentInspectDeviceType {
  /// @nodoc
  static ContentInspectDeviceType fromValue(int value) {
    return $enumDecode(_$ContentInspectDeviceTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$ContentInspectDeviceTypeEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum ContentInspectType {
  /// @nodoc
  @JsonValue(0)
  contentInspectInvalide,

  /// @nodoc
  @JsonValue(1)
  contentInspectModeration,

  /// @nodoc
  @JsonValue(2)
  contentInspectSupervise,
}

/// Extensions functions of [ContentInspectType].
extension ContentInspectTypeExt on ContentInspectType {
  /// @nodoc
  static ContentInspectType fromValue(int value) {
    return $enumDecode(_$ContentInspectTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$ContentInspectTypeEnumMap[this]!;
  }
}

/// @nodoc
@JsonSerializable(explicitToJson: true)
class ContentInspectModule {
  /// Construct the [ContentInspectModule].
  const ContentInspectModule({this.type, this.frequency});

  /// /// @nodoc
  @JsonKey(name: 'type')
  final ContentInspectType? type;

  /// @nodoc
  @JsonKey(name: 'frequency')
  final int? frequency;

  /// @nodoc
  factory ContentInspectModule.fromJson(Map<String, dynamic> json) =>
      _$ContentInspectModuleFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ContentInspectModuleToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true)
class ContentInspectConfig {
  /// Construct the [ContentInspectConfig].
  const ContentInspectConfig(
      {this.enable,
      this.deviceWork,
      this.cloudWork,
      this.deviceworkType,
      this.extraInfo,
      this.modules,
      this.moduleCount});

  /// @nodoc
  @JsonKey(name: 'enable')
  final bool? enable;

  /// @nodoc
  @JsonKey(name: 'DeviceWork')
  final bool? deviceWork;

  /// @nodoc
  @JsonKey(name: 'CloudWork')
  final bool? cloudWork;

  /// @nodoc
  @JsonKey(name: 'DeviceworkType')
  final ContentInspectDeviceType? deviceworkType;

  /// @nodoc
  @JsonKey(name: 'extraInfo')
  final String? extraInfo;

  /// @nodoc
  @JsonKey(name: 'modules')
  final List<ContentInspectModule>? modules;

  /// @nodoc
  @JsonKey(name: 'moduleCount')
  final int? moduleCount;

  /// @nodoc
  factory ContentInspectConfig.fromJson(Map<String, dynamic> json) =>
      _$ContentInspectConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ContentInspectConfigToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true)
class SnapShotConfig {
  /// Construct the [SnapShotConfig].
  const SnapShotConfig({this.channel, this.uid, this.filePath});

  /// @nodoc
  @JsonKey(name: 'channel')
  final String? channel;

  /// @nodoc
  @JsonKey(name: 'uid')
  final int? uid;

  /// @nodoc
  @JsonKey(name: 'filePath')
  final String? filePath;

  /// @nodoc
  factory SnapShotConfig.fromJson(Map<String, dynamic> json) =>
      _$SnapShotConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$SnapShotConfigToJson(this);
}

/// The external video frame encoding type.
@JsonEnum(alwaysCreate: true)
enum ExternalVideoSourceType {
  /// 0: The video frame is not encoded.
  @JsonValue(0)
  videoFrame,

  /// 1: The video frame is encoded.
  @JsonValue(1)
  encodedVideoFrame,
}

/// Extensions functions of [ExternalVideoSourceType].
extension ExternalVideoSourceTypeExt on ExternalVideoSourceType {
  /// @nodoc
  static ExternalVideoSourceType fromValue(int value) {
    return $enumDecode(_$ExternalVideoSourceTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$ExternalVideoSourceTypeEnumMap[this]!;
  }
}
