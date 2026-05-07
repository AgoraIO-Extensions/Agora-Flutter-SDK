#import "AgoraTextureRenderPixelBufferConverter.h"

#import <CoreImage/CoreImage.h>

@implementation AgoraTextureRenderPixelBufferConverter {
  CVPixelBufferPoolRef _bgraPixelBufferPool;
  size_t _bgraPixelBufferWidth;
  size_t _bgraPixelBufferHeight;
}

+ (CIContext *)sharedConversionContext {
  static CIContext *context = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    context = [CIContext contextWithOptions:nil];
  });
  return context;
}

+ (CGColorSpaceRef)sharedRGBColorSpace {
  static CGColorSpaceRef colorSpace = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    colorSpace = CGColorSpaceCreateDeviceRGB();
  });
  return colorSpace;
}

+ (CVPixelBufferPoolRef)createBGRAPixelBufferPoolWithWidth:(size_t)width
                                                    height:(size_t)height {
  NSDictionary *attributes = @{
    (id)kCVPixelBufferIOSurfacePropertiesKey : @{},
    (id)kCVPixelBufferOpenGLESCompatibilityKey : @YES,
    (id)kCVPixelBufferCGImageCompatibilityKey : @YES,
    (id)kCVPixelBufferCGBitmapContextCompatibilityKey : @YES,
    (id)kCVPixelBufferMetalCompatibilityKey : @YES,
    (id)kCVPixelBufferPixelFormatTypeKey : @(kCVPixelFormatType_32BGRA),
    (id)kCVPixelBufferWidthKey : @(width),
    (id)kCVPixelBufferHeightKey : @(height)
  };

  CVPixelBufferPoolRef pool = nil;
  CVReturn status =
      CVPixelBufferPoolCreate(nil, nil, (__bridge CFDictionaryRef)attributes,
                              &pool);
  if (status != kCVReturnSuccess) {
    return nil;
  }
  return pool;
}

- (void)dealloc {
  if (_bgraPixelBufferPool) {
    CVPixelBufferPoolRelease(_bgraPixelBufferPool);
    _bgraPixelBufferPool = nil;
  }
}

- (CVPixelBufferRef _Nullable)copyPixelBufferForFlutter:
    (CVPixelBufferRef _Nonnull)sourcePixelBuffer {
  if (!sourcePixelBuffer) {
    return nil;
  }

  OSType sourceFormat = CVPixelBufferGetPixelFormatType(sourcePixelBuffer);
  if (sourceFormat != kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange &&
      sourceFormat != kCVPixelFormatType_420YpCbCr8BiPlanarFullRange) {
    return CVPixelBufferRetain(sourcePixelBuffer);
  }

  size_t width = CVPixelBufferGetWidth(sourcePixelBuffer);
  size_t height = CVPixelBufferGetHeight(sourcePixelBuffer);
  if (!_bgraPixelBufferPool || _bgraPixelBufferWidth != width ||
      _bgraPixelBufferHeight != height) {
    if (_bgraPixelBufferPool) {
      CVPixelBufferPoolRelease(_bgraPixelBufferPool);
      _bgraPixelBufferPool = nil;
    }
    _bgraPixelBufferPool =
        [AgoraTextureRenderPixelBufferConverter
            createBGRAPixelBufferPoolWithWidth:width
                                        height:height];
    _bgraPixelBufferWidth = width;
    _bgraPixelBufferHeight = height;
  }

  if (!_bgraPixelBufferPool) {
    return CVPixelBufferRetain(sourcePixelBuffer);
  }

  CVPixelBufferRef destPixelBuffer = nil;
  CVReturn status = CVPixelBufferPoolCreatePixelBuffer(
      kCFAllocatorDefault, _bgraPixelBufferPool, &destPixelBuffer);
  if (status != kCVReturnSuccess || !destPixelBuffer) {
    return CVPixelBufferRetain(sourcePixelBuffer);
  }

  CIImage *image = [CIImage imageWithCVPixelBuffer:sourcePixelBuffer];
  if (!image) {
    CVPixelBufferRelease(destPixelBuffer);
    return CVPixelBufferRetain(sourcePixelBuffer);
  }

  CGRect bounds = CGRectMake(0, 0, width, height);
  [[AgoraTextureRenderPixelBufferConverter sharedConversionContext]
      render:image
                         toCVPixelBuffer:destPixelBuffer
                                  bounds:bounds
                              colorSpace:[AgoraTextureRenderPixelBufferConverter
                                             sharedRGBColorSpace]];
  return destPixelBuffer;
}

@end
