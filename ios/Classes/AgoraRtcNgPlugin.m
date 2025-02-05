#import "AgoraRtcNgPlugin.h"
#import "AgoraSurfaceViewFactory.h"
#import "VideoViewController.h"

@interface AgoraRtcNgPlugin ()

@property(nonatomic) VideoViewController *videoViewController;

@property(nonatomic) NSObject<FlutterPluginRegistrar> *registrar;

@end

@implementation AgoraRtcNgPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"agora_rtc_ng"
            binaryMessenger:[registrar messenger]];
  AgoraRtcNgPlugin* instance = [[AgoraRtcNgPlugin alloc] init];
  instance.registrar = registrar;
  [registrar addMethodCallDelegate:instance channel:channel];
    
  instance.videoViewController = [[VideoViewController alloc] initWith:registrar.textures messenger:registrar.messenger];
    
  [registrar registerViewFactory:[[AgoraSurfaceViewFactory alloc]
                        initWith:[registrar messenger]
                      controller:instance.videoViewController]
                          withId:@"AgoraSurfaceView"];
}

- (void)getAssetAbsolutePath:(FlutterMethodCall *)call
                      result:(FlutterResult)result {
    NSString *assetPath = (NSString *)[call arguments];
    if (assetPath) {
        NSString *assetKey = [[self registrar] lookupKeyForAsset:assetPath];
        if (assetKey) {
            NSString *realPath = [[NSBundle mainBundle] pathForResource:assetKey ofType:nil];
            result(realPath);
            return;
        }
        result([FlutterError
            errorWithCode:@"FileNotFoundException"
                  message:nil
                  details:nil]);
        return;
    }
    result([FlutterError
        errorWithCode:@"IllegalArgumentException"
              message:nil
              details:nil]);
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"getAssetAbsolutePath" isEqualToString:call.method]) {
            [self getAssetAbsolutePath:call result:result];
        } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
