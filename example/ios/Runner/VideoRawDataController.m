#import <Foundation/Foundation.h>
#import "VideoRawDataController.h"
#import <AgoraRtcKit/AgoraRtcKit.h>

@interface VideoRawDataController ()<AgoraRtcEngineDelegate, AgoraVideoFrameDelegate>

@property(nonatomic, strong) AgoraRtcEngineKit *agoraRtcEngine;

@end

@implementation VideoRawDataController

- (instancetype)initWith:(NSString *) appId {
    self = [super init];
    if (self) {
        AgoraRtcEngineConfig *config = [[AgoraRtcEngineConfig alloc] init];
        config.appId = appId;
        self.agoraRtcEngine = [AgoraRtcEngineKit sharedEngineWithConfig:config delegate:self];
        [self.agoraRtcEngine setVideoFrameDelegate:self];
    }
    
    return self;
}

- (intptr_t)getNativeHandle {
    return (intptr_t)[self.agoraRtcEngine getNativeHandle];
}

- (void)dispose {
    [self.agoraRtcEngine setVideoFrameDelegate:NULL];
    [AgoraRtcEngineKit destroy];
}

// MARK: - AgoraVideoFrameDelegate
- (BOOL)onCaptureVideoFrame:(AgoraOutputVideoFrame *)videoFrame sourceType:(AgoraVideoSourceType)sourceType {
    memset(videoFrame.uBuffer, 128, (videoFrame.uStride * videoFrame.height) / 2);
    memset(videoFrame.vBuffer, 128, (videoFrame.vStride * videoFrame.height) / 2);
    return YES;
}

- (AgoraVideoFormat)getVideoFormatPreference {
    return AgoraVideoFormatI420;
}

- (AgoraVideoFrameProcessMode)getVideoFrameProcessMode {
    return AgoraVideoFrameProcessModeReadWrite;
}

@end

