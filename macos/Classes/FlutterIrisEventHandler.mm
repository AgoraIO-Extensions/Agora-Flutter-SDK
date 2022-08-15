#import "FlutterIrisEventHandler.h"
#import <AgoraRtcWrapper/iris_rtc_engine.h>
#import <Foundation/Foundation.h>
#include <mutex>

class EventHandler : public agora::iris::IrisEventHandler {
public:
  EventHandler(FlutterEventSink eventSink, bool shouldHandleSubProcess = false,
               bool sub_process = false)
      : eventSink_(eventSink), sub_process_(sub_process),
        shouldHandleSubProcess_(shouldHandleSubProcess) {}

  void OnEvent(const char *event, const char *data) override {
      std::lock_guard<std::mutex> guard(isCleanUpMutex_);
        
      if (isCleanUp_) return;
      
      @try {
          if (eventSink_) {
            NSMutableDictionary *dic = [NSMutableDictionary
                dictionaryWithObjectsAndKeys:[NSString stringWithUTF8String:event],
                                             @"methodName",
                                             [NSString stringWithUTF8String:data],
                                             @"data", nil];

            if (shouldHandleSubProcess_) {
              [dic setObject:@(sub_process_) forKey:@"subProcess"];
            }

            if (isCleanUp_) return;
            eventSink_(dic);
          }
      } @catch (NSException *e) {
          NSLog(@"Error: %@ %@", e, [e userInfo]);
      } @finally {
      }
  }

  void OnEvent(const char *event, const char *data, const void *buffer,
               unsigned int length) override {
      std::lock_guard<std::mutex> guard(isCleanUpMutex_);
        
      if (isCleanUp_) return;
      
      @try {
          FlutterStandardTypedData *bufferApple = [FlutterStandardTypedData
              typedDataWithBytes:[[NSData alloc] initWithBytes:buffer
                                                        length:length]];
          if (eventSink_) {
            NSMutableDictionary *dic = [NSMutableDictionary
                dictionaryWithObjectsAndKeys:[NSString stringWithUTF8String:event],
                                             @"methodName",
                                             [NSString stringWithUTF8String:data],
                                             @"data", bufferApple, @"buffer", nil];

            if (shouldHandleSubProcess_) {
              [dic setObject:@(sub_process_) forKey:@"subProcess"];
            }

            if (isCleanUp_) return;
            eventSink_(dic);
          }
      } @catch (NSException *e) {
          NSLog(@"Error: %@ %@", e, [e userInfo]);
      } @finally {
      }
  }
    
    void setIsCleanUp(bool isCleanUp) {
        std::lock_guard<std::mutex> guard(isCleanUpMutex_);
        isCleanUp_ = isCleanUp;
    }

private:
  FlutterEventSink eventSink_;
  bool sub_process_;
  bool shouldHandleSubProcess_;
    bool isCleanUp_ = false;
    std::mutex isCleanUpMutex_;
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
  }
  if (self.eventHandlerSub) {
    delete self.eventHandlerSub;
  }
}

- (FlutterError *_Nullable)onCancelWithArguments:(id _Nullable)arguments {
  self.eventSink = nil;
  //    self.irisRtcEngine->SetEventHandler(nil);

  [self resetEventHandler:self.irisRtcEngine];
  if (self.irisRtcEngineSub) {
    [self resetEventHandler:self.irisRtcEngineSub];
  }

  return nil;
}

- (FlutterError *)onListenWithArguments:(id)arguments
                              eventSink:(FlutterEventSink)events {
  self.eventSink = events;
  if (!self.eventHandler) {
    self.eventHandler =
        new EventHandler(self.eventSink, self.irisRtcEngineSub != nil, false);
    [self setUpEventHandler:self.irisRtcEngine eventHandler:self.eventHandler];
    if (self.irisRtcEngineSub != nil) {
      self.eventHandlerSub = new EventHandler(self.eventSink, true, true);
      [self setUpEventHandler:self.irisRtcEngineSub
                 eventHandler:self.eventHandlerSub];
    }
  }

  return nil;
}

- (void)setUpEventHandler:(void *)engine eventHandler:(void *)eventHandler {
  agora::iris::rtc::IrisRtcEngine *e =
      (agora::iris::rtc::IrisRtcEngine *)engine;
  e->SetEventHandler((EventHandler *)eventHandler);
}

- (void)resetEventHandler:(void *)engine {
    if (self.eventHandler) {
        self.eventHandler->setIsCleanUp(true);
    }
    if (self.eventHandlerSub) {
        self.eventHandlerSub->setIsCleanUp(true);
    }
  agora::iris::rtc::IrisRtcEngine *e =
      (agora::iris::rtc::IrisRtcEngine *)engine;
  e->SetEventHandler(nil);
}

@end

@implementation RtcChannelFlutterIrisEventHandler
- (void)setUpEventHandler:(void *)engine eventHandler:(void *)eventHandler {
  agora::iris::rtc::IrisRtcEngine *e =
      (agora::iris::rtc::IrisRtcEngine *)engine;
  e->channel()->SetEventHandler((EventHandler *)eventHandler);
}

- (void)resetEventHandler:(void *)engine {
  agora::iris::rtc::IrisRtcEngine *e =
      (agora::iris::rtc::IrisRtcEngine *)engine;
  e->channel()->SetEventHandler(nil);
}

@end
