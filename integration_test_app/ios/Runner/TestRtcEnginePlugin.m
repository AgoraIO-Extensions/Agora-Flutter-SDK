#import <Foundation/Foundation.h>
#import "TestRtcEnginePlugin.h"

@interface TestRtcEnginePlugin : NSObject <RtcEnginePlugin>
@property(nonatomic) bool isRtcEngineCreated;
@property(nonatomic) bool isRtcEngineDestroy;
@property(nonatomic) AgoraRtcEngineKit *_Nullable rtcEngine;

@end

@implementation TestRtcEnginePlugin

- (void)onRtcEngineCreated:(AgoraRtcEngineKit * _Nullable)rtcEngine {
    self.isRtcEngineCreated = true;
    self.isRtcEngineDestroy = false;
    self.rtcEngine = rtcEngine;
}

- (void)onRtcEngineDestroyed {
    self.isRtcEngineCreated = false;
    self.isRtcEngineDestroy = true;
}

@end

@interface TestRtcEnginePluginMethodChannel()
@property(nonatomic) TestRtcEnginePlugin *currentRtcEnginePlugin;
@end

@implementation TestRtcEnginePluginMethodChannel

- (void)setUp:(NSObject<FlutterBinaryMessenger>*)messenger {
    FlutterMethodChannel* methodChannel = [FlutterMethodChannel
                                            methodChannelWithName:@"agora_rtc_engine/integration_test/rtc_engine_plugin"
                                            binaryMessenger:messenger];

    [methodChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        if ([@"registerRtcEnginePlugin" isEqualToString:call.method]) {
            self.currentRtcEnginePlugin = [TestRtcEnginePlugin new];
            [RtcEnginePluginRegistrant register:self.currentRtcEnginePlugin];
            result(@true);
        } else if ([@"unregisterRtcEnginePlugin" isEqualToString:call.method]) {
            [RtcEnginePluginRegistrant unregister:self.currentRtcEnginePlugin];
            result(@true);
        } else if ([@"isRtcEngineCreated" isEqualToString:call.method]) {
            result(@([[self currentRtcEnginePlugin] isRtcEngineCreated]));
        } else if ([@"isRtcEngineDestroyed" isEqualToString:call.method]) {
            result(@([[self currentRtcEnginePlugin] isRtcEngineDestroy]));
        } else if ([@"getRtcEngineNativeHandleFromPlugin" isEqualToString:call.method]) {
            result(@((intptr_t)[[[self currentRtcEnginePlugin] rtcEngine] getNativeHandle]));
        } else {
            result(FlutterMethodNotImplemented);
          }
    }];
}

@end
