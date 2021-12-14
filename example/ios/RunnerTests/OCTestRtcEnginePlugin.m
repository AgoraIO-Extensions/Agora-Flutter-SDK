#import <Foundation/Foundation.h>
#import "OCTestRtcEnginePlugin.h"

@implementation OCTestRtcEnginePlugin

- (void)registerSelf {
    // Simulate call RtcEnginePluginRegistrant.register in oc
    [RtcEnginePluginRegistrant register:self];
}

- (void)unregisterSelf {
    // Simulate call RtcEnginePluginRegistrant.unregister in oc
    [RtcEnginePluginRegistrant unregister:self];
}

- (void)onRtcEngineCreated:(AgoraRtcEngineKit * _Nullable)rtcEngine { 
    _isRtcEngineCreated = true;
}

- (void)onRtcEngineDestroyed { 
    _isRtcEngineDestroyed = true;
}

@end
