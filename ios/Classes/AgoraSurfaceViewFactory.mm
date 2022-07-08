#import "AgoraSurfaceViewFactory.h"

@interface AgoraSurfaceView : NSObject <FlutterPlatformView>

@property(nonatomic, strong) UIView *surfaceView;

@property(nonatomic, strong) FlutterMethodChannel *methodChannel;

@property(nonatomic) NSString *viewType;

- (instancetype)initWith:(NSObject<FlutterBinaryMessenger> *)messenger
                   frame:(CGRect)frame
                  viewId:(int64_t)viewId
                    args:(NSDictionary *)args;

@end

@implementation AgoraSurfaceView

- (instancetype)initWith:(NSObject<FlutterBinaryMessenger> *)messenger
                   frame:(CGRect)frame
                  viewId:(int64_t)viewId
                    args:(NSDictionary *)args {
  if (self = [super init]) {
      self.viewType = [args objectForKey:@"viewType"];
    self.surfaceView = [[UIView alloc] initWithFrame:frame];
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
//  [self.methodChannel setMethodCallHandler:nil];
}

- (nonnull UIView *)view {
  return self.surfaceView;
}

- (void)onMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
  if ([@"getNativeViewPtr" isEqualToString:call.method]) {
      result(@((uint64_t)self.surfaceView));
  } else if ([@"deleteNativeViewPtr" isEqualToString:call.method]) {
      // Do nothing
  }
}

@end

@interface AgoraSurfaceViewFactory ()

@property(nonatomic, strong) NSObject<FlutterBinaryMessenger> *messenger;

@end

@implementation AgoraSurfaceViewFactory

- (instancetype)initWith:(NSObject<FlutterBinaryMessenger> *)messenger {
  if (self = [super init]) {
    self.messenger = messenger;
  }
  return self;
}

- (nonnull NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame
                                            viewIdentifier:(int64_t)viewId
                                                 arguments:(id _Nullable)args {
  return [[AgoraSurfaceView alloc] initWith:self.messenger
                                      frame:frame
                                     viewId:viewId
                                       args:args];
}

- (NSObject<FlutterMessageCodec> *)createArgsCodec {
  return [FlutterStandardMessageCodec sharedInstance];
}

@end
