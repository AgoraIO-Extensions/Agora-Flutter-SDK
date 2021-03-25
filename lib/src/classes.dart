import 'package:json_annotation/json_annotation.dart';

import 'enums.dart';

part 'classes.g.dart';

/// The UserInfo class.
@JsonSerializable(explicitToJson: true)
class UserInfo {
  /// The user ID.
  int uid;

  /// The user account.
  String userAccount;

  /// Constructs a [UserInfo]
  UserInfo();

  /// @nodoc
  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

/// The video resolution.
@JsonSerializable(explicitToJson: true)
class VideoDimensions {
  /// The video resolution on the horizontal axis.
  final int width;

  /// The video resolution on the vertical axis.
  final int height;

  /// Constructs a [VideoDimensions]
  VideoDimensions(this.width, this.height);

  /// @nodoc ignore: public_member_api_docs
  factory VideoDimensions.fromJson(Map<String, dynamic> json) =>
      _$VideoDimensionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$VideoDimensionsToJson(this);
}

/// Definition of VideoEncoderConfiguration.
@JsonSerializable(explicitToJson: true)
class VideoEncoderConfiguration {
  /// The video frame dimensions (px), which is used to specify the video quality and measured by the total number of pixels along a frame's width and height. The default value is 640 × 360.
  /// You can customize the dimension, or select from the following list:
  /// - 120x120
  /// - 160x120
  /// - 180x180
  /// - 240x180
  /// - 320x180
  /// - 240x240
  /// - 320x240
  /// - 424x240
  /// - 360x360
  /// - 480x360
  /// - 640x360
  /// - 480x480
  /// - 640x480
  /// - 840x480
  /// - 960x720
  /// - 1280x720
  ///
  /// **Note**
  /// - The value of the dimension does not indicate the orientation mode of the output ratio. For how to set the video orientation, see [VideoOutputOrientationMode].</li>
  /// - Whether 720p+ can be supported depends on the device. If the device cannot support 720p, the frame rate will be lower than the one listed in the table.</li>
  @JsonKey(includeIfNull: false)
  VideoDimensions dimensions;

  /// The video frame rate (fps). The default value is 15. You can either set the frame rate manually or choose from [VideoFrameRate]. We do not recommend setting this to a value greater than 30.
  @JsonKey(includeIfNull: false)
  VideoFrameRate frameRate;

  /// The minimum video encoder frame rate (fps). The default value is [VideoFrameRate.Min] (the SDK uses the lowest encoder frame rate).
  @JsonKey(includeIfNull: false)
  VideoFrameRate minFrameRate;

  /// Bitrate of the video (Kbps). Refer to the table below and set your bitrate. If you set a bitrate beyond the proper range, the SDK automatically adjusts it to a value within the range.
  ///  You can also choose from the following options:
  ///     - [BitRate.Standard]: (Recommended) The standard bitrate mode. In this mode, the bitrates differ between the LiveBroadcasting and Communication profiles:
  ///              - In the Communication profile, the video bitrate is the same as the base bitrate.
  ///              - In the LiveBroadcasting profile, the video bitrate is twice the base bitrate.
  ///     - [BitRate.Compatible]: The compatible bitrate mode. In this mode, the bitrate stays the same regardless of the profile. If you choose this mode for the Live Broadcast profile, the video frame rate may be lower than the set value.
  /// Agora uses different video codecs for different profiles to optimize the user experience. For example, the Communication profile prioritizes the smoothness while the Live Broadcast profile prioritizes the video quality (a higher bitrate). Therefore, We recommend setting this parameter as `0`.
  ///
  /// **Video Bitrate Table**
  ///
  /// | Resolution             | Frame Rate (fps) | Base Bitrate (Kbps)                    | Live Bitrate (Kbps)                    |
  /// |------------------------|------------------|----------------------------------------|----------------------------------------|
  /// | 160 * 120              | 15               | 65                                     | 130                                    |
  /// | 120 * 120              | 15               | 50                                     | 100                                    |
  /// | 320 * 180              | 15               | 140                                    | 280                                    |
  /// | 180 * 180              | 15               | 100                                    | 200                                    |
  /// | 240 * 180              | 15               | 120                                    | 240                                    |
  /// | 320 * 240              | 15               | 200                                    | 400                                    |
  /// | 240 * 240              | 15               | 140                                    | 280                                    |
  /// | 424 * 240              | 15               | 220                                    | 440                                    |
  /// | 640 * 360              | 15               | 400                                    | 800                                    |
  /// | 360 * 360              | 15               | 260                                    | 520                                    |
  /// | 640 * 360              | 30               | 600                                    | 1200                                   |
  /// | 360 * 360              | 30               | 400                                    | 800                                    |
  /// | 480 * 360              | 15               | 320                                    | 640                                    |
  /// | 480 * 360              | 30               | 490                                    | 980                                    |
  /// | 640 * 480              | 15               | 500                                    | 1000                                   |
  /// | 480 * 480              | 15               | 400                                    | 800                                    |
  /// | 640 * 480              | 30               | 750                                    | 1500                                   |
  /// | 480 * 480              | 30               | 600                                    | 1200                                   |
  /// | 848 * 480              | 15               | 610                                    | 1220                                   |
  /// | 848 * 480              | 30               | 930                                    | 1860                                   |
  /// | 640 * 480              | 10               | 400                                    | 800                                    |
  /// | 1280 * 720             | 15               | 1130                                   | 2260                                   |
  /// | 1280 * 720             | 30               | 1710                                   | 3420                                   |
  /// | 960 * 720              | 15               | 910                                    | 1820                                   |
  /// | 960 * 720              | 30               | 1380                                   | 2760                                   |
  ///
  ///  **Note**
  /// - The base bitrate in this table applies to the Communication profile.
  /// - The LiveBroadcasting profile generally requires a higher bitrate for better video quality. We recommend setting the bitrate mode as `0`. You can also set the bitrate as the base bitrate value x 2.
  @JsonKey(includeIfNull: false)
  int bitrate;

  /// The minimum encoding bitrate (Kbps). The Agora SDK automatically adjusts the encoding bitrate to adapt to the network conditions. Using a value greater than the default value forces the video encoder to output high-quality images but may cause more packet loss and hence sacrifice the smoothness of the video transmission. That said, unless you have special requirements for image quality, Agora does not recommend changing this value.
  @JsonKey(includeIfNull: false)
  int minBitrate;

  /// The orientation mode.
  /// See [VideoOutputOrientationMode].
  @JsonKey(includeIfNull: false)
  VideoOutputOrientationMode orientationMode;

  /// The video encoding degradation preference under limited bandwidth:
  /// See [DegradationPreference].
  @JsonKey(includeIfNull: false)
  DegradationPreference degradationPrefer;

  /// Sets the mirror mode of the published local video stream.
  /// This member only affects the video that the remote user sees.
  /// See [VideoMirrorMode].
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

  /// @nodoc
  factory VideoEncoderConfiguration.fromJson(Map<String, dynamic> json) =>
      _$VideoEncoderConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$VideoEncoderConfigurationToJson(this);
}

/// Sets the image enhancement options.
@JsonSerializable(explicitToJson: true)
class BeautyOptions {
  /// The lightening contrast level, used with [lighteningLevel].
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

  /// @nodoc
  factory BeautyOptions.fromJson(Map<String, dynamic> json) =>
      _$BeautyOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$BeautyOptionsToJson(this);
}

/// Agora image properties. A class for setting the properties of the watermark and background images.
@JsonSerializable(explicitToJson: true)
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

  /// @nodoc
  factory AgoraImage.fromJson(Map<String, dynamic> json) =>
      _$AgoraImageFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AgoraImageToJson(this);
}

/// The transcodingUser class, which defines the audio and video properties in the CDN live. Agora supports a maximum of 17 transcoding users in a CDN live streaming channel.
@JsonSerializable(explicitToJson: true)
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

  /// The layer index of the video frame. An integer. The value range is [0,100].
  /// - 0: (Default) Bottom layer.
  /// - 100: Top layer.
  ///
  /// **Note**: If the value is set lower than 0 or higher than 100, the [ErrorCode.InvalidArgument] error is reported.
  int zOrder;

  /// The transparency of the video frame of the user in the CDN live stream that ranges between 0.0 and 1.0. 0.0 means that the video frame is completely transparent and 1.0 means opaque. The default value is 1.0.
  @JsonKey(includeIfNull: false)
  double alpha;

  /// The audio channel ranging between 0 and 5. The default value is 0.
  /// See [AudioChannel].
  ///
  /// **Note** Special players are needed if `audioChannel` is not set as 0.
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

  /// @nodoc
  factory TranscodingUser.fromJson(Map<String, dynamic> json) =>
      _$TranscodingUserFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$TranscodingUserToJson(this);
}

/// The background color in RGB hex. Value only. Do not include a preceding #. For example, 0xFFB6C1 (light pink). The default value is 0x000000 (black).
@JsonSerializable(explicitToJson: true)
class Color {
  /// Red.
  final int red;

  /// Green.
  final int green;

  /// Blue.
  final int blue;

  /// Constructs a [Color]
  Color(this.red, this.green, this.blue);

  /// @nodoc
  factory Color.fromJson(Map<String, dynamic> json) => _$ColorFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ColorToJson(this);
}

/// A class for managing user-specific CDN live audio/video transcoding settings.
@JsonSerializable(explicitToJson: true)
class LiveTranscoding {
  /// Width (pixel) of the video. The default value is 360.
  /// - When pushing video streams to the CDN, ensure that `width` is at least 64; otherwise, the Agora server adjusts the value to 64.
  /// - When pushing audio streams to the CDN, set `width` and `height` as 0.
  @JsonKey(includeIfNull: false)
  int width;

  /// Height (pixel) of the video. The default value is 640.
  /// - When pushing video streams to the CDN, ensure that `height` is at least 64; otherwise, the Agora server adjusts the value to 64.
  /// - When pushing audio streams to the CDN, set `width` and `height` as 0.
  @JsonKey(includeIfNull: false)
  int height;

  /// Bitrate (Kbps) of the CDN live output video stream. The default value is 400. Set this parameter according to the [VideoEncoderConfiguration.bitrate](Video Bitrate Table). If you set a bitrate beyond the proper range, the SDK automatically adapts it to a value within the range.
  @JsonKey(includeIfNull: false)
  int videoBitrate;

  /// The frame rate (fps) of the video. The value range is [0, 30]. The default value is 15. The Agora server adjusts any value over 30 to 30.
  @JsonKey(includeIfNull: false)
  VideoFrameRate videoFramerate;

  /// Agora does not recommend using this parameter.
  /// - `true`: Low latency with unassured quality.
  /// - `false`: (Default) High latency with assured quality.
  @deprecated
  @JsonKey(includeIfNull: false)
  bool lowLatency;

  /// Gop of the video frames in the CDN live stream. The default value is 30 fps.
  @JsonKey(includeIfNull: false)
  int videoGop;

  /// The watermark image added to the CDN live publishing stream. Ensure that the format of the image is PNG. Once a watermark image is added, the audience of the CDN live publishing stream can see it.
  /// See [AgoraImage].
  @JsonKey(includeIfNull: false)
  AgoraImage watermark;

  /// The background image added to the CDN live publishing stream. Once a background image is added, the audience of the CDN live publishing stream can see it.
  /// See [AgoraImage].
  @JsonKey(includeIfNull: false)
  AgoraImage backgroundImage;

  /// Self-defined audio-sample rate: [AudioSampleRateType].
  @JsonKey(includeIfNull: false)
  AudioSampleRateType audioSampleRate;

  /// Bitrate (Kbps) of the CDN live audio output stream. The default value is 48 and the highest value is 128.
  @JsonKey(includeIfNull: false)
  int audioBitrate;

  /// Agora’s self-defined audio channel type. Agora recommends choosing 1 (mono), or 2 (stereo) audio channels. Special players are required if you choose 3, 4, or 5.
  /// See [AudioChannel].
  @JsonKey(includeIfNull: false)
  AudioChannel audioChannels;

  /// Audio codec profile type: [AudioCodecProfileType]. Set it as `LCAAC` or `HEAAC`. The default value is `LCAAC`.
  @JsonKey(includeIfNull: false)
  AudioCodecProfileType audioCodecProfile;

  /// Video codec profile type: [VideoCodecProfileType]. Set it as `BASELINE`, `MAIN`, or `HIGH` (default). If you set this parameter to other values, Agora adjusts it to the default value `HIGH`.
  @JsonKey(includeIfNull: false)
  VideoCodecProfileType videoCodecProfile;

  /// The background color in RGB hex. Value only. Do not include a preceding #. For example, 0xFFB6C1 (light pink). The default value is 0x000000 (black).
  /// See [Color].
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

  /// @nodoc
  factory LiveTranscoding.fromJson(Map<String, dynamic> json) =>
      _$LiveTranscodingFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LiveTranscodingToJson(this);
}

/// The ChannelMediaInfo class.
@JsonSerializable(explicitToJson: true)
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

  /// @nodoc
  factory ChannelMediaInfo.fromJson(Map<String, dynamic> json) =>
      _$ChannelMediaInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ChannelMediaInfoToJson(this);
}

/// The ChannelMediaRelayConfiguration class.
@JsonSerializable(explicitToJson: true)
class ChannelMediaRelayConfiguration {
  /// The information of the source channel: [ChannelMediaInfo]. It contains the following members:
  /// - `channelName`: The name of the source channel. The default value is NULL, which means the SDK applies the name of the current channel.
  /// - `uid`: ID of the broadcaster whose media stream you want to relay. The default value is 0, which means the SDK generates a random UID. You must set it as 0.
  /// - `token`: The token for joining the source channel. It is generated with the `channelName` and `uid` you set in `srcInfo`.
  ///   - If you have not enabled the App Certificate, set this parameter as the default value NULL, which means the SDK applies the App ID.
  ///   - If you have enabled the App Certificate, you must use the token generated with the `channelName` and `uid`.
  final ChannelMediaInfo srcInfo;

  /// The information of the destination channel: [ChannelMediaInfo]. It contains the following members:
  ///- `channelName`: The name of the destination channel.
  ///- `uid`: ID of the broadcaster in the destination channel. The value ranges from 0 to (2<sup>32</sup>-1). To avoid UID conflicts,
  /// this uid must be different from any other UIDs in the destination channel. The default value is 0, which means the SDK generates a random UID.
  ///  - `token`: The token for joining the destination channel. It is generated with the `channelName` and `uid` you set in `destInfo`.
  ///    - If you have not enabled the App Certificate, set this parameter as the default value NULL, which means the SDK applies the App ID.
  ///    - If you have enabled the App Certificate, you must use the token generated with the `channelName` and `uid`.
  final List<ChannelMediaInfo> destInfos;

  /// Constructs a [ChannelMediaRelayConfiguration]
  ChannelMediaRelayConfiguration(this.srcInfo, this.destInfos);

  /// @nodoc
  factory ChannelMediaRelayConfiguration.fromJson(Map<String, dynamic> json) =>
      _$ChannelMediaRelayConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ChannelMediaRelayConfigurationToJson(this);
}

/// Lastmile probe configuration.
@JsonSerializable(explicitToJson: true)
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

  /// @nodoc
  factory LastmileProbeConfig.fromJson(Map<String, dynamic> json) =>
      _$LastmileProbeConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LastmileProbeConfigToJson(this);
}

/// The position and size of the watermark image.
@JsonSerializable(explicitToJson: true)
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

  /// @nodoc
  factory Rectangle.fromJson(Map<String, dynamic> json) =>
      _$RectangleFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RectangleToJson(this);
}

/// Agora watermark options. A class for setting the properties of watermark.
@JsonSerializable(explicitToJson: true)
class WatermarkOptions {
  /// Whether the watermark image is visible in the local video preview.
  /// - `true`: (Default) The watermark image is visible in preview.
  /// - `false`: The watermark image is not visible in preview.
  @JsonKey(includeIfNull: false)
  bool visibleInPreview;

  /// The watermark position in the landscape mode.
  /// See [Rectangle].
  final Rectangle positionInLandscapeMode;

  /// The watermark position in the portrait mode.
  /// See [Rectangle].
  final Rectangle positionInPortraitMode;

  /// Constructs a [WatermarkOptions]
  WatermarkOptions(this.positionInLandscapeMode, this.positionInPortraitMode,
      {this.visibleInPreview});

  /// @nodoc
  factory WatermarkOptions.fromJson(Map<String, dynamic> json) =>
      _$WatermarkOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$WatermarkOptionsToJson(this);
}

/// Configuration of the imported live broadcast voice or video stream.
@JsonSerializable(explicitToJson: true)
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

  /// Audio sample rate of the added stream to the broadcast: [AudioSampleRateType]. The default value is 44100 Hz.
  ///
  /// **Note** We recommend you use the default value and not reset it.
  @JsonKey(includeIfNull: false)
  AudioSampleRateType audioSampleRate;

  /// Audio bitrate of the added stream to the broadcast. The default value is 48.
  ///
  /// **Note** We recommend you use the default value and not reset it.
  @JsonKey(includeIfNull: false)
  int audioBitrate;

  /// Audio channels to add into the broadcast. The value ranges between 1 and 2. The default value is 1.
  ///
  /// **Note** We recommend you use the default value and not reset it.
  @JsonKey(includeIfNull: false)
  AudioChannel audioChannels;

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

  /// @nodoc
  factory LiveInjectStreamConfig.fromJson(Map<String, dynamic> json) =>
      _$LiveInjectStreamConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LiveInjectStreamConfigToJson(this);
}

/// The definition of CameraCapturerConfiguration.
@JsonSerializable(explicitToJson: true)
class CameraCapturerConfiguration {
  /// The camera capturer configuration.
  /// See [CameraCaptureOutputPreference].
  final CameraCaptureOutputPreference preference;

  /// The camera direction.
  /// See [CameraDirection].
  final CameraDirection cameraDirection;

  /// Constructs a [CameraCapturerConfiguration]
  CameraCapturerConfiguration(this.preference, this.cameraDirection);

  /// @nodoc
  factory CameraCapturerConfiguration.fromJson(Map<String, dynamic> json) =>
      _$CameraCapturerConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$CameraCapturerConfigurationToJson(this);
}

/// The channel media options.
@JsonSerializable(explicitToJson: true)
class ChannelMediaOptions {
  /// Determines whether to subscribe to audio streams when the user joins the channel.
  /// - `true`: (Default) Subscribe.
  /// - `false`: Do not subscribe.
  ///
  /// This member serves a similar function to the [RtcEngine.muteAllRemoteAudioStreams] method.
  /// After joining the channel, you can call `muteAllRemoteAudioStreams` to set whether to subscribe to audio streams in the channel.
  final bool autoSubscribeAudio;

  /// Determines whether to subscribe to video streams when the user joins the channel.
  /// - `true`: (Default) Subscribe.
  /// - `false`: Do not subscribe.
  ///
  /// This member serves a similar function to the [RtcEngine.muteAllRemoteVideoStreams] method.
  /// After joining the channel, you can call `muteAllRemoteVideoStreams` to set whether to subscribe to video streams in the channel.
  final bool autoSubscribeVideo;

  /// Constructs a [ChannelMediaOptions]
  ChannelMediaOptions(this.autoSubscribeAudio, this.autoSubscribeVideo);

  /// @nodoc
  factory ChannelMediaOptions.fromJson(Map<String, dynamic> json) =>
      _$ChannelMediaOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ChannelMediaOptionsToJson(this);
}

/// Definition of `EncryptionConfig`.
///
/// @since v3.1.2.
@JsonSerializable(explicitToJson: true)
class EncryptionConfig {
  /// Encryption mode. The default encryption mode is `AES128XTS`. See [EncryptionMode].
  final EncryptionMode encryptionMode;

  /// Encryption key in string type.
  ///
  /// **Note**
  ///
  /// If you do not set an encryption key or set it as null, you cannot use the built-in encryption, and the SDK returns [ErrorCode.InvalidArgument].
  final String encryptionKey;

  /// Constructs a [EncryptionConfig]
  EncryptionConfig(this.encryptionMode, this.encryptionKey);

  /// @nodoc
  factory EncryptionConfig.fromJson(Map<String, dynamic> json) =>
      _$EncryptionConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$EncryptionConfigToJson(this);
}

/// Statistics of RTCEngine.
@JsonSerializable(explicitToJson: true)
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
  /// - Communication profile: The number of users in the channel.
  /// - Live Broadcast profile:
  ///   - If the local user is an audience: The number of users in the channel = The number of hosts in the channel + 1.
  ///   - If the local user is a host: The number of users in the channel = The number of hosts in the channel.
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
  ///
  /// **Note**: This value is for reference only. Due to system limitations, you may not get the value of this member.
  double memoryAppUsageRatio;

  /// The memory usage ratio of the system (%).
  ///
  /// **Note**: This value is for reference only. Due to system limitations, you may not get the value of this member.
  double memoryTotalUsageRatio;

  /// The memory usage of the app (KB).
  ///
  /// **Note**: This value is for reference only. Due to system limitations, you may not get the value of this member.
  int memoryAppUsageInKbytes;

  /// Constructs a [RtcStats]
  RtcStats();

  /// @nodoc
  factory RtcStats.fromJson(Map<String, dynamic> json) =>
      _$RtcStatsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RtcStatsToJson(this);
}

/// Properties of the audio volume information.
/// Contains the user ID and volume information for each speaker.
@JsonSerializable(explicitToJson: true)
class AudioVolumeInfo {
  /// The user ID of the speaker. The uid of the local user is 0.
  int uid;

  /// The sum of the voice volume and audio-mixing volume of the speaker. The value ranges between 0 (lowest volume) and 255 (highest volume).
  int volume;

  /// Voice activity status of the local user.
  /// - 0: The local user is not speaking.
  /// - 1: The local user is speaking.
  ///
  ///
  /// **Note**
  /// - The `vad` parameter cannot report the voice activity status of the remote users. In the remote users' callback, `vad` = 0.
  /// - Ensure that you set `report_vad`(true) in the [RtcEngine.enableAudioVolumeIndication] method to enable the voice activity
  /// detection of the local user.
  int vad;

  /// The channel ID, which indicates which channel the speaker is in.
  String channelId;

  /// Constructs a [AudioVolumeInfo]
  AudioVolumeInfo();

  /// @nodoc
  factory AudioVolumeInfo.fromJson(Map<String, dynamic> json) =>
      _$AudioVolumeInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AudioVolumeInfoToJson(this);
}

/// Integer coordinates for a rectangle.
@JsonSerializable(explicitToJson: true)
class Rect {
  /// The X coordinate of the left side of the rectangle.
  int left;

  /// The Y coordinate of the top side of the rectangle.
  int top;

  /// The X coordinate of the right side of the rectangle.
  int right;

  /// The Y coordinate of the bottom side of the rectangle.
  int bottom;

  /// Constructs a [Rect]
  Rect();

  /// @nodoc
  factory Rect.fromJson(Map<String, dynamic> json) => _$RectFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RectToJson(this);
}

/// The one-way last-mile probe result.
@JsonSerializable(explicitToJson: true)
class LastmileProbeOneWayResult {
  /// The packet loss rate (%).
  int packetLossRate;

  /// The network jitter (ms).
  int jitter;

  /// The estimated available bandwidth (bps).
  int availableBandwidth;

  /// Constructs a [LastmileProbeOneWayResult]
  LastmileProbeOneWayResult();

  /// @nodoc
  factory LastmileProbeOneWayResult.fromJson(Map<String, dynamic> json) =>
      _$LastmileProbeOneWayResultFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LastmileProbeOneWayResultToJson(this);
}

/// Statistics of the lastmile probe.
@JsonSerializable(explicitToJson: true)
class LastmileProbeResult {
  /// The state of the probe test.
  /// See [LastmileProbeResultState].
  LastmileProbeResultState state;

  /// The round-trip delay time (ms).
  int rtt;

  /// The uplink last-mile network report.
  /// See [LastmileProbeOneWayResult].
  LastmileProbeOneWayResult uplinkReport;

  /// The downlink last-mile network report.
  /// See [LastmileProbeOneWayResult].
  LastmileProbeOneWayResult downlinkReport;

  /// Constructs a [LastmileProbeResult]
  LastmileProbeResult();

  /// @nodoc
  factory LastmileProbeResult.fromJson(Map<String, dynamic> json) =>
      _$LastmileProbeResultFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LastmileProbeResultToJson(this);
}

/// Statistics of the local audio stream.
@JsonSerializable(explicitToJson: true)
class LocalAudioStats {
  /// The number of channels.
  int numChannels;

  /// The sample rate (Hz).
  int sentSampleRate;

  /// The average sending bitrate (Kbps).
  int sentBitrate;

  /// Constructs a [LocalAudioStats]
  LocalAudioStats();

  /// @nodoc
  factory LocalAudioStats.fromJson(Map<String, dynamic> json) =>
      _$LocalAudioStatsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LocalAudioStatsToJson(this);
}

/// Statistics of the local video.
@JsonSerializable(explicitToJson: true)
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
  /// See [VideoQualityAdaptIndication].
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
  /// See [VideoCodecType].
  VideoCodecType codecType;


  /// Constructs a [LocalVideoStats]
  LocalVideoStats();

  /// @nodoc
  factory LocalVideoStats.fromJson(Map<String, dynamic> json) =>
      _$LocalVideoStatsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LocalVideoStatsToJson(this);
}

/// Statistics of the remote audio.
@JsonSerializable(explicitToJson: true)
class RemoteAudioStats {
  /// ID of the user sending the audio streams.
  int uid;

  /// Audio quality received by the user.
  /// See [NetworkQuality].
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


  /// Constructs a [RemoteAudioStats]
  RemoteAudioStats();

  /// @nodoc
  factory RemoteAudioStats.fromJson(Map<String, dynamic> json) =>
      _$RemoteAudioStatsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RemoteAudioStatsToJson(this);
}

/// Statistics of the remote video.
@JsonSerializable(explicitToJson: true)
class RemoteVideoStats {
  /// ID of the user sending the video streams.
  int uid;

  /// Time delay (ms). In scenarios where audio and video is synchronized, you can use the value of `networkTransportDelay` and `jitterBufferDelay` in [RemoteAudioStats] to know the delay statistics of the remote video.
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
  /// See [VideoStreamType].
  VideoStreamType rxStreamType;

  /// The total freeze time (ms) of the remote video stream after the remote user joins the channel.
  /// In a video session where the frame rate is set to no less than 5 fps, video freeze occurs when the time interval between two adjacent renderable video frames is more than 500 ms.
  int totalFrozenTime;

  /// The total video freeze time (`totalFrozenTime`) as a percentage (%) of the total time when the video is available (`totalActiveTime`).
  int frozenRate;


  /// Constructs a [RemoteVideoStats]
  RemoteVideoStats();

  /// @nodoc
  factory RemoteVideoStats.fromJson(Map<String, dynamic> json) =>
      _$RemoteVideoStatsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RemoteVideoStatsToJson(this);
}

/// The information of the detected human face.
@JsonSerializable(explicitToJson: true)
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

  /// @nodoc
  factory FacePositionInfo.fromJson(Map<String, dynamic> json) =>
      _$FacePositionInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$FacePositionInfoToJson(this);
}
