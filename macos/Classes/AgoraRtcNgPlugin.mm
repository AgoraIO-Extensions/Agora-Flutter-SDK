#import "AgoraRtcNgPlugin.h"
#import "VideoViewController.h"

@interface AgoraRtcNgPlugin ()

@property(nonatomic) VideoViewController *videoViewController;

@end

@implementation AgoraRtcNgPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"agora_rtc_ng"
            binaryMessenger:[registrar messenger]];
  AgoraRtcNgPlugin* instance = [[AgoraRtcNgPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
    
    instance.videoViewController = [[VideoViewController alloc] initWith:registrar.textures messenger:registrar.messenger];
}

- (void)getAssetAbsolutePath:(FlutterMethodCall *)call
                      result:(FlutterResult)result {
    NSString *assetPath = (NSString *)[call arguments];
    if (assetPath) {
        NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
        // Temporary workaround for loop up flutter asset in macOS
        // https://github.com/flutter/flutter/issues/47681#issuecomment-958111474
        NSString *realPath =  [NSString stringWithFormat:@"%@%@%@", bundlePath, @"/Contents/Frameworks/App.framework/Resources/flutter_assets/", assetPath];
        
        if (realPath) {
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
