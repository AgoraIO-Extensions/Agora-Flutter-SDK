//
//  AgoraVideoFrame.h
//  react-native-agora-rawdata
//
//  Created by LXH on 2020/11/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, AgoraVideoFrameType) {
  AgoraVideoFrameTypeYUV420 = 0,
  AgoraVideoFrameTypeYUV422 = 1,
  AgoraVideoFrameTypeYUVRGBA = 2,
};

@interface AgoraVideoFrame : NSObject
@property(nonatomic, assign) AgoraVideoFrameType type;
@property(nonatomic, assign) int width;
@property(nonatomic, assign) int height;
@property(nonatomic, assign) int yStride;
@property(nonatomic, assign) int uStride;
@property(nonatomic, assign) int vStride;
@property(nonatomic) void *yBuffer;
@property(nonatomic) void *uBuffer;
@property(nonatomic) void *vBuffer;
@property(nonatomic, assign) int rotation;
@property(nonatomic, assign) int64_t renderTimeMs;
@property(nonatomic, assign) int avsync_type;
@end

NS_ASSUME_NONNULL_END
