#ifndef VideoViewController_h
#define VideoViewController_h

#if TARGET_OS_IPHONE
#import <Flutter/Flutter.h>
#else
#import <FlutterMacOS/FlutterMacOS.h>
#endif

@interface VideoViewController : NSObject

- (instancetype)initWith:(NSObject<FlutterTextureRegistry> *)textureRegistry
               messenger: (NSObject<FlutterBinaryMessenger> *)messenger;

- (id)createPlatformRender:(int64_t)platformViewId frame:(CGRect)frame;

- (BOOL)destroyPlatformRender:(int64_t)platformViewId;

- (BOOL)addPlatformRenderRef:(int64_t)platformViewId;

- (BOOL)dePlatformRenderRef:(int64_t)platformViewId;

- (int64_t)createTextureRender:(intptr_t)irisRtcRenderingHandle
                           uid:(NSNumber *)uid
                     channelId:(NSString *)channelId
               videoSourceType:(NSNumber *)videoSourceType
            videoViewSetupMode:(NSNumber *)videoViewSetupMode;

- (BOOL)destroyTextureRender:(int64_t)textureId;

@end


#endif /* VideoViewController_h */
