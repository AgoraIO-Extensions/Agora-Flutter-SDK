#import "AgoraRtcEnginePlugin.h"
#if __has_include(<agora_rtc_engine/agora_rtc_engine-Swift.h>)
#import <agora_rtc_engine/agora_rtc_engine-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "agora_rtc_engine-Swift.h"
#endif

@implementation AgoraRtcEnginePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  [SwiftAgoraRtcEnginePlugin registerWithRegistrar:registrar];
}
@end
