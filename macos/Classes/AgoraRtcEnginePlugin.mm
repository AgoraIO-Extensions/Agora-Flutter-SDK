#import "AgoraRtcEnginePlugin.h"
#import "AgoraRtcChannelPlugin.h"
#import "AgoraRtcDeviceManagerPlugin.h"
#import "AgoraTextureViewFactory.h"
#import "CallApiMethodCallHandler.h"
#import "FlutterIrisEventHandler.h"
#import <AgoraRtcWrapper/iris_rtc_engine.h>
#import <AgoraRtcWrapper/iris_video_processor.h>
#import <string>

using namespace agora::iris;
using namespace agora::iris::rtc;

@interface AgoraRtcEnginePlugin ()
@property(nonatomic) IrisRtcEngine *engine_main;
@property(nonatomic) IrisRtcEngine *engine_sub;
@property(nonatomic) CallApiMethodCallHandler *callApiMethodCallHandlerMain;
@property(nonatomic) CallApiMethodCallHandler *callApiMethodCallHandlerSub;
@property(nonatomic) FlutterIrisEventHandler *eventHandler;
@property(nonatomic) FlutterEventSink events;
@property(nonatomic, strong) AgoraTextureViewFactory *factory;
@end

@implementation AgoraRtcEnginePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  FlutterMethodChannel *methodChannel =
      [FlutterMethodChannel methodChannelWithName:@"agora_rtc_engine"
                                  binaryMessenger:[registrar messenger]];
  FlutterEventChannel *eventChannel =
      [FlutterEventChannel eventChannelWithName:@"agora_rtc_engine/events"
                                binaryMessenger:[registrar messenger]];
  AgoraRtcEnginePlugin *instance = [[AgoraRtcEnginePlugin alloc] init];
  [instance
      setFactory:[[AgoraTextureViewFactory alloc] initWithRegistrar:registrar]];

  instance.eventHandler =
      [[FlutterIrisEventHandler alloc] initWith:instance.engine_main
                                      subEngine:instance.engine_sub];

  [registrar addMethodCallDelegate:instance channel:methodChannel];
  [eventChannel setStreamHandler:instance.eventHandler];

  [AgoraRtcChannelPlugin registerWithRegistrar:registrar
                                        engine:instance.engine_main];
  [AgoraRtcDeviceManagerPlugin registerWithRegistrar:registrar
                                              engine:instance.engine_main];
}

- (instancetype)init {
  self = [super init];
  if (self) {
    self.engine_main = new IrisRtcEngine();
    self.engine_main->raw_data()->Attach(new IrisVideoFrameBufferManager);
    self.callApiMethodCallHandlerMain =
        [[CallApiMethodCallHandler alloc] initWith:self.engine_main];

    self.engine_sub = new IrisRtcEngine(nullptr, kEngineTypeSubProcess);
    self.engine_sub->raw_data()->Attach(new IrisVideoFrameBufferManager);
    self.callApiMethodCallHandlerSub =
        [[CallApiMethodCallHandler alloc] initWith:self.engine_sub];
  }
  return self;
}

- (void)dealloc {
  if (self.engine_main) {
    delete self.engine_main;
    self.engine_main = nil;
  }

  if (self.engine_sub) {
    delete self.engine_sub;
    self.engine_sub = nil;
  }
}

- (IrisRtcEngine *)engine:(id)arguments {
  if ([self isSubProcess:arguments]) {
    return self.engine_sub;
  } else {
    return self.engine_main;
  }
}

- (BOOL)isSubProcess:(id)arguments {
  NSNumber *subProcess = arguments[@"subProcess"];
  return [subProcess boolValue];
}

- (void)handleMethodCall:(FlutterMethodCall *)call
                  result:(FlutterResult)result {
#if DEBUG
  if ([@"getIrisRtcEngineIntPtr" isEqualToString:call.method]) {
    result(@((intptr_t)self.engine_main));
    return;
  }
#endif

  if ([@"createTextureRender" isEqualToString:call.method]) {
    int64_t textureId = [self.factory
        createTextureRenderer:[self engine:call.arguments]->raw_data()
                                  -> buffer_manager()];
    result(@(textureId));
  } else if ([@"destroyTextureRender" isEqualToString:call.method]) {
    NSNumber *textureId = call.arguments[@"id"];
    [self.factory destroyTextureRenderer:[textureId integerValue]];
    result(nil);
  } else {
    if ([self isSubProcess:call.arguments]) {
      [[self callApiMethodCallHandlerSub] onMethodCall:call _:result];
    } else {
      [[self callApiMethodCallHandlerMain] onMethodCall:call _:result];
    }
  }
}
@end
