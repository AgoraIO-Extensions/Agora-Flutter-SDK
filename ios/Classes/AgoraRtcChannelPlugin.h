#ifndef AgoraRtcChannelPlugin_h
#define AgoraRtcChannelPlugin_h

#import <Flutter/Flutter.h>

@interface AgoraRtcChannelPlugin : NSObject
- (instancetype)initWith:(void *)irisRtcEngine binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;
@end

#endif /* AgoraRtcChannelPlugin_h */
