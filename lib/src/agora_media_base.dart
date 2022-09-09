import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_media_base.g.dart';

/// @nodoc
const defaultConnectionId = 0;

/// @nodoc
const dummyConnectionId = 4294967295;

/// 音频路由的类型。
///
@JsonEnum(alwaysCreate: true)
enum AudioRoute {
  /// -1: 使用默认的音频路由。
  @JsonValue(-1)
  routeDefault,

  /// 0: 音频路由为带麦克风的耳机。
  @JsonValue(0)
  routeHeadset,

  /// 1: 音频路由为听筒。
  @JsonValue(1)
  routeEarpiece,

  /// 2: 音频路由为不带麦克风的耳机。
  @JsonValue(2)
  routeHeadsetnomic,

  /// 3: 音频路由为设备自带的扬声器。
  @JsonValue(3)
  routeSpeakerphone,

  /// 4: 音频路由为外接的扬声器。（仅适用于 iOS 和 macOS）
  @JsonValue(4)
  routeLoudspeaker,

  /// 5: 音频路由为蓝牙耳机。
  @JsonValue(5)
  routeHeadsetbluetooth,

  /// 7: 音频路由为 USB 外围设备。（仅适用于 macOS）
  @JsonValue(6)
  routeUsb,

  /// 6: 音频路由为 HDMI 外围设备。（仅适用于 macOS）
  @JsonValue(7)
  routeHdmi,

  /// 8: 音频路由为 DisplayPort 外围设备。（仅适用于 macOS）
  @JsonValue(8)
  routeDisplayport,

  /// 9: 音频路由为 Apple AirPlay。（仅适用于 macOS）
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

/// 音频数据的使用模式。
///
@JsonEnum(alwaysCreate: true)
enum RawAudioFrameOpModeType {
  /// 0: 只读模式，
  @JsonValue(0)
  rawAudioFrameOpModeReadOnly,

  /// 2: 读写模式,
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

/// 媒体源类型。
///
@JsonEnum(alwaysCreate: true)
enum MediaSourceType {
  /// 0: 音频播放设备。
  @JsonValue(0)
  audioPlayoutSource,

  /// 1: 音频采集设备。
  @JsonValue(1)
  audioRecordingSource,

  /// 2: 第一个摄像头
  @JsonValue(2)
  primaryCameraSource,

  /// 3: 第二个摄像头。
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

  /// 100: 未知媒体源。
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

/// 鉴黄结果。
///
@JsonEnum(alwaysCreate: true)
enum ContentInspectResult {
  /// 1：正常图片。
  @JsonValue(1)
  contentInspectNeutral,

  /// 2：性感图片。
  @JsonValue(2)
  contentInspectSexy,

  /// 3：色情图片。
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

/// 视频内容审核模块的类型。
///
@JsonEnum(alwaysCreate: true)
enum ContentInspectType {
  /// 0：（默认）该功能模块无实际功能。请不要将 type 设为该值。
  @JsonValue(0)
  contentInspectInvalid,

  /// 1：视频鉴黄。SDK 会对视频流进行截图、鉴黄，并将截图和审核结果上传。
  @JsonValue(1)
  contentInspectModeration,

  /// 2：视频截图。SDK 会对视频流进行截图并上传。
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

/// ContentInspectModule 结构体，用于配置视频内容审核模块的类型和频率。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ContentInspectModule {
  /// @nodoc
  const ContentInspectModule({this.type, this.interval});

  /// 视频内容审核模块的类型。详见 ContentInspectType 。
  @JsonKey(name: 'type')
  final ContentInspectType? type;

  /// 视频内容审核的间隔，单位为秒，取值必须大于 0。默认值为 0，表示不进行内容审核。推荐值为 10 秒，你也可以根据业务需求自行调整。
  @JsonKey(name: 'interval')
  final int? interval;

  /// @nodoc
  factory ContentInspectModule.fromJson(Map<String, dynamic> json) =>
      _$ContentInspectModuleFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ContentInspectModuleToJson(this);
}

/// 视频内容审核配置。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ContentInspectConfig {
  /// @nodoc
  const ContentInspectConfig({this.extraInfo, this.modules, this.moduleCount});

  /// 视频内容审核的附加信息，最大长度为 1024 字节。SDK 会将附加信息和截图一起上传至 Agora 内容审核服务器；审核完成后，Agora 内容审核服务器会将附加信息随审核结果一起发送给你的服务器。
  @JsonKey(name: 'extraInfo')
  final String? extraInfo;

  /// 视频内容审核模块。详见 ContentInspectModule 。最多支持配置 32 个 ContentInspectModule 实例，MAX_CONTENT_INSPECT_MODULE_COUNT 的取值范围为 [1,32] 中的整数。一个视频内容审核模块最多只能配置一个实例。
  @JsonKey(name: 'modules')
  final List<ContentInspectModule>? modules;

  /// 视频内容审核模块数，即配置的 ContentInspectModule 实例的数量，必须与 modules 中配置的实例个数一致。最大值为 32。
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

/// 外部 PCM 格式音频帧的信息。
///
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

  /// 音频帧的时间戳 (ms)。
  @JsonKey(name: 'capture_timestamp')
  final int? captureTimestamp;

  /// 每个声道的采样点数。
  @JsonKey(name: 'samples_per_channel_')
  final int? samplesPerChannel;

  /// 音频采样率 (Hz)。
  @JsonKey(name: 'sample_rate_hz_')
  final int? sampleRateHz;

  /// 音频声道数。
  @JsonKey(name: 'num_channels_')
  final int? numChannels;

  /// 音频数据的字节数。
  @JsonKey(name: 'bytes_per_sample')
  final BytesPerSample? bytesPerSample;

  /// 音频帧数据。
  @JsonKey(name: 'data_')
  final List<int>? data;

  /// @nodoc
  factory AudioPcmFrame.fromJson(Map<String, dynamic> json) =>
      _$AudioPcmFrameFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AudioPcmFrameToJson(this);
}

/// 声道模式。
///
@JsonEnum(alwaysCreate: true)
enum AudioDualMonoMode {
  /// 0: 原始模式。
  @JsonValue(0)
  audioDualMonoStereo,

  /// 1: 左声道模式。该模式用左声道的音频替换右声道的音频，即用户只能听到左声道的音频。
  @JsonValue(1)
  audioDualMonoL,

  /// 2: 右声道模式。该模式用右声道的音频替换左声道的音频，即用户只能听到右声道的音频。
  @JsonValue(2)
  audioDualMonoR,

  /// 3: 混合模式。该模式将左右声道的数据叠加，即用户能同时听到左声道和右声道的音频。
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

/// 视频像素格式。
///
@JsonEnum(alwaysCreate: true)
enum VideoPixelFormat {
  /// 0: 原始视频像素格式。
  @JsonValue(0)
  videoPixelDefault,

  /// 1: I420 格式。
  @JsonValue(1)
  videoPixelI420,

  /// @nodoc
  @JsonValue(2)
  videoPixelBgra,

  /// @nodoc
  @JsonValue(3)
  videoPixelNv21,

  /// 4: RGBA 格式。
  @JsonValue(4)
  videoPixelRgba,

  /// 8: NV12 格式。
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

  /// 16: I422 格式。
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

/// 视频显示模式。
///
@JsonEnum(alwaysCreate: true)
enum RenderModeType {
  /// 1: 视频尺寸等比缩放。优先保证视窗被填满。因视频尺寸与显示视窗尺寸不一致而多出的视频将被截掉。
  @JsonValue(1)
  renderModeHidden,

  /// 2: 视频尺寸等比缩放。优先保证视频内容全部显示。因视频尺寸与显示视窗尺寸不一致造成的视窗未被填满的区域填充黑色。
  @JsonValue(2)
  renderModeFit,

  /// 弃用：3: 该模式已弃用。
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

/// 外部视频帧。
///
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

  /// 视频类型。详见 VideoBufferType 。
  @JsonKey(name: 'type')
  final VideoBufferType? type;

  /// 像素格式。详见 VideoPixelFormat 。
  @JsonKey(name: 'format')
  final VideoPixelFormat? format;

  /// 视频缓冲区。
  @JsonKey(name: 'buffer', ignore: true)
  final Uint8List? buffer;

  /// 传入视频帧的行间距，单位为像素而不是字节。对于 Texture，该值指的是 Texture 的宽度。
  ///
  @JsonKey(name: 'stride')
  final int? stride;

  /// 传入视频帧的高度。
  @JsonKey(name: 'height')
  final int? height;

  /// 原始数据相关字段。指定左边裁剪掉的像素数量。默认为 0。
  @JsonKey(name: 'cropLeft')
  final int? cropLeft;

  /// 原始数据相关字段。指定顶边裁剪掉的像素数量。默认为 0。
  @JsonKey(name: 'cropTop')
  final int? cropTop;

  ///  原始数据相关字段。指定右边裁剪掉的像素数量。默认为 0。
  @JsonKey(name: 'cropRight')
  final int? cropRight;

  /// 原始数据相关字段。指定底边裁剪掉的像素数量。默认为 0。
  @JsonKey(name: 'cropBottom')
  final int? cropBottom;

  /// 原始数据相关字段。指定是否对传入的视频组做顺时针旋转操作，可选值为 0， 90， 180， 270。默认为 0。
  @JsonKey(name: 'rotation')
  final int? rotation;

  /// 传入的视频帧的时间戳，以毫秒为单位。不正确的时间戳会导致丢帧或者音视频不同步。
  @JsonKey(name: 'timestamp')
  final int? timestamp;

  /// 该参数仅适用于 Texture 格式的视频数据。指该视频帧的 Texture ID。
  @JsonKey(name: 'eglType')
  final EglContextType? eglType;

  /// 该参数仅适用于 Texture 格式的视频数据。为一个输入的 4x4 变换矩阵，典型值为一个单位矩阵。
  @JsonKey(name: 'textureId')
  final int? textureId;

  /// 该参数仅适用于 Texture 格式的视频数据。为一个输入的 4x4 变换矩阵，典型值为一个单位矩阵。
  @JsonKey(name: 'matrix')
  final List<double>? matrix;

  /// 该参数仅适用于 Texture 格式的视频数据。指 MetaData 的数据缓冲区，默认值为 NULL。
  @JsonKey(name: 'metadata_buffer', ignore: true)
  final Uint8List? metadataBuffer;

  /// 该参数仅适用于 Texture 格式的视频数据。指 MetaData 的大小，默认值为 0。
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

/// 视频 buffer 类型。
///
@JsonEnum(alwaysCreate: true)
enum VideoBufferType {
  /// 1: 类型为原始数据。
  @JsonValue(1)
  videoBufferRawData,

  /// 2: 类型为原始数据。
  @JsonValue(2)
  videoBufferArray,

  /// 3: 类型为 Texture。
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

/// 视频帧的属性设置。
/// 视频数据的格式为 YUV420。缓冲区给出的是指向指针的指针，该接口不能修改缓冲区的指针，只能修改缓冲区的内容。
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

  /// 像素格式。详见 VideoPixelFormat 。
  @JsonKey(name: 'type')
  final VideoPixelFormat? type;

  /// 视频像素宽度。
  @JsonKey(name: 'width')
  final int? width;

  /// 视频像素高度。
  @JsonKey(name: 'height')
  final int? height;

  /// 对 YUV 数据，表示 Y 缓冲区的行跨度；对 RGBA 数据，表示总的数据长度。
  @JsonKey(name: 'yStride')
  final int? yStride;

  /// 对 YUV 数据，表示 U 缓冲区的行跨度；对 RGBA 数据，值为 0。
  @JsonKey(name: 'uStride')
  final int? uStride;

  /// 对 YUV 数据，表示 V 缓冲区的行跨度；对 RGBA 数据，值为 0。
  @JsonKey(name: 'vStride')
  final int? vStride;

  /// 对 YUV 数据，表示 Y 缓冲区的指针；对 RGBA 数据，表示数据缓冲区。
  @JsonKey(name: 'yBuffer', ignore: true)
  final Uint8List? yBuffer;

  /// 对 YUV 数据，表示 U 缓冲区的指针；对 RGBA 数据，值为空。
  @JsonKey(name: 'uBuffer', ignore: true)
  final Uint8List? uBuffer;

  /// 对 YUV 数据，表示 V 缓冲区的指针；对 RGBA 数据，值为空。
  @JsonKey(name: 'vBuffer', ignore: true)
  final Uint8List? vBuffer;

  /// 在渲染视频前设置该帧的顺时针旋转角度，目前支持 0 度、90 度、180 度，和 270 度。
  @JsonKey(name: 'rotation')
  final int? rotation;

  /// 视频帧被渲染时的 Unix 时间戳（毫秒）。该时间戳可用于指导渲染视频帧。该参数为必填。
  @JsonKey(name: 'renderTimeMs')
  final int? renderTimeMs;

  /// 保留参数。
  @JsonKey(name: 'avsync_type')
  final int? avsyncType;

  /// 该参数仅适用于 Texture 格式的视频数据。指 MetaData 的数据缓冲区，默认值为 NULL。
  @JsonKey(name: 'metadata_buffer', ignore: true)
  final Uint8List? metadataBuffer;

  /// 该参数仅适用于 Texture 格式的视频数据。指 MetaData 的大小，默认值为 0。
  @JsonKey(name: 'metadata_size')
  final int? metadataSize;

  /// 该参数仅适用于 Texture 格式的视频数据。Texture ID。
  @JsonKey(name: 'textureId')
  final int? textureId;

  /// 该参数仅适用于 Texture 格式的视频数据。为一个输入的 4x4 变换矩阵，典型值为一个单位矩阵。
  @JsonKey(name: 'matrix')
  final List<double>? matrix;

  /// 表示人像分割算法的输出数据，跟视频帧的尺寸一致。每个像素点的取值范围为 [0,255]，其中 0 表示背景；255 代表前景（人像）。在用户自定义视频渲染场景下，该参数可帮助实现将视频背景自渲染为各种效果，例如：透明、纯色、图片、视频等等。 该参数需要开通。
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

/// 视频观测位置。
///
@JsonEnum(alwaysCreate: true)
enum VideoModulePosition {
  /// 1: 本地采集视频数据后的位置，对应 onCaptureVideoFrame 回调。
  @JsonValue(1 << 0)
  positionPostCapturer,

  /// 2: 接收远端发送视频前的位置，对应 onRenderVideoFrame 回调。
  @JsonValue(1 << 1)
  positionPreRenderer,

  /// 4: 本地视频编码前的位置，对应 onPreEncodeVideoFrame 回调。
  @JsonValue(1 << 2)
  positionPreEncoder,

  /// @nodoc
  @JsonValue(1 << 3)
  positionPostFilters,
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

/// 音频观测器。
///
class AudioFrameObserverBase {
  /// @nodoc
  const AudioFrameObserverBase({
    this.onRecordAudioFrame,
    this.onPlaybackAudioFrame,
    this.onMixedAudioFrame,
  });

  /// 获得采集的音频。
  ///
  ///
  /// * [audioFrame] 音频原始数据。详见 AudioFrame 。
  /// * [channelId] 频道 ID。
  ///
  /// Returns
  /// 无实际含义。
  final void Function(String channelId, AudioFrame audioFrame)?
      onRecordAudioFrame;

  /// 获得播放的声音。
  /// 为保证播放的音频数据格式符合预期，Agora 推荐你在调用 registerAudioFrameObserver 注册音频观测器后，调用 setPlaybackAudioFrameParameters 方法设置播放的音频数据格式。
  ///
  /// * [audioFrame] 音频原始数据。详见 AudioFrame 。
  /// * [channelId] 频道 ID。
  ///
  /// Returns
  /// 无实际含义。
  final void Function(String channelId, AudioFrame audioFrame)?
      onPlaybackAudioFrame;

  /// 获取采集和播放音频混音后的数据。
  /// 该方法仅返回单通道数据。为保证采集和播放音频混音后的数据格式符合预期，Agora 推荐你在调用 registerAudioFrameObserver 注册音频观测器后，调用 setMixedAudioFrameParameters 方法设置采集和播放音频混音后的音频数据格式。
  ///
  /// * [audioFrame] 音频原始数据。详见 AudioFrame 。
  /// * [channelId] 频道 ID。
  ///
  /// Returns
  /// 无实际含义。
  final void Function(String channelId, AudioFrame audioFrame)?
      onMixedAudioFrame;
}

/// 音频帧类型。
///
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

/// 原始音频数据。
///
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

  /// 音频帧类型，详见 AudioFrameType 。
  @JsonKey(name: 'type')
  final AudioFrameType? type;

  /// 每个声道的采样点数。
  @JsonKey(name: 'samplesPerChannel')
  final int? samplesPerChannel;

  /// 每个采样点的字节数: 对于 PCM 来说，一般使用 16 bit，即两个字节。
  @JsonKey(name: 'bytesPerSample')
  final BytesPerSample? bytesPerSample;

  /// 声道数量(如果是立体声，数据是交叉的)。
  ///  1: 单声道2: 双声道
  @JsonKey(name: 'channels')
  final int? channels;

  /// 每声道每秒的采样点数。
  @JsonKey(name: 'samplesPerSec')
  final int? samplesPerSec;

  /// 声音数据缓存区（如果是立体声，数据是交叉存储的）。缓存区数据大小 buffer = samples × channels × bytesPerSample。
  @JsonKey(name: 'buffer', ignore: true)
  final Uint8List? buffer;

  /// 外部音频帧的渲染时间戳。你可以使用该时间戳还原音频帧顺序；在有视频的场景中（包含使用外部视频源的场景），该参数可以用于实现音视频同步。
  @JsonKey(name: 'renderTimeMs')
  final int? renderTimeMs;

  /// 保留参数。
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

/// 音频数据格式。
/// SDK 会通过 AudioParams 中的 samplesPerCall、sampleRate 和 channel 参数计算采样间隔，并根据该采样间隔触发 onRecordAudioFrame、onPlaybackAudioFrame 和 onMixedAudioFrame 回调。采样间隔 = samplesPerCall/(sampleRate × channel)。请确保采样间隔不得小于 0.01 (s)。
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioParams {
  /// @nodoc
  const AudioParams(
      {this.sampleRate, this.channels, this.mode, this.samplesPerCall});

  /// 数据的采样率，单位为 Hz，取值如下： 800016000（默认值）320004410048000
  @JsonKey(name: 'sample_rate')
  final int? sampleRate;

  /// 数据的声道数，取值如下：
  ///  1：单声道（默认值）2：双声道
  @JsonKey(name: 'channels')
  final int? channels;

  /// 数据的使用模式。详见 RawAudioFrameOpModeType 。
  @JsonKey(name: 'mode')
  final RawAudioFrameOpModeType? mode;

  /// 数据的采样点数，如旁路推流应用中通常为 1024。
  @JsonKey(name: 'samples_per_call')
  final int? samplesPerCall;

  /// @nodoc
  factory AudioParams.fromJson(Map<String, dynamic> json) =>
      _$AudioParamsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AudioParamsToJson(this);
}

/// 音频观测器。
///
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
    this.onPlaybackAudioFrameBeforeMixing,
  }) : super(
          onRecordAudioFrame: onRecordAudioFrame,
          onPlaybackAudioFrame: onPlaybackAudioFrame,
          onMixedAudioFrame: onMixedAudioFrame,
        );

  /// 获得混音前的指定用户的声音。
  ///
  ///
  /// * [channelId] 频道 ID。
  /// * [uid] 指定用户的用户 ID。
  /// * [audioFrame] 音频原始数据。详见 AudioFrame 。
  ///
  /// Returns
  /// 无实际含义。
  final void Function(String channelId, int uid, AudioFrame audioFrame)?
      onPlaybackAudioFrameBeforeMixing;
}

/// 音频频谱数据。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AudioSpectrumData {
  /// @nodoc
  const AudioSpectrumData({this.audioSpectrumData, this.dataLength});

  /// 音频频谱数据。Agora 将声音频率分为 256 个频域，通过该参数报告各频域的能量值，每个能量值的取值范围为 [-300,1]，单位为 dBFS。
  @JsonKey(name: 'audioSpectrumData')
  final List<double>? audioSpectrumData;

  /// 音频频谱数据长度为 256。
  @JsonKey(name: 'dataLength')
  final int? dataLength;

  /// @nodoc
  factory AudioSpectrumData.fromJson(Map<String, dynamic> json) =>
      _$AudioSpectrumDataFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AudioSpectrumDataToJson(this);
}

/// 远端用户的音频频谱信息。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class UserAudioSpectrumInfo {
  /// @nodoc
  const UserAudioSpectrumInfo({this.uid, this.spectrumData});

  /// 远端用户 ID。
  @JsonKey(name: 'uid')
  final int? uid;

  /// 远端用户的音频频谱数据。详见 AudioSpectrumData 。
  @JsonKey(name: 'spectrumData')
  final AudioSpectrumData? spectrumData;

  /// @nodoc
  factory UserAudioSpectrumInfo.fromJson(Map<String, dynamic> json) =>
      _$UserAudioSpectrumInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$UserAudioSpectrumInfoToJson(this);
}

/// 音频频谱观测器。
///
class AudioSpectrumObserver {
  /// @nodoc
  const AudioSpectrumObserver({
    this.onLocalAudioSpectrum,
    this.onRemoteAudioSpectrum,
  });

  /// 获取本地音频频谱。
  /// 成功调用 registerAudioSpectrumObserver 实现 AudioSpectrumObserver 中的 onLocalAudioSpectrum 回调并调用 enableAudioSpectrumMonitor 开启音频频谱监测后，SDK 会按照你设置的时间间隔触发该回调，报告编码后的本地音频数据的频谱。
  ///
  /// * [data] 本地用户的音频频谱数据。详见 AudioSpectrumData 。
  final void Function(AudioSpectrumData data)? onLocalAudioSpectrum;

  /// 获取远端音频频谱。
  /// 成功调用 registerAudioSpectrumObserver 实现 AudioSpectrumObserver 中的 onRemoteAudioSpectrum 回调并调用 enableAudioSpectrumMonitor 开启音频频谱监测后，SDK 会按照你设置的时间间隔触发该回调，报告接收到的远端音频数据的频谱。
  ///
  /// * [spectrums] 远端用户的音频频谱信息，详见 UserAudioSpectrumInfo 。 数组数量等于 SDK 监测到的远端用户数量，数组为空表示没有监测到远端用户的音频频谱。
  /// * [spectrumNumber] 远端用户的数量。
  final void Function(
          List<UserAudioSpectrumInfo> spectrums, int spectrumNumber)?
      onRemoteAudioSpectrum;
}

/// 用于接收编码后的视频图像的类。
///
class VideoEncodedFrameObserver {
  /// @nodoc
  const VideoEncodedFrameObserver({
    this.onEncodedVideoFrameReceived,
  });

  /// 报告 SDK 接收到编码后的视频图像。
  ///
  ///
  /// * [uid] 远端用户 ID。
  /// * [imageBuffer] 视频图像 buffer。
  /// * [length] 视频图像的数据长度。
  /// * [videoEncodedFrameInfo] 编码后的视频帧信息，详见 EncodedVideoFrameInfo 。
  ///
  /// Returns
  /// 无实际含义。
  final void Function(int uid, Uint8List imageBuffer, int length,
      EncodedVideoFrameInfo videoEncodedFrameInfo)? onEncodedVideoFrameReceived;
}

/// 视频观测器。
///
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

  /// 获取本地摄像头采集到的视频数据。
  /// 成功注册视频数据观测器后，SDK 会在捕捉到每个视频帧时触发该回调。你可以在回调中获取本地摄像头采集到的视频数据，然后根据场景需要，对视频数据进行前处理。完成前处理后，你可以在该回调中，传入处理后的视频数据将其发送回 SDK。此处获取的视频数据未经过前处理，如水印、裁剪、旋转和美颜等。
  ///
  /// * [videoFrame] 视频帧数据。详见 VideoFrame 。
  final void Function(VideoFrame videoFrame)? onCaptureVideoFrame;

  /// 获取本地视频编码前的视频数据。
  /// 成功注册视频数据观测器后，SDK 会在捕捉到每个视频帧时触发该回调。你可以在回调中获取编码前的视频数据，然后根据场景需要，对视频数据进行处理。完成处理后，你可以在该回调中，传入处理后的视频数据将其发送回 SDK。此处获取的视频数据已经过前处理，如裁剪、旋转和美颜等。
  ///
  /// * [videoFrame] 视频帧数据。详见 VideoFrame 。
  final void Function(VideoFrame videoFrame)? onPreEncodeVideoFrame;

  /// @nodoc
  final void Function(VideoFrame videoFrame)?
      onSecondaryCameraCaptureVideoFrame;

  /// 获取第二个摄像头采集后、编码前的视频数据。
  /// 成功注册视频数据观测器后，SDK 会在捕捉到每个视频帧时触发该回调。你可以在回调中获取第二个摄像头采集后、编码前的视频数据，然后根据场景需要，对视频数据进行处理。完成处理后，你可以在该回调中，传入处理后的视频数据将其发送回 SDK。
  ///
  /// * [videoFrame] 视频帧数据。详见 VideoFrame 。
  final void Function(VideoFrame videoFrame)?
      onSecondaryPreEncodeCameraVideoFrame;

  /// 获取从屏幕采集到的视频数据。
  /// 成功注册视频数据观测器后，SDK 会在捕捉到每个视频帧时触发该回调。你可以在回调中获取从屏幕采集到的视频数据，然后根据场景需要，对视频数据进行前处理。完成前处理后，你可以在该回调中，传入处理后的视频数据将其发送回 SDK。如果你获取到的视频数据类型为 RGBA，Agora 不支持将处理后的 RGBA 数据通过该回调再发送回 SDK。此处获取的视频数据未经过前处理，如水印、裁剪、旋转和美颜等。
  ///
  /// * [videoFrame] 视频帧数据。详见 VideoFrame 。
  final void Function(VideoFrame videoFrame)? onScreenCaptureVideoFrame;

  /// 获取屏幕采集后、编码前的视频数据。
  /// 成功注册视频数据观测器后，SDK 会在捕捉到每个视频帧时触发该回调。你可以在回调中获取从屏幕采集后、编码前的视频数据，然后根据场景需要，对视频数据进行处理。完成处理后，你可以在该回调中，传入处理后的视频数据将其发送回 SDK。此处获取的视频数据已经过前处理，如裁剪、旋转和美颜等。如果你获取到的视频数据类型为 RGBA，Agora 不支持将处理后的 RGBA 数据通过该回调再发送回 SDK。
  ///
  /// * [videoFrame] 视频帧数据。详见 VideoFrame 。
  final void Function(VideoFrame videoFrame)? onPreEncodeScreenVideoFrame;

  /// 获取媒体播放器中的视频数据。
  /// 成功注册视频数据观测器并调用 createMediaPlayer 后， SDK 会在捕捉到每个视频帧时触发该回调。
  ///  你可以在回调中获取媒体播放器中的视频数据，然后根据场景需要，对视频数据进行前处理。完成前处理后，你可以在该回调中，传入处理后的视频数据将其发送回 SDK。
  ///
  /// * [videoFrame] 视频帧数据。详见 VideoFrame 。
  /// * [mediaPlayerId] 媒体播放器 ID。
  ///
  /// Returns
  /// true：设置 SDK 接收视频帧。false：设置 SDK 丢弃视频帧。
  final void Function(VideoFrame videoFrame, int mediaPlayerId)?
      onMediaPlayerVideoFrame;

  /// @nodoc
  final void Function(VideoFrame videoFrame)?
      onSecondaryScreenCaptureVideoFrame;

  /// 获取从第二个屏幕采集后、编码前的视频数据。
  /// 成功注册视频数据观测器后，SDK 会在捕捉到每个视频帧时触发该回调。你可以在回调中获取从第二个屏幕采集后、编码前的视频数据，然后根据场景需要，对视频数据进行处理。完成处理后，你可以在该回调中，传入处理后的视频数据将其发送回 SDK。
  ///
  /// * [videoFrame] 视频帧数据。详见 VideoFrame 。
  final void Function(VideoFrame videoFrame)?
      onSecondaryPreEncodeScreenVideoFrame;

  /// 获取远端发送的视频数据。
  /// 成功注册视频数据观测器后，SDK 会在捕捉到每个视频帧时触发该回调。你可以在回调中获取远端发送的视频数据，然后根据场景需要，对视频数据进行处理。该功能仅支持视频处理模式为 processModeReadOnly 的场景。
  ///
  /// * [videoFrame] 视频帧数据。详见 VideoFrame 。
  /// * [remoteUid] 发送该帧视频的远端用户 ID。
  /// * [channelId] 频道 ID。
  final void Function(String channelId, int remoteUid, VideoFrame videoFrame)?
      onRenderVideoFrame;

  /// @nodoc
  final void Function(VideoFrame videoFrame)? onTranscodedVideoFrame;
}

/// 视频帧处理模式。
///
@JsonEnum(alwaysCreate: true)
enum VideoFrameProcessMode {
  /// 只读模式。只读模式下，你不修改视频帧，视频观测器相当于渲染器。
  @JsonValue(0)
  processModeReadOnly,

  /// 读写模式。读写模式下，你会修改视频帧，视频观测器相当于视频 filter。
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

/// 外部视频帧编码类型。
///
@JsonEnum(alwaysCreate: true)
enum ExternalVideoSourceType {
  /// 0：未编码视频帧。
  @JsonValue(0)
  videoFrame,

  /// 1：已编码视频帧。
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

/// 录制文件的格式。
///
@JsonEnum(alwaysCreate: true)
enum MediaRecorderContainerFormat {
  /// 1:（默认）MP4
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

/// 录制内容。
///
@JsonEnum(alwaysCreate: true)
enum MediaRecorderStreamType {
  /// 仅音频。
  @JsonValue(0x01)
  streamTypeAudio,

  /// 仅视频。
  @JsonValue(0x02)
  streamTypeVideo,

  /// （默认）音视频。
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

/// 当前的录制状态。
///
@JsonEnum(alwaysCreate: true)
enum RecorderState {
  /// -1: 音视频流录制出错，错误原因详见 RecorderErrorCode 。
  @JsonValue(-1)
  recorderStateError,

  /// 2: 音视频流录制开始。
  @JsonValue(2)
  recorderStateStart,

  /// 3: 音视频流录制停止。
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

/// 录制状态出错的原因。
///
@JsonEnum(alwaysCreate: true)
enum RecorderErrorCode {
  /// 0: 一切正常。
  @JsonValue(0)
  recorderErrorNone,

  /// 1: 录制文件写入失败。
  @JsonValue(1)
  recorderErrorWriteFailed,

  /// 2: 没有可录制的音视频流或者录制的音视频流中断超过 5 秒。
  @JsonValue(2)
  recorderErrorNoStream,

  /// 3: 录制时长超出上限。
  @JsonValue(3)
  recorderErrorOverMaxDuration,

  /// 4: 录制配置改变。
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

/// 本地音视频流录制配置。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MediaRecorderConfiguration {
  /// @nodoc
  const MediaRecorderConfiguration(
      {this.storagePath,
      this.containerFormat,
      this.streamType,
      this.maxDurationMs,
      this.recorderInfoUpdateInterval});

  /// 录音文件在本地保存的绝对路径，需精确到文件名及格式。例如：
  ///  Windows: C:\Users\<user_name>\AppData\Local\Agora\<process_name>\example.mp4iOS: /App Sandbox/Library/Caches/example.mp4macOS: /Library/Logs/example.mp4Android: /storage/emulated/0/Android/data/<package name>/files/example.mp4请确保你指定的路径存在并且可写。
  @JsonKey(name: 'storagePath')
  final String? storagePath;

  /// 录制文件的格式。详见 MediaRecorderContainerFormat 。
  @JsonKey(name: 'containerFormat')
  final MediaRecorderContainerFormat? containerFormat;

  /// 录制内容。详见 MediaRecorderStreamType 。
  @JsonKey(name: 'streamType')
  final MediaRecorderStreamType? streamType;

  /// 最大录制时长，单位为毫秒，默认值为 120000。
  @JsonKey(name: 'maxDurationMs')
  final int? maxDurationMs;

  /// 录制信息更新间隔，单位为毫秒，取值范围为 [1000,10000]。SDK 会根据该值的设置触发 onRecorderInfoUpdated 回调，报告更新后的录制信息。
  @JsonKey(name: 'recorderInfoUpdateInterval')
  final int? recorderInfoUpdateInterval;

  /// @nodoc
  factory MediaRecorderConfiguration.fromJson(Map<String, dynamic> json) =>
      _$MediaRecorderConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$MediaRecorderConfigurationToJson(this);
}

/// 录制文件信息。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RecorderInfo {
  /// @nodoc
  const RecorderInfo({this.fileName, this.durationMs, this.fileSize});

  /// 录制文件的绝对存储路径。
  @JsonKey(name: 'fileName')
  final String? fileName;

  /// 录制文件的时长，单位为毫秒。
  @JsonKey(name: 'durationMs')
  final int? durationMs;

  /// 录制文件的大小，单位为字节。
  @JsonKey(name: 'fileSize')
  final int? fileSize;

  /// @nodoc
  factory RecorderInfo.fromJson(Map<String, dynamic> json) =>
      _$RecorderInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RecorderInfoToJson(this);
}

/// 包含音视频录制的事件。
///
class MediaRecorderObserver {
  /// @nodoc
  const MediaRecorderObserver({
    this.onRecorderStateChanged,
    this.onRecorderInfoUpdated,
  });

  /// 录制状态发生改变回调。
  /// 本地音视频流录制状态发生改变时，SDK 会触发该回调，报告当前的录制状态和引起录制状态改变的原因。
  ///
  /// * [state] 当前的录制状态。详见 RecorderState 。
  /// * [error] 录制状态出错的原因。详见 RecorderErrorCode 。
  final void Function(RecorderState state, RecorderErrorCode error)?
      onRecorderStateChanged;

  /// 录制信息更新回调。
  /// 成功注册该回调并开启本地音视频流录制后，SDK 会根据你在 MediaRecorderConfiguration 中设置的 recorderInfoUpdateInterval 的值周期性触发该回调，报告当前录制文件的文件名、时长和大小。
  ///
  /// * [info] 录制文件信息。详见 RecorderInfo 。
  final void Function(RecorderInfo info)? onRecorderInfoUpdated;
}
