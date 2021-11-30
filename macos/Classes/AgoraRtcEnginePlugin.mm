#import "AgoraRtcEnginePlugin.h"
#import "AgoraRtcChannelPlugin.h"
#import "AgoraRtcDeviceManagerPlugin.h"
#import "AgoraTextureViewFactory.h"
#import "CallApiMethodCallHandler.h"
#import <AgoraRtcWrapper/iris_rtc_engine.h>
#import <AgoraRtcWrapper/iris_video_processor.h>
#import "FlutterIrisEventHandler.h"
#import <string>

using namespace agora::iris;
using namespace agora::iris::rtc;

@interface AgoraRtcEnginePlugin ()
@property(nonatomic) IrisRtcEngine *engine_main;
@property(nonatomic) IrisRtcEngine *engine_sub;
@property(nonatomic) CallApiMethodCallHandler *callApiMethodCallHandlerMain;
@property(nonatomic) CallApiMethodCallHandler *callApiMethodCallHandlerSub;
@property(nonatomic) FlutterIrisEventHandler *eventHandler;
//@property(nonatomic) FlutterIrisEventHandler *eventHandlerSub;
@property(nonatomic) FlutterEventSink events;
@property(nonatomic, strong) AgoraTextureViewFactory *factory;
@end

//namespace {
//class EventHandler : public IrisEventHandler {
//public:
//  EventHandler(void *plugin, bool sub_process = false)
//      : plugin_(plugin), sub_process_(sub_process) {}
//
//  void OnEvent(const char *event, const char *data) override {
//    @autoreleasepool {
//      AgoraRtcEnginePlugin *plugin = (__bridge AgoraRtcEnginePlugin *)plugin_;
//      if ([plugin events]) {
//        NSString *eventApple = [NSString stringWithUTF8String:event];
//        NSString *dataApple = [NSString stringWithUTF8String:data];
//        [plugin events](@{
//          @"methodName" : eventApple,
//          @"data" : dataApple,
//          @"subProcess" : @(sub_process_)
//        });
//      }
//    }
//  }
//
//  void OnEvent(const char *event, const char *data, const void *buffer,
//               unsigned int length) override {
//    @autoreleasepool {
//      AgoraRtcEnginePlugin *plugin = (__bridge AgoraRtcEnginePlugin *)plugin_;
//      if ([plugin events]) {
//        NSString *eventApple = [NSString stringWithUTF8String:event];
//        NSString *dataApple = [NSString stringWithUTF8String:data];
//        FlutterStandardTypedData *bufferApple = [FlutterStandardTypedData
//            typedDataWithBytes:[[NSData alloc] initWithBytes:buffer
//                                                      length:length]];
//        [plugin events](@{
//          @"methodName" : eventApple,
//          @"data" : dataApple,
//          @"buffer" : bufferApple,
//          @"subProcess" : @(sub_process_)
//        });
//      }
//    }
//  }
//
//private:
//  void *plugin_;
//  bool sub_process_;
//};
//}

//@interface RtcEngineFlutterIrisEventHandler : FlutterIrisEventHandler
//
//@end
//
//@implementation RtcEngineFlutterIrisEventHandler
//
//
//
//@end

//@interface AgoraRtcEnginePlugin ()
//@property(nonatomic) EventHandler *handler_main;
//@property(nonatomic) EventHandler *handler_sub;
//@end

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
    
    instance.eventHandler = [[FlutterIrisEventHandler alloc] initWith:instance.engine_main subEngine:instance.engine_sub];
    
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
//    self.handler_main = new ::EventHandler((__bridge void *)self);
//    self.engine_main->SetEventHandler(self.handler_main);
      self.engine_main->raw_data()->Attach(new IrisVideoFrameBufferManager);
      self.callApiMethodCallHandlerMain = [[CallApiMethodCallHandler alloc] initWith:self.engine_main];
      
    self.engine_sub = new IrisRtcEngine(kEngineTypeSubProcess);
//    self.handler_sub = new ::EventHandler((__bridge void *)self, true);
//    self.engine_sub->SetEventHandler(self.handler_sub);
    self.engine_sub->raw_data()->Attach(new IrisVideoFrameBufferManager);
      self.callApiMethodCallHandlerSub = [[CallApiMethodCallHandler alloc] initWith:self.engine_sub];
  }
  return self;
}

- (void)dealloc {
  if (self.engine_main) {
    delete self.engine_main;
    self.engine_main = nil;
  }
//  if (self.handler_main) {
//    delete self.handler_main;
//    self.handler_main = nil;
//  }
  if (self.engine_sub) {
    delete self.engine_sub;
    self.engine_sub = nil;
  }
//  if (self.handler_sub) {
//    delete self.handler_sub;
//    self.handler_sub = nil;
//  }
}

- (IrisRtcEngine *)engine:(id)arguments {
//  NSNumber *subProcess = arguments[@"subProcess"];
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

    
//    BOOL isCallApi = [@"callApi" isEqualToString:call.method] || [@"callApiWithBuffer" isEqualToString:call.method];
//    if (isCallApi) {
//        if ([self isSubProcess:call.arguments]) {
//            [[self callApiMethodCallHandlerSub] onMethodCall:call _:result];
//        } else {
//            [[self callApiMethodCallHandlerMain] onMethodCall:call _:result];
//        }
//    }
//  if ([@"callApi" isEqualToString:call.method]) {
//    NSNumber *apiType = call.arguments[@"apiType"];
//    NSString *params = call.arguments[@"params"];
//    char res[kMaxResultLength] = "";
//
//    auto ret = [self engine:call.arguments]->CallApi(
//        (ApiTypeEngine)[apiType unsignedIntValue], [params UTF8String], res);
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
//    auto ret = [self engine:call.arguments]->CallApi(
//        (ApiTypeEngine)[apiType unsignedIntValue], [params UTF8String],
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
//  }else
    if ([@"createTextureRender" isEqualToString:call.method]) {
    int64_t textureId = [self.factory
        createTextureRenderer:[self engine:call.arguments]->raw_data()
                                  ->buffer_manager()];
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
