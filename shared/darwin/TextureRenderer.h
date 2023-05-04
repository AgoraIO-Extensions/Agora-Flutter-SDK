#ifndef TextureRenderer_h
#define TextureRenderer_h

#if TARGET_OS_IPHONE
#import <Flutter/Flutter.h>
#else
#import <FlutterMacOS/FlutterMacOS.h>
#endif

@interface TextureRender : NSObject <FlutterTexture>

- (instancetype)
initWithTextureRegistry:(NSObject<FlutterTextureRegistry> *)textureRegistry
                  messenger:(NSObject<FlutterBinaryMessenger> *)messenger
irisRtcRenderingHandle:(void *)irisRtcRenderingHandle;

- (void)updateData:(NSNumber *)uid channelId:(NSString *)channelId videoSourceType:(NSNumber *)videoSourceType videoViewSetupMode:(NSNumber *)videoViewSetupMode;

- (void)dispose;

@property(nonatomic, assign) int64_t textureId;

@end


#endif /* TextureRenderer_h */
