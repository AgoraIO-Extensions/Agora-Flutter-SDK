#import <Foundation/Foundation.h>
#import "RtcEngineRegistry.h"
#import "RtcEnginePlugin.h"
#import "RtcEnginePluginRegistrant.h"

@implementation RtcEnginePluginRegistrant : NSObject

+ (void)register:(NSObject<RtcEnginePlugin> *)plugin {
    [[RtcEngineRegistry shared] add:plugin];
}

+ (void)unregister:(NSObject<RtcEnginePlugin> *)plugin {
    [[RtcEngineRegistry shared] remove:plugin];
}
@end
