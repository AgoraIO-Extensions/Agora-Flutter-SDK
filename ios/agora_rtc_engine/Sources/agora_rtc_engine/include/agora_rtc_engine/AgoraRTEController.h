#import <Foundation/Foundation.h>
#import <AgoraRtcKit/AgoraRteKit.h>
#import "AgoraRTE.h"
#import "AgoraRTEConfig.h"
#import "AgoraRTEPlayerObserverDelegate.h"
#import "AgoraRTEPlayer.h"
#import "AgoraRTECanvas.h"

#pragma mark - AgoraRTEControllerDelegate

@protocol AgoraRTEControllerDelegate <NSObject>
@optional
- (void)rteErrorOccurred:(NSInteger)code message:(NSString *)message;
@end

#pragma mark - AgoraRTEController

@interface AgoraRTEController : NSObject

@property (nonatomic, weak) id<AgoraRTEControllerDelegate> delegate;
@property (nonatomic, weak) id<AgoraRTEPlayerObserverDelegate> playerObserverDelegate;

// 使用新的分离类
@property (nonatomic, strong, readonly) AgoraRTE *rte;
@property (nonatomic, strong, readonly) AgoraRTEConfig *rteConfig;
@property (nonatomic, strong, readonly) AgoraRTEPlayer *rtePlayer;
@property (nonatomic, strong, readonly) AgoraRTECanvas *rteCanvas;

- (instancetype)init;

// #pragma mark - RTE Lifecycle
 - (BOOL)createRteFromBridge:(NSError **)error;
 - (BOOL)createRteWithConfig:(NSDictionary *)config error:(NSError **)error;
 - (BOOL)initMediaEngine:(void (^)(NSError *error))completion error:(NSError **)error;
 - (BOOL)destroyRte:(NSError **)error;

#pragma mark - RTE Config
- (BOOL)setRteConfig:(NSDictionary *)config error:(NSError **)error;
- (NSDictionary *)getRteConfig:(NSError **)error;
- (NSString *)appId:(NSError **)error;
- (BOOL)setAppId:(NSString *)appId error:(NSError **)error;
- (NSString *)logFolder:(NSError **)error;
- (BOOL)setLogFolder:(NSString *)logFolder error:(NSError **)error;
- (NSNumber *)logFileSize:(NSError **)error;
- (BOOL)setLogFileSize:(NSNumber *)logFileSize error:(NSError **)error;
- (NSNumber *)areaCode:(NSError **)error;
- (BOOL)setAreaCode:(NSNumber *)areaCode error:(NSError **)error;
- (NSString *)cloudProxy:(NSError **)error;
- (BOOL)setCloudProxy:(NSString *)cloudProxy error:(NSError **)error;
- (NSString *)jsonParameter:(NSError **)error;
- (BOOL)setJsonParameter:(NSString *)jsonParameter error:(NSError **)error;

// #pragma mark - RTE Observer
//- (BOOL)registerRteObserver:(NSError **)error;
//- (BOOL)unregisterRteObserver:(NSError **)error;

#pragma mark - RTE Canvas Config
- (BOOL)canvasSetVideoRenderMode:(NSString *)canvasId mode:(AgoraRteVideoRenderMode)mode error:(NSError **)error;
- (AgoraRteVideoRenderMode)canvasGetVideoRenderMode:(NSString *)canvasId error:(NSError **)error;
- (BOOL)canvasSetVideoMirrorMode:(NSString *)canvasId mode:(AgoraRteVideoMirrorMode)mode error:(NSError **)error;
- (AgoraRteVideoMirrorMode)canvasGetVideoMirrorMode:(NSString *)canvasId error:(NSError **)error;
- (BOOL)canvasSetCropArea:(NSString *)canvasId x:(int32_t)x y:(int32_t)y width:(int32_t)width height:(int32_t)height error:(NSError **)error;
- (NSDictionary *)canvasGetCropArea:(NSString *)canvasId error:(NSError **)error;

#pragma mark - RTE Canvas Lifecycle
- (NSString *)createCanvas:(NSDictionary *)config error:(NSError **)error;
- (BOOL)destroyCanvas:(NSString *)canvasId error:(NSError **)error;
- (BOOL)canvasSetConfig:(NSString *)canvasId config:(NSDictionary *)config error:(NSError **)error;
- (NSDictionary *)canvasGetConfig:(NSString *)canvasId error:(NSError **)error;
- (BOOL)canvasAddView:(NSString *)canvasId view:(UIView *)view config:(NSDictionary *)config error:(NSError **)error;
- (BOOL)canvasRemoveView:(NSString *)canvasId view:(UIView *)view config:(NSDictionary *)config error:(NSError **)error;

#pragma mark - RTE AgoraRtePlayerConfig
- (BOOL)playerSetAutoPlay:(NSString *)playerId autoPlay:(BOOL)autoPlay error:(NSError **)error;
- (BOOL)playerGetAutoPlay:(NSString *)playerId error:(NSError **)error;
- (BOOL)playerSetPlaybackSpeed:(NSString *)playerId speed:(int32_t)speed error:(NSError **)error;
- (int32_t)playerGetPlaybackSpeed:(NSString *)playerId error:(NSError **)error;
- (BOOL)playerSetPlayoutAudioTrackIdx:(NSString *)playerId idx:(int32_t)idx error:(NSError **)error;
- (int32_t)playerGetPlayoutAudioTrackIdx:(NSString *)playerId error:(NSError **)error;
- (BOOL)playerSetPublishAudioTrackIdx:(NSString *)playerId idx:(int32_t)idx error:(NSError **)error;
- (int32_t)playerGetPublishAudioTrackIdx:(NSString *)playerId error:(NSError **)error;
- (BOOL)playerSetAudioTrackIdx:(NSString *)playerId idx:(int32_t)idx error:(NSError **)error;
- (int32_t)playerGetAudioTrackIdx:(NSString *)playerId error:(NSError **)error;
- (BOOL)playerSetSubtitleTrackIdx:(NSString *)playerId idx:(int32_t)idx error:(NSError **)error;
- (int32_t)playerGetSubtitleTrackIdx:(NSString *)playerId error:(NSError **)error;
- (BOOL)playerSetExternalSubtitleTrackIdx:(NSString *)playerId idx:(int32_t)idx error:(NSError **)error;
- (int32_t)playerGetExternalSubtitleTrackIdx:(NSString *)playerId error:(NSError **)error;
- (BOOL)playerSetAudioPitch:(NSString *)playerId pitch:(int32_t)pitch error:(NSError **)error;
- (int32_t)playerGetAudioPitch:(NSString *)playerId error:(NSError **)error;
- (BOOL)playerSetPlayoutVolume:(NSString *)playerId volume:(int32_t)volume error:(NSError **)error;
- (int32_t)playerGetPlayoutVolume:(NSString *)playerId error:(NSError **)error;
- (BOOL)playerSetAudioPlaybackDelay:(NSString *)playerId delay:(int32_t)delay error:(NSError **)error;
- (int32_t)playerGetAudioPlaybackDelay:(NSString *)playerId error:(NSError **)error;
- (BOOL)playerSetAudioDualMonoMode:(NSString *)playerId mode:(int32_t)mode error:(NSError **)error;
- (int32_t)playerGetAudioDualMonoMode:(NSString *)playerId error:(NSError **)error;
- (BOOL)playerSetPublishVolume:(NSString *)playerId volume:(int32_t)volume error:(NSError **)error;
- (int32_t)playerGetPublishVolume:(NSString *)playerId error:(NSError **)error;
- (BOOL)playerSetLoopCount:(NSString *)playerId count:(int32_t)count error:(NSError **)error;
- (int32_t)playerGetLoopCount:(NSString *)playerId error:(NSError **)error;
- (BOOL)playerSetJsonParameter:(NSString *)playerId jsonParameter:(NSString *)jsonParameter error:(NSError **)error;
- (NSString *)playerGetJsonParameter:(NSString *)playerId error:(NSError **)error;
- (BOOL)playerSetAbrSubscriptionLayer:(NSString *)playerId layer:(AgoraRteAbrSubscriptionLayer)layer error:(NSError **)error;
- (AgoraRteAbrSubscriptionLayer)playerGetAbrSubscriptionLayer:(NSString *)playerId error:(NSError **)error;
- (BOOL)playerSetAbrFallbackLayer:(NSString *)playerId layer:(AgoraRteAbrFallbackLayer)layer error:(NSError **)error;
- (AgoraRteAbrFallbackLayer)playerGetAbrFallbackLayer:(NSString *)playerId error:(NSError **)error;

#pragma mark - RTE Player Playback Control
+ (BOOL)preloadWithUrl:(NSString *)url error:(NSError **)error;
- (NSString *)createPlayer:(NSDictionary *)config error:(NSError **)error;
- (BOOL)playerOpenUrl:(NSString *)playerId url:(NSString *)url startTime:(uint64_t)startTime completion:(void (^)(NSError *error))completion error:(NSError **)error;
- (BOOL)playerOpenWithCustomSourceProvider:(NSString *)playerId provider:(void *)provider startTime:(uint64_t)startTime completion:(void (^)(NSError *error))completion error:(NSError **)error;
- (BOOL)playerOpenWithStream:(NSString *)playerId stream:(void *)stream completion:(void (^)(NSError *error))completion error:(NSError **)error;
- (BOOL)playerSwitch:(NSString *)playerId url:(NSString *)url syncPts:(BOOL)syncPts completion:(void (^)(NSError *error))completion error:(NSError **)error;
// RTE Player Canvas bindng
- (BOOL)playerSetCanvas:(NSString *)playerId canvasId:(NSString *)canvasId error:(NSError **)error;

- (BOOL)playerPlay:(NSString *)playerId error:(NSError **)error;
- (BOOL)playerPause:(NSString *)playerId error:(NSError **)error;
- (BOOL)playerStop:(NSString *)playerId error:(NSError **)error;
- (BOOL)playerSeek:(NSString *)playerId position:(uint64_t)position error:(NSError **)error;
- (BOOL)playerMuteAudio:(NSString *)playerId mute:(BOOL)mute error:(NSError **)error;
- (BOOL)playerMuteVideo:(NSString *)playerId mute:(BOOL)mute error:(NSError **)error;

// RTE Player Info
- (void)playerGetStats:(NSString *)playerId completion:(void (^)(NSDictionary *stats, NSError *error))completion;
- (int64_t)playerGetCurrentTime:(NSString *)playerId error:(NSError **)error;
- (int64_t)playerGetDuration:(NSString *)playerId error:(NSError **)error;
- (NSDictionary *)playerGetInfo:(NSString *)playerId error:(NSError **)error;
// RTE Player Config
- (BOOL)playerSetConfig:(NSString *)playerId config:(NSDictionary *)config error:(NSError **)error;
- (NSDictionary *)playerGetConfig:(NSString *)playerId error:(NSError **)error;

// RTE Player Observer
- (BOOL)playerRegisterObserver:(NSString *)playerId error:(NSError **)error;
- (BOOL)destroyPlayer:(NSString *)playerId error:(NSError **)error;
- (BOOL)playerUnregisterObserver:(NSString *)playerId error:(NSError **)error;


@end
