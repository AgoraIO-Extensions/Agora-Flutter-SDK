#import "AgoraRtcEnginePlugin.h"
#import <AgoraRtcEngineKit/AgoraRtcEngineKit.h>

@interface AgoraRtcEnginePlugin()<AgoraRtcEngineDelegate>
@property (strong, nonatomic) AgoraRtcEngineKit *agoraRtcEngine;
@end

@implementation AgoraRtcEnginePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"agora_rtc_engine"
            binaryMessenger:[registrar messenger]];
  AgoraRtcEnginePlugin* instance = [[AgoraRtcEnginePlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  NSArray *arguments = call.arguments;
  
  if ([@"createEngine" isEqualToString:call.method]) {
    NSString *appid = arguments.firstObject;
    self.agoraRtcEngine = [AgoraRtcEngineKit sharedEngineWithAppId:appid delegate:self];
  } else if ([@"joinChannel" isEqualToString:call.method]) {
    NSString *token = [self stringFromArguments:arguments index:0];
    NSString *channel = [self stringFromArguments:arguments index:1];
    NSString *info = [self stringFromArguments:arguments index:2];
    NSInteger uid = [self intFromArguments:arguments index:3];
    
    [self.agoraRtcEngine joinChannelByToken:token channelId:channel info:info uid:uid  joinSuccess:nil];
    result([NSNumber numberWithBool:YES]);
  } else if ([@"leaveChannel" isEqualToString:call.method]) {
    BOOL success = (0 == [self.agoraRtcEngine leaveChannel:nil]);
    result([NSNumber numberWithBool:success]);
  }
  
  
  else {
    result(FlutterMethodNotImplemented);
  }
}

- (NSString *)stringFromArguments:(NSArray *)arguments index:(int)index {
  if (![arguments isKindOfClass:[NSArray class]]) {
    return nil;
  }
  if (arguments.count <= index) {
    return nil;
  }
  NSString *value = arguments[index];
  if (![value isKindOfClass:[NSString class]]) {
    return nil;
  } else {
    return value;
  }
}

- (NSInteger)intFromArguments:(NSArray *)arguments index:(int)index {
  if (![arguments isKindOfClass:[NSArray class]]) {
    return 0;
  }
  if (arguments.count >= index) {
    return 0;
  }
  NSNumber *value = arguments[index];
  if (![value isKindOfClass:[NSNumber class]]) {
    return 0;
  } else {
    return [value integerValue];
  }
}

@end
