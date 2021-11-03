//
//  AudioController.m
//  AudioCapture
//
//  Created by CavanSu on 10/11/2017.
//  Copyright © 2017 Agora. All rights reserved.
//

#import "AudioController.h"
#import "AudioWriteToFile.h"

#define InputBus 1
#define OutputBus 0

@interface AudioController ()
@property (nonatomic, assign) int sampleRate;
@property (nonatomic, assign) int channelCount;
@property (nonatomic, assign) AudioCRMode audioCRMode;
@property (nonatomic, assign) OSStatus error;

@property (nonatomic, assign) AudioUnit remoteIOUnit;
#if TARGET_OS_MAC
@property (nonatomic, assign) AudioUnit macPlayUnit;
#endif
@end

@implementation AudioController

#if TARGET_OS_IPHONE
static double preferredIOBufferDuration = 0.02;
#endif

+ (instancetype)audioController {
    AudioController *audioController = [[self alloc] init];
    return audioController;
}

#pragma mark - <Capture Call Back>
static OSStatus captureCallBack(void *inRefCon,
                                AudioUnitRenderActionFlags *ioActionFlags,
                                const AudioTimeStamp *inTimeStamp,
                                UInt32 inBusNumber, // inputBus = 1
                                UInt32 inNumberFrames,
                                AudioBufferList *ioData)
{
    AudioController *audioController = (__bridge AudioController *)inRefCon;
    
    AudioUnit captureUnit = [audioController remoteIOUnit];
    
    if (!inRefCon) return 0;
    
    AudioBuffer buffer;
    buffer.mData = NULL;
    buffer.mDataByteSize = 0;
    buffer.mNumberChannels = audioController.channelCount;
    
    AudioBufferList bufferList;
    bufferList.mNumberBuffers = 1;
    bufferList.mBuffers[0] = buffer;
    
    OSStatus status = AudioUnitRender(captureUnit,
                                      ioActionFlags,
                                      inTimeStamp,
                                      inBusNumber,
                                      inNumberFrames,
                                      &bufferList);
    
    if (!status) {
        if ([audioController.delegate respondsToSelector:@selector(audioController:didCaptureData:bytesLength:)]) {
            [audioController.delegate audioController:audioController didCaptureData:(unsigned char *)bufferList.mBuffers[0].mData bytesLength:bufferList.mBuffers[0].mDataByteSize];
        }
    }
    else {
        [audioController error:status position:@"captureCallBack"];
    }
    
    return 0;
}

#pragma mark - <Render Call Back>
static OSStatus renderCallBack(void *inRefCon,
                               AudioUnitRenderActionFlags *ioActionFlags,
                               const AudioTimeStamp *inTimeStamp,
                               UInt32 inBusNumber,
                               UInt32 inNumberFrames,
                               AudioBufferList *ioData)
{
    AudioController *audioController = (__bridge AudioController *)(inRefCon);
    
    if (*ioActionFlags == kAudioUnitRenderAction_OutputIsSilence) {
        return noErr;
    }
    
    int result = 0;

    if ([audioController.delegate respondsToSelector:@selector(audioController:didRenderData:bytesLength:)]) {
        result = [audioController.delegate audioController:audioController didRenderData:(uint8_t*)ioData->mBuffers[0].mData bytesLength:ioData->mBuffers[0].mDataByteSize];
    }
    
    if (result == 0) {
        *ioActionFlags = kAudioUnitRenderAction_OutputIsSilence;
        ioData->mBuffers[0].mDataByteSize = 0;
    }

    return noErr;
}


#pragma mark - <Step 1, Set Up Audio Session>
- (void)setUpAudioSessionWithSampleRate:(int)sampleRate channelCount:(int)channelCount audioCRMode:(AudioCRMode)audioCRMode IOType:(IOUnitType)ioType{
    if (_audioCRMode == AudioCRModeSDKCaptureSDKRender) {
        return;
    }
    
    self.audioCRMode = audioCRMode;
    self.sampleRate = sampleRate;
    self.channelCount = channelCount;
    
#if TARGET_OS_IPHONE
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSUInteger sessionOption = AVAudioSessionCategoryOptionMixWithOthers;
    sessionOption |= AVAudioSessionCategoryOptionAllowBluetooth;
    
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:sessionOption error:nil];
    [audioSession setMode:AVAudioSessionModeDefault error:nil];
    [audioSession setPreferredIOBufferDuration:preferredIOBufferDuration error:nil];
    NSError *error;
    BOOL success = [audioSession setActive:YES error:&error];
    if (!success) {
        NSLog(@"<Error> audioSession setActive:YES error:nil");
    }
    if (error) {
        NSLog(@"<Error> setUpAudioSessionWithSampleRate : %@", error.localizedDescription);
    }
#endif
    
    [self setupRemoteIOWithIOType:ioType];
}

#pragma mark - <Step 2, Set Up Audio Unit>
- (void)setupRemoteIOWithIOType:(IOUnitType)ioType {
#if TARGET_OS_IPHONE
    // AudioComponentDescription
    AudioComponentDescription remoteIODesc;
    remoteIODesc.componentType = kAudioUnitType_Output;
    remoteIODesc.componentSubType = ioType == IOUnitTypeVPIO ? kAudioUnitSubType_VoiceProcessingIO : kAudioUnitSubType_RemoteIO;
    remoteIODesc.componentManufacturer = kAudioUnitManufacturer_Apple;
    remoteIODesc.componentFlags = 0;
    remoteIODesc.componentFlagsMask = 0;
    AudioComponent remoteIOComponent = AudioComponentFindNext(NULL, &remoteIODesc);
    _error = AudioComponentInstanceNew(remoteIOComponent, &_remoteIOUnit);
    [self error:_error position:@"AudioComponentInstanceNew"];
#endif
    
    if (_audioCRMode == AudioCRModeExterCaptureSDKRender || _audioCRMode == AudioCRModeExterCaptureExterRender) {
        
#if !TARGET_OS_IPHONE
        AudioComponentDescription remoteIODesc;
        remoteIODesc.componentType = kAudioUnitType_Output;
        remoteIODesc.componentSubType = kAudioUnitSubType_HALOutput;
        remoteIODesc.componentManufacturer = kAudioUnitManufacturer_Apple;
        remoteIODesc.componentFlags = 0;
        remoteIODesc.componentFlagsMask = 0;
        AudioComponent remoteIOComponent = AudioComponentFindNext(NULL, &remoteIODesc);
        _error = AudioComponentInstanceNew(remoteIOComponent, &_remoteIOUnit);
        [self error:_error position:@"AudioComponentInstanceNew"];
        _error = AudioUnitInitialize(_remoteIOUnit);
        [self error:_error position:@"AudioUnitInitialize"];
#endif
        [self setupCapture];
    }
    
    if (_audioCRMode == AudioCRModeSDKCaptureExterRender || _audioCRMode == AudioCRModeExterCaptureExterRender) {
        
#if !TARGET_OS_IPHONE
        AudioComponentDescription macPlayDesc;
        macPlayDesc.componentType = kAudioUnitType_Output;
        macPlayDesc.componentSubType = kAudioUnitSubType_DefaultOutput;
        macPlayDesc.componentManufacturer = kAudioUnitManufacturer_Apple;
        macPlayDesc.componentFlags = 0;
        macPlayDesc.componentFlagsMask = 0;
        AudioComponent macPlayComponent = AudioComponentFindNext(NULL, &macPlayDesc);
        _error = AudioComponentInstanceNew(macPlayComponent, &_macPlayUnit);
        [self error:_error position:@"AudioComponentInstanceNew"];
        _error = AudioUnitInitialize(_macPlayUnit);
        [self error:_error position:@"AudioUnitInitialize"];
#endif
        [self setupRender];
    }

}

- (void)setupCapture {
    // EnableIO
    UInt32 one = 1;
    _error = AudioUnitSetProperty(_remoteIOUnit,
                                   kAudioOutputUnitProperty_EnableIO,
                                   kAudioUnitScope_Input,
                                   InputBus,
                                   &one,
                                   sizeof(one));
    [self error:_error position:@"kAudioOutputUnitProperty_EnableIO, kAudioUnitScope_Input"];

#if !TARGET_OS_IPHONE
    UInt32 disableFlag = 0;
    
    // Attention! set kAudioOutputUnitProperty_EnableIO, kAudioUnitScope_Output, disable
    _error = AudioUnitSetProperty(_remoteIOUnit,
                                  kAudioOutputUnitProperty_EnableIO,
                                  kAudioUnitScope_Output,
                                  OutputBus,
                                  &disableFlag,
                                  sizeof(disableFlag));
    [self error:_error position:@"kAudioOutputUnitProperty_EnableIO, kAudioUnitScope_Output"];
    
    AudioDeviceID defaultDevice = kAudioDeviceUnknown;
    UInt32 propertySize = sizeof(defaultDevice);
    AudioObjectPropertyAddress defaultDeviceProperty = {
        .mSelector = kAudioHardwarePropertyDefaultInputDevice,
        .mScope = kAudioObjectPropertyScopeInput,
        .mElement = kAudioObjectPropertyElementMaster
    };
    
    _error = AudioObjectGetPropertyData(kAudioObjectSystemObject,
                                        &defaultDeviceProperty,
                                        0,
                                        NULL,
                                        &propertySize,
                                        &defaultDevice);
    [self error:_error position:@"AudioObjectGetPropertyData, kAudioObjectSystemObject"];
    
    // Set the sample rate of the input device to the output samplerate (if possible)
    Float64 temp = _sampleRate;
    defaultDeviceProperty.mSelector = kAudioDevicePropertyNominalSampleRate;
    
    _error = AudioObjectSetPropertyData(defaultDevice,
                                        &defaultDeviceProperty,
                                        0,
                                        NULL,
                                        sizeof(Float64),
                                        &temp);
    [self error:_error position:@"AudioObjectSetPropertyData, defaultDeviceProperty"];
    
    // Set the input device to the system's default input device
    _error = AudioUnitSetProperty(_remoteIOUnit,
                                  kAudioOutputUnitProperty_CurrentDevice,
                                  kAudioUnitScope_Global,
                                  InputBus,
                                  &defaultDevice,
                                  sizeof(defaultDevice));
    [self error:_error position:@"kAudioOutputUnitProperty_CurrentDevice, kAudioUnitScope_Global"];
    
#endif
    
    // AudioStreamBasicDescription
    AudioStreamBasicDescription streamFormatDesc = [self signedIntegerStreamFormatDesc];
    _error = AudioUnitSetProperty(_remoteIOUnit,
                                   kAudioUnitProperty_StreamFormat,
                                   kAudioUnitScope_Output,
                                   InputBus,
                                   &streamFormatDesc,
                                   sizeof(streamFormatDesc));
    [self error:_error position:@"kAudioUnitProperty_StreamFormat, kAudioUnitScope_Output"];
    
    // CallBack
    AURenderCallbackStruct captureCallBackStruck;
    captureCallBackStruck.inputProcRefCon = (__bridge void * _Nullable)(self);
    captureCallBackStruck.inputProc = captureCallBack;
    
    _error = AudioUnitSetProperty(_remoteIOUnit,
                                  kAudioOutputUnitProperty_SetInputCallback,
                                  kAudioUnitScope_Global,
                                  InputBus,
                                  &captureCallBackStruck,
                                  sizeof(captureCallBackStruck));
    [self error:_error position:@"kAudioOutputUnitProperty_SetInputCallback"];
}

- (void)setupRender {
    
#if TARGET_OS_IPHONE
    // EnableIO
    UInt32 one = 1;
    _error = AudioUnitSetProperty(_remoteIOUnit,
                                  kAudioOutputUnitProperty_EnableIO,
                                  kAudioUnitScope_Output,
                                  OutputBus,
                                  &one,
                                  sizeof(one));
    [self error:_error position:@"kAudioOutputUnitProperty_EnableIO, kAudioUnitScope_Output"];
    
    // AudioStreamBasicDescription
    AudioStreamBasicDescription streamFormatDesc = [self signedIntegerStreamFormatDesc];
    _error = AudioUnitSetProperty(_remoteIOUnit,
                                  kAudioUnitProperty_StreamFormat,
                                  kAudioUnitScope_Input,
                                  OutputBus,
                                  &streamFormatDesc,
                                  sizeof(streamFormatDesc));
    [self error:_error position:@"kAudioUnitProperty_StreamFormat, kAudioUnitScope_Input"];
    
    // CallBack
    AURenderCallbackStruct renderCallback;
    renderCallback.inputProcRefCon = (__bridge void * _Nullable)(self);
    renderCallback.inputProc = renderCallBack;
    AudioUnitSetProperty(_remoteIOUnit,
                         kAudioUnitProperty_SetRenderCallback,
                         kAudioUnitScope_Input,
                         OutputBus,
                         &renderCallback,
                         sizeof(renderCallback));
    [self error:_error position:@"kAudioUnitProperty_SetRenderCallback"];
    
#else

    // AudioStreamBasicDescription
    AudioStreamBasicDescription streamFormatDesc = [self signedIntegerStreamFormatDesc];
    _error = AudioUnitSetProperty(_macPlayUnit,
                                  kAudioUnitProperty_StreamFormat,
                                  kAudioUnitScope_Input,
                                  OutputBus,
                                  &streamFormatDesc,
                                  sizeof(streamFormatDesc));
    [self error:_error position:@"kAudioUnitProperty_StreamFormat, kAudioUnitScope_Input"];
    
    // CallBack
    AURenderCallbackStruct renderCallback;
    renderCallback.inputProcRefCon = (__bridge void * _Nullable)(self);
    renderCallback.inputProc = renderCallBack;
    _error = AudioUnitSetProperty(_macPlayUnit,
                         kAudioUnitProperty_SetRenderCallback,
                         kAudioUnitScope_Input,
                         OutputBus,
                         &renderCallback,
                         sizeof(renderCallback));
    [self error:_error position:@"kAudioUnitProperty_SetRenderCallback"];
#endif
    
}

- (void)startWork {
#if TARGET_OS_IPHONE
    _error = AudioOutputUnitStart(_remoteIOUnit);
    [self error:_error position:@"AudioOutputUnitStart"];
#else
    if (_audioCRMode == AudioCRModeExterCaptureSDKRender || _audioCRMode == AudioCRModeExterCaptureExterRender) {
        _error = AudioOutputUnitStart(_remoteIOUnit);
        if (_error != noErr) {
            [self error:_error position:@"AudioOutputUnitStart"];
            return;
        }
    }
    
    if (self.audioCRMode == AudioCRModeExterCaptureExterRender || self.audioCRMode == AudioCRModeSDKCaptureExterRender) {
        _error = AudioOutputUnitStart(_macPlayUnit);
        [self error:_error position:@"AudioOutputUnitStart"];
    }
#endif
}

- (void)stopWork {
#if TARGET_OS_IPHONE
    AudioOutputUnitStop(_remoteIOUnit);
#else
    if (_audioCRMode == AudioCRModeExterCaptureSDKRender || _audioCRMode == AudioCRModeExterCaptureExterRender) {
        AudioOutputUnitStop(_remoteIOUnit);
    }
    
    if (self.audioCRMode == AudioCRModeExterCaptureExterRender || self.audioCRMode == AudioCRModeSDKCaptureExterRender) {
        AudioOutputUnitStop(_macPlayUnit);
    }
#endif
}

- (void)error:(OSStatus)error position:(NSString *)position {
    if (error != noErr) {
        NSString *errorInfo = [NSString stringWithFormat:@"<ACLog> Error: %d, Position: %@", (int)error, position];
        if ([self.delegate respondsToSelector:@selector(audioController:error:info:)]) {
            [self.delegate audioController:self error:error info:position];
        }
        NSLog(@"<OSStatus> :%@", errorInfo);
    }
}

- (AudioStreamBasicDescription)signedIntegerStreamFormatDesc {
    AudioStreamBasicDescription streamFormatDesc;
    streamFormatDesc.mSampleRate = _sampleRate;
    streamFormatDesc.mFormatID = kAudioFormatLinearPCM;
    streamFormatDesc.mFormatFlags = (kAudioFormatFlagIsSignedInteger | kAudioFormatFlagsNativeEndian | kAudioFormatFlagIsPacked);
    streamFormatDesc.mChannelsPerFrame = _channelCount;
    streamFormatDesc.mFramesPerPacket = 1;
    streamFormatDesc.mBitsPerChannel = 16;
    streamFormatDesc.mBytesPerFrame = streamFormatDesc.mBitsPerChannel / 8 * streamFormatDesc.mChannelsPerFrame;
    streamFormatDesc.mBytesPerPacket = streamFormatDesc.mBytesPerFrame * streamFormatDesc.mFramesPerPacket;
    
    return streamFormatDesc;
}

- (void)dealloc {
    if (_remoteIOUnit) {
        AudioOutputUnitStop(_remoteIOUnit);
        AudioComponentInstanceDispose(_remoteIOUnit);
        _remoteIOUnit = nil;
    }
    
#if !TARGET_OS_IPHONE
    if (_macPlayUnit) {
        AudioOutputUnitStop(_macPlayUnit);
        AudioComponentInstanceDispose(_macPlayUnit);
        _macPlayUnit = nil;
    }
#endif
    
    NSLog(@"<ACLog> AudioController dealloc");
}

@end
