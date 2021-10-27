//
//  AudioOptions.h
//  AgoraAudioIO
//
//  Created by CavanSu on 12/03/2018.
//  Copyright © 2018 CavanSu. All rights reserved.
//

#ifndef AudioOptions_h
#define AudioOptions_h

typedef NS_ENUM(int, AudioCRMode) {
    AudioCRModeExterCaptureSDKRender = 1,
    AudioCRModeSDKCaptureExterRender = 2,
    AudioCRModeSDKCaptureSDKRender = 3,
    AudioCRModeExterCaptureExterRender = 4
};

typedef NS_ENUM(int, IOUnitType) {
    IOUnitTypeVPIO,
    IOUnitTypeRemoteIO
};

typedef NS_ENUM(int, ChannelMode) {
    ChannelModeCommunication = 0,
    ChannelModeLiveBroadcast = 1
};

typedef NS_ENUM(int, ClientRole) {
    ClientRoleAudience = 0,
    ClientRoleBroadcast = 1
};

//#if TARGET_OS_IPHONE
//#import "UIColor+CSRGB.h"
//#import "UIView+CSshortFrame.h"
//#define ThemeColor [UIColor Red: 122 Green: 203 Blue: 253]
//#endif

#endif /* AudioOptions_h */
