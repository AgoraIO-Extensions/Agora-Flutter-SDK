//
//  AgoraRtcEngineKit.h
//  AgoraRtcEngineKit
//
//  Copyright (c) 2018 Agora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AgoraConstants.h"
#import "AgoraObjects.h"
#import "AgoraMediaIO.h"
#import "AgoraMediaMetadata.h"
#import "AgoraLogWriter.h"
#import "AgoraAudioFrame.h"
#import "AgoraVideoFrame.h"

/** Agora provides ensured quality of experience (QoE) for worldwide Internet-based voice and video communications through a virtual global network optimized for real-time web and mobile-to-mobile applications.

 The AgoraRtcEngineKit class is the entry point of the SDK providing API methods for apps to easily start voice and video communication.
 */
@class AgoraRtcEngineKit;
/** The AgoraRtcChannel class.
 */
@class AgoraRtcChannel;

/** The AgoraRtcEngineDelegate protocol enables callbacks to your app.

 The SDK uses delegate callbacks in the AgoraRtcEngineDelegate protocol to report runtime events to the app.
 From v1.1, some block callbacks in the SDK are replaced with delegate callbacks. The old block callbacks are therefore deprecated, but can still be used in the current version. However, Agora recommends replacing block callbacks with delegate callbacks. The SDK calls the block callback if a callback is defined in both the block and delegate callbacks.
 */
@protocol AgoraRtcEngineDelegate <NSObject>
@optional

#pragma mark Core Delegate Methods

/**-----------------------------------------------------------------------------
 * @name Core Delegate Methods
 * -----------------------------------------------------------------------------
 */

/** Reports a warning during SDK runtime.

 In most cases, the app can ignore the warning reported by the SDK because the SDK can usually fix the issue and resume running.

 For instance, the SDK may report an AgoraWarningCodeOpenChannelTimeout(106) warning upon disconnection from the server and attempts to reconnect.

 See [AgoraWarningCode](AgoraWarningCode).

 @param engine      AgoraRtcEngineKit object
 @param warningCode Warning code: AgoraWarningCode
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine didOccurWarning:(AgoraWarningCode)warningCode;

/** Reports an error during SDK runtime.

In most cases, the SDK cannot fix the issue and resume running. The SDK requires the app to take action or informs the user about the issue.

For example, the SDK reports an AgoraErrorCodeStartCall = 1002 error when failing to initialize a call. The app informs the user that the call initialization failed and invokes the [leaveChannel]([AgoraRtcEngineKit leaveChannel:]) method to leave the channel.

See [AgoraErrorCode](AgoraErrorCode).

 @param engine    AgoraRtcEngineKit object
 @param errorCode Error code: AgoraErrorCode
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine didOccurError:(AgoraErrorCode)errorCode;

/** Occurs when a method is executed by the SDK.

 @param engine AgoraRtcEngineKit object.
 @param error  The error code (AgoraErrorCode) returned by the SDK when the method call fails. If the SDK returns 0, then the method call succeeds.
 @param api    The method executed by the SDK.
 @param result The result of the method call.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine didApiCallExecute:(NSInteger)error api:(NSString* _Nonnull)api result:(NSString* _Nonnull)result;

/** Occurs when the local user joins a specified channel.

 Same as `joinSuccessBlock` in the [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) method.

 @param engine  AgoraRtcEngineKit object.
 @param channel Channel name.
 @param uid     User ID. If the `uid` is specified in the [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) method, the specified user ID is returned. If the user ID is not specified when the joinChannel method is called, the server automatically assigns a `uid`.
 @param elapsed Time elapsed (ms) from the user calling the [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) method until the SDK triggers this callback.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine didJoinChannel:(NSString* _Nonnull)channel withUid:(NSUInteger)uid elapsed:(NSInteger)elapsed;

/** Occurs when the local user rejoins a channel.

 If the client loses connection with the server because of network problems, the SDK automatically attempts to reconnect and then triggers this callback upon reconnection, indicating that the user rejoins the channel with the assigned channel ID and user ID.

 @param engine  AgoraRtcEngineKit object.
 @param channel Channel name.
 @param uid     User ID. If the `uid` is specified in the [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) method, the specified user ID is returned. If the user ID is not specified when the joinChannel method is called, the server automatically assigns a `uid`.
 @param elapsed Time elapsed (ms) from starting to reconnect to a successful reconnection.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine didRejoinChannel:(NSString* _Nonnull)channel withUid:(NSUInteger)uid elapsed:(NSInteger)elapsed;

/** Occurs when the local user leaves a channel.

 When the app calls the [leaveChannel]([AgoraRtcEngineKit leaveChannel:]) method, this callback notifies the app that a user leaves a channel.

 With this callback, the app gets information, such as the call duration and the statistics of the received/transmitted data reported by the [audioQualityOfUid]([AgoraRtcEngineDelegate rtcEngine:audioQualityOfUid:quality:delay:lost:]) callback.

 @param engine AgoraRtcEngineKit object.
 @param stats  Statistics of the call: [AgoraChannelStats](AgoraChannelStats).
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine didLeaveChannelWithStats:(AgoraChannelStats* _Nonnull)stats;

/** Occurs when the local user successfully registers a user account by calling the [registerLocalUserAccount]([AgoraRtcEngineKit registerLocalUserAccount:appId:]) or [joinChannelByUserAccount]([AgoraRtcEngineKit joinChannelByUserAccount:token:channelId:joinSuccess:]) method.

This callback reports the user ID and user account of the local user.

@param engine AgoraRtcEngineKit object.
@param userAccount The user account of the local user.
@param uid The ID of the local user.
*/
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine didRegisteredLocalUser:(NSString* _Nonnull)userAccount withUid:(NSUInteger)uid;

/** Occurs when the SDK gets the user ID and user account of the remote user.

After a remote user joins the channel, the SDK gets the user ID and user account of the remote user, caches them in a mapping table object (`userInfo`), and triggers this callback on the local client.

@param engine AgoraRtcEngineKit object.
@param userInfo The [AgoraUserInfo](AgoraUserInfo) object that contains the user ID and user account of the remote user.
@param uid The ID of the remote user.
*/
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine didUpdatedUserInfo:(AgoraUserInfo* _Nonnull)userInfo withUid:(NSUInteger)uid;

/** Occurs when the local user role switches in the interactive live streaming.

The SDK triggers this callback when the local user switches the user role by calling the [setClientRole]([AgoraRtcEngineKit setClientRole:]) method after joining the channel.

 @param engine  AgoraRtcEngineKit object.
 @param oldRole Role that the user switches from: AgoraClientRole.
 @param newRole Role that the user switches to: AgoraClientRole.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine didClientRoleChanged:(AgoraClientRole)oldRole newRole:(AgoraClientRole)newRole;

/** Occurs when a remote user or host joins a channel. Same as [userJoinedBlock]([AgoraRtcEngineKit userJoinedBlock:]).

 - Communication profile: This callback notifies the app that another user joins the channel. If other users are already in the channel, the SDK also reports to the app on the existing users.
 - Interactive live streaming profile: This callback notifies the app that a host joins the channel. If other hosts are already in the channel, the SDK also reports to the app on the existing hosts. Agora recommends limiting the number of hosts to 17.

 The SDK triggers this callback under one of the following circumstances:
 - A remote user/host joins the channel by calling the [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) method.
 - A remote user switches the user role to the host by calling the [setClientRole]([AgoraRtcEngineKit setClientRole:]) method after joining the channel.
 - A remote user/host rejoins the channel after a network interruption.
 - A host injects an online media stream into the channel by calling the [addInjectStreamUrl]([AgoraRtcEngineKit addInjectStreamUrl:config:]) method.

 **Note:**

 Interactive live streaming profile:

 * The host receives this callback when another host joins the channel.
 * The audience in the channel receives this callback when a new host joins the channel.
 * When a web application joins the channel, the SDK triggers this callback as long as the web application publishes streams.

 @param engine  AgoraRtcEngineKit object.
 @param uid     ID of the user or host who joins the channel. If the `uid` is specified in the [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) method, the specified user ID is returned. If the `uid` is not specified in the joinChannelByToken method, the Agora server automatically assigns a `uid`.
 @param elapsed Time elapsed (ms) from the local user calling the [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) or [setClientRole]([AgoraRtcEngineKit setClientRole:]) method until the SDK triggers this callback.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine didJoinedOfUid:(NSUInteger)uid elapsed:(NSInteger)elapsed;

/** Occurs when a remote user (Communication)/host (Live Broadcast) leaves a channel. Same as [userOfflineBlock]([AgoraRtcEngineKit userOfflineBlock:]).

There are two reasons for users to be offline:

- Leave a channel: When the user/host leaves a channel, the user/host sends a goodbye message. When the message is received, the SDK assumes that the user/host leaves a channel.
- Drop offline: When no data packet of the user or host is received for a certain period of time (20 seconds for the Communication profile, and more for the interactive live streaming profile), the SDK assumes that the user/host drops offline. Unreliable network connections may lead to NO detections, so Agora recommends using the [Agora RTM SDK](https://docs.agora.io/en/Real-time-Messaging/product_rtm?platform=All%20Platforms) for more reliable offline detection.

 @param engine AgoraRtcEngineKit object.
 @param uid    ID of the user or host who leaves a channel or goes offline.
 @param reason Reason why the user goes offline, see AgoraUserOfflineReason.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine didOfflineOfUid:(NSUInteger)uid reason:(AgoraUserOfflineReason)reason;

/** Occurs when the network connection state changes.

The SDK triggers this callback to report on the current network connection state when it changes, and the reason of the change.

@param engine AgoraRtcEngineKit object.
@param state The current network connection state, see AgoraConnectionStateType.
@param reason The reason of the connection state change, see AgoraConnectionChangedReason.
*/
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine connectionChangedToState:(AgoraConnectionStateType)state reason:(AgoraConnectionChangedReason)reason;

/** Occurs when the local network type changes.

When the network connection is interrupted, this callback indicates whether the interruption is caused by a network type change or poor network conditions.

@param engine AgoraRtcEngineKit object.
@param type The network type, see AgoraNetworkType.
*/
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine networkTypeChangedToType:(AgoraNetworkType)type;

/** Occurs when the SDK cannot reconnect to Agora's edge server 10 seconds after its connection to the server is interrupted.

The SDK triggers this callback when it cannot connect to the server 10 seconds after calling the [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) method, regardless of whether it is in the channel or not.

This callback is different from [rtcEngineConnectionDidInterrupted]([AgoraRtcEngineDelegate rtcEngineConnectionDidInterrupted:]):

- The SDK triggers the [rtcEngineConnectionDidInterrupted]([AgoraRtcEngineDelegate rtcEngineConnectionDidInterrupted:]) callback when it loses connection with the server for more than four seconds after it successfully joins the channel.
- The SDK triggers the [rtcEngineConnectionDidLost]([AgoraRtcEngineDelegate rtcEngineConnectionDidLost:]) callback when it loses connection with the server for more than 10 seconds, regardless of whether it joins the channel or not.

If the SDK fails to rejoin the channel 20 minutes after being disconnected from Agora's edge server, the SDK stops rejoining the channel.

@param engine AgoraRtcEngineKit object.
 */
- (void)rtcEngineConnectionDidLost:(AgoraRtcEngineKit* _Nonnull)engine;

/** Occurs when the token expires in 30 seconds.

 The user becomes offline if the `token` used in the [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) method expires. The SDK triggers this callback 30 seconds before the `token` expires to remind the app to get a new `token`.
 Upon receiving this callback, generate a new `token` on the server and call the [renewToken]([AgoraRtcEngineKit renewToken:]) method to pass the new `token` to the SDK.

 @param engine AgoraRtcEngineKit object.
 @param token  The `token` that expires in 30 seconds.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine tokenPrivilegeWillExpire:(NSString* _Nonnull)token;

/** Occurs when the token expires.

 After a `token` is specified by calling the [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) method, if the SDK losses connection to the Agora server due to network issues, the `token` may expire after a certain period of time and a new `token` may be required to reconnect to the server.

 This callback notifies the app to generate a new token and call `joinChannelByToken` to rejoin the channel with the new token.

 @param engine AgoraRtcEngineKit object.
 */
- (void)rtcEngineRequestToken:(AgoraRtcEngineKit* _Nonnull)engine;

#pragma mark Media Delegate Methods

/**-----------------------------------------------------------------------------
 * @name Media Delegate Methods
 * -----------------------------------------------------------------------------
 */

/** Reports the volume information of users.

 By default, this callback is disabled. You can enable it by calling [enableAudioVolumeIndication]([AgoraRtcEngineKit enableAudioVolumeIndication:smooth:report_vad:]).
 Once this callback is enabled and users send streams in the channel, the SDK triggers the `reportAudioVolumeIndicationOfSpeakers`
 callback at the time interval set in `enableAudioVolumeIndication`.

 The SDK triggers two independent `reportAudioVolumeIndicationOfSpeakers` callbacks simultaneously, which separately report
 the volume information of the local user who sends a stream and the remote users (up to three) whose instantaneous volumes
 are the highest.

 @note After you enable this callback, calling [muteLocalAudioStream]([AgoraRtcEngineKit muteLocalAudioStream:]) affects
 the SDK's behavior as follows:

  - If the local user calls `muteLocalAudioStream`, the SDK stops triggering the local user’s callback.
  - 20 seconds after a remote user whose volume is one of the three highest calls `muteLocalAudioStream` method, the
  remote users' callback excludes this remote user's information; 20 seconds after all remote users call `muteLocalAudioStream`,
  the SDK stops triggering the remote users' callback.

 @param engine      AgoraRtcEngineKit object.
 @param speakers    The volume information of users. See AgoraRtcAudioVolumeInfo.<p>An empty `speakers` array in the
 callback indicates that no remote user is in the channel or sending a stream at the moment.</p>
 @param totalVolume Total volume after audio mixing. The value ranges between 0 (lowest volume) and 255 (highest volume).

 - In the local user's callback, `totalVolume` is the volume of the local user who sends a stream.
 - In the remote speakers' callback, `totalVolume` is the sum of the volume of all remote users (up to three) whose
 instantaneous volumes are the highest.

 If the user calls [startAudioMixing]([AgoraRtcEngineKit startAudioMixing:loopback:replace:cycle:startPos:]), `totalVolume` is
 the sum of the voice volume and audio-mixing volume.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine reportAudioVolumeIndicationOfSpeakers:(NSArray<AgoraRtcAudioVolumeInfo*>* _Nonnull)speakers totalVolume:(NSInteger)totalVolume;

/** Occurs when the most active remote speaker is detected.

 After a successful call of [enableAudioVolumeIndication]([AgoraRtcEngineKit enableAudioVolumeIndication:smooth:report_vad:]),
 the SDK continuously detects which remote user has the loudest volume. During the current period, the remote user,
 who is detected as the loudest for the most times, is the most active user.

 When the number of users is more than or equal to two and an active speaker exists, the SDK triggers this callback and reports the `uid` of the most active speaker.

 - If the most active speaker is always the same user, the SDK triggers this callback only once.
 - If the most active speaker changes to another user, the SDK triggers this callback again and reports the `uid` of the new active speaker.

 @param engine     AgoraRtcEngineKit object.
 @param speakerUid The user ID of the most active remote speaker.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine activeSpeaker:(NSUInteger)speakerUid;

/** Occurs when the first audio frame is published.

 @since v3.1.0

 The SDK triggers this callback under one of the following circumstances:

 - The local client enables the audio module and calls [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) successfully.
 - The local client calls [muteLocalAudioStream(YES)]([AgoraRtcEngineKit muteLocalAudioStream:]) and `muteLocalAudioStream(NO)` in sequence.
 - The local client calls [disableAudio]([AgoraRtcEngineKit disableAudio]) and [enableAudio]([AgoraRtcEngineKit enableAudio]) in sequence.
 - The local client calls [pushExternalAudioFrameRawData]([AgoraRtcEngineKit pushExternalAudioFrameRawData:samples:timestamp:])
 or [pushExternalAudioFrameSampleBuffer]([AgoraRtcEngineKit pushExternalAudioFrameSampleBuffer:]) to successfully push the audio frame to the SDK.

 @param engine  AgoraRtcEngineKit object.
 @param elapsed The time elapsed (ms) from the local client calling `joinChannelByToken` until the SDK triggers this callback.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine firstLocalAudioFramePublished:(NSInteger)elapsed;

/** Occurs when the first local video frame is displayed/rendered on the local video view.

Same as [firstLocalVideoFrameBlock]([AgoraRtcEngineKit firstLocalVideoFrameBlock:]).
@param engine  AgoraRtcEngineKit object.
@param size    Size of the first local video frame (width and height).
@param elapsed Time elapsed (ms) from the local user calling the [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) method until the SDK calls this callback.<p>If the [startPreview]([AgoraRtcEngineKit startPreview]) method is called before the [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) method, then `elapsed` is the time elapsed from calling the [startPreview]([AgoraRtcEngineKit startPreview]) method until the SDK triggers this callback.</p>
*/
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine firstLocalVideoFrameWithSize:(CGSize)size elapsed:(NSInteger)elapsed;

/** Occurs when the first video frame is published.

 @since v3.1.0

 The SDK triggers this callback under one of the following circumstances:

 - The local client enables the video module and calls [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) successfully.
 - The local client calls [muteLocalVideoStream(YES)]([AgoraRtcEngineKit muteLocalVideoStream:]) and `muteLocalVideoStream(NO)` in sequence.
 - The local client calls [disableVideo]([AgoraRtcEngineKit disableVideo]) and [enableVideo]([AgoraRtcEngineKit enableVideo]) in sequence.
 - The local client calls [pushExternalVideoFrame]([AgoraRtcEngineKit pushExternalVideoFrame:]) to successfully push the video frame to the SDK.

 @param engine  AgoraRtcEngineKit object.
 @param elapsed The time elapsed (ms) from the local client calling `joinChannelByToken` until the SDK triggers this callback.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine firstLocalVideoFramePublished:(NSInteger)elapsed;

/** Occurs when the video size or rotation of a specific remote user changes.

 @param engine   AgoraRtcEngineKit object.
 @param uid      User ID of the remote user or local user (0) whose video size or rotation changes.
 @param size     New video size.
 @param rotation New rotation of the video. The value ranges between 0 and 360.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine videoSizeChangedOfUid:(NSUInteger)uid size:(CGSize)size rotation:(NSInteger)rotation;

/** Occurs when the remote video state changes.

 @note This callback can be inaccurate when the number of users (in the
 communication profile) or hosts (in the interactive live streaming profile) in a channel exceeds 17.

 @param engine AgoraRtcEngineKit object.
 @param uid ID of the remote user whose video state changes.
 @param state The state of the remote video. See [AgoraVideoRemoteState](AgoraVideoRemoteState).
 @param reason The reason of the remote video state change. See [AgoraVideoRemoteStateReason](AgoraVideoRemoteStateReason).
 @param elapsed The time elapsed (ms) from the local user calling the [joinChannel]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) method until the SDK triggers this callback.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine remoteVideoStateChangedOfUid:(NSUInteger)uid state:(AgoraVideoRemoteState)state reason:(AgoraVideoRemoteStateReason)reason elapsed:(NSInteger)elapsed;

/** Reports whether the super resolution feature is successfully enabled. (beta feature)

 @since v3.5.1

 After calling [enableRemoteSuperResolution]([AgoraRtcEngineKit enableRemoteSuperResolution:enabled:]),
 the SDK triggers this callback to report whether super resolution is successfully enabled.
 If it is not successfully enabled, use `reason` for troubleshooting.

 @param engine AgoraRtcEngineKit object.
 @param uid The user ID of the remote user.
 @param enabled Whether super resolution is successfully enabled:

 - `YES`: Super resolution is successfully enabled.
 - `NO`: Super resolution is not successfully enabled.
 @param reason The reason why super resolution is not successfully enabled or
 the message that confirms success. See [AgoraSuperResolutionStateReason](AgoraSuperResolutionStateReason).
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine superResolutionEnabledOfUid:(NSUInteger)uid enabled:(BOOL)enabled reason:(AgoraSuperResolutionStateReason)reason;

/** Reports whether the virtual background is successfully enabled. (beta feature)

 @since Support for macOS as of v3.4.5 and iOS as of v3.5.0.

 After you call [enableVirtualBackground]([AgoraRtcEngineKit enableVirtualBackground:backData:]),
 the SDK triggers this callback to report whether the virtual background is
 successfully enabled.

 @note If the background image customized in the virtual background is in PNG
 or JPG format, the triggering of this callback is delayed until the image is
 read.

 @param engine AgoraRtcEngineKit object.
 @param enabled Whether the virtual background is successfully enabled:

 - `YES`: The virtual background is successfully enabled.
 - `NO`: The virtual background is not successfully enabled.
 @param reason The reason why the virtual background is not successfully
 enabled or the message that confirms success.
 See AgoraVirtualBackgroundSourceStateReason.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine virtualBackgroundSourceEnabled:(BOOL)enabled reason:(AgoraVirtualBackgroundSourceStateReason)reason;

- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine contentInspectResult:(AgoraContentInspectResult)result;
/**
 Reports the result of taking a video snapshot.

 @since v3.5.2

 After a successful [takeSnapshot]([AgoraRtcEngineKit takeSnapshot:uid:filePath:]) method call, the SDK triggers this
 callback to report whether the snapshot is successfully taken as well as the details for the snapshot taken.

 @param engine AgoraRtcEngineKit
 @param channel The channel name.
 @param uid The user ID of the user. A `uid` of 0 indicates the local user.
 @param filePath The local path of the snapshot.
 @param width The width (px) of the snapshot.
 @param height The height (px) of the snapshot.
 @param errCode The message that confirms success or the reason why the snapshot is not successfully taken:

 - 0: Success.
 - < 0: Failure:

  - -1: The SDK fails to write data to a file or encode a JPEG image.
  - -2: The SDK does not find the video stream of the specified user within one second after the [takeSnapshot]([AgoraRtcEngineKit takeSnapshot:uid:filePath:]) method call succeeds.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine snapshotTaken:(NSString* _Nonnull)channel uid:(NSUInteger)uid filePath:(NSString* _Nonnull)filePath width:(NSInteger)width height:(NSInteger)height errCode:(NSInteger)errCode;

/** Occurs when the local video stream state changes.

 The SDK reports the current video state in this callback.

 The SDK triggers the `localVideoStateChange(AgoraLocalVideoStreamStateFailed, AgoraLocalVideoStreamErrorCaptureFailure)`
 callback in the following situations:

 - The application exits to the background, and the system recycles the camera.
 - The camera starts normally, but the captured video is not output for four seconds.

 When the camera outputs the captured video frames, if all the video frames are
 the same for 15 consecutive frames, the SDK triggers the `localVideoStateChange(AgoraLocalVideoStreamStateCapturing, AgoraLocalVideoStreamErrorCaptureFailure)`
 callback. Note that the video frame duplication detection is only available for
 video frames with a resolution greater than 200 × 200, a frame rate greater
 than or equal to 10 fps, and a bitrate less than 20 Kbps.

 @param engine AgoraRtcEngineKit object.
 @param state The local video state, see AgoraLocalVideoStreamState.
 @param error The detailed error information of the local video, see AgoraLocalVideoStreamError.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine localVideoStateChange:(AgoraLocalVideoStreamState)state error:(AgoraLocalVideoStreamError)error;

/** Occurs when the local audio state changes.

 This callback indicates the state change of the local audio stream, including the state of the audio sampling and encoding, and allows you to troubleshoot issues when exceptions occur.

 @note This callback can be inaccurate when the number of users (in the
 communication profile) or hosts (in the interactive live streaming profile) in a channel exceeds 17.

 @param engine See AgoraRtcEngineKit.
 @param uid ID of the remote user whose audio state changes.
 @param state  State of the remote audio. See [AgoraAudioRemoteState](AgoraAudioRemoteState).
 @param reason The reason of the remote audio state change. See [AgoraAudioRemoteStateReason](AgoraAudioRemoteStateReason).
 @param elapsed Time elapsed (ms) from the local user calling the [joinChannel]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) method until the SDK triggers this callback.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine remoteAudioStateChangedOfUid:(NSUInteger)uid state:(AgoraAudioRemoteState)state reason:(AgoraAudioRemoteStateReason)reason elapsed:(NSInteger)elapsed;

/** Occurs when the local audio state changes.

 This callback indicates the state change of the local audio stream, including the state of the audio sampling and encoding, and allows you to troubleshoot issues when exceptions occur.

 @param engine See AgoraRtcEngineKit.
 @param state The state of the local audio. See [AgoraAudioLocalState](AgoraAudioLocalState).
 @param error The error information of the local audio. See [AgoraAudioLocalError](AgoraAudioLocalError).

 @note When the state is AgoraAudioLocalStateFailed(3), see the `error` parameter for details.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine localAudioStateChange:(AgoraAudioLocalState)state error:(AgoraAudioLocalError)error;

/** Occurs when the first remote video frame is rendered.

 Same as [firstRemoteVideoFrameBlock]([AgoraRtcEngineKit firstRemoteVideoFrameBlock:]).

 @param engine  AgoraRtcEngineKit object.
 @param uid     User ID of the remote user sending the video stream.
 @param size    Size of the video frame (width and height).
 @param elapsed Time elapsed (ms) from the local user calling the [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) method until the SDK triggers this callback.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine firstRemoteVideoFrameOfUid:(NSUInteger)uid size:(CGSize)size elapsed:(NSInteger)elapsed;

/** Occurs when the audio publishing state changes.

 @since v3.1.0

 This callback indicates the publishing state change of the local audio stream.

 @param engine     AgoraRtcEngineKit object.
 @param channel    The channel name.
 @param oldState   The previous publishing state. For details, see AgoraStreamPublishState.
 @param newState   The current publishing state. For details, see AgoraStreamPublishState.
 @param elapseSinceLastState The time elapsed (ms) from the previous state to the current state.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine didAudioPublishStateChange:(NSString* _Nonnull)channel oldState:(AgoraStreamPublishState)oldState newState:(AgoraStreamPublishState)newState elapseSinceLastState:(NSInteger)elapseSinceLastState;

/** Occurs when the video publishing state changes.

 @since v3.1.0

 This callback indicates the publishing state change of the local video stream.

 @param engine     AgoraRtcEngineKit object.
 @param channel    The channel name.
 @param oldState   The previous publishing state. For details, see AgoraStreamPublishState.
 @param newState   The current publishing state. For details, see AgoraStreamPublishState.
 @param elapseSinceLastState The time elapsed (ms) from the previous state to the current state.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine didVideoPublishStateChange:(NSString* _Nonnull)channel oldState:(AgoraStreamPublishState)oldState newState:(AgoraStreamPublishState)newState elapseSinceLastState:(NSInteger)elapseSinceLastState;

/** Occurs when the audio subscribing state changes.

 @since v3.1.0

 This callback indicates the subscribing state change of a remote audio stream.

 @param engine    AgoraRtcEngineKit object.
 @param channel   The channel name.
 @param uid       The ID of the remote user.
 @param oldState  The previous subscribing state. For details, see AgoraStreamSubscribeState.
 @param newState  The current subscribing state. For details, see AgoraStreamSubscribeState.
 @param elapseSinceLastState The time elapsed (ms) from the previous state to the current state.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine didAudioSubscribeStateChange:(NSString* _Nonnull)channel withUid:(NSUInteger)uid oldState:(AgoraStreamSubscribeState)oldState newState:(AgoraStreamSubscribeState)newState elapseSinceLastState:(NSInteger)elapseSinceLastState;

/** Occurs when the video subscribing state changes.

 @since v3.1.0

 This callback indicates the subscribing state change of a remote video stream.

 @param engine    AgoraRtcEngineKit object.
 @param channel   The channel name.
 @param uid       The ID of the remote user.
 @param oldState  The previous subscribing state. For details, see AgoraStreamSubscribeState.
 @param newState  The current subscribing state. For details, see AgoraStreamSubscribeState.
 @param elapseSinceLastState The time elapsed (ms) from the previous state to the current state.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine didVideoSubscribeStateChange:(NSString* _Nonnull)channel withUid:(NSUInteger)uid oldState:(AgoraStreamSubscribeState)oldState newState:(AgoraStreamSubscribeState)newState elapseSinceLastState:(NSInteger)elapseSinceLastState;

/** Occurs when a remote user's audio stream is muted/unmuted.

 You can also use the [remoteAudioStateChangedOfUid]([AgoraRtcEngineDelegate rtcEngine:remoteAudioStateChangedOfUid:state:reason:elapsed:]) callback with the following parameters instead:

 - `AgoraAudioRemoteStateStopped(0)` and `AgoraAudioRemoteReasonRemoteMuted(5)`.
 - `AgoraAudioRemoteStateDecoding(2)` and `AgoraAudioRemoteReasonRemoteUnmuted(6)`.

 The SDK triggers this callback when the remote user stops or resumes sending the audio stream by calling the [muteLocalAudioStream]([AgoraRtcEngineKit muteLocalAudioStream:]) method.

 @note This callback can be inaccurate when the number of users (in the
 communication profile) or hosts (in the interactive live streaming profile) in a channel exceeds 17.

 @param engine AgoraRtcEngineKit object.
 @param muted  Whether the remote user's audio stream is muted/unmuted:

 * YES: Muted.
 * NO: Unmuted.
 @param uid  ID of the remote user.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine didAudioMuted:(BOOL)muted byUid:(NSUInteger)uid;

/** Occurs when a remote user stops or resumes publishing the video stream.

 Same as [userMuteVideoBlock]([AgoraRtcEngineKit userMuteVideoBlock:]).

 When a remote user calls [muteLocalVideoStream]([AgoraRtcEngineKit muteLocalVideoStream:])
 to stop or resume publishing the video stream, the SDK triggers this callback
 to report the state of the remote user's publishing stream to the local user.

 @note This callback can be inaccurate when the number of users (in the
 communication profile) or hosts (in the interactive live streaming profile) in a channel exceeds 17.

 @param engine AgoraRtcEngineKit object.
 @param muted  A remote user's video stream playback pauses/resumes:

 * YES: Pause.
 * NO: Resume.

 @param uid    User ID of the remote user.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine didVideoMuted:(BOOL)muted byUid:(NSUInteger)uid;

/** Occurs when a specific remote user enables/disables the video module.

 Once the video module is disabled, the remote user can only use a voice call. The remote user cannot send or receive any video from other users.

 The SDK triggers this callback when the remote user enables or disables the video module by calling the [enableVideo]([AgoraRtcEngineKit enableVideo]) or [disableVideo]([AgoraRtcEngineKit disableVideo]) method.

 @param engine  AgoraRtcEngineKit object.
 @param enabled Whether the remote user enables/disables the video module:

 * YES: Enable. The remote user can enter a video session.
 * NO: Disable. The remote user can only enter a voice session, and cannot send or receive any video stream.

 @param uid  User ID of the remote user.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine didVideoEnabled:(BOOL)enabled byUid:(NSUInteger)uid;

/** Occurs when a specific remote user enables/disables the local video capturing function.

 This callback is only applicable to the scenario when the user only wants to watch the remote video without sending any video stream to the other user.

 @param engine  AgoraRtcEngineKit object.
 @param enabled Whether the specific remote user enables/disables the local video capturing function:

 * YES: Enable. Other users in the channel can see the video of this remote user.
 * NO: Disable. Other users in the channel do not receive the video stream from this remote user, while this remote user can still receive the video streams from other users.

 @param uid  User ID of the remote user.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine didLocalVideoEnabled:(BOOL)enabled byUid:(NSUInteger)uid;

/** Occurs when the first remote video frame is received and decoded.

 You can also use AgoraVideoRemoteStateStarting(1) or AgoraVideoRemoteStateDecoding(2) in the [remoteVideoStateChangedOfUid]([AgoraRtcEngineDelegate rtcEngine:remoteVideoStateChangedOfUid:state:reason:elapsed:]) callback instead.

 Same as [firstRemoteVideoDecodedBlock]([AgoraRtcEngineKit firstRemoteVideoDecodedBlock:]).

 This callback is triggered in either of the following scenarios:

 - The remote user joins the channel and sends the video stream.
 - The remote user stops sending the video stream and re-sends it after 15 seconds. Possible reasons include:

    - The remote user leaves channel.
    - The remote user drops offline.
    - The remote user calls [muteLocalVideoStream]([AgoraRtcEngineKit muteLocalVideoStream:]).
    - The remote user calls [disableVideo]([AgoraRtcEngineKit disableVideo]).

 @param engine  AgoraRtcEngineKit object.
 @param uid     User ID of the remote user sending the video stream.
 @param size    Size of the video frame (width and height).
 @param elapsed Time elapsed (ms) from the local user calling the [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) method until the SDK triggers this callback.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine firstRemoteVideoDecodedOfUid:(NSUInteger)uid size:(CGSize)size elapsed:(NSInteger)elapsed;

#pragma mark Fallback Delegate Methods

/**-----------------------------------------------------------------------------
 * @name Fallback Delegate Methods
 * -----------------------------------------------------------------------------
 */

/** Occurs when the published video stream falls back to an audio-only stream due to unreliable network conditions or switches back to the video when the network conditions improve.

 If you call the [setLocalPublishFallbackOption]([AgoraRtcEngineKit setLocalPublishFallbackOption:]) method and set `option` as AgoraStreamFallbackOptionAudioOnly, the SDK triggers this callback when the published stream falls back to audio-only mode due to unreliable uplink conditions, or when the audio stream switches back to the video when the uplink network condition improves.

 **Note:**

 Once the published stream falls back to audio only, the remote app receives the [userMuteVideoBlock]([AgoraRtcEngineKit userMuteVideoBlock:]) callback.

 @param engine              AgoraRtcEngineKit object.
 @param isFallbackOrRecover Whether the published stream falls back to audio-only or switches back to the video:

 * YES: The published stream falls back to audio-only due to unreliable network conditions.
 * NO: The published stream switches back to the video after the network conditions improve.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine didLocalPublishFallbackToAudioOnly:(BOOL)isFallbackOrRecover;

/** Occurs when the remote video stream falls back to an audio-only stream due to unreliable network conditions or switches back to the video after the network conditions improve.

If you call [setRemoteSubscribeFallbackOption]([AgoraRtcEngineKit setRemoteSubscribeFallbackOption:]) and set `option` as `AgoraStreamFallbackOptionAudioOnly`, the SDK triggers this callback when the remote media stream falls back to audio only due to poor downlink conditions or switches back to the video after the downlink network condition improves.

**Note:**

Once the remote media stream is switched to the low stream due to unreliable network conditions, you can monitor the stream switch between a high stream and low stream in the [remoteVideoStats]([AgoraRtcEngineDelegate rtcEngine:remoteVideoStats:]) callback.

@param engine              AgoraRtcEngineKit object.
@param isFallbackOrRecover Whether the remote media stream falls back to audio-only or switches back to the video:

* YES: The remote media stream falls back to audio-only due to unreliable network conditions.
* NO: The remote media stream switches back to the video stream after the network conditions improve.
@param uid                 ID of the remote user sending the stream.
*/
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine didRemoteSubscribeFallbackToAudioOnly:(BOOL)isFallbackOrRecover byUid:(NSUInteger)uid;

/**-----------------------------------------------------------------------------
 * @name Face Detection Delegate Methods
 * -----------------------------------------------------------------------------
 */

/** Reports the face detection result of the local user. (iOS only)

 **Since:** v3.0.1.

 Once you enable face detection by calling [enableFaceDetection]([AgoraRtcEngineKit enableFaceDetection:]), you can get the following information on the local user in real-time:

 - The width and height of the local video.
 - The position of the human face in the local video.
 - The distance between the human face and the device screen. This value is based on the fitting calculation of the local video size and the position of the human face.

 **Note**

 - If the SDK does not detect a face, it reduces the frequency of this callback to reduce power consumption on the local device.
 - The SDK stops triggering this callback when a human face is in close proximity to the screen.

 @param engine AgoraRtcEngineKit object.
 @param width The width (px) of the local video.
 @param height The height (px) of the local video.
 @param faces An AgoraFacePositionInfo array, which contains the information of the detected human face.

 The number of the AgoraFacePositionInfo array depends on the number of human faces detected. If the array length is 0, it means that no human face is detected.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine facePositionDidChangeWidth:(int)width previewHeight:(int)height faces:(NSArray<AgoraFacePositionInfo*>* _Nullable)faces;

#pragma mark Device Delegate Methods

/**-----------------------------------------------------------------------------
 * @name Device Delegate Methods
 * -----------------------------------------------------------------------------
 */

#if (!(TARGET_OS_IPHONE) && (TARGET_OS_MAC))

/** Occurs when the device state changes. (macOS only.)

 @param engine     AgoraRtcEngineKit object.
 @param deviceId   Device ID.
 @param deviceType Device type: AgoraMediaDeviceType.
 @param state      The state of the device:

 - `0`: The device is connected but not in use.
 - `8`: The device is not connected.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine device:(NSString* _Nonnull)deviceId type:(AgoraMediaDeviceType)deviceType stateChanged:(NSInteger)state;

#endif

/** Occurs when the local audio route changes.

 @param engine  AgoraRtcEngineKit object.
 @param routing The current audio route: AgoraAudioOutputRouting.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine didAudioRouteChanged:(AgoraAudioOutputRouting)routing;

#if defined(TARGET_OS_IPHONE) && TARGET_OS_IPHONE

/** Occurs when a camera focus area changes. (iOS only.)

The SDK triggers this callback when the local user changes the camera focus position by calling the [setCameraFocusPositionInPreview](setCameraFocusPositionInPreview:) method.

 @param engine AgoraRtcEngineKit object.
 @param rect   Rectangular area in the camera zoom specifying the focus area.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine cameraFocusDidChangedToRect:(CGRect)rect;

#endif

#if defined(TARGET_OS_IPHONE) && TARGET_OS_IPHONE
/** Occurs when the camera exposure area changes. (iOS only)

The SDK triggers this callback when the local user changes the camera exposure position by calling the [setCameraExposurePosition](setCameraExposurePosition:) method.

@param engine AgoraRtcEngineKit object.
@param rect   Rectangular area in the camera zoom specifying the exposure area.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine cameraExposureDidChangedToRect:(CGRect)rect;
#endif

#pragma mark Statistics Delegate Methods

/**-----------------------------------------------------------------------------
 * @name Statistics Delegate Methods
 * -----------------------------------------------------------------------------
 */

/** Reports the statistics of the current call. The SDK triggers this callback once every two seconds after the user joins the channel.

 @param engine AgoraRtcEngineKit object.
 @param stats  Statistics of the AgoraRtcEngineKit: [AgoraChannelStats](AgoraChannelStats).
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine reportRtcStats:(AgoraChannelStats* _Nonnull)stats;

/** Reports the last mile network quality of the local user once every two seconds before the user joins a channel.

Last mile refers to the connection between the local device and Agora's edge server. After the app calls the [enableLastmileTest]([AgoraRtcEngineKit enableLastmileTest]) method, the SDK triggers this callback once every two seconds to report the uplink and downlink last mile network conditions of the local user before the user joins the channel.

 @param engine  AgoraRtcEngineKit object.
 @param quality The last mile network quality based on the uplink and dowlink packet loss rate and jitter. See AgoraNetworkQuality.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine lastmileQuality:(AgoraNetworkQuality)quality;

/** Reports the last mile network quality of each user in the channel once every two seconds.

 Last mile refers to the connection between the local device and Agora's edge server. The SDK triggers this callback once every two seconds to report the last mile network conditions of each user in the channel. If a channel includes multiple users, the SDK triggers this callback as many times.

 @note `txQuality` is `Unknown` when the user is not sending a stream; `rxQuality` is `Unknown` when the user is not receiving a stream.

 @param engine    AgoraRtcEngineKit object.
 @param uid       User ID. The network quality of the user with this `uid` is reported. If `uid` is 0, the local network quality is reported.
 @param txQuality Uplink transmission quality of the user in terms of the transmission bitrate, packet loss rate, average RTT (Round-Trip Time), and jitter of the uplink network. `txQuality` is a quality rating helping you understand how well the current uplink network conditions can support the selected AgoraVideoEncoderConfiguration. For example, a 1000-Kbps uplink network may be adequate for video frames with a resolution of 640 * 480 and a frame rate of 15 fps in the interactive live streaming profile, but may be inadequate for resolutions higher than 1280 * 720. See  AgoraNetworkQuality.
 @param rxQuality Downlink network quality rating of the user in terms of packet loss rate, average RTT, and jitter of the downlink network.  See AgoraNetworkQuality.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine networkQuality:(NSUInteger)uid txQuality:(AgoraNetworkQuality)txQuality rxQuality:(AgoraNetworkQuality)rxQuality;

/** Reports the last-mile network probe result.

The SDK triggers this callback within 30 seconds after the app calls the [startLastmileProbeTest]([AgoraRtcEngineKit startLastmileProbeTest:]) method.

 @param engine AgoraRtcEngineKit object.
 @param result The uplink and downlink last-mile network probe test result, see [AgoraLastmileProbeResult](AgoraLastmileProbeResult).
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine lastmileProbeTestResult:(AgoraLastmileProbeResult* _Nonnull)result;

/** Reports the statistics of the uploading local video streams once every two seconds. Same as [localVideoStatBlock]([AgoraRtcEngineKit localVideoStatBlock:]).

 @param engine AgoraRtcEngineKit object.
 @param stats Statistics of the uploading local video streams. See [AgoraRtcLocalVideoStats](AgoraRtcLocalVideoStats).
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine localVideoStats:(AgoraRtcLocalVideoStats* _Nonnull)stats;

/** Reports the statistics of the local audio stream.

 The SDK triggers this callback once every two seconds.

 @param engine See AgoraRtcEngineKit.
 @param stats The statistics of the local audio stream. See [AgoraRtcLocalAudioStats](AgoraRtcLocalAudioStats).
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine localAudioStats:(AgoraRtcLocalAudioStats* _Nonnull)stats;

/** Reports the statistics of the video stream from each remote user/host.

The SDK triggers this callback once every two seconds for each remote user/host. If a channel includes multiple remote users, the SDK triggers this callback as many times.

 This callback reports the statistics more closely linked to the real-user experience of the video transmission quality than the statistics that the [videoTransportStatsOfUid]([AgoraRtcEngineDelegate rtcEngine:videoTransportStatsOfUid:delay:lost:rxKBitRate:]) callback reports. This callback reports more about media layer statistics such as the frame loss rate, while the [videoTransportStatsOfUid]([AgoraRtcEngineDelegate rtcEngine:videoTransportStatsOfUid:delay:lost:rxKBitRate:]) callback reports more about the transport layer statistics such as the packet loss rate.

Schemes such as FEC (Forward Error Correction) or retransmission counter the frame loss rate. Hence, users may find the overall video quality acceptable even when the packet loss rate is high.


 @param engine AgoraRtcEngineKit object.
 @param stats  Statistics of the received remote video streams. See [AgoraRtcRemoteVideoStats](AgoraRtcRemoteVideoStats).
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine remoteVideoStats:(AgoraRtcRemoteVideoStats* _Nonnull)stats;

/** Reports the statistics of the audio stream from each remote user/host.

 This callback replaces the [audioQualityOfUid]([AgoraRtcEngineDelegate rtcEngine:audioQualityOfUid:quality:delay:lost:]) callback.

 The SDK triggers this callback once every two seconds for each remote user/host. If a channel includes multiple remote users, the SDK triggers this callback as many times.

 This callback reports the statistics more closely linked to the real-user experience of the audio transmission quality than the statistics that the [audioTransportStatsOfUid]([AgoraRtcEngineDelegate rtcEngine:audioTransportStatsOfUid:delay:lost:rxKBitRate:]) callback reports. This callback reports more about media layer statistics such as the frame loss rate, while the [audioTransportStatsOfUid]([AgoraRtcEngineDelegate rtcEngine:audioTransportStatsOfUid:delay:lost:rxKBitRate:]) callback reports more about the transport layer statistics such as the packet loss rate.

Schemes such as FEC (Forward Error Correction) or retransmission counter the frame loss rate. Hence, users may find the overall audio quality acceptable even when the packet loss rate is high.

 @param engine AgoraRtcEngineKit object.
 @param stats  Statistics of the received remote audio streams. See AgoraRtcRemoteAudioStats.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine remoteAudioStats:(AgoraRtcRemoteAudioStats* _Nonnull)stats;

#pragma mark Audio Player Delegate Methods

/**-----------------------------------------------------------------------------
 * @name Audio Player Delegate Methods
 * -----------------------------------------------------------------------------
 */

/** Occurs when the audio mixing file playback finishes.

You can start an audio mixing file playback by calling the [startAudioMixing]([AgoraRtcEngineKit startAudioMixing:loopback:replace:cycle:startPos:]) method. The SDK triggers this callback when the audio mixing file playback finishes.

 If the [startAudioMixing]([AgoraRtcEngineKit startAudioMixing:loopback:replace:cycle:startPos:]) method call fails, a warning code, AgoraWarningCodeAudioMixingOpenError, returns in the [didOccurWarning]([AgoraRtcEngineDelegate rtcEngine:didOccurWarning:]) callback.

 @param engine AgoraRtcEngineKit object.
 */
- (void)rtcEngineLocalAudioMixingDidFinish:(AgoraRtcEngineKit* _Nonnull)engine;

/** Occurs when the playback state of the local user's music file changes.

When the playback state of the local user's music file changes, the SDK triggers this callback and reports the
current playback state and the reason for the change.

@since v3.4.0

@param engine AgoraRtcEngineKit object.
@param state The current music file playback state. See AgoraAudioMixingStateCode.
@param reason The reason for the change of the music file playback state. See AgoraAudioMixingReasonCode.
*/
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine localAudioMixingStateDidChanged:(AgoraAudioMixingStateCode)state reason:(AgoraAudioMixingReasonCode)reason;

/** Occurs when a remote user starts audio mixing.

 The SDK triggers this callback when a remote user calls the [startAudioMixing]([AgoraRtcEngineKit startAudioMixing:loopback:replace:cycle:startPos:]) method.

 @param engine AgoraRtcEngineKit object.
 */
- (void)rtcEngineRemoteAudioMixingDidStart:(AgoraRtcEngineKit* _Nonnull)engine;

/** Occurs when a remote user finishes audio mixing.

 @param engine AgoraRtcEngineKit object.
 */
- (void)rtcEngineRemoteAudioMixingDidFinish:(AgoraRtcEngineKit* _Nonnull)engine;

/** Occurs when the local audio effect playback finishes.

 You can start a local audio effect playback by calling the [playEffect]([AgoraRtcEngineKit playEffect:filePath:loopCount:pitch:pan:gain:publish:startPos:]) method. The SDK triggers this callback when the local audio effect file playback finishes.

 @param engine  AgoraRtcEngineKit object.
 @param soundId ID of the local audio effect. Each local audio effect has a unique ID.
 */
- (void)rtcEngineDidAudioEffectFinish:(AgoraRtcEngineKit* _Nonnull)engine soundId:(NSInteger)soundId;

- (void)rtcEngineAirPlayIsConnected:(AgoraRtcEngineKit* _Nonnull)engine;

#pragma mark CDN Publisher Delegate Methods

/**-----------------------------------------------------------------------------
 * @name CDN Live Streaming Delegate Methods
 * -----------------------------------------------------------------------------
 */

/** Occurs when the state of the RTMP or RTMPS streaming changes.

The SDK triggers this callback to report the result of the local user calling the [addPublishStreamUrl](addPublishStreamUrl:transcodingEnabled:) or [removePublishStreamUrl](removePublishStreamUrl:) method.

This callback returns the URL and its current streaming state.

This callback indicates the state of the RTMP or RTMPS streaming. When exceptions occur, you can troubleshoot issues by referring to the detailed error descriptions in the `errorCode` parameter.

@param engine AgoraRtcEngineKit object.
@param url The CDN streaming URL.
@param state The RTMP or RTMPS streaming state: AgoraRtmpStreamingState.
@param errorCode The detailed error information for streaming: AgoraRtmpStreamingErrorCode.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine rtmpStreamingChangedToState:(NSString* _Nonnull)url state:(AgoraRtmpStreamingState)state errorCode:(AgoraRtmpStreamingErrorCode)errorCode;

/** Reports events during the RTMP or RTMPS streaming.

 @since v3.1.0

 @param engine AgoraRtcEngineKit object.
 @param url The RTMP or RTMPS streaming URL.
 @param eventCode The event code. See AgoraRtmpStreamingEvent.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine rtmpStreamingEventWithUrl:(NSString* _Nonnull)url eventCode:(AgoraRtmpStreamingEvent)eventCode;

/** Occurs when the CDN live streaming settings are updated.

 When the `LiveTranscoding` class in the [setLiveTranscoding]([AgoraRtcEngineKit setLiveTranscoding:]) method updates, the SDK triggers the rtcEngineTranscodingUpdated callback to report the update information to the local host.

 **Note:**

 If you call the `setLiveTranscoding` method to set the `LiveTranscoding` class for the first time, the SDK does not trigger the `rtcEngineTranscodingUpdated` callback.

 @param engine AgoraRtcEngineKit object.
 */
- (void)rtcEngineTranscodingUpdated:(AgoraRtcEngineKit* _Nonnull)engine;

#pragma mark Inject Stream URL Delegate Methods

/**-----------------------------------------------------------------------------
 * @name Inject Online Stream Delegate Methods
 * -----------------------------------------------------------------------------
 */

/** Reports the status of injecting an online stream to the interactive live streaming.

 @warning Agora will soon stop the service for injecting online media streams on the client. If you have not implemented this service, Agora recommends that you do not use it.

 @param engine  AgoraRtcEngineKit object.
 @param url     URL address of the externally injected stream.
 @param uid     User ID.
 @param status  Status of the externally injected stream. See AgoraInjectStreamStatus.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine streamInjectedStatusOfUrl:(NSString* _Nonnull)url uid:(NSUInteger)uid status:(AgoraInjectStreamStatus)status;

#pragma mark Stream Message Delegate Methods

/**-----------------------------------------------------------------------------
 * @name Stream Message Delegate Methods
 * -----------------------------------------------------------------------------
 */

/** Occurs when the local user receives the data stream from a remote user within five seconds.

The SDK triggers this callback when the local user receives the stream message that the remote user sends by calling the [sendStreamMessage](sendStreamMessage:data:) method.

 @param engine   AgoraRtcEngineKit object.
 @param uid      User ID of the remote user sending the message.
 @param streamId Stream ID.
 @param data     Data received by the local user.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine receiveStreamMessageFromUid:(NSUInteger)uid streamId:(NSInteger)streamId data:(NSData* _Nonnull)data;

/** Occurs when the local user does not receive the data stream from the remote user within five seconds.

 The SDK triggers this callback when the local user fails to receive the stream message that the remote user sends by calling the [sendStreamMessage](sendStreamMessage:data:) method.

 @param engine   AgoraRtcEngineKit object.
 @param uid      User ID of the remote user sending the message.
 @param streamId Stream ID.
 @param error    Error code. See AgoraErrorCode.
 @param missed Number of lost messages.
 @param cached Number of incoming cached messages when the data stream is interrupted.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine didOccurStreamMessageErrorFromUid:(NSUInteger)uid streamId:(NSInteger)streamId error:(NSInteger)error missed:(NSInteger)missed cached:(NSInteger)cached;

#pragma mark Miscellaneous Delegate Methods

/**-----------------------------------------------------------------------------
 * @name Miscellaneous Delegate Methods
 * -----------------------------------------------------------------------------
 */

/** Reports the information of an audio file.

 @since v3.5.1

 After successfully calling [getAudioFileInfo]([AgoraRtcEngineKit getAudioFileInfo:]),
 the SDK triggers this callback to report the information of the audio file,
 such as the file path and duration.

 @param engine AgoraRtcEngineKit object.
 @param info The information of an audio file. See AgoraRtcAudioFileInfo.
 @param error The information acquisition state. See AgoraAudioFileInfoError.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine didRequestAudioFileInfo:(AgoraRtcAudioFileInfo* _Nonnull)info error:(AgoraAudioFileInfoError)error;

- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine uploadLogResultRequestId:(NSString* _Nonnull)requestId success:(BOOL)success reason:(AgoraUploadErrorReason)reason;

/** Occurs when the media engine loads.

 @param engine AgoraRtcEngineKit object.
 */
- (void)rtcEngineMediaEngineDidLoaded:(AgoraRtcEngineKit* _Nonnull)engine;

/** Occurs when the media engine call starts.

 @param engine AgoraRtcEngineKit object.
 */
- (void)rtcEngineMediaEngineDidStartCall:(AgoraRtcEngineKit* _Nonnull)engine;

/** Occurs when the state of the media stream relay changes.

 The SDK reports the state of the current media relay and possible error messages in this callback.

 @param engine AgoraRtcEngineKit object.
 @param state The state code in [AgoraChannelMediaRelayState](AgoraChannelMediaRelayState).
 @param error The error code in [AgoraChannelMediaRelayError](AgoraChannelMediaRelayError).
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine channelMediaRelayStateDidChange:(AgoraChannelMediaRelayState)state error:(AgoraChannelMediaRelayError)error;

/** Reports events during the media stream relay.

 @param engine AgoraRtcEngineKit object.
 @param event The event code in [AgoraChannelMediaRelayEvent](AgoraChannelMediaRelayEvent).
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine didReceiveChannelMediaRelayEvent:(AgoraChannelMediaRelayEvent)event;

#pragma mark Deprecated Delegates

/**-----------------------------------------------------------------------------
 * @name Deprecated Delegates
 * -----------------------------------------------------------------------------
 */
/** Occurs when the engine sends the first local audio frame.

**Deprecated**  from v3.1.0. Use [firstLocalAudioFramePublished]([AgoraRtcEngineDelegate rtcEngine:firstLocalAudioFramePublished:]) instead.

 @param engine  AgoraRtcEngineKit object.
 @param elapsed Time elapsed (ms) from the local user calling the [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) method until the SDK triggers this callback.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine firstLocalAudioFrame:(NSInteger)elapsed;

/** Occurs when the engine receives the first audio frame from a specified remote user.

 **Deprecated**  from v3.0.0. Use `AgoraAudioRemoteStateStarting(1)` in the [remoteAudioStateChangedOfUid]([AgoraRtcEngineDelegate rtcEngine:remoteAudioStateChangedOfUid:state:reason:elapsed:]) callback.

 This callback is triggered in either of the following scenarios:

 - The remote user joins the channel and sends the audio stream.
 - The remote user stops sending the audio stream and re-sends it after 15 seconds. Possible reasons include:

    - The remote user leaves channel.
    - The remote user drops offline.
    - The remote user calls [muteLocalAudioStream]([AgoraRtcEngineKit muteLocalAudioStream:]).
    - The remote user calls [disableAudio]([AgoraRtcEngineKit disableAudio]).

 @param engine  AgoraRtcEngineKit object.
 @param uid     User ID of the remote user.
 @param elapsed Time elapsed (ms) from the local user calling the [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) method until the SDK triggers this callback.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine firstRemoteAudioFrameOfUid:(NSUInteger)uid elapsed:(NSInteger)elapsed;

/** Occurs when the SDK decodes the first remote audio frame for playback.

 **Deprecated**  from v3.0.0. Use `AgoraAudioRemoteStateDecoding(2)` in the [remoteAudioStateChangedOfUid]([AgoraRtcEngineDelegate rtcEngine:remoteAudioStateChangedOfUid:state:reason:elapsed:]) callback instead.

 This callback is triggered in either of the following scenarios:

 - The remote user joins the channel and sends the audio stream.
 - The remote user stops sending the audio stream and re-sends it after 15 seconds. Reasons for such an interruption include:

     - The remote user leaves channel.
     - The remote user drops offline.
     - The remote user calls the [muteLocalAudioStream]([AgoraRtcEngineKit muteLocalAudioStream:]) method to stop sending the local audio stream.
     - The remote user calls the [disableAudio]([AgoraRtcEngineKit disableAudio]) method to disable audio.

 @param engine AgoraRtcEngineKit object.
 @param uid User ID of the remote user sending the audio stream.
 @param elapsed The time elapsed (ms) from the local user calling the joinChannel method until the SDK triggers this callback.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine firstRemoteAudioFrameDecodedOfUid:(NSUInteger)uid elapsed:(NSInteger)elapsed;

/** Reports the result of calling the [addPublishStreamUrl]([AgoraRtcEngineKit addPublishStreamUrl:transcodingEnabled:]) method.

 **Deprecated**  from v3.0.0. Use the [rtmpStreamingChangedToState]([AgoraRtcEngineDelegate rtcEngine:rtmpStreamingChangedToState:state:errorCode:]) callback instead.

 @param engine    AgoraRtcEngineKit object.
 @param url       The CDN streaming URL.
 @param errorCode Error code: [AgoraErrorCode](AgoraErrorCode). Main errors include:

 - AgoraErrorCodeNoError(0): The publishing succeeds.
 - AgoraErrorCodeFailed(1): The publishing fails.
 - AgoraErrorCodeInvalidArgument(2): Invalid argument used. If, for example, you do not call the [setLiveTranscoding]([AgoraRtcEngineKit setLiveTranscoding:]) method to configure AgoraLiveTranscoding before calling the [addPublishStreamUrl]([AgoraRtcEngineKit addPublishStreamUrl:transcodingEnabled:]) method, the SDK reports this error.
 - AgoraErrorCodeTimedOut(10): The publishing times out.
 - AgoraErrorCodeAlreadyInUse(19): The CDN streaming URL is already in use for CDN live streaming.
 - AgoraErrorCodeEncryptedStreamNotAllowedPublish(130): You cannot publish an encrypted stream.
 - AgoraErrorCodePublishStreamCDNError(151): CDN related errors. Remove the original URL address and add a new one by calling the [removePublishStreamUrl]([AgoraRtcEngineKit removePublishStreamUrl:]) and [addPublishStreamUrl]([AgoraRtcEngineKit addPublishStreamUrl:transcodingEnabled:]) methods.
 - AgoraErrorCodePublishStreamNumReachLimit(152): The host publishes more than 10 URLs. Delete the unnecessary URLs before adding new ones.
 - AgoraErrorCodePublishStreamNotAuthorized(153): The host manipulates other hosts' URLs. Check your app logic.
 - AgoraErrorCodePublishStreamInternalServerError(154): An error occurs in Agora's streaming server. Call the [addPublishStreamUrl]([AgoraRtcEngineKit addPublishStreamUrl:transcodingEnabled:]) method to publish the streaming again.
 - AgoraErrorCodePublishStreamFormatNotSuppported(156): The format of the RTMP stream URL is not supported. Check whether the URL format is correct.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine streamPublishedWithUrl:(NSString* _Nonnull)url errorCode:(AgoraErrorCode)errorCode;

/** Reports the result of calling the [removePublishStreamUrl]([AgoraRtcEngineKit removePublishStreamUrl:]) method.

 **Deprecated**  from v3.0.0. Use the [rtmpStreamingChangedToState]([AgoraRtcEngineDelegate rtcEngine:rtmpStreamingChangedToState:state:errorCode:]) callback instead.

 This callback indicates whether you have successfully removed an RTMP stream from the CDN.

 @param engine AgoraRtcEngineKit object.
 @param url    The CDN streaming URL.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine streamUnpublishedWithUrl:(NSString* _Nonnull)url;

/** Reports the transport-layer statistics of each remote audio stream.

 **Deprecated**  from v2.9.0. Use the [remoteAudioStats]([AgoraRtcEngineDelegate rtcEngine:remoteAudioStats:]) callback instead.

 This callback reports the transport-layer statistics, such as the packet loss rate and network time delay, once every two seconds after the local user receives an audio packet from a remote user.

 @param engine     AgoraRtcEngineKit object.
 @param uid        User ID of the remote user sending the audio packet.
 @param delay      Network time delay (ms) from the remote user sending the audio packet to the local user.
 @param lost       Packet loss rate (%) of the audio packet sent from the remote user.
 @param rxKBitRate Received bitrate (Kbps) of the audio packet sent from the remote user.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine audioTransportStatsOfUid:(NSUInteger)uid delay:(NSUInteger)delay lost:(NSUInteger)lost rxKBitRate:(NSUInteger)rxKBitRate;

/** Reports the transport-layer statistics of each remote video stream.

 **Deprecated**  from v2.9.0. Use the [remoteVideoStats]([AgoraRtcEngineDelegate rtcEngine:remoteVideoStats:]) callback instead.

 This callback reports the transport layer statistics, such as the packet loss rate and network time delay, once every two seconds after the local user receives a video packet from a remote user.

 @param engine     AgoraRtcEngineKit object.
 @param uid        User ID of the remote user sending the video packet.
 @param delay      Network time delay (ms) from the remote user sending the video packet to the local user.
 @param lost       Packet loss rate (%) of the video packet sent from the remote user.
 @param rxKBitRate Received bitrate (Kbps) of the video packet sent from the remote user.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine videoTransportStatsOfUid:(NSUInteger)uid delay:(NSUInteger)delay lost:(NSUInteger)lost rxKBitRate:(NSUInteger)rxKBitRate;

/** Occurs when the microphone is enabled/disabled.

 **Deprecated**  from v2.9.0. Use AgoraAudioLocalStateStopped(0) or AgoraAudioLocalStateRecording(1) in the [localAudioStateChange]([AgoraRtcEngineDelegate rtcEngine:localAudioStateChange:error:]) callback instead.

 The SDK triggers this callback when the local user resumes or stops capturing the local audio stream by calling the [enableLocalAudio]([AgoraRtcEngineKit enableLocalAudio:]) method.

 @param engine AgoraRtcEngineKit object.
 @param enabled  Whether the microphone is enabled/disabled:

 * YES: Enabled.
 * NO: Disabled.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine didMicrophoneEnabled:(BOOL)enabled;

/** Occurs when the connection between the SDK and the server is interrupted.

**Deprecated**  from v2.3.2. Use `AgoraConnectionStateReconnecting(4)` and `AgoraConnectionChangedInterrupted(2)` of the [connectionChangedToState]([AgoraRtcEngineDelegate rtcEngine:connectionChangedToState:reason:]) callback instead.

The SDK triggers this callback when it loses connection with the server for more than four seconds after a connection is established.

After triggering this callback, the SDK tries reconnecting to the server. You can use this callback to implement pop-up reminders.

This callback is different from [rtcEngineConnectionDidLost]([AgoraRtcEngineDelegate rtcEngineConnectionDidLost:]):

- The SDK triggers the [rtcEngineConnectionDidInterrupted]([AgoraRtcEngineDelegate rtcEngineConnectionDidInterrupted:]) callback when it loses connection with the server for more than four seconds after it joins the channel.
- The SDK triggers the [rtcEngineConnectionDidLost]([AgoraRtcEngineDelegate rtcEngineConnectionDidLost:]) callback when it loses connection with the server for more than 10 seconds, regardless of whether it joins the channel or not.

If the SDK fails to rejoin the channel 20 minutes after being disconnected from Agora's edge server, the SDK stops rejoining the channel.

 @param engine AgoraRtcEngineKit object.
 */
- (void)rtcEngineConnectionDidInterrupted:(AgoraRtcEngineKit* _Nonnull)engine;

/** Occurs when your connection is banned by the Agora server.

**Deprecated**  from v2.3.2. Use `AgoraConnectionStateFailed(5)` and `AgoraConnectionChangedBannedByServer(3)` of [connectionChangedToState]([AgoraRtcEngineDelegate rtcEngine:connectionChangedToState:reason:]) callback instead.

@param engine AgoraRtcEngineKit object
 */
- (void)rtcEngineConnectionDidBanned:(AgoraRtcEngineKit* _Nonnull)engine;

/** Reports the audio quality of the remote user.

Same as [audioQualityBlock]([AgoraRtcEngineKit audioQualityBlock:]).

**Deprecated**  from v2.3.2. Use [remoteAudioStats]([AgoraRtcEngineDelegate rtcEngine:remoteAudioStats:]) instead.

The SDK triggers this callback once every two seconds. This callback reports the audio quality of each remote user/host sending an audio stream. If a channel has multiple users/hosts sending audio streams, then the SDK triggers this callback as many times.

 @see See [remoteAudioStats]([AgoraRtcEngineDelegate rtcEngine:remoteAudioStats:])
 @param engine  AgoraRtcEngineKit object.
 @param uid     User ID of the speaker.
 @param quality Audio quality of the user, see AgoraNetworkQuality.
 @param delay   Time delay (ms) of the audio packet sent from the sender to the receiver, including the time delay from audio sampling pre-processing, transmission, and the jitter buffer.
 @param lost    Packet loss rate (%) of the audio packet sent from the sender to the receiver.
 */
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine audioQualityOfUid:(NSUInteger)uid quality:(AgoraNetworkQuality)quality delay:(NSUInteger)delay lost:(NSUInteger)lost;

/** Occurs when the camera turns on and is ready to capture video.

**Deprecated**  from v2.4.1. Use AgoraLocalVideoStreamStateCapturing(1) in the `state` parameter of [localVideoStateChange]([AgoraRtcEngineDelegate rtcEngine:localVideoStateChange:error:]) instead.

 Same as [cameraReadyBlock]([AgoraRtcEngineKit cameraReadyBlock:]).

 @see [localVideoStateChange]([AgoraRtcEngineDelegate rtcEngine:localVideoStateChange:error:])
 @param engine AgoraRtcEngineKit object.
 */
- (void)rtcEngineCameraDidReady:(AgoraRtcEngineKit* _Nonnull)engine;

/** Occurs when the video stops playing.

**Deprecated**  from v2.4.1. Use AgoraLocalVideoStreamStateStopped(0) in the `state` parameter of [localVideoStateChange]([AgoraRtcEngineDelegate rtcEngine:localVideoStateChange:error:]) instead

 The app can use this callback to change the configuration of the view (for example, to display other screens in the view) after the video stops.

 @see [localVideoStateChange]([AgoraRtcEngineDelegate rtcEngine:localVideoStateChange:error:])
 @param engine AgoraRtcEngineKit object.
 */
- (void)rtcEngineVideoDidStop:(AgoraRtcEngineKit* _Nonnull)engine;

@end

#pragma mark - AgoraRtcEngineKit

/** The AgoraRtcEngineKit class provides all methods invoked by your app.

 Agora provides ensured quality of experience (QoE) for worldwide Internet-based voice and video communications through a virtual global network optimized for real-time web and mobile-to-mobile apps.

 AgoraRtcEngineKit is the basic interface class of the SDK. Creating an AgoraRtcEngineKit object and then calling the methods of this object enables the use of the SDK’s communication functionality.
*/
__attribute__((visibility("default"))) @interface AgoraRtcEngineKit : NSObject

#pragma mark Core Service

/**-----------------------------------------------------------------------------
 * @name Core Service
 * -----------------------------------------------------------------------------
 */

/** Creates an AgoraRtcEngineKit instance.

  Unless otherwise specified, all the methods provided by the AgoraRtcEngineKit instance are executed asynchronously. Agora recommends calling these methods in the same thread.

  **Note:**

  - You must create an AgoraRtcEngineKit instance before calling any other method.
  - You can create an AgoraRtcEngineKit instance either by calling this method or by calling [sharedEngineWithConfig]([AgoraRtcEngineKit sharedEngineWithConfig:delegate:]). The difference between `sharedEngineWithConfig` and this method is that `sharedEngineWithConfig` enables you to specify the region for connection.
  - The Agora RTC Native SDK supports creating only one AgoraRtcEngineKit instance for an app for now.

 @param appId    The App ID issued to you by Agora. See [How to get the App ID](https://docs.agora.io/en/Agora%20Platform/token#get-an-app-id). Only users in apps with the same App ID can join the same channel and communicate with each other. Use an App ID to create only one AgoraRtcEngineKit instance. To change your App ID, call [destroy]([AgoraRtcEngineKit destroy]) to `destroy` the current AgoraRtcEngineKit instance, and after `destroy` returns 0, call `sharedEngineWithAppId` to create an AgoraRtcEngineKit instance with the new App ID.
 @param delegate AgoraRtcEngineDelegate.

 @return - The AgoraRtcEngineKit instance, if this method call succeeds.
 - The error code, if this method call fails.

  - `-1`(`AgoraErrorCodeFailed`): A general error occurs (no specified reason).
  - `-2`(`AgoraErrorCodeInvalidArgument`): No `AgoraRtcEngineDelegate` object is specified.
  - `-7`(`AgoraErrorCodeNotInitialized`): The SDK is not initialized.
  - `-101`(`AgoraErrorCodeInvalidAppId`): The App ID is invalid.
 */
+ (instancetype _Nonnull)sharedEngineWithAppId:(NSString* _Nonnull)appId delegate:(id<AgoraRtcEngineDelegate> _Nullable)delegate;

/** Creates an AgoraRtcEngineKit instance.

  Unless otherwise specified, all the methods provided by the AgoraRtcEngineKit instance are executed asynchronously. Agora recommends calling these methods in the same thread.

  **Note:**

  - You must create the AgoraRtcEngineKit instance before calling any other method.
  - You can create an AgoraRtcEngineKit instance either by calling this method or by calling [sharedEngineWithAppId]([AgoraRtcEngineKit sharedEngineWithAppId:delegate:]). The difference between `sharedEngineWithAppId` and this method is that this method enables you to specify the region for connection.
  - The Agora RTC Native SDK supports creating only one AgoraRtcEngineKit instance for an app for now.

  @param config    Configurations for the AgoraRtcEngineKit instance. For details, see AgoraRtcEngineConfig.
  @param delegate AgoraRtcEngineDelegate.

  @return - The AgoraRtcEngineKit instance, if this method call succeeds.
 - The error code, if this method call fails.

  - `-1`(`AgoraErrorCodeFailed`): A general error occurs (no specified reason).
  - `-2`(`AgoraErrorCodeInvalidArgument`): No `AgoraRtcEngineDelegate` object is specified.
  - `-7`(`AgoraErrorCodeNotInitialized`): The SDK is not initialized.
  - `-101`(`AgoraErrorCodeInvalidAppId`): The App ID is invalid.
  */
+ (instancetype _Nonnull)sharedEngineWithConfig:(AgoraRtcEngineConfig* _Nonnull)config delegate:(id<AgoraRtcEngineDelegate> _Nullable)delegate;

/** Destroys the `AgoraRtcEngineKit` instance and releases all resources used by the Agora SDK.

 Use this method for apps in which users occasionally make voice or video calls. When users do not make calls, you can free up resources
 for other operations. Once you call `destroy` to destroy the created `AgoraRtcEngineKit` instance, you cannot use any method or callback
 in the SDK any more. If you want to use the real-time communication functions again, you must call
 [sharedEngineWithappId]([AgoraRtcEngineKit sharedEngineWithAppId:delegate:]) to create a new `AgoraRtcEngineKit` instance.

 **Note:**

 - Because `destroy` is a synchronous method and the app cannot move on to another task until the execution completes, Agora suggests
 calling this method in a sub-thread to avoid congestion in the main thread. Besides, you **cannot** call `destroy` in any method or
 callback of the SDK. Otherwise, the SDK cannot release the resources occupied by the `AgoraRtcEngineKit` instance until the callbacks
 return results, which may result in a deadlock.
 - If you want to create a new `AgoraRtcEngineKit` instance after destroying the current one, ensure that you wait till the `destroy` method completes executing.
 */
+ (void)destroy;

/** Sets the channel profile of the AgoraRtcEngineKit.

 After initialization, the SDK uses the communication channel profile by default.
 You can call `setChannelProfile` to set the channel profile.
 The `AgoraRtcEngineKit` differentiates channel profiles and applies optimization
 algorithms accordingly. For example, it prioritizes smoothness and low latency
 for a video call, and prioritizes video quality for the interactive live video streaming.

 **Note:**

 - To ensure the quality of real-time communication, we recommend that all users in a channel use the same channel profile.
 - Call this method before calling [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]). You cannot set the channel profile once you have joined the channel.
 - The default audio route and video encoding bitrate are different in different channel profiles. For details, see [setDefaultAudioRouteToSpeakerphone]([AgoraRtcEngineKit setDefaultAudioRouteToSpeakerphone:]) and [setVideoEncoderConfiguration]([AgoraRtcEngineKit setVideoEncoderConfiguration:]).

 @param profile The channel profile of the AgoraRtcEngineKit: [AgoraChannelProfile](AgoraChannelProfile).

 @return - `0`(`AgoraErrorCodeNoError`): Success.
- < `0`: Failure.

  - `-2`(`AgoraErrorCodeInvalidArgument`): The parameter is invalid.
  - `-7`(`AgoraErrorCodeNotInitialized`): The SDK is not initialized.
 */
- (int)setChannelProfile:(AgoraChannelProfile)profile;

/** Sets the role of the user in interactive live streaming.

 After calling [setChannelProfile(AgoraChannelProfileLiveBroadcasting)]([AgoraRtcEngineKit setChannelProfile:]),
 the SDK sets the user role as audience by default. You can call
 `setClientRole` to set the user role as host.

 You can call this method either before or after joining a channel.
 If you call this method to switch the user role after joining a channel,
 the SDK automatically does the following:

 - Calls [muteLocalAudioStream]([AgoraRtcEngineKit muteLocalAudioStream:]) and
 [muteLocalVideoStream]([AgoraRtcEngineKit muteLocalVideoStream:]) to change
 the publishing state.
 - Triggers [didClientRoleChanged]([AgoraRtcEngineDelegate rtcEngine:didClientRoleChanged:newRole:])
 on the local client.
 - Triggers [didJoinedOfUid]([AgoraRtcEngineDelegate rtcEngine:didJoinedOfUid:elapsed:])
 or [didOfflineOfUid(AgoraUserOfflineReasonBecomeAudience)]([AgoraRtcEngineDelegate rtcEngine:didOfflineOfUid:reason:])
 on the remote client.

 @note This method applies to the `AgoraChannelProfileLiveBroadcasting` profile
 only (when the `profile` parameter in `setChannelProfile` is set as
 `AgoraChannelProfileLiveBroadcasting`).

 @param role The role of a user in interactive live streaming.
 See [AgoraClientRole](AgoraClientRole).

 @return - 0(`AgoraErrorCodeNoError`): Success.
 - < 0: Failure.

   - -1(`AgoraErrorCodeFailed`): A general error occurs (no specified reason).
   - -2(`AgoraErrorCodeInvalidArgument`): The parameter is invalid.
   - -7(`AgoraErrorCodeNotInitialized`): The SDK is not initialized.
   - -5 (`AgoraErrorCodeRefused`): The request is rejected. In multichannel
   scenarios, if you have set any of the following in one channel, the SDK
   returns this error code when the user switches the user role to host
   in another channel:

     - Call [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:options:])
     with the `options` parameter and use the default settings
     `publishLocalAudio = YES` or `publishLocalVideo = YES`.
     - Call `setClientRole` to set the user role as host.
     - Call `muteLocalAudioStream(NO)` or `muteLocalVideoStream(NO)`.
 */
- (int)setClientRole:(AgoraClientRole)role;

/** Sets the role of the user in interactive live streaming.

 @since v3.2.0

 After calling [setChannelProfile(AgoraChannelProfileLiveBroadcasting)]([AgoraRtcEngineKit setChannelProfile:]),
 the SDK sets the user role as audience by default. You can call
 `setClientRole` to set the user role as host.

 You can call this method either before or after joining a channel.
 If you call this method to switch the user role after joining a channel,
 the SDK automatically does the following:

 - Calls [muteLocalAudioStream]([AgoraRtcEngineKit muteLocalAudioStream:]) and
 [muteLocalVideoStream]([AgoraRtcEngineKit muteLocalVideoStream:]) to change
 the publishing state.
 - Triggers [didClientRoleChanged]([AgoraRtcEngineDelegate rtcEngine:didClientRoleChanged:newRole:])
 on the local client.
 - Triggers [didJoinedOfUid]([AgoraRtcEngineDelegate rtcEngine:didJoinedOfUid:elapsed:])
 or [didOfflineOfUid(AgoraUserOfflineReasonBecomeAudience)]([AgoraRtcEngineDelegate rtcEngine:didOfflineOfUid:reason:])
 on the remote client.

 **Note**

 -This method applies to the `AgoraChannelProfileLiveBroadcasting` profile
 only (when the `profile` parameter in `setChannelProfile` is set as
 `AgoraChannelProfileLiveBroadcasting`).
 - The difference between this method and
 [setClientRole]([AgoraRtcEngineKit setClientRole:])1 is that this method can
 set the user level in addition to the user role.

   - The user role determines the permissions that the SDK grants to a user,
   such as permission to send local streams, receive remote
   streams, and push streams to a CDN address.
   - The user level determines the level of services that a user can enjoy
   within the permissions of the user's role. For example, an audience member
   can choose to receive remote streams with low latency or ultra low latency.
   **User level affects the pricing of services**.

 @param role The role of a user in interactive live streaming.
 See [AgoraClientRole](AgoraClientRole).
 @param options The detailed options of a user, including user level.
 See [AgoraClientRoleOptions](AgoraClientRoleOptions).

 @return - 0(`AgoraErrorCodeNoError`): Success.
 - < 0: Failure.

   - -1(`AgoraErrorCodeFailed`): A general error occurs (no specified reason).
   - -2(`AgoraErrorCodeInvalidArgument`): The parameter is invalid.
   - -7(`AgoraErrorCodeNotInitialized`): The SDK is not initialized.
   - -5 (`AgoraErrorCodeRefused`): The request is rejected. In multichannel
   scenarios, if you have set any of the following in one channel, the SDK
   returns this error code when the user switches the user role to host
   in another channel:

     - Call [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:options:])
     with the `options` parameter and use the default settings
     `publishLocalAudio = YES` or `publishLocalVideo = YES`.
     - Call `setClientRole` to set the user role as host.
     - Call `muteLocalAudioStream(NO)` or `muteLocalVideoStream(NO)`.
 */
- (int)setClientRole:(AgoraClientRole)role options:(AgoraClientRoleOptions* _Nullable)options;
/** Joins a channel with the user ID.

Users in the same channel can talk to each other, and multiple users in the same channel can start a group chat. Users with different App IDs cannot call each other even if they join the same channel.

You must call the [leaveChannel]([AgoraRtcEngineKit leaveChannel:]) method to exit the current call before entering another channel. This method call is asynchronous; therefore, you can call this method in the main user interface thread.

The SDK uses the iOS's AVAudioSession shared object for audio sampling and playback. Using this object may affect the SDK’s audio functions.

If the [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) method call succeeds, the SDK triggers`joinSuccessBlock`. If you implement both `joinSuccessBlock` and [didJoinChannel]([AgoraRtcEngineDelegate rtcEngine:didJoinChannel:withUid:elapsed:]), `joinSuccessBlock` takes higher priority than [didJoinChannel]([AgoraRtcEngineDelegate rtcEngine:didJoinChannel:withUid:elapsed:]).

We recommend you set `joinSuccessBlock` as nil to use [didJoinChannel]([AgoraRtcEngineDelegate rtcEngine:didJoinChannel:withUid:elapsed:]).

A successful joinChannel method call triggers the following callbacks:

- The local client: [didJoinChannel]([AgoraRtcEngineDelegate rtcEngine:didJoinChannel:withUid:elapsed:])
- The remote client: [didJoinedOfUid]([AgoraRtcEngineDelegate rtcEngine:didJoinedOfUid:elapsed:]), if the user joining the channel is in the Communication profile, or is a host in the Live Broadcast profile.

Once the user joins the channel, the user subscribes to the audio and video streams of all the other users in the channel by default, giving rise to usage and billing calculation. If you do not want to subscribe to a specified stream or all remote streams, call the `mute` methods accordingly.

When the connection between the client and Agora's server is interrupted due to poor network conditions, the SDK tries reconnecting to the server. When the local client successfully rejoins the channel, the SDK triggers the [didRejoinChannel]([AgoraRtcEngineDelegate rtcEngine:didRejoinChannel:withUid:elapsed:]) callback on the local client.

**Note:**

- A channel does not accept duplicate UIDs, such as two users with the same `uid`. If you set `uid` as 0, the system automatically assigns a `uid`. If you want to join the same channel on different devices, ensure that different uids are used for each device.
- When joining a channel, the SDK calls `setCategory(AVAudioSessionCategoryPlayAndRecord)` to set `AVAudioSession` to `PlayAndRecord` mode. When `AVAudioSession` is set to `PlayAndRecord` mode, the sound played (for example a ringtone) is interrupted. The app should not set `AVAudioSession` to any other mode.

 @param token The token generated at your server. See [Authenticate Your Users with Tokens](https://docs.agora.io/en/Interactive%20Broadcast/token_server?platform=All%20Platforms).
 @param channelId Unique channel name for the Agora RTC session in the string format. The string length must be less than 64 bytes.
 Supported character scopes are:

 * All lowercase English letters: a to z.
 * All uppercase English letters: A to Z.
 * All numeric characters: 0 to 9.
 * The space character.
 * Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ",".

@param info (Optional) Additional information about the channel. This parameter can be set to nil or contain channel related information. Other users in the channel do not receive this message.
@param uid User ID. A 32-bit unsigned integer with a value ranging from 1 to (2<sup>32</sup>-1). The `uid` must be unique. If a `uid` is not assigned (or set to 0), the SDK assigns and returns a `uid` in `joinSuccessBlock`. Your app must record and maintain the returned `uid` since the SDK does not do so.
@param joinSuccessBlock Occurs when the local user joins a specified channel.
If you implement both `joinSuccessBlock` and `didJoinChannel`, `joinSuccessBlock`
takes higher priority than `didJoinChannel`. Agora recommends setting `joinSuccessBlock` as `nil` to use `didJoinChannel`.

@return - `0`(`AgoraErrorCodeNoError`): Success.
- < `0`: Failure.

  - `-2`(`AgoraErrorCodeInvalidArgument`): The parameter is invalid.
  - `-3`(`AgoraErrorCodeNotReady`): The SDK fails to be initialized. You can try re-initializing the SDK.
  - `-5`(`AgoraErrorCodeRefused`): The request is rejected. This may be caused by the following:
  - `-7`(`AgoraErrorCodeNotInitialized`): The SDK is not initialized.

    - You have created an `AgoraRtcChannel` object with the same channel name.
    - You have joined and published a stream in a channel created by the `AgoraRtcChannel` object. When you join a channel created by `AgoraRtcEngineKit`, the SDK publishes the local audio and video streams to that channel by default. Because the SDK does not support publishing a local stream to more than one channel simultaneously, an error occurs in this occasion.

  - `-17`(`AgoraErrorCodeJoinChannelRejected`): The request to join the channel is rejected.
  The SDK supports joining only one AgoraRtcEngineKit channel at a time. Therefore, the SDK returns this error
  code when a user who has already joined an AgoraRtcEngineKit channel calls the joining channel method of the
  AgoraRtcEngineKit class with a valid channel name.
*/
- (int)joinChannelByToken:(NSString* _Nullable)token channelId:(NSString* _Nonnull)channelId info:(NSString* _Nullable)info uid:(NSUInteger)uid joinSuccess:(void (^_Nullable)(NSString* _Nonnull channel, NSUInteger uid, NSInteger elapsed))joinSuccessBlock;

/** Joins a channel with the user ID, and configures whether to publish or
 automatically subscribe to the audio or video streams.

 @since v3.3.0

 Users in the same channel can talk to each other, and multiple users in the
 same channel can start a group chat. Users with different App IDs cannot call
 each other.

 You must call the [leaveChannel]([AgoraRtcEngineKit leaveChannel:]) method to
 exit the current call before entering another channel.

 A successful `joinChannelByToken` method call triggers the following
 callbacks:

 - The local client: [didJoinChannel]([AgoraRtcEngineDelegate rtcEngine:didJoinChannel:withUid:elapsed:])
 - The remote client: [didJoinedOfUid]([AgoraRtcEngineDelegate rtcEngine:didJoinedOfUid:elapsed:]),
 if the user joining the channel is in the Communication profile, or is a
 host in the Live Broadcast profile.

 When the connection between the client and the Agora server is interrupted
 due to poor network conditions, the SDK tries reconnecting to the server.
 When the local client successfully rejoins the channel, the SDK triggers
 the [didRejoinChannel]([AgoraRtcEngineDelegate rtcEngine:didRejoinChannel:withUid:elapsed:])
 callback on the local client.

 **Note**

 - Compared with [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:])1,
 this method has the `options` parameter which configures whether the user publishes or
 automatically subscribes to the audio and video streams in the channel
 when joining the channel. By default, the user publishes the local audio and
 video streams and automatically subscribes to the audio and
 video streams of all the other users in the channel. Subscribing incurs all
 associated usage costs. To unsubscribe, set the `options` parameter or call
 the `mute` methods accordingly.
 - Ensure that the App ID used for generating the token is the same App ID used
 in the [sharedEngineWithAppId]([AgoraRtcEngineKit sharedEngineWithAppId:delegate:])
 method for generating an `AgoraRtcEngineKit` object.

 @param token The token generated at your server. For details, see [Generate a token](https://docs.agora.io/en/Interactive%20Broadcast/token_server?platform=All%20Platforms).
 @param channelId The unique channel name for the Agora RTC session in the string format. The string length must be less than 64 bytes.
 Supported character scopes are:

 * All lowercase English letters: a to z.
 * All uppercase English letters: A to Z.
 * All numeric characters: 0 to 9.
 * The space character.
 * Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ",".

 @param info (Optional) Additional information about the channel. This parameter can be set to nil or contain channel related information. Other users in the channel do not receive this message.
 @param uid (Optional) User ID. A 32-bit unsigned integer with a value ranging
 from 1 to (2<sup>32</sup>-1). The `uid` must be unique. If a `uid` is not
 assigned (or set to `0`), the SDK assigns and returns a `uid` in the
 `didJoinChannel` callback. Your application must record and maintain the
 returned `uid`, because the SDK does not do so.

 **Note**: The ID of each user in the channel should be unique. If you want to join
 the same channel from different devices, ensure that the user IDs in all
 devices are different.
 @param options The channel media options: AgoraRtcChannelMediaOptions.

 @return - `0`(`AgoraErrorCodeNoError`): Success.
 - < `0`: Failure.

   - `-2`(`AgoraErrorCodeInvalidArgument`): The parameter is invalid.
   - `-3`(`AgoraErrorCodeNotReady`): The SDK fails to be initialized. You can try re-initializing the SDK.
   - `-5`(`AgoraErrorCodeRefused`): The request is rejected. This may be caused by the following:

     - You have created an `AgoraRtcChannel` object with the same channel name.
     - You have joined and published a stream in a channel created by the `AgoraRtcChannel` object. When you join a channel created by `AgoraRtcEngineKit`, the SDK publishes the local audio and video streams to that channel by default. Because the SDK does not support publishing a local stream to more than one channel simultaneously, an error occurs in this occasion.

  - `-7`(`AgoraErrorCodeNotInitialized`): The SDK is not initialized before calling this method.
  - `-17`(`AgoraErrorCodeJoinChannelRejected`): The request to join the channel is rejected.
  The SDK supports joining only one AgoraRtcEngineKit channel at a time. Therefore, the SDK returns this error
  code when a user who has already joined an AgoraRtcEngineKit channel calls the joining channel method of the
  AgoraRtcEngineKit class with a valid channel name.
*/
- (int)joinChannelByToken:(NSString* _Nullable)token channelId:(NSString* _Nonnull)channelId info:(NSString* _Nullable)info uid:(NSUInteger)uid options:(AgoraRtcChannelMediaOptions* _Nonnull)options;

/** Joins the channel with a user account.

After the user successfully joins the channel, the SDK triggers the following callbacks:

- On the local client: [didRegisteredLocalUser]([AgoraRtcEngineDelegate rtcEngine:didRegisteredLocalUser:withUid:]) and [didJoinChannel]([AgoraRtcEngineDelegate rtcEngine:didJoinChannel:withUid:elapsed:]).
- On the remote client: [didJoinedOfUid]([AgoraRtcEngineDelegate rtcEngine:didJoinedOfUid:elapsed:]) and [didUpdatedUserInfo]([AgoraRtcEngineDelegate rtcEngine:didUpdatedUserInfo:withUid:]), if the user joining the channel is in the Communication profile, or is a host in the Live Broadcast profile.

Once the user joins the channel, the user subscribes to the audio and video streams of all the other users in the channel by default, giving rise to usage and billing calculation. If you do not want to subscribe to a specified stream or all remote streams, call the `mute` methods accordingly.

 **Note**

 - Before using a String user name, ensure that you read [How can I use string user names](https://docs.agora.io/en/faq/string) for getting details about the limitations and implementation steps.
 - To ensure smooth communication, use the same parameter type to identify the user. For example, if a user joins the channel with a user ID, then ensure all the other users use the user ID too. The same applies to the user account. If a user joins the channel with the Agora Web SDK, ensure that the uid of the user is set to the same parameter type.

@param userAccount The user account. The maximum length of this parameter is 255 bytes. Ensure that you set this parameter and do not set it as `nil`. Supported character scopes are:

- All lowercase English letters: a to z.
- All uppercase English letters: A to Z.
- All numeric characters: 0 to 9.
- The space character.
- Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ",".
@param token The token generated at your server. See [Authenticate Your Users with Tokens](https://docs.agora.io/en/Interactive%20Broadcast/token_server?platform=All%20Platforms).
@param channelId The channel name. The maximum length of this parameter is 64 bytes. Supported character scopes are:

- All lowercase English letters: a to z.
- All uppercase English letters: A to Z.
- All numeric characters: 0 to 9.
- The space character.
- Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ",".
@param joinSuccessBlock Occurs when the local user joins a specified channel.
If you implement both `joinSuccessBlock` and `didJoinChannel`, `joinSuccessBlock`
takes higher priority than `didJoinChannel`. Agora recommends setting `joinSuccessBlock` as `nil` to use `didJoinChannel`.

@return * 0: Success.
* < 0: Failure.

   - `AgoraErrorCodeInvalidArgument`(-2)
   - `AgoraErrorCodeNotReady`(-3)
   - `AgoraErrorCodeRefused`(-5)
   - `AgoraErrorCodeSDKNotInitialized`(-7)
   - `AgoraErrorCodeJoinChannelRejected`(-17): The request to join the channel is rejected.
  The SDK supports joining only one AgoraRtcEngineKit channel at a time. Therefore, the SDK returns this error
  code when a user who has already joined an AgoraRtcEngineKit channel calls the joining channel method of the
  AgoraRtcEngineKit class with a valid channel name.
*/
- (int)joinChannelByUserAccount:(NSString* _Nonnull)userAccount token:(NSString* _Nullable)token channelId:(NSString* _Nonnull)channelId joinSuccess:(void (^_Nullable)(NSString* _Nonnull channel, NSUInteger uid, NSInteger elapsed))joinSuccessBlock;

/** Joins the channel with a user account, and configures whether to
 automatically subscribe to audio or video streams after joining the channel.

 @since v3.3.0

 After the user successfully joins the channel, the SDK triggers the following
 callbacks:

 - On the local client: [didRegisteredLocalUser]([AgoraRtcEngineDelegate rtcEngine:didRegisteredLocalUser:withUid:])
 and [didJoinChannel]([AgoraRtcEngineDelegate rtcEngine:didJoinChannel:withUid:elapsed:]).
 - On the remote client: [didJoinedOfUid]([AgoraRtcEngineDelegate rtcEngine:didJoinedOfUid:elapsed:])
 and [didUpdatedUserInfo]([AgoraRtcEngineDelegate rtcEngine:didUpdatedUserInfo:withUid:]),
 if the user joining the channel is in the Communication profile, or is a host in the Live Broadcast profile.

 **Note**

 - Before using a String user name, ensure that you read
 [How can I use string user names](https://docs.agora.io/en/faq/string)
 for getting details about the limitations and implementation steps.
 - Compared with [joinChannelByUserAccount]([AgoraRtcEngineKit joinChannelByUserAccount:token:channelId:joinSuccess:])1,
 this method has the `options` parameter to configure whether the end user
 automatically subscribes to all remote audio and video streams in a channel
 when joining the channel. By default, the user subscribes to the audio and
 video streams of all the other users in the channel, thus incurring all
 associated usage costs. To unsubscribe, set the `options` parameter or call
 the `mute` methods accordingly.
 - To ensure smooth communication, use the same parameter type to identify the
 user. For example, if a user joins the channel with a user ID, then ensure
 all the other users use the user ID too. The same applies to the user
 account. If a user joins the channel with the Agora Web SDK, ensure that
 the user ID is set to the same parameter type.

 @param userAccount The user account. The maximum length of this parameter is 255 bytes. Ensure that the user account is unique and do not set it as `nil`. Supported character scopes are:

 - All lowercase English letters: a to z.
 - All uppercase English letters: A to Z.
 - All numeric characters: 0 to 9.
 - The space character.
 - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ",".
 @param token The token generated at your server. For details, see [Generate a token](https://docs.agora.io/en/Interactive%20Broadcast/token_server?platform=All%20Platforms).
 @param channelId The channel name. The maximum length of this parameter is 64 bytes. Supported character scopes are:

 - All lowercase English letters: a to z.
 - All uppercase English letters: A to Z.
 - All numeric characters: 0 to 9.
 - The space character.
 - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ",".
 @param options The channel media options: AgoraRtcChannelMediaOptions.

 @return * 0: Success.
 * < 0: Failure.

    - `AgoraErrorCodeInvalidArgument`(-2)
    - `AgoraErrorCodeNotReady`(-3)
    - `AgoraErrorCodeRefused`(-5)
    - `AgoraErrorCodeSDKNotInitialized`(-7)
    - `AgoraErrorCodeJoinChannelRejected`(-17): The request to join the channel is rejected.
  The SDK supports joining only one AgoraRtcEngineKit channel at a time. Therefore, the SDK returns this error
  code when a user who has already joined an AgoraRtcEngineKit channel calls the joining channel method of the
  AgoraRtcEngineKit class with a valid channel name.
*/
- (int)joinChannelByUserAccount:(NSString* _Nonnull)userAccount token:(NSString* _Nullable)token channelId:(NSString* _Nonnull)channelId options:(AgoraRtcChannelMediaOptions* _Nonnull)options;

/** Registers a user account.

Once registered, the user account can be used to identify the local user when the user joins the channel. After the user successfully registers a user account,  the SDK triggers the [didRegisteredLocalUser]([AgoraRtcEngineDelegate rtcEngine:didRegisteredLocalUser:withUid:]) callback on the local client, reporting the user ID and user account of the local user.

To join a channel with a user account, you can choose either of the following:

- Call the [registerLocalUserAccount]([AgoraRtcEngineKit registerLocalUserAccount:appId:]) method to create a user account, and then the [joinChannelByUserAccount]([AgoraRtcEngineKit joinChannelByUserAccount:token:channelId:joinSuccess:]) method to join the channel.
- Call the [joinChannelByUserAccount]([AgoraRtcEngineKit joinChannelByUserAccount:token:channelId:joinSuccess:]) method to join the channel.

The difference between the two is that for the former, the time elapsed between calling the [joinChannelByUserAccount]([AgoraRtcEngineKit joinChannelByUserAccount:token:channelId:joinSuccess:]) method and joining the channel is shorter than the latter.

**Note:**

- Ensure that you set the `userAccount` parameter. Otherwise, this method does not take effect.
- Ensure that the value of the `userAccount` parameter is unique in the channel.
- To ensure smooth communication, use the same parameter type to identify the user. For example, if a user joins the channel with a user ID, then ensure that all the other users use the user ID too. The same applies to the user account. If a user joins the channel with the Agora Web SDK, ensure that the `uid` of the user is set to the same parameter type.

@param userAccount The user account. The maximum length of this parameter is 255 bytes. Ensure that you set this parameter and do not set it as `nil`. Supported character scopes are:

- All lowercase English letters: a to z.
- All uppercase English letters: A to Z.
- All numeric characters: 0 to 9.
- The space character.
- Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ",".
@param appId The App ID of your project.

@return * 0: Success.
* < 0: Failure.
*/
- (int)registerLocalUserAccount:(NSString* _Nonnull)userAccount appId:(NSString* _Nonnull)appId;

/** Gets the user information by passing in the user account.

After a remote user joins the channel, the SDK gets the user ID and user account of the remote user, caches them in a mapping table object (`AgoraUserInfo`), and triggers the [didUpdatedUserInfo]([AgoraRtcEngineDelegate rtcEngine:didUpdatedUserInfo:withUid:]) callback on the local client.

After receiving the [didUpdatedUserInfo]([AgoraRtcEngineDelegate rtcEngine:didUpdatedUserInfo:withUid:]) callback, you can call this method to get the user ID of the remote user from the `userInfo` object by passing in the user account.

@param userAccount The user account of the user. Ensure that you set this parameter.
@param error The pointer to [AgoraErrorCode](AgoraErrorCode). It can be set as nil.

@return An [AgoraUserInfo](AgoraUserInfo) object that contains the user account and user ID of the user.
*/
- (AgoraUserInfo* _Nullable)getUserInfoByUserAccount:(NSString* _Nonnull)userAccount withError:(AgoraErrorCode* _Nullable)error;

/** Gets the user information by passing in the user ID.

After a user joins the channel, the SDK gets the user ID and user account of the remote user, caches them in a mapping table object (`AgoraUserInfo`), and triggers the [didUpdatedUserInfo]([AgoraRtcEngineDelegate rtcEngine:didUpdatedUserInfo:withUid:]) callback on the local client.

After receiving the [didUpdatedUserInfo]([AgoraRtcEngineDelegate rtcEngine:didUpdatedUserInfo:withUid:]) callback, you can call this method to get the user account of the user from the `userInfo` object by passing in the user ID.

@param uid The user ID of the user. Ensure that you set this parameter.
@param error The pointer to [AgoraErrorCode](AgoraErrorCode). It can be set as nil.

@return An [AgoraUserInfo](AgoraUserInfo) object that contains the user account and user ID of the user.
*/
- (AgoraUserInfo* _Nullable)getUserInfoByUid:(NSUInteger)uid withError:(AgoraErrorCode* _Nullable)error;

/** Switches to a different channel.

 This method allows the audience of the interactive live streaming channel to switch to a different channel.

 After the user successfully switches to another channel, the [didLeaveChannelWithStats]([AgoraRtcEngineDelegate rtcEngine:didLeaveChannelWithStats:]) and [didJoinChannel]([AgoraRtcEngineDelegate rtcEngine:didJoinChannel:withUid:elapsed:]) callbacks are triggered to indicate that the user has left the original channel and joined a new one.

 Once the user switches to another channel, the user subscribes to the audio and video streams of all the other users in the channel by default, giving rise to usage and billing calculation. If you do not want to subscribe to a specified stream or all remote streams, call the `mute` methods accordingly.

 @param token The token generated at your server. See [Authenticate Your Users with Tokens](https://docs.agora.io/en/Interactive%20Broadcast/token_server?platform=All%20Platforms).
 @param channelId Unique channel name for the Agora RTC session in the string format. The string length must be less than 64 bytes. Supported character scopes are:

 - All lowercase English letters: a to z.
 - All uppercase English letters: A to Z.
 - All numeric characters: 0 to 9.
 - The space character.
 - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ",".
 @param joinSuccessBlock Returns that the user joins the specified channel. Same as [didJoinChannel]([AgoraRtcEngineDelegate rtcEngine:didJoinChannel:withUid:elapsed:]). If `joinSuccessBlock` is nil, the SDK triggers the [didJoinChannel]([AgoraRtcEngineDelegate rtcEngine:didJoinChannel:withUid:elapsed:]) callback.

 @note This method applies to the audience role in the interactive live streaming channel only.

 @return - `0`(`AgoraErrorCodeNoError`): Success.
- < `0`: Failure.

  - `-1`(`AgoraErrorCodeFailed`): A general error occurs (no specified reason).
  - `-2`(`AgoraErrorCodeInvalidArgument`): The parameter is invalid.
  - `-5`(`AgoraErrorCodeRefused`): The request is rejected, probably because the user is not an audience.
  - `-7`(`AgoraErrorCodeNotInitialized`): The SDK is not initialized.
  - `-102`(`AgoraErrorCodeInvalidChannelId`): The channel ID is invalid.
  - `-113`(`AgoraErrorCodeNotInChannel`): The user is not in the channel.
 */
- (int)switchChannelByToken:(NSString* _Nullable)token channelId:(NSString* _Nonnull)channelId joinSuccess:(void (^_Nullable)(NSString* _Nonnull channel, NSUInteger uid, NSInteger elapsed))joinSuccessBlock;

/** Switches to a different channel, and configures whether to automatically
 subscribe to audio or video streams in the target channel.

 @since v3.3.0

 This method allows the audience of the interactive live streaming channel to
 switch to a different channel.

 After the user successfully switches to another channel, the
 [didLeaveChannelWithStats]([AgoraRtcEngineDelegate rtcEngine:didLeaveChannelWithStats:])
 and [didJoinChannel]([AgoraRtcEngineDelegate rtcEngine:didJoinChannel:withUid:elapsed:])
 callbacks are triggered to indicate that the user has left the original
 channel and joined a new one.

 **Note**

 - This method applies to the audience role in the interactive live streaming
 channel only.
 - The difference between this method and [switchChannelByToken]([AgoraRtcEngineKit switchChannelByToken:channelId:joinSuccess:])1
 is that the former adds the `options` parameter to configure whether the end
 user automatically subscribes to all remote audio and video streams in the
 target channel. By default, the user subscribes to the audio and video streams
 of all the other users in the target channel, thus incurring all associated
 usage costs. To unsubscribe, set the `options` parameter or call the `mute` methods accordingly.

 @param token The token generated at your server. For details, see [Generate a token](https://docs.agora.io/en/Interactive%20Broadcast/token_server?platform=All%20Platforms).
 @param channelId The unique channel name for the Agora RTC session in the string format. The string length must be less than 64 bytes. Supported character scopes are:

 - All lowercase English letters: a to z.
 - All uppercase English letters: A to Z.
 - All numeric characters: 0 to 9.
 - The space character.
 - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ",".
 @param options The channel media options: AgoraRtcChannelMediaOptions.

 @return - `0`(`AgoraErrorCodeNoError`): Success.
- < `0`: Failure.

  - `-1`(`AgoraErrorCodeFailed`): A general error occurs (no specified reason).
  - `-2`(`AgoraErrorCodeInvalidArgument`): The parameter is invalid.
  - `-5`(`AgoraErrorCodeRefused`): The request is rejected, probably because the user is not an audience.
  - `-7`(`AgoraErrorCodeNotInitialized`): The SDK is not initialized.
  - `-102`(`AgoraErrorCodeInvalidChannelId`): The channel ID is invalid.
  - `-113`(`AgoraErrorCodeNotInChannel`): The user is not in the channel.
 */
- (int)switchChannelByToken:(NSString* _Nullable)token channelId:(NSString* _Nonnull)channelId options:(AgoraRtcChannelMediaOptions* _Nonnull)options;

/** Allows a user to leave a channel, such as hanging up or exiting a call.

After joining a channel, the user must call the leaveChannel method to end the call before joining another channel.

This method returns 0 if the user leaves the channel and releases all resources related to the call.

This method call is asynchronous, and the user has not exited the channel when the method call returns.

A successful leaveChannel method call triggers the following callbacks:

- The local client: [didLeaveChannelWithStats]([AgoraRtcEngineDelegate rtcEngine:didLeaveChannelWithStats:])
- The remote client: [didOfflineOfUid(AgoraUserOfflineReasonBecomeAudience)]([AgoraRtcEngineDelegate rtcEngine:didOfflineOfUid:reason:]), if the user leaving the channel is in the Communication channel, or is a host in the Live Broadcast profile.

**Note:**

- If you call [destroy](destroy) immediately after leaveChannel, the leaveChannel process interrupts, and the SDK does not trigger the [didLeaveChannelWithStats]([AgoraRtcEngineDelegate rtcEngine:didLeaveChannelWithStats:]) callback.
- If you call this method during CDN live streaming, the SDK triggers the [removePublishStreamUrl](removePublishStreamUrl:) method.
- When you call this method, the SDK deactivates the audio session on iOS by default, and may affect other apps. If you do not want this default behavior, use [setAudioSessionOperationRestriction](setAudioSessionOperationRestriction:) to set `AgoraAudioSessionOperationRestrictionDeactivateSession` so that when you call the [leaveChannel]([AgoraRtcEngineKit leaveChannel:]) method, the SDK does not deactivate the audio session.

 @param leaveChannelBlock This callback indicates that a user leaves a channel, and provides the statistics of the call. See [AgoraChannelStats](AgoraChannelStats).

 @return - `0`(`AgoraErrorCodeNoError`): Success.
- < `0`: Failure.

  - `-1`(`AgoraErrorCodeFailed`): A general error occurs (no specified reason).
  - `-2`(`AgoraErrorCodeInvalidArgument`): The parameter is invalid.
  - `-7`(`AgoraErrorCodeNotInitialized`): The SDK is not initialized.
 */
- (int)leaveChannel:(void (^_Nullable)(AgoraChannelStats* _Nonnull stat))leaveChannelBlock;

/** Gets a new token when the current token expires after a period of time.

The `token` expires after a period of time once the token schema is enabled when:

  - The SDK triggers the [tokenPrivilegeWillExpire]([AgoraRtcEngineDelegate rtcEngine:tokenPrivilegeWillExpire:]) callback, or
  - [connectionChangedToState]([AgoraRtcEngineDelegate rtcEngine:connectionChangedToState:reason:]) reports AgoraConnectionChangedTokenExpired(9) in the`reason` parameter.

 **Note:**

 Agora recommends using the [rtcEngineRequestToken]([AgoraRtcEngineDelegate rtcEngineRequestToken:]) callback to report the AgoraErrorCodeTokenExpired(-109) error, not using the [didOccurError]([AgoraRtcEngineDelegate rtcEngine:didOccurError:]) callback.

 The app should call this method to get the `token`. Failure to do so results in the SDK disconnecting from the server.

 @param token The new token.

 @return - `0`(`AgoraErrorCodeNoError`): Success.
- < `0`: Failure.

  - `-1`(`AgoraErrorCodeFailed`): A general error occurs (no specified reason).
  - `-2`(`AgoraErrorCodeInvalidArgument`): The parameter is invalid.
  - `-7`(`AgoraErrorCodeNotInitialized`): The SDK is not initialized.
 */
- (int)renewToken:(NSString* _Nonnull)token;

/** Gets the connection state of the app.

 You can call this method either before or after joining a channel.

 @return The connection state, see [AgoraConnectionStateType](AgoraConnectionStateType).
*/
- (AgoraConnectionStateType)getConnectionState;

/** Starts to relay media streams across channels.

 After a successful method call, the SDK triggers the [channelMediaRelayStateDidChange]([AgoraRtcEngineDelegate rtcEngine:channelMediaRelayStateDidChange:error:]) and [didReceiveChannelMediaRelayEvent]([AgoraRtcEngineDelegate rtcEngine:didReceiveChannelMediaRelayEvent:]) callbacks, and these callbacks return the state and events of the media stream relay.

 - If the `channelMediaRelayStateDidChange` callback returns AgoraChannelMediaRelayStateRunning(2) and AgoraChannelMediaRelayStateIdle(0), and the `didReceiveChannelMediaRelayEvent` callback returns  AgoraChannelMediaRelayEventSentToDestinationChannel(4), the SDK starts relaying media streams between the original and the destination channel.
 - If the `channelMediaRelayStateDidChange` callback returns AgoraChannelMediaRelayStateFailure(3), an exception occurs during the media stream relay.

 **Note**

 - Call this method after the [joinChannel]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) method.
 - This method takes effect only when you are a host in the interactive live streaming channel.
 - After a successful method call, if you want to call this method again, ensure that you call the [stopChannelMediaRelay]([AgoraRtcEngineKit stopChannelMediaRelay]) method to quit the current relay.
 - Contact support@agora.io before implementing this function.
 - We do not support string user accounts in this API.

 @param config The configuration of the media stream relay: [AgoraChannelMediaRelayConfiguration](AgoraChannelMediaRelayConfiguration).

 @return - 0: Success.
 - < 0: Failure.
 */
- (int)startChannelMediaRelay:(AgoraChannelMediaRelayConfiguration* _Nonnull)config;

/** Updates the channels for media stream relay.

 After the channel media relay starts, if you want to relay the media stream to more channels, or leave the current relay channel, you can call the `updateChannelMediaRelay` method.

 After a successful method call, the SDK triggers the [didReceiveChannelMediaRelayEvent]([AgoraRtcEngineDelegate rtcEngine:didReceiveChannelMediaRelayEvent:]) callback with the AgoraChannelMediaRelayEventUpdateDestinationChannel(7) state code.

 **Note**

 - Call this method after successfully calling the
 [startChannelMediaRelay]([AgoraRtcEngineKit startChannelMediaRelay:]) method
 and receiving the [channelMediaRelayStateDidChange]([AgoraRtcChannelDelegate rtcChannel:channelMediaRelayStateDidChange:error:])
 `(AgoraChannelMediaRelayStateRunning, AgoraChannelMediaRelayErrorNone)` callback;
 otherwise, this method call fails.
 - This method supports adding at most four destination channels in the relay. If there are already four destination channels in the relay, remove the unnecessary ones with the `removeDestinationInfoForChannelName` method in channelMediaRelayConfiguration before calling this method.

 @param config The media stream relay configuration: [AgoraChannelMediaRelayConfiguration](AgoraChannelMediaRelayConfiguration).

 @return - 0: Success.
 - < 0: Failure.
 */
- (int)updateChannelMediaRelay:(AgoraChannelMediaRelayConfiguration* _Nonnull)config;

/** Pauses the media stream relay to all destination channels.

 @since v3.5.1

 After the cross-channel media stream relay starts, you can call this method to
 pause relaying media streams to all destination channels; after the pause,
 if you want to resume the relay, call
 [resumeAllChannelMediaRelay]([AgoraRtcEngineKit resumeAllChannelMediaRelay]).

 After a successful method call, the SDK triggers the
 [didReceiveChannelMediaRelayEvent]([AgoraRtcEngineDelegate rtcEngine:didReceiveChannelMediaRelayEvent:])
 callback to report whether the media stream relay is successfully paused.

 @note Call this method after the
 [startChannelMediaRelay]([AgoraRtcEngineKit startChannelMediaRelay:]) method.

 @return - 0: Success.
 - < 0: Failure.
 */
- (int)pauseAllChannelMediaRelay;

/** Resumes the media stream relay to all destination channels.

 @since v3.5.1

 After calling the [pauseAllChannelMediaRelay]([AgoraRtcEngineKit pauseAllChannelMediaRelay])
 method, you can call this method to resume relaying media streams to all
 destination channels.

 After a successful method call, the SDK triggers the
 [didReceiveChannelMediaRelayEvent]([AgoraRtcEngineDelegate rtcEngine:didReceiveChannelMediaRelayEvent:])
 callback to report whether the media stream relay is successfully resumed.

 @note Call this method after the `pauseAllChannelMediaRelay` method.

 @return - 0: Success.
 - < 0: Failure.
 */
- (int)resumeAllChannelMediaRelay;

/** Stops the media stream relay.

 Once the relay stops, the host quits all the destination channels.

 After a successful method call, the SDK triggers the [channelMediaRelayStateDidChange]([AgoraRtcEngineDelegate rtcEngine:channelMediaRelayStateDidChange:error:]) callback. If the callback returns  AgoraChannelMediaRelayStateIdle(0) and AgoraChannelMediaRelayErrorNone(0), the host successfully stops the relay.

 @note If the method call fails, the SDK triggers the [channelMediaRelayStateDidChange]([AgoraRtcEngineDelegate rtcEngine:channelMediaRelayStateDidChange:error:]) callback with the AgoraChannelMediaRelayErrorServerNoResponse(2) or AgoraChannelMediaRelayEventUpdateDestinationChannelRefused(8) state code. You can leave the channel by calling the [leaveChannel]([AgoraRtcEngineKit leaveChannel:]) method, and the media stream relay automatically stops.

 @return - 0: Success.
 - < 0: Failure.
 */
- (int)stopChannelMediaRelay;

/** Sets the Agora cloud proxy service.

 @since v3.3.0

 When the user's firewall restricts the IP address and port, refer to
 *Use Cloud Proxy* to add the specific IP addresses and ports to the firewall
 whitelist; then, call this method to enable the cloud proxy and set the cloud
 proxy type with the `proxyType` parameter as `AgoraUdpProxy(1)`, which is the
 cloud proxy for the UDP protocol.

 After a successfully cloud proxy connection, the SDK triggers the
 [connectionChangedToState(AgoraConnectionStateConnecting, AgoraConnectionChangedSettingProxyServer)]([AgoraRtcEngineDelegate rtcEngine:connectionChangedToState:reason:])
 callback.

 To disable the cloud proxy that has been set, call `setCloudProxy(AgoraNoneProxy)`.
 To change the cloud proxy type that has been set, call `setCloudProxy(AgoraNoneProxy)`
 first, and then call `setCloudProxy`, and pass the value that you expect in
 `proxyType`.

 **Note**

 - Agora recommends that you call this method before joining the channel or
 after leaving the channel.
 - For the SDK v3.3.x, the services for pushing streams to CDN and co-hosting
 across channels are not available when you use the cloud proxy for the UDP
 protocol. For the SDK v3.4.0 and later, the services for pushing streams to
 CDN and co-hosting across channels are not available when the user is in a
 network environment with a firewall and uses the cloud proxy for the UDP protocol.

 @param proxyType The cloud proxy type, see AgoraCloudProxyType. This
 parameter is required, and the SDK reports an error if you do not pass in a value.

 @return - 0: Success.
- < 0: Failure.

  - `-2(AgoraErrorCodeInvalidArgument)`: The parameter is invalid.
  - `-7(AgoraErrorCodeNotInitialized)`: The SDK is not initialized.
 */
- (int)setCloudProxy:(AgoraCloudProxyType)proxyType;

#pragma mark Core Audio

/**-----------------------------------------------------------------------------
 * @name Core Audio
 * -----------------------------------------------------------------------------
 */

/** Enables the audio module.

 The audio module is enabled by default.

 **Note:**

- This method affects the audio module and can be called after the [leaveChannel]([AgoraRtcEngineKit leaveChannel:]) method. You can call this method either before or after joining a channel.
- This method enables the audio module and takes some time to take effect. Agora recommends using the following API methods to control the audio engine modules separately:

    * [enableLocalAudio]([AgoraRtcEngineKit enableLocalAudio:]): Whether to enable the microphone to create the local audio stream.
    * [muteLocalAudioStream]([AgoraRtcEngineKit muteLocalAudioStream:]): Whether to publish the local audio stream.
    * [muteRemoteAudioStream]([AgoraRtcEngineKit muteRemoteAudioStream:mute:]): Whether to subscribe to and play the remote audio stream.
    * [muteAllRemoteAudioStreams]([AgoraRtcEngineKit muteAllRemoteAudioStreams:]): Whether to subscribe to and play all remote audio streams.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)enableAudio;

/** Disables the audio module.

 **Note:**

- This method affects the audio module and can be called after the [leaveChannel]([AgoraRtcEngineKit leaveChannel:]) method. You can call this method either before or after joining a channel.
- This method disables the audio module and takes some time to take effect. Agora recommends using the following API methods to control the audio engine modules separately:

    * [enableLocalAudio]([AgoraRtcEngineKit enableLocalAudio:]): Whether to enable the microphone to create the local audio stream.
    * [muteLocalAudioStream]([AgoraRtcEngineKit muteLocalAudioStream:]): Whether to publish the local audio stream.
    * [muteRemoteAudioStream]([AgoraRtcEngineKit muteRemoteAudioStream:mute:]): Whether to subscribe to and play the remote audio stream.
    * [muteAllRemoteAudioStreams]([AgoraRtcEngineKit muteAllRemoteAudioStreams:]): Whether to subscribe to and play all remote audio streams.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)disableAudio;

/** Sets the audio parameters and application scenarios.

 **Note:**

 * You must call this method before the [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) method.
 * In the Communication profile, you can set the `profile` but not the `scenario`.
 * In the Communication and interactive live streaming profiles, the bitrates may be different from your settings due to network self-adaptation.
 * In scenarios requiring high-quality audio, we recommend setting `profile` as `AgoraAudioProfileMusicHighQuality(4)` and `scenario` as `AgoraAudioScenarioGameStreaming(3)`. For example, for music education scenarios.

 @param profile  Sets the sample rate, bitrate, encoding mode, and the number of channels. See [AgoraAudioProfile](AgoraAudioProfile).
 @param scenario Sets the audio application scenario. See [AgoraAudioScenario](AgoraAudioScenario). Under different audio scenarios, the device uses different volume types. For details, see [What is the difference between the in-call volume and the media volume?](https://docs.agora.io/en/faq/system_volume).

 @return * 0: Success.
* < 0: Failure.
 */
- (int)setAudioProfile:(AgoraAudioProfile)profile scenario:(AgoraAudioScenario)scenario;

/** Adjusts the volume of the signal captured by the microphone.

 You can call this method either before or after joining a channel.

 @param volume The volume of the signal captured by the microphone. The value
 ranges between 0 and 400, including the following:

 - 0: Mute.
 - 100: (Default) Original volume.
 - 400: Four times the original volume with signal-clipping protection.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)adjustRecordingSignalVolume:(NSInteger)volume;

/** Adjusts the volume of the signal captured by the sound card. (macOS only)

 @since v3.4.0

 After calling [enableLoopbackRecording]([AgoraRtcEngineKit enableLoopbackRecording:deviceName:]) to enable loopback
 audio capturing, you can call this method to adjust the volume of the signal captured by the sound card.

 @param volume The volume of the signal captured by the sound card. The value
 ranges between 0 and 400, including the following:

 - 0: Mute.
 - 100: (Default) Original volume.
 - 400: Four times the original volume with signal-clipping protection.

 @return - 0: Success.
 - < 0: Failure.
 */
- (int)adjustLoopbackRecordingSignalVolume:(NSInteger)volume;

/** Adjusts the playback signal volume of all remote users.

 You can call this method either before or after joining a channel.

 **Note**

 - This method adjusts the playback volume which is mixed volume of all remote users.
 - Since v2.3.2, to mute the local audio playback, call both `adjustPlaybackSignalVolume` and [adjustAudioMixingVolume]([AgoraRtcEngineKit adjustAudioMixingVolume:]), and set `volume` as 0.

 @param volume The playback volume. The value
 ranges between 0 and 400, including the following:

 - 0: Mute.
 - 100: (Default) Original volume.
 - 400: Four times the original volume with signal-clipping protection.

 @return * 0: Success.
 * < 0: Failure.
 */
- (int)adjustPlaybackSignalVolume:(NSInteger)volume;

/** Enables the reporting of users' volume indication.

 This method enables the SDK to regularly report the volume information of the local user who sends a stream and remote users
 (up to three) whose instantaneous volumes are the highest to the app. Once you call this method and users send streams in
 the channel, the SDK triggers the
 [reportAudioVolumeIndicationOfSpeakers]([AgoraRtcEngineDelegate rtcEngine:reportAudioVolumeIndicationOfSpeakers:totalVolume:])
 callback at the time interval set in this method.

 You can call this method either before or after joining a channel.

 @param interval Sets the time interval between two consecutive volume indications:

 * &le; 0: Disables the volume indication.
 * &gt; 0: The time interval (ms) between two consecutive volume indications. Agora recommends setting `interval` &ge; 200 ms.

 @param smooth The smoothing factor sets the sensitivity of the audio volume indicator. The value ranges between 0 and 10. The greater the value, the more sensitive the indicator. The recommended value is 3.
 @param report_vad - YES: Enable the voice activity detection of the local user. Once it is enabled, the `vad` parameter of the [reportAudioVolumeIndicationOfSpeakers]([AgoraRtcEngineDelegate rtcEngine:reportAudioVolumeIndicationOfSpeakers:totalVolume:]) callback reports the voice activity status of the local user.
 - NO: (Default) Disable the voice activity detection of the local user. Once it is disabled, the `vad` parameter of the [reportAudioVolumeIndicationOfSpeakers]([AgoraRtcEngineDelegate rtcEngine:reportAudioVolumeIndicationOfSpeakers:totalVolume:]) callback does not report the voice activity status of the local user, except for the scenario where the engine automatically detects the voice activity of the local user.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)enableAudioVolumeIndication:(NSInteger)interval smooth:(NSInteger)smooth report_vad:(BOOL)report_vad;

/** Enables/Disables the local audio capture.

When an app joins a channel, the audio module is enabled by default. This method disables or re-enables the local audio capture, that is, to stop or restart local audio capturing and processing.

This method does not affect receiving the remote audio streams, and `enableLocalAudio(NO)` is applicable to scenarios where the user wants to receive remote audio streams without sending any audio stream to other users in the channel.

Once the local audio function is disabled or re-enabled, the SDK triggers the [localAudioStateChange]([AgoraRtcEngineDelegate rtcEngine:localAudioStateChange:error:]) callback, which reports `AgoraAudioLocalStateStopped(0)` or `AgoraAudioLocalStateRecording(1)`.

**Note:**

- This method can be called either before or after you join a channel. Calling
it before you join a channel can set the device state only, and it takes effect
immediately after you join the channel.
- This method is different from the [muteLocalAudioStream]([AgoraRtcEngineKit muteLocalAudioStream:]) method:

  - [enableLocalAudio]([AgoraRtcEngineKit enableLocalAudio:]): Disables/Re-enables the local audio capturing and processing. If you disable or re-enable local audio sampling using the `enableLocalAudio` method, the local user may hear a pause in the remote audio playback.
  - [muteLocalAudioStream]([AgoraRtcEngineKit muteLocalAudioStream:]): Sends/Stops sending the local audio stream.

 @param enabled * YES: (Default) Enable the local audio module, that is, to start local audio capturing and processing.
 * NO: Disable the local audio module, that is, to stop local audio capturing and processing.
 @return * 0: Success.
* < 0: Failure.
 */
- (int)enableLocalAudio:(BOOL)enabled;

/** Stops or resumes publishing the local audio stream.

 As of v3.4.5, this method only sets the publishing status of the audio stream
 in the channel of `AgoraRtcEngineKit`.

 A successful method call triggers the
 [didAudioMuted]([AgoraRtcEngineDelegate rtcEngine:didAudioMuted:byUid:])
 callback on the remote client.

 You can only publish the local stream in one channel at a time. If you create
 multiple channels, ensure that you only call `muteLocalAudioStream(NO)` in
 one channel; otherwise, the method call fails, and the SDK returns
 `-5 (AgoraErrorCodeRefused)`.

 **Note:**

 - This method does not change the usage status of the audio-capturing device.
 - Whether this method call takes effect is affected by the
 [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:options:])
 and [setClientRole]([AgoraRtcEngineKit setClientRole:]) methods. For details,
 see *Set the Publishing State*.

 @param mute Sets whether to stop publishing the local audio stream.

 * YES: Stop publishing the local audio stream.
 * NO: Resume publishing the local audio stream.

 @return * 0: Success.
* < 0: Failure.

 - `-5` (`AgoraErrorCodeRefused`): The request is rejected.
 */
- (int)muteLocalAudioStream:(BOOL)mute;

/** Stops or resumes subscribing to the audio stream of a specified user.

 **Note:**

 - Call this method after joining a channel.
 - See recommended settings in *Set the Subscribing State*.

 @param uid  The user ID of the specified remote user.
 @param mute Sets whether to stop subscribing to the audio stream of a
 specified user.

 * YES: Stop subscribing to the audio stream of a specified user.
 * NO: (Default) Resume subscribing to the audio stream of a specified user.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)muteRemoteAudioStream:(NSUInteger)uid mute:(BOOL)mute;

/** Stops or resumes subscribing to the audio streams of all remote users.

 After successfully calling this method, the local user stops or
 resumes subscribing to the audio streams of all remote users, including all
 subsequent users.

 **Note**

 - Call this method after joining a channel.
 - As of v3.3.0, this method contains the function of
 [setDefaultMuteAllRemoteAudioStreams]([AgoraRtcEngineKit setDefaultMuteAllRemoteAudioStreams:]).
 Agora recommends not calling `muteAllRemoteAudioStreams` and
 `setDefaultMuteAllRemoteAudioStreams` together; otherwise, the settings may
 not take effect. See *Set the Subscribing State*.

 @param mute Sets whether to stop subscribing to the audio streams of all
 remote users.

 * YES: Stop subscribing to the audio streams of all remote users.
 * NO: (Default) Resume subscribing to the audio streams of all remote users.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)muteAllRemoteAudioStreams:(BOOL)mute;

/** Adjust the playback signal volume of a specified remote user.

 **Since** v3.0.0.

 You can call this method as many times as necessary to adjust the playback volume of different remote users, or to repeatedly adjust the playback volume of the same remote user.

 **Note**

 - Call this method after joining a channel.
 - The playback volume here refers to the mixed volume of a specified remote user.
 - This method can only adjust the playback volume of one specified remote user at a time. To adjust the playback volume of different remote users, call the method as many times, once for each remote user.

 @param uid The ID of the remote user.
 @param volume The playback volume of the specified remote user. The value
 ranges between 0 and 400, including the following:

 - 0: Mute.
 - 100: (Default) Original volume.
 - 400: Four times the original volume with signal-clipping protection.

 @return - 0: Success.
 - < 0: Failure.
 */
- (int)adjustUserPlaybackSignalVolume:(NSUInteger)uid volume:(int)volume;

#pragma mark Core Video

/**-----------------------------------------------------------------------------
 * @name Core Video
 * -----------------------------------------------------------------------------
 */

/** Enables the video module.

You can call this method either before entering a channel or during a call. If you call this method before entering a channel, the service starts in the video mode. If you call this method during an audio call, the audio mode switches to the video mode.

A successful enableVideo method call triggers the [didVideoEnabled(YES)]([AgoraRtcEngineDelegate rtcEngine:didVideoEnabled:byUid:]) callback on the remote client.


To disable the video, call the disableVideo method.

**Note:**

- This method affects the internal engine and can be called after the [leaveChannel]([AgoraRtcEngineKit leaveChannel:]) method.
- This method resets the internal engine and takes some time to take effect. Agora recommends using the following API methods to control the video engine modules separately:

    * [enableLocalVideo]([AgoraRtcEngineKit enableLocalVideo:]): Whether to enable the camera to create the local video stream.
    * [muteLocalVideoStream]([AgoraRtcEngineKit muteLocalVideoStream:]): Whether to publish the local video stream.
    * [muteRemoteVideoStream]([AgoraRtcEngineKit muteRemoteVideoStream:mute:]): Whether to subscribe to and play the remote video stream.
    * [muteAllRemoteVideoStreams]([AgoraRtcEngineKit muteAllRemoteVideoStreams:]): Whether to subscribe to and play all remote video streams.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)enableVideo;

/** Disables the video module.

   You can call this method before entering a channel or during a call. If you call this method before entering a channel, the service starts in the audio mode. If you call this method during a video call, the video mode switches to the audio mode. To enable the video module, call the [enableVideo]([AgoraRtcEngineKit enableVideo]) method.

   A successful disableVideo method call triggers the [didVideoEnabled(NO)]([AgoraRtcEngineDelegate rtcEngine:didVideoEnabled:byUid:]) callback on the remote client.

 **Note:**

- This method affects the internal engine and can be called after the [leaveChannel]([AgoraRtcEngineKit leaveChannel:]) method.
- This method resets the internal engine and takes some time to take effect. Agora recommends using the following API methods to control the video engine modules separately:

    * [enableLocalVideo]([AgoraRtcEngineKit enableLocalVideo:]): Whether to enable the camera to create the local video stream.
    * [muteLocalVideoStream]([AgoraRtcEngineKit muteLocalVideoStream:]): Whether to publish the local video stream.
    * [muteRemoteVideoStream]([AgoraRtcEngineKit muteRemoteVideoStream:mute:]): Whether to subscribe to and play the remote video stream.
    * [muteAllRemoteVideoStreams]([AgoraRtcEngineKit muteAllRemoteVideoStreams:]): Whether to subscribe to and play all remote video streams.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)disableVideo;

/** Sets the video encoder configuration.

 Each video encoder configuration corresponds to a set of video parameters, including the resolution, frame rate, bitrate, and video orientation.

 The parameters specified in this method are the maximum values under ideal network conditions. If the video engine cannot render the video using the specified parameters due to unreliable network conditions, the parameters further down the list are considered until a successful configuration is found.

 If you do not need to set the video encoder configuration after joining a channel, you can call this method before calling the enableVideo method to reduce the render time of the first video frame.

 You can call this method either before or after joining a channel.

 **Note:**

 From v2.3.0, the following API methods are deprecated:

 - [setVideoProfile](setVideoProfile:swapWidthAndHeight:)
 - [setVideoResolution](setVideoResolution:andFrameRate:bitrate:)

 @param config Video encoder configuration: AgoraVideoEncoderConfiguration
 @return * 0: Success.
* < 0: Failure.
 */
- (int)setVideoEncoderConfiguration:(AgoraVideoEncoderConfiguration* _Nonnull)config;

/** Initializes the local video view.

 This method initializes the video view of the local stream on the local device. It affects only the video view that the local user sees, not the published local video stream.

 Call this method to bind the local video stream to a video view and to set the rendering and mirror modes of the video view. To unbind the `view`, set the `view` in AgoraRtcVideoCanvas to `nil`.

 You can call this method either before or after joining a channel.

 **Note**

 To update the rendering or mirror mode of the local video view during a call, use [setLocalRenderMode]([AgoraRtcEngineKit setLocalRenderMode:mirrorMode:]).

 @param local Sets the local video view and settings. See AgoraRtcVideoCanvas.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)setupLocalVideo:(AgoraRtcVideoCanvas* _Nullable)local;

/** Initializes the video view of a remote user.

 This method initializes the video view of a remote stream on the local device. It affects only the video view that the local user sees.

 Call this method to bind the remote video stream to a video view and to set the rendering and mirror modes of the video view.

 The app specifies the `uid` of the remote video in this method call before the user joins a channel.

 If the remote `uid` is unknown to the app, set it after the app receives the [userJoinedBlock]([AgoraRtcEngineKit userJoinedBlock:]) callback.

 If the Video Recording function is enabled, the Video Recording Service joins the channel as a dummy client, causing other clients to also receive the [didJoinedOfUid]([AgoraRtcEngineDelegate rtcEngine:didJoinedOfUid:elapsed:]) callback. Do not bind the dummy client to the app view because the dummy client does not send any video streams. If your app does not recognize the dummy client, bind the remote user to the view when the SDK triggers the [firstRemoteVideoDecodedOfUid]([AgoraRtcEngineDelegate rtcEngine:firstRemoteVideoDecodedOfUid:size:elapsed:]) callback.

 To unbind the remote user from the view, set the `view` in AgoraRtcVideoCanvas as nil. Once the remote user leaves the channel, the SDK unbinds the remote user.

 @note To update the rendering or mirror mode of the remote video view during a call, use [setRemoteRenderMode]([AgoraRtcEngineKit setRemoteRenderMode:renderMode:mirrorMode:]).

 @param remote Sets the remote video view and settings. See AgoraRtcVideoCanvas.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)setupRemoteVideo:(AgoraRtcVideoCanvas* _Nonnull)remote;

/** Updates the display mode of the local video view.

 **Since** v3.0.0.

 After initializing the local video view, you can call this method to update its rendering and mirror modes. It affects only the video view that the local user sees, not the published local video stream.

 **Note**

 - Ensure that you have called [setupLocalVideo]([AgoraRtcEngineKit setupLocalVideo:]) to initialize the local video view before calling this method.
 - During a call, you can call this method as many times as necessary to update the display mode of the local video view.

 @param renderMode The rendering mode of the local video view. See [AgoraVideoRenderMode](AgoraVideoRenderMode).
 @param mirrorMode The mirror mode of the local video view. See [AgoraVideoMirrorMode](AgoraVideoMirrorMode).

 **Note**

 If you use a front camera, the SDK enables the mirror mode by default; if you use a rear camera, the SDK disables the mirror mode by default.

 @return * 0: Success.
 * < 0: Failure.
 */
- (int)setLocalRenderMode:(AgoraVideoRenderMode)renderMode mirrorMode:(AgoraVideoMirrorMode)mirrorMode;

/** Updates the display mode of the video view of a remote user.

 **Since** v3.0.0.

 After initializing the video view of a remote user, you can call this method to update its rendering and mirror modes. This method affects only the video view that the local user sees.

 **Note**

 - Ensure that you have called [setupRemoteVideo]([AgoraRtcEngineKit setupRemoteVideo:]) to initialize the remote video view before calling this method.
 - During a call, you can call this method as many times as necessary to update the display mode of the video view of a remote user.

 @param uid The ID of the remote user.
 @param renderMode The rendering mode of the remote video view. See [AgoraVideoRenderMode](AgoraVideoRenderMode).
 @param mirrorMode The mirror mode of the remote video view. See [AgoraVideoMirrorMode](AgoraVideoMirrorMode).

 **Note**

 The SDK disables the mirror mode by default.

 @return * 0: Success.
 * < 0: Failure.
 */
- (int)setRemoteRenderMode:(NSUInteger)uid renderMode:(AgoraVideoRenderMode)renderMode mirrorMode:(AgoraVideoMirrorMode)mirrorMode;

/** Starts the local video preview before joining a channel.

By default, the local preview enables the mirror mode.

Before calling this method, you must:

 - Call the [setupLocalVideo]([AgoraRtcEngineKit setupLocalVideo:]) method to set up the local preview window and configure the attributes.
 - Call the [enableVideo]([AgoraRtcEngineKit enableVideo]) method to enable video.

**Note:**

 Once you call this method to start the local video preview, if you leave the channel by calling the [leaveChannel]([AgoraRtcEngineKit leaveChannel:]) method, the local video preview remains until you call the stopPreview method to disable it.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)startPreview;

/** Stops the local video preview.

 After calling [startPreview]([AgoraRtcEngineKit startPreview]), if you want to
 stop the local video preview, call `stopPreview`.

 @note Call this method before you join the channel or after you leave the channel.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)stopPreview;

/** Disables the local video.

 This method disables or re-enables the local video capturer, and does not affect receiving the remote video stream.

 After you call the [enableVideo]([AgoraRtcEngineKit enableVideo]) method, the local video capturer is enabled by default. You can call [enableLocalVideo(NO)]([AgoraRtcEngineKit enableLocalVideo:]) to disable the local video capturer. If you want to re-enable it, call [enableLocalVideo(YES)]([AgoraRtcEngineKit enableLocalVideo:]).

 After the local video capturer is successfully disabled or re-enabled, the SDK triggers the [remoteVideoStateChangedOfUid]([AgoraRtcEngineDelegate rtcEngine:remoteVideoStateChangedOfUid:state:reason:elapsed:]) callback on the remote client.

 You can call this method either before or after joining a channel.

 **Note:**

 This method enables the internal engine and can be called after calling the [leaveChannel]([AgoraRtcEngineKit leaveChannel:]) method.

 @param enabled Sets whether to enable/disable the local video, including the capturer, renderer, and sender:

 * YES: (Default) Enable the local video.
 * NO: Disable the local video. Once the local video is disabled, the remote users can no longer receive the video stream of this user, while this user can still receive the video streams of other remote users.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)enableLocalVideo:(BOOL)enabled;

/** Stops or resumes publishing the local video stream.

 As of v3.4.5, this method only sets the publishing state of the video stream
 in the channel of `AgoraRtcEngineKit`.

 A successful method call triggers the
 [didVideoMuted]([AgoraRtcEngineDelegate rtcEngine:didVideoMuted:byUid:])
 callback on the remote client.

 You can only publish the local stream in one channel at a time. If you create
 multiple channels, ensure that you only call `muteLocalVideoStream(NO)` in
 one channel; otherwise, the method call fails, and the SDK returns
 `-5 (AgoraErrorCodeRefused)`.

 **Note:**

 - This method does not change the usage state of the video-capturing device.
 - Whether this method call takes effect is affected by the
 [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:options:])
 and [setClientRole]([AgoraRtcEngineKit setClientRole:]) methods. For details,
 see *Set the Publishing State*.

 @param mute Sets whether to stop publishing the local video stream.

 * YES: Stop publishing the local video stream.
 * NO: Resume publishing the local video stream.

 @return * 0: Success.
* < 0: Failure.

  - `-5` (`AgoraErrorCodeRefused`): The request is rejected.
 */
- (int)muteLocalVideoStream:(BOOL)mute;

/** Stops or resumes subscribing to the video streams of all remote users.

 After successfully calling this method, the local user stops or
 resumes subscribing to the video streams of all remote users, including all
 subsequent users.

 **Note**

 - Call this method after joining a channel.
 - As of v3.3.0, this method contains the function of
 [setDefaultMuteAllRemoteAudioStreams]([AgoraRtcEngineKit setDefaultMuteAllRemoteAudioStreams:]).
 Agora recommends not calling `muteAllRemoteAudioStreams` and
 `setDefaultMuteAllRemoteAudioStreams` together; otherwise, the settings may
 not take effect. See *Set the Subscribing State*.

 @param mute Sets whether to stop subscribing to the video streams of all
 remote users.

 * YES: Stop subscribing to the video streams of all remote users.
 * NO: (Default) Resume subscribing to the video streams of all remote users.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)muteAllRemoteVideoStreams:(BOOL)mute;

/** Stops or resumes subscribing to the video stream of a specified user.

 **Note:**

 - Call this method after joining a channel.
 - See recommended settings in *Set the Subscribing State*.

 @param uid  The user ID of the specified remote user.
 @param mute Sets whether to stop subscribing to the video stream of a
 specified user.

 * YES: Stop subscribing to the video stream of a specified user.
 * NO: (Default) Resume subscribing to the video stream of a specified user.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)muteRemoteVideoStream:(NSUInteger)uid mute:(BOOL)mute;

#pragma mark Video Pre-Process and Post-Process
/**-----------------------------------------------------------------------------
 * @name Video Pre-Process and Post-Process
 * -----------------------------------------------------------------------------
 */

/** Enables/Disables image enhancement and sets the options.

@note Call this method after calling the [enableVideo]([AgoraRtcEngineKit enableVideo]) method.

@param enable Sets whether to enable image enhancement:

- `YES`: Enable image enhancement.
- `NO`: Disable image enhancement.
@param options The image enhancement options, see AgoraBeautyOptions.

@return * 0: Success.
* < 0: Failure.
*/
- (int)setBeautyEffectOptions:(BOOL)enable options:(AgoraBeautyOptions* _Nullable)options;

/** Enables/Disables the virtual background. (beta feature)

 @since Support for macOS as of v3.4.5 and iOS as of v3.5.0.

 After enabling the virtual background feature, you can replace the original
 background image of the local user with a custom background image. After the
 replacement, all users in the channel can see the custom background image. You
 can find out from the [virtualBackgroundSourceEnabled]([AgoraRtcEngineDelegate rtcEngine:virtualBackgroundSourceEnabled:reason:])
 callback whether the virtual background is successfully enabled or the cause
 of any errors.

 **Note**:

 - Before calling this method, ensure that you have integrated the
 `AgoraVideoSegmentationExtension.framework` (macOS) or
 `AgoraVideoSegmentationExtension.xcframework`(iOS) dynamic library into
 the project folder.
 - Call this method after [enableVideo]([AgoraRtcEngineKit enableVideo]).
 - The virtual background feature does not support video in the Texture
 format or video obtained from custom video capture by the Push method.
 - This feature requires a high-performance device. Agora recommends that
 you use this feature on the following devices:

    - macOS: Devices with an i5 CPU and better
    - iOS: Devices with an A9 chip and better, as follows:

      - iPhone 6S and later
      - iPad Air (3rd generation) and later
      - iPad (5th generation) and later
      - iPad Pro (1st generation) and later
      - iPad mini (5th generation) and later

 @param enable Sets whether to enable the virtual background:

 - `YES`: Enable.
 - `NO`: Disable.
 @param backData The custom background image. See AgoraVirtualBackgroundSource.
 <p><b>Note</b>: To adapt the resolution of the custom background image to the
 resolution of the SDK capturing video, the SDK scales and crops the custom
 background image while ensuring that the content of the custom background
 image is not distorted.</p>

 @return * 0: Success.
* < 0: Failure.
 */
- (int)enableVirtualBackground:(BOOL)enable backData:(AgoraVirtualBackgroundSource* _Nullable)backData;

#if defined(TARGET_OS_IPHONE) && TARGET_OS_IPHONE
/** Enables/Disables the super resolution feature for a remote user's video. (beta feature)

 @since v3.5.1

 This feature effectively boosts the resolution of a remote user's video seen
 by the local user. If the original resolution of a remote user's video is a × b,
 the local user's device can render the remote video at a resolution of 2a × 2b
 after you enable this feature.

 After calling this method, the SDK triggers the
 [superResolutionEnabledOfUid]([AgoraRtcEngineDelegate rtcEngine:superResolutionEnabledOfUid:enabled:reason:])
 callback to report whether you have successfully enabled super resolution.

 **Warnings**

 The super resolution feature requires extra system resources. To balance the
 visual experience and system consumption, the SDK poses the following restrictions:

 - This feature can only be enabled for a single remote user.
 - The original resolution of the remote user's video cannot exceed 640 × 480 pixels.

 If you exceed these limitations, the SDK triggers the
 [didOccurWarning]([AgoraRtcEngineDelegate rtcEngine:didOccurWarning:])
 callback and returns the corresponding warning codes:

 - `AgoraWarningCodeSuperResolutionStreamOverLimitation(1610)`:
 The original resolution of the remote user's video is beyond the range where
 super resolution can be applied.
 - `AgoraWarningCodeSuperResolutionUserCountOverLimitation(1611)`: Super
 resolution is already being used to boost another remote user's video.
 - `AgoraWarningCodeSuperResolutionDeviceNotSupported(1612)`: The device does
 not support using super resolution.

 **Notes**

 - This method is for iOS only.
 - Before calling this method, ensure that you have integrated the
 `AgoraSuperResolutionExtension.xcframework` dynamic library into your project.
 - Because this method has certain system performance requirements, Agora
 recommends that you use the following iOS devices (iOS 12.0 or later) or better:

   - iPhone XR
   - iPhone XS
   - iPhone XS Max
   - iPhone 11
   - iPhone 11 Pro
   - iPhone 11 Pro Max
   - iPhone 12
   - iPhone 12 mini
   - iPhone 12 Pro
   - iPhone 12 Pro Max
   - iPhone 12 SE (2nd generation)
   - iPad Pro 11-inch (3rd generation)
   - iPad Pro 12.9-inch (3rd generation)
   - iPad Air (3rd generation)
   - iPad Air (4th generation)

 @param uid The user ID of the remote user.
 @param enabled Determines whether to enable super resolution for the remote user's video:

   - `YES`: Enable super-resolution.
   - `NO`: Do not enable super resolution.

 @return - 0: Success.
 - < 0: Failure.

   - -157(`AgoraErrorCodeModuleNotFound`): The dynamic library for super resolution is not integrated.
 */
- (int)enableRemoteSuperResolution:(NSUInteger)uid enabled:(BOOL)enabled;
#endif

/**-----------------------------------------------------------------------------
 * @name Face Detection
 * -----------------------------------------------------------------------------
 */

/** Enables/Disables face detection for the local user. (iOS only)

 **Since:** v3.0.1.

 Once face detection is enabled, the SDK triggers the [facePositionDidChangeWidth]([AgoraRtcEngineDelegate rtcEngine:facePositionDidChangeWidth:previewHeight:faces:]) callback to report the face information of the local user, which includes the following aspects:

 - The width and height of the local video.
 - The position of the human face in the local video.
 - The distance between the human face and the device screen.

 You can call this method either before or after joining a channel.

 @param enable Determines whether to enable the face detection function for the local user:

 - YES: Enable face detection.
 - NO: Disable face detection.

 @return - 0: Success.
 - < 0: Failure.
 */
- (int)enableFaceDetection:(bool)enable;

#pragma mark Audio Routing Controller

/**-----------------------------------------------------------------------------
 * @name Audio Routing Controller
 * -----------------------------------------------------------------------------
 */

#if defined(TARGET_OS_IPHONE) && TARGET_OS_IPHONE
/** Sets the default audio route.

 If the default audio route of the SDK (see *Set the Audio Route*) cannot meet
 your requirements, you can call this method to switch the default audio route.
 After successfully switching the audio route, the SDK triggers the
 [didAudioRouteChanged]([AgoraRtcEngineDelegate rtcEngine:didAudioRouteChanged:])
 callback to indicate the changes.

 **Note**

 - This method applies to iOS only.
 - Call this method before calling
 [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:options:]).
 If you need to switch the audio route after joining a channel, call
 [setEnableSpeakerphone]([AgoraRtcEngineKit setEnableSpeakerphone:]).
 - If the user uses an external audio playback device such as a Bluetooth or
 wired headset, this method does not take effect, and the SDK plays audio
 through the external device. When the user uses multiple external devices,
 the SDK plays audio through the last connected device.

 @param defaultToSpeaker Sets the default audio route as follows:

   - `YES`: Set to the speakerphone.
   - `NO`: Set to the earpiece.

 @return - 0: Success.
 - < 0: Failure.
 */
- (int)setDefaultAudioRouteToSpeakerphone:(BOOL)defaultToSpeaker;

/** Enables/Disables the audio route to the speakerphone.

 If the default audio route of the SDK (see *Set the Audio Route*) or the
 setting in
 [setDefaultAudioRouteToSpeakerphone]([AgoraRtcEngineKit setDefaultAudioRouteToSpeakerphone:])
 cannot meet your requirements, you can call this method to switch the current
 audio route. After successfully switching the audio route, the SDK triggers
 the
 [didAudioRouteChanged]([AgoraRtcEngineDelegate rtcEngine:didAudioRouteChanged:])
 callback to indicate the changes.

 This method only sets the audio route in the current channel and does not
 influence the default audio route. If the user leaves the current channel and
 joins another channel, the default audio route is used.

 **Notes**

 - This method applies to iOS only.
 - Call this method after calling
 [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:options:]).
 - If the user uses an external audio playback device such as a Bluetooth or
 wired headset, this method does not take effect, and the SDK plays audio
 through the external device. When the user uses multiple external devices,
 the SDK plays audio through the last connected device.

 @param enableSpeaker Sets whether to enable the speakerphone or earpiece:

  - `YES`: Enable the speakerphone. The audio route is the speakerphone.
  - `NO`: Disable the speakerphone. The audio route is the earpiece.

 @return * 0: Success.
 * < 0: Failure.
 */
- (int)setEnableSpeakerphone:(BOOL)enableSpeaker;

/** Checks whether the speakerphone is enabled. (iOS only.)

 You can call this method either before or after joining a channel.

 @return * YES: The speakerphone is enabled, and the audio plays from the speakerphone.
 * NO: The speakerphone is not enabled, and the audio plays from devices other than the speakerphone. For example, the headset or earpiece.
 */
- (BOOL)isSpeakerphoneEnabled;
#endif

#pragma mark In Ear Monitor

/**-----------------------------------------------------------------------------
 * @name In-ear Monitor
 * -----------------------------------------------------------------------------
 */

#if defined(TARGET_OS_IPHONE) && TARGET_OS_IPHONE

/** Enables in-ear monitoring. (iOS only.)

 You can call this method either before or after joining a channel.

 @note Users must use wired earphones to hear their own voices.

 @param enabled Sets whether to enable/disable in-ear monitoring.

 * YES: Enable.
 * NO: (Default) Disable.

 @return * 0: Success.
* < 0: Failure.
  */
- (int)enableInEarMonitoring:(BOOL)enabled;

/** Sets the volume of the in-ear monitor. (iOS only.)

 You can call this method either before or after joining a channel.

 @note Users must use wired earphones to hear their own voices.

 @param volume Sets the volume of the in-ear monitor. The value ranges between 0 and 100 (default).

 @return * 0: Success.
* < 0: Failure.
 */
- (int)setInEarMonitoringVolume:(NSInteger)volume;
#endif

#pragma mark Audio Sound Effect

/**-----------------------------------------------------------------------------
 * @name Set the Voice Effect
 * -----------------------------------------------------------------------------
 */

/** Changes the voice pitch of the local speaker.

 You can call this method either before or after joining a channel.

 @param pitch Sets the voice pitch. The value ranges between 0.5 and 2.0. The lower the value, the lower the voice pitch. The default value is 1.0 (no change to the local voice pitch).

 @return * 0: Success.
* < 0: Failure.
 */
- (int)setLocalVoicePitch:(double)pitch;

/** Sets the local voice equalization effect.

 You can call this method either before or after joining a channel.

 @param bandFrequency Sets the band frequency. The value ranges between 0 and 9, representing the respective 10-band center frequencies of the voice effects, including 31, 62, 125, 250, 500, 1k, 2k, 4k, 8k, and 16k Hz. See AgoraAudioEqualizationBandFrequency.
 @param gain          Sets the gain of each band (dB). The value ranges between -15 and 15. The default value is 0.

 @return * 0: Success.
* < 0: Failure.
*/
- (int)setLocalVoiceEqualizationOfBandFrequency:(AgoraAudioEqualizationBandFrequency)bandFrequency withGain:(NSInteger)gain;

/** Sets the local voice reverberation.

 As of v3.2.0, the SDK provides a more convenient method [setAudioEffectPreset]([AgoraRtcEngineKit setAudioEffectPreset:]),
 which directly implements the popular music, R&B music, KTV and other preset reverb effects.

 You can call this method either before or after joining a channel.

 @param reverbType Sets the reverberation type. See AgoraAudioReverbType.
 @param value      Sets the effect of the reverberation type. See AgoraAudioReverbType for the value range.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)setLocalVoiceReverbOfType:(AgoraAudioReverbType)reverbType withValue:(NSInteger)value;

/** Sets an SDK preset voice beautifier effect.

 @since v3.2.0

 Call this method to set an SDK preset voice beautifier effect for the local user who sends an audio stream. After setting a voice
 beautifier effect, all users in the channel can hear the effect.

 You can set different voice beautifier effects for different scenarios. See *Set the Voice Effect*.

 To achieve better audio effect quality, Agora recommends calling [setAudioProfile]([AgoraRtcEngineKit setAudioProfile:scenario:]) and
 setting the `scenario` parameter to `AgoraAudioScenarioGameStreaming(3)` and the `profile` parameter to
 `AgoraAudioProfileMusicHighQuality(4)` or `AgoraAudioProfileMusicHighQualityStereo(5)` before calling this method.

 **Note**

 - You can call this method either before or after joining a channel.
 - Do not set the `profile` parameter of `setAudioProfile` to `AgoraAudioProfileSpeechStandard(1)`; otherwise, this method call does not take effect.
 - This method works best with the human voice. Agora does not recommend using this method for audio containing music.
 - After calling this method, Agora recommends not calling the following methods, because they can override `setVoiceBeautifierPreset`:

   - [setAudioEffectPreset]([AgoraRtcEngineKit setAudioEffectPreset:])
   - [setAudioEffectParameters]([AgoraRtcEngineKit setAudioEffectParameters:param1:param2:])
   - [setVoiceBeautifierParameters]([AgoraRtcEngineKit setVoiceBeautifierParameters:param1:param2:])
   - [setVoiceConversionPreset]([AgoraRtcEngineKit setVoiceConversionPreset:])
   - [setLocalVoiceReverbPreset]([AgoraRtcEngineKit setLocalVoiceReverbPreset:])
   - [setLocalVoiceChanger]([AgoraRtcEngineKit setLocalVoiceChanger:])
   - [setLocalVoicePitch]([AgoraRtcEngineKit setLocalVoicePitch:])
   - [setLocalVoiceEqualizationOfBandFrequency]([AgoraRtcEngineKit setLocalVoiceEqualizationOfBandFrequency:withGain:])
   - [setLocalVoiceReverbOfType]([AgoraRtcEngineKit  setLocalVoiceReverbOfType:withValue:])

 @param preset The options for SDK preset voice beautifier effects: [AgoraVoiceBeautifierPreset](AgoraVoiceBeautifierPreset).

 @return - 0: Success.
- < 0: Failure.
 */
- (int)setVoiceBeautifierPreset:(AgoraVoiceBeautifierPreset)preset;

/** Sets parameters for SDK preset voice beautifier effects.

 @since v3.3.0

 Call this method to set a gender characteristic and a reverberation effect
 for the singing beautifier effect. This method sets parameters for the local
 user who sends an audio stream.

 After you call this method successfully, all users in the channel can hear
 the relevant effect.

 To achieve better audio effect quality, before you call this method, Agora
 recommends calling [setAudioProfile]([AgoraRtcEngineKit setAudioProfile:scenario:]), and
 setting the `scenario` parameter to `AgoraAudioScenarioGameStreaming(3)` and
 the `profile` parameter to `AgoraAudioProfileMusicHighQuality(4)` or
 `AgoraAudioProfileMusicHighQualityStereo(5)`.

 **Note**

 - You can call this method either before or after joining a channel.
 - Do not set the `profile` parameter of `setAudioProfile` to
 `AgoraAudioProfileSpeechStandard(1)`; otherwise, this method call does not
 take effect.
 - This method works best with the human voice. Agora does not recommend using
 this method for audio containing music.
 - After calling this method, Agora recommends not calling the following
 methods, because they can override `setVoiceBeautifierParameters`:

   - [setAudioEffectPreset]([AgoraRtcEngineKit setAudioEffectPreset:])
   - [setAudioEffectParameters]([AgoraRtcEngineKit setAudioEffectParameters:param1:param2:])
   - [setVoiceBeautifierPreset]([AgoraRtcEngineKit setVoiceBeautifierPreset:])
   - [setVoiceConversionPreset]([AgoraRtcEngineKit setVoiceConversionPreset:])
   - [setLocalVoiceReverbPreset]([AgoraRtcEngineKit setLocalVoiceReverbPreset:])
   - [setLocalVoiceChanger]([AgoraRtcEngineKit setLocalVoiceChanger:])
   - [setLocalVoicePitch]([AgoraRtcEngineKit setLocalVoicePitch:])
   - [setLocalVoiceEqualizationOfBandFrequency]([AgoraRtcEngineKit setLocalVoiceEqualizationOfBandFrequency:withGain:])
   - [setLocalVoiceReverbOfType]([AgoraRtcEngineKit  setLocalVoiceReverbOfType:withValue:])

 @param preset The options for SDK preset voice beautifier effects:

 - `AgoraSingingBeautifier`: Singing beautifier effect.
 @param param1 The gender characteristics options for the singing voice:

 - `1`: A male-sounding voice.
 - `2`: A female-sounding voice.
 @param param2 The reverberation effects options:

 - `1`: The reverberation effect sounds like singing in a small room.
 - `2`: The reverberation effect sounds like singing in a large room.
 - `3`: The reverberation effect sounds like singing in a hall.

 @return - 0: Success.
- < 0: Failure.
 */
- (int)setVoiceBeautifierParameters:(AgoraVoiceBeautifierPreset)preset param1:(int)param1 param2:(int)param2;

/** Sets an SDK preset audio effect.

 @since v3.2.0

 Call this method to set an SDK preset audio effect for the local user who sends an audio stream. This audio effect does not change the
 gender characteristics of the original voice. After setting an audio effect, all users in the channel can hear the effect.

 You can set different audio effects for different scenarios. See *Set the Voice Effect*.

 To achieve better audio effect quality, Agora recommends calling [setAudioProfile]([AgoraRtcEngineKit setAudioProfile:scenario:])
 and setting the `scenario` parameter to `AgoraAudioScenarioGameStreaming(3)` before calling this method.

 **Note**:

 - You can call this method either before or after joining a channel.
 - Do not set the `profile` parameter of `setAudioProfile` to `AgoraAudioProfileSpeechStandard(1)`; otherwise, this method call does not take effect.
 - This method works best with the human voice. Agora does not recommend using this method for audio containing music.
 - If you call this method and set the preset parameter to enumerators except `AgoraRoomAcoustics3DVoice` or `AgoraPitchCorrection`,
 do not call [setAudioEffectParameters]([AgoraRtcEngineKit setAudioEffectParameters:param1:param2:]); otherwise,
 `setAudioEffectParameters` overrides this method.
 - After calling this method, Agora recommends not calling the following methods, because they can override `setAudioEffectPreset`:

   - [setVoiceBeautifierPreset]([AgoraRtcEngineKit setVoiceBeautifierPreset:])
   - [setVoiceBeautifierParameters]([AgoraRtcEngineKit setVoiceBeautifierParameters:param1:param2:])
   - [setVoiceConversionPreset]([AgoraRtcEngineKit setVoiceConversionPreset:])
   - [setLocalVoiceReverbPreset]([AgoraRtcEngineKit setLocalVoiceReverbPreset:])
   - [setLocalVoiceChanger]([AgoraRtcEngineKit setLocalVoiceChanger:])
   - [setLocalVoicePitch]([AgoraRtcEngineKit setLocalVoicePitch:])
   - [setLocalVoiceEqualizationOfBandFrequency]([AgoraRtcEngineKit setLocalVoiceEqualizationOfBandFrequency:withGain:])
   - [setLocalVoiceReverbOfType]([AgoraRtcEngineKit  setLocalVoiceReverbOfType:withValue:])

 @param preset The options for SDK preset audio effects: [AgoraAudioEffectPreset](AgoraAudioEffectPreset).

 @return - 0: Success.
- < 0: Failure.
 */
- (int)setAudioEffectPreset:(AgoraAudioEffectPreset)preset;
/** Sets an SDK preset voice conversion effect.

 @since v3.3.1

 Call this method to set an SDK preset voice conversion effect for the local user who sends an audio stream.
 After setting a voice conversion effect, all users in the channel can hear the effect.

 You can set different voice conversion effects for different scenarios. See *Set the Voice Effect*.

 To achieve better voice effect quality, Agora recommends calling [setAudioProfile]([AgoraRtcEngineKit setAudioProfile:scenario:])
 and setting the `profile` parameter to `AgoraAudioProfileMusicHighQuality(4)` or `AgoraAudioProfileMusicHighQualityStereo(5)` and
 the `scenario` parameter to `AgoraAudioScenarioGameStreaming(3)` before calling this method.

 **Note**:

 - You can call this method either before or after joining a channel.
 - Do not set the `profile` parameter of `setAudioProfile` to `AgoraAudioProfileSpeechStandard(1)`; otherwise, this method call does not take effect.
 - This method works best with the human voice. Agora does not recommend using this method for audio containing music.
 - After calling this method, Agora recommends not calling the following methods, because they can override `setVoiceConversionPreset`:

   - [setAudioEffectPreset]([AgoraRtcEngineKit setAudioEffectPreset:])
   - [setAudioEffectParameters]([AgoraRtcEngineKit setAudioEffectParameters:param1:param2:])
   - [setVoiceBeautifierPreset]([AgoraRtcEngineKit setVoiceBeautifierPreset:])
   - [setVoiceBeautifierParameters]([AgoraRtcEngineKit setVoiceBeautifierParameters:param1:param2:])
   - [setLocalVoiceReverbPreset]([AgoraRtcEngineKit setLocalVoiceReverbPreset:])
   - [setLocalVoiceChanger]([AgoraRtcEngineKit setLocalVoiceChanger:])
   - [setLocalVoicePitch]([AgoraRtcEngineKit setLocalVoicePitch:])
   - [setLocalVoiceEqualizationOfBandFrequency]([AgoraRtcEngineKit setLocalVoiceEqualizationOfBandFrequency:withGain:])
   - [setLocalVoiceReverbOfType]([AgoraRtcEngineKit  setLocalVoiceReverbOfType:withValue:])

 @param preset The options for SDK preset voice conversion effects: [AgoraVoiceConversionPreset](AgoraVoiceConversionPreset).

 @return - 0: Success.
- < 0: Failure.
 */
- (int)setVoiceConversionPreset:(AgoraVoiceConversionPreset)preset;

/** Sets parameters for SDK preset audio effects.

 @since v3.2.0

 Call this method to set the following parameters for the local user who sends an audio stream:

 - 3D voice effect: Sets the cycle period of the 3D voice effect.
 - Pitch correction effect: Sets the basic mode and tonic pitch of the pitch correction effect. Different songs have different modes and
 tonic pitches. Agora recommends bounding this method with interface elements to enable users to adjust the pitch correction interactively.

 After setting parameters, all users in the channel can hear the relevant effect.

 **Note**:

 - You can call this method either before or after joining a channel.
 - To achieve better audio effect quality, Agora recommends calling [setAudioProfile]([AgoraRtcEngineKit setAudioProfile:scenario:]) and
 setting the scenario parameter to `AgoraAudioScenarioGameStreaming(3)` before calling this method.
 - Do not set the `profile` parameter of `setAudioProfile` to `AgoraAudioProfileSpeechStandard(1)`; otherwise, this method call does not take effect.
 - This method works best with the human voice. Agora does not recommend using this method for audio containing music.
 - After calling this method, Agora recommends not calling the following methods, because they can override `setAudioEffectParameters`:

   - [setAudioEffectPreset]([AgoraRtcEngineKit setAudioEffectPreset:])
   - [setVoiceBeautifierPreset]([AgoraRtcEngineKit setVoiceBeautifierPreset:])
   - [setVoiceBeautifierParameters]([AgoraRtcEngineKit setVoiceBeautifierParameters:param1:param2:])
   - [setVoiceConversionPreset]([AgoraRtcEngineKit setVoiceConversionPreset:])
   - [setLocalVoiceReverbPreset]([AgoraRtcEngineKit setLocalVoiceReverbPreset:])
   - [setLocalVoiceChanger]([AgoraRtcEngineKit setLocalVoiceChanger:])
   - [setLocalVoicePitch]([AgoraRtcEngineKit setLocalVoicePitch:])
   - [setLocalVoiceEqualizationOfBandFrequency]([AgoraRtcEngineKit setLocalVoiceEqualizationOfBandFrequency:withGain:])
   - [setLocalVoiceReverbOfType]([AgoraRtcEngineKit  setLocalVoiceReverbOfType:withValue:])

 @param preset The options for SDK preset audio effects:

 - 3D voice effect: `AgoraRoomAcoustics3DVoice`.

    - Call `setAudioProfile` and set the `profile` parameter to
    `AgoraAudioProfileMusicStandardStereo(3)` or `AgoraAudioProfileMusicHighQualityStereo(5)` before setting this enumerator;
    otherwise, the enumerator setting does not take effect.
    - If the 3D voice effect is enabled, users need to use stereo audio playback devices to hear the anticipated voice effect.

 - Pitch correction effect: `AgoraPitchCorrection`. To achieve better audio effect quality, Agora recommends calling
 `setAudioProfile` and setting the `profile` parameter to `AgoraAudioProfileMusicHighQuality(4)` or
 `AgoraAudioProfileMusicHighQualityStereo(5)` before setting this enumerator.
 @param param1 - If you set `preset` to `AgoraRoomAcoustics3DVoice`, the `param1` sets the cycle period of the 3D voice effect.
 The value range is [1,60] and the unit is a second. The default value is 10 seconds, indicating that the voice moves around
 you every 10 seconds.
 - If you set `preset` to `AgoraPitchCorrection`, `param1` sets the basic mode of the pitch correction effect:

    - `1`: (Default) Natural major scale.
    - `2`: Natural minor scale.
    - `3`: Japanese pentatonic scale.
 @param param2 - If you set `preset` to `AgoraRoomAcoustics3DVoice`, you need to set `param2` to `0`.
- If you set`preset` to `AgoraPitchCorrection`, `param2` sets the tonic pitch of the pitch correction effect:

    - `1`: A
    - `2`: A#
    - `3`: B
    - `4`: (Default) C
    - `5`: C#
    - `6`: D
    - `7`: D#
    - `8`: E
    - `9`: F
    - `10`: F#
    - `11`: G
    - `12`: G#

 @return - 0: Success.
- < 0: Failure.
 */
- (int)setAudioEffectParameters:(AgoraAudioEffectPreset)preset param1:(int)param1 param2:(int)param2;

#pragma mark Sound Position Indication

/**-----------------------------------------------------------------------------
 * @name Sound Position Indication
 * -----------------------------------------------------------------------------
 */
/** Enables/Disables stereo panning for remote users.

If you need to use the [setRemoteVoicePosition]([AgoraRtcEngineKit setRemoteVoicePosition:pan:gain:]) method, ensure that you call this method before joining a channel to enable stereo panning for remote users.

 @param enabled Sets whether to enable stereo panning for remote users:

 - `YES`: enables stereo panning.
 - `NO`: disables stereo panning.

 @return * 0: Success.
 * < 0: Failure.
 */
- (int)enableSoundPositionIndication:(BOOL)enabled;

/** Sets the sound position and gain of a remote user.

 When the local user calls this method to set the sound position of a remote user, the sound difference between the left and right channels allows the local user to track the real-time position of the remote user, creating a real sense of space. This method applies to massively multiplayer online games, such as Battle Royale games.

**Note:**

- Ensure that you call this method after joining a channel. For this method to work, enable stereo panning for remote users by calling [enableSoundPositionIndication]([AgoraRtcEngineKit enableSoundPositionIndication:]) before joining a channel.
This method requires hardware support.
- For the best effect, we recommend using the following audio output devices:
  - (iOS) A wired headset.
  - (macOS) A stereo loudspeaker.
 @param uid The ID of the remote user.
 @param pan The sound position of the remote user. The value ranges from -1.0 to 1.0:

 * 0.0: (default) the remote sound comes from the front.
 * -1.0: the remote sound comes from the left.
 * 1.0: the remote sound comes from the right.

 @param gain Gain of the remote user. The value ranges from 0.0 to 100.0. The default value is 100.0 (the original gain of the remote user). The smaller the value, the less the gain.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)setRemoteVoicePosition:(NSUInteger)uid pan:(double)pan gain:(double)gain;

#pragma mark Music File Playback and Mixing

/**-----------------------------------------------------------------------------
 * @name Music File Playback and Mixing
 * -----------------------------------------------------------------------------
 */

/** Starts playing and mixing the music file.

 @since v3.4.0

 This method supports mixing or replacing local or online music file and audio collected by a microphone. After
 successfully playing the music file, the SDK triggers
 [localAudioMixingStateDidChanged]([AgoraRtcEngineDelegate rtcEngine:localAudioMixingStateDidChanged:reason:])`(AgoraAudioMixingStatePlaying, AgoraAudioMixingReasonStartedByUser)`.
 After completing playing the music file, the SDK triggers `localAudioMixingStateDidChanged(AgoraAudioMixingStateStopped, AgoraAudioMixingReasonAllLoopsCompleted)`.

 **Note:**

 - To avoid blocking, as of v3.4.5, this method changes from a synchronous call
 to an asynchronous call.
 - If you need to call `startAudioMixing` multiple times, ensure that the
 call interval is longer than 500 ms.
 - If the local music file does not exist, or if the SDK does not support the file format or cannot access the music
 file URL, the SDK returns `AgoraWarningCodeAudioMixingOpenError(701)`.
 - For the audio file formats supported by this method, see
 [What formats of audio files does the Agora RTC SDK support](https://docs.agora.io/en/faq/audio_format).

 @param filePath The absolute path or URL address (including the filename extensions) of the music file. For example:
 `/var/mobile/Containers/Data/audio.mp4`.
 @param loopback Whether to only play the music file on the local client:

 * YES: Only play the music file on the local client so that only the local user can hear the music.
 * NO: Publish the music file to remote clients so that both the local user and remote users can hear the music.

 @param replace Whether to replace the audio collected by the microphone with a music file:

 * YES: Replace. Users can only hear music.
 * NO: Do not replace. Users can hear both music and audio collected by the microphone.

 @param cycle The number of times the music file plays.

 * &ge; `0`: The number of playback times. For example, 0 means that the SDK does not play the music file, while 1 means
 that the SDK plays the music file once.
 * `-1`：Play the music in an indefinite loop.

 @param startPos The playback position (ms) of the music file.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)startAudioMixing:(NSString* _Nonnull)filePath loopback:(BOOL)loopback replace:(BOOL)replace cycle:(NSInteger)cycle startPos:(NSInteger)startPos;

/** Sets the playback speed of the current music file.

 @since v3.5.1

 @note Call this method after calling
 [startAudioMixing]([AgoraRtcEngineKit startAudioMixing:loopback:replace:cycle:startPos:])
 and receiving the
 [localAudioMixingStateDidChanged]([AgoraRtcEngineDelegate rtcEngine:localAudioMixingStateDidChanged:reason:])
 (`AgoraAudioMixingStatePlaying`) callback.

 @param speed The playback speed. Agora recommends that you limit this value to
 between 50 and 400, defined as follows:

 - 50: Half the original speed.
 - 100: The original speed.
 - 400: 4 times the original speed.

 @return * 0: Success.
 * < 0: Failure.
 */
- (int)setAudioMixingPlaybackSpeed:(int)speed;

/** Stops audio mixing.

 Call this method when you are in a channel.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)stopAudioMixing;

/** Pauses audio mixing.

 Call this method when you are in a channel.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)pauseAudioMixing;

/** Resumes audio mixing.

 Call this method when you are in a channel.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)resumeAudioMixing;

/** Specifies the playback track of the current music file.

 @since v3.5.1

 After getting the audio track index of the current music file, call this
 method to specify any audio track to play. For example, if different tracks of
 a multitrack file store songs in different languages, you can call this method
 to set the language of the music file to play.

 **Notes**

 - Call this method after calling
 [startAudioMixing]([AgoraRtcEngineKit startAudioMixing:loopback:replace:cycle:startPos:])
 and receiving the
 [localAudioMixingStateDidChanged]([AgoraRtcEngineDelegate rtcEngine:localAudioMixingStateDidChanged:reason:])
 (`AgoraAudioMixingStatePlaying`) callback.
 - This method applies to iOS only.
 - For the audio file formats supported by this method, see
 [What formats of audio files does the Agora RTC SDK support](https://docs.agora.io/en/faq/audio_format).

 @param index The specified playback track. This parameter must be less than or
 equal to the return value of [getAudioTrackCount]([AgoraRtcEngineKit getAudioTrackCount]).

 @return - 0: Success.
 - < 0: Failure.
 */
- (int)selectAudioTrack:(NSInteger)index;

/** Gets the audio track index of the current music file.

 @since v3.5.1

 **Notes**

 - Call this method after calling
 [startAudioMixing]([AgoraRtcEngineKit startAudioMixing:loopback:replace:cycle:startPos:])
 and receiving the
 [localAudioMixingStateDidChanged]([AgoraRtcEngineDelegate rtcEngine:localAudioMixingStateDidChanged:reason:])
 (`AgoraAudioMixingStatePlaying`) callback.
 - This method applies to iOS only.
 - For the audio file formats supported by this method, see
 [What formats of audio files does the Agora RTC SDK support](https://docs.agora.io/en/faq/audio_format).

 @return - &ge; 0: The audio track index of the current music file, if this method call succeeds.
 - < 0: Failure.
  */
- (int)getAudioTrackCount;

/** Sets the channel mode of the current music file.

 @since v3.5.1

 In a stereo music file, the left and right channels can store different audio
 data. According to your needs, you can set the channel mode to original mode,
 left channel mode, right channel mode, or mixed channel mode. For example,
 in the KTV scenario, the left channel of the music file stores the musical
 accompaniment, and the right channel stores the singing voice. If you only
 need to listen to the accompaniment, call this method to set the channel
 mode of the music file to left channel mode; if you need to listen to the
 accompaniment and the singing voice at the same time, call this method to
 set the channel mode to mixed channel mode.

 **Notes**

 - Call this method after calling
 [startAudioMixing]([AgoraRtcEngineKit startAudioMixing:loopback:replace:cycle:startPos:])
 and receiving the
 [localAudioMixingStateDidChanged]([AgoraRtcEngineDelegate rtcEngine:localAudioMixingStateDidChanged:reason:])
 (`AgoraAudioMixingStatePlaying`) callback.
 - This method only applies to stereo audio files.

 @param mode The channel mode. See AgoraAudioMixingDualMonoMode.

  @return - 0: Success.
 - < 0: Failure.
 */
- (int)setAudioMixingDualMonoMode:(AgoraAudioMixingDualMonoMode)mode;

/** Adjusts the volume of audio mixing.

 Ensure that this method is called after [startAudioMixing]([AgoraRtcEngineKit startAudioMixing:loopback:replace:cycle:startPos:]).

 **Note:**

 Calling this method does not affect the volume of audio effect file playback invoked by the [playEffect]([AgoraRtcEngineKit playEffect:filePath:loopCount:pitch:pan:gain:publish:startPos:]) method.

 @param volume Audio mixing volume. The value ranges between 0 and 100 (default).
 @return * 0: Success.
* < 0: Failure.
 */
- (int)adjustAudioMixingVolume:(NSInteger)volume;

/** Adjusts the volume of audio mixing for local playback.

 Ensure that this method is called after [startAudioMixing]([AgoraRtcEngineKit startAudioMixing:loopback:replace:cycle:startPos:]).

 @param volume Audio mixing volume for local playback. The value ranges between 0 and 100 (default).
 @return * 0: Success.
 * < 0: Failure.
 */
- (int)adjustAudioMixingPlayoutVolume:(NSInteger)volume;

/** Adjusts the volume of audio mixing for publishing (sending to other users).

 Ensure that this method is called after [startAudioMixing]([AgoraRtcEngineKit startAudioMixing:loopback:replace:cycle:startPos:]).

 @param volume Audio mixing volume for publishing. The value ranges between 0 and 100 (default).
 @return * 0: Success.
 * < 0: Failure.
 */
- (int)adjustAudioMixingPublishVolume:(NSInteger)volume;

/** Gets the audio mixing volume for publishing.

 This method helps troubleshoot audio volume related issues.

 @note Call this method after calling [startAudioMixing]([AgoraRtcEngineKit startAudioMixing:loopback:replace:cycle:startPos:])
and receiving the [localAudioMixingStateDidChanged]([AgoraRtcEngineDelegate rtcEngine:localAudioMixingStateDidChanged:reason:])(`AgoraAudioMixingStatePlaying`) callback.

 @return * &ge; 0: The audio mixing volume for publishing, if this method call is successful. The value ranges between 0 to 100.
* < 0: Failure.
*/
- (int)getAudioMixingPublishVolume;

/** Gets the audio mixing volume for local playback.

 This method helps troubleshoot audio volume related issues.

 @note Call this method after calling [startAudioMixing]([AgoraRtcEngineKit startAudioMixing:loopback:replace:cycle:startPos:])
and receiving the [localAudioMixingStateDidChanged]([AgoraRtcEngineDelegate rtcEngine:localAudioMixingStateDidChanged:reason:])(`AgoraAudioMixingStatePlaying`) callback.

 @return * &ge; 0: The audio mixing volume for local playback, if this method call is successful. The value ranges between 0 to 100.
* < 0: Failure.
*/
- (int)getAudioMixingPlayoutVolume;

/** Gets the playback position (ms) of the audio mixing file.

 **Note**:

 - Call this method after calling [startAudioMixing]([AgoraRtcEngineKit startAudioMixing:loopback:replace:cycle:startPos:])
 and receiving the [localAudioMixingStateDidChanged]([AgoraRtcEngineDelegate rtcEngine:localAudioMixingStateDidChanged:reason:])(`AgoraAudioMixingStatePlaying`) callback.
 - If you need to call `getAudioMixingCurrentPosition` multiple times, ensure that the call interval is longer than 500 ms.

 @return * &ge; 0: The current playback position (ms) of the music file, if this method call succeeds. 0 represents that the current music file does not start playing.

* < 0: Failure.
 */
- (int)getAudioMixingCurrentPosition;

/** Sets the playback position of the audio mixing file to a different starting position (the default plays from the beginning).

 Ensure that this method is called after [startAudioMixing]([AgoraRtcEngineKit startAudioMixing:loopback:replace:cycle:startPos:]).

 @param pos The playback starting position (ms) of the audio mixing file.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)setAudioMixingPosition:(NSInteger)pos;

/** Sets the pitch of the local music file.

 **Since:** v3.0.1.

 When a local music file is mixed with a local human voice, call this method to set the pitch of the local music file only.

 @note Call this method after calling [startAudioMixing]([AgoraRtcEngineKit startAudioMixing:loopback:replace:cycle:startPos:]).

 @param pitch Sets the pitch of the local music file by chromatic scale. The default value is 0, which means keeping the original pitch. The value ranges from -12 to 12, and the pitch value between consecutive values is a chromatic value. The greater the absolute value of this parameter, the higher or lower the pitch of the local music file.

 @return * 0: Success.
 * < 0: Failure.
 */
- (int)setAudioMixingPitch:(NSInteger)pitch;

#pragma mark Audio Effect File Playback

/**-----------------------------------------------------------------------------
 * @name Audio Effect File Playback
 * -----------------------------------------------------------------------------
 */

/** Gets the volume of the audio effects.

 Ensure that this method is called after [playEffect]([AgoraRtcEngineKit playEffect:filePath:loopCount:pitch:pan:gain:publish:startPos:]).

 The value ranges between 0.0 and 100.0.

 @return * &ge; 0: Volume of the audio effects, if this method call is successful.

* < 0: Failure.
 */
- (double)getEffectsVolume;

/** Sets the volume of the audio effects.

 Ensure that this method is called after [playEffect]([AgoraRtcEngineKit playEffect:filePath:loopCount:pitch:pan:gain:publish:startPos:]).

 @param volume Volume of the audio effects. The value ranges between 0.0 and 100.0 (default).

 @return * 0: Success.
* < 0: Failure.
 */
- (int)setEffectsVolume:(double)volume;

/** Sets the volume of a specified audio effect.

 Ensure that this method is called after [playEffect]([AgoraRtcEngineKit playEffect:filePath:loopCount:pitch:pan:gain:publish:startPos:]).

 @param soundId ID of the audio effect. Each audio effect has a unique ID.
 @param volume Volume of the audio effect. The value ranges between 0.0 and 100.0 (default).

 @return * 0: Success.
* < 0: Failure.
 */
- (int)setVolumeOfEffect:(int)soundId withVolume:(double)volume;

/** Plays a specified local or online audio effect file.

 To play multiple audio effect files at the same time, call this method multiple times with different `soundId` and `filePath` values.
 For the best user experience, Agora recommends playing no more than three audio effect files at the same time.

 After completing playing an audio effect file, the SDK triggers the [rtcEngineDidAudioEffectFinish]([AgoraRtcEngineDelegate rtcEngineDidAudioEffectFinish:soundId:]) callback.

 **Note**

 - Call this method after joining a channel.
 - For the audio file formats supported by this method, see
 [What formats of audio files does the Agora RTC SDK support](https://docs.agora.io/en/faq/audio_format).

 @param soundId Audio effect ID. The ID of each audio effect file is unique. If you preloaded an audio effect into
 memory by calling [preloadEffect](preloadEffect:filePath:), ensure that this parameter is set to the same value as in `preloadEffect`.
 @param filePath The absolute path or URL address (including the filename extensions) of the audio effect file.
 For example: `/var/mobile/Containers/Data/audio.mp4`.
 If you preloaded an audio effect into memory by calling `preloadEffect`, ensure that this parameter is set to the same
 value as in `preloadEffect`.
 @param loopCount The number of times the audio effect loops:

 - ≥ `0`: The number of loops. For example, `1` means loop one time, which means play the audio effect two times in total.
 - `-1`: Play the audio effect in an indefinite loop.

 @param pitch The pitch of the audio effect. The range is `0.5` to `2.0`. The default value is `1.0`, which means the
 original pitch. The lower the value, the lower the pitch.
 @param pan The spatial position of the audio effect. The range is `-1.0` to `1.0`. For example:

 - `-1.0`: The audio effect occurs on the left.
 - `0.0`: The audio effect occurs in the front.
 - `1.0`: The audio effect occurs on the right.

 @param gain The volume of the audio effect. The range is `0.0` to `100.0`. The default value is 100.0, which means the
 original volume. The smaller the value, the less the gain.
 @param publish Whether to publish the audio effect to the remote users:

- `YES`: Publish. Both the local user and remote users can hear the audio effect.
- `NO`: Do not publish. Only the local user can hear the audio effect.

 @param startPos The playback position (ms) of the audio effect file.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)playEffect:(int)soundId filePath:(NSString* _Nullable)filePath loopCount:(int)loopCount pitch:(double)pitch pan:(double)pan gain:(double)gain publish:(BOOL)publish startPos:(int)startPos;

/** Stops playing a specified audio effect.

 @param soundId ID of the audio effect. Each audio effect has a unique ID.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)stopEffect:(int)soundId;

/** Stops playing all audio effects.
 */
- (int)stopAllEffects;

/** Preloads a specified audio effect file into the memory.

 To ensure smooth communication, limit the size of the audio effect file. Agora recommends using this method to preload the audio effect before calling the [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) method.

 **Note**

 - This method does not support online audio effect files.
 - For the audio file formats supported by this method, see
 [What formats of audio files does the Agora RTC SDK support](https://docs.agora.io/en/faq/audio_format).

 @param soundId  ID of the audio effect. Each audio effect has a unique ID.
 @param filePath Absolute path of the audio effect file.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)preloadEffect:(int)soundId filePath:(NSString* _Nullable)filePath;

/** Releases a specified preloaded audio effect from the memory.

 @param soundId ID of the audio effect. Each audio effect has a unique ID.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)unloadEffect:(int)soundId;

/** Pauses a specified audio effect.

 @param soundId ID of the audio effect. Each audio effect has a unique ID.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)pauseEffect:(int)soundId;

/** Pauses all audio effects.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)pauseAllEffects;

/** Resumes playing a specified audio effect.

 @param soundId ID of the audio effect. Each audio effect has a unique ID.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)resumeEffect:(int)soundId;

/** Resumes playing all audio effects.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)resumeAllEffects;

/** Gets the playback position of the audio effect file.

 @since v3.4.0

 @note Call this method after [playEffect]([AgoraRtcEngineKit playEffect:filePath:loopCount:pitch:pan:gain:publish:startPos:]).

 @param soundId Audio effect ID. Ensure that this parameter is set to the same value as in `playEffect`.
 @return - &ge; 0: A successful method call. Returns the playback position (ms) of the specified audio effect file.
- < 0: Failure.

   - `-22(AgoraErrorCodeResourceLimited)`: Cannot find the audio effect file. Please set a correct `soundId`.
 */
- (int)getEffectCurrentPosition:(int)soundId;

/** Sets the playback position of an audio effect file.

 @since v3.4.0

 After a successful setting, the local audio effect file starts playing at the specified position.

 @note Call this method after [playEffect]([AgoraRtcEngineKit playEffect:filePath:loopCount:pitch:pan:gain:publish:startPos:]).

 @param soundId Audio effect ID. Ensure that this parameter is set to the same value as in `playEffect`.
 @param pos The playback position (ms) of the audio effect file.

 @return - 0: Success.
- < 0: Failure.

   - `-22(AgoraErrorCodeResourceLimited)`: Cannot find the audio effect file. Please set a correct `soundId`.
 */
- (int)setEffectPosition:(int)soundId pos:(NSInteger)pos;

/** Gets the duration of the audio effect file.

 @since v3.4.0

 **Note**

 - Call this method after joining a channel.
 - For the audio file formats supported by this method, see
 [What formats of audio files does the Agora RTC SDK support](https://docs.agora.io/en/faq/audio_format).

 @param filePath The absolute path (including the filename extensions) of the local audio effect file. For example:
 `/var/mobile/Containers/Data/audio.mp4`.
 @return - &ge; 0: A successful method call. Returns the total duration (ms) of the specified audio effect file.
- < 0: Failure.

   - `-22(AgoraErrorCodeResourceLimited)`: Cannot find the audio effect file. Please set a correct `filePath`.
 */
- (int)getEffectDuration:(NSString* _Nonnull)filePath;

/**-----------------------------------------------------------------------------
 * @name Virtual metronome
 * -----------------------------------------------------------------------------
 */

/** Enables the virtual metronome (iOS only).

 @since v3.4.0

 In music education, physical education, and other scenarios, teachers often need to use a metronome so that students
 can practice at the correct tempo. A meter is composed of a downbeat and some number of upbeats (including zero). The
 first beat of each measure is called the downbeat, and the rest are called the upbeats. In this method, you need to set
 the paths of the upbeat and downbeat files, the number of beats per measure, the tempo, and whether to send the sound of the metronome to remote users.

 **Note**

 - After enabling the virtual metronome, the SDK plays the specified files from the beginning and controls the beat
 duration according to the value you set in [beatsPerMinute](AgoraRtcRhythmPlayerConfig). If the file duration exceeds
 the beat duration, the SDK only plays the audio within the beat duration.
 - For the audio file formats supported by this method, see
 [What formats of audio files does the Agora RTC SDK support](https://docs.agora.io/en/faq/audio_format).

 @param sound1 The absolute path or URL address (including the filename extensions) of the file for the downbeat. For
 example: `/var/mobile/Containers/Data/audio.mp4`.
 @param sound2 The absolute path or URL address (including the filename extensions) of the file for the upbeats. For
 example: `/var/mobile/Containers/Data/audio.mp4`.
 @param config The metronome configuration. See [AgoraRtcRhythmPlayerConfig](AgoraRtcRhythmPlayerConfig).
 @return - 0: Success.
- < 0: Failure.

   - `-22(AgoraErrorCodeResourceLimited)`: Cannot find audio effect files. Please set the correct paths for `sound1` and `sound2`.
 */
- (int)startRhythmPlayer:(NSString* _Nonnull)sound1 sound2:(NSString* _Nonnull)sound2 config:(AgoraRtcRhythmPlayerConfig* _Nonnull)config;
/** Disables the virtual metronome (iOS only).

 @since v3.4.0

 After calling [startRhythmPlayer]([AgoraRtcEngineKit startRhythmPlayer:sound2:config:]), you can call this method to
 disable the virtual metronome.

 @return - 0: Success.
- < 0: Failure.
 */
- (int)stopRhythmPlayer;
/** Configures the virtual metronome (iOS only).

 @since v3.4.0

 After calling [startRhythmPlayer]([AgoraRtcEngineKit startRhythmPlayer:sound2:config:]), you can call this method to
 reconfigure the virtual metronome.

 @note After reconfiguring the virtual metronome, the SDK plays the specified files from the beginning and controls the
 beat duration according to the value you set in [beatsPerMinute](AgoraRtcRhythmPlayerConfig). If the file duration
 exceeds the beat duration, the SDK only plays the audio within the beat duration.

 @param config The metronome configuration. See [AgoraRtcRhythmPlayerConfig](AgoraRtcRhythmPlayerConfig).
 @return - 0: Success.
- < 0: Failure.
 */
- (int)configRhythmPlayer:(AgoraRtcRhythmPlayerConfig* _Nonnull)config;

#pragma mark Audio Recorder

/**-----------------------------------------------------------------------------
 * @name Audio Recorder
 * -----------------------------------------------------------------------------
 */

/** Starts an audio recording on the client.

 @since v3.4.0

 The SDK allows recording audio during a call. After successfully calling this method, you can record the audio of
 users in the channel and get an audio recording file. Supported file formats are as follows:

 - WAV: High-fidelity files with typically larger file sizes. For example, if the sample rate is 32,000 Hz, the file
 size for a 10-minute recording is approximately 73 MB.
 - AAC: Low-fidelity files with typically smaller file sizes. For example, if the sample rate is 32,000 Hz and the
 recording quality is `AgoraAudioRecordingQualityMedium`, the file size for a 10-minute recording is approximately 2 MB.

 Once the user leaves the channel, the recording automatically stops.

 @note Call this method after joining a channel.

 @param config  Recording configuration. See AgoraAudioRecordingConfiguration.

 @return - 0: Success.
 - < 0: Failure.

   -160(`AgoraErrorCodeAlreadyInRecording`): The client is already recording audio. To start a new recording, call
   [stopAudioRecording]([AgoraRtcEngineKit stopAudioRecording]) to stop the current recording first, and then call
   `startAudioRecordingWithConfig`.
 */
- (int)startAudioRecordingWithConfig:(AgoraAudioRecordingConfiguration* _Nonnull)config;

/** Stops an audio recording on the client.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)stopAudioRecording;

#pragma mark Loopback Recording

/**-----------------------------------------------------------------------------
 * @name Loopback Sampling
 * -----------------------------------------------------------------------------
 */

#if (!(TARGET_OS_IPHONE) && (TARGET_OS_MAC))
/** Enables loopback sampling. (macOS only)

 If you enable loopback sampling, the output of the sound card is mixed into the audio stream sent to the other end.

 You can call this method either before or after joining a channel.

 **Note:**

 macOS does not support loopback sampling of the default sound card. If you need to use this method, please use a virtual sound card and pass its name to the `deviceName` parameter. Agora has tested and recommends using soundflower.

 @param enabled Sets whether to enable/disable loopback sampling.

 * YES: Enable loopback sampling.
 * NO: (Default) Disable loopback sampling.

 @param deviceName Pointer to the device name of the sound card. The default value is nil (default sound card). If you use a virtual sound card like "Soundflower", set this parameter as the name of the sound card, "Soundflower", and the SDK will find the corresponding sound card and start capturing.
 @return * 0: Success.
* < 0: Failure.
 */
- (int)enableLoopbackRecording:(BOOL)enabled deviceName:(NSString* _Nullable)deviceName;
#endif

#pragma mark Miscellaneous Audio Control

/**-----------------------------------------------------------------------------
 * @name Miscellaneous Audio Control
 * -----------------------------------------------------------------------------
 */

#if defined(TARGET_OS_IPHONE) && TARGET_OS_IPHONE
/** Sets the operational permission of the SDK on the audio session. (iOS only)

 The SDK and the app can both configure the audio session by default. If you need to only use the app to configure the audio session, this method restricts the operational permission of the SDK on the audio session.

 You can call this method either before or after joining a channel. Once you call this method to restrict the operational permission of the SDK on the audio session, the restriction takes effect when the SDK needs to change the audio session.

 @note This method does not restrict the operational permission of the app on the audio session.

 @param restriction The operational permission of the SDK on the audio session. See [AgoraAudioSessionOperationRestriction](AgoraAudioSessionOperationRestriction). This parameter is in bit mask format, and each bit corresponds to a permission.
 */
- (void)setAudioSessionOperationRestriction:(AgoraAudioSessionOperationRestriction)restriction;
#endif

/** Enables or disables deep-learning noise reduction.

 The SDK enables traditional noise reduction mode by default to reduce most
 of the stationary background noise. If you need to reduce most of the
 non-stationary background noise, Agora recommends enabling deep-learning
 noise reduction as follows:

 1. Ensure that the following library is integrated in your project:

   - iOS: `AgoraAIDenoiseExtension.xcframework`
   - macOS: `AgoraAIDenoiseExtension.framework`
 2. Call `enableDeepLearningDenoise(YES)`.

 Deep-learning noise reduction requires high-performance devices. The
 following devices and later models are known to support deep-learning noise
 reduction:

 - iPhone 6S
 - MacBook Pro 2015
 - iPad Pro (2nd generation)
 - iPad mini (5th generation)
 - iPad Air (3rd generation)

 After successfully enabling deep-learning noise reduction, if the SDK detects
 that the device performance is not sufficient, it automatically disables
 deep-learning noise reduction and enables traditional noise reduction.

 If you call `enableDeepLearningDenoise(NO)` or the SDK automatically
 disables deep-learning noise reduction in the channel, when you need to
 re-enable deep-learning noise reduction, you need to call [leaveChannel]([AgoraRtcEngineKit leaveChannel:])
 first, and then call `enableDeepLearningDenoise(YES)`.

 **Note**

 - This method dynamically loads the `AgoraAIDenoiseExtension` library, so
 Agora recommends calling this method before joining a channel.
 - This method works best with the human voice. Agora does not recommend
 using this method for audio containing music.

 @param enabled Sets whether to enable deep-learning noise reduction.

 - `YES`: (Default) Enables deep-learning noise reduction.
 - `NO`: Disables deep-learning noise reduction.

 @return * 0: Success.
 * < 0: Failure.
   * -`157`(`AgoraErrorCodeModuleNotFound`): The library for enabling deep-learning noise reduction is not integrated.
 */
- (int)enableDeepLearningDenoise:(BOOL)enabled;

#pragma mark Network-related Test

/**-----------------------------------------------------------------------------
 * @name Network-related Test
 * -----------------------------------------------------------------------------
 */

/** Starts an audio call test.

This method starts an audio call test to determine whether the audio devices (for example, headset and speaker) and the network connection are working properly.

In the audio call test, the SDK samples your voice. If the sampled audio data plays back within the set time interval, the audio devices and the network connection are working properly.

**Note:**

- Call this method before joining a channel.

- After calling this method, call the stopEchoTest method to end the test. Otherwise, the app cannot run the next echo test, or join a channel.

- In the interactive live streaming profile, only a host can call this method.

@param interval The time interval (s) between when you speak and when the sampled audio data plays back.
@param successBlock The SDK triggers the `successBlock` callback if this method call is successful.

@return * 0: Success.
* < 0: Failure.
*/
- (int)startEchoTestWithInterval:(NSInteger)interval successBlock:(void (^_Nullable)(NSString* _Nonnull channel, NSUInteger uid, NSInteger elapsed))successBlock;

/**
 Starts an audio and video call loop test.

 @since v3.5.2

 Before joining a channel, to test whether the user's local sending and receiving streams are normal, you can call this
 method to perform an audio and video call loop test, which tests whether the audio and video devices and the user's upstream and downstream networks are working properly.

 After starting the test, the user needs to make a sound or face the camera. The audio or video is output after about two seconds.
 If the audio playback is normal, the audio device and the user's upstream and downstream networks are working properly;
 if the video playback is normal, the video device and the user's upstream and downstream networks are working properly.

 **Notes:**

 - Call this method before joining a channel.
 - After calling this method, call [stopEchoTest]([AgoraRtcEngineKit stopEchoTest]) to end the test; otherwise, the user cannot perform the next audio and video call loop test and cannot join the channel.
 - In the `LiveBroadcasting` profile, only a host can call this method.

 @param config The configuration of the audio and video call loop test. See AgoraEchoTestConfiguration.

 @return - 0: Success.
 - < 0: Failure.
 */
- (int)startEchoTestWithConfig:(AgoraEchoTestConfiguration* _Nonnull)config;

/** Stops call loop test.

After calling [startEchoTestWithInterval]([AgoraRtcEngineKit startEchoTestWithInterval:successBlock:])
or [startEchoTestWithConfig]([AgoraRtcEngineKit startEchoTestWithConfig:]), call this method if you want to stop the call loop test.

 @return * 0: Success.
* < 0: Failure. For example, AgoraErrorCodeRefused(-5)：Failed to stop the echo test. The echo test may not be running.
 */
- (int)stopEchoTest;

- (int)setLocalAccessPoint:(NSArray* _Nonnull)ips domain:(NSString* _Nonnull)domain;

/** Enables the network connection quality test.

 This method tests the quality of the user’s network connection and is disabled by default.

 Before users join a channel or before an audience switches to a host, call this method to check the uplink network quality.

 This method consumes additional network traffic, which may affect the communication quality. We do not recommend calling this method together with [startLastmileProbeTest]([AgoraRtcEngineKit startLastmileProbeTest:]).

 Call the [disableLastmileTest](disableLastmileTest) method to disable this test after receiving the [lastmileQuality]([AgoraRtcEngineDelegate rtcEngine:lastmileQuality:]) callback, and before the user joins the channel or switches the user role.

 **Note:**

 - Do not call any other methods before receiving the [lastmileQuality]([AgoraRtcEngineDelegate rtcEngine:lastmileQuality:]) callback. Otherwise, the callback may be interrupted by other methods and may not execute.

 - In the interactive live streaming profile, a host should not call this method after joining a channel.
 - If you call this method to test the last mile quality, the SDK consumes the bandwidth of a video stream, whose bitrate corresponds to the bitrate you set in the [setVideoEncoderConfiguration]([AgoraRtcEngineKit setVideoEncoderConfiguration:]) method. After you join the channel, whether you have called the `disableLastmileTest` method or not, the SDK automatically stops consuming the bandwidth.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)enableLastmileTest;

/** Disables the network connection quality test.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)disableLastmileTest;

/** Starts the last-mile network probe test.


Starts the last-mile network probe test before joining a channel to get the uplink and downlink last-mile network statistics, including the bandwidth, packet loss, jitter, and round-trip time (RTT).

Call this method to check the uplink network quality before users join a channel or before an audience switches to a host.

Once this method is enabled, the SDK returns the following callbacks:

- [lastmileQuality]([AgoraRtcEngineDelegate rtcEngine:lastmileQuality:]): the SDK triggers this callback within two seconds depending on the network conditions. This callback rates the network conditions and is more closely linked to the user experience.
- [lastmileProbeResult]([AgoraRtcEngineDelegate rtcEngine:lastmileProbeTestResult:])the SDK triggers this callback within 30 seconds depending on the network conditions. This callback returns the real-time statistics of the network conditions and is more objective.

**Note:**

- This method consumes extra network traffic and may affect communication quality. We do not recommend calling this method together with [enableLastmileTest]([AgoraRtcEngineKit enableLastmileTest]).
- Do not call other methods before receiving the [lastmileQuality]([AgoraRtcEngineDelegate rtcEngine:lastmileQuality:]) and [lastmileProbeResult]([AgoraRtcEngineDelegate rtcEngine:lastmileProbeTestResult:]) callbacks. Otherwise, the callbacks may be interrupted.
- In the interactive live streaming profile, a host should not call this method after joining a channel.

@param config The configurations of the last-mile network probe test, see [AgoraLastmileProbeConfig](AgoraLastmileProbeConfig).

@return * 0: Success.
* < 0: Failure.
*/
- (int)startLastmileProbeTest:(AgoraLastmileProbeConfig* _Nullable)config;

/** Stops the last-mile network probe test.

@return * 0: Success.
* < 0: Failure.
*/
- (int)stopLastmileProbeTest;

#pragma mark Custom Video Module

/**-----------------------------------------------------------------------------
 * @name Custom Video Module
 * -----------------------------------------------------------------------------
 */

/** Sets the video source.

 In real-time communications, the SDK uses the default video input source (the built-in camera) to publish streams. To use an external video source, call AgoraVideoSourceProtocol to set the custom video source and then use this method to add the external video source into the SDK.

 You can call this method either before or after joining a channel.

 @param videoSource AgoraVideoSourceProtocol
 */
- (void)setVideoSource:(id<AgoraVideoSourceProtocol> _Nullable)videoSource;

/** Sets the local video renderer.

 In real-time communications, the SDK uses the default video renderer to render the video. To use an external video renderer, call AgoraVideoSinkProtocol to set the custom local video renderer and then use this method to add the external renderer into the SDK.

 You can call this method either before or after joining a channel.

 @param videoRenderer Sets the local video renderer. See AgoraVideoSinkProtocol.
 */
- (void)setLocalVideoRenderer:(id<AgoraVideoSinkProtocol> _Nullable)videoRenderer;

/** Sets the remote video renderer.

 This method sets the remote renderer. In real-time communications, the SDK uses the default video renderer to render the video. To use an external video renderer, call AgoraVideoSinkProtocol to set the custom remote video renderer and then use this method to add the external renderer into the SDK.

 You can call this method either before or after joining a channel. If you call it before joining a channel, you need to maintain the `uid` of the remote user on your app level.

 @param videoRenderer Sets the video renderer of the remote user. See AgoraVideoSinkProtocol.
 @param userId ID of the remote user.
 */
- (void)setRemoteVideoRenderer:(id<AgoraVideoSinkProtocol> _Nullable)videoRenderer forUserId:(NSUInteger)userId;

/** Gets the video source.

  @return Video source. See AgoraVideoSourceProtocol.
 */
- (id<AgoraVideoSourceProtocol> _Nullable)videoSource;

/** Gets the local video renderer.

 @return Local video renderer. See AgoraVideoSinkProtocol.
 */
- (id<AgoraVideoSinkProtocol> _Nullable)localVideoRenderer;

/** Gets the video renderer of a specified remote user.

 @param userId ID of the remote user.
 @return Video renderer of the remote user. See AgoraVideoSinkProtocol.
 */
- (id<AgoraVideoSinkProtocol> _Nullable)remoteVideoRendererOfUserId:(NSUInteger)userId;

/** Registers a raw video frame protocol.

 @since v3.4.5

 After you successfully register the raw video frame protocol, the SDK triggers
 the callbacks that you have implemented in AgoraVideoDataFrameProtocol each
 time a video frame is received.

 **Note**:

 - This method applies to iOS only.
 - Ensure that you call this method before joining a channel.
 - The width and height of the video obtained through the protocol may change
 due to poor network conditions and user-adjusted resolution.

 @param videoData The raw video frame. See AgoraVideoDataFrameProtocol. If
 `nil` is passed, the protocol registration is canceled.
 */
- (void)setVideoDataFrame:(id<AgoraVideoDataFrameProtocol> _Nullable)videoData;

/** Registers a local encoded video frame protocol.

 @since v3.4.5

 After you successfully register the local encoded video frame protocol, the
 SDK triggers the callbacks that you have implemented in
 AgoraVideoEncodedFrameProtocol each time a video frame is received.

 **Note**:

 - This method applies to iOS only.
 - Ensure that you call this method before joining a channel.
 - The width and height of the video obtained through the protocol may change
 due to poor network conditions and user-adjusted resolution.

 @param videoEncode The local encoded video frame protocol.
 See AgoraVideoEncodedFrameProtocol. If `nil` is passed, the protocol
 registration is canceled.
 */
- (void)setVideoEncodedFrame:(id<AgoraVideoEncodedFrameProtocol> _Nullable)videoEncode;

#pragma mark External Audio Data

/**-----------------------------------------------------------------------------
 * @name External Audio Sink
 * -----------------------------------------------------------------------------
 */

/** Enables the external audio sink.

 This method applies to scenarios where you want to use external audio data for playback. After enabling the external audio sink, you can call the [pullPlaybackAudioFrameRawData]([AgoraRtcEngineKit pullPlaybackAudioFrameRawData:lengthInByte:]) / [pullPlaybackAudioFrameSampleBufferByLengthInByte]([AgoraRtcEngineKit pullPlaybackAudioFrameSampleBufferByLengthInByte:]) method to pull the remote audio data, process it, and play it with the audio effects that you want.

 Ensure that you call this method before joining a channel.

 @param sampleRate Sets the sample rate (Hz) of the external audio sink. You can set this parameter as 16000, 32000, 44100 or 48000.
 @param channels Sets the number of audio channels of the external audio sink:

 - 1: Mono
 - 2: Stereo

 @note Once you enable the external audio sink, the app will not retrieve any audio data from the `onPlaybackAudioFrame` callback.
 */
- (void)enableExternalAudioSink:(NSUInteger)sampleRate channels:(NSUInteger)channels;

/** Disables the external audio sink.
 */
- (void)disableExternalAudioSink;

/** Pulls the remote audio data in the RawData format.

 Before calling this method, call the [enableExternalAudioSink]([AgoraRtcEngineKit enableExternalAudioSink:channels:]) method to enable and set the external audio sink.

 After a successful method call, the app pulls the decoded and mixed audio data for playback.

 **Note**

 - Ensure that you call this method after joining a channel. Once you call the [pullPlaybackAudioFrameRawData]([AgoraRtcEngineKit pullPlaybackAudioFrameRawData:lengthInByte:]) method successfully, the app will not retrieve any audio data from the `onPlaybackAudioFrame` callback.
 - The difference between the `onPlaybackAudioFrame` callback and the `pullPlaybackAudioFrameRawData` method is as follows:
    - `onPlaybackAudioFrame`: The SDK sends the audio data to the app through this callback. Any delay in processing the audio frames may result in audio jitter.
    - `pullPlaybackAudioFrameRawData`: The app pulls the remote audio data autonomously. After setting the audio data parameters, the SDK adjusts the frame buffer and avoids problems caused by jitter in the external audio playback.

 @param data The audio data that you want to pull. The data format is in byte[].
 @param lengthInByte The data length (byte) of the external audio data. The value of this parameter is related to the audio duration, and the values of the `sampleRate` and `channels` parameters that you set in [enableExternalAudioSink]([AgoraRtcEngineKit enableExternalAudioSink:channels:]). Agora recommends setting the audio duration no shorter than 10 ms. The formula for `lengthInByte` is as follows: `lengthInByte` = `sampleRate` / 1000 × 2 × `channels` × audio duration (ms).

 @return - YES: Success.
 - NO: Failure.
 */
- (BOOL)pullPlaybackAudioFrameRawData:(void* _Nonnull)data lengthInByte:(NSUInteger)lengthInByte;

/** Pulls the remote audio data in the SampleBuffer format.

 Before calling this method, call the [enableExternalAudioSink]([AgoraRtcEngineKit enableExternalAudioSink:channels:]) method to enable and set the external audio sink.

 After a successful method call, the app pulls the decoded and mixed audio data for playback.

 **Note**

 - Ensure that you call this method after joining a channel. Once you call the [pullPlaybackAudioFrameSampleBufferByLengthInByte]([AgoraRtcEngineKit pullPlaybackAudioFrameSampleBufferByLengthInByte:]) method successfully, the app will not retrieve any audio data from the `onPlaybackAudioFrame` callback.
 - The difference between the `onPlaybackAudioFrame` callback and the `pullPlaybackAudioFrameSampleBufferByLengthInByte` method is as follows:
    - `onPlaybackAudioFrame`: The SDK sends the audio data to the app through this callback. Any delay in processing the audio frames may result in audio jitter.
    - `pullPlaybackAudioFrameSampleBufferByLengthInByte`: The app pulls the remote audio data. After setting the audio data parameters, the SDK adjusts the frame buffer and avoids problems caused by jitter in the external audio playback.

 @param lengthInByte The data length (byte) of the external audio data. The value of this parameter is related to the audio duration, and the values of the `sampleRate` and `channels` parameters that you set in [enableExternalAudioSink]([AgoraRtcEngineKit enableExternalAudioSink:channels:]). This parameter should be divisible by the value of `sampleRate`, and Agora recommends setting the audio duration no shorter than 10 ms. The formula for `lengthInByte` is as follows: `lengthInByte` = `sampleRate` / 1000 × 2 × `channels` × audio duration (ms).
 - This parameter should be divisible by the value of sampleRate.

 @return - YES: Success.
 - NO: Failure.
 */
- (CMSampleBufferRef _Nullable)pullPlaybackAudioFrameSampleBufferByLengthInByte:(NSUInteger)lengthInByte;

/**-----------------------------------------------------------------------------
 * @name External Audio Data (push-mode only)
 * -----------------------------------------------------------------------------
 */

/** Enables the external audio source.

 Call this method before [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) and [startPreview]([AgoraRtcEngineKit startPreview]).

 @param sampleRate       Sets the sample rate (Hz) of the external audio source: 8000, 16000, 44100, or 48000 Hz.
 @param channelsPerFrame Sets the number of external audio source channels:

 - 1: Mono.
 - 2: Stereo.
 */
- (void)enableExternalAudioSourceWithSampleRate:(NSUInteger)sampleRate channelsPerFrame:(NSUInteger)channelsPerFrame;

/** Disables the external audio source.
 */
- (void)disableExternalAudioSource;

/** Sets the volume of the external audio frame in the specified position.

 @since v3.5.1

 You can call this method multiple times to set the volume of external audio
 frames in different positions. The volume setting takes effect for all
 external audio frames that are pushed to the specified position.

 @note Call this method after joining a channel.

 @param sourcePos The push position of the external audio frame. See AgoraAudioExternalSourcePos.
 @param volume The volume of the external audio frame.
 The value range is [0,100]. The default value is 100, which
 represents the original value.
*/
- (void)setExternalAudioSourceVolume:(AgoraAudioExternalSourcePos)sourcePos volume:(NSUInteger)volume;

/** Pushes the external raw audio frame to a specified position.

 @since v3.5.1

 According to your needs, you can push the external audio frame to one of three
 positions: after audio capture, before audio encoding, or before local playback.
 You can call this method multiple times to push one audio frame to multiple
 positions or multiple audio frames to different positions. For example, in
 the KTV scenario, you can push the singing voice to after audio capture, so
 that the singing voice can be processed by the SDK audio module and you can
 obtain a high-quality audio experience; you can also push the accompaniment to
 before audio encoding, so that the accompaniment is not affected by the audio
 module of the SDK.

 @note Call this method after joining a channel.

 @param sourcePos The push position of the external audio frame.
 See AgoraAudioExternalSourcePos.
 @param frame The audio frame. See AgoraAudioFrame. The value range of the
 audio frame length (ms) is [10,60].

 @return * 0: Success.
 * < 0: Failure.

  - -2 (`AgoraErrorCodeInvalidArgument`): The parameter is invalid.
  - -12 (`AgoraErrorCodeTooOften`): The call frequency is too high, causing the
  internal buffer to overflow. Call this method again after 30-50 ms.
 */
- (int)pushExternalAudioFrameRawData:(AgoraAudioExternalSourcePos)sourcePos frame:(AgoraAudioFrame* _Nonnull)frame;

/** Pushes the external CMSampleBuffer audio frame to a specified position.

 @since v3.5.1

 According to your needs, you can push the external audio frame to one of three
 positions: after audio capture, before audio encoding, or before local playback.
 You can call this method multiple times to push one audio frame to multiple
 positions or multiple audio frames to different positions. For example, in
 the KTV scenario, you can push the singing voice to after audio capture, so
 that the singing voice can be processed by the SDK audio module and you can
 obtain a high-quality audio experience; you can also push the accompaniment to
 before audio encoding, so that the accompaniment is not affected by the audio
 module of the SDK.

 @note Call this method after joining a channel.

 @param sourcePos The push position of the external audio frame.
 See AgoraAudioExternalSourcePos.
 @param sampleBuffer The sample buffer. The value range of the
 sample buffer length (ms) is [10,60].

 @return * 0: Success.
 * < 0: Failure.

  - -2 (`AgoraErrorCodeInvalidArgument`): The parameter is invalid.
  - -12 (`AgoraErrorCodeTooOften`): The call frequency is too high, causing the
  internal buffer to overflow. Call this method again after 30-50 ms.
 */
- (int)pushExternalAudioFrameSampleBuffer:(AgoraAudioExternalSourcePos)sourcePos sampleBuffer:(CMSampleBufferRef _Nonnull)sampleBuffer;

#pragma mark External Video Data

/**-----------------------------------------------------------------------------
 * @name External Video Data (push-mode only)
 * -----------------------------------------------------------------------------
 */

/** Configures the external video source.

 @note Call this method before joining a channel.

 @param enable Sets whether to use an external video source:

 * YES: Use an external video source.
 * NO: (Default) Do not use an external video source.

 @param useTexture Sets whether to use texture as an input:

 * YES: Use texture as an input.
 * NO: Do not use texture as an input.

 @param pushMode Sets whether or not the external video source needs to call the [pushExternalVideoFrame](pushExternalVideoFrame:) method to send the video frame to the SDK:

 * YES: Use the push mode.
 * NO: Use the pull mode (not supported yet).
 */
- (void)setExternalVideoSource:(BOOL)enable useTexture:(BOOL)useTexture pushMode:(BOOL)pushMode;

/** Pushes the external video frame.

 This method pushes the video frame using the AgoraVideoFrame class and passes the video frame to the SDK with the `format` parameter found in AgoraVideoFrame.
 Call the [setExternalVideoSource](setExternalVideoSource:useTexture:pushMode:) method and set the `pushMode` parameter as `YES` before calling this method. Otherwise, a failure returns after calling this method.

 @note The SDK does not support the alpha channel, and discards any alpha value passed to the SDK.

 @param frame Video frame containing the SDK's encoded video data to be pushed. See AgoraVideoFrame.
 @return * YES: The frame is pushed successfully.
 * NO: Fails to push the frame.
 */
- (BOOL)pushExternalVideoFrame:(AgoraVideoFrame* _Nonnull)frame;

#pragma mark Raw Audio Data

/**-----------------------------------------------------------------------------
 * @name Raw Audio Data
 * -----------------------------------------------------------------------------
 */

/** Sets the audio sampling format.

This method sets the audio format of the `onRecordAudioFrame` callback. See *Raw Audio Data*.

Ensure that you call this method before joining a channel.

@note The SDK calculates the sample interval according to the value of the `sampleRate`, `channel`, and `samplesPerCall` parameters you set in this method. Sample interval (sec) = `samplePerCall`/(`sampleRate` * `channel`). Ensure that the value of sample interval is no less than 0.01. The SDK triggers the `onRecordAudioFrame` callback according to the sample interval.

 @param sampleRate     Sets the audio sample rate (`samplesPerSec`) returned in the `onRecordAudioFrame` callback, which can be set as 8000, 16000, 32000, 44100, or 48000 Hz.
 @param channel        Sets the number of audio channels (`channels`) returned in the `onRecordAudioFrame` callback, which can be set as 1 or 2:

- 1: Mono
- 2: Stereo
 @param mode      Sets the use mode of the `onRecordAudioFrame` callback. See AgoraAudioRawFrameOperationMode.
 @param samplesPerCall Sets the number of samples the `onRecordAudioFrame` callback returns. Set it as 1024 for RTMP or RTMPS streaming.


 @return * 0: Success.
 * < 0: Failure.
 */
- (int)setRecordingAudioFrameParametersWithSampleRate:(NSInteger)sampleRate channel:(NSInteger)channel mode:(AgoraAudioRawFrameOperationMode)mode samplesPerCall:(NSInteger)samplesPerCall;
/** Sets the audio playback format.

This method sets the audio format of the `onPlaybackAudioFrame` callback. See *Raw Audio Data*.

Ensure that you call this method before joining a channel.

@note The SDK calculates the sample interval according to the value of the `sampleRate`, `channel`, and `samplesPerCall` parameters you set in this method. Sample interval (sec) = `samplePerCall`/(`sampleRate` * `channel`). Ensure that the value of sample interval is no less than 0.01. The SDK triggers the `onPlaybackAudioFrame` callback according to the sample interval.

 @param sampleRate     Sets the sample rate (`samplesPerSec`) returned in the `onPlaybackAudioFrame` callback, which can be set as 8000, 16000, 32000, 44100, or 48000 Hz.
 @param channel        Sets the number of audio channels (`channels`) returned in the `onPlaybackAudioFrame` callback, which can be set as 1 or 2:

  * 1: Mono
  * 2: Stereo
 @param mode           Sets the use mode of the `onPlaybackAudioFrame` callback. See AgoraAudioRawFrameOperationMode.
 @param samplesPerCall Sets the number of samples the `onPlaybackAudioFrame` callback returns. Set it as 1024 for RTMP or RTMPS streaming.

 @return * 0: Success.
 * < 0: Failure.
 */
- (int)setPlaybackAudioFrameParametersWithSampleRate:(NSInteger)sampleRate channel:(NSInteger)channel mode:(AgoraAudioRawFrameOperationMode)mode samplesPerCall:(NSInteger)samplesPerCall;

/** Sets the format of the mixed sampled and playback audio frame.

This method sets the audio format of the `onMixedAudioFrame` callback. See *Raw Audio Data*.

Ensure that you call this method before joining a channel.

@note The SDK calculates the sample interval according to the value of the `sampleRate`, `channel`, and `samplesPerCall` parameters you set in this method. Sample interval (sec) = `samplePerCall`/(`sampleRate` * `channel`). Ensure that the value of sample interval is no less than 0.01. The SDK triggers the `onMixedAudioFrame` callback according to the sample interval.

 @param sampleRate     Sets the sample rate (`samplesPerSec`) returned in the `onMixedAudioFrame` callback, which can be set as 8000, 16000, 32000, 44100, or 48000 Hz.
 @param samplesPerCall Sets the number of samples the `onMixedAudioFrame` callback returns. Set it as 1024 for RTMP or RTMPS streaming.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)setMixedAudioFrameParametersWithSampleRate:(NSInteger)sampleRate samplesPerCall:(NSInteger)samplesPerCall;

/** Registers the raw audio data protocol.

 @since v3.4.5

 For the SDK to trigger the callbacks that provide the raw audio data, call this
 method to register the audio frame delegate. You need to implement
 `AgoraAudioDataFrameProtocol` in this method.

 **Note**

 - Ensure that you call this method before joining a channel.
 - To release the audio frame delegate, pass `nil` in the `delegate` parameter.
 Agora recommends calling `setAudioDataFrame(nil)` after
 receiving the
 [didLeaveChannelWithStats]([AgoraRtcEngineDelegate rtcEngine:didLeaveChannelWithStats:]) callback.

 @param delegate The delegate of the audio frame. See AgoraAudioDataFrameProtocol.

 @return * YES: Success.
 * NO: Failure.
 */
- (BOOL)setAudioDataFrame:(id<AgoraAudioDataFrameProtocol> _Nullable)delegate;

#pragma mark Watermark

/**-----------------------------------------------------------------------------
 * @name Watermark
 * -----------------------------------------------------------------------------
 */

/** Adds a watermark image to the local video.

 This method adds a PNG watermark image to the local video in the interactive live streaming. Once the watermark image is added, all the audience in the channel (CDN audience included), and the capturing device can see and capture it. Agora supports adding only one watermark image onto the local video, and the newly watermark image replaces the previous one.

 The watermark position depends on the settings in the [setVideoEncoderConfiguration]([AgoraRtcEngineKit setVideoEncoderConfiguration:]) method:

 - If the orientation mode of the encoding video is AgoraVideoOutputOrientationModeFixedLandscape, or the landscape mode in AgoraVideoOutputOrientationModeAdaptative, the watermark uses the landscape orientation.
 - If the orientation mode of the encoding video is AgoraVideoOutputOrientationModeFixedPortrait, or the portrait mode in AgoraVideoOutputOrientationModeAdaptative, the watermark uses the portrait orientation.
 - When setting the watermark position, the region must be less than the dimensions set in the [setVideoEncoderConfiguration]([AgoraRtcEngineKit setVideoEncoderConfiguration:]) method. Otherwise, the watermark image will be cropped.

 **Note**

 - Ensure that you have called the [enableVideo]([AgoraRtcEngineKit enableVideo]) method to enable the video module before calling this method.
 - If you only want to add a watermark image to the local video for the audience in the CDN live streaming channel to see and capture, you can call this method or the [setLiveTranscoding]([AgoraRtcEngineKit setLiveTranscoding:]) method.
 - This method supports adding a watermark image in the PNG file format only. Supported pixel formats of the PNG image are RGBA, RGB, Palette, Gray, and Alpha_gray.
 - If the dimensions of the PNG image differ from your settings in this method, the image will be cropped or zoomed to conform to your settings.
 - If you have enabled the local video preview by calling the [startPreview]([AgoraRtcEngineKit startPreview]) method, you can use the `visibleInPreview` member in the WatermarkOptions class to set whether or not the watermark is visible in preview.
 - If you have enabled the mirror mode for the local video, the watermark on the local video is also mirrored. To avoid mirroring the watermark, Agora recommends that you do not use the mirror and watermark functions for the local video at the same time. You can implement the watermark function in your application layer.

 @param url The local file path of the watermark image to be added. This method supports adding a watermark image from the local file path. If the watermark image to be added is in the project file, you need to change the image's Type from PNG image to Data in the Xcode property, otherwise, the Agora Native SDK cannot recognize the image.
 @param options The options of the watermark image to be added. See WatermarkOptions.

 @return * 0: Success.
 * < 0: Failure.
 */
- (int)addVideoWatermark:(NSURL* _Nonnull)url options:(WatermarkOptions* _Nonnull)options;

/** Removes the watermark image from the video stream added by [addVideoWatermark]([AgoraRtcEngineKit addVideoWatermark:options:]).

 @return * 0: Success.
* < 0: Failure.
 */
- (int)clearVideoWatermarks;

#pragma mark Stream Fallback

/**-----------------------------------------------------------------------------
 * @name Stream Fallback
 * -----------------------------------------------------------------------------
 */

/** Sets the priority of a remote user's stream.

The SDK ensures the high-priority user gets the best possible stream quality.

**Note:**

The SDK supports setting userPriority as high for one user only.

 @param uid        The ID of the remote user.
 @param userPriority The priority of the remote user, see [AgoraUserPriority](AgoraUserPriority).
 @return * 0: Success.
 * <0: Failure.
 */
- (int)setRemoteUserPriority:(NSUInteger)uid type:(AgoraUserPriority)userPriority;

/** Sets the fallback option for the locally published video stream based on the network conditions.

The default setting for `option` is `AgoraStreamFallbackOptionDisabled`, where there is no fallback behavior for the locally published video stream when the uplink network conditions are unreliable.

If `option` is set as `AgoraStreamFallbackOptionAudioOnly`, the SDK will:

 * Disable the upstream video but enable audio only when the network conditions deteriorate and cannot support both video and audio.
 * Re-enable the video when the network conditions improve.

 When the published video stream falls back to audio only or when the audio-only stream switches back to the video, the SDK triggers the [didLocalPublishFallbackToAudioOnly]([AgoraRtcEngineDelegate rtcEngine:didLocalPublishFallbackToAudioOnly:]) callback.

 Ensure that you call this method before joining a channel.

 **Note:**

 Agora does not recommend using this method for CDN live streaming, because the remote CDN live user will have a noticeable lag when the published video stream falls back to audio-only.

 @param option Sets the fallback option for the published video stream. The default value is AgoraStreamFallbackOptionDisabled. See AgoraStreamFallbackOptions.
 @return * 0: Success.
* < 0: Failure.
 */
- (int)setLocalPublishFallbackOption:(AgoraStreamFallbackOptions)option;

/** Sets the fallback option for the remotely subscribed video stream based on the network conditions.

The default setting for `option` is `AgoraStreamFallbackOptionVideoStreamLow`, where the remotely subscribed video stream falls back to the low-stream (low resolution and low bitrate) video under unreliable downlink network conditions.

If `option` is set as `AgoraStreamFallbackOptionAudioOnly`, the SDK automatically switches the video from a high stream to a low stream, or disables the video when the downlink network conditions cannot support both audio and video to guarantee the quality of the audio. The SDK monitors the network quality and re-enables the video stream when the network conditions improve.
 When the remotely subscribed video stream falls back to audio only or when the audio-only stream switches back to the video, the SDK triggers the [didRemoteSubscribeFallbackToAudioOnly]([AgoraRtcEngineDelegate  rtcEngine:didRemoteSubscribeFallbackToAudioOnly:byUid:]) callback.

Ensure that you call this method before joining a channel.

 @param option Sets the fallback option for the remotely subscribed video stream. The default value is `AgoraStreamFallbackOptionVideoStreamLow`. See AgoraStreamFallbackOptions.
 @return * 0: Success.
* < 0: Failure.
 */
- (int)setRemoteSubscribeFallbackOption:(AgoraStreamFallbackOptions)option;

#pragma mark Dual-stream Mode

/**-----------------------------------------------------------------------------
 * @name Dual-stream Mode
 * -----------------------------------------------------------------------------
 */

/** Enables/Disables dual-stream mode. (Interactive live streaming only.)

If dual-stream mode is enabled, the receiver can choose to receive the high-stream (high-resolution high-bitrate) or low-stream (low-resolution low-bitrate) video.

You can call this method either before or after joining a channel.

 @param enabled Sets the stream mode:

 * YES: Dual-stream mode.
 * NO: Single-stream mode.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)enableDualStreamMode:(BOOL)enabled;

/** Sets the stream type of the remote video.

 Under limited network conditions, if the publisher has not disabled the dual-stream mode using [enableDualStreamMode(NO)]([AgoraRtcEngineKit enableDualStreamMode:])enableDualStreamMode(NO), the receiver can choose to receive either the high-quality video stream (the high resolution, and high bitrate video stream) or the low-quality video stream (the low resolution, and low bitrate video stream).

 By default, users receive the high-quality video stream. Call this method if you want to switch the remote stream type to reduce the bandwidth and resources.

 The aspect ratio of the low-quality video stream is the same as the high-quality video stream. Once the resolution of the high-quality video stream is set, the system automatically sets the resolution, frame rate, and bitrate of the low-quality video stream.

 The SDK reports the result of calling this method in the [didApiCallExecute]([AgoraRtcEngineDelegate rtcEngine:didApiCallExecute:api:result:]) callback.

 @note You can call this method either before or after joining a channel. If you call both `setRemoteVideoStream` and [setRemoteDefaultVideoStreamType]([AgoraRtcEngineKit setRemoteDefaultVideoStreamType:]), the SDK applies the settings in the `setRemoteVideoStream` method.

 @param uid        ID of the remote user sending the video stream.
 @param streamType  Sets the video-stream type. See AgoraVideoStreamType.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)setRemoteVideoStream:(NSUInteger)uid type:(AgoraVideoStreamType)streamType;

/** Sets the default video-stream type for the video received by the local user when the remote user sends dual streams.

 @note You can call this method either before or after joining a channel. If you call both `setRemoteDefaultVideoStreamType` and [setRemoteVideoStream]([AgoraRtcEngineKit setRemoteVideoStream:type:]), the SDK applies the settings in the `setRemoteDefaultVideoStreamType` method.

 @param streamType Sets the default video-stream type. See AgoraVideoStreamType.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)setRemoteDefaultVideoStreamType:(AgoraVideoStreamType)streamType;

#pragma mark Encryption

/**-----------------------------------------------------------------------------
 * @name Encryption
 * -----------------------------------------------------------------------------
 */

/** Enables/Disables the built-in encryption.

 @since v3.1.0

 In scenarios requiring high security, Agora recommends calling
 `enableEncryption` to enable the built-in encryption before joining a channel.

 After a user leaves the channel, the SDK automatically disables the built-in
 encryption. To re-enable the built-in encryption, call this method before the
 user joins the channel again.

 As of v3.4.5, Agora recommends using either the `AgoraEncryptionModeAES128GCM2`
 or `AgoraEncryptionModeAES256GCM2` encryption mode, both of which support
 adding a salt and are more secure. For details, see *Media Stream Encryption*.

 @warning All users in the same channel must use the same encryption mode,
 encryption key, and salt; otherwise, users cannot communicate with each other.

 **Note**:

 - If you enable the built-in encryption, you cannot use the RTMP or RTMPS
 streaming function.
 - To enhance security, Agora recommends using a new key and salt every time
 you enable the media stream encryption.

 @param enabled Whether to enable the built-in encryption:

 - YES: Enable the built-in encryption.
 - NO: Disable the built-in encryption.

 @param config Configurations of built-in encryption schemas. See AgoraEncryptionConfig.

 @return - 0: Success.
 - < 0: Failure.

  - -2 (`AgoraErrorCodeInvalidArgument`): An invalid parameter is used. Set the parameter with a valid value.
  - -7 (`AgoraErrorCodeNotInitialized`): The SDK is not initialized. Initialize the `AgoraRtcEngineKit` instance before calling this method.
  - -4 (`AgoraErrorCodeNotSupported`): The encryption mode is incorrect or the SDK fails to load the external encryption library. Check the enumeration or reload the external encryption library.
 */
- (int)enableEncryption:(bool)enabled encryptionConfig:(AgoraEncryptionConfig* _Nonnull)config;

#pragma mark Inject an Online Media Stream

/**-----------------------------------------------------------------------------
 * @name Inject an Online Media Stream
 * -----------------------------------------------------------------------------
 */

/** Adds a voice or video stream CDN streaming URL to the interactive live streaming.

 The [streamPublishedWithUrl]([AgoraRtcEngineDelegate rtcEngine:streamPublishedWithUrl:errorCode:]) callback returns the inject stream status.

 If this method call is successful, the server pulls the voice or video stream and injects it into a live channel. This is applicable to scenarios where all audience members in the channel can watch a live show and interact with each other.

 The `addInjectStreamUrl` method call triggers the following callbacks:

 - The local client:

   - [streamInjectedStatusOfUrl]([AgoraRtcEngineDelegate rtcEngine:streamInjectedStatusOfUrl:uid:status:]), with the state of the injecting the online stream.
   - [didJoinedOfUid]([AgoraRtcEngineDelegate rtcEngine:didJoinedOfUid:elapsed:])(uid: 666), if the method call is successful and the online media stream is injected into the channel.

 - The remote client:

   - [didJoinedOfUid]([AgoraRtcEngineDelegate rtcEngine:didJoinedOfUid:elapsed:])(uid: 666), if the method call is successful and the online media stream is injected into the channel.


 @warning Agora will soon stop the service for injecting online media streams on the client. If you have not implemented this service, Agora recommends that you do not use it.

 **Note:**

 - Ensure that you call this method after joining a channel.
 - You can inject only one media stream into the channel at the same time.
 - Ensure that you enable the RTMP Converter service before using this function. See [Prerequisites](https://docs.agora.io/en/Interactive%20Broadcast/cdn_streaming_apple?platform=iOS#prerequisites).
 - This method applies to the Native SDK v2.4.1 and later.
 @param url    URL address to be added to the ongoing interactive live streaming. Valid protocols are RTMP, HLS, and HTTP-FLV.

- Supported audio codec type: AAC.
- Supported video codec type: H264 (AVC).
 @param config AgoraLiveInjectStreamConfig object which contains the configuration information for the added voice or video stream.

@return * 0: Success.
* < 0: Failure.
    - `AgoraErrorCodeInvalidArgument`(-2): The injected URL does not exist. Call this method again to inject the stream and ensure that the URL is valid.
    - `AgoraErrorCodeNotReady`(-3): The user is not in the channel.
    - `AgoraErrorCodeNotSupported`(-4): The channel profile is not Live Broadcast. Call the [setChannelProfile]([AgoraRtcEngineKit setChannelProfile:]) method and set the channel profile to Live Broadcast before calling this method.
    - `AgoraErrorCodeNotInitialized`(-7): The SDK is not initialized. Ensure that the RtcEngine object is initialized before using this method.

*/
- (int)addInjectStreamUrl:(NSString* _Nonnull)url config:(AgoraLiveInjectStreamConfig* _Nonnull)config;

/** Removes the voice or video stream CDN streaming URL from the interactive live streaming.

 This method removes the URL address (added by the [addInjectStreamUrl](addInjectStreamUrl:config:) method) from the interactive live streaming.

 If this method call is successful, the SDK triggers the [didOfflineOfUid]([AgoraRtcEngineDelegate rtcEngine:didOfflineOfUid:reason:]) callback and returns a stream uid of 666.

 @warning Agora will soon stop the service for injecting online media streams on the client. If you have not implemented this service, Agora recommends that you do not use it.

 @param url URL address of the added stream to be removed.
 @return * 0: Success.
 * < 0: Failure.
 */
- (int)removeInjectStreamUrl:(NSString* _Nonnull)url;

#pragma mark CDN Live Streaming

/**-----------------------------------------------------------------------------
 * @name CDN Live Streaming
 * -----------------------------------------------------------------------------
 */

/** Publishes the local stream to a specified CDN streaming URL.

 After calling this method, you can push media streams in RTMP or RTMPS protocol to the CDN. The SDK triggers the [rtmpStreamingChangedToState]([AgoraRtcEngineDelegate rtcEngine:rtmpStreamingChangedToState:state:errorCode:]) callback on the local client to report the state of adding a local stream to the CDN.

 **Note:**

 - This method applies to the interactive live streaming profile only.
 - Ensure that the user joins the channel before calling this method.
 - Ensure that you enable the RTMP Converter service before using this function. See [Prerequisites](https://docs.agora.io/en/Interactive%20Broadcast/cdn_streaming_apple?platform=iOS#prerequisites).
 - This method adds only one stream URL each time it is called.
 - Agora supports pushing media streams in RTMPS protocol to the CDN only when you enable transcoding.

 @param url  The CDN streaming URL in the RTMP or RTMPS format.  The maximum length of this parameter is 1024 bytes. The CDN streaming URL must not contain special characters, such as Chinese language characters.
 @param transcodingEnabled Sets whether transcoding is enabled/disabled:

 - YES: Enable transcoding. To [transcode](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#transcoding) the audio or video streams when publishing them to CDN live, often used for combining the audio and video streams of multiple hosts in CDN live. If you set this parameter as `YES`, ensure that you call the [setLiveTranscoding]([AgoraRtcEngineKit setLiveTranscoding:]) method before this method.
 - NO: Disable transcoding.

 @return * 0: Success.
 * < 0: Failure.

  - `AgoraErrorCodeInvalidArgument`(-2): Invalid parameter. The URL is nil or the string length is 0.
  - `AgoraErrorCodeNotInitialized`(-7): You have not initialized the RTC Engine when publishing the stream.
 */
- (int)addPublishStreamUrl:(NSString* _Nonnull)url transcodingEnabled:(BOOL)transcodingEnabled;

/** Removes an RTMP or RTMPS stream from the CDN.

This method removes the CDN streaming URL added by the [addPublishStreamUrl](addPublishStreamUrl:transcodingEnabled:) method from a CDN live stream.

This method call triggers the [rtmpStreamingChangedToState]([AgoraRtcEngineDelegate rtcEngine:rtmpStreamingChangedToState:state:errorCode:]) callback on the local client to report the state of removing an RTMP or RTMPS stream from the CDN.

 **Note:**

 * This method applies to the interactive live streaming profile only.
 * This method removes only one URL each time it is called.
 * The URL must not contain special characters, such as Chinese language characters.

 @param url The CDN streaming URL to be removed. The maximum length of this parameter is 1024 bytes.

 @return * 0: Success.
 * < 0: Failure.
 */
- (int)removePublishStreamUrl:(NSString* _Nonnull)url;

/** Sets the video layout and audio settings for CDN live. (CDN live only.)

 The SDK triggers the [rtcEngineTranscodingUpdated]([AgoraRtcEngineDelegate rtcEngineTranscodingUpdated:]) callback when you call the `setLiveTranscoding` method to update the transcoding setting.

 **Note**

 - Ensure that you call this method after joining a channel.
 - This method applies to the interactive live streaming profile only.
 - Ensure that you enable the RTMP Converter service before using this function. See [Prerequisites](https://docs.agora.io/en/Interactive%20Broadcast/cdn_streaming_apple?platform=iOS#prerequisites).
 - If you call the `setLiveTranscoding` method to update the transcoding setting for the first time, the SDK does not trigger the `rtcEngineTranscodingUpdated` callback.
 - Agora supports pushing media streams in RTMPS protocol to the CDN only when you enable transcoding.

 @param transcoding Sets the CDN live audio/video transcoding settings. See AgoraLiveTranscoding.

 @return * 0: Success.
 * < 0: Failure.
 */
- (int)setLiveTranscoding:(AgoraLiveTranscoding* _Nullable)transcoding;

#pragma mark Data Stream

/**-----------------------------------------------------------------------------
 * @name Data Stream
 * -----------------------------------------------------------------------------
 */

/** Creates a data stream.

 @since v3.3.0

 Each user can create up to five data streams in a single channel.

 This method does not support data reliability. If the receiver receives a data
 packet five seconds or more after it was sent, the SDK directly discards
 the data.

 @param streamId ID of the created data stream.
 @param config The configurations for the data stream: AgoraDataStreamConfig.

 @return * Returns the stream ID if you successfully create the data stream.
* < 0: Fails to create the data stream.
 */
- (int)createDataStream:(NSInteger* _Nonnull)streamId config:(AgoraDataStreamConfig* _Nonnull)config;

/** Sends data stream messages to all users in a channel.

The SDK has the following restrictions on this method:

* Up to 30 packets can be sent per second in a channel with each packet having a maximum size of 1 kB.
* Each client can send up to 6 kB of data per second.
* Each user can have up to five data streams simultaneously.

A successful sendStreamMessage method call triggers the [receiveStreamMessageFromUid]([AgoraRtcEngineDelegate rtcEngine:receiveStreamMessageFromUid:streamId:data:]) callback on the remote client, from which the remote user gets the stream message.

A failed sendStreamMessage method call triggers the [didOccurStreamMessageErrorFromUid]([AgoraRtcEngineDelegate rtcEngine:didOccurStreamMessageErrorFromUid:streamId:error:missed:cached:]) callback on the remote client.

 **Note:**

 - This method applies only to the Communication profile or to the hosts in the interactive live streaming profile. If an audience in the interactive live streaming profile calls this method, the audience role may be changed to a host.
 - Ensure that you have created the data stream using [createDataStream](createDataStream:reliable:ordered:) before calling this method.

 @param streamId ID of the sent data stream returned in the `createDataStream` method.
 @param data   Sent data.

 @return * 0: Success.
 * < 0: Failure.
*/
- (int)sendStreamMessage:(NSInteger)streamId data:(NSData* _Nonnull)data;

#pragma mark Miscellaneous Video Control

/**-----------------------------------------------------------------------------
 * @name Miscellaneous Video Control
 * -----------------------------------------------------------------------------
 */

/** Sets the camera capture preference.

For a video call or interactive live streaming, generally the SDK controls the camera output parameters. When the default camera capture settings do not meet special requirements or cause performance problems, we recommend using this method to set the camera capture preference:

* If the resolution or frame rate of the captured raw video data is higher than that set by [setVideoEncoderConfiguration]([AgoraRtcEngineKit setVideoEncoderConfiguration:]), processing video frames requires extra CPU and RAM usage and degrades performance. We recommend setting `configuration` as `AgoraCameraCaptureOutputPreferencePerformance(1)` to avoid such problems.
* If you do not need local video preview or are willing to sacrifice preview quality, we recommend setting `configuration` as `AgoraCameraCaptureOutputPreferencePerformance(1)` to optimize CPU and RAM usage.
* If you want better quality for the local video preview, we recommend setting `configuration` as `AgoraCameraCaptureOutputPreferencePreview(2)`.
* To customize the width and height of the video image captured by the local camera, set the camera capture configuration as `AgoraCameraCaptureOutputPreferenceManual(3)`.

**Note:**

Call this method before enabling the local camera. That said, you can call this method before calling `joinChannel`, `enableVideo`, or `enableLocalVideo`, depending on which method you use to turn on your local camera.

@param configuration The camera capturer configuration, see AgoraCameraCapturerConfiguration.

@return * 0: Success.
* < 0: Failure.
 */
- (int)setCameraCapturerConfiguration:(AgoraCameraCapturerConfiguration* _Nullable)configuration;

#if defined(TARGET_OS_IPHONE) && TARGET_OS_IPHONE
#pragma mark Camera Control

/**-----------------------------------------------------------------------------
 * @name Camera Control
 * -----------------------------------------------------------------------------
 */

/** Switches between front and rear cameras. (iOS only)

 @note Ensure that you call this method after the camera starts, for example, by calling [startPreview]([AgoraRtcEngineKit startPreview]) or [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]).

 @return * 0: Success.
* < 0: Failure.
 */
- (int)switchCamera;

/** Checks whether the camera zoom function is supported. (iOS only.)

 @note Ensure that you call this method after the camera starts, for example, by calling [startPreview]([AgoraRtcEngineKit startPreview]) or [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]).

 @return * YES: The device supports the camera zoom function.
 * NO: The device does not support the camera zoom function.
 */
- (BOOL)isCameraZoomSupported;

/** Checks whether the device supports enabling the flash. (iOS only.)

 The SDK uses the front camera by default, so if you call
 `isCameraTorchSupported` directly, you can find out from the return value
 whether the device supports enabling the flash when using the front camera.
 If you want to check whether the device supports enabling the flash when
 using the rear camera, call [switchCamera]([AgoraRtcEngineKit switchCamera])
 to switch the camera used by the SDK to the rear camera, and then call
 `isCameraTorchSupported`.

 **Note**

 - Call this method after the camera is started.
 - On iPads with system version 15, even if `isCameraTorchSupported`
 returns `YES`, you might fail to successfully enable the flash by calling
 [setCameraTorchOn]([AgoraRtcEngineKit setCameraTorchOn:]) due to system issues.


 @return * YES: The device supports enabling the flash.
 * NO: The device does not support enabling the flash.
 */
- (BOOL)isCameraTorchSupported;

/** Checks whether the camera manual focus function is supported. (iOS only)

 @note Ensure that you call this method after the camera starts, for example, by calling [startPreview]([AgoraRtcEngineKit startPreview]) or [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]).

 @return * YES: The device supports the camera manual focus function.
 * NO: The device does not support the camera manual focus function.
 */
- (BOOL)isCameraFocusPositionInPreviewSupported;

/** Checks whether the camera manual exposure function is supported. (iOS only)

 @note Ensure that you call this method after the camera starts, for example, by calling [startPreview]([AgoraRtcEngineKit startPreview]) or [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]).

 @return * YES: The device supports the manual exposure function.
 * NO: The device does not support the manual exposure function.
 */
- (BOOL)isCameraExposurePositionSupported;

/** Checks whether the camera auto-face focus function is supported. (iOS only)

 @note Ensure that you call this method after the camera starts, for example, by calling [startPreview]([AgoraRtcEngineKit startPreview]) or [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]).

 @return * YES: The device supports the camera auto-face focus function.
 * NO: The device does not support the camera auto-face focus function.
 */
- (BOOL)isCameraAutoFocusFaceModeSupported;

/** Sets the camera zoom ratio. (iOS only)

 @note Ensure that you call this method after the camera starts, for example, by calling [startPreview]([AgoraRtcEngineKit startPreview]) or [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]).

 @param zoomFactor Sets the camera zoom factor. The value ranges between 1.0 and the maximum zoom supported by the device.

 @return * The set camera zoom factor, if this method call is successful.
 * < 0: Failure.
 */
- (CGFloat)setCameraZoomFactor:(CGFloat)zoomFactor;

/** Sets the manual focus position. (iOS only)

 A successful setCameraFocusPositionInPreview method call triggers the o[cameraFocusDidChangedToRect]([AgoraRtcEngineDelegate rtcEngine:cameraFocusDidChangedToRect:]) callback on the local client.

 @note Ensure that you call this method after the camera starts, for example, by calling [startPreview]([AgoraRtcEngineKit startPreview]) or [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]).

 @param position Coordinates of the touch point in the view.

 @return * YES: Success.
* NO: Failure.
 */
- (BOOL)setCameraFocusPositionInPreview:(CGPoint)position;

/** Sets the camera exposure position. (iOS only)

 A successful setCameraExposurePosition method call triggers the [cameraExposureDidChangedToRect]([AgoraRtcEngineDelegate rtcEngine:cameraExposureDidChangedToRect:]) callback on the local client.

 @note Ensure that you call this method after the camera starts, for example, by calling [startPreview]([AgoraRtcEngineKit startPreview]) or [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]).

 @param positionInView Coordinates of the touch point in the view.

 @return * YES: Success.
 * NO: Failure.
 */
- (BOOL)setCameraExposurePosition:(CGPoint)positionInView;

/** Sets whether to enable the flash. (iOS only.)

 **Note**

 - Call this method after the camera is started.
 - On iPads with system version 15, even if [isCameraTorchSupported]([AgoraRtcEngineKit isCameraTorchSupported])
 returns `YES`, you might fail to successfully enable the flash by calling `setCameraTorchOn` due to system issues.

 @param isOn Determines whether to enable the flash:

 * YES: Enable the flash.
 * NO: Do not enable the flash.

 @return * YES: Success.
* NO: Failure.
 */
- (BOOL)setCameraTorchOn:(BOOL)isOn;

/** Sets whether to enable face autofocus. (iOS only.)

 The SDK earlier than v3.5.0 disables face autofocus by default. The SDK v3.5.0
 and later enables face autofocus by default. To set face autofocus, call this method.

 @note Call this method after the camera is started.

 @param enable Determines whether to enable face autofocus:

 * YES: Enable face autofocus.
 * NO: Disable face autofocus.

 @return * YES: Success.
* NO: Failure.
 */
- (BOOL)setCameraAutoFocusFaceModeEnabled:(BOOL)enable;

#endif

#if (!(TARGET_OS_IPHONE) && (TARGET_OS_MAC))
#pragma mark Screen Sharing

/**-----------------------------------------------------------------------------
 * @name Screen Sharing (macOS)
 * -----------------------------------------------------------------------------
 */

/** Shares the whole or part of a screen by specifying the display ID.  (macOS only.)

@note Ensure that you call this method after joining a channel.

@param displayId The display ID of the screen to be shared. Use this parameter to specify which screen you want to share.
For more information on how to get the display ID, see the advanced feature guide *Share the Screen* or get the display ID
from `sourceId` returned by [getScreenCaptureSourcesWithThumbSize]([AgoraRtcEngineKit getScreenCaptureSourcesWithThumbSize:iconSize:includeScreen:]).
@param rectangle (Optional) The relative location of the region to the screen. nil means sharing the whole screen. This parameter contains the following properties:

- x: the horizontal offset from the top-left corner.
- y: the vertical offset from the top-left corner.
- width: the width of the region.
- height: the height of the region.

If the specified region overruns the screen, the SDK shares only the region within it; if you set width or height as 0, the SDK shares the whole screen.
@param captureParams The screen sharing encoding parameters. The default video dimension is 1920 x 1080, that is, 2,073,600
pixels. Agora uses the value of `dimensions` to calculate the charges. For details, see descriptions in [AgoraScreenCaptureParameters](AgoraScreenCaptureParameters).

@return * 0: Success.
* < 0: Failure.

    - -2(AgoraErrorCodeInvalidArgument): the argument is invalid.
 */
- (int)startScreenCaptureByDisplayId:(NSUInteger)displayId rectangle:(CGRect)rectangle parameters:(AgoraScreenCaptureParameters* _Nonnull)captureParams;

/** Shares the whole or part of a window by specifying the window ID. (macOS only.)

@note Ensure that you call this method after joining a channel.

@param windowId The ID of the window to be shared. This parameter specifies which window you want to share. For information on how to get the windowId, see *Share the Screen*.
@param rectangle (Optional) The relative location of the region to the window. nil means sharing the whole window. This parameter contains the following properties:

- x: the horizontal offset from the top-left corner.
- y: the vertical offset from the top-left corner.
- width: the width of the region.
- height: the height of the region.

If the specified region overruns the window, the SDK shares only the region within it; if you set width or height as 0, the SDK shares the whole window.
@param captureParams The screen sharing encoding parameters. The default video dimension is 1920 x 1080, that is, 2,073,600
pixels. Agora uses the value of `dimensions` to calculate the charges. For details, see descriptions in [AgoraScreenCaptureParameters](AgoraScreenCaptureParameters).

@return * 0: Success.
* < 0: Failure.

    - -2(AgoraErrorCodeInvalidArgument): the argument is invalid.
 */
- (int)startScreenCaptureByWindowId:(NSUInteger)windowId rectangle:(CGRect)rectangle parameters:(AgoraScreenCaptureParameters* _Nonnull)captureParams;

/** Sets the content hint for screen sharing.

A content hint suggests the type of the content being shared, so that the SDK applies different optimization algorithm to different types of content.

You can call this method either before or after you start screen sharing.

@param contentHint The content hint for screen sharing, see [AgoraVideoContentHint](AgoraVideoContentHint).

@return * 0: Success.
* < 0: Failure.
*/
- (int)setScreenCaptureContentHint:(AgoraVideoContentHint)contentHint;

/** Updates the screen sharing parameters. (macOS only.)

@param captureParams The screen sharing encoding parameters. The default video dimension is 1920 x 1080, that is, 2,073,600
pixels. Agora uses the value of `dimensions` to calculate the charges. For details, see descriptions in [AgoraScreenCaptureParameters](AgoraScreenCaptureParameters).

@return * 0: Success.
* < 0: Failure.

    - -3(AgoraErrorCodeNotReady): no screen or windows is being shared.
 */
- (int)updateScreenCaptureParameters:(AgoraScreenCaptureParameters* _Nonnull)captureParams;

/** Updates the screen-sharing region. (macOS only.)

 @param rect The relative location of the region to the screen or window. nil means sharing the whole screen or window. This parameter contains the following properties:

- x: the horizontal offset from the top-left corner.
- y: the vertical offset from the top-left corner.
- width: the width of the region.
- height: the height of the region.

If the specified region overruns the screen or window, the SDK shares only the region within it; if you set width or height as 0, the SDK shares the whole screen or window.

@return * 0: Success.
* < 0: Failure.

    - -3(AgoraErrorCodeNotReady): no screen or windows is being shared.
*/
- (int)updateScreenCaptureRegion:(CGRect)rect;

/** Stops screen sharing. (macOS only.)

 @return * 0: Success.
* < 0: Failure.
 */
- (int)stopScreenCapture;

/**
 Gets a list of shareable screens and windows.

 @since v3.5.2

 You can call this method before sharing a screen or window to get a list of
 shareable screens and windows, which enables a user to use thumbnails in the
 list to easily choose a particular screen or window to share. This list also
 contains important information such as window ID and screen ID, with which you
 can call [startScreenCaptureByWindowId]([AgoraRtcEngineKit startScreenCaptureByWindowId:rectangle:parameters:])
 or [startScreenCaptureByDisplayId]([AgoraRtcEngineKit startScreenCaptureByDisplayId:rectangle:parameters:])
 to start the sharing.

 @note This method applies to macOS only.

 @param thumbSize The target size of the screen or window thumbnail. The width and height are in pixels. The SDK scales
 the original image to make the length of the longest side of the image the same as that of the target size without
 distorting the original image. For example, if the original image is 400 × 300 and `thumbSize` is 100 × 100, the
 actual size of the thumbnail is 100 × 75. If the target size is larger than the original size, the thumbnail is the
 original image and the SDK does not scale it.
 @param iconSize The target size of the icon corresponding to the application program. The width and height are in pixels.
 The SDK scales the original image to make the length of the longest side of the image the same as that of the target
 size without distorting the original image. For example, if the original image is 400 × 300 and `iconSize` is 100 × 100,
 the actual size of the icon is 100 × 75. If the target size is larger than the original size, the icon is the original
 image and the SDK does not scale it.
 @param includeScreen Whether the SDK returns screen information in addition to window information:

 - YES: The SDK returns screen and window information.
 - NO: The SDK returns window information only.

 @return AgoraScreenCaptureSourceInfo
 */
- (NSArray<AgoraScreenCaptureSourceInfo*>* _Nullable)getScreenCaptureSourcesWithThumbSize:(NSSize)thumbSize iconSize:(NSSize)iconSize includeScreen:(BOOL)includeScreen;

#endif

#if (!(TARGET_OS_IPHONE) && (TARGET_OS_MAC))
#pragma mark Device Manager (macOS)
/**-----------------------------------------------------------------------------
 * @name Device Manager (macOS only)
 * -----------------------------------------------------------------------------
 */

/** Monitors the change of a device state. (macOS only.)

 Use this method to monitor the plugging and swapping of external audio/video devices. For example, an external camera.

 @param enabled - YES: Enable the monitoring of a device state change.
 - NO: Disable the monitoring of a device state change.
 */
- (void)monitorDeviceChange:(BOOL)enabled;

/** Gets all devices in the system. (macOS only.)

 **Note:**

 Do not call this method in the main thread.

 This method returns an NSArray object, including all audio/video devices in the system.
 Your app can use the AgoraRtcDeviceInfo array object to enumerate the devices.

 @param type Device type: AgoraMediaDeviceType.
 @return An AgoraRtcDeviceInfo NSArray object including all devices, if this method call is successful.
 */
- (NSArray<AgoraRtcDeviceInfo*>* _Nullable)enumerateDevices:(AgoraMediaDeviceType)type;

/** Gets the information of devices, such as audio sampling and playback device. (macOS only.)

 @param type Device type: AgoraMediaDeviceType.
 @return * The device information (AgoraRtcDeviceInfo), if this method call is successful.
 * nil: Failure.
 */
- (AgoraRtcDeviceInfo* _Nullable)getDeviceInfo:(AgoraMediaDeviceType)type;

/** Sets the devices, such as audio sampling and playback device. (macOS only.)

 @param type    Device type: AgoraMediaDeviceType.
 @param deviceId Device ID of the device, which can be retrieved by calling the [enumerateDevices](enumerateDevices:)method. `deviceId` does not change when the device is plugged or unplugged.
 @return * 0: Success.
* < 0: Failure.
 */

- (int)setDevice:(AgoraMediaDeviceType)type deviceId:(NSString* _Nonnull)deviceId;

/** Gets the specified device's volume. (macOS only.)

 @param type Device type: AgoraMediaDeviceType.
 @return * Returns the volume, if this method call is successful.

* < 0: Failure.
 */
- (int)getDeviceVolume:(AgoraMediaDeviceType)type;

/** Sets the specified device's volume. (macOS only.)

 @note Call this method after joining a channel.

 @param type   Device type: AgoraMediaDeviceType
 @param volume Sets the specified device's volume. The value ranges between 0 and 100.
 @return * 0: Success.
* < 0: Failure.
 */
- (int)setDeviceVolume:(AgoraMediaDeviceType)type volume:(int)volume;

/** Starts the audio sampling device test. (macOS only)

 This method tests whether the audio sampling device works properly.

 After calling this method, the SDK triggers the
 [reportAudioVolumeIndicationOfSpeakers]([AgoraRtcEngineDelegate rtcEngine:reportAudioVolumeIndicationOfSpeakers:totalVolume:])
 callback at the time interval set in this method, which reports `uid` = 0 and the volume of the sampling device.

 @note Call this method before joining a channel.

 @param indicationInterval The time interval (ms) at which the `reportAudioVolumeIndicationOfSpeakers` callback returns.
 We recommend a setting greater than 200 ms. This value must not be less than 10 ms; otherwise, you can not receive the
 `reportAudioVolumeIndicationOfSpeakers` callback.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)startRecordingDeviceTest:(int)indicationInterval;

/** Stops the microphone test. (macOS only.)

 This method stops testing the microphone. You must call this method to stop the test after calling the [startRecordingDeviceTest](startRecordingDeviceTest:) method.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)stopRecordingDeviceTest;

/** Starts the audio playback device test. (macOS only)

This method tests if the audio playback device works properly. Once a user starts the test, the SDK plays an audio file
specified by the user. If the user can hear the audio, the playback device works properly.

After calling this method, the SDK triggers the
[reportAudioVolumeIndicationOfSpeakers]([AgoraRtcEngineDelegate rtcEngine:reportAudioVolumeIndicationOfSpeakers:totalVolume:])
callback every 100 ms, which reports `uid` = 1 and the volume of the playback device.

@note Call this method before joining a channel.

@param audioFileName Absolute path of the audio file for the test in UTF-8:

- Supported file formats: wav, mp3, m4a, and aac.
- Supported file sample rates: 8000, 16000, 32000, 44100, and 48000 Hz.

@return * 0: Success.
* < 0: Failure.
*/
- (int)startPlaybackDeviceTest:(NSString* _Nonnull)audioFileName;

/** Stops the audio playback device test. (macOS only.)

 This method stops testing the audio playback device. You must call this method to stop the test after calling the [startPlaybackDeviceTest](startPlaybackDeviceTest:) method.

 @note Call this method before joining a channel.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)stopPlaybackDeviceTest;

/** Starts a video-capture device test. (macOS only.)

 This method tests whether the video-capture device works properly. Ensure that you call the [enableVideo]([AgoraRtcEngineKit enableVideo]) method before calling this method and that the parameter view window is valid.

 @param view Input parameter for displaying the video window.

 @note Call this method before joining a channel.

 @return * 0: Success.
* < 0: Failure.

 */
- (int)startCaptureDeviceTest:(NSView* _Nonnull)view;

/** Stops the video-capture device test. (macOS only.)

 This method stops testing the video-capture device. You must call this method to stop the test after calling the [startCaptureDeviceTest](startCaptureDeviceTest:) method.

 @note Call this method before joining a channel.

 @return * 0: Success.
* < 0: Failure.

 */
- (int)stopCaptureDeviceTest;

/** Starts the audio device loopback test. (macOS only)

This method tests whether the local audio sampling device and playback device are working properly. After calling this method,
the audio sampling device samples the local audio, and the audio playback device plays the sampled audio. The SDK triggers
two independent
[reportAudioVolumeIndicationOfSpeakers]([AgoraRtcEngineDelegate rtcEngine:reportAudioVolumeIndicationOfSpeakers:totalVolume:])
callbacks at the time interval set in this method, which reports the following information:

- `uid` = 0 and the volume information of the sampling device.
- `uid` = 1 and the volume information of the playback device.

**Note:**

- This method tests the local audio devices and does not report the network conditions.
- Call this method before joining a channel.

@param indicationInterval The time interval (ms) at which the `reportAudioVolumeIndicationOfSpeakers` callback returns.
We recommend a setting greater than 200 ms. This value must not be less than 10 ms; otherwise, you can not receive the
`reportAudioVolumeIndicationOfSpeakers` callback.

@return * 0: Success.
* < 0: Failure.
*/
- (int)startAudioDeviceLoopbackTest:(int)indicationInterval;

/** Stops the audio device loopback test. (macOS only.)

 Ensure that you call this method to stop the loopback test after calling the [startAudioDeviceLoopbackTest]([AgoraRtcEngineKit startAudioDeviceLoopbackTest:]) method.

 @note Call this method before joining a channel.

 @return * 0: Success.
* < 0: Failure.
*/
- (int)stopAudioDeviceLoopbackTest;
#endif

#pragma mark Custom Media Metadata

/**-----------------------------------------------------------------------------
 * @name Media Metadata
 * -----------------------------------------------------------------------------
 */

/** Sets the data source of the metadata.

 You need to implement the [AgoraMediaMetadataDataSource](AgoraMediaMetadataDataSource) protocol and specify the type of metadata in this method.

 Use this method with the [setMediaMetadataDelegate]([AgoraRtcEngineKit setMediaMetadataDelegate:withType:]) method to add synchronized metadata in the video stream. You can create more diversified interactive live streaming interactions, such as sending shopping links, digital coupons, and online quizzes.

 **Note**

 - Call this method before the [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) method.
 - This method applies to the interactive live streaming channel profile only.

 @param metadataDataSource The AgoraMediaMetadataDataSource protocol.
 @param type The metadata type. See [AgoraMetadataType](AgoraMetadataType). Currently, the SDK supports video metadata only.
 @return * YES: Success.
 * NO: Failure.
 */
- (BOOL)setMediaMetadataDataSource:(id<AgoraMediaMetadataDataSource> _Nullable)metadataDataSource withType:(AgoraMetadataType)type;

/** Sets the delegate of the metadata.

 You need to implement the AgoraMediaMetadataDelegate protocol and specify the type of metadata in this method.

 **Note**

 - Call this method before the [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) method.
 - This method applies to the interactive live streaming channel profile only.

 @param metadataDelegate The AgoraMediaMetadataDelegate protocol.
 @param type The metadata type. See [AgoraMetadataType](AgoraMetadataType). Currently, the SDK supports video metadata only.
 @return * YES: Success.
 * NO: Failure.
 */
- (BOOL)setMediaMetadataDelegate:(id<AgoraMediaMetadataDelegate> _Nullable)metadataDelegate withType:(AgoraMetadataType)type;

#pragma mark Miscellaneous Methods

/**-----------------------------------------------------------------------------
 * @name Miscellaneous Methods
 * -----------------------------------------------------------------------------
 */

/** Gets the information of a specified audio file.

 @since v3.5.1

 After calling this method successfully, the SDK triggers the
 [didRequestAudioFileInfo]([AgoraRtcEngineDelegate rtcEngine:didRequestAudioFileInfo:error:])
 callback to report the information of an audio file, such as audio duration.
 You can call this method multiple times to get the information of multiple
 audio files.

  **Note**

 - Call this method after joining a channel.
 - For the audio file formats supported by this method, see
 [What formats of audio files does the Agora RTC SDK support](https://docs.agora.io/en/faq/audio_format).

 @param filePath The absolute path or URL address (including the filename extensions)
 of the audio file. For example: `/var/mobile/Containers/Data/audio.mp4`.

 @return * 0: Success.
 * < 0: Failure.
 */
- (int)getAudioFileInfo:(NSString* _Nullable)filePath;

/** Gets the current call ID.

 When a user joins a channel on a client, a `callId` is generated to identify the call from the client. Feedback methods, such as the [rate](rate:rating:description:) and [complain](complain:description:) methods, must be called after the call ends to submit feedback to the SDK.

 The [rate](rate:rating:description:) and [complain](complain:description:) methods require the `callId` parameter retrieved from the `getCallId` method during a call. *callId* is passed as an argument into the [rate](rate:rating:description:) and [complain](complain:description:) methods after the call ends.

 @note Ensure that you call this method after joining a channel.

 @return callId The current call ID.
 */
- (NSString* _Nullable)getCallId;

/** Allows a user to rate a call after the call ends.

 @note Ensure that you call this method after leaving a channel.

 @param callId      Call ID retrieved from the [getCallId]([AgoraRtcEngineKit getCallId]) method.
 @param rating      Rating of the call. The value is between 1 (lowest score) and 5 (highest score). If you set a value out of this range, the AgoraErrorCodeInvalidArgument(-2) error occurs.
 @param description (Optional) Description of the rating. The string length must be less than 800 bytes.

 @return * 0: Success.
 * < 0: Failure.

     * Return AgoraErrorCodeInvalidArgument(-2)：The passed argument is invalid. For example, `callId` is invalid.
     * Return AgoraErrorCodeNotReady(-3)：The SDK status is incorrect. For example, initialization fails.
 */
- (int)rate:(NSString* _Nonnull)callId rating:(NSInteger)rating description:(NSString* _Nullable)description;

/** Allows a user to complain about the call quality after a call ends.

 @note Ensure that you call this method after leaving a channel.

 @param callId      Call ID retrieved from the getCallId method.
 @param description (Optional) Description of the complaint. The string length must be less than 800 bytes.

 @return * 0: Success.
 * < 0: Failure.

  * -2(AgoraErrorCodeInvalidArgument): The parameter is invalid.
  * -3(AgoraErrorCodeNotReady): The SDK fails to be initialized. You can try re-initializing the SDK.
 */
- (int)complain:(NSString* _Nonnull)callId description:(NSString* _Nullable)description;

/** Enables/Disables dispatching delegate methods to the main queue.

 If disabled, the app should dispatch UI operations to the main queue.

 @param enabled Sets whether to dispatch delegate methods to the main queue:

 * YES: Dispatch delegate methods to the main queue.
 * NO: Do not dispatch delegate methods to the main queue

 @return * 0: Success.
* < 0: Failure.
 */
- (int)enableMainQueueDispatch:(BOOL)enabled;

/** Gets the SDK version.

 This method returns the string of the version number.

 @note You can call this method either before or after joining a channel.

 @return The version of the current SDK in the string format. For example, 2.3.0
 */
+ (NSString* _Nonnull)getSdkVersion;

/** Gets the description of a warning or error code.

 @param code The warning or error code that the [didOccurWarning]([AgoraRtcEngineDelegate rtcEngine:didOccurWarning:]) or [didOccurError]([AgoraRtcEngineDelegate rtcEngine:didOccurError:]) callback returns.

 @return AgoraWarningCode or AgoraErrorCode.
 */
+ (NSString* _Nullable)getErrorDescription:(NSInteger)code;

- (NSString* _Nullable)uploadLogFile;

/** Agora supports reporting and analyzing customized messages.

 @since 3.1.0

 This function is in the beta stage with a free trial.
 The ability provided in its beta test version is reporting a maximum of 10 message pieces within 6 seconds,
 with each message piece not exceeding 256 bytes and each string not exceeding 100 bytes.
 To try out this function, contact [support@agora.io](mailto:support@agora.io) and discuss the format of customized messages with us.
 */
- (int)sendCustomReportMessage:(NSString* _Nonnull)id category:(NSString* _Nonnull)category event:(NSString* _Nonnull)event label:(NSString* _Nonnull)label value:(NSInteger)value;

/** Returns the native handler of the SDK engine.

 This interface is used to get the native C++ handler of the SDK engine used in special scenarios, such as registering the audio and video frame observer.
 */
- (void* _Nullable)getNativeHandle;

/** Sets and gets the SDK delegate.

 The SDK uses the delegate to inform the app on engine runtime events. All methods defined in the delegate are optional implementation methods.

 */
@property(nonatomic, weak) id<AgoraRtcEngineDelegate> _Nullable delegate;

#pragma mark Customized Methods (Technical Preview)

- (int)setParameters:(NSString* _Nonnull)options;

- (NSString* _Nullable)getParameter:(NSString* _Nonnull)parameter args:(NSString* _Nullable)args;

/**
 Takes a snapshot of a video stream.

 @since v3.5.2

 This method takes a snapshot of a video stream from the specified user, generates a JPG image, and saves it to the specified path.

 The method is asynchronous, and the SDK has not taken the snapshot when the method call returns.
 After a successful method call, the SDK triggers the [snapshotTaken]([AgoraRtcEngineDelegate rtcEngine:snapshotTaken:uid:filePath:width:height:errCode:]) callback to report whether the snapshot is successfully
 taken as well as the details of the snapshot taken.

 **Notes:**

 - Call this method after joining a channel.
 - If the video of the specified user is pre-processed, for example, added with watermarks or image enhancement effects, the generated snapshot also includes the pre-processing effects.

 @param channel The channel name.
 @param uid The user ID of the user. Set uid as 0 if you want to take a snapshot of the local user's video.
 @param filePath The local path (including the filename extensions) of the snapshot.
 For example, `/App Sandbox/Library/Caches/example.jpg` on iOS and `～/Library/Logs/example.jpg` on macOS.
 Ensure that the path you specify exists and is writable.

 @return - 0: Success.
 - < 0: Failure.
 */
- (NSInteger)takeSnapshot:(NSString* _Nonnull)channel uid:(NSInteger)uid filePath:(NSString* _Nonnull)filePath;

- (int)enableContentInspect:(BOOL)enabled config:(AgoraContentInspectConfig* _Nonnull)config;

#pragma mark Deprecated Methods

/**-----------------------------------------------------------------------------
 * @name Deprecated Methods
 * -----------------------------------------------------------------------------
 */

/** Pushes the external raw audio frame data to the SDK for encoding.

 **Deprecated**This method is deprecated as of v3.5.1.
 Use [pushExternalAudioFrameRawData]([AgoraRtcEngineKit pushExternalAudioFrameRawData:frame:]) 2 instead.

 @param data      External audio data to be pushed.
 @param samples   Number of samples for the push.
 @param timestamp The timestamp (ms) of the external audio frame. It is mandatory. You can use this parameter for the following purposes:

 - Restore the order of the captured audio frame.
 - Synchronize audio and video frames in video-related scenarios, including scenarios where external video sources are used.
 @return * YES: Success.
* NO: Failure.
 */
- (BOOL)pushExternalAudioFrameRawData:(void* _Nonnull)data samples:(NSUInteger)samples timestamp:(NSTimeInterval)timestamp __deprecated_msg("use pushExternalAudioFrameRawData:sourcePos:frame instead.");

/** Pushes the external CMSampleBuffer audio frame to the SDK for encoding.

 **Deprecated**This method is deprecated as of v3.5.1.
 Use [pushExternalAudioFrameSampleBuffer]([AgoraRtcEngineKit pushExternalAudioFrameSampleBuffer:sampleBuffer:]) 2 instead.

 @param sampleBuffer Sample buffer for the push.
 @return * YES: Success.
* NO: Failure.
 */
- (BOOL)pushExternalAudioFrameSampleBuffer:(CMSampleBufferRef _Nonnull)sampleBuffer __deprecated_msg("use pushExternalAudioFrameSampleBuffer:sourcePos:sampleBuffer instead.");

/** Gets the total duration of the current music file.

 **Deprecated** This method is deprecated as of v3.5.1. Use
 [getAudioFileInfo]([AgoraRtcEngineKit getAudioFileInfo:]) instead.

 @since v3.4.0
 @note Call this method after [startAudioMixing]([AgoraRtcEngineKit startAudioMixing:loopback:replace:cycle:startPos:]).
 @return * &ge; 0: A successful method call. Returns the total duration (ms) of the current music file.
* < 0: Failure.
 */
- (int)getAudioMixingDuration __deprecated_msg("use getAudioFileInfo:filePath instead.");

/** Plays a specified audio effect.

**Deprecated** from v3.4.0. Use [playEffect]([AgoraRtcEngineKit playEffect:filePath:loopCount:pitch:pan:gain:publish:startPos:])3 instead.

You can use this method to add specific audio effects for specific scenarios, for example, gaming.

With this method, you can set the loop count, pitch, pan, and gain of the audio effect file and whether the remote user can hear the audio effect.

To play multiple audio effect files simultaneously, call this method multiple times with different soundIds and filePaths. We recommend playing no more than three audio effect files at the same time.

When the audio effect file playback is finished, the SDK triggers the [rtcEngineDidAudioEffectFinish]([AgoraRtcEngineDelegate rtcEngineDidAudioEffectFinish:soundId:]) callback.

  **Note**

 - Call this method after joining a channel.
 - For the audio file formats supported by this method, see
 [What formats of audio files does the Agora RTC SDK support](https://docs.agora.io/en/faq/audio_format).

 @param soundId ID of the specified audio effect. Each audio effect has a unique ID.
 If the audio effect is preloaded into the memory through the [preloadEffect](preloadEffect:filePath:) method, ensure that the `soundId` value is set to the same value as in [preloadEffect](preloadEffect:filePath:).
 @param filePath The absolute path or URL address (including the filename extensions)
 of the audio file. For example: `/var/mobile/Containers/Data/audio.mp4`.
 @param loopCount Sets the number of times the audio effect loops:

 * 0: Plays the audio effect once.
 * 1: Plays the audio effect twice.
 * -1: Plays the audio effect in an indefinite loop until you call the [stopEffect](stopEffect:) or [stopAllEffects](stopAllEffects) method.

 @param pitch Sets the pitch of the audio effect. The value ranges between 0.5 and 2. The default value is 1 (no change to the pitch). The lower the value, the lower the pitch.
 @param pan Sets the spatial position of the audio effect. The value ranges between -1.0 and 1.0.

 * 0.0: The audio effect displays ahead.
 * 1.0: The audio effect displays to the right.
 * -1.0: The audio effect displays to the left.

 @param gain Sets the volume of the audio effect. The value ranges between 0.0 and 100.0 (default). The lower the value, the lower the volume of the audio effect.
 @param publish Sets whether to publish the specified audio effect to the remote stream:

 * YES: The played audio effect is published to the Agora Cloud and the remote users can hear it.
 * NO: The played audio effect is not published to the Agora Cloud and the remote users cannot hear it.
 @return * 0: Success.
* < 0: Failure.
 */
- (int)playEffect:(int)soundId filePath:(NSString* _Nullable)filePath loopCount:(int)loopCount pitch:(double)pitch pan:(double)pan gain:(double)gain publish:(BOOL)publish __deprecated_msg("use playEffect:filePath:loopCount:pitch:pan:gain:publish:startPos instead.");

/** Starts an audio recording on the client.

 **Deprecated** from v3.4.0. Use [startAudioRecordingWithConfig]([AgoraRtcEngineKit startAudioRecordingWithConfig:]) instead.

 The SDK allows recording during a call. After successfully calling this method, you can record the audio of all the users in the channel and get an audio recording file. Supported formats of the recording file are as follows:

 - .wav: Large file size with high fidelity.
 - .aac: Small file size with low fidelity.

 **Note**

 - Ensure that the directory you use to save the recording file exists and is writable.
 - This method is usually called after the [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) method. The recording automatically stops when you call the [leaveChannel]([AgoraRtcEngineKit leaveChannel:]) method.
 - For better recording effects, set `quality` as AgoraAudioRecordingQualityMedium or AgoraAudioRecordingQualityHigh when `sampleRate` is 44100 Hz or 48000 Hz.

 @param filePath Absolute file path of the recording file, for example, /var/mobile/Containers/Data/audio.aac. The string of the filename is in UTF-8.
 @param sampleRate Sample rate (Hz) of the recording file. Supported values are as follows:

 - 16000
 - (Default) 32000
 - 44100
 - 48000

 @param quality Audio recording quality. See AgoraAudioRecordingQuality.

  @return - 0: Success.
- < 0: Failure.
 */
- (int)startAudioRecording:(NSString* _Nonnull)filePath sampleRate:(NSInteger)sampleRate quality:(AgoraAudioRecordingQuality)quality __deprecated_msg("use startAudioRecordingWithConfig:config instead.");

/** Starts audio mixing.

 **Deprecated** from v3.4.0. Use [startAudioMixing]([AgoraRtcEngineKit startAudioMixing:loopback:replace:cycle:startPos:])2 instead.

 This method mixes the specified local audio file with the audio stream from the microphone, or replaces the microphone's audio stream with the specified local audio file. You can choose whether the other user can hear the local audio playback and specify the number of playback loops. This method also supports online music playback.

 A successful startAudioMixing method call triggers the [localAudioMixingStateDidChanged]([AgoraRtcEngineDelegate rtcEngine:localAudioMixingStateDidChanged:reason:])(AgoraAudioMixingStatePlaying) callback on the local client.

 When the audio mixing file playback finishes, the SDK triggers the [localAudioMixingStateDidChanged]([AgoraRtcEngineDelegate rtcEngine:localAudioMixingStateDidChanged:reason:])(AgoraAudioMixingStateStopped) callback on the local client.

 **Note:**

 - To avoid blocking, as of v3.4.5, this method changes from a synchronous call
 to an asynchronous call.
 - If you want to play an online music file, ensure that the time interval between playing the online music file and calling this method is greater than 100 ms, or the AudioFileOpenTooFrequent(702) warning occurs.
 - If the local audio mixing file does not exist, or if the SDK does not support the file format or cannot access the music file URL, the SDK returns AgoraWarningCodeAudioMixingOpenError(701).
 - For the audio file formats supported by this method, see
 [What formats of audio files does the Agora RTC SDK support](https://docs.agora.io/en/faq/audio_format).

 @param filePath The absolute path or URL address (including the filename extensions)
 of the audio file. For example: `/var/mobile/Containers/Data/audio.mp4`.
 @param loopback Sets which user can hear the audio mixing:

 * YES: Only the local user can hear the audio mixing.
 * NO: Both users can hear the audio mixing.

 @param replace Sets the audio mixing content:

 * YES: Only the specified audio file is published; the audio stream received by the microphone is not published.
 * NO: The local audio file mixed with the audio stream from the microphone.

 @param cycle Sets the number of playback loops:

 * Positive integer: Number of playback loops.
 * -1：Infinite playback loops.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)startAudioMixing:(NSString* _Nonnull)filePath loopback:(BOOL)loopback replace:(BOOL)replace cycle:(NSInteger)cycle __deprecated_msg("use startAudioMixing(.., startPos) instead");

/** Stops or resumes subscribing to the video streams of all remote users by default.

 **Deprecated** This method is deprecated from v3.3.0.

 Call this method after joining a channel. After successfully calling this
 method, the local user stops or resumes subscribing to the video streams of
 all subsequent users.

 **Note**

 If you need to resume subscribing to the video streams of remote users
 in the channel after calling `setDefaultMuteAllRemoteVideoStreams(YES)`, do
 the following:

  - If you need to resume subscribing to the video stream of a specified user,
  call [muteRemoteVideoStream(NO)]([AgoraRtcEngineKit muteRemoteVideoStream:mute:]), and specify the user ID.
  - If you need to resume subscribing to the video streams of multiple remote
  users, call `muteRemoteVideoStream(NO)` multiple times.

 @param mute Sets whether to stop subscribing to the video streams of all
 remote users by default.

 * YES: Stop subscribing to the video streams of all
 remote users by default.
 * NO: (Default) Resume subscribing to the video streams of all remote users
 by default.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)setDefaultMuteAllRemoteVideoStreams:(BOOL)mute;

/** Stops or resumes subscribing to the audio streams of all remote users by default.

 **Deprecated** This method is deprecated from v3.3.0.

 Call this method after joining a channel. After successfully calling this
 method, the local user stops or resumes subscribing to the audio streams of
 all subsequent users.

 **Note**

 If you need to resume subscribing to the audio streams of remote users
 in the channel after calling `setDefaultMuteAllRemoteAudioStreams(YES)`, do
 the following:

  - If you need to resume subscribing to the audio stream of a specified user,
  call [muteRemoteAudioStream(NO)]([AgoraRtcEngineKit muteRemoteAudioStream:mute:]), and specify the user ID.
  - If you need to resume subscribing to the audio streams of multiple remote
  users, call `muteRemoteAudioStream(NO)` multiple times.

 @param mute Sets whether to stop subscribing to the audio streams of all
 remote users by default.

 * YES: Stop subscribing to the audio streams of all
 remote users by default.
 * NO: (Default) Resume subscribing to the audio streams of all remote users
 by default.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)setDefaultMuteAllRemoteAudioStreams:(BOOL)mute;

/** Sets the log files that the SDK outputs.

 **Deprecated** This method is deprecated from v3.3.0. Use the `logConfig`
 parameter in [sharedEngineWithConfig]([AgoraRtcEngineKit sharedEngineWithConfig:delegate:])
 to set the log file path instead.

 By default, the SDK outputs five log files, `agorasdk.log`, `agorasdk_1.log`, `agorasdk_2.log`, `agorasdk_3.log`, `agorasdk_4.log`, each
 with a default size of 1024 KB. These log files are encoded in UTF-8. The SDK writes the latest logs in `agorasdk.log`. When `agorasdk.log`
 is full, the SDK deletes the log file with the earliest modification time among the other four, renames `agorasdk.log` to the name of the
 deleted log file, and creates a new `agorasdk.log` to record latest logs.

 **Note:**

 - The default log file path is as follows:
   - iOS: `App Sandbox/Library/caches/agorasdk.log`
   - macOS
     - Sandbox enabled: `App Sandbox/Library/Logs/agorasdk.log`, for example `/Users/<username>/Library/Containers/<App Bundle Identifier>/Data/Library/Logs/agorasdk.log`.
     - Sandbox disabled: `～/Library/Logs/agorasdk.log`.
 - Ensure that you call this method immediately after calling the [sharedEngineWithAppId]([AgoraRtcEngineKit sharedEngineWithAppId:delegate:]) method, otherwise the output logs may not be complete.

 @param filePath The absolute path of log files. Ensure that the directory for the log files exists and is writable. You can use this parameter to rename the log files.

 @return * 0: Success.
 * < 0: Failure.
 */
- (int)setLogFile:(NSString* _Nonnull)filePath;

/** Sets the output log level of the SDK.

 **Deprecated** This method is deprecated from v3.3.0. Use the `logConfig`
 parameter in [sharedEngineWithConfig]([AgoraRtcEngineKit sharedEngineWithConfig:delegate:])
 to set the log filter instead.

 You can use one or a combination of the filters. The log level follows the sequence of `Off`, `Critical`, `Error`, `Warning`, `Info` and `Debug`. Choose a level to see the logs preceding that level.

 For example, if you set the log level to `Warning`, you see the logs within levels `Critical`, `Error`, and `Warning`.

 @param filter Log filter level: AgoraLogFilter.

 @return * 0: Success.
 * < 0: Failure.
 */
- (int)setLogFilter:(NSUInteger)filter;

/** Sets the size of a log file that the SDK outputs.

 **Deprecated** This method is deprecated from v3.3.0. Use the `logConfig`
 parameter in [sharedEngineWithConfig]([AgoraRtcEngineKit sharedEngineWithConfig:delegate:])
 to set the log file size instead.

 By default, the SDK outputs five log files, `agorasdk.log`, `agorasdk_1.log`, `agorasdk_2.log`,
 `agorasdk_3.log`, `agorasdk_4.log`, each with a default size of 1024 KB. These log files are
 encoded in UTF-8. The SDK writes the latest logs in `agorasdk.log`. When `agorasdk.log` is full,
 the SDK deletes the log file with the earliest modification time among the other four, renames
 `agorasdk.log` to the name of the deleted log file, and create a new `agorasdk.log` to record latest logs.

 @note If you want to set the log file size, ensure that you call `setLogFileSize` before [setLogFile]([AgoraRtcEngineKit setLogFile:]), or the logs are cleared.

 @param fileSizeInKBytes The size (KB) of a log file. The default value is 1024 KB. If you set
 `fileSizeInKByte` to 1024 KB, the SDK outputs at most 5 MB log files; if you set it to less
 than 1024 KB, the maximum size of a log file is still 1024 KB.

 @return - 0: Success.
 - < 0: Failure.
 */
- (int)setLogFileSize:(NSUInteger)fileSizeInKBytes;

#pragma mark ExternalLogWriter

@property(nonatomic, weak) id<AgoraLogWriterDelegate> _Nullable logWriterDelegate;

#pragma mark Deprecated Methods
/** Creates a data stream.

 **Deprecated** This method is deprecated from v3.3.0. Use the
 [createDataStream]([AgoraRtcEngineKit createDataStream:config:])2 method
 instead.

 Each user can create up to five data streams during the lifecycle of the [AgoraRtcEngineKit](AgoraRtcEngineKit).

 **Note:**

 - Ensure that you call this method after joining a channel.
 - Set both the `reliable` and `ordered` parameters to `YES` or `NO`. Do not set one as `YES` and the other as `NO`.

 @param streamId (Output parameter) The ID of the created data stream.
 @param reliable Sets whether or not the recipients are guaranteed to receive the data stream from the sender within five seconds:

 * YES: The recipients receive the data stream from the sender within five seconds. If the recipient does not receive the data stream within five seconds, an error is reported to the app.
 * NO: There is no guarantee that the recipients receive the data stream within five seconds and no error message is reported for any delay or missing data stream.

 @param ordered  Sets whether or not the recipients receive the data stream in the sent order:

 * YES: The recipients receive the data stream in the sent order.
 * NO: The recipients do not receive the data stream in the sent order.

 @return * 0: Success.
* < 0: Failure.
*/
- (int)createDataStream:(NSInteger* _Nonnull)streamId reliable:(BOOL)reliable ordered:(BOOL)ordered;

/** Sets the local voice changer option.

**Deprecated**  from v3.2.0. Use the following methods instead:

- [setAudioEffectPreset]([AgoraRtcEngineKit setAudioEffectPreset:]): Audio effects.
- [setVoiceBeautifierPreset]([AgoraRtcEngineKit setVoiceBeautifierPreset:]): Voice beautifier effects.
- [setVoiceConversionPreset]([AgoraRtcEngineKit setVoiceConversionPreset:]): Voice conversion effects.

This method can be used to set the local voice effect for users in a Communication channel or hosts in the interactive live streaming channel. Voice changer options include the following voice effects:

| Voice effect             | Description                                                  | Scenario          |
| :----------------------- | :----------------------------------------------------------- | :---------------- |
| AgoraAudioVoiceChanger*        | Changes the local voice to an old man, a little boy, or the Hulk. | Voice talk        |
| AgoraAudioVoiceBeauty*         | Beautifies the local voice by making it sound more vigorous, resounding, or adding spacial resonance. | Voice talkSinging |
| AgoraAudioGeneralBeautyVoice* | Adds gender-based beautification effect to the local voice:<li>For a male voice: Adds magnetism to the voice.<li>For a female voice: Adds freshness or vitality to the voice.</li> | Voice talk        |

**Note:**

- You can call this method either before or after joining a channel.
- To achieve better voice effect quality, Agora recommends setting the `profile` parameter in [setAudioProfile]([AgoraRtcEngineKit setAudioProfile:scenario:]) as `AgoraAudioProfileMusicHighQuality(4)` or `AgoraAudioProfileMusicHighQualityStereo(5)`.
- This method works best with the human voice, and Agora does not recommend using it for audio containing music and a human voice.
- Do not use this method with [setLocalVoiceReverbPreset]([AgoraRtcEngineKit setLocalVoiceReverbPreset:]), because the method called later overrides the one called earlier. For detailed considerations, see the advanced guide *Set the Voice Effect*.

@param voiceChanger <p>The local voice changer option. The default value is `AgoraAudioVoiceChangerOff`, which means the original voice. See details in AgoraAudioVoiceChanger.</p>
Gender-based beatification effect works best only when assigned a proper gender:
<li>For male: AgoraAudioGeneralBeautyVoiceMaleMagnetic.<li>For female: AgoraAudioGeneralBeautyVoiceFemaleFresh or AgoraAudioGeneralBeautyVoiceFemaleVitality.</li>
<p>Failure to do so can lead to voice distortion.</p>

@return * 0: Success.
* < 0: Failure. Check if the enumeration is properly set.
*/
- (int)setLocalVoiceChanger:(AgoraAudioVoiceChanger)voiceChanger __deprecated_msg("use setAudioEffectPreset or setVoiceBeautifierPreset instead.");

/** Sets the local voice reverberation option, including the virtual stereo.

**Deprecated**  from v3.2.0. Use [setAudioEffectPreset]([AgoraRtcEngineKit setAudioEffectPreset:]) or
[setVoiceBeautifierPreset]([AgoraRtcEngineKit setVoiceBeautifierPreset:]) instead.

This method sets the local voice reverberation for users in a Communication channel or hosts in the interactive live streaming channel. After successfully calling this method, all users in the channel can hear the voice with reverberation.

**Note:**

- You can call this method either before or after joining a channel.
- When calling this method with enumerations that begin with `AgoraAudioReverbPresetFx`, ensure that you set `profile` in [setAudioProfile]([AgoraRtcEngineKit setAudioProfile:scenario:]) as `AgoraAudioProfileMusicHighQuality(4)` or `AgoraAudioProfileMusicHighQualityStereo(5)`. Otherwise, this method call does not take effect.
- When calling this method with `AgoraAudioReverbPresetVirtualStereo`, Agora recommends setting the `profile` parameter in `setAudioProfile` as `AgoraAudioProfileMusicHighQualityStereo(5)`.
- This method works best with the human voice, and Agora does not recommend using it for audio containing music and a human voice.
- Do not use this method with [setLocalVoiceChanger]([AgoraRtcEngineKit setLocalVoiceChanger:]), because the method called later overrides the one called earlier. For detailed considerations, see the advanced guide *Set the Voice Effect*.

 @param reverbPreset The local voice reverberation option. The default value is `AgoraAudioReverbPresetOff`, which means the original voice. See details in AgoraAudioReverbPreset.<p>**Note**</p><p>To achieve better voice effects, Agora recommends the enumeration whose name begins with `AgoraAudioReverbPresetFx`.</p>

 @return * 0: Success.
* < 0: Failure. Check if the enumeration is properly set.
 */
- (int)setLocalVoiceReverbPreset:(AgoraAudioReverbPreset)reverbPreset __deprecated_msg("use setAudioEffectPreset or setVoiceBeautifierPreset instead.");

/** Enables built-in encryption with an encryption password before joining a channel.

 **Deprecated**  from v3.1.0. Use [enableEncryption]([AgoraRtcEngineKit enableEncryption:encryptionConfig:]) instead.

All users in a channel must set the same encryption password. The encryption password is automatically cleared once a user leaves the channel.

  If the encryption password is not specified or set to empty, the encryption functionality is disabled.

 **Note:**

 - Do not use this method for CDN live streaming.
 - For optimal transmission, ensure that the encrypted data size does not exceed the original data size + 16 bytes. 16 bytes is the maximum padding size for AES encryption.

 @param secret Encryption password.
 @return * 0: Success.
* < 0: Failure.
 */
- (int)setEncryptionSecret:(NSString* _Nullable)secret;

/** Sets the built-in encryption mode.

 **Deprecated**  from v3.1.0. Use [enableEncryption]([AgoraRtcEngineKit enableEncryption:encryptionConfig:]) instead.

 The SDK supports built-in encryption, which is set to the `"aes-128-xts"
` mode by default. Call this method to use other encryption modes.

 All users in the same channel must use the same encryption mode and password.

 Refer to the information related to the AES encryption algorithm on the differences between the encryption modes.

 **Note:**

 - Call the [setEncryptionSecret](setEncryptionSecret:) method to enable the built-in encryption function before calling this method.
 - Do not use this method for CDN live streaming.

 @param encryptionMode Sets the encryption mode.

 - "aes-128-xts": (default) 128-bit AES encryption, XTS mode.
 - "aes-256-xts": 256-bit AES encryption, XTS mode.
 - "aes-128-ecb": 128-bit AES encryption, ECB mode.

When `encryptionMode` is set as NULL, the encryption mode is set as "aes-128-xts" by default.

 @return * 0: Success.
 * < 0: Failure.
 */
- (int)setEncryptionMode:(NSString* _Nullable)encryptionMode;

/** Sets the local video display mode.

 **Deprecated**  from v3.0.0, use the new [setLocalRenderMode]([AgoraRtcEngineKit setLocalRenderMode:mirrorMode:]) method instead.

 This method can be invoked multiple times during a call to change the display mode.

 @param mode Sets the local video display mode. See AgoraVideoRenderMode.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)setLocalRenderMode:(AgoraVideoRenderMode)mode;

/** Sets the remote video display mode.

 **Deprecated**  from v3.0.0, use the new [setRemoteRenderMode]([AgoraRtcEngineKit setRemoteRenderMode:renderMode:mirrorMode:]) method instead.

 This method can be invoked multiple times during a call to change the display mode.

 @param uid  User ID of the remote user sending the video streams.
 @param mode Sets the remote video display mode. See AgoraVideoRenderMode.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)setRemoteRenderMode:(NSUInteger)uid mode:(AgoraVideoRenderMode)mode;

/** Sets the local video mirror mode.

 **Deprecated**  from v3.0.0, use the [setupLocalVideo]([AgoraRtcEngineKit setupLocalVideo:]) or [setLocalRenderMode]([AgoraRtcEngineKit setLocalRenderMode:mirrorMode:]) method instead.

 @warning Call this method after calling the initializing the local video view by calling `setupLocalVideo`.
 @param mode Sets the local video mirror mode. See AgoraVideoMirrorMode.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)setLocalVideoMirrorMode:(AgoraVideoMirrorMode)mode;

/** Enables interoperability with the Agora Web SDK.

 **Deprecated**  from v3.0.0. As of v3.0.0, the Native SDK automatically enables interoperability with the Web SDK, so you no longer need to call this method.

 - This method is applicable to the interactive live streaming profile only. In the Communication profile, the SDK is interoperable with the Web SDK by default.
 - If the channel has Web SDK users, ensure that you call this method, or the video of the Native user will be a black screen for the Web user.

 @param enabled Sets whether to enable/disable interoperability with the Agora Web SDK:

 * YES: Enable.
 * NO: (Default) Disable.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)enableWebSdkInteroperability:(BOOL)enabled;

/** Adds a watermark image to the local video or CDN live stream.

 **Deprecated**  from v2.9.1. Use the new [addVideoWatermark]([AgoraRtcEngineKit addVideoWatermark:options:]) method.

 This method adds a PNG watermark to the local video stream for the capturing device, channel audience, or CDN live audience to see and capture.

 To add the PNG file onto a CDN live publishing stream only, see the [setLiveTranscoding]([AgoraRtcEngineKit setLiveTranscoding:]) method.

**Note:**

* The URL descriptions are different for the local video and CDN live streams:
  * In a local video stream, `url` in AgoraImage refers to the local file path of the added watermark image file in the local video stream.
  * In a CDN live stream, `url` in AgoraImage refers to the URL address of the added watermark image in the CDN live streaming.
* The source file of the watermark image must be in the PNG file format. If the width and height of the PNG file differ from your settings in this method, the PNG file is cropped to conform to your settings.
* The SDK supports adding only one watermark image onto a local video or CDN live stream. The newly added watermark image replaces the previous one.
* If you set `orientationMode` as `Adaptive` in the [setVideoEncoderConfiguration]([AgoraRtcEngineKit setVideoEncoderConfiguration:]) method, the watermark image rotates with the video frame and rotates around the upper left corner of the watermark image.

@param watermark Watermark image to be added to the local video stream. See AgoraImage.

@return * 0: Success.
* < 0: Failure.
 */
- (int)addVideoWatermark:(AgoraImage* _Nonnull)watermark NS_SWIFT_NAME(addVideoWatermark(_:))__deprecated_msg("use addVideoWatermark:url options instead.");

/** Starts an audio recording.

 **Deprecated**  from v2.9.1. Use [startAudioRecordingWithConfig]([AgoraRtcEngineKit startAudioRecordingWithConfig:]) instead.

 This method has a fixed sample rate of 32 kHz.

 The SDK allows recording during a call. Supported formats:

 * .wav: Large file size with high fidelity.
 * .aac: Small file size with low fidelity.

 Ensure that the directory to save the recording file exists and is writable. You can call this method after calling the [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) method. The recording automatically stops when you call the [leaveChannel]([AgoraRtcEngineKit leaveChannel:]) method.

 @param filePath Absolute file path of the recording file. The string of the file name is in UTF-8.
 @param quality  Sets the audio recording quality. See AgoraAudioRecordingQuality.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)startAudioRecording:(NSString* _Nonnull)filePath quality:(AgoraAudioRecordingQuality)quality __deprecated_msg("use startAudioRecordingWithConfig:config instead.");

/** Starts an audio call test.

**Deprecated**  from v2.4.

This method launches an audio call test to determine whether the audio devices (for example, headset and speaker) and the network connection are working properly.

To conduct the test:

- The user speaks and the sampled audio data is played back within 10 seconds.
- If the user can hear the sampled audio data within 10 seconds, the audio devices and network connection are working properly.

 **Note:**

 * After calling this method, always call the stopEchoTest method to end the test. Otherwise, the app cannot run the next echo test, nor can it call the [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) method to start a new call.
 * In the interactive live streaming profile, only the hosts can call this method. If the user switches from the Communication to interactive live streaming profile, the user must call the [setClientRole](setClientRole:) method to change the user role from an audience (default) to a host before calling this method.
 @see [startEchoTestWithInterval]([AgoraRtcEngineKit startEchoTestWithInterval:successBlock:])
 @param successBlock The SDK triggers the `successBlock` callback if this method call is successful.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)startEchoTest:(void (^_Nullable)(NSString* _Nonnull channel, NSUInteger uid, NSInteger elapsed))successBlock __deprecated_msg("use startEchoTestWithInterval instead.");

/** Sets the preferences for the video quality. (interactive live streaming only).

**Deprecated**  from v2.4.

Under unreliable network connections or the device's CPU is overloaded, the video quality may be affected. You can use this method to choose the video smoothness (frame rate) over the image quality or vice versa.

 @param preferFrameRateOverImageQuality Sets the video quality preference:

 * YES: Frame rate over image quality.
 * NO: (Default) Image quality over frame rate.

 @return * 0: Success.
* < 0: Failure.
 */
- (int)setVideoQualityParameters:(BOOL)preferFrameRateOverImageQuality __deprecated_msg("use AgoraDegradationPreference instead.");

/** Initializes the AgoraRtcEngineKit object.

 **Deprecated**  from v2.3.

 @see [sharedEngineWithappId]([AgoraRtcEngineKit sharedEngineWithAppId:delegate:])
 @param AppId    App ID issued to you by Agora. Apply for a new App ID from Agora if it is missing from your kit. Each project is assigned a unique App ID. The App ID identifies your project and organization in the [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) method to access the Agora Global Network, and enable one-to-one or one-to-more communication or the interactive live streaming sessions using a unique channel name for your App ID.
 @param errorBlock Error code: AgoraErrorCode.
 */
+ (instancetype _Nonnull)sharedEngineWithAppId:(NSString* _Nonnull)AppId error:(void (^_Nullable)(AgoraErrorCode errorCode))errorBlock __deprecated_msg("use sharedEngineWithAppId:delegate: instead.");

/** Disables the audio function in a channel.

**Deprecated**  from v2.3

 @see disableAudio
 @return * 0: Success.
* < 0: Failure.
 */
- (int)pauseAudio __deprecated_msg("use disableAudio instead.");

/** Resumes the audio in a channel.

 **Deprecated**  from v2.3

 @see enableAudio
 @return * 0: Success.
* < 0: Failure.
 */
- (int)resumeAudio __deprecated_msg("use enableAudio instead.");

/** Sets the high-quality audio parameters.

 Replaced with [setAudioProfile](setAudioProfile:scenario:).

**Deprecated**  from v2.3.

 @param fullband Sets whether to enable/disable full-band codec (48 kHz sample rate). Not compatible with versions earlier than v1.7.4.

  * YES: Enable full-band codec.
  * NO: Disable full-band codec.
 @param stereo Sets whether to enable/disable stereo codec. Not compatible with versions earlier than v1.7.4.

  * YES: Enable stereo codec.
  * NO: Disable stereo codec.
 @param fullBitrate Sets whether to enable/disable high-bitrate mode. Recommended in voice-only mode.

  * YES: Enable high-bitrate mode.
  * NO: Disable high-bitrate mode.
 @return * 0: Success.
 * < 0: Failure.
 */
- (int)setHighQualityAudioParametersWithFullband:(BOOL)fullband stereo:(BOOL)stereo fullBitrate:(BOOL)fullBitrate __deprecated_msg("use setAudioProfile:scenario: instead.");

#if (!(TARGET_OS_IPHONE) && (TARGET_OS_MAC))
/** Sets the speakerphone volume. (macOS only.)

 **Deprecated**  from v2.3.

 @see [setDeviceVolume](setDeviceVolume:volume:).
 @param volume Sets the speakerphone volume. The value ranges between 0 (lowest volume) and 255 (highest volume).

 @return * 0: Success.
* < 0: Failure.
 */
- (int)setSpeakerphoneVolume:(NSUInteger)volume __deprecated_msg("use setDeviceVolume:volume: instead.");

/** Starts screen sharing. (macOS only.)

**Deprecated**  from v2.4.

 @see [startScreenCaptureByDisplayId]([AgoraRtcEngineKit startScreenCaptureByDisplayId:rectangle:parameters:])
 @see [startScreenCaptureByWindowId]([AgoraRtcEngineKit startScreenCaptureByWindowId:rectangle:parameters:])
 @param windowId Sets to share the whole screen, a specified window, or a specified region:
 * Share the whole screen: Set `windowId` as 0 and set `rect` as nil.
 * Share the specified window: Set `windowId` not as 0. Each window has a `windowId` that is not 0.
 * Share the specified region: Set `windowId` as 0 and set `rect` not as nil. You can share the specified region, for example by dragging the mouse (the logic is implemented by yourself). The specified region is a region on the whole screen. Currently, sharing a specified region in a specific window is not supported.
 @param captureFreq (Mandatory) The captured frame rate. The value ranges between 1 fps and 15 fps.
 @param bitRate The captured bitrate.
 @param rect Specifies the screen-sharing region. `rect` is valid when `windowsId` is set as 0. When you set `rect` as nil, the whole screen is shared.
 @return * 0: Success.
* < 0: Failure.
 */
- (int)startScreenCapture:(NSUInteger)windowId withCaptureFreq:(NSInteger)captureFreq bitRate:(NSInteger)bitRate andRect:(CGRect)rect __deprecated_msg("use startScreenCaptureByDisplayId or startScreenCaptureByWindowId: instead.");

#endif

/** Sets the video profile.

 **Deprecated**  from v2.3.

 Each video profile includes a set of parameters, such as the resolution, frame rate, and bitrate. If the camera device does not support the specified resolution, the SDK automatically chooses a suitable camera resolution, keeping the encoder resolution specified by setVideoProfile.

 You can call this method either before or after joining a channel.

 **Note:**

 * Always set the video profile after calling the [enableVideo](enableVideo) method.
 * Always set the video profile before calling the [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) or [startPreview]([AgoraRtcEngineKit startPreview]) method.
 * If you do not need to set the video profile after joining the channel, call this method before calling the enableVideo method to reduce the render time of the first video frame.

 @see [setVideoEncoderConfiguration]([AgoraRtcEngineKit setVideoEncoderConfiguration:])
 @param profile    Sets the video profile. See AgoraVideoProfile.
 @param swapWidthAndHeight Sets whether to swap the width and height of the video:

 * YES: Swap the width and height. The video is in portrait mode.
 * NO: (Default) Do not swap the width and height. The video remains in landscape mode.

 The width and height of the output video are consistent with the set video profile.

 @return * 0: Success.
 * < 0: Failure.
 */
- (int)setVideoProfile:(AgoraVideoProfile)profile swapWidthAndHeight:(BOOL)swapWidthAndHeight __deprecated_msg("use setVideoEncoderConfiguration: instead.");

/** Sets the video encoding profile manually.

 **Deprecated**  from v2.3.

 If you do not need to change the video profile after joining the channel, Agora recommends calling this method before calling the enableVideo method to reduce the render time of the first video frame.

 @see [setVideoEncoderConfiguration]([AgoraRtcEngineKit setVideoEncoderConfiguration:])
 @param size      Sets the size of the video. The highest value is 1280 * 720.
 @param frameRate Sets the frame rate of the video. The highest value is 30. You can set it to 5, 10, 15, 24, 30, and so on.
 @param bitrate   Sets the bitrate of the video. You need to manually work out the bitrate according to the width, height, and frame rate. See the bitrate table in AgoraVideoEncoderConfiguration. With the same width and height, the bitrate varies with the change of the frame rate:

 * If the frame rate is 5 fps, divide the recommended bitrate by 2.
 * If the frame rate is 15 fps, use the recommended bitrate.
 * If the frame rate is 30 fps, multiply the recommended bitrate by 1.5.
 * Calculate your bitrate with the ratio if you choose other frame rates.

 For example, the resolution is 320 * 240 and the frame rate is 15 fps, hence, the bitrate is 200:

 * If the frame rate is 5 fps, the bitrate is 100.
 * If the frame rate is 30 fps, the bitrate is 300.
 * If you set a bitrate beyond the proper range, the SDK automatically adjusts the bitrate to a value within the proper range.
 */
- (int)setVideoResolution:(CGSize)size andFrameRate:(NSInteger)frameRate bitrate:(NSInteger)bitrate __deprecated_msg("use setVideoEncoderConfiguration: instead.");

#if (!(TARGET_OS_IPHONE) && (TARGET_OS_MAC))
/** Gets the type of devices, such as audio sampling and playback device. (macOS only.)

 **Deprecated**   from v2.3.

 @see [getDeviceInfo](getDeviceInfo:).
 @param type Device type: AgoraMediaDeviceType.
 @return * Returns the device ID of the device, if this method call is successful.
 * nil: Failure.
 */
- (NSString* _Nullable)getDeviceId:(AgoraMediaDeviceType)type __deprecated_msg("use getDeviceInfo: instead.");
#endif

/** Plays a specified audio effect.

 **Deprecated**  from v2.3.

 @see [playEffect]([AgoraRtcEngineKit playEffect:filePath:loopCount:pitch:pan:gain:publish:startPos:])3
 @param soundId ID of the audio effect. Each audio effect has a unique ID.

 **Note:**

 - If you preloaded the audio effect into the memory through the [preloadEffect]([AgoraRtcEngineKit preloadEffect:filePath:]) method, ensure that the `soundID` value is set to the same value as in `preloadEffect`.
 - For the audio file formats supported by this method, see
 [What formats of audio files does the Agora RTC SDK support](https://docs.agora.io/en/faq/audio_format).

 @param filePath Absolute path of the audio effect file.
 @param loopCount Sets the number of times looping the audio effect:

 * 0: Plays the audio effect once.
 * 1: Plays the audio effect twice.
 * -1: Plays the audio effect in an indefinite loop until you call the [stopEffect]([AgoraRtcEngineKit stopEffect:]) or [stopAllEffects]([AgoraRtcEngineKit stopAllEffects]) method

 @param pitch Sets whether to change the pitch of the audio effect. The value ranges between 0.5 and 2.
 The default value is 1 (no change to the pitch). The lower the value, the lower the pitch.
 @param pan Sets the spatial position of the audio effect. The value ranges between -1.0 and 1.0.

 * 0.0: The audio effect displays ahead.
 * 1.0: The audio effect displays to the right.
 * -1.0: The audio effect displays to the left.

 @param gain Sets the volume of the sound effect. The value ranges between 0.0 and 100.0 (default). The lower the value, the lower the volume of the sound effect.
 @return * 0: Success.
* < 0: Failure.
 */
- (int)playEffect:(int)soundId filePath:(NSString* _Nullable)filePath loopCount:(int)loopCount pitch:(double)pitch pan:(double)pan gain:(double)gain __deprecated_msg("use playEffect:filePath:loopCount:pitch:pan:gain:publish:startPos instead.");

/** Returns the media engine version.

 **Deprecated**  from v2.3.

 @see getSdkVersion

 @return The media engine version in the string format.
 */
+ (NSString* _Nonnull)getMediaEngineVersion __deprecated;

#pragma mark Deprecated Blocks

/**-----------------------------------------------------------------------------
 * @name Deprecated Blocks
 * -----------------------------------------------------------------------------
 */

/** Reports which users are speaking and the speakers' volume.

 **Deprecated**  from v1.1.

 This callback is disabled by default and can be enabled by the `enableAudioVolumeIndication` method.

 In the returned speakers' array:

 * If `uid` is 0 (the local user is the speaker), the returned volume is `totalVolume`.
 * If `uid` is not 0 and `volume` is 0, the specified user did not speak.
 * If a `uid` is found in the previous speakers' array but not in the current speakers' array, the specified user did not speak.

@see [reportAudioVolumeIndicationOfSpeakers]([AgoraRtcEngineDelegate rtcEngine:reportAudioVolumeIndicationOfSpeakers:totalVolume:])

@param audioVolumeIndicationBlock This block includes:

- speakers: An array containing the user ID and volume information for each speaker.

   - uid: User ID of the speaker.
   - volume：Volume of the speaker. The value ranges between 0 (lowest volume) to 255 (highest volume).
- totalVolume: Total volume after audio mixing between 0 (lowest volume) to 255 (highest volume).
 */
- (void)audioVolumeIndicationBlock:(void (^_Nullable)(NSArray* _Nonnull speakers, NSInteger totalVolume))audioVolumeIndicationBlock __deprecated_msg("use delegate instead.");

/** Occurs when the first local video frame is displayed/rendered on the local video view.

 **Deprecated**  from v1.1.

 @see [firstLocalVideoFrameWithSize]([AgoraRtcEngineDelegate rtcEngine:firstLocalVideoFrameWithSize:elapsed:])

 @param firstLocalVideoFrameBlock This block includes the:

 - width: Width (pixels) of the video stream.
 - height: Height (pixels) of the video stream.
 - elapsed: Time elapsed (ms) from the local user calling [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) until the SDK triggers this callback.
 */
- (void)firstLocalVideoFrameBlock:(void (^_Nullable)(NSInteger width, NSInteger height, NSInteger elapsed))firstLocalVideoFrameBlock __deprecated_msg("use delegate instead.");

/** Occurs when the engine decodes the first video frame from a specific remote user.

 **Deprecated**  from v1.1.

 @see [firstRemoteVideoFrameOfUid]([AgoraRtcEngineDelegate rtcEngine:firstRemoteVideoFrameOfUid:size:elapsed:])

 @param firstRemoteVideoDecodedBlock This block includes the:

 - uid:     User ID of the user sending the video streams.
 - width:   Width (pixels) of the video stream.
 - height:  Height (pixels) of the video stream.
 - elapsed: Time elapsed (ms) from the remote user calling [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) until the SDK triggers this callback.
 */
- (void)firstRemoteVideoDecodedBlock:(void (^_Nullable)(NSUInteger uid, NSInteger width, NSInteger height, NSInteger elapsed))firstRemoteVideoDecodedBlock __deprecated_msg("use delegate instead.");

/** Occurs when the first remote video frame is rendered.

 **Deprecated**  from v1.1.

 @see [firstRemoteVideoDecodedOfUid]([AgoraRtcEngineDelegate rtcEngine:firstRemoteVideoDecodedOfUid:size:elapsed:])

 @param firstRemoteVideoFrameBlock This block includes the:

 - uid:     User ID of the remote user sending the video streams.
 - width:   Width (pixels) of the video stream.
 - height:  Height (pixels) of the video stream.
 - elapsed: Time elapsed (ms) from the local user calling [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) until the SDK triggers this callback.
 */
- (void)firstRemoteVideoFrameBlock:(void (^_Nullable)(NSUInteger uid, NSInteger width, NSInteger height, NSInteger elapsed))firstRemoteVideoFrameBlock __deprecated_msg("use delegate instead.");

/** Occurs when a user joins a channel.

 **Deprecated**  from v1.1.

 If there are other users in the channel when this user joins, the SDK also reports to the app on the existing users who are already in the channel.

 @see [didJoinedOfUid]([AgoraRtcEngineDelegate rtcEngine:didJoinedOfUid:elapsed:])

 @param userJoinedBlock This block includes the:

 - uid:     User ID. If the `uid` is specified in the [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) method, the specified user ID is returned. If the user ID is not specified in the joinChannel method, the server automatically assigns a `uid`.
 - elapsed: Time elapsed (ms) from the user calling  [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) until the SDK triggers this callback.
 */
- (void)userJoinedBlock:(void (^_Nullable)(NSUInteger uid, NSInteger elapsed))userJoinedBlock __deprecated_msg("use delegate instead.");

/** Occurs when a user leaves a call or goes offline.

 **Deprecated**  from v1.1.

 The SDK reads the timeout data to determine if a user leaves a channel (or goes offline). If no data packet is received from the user within 15 seconds, the SDK assumes the user is offline. Sometimes a weak network connection may lead to NO detections; therefore, Agora recommends using the [Agora RTM SDK](https://docs.agora.io/en/Real-time-Messaging/product_rtm?platform=All%20Platforms) for reliable offline detection.

 @see [didOfflineOfUid]([AgoraRtcEngineDelegate rtcEngine:didOfflineOfUid:reason:])
 @param userOfflineBlock This block includes the user ID, `uid`.
 */
- (void)userOfflineBlock:(void (^_Nullable)(NSUInteger uid))userOfflineBlock __deprecated_msg("use delegate instead.");

/** Occurs when a remote user's audio stream is muted/unmuted.

 **Deprecated**  from v1.1.

 @see [didAudioMuted]([AgoraRtcEngineDelegate rtcEngine:didAudioMuted:byUid:])

 @param userMuteAudioBlock This block includes the:

 - uid:   ID of the remote user whose audio stream is muted/unmuted.
 - muted: Whether the remote user's audio stream is muted/unmuted:

     - YES: Muted.
     - NO: Unmuted.
 */
- (void)userMuteAudioBlock:(void (^_Nullable)(NSUInteger uid, BOOL muted))userMuteAudioBlock __deprecated_msg("use delegate instead.");

/** Occurs when a remote user's video stream playback pauses/resumes.

 **Deprecated**  from v1.1.

 @see [didVideoMuted]([AgoraRtcEngineDelegate rtcEngine:didVideoMuted:byUid:])
 @param userMuteVideoBlock This block includes the:

 - uid:   ID of the remote user whose video stream playback pauses/resumes.
 - muted: Whether the remote user's video playback pauses/resumes:

     - YES: Pauses.
     - NO: Resumes.
 */
- (void)userMuteVideoBlock:(void (^_Nullable)(NSUInteger uid, BOOL muted))userMuteVideoBlock __deprecated_msg("use delegate instead.");

/** Reports the statistics of the uploading local video streams once every two seconds.

 **Deprecated**  from v1.1.

 @see [localVideoStats]([AgoraRtcEngineDelegate rtcEngine:localVideoStats:])
 @param localVideoStatBlock This block includes the:

 - sentBitrate:  Bitrate sent since last count.
 - sentFrameRate: Frame rate sent since last count.
 */
- (void)localVideoStatBlock:(void (^_Nullable)(NSInteger sentBitrate, NSInteger sentFrameRate))localVideoStatBlock __deprecated_msg("use delegate instead.");

/** Reports the statistics of the receiving remote video streams once every two seconds.

 **Deprecated**  from v1.1.

  @see [remoteVideoStats]([AgoraRtcEngineDelegate rtcEngine:remoteVideoStats:])

 @param remoteVideoStatBlock This block includes the:

 - uid:                   User ID of the remote user sending the video streams.
 - delay:                 Time delay (ms).
 - receivedBitrate:       Bitrate received since last count.
 - decoderOutputFrameRate:     Frame rate encoder output since last count.
 - renderererOutputFrameRate       Frame rate render output since last count.
 */
- (void)remoteVideoStatBlock:(void (^_Nullable)(NSUInteger uid, NSInteger delay, NSInteger receivedBitrate, NSInteger decoderOutputFrameRate, NSInteger rendererOutputFrameRate))remoteVideoStatBlock __deprecated_msg("use delegate instead.");

/** Reports the statistics of the receiving remote audio streams once every two seconds.

 **Deprecated**  from v1.1.

 @see [remoteAudioStats]([AgoraRtcEngineDelegate rtcEngine:remoteAudioStats:])

 @param remoteAudioStatBlock This block includes the:

 - uid:                    User ID of the user sending the audio streams.
 - quality:                Audio receiving quality of the user
 - networkTransportDelay:  Network delay from the sender to the receiver.
 - jitterBufferDelay:      Jitter buffer delay at the receiver.
 - audioLossRate:          Audio frame loss rate in the reported interval.
 */
- (void)remoteAudioStatBlock:(void (^_Nullable)(NSUInteger uid, NSInteger quality, NSInteger networkTransportDelay, NSInteger jitterBufferDelay, NSInteger audioLossRate, NSInteger numChannels, NSInteger receivedSampleRate, NSInteger receivedBitrate, NSInteger totalFrozenTime, NSInteger frozenRate, NSInteger totalActiveTime, NSInteger publishDuration, NSInteger qoeQuality, NSInteger qualityChangedReason, NSInteger mosValue))remoteAudioStatBlock __deprecated_msg("use delegate instead.");

/** Occurs when the camera turns on and is ready to capture the video.

 **Deprecated**  from v1.1.

 @see [rtcEngineCameraDidReady]([AgoraRtcEngineDelegate rtcEngineCameraDidReady:])
 */
- (void)cameraReadyBlock:(void (^_Nullable)(void))cameraReadyBlock __deprecated_msg("use delegate instead.");

/** Occurs when the connection between the SDK and the server is lost.

 **Deprecated**  from v1.1.

 @see [rtcEngineConnectionDidInterrupted]([AgoraRtcEngineDelegate rtcEngineConnectionDidInterrupted:])
 @see [rtcEngineConnectionDidLost]([AgoraRtcEngineDelegate rtcEngineConnectionDidLost:])
 */
- (void)connectionLostBlock:(void (^_Nullable)(void))connectionLostBlock __deprecated_msg("use delegate instead.");

/** Occurs when a user rejoins the channel after disconnection due to network problems.

When the client loses connection with the server because of network problems, the SDK automatically attempts to reconnect and triggers this callback upon reconnection.

 **Deprecated**  from v1.1.

 @see [didRejoinChannel]([AgoraRtcEngineDelegate rtcEngine:didRejoinChannel:withUid:elapsed:])
 @param rejoinChannelSuccessBlock This block includes the:

 - channel: Channel name.
 - uid:     User ID.
 - elapsed: Time elapsed (ms) from starting to reconnect until this callback occurs.
 */
- (void)rejoinChannelSuccessBlock:(void (^_Nullable)(NSString* _Nonnull channel, NSUInteger uid, NSInteger elapsed))rejoinChannelSuccessBlock __deprecated_msg("use delegate instead.");

/** Reports the RtcEngine runtime statistics once every two seconds.

 **Deprecated**  from v1.1.

 @see [reportRtcStats]([AgoraRtcEngineDelegate rtcEngine:reportRtcStats:])
 @param rtcStatsBlock RtcEngine runtime statistics. See [AgoraChannelStats](AgoraChannelStats).
 */
- (void)rtcStatsBlock:(void (^_Nullable)(AgoraChannelStats* _Nonnull stat))rtcStatsBlock __deprecated_msg("use delegate instead.");

/** Occurs when a user leaves a channel.

 **Deprecated**  from v1.1.

 When the app calls the [leaveChannel]([AgoraRtcEngineKit leaveChannel:]) method, the SDK uses this callback to notify the app that a user leaves a channel.

 With this callback, the app gets information, such as the call duration and statistics of the received/transmitted data in the [audioQualityOfUid]([AgoraRtcEngineDelegate rtcEngine:audioQualityOfUid:quality:delay:lost:]) callback.

 @see [didLeaveChannelWithStats]([AgoraRtcEngineDelegate rtcEngine:didLeaveChannelWithStats:])
 @param leaveChannelBlock Statistics of the call. See [AgoraChannelStats](AgoraChannelStats).
 */
- (void)leaveChannelBlock:(void (^_Nullable)(AgoraChannelStats* _Nonnull stat))leaveChannelBlock __deprecated_msg("use delegate instead.");

/** Reports the audio quality of the current call once every two seconds.

 **Deprecated**  from v1.1.

 @see [audioQualityOfUid]([AgoraRtcEngineDelegate rtcEngine:audioQualityOfUid:quality:delay:lost:])
 @param audioQualityBlock This block includes the:

 - uid:     User ID of the speaker.
 - quality: Audio quality of the user: AgoraNetworkQuality.
 - delay:   Time delay (ms).
 - lost:    Audio packet loss rate (%).
 */
- (void)audioQualityBlock:(void (^_Nullable)(NSUInteger uid, AgoraNetworkQuality quality, NSUInteger delay, NSUInteger lost))audioQualityBlock __deprecated_msg("use delegate instead.");

/** Reports the network quality of a specified user in the Communication or Live Broadcast profile once every two seconds.

 **Deprecated**  from v1.1.

 @see [networkQuality]([AgoraRtcEngineDelegate rtcEngine:networkQuality:txQuality:rxQuality:])
 @param networkQualityBlock This block includes the:

 - uid:       User ID. The network quality of the user with this `uid` is reported. If `uid` is 0, the local network quality is reported.
 - txQuality: The transmission quality of the user: AgoraNetworkQuality.
 - rxQuality: The receiving quality of the user: AgoraNetworkQuality.
 */
- (void)networkQualityBlock:(void (^_Nullable)(NSUInteger uid, AgoraNetworkQuality txQuality, AgoraNetworkQuality rxQuality))networkQualityBlock __deprecated_msg("use delegate instead.");

/** Reports the last mile network quality of the local user once every two seconds before the user joins a channel.

 **Deprecated**  from v1.1.

Last mile refers to the connection between the local device and Agora's edge server. After the app calls the [enableLastmileTest]([AgoraRtcEngineKit enableLastmileTest]) method, this callback reports once every two seconds the uplink and downlink last mile network conditions of the local user before the user joins a channel.

 @param lastmileQualityBlock Network quality. See [AgoraNetworkQuality](AgoraNetworkQuality).
 */
- (void)lastmileQualityBlock:(void (^_Nullable)(AgoraNetworkQuality quality))lastmileQualityBlock __deprecated_msg("use delegate instead.");

/** Reports a media engine event.

 **Deprecated**  from v1.1.
 */
- (void)mediaEngineEventBlock:(void (^_Nullable)(NSInteger code))mediaEngineEventBlock __deprecated_msg("use delegate instead.");

@end
/**
 The AgoraMediaRecorder class.

 @since v3.5.2
 */
@class AgoraMediaRecorder;
/** The AgoraMediaRecorderDelegate protocol.

 @since v3.5.2
 */
@protocol AgoraMediaRecorderDelegate <NSObject>
#pragma mark Media Recorder Delegate Methods
/**-----------------------------------------------------------------------------
 * @name Media Recorder Delegate Methods
 * -----------------------------------------------------------------------------
 */

/**
 Occurs when the recording state changes.

 @since v3.5.2

 When the local audio and video recording state changes, the SDK triggers this callback to report the current recording state and the reason for the change.

 @param recorder AgoraMediaRecorder
 @param state The current recording state. See AgoraMediaRecorderState.
 @param error The reason for the state change. See AgoraMediaRecorderErrorCode.
 */
- (void)mediaRecorder:(AgoraMediaRecorder* _Nonnull)recorder stateDidChanged:(AgoraMediaRecorderState)state error:(AgoraMediaRecorderErrorCode)error;

/**
 Occurs when the recording information is updated.

 @since v3.5.2

 After you successfully enable the local audio and video recording, the SDK periodically triggers this callback based on the
 set value of `recorderInfoUpdateInterval`. This callback reports the filename, duration, and size of the current recording file.

 @param recorder AgoraMediaRecorder
 @param info Information for the recording file. See AgoraMediaRecorderInfo.
 */
- (void)mediaRecorder:(AgoraMediaRecorder* _Nonnull)recorder informationDidUpdated:(AgoraMediaRecorderInfo* _Nonnull)info;

@end
/**
 The AgoraMediaRecorder interface, for recording the audio and video on the client. AgoraMediaRecorder can record
 the following content:

 - The audio captured by the local microphone and encoded in AAC format.
 - The video captured by the local camera and encoded by the SDK.

 @since v3.5.2

 @note In the `Communication` channel profile, this function is unavailable when there are users using versions of the SDK earlier than v3.0.0 in the channel.
 */
__attribute__((visibility("default"))) @interface AgoraMediaRecorder : NSObject

/**
 Creates an AgoraMediaRecorder instance.

 @since v3.5.2

 @note Call this method after creating AgoraRtcEngineKit.

 @param engine AgoraRtcEngineKit
 @param delegate AgoraMediaRecorderDelegate

 @return AgoraMediaRecorder
 */
+ (instancetype _Nonnull)sharedMediaRecorderWithRtcEngine:(AgoraRtcEngineKit* _Nonnull)engine delegate:(id<AgoraMediaRecorderDelegate> _Nullable)delegate;

/**
 Destroys the AgoraMediaRecorder instance.

 @since v3.5.2

 This method releases AgoraRtcEngineKit and all other resources used by AgoraMediaRecorder. After calling this method,
 if you want to enable the recording again, you must call [sharedMediaRecorderWithRtcEngine]([AgoraMediaRecorder sharedMediaRecorderWithRtcEngine:delegate:]) to get AgoraMediaRecorder.
 */
+ (void)destroy;

/** Enables/Disables dispatching delegate methods to the main queue.

 @since v3.5.2

 If disabled, the app should dispatch UI operations to the main queue.

 @param enabled Sets whether or not to dispatch delegate methods to the main queue:

 * YES: Dispatch delegate methods to the main queue.
 * NO: Do not dispatch delegate methods to the main queue

 @return * 0: Success.
 * < 0: Failure.
 */
- (int)enableMainQueueDispatch:(BOOL)enabled;

/**
 Starts recording the local audio and video.

 @since v3.5.2

 After successfully getting the object, you can call this method to enable the recording of the local audio and video.

 This method can record the following content:

 - The audio captured by the local microphone and encoded in AAC format.
 - The video captured by the local camera and encoded by the SDK.

 The SDK can generate a recording file only when it detects the recordable audio and video streams; when there are no
 audio and video streams to be recorded or the audio and video streams are interrupted for more than five seconds, the
 SDK stops recording and triggers the [stateDidChanged(AgoraMediaRecorderStateError, AgoraMediaRecorderErrorCodeNoStream)]([AgoraMediaRecorderDelegate mediaRecorder:stateDidChanged:error:])callback.

 @note Call this method after joining the channel.

 @param config The recording configurations. See AgoraMediaRecorderConfiguration.

 @return - 0: Success.
 -  < 0: Failure.

  - `-2(AgoraErrorCodeInvalidArgument)`: The parameter is invalid. Ensure the following:

    - The specified path of the recording file exists and is writable.
    - The specified format of the recording file is supported.
    - The maximum recording duration is correctly set.

  - `-4(AgoraErrorCodeNotSupported)`: AgoraRtcEngineKit does not support the request due to one of the following reasons:

    - The recording is ongoing.
    - The recording stops because an error occurs.

  - `-7(AgoraErrorCodeNotInitialized)`: This method is called before you create AgoraRtcEngineKit.
  Ensure that you have called [sharedMediaRecorderWithRtcEngine]([AgoraMediaRecorder sharedMediaRecorderWithRtcEngine:delegate:]) before calling `startRecording`.
 */
- (int)startRecording:(AgoraMediaRecorderConfiguration* _Nonnull)config;

/**
 Stops recording the local audio and video.

 @since v3.5.2

 @note Call this method after calling [startRecording]([AgoraMediaRecorder startRecording:]).

 @return - 0: Success.
 - < 0: Failure.

  - `-7(AgoraErrorCodeNotInitialized)`: This method is called before you create AgoraRtcEngineKit.
  Ensure that you have called [sharedMediaRecorderWithRtcEngine]([AgoraMediaRecorder sharedMediaRecorderWithRtcEngine:delegate:]) before calling `stopRecording`.
 */
- (int)stopRecording;

@end
