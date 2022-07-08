#ifndef TextureRenderer_h
#define TextureRenderer_h

#import <Flutter/Flutter.h>

@interface TextureRender : NSObject <FlutterTexture>

- (instancetype)
initWithTextureRegistry:(NSObject<FlutterTextureRegistry> *)textureRegistry
                  messenger:(NSObject<FlutterBinaryMessenger> *)messenger
    videoFrameBufferManager:(void *)manager;

- (void)updateData:(NSNumber *)uid channelId:(NSString *)channelId videoSourceType:(NSNumber *)videoSourceType;

- (void)dispose;

@property(nonatomic, assign) int64_t textureId;

@end


#endif /* TextureRenderer_h */
