#import "AgoraRtcEnginePlugin.h"
//#if __has_include(<agora_rtc_engine/agora_rtc_engine-Swift.h>)
//#import <agora_rtc_engine/agora_rtc_engine-Swift.h>
//#else
//// Support project import fallback if the generated compatibility header
//// is not copied when this plugin is created as a library.
//// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
//#import "agora_rtc_engine-Swift.h"
//#endif
#import <AgoraRtcWrapper/iris_rtc_engine.h>
#import <AgoraRtcWrapper/iris_video_processor.h>
#import "CallApiMethodCallHandler.h"
#import "FlutterIrisEventHandler.h"
#import "AgoraRtcChannelPlugin.h"
#import "AgoraSurfaceViewFactory.h"
#import "AgoraTextureViewFactory.h"
#import "FlutterIrisEventHandler.h"

//namespace agora {
//namespace iris {
//class EventHandler : public IrisEventHandler {
//public:
//  EventHandler(FlutterEventSink eventSink) {
//      eventSink_ = eventSink;
//  }
//
//  void OnEvent(const char *event, const char *data) override {
//    if (strcmp(event, "onAudioVolumeIndication") == 0) {
//      return;
//    }
//    @autoreleasepool {
//      eventSink_(@{
//        @"methodName" : [NSString stringWithUTF8String:event],
//        @"data" : [NSString stringWithUTF8String:data],
//      });
//    }
//  }
//
//  void OnEvent(const char *event, const char *data, const void *buffer,
//               unsigned int length) override {
//    @autoreleasepool {
//      FlutterStandardTypedData *bufferApple = [FlutterStandardTypedData
//          typedDataWithBytes:[[NSData alloc] initWithBytes:buffer
//                                                    length:length]];
//      eventSink_(@{
//        @"methodName" : [NSString stringWithUTF8String:event],
//        @"data" : [NSString stringWithUTF8String:data],
//        @"buffer" : bufferApple
//      });
//    }
//  }
//
//private:
//    FlutterEventSink eventSink_;
//};
//}
//}

@interface AgoraRtcEnginePlugin ()

@property(nonatomic) agora::iris::rtc::IrisRtcEngine *irisRtcEngine;

// TODO(littlegnal): Lazy init videoFrameBufferManager
@property(nonatomic) agora::iris::IrisVideoFrameBufferManager *videoFrameBufferManager;

@property(nonatomic) FlutterIrisEventHandler *flutterIrisEventHandler;

//@property(nonatomic) EventHandler *eventHandler;

//@property(nonatomic) FlutterEventSink eventSink;

@property(nonatomic) CallApiMethodCallHandler *callApiMethodCallHandler;

@property(nonatomic) AgoraRtcChannelPlugin *agoraRtcChannelPlugin;

@property(nonatomic, strong) AgoraTextureViewFactory *factory;

@property(nonatomic) NSObject<FlutterPluginRegistrar> *registrar;

@end

@implementation AgoraRtcEnginePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
//  [SwiftAgoraRtcEnginePlugin registerWithRegistrar:registrar];
    
    FlutterMethodChannel *methodChannel =
        [FlutterMethodChannel methodChannelWithName:@"agora_rtc_engine"
                                    binaryMessenger:[registrar messenger]];
    FlutterEventChannel *eventChannel =
        [FlutterEventChannel eventChannelWithName:@"agora_rtc_engine/events"
                                  binaryMessenger:[registrar messenger]];
    AgoraRtcEnginePlugin *instance = [[AgoraRtcEnginePlugin alloc] init];
    instance.registrar = registrar;
    [registrar addMethodCallDelegate:instance channel:methodChannel];
    
    instance.flutterIrisEventHandler = [[FlutterIrisEventHandler alloc] initWith:instance.irisRtcEngine];
    
    [eventChannel setStreamHandler:instance.flutterIrisEventHandler];
    
    instance.agoraRtcChannelPlugin = [[AgoraRtcChannelPlugin alloc] initWith:[instance irisRtcEngine] binaryMessenger:[registrar messenger]];
    
    [instance
        setFactory:[[AgoraTextureViewFactory alloc] initWithRegistrar:registrar]];

    [registrar registerViewFactory:[[AgoraSurfaceViewFactory alloc]
                                       initWith:[registrar messenger]
                                         engine:instance.irisRtcEngine]
                            withId:@"AgoraSurfaceView"];
}

- (instancetype)init {
  self = [super init];
  if (self) {
    self.irisRtcEngine = new agora::iris::rtc::IrisRtcEngine;
      self.videoFrameBufferManager = new agora::iris::IrisVideoFrameBufferManager;
      self.irisRtcEngine->raw_data()->Attach(self.videoFrameBufferManager);
      
//      self.eventHandler = new agora::iris::EventHandler(_eventSink);
//      self.eventHandler = new EventHandler(self.eventSink);
//    self.irisRtcEngine->SetEventHandler(self.eventHandler);
      self.callApiMethodCallHandler = [[CallApiMethodCallHandler alloc] initWith:self.irisRtcEngine];
      
//      self.agoraRtcChannelPlugin = [[AgoraRtcChannelPlugin alloc] initWith:];
  }
  return self;
}

- (void)dealloc {
  delete self.irisRtcEngine;
//  delete self.eventHandler;
    delete self.videoFrameBufferManager;
//    delete self.agoraRtcChannelPlugin;
}

- (void)handleMethodCall:(FlutterMethodCall *)call
                  result:(FlutterResult)result {
//    [self callApiMethodCallHandler:call result:result];
    if ([@"createTextureRender" isEqualToString:call.method]) {
        int64_t textureId = [self.factory
            createTextureRenderer:[self videoFrameBufferManager]];
        result(@(textureId));
    } else if ([@"destroyTextureRender" isEqualToString:call.method]) {
        NSNumber *textureId = call.arguments[@"id"];
        [self.factory destroyTextureRenderer:[textureId integerValue]];
        result(nil);
    } else if ([@"getAssetAbsolutePath" isEqualToString:call.method]) {
        [self getAssetAbsolutePath:call result:result];
    } else {
        [[self callApiMethodCallHandler] onMethodCall:call _:result];
    }
    
    
//  if ([@"getPlatformVersion" isEqualToString:call.method]) {
//    result([@"iOS "
//        stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
//  } else if ([@"callApi" isEqualToString:call.method]) {
//    NSDictionary<NSString *, id> *arguments = call.arguments;
//    NSNumber *apiType = arguments[@"apiType"];
//    NSString *params = arguments[@"params"];
//    FlutterStandardTypedData *buffer = arguments[@"buffer"];
//    char res[kBasicResultLength] = "";
//    int ret;
//    if (buffer == nil || buffer == [NSNull null]) {
//      ret = self.irisRtcEngine->CallApi(
//          (ApiTypeEngine)[apiType unsignedIntValue], [params UTF8String], res);
//    } else {
//      ret = self.irisRtcEngine->CallApi(
//          (ApiTypeEngine)[apiType unsignedIntValue], [params UTF8String],
//          (void *)[[buffer data] bytes], res);
//    }
//    if (ret == 0) {
//      if (strlen(res) == 0) {
//        result(nil);
//      } else {
//        result([NSString stringWithUTF8String:res]);
//      }
//    } else if (ret > 0) {
//      result(@(ret));
//    } else {
//      char description[kBasicResultLength];
//      self.irisRtcEngine->CallApi(
//          ApiTypeEngine::kEngineGetErrorDescription,
//          [[NSString stringWithFormat:@"{\"code\":%d}", abs(ret)] UTF8String],
//          description);
//      result([FlutterError
//          errorWithCode:[@(ret) stringValue]
//                message:[NSString stringWithUTF8String:description]
//                details:nil]);
//    }
//  } else {
//    result(FlutterMethodNotImplemented);
//  }
}

//- (FlutterError *_Nullable)onCancelWithArguments:(id _Nullable)arguments {
//  self.eventSink = nil;
//    self.irisRtcEngine->SetEventHandler(nil);
//
//  return nil;
//}
//
//- (FlutterError *)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)events {
//    NSLog(@"events events %@", events);
//    self.eventSink = events;
//    if (!self.eventHandler) {
//        self.eventHandler = new EventHandler(self.eventSink);
//      self.irisRtcEngine->SetEventHandler(self.eventHandler);
//    }
//
//    return nil;
//}

//- (FlutterError *_Nullable)onListenWithArguments:(id _Nullable)arguments
//                                       eventSink:
//                                           (nonnull FlutterEventSink)events {
//  self.eventSink = events;
//  return nil;
//}

//private func getAssetAbsolutePath(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
//    if let assetPath = call.arguments as? String {
//        if let assetKey = registrar?.lookupKey(forAsset: assetPath) {
//            if let realPath = Bundle.main.path(forResource: assetKey, ofType: nil) {
//                result(realPath)
//                return
//            }
//        }
//        result(FlutterError(code: "FileNotFoundException", message: nil, details: nil))
//        return
//    }
//    result(FlutterError(code: "IllegalArgumentException", message: nil, details: nil))
//}

- (void)getAssetAbsolutePath:(FlutterMethodCall *)call
                      result:(FlutterResult)result {
    NSString *assetPath = (NSString *)[call arguments];
    if (assetPath) {
        NSString *assetKey = [[self registrar] lookupKeyForAsset:assetPath];
        if (assetKey) {
            NSString *realPath = [[NSBundle mainBundle] pathForResource:assetKey ofType:nil];
            result(realPath);
            return;
        }
        result([FlutterError
            errorWithCode:@"FileNotFoundException"
                  message:nil
                  details:nil]);
        return;
    }
    result([FlutterError
        errorWithCode:@"IllegalArgumentException"
              message:nil
              details:nil]);
}

@end
