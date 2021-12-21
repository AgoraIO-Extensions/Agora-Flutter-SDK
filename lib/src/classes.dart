import 'dart:typed_data';
import 'dart:ui' show Color;

import 'package:agora_rtc_engine/src/enum_converter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'events.dart';

import 'enums.dart';

part 'classes.g.dart';

Color _$ColorFromJson(Map<String, dynamic> json) => Color.fromRGBO(
    json['red'] as int, json['green'] as int, json['blue'] as int, 1.0);

Map<String, dynamic>? _$ColorToJson(Color? instance) => instance != null
    ? <String, dynamic>{
        'red': instance.red,
        'green': instance.green,
        'blue': instance.blue,
      }
    : null;

///
/// The information of the user.
/// 
///
@JsonSerializable(explicitToJson: true)
class UserInfo {
  ///
  /// User ID
  ///
  int uid;

  ///
  /// The user account. 
  ///
  String userAccount;

  /// Constructs a [UserInfo]
  UserInfo(
    this.uid,
    this.userAccount,
  );

  /// @nodoc
  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

///
/// Video dimensions.
/// 
///
@JsonSerializable(explicitToJson: true)
class VideoDimensions {
  @JsonKey(includeIfNull: false)
  ///
  /// 
  /// The width (pixels) of the video.
  /// 
  ///
  int? width;

  @JsonKey(includeIfNull: false)
  ///
  /// The height (pixels) of the video.
  ///
  int? height;

  /// Constructs a [VideoDimensions]
  VideoDimensions({
    this.width,
    this.height,
  });

  /// @nodoc
  factory VideoDimensions.fromJson(Map<String, dynamic> json) =>
      _$VideoDimensionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$VideoDimensionsToJson(this);
}

///
/// Video encoder configurations.
/// 
///
@JsonSerializable(explicitToJson: true)
class VideoEncoderConfiguration {
  @JsonKey(includeIfNull: false)
  ///
  /// 
  /// The dimensions of the encoded video (px). This parameter measures the video encoding quality in the format of length × width. The default value is 640 × 360. You can set a custom value, or select from the following list:
  /// AgoraVideoDimension120x120
  /// AgoraVideoDimension160x120
  /// AgoraVideoDimension180x180
  /// AgoraVideoDimension180x180
  /// AgoraVideoDimension320x180
  /// AgoraVideoDimension240x240
  /// AgoraVideoDimension320x240
  /// AgoraVideoDimension424x240
  /// AgoraVideoDimension360x360
  /// AgoraVideoDimension480x360
  /// AgoraVideoDimension640x360
  /// AgoraVideoDimension480x480
  /// AgoraVideoDimension640x480
  /// AgoraVideoDimension840x480
  /// AgoraVideoDimension960x720
  /// AgoraVideoDimension1280x720
  /// AgoraVideoDimension1920x1080 (macOS only)
  /// AgoraVideoDimension2540x1440 (macOS only)
  /// AgoraVideoDimension3840x2160 (macOS only)
  /// 
  /// 
  /// 
  /// Whether the 720p resolution or above can be supported depends on the device. If the device cannot support 720p, the frame rate will be lower than the set value.
  /// iPhones do not support video frame dimensions above 720p.
  /// 
  /// 
  /// 
  ///
  VideoDimensions? dimensions;

  @JsonKey(includeIfNull: false)
  ///
  /// 
  /// The encoding frame rate (fps) of the video. See VideoFrameRate. The default value is 15.
  ///   
  ///
  VideoFrameRate? frameRate;

  @JsonKey(includeIfNull: false)
  VideoFrameRate? minFrameRate;

  @JsonKey(includeIfNull: false)
  ///
  /// 
  /// The encoding bitrate (Kbps) of the video.
  /// 
  ///   : (Recommended)
  /// Standard bitrate mode. In this mode, the video bitrate of the Live-broadcasting profile is twice that of the Communication profile.
  ///  
  /// : Adaptive bitrate mode. In this mode, the bitrate differs between the Live-broadcasting and Communication profiles. If you choose this mode in the Live-broadcasting profile, the video frame rate may be lower than the set value.
  /// 
  /// Agora uses different video codecs for different profiles to optimize user experience. The Communication profile prioritizes smoothness while the Live-broadcasting profile prioritizes video quality (a higher bitrate).  Therefore, Agora recommends setting this parameter as
  ///  . You can also set the bitrate value of the Live-broadcasting profile to twice the bitrate value of the Communication profile.
  /// 
  ///
  int? bitrate;

  @JsonKey(includeIfNull: false)
  ///
  /// 
  /// The minimum encoding bitrate (Kbps) of the video.
  /// The SDK automatically adjusts the encoding bitrate to adapt to the network conditions. Using a value greater than the default value forces the video encoder to output high-quality images but may cause more packet loss and sacrifice the smoothness of the video transmission. Unless you have special requirements for image quality, Agora does not recommend changing this value.
  /// This parameter only applies to the Live-broadcasting profile.
  ///   
  ///
  int? minBitrate;

  @JsonKey(includeIfNull: false)
  ///
  /// 
  /// The orientation mode of the encoded video. See VideoOutputOrientationMode.
  ///
  VideoOutputOrientationMode? orientationMode;

  @JsonKey(includeIfNull: false)
  DegradationPreference? degradationPrefer;

  @JsonKey(includeIfNull: false)
  ///
  /// 
  /// Whether to mirror the video when encoding the video. It only affects the video that the
  /// remote user sees. For details, see
  /// VideoMirrorMode.
  /// 
  /// 
  /// By default, the video is not mirrored.
  ///   
  ///
  VideoMirrorMode? mirrorMode;

  /// Constructs a [VideoEncoderConfiguration]
  VideoEncoderConfiguration({
    this.dimensions,
    this.frameRate,
    this.minFrameRate,
    this.bitrate,
    this.minBitrate,
    this.orientationMode,
    this.degradationPrefer,
    this.mirrorMode,
  });

  /// @nodoc
  factory VideoEncoderConfiguration.fromJson(Map<String, dynamic> json) =>
      _$VideoEncoderConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$VideoEncoderConfigurationToJson(this);
}

///
/// Image enhancement options.
/// 
///
@JsonSerializable(explicitToJson: true)
class BeautyOptions {
  @JsonKey(includeIfNull: false)
  ///
  /// The contrast level. For details, see LighteningContrastLevel.
  ///
  LighteningContrastLevel? lighteningContrastLevel;

  @JsonKey(includeIfNull: false)
  ///
  /// The brightness level. The value ranges from 0.0 (original) to 1.0. The default value is 0.6
  ///
  double? lighteningLevel;

  @JsonKey(includeIfNull: false)
  ///
  /// The smoothness level. The value ranges from 0.0 (original) to 1.0. The default value is 0.5
  ///
  double? smoothnessLevel;

  @JsonKey(includeIfNull: false)
  ///
  /// The redness level. The value ranges from 0.0 (original) to 1.0. The default value is 0.1
  ///
  double? rednessLevel;

  /// Constructs a [BeautyOptions]
  BeautyOptions({
    this.lighteningContrastLevel,
    this.lighteningLevel,
    this.smoothnessLevel,
    this.rednessLevel,
  });

  /// @nodoc
  factory BeautyOptions.fromJson(Map<String, dynamic> json) =>
      _$BeautyOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$BeautyOptionsToJson(this);
}

///
/// Image properties.
/// This class sets the properties of the watermark and background images in the live video.
///
@JsonSerializable(explicitToJson: true)
class AgoraImage {
  ///
  ///
  /// The y coordinate (pixel) of the image on the video frame (taking the upper left corner of the video frame as the origin).
  ///
  /// The HTTP/HTTPS URL address of the image in the live video. The maximum length of this parameter is 1024 bytes.
  ///
  String url;

  @JsonKey(includeIfNull: false)
  int? x;

  @JsonKey(includeIfNull: false)
  int? y;

  int? width;

  ///
  /// The height (pixel) of the image on the video frame.
  ///
  int? height;

  /// Constructs a [AgoraImage]
  AgoraImage(
    this.url, {
    this.x,
    this.y,
    this.width,
    this.height,
  });

  /// @nodoc
  factory AgoraImage.fromJson(Map<String, dynamic> json) =>
      _$AgoraImageFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AgoraImageToJson(this);
}

///
/// Transcoding configurations of each host.
/// 
///
@JsonSerializable(explicitToJson: true)
class TranscodingUser {
  ///
  /// 
  ///   The user ID of the host.
  /// 
  ///
  int uid;

  ///
  ///
  /// 
  /// The height (pixel) of the host's video.
  /// 
  ///
  /// The y coordinate (pixel) of the host's video on the output video frame (taking the upper left corner of the video frame as the origin). The value range is [0, height], where height is the LiveTranscodingheight set in .
  ///
  @JsonKey(includeIfNull: false)
  int? x;

  @JsonKey(includeIfNull: false)
  int? y;

  @JsonKey(includeIfNull: false)
  int? width;

  @JsonKey(includeIfNull: false)
  int? height;

  @JsonKey(includeIfNull: false)
  ///
  /// 
  /// The layer index number of the host's video. The value range is [0, 100].
  /// 0: (Default) The host's video is the bottom layer.
  /// 100: The host's video is the top layer.
  /// 
  /// 
  /// 
  /// 
  /// If the value is beyond this range, the SDK reports the error code ERR_INVALID_ARGUMENT.
  ///
  /// The layer index of the video frame. An integer. The value range is [0, 100]. 1 represents the lowest layer. 100 represents the top layer.
  ///
  /// As of v2.3, the SDK supports setting zOrder to 0.
  /// 
  /// 
  /// 
  ///
  int? zOrder;

  @JsonKey(includeIfNull: false)
  ///
  /// 
  /// The transparency of the host's video. The value range is [0.0, 1.0].
  /// 0.0: Completely transparent.
  /// 1.0: (Default) Opaque.
  /// 
  /// 
  /// 
  ///
  double? alpha;

  @JsonKey(includeIfNull: false)
  ///
  /// 
  /// The audio channel used by the host's audio in the output audio. The default value is 0, and the value range is [0, 5].
  /// 0: (Recommended) The defaut setting, which supports dual channels at most and depends on the upstream of the host.
  /// 1: The host's audio uses the FL audio channel. If the host's upstream uses multiple audio channels, the Agora
  /// server mixes them into mono first.
  /// 2: The host's audio uses the FC audio channel. If the host's upstream uses multiple audio channels, the Agora
  /// server mixes them into mono first.
  /// 3: The host's audio uses the FR audio channel. If the host's upstream uses multiple audio channels, the Agora
  /// server mixes them into mono first.
  /// 4: The host's audio uses the BL audio channel. If the host's upstream uses multiple audio channels, the Agora
  /// server mixes them into mono first.
  /// 5: The host's audio uses the BR audio channel. If the host's upstream uses multiple audio channels, the Agora
  /// server mixes them into mono first.
  /// 0xFF or a value greater than 5: The host's audio is muted, and the Agora
  /// server removes the host's audio.
  /// 
  /// If the value is not 0, a special player is required.
  /// 
  ///
  AudioChannel? audioChannel;

  /// Constructs a [TranscodingUser]
  TranscodingUser(
    this.uid, {
    this.x,
    this.y,
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

///
/// Transcoding configurations for CDN live streaming.
/// 
///
@JsonSerializable(explicitToJson: true)
class LiveTranscoding {
  @JsonKey(includeIfNull: false)
  int? width;

  @JsonKey(includeIfNull: false)
  ///
  /// 
  /// The height of the output media stream in pixels. The default value is 640.
  /// 
  /// When the output media stream is video, ensure that height is set to 64 or higher. Otherwise, the Agora server adjusts the value to 64.
  /// When the output media stream is audio, set height to 0.
  /// 
  /// 
  ///
  int? height;

  @JsonKey(includeIfNull: false)
  ///
  /// The video bitrate (Kbps) of the output media stream. The default value is 400. You can refer to Push Streams to
  /// CND for how to set the parameters.
  ///
  int? videoBitrate;

  @JsonKey(includeIfNull: false)
  VideoFrameRate? videoFramerate;

  @deprecated
  @JsonKey(includeIfNull: false)
  ///
  /// 
  /// 
  /// 
  /// Deprecated
  /// This attribute is deprecated since v2.8.0, and Agora does not recommend it.
  /// 
  /// 
  /// 
  /// true: Low latency with unassured quality.
  /// false: (Default) High latency with assured quality.
  /// 
  /// 
  ///
  bool? lowLatency;

  @JsonKey(includeIfNull: false)
  ///
  /// The video GOP (Group of Pictures) of the output media stream. The default value is 30.
  ///
  int? videoGop;

  @JsonKey(includeIfNull: false)
  ///
  /// The video watermark of the output media stream. Ensure that the format of the watermark image is PNG. For details, see AgoraImage.
  ///
  AgoraImage? watermark;

  @JsonKey(includeIfNull: false)
  ///
  ///  The video background image of the output media stream. For details, see AgoraImage.
  ///
  AgoraImage? backgroundImage;

  @JsonKey(includeIfNull: false)
  ///
  /// The audio sampling rate (Hz) of the output media stream. See AudioSampleRateType.
  ///
  AudioSampleRateType? audioSampleRate;

  @JsonKey(includeIfNull: false)
  ///
  /// The audio bitrate (Kbps) of the output media stream. The default value is 48, and the maximum is 128.
  ///
  int? audioBitrate;

  @JsonKey(includeIfNull: false)
  ///
  /// The number of audio channels of the output media stream. The default value is 1. Agora recommends setting it to 1 or 2.
  /// 1: (Default) Mono
  /// 2: Stereo.
  /// 3: Three audio channels.
  /// 4: Four audio channels.
  /// 5: Five audio channels.
  /// 
  /// 
  ///
  AudioChannel? audioChannels;

  @JsonKey(includeIfNull: false)
  ///
  /// The audio codec of the output media stream. For details, see AudioCodecProfileType.
  ///
  AudioCodecProfileType? audioCodecProfile;

  @JsonKey(includeIfNull: false)
  ///
  /// 
  /// The video encoding configuration of the output media stream. See VideoCodecProfileType.
  /// If you set this parameter to any other value, Agora adjusts it to the default value.
  /// 
  ///
  VideoCodecProfileType? videoCodecProfile;

  @JsonKey(
      includeIfNull: false, fromJson: _$ColorFromJson, toJson: _$ColorToJson)
  ///
  /// The video background color of the output media stream. The format is a hexadecimal integer defined by RGB without the # symbol. For example, 0xFFB6C1
  /// means light pink. The default value is 0x000000 (black).
  ///
  Color? backgroundColor;

  @JsonKey(includeIfNull: false)
  VideoCodecTypeForStream? videoCodecType;

  @JsonKey(includeIfNull: false)
  String? userConfigExtraInfo;

  ///
  /// 
  /// Transcoding configurations of each host. One live streaming channel supports up to 17 hosts. For details, see TranscodingUser.
  /// 
  ///
  List<TranscodingUser> transcodingUsers;

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
    this.videoCodecType,
    this.userConfigExtraInfo,
  });

  /// @nodoc
  factory LiveTranscoding.fromJson(Map<String, dynamic> json) =>
      _$LiveTranscodingFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LiveTranscodingToJson(this);
}

///
/// The definition of 
/// ChannelMediaInfo
/// .
/// 
///
@JsonSerializable(explicitToJson: true)
class ChannelMediaInfo {
  ///
  /// The name of the channel.
  ///
  String channelName;

  @JsonKey(includeIfNull: false)
  ///
  /// The token that enables the user to join the channel.
  ///
  String? token;

  ///
  /// User ID.
  ///
  int uid;

  /// Constructs a [ChannelMediaInfo]
  ChannelMediaInfo(
    this.channelName,
    this.uid, {
    this.token,
  });

  /// @nodoc
  factory ChannelMediaInfo.fromJson(Map<String, dynamic> json) =>
      _$ChannelMediaInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ChannelMediaInfoToJson(this);
}

///
/// The definition of 
/// ChannelMediaRelayConfiguration
/// .
/// 
///
@JsonSerializable(explicitToJson: true)
class ChannelMediaRelayConfiguration {
  ChannelMediaInfo srcInfo;

  List<ChannelMediaInfo> destInfos;

  /// Constructs a [ChannelMediaRelayConfiguration]
  ChannelMediaRelayConfiguration(
    this.srcInfo,
    this.destInfos,
  );

  /// @nodoc
  factory ChannelMediaRelayConfiguration.fromJson(Map<String, dynamic> json) =>
      _$ChannelMediaRelayConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ChannelMediaRelayConfigurationToJson(this);
}

///
/// Configurations of the last-mile network test.
/// 
///
@JsonSerializable(explicitToJson: true)
class LastmileProbeConfig {
  ///
  /// Sets whether to test the uplink network. Some users, for example, the audience members in a LIVE_BROADCASTING channel, do not need such a test.
  ///  true: Test.
  ///  false: Not test.
  /// 
  /// 
  ///   
  ///
  bool probeUplink;

  ///
  /// 
  /// Sets whether to test the downlink network:
  /// true: Test.
  /// false: Not test.
  ///  
  /// 
  ///   
  ///
  bool probeDownlink;

  ///
  /// The expected maximum uplink bitrate (bps) of the local user. The value range is [100000, 5000000]. Agora recommends referring to setVideoEncoderConfiguration to set the value.
  ///
  int expectedUplinkBitrate;

  ///
  /// The expected maximum downlink bitrate (bps) of the local user. The value range is [100000,5000000].
  ///
  int expectedDownlinkBitrate;

  /// Constructs a [LastmileProbeConfig]
  LastmileProbeConfig(
    this.probeUplink,
    this.probeDownlink,
    this.expectedUplinkBitrate,
    this.expectedDownlinkBitrate,
  );

  /// @nodoc
  factory LastmileProbeConfig.fromJson(Map<String, dynamic> json) =>
      _$LastmileProbeConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LastmileProbeConfigToJson(this);
}

///
/// The relative location of the screen-share area to the screen or window. If you do not set this parameter, the SDK shares the whole screen or window.
/// 
///
  ///
  /// The horizontal offset from the top-left corner.
  ///
@JsonSerializable(explicitToJson: true)
class Rectangle {
  ///
  /// The vertical offset from the top-left corner.
  ///
  @JsonKey(includeIfNull: false)
  int? x;

  @JsonKey(includeIfNull: false)
  int? y;

  @JsonKey(includeIfNull: false)
  ///
  /// The width of the shared area.
  ///
  int? width;

  @JsonKey(includeIfNull: false)
  ///
  /// The height of the shared area.
  ///
  int? height;

  /// Constructs a [Rectangle]
  Rectangle({
    this.x,
    this.y,
    this.width,
    this.height,
  });

  /// @nodoc
  factory Rectangle.fromJson(Map<String, dynamic> json) =>
      _$RectangleFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RectangleToJson(this);
}

///
/// Configurations of the watermark image.
/// 
///
@JsonSerializable(explicitToJson: true)
class WatermarkOptions {
  @JsonKey(includeIfNull: false)
  ///
  /// 
  /// Whether the watermark image is visible in the local video preview:
  /// true: (Default) The watermark image is visible in the local preview.
  /// false: The watermark image is not visible in the local preview.
  ///  
  /// 
  ///   
  ///
  bool? visibleInPreview;

  @JsonKey(includeIfNull: false)
  ///
  /// 
  /// The area to display the watermark image in landscape mode. This parameter contains the following members.For details about the landscape mode, see Set the Video Profile.
  ///   
  ///
  Rectangle? positionInLandscapeMode;

  @JsonKey(includeIfNull: false)
  ///
  /// 
  /// The area to display the watermark image in portrait mode.  This parameter contains the following members.For details about the portrait mode, see Set the Video Profile.
  ///   
  ///
  Rectangle? positionInPortraitMode;

  /// Constructs a [WatermarkOptions]
  WatermarkOptions({
    this.visibleInPreview,
    this.positionInLandscapeMode,
    this.positionInPortraitMode,
  });

  /// @nodoc
  factory WatermarkOptions.fromJson(Map<String, dynamic> json) =>
      _$WatermarkOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$WatermarkOptionsToJson(this);
}

///
/// Configurations of injecting an external audio or video stream.
/// Agora will soon stop the service for injecting online media streams on the client. If you have not implemented this service, Agora recommends that you do not use it. For details, see Service Sunset Plans.
///
@JsonSerializable(explicitToJson: true)
class LiveInjectStreamConfig {
  @JsonKey(includeIfNull: false)
  ///
  /// The width of the external video stream after injecting. The default value is 0, which represents the same width as the original.
  ///
  int? width;

  @JsonKey(includeIfNull: false)
  ///
  /// The height of the external video stream after injecting. The default value is 0, which represents the same height as the original.
  ///
  int? height;

  @JsonKey(includeIfNull: false)
  ///
  /// The GOP (in frames) of injecting the external video stream. The default value is 30 frames.
  ///
  int? videoGop;

  @JsonKey(includeIfNull: false)
  ///
  /// The frame rate (fps) of injecting the external video stream. The default rate is 15 fps.
  ///
  VideoFrameRate? videoFramerate;

  @JsonKey(includeIfNull: false)
  ///
  /// 
  /// The bitrate (Kbps) of injecting the external video stream. The default value is 400 Kbps.
  /// The bitrate setting is closely linked to the video resolution. If the bitrate you set is beyond a reasonable range, the SDK sets it within a reasonable range.
  /// 
  ///
  int? videoBitrate;

  @JsonKey(includeIfNull: false)
  ///
  /// The sampling rate (Hz) of injecting the external audio stream. The default value is 48000 Hz. See AudioSampleRateType.
  /// Agora recommends using the default value.
  /// 
  ///
  AudioSampleRateType? audioSampleRate;

  @JsonKey(includeIfNull: false)
  ///
  /// 
  /// The bitrate (Kbps) of injecting the external audio stream. The default value is 48 Kbps.
  /// Agora recommends using the default value.
  /// 
  ///
  int? audioBitrate;

  @JsonKey(includeIfNull: false)
  ///
  /// 
  /// The number of channels of the external audio stream after injecting.
  /// 1:  (Default) Mono.
  /// 2: Stereo.
  /// 
  /// 
  /// Agora recommends using the default value.
  /// 
  ///
  AudioChannel? audioChannels;

  /// Constructs a [LiveInjectStreamConfig]
  LiveInjectStreamConfig({
    this.width,
    this.height,
    this.videoGop,
    this.videoFramerate,
    this.videoBitrate,
    this.audioSampleRate,
    this.audioBitrate,
    this.audioChannels,
  });

  /// @nodoc
  factory LiveInjectStreamConfig.fromJson(Map<String, dynamic> json) =>
      _$LiveInjectStreamConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LiveInjectStreamConfigToJson(this);
}

///
/// The camera capturer preference.
/// 
///
@JsonSerializable(explicitToJson: true)
class CameraCapturerConfiguration {
  @JsonKey(includeIfNull: false)
  ///
  /// The camera capture preference. For details, see CameraCaptureOutputPreference.
  ///
  CameraCaptureOutputPreference? preference;

  @JsonKey(includeIfNull: false)
  ///
  /// 
  /// The width (px) of the video image captured by the local camera. To customize the width of the video image, set preference as Manual(3) first, and then use captureWidth to set the video width.
  /// 
  ///
  int? captureWidth;

  @JsonKey(includeIfNull: false)
  ///
  /// 
  /// The height (px) of the video image captured by the local camera. To customize the height of the video image, set preference as Manual(3) first, and then use captureHeight.
  /// 
  ///
  int? captureHeight;

  @JsonKey(includeIfNull: false)
  ///
  /// 
  /// This parameter applies to Android and iOS only.
  /// The camera direction. For details, see CameraDirection.
  /// The camera direction.
  /// Rear (0): Use the rear camera.
  /// Front (1): Use the front camera.
  /// 
  ///   
  ///
  CameraDirection? cameraDirection;

  /// Constructs a [CameraCapturerConfiguration]
  CameraCapturerConfiguration({
    this.preference,
    this.captureWidth,
    this.captureHeight,
    this.cameraDirection,
  });

  /// @nodoc
  factory CameraCapturerConfiguration.fromJson(Map<String, dynamic> json) =>
      _$CameraCapturerConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$CameraCapturerConfigurationToJson(this);
}

///
/// The channel media options.
/// 
///
@JsonSerializable(explicitToJson: true)
class ChannelMediaOptions {
  @JsonKey(includeIfNull: false)
  ///
  /// Whether to automatically subscribe to all remote audio streams when the user joins a channel:
  /// true: (Default) Subscribe.
  /// false: Do not subscribe.
  ///   This member serves a similar function to the muteAllRemoteAudioStreams method. After joining the channel, you can call the muteAllRemoteAudioStreams method to set whether to subscribe to audio streams in the channel.
  ///
  bool? autoSubscribeAudio;

  @JsonKey(includeIfNull: false)
  bool? autoSubscribeVideo;

  @JsonKey(includeIfNull: false)
  bool? publishLocalAudio;

  @JsonKey(includeIfNull: false)
  bool? publishLocalVideo;

  /// Constructs a [ChannelMediaOptions]
  ChannelMediaOptions({
    this.autoSubscribeAudio,
    this.autoSubscribeVideo,
    this.publishLocalAudio,
    this.publishLocalVideo,
  });

  /// @nodoc
  factory ChannelMediaOptions.fromJson(Map<String, dynamic> json) =>
      _$ChannelMediaOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ChannelMediaOptionsToJson(this);
}

///
/// Configurations of built-in encryption.
/// 
///
@JsonSerializable(explicitToJson: true)
class EncryptionConfig {
  @JsonKey(includeIfNull: false)
  ///
  /// The built-in encryption mode. Agora recommends using AES128GCM2 or AES256GCM2 encrypted mode. These two modes support the use of salt for higher security.
  /// SM4128ECB (4): 128-bit SM4 encryption, ECB mode.
  ///
  /// 
  /// Salt, 32 bytes in length. Agora recommends that you use OpenSSL to generate salt on the server side, see Media Stream Encryption for details.
  /// This parameter takes effect only in AES128GCM2 or AES256GCM2 encrypted mode. In this case, ensure that this parameter is not 0.
  /// 
  ///
  /// AES128GCM2 (7): (Default) 128-bit AES encryption, GCM mode. This encryption mode requires the setting of salt (encryptionKdfSalt).
  /// AES256GCM2 (8): 256-bit AES encryption, GCM mode. This encryption mode requires the setting of salt (encryptionKdfSalt).
  /// (9): Enumeration value boundary.
  /// 
  ///   
  ///
  EncryptionMode? encryptionMode;

  @JsonKey(includeIfNull: false)
  ///
  /// 
  /// Encryption key in string type.
  /// If you do not set an encryption key or set it as NULL, you cannot use the built-in encryption, and the SDK returns ERR_INVALID_ARGUMENT (-2).
  ///   
  ///
  String? encryptionKey;

  @JsonKey(includeIfNull: false)
  List<int>? encryptionKdfSalt;

  /// Constructs a [EncryptionConfig]
  EncryptionConfig({
    this.encryptionMode,
    this.encryptionKey,
    this.encryptionKdfSalt,
  });

  /// @nodoc
  factory EncryptionConfig.fromJson(Map<String, dynamic> json) =>
      _$EncryptionConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$EncryptionConfigToJson(this);
}

///
/// Statistics of a call session.
/// 
///
@JsonSerializable(explicitToJson: true)
class RtcStats {
  int duration;

  ///
  /// The number of bytes sent.
  ///
  int txBytes;

  ///
  /// The number of bytes received.
  ///
  int rxBytes;

  ///
  /// The total number of audio bytes sent, represented by an aggregate value.
  ///
  int txAudioBytes;

  ///
  /// The total number of video bytes sent, represented by an aggregate value.
  ///
  int txVideoBytes;

  ///
  /// The total number of audio bytes received, represented by an aggregate value.
  ///
  int rxAudioBytes;

  ///
  /// The total number of video bytes received, represented by an aggregate value.
  ///
  int rxVideoBytes;

  ///
  /// Video transmission bitrate (Kbps), represented by an instantaneous value.
  ///
  int txKBitRate;

  ///
  /// The receiving bitrate (Kbps), represented by an instantaneous value.
  ///
  int rxKBitRate;

  ///
  /// The bitrate (Kbps) of sending the audio packet.
  ///
  int txAudioKBitRate;

  ///
  /// Audio receive bitrate (Kbps), represented by an instantaneous value.
  ///
  int rxAudioKBitRate;

  ///
  /// The bitrate (Kbps) of sending the video.
  ///
  int txVideoKBitRate;

  ///
  /// Video receive bitrate (Kbps), represented by an instantaneous value.
  ///
  int rxVideoKBitRate;

  int userCount;

  ///
  /// The client-to-server delay (milliseconds).
  ///
  int lastmileDelay;

  ///
  /// The packet loss rate (%) from the client to the Agora server before applying the anti-packet-loss algorithm.
  ///
  int txPacketLossRate;

  ///
  /// The packet loss rate (%) from the Agora server to the client before using the anti-packet-loss method.
  ///
  int rxPacketLossRate;

  ///
  /// 
  /// The system CPU usage (%).
  /// The value of cpuTotalUsage is always reported as 0 in the leaveChannel callback.
  /// 
  ///
  double cpuTotalUsage;

  ///
  /// The CPU usage (%) of the app.
  ///
  double cpuAppUsage;

  ///
  /// The round-trip time delay (ms) from the client to the local router.
  /// As of v3.3.0, this property is disabled on devices running iOS 14 or later, and enabled on devices running versions earlier than iOS 14 by default. 
  /// This property is disabled on devices running iOS 14 or later, and enabled on devices running versions earlier than iOS 14 by default.
  /// To enable this property on devices running iOS 14 or later, contact support@agora.io (https://agora-ticket.agora.io/). 
  /// 
  /// 
  /// To get gatewayRtt, ensure that you add the android.permission.ACCESS_WIFI_STATE permission after </application> in the project AndroidManifest.xml file.
  /// 
  ///
  int gatewayRtt;

  ///
  /// 
  /// The memory ratio occupied by the app (%).
  /// This value is for reference only. Due to system limitations, you may not get this value.
  /// 
  ///
  double memoryAppUsageRatio;

  ///
  /// 
  /// The memory occupied by the system (%).
  /// This value is for reference only. Due to system limitations, you may not get this value.
  /// 
  ///
  double memoryTotalUsageRatio;

  ///
  /// 
  /// The memory size occupied by the app (KB).
  /// This value is for reference only. Due to system limitations, you may not get this value.
  /// 
  ///
  int memoryAppUsageInKbytes;

  /// Constructs a [RtcStats]
  RtcStats(
    this.duration,
    this.txBytes,
    this.rxBytes,
    this.txAudioBytes,
    this.txVideoBytes,
    this.rxAudioBytes,
    this.rxVideoBytes,
    this.txKBitRate,
    this.rxKBitRate,
    this.txAudioKBitRate,
    this.rxAudioKBitRate,
    this.txVideoKBitRate,
    this.rxVideoKBitRate,
    this.userCount,
    this.lastmileDelay,
    this.txPacketLossRate,
    this.rxPacketLossRate,
    this.cpuTotalUsage,
    this.cpuAppUsage,
    this.gatewayRtt,
    this.memoryAppUsageRatio,
    this.memoryTotalUsageRatio,
    this.memoryAppUsageInKbytes,
  );

  /// @nodoc
  factory RtcStats.fromJson(Map<String, dynamic> json) =>
      _$RtcStatsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RtcStatsToJson(this);
}

///
  ///
  /// The number of users in the channel.
  ///
/// The volume information of users.
/// 
///
@JsonSerializable(explicitToJson: true)
class AudioVolumeInfo {
  ///
  /// 
  /// User ID.
  /// In the local user's callback, uid = 0.
  ///
  /// The volume of the user. The value ranges between 0 (lowest volume) and 255 (highest volume). If the user calls startAudioMixing, the value of volume is the volume after audio mixing.
  ///
  /// In the remote users' callback, uid is the ID of a remote user whose instantaneous volume is one of the three highest.
  /// ID.
  /// 
  /// 
  ///
  int uid;

  int volume;

  ///
  /// 
  /// Voice activity status of the local user.
  /// 0: The local user is not speaking.
  /// 1: The local user is speaking.
  /// 
  /// 
  /// 
  /// The vad parameter does not report the voice activity status of remote users. In the remote users' callback, the value of vad is always 0.
  /// To use this parameter, you must set reportVad to true when calling enableAudioVolumeIndication.
  /// 
  /// 
  /// 
  ///
  int vad;

  String channelId;

  /// Constructs a [AudioVolumeInfo]
  AudioVolumeInfo(
    this.uid,
    this.volume,
    this.vad,
    this.channelId,
  );

  /// @nodoc
  factory AudioVolumeInfo.fromJson(Map<String, dynamic> json) =>
      _$AudioVolumeInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AudioVolumeInfoToJson(this);
}

///
/// The screen sharing region.
/// Deprecated:
///   This class is deprecated. Please use the updateScreenCaptureRegion method to update the shared area.
///
@JsonSerializable(explicitToJson: true)
class Rect {
  @JsonKey(includeIfNull: false)
  @Deprecated('This property is deprecated, pls use x instead.')
  ///
  /// The coordinate of the left side of the shared area on the horizontal axis.
  ///
  int? left;

  @JsonKey(includeIfNull: false)
  @Deprecated('This property is deprecated, pls use y instead.')
  ///
  /// The coordinate of the top side of the shared area on the vertical axis.
  ///
  int? top;

  @JsonKey(includeIfNull: false)
  @Deprecated('This property is deprecated, pls use x + width instead.')
  ///
  /// The coordinate of the right side of the shared area on the horizontal axis.
  ///
  int? right;

  @JsonKey(includeIfNull: false)
  @Deprecated('This property is deprecated, pls use y + height instead.')
  ///
  /// The coordinate of the bottom side of the shared area on the vertical axis.
  ///
  int? bottom;

  int x;

  int y;

  int width;

  int height;

  /// Constructs a [Rect]
  Rect({
    this.x = 0,
    this.y = 0,
    this.width = 0,
    this.height = 0,
    this.left,
    this.top,
    this.right,
    this.bottom,
  });

  /// @nodoc
  factory Rect.fromJson(Map<String, dynamic> json) => _$RectFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RectToJson(this);
}

///
/// Results of the uplink or downlink last-mile network test.
/// 
///
@JsonSerializable(explicitToJson: true)
class LastmileProbeOneWayResult {
  ///
  /// The packet loss rate (%).
  ///
  int packetLossRate;

  ///
  /// The network jitter (ms).
  ///
  int jitter;

  ///
  /// The estimated available bandwidth (bps).
  ///
  int availableBandwidth;

  /// Constructs a [LastmileProbeOneWayResult]
  LastmileProbeOneWayResult(
    this.packetLossRate,
    this.jitter,
    this.availableBandwidth,
  );

  /// @nodoc
  factory LastmileProbeOneWayResult.fromJson(Map<String, dynamic> json) =>
      _$LastmileProbeOneWayResultFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LastmileProbeOneWayResultToJson(this);
}

///
/// Results of the uplink and downlink last-mile network tests.
/// 
///
@JsonSerializable(explicitToJson: true)
class LastmileProbeResult {
  ///
  /// The status of the last-mile network tests, which includes:
  /// Complete (1): The last-mile
  /// network probe test is complete. 
  /// IncompleteNoBwe (2): The
  /// last-mile network probe test is incomplete because the bandwidth estimation is not available, probably due to limited test resources.
  /// Unavailable (3): The
  /// last-mile network probe test is not carried out, probably due to poor network conditions.
  /// 
  /// 
  /// 
  ///
  LastmileProbeResultState state;

  ///
  /// The round-trip time (ms).
  ///
  int rtt;

  ///
  /// Results of the uplink last-mile network test. For details, see LastmileProbeOneWayResult.
  ///
  LastmileProbeOneWayResult uplinkReport;

  ///
  /// Results of the downlink last-mile network test. For details, see LastmileProbeOneWayResult.
  ///
  LastmileProbeOneWayResult downlinkReport;

  /// Constructs a [LastmileProbeResult]
  LastmileProbeResult(
    this.state,
    this.rtt,
    this.uplinkReport,
    this.downlinkReport,
  );

  /// @nodoc
  factory LastmileProbeResult.fromJson(Map<String, dynamic> json) =>
      _$LastmileProbeResultFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LastmileProbeResultToJson(this);
}

///
/// Local audio statistics.
/// 
///
@JsonSerializable(explicitToJson: true)
class LocalAudioStats {
  ///
  /// The number of audio channels.
  ///
  int numChannels;

  ///
  /// The sampling rate (Hz) of sending the local user's audio stream.
  ///
  int sentSampleRate;

  ///
  /// The average bitrate (Kbps) of sending the local user's audio stream.
  ///
  int sentBitrate;

  ///
  /// The packet loss rate (%) from the local client to the Agora server before applying the anti-packet loss strategies.
  ///
  int txPacketLossRate;

  /// Constructs a [LocalAudioStats]
  LocalAudioStats(
    this.numChannels,
    this.sentSampleRate,
    this.sentBitrate,
    this.txPacketLossRate,
  );

  /// @nodoc
  factory LocalAudioStats.fromJson(Map<String, dynamic> json) =>
      _$LocalAudioStatsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LocalAudioStatsToJson(this);
}

///
/// The statistics of the local video stream.
/// 
///
@JsonSerializable(explicitToJson: true)
class LocalVideoStats {
  ///
  /// 
  /// The actual bitrate (Kbps) for sending the local video stream.This value does not include the bitrate for resending the video after packet loss.
  ///   
  ///
  int sentBitrate;

  ///
  /// The actual frame rate (Kbps) while sending the local video stream.This value does not include the frame rate for resending the video after packet loss.
  ///
  int sentFrameRate;

  ///
  /// The output frame rate (fps) of the local video encoder.
  ///
  int encoderOutputFrameRate;

  ///
  /// The output frame rate (fps) of the local video renderer.
  ///
  int rendererOutputFrameRate;

  ///
  /// The target bitrate (Kbps) of the current encoder. This is an estimate made by the SDK based on the current network conditions.
  ///
  int targetBitrate;

  ///
  /// The target frame rate (fps) of the current encoder.
  ///
  int targetFrameRate;

  ///
  /// 
  /// For details, see VideoQualityAdaptIndication.
  ///
  VideoQualityAdaptIndication qualityAdaptIndication;

  ///
  /// 
  /// The bitrate (Kbps) for encoding the local video stream.This value does not include the bitrate for resending the video after packet loss.
  ///   
  ///
  int encodedBitrate;

  ///
  /// The width of the encoded video (px).
  ///
  int encodedFrameWidth;

  ///
  /// The height of the encoded video (px).
  ///
  int encodedFrameHeight;

  ///
  /// The number of the sent video frames, represented by an aggregate value.
  ///
  int encodedFrameCount;

  ///
  /// The codec type of the local video. 
  /// 
  /// VP8 (1): VP8.
  /// H264 (2): (Default) H.264.
  /// 
  /// 
  /// 
  ///
  VideoCodecType codecType;

  ///
  /// The video packet loss rate (%) from the local client to the Agora server before applying the anti-packet loss strategies.
  ///
  int txPacketLossRate;

  int captureFrameRate;

  ///
  /// 
  /// 
  /// 
  /// Since
  /// v3.3.0
  /// 
  /// 
  /// The brightness level of the video image captured by the local camera. For details, see CaptureBrightnessLevelType.
  /// 
  ///
  CaptureBrightnessLevelType captureBrightnessLevel;

  /// Constructs a [LocalVideoStats]
  LocalVideoStats(
    this.sentBitrate,
    this.sentFrameRate,
    this.encoderOutputFrameRate,
    this.rendererOutputFrameRate,
    this.targetBitrate,
    this.targetFrameRate,
    this.qualityAdaptIndication,
    this.encodedBitrate,
    this.encodedFrameWidth,
    this.encodedFrameHeight,
    this.encodedFrameCount,
    this.codecType,
    this.txPacketLossRate,
    this.captureFrameRate,
    this.captureBrightnessLevel,
  );

  /// @nodoc
  factory LocalVideoStats.fromJson(Map<String, dynamic> json) =>
      _$LocalVideoStatsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LocalVideoStatsToJson(this);
}

///
/// Audio statistics of the remote user.
/// 
///
@JsonSerializable(explicitToJson: true)
class RemoteAudioStats {
  ///
  /// The ID of the remote user.
  ///
  int uid;

  ///
  /// The quality of the audio stream sent by the user.  
  /// 
  /// Unknown (0): The quality is unknown.
  /// Excellent (1): The quality is excellent.
  /// Good (2): The network quality is quite good, but the bitrate may be slightly lower than excellent.
  /// Poor (3): Users can feel the communication slightly impaired.
  /// Bad (4): Users cannot communicate smoothly.
  /// VBad (5): The quality is so bad that users can barely communicate.
  /// Down (6): The quality is down and users cannot communicate at all.
  /// 
  /// 
  /// 
  ///
  NetworkQuality quality;

  ///
  /// The network delay (ms) from the sender to the receiver.
  ///
  int networkTransportDelay;

  ///
  /// 
  /// The network delay (ms) from the receiver to the jitter buffer.This parameter does not take effect if the receiver is an audience member and AudienceLatencyLevelType is 1.
  ///   
  ///
  int jitterBufferDelay;

  ///
  /// The frame loss rate (%) of the remote audio stream in the reported interval.
  ///
  int audioLossRate;

  ///
  /// The number of audio channels.
  ///
  int numChannels;

  ///
  /// The sampling rate of the received audio stream in the reported interval.
  ///
  int receivedSampleRate;

  ///
  /// The average bitrate (Kbps) of the received audio stream in the reported interval.
  ///
  int receivedBitrate;

  ///
  /// The total freeze time (ms) of the remote audio stream after the remote user joins the channel. In a session, audio freeze occurs when the audio frame loss rate reaches 4%.
  ///
  int totalFrozenTime;

  ///
  /// The total audio freeze time as a percentage (%) of the total time when the audio is available. The audio is available means that the remote user neither stops sending the audio stream nor disables the audio module after joining the channel.
  ///
  int frozenRate;

  ///
  /// 
  /// The total active time (ms) between the start of the audio call and the callback of the remote user.
  /// The active time refers to the total duration of the remote user without the mute state.
  ///
  int totalActiveTime;

  ///
  /// 
  /// The total duration (ms) of the remote audio stream.
  ///
  int publishDuration;

  ExperienceQualityType qoeQuality;

  ///
  /// 
  /// 
  ///  
  /// Since
  /// v3.3.0
  ///  
  /// 
  /// The reason for poor QoE of the local user when receiving the remote audio stream. See ExperiencePoorReason.
  ///   
  ///
  ExperiencePoorReason qualityChangedReason;

  ///
  /// 
  /// The quality of the remote audio stream in the reported interval. The quality is determined by the Agora real-time audio MOS (Mean Opinion Score) measurement method. The return value range is [0, 500]. Dividing the return value by 100 gets the MOS score, which ranges from 0 to 5. The higher the score, the better the audio quality.
  /// 
  /// The subjective perception of audio quality corresponding to the Agora real-time audio MOS scores is as follows:
  /// 
  /// MOS score
  /// Perception of audio quality
  /// 
  /// 
  /// Greater than 4
  /// Excellent. The audio sounds clear and smooth.
  /// 
  /// 
  /// From 3.5 to 4
  /// Good. The audio has some perceptible impairment but still sounds clear.
  /// 
  /// 
  /// From 3 to 3.5
  /// Fair. The audio freezes occasionally and requires attentive listening.
  /// 
  /// 
  /// From 2.5 to 3
  /// Poor. The audio sounds choppy and requires considerable effort to understand.
  /// 
  /// 
  /// From 2 to 2.5
  /// Bad. The audio has occasional noise. Consecutive audio dropouts occur, resulting in some information loss. The users can communicate only with difficulty.
  /// 
  /// 
  /// Less than 2
  /// Very bad. The audio has persistent noise. Consecutive audio dropouts are frequent, resulting in severe information loss. Communication is nearly impossible.
  /// 
  /// 
  /// 
  ///
  int mosValue;

  /// Constructs a [RemoteAudioStats]
  RemoteAudioStats(
    this.uid,
    this.quality,
    this.networkTransportDelay,
    this.jitterBufferDelay,
    this.audioLossRate,
    this.numChannels,
    this.receivedSampleRate,
    this.receivedBitrate,
    this.totalFrozenTime,
    this.frozenRate,
    this.totalActiveTime,
    this.publishDuration,
    this.qoeQuality,
    this.qualityChangedReason,
    this.mosValue,
  );

  /// @nodoc
  factory RemoteAudioStats.fromJson(Map<String, dynamic> json) =>
      _$RemoteAudioStatsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RemoteAudioStatsToJson(this);
}

///
/// Statistics of the remote video stream.
/// 
///
@JsonSerializable(explicitToJson: true)
class RemoteVideoStats {
  ///
  /// The user ID of the remote user sending the video stream.
  ///
  int uid;

  @deprecated
  ///
  /// 
  /// 
  ///  
  /// Deprecated:
  /// In scenarios where audio and video are synchronized, you can get the video  delay data from networkTransportDelay and jitterBufferDelay in RemoteAudioStats.
  ///  
  /// 
  /// The video delay (ms).
  ///   
  ///
  int delay;

  ///
  /// The width (pixels) of the video.
  ///
  int width;

  ///
  /// The height (pixels) of the video.
  ///
  int height;

  ///
  /// The bitrate (Kbps) of receiving the remote video since the last count.
  ///
  int receivedBitrate;

  ///
  /// The frame rate (fps) of decoding the remote video.
  ///
  int decoderOutputFrameRate;

  ///
  /// The frame rate (fps) of rendering the remote video.
  ///
  int rendererOutputFrameRate;

  ///
  /// The packet loss rate (%) of the remote video after using the anti-packet-loss technology.
  ///
  int packetLossRate;

  ///
  /// The type of the video stream. 
  /// 
  /// High (0): High-quality stream, that is, high-resolution and high-bitrate video stream.
  /// Low (1): Low-quality stream, that is, low-resolution and low-bitrate video stream.
  /// 
  /// 
  /// 
  ///
  VideoStreamType rxStreamType;

  ///
  /// The total freeze time (ms) of the remote video stream after the remote user joins the channel. In a video session where the frame rate is set to 5 fps or higher, video freeze occurs when the time interval between two adjacent video frames is more than 500
  /// ms.
  ///
  int totalFrozenTime;

  ///
  /// The total video freeze time as a percentage (%) of the total time when the video is available. The video is available means that the remote user neither stops sending the video stream nor disables the video module after joining the channel.
  ///
  int frozenRate;

  ///
  /// 
  /// Total active time (ms) of the video.
  /// When the remote user/host neither stops sending the video stream nor disables the video module after joining the channel, the video is available.
  ///
  int totalActiveTime;

  ///
  /// 
  /// The total duration (ms) of the remote video stream.
  ///
  int publishDuration;

  /// Constructs a [RemoteVideoStats]
  RemoteVideoStats(
    this.uid,
    this.delay,
    this.width,
    this.height,
    this.receivedBitrate,
    this.decoderOutputFrameRate,
    this.rendererOutputFrameRate,
    this.packetLossRate,
    this.rxStreamType,
    this.totalFrozenTime,
    this.frozenRate,
    this.totalActiveTime,
    this.publishDuration,
  );

  /// @nodoc
  factory RemoteVideoStats.fromJson(Map<String, dynamic> json) =>
      _$RemoteVideoStatsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RemoteVideoStatsToJson(this);
}

///
/// The information of the detected human face.
/// 
///
  ///
  /// 
  /// The x coordinate (px) of the human face in the local video. Taking the top left corner of the captured video as the origin, the x coordinate represents the relative lateral displacement of the top left corner of the human face to the origin.
  /// 
  ///
@JsonSerializable(explicitToJson: true)
class FacePositionInfo {
  int x;

  ///
  /// 
  /// The y coordinate (px) of the human face in the local video. Taking the top left corner of the captured video as the origin, the y coordinate represents the relative longitudinal displacement of the top left corner of the human face to the origin.
  /// 
  ///
  int y;

  ///
  /// 
  /// The width (px) of the human face in the captured video.
  /// 
  ///
  int width;

  ///
  /// 
  /// The height (px) of the human face in the captured video.
  /// 
  ///
  int height;

  ///
  /// 
  /// The distance between the human face and the device screen (cm).
  /// 
  ///
  int distance;

  /// Constructs a [FacePositionInfo]
  FacePositionInfo(
    this.x,
    this.y,
    this.width,
    this.height,
    this.distance,
  );

  /// @nodoc
  factory FacePositionInfo.fromJson(Map<String, dynamic> json) =>
      _$FacePositionInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$FacePositionInfoToJson(this);
}

///
/// The detailed options of a user.
/// 
///
@JsonSerializable(explicitToJson: true)
class ClientRoleOptions {
  @JsonKey(includeIfNull: false)
  ///
  /// The latency level of an audience member in interactive live streaming. For details, see AudienceLatencyLevelType.
  ///
  AudienceLatencyLevelType? audienceLatencyLevel;

  /// Constructs a [ClientRoleOptions]
  ClientRoleOptions({
    this.audienceLatencyLevel,
  });

  /// @nodoc
  factory ClientRoleOptions.fromJson(Map<String, dynamic> json) =>
      _$ClientRoleOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ClientRoleOptionsToJson(this);
}

///
/// The configuration of the SDK log files.
/// 
///
@JsonSerializable(explicitToJson: true)
class LogConfig {
  @JsonKey(includeIfNull: false)
  ///
  /// 
  /// The absolute or relative path of the log file, which ends with \ or /. Ensure that the path for the log file exists and is writable. You can use this parameter to rename the log files.
  /// The default file path is:
  /// /storage/emulated/0/Android/data/<package
  /// name>/files/agorasdk.log/.
  /// The default file path is:
  /// If Sandbox is enabled: App
  /// Sandbox/Library/Logs/agorasdk.log/. For example, 
  /// /Users/<username>/Library/Containers/<App
  /// Bundle
  /// Identifier>/Data/Library/Logs/agorasdk.log/.
  /// If Sandbox is disabled: ~/Library/Logs/agorasdk.log
  /// 
  /// 
  /// 
  ///
  String? filePath;

  @JsonKey(includeIfNull: false)
  ///
  /// The size (KB) of a log file. The default value is 2014 KB. If you set fileSize to 1024 KB, the maximum aggregate size of the log files output by the SDK is 5 MB. If you set fileSize to less than 1024 KB, the setting is invalid, and the maximum size of a log file is still 1024 KB.
  ///
  int? fileSize;

  @JsonKey(includeIfNull: false)
  ///
  /// The output level of the SDK log file. See LogLevel.
  ///
  LogLevel? level;

  /// Constructs a [LogConfig]
  LogConfig({
    this.filePath,
    this.fileSize,
    this.level,
  });

  /// @nodoc
  factory LogConfig.fromJson(Map<String, dynamic> json) =>
      _$LogConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LogConfigToJson(this);
}

///
/// The configurations for the data stream.
/// The following table shows the SDK behaviors under different parameter settings:
///
@JsonSerializable(explicitToJson: true)
class DataStreamConfig {
  ///
  /// 
  /// Whether to synchronize the data packet with the published audio packet.
  /// true: Synchronize the data packet with the audio packet.
  /// false: Do not synchronize the data packet with the audio packet.
  /// When you set the data packet to synchronize with the audio, then if the data packet delay is within the audio delay, the SDK triggers the streamMessage callback when the synchronized audio packet is played out. Do not set this parameter as true if you need the receiver to receive the data packet immediately. Agora recommends that you set this parameter to `true` only when you need to implement specific functions, for example lyric synchronization.
  /// 
  ///
  bool syncWithAudio;

  ///
  /// 
  /// Whether the SDK guarantees that the receiver receives the data in the sent order.
  /// true: Guarantee that the receiver receives the data in the sent order.
  /// false: Do not guarantee that the receiver receives the data in the sent order.
  /// Do not set this parameter as true if you need the receiver to receive the data packet immediately.
  /// 
  ///
  bool ordered;

  /// Constructs a [DataStreamConfig]
  DataStreamConfig(
    this.syncWithAudio,
    this.ordered,
  );

  /// @nodoc
  factory DataStreamConfig.fromJson(Map<String, dynamic> json) =>
      _$DataStreamConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$DataStreamConfigToJson(this);
}

/* class-RtcEngineConfig */
@JsonSerializable(explicitToJson: true)
@deprecated
class RtcEngineConfig extends RtcEngineContext {
  /// Constructs a [RtcEngineConfig]
  RtcEngineConfig(String appId,
      {List<AreaCode>? areaCode, LogConfig? logConfig})
      : super(appId, areaCode: areaCode, logConfig: logConfig);
}

///
/// Configurations of initializing the SDK.
/// 
///
@JsonSerializable(explicitToJson: true)
class RtcEngineContext {
  ///
  /// The App ID issued by Agora for your app development project. Only users who use the same App ID can join the same channel and communicate with each other.
  /// An App ID can only be used to create one RtcEngineinstance. If you need to change the App ID, you must call destroy to destroy the current IRtcEngine, and then call create and createWithContext to recreate RtcEngine.
  /// An App ID can only be used to create one RtcEngineinstance. If you need to change the App ID, you
  /// must call destroy destroy the current IRtcEngine, and
  /// then call createWithContext to recreate RtcEngine.
  ///   
  ///
  String appId;

  @JsonKey(includeIfNull: false, toJson: _$AreaCodeListToJson)
  ///
  /// The region for connection. This advanced feature applies to scenarios that have regional restrictions. See AreaCode for details about supported regions.
  ///   After specifying the region, the SDK connects to the Agora servers within that region.
  ///
  List<AreaCode>? areaCode;

  @JsonKey(includeIfNull: false)
  ///
  /// The configuration of the log files. See LogConfig.
  ///   By default, the SDK outputs five log files: agorasdk.log, agorasdk_1.log, agorasdk_2.log, agorasdk_3.log, and agorasdk_4.log.
  ///   Each log file has a default size of 512 KB and is encoded in UTF-8 format. The SDK writes the latest log in agorasdk.log. When agorasdk.log is full, the SDK deletes the log file with the earliest modification time among the other four, renames agorasdk.log to the name of the deleted log file, and create a new agorasdk.log to record the latest  log.
  ///
  LogConfig? logConfig;

  /// Constructs a [RtcEngineContext]
  RtcEngineContext(
    this.appId, {
    this.areaCode,
    this.logConfig,
  });

  /// @nodoc
  factory RtcEngineContext.fromJson(Map<String, dynamic> json) =>
      _$RtcEngineContextFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RtcEngineContextToJson(this);

  static int? _$AreaCodeListToJson(List<AreaCode>? instance) {
    if (instance == null) return null;
    var areaCode = 0;
    instance.forEach((element) {
      areaCode |= AreaCodeConverter(element).value();
    });
    return areaCode;
  }
}

///
/// The metronome configuration.
/// The metronome configuration, which is set in startRhythmPlayer or configRhythmPlayer.
///
@JsonSerializable(explicitToJson: true)
class RhythmPlayerConfig {
  @JsonKey(includeIfNull: false)
  ///
  /// The number of beats per measure. The value range is [1,9]. The default value is 4, which means that each measure contains one downbeat and three upbeats.
  ///
  int? beatsPerMeasure;

  @JsonKey(includeIfNull: false)
  ///
  /// The beat speed (beats/minute), which range from 60 to 360. The default value is 60, which means that the metronome plays 60 beats in one minute.
  ///
  int? beatsPerMinute;

  @JsonKey(includeIfNull: false)
  ///
  /// Whether to publish the sound of the metronome to remote users:
  /// true: (Default) Resumes publishing the local audio stream. Both the local user and remote users can hear the audio effect.
  /// false: Do not publish the audio effect. Only the local user can hear the audio effect.
  /// 
  ///
  bool? publish;

  /// Constructs a [RhythmPlayerConfig]
  RhythmPlayerConfig({
    this.beatsPerMeasure,
    this.beatsPerMinute,
    this.publish,
  });

  /// @nodoc
  factory RhythmPlayerConfig.fromJson(Map<String, dynamic> json) =>
      _$RhythmPlayerConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RhythmPlayerConfigToJson(this);
}

///
/// The configuration of audio recording on the app client.
/// 
///
@JsonSerializable(explicitToJson: true)
class AudioRecordingConfiguration {
  ///
  /// 
  /// The absolute path (including the filename extensions) of the recording file. For example: C:\music\audio.aac.
  /// Ensure that the directory for the log files exists and is writable.
  /// 
  ///
  String filePath;

  @JsonKey(includeIfNull: false)
  ///
  /// Recording quality. For details, see AudioRecordingQuality.
  /// Note: This parameter applies to AAC files only.
  ///
  AudioRecordingQuality? recordingQuality;

  @JsonKey(includeIfNull: false)
  ///
  /// The recording content. For details, see AudioRecordingPosition.
  ///
  AudioRecordingPosition? recordingPosition;

  @JsonKey(includeIfNull: false)
  ///
  /// Recording sample rate (Hz).
  /// 16000
  /// (Default) 32000
  /// 44100
  /// 48000
  /// 
  /// If you set this parameter as 44100 or 48000, Agora recommends recording WAV files or AAV files whose recordingQuality is Medium or High for better recording quality.
  ///
  AudioSampleRateType? recordingSampleRate;

  /// Constructs a [AudioRecordingConfiguration]
  AudioRecordingConfiguration(
    this.filePath, {
    this.recordingQuality,
    this.recordingPosition,
    this.recordingSampleRate,
  });

  /// @nodoc
  factory AudioRecordingConfiguration.fromJson(Map<String, dynamic> json) =>
      _$AudioRecordingConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AudioRecordingConfigurationToJson(this);
}

///
/// Since
/// v3.5.0
///
@JsonSerializable(explicitToJson: true)
class VirtualBackgroundSource {
  @JsonKey(includeIfNull: false)
  VirtualBackgroundSourceType? backgroundSourceType;

  @JsonKey(
      includeIfNull: false, fromJson: _$ColorFromJson, toJson: _$ColorToJson)
  ///
  /// The type of the custom background image. The color of the custom background image. The format is a hexadecimal integer defined by RGB, without the # sign, such as 0xFFB6C1 for light pink.The default value is 0xFFFFFF, which signifies white. 
  /// The value range is [0x000000, 0xffffff]. If the value is invalid, the SDK replaces the original background image with a white background image.This parameter takes effect only when the type of the custom background image is .
  ///
  Color? color;

  @JsonKey(includeIfNull: false)
  ///
  /// The local absolute path of the custom background image. PNG and JPG formats are supported. If the path is invalid, the SDK replaces the original background image with a white background image.This parameter takes effect only when the type of the custom background image is .
  ///
  String? source;

  ///
  /// The degree of blurring applied to the custom background image. See . The default degree of blurring is .This parameter takes effect only when the type of the custom background image is .
  ///
  @JsonKey(name: 'blur_degree')
  VirtualBackgroundBlurDegree blurDegree;

  /// Constructs a [VirtualBackgroundSource]
  VirtualBackgroundSource({
    this.backgroundSourceType,
    this.color,
    this.source,
    this.blurDegree = VirtualBackgroundBlurDegree.High,
  });

  /// @nodoc
  factory VirtualBackgroundSource.fromJson(Map<String, dynamic> json) =>
      _$VirtualBackgroundSourceFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$VirtualBackgroundSourceToJson(this);
}

/* class-AudioFileInfo */
@JsonSerializable(explicitToJson: true)
class AudioFileInfo {
  @JsonKey()
  String filePath;

  @JsonKey()
  int durationMs;

  /// Construct the [AudioFileInfo]
  AudioFileInfo({
    required this.filePath,
    required this.durationMs,
  });

  /// @nodoc
  factory AudioFileInfo.fromJson(Map<String, dynamic> json) =>
      _$AudioFileInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AudioFileInfoToJson(this);
}

/* class-MediaDeviceInfo */
@JsonSerializable(explicitToJson: true)
class MediaDeviceInfo {
  String deviceId;

  String deviceName;

  /// Constructs a [MediaDeviceInfo]
  MediaDeviceInfo(
    this.deviceId,
    this.deviceName,
  );

  /// @nodoc
  factory MediaDeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$MediaDeviceInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$MediaDeviceInfoToJson(this);
}

///
/// Screen sharing configurations.
/// 
///
@JsonSerializable(explicitToJson: true)
class ScreenCaptureParameters {
  @JsonKey(includeIfNull: false)
  ///
  /// The maximum dimensions of encoding the shared region. For details, see VideoDimensions. The default value is 1,920 × 1,080, that is,
  /// 2,073,600 pixels. Agora uses the value of this parameter to calculate the charges.
  /// If the screen dimensions are different from the value of this parameter, Agora applies the following strategies for encoding. Suppose dimensions are set to 1,920 x 1,080:
  /// If the value of the screen dimensions is lower than that of dimensions, for example, 1,000 x 1,000 pixels, the SDK uses 1,000 x 1,000 pixels
  /// for encoding.
  /// If the value of the screen dimensions is larger than that of dimensions, for example, 2,000 × 1,500, the SDK uses
  /// the maximum value next to 1,920 × 1,080 with the aspect ratio of the screen dimension (4:3) for encoding, that is, 1,440 × 1,080.
  /// 
  /// 
  ///
  VideoDimensions? dimensions;

  @JsonKey(includeIfNull: false)
  ///
  /// The frame rate (fps) of the shared region. The default value is 5. Agora does not recommend setting it to a value greater than 15.
  ///
  int? frameRate;

  @JsonKey(includeIfNull: false)
  ///
  /// The bitrate (Kbps) of the shared region. The default value is 0, which represents that the SDK works out a bitrate according to the dimensions of the current screen.
  ///
  int? bitrate;

  @JsonKey(includeIfNull: false)
  ///
  /// 
  /// Whether to capture the mouse in screen sharing:
  /// true: (Default) Capture the mouse.
  /// false: Do not capture the mouse.
  /// 
  /// 
  ///
  bool? captureMouseCursor;

  @JsonKey(includeIfNull: false)
  ///
  /// 
  /// Whether to bring the window to the front when calling the startScreenCaptureByWindowId method to share it:
  /// true:Bring the window to the front.
  /// false: (Default) Do not bring the window to the front.
  /// 
  /// 
  ///
  bool? windowFocus;

  @JsonKey(includeIfNull: false)
  ///
  /// 
  /// The ID list of the windows to be blocked. When calling startScreenCaptureByScreenRect to start screen sharing, you can use this parameter to block a specified window. When calling  toupdateScreenCaptureParameters update screen sharing configurations, you can use this parameter to dynamically block a specified window.
  ///
  List<int>? excludeWindowList;

  /// Constructs a [ScreenCaptureParameters]
  ScreenCaptureParameters({
    this.dimensions,
    this.frameRate,
    this.bitrate,
    this.captureMouseCursor,
    this.windowFocus,
    this.excludeWindowList,
  });

  /// @nodoc
  factory ScreenCaptureParameters.fromJson(Map<String, dynamic> json) =>
      _$ScreenCaptureParametersFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ScreenCaptureParametersToJson(this);
}

///
  ///
  /// 
  /// 
  /// 
  /// Deprecated:
  /// This attribute is deprecated.
  /// 
  /// The metadata sent to the CDN client.
  ///
/// Media metadata
/// 
///
@JsonSerializable(explicitToJson: true)
class Metadata {
  ///
  /// 
  /// User ID.
  ///  For the receiver: The user ID of the user who sent the Metadata.
  /// For the sender: Ignore this value.
  ///  
  ///   
  ///
  int uid;

  @JsonKey(ignore: true)
  ///
  /// The buffer address of the sent or received Metadata.
  ///
  Uint8List? buffer;

  ///
  /// The timestamp (ms) of the Metadata.
  ///
  int timeStampMs;

  /// Constructs a [Metadata]
  Metadata(this.uid, this.timeStampMs);

  /// @nodoc
  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}

/* class-MediaRecorderConfiguration */
@JsonSerializable(explicitToJson: true)
class MediaRecorderConfiguration {
  String storagePath;
  AgoraMediaRecorderContainerFormat containerFormat; // = CONTAINER_MP4;
  AgoraMediaRecorderStreamType streamType; // = STREAM_TYPE_BOTH;
  int maxDurationMs; // = 120000;
  int recorderInfoUpdateInterval; // = 0;

  /// Constructs a [MediaRecorderConfiguration]
  MediaRecorderConfiguration(
    this.storagePath,
    this.containerFormat,
    this.streamType,
    this.maxDurationMs,
    this.recorderInfoUpdateInterval,
  );

  /// @nodoc
  factory MediaRecorderConfiguration.fromJson(Map<String, dynamic> json) =>
      _$MediaRecorderConfigurationFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$MediaRecorderConfigurationToJson(this);
}

/* class-RecorderInfo */
@JsonSerializable(explicitToJson: true)
class RecorderInfo {
  String fileName;
  int durationMs;
  int fileSize;

  /// Constructs a [RecorderInfo]
  RecorderInfo(this.fileName, this.durationMs, this.fileSize);

  /// @nodoc
  factory RecorderInfo.fromJson(Map<String, dynamic> json) =>
      _$RecorderInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RecorderInfoToJson(this);
}
