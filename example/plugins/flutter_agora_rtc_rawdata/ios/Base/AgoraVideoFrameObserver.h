//
//  AgoraVideoFrameObserver.h
//  react-native-agora-rawdata
//
//  Created by LXH on 2020/11/10.
//

#import <Foundation/Foundation.h>

#import "AgoraVideoFrame.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AgoraVideoFrameDelegate <NSObject>
@required
- (BOOL)onCaptureVideoFrame:(AgoraVideoFrame *_Nonnull)videoFrame;
- (BOOL)onRenderVideoFrame:(AgoraVideoFrame *_Nonnull)videoFrame
                       uid:(NSUInteger)uid;
@optional
- (BOOL)onPreEncodeVideoFrame:(AgoraVideoFrame *_Nonnull)videoFrame;
- (AgoraVideoFrameType)getVideoFormatPreference;
- (BOOL)getRotationApplied;
- (BOOL)getMirrorApplied;
- (BOOL)getSmoothRenderingEnabled;
- (uint32_t)getObservedFramePosition;
- (BOOL)isMultipleChannelFrameWanted;
- (BOOL)onRenderVideoFrameEx:(AgoraVideoFrame *_Nonnull)videoFrame
                   channelId:(NSString *_Nonnull)channelId
                         uid:(NSUInteger)uid;
@end

@interface AgoraVideoFrameObserver : NSObject
@property(nonatomic, assign) NSUInteger engineHandle;
@property(nonatomic, weak) id<AgoraVideoFrameDelegate> _Nullable delegate;

- (instancetype)initWithEngineHandle:(NSUInteger)engineHandle;

- (void)registerVideoFrameObserver;

- (void)unregisterVideoFrameObserver;
@end

NS_ASSUME_NONNULL_END
