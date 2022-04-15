#import <Foundation/Foundation.h>
#import "CallApiMethodCallHandler.h"
#import <AgoraRtcWrapper/iris_rtc_engine.h>
#import "Base/RtcEngineRegistry.h"

@interface CallApiMethodCallHandler ()
@property(nonatomic) agora::iris::rtc::IrisRtcEngine *irisRtcEngine;
@end

@implementation CallApiMethodCallHandler

- (instancetype)initWith:(void *)engine {
    self.irisRtcEngine = (agora::iris::rtc::IrisRtcEngine *)engine;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call _:(FlutterResult)result {
    if ([@"callApi" isEqualToString:call.method] || [@"callApiWithBuffer" isEqualToString:call.method]) {
        NSDictionary<NSString *, id> *arguments = call.arguments;
        NSNumber *apiType = arguments[@"apiType"];
        NSString *params = arguments[@"params"];
        FlutterStandardTypedData *buffer = arguments[@"buffer"];
        char res[kBasicResultLength] = "";
        int ret;
        if (buffer == nil || buffer == [NSNull null]) {
            
            ret = [self callApi:apiType _:params _:res];
        } else {
            ret = [self callApiWithBuffer:apiType _:params _:(void *)[[buffer data] bytes] _:res];
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
            result([FlutterError
                errorWithCode:[@(ret) stringValue]
                    message:des
                    details:nil]);
        }
    } else {
      result(FlutterMethodNotImplemented);
    }
}
- (int)callApi:(NSNumber *) apiType _:(NSString *)params _:(char *) result {
    ApiTypeEngine apiTypeEngine = (ApiTypeEngine)[apiType unsignedIntValue];
    int ret = self.irisRtcEngine->CallApi(apiTypeEngine, [params UTF8String], result);
    
     if (apiTypeEngine == ApiTypeEngine::kEngineInitialize) {
         [[RtcEngineRegistry shared] onRtcEngineCreated:(__bridge AgoraRtcEngineKit *) self.irisRtcEngine->rtc_engine()];
     }
    
     if (apiTypeEngine == ApiTypeEngine::kEngineRelease) {
         [[RtcEngineRegistry shared] onRtcEngineDestroyed];
     }
    
    return ret;
    
}

- (int)callApiWithBuffer:(NSNumber *) apiType _:(NSString *)params _:(void *)buffer _:(char *) result {
    return self.irisRtcEngine->CallApi((ApiTypeEngine)[apiType unsignedIntValue], [params UTF8String], buffer, result);
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
    return self.irisRtcEngine->channel()->CallApi((ApiTypeChannel)[apiType unsignedIntValue],
                                                  [params UTF8String],
                                                  result);
}

- (int)callApiWithBuffer:(NSNumber *)apiType _:(NSString *)params _:(void *)buffer _:(char *)result {
    return self.irisRtcEngine->channel()->CallApi((ApiTypeChannel)[apiType unsignedIntValue],
                                                  [params UTF8String],
                                                  buffer,
                                                  result);
}

@end
