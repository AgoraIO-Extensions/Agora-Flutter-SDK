//
//  AgoraRtcEngineKit.h
//  RCTAgora
//
//  Created by LXH on 2020/4/22.
//  Copyright © 2020 Syan. All rights reserved.
//

#import <AgoraRtcKit/AgoraRtcEngineKit.h>

typedef NS_ENUM(NSUInteger, AgoraRtcQualityReportFormat) {
  AgoraRtc_QualityReportFormat_Json = 0,
  AgoraRtc_QualityReportFormat_Html = 1,
};

typedef NS_ENUM(NSUInteger, AgoraRtcAppType) {
  AgoraRtc_APP_TYPE_NATIVE = 0,
  AgoraRtc_APP_TYPE_COCOS = 1,
  AgoraRtc_APP_TYPE_UNITY = 2,
  AgoraRtc_APP_TYPE_ELECTRON = 3,
  AgoraRtc_APP_TYPE_FLUTTER = 4,
  AgoraRtc_APP_TYPE_UNREAL = 5,
  AgoraRtc_APP_TYPE_XAMARIN = 6,
  AgoraRtc_APP_TYPE_APICLOUD = 7,
  AgoraRtc_APP_TYPE_REACTNATIVE = 8
};

@protocol AgoraRtcEngineExtensionDelegate <AgoraRtcEngineDelegate>
@optional
- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine
    audioTransportQualityOfUid:(NSUInteger)uid
                         delay:(NSUInteger)delay
                          lost:(NSUInteger)lost;
- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine
    videoTransportQualityOfUid:(NSUInteger)uid
                         delay:(NSUInteger)delay
                          lost:(NSUInteger)lost;
@end

@interface AgoraRtcEngineKit (AgoraExtension)

+ (instancetype _Nonnull)sharedEngineWithAppId:(NSString *_Nonnull)appId
                             extensionDelegate:
                                 (id<AgoraRtcEngineExtensionDelegate> _Nullable)
                                     delegate;

/** Sets the profile to control the RTC engine.
 *
 *  @param profile SDK profile in JSON format.
 *  @param merge Whether to merge the profile data with the original value.
 */
- (int)setProfile:(NSString *_Nonnull)profile merge:(BOOL)merge;

/** Set wrapper frame type by language wrapper.
 *
 *  @param appType wrapper frame type.
 */
- (int)setAppType:(AgoraRtcAppType)appType;

/** END OF COMMON METHODS */

/** BEGIN OF AUDIO METHODS */

/**
 *  Enable recap
 *
 *  @param interval &le; 0: Disabled, > 0: Interval in ms.
 */
- (int)enableRecap:(NSInteger)interval;

/**
 *  Start playing recap conversation
 *
 */
- (int)playRecap;

- (int)enableAudioQualityIndication:(BOOL)enabled;
- (int)enableTransportQualityIndication:(BOOL)enabled;

- (int)setVideoProfileEx:(NSInteger)width
               andHeight:(NSInteger)height
            andFrameRate:(NSInteger)frameRate
              andBitrate:(NSInteger)andBitrate;

- (int)sendReportData:(NSData *_Nonnull)data type:(NSInteger)type;
/** END OF AUDIO METHODS */

/** Queries internal states
 * @param parameters
 *     json string, array type
 * @return a json string
 */
- (NSString *_Nullable)getParameters:(NSString *_Nonnull)parameters;

/**
 *  Generates a URL linking to the call quality reports. @param channel      The
 channel name specified in the joinChannel method.
 *  @param listenerUid  The uid of the listener.
 *  @param speakerUid   The uid of the speaker.
 *  @param reportFormat The format of the report.
                        AgoraRtc_QualityReportFormat_Json (0): JSON.: Returns
 the quality report data in Json. AgoraRtc_QualityReportFormat_Html (1): HTML.:
 Returns a report in HTML format, displayed on a web browser or WebVIEW
 components.
 *
 *  @return 0 when executed successfully. return minus value when failed. return
 AgoraRtc_Error_Invalid_Argument (-2)：Invalid argument. return
 AgoraRtc_Error_Buffer_Too_Small (-6)：The buffer length is too small.
 */
- (NSString *_Nullable)makeQualityReportUrl:(NSString *_Nonnull)channel
                                listenerUid:(NSUInteger)listenerUid
                                speakerrUid:(NSUInteger)speakerUid
                               reportFormat:
                                   (AgoraRtcQualityReportFormat)reportFormat;

/*********************************************************
 * Large group conference call (experiment) - END
 *********************************************************/
@end
