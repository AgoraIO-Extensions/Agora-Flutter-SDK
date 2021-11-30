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

//namespace {
//class EventHandler : public IrisEventHandler {
//public:
//  EventHandler(void *plugin) : plugin_(plugin) {}
//
//  void OnEvent(const char *event, const char *data) override {
//    @autoreleasepool {
//      AgoraRtcChannelPlugin *plugin = (__bridge AgoraRtcChannelPlugin *)plugin_;
//      if ([plugin events]) {
//        NSString *eventApple = [NSString stringWithUTF8String:event];
//        NSString *dataApple = [NSString stringWithUTF8String:data];
//        [plugin events](@{@"methodName" : eventApple, @"data" : dataApple});
//      }
//    }
//  }
//
//  void OnEvent(const char *event, const char *data, const void *buffer,
//               unsigned int length) override {
//    @autoreleasepool {
//      AgoraRtcChannelPlugin *plugin = (__bridge AgoraRtcChannelPlugin *)plugin_;
//      if ([plugin events]) {
//        NSString *eventApple = [NSString stringWithUTF8String:event];
//        NSString *dataApple = [NSString stringWithUTF8String:data];
//        FlutterStandardTypedData *bufferApple = [FlutterStandardTypedData
//            typedDataWithBytes:[[NSData alloc] initWithBytes:buffer
//                                                      length:length]];
//        [plugin events](@{
//          @"methodName" : eventApple,
//          @"data" : dataApple,
//          @"buffer" : bufferApple
//        });
//      }
//    }
//  }
//
//private:
//  void *plugin_;
//};
//}

//@interface AgoraRtcChannelPlugin ()
//@property(nonatomic) EventHandler *handler;
//@end

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
//  instance.handler = new ::EventHandler((__bridge void *)instance);
    
    
    
//  instance.engine->channel()->SetEventHandler(instance.handler);
  instance.callApiMethodCallHandler = [[RtcChannelCallApiMethodCallHandler alloc] initWith:engine];
  [registrar addMethodCallDelegate:instance channel:methodChannel];
  [eventChannel setStreamHandler:instance.eventHandler];
}

//- (void)dealloc {
//  if (self.handler) {
//    delete self.handler;
//    self.handler = nil;
//  }
//}

- (void)handleMethodCall:(FlutterMethodCall *)call
                  result:(FlutterResult)result {
    [[self callApiMethodCallHandler] onMethodCall:call _:result];
//  if ([@"callApi" isEqualToString:call.method]) {
//    NSNumber *apiType = call.arguments[@"apiType"];
//    NSString *params = call.arguments[@"params"];
//    char res[kMaxResultLength] = "";
//
//    auto ret = self.engine->channel()->CallApi(
//        (ApiTypeChannel)[apiType unsignedIntValue], [params UTF8String], res);
//
//    if (ret == 0) {
//      std::string res_str(res);
//      if (res_str.empty()) {
//        result(nil);
//      } else {
//        result([NSString stringWithUTF8String:res]);
//      }
//    } else if (ret > 0) {
//      result(@(ret));
//    } else {
//      result([FlutterError errorWithCode:[NSString stringWithFormat:@"%d", ret]
//                                 message:nil
//                                 details:nil]);
//    }
//  } else if ([@"callApiWithBuffer" isEqualToString:call.method]) {
//    NSNumber *apiType = call.arguments[@"apiType"];
//    NSString *params = call.arguments[@"params"];
//    FlutterStandardTypedData *buffer = call.arguments[@"buffer"];
//    char res[kMaxResultLength] = "";
//
//    auto ret = self.engine->channel()->CallApi(
//        (ApiTypeChannel)[apiType unsignedIntValue], [params UTF8String],
//        (void *)[[buffer data] bytes], res);
//
//    if (ret == 0) {
//      std::string res_str(res);
//      if (res_str.empty()) {
//        result(nil);
//      } else {
//        result([NSString stringWithUTF8String:res]);
//      }
//    } else if (ret > 0) {
//      result(@(ret));
//    } else {
//      result([FlutterError errorWithCode:[NSString stringWithFormat:@"%d", ret]
//                                 message:nil
//                                 details:nil]);
//    }
//  } else {
//    result(FlutterMethodNotImplemented);
//  }
}

+ (void)registerWithRegistrar:(nonnull id<FlutterPluginRegistrar>)registrar {
}


//- (FlutterError *_Nullable)onCancelWithArguments:(id _Nullable)arguments {
//  self.events = nil;
//  return nil;
//}
//
//- (FlutterError *_Nullable)onListenWithArguments:(id _Nullable)arguments
//                                       eventSink:
//                                           (nonnull FlutterEventSink)events {
//  self.events = events;
//  return nil;
//}
@end
