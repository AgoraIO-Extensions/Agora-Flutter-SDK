//
//  AgoraAudioFrameObserver.h
//  react-native-agora-rawdata
//
//  Created by LXH on 2020/11/10.
//

#import <Foundation/Foundation.h>

#import "AgoraAudioFrame.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AgoraAudioFrameDelegate <NSObject>
@required
- (BOOL)onRecordAudioFrame:(AgoraAudioFrame *_Nonnull)audioFrame;

- (BOOL)onPlaybackAudioFrame:(AgoraAudioFrame *_Nonnull)audioFrame;

- (BOOL)onMixedAudioFrame:(AgoraAudioFrame *_Nonnull)audioFrame;

- (BOOL)onPlaybackAudioFrameBeforeMixing:(AgoraAudioFrame *_Nonnull)audioFrame
                                     uid:(NSUInteger)uid;

@optional
- (BOOL)isMultipleChannelFrameWanted;

- (BOOL)onPlaybackAudioFrameBeforeMixingEx:(AgoraAudioFrame *_Nonnull)audioFrame
                                 channelId:(NSString *_Nonnull)channelId
                                       uid:(NSUInteger)uid;
@end

@interface AgoraAudioFrameObserver : NSObject
@property(nonatomic, assign) NSUInteger engineHandle;
@property(nonatomic, weak) id<AgoraAudioFrameDelegate> _Nullable delegate;

- (instancetype)initWithEngineHandle:(NSUInteger)engineHandle;

- (void)registerAudioFrameObserver;

- (void)unregisterAudioFrameObserver;
@end

NS_ASSUME_NONNULL_END
