#import <Flutter/Flutter.h>

#import <AgoraRtcWrapper/AgoraPIPController.h>

@interface AgoraRtcNgPlugin
    : NSObject <FlutterPlugin, AgoraPIPStateChangedDelegate>
@end
