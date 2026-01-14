#import <Flutter/Flutter.h>

#import <AgoraRtcWrapper/AgoraPIPController.h>
#import "./AgoraRTEController.h"

@interface AgoraRtcNgPlugin
    : NSObject <FlutterPlugin, AgoraPIPStateChangedDelegate>
@end
