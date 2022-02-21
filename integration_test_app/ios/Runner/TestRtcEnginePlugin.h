#ifndef TestRtcEnginePlugin_h
#define TestRtcEnginePlugin_h

@import agora_rtc_engine;
#import <Flutter/Flutter.h>

@interface TestRtcEnginePluginMethodChannel : NSObject
- (void)setUp:(NSObject<FlutterBinaryMessenger>*)messenger;
@end

#endif /* TestRtcEnginePlugin_h */
