#import "AgoraCVPixelBufferUtils.h"

#include <mutex>
#include <tuple>
#include <unordered_map>

#include <CoreVideo/CoreVideo.h>
#import <Foundation/Foundation.h>

#pragma mark - AgoraCVPixelBufferPool

struct AgoraCVPixelBufferPoolKey {
  OSType type;
  size_t width;
  size_t height;

  bool operator==(const AgoraCVPixelBufferPoolKey &other) const {
    return type == other.type && width == other.width && height == other.height;
  }

  bool operator<(const AgoraCVPixelBufferPoolKey &other) const {
    return std::tie(type, width, height) <
           std::tie(other.type, other.width, other.height);
  }
};

struct AgoraCVPixelBufferPoolKeyHash {
  std::size_t operator()(const AgoraCVPixelBufferPoolKey &key) const {
    return std::hash<OSType>()(key.type) ^ std::hash<size_t>()(key.width) ^
           std::hash<size_t>()(key.height);
  }
};

@interface AgoraCVPixelBufferPool : NSObject

+ (instancetype)sharedInstance;

- (CVPixelBufferRef)createPixelBuffer:(OSType)type
                                width:(size_t)width
                               height:(size_t)height;

- (void)freeAllCVPixelBufferPools;

@end

@implementation AgoraCVPixelBufferPool {
  std::mutex _mutex;
  std::unordered_map<AgoraCVPixelBufferPoolKey, CVPixelBufferPoolRef,
                     AgoraCVPixelBufferPoolKeyHash>
      _pools;
}

+ (instancetype)sharedInstance {
  static AgoraCVPixelBufferPool *instance = nil;

  // should we use this or just use a static global variable?
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[AgoraCVPixelBufferPool alloc] init];
  });

  return instance;
}

- (CVPixelBufferRef)createPixelBuffer:(OSType)type
                                width:(size_t)width
                               height:(size_t)height {
  @autoreleasepool {
    CVPixelBufferPoolRef pool = nil;
    AgoraCVPixelBufferPoolKey key = {type, width, height};

    std::lock_guard<std::mutex> lock(_mutex);
    auto it = _pools.find(key);
    if (it == _pools.end()) {
      NSMutableDictionary *attributes =
          [NSMutableDictionary dictionaryWithDictionary:@{
            (id)kCVPixelBufferIOSurfacePropertiesKey : @{},
#if (TARGET_OS_IOS)
            (id)kCVPixelBufferOpenGLESCompatibilityKey : @YES,
#elif (TARGET_OS_OSX)
            (id)kCVPixelBufferOpenGLCompatibilityKey : @YES,
#endif
            (id)kCVPixelBufferCGImageCompatibilityKey : @YES,
            (id)kCVPixelBufferCGBitmapContextCompatibilityKey : @YES,
            (id)kCVPixelBufferPixelFormatTypeKey : @(key.type),
            (id)kCVPixelBufferWidthKey : @(key.width),
            (id)kCVPixelBufferHeightKey : @(key.height)
          }];

      if (@available(macOS 10.11, *)) {
        [attributes setObject:@YES
                       forKey:(id)kCVPixelBufferMetalCompatibilityKey];
      }
      CVReturn status = CVPixelBufferPoolCreate(
          nil, nil, (__bridge CFDictionaryRef)attributes, &pool);
      if (status != kCVReturnSuccess || !pool) {
        return nil;
      }

      _pools[key] = pool;
    } else {
      pool = it->second;
    }

    CVPixelBufferRef pixelBuffer = nil;
    CVPixelBufferPoolCreatePixelBuffer(kCFAllocatorDefault, pool, &pixelBuffer);

    return pixelBuffer;
  }
}

- (void)freeAllCVPixelBufferPools {
  std::lock_guard<std::mutex> lock(_mutex);
  for (auto &pool : _pools) {
    CVPixelBufferPoolFlush(pool.second, kCVPixelBufferPoolFlushExcessBuffers);
    CVPixelBufferPoolRelease(pool.second);
  }
  _pools.clear();
}

@end

#pragma mark - AgoraCVPixelBufferUtils

@implementation AgoraCVPixelBufferUtils

+ (void)freeAllCVPixelBufferPools {
  [[AgoraCVPixelBufferPool sharedInstance] freeAllCVPixelBufferPools];
}

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

// create pixel buffer directly
#if defined(TARGET_OS_OSX) && TARGET_OS_OSX
  NSMutableDictionary *pixelBufferAttributes =
      [NSMutableDictionary dictionaryWithDictionary:@{
        (id)kCVPixelBufferIOSurfacePropertiesKey : @{},
#if (TARGET_OS_IOS)
        (id)kCVPixelBufferOpenGLESCompatibilityKey : @YES,
#elif (TARGET_OS_OSX)
        (id)kCVPixelBufferOpenGLCompatibilityKey : @YES,
#endif
        (id)kCVPixelBufferCGImageCompatibilityKey : @YES,
        (id)kCVPixelBufferCGBitmapContextCompatibilityKey : @YES,
        (id)kCVPixelBufferPixelFormatTypeKey : @(sourceFormat),
        (id)kCVPixelBufferWidthKey : @(sourceWidth),
        (id)kCVPixelBufferHeightKey : @(sourceHeight)
      }];

  if (@available(macOS 10.11, *)) {
    // This key is required to generate SKPicture with CVPixelBufferRef in
    // metal.
    [pixelBufferAttributes setObject:@YES forKey:(id)kCVPixelBufferMetalCompatibilityKey];
  }

  CVPixelBufferRef destPixelBuffer = nil;
  CVReturn status = CVPixelBufferCreate(
      kCFAllocatorDefault, sourceWidth, sourceHeight, sourceFormat,
      (__bridge CFDictionaryRef)pixelBufferAttributes, &destPixelBuffer);
  if (status != kCVReturnSuccess || !destPixelBuffer) {
    return nil;
  }
#else
  // create pixel buffer from pool
  CVPixelBufferRef destPixelBuffer =
      [[AgoraCVPixelBufferPool sharedInstance] createPixelBuffer:sourceFormat
                                                           width:sourceWidth
                                                          height:sourceHeight];
  if (!destPixelBuffer) {
    return nil;
  }
#endif

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

#if defined(TARGET_OS_OSX) && TARGET_OS_OSX
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
#endif

@end
