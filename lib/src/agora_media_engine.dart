import 'package:agora_rtc_engine/src/binding_forward_export.dart';
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
  /// Call this method to register an audio frame observer object (register a callback). When you need the SDK to trigger onMixedAudioFrame , onRecordAudioFrame , onPlaybackAudioFrame or onEarMonitoringAudioFrame callback, you need to use this method to register the callbacks.Ensure that you call this method before joining a channel.
  ///
  /// * [observer] The observer object instance. See AudioFrameObserver . Agora recommends calling this method after receiving onLeaveChannel to release the audio observer object.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; you need to catch the exception and handle it accordingly.
  void registerAudioFrameObserver(AudioFrameObserver observer);

  /// Registers a raw video frame observer object.
  /// If you want to obtain the original video data of some remote users (referred to as group A) and the encoded video data of other remote users (referred to as group B), you can refer to the following steps:
  ///  Call registerVideoFrameObserver to register the raw video frame observer before joining the channel.
  ///  Call registerVideoEncodedFrameObserver to register the encoded video frame observer before joining the channel.
  ///  After joining the channel, get the user IDs of group B users through onUserJoined , and then call setRemoteVideoSubscriptionOptions to set the encodedFrameOnly of this group of users to true.
  ///  Call muteAllRemoteVideoStreams (false) to start receiving the video streams of all remote users. Then:
  ///  The raw video data of group A users can be obtained through the callback in VideoFrameObserver , and the SDK renders the data by default.
  ///  The encoded video data of group B users can be obtained through the callback in VideoEncodedFrameObserver . If you want to observe raw video frames (such as YUV or RGBA format), Agora recommends that you implement one VideoFrameObserver class with this method.When calling this method to register a video observer, you can register callbacks in the VideoFrameObserver class as needed. After you successfully register the video frame observer, the SDK triggers the registered callbacks each time a video frame is received.Ensure that you call this method before joining a channel.When handling the video data returned in the callbacks, pay attention to the changes in the width and height parameters, which may be adapted under the following circumstances:When network conditions deteriorate, the video resolution decreases incrementally.If the user adjusts the video profile, the resolution of the video returned in the callbacks also changes.After registering the raw video observer, you can use the obtained raw video data in various video pre-processing scenarios, such as implementing virtual backgrounds and image enhacement scenarios by yourself, Agora provides some open source sample projects on GitHub for your reference.
  ///
  /// * [observer] The observer object instance. See VideoFrameObserver .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; you need to catch the exception and handle it accordingly.< 0: Failure.
  void registerVideoFrameObserver(VideoFrameObserver observer);

  /// Registers a receiver object for the encoded video image.
  /// If you only want to observe encoded video frames (such as h.264 format) without decoding and rendering the video, Agora recommends that you implement one VideoEncodedFrameObserver class through this method.If you want to obtain the original video data of some remote users (referred to as group A) and the encoded video data of other remote users (referred to as group B), you can refer to the following steps:Call registerVideoFrameObserver to register the raw video frame observer before joining the channel.Call registerVideoEncodedFrameObserver to register the encoded video frame observer before joining the channel.After joining the channel, get the user IDs of group B users through onUserJoined , and then call setRemoteVideoSubscriptionOptions to set the encodedFrameOnly of this group of users to true.Call muteAllRemoteVideoStreams (false) to start receiving the video streams of all remote users. Then:The raw video data of group A users can be obtained through the callback in VideoFrameObserver , and the SDK renders the data by default.The encoded video data of group B users can be obtained through the callback in VideoEncodedFrameObserver .Call this method before joining a channel.
  ///
  /// * [observer] The video frame observer object. See VideoEncodedFrameObserver .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; you need to catch the exception and handle it accordingly.
  void registerVideoEncodedFrameObserver(VideoEncodedFrameObserver observer);

  /// Pushes the external audio frame.
  ///
  /// * [type] The type of the audio recording device. See MediaSourceType .
  /// * [frame] The external audio frame. See AudioFrame .
  /// * [wrap] Whether to use the placeholder. Agora recommends using the default value.true: Use the placeholder.false: (Default) Do not use the placeholder.
  /// * [sourceId] The ID of external audio source. If you want to publish a custom external audio source, set this parameter to the ID of the corresponding custom audio track you want to publish.
  Future<void> pushAudioFrame({required AudioFrame frame, int trackId = 0});

  /// Pulls the remote audio data.
  /// Before calling this method, you need to call setExternalAudioSink to notify the app to enable and set the external rendering.After a successful method call, the app pulls the decoded and mixed audio data for playback.This method only supports pulling data from custom audio source. If you need to pull the data captured by the SDK, do not call this method.Call this method after joining a channel.Once you enable the external audio sink, the app will not retrieve any audio data from the onPlaybackAudioFrame callback.The difference between this method and the onPlaybackAudioFrame callback is as follows:The SDK sends the audio data to the app through the onPlaybackAudioFrame callback. Any delay in processing the audio frames may result in audio jitter.After a successful method call, the app automatically pulls the audio data from the SDK. After setting the audio data parameters, the SDK adjusts the frame buffer and avoids problems caused by jitter in the external audio playback.
  ///
  /// * [frame] Pointers to AudioFrame .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; you need to catch the exception and handle it accordingly.
  Future<void> pullAudioFrame(AudioFrame frame);

  /// Configures the external video source.
  /// Call this method before joining a channel.
  ///
  /// * [enabled] Whether to use the external video source:true: Use the external video source. The SDK prepares to accept the external video frame.false: (Default) Do not use the external video source.
  /// * [useTexture] Whether to use the external video frame in the Texture format.true: Use the external video frame in the Texture format.false: (Default) Do not use the external video frame in the Texture format.
  /// * [sourceType] Whether the external video frame is encoded. See ExternalVideoSourceType .
  /// * [encodedVideoOption] Video encoding options. This parameter needs to be set if sourceType is encodedVideoFrame. To set this parameter, contact .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; you need to catch the exception and handle it accordingly.< 0: Failure.
  Future<void> setExternalVideoSource(
      {required bool enabled,
      required bool useTexture,
      ExternalVideoSourceType sourceType = ExternalVideoSourceType.videoFrame,

      /// @nodoc
      SenderOptions encodedVideoOption = const SenderOptions()});

  /// Sets the external audio source parameters.
  /// Call this method before joining a channel.
  ///
  /// * [enabled] Whether to enable the external audio source:true: Enable the external audio source.false: (Default) Disable the external audio source.
  /// * [sampleRate] The sample rate (Hz) of the external audio which can be set as 8000, 16000, 32000, 44100, or 48000.
  /// * [channels] The number of channels of the external audio source, which can be set as 1 (Mono) or 2 (Stereo).
  /// * [sourceNumber] The number of external audio sources. The value of this parameter should be larger than 0. The SDK creates a corresponding number of custom audio tracks based on this parameter value and names the audio tracks starting from 0. In ChannelMediaOptions , you can set publishCustomAudioSourceId to the audio track ID you want to publish.
  /// * [localPlayback] Whether to play the external audio source:true: Play the external audio source.false: (Default) Do not play the external source.
  /// * [publish] Whether to publish audio to the remote users:true: (Default) Publish audio to the remote users.false: Do not publish audio to the remote users.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; you need to catch the exception and handle it accordingly.< 0: Failure.
  Future<void> setExternalAudioSource(
      {required bool enabled,
      required int sampleRate,
      required int channels,
      bool localPlayback = false,
      bool publish = true});

  /// @nodoc
  Future<int> createCustomAudioTrack(
      {required AudioTrackType trackType, required AudioTrackConfig config});

  /// @nodoc
  Future<void> destroyCustomAudioTrack(int trackId);

  /// Sets the external audio sink.
  /// This method applies to scenarios where you want to use external audio data for playback. After you set the external audio sink, you can call pullAudioFrame to pull remote audio frames. The app can process the remote audio and play it with the audio effects that you want.
  ///
  /// * [enabled] Whether to enable or disable the external audio sink:true: Enables the external audio sink.false: (Default) Disables the external audio sink.
  /// * [sampleRate] The sample rate (Hz) of the external audio sink, which can be set as 16000, 32000, 44100, or 48000.
  /// * [channels] The number of audio channels of the external audio sink:1: Mono.2: Stereo.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; you need to catch the exception and handle it accordingly.< 0: Failure.
  Future<void> setExternalAudioSink(
      {required bool enabled, required int sampleRate, required int channels});

  /// @nodoc
  Future<void> enableCustomAudioLocalPlayback(
      {required int trackId, required bool enabled});

  /// Pushes the external raw video frame to the SDK.
  /// If you call createCustomVideoTrack method to get the video track ID, set the customVideoTrackId parameter to the video track ID you want to publish in the ChannelMediaOptions of each channel, and set the publishCustomVideoTrack parameter to true, you can call this method to push the unencoded external video frame to the SDK.
  ///
  /// * [frame] The external raw video frame to be pushed. See ExternalVideoFrame .
  /// * [videoTrackId] The video track ID returned by calling the createCustomVideoTrack method. The default value is 0.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; you need to catch the exception and handle it accordingly.
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
  /// * [observer] The audio frame observer, reporting the reception of each audio frame. See AudioFrameObserver .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; you need to catch the exception and handle it accordingly.< 0: Failure.
  void unregisterAudioFrameObserver(AudioFrameObserver observer);

  /// Unregisters the video frame observer.
  ///
  /// * [observer] The video observer, reporting the reception of each video frame. See VideoFrameObserver .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; you need to catch the exception and handle it accordingly.
  void unregisterVideoFrameObserver(VideoFrameObserver observer);

  /// Unregisters a receiver object for the encoded video image.
  ///
  /// * [observer] The video observer, reporting the reception of each video frame. See VideoEncodedFrameObserver .
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown; you need to catch the exception and handle it accordingly.
  void unregisterVideoEncodedFrameObserver(VideoEncodedFrameObserver observer);
}
