#import "TextureRenderLogger.h"
#include <pthread.h>

static FILE *sLogFile = NULL;
static BOOL sEnabled = NO;
static NSString *sLogFilePath = nil;
static pthread_mutex_t sLogMutex = PTHREAD_MUTEX_INITIALIZER;
static NSDateFormatter *sDateFormatter = nil;

@implementation TextureRenderLogger

+ (void)enableWithDirectory:(NSString *)logDir {
  pthread_mutex_lock(&sLogMutex);
  [self _closeFileLocked];

  NSFileManager *fm = [NSFileManager defaultManager];
  if (![fm fileExistsAtPath:logDir]) {
    [fm createDirectoryAtPath:logDir
        withIntermediateDirectories:YES
                         attributes:nil
                              error:nil];
  }

  sLogFilePath =
      [logDir stringByAppendingPathComponent:@"flutter_texture_render.log"];
  sLogFile = fopen([sLogFilePath UTF8String], "a");
  if (sLogFile) {
    sEnabled = YES;
    sDateFormatter = [[NSDateFormatter alloc] init];
    sDateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS";
    sDateFormatter.locale =
        [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
  }
  pthread_mutex_unlock(&sLogMutex);
}

+ (void)disable {
  pthread_mutex_lock(&sLogMutex);
  [self _closeFileLocked];
  pthread_mutex_unlock(&sLogMutex);
}

+ (void)_closeFileLocked {
  if (sLogFile) {
    fflush(sLogFile);
    fclose(sLogFile);
    sLogFile = NULL;
  }
  sEnabled = NO;
  sLogFilePath = nil;
  sDateFormatter = nil;
}

+ (void)log:(NSString *)tag message:(NSString *)format, ... {
  if (!sEnabled) {
    return;
  }

  va_list args;
  va_start(args, format);
  NSString *message =
      [[NSString alloc] initWithFormat:format arguments:args];
  va_end(args);

  pthread_mutex_lock(&sLogMutex);
  if (sLogFile) {
    NSString *timestamp = [sDateFormatter stringFromDate:[NSDate date]];
    fprintf(sLogFile, "%s [Native][%s] %s\n", [timestamp UTF8String],
            [tag UTF8String], [message UTF8String]);
    // Flush immediately so logs are not lost on crash
    fflush(sLogFile);
  }
  pthread_mutex_unlock(&sLogMutex);
}

+ (BOOL)isEnabled {
  return sEnabled;
}

+ (nullable NSString *)logFilePath {
  return sLogFilePath;
}

@end
