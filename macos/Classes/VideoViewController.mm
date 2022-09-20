#import <Foundation/Foundation.h>
#import "VideoViewController.h"
#import "TextureRenderer.h"
#import <AgoraRtcWrapper/iris_engine_base.h>
#import <AgoraRtcWrapper/iris_video_processor_cxx.h>

@interface VideoViewController ()
@property(nonatomic, weak) NSObject<FlutterTextureRegistry> *textureRegistry;
@property(nonatomic, weak) NSObject<FlutterBinaryMessenger> *messenger;
@property(nonatomic) NSMutableDictionary<NSNumber *, TextureRender *> *textureRenders;
@property(nonatomic) agora::iris::IrisVideoFrameBufferManager *videoFrameBufferManager;
//@property(nonatomic) intptr_t irisRtcEnginePtr;
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
//        self.irisRtcEnginePtr = 0;
        self.videoFrameBufferManager = new agora::iris::IrisVideoFrameBufferManager;
        
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
  if ([@"attachVideoFrameBufferManager" isEqualToString:call.method]) {
      NSNumber *enginePtrValue = call.arguments;
//      if (self.irisRtcEnginePtr != 0) {
//          result(@(YES));
//          return;
//      }
      intptr_t irisRtcEnginePtr = (intptr_t)[enginePtrValue longLongValue];
      IApiEngineBase *irisApiEngine = reinterpret_cast<IApiEngineBase *>(irisRtcEnginePtr);
//      agora::iris::rtc::IrisRtcRawData *rawData = engine->raw_data();
      irisApiEngine->Attach(self.videoFrameBufferManager);
      
      result(@((intptr_t)self.videoFrameBufferManager));
  } else if ([@"detachVideoFrameBufferManager" isEqualToString:call.method]) {
      NSNumber *enginePtrValue = call.arguments;
//      if (self.irisRtcEnginePtr == 0) {
//          result(@(NO));
//          return;
//      }
      intptr_t irisRtcEnginePtr = (intptr_t)[enginePtrValue longLongValue];
      IApiEngineBase *irisApiEngine = reinterpret_cast<IApiEngineBase *>(irisRtcEnginePtr);
//      agora::iris::rtc::IrisRtcRawData *rawData = engine->raw_data();
      irisApiEngine->Detach(self.videoFrameBufferManager);
      
      result(@(YES));
  }
  else if ([@"createTextureRender" isEqualToString:call.method]) {
      NSDictionary *data = call.arguments;
      NSNumber *uid = data[@"uid"];
      NSString *channelId = data[@"channelId"];
      NSNumber *videoSourceType = data[@"videoSourceType"];

      int64_t textureId = [self createTextureRender:uid channelId:channelId  videoSourceType:videoSourceType];
      result(@(textureId));
  } else if ([@"destroyTextureRender" isEqualToString:call.method]) {
      NSNumber *textureIdValue = call.arguments;
      BOOL success = [self destroyTextureRender: [textureIdValue longLongValue]];
      result(@(success));
  } else if ([@"updateTextureRenderData" isEqualToString:call.method]) {
      NSDictionary *data = call.arguments;
      int64_t textureId = [data[@"uid"] longLongValue];
      NSNumber *uid = data[@"uid"];
      NSString *channelId = data[@"channelId"];
      NSNumber *videoSourceType = data[@"videoSourceType"];
      
      [self updateTextureRenderData:textureId uid:uid channelId:channelId  videoSourceType:videoSourceType];
      result(@(YES));
  }
}

- (int64_t)createPlatformRender {
    return 0;
}

- (BOOL)destroyPlatformRender:(int64_t)platformRenderId {
    return true;
}

- (int64_t)createTextureRender:(NSNumber *)uid channelId:(NSString *)channelId videoSourceType:(NSNumber *)videoSourceType {
    TextureRender *textureRender = [[TextureRender alloc]
        initWithTextureRegistry:self.textureRegistry
                      messenger:self.messenger
                       videoFrameBufferManager:self.videoFrameBufferManager];
    int64_t textureId = [textureRender textureId];
    [textureRender updateData:uid channelId:channelId videoSourceType:videoSourceType];
    self.textureRenders[@(textureId)] = textureRender;
    return textureId;
}

- (void)updateTextureRenderData:(int64_t)textureId uid:(NSNumber *)uid channelId:(NSString *)channelId videoSourceType:(NSNumber *)videoSourceType {
    [self.textureRenders[@(textureId)] updateData:uid channelId:channelId videoSourceType:videoSourceType];
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

- (void)dealloc {
    if (self.videoFrameBufferManager) {
        delete self.videoFrameBufferManager;
        self.videoFrameBufferManager = nil;
    }
}

@end
