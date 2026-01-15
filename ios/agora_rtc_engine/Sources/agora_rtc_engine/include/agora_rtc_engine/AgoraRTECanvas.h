#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AgoraRtcKit/AgoraRteKit.h>


/// RTE Canvas 管理类
@interface AgoraRTECanvas : NSObject

@property (nonatomic, strong, readonly) NSMutableDictionary<NSString *, AgoraRteCanvas *> *canvases;

- (instancetype)initWithRte:(AgoraRte *)rte;

/// 创建 Canvas
- (NSString *)createCanvas:(NSDictionary *)config error:(NSError **)error;

/// 销毁 Canvas
- (BOOL)destroyCanvas:(NSString *)canvasId error:(NSError **)error;

/// 批量设置配置
- (BOOL)setConfigs:(NSString *)canvasId config:(NSDictionary *)config error:(NSError **)error;

/// 获取配置
- (NSDictionary *)getConfigs:(NSString *)canvasId error:(NSError **)error;

// Individual Config Setters/Getters
- (BOOL)setVideoRenderMode:(NSString *)canvasId mode:(AgoraRteVideoRenderMode)mode error:(NSError **)error;
- (AgoraRteVideoRenderMode)getVideoRenderMode:(NSString *)canvasId error:(NSError **)error;
- (BOOL)setVideoMirrorMode:(NSString *)canvasId mode:(AgoraRteVideoMirrorMode)mode error:(NSError **)error;
- (AgoraRteVideoMirrorMode)getVideoMirrorMode:(NSString *)canvasId error:(NSError **)error;
- (BOOL)setCropArea:(NSString *)canvasId x:(int32_t)x y:(int32_t)y width:(int32_t)width height:(int32_t)height error:(NSError **)error;
- (NSDictionary *)getCropArea:(NSString *)canvasId error:(NSError **)error;

/// 添加视图
- (BOOL)addView:(NSString *)canvasId view:(UIView *)view config:(NSDictionary *)config error:(NSError **)error;

/// 移除视图
- (BOOL)removeView:(NSString *)canvasId view:(UIView *)view config:(NSDictionary *)config error:(NSError **)error;

/// 获取 Canvas 实例
- (AgoraRteCanvas *)getCanvas:(NSString *)canvasId;

@end
