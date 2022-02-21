#ifndef AgoraTextureViewFactory_h
#define AgoraTextureViewFactory_h

#import <Flutter/Flutter.h>

@interface AgoraTextureViewFactory : NSObject
- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar;

- (int64_t)createTextureRenderer:(void *)renderer;

- (BOOL)destroyTextureRenderer:(int64_t)textureId;
@end

#endif /* AgoraTextureViewFactory_h */
