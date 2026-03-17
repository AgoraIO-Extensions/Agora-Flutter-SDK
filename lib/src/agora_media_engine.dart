import 'package:agora_rtc_engine/src/_serializable.dart';
import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_media_engine.g.dart';

/// Channel mode.
@JsonEnum(alwaysCreate: true)
enum AudioMixingDualMonoMode {
  /// 0: Original mode.
  @JsonValue(0)
  audioMixingDualMonoAuto,

  /// 1: Left channel mode. This mode replaces the right channel audio with the left channel audio, so the user can only hear the left channel.
  @JsonValue(1)
  audioMixingDualMonoL,

  /// 2: Right channel mode. This mode replaces the left channel audio with the right channel audio, so the user can only hear the right channel.
  @JsonValue(2)
  audioMixingDualMonoR,

  /// 3: Mixed mode. This mode overlays the left and right channel data, so the user can hear both channels simultaneously.
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

/// MediaEngine class.
abstract class MediaEngine {
  /// Registers an audio observer object.
  ///
  /// This method registers an audio observer object, i.e., registers callbacks. When you need the SDK to trigger onMixedAudioFrame, onRecordAudioFrame, onPlaybackAudioFrame, onPlaybackAudioFrameBeforeMixing, and onEarMonitoringAudioFrame callbacks, you need to call this method to register the callbacks.
  ///
  /// * [observer] Instance of the interface object. See AudioFrameObserver. It is recommended to call this after receiving onLeaveChannel to release the audio observer object.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  void registerAudioFrameObserver(AudioFrameObserver observer);

  /// Registers a raw video frame observer object.
  ///
  /// If you want to observe raw video frames (such as YUV or RGBA format), Agora recommends that you register a VideoFrameObserver class using this method.
  /// When registering a video frame observer using this method, you can register callbacks in the VideoFrameObserver class as needed. After successful registration, the SDK triggers the registered callbacks each time a video frame is captured. When handling the callback, you need to consider changes in the width and height parameters of the video frame, as the observed video frames may vary due to the following situations:
  ///  When the network condition is poor, the resolution will drop step by step.
  ///  When the user manually adjusts the resolution, the resolution reported in the callback will also change.
  ///
  /// * [observer] Instance of the interface object. See VideoFrameObserver.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Method call failed. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  void registerVideoFrameObserver(VideoFrameObserver observer);

  /// Registers a video frame observer for encoded video images.
  ///
  /// If you only want to observe encoded video frames (such as H.264 format) without decoding and rendering, Agora recommends that you register a VideoEncodedFrameObserver class using this method. This method must be called before joining a channel.
  ///
  /// * [observer] Video frame observer. See VideoEncodedFrameObserver.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  void registerVideoEncodedFrameObserver(VideoEncodedFrameObserver observer);

  /// Registers a face information observer.
  ///
  /// You can call this method to register the onFaceInfo callback to obtain the face information processed by the Agora voice driver plugin. When registering the face information observer using this method, you can register callbacks in the FaceInfoObserver class as needed. After successfully registering the face information observer, the SDK triggers the registered callback when it captures face information converted by the voice driver plugin.
  ///  You must call this method before joining a channel.
  ///  Before calling this method, make sure you have called enableExtension to enable the voice driver plugin.
  ///
  /// * [observer] Face information observer. See FaceInfoObserver.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  void registerFaceInfoObserver(FaceInfoObserver observer);

  /// Pushes external audio frames.
  ///
  /// Call this method to push external audio frames through an audio track.
  ///
  /// * [frame] External audio frame. See AudioFrame.
  /// * [trackId] Audio track ID. If you want to publish a custom external audio source, set this parameter to the custom audio track ID you want to publish.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> pushAudioFrame({required AudioFrame frame, int trackId = 0});

  /// Pulls remote audio data.
  ///
  /// After calling this method, the app actively pulls the decoded and mixed remote audio data for playback. This method and the onPlaybackAudioFrame callback can both be used to get the mixed remote audio playback data. After calling setExternalAudioSink to enable external audio rendering, the app can no longer get data from the onPlaybackAudioFrame callback. Therefore, choose between this method and the onPlaybackAudioFrame callback based on your actual business needs. The processing mechanisms differ, with the following distinctions:
  ///  After calling this method, the app actively pulls the audio data. By setting the audio data, the SDK can adjust the buffer to help the app handle latency and effectively avoid audio playback jitter.
  ///  After registering the onPlaybackAudioFrame callback, the SDK pushes the audio data to the app through the callback. When handling audio frame latency, the app may cause audio playback jitter. This method is only used to pull the mixed remote audio playback data. To obtain the captured raw audio data or the raw audio playback data of each stream before mixing, you can register the corresponding callback by calling registerAudioFrameObserver.
  ///
  /// * [frame] Pointer to AudioFrame.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> pullAudioFrame(AudioFrame frame);

  /// Sets the external video source.
  ///
  /// After calling this method to enable the external video source, you can call pushVideoFrame to push external video data to the SDK. Switching video sources dynamically within a channel is not supported. If you have already called this method to enable an external video source and joined a channel, to switch to an internal video source, you must first leave the channel, then call this method to disable the external video source, and rejoin the channel.
  ///
  /// * [enabled] Whether to enable the external video source: true : Enable the external video source. The SDK is ready to receive external video frames. false : (Default) Do not enable the external video source.
  /// * [useTexture] Whether to use external video frames in Texture format: true : Use Texture format for external video frames. false : Do not use Texture format for external video frames.
  /// * [sourceType] Whether the external video frame is encoded. See ExternalVideoSourceType.
  /// * [encodedVideoOption] Video encoding options. If sourceType is encodedVideoFrame, this parameter must be set. You can [contact technical support](https://ticket.shengwang.cn/) to learn how to configure this parameter.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setExternalVideoSource(
      {required bool enabled,
      required bool useTexture,
      ExternalVideoSourceType sourceType = ExternalVideoSourceType.videoFrame,
      SenderOptions encodedVideoOption = const SenderOptions()});

  /// @nodoc
  Future<void> setExternalRemoteEglContext(int eglContext);

  /// Sets the external audio source parameters.
  ///
  /// Deprecated Deprecated: This method is deprecated. Use createCustomAudioTrack instead.
  ///
  /// * [enabled] Whether to enable the external audio source: true : Enable the external audio source. false : (Default) Disable the external audio source.
  /// * [sampleRate] The sample rate (Hz) of the external audio source. You can set it to 8000, 16000, 32000, 44100, or 48000.
  /// * [channels] The number of channels of the external audio source. You can set it to 1 (mono) or 2 (stereo).
  /// * [localPlayback] Whether to play the external audio source locally: true : Play locally. false : (Default) Do not play locally.
  /// * [publish] Whether to publish the audio to the remote: true : (Default) Publish to the remote. false : Do not publish to the remote.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Failure. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setExternalAudioSource(
      {required bool enabled,
      required int sampleRate,
      required int channels,
      bool localPlayback = false,
      bool publish = true});

  /// Creates a custom audio track.
  ///
  /// To publish custom captured audio in a channel, follow these steps:
  ///  Call this method to create an audio track and get the audio track ID.
  ///  When calling joinChannel to join a channel, set publishCustomAudioTrackId in ChannelMediaOptions to the audio track ID you want to publish, and set publishCustomAudioTrack to true.
  ///  Call pushAudioFrame and set trackId to the audio track ID specified in step 2 to publish the corresponding custom audio source in the channel. This method must be called before joining a channel.
  ///
  /// * [trackType] Custom audio track type. See AudioTrackType. If audioTrackDirect is specified, you must set publishMicrophoneTrack to false in ChannelMediaOptions when calling joinChannel; otherwise, joining the channel will fail and return error code -2.
  /// * [config] Custom audio track configuration. See AudioTrackConfig.
  ///
  /// Returns
  /// If the method call succeeds, it returns the audio track ID as the unique identifier of the audio track.
  ///  If the method call fails, it returns 0xffffffff. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<int> createCustomAudioTrack(
      {required AudioTrackType trackType, required AudioTrackConfig config});

  /// Destroys the specified audio track.
  ///
  /// * [trackId] The custom audio track ID returned by the createCustomAudioTrack method.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> destroyCustomAudioTrack(int trackId);

  /// Sets external audio rendering.
  ///
  /// After calling this method to enable external audio rendering, you can call pullAudioFrame to pull remote audio data. The app can process the pulled raw audio data before rendering to achieve the desired audio effect. After calling this method to enable external audio rendering, the app can no longer get data from the onPlaybackAudioFrame callback.
  ///
  /// * [enabled] Whether to enable external audio rendering: true : Enable external audio rendering. false : (Default) Disable external audio rendering.
  /// * [sampleRate] The sample rate (Hz) for external audio rendering. You can set it to 16000, 32000, 44100, or 48000.
  /// * [channels] The number of channels for external audio rendering:
  ///  1: Mono
  ///  2: Stereo
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setExternalAudioSink(
      {required bool enabled, required int sampleRate, required int channels});

  /// @nodoc
  Future<void> enableCustomAudioLocalPlayback(
      {required int trackId, required bool enabled});

  /// Publishes external raw video frames to the channel through a custom video track.
  ///
  /// When you need to publish custom captured video in a channel, follow these steps:
  ///  Call the createCustomVideoTrack method to create a video track and get the video track ID.
  ///  When calling joinChannel to join a channel, set customVideoTrackId in ChannelMediaOptions to the video track ID you want to publish and set publishCustomVideoTrack to true.
  ///  Call this method and specify videoTrackId as the video track ID from step 2 to publish the corresponding custom video source in the channel. After calling this method, even if you stop pushing external video frames to the SDK, the custom captured video stream will still be counted in the video duration usage and incur charges. Agora recommends taking appropriate measures based on your actual situation to avoid such video billing:
  ///  If you no longer need to capture external video data, call destroyCustomVideoTrack to destroy the custom captured video track.
  ///  If you only want to use the captured external video data for local preview and not publish it in the channel, call muteLocalVideoStream to stop sending the video stream, or call updateChannelMediaOptions and set publishCustomVideoTrack to false.
  ///
  /// * [frame] The video frame to be pushed. See ExternalVideoFrame.
  /// * [videoTrackId] The video track ID returned by the createCustomVideoTrack method. If you only need to push one external video stream, set videoTrackId to 0.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
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

  /// Unregisters the audio frame observer.
  ///
  /// * [observer] The audio frame observer that monitors the reception of each audio frame. See AudioFrameObserver.
  ///
  /// Returns
  /// This method returns no value if the call succeeds. If the method call fails, it throws an AgoraRtcException, which you need to catch and handle. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and troubleshooting suggestions.
  void unregisterAudioFrameObserver(AudioFrameObserver observer);

  /// Unregisters the video frame observer.
  ///
  /// * [observer] Video frame observer that observes each received video frame. See VideoFrameObserver.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  void unregisterVideoFrameObserver(VideoFrameObserver observer);

  /// Unregisters the video frame observer for encoded video frames.
  ///
  /// * [observer] The video frame observer that observes each received video frame. See VideoEncodedFrameObserver.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  void unregisterVideoEncodedFrameObserver(VideoEncodedFrameObserver observer);

  /// Unregisters the face information observer.
  ///
  /// * [observer] Face information observer. See FaceInfoObserver.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  void unregisterFaceInfoObserver(FaceInfoObserver observer);
}
