#import "AgoraRtcNgPlugin.h"
#import "AgoraSurfaceViewFactory.h"
#import "VideoViewController.h"

@interface AgoraRtcNgPlugin ()

@property(nonatomic) NSObject<FlutterPluginRegistrar> *registrar;

@property(nonatomic) FlutterMethodChannel *channel;

@property(nonatomic) VideoViewController *videoViewController;

@property(nonatomic) AgoraPipController *pipController;

@end

@implementation AgoraRtcNgPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  AgoraRtcNgPlugin *instance = [[AgoraRtcNgPlugin alloc] init];
  instance.registrar = registrar;

  // create method channel
  FlutterMethodChannel *channel =
      [FlutterMethodChannel methodChannelWithName:@"agora_rtc_ng"
                                  binaryMessenger:[registrar messenger]];
  instance.channel = channel;
  [registrar addMethodCallDelegate:(NSObject<FlutterPlugin> *)instance
                           channel:channel];

  // create video view controller
  instance.videoViewController =
      [[VideoViewController alloc] initWith:registrar.textures
                                  messenger:registrar.messenger];
  [registrar registerViewFactory:[[AgoraSurfaceViewFactory alloc]
                                       initWith:[registrar messenger]
                                     controller:instance.videoViewController]
                          withId:@"AgoraSurfaceView"];

  // create pip controller
  instance.pipController = [[AgoraPipController alloc]
      initWith:(id<AgoraPipStateChangedDelegate>)instance];
}

- (void)getAssetAbsolutePath:(FlutterMethodCall *)call
                      result:(FlutterResult)result {
  NSString *assetPath = (NSString *)[call arguments];
  if (assetPath) {
    NSString *assetKey = [[self registrar] lookupKeyForAsset:assetPath];
    if (assetKey) {
      NSString *realPath = [[NSBundle mainBundle] pathForResource:assetKey
                                                           ofType:nil];
      result(realPath);
      return;
    }
    result([FlutterError errorWithCode:@"FileNotFoundException"
                               message:nil
                               details:nil]);
    return;
  }
  result([FlutterError errorWithCode:@"IllegalArgumentException"
                             message:nil
                             details:nil]);
}

- (void)handleMethodCall:(FlutterMethodCall *)call
                  result:(FlutterResult)result {
  if ([@"getAssetAbsolutePath" isEqualToString:call.method]) {
    [self getAssetAbsolutePath:call result:result];
  } else if ([call.method hasPrefix:@"pip"]) {
    [self handlePipMethodCall:call result:result];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)handlePipMethodCall:(FlutterMethodCall *)call
                     result:(FlutterResult)result {
  if ([@"pipIsSupported" isEqualToString:call.method]) {
    result([NSNumber numberWithBool:[self.pipController isSupported]]);
  } else if ([@"pipIsAutoEnterSupported" isEqualToString:call.method]) {
    result([NSNumber numberWithBool:[self.pipController isAutoEnterSupported]]);
  } else if ([@"pipIsActived" isEqualToString:call.method]) {
    result([NSNumber numberWithBool:[self.pipController isActived]]);
  } else if ([@"pipSetup" isEqualToString:call.method]) {
    @autoreleasepool {
      // new options
      AgoraPipOptions *options = [[AgoraPipOptions alloc] init];

      // auto enter
      if ([call.arguments objectForKey:@"autoEnterEnabled"]) {
        options.autoEnterEnabled =
            [[call.arguments objectForKey:@"autoEnterEnabled"] boolValue];
      }

      // preferred content size
      if ([call.arguments objectForKey:@"preferredContentWidth"] &&
          [call.arguments objectForKey:@"preferredContentHeight"]) {
        options.preferredContentSize = CGSizeMake(
            [[call.arguments objectForKey:@"preferredContentWidth"] floatValue],
            [[call.arguments objectForKey:@"preferredContentHeight"]
                floatValue]);
      }

      // connection
      if ([call.arguments objectForKey:@"connection"] &&
          [[call.arguments objectForKey:@"connection"]
              isKindOfClass:[NSDictionary class]]) {
        NSDictionary *connectionDict =
            [call.arguments objectForKey:@"connection"];
        options.connection = [[AgoraRtcConnection alloc]
            initWithChannelId:[connectionDict objectForKey:@"channelId"]
                     localUid:[[connectionDict objectForKey:@"localUid"]
                                  unsignedIntegerValue]];
      }

      // video canvas
      if ([call.arguments objectForKey:@"videoCanvas"] &&
          [[call.arguments objectForKey:@"videoCanvas"]
              isKindOfClass:[NSDictionary class]]) {
        NSDictionary *videoCanvasDict =
            [call.arguments objectForKey:@"videoCanvas"];
        options.videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
        options.videoCanvas.uid =
            [[videoCanvasDict objectForKey:@"uid"] unsignedIntegerValue];
        options.videoCanvas.view = (__bridge UIView *)[[videoCanvasDict
            objectForKey:@"view"] pointerValue];
        options.videoCanvas.mirrorMode =
            [[videoCanvasDict objectForKey:@"mirrorMode"] integerValue];
        options.videoCanvas.renderMode =
            [[videoCanvasDict objectForKey:@"renderMode"] integerValue];
        options.videoCanvas.backgroundColor = [[videoCanvasDict
            objectForKey:@"backgroundColor"] unsignedIntValue];
        options.videoCanvas.sourceType =
            [[videoCanvasDict objectForKey:@"sourceType"] integerValue];
        options.videoCanvas.mediaPlayerId =
            (int)[[videoCanvasDict objectForKey:@"mediaPlayerId"] integerValue];
      }

      // rendering handle pointerValue
      if ([call.arguments objectForKey:@"renderingHandle"] &&
          [[call.arguments objectForKey:@"renderingHandle"]
              isKindOfClass:[NSNumber class]]) {
        options.renderingHandle = (uintptr_t)[
            [call.arguments objectForKey:@"renderingHandle"] pointerValue];
      }
      result([NSNumber numberWithBool:[self.pipController setup:options]]);
    }
  } else if ([@"pipStart" isEqualToString:call.method]) {
    result([NSNumber numberWithBool:[self.pipController start]]);
  } else if ([@"pipStop" isEqualToString:call.method]) {
    [self.pipController stop];
    result(nil);
  } else if ([@"pipDispose" isEqualToString:call.method]) {
    [self.pipController dispose];
    result(nil);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)pipStateChanged:(AgoraPipState)state error:(NSString *)error {
  NSDictionary *arguments = [[NSDictionary alloc]
      initWithObjectsAndKeys:[NSNumber numberWithLong:(long)state], @"state",
                             error, @"error", nil];
  [self.channel invokeMethod:@"pipStateChanged" arguments:arguments];
}

@end
