//
//  AudioWriteToFile.h
//  AudioCapture
//
//  Created by CavanSu on 08/11/2017.
//  Copyright © 2017 Agora. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioWriteToFile : NSObject
+ (void)writeToFileWithData:(void *)data length:(int)bytes;
@end
