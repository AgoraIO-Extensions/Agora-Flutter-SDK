#import "AgoraRTEPlayer.h"
#import "AgoraRTECommon.h"

#pragma mark - AgoraRTEPlayerObserverBridge

@interface AgoraRTEPlayerObserverBridge : AgoraRtePlayerObserver
@property (nonatomic, weak) AgoraRTEPlayer *playerManager;
@property (nonatomic, copy) NSString *playerId;
@end

@implementation AgoraRTEPlayerObserverBridge

- (void)onStateChanged:(AgoraRtePlayerState)oldState newState:(AgoraRtePlayerState)newState error:(AgoraRteError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.playerManager.observerDelegate respondsToSelector:@selector(player:onStateChanged:newState:errorCode:errorMessage:)]) {
            [self.playerManager.observerDelegate player:self.playerId
                                        onStateChanged:(NSInteger)oldState
                                              newState:(NSInteger)newState
                                             errorCode:error ? (NSInteger)error.code : 0
                                          errorMessage:error ? SafeGetRteErrorMessage(error) : nil];
        }
    });
}

- (void)onPositionChanged:(uint64_t)currentTime utcTime:(uint64_t)utcTime {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.playerManager.observerDelegate respondsToSelector:@selector(player:onPositionChanged:utcTime:)]) {
            [self.playerManager.observerDelegate player:self.playerId onPositionChanged:currentTime utcTime:utcTime];
        }
    });
}

- (void)onResolutionChanged:(int)width height:(int)height {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.playerManager.observerDelegate respondsToSelector:@selector(player:onResolutionChanged:height:)]) {
            [self.playerManager.observerDelegate player:self.playerId onResolutionChanged:width height:height];
        }
    });
}

- (void)onEvent:(AgoraRtePlayerEvent)event {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.playerManager.observerDelegate respondsToSelector:@selector(player:onEvent:)]) {
            [self.playerManager.observerDelegate player:self.playerId onEvent:(NSInteger)event];
        }
    });
}

- (void)onMetadata:(AgoraRtePlayerMetadataType)type data:(NSData *)data {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.playerManager.observerDelegate respondsToSelector:@selector(player:onMetadata:data:)]) {
            [self.playerManager.observerDelegate player:self.playerId onMetadata:(NSInteger)type data:data];
        }
    });
}

- (void)onPlayerInfoUpdated:(AgoraRtePlayerInfo *)info {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.playerManager.observerDelegate respondsToSelector:@selector(player:onPlayerInfoUpdated:)]) {
            NSDictionary *infoDict = @{
                @"state": @([info state]),
                @"duration": @([info duration]),
                @"streamCount": @([info streamCount]),
                @"hasAudio": @([info hasAudio]),
                @"hasVideo": @([info hasVideo]),
                @"isAudioMuted": @([info isAudioMuted]),
                @"isVideoMuted": @([info isVideoMuted]),
                @"videoHeight": @([info videoHeight]),
                @"videoWidth": @([info videoWidth]),
                @"audioSampleRate": @([info audioSampleRate]),
                @"audioChannels": @([info audioChannels]),
                @"audioBitsPerSample": @([info audioBitsPerSample]),
                @"abrSubscriptionLayer": @([info abrSubscriptionLayer]),
                @"currentUrl": [info currentUrl] ?: @""
            };
            [self.playerManager.observerDelegate player:self.playerId onPlayerInfoUpdated:infoDict];
        }
    });
}

- (void)onAudioVolumeIndication:(int32_t)volume {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.playerManager.observerDelegate respondsToSelector:@selector(player:onAudioVolumeIndication:)]) {
            [self.playerManager.observerDelegate player:self.playerId onAudioVolumeIndication:volume];
        }
    });
}

@end

#pragma mark - AgoraRTEPlayer Implementation

@interface AgoraRTEPlayer ()
@property (nonatomic, weak) AgoraRte *rte;
@end

@implementation AgoraRTEPlayer

- (instancetype)initWithRte:(AgoraRte *)rte {
    self = [super init];
    if (self) {
        _rte = rte;
        _players = [NSMutableDictionary dictionary];
        _playerObservers = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark - Player Lifecycle

+ (BOOL)preloadWithUrl:(NSString *)url error:(NSError **)error {
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [AgoraRtePlayer preloadWithUrl:url error:rteError];
    
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    return YES;
}

- (NSString *)createPlayer:(NSDictionary *)config error:(NSError **)error {
    CHECK_RTE_INSTANCE_NIL(self.rte, error);
    
    AgoraRtePlayerInitialConfig *initialConfig = [[AgoraRtePlayerInitialConfig alloc] init];
    AgoraRtePlayer *player = [[AgoraRtePlayer alloc] initWithRte:self.rte initialConfig:initialConfig];
    
    if (!player) {
        if (error) *error = RTE_NSERROR(-1, @"Failed to create player");
        return nil;
    }
    
    NSString *playerId = [[NSUUID UUID] UUIDString];
    self.players[playerId] = player;
    
    // Apply config if provided
    if (config && config.count > 0) {
        NSError *configError = nil;
        if (![self setConfigs:playerId config:config error:&configError]) {
            [self.players removeObjectForKey:playerId];
            if (error) *error = configError;
            return nil;
        }
    }
    
    return playerId;
}

- (BOOL)destroyPlayer:(NSString *)playerId error:(NSError **)error {
    AgoraRtePlayer *player = self.players[playerId];
    if (!player) {
        if (error) *error = RTE_NSERROR(-1, @"Player not found");
        return NO;
    }
    
    // Unregister observer
    [self unregisterObserver:playerId error:nil];
    
    [self.players removeObjectForKey:playerId];
    return YES;
}

#pragma mark - Player Playback Control

- (BOOL)openUrl:(NSString *)playerId url:(NSString *)url startTime:(uint64_t)startTime completion:(void (^)(NSError *error))completion error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, NO);
    
    [player openWithUrl:url startTime:startTime cb:^(AgoraRteError *err) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSError *nsError = nil;
            if (err && err.code != AgoraRteOk) {
                nsError = RTE_NSERROR_FROM_RTE_ERROR(err);
            }
            if (completion) completion(nsError);
        });
    }];
    
    return YES;
}

- (BOOL)openWithCustomSourceProvider:(NSString *)playerId provider:(void *)provider startTime:(uint64_t)startTime completion:(void (^)(NSError *error))completion error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, NO);
    
    AgoraRtePlayerCustomSourceProvider *sourceProvider = (__bridge AgoraRtePlayerCustomSourceProvider *)provider;
    [player openWithCustomSourceProvider:sourceProvider startTime:startTime cb:^(AgoraRteError *err) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSError *nsError = nil;
            if (err && err.code != AgoraRteOk) {
                nsError = RTE_NSERROR_FROM_RTE_ERROR(err);
            }
            if (completion) completion(nsError);
        });
    }];
    
    return YES;
}

- (BOOL)openWithStream:(NSString *)playerId stream:(void *)stream completion:(void (^)(NSError *error))completion error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, NO);
    
    AgoraRteStream *rteStream = (__bridge AgoraRteStream *)stream;
    [player openWithStream:rteStream cb:^(AgoraRteError *err) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSError *nsError = nil;
            if (err && err.code != AgoraRteOk) {
                nsError = RTE_NSERROR_FROM_RTE_ERROR(err);
            }
            if (completion) completion(nsError);
        });
    }];
    
    return YES;
}

- (BOOL)switchWithUrl:(NSString *)playerId url:(NSString *)url syncPts:(BOOL)syncPts completion:(void (^)(NSError *error))completion error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, NO);
    
    [player switchWithUrl:url syncPts:syncPts cb:^(AgoraRteError *err) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSError *nsError = nil;
            if (err && err.code != AgoraRteOk) {
                nsError = RTE_NSERROR_FROM_RTE_ERROR(err);
            }
            if (completion) completion(nsError);
        });
    }];
    
    return YES;
}

- (BOOL)setCanvas:(NSString *)playerId canvas:(AgoraRteCanvas *)canvas error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, NO);
    
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player setCanvas:canvas error:rteError];
    
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    return YES;
}

- (BOOL)play:(NSString *)playerId error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, NO);
    
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player play:rteError];
    
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    return YES;
}

- (BOOL)pause:(NSString *)playerId error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, NO);
    
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player pause:rteError];
    
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    return YES;
}

- (BOOL)stop:(NSString *)playerId error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, NO);
    
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player stop:rteError];
    
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    return YES;
}

- (BOOL)seek:(NSString *)playerId position:(uint64_t)position error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, NO);
    
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player seek:position error:rteError];
    
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    return YES;
}

- (BOOL)muteAudio:(NSString *)playerId mute:(BOOL)mute error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, NO);
    
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player muteAudio:mute error:rteError];
    
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    return YES;
}

- (BOOL)muteVideo:(NSString *)playerId mute:(BOOL)mute error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, NO);
    
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player muteVideo:mute error:rteError];
    
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    return YES;
}

#pragma mark - Player Info

- (void)getStats:(NSString *)playerId completion:(void (^)(NSDictionary *stats, NSError *error))completion {
    AgoraRtePlayer *player = self.players[playerId];
    if (!player) {
        if (completion) completion(nil, RTE_NSERROR(-1, @"Player not found"));
        return;
    }
    
    [player getStats:^(AgoraRtePlayerStats *stats, AgoraRteError *err) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (err && err.code != AgoraRteOk) {
                if (completion) completion(nil, RTE_NSERROR_FROM_RTE_ERROR(err));
                return;
            }
            
            NSDictionary *statsDict = @{
                @"videoDecodeFrameRate": @([stats videoDecodeFrameRate]),
                @"videoRenderFrameRate": @([stats videoRenderFrameRate]),
                @"videoBitrate": @([stats videoBitrate]),
                @"audioBitrate": @([stats audioBitrate])
            };
            
            if (completion) completion(statsDict, nil);
        });
    }];
}

- (int64_t)getCurrentTime:(NSString *)playerId error:(NSError **)error {
    AgoraRtePlayer *player = self.players[playerId];
    if (!player) {
        if (error) *error = RTE_NSERROR(-1, @"Player not found");
        return 0;
    }
    
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    uint64_t position = [player getPosition:rteError];
    
    if (rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return 0;
    }
    return (int64_t)position;
}

- (int64_t)getDuration:(NSString *)playerId error:(NSError **)error {
    AgoraRtePlayer *player = self.players[playerId];
    if (!player) {
        if (error) *error = RTE_NSERROR(-1, @"Player not found");
        return 0;
    }
    
    AgoraRtePlayerInfo *info = [[AgoraRtePlayerInfo alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getInfo:info error:rteError];
    
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return 0;
    }
    
    return [info duration];
}

- (NSDictionary *)getInfo:(NSString *)playerId error:(NSError **)error {
    AgoraRtePlayer *player = self.players[playerId];
    if (!player) {
        if (error) *error = RTE_NSERROR(-1, @"Player not found");
        return nil;
    }
    
    AgoraRtePlayerInfo *info = [[AgoraRtePlayerInfo alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    
    BOOL success = [player getInfo:info error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return nil;
    }
    
    return @{
        @"state": @([info state]),
        @"duration": @([info duration]),
        @"streamCount": @([info streamCount]),
        @"hasAudio": @([info hasAudio]),
        @"hasVideo": @([info hasVideo]),
        @"isAudioMuted": @([info isAudioMuted]),
        @"isVideoMuted": @([info isVideoMuted]),
        @"videoHeight": @([info videoHeight]),
        @"videoWidth": @([info videoWidth]),
        @"audioSampleRate": @([info audioSampleRate]),
        @"audioChannels": @([info audioChannels]),
        @"audioBitsPerSample": @([info audioBitsPerSample]),
        @"abrSubscriptionLayer": @([info abrSubscriptionLayer]),
        @"currentUrl": [info currentUrl] ?: @""
    };
}

#pragma mark - Player Config

- (BOOL)setConfigs:(NSString *)playerId config:(NSDictionary *)config error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, NO);
    
    // 先获取当前配置，避免覆盖其他属性
    AgoraRtePlayerConfig *playerConfig = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:playerConfig error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // 只更新字典中提供的属性
    if (config[@"autoPlay"] && config[@"autoPlay"] != [NSNull null]) {
        [playerConfig setAutoPlay:[config[@"autoPlay"] boolValue] error:rteError];
        if (rteError.code != AgoraRteOk) {
            if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
            return NO;
        }
    }
    if (config[@"playbackSpeed"] && config[@"playbackSpeed"] != [NSNull null]) {
        [playerConfig setPlaybackSpeed:[config[@"playbackSpeed"] intValue] error:rteError];
        if (rteError.code != AgoraRteOk) {
            if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
            return NO;
        }
    }
    if (config[@"playoutAudioTrackIdx"] && config[@"playoutAudioTrackIdx"] != [NSNull null]) {
        [playerConfig setPlayoutAudioTrackIdx:[config[@"playoutAudioTrackIdx"] intValue] error:rteError];
        if (rteError.code != AgoraRteOk) {
            if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
            return NO;
        }
    }
    if (config[@"publishAudioTrackIdx"] && config[@"publishAudioTrackIdx"] != [NSNull null]) {
        [playerConfig setPublishAudioTrackIdx:[config[@"publishAudioTrackIdx"] intValue] error:rteError];
        if (rteError.code != AgoraRteOk) {
            if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
            return NO;
        }
    }
    if (config[@"audioTrackIdx"] && config[@"audioTrackIdx"] != [NSNull null]) {
        [playerConfig setAudioTrackIdx:[config[@"audioTrackIdx"] intValue] error:rteError];
        if (rteError.code != AgoraRteOk) {
            if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
            return NO;
        }
    }
    if (config[@"subtitleTrackIdx"] && config[@"subtitleTrackIdx"] != [NSNull null]) {
        [playerConfig setSubtitleTrackIdx:[config[@"subtitleTrackIdx"] intValue] error:rteError];
        if (rteError.code != AgoraRteOk) {
            if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
            return NO;
        }
    }
    if (config[@"externalSubtitleTrackIdx"] && config[@"externalSubtitleTrackIdx"] != [NSNull null]) {
        [playerConfig setExternalSubtitleTrackIdx:[config[@"externalSubtitleTrackIdx"] intValue] error:rteError];
        if (rteError.code != AgoraRteOk) {
            if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
            return NO;
        }
    }
    if (config[@"audioPitch"] && config[@"audioPitch"] != [NSNull null]) {
        [playerConfig setAudioPitch:[config[@"audioPitch"] intValue] error:rteError];
        if (rteError.code != AgoraRteOk) {
            if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
            return NO;
        }
    }
    if (config[@"playoutVolume"] && config[@"playoutVolume"] != [NSNull null]) {
        [playerConfig setPlayoutVolume:[config[@"playoutVolume"] intValue] error:rteError];
        if (rteError.code != AgoraRteOk) {
            if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
            return NO;
        }
    }
    if (config[@"audioPlaybackDelay"] && config[@"audioPlaybackDelay"] != [NSNull null]) {
        [playerConfig setAudioPlaybackDelay:[config[@"audioPlaybackDelay"] intValue] error:rteError];
        if (rteError.code != AgoraRteOk) {
            if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
            return NO;
        }
    }
    if (config[@"audioDualMonoMode"] && config[@"audioDualMonoMode"] != [NSNull null]) {
        [playerConfig setAudioDualMonoMode:[config[@"audioDualMonoMode"] intValue] error:rteError];
        if (rteError.code != AgoraRteOk) {
            if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
            return NO;
        }
    }
    if (config[@"publishVolume"] && config[@"publishVolume"] != [NSNull null]) {
        [playerConfig setPublishVolume:[config[@"publishVolume"] intValue] error:rteError];
        if (rteError.code != AgoraRteOk) {
            if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
            return NO;
        }
    }
    if (config[@"loopCount"] && config[@"loopCount"] != [NSNull null]) {
        [playerConfig setLoopCount:[config[@"loopCount"] intValue] error:rteError];
        if (rteError.code != AgoraRteOk) {
            if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
            return NO;
        }
    }
    if (config[@"jsonParameter"] && config[@"jsonParameter"] != [NSNull null]) {
        [playerConfig setJsonParameter:config[@"jsonParameter"] error:rteError];
        if (rteError.code != AgoraRteOk) {
            if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
            return NO;
        }
    }
    if (config[@"abrSubscriptionLayer"] && config[@"abrSubscriptionLayer"] != [NSNull null]) {
        [playerConfig setAbrSubscriptionLayer:(AgoraRteAbrSubscriptionLayer)[config[@"abrSubscriptionLayer"] intValue] error:rteError];
        if (rteError.code != AgoraRteOk) {
            if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
            return NO;
        }
    }
    if (config[@"abrFallbackLayer"] && config[@"abrFallbackLayer"] != [NSNull null]) {
        [playerConfig setAbrFallbackLayer:(AgoraRteAbrFallbackLayer)[config[@"abrFallbackLayer"] intValue] error:rteError];
        if (rteError.code != AgoraRteOk) {
            if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
            return NO;
        }
    }
    
    // 设置修改后的配置
    AgoraRteError *setError = [[AgoraRteError alloc] init];
    success = [player setConfigs:playerConfig error:setError];
    
    if (!success || setError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(setError);
        return NO;
    }
    return YES;
}

- (NSDictionary *)getConfigs:(NSString *)playerId error:(NSError **)error {
    AgoraRtePlayer *player = self.players[playerId];
    if (!player) {
        if (error) *error = RTE_NSERROR(-1, @"Player not found");
        return nil;
    }
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return nil;
    }
    
    AgoraRteError *getError = [[AgoraRteError alloc] init];
    return @{
        @"autoPlay": @([config autoPlay:getError]),
        @"playbackSpeed": @([config playbackSpeed:getError]),
        @"playoutAudioTrackIdx": @([config playoutAudioTrackIdx:getError]),
        @"publishAudioTrackIdx": @([config publishAudioTrackIdx:getError]),
        @"audioTrackIdx": @([config audioTrackIdx:getError]),
        @"subtitleTrackIdx": @([config subtitleTrackIdx:getError]),
        @"externalSubtitleTrackIdx": @([config externalSubtitleTrackIdx:getError]),
        @"audioPitch": @([config audioPitch:getError]),
        @"playoutVolume": @([config playoutVolume:getError]),
        @"audioPlaybackDelay": @([config audioPlaybackDelay:getError]),
        @"audioDualMonoMode": @([config audioDualMonoMode:getError]),
        @"publishVolume": @([config publishVolume:getError]),
        @"loopCount": @([config loopCount:getError]),
        @"jsonParameter": [config jsonParameter:getError] ?: @"",
        @"abrSubscriptionLayer": @([config abrSubscriptionLayer:getError]),
        @"abrFallbackLayer": @([config abrFallbackLayer:getError])
    };
}

// Individual Config Setters/Getters
- (BOOL)setAutoPlay:(NSString *)playerId autoPlay:(BOOL)autoPlay error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, NO);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    [config setAutoPlay:autoPlay error:rteError];
    if (rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // success = [player setConfigs:config error:rteError];
    // if (!success || rteError.code != AgoraRteOk) {
    //     if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
    //     return NO;
    // }
    return YES;
}

- (BOOL)getAutoPlay:(NSString *)playerId error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, NO);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    return [config autoPlay:rteError];
}

- (BOOL)setPlaybackSpeed:(NSString *)playerId speed:(int32_t)speed error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, NO);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    [config setPlaybackSpeed:speed error:rteError];
    if (rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // success = [player setConfigs:config error:rteError];
    // if (!success || rteError.code != AgoraRteOk) {
    //     if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
    //     return NO;
    // }
    return YES;
}

- (int32_t)getPlaybackSpeed:(NSString *)playerId error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, 0);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return 0;
    }
    return [config playbackSpeed:rteError];
}

- (BOOL)setPlayoutAudioTrackIdx:(NSString *)playerId idx:(int32_t)idx error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, NO);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    [config setPlayoutAudioTrackIdx:idx error:rteError];
    if (rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // success = [player setConfigs:config error:rteError];
    // if (!success || rteError.code != AgoraRteOk) {
    //     if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
    //     return NO;
    // }
    return YES;
}

- (int32_t)getPlayoutAudioTrackIdx:(NSString *)playerId error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, 0);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return 0;
    }
    return [config playoutAudioTrackIdx:rteError];
}

- (BOOL)setPublishAudioTrackIdx:(NSString *)playerId idx:(int32_t)idx error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, NO);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    [config setPublishAudioTrackIdx:idx error:rteError];
    if (rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // success = [player setConfigs:config error:rteError];
    // if (!success || rteError.code != AgoraRteOk) {
    //     if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
    //     return NO;
    // }
    return YES;
}

- (int32_t)getPublishAudioTrackIdx:(NSString *)playerId error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, 0);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return 0;
    }
    return [config publishAudioTrackIdx:rteError];
}

- (BOOL)setAudioTrackIdx:(NSString *)playerId idx:(int32_t)idx error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, NO);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    [config setAudioTrackIdx:idx error:rteError];
    if (rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // success = [player setConfigs:config error:rteError];
    // if (!success || rteError.code != AgoraRteOk) {
    //     if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
    //     return NO;
    // }
    return YES;
}

- (int32_t)getAudioTrackIdx:(NSString *)playerId error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, 0);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return 0;
    }
    return [config audioTrackIdx:rteError];
}

- (BOOL)setSubtitleTrackIdx:(NSString *)playerId idx:(int32_t)idx error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, NO);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    [config setSubtitleTrackIdx:idx error:rteError];
    if (rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // success = [player setConfigs:config error:rteError];
    // if (!success || rteError.code != AgoraRteOk) {
    //     if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
    //     return NO;
    // }
    return YES;
}

- (int32_t)getSubtitleTrackIdx:(NSString *)playerId error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, 0);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return 0;
    }
    return [config subtitleTrackIdx:rteError];
}

- (BOOL)setExternalSubtitleTrackIdx:(NSString *)playerId idx:(int32_t)idx error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, NO);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    [config setExternalSubtitleTrackIdx:idx error:rteError];
    if (rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // success = [player setConfigs:config error:rteError];
    // if (!success || rteError.code != AgoraRteOk) {
    //     if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
    //     return NO;
    // }
    return YES;
}

- (int32_t)getExternalSubtitleTrackIdx:(NSString *)playerId error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, 0);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return 0;
    }
    return [config externalSubtitleTrackIdx:rteError];
}

- (BOOL)setAudioPitch:(NSString *)playerId pitch:(int32_t)pitch error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, NO);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    [config setAudioPitch:pitch error:rteError];
    if (rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // success = [player setConfigs:config error:rteError];
    // if (!success || rteError.code != AgoraRteOk) {
    //     if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
    //     return NO;
    // }
    return YES;
}

- (int32_t)getAudioPitch:(NSString *)playerId error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, 0);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return 0;
    }
    return [config audioPitch:rteError];
}

- (BOOL)setPlayoutVolume:(NSString *)playerId volume:(int32_t)volume error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, NO);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    [config setPlayoutVolume:volume error:rteError];
    if (rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // success = [player setConfigs:config error:rteError];
    // if (!success || rteError.code != AgoraRteOk) {
    //     if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
    //     return NO;
    // }
    return YES;
}

- (int32_t)getPlayoutVolume:(NSString *)playerId error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, 0);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return 0;
    }
    return [config playoutVolume:rteError];
}

- (BOOL)setAudioPlaybackDelay:(NSString *)playerId delay:(int32_t)delay error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, NO);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    [config setAudioPlaybackDelay:delay error:rteError];
    if (rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // success = [player setConfigs:config error:rteError];
    // if (!success || rteError.code != AgoraRteOk) {
    //     if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
    //     return NO;
    // }
    return YES;
}

- (int32_t)getAudioPlaybackDelay:(NSString *)playerId error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, 0);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return 0;
    }
    return [config audioPlaybackDelay:rteError];
}

- (BOOL)setAudioDualMonoMode:(NSString *)playerId mode:(int32_t)mode error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, NO);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    [config setAudioDualMonoMode:mode error:rteError];
    if (rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // success = [player setConfigs:config error:rteError];
    // if (!success || rteError.code != AgoraRteOk) {
    //     if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
    //     return NO;
    // }
    return YES;
}

- (int32_t)getAudioDualMonoMode:(NSString *)playerId error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, 0);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return 0;
    }
    return [config audioDualMonoMode:rteError];
}

- (BOOL)setPublishVolume:(NSString *)playerId volume:(int32_t)volume error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, NO);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    [config setPublishVolume:volume error:rteError];
    if (rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // success = [player setConfigs:config error:rteError];
    // if (!success || rteError.code != AgoraRteOk) {
    //     if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
    //     return NO;
    // }
    return YES;
}

- (int32_t)getPublishVolume:(NSString *)playerId error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, 0);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return 0;
    }
    return [config publishVolume:rteError];
}

- (BOOL)setLoopCount:(NSString *)playerId count:(int32_t)count error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, NO);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    [config setLoopCount:count error:rteError];
    if (rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // success = [player setConfigs:config error:rteError];
    // if (!success || rteError.code != AgoraRteOk) {
    //     if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
    //     return NO;
    // }
    return YES;
}

- (int32_t)getLoopCount:(NSString *)playerId error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, 0);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return 0;
    }
    return [config loopCount:rteError];
}

- (BOOL)setJsonParameter:(NSString *)playerId jsonParameter:(NSString *)jsonParameter error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, NO);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    [config setJsonParameter:jsonParameter error:rteError];
    if (rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // success = [player setConfigs:config error:rteError];
    // if (!success || rteError.code != AgoraRteOk) {
    //     if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
    //     return NO;
    // }
    return YES;
}

- (NSString *)getJsonParameter:(NSString *)playerId error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, nil);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return nil;
    }
    return [config jsonParameter:rteError] ?: @"";
}

- (BOOL)setAbrSubscriptionLayer:(NSString *)playerId layer:(AgoraRteAbrSubscriptionLayer)layer error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, NO);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    [config setAbrSubscriptionLayer:layer error:rteError];
    if (rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // success = [player setConfigs:config error:rteError];
    // if (!success || rteError.code != AgoraRteOk) {
    //     if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
    //     return NO;
    // }
    return YES;
}

- (AgoraRteAbrSubscriptionLayer)getAbrSubscriptionLayer:(NSString *)playerId error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, AgoraRteAbrSubscriptionHigh);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return AgoraRteAbrSubscriptionHigh;
    }
    return [config abrSubscriptionLayer:rteError];
}

- (BOOL)setAbrFallbackLayer:(NSString *)playerId layer:(AgoraRteAbrFallbackLayer)layer error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, NO);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    [config setAbrFallbackLayer:layer error:rteError];
    if (rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // success = [player setConfigs:config error:rteError];
    // if (!success || rteError.code != AgoraRteOk) {
    //     if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
    //     return NO;
    // }
    return YES;
}

- (AgoraRteAbrFallbackLayer)getAbrFallbackLayer:(NSString *)playerId error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, AgoraRteAbrFallbackLow);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return AgoraRteAbrFallbackLow;
    }
    return [config abrFallbackLayer:rteError];
}

#pragma mark - Player Observer

- (BOOL)registerObserver:(NSString *)playerId error:(NSError **)error {
    GET_PLAYER_OR_RETURN(self.players, playerId, error, NO);
    
    if (self.playerObservers[playerId]) return YES;
    
    AgoraRTEPlayerObserverBridge *bridge = [[AgoraRTEPlayerObserverBridge alloc] init];
    bridge.playerManager = self;
    bridge.playerId = playerId;
    
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player registerObserver:(id)bridge error:rteError];
    
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    self.playerObservers[playerId] = bridge;
    return YES;
}

- (BOOL)unregisterObserver:(NSString *)playerId error:(NSError **)error {
    AgoraRtePlayer *player = self.players[playerId];
    AgoraRtePlayerObserver *observer = self.playerObservers[playerId];
    
    if (!player || !observer) return YES;
    
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player unregisterObserver:(id)observer error:rteError];
    
    [self.playerObservers removeObjectForKey:playerId];
    
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    return YES;
}

@end
