#import <AVFoundation/AVFoundation.h>

@interface AgoraTextureRenderPixelBufferConverter : NSObject

- (CVPixelBufferRef _Nullable)copyPixelBufferForFlutter:
    (CVPixelBufferRef _Nonnull)sourcePixelBuffer;

@end
