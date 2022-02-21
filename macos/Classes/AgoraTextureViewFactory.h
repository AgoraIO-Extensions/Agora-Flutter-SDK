#import <FlutterMacOS/FlutterMacOS.h>

@interface AgoraTextureViewFactory : NSObject
- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar;

- (int64_t)createTextureRenderer:(void *)renderer;

- (BOOL)destroyTextureRenderer:(int64_t)textureId;
@end
