#ifndef FlutterIrisEventHandler_h
#define FlutterIrisEventHandler_h

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

#endif /* FlutterIrisEventHandler_h */
