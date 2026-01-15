#import <Foundation/Foundation.h>
#import <AgoraRtcKit/AgoraRteKit.h>
#import "AgoraRTEPlayerObserverDelegate.h"

/// RTE Player 管理类
@interface AgoraRTEPlayer : NSObject

@property (nonatomic, weak) id<AgoraRTEPlayerObserverDelegate> observerDelegate;
@property (nonatomic, strong, readonly) NSMutableDictionary<NSString *, AgoraRtePlayer *> *players;
@property (nonatomic, strong, readonly) NSMutableDictionary<NSString *, AgoraRtePlayerObserver *> *playerObservers;

- (instancetype)initWithRte:(AgoraRte *)rte;

/// 预加载 URL
+ (BOOL)preloadWithUrl:(NSString *)url error:(NSError **)error;

/// 创建播放器
- (NSString *)createPlayer:(NSDictionary *)config error:(NSError **)error;

/// 销毁播放器
- (BOOL)destroyPlayer:(NSString *)playerId error:(NSError **)error;

#pragma mark - Player Playback Control

/// 打开 URL
- (BOOL)openUrl:(NSString *)playerId url:(NSString *)url startTime:(uint64_t)startTime completion:(void (^)(NSError *error))completion error:(NSError **)error;

/// 使用自定义源提供者打开
- (BOOL)openWithCustomSourceProvider:(NSString *)playerId provider:(void *)provider startTime:(uint64_t)startTime completion:(void (^)(NSError *error))completion error:(NSError **)error;

/// 使用流打开
- (BOOL)openWithStream:(NSString *)playerId stream:(void *)stream completion:(void (^)(NSError *error))completion error:(NSError **)error;

/// 切换 URL
- (BOOL)switchWithUrl:(NSString *)playerId url:(NSString *)url syncPts:(BOOL)syncPts completion:(void (^)(NSError *error))completion error:(NSError **)error;

/// 设置 Canvas
- (BOOL)setCanvas:(NSString *)playerId canvas:(AgoraRteCanvas *)canvas error:(NSError **)error;

/// 播放
- (BOOL)play:(NSString *)playerId error:(NSError **)error;

/// 暂停
- (BOOL)pause:(NSString *)playerId error:(NSError **)error;

/// 停止
- (BOOL)stop:(NSString *)playerId error:(NSError **)error;

/// 跳转
- (BOOL)seek:(NSString *)playerId position:(uint64_t)position error:(NSError **)error;

/// 静音音频
- (BOOL)muteAudio:(NSString *)playerId mute:(BOOL)mute error:(NSError **)error;

/// 静音视频
- (BOOL)muteVideo:(NSString *)playerId mute:(BOOL)mute error:(NSError **)error;

#pragma mark - Player Info

/// 获取统计信息
- (void)getStats:(NSString *)playerId completion:(void (^)(NSDictionary *stats, NSError *error))completion;

/// 获取当前时间
- (int64_t)getCurrentTime:(NSString *)playerId error:(NSError **)error;

/// 获取时长
- (int64_t)getDuration:(NSString *)playerId error:(NSError **)error;

/// 获取播放器信息
- (NSDictionary *)getInfo:(NSString *)playerId error:(NSError **)error;

#pragma mark - Player Config

/// 批量设置配置
- (BOOL)setConfigs:(NSString *)playerId config:(NSDictionary *)config error:(NSError **)error;

/// 获取配置
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

/// 注册观察者
- (BOOL)registerObserver:(NSString *)playerId error:(NSError **)error;

/// 注销观察者
- (BOOL)unregisterObserver:(NSString *)playerId error:(NSError **)error;

@end

