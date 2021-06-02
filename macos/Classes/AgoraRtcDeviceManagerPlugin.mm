#import "AgoraRtcDeviceManagerPlugin.h"
#import <AgoraRtcWrapper/iris_rtc_engine.h>
#import <string>

using namespace agora::iris;
using namespace agora::iris::rtc;

@interface AgoraRtcDeviceManagerPlugin ()
@property(nonatomic) IrisRtcEngine *engine;
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
  [registrar addMethodCallDelegate:audioInstance channel:audioMethodChannel];
  FlutterMethodChannel *videoMethodChannel = [FlutterMethodChannel
      methodChannelWithName:@"agora_rtc_video_device_manager"
            binaryMessenger:[registrar messenger]];
  AgoraRtcDeviceManagerPlugin *videoInstance =
      [[AgoraRtcDeviceManagerPlugin alloc] initWithType:NO];
  videoInstance.engine = (IrisRtcEngine *)engine;
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
  if ([@"callApi" isEqualToString:call.method]) {
    NSNumber *apiType = call.arguments[@"apiType"];
    NSString *params = call.arguments[@"params"];
    char res[kMaxResultLength] = "";
    int ret = 0;
    if (self.audio) {
      ret = self.engine->device_manager()->CallApi(
          (ApiTypeAudioDeviceManager)[apiType unsignedIntValue],
          [params UTF8String], res);
    } else {
      ret = self.engine->device_manager()->CallApi(
          (ApiTypeVideoDeviceManager)[apiType unsignedIntValue],
          [params UTF8String], res);
    }

    if (ret == 0) {
      std::string res_str(res);
      if (res_str.empty()) {
        result(nil);
      } else {
        result([NSString stringWithUTF8String:res]);
      }
    } else if (ret > 0) {
      result(@(ret));
    } else {
      result([FlutterError errorWithCode:[NSString stringWithFormat:@"%d", ret]
                                 message:nil
                                 details:nil]);
    }
  } else {
    result(FlutterMethodNotImplemented);
  }
}
@end
