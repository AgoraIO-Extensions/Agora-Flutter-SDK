#import "./include/agora_rtc_engine/AgoraRTEController.h"
#import <AgoraRtcKit/AgoraRteKit.h>

#pragma mark - Helper Macros

#define RTE_NSERROR(errCode, msg) \
    [NSError errorWithDomain:@"AgoraRTE" code:errCode userInfo:@{NSLocalizedDescriptionKey: msg ?: @"Unknown error"}]


static inline NSString * _Nullable SafeGetRteErrorMessage(AgoraRteError * _Nullable rteError) {
    if (!rteError) {
        return nil;
    }
    AgoraRteErrorCode code = [rteError code];
    return [NSString stringWithFormat:@"RTE Error (code: %ld)", (long)code];
}

#define RTE_NSERROR_FROM_RTE_ERROR(rteError) \
    RTE_NSERROR([rteError code], SafeGetRteErrorMessage(rteError))

#define CHECK_RTE_INSTANCE(error) \
    if (!self.rteInstance) { \
        if (error) *error = RTE_NSERROR(-1, @"RTE instance not created"); \
        return NO; \
    }

#define CHECK_RTE_INSTANCE_NIL(error) \
    if (!self.rteInstance) { \
        if (error) *error = RTE_NSERROR(-1, @"RTE instance not created"); \
        return nil; \
    }

#define GET_PLAYER_OR_RETURN(playerId, error, retVal) \
    AgoraRtePlayer *player = self.players[playerId]; \
    if (!player) { \
        if (error) *error = RTE_NSERROR(-1, @"Player not found"); \
        return retVal; \
    }

#define GET_CANVAS_OR_RETURN(canvasId, error, retVal) \
    AgoraRteCanvas *canvas = self.canvases[canvasId]; \
    if (!canvas) { \
        if (error) *error = RTE_NSERROR(-1, @"Canvas not found"); \
        return retVal; \
    }

#pragma mark - AgoraRTEPlayerObserverBridge

@interface AgoraRTEPlayerObserverBridge : AgoraRtePlayerObserver
@property (nonatomic, weak) AgoraRTEController *controller;
@property (nonatomic, copy) NSString *playerId;
@end

@implementation AgoraRTEPlayerObserverBridge

- (void)onStateChanged:(AgoraRtePlayerState)oldState newState:(AgoraRtePlayerState)newState error:(AgoraRteError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.controller.playerObserverDelegate respondsToSelector:@selector(player:onStateChanged:newState:errorCode:errorMessage:)]) {
            [self.controller.playerObserverDelegate player:self.playerId
                                            onStateChanged:(NSInteger)oldState
                                                  newState:(NSInteger)newState
                                                 errorCode:error ? (NSInteger)error.code : 0
                                              errorMessage:error ? SafeGetRteErrorMessage(error) : nil];
        }
    });
}

- (void)onPositionChanged:(uint64_t)currentTime utcTime:(uint64_t)utcTime {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.controller.playerObserverDelegate respondsToSelector:@selector(player:onPositionChanged:utcTime:)]) {
            [self.controller.playerObserverDelegate player:self.playerId onPositionChanged:currentTime utcTime:utcTime];
        }
    });
}

- (void)onResolutionChanged:(int)width height:(int)height {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.controller.playerObserverDelegate respondsToSelector:@selector(player:onResolutionChanged:height:)]) {
            [self.controller.playerObserverDelegate player:self.playerId onResolutionChanged:width height:height];
        }
    });
}

- (void)onEvent:(AgoraRtePlayerEvent)event {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.controller.playerObserverDelegate respondsToSelector:@selector(player:onEvent:)]) {
            [self.controller.playerObserverDelegate player:self.playerId onEvent:(NSInteger)event];
        }
    });
}

- (void)onMetadata:(AgoraRtePlayerMetadataType)type data:(NSData *)data {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.controller.playerObserverDelegate respondsToSelector:@selector(player:onMetadata:data:)]) {
            [self.controller.playerObserverDelegate player:self.playerId onMetadata:(NSInteger)type data:data];
        }
    });
}

- (void)onPlayerInfoUpdated:(AgoraRtePlayerInfo *)info {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.controller.playerObserverDelegate respondsToSelector:@selector(player:onPlayerInfoUpdated:)]) {
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
            [self.controller.playerObserverDelegate player:self.playerId onPlayerInfoUpdated:infoDict];
        }
    });
}

- (void)onAudioVolumeIndication:(int32_t)volume {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.controller.playerObserverDelegate respondsToSelector:@selector(player:onAudioVolumeIndication:)]) {
            [self.controller.playerObserverDelegate player:self.playerId onAudioVolumeIndication:volume];
        }
    });
}

@end

#pragma mark - AgoraRTEObserverBridge

@interface AgoraRTEObserverBridge : NSObject
@property (nonatomic, weak) AgoraRTEController *controller;
@end

@implementation AgoraRTEObserverBridge
@end

#pragma mark - AgoraRTEController Private

@interface AgoraRTEController ()
@property (nonatomic, strong) AgoraRTEObserverBridge *rteObserver;
@end

#pragma mark - AgoraRTEController Implementation

@implementation AgoraRTEController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.players = [NSMutableDictionary dictionary];
        self.canvases = [NSMutableDictionary dictionary];
        self.playerObservers = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark - RTE Lifecycle

- (BOOL)createRteFromBridge:(NSError **)error {
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    self.rteInstance = [AgoraRte getFromBridge:rteError];
    
    if (!self.rteInstance || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    return YES;
}

- (BOOL)createRteWithConfig:(NSDictionary *)config error:(NSError **)error {
    AgoraRteInitialConfig *initialConfig = [[AgoraRteInitialConfig alloc] init];
    self.rteInstance = [[AgoraRte alloc] initWithInitialConfig:initialConfig];
    
    if (!self.rteInstance) {
        if (error) *error = RTE_NSERROR(-1, @"Failed to create RTE instance");
        return NO;
    }
    
    if (config && config.count > 0) {
        return [self setRteConfig:config error:error];
    }
    
    return YES;
}

- (BOOL)initMediaEngine:(void (^)(NSError *error))completion error:(NSError **)error {
    CHECK_RTE_INSTANCE(error);
    
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [self.rteInstance initMediaEngine:^(AgoraRteError *err) {
        NSError *nsError = nil;
        if (err && err.code != AgoraRteOk) {
            nsError = RTE_NSERROR_FROM_RTE_ERROR(err);
        }
        if (completion) completion(nsError);
    } error:rteError];
    
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    return YES;
}

- (BOOL)destroyRte:(NSError **)error {
    if (!self.rteInstance) return YES;
    
    // Destroy all players
    for (NSString *playerId in [self.players allKeys]) {
        [self destroyPlayer:playerId error:nil];
    }
    
    // Destroy all canvases
    for (NSString *canvasId in [self.canvases allKeys]) {
        [self destroyCanvas:canvasId error:nil];
    }
    
    // Unregister RTE observer
    [self unregisterRteObserver:nil];
    
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [self.rteInstance destroy:rteError];
    
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    self.rteInstance = nil;
    return YES;
}

#pragma mark - RTE Config

- (BOOL)setRteConfig:(NSDictionary *)config error:(NSError **)error {
    CHECK_RTE_INSTANCE(error);
    
    AgoraRteConfig *rteConfig = [[AgoraRteConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    
    if (config[@"appId"] && config[@"appId"] != [NSNull null]) {
        [rteConfig setAppId:config[@"appId"] error:rteError];
    }
    if (config[@"logFolder"] && config[@"logFolder"] != [NSNull null]) {
        [rteConfig setLogFolder:config[@"logFolder"] error:rteError];
    }
    if (config[@"logFileSize"] && config[@"logFileSize"] != [NSNull null]) {
        [rteConfig setLogFileSize:[config[@"logFileSize"] unsignedLongValue] error:rteError];
    }
    if (config[@"areaCode"] && config[@"areaCode"] != [NSNull null]) {
        [rteConfig setAreaCode:[config[@"areaCode"] intValue] error:rteError];
    }
    if (config[@"cloudProxy"] && config[@"cloudProxy"] != [NSNull null]) {
        [rteConfig setCloudProxy:config[@"cloudProxy"] error:rteError];
    }
    if (config[@"jsonParameter"] && config[@"jsonParameter"] != [NSNull null]) {
        [rteConfig setJsonParameter:config[@"jsonParameter"] error:rteError];
    }
    
    AgoraRteError *setError = [[AgoraRteError alloc] init];
    BOOL success = [self.rteInstance setConfigs:rteConfig error:setError];
    
    if (!success || setError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(setError);
        return NO;
    }
    return YES;
}

- (NSDictionary *)getRteConfig:(NSError **)error {
    CHECK_RTE_INSTANCE_NIL(error);
    
    AgoraRteConfig *config = [[AgoraRteConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    
    BOOL success = [self.rteInstance getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return nil;
    }
    
    AgoraRteError *getError = [[AgoraRteError alloc] init];
    return @{
        @"appId": [config appId:getError] ?: @"",
        @"logFolder": [config logFolder:getError] ?: @"",
        @"logFileSize": @([config logFileSize:getError]),
        @"areaCode": @([config areaCode:getError]),
        @"cloudProxy": [config cloudProxy:getError] ?: @"",
        @"jsonParameter": [config jsonParameter:getError] ?: @""
    };
}
- (NSString *)appId:(NSError **)error {
    CHECK_RTE_INSTANCE_NIL(error);
    
    AgoraRteConfig *config = [[AgoraRteConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    
    BOOL success = [self.rteInstance getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return nil;
    }
    
    AgoraRteError *getError = [[AgoraRteError alloc] init];
    NSString *appId = [config appId:getError];
    
    if (getError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(getError);
        return nil;
    }
    
    return appId ?: @"";
}

- (NSString *)logFolder:(NSError **)error {
    CHECK_RTE_INSTANCE_NIL(error);
    
    AgoraRteConfig *config = [[AgoraRteConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    
    BOOL success = [self.rteInstance getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return nil;
    }
    
    AgoraRteError *getError = [[AgoraRteError alloc] init];
    NSString *logFolder = [config logFolder:getError];
    
    if (getError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(getError);
        return nil;
    }
    
    return logFolder ?: @"";
}

- (NSNumber *)logFileSize:(NSError **)error {
    CHECK_RTE_INSTANCE_NIL(error);
    
    AgoraRteConfig *config = [[AgoraRteConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    
    BOOL success = [self.rteInstance getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return nil;
    }
    
    AgoraRteError *getError = [[AgoraRteError alloc] init];
    size_t logFileSize = [config logFileSize:getError];
    
    if (getError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(getError);
        return nil;
    }
    
    return @(logFileSize);
}

- (NSNumber *)areaCode:(NSError **)error {
    CHECK_RTE_INSTANCE_NIL(error);
    
    AgoraRteConfig *config = [[AgoraRteConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    
    BOOL success = [self.rteInstance getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return nil;
    }
    
    AgoraRteError *getError = [[AgoraRteError alloc] init];
    int32_t areaCode = [config areaCode:getError];
    
    if (getError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(getError);
        return nil;
    }
    
    return @(areaCode);
}

- (NSString *)cloudProxy:(NSError **)error {
    CHECK_RTE_INSTANCE_NIL(error);
    
    AgoraRteConfig *config = [[AgoraRteConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    
    BOOL success = [self.rteInstance getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return nil;
    }
    
    AgoraRteError *getError = [[AgoraRteError alloc] init];
    NSString *cloudProxy = [config cloudProxy:getError];
    
    if (getError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(getError);
        return nil;
    }
    
    return cloudProxy ?: @"";
}

- (NSString *)jsonParameter:(NSError **)error {
    CHECK_RTE_INSTANCE_NIL(error);
    
    AgoraRteConfig *config = [[AgoraRteConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    
    BOOL success = [self.rteInstance getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return nil;
    }
    
    AgoraRteError *getError = [[AgoraRteError alloc] init];
    NSString *jsonParameter = [config jsonParameter:getError];
    
    if (getError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(getError);
        return nil;
    }
    
    return jsonParameter ?: @"";
}

#pragma mark - RTE Observer

- (BOOL)registerRteObserver:(NSError **)error {
    CHECK_RTE_INSTANCE(error);
    
    if (self.rteObserver) return YES;
    
    AgoraRTEObserverBridge *bridge = [[AgoraRTEObserverBridge alloc] init];
    bridge.controller = self;
    self.rteObserver = bridge;
    
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [self.rteInstance registerObserver:(id)bridge error:rteError];
    
    if (!success || rteError.code != AgoraRteOk) {
        self.rteObserver = nil;
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    return YES;
}

- (BOOL)unregisterRteObserver:(NSError **)error {
    if (!self.rteInstance || !self.rteObserver) return YES;
    
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [self.rteInstance unregisterObserver:(id)self.rteObserver error:rteError];
    
    self.rteObserver = nil;
    
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    return YES;
}


#pragma mark - RTE Player Lifecycle

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
    CHECK_RTE_INSTANCE_NIL(error);
    
    AgoraRtePlayerInitialConfig *initialConfig = [[AgoraRtePlayerInitialConfig alloc] init];
    AgoraRtePlayer *player = [[AgoraRtePlayer alloc] initWithRte:self.rteInstance initialConfig:initialConfig];
    
    if (!player) {
        if (error) *error = RTE_NSERROR(-1, @"Failed to create player");
        return nil;
    }
    
    // Apply config if provided
    if (config && config.count > 0) {
        NSString *playerId = [[NSUUID UUID] UUIDString];
        self.players[playerId] = player;
        
        NSError *configError = nil;
        if (![self playerSetConfig:playerId config:config error:&configError]) {
            [self.players removeObjectForKey:playerId];
            if (error) *error = configError;
            return nil;
        }
        return playerId;
    }
    
    NSString *playerId = [[NSUUID UUID] UUIDString];
    self.players[playerId] = player;
    return playerId;
}

- (BOOL)destroyPlayer:(NSString *)playerId error:(NSError **)error {
    AgoraRtePlayer *player = self.players[playerId];
    if (!player) {
        if (error) *error = RTE_NSERROR(-1, @"Player not found");
        return NO;
    }
    
    // Unregister observer
    [self playerUnregisterObserver:playerId error:nil];
    
    [self.players removeObjectForKey:playerId];
    return YES;
}

#pragma mark - RTE Player Playback Control

- (BOOL)playerOpenUrl:(NSString *)playerId url:(NSString *)url startTime:(uint64_t)startTime completion:(void (^)(NSError *error))completion error:(NSError **)error {
    GET_PLAYER_OR_RETURN(playerId, error, NO);
    
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

- (BOOL)playerOpenWithCustomSourceProvider:(NSString *)playerId provider:(void *)provider startTime:(uint64_t)startTime completion:(void (^)(NSError *error))completion error:(NSError **)error {
    GET_PLAYER_OR_RETURN(playerId, error, NO);
    
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

- (BOOL)playerOpenWithStream:(NSString *)playerId stream:(void *)stream completion:(void (^)(NSError *error))completion error:(NSError **)error {
    GET_PLAYER_OR_RETURN(playerId, error, NO);
    
    AgoraRteStream *rteStream = (__bridge AgoraRteStream *)stream;
    [player openWithStream:rteStream cb:^(AgoraRteError *err) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSError *nsError = nil;
            if (err && err.code != AgoraRteOk) {
                nsError = RTE_NSERROR_FROM_RTE_ERROR(err);;
            }
            if (completion) completion(nsError);
        });
    }];
    
    return YES;
}

- (BOOL)playerPlay:(NSString *)playerId error:(NSError **)error {
    GET_PLAYER_OR_RETURN(playerId, error, NO);
    
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player play:rteError];
    
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    return YES;
}

- (BOOL)playerPause:(NSString *)playerId error:(NSError **)error {
    GET_PLAYER_OR_RETURN(playerId, error, NO);
    
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player pause:rteError];
    
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    return YES;
}

- (BOOL)playerStop:(NSString *)playerId error:(NSError **)error {
    GET_PLAYER_OR_RETURN(playerId, error, NO);
    
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player stop:rteError];
    
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    return YES;
}

- (BOOL)playerSeek:(NSString *)playerId position:(uint64_t)position error:(NSError **)error {
    GET_PLAYER_OR_RETURN(playerId, error, NO);
    
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player seek:position error:rteError];
    
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    return YES;
}

- (BOOL)playerMuteAudio:(NSString *)playerId mute:(BOOL)mute error:(NSError **)error {
    GET_PLAYER_OR_RETURN(playerId, error, NO);
    
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player muteAudio:mute error:rteError];
    
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    return YES;
}

- (BOOL)playerMuteVideo:(NSString *)playerId mute:(BOOL)mute error:(NSError **)error {
    GET_PLAYER_OR_RETURN(playerId, error, NO);
    
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player muteVideo:mute error:rteError];
    
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    return YES;
}

- (BOOL)playerSwitch:(NSString *)playerId url:(NSString *)url syncPts:(BOOL)syncPts completion:(void (^)(NSError *error))completion error:(NSError **)error {
    GET_PLAYER_OR_RETURN(playerId, error, NO);
    
    [player switchWithUrl:url syncPts:syncPts cb:^(AgoraRteError *err) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSError *nsError = nil;
            if (err && err.code != AgoraRteOk) {
                nsError = RTE_NSERROR_FROM_RTE_ERROR(err);;
            }
            if (completion) completion(nsError);
        });
    }];
    
    return YES;
}

- (BOOL)playerSetPlaybackSpeed:(NSString *)playerId speed:(int32_t)speed error:(NSError **)error {
    GET_PLAYER_OR_RETURN(playerId, error, NO);
    
    // 先获取当前配置，避免覆盖其他属性
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // 只修改需要修改的属性
    [config setPlaybackSpeed:speed error:rteError];
    if (rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // 设置修改后的配置
    success = [player setConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    return YES;
}

- (int32_t)playerGetPlaybackSpeed:(NSString *)playerId error:(NSError **)error {
    GET_PLAYER_OR_RETURN(playerId, error, 0);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return 0;
    }
    return [config playbackSpeed:rteError];
}

- (BOOL)playerSetPlayoutVolume:(NSString *)playerId volume:(int32_t)volume error:(NSError **)error {
    GET_PLAYER_OR_RETURN(playerId, error, NO);
    
    // 先获取当前配置，避免覆盖其他属性
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // 只修改需要修改的属性
    [config setPlayoutVolume:volume error:rteError];
    if (rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // 设置修改后的配置
    success = [player setConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    return YES;
}

- (int32_t)playerGetPlayoutVolume:(NSString *)playerId error:(NSError **)error {
    GET_PLAYER_OR_RETURN(playerId, error, 0);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return 0;
    }
    return [config playoutVolume:rteError];
}

- (BOOL)playerSetLoopCount:(NSString *)playerId count:(int32_t)count error:(NSError **)error {
    GET_PLAYER_OR_RETURN(playerId, error, NO);
    
    // 先获取当前配置，避免覆盖其他属性
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // 只修改需要修改的属性
    [config setLoopCount:count error:rteError];
    if (rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // 设置修改后的配置
    success = [player setConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    return YES;
}

- (int32_t)playerGetLoopCount:(NSString *)playerId error:(NSError **)error {
    GET_PLAYER_OR_RETURN(playerId, error, 0);
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return 0;
    }
    return [config loopCount:rteError];
}

#pragma mark - RTE Player Info

- (int64_t)playerGetCurrentTime:(NSString *)playerId error:(NSError **)error {
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

- (int64_t)playerGetDuration:(NSString *)playerId error:(NSError **)error {
    AgoraRtePlayer *player = self.players[playerId];
    if (!player) {
        if (error) *error = RTE_NSERROR(-1, @"Player not found");
        return 0;
    }
    
    AgoraRtePlayerConfig *config = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return 0;
    }
    
    AgoraRtePlayerInfo *info = [[AgoraRtePlayerInfo alloc] init];
    success = [player getInfo:info error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return 0;
    }
    
    return [info duration];
}

- (NSDictionary *)playerGetInfo:(NSString *)playerId error:(NSError **)error {
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

- (void)playerGetStats:(NSString *)playerId completion:(void (^)(NSDictionary *stats, NSError *error))completion {
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


#pragma mark - RTE Player Config

- (BOOL)playerSetConfig:(NSString *)playerId config:(NSDictionary *)config error:(NSError **)error {
    GET_PLAYER_OR_RETURN(playerId, error, NO);
    
    AgoraRtePlayerConfig *playerConfig = [[AgoraRtePlayerConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    
    if (config[@"autoPlay"] && config[@"autoPlay"] != [NSNull null]) {
        [playerConfig setAutoPlay:[config[@"autoPlay"] boolValue] error:rteError];
    }
    if (config[@"playbackSpeed"] && config[@"playbackSpeed"] != [NSNull null]) {
        [playerConfig setPlaybackSpeed:[config[@"playbackSpeed"] intValue] error:rteError];
    }
    if (config[@"playoutAudioTrackIdx"] && config[@"playoutAudioTrackIdx"] != [NSNull null]) {
        [playerConfig setPlayoutAudioTrackIdx:[config[@"playoutAudioTrackIdx"] intValue] error:rteError];
    }
    if (config[@"publishAudioTrackIdx"] && config[@"publishAudioTrackIdx"] != [NSNull null]) {
        [playerConfig setPublishAudioTrackIdx:[config[@"publishAudioTrackIdx"] intValue] error:rteError];
    }
    if (config[@"audioTrackIdx"] && config[@"audioTrackIdx"] != [NSNull null]) {
        [playerConfig setAudioTrackIdx:[config[@"audioTrackIdx"] intValue] error:rteError];
    }
    if (config[@"subtitleTrackIdx"] && config[@"subtitleTrackIdx"] != [NSNull null]) {
        [playerConfig setSubtitleTrackIdx:[config[@"subtitleTrackIdx"] intValue] error:rteError];
    }
    if (config[@"externalSubtitleTrackIdx"] && config[@"externalSubtitleTrackIdx"] != [NSNull null]) {
        [playerConfig setExternalSubtitleTrackIdx:[config[@"externalSubtitleTrackIdx"] intValue] error:rteError];
    }
    if (config[@"audioPitch"] && config[@"audioPitch"] != [NSNull null]) {
        [playerConfig setAudioPitch:[config[@"audioPitch"] intValue] error:rteError];
    }
    if (config[@"playoutVolume"] && config[@"playoutVolume"] != [NSNull null]) {
        [playerConfig setPlayoutVolume:[config[@"playoutVolume"] intValue] error:rteError];
    }
    if (config[@"audioPlaybackDelay"] && config[@"audioPlaybackDelay"] != [NSNull null]) {
        [playerConfig setAudioPlaybackDelay:[config[@"audioPlaybackDelay"] intValue] error:rteError];
    }
    if (config[@"audioDualMonoMode"] && config[@"audioDualMonoMode"] != [NSNull null]) {
        [playerConfig setAudioDualMonoMode:[config[@"audioDualMonoMode"] intValue] error:rteError];
    }
    if (config[@"publishVolume"] && config[@"publishVolume"] != [NSNull null]) {
        [playerConfig setPublishVolume:[config[@"publishVolume"] intValue] error:rteError];
    }
    if (config[@"loopCount"] && config[@"loopCount"] != [NSNull null]) {
        [playerConfig setLoopCount:[config[@"loopCount"] intValue] error:rteError];
    }
    if (config[@"jsonParameter"] && config[@"jsonParameter"] != [NSNull null]) {
        [playerConfig setJsonParameter:config[@"jsonParameter"] error:rteError];
    }
    if (config[@"abrSubscriptionLayer"] && config[@"abrSubscriptionLayer"] != [NSNull null]) {
        [playerConfig setAbrSubscriptionLayer:(AgoraRteAbrSubscriptionLayer)[config[@"abrSubscriptionLayer"] intValue] error:rteError];
    }
    if (config[@"abrFallbackLayer"] && config[@"abrFallbackLayer"] != [NSNull null]) {
        [playerConfig setAbrFallbackLayer:(AgoraRteAbrFallbackLayer)[config[@"abrFallbackLayer"] intValue] error:rteError];
    }
    
    AgoraRteError *setError = [[AgoraRteError alloc] init];
    BOOL success = [player setConfigs:playerConfig error:setError];
    
    if (!success || setError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(setError);
        return NO;
    }
    return YES;
}

- (NSDictionary *)playerGetConfig:(NSString *)playerId error:(NSError **)error {
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

#pragma mark - RTE Player Observer

- (BOOL)playerRegisterObserver:(NSString *)playerId error:(NSError **)error {
    GET_PLAYER_OR_RETURN(playerId, error, NO);
    
    if (self.playerObservers[playerId]) return YES;
    
    AgoraRTEPlayerObserverBridge *bridge = [[AgoraRTEPlayerObserverBridge alloc] init];
    bridge.controller = self;
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

- (BOOL)playerUnregisterObserver:(NSString *)playerId error:(NSError **)error {
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

#pragma mark - RTE Canvas Lifecycle

- (NSString *)createCanvas:(NSDictionary *)config error:(NSError **)error {
    CHECK_RTE_INSTANCE_NIL(error);
    
    AgoraRteCanvasInitialConfig *initialConfig = [[AgoraRteCanvasInitialConfig alloc] init];
    AgoraRteCanvas *canvas = [[AgoraRteCanvas alloc] initWithRte:self.rteInstance initialConfig:initialConfig];
    
    if (!canvas) {
        if (error) *error = RTE_NSERROR(-1, @"Failed to create canvas");
        return nil;
    }
    
    NSString *canvasId = [[NSUUID UUID] UUIDString];
    self.canvases[canvasId] = canvas;
    
    // Apply config if provided
    if (config && config.count > 0) {
        NSError *configError = nil;
        if (![self canvasSetConfig:canvasId config:config error:&configError]) {
            [self.canvases removeObjectForKey:canvasId];
            if (error) *error = configError;
            return nil;
        }
    }
    
    return canvasId;
}

- (BOOL)destroyCanvas:(NSString *)canvasId error:(NSError **)error {
    AgoraRteCanvas *canvas = self.canvases[canvasId];
    if (!canvas) {
        if (error) *error = RTE_NSERROR(-1, @"Canvas not found");
        return NO;
    }
    
    [self.canvases removeObjectForKey:canvasId];
    return YES;
}

#pragma mark - RTE Canvas Config

- (BOOL)canvasSetConfig:(NSString *)canvasId config:(NSDictionary *)config error:(NSError **)error {
    GET_CANVAS_OR_RETURN(canvasId, error, NO);
    
    AgoraRteCanvasConfig *canvasConfig = [[AgoraRteCanvasConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    
    if (config[@"videoRenderMode"] && config[@"videoRenderMode"] != [NSNull null]) {
        [canvasConfig setVideoRenderMode:(AgoraRteVideoRenderMode)[config[@"videoRenderMode"] intValue] error:rteError];
    }
    if (config[@"videoMirrorMode"] && config[@"videoMirrorMode"] != [NSNull null]) {
        [canvasConfig setVideoMirrorMode:(AgoraRteVideoMirrorMode)[config[@"videoMirrorMode"] intValue] error:rteError];
    }
    if (config[@"cropArea"] && config[@"cropArea"] != [NSNull null]) {
        NSDictionary *cropAreaDict = config[@"cropArea"];
        AgoraRteRect *rect = [[AgoraRteRect alloc] init];
        [rect setX:[cropAreaDict[@"x"] intValue]];
        [rect setY:[cropAreaDict[@"y"] intValue]];
        [rect setWidth:[cropAreaDict[@"width"] intValue]];
        [rect setHeight:[cropAreaDict[@"height"] intValue]];
        [canvasConfig setCropArea:rect error:rteError];
    }
    
    AgoraRteError *setError = [[AgoraRteError alloc] init];
    BOOL success = [canvas setConfigs:canvasConfig error:setError];
    
    if (!success || setError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(setError);
        return NO;
    }
    return YES;
}

- (NSDictionary *)canvasGetConfig:(NSString *)canvasId error:(NSError **)error {
    AgoraRteCanvas *canvas = self.canvases[canvasId];
    if (!canvas) {
        if (error) *error = RTE_NSERROR(-1, @"Canvas not found");
        return nil;
    }
    
    AgoraRteCanvasConfig *config = [[AgoraRteCanvasConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    
    BOOL success = [canvas getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return nil;
    }
    
    AgoraRteError *getError = [[AgoraRteError alloc] init];
    AgoraRteRect *cropArea = [config cropArea:getError];
    
    return @{
        @"videoRenderMode": @([config videoRenderMode:getError]),
        @"videoMirrorMode": @([config videoMirrorMode:getError]),
        @"cropArea": @{
            @"x": @([cropArea x]),
            @"y": @([cropArea y]),
            @"width": @([cropArea width]),
            @"height": @([cropArea height])
        }
    };
}

#pragma mark - RTE Canvas View

- (BOOL)canvasAddView:(NSString *)canvasId view:(UIView *)view config:(NSDictionary *)config error:(NSError **)error {
    GET_CANVAS_OR_RETURN(canvasId, error, NO);
    
    AgoraRteViewConfig *viewConfig = nil;
    if (config && config.count > 0) {
        viewConfig = [[AgoraRteViewConfig alloc] init];
        if (config[@"cropArea"]) {
            NSDictionary *cropAreaDict = config[@"cropArea"];
            AgoraRteRect *rect = [[AgoraRteRect alloc] init];
            [rect setX:[cropAreaDict[@"x"] intValue]];
            [rect setY:[cropAreaDict[@"y"] intValue]];
            [rect setWidth:[cropAreaDict[@"width"] intValue]];
            [rect setHeight:[cropAreaDict[@"height"] intValue]];
            AgoraRteError *rteError = [[AgoraRteError alloc] init];
            [viewConfig setCropArea:rect error:rteError];
        }
    }
    
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [canvas addView:view config:viewConfig error:rteError];
    
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    return YES;
}

- (BOOL)canvasRemoveView:(NSString *)canvasId view:(UIView *)view config:(NSDictionary *)config error:(NSError **)error {
    GET_CANVAS_OR_RETURN(canvasId, error, NO);
    
    AgoraRteViewConfig *viewConfig = nil;
    if (config && config.count > 0) {
        viewConfig = [[AgoraRteViewConfig alloc] init];
        if (config[@"cropArea"]) {
            NSDictionary *cropAreaDict = config[@"cropArea"];
            AgoraRteRect *rect = [[AgoraRteRect alloc] init];
            [rect setX:[cropAreaDict[@"x"] intValue]];
            [rect setY:[cropAreaDict[@"y"] intValue]];
            [rect setWidth:[cropAreaDict[@"width"] intValue]];
            [rect setHeight:[cropAreaDict[@"height"] intValue]];
            AgoraRteError *rteError = [[AgoraRteError alloc] init];
            [viewConfig setCropArea:rect error:rteError];
        }
    }
    
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [canvas removeView:view config:viewConfig error:rteError];
    
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    return YES;
}

#pragma mark - RTE Player Canvas Bindng

- (BOOL)playerSetCanvas:(NSString *)playerId canvasId:(NSString *)canvasId error:(NSError **)error {
    GET_PLAYER_OR_RETURN(playerId, error, NO);
    GET_CANVAS_OR_RETURN(canvasId, error, NO);
    
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [player setCanvas:canvas error:rteError];
    
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    return YES;
}

@end
