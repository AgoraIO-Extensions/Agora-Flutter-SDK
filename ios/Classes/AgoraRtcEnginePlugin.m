#import "AgoraRtcEnginePlugin.h"
#import <AgoraRtcEngineKit/AgoraRtcEngineKit.h>

@interface AgoraRendererView()
@property (nonatomic, strong) UIView *renderView;
@property (nonatomic, assign) int64_t viewId;
@end

@implementation AgoraRendererView
- (instancetype)initWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId {
  if (self = [super init]) {
    self.renderView = [[UIView alloc] initWithFrame:frame];
    self.renderView.backgroundColor = [UIColor blackColor];
    self.viewId = viewId;
  }
  return self;
}

- (nonnull UIView *)view {
  return self.renderView;
}
@end

@interface AgoraRenderViewFactory : NSObject<FlutterPlatformViewFactory>
@end

@interface AgoraRtcEnginePlugin()<FlutterStreamHandler, AgoraRtcEngineDelegate>
@property (strong, nonatomic) AgoraRtcEngineKit *agoraRtcEngine;
@property (strong, nonatomic) FlutterMethodChannel *methodChannel;
@property (strong, nonatomic) FlutterEventChannel *eventChannel;
@property (strong, nonatomic) FlutterEventSink eventSink;
@property (strong, nonatomic) NSMutableDictionary *rendererViews;
@end

@implementation AgoraRtcEnginePlugin
#pragma mark - renderer views
+ (instancetype)sharedPlugin {
  static AgoraRtcEnginePlugin* plugin = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    plugin = [[AgoraRtcEnginePlugin alloc] init];
  });
  return plugin;
}

- (NSMutableDictionary *)rendererViews {
  if (!_rendererViews) {
    _rendererViews = [[NSMutableDictionary alloc] init];
  }
  return _rendererViews;
}

+ (void)addView:(UIView *)view id:(NSNumber *)viewId {
  if (!viewId) {
    return;
  }
  if (view) {
    [[[AgoraRtcEnginePlugin sharedPlugin] rendererViews] setObject:view forKey:viewId];
  } else {
    [self removeViewForId:viewId];
  }
}

+ (void)removeViewForId:(NSNumber *)viewId {
  if (!viewId) {
    return;
  }
  [[[AgoraRtcEnginePlugin sharedPlugin] rendererViews] removeObjectForKey:viewId];
}

+ (UIView *)viewForId:(NSNumber *)viewId {
  if (!viewId) {
    return nil;
  }
  return [[[AgoraRtcEnginePlugin sharedPlugin] rendererViews] objectForKey:viewId];
}

#pragma mark - Flutter
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
                                   methodChannelWithName:@"agora_rtc_engine"
                                   binaryMessenger:[registrar messenger]];
  FlutterEventChannel* eventChannel = [FlutterEventChannel
                                       eventChannelWithName:@"agora_rtc_engine_event_channel"
                                       binaryMessenger:registrar.messenger];
  AgoraRtcEnginePlugin* instance = [[AgoraRtcEnginePlugin alloc] init];
  instance.methodChannel = channel;
  instance.eventChannel = eventChannel;
  [registrar addMethodCallDelegate:instance channel:channel];
  
  AgoraRenderViewFactory *fac = [[AgoraRenderViewFactory alloc] init];
  [registrar registerViewFactory:fac withId:@"AgoraRendererView"];
}

- (UIColor *) UIColorFromRGB:(NSUInteger)rgbValue {
  return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];
}

- (AgoraImage *) makeAgoraImage:(NSDictionary *)options {
  AgoraImage *img = [AgoraImage new];
  img.url = [NSURL URLWithString:options[@"url"]];
  
  img.rect = CGRectMake((CGFloat)[options[@"x"] floatValue],
                        (CGFloat)[options[@"y"] floatValue],
                        (CGFloat)[options[@"width"] floatValue],
                        (CGFloat)[options[@"height"] floatValue]);
  return img;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  NSString *method = call.method;
  NSDictionary *params = call.arguments;
  NSLog(@"plugin handleMethodCall: %@, argus: %@", method, params);
  
  // Core Methods
  if ([@"create" isEqualToString:method]) {
    NSString *appId = [self stringFromArguments:params key:@"appId"];
    self.agoraRtcEngine = [AgoraRtcEngineKit sharedEngineWithAppId:appId delegate:self];
    [_eventChannel setStreamHandler:self];
    result(nil);
  } else if ([@"destroy" isEqualToString:method]) {
    self.agoraRtcEngine = nil;
    [AgoraRtcEngineKit destroy];
    result(nil);
  } else if ([@"setChannelProfile" isEqualToString:method]) {
    NSInteger profile = [self intFromArguments:params key:@"profile"];
    [self.agoraRtcEngine setChannelProfile:profile];
    result(nil);
  } else if ([@"setClientRole" isEqualToString:method]) {
    NSInteger role = [self intFromArguments:params key:@"role"];
    [self.agoraRtcEngine setClientRole:role];
    result(nil);
  } else if([@"switchChannel" isEqualToString:method]) {
    NSString *token = [self stringFromArguments:params key:@"token"];
    NSString *channel = [self stringFromArguments:params key:@"channelId"];
    NSInteger res = [self.agoraRtcEngine switchChannelByToken:token channelId:channel joinSuccess:nil];
    if (res == 0) {
      result(@{@"result": @(YES)});
    } else {
      result(@{@"result": @(NO), @"errorCode": @(res)});
    }
  } else if ([@"joinChannel" isEqualToString:method]) {
    NSString *token = [self stringFromArguments:params key:@"token"];
    NSString *channel = [self stringFromArguments:params key:@"channelId"];
    NSString *info = [self stringFromArguments:params key:@"info"];
    NSInteger uid = [self intFromArguments:params key:@"uid"];
    
    [self.agoraRtcEngine joinChannelByToken:token channelId:channel info:info uid:uid joinSuccess:nil];
    result([NSNumber numberWithBool:YES]);
  } else if ([@"leaveChannel" isEqualToString:method]) {
    BOOL success = (0 == [self.agoraRtcEngine leaveChannel:nil]);
    result([NSNumber numberWithBool:success]);
  } else if ([@"renewToken" isEqualToString:method]) {
    NSString *token = [self stringFromArguments:params key:@"token"];
    [self.agoraRtcEngine renewToken:token];
    result(nil);
  } else if ([@"enableWebSdkInteroperability" isEqualToString:method]) {
    BOOL enabled = [self boolFromArguments:params key:@"enabled"];
    [self.agoraRtcEngine enableWebSdkInteroperability:enabled];
    result(nil);
  } else if ([@"getConnectionState" isEqualToString:method]) {
    AgoraConnectionStateType state = [self.agoraRtcEngine getConnectionState];
    result([NSNumber numberWithInteger:state]);
  }
  // stringUid
  else if ([@"registerLocalUserAccount" isEqualToString:method]) {
    NSString *appId = [self stringFromArguments:params key:@"appId"];
    NSString *userAccount = [self stringFromArguments:params key:@"userAccount"];
    int res = [self.agoraRtcEngine registerLocalUserAccount:userAccount appId:appId];
    bool value = res == 0 ? YES : NO;
    result(@(value));
  }
  else if ([@"joinChannelByUserAccount" isEqualToString:method]) {
    NSString *token = [self stringFromArguments:params key:@"token"];
    NSString *userAccount = [self stringFromArguments:params key:@"userAccount"];
    NSString *channelId = [self stringFromArguments:params key:@"channelId"];
    int res = [self.agoraRtcEngine joinChannelByUserAccount:userAccount token:token channelId:channelId joinSuccess:nil];
    bool value = res == 0 ? YES : NO;
    result(@(value));
  }
  else if ([@"getUserInfoByUserAccount" isEqualToString:method]) {
    NSString *userAccount = [self stringFromArguments:params key:@"userAccount"];
    AgoraErrorCode errorCode = 0;
    AgoraUserInfo *res = [self.agoraRtcEngine getUserInfoByUserAccount:userAccount withError:&errorCode];
    if (errorCode == 0) {
      result(@{@"uid": @(res.uid), @"userAccount": res.userAccount});
    } else {
      result([FlutterError errorWithCode:@"UgetUserInfoByUserAccountError"
      message:@"get user info failed"
      details:@(errorCode)]);
    }
  }
  else if ([@"getUserInfoByUid" isEqualToString:method]) {
    NSInteger uid = [self intFromArguments:params key:@"uid"];
    AgoraErrorCode errorCode = 0;
    AgoraUserInfo *res = [self.agoraRtcEngine getUserInfoByUid:uid withError:&errorCode];
    if (errorCode == 0) {
      result(@{@"uid": @(res.uid), @"userAccount": res.userAccount});
    } else {
      result([FlutterError errorWithCode:@"UgetUserInfoByUserAccountError"
      message:@"get user info failed"
      details:@(errorCode)]);
    }
  }
  // Core Audio
  else if ([@"enableAudio" isEqualToString:method]) {
    [self.agoraRtcEngine enableAudio];
    result(nil);
  } else if ([@"disableAudio" isEqualToString:method]) {
    [self.agoraRtcEngine disableAudio];
    result(nil);
  } else if ([@"setAudioProfile" isEqualToString:method]) {
    NSInteger profile = [self intFromArguments:params key:@"profile"];
    NSInteger scenario = [self intFromArguments:params key:@"scenario"];
    [self.agoraRtcEngine setAudioProfile:profile scenario:scenario];
    result(nil);
  } else if ([@"setAudioProfile" isEqualToString:method]) {
    NSInteger profile = [self intFromArguments:params key:@"profile"];
    NSInteger scenario = [self intFromArguments:params key:@"scenario"];
    [self.agoraRtcEngine setAudioProfile:profile scenario:scenario];
    result(nil);
  } else if ([@"adjustRecordingSignalVolume" isEqualToString:method]) {
    NSInteger volume = [self intFromArguments:params key:@"volume"];
    [self.agoraRtcEngine adjustRecordingSignalVolume:volume];
    result(nil);
  } else if ([@"adjustPlaybackSignalVolume" isEqualToString:method]) {
    NSInteger volume = [self intFromArguments:params key:@"volume"];
    [self.agoraRtcEngine adjustPlaybackSignalVolume:volume];
    result(nil);
  } else if ([@"enableAudioVolumeIndication" isEqualToString:method]) {
    NSInteger interval = [self intFromArguments:params key:@"interval"];
    NSInteger smooth = [self intFromArguments:params key:@"smooth"];
    Boolean vad = [self boolFromArguments:params key:@"vad"];
    [self.agoraRtcEngine enableAudioVolumeIndication:interval smooth:smooth report_vad:vad];
    result(nil);
  } else if ([@"enableLocalAudio" isEqualToString:method]) {
    BOOL enabled = [self boolFromArguments:params key:@"enabled"];
    [self.agoraRtcEngine enableLocalAudio:enabled];
    result(nil);
  } else if ([@"muteLocalAudioStream" isEqualToString:method]) {
    BOOL muted = [self boolFromArguments:params key:@"muted"];
    [self.agoraRtcEngine muteLocalAudioStream:muted];
    result(nil);
  } else if ([@"muteRemoteAudioStream" isEqualToString:method]) {
    NSInteger uid = [self intFromArguments:params key:@"uid"];
    BOOL muted = [self boolFromArguments:params key:@"muted"];
    [self.agoraRtcEngine muteRemoteAudioStream:uid mute:muted];
    result(nil);
  } else if ([@"muteAllRemoteAudioStreams" isEqualToString:method]) {
    BOOL muted = [self boolFromArguments:params key:@"muted"];
    [self.agoraRtcEngine muteAllRemoteAudioStreams:muted];
    result(nil);
  } else if ([@"setDefaultMuteAllRemoteAudioStreams" isEqualToString:method]) {
    BOOL muted = [self boolFromArguments:params key:@"muted"];
    [self.agoraRtcEngine setDefaultMuteAllRemoteAudioStreams:muted];
    result(nil);
  }
  // Core Video
  else if ([@"enableVideo" isEqualToString:method]) {
    [self.agoraRtcEngine enableVideo];
    result(nil);
  } else if ([@"disableVideo" isEqualToString:method]) {
    [self.agoraRtcEngine disableVideo];
    result(nil);
  } else if ([@"setVideoEncoderConfiguration" isEqualToString:method]) {
    NSDictionary *configDic = [self dictionaryFromArguments:params key:@"config"];
    AgoraVideoEncoderConfiguration *config = [self videoEncoderConfigurationFromDic:configDic];
    [self.agoraRtcEngine setVideoEncoderConfiguration:config];
    result(nil);
  } else if ([@"removeNativeView" isEqualToString:method]) {
    NSString *viewId = [self stringFromArguments:params key:@"viewId"];
    if (viewId.length) {
      [self.rendererViews removeObjectForKey:viewId];
    }
    result(nil);
  } else if ([@"setupLocalVideo" isEqualToString:method]) {
    NSInteger viewId = [self intFromArguments:params key:@"viewId"];
    UIView *view = [AgoraRtcEnginePlugin viewForId:@(viewId)];
    NSInteger renderType = [self intFromArguments:params key:@"renderMode"];
    
    AgoraRtcVideoCanvas *canvas = [[AgoraRtcVideoCanvas alloc] init];
    canvas.view = view;
    canvas.renderMode = renderType;
    [self.agoraRtcEngine setupLocalVideo:canvas];
    result(nil);
  } else if ([@"setupRemoteVideo" isEqualToString:method]) {
    NSInteger viewId = [self intFromArguments:params key:@"viewId"];
    UIView *view = [AgoraRtcEnginePlugin viewForId:@(viewId)];
    NSInteger renderType = [self intFromArguments:params key:@"renderMode"];
    NSInteger uid = [self intFromArguments:params key:@"uid"];
    
    AgoraRtcVideoCanvas *canvas = [[AgoraRtcVideoCanvas alloc] init];
    canvas.view = view;
    canvas.renderMode = renderType;
    canvas.uid = uid;
    [self.agoraRtcEngine setupRemoteVideo:canvas];
    result(nil);
  } else if ([@"setLocalRenderMode" isEqualToString:method]) {
    NSInteger mode = [self intFromArguments:params key:@"mode"];
    [self.agoraRtcEngine setLocalRenderMode:mode];
    result(nil);
  } else if ([@"setLocalVoiceChanger" isEqualToString:method]) {
    NSInteger changer = [self intFromArguments:params key:@"changer"];
    [self.agoraRtcEngine setLocalVoiceChanger:changer];
    result(nil);
  } else if ([@"setRemoteRenderMode" isEqualToString:method]) {
    NSInteger uid = [self intFromArguments:params key:@"uid"];
    NSInteger mode = [self intFromArguments:params key:@"mode"];
    [self.agoraRtcEngine setRemoteRenderMode:uid mode:mode];
    result(nil);
  } else if ([@"startPreview" isEqualToString:method]) {
    [self.agoraRtcEngine startPreview];
    result(nil);
  } else if ([@"stopPreview" isEqualToString:method]) {
    [self.agoraRtcEngine stopPreview];
    result(nil);
  } else if ([@"enableLocalVideo" isEqualToString:method]) {
    BOOL enabled = [self boolFromArguments:params key:@"enabled"];
    [self.agoraRtcEngine enableLocalVideo:enabled];
    result(nil);
  } else if ([@"muteLocalVideoStream" isEqualToString:method]) {
    BOOL muted = [self boolFromArguments:params key:@"muted"];
    [self.agoraRtcEngine muteLocalVideoStream:muted];
    result(nil);
  } else if ([@"muteRemoteVideoStream" isEqualToString:method]) {
    NSInteger uid = [self intFromArguments:params key:@"uid"];
    BOOL muted = [self boolFromArguments:params key:@"muted"];
    [self.agoraRtcEngine muteRemoteVideoStream:uid mute:muted];
    result(nil);
  } else if ([@"muteAllRemoteVideoStreams" isEqualToString:method]) {
    BOOL muted = [self boolFromArguments:params key:@"muted"];
    [self.agoraRtcEngine muteAllRemoteVideoStreams:muted];
    result(nil);
  } else if ([@"setDefaultMuteAllRemoteVideoStreams" isEqualToString:method]) {
    BOOL muted = [self boolFromArguments:params key:@"muted"];
    [self.agoraRtcEngine setDefaultMuteAllRemoteVideoStreams:muted];
    result(nil);
  }
  
  // Voice
  else if ([@"setLocalVoicePitch" isEqualToString:method]) {
    
  }
  else if ([@"setLocalVoiceEqualizationOfBandFrequency" isEqualToString:method]) {
    
  }
  else if ([@"setLocalVoiceReverbOfType" isEqualToString:method]) {
    
  }
  else if ([@"setLocalVoiceReverbPreset" isEqualToString:method]) {
    
  }
  else if ([@"enableSoundPositionIndication" isEqualToString:method]) {
    
  }
  else if ([@"setRemoteVoicePosition" isEqualToString:method]) {
    
  }
  
  else if ([@"startEchoTestWithInterval" isEqualToString:method]) {
    
  }
  else if ([@"stopEchoTest" isEqualToString:method]) {
    
  }
  else if ([@"enableLastmileTest" isEqualToString:method]) {
    
  }
  else if ([@"disableLastmileTest" isEqualToString:method]) {
    
  }
  else if ([@"startLastmileProbeTest" isEqualToString:method]) {
    
  }
  else if ([@"stopLastmileProbeTest" isEqualToString:method]) {
    
  }
  
  else if ([@"addVideoWatermark" isEqualToString:method]) {
    
  }
  
  else if ([@"clearVideoWatermarks" isEqualToString:method]) {
    
  }
  
  
  // Video Pre-process and Post-process
  else if ([@"setBeautyEffectOptions" isEqualToString:method]) {
    BOOL enabled = [self boolFromArguments:params key:@"enabled"];
    NSDictionary *optionsDic = [self dictionaryFromArguments:params key:@"options"];
    AgoraBeautyOptions *options = [self beautyOptionsFromDic:optionsDic];
    [self.agoraRtcEngine setBeautyEffectOptions:enabled options:options];
    result(nil);
  }

  // Audio Routing Controller
  else if ([@"setDefaultAudioRouteToSpeaker" isEqualToString:method]) {
    BOOL defaultToSpeaker = [self boolFromArguments:params key:@"defaultToSpeaker"];
    [self.agoraRtcEngine setDefaultAudioRouteToSpeakerphone:defaultToSpeaker];
    result(nil);
  } else if ([@"setEnableSpeakerphone" isEqualToString:method]) {
    BOOL enabled = [self boolFromArguments:params key:@"enabled"];
    [self.agoraRtcEngine setEnableSpeakerphone:enabled];
    result(nil);
  } else if ([@"isSpeakerphoneEnabled" isEqualToString:method]) {
    BOOL enable = [self.agoraRtcEngine isSpeakerphoneEnabled];
    result([NSNumber numberWithBool:enable]);
  }
  // Stream Fallback
  else if ([@"setRemoteUserPriority" isEqualToString:method]) {
    NSInteger uid = [self intFromArguments:params key:@"uid"];
    AgoraUserPriority priority = [self intFromArguments:params key:@"userPriority"];
    [self.agoraRtcEngine setRemoteUserPriority:uid type:priority];
    result(nil);
  } else if ([@"setLocalPublishFallbackOption" isEqualToString:method]) {
    NSInteger option = [self intFromArguments:params key:@"option"];
    [self.agoraRtcEngine setLocalPublishFallbackOption:option];
    result(nil);
  } else if ([@"setRemoteSubscribeFallbackOption" isEqualToString:method]) {
    NSInteger option = [self intFromArguments:params key:@"option"];
    [self.agoraRtcEngine setRemoteSubscribeFallbackOption:option];
    result(nil);
  }
  // Dual-stream Mode
  else if ([@"enableDualStreamMode" isEqualToString:method]) {
    BOOL enabled = [self boolFromArguments:params key:@"enabled"];
    [self.agoraRtcEngine enableDualStreamMode:enabled];
    result(nil);
  } else if ([@"setRemoteVideoStreamType" isEqualToString:method]) {
    NSInteger uid = [self intFromArguments:params key:@"uid"];
    NSInteger streamType = [self intFromArguments:params key:@"streamType"];
    [self.agoraRtcEngine setRemoteVideoStream:uid type:streamType];
    result(nil);
  } else if ([@"setRemoteDefaultVideoStreamType" isEqualToString:method]) {
    NSInteger streamType = [self intFromArguments:params key:@"streamType"];
    [self.agoraRtcEngine setRemoteDefaultVideoStreamType:streamType];
    result(nil);
  }
  // CDN push & pull
  else if ([@"setLiveTranscoding" isEqualToString:method]) {
    NSDictionary *options = [self dictionaryFromArguments:params key:@"transcoding"];
    AgoraLiveTranscoding *transcoding = [AgoraLiveTranscoding defaultTranscoding];
    if (options[@"width"] != [NSNull null] && options[@"height"] != [NSNull null]) {
      transcoding.size = CGSizeMake([options[@"width"] doubleValue], [options[@"height"] doubleValue]);
    }
    if (options[@"videoBitrate"] != [NSNull null]) {
      transcoding.videoBitrate = [options[@"videoBitrate"] integerValue];
    }
    if (options[@"videoFramerate"] != [NSNull null]) {
      transcoding.videoFramerate = [options[@"videoFramerate"] integerValue];
    }
    if (options[@"videoGop"] != [NSNull null]) {
      transcoding.videoGop = [options[@"videoGop"] integerValue];
    }
    if (options[@"videoCodecProfile"] != [NSNull null]) {
      transcoding.videoCodecProfile = (AgoraVideoCodecProfileType)[options[@"videoCodecProfile"] integerValue];
    }
    if (options[@"audioCodecProfile"] != [NSNull null]) {
      transcoding.audioCodecProfile = (AgoraAudioCodecProfileType)[options[@"audioCodecProfile"] integerValue];
    }
    if (options[@"audioSampleRate"] != [NSNull null]) {
      transcoding.audioSampleRate = (AgoraAudioSampleRateType)[options[@"audioSampleRate"] integerValue];
    }
    if (options[@"watermark"] != [NSNull null]) {
      transcoding.watermark = [self makeAgoraImage:@{
                                                     @"url": options[@"watermark"][@"url"],
                                                     @"x": options[@"watermark"][@"x"],
                                                     @"y": options[@"watermark"][@"y"],
                                                     @"width": options[@"watermark"][@"width"],
                                                     @"height": options[@"watermark"][@"height"]
                                                     }];
    }
    if (options[@"backgroundImage"] != [NSNull null]) {
      transcoding.backgroundImage = [self makeAgoraImage:@{
                                                           @"url": options[@"backgroundImage"][@"url"],
                                                           @"x": options[@"backgroundImage"][@"x"],
                                                           @"y": options[@"backgroundImage"][@"y"],
                                                           @"width": options[@"backgroundImage"][@"width"],
                                                           @"height": options[@"backgroundImage"][@"height"]
                                                           }];
    }
    
    if (options[@"backgroundColor"] != [NSNull null]) {
      transcoding.backgroundColor = [self UIColorFromRGB:(NSUInteger)[options[@"backgroundColor"] integerValue]];
    }
    
    if (options[@"audioBitrate"] != [NSNull null]) {
      transcoding.audioBitrate = [options[@"audioBitrate"] integerValue];
    }
    
    if (options[@"audioChannels"] != [NSNull null]) {
      transcoding.audioChannels = [options[@"audioChannels"] integerValue];
    }
    
    if (options[@"transcodingUsers"] != [NSNull null]) {
      NSMutableArray<AgoraLiveTranscodingUser*> *transcodingUsers = [NSMutableArray new];
      for (NSDictionary *optionUser in options[@"transcodingUsers"]) {
        AgoraLiveTranscodingUser *liveUser = [AgoraLiveTranscodingUser new];
        liveUser.uid = (NSUInteger)[optionUser[@"uid"] integerValue];
        liveUser.rect = CGRectMake((CGFloat)[optionUser[@"x"] floatValue],
                                   (CGFloat)[optionUser[@"y"] floatValue],
                                   (CGFloat)[optionUser[@"width"] floatValue],
                                   (CGFloat)[optionUser[@"height"] floatValue]);
        liveUser.zOrder = [optionUser[@"zOrder"] integerValue];
        liveUser.alpha = [optionUser[@"alpha"] doubleValue];
        liveUser.audioChannel = [optionUser[@"audioChannel"] integerValue];
        [transcodingUsers addObject:liveUser];
      }
      transcoding.transcodingUsers = transcodingUsers;
    }
    if (options[@"transcodingExtraInfo"] != [NSNull null]) {
      transcoding.transcodingExtraInfo = [options[@"transcodingExtraInfo"] stringValue];
    }
    NSInteger res = [self.agoraRtcEngine setLiveTranscoding:transcoding];
    result(@(res));
  }
  else if ([@"addPublishStreamUrl" isEqualToString:method]) {
    NSString *url = [self stringFromArguments:params key:@"url"];
    Boolean enabled = [self boolFromArguments:params key:@"enable"];
    NSInteger res = [self.agoraRtcEngine addPublishStreamUrl:url transcodingEnabled:enabled];
    result(@(res));
  }
  else if ([@"removePublishStreamUrl" isEqualToString:method]) {
    NSString *url = [self stringFromArguments:params key:@"url"];
    NSInteger res = [self.agoraRtcEngine removePublishStreamUrl:url];
    result(@(res));
  }
  else if ([@"addInjectStreamUrl" isEqualToString:method]) {
    NSString *url = [self stringFromArguments:params key:@"url"];
    NSDictionary *config = [self dictionaryFromArguments:params key:@"config"];
    AgoraLiveInjectStreamConfig *streamConfig = [AgoraLiveInjectStreamConfig defaultConfig];
    
    if (config[@"width"] != [NSNull null] && config[@"height"] != [NSNull null]) {
      streamConfig.size = CGSizeMake([config[@"width"] doubleValue], [config[@"height"] doubleValue]);
    }
    
    if (config[@"videoGop"] != [NSNull null]) {
      streamConfig.videoGop = [config[@"videoGop"] integerValue];
    }
    
    if (config[@"videoFramerate"] != [NSNull null]) {
      streamConfig.videoFramerate = [config[@"videoFramerate"] integerValue];
    }
    
    if (config[@"videoBitrate"] != [NSNull null]) {
      streamConfig.videoBitrate = [config[@"videoBitrate"] integerValue];
    }
    
    if (config[@"audioBitrate"] != [NSNull null]) {
      streamConfig.audioBitrate = [config[@"audioBitrate"] integerValue];
    }
    
    if (config[@"audioChannels"] != [NSNull null]) {
      streamConfig.audioChannels = [config[@"audioChannels"] integerValue];
    }
    
    if (config[@"audioSampleRate"] != [NSNull null]) {
      streamConfig.audioSampleRate = (AgoraAudioSampleRateType)[config[@"audioSampleRate"] integerValue];
    }
    
    NSInteger res = [self.agoraRtcEngine addInjectStreamUrl:url config:streamConfig];
    result(@(res));
  }
  else if ([@"removeInjectStreamUrl" isEqualToString:method]) {
    NSString *url = [self stringFromArguments:params key:@"url"];
    NSInteger res = [self.agoraRtcEngine removeInjectStreamUrl:url];
    result(@(res));
  }
  // Encryption
  else if ([@"setEncryptionSecret" isEqualToString:method]) {
    NSString *secret = [self stringFromArguments:params key:@"secret"];
    [self.agoraRtcEngine setEncryptionSecret:secret];
    result(nil);
  } else if ([@"setEncryptionMode" isEqualToString:method]) {
    NSString *encryptionMode = [self stringFromArguments:params key:@"encryptionMode"];
    [self.agoraRtcEngine setEncryptionMode:encryptionMode];
    result(nil);
  }
  // Audio Mixing
  else if ([@"startAudioMixing" isEqualToString:method]) {
    
  }
  else if ([@"stopAudioMixing" isEqualToString:method]) {
    
  }
  else if ([@"pauseAudioMixing" isEqualToString:method]) {
    
  }
  else if ([@"resumeAudioMixing" isEqualToString:method]) {
    
  }
  else if ([@"adjustAudioMixingVolume" isEqualToString:method]) {
    
  }
  else if ([@"adjustAudioMixingPlayoutVolume" isEqualToString:method]) {
    
  }
  else if ([@"adjustAudioMixingPublishVolume" isEqualToString:method]) {
    
  }
  else if ([@"getAudioMixingPlayoutVolume" isEqualToString:method]) {
    
  }
  else if ([@"getAudioMixingPublishVolume" isEqualToString:method]) {
    
  }
  else if ([@"getAudioMixingDuration" isEqualToString:method]) {
    
  }
  else if ([@"getAudioMixingCurrentPosition" isEqualToString:method]) {
    
  }
  else if ([@"setAudioMixingPosition" isEqualToString:method]) {
    
  }
  // AudioEffect
  else if ([@"getEffectsVolume" isEqualToString:method]) {
    
  }
  else if ([@"setEffectsVolume" isEqualToString:method]) {
    
  }
  else if ([@"setVolumeOfEffect" isEqualToString:method]) {
    
  }
  else if ([@"playEffect" isEqualToString:method]) {
    
  }
  else if ([@"stopEffect" isEqualToString:method]) {
    
  }
  else if ([@"stopAllEffects" isEqualToString:method]) {
    
  }
  else if ([@"preloadEffect" isEqualToString:method]) {
    
  }
  else if ([@"unloadEffect" isEqualToString:method]) {
    
  }
  else if ([@"pauseEffect" isEqualToString:method]) {
    
  }
  else if ([@"pauseAllEffects" isEqualToString:method]) {
    
  }
  else if ([@"resumeEffect" isEqualToString:method]) {
    
  }
  else if ([@"resumeAllEffects" isEqualToString:method]) {
    
  }
  
  // Channel Media Relay
  else if ([@"startChannelMediaRelay" isEqualToString:method]) {
    
  }
  else if ([@"updateChannelMediaRelay" isEqualToString:method]) {
    
  }
  else if ([@"stopChannelMediaRelay" isEqualToString:method]) {
    
  }
  
  else if ([@"enableInEarMonitoring" isEqualToString:method]) {
    
  }
  
  else if ([@"setInEarMonitoringVolume" isEqualToString:method]) {
    
  }
  
  // Camera Control
  else if ([@"switchCamera" isEqualToString:method]) {
    [self.agoraRtcEngine switchCamera];
    result(nil);
  }
  // Miscellaneous Methods
  else if ([@"getSdkVersion" isEqualToString:method]) {
    NSString *version = [AgoraRtcEngineKit getSdkVersion];
    result(version);
  }
  
  else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)dealloc {
  [self.methodChannel setMethodCallHandler:nil];
  [self.eventChannel setStreamHandler:nil];
}


#pragma mark - FlutterStreamHandler
- (FlutterError * _Nullable)onCancelWithArguments:(id _Nullable)params {
  _eventSink = nil;
  return nil;
}

- (FlutterError * _Nullable)onListenWithArguments:(id _Nullable)params eventSink:(nonnull FlutterEventSink)events {
  _eventSink = events;
  return nil;
}

- (void) sendEvent:(NSString *)name params:(NSDictionary*)params {
  if (_eventSink) {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:params];
    dict[@"event"] = name;
    _eventSink([dict copy]);
  }
}

#pragma mark - delegate
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didOccurWarning:(AgoraWarningCode)warningCode {
  [self sendEvent:@"onWarning" params:@{@"errorCode": @(warningCode)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didOccurError:(AgoraErrorCode)errorCode {
  [self sendEvent:@"onError" params:@{@"errorCode": @(errorCode)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didJoinChannel:(NSString * _Nonnull)channel withUid:(NSUInteger)uid elapsed:(NSInteger) elapsed {
  [self sendEvent:@"onJoinChannelSuccess" params:@{@"channel": channel, @"uid": @(uid), @"elapsed": @(elapsed)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didRejoinChannel:(NSString * _Nonnull)channel withUid:(NSUInteger)uid elapsed:(NSInteger) elapsed {
  [self sendEvent:@"onRejoinChannelSuccess" params:@{@"channel": channel, @"uid": @(uid), @"elapsed": @(elapsed)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didLeaveChannelWithStats:(AgoraChannelStats * _Nonnull)stats {
  [self sendEvent:@"onLeaveChannel" params:@{@"stats": [self dicFromChannelStats:stats]}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didClientRoleChanged:(AgoraClientRole)oldRole newRole:(AgoraClientRole)newRole {
  [self sendEvent:@"onClientRoleChanged" params:@{@"oldRole": @(oldRole), @"newRole": @(newRole)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didJoinedOfUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
  [self sendEvent:@"onUserJoined" params:@{@"uid": @(uid), @"elapsed": @(elapsed)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didOfflineOfUid:(NSUInteger)uid reason:(AgoraUserOfflineReason)reason {
  [self sendEvent:@"onUserOffline" params:@{@"uid": @(uid), @"reason": @(reason)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine didRegisteredLocalUser:(NSString *_Nonnull)userAccount withUid:(NSUInteger)uid {
  [self sendEvent:@"onRegisteredLocalUser" params:@{@"uid": @(uid), @"userAccount": userAccount}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine didUpdatedUserInfo:(AgoraUserInfo *_Nonnull)userInfo withUid:(NSUInteger)uid {
  [self sendEvent:@"onUpdatedUserInfo" params:@{
    @"uid": @(uid),
    @"userInfo": @{
        @"uid": @(userInfo.uid),
        @"userAccount": userInfo.userAccount
    }
  }];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine connectionChangedToState:(AgoraConnectionStateType)state reason:(AgoraConnectionChangedReason)reason {
  [self sendEvent:@"onConnectionStateChanged" params:@{@"state": @(state), @"reason": @(reason)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine networkTypeChangedToType:(AgoraNetworkType)type {
  [self sendEvent:@"onNetworkTypeChanged" params:@{@"type": @(type)}];
}

- (void)rtcEngineConnectionDidLost:(AgoraRtcEngineKit * _Nonnull)engine {
  [self sendEvent:@"onConnectionLost" params:nil];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didApiCallExecute:(NSInteger)error api:(NSString * _Nonnull)api result:(NSString * _Nonnull)result {
  [self sendEvent:@"onApiCallExecuted" params:@{@"errorCode": @(error), @"api": api, @"result": result}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine tokenPrivilegeWillExpire:(NSString * _Nonnull)token {
  [self sendEvent:@"onTokenPrivilegeWillExpire" params:@{@"token": token}];
}

- (void)rtcEngineRequestToken:(AgoraRtcEngineKit * _Nonnull)engine {
  [self sendEvent:@"onRequestToken" params:nil];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine reportAudioVolumeIndicationOfSpeakers:(NSArray<AgoraRtcAudioVolumeInfo *> * _Nonnull)speakers totalVolume:(NSInteger)totalVolume {
  [self sendEvent:@"onAudioVolumeIndication" params:@{@"speakers": [self arrayFromSpeakers:speakers], @"totalVolume": @(totalVolume)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine activeSpeaker:(NSUInteger)speakerUid {
  [self sendEvent:@"onActiveSpeaker" params:@{@"uid": @(speakerUid)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine firstLocalAudioFrame:(NSInteger)elapsed {
  [self sendEvent:@"onFirstLocalAudioFrame" params:@{@"elapsed": @(elapsed)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine firstRemoteAudioFrameOfUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
  [self sendEvent:@"onFirstRemoteAudioFrame" params:@{@"uid": @(uid), @"elapsed": @(elapsed)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine firstRemoteAudioFrameDecodedOfUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
  [self sendEvent:@"onFirstRemoteAudioDecoded" params:@{@"uid": @(uid), @"elapsed": @(elapsed)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine firstLocalVideoFrameWithSize:(CGSize)size elapsed:(NSInteger)elapsed {
  [self sendEvent:@"onFirstLocalVideoFrame" params:@{@"width": @((int)size.width), @"height": @((int)size.height), @"elapsed": @(elapsed)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine firstRemoteVideoFrameOfUid:(NSUInteger)uid size:(CGSize)size elapsed:(NSInteger)elapsed {
  [self sendEvent:@"onFirstRemoteVideoFrame" params:@{@"uid": @(uid), @"width": @((int)size.width), @"height": @((int)size.height), @"elapsed": @(elapsed)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didAudioMuted:(BOOL)muted byUid:(NSUInteger)uid {
  [self sendEvent:@"onUserMuteAudio" params:@{@"muted": @(muted), @"uid": @(uid)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine didVideoMuted:(BOOL)muted byUid:(NSUInteger)uid {
  [self sendEvent:@"onUserMuteVideo" params:@{@"muted": @(muted), @"uid": @(uid)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine videoSizeChangedOfUid:(NSUInteger)uid size:(CGSize)size rotation:(NSInteger)rotation {
  [self sendEvent:@"onVideoSizeChanged" params:@{@"uid": @(uid), @"width": @((int)size.width), @"height": @((int)size.height), @"rotation": @(rotation)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine remoteVideoStateChangedOfUid:(NSUInteger)uid state:(AgoraVideoRemoteState)state reason:(AgoraVideoRemoteStateReason)reason elapsed:(NSInteger)elapsed {
  [self sendEvent:@"onRemoteVideoStateChanged" params:@{@"uid": @(uid), @"state": @(state), @"reason": @(reason), @"elapsed": @(elapsed)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine localVideoStateChange:(AgoraLocalVideoStreamState)state error:(AgoraLocalVideoStreamError)error {
  [self sendEvent:@"onLocalVideoStateChanged" params:@{@"errorCode": @(error), @"localVideoState": @(state)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine remoteAudioStateChangedOfUid:(NSUInteger)uid state:(AgoraAudioRemoteState)state reason:(AgoraAudioRemoteStateReason)reason elapsed:(NSInteger)elapsed {
  [self sendEvent:@"onRemoteAudioStateChanged" params:@{@"uid": @(uid), @"state": @(state), @"reason": @(reason), @"elapsed": @(elapsed)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine localAudioStateChange:(AgoraAudioLocalState)state error:(AgoraAudioLocalError)error {
  [self sendEvent:@"onLocalAudioStateChanged" params:@{@"errorCode": @(error), @"state": @(state)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didLocalPublishFallbackToAudioOnly:(BOOL)isFallbackOrRecover {
  [self sendEvent:@"onLocalPublishFallbackToAudioOnly" params:@{@"isFallbackOrRecover": @(isFallbackOrRecover)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didRemoteSubscribeFallbackToAudioOnly:(BOOL)isFallbackOrRecover byUid:(NSUInteger)uid {
  [self sendEvent:@"onRemoteSubscribeFallbackToAudioOnly" params:@{@"uid": @(uid), @"isFallbackOrRecover": @(isFallbackOrRecover)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didAudioRouteChanged:(AgoraAudioOutputRouting)routing {
  [self sendEvent:@"onAudioRouteChanged" params:@{@"routing": @(routing)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine cameraFocusDidChangedToRect:(CGRect)rect {
  [self sendEvent:@"onCameraFocusAreaChanged" params:@{@"rect": [self dicFromRect:rect]}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine cameraExposureDidChangedToRect:(CGRect)rect {
  [self sendEvent:@"onCameraExposureAreaChanged" params:@{@"rect": [self dicFromRect:rect]}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine reportRtcStats:(AgoraChannelStats * _Nonnull)stats {
  [self sendEvent:@"onRtcStats" params:@{@"stats": [self dicFromChannelStats:stats]}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine lastmileQuality:(AgoraNetworkQuality)quality {
  [self sendEvent:@"onLastmileQuality" params:@{@"quality": @(quality)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine networkQuality:(NSUInteger)uid txQuality:(AgoraNetworkQuality)txQuality rxQuality:(AgoraNetworkQuality)rxQuality {
  [self sendEvent:@"onNetworkQuality" params:@{@"uid": @(uid), @"txQuality": @(txQuality), @"rxQuality": @(rxQuality)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine lastmileProbeTestResult:(AgoraLastmileProbeResult *_Nonnull)result
{
  [self sendEvent:@"onLastmileProbeTestResult" params:@{
    @"state": @(result.state),
    @"rtt": @(result.rtt),
    @"uplinkReport": @{
        @"availableBandwidth": @(result.uplinkReport.availableBandwidth),
        @"jitter": @(result.uplinkReport.jitter),
        @"packetLossRate": @(result.uplinkReport.packetLossRate),
    },
    @"downlinkReport": @{
        @"availableBandwidth": @(result.downlinkReport.availableBandwidth),
        @"jitter": @(result.downlinkReport.jitter),
        @"packetLossRate": @(result.downlinkReport.packetLossRate),
    }
  }];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine localVideoStats:(AgoraRtcLocalVideoStats * _Nonnull)stats {
  [self sendEvent:@"onLocalVideoStats" params:@{@"stats": [self dicFromLocalVideoStats:stats]}];
}

- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine localAudioStats:(AgoraRtcLocalAudioStats *_Nonnull)stats {
  [self sendEvent:@"onLocalAudioStats" params:@{@"stats": [self dicFromLocalAudioStats:stats]}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine remoteVideoStats:(AgoraRtcRemoteVideoStats * _Nonnull)stats {
  [self sendEvent:@"onRemoteVideoStats" params:@{@"stats": [self dicFromRemoteVideoStats:stats]}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine remoteAudioStats:(AgoraRtcRemoteAudioStats * _Nonnull)stats {
  [self sendEvent:@"onRemoteAudioStats" params:@{@"stats": [self dicFromRemoteAudioStats:stats]}];
}

- (void)rtcEngineRemoteAudioMixingDidStart:(AgoraRtcEngineKit * _Nonnull)engine {
  [self sendEvent:@"onRemoteAudioMixingStarted" params:nil];
}

- (void)rtcEngineRemoteAudioMixingDidFinish:(AgoraRtcEngineKit * _Nonnull)engine {
  [self sendEvent:@"onRemoteAudioMixingFinished" params:nil];
}

- (void)rtcEngineDidAudioEffectFinish:(AgoraRtcEngineKit * _Nonnull)engine soundId:(NSInteger)soundId {
  [self sendEvent:@"onAudioEffectFinished" params:@{@"soundId": @(soundId)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine streamPublishedWithUrl:(NSString * _Nonnull)url errorCode:(AgoraErrorCode)errorCode {
  [self sendEvent:@"onStreamPublished" params:@{@"url": url, @"errorCode": @(errorCode)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine streamUnpublishedWithUrl:(NSString * _Nonnull)url {
  [self sendEvent:@"onStreamUnpublished" params:@{@"url": url}];
}

- (void)rtcEngineTranscodingUpdated:(AgoraRtcEngineKit * _Nonnull)engine {
  [self sendEvent:@"onTranscodingUpdated" params:nil];
}

- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine rtmpStreamingChangedToState:(NSString *_Nonnull)url state:(AgoraRtmpStreamingState)state errorCode:(AgoraRtmpStreamingErrorCode)errorCode {
  [self sendEvent:@"onRtmpStreamingStateChanged" params:@{@"url": url, @"errorCode": @(errorCode), @"state": @(state)}];
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine streamInjectedStatusOfUrl:(NSString * _Nonnull)url uid:(NSUInteger)uid status:(AgoraInjectStreamStatus)status {
  [self sendEvent:@"onStreamInjectedStatus" params:@{@"url": url, @"uid": @(uid), @"status": @(status)}];
}

- (void)rtcEngineMediaEngineDidLoaded:(AgoraRtcEngineKit * _Nonnull)engine {
  [self sendEvent:@"onMediaEngineLoadSuccess" params:nil];
}

- (void)rtcEngineMediaEngineDidStartCall:(AgoraRtcEngineKit * _Nonnull)engine {
  [self sendEvent:@"onMediaEngineStartCallSuccess" params:nil];
}

- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine channelMediaRelayStateDidChange:(AgoraChannelMediaRelayState)state error:(AgoraChannelMediaRelayError)error {
  [self sendEvent:@"onChannelMediaRelayChanged" params:@{
    @"state": @(state),
    @"errorCode": @(error)
  }];
}

- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine didReceiveChannelMediaRelayEvent:(AgoraChannelMediaRelayEvent)event {
  [self sendEvent:@"onReceivedChannelMediaRelayEvent" params:@{
    @"event": @(event)
  }];
}

- (void)rtcEngineLocalAudioMixingDidFinish:(AgoraRtcEngineKit *_Nonnull)engine {
  [self sendEvent:@"onLocalAudioMixingFinished" params:nil];
}

- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine localAudioMixingStateDidChanged:(AgoraAudioMixingStateCode)state errorCode:(AgoraAudioMixingErrorCode)errorCode {
  [self sendEvent:@"onLocalAudioMixingStateChanged" params:@{@"errorCode": @(errorCode)}];
}

#pragma mark - helper
- (NSString *)stringFromArguments:(NSDictionary *)params key:(NSString *)key {
  if (![params isKindOfClass:[NSDictionary class]]) {
    return nil;
  }
  
  NSString *value = [params valueForKey:key];
  if (![value isKindOfClass:[NSString class]]) {
    return nil;
  } else {
    return value;
  }
}

- (NSInteger)intFromArguments:(NSDictionary *)params key:(NSString *)key {
  if (![params isKindOfClass:[NSDictionary class]]) {
    return 0;
  }
  
  NSNumber *value = [params valueForKey:key];
  if (![value isKindOfClass:[NSNumber class]]) {
    return 0;
  } else {
    return [value integerValue];
  }
}

- (double)doubleFromArguments:(NSDictionary *)params key:(NSString *)key {
  if (![params isKindOfClass:[NSDictionary class]]) {
    return 0;
  }
  
  NSNumber *value = [params valueForKey:key];
  if (![value isKindOfClass:[NSNumber class]]) {
    return 0;
  } else {
    return [value doubleValue];
  }
}

- (BOOL)boolFromArguments:(NSDictionary *)params key:(NSString *)key {
  if (![params isKindOfClass:[NSDictionary class]]) {
    return NO;
  }
  
  NSNumber *value = [params valueForKey:key];
  if (![value isKindOfClass:[NSNumber class]]) {
    return NO;
  } else {
    return [value boolValue];
  }
}

- (NSDictionary *)dictionaryFromArguments:(NSDictionary *)params key:(NSString *)key {
  if (![params isKindOfClass:[NSDictionary class]]) {
    return nil;
  }
  
  NSDictionary *value = [params valueForKey:key];
  if (![value isKindOfClass:[NSDictionary class]]) {
    return nil;
  } else {
    return value;
  }
}

- (NSDictionary * _Nonnull)dicFromChannelStats:(AgoraChannelStats * _Nonnull)stats {
  return @{@"totalDuration": @(stats.duration),
           @"txBytes": @(stats.txBytes),
           @"rxBytes": @(stats.rxBytes),
           @"txAudioBytes": @(stats.txAudioBytes),
           @"txVideoBytes": @(stats.txVideoBytes),
           @"rxAudioBytes": @(stats.rxAudioBytes),
           @"rxVideoBytes": @(stats.rxVideoBytes),
           @"txKBitrate": @(stats.txKBitrate),
           @"rxKBitrate": @(stats.rxKBitrate),
           @"txAudioKBitrate": @(stats.txAudioKBitrate),
           @"rxAudioKBitrate": @(stats.rxAudioKBitrate),
           @"txVideoKBitrate": @(stats.txVideoKBitrate),
           @"rxVideoKBitrate": @(stats.rxVideoKBitrate),
           @"lastmileDelay": @(stats.lastmileDelay),
           @"txPacketLossRate": @(stats.txPacketLossRate),
           @"rxPacketLossRate": @(stats.rxPacketLossRate),
           @"users": @(stats.userCount),
           @"cpuAppUsage": @(stats.cpuAppUsage),
           @"cpuTotalUsage": @(stats.cpuTotalUsage)
           };
}

- (NSArray * _Nonnull)arrayFromSpeakers:(NSArray<AgoraRtcAudioVolumeInfo *> * _Nonnull)speakers {
  NSMutableArray *array = [[NSMutableArray alloc] init];
  for (AgoraRtcAudioVolumeInfo *speaker in speakers) {
    [array addObject:@{@"uid": @(speaker.uid),
                       @"volume": @(speaker.volume),
                       }];
  }
  
  return [array copy];
}

- (NSDictionary * _Nonnull)dicFromRect:(CGRect)rect {
  return @{@"x": @(rect.origin.x),
           @"y": @(rect.origin.y),
           @"width": @(rect.size.width),
           @"height": @(rect.size.height),
           };
}

- (NSDictionary * _Nonnull)dicFromLocalVideoStats:(AgoraRtcLocalVideoStats * _Nonnull)stats {
  return @{@"sentBitrate": @(stats.sentBitrate),
           @"sentFrameRate": @(stats.sentFrameRate),
           @"encoderOutputFrameRate": @(stats.encoderOutputFrameRate),
           @"rendererOutputFrameRate": @(stats.rendererOutputFrameRate),
           @"sentTargetBitrate": @(stats.sentTargetBitrate),
           @"sentTargetFrameRate": @(stats.sentTargetFrameRate),
           @"qualityAdaptIndication": @(stats.qualityAdaptIndication),
           @"encodedBitrate": @(stats.encodedBitrate),
           @"encodedFrameWidth": @(stats.encodedFrameWidth),
           @"encodedFrameHeight": @(stats.encodedFrameHeight),
           @"encodedFrameCount": @(stats.encodedFrameCount),
           @"codecType": @(stats.codecType)
           };
}

- (NSDictionary * _Nonnull)dicFromLocalAudioStats:(AgoraRtcLocalAudioStats * _Nonnull)stats {
  return @{@"numChannels": @(stats.numChannels),
           @"sentSampleRate": @(stats.sentSampleRate),
           @"sentBitrate": @(stats.sentBitrate),
           };
}

- (NSDictionary * _Nonnull)dicFromRemoteVideoStats:(AgoraRtcRemoteVideoStats * _Nonnull)stats {
  return @{@"uid": @(stats.uid),
           @"width": @(stats.width),
           @"height": @(stats.height),
           @"receivedBitrate": @(stats.receivedBitrate),
           @"decoderOutputFrameRate": @(stats.decoderOutputFrameRate),
           @"rendererOutputFrameRate": @(stats.rendererOutputFrameRate),
           @"packetLossRate": @(stats.packetLossRate),
           @"rxStreamType": @(stats.rxStreamType),
           @"totalFrozenTime": @(stats.totalFrozenTime),
           @"frozenRate": @(stats.frozenRate),
           };
}

- (NSDictionary * _Nonnull)dicFromRemoteAudioStats:(AgoraRtcRemoteAudioStats * _Nonnull)stats {
  return @{@"uid": @(stats.uid),
           @"quality": @(stats.quality),
           @"networkTransportDelay": @(stats.networkTransportDelay),
           @"jitterBufferDelay": @(stats.jitterBufferDelay),
           @"audioLossRate": @(stats.audioLossRate),
           @"numChannels": @(stats.numChannels),
           @"receivedSampleRate": @(stats.receivedSampleRate),
           @"receivedBitrate": @(stats.receivedBitrate),
           @"totalFrozenTime": @(stats.totalFrozenTime),
           @"frozenRate": @(stats.frozenRate)
   };
}

- (AgoraBeautyOptions *)beautyOptionsFromDic:(NSDictionary *)dictionary {
  AgoraBeautyOptions *options = [[AgoraBeautyOptions alloc] init];
  if (dictionary) {
    options.lighteningContrastLevel = [self intFromArguments:dictionary key:@"lighteningContrastLevel"];
    options.lighteningLevel = [self doubleFromArguments:dictionary key:@"lighteningLevel"];
    options.smoothnessLevel = [self doubleFromArguments:dictionary key:@"smoothnessLevel"];
    options.rednessLevel = [self doubleFromArguments:dictionary key:@"rednessLevel"];
  }
  return options;
}

- (AgoraVideoEncoderConfiguration *)videoEncoderConfigurationFromDic:(NSDictionary *)dictionary {
  AgoraVideoEncoderConfiguration *configuration = [[AgoraVideoEncoderConfiguration alloc] init];
  if (dictionary) {
    NSInteger width = [self doubleFromArguments:dictionary key:@"width"];
    NSInteger height = [self doubleFromArguments:dictionary key:@"height"];
    NSInteger frameRate = [self intFromArguments:dictionary key:@"frameRate"];
    NSInteger minFrameRate = [self intFromArguments:dictionary key:@"minFrameRate"];
    NSInteger bitrate = [self intFromArguments:dictionary key:@"bitrate"];
    NSInteger minBitrate = [self intFromArguments:dictionary key:@"minBitrate"];
    NSInteger orientationMode = [self intFromArguments:dictionary key:@"orientationMode"];
    NSInteger degradationPreference = [self intFromArguments:dictionary key:@"degradationPreference"];
    
    configuration.dimensions = CGSizeMake(width, height);
    configuration.frameRate = frameRate;
    configuration.minFrameRate = minFrameRate;
    configuration.bitrate = bitrate;
    configuration.minBitrate = minBitrate;
    configuration.orientationMode = orientationMode;
    configuration.degradationPreference = degradationPreference;
  }
  return configuration;
}
@end

@implementation AgoraRenderViewFactory
- (nonnull NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id _Nullable)args {
  AgoraRendererView *rendererView = [[AgoraRendererView alloc] initWithFrame:frame viewIdentifier:viewId];
  [AgoraRtcEnginePlugin addView:rendererView.view id:@(viewId)];
  return rendererView;
}

@end
