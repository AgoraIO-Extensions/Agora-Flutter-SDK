#import <FlutterMacOS/FlutterMacOS.h>

@interface AgoraRtcChannelPlugin
    : NSObject <FlutterPlugin, FlutterStreamHandler>
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar
                       engine:(void *)engine;
@end
