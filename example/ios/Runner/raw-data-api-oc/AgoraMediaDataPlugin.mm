//
//  AgoraMediaRawData.m
//  OpenVideoCall
//
//  Created by CavanSu on 26/02/2018.
//  Copyright © 2018 Agora. All rights reserved.
//

#import "AgoraMediaDataPlugin.h"

#import <AgoraRtcKit/AgoraRtcEngineKit.h>
#import <AgoraRtcKit/IAgoraMediaEngine.h>
#import <AgoraRtcKit/IAgoraRtcEngine.h>
#include <vector>

typedef void (^imageBlock)(AGImage *image);

@interface AgoraMediaDataPlugin ()
@property (nonatomic, assign) NSUInteger screenShotUid;
@property (nonatomic, assign) ObserverVideoType observerVideoType;
@property (nonatomic, assign) ObserverAudioType observerAudioType;
@property (nonatomic, assign) ObserverPacketType observerPacketType;
@property (nonatomic, strong) AgoraVideoRawDataFormatter *videoFormatter;
@property (nonatomic, assign) long agoraKit;
@property (nonatomic, copy) imageBlock imageBlock;
- (void)yuvToUIImageWithVideoRawData:(AgoraVideoRawData *)data;
@end


class AgoraVideoFrameObserver : public agora::media::IVideoFrameObserver
{
public:
    AgoraMediaDataPlugin *mediaDataPlugin;
    BOOL getOneDidCaptureVideoFrame = false;
    BOOL getOneWillRenderVideoFrame = false;
    unsigned int videoFrameUid = -1;
    
    AgoraVideoRawData* getVideoRawDataWithVideoFrame(VideoFrame& videoFrame)
    {
        AgoraVideoRawData *data = [[AgoraVideoRawData alloc] init];
        data.type = videoFrame.type;
        data.width = videoFrame.width;
        data.height = videoFrame.height;
        data.yStride = videoFrame.yStride;
        data.uStride = videoFrame.uStride;
        data.vStride = videoFrame.vStride;
        data.rotation = videoFrame.rotation;
        data.renderTimeMs = videoFrame.renderTimeMs;
        data.yBuffer = (char *)videoFrame.yBuffer;
        data.uBuffer = (char *)videoFrame.uBuffer;
        data.vBuffer = (char *)videoFrame.vBuffer;
        return data;
    }
    
    virtual bool onCaptureVideoFrame(VideoFrame& videoFrame) override
    {
        if (!mediaDataPlugin && ((mediaDataPlugin.observerVideoType >> 0) == 0)) return true;
        @autoreleasepool {
            AgoraVideoRawData *newData = nil;
            if ([mediaDataPlugin.videoDelegate respondsToSelector:@selector(mediaDataPlugin:didCapturedVideoRawData:)]) {
                AgoraVideoRawData *data = getVideoRawDataWithVideoFrame(videoFrame);
                newData = [mediaDataPlugin.videoDelegate mediaDataPlugin:mediaDataPlugin didCapturedVideoRawData:data];
                
                // ScreenShot
                if (getOneDidCaptureVideoFrame) {
                    getOneDidCaptureVideoFrame = false;
                    [mediaDataPlugin yuvToUIImageWithVideoRawData:newData];
                }
            }
        }
        return true;
    }
    
    virtual bool onRenderVideoFrame(unsigned int uid, VideoFrame& videoFrame) override
    {
        if (!mediaDataPlugin && ((mediaDataPlugin.observerVideoType >> 1) == 0)) return true;
        @autoreleasepool {
            AgoraVideoRawData *newData = nil;
            if ([mediaDataPlugin.videoDelegate respondsToSelector:@selector(mediaDataPlugin:willRenderVideoRawData:ofUid:)]) {
                AgoraVideoRawData *data = getVideoRawDataWithVideoFrame(videoFrame);
                newData = [mediaDataPlugin.videoDelegate mediaDataPlugin:mediaDataPlugin willRenderVideoRawData:data ofUid:uid];
                
                // ScreenShot
                if (getOneWillRenderVideoFrame && videoFrameUid == uid) {
                    getOneWillRenderVideoFrame = false;
                    videoFrameUid = -1;
                    [mediaDataPlugin yuvToUIImageWithVideoRawData:newData];
                }
            }
        }
        return true;
    }
    
    virtual VIDEO_FRAME_TYPE getVideoFormatPreference() override
    {
        return VIDEO_FRAME_TYPE(mediaDataPlugin.videoFormatter.type);
    }

    virtual bool getRotationApplied() override
    {
        return mediaDataPlugin.videoFormatter.rotationApplied;
    }

    virtual bool getMirrorApplied() override
    {
        return mediaDataPlugin.videoFormatter.mirrorApplied;
    }
};

class AgoraAudioFrameObserver : public agora::media::IAudioFrameObserver
{
public:
    AgoraMediaDataPlugin *mediaDataPlugin;

    AgoraAudioRawData* getAudioRawDataWithAudioFrame(AudioFrame& audioFrame)
    {
        AgoraAudioRawData *data = [[AgoraAudioRawData alloc] init];
        data.samples = audioFrame.samples;
        data.bytesPerSample = audioFrame.bytesPerSample;
        data.channels = audioFrame.channels;
        data.samplesPerSec = audioFrame.samplesPerSec;
        data.renderTimeMs = audioFrame.renderTimeMs;
        data.buffer = (char *)audioFrame.buffer;
        data.bufferSize = audioFrame.samples * audioFrame.bytesPerSample;
        return data;
    }
    
    void modifiedAudioFrameWithNewAudioRawData(AudioFrame& audioFrame, AgoraAudioRawData *audioRawData)
    {
        audioFrame.samples = audioRawData.samples;
        audioFrame.bytesPerSample = audioRawData.bytesPerSample;
        audioFrame.channels = audioRawData.channels;
        audioFrame.samplesPerSec = audioRawData.samplesPerSec;
        audioFrame.renderTimeMs = audioRawData.renderTimeMs;
    }
    
    virtual bool onRecordAudioFrame(AudioFrame& audioFrame) override
    {
        if (!mediaDataPlugin && ((mediaDataPlugin.observerAudioType >> 0) == 0)) return true;
        @autoreleasepool {
            if ([mediaDataPlugin.audioDelegate respondsToSelector:@selector(mediaDataPlugin:didRecordAudioRawData:)]) {
                AgoraAudioRawData *data = getAudioRawDataWithAudioFrame(audioFrame);
                AgoraAudioRawData *newData = [mediaDataPlugin.audioDelegate mediaDataPlugin:mediaDataPlugin didRecordAudioRawData:data];
                modifiedAudioFrameWithNewAudioRawData(audioFrame, newData);
            }
        }
        return true;
    }
    
    virtual bool onPlaybackAudioFrame(AudioFrame& audioFrame) override
    {
        if (!mediaDataPlugin && ((mediaDataPlugin.observerAudioType >> 1) == 0)) return true;
        @autoreleasepool {
            if ([mediaDataPlugin.audioDelegate respondsToSelector:@selector(mediaDataPlugin:willPlaybackAudioRawData:)]) {
                AgoraAudioRawData *data = getAudioRawDataWithAudioFrame(audioFrame);
                AgoraAudioRawData *newData = [mediaDataPlugin.audioDelegate mediaDataPlugin:mediaDataPlugin willPlaybackAudioRawData:data];
                modifiedAudioFrameWithNewAudioRawData(audioFrame, newData);
            }
        }
        return true;
    }
    
    virtual bool onPlaybackAudioFrameBeforeMixing(unsigned int uid, AudioFrame& audioFrame) override
    {
        if (!mediaDataPlugin && ((mediaDataPlugin.observerAudioType >> 2) == 0)) return true;
        @autoreleasepool {
            if ([mediaDataPlugin.audioDelegate respondsToSelector:@selector(mediaDataPlugin:willPlaybackBeforeMixingAudioRawData:ofUid:)]) {
                AgoraAudioRawData *data = getAudioRawDataWithAudioFrame(audioFrame);
                AgoraAudioRawData *newData = [mediaDataPlugin.audioDelegate mediaDataPlugin:mediaDataPlugin willPlaybackBeforeMixingAudioRawData:data ofUid:uid];
                modifiedAudioFrameWithNewAudioRawData(audioFrame, newData);
            }
        }
        return true;
    }
    
    virtual bool onMixedAudioFrame(AudioFrame& audioFrame) override
    {
        if (!mediaDataPlugin && ((mediaDataPlugin.observerAudioType >> 3) == 0)) return true;
        @autoreleasepool {
            if ([mediaDataPlugin.audioDelegate respondsToSelector:@selector(mediaDataPlugin:didMixedAudioRawData:)]) {
                AgoraAudioRawData *data = getAudioRawDataWithAudioFrame(audioFrame);
                AgoraAudioRawData *newData = [mediaDataPlugin.audioDelegate mediaDataPlugin:mediaDataPlugin didMixedAudioRawData:data];
                modifiedAudioFrameWithNewAudioRawData(audioFrame, newData);
            }
        }
        return true;
    }
};

class AgoraPacketObserver : public agora::rtc::IPacketObserver
{
public:
    AgoraMediaDataPlugin *mediaDataPlugin;
    
    AgoraPacketObserver()
    {
    }
    
    AgoraPacketRawData* getPacketRawDataWithPacket(Packet& packet)
    {
        AgoraPacketRawData *data = [[AgoraPacketRawData alloc] init];
        data.buffer = packet.buffer;
        data.bufferSize = packet.size;
        return data;
    }
    
    void modifiedPacketWithNewPacketRawData(Packet& packet, AgoraPacketRawData *rawData)
    {
        packet.size = rawData.bufferSize;
    }
    
    virtual bool onSendAudioPacket(Packet& packet)
    {
        if (!mediaDataPlugin && ((mediaDataPlugin.observerPacketType >> 0) == 0)) return true;
        @synchronized(mediaDataPlugin) {
            @autoreleasepool {
                if ([mediaDataPlugin.packetDelegate respondsToSelector:@selector(mediaDataPlugin:willSendAudioPacket:)]) {
                    AgoraPacketRawData *data = getPacketRawDataWithPacket(packet);
                    AgoraPacketRawData *newData = [mediaDataPlugin.packetDelegate mediaDataPlugin:mediaDataPlugin willSendAudioPacket:data];
                    modifiedPacketWithNewPacketRawData(packet, newData);
                }
            }
            return true;
        }
    }
    
    virtual bool onSendVideoPacket(Packet& packet)
    {
        
        if (!mediaDataPlugin && ((mediaDataPlugin.observerPacketType >> 1) == 0)) return true;
        @synchronized(mediaDataPlugin) {
            @autoreleasepool {
                if ([mediaDataPlugin.packetDelegate respondsToSelector:@selector(mediaDataPlugin:willSendVideoPacket:)]) {
                    AgoraPacketRawData *data = getPacketRawDataWithPacket(packet);
                    AgoraPacketRawData *newData = [mediaDataPlugin.packetDelegate mediaDataPlugin:mediaDataPlugin willSendVideoPacket:data];
                    modifiedPacketWithNewPacketRawData(packet, newData);
                }
            }
            return true;
        }
    }
    
    virtual bool onReceiveAudioPacket(Packet& packet)
    {
        if (!mediaDataPlugin && ((mediaDataPlugin.observerPacketType >> 2) == 0)) return true;
        @synchronized(mediaDataPlugin) {
            @autoreleasepool {
                if ([mediaDataPlugin.packetDelegate respondsToSelector:@selector(mediaDataPlugin:didReceivedAudioPacket:)]) {
                    AgoraPacketRawData *data = getPacketRawDataWithPacket(packet);
                    AgoraPacketRawData *newData = [mediaDataPlugin.packetDelegate mediaDataPlugin:mediaDataPlugin didReceivedAudioPacket:data];
                    modifiedPacketWithNewPacketRawData(packet, newData);
                }
            }
            return true;
        }
    }
    
    virtual bool onReceiveVideoPacket(Packet& packet)
    {
        if (!mediaDataPlugin && ((mediaDataPlugin.observerPacketType >> 3) == 0)) return true;
        @synchronized(mediaDataPlugin) {
            @autoreleasepool {
                if ([mediaDataPlugin.packetDelegate respondsToSelector:@selector(mediaDataPlugin:didReceivedVideoPacket:)]) {
                    AgoraPacketRawData *data = getPacketRawDataWithPacket(packet);
                    AgoraPacketRawData *newData = [mediaDataPlugin.packetDelegate mediaDataPlugin:mediaDataPlugin didReceivedVideoPacket:data];
                    modifiedPacketWithNewPacketRawData(packet, newData);
                }
            }
            return true;
        }
    }
};

static AgoraVideoFrameObserver s_videoFrameObserver;
static AgoraAudioFrameObserver s_audioFrameObserver;
static AgoraPacketObserver s_packetObserver;

@implementation AgoraMediaDataPlugin
    
+ (instancetype)mediaDataPluginWithAgoraKit:(long)agoraKit {
    AgoraMediaDataPlugin *source = [[AgoraMediaDataPlugin alloc] init];
    source.videoFormatter = [[AgoraVideoRawDataFormatter alloc] init];
    source.agoraKit = agoraKit;
    
    if (!agoraKit) {
        return nil;
    }
    return source;
}

- (void)registerVideoRawDataObserver:(ObserverVideoType)observerType {
    agora::rtc::IRtcEngine* rtc_engine = (agora::rtc::IRtcEngine*)self.agoraKit;
    agora::util::AutoPtr<agora::media::IMediaEngine> mediaEngine;
    mediaEngine.queryInterface(rtc_engine, agora::AGORA_IID_MEDIA_ENGINE);
    
    NSInteger oldValue = self.observerVideoType;
    self.observerVideoType |= observerType;
    
    if (mediaEngine && oldValue == 0)
    {
        mediaEngine->registerVideoFrameObserver(&s_videoFrameObserver);
        s_videoFrameObserver.mediaDataPlugin = self;
    }
}

- (void)deregisterVideoRawDataObserver:(ObserverVideoType)observerType {
    agora::rtc::IRtcEngine* rtc_engine = (agora::rtc::IRtcEngine*)self.agoraKit;
    agora::util::AutoPtr<agora::media::IMediaEngine> mediaEngine;
    mediaEngine.queryInterface(rtc_engine, agora::AGORA_IID_MEDIA_ENGINE);
    
    self.observerVideoType ^= observerType;
    
    if (mediaEngine && self.observerVideoType == 0)
    {
        mediaEngine->registerVideoFrameObserver(NULL);
        s_videoFrameObserver.mediaDataPlugin = nil;
    }
}

- (void)registerAudioRawDataObserver:(ObserverAudioType)observerType {
    agora::rtc::IRtcEngine* rtc_engine = (agora::rtc::IRtcEngine*)self.agoraKit;
    agora::util::AutoPtr<agora::media::IMediaEngine> mediaEngine;
    mediaEngine.queryInterface(rtc_engine, agora::AGORA_IID_MEDIA_ENGINE);
    
    NSInteger oldValue = self.observerAudioType;
    self.observerAudioType |= observerType;
    
    if (mediaEngine && oldValue == 0)
    {
        mediaEngine->registerAudioFrameObserver(&s_audioFrameObserver);
        s_audioFrameObserver.mediaDataPlugin = self;
    }
}

- (void)deregisterAudioRawDataObserver:(ObserverAudioType)observerType {
    agora::rtc::IRtcEngine* rtc_engine = (agora::rtc::IRtcEngine*)self.agoraKit;
    agora::util::AutoPtr<agora::media::IMediaEngine> mediaEngine;
    mediaEngine.queryInterface(rtc_engine, agora::AGORA_IID_MEDIA_ENGINE);
    
    self.observerAudioType ^= observerType;
    
    if (mediaEngine && self.observerAudioType == 0)
    {
        mediaEngine->registerAudioFrameObserver(NULL);
        s_audioFrameObserver.mediaDataPlugin = nil;
    }
}

- (void)registerPacketRawDataObserver:(ObserverPacketType)observerType {
    agora::rtc::IRtcEngine* rtc_engine = (agora::rtc::IRtcEngine*)self.agoraKit;
    
    NSInteger oldValue = self.observerPacketType;
    self.observerPacketType |= observerType;
    
    if (rtc_engine && oldValue == 0)
    {
        rtc_engine->registerPacketObserver(&s_packetObserver);
        s_packetObserver.mediaDataPlugin = self;
    }
}

- (void)deregisterPacketRawDataObserver:(ObserverPacketType)observerType {
    agora::rtc::IRtcEngine* rtc_engine = (agora::rtc::IRtcEngine*)self.agoraKit;
    
    self.observerPacketType ^= observerType;
    
    if (rtc_engine && self.observerPacketType == 0)
    {
        rtc_engine->registerPacketObserver(NULL);
        s_packetObserver.mediaDataPlugin = nil;
    }
}

- (void)setVideoRawDataFormatter:(AgoraVideoRawDataFormatter * _Nonnull)formatter {
    if (self.videoFormatter.type != formatter.type) {
        self.videoFormatter.type = formatter.type;
    }
    
    if (self.videoFormatter.rotationApplied != formatter.rotationApplied) {
        self.videoFormatter.rotationApplied = formatter.rotationApplied;
    }
    
    if (self.videoFormatter.mirrorApplied != formatter.mirrorApplied) {
        self.videoFormatter.mirrorApplied = formatter.mirrorApplied;
    }
}

- (AgoraVideoRawDataFormatter * _Nonnull)getCurrentVideoRawDataFormatter {
    return self.videoFormatter;
}

#pragma mark - Screen Capture
- (void)localSnapshot:(void (^ _Nullable)(AGImage * _Nonnull image))completion {
    self.imageBlock = completion;
    s_videoFrameObserver.getOneDidCaptureVideoFrame = true;
}

- (void)remoteSnapshotWithUid:(NSUInteger)uid image:(void (^ _Nullable)(AGImage * _Nonnull image))completion {
    self.imageBlock = completion;
    s_videoFrameObserver.getOneWillRenderVideoFrame = true;
    s_videoFrameObserver.videoFrameUid = (unsigned int)uid;
}

- (void)yuvToUIImageWithVideoRawData:(AgoraVideoRawData *)data {
    size_t width = data.width;
    size_t height = data.height;
    size_t yStride = data.yStride;
    size_t uvStride = data.uStride;
    
    char* yBuffer = data.yBuffer;
    char* uBuffer = data.uBuffer;
    char* vBuffer = data.vBuffer;
    
    size_t uvBufferLength = height * uvStride;
    char* uvBuffer = (char *)malloc(uvBufferLength);
    for (size_t uv = 0, u = 0; uv < uvBufferLength; uv += 2, u++) {
        // swtich the location of U、V，to NV12
        uvBuffer[uv] = uBuffer[u];
        uvBuffer[uv+1] = vBuffer[u];
    }
    
    @autoreleasepool {
        void * planeBaseAddress[2] = {yBuffer, uvBuffer};
        size_t planeWidth[2] = {width, width / 2};
        size_t planeHeight[2] = {height, height / 2};
        size_t planeBytesPerRow[2] = {yStride, uvStride * 2};
        
        CVPixelBufferRef pixelBuffer = NULL;
        CVReturn result = CVPixelBufferCreateWithPlanarBytes(kCFAllocatorDefault,
                                                             width, height,
                                                             kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange,
                                                             NULL, 0,
                                                             2, planeBaseAddress, planeWidth, planeHeight, planeBytesPerRow,
                                                             NULL, NULL, NULL,
                                                             &pixelBuffer);
        if (result != kCVReturnSuccess) {
            NSLog(@"Unable to create cvpixelbuffer %d", result);
        }
        
        AGImage *image = [self CVPixelBufferToImage:pixelBuffer rotation:data.rotation];
        if (self.imageBlock) {
            self.imageBlock(image);
        }
        
        CVPixelBufferRelease(pixelBuffer);
    }
    
    if(uvBuffer != NULL) {
        free(uvBuffer);
        uvBuffer = NULL;
    }
}

// CVPixelBuffer-->CIImage--->AGImage Conversion
- (AGImage *)CVPixelBufferToImage:(CVPixelBufferRef)pixelBuffer rotation:(int)rotation {
    size_t width, height;
    CGImagePropertyOrientation orientation;
    switch (rotation) {
        case 0:
            width = CVPixelBufferGetWidth(pixelBuffer);
            height = CVPixelBufferGetHeight(pixelBuffer);
            orientation = kCGImagePropertyOrientationUp;
            break;
        case 90:
            width = CVPixelBufferGetHeight(pixelBuffer);
            height = CVPixelBufferGetWidth(pixelBuffer);
            orientation = kCGImagePropertyOrientationRight;
            break;
        case 180:
            width = CVPixelBufferGetWidth(pixelBuffer);
            height = CVPixelBufferGetHeight(pixelBuffer);
            orientation = kCGImagePropertyOrientationDown;
            break;
        case 270:
            width = CVPixelBufferGetHeight(pixelBuffer);
            height = CVPixelBufferGetWidth(pixelBuffer);
            orientation = kCGImagePropertyOrientationLeft;
            break;
        default:
            return nil;
    }
    CIImage *coreImage = [[CIImage imageWithCVPixelBuffer:pixelBuffer] imageByApplyingOrientation:orientation];
    CIContext *temporaryContext = [CIContext contextWithOptions:nil];
    CGImageRef videoImage = [temporaryContext createCGImage:coreImage
                                                   fromRect:CGRectMake(0, 0, width, height)];

#if (!(TARGET_OS_IPHONE) && (TARGET_OS_MAC))
    AGImage *finalImage =  [[NSImage alloc] initWithCGImage:videoImage size:NSMakeSize(width, height)];
#else
    AGImage *finalImage = [[AGImage alloc] initWithCGImage:videoImage];
#endif
    CGImageRelease(videoImage);
    return finalImage;
}
@end

