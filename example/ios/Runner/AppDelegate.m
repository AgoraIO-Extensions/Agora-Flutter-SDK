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
    
    [application setIdleTimerDisabled: YES];
    [GeneratedPluginRegistrant registerWithRegistry:self];

    // Initialize rootViewController if it's not already available
    if (!self.window.rootViewController) {
        FlutterViewController *flutterViewController = [[FlutterViewController alloc] initWithProject:nil nibName:nil bundle:nil];
        if (!self.window) {
            self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        }
        self.window.rootViewController = flutterViewController;
        [self.window makeKeyAndVisible];
    }
  
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    FlutterViewController* flutterViewController = (FlutterViewController*)self.window.rootViewController;
    
    if (flutterViewController && [flutterViewController isKindOfClass:[FlutterViewController class]]) {
        FlutterMethodChannel* screensharingIOSChannel = [FlutterMethodChannel
                                                methodChannelWithName:@"example_screensharing_ios"
                                                binaryMessenger:flutterViewController.binaryMessenger];

        [screensharingIOSChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
            if (![@"showRPSystemBroadcastPickerView" isEqualToString:call.method]) {
                result(FlutterMethodNotImplemented);
                return;
            }

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
                    result(nil);
                });
            } else {
                result(FlutterMethodNotImplemented);
            }
        }];
        
        __weak typeof(self) weakSelf = self;
        FlutterMethodChannel* sharedNativeHandleMethodChannel = [FlutterMethodChannel
                                                methodChannelWithName:@"agora_rtc_engine_example/shared_native_handle"
                                                binaryMessenger:flutterViewController.binaryMessenger];

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
    }
}

@end
