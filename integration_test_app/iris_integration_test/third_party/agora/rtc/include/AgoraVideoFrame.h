//
// AgoraVideoFrame.h
// AgoraRtcEngineKit
//
// Copyright (c) 2020 Agora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AgoraEnumerates.h"
#import "AgoraObjects.h"

/** The protocol of the raw video data.

 @note This protocol applies to iOS only.
 */
@protocol AgoraVideoDataFrameProtocol <NSObject>
@required

/** Gets the video data captured by the local camera.

 @since v3.4.5

 After you successfully register the raw video frame protocol, the SDK triggers
 this callback each time a video frame is received. You can get the video data
 captured by the local camera in `videoFrame` and then process the video data
 according to your scenario. After processing, you can use `videoFrame` to pass
 the processed video data back to the SDK.

 **Note**:

 - This callback applies to iOS only.
 - If you get the video data in RGBA color encoding format, Agora does not
 support using this callback to send the processed data in RGBA color encoding
 format back to the SDK.
 - The video data obtained through this callback has not undergone
 preprocessing, such as watermarking, cropping content, rotating, or
 image enhancement.

 @param videoFrame The video frame. See AgoraVideoDataFrame.

 @return - YES: Sets the SDK to receive the video frame.
 - NO: Sets the SDK to discard the video frame.
 */
- (BOOL)onCaptureVideoFrame:(AgoraVideoDataFrame*)videoFrame;
/** Gets the local pre-encoded video data.

 @since v3.4.5

 After you successfully register the raw video frame protocol and use
 [getObservedFramePosition]([AgoraVideoDataFrameProtocol getObservedFramePosition])
 to set the observation `AgoraVideoFramePositionPreEncoder (1 << 2)`, the SDK
 triggers this callback each time a video frame is received. You can get the
 local pre-encoded video data in `videoFrame` and then process the video data
 according to your scenario. After processing, you can use videoFrame to pass
 the processed video data back to the SDK.

 **Note**:

 - This callback applies to iOS only.
 - If you get the video data in RGBA color encoding format, Agora does not
 support using this callback to send the processed data in RGBA color encoding
 format back to the SDK.
 - The video data obtained through this callback has not undergone
 preprocessing, such as watermarking, cropping content, rotating, or
 image enhancement.

 @param videoFrame The video frame. See AgoraVideoDataFrame.

 @return - YES: Sets the SDK to receive the video frame.
 - NO: Sets the SDK to discard the video frame.
 */
- (BOOL)onPreEncodeVideoFrame:(AgoraVideoDataFrame*)videoFrame;
/** Gets the incoming remote video data.

 @since v3.4.5

 After you successfully register the raw video frame and set the return value
 of [isMultipleChannelFrameWanted]([AgoraVideoDataFrameProtocol isMultipleChannelFrameWanted])
 as `NO`, the SDK triggers this callback each time a video frame is received.
 You can get the incoming remote video data in `videoFrame` and then process
 the video data according to your scenario. After processing, you can use
 `videoFrame` to pass the processed video data back to the SDK.

 **Note**:

 - This callback applies to iOS only.
 - If you get the video data in RGBA color encoding format, Agora does not
 support using this callback to send the processed data in RGBA color
 encoding format back to the SDK.

 @param videoFrame The video frame. See AgoraVideoDataFrame.
 @param uid The user ID of the remote user.

 @return - YES: Sets the SDK to receive the video frame.
 - NO: Sets the SDK to discard the video frame.
 */
- (BOOL)onRenderVideoFrame:(AgoraVideoDataFrame*)videoFrame forUid:(unsigned int)uid;
/** Sets the format of the raw video data output by the SDK.

 @since v3.4.5

 If you want to get raw video data in a color encoding format other than YUV
 420, you need to implement the `getVideoFormatPreference` callback in
 AgoraVideoDataFrameProtocol. After you successfully register the raw video
 frame protocol, the SDK triggers this callback each time a video frame is
 received. You need to set the desired color encoding format of the video
 data in the return value of this callback.

 @note This method applies to iOS only.

 @return The color encoding format of the raw video data output by the SDK.
 See AgoraVideoFrameType.
 */
- (AgoraVideoFrameType)getVideoFormatPreference;
/** Sets whether to rotate the raw video data output by the SDK.

 @since v3.4.5

 If you want to get raw video data that has been rotated according to the
 value of `rotation` in AgoraVideoDataFrame, you need to implement the
 `getRotationApplied` callback in AgoraVideoDataFrameProtocol. After you
 successfully register the raw video frame protocol, the SDK triggers this
 callback each time a video frame is received. You need to set whether to
 rotate the observed raw video data in the return value of this callback.

 **Note**:

 - This method applies to iOS only.
 - This function supports video data in RGBA and YUV 420 color encoding
 formats only.

 @return Whether to rotate the raw video data output by the SDK:

 - YES: Rotate the raw video data.
 - NO: (Default) Do not rotate the raw video data.
 */
- (BOOL)getRotationApplied;
/** Sets whether to mirror the raw video data output by the SDK.

 @since v3.4.5

 If you want to get the mirrored raw video data, you need to implement the
 `getMirrorApplied` callback in AgoraVideoDataFrameProtocol. After you
 successfully register the raw video frame observer, the SDK triggers this
 callback each time a video frame is received. You need to set whether to
 mirror the observed raw video data in the return value of this callback.

 **Note**:

 - This method applies to iOS only.
 - This function supports video data in RGBA and YUV 420 color encoding
 formats only.

 @return Whether to mirror the raw video data output by the SDK:

 - YES: Mirror the raw video data.
 - NO: (Default) Do not mirror the raw video data.
 */
- (BOOL)getMirrorApplied;
/** Sets the video observation positions.

 @since v3.4.5

 After you successfully register the raw video frame observer, the SDK uses
 the `getObservedFramePosition` callback to determine at each specific
 video-frame processing node whether to trigger the following callbacks:

 - [onCaptureVideoFrame]([AgoraVideoDataFrameProtocol onCaptureVideoFrame:])
 - [onPreEncodeVideoFrame]([AgoraVideoDataFrameProtocol onPreEncodeVideoFrame:])
 - [onRenderVideoFrame]([AgoraVideoDataFrameProtocol onRenderVideoFrame:forUid:]) or
 [onRenderVideoFrameEx]([AgoraVideoDataFrameProtocol onRenderVideoFrameEx:forUid:inChannel:])

 You can set the position or positions that you want to observe by modifying
 the return value of `getObservedFramePosition` according to your scenario.

 **Note**:

 - This method applies to iOS only.
 - To observe multiple positions, use `|` (the OR operator).
 - The default return value of this callback is
 `AgoraVideoFramePositionPostCapture (1 << 0)` and
 `AgoraVideoFramePositionPreRenderer (1 << 1)`.
 - To conserve system resources of the device, you can reduce the number of
 observation positions appropriately according to your scenario.

 @return The bit mask of the observation positions. See AgoraVideoFramePosition.
 */
- (AgoraVideoFramePosition)getObservedFramePosition;

/** Sets whether the SDK outputs remote video data received in multiple channels.

 @since v3.4.5

 In a multi-channel (AgoraRtcChannel) scenario, if you want to get the remote
 video data received in multiple channels, you need to implement the
 `isMultipleChannelFrameWanted` callback in AgoraVideoDataFrameProtocol and
 set the return value of this callback to `YES`. The SDK triggers the
 [onRenderVideoFrameEx]([AgoraVideoDataFrameProtocol onRenderVideoFrameEx:forUid:inChannel:])
 callback each time a video frame is received, from which you can get the
 expected multi-channel video data.

 **Note**:

 - This method applies to iOS only.
 - The SDK chooses to trigger either the
 [onRenderVideoFrame]([AgoraVideoDataFrameProtocol onRenderVideoFrame:forUid:]) or
 [onRenderVideoFrameEx]([AgoraVideoDataFrameProtocol onRenderVideoFrameEx:forUid:inChannel:])
 callback depending on the return value that you set in the
 `isMultipleChannelFrameWanted` callback. Agora recommends that you set the
 return value as `YES` in a multi-channel scenario.

 @return Whether the SDK outputs remote video data received in multiple channels:

 - YES: The SDK uses `onRenderVideoFrameEx` to output remote video data
 received in multiple channels.
 - NO: (Default) The SDK uses `onRenderVideoFrame` to output remote video data
 received in a single channel.
 */
- (BOOL)isMultipleChannelFrameWanted;

/** Gets the remote video data received in multiple channels.

 @since v3.4.5

 After you successfully register the raw video frame protocol and set the
 return value of
 [isMultipleChannelFrameWanted]([AgoraVideoDataFrameProtocol isMultipleChannelFrameWanted])
 as `YES`, the SDK triggers this callback each time a video frame is received.
 You get the remote video data received in multiple channels in `videoFrame`
 and then process the video data according to your scenario. After processing,
 you can pass the processed video data back to the SDK.

 **Note**:

 - This callback applies to iOS only.
 - If you get the video data in RGBA color encoding format, Agora does not
 support using this callback to send the processed data in RGBA color encoding
 format back to the SDK.

 @param videoFrame The video frame. See AgoraVideoDataFrame.
 @param uid The user ID of the remote user.
 @param channelId The channel name.

 @return - YES: Sets the SDK to receive the video frame.
 - NO: Sets the SDK to discard the video frame.
 */
- (BOOL)onRenderVideoFrameEx:(AgoraVideoDataFrame*)videoFrame forUid:(unsigned int)uid inChannel:(NSString*)channelId;

@end

/** The protocol of local encoded video frame.

 @since v3.4.5

  @note This protocol applies to iOS only.
 */
@protocol AgoraVideoEncodedFrameProtocol <NSObject>

@required
/** Gets the local encoded video frame.

 @since v3.4.5

 After you successfully register the local encoded video frame protocol, the
 SDK triggers this callback each time a video frame is received. You can get
 the local encoded video frame in `VideoEncodedFrame` and then process the
 video data according to your scenario. After processing, you can use
 `VideoEncodedFrame` to pass the processed video data back to the SDK.

 @note This callback applies to iOS only.

 @param VideoEncodedFrame The local encoded video frame.
 See AgoraVideoEncodedFrame.

 @return - YES: Sets the SDK to receive the video frame.
 - NO: Sets the SDK to discard the video frame.
 */
- (BOOL)onVideoEncodedFrame:(AgoraVideoEncodedFrame*)VideoEncodedFrame;

@end
