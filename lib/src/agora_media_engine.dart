import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_media_engine.g.dart';

/// 声道模式。
///
@JsonEnum(alwaysCreate: true)
enum AudioMixingDualMonoMode {
  /// 0：原始模式。
  @JsonValue(0)
  audioMixingDualMonoAuto,

  /// 1：左声道模式。该模式用左声道的音频替换右声道的音频，即用户只能听到左声道的音频。
  @JsonValue(1)
  audioMixingDualMonoL,

  /// 2：右声道模式。该模式用右声道的音频替换左声道的音频，即用户只能听到右声道的音频。
  @JsonValue(2)
  audioMixingDualMonoR,

  /// 3：混合模式。该模式将左右声道的数据叠加，即用户能同时听到左声道和右声道的音频。
  @JsonValue(3)
  audioMixingDualMonoMix,
}

/// @nodoc
extension AudioMixingDualMonoModeExt on AudioMixingDualMonoMode {
  /// @nodoc
  static AudioMixingDualMonoMode fromValue(int value) {
    return $enumDecode(_$AudioMixingDualMonoModeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$AudioMixingDualMonoModeEnumMap[this]!;
  }
}

/// MediaEngine 类。
///
abstract class MediaEngine {
  /// 注册音频观测器对象。
  /// 该方法需要在加入频道前调用。
  ///
  /// * [observer] 接口对象实例。详见 AudioFrameObserver 。Agora 建议在收到 onLeaveChannel 后调用，来释放音频观测器对象。
  void registerAudioFrameObserver(AudioFrameObserver observer);

  /// 注册视频观测器对象。
  /// 你需要在该方法中实现一个 VideoFrameObserver 类，并根据场景需要，注册该类的回调。 成功注册视频观测器后，SDK 会在捕捉到每个视频帧时，触发你所注册的上述回调。在处理回调时，你需要考虑视频帧中 width 和 height 参数的变化，因为观测得到的视频帧可能会随以下情况变化： 当网络状况差时，分辨率会阶梯式下降。当用户自行调整分辨率时，回调中报告的分辨率也会变化。该方法需要在加入频道前调用。
  ///
  /// * [observer] 接口对象实例。详见 VideoFrameObserver 。
  void registerVideoFrameObserver(VideoFrameObserver observer);

  /// 为编码后的视频图像注册视频帧接收观测器。
  /// 请在加入频道后调用该方法。如果你调用该方法注册了 VideoEncodedFrameObserver 对象，则不能再注册 VideoFrameObserver 对象。
  ///
  /// * [observer] 视频帧接收观测器，详见 VideoEncodedFrameObserver 。
  void registerVideoEncodedFrameObserver(VideoEncodedFrameObserver observer);

  /// 推送外部音频帧。
  ///
  ///
  /// * [type] 音频采集设备类型。详见 MediaSourceType 。
  /// * [frame] 外部音频帧。详见 AudioFrame 。
  /// * [wrap] 设置是否占位使用。Agora 建议用户使用默认值。 true: 占位使用；false:（默认）不占位使用。
  /// * [sourceId] 外部音频源的 ID。如果你要发布自定义的外部音频源，则将该参数设置为你想要发布的自定义音频轨道 ID。
  Future<void> pushAudioFrame(
      {required MediaSourceType type,
      required AudioFrame frame,
      bool wrap = false,
      int sourceId = 0});

  /// @nodoc
  Future<void> pushCaptureAudioFrame(AudioFrame frame);

  /// @nodoc
  Future<void> pushReverseAudioFrame(AudioFrame frame);

  /// @nodoc
  Future<void> pushDirectAudioFrame(AudioFrame frame);

  /// 拉取远端音频数据。
  /// 使用该方法前，你需要调用 setExternalAudioSink 通知 app 开启并设置外部渲染。调用该方法后，app 会采取主动拉取的方式获取远端已解码和混音后的音频数据，用于音频播放。该方法仅支持拉取自采集的数据。如果你需要拉取 SDK 采集的数据，请不要调用该方法。该方法需要在加入频道后调用。开启外部音频渲染后，app 将无法从 onPlaybackAudioFrame 回调中获得数据。该方法和 onPlaybackAudioFrame 回调相比，区别在于： SDK 通过 onPlaybackAudioFrame 回调将音频数据传输给 app。如果 app 处理延时，可能会导致音频播放抖动。调用该方法后 app 会主动拉取音频数据。通过设置音频数据，SDK 可以调整缓存，帮助 app 处理延时，从而有效避免音频播放抖动。
  Future<void> pullAudioFrame(AudioFrame frame);

  /// 设置外部视频源。
  /// 请在加入频道前调用该方法。
  ///
  /// * [enabled] 是否启用外部视频源：
  ///  true: 启用外部视频源。SDK 准备接收外部视频帧。false:（默认）不启用外部视频源。
  /// * [useTexture] 是否使用 texture 格式的外部视频帧：
  ///  true: 使用 texture 格式的外部视频帧。false: 不使用 texture 格式的外部视频帧。
  /// * [sourceType] 是否对外部视频帧编码，详见 ExternalVideoSourceType 。
  /// * [encodedVideoOption] 视频编码选项。如果 sourceType 为 encodedVideoFrame，则需要设置该参数。你可以了解如何设置该参数。
  Future<void> setExternalVideoSource(
      {required bool enabled,
      required bool useTexture,
      ExternalVideoSourceType sourceType = ExternalVideoSourceType.videoFrame,

      /// @nodoc
      SenderOptions encodedVideoOption = const SenderOptions()});

  /// 设置外部音频采集参数。
  /// 请在加入频道前调用该方法。
  ///
  /// * [enabled] 是否开启使用外部音频源的功能： true：开启外部音频源。false：（默认）关闭外部音频源。
  /// * [sampleRate] 外部音频源的采样率 (Hz)，可设置为 8000，16000，32000，44100 或 48000。
  /// * [channels] 外部音频源的声道数，可设置为 1（单声道）或 2（双声道）。
  /// * [sourceNumber] 外部音频源的数量，取值为正整数。SDK 会根据该参数值创建对应数量的自采集音频轨道，并从 0 开始为音频轨道命名。你可以在 ChannelMediaOptions 中，设置 publishCustomAudioSourceId 为你想要发布的音频轨道 ID。
  /// * [localPlayback] 是否在本地播放外部音频源： true：在本地播放。false：（默认）不在本地播放。
  /// * [publish] 是否将音频发布到远端： true：（默认）发布到远端。false：不发布到远端。
  Future<void> setExternalAudioSource(
      {required bool enabled,
      required int sampleRate,
      required int channels,
      int sourceNumber = 1,
      bool localPlayback = false,
      bool publish = true});

  /// 设置外部音频渲染。
  /// 该方法适用于需要自行渲染音频的场景。开启外部音频渲染后，你可以调用 pullAudioFrame 拉取远端音频数据。App 可以对拉取到的原始音频数据进行处理后再渲染，获取想要的音频效果。
  ///
  /// * [enabled] 设置是否开启外部音频渲染：
  ///  true：开启外部音频渲染。false：（默认）关闭外部音频渲染。
  /// * [sampleRate] 外部音频渲染的采样率 (Hz)，可设置为 16000，32000，44100 或 48000。
  /// * [channels] 外部音频渲染的声道数，可设置为 1 或 2:
  ///  1: 单声道2: 双声道
  Future<void> setExternalAudioSink(
      {required bool enabled, required int sampleRate, required int channels});

  /// @nodoc
  Future<void> enableCustomAudioLocalPlayback(
      {required int sourceId, required bool enabled});

  /// @nodoc
  Future<void> setDirectExternalAudioSource(
      {required bool enable, bool localPlayback = false});

  /// 推送外部原始视频帧到 SDK。
  /// 调用 createCustomVideoTrack 方法获得视频轨道 ID，在每个频道的 ChannelMediaOptions 中，将 customVideoTrackId 参数设置为你想要发布的视频轨道 ID，并将 publishCustomVideoTrack 设置为 true后，你可以调用本方法将未编码的外部视频帧推送到 SDK。
  ///
  /// * [frame] 待推送的视频帧。详见 ExternalVideoFrame 。
  /// * [videoTrackId] 调用 createCustomVideoTrack 方法返回的视频轨道 ID。默认值为 0。
  Future<void> pushVideoFrame(
      {required ExternalVideoFrame frame, int videoTrackId = 0});

  /// @nodoc
  Future<void> pushEncodedVideoImage(
      {required Uint8List imageBuffer,
      required int length,
      required EncodedVideoFrameInfo videoEncodedFrameInfo,
      int videoTrackId = 0});

  /// @nodoc
  Future<void> release();

  /// 取消注册音频帧观测器。
  ///
  ///
  /// * [observer] 音频帧观测器，观测每帧音频的接收，详见 AudioFrameObserver 。
  void unregisterAudioFrameObserver(AudioFrameObserver observer);

  /// 取消注册视频帧观测器。
  ///
  ///
  /// * [observer] 视频帧观测器，观测每帧视频的接收, 详见 VideoFrameObserver 。
  void unregisterVideoFrameObserver(VideoFrameObserver observer);

  /// 为编码后的视频图像取消注册视频帧接收观测器。
  ///
  ///
  /// * [observer] 视频帧观测器，观测每帧视频的接收, 详见 VideoEncodedFrameObserver 。
  void unregisterVideoEncodedFrameObserver(VideoEncodedFrameObserver observer);
}
