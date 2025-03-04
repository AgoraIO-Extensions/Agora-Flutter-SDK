#ifndef AGORA_IOS_CLASSES_AGORAPIPCONTROLLER_H_
#define AGORA_IOS_CLASSES_AGORAPIPCONTROLLER_H_

#import <UIKit/UIKit.h>
#import <AVKit/AVPictureInPictureController.h>
#import <AVFoundation/AVFoundation.h>

#import <AgoraRtcKit/AgoraObjects.h>

/**
 * AgoraPipState
 * @note AgoraPipStateStarted: pip is started
 * @note AgoraPipStateStopped: pip is stopped
 * @note AgoraPipStateFailed: pip is failed
 */
typedef NS_ENUM(NSInteger, AgoraPipState) {
  AgoraPipStateStarted = 0,
  AgoraPipStateStopped = 1,
  AgoraPipStateFailed = 2,
};

/**
 * @protocol AgoraPipStateChangedDelegate
 * @abstract A protocol that defines the methods for pip state changed.
 */
@protocol AgoraPipStateChangedDelegate

/**
 * @method pipStateChanged
 * @param state
 *        The state of pip.
 * @param error
 *        The error message.
 * @abstract Delegate can implement this method to handle the pip state changed.
 */
- (void)pipStateChanged:(AgoraPipState)state error:(NSString * _Nullable)error;

@end

/**
 * @class AgoraPipOptions
 * @abstract A class that defines the options for pip.
 */
@interface AgoraPipOptions : NSObject

/**
 * @property autoEnterEnabled
 * @abstract Whether to enable auto enter pip.
 */
@property(nonatomic, assign) BOOL autoEnterEnabled;

/**
 * @property preferredContentSize
 * @abstract The preferred content size for pip.
 */
@property(nonatomic, assign) CGSize preferredContentSize;

@property(nonatomic, strong) AgoraRtcConnection* _Nullable connection;

/**
 * @property videoCanvas
 * @abstract The video canvas for pip.
 */
@property(nonatomic, strong)  AgoraRtcVideoCanvas * _Nullable videoCanvas;

/**
 * @property irisRtcRendering
 * @abstract The internal rendering pointer value.
 */
@property(nonatomic, assign) uintptr_t renderingHandle;

@end

/**
 * @class AgoraPipController
 * @abstract A class that controls the pip.
 */
@interface AgoraPipController : NSObject <AVPictureInPictureControllerDelegate>

/**
 * @method initWith
 * @param delegate
 *        The delegate of pip state changed.
 * @abstract Initialize the pip controller.
 */
- (instancetype _Nonnull)initWith:(id<AgoraPipStateChangedDelegate> _Nonnull)delegate;

/**
 * @method isSupported
 * @abstract Check if pip is supported.
 * @return Whether pip is supported.
 * @discussion This method is used to check if pip is supported, When No all
 * other methods will return NO or do nothing.
 */
- (BOOL)isSupported;

/**
 * @method isAutoEnterSupported
 * @abstract Check if pip is auto enter supported.
 * @return Whether pip is auto enter supported.
 */
- (BOOL)isAutoEnterSupported;

/**
 * @method isActivated
 * @abstract Check if pip is activated.
 * @return Whether pip is activated.
 */
- (BOOL)isActivated;

/**
 * @method setup
 * @param options
 *        The options for pip.
 * @abstract Setup pip or update pip options.
 * @return Whether pip is setup successfully.
 * @discussion This method is used to setup pip or update pip options, but only
 * the `videoCanvas` is allowed to update after the pip controller is
 * initialized, unless you call the `dispose` method and re-initialize the pip
 * controller.
 */
- (BOOL)setup:(AgoraPipOptions * _Nonnull)options;

/**
 * @method start
 * @abstract Start pip.
 * @return Whether start pip is successful or not.
 * @discussion This method is used to start pip, however, it will only works
 * when application is in the foreground. If you want to start pip when
 * application is changing to the background, you should set the
 * `autoEnterEnabled` to YES when calling the `setup` method.
 */
- (BOOL)start;

/**
 * @method stop
 * @abstract Stop pip.
 * @discussion This method is used to stop pip, however, it will only works when
 * application is in the foreground. If you want to stop pip in the background,
 * you can use the `dispose` method, which will destroy the internal pip
 * controller and release the pip view.
 * If `isPictureInPictureActive` is NO, this method will do nothing.
 */
- (void)stop;

/**
 * @method dispose
 * @abstract Dispose all resources that pip controller holds.
 * @discussion This method is used to dispose all resources that pip controller
 * holds, which will destroy the internal pip controller and release the pip
 * view. Accroding to the Apple's documentation, you should call this method
 * when you want to stop pip in the background. see:
 * https://developer.apple.com/documentation/avkit/adopting-picture-in-picture-for-video-calls?language=objc
 */
- (void)dispose;

@end

#endif /* AGORA_IOS_CLASSES_AGORAPIPCONTROLLER_H_ */
