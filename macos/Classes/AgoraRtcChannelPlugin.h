#import <FlutterMacOS/FlutterMacOS.h>

@interface AgoraRtcChannelPlugin
    : NSObject <FlutterPlugin>
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar
                       engine:(void *)engine;
@end
