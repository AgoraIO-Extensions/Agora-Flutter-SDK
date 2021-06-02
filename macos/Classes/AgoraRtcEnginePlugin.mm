#import "AgoraRtcEnginePlugin.h"
#import "AgoraRtcChannelPlugin.h"
#import "AgoraRtcDeviceManagerPlugin.h"
#import "AgoraTextureViewFactory.h"
#import <AgoraRtcWrapper/iris_rtc_engine.h>
#import <string>

using namespace agora::iris;
using namespace agora::iris::rtc;

@interface AgoraRtcEnginePlugin ()
@property(nonatomic) IrisRtcEngine *engine_main;
@property(nonatomic) IrisRtcEngine *engine_sub;
@property(nonatomic) FlutterEventSink events;
@property(nonatomic, strong) AgoraTextureViewFactory *factory;
@end

namespace {
class EventHandler : public IrisEventHandler {
public:
  void OnEvent(const char *event, const char *data) override {
    @autoreleasepool {
      AgoraRtcEnginePlugin *plugin = (__bridge AgoraRtcEnginePlugin *)plugin_;
      if ([plugin events]) {
        NSString *eventApple = [NSString stringWithUTF8String:event];
        NSString *dataApple = [NSString stringWithUTF8String:data];
        [plugin events](@{@"methodName" : eventApple, @"data" : dataApple});
      }
    }
  }

  void OnEvent(const char *event, const char *data, const void *buffer,
               unsigned int length) override {
    @autoreleasepool {
      AgoraRtcEnginePlugin *plugin = (__bridge AgoraRtcEnginePlugin *)plugin_;
      if ([plugin events]) {
        NSString *eventApple = [NSString stringWithUTF8String:event];
        NSString *dataApple = [NSString stringWithUTF8String:data];
        [plugin events](@{@"methodName" : eventApple, @"data" : dataApple});
      }
    }
  }

public:
  void *plugin_;
};
}

@interface AgoraRtcEnginePlugin ()
@property(nonatomic) EventHandler *handler;
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
  [registrar addMethodCallDelegate:instance channel:methodChannel];
  [eventChannel setStreamHandler:instance];

  [AgoraRtcChannelPlugin registerWithRegistrar:registrar
                                        engine:instance.engine_main];
  [AgoraRtcDeviceManagerPlugin registerWithRegistrar:registrar
                                              engine:instance.engine_main];
}

- (instancetype)init {
  self = [super init];
  if (self) {
    self.engine_main = new IrisRtcEngine();
    self.engine_sub = new IrisRtcEngine(kEngineTypeSubProcess);
    self.handler = new ::EventHandler;
    self.handler->plugin_ = (__bridge void *)self;
    self.engine_main->SetEventHandler(self.handler);
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

- (void)handleMethodCall:(FlutterMethodCall *)call
                  result:(FlutterResult)result {
  if ([@"callApi" isEqualToString:call.method]) {
    NSNumber *apiType = call.arguments[@"apiType"];
    NSString *params = call.arguments[@"params"];
    char res[kMaxResultLength] = "";
    auto ret = self.engine_main->CallApi(
        (ApiTypeEngine)[apiType unsignedIntValue], [params UTF8String], res);

    if (ret == 0) {
      std::string res_str(res);
      if (res_str.empty()) {
        result(nil);
      } else {
        result([NSString stringWithUTF8String:res]);
      }
    } else if (ret > 0) {
      result(@(ret));
    } else {
      result([FlutterError errorWithCode:[NSString stringWithFormat:@"%d", ret]
                                 message:nil
                                 details:nil]);
    }
  } else if ([@"createTextureRender" isEqualToString:call.method]) {
    int64_t textureId = [self.factory
        createTextureRenderer:self.engine_main->raw_data()->renderer()];
    result(@(textureId));
  } else if ([@"destroyTextureRender" isEqualToString:call.method]) {
    NSNumber *textureId = call.arguments[@"id"];
    [self.factory destroyTextureRenderer:[textureId integerValue]];
    result(nil);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (FlutterError *_Nullable)onCancelWithArguments:(id _Nullable)arguments {
  self.events = nil;
  return nil;
}

- (FlutterError *_Nullable)onListenWithArguments:(id _Nullable)arguments
                                       eventSink:
                                           (nonnull FlutterEventSink)events {
  self.events = events;
  return nil;
}
@end
