import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_media_engine.g.dart';

@JsonEnum(alwaysCreate: true)
enum AudioMixingDualMonoMode {
  @JsonValue(0)
  audioMixingDualMonoAuto,

  @JsonValue(1)
  audioMixingDualMonoL,

  @JsonValue(2)
  audioMixingDualMonoR,

  @JsonValue(3)
  audioMixingDualMonoMix,
}

/// Extensions functions of [AudioMixingDualMonoMode].
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

abstract class MediaEngine {
  void registerAudioFrameObserver(AudioFrameObserver observer);

  void registerVideoFrameObserver(VideoFrameObserver observer);

  void registerVideoEncodedFrameObserver(VideoEncodedFrameObserver observer);

  Future<void> pushAudioFrame(
      {required MediaSourceType type,
      required AudioFrame frame,
      bool wrap = false,
      int sourceId = 0});

  Future<void> pushCaptureAudioFrame(AudioFrame frame);

  Future<void> pushReverseAudioFrame(AudioFrame frame);

  Future<void> pushDirectAudioFrame(AudioFrame frame);

  Future<void> pullAudioFrame(AudioFrame frame);

  Future<void> setExternalVideoSource(
      {required bool enabled,
      required bool useTexture,
      ExternalVideoSourceType sourceType = ExternalVideoSourceType.videoFrame,
      SenderOptions encodedVideoOption = const SenderOptions()});

  Future<void> setExternalAudioSource(
      {required bool enabled,
      required int sampleRate,
      required int channels,
      int sourceNumber = 1,
      bool localPlayback = false,
      bool publish = true});

  Future<void> setExternalAudioSink(
      {required bool enabled, required int sampleRate, required int channels});

  Future<void> enableCustomAudioLocalPlayback(
      {required int sourceId, required bool enabled});

  Future<void> setDirectExternalAudioSource(
      {required bool enable, bool localPlayback = false});

  Future<void> pushVideoFrame(
      {required ExternalVideoFrame frame, int videoTrackId = 0});

  Future<void> pushEncodedVideoImage(
      {required Uint8List imageBuffer,
      required int length,
      required EncodedVideoFrameInfo videoEncodedFrameInfo,
      int videoTrackId = 0});

  Future<void> release();

  void unregisterAudioFrameObserver(AudioFrameObserver observer);

  void unregisterVideoFrameObserver(VideoFrameObserver observer);

  void unregisterVideoEncodedFrameObserver(VideoEncodedFrameObserver observer);
}
