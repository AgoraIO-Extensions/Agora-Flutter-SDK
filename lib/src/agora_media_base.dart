import '/src/_serializable.dart';
import '/src/binding_forward_export.dart';
part 'agora_media_base.g.dart';

/// @nodoc
const invalidTrackId = 0xffffffff;

/// @nodoc
const defaultConnectionId = 0;

/// @nodoc
const dummyConnectionId = 4294967295;

/// Plugin context information.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ExtensionContext implements AgoraSerializable {
  /// @nodoc
  const ExtensionContext(
      {this.isValid, this.uid, this.providerName, this.extensionName});

  /// Whether the uid reported in ExtensionContext is valid: true : uid is valid. false : uid is invalid.
  @JsonKey(name: 'isValid')
  final bool? isValid;

  /// User ID. 0 represents the local user, values greater than 0 represent remote users.
  @JsonKey(name: 'uid')
  final int? uid;

  /// Name of the plugin provider.
  @JsonKey(name: 'providerName')
  final String? providerName;

  /// Name of the plugin.
  @JsonKey(name: 'extensionName')
  final String? extensionName;

  /// @nodoc
  factory ExtensionContext.fromJson(Map<String, dynamic> json) =>
      _$ExtensionContextFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ExtensionContextToJson(this);
}

/// Type of video source.
@JsonEnum(alwaysCreate: true)
enum VideoSourceType {
  /// 0: (Default) Video source is the first camera.
  @JsonValue(0)
  videoSourceCameraPrimary,

  /// 0: (Default) Video source is the first camera.
  @JsonValue(0)
  videoSourceCamera,

  /// 1: Video source is the second camera.
  @JsonValue(1)
  videoSourceCameraSecondary,

  /// 2: Video source is the first screen.
  @JsonValue(2)
  videoSourceScreenPrimary,

  /// 2: Video source is the first screen.
  @JsonValue(2)
  videoSourceScreen,

  /// 3: Video source is the second screen.
  @JsonValue(3)
  videoSourceScreenSecondary,

  /// 4: Custom video source.
  @JsonValue(4)
  videoSourceCustom,

  /// 5: Video source is media player.
  @JsonValue(5)
  videoSourceMediaPlayer,

  /// 6: Video source is a PNG image.
  @JsonValue(6)
  videoSourceRtcImagePng,

  /// 7: Video source is a JPEG image.
  @JsonValue(7)
  videoSourceRtcImageJpeg,

  /// 8: Video source is a GIF image.
  @JsonValue(8)
  videoSourceRtcImageGif,

  /// 9: Video source is remote video obtained from the network.
  @JsonValue(9)
  videoSourceRemote,

  /// 10: Transcoded video source.
  @JsonValue(10)
  videoSourceTranscoded,

  /// 11: (Android, Windows, and macOS only) Video source is the third camera.
  @JsonValue(11)
  videoSourceCameraThird,

  /// 12: (Android, Windows, and macOS only) Video source is the fourth camera.
  @JsonValue(12)
  videoSourceCameraFourth,

  /// 13: (Windows and macOS only) Video source is the third screen.
  @JsonValue(13)
  videoSourceScreenThird,

  /// 14: (Windows and macOS only) Video source is the fourth screen.
  @JsonValue(14)
  videoSourceScreenFourth,

  /// 15: Video source is post-processed by a speech-driven plugin.
  @JsonValue(15)
  videoSourceSpeechDriven,

  /// 100: Unknown video source.
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

/// Audio source types.
@JsonEnum(alwaysCreate: true)
enum AudioSourceType {
  /// 0: (default) Microphone.
  @JsonValue(0)
  audioSourceMicrophone,

  /// 1: Custom captured audio stream.
  @JsonValue(1)
  audioSourceCustom,

  /// 2: Media player.
  @JsonValue(2)
  audioSourceMediaPlayer,

  /// 3: System audio stream captured during screen sharing.
  @JsonValue(3)
  audioSourceLoopbackRecording,

  /// @nodoc
  @JsonValue(4)
  audioSourceMixedStream,

  /// 5: Audio stream of a specified remote user.
  @JsonValue(5)
  audioSourceRemoteUser,

  /// 6: Mixed stream of all audio streams in the current channel.
  @JsonValue(6)
  audioSourceRemoteChannel,

  /// 100: Unknown audio source.
  @JsonValue(100)
  audioSourceUnknown,
}

/// @nodoc
extension AudioSourceTypeExt on AudioSourceType {
  /// @nodoc
  static AudioSourceType fromValue(int value) {
    return $enumDecode(_$AudioSourceTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$AudioSourceTypeEnumMap[this]!;
  }
}

/// Audio routing types.
@JsonEnum(alwaysCreate: true)
enum AudioRoute {
  /// -1: Use the default audio route.
  @JsonValue(-1)
  routeDefault,

  /// 0: Audio routed to a headset with microphone.
  @JsonValue(0)
  routeHeadset,

  /// 1: Audio routed to the earpiece.
  @JsonValue(1)
  routeEarpiece,

  /// 2: Audio routed to a headset without microphone.
  @JsonValue(2)
  routeHeadsetnomic,

  /// 3: Audio routed to the device's built-in speaker.
  @JsonValue(3)
  routeSpeakerphone,

  /// 4: Audio routed to an external speaker. (iOS and macOS only)
  @JsonValue(4)
  routeLoudspeaker,

  /// @nodoc
  @JsonValue(5)
  routeBluetoothDeviceHfp,

  /// 6: Audio routed to a USB peripheral device. (macOS only)
  @JsonValue(6)
  routeUsb,

  /// 7: Audio routed to an HDMI peripheral device. (macOS only)
  @JsonValue(7)
  routeHdmi,

  /// 8: Audio routed to a DisplayPort peripheral device. (macOS only)
  @JsonValue(8)
  routeDisplayport,

  /// 9: Audio routed to Apple AirPlay. (macOS only)
  @JsonValue(9)
  routeAirplay,

  /// @nodoc
  @JsonValue(10)
  routeBluetoothDeviceA2dp,
}

/// @nodoc
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
enum BytesPerSample {
  /// @nodoc
  @JsonValue(2)
  twoBytesPerSample,
}

/// @nodoc
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
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioParameters implements AgoraSerializable {
  /// @nodoc
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

  @override
  Map<String, dynamic> toJson() => _$AudioParametersToJson(this);
}

/// Usage mode of audio data.
@JsonEnum(alwaysCreate: true)
enum RawAudioFrameOpModeType {
  /// 0: (Default) Read-only mode. For example, if you collect data via the SDK and perform bypass streaming yourself, you can choose this mode.
  @JsonValue(0)
  rawAudioFrameOpModeReadOnly,

  /// 2: Read-write mode. For example, if you have your own audio effects processing module and want to pre-process the data (e.g., voice changing), you can choose this mode.
  @JsonValue(2)
  rawAudioFrameOpModeReadWrite,
}

/// @nodoc
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

/// Media source types.
@JsonEnum(alwaysCreate: true)
enum MediaSourceType {
  /// 0: Audio playback device.
  @JsonValue(0)
  audioPlayoutSource,

  /// 1: Audio capture device.
  @JsonValue(1)
  audioRecordingSource,

  /// 2: Primary camera.
  @JsonValue(2)
  primaryCameraSource,

  /// 3: Secondary camera.
  @JsonValue(3)
  secondaryCameraSource,

  /// @nodoc
  @JsonValue(4)
  primaryScreenSource,

  /// @nodoc
  @JsonValue(5)
  secondaryScreenSource,

  /// 6: Custom video capture source.
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

  /// 13: Video source processed by speech-driven plugin.
  @JsonValue(13)
  speechDrivenVideoSource,

  /// 100: Unknown media source.
  @JsonValue(100)
  unknownMediaSource,
}

/// @nodoc
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
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class PacketOptions implements AgoraSerializable {
  /// @nodoc
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

  @override
  Map<String, dynamic> toJson() => _$PacketOptionsToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioEncodedFrameInfo implements AgoraSerializable {
  /// @nodoc
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

  @override
  Map<String, dynamic> toJson() => _$AudioEncodedFrameInfoToJson(this);
}

/// Information of external PCM format audio frame.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioPcmFrame implements AgoraSerializable {
  /// @nodoc
  const AudioPcmFrame(
      {this.captureTimestamp,
      this.samplesPerChannel,
      this.sampleRateHz,
      this.numChannels,
      this.audioTrackNumber,
      this.bytesPerSample,
      this.data,
      this.isStereo});

  /// Timestamp (ms) of the audio frame.
  @JsonKey(name: 'capture_timestamp')
  final int? captureTimestamp;

  /// Number of samples per channel.
  @JsonKey(name: 'samples_per_channel_')
  final int? samplesPerChannel;

  /// Audio sample rate (Hz).
  @JsonKey(name: 'sample_rate_hz_')
  final int? sampleRateHz;

  /// Number of audio channels.
  @JsonKey(name: 'num_channels_')
  final int? numChannels;

  /// @nodoc
  @JsonKey(name: 'audio_track_number_')
  final int? audioTrackNumber;

  /// Number of bytes per audio sample.
  @JsonKey(name: 'bytes_per_sample')
  final BytesPerSample? bytesPerSample;

  /// Audio frame data.
  @JsonKey(name: 'data_')
  final List<int>? data;

  /// @nodoc
  @JsonKey(name: 'is_stereo_')
  final bool? isStereo;

  /// @nodoc
  factory AudioPcmFrame.fromJson(Map<String, dynamic> json) =>
      _$AudioPcmFrameFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AudioPcmFrameToJson(this);
}

/// Channel mode.
@JsonEnum(alwaysCreate: true)
enum AudioDualMonoMode {
  /// 0: Original mode.
  @JsonValue(0)
  audioDualMonoStereo,

  /// 1: Left channel mode. This mode replaces the right channel audio with the left channel audio, so the user hears only the left channel.
  @JsonValue(1)
  audioDualMonoL,

  /// 2: Right channel mode. This mode replaces the left channel audio with the right channel audio, so the user hears only the right channel.
  @JsonValue(2)
  audioDualMonoR,

  /// 3: Mix mode. This mode mixes the left and right channel data, so the user hears both channels simultaneously.
  @JsonValue(3)
  audioDualMonoMix,
}

/// @nodoc
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

/// Video pixel format.
@JsonEnum(alwaysCreate: true)
enum VideoPixelFormat {
  /// 0: Original video pixel format.
  @JsonValue(0)
  videoPixelDefault,

  /// 1: I420 format.
  @JsonValue(1)
  videoPixelI420,

  /// @nodoc
  @JsonValue(2)
  videoPixelBgra,

  /// @nodoc
  @JsonValue(3)
  videoPixelNv21,

  /// 4: RGBA format.
  @JsonValue(4)
  videoPixelRgba,

  /// @nodoc
  @JsonValue(8)
  videoPixelNv12,

  /// @nodoc
  @JsonValue(10)
  videoTexture2d,

  /// @nodoc
  @JsonValue(11)
  videoTextureOes,

  /// @nodoc
  @JsonValue(12)
  videoCvpixelNv12,

  /// @nodoc
  @JsonValue(13)
  videoCvpixelI420,

  /// @nodoc
  @JsonValue(14)
  videoCvpixelBgra,

  /// @nodoc
  @JsonValue(15)
  videoCvpixelP010,

  /// 16: I422 format.
  @JsonValue(16)
  videoPixelI422,

  /// 17: ID3D11TEXTURE2D format. Currently supported types include DXGI_FORMAT_B8G8R8A8_UNORM, DXGI_FORMAT_B8G8R8A8_TYPELESS, and DXGI_FORMAT_NV12.
  @JsonValue(17)
  videoTextureId3d11texture2d,

  /// @nodoc
  @JsonValue(18)
  videoPixelI010,
}

/// @nodoc
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

/// Video display mode.
@JsonEnum(alwaysCreate: true)
enum RenderModeType {
  /// 1: Video is scaled proportionally. Priority is to fill the view. Excess video that does not fit due to aspect ratio differences is cropped.
  @JsonValue(1)
  renderModeHidden,

  /// 2: Video is scaled proportionally. Priority is to display the entire video content. Black bars are added to fill areas not covered due to aspect ratio differences.
  @JsonValue(2)
  renderModeFit,

  /// 3: Adaptive mode. Deprecated: This enum is deprecated and not recommended for use.
  @JsonValue(3)
  renderModeAdaptive,
}

/// @nodoc
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
enum CameraVideoSourceType {
  /// @nodoc
  @JsonValue(0)
  cameraSourceFront,

  /// @nodoc
  @JsonValue(1)
  cameraSourceBack,

  /// @nodoc
  @JsonValue(2)
  videoSourceUnspecified,
}

/// @nodoc
extension CameraVideoSourceTypeExt on CameraVideoSourceType {
  /// @nodoc
  static CameraVideoSourceType fromValue(int value) {
    return $enumDecode(_$CameraVideoSourceTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$CameraVideoSourceTypeEnumMap[this]!;
  }
}

/// @nodoc
abstract class VideoFrameMetaInfo {
  /// @nodoc
  Future<String> getMetaInfoStr(MetaInfoKey key);
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum MetaInfoKey {
  /// @nodoc
  @JsonValue(0)
  keyFaceCapture,
}

/// @nodoc
extension MetaInfoKeyExt on MetaInfoKey {
  /// @nodoc
  static MetaInfoKey fromValue(int value) {
    return $enumDecode(_$MetaInfoKeyEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$MetaInfoKeyEnumMap[this]!;
  }
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ColorSpace implements AgoraSerializable {
  /// @nodoc
  const ColorSpace({this.primaries, this.transfer, this.matrix, this.range});

  /// @nodoc
  @JsonKey(name: 'primaries')
  final PrimaryID? primaries;

  /// @nodoc
  @JsonKey(name: 'transfer')
  final TransferID? transfer;

  /// @nodoc
  @JsonKey(name: 'matrix')
  final MatrixID? matrix;

  /// @nodoc
  @JsonKey(name: 'range')
  final RangeID? range;

  /// @nodoc
  factory ColorSpace.fromJson(Map<String, dynamic> json) =>
      _$ColorSpaceFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ColorSpaceToJson(this);
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum PrimaryID {
  /// @nodoc
  @JsonValue(1)
  primaryidBt709,

  /// @nodoc
  @JsonValue(2)
  primaryidUnspecified,

  /// @nodoc
  @JsonValue(4)
  primaryidBt470m,

  /// @nodoc
  @JsonValue(5)
  primaryidBt470bg,

  /// @nodoc
  @JsonValue(6)
  primaryidSmpte170m,

  /// @nodoc
  @JsonValue(7)
  primaryidSmpte240m,

  /// @nodoc
  @JsonValue(8)
  primaryidFilm,

  /// @nodoc
  @JsonValue(9)
  primaryidBt2020,

  /// @nodoc
  @JsonValue(10)
  primaryidSmptest428,

  /// @nodoc
  @JsonValue(11)
  primaryidSmptest431,

  /// @nodoc
  @JsonValue(12)
  primaryidSmptest432,

  /// @nodoc
  @JsonValue(22)
  primaryidJedecp22,
}

/// @nodoc
extension PrimaryIDExt on PrimaryID {
  /// @nodoc
  static PrimaryID fromValue(int value) {
    return $enumDecode(_$PrimaryIDEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$PrimaryIDEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum RangeID {
  /// @nodoc
  @JsonValue(0)
  rangeidInvalid,

  /// @nodoc
  @JsonValue(1)
  rangeidLimited,

  /// @nodoc
  @JsonValue(2)
  rangeidFull,

  /// @nodoc
  @JsonValue(3)
  rangeidDerived,
}

/// @nodoc
extension RangeIDExt on RangeID {
  /// @nodoc
  static RangeID fromValue(int value) {
    return $enumDecode(_$RangeIDEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$RangeIDEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum MatrixID {
  /// @nodoc
  @JsonValue(0)
  matrixidRgb,

  /// @nodoc
  @JsonValue(1)
  matrixidBt709,

  /// @nodoc
  @JsonValue(2)
  matrixidUnspecified,

  /// @nodoc
  @JsonValue(4)
  matrixidFcc,

  /// @nodoc
  @JsonValue(5)
  matrixidBt470bg,

  /// @nodoc
  @JsonValue(6)
  matrixidSmpte170m,

  /// @nodoc
  @JsonValue(7)
  matrixidSmpte240m,

  /// @nodoc
  @JsonValue(8)
  matrixidYcocg,

  /// @nodoc
  @JsonValue(9)
  matrixidBt2020Ncl,

  /// @nodoc
  @JsonValue(10)
  matrixidBt2020Cl,

  /// @nodoc
  @JsonValue(11)
  matrixidSmpte2085,

  /// @nodoc
  @JsonValue(12)
  matrixidCdncls,

  /// @nodoc
  @JsonValue(13)
  matrixidCdcls,

  /// @nodoc
  @JsonValue(14)
  matrixidBt2100Ictcp,
}

/// @nodoc
extension MatrixIDExt on MatrixID {
  /// @nodoc
  static MatrixID fromValue(int value) {
    return $enumDecode(_$MatrixIDEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$MatrixIDEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum TransferID {
  /// @nodoc
  @JsonValue(1)
  transferidBt709,

  /// @nodoc
  @JsonValue(2)
  transferidUnspecified,

  /// @nodoc
  @JsonValue(4)
  transferidGamma22,

  /// @nodoc
  @JsonValue(5)
  transferidGamma28,

  /// @nodoc
  @JsonValue(6)
  transferidSmpte170m,

  /// @nodoc
  @JsonValue(7)
  transferidSmpte240m,

  /// @nodoc
  @JsonValue(8)
  transferidLinear,

  /// @nodoc
  @JsonValue(9)
  transferidLog,

  /// @nodoc
  @JsonValue(10)
  transferidLogSqrt,

  /// @nodoc
  @JsonValue(11)
  transferidIec6196624,

  /// @nodoc
  @JsonValue(12)
  transferidBt1361Ecg,

  /// @nodoc
  @JsonValue(13)
  transferidIec6196621,

  /// @nodoc
  @JsonValue(14)
  transferidBt202010,

  /// @nodoc
  @JsonValue(15)
  transferidBt202012,

  /// @nodoc
  @JsonValue(16)
  transferidSmptest2084,

  /// @nodoc
  @JsonValue(17)
  transferidSmptest428,

  /// @nodoc
  @JsonValue(18)
  transferidAribStdB67,
}

/// @nodoc
extension TransferIDExt on TransferID {
  /// @nodoc
  static TransferID fromValue(int value) {
    return $enumDecode(_$TransferIDEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$TransferIDEnumMap[this]!;
  }
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Hdr10MetadataInfo implements AgoraSerializable {
  /// @nodoc
  const Hdr10MetadataInfo(
      {this.redPrimaryX,
      this.redPrimaryY,
      this.greenPrimaryX,
      this.greenPrimaryY,
      this.bluePrimaryX,
      this.bluePrimaryY,
      this.whitePointX,
      this.whitePointY,
      this.maxMasteringLuminance,
      this.minMasteringLuminance,
      this.maxContentLightLevel,
      this.maxFrameAverageLightLevel});

  /// @nodoc
  @JsonKey(name: 'redPrimaryX')
  final int? redPrimaryX;

  /// @nodoc
  @JsonKey(name: 'redPrimaryY')
  final int? redPrimaryY;

  /// @nodoc
  @JsonKey(name: 'greenPrimaryX')
  final int? greenPrimaryX;

  /// @nodoc
  @JsonKey(name: 'greenPrimaryY')
  final int? greenPrimaryY;

  /// @nodoc
  @JsonKey(name: 'bluePrimaryX')
  final int? bluePrimaryX;

  /// @nodoc
  @JsonKey(name: 'bluePrimaryY')
  final int? bluePrimaryY;

  /// @nodoc
  @JsonKey(name: 'whitePointX')
  final int? whitePointX;

  /// @nodoc
  @JsonKey(name: 'whitePointY')
  final int? whitePointY;

  /// @nodoc
  @JsonKey(name: 'maxMasteringLuminance')
  final int? maxMasteringLuminance;

  /// @nodoc
  @JsonKey(name: 'minMasteringLuminance')
  final int? minMasteringLuminance;

  /// @nodoc
  @JsonKey(name: 'maxContentLightLevel')
  final int? maxContentLightLevel;

  /// @nodoc
  @JsonKey(name: 'maxFrameAverageLightLevel')
  final int? maxFrameAverageLightLevel;

  /// @nodoc
  factory Hdr10MetadataInfo.fromJson(Map<String, dynamic> json) =>
      _$Hdr10MetadataInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$Hdr10MetadataInfoToJson(this);
}

/// The relative position of alphaBuffer and the video frame.
@JsonEnum(alwaysCreate: true)
enum AlphaStitchMode {
  /// 0: (Default) Only the video frame, i.e., alphaBuffer is not stitched with the video frame.
  @JsonValue(0)
  noAlphaStitch,

  /// 1: alphaBuffer is above the video frame.
  @JsonValue(1)
  alphaStitchUp,

  /// 2: alphaBuffer is below the video frame.
  @JsonValue(2)
  alphaStitchBelow,

  /// 3: alphaBuffer is on the left side of the video frame.
  @JsonValue(3)
  alphaStitchLeft,

  /// 4: alphaBuffer is on the right side of the video frame.
  @JsonValue(4)
  alphaStitchRight,
}

/// @nodoc
extension AlphaStitchModeExt on AlphaStitchMode {
  /// @nodoc
  static AlphaStitchMode fromValue(int value) {
    return $enumDecode(_$AlphaStitchModeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$AlphaStitchModeEnumMap[this]!;
  }
}

/// External video frame.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ExternalVideoFrame implements AgoraSerializable {
  /// @nodoc
  const ExternalVideoFrame(
      {this.type,
      this.format,
      this.buffer,
      this.stride,
      this.height,
      this.cropLeft,
      this.cropTop,
      this.cropRight,
      this.cropBottom,
      this.rotation,
      this.timestamp,
      this.eglType,
      this.textureId,
      this.fenceObject,
      this.matrix,
      this.metadataBuffer,
      this.metadataSize,
      this.alphaBuffer,
      this.fillAlphaBuffer,
      this.alphaStitchMode,
      this.d3d11Texture2d,
      this.textureSliceIndex,
      this.hdr10MetadataInfo,
      this.colorSpace});

  /// Video type. See VideoBufferType.
  @JsonKey(name: 'type')
  final VideoBufferType? type;

  /// Pixel format. See VideoPixelFormat.
  @JsonKey(name: 'format')
  final VideoPixelFormat? format;

  /// Video buffer.
  @JsonKey(name: 'buffer', includeFromJson: false, includeToJson: false)
  final Uint8List? buffer;

  /// Stride of the input video frame, in pixels (not bytes). For Texture, this refers to the width of the Texture.
  @JsonKey(name: 'stride')
  final int? stride;

  /// Height of the input video frame.
  @JsonKey(name: 'height')
  final int? height;

  /// This parameter only applies to raw video data.
  @JsonKey(name: 'cropLeft')
  final int? cropLeft;

  /// This parameter only applies to raw video data.
  @JsonKey(name: 'cropTop')
  final int? cropTop;

  /// This parameter only applies to raw video data.
  @JsonKey(name: 'cropRight')
  final int? cropRight;

  /// This parameter only applies to raw video data.
  @JsonKey(name: 'cropBottom')
  final int? cropBottom;

  /// Field related to raw data. Specifies whether to rotate the input video frame clockwise. Options are 0, 90, 180, 270. Default is 0.
  @JsonKey(name: 'rotation')
  final int? rotation;

  /// Timestamp of the input video frame, in milliseconds. Incorrect timestamps may cause frame drops or audio-video desynchronization.
  @JsonKey(name: 'timestamp')
  final int? timestamp;

  /// This parameter only applies to video data in Texture format. Refers to the Texture ID of the video frame.
  @JsonKey(name: 'eglType')
  final EglContextType? eglType;

  /// This parameter only applies to video data in Texture format. It is a 4x4 input transformation matrix, typically an identity matrix.
  @JsonKey(name: 'textureId')
  final int? textureId;

  /// @nodoc
  @JsonKey(name: 'fenceObject')
  final int? fenceObject;

  /// This parameter only applies to video data in Texture format. It is a 4x4 input transformation matrix, typically an identity matrix.
  @JsonKey(name: 'matrix')
  final List<double>? matrix;

  /// This parameter only applies to video data in Texture format. Refers to the data buffer of MetaData, default value is NULL.
  @JsonKey(name: 'metadataBuffer', includeFromJson: false, includeToJson: false)
  final Uint8List? metadataBuffer;

  /// This parameter only applies to video data in Texture format. Refers to the size of MetaData, default value is 0.
  @JsonKey(name: 'metadataSize')
  final int? metadataSize;

  /// Alpha channel data output by portrait segmentation algorithm. This data matches the size of the video frame. Each pixel value ranges from [0,255], where 0 represents background and 255 represents foreground (portrait).
  /// You can use this parameter to render the video background with various effects, such as transparency, solid color, image, video, etc. In custom video rendering scenarios, make sure both the input video frame and alphaBuffer are of Full Range type; other types may cause incorrect rendering of alpha data.
  @JsonKey(name: 'alphaBuffer', includeFromJson: false, includeToJson: false)
  final Uint8List? alphaBuffer;

  /// For video data in BGRA or RGBA format, you can choose either method to set the alpha channel data:
  ///  Automatically fill by setting this parameter to true.
  ///  Set via the alphaBuffer parameter. This parameter only applies to video data in BGRA or RGBA format. Sets whether to extract the alpha channel data from the video frame and automatically fill it into alphaBuffer : true : Extract and fill alpha channel data. false : (default) Do not extract or fill alpha channel data.
  @JsonKey(name: 'fillAlphaBuffer')
  final bool? fillAlphaBuffer;

  /// When the video frame contains alpha channel data, sets the relative position of alphaBuffer to the video frame. See AlphaStitchMode.
  @JsonKey(name: 'alphaStitchMode')
  final AlphaStitchMode? alphaStitchMode;

  /// This parameter only applies to video data in Windows Texture format. Represents a pointer to an object of type ID3D11Texture2D, which is used by the video frame.
  @JsonKey(name: 'd3d11Texture2d', readValue: readIntPtr)
  final int? d3d11Texture2d;

  /// This parameter only applies to video data in Windows Texture format. Indicates the index of the ID3D11Texture2D texture object used by the video frame in the ID3D11Texture2D array.
  @JsonKey(name: 'textureSliceIndex')
  final int? textureSliceIndex;

  /// @nodoc
  @JsonKey(name: 'hdr10MetadataInfo')
  final Hdr10MetadataInfo? hdr10MetadataInfo;

  /// Color space property of the video frame. By default, Full Range and BT.709 standard configuration is applied. You can customize the setting based on your custom capture or rendering requirements. See [VideoColorSpace](https://developer.mozilla.org/en-US/docs/Web/API/VideoColorSpace).
  @JsonKey(name: 'colorSpace')
  final ColorSpace? colorSpace;

  /// @nodoc
  factory ExternalVideoFrame.fromJson(Map<String, dynamic> json) =>
      _$ExternalVideoFrameFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ExternalVideoFrameToJson(this);
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

/// @nodoc
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

/// Video buffer type.
@JsonEnum(alwaysCreate: true)
enum VideoBufferType {
  /// 1: Type is raw data.
  @JsonValue(1)
  videoBufferRawData,

  /// 2: Type is raw data.
  @JsonValue(2)
  videoBufferArray,

  /// 3: Type is Texture.
  @JsonValue(3)
  videoBufferTexture,
}

/// @nodoc
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

/// Video frame property settings.
///
/// The buffer is a pointer to a pointer. This interface cannot modify the buffer pointer, only the content of the buffer.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoFrame implements AgoraSerializable {
  /// @nodoc
  const VideoFrame(
      {this.type,
      this.width,
      this.height,
      this.yStride,
      this.uStride,
      this.vStride,
      this.yBuffer,
      this.uBuffer,
      this.vBuffer,
      this.rotation,
      this.renderTimeMs,
      this.avsyncType,
      this.metadataBuffer,
      this.metadataSize,
      this.textureId,
      this.matrix,
      this.alphaBuffer,
      this.alphaStitchMode,
      this.pixelBuffer,
      this.metaInfo,
      this.hdr10MetadataInfo,
      this.colorSpace});

  /// Pixel format. See VideoPixelFormat.
  @JsonKey(name: 'type')
  final VideoPixelFormat? type;

  /// Pixel width of the video.
  @JsonKey(name: 'width')
  final int? width;

  /// Pixel height of the video.
  @JsonKey(name: 'height')
  final int? height;

  /// For YUV data, the line stride of the Y buffer; for RGBA data, the total data length. When processing video data, you must handle the offset between each row of pixel data based on this parameter; otherwise, image distortion may occur.
  @JsonKey(name: 'yStride')
  final int? yStride;

  /// For YUV data, the line stride of the U buffer; for RGBA data, the value is 0. When processing video data, you must handle the offset between each row of pixel data based on this parameter; otherwise, image distortion may occur.
  @JsonKey(name: 'uStride')
  final int? uStride;

  /// For YUV data, the line stride of the V buffer; for RGBA data, the value is 0. When processing video data, you must handle the offset between each row of pixel data based on this parameter; otherwise, image distortion may occur.
  @JsonKey(name: 'vStride')
  final int? vStride;

  /// For YUV data, the pointer to the Y buffer; for RGBA data, the data buffer.
  @JsonKey(name: 'yBuffer', includeFromJson: false, includeToJson: false)
  final Uint8List? yBuffer;

  /// For YUV data, the pointer to the U buffer; for RGBA data, the value is null.
  @JsonKey(name: 'uBuffer', includeFromJson: false, includeToJson: false)
  final Uint8List? uBuffer;

  /// For YUV data, the pointer to the V buffer; for RGBA data, the value is null.
  @JsonKey(name: 'vBuffer', includeFromJson: false, includeToJson: false)
  final Uint8List? vBuffer;

  /// Clockwise rotation angle of this frame before rendering. Supported values are 0, 90, 180, and 270 degrees.
  @JsonKey(name: 'rotation')
  final int? rotation;

  /// Unix timestamp (in milliseconds) when the video frame is rendered. This timestamp can be used to guide video frame rendering. This parameter is required.
  @JsonKey(name: 'renderTimeMs')
  final int? renderTimeMs;

  /// Reserved parameter.
  @JsonKey(name: 'avsync_type')
  final int? avsyncType;

  /// This parameter applies only to video data in Texture format. It refers to the data buffer of MetaData. Default is NULL.
  @JsonKey(
      name: 'metadata_buffer', includeFromJson: false, includeToJson: false)
  final Uint8List? metadataBuffer;

  /// This parameter applies only to video data in Texture format. It refers to the size of MetaData. Default is 0.
  @JsonKey(name: 'metadata_size')
  final int? metadataSize;

  /// This parameter applies only to video data in Texture format. Texture ID.
  @JsonKey(name: 'textureId')
  final int? textureId;

  /// This parameter applies only to video data in Texture format. A 4x4 transformation matrix input, typically an identity matrix.
  @JsonKey(name: 'matrix')
  final List<double>? matrix;

  /// Alpha channel data output by portrait segmentation algorithm. This data has the same dimensions as the video frame. Each pixel value ranges from [0,255], where 0 represents background and 255 represents foreground (portrait).
  /// By setting this parameter, you can render the video background with various effects such as transparency, solid color, image, or video.
  ///  In custom video rendering scenarios, ensure that both the video frame and alphaBuffer are Full Range type; other types may result in incorrect rendering of Alpha data.
  ///  Make sure that the dimensions of alphaBuffer exactly match the video frame (width × height), otherwise the app may crash.
  @JsonKey(name: 'alphaBuffer', includeFromJson: false, includeToJson: false)
  final Uint8List? alphaBuffer;

  /// When the video frame contains Alpha channel data, sets the relative position of alphaBuffer and the video frame. See AlphaStitchMode.
  @JsonKey(name: 'alphaStitchMode')
  final AlphaStitchMode? alphaStitchMode;

  /// @nodoc
  @JsonKey(name: 'pixelBuffer', includeFromJson: false, includeToJson: false)
  final Uint8List? pixelBuffer;

  /// Metadata in the video frame. This parameter requires [contacting technical support](https://www.agora.io/cn/contact/) to use.
  @VideoFrameMetaInfoConverter()
  @JsonKey(name: 'metaInfo')
  final VideoFrameMetaInfo? metaInfo;

  /// @nodoc
  @JsonKey(name: 'hdr10MetadataInfo')
  final Hdr10MetadataInfo? hdr10MetadataInfo;

  /// Color space properties of the video frame. By default, Full Range and BT.709 configuration is applied. You can customize it according to the needs of custom capture and rendering. See [VideoColorSpace](https://developer.mozilla.org/en-US/docs/Web/API/VideoColorSpace).
  @JsonKey(name: 'colorSpace')
  final ColorSpace? colorSpace;

  /// @nodoc
  factory VideoFrame.fromJson(Map<String, dynamic> json) =>
      _$VideoFrameFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$VideoFrameToJson(this);
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

/// @nodoc
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

/// Video observation position.
@JsonEnum(alwaysCreate: true)
enum VideoModulePosition {
  /// 1: Position after local video capture and preprocessing, corresponding to the onCaptureVideoFrame callback. The observed video at this position includes preprocessing effects and can be verified by enabling beautification, virtual background, or watermark.
  @JsonValue(1 << 0)
  positionPostCapturer,

  /// 2: Position before rendering received remote video, corresponding to the onRenderVideoFrame callback.
  @JsonValue(1 << 1)
  positionPreRenderer,

  /// 4: Position before local video encoding, corresponding to the onPreEncodeVideoFrame callback. The observed video at this position includes preprocessing and pre-encoding effects:
  ///  For preprocessing effects, verify by enabling beautification, virtual background, or watermark.
  ///  For pre-encoding effects, verify by setting a low frame rate (e.g., 5 fps).
  @JsonValue(1 << 2)
  positionPreEncoder,

  /// 8: Position after local video capture and before preprocessing. The observed video at this position does not include preprocessing effects and can be verified by enabling beautification, virtual background, or watermark.
  @JsonValue(1 << 3)
  positionPostCapturerOrigin,
}

/// @nodoc
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

/// @nodoc
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

/// Type of video content inspection module.
@JsonEnum(alwaysCreate: true)
enum ContentInspectType {
  /// 0: (Default) This module has no actual functionality. Do not set type to this value.
  @JsonValue(0)
  contentInspectInvalid,

  /// @nodoc
  @JsonValue(1)
  contentInspectModeration,

  /// 2: Uses Agora's proprietary plugin for screenshot upload. The SDK captures and uploads screenshots of the video stream.
  @JsonValue(2)
  contentInspectSupervision,

  /// 3: Uses Cloud Marketplace plugin for screenshot upload. The SDK uses the Cloud Marketplace video moderation plugin to capture and upload screenshots of the video stream.
  @JsonValue(3)
  contentInspectImageModeration,
}

/// @nodoc
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

/// ContentInspectModule struct for configuring the upload frequency of local screenshots.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ContentInspectModule implements AgoraSerializable {
  /// @nodoc
  const ContentInspectModule({this.type, this.interval, this.position});

  /// The type of function module. See ContentInspectType.
  @JsonKey(name: 'type')
  final ContentInspectType? type;

  /// Interval for uploading local screenshots, in seconds. The value must be greater than 0. Default is 0, meaning no screenshot upload. Recommended value is 10 seconds, but you can adjust it based on your business requirements.
  @JsonKey(name: 'interval')
  final int? interval;

  /// Position of the video observer. See VideoModulePosition.
  @JsonKey(name: 'position')
  final VideoModulePosition? position;

  /// @nodoc
  factory ContentInspectModule.fromJson(Map<String, dynamic> json) =>
      _$ContentInspectModuleFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ContentInspectModuleToJson(this);
}

/// Local screenshot upload configuration.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ContentInspectConfig implements AgoraSerializable {
  /// @nodoc
  const ContentInspectConfig(
      {this.extraInfo, this.serverConfig, this.modules, this.moduleCount});

  /// Additional information, with a maximum length of 1024 bytes.
  /// The SDK uploads the additional information along with the screenshot to the Agora server; after the screenshot is completed, the Agora server sends the additional information to your server along with the callback notification.
  @JsonKey(name: 'extraInfo')
  final String? extraInfo;

  /// (Optional) Server configuration related to video moderation in the Cloud Marketplace. This parameter takes effect only when the type in ContentInspectModule is set to contentInspectImageModeration. To use this feature, please [contact technical support](https://www.agora.io/cn/contact/).
  @JsonKey(name: 'serverConfig')
  final String? serverConfig;

  /// Function modules. See ContentInspectModule.
  /// Supports up to 32 ContentInspectModule instances. The value range for MAX_CONTENT_INSPECT_MODULE_COUNT is an integer between [1, 32]. Only one instance can be configured for each function module. Currently, only screenshot upload is supported.
  @JsonKey(name: 'modules')
  final List<ContentInspectModule>? modules;

  /// The number of function modules, i.e., the number of configured ContentInspectModule instances. Must match the number of instances configured in modules. Maximum value is 32.
  @JsonKey(name: 'moduleCount')
  final int? moduleCount;

  /// @nodoc
  factory ContentInspectConfig.fromJson(Map<String, dynamic> json) =>
      _$ContentInspectConfigFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ContentInspectConfigToJson(this);
}

/// Video snapshot settings.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SnapshotConfig implements AgoraSerializable {
  /// @nodoc
  const SnapshotConfig({this.filePath, this.position});

  /// Make sure the directory exists and is writable. Local path to save the snapshot, including file name and format. For example:
  ///  Windows: `C:\Users\<user_name>\AppData\Local\Agora\<process_name>\example.jpg`
  ///  iOS: /App Sandbox/Library/Caches/example.jpg
  ///  macOS: ～/Library/Logs/example.jpg
  ///  Android: `/storage/emulated/0/Android/data/<package name>/files/example.jpg`
  @JsonKey(name: 'filePath')
  final String? filePath;

  /// The position of the video frame to snapshot within the video pipeline. See VideoModulePosition.
  @JsonKey(name: 'position')
  final VideoModulePosition? position;

  /// @nodoc
  factory SnapshotConfig.fromJson(Map<String, dynamic> json) =>
      _$SnapshotConfigFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SnapshotConfigToJson(this);
}

/// This class is used to obtain raw PCM audio data.
///
/// You can inherit this class and implement the onFrame callback to get PCM audio data.
class AudioPcmFrameSink {
  /// @nodoc
  const AudioPcmFrameSink({
    this.onFrame,
  });

  /// Callback for received audio frame.
  ///
  /// After registering the audio data observer, this callback is triggered each time an audio frame is received to report audio frame information.
  ///
  /// * [frame] Audio frame information. See AudioPcmFrame.
  final void Function(AudioPcmFrame frame)? onFrame;
}

/// Audio observer.
///
/// You can call registerAudioFrameObserver to register or unregister the AudioFrameObserverBase.
class AudioFrameObserverBase {
  /// @nodoc
  const AudioFrameObserverBase({
    this.onRecordAudioFrame,
    this.onPlaybackAudioFrame,
    this.onMixedAudioFrame,
    this.onEarMonitoringAudioFrame,
  });

  /// Retrieves the raw audio data collected.
  ///
  /// To ensure the format of the recorded audio data meets expectations, you can set the audio data format using the following methods: Call setRecordingAudioFrameParameters to set the audio data format, then call registerAudioFrameObserver to register the audio frame observer object. The SDK calculates the sampling interval based on the parameters of this method and triggers the onRecordAudioFrame callback accordingly.
  ///  Due to framework limitations, this callback does not support sending the processed audio data back to the SDK.
  ///
  /// * [audioFrame] Raw audio data. See AudioFrame.
  /// * [channelId] Channel ID.
  final void Function(String channelId, AudioFrame audioFrame)?
      onRecordAudioFrame;

  /// Retrieves the raw audio data being played.
  ///
  /// To ensure the format of the playback audio data meets expectations, you can set the audio data format using the following methods: Call setPlaybackAudioFrameParameters to set the audio data format, then call registerAudioFrameObserver to register the audio frame observer object. The SDK calculates the sampling interval based on the parameters of this method and triggers the onPlaybackAudioFrame callback accordingly.
  ///  Due to framework limitations, this callback does not support sending the processed audio data back to the SDK.
  ///
  /// * [audioFrame] Raw audio data. See AudioFrame.
  /// * [channelId] Channel ID.
  final void Function(String channelId, AudioFrame audioFrame)?
      onPlaybackAudioFrame;

  /// Retrieves the data after mixing recorded and playback audio.
  ///
  /// To ensure the format of the mixed audio data from recording and playback meets expectations, you can set the audio data format using the following methods: Call setMixedAudioFrameParameters to set the audio data format, then call registerAudioFrameObserver to register the audio frame observer object. The SDK calculates the sampling interval based on the parameters of this method and triggers the onMixedAudioFrame callback accordingly.
  ///  Due to framework limitations, this callback does not support sending the processed audio data back to the SDK.
  ///
  /// * [audioFrame] Raw audio data. See AudioFrame.
  /// * [channelId] Channel ID.
  final void Function(String channelId, AudioFrame audioFrame)?
      onMixedAudioFrame;

  /// Receives the raw audio data for ear monitoring.
  ///
  /// To ensure the audio data format for ear monitoring meets expectations, you can set the format using the following methods: Call setEarMonitoringAudioFrameParameters to set the audio data format, then call registerAudioFrameObserver to register the audio observer object. The SDK calculates the sampling interval based on the parameters in this method and triggers the onEarMonitoringAudioFrame callback accordingly.
  ///  Due to framework limitations, this callback does not support sending the processed audio data back to the SDK.
  ///
  /// * [audioFrame] The raw audio data. See AudioFrame.
  final void Function(AudioFrame audioFrame)? onEarMonitoringAudioFrame;
}

/// Audio frame type.
@JsonEnum(alwaysCreate: true)
enum AudioFrameType {
  /// 0: PCM 16
  @JsonValue(0)
  frameTypePcm16,
}

/// @nodoc
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

/// Raw audio data.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioFrame implements AgoraSerializable {
  /// @nodoc
  const AudioFrame(
      {this.type,
      this.samplesPerChannel,
      this.bytesPerSample,
      this.channels,
      this.samplesPerSec,
      this.buffer,
      this.renderTimeMs,
      this.avsyncType,
      this.presentationMs,
      this.audioTrackNumber,
      this.rtpTimestamp});

  /// Audio frame type. See AudioFrameType.
  @JsonKey(name: 'type')
  final AudioFrameType? type;

  /// Number of samples per channel.
  @JsonKey(name: 'samplesPerChannel')
  final int? samplesPerChannel;

  /// Number of bytes per sample. For PCM, typically 16 bits, i.e., two bytes.
  @JsonKey(name: 'bytesPerSample')
  final BytesPerSample? bytesPerSample;

  /// Number of channels (data is interleaved if stereo).
  ///  1: Mono
  ///  2: Stereo
  @JsonKey(name: 'channels')
  final int? channels;

  /// Number of samples per second per channel.
  @JsonKey(name: 'samplesPerSec')
  final int? samplesPerSec;

  /// Audio data buffer (data is interleaved if stereo).
  /// Buffer size buffer = samples × channels × bytesPerSample.
  @JsonKey(name: 'buffer', includeFromJson: false, includeToJson: false)
  final Uint8List? buffer;

  /// Render timestamp of the external audio frame.
  /// You can use this timestamp to restore the audio frame order; in scenarios with video (including external video source), this parameter can be used to achieve audio-video synchronization.
  @JsonKey(name: 'renderTimeMs')
  final int? renderTimeMs;

  /// Reserved parameter.
  @JsonKey(name: 'avsync_type')
  final int? avsyncType;

  /// @nodoc
  @JsonKey(name: 'presentationMs')
  final int? presentationMs;

  /// @nodoc
  @JsonKey(name: 'audioTrackNumber')
  final int? audioTrackNumber;

  /// @nodoc
  @JsonKey(name: 'rtpTimestamp')
  final int? rtpTimestamp;

  /// @nodoc
  factory AudioFrame.fromJson(Map<String, dynamic> json) =>
      _$AudioFrameFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AudioFrameToJson(this);
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum AudioFramePosition {
  /// @nodoc
  @JsonValue(0x0000)
  audioFramePositionNone,

  /// @nodoc
  @JsonValue(0x0001)
  audioFramePositionPlayback,

  /// @nodoc
  @JsonValue(0x0002)
  audioFramePositionRecord,

  /// @nodoc
  @JsonValue(0x0004)
  audioFramePositionMixed,

  /// @nodoc
  @JsonValue(0x0008)
  audioFramePositionBeforeMixing,

  /// @nodoc
  @JsonValue(0x0010)
  audioFramePositionEarMonitoring,
}

/// @nodoc
extension AudioFramePositionExt on AudioFramePosition {
  /// @nodoc
  static AudioFramePosition fromValue(int value) {
    return $enumDecode(_$AudioFramePositionEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$AudioFramePositionEnumMap[this]!;
  }
}

/// Audio data format.
///
/// The SDK calculates the sampling interval based on the samplesPerCall, sampleRate, and channel parameters in AudioParams, and triggers the onRecordAudioFrame, onPlaybackAudioFrame, onMixedAudioFrame, and onEarMonitoringAudioFrame callbacks accordingly.
///  Sampling interval = samplesPerCall / (sampleRate × channel).
///  Make sure the sampling interval is not less than 0.01 (s).
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioParams implements AgoraSerializable {
  /// @nodoc
  const AudioParams(
      {this.sampleRate, this.channels, this.mode, this.samplesPerCall});

  /// Sampling rate of the data in Hz. The possible values are:
  ///  8000
  ///  16000 (default)
  ///  32000
  ///  44100
  ///  48000
  @JsonKey(name: 'sample_rate')
  final int? sampleRate;

  /// Number of audio channels. The possible values are:
  ///  1: Mono (default)
  ///  2: Stereo
  @JsonKey(name: 'channels')
  final int? channels;

  /// Usage mode of the data. See RawAudioFrameOpModeType.
  @JsonKey(name: 'mode')
  final RawAudioFrameOpModeType? mode;

  /// Number of audio samples per call, typically 1024 in scenarios like media stream relay.
  @JsonKey(name: 'samples_per_call')
  final int? samplesPerCall;

  /// @nodoc
  factory AudioParams.fromJson(Map<String, dynamic> json) =>
      _$AudioParamsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AudioParamsToJson(this);
}

/// Audio observer.
///
/// You can call registerAudioFrameObserver to register or unregister the AudioFrameObserver.
class AudioFrameObserver extends AudioFrameObserverBase {
  /// @nodoc
  const AudioFrameObserver({
    /// @nodoc
    void Function(String channelId, AudioFrame audioFrame)? onRecordAudioFrame,

    /// @nodoc
    void Function(String channelId, AudioFrame audioFrame)?
        onPlaybackAudioFrame,

    /// @nodoc
    void Function(String channelId, AudioFrame audioFrame)? onMixedAudioFrame,

    /// @nodoc
    void Function(AudioFrame audioFrame)? onEarMonitoringAudioFrame,
    this.onPlaybackAudioFrameBeforeMixing,
  }) : super(
          onRecordAudioFrame: onRecordAudioFrame,
          onPlaybackAudioFrame: onPlaybackAudioFrame,
          onMixedAudioFrame: onMixedAudioFrame,
          onEarMonitoringAudioFrame: onEarMonitoringAudioFrame,
        );

  /// Retrieves the audio of a subscribed remote user before mixing.
  ///
  /// Due to framework limitations, this callback does not support sending the processed audio data back to the SDK.
  ///
  /// * [channelId] Channel ID.
  /// * [uid] ID of the subscribed remote user.
  /// * [audioFrame] Raw audio data. See AudioFrame.
  final void Function(String channelId, int uid, AudioFrame audioFrame)?
      onPlaybackAudioFrameBeforeMixing;
}

/// Audio spectrum data.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioSpectrumData implements AgoraSerializable {
  /// @nodoc
  const AudioSpectrumData({this.audioSpectrumData, this.dataLength});

  /// Audio spectrum data. The SDK divides the audio frequency into 256 bands and reports the energy value of each band through this parameter. The value range of each energy is [-300, 1], in dBFS.
  @JsonKey(name: 'audioSpectrumData')
  final List<double>? audioSpectrumData;

  /// The length of the audio spectrum data is 256.
  @JsonKey(name: 'dataLength')
  final int? dataLength;

  /// @nodoc
  factory AudioSpectrumData.fromJson(Map<String, dynamic> json) =>
      _$AudioSpectrumDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AudioSpectrumDataToJson(this);
}

/// Audio spectrum information of a remote user.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class UserAudioSpectrumInfo implements AgoraSerializable {
  /// @nodoc
  const UserAudioSpectrumInfo({this.uid, this.spectrumData});

  /// Remote user ID.
  @JsonKey(name: 'uid')
  final int? uid;

  /// Audio spectrum data of the remote user. See AudioSpectrumData.
  @JsonKey(name: 'spectrumData')
  final AudioSpectrumData? spectrumData;

  /// @nodoc
  factory UserAudioSpectrumInfo.fromJson(Map<String, dynamic> json) =>
      _$UserAudioSpectrumInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserAudioSpectrumInfoToJson(this);
}

/// Audio spectrum observer.
class AudioSpectrumObserver {
  /// @nodoc
  const AudioSpectrumObserver({
    this.onLocalAudioSpectrum,
    this.onRemoteAudioSpectrum,
  });

  /// Gets the local audio spectrum.
  ///
  /// After successfully calling registerAudioSpectrumObserver to implement the onLocalAudioSpectrum callback in AudioSpectrumObserver and calling enableAudioSpectrumMonitor to enable audio spectrum monitoring, the SDK triggers this callback at the set time interval to report the spectrum of the local audio data before encoding.
  ///
  /// * [data] The local user's audio spectrum data. See AudioSpectrumData.
  final void Function(AudioSpectrumData data)? onLocalAudioSpectrum;

  /// Gets the remote audio spectrum.
  ///
  /// After successfully calling registerAudioSpectrumObserver to implement the onRemoteAudioSpectrum callback in AudioSpectrumObserver and calling enableAudioSpectrumMonitor to enable audio spectrum monitoring, the SDK triggers this callback at the set time interval to report the spectrum of the received remote audio data.
  ///
  /// * [spectrums] The audio spectrum information of remote users. See UserAudioSpectrumInfo. The number of elements in the array equals the number of remote users detected by the SDK. An empty array means no remote audio spectrum is detected.
  /// * [spectrumNumber] The number of remote users.
  final void Function(
          List<UserAudioSpectrumInfo> spectrums, int spectrumNumber)?
      onRemoteAudioSpectrum;
}

/// Class used to receive encoded video frames.
class VideoEncodedFrameObserver {
  /// @nodoc
  const VideoEncodedFrameObserver({
    this.onEncodedVideoFrameReceived,
  });

  /// Reports that the receiver has received a remote encoded video frame.
  ///
  /// When you call the setRemoteVideoSubscriptionOptions method and set encodedFrameOnly to true, the SDK triggers this callback locally to report the received encoded video frame information.
  ///
  /// * [channelId] Channel name.
  /// * [uid] Remote user ID.
  /// * [imageBuffer] Video frame buffer.
  /// * [length] Data length of the video frame.
  /// * [videoEncodedFrameInfo] Information about the encoded video frame. See EncodedVideoFrameInfo.
  final void Function(int uid, Uint8List imageBuffer, int length,
      EncodedVideoFrameInfo videoEncodedFrameInfo)? onEncodedVideoFrameReceived;
}

/// Video observer.
///
/// You can call registerVideoFrameObserver to register or unregister the VideoFrameObserver.
class VideoFrameObserver {
  /// @nodoc
  const VideoFrameObserver({
    this.onCaptureVideoFrame,
    this.onPreEncodeVideoFrame,
    this.onMediaPlayerVideoFrame,
    this.onRenderVideoFrame,
    this.onTranscodedVideoFrame,
  });

  /// Gets the video data captured by the local device.
  ///
  /// You can get the raw video data captured by the local device in the callback.
  ///  If the video data you get is of RGBA type, the SDK does not support processing the Alpha channel.
  ///  It is recommended that you ensure the modified parameters in videoFrame match the actual video frame in the buffer; otherwise, unexpected rotation, distortion, etc., may occur in the local preview or remote video.
  ///  Due to framework limitations, this callback does not support sending the processed video data back to the SDK.
  ///
  /// * [sourceType] Type of video source, which may include camera, screen, or media player. See VideoSourceType.
  /// * [videoFrame] Video frame data. See VideoFrame. The default format of the video frame data obtained through this callback is as follows:
  ///  Android: I420
  ///  iOS: I420
  ///  macOS: I420
  ///  Windows: YUV420
  final void Function(VideoSourceType sourceType, VideoFrame videoFrame)?
      onCaptureVideoFrame;

  /// Gets the video data before local encoding.
  ///
  /// After successfully registering the video data observer, the SDK triggers this callback each time a video frame is captured. You can get the video data before encoding in the callback and process it as needed for your scenario.
  ///  Due to framework limitations, this callback does not support sending the processed video data back to the SDK.
  ///  The video data obtained here has already undergone preprocessing such as cropping, rotation, and beauty effects.
  ///  It is recommended that you ensure the modified parameters in videoFrame match the actual video frame in the buffer; otherwise, unexpected rotation, distortion, etc., may occur in the local preview or remote video.
  ///
  /// * [sourceType] Type of video source. See VideoSourceType.
  /// * [videoFrame] Video frame data. See VideoFrame. The default format of the video frame data obtained through this callback is as follows:
  ///  Android: I420
  ///  iOS: I420
  ///  macOS: I420
  ///  Windows: YUV420
  final void Function(VideoSourceType sourceType, VideoFrame videoFrame)?
      onPreEncodeVideoFrame;

  /// @nodoc
  final void Function(VideoFrame videoFrame, int mediaPlayerId)?
      onMediaPlayerVideoFrame;

  /// Gets the video data sent from the remote user.
  ///
  /// After successfully registering the video data observer, the SDK triggers this callback each time a video frame is captured. You can get the video data sent from the remote user before rendering and process it as needed for your scenario.
  ///  If the video data you get is of RGBA type, the SDK does not support processing the Alpha channel.
  ///  Due to framework limitations, this callback does not support sending the processed video data back to the SDK.
  ///  It is recommended that you ensure the modified parameters in videoFrame match the actual video frame in the buffer; otherwise, unexpected rotation, distortion, etc., may occur in the local preview or remote video.
  ///
  /// * [remoteUid] Remote user ID who sent the video frame.
  /// * [videoFrame] Video frame data. See VideoFrame. The default format of the video frame data obtained through this callback is as follows:
  ///  Android: I420
  ///  iOS: I420
  ///  macOS: I420
  ///  Windows: YUV420
  /// * [channelId] Channel ID.
  final void Function(String channelId, int remoteUid, VideoFrame videoFrame)?
      onRenderVideoFrame;

  /// @nodoc
  final void Function(VideoFrame videoFrame)? onTranscodedVideoFrame;
}

/// Video frame processing mode.
@JsonEnum(alwaysCreate: true)
enum VideoFrameProcessMode {
  /// Read-only mode.
  /// In read-only mode, you do not modify video frames. The video observer acts as a renderer.
  @JsonValue(0)
  processModeReadOnly,

  /// Read-write mode.
  /// In read-write mode, you modify video frames. The video observer acts as a video filter.
  @JsonValue(1)
  processModeReadWrite,
}

/// @nodoc
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

/// Encoding type of external video frames.
@JsonEnum(alwaysCreate: true)
enum ExternalVideoSourceType {
  /// 0: Unencoded video frame.
  @JsonValue(0)
  videoFrame,

  /// 1: Encoded video frame.
  @JsonValue(1)
  encodedVideoFrame,
}

/// @nodoc
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

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum MediaRecorderContainerFormat {
  /// @nodoc
  @JsonValue(1)
  formatMp4,
}

/// @nodoc
extension MediaRecorderContainerFormatExt on MediaRecorderContainerFormat {
  /// @nodoc
  static MediaRecorderContainerFormat fromValue(int value) {
    return $enumDecode(_$MediaRecorderContainerFormatEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$MediaRecorderContainerFormatEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum MediaRecorderStreamType {
  /// @nodoc
  @JsonValue(0x01)
  streamTypeAudio,

  /// @nodoc
  @JsonValue(0x02)
  streamTypeVideo,

  /// @nodoc
  @JsonValue(0x01 | 0x02)
  streamTypeBoth,
}

/// @nodoc
extension MediaRecorderStreamTypeExt on MediaRecorderStreamType {
  /// @nodoc
  static MediaRecorderStreamType fromValue(int value) {
    return $enumDecode(_$MediaRecorderStreamTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$MediaRecorderStreamTypeEnumMap[this]!;
  }
}

/// Current recording state.
@JsonEnum(alwaysCreate: true)
enum RecorderState {
  /// -1: Audio/video stream recording error. See RecorderReasonCode.
  @JsonValue(-1)
  recorderStateError,

  /// 2: Audio/video stream recording started.
  @JsonValue(2)
  recorderStateStart,

  /// 3: Audio/video stream recording stopped.
  @JsonValue(3)
  recorderStateStop,
}

/// @nodoc
extension RecorderStateExt on RecorderState {
  /// @nodoc
  static RecorderState fromValue(int value) {
    return $enumDecode(_$RecorderStateEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$RecorderStateEnumMap[this]!;
  }
}

/// Reason for recording state error.
@JsonEnum(alwaysCreate: true)
enum RecorderReasonCode {
  /// 0: Everything is normal.
  @JsonValue(0)
  recorderReasonNone,

  /// 1: Failed to write the recording file.
  @JsonValue(1)
  recorderReasonWriteFailed,

  /// 2: No audio/video stream to record or the stream was interrupted for more than 5 seconds.
  @JsonValue(2)
  recorderReasonNoStream,

  /// 3: Recording duration exceeds the limit.
  @JsonValue(3)
  recorderReasonOverMaxDuration,

  /// 4: Recording configuration changed.
  @JsonValue(4)
  recorderReasonConfigChanged,
}

/// @nodoc
extension RecorderReasonCodeExt on RecorderReasonCode {
  /// @nodoc
  static RecorderReasonCode fromValue(int value) {
    return $enumDecode(_$RecorderReasonCodeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$RecorderReasonCodeEnumMap[this]!;
  }
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MediaRecorderConfiguration implements AgoraSerializable {
  /// @nodoc
  const MediaRecorderConfiguration(
      {this.storagePath,
      this.containerFormat,
      this.streamType,
      this.maxDurationMs,
      this.recorderInfoUpdateInterval,
      this.width,
      this.height,
      this.fps,
      this.sampleRate,
      this.channelNum,
      this.videoSourceType});

  /// @nodoc
  @JsonKey(name: 'storagePath')
  final String? storagePath;

  /// @nodoc
  @JsonKey(name: 'containerFormat')
  final MediaRecorderContainerFormat? containerFormat;

  /// @nodoc
  @JsonKey(name: 'streamType')
  final MediaRecorderStreamType? streamType;

  /// @nodoc
  @JsonKey(name: 'maxDurationMs')
  final int? maxDurationMs;

  /// @nodoc
  @JsonKey(name: 'recorderInfoUpdateInterval')
  final int? recorderInfoUpdateInterval;

  /// @nodoc
  @JsonKey(name: 'width')
  final int? width;

  /// @nodoc
  @JsonKey(name: 'height')
  final int? height;

  /// @nodoc
  @JsonKey(name: 'fps')
  final int? fps;

  /// @nodoc
  @JsonKey(name: 'sample_rate')
  final int? sampleRate;

  /// @nodoc
  @JsonKey(name: 'channel_num')
  final int? channelNum;

  /// @nodoc
  @JsonKey(name: 'videoSourceType')
  final VideoSourceType? videoSourceType;

  /// @nodoc
  factory MediaRecorderConfiguration.fromJson(Map<String, dynamic> json) =>
      _$MediaRecorderConfigurationFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MediaRecorderConfigurationToJson(this);
}

/// Face information observer.
///
/// You can call registerFaceInfoObserver to register the FaceInfoObserver.
class FaceInfoObserver {
  /// @nodoc
  const FaceInfoObserver({
    this.onFaceInfo,
  });

  /// Reports the face information processed by the voice driver plugin.
  ///
  /// * [outFaceInfo] Output parameter. A JSON string of face information processed by the voice driver plugin, containing the following fields:
  ///  faces: Array of objects. Contains information of detected faces, each face corresponds to one object.
  ///  blendshapes: Object. Blend shape coefficient set, named according to ARkit standards. Each key-value pair represents a blend shape coefficient. The coefficient is a float ranging from [0.0, 1.0].
  ///  rotation: Array of objects. Head rotation values, including the following three key-value pairs, with float values ranging from [-180.0, 180.0]:
  ///  pitch: Head pitch angle. Positive when looking down, negative when looking up.
  ///  yaw: Head yaw angle. Positive when turning left, negative when turning right.
  ///  roll: Head roll angle. Positive when tilting right, negative when tilting left.
  ///  timestamp: String. Timestamp of the output result in milliseconds. Example JSON: { "faces":[{ "blendshapes":{ "eyeBlinkLeft":0.9, "eyeLookDownLeft":0.0, "eyeLookInLeft":0.0, "eyeLookOutLeft":0.0, "eyeLookUpLeft":0.0, "eyeSquintLeft":0.0, "eyeWideLeft":0.0, "eyeBlinkRight":0.0, "eyeLookDownRight":0.0, "eyeLookInRight":0.0, "eyeLookOutRight":0.0, "eyeLookUpRight":0.0, "eyeSquintRight":0.0, "eyeWideRight":0.0, "jawForward":0.0, "jawLeft":0.0, "jawRight":0.0, "jawOpen":0.0, "mouthClose":0.0, "mouthFunnel":0.0, "mouthPucker":0.0, "mouthLeft":0.0, "mouthRight":0.0, "mouthSmileLeft":0.0, "mouthSmileRight":0.0, "mouthFrownLeft":0.0, "mouthFrownRight":0.0, "mouthDimpleLeft":0.0, "mouthDimpleRight":0.0, "mouthStretchLeft":0.0, "mouthStretchRight":0.0, "mouthRollLower":0.0, "mouthRollUpper":0.0, "mouthShrugLower":0.0, "mouthShrugUpper":0.0, "mouthPressLeft":0.0, "mouthPressRight":0.0, "mouthLowerDownLeft":0.0, "mouthLowerDownRight":0.0, "mouthUpperUpLeft":0.0, "mouthUpperUpRight":0.0, "browDownLeft":0.0, "browDownRight":0.0, "browInnerUp":0.0, "browOuterUpLeft":0.0, "browOuterUpRight":0.0, "cheekPuff":0.0, "cheekSquintLeft":0.0, "cheekSquintRight":0.0, "noseSneerLeft":0.0, "noseSneerRight":0.0, "tongueOut":0.0 }, "rotation":{"pitch":30.0, "yaw":25.5, "roll":-15.5}, }], "timestamp":"654879876546" }
  ///
  /// Returns
  /// true : Face information JSON parsed successfully. false : Face information JSON parsing failed.
  final void Function(String outFaceInfo)? onFaceInfo;
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RecorderInfo implements AgoraSerializable {
  /// @nodoc
  const RecorderInfo({this.fileName, this.durationMs, this.fileSize});

  /// @nodoc
  @JsonKey(name: 'fileName')
  final String? fileName;

  /// @nodoc
  @JsonKey(name: 'durationMs')
  final int? durationMs;

  /// @nodoc
  @JsonKey(name: 'fileSize')
  final int? fileSize;

  /// @nodoc
  factory RecorderInfo.fromJson(Map<String, dynamic> json) =>
      _$RecorderInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RecorderInfoToJson(this);
}

/// @nodoc
class MediaRecorderObserver {
  /// @nodoc
  const MediaRecorderObserver({
    this.onRecorderStateChanged,
    this.onRecorderInfoUpdated,
  });

  /// @nodoc
  final void Function(String channelId, int uid, RecorderState state,
      RecorderReasonCode reason)? onRecorderStateChanged;

  /// @nodoc
  final void Function(String channelId, int uid, RecorderInfo info)?
      onRecorderInfoUpdated;
}
