//
//  AgoraConstants.h
//  AgoraRtcEngineKit
//
//  Copyright (c) 2018 Agora. All rights reserved.
//
#import <Foundation/Foundation.h>
#if defined(TARGET_OS_IPHONE) && TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#elif defined(TARGET_OS_MAC) && TARGET_OS_MAC
#import <AppKit/AppKit.h>
#endif

/** The standard bitrate set in [setVideoEncoderConfiguration]([AgoraRtcEngineKit setVideoEncoderConfiguration:]).

(Recommended) The standard bitrate mode. In this mode, the bitrate under the interactive live streaming and communication profiles differs:

    - Communication profile: The video bitrate is the same as the base bitrate.
    - Interactive live streaming profile: The video bitrate is twice the base bitrate.
 */
extern NSInteger const AgoraVideoBitrateStandard;

/** The compatible bitrate set in [setVideoEncoderConfiguration]([AgoraRtcEngineKit setVideoEncoderConfiguration:]).

The compatible bitrate mode. In this mode, the bitrate stays the same regardless of the channel profile. In the interactive live streaming channel, if you choose this mode, the video frame rate may be lower than the set value.
 */
extern NSInteger const AgoraVideoBitrateCompatible;

/** Use the default minimum bitrate.
 */
extern NSInteger const AgoraVideoBitrateDefaultMin;

/** 120 * 120
 */
extern CGSize const AgoraVideoDimension120x120;
/** 160 * 120
 */
extern CGSize const AgoraVideoDimension160x120;
/** 180 * 180
 */
extern CGSize const AgoraVideoDimension180x180;
/** 240 * 180
 */
extern CGSize const AgoraVideoDimension240x180;
/** 320 * 180
 */
extern CGSize const AgoraVideoDimension320x180;
/** 240 * 240
 */
extern CGSize const AgoraVideoDimension240x240;
/** 320 * 240
 */
extern CGSize const AgoraVideoDimension320x240;
/** 424 * 240
 */
extern CGSize const AgoraVideoDimension424x240;
/** 360 * 360
 */
extern CGSize const AgoraVideoDimension360x360;
/** 480 * 360
 */
extern CGSize const AgoraVideoDimension480x360;
/** 640 * 360
 */
extern CGSize const AgoraVideoDimension640x360;
/** 480 * 480
 */
extern CGSize const AgoraVideoDimension480x480;
/** 640 * 480
 */
extern CGSize const AgoraVideoDimension640x480;
/** 840 * 480
 */
extern CGSize const AgoraVideoDimension840x480;
/** 960 * 720 (Hardware dependent)
 */
extern CGSize const AgoraVideoDimension960x720;
/** 1280 * 720 (Hardware dependent)
 */
extern CGSize const AgoraVideoDimension1280x720;
#if TARGET_OS_MAC && !TARGET_OS_IPHONE
/** 1920 * 1080 (Hardware dependent, macOS only)
 */
extern CGSize const AgoraVideoDimension1920x1080;
/** Reserved for future use.
 */
extern CGSize const AgoraVideoDimension2540x1440;
/** Reserved for future use.
 */
extern CGSize const AgoraVideoDimension3840x2160;
#endif
