import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_media_base.g.dart';

/// @nodoc
const defaultConnectionId = 0;

/// @nodoc
const dummyConnectionId = 4294967295;

@JsonEnum(alwaysCreate: true)
enum AudioRoute {
  @JsonValue(-1)
  routeDefault,

  @JsonValue(0)
  routeHeadset,

  @JsonValue(1)
  routeEarpiece,

  @JsonValue(2)
  routeHeadsetnomic,

  @JsonValue(3)
  routeSpeakerphone,

  @JsonValue(4)
  routeLoudspeaker,

  @JsonValue(5)
  routeHeadsetbluetooth,

  @JsonValue(6)
  routeUsb,

  @JsonValue(7)
  routeHdmi,

  @JsonValue(8)
  routeDisplayport,

  @JsonValue(9)
  routeAirplay,
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

@JsonEnum(alwaysCreate: true)
enum BytesPerSample {
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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioParameters {
  const AudioParameters({this.sampleRate, this.channels, this.framesPerBuffer});

  @JsonKey(name: 'sample_rate')
  final int? sampleRate;

  @JsonKey(name: 'channels')
  final int? channels;

  @JsonKey(name: 'frames_per_buffer')
  final int? framesPerBuffer;
  factory AudioParameters.fromJson(Map<String, dynamic> json) =>
      _$AudioParametersFromJson(json);
  Map<String, dynamic> toJson() => _$AudioParametersToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum RawAudioFrameOpModeType {
  @JsonValue(0)
  rawAudioFrameOpModeReadOnly,

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

@JsonEnum(alwaysCreate: true)
enum MediaSourceType {
  @JsonValue(0)
  audioPlayoutSource,

  @JsonValue(1)
  audioRecordingSource,

  @JsonValue(2)
  primaryCameraSource,

  @JsonValue(3)
  secondaryCameraSource,

  @JsonValue(4)
  primaryScreenSource,

  @JsonValue(5)
  secondaryScreenSource,

  @JsonValue(6)
  customVideoSource,

  @JsonValue(7)
  mediaPlayerSource,

  @JsonValue(8)
  rtcImagePngSource,

  @JsonValue(9)
  rtcImageJpegSource,

  @JsonValue(10)
  rtcImageGifSource,

  @JsonValue(11)
  remoteVideoSource,

  @JsonValue(12)
  transcodedVideoSource,

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

@JsonEnum(alwaysCreate: true)
enum ContentInspectResult {
  @JsonValue(1)
  contentInspectNeutral,

  @JsonValue(2)
  contentInspectSexy,

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

@JsonEnum(alwaysCreate: true)
enum ContentInspectType {
  @JsonValue(0)
  contentInspectInvalid,

  @JsonValue(1)
  contentInspectModeration,

  @JsonValue(2)
  contentInspectSupervision,
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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ContentInspectModule {
  const ContentInspectModule({this.type, this.interval});

  @JsonKey(name: 'type')
  final ContentInspectType? type;

  @JsonKey(name: 'interval')
  final int? interval;
  factory ContentInspectModule.fromJson(Map<String, dynamic> json) =>
      _$ContentInspectModuleFromJson(json);
  Map<String, dynamic> toJson() => _$ContentInspectModuleToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ContentInspectConfig {
  const ContentInspectConfig({this.extraInfo, this.modules, this.moduleCount});

  @JsonKey(name: 'extraInfo')
  final String? extraInfo;

  @JsonKey(name: 'modules')
  final List<ContentInspectModule>? modules;

  @JsonKey(name: 'moduleCount')
  final int? moduleCount;
  factory ContentInspectConfig.fromJson(Map<String, dynamic> json) =>
      _$ContentInspectConfigFromJson(json);
  Map<String, dynamic> toJson() => _$ContentInspectConfigToJson(this);
}

/// @nodoc
const kMaxCodecNameLength = 50;

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class PacketOptions {
  const PacketOptions({this.timestamp, this.audioLevelIndication});

  @JsonKey(name: 'timestamp')
  final int? timestamp;

  @JsonKey(name: 'audioLevelIndication')
  final int? audioLevelIndication;
  factory PacketOptions.fromJson(Map<String, dynamic> json) =>
      _$PacketOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$PacketOptionsToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioEncodedFrameInfo {
  const AudioEncodedFrameInfo({this.sendTs, this.codec});

  @JsonKey(name: 'sendTs')
  final int? sendTs;

  @JsonKey(name: 'codec')
  final int? codec;
  factory AudioEncodedFrameInfo.fromJson(Map<String, dynamic> json) =>
      _$AudioEncodedFrameInfoFromJson(json);
  Map<String, dynamic> toJson() => _$AudioEncodedFrameInfoToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioPcmFrame {
  const AudioPcmFrame(
      {this.captureTimestamp,
      this.samplesPerChannel,
      this.sampleRateHz,
      this.numChannels,
      this.bytesPerSample,
      this.data});

  @JsonKey(name: 'capture_timestamp')
  final int? captureTimestamp;

  @JsonKey(name: 'samples_per_channel_')
  final int? samplesPerChannel;

  @JsonKey(name: 'sample_rate_hz_')
  final int? sampleRateHz;

  @JsonKey(name: 'num_channels_')
  final int? numChannels;

  @JsonKey(name: 'bytes_per_sample')
  final BytesPerSample? bytesPerSample;

  @JsonKey(name: 'data_')
  final List<int>? data;
  factory AudioPcmFrame.fromJson(Map<String, dynamic> json) =>
      _$AudioPcmFrameFromJson(json);
  Map<String, dynamic> toJson() => _$AudioPcmFrameToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum AudioDualMonoMode {
  @JsonValue(0)
  audioDualMonoStereo,

  @JsonValue(1)
  audioDualMonoL,

  @JsonValue(2)
  audioDualMonoR,

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

@JsonEnum(alwaysCreate: true)
enum VideoPixelFormat {
  @JsonValue(0)
  videoPixelDefault,

  @JsonValue(1)
  videoPixelI420,

  @JsonValue(2)
  videoPixelBgra,

  @JsonValue(3)
  videoPixelNv21,

  @JsonValue(4)
  videoPixelRgba,

  @JsonValue(8)
  videoPixelNv12,

  @JsonValue(10)
  videoTexture2d,

  @JsonValue(11)
  videoTextureOes,

  @JsonValue(12)
  videoCvpixelNv12,

  @JsonValue(13)
  videoCvpixelI420,

  @JsonValue(14)
  videoCvpixelBgra,

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

@JsonEnum(alwaysCreate: true)
enum RenderModeType {
  @JsonValue(1)
  renderModeHidden,

  @JsonValue(2)
  renderModeFit,

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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ExternalVideoFrame {
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
      this.matrix,
      this.metadataBuffer,
      this.metadataSize});

  @JsonKey(name: 'type')
  final VideoBufferType? type;

  @JsonKey(name: 'format')
  final VideoPixelFormat? format;

  @JsonKey(name: 'buffer', ignore: true)
  final Uint8List? buffer;

  @JsonKey(name: 'stride')
  final int? stride;

  @JsonKey(name: 'height')
  final int? height;

  @JsonKey(name: 'cropLeft')
  final int? cropLeft;

  @JsonKey(name: 'cropTop')
  final int? cropTop;

  @JsonKey(name: 'cropRight')
  final int? cropRight;

  @JsonKey(name: 'cropBottom')
  final int? cropBottom;

  @JsonKey(name: 'rotation')
  final int? rotation;

  @JsonKey(name: 'timestamp')
  final int? timestamp;

  @JsonKey(name: 'eglType')
  final EglContextType? eglType;

  @JsonKey(name: 'textureId')
  final int? textureId;

  @JsonKey(name: 'matrix')
  final List<double>? matrix;

  @JsonKey(name: 'metadata_buffer', ignore: true)
  final Uint8List? metadataBuffer;

  @JsonKey(name: 'metadata_size')
  final int? metadataSize;
  factory ExternalVideoFrame.fromJson(Map<String, dynamic> json) =>
      _$ExternalVideoFrameFromJson(json);
  Map<String, dynamic> toJson() => _$ExternalVideoFrameToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum EglContextType {
  @JsonValue(0)
  eglContext10,

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

@JsonEnum(alwaysCreate: true)
enum VideoBufferType {
  @JsonValue(1)
  videoBufferRawData,

  @JsonValue(2)
  videoBufferArray,

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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoFrame {
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
      this.alphaBuffer});

  @JsonKey(name: 'type')
  final VideoPixelFormat? type;

  @JsonKey(name: 'width')
  final int? width;

  @JsonKey(name: 'height')
  final int? height;

  @JsonKey(name: 'yStride')
  final int? yStride;

  @JsonKey(name: 'uStride')
  final int? uStride;

  @JsonKey(name: 'vStride')
  final int? vStride;

  @JsonKey(name: 'yBuffer', ignore: true)
  final Uint8List? yBuffer;

  @JsonKey(name: 'uBuffer', ignore: true)
  final Uint8List? uBuffer;

  @JsonKey(name: 'vBuffer', ignore: true)
  final Uint8List? vBuffer;

  @JsonKey(name: 'rotation')
  final int? rotation;

  @JsonKey(name: 'renderTimeMs')
  final int? renderTimeMs;

  @JsonKey(name: 'avsync_type')
  final int? avsyncType;

  @JsonKey(name: 'metadata_buffer', ignore: true)
  final Uint8List? metadataBuffer;

  @JsonKey(name: 'metadata_size')
  final int? metadataSize;

  @JsonKey(name: 'textureId')
  final int? textureId;

  @JsonKey(name: 'matrix')
  final List<double>? matrix;

  @JsonKey(name: 'alphaBuffer', ignore: true)
  final Uint8List? alphaBuffer;
  factory VideoFrame.fromJson(Map<String, dynamic> json) =>
      _$VideoFrameFromJson(json);
  Map<String, dynamic> toJson() => _$VideoFrameToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum MediaPlayerSourceType {
  @JsonValue(0)
  mediaPlayerSourceDefault,

  @JsonValue(1)
  mediaPlayerSourceFullFeatured,

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

@JsonEnum(alwaysCreate: true)
enum VideoModulePosition {
  @JsonValue(1 << 0)
  positionPostCapturer,

  @JsonValue(1 << 1)
  positionPreRenderer,

  @JsonValue(1 << 2)
  positionPreEncoder,

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

class AudioFrameObserverBase {
  /// Construct the [AudioFrameObserverBase].
  const AudioFrameObserverBase({
    this.onRecordAudioFrame,
    this.onPlaybackAudioFrame,
    this.onMixedAudioFrame,
  });

  final void Function(String channelId, AudioFrame audioFrame)?
      onRecordAudioFrame;

  final void Function(String channelId, AudioFrame audioFrame)?
      onPlaybackAudioFrame;

  final void Function(String channelId, AudioFrame audioFrame)?
      onMixedAudioFrame;
}

@JsonEnum(alwaysCreate: true)
enum AudioFrameType {
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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioFrame {
  const AudioFrame(
      {this.type,
      this.samplesPerChannel,
      this.bytesPerSample,
      this.channels,
      this.samplesPerSec,
      this.buffer,
      this.renderTimeMs,
      this.avsyncType});

  @JsonKey(name: 'type')
  final AudioFrameType? type;

  @JsonKey(name: 'samplesPerChannel')
  final int? samplesPerChannel;

  @JsonKey(name: 'bytesPerSample')
  final BytesPerSample? bytesPerSample;

  @JsonKey(name: 'channels')
  final int? channels;

  @JsonKey(name: 'samplesPerSec')
  final int? samplesPerSec;

  @JsonKey(name: 'buffer', ignore: true)
  final Uint8List? buffer;

  @JsonKey(name: 'renderTimeMs')
  final int? renderTimeMs;

  @JsonKey(name: 'avsync_type')
  final int? avsyncType;
  factory AudioFrame.fromJson(Map<String, dynamic> json) =>
      _$AudioFrameFromJson(json);
  Map<String, dynamic> toJson() => _$AudioFrameToJson(this);
}

@JsonEnum(alwaysCreate: true)
enum AudioFramePosition {
  @JsonValue(0x0000)
  audioFramePositionNone,

  @JsonValue(0x0001)
  audioFramePositionPlayback,

  @JsonValue(0x0002)
  audioFramePositionRecord,

  @JsonValue(0x0004)
  audioFramePositionMixed,

  @JsonValue(0x0008)
  audioFramePositionBeforeMixing,
}

/// Extensions functions of [AudioFramePosition].
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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioParams {
  const AudioParams(
      {this.sampleRate, this.channels, this.mode, this.samplesPerCall});

  @JsonKey(name: 'sample_rate')
  final int? sampleRate;

  @JsonKey(name: 'channels')
  final int? channels;

  @JsonKey(name: 'mode')
  final RawAudioFrameOpModeType? mode;

  @JsonKey(name: 'samples_per_call')
  final int? samplesPerCall;
  factory AudioParams.fromJson(Map<String, dynamic> json) =>
      _$AudioParamsFromJson(json);
  Map<String, dynamic> toJson() => _$AudioParamsToJson(this);
}

class AudioFrameObserver extends AudioFrameObserverBase {
  /// Construct the [AudioFrameObserver].
  const AudioFrameObserver({
    void Function(String channelId, AudioFrame audioFrame)? onRecordAudioFrame,
    void Function(String channelId, AudioFrame audioFrame)?
        onPlaybackAudioFrame,
    void Function(String channelId, AudioFrame audioFrame)? onMixedAudioFrame,
    this.onPlaybackAudioFrameBeforeMixing,
  }) : super(
          onRecordAudioFrame: onRecordAudioFrame,
          onPlaybackAudioFrame: onPlaybackAudioFrame,
          onMixedAudioFrame: onMixedAudioFrame,
        );

  final void Function(String channelId, int uid, AudioFrame audioFrame)?
      onPlaybackAudioFrameBeforeMixing;
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioSpectrumData {
  const AudioSpectrumData({this.audioSpectrumData, this.dataLength});

  @JsonKey(name: 'audioSpectrumData')
  final List<double>? audioSpectrumData;

  @JsonKey(name: 'dataLength')
  final int? dataLength;
  factory AudioSpectrumData.fromJson(Map<String, dynamic> json) =>
      _$AudioSpectrumDataFromJson(json);
  Map<String, dynamic> toJson() => _$AudioSpectrumDataToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class UserAudioSpectrumInfo {
  const UserAudioSpectrumInfo({this.uid, this.spectrumData});

  @JsonKey(name: 'uid')
  final int? uid;

  @JsonKey(name: 'spectrumData')
  final AudioSpectrumData? spectrumData;
  factory UserAudioSpectrumInfo.fromJson(Map<String, dynamic> json) =>
      _$UserAudioSpectrumInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserAudioSpectrumInfoToJson(this);
}

class AudioSpectrumObserver {
  /// Construct the [AudioSpectrumObserver].
  const AudioSpectrumObserver({
    this.onLocalAudioSpectrum,
    this.onRemoteAudioSpectrum,
  });

  final void Function(AudioSpectrumData data)? onLocalAudioSpectrum;

  final void Function(
          List<UserAudioSpectrumInfo> spectrums, int spectrumNumber)?
      onRemoteAudioSpectrum;
}

class VideoEncodedFrameObserver {
  /// Construct the [VideoEncodedFrameObserver].
  const VideoEncodedFrameObserver({
    this.onEncodedVideoFrameReceived,
  });

  final void Function(int uid, Uint8List imageBuffer, int length,
      EncodedVideoFrameInfo videoEncodedFrameInfo)? onEncodedVideoFrameReceived;
}

class VideoFrameObserver {
  /// Construct the [VideoFrameObserver].
  const VideoFrameObserver({
    this.onCaptureVideoFrame,
    this.onPreEncodeVideoFrame,
    this.onSecondaryCameraCaptureVideoFrame,
    this.onSecondaryPreEncodeCameraVideoFrame,
    this.onScreenCaptureVideoFrame,
    this.onPreEncodeScreenVideoFrame,
    this.onMediaPlayerVideoFrame,
    this.onSecondaryScreenCaptureVideoFrame,
    this.onSecondaryPreEncodeScreenVideoFrame,
    this.onRenderVideoFrame,
    this.onTranscodedVideoFrame,
  });

  final void Function(VideoFrame videoFrame)? onCaptureVideoFrame;

  final void Function(VideoFrame videoFrame)? onPreEncodeVideoFrame;

  final void Function(VideoFrame videoFrame)?
      onSecondaryCameraCaptureVideoFrame;

  final void Function(VideoFrame videoFrame)?
      onSecondaryPreEncodeCameraVideoFrame;

  final void Function(VideoFrame videoFrame)? onScreenCaptureVideoFrame;

  final void Function(VideoFrame videoFrame)? onPreEncodeScreenVideoFrame;

  final void Function(VideoFrame videoFrame, int mediaPlayerId)?
      onMediaPlayerVideoFrame;

  final void Function(VideoFrame videoFrame)?
      onSecondaryScreenCaptureVideoFrame;

  final void Function(VideoFrame videoFrame)?
      onSecondaryPreEncodeScreenVideoFrame;

  final void Function(String channelId, int remoteUid, VideoFrame videoFrame)?
      onRenderVideoFrame;

  final void Function(VideoFrame videoFrame)? onTranscodedVideoFrame;
}

@JsonEnum(alwaysCreate: true)
enum VideoFrameProcessMode {
  @JsonValue(0)
  processModeReadOnly,

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

@JsonEnum(alwaysCreate: true)
enum ExternalVideoSourceType {
  @JsonValue(0)
  videoFrame,

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

@JsonEnum(alwaysCreate: true)
enum MediaRecorderContainerFormat {
  @JsonValue(1)
  formatMp4,
}

/// Extensions functions of [MediaRecorderContainerFormat].
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

@JsonEnum(alwaysCreate: true)
enum MediaRecorderStreamType {
  @JsonValue(0x01)
  streamTypeAudio,

  @JsonValue(0x02)
  streamTypeVideo,

  @JsonValue(0x01 | 0x02)
  streamTypeBoth,
}

/// Extensions functions of [MediaRecorderStreamType].
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

@JsonEnum(alwaysCreate: true)
enum RecorderState {
  @JsonValue(-1)
  recorderStateError,

  @JsonValue(2)
  recorderStateStart,

  @JsonValue(3)
  recorderStateStop,
}

/// Extensions functions of [RecorderState].
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

@JsonEnum(alwaysCreate: true)
enum RecorderErrorCode {
  @JsonValue(0)
  recorderErrorNone,

  @JsonValue(1)
  recorderErrorWriteFailed,

  @JsonValue(2)
  recorderErrorNoStream,

  @JsonValue(3)
  recorderErrorOverMaxDuration,

  @JsonValue(4)
  recorderErrorConfigChanged,
}

/// Extensions functions of [RecorderErrorCode].
extension RecorderErrorCodeExt on RecorderErrorCode {
  /// @nodoc
  static RecorderErrorCode fromValue(int value) {
    return $enumDecode(_$RecorderErrorCodeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$RecorderErrorCodeEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MediaRecorderConfiguration {
  const MediaRecorderConfiguration(
      {this.storagePath,
      this.containerFormat,
      this.streamType,
      this.maxDurationMs,
      this.recorderInfoUpdateInterval});

  @JsonKey(name: 'storagePath')
  final String? storagePath;

  @JsonKey(name: 'containerFormat')
  final MediaRecorderContainerFormat? containerFormat;

  @JsonKey(name: 'streamType')
  final MediaRecorderStreamType? streamType;

  @JsonKey(name: 'maxDurationMs')
  final int? maxDurationMs;

  @JsonKey(name: 'recorderInfoUpdateInterval')
  final int? recorderInfoUpdateInterval;
  factory MediaRecorderConfiguration.fromJson(Map<String, dynamic> json) =>
      _$MediaRecorderConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$MediaRecorderConfigurationToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RecorderInfo {
  const RecorderInfo({this.fileName, this.durationMs, this.fileSize});

  @JsonKey(name: 'fileName')
  final String? fileName;

  @JsonKey(name: 'durationMs')
  final int? durationMs;

  @JsonKey(name: 'fileSize')
  final int? fileSize;
  factory RecorderInfo.fromJson(Map<String, dynamic> json) =>
      _$RecorderInfoFromJson(json);
  Map<String, dynamic> toJson() => _$RecorderInfoToJson(this);
}

class MediaRecorderObserver {
  /// Construct the [MediaRecorderObserver].
  const MediaRecorderObserver({
    this.onRecorderStateChanged,
    this.onRecorderInfoUpdated,
  });

  final void Function(RecorderState state, RecorderErrorCode error)?
      onRecorderStateChanged;

  final void Function(RecorderInfo info)? onRecorderInfoUpdated;
}
