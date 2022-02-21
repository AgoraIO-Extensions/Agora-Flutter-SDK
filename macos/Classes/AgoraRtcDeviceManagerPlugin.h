#import <FlutterMacOS/FlutterMacOS.h>

@interface AgoraRtcDeviceManagerPlugin : NSObject <FlutterPlugin>
@property(nonatomic, assign) BOOL audio;

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar
                       engine:(void *)engine;

- (instancetype)initWithType:(BOOL)audio;
@end
