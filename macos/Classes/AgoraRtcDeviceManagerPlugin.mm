#import "AgoraRtcDeviceManagerPlugin.h"
#import <AgoraRtcWrapper/iris_rtc_engine.h>
#import "CallApiMethodCallHandler.h"
#import <string>

using namespace agora::iris;
using namespace agora::iris::rtc;

@interface AgoraRtcDeviceManagerPlugin ()
@property(nonatomic) IrisRtcEngine *engine;
@property(nonatomic) CallApiMethodCallHandler *callApiMethodCallHandler;
@end

@implementation AgoraRtcDeviceManagerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar
                       engine:(void *)engine {
  FlutterMethodChannel *audioMethodChannel = [FlutterMethodChannel
      methodChannelWithName:@"agora_rtc_audio_device_manager"
            binaryMessenger:[registrar messenger]];
  AgoraRtcDeviceManagerPlugin *audioInstance =
      [[AgoraRtcDeviceManagerPlugin alloc] initWithType:YES];
  audioInstance.engine = (IrisRtcEngine *)engine;
    audioInstance.callApiMethodCallHandler = [[CallApiMethodCallHandler alloc] initWith:engine];
  [registrar addMethodCallDelegate:audioInstance channel:audioMethodChannel];
  FlutterMethodChannel *videoMethodChannel = [FlutterMethodChannel
      methodChannelWithName:@"agora_rtc_video_device_manager"
            binaryMessenger:[registrar messenger]];
  AgoraRtcDeviceManagerPlugin *videoInstance =
      [[AgoraRtcDeviceManagerPlugin alloc] initWithType:NO];
  videoInstance.engine = (IrisRtcEngine *)engine;
    videoInstance.callApiMethodCallHandler = [[CallApiMethodCallHandler alloc] initWith:engine];
  [registrar addMethodCallDelegate:videoInstance channel:videoMethodChannel];
}

- (instancetype)initWithType:(BOOL)audio {
  self = [super init];
  if (self) {
    self.audio = audio;
  }
  return self;
}

- (void)handleMethodCall:(FlutterMethodCall *)call
                  result:(FlutterResult)result {
    // TODO(littlegnal): Should handle self.engine->device_manager()->CallApi
    [[self callApiMethodCallHandler] onMethodCall:call _:result];
}

+ (void)registerWithRegistrar:(nonnull id<FlutterPluginRegistrar>)registrar {
}

@end
