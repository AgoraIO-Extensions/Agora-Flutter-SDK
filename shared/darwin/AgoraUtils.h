#ifdef DEBUG
#import <Foundation/Foundation.h>

#define AGORA_LOG(fmt, ...) NSLog((@"[AGORA_NG] " fmt), ##__VA_ARGS__)
#else
#define AGORA_LOG(fmt, ...)
#endif