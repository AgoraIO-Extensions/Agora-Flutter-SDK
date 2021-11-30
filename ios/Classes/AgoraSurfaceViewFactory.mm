#import "AgoraSurfaceViewFactory.h"
#import <AgoraRtcWrapper/iris_rtc_engine.h>
#import "CallApiMethodCallHandler.h"

@interface SurfaceViewCallApiMethodCallHandler : CallApiMethodCallHandler
@property(nonatomic) NSObject<FlutterPlatformView> *platformView;
- (instancetype)initWith:(agora::iris::rtc::IrisRtcEngine *)irisRtcEngine platformView:(NSObject<FlutterPlatformView>*) platformView;
@end

@implementation SurfaceViewCallApiMethodCallHandler

- (instancetype)initWith:(agora::iris::rtc::IrisRtcEngine *)irisRtcEngine platformView:(NSObject<FlutterPlatformView> *) platformView {
    self.irisRtcEngine = irisRtcEngine;
    self.platformView = platformView;
    return self;
}

- (int)callApi:(NSNumber *)apiType _:(NSString *)params _:(char *)result {
    return self.irisRtcEngine->CallApi((ApiTypeEngine)[apiType unsignedIntValue], [params UTF8String], (__bridge void *)self.platformView.view, result);
}

- (int)callApiWithBuffer:(NSNumber *)apiType _:(NSString *)params _:(void *)buffer _:(char *)result {
    return self.irisRtcEngine->CallApi((ApiTypeEngine)[apiType unsignedIntValue], [params UTF8String], (__bridge void *)self.platformView.view, result);
}

@end

@interface AgoraSurfaceView : NSObject <FlutterPlatformView>

@property(nonatomic, strong) UIView *surfaceView;

@property(nonatomic, strong) FlutterMethodChannel *methodChannel;

@property(nonatomic) agora::iris::rtc::IrisRtcEngine *engine;

@property(nonatomic) CallApiMethodCallHandler *callApiMethodCallHandler;

- (instancetype)initWith:(NSObject<FlutterBinaryMessenger> *)messenger
                  engine:(agora::iris::rtc::IrisRtcEngine *)engine
                   frame:(CGRect)frame
                  viewId:(int64_t)viewId
                    args:(NSDictionary *)args;

@end

@implementation AgoraSurfaceView

- (instancetype)initWith:(NSObject<FlutterBinaryMessenger> *)messenger
                  engine:(agora::iris::rtc::IrisRtcEngine *)engine
                   frame:(CGRect)frame
                  viewId:(int64_t)viewId
                    args:(NSDictionary *)args {
  if (self = [super init]) {
    self.surfaceView = [[UIView alloc] initWithFrame:frame];
    self.methodChannel = [FlutterMethodChannel
        methodChannelWithName:
            [NSString
                stringWithFormat:@"agora_rtc_engine/surface_view_%lld",
                                 viewId]
              binaryMessenger:messenger];
    self.engine = engine;
      
      self.callApiMethodCallHandler = [[SurfaceViewCallApiMethodCallHandler alloc] initWith:self.engine platformView:self];
      
      
    __weak __typeof(self) weakSelf = self;
    [self.methodChannel setMethodCallHandler:^(FlutterMethodCall *_Nonnull call,
                                               FlutterResult _Nonnull result) {
      if (weakSelf != nil) {
        [weakSelf onMethodCall:call result:result];
      }
    }];
    for (NSString *key in args) {
      [self onMethodCall:[FlutterMethodCall
                             methodCallWithMethodName:key
                                            arguments:[args objectForKey:key]]
                  result:nil];
    }
  }
  return self;
}

- (void)dealloc {
  [self.methodChannel setMethodCallHandler:nil];
}

- (nonnull UIView *)view {
  return self.surfaceView;
}

- (void)onMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    [[self callApiMethodCallHandler] onMethodCall:call _:result];
}

@end

@interface AgoraSurfaceViewFactory ()

@property(nonatomic, strong) NSObject<FlutterBinaryMessenger> *messenger;

@property(nonatomic) agora::iris::rtc::IrisRtcEngine *engine;

@end

@implementation AgoraSurfaceViewFactory

- (instancetype)initWith:(NSObject<FlutterBinaryMessenger> *)messenger
                  engine:(void *)engine {
  if (self = [super init]) {
    self.messenger = messenger;
    self.engine = (agora::iris::rtc::IrisRtcEngine *)engine;
  }
  return self;
}

- (nonnull NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame
                                            viewIdentifier:(int64_t)viewId
                                                 arguments:(id _Nullable)args {
  return [[AgoraSurfaceView alloc] initWith:self.messenger
                                     engine:self.engine
                                      frame:frame
                                     viewId:viewId
                                       args:args];
}

- (NSObject<FlutterMessageCodec> *)createArgsCodec {
  return [FlutterStandardMessageCodec sharedInstance];
}

@end
