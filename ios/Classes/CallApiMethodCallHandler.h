#ifndef CallApiMethodCallHandler_h
#define CallApiMethodCallHandler_h

#if TARGET_OS_IPHONE
#import <Flutter/Flutter.h>
#else
#import <FlutterMacOS/FlutterMacOS.h>
#endif

@interface CallApiMethodCallHandler : NSObject
//@property(nonatomic) agora::iris::rtc::IrisRtcEngine *irisRtcEngine;
- (instancetype)initWith:(void *)engine;
- (void)onMethodCall:(FlutterMethodCall *)call _:(FlutterResult)result;
- (int)callApi:(NSNumber *) apiType _:(NSString *)params _:(char *) result;

- (int)callApiWithBuffer:(NSNumber *) apiType _:(NSString *)params _:(void *)buffer _:(char *) result;

- (NSString *)callApiError:(int)ret;
@end

#endif /* CallApiMethodCallHandler_h */

@interface RtcChannelCallApiMethodCallHandler : CallApiMethodCallHandler
@end
