#import "AgoraRtcChannelPlugin.h"
#import <AgoraRtcWrapper/iris_rtc_channel.h>
#import <AgoraRtcWrapper/iris_rtc_engine.h>
#import <string>

using namespace agora::iris;
using namespace agora::iris::rtc;

@interface AgoraRtcChannelPlugin ()
@property(nonatomic) IrisRtcEngine *engine;
@property(nonatomic) FlutterEventSink events;
@end

namespace {
class EventHandler : public IrisEventHandler {
public:
  void OnEvent(const char *event, const char *data) override {
    @autoreleasepool {
      AgoraRtcChannelPlugin *plugin = (__bridge AgoraRtcChannelPlugin *)plugin_;
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
      AgoraRtcChannelPlugin *plugin = (__bridge AgoraRtcChannelPlugin *)plugin_;
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

@interface AgoraRtcChannelPlugin ()
@property(nonatomic) EventHandler *handler;
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
  instance.handler = new ::EventHandler;
  instance.handler->plugin_ = (__bridge void *)instance;
  instance.engine->channel()->SetEventHandler(instance.handler);
  [registrar addMethodCallDelegate:instance channel:methodChannel];
  [eventChannel setStreamHandler:instance];
}

- (void)handleMethodCall:(FlutterMethodCall *)call
                  result:(FlutterResult)result {
  if ([@"callApi" isEqualToString:call.method]) {
    NSNumber *apiType = call.arguments[@"apiType"];
    NSString *params = call.arguments[@"params"];
    char res[kMaxResultLength] = "";
    auto ret = self.engine->channel()->CallApi(
        (ApiTypeChannel)[apiType unsignedIntValue], [params UTF8String], res);

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
