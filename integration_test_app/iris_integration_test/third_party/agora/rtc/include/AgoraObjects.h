//
//  AgoraObjects.h
//  AgoraRtcEngineKit
//
//  Copyright (c) 2018 Agora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>
#import "AgoraEnumerates.h"

#if defined(TARGET_OS_IPHONE) && TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
typedef UIView VIEW_CLASS;
typedef UIColor COLOR_CLASS;
#elif defined(TARGET_OS_MAC) && TARGET_OS_MAC
#import <AppKit/AppKit.h>
typedef NSView VIEW_CLASS;
typedef NSColor COLOR_CLASS;
#endif

/** The AgoraAudioFrame interface. (iOS only)

 @since v3.4.5

 After you successfully register the audio delegate, the SDK triggers the
 following callbacks to report the observed audio data:

 - [onRecordAudioFrame]([AgoraAudioDataFrameProtocol onRecordAudioFrame:])
 - [onPlaybackAudioFrame]([AgoraAudioDataFrameProtocol onPlaybackAudioFrame:])
 - [onMixedAudioFrame]([AgoraAudioDataFrameProtocol onMixedAudioFrame:])
 - [onPlaybackAudioFrameBeforeMixing]([AgoraAudioDataFrameProtocol onPlaybackAudioFrameBeforeMixing:uid:])
 */
__attribute__((visibility("default"))) @interface AgoraAudioFrame : NSObject
/** The number of samples per channel.
 */
@property(assign, nonatomic) NSInteger samplesPerChannel;
/** The number of bytes per audio sample. For example, each PCM audio sample
 usually takes up 16 bits (2 bytes).
 */
@property(assign, nonatomic) NSInteger bytesPerSample;
/** The number of audio channels. If the channel uses stereo, the data is
 interleaved.

- 1: Mono.
- 2: Stereo.
 */
@property(assign, nonatomic) NSInteger channels;
/** The sample rate.
 */
@property(assign, nonatomic) NSInteger samplesPerSec;
/** The buffer of the sample audio data. When the audio frame uses a stereo
 channel, the data buffer is interleaved. The size of the data buffer is as
 follows: `buffer` = `samplesPerChannel` × `channels` × `bytesPerSample`.
 */
@property(assign, nonatomic) void* _Nullable buffer;
/** The timestamp of the external audio frame. You can use this parameter for
 the following purposes:

- Restore the order of the captured audio frame.
- Synchronize audio and video frames in video-related scenarios, including
where external video sources are used.
 */
@property(assign, nonatomic) int64_t renderTimeMs;
/** Reserved for future use.
 */
@property(assign, nonatomic) NSInteger avSyncType;
@end

/** The AgoraAudioParam interface. (iOS only)

 @since v3.4.5

 You can pass the `AgoraAudioParam` object in the return value of the following
 callbacks to set the audio data format for the corresponding callbacks:

 - [getRecordAudioParams]([AgoraAudioDataFrameProtocol getRecordAudioParams]):
 Sets the audio recording format for the
 [onRecordAudioFrame]([AgoraAudioDataFrameProtocol onRecordAudioFrame:])
 callback.
 - [getPlaybackAudioParams]([AgoraAudioDataFrameProtocol getPlaybackAudioParams]):
 Sets the audio playback format for the
 [onPlaybackAudioFrame]([AgoraAudioDataFrameProtocol onPlaybackAudioFrame:])
 callback.
 - [getMixedAudioParams]([AgoraAudioDataFrameProtocol getMixedAudioParams]):
 Sets the audio mixing format for the
 [onMixedAudioFrame]([AgoraAudioDataFrameProtocol onMixedAudioFrame:]) callback.

 @note The SDK calculates the sample interval according to the
 `samplesPerCall`, `sampleRate`, and `channel` values in the
 `AgoraAudioParam` interface and triggers the following callbacks at the
 calculated sample interval:

 - [onRecordAudioFrame]([AgoraAudioDataFrameProtocol onRecordAudioFrame:])
 - [onPlaybackAudioFrame]([AgoraAudioDataFrameProtocol onPlaybackAudioFrame:])
 - [onMixedAudioFrame]([AgoraAudioDataFrameProtocol onMixedAudioFrame:])

 Sample interval (seconds) = `samplesPerCall`/(`sampleRate` × `channel`).
 Ensure that the value of sample interval is equal to or greater than 0.01.
 */
__attribute__((visibility("default"))) @interface AgoraAudioParam : NSObject

/** The audio sample rate (Hz), which can be set as one of the following values:

 - `8000`
 - `16000` (Default)
 - `32000`
 - `44100 `
 - `48000`
 */
@property(assign, nonatomic) NSInteger sampleRate;

/* The number of audio channels, which can be set as either of the following values:

 - `1`: Mono (Default)
 - `2`: Stereo
 */
@property(assign, nonatomic) NSInteger channel;

/* The use mode of the audio data. See AgoraAudioRawFrameOperationMode.
 */
@property(assign, nonatomic) AgoraAudioRawFrameOperationMode mode;

/** The number of samples. For example, set it as 1024 for RTMP or RTMPS
 streaming.
 */
@property(assign, nonatomic) NSInteger samplesPerCall;

@end

/** Properties of the video canvas object.
 */
__attribute__((visibility("default"))) @interface AgoraRtcVideoCanvas : NSObject
/** The video display view.

 VIEW_CLASS is a general name for this property. See the following definitions for iOS and macOS:

 - iOS: UIView
 - MacOS: NSView
 */
@property(strong, nonatomic) VIEW_CLASS* _Nullable view;
/** The rendering mode of the video view. See [AgoraVideoRenderMode](AgoraVideoRenderMode).
 */
@property(assign, nonatomic) AgoraVideoRenderMode renderMode;
/** The unique channel name for the Agora RTC session in the string format. The string length must be less than 64 bytes. Supported character scopes are:

 - All lowercase English letters: a to z.
 - All uppercase English letters: A to Z.
 - All numeric characters: 0 to 9.
 - The space character.
 - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ",".
 <p>**Note**</p>

 - The default value is the empty string "". Use the default value if the user joins the channel using the [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) method in the [AgoraRtcEngineKit](AgoraRtcEngineKit) class. The `AgoraRtcVideoCanvas` struct defines the video canvas of the user in the channel.
 - If the user joins the channel using the [joinChannelByToken]([AgoraRtcChannel joinChannelByToken:info:uid:options:]) method in the [AgoraRtcChannel](AgoraRtcChannel) class, set this parameter as the `channelID` of the `AgoraRtcChannel` object. The `AgoraRtcVideoCanvas` struct defines the video canvas of the user in the channel with the specified channel ID.
 */
@property(copy, nonatomic) NSString* _Nullable channelId;
/** User ID of the view.
 */
@property(assign, nonatomic) NSUInteger uid;
/** The mirror mode of the video view. See [AgoraVideoMirrorMode](AgoraVideoMirrorMode).

 **Note**

 - For the mirror mode of the local video view: If you use a front camera, the SDK enables the mirror mode by default; if you use a rear camera, the SDK disables the mirror mode by default.
 -
 */
@property(assign, nonatomic) AgoraVideoMirrorMode mirrorMode;
@end

/** The configurations of the last-mile network probe test. */
__attribute__((visibility("default"))) @interface AgoraLastmileProbeConfig : NSObject
/** Sets whether to test the uplink network. Some users, for example, the audience in the interactive live streaming channel, do not need such a test.

- NO: disables the test.
- YES: enables the test.
*/
@property(assign, nonatomic) BOOL probeUplink;
/** Sets whether to test the downlink network.

- NO: disables the test.
- YES: enables the test.
*/
@property(assign, nonatomic) BOOL probeDownlink;
/** The expected maximum sending bitrate (bps) of the local user.

The value ranges between 100000 and 5000000. We recommend setting this parameter according to the bitrate value set by [setVideoEncoderConfiguration]([AgoraRtcEngineKit setVideoEncoderConfiguration:]). */
@property(assign, nonatomic) NSUInteger expectedUplinkBitrate;
/** The expected maximum receiving bitrate (bps) of the local user.

The value ranges between 100000 and 5000000.
*/
@property(assign, nonatomic) NSUInteger expectedDownlinkBitrate;
@end

/** The last-mile network probe test result in one direction (uplink or downlink). */
__attribute__((visibility("default"))) @interface AgoraLastmileProbeOneWayResult : NSObject
/** The packet loss rate (%). */
@property(assign, nonatomic) NSUInteger packetLossRate;
/** The network jitter (ms). */
@property(assign, nonatomic) NSUInteger jitter;
/** The estimated available bandwidth (Kbps). */
@property(assign, nonatomic) NSUInteger availableBandwidth;
@end

/** The uplink and downlink last-mile network probe test result. */
__attribute__((visibility("default"))) @interface AgoraLastmileProbeResult : NSObject
/* The state of the probe test.

See [AgoraLastmileProbeResultState](AgoraLastmileProbeResultState).
*/
@property(assign, nonatomic) AgoraLastmileProbeResultState state;
/** The round-trip delay time (ms). */
@property(assign, nonatomic) NSUInteger rtt;
/** The uplink last-mile network report

See [AgoraLastmileProbeOneWayResult](AgoraLastmileProbeOneWayResult).
*/
@property(strong, nonatomic) AgoraLastmileProbeOneWayResult* _Nonnull uplinkReport;
/** The downlink last-mile network report

See [AgoraLastmileProbeOneWayResult](AgoraLastmileProbeOneWayResult).
*/
@property(strong, nonatomic) AgoraLastmileProbeOneWayResult* _Nonnull downlinkReport;
@end

/** Statistics of the local video stream.
 */
__attribute__((visibility("default"))) @interface AgoraRtcLocalVideoStats : NSObject
/** Bitrate (Kbps) sent in the reported interval, which does not include the bitrate of the retransmission video after packet loss. */
@property(assign, nonatomic) NSUInteger sentBitrate;
/** Frame rate (fps) sent in the reported interval, which does not include the frame rate of the retransmission video after packet loss. */
@property(assign, nonatomic) NSUInteger sentFrameRate;
/** The encoder output frame rate (fps) of the local video. */
@property(assign, nonatomic) NSUInteger encoderOutputFrameRate;
/** The renderer output frame rate (fps) of the local video. */
@property(assign, nonatomic) NSUInteger rendererOutputFrameRate;
/** The target bitrate (Kbps) of the current encoder. This value is estimated by the SDK based on the current network conditions. */
@property(assign, nonatomic) NSUInteger sentTargetBitrate;
/** The target frame rate (fps) of the current encoder. */
@property(assign, nonatomic) NSUInteger sentTargetFrameRate;
/** Quality change of the local video in terms of target frame rate and target bit rate in this reported interval, see [AgoraVideoQualityAdaptIndication](AgoraVideoQualityAdaptIndication). */
@property(assign, nonatomic) AgoraVideoQualityAdaptIndication qualityAdaptIndication;
/** The encoding bitrate (Kbps), which does not include the bitrate of the re-transmission video after packet loss.
 */
@property(assign, nonatomic) NSUInteger encodedBitrate;
/** The width of the encoding frame (px).
 */
@property(assign, nonatomic) NSUInteger encodedFrameWidth;
/** The height of the encoding frame (px).
 */
@property(assign, nonatomic) NSUInteger encodedFrameHeight;
/** The value of the sent frames, represented by an aggregate value.
 */
@property(assign, nonatomic) NSUInteger encodedFrameCount;
/** The codec type of the local video：

 - `AgoraVideoCodecTypeVP8` = 1: VP8.
 - `AgoraVideoCodecTypeH264` = 2: (Default) H.264.
 */
@property(assign, nonatomic) AgoraVideoCodecType codecType;

/** The video packet loss rate (%) from the local client to the Agora edge server before applying the anti-packet loss strategies.

 @since v3.1.0
 */
@property(assign, nonatomic) NSInteger txPacketLossRate;

/** The capture frame rate (fps) of the local video.

 @since v3.1.0
 */
@property(assign, nonatomic) NSInteger captureFrameRate;

/** The brightness level of the video image captured by the local camera. See
 AgoraCaptureBrightnessLevelType.

 @since v3.3.0
 */
@property(assign, nonatomic) AgoraCaptureBrightnessLevelType captureBrightnessLevel;
@end

/** Statistics of the remote video stream.
 */
__attribute__((visibility("default"))) @interface AgoraRtcRemoteVideoStats : NSObject
/** User ID of the user sending the video streams.
 */
@property(assign, nonatomic) NSUInteger uid;
/** Time delay (ms). **DEPRECATED** In scenarios where audio and video is synchronized, you can use the value of `networkTransportDelay` and `jitterBufferDelay` in AgoraRtcRemoteAudioStats to know the delay statistics of the remote video.
 */
@property(assign, nonatomic) NSUInteger __deprecated delay;
/** Width (pixels) of the video stream.
 */
@property(assign, nonatomic) NSUInteger width;
/** Height (pixels) of the video stream.
 */
@property(assign, nonatomic) NSUInteger height;
/** The average bitrate (Kbps) of the received video stream.
 */
@property(assign, nonatomic) NSUInteger receivedBitrate;
/** The decoder output frame rate (fps) of the remote video.
 */
@property(assign, nonatomic) NSUInteger decoderOutputFrameRate;
/** The renderer output frame rate (fps) of the remote video.
 */
@property(assign, nonatomic) NSUInteger rendererOutputFrameRate;
/** Packet loss rate (%) of the remote video stream after using the anti-packet-loss method.
 */
@property(assign, nonatomic) NSUInteger packetLossRate;
/** Video stream type (high-stream or low-stream).
 */
@property(assign, nonatomic) AgoraVideoStreamType rxStreamType;
/** The total freeze time (ms) of the remote video stream after the remote user joins the channel. In a video session where the frame rate is set to no less than 5 fps, video freeze occurs when the time interval between two adjacent renderable video frames is more than 500 ms.
 */
@property(assign, nonatomic) NSUInteger totalFrozenTime;
/** The total video freeze time as a percentage (%) of the total time when the video is available.
 */
@property(assign, nonatomic) NSUInteger frozenRate;
/** The total time (ms) when the remote user in the Communication profile or the remote host in the interactive live streaming profile neither stops sending the video stream nor disables the video module after joining the channel.
 */
@property(assign, nonatomic) NSUInteger totalActiveTime;
/** The total publish duration (ms) of the remote video stream.
 */
@property(assign, nonatomic) NSInteger publishDuration;
@end

/** The statistics of the local audio stream.
 */
__attribute__((visibility("default"))) @interface AgoraRtcLocalAudioStats : NSObject
/** The number of channels.
 */
@property(assign, nonatomic) NSUInteger numChannels;
/** The sample rate (Hz).
 */
@property(assign, nonatomic) NSUInteger sentSampleRate;
/** The average sending bitrate (Kbps).
 */
@property(assign, nonatomic) NSUInteger sentBitrate;
/** The audio packet loss rate (%) from the local client to the Agora edge server before applying the anti-packet loss strategies.

 @since v3.1.0
 */
@property(assign, nonatomic) NSUInteger txPacketLossRate;
@end

/** The statistics of the remote audio stream.
 */
__attribute__((visibility("default"))) @interface AgoraRtcRemoteAudioStats : NSObject
/** User ID of the user sending the audio stream.
 */
@property(assign, nonatomic) NSUInteger uid;
/** Audio quality received by the user.
 */
@property(assign, nonatomic) NSUInteger quality;
/** Network delay (ms) from the sender to the receiver.
 */
@property(assign, nonatomic) NSUInteger networkTransportDelay;
/** Network delay (ms) from the receiver to the jitter buffer.
 @note When the receiver is an audience member and `AgoraAudienceLatencyLevelType` is `1`, this parameter does not take effect.
 */
@property(assign, nonatomic) NSUInteger jitterBufferDelay;
/** The audio frame loss rate in the reported interval.
 */
@property(assign, nonatomic) NSUInteger audioLossRate;
/** The number of channels.
 */
@property(assign, nonatomic) NSUInteger numChannels;
/** The sample rate (Hz) of the received audio stream in the reported interval.
 */
@property(assign, nonatomic) NSUInteger receivedSampleRate;
/** The average bitrate (Kbps) of the received audio stream in the reported interval.
 */
@property(assign, nonatomic) NSUInteger receivedBitrate;
/** The total freeze time (ms) of the remote audio stream after the remote user joins the channel.
 */
@property(assign, nonatomic) NSUInteger totalFrozenTime;
/** The total audio freeze time as a percentage (%) of the total time when the audio is available.
 */
@property(assign, nonatomic) NSUInteger frozenRate;
/** The total time (ms) when the remote user in the Communication profile or the remote host in the interactive live streaming profile neither stops sending the audio stream nor disables the audio module after joining the channel.
 */
@property(assign, nonatomic) NSUInteger totalActiveTime;
/** The total publish duration (ms) of the remote audio stream.

 @since v3.1.0
 */
@property(assign, nonatomic) NSInteger publishDuration;
/** Quality of experience (QoE) of the local user when receiving a remote
 audio stream. See AgoraExperienceQuality.

 @since v3.3.0
 */
@property(assign, nonatomic) NSUInteger qoeQuality;
/** The reason for poor QoE of the local user when receiving a remote
 audio stream. See AgoraExperiencePoorReason.

 @since v3.3.0
 */
@property(assign, nonatomic) NSUInteger qualityChangedReason;
/** The quality of the remote audio stream as determined by the Agora real-time
 audio MOS (Mean Opinion Score) measurement method in the reported interval.
 The return value ranges from 0 to 500. Dividing the return value by 100 gets
 the MOS score, which ranges from 0 to 5. The higher the score, the better the audio quality.

 @since v3.3.1

 The subjective perception of audio quality corresponding to the Agora real-time audio MOS scores is as follows:

| MOS score      | Perception of audio quality                                  |
| :------------- | :----------------------------------------------------------- |
| Greater than 4 | Excellent. The audio sounds clear and smooth.                |
| From 3.5 to 4  | Good. The audio has some perceptible impairment, but still sounds clear. |
| From 3 to 3.5  | Fair. The audio freezes occasionally and requires attentive listening. |
| From 2.5 to 3  | Poor. The audio sounds choppy and requires considerable effort to understand. |
| From 2 to 2.5  | Bad. The audio has occasional noise. Consecutive audio dropouts occur, resulting in some information loss. The users can communicate only with difficulty. |
| Less than 2    | Very bad. The audio has persistent noise. Consecutive audio dropouts are frequent, resulting in severe information loss. Communication is nearly impossible. |
 */
@property(assign, nonatomic) NSInteger mosValue;
@end

/** Properties of the audio volume information.
 */
__attribute__((visibility("default"))) @interface AgoraRtcAudioVolumeInfo : NSObject
/** The user ID.

 - In the local user's callback, `uid` = 0.
 - In the remote users' callback, `uid` is the ID of a remote user whose instantaneous volume is one of the three highest.
 */
@property(assign, nonatomic) NSUInteger uid;
/** The volume of each user after audio mixing. The value ranges between 0 (lowest volume) and 255 (highest volume). In
 * the local user's callback, `volume` = `totalVolume`.
 */
@property(assign, nonatomic) NSUInteger volume;
/** Voice activity status of the local user.

 - 0: The local user is not speaking.
 - 1: The local user is speaking.

 **Note**

 - The `vad` parameter cannot report the voice activity status of the remote users. In the remote users' callback, `vad` is always 1.
 - To use this parameter, you must set the `report_vad` parameter to `YES` when calling
 [enableAudioVolumeIndication]([AgoraRtcEngineKit enableAudioVolumeIndication:smooth:report_vad:]).
 */
@property(assign, nonatomic) NSUInteger vad;
/** The name of the channel where the user is in.
 */
@property(copy, nonatomic) NSString* _Nonnull channelId;
@end

/** **Since** v3.5.1. The information of an audio file. This struct is reported in
 [didRequestAudioFileInfo]([AgoraRtcEngineDelegate rtcEngine:didRequestAudioFileInfo:error:]).
 */
__attribute__((visibility("default"))) @interface AgoraRtcAudioFileInfo : NSObject
/** The file path.
 */
@property(copy, nonatomic) NSString* _Nonnull filePath;
/** The file duration (ms).
 */
@property(assign, nonatomic) NSUInteger durationMs;
@end

/** **Since** v3.4.0. The metronome configuration, which is set in [startRhythmPlayer]([AgoraRtcEngineKit startRhythmPlayer:sound2:config:]) or [configRhythmPlayer]([AgoraRtcEngineKit configRhythmPlayer:]). */
__attribute__((visibility("default"))) @interface AgoraRtcRhythmPlayerConfig : NSObject
/** The number of beats per measure. The range is 1 to 9. The default value is 4, which means that each measure
 contains one downbeat and three upbeats.
 */
@property(assign, nonatomic) NSUInteger beatsPerMeasure;
/** Tempo (beats per minute). The range is 60 to 360. The default value is 60, which means that the metronome plays 60
 beats in one minute.
 */
@property(assign, nonatomic) NSUInteger beatsPerMinute;
/** Whether to publish the sound of the metronome to remote users:

 - `YES`: (Default) Publish. Both the local user and remote users can hear the metronome.
 - `NO`: Do not publish. Only the local user can hear the metronome.
 */
@property(assign, nonatomic) BOOL publish;
@end

/** Statistics of the channel
 */
__attribute__((visibility("default"))) @interface AgoraChannelStats : NSObject
/** Call duration of the local user in seconds, represented by an aggregate value.
 */
@property(assign, nonatomic) NSInteger duration;
/** Total number of bytes transmitted, represented by an aggregate value.
 */
@property(assign, nonatomic) NSInteger txBytes;
/** Total number of bytes received, represented by an aggregate value.
 */
@property(assign, nonatomic) NSInteger rxBytes;
/** Total number of audio bytes sent (bytes), represented by an aggregate value.
 */
@property(assign, nonatomic) NSInteger txAudioBytes;
/** Total number of video bytes sent (bytes), represented by an aggregate value.
 */
@property(assign, nonatomic) NSInteger txVideoBytes;
/** Total number of audio bytes received (bytes), represented by an aggregate value.
 */
@property(assign, nonatomic) NSInteger rxAudioBytes;
/** Total number of video bytes received (bytes), represented by an aggregate value.
 */
@property(assign, nonatomic) NSInteger rxVideoBytes;
/** Total packet transmission bitrate (Kbps), represented by an instantaneous value.
 */
@property(assign, nonatomic) NSInteger txKBitrate;
/** Total receive bitrate (Kbps), represented by an instantaneous value.
 */
@property(assign, nonatomic) NSInteger rxKBitrate;
/** Audio packet transmission bitrate (Kbps), represented by an instantaneous value.
 */
@property(assign, nonatomic) NSInteger txAudioKBitrate;
/** Audio receive bitrate (Kbps), represented by an instantaneous value.
 */
@property(assign, nonatomic) NSInteger rxAudioKBitrate;
/** Video transmission bitrate (Kbps), represented by an instantaneous value.
 */
@property(assign, nonatomic) NSInteger txVideoKBitrate;
/** Video receive bitrate (Kbps), represented by an instantaneous value.
 */
@property(assign, nonatomic) NSInteger rxVideoKBitrate;
/** Client-server latency (ms)
 */
@property(assign, nonatomic) NSInteger lastmileDelay;
/** The packet loss rate (%) from the local client to Agora's edge server, before using the anti-packet-loss method.
 */
@property(assign, nonatomic) NSInteger txPacketLossRate;
/** The packet loss rate (%) from Agora's edge server to the local client, before using the anti-packet-loss method.
 */
@property(assign, nonatomic) NSInteger rxPacketLossRate;
/** Number of users in the channel.

- Communication profile: The number of users in the channel.
- Interactive live streaming profile:

  - If the local user is an audience: The number of users in the channel = The number of hosts in the channel + 1.
  - If the user is a host: The number of users in the channel = The number of hosts in the channel.
 */
@property(assign, nonatomic) NSInteger userCount;
/** Application CPU usage (%).
 This property reported in the [didLeaveChannelWithStats]([AgoraRtcEngineDelegate rtcEngine:didLeaveChannelWithStats:]) callback is always `0`.
 */
@property(assign, nonatomic) double cpuAppUsage;
/** System CPU usage (%).
 This property reported in the [didLeaveChannelWithStats]([AgoraRtcEngineDelegate rtcEngine:didLeaveChannelWithStats:]) callback is always `0`.
 */
@property(assign, nonatomic) double cpuTotalUsage;
/** The round-trip time delay (ms) from the client to the local router.

 @note (iOS only) As of v3.3.0, this property is disabled on devices running iOS 14 or later, and enabled on devices running versions earlier than iOS 14 by default. To enable this property on devices running iOS 14 or later, contact [support@agora.io](mailto:support@agora.io). See [FAQ](https://docs.agora.io/en/faq/local_network_privacy) for details.
 */
@property(assign, nonatomic) NSInteger gatewayRtt;
/** The memory usage ratio of the app (%).

 @note This value is for reference only. Due to system limitations, you may not get the value of this member.
 */
@property(assign, nonatomic) double memoryAppUsageRatio;
/** The memory usage ratio of the system (%).

 @note This value is for reference only. Due to system limitations, you may not get the value of this member.
 */
@property(assign, nonatomic) double memoryTotalUsageRatio;
/** The memory usage of the app (KB).

 @note This value is for reference only. Due to system limitations, you may not get the value of this member.
 */
@property(assign, nonatomic) NSInteger memoryAppUsageInKbytes;
@end

/** Properties of the video encoder configuration.
 */
__attribute__((visibility("default"))) @interface AgoraVideoEncoderConfiguration : NSObject
/** The video frame dimension (px) used to specify the video quality in the total number of pixels along a frame's width and height. The default value is 640 * 360.

You can customize the dimension, or select from the following list:

 - AgoraVideoDimension120x120
 - AgoraVideoDimension160x120
 - AgoraVideoDimension180x180
 - AgoraVideoDimension240x180
 - AgoraVideoDimension320x180
 - AgoraVideoDimension240x240
 - AgoraVideoDimension320x240
 - AgoraVideoDimension424x240
 - AgoraVideoDimension360x360
 - AgoraVideoDimension480x360
 - AgoraVideoDimension640x360
 - AgoraVideoDimension480x480
 - AgoraVideoDimension640x480
 - AgoraVideoDimension840x480
 - AgoraVideoDimension960x720
 - AgoraVideoDimension1280x720
 - AgoraVideoDimension1920x1080 (macOS only)

 Note:

 - The dimension does not specify the orientation mode of the output ratio. For how to set the video orientation, see [AgoraVideoOutputOrientationMode](AgoraVideoOutputOrientationMode).
 - Whether 720p can be supported depends on the device. If the device cannot support 720p, the frame rate will be lower than the one listed in the table. Agora optimizes the video in lower-end devices.
 - iPhones do not support video frame dimensions above 720p.
 */
@property(assign, nonatomic) CGSize dimensions;

/** The frame rate of the video (fps).

 You can either set the frame rate manually or choose from the following options. The default value is 15. We do not recommend setting this to a value greater than 30.

  *  AgoraVideoFrameRateFps1(1): 1 fps
  *  AgoraVideoFrameRateFps7(7): 7 fps
  *  AgoraVideoFrameRateFps10(10): 10 fps
  *  AgoraVideoFrameRateFps15(15): 15 fps
  *  AgoraVideoFrameRateFps24(24): 24 fps
  *  AgoraVideoFrameRateFps30(30): 30 fps
  *  AgoraVideoFrameRateFps60(30): 60 fps (macOS only)
 */
@property(assign, nonatomic) NSInteger frameRate;

/** The minimum video encoder frame rate (fps).

The default value is DEFAULT_MIN_BITRATE(-1) (the SDK uses the lowest encoder frame rate). For information on scenarios and considerations, see *Set the Video Profile*.
*/
@property(assign, nonatomic) NSInteger minFrameRate;

/** The bitrate of the video.

 Sets the video bitrate (Kbps). Refer to the table below and set your bitrate. If you set a bitrate beyond the proper range, the SDK automatically adjusts it to a value within the range. You can also choose from the following options:

 - AgoraVideoBitrateStandard: (recommended) the standard bitrate mode. In this mode, the bitrates differ between the interactive live streaming and Communication profiles:

     - Communication profile: the video bitrate is the same as the base bitrate.
     - Interactive live streaming profile: the video bitrate is twice the base bitrate.

 - AgoraVideoBitrateCompatible: the compatible bitrate mode. In this mode, the bitrate stays the same regardless of the profile. In the interactive live streaming profile, if you choose this mode, the video frame rate may be lower than the set value.

Agora uses different video codecs for different profiles to optimize the user experience. For example, the Communication profile prioritizes the smoothness while the interactive live streaming profile prioritizes the video quality (a higher bitrate). Therefore, Agora recommends setting this parameter as AgoraVideoBitrateStandard.

**Video Bitrate Table**

| Resolution        | Frame Rate (fps) | Base Bitrate (Kbps, for Communication) | Live Bitrate (Kbps, for Live Broadcast) |
|-------------------|------------------|----------------------------------------|-----------------------------------------|
| 160 * 120   | 15               | 65                                     | 130                                     |
| 120 * 120   | 15               | 50                                     | 100                                     |
| 320 * 180   | 15               | 140                                    | 280                                     |
| 180 * 180   | 15               | 100                                    | 200                                     |
| 240 * 180   | 15               | 120                                    | 240                                     |
| 320 * 240   | 15               | 200                                    | 400                                     |
| 240 * 240   | 15               | 140                                    | 280                                     |
| 424 * 240   | 15               | 220                                    | 440                                     |
| 640 * 360   | 15               | 400                                    | 800                                     |
| 360 * 360   | 15               | 260                                    | 520                                     |
| 640 * 360   | 30               | 600                                    | 1200                                    |
| 360 * 360   | 30               | 400                                    | 800                                     |
| 480 * 360   | 15               | 320                                    | 640                                     |
| 480 * 360   | 30               | 490                                    | 980                                     |
| 640 * 480   | 15               | 500                                    | 1000                                    |
| 480 * 480   | 15               | 400                                    | 800                                     |
| 640 * 480   | 30               | 750                                    | 1500                                    |
| 480 * 480   | 30               | 600                                    | 1200                                    |
| 848 * 480   | 15               | 610                                    | 1220                                    |
| 848 * 480   | 30               | 930                                    | 1860                                    |
| 640 * 480   | 10               | 400                                    | 800                                     |
| 1280 * 720  | 15               | 1130                                   | 2260                                    |
| 1280 * 720  | 30               | 1710                                   | 3420                                    |
| 960 * 720   | 15               | 910                                    | 1820                                    |
| 960 * 720   | 30               | 1380                                   | 2760                                    |
| 1920 * 1080 | 15               | 2080                                   | 4160                                    |
| 1920 * 1080 | 30               | 3150                                   | 6300                                    |
| 1920 * 1080 | 60               | 4780                                   | 6500                                    |


**Note:**

The base bitrate in this table applies to the Communication profile. The interactive live streaming profile generally requires a higher bitrate for better video quality. Agora recommends setting the bitrate mode as AgoraVideoBitrateStandard. You can also set the bitrate as twice the base bitrate.


*/
@property(assign, nonatomic) NSInteger bitrate;

/** The minimum encoding bitrate.

Sets the minimum encoding bitrate (Kbps).

The Agora SDK automatically adjusts the encoding bitrate to adapt to network conditions. Using a value greater than the default value forces the video encoder to output high-quality images but may cause more packet loss and hence sacrifice the smoothness of the video transmission. Unless you have special requirements for image quality, Agora does not recommend changing this value.

**Note:**

This parameter applies only to the interactive live streaming profile.*/
@property(assign, nonatomic) NSInteger minBitrate;

/** The video orientation mode of the video: AgoraVideoOutputOrientationMode.

 * AgoraVideoOutputOrientationModeAdaptative(0): (Default) The output video always follows the orientation of the captured video, because the receiver takes the rotational information passed on from the video encoder.
   - If the captured video is in landscape mode, the output video is in landscape mode.
   - If the captured video is in portrait mode, the output video is in portrait mode.
 * AgoraVideoOutputOrientationModeFixedLandscape(1): The output video is always in landscape mode. If the captured video is in portrait mode, the video encoder crops it to fit the output. This applies to situations where the receiver cannot process the rotational information. For example, CDN live streaming.
 * AgoraVideoOutputOrientationModeFixedPortrait(2): The output video is always in portrait mode. If the captured video is in landscape mode, the video encoder crops it to fit the output. This applies to situations where the receiver cannot process the rotational information. For example, CDN live streaming.

For scenarios with video rotation, Agora provides *Rotate the Video* to guide users on how to set this parameter to get the preferred video orientation.

 */
@property(assign, nonatomic) AgoraVideoOutputOrientationMode orientationMode;

/** The video encoding degradation preference under limited bandwidth.

AgoraDegradationPreference:

* AgoraDegradationMaintainQuality(0): (Default) Degrades the frame rate to guarantee the video quality.
* AgoraDegradationMaintainFramerate(1): Degrades the video quality to guarantee the frame rate.
*/
@property(assign, nonatomic) AgoraDegradationPreference degradationPreference;

/** Sets the mirror mode of the published local video stream. It only affects the video that the remote user sees. See [AgoraVideoMirrorMode](AgoraVideoMirrorMode).

 **Note**

 The SDK disables the mirror mode by default.
 */
@property(assign, nonatomic) AgoraVideoMirrorMode mirrorMode;

/** Initializes and returns a newly allocated AgoraVideoEncoderConfiguration object with the specified video resolution.

 @param size Video resolution.
 @param frameRate Video frame rate.
 @param bitrate Video bitrate.
 @param orientationMode AgoraVideoOutputOrientationMode.
 @return An initialized `AgoraVideoEncoderConfiguration` object.
 */
- (instancetype _Nonnull)initWithSize:(CGSize)size frameRate:(AgoraVideoFrameRate)frameRate bitrate:(NSInteger)bitrate orientationMode:(AgoraVideoOutputOrientationMode)orientationMode;

/** Initializes and returns a newly allocated AgoraVideoEncoderConfiguration object with the specified video width and height.

 @param width Width of the video.
 @param height Height of the video.
 @param frameRate Video frame rate.
 @param bitrate Video bitrate.
 @param orientationMode AgoraVideoOutputOrientationMode.
 @return An initialized `AgoraVideoEncoderConfiguration` object.
 */
- (instancetype _Nonnull)initWithWidth:(NSInteger)width height:(NSInteger)height frameRate:(AgoraVideoFrameRate)frameRate bitrate:(NSInteger)bitrate orientationMode:(AgoraVideoOutputOrientationMode)orientationMode;
@end

/** Properties of the screen sharing encoding parameters.
 */
__attribute__((visibility("default"))) @interface AgoraScreenCaptureParameters : NSObject
/**  The maximum encoding dimensions for screen sharing.

The default value is 1920 * 1080 pixels, that is, 2073600 pixels. Agora uses the value of this parameter to calculate the charges.

If the aspect ratio is different between the encoding dimensions and screen dimensions, Agora applies the following algorithms for encoding. Suppose the encoding dimensions are 1920 * 1080:

- If the value of the screen dimensions is lower than that of the encoding dimensions, for example, 1000 * 1000, the SDK uses 1000 * 1000 for encoding.
- If the value of the screen dimensions is higher than that of the encoding dimensions, for example, 2000 * 1500, the SDK uses the maximum value under 1920 * 1080 with the aspect ratio of the screen dimension (4:3) for encoding, that is, 1440 * 1080.

In either case, Agora uses the value of this parameter to calculate the charges.
 */
@property(assign, nonatomic) CGSize dimensions;

/** The frame rate (fps) of the shared region. The default value is 5. We do not recommend setting this to a value greater than 15.
 */
@property(assign, nonatomic) NSInteger frameRate;

/** The bitrate (Kbps) of the shared region. The default value is 0 (the SDK works out a bitrate according to the dimensions of the current screen).
 */
@property(assign, nonatomic) NSInteger bitrate;

/** Sets whether to capture the mouse for screen sharing.

- YES: (Default) Capture the mouse.
- NO: Do not capture the mouse.
 */
@property(assign, nonatomic) BOOL captureMouseCursor;

/** Whether to bring the window to the front when calling [startScreenCaptureByWindowId]([AgoraRtcEngineKit startScreenCaptureByWindowId:rectangle:parameters:]) to share the window:

 - YES: Bring the window to the front.
 - NO: (Default) Do not bring the window to the front.

 @since v3.1.0
 */
@property(assign, nonatomic) BOOL windowFocus;

/** A list of IDs of windows to be blocked.

 When calling [startScreenCaptureByDisplayId]([AgoraRtcEngineKit startScreenCaptureByDisplayId:rectangle:parameters:])
 and pass `0` in the `displayId` parameter to start sharing a main screen, you can use this parameter to block the specified windows. When calling
 [updateScreenCaptureParameters]([AgoraRtcEngineKit updateScreenCaptureParameters:]) to update the configuration for the main screen sharing, you can use this
 parameter to dynamically block the specified windows during the main screen sharing.

 @since v3.1.0
 */
@property(copy, nonatomic) NSArray* _Nullable excludeWindowList;

@end

/** A class for providing user-specific CDN live audio/video transcoding settings.
 */
__attribute__((visibility("default"))) @interface AgoraLiveTranscodingUser : NSObject
/** User ID of the CDN live host.
 */
@property(assign, nonatomic) NSUInteger uid;
/** Size and the position of the video frame relative to the top left corner.
 */
@property(assign, nonatomic) CGRect rect;
/**  The layer index of the video frame.

 From v2.3.0, the Agora SDK supports setting zOrder as 0.

 An integer. The value range is [0,100].

 - 0: (Default) Bottom layer.
 - 100: Top layer.

 Note: If the value is set lower than 0 or higher than 100, the `AgoraErrorCodeInvalidArgument` error occurs.
 */
@property(assign, nonatomic) NSInteger zOrder;
/** The transparency level of the user's video.

 The value ranges between 0.0 and 1.0:

 * 0.0: Completely transparent.
 * 1.0: (Default) Opaque.
 */
@property(assign, nonatomic) double alpha;
/** The audio channel of the sound.

 The default value is 0:

    - 0: (Default) Supports dual channels. Depends on the upstream of the host.
    - 1: The audio stream of the host uses the FL audio channel. If the upstream of the host uses multiple audio channels, these channels will be mixed into mono first.
    - 2: The audio stream of the host uses the FC audio channel. If the upstream of the host uses multiple audio channels, these channels will be mixed into mono first.
    - 3: The audio stream of the host uses the FR audio channel. If the upstream of the host uses multiple audio channels, these channels will be mixed into mono first.
    - 4: The audio stream of the host uses the BL audio channel. If the upstream of the host uses multiple audio channels, these channels will be mixed into mono first.
    - 5: The audio stream of the host uses the BR audio channel. If the upstream of the host uses multiple audio channels, these channels will be mixed into mono first.

Note: If your setting is not 0, you may need a specialized player.
 */
@property(assign, nonatomic) NSInteger audioChannel;
@end

/** The advanced feature for high-quality video with a lower bitrate. */
extern NSString* _Nonnull const LBHQ;
/** The advanced feature for the optimized video encoder. */
extern NSString* _Nonnull const VEO;

__attribute__((visibility("default"))) @interface AgoraLiveStreamAdvancedFeature : NSObject

@property(copy, nonatomic) NSString* _Nullable featureName;

@property(assign, nonatomic) BOOL opened;
@end

/** Image properties.

 A class for setting the properties of the watermark and background images in live broadcasting.
 */
__attribute__((visibility("default"))) @interface AgoraImage : NSObject
/** URL address of the image on the broadcasting video.

The maximum length of this parameter is 1024 bytes.
 */
@property(strong, nonatomic) NSURL* _Nonnull url;
/** Position and size of the image on the broadcasting video in CGRect.
 */
@property(assign, nonatomic) CGRect rect;
@end

/** The options of the watermark image to be added.
 */
__attribute__((visibility("default"))) @interface WatermarkOptions : NSObject
/** Sets whether or not the watermark image is visible in the local video preview:

 - YES: (Default) The watermark image is visible in preview.
 - NO: The watermark image is not visible in preview.
 */
@property(assign, nonatomic) BOOL visibleInPreview;
/** The watermark position in landscape mode of *Rotate the Video*. This parameter contains the following members:

  - `x`: The horizontal offset of the watermark from the top-left corner.
  - `y`: The vertical offset of the watermark from the top-left corner.
  - `width`: The width (pixel) of the watermark region.
  - `height`: The height (pixel) of the watermark region.
 */
@property(assign, nonatomic) CGRect positionInLandscapeMode;
/** The watermark position in portrait mode of *Rotate the Video*. This parameter contains the following members:

  - `x`: The horizontal offset of the watermark from the top-left corner.
  - `y`: The vertical offset of the watermark from the top-left corner.
  - `width`: The width (pixel) of the watermark region.
  - `height`: The height (pixel) of the watermark region.
 */
@property(assign, nonatomic) CGRect positionInPortraitMode;
@end

/** A class for managing user-specific CDN live audio/video transcoding settings.
 */
__attribute__((visibility("default"))) @interface AgoraLiveTranscoding : NSObject
/** The size of the video (width and height in pixels).

- When pushing video streams to the CDN, note the following:

  - The value range of the width is [64,1920]. If the value is less than 64,
  Agora server automatically adjusts it to 64; if the value is greater than
  1920, Agora server automatically adjusts it to 1920.
  - The value range of the height is [64,1080]. If the value is less than 64,
  Agora server automatically adjusts it to 64; if the value is greater than
  1080, Agora server automatically adjusts it to 1080.

- When pushing audio streams to the CDN, set the width and height as 0.
 */
@property(assign, nonatomic) CGSize size;
/** Bitrate of the CDN live output video stream.

The default value is 400 Kbps.

Set this parameter according to the Video Bitrate Table. If you set a bitrate beyond the proper range, the SDK automatically adapts it to a value within the range.
 */
@property(assign, nonatomic) NSInteger videoBitrate;
/** Frame rate of the CDN live output video stream.

The default value is 15 fps, and the value range is (0,30].

 @note The Agora server adjusts any value over 30 to 30.
 */
@property(assign, nonatomic) NSInteger videoFramerate;
/** Latency mode. **DEPRECATED** from v2.8.0

 * YES: Low latency with unassured quality.
 * NO:（Default）High latency with assured quality.
 */
@property(assign, nonatomic) BOOL lowLatency;
/** Video GOP in frames. The default value is 30 fps. */
@property(assign, nonatomic) NSInteger videoGop;
/** Video codec profile type

Set it as 66, 77, or 100 (default), see [AgoraVideoCodecProfileType](AgoraVideoCodecProfileType).

If you set this parameter to other values, Agora adjusts it to the default value of 100.
 */
@property(assign, nonatomic) AgoraVideoCodecProfileType videoCodecProfile;

/** The video codec type of the output video stream. See AgoraVideoCodecTypeForStream.

 @since v3.2.0
 */
@property(assign, nonatomic) AgoraVideoCodecTypeForStream videoCodecType;

/** An AgoraLiveTranscodingUser object managing the user layout configuration in the CDN live stream. Agora supports a maximum of 17 transcoding users in a CDN live stream channel. See AgoraLiveTranscodingUser.
 */
@property(copy, nonatomic) NSArray<AgoraLiveTranscodingUser*>* _Nullable transcodingUsers;

/** Reserved property. Extra user-defined information to send SEI for the H.264/H.265 video stream to the CDN live client. Maximum length: 4096 bytes. For more information on SEI, see [SEI-related questions](https://docs.agora.io/en/faq/sei).
 */
@property(copy, nonatomic) NSString* _Nullable transcodingExtraInfo;
/** The watermark image added to the CDN live publishing stream.

The audience of the CDN live publishing stream can see the watermark. Ensure that the format of the image is PNG.

See AgoraImage for the definition of the watermark.
 */
@property(strong, nonatomic) AgoraImage* _Nullable watermark;
/** The background image added to the CDN live publishing stream.

The audience of the CDN live publishing stream can see the background image. See AgoraImage for the definition of the background image.
 */
@property(strong, nonatomic) AgoraImage* _Nullable backgroundImage;
/** The background color in RGB hex.

Value only. Do not include a preceding #. For example, 0xFFB6C1 (light pink). The default value is 0x000000 (black).

COLOR_CLASS is a general name for the type:

* iOS: UIColor
* macOS: NSColor
 */
@property(strong, nonatomic) COLOR_CLASS* _Nullable backgroundColor;

/** Self-defined audio sample rate: AgoraAudioSampleRateType.
 */
@property(assign, nonatomic) AgoraAudioSampleRateType audioSampleRate;
/** Bitrate (Kbps) of the CDN live audio output stream. The default value is 48, and the highest value is 128.
 */
@property(assign, nonatomic) NSInteger audioBitrate;
/** The number of audio channels for the CDN live stream.

 Agora recommends choosing 1 (mono), or 2 (stereo) audio channels. Special players are required if you choose 3, 4, or 5.

 * 1: (Default) Mono
 * 2: Stereo
 * 3: Three audio channels
 * 4: Four audio channels
 * 5: Five audio channels
 */
@property(assign, nonatomic) NSInteger audioChannels;
/**
 Audio codec profile. See AgoraAudioCodecProfileType.

 The default value is AgoraAudioCodecProfileLCAAC(0).
 */
@property(assign, nonatomic) AgoraAudioCodecProfileType audioCodecProfile;

/** Creates a default transcoding object.

 @return Default AgoraLiveTranscoding object.
 */
+ (AgoraLiveTranscoding* _Nonnull)defaultTranscoding;

/** Adds a user displaying the video in CDN live.

 @param user The transcoding user. See AgoraLiveTranscodingUser.

 @return - 0: Success.
 - < 0: Failure.
 */
- (int)addUser:(AgoraLiveTranscodingUser* _Nonnull)user;

/** Removes a user from CDN live.

 @param uid The user ID of the user to remove from CDN live.

 @return - 0: Success.
 - < 0: Failure.
 */
- (int)removeUser:(NSUInteger)uid;

- (void)setAdvancedFeatures:(NSString* _Nonnull)featureName opened:(BOOL)opened;

- (NSArray<AgoraLiveStreamAdvancedFeature*>* _Nullable)getAdvancedFeatures;

@end

/** Configuration of the imported interactive live streaming.
 */
__attribute__((visibility("default"))) @interface AgoraLiveInjectStreamConfig : NSObject
/** Size of the added stream to the interactive live streaming.

The default value is 0; same size as the original stream.
 */
@property(assign, nonatomic) CGSize size;
/** Video GOP of the added stream to the interactive live streaming.

The default value is 30 fps.
 */
@property(assign, nonatomic) NSInteger videoGop;
/** Video frame rate of the added stream to the interactive live streaming.

The default value is 15 fps.
 */
@property(assign, nonatomic) NSInteger videoFramerate;
/** Video bitrate of the added stream to the interactive live streaming.

The default value is 400 Kbps.

The setting of the video bitrate is closely linked to the resolution. If the video bitrate you set is beyond a reasonable range, the SDK will set it within a reasonable range instead.
 */
@property(assign, nonatomic) NSInteger videoBitrate;

/** Audio sample rate of the added stream to the interactive live streaming.

The default value is 48000 Hz. See AgoraAudioSampleRateType for details.

**Note:**

Agora recommends using the default value.
 */
@property(assign, nonatomic) AgoraAudioSampleRateType audioSampleRate;
/** Audio bitrate of the added stream to the interactive live streaming.

The default value is 48 Kbps.

**Note:**

Agora recommends using the default value.
 */
@property(assign, nonatomic) NSInteger audioBitrate;
/** Number of audio channels to add to the interactive live streaming. The values are 1 and 2.

The default value is 1.

**Note:**

Agora recommends using the default value.
 */
@property(assign, nonatomic) NSInteger audioChannels;

/** Creates a default stream configuration object.

 @return Default stream configuration object.
 */
+ (AgoraLiveInjectStreamConfig* _Nonnull)defaultConfig;

@end

/** The configuration of camera capturer.
 */
__attribute__((visibility("default"))) @interface AgoraCameraCapturerConfiguration : NSObject
/** This preference will balance the performance and preview quality by adjusting camera output frame size. See AgoraCameraCaptureOutputPreference.
 */
@property(assign, nonatomic) AgoraCameraCaptureOutputPreference preference;
/** The width (px) of the video image captured by the local camera. To
 customize the width of the video image, set preference as
 `AgoraCameraCaptureOutputPreferenceManual(3)` first, and then use this parameter.

 @since v3.3.0
 */
@property(assign, nonatomic) int captureWidth;
/** The height (px) of the video image captured by the local camera. To
 customize the height of the video image, set preference as
 `AgoraCameraCaptureOutputPreferenceManual(3)` first, and then use this parameter.

 @since v3.3.0
 */
@property(assign, nonatomic) int captureHeight;

#if defined(TARGET_OS_IOS) && TARGET_OS_IOS
/** The camera direction. See AgoraCameraDirection:

 - AgoraCameraDirectionRear: The rear camera.
 - AgoraCameraDirectionFront: The front camera.

 @note This method applies to iOS only.
 */
@property(assign, nonatomic) AgoraCameraDirection cameraDirection;

/** Sets the local camera capture behavior.

 Before calling this method, ensure that you have called
 [setCameraCapturerConfiguration]([AgoraRtcEngineKit setCameraCapturerConfiguration:])
 to set the camera capture configuration as `AgoraCameraCaptureOutputPreferenceManual(3)`.

 @note This method applies to iOS only.

 @param size The size of the video image captured by the local camera.
 @param facing The camera direction. See AgoraCameraDirection.

 @return An initialized AgoraCameraCapturerConfiguration object.
 */
- (instancetype _Nonnull)initWithSize:(CGSize)size facing:(AgoraCameraDirection)facing;

/** Sets the local camera capture behavior.

 Before calling this method, ensure that you have called
 [setCameraCapturerConfiguration]([AgoraRtcEngineKit setCameraCapturerConfiguration:])
 to set the camera capture configuration as `AgoraCameraCaptureOutputPreferenceManual(3)`.

 @note This method applies to iOS only.

 @param width The width (px) of the video image captured by the local camera.
 @param height The height (px) of the video image captured by the local camera.
 @param facing The camera direction. See AgoraCameraDirection.

 @return An initialized AgoraCameraCapturerConfiguration object.
 */
- (instancetype _Nonnull)initWithWidth:(NSInteger)width height:(NSInteger)height facing:(AgoraCameraDirection)facing;
#endif

#if (!(TARGET_OS_IPHONE) && (TARGET_OS_MAC))
/** Sets the local camera capture behavior.

 Before calling this method, ensure that you have called
 [setCameraCapturerConfiguration]([AgoraRtcEngineKit setCameraCapturerConfiguration:])
 to set the camera capture configuration as `AgoraCameraCaptureOutputPreferenceManual(3)`.

 @note This method applies to macOS only.

 @param size The size of the video image captured by the local camera.

 @return An initialized `AgoraCameraCapturerConfiguration` object.
 */
- (instancetype _Nonnull)initWithSize:(CGSize)size;

/** Sets the local camera capture behavior.

 Before calling this method, ensure that you have called
 [setCameraCapturerConfiguration]([AgoraRtcEngineKit setCameraCapturerConfiguration:])
 to set the camera capture configuration as `AgoraCameraCaptureOutputPreferenceManual(3)`.

 @note This method applies to macOS only.

 @param width The width (px) of the video image captured by the local camera.
 @param height The height (px) of the video image captured by the local camera.

 @return An initialized `AgoraCameraCapturerConfiguration` object.
 */
- (instancetype _Nonnull)initWithWidth:(NSInteger)width height:(NSInteger)height;
#endif

@end

#if (!(TARGET_OS_IPHONE) && (TARGET_OS_MAC))

/** AgoraRtcDeviceInfo array. (macOS only)
 */
__attribute__((visibility("default"))) @interface AgoraRtcDeviceInfo : NSObject
@property(assign, nonatomic) int __deprecated index;

/** Device type: AgoraMediaDeviceType.
 */
@property(assign, nonatomic) AgoraMediaDeviceType type;

/** Device ID.
 */
@property(copy, nonatomic) NSString* _Nullable deviceId;

/** Device name.
 */
@property(copy, nonatomic) NSString* _Nullable deviceName;
@end

/** The image content of the thumbnail or icon. (macOS only)

 @since v3.5.2

 @note The default image is in the RGBA format. If you need to use another
 format, you need to convert the image on your own.
 */
__attribute__((visibility("default"))) @interface AgoraThumbImageBuffer : NSObject
/**
 The NSImage of the thumbnail or icon.
 */
@property(strong, nonatomic, readonly) NSImage* _Nonnull image;
/**
 The buffer of the thumbnail or icon.
 */
@property(copy, nonatomic) NSData* _Nonnull buffer;
/**
 The buffer length (bytes) of the thumbnail or icon.
 */
@property(assign, nonatomic) NSUInteger length;
/**
 The actual width (px) of the thumbnail or icon.
 */
@property(assign, nonatomic) NSUInteger width;
/**
 The actual height (px) of the thumbnail or icon.
 */
@property(assign, nonatomic) NSUInteger height;

@end
/**
 The AgoraScreenCaptureSourceInfo interface. (macOS only)

 @since v3.5.2
 */
__attribute__((visibility("default"))) @interface AgoraScreenCaptureSourceInfo : NSObject
/** The type of the shared target. See ScreenCaptureSourceType. */
@property(assign, nonatomic) AgoraScreenCaptureSourceType type;
/** The window ID for a window or the display ID for a screen. */
@property(assign, nonatomic) CGWindowID sourceId;
/** The name of the window or screen. UTF-8 encoding. */
@property(copy, nonatomic) NSString* _Nonnull sourceName;
/** The image content of the thumbnail. See AgoraThumbImageBuffer. */
@property(strong, nonatomic) AgoraThumbImageBuffer* _Nonnull thumbImage;
/** The image content of the icon. See AgoraThumbImageBuffer. */
@property(strong, nonatomic) AgoraThumbImageBuffer* _Nullable iconImage;
/** The process to which the window belongs. UTF-8 encoding. */
@property(copy, nonatomic) NSString* _Nonnull processPath;
/** The title of the window. UTF-8 encoding. */
@property(copy, nonatomic) NSString* _Nonnull sourceTitle;
/** Determines whether the screen is the primary display:

 - YES: The screen is the primary display.
 - NO: The screen is not the primary display.
 */
@property(assign, nonatomic) BOOL primaryMonitor;

@end

#endif

/** Video frame containing the Agora SDK's encoded video data.
 */
__attribute__((visibility("default"))) @interface AgoraVideoFrame : NSObject
/** Video format:

 * 1: I420
 * 2: BGRA
 * 3: NV21
 * 4: RGBA
 * 5: IMC2
 * 7: ARGB
 * 8: NV12
 * 12: iOS texture (CVPixelBufferRef)
 * 16: I422
 */
@property(assign, nonatomic) NSInteger format;

/** Timestamp of the incoming video frame (ms).

An incorrect timestamp results in frame loss or unsynchronized audio and video.

 */
@property(assign, nonatomic) CMTime time;  // Time for this frame.

@property(assign, nonatomic) int stride DEPRECATED_MSG_ATTRIBUTE("use strideInPixels instead");

/** Line spacing of the incoming video frame, which must be in pixels instead of bytes. For textures, it is the width of the texture.
 */
@property(assign, nonatomic) int strideInPixels;  // Number of pixels between two consecutive rows. Note: in pixel, not byte. Not used for iOS textures.

/** Height of the incoming video frame
 */
@property(assign, nonatomic) int height;  // Number of rows of pixels. Not used for iOS textures.

/** CVPixelBuffer
 */
@property(assign, nonatomic) CVPixelBufferRef _Nullable textureBuf;

/** Raw data buffer
 */
@property(strong, nonatomic) NSData* _Nullable dataBuf;  // Raw data buffer. Not used for iOS textures.

/** (Optional) The number of pixels trimmed from the left. The default value is 0.
 */
@property(assign, nonatomic) int cropLeft;  // Number of pixels to crop on the left boundary.
/** (Optional) The number of pixels trimmed from the top. The default value is 0.
 */
@property(assign, nonatomic) int cropTop;  // Number of pixels to crop on the top boundary.
/** (Optional) The number of pixels trimmed from the right. The default value is 0.
 */
@property(assign, nonatomic) int cropRight;  // Number of pixels to crop on the right boundary.
/** (Optional) The number of pixels trimmed from the bottom. The default value is 0.
 */
@property(assign, nonatomic) int cropBottom;  // Number of pixels to crop on the bottom boundary.
/** (Optional) The clockwise rotation of the incoming video frame.

Optional values: 0, 90, 180, or 270. The default value is 0.
 */
@property(assign, nonatomic) int rotation;  // 0, 90, 180, 270. See document for rotation calculation.
/* Note
 * 1. strideInPixels
 *    Stride is in pixels, not bytes.
 * 2. About the frame width and height.
 *    No field is defined for the width. However, it can be deduced by:
 *       croppedWidth = (strideInPixels - cropLeft - cropRight)
 *    And
 *       croppedHeight = (height - cropTop - cropBottom)
 * 3. About crop.
 *    _________________________________________________________________.....
 *    |                        ^                                      |  ^
 *    |                        |                                      |  |
 *    |                     cropTop                                   |  |
 *    |                        |                                      |  |
 *    |                        v                                      |  |
 *    |                ________________________________               |  |
 *    |                |                              |               |  |
 *    |                |                              |               |  |
 *    |<-- cropLeft -->|          valid region        |<- cropRight ->|
 *    |                |                              |               | height
 *    |                |                              |               |
 *    |                |_____________________________ |               |  |
 *    |                        ^                                      |  |
 *    |                        |                                      |  |
 *    |                     cropBottom                                |  |
 *    |                        |                                      |  |
 *    |                        v                                      |  v
 *    _________________________________________________________________......
 *    |                                                               |
 *    |<---------------- strideInPixels ----------------------------->|
 *
 *    If your buffer contains garbage data, you can crop them. For example, if the frame size is
 *    360 * 640, often the buffer stride is 368, that is, the extra 8 pixels on the
 *    right are for padding, and should be removed. In this case, you can set:
 *    strideInPixels = 368;
 *    height = 640;
 *    cropRight = 8;
 *    // cropLeft, cropTop, cropBottom are set to a default of 0
 */
@end

/** The definition of AgoraChannelMediaRelayInfo.
 */
__attribute__((visibility("default"))) @interface AgoraChannelMediaRelayInfo : NSObject
/** The token that enables the user to join the channel.
 */
@property(copy, nonatomic) NSString* _Nullable token;
/** The channel name.
 */
@property(copy, nonatomic) NSString* _Nullable channelName;
/** The user ID.
 */
@property(assign, nonatomic) NSUInteger uid;
/** Initializes the AgoraChannelMediaRelayInfo object

 @param token The token that enables the user to join the channel.
 */
- (instancetype _Nonnull)initWithToken:(NSString* _Nullable)token;
@end

/** The configurations for the data stream.

 The following table shows the relationship between the `syncWithAudio`
 parameter and the `ordered` parameter:

 | `syncWithAudio` | `ordered` | SDK behaviors                                                |
 | :-------------- | :-------- | :----------------------------------------------------------- |
 | `NO`         | `NO`   | The SDK triggers the `receiveStreamMessageFromUid` callback immediately after the receiver receives a data packet. |
 | `YES`          | `NO`   | <li>If the data packet delay is within the audio delay, the SDK triggers the `receiveStreamMessageFromUid` callback when the synchronized audio packet is played out.</li><li>If the data packet delay exceeds the audio delay, the SDK triggers the `receiveStreamMessageFromUid` callback as soon as the data packet is received. In this case, the data packet is not synchronized with the audio packet.</li> |
 | `NO`         | `YES`    | <li>If the delay of a data packet is within five seconds, the SDK corrects the order of the data packet.</li><li>If the delay of a data packet exceeds five seconds, the SDK discards the data packet.</li>|
 | `YES`          | `YES`    | <li>If the delay of a data packet is within the audio delay, the SDK corrects the order of the data packet.</li><li>If the delay of a data packet exceeds the audio delay, the SDK discards this data packet.</li> |
 */
__attribute__((visibility("default"))) @interface AgoraDataStreamConfig : NSObject

/** Whether the SDK guarantees that the receiver receives the data in the sent
 order.

 - `YES`: Guarantee that the receiver receives the data in the sent order.
 - `NO`: Do not guarantee that the receiver receives the data in the sent order.

 Do not set this parameter to `YES` if you need the receiver to receive
 the data immediately.
 */
@property(assign, nonatomic) BOOL ordered;

/** Whether to synchronize the data packet with the published audio packet.

 - `YES`: Synchronize the data packet with the audio packet.
 - `NO`: Do not synchronize the data packet with the audio packet.

 When you set the data packet to synchronize with the audio, then if the data
 packet delay is within the audio delay range, the SDK triggers the `receiveStreamMessageFromUid`
 callback when the synchronized audio packet is played out. Do not set this
 parameter as `YES` if you need the receiver to receive the data packet
 immediately. Agora recommends that you set this parameter to `YES` only
 when you need to implement specific functions, for example lyric
 synchronization.
 */
@property(assign, nonatomic) BOOL syncWithAudio;
@end

/** The definition of AgoraChannelMediaRelayConfiguration.

 */
__attribute__((visibility("default"))) @interface AgoraChannelMediaRelayConfiguration : NSObject
/** The information of the destination channel: AgoraChannelMediaRelayInfo. It contains the following members:

 - `channelName`: The name of the destination channel.
 - `uid`: The unique ID to identify the relay stream in the destination channel. The value ranges from 0 to (2<sup>32</sup>-1). Do not set this parameter as the `uid` of the host in the destination channel, and ensure that this `uid` is different from any other `uid` in the channel. The default value is 0, which means the SDK generates a random UID.
 - `token`: The token for joining the destination channel. It is generated with the `channelName` and `uid` you set in `destinationInfos`.

   - If you have not enabled the App Certificate, set this parameter as the default value `nil`, which means the SDK applies the App ID.
   - If you have enabled the App Certificate, you must use the `token` generated with the `channelName` and `uid`.
 */
@property(strong, nonatomic, readonly) NSDictionary<NSString*, AgoraChannelMediaRelayInfo*>* _Nullable destinationInfos;
/** The information of the source channel: AgoraChannelMediaRelayInfo. It contains the following members:

 - `channelName`: The name of the source channel. The default value is `nil`, which means the SDK applies the name of the current channel.
 - `uid`: The unique ID to identify the relay stream in the source channel. The default value is 0, which means the SDK generates a random UID. You must set it as 0.
 - `token`: The token for joining the source channel. It is generated with the `channelName` and `uid` you set in `sourceInfo`.

   - If you have not enabled the App Certificate, set this parameter as the default value `nil`, which means the SDK applies the App ID.
   - If you have enabled the App Certificate, you must use the `token` generated with the `channelName` and `uid`, and the `uid` must be set as 0.
 */
@property(strong, nonatomic) AgoraChannelMediaRelayInfo* _Nonnull sourceInfo;
/** Sets the information of the destination channel.

 If you want to relay the media stream to multiple channels, call this method as many times (at most four).

 @param destinationInfo The information of the destination channel: AgoraChannelMediaRelayInfo. It contains the following members:

 - `channelName`: The name of the destination channel.
 - `uid`: The unique ID to identify the relay stream in the destination channel. The value ranges from 0 to (2<sup>32</sup>-1). Do not set this parameter as the `uid` of the host in the destination channel, and ensure that this `uid` is different from any other `uid` in the channel. The default value is 0, which means the SDK generates a random UID.
 - `token`: The token for joining the destination channel. It is generated with the `channelName` and `uid` you set in `destinationInfo`.

   - If you have not enabled the App Certificate, set this parameter as the default value `nil`, which means the SDK applies the App ID.
   - If you have enabled the App Certificate, you must use the `token` generated with the `channelName` and `uid`.

 @param channelName The name of the destination channel. Ensure that the value of this parameter is the same as that of the `channelName` member in `destinationInfo`.

 @return - YES: Success.
 - NO: Failure.
 */
- (BOOL)setDestinationInfo:(AgoraChannelMediaRelayInfo* _Nonnull)destinationInfo forChannelName:(NSString* _Nonnull)channelName;
/** Removes the destination channel.

 @param channelName The name of the destination channel.

 @return - YES: Success.
 - NO: Failure.
 */
- (BOOL)removeDestinationInfoForChannelName:(NSString* _Nonnull)channelName;
@end

/** The image enhancement options in [setBeautyEffectOptions]([AgoraRtcEngineKit setBeautyEffectOptions:options:]). */
__attribute__((visibility("default"))) @interface AgoraBeautyOptions : NSObject

/** The lightening contrast level

[AgoraLighteningContrastLevel](AgoraLighteningContrastLevel), used with the lighteningLevel property:

- 0: Low contrast level.
- 1: (Default) Normal contrast level.
- 2: High contrast level.
*/
@property(nonatomic, assign) AgoraLighteningContrastLevel lighteningContrastLevel;

/** The brightness level.

The default value is 0.7. The value ranges from 0.0 (original) to 1.0.
 */
@property(nonatomic, assign) float lighteningLevel;

/** The sharpness level.

The default value is 0.5. The value ranges from 0.0 (original) to 1.0. This parameter is usually used to remove blemishes.
 */
@property(nonatomic, assign) float smoothnessLevel;

/** The redness level.

The default value is 0.1. The value ranges from 0.0 (original) to 1.0. This parameter adjusts the red saturation level.
*/
@property(nonatomic, assign) float rednessLevel;

@end

/** <b>Since</b> v3.4.5. The custom background image.
 */
__attribute__((visibility("default"))) @interface AgoraVirtualBackgroundSource : NSObject

/** The type of the custom background image. See AgoraVirtualBackgroundSourceType.
 */
@property(nonatomic, assign) AgoraVirtualBackgroundSourceType backgroundSourceType;

/** The color of the custom background image. The format is a hexadecimal
 integer defined by RGB, without the # sign, such as `0xFFB6C1` for light pink.
 The default value is `0xFFFFFF`, which signifies white. The value range is
 [0x000000,0xFFFFFF]. If the value is invalid, the SDK replaces the original
 background image with a white background image.
 <p><b>Note</b>: This parameter takes effect only when the type of the custom
 background image is <code>AgoraVirtualBackgroundColor</code>.</p>
 */
@property(nonatomic, assign) NSUInteger color;

/** The local absolute path of the custom background image. PNG and JPG formats
 are supported. If the path is invalid, the SDK replaces the original
 background image with a white background image.
 <p><b>Note</b>: This parameter takes effect only when the type of the custom
 background image is <code>AgoraVirtualBackgroundImg</code>.</p>
 */
@property(nonatomic, copy) NSString* _Nullable source;

/** The degree of blurring applied to the custom background image. See AgoraBlurDegree.
 <p><b>Note</b>: This parameter takes effect only when the type of the custom
 background image is <code>AgoraVirtualBackgroundBlur</code>.</p>

 @since v3.5.1
 */
@property(nonatomic, assign) AgoraBlurDegree blur_degree;

@end

/** The user information, including the user ID and user account. */
__attribute__((visibility("default"))) @interface AgoraUserInfo : NSObject
/** The user ID of a user.
 */
@property(nonatomic, assign) NSUInteger uid;
/** The user account of a user.
 */
@property(copy, nonatomic) NSString* _Nullable userAccount;
@end

/** The channel media options.
 */
__attribute__((visibility("default"))) @interface AgoraRtcChannelMediaOptions : NSObject
/** Determines whether to automatically subscribe to all remote audio streams
 when the user joins a channel.

 - YES: (Default) Subscribe.
 - NO: Do not subscribe.

 This member variable serves a similar function to the `muteAllRemoteAudioStreams`
 method. After joining the channel, you can call the
 `muteAllRemoteAudioStreams` method to set whether to subscribe to all remote
 audio streams in the channel.
 */
@property(nonatomic, assign) BOOL autoSubscribeAudio;
/** Determines whether to automatically subscribe to all remote video streams
 when the user joins a channel.

 - YES: (Default) Subscribe.
 - NO: Do not subscribe.

 This member variable serves a similar function to the `muteAllRemoteVideoStreams`
 method. After joining the channel, you can call the
 `muteAllRemoteVideoStreams` method to set whether to subscribe to all remote
 video streams in the channel.
 */
@property(nonatomic, assign) BOOL autoSubscribeVideo;
/** Sets whether to publish the local audio stream when the user joins a channel:

 - `YES`: (Default) Publish.
 - `NO`: Do not publish.

 This member serves a similar function to the `muteLocalAudioStream` method.
 After the user joins the channel, you can call the `muteLocalAudioStream`
 method to set whether to publish the local audio stream in the channel.

 @since v3.4.5
 */
@property(nonatomic, assign) BOOL publishLocalAudio;
/** Sets whether to publish the local video stream when the user joins a channel:

 - `YES`: (Default) Publish.
 - `NO`: Do not publish.

 This member serves a similar function to the `muteLocalVideoStream` method.
 After the user joins the channel, you can call the `muteLocalVideoStream`
 method to set whether to publish the local video stream in the channel.

 @since v3.4.5
 */
@property(nonatomic, assign) BOOL publishLocalVideo;
@end

/** AgoraFacePositionInfo array.
 */
__attribute__((visibility("default"))) @interface AgoraFacePositionInfo : NSObject

/** The x coordinate (px) of the human face in the local video. Taking the top left corner of the captured video as the origin, the x coordinate represents the relative lateral displacement of the top left corner of the human face to the origin.
 */
@property(assign, nonatomic) NSInteger x;

/** The y coordinate (px) of the human face in the local video. Taking the top left corner of the captured video as the origin, the y coordinate represents the relative longitudinal displacement of the top left corner of the human face to the origin.
 */
@property(assign, nonatomic) NSInteger y;

/** The width (px) of the human face in the captured video.
 */
@property(assign, nonatomic) NSInteger width;

/** The height (px) of the human face in the captured video.
 */
@property(assign, nonatomic) NSInteger height;

/** The distance (cm) between the human face and the screen.
 */
@property(assign, nonatomic) NSInteger distance;
@end

/** **Since** v3.4.0. Recording configuration, which is set in [startAudioRecordingWithConfig]([AgoraRtcEngineKit startAudioRecordingWithConfig:]). */
__attribute__((visibility("default"))) @interface AgoraAudioRecordingConfiguration : NSObject

/** The absolute path (including the filename extensions) of the recording file. For example: `/var/mobile/Containers/Data/audio.aac`.

 @note Ensure that the path you specify exists and is writable.
 */
@property(copy, nonatomic) NSString* _Nullable filePath;

/** Audio recording quality. See AgoraAudioRecordingQuality.

 @note This parameter applies for AAC files only.
 */
@property(assign, nonatomic) AgoraAudioRecordingQuality recordingQuality;

/** Recording content. See AgoraAudioRecordingPosition.
 */
@property(assign, nonatomic) AgoraAudioRecordingPosition recordingPosition;

/** Recording sample rate (Hz). The following values are supported:

 - 16000
 - (Default) 32000
 - 44100
 - 48000

 @note If this parameter is set to `44100` or `48000`, for better recording effects, Agora recommends recording WAV
 files or AAC files whose `recordingQuality` is `AgoraAudioRecordingQualityMedium` or `AgoraAudioRecordingQualityHigh`.
 */
@property(assign, nonatomic) NSInteger recordingSampleRate;
@end

//__attribute__((visibility("default"))) @interface AgoraRtcChannelInfo : NSObject
//
//@property (nonatomic, copy) NSString * _Nonnull channelId;
//
//@end
/** The configuration of the log files that the SDK outputs.
 */
__attribute__((visibility("default"))) @interface AgoraLogConfig : NSObject
/** The absolute path of log files.

 @since v3.3.0

 Ensure that the directory for the log
 files exists and is writable. The default file path is as follows:

 - iOS: `App Sandbox/Library/caches/agorasdk.log`
 - macOS:
   - Sandbox enabled: `App Sandbox/Library/Logs/agorasdk.log`, such as
   `/Users/<username>/Library/Containers/<App Bundle Identifier>/Data/Library/Logs/agorasdk.log`
   - Sandbox disabled: `～/Library/Logs/agorasdk.log`
 */
@property(copy, nonatomic) NSString* _Nullable filePath;
/** The size (KB) of a log file.

 @since v3.3.0

 The default value is 1024 KB. If you set
 this parameter to 1024 KB, the SDK outputs at most 5 MB log files; if
 you set it to less than 1024 KB, the setting is invalid, and the maximum
 size of a log file is still 1024 KB.
 */
@property(assign, nonatomic) NSInteger fileSize;
/** The output log level of the SDK. See details in AgoraLogLevel.

 @since v3.3.0

 For example, if you set the log level to `AgoraLogLevelWarn`, the SDK outputs the logs
 within levels `AgoraLogLevelFatal`, `AgoraLogLevelError`, and `AgoraLogLevelWarn`.
 */
@property(assign, nonatomic) AgoraLogLevel level;
@end
/** Configurations for the AgoraRtcEngineKit instance.
 */
__attribute__((visibility("default"))) @interface AgoraRtcEngineConfig : NSObject
/** The App ID issued to you by Agora. See [How to get the App ID](https://docs.agora.io/en/Agora%20Platform/token#get-an-app-id). Only users in apps with the same App ID can join the same channel and communicate with each other. Use an App ID to create only one AgoraRtcEngineKit instance.  To change your App ID, call [destroy]([AgoraRtcEngineKit destroy]) to `destroy` the current AgoraRtcEngineKit instance, and after `destroy` returns 0, call [sharedEngineWithConfig]([AgoraRtcEngineKit sharedEngineWithConfig:delegate:]) to create an AgoraRtcEngineKit instance with the new App ID.
 */
@property(copy, nonatomic) NSString* _Nullable appId;
/** The region for connection. This advanced feature applies to scenarios that have regional restrictions. <p>For the regions that Agora supports, see AgoraAreaCode. The area codes support bitwise operation. After specifying the region, the SDK connects to the Agora servers within that region.</p>
 */
@property(nonatomic, assign) NSUInteger areaCode;
/** The configuration of the log files that the SDK outputs. See AgoraLogConfig.

@since v3.3.0.

By default, the SDK outputs five log files, `agorasdk.log`, `agorasdk_1.log`,
`agorasdk_2.log`, `agorasdk_3.log`, `agorasdk_4.log`, each with a default
size of 1024 KB. These log files are encoded in UTF-8. The SDK writes the
latest logs in `agorasdk.log`. When `agorasdk.log` is full, the SDK deletes
the log file with the earliest modification time among the other four,
renames `agorasdk.log` to the name of the deleted log file, and creates a
new `agorasdk.log` to record latest logs.
 */
@property(strong, nonatomic) AgoraLogConfig* _Nullable logConfig;
@end

/** Configurations of built-in encryption schemas.
 */
__attribute__((visibility("default"))) @interface AgoraEncryptionConfig : NSObject

/** Encryption mode. The default encryption mode is `AgoraEncryptionModeAES128GCM2`. See AgoraEncryptionMode.
 */
@property(assign, nonatomic) AgoraEncryptionMode encryptionMode;

/** Encryption key in string type with unlimited length. Agora recommends
 using a 32-byte key.

**Note**

If you do not set an encryption key or set it as `nil`, you cannot use the built-in encryption, and the SDK returns `-2` (`AgoraErrorCodeInvalidArgument`).
 */
@property(copy, nonatomic) NSString* _Nullable encryptionKey;
/** The salt with the length of 32 bytes. Agora recommends using OpenSSL to generate the salt on your
 server. For details, see *Media Stream Encryption*.
 <p><b>Note</b>: This parameter is only valid when you set the encryption mode
 as <code>AgoraEncryptionModeAES128GCM2</code> or
 <code>AgoraEncryptionModeAES256GCM2</code>. In this case, ensure that this
 parameter is not <code>nil</code> or <code>0</code>, and the data length is
 32 bytes.</p>
 */
@property(strong, nonatomic) NSData* _Nullable encryptionKdfSalt;
@end

/** The detailed options of a user.
 */
__attribute__((visibility("default"))) @interface AgoraClientRoleOptions : NSObject

/** The latency level of an audience member in a interactive live streaming. See [AgoraAudienceLatencyLevelType](AgoraAudienceLatencyLevelType).
 */
@property(assign, nonatomic) AgoraAudienceLatencyLevelType audienceLatencyLevel;
@end
/**
 Information for the recording file.

 @since v3.5.2
 */
__attribute__((visibility("default"))) @interface AgoraMediaRecorderInfo : NSObject

/** The absolute path of the recording file.
 */
@property(copy, nonatomic) NSString* _Nonnull recorderFileName;
/** The recording duration, in milliseconds.
 */
@property(assign, nonatomic) NSUInteger durationMs;
/** The size in bytes of the recording file.
 */
@property(assign, nonatomic) NSUInteger fileSize;

@end
/**
 Configurations for the local audio and video recording.

 @since v3.5.2
 */
__attribute__((visibility("default"))) @interface AgoraMediaRecorderConfiguration : NSObject

/** The absolute path (including the filename extensions) of the recording file. For example, `/App Sandbox/Library/Caches/example.mp4`
 on iOS and `/Library/Logs/example.mp4` on macOS.

 @note Ensure that the specified path exists and is writable.
 */
@property(copy, nonatomic) NSString* _Nonnull storagePath;
/** The format of the recording file. See AgoraMediaRecorderContainerFormat.
 */
@property(assign, nonatomic) AgoraMediaRecorderContainerFormat containerFormat;
/** The recording content. See AgoraMediaRecorderStreamType.
 */
@property(assign, nonatomic) AgoraMediaRecorderStreamType streamType;
/** The maximum recording duration, in milliseconds. The default value is 120000.
 */
@property(assign, nonatomic) NSUInteger maxDurationMs;
/** The interval (ms) of updating the recording information. The value range is [1000,10000].
 Based on the set value of `recorderInfoUpdateInterval`, the SDK triggers the [informationDidUpdated]([AgoraMediaRecorderDelegate mediaRecorder:informationDidUpdated:])
 callback to report the updated recording information.
 */
@property(assign, nonatomic) NSUInteger recorderInfoUpdateInterval;

@end

/** The local encoded video frame. (iOS only)

 @since v3.4.5
 */
__attribute__((visibility("default"))) @interface AgoraVideoEncodedFrame : NSObject

/** The video codec type. See AgoraVideoCodecType.
 */
@property(assign, nonatomic) AgoraVideoCodecType codecType;
/** The width (px) of the video. */
@property(assign, nonatomic) NSInteger width;
/** The height (px) of the video. */
@property(assign, nonatomic) NSInteger height;
/** The video buffer. */
@property(assign, nonatomic) void* _Nullable buffer;
/** The length (in bytes) of the video buffer.*/
@property(assign, nonatomic) NSUInteger length;
/** The video frame type. See AgoraVideoEncodeType.   */
@property(assign, nonatomic) AgoraVideoEncodeType frameType;
/** The clockwise rotation angle of the video frame. See AgoraVideoRotation.  */
@property(assign, nonatomic) AgoraVideoRotation rotation;
/** The Unix timestamp (ms) when the video frame is rendered. This timestamp
 can be used to guide the rendering of the video frame. This parameter is
 required.
 */
@property(assign, nonatomic) int64_t renderTimeMs;

@end

/** The video frame. (iOS only)

 @since v3.4.5
 */
__attribute__((visibility("default"))) @interface AgoraVideoDataFrame : NSObject
/** The color video format. See AgoraVideoFrameType.
 */
@property(assign, nonatomic) AgoraVideoFrameType frameType;
/** The width (px) of the video.
 */
@property(assign, nonatomic) NSInteger width;              // width of video frame
/** The height (px) of the video.
 */
@property(assign, nonatomic) NSInteger height;             // height of video frame
/** For YUV data, the line span of the Y buffer; for RGBA data, the total
 data length.
 */
@property(assign, nonatomic) NSInteger yStride;            // stride of Y data buffer
/** For YUV data, the line span of the U buffer; for RGBA data, the value is 0.
 */
@property(assign, nonatomic) NSInteger uStride;            // stride of U data buffer
/** For YUV data, the line span of the V buffer; for RGBA data, the value is 0.
 */
@property(assign, nonatomic) NSInteger vStride;            // stride of V data buffer
/** For YUV data, the pointer to the Y buffer; for RGBA data, the data buffer.
 */
@property(assign, nonatomic) void* _Nullable yBuffer;      // Y data buffer
/** For YUV data, the pointer to the U buffer; for RGBA data, the value is 0.
 */
@property(assign, nonatomic) void* _Nullable uBuffer;      // U data buffer
/** For YUV data, the pointer to the V buffer; for RGBA data, the value is 0.
 */
@property(assign, nonatomic) void* _Nullable vBuffer;      // V data buffer
/** The clockwise rotation angle of the video frame.
 See AgoraVideoRotation.
 */
@property(assign, nonatomic) AgoraVideoRotation rotation;  // rotation of this frame (0, 90, 180, 270)
/** The Unix timestamp (ms) when the video frame is rendered. This timestamp
 can be used to guide the rendering of the video frame. This parameter is
 required.
 */
@property(assign, nonatomic) int64_t renderTimeMs;
/** Reserved parameter.
 */
@property(assign, nonatomic) NSInteger avsync_type;

@end
/**
 The configuration of the audio and video call loop test.

 @since v3.5.2
 */
__attribute__((visibility("default"))) @interface AgoraEchoTestConfiguration : NSObject
/** The view used to render the local user's video.
 This property is only applicable to scenarios testing video devices, that is, when `enableVideo` is YES.

 @note For iOS, the data type of this property is UIView; for macOS, the data type of this property is NSView.
 */
@property(strong, nonatomic) VIEW_CLASS* _Nullable view;
/** Whether to enable the audio device for the call loop test:

 - YES: (Default) Enables the audio device. To test the audio device, set this property as `YES`.
 - NO: Disables the audio device.
 */
@property(assign, nonatomic) BOOL enableAudio;
/** Whether to enable the video device for the call loop test:

 - YES: (Default) Enables the video device. To test the video device, set this property as `YES`.
 - NO: Disables the video device.
 */
@property(assign, nonatomic) BOOL enableVideo;
/** The token used to secure the audio and video call loop test. If you do not enable App Certificate in Agora Console,
 you do not need to pass a value in this parameter; if you have enabled App Certificate in Agora Console, you must pass
 a token in this property, the `uid` used when you generate the token must be 0xFFFFFFFF, and the channel name used must
 be the channel name that identifies each audio and video call loop tested. For server-side token generation,
 see [Authenticate Your Users with Tokens](https://docs.agora.io/en/Interactive%20Broadcast/token_server?platform=All%20Platforms).
 */
@property(copy, nonatomic) NSString* _Nullable token;
/** The channel name that identifies each audio and video call loop. To ensure proper loop test functionality,
 the channel name passed in to identify each loop test cannot be the same when users of the same project (App ID) perform
 audio and video call loop tests on different devices.
 */
@property(copy, nonatomic) NSString* _Nonnull channelId;
@end

__attribute__((visibility("default"))) @interface AgoraContentInspectModule : NSObject

@property(assign, nonatomic) AgoraContentInspectType type;

@property(assign, nonatomic) NSInteger interval NS_SWIFT_NAME(interval);

@end

__attribute__((visibility("default"))) @interface AgoraContentInspectConfig : NSObject

@property(nonatomic, copy) NSString* _Nullable extraInfo;

@property(copy, nonatomic) NSArray<AgoraContentInspectModule*>* _Nullable modules;
@end
