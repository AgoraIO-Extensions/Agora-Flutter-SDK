import 'dart:ui';

class AgoraImage {
  String url;
  int x;
  int y;
  int width;
  int height;

  AgoraImage(this.url, this.x, this.y, this.width, this.height);

  Map<String, dynamic> toJson() => {
        'url': url,
        'x': x,
        'y': y,
        'width': width,
        'height': height,
      };

  @override
  String toString() {
    return "{x: $x, y: $y, width: $width, height: $height}";
  }
}

class AgoraLiveTranscodingUser {
  int uid;
  int width;
  int height;
  int x;
  int y;
  int zOrder;
  int alpha;
  int audioChannel;

  AgoraLiveTranscodingUser.fromJson(Map<dynamic, dynamic> json)
      : uid = json['uid'],
        width = json['width'],
        height = json['height'],
        x = json['x'],
        y = json['y'],
        zOrder = json['zOrder'],
        alpha = json['alpha'],
        audioChannel = json['audioChannel'];

  Map<dynamic, dynamic> toJson() => {
        'uid': uid,
        'width': width,
        'height': height,
        'x': x,
        'y': y,
        'zOrder': zOrder,
        'alpha': alpha,
        'audioChannel': audioChannel
      };
}

enum AgoraAudioCodecProfileType { LCAAC, HEAAC }

Map<AgoraAudioCodecProfileType, int> _resolveAudioCodecProfileType = {
  AgoraAudioCodecProfileType.LCAAC: 0,
  AgoraAudioCodecProfileType.HEAAC: 1,
};

enum AgoraVideoCodecProfileType { BaseLine, Main, High }

Map<AgoraVideoCodecProfileType, int> _resolveVideoCodecProfileType = {
  AgoraVideoCodecProfileType.BaseLine: 66,
  AgoraVideoCodecProfileType.Main: 77,
  AgoraVideoCodecProfileType.High: 100
};

enum AgoraAudioSampleRateType { LowRateType, MidRateType, HighRateType }

Map<AgoraAudioSampleRateType, int> _resolveAudioSampleRate = {
  AgoraAudioSampleRateType.LowRateType: 32000,
  AgoraAudioSampleRateType.MidRateType: 44100,
  AgoraAudioSampleRateType.HighRateType: 48000
};

class AgoraLiveTranscoding {
  int width;
  int height;
  int videoBitrate;
  int videoFramerate;
  int videoGop;
  AgoraVideoCodecProfileType videoCodecProfile;
  List<AgoraLiveTranscodingUser> transcodingUsers;
  String transcodingExtraInfo;
  AgoraImage watermark;
  AgoraImage backgroundImage;
  int backgroundColor;
  AgoraAudioSampleRateType audioSampleRate;
  int audioBitrate;
  int audioChannels;
  AgoraAudioCodecProfileType audioCodecProfile;

  AgoraLiveTranscoding.fromJson(Map<dynamic, dynamic> json)
      : width = json['width'],
        height = json['height'],
        videoBitrate = json['videoBitrate'],
        videoFramerate = json['videoFramerate'],
        videoGop = json['videoGop'],
        videoCodecProfile = json['videoCodecProfile'],
        transcodingUsers = json['transcodingUsers'],
        transcodingExtraInfo = json['transcodingExtraInfo'],
        watermark = json['watermark'],
        backgroundImage = json['backgroundImage'],
        backgroundColor = json['backgroundColor'],
        audioSampleRate = json['audioSampleRate'],
        audioBitrate = json['audioBitrate'],
        audioChannels = json['audioChannels'],
        audioCodecProfile = json['audioCodecProfile'];

  Map<String, dynamic> toJson() => {
        'width': width,
        'height': height,
        'videoBitrate': videoBitrate,
        'videoFramerate': videoFramerate,
        'videoGop': videoGop,
        'videoCodecProfile': _resolveVideoCodecProfileType[videoCodecProfile],
        'transcodingUsers':
            transcodingUsers.map((item) => item.toJson()).toList(),
        'transcodingExtraInfo': transcodingExtraInfo,
        'watermark': watermark.toJson(),
        'backgroundImage': backgroundImage.toJson(),
        'audioSampleRate': _resolveAudioSampleRate[audioSampleRate],
        'audioBitrate': audioBitrate,
        'audioChannels': audioChannels,
        'backgroundColor': backgroundColor,
        'audioCodecProfile': _resolveAudioCodecProfileType[audioCodecProfile],
      };
}

class AgoraLiveInjectStreamConfig {
  int width;
  int height;
  int videoGop;
  int videoFramerate;
  int videoBitrate;
  int audioBitrate;
  AgoraAudioSampleRateType audioSampleRate;

  AgoraLiveInjectStreamConfig.fromJson(Map<dynamic, dynamic> json)
      : width = json['width'],
        height = json['height'],
        videoGop = json['videoGop'],
        videoFramerate = json['videoFramerate'],
        videoBitrate = json['videoBitrate'],
        audioBitrate = json['audioBitrate'],
        audioSampleRate = json['audioSampleRate'];

  Map<String, dynamic> toJson() => {
        'width': width,
        'height': height,
        'videoGop': videoGop,
        'videoFramerate': videoFramerate,
        'videoBitrate': videoBitrate,
        'audioBitrate': audioBitrate,
        'audioSampleRate': _resolveAudioSampleRate[audioSampleRate],
      };

  @override
  String toString() {
    return "{width: $width, height: $height, videoGop: $videoGop, videoFramerate: $videoFramerate, videoBitrate: $videoBitrate, audioBitrate: $audioBitrate, audioSampleRate: ${_resolveAudioSampleRate[audioSampleRate]}}";
  }
}

class AudioVolumeInfo {
  int uid;
  int volume;

  AudioVolumeInfo(int uid, int volume) {
    this.uid = uid;
    this.volume = volume;
  }
}

class RtcStats {
  final int totalDuration;
  final int txBytes;
  final int rxBytes;
  final int txAudioBytes;
  final int txVideoBytes;
  final int rxAudioBytes;
  final int rxVideoBytes;
  final int txKBitrate;
  final int rxKBitrate;
  final int txAudioKBitrate;
  final int rxAudioKBitrate;
  final int txVideoKBitrate;
  final int rxVideoKBitrate;
  final int lastmileDelay;
  final int txPacketLossRate;
  final int rxPacketLossRate;
  final int users;
  final double cpuTotalUsage;
  final double cpuAppUsage;

  RtcStats(
    this.totalDuration,
    this.txBytes,
    this.rxBytes,
    this.txAudioBytes,
    this.txVideoBytes,
    this.rxAudioBytes,
    this.rxVideoBytes,
    this.txKBitrate,
    this.rxKBitrate,
    this.txAudioKBitrate,
    this.rxAudioKBitrate,
    this.txVideoKBitrate,
    this.rxVideoKBitrate,
    this.lastmileDelay,
    this.txPacketLossRate,
    this.rxPacketLossRate,
    this.users,
    this.cpuTotalUsage,
    this.cpuAppUsage,
  );

  RtcStats.fromJson(Map<dynamic, dynamic> json)
      : totalDuration = json['totalDuration'],
        txBytes = json['txBytes'],
        rxBytes = json['rxBytes'],
        txAudioBytes = json['txAudioBytes'],
        txVideoBytes = json['txVideoBytes'],
        rxAudioBytes = json['rxAudioBytes'],
        rxVideoBytes = json['rxVideoBytes'],
        txKBitrate = json['txKBitrate'],
        rxKBitrate = json['rxKBitrate'],
        txAudioKBitrate = json['txAudioKBitrate'],
        rxAudioKBitrate = json['rxAudioKBitrate'],
        txVideoKBitrate = json['txVideoKBitrate'],
        rxVideoKBitrate = json['rxVideoKBitrate'],
        lastmileDelay = json['lastmileDelay'],
        txPacketLossRate = json['txPacketLossRate'],
        rxPacketLossRate = json['rxPacketLossRate'],
        users = json['users'],
        cpuTotalUsage = json['cpuTotalUsage'],
        cpuAppUsage = json['cpuAppUsage'];

  Map<String, dynamic> toJson() {
    return {
      "totalDuration": totalDuration,
      "txBytes": txBytes,
      "rxBytes": rxBytes,
      "txAudioBytes": txAudioBytes,
      "txVideoBytes": txVideoBytes,
      "rxAudioBytes": rxAudioBytes,
      "rxVideoBytes": rxVideoBytes,
      "txKBitrate": txKBitrate,
      "rxKBitrate": rxKBitrate,
      "txAudioKBitrate": txAudioKBitrate,
      "rxAudioKBitrate": rxAudioKBitrate,
      "txVideoKBitrate": txVideoKBitrate,
      "rxVideoKBitrate": rxVideoKBitrate,
      "lastmileDelay": lastmileDelay,
      "txPacketLossRate": txPacketLossRate,
      "rxPacketLossRate": rxPacketLossRate,
      "users": users,
      "cpuTotalUsage": cpuTotalUsage,
      "cpuAppUsage": cpuAppUsage,
    };
  }
}

class LocalVideoStats {
  final int sentBitrate;
  final int sentFrameRate;
  final int encoderOutputFrameRate;
  final int rendererOutputFrameRate;
  final int sentTargetBitrate;
  final int sentTargetFrameRate;
  final int qualityAdaptIndication;
  final int encodedBitrate;
  final int encodedFrameWidth;
  final int encodedFrameHeight;
  final int encodedFrameCount;
  final int codecType;

  LocalVideoStats(
      this.sentBitrate,
      this.sentFrameRate,
      this.encoderOutputFrameRate,
      this.rendererOutputFrameRate,
      this.sentTargetBitrate,
      this.sentTargetFrameRate,
      this.qualityAdaptIndication,
      this.encodedBitrate,
      this.encodedFrameWidth,
      this.encodedFrameHeight,
      this.encodedFrameCount,
      this.codecType);

  LocalVideoStats.fromJson(Map<dynamic, dynamic> json)
      : sentBitrate = json["sentBitrate"],
        sentFrameRate = json["sentFrameRate"],
        encoderOutputFrameRate = json["encoderOutputFrameRate"],
        rendererOutputFrameRate = json["rendererOutputFrameRate"],
        sentTargetBitrate = json["sentTargetBitrate"],
        sentTargetFrameRate = json["sentTargetFrameRate"],
        qualityAdaptIndication = json["qualityAdaptIndication"],
        encodedBitrate = json["encodedBitrate"],
        encodedFrameWidth = json["encodedFrameWidth"],
        encodedFrameHeight = json["encodedFrameHeight"],
        encodedFrameCount = json["encodedFrameCount"],
        codecType = json["codecType"];

  Map<String, dynamic> toJson() {
    return {
      "sentBitrate": sentBitrate,
      "sentFrameRate": sentFrameRate,
      "encoderOutputFrameRate": encoderOutputFrameRate,
      "rendererOutputFrameRate": rendererOutputFrameRate,
      "sentTargetBitrate": sentTargetBitrate,
      "sentTargetFrameRate": sentTargetFrameRate,
      "qualityAdaptIndication": qualityAdaptIndication,
      "encodedBitrate": encodedBitrate,
      "encodedFrameWidth": encodedFrameWidth,
      "encodedFrameHeight": encodedFrameHeight,
      "encodedFrameCount": encodedFrameCount,
      "codecType": codecType,
    };
  }
}

class LocalAudioStats {
  final int numChannels;
  final int sentSampleRate;
  final int sentBitrate;

  LocalAudioStats(this.numChannels, this.sentSampleRate, this.sentBitrate);

  LocalAudioStats.fromJson(Map<dynamic, dynamic> json)
      : numChannels = json['numChannels'],
        sentSampleRate = json['sentSampleRate'],
        sentBitrate = json['sentBitrate'];
}

class RemoteVideoStats {
  final int uid;
  final int width;
  final int height;
  final int receivedBitrate;
  final int decoderOutputFrameRate;
  final int rendererOutputFrameRate;
  final int packetLostRate;
  final int rxStreamType;
  final int totalFrozenTime;
  final int frozenRate;

  RemoteVideoStats(
      this.uid,
      this.width,
      this.height,
      this.receivedBitrate,
      this.decoderOutputFrameRate,
      this.rendererOutputFrameRate,
      this.packetLostRate,
      this.rxStreamType,
      this.totalFrozenTime,
      this.frozenRate);

  RemoteVideoStats.fromJson(Map<dynamic, dynamic> json)
      : uid = json['uid'],
        width = json['width'],
        height = json['height'],
        receivedBitrate = json['receivedBitrate'],
        decoderOutputFrameRate = json['decoderOutputFrameRate'],
        rendererOutputFrameRate = json['rendererOutputFrameRate'],
        packetLostRate = json['packetLostRate'],
        rxStreamType = json['rxStreamType'],
        totalFrozenTime = json['totalFrozenTime'],
        frozenRate = json['frozenRate'];

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "width": width,
      "height": height,
      "receivedBitrate": receivedBitrate,
      "decoderOutputFrameRate": decoderOutputFrameRate,
      "rendererOutputFrameRate": rendererOutputFrameRate,
      "packetLostRate": packetLostRate,
      "rxStreamType": rxStreamType,
      "totalFrozenTime": totalFrozenTime,
      "frozenRate": frozenRate,
    };
  }
}

class RemoteAudioStats {
  int uid;
  int quality;
  int networkTransportDelay;
  int jitterBufferDelay;
  int audioLossRate;
  int numChannels;
  int receivedSampleRate;
  int receivedBitrate;
  int totalFrozenTime;
  int frozenRate;

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
  );

  RemoteAudioStats.fromJson(Map<dynamic, dynamic> json)
      : uid = json['uid'],
        quality = json['quality'],
        networkTransportDelay = json['networkTransportDelay'],
        jitterBufferDelay = json['jitterBufferDelay'],
        audioLossRate = json['audioLossRate'],
        numChannels = json['numChannels'],
        receivedSampleRate = json['receivedSampleRate'],
        receivedBitrate = json['receivedBitrate'],
        totalFrozenTime = json['totalFrozenTime'],
        frozenRate = json['frozenRate'];

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "quality": quality,
      "networkTransportDelay": networkTransportDelay,
      "jitterBufferDelay": jitterBufferDelay,
      "audioLossRate": audioLossRate,
      "numChannels": numChannels,
      "receivedSampleRate": receivedSampleRate,
      "receivedBitrate": receivedBitrate,
      "totalFrozenTime": totalFrozenTime,
      "frozenRate": frozenRate
    };
  }
}

/// The image enhancement options in [AgoraRtcEngine.setBeautyEffectOptions].
class BeautyOptions {
  /// The lightening contrast level.
  ///
  /// 0: low contrast level.
  /// 1: (default) normal contrast level.
  /// 2: high contrast level.
  LighteningContrastLevel lighteningContrastLevel =
      LighteningContrastLevel.Normal;

  /// The brightness level.
  ///
  /// The value ranges from 0.0 (original) to 1.0.
  double lighteningLevel = 0;

  /// The sharpness level.
  ///
  ///The value ranges from 0.0 (original) to 1.0. This parameter is usually used to remove blemishes.
  double smoothnessLevel = 0;

  /// The redness level.
  ///
  /// The value ranges from 0.0 (original) to 1.0. This parameter adjusts the red saturation level.
  double rednessLevel = 0;

  Map<String, double> toJson() {
    return {
      "lighteningContrastLevel": lighteningContrastLevel.index.toDouble(),
      "lighteningLevel": lighteningLevel,
      "smoothnessLevel": smoothnessLevel,
      "rednessLevel": rednessLevel,
    };
  }
}

/// Properties of the video encoder configuration.
class VideoEncoderConfiguration {
  /// The video frame dimension used to specify the video quality in the total number of pixels along a frame's width and height.
  ///
  /// The dimension does not specify the orientation mode of the output ratio. For how to set the video orientation, see [VideoOutputOrientationMode].
  /// Whether 720p can be supported depends on the device. If the device cannot support 720p, the frame rate will be lower than the one listed in the table. Agora optimizes the video in lower-end devices.
  Size dimensions = Size(640, 360);

  /// The frame rate of the video (fps).
  ///
  /// We do not recommend setting this to a value greater than 30.
  int frameRate = 15;

  /// The minimum video encoder frame rate (fps).
  ///
  /// The default value (-1) means the SDK uses the lowest encoder frame rate.
  int minFrameRate = -1;

  /// The bitrate of the video.
  ///
  /// Sets the video bitrate (Kbps). If you set a bitrate beyond the proper range, the SDK automatically adjusts it to a value within the range. You can also choose from the following options:
  ///  - Standard: (recommended) In this mode, the bitrates differ between the Live-broadcast and Communication profiles:
  ///   - Communication profile: the video bitrate is the same as the base bitrate.
  ///   - Live-broadcast profile: the video bitrate is twice the base bitrate.
  ///  - Compatible: In this mode, the bitrate stays the same regardless of the profile. In the Live-broadcast profile, if you choose this mode, the video frame rate may be lower than the set value.
  /// Agora uses different video codecs for different profiles to optimize the user experience. For example, the Communication profile prioritizes the smoothness while the Live-broadcast profile prioritizes the video quality (a higher bitrate). Therefore, Agora recommends setting this parameter as AgoraVideoBitrateStandard.
  int bitrate = AgoraVideoBitrateStandard;

  /// The minimum encoding bitrate.
  ///
  /// The Agora SDK automatically adjusts the encoding bitrate to adapt to network conditions.
  /// Using a value greater than the default value forces the video encoder to output high-quality images but may cause more packet loss and hence sacrifice the smoothness of the video transmission.
  /// Unless you have special requirements for image quality, Agora does not recommend changing this value.
  int minBitrate = -1;

  /// The video orientation mode of the video.
  VideoOutputOrientationMode orientationMode =
      VideoOutputOrientationMode.Adaptative;

  /// The video encoding degradation preference under limited bandwidth.
  DegradationPreference degradationPreference =
      DegradationPreference.MaintainQuality;

  Map<String, dynamic> toJson() {
    return {
      'width': dimensions.width.toInt(),
      'height': dimensions.height.toInt(),
      'frameRate': frameRate,
      'minFrameRate': minFrameRate,
      'bitrate': bitrate,
      'minBitrate': minBitrate,
      'orientationMode': orientationMode.index,
      'degradationPreference': degradationPreference.index,
    };
  }
}

const int AgoraVideoBitrateStandard = 0;
const int AgoraVideoBitrateCompatible = -1;

enum ChannelProfile {
  /// This is used in one-on-one or group calls, where all users in the channel can talk freely.
  Communication,

  /// Host and audience roles that can be set by calling the [AgoraRtcEngine.setClientRole] method. The host sends and receives voice/video, while the audience can only receive voice/video.
  LiveBroadcasting,
}

enum ClientRole {
  Broadcaster,
  Audience,
}

enum VideoOutputOrientationMode {
  /// Adaptive mode.
  ///
  /// The video encoder adapts to the orientation mode of the video input device. When you use a custom video source, the output video from the encoder inherits the orientation of the original video.
  /// If the width of the captured video from the SDK is greater than the height, the encoder sends the video in landscape mode. The encoder also sends the rotational information of the video, and the receiver uses the rotational information to rotate the received video.
  /// If the original video is in portrait mode, the output video from the encoder is also in portrait mode. The encoder also sends the rotational information of the video to the receiver.
  Adaptative,

  /// Landscape mode.
  ///
  /// The video encoder always sends the video in landscape mode. The video encoder rotates the original video before sending it and the rotational information is 0. This mode applies to scenarios involving CDN live streaming.
  FixedLandscape,

  /// Portrait mode.
  ///
  /// The video encoder always sends the video in portrait mode. The video encoder rotates the original video before sending it and the rotational information is 0. This mode applies to scenarios involving CDN live streaming.
  FixedPortrait,
}

/// The video encoding degradation preference under limited bandwidth.
enum DegradationPreference {
  /// Degrades the frame rate to guarantee the video quality.
  MaintainQuality,

  /// Degrades the video quality to guarantee the frame rate.
  MaintainFramerate,

  /// Reserved for future use.
  Balanced,
}

enum VideoRenderMode {
  /// Uniformly scale the video until it fills the visible boundaries (cropped). One dimension of the video may have clipped contents.
  Hidden,

  /// Uniformly scale the video until one of its dimension fits the boundary (zoomed to fit). Areas that are not filled due to the disparity in the aspect ratio are filled with black.
  Fit,
}

enum VoiceChanger {
  /// The original voice (no local voice change).
  VOICE_CHANGER_OFF,

  /// An old man's voice.
  VOICE_CHANGER_OLDMAN,

  /// A little boy's voice.
  VOICE_CHANGER_BABYBOY,

  ///A little girl's voice.
  VOICE_CHANGER_BABYGILR,

  /// Zhu Bajie's voice (Zhu Bajie is a character from Journey to the West who has a voice like a growling bear).
  VOICE_CHANGER_ZHUBAJIE,

  /// Ethereal vocal effects.
  VOICE_CHANGER_ETHEREAL,

  /// Hulk's voice.
  VOICE_CHANGER_HULK
}

enum UserPriority {
  High,
  Normal,
}

enum AgoraAudioEqualizationBandFrequency {
  AgoraAudioEqualizationBand31,
  AgoraAudioEqualizationBand62,
  AgoraAudioEqualizationBand125,
  AgoraAudioEqualizationBand250,
  AgoraAudioEqualizationBand500,
  AgoraAudioEqualizationBand1K,
  AgoraAudioEqualizationBand2K,
  AgoraAudioEqualizationBand4K,
  AgoraAudioEqualizationBand8K,
  AgoraAudioEqualizationBand16K,
}

enum AgoraAudioReverbType {
  AgoraAudioReverbDryLevel,
  AgoraAudioReverbWetLevel,
  AgoraAudioReverbRoomSize,
  AgoraAudioReverbWetDelay,
  AgoraAudioReverbStrength,
}

enum StreamFallbackOptions {
  /// No fallback behavior for the local/remote stream when the uplink/downlink network condition is unreliable. The quality of the stream is not guaranteed.
  Disabled,

  /// Under unreliable downlink network conditions, the remote stream falls back to the low-video stream (low resolution and low bitrate). You can only set this option in [AgoraRtcEngine.setRemoteSubscribeFallbackOption].
  /// Nothing happens when you set this in [AgoraRtcEngine.setLocalPublishFallbackOption].
  VideoStreamLow,

  /// Under unreliable uplink network conditions, the published stream falls back audio only.
  /// Under unreliable downlink network conditions, the remote stream first falls back to the low-video stream (low resolution and low bitrate); and then to an audio-only stream if the network condition deteriorates.
  AudioOnly,
}

enum AudioProfile {
  /// Default audio profile. In the communication profile, the default value is [SpeechStandard]; in the live-broadcast profile, the default value is [MusicStandard].
  Default,

  /// Sampling rate of 32 kHz, audio encoding, mono, and a bitrate of up to 18 Kbps.
  SpeechStandard,

  /// Sampling rate of 48 kHz, music encoding, mono, and a bitrate of up to 48 Kbps.
  MusicStandard,

  /// Sampling rate of 48 kHz, music encoding, stereo, and a bitrate of up to 56 Kbps.
  MusicStandardStereo,

  /// Sampling rate of 48 kHz, music encoding, mono, and a bitrate of up to 128 Kbps.
  MusicHighQuality,

  /// Sampling rate of 48 kHz, music encoding, stereo, and a bitrate of up to 192 Kbps.
  MusicHighQualityStereo,
}

enum AudioScenario {
  /// Default.
  Default,

  /// Entertainment scenario, supporting voice during gameplay.
  ChatRoomEntertainment,

  /// Education scenario, prioritizing fluency and stability.
  Education,

  /// Live gaming scenario, enabling the gaming audio effects in the speaker mode in a live broadcast scenario. Choose this scenario for high-fidelity music playback.
  GameStreaming,

  /// Showroom scenario, optimizing the audio quality with external professional equipment.
  ShowRoom,

  /// Gaming scenario.
  ChatRoomGaming,
}

enum LighteningContrastLevel {
  /// Low contrast level.
  Low,

  /// Normal contrast level.
  Normal,

  ///High contrast level.
  High,
}

enum LocalVideoStreamState {
  /// The local video is in the initial state.
  Stopped,

  /// The local video capturer starts successfully.
  Capturing,

  /// The first local video frame encodes successfully.
  Encoding,

  /// The local video fails to start.
  Failed,
}

enum LocalVideoStreamError {
  /// The local video is normal.
  OK,

  /// No specified reason for the local video failure.
  Failure,

  /// No permission to use the local video device.
  DeviceNoPermission,

  /// The local video capturer is in use.
  DeviceBusy,

  /// The local video capture fails. Check whether the capturer is working properly.
  CaptureFailure,

  /// The local video encoding fails.
  EncodeFailure,
}
