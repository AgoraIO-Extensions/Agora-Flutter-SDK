//
//  AgoraAudioFrame.h
//  react-native-agora-rawdata
//
//  Created by LXH on 2020/11/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, AgoraAudioFrameType) {
  AgoraAudioFrameTypePCM16 = 0
};

@interface AgoraAudioFrame : NSObject
@property(nonatomic, assign) AgoraAudioFrameType type;
@property(nonatomic, assign) int samples;
@property(nonatomic, assign) int bytesPerSample;
@property(nonatomic, assign) int channels;
@property(nonatomic, assign) int samplesPerSec;
@property(nonatomic) void *buffer;
@property(nonatomic, assign) int64_t renderTimeMs;
@property(nonatomic, assign) int avsync_type;
@end

NS_ASSUME_NONNULL_END
