#import <Foundation/Foundation.h>
#import "AgoraRtcChannelPlugin.h"
#import <AgoraRtcWrapper/iris_rtc_engine.h>
#import "CallApiMethodCallHandler.h"
#import "FlutterIrisEventHandler.h"


@interface AgoraRtcChannelPlugin ()

@property(nonatomic) agora::iris::rtc::IrisRtcEngine *irisRtcEngine;


@property(nonatomic) FlutterIrisEventHandler *eventHandler;

@property(nonatomic) FlutterEventSink eventSink;

@property(nonatomic) CallApiMethodCallHandler *callApiMethodCallHandler;

@end

@implementation AgoraRtcChannelPlugin

//+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
////  [SwiftAgoraRtcEnginePlugin registerWithRegistrar:registrar];
//
//    FlutterMethodChannel *methodChannel =
//        [FlutterMethodChannel methodChannelWithName:@"agora_rtc_channel"
//                                    binaryMessenger:[registrar messenger]];
//    FlutterEventChannel *eventChannel =
//        [FlutterEventChannel eventChannelWithName:@"agora_rtc_channel/events"
//                                  binaryMessenger:[registrar messenger]];
//    AgoraRtcEnginePlugin *instance = [[AgoraRtcEnginePlugin alloc] init];
//    [registrar addMethodCallDelegate:instance channel:methodChannel];
//    [eventChannel setStreamHandler:instance];
//
//}

- (instancetype)initWith:(void *)irisRtcEngine binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
    self.irisRtcEngine = (agora::iris::rtc::IrisRtcEngine *)irisRtcEngine;
    
//    self.eventHandler = new EventHandler(_eventSink);
//    self.irisRtcEngine->channel()->SetEventHandler(self.eventHandler);
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
    
    
//    AgoraRtcEnginePlugin *instance = [[AgoraRtcEnginePlugin alloc] init];
//    [registrar addMethodCallDelegate:instance channel:methodChannel];
    
    
    
    
    [eventChannel setStreamHandler:self.eventHandler];
    
    
    
//  self.irisRtcEngine = new agora::iris::rtc::IrisRtcEngine;
//      self.eventHandler = new agora::iris::EventHandler(_eventSink);
    
//  self.irisRtcEngine->SetEventHandler(self.eventHandler);
    
  return self;
}

- (FlutterError *_Nullable)onCancelWithArguments:(id _Nullable)arguments {
  self.eventSink = nil;
  return nil;
}

- (FlutterError *_Nullable)onListenWithArguments:(id _Nullable)arguments
                                       eventSink:
                                           (nonnull FlutterEventSink)events {
  self.eventSink = events;
  return nil;
}

- (void)dealloc {
//  delete self.irisRtcEngine;
    self.irisRtcEngine->channel()->SetEventHandler(NULL);
//  delete self.eventHandler;
}

@end
