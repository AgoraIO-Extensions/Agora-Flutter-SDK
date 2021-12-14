#import <Flutter/Flutter.h>

@import agora_rtc_engine;

@interface OCTestRtcEnginePlugin : NSObject<RtcEnginePlugin>
@property bool isRtcEngineCreated;
@property bool isRtcEngineDestroyed;
- (void) registerSelf;
- (void) unregisterSelf;
@end
