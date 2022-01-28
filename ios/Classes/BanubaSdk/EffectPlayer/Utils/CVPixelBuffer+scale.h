#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreVideo/CoreVideo.h>

NS_ASSUME_NONNULL_BEGIN

CV_RETURNS_RETAINED_PARAMETER CVPixelBufferRef CV_NULLABLE BNBCVPixelBufferCreateScaled(
    CVPixelBufferRef pixelBuffer,
    CGSize scaleSize);

NS_ASSUME_NONNULL_END
