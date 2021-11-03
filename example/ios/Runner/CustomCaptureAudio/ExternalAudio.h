//
//  ExternalAudio.h
//  AgoraAudioIO
//
//  Created by CavanSu on 22/01/2018.
//  Copyright © 2018 CavanSu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AudioOptions.h"

@class AgoraRtcEngineKit;
@class ExternalAudio;
@protocol ExternalAudioDelegate <NSObject>
@optional
- (void)externalAudio:(ExternalAudio *)externalAudio errorInfo:(NSString *)errorInfo;
@end

@interface ExternalAudio : NSObject
@property (nonatomic, weak) id<ExternalAudioDelegate> delegate;

+ (instancetype)sharedExternalAudio;
- (void)setupExternalAudioWithAgoraKit:(AgoraRtcEngineKit *)agoraKit sampleRate:(uint)sampleRate channels:(uint)channels audioCRMode:(AudioCRMode)audioCRMode IOType:(IOUnitType)ioType;
- (void)startWork;
- (void)stopWork;
@end
