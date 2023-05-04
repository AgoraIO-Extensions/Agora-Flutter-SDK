#import <Foundation/Foundation.h>
#import "VideoViewController.h"
#import "TextureRenderer.h"
#import <AgoraRtcWrapper/iris_engine_base.h>
#import <AgoraRtcWrapper/iris_rtc_rendering_cxx.h>

@interface VideoViewController ()
@property(nonatomic, weak) NSObject<FlutterTextureRegistry> *textureRegistry;
@property(nonatomic, weak) NSObject<FlutterBinaryMessenger> *messenger;
@property(nonatomic) NSMutableDictionary<NSNumber *, TextureRender *> *textureRenders;

@property(nonatomic, strong) FlutterMethodChannel *methodChannel;
@end

@implementation VideoViewController

- (instancetype)initWith:(NSObject<FlutterTextureRegistry> *)textureRegistry
               messenger: (NSObject<FlutterBinaryMessenger> *)messenger {
    self = [super init];
    if (self) {
      self.textureRegistry = textureRegistry;
      self.messenger = messenger;
      self.textureRenders = [NSMutableDictionary new];
        
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
  }
}

- (int64_t)createPlatformRender {
    return 0;
}

- (BOOL)destroyPlatformRender:(int64_t)platformRenderId {
    return true;
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

@end
