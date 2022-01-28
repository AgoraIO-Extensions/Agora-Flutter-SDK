#import "SBVideoWriter.h"
#import <UIKit/UIKit.h>

NSErrorDomain const kVideoWriterErrorDomain = @"com.banuba.videoWriter";
NSInteger const kUnknownRecordingErrorCode = 1;
NSInteger const kNotEnoughSpaceForRecordingErrorCode = 2;

@implementation OutputSettings

- (instancetype)initWithOrientation:(UIDeviceOrientation)orientation
                         isMirrored:(BOOL)isMirrored
                     applyWatermark:(BOOL)applyWatermark
{
    self = [super init];
    if (self) {
        _deviceOrientation = orientation;
        _isMirrored = isMirrored;
        _applyWatermark = applyWatermark;
    }
    return self;
}

- (BOOL)shouldApplyVerticalFlip
{
    switch (_deviceOrientation) {
        // TODO: hardcoded fix for voice changer issue (lost video transform
        // after merging video track) only for portrait
        case UIDeviceOrientationPortrait:
            return false;
        case UIDeviceOrientationLandscapeLeft:
        case UIDeviceOrientationLandscapeRight:
            return _isMirrored;
        default:
            return true;
    }
}

- (BOOL)shouldApplyHorizontalFlip
{
    // TODO hardcoded fix for voice changer issue (lost video transform after merging video track)
    // only for portrait
    if (_deviceOrientation == UIDeviceOrientationPortrait) {
        return _isMirrored;
    }

    return (_deviceOrientation == UIDeviceOrientationPortraitUpsideDown) ? !_isMirrored : false;
}

- (CGAffineTransform)resultVideoTransform
{
    switch (_deviceOrientation) {
        case UIDeviceOrientationPortrait:
            // TODO hardcoded fix for voice changer issue (lost video transform after merging video track)
            // only for portrait
            return CGAffineTransformIdentity;
            //return _isMirrored ? CGAffineTransformMakeRotation(M_PI) : CGAffineTransformIdentity;
        case UIDeviceOrientationLandscapeLeft:
            return CGAffineTransformMakeRotation(M_PI_2);
        case UIDeviceOrientationLandscapeRight:
            return CGAffineTransformMakeRotation(-M_PI_2);
        default:
            return CGAffineTransformIdentity;
    }
}

- (UIImageOrientation)resultImageOrientation
{
    switch (_deviceOrientation) {
        case UIDeviceOrientationLandscapeLeft:
            return UIImageOrientationRight;
        case UIDeviceOrientationLandscapeRight:
            return UIImageOrientationLeft;
        default:
            return UIImageOrientationUp;
    }
}

@end

static const CGFloat kTimescale = 1000000000.0;
static const NSUInteger kLowDiskSpaceLimit = 209715200;                                                           // 200 Mb as minimal disk space limit
static const NSUInteger kDiskSpaceCheckTimeInterval = 5;                                                          // interval in seconds between checks for available disk space
static NSString* const kLowDiskSpaceRecordingErrorMsg = @"Video recording was terminated due to low disk space."; // TODO adjust text later
static NSString* const kUnknownRecordingErrorMsg = @"Video recording was terminated due to internal issues.";     // TODO adjust text later

@interface SBVideoWriter ()

@property(assign, nonatomic, readwrite) CMTime recorderVideoDuration;
@property(strong, nonatomic) NSMutableArray<NSValue*>* boundaryTimes;

@end

@implementation SBVideoWriter
{
    AVAssetWriter* _asset_writer;

    AVAssetWriterInput* _camera_input;
    AVAssetWriterInput* _microphone_input;

    AVAssetWriterInputPixelBufferAdaptor* _pixel_buff_adaptor;

    CGSize _captureSize;
    OutputSettings* _settings;

    CMTime _startTime;
    CMTime _nextNotifyProgressTime;
    BOOL _isRealtime;

    NSDate* _diskSpaceCheckTime;
    BOOL _errorOccurred;

    NSUInteger _audio_frames_cnt;
    NSUInteger _video_frames_cnt;

    void (^_completionHandler)(BOOL, NSError*);
    void (^_progressBlock)(CMTime);
    void (^_boundaryBlock)(CMTime);
    void (^_limitReachedBlock)(void);
    CMTime _maxDuration;
    dispatch_once_t onceToken;
    CMTime _periodicProgressUpdateTime;
    CMTime _deltaFrameRate;
    BOOL isLimitReached;
}

- (instancetype)initWithSize:(CGSize)size outputSettings:(OutputSettings*)settings
{
    self = [super init];
    if (self != nil) {
        // AVAssetWriter can't properly handle frames with uneven resolution, so we manually adjust it here,
        // otherwise green outline will appear on created video.
        CGFloat width = ((int) size.width % 2 == 0) ? size.width : size.width - 1;
        CGFloat height = ((int) size.height % 2 == 0) ? size.height : size.height - 1;

        _captureSize = CGSizeMake(width, height);
        _errorOccurred = false;
        _periodicProgressUpdateTime = kCMTimeZero;
        _maxDuration = kCMTimeIndefinite;
        _deltaFrameRate = CMTimeMake(1, 30);
        _settings = settings;
    }

    return self;
}

- (void)dealloc
{
    NSLog(@"DEALLOC WIDEO WRITER");
}

- (void)startCapturingScreenWithUrl:(NSURL*)fileUrl
                           progress:(void (^)(CMTime))progress
       periodicProgressTimeInterval:(NSTimeInterval)periodicProgressTimeInterval
                      boundaryTimes:(NSArray<NSValue*>*)boundaryTimes
                    boundaryHandler:(void (^)(CMTime))boundaryHandler
                      totalDuration:(NSTimeInterval)totalDuration
                limitReachedHandler:(void (^)(void))limitReachedHandler
                         completion:(void (^)(BOOL, NSError*))completionHandler
{
    [self prepareInputs:fileUrl];
    [self startCapturingScreenWithProgress:progress
              periodicProgressTimeInterval:periodicProgressTimeInterval
                             boundaryTimes:boundaryTimes
                           boundaryHandler:boundaryHandler
                             totalDuration:totalDuration
                       limitReachedHandler:limitReachedHandler
                                completion:completionHandler];
}

- (void)startCapturingScreenWithProgress:(void (^)(CMTime))progress
            periodicProgressTimeInterval:(NSTimeInterval)periodicProgressTimeInterval
                           boundaryTimes:(NSArray<NSValue*>*)boundaryTimes
                         boundaryHandler:(void (^)(CMTime))boundaryHandler
                           totalDuration:(NSTimeInterval)totalDuration
                     limitReachedHandler:(void (^)(void))limitReachedHandler
                              completion:(void (^)(BOOL, NSError*))completionHandler
{
    _completionHandler = [completionHandler copy];
    _progressBlock = [progress copy];
    self.boundaryTimes = [boundaryTimes mutableCopy];
    _boundaryBlock = [boundaryHandler copy];
    _limitReachedBlock = [limitReachedHandler copy];
    _periodicProgressUpdateTime = CMTimeMakeWithSeconds(periodicProgressTimeInterval, kTimescale);

    if (totalDuration > 0) {
        CMTime maximumTime = CMTimeMakeWithSeconds(totalDuration, kTimescale);
        ;
        CMTime maximumWithDelta = CMTimeAdd(maximumTime, _deltaFrameRate);
        _maxDuration = maximumWithDelta;
    }

    [self startCapturing];
}

- (void)pushAudioSampleBuffer:(CMSampleBufferRef)buffer
{
    if (_errorOccurred || _microphone_input == nil) {
        return;
    }

    NSError* error = nil;
    if (![self isRecordingProcessAvailable:&error]) {
        [self terminateCapturingWithError:error];
        return;
    }

    if ([_microphone_input isReadyForMoreMediaData]) {
        if (_startTime.value == 0) {
            NSLog(@"Warning: audio buffer skipped!");
            return;
        }

        BOOL success = [_microphone_input appendSampleBuffer:buffer];
        if (success) {
            _audio_frames_cnt++;
        } else {
            [self terminateCapturingWithError:[self.class errorWithMessage:kUnknownRecordingErrorMsg]];
        }
    } else {
        NSLog(@"Error: audio buffer dropped!");
    }
}

- (void)pushVideoSampleBuffer:(CVPixelBufferRef)buffer
{
    if (_errorOccurred) {
        return;
    }

    NSError* error = nil;
    if (![self isRecordingProcessAvailable:&error]) {
        [self terminateCapturingWithError:error];
        return;
    }

    if (![_camera_input isReadyForMoreMediaData]) {
        NSLog(@"Error: video frame dropped!");
    } else {
        CFTimeInterval currentTime = CACurrentMediaTime();
        CMTime time = CMTimeMake(currentTime * kTimescale, kTimescale);
        dispatch_once(&onceToken, ^{
          self->_startTime = time;
          self->_nextNotifyProgressTime = time;
          [self->_asset_writer startSessionAtSourceTime:self->_startTime];
        });


        CMTime futureDuration = CMTimeSubtract(time, self->_startTime);
        BOOL needToRecord = CMTimeCompare(futureDuration, _maxDuration) <= 0;

        if (needToRecord) {
            BOOL success = [_pixel_buff_adaptor appendPixelBuffer:buffer withPresentationTime:time];
            if (success) {
                self.recorderVideoDuration = CMTimeSubtract(time, self->_startTime);
                [self notifyProgressIfNeededWith:time];
                _video_frames_cnt++;
            } else {
                [self terminateCapturingWithError:[self.class errorWithMessage:kUnknownRecordingErrorMsg]];
            }
        } else {
            [self notifyProgressIfNeededWith:time];

            if (_limitReachedBlock) {
                _limitReachedBlock();
            }
        }
    }
}

- (void)notifyProgressIfNeededWith:(CMTime)time
{
    BOOL needToNotify = (_progressBlock != nil && CMTimeCompare(time, _nextNotifyProgressTime) >= 0);

    CMTime boundaryNotifyTime = kCMTimeInvalid;
    NSInteger boundaryTimeIndexToRemove = -1;

    for (NSInteger i = 0; i < self.boundaryTimes.count; i++) {
        CMTime boundaryTime = [self.boundaryTimes[i] CMTimeValue];

        if (CMTimeCompare(boundaryTime, self.recorderVideoDuration) <= 0) {
            boundaryTimeIndexToRemove = i;
            boundaryNotifyTime = boundaryTime;
        }
    }

    if (CMTIME_IS_VALID(boundaryNotifyTime)) {
        if (boundaryTimeIndexToRemove >= 0 && self.boundaryTimes.count > 0) {
            [self.boundaryTimes removeObjectAtIndex:boundaryTimeIndexToRemove];
        }

        if (_boundaryBlock) {
            _boundaryBlock(boundaryNotifyTime);
        }
    }

    if (needToNotify) {
        _progressBlock(self.recorderVideoDuration);
        _nextNotifyProgressTime = CMTimeAdd(_nextNotifyProgressTime, _periodicProgressUpdateTime);
    }
}

- (void)prepareInputs:(NSURL*)fileUrl
{
    NSError* error = nil;
    _asset_writer = [[AVAssetWriter alloc] initWithURL:fileUrl
                                              fileType:AVFileTypeQuickTimeMovie
                                                 error:&error];
    _asset_writer.shouldOptimizeForNetworkUse = NO;
    NSParameterAssert(error == nil);
    NSParameterAssert(_asset_writer);

    CFTimeInterval currentTime = CACurrentMediaTime();
    CMTime time = CMTimeMake(currentTime * kTimescale, kTimescale);
    if (!CMTIME_IS_VALID(time) || CMTIME_IS_INDEFINITE(time) || !CMTIME_IS_NUMERIC(time)) {
        NSParameterAssert(false);
    }
    NSLog(@"INITIALIZE INPUTS");
    [self setupAssetWriterVideoInput];
    [self setupAssetWriterAudioInput];

    [self bindVideoInput];
    [self bindAudioInput];
}

- (void)startCapturing
{
    _diskSpaceCheckTime = [NSDate date];
    [_asset_writer startWriting];

    NSLog(@"Recording started");
}

- (void)stopCapturing
{
    [self terminateCapturingWithError:nil];
}

- (void)terminateCapturingWithError:(NSError*)error
{
    if (error != nil) {
        _errorOccurred = YES;
    }
    NSLog(@"terminateCapturingWithErrorMessage - %@", error.localizedDescription);
    if (_microphone_input != nil) {
        [_microphone_input markAsFinished];
        NSLog(@"microphone_input finished");
    }

    if (_camera_input != nil) {
        [_camera_input markAsFinished];
        NSLog(@"camera_input finished");
    }

    // TODO: Move mimimal frames logic to client side
    AVAssetWriterStatus st = _asset_writer.status;

    // TODO: ignore when microphone is off
    BOOL isValid = _video_frames_cnt > 0 && (error == nil);

    if (st != AVAssetWriterStatusUnknown) {
        dispatch_group_t group = dispatch_group_create();
        dispatch_group_enter(group);
        __weak typeof(self) weakSelf = self;
        [_asset_writer finishWritingWithCompletionHandler:^{
          __strong typeof(self) strongSelf = weakSelf;
          [strongSelf freeInputs];
          [strongSelf callCompletion:isValid errorDescription:error];
          dispatch_group_leave(group);
        }];
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    } else {
        [self callCompletion:isValid errorDescription:error];
    }
}

- (void)callCompletion:(BOOL)isValid errorDescription:(NSError*)error
{
    if (_completionHandler) {
        _completionHandler(isValid, error);
        _completionHandler = nil;
    }
}

- (void)freeInputs
{
    _microphone_input = nil;
    _camera_input = nil;
}

- (void)discardCapturing
{
    _completionHandler = nil;
    [self stopCapturing];
}

+ (BOOL)isEnoughDiskSpaceForRecording
{
    NSError* error = nil;
    uint64_t currentAvailableDiskSpace = [self bnb_deviceFreeDiskspaceInBytes:&error];
    return (error == nil) ? (currentAvailableDiskSpace > kLowDiskSpaceLimit) : YES;
}

+ (NSUInteger)bnb_deviceFreeDiskspaceInBytes:(NSError**)pError
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary* dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:paths.lastObject error:pError];

    if (dictionary) {
        NSNumber* freeFileSystemSizeInBytes = dictionary[NSFileSystemFreeSize];
        return freeFileSystemSizeInBytes.unsignedLongLongValue;
    }

    return 0;
}

+ (NSError*)errorWithMessage:(NSString*)message
{
    return [NSError errorWithDomain:kVideoWriterErrorDomain
                               code:kUnknownRecordingErrorCode
                           userInfo:@{NSLocalizedDescriptionKey: message}];
}

#pragma mark - private methods

- (BOOL)isRecordingProcessAvailable:(NSError**)error
{
    if (_asset_writer.status == AVAssetWriterStatusFailed) {
        if (error != nil) {
            *error = _asset_writer.error;
        }
        return NO;
    }

    NSDate* currentDate = [NSDate date];
    NSTimeInterval intervalSinceLastCheck = [currentDate timeIntervalSinceDate:_diskSpaceCheckTime];
    if (intervalSinceLastCheck > kDiskSpaceCheckTimeInterval) {
        _diskSpaceCheckTime = currentDate;
        if (![SBVideoWriter isEnoughDiskSpaceForRecording]) {
            *error = [NSError errorWithDomain:kVideoWriterErrorDomain
                                         code:kNotEnoughSpaceForRecordingErrorCode
                                     userInfo:@{NSLocalizedDescriptionKey: kLowDiskSpaceRecordingErrorMsg}];
            return NO;
        }
    }

    return YES;
}

- (void)setupAssetWriterAudioInput
{
    AudioChannelLayout acl;
    bzero(&acl, sizeof(acl));
    acl.mChannelLayoutTag = kAudioChannelLayoutTag_Mono;
    NSDictionary* audioOutputSettings = @{
        AVFormatIDKey: @(kAudioFormatMPEG4AAC),
        AVNumberOfChannelsKey: @(1),
        AVSampleRateKey: @(44100.0),
        AVChannelLayoutKey: [NSData dataWithBytes:&acl length:sizeof(AudioChannelLayout)],
        AVEncoderBitRateKey: @(64000)
    };
    _microphone_input = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeAudio outputSettings:audioOutputSettings];
    _microphone_input.expectsMediaDataInRealTime = YES;

    NSParameterAssert(_microphone_input);
}

- (void)setupAssetWriterVideoInput
{
    NSDictionary* videoSettings = @{
        AVVideoCodecKey: AVVideoCodecH264,
        AVVideoWidthKey: @(_captureSize.width),
        AVVideoHeightKey: @(_captureSize.height)
    };

    _camera_input = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo outputSettings:videoSettings];
    _camera_input.expectsMediaDataInRealTime = YES;
    _camera_input.transform = _settings.resultVideoTransform;

    NSDictionary* pixelBufferAdaptorSettings = @{
        (__bridge NSString*) kCVPixelBufferWidthKey: @(_captureSize.width),
        (__bridge NSString*) kCVPixelBufferHeightKey: @(_captureSize.height),
        (__bridge NSString*) kCVPixelBufferPixelFormatTypeKey: @(kCVPixelFormatType_32BGRA),
    };
    _pixel_buff_adaptor = [AVAssetWriterInputPixelBufferAdaptor assetWriterInputPixelBufferAdaptorWithAssetWriterInput:_camera_input
                                                                                           sourcePixelBufferAttributes:pixelBufferAdaptorSettings];
    NSParameterAssert(_camera_input);
}

- (void)bindVideoInput
{
    NSParameterAssert([_asset_writer canAddInput:_camera_input]);
    [_asset_writer addInput:_camera_input];
}

- (void)bindAudioInput
{
    NSParameterAssert([_asset_writer canAddInput:_microphone_input]);
    [_asset_writer addInput:_microphone_input];
}

@end
