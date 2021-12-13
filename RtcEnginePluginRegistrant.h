#ifndef RtcEnginePluginRegistrant_h
#define RtcEnginePluginRegistrant_h

#import <Foundation/Foundation.h>
#import "RtcEnginePlugin.h"

/**
 * Class for register the `RtcEnginePlugin`.
 */
@interface RtcEnginePluginRegistrant : NSObject

/**
 * Register a `RtcEnginePlugin`. The `plugin` will be called when the `RtcEngine` is created from
 * flutter side.
 */
+(void)register:(NSObject<RtcEnginePlugin> *_Nonnull)plugin;

/**
 * Unregister a previously registered `RtcEnginePlugin`.
 */
+(void)unregister:(NSObject<RtcEnginePlugin> *_Nonnull)plugin;

@end

#endif /* RtcEnginePluginRegistrant_h */
