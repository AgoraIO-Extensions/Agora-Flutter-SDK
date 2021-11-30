#import <Foundation/Foundation.h>
#import "RtcEngineRegistry.h"

@interface RtcEngineRegistry()
@property(nonatomic) NSMutableDictionary<id, NSObject<RtcEnginePlugin>*> *plugins;
@end

@implementation RtcEngineRegistry

-(id)init {
     if (self = [super init])  {
         self.plugins = [[NSMutableDictionary alloc]initWithCapacity:2];
     }
     return self;
}

static RtcEngineRegistry *_rtcEngineRegistryOC = nil;

+ (RtcEngineRegistry *)shared {
    @synchronized([RtcEngineRegistry class]) {
        if (!_rtcEngineRegistryOC)
            _rtcEngineRegistryOC = [[self alloc] init];
        return _rtcEngineRegistryOC;
    }
    return nil;
}

- (void)add:(NSObject<RtcEnginePlugin>*) plugin {
    [[self plugins] setObject:plugin forKey:(id)[plugin class]];
}

- (void)remove:(NSObject<RtcEnginePlugin>*) plugin {
    [[self plugins] removeObjectForKey:(id)[plugin class]];
}

// MARK: - protocol from RtcEnginePlugin
- (void)onRtcEngineCreated:(AgoraRtcEngineKit * _Nullable)rtcEngine {
    for (id key in self.plugins) {
        NSObject<RtcEnginePlugin>* plugin = [self.plugins objectForKey:key];
        [plugin onRtcEngineCreated:rtcEngine];
    }
}

// MARK: - protocol from RtcEnginePlugin
- (void)onRtcEngineDestroyed {
    for (id key in self.plugins) {
        NSObject<RtcEnginePlugin>* plugin = [self.plugins objectForKey:key];
        [plugin onRtcEngineDestroyed];
    }
}

@end

