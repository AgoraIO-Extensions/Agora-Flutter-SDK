#import <Flutter/Flutter.h>
#if __has_include(<agora_rtc_engine/agora_rtc_engine-Swift.h>)
#import <agora_rtc_engine/agora_rtc_engine-Swift.h>
#endif
#import <agora_rtc_engine/RtcEnginePlugin.h>

@interface OCTestRtcEnginePlugin : NSObject<RtcEnginePlugin>
@property bool isRtcEngineCreated;
@property bool isRtcEngineDestroyed;
- (void) registerSelf;
- (void) unregisterSelf;
@end
