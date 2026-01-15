#import <Foundation/Foundation.h>
#import <AgoraRtcKit/AgoraRteKit.h>

@protocol AgoraRTEDelegate <NSObject>
@optional
- (void)rteErrorOccurred:(NSInteger)code message:(NSString *)message;
@end

/// RTE 主类，管理 RTE 生命周期
@interface AgoraRTE : NSObject

@property (nonatomic, weak) id<AgoraRTEDelegate> delegate;
@property (nonatomic, strong, readonly) AgoraRte *rteInstance;

- (instancetype)init;

/// 从 Bridge 创建 RTE 实例
- (BOOL)getFromBridge:(NSError **)error;

/// 使用配置创建 RTE 实例
- (BOOL)createWithConfig:(NSDictionary *)config error:(NSError **)error;

/// 初始化媒体引擎
- (BOOL)initMediaEngine:(void (^)(NSError *error))completion error:(NSError **)error;

/// 批量设置配置
- (BOOL)setConfigs:(NSDictionary *)config error:(NSError **)error;

/// 获取所有配置
- (NSDictionary *)getConfigs:(NSError **)error;

/// 销毁 RTE 实例
- (BOOL)destroy:(NSError **)error;

@end
