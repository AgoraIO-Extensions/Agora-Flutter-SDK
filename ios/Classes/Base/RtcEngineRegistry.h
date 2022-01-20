#ifndef RtcEngineRegistry_h
#define RtcEngineRegistry_h

#import "RtcEnginePlugin.h"

/**
 * The `RtcEngineRegistry` is response to add, remove and notify the callback when `RtcEngine` is created
 * from flutter side.
 */
@interface RtcEngineRegistry : NSObject <RtcEnginePlugin>
+ (RtcEngineRegistry *)shared;

/**
 * Add a `RtcEnginePlugin`.
 */
- (void)add:(NSObject<RtcEnginePlugin>*) plugin;

/**
 * Remove the previously added `RtcEnginePlugin`.
 */
- (void)remove:(NSObject<RtcEnginePlugin>*) plugin;
@end

#endif /* RtcEngineRegistry_h */
