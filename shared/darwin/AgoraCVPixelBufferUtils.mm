#import "AgoraCVPixelBufferUtils.h"
#include <CoreVideo/CoreVideo.h>

@implementation AgoraCVPixelBufferUtils

+ (BOOL)copyNV12CVPixelBuffer:(CVPixelBufferRef _Nonnull)sourcePixelBuffer
              destPixelBuffer:(CVPixelBufferRef _Nonnull)destPixelBuffer {
  if (!sourcePixelBuffer || !destPixelBuffer) {
    return NO;
  }

  CVReturn status = CVPixelBufferLockBaseAddress(sourcePixelBuffer,
                                                 kCVPixelBufferLock_ReadOnly);
  if (status != kCVReturnSuccess) {
    return NO;
  }

  status = CVPixelBufferLockBaseAddress(destPixelBuffer, 0);
  if (status != kCVReturnSuccess) {
    CVPixelBufferUnlockBaseAddress(sourcePixelBuffer,
                                   kCVPixelBufferLock_ReadOnly);
    return NO;
  }

  size_t sourceHeight = CVPixelBufferGetHeightOfPlane(sourcePixelBuffer, 0);

  uint8_t *srcY =
      (uint8_t *)CVPixelBufferGetBaseAddressOfPlane(sourcePixelBuffer, 0);
  uint8_t *srcUV =
      (uint8_t *)CVPixelBufferGetBaseAddressOfPlane(sourcePixelBuffer, 1);
  uint8_t *dstY =
      (uint8_t *)CVPixelBufferGetBaseAddressOfPlane(destPixelBuffer, 0);
  uint8_t *dstUV =
      (uint8_t *)CVPixelBufferGetBaseAddressOfPlane(destPixelBuffer, 1);

  size_t srcStrideY = CVPixelBufferGetBytesPerRowOfPlane(sourcePixelBuffer, 0);
  size_t srcStrideUV = CVPixelBufferGetBytesPerRowOfPlane(sourcePixelBuffer, 1);
  size_t dstStrideY = CVPixelBufferGetBytesPerRowOfPlane(destPixelBuffer, 0);
  size_t dstStrideUV = CVPixelBufferGetBytesPerRowOfPlane(destPixelBuffer, 1);

  if (srcStrideY == dstStrideY) {
    memcpy(dstY, srcY, srcStrideY * sourceHeight);
  } else {
    for (size_t row = 0; row < sourceHeight; ++row) {
      memcpy(dstY + row * dstStrideY, srcY + row * srcStrideY,
             MIN(srcStrideY, dstStrideY));
    }
  }

  if (srcStrideUV == dstStrideUV) {
    memcpy(dstUV, srcUV, srcStrideUV * sourceHeight / 2);
  } else {
    for (size_t row = 0; row < sourceHeight / 2; ++row) {
      memcpy(dstUV + row * dstStrideUV, srcUV + row * srcStrideUV,
             MIN(srcStrideUV, dstStrideUV));
    }
  }

  CVPixelBufferUnlockBaseAddress(sourcePixelBuffer,
                                 kCVPixelBufferLock_ReadOnly);
  CVPixelBufferUnlockBaseAddress(destPixelBuffer, 0);

  return YES;
}

+ (BOOL)copyRGBACVPixelBuffer:(CVPixelBufferRef _Nonnull)sourcePixelBuffer
              destPixelBuffer:(CVPixelBufferRef _Nonnull)destPixelBuffer {
  if (!sourcePixelBuffer || !destPixelBuffer) {
    return NO;
  }

  CVReturn status = CVPixelBufferLockBaseAddress(sourcePixelBuffer,
                                                 kCVPixelBufferLock_ReadOnly);
  if (status != kCVReturnSuccess) {
    return NO;
  }

  status = CVPixelBufferLockBaseAddress(destPixelBuffer, 0);
  if (status != kCVReturnSuccess) {
    CVPixelBufferUnlockBaseAddress(sourcePixelBuffer,
                                   kCVPixelBufferLock_ReadOnly);
    return NO;
  }

  size_t sourceHeight = CVPixelBufferGetHeight(sourcePixelBuffer);

  uint8_t *src = (uint8_t *)CVPixelBufferGetBaseAddress(sourcePixelBuffer);
  uint8_t *dst = (uint8_t *)CVPixelBufferGetBaseAddress(destPixelBuffer);
  size_t srcStride = CVPixelBufferGetBytesPerRow(sourcePixelBuffer);
  size_t dstStride = CVPixelBufferGetBytesPerRow(destPixelBuffer);

  if (srcStride == dstStride) {
    memcpy(dst, src, srcStride * sourceHeight);
  } else {
    for (size_t row = 0; row < sourceHeight; ++row) {
      memcpy(dst + row * dstStride, src + row * srcStride,
             MIN(srcStride, dstStride));
    }
  }

  CVPixelBufferUnlockBaseAddress(sourcePixelBuffer,
                                 kCVPixelBufferLock_ReadOnly);
  CVPixelBufferUnlockBaseAddress(destPixelBuffer, 0);

  return YES;
}

+ (CVPixelBufferRef)copyCVPixelBuffer:
    (CVPixelBufferRef _Nonnull)sourcePixelBuffer {
  if (!sourcePixelBuffer) {
    return nil;
  }

  // Get source buffer properties
  size_t sourceWidth = CVPixelBufferGetWidth(sourcePixelBuffer);
  size_t sourceHeight = CVPixelBufferGetHeight(sourcePixelBuffer);
  OSType sourceFormat = CVPixelBufferGetPixelFormatType(sourcePixelBuffer);

  // Create new buffer with Metal compatibility
  NSDictionary *pixelBufferAttributes = @{
    // This key is required to generate SKPicture with CVPixelBufferRef in
    // metal.
    (NSString *)kCVPixelBufferMetalCompatibilityKey : @YES,
  };

  CVPixelBufferRef destPixelBuffer = nil;
  CVReturn status = CVPixelBufferCreate(
      kCFAllocatorDefault, sourceWidth, sourceHeight, sourceFormat,
      (__bridge CFDictionaryRef)pixelBufferAttributes, &destPixelBuffer);
  if (status != kCVReturnSuccess || !destPixelBuffer) {
    return nil;
  }

  // Copy data based on format
  BOOL success = NO;
  if (sourceFormat == kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange ||
      sourceFormat == kCVPixelFormatType_420YpCbCr8BiPlanarFullRange) {
    success = [self copyNV12CVPixelBuffer:sourcePixelBuffer
                          destPixelBuffer:destPixelBuffer];
  } else if (sourceFormat == kCVPixelFormatType_32BGRA ||
             sourceFormat == kCVPixelFormatType_32ARGB) {
    success = [self copyRGBACVPixelBuffer:sourcePixelBuffer
                          destPixelBuffer:destPixelBuffer];
  }

  if (!success) {
    CVPixelBufferRelease(destPixelBuffer);
    return nil;
  }

  return destPixelBuffer;
}

+ (BOOL)saveCVPixelBufferToFile:(CVPixelBufferRef)pixelBuffer
                           name:(NSString *)name {
  // Validate input parameters
  if (!pixelBuffer || !name) {
    return NO;
  }

  // Get the documents directory URL
  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSURL *documentsURL =
      [[fileManager URLsForDirectory:NSDocumentDirectory
                           inDomains:NSUserDomainMask] lastObject];
  NSURL *fileURL = [documentsURL URLByAppendingPathComponent:name];

  // Create CIImage from CVPixelBuffer
  CIImage *ciImage = [CIImage imageWithCVPixelBuffer:pixelBuffer];
  if (!ciImage) {
    return NO;
  }

  // Create CIContext and CGImage
  CIContext *context = [CIContext contextWithOptions:nil];
  CGImageRef cgImage = [context createCGImage:ciImage fromRect:ciImage.extent];
  if (!cgImage) {
    return NO;
  }

  // Create PNG data
  CFMutableDataRef pngData = CFDataCreateMutable(kCFAllocatorDefault, 0);
  if (!pngData) {
    CGImageRelease(cgImage);
    return NO;
  }

  // Create image destination
  CGImageDestinationRef destination =
      CGImageDestinationCreateWithData(pngData, kUTTypePNG, 1, NULL);
  if (!destination) {
    CFRelease(pngData);
    CGImageRelease(cgImage);
    return NO;
  }

  // Add image to destination
  CGImageDestinationAddImage(destination, cgImage, nil);

  // Finalize the destination
  BOOL success = CGImageDestinationFinalize(destination);

  // Clean up resources
  CFRelease(destination);
  CGImageRelease(cgImage);

  if (!success) {
    CFRelease(pngData);
    return NO;
  }

  // Write to file
  NSData *imageData = (__bridge NSData *)pngData;
  BOOL writeSuccess = [imageData writeToURL:fileURL atomically:YES];

  // Final cleanup
  CFRelease(pngData);

  return writeSuccess;
}

@end
