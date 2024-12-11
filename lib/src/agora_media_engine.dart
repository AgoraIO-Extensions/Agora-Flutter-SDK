import '/src/binding_forward_export.dart';
part 'agora_media_engine.g.dart';

/// The channel mode.
@JsonEnum(alwaysCreate: true)
enum AudioMixingDualMonoMode {
  /// 0: Original mode.
  @JsonValue(0)
  audioMixingDualMonoAuto,

  /// 1: Left channel mode. This mode replaces the audio of the right channel with the audio of the left channel, which means the user can only hear the audio of the left channel.
  @JsonValue(1)
  audioMixingDualMonoL,

  /// 2: Right channel mode. This mode replaces the audio of the left channel with the audio of the right channel, which means the user can only hear the audio of the right channel.
  @JsonValue(2)
  audioMixingDualMonoR,

  /// 3: Mixed channel mode. This mode mixes the audio of the left channel and the right channel, which means the user can hear the audio of the left channel and the right channel at the same time.
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

/// The MediaEngine class.
abstract class MediaEngine {
  /// Registers an audio frame observer object.
  ///
  /// Call this method to register an audio frame observer object (register a callback). When you need the SDK to trigger the onMixedAudioFrame, onRecordAudioFrame, onPlaybackAudioFrame, onPlaybackAudioFrameBeforeMixing or onEarMonitoringAudioFrame callback, you need to use this method to register the callbacks.
  ///
  /// * [observer] The observer instance. See AudioFrameObserver. Agora recommends calling this method after receiving onLeaveChannel to release the audio observer object.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  void registerAudioFrameObserver(AudioFrameObserver observer);

  /// Registers a raw video frame observer object.
  ///
  /// If you want to observe raw video frames (such as YUV or RGBA format), Agora recommends that you implement one VideoFrameObserver class with this method. When calling this method to register a video observer, you can register callbacks in the VideoFrameObserver class as needed. After you successfully register the video frame observer, the SDK triggers the registered callbacks each time a video frame is received.
  ///
  /// * [observer] The observer instance. See VideoFrameObserver.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: Failure.
  void registerVideoFrameObserver(VideoFrameObserver observer);

  /// Registers a receiver object for the encoded video image.
  ///
  /// If you only want to observe encoded video frames (such as H.264 format) without decoding and rendering the video, Agora recommends that you implement one VideoEncodedFrameObserver class through this method. Call this method before joining a channel.
  ///
  /// * [observer] The video frame observer object. See VideoEncodedFrameObserver.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  void registerVideoEncodedFrameObserver(VideoEncodedFrameObserver observer);

  /// Registers a facial information observer.
  ///
  /// You can call this method to register the onFaceInfo callback to receive the facial information processed by Agora speech driven extension. When calling this method to register a facial information observer, you can register callbacks in the FaceInfoObserver class as needed. After successfully registering the facial information observer, the SDK triggers the callback you have registered when it captures the facial information converted by the speech driven extension.
  ///  Call this method before joining a channel.
  ///  Before calling this method, you need to make sure that the speech driven extension has been enabled by calling enableExtension.
  ///
  /// * [observer] Facial information observer, see FaceInfoObserver.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  void registerFaceInfoObserver(FaceInfoObserver observer);

  /// Pushes the external audio frame.
  ///
  /// Call this method to push external audio frames through the audio track.
  ///
  /// * [frame] The external audio frame. See AudioFrame.
  /// * [trackId] The audio track ID. If you want to publish a custom external audio source, set this parameter to the ID of the corresponding custom audio track you want to publish.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> pushAudioFrame({required AudioFrame frame, int trackId = 0});

  /// Pulls the remote audio data.
  ///
  /// After a successful call of this method, the app pulls the decoded and mixed audio data for playback.
  ///
  /// * [frame] Pointers to AudioFrame.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> pullAudioFrame(AudioFrame frame);

  /// Configures the external video source.
  ///
  /// After calling this method to enable an external video source, you can call pushVideoFrame to push external video data to the SDK.
  ///
  /// * [enabled] Whether to use the external video source: true : Use the external video source. The SDK prepares to accept the external video frame. false : (Default) Do not use the external video source.
  /// * [useTexture] Whether to use the external video frame in the Texture format. true : Use the external video frame in the Texture format. false : (Default) Do not use the external video frame in the Texture format.
  /// * [sourceType] Whether the external video frame is encoded. See ExternalVideoSourceType.
  /// * [encodedVideoOption] Video encoding options. This parameter needs to be set if sourceType is encodedVideoFrame. To set this parameter, contact.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setExternalVideoSource(
      {required bool enabled,
      required bool useTexture,
      ExternalVideoSourceType sourceType = ExternalVideoSourceType.videoFrame,
      SenderOptions encodedVideoOption = const SenderOptions()});

  /// @nodoc
  Future<void> setExternalRemoteEglContext(int eglContext);

  /// Sets the external audio source parameters.
  ///
  /// Deprecated: This method is deprecated, use createCustomAudioTrack instead.
  ///
  /// * [enabled] Whether to enable the external audio source: true : Enable the external audio source. false : (Default) Disable the external audio source.
  /// * [sampleRate] The sample rate (Hz) of the external audio source which can be set as 8000, 16000, 32000, 44100, or 48000.
  /// * [channels] The number of channels of the external audio source, which can be set as 1 (Mono) or 2 (Stereo).
  /// * [localPlayback] Whether to play the external audio source: true : Play the external audio source. false : (Default) Do not play the external source.
  /// * [publish] Whether to publish audio to the remote users: true : (Default) Publish audio to the remote users. false : Do not publish audio to the remote users.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: Failure.
  Future<void> setExternalAudioSource(
      {required bool enabled,
      required int sampleRate,
      required int channels,
      bool localPlayback = false,
      bool publish = true});

  /// Creates a custom audio track.
  ///
  /// Call this method before joining a channel. To publish a custom audio source, see the following steps:
  ///  Call this method to create a custom audio track and get the audio track ID.
  ///  Call joinChannel to join the channel. In ChannelMediaOptions, set publishCustomAudioTrackId to the audio track ID that you want to publish, and set publishCustomAudioTrack to true.
  ///  Call pushAudioFrame and specify trackId as the audio track ID set in step 2. You can then publish the corresponding custom audio source in the channel.
  ///
  /// * [trackType] The type of the custom audio track. See AudioTrackType. If audioTrackDirect is specified for this parameter, you must set publishMicrophoneTrack to false in ChannelMediaOptions when calling joinChannel to join the channel; otherwise, joining the channel fails and returns the error code -2.
  /// * [config] The configuration of the custom audio track. See AudioTrackConfig.
  ///
  /// Returns
  /// If the method call is successful, the audio track ID is returned as the unique identifier of the audio track.
  ///  If the method call fails, 0xffffffff is returned.
  Future<int> createCustomAudioTrack(
      {required AudioTrackType trackType, required AudioTrackConfig config});

  /// Destroys the specified audio track.
  ///
  /// * [trackId] The custom audio track ID returned in createCustomAudioTrack.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> destroyCustomAudioTrack(int trackId);

  /// Sets the external audio sink.
  ///
  /// After enabling the external audio sink, you can call pullAudioFrame to pull remote audio frames. The app can process the remote audio and play it with the audio effects that you want.
  ///
  /// * [enabled] Whether to enable or disable the external audio sink: true : Enables the external audio sink. false : (Default) Disables the external audio sink.
  /// * [sampleRate] The sample rate (Hz) of the external audio sink, which can be set as 16000, 32000, 44100, or 48000.
  /// * [channels] The number of audio channels of the external audio sink:
  ///  1: Mono.
  ///  2: Stereo.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setExternalAudioSink(
      {required bool enabled, required int sampleRate, required int channels});

  /// @nodoc
  Future<void> enableCustomAudioLocalPlayback(
      {required int trackId, required bool enabled});

  /// Pushes the external raw video frame to the SDK through video tracks.
  ///
  /// To publish a custom video source, see the following steps:
  ///  Call createCustomVideoTrack to create a video track and get the video track ID.
  ///  Call joinChannel to join the channel. In ChannelMediaOptions, set customVideoTrackId to the video track ID that you want to publish, and set publishCustomVideoTrack to true.
  ///  Call this method and specify videoTrackId as the video track ID set in step 2. You can then publish the corresponding custom video source in the channel. After calling this method, even if you stop pushing external video frames to the SDK, the custom video stream will still be counted as the video duration usage and incur charges. Agora recommends that you take appropriate measures based on the actual situation to avoid such video billing.
  ///  If you no longer need to capture external video data, you can call destroyCustomVideoTrack to destroy the custom video track.
  ///  If you only want to use the external video data for local preview and not publish it in the channel, you can call muteLocalVideoStream to cancel sending video stream or call updateChannelMediaOptions to set publishCustomVideoTrack to false.
  ///
  /// * [frame] The external raw video frame to be pushed. See ExternalVideoFrame.
  /// * [videoTrackId] The video track ID returned by calling the createCustomVideoTrack method. The default value is 0.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
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

  /// Unregisters an audio frame observer.
  ///
  /// * [observer] The audio frame observer, reporting the reception of each audio frame. See AudioFrameObserver.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  void unregisterAudioFrameObserver(AudioFrameObserver observer);

  /// Unregisters the video frame observer.
  ///
  /// * [observer] The video observer, reporting the reception of each video frame. See VideoFrameObserver.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  void unregisterVideoFrameObserver(VideoFrameObserver observer);

  /// Unregisters a receiver object for the encoded video frame.
  ///
  /// * [observer] The video observer, reporting the reception of each video frame. See VideoEncodedFrameObserver.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  void unregisterVideoEncodedFrameObserver(VideoEncodedFrameObserver observer);

  /// Unregisters a facial information observer.
  ///
  /// * [observer] Facial information observer, see FaceInfoObserver.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  void unregisterFaceInfoObserver(FaceInfoObserver observer);
}
