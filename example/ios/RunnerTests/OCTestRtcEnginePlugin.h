#import <Flutter/Flutter.h>
#import <RtcEnginePlugin.h>

@interface OCTestRtcEnginePlugin : NSObject<RtcEnginePlugin>
@property bool isRtcEngineCreated;
@property bool isRtcEngineDestroyed;
- (void) registerSelf;
- (void) unregisterSelf;
@end
