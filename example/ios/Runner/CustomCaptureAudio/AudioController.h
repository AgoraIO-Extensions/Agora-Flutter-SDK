//
//  AudioController.h
//  AudioCapture
//
//  Created by CavanSu on 10/11/2017.
//  Copyright © 2017 Agora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "AudioOptions.h"

@class AudioController;
@protocol AudioControllerDelegate <NSObject>
@optional
- (void)audioController:(AudioController *)controller
         didCaptureData:(unsigned char *)data
            bytesLength:(int)bytesLength;
- (int)audioController:(AudioController *)controller
         didRenderData:(unsigned char *)data
            bytesLength:(int)bytesLength;
- (void)audioController:(AudioController *)controller
                  error:(OSStatus)error
                   info:(NSString *)info;
@end


@interface AudioController : NSObject
@property (nonatomic, weak) id<AudioControllerDelegate> delegate;

+ (instancetype)audioController;
- (void)setUpAudioSessionWithSampleRate:(int)sampleRate channelCount:(int)channelCount audioCRMode:(AudioCRMode)audioCRMode IOType:(IOUnitType)ioType;
- (void)startWork;
- (void)stopWork;
 @end
