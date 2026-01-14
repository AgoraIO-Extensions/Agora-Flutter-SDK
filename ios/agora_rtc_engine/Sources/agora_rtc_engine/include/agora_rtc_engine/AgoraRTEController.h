#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <AgoraRtcKit/AgoraRtcKit.h>

// Forward declarations
@class AgoraRte;
@class AgoraRtePlayer;
@class AgoraRteCanvas;
@class AgoraRteObserver;
@class AgoraRtePlayerObserver;
@class AgoraRteError;

#pragma mark - AgoraRTEPlayerObserverDelegate

@protocol AgoraRTEPlayerObserverDelegate <NSObject>
@optional
- (void)player:(NSString *)playerId onStateChanged:(NSInteger)oldState newState:(NSInteger)newState errorCode:(NSInteger)errorCode errorMessage:(NSString *)errorMessage;
- (void)player:(NSString *)playerId onPositionChanged:(uint64_t)currentTime utcTime:(uint64_t)utcTime;
- (void)player:(NSString *)playerId onResolutionChanged:(int)width height:(int)height;
- (void)player:(NSString *)playerId onEvent:(NSInteger)event;
- (void)player:(NSString *)playerId onMetadata:(NSInteger)type data:(NSData *)data;
- (void)player:(NSString *)playerId onPlayerInfoUpdated:(NSDictionary *)info;
- (void)player:(NSString *)playerId onAudioVolumeIndication:(int32_t)volume;
@end

#pragma mark - AgoraRTEControllerDelegate

@protocol AgoraRTEControllerDelegate <NSObject>
@optional
- (void)rteErrorOccurred:(NSInteger)code message:(NSString *)message;
@end

#pragma mark - AgoraRTEController

@interface AgoraRTEController : NSObject

@property (nonatomic, weak) id<AgoraRTEControllerDelegate> delegate;
@property (nonatomic, weak) id<AgoraRTEPlayerObserverDelegate> playerObserverDelegate;
@property (nonatomic, strong) AgoraRte *rteInstance;
@property (nonatomic, strong) NSMutableDictionary<NSString *, AgoraRtePlayer *> *players;
@property (nonatomic, strong) NSMutableDictionary<NSString *, AgoraRteCanvas *> *canvases;
@property (nonatomic, strong) NSMutableDictionary<NSString *, AgoraRtePlayerObserver *> *playerObservers;

- (instancetype)init;

#pragma mark - RTE Lifecycle
- (BOOL)createRteFromBridge:(NSError **)error;
- (BOOL)createRteWithConfig:(NSDictionary *)config error:(NSError **)error;
- (BOOL)initMediaEngine:(void (^)(NSError *error))completion error:(NSError **)error;
- (BOOL)destroyRte:(NSError **)error;

#pragma mark - RTE Config
- (BOOL)setRteConfig:(NSDictionary *)config error:(NSError **)error;
- (NSDictionary *)getRteConfig:(NSError **)error;

#pragma mark - RTE Observer
- (BOOL)registerRteObserver:(NSError **)error;
- (BOOL)unregisterRteObserver:(NSError **)error;

#pragma mark - RTE Player Lifecycle
+ (BOOL)preloadWithUrl:(NSString *)url error:(NSError **)error;
- (NSString *)createPlayer:(NSDictionary *)config error:(NSError **)error;
- (BOOL)destroyPlayer:(NSString *)playerId error:(NSError **)error;

#pragma mark - RTE Player Playback Control
- (BOOL)playerOpenUrl:(NSString *)playerId url:(NSString *)url startTime:(uint64_t)startTime completion:(void (^)(NSError *error))completion error:(NSError **)error;
- (BOOL)playerOpenWithCustomSourceProvider:(NSString *)playerId provider:(void *)provider startTime:(uint64_t)startTime completion:(void (^)(NSError *error))completion error:(NSError **)error;
- (BOOL)playerOpenWithStream:(NSString *)playerId stream:(void *)stream completion:(void (^)(NSError *error))completion error:(NSError **)error;
- (BOOL)playerPlay:(NSString *)playerId error:(NSError **)error;
- (BOOL)playerPause:(NSString *)playerId error:(NSError **)error;
- (BOOL)playerStop:(NSString *)playerId error:(NSError **)error;
- (BOOL)playerSeek:(NSString *)playerId position:(uint64_t)position error:(NSError **)error;
- (BOOL)playerMuteAudio:(NSString *)playerId mute:(BOOL)mute error:(NSError **)error;
- (BOOL)playerMuteVideo:(NSString *)playerId mute:(BOOL)mute error:(NSError **)error;
- (BOOL)playerSetPlaybackSpeed:(NSString *)playerId speed:(int32_t)speed error:(NSError **)error;
- (int32_t)playerGetPlaybackSpeed:(NSString *)playerId error:(NSError **)error;
- (BOOL)playerSetPlayoutVolume:(NSString *)playerId volume:(int32_t)volume error:(NSError **)error;
- (int32_t)playerGetPlayoutVolume:(NSString *)playerId error:(NSError **)error;
- (BOOL)playerSetLoopCount:(NSString *)playerId count:(int32_t)count error:(NSError **)error;
- (int32_t)playerGetLoopCount:(NSString *)playerId error:(NSError **)error;
- (BOOL)playerSwitch:(NSString *)playerId url:(NSString *)url syncPts:(BOOL)syncPts completion:(void (^)(NSError *error))completion error:(NSError **)error;

#pragma mark - RTE Player Info
- (int64_t)playerGetCurrentTime:(NSString *)playerId error:(NSError **)error;
- (int64_t)playerGetDuration:(NSString *)playerId error:(NSError **)error;
- (NSDictionary *)playerGetInfo:(NSString *)playerId error:(NSError **)error;
- (void)playerGetStats:(NSString *)playerId completion:(void (^)(NSDictionary *stats, NSError *error))completion;

#pragma mark - RTE Player Config
- (BOOL)playerSetConfig:(NSString *)playerId config:(NSDictionary *)config error:(NSError **)error;
- (NSDictionary *)playerGetConfig:(NSString *)playerId error:(NSError **)error;

#pragma mark - RTE Player Observer
- (BOOL)playerRegisterObserver:(NSString *)playerId error:(NSError **)error;
- (BOOL)playerUnregisterObserver:(NSString *)playerId error:(NSError **)error;

#pragma mark - RTE Canvas Lifecycle
- (NSString *)createCanvas:(NSDictionary *)config error:(NSError **)error;
- (BOOL)destroyCanvas:(NSString *)canvasId error:(NSError **)error;

#pragma mark - RTE Canvas Config
- (BOOL)canvasSetConfig:(NSString *)canvasId config:(NSDictionary *)config error:(NSError **)error;
- (NSDictionary *)canvasGetConfig:(NSString *)canvasId error:(NSError **)error;

#pragma mark - RTE Canvas View
- (BOOL)canvasAddView:(NSString *)canvasId view:(UIView *)view config:(NSDictionary *)config error:(NSError **)error;
- (BOOL)canvasRemoveView:(NSString *)canvasId view:(UIView *)view config:(NSDictionary *)config error:(NSError **)error;

#pragma mark - RTE Player Canvas bindng
- (BOOL)playerSetCanvas:(NSString *)playerId canvasId:(NSString *)canvasId error:(NSError **)error;

@end
