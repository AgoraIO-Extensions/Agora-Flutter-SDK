import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_media_base.g.dart';

/// @nodoc
const defaultConnectionId = 0;

/// @nodoc
const dummyConnectionId = 4294967295;

/// The type of the audio route.
@JsonEnum(alwaysCreate: true)
enum AudioRoute {
  /// -1: The default audio route.
  @JsonValue(-1)
  routeDefault,

  /// 0: Audio output routing is a headset with microphone.
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

  /// 4: The audio route is an external speaker. (iOS and macOS only)
  @JsonValue(4)
  routeLoudspeaker,

  /// 5: The audio route is a bluetooth headset.
  @JsonValue(5)
  routeHeadsetbluetooth,

  /// 7: The audio route is a USB peripheral device. (For macOS only)
  @JsonValue(6)
  routeUsb,

  /// 6: The audio route is an HDMI peripheral device. (For macOS only)
  @JsonValue(7)
  routeHdmi,

  /// 8: The audio route is a DisplayPort peripheral device. (For macOS only)
  @JsonValue(8)
  routeDisplayport,

  /// 9: The audio route is Apple AirPlay. (For macOS only)
  @JsonValue(9)
  routeAirplay,
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
class AudioParameters {
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

  /// @nodoc
  Map<String, dynamic> toJson() => _$AudioParametersToJson(this);
}

/// The use mode of the audio data.
@JsonEnum(alwaysCreate: true)
enum RawAudioFrameOpModeType {
  /// 0: Read-only mode,
  @JsonValue(0)
  rawAudioFrameOpModeReadOnly,

  /// 2: Read and write mode,
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

/// Media source type.
@JsonEnum(alwaysCreate: true)
enum MediaSourceType {
  /// 0: Audio playback device.
  @JsonValue(0)
  audioPlayoutSource,

  /// 1: Audio capturing device.
  @JsonValue(1)
  audioRecordingSource,

  /// 2: The primary camera.
  @JsonValue(2)
  primaryCameraSource,

  /// 3: The secondary camera.
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

/// The type of video content moderation module.
@JsonEnum(alwaysCreate: true)
enum ContentInspectType {
  /// 0: (Default) This module has no actual function. Do not set type to this value.
  @JsonValue(0)
  contentInspectInvalid,

  /// 1: Video content moderation. SDK takes screenshots, inspects video content of the video stream in the channel, and uploads the screenshots and moderation results.
  @JsonValue(1)
  contentInspectModeration,

  /// 2: Screenshot capture. SDK takes screenshots of the video stream in the channel and uploads them.
  @JsonValue(2)
  contentInspectSupervision,
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

/// A structure used to configure the frequency of video screenshot and upload.ContentInspectModule
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ContentInspectModule {
  /// @nodoc
  const ContentInspectModule({this.type, this.interval});

  /// Types of functional module. See ContentInspectType .
  @JsonKey(name: 'type')
  final ContentInspectType? type;

  /// The frequency (s) of video screenshot and upload. The value should be set as larger than 0. The default value is 0, the SDK does not take screenshots. Agora recommends that you set the value as 10; you can also adjust it according to your business needs.
  @JsonKey(name: 'interval')
  final int? interval;

  /// @nodoc
  factory ContentInspectModule.fromJson(Map<String, dynamic> json) =>
      _$ContentInspectModuleFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ContentInspectModuleToJson(this);
}

/// Configuration of video screenshot and upload.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ContentInspectConfig {
  /// @nodoc
  const ContentInspectConfig({this.extraInfo, this.modules, this.moduleCount});

  /// Additional information on the video content (maximum length: 1024 Bytes).The SDK sends the screenshots and additional information on the video content to the Agora server. Once the video screenshot and upload process is completed, the Agora server sends the additional information and the callback notification to your server.
  @JsonKey(name: 'extraInfo')
  final String? extraInfo;

  /// Functional module. See ContentInspectModule .A maximum of 32 ContentInspectModule instances can be configured, and the value range of MAX_CONTENT_INSPECT_MODULE_COUNT is an integer in [1,32].A function module can only be configured with one instance at most. Currently only the video screenshot and upload function is supported.
  @JsonKey(name: 'modules')
  final List<ContentInspectModule>? modules;

  /// The number of functional modules, that is,the number of configured ContentInspectModule instances, must be the same as the number of instances configured in modules. The maximum number is 32.
  @JsonKey(name: 'moduleCount')
  final int? moduleCount;

  /// @nodoc
  factory ContentInspectConfig.fromJson(Map<String, dynamic> json) =>
      _$ContentInspectConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ContentInspectConfigToJson(this);
}

/// @nodoc
const kMaxCodecNameLength = 50;

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class PacketOptions {
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

  /// @nodoc
  Map<String, dynamic> toJson() => _$PacketOptionsToJson(this);
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioEncodedFrameInfo {
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

  /// @nodoc
  Map<String, dynamic> toJson() => _$AudioEncodedFrameInfoToJson(this);
}

/// The parameters of the audio frame in PCM format.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioPcmFrame {
  /// @nodoc
  const AudioPcmFrame(
      {this.captureTimestamp,
      this.samplesPerChannel,
      this.sampleRateHz,
      this.numChannels,
      this.bytesPerSample,
      this.data});

  /// The timestamp (ms) of the audio frame.
  @JsonKey(name: 'capture_timestamp')
  final int? captureTimestamp;

  /// The number of samples per channel in the audio frame.
  @JsonKey(name: 'samples_per_channel_')
  final int? samplesPerChannel;

  /// Audio sample rate (Hz).
  @JsonKey(name: 'sample_rate_hz_')
  final int? sampleRateHz;

  /// The number of audio channels.
  @JsonKey(name: 'num_channels_')
  final int? numChannels;

  /// The number of bytes per sample.
  @JsonKey(name: 'bytes_per_sample')
  final BytesPerSample? bytesPerSample;

  /// The video frame.
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

/// The video pixel format.
@JsonEnum(alwaysCreate: true)
enum VideoPixelFormat {
  /// 0: Raw video pixel format.
  @JsonValue(0)
  videoPixelDefault,

  /// 1: The format is I420.
  @JsonValue(1)
  videoPixelI420,

  /// @nodoc
  @JsonValue(2)
  videoPixelBgra,

  /// @nodoc
  @JsonValue(3)
  videoPixelNv21,

  /// 4: The format is RGBA.
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
  @JsonValue(12)
  videoCvpixelNv12,

  /// @nodoc
  @JsonValue(13)
  videoCvpixelI420,

  /// @nodoc
  @JsonValue(14)
  videoCvpixelBgra,

  /// 16: The format is I422.
  @JsonValue(16)
  videoPixelI422,
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

/// Video display modes.
@JsonEnum(alwaysCreate: true)
enum RenderModeType {
  /// 1: Hidden mode. Uniformly scale the video until one of its dimension fits the boundary (zoomed to fit). One dimension of the video may have clipped contents.
  @JsonValue(1)
  renderModeHidden,

  /// 2: Fit mode. Uniformly scale the video until one of its dimension fits the boundary (zoomed to fit). Areas that are not filled due to disparity in the aspect ratio are filled with black.
  @JsonValue(2)
  renderModeFit,

  /// Deprecated:3: This mode is deprecated.
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

/// The external video frame.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ExternalVideoFrame {
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
      this.matrix,
      this.metadataBuffer,
      this.metadataSize});

  /// The video type. See VideoBufferType .
  @JsonKey(name: 'type')
  final VideoBufferType? type;

  /// The pixel format. See VideoPixelFormat .
  @JsonKey(name: 'format')
  final VideoPixelFormat? format;

  /// Video frame buffer.
  @JsonKey(name: 'buffer', ignore: true)
  final Uint8List? buffer;

  /// Line spacing of the incoming video frame, which must be in pixels instead of bytes. For textures, it is the width of the texture.
  @JsonKey(name: 'stride')
  final int? stride;

  /// Height of the incoming video frame.
  @JsonKey(name: 'height')
  final int? height;

  /// Raw data related parameter. The number of pixels trimmed from the left. The default value is 0.
  @JsonKey(name: 'cropLeft')
  final int? cropLeft;

  /// Raw data related parameter. The number of pixels trimmed from the top. The default value is 0.
  @JsonKey(name: 'cropTop')
  final int? cropTop;

  /// Raw data related parameter. The number of pixels trimmed from the right. The default value is 0.
  @JsonKey(name: 'cropRight')
  final int? cropRight;

  /// Raw data related parameter. The number of pixels trimmed from the bottom. The default value is 0.
  @JsonKey(name: 'cropBottom')
  final int? cropBottom;

  /// Raw data related parameter. The clockwise rotation of the video frame. You can set the rotation angle as 0, 90, 180, or 270. The default value is 0.
  @JsonKey(name: 'rotation')
  final int? rotation;

  /// Timestamp (ms) of the incoming video frame. An incorrect timestamp results in frame loss or unsynchronized audio and video.
  @JsonKey(name: 'timestamp')
  final int? timestamp;

  /// This parameter only applies to video data in Texture format. Texture ID of the frame.
  @JsonKey(name: 'eglType')
  final EglContextType? eglType;

  /// This parameter only applies to video data in Texture format. Incoming 4 x 4 transformational matrix. The typical value is a unit matrix.
  @JsonKey(name: 'textureId')
  final int? textureId;

  /// This parameter only applies to video data in Texture format. Incoming 4 x 4 transformational matrix. The typical value is a unit matrix.
  @JsonKey(name: 'matrix')
  final List<double>? matrix;

  /// This parameter only applies to video data in Texture format. The MetaData buffer. The default value is NULL.
  @JsonKey(name: 'metadata_buffer', ignore: true)
  final Uint8List? metadataBuffer;

  /// This parameter only applies to video data in Texture format. The MetaData size. The default value is 0.
  @JsonKey(name: 'metadata_size')
  final int? metadataSize;

  /// @nodoc
  factory ExternalVideoFrame.fromJson(Map<String, dynamic> json) =>
      _$ExternalVideoFrameFromJson(json);

  /// @nodoc
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

/// The video buffer type.
@JsonEnum(alwaysCreate: true)
enum VideoBufferType {
  /// 1: The video buffer in the format of raw data.
  @JsonValue(1)
  videoBufferRawData,

  /// 2: The video buffer in the format of raw data.
  @JsonValue(2)
  videoBufferArray,

  /// 3: The video buffer in the format of Texture.
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

/// Configurations of the video frame.
/// The video data format is YUV420. Note that the buffer provides a pointer to a pointer. This interface cannot modify the pointer of the buffer, but it can modify the content of the buffer.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VideoFrame {
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
      this.alphaBuffer});

  /// The pixel format. See VideoPixelFormat .
  @JsonKey(name: 'type')
  final VideoPixelFormat? type;

  /// The width of the video, in pixels.
  @JsonKey(name: 'width')
  final int? width;

  /// The height of the video, in pixels.
  @JsonKey(name: 'height')
  final int? height;

  /// For YUV data, the line span of the Y buffer; for RGBA data, the total data length.
  @JsonKey(name: 'yStride')
  final int? yStride;

  /// For YUV data, the line span of the U buffer; for RGBA data, the value is 0.
  @JsonKey(name: 'uStride')
  final int? uStride;

  /// For YUV data, the line span of the V buffer; for RGBA data, the value is 0.
  @JsonKey(name: 'vStride')
  final int? vStride;

  /// For YUV data, the pointer to the Y buffer; for RGBA data, the data buffer.
  @JsonKey(name: 'yBuffer', ignore: true)
  final Uint8List? yBuffer;

  /// For YUV data, the pointer to the U buffer; for RGBA data, the value is 0.
  @JsonKey(name: 'uBuffer', ignore: true)
  final Uint8List? uBuffer;

  /// For YUV data, the pointer to the V buffer; for RGBA data, the value is 0.
  @JsonKey(name: 'vBuffer', ignore: true)
  final Uint8List? vBuffer;

  /// The clockwise rotation of the video frame before rendering. Supported values include 0, 90, 180, and 270 degrees.
  @JsonKey(name: 'rotation')
  final int? rotation;

  /// The Unix timestamp (ms) when the video frame is rendered. This timestamp can be used to guide the rendering of the video frame. It is required.
  @JsonKey(name: 'renderTimeMs')
  final int? renderTimeMs;

  /// Reserved for future use.
  @JsonKey(name: 'avsync_type')
  final int? avsyncType;

  /// This parameter only applies to video data in Texture format. The MetaData buffer. The default value is NULL.
  @JsonKey(name: 'metadata_buffer', ignore: true)
  final Uint8List? metadataBuffer;

  /// This parameter only applies to video data in Texture format. The MetaData size. The default value is 0.
  @JsonKey(name: 'metadata_size')
  final int? metadataSize;

  /// This parameter only applies to video data in Texture format. Texture ID.
  @JsonKey(name: 'textureId')
  final int? textureId;

  /// This parameter only applies to video data in Texture format. Incoming 4 × 4 transformational matrix. The typical value is a unit matrix.
  @JsonKey(name: 'matrix')
  final List<double>? matrix;

  /// @nodoc
  @JsonKey(name: 'alphaBuffer', ignore: true)
  final Uint8List? alphaBuffer;

  /// @nodoc
  factory VideoFrame.fromJson(Map<String, dynamic> json) =>
      _$VideoFrameFromJson(json);

  /// @nodoc
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

/// The frame position of the video observer.
@JsonEnum(alwaysCreate: true)
enum VideoModulePosition {
  /// 1: The post-capturer position, which corresponds to the video data in the onCaptureVideoFrame callback.
  @JsonValue(1 << 0)
  positionPostCapturer,

  /// 2: The pre-renderer position, which corresponds to the video data in the onRenderVideoFrame callback.
  @JsonValue(1 << 1)
  positionPreRenderer,

  /// 4: The pre-encoder position, which corresponds to the video data in the onPreEncodeVideoFrame callback.
  @JsonValue(1 << 2)
  positionPreEncoder,
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

/// The audio frame observer.
class AudioFrameObserverBase {
  /// @nodoc
  const AudioFrameObserverBase({
    this.onRecordAudioFrame,
    this.onPlaybackAudioFrame,
    this.onMixedAudioFrame,
    this.onEarMonitoringAudioFrame,
  });

  /// Gets the captured audio frame.
  /// To ensure that the data format of captured audio frame is as expected, Agora recommends that you set the audio data format as follows: After calling setRecordingAudioFrameParameters to set the audio data format, call registerAudioFrameObserver to register the audio observer object, the SDK will calculate the sampling interval according to the parameters set in this method, and triggers the onRecordAudioFrame callback according to the sampling interval.Due to the limitations of Flutter, this callback does not support sending processed audio data back to the SDK.
  ///
  /// * [audioFrame] The raw audio data. See AudioFrame .
  /// * [channelId] The channel ID.
  ///
  /// Returns
  /// Reserved for future use.
  final void Function(String channelId, AudioFrame audioFrame)?
      onRecordAudioFrame;

  /// Gets the raw audio frame for playback.
  /// To ensure that the data format of audio frame for playback is as expected, Agora recommends that you set the audio data format as follows: After calling setPlaybackAudioFrameParameters to set the audio data format and registerAudioFrameObserver to register the audio frame observer object, the SDK calculates the sampling interval according to the parameters set in the methods, and triggers the onPlaybackAudioFrame callback according to the sampling interval.Due to the limitations of Flutter, this callback does not support sending processed audio data back to the SDK.
  ///
  /// * [audioFrame] The raw audio data. See AudioFrame .
  /// * [channelId] The channel ID.
  ///
  /// Returns
  /// Reserved for future use.
  final void Function(String channelId, AudioFrame audioFrame)?
      onPlaybackAudioFrame;

  /// Retrieves the mixed captured and playback audio frame.
  /// To ensure that the data format of mixed captured and playback audio frame meets the expectations, Agora recommends that you set the data format as follows: After calling setMixedAudioFrameParameters to set the audio data format and registerAudioFrameObserver to register the audio frame observer object, the SDK calculates the sampling interval according to the parameters set in the methods, and triggers the onMixedAudioFrame callback according to the sampling interval.Due to the limitations of Flutter, this callback does not support sending processed audio data back to the SDK.
  ///
  /// * [audioFrame] The raw audio data. See AudioFrame .
  /// * [channelId] The channel ID.
  ///
  /// Returns
  /// Reserved for future use.
  final void Function(String channelId, AudioFrame audioFrame)?
      onMixedAudioFrame;

  /// Gets the in-ear monitoring audio frame.
  /// In order to ensure that the obtained in-ear audio data meets the expectations, Agora recommends that you set the in-ear monitoring-ear audio data format as follows: After calling setEarMonitoringAudioFrameParameters to set the audio data format and registerAudioFrameObserver to register the audio frame observer object, the SDK calculates the sampling interval according to the parameters set in the methods, and triggers the onEarMonitoringAudioFrame callback according to the sampling interval.Due to the limitations of Flutter, this callback does not support sending processed audio data back to the SDK.
  /// * [audioFrame] The raw audio data. See AudioFrame .
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
class AudioFrame {
  /// @nodoc
  const AudioFrame(
      {this.type,
      this.samplesPerChannel,
      this.bytesPerSample,
      this.channels,
      this.samplesPerSec,
      this.buffer,
      this.renderTimeMs,
      this.avsyncType});

  /// The type of the audio frame. See AudioFrameType .
  @JsonKey(name: 'type')
  final AudioFrameType? type;

  /// The number of samples per channel in the audio frame.
  @JsonKey(name: 'samplesPerChannel')
  final int? samplesPerChannel;

  /// The number of bytes per audio sample, which is usually 16-bit (2 bytes).
  @JsonKey(name: 'bytesPerSample')
  final BytesPerSample? bytesPerSample;

  /// The number of audio channels (the data are interleaved if it is stereo).1: Mono.2: Stereo.
  @JsonKey(name: 'channels')
  final int? channels;

  /// The number of samples per channel in the audio frame.
  @JsonKey(name: 'samplesPerSec')
  final int? samplesPerSec;

  /// The data buffer of the audio frame. When the audio frame uses a stereo channel, the data buffer is interleaved.The size of the data buffer is as follows: buffer = samples ×channels × bytesPerSample.
  @JsonKey(name: 'buffer', ignore: true)
  final Uint8List? buffer;

  /// The timestamp (ms) of the external audio frame.You can use this timestamp to restore the order of the captured audio frame, and synchronize audio and video frames in video scenarios, including scenarios where external video sources are used.
  @JsonKey(name: 'renderTimeMs')
  final int? renderTimeMs;

  /// Reserved for future use.
  @JsonKey(name: 'avsync_type')
  final int? avsyncType;

  /// @nodoc
  factory AudioFrame.fromJson(Map<String, dynamic> json) =>
      _$AudioFrameFromJson(json);

  /// @nodoc
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
/// The SDK calculates the sampling interval through the samplesPerCall, sampleRate, and channel parameters in AudioParams, and triggers the onRecordAudioFrame, onPlaybackAudioFrame, onMixedAudioFrame, and onEarMonitoringAudioFrame callbacks according to the sampling interval.Sample interval (sec) = samplePerCall/(sampleRate × channel).Ensure that the sample interval ≥ 0.01 (s).
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioParams {
  /// @nodoc
  const AudioParams(
      {this.sampleRate, this.channels, this.mode, this.samplesPerCall});

  /// The audio sample rate (Hz), which can be set as one of the following values:8000.(Default) 16000.32000.4410048000
  @JsonKey(name: 'sample_rate')
  final int? sampleRate;

  /// The number of audio channels, which can be set as either of the following values:1: (Default) Mono.2: Stereo.
  @JsonKey(name: 'channels')
  final int? channels;

  /// The use mode of the audio data. See RawAudioFrameOpModeType .
  @JsonKey(name: 'mode')
  final RawAudioFrameOpModeType? mode;

  /// The number of samples, such as 1024 for the media push.
  @JsonKey(name: 'samples_per_call')
  final int? samplesPerCall;

  /// @nodoc
  factory AudioParams.fromJson(Map<String, dynamic> json) =>
      _$AudioParamsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AudioParamsToJson(this);
}

/// The audio frame observer.
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

  /// Retrieves the audio frame of a specified user before mixing.
  /// Due to the limitations of Flutter, this callback does not support sending processed audio data back to the SDK.
  ///
  /// * [channelId] The channel ID.
  /// * [uid] The user ID of the specified user.
  /// * [audioFrame] The raw audio data. See AudioFrame .
  ///
  /// Returns
  /// Reserved for future use.
  final void Function(String channelId, int uid, AudioFrame audioFrame)?
      onPlaybackAudioFrameBeforeMixing;
}

/// The audio spectrum data.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioSpectrumData {
  /// @nodoc
  const AudioSpectrumData({this.audioSpectrumData, this.dataLength});

  /// The audio spectrum data. Agora divides the audio frequency into 256 frequency domains, and reports the energy value of each frequency domain through this parameter. The value range of each energy type is [-300, 1] and the unit is dBFS.
  @JsonKey(name: 'audioSpectrumData')
  final List<double>? audioSpectrumData;

  /// The audio spectrum data length is 256.
  @JsonKey(name: 'dataLength')
  final int? dataLength;

  /// @nodoc
  factory AudioSpectrumData.fromJson(Map<String, dynamic> json) =>
      _$AudioSpectrumDataFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AudioSpectrumDataToJson(this);
}

/// Audio spectrum information of the remote user.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class UserAudioSpectrumInfo {
  /// @nodoc
  const UserAudioSpectrumInfo({this.uid, this.spectrumData});

  /// The user ID of the remote user.
  @JsonKey(name: 'uid')
  final int? uid;

  /// Audio spectrum information of the remote user.See AudioSpectrumData .
  @JsonKey(name: 'spectrumData')
  final AudioSpectrumData? spectrumData;

  /// @nodoc
  factory UserAudioSpectrumInfo.fromJson(Map<String, dynamic> json) =>
      _$UserAudioSpectrumInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$UserAudioSpectrumInfoToJson(this);
}

/// The audio spectrum observer.
class AudioSpectrumObserver {
  /// @nodoc
  const AudioSpectrumObserver({
    this.onLocalAudioSpectrum,
    this.onRemoteAudioSpectrum,
  });

  /// Gets the statistics of a local audio spectrum.
  /// After successfully calling registerAudioSpectrumObserver to implement the onLocalAudioSpectrum callback in AudioSpectrumObserver and calling enableAudioSpectrumMonitor to enable audio spectrum monitoring, the SDK will trigger the callback as the time interval you set to report the received remote audio data spectrum.
  ///
  /// * [data] The audio spectrum data of the local user. See AudioSpectrumData .
  final void Function(AudioSpectrumData data)? onLocalAudioSpectrum;

  /// Gets the remote audio spectrum.
  /// After successfully calling registerAudioSpectrumObserver to implement the onRemoteAudioSpectrum callback in the AudioSpectrumObserver and calling enableAudioSpectrumMonitor to enable audio spectrum monitoring, the SDK will trigger the callback as the time interval you set to report the received remote audio data spectrum.
  ///
  /// * [spectrums] The audio spectrum information of the remote user, see UserAudioSpectrumInfo . The number of arrays is the number of remote users monitored by the SDK. If the array is null, it means that no audio spectrum of remote users is detected.
  /// * [spectrumNumber] The number of remote users.
  final void Function(
          List<UserAudioSpectrumInfo> spectrums, int spectrumNumber)?
      onRemoteAudioSpectrum;
}

/// Receives encoded video images.
class VideoEncodedFrameObserver {
  /// @nodoc
  const VideoEncodedFrameObserver({
    this.onEncodedVideoFrameReceived,
  });

  /// Reports that the receiver has received the to-be-decoded video frame sent by the remote end.
  /// If you call the setRemoteVideoSubscriptionOptions method and set encodedFrameOnly to true, the SDK triggers this callback locally to report the received encoded video frame information.
  ///
  /// * [uid] The user ID of the remote user.
  /// * [imageBuffer] The encoded video image buffer.
  /// * [length] The data length of the video image.
  /// * [videoEncodedFrameInfo] For the information of the encoded video frame, see EncodedVideoFrameInfo .
  ///
  /// Returns
  /// Reserved for future use.
  final void Function(int uid, Uint8List imageBuffer, int length,
      EncodedVideoFrameInfo videoEncodedFrameInfo)? onEncodedVideoFrameReceived;
}

/// The IVideoFrameObserver class.
class VideoFrameObserver {
  /// @nodoc
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

  /// Occurs each time the SDK receives a video frame captured by the local camera.
  /// After you successfully register the video frame observer, the SDK triggers this callback each time it receives a video frame. In this callback, you can get the video data captured by the local camera. You can then pre-process the data according to your scenarios.The video data that this callback gets has not been pre-processed, and is not watermarked, cropped, rotated or beautified.If the video data type you get is RGBA, Agora does not support processing the data of the alpha channel.Due to the limitations of Flutter, this callback does not support sending processed video data back to the SDK.
  ///
  /// * [videoFrame] The video frame. See VideoFrame .
  final void Function(VideoFrame videoFrame)? onCaptureVideoFrame;

  /// Occurs each time the SDK receives a video frame before encoding.
  /// After you successfully register the video frame observer, the SDK triggers this callback each time it receives a video frame. In this callback, you can get the video data before encoding and then process the data according to your particular scenarios.Due to the limitations of Flutter, this callback does not support sending processed video data back to the SDK.The video data that this callback gets has been preprocessed, with its content cropped and rotated, and the image enhanced.
  ///
  /// * [videoFrame] The video frame. See VideoFrame .
  final void Function(VideoFrame videoFrame)? onPreEncodeVideoFrame;

  /// @nodoc
  final void Function(VideoFrame videoFrame)?
      onSecondaryCameraCaptureVideoFrame;

  /// Gets the video data captured from the second camera before encoding.
  /// After you successfully register the video frame observer, the SDK triggers this callback each time it receives a video frame. In this callback, you can get the video data captured from the second camera before encoding and then process the data according to your particular scenarios.Due to the limitations of Flutter, this callback does not support sending processed video data back to the SDK.
  ///
  /// * [videoFrame] The video frame. See VideoFrame .
  final void Function(VideoFrame videoFrame)?
      onSecondaryPreEncodeCameraVideoFrame;

  /// Occurs each time the SDK receives a video frame captured by the screen.
  /// After you successfully register the video frame observer, the SDK triggers this callback each time it receives a video frame. In this callback, you can get the video data for screen sharing. You can then pre-process the data according to your scenarios.Due to the limitations of Flutter, this callback does not support sending processed video data back to the SDK.
  ///
  /// * [videoFrame] The video frame. See VideoFrame .
  final void Function(VideoFrame videoFrame)? onScreenCaptureVideoFrame;

  /// Gets the video data captured from the screen before encoding.
  /// After you successfully register the video frame observer, the SDK triggers this callback each time it receives a video frame. In this callback, you can get the video data captured from the screen before encoding and then process the data according to your particular scenarios.Due to the limitations of Flutter, this callback does not support sending processed video data back to the SDK.
  ///
  /// * [videoFrame] The video frame. See VideoFrame .
  final void Function(VideoFrame videoFrame)? onPreEncodeScreenVideoFrame;

  /// Gets the video data of the media player.
  /// After you successfully register the video frame observer and calling the createMediaPlayer method, the SDK triggers this callback each time when it receives a video frame. In this callback, you can get the video data of the media player. You can then process the data according to your particular scenarios.Due to the limitations of Flutter, this callback does not support sending processed video data back to the SDK.
  ///
  /// * [videoFrame] The video frame. See VideoFrame .
  /// * [mediaPlayerId] The ID of the media player.
  final void Function(VideoFrame videoFrame, int mediaPlayerId)?
      onMediaPlayerVideoFrame;

  /// @nodoc
  final void Function(VideoFrame videoFrame)?
      onSecondaryScreenCaptureVideoFrame;

  /// Gets the video data captured from the second screen before encoding.
  /// After you successfully register the video frame observer, the SDK triggers this callback each time it receives a video frame. In this callback, you can get the video data captured from the second screen before encoding and then process the data according to your particular scenarios.Due to the limitations of Flutter, this callback does not support sending processed video data back to the SDK.
  ///
  /// * [videoFrame] The video frame. See VideoFrame .
  final void Function(VideoFrame videoFrame)?
      onSecondaryPreEncodeScreenVideoFrame;

  /// Occurs each time the SDK receives a video frame sent by the remote user.
  /// After you successfully register the video frame observer, the SDK triggers this callback each time it receives a video frame. In this callback, you can get the video data before encoding. You can then process the data according to your particular scenarios.If the video data type you get is RGBA, Agora does not support processing the data of the alpha channel.Due to the limitations of Flutter, this callback does not support sending processed video data back to the SDK.
  ///
  /// * [videoFrame] The video frame. See VideoFrame .
  /// * [remoteUid] The user ID of the remote user who sends the current video frame.
  /// * [channelId] The channel ID.
  final void Function(String channelId, int remoteUid, VideoFrame videoFrame)?
      onRenderVideoFrame;

  /// @nodoc
  final void Function(VideoFrame videoFrame)? onTranscodedVideoFrame;
}

/// The process mode of the video frame:
@JsonEnum(alwaysCreate: true)
enum VideoFrameProcessMode {
  /// Read-only mode.In this mode, you do not modify the video frame. The video frame observer is a renderer.
  @JsonValue(0)
  processModeReadOnly,

  /// Read and write mode.In this mode, you modify the video frame. The video frame observer is a video filter.
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

/// The format of the recording file.
@JsonEnum(alwaysCreate: true)
enum MediaRecorderContainerFormat {
  /// 1: (Default) MP4.
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

/// The recording content.
@JsonEnum(alwaysCreate: true)
enum MediaRecorderStreamType {
  /// Only audio.
  @JsonValue(0x01)
  streamTypeAudio,

  /// Only video.
  @JsonValue(0x02)
  streamTypeVideo,

  /// (Default) Audio and video.
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

/// The current recording state.
@JsonEnum(alwaysCreate: true)
enum RecorderState {
  /// -1: An error occurs during the recording. See RecorderErrorCode for the reason.
  @JsonValue(-1)
  recorderStateError,

  /// 2: The audio and video recording starts.
  @JsonValue(2)
  recorderStateStart,

  /// 3: The audio and video recording stops.
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

/// The reason for the state change.
@JsonEnum(alwaysCreate: true)
enum RecorderErrorCode {
  /// 0: No error.
  @JsonValue(0)
  recorderErrorNone,

  /// 1: The SDK fails to write the recorded data to a file.
  @JsonValue(1)
  recorderErrorWriteFailed,

  /// 2: The SDK does not detect any audio and video streams, or audio and video streams are interrupted for more than five seconds during recording.
  @JsonValue(2)
  recorderErrorNoStream,

  /// 3: The recording duration exceeds the upper limit.
  @JsonValue(3)
  recorderErrorOverMaxDuration,

  /// 4: The recording configuration changes.
  @JsonValue(4)
  recorderErrorConfigChanged,
}

/// @nodoc
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

/// Configurations for the local audio and video recording.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MediaRecorderConfiguration {
  /// @nodoc
  const MediaRecorderConfiguration(
      {this.storagePath,
      this.containerFormat,
      this.streamType,
      this.maxDurationMs,
      this.recorderInfoUpdateInterval});

  /// The absolute path (including the filename extensions) of the recording file. For example:Windows: C:\Users\<user_name>\AppData\Local\Agora\<process_name>\example.mp4iOS: /App Sandbox/Library/Caches/example.mp4macOS: /Library/Logs/example.mp4Android: /storage/emulated/0/Android/data/<package name>/files/example.mp4Ensure that the directory for the log files exists and is writable.
  @JsonKey(name: 'storagePath')
  final String? storagePath;

  /// The format of the recording file. See MediaRecorderContainerFormat .
  @JsonKey(name: 'containerFormat')
  final MediaRecorderContainerFormat? containerFormat;

  /// The recording content. See MediaRecorderStreamType .
  @JsonKey(name: 'streamType')
  final MediaRecorderStreamType? streamType;

  /// The maximum recording duration, in milliseconds. The default value is 120000.
  @JsonKey(name: 'maxDurationMs')
  final int? maxDurationMs;

  /// The interval (ms) of updating the recording information. The value range is [1000,10000]. Based on the value you set in this parameter, the SDK triggers the onRecorderInfoUpdated callback to report the updated recording information.
  @JsonKey(name: 'recorderInfoUpdateInterval')
  final int? recorderInfoUpdateInterval;

  /// @nodoc
  factory MediaRecorderConfiguration.fromJson(Map<String, dynamic> json) =>
      _$MediaRecorderConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$MediaRecorderConfigurationToJson(this);
}

/// The information about the file that is recorded.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RecorderInfo {
  /// @nodoc
  const RecorderInfo({this.fileName, this.durationMs, this.fileSize});

  /// The absolute path of the recording file.
  @JsonKey(name: 'fileName')
  final String? fileName;

  /// The recording duration (ms).
  @JsonKey(name: 'durationMs')
  final int? durationMs;

  /// The size (bytes) of the recording file.
  @JsonKey(name: 'fileSize')
  final int? fileSize;

  /// @nodoc
  factory RecorderInfo.fromJson(Map<String, dynamic> json) =>
      _$RecorderInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RecorderInfoToJson(this);
}

/// The MediaRecorderObserver class.
class MediaRecorderObserver {
  /// @nodoc
  const MediaRecorderObserver({
    this.onRecorderStateChanged,
    this.onRecorderInfoUpdated,
  });

  /// Occurs when the recording state changes.
  /// When the local audio or video recording state changes, the SDK triggers this callback to report the current recording state and the reason for the change.
  ///
  /// * [state] The current recording state. See RecorderState .
  /// * [error] The reason for the state change. See RecorderErrorCode .
  final void Function(RecorderState state, RecorderErrorCode error)?
      onRecorderStateChanged;

  /// Occurs when the recording information is updated.
  /// After you successfully enable the local audio and video recording, the SDK periodically triggers this callback based on the value of recorderInfoUpdateInterval set in MediaRecorderConfiguration . This callback reports the file name, duration, and size of the current recording file.
  ///
  /// * [info] The information about the file that is recorded. See RecorderInfo .
  final void Function(RecorderInfo info)? onRecorderInfoUpdated;
}
