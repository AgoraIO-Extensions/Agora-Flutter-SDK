#import <Foundation/Foundation.h>

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
