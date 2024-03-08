#import <Foundation/Foundation.h>
#import "VideoViewController.h"
#import "TextureRenderer.h"
#import <AgoraRtcWrapper/iris_engine_base.h>
#import <AgoraRtcWrapper/iris_rtc_rendering_cxx.h>

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

- (void)dispose;
@end

@implementation VideoViewController

- (instancetype)initWith:(NSObject<FlutterTextureRegistry> *)textureRegistry
               messenger: (NSObject<FlutterBinaryMessenger> *)messenger {
    self = [super init];
    if (self) {
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
  if ([@"createTextureRender" isEqualToString:call.method]) {
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
      result(@(textureId));
  } else if ([@"destroyTextureRender" isEqualToString:call.method]) {
      NSNumber *textureIdValue = call.arguments;
      BOOL success = [self destroyTextureRender: [textureIdValue longLongValue]];
      result(@(success));
  } else if ([@"dePlatfromViewRef" isEqualToString:call.method]) {
      NSNumber *platformViewIdValue = call.arguments;
      int64_t platformViewId = [platformViewIdValue longLongValue];
      [self dePlatformRenderRef:platformViewId];
      
      result(@(YES));
  } else if ([@"dispose" isEqualToString:call.method]) {
      [self dispose];
      result(@(YES));
  }
}

- (id)createPlatformRender:(int64_t)platformViewId frame:(CGRect)frame {
    return [self.platformRenderPool createView:platformViewId frame:frame];
}

- (BOOL)destroyPlatformRender:(int64_t)platformViewId {
    return [self.platformRenderPool deViewRef:platformViewId];
}

- (BOOL)addPlatformRenderRef:(int64_t)platformViewId {
    return [self.platformRenderPool addViewRef:platformViewId];
}

- (BOOL)dePlatformRenderRef:(int64_t)platformViewId {
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
    return textureId;
}

- (BOOL)destroyTextureRender:(int64_t)textureId {
    TextureRender *textureRender = [self.textureRenders objectForKey:@(textureId)];
    if (textureRender != nil) {
      [textureRender dispose];
      [self.textureRenders removeObjectForKey:@(textureId)];
      return YES;
    }
    return NO;
}

- (void)dispose {
    for (TextureRender * textureRender in self.textureRenders.allValues) {
        [textureRender dispose];
    }
    [self.textureRenders removeAllObjects];
}

@end
