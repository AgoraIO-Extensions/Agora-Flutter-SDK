//
// AgoraAudioFrame.h
// AgoraRtcEngineKit
//
// Copyright (c) 2020 Agora. All rights reserved.
//

#import <Foundation/Foundation.h>

/** The protocol of the raw audio data.
 */
@protocol AgoraAudioDataFrameProtocol <NSObject>
@required

/** Occurs when the recorded audio frame of the local user is received.

 @since v3.4.5

 After you successfully register the audio delegate, the SDK triggers the
 `onRecordAudioFrame` callback every 10 ms by default, and the reported audio
 frame format is the same as the recorded audio frame format.

 @note To ensure that the received audio frame has the expected format, you can
 register the
 [getRecordAudioParams]([AgoraAudioDataFrameProtocol getRecordAudioParams])
 callback when calling the
 [setAudioDataFrame]([AgoraRtcEngineKit setAudioDataFrame:]) method and set the
 audio recording format in the return value of `getRecordAudioParams`. The SDK
 calculates the sample interval according to the `AgoraAudioParam` you set in
 the return value of `getRecordAudioParams` and triggers the
 `onRecordAudioFrame` callback at the sample interval.

 @param frame The raw audio data. See AgoraAudioFrame.

 @return - `YES`: Valid buffer in AgoraAudioFrame, and the audio frame is
 sent out.
- `NO`: Invalid buffer in AgoraAudioFrame, and the audio frame is discarded.
 */
- (BOOL)onRecordAudioFrame:(AgoraAudioFrame* _Nonnull)frame;

/** Occurs when the playback audio frame of all remote users is received.

 @since v3.4.5

 After you successfully register the audio delegate, the SDK triggers the
 `onPlaybackAudioFrame` callback every 10 ms by default, and the reported audio
 frame format is the same as the playback audio frame format.

 @note To ensure that the received audio frame has the expected format, you can
 register the
 [getPlaybackAudioParams]([AgoraAudioDataFrameProtocol getPlaybackAudioParams])
 callback when calling the
 [setAudioDataFrame]([AgoraRtcEngineKit setAudioDataFrame:]) method and set the
 audio playback format in the return value of `getPlaybackAudioParams`. The SDK
 calculates the sample interval according to the `AgoraAudioParam` you set in
 the return value of `getPlaybackAudioParams` and triggers the
 `onPlaybackAudioFrame` callback at the sample interval.

 @param frame The raw audio data. See AgoraAudioFrame.

 @return - `YES`: Valid buffer in AgoraAudioFrame, and the audio frame is
 sent out.
- `NO`: Invalid buffer in AgoraAudioFrame, and the audio frame is discarded.
 */
- (BOOL)onPlaybackAudioFrame:(AgoraAudioFrame* _Nonnull)frame;

/** Occurs when the mixed audio frame of the local user and all remote users
 is received.

 @since v3.4.5

 To trigger this callback, you need to register the
 [getObservedAudioFramePosition]([AgoraAudioDataFrameProtocol getObservedAudioFramePosition])
 callback when calling the
 [setAudioDataFrame]([AgoraRtcEngineKit setAudioDataFrame:]) method and set the
 return value of `getObservedAudioFramePosition` as
 `AgoraAudioFramePositionMixed (1 << 2)`. After the setting is successful, the
 SDK triggers the `onMixedAudioFrame` callback every 10 ms by default, and the
 reported audio frame format is the same as the mixed audio frame format.

 @note To ensure that the received audio frame has the expected format, you can
 register the
 [getMixedAudioParams]([AgoraAudioDataFrameProtocol getMixedAudioParams])
 callback when calling the `setAudioDataFrame` method and set the audio mixing
 format in the return value of `getMixedAudioParams`. The SDK calculates the
 sample interval according to the `AgoraAudioFrame` you set in the return value
 of `getMixedAudioParams` and triggers the `onMixedAudioFrame` callback at
 the sample interval.

 @param frame The raw audio data. See AgoraAudioFrame.

 @return - `YES`: Valid buffer in AgoraAudioFrame, and the audio frame is
 sent out.
- `NO`: Invalid buffer in AgoraAudioFrame, and the audio frame is discarded.
 */
- (BOOL)onMixedAudioFrame:(AgoraAudioFrame* _Nonnull)frame;

/** Occurs when the audio frame of a remote user is received before mixing.

 @since v3.4.5

 To trigger this callback, you need to register the
 [getObservedAudioFramePosition]([AgoraAudioDataFrameProtocol getObservedAudioFramePosition])
 callback when calling the
 [setAudioDataFrame]([AgoraRtcEngineKit setAudioDataFrame:]) method and set the
 return value of `getObservedAudioFramePosition` as
 `AgoraAudioFramePositionBeforeMixing (1 << 3)`. After the setting is successful,
 the SDK triggers the `onPlaybackAudioFrameBeforeMixing` callback every 10 ms
 by default, and the reported audio frame format is the same as the playback
 audio frame format.

 @param frame The raw audio data. See AgoraAudioFrame.
 @param uid The user ID of the remote user.

 @return - `YES`: Valid buffer in AgoraAudioFrame, and the audio frame is
 sent out.
- `NO`: Invalid buffer in AgoraAudioFrame, and the audio frame is discarded.
 */
- (BOOL)onPlaybackAudioFrameBeforeMixing:(AgoraAudioFrame* _Nonnull)frame uid:(NSUInteger)uid;

/** Determines whether to receive raw audio data from multiple channels.

 @since v3.5.0

 After you register the audio frame observer, the SDK triggers this callback
 every time it captures an audio frame.

 In a multi-channel scenario, if you want to get audio data from multiple
 channels, set the return value of this callback as `YES`, and set the return
 value of [getObservedAudioFramePosition]([AgoraAudioDataFrameProtocol getObservedAudioFramePosition]) as
 `AgoraAudioFramePositionBeforeMixing (1 << 3)`. After that, the SDK triggers
 the [onPlaybackAudioFrameBeforeMixingEx]([AgoraAudioDataFrameProtocol onPlaybackAudioFrameBeforeMixingEx:channelId:uid:])
 callback to send you the before-mixing audio data from various channels. You
 can also get the channel ID of each audio frame.

 **Note**

 - Once you set the return value of this callback as `YES`, the SDK triggers
 only the `onPlaybackAudioFrameBeforeMixingEx` callback to send the
 before-mixing audio frame.
 [onPlaybackAudioFrameBeforeMixing]([AgoraAudioDataFrameProtocol onPlaybackAudioFrameBeforeMixing:uid:])
 is not triggered. In a multi-channel scenario, Agora recommends setting the
 return value as `YES`.
 - If you set the return value of this callback as `NO`, the SDK triggers only
 the `onPlaybackAudioFrameBeforeMixing` callback to send the audio data.

 @return - `YES`: Receive audio data from multiple channels.
 - `NO`: Do not receive audio data from multiple channels.
 */
- (BOOL)isMultipleChannelFrameWanted;

/** Gets the audio frame of a remote user before mixing from one of the
 multiple channels.

 @since v3.5.0

 To trigger this callback, you need to register the following callbacks and
 set their return values when calling the
 [setAudioDataFrame]([AgoraRtcEngineKit setAudioDataFrame:]) method:

 - [getObservedAudioFramePosition]([AgoraAudioDataFrameProtocol getObservedAudioFramePosition]):
 Set its return value as `AgoraAudioFramePositionBeforeMixing (1 << 3)`.
 - [isMultipleChannelFrameWanted]([AgoraAudioDataFrameProtocol isMultipleChannelFrameWanted]):
 Set its return value as `YES`.

 After the setting is successful, the SDK triggers the
 `onPlaybackAudioFrameBeforeMixingEx` callback every 10 ms by default, and the
 reported audio frame format is the same as the playback audio frame format.

 @param frame The raw audio data. See AgoraAudioFrame.
 @param channelId The channel name.
 @param uid The user ID of the remote user.

 @return - `YES`: Valid buffer in `AgoraAudioFrame`, and the audio frame is sent out.
 - `NO`: Invalid buffer in `AgoraAudioFrame`, and the audio frame is discarded.
 */
- (BOOL)onPlaybackAudioFrameBeforeMixingEx:(AgoraAudioFrame* _Nonnull)frame channelId:(NSString* _Nonnull)channelId uid:(NSUInteger)uid;

/** Sets the audio observation positions.

 @since v3.4.5

 After you successfully register the audio delegate, the SDK uses the
 [getObservedAudioFramePosition]([AgoraAudioDataFrameProtocol getObservedAudioFramePosition])
 callback to determine at each specific audio-frame processing node whether to
 trigger the following callbacks:

 - [onRecordAudioFrame]([AgoraAudioDataFrameProtocol onRecordAudioFrame:])
 - [onPlaybackAudioFrame]([AgoraAudioDataFrameProtocol onPlaybackAudioFrame:])
 - [onMixedAudioFrame]([AgoraAudioDataFrameProtocol onMixedAudioFrame:])
 - [onPlaybackAudioFrameBeforeMixing]([AgoraAudioDataFrameProtocol onPlaybackAudioFrameBeforeMixing:uid:])
 or [onPlaybackAudioFrameBeforeMixingEx]([AgoraAudioDataFrameProtocol onPlaybackAudioFrameBeforeMixingEx:channelId:uid:])

 You can set the positions that you want to observe by modifying the return
 value of `getObservedAudioFramePosition` according to your scenario.

 **Note**:

 - To observe multiple positions, use `|` (the OR operator).
 - The default return value of `getObservedAudioFramePosition` is
 `AgoraAudioFramePositionPlayback (1 << 0)` and
 `AgoraAudioFramePositionRecord (1 << 1)`.
 - To conserve system resources, you can reduce the number of frame positions
 that you want to observe.

 @return The bit mask that controls the audio observation positions.
 See AgoraAudioFramePosition.
 */
- (AgoraAudioFramePosition)getObservedAudioFramePosition;

/** Sets the audio mixing format for the
 [onMixedAudioFrame]([AgoraAudioDataFrameProtocol onMixedAudioFrame:]) callback.

 @since v3.4.5

 Register the `getMixedAudioParams` callback when calling the
 [setAudioDataFrame]([AgoraRtcEngineKit setAudioDataFrame:]) method. After you
 successfully register the audio delegate, the SDK triggers this callback.
 You can set the audio mixing format in
 the return value of this callback.

 @note The SDK calculates the sample interval according to the `AgoraAudioParam`
 you set in the return value of this callback and triggers the
 `onMixedAudioFrame` callback at the calculated sample interval.
 Sample interval (seconds) = `samplesPerCall`/(`sampleRate` × `channel`).
 Ensure that the value of sample interval is equal to or greater than 0.01.

 @return Sets the audio format. See AgoraAudioParam.
 */
- (AgoraAudioParam* _Nonnull)getMixedAudioParams;

/** Sets the audio recording format for the
 [onRecordAudioFrame]([AgoraAudioDataFrameProtocol onRecordAudioFrame:])
 callback.

 @since v3.4.5

 Register the `getRecordAudioParams` callback when calling the
 [setAudioDataFrame]([AgoraRtcEngineKit setAudioDataFrame:]) method. After you
 successfully register the audio delegate, the SDK triggers this callback.
 You can set the audio recording format in
 the return value of this callback.

 @note The SDK calculates the sample interval according to the `AgoraAudioParam`
 you set in the return value of this callback and triggers the
 `onRecordAudioFrame` callback at the calculated sample interval.
 Sample interval (seconds) = `samplesPerCall`/(`sampleRate` × `channel`).
 Ensure that the value of sample interval is equal to or greater than 0.01.

 @return Sets the audio format. See AgoraAudioParam.
 */
- (AgoraAudioParam* _Nonnull)getRecordAudioParams;

/** Sets the audio playback format for the
 [onPlaybackAudioFrame]([AgoraAudioDataFrameProtocol onPlaybackAudioFrame:])
 callback.

 @since v3.4.5

 Register the `getPlaybackAudioParams` callback when calling the
 [setAudioDataFrame]([AgoraRtcEngineKit setAudioDataFrame:]) method. After you
 successfully register the audio delegate, the SDK triggers this callback.
 You can set the audio playback format in
 the return value of this callback.

 @note The SDK calculates the sample interval according to the `AgoraAudioParam`
 you set in the return value of this callback and triggers the
 `onPlaybackAudioFrame` callback at the calculated sample interval.
 Sample interval (seconds) = `samplesPerCall`/(`sampleRate` × `channel`).
 Ensure that the value of sample interval is equal to or greater than 0.01.

 @return Sets the audio format. See AgoraAudioParam.
 */
- (AgoraAudioParam* _Nonnull)getPlaybackAudioParams;

@end
