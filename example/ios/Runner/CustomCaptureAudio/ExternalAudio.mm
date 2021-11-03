//
//  ExternalAudio.m
//  AgoraAudioIO
//
//  Created by CavanSu on 22/01/2018.
//  Copyright © 2018 CavanSu. All rights reserved.
//

#import "ExternalAudio.h"
#import "AudioController.h"
#import "AudioWriteToFile.h"

#if TARGET_OS_IPHONE
#import <AgoraRtcKit/AgoraRtcEngineKit.h>
#import <AgoraRtcKit/IAgoraRtcEngine.h>
#import <AgoraRtcKit/IAgoraMediaEngine.h>
#else
#import <AgoraRtcKit/AgoraRtcEngineKit.h>
#import <AgoraRtcKit/IAgoraRtcEngine.h>
#import <AgoraRtcKit/IAgoraMediaEngine.h>
#endif

@interface ExternalAudio () <AudioControllerDelegate>
@property (nonatomic, strong) AudioController *audioController;
@property (nonatomic, assign) AudioCRMode audioCRMode;
@property (nonatomic, assign) int sampleRate;
@property (nonatomic, assign) int channelCount;
@property (nonatomic, weak) AgoraRtcEngineKit *agoraKit;
@end

@implementation ExternalAudio

static NSObject *threadLockCapture;
static NSObject *threadLockPlay;

#pragma mark - C++ ExternalAudioFrameObserver
class ExternalAudioFrameObserver : public agora::media::IAudioFrameObserver
{
private:
    
    // total buffer length of per second
    enum { kBufferLengthBytes = 441 * 2 * 2 * 50 }; //
    
    // capture
    char byteBuffer[kBufferLengthBytes]; // char take up 1 byte, byterBuffer[] take up 88200 bytes
    int readIndex = 0;
    int writeIndex = 0;
    int availableBytes = 0;
    int channels = 1;
    
    // play
    char byteBuffer_play[kBufferLengthBytes];
    int readIndex_play = 0;
    int writeIndex_play = 0;
    int availableBytes_play = 0;
    int channels_play = 1;
    
public:
    int sampleRate = 0;
    int sampleRate_play = 0;
    
    bool isExternalCapture = false;
    bool isExternalRender = false;
    
#pragma mark- <C++ Capture>
    // push audio data to special buffer(Array byteBuffer)
    // bytesLength = date length
    void pushExternalData(void* data, int bytesLength)
    {
        @synchronized(threadLockCapture) {
            
            if (availableBytes + bytesLength > kBufferLengthBytes) {
                
                readIndex = 0;
                writeIndex = 0;
                availableBytes = 0;
            }
            
            if (writeIndex + bytesLength > kBufferLengthBytes) {
                
                int left = kBufferLengthBytes - writeIndex;
                memcpy(byteBuffer + writeIndex, data, left);
                memcpy(byteBuffer, (char *)data + left, bytesLength - left);
                writeIndex = bytesLength - left;
            }
            else {
                
                memcpy(byteBuffer + writeIndex, data, bytesLength);
                writeIndex += bytesLength;
            }
            availableBytes += bytesLength;
        }
    
    }
    
    // copy byteBuffer to audioFrame.buffer
    virtual bool onRecordAudioFrame(AudioFrame& audioFrame) override
    {
        @synchronized(threadLockCapture) {
            
            if (isExternalCapture == false) return true;
            
            int readBytes = sampleRate / 100 * channels * audioFrame.bytesPerSample;
            
            if (availableBytes < readBytes) {
                return false;
            }
            
            audioFrame.samplesPerSec = sampleRate;
            unsigned char tmp[960]; // The most rate:@48k fs, channels = 1, the most total size = 960;
            
            if (readIndex + readBytes > kBufferLengthBytes) {
                int left = kBufferLengthBytes - readIndex;
                memcpy(tmp, byteBuffer + readIndex, left);
                memcpy(tmp + left, byteBuffer, readBytes - left);
                readIndex = readBytes - left;
            }
            else {
                memcpy(tmp, byteBuffer + readIndex, readBytes);
                readIndex += readBytes;
            }
            
            availableBytes -= readBytes;
            
            if (channels == audioFrame.channels) {
                memcpy(audioFrame.buffer, tmp, readBytes);
            }
            [AudioWriteToFile writeToFileWithData:audioFrame.buffer length:readBytes];
            return true;
        }
        
    }
    
#pragma mark- <C++ Render>
    // read Audio data from byteBuffer_play to audioUnit
    int readAudioData(void* data, int bytesLength)
    {
        @synchronized(threadLockPlay) {
            
            if (NULL == data || bytesLength < 1 || availableBytes_play < bytesLength) {
                return 0;
            }
            
            int readBytes = bytesLength;
            
            unsigned char tmp[4096]; // unsigned char takes up 1 byte
            
            if (readIndex_play + readBytes > kBufferLengthBytes) {
                
                int left = kBufferLengthBytes - readIndex_play;
                memcpy(tmp, byteBuffer_play + readIndex_play, left);
                memcpy(tmp + left, byteBuffer_play, readBytes - left);
                readIndex_play = readBytes - left;
            }
            else {
                
                memcpy(tmp, byteBuffer_play + readIndex_play, readBytes);
                readIndex_play += readBytes;
            }
            
            availableBytes_play -= readBytes;
            
            if (channels_play == 1) {
                memcpy(data, tmp, readBytes);
            }
            
            [AudioWriteToFile writeToFileWithData:data length:readBytes];
            
            return readBytes;
        }
        
    }
    
    // recive remote audio stream, push audio data to byteBuffer_play
    virtual bool onPlaybackAudioFrame(AudioFrame& audioFrame) override
    {
        @synchronized(threadLockPlay) {
        
            if (isExternalRender == false) return true;

            int bytesLength = audioFrame.samples * audioFrame.channels * audioFrame.bytesPerSample;
            char *data = (char *)audioFrame.buffer;
            
            sampleRate_play = audioFrame.samplesPerSec;
            channels_play = audioFrame.channels;
            
            if (availableBytes_play + bytesLength > kBufferLengthBytes) {
                
                readIndex_play = 0;
                writeIndex_play = 0;
                availableBytes_play = 0;
            }
            
            if (writeIndex_play + bytesLength > kBufferLengthBytes) {
                
                int left = kBufferLengthBytes - writeIndex_play;
                memcpy(byteBuffer_play + writeIndex_play, data, left);
                memcpy(byteBuffer_play, (char *)data + left, bytesLength - left);
                writeIndex_play = bytesLength - left;
            }
            else {
                
                memcpy(byteBuffer_play + writeIndex_play, data, bytesLength);
                writeIndex_play += bytesLength;
            }
            
            availableBytes_play += bytesLength;
            
            return true;
        }
    
    }
    
    virtual bool onPlaybackAudioFrameBeforeMixing(unsigned int uid, AudioFrame& audioFrame) override { return true; }
    
    virtual bool onMixedAudioFrame(AudioFrame& audioFrame) override { return true; }
};

static ExternalAudioFrameObserver* s_audioFrameObserver;


+ (instancetype)sharedExternalAudio {
    ExternalAudio *audio = [[ExternalAudio alloc] init];
    return audio;
}

- (void)setupExternalAudioWithAgoraKit:(AgoraRtcEngineKit *)agoraKit sampleRate:(uint)sampleRate channels:(uint)channels audioCRMode:(AudioCRMode)audioCRMode IOType:(IOUnitType)ioType {
    
    threadLockCapture = [[NSObject alloc] init];
    threadLockPlay = [[NSObject alloc] init];
    
    // AudioController
    self.audioController = [AudioController audioController];
    self.audioController.delegate = self;
    [self.audioController setUpAudioSessionWithSampleRate:sampleRate channelCount:channels audioCRMode:audioCRMode IOType:ioType];
    
    // Agora Engine of C++
    agora::rtc::IRtcEngine* rtc_engine = (agora::rtc::IRtcEngine*)agoraKit.getNativeHandle;
    agora::util::AutoPtr<agora::media::IMediaEngine> mediaEngine;
    mediaEngine.queryInterface(rtc_engine, agora::AGORA_IID_MEDIA_ENGINE);
    
    if (mediaEngine) {
        s_audioFrameObserver = new ExternalAudioFrameObserver();
        s_audioFrameObserver -> sampleRate = sampleRate;
        s_audioFrameObserver -> sampleRate_play = channels;
        mediaEngine->registerAudioFrameObserver(s_audioFrameObserver);
    }
    
    if (audioCRMode == AudioCRModeExterCaptureExterRender || audioCRMode == AudioCRModeSDKCaptureExterRender) {
        s_audioFrameObserver -> isExternalRender = true;
    }
    if (audioCRMode == AudioCRModeExterCaptureExterRender || audioCRMode == AudioCRModeExterCaptureSDKRender) {
        s_audioFrameObserver -> isExternalCapture = true;
    }
    
    self.agoraKit = agoraKit;
    self.audioCRMode = audioCRMode;
}

- (void)startWork {
    [self.audioController startWork];
}

- (void)stopWork {
    [self.audioController stopWork];
    [self cancelRegiset];
}

- (void)cancelRegiset {
    agora::rtc::IRtcEngine* rtc_engine = (agora::rtc::IRtcEngine*)self.agoraKit.getNativeHandle;
    agora::util::AutoPtr<agora::media::IMediaEngine> mediaEngine;
    mediaEngine.queryInterface(rtc_engine, agora::AGORA_IID_MEDIA_ENGINE);
    mediaEngine->registerAudioFrameObserver(NULL);
}

- (void)audioController:(AudioController *)controller didCaptureData:(unsigned char *)data bytesLength:(int)bytesLength {
    
    if (self.audioCRMode != AudioCRModeExterCaptureSDKRender) {
        if (s_audioFrameObserver) {
            s_audioFrameObserver -> pushExternalData(data, bytesLength);
        }
    }
    else {
        [self.agoraKit pushExternalAudioFrameRawData:data samples:bytesLength / 2 timestamp:0];
    }
    
}

- (int)audioController:(AudioController *)controller didRenderData:(unsigned char *)data bytesLength:(int)bytesLength {
    int result = 0;
    
    if (s_audioFrameObserver) {
        result = s_audioFrameObserver -> readAudioData(data, bytesLength);
    }
    
    return result;
}

- (void)audioController:(AudioController *)controller error:(OSStatus)error info:(NSString *)info {
    if ([self.delegate respondsToSelector:@selector(externalAudio:errorInfo:)]) {
        NSString *errorInfo = [NSString stringWithFormat:@"<EA Error> error:%d, info:%@", error, info];
        [self.delegate externalAudio:self errorInfo:errorInfo];
    }
}

- (void)dealloc {
    NSLog(@"<ExternalAudio Log>ExAudio dealloc");
}

@end
