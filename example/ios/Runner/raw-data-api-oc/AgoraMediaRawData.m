//
//  AgoraVideoRawData.m
//  OpenVideoCall
//
//  Created by CavanSu on 26/02/2018.
//  Copyright © 2018 Agora. All rights reserved.
//

#import "AgoraMediaRawData.h"

@implementation AgoraVideoRawDataFormatter
- (instancetype)init {
    if (self = [super init]) {
        self.mirrorApplied = false;
        self.rotationApplied = false;
        self.type = 0;
    }
    return self;
}
@end

@implementation AgoraVideoRawData

@end

@implementation AgoraAudioRawData

@end

@implementation AgoraPacketRawData

@end
