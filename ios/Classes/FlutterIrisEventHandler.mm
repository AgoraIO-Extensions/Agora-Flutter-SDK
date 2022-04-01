#import <Foundation/Foundation.h>
#import "FlutterIrisEventHandler.h"
#import <AgoraRtcWrapper/iris_rtc_engine.h>

class EventHandler : public agora::iris::IrisEventHandler {
public:
    EventHandler(FlutterEventSink eventSink, bool shouldHandleSubProcess = false, bool sub_process = false) : eventSink_(eventSink), sub_process_(sub_process), shouldHandleSubProcess_(shouldHandleSubProcess) {
  }

  void OnEvent(const char *event, const char *data) override {
    @autoreleasepool {
        if (eventSink_) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithUTF8String:event], @"methodName", [NSString stringWithUTF8String:data], @"data", nil];
            
            if (shouldHandleSubProcess_) {
                [dic setObject:@(sub_process_) forKey:@"subProcess"];
            }
            
            eventSink_(dic);
        }
    }
  }

  void OnEvent(const char *event, const char *data, const void *buffer,
               unsigned int length) override {
    @autoreleasepool {
      FlutterStandardTypedData *bufferApple = [FlutterStandardTypedData
          typedDataWithBytes:[[NSData alloc] initWithBytes:buffer
                                                    length:length]];
        if (eventSink_) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithUTF8String:event], @"methodName", [NSString stringWithUTF8String:data], @"data", bufferApple, @"buffer", nil];
            
            if (shouldHandleSubProcess_) {
                [dic setObject:@(sub_process_) forKey:@"subProcess"];
            }
            
            eventSink_(dic);
        }
    }
  }

private:
    FlutterEventSink eventSink_;
    bool sub_process_;
    bool shouldHandleSubProcess_;
};

@interface FlutterIrisEventHandler ()
@property(nonatomic) FlutterEventSink eventSink;
@property(nonatomic) agora::iris::rtc::IrisRtcEngine *irisRtcEngine;
@property(nonatomic) agora::iris::rtc::IrisRtcEngine *irisRtcEngineSub;
@property(nonatomic) EventHandler *eventHandler;
@property(nonatomic) EventHandler *eventHandlerSub;
@end

@implementation FlutterIrisEventHandler

- (instancetype)initWith:(void *)engine {
    self.irisRtcEngine = (agora::iris::rtc::IrisRtcEngine *)engine;
    return self;
}

- (instancetype)initWith:(void *)mainEngine subEngine:(void *)subEngine {
    self = [super init];
    if (self) {
        self.irisRtcEngine = (agora::iris::rtc::IrisRtcEngine *)mainEngine;
        self.irisRtcEngineSub = (agora::iris::rtc::IrisRtcEngine *)subEngine;
    }
    return self;
}

- (void)dealloc {
    self.eventSink = nil;
    if (self.eventHandler) {
        delete self.eventHandler;
        self.eventHandler = nil;
    }
    if (self.eventHandlerSub) {
        delete self.eventHandlerSub;
        self.eventHandlerSub = nil;
    }
}

- (FlutterError *_Nullable)onCancelWithArguments:(id _Nullable)arguments {
    self.eventSink = nil;
    
    [self resetEventHandler:self.irisRtcEngine];
    if (self.irisRtcEngineSub) {
        [self resetEventHandler:self.irisRtcEngineSub];
    }
    
  return nil;
}

- (FlutterError *)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)events {
    self.eventSink = events;
    if (!self.eventHandler) {
        self.eventHandler = new EventHandler(self.eventSink, self.irisRtcEngineSub != nil, false);
        [self setUpEventHandler:self.irisRtcEngine eventHandler:self.eventHandler];
        if (self.irisRtcEngineSub != nil) {
            self.eventHandlerSub = new EventHandler(self.eventSink, true, true);
            [self setUpEventHandler:self.irisRtcEngineSub eventHandler:self.eventHandler];
        }
    }
    
    return nil;
}

- (void)setUpEventHandler:(void *)engine eventHandler:(void *)eventHandler {
    agora::iris::rtc::IrisRtcEngine *e = (agora::iris::rtc::IrisRtcEngine *)engine;
    e->SetEventHandler((EventHandler *)eventHandler);
}

- (void)resetEventHandler:(void *)engine {
    agora::iris::rtc::IrisRtcEngine *e = (agora::iris::rtc::IrisRtcEngine *)engine;
    e->SetEventHandler(nil);
    self.eventSink = nil;
}

@end

@implementation RtcChannelFlutterIrisEventHandler
- (void)setUpEventHandler:(void *)engine eventHandler:(void *)eventHandler {
    agora::iris::rtc::IrisRtcEngine *e = (agora::iris::rtc::IrisRtcEngine *)engine;
    e->channel()->SetEventHandler((EventHandler *)eventHandler);
}

- (void)resetEventHandler:(void *)engine {
    agora::iris::rtc::IrisRtcEngine *e = (agora::iris::rtc::IrisRtcEngine *)engine;
    e->channel()->SetEventHandler(nil);
}

@end
