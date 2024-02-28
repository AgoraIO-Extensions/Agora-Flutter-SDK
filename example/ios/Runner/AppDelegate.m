#import <Flutter/Flutter.h>
#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import <ReplayKit/ReplayKit.h>
#import "VideoRawDataController.h"

@interface AppDelegate ()

@property(nonatomic, strong, nullable) VideoRawDataController *videoRawDataController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // On low power mode, the system force keep the screen on for 30s only,
    // we keep the screen on to help internal testing.
    [application setIdleTimerDisabled: YES];
    
    FlutterViewController* controller = (FlutterViewController*) self.window.rootViewController;

    FlutterMethodChannel* screensharingIOSChannel = [FlutterMethodChannel
                                            methodChannelWithName:@"example_screensharing_ios"
                                            binaryMessenger:controller.binaryMessenger];

    [screensharingIOSChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        if (@available(iOS 12.0, *)) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSURL *url = [[NSBundle mainBundle] URLForResource:nil withExtension:@"appex" subdirectory:@"PlugIns"];
                NSBundle *bundle = [NSBundle bundleWithURL:url];
                if (bundle) {
                    RPSystemBroadcastPickerView *picker = [[RPSystemBroadcastPickerView alloc] initWithFrame:CGRectMake(0, 0, 100, 200)];
                    picker.showsMicrophoneButton = YES;
                    picker.preferredExtension = bundle.bundleIdentifier;
                    for (UIView *view in [picker subviews]) {
                        if ([view isKindOfClass:UIButton.class]) {
                            [((UIButton*)view) sendActionsForControlEvents:UIControlEventAllTouchEvents];
                        }
                    }
                }
            });
        }
    }];
    
    __weak typeof(self) weakSelf = self;
    
    FlutterMethodChannel* sharedNativeHandleMethodChannel = [FlutterMethodChannel
                                            methodChannelWithName:@"agora_rtc_engine_example/shared_native_handle"
                                            binaryMessenger:controller.binaryMessenger];

    [sharedNativeHandleMethodChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        if (!weakSelf) {
            result(FlutterMethodNotImplemented);
            return;
        }
        
        NSDictionary *data = call.arguments;
        if ([@"native_init" isEqualToString:call.method]) {
            NSString *appId = data[@"appId"];
            intptr_t nativeHandle = 0L;
            if (!weakSelf.videoRawDataController) {
                weakSelf.videoRawDataController = [[VideoRawDataController alloc] initWith:appId];
                nativeHandle = [weakSelf.videoRawDataController getNativeHandle];
                
            }
            
            result(@(nativeHandle));
            return;
        } else if ([@"native_dispose" isEqualToString:call.method]) {
            if (weakSelf.videoRawDataController) {
                [weakSelf.videoRawDataController dispose];
                weakSelf.videoRawDataController = NULL;
            }
            result(@(true));
            return;
        }
        
        result(FlutterMethodNotImplemented);
    }];

  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
