#import <AVFoundation/AVFoundation.h>

@interface AgoraCVPixelBufferUtils : NSObject

/**
 * Frees all CVPixelBuffer pools.
 *
 * We use a pool of CVPixelBuffers to avoid allocating and freeing them
 * frequently. This method allows us to free all the CVPixelBuffers in the
 * pool when needed.
 */
+ (void)freeAllCVPixelBufferPools;

/**
 * Creates a copy of a CVPixelBuffer.
 *
 * Always returns a new CVPixelBuffer with the same properties as the source
 * CVPixelBuffer.
 *
 * @param sourcePixelBuffer The source CVPixelBuffer to copy from
 * @return A new CVPixelBuffer containing a copy of the source data
 */
+ (CVPixelBufferRef _Nullable)copyCVPixelBuffer:
    (CVPixelBufferRef _Nonnull)sourcePixelBuffer;


#if defined(TARGET_OS_OSX) && TARGET_OS_OSX
/**
 * Saves a CVPixelBuffer to a PNG file in the documents directory.
 *
 * @param pixelBuffer The CVPixelBuffer to save
 * @param name The filename to save as
 * @return YES if successful, NO otherwise
 */
+ (BOOL)saveCVPixelBufferToFile:(CVPixelBufferRef _Nonnull)pixelBuffer
                           name:(NSString *_Nonnull)name;
#endif

@end
