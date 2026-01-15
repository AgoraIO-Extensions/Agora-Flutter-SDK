#import "AgoraRtcNgPlugin.h"
#import "AgoraSurfaceViewFactory.h"
#import "AgoraUtils.h"
#import "VideoViewController.h"
#import "AgoraRTEPlayerObserverDelegate.h"
#include <Foundation/Foundation.h>

@interface AgoraRtcNgPlugin ()

@property(nonatomic) FlutterMethodChannel *channel;

@property(nonatomic) VideoViewController *videoViewController;

@property(nonatomic) NSObject<FlutterPluginRegistrar> *registrar;

@property(nonatomic) AgoraPIPController *pipController;

@property(nonatomic) AgoraRTEController *rteController;

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
  
  // create rte controller
  instance.rteController = [[AgoraRTEController alloc] init];
  instance.rteController.playerObserverDelegate = (id<AgoraRTEPlayerObserverDelegate>)instance;
}

- (void)handleMethodCall:(FlutterMethodCall *)call
                  result:(FlutterResult)result {
  AGORA_LOG(@"handleMethodCall: %@ with arguments: %@", call.method,
            call.arguments);

  if ([@"getAssetAbsolutePath" isEqualToString:call.method]) {
    [self getAssetAbsolutePath:call result:result];
  } else if ([call.method hasPrefix:@"pip"]) {
    [self handlePipMethodCall:call result:result];
  } else if ([call.method hasPrefix:@"rte"]) {
    [self handleRteMethodCall:call result:result];
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

  dispatch_async(dispatch_get_main_queue(), ^{
      NSDictionary *arguments = [[NSDictionary alloc]
          initWithObjectsAndKeys:[NSNumber numberWithLong:(long)state], @"state",
                                 error, @"error", nil];
      [self.channel invokeMethod:@"pipStateChanged" arguments:arguments];
  });
}

- (void)handleRteMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
  NSDictionary *args = call.arguments;
  NSError *error = nil;
  
  // RTE 基础方法
  if ([@"rteCreateFromBridge" isEqualToString:call.method]) {
    BOOL success = [self.rteController createRteFromBridge:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR"
                                  message:error.localizedDescription
                                  details:nil]);
    }
  } else if ([@"rteCreateWithConfig" isEqualToString:call.method]) {
    BOOL success = [self.rteController createRteWithConfig:args error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR"
                                  message:error.localizedDescription
                                  details:nil]);
    }
  } else if ([@"rteInitMediaEngine" isEqualToString:call.method]) {
    BOOL success = [self.rteController initMediaEngine:^(NSError *err) {
      dispatch_async(dispatch_get_main_queue(), ^{
          if (err) {
            [self.channel invokeMethod:@"rteInitMediaEngineCallback"
                               arguments:@{@"error": err.localizedDescription}];
          } else {
            [self.channel invokeMethod:@"rteInitMediaEngineCallback"
                               arguments:@{@"error": [NSNull null]}];
          }
      });
    } error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR"
                                  message:error.localizedDescription
                                  details:nil]);
    }
  } else if ([@"rteDestroy" isEqualToString:call.method]) {
    BOOL success = [self.rteController destroyRte:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR"
                                  message:error.localizedDescription
                                  details:nil]);
    }
  } else if ([@"rtePlayerPreloadWithUrl" isEqualToString:call.method]) {
    NSString *url = args[@"url"];
    BOOL success = [AgoraRTEController preloadWithUrl:url error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR"
                                  message:error.localizedDescription
                                  details:nil]);
    }
  } else if ([@"rteSetConfigs" isEqualToString:call.method]) {
    BOOL success = [self.rteController setRteConfig:args error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rteGetConfigs" isEqualToString:call.method]) {
    NSDictionary *config = [self.rteController getRteConfig:&error];
    if (config) {
      result(config);
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rteGetAppId" isEqualToString:call.method]) {
    NSString *appId = [self.rteController appId:&error];
    if (appId) {
      result(appId);
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rteGetLogFolder" isEqualToString:call.method]) {
    NSString *logFolder = [self.rteController logFolder:&error];
    if (logFolder) {
      result(logFolder);
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rteGetLogFileSize" isEqualToString:call.method]) {
    NSNumber *logFileSize = [self.rteController logFileSize:&error];
    if (logFileSize) {
      result(logFileSize);
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rteGetAreaCode" isEqualToString:call.method]) {
    NSNumber *areaCode = [self.rteController areaCode:&error];
    if (areaCode) {
      result(areaCode);
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rteGetCloudProxy" isEqualToString:call.method]) {
    NSString *cloudProxy = [self.rteController cloudProxy:&error];
    if (cloudProxy) {
      result(cloudProxy);
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rteGetJsonParameter" isEqualToString:call.method]) {
    NSString *jsonParameter = [self.rteController jsonParameter:&error];
    if (jsonParameter) {
      result(jsonParameter);
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rteSetAppId" isEqualToString:call.method]) {
    NSString *appId = args[@"appId"];
    BOOL success = [self.rteController setAppId:appId error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rteSetLogFolder" isEqualToString:call.method]) {
    NSString *logFolder = args[@"logFolder"];
    BOOL success = [self.rteController setLogFolder:logFolder error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rteSetLogFileSize" isEqualToString:call.method]) {
    NSNumber *logFileSize = args[@"logFileSize"];
    BOOL success = [self.rteController setLogFileSize:logFileSize error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rteSetAreaCode" isEqualToString:call.method]) {
    NSNumber *areaCode = args[@"areaCode"];
    BOOL success = [self.rteController setAreaCode:areaCode error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rteSetCloudProxy" isEqualToString:call.method]) {
    NSString *cloudProxy = args[@"cloudProxy"];
    BOOL success = [self.rteController setCloudProxy:cloudProxy error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rteSetJsonParameter" isEqualToString:call.method]) {
    NSString *jsonParameter = args[@"jsonParameter"];
    BOOL success = [self.rteController setJsonParameter:jsonParameter error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
//  } else if ([@"rteRegisterObserver" isEqualToString:call.method]) {
//    BOOL success = [self.rteController registerRteObserver:&error];
//    if (success) {
//      result(@(YES));
//    } else {
//      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
//    }
//  } else if ([@"rteUnregisterObserver" isEqualToString:call.method]) {
//    BOOL success = [self.rteController unregisterRteObserver:&error];
//    if (success) {
//      result(@(YES));
//    } else {
//      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
//    }
  }
  // RTE Player 方法
  else if ([@"rtePlayerCreate" isEqualToString:call.method]) {
    NSString *playerId = [self.rteController createPlayer:args error:&error];
    if (playerId) {
      result(playerId);
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR"
                                  message:error.localizedDescription
                                  details:nil]);
    }
  } else if ([@"rtePlayerDestroy" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    BOOL success = [self.rteController destroyPlayer:playerId error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR"
                                  message:error.localizedDescription
                                  details:nil]);
    }
  } else if ([@"rtePlayerOpenUrl" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    NSString *url = args[@"url"];
    NSNumber *startTime = args[@"startTime"];
    BOOL success = [self.rteController playerOpenUrl:playerId
                                                  url:url
                                            startTime:[startTime longLongValue]
                                           completion:^(NSError *err) {
      dispatch_async(dispatch_get_main_queue(), ^{
          if (err) {
            [self.channel invokeMethod:@"rtePlayerOpenUrlCallback"
                               arguments:@{
                                 @"playerId": playerId,
                                 @"error": err.localizedDescription
                               }];
          } else {
            [self.channel invokeMethod:@"rtePlayerOpenUrlCallback"
                               arguments:@{
                                 @"playerId": playerId,
                                 @"error": [NSNull null]
                               }];
          }
      });
    } error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR"
                                  message:error.localizedDescription
                                  details:nil]);
    }
  } else if ([@"rtePlayerPlay" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    BOOL success = [self.rteController playerPlay:playerId error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR"
                                  message:error.localizedDescription
                                  details:nil]);
    }
  } else if ([@"rtePlayerPause" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    BOOL success = [self.rteController playerPause:playerId error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR"
                                  message:error.localizedDescription
                                  details:nil]);
    }
  } else if ([@"rtePlayerStop" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    BOOL success = [self.rteController playerStop:playerId error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR"
                                  message:error.localizedDescription
                                  details:nil]);
    }
  } else if ([@"rtePlayerSeek" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    NSNumber *position = args[@"position"];
    BOOL success = [self.rteController playerSeek:playerId position:[position longLongValue] error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR"
                                  message:error.localizedDescription
                                  details:nil]);
    }
  } else if ([@"rtePlayerMuteAudio" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    BOOL mute = [args[@"mute"] boolValue];
    BOOL success = [self.rteController playerMuteAudio:playerId mute:mute error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rtePlayerMuteVideo" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    BOOL mute = [args[@"mute"] boolValue];
    BOOL success = [self.rteController playerMuteVideo:playerId mute:mute error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rtePlayerGetDuration" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    int64_t duration = [self.rteController playerGetDuration:playerId error:&error];
    if (!error) {
      result(@(duration));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR"
                                  message:error.localizedDescription
                                  details:nil]);
    }
  } else if ([@"rtePlayerGetCurrentTime" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    int64_t currentTime = [self.rteController playerGetCurrentTime:playerId error:&error];
    if (!error) {
      result(@(currentTime));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR"
                                  message:error.localizedDescription
                                  details:nil]);
    }
  } else if ([@"rtePlayerSetPlaybackSpeed" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    NSNumber *speed = args[@"speed"];
    BOOL success = [self.rteController playerSetPlaybackSpeed:playerId speed:[speed intValue] error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR"
                                  message:error.localizedDescription
                                  details:nil]);
    }
  } else if ([@"rtePlayerGetPlaybackSpeed" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    int32_t speed = [self.rteController playerGetPlaybackSpeed:playerId error:&error];
    if (!error) {
      result(@(speed));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR"
                                  message:error.localizedDescription
                                  details:nil]);
    }
  } else if ([@"rtePlayerSetPlayoutVolume" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    NSNumber *volume = args[@"volume"];
    BOOL success = [self.rteController playerSetPlayoutVolume:playerId volume:[volume intValue] error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR"
                                  message:error.localizedDescription
                                  details:nil]);
    }
  } else if ([@"rtePlayerGetPlayoutVolume" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    int32_t volume = [self.rteController playerGetPlayoutVolume:playerId error:&error];
    if (!error) {
      result(@(volume));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR"
                                  message:error.localizedDescription
                                  details:nil]);
    }
  } else if ([@"rtePlayerSetLoopCount" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    NSNumber *count = args[@"count"];
    BOOL success = [self.rteController playerSetLoopCount:playerId count:[count intValue] error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR"
                                  message:error.localizedDescription
                                  details:nil]);
    }
  } else if ([@"rtePlayerGetLoopCount" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    int32_t count = [self.rteController playerGetLoopCount:playerId error:&error];
    if (!error) {
      result(@(count));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR"
                                  message:error.localizedDescription
                                  details:nil]);
    }
  } else if ([@"rtePlayerSetCanvas" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    NSString *canvasId = args[@"canvasId"];
    BOOL success = [self.rteController playerSetCanvas:playerId canvasId:canvasId error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR"
                                  message:error.localizedDescription
                                  details:nil]);
    }
  } else if ([@"rtePlayerOpenWithCustomSourceProvider" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    NSNumber *startTime = args[@"startTime"];
    void *provider = (void *)[args[@"provider"] longLongValue];
    BOOL success = [self.rteController playerOpenWithCustomSourceProvider:playerId provider:provider startTime:[startTime unsignedLongLongValue] completion:^(NSError *err) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.channel invokeMethod:@"rtePlayerOpenWithCustomSourceProviderCallback"
                             arguments:@{
                               @"playerId": playerId,
                               @"error": err ? err.localizedDescription : [NSNull null]
                             }];
        });
    } error:&error];
    if (success) {
        result(@(YES));
    } else {
        result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rtePlayerOpenWithStream" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    void *stream = (void *)[args[@"stream"] longLongValue];
    BOOL success = [self.rteController playerOpenWithStream:playerId stream:stream completion:^(NSError *err) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.channel invokeMethod:@"rtePlayerOpenWithStreamCallback"
                             arguments:@{
                               @"playerId": playerId,
                               @"error": err ? err.localizedDescription : [NSNull null]
                             }];
        });
    } error:&error];
    if (success) {
        result(@(YES));
    } else {
        result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rtePlayerSwitchWithUrl" isEqualToString:call.method]) {
      NSString *playerId = args[@"playerId"];
      NSString *url = args[@"url"];
      BOOL syncPts = [args[@"syncPts"] boolValue];
      BOOL success = [self.rteController playerSwitch:playerId url:url syncPts:syncPts completion:nil error:&error];
      if (success) {
          result(@(YES));
      } else {
          result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
      }
  } else if ([@"rtePlayerGetStats" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    [self.rteController playerGetStats:playerId completion:^(NSDictionary *stats, NSError *err) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (err) {
                result([FlutterError errorWithCode:@"RTE_ERROR" message:err.localizedDescription details:nil]);
            } else {
                result(stats);
            }
        });
    }];
  } else if ([@"rtePlayerGetInfo" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    NSDictionary *info = [self.rteController playerGetInfo:playerId error:&error];
    if (info) {
        result(info);
    } else {
        result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rtePlayerSetConfigs" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    NSDictionary *config = args[@"config"];
    BOOL success = [self.rteController playerSetConfig:playerId config:config error:&error];
    if (success) {
        result(@(YES));
    } else {
        result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rtePlayerGetConfigs" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    NSDictionary *config = [self.rteController playerGetConfig:playerId error:&error];
    if (config) {
        result(config);
    } else {
        result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rtePlayerRegisterObserver" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    BOOL success = [self.rteController playerRegisterObserver:playerId error:&error];
    if (success) {
        result(@(YES));
    } else {
        result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rtePlayerUnregisterObserver" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    BOOL success = [self.rteController playerUnregisterObserver:playerId error:&error];
    if (success) {
        result(@(YES));
    } else {
        result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rtePlayerGetAutoPlay" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    BOOL autoPlay = [self.rteController playerGetAutoPlay:playerId error:&error];
    if (!error) {
      result(@(autoPlay));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rtePlayerSetAutoPlay" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    BOOL autoPlay = [args[@"autoPlay"] boolValue];
    BOOL success = [self.rteController playerSetAutoPlay:playerId autoPlay:autoPlay error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rtePlayerGetPlayoutAudioTrackIdx" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    int32_t idx = [self.rteController playerGetPlayoutAudioTrackIdx:playerId error:&error];
    if (!error) {
      result(@(idx));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rtePlayerSetPlayoutAudioTrackIdx" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    NSNumber *idx = args[@"idx"];
    BOOL success = [self.rteController playerSetPlayoutAudioTrackIdx:playerId idx:[idx intValue] error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rtePlayerGetPublishAudioTrackIdx" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    int32_t idx = [self.rteController playerGetPublishAudioTrackIdx:playerId error:&error];
    if (!error) {
      result(@(idx));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rtePlayerSetPublishAudioTrackIdx" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    NSNumber *idx = args[@"idx"];
    BOOL success = [self.rteController playerSetPublishAudioTrackIdx:playerId idx:[idx intValue] error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rtePlayerGetAudioTrackIdx" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    int32_t idx = [self.rteController playerGetAudioTrackIdx:playerId error:&error];
    if (!error) {
      result(@(idx));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rtePlayerSetAudioTrackIdx" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    NSNumber *idx = args[@"idx"];
    BOOL success = [self.rteController playerSetAudioTrackIdx:playerId idx:[idx intValue] error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rtePlayerGetSubtitleTrackIdx" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    int32_t idx = [self.rteController playerGetSubtitleTrackIdx:playerId error:&error];
    if (!error) {
      result(@(idx));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rtePlayerSetSubtitleTrackIdx" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    NSNumber *idx = args[@"idx"];
    BOOL success = [self.rteController playerSetSubtitleTrackIdx:playerId idx:[idx intValue] error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rtePlayerGetExternalSubtitleTrackIdx" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    int32_t idx = [self.rteController playerGetExternalSubtitleTrackIdx:playerId error:&error];
    if (!error) {
      result(@(idx));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rtePlayerSetExternalSubtitleTrackIdx" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    NSNumber *idx = args[@"idx"];
    BOOL success = [self.rteController playerSetExternalSubtitleTrackIdx:playerId idx:[idx intValue] error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rtePlayerGetAudioPitch" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    int32_t pitch = [self.rteController playerGetAudioPitch:playerId error:&error];
    if (!error) {
      result(@(pitch));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rtePlayerSetAudioPitch" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    NSNumber *pitch = args[@"pitch"];
    BOOL success = [self.rteController playerSetAudioPitch:playerId pitch:[pitch intValue] error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rtePlayerGetAudioPlaybackDelay" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    int32_t delay = [self.rteController playerGetAudioPlaybackDelay:playerId error:&error];
    if (!error) {
      result(@(delay));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rtePlayerSetAudioPlaybackDelay" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    NSNumber *delay = args[@"delay"];
    BOOL success = [self.rteController playerSetAudioPlaybackDelay:playerId delay:[delay intValue] error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rtePlayerGetAudioDualMonoMode" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    int32_t mode = [self.rteController playerGetAudioDualMonoMode:playerId error:&error];
    if (!error) {
      result(@(mode));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rtePlayerSetAudioDualMonoMode" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    NSNumber *mode = args[@"mode"];
    BOOL success = [self.rteController playerSetAudioDualMonoMode:playerId mode:[mode intValue] error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rtePlayerGetPublishVolume" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    int32_t volume = [self.rteController playerGetPublishVolume:playerId error:&error];
    if (!error) {
      result(@(volume));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rtePlayerSetPublishVolume" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    NSNumber *volume = args[@"volume"];
    BOOL success = [self.rteController playerSetPublishVolume:playerId volume:[volume intValue] error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rtePlayerGetJsonParameter" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    NSString *jsonParameter = [self.rteController playerGetJsonParameter:playerId error:&error];
    if (jsonParameter) {
      result(jsonParameter);
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rtePlayerSetJsonParameter" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    NSString *jsonParameter = args[@"jsonParameter"];
    BOOL success = [self.rteController playerSetJsonParameter:playerId jsonParameter:jsonParameter error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rtePlayerGetAbrSubscriptionLayer" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    AgoraRteAbrSubscriptionLayer layer = [self.rteController playerGetAbrSubscriptionLayer:playerId error:&error];
    if (!error) {
      result(@(layer));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rtePlayerSetAbrSubscriptionLayer" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    NSNumber *layer = args[@"layer"];
    BOOL success = [self.rteController playerSetAbrSubscriptionLayer:playerId layer:[layer intValue] error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rtePlayerGetAbrFallbackLayer" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    AgoraRteAbrFallbackLayer layer = [self.rteController playerGetAbrFallbackLayer:playerId error:&error];
    if (!error) {
      result(@(layer));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rtePlayerSetAbrFallbackLayer" isEqualToString:call.method]) {
    NSString *playerId = args[@"playerId"];
    NSNumber *layer = args[@"layer"];
    BOOL success = [self.rteController playerSetAbrFallbackLayer:playerId layer:[layer intValue] error:&error];
    if (success) {
      result(@(YES));
    } else {
      result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
    }
  } else if ([@"rteCanvasCreate" isEqualToString:call.method]) {
      NSString *canvasId = [self.rteController createCanvas:args error:&error];
      if (canvasId) {
          result(canvasId);
      } else {
          result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
      }
  } else if ([@"rteCanvasDestroy" isEqualToString:call.method]) {
      NSString *canvasId = args[@"canvasId"];
      BOOL success = [self.rteController destroyCanvas:canvasId error:&error];
      if (success) {
          result(@(YES));
      } else {
          result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
      }
  } else if ([@"rteCanvasSetConfigs" isEqualToString:call.method]) {
      NSString *canvasId = args[@"canvasId"];
      NSDictionary *config = args[@"config"];
      BOOL success = [self.rteController canvasSetConfig:canvasId config:config error:&error];
      if (success) {
          result(@(YES));
      } else {
          result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
      }
  } else if ([@"rteCanvasGetConfigs" isEqualToString:call.method]) {
      NSString *canvasId = args[@"canvasId"];
      NSDictionary *config = [self.rteController canvasGetConfig:canvasId error:&error];
      if (config) {
          result(config);
      } else {
          result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
      }
  } else if ([@"rteCanvasAddView" isEqualToString:call.method]) {
      NSString *canvasId = args[@"canvasId"];
      UIView *view = (__bridge UIView *)(void *)(intptr_t)[args[@"viewPtr"] longLongValue];
      NSDictionary *config = args[@"config"];
      BOOL success = [self.rteController canvasAddView:canvasId view:view config:config error:&error];
      if (success) {
          result(@(YES));
      } else {
          result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
      }
  } else if ([@"rteCanvasRemoveView" isEqualToString:call.method]) {
      NSString *canvasId = args[@"canvasId"];
      UIView *view = (__bridge UIView *)(void *)(intptr_t)[args[@"viewPtr"] longLongValue];
      NSDictionary *config = args[@"config"];
      BOOL success = [self.rteController canvasRemoveView:canvasId view:view config:config error:&error];
      if (success) {
          result(@(YES));
      } else {
          result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
      }
  } else if ([@"rteCanvasGetVideoRenderMode" isEqualToString:call.method]) {
      NSString *canvasId = args[@"canvasId"];
      AgoraRteVideoRenderMode mode = [self.rteController canvasGetVideoRenderMode:canvasId error:&error];
      if (!error) {
          result(@(mode));
      } else {
          result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
      }
  } else if ([@"rteCanvasSetVideoRenderMode" isEqualToString:call.method]) {
      NSString *canvasId = args[@"canvasId"];
      NSNumber *mode = args[@"mode"];
      BOOL success = [self.rteController canvasSetVideoRenderMode:canvasId mode:[mode intValue] error:&error];
      if (success) {
          result(@(YES));
      } else {
          result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
      }
  } else if ([@"rteCanvasGetVideoMirrorMode" isEqualToString:call.method]) {
      NSString *canvasId = args[@"canvasId"];
      AgoraRteVideoMirrorMode mode = [self.rteController canvasGetVideoMirrorMode:canvasId error:&error];
      if (!error) {
          result(@(mode));
      } else {
          result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
      }
  } else if ([@"rteCanvasSetVideoMirrorMode" isEqualToString:call.method]) {
      NSString *canvasId = args[@"canvasId"];
      NSNumber *mode = args[@"mode"];
      BOOL success = [self.rteController canvasSetVideoMirrorMode:canvasId mode:[mode intValue] error:&error];
      if (success) {
          result(@(YES));
      } else {
          result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
      }
  } else if ([@"rteCanvasGetCropArea" isEqualToString:call.method]) {
      NSString *canvasId = args[@"canvasId"];
      NSDictionary *cropArea = [self.rteController canvasGetCropArea:canvasId error:&error];
      if (cropArea) {
          result(cropArea);
      } else {
          result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
      }
  } else if ([@"rteCanvasSetCropArea" isEqualToString:call.method]) {
      NSString *canvasId = args[@"canvasId"];
      NSNumber *x = args[@"x"];
      NSNumber *y = args[@"y"];
      NSNumber *width = args[@"width"];
      NSNumber *height = args[@"height"];
      BOOL success = [self.rteController canvasSetCropArea:canvasId x:[x intValue] y:[y intValue] width:[width intValue] height:[height intValue] error:&error];
      if (success) {
          result(@(YES));
      } else {
          result([FlutterError errorWithCode:@"RTE_ERROR" message:error.localizedDescription details:nil]);
      }
  } else {
    result(FlutterMethodNotImplemented);
  }
}

#pragma mark - AgoraRTEPlayerObserverDelegate

- (void)player:(NSString *)playerId onStateChanged:(NSInteger)oldState newState:(NSInteger)newState errorCode:(NSInteger)errorCode errorMessage:(NSString *)errorMessage {
  [self.channel invokeMethod:@"rtePlayerOnStateChanged"
                   arguments:@{
                     @"playerId": playerId,
                     @"oldState": @(oldState),
                     @"newState": @(newState),
                     @"errorCode": @(errorCode),
                     @"errorMessage": errorMessage ?: @""
                   }];
}

- (void)player:(NSString *)playerId onPositionChanged:(uint64_t)currentTime utcTime:(uint64_t)utcTime {
  [self.channel invokeMethod:@"rtePlayerOnPositionChanged"
                   arguments:@{
                     @"playerId": playerId,
                     @"currentTime": @(currentTime),
                     @"utcTime": @(utcTime)
                   }];
}

- (void)player:(NSString *)playerId onResolutionChanged:(int)width height:(int)height {
  [self.channel invokeMethod:@"rtePlayerOnResolutionChanged"
                   arguments:@{
                     @"playerId": playerId,
                     @"width": @(width),
                     @"height": @(height)
                   }];
}

- (void)player:(NSString *)playerId onEvent:(NSInteger)event {
  [self.channel invokeMethod:@"rtePlayerOnEvent"
                   arguments:@{
                     @"playerId": playerId,
                     @"event": @(event)
                   }];
}

- (void)player:(NSString *)playerId onMetadata:(NSInteger)type data:(NSData *)data {
  [self.channel invokeMethod:@"rtePlayerOnMetadata"
                   arguments:@{
                     @"playerId": playerId,
                     @"type": @(type),
                     @"data": data
                   }];
}

- (void)player:(NSString *)playerId onPlayerInfoUpdated:(NSDictionary *)info {
  [self.channel invokeMethod:@"rtePlayerOnPlayerInfoUpdated"
                   arguments:@{
                     @"playerId": playerId,
                     @"info": info
                   }];
}

- (void)player:(NSString *)playerId onAudioVolumeIndication:(int32_t)volume {
  [self.channel invokeMethod:@"rtePlayerOnAudioVolumeIndication"
                   arguments:@{
                     @"playerId": playerId,
                     @"volume": @(volume)
                   }];
}

@end
