#import <Foundation/Foundation.h>
#import <AgoraRtcKit/AgoraRtcEngineKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * A `RtcEnginePlugin` allows developers to interact with the `RtcEngine` which created from flutter
 * side.
 */
@protocol RtcEnginePlugin

/**
 * This callback will be called when the `RtcEngine` is created by
 [RtcEngine.createWithContext](https://docs.agora.io/cn/Video/API%20Reference/flutter/agora_rtc_engine/RtcEngine/createWithContext.html)
 * function from flutter.

 * NOTE that you should not call `AgoraRtcEngineKit.destroy`, because it will also destroy the `RtcEngine` 
 * used by flutter side.
 *
 * @param rtcEngine The same `AgoraRtcEngineKit` used by flutter side
 */
- (void)onRtcEngineCreated:(AgoraRtcEngineKit *_Nullable)rtcEngine;

/**
 * This callback will be called when the [RtcEngine.destroy](https://docs.agora.io/cn/Video/API%20Reference/flutter/v4.0.7/rtc_channel/RtcChannel/destroy.html)
 * function is called from flutter.
 */
- (void)onRtcEngineDestroyed;
@end

NS_ASSUME_NONNULL_END
