#import "AgoraRtcEnginePlugin.h"
#import <AgoraRtcEngineKit/AgoraRtcEngineKit.h>

@interface AgoraRendererView()
@property (nonatomic, strong) UIView *renderView;
@property (nonatomic, assign) int64_t viewId;
@end

@implementation AgoraRendererView
- (instancetype)initWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId {
  if (self = [super init]) {
    self.renderView = [[UIView alloc] initWithFrame:frame];
    self.renderView.backgroundColor = [UIColor blackColor];
    self.viewId = viewId;
  }
  return self;
}

- (nonnull UIView *)view {
  return self.renderView;
}
@end

@interface AgoraRenderViewFactory : NSObject<FlutterPlatformViewFactory>
@end

@interface AgoraRtcEnginePlugin()<AgoraRtcEngineDelegate>
@property (strong, nonatomic) AgoraRtcEngineKit *agoraRtcEngine;
@property (strong, nonatomic) FlutterMethodChannel *channel;
@property (strong, nonatomic) NSMutableDictionary *rendererViews;
@end

@implementation AgoraRtcEnginePlugin
#pragma mark - renderer views
+ (instancetype)sharedPlugin {
  static AgoraRtcEnginePlugin* plugin = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    plugin = [[AgoraRtcEnginePlugin alloc] init];
  });
  return plugin;
}

- (NSMutableDictionary *)rendererViews {
  if (!_rendererViews) {
    _rendererViews = [[NSMutableDictionary alloc] init];
  }
  return _rendererViews;
}

+ (void)addView:(UIView *)view id:(NSNumber *)viewId {
  if (!viewId) {
    return;
  }
  if (view) {
    [[[AgoraRtcEnginePlugin sharedPlugin] rendererViews] setObject:view forKey:viewId];
  } else {
    [self removeViewForId:viewId];
  }
}

+ (void)removeViewForId:(NSNumber *)viewId {
  if (!viewId) {
    return;
  }
  [[[AgoraRtcEnginePlugin sharedPlugin] rendererViews] removeObjectForKey:viewId];
}

+ (UIView *)viewForId:(NSNumber *)viewId {
  if (!viewId) {
    return nil;
  }
  return [[[AgoraRtcEnginePlugin sharedPlugin] rendererViews] objectForKey:viewId];
}

#pragma mark - Flutter
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"agora_rtc_engine"
            binaryMessenger:[registrar messenger]];
  AgoraRtcEnginePlugin* instance = [[AgoraRtcEnginePlugin alloc] init];
  instance.channel = channel;
  [registrar addMethodCallDelegate:instance channel:channel];
  
  AgoraRenderViewFactory *fac = [[AgoraRenderViewFactory alloc] init];
  [registrar registerViewFactory:fac withId:@"AgoraRendererView"];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  NSString *method = call.method;
  NSDictionary *arguments = call.arguments;
  NSLog(@"plugin handleMethodCall: %@, argus: %@", method, arguments);
  
  if ([@"createEngine" isEqualToString:method]) {
    NSString *appId = [self stringFromArguments:arguments key:@"appId"];;
    self.agoraRtcEngine = [AgoraRtcEngineKit sharedEngineWithAppId:appId delegate:self];
  } else if ([@"joinChannel" isEqualToString:method]) {
    NSString *token = [self stringFromArguments:arguments key:@"token"];
    NSString *channel = [self stringFromArguments:arguments key:@"channelId"];
    NSString *info = [self stringFromArguments:arguments key:@"info"];
    NSInteger uid = [self intFromArguments:arguments key:@"uid"];
    
    [self.agoraRtcEngine joinChannelByToken:token channelId:channel info:info uid:uid  joinSuccess:nil];
    result([NSNumber numberWithBool:YES]);
  } else if ([@"leaveChannel" isEqualToString:method]) {
    BOOL success = (0 == [self.agoraRtcEngine leaveChannel:nil]);
    result([NSNumber numberWithBool:success]);
  } else if ([@"setupLocalVideo" isEqualToString:method]) {
    NSInteger viewId = [self intFromArguments:arguments key:@"viewId"];
    UIView *view = [AgoraRtcEnginePlugin viewForId:@(viewId)];
    NSInteger renderType = [self intFromArguments:arguments key:@"renderMode"];
    
    AgoraRtcVideoCanvas *canvas = [[AgoraRtcVideoCanvas alloc] init];
    canvas.view = view;
    canvas.renderMode = renderType;
    [self.agoraRtcEngine setupLocalVideo:canvas];
  } else if ([@"setupRemoteVideo" isEqualToString:method]) {
    NSInteger viewId = [self intFromArguments:arguments key:@"viewId"];
    UIView *view = [AgoraRtcEnginePlugin viewForId:@(viewId)];
    NSInteger renderType = [self intFromArguments:arguments key:@"renderMode"];
    NSInteger uid = [self intFromArguments:arguments key:@"uid"];
    
    AgoraRtcVideoCanvas *canvas = [[AgoraRtcVideoCanvas alloc] init];
    canvas.view = view;
    canvas.renderMode = renderType;
    canvas.uid = uid;
    [self.agoraRtcEngine setupRemoteVideo:canvas];
  } else if ([@"enableVideo" isEqualToString:method]) {
    [self.agoraRtcEngine enableVideo];
  } else if ([@"disableVideo" isEqualToString:method]) {
    [self.agoraRtcEngine disableVideo];
  } else if ([@"startPreview" isEqualToString:method]) {
    [self.agoraRtcEngine startPreview];
  } else if ([@"stopPreview" isEqualToString:method]) {
    [self.agoraRtcEngine stopPreview];
  }
  
  else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)dealloc {
  [self.channel setMethodCallHandler:nil];
}

#pragma mark - delegate
- (void)rtcEngine:(AgoraRtcEngineKit *)engine didJoinChannel:(NSString *)channel withUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
  [self.channel invokeMethod:@"didJoinChannel" arguments:@{@"channel": channel, @"uid": @(uid), @"elapsed": @(elapsed)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didLeaveChannelWithStats:(AgoraChannelStats *)stats {
  [self.channel invokeMethod:@"didLeaveChannel" arguments:nil];
}

#pragma mark - helper
- (NSString *)stringFromArguments:(NSDictionary *)arguments key:(NSString *)key {
  if (![arguments isKindOfClass:[NSDictionary class]]) {
    return nil;
  }
  
  NSString *value = [arguments valueForKey:key];
  if (![value isKindOfClass:[NSString class]]) {
    return nil;
  } else {
    return value;
  }
}

- (NSInteger)intFromArguments:(NSDictionary *)arguments key:(NSString *)key {
  if (![arguments isKindOfClass:[NSDictionary class]]) {
    return 0;
  }
  
  NSNumber *value = [arguments valueForKey:key];
  if (![value isKindOfClass:[NSNumber class]]) {
    return 0;
  } else {
    return [value integerValue];
  }
}

@end

@implementation AgoraRenderViewFactory
- (nonnull NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id _Nullable)args {
  AgoraRendererView *rendererView = [[AgoraRendererView alloc] initWithFrame:frame viewIdentifier:viewId];
  [AgoraRtcEnginePlugin addView:rendererView.view id:@(viewId)];
  return rendererView;
}
@end
