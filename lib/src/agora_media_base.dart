import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_media_base.g.dart';

/// @nodoc
const invalidTrackId = 0xffffffff;

/// @nodoc
const defaultConnectionId = 0;

/// @nodoc
const dummyConnectionId = 4294967295;

/// The type of the video source.
@JsonEnum(alwaysCreate: true)
enum VideoSourceType {
  /// 0: (Default) The primary camera.
  @JsonValue(0)
  videoSourceCameraPrimary,

  /// 0: (Default) The primary camera.
  @JsonValue(0)
  videoSourceCamera,

  /// 1: The secondary camera.
  @JsonValue(1)
  videoSourceCameraSecondary,

  /// 2: The primary screen.
  @JsonValue(2)
  videoSourceScreenPrimary,

  /// 2: The primary screen.
  @JsonValue(2)
  videoSourceScreen,

  /// 3: The secondary screen.
  @JsonValue(3)
  videoSourceScreenSecondary,

  /// 4: A custom video source.
  @JsonValue(4)
  videoSourceCustom,

  /// 5: The media player.
  @JsonValue(5)
  videoSourceMediaPlayer,

  /// 6: One PNG image.
  @JsonValue(6)
  videoSourceRtcImagePng,

  /// 7: One JPEG image.
  @JsonValue(7)
  videoSourceRtcImageJpeg,

  /// 8: One GIF image.
  @JsonValue(8)
  videoSourceRtcImageGif,

  /// 9: One remote video acquired by the network.
  @JsonValue(9)
  videoSourceRemote,

  /// 10: One transcoded video source.
  @JsonValue(10)
  videoSourceTranscoded,

  /// 11: (For Android, Windows, and macOS only) The third camera.
  @JsonValue(11)
  videoSourceCameraThird,

  /// 12: (For Android, Windows, and macOS only) The fourth camera.
  @JsonValue(12)
  videoSourceCameraFourth,

  /// 13: (For Windows and macOS only) The third screen.
  @JsonValue(13)
  videoSourceScreenThird,

  /// 14: (For Windows and macOS only) The fourth screen.
  @JsonValue(14)
  videoSourceScreenFourth,

  /// @nodoc
  @JsonValue(15)
  videoSourceSpeechDriven,

  /// 100: An unknown video source.
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

  /// @nodoc
  @JsonValue(5)
  routeBluetoothDeviceHfp,

  /// 6: The audio route is a USB peripheral device. (For macOS only)
  @JsonValue(6)
  routeUsb,

  /// 7: The audio route is an HDMI peripheral device. (For macOS only)
  @JsonValue(7)
  routeHdmi,

  /// 8: The audio route is a DisplayPort peripheral device. (For macOS only)
  @JsonValue(8)
  routeDisplayport,

  /// 9: The audio route is Apple AirPlay. (For macOS only)
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
  /// 0: Read-only mode, For example, when users acquire the data with the Agora SDK, then start the media push.
  @JsonValue(0)
  rawAudioFrameOpModeReadOnly,

  /// 2: Read and write mode, For example, when users have their own audio-effect processing module and perform some voice preprocessing, such as a voice change.
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

  /// 3: A secondary camera.
  @JsonValue(3)
  secondaryCameraSource,

  /// @nodoc
  @JsonValue(4)
  primaryScreenSource,

  /// @nodoc
  @JsonValue(5)
  secondaryScreenSource,

  /// 6: Custom video source.
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

  /// @nodoc
  @JsonValue(1)
  contentInspectModeration,

  /// 2: Video screenshot and upload via Agora self-developed extension. SDK takes screenshots of the video stream in the channel and uploads them.
  @JsonValue(2)
  contentInspectSupervision,

  /// 3: Video screenshot and upload via extensions from Agora Extensions Marketplace. SDK uses video moderation extensions from Agora Extensions Marketplace to take screenshots of the video stream in the channel and uploads them.
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

/// A ContentInspectModule structure used to configure the frequency of video screenshot and upload.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ContentInspectModule {
  /// @nodoc
  const ContentInspectModule({this.type, this.interval});

  /// Types of functional module. See ContentInspectType.
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
  const ContentInspectConfig(
      {this.extraInfo, this.serverConfig, this.modules, this.moduleCount});

  /// Additional information on the video content (maximum length: 1024 Bytes). The SDK sends the screenshots and additional information on the video content to the Agora server. Once the video screenshot and upload process is completed, the Agora server sends the additional information and the callback notification to your server.
  @JsonKey(name: 'extraInfo')
  final String? extraInfo;

  /// (Optional) Server configuration related to uploading video screenshots via extensions from Agora Extensions Marketplace. This parameter only takes effect when type in ContentInspectModule is set to contentInspectImageModeration. If you want to use it, contact.
  @JsonKey(name: 'serverConfig')
  final String? serverConfig;

  /// Functional module. See ContentInspectModule. A maximum of 32 ContentInspectModule instances can be configured, and the value range of MAX_CONTENT_INSPECT_MODULE_COUNT is an integer in [1,32]. A function module can only be configured with one instance at most. Currently only the video screenshot and upload function is supported.
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

  /// The audio frame.
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

  /// 16: The format is I422.
  @JsonValue(16)
  videoPixelI422,

  /// 17: The ID3D11TEXTURE2D format. Currently supported types are DXGI_FORMAT_B8G8R8A8_UNORM, DXGI_FORMAT_B8G8R8A8_TYPELESS and DXGI_FORMAT_NV12.
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

/// Video display modes.
@JsonEnum(alwaysCreate: true)
enum RenderModeType {
  /// 1: Hidden mode. Uniformly scale the video until one of its dimension fits the boundary (zoomed to fit). One dimension of the video may have clipped contents.
  @JsonValue(1)
  renderModeHidden,

  /// 2: Fit mode. Uniformly scale the video until one of its dimension fits the boundary (zoomed to fit). Areas that are not filled due to disparity in the aspect ratio are filled with black.
  @JsonValue(2)
  renderModeFit,

  /// Deprecated: 3: This mode is deprecated.
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
      this.metadataSize,
      this.alphaBuffer,
      this.fillAlphaBuffer,
      this.textureSliceIndex});

  /// The video type. See VideoBufferType.
  @JsonKey(name: 'type')
  final VideoBufferType? type;

  /// The pixel format. See VideoPixelFormat.
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

  /// This parameter only applies to video data in Texture format. Texture ID of the video frame.
  @JsonKey(name: 'eglType')
  final EglContextType? eglType;

  /// This parameter only applies to video data in Texture format. Incoming 4 × 4 transformational matrix. The typical value is a unit matrix.
  @JsonKey(name: 'textureId')
  final int? textureId;

  /// This parameter only applies to video data in Texture format. Incoming 4 × 4 transformational matrix. The typical value is a unit matrix.
  @JsonKey(name: 'matrix')
  final List<double>? matrix;

  /// This parameter only applies to video data in Texture format. The MetaData buffer. The default value is NULL.
  @JsonKey(name: 'metadata_buffer', ignore: true)
  final Uint8List? metadataBuffer;

  /// This parameter only applies to video data in Texture format. The MetaData size. The default value is 0.
  @JsonKey(name: 'metadata_size')
  final int? metadataSize;

  /// @nodoc
  @JsonKey(name: 'alphaBuffer', ignore: true)
  final Uint8List? alphaBuffer;

  /// @nodoc
  @JsonKey(name: 'fillAlphaBuffer')
  final bool? fillAlphaBuffer;

  /// This parameter only applies to video data in Windows Texture format. It represents an index of an ID3D11Texture2D texture object used by the video frame in the ID3D11Texture2D array.
  @JsonKey(name: 'texture_slice_index')
  final int? textureSliceIndex;

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
///
/// Note that the buffer provides a pointer to a pointer. This interface cannot modify the pointer of the buffer, but it can modify the content of the buffer.
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
      this.alphaBuffer,
      this.pixelBuffer,
      this.metaInfo});

  /// The pixel format. See VideoPixelFormat.
  @JsonKey(name: 'type')
  final VideoPixelFormat? type;

  /// The width of the video, in pixels.
  @JsonKey(name: 'width')
  final int? width;

  /// The height of the video, in pixels.
  @JsonKey(name: 'height')
  final int? height;

  /// For YUV data, the line span of the Y buffer; for RGBA data, the total data length. When dealing with video data, it is necessary to process the offset between each line of pixel data based on this parameter, otherwise it may result in image distortion.
  @JsonKey(name: 'yStride')
  final int? yStride;

  /// For YUV data, the line span of the U buffer; for RGBA data, the value is 0. When dealing with video data, it is necessary to process the offset between each line of pixel data based on this parameter, otherwise it may result in image distortion.
  @JsonKey(name: 'uStride')
  final int? uStride;

  /// For YUV data, the line span of the V buffer; for RGBA data, the value is 0. When dealing with video data, it is necessary to process the offset between each line of pixel data based on this parameter, otherwise it may result in image distortion.
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

  /// The Unix timestamp (ms) when the video frame is rendered. This timestamp can be used to guide the rendering of the video frame. This parameter is required.
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
  @JsonKey(name: 'pixelBuffer', ignore: true)
  final Uint8List? pixelBuffer;

  /// The meta information in the video frame. To use this parameter, please.
  @VideoFrameMetaInfoConverter()
  @JsonKey(name: 'metaInfo')
  final VideoFrameMetaInfo? metaInfo;

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
  /// 1: The location of the locally collected video data after preprocessing corresponds to the onCaptureVideoFrame callback. The observed video here has the effect of video pre-processing, which can be verified by enabling image enhancement, virtual background, or watermark.
  @JsonValue(1 << 0)
  positionPostCapturer,

  /// 2: The pre-renderer position, which corresponds to the video data in the onRenderVideoFrame callback.
  @JsonValue(1 << 1)
  positionPreRenderer,

  /// 4: The pre-encoder position, which corresponds to the video data in the onPreEncodeVideoFrame callback. The observed video here has the effects of video pre-processing and encoding pre-processing.
  ///  To verify the pre-processing effects of the video, you can enable image enhancement, virtual background, or watermark.
  ///  To verify the pre-encoding processing effect, you can set a lower frame rate (for example, 5 fps).
  @JsonValue(1 << 2)
  positionPreEncoder,

  /// 8: The position after local video capture and before pre-processing. The observed video here does not have pre-processing effects, which can be verified by enabling image enhancement, virtual background, or watermarks.
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

/// This class is used to get raw PCM audio.
///
/// You can inherit this class and implement the onFrame callback to get raw PCM audio.
class AudioPcmFrameSink {
  /// @nodoc
  const AudioPcmFrameSink({
    this.onFrame,
  });

  /// Occurs each time the player receives an audio frame.
  ///
  /// After registering the audio frame observer, the callback occurs every time the player receives an audio frame, reporting the detailed information of the audio frame.
  ///
  /// * [frame] The audio frame information. See AudioPcmFrame.
  final void Function(AudioPcmFrame frame)? onFrame;
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
  ///
  /// To ensure that the data format of captured audio frame is as expected, Agora recommends that you set the audio data format as follows: After calling setRecordingAudioFrameParameters to set the audio data format, call registerAudioFrameObserver to register the audio observer object, the SDK will calculate the sampling interval according to the parameters set in this method, and triggers the onRecordAudioFrame callback according to the sampling interval.
  ///  Due to framework limitations, this callback does not support sending processed audio data back to the SDK.
  ///
  /// * [audioFrame] The raw audio data. See AudioFrame.
  /// * [channelId] The channel ID.
  final void Function(String channelId, AudioFrame audioFrame)?
      onRecordAudioFrame;

  /// Gets the raw audio frame for playback.
  ///
  /// To ensure that the data format of audio frame for playback is as expected, Agora recommends that you set the audio data format as follows: After calling setPlaybackAudioFrameParameters to set the audio data format and registerAudioFrameObserver to register the audio frame observer object, the SDK calculates the sampling interval according to the parameters set in the methods, and triggers the onPlaybackAudioFrame callback according to the sampling interval.
  ///  Due to framework limitations, this callback does not support sending processed audio data back to the SDK.
  ///
  /// * [audioFrame] The raw audio data. See AudioFrame.
  /// * [channelId] The channel ID.
  final void Function(String channelId, AudioFrame audioFrame)?
      onPlaybackAudioFrame;

  /// Retrieves the mixed captured and playback audio frame.
  ///
  /// To ensure that the data format of mixed captured and playback audio frame meets the expectations, Agora recommends that you set the data format as follows: After calling setMixedAudioFrameParameters to set the audio data format and registerAudioFrameObserver to register the audio frame observer object, the SDK calculates the sampling interval according to the parameters set in the methods, and triggers the onMixedAudioFrame callback according to the sampling interval.
  ///  Due to framework limitations, this callback does not support sending processed audio data back to the SDK.
  ///
  /// * [audioFrame] The raw audio data. See AudioFrame.
  /// * [channelId] The channel ID.
  final void Function(String channelId, AudioFrame audioFrame)?
      onMixedAudioFrame;

  /// Gets the in-ear monitoring audio frame.
  ///
  /// In order to ensure that the obtained in-ear audio data meets the expectations, Agora recommends that you set the in-ear monitoring-ear audio data format as follows: After calling setEarMonitoringAudioFrameParameters to set the audio data format and registerAudioFrameObserver to register the audio frame observer object, the SDK calculates the sampling interval according to the parameters set in the methods, and triggers the onEarMonitoringAudioFrame callback according to the sampling interval.
  ///  Due to framework limitations, this callback does not support sending processed audio data back to the SDK.
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
      this.avsyncType,
      this.presentationMs,
      this.audioTrackNumber,
      this.rtpTimestamp});

  /// The type of the audio frame. See AudioFrameType.
  @JsonKey(name: 'type')
  final AudioFrameType? type;

  /// The number of samples per channel in the audio frame.
  @JsonKey(name: 'samplesPerChannel')
  final int? samplesPerChannel;

  /// The number of bytes per sample. For PCM, this parameter is generally set to 16 bits (2 bytes).
  @JsonKey(name: 'bytesPerSample')
  final BytesPerSample? bytesPerSample;

  /// The number of audio channels (the data are interleaved if it is stereo).
  ///  1: Mono.
  ///  2: Stereo.
  @JsonKey(name: 'channels')
  final int? channels;

  /// The number of samples per channel in the audio frame.
  @JsonKey(name: 'samplesPerSec')
  final int? samplesPerSec;

  /// The data buffer of the audio frame. When the audio frame uses a stereo channel, the data buffer is interleaved. The size of the data buffer is as follows: buffer = samples × channels × bytesPerSample.
  @JsonKey(name: 'buffer', ignore: true)
  final Uint8List? buffer;

  /// The timestamp (ms) of the external audio frame. You can use this timestamp to restore the order of the captured audio frame, and synchronize audio and video frames in video scenarios, including scenarios where external video sources are used.
  @JsonKey(name: 'renderTimeMs')
  final int? renderTimeMs;

  /// Reserved for future use.
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
///
/// The SDK calculates the sampling interval through the samplesPerCall, sampleRate, and channel parameters in AudioParams, and triggers the onRecordAudioFrame, onPlaybackAudioFrame, onMixedAudioFrame, and onEarMonitoringAudioFrame callbacks according to the sampling interval. Sample interval (sec) = samplePerCall /(sampleRate × channel).
///  Ensure that the sample interval ≥ 0.01 (s).
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioParams {
  /// @nodoc
  const AudioParams(
      {this.sampleRate, this.channels, this.mode, this.samplesPerCall});

  /// The audio sample rate (Hz), which can be set as one of the following values:
  ///  8000.
  ///  (Default) 16000.
  ///  32000.
  ///  44100
  ///  48000
  @JsonKey(name: 'sample_rate')
  final int? sampleRate;

  /// The number of audio channels, which can be set as either of the following values:
  ///  1: (Default) Mono.
  ///  2: Stereo.
  @JsonKey(name: 'channels')
  final int? channels;

  /// The use mode of the audio data. See RawAudioFrameOpModeType.
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

  /// Retrieves the audio frame before mixing of subscribed remote users.
  ///
  /// Due to framework limitations, this callback does not support sending processed audio data back to the SDK.
  ///
  /// * [channelId] The channel ID.
  /// * [uid] The ID of subscribed remote users.
  /// * [audioFrame] The raw audio data. See AudioFrame.
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

  /// Audio spectrum information of the remote user. See AudioSpectrumData.
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
  ///
  /// After successfully calling registerAudioSpectrumObserver to implement the onLocalAudioSpectrum callback in AudioSpectrumObserver and calling enableAudioSpectrumMonitor to enable audio spectrum monitoring, the SDK will trigger the callback as the time interval you set to report the received remote audio data spectrum.
  ///
  /// * [data] The audio spectrum data of the local user. See AudioSpectrumData.
  final void Function(AudioSpectrumData data)? onLocalAudioSpectrum;

  /// Gets the remote audio spectrum.
  ///
  /// After successfully calling registerAudioSpectrumObserver to implement the onRemoteAudioSpectrum callback in the AudioSpectrumObserver and calling enableAudioSpectrumMonitor to enable audio spectrum monitoring, the SDK will trigger the callback as the time interval you set to report the received remote audio data spectrum.
  ///
  /// * [spectrums] The audio spectrum information of the remote user, see UserAudioSpectrumInfo. The number of arrays is the number of remote users monitored by the SDK. If the array is null, it means that no audio spectrum of remote users is detected.
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
  ///
  /// If you call the setRemoteVideoSubscriptionOptions method and set encodedFrameOnly to true, the SDK triggers this callback locally to report the received encoded video frame information.
  ///
  /// * [uid] The user ID of the remote user.
  /// * [imageBuffer] The encoded video image buffer.
  /// * [length] The data length of the video image.
  /// * [videoEncodedFrameInfo] For the information of the encoded video frame, see EncodedVideoFrameInfo.
  final void Function(int uid, Uint8List imageBuffer, int length,
      EncodedVideoFrameInfo videoEncodedFrameInfo)? onEncodedVideoFrameReceived;
}

/// The IVideoFrameObserver class.
class VideoFrameObserver {
  /// @nodoc
  const VideoFrameObserver({
    this.onCaptureVideoFrame,
    this.onPreEncodeVideoFrame,
    this.onMediaPlayerVideoFrame,
    this.onRenderVideoFrame,
    this.onTranscodedVideoFrame,
  });

  /// Occurs each time the SDK receives a video frame captured by local devices.
  ///
  /// You can get raw video data collected by the local device through this callback.
  ///
  /// * [sourceType] Video source types, including cameras, screens, or media player. See VideoSourceType.
  /// * [videoFrame] The video frame. See VideoFrame. The default value of the video frame data format obtained through this callback is as follows:
  ///  Android: I420
  ///  iOS: I420
  ///  macOS: I420
  ///  Windows: YUV420
  final void Function(VideoSourceType sourceType, VideoFrame videoFrame)?
      onCaptureVideoFrame;

  /// Occurs each time the SDK receives a video frame before encoding.
  ///
  /// After you successfully register the video frame observer, the SDK triggers this callback each time it receives a video frame. In this callback, you can get the video data before encoding and then process the data according to your particular scenarios.
  ///  Due to framework limitations, this callback does not support sending processed video data back to the SDK.
  ///  The video data that this callback gets has been preprocessed, with its content cropped and rotated, and the image enhanced.
  ///
  /// * [videoFrame] The video frame. See VideoFrame. The default value of the video frame data format obtained through this callback is as follows:
  ///  Android: I420
  ///  iOS: I420
  ///  macOS: I420
  ///  Windows: YUV420
  /// * [sourceType] The type of the video source. See VideoSourceType.
  final void Function(VideoSourceType sourceType, VideoFrame videoFrame)?
      onPreEncodeVideoFrame;

  /// @nodoc
  final void Function(VideoFrame videoFrame, int mediaPlayerId)?
      onMediaPlayerVideoFrame;

  /// Occurs each time the SDK receives a video frame sent by the remote user.
  ///
  /// After you successfully register the video frame observer, the SDK triggers this callback each time it receives a video frame. In this callback, you can get the video data sent from the remote end before rendering, and then process it according to the particular scenarios.
  ///  If the video data type you get is RGBA, the SDK does not support processing the data of the alpha channel.
  ///  Due to framework limitations, this callback does not support sending processed video data back to the SDK.
  ///
  /// * [videoFrame] The video frame. See VideoFrame. The default value of the video frame data format obtained through this callback is as follows:
  ///  Android: I420
  ///  iOS: I420
  ///  macOS: I420
  ///  Windows: YUV420
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
  /// Read-only mode. In this mode, you do not modify the video frame. The video frame observer is a renderer.
  @JsonValue(0)
  processModeReadOnly,

  /// Read and write mode. In this mode, you modify the video frame. The video frame observer is a video filter.
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
  /// -1: An error occurs during the recording. See RecorderReasonCode for the reason.
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
enum RecorderReasonCode {
  /// 0: No error.
  @JsonValue(0)
  recorderReasonNone,

  /// 1: The SDK fails to write the recorded data to a file.
  @JsonValue(1)
  recorderReasonWriteFailed,

  /// 2: The SDK does not detect any audio and video streams, or audio and video streams are interrupted for more than five seconds during recording.
  @JsonValue(2)
  recorderReasonNoStream,

  /// 3: The recording duration exceeds the upper limit.
  @JsonValue(3)
  recorderReasonOverMaxDuration,

  /// 4: The recording configuration changes.
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
class MediaRecorderConfiguration {
  /// @nodoc
  const MediaRecorderConfiguration(
      {this.storagePath,
      this.containerFormat,
      this.streamType,
      this.maxDurationMs,
      this.recorderInfoUpdateInterval});

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
  factory MediaRecorderConfiguration.fromJson(Map<String, dynamic> json) =>
      _$MediaRecorderConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$MediaRecorderConfigurationToJson(this);
}

/// Facial information observer.
///
/// You can call registerFaceInfoObserver to register one FaceInfoObserver observer.
class FaceInfoObserver {
  /// @nodoc
  const FaceInfoObserver({
    this.onFaceInfo,
  });

  /// Occurs when the facial information processed by speech driven extension is received.
  ///
  /// * [outFaceInfo] Output parameter, the JSON string of the facial information processed by the voice driver plugin, including the following fields:
  ///  faces: Object sequence. The collection of facial information, with each face corresponding to an object.
  ///  blendshapes: Object. The collection of face capture coefficients, named according to ARkit standards, with each key-value pair representing a blendshape coefficient. The blendshape coefficient is a floating point number with a range of [0.0, 1.0].
  ///  rotation: Object sequence. The rotation of the head, which includes the following three key-value pairs, with values as floating point numbers ranging from -180.0 to 180.0:
  ///  pitch: Head pitch angle. A positve value means looking down, while a negative value means looking up.
  ///  yaw: Head yaw angle. A positve value means turning left, while a negative value means turning right.
  ///  roll: Head roll angle. A positve value means tilting to the right, while a negative value means tilting to the left.
  ///  timestamp: String. The timestamp of the output result, in milliseconds. Here is an example of JSON:
  /// {
  ///  "faces":[{
  ///  "blendshapes":{
  ///  "eyeBlinkLeft":0.9, "eyeLookDownLeft":0.0, "eyeLookInLeft":0.0, "eyeLookOutLeft":0.0, "eyeLookUpLeft":0.0,
  ///  "eyeSquintLeft":0.0, "eyeWideLeft":0.0, "eyeBlinkRight":0.0, "eyeLookDownRight":0.0, "eyeLookInRight":0.0,
  ///  "eyeLookOutRight":0.0, "eyeLookUpRight":0.0, "eyeSquintRight":0.0, "eyeWideRight":0.0, "jawForward":0.0,
  ///  "jawLeft":0.0, "jawRight":0.0, "jawOpen":0.0, "mouthClose":0.0, "mouthFunnel":0.0, "mouthPucker":0.0,
  ///  "mouthLeft":0.0, "mouthRight":0.0, "mouthSmileLeft":0.0, "mouthSmileRight":0.0, "mouthFrownLeft":0.0,
  ///  "mouthFrownRight":0.0, "mouthDimpleLeft":0.0, "mouthDimpleRight":0.0, "mouthStretchLeft":0.0, "mouthStretchRight":0.0,
  ///  "mouthRollLower":0.0, "mouthRollUpper":0.0, "mouthShrugLower":0.0, "mouthShrugUpper":0.0, "mouthPressLeft":0.0,
  ///  "mouthPressRight":0.0, "mouthLowerDownLeft":0.0, "mouthLowerDownRight":0.0, "mouthUpperUpLeft":0.0, "mouthUpperUpRight":0.0,
  ///  "browDownLeft":0.0, "browDownRight":0.0, "browInnerUp":0.0, "browOuterUpLeft":0.0, "browOuterUpRight":0.0,
  ///  "cheekPuff":0.0, "cheekSquintLeft":0.0, "cheekSquintRight":0.0, "noseSneerLeft":0.0, "noseSneerRight":0.0,
  ///  "tongueOut":0.0
  ///  },
  ///  "rotation":{"pitch":30.0, "yaw":25.5, "roll":-15.5},
  ///
  ///  }],
  ///  "timestamp":"654879876546"
  /// }
  ///
  /// Returns
  /// true : Facial information JSON parsing successful. false : Facial information JSON parsing failed.
  final void Function(String outFaceInfo)? onFaceInfo;
}

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RecorderInfo {
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

  /// @nodoc
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
