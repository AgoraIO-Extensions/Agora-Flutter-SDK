#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Shared file logger for texture rendering pipeline debugging.
/// Both native (ObjC) and Flutter (Dart) sides write to the same file
/// so logs are interleaved in chronological order.
///
/// Disabled by default. Call `enableWithDirectory:` to start logging.
@interface TextureRenderLogger : NSObject

+ (void)enableWithDirectory:(NSString *)logDir;
+ (void)disable;
+ (void)log:(NSString *)tag message:(NSString *)format, ... NS_FORMAT_FUNCTION(2, 3);
+ (BOOL)isEnabled;
+ (nullable NSString *)logFilePath;

@end

NS_ASSUME_NONNULL_END
