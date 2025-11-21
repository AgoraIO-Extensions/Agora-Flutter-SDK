#import <Foundation/Foundation.h>
#import "VideoViewController.h"
#import "TextureRenderer.h"
#import <AgoraRtcWrapper/iris_engine_base.h>
#import <AgoraRtcWrapper/iris_rtc_rendering_cxx.h>

// Define WriteIrisLogInternal to handle varargs formatting
void WriteIrisLogInternal(IrisLogLevel level, const char* format, ...) {
    va_list args;
    va_start(args, format);
    NSString *formatStr = [NSString stringWithUTF8String:format];
    NSString *logMsg = [[NSString alloc] initWithFormat:formatStr arguments:args];
    WriteIrisLog(level, [logMsg UTF8String]);
    va_end(args);
}

/// A simple implemetation of ref count for an object, which just hold the value reference and record the ref count.
@interface SimpleRef : NSObject

@property(nonatomic, strong) id value;
@property(nonatomic) int refCount;

- (instancetype)initWith:(id) value;

/// Increase the ref count.
- (void) addRef;

/// Decrease the ref count.
- (void) deRef;

/// Force clean the value reference, and set the ref count to 0.
- (void) releaseRef;

@end

@implementation SimpleRef

- (instancetype)initWith:(id) value {
    self = [super init];
    if (self) {
        self.value = value;
        self.refCount = 1;
    }
    return self;
}

- (void) addRef {
    ++self.refCount;
}

- (void) deRef {
    --self.refCount;
}

- (void) releaseRef {
    self.value = NULL;
    self.refCount = 0;
}

@end

/// A pool to manage the native views that to be used in the Flutter PlatformView. You can change the native views's lifecycle through
/// the `addViewRef`/`deViewRef`.
@interface PlatformRenderPool : NSObject

@property(nonatomic) NSMutableDictionary<NSNumber *, SimpleRef *> *renders;
- (instancetype)init;
- (id)createView:(int64_t)platformViewId frame:(CGRect)frame;
- (BOOL)addViewRef:(int64_t)platformViewId;
- (BOOL)deViewRef:(int64_t)platformViewId;

@end

@implementation PlatformRenderPool

- (instancetype)init {
    self = [super init];
    if (self) {
        self.renders = [NSMutableDictionary new];
    }
    return self;
}

- (id)createView:(int64_t)platformViewId frame:(CGRect)frame {
#if TARGET_OS_IPHONE
    UIView *v = [[UIView alloc] initWithFrame:frame];
    SimpleRef * ref = [[SimpleRef alloc] initWith:v];
    
    self.renders[@(platformViewId)] = ref;
    
    return v;
#endif
    
    // Not supported on macOS
    NSAssert(false, @"NOT SUPPORTED");
    return NULL;
}

- (BOOL)destroyView:(int64_t)viewId {
    if ([self.renders objectForKey:@(viewId)]) {
        [self.renders removeObjectForKey:@(viewId)];
        
        return true;
    }
    
    return false;
}

- (BOOL)addViewRef:(int64_t)platformViewId {
    if ([self.renders objectForKey:@(platformViewId)]) {
        SimpleRef * ref = self.renders[@(platformViewId)];
        [ref addRef];
        
        return true;
    }
    
    return false;
}

- (BOOL)deViewRef:(int64_t)platformViewId {
    if ([self.renders objectForKey:@(platformViewId)]) {
        SimpleRef * ref = self.renders[@(platformViewId)];
        [ref deRef];
        
        if ([ref refCount] <= 0) {
            [ref releaseRef];
            [self.renders removeObjectForKey:@(platformViewId)];
        }
        
        return true;
    }
    
    return false;
}

@end

@interface VideoViewController ()
@property(nonatomic, weak) NSObject<FlutterTextureRegistry> *textureRegistry;
@property(nonatomic, weak) NSObject<FlutterBinaryMessenger> *messenger;
@property(nonatomic) NSMutableDictionary<NSNumber *, TextureRender *> *textureRenders;
@property(nonatomic) PlatformRenderPool* platformRenderPool;

@property(nonatomic, strong) FlutterMethodChannel *methodChannel;
@end

@implementation VideoViewController

- (instancetype)initWith:(NSObject<FlutterTextureRegistry> *)textureRegistry
               messenger: (NSObject<FlutterBinaryMessenger> *)messenger {
    self = [super init];
    if (self) {
      WriteIrisLogInternal(IrisLogLevel::levelInfo, "VideoViewController init method called");
      self.textureRegistry = textureRegistry;
      self.messenger = messenger;
      self.textureRenders = [NSMutableDictionary new];
      self.platformRenderPool = [PlatformRenderPool new];
        
      self.methodChannel = [FlutterMethodChannel
            methodChannelWithName:
                                  @"agora_rtc_ng/video_view_controller"
                  binaryMessenger:messenger];
        
      __weak typeof(self) weakSelf = self;
      [self.methodChannel setMethodCallHandler:^(FlutterMethodCall *_Nonnull call,
                                                   FlutterResult _Nonnull result) {
        if (weakSelf != nil) {
          [weakSelf onMethodCall:call result:result];
        }
      }];
    }
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
      WriteIrisLogInternal(IrisLogLevel::levelInfo, "VideoViewController onMethodCall method called");
  if ([@"createTextureRender" isEqualToString:call.method]) {
    WriteIrisLogInternal(IrisLogLevel::levelInfo, "VideoViewController createTextureRender method called with arguments: %s", [call.arguments description].UTF8String);
      NSDictionary *data = call.arguments;
      NSNumber *irisRtcRenderingHandle = data[@"irisRtcRenderingHandle"];
      NSNumber *uid = data[@"uid"];
      NSString *channelId = data[@"channelId"];
      NSNumber *videoSourceType = data[@"videoSourceType"];
      NSNumber *videoViewSetupMode = data[@"videoViewSetupMode"];

      int64_t textureId = [self createTextureRender:(intptr_t)[irisRtcRenderingHandle longLongValue]
                                                uid:uid
                                          channelId:channelId
                                    videoSourceType:videoSourceType
                                 videoViewSetupMode:videoViewSetupMode];
      WriteIrisLogInternal(IrisLogLevel::levelInfo, "VideoViewController createTextureRender method returned textureId: %lld", textureId);
      result(@(textureId));
  } else if ([@"destroyTextureRender" isEqualToString:call.method]) {
      NSNumber *textureIdValue = call.arguments;
      WriteIrisLogInternal(IrisLogLevel::levelInfo, "VideoViewController destroyTextureRender method called with arguments: %s", [textureIdValue description].UTF8String);
      BOOL success = [self destroyTextureRender: [textureIdValue longLongValue]];
      WriteIrisLogInternal(IrisLogLevel::levelInfo, "VideoViewController destroyTextureRender method returned success: %d", success);
      result(@(success));
  } else if ([@"addPlatformRenderRef" isEqualToString:call.method]) {
      NSNumber *platformViewIdValue = call.arguments;
      int64_t platformViewId = [platformViewIdValue longLongValue];
      WriteIrisLogInternal(IrisLogLevel::levelInfo, "VideoViewController addPlatformRenderRef method called with arguments: %lld", platformViewId);
      [self addPlatformRenderRef:platformViewId];
      result(@(YES));
  } else if ([@"dePlatfromViewRef" isEqualToString:call.method]) {
      NSNumber *platformViewIdValue = call.arguments;
      int64_t platformViewId = [platformViewIdValue longLongValue];
      WriteIrisLogInternal(IrisLogLevel::levelInfo, "VideoViewController dePlatfromViewRef method called with arguments: %lld", platformViewId);
      [self dePlatformRenderRef:platformViewId];
      
      result(@(YES));
  } else if ([@"dispose" isEqualToString:call.method]) {
      WriteIrisLogInternal(IrisLogLevel::levelInfo, "VideoViewController dispose method called");
      [self dispose];
      result(@(YES));
  }
}

- (id)createPlatformRender:(int64_t)platformViewId frame:(CGRect)frame {
    WriteIrisLogInternal(IrisLogLevel::levelInfo, "VideoViewController createPlatformRender method called with arguments: %lld %s", platformViewId, NSStringFromCGRect(frame).UTF8String);
    return [self.platformRenderPool createView:platformViewId frame:frame];
}

- (BOOL)destroyPlatformRender:(int64_t)platformViewId {
    WriteIrisLogInternal(IrisLogLevel::levelInfo, "VideoViewController destroyPlatformRender method called with arguments: %lld", platformViewId);
    return [self.platformRenderPool deViewRef:platformViewId];
}

- (BOOL)addPlatformRenderRef:(int64_t)platformViewId {
    WriteIrisLogInternal(IrisLogLevel::levelInfo, "VideoViewController addPlatformRenderRef method called with arguments: %lld", platformViewId);
    return [self.platformRenderPool addViewRef:platformViewId];
}

- (BOOL)dePlatformRenderRef:(int64_t)platformViewId {
    WriteIrisLogInternal(IrisLogLevel::levelInfo, "VideoViewController dePlatformRenderRef method called with arguments: %lld", platformViewId);
    return [self.platformRenderPool deViewRef:platformViewId];
}

- (int64_t)createTextureRender:(intptr_t)irisRtcRenderingHandle
                           uid:(NSNumber *)uid
                     channelId:(NSString *)channelId
               videoSourceType:(NSNumber *)videoSourceType
            videoViewSetupMode:(NSNumber *)videoViewSetupMode {
    agora::iris::IrisRtcRendering *irisRtcRendering = reinterpret_cast<agora::iris::IrisRtcRendering *>(irisRtcRenderingHandle);
    TextureRender *textureRender = [[TextureRender alloc]
        initWithTextureRegistry:self.textureRegistry
                      messenger:self.messenger
         irisRtcRenderingHandle:irisRtcRendering];
    int64_t textureId = [textureRender textureId];
    [textureRender updateData:uid channelId:channelId videoSourceType:videoSourceType videoViewSetupMode:videoViewSetupMode];
    self.textureRenders[@(textureId)] = textureRender;
    WriteIrisLogInternal(IrisLogLevel::levelInfo, "VideoViewController createTextureRender method returned textureId: %lld", textureId);
    return textureId;
}

- (BOOL)destroyTextureRender:(int64_t)textureId {
    WriteIrisLogInternal(IrisLogLevel::levelInfo, "VideoViewController destroyTextureRender method called with arguments: %lld", textureId);
    TextureRender *textureRender = [self.textureRenders objectForKey:@(textureId)];
    if (textureRender != nil) {
      [textureRender dispose];
      [self.textureRenders removeObjectForKey:@(textureId)];
      WriteIrisLogInternal(IrisLogLevel::levelInfo, "VideoViewController destroyTextureRender method returned success: %d", YES);
      return YES;
    }
    WriteIrisLogInternal(IrisLogLevel::levelInfo, "VideoViewController destroyTextureRender method returned success: %d", NO);
    return NO;
}

- (void)dispose {
    WriteIrisLogInternal(IrisLogLevel::levelInfo, "VideoViewController dispose method called");
    for (TextureRender * textureRender in self.textureRenders.allValues) {
        [textureRender dispose];
        WriteIrisLogInternal(IrisLogLevel::levelInfo, "VideoViewController dispose method called with textureRender: %p", textureRender);
    }
    [self.textureRenders removeAllObjects];
    WriteIrisLogInternal(IrisLogLevel::levelInfo, "VideoViewController dispose method returned");
}

// - (void)dealloc {
//   // do not do this, coz TextureRender::TextureRender will call
//   // [textureRegistry unregisterTexture] which may already been dealloced by
//   // flutter and will bring crash
//   // [self dispose];
// }

@end
