#import "AgoraRtcChannelPlugin.h"
#import <AgoraRtcWrapper/iris_rtc_channel.h>
#import <AgoraRtcWrapper/iris_rtc_engine.h>
#import "CallApiMethodCallHandler.h"
#import "FlutterIrisEventHandler.h"
#import <string>

using namespace agora::iris;
using namespace agora::iris::rtc;

@interface AgoraRtcChannelPlugin ()
@property(nonatomic) IrisRtcEngine *engine;
@property(nonatomic) FlutterEventSink events;
@property(nonatomic) CallApiMethodCallHandler *callApiMethodCallHandler;
@property(nonatomic) FlutterIrisEventHandler *eventHandler;
@end

@implementation AgoraRtcChannelPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar
                       engine:(void *)engine {
  FlutterMethodChannel *methodChannel =
      [FlutterMethodChannel methodChannelWithName:@"agora_rtc_channel"
                                  binaryMessenger:[registrar messenger]];
  FlutterEventChannel *eventChannel =
      [FlutterEventChannel eventChannelWithName:@"agora_rtc_channel/events"
                                binaryMessenger:[registrar messenger]];
  AgoraRtcChannelPlugin *instance = [[AgoraRtcChannelPlugin alloc] init];
  instance.engine = (IrisRtcEngine *)engine;
  instance.eventHandler = [[RtcChannelFlutterIrisEventHandler alloc] initWith:engine];
  instance.callApiMethodCallHandler = [[RtcChannelCallApiMethodCallHandler alloc] initWith:engine];
  [registrar addMethodCallDelegate:instance channel:methodChannel];
  [eventChannel setStreamHandler:instance.eventHandler];
}

- (void)handleMethodCall:(FlutterMethodCall *)call
                  result:(FlutterResult)result {
    [[self callApiMethodCallHandler] onMethodCall:call _:result];
}

+ (void)registerWithRegistrar:(nonnull id<FlutterPluginRegistrar>)registrar {
}

@end
