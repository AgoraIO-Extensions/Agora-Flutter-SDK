#import <Flutter/Flutter.h>
#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import <ReplayKit/ReplayKit.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
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

  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
