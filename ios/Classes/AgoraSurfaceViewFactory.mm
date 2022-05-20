#import "AgoraSurfaceViewFactory.h"
#import <AgoraRtcWrapper/iris_rtc_engine.h>
#import "CallApiMethodCallHandler.h"

@interface AgoraSurfaceView : NSObject <FlutterPlatformView>

@property(nonatomic, strong) UIView *parentView;

@property(nonatomic, strong) UIView *surfaceView;

@property(nonatomic, strong) FlutterMethodChannel *methodChannel;

@property(nonatomic) agora::iris::rtc::IrisRtcEngine *engine;

@property(nonatomic) CallApiMethodCallHandler *callApiMethodCallHandler;

- (instancetype)initWith:(NSObject<FlutterBinaryMessenger> *)messenger
                  engine:(agora::iris::rtc::IrisRtcEngine *)engine
                   frame:(CGRect)frame
                  viewId:(int64_t)viewId
                    args:(NSDictionary *)args;

- (UIView *)getIrisRenderView;

- (void)updateIrisRenderView;

- (NSString *)observerForKeyPath;

@end

@interface SurfaceViewCallApiMethodCallHandler : CallApiMethodCallHandler
@property(nonatomic) agora::iris::rtc::IrisRtcEngine *irisRtcEngine;
@property(nonatomic) AgoraSurfaceView *platformView;
- (instancetype)initWith:(agora::iris::rtc::IrisRtcEngine *)irisRtcEngine platformView:(AgoraSurfaceView*) platformView;
@end

@implementation SurfaceViewCallApiMethodCallHandler

- (instancetype)initWith:(agora::iris::rtc::IrisRtcEngine *)irisRtcEngine platformView:(AgoraSurfaceView *) platformView {
    self.irisRtcEngine = irisRtcEngine;
    self.platformView = platformView;
    return self;
}

- (int)callApi:(NSNumber *)apiType _:(NSString *)params _:(char *)result {
    [self.platformView updateIrisRenderView];
    return self.irisRtcEngine->CallApi((ApiTypeEngine)[apiType unsignedIntValue], [params UTF8String], (__bridge void *)[self.platformView getIrisRenderView], result);
}

- (int)callApiWithBuffer:(NSNumber *)apiType _:(NSString *)params _:(void *)buffer _:(char *)result {
    [self.platformView updateIrisRenderView];
    return self.irisRtcEngine->CallApi((ApiTypeEngine)[apiType unsignedIntValue], [params UTF8String], (__bridge void *)[self.platformView getIrisRenderView], result);
}

@end



@implementation AgoraSurfaceView

- (instancetype)initWith:(NSObject<FlutterBinaryMessenger> *)messenger
                  engine:(agora::iris::rtc::IrisRtcEngine *)engine
                   frame:(CGRect)frame
                  viewId:(int64_t)viewId
                    args:(NSDictionary *)args {
  if (self = [super init]) {
    self.parentView = [[UIView alloc] initWithFrame:frame];
    CGRect cgRect = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.surfaceView = [[UIView alloc] initWithFrame: cgRect];
    [[self parentView] addSubview:self.surfaceView];
      
      [self.parentView addObserver:self forKeyPath:[self observerForKeyPath] options:NSKeyValueObservingOptionNew context:nil];
      
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
                  result:^(id _Nullable result) {
          // Do nothing
      }];
    }
  }
  return self;
}

- (void)dealloc {
  [self removeObserver:self.parentView forKeyPath:[self observerForKeyPath] context:nil];
}

- (UIView *)getIrisRenderView {
    return self.surfaceView;
}

- (void)updateIrisRenderView {
    [[self surfaceView] removeFromSuperview];
    
    CGRect cgRect = CGRectMake(0, 0, self.parentView.bounds.size.width, self.parentView.bounds.size.height);
    
    self.surfaceView = [[UIView alloc] initWithFrame: cgRect];
    
    [[self parentView] addSubview:self.surfaceView];
}

- (NSString *)observerForKeyPath {
    return @"frame";
}

- (nonnull UIView *)view {
  return self.parentView;
}

- (void)onMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    [[self callApiMethodCallHandler] onMethodCall:call _:result];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if([keyPath isEqualToString:[self observerForKeyPath]]) {
        id newKey = change[NSKeyValueChangeNewKey];
        if (newKey != NULL) {
            CGRect rect = [newKey CGRectValue];
            CGRect cgRect;
            CGPoint cgPoint;
            cgPoint.x = 0;
            cgPoint.y = 0;
            
            cgRect.origin = cgPoint;
            cgRect.size = rect.size;
            [[self surfaceView] setFrame:cgRect];
        }
    }
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
