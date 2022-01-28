#import "CVPixelBuffer+scale.h"
#import <CoreImage/CoreImage.h>

CV_RETURNS_RETAINED_PARAMETER CVPixelBufferRef CV_NULLABLE BNBCVPixelBufferCreateScaled(
    CVPixelBufferRef pixelBuffer,
    CGSize scaleSize)
{
    CIContext* context = [CIContext context];

    CIImage* image = [CIImage imageWithCVImageBuffer:pixelBuffer];

    CGFloat scaleX = scaleSize.width / CGRectGetWidth(image.extent);
    CGFloat scaleY = scaleSize.height / CGRectGetHeight(image.extent);

    image = [image
        imageByApplyingTransform:CGAffineTransformMakeScale(scaleX, scaleY)];

    image = [image
        imageByApplyingTransform:CGAffineTransformMakeTranslation(
                                     -image.extent.origin.x,
                                     -image.extent.origin.y)];

    CVPixelBufferRef output = NULL;

    CVPixelBufferCreate(
        nil,
        CGRectGetWidth(image.extent),
        CGRectGetHeight(image.extent),
        CVPixelBufferGetPixelFormatType(pixelBuffer),
        nil,
        &output);

    if (output != NULL) {
        [context render:image toCVPixelBuffer:output];
    }

    return output;
}
