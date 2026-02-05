#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AgoraRtcKit/AgoraRteKit.h>


/// RTE Canvas Manager
@interface AgoraRTECanvas : NSObject

@property (nonatomic, strong, readonly) NSMutableDictionary<NSString *, AgoraRteCanvas *> *canvases;

- (instancetype)initWithRte:(AgoraRte *)rte;

/// Create canvas
- (NSString *)createCanvas:(NSDictionary *)config error:(NSError **)error;

/// Destroy canvas
- (BOOL)destroyCanvas:(NSString *)canvasId error:(NSError **)error;

/// Set configs
- (BOOL)setConfigs:(NSString *)canvasId config:(NSDictionary *)config error:(NSError **)error;

/// Get configs
- (NSDictionary *)getConfigs:(NSString *)canvasId error:(NSError **)error;

// Individual Config Setters/Getters
- (BOOL)setVideoRenderMode:(NSString *)canvasId mode:(AgoraRteVideoRenderMode)mode error:(NSError **)error;
- (AgoraRteVideoRenderMode)getVideoRenderMode:(NSString *)canvasId error:(NSError **)error;
- (BOOL)setVideoMirrorMode:(NSString *)canvasId mode:(AgoraRteVideoMirrorMode)mode error:(NSError **)error;
- (AgoraRteVideoMirrorMode)getVideoMirrorMode:(NSString *)canvasId error:(NSError **)error;
- (BOOL)setCropArea:(NSString *)canvasId x:(int32_t)x y:(int32_t)y width:(int32_t)width height:(int32_t)height error:(NSError **)error;
- (NSDictionary *)getCropArea:(NSString *)canvasId error:(NSError **)error;

/// Add view
- (BOOL)addView:(NSString *)canvasId view:(UIView *)view config:(NSDictionary *)config error:(NSError **)error;

/// Remove view
- (BOOL)removeView:(NSString *)canvasId view:(UIView *)view config:(NSDictionary *)config error:(NSError **)error;

/// Get Canvas instance
- (AgoraRteCanvas *)getCanvas:(NSString *)canvasId;

@end
