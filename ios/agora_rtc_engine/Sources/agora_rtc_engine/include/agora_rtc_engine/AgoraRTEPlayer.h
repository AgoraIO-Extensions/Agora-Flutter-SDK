#import <Foundation/Foundation.h>
#import <AgoraRtcKit/AgoraRteKit.h>
#import "AgoraRTEPlayerObserverDelegate.h"

/// RTE Player Manager
@interface AgoraRTEPlayer : NSObject

@property (nonatomic, weak) id<AgoraRTEPlayerObserverDelegate> observerDelegate;
@property (nonatomic, strong, readonly) NSMutableDictionary<NSString *, AgoraRtePlayer *> *players;
@property (nonatomic, strong, readonly) NSMutableDictionary<NSString *, AgoraRtePlayerObserver *> *playerObservers;

- (instancetype)initWithRte:(AgoraRte *)rte;

/// Preload URL
+ (BOOL)preloadWithUrl:(NSString *)url error:(NSError **)error;

/// Create player
- (NSString *)createPlayer:(NSDictionary *)config error:(NSError **)error;

/// Destroy player
- (BOOL)destroyPlayer:(NSString *)playerId error:(NSError **)error;

#pragma mark - Player Playback Control

/// Open URL
- (BOOL)openUrl:(NSString *)playerId url:(NSString *)url startTime:(uint64_t)startTime completion:(void (^)(NSError *error))completion error:(NSError **)error;

/// Open with custom source provider
- (BOOL)openWithCustomSourceProvider:(NSString *)playerId provider:(void *)provider startTime:(uint64_t)startTime completion:(void (^)(NSError *error))completion error:(NSError **)error;

/// Open with stream
- (BOOL)openWithStream:(NSString *)playerId stream:(void *)stream completion:(void (^)(NSError *error))completion error:(NSError **)error;

/// Switch URL
- (BOOL)switchWithUrl:(NSString *)playerId url:(NSString *)url syncPts:(BOOL)syncPts completion:(void (^)(NSError *error))completion error:(NSError **)error;

/// Set canvas
- (BOOL)setCanvas:(NSString *)playerId canvas:(AgoraRteCanvas *)canvas error:(NSError **)error;

/// Play
- (BOOL)play:(NSString *)playerId error:(NSError **)error;

/// Pause
- (BOOL)pause:(NSString *)playerId error:(NSError **)error;

/// Stop
- (BOOL)stop:(NSString *)playerId error:(NSError **)error;

/// Seek
- (BOOL)seek:(NSString *)playerId position:(uint64_t)position error:(NSError **)error;

/// Mute audio
- (BOOL)muteAudio:(NSString *)playerId mute:(BOOL)mute error:(NSError **)error;

/// Mute video
- (BOOL)muteVideo:(NSString *)playerId mute:(BOOL)mute error:(NSError **)error;

#pragma mark - Player Info

/// Get stats
- (void)getStats:(NSString *)playerId completion:(void (^)(NSDictionary *stats, NSError *error))completion;

/// Get current time
- (int64_t)getCurrentTime:(NSString *)playerId error:(NSError **)error;

/// Get duration
- (int64_t)getDuration:(NSString *)playerId error:(NSError **)error;

/// Get player info
- (NSDictionary *)getInfo:(NSString *)playerId error:(NSError **)error;

#pragma mark - Player Config

/// Set configs
- (BOOL)setConfigs:(NSString *)playerId config:(NSDictionary *)config error:(NSError **)error;

/// Get configs
- (NSDictionary *)getConfigs:(NSString *)playerId error:(NSError **)error;

// Individual Config Setters/Getters
- (BOOL)setAutoPlay:(NSString *)playerId autoPlay:(BOOL)autoPlay error:(NSError **)error;
- (BOOL)getAutoPlay:(NSString *)playerId error:(NSError **)error;
- (BOOL)setPlaybackSpeed:(NSString *)playerId speed:(int32_t)speed error:(NSError **)error;
- (int32_t)getPlaybackSpeed:(NSString *)playerId error:(NSError **)error;
- (BOOL)setPlayoutAudioTrackIdx:(NSString *)playerId idx:(int32_t)idx error:(NSError **)error;
- (int32_t)getPlayoutAudioTrackIdx:(NSString *)playerId error:(NSError **)error;
- (BOOL)setPublishAudioTrackIdx:(NSString *)playerId idx:(int32_t)idx error:(NSError **)error;
- (int32_t)getPublishAudioTrackIdx:(NSString *)playerId error:(NSError **)error;
- (BOOL)setAudioTrackIdx:(NSString *)playerId idx:(int32_t)idx error:(NSError **)error;
- (int32_t)getAudioTrackIdx:(NSString *)playerId error:(NSError **)error;
- (BOOL)setSubtitleTrackIdx:(NSString *)playerId idx:(int32_t)idx error:(NSError **)error;
- (int32_t)getSubtitleTrackIdx:(NSString *)playerId error:(NSError **)error;
- (BOOL)setExternalSubtitleTrackIdx:(NSString *)playerId idx:(int32_t)idx error:(NSError **)error;
- (int32_t)getExternalSubtitleTrackIdx:(NSString *)playerId error:(NSError **)error;
- (BOOL)setAudioPitch:(NSString *)playerId pitch:(int32_t)pitch error:(NSError **)error;
- (int32_t)getAudioPitch:(NSString *)playerId error:(NSError **)error;
- (BOOL)setPlayoutVolume:(NSString *)playerId volume:(int32_t)volume error:(NSError **)error;
- (int32_t)getPlayoutVolume:(NSString *)playerId error:(NSError **)error;
- (BOOL)setAudioPlaybackDelay:(NSString *)playerId delay:(int32_t)delay error:(NSError **)error;
- (int32_t)getAudioPlaybackDelay:(NSString *)playerId error:(NSError **)error;
- (BOOL)setAudioDualMonoMode:(NSString *)playerId mode:(int32_t)mode error:(NSError **)error;
- (int32_t)getAudioDualMonoMode:(NSString *)playerId error:(NSError **)error;
- (BOOL)setPublishVolume:(NSString *)playerId volume:(int32_t)volume error:(NSError **)error;
- (int32_t)getPublishVolume:(NSString *)playerId error:(NSError **)error;
- (BOOL)setLoopCount:(NSString *)playerId count:(int32_t)count error:(NSError **)error;
- (int32_t)getLoopCount:(NSString *)playerId error:(NSError **)error;
- (BOOL)setJsonParameter:(NSString *)playerId jsonParameter:(NSString *)jsonParameter error:(NSError **)error;
- (NSString *)getJsonParameter:(NSString *)playerId error:(NSError **)error;
- (BOOL)setAbrSubscriptionLayer:(NSString *)playerId layer:(AgoraRteAbrSubscriptionLayer)layer error:(NSError **)error;
- (AgoraRteAbrSubscriptionLayer)getAbrSubscriptionLayer:(NSString *)playerId error:(NSError **)error;
- (BOOL)setAbrFallbackLayer:(NSString *)playerId layer:(AgoraRteAbrFallbackLayer)layer error:(NSError **)error;
- (AgoraRteAbrFallbackLayer)getAbrFallbackLayer:(NSString *)playerId error:(NSError **)error;

#pragma mark - Player Observer

/// Register observer
- (BOOL)registerObserver:(NSString *)playerId error:(NSError **)error;

/// Unregister observer
- (BOOL)unregisterObserver:(NSString *)playerId error:(NSError **)error;

@end

