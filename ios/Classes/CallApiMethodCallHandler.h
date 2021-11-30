//
//  CallApiMethodCallHandler.h
//  agora_rtc_engine
//
//  Created by fenglang on 2021/11/4.
//

#ifndef CallApiMethodCallHandler_h
#define CallApiMethodCallHandler_h

#if TARGET_OS_IPHONE
#import <Flutter/Flutter.h>
#else
#import <FlutterMacOS/FlutterMacOS.h>
#endif
//#import <AgoraRtcWrapper/iris_rtc_engine.h>

@interface CallApiMethodCallHandler : NSObject
//@property(nonatomic) void *irisRtcEngine;
- (instancetype)initWith:(void *)engine;
//    typedef void (^FlutterMethodCallHandler)(FlutterMethodCall* call, FlutterResult result);
- (void)onMethodCall:(FlutterMethodCall *)call _:(FlutterResult)result;
- (int)callApi:(NSNumber *) apiType _:(NSString *)params _:(char *) result;

- (int)callApiWithBuffer:(NSNumber *) apiType _:(NSString *)params _:(void *)buffer _:(char *) result;

- (NSString *)callApiError:(int)ret;
@end

#endif /* CallApiMethodCallHandler_h */

@interface RtcChannelCallApiMethodCallHandler : CallApiMethodCallHandler
@end
