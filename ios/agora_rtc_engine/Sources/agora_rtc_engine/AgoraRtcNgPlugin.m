#import "./include/agora_rtc_engine/AgoraRtcNgPlugin.h"
#import "./include/agora_rtc_engine/AgoraSurfaceViewFactory.h"
#import "./include/agora_rtc_engine/AgoraUtils.h"
#import "./include/agora_rtc_engine/VideoViewController.h"
#include <Foundation/Foundation.h>

@interface AgoraRtcNgPlugin ()

@property(nonatomic) FlutterMethodChannel *channel;

@property(nonatomic) VideoViewController *videoViewController;

@property(nonatomic) NSObject<FlutterPluginRegistrar> *registrar;

@property(nonatomic) AgoraPIPController *pipController;

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
  [registrar addMethodCallDelegate:instance channel:channel];

  // create video view controller
  instance.videoViewController =
      [[VideoViewController alloc] initWith:registrar.textures
                                  messenger:registrar.messenger];
  [registrar registerViewFactory:[[AgoraSurfaceViewFactory alloc]
                                       initWith:[registrar messenger]
                                     controller:instance.videoViewController]
                          withId:@"AgoraSurfaceView"];

  // create pip controller
  instance.pipController = [[AgoraPIPController alloc]
      initWith:(id<AgoraPIPStateChangedDelegate>)instance];
}

- (void)handleMethodCall:(FlutterMethodCall *)call
                  result:(FlutterResult)result {
  AGORA_LOG(@"handleMethodCall: %@ with arguments: %@", call.method,
            call.arguments);

  if ([@"getAssetAbsolutePath" isEqualToString:call.method]) {
    [self getAssetAbsolutePath:call result:result];
  } else if ([call.method hasPrefix:@"pip"]) {
    [self handlePipMethodCall:call result:result];
  } else {
    result(FlutterMethodNotImplemented);
  }
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

- (void)handlePipMethodCall:(FlutterMethodCall *)call
                     result:(FlutterResult)result {
  if ([@"pipIsSupported" isEqualToString:call.method]) {
    result([NSNumber numberWithBool:[self.pipController isSupported]]);
  } else if ([@"pipIsAutoEnterSupported" isEqualToString:call.method]) {
    result([NSNumber numberWithBool:[self.pipController isAutoEnterSupported]]);
  } else if ([@"pipIsActivated" isEqualToString:call.method]) {
    result([NSNumber numberWithBool:[self.pipController isActivated]]);
  } else if ([@"pipSetup" isEqualToString:call.method]) {
    @autoreleasepool {
      // new options
      AgoraPIPOptions *options = [[AgoraPIPOptions alloc] init];

      // auto enter
      if ([call.arguments objectForKey:@"autoEnterEnabled"]) {
        options.autoEnterEnabled =
            [[call.arguments objectForKey:@"autoEnterEnabled"] boolValue];
      }

      // sourceContentView
      if ([call.arguments objectForKey:@"sourceContentView"]) {
        options.sourceContentView = (__bridge UIView *)[[call.arguments
            objectForKey:@"sourceContentView"] pointerValue];
      }

      // contentView
      if ([call.arguments objectForKey:@"contentView"]) {
        options.contentView = (__bridge UIView *)[[call.arguments
            objectForKey:@"contentView"] pointerValue];
      }

      // videoStreams
      NSArray *videoStreams = [call.arguments objectForKey:@"videoStreams"];
      if (videoStreams) {
        NSMutableArray *tempVideoStreamArray = [[NSMutableArray alloc] init];
        for (NSDictionary *videoStream in videoStreams) {
          NSDictionary *connectionObj =
              [videoStream objectForKey:@"connection"];
          NSDictionary *canvasObj = [videoStream objectForKey:@"canvas"];

          if (!connectionObj || !canvasObj) {
            continue;
          }

          AgoraPIPVideoStream *videoStreamObj =
              [[AgoraPIPVideoStream alloc] init];

          // connection
          id channelIdObj = [connectionObj objectForKey:@"channelId"];
          videoStreamObj.channelId =
              [channelIdObj isKindOfClass:[NSString class]] ? channelIdObj
                                                            : @"";

          id localUidObj = [connectionObj objectForKey:@"localUid"];
          videoStreamObj.localUid = [localUidObj isKindOfClass:[NSNumber class]]
                                        ? [localUidObj intValue]
                                        : 0;

          // canvas
          id uidObj = [canvasObj objectForKey:@"uid"];
          videoStreamObj.uid =
              [uidObj isKindOfClass:[NSNumber class]] ? [uidObj intValue] : 0;

          id backgroundColorObj = [canvasObj objectForKey:@"backgroundColor"];
          videoStreamObj.backgroundColor =
              [backgroundColorObj isKindOfClass:[NSNumber class]]
                  ? [backgroundColorObj intValue]
                  : 0;

          id renderModeObj = [canvasObj objectForKey:@"renderMode"];
          videoStreamObj.renderMode =
              [renderModeObj isKindOfClass:[NSNumber class]]
                  ? [renderModeObj intValue]
                  : 0;

          id mirrorModeObj = [canvasObj objectForKey:@"mirrorMode"];
          videoStreamObj.mirrorMode =
              [mirrorModeObj isKindOfClass:[NSNumber class]]
                  ? [mirrorModeObj intValue]
                  : 0;

          id setupModeObj = [canvasObj objectForKey:@"setupMode"];
          videoStreamObj.setupMode =
              [setupModeObj isKindOfClass:[NSNumber class]]
                  ? [setupModeObj intValue]
                  : 0;

          id sourceTypeObj = [canvasObj objectForKey:@"sourceType"];
          videoStreamObj.sourceType =
              [sourceTypeObj isKindOfClass:[NSNumber class]]
                  ? [sourceTypeObj intValue]
                  : 0;

          id enableAlphaMaskObj = [canvasObj objectForKey:@"enableAlphaMask"];
          videoStreamObj.enableAlphaMask =
              [enableAlphaMaskObj isKindOfClass:[NSNumber class]]
                  ? [enableAlphaMaskObj boolValue]
                  : NO;

          id positionObj = [canvasObj objectForKey:@"position"];
          videoStreamObj.position = [positionObj isKindOfClass:[NSNumber class]]
                                        ? [positionObj intValue]
                                        : 0;

          [tempVideoStreamArray addObject:videoStreamObj];
        }
        options.videoStreamArray = tempVideoStreamArray;
      }

      // contentViewLayout
      NSDictionary *contentViewLayout =
          [call.arguments objectForKey:@"contentViewLayout"];
      if (contentViewLayout) {
        options.contentViewLayout = [[AgoraPipContentViewLayout alloc] init];

        id paddingObj = [contentViewLayout objectForKey:@"padding"];
        options.contentViewLayout.padding =
            [paddingObj isKindOfClass:[NSNumber class]] ? [paddingObj intValue]
                                                        : 0;

        id spacingObj = [contentViewLayout objectForKey:@"spacing"];
        options.contentViewLayout.spacing =
            [spacingObj isKindOfClass:[NSNumber class]] ? [spacingObj intValue]
                                                        : 0;

        id rowObj = [contentViewLayout objectForKey:@"row"];
        options.contentViewLayout.row =
            [rowObj isKindOfClass:[NSNumber class]] ? [rowObj intValue] : 0;

        id columnObj = [contentViewLayout objectForKey:@"column"];
        options.contentViewLayout.column =
            [columnObj isKindOfClass:[NSNumber class]] ? [columnObj intValue]
                                                       : 0;
      }

      // apiEngine
      if ([call.arguments objectForKey:@"apiEngine"]) {
        options.apiEngine =
            (void *)[[call.arguments objectForKey:@"apiEngine"] pointerValue];
      }

      // preferred content size
      id preferredContentWidthObj =
          [call.arguments objectForKey:@"preferredContentWidth"];
      id preferredContentHeightObj =
          [call.arguments objectForKey:@"preferredContentHeight"];
      if (preferredContentWidthObj && preferredContentHeightObj &&
          [preferredContentWidthObj isKindOfClass:[NSNumber class]] &&
          [preferredContentHeightObj isKindOfClass:[NSNumber class]]) {
        options.preferredContentSize =
            CGSizeMake([preferredContentWidthObj floatValue],
                       [preferredContentHeightObj floatValue]);
      }

      // control style
      id controlStyleObj = [call.arguments objectForKey:@"controlStyle"];
      if (controlStyleObj && [controlStyleObj isKindOfClass:[NSNumber class]]) {
        options.controlStyle = [controlStyleObj intValue];
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

- (void)pipStateChanged:(AgoraPIPState)state error:(NSString *)error {
  AGORA_LOG(@"pipStateChanged: %ld, error: %@", (long)state, error);

  NSDictionary *arguments = [[NSDictionary alloc]
      initWithObjectsAndKeys:[NSNumber numberWithLong:(long)state], @"state",
                             error, @"error", nil];
  [self.channel invokeMethod:@"pipStateChanged" arguments:arguments];
}

@end
