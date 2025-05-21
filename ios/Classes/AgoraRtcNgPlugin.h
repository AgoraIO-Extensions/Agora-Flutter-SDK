#import <Flutter/Flutter.h>

#import <AgoraPIPKit/AgoraPIPKit.h>

@interface AgoraRtcNgPlugin
    : NSObject <FlutterPlugin, AgoraPIPStateChangedDelegate>

@end
