#import "CallApiMethodCallHandler.h"
#import <AgoraRtcWrapper/iris_rtc_device_manager.h>
#import <AgoraRtcWrapper/iris_rtc_engine.h>
#import <Foundation/Foundation.h>

@interface CallApiMethodCallHandler ()
@property(nonatomic) agora::iris::rtc::IrisRtcEngine *irisRtcEngine;
@property(nonatomic) int maxResultLength;
@end

@implementation CallApiMethodCallHandler

- (instancetype)initWith:(void *)engine {
    return [self initWith:engine maxResultLength:kBasicResultLength];
}

- (instancetype)initWith:(void *)engine maxResultLength:(int)maxResultLength {
    self = [super init];
    if (self) {
        self.irisRtcEngine = (agora::iris::rtc::IrisRtcEngine *)engine;
        self.maxResultLength = maxResultLength;
    }
    return self;
    
}

- (void)onMethodCall:(FlutterMethodCall *)call _:(FlutterResult)result {
  if ([@"callApi" isEqualToString:call.method] ||
      [@"callApiWithBuffer" isEqualToString:call.method]) {
      NSDictionary<NSString *, id> *arguments = call.arguments;
      NSNumber *apiType = arguments[@"apiType"];
      NSString *params = arguments[@"params"];
      FlutterStandardTypedData *buffer = arguments[@"buffer"];
      const int length = [self maxResultLength];
      char res[length];
      res[length] = {'\0'};
      int ret;
      if (buffer == nil || buffer == [NSNull null]) {

        ret = [self callApi:apiType
                          _:params
                          _:res]; // self.irisRtcEngine->CallApi(
      } else {
        ret = [self callApiWithBuffer:apiType
                                    _:params
                                    _:(void *)[[buffer data] bytes]
                                    _:res];
      }
      if (ret == 0) {
        if (strlen(res) == 0) {
          result(nil);
        } else {
          result([NSString stringWithUTF8String:res]);
        }
      } else if (ret > 0) {
        result(@(ret));
      } else {
        NSString *des = [self callApiError:ret];
        result([FlutterError errorWithCode:[@(ret) stringValue]
                                   message:des
                                   details:nil]);
      }
  } else {
    result(FlutterMethodNotImplemented);
  }
}
- (int)callApi:(NSNumber *)apiType _:(NSString *)params _:(char *)result {
  return self.irisRtcEngine->CallApi((ApiTypeEngine)[apiType unsignedIntValue],
                                     [params UTF8String], result);
}

- (int)callApiWithBuffer:(NSNumber *)apiType
                       _:(NSString *)params
                       _:(void *)buffer
                       _:(char *)result {
  return self.irisRtcEngine->CallApi((ApiTypeEngine)[apiType unsignedIntValue],
                                     [params UTF8String], buffer, result);
}

- (NSString *)callApiError:(int)ret {
  char description[kBasicResultLength];
  self.irisRtcEngine->CallApi(
      ApiTypeEngine::kEngineGetErrorDescription,
      [[NSString stringWithFormat:@"{\"code\":%d}", abs(ret)] UTF8String],
      description);
  return [NSString stringWithUTF8String:description];
}

@end

@implementation RtcChannelCallApiMethodCallHandler

- (int)callApi:(NSNumber *)apiType _:(NSString *)params _:(char *)result {
  return self.irisRtcEngine->channel()->CallApi(
      (ApiTypeChannel)[apiType unsignedIntValue], [params UTF8String], result);
}

- (int)callApiWithBuffer:(NSNumber *)apiType
                       _:(NSString *)params
                       _:(void *)buffer
                       _:(char *)result {
  return self.irisRtcEngine->channel()->CallApi(
      (ApiTypeChannel)[apiType unsignedIntValue], [params UTF8String], buffer,
      result);
}

@end

@implementation RtcADMCallApiMethodCallHandler

- (int)callApi:(NSNumber *)apiType _:(NSString *)params _:(char *)result {
    agora::iris::rtc::IrisRtcDeviceManager * deviceManager = (agora::iris::rtc::IrisRtcDeviceManager *) self.irisRtcEngine->device_manager();
  return deviceManager->CallApi((ApiTypeAudioDeviceManager)[apiType unsignedIntValue],
                [params UTF8String], result);
}

@end

@implementation RtcVDMCallApiMethodCallHandler

- (int)callApi:(NSNumber *)apiType _:(NSString *)params _:(char *)result {
    agora::iris::rtc::IrisRtcDeviceManager * deviceManager = (agora::iris::rtc::IrisRtcDeviceManager *) self.irisRtcEngine->device_manager();
  return deviceManager->CallApi((ApiTypeVideoDeviceManager)[apiType unsignedIntValue],
                [params UTF8String], result);
}

@end
