import 'package:json_annotation/json_annotation.dart';

import 'enums.dart';

part 'classes.g.dart';

/// The user information, including the user ID and user account.
@JsonSerializable()
class UserInfo {
  /// The user ID of a user.
  int uid;

  /// The user account of a user.
  String userAccount;

  /// Constructs a [UserInfo]
  UserInfo();

  // ignore: public_member_api_docs
  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

/// The video resolution.
@JsonSerializable()
class VideoDimensions {
  /// The video resolution on the horizontal axis.
  final int width;

  /// The video resolution on the vertical axis.
  final int height;

  /// Constructs a [VideoDimensions]
  VideoDimensions(this.width, this.height);

  // ignore: public_member_api_docs
  factory VideoDimensions.fromJson(Map<String, dynamic> json) =>
      _$VideoDimensionsFromJson(json);

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$VideoDimensionsToJson(this);
}

/// Definition of VideoEncoderConfiguration.
@JsonSerializable()
class VideoEncoderConfiguration {
  /// The video frame dimensions (px), which is used to specify the video quality and measured by the total number of pixels along a frame's width and height. The default value is 640 × 360.
  @JsonKey(includeIfNull: false)
  VideoDimensions dimensions;

  /// The video frame rate (fps). The default value is 15. Users can either set the frame rate manually or choose from the following options. We do not recommend setting this to a value greater than 30.
  @JsonKey(includeIfNull: false)
  VideoFrameRate frameRate;

  /// The minimum video encoder frame rate (fps). The default value is Min(-1) (the SDK uses the lowest encoder frame rate).
  @JsonKey(includeIfNull: false)
  VideoFrameRate minFrameRate;

  /// Bitrate of the video (Kbps). Refer to the table below and set your bitrate. If you set a bitrate beyond the proper range, the SDK automatically adjusts it to a value within the range.
  @JsonKey(includeIfNull: false)
  int bitrate;

  /// The minimum encoding bitrate (Kbps). The Agora SDK automatically adjusts the encoding bitrate to adapt to the network conditions. Using a value greater than the default value forces the video encoder to output high-quality images but may cause more packet loss and hence sacrifice the smoothness of the video transmission. That said, unless you have special requirements for image quality, Agora does not recommend changing this value.
  @JsonKey(includeIfNull: false)
  int minBitrate;

  /// The orientation mode.
  @JsonKey(includeIfNull: false)
  VideoOutputOrientationMode orientationMode;

  /// The video encoding degradation preference under limited bandwidth.
  @JsonKey(includeIfNull: false)
  DegradationPreference degradationPrefer;

  /// Sets the mirror mode of the published local video stream.
  @JsonKey(includeIfNull: false)
  VideoMirrorMode mirrorMode;

  /// Constructs a [VideoEncoderConfiguration]
  VideoEncoderConfiguration(
      {this.dimensions,
      this.frameRate,
      this.minFrameRate,
      this.bitrate,
      this.minBitrate,
      this.orientationMode,
      this.degradationPrefer,
      this.mirrorMode});

  // ignore: public_member_api_docs
  factory VideoEncoderConfiguration.fromJson(Map<String, dynamic> json) =>
      _$VideoEncoderConfigurationFromJson(json);

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$VideoEncoderConfigurationToJson(this);
}

/// Sets the image enhancement options.
@JsonSerializable()
class BeautyOptions {
  /// The lightening contrast level.
  @JsonKey(includeIfNull: false)
  LighteningContrastLevel lighteningContrastLevel;

  /// The brightness level. The value ranges between 0.0 (original) and 1.0. The default value is 0.7.
  @JsonKey(includeIfNull: false)
  double lighteningLevel;

  /// The sharpness level. The value ranges between 0.0 (original) and 1.0. The default value is 0.5. This parameter is usually used to remove blemishes.
  @JsonKey(includeIfNull: false)
  double smoothnessLevel;

  /// The redness level. The value ranges between 0.0 (original) and 1.0. The default value is 0.1. This parameter adjusts the red saturation level.
  @JsonKey(includeIfNull: false)
  double rednessLevel;

  /// Constructs a [BeautyOptions]
  BeautyOptions(
      {this.lighteningContrastLevel,
      this.lighteningLevel,
      this.smoothnessLevel,
      this.rednessLevel});

  // ignore: public_member_api_docs
  factory BeautyOptions.fromJson(Map<String, dynamic> json) =>
      _$BeautyOptionsFromJson(json);

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$BeautyOptionsToJson(this);
}

/// Agora image properties. A class for setting the properties of the watermark and background images.
@JsonSerializable()
class AgoraImage {
  /// HTTP/HTTPS URL address of the image on the broadcasting video. The maximum length of this parameter is 1024 bytes.
  final String url;

  /// Position of the image on the upper left of the broadcasting video on the horizontal axis.
  final int x;

  /// Position of the image on the upper left of the broadcasting video on the vertical axis.
  final int y;

  /// Width of the image on the broadcasting video.
  final int width;

  /// Height of the image on the broadcasting video.
  final int height;

  /// Constructs a [AgoraImage]
  AgoraImage(this.url, this.x, this.y, this.width, this.height);

  // ignore: public_member_api_docs
  factory AgoraImage.fromJson(Map<String, dynamic> json) =>
      _$AgoraImageFromJson(json);

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$AgoraImageToJson(this);
}

/// The transcodingUser class, which defines the audio and video properties in the CDN live. Agora supports a maximum of 17 transcoding users in a CDN live streaming channel.
@JsonSerializable()
class TranscodingUser {
  /// ID of the user in the CDN live streaming.
  final int uid;

  /// Horizontal position of the video frame of the user from the top left corner of the CDN live streaming.
  final int x;

  /// Vertical position of the video frame of the user from the top left corner of the CDN live streaming.
  final int y;

  /// Width of the video frame of the user on the CDN live streaming. The default value is 360.
  int width;

  /// Height of the video frame of the user on the CDN live streaming. The default value is 640.
  int height;

  /// Layer position of video frame of the user on the CDN live streaming. The value ranges between 0 and 100. From v2.3.0, Agora SDK supports setting zOrder as 0. The smallest value is 0 (default value), which means that the video frame is at the bottom layer. The biggest value is 100, which means that the video frame is at the top layer.
  int zOrder;

  /// The transparency of the video frame of the user in the CDN live stream that ranges between 0.0 and 1.0. 0.0 means that the video frame is completely transparent and 1.0 means opaque. The default value is 1.0.
  @JsonKey(includeIfNull: false)
  double alpha;

  /// The audio channel ranging between 0 and 5. The default value is 0.
  AudioChannel audioChannel;

  /// Constructs a [TranscodingUser]
  TranscodingUser(
    this.uid,
    this.x,
    this.y, {
    this.width,
    this.height,
    this.zOrder,
    this.alpha,
    this.audioChannel,
  });

  // ignore: public_member_api_docs
  factory TranscodingUser.fromJson(Map<String, dynamic> json) =>
      _$TranscodingUserFromJson(json);

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$TranscodingUserToJson(this);
}

/// Color.
@JsonSerializable()
class Color {
  /// Red.
  final int red;

  /// Green.
  final int green;

  /// Blue.
  final int blue;

  /// Constructs a [Color]
  Color(this.red, this.green, this.blue);

  // ignore: public_member_api_docs
  factory Color.fromJson(Map<String, dynamic> json) => _$ColorFromJson(json);

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$ColorToJson(this);
}

/// A class for managing user-specific CDN live audio/video transcoding settings.
@JsonSerializable()
class LiveTranscoding {
  /// Width (pixel) of the video. The default value is 360. If you push video streams to the CDN, set the value of width × height to at least 64 × 64, or the SDK adjusts it to 64 x 64. If you push audio streams to the CDN, set the value of width × height to 0 × 0.
  @JsonKey(includeIfNull: false)
  int width;

  /// Height (pixel) of the video. The default value is 640. If you push video streams to the CDN, set the value of width × height to at least 64 × 64, or the SDK adjusts it to 64 x 64. If you push audio streams to the CDN, set the value of width × height to 0 × 0.
  @JsonKey(includeIfNull: false)
  int height;

  /// Bitrate (Kbps) of the CDN live output video stream. The default value is 400. Set this parameter according to the Video Bitrate Table. If you set a bitrate beyond the proper range, the SDK automatically adapts it to a value within the range.
  @JsonKey(includeIfNull: false)
  int videoBitrate;

  /// Frame rate (fps) of the CDN live output video stream. The value range is [0, 30]. The default value is 15. Agora adjusts all values over 30 to 30.
  @JsonKey(includeIfNull: false)
  VideoFrameRate videoFramerate;

  /// true: Low latency with unassured quality. false: (Default) High latency with assured quality.
  @deprecated
  @JsonKey(includeIfNull: false)
  bool lowLatency;

  /// Gop of the video frames in the CDN live stream. The default value is 30 fps.
  @JsonKey(includeIfNull: false)
  int videoGop;

  /// The watermark image added to the CDN live publishing stream. Ensure that the format of the image is PNG. Once a watermark image is added, the audience of the CDN live publishing stream can see it.
  @JsonKey(includeIfNull: false)
  AgoraImage watermark;

  /// The background image added to the CDN live publishing stream. Once a background image is added, the audience of the CDN live publishing stream can see it.
  @JsonKey(includeIfNull: false)
  AgoraImage backgroundImage;

  /// Self-defined audio-sample rate: AudioSampleRateType.
  @JsonKey(includeIfNull: false)
  AudioSampleRateType audioSampleRate;

  /// Bitrate (Kbps) of the CDN live audio output stream. The default value is 48 and the highest value is 128.
  @JsonKey(includeIfNull: false)
  int audioBitrate;

  /// Agora’s self-defined audio channel type. We recommend choosing 1 or 2. Special players are required if you choose 3, 4 or 5.
  @JsonKey(includeIfNull: false)
  int audioChannels;

  /// Audio codec profile type: AudioCodecProfileType. Set it as LC-AAC or HE-AAC. The default value is LC-AAC.
  @JsonKey(includeIfNull: false)
  AudioCodecProfileType audioCodecProfile;

  /// Video codec profile type: VideoCodecProfileType. Set it as BASELINE, MAIN, or HIGH (default). If you set this parameter to other values, Agora adjusts it to the default value HIGH.
  @JsonKey(includeIfNull: false)
  VideoCodecProfileType videoCodecProfile;

  /// Sets the background color.
  @JsonKey(includeIfNull: false)
  Color backgroundColor;

  /// Reserved property. Extra user-defined information to send the Supplemental Enhancement Information (SEI) for the H.264/H.265 video stream to the CDN live client. Maximum length: 4096 Bytes.
  @JsonKey(includeIfNull: false)
  String userConfigExtraInfo;

  /// An TranscodingUser object managing the user layout configuration in the CDN live stream. Agora supports a maximum of 17 transcoding users in a CDN live stream channel.
  final List<TranscodingUser> transcodingUsers;

  /// Constructs a [LiveTranscoding]
  LiveTranscoding(
    this.transcodingUsers, {
    this.width,
    this.height,
    this.videoBitrate,
    this.videoFramerate,
    this.lowLatency,
    this.videoGop,
    this.watermark,
    this.backgroundImage,
    this.audioSampleRate,
    this.audioBitrate,
    this.audioChannels,
    this.audioCodecProfile,
    this.videoCodecProfile,
    this.backgroundColor,
    this.userConfigExtraInfo,
  });

  // ignore: public_member_api_docs
  factory LiveTranscoding.fromJson(Map<String, dynamic> json) =>
      _$LiveTranscodingFromJson(json);

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$LiveTranscodingToJson(this);
}

/// The ChannelMediaInfo class.
@JsonSerializable()
class ChannelMediaInfo {
  /// The channel name.
  @JsonKey(includeIfNull: false)
  String channelName;

  /// The token that enables the user to join the channel.
  @JsonKey(includeIfNull: false)
  String token;

  /// The user ID.
  final int uid;

  /// Constructs a [ChannelMediaInfo]
  ChannelMediaInfo(this.uid, {this.channelName, this.token});

  // ignore: public_member_api_docs
  factory ChannelMediaInfo.fromJson(Map<String, dynamic> json) =>
      _$ChannelMediaInfoFromJson(json);

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$ChannelMediaInfoToJson(this);
}

/// The ChannelMediaRelayConfiguration class.
@JsonSerializable()
class ChannelMediaRelayConfiguration {
  /// Sets the information of the source channel.
  final ChannelMediaInfo srcInfo;

  /// Sets the information of the destination channel.
  final List<ChannelMediaInfo> destInfos;

  /// Constructs a [ChannelMediaRelayConfiguration]
  ChannelMediaRelayConfiguration(this.srcInfo, this.destInfos);

  // ignore: public_member_api_docs
  factory ChannelMediaRelayConfiguration.fromJson(Map<String, dynamic> json) =>
      _$ChannelMediaRelayConfigurationFromJson(json);

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$ChannelMediaRelayConfigurationToJson(this);
}

/// Lastmile probe configuration.
@JsonSerializable()
class LastmileProbeConfig {
  /// Whether to probe uplink of lastmile. i.e., audience don't need probe uplink bandwidth.
  final bool probeUplink;

  /// Whether to probe downlink of lastmile.
  final bool probeDownlink;

  /// The expected maximum sending bitrate in bps in range of [100000, 5000000]. It is recommended to set this value according to the required bitrate of selected video profile.
  final int expectedUplinkBitrate;

  /// The expected maximum receive bitrate in bps in range of [100000, 5000000].
  final int expectedDownlinkBitrate;

  /// Constructs a [LastmileProbeConfig]
  LastmileProbeConfig(this.probeUplink, this.probeDownlink,
      this.expectedUplinkBitrate, this.expectedDownlinkBitrate);

  // ignore: public_member_api_docs
  factory LastmileProbeConfig.fromJson(Map<String, dynamic> json) =>
      _$LastmileProbeConfigFromJson(json);

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$LastmileProbeConfigToJson(this);
}

/// The position and size of the watermark image.
@JsonSerializable()
class Rectangle {
  /// The horizontal offset from the top-left corner.
  final int x;

  /// The vertical offset from the top-left corner.
  final int y;

  /// The width (pixels) of the watermark image.
  final int width;

  /// The height (pixels) of the watermark image.
  final int height;

  /// Constructs a [Rectangle]
  Rectangle(this.x, this.y, this.width, this.height);

  // ignore: public_member_api_docs
  factory Rectangle.fromJson(Map<String, dynamic> json) =>
      _$RectangleFromJson(json);

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$RectangleToJson(this);
}

/// Agora watermark options. A class for setting the properties of watermark.
@JsonSerializable()
class WatermarkOptions {
  /// Sets whether or not the watermark image is visible in the local video preview: true: (Default) The watermark image is visible in preview. false: The watermark image is not visible in preview.
  @JsonKey(includeIfNull: false)
  bool visibleInPreview;

  /// The watermark position in the landscape mode.
  final Rectangle positionInLandscapeMode;

  /// The watermark position in the portrait mode.
  final Rectangle positionInPortraitMode;

  /// Constructs a [WatermarkOptions]
  WatermarkOptions(this.positionInLandscapeMode, this.positionInPortraitMode,
      {this.visibleInPreview});

  // ignore: public_member_api_docs
  factory WatermarkOptions.fromJson(Map<String, dynamic> json) =>
      _$WatermarkOptionsFromJson(json);

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$WatermarkOptionsToJson(this);
}

/// Configuration of the imported live broadcast voice or video stream.
@JsonSerializable()
class LiveInjectStreamConfig {
  /// Width of the added stream to the broadcast. The default value is 0, which is the same width as the original stream.
  int width;

  /// Height of the added stream to the broadcast. The default value is 0, which is the same height as the original stream.
  int height;

  /// Video GOP of the added stream to the broadcast. The default value is 30 frames.
  @JsonKey(includeIfNull: false)
  int videoGop;

  /// Video frame rate of the added stream to the broadcast. The default value is 15 fps.
  @JsonKey(includeIfNull: false)
  VideoFrameRate videoFramerate;

  /// Video bitrate of the added stream to the broadcast. The default value is 400 Kbps.
  @JsonKey(includeIfNull: false)
  int videoBitrate;

  /// Audio sample rate of the added stream to the broadcast: AudioSampleRateType. The default value is 44100 Hz.
  @JsonKey(includeIfNull: false)
  AudioSampleRateType audioSampleRate;

  /// Audio bitrate of the added stream to the broadcast. The default value is 48.
  @JsonKey(includeIfNull: false)
  int audioBitrate;

  /// Audio channels to add into the broadcast. The value ranges between 1 and 2. The default value is 1.
  @JsonKey(includeIfNull: false)
  int audioChannels;

  /// Constructs a [LiveInjectStreamConfig]
  LiveInjectStreamConfig(
      {this.width,
      this.height,
      this.videoGop,
      this.videoFramerate,
      this.videoBitrate,
      this.audioSampleRate,
      this.audioBitrate,
      this.audioChannels});

  // ignore: public_member_api_docs
  factory LiveInjectStreamConfig.fromJson(Map<String, dynamic> json) =>
      _$LiveInjectStreamConfigFromJson(json);

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$LiveInjectStreamConfigToJson(this);
}

/// The definition of CameraCapturerConfiguration.
@JsonSerializable()
class CameraCapturerConfiguration {
  /// The camera capturer configuration.
  final CameraCaptureOutputPreference preference;

  /// The camera direction.
  final CameraDirection cameraDirection;

  /// Constructs a [CameraCapturerConfiguration]
  CameraCapturerConfiguration(this.preference, this.cameraDirection);

  // ignore: public_member_api_docs
  factory CameraCapturerConfiguration.fromJson(Map<String, dynamic> json) =>
      _$CameraCapturerConfigurationFromJson(json);

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$CameraCapturerConfigurationToJson(this);
}

/// The channel media options.
@JsonSerializable()
class ChannelMediaOptions {
  /// Determines whether to subscribe to audio streams when the user joins the channel.
  final bool autoSubscribeAudio;

  /// Determines whether to subscribe to video streams when the user joins the channel.
  final bool autoSubscribeVideo;

  /// Constructs a [ChannelMediaOptions]
  ChannelMediaOptions(this.autoSubscribeAudio, this.autoSubscribeVideo);

  // ignore: public_member_api_docs
  factory ChannelMediaOptions.fromJson(Map<String, dynamic> json) =>
      _$ChannelMediaOptionsFromJson(json);

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$ChannelMediaOptionsToJson(this);
}

/// Statistics of RTCEngine.
@JsonSerializable()
class RtcStats {
  /// Call duration in seconds, represented by an aggregate value.
  int totalDuration;

  /// Total number of bytes transmitted, represented by an aggregate value.
  int txBytes;

  /// Total number of bytes received, represented by an aggregate value.
  int rxBytes;

  /// Total number of audio bytes sent (bytes), represented by an aggregate value.
  int txAudioBytes;

  /// Total number of video bytes sent (bytes), represented by an aggregate value.
  int txVideoBytes;

  /// Total number of audio bytes received (bytes), represented by an aggregate value.
  int rxAudioBytes;

  /// Total number of video bytes received (bytes), represented by an aggregate value.
  int rxVideoBytes;

  /// Transmission bitrate in Kbps, represented by an instantaneous value.
  int txKBitRate;

  /// Receive bitrate (Kbps), represented by an instantaneous value.
  int rxKBitRate;

  /// The transmission bitrate of the audio packet (Kbps), represented by an instantaneous value.
  int txAudioKBitRate;

  /// Audio receive bitrate (Kbps), represented by an instantaneous value.
  int rxAudioKBitRate;

  /// Video transmission bitrate (Kbps), represented by an instantaneous value.
  int txVideoKBitRate;

  /// Video receive bitrate (Kbps), represented by an instantaneous value.
  int rxVideoKBitRate;

  /// The number of users in the channel.
  int users;

  /// Client-server latency.
  int lastmileDelay;

  /// The packet loss rate (%) from the local client to Agora's edge server, before network countermeasures.
  int txPacketLossRate;

  /// The packet loss rate (%) from Agora's edge server to the local client, before network countermeasures.
  int rxPacketLossRate;

  /// System CPU usage (%).
  double cpuTotalUsage;

  /// Application CPU usage (%).
  double cpuAppUsage;

  /// The round-trip time delay from the client to the local router.
  int gatewayRtt;

  /// The memory usage ratio of the app (%).
  double memoryAppUsageRatio;

  /// The memory usage ratio of the system (%).
  double memoryTotalUsageRatio;

  /// The memory usage of the app (KB).
  int memoryAppUsageInKbytes;

  /// Constructs a [RtcStats]
  RtcStats();

  // ignore: public_member_api_docs
  factory RtcStats.fromJson(Map<String, dynamic> json) =>
      _$RtcStatsFromJson(json);

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$RtcStatsToJson(this);
}

/// Properties of the audio volume information. An array containing the user ID and volume information for each speaker.
@JsonSerializable()
class AudioVolumeInfo {
  /// The user ID of the speaker. The uid of the local user is 0.
  int uid;

  /// The sum of the voice volume and audio-mixing volume of the speaker. The value ranges between 0 (lowest volume) and 255 (highest volume).
  int volume;

  /// Voice activity status of the local user.
  int vad;

  /// The channel ID, which indicates which channel the speaker is in.
  String channelId;

  /// Constructs a [AudioVolumeInfo]
  AudioVolumeInfo();

  // ignore: public_member_api_docs
  factory AudioVolumeInfo.fromJson(Map<String, dynamic> json) =>
      _$AudioVolumeInfoFromJson(json);

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$AudioVolumeInfoToJson(this);
}

/// Rect.
@JsonSerializable()
class Rect {
  /// Left.
  int left;

  /// Top.
  int top;

  /// Right.
  int right;

  /// Bottom.
  int bottom;

  /// Constructs a [Rect]
  Rect();

  // ignore: public_member_api_docs
  factory Rect.fromJson(Map<String, dynamic> json) => _$RectFromJson(json);

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$RectToJson(this);
}

/// The one-way last-mile probe result.
@JsonSerializable()
class LastmileProbeOneWayResult {
  /// The packet loss rate (%).
  int packetLossRate;

  /// The network jitter (ms).
  int jitter;

  /// The estimated available bandwidth (bps).
  int availableBandwidth;

  /// Constructs a [LastmileProbeOneWayResult]
  LastmileProbeOneWayResult();

  // ignore: public_member_api_docs
  factory LastmileProbeOneWayResult.fromJson(Map<String, dynamic> json) =>
      _$LastmileProbeOneWayResultFromJson(json);

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$LastmileProbeOneWayResultToJson(this);
}

/// Statistics of the lastmile probe.
@JsonSerializable()
class LastmileProbeResult {
  /// The state of the probe test.
  LastmileProbeResultState state;

  /// The round-trip delay time (ms).
  int rtt;

  /// The uplink last-mile network report.
  LastmileProbeOneWayResult uplinkReport;

  /// The downlink last-mile network report.
  LastmileProbeOneWayResult downlinkReport;

  /// Constructs a [LastmileProbeResult]
  LastmileProbeResult();

  // ignore: public_member_api_docs
  factory LastmileProbeResult.fromJson(Map<String, dynamic> json) =>
      _$LastmileProbeResultFromJson(json);

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$LastmileProbeResultToJson(this);
}

/// Statistics of the local audio stream.
@JsonSerializable()
class LocalAudioStats {
  /// The number of channels.
  int numChannels;

  /// The sample rate (Hz).
  int sentSampleRate;

  /// The average sending bitrate (Kbps).
  int sentBitrate;

  /// Constructs a [LocalAudioStats]
  LocalAudioStats();

  // ignore: public_member_api_docs
  factory LocalAudioStats.fromJson(Map<String, dynamic> json) =>
      _$LocalAudioStatsFromJson(json);

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$LocalAudioStatsToJson(this);
}

/// Statistics of the local video.
@JsonSerializable()
class LocalVideoStats {
  /// Bitrate (Kbps) sent in the reported interval, which does not include the bitrate of the re-transmission video after the packet loss.
  int sentBitrate;

  /// Frame rate (fps) sent in the reported interval, which does not include the frame rate of the re-transmission video after the packet loss.
  int sentFrameRate;

  /// The encoder output frame rate (fps) of the local video.
  int encoderOutputFrameRate;

  /// The renderer output frame rate (fps) of the local video.
  int rendererOutputFrameRate;

  /// The target bitrate (Kbps) of the current encoder. This value is estimated by the SDK based on the current network conditions.
  int targetBitrate;

  /// The target frame rate (fps) of the current encoder.
  int targetFrameRate;

  /// Quality change of the local video in terms of target frame rate and target bit rate since last count.
  VideoQualityAdaptIndication qualityAdaptIndication;

  /// The encoding bitrate (Kbps), which does not include the bitrate of the re-transmission video after packet loss.
  int encodedBitrate;

  /// The width of the encoding frame (px).
  int encodedFrameWidth;

  /// The height of the encoding frame (px).
  int encodedFrameHeight;

  /// The value of the sent frame rate, represented by an aggregate value.
  int encodedFrameCount;

  /// The codec type of the local video.
  VideoCodecType codecType;

  /// Constructs a [LocalVideoStats]
  LocalVideoStats();

  // ignore: public_member_api_docs
  factory LocalVideoStats.fromJson(Map<String, dynamic> json) =>
      _$LocalVideoStatsFromJson(json);

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$LocalVideoStatsToJson(this);
}

/// Statistics of the remote audio.
@JsonSerializable()
class RemoteAudioStats {
  /// User ID of the user sending the audio streams.
  int uid;

  /// Audio quality received by the user.
  NetworkQuality quality;

  /// Network delay (ms) from the sender to the receiver.
  int networkTransportDelay;

  /// Network delay (ms) from the receiver to the jitter buffer.
  int jitterBufferDelay;

  /// Packet loss rate in the reported interval.
  int audioLossRate;

  /// The number of channels.
  int numChannels;

  /// The sample rate (Hz) of the received audio stream in the reported interval.
  int receivedSampleRate;

  /// The average bitrate (Kbps) of the received audio stream in the reported interval.
  int receivedBitrate;

  /// The total freeze time (ms) of the remote audio stream after the remote user joins the channel. In the reported interval, audio freeze occurs when the audio frame loss rate reaches 4%. totalFrozenTime = The audio freeze time × 2 × 1000 (ms).
  int totalFrozenTime;

  /// The total audio freeze time as a percentage (%) of the total time when the audio is available.
  int frozenRate;

  /// The total time (ms) when the remote user in the Communication profile or the remote broadcaster in the Live-broadcast profile neither stops sending the audio stream nor disables the audio module after joining the channel.
  int totalActiveTime;

  /// Constructs a [RemoteAudioStats]
  RemoteAudioStats();

  // ignore: public_member_api_docs
  factory RemoteAudioStats.fromJson(Map<String, dynamic> json) =>
      _$RemoteAudioStatsFromJson(json);

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$RemoteAudioStatsToJson(this);
}

/// Statistics of the remote video.
@JsonSerializable()
class RemoteVideoStats {
  /// User ID of the user sending the video streams.
  int uid;

  /// Time delay (ms). In scenarios where audio and video is synchronized, you can use the value of networkTransportDelay and jitterBufferDelay in RemoteAudioStats to know the delay statistics of the remote video.
  @deprecated
  int delay;

  /// Width (pixels) of the remote video.
  int width;

  /// Height (pixels) of the remote video.
  int height;

  /// Bitrate (Kbps) received in the reported interval.
  int receivedBitrate;

  /// The decoder output frame rate (fps) of the remote video.
  int decoderOutputFrameRate;

  /// The renderer output frame rate (fps) of the remote video.
  int rendererOutputFrameRate;

  /// Packet loss rate (%) of the remote video stream after network countermeasures.
  int packetLossRate;

  /// Video stream type (high-stream or low-stream).
  VideoStreamType rxStreamType;

  /// The total freeze time (ms) of the remote video stream after the remote user joins the channel.
  int totalFrozenTime;

  /// The total video freeze time as a percentage (%) of the total time when the video is available.
  int frozenRate;

  /// The total time (ms) when the remote user in the Communication profile or the remote broadcaster in the Live-broadcast profile neither stops sending the video stream nor disables the video module after joining the channel.
  int totalActiveTime;

  /// Constructs a [RemoteVideoStats]
  RemoteVideoStats();

  // ignore: public_member_api_docs
  factory RemoteVideoStats.fromJson(Map<String, dynamic> json) =>
      _$RemoteVideoStatsFromJson(json);

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$RemoteVideoStatsToJson(this);
}

/// The information of the detected human face.
@JsonSerializable()
class FacePositionInfo {
  /// The x coordinate (px) of the human face in the local video. Taking the top left corner of the captured video as the origin, the x coordinate represents the relative lateral displacement of the top left corner of the human face to the origin.
  int x;

  /// The y coordinate (px) of the human face in the local video. Taking the top left corner of the captured video as the origin, the y coordinate represents the relative longitudinal displacement of the top left corner of the human face to the origin.
  int y;

  /// The width (px) of the human face in the captured video.
  int width;

  /// The height (px) of the human face in the captured video.
  int height;

  /// The distance (cm) between the human face and the screen.
  int distance;

  /// Constructs a [FacePositionInfo]
  FacePositionInfo();

  // ignore: public_member_api_docs
  factory FacePositionInfo.fromJson(Map<String, dynamic> json) =>
      _$FacePositionInfoFromJson(json);

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$FacePositionInfoToJson(this);
}
