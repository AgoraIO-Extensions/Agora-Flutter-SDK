#ifndef FlutterIrisEventHandler_h
#define FlutterIrisEventHandler_h

//#import <AgoraRtcWrapper/iris_rtc_engine.h>
#if TARGET_OS_IPHONE
#import <Flutter/Flutter.h>
#else
#import <FlutterMacOS/FlutterMacOS.h>
#endif

@interface FlutterIrisEventHandler : NSObject <FlutterStreamHandler>
- (instancetype)initWith:(void *)engine;
- (instancetype)initWith:(void *)mainEngine subEngine:(void *)subEngine;
- (void)setUpEventHandler:(void *)engine eventHandler:(void *)eventHandler;
- (void)resetEventHandler:(void *)engine;
@end

@interface RtcChannelFlutterIrisEventHandler : FlutterIrisEventHandler
@end

//class EventHandler : public agora::iris::IrisEventHandler {
//public:
//  EventHandler(FlutterEventSink eventSink) {
//      eventSink_ = eventSink;
//  }
//
//  void OnEvent(const char *event, const char *data) override {
//    @autoreleasepool {
//        if (eventSink_) {
//            eventSink_(@{
//              @"methodName" : [NSString stringWithUTF8String:event],
//              @"data" : [NSString stringWithUTF8String:data],
//            });
//        }
//    }
//  }
//
//  void OnEvent(const char *event, const char *data, const void *buffer,
//               unsigned int length) override {
//    @autoreleasepool {
//      FlutterStandardTypedData *bufferApple = [FlutterStandardTypedData
//          typedDataWithBytes:[[NSData alloc] initWithBytes:buffer
//                                                    length:length]];
//        if (eventSink_) {
//            eventSink_(@{
//              @"methodName" : [NSString stringWithUTF8String:event],
//              @"data" : [NSString stringWithUTF8String:data],
//              @"buffer" : bufferApple
//            });
//        }
//    }
//  }
//
//private:
//    FlutterEventSink eventSink_;
//};

#endif /* FlutterIrisEventHandler_h */
