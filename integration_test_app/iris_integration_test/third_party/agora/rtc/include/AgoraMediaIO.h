//
//  AgoraMediaIO.h
//  AgoraRtcEngineKit
//
//  Copyright (c) 2018 Agora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "AgoraEnumerates.h"
#import "AgoraObjects.h"

/** Video pixel format.

 This enumeration defines the pixel format of the video frame. Agora supports three pixel formats on iOS: I420, BGRA, and NV12. For information on the YVU format, see:

   * [FourCC YUV Pixel Formats](http://www.fourcc.org/yuv.php)
   * [Recommended 8-Bit YUV Formats for Video Rendering](https://docs.microsoft.com/zh-cn/windows/desktop/medfound/recommended-8-bit-yuv-formats-for-video-rendering)
 */
typedef NS_ENUM(NSUInteger, AgoraVideoPixelFormat) {
  /** I420 */
  AgoraVideoPixelFormatI420 = 1,
  /** BGRA */
  AgoraVideoPixelFormatBGRA = 2,
  /** NV12 */
  AgoraVideoPixelFormatNV12 = 8,
};

/** Video buffer type */
typedef NS_ENUM(NSInteger, AgoraVideoBufferType) {
  /** Use a pixel buffer to transmit the video data. */
  AgoraVideoBufferTypePixelBuffer = 1,
  /** Use raw data to transmit the video data. */
  AgoraVideoBufferTypeRawData = 2,
};

/** The capture type of the custom video source. */
typedef NS_ENUM(NSInteger, AgoraVideoCaptureType) {
  /** Unknown type. */
  AgoraVideoCaptureTypeUnknown = 0,
  /** (Default) Video captured by the camera. */
  AgoraVideoCaptureTypeCamera = 1,
  /** Video for screen sharing. */
  AgoraVideoCaptureTypeScreen = 2,
};

/** An object supporting video data in two formats; pixel buffer and raw data.

 When the video source is initialized, the media engine passes this object to you and you need to reserve it, and then pass the video frame to the media engine through this object once the video source is initialized.
 Call [bufferType]([AgoraVideoSinkProtocol bufferType]) to specify a buffer type. The video data can only be transmitted in the corresponding type.
 */
@protocol AgoraVideoFrameConsumer <NSObject>

/** Uses the video information in the pixel buffer.

 @param pixelBuffer Buffer type
 @param timestamp   Timestamp (ms) of the video frame. For each video frame, you need to set a timestamp.
 @param rotation    AgoraVideoRotation
 */
- (void)consumePixelBuffer:(CVPixelBufferRef _Nonnull)pixelBuffer withTimestamp:(CMTime)timestamp rotation:(AgoraVideoRotation)rotation;

/** Uses the video information in the raw data.

 @param rawData   Raw data of the video frame.
 @param timestamp Timestamp (ms) of the video frame.
 @param format    AgoraVideoPixelFormat
 @param size      Size of the raw video data.
 @param rotation  AgoraVideoRotation
 */
- (void)consumeRawData:(void* _Nonnull)rawData withTimestamp:(CMTime)timestamp format:(AgoraVideoPixelFormat)format size:(CGSize)size rotation:(AgoraVideoRotation)rotation;
@end

/** Defines a set of protocols to implement the custom video source and pass it to the underlying media engine to replace the default video source.

 `AgoraVideoSourceProtocol` allows you to take the ownership of the video source and manipulate it.
 By default, when enabling real-time communications, the Agora SDK enables the default video input device (built-in camera) to start video streaming.
 By calling [setVideoSource]([AgoraRtcEngineKit setVideoSource:]), you can change the default video input device, control it, and send the video source from the specified input device to the Agora Media Engine to handle the remaining video processes; such as video filtering and publishing the video to the RTC connection.
 Once you have implemented this interface, the Agora Media Engine automatically releases the ownership of the current video input device and passes the ownership to you, so that you can use the same video input device to capture the video stream.
 `AgoraVideoSourceProtocol` consists of the following methods:

 * Initializes the Video Source ([shouldInitialize](shouldInitialize))
 * Enables the Video Source ([shouldStart](shouldStart))
 * Disables the Video Source ([shouldStop](shouldStop))
 * Releases the Video Source ([shouldDispose](shouldDispose))
 * Gets the Buffer Type (AgoraVideoBufferType)
 * Gets the capture type of the custom video source (AgoraVideoCaptureType)
 * Gets the content hint of the custom video source (AgoraVideoContentHint)

 Note:

 * All methods in `AgoraVideoSourceProtocol` are callbacks. The media engine maintains a finite state machine and uses these methods at the right time. Do not use these methods directly in the app.
 * These methods are synchronized.
 * If the media engine restarts during the process, these methods can be repeated for a couple of times.
 * These methods are not in the primary thread.

 When using the `AgoraVideoSourceProtocol`, call AgoraVideoBufferType, AgoraVideoPixelFormat, and AgoraVideoRotation to set the buffer type, pixel format, and rotation angle of the transmitted video.
 */
@protocol AgoraVideoSourceProtocol <NSObject>
@required
/** An AgoraVideoFrameConsumer object that the SDK passes to you. You need to reserve this object and use it to send the video frame to
 the SDK once the custom video source is started. See [AgoraVideoFrameConsumer](AgoraVideoFrameConsumer).

 @note The SDK does not support the alpha channel, and discards any alpha value passed to the SDK.
 */
@property(strong) id<AgoraVideoFrameConsumer> _Nullable consumer;
/** Initializes the video source.

 The media engine calls this method to initialize the video source. You can also initialize the video source before this method is called and return YES to the media engine in this method. You need to pass YES or NO in this method to tell the media engine if the video source is initialized.
 When the video source is initialized, the media engine initializes the AgoraVideoFrameConsumer pointer in AgoraVideoSourceProtocol, then the video source sends the video frame to the media engine through the AgoraVideoFrameConsumer method.

 @return * YES: If the external video source is initialized.
 * NO: If the external video source is not ready or fails to initialize, the media engine stops and reports the error.
 */
- (BOOL)shouldInitialize;

/** Enables the video source.

 Call this method when the media engine is ready to start video streaming. You should start the video source to capture the video frame. Once the frame is ready, use AgoraVideoFrameConsumer to consume the video frame.
 Pass one of the following return values to the media engine:

 * YES: If the external video source is enabled and AgoraVideoFrameConsumer is called to receive video frames.
 * NO: If the external video source is not ready or fails to enable, the media engine stops and reports the error.

 After YES is returned, video frames can be passed to the media engine through the preset AgoraVideoFrameConsumer interface method.
 */
- (void)shouldStart;

/** Disables the video source.

 Call this method when the media engine stops streaming. You should then stop capturing the video frame and consuming it. After this method is called, the video frames are discarded by the media engine.
 */
- (void)shouldStop;

/** Releases the video source.

Call this method when AgoraVideoFrameConsumer is released by the media engine. You can now release the video source as well as AgoraVideoFrameConsumer.
 */
- (void)shouldDispose;

/** Gets the buffer type.

 Passes the buffer type previously set in `AgoraVideoBufferType` to the media engine. This buffer type is used to set up the correct media engine environment.

 @return return AgoraVideoBufferType
 */
- (AgoraVideoBufferType)bufferType;

/** Gets the capture type of the custom video source.

 @since v3.1.0

 Before you initialize the custom video source, the SDK triggers this callback to query the capture type
 of the video source. You must specify the capture type in the return value and then pass it to the SDK.
 The SDK enables the corresponding video processing algorithm according to the capture type after
 receiving the video frame.

 @return AgoraVideoCaptureType
 */
- (AgoraVideoCaptureType)captureType;

/** Gets the content hint of the custom video source.

 @since v3.1.0

 If you specify the custom video source as a screen-sharing video, the SDK triggers this callback to query
 the content hint of the video source before you initialize the video source. You must specify the content
 hint in the return value and then pass it to the SDK. The SDK enables the corresponding video processing
 algorithm according to the content hint after receiving the video frame.

 @return AgoraVideoContentHint
 */
- (AgoraVideoContentHint)contentHint;
@end

/** Defines a set of protocols to implement the custom video sink and pass it to the underlying media engine to replace the default video sink.

 AgoraVideoSinkProtocol allows you to implement the custom video source.
 By default, when you try to enable real-time communications, the Agora SDK enables the default video sink to start video rendering. By calling [setLocalVideoRenderer]([AgoraRtcEngineKit setLocalVideoRenderer:]) and [setRemoteVideoRenderer]([AgoraRtcEngineKit setRemoteVideoRenderer:forUserId:]), you can change the default video sink.
 Once you implement this interface, you receive callbacks from the media engine to indicate the state of the custom video sink, the underlying media engine, and enable their synchronization. Follow each callback to handle the resource allocation, and to release and receive the video frame from the media engine.
 AgoraVideoSinkProtocol defines a set of protocols to create a customized video sink. The AgoraVideoFrameConsumer interface passes the video frames to the media engine, which then passes them to the renderer.
 After a customized video sink is created, the app passes it to the media engine, see [setLocalVideoRenderer]([AgoraRtcEngineKit setLocalVideoRenderer:]) and [setRemoteVideoRenderer]([AgoraRtcEngineKit setRemoteVideoRenderer:forUserId:]).
 AgoraVideoSinkProtocol consists of the following methods:

 * Initializes the Video Sink ([shouldInitialize](shouldInitialize))
 * Enables the Video Sink ([shouldStart](shouldStart))
 * Disables the Video Sink ([shouldStop](shouldStop))
 * Releases the Video Sink ([shouldDispose](shouldDispose))
 * Gets the Buffer Type ([bufferType](bufferType))
 * Gets the Pixel Format ([pixelFormat](pixelFormat))
 * (Optional) Outputs the Video in the Pixel Buffer ([renderPixelBuffer](renderPixelBuffer:rotation:))
 * (Optional) Outputs the Video in the Raw Data ([renderRawData](renderRawData:size:rotation:))

 Note: All methods defined in AgoraVideoSinkProtocol are callbacks. The media engine uses these methods to inform the customized renderer of its internal changes.
 An example is shown in the following steps to customize the video sink:

 1. Call bufferType and AgoraVideoPixelFormat to set the buffer type and pixel format of the video frame.
 2. Implement [shouldInitialize](shouldInitialize), [shouldStart](shouldStart), [shouldStop](shouldStop), and [shouldDispose](shouldDispose) to manage the customized video sink.
 3. Implement the buffer type and pixel format as specified in AgoraVideoFrameConsumer.
 4. Create the customized video sink object.
 5. Call the [setLocalVideoRenderer]([AgoraRtcEngineKit setLocalVideoRenderer:]) and [setRemoteVideoRenderer]([AgoraRtcEngineKit setRemoteVideoRenderer:forUserId:]) methods to set the local and remote renderers.
 6. The media engine calls functions in AgoraVideoSinkProtocol according to its internal state.
 */
@protocol AgoraVideoSinkProtocol <NSObject>
@required
/** Initializes the video  sink.

 You can also initialize the video sink before this method is called and return YES in this method.

 @return * YES: If the video sink is initialized.
 * NO: If the video sink is not ready or fails to initialize, the media engine stops and reports the error.
 */
- (BOOL)shouldInitialize;

/** Enables the video sink.

 Call this method when the media engine starts streaming.

 * YES: If the video sink is ready. The media engine provides the video frame to the custom video sink by calling the AgoraVideoFrameConsumer interface.
 * NO: If the video sink is not ready.
 */
- (void)shouldStart;

/** Disables the video sink.

 Call this method when the media engine stops video streaming. You should then stop the video sink.
 */
- (void)shouldStop;

/** Releases the video sink.

 Call this method when the media engine wants to release the video sink resources.
 */
- (void)shouldDispose;

/** Gets the buffer type and passes the buffer type specified in `AgoraVideoBufferType` to the media engine.

 @return bufferType AgoraVideoBufferType
 */
- (AgoraVideoBufferType)bufferType;

/** Gets the pixel format and passes it to the media engine.

 @return pixelFormat AgoraVideoPixelFormat
 */
- (AgoraVideoPixelFormat)pixelFormat;

@optional
/** (Optional) Outputs the video in the pixel buffer.

 @param pixelBuffer Video in the pixel buffer.
 @param rotation    Clockwise rotating angle of the video frame. See AgoraVideoRotation.
 */
- (void)renderPixelBuffer:(CVPixelBufferRef _Nonnull)pixelBuffer rotation:(AgoraVideoRotation)rotation;

/** (Optional) Outputs the video in the raw data.

 @param rawData  Raw video data.
 @param size     Size of the raw video.
 @param rotation Clockwise rotating angle of the video frame. See AgoraVideoRotation.
 */
- (void)renderRawData:(void* _Nonnull)rawData size:(CGSize)size rotation:(AgoraVideoRotation)rotation;
@end

#pragma mark - Agora Default Media IO
/** Default camera position */
typedef NS_ENUM(NSInteger, AgoraRtcDefaultCameraPosition) {
  /** Front camera */
  AgoraRtcDefaultCameraPositionFront = 0,
  /** Rear camera */
  AgoraRtcDefaultCameraPositionBack = 1,
};

__attribute__((visibility("default"))) @interface AgoraRtcDefaultCamera : NSObject<AgoraVideoSourceProtocol>
#if defined(TARGET_OS_IPHONE) && TARGET_OS_IPHONE
@property(nonatomic, assign) AgoraRtcDefaultCameraPosition position;
- (instancetype _Nonnull)initWithPosition:(AgoraRtcDefaultCameraPosition)position;
#endif
@end

#if (!(TARGET_OS_IPHONE) && (TARGET_OS_MAC))
__attribute__((visibility("default"))) @interface AgoraRtcScreenCapture : NSObject<AgoraVideoSourceProtocol>
@property(nonatomic, assign, readonly) BOOL ifWindowShare;
@property(nonatomic, assign, readonly) NSUInteger displayId;
@property(nonatomic, assign, readonly) NSUInteger windowId;
@property(nonatomic, assign, readonly) CGRect rect;
@property(nonatomic, assign, readonly) CGSize dimensions;
@property(nonatomic, assign, readonly) NSInteger frameRate;
@property(nonatomic, assign, readonly) NSInteger bitrate;
@property(nonatomic, assign, readonly) BOOL captureMouseCursor;
@property(nonatomic, assign, readonly) BOOL windowFocus;

+ (instancetype _Nonnull)screenCaptureWithId:(NSUInteger)displayId rect:(CGRect)rect dimensions:(CGSize)dimensions frameRate:(NSInteger)frameRate bitrate:(NSInteger)bitrate captureMouseCursor:(BOOL)captureMouseCursor;
+ (instancetype _Nonnull)windowCaptureWithId:(NSUInteger)windowId rect:(CGRect)rect dimensions:(CGSize)dimensions frameRate:(NSInteger)frameRate bitrate:(NSInteger)bitrate captureMouseCursor:(BOOL)captureMouseCursor windowFocus:(BOOL)windowFocus;
@end
#endif

__attribute__((visibility("default"))) @interface AgoraRtcDefaultRenderer : NSObject<AgoraVideoSinkProtocol>
@property(nonatomic, strong, readonly) VIEW_CLASS* _Nonnull view;
@property(nonatomic, assign) AgoraVideoRenderMode mode;
- (instancetype _Nonnull)initWithView:(VIEW_CLASS* _Nonnull)view renderMode:(AgoraVideoRenderMode)mode;
@end
