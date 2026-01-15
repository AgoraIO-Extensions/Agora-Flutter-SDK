#import "AgoraRTEController.h"
#import "AgoraRTE.h"
#import "AgoraRTEConfig.h"
#import "AgoraRTEPlayer.h"
#import "AgoraRTECanvas.h"
#import "AgoraRTECommon.h"

#pragma mark - AgoraRTEController Private

@interface AgoraRTEController ()
@property (nonatomic, strong, readwrite) AgoraRTE *rte;
@property (nonatomic, strong, readwrite) AgoraRTEConfig *rteConfig;
@property (nonatomic, strong, readwrite) AgoraRTEPlayer *rtePlayer;
@property (nonatomic, strong, readwrite) AgoraRTECanvas *rteCanvas;
@end

#pragma mark - AgoraRTEController Implementation

@implementation AgoraRTEController

- (instancetype)init {
    self = [super init];
    if (self) {
        _rte = [[AgoraRTE alloc] init];
        _rteConfig = nil;
        _rtePlayer = nil;
        _rteCanvas = nil;
    }
    return self;
}

#pragma mark - RTE Lifecycle

- (BOOL)createRteFromBridge:(NSError **)error {
    BOOL success = [self.rte getFromBridge:error];
    if (success && self.rte.rteInstance) {
        self.rteConfig = [[AgoraRTEConfig alloc] initWithRte:self.rte.rteInstance];
        self.rtePlayer = [[AgoraRTEPlayer alloc] initWithRte:self.rte.rteInstance];
        self.rteCanvas = [[AgoraRTECanvas alloc] initWithRte:self.rte.rteInstance];
        self.rtePlayer.observerDelegate = self.playerObserverDelegate;
    }
    return success;
}

- (BOOL)createRteWithConfig:(NSDictionary *)config error:(NSError **)error {
    BOOL success = [self.rte createWithConfig:config error:error];
    if (success && self.rte.rteInstance) {
        self.rteConfig = [[AgoraRTEConfig alloc] initWithRte:self.rte.rteInstance];
        self.rtePlayer = [[AgoraRTEPlayer alloc] initWithRte:self.rte.rteInstance];
        self.rteCanvas = [[AgoraRTECanvas alloc] initWithRte:self.rte.rteInstance];
        self.rtePlayer.observerDelegate = self.playerObserverDelegate;
    }
    return success;
}

- (BOOL)initMediaEngine:(void (^)(NSError *error))completion error:(NSError **)error {
    return [self.rte initMediaEngine:completion error:error];
}

- (BOOL)destroyRte:(NSError **)error {
    // Destroy all players and canvases first
    if (self.rtePlayer) {
        for (NSString *playerId in [self.rtePlayer.players allKeys]) {
            [self.rtePlayer destroyPlayer:playerId error:nil];
        }
    }
    if (self.rteCanvas) {
        for (NSString *canvasId in [self.rteCanvas.canvases allKeys]) {
            [self.rteCanvas destroyCanvas:canvasId error:nil];
        }
    }
    
    BOOL success = [self.rte destroy:error];
    if (success) {
        self.rteConfig = nil;
        self.rtePlayer = nil;
        self.rteCanvas = nil;
    }
    return success;
}

#pragma mark - RTE Config

- (BOOL)setRteConfig:(NSDictionary *)config error:(NSError **)error {
    if (!self.rteConfig) {
        if (error) *error = RTE_NSERROR(-1, @"RTE config not initialized");
        return NO;
    }
    return [self.rte setConfigs:config error:error];
}

- (NSDictionary *)getRteConfig:(NSError **)error {
    if (!self.rteConfig) {
        if (error) *error = RTE_NSERROR(-1, @"RTE config not initialized");
        return nil;
    }
    return [self.rte getConfigs:error];
}
- (NSString *)appId:(NSError **)error {
    if (!self.rteConfig) {
        if (error) *error = RTE_NSERROR(-1, @"RTE config not initialized");
        return nil;
    }
    return [self.rteConfig appId:error];
}

- (NSString *)logFolder:(NSError **)error {
    if (!self.rteConfig) {
        if (error) *error = RTE_NSERROR(-1, @"RTE config not initialized");
        return nil;
    }
    return [self.rteConfig logFolder:error];
}

- (NSNumber *)logFileSize:(NSError **)error {
    if (!self.rteConfig) {
        if (error) *error = RTE_NSERROR(-1, @"RTE config not initialized");
        return nil;
    }
    return [self.rteConfig logFileSize:error];
}

- (NSNumber *)areaCode:(NSError **)error {
    if (!self.rteConfig) {
        if (error) *error = RTE_NSERROR(-1, @"RTE config not initialized");
        return nil;
    }
    return [self.rteConfig areaCode:error];
}

- (NSString *)cloudProxy:(NSError **)error {
    if (!self.rteConfig) {
        if (error) *error = RTE_NSERROR(-1, @"RTE config not initialized");
        return nil;
    }
    return [self.rteConfig cloudProxy:error];
}

- (NSString *)jsonParameter:(NSError **)error {
    if (!self.rteConfig) {
        if (error) *error = RTE_NSERROR(-1, @"RTE config not initialized");
        return nil;
    }
    return [self.rteConfig jsonParameter:error];
}

// RTE Config Setters
- (BOOL)setAppId:(NSString *)appId error:(NSError **)error {
    if (!self.rteConfig) {
        if (error) *error = RTE_NSERROR(-1, @"RTE config not initialized");
        return NO;
    }
    return [self.rteConfig setAppId:appId error:error];
}

- (BOOL)setLogFolder:(NSString *)logFolder error:(NSError **)error {
    if (!self.rteConfig) {
        if (error) *error = RTE_NSERROR(-1, @"RTE config not initialized");
        return NO;
    }
    return [self.rteConfig setLogFolder:logFolder error:error];
}

- (BOOL)setLogFileSize:(NSNumber *)logFileSize error:(NSError **)error {
    if (!self.rteConfig) {
        if (error) *error = RTE_NSERROR(-1, @"RTE config not initialized");
        return NO;
    }
    return [self.rteConfig setLogFileSize:logFileSize error:error];
}

- (BOOL)setAreaCode:(NSNumber *)areaCode error:(NSError **)error {
    if (!self.rteConfig) {
        if (error) *error = RTE_NSERROR(-1, @"RTE config not initialized");
        return NO;
    }
    return [self.rteConfig setAreaCode:areaCode error:error];
}

- (BOOL)setCloudProxy:(NSString *)cloudProxy error:(NSError **)error {
    if (!self.rteConfig) {
        if (error) *error = RTE_NSERROR(-1, @"RTE config not initialized");
        return NO;
    }
    return [self.rteConfig setCloudProxy:cloudProxy error:error];
}

- (BOOL)setJsonParameter:(NSString *)jsonParameter error:(NSError **)error {
    if (!self.rteConfig) {
        if (error) *error = RTE_NSERROR(-1, @"RTE config not initialized");
        return NO;
    }
    return [self.rteConfig setJsonParameter:jsonParameter error:error];
}

#pragma mark - RTE Observer

- (BOOL)registerRteObserver:(NSError **)error {
    // RTE Observer functionality is not yet implemented in the separated classes
    // This method is kept for backward compatibility but does nothing
    return YES;
}

- (BOOL)unregisterRteObserver:(NSError **)error {
    // RTE Observer functionality is not yet implemented in the separated classes
    // This method is kept for backward compatibility but does nothing
    return YES;
}


#pragma mark - RTE Player Lifecycle

+ (BOOL)preloadWithUrl:(NSString *)url error:(NSError **)error {
    return [AgoraRTEPlayer preloadWithUrl:url error:error];
}

- (NSString *)createPlayer:(NSDictionary *)config error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return nil;
    }
    return [self.rtePlayer createPlayer:config error:error];
}

- (BOOL)destroyPlayer:(NSString *)playerId error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return NO;
    }
    return [self.rtePlayer destroyPlayer:playerId error:error];
}

#pragma mark - RTE Player Playback Control

- (BOOL)playerOpenUrl:(NSString *)playerId url:(NSString *)url startTime:(uint64_t)startTime completion:(void (^)(NSError *error))completion error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return NO;
    }
    return [self.rtePlayer openUrl:playerId url:url startTime:startTime completion:completion error:error];
}

- (BOOL)playerOpenWithCustomSourceProvider:(NSString *)playerId provider:(void *)provider startTime:(uint64_t)startTime completion:(void (^)(NSError *error))completion error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return NO;
    }
    return [self.rtePlayer openWithCustomSourceProvider:playerId provider:provider startTime:startTime completion:completion error:error];
}

- (BOOL)playerOpenWithStream:(NSString *)playerId stream:(void *)stream completion:(void (^)(NSError *error))completion error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return NO;
    }
    return [self.rtePlayer openWithStream:playerId stream:stream completion:completion error:error];
}

- (BOOL)playerPlay:(NSString *)playerId error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return NO;
    }
    return [self.rtePlayer play:playerId error:error];
}

- (BOOL)playerPause:(NSString *)playerId error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return NO;
    }
    return [self.rtePlayer pause:playerId error:error];
}

- (BOOL)playerStop:(NSString *)playerId error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return NO;
    }
    return [self.rtePlayer stop:playerId error:error];
}

- (BOOL)playerSeek:(NSString *)playerId position:(uint64_t)position error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return NO;
    }
    return [self.rtePlayer seek:playerId position:position error:error];
}

- (BOOL)playerMuteAudio:(NSString *)playerId mute:(BOOL)mute error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return NO;
    }
    return [self.rtePlayer muteAudio:playerId mute:mute error:error];
}

- (BOOL)playerMuteVideo:(NSString *)playerId mute:(BOOL)mute error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return NO;
    }
    return [self.rtePlayer muteVideo:playerId mute:mute error:error];
}

- (BOOL)playerSwitch:(NSString *)playerId url:(NSString *)url syncPts:(BOOL)syncPts completion:(void (^)(NSError *error))completion error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return NO;
    }
    return [self.rtePlayer switchWithUrl:playerId url:url syncPts:syncPts completion:completion error:error];
}

- (BOOL)playerSetPlaybackSpeed:(NSString *)playerId speed:(int32_t)speed error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return NO;
    }
    return [self.rtePlayer setPlaybackSpeed:playerId speed:speed error:error];
}

- (int32_t)playerGetPlaybackSpeed:(NSString *)playerId error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return 0;
    }
    return [self.rtePlayer getPlaybackSpeed:playerId error:error];
}

- (BOOL)playerSetPlayoutVolume:(NSString *)playerId volume:(int32_t)volume error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return NO;
    }
    return [self.rtePlayer setPlayoutVolume:playerId volume:volume error:error];
}

- (int32_t)playerGetPlayoutVolume:(NSString *)playerId error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return 0;
    }
    return [self.rtePlayer getPlayoutVolume:playerId error:error];
}

- (BOOL)playerSetLoopCount:(NSString *)playerId count:(int32_t)count error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return NO;
    }
    return [self.rtePlayer setLoopCount:playerId count:count error:error];
}

- (int32_t)playerGetLoopCount:(NSString *)playerId error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return 0;
    }
    return [self.rtePlayer getLoopCount:playerId error:error];
}

// RTE Player Config - Additional Setters/Getters
- (BOOL)playerSetAutoPlay:(NSString *)playerId autoPlay:(BOOL)autoPlay error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return NO;
    }
    return [self.rtePlayer setAutoPlay:playerId autoPlay:autoPlay error:error];
}

- (BOOL)playerGetAutoPlay:(NSString *)playerId error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return NO;
    }
    return [self.rtePlayer getAutoPlay:playerId error:error];
}

- (BOOL)playerSetPlayoutAudioTrackIdx:(NSString *)playerId idx:(int32_t)idx error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return NO;
    }
    return [self.rtePlayer setPlayoutAudioTrackIdx:playerId idx:idx error:error];
}

- (int32_t)playerGetPlayoutAudioTrackIdx:(NSString *)playerId error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return 0;
    }
    return [self.rtePlayer getPlayoutAudioTrackIdx:playerId error:error];
}

- (BOOL)playerSetPublishAudioTrackIdx:(NSString *)playerId idx:(int32_t)idx error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return NO;
    }
    return [self.rtePlayer setPublishAudioTrackIdx:playerId idx:idx error:error];
}

- (int32_t)playerGetPublishAudioTrackIdx:(NSString *)playerId error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return 0;
    }
    return [self.rtePlayer getPublishAudioTrackIdx:playerId error:error];
}

- (BOOL)playerSetAudioTrackIdx:(NSString *)playerId idx:(int32_t)idx error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return NO;
    }
    return [self.rtePlayer setAudioTrackIdx:playerId idx:idx error:error];
}

- (int32_t)playerGetAudioTrackIdx:(NSString *)playerId error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return 0;
    }
    return [self.rtePlayer getAudioTrackIdx:playerId error:error];
}

- (BOOL)playerSetSubtitleTrackIdx:(NSString *)playerId idx:(int32_t)idx error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return NO;
    }
    return [self.rtePlayer setSubtitleTrackIdx:playerId idx:idx error:error];
}

- (int32_t)playerGetSubtitleTrackIdx:(NSString *)playerId error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return 0;
    }
    return [self.rtePlayer getSubtitleTrackIdx:playerId error:error];
}

- (BOOL)playerSetExternalSubtitleTrackIdx:(NSString *)playerId idx:(int32_t)idx error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return NO;
    }
    return [self.rtePlayer setExternalSubtitleTrackIdx:playerId idx:idx error:error];
}

- (int32_t)playerGetExternalSubtitleTrackIdx:(NSString *)playerId error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return 0;
    }
    return [self.rtePlayer getExternalSubtitleTrackIdx:playerId error:error];
}

- (BOOL)playerSetAudioPitch:(NSString *)playerId pitch:(int32_t)pitch error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return NO;
    }
    return [self.rtePlayer setAudioPitch:playerId pitch:pitch error:error];
}

- (int32_t)playerGetAudioPitch:(NSString *)playerId error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return 0;
    }
    return [self.rtePlayer getAudioPitch:playerId error:error];
}

- (BOOL)playerSetAudioPlaybackDelay:(NSString *)playerId delay:(int32_t)delay error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return NO;
    }
    return [self.rtePlayer setAudioPlaybackDelay:playerId delay:delay error:error];
}

- (int32_t)playerGetAudioPlaybackDelay:(NSString *)playerId error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return 0;
    }
    return [self.rtePlayer getAudioPlaybackDelay:playerId error:error];
}

- (BOOL)playerSetAudioDualMonoMode:(NSString *)playerId mode:(int32_t)mode error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return NO;
    }
    return [self.rtePlayer setAudioDualMonoMode:playerId mode:mode error:error];
}

- (int32_t)playerGetAudioDualMonoMode:(NSString *)playerId error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return 0;
    }
    return [self.rtePlayer getAudioDualMonoMode:playerId error:error];
}

- (BOOL)playerSetPublishVolume:(NSString *)playerId volume:(int32_t)volume error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return NO;
    }
    return [self.rtePlayer setPublishVolume:playerId volume:volume error:error];
}

- (int32_t)playerGetPublishVolume:(NSString *)playerId error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return 0;
    }
    return [self.rtePlayer getPublishVolume:playerId error:error];
}

- (BOOL)playerSetJsonParameter:(NSString *)playerId jsonParameter:(NSString *)jsonParameter error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return NO;
    }
    return [self.rtePlayer setJsonParameter:playerId jsonParameter:jsonParameter error:error];
}

- (NSString *)playerGetJsonParameter:(NSString *)playerId error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return nil;
    }
    return [self.rtePlayer getJsonParameter:playerId error:error];
}

- (BOOL)playerSetAbrSubscriptionLayer:(NSString *)playerId layer:(AgoraRteAbrSubscriptionLayer)layer error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return NO;
    }
    return [self.rtePlayer setAbrSubscriptionLayer:playerId layer:layer error:error];
}

- (AgoraRteAbrSubscriptionLayer)playerGetAbrSubscriptionLayer:(NSString *)playerId error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return AgoraRteAbrSubscriptionHigh;
    }
    return [self.rtePlayer getAbrSubscriptionLayer:playerId error:error];
}

- (BOOL)playerSetAbrFallbackLayer:(NSString *)playerId layer:(AgoraRteAbrFallbackLayer)layer error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return NO;
    }
    return [self.rtePlayer setAbrFallbackLayer:playerId layer:layer error:error];
}

- (AgoraRteAbrFallbackLayer)playerGetAbrFallbackLayer:(NSString *)playerId error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return AgoraRteAbrFallbackLow;
    }
    return [self.rtePlayer getAbrFallbackLayer:playerId error:error];
}

#pragma mark - RTE Player Info

- (void)playerGetStats:(NSString *)playerId completion:(void (^)(NSDictionary *stats, NSError *error))completion {
    if (!self.rtePlayer) {
        if (completion) completion(nil, RTE_NSERROR(-1, @"RTE player not initialized"));
        return;
    }
    [self.rtePlayer getStats:playerId completion:completion];
}

- (int64_t)playerGetCurrentTime:(NSString *)playerId error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return 0;
    }
    return [self.rtePlayer getCurrentTime:playerId error:error];
}

- (int64_t)playerGetDuration:(NSString *)playerId error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return 0;
    }
    return [self.rtePlayer getDuration:playerId error:error];
}

- (NSDictionary *)playerGetInfo:(NSString *)playerId error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return nil;
    }
    return [self.rtePlayer getInfo:playerId error:error];
}

#pragma mark - RTE Player Config

- (BOOL)playerSetConfig:(NSString *)playerId config:(NSDictionary *)config error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return NO;
    }
    return [self.rtePlayer setConfigs:playerId config:config error:error];
}

- (NSDictionary *)playerGetConfig:(NSString *)playerId error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return nil;
    }
    return [self.rtePlayer getConfigs:playerId error:error];
}

#pragma mark - RTE Player Observer

- (BOOL)playerRegisterObserver:(NSString *)playerId error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return NO;
    }
    return [self.rtePlayer registerObserver:playerId error:error];
}

- (BOOL)playerUnregisterObserver:(NSString *)playerId error:(NSError **)error {
    if (!self.rtePlayer) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player not initialized");
        return NO;
    }
    return [self.rtePlayer unregisterObserver:playerId error:error];
}

#pragma mark - RTE Canvas Lifecycle

- (NSString *)createCanvas:(NSDictionary *)config error:(NSError **)error {
    if (!self.rteCanvas) {
        if (error) *error = RTE_NSERROR(-1, @"RTE canvas not initialized");
        return nil;
    }
    return [self.rteCanvas createCanvas:config error:error];
}

- (BOOL)destroyCanvas:(NSString *)canvasId error:(NSError **)error {
    if (!self.rteCanvas) {
        if (error) *error = RTE_NSERROR(-1, @"RTE canvas not initialized");
        return NO;
    }
    return [self.rteCanvas destroyCanvas:canvasId error:error];
}

#pragma mark - RTE Canvas Config

- (BOOL)canvasSetConfig:(NSString *)canvasId config:(NSDictionary *)config error:(NSError **)error {
    if (!self.rteCanvas) {
        if (error) *error = RTE_NSERROR(-1, @"RTE canvas not initialized");
        return NO;
    }
    return [self.rteCanvas setConfigs:canvasId config:config error:error];
}

- (NSDictionary *)canvasGetConfig:(NSString *)canvasId error:(NSError **)error {
    if (!self.rteCanvas) {
        if (error) *error = RTE_NSERROR(-1, @"RTE canvas not initialized");
        return nil;
    }
    return [self.rteCanvas getConfigs:canvasId error:error];
}

- (BOOL)canvasSetVideoRenderMode:(NSString *)canvasId mode:(AgoraRteVideoRenderMode)mode error:(NSError **)error {
    if (!self.rteCanvas) {
        if (error) *error = RTE_NSERROR(-1, @"RTE canvas not initialized");
        return NO;
    }
    return [self.rteCanvas setVideoRenderMode:canvasId mode:mode error:error];
}

- (AgoraRteVideoRenderMode)canvasGetVideoRenderMode:(NSString *)canvasId error:(NSError **)error {
    if (!self.rteCanvas) {
        if (error) *error = RTE_NSERROR(-1, @"RTE canvas not initialized");
        return AgoraRteVideoRenderModeHidden;
    }
    return [self.rteCanvas getVideoRenderMode:canvasId error:error];
}

- (BOOL)canvasSetVideoMirrorMode:(NSString *)canvasId mode:(AgoraRteVideoMirrorMode)mode error:(NSError **)error {
    if (!self.rteCanvas) {
        if (error) *error = RTE_NSERROR(-1, @"RTE canvas not initialized");
        return NO;
    }
    return [self.rteCanvas setVideoMirrorMode:canvasId mode:mode error:error];
}

- (AgoraRteVideoMirrorMode)canvasGetVideoMirrorMode:(NSString *)canvasId error:(NSError **)error {
    if (!self.rteCanvas) {
        if (error) *error = RTE_NSERROR(-1, @"RTE canvas not initialized");
        return AgoraRteVideoMirrorModeDisabled;
    }
    return [self.rteCanvas getVideoMirrorMode:canvasId error:error];
}

- (BOOL)canvasSetCropArea:(NSString *)canvasId x:(int32_t)x y:(int32_t)y width:(int32_t)width height:(int32_t)height error:(NSError **)error {
    if (!self.rteCanvas) {
        if (error) *error = RTE_NSERROR(-1, @"RTE canvas not initialized");
        return NO;
    }
    return [self.rteCanvas setCropArea:canvasId x:x y:y width:width height:height error:error];
}

- (NSDictionary *)canvasGetCropArea:(NSString *)canvasId error:(NSError **)error {
    if (!self.rteCanvas) {
        if (error) *error = RTE_NSERROR(-1, @"RTE canvas not initialized");
        return nil;
    }
    return [self.rteCanvas getCropArea:canvasId error:error];
}

#pragma mark - RTE Canvas View

- (BOOL)canvasAddView:(NSString *)canvasId view:(UIView *)view config:(NSDictionary *)config error:(NSError **)error {
    if (!self.rteCanvas) {
        if (error) *error = RTE_NSERROR(-1, @"RTE canvas not initialized");
        return NO;
    }
    return [self.rteCanvas addView:canvasId view:view config:config error:error];
}

- (BOOL)canvasRemoveView:(NSString *)canvasId view:(UIView *)view config:(NSDictionary *)config error:(NSError **)error {
    if (!self.rteCanvas) {
        if (error) *error = RTE_NSERROR(-1, @"RTE canvas not initialized");
        return NO;
    }
    return [self.rteCanvas removeView:canvasId view:view config:config error:error];
}

#pragma mark - RTE Player Canvas Binding

- (BOOL)playerSetCanvas:(NSString *)playerId canvasId:(NSString *)canvasId error:(NSError **)error {
    if (!self.rtePlayer || !self.rteCanvas) {
        if (error) *error = RTE_NSERROR(-1, @"RTE player or canvas not initialized");
        return NO;
    }
    AgoraRteCanvas *canvas = [self.rteCanvas getCanvas:canvasId];
    if (!canvas) {
        if (error) *error = RTE_NSERROR(-1, @"Canvas not found");
        return NO;
    }
    return [self.rtePlayer setCanvas:playerId canvas:canvas error:error];
}

@end
