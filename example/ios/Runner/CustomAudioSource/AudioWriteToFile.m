//
//  AudioWriteToFile.m
//  AudioCapture
//
//  Created by CavanSu on 08/11/2017.
//  Copyright © 2017 Agora. All rights reserved.
//

#import "AudioWriteToFile.h"

@implementation AudioWriteToFile

static NSFileHandle *file = nil;
static dispatch_queue_t queue = nil;

+ (void)load {
    queue = dispatch_queue_create("writeFile", NULL);
}

+ (void)writeToFileWithData:(void *)data length:(int)bytes {
    if(NULL == data || bytes < 1) return;
    
    dispatch_async(queue, ^{
        
        if (file == nil) {
            NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"1.pcm"];
            [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
            if (![[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil]) {
        
            }
            else {
                file = [NSFileHandle fileHandleForWritingAtPath:path];
            }
        }
        [file writeData:[NSData dataWithBytes:data length:bytes]];
    });
}

@end
