#import <Foundation/Foundation.h>
#import "AgoraRtcChannelPlugin.h"
#import <AgoraRtcWrapper/iris_rtc_engine.h>
#import "CallApiMethodCallHandler.h"
#import "FlutterIrisEventHandler.h"


@interface AgoraRtcChannelPlugin ()

@property(nonatomic) agora::iris::rtc::IrisRtcEngine *irisRtcEngine;


@property(nonatomic) FlutterIrisEventHandler *eventHandler;

@property(nonatomic) CallApiMethodCallHandler *callApiMethodCallHandler;

@end

@implementation AgoraRtcChannelPlugin

- (instancetype)initWith:(void *)irisRtcEngine binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
    self.irisRtcEngine = (agora::iris::rtc::IrisRtcEngine *)irisRtcEngine;
    
    self.eventHandler = [[RtcChannelFlutterIrisEventHandler alloc] initWith:self.irisRtcEngine];
    self.callApiMethodCallHandler = [[RtcChannelCallApiMethodCallHandler alloc] initWith:self.irisRtcEngine];
    
    FlutterMethodChannel *methodChannel =
        [FlutterMethodChannel methodChannelWithName:@"agora_rtc_channel"
                                    binaryMessenger:messenger];
    FlutterEventChannel *eventChannel =
        [FlutterEventChannel eventChannelWithName:@"agora_rtc_channel/events"
                                  binaryMessenger:messenger];
    __weak __typeof(self) weakSelf = self;
    [methodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        if (weakSelf) {
            [[weakSelf callApiMethodCallHandler] onMethodCall:call _:result];
        }
        
    }];
    
    [eventChannel setStreamHandler:self.eventHandler];
    
  return self;
}

@end
