#import "AgoraSurfaceViewFactory.h"

@interface AgoraSurfaceView : NSObject <FlutterPlatformView>

@property(nonatomic, strong) VideoViewController *controller;

@property(nonatomic, strong) UIView *surfaceView;

@property(nonatomic, strong) FlutterMethodChannel *methodChannel;

@property(nonatomic) NSString *viewType;

@property(nonatomic) int64_t platformViewId;

- (instancetype)initWith:(NSObject<FlutterBinaryMessenger> *)messenger
              controller:(VideoViewController *)controller
                   frame:(CGRect)frame
                  viewId:(int64_t)viewId
                    args:(NSDictionary *)args;

@end

@implementation AgoraSurfaceView

- (instancetype)initWith:(NSObject<FlutterBinaryMessenger> *)messenger
              controller:(VideoViewController *)controller
                   frame:(CGRect)frame
                  viewId:(int64_t)viewId
                    args:(NSDictionary *)args {
  if (self = [super init]) {
    self.controller = controller;
    self.viewType = [args objectForKey:@"viewType"];
    self.surfaceView = (UIView *)[self.controller createPlatformRender:viewId frame:frame];
    self.platformViewId = viewId;
    self.methodChannel = [FlutterMethodChannel
        methodChannelWithName:
            [NSString
                stringWithFormat:@"agora_rtc_ng/AgoraSurfaceView_%lld",
              viewId]
              binaryMessenger:messenger];
    
    __weak typeof(self) weakSelf = self;
    [self.methodChannel setMethodCallHandler:^(FlutterMethodCall *_Nonnull call,
                                               FlutterResult _Nonnull result) {
      if (weakSelf != nil) {
        [weakSelf onMethodCall:call result:result];
      }
    }];
//    for (NSString *key in args) {
//        if ([@"viewType" isEqualToString:key]) {
//            continue;;
//        }
//      [self onMethodCall:[FlutterMethodCall
//                             methodCallWithMethodName:key
//                                            arguments:[args objectForKey:key]]
//                  result:nil];
//    }
  }
  return self;
}

- (void)dealloc {
    [self.controller dePlatformRenderRef:self.platformViewId];
    self.surfaceView = NULL;
}

- (nonnull UIView *)view {
  return self.surfaceView;
}

- (void)onMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
  if ([@"getNativeViewPtr" isEqualToString:call.method]) {
      if (self.surfaceView) {
          // Add ref to ensure the `self.surfaceView` not be released by ARC, which will be
          // de-ref by the `VideoViewController.dePlatformRenderRef`.
          [self.controller addPlatformRenderRef:self.platformViewId];
          uint64_t viewId = (uint64_t)self.surfaceView;
          result(@(viewId));
      } else {
          result(@(0));
      }
      

  } else if ([@"deleteNativeViewPtr" isEqualToString:call.method]) {
      // Do nothing
      result(@(0));
  }
}

@end

@interface AgoraSurfaceViewFactory ()

@property(nonatomic, strong) NSObject<FlutterBinaryMessenger> *messenger;
@property(nonatomic, strong) VideoViewController *controller;

@end

@implementation AgoraSurfaceViewFactory

- (instancetype)initWith:(NSObject<FlutterBinaryMessenger> *)messenger
              controller:(VideoViewController *)controller {
  if (self = [super init]) {
    self.messenger = messenger;
    self.controller = controller;
  }
  return self;
}

- (nonnull NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame
                                            viewIdentifier:(int64_t)viewId
                                                 arguments:(id _Nullable)args {
  return [[AgoraSurfaceView alloc] initWith:self.messenger
                                 controller:self.controller
                                      frame:frame
                                     viewId:viewId
                                       args:args];
}

- (NSObject<FlutterMessageCodec> *)createArgsCodec {
  return [FlutterStandardMessageCodec sharedInstance];
}

@end
