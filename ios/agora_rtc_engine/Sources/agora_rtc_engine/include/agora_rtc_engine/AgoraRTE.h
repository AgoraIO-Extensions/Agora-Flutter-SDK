#import <Foundation/Foundation.h>
#import <AgoraRtcKit/AgoraRteKit.h>

@protocol AgoraRTEDelegate <NSObject>
@optional
- (void)rteErrorOccurred:(NSInteger)code message:(NSString *)message;
@end

/// RTE main class, manages RTE lifecycle
@interface AgoraRTE : NSObject

@property (nonatomic, weak) id<AgoraRTEDelegate> delegate;
@property (nonatomic, strong, readonly) AgoraRte *rteInstance;

/// Create RTE from bridge
- (BOOL)getFromBridge:(NSError **)error;

/// Create RTE with config
- (BOOL)createWithConfig:(NSDictionary *)config error:(NSError **)error;

/// Initialize media engine
- (BOOL)initMediaEngine:(void (^)(NSError *error))completion error:(NSError **)error;

/// Set configs
- (BOOL)setConfigs:(NSDictionary *)config error:(NSError **)error;

/// Get all configs
- (NSDictionary *)getConfigs:(NSError **)error;

/// Destroy RTE
- (BOOL)destroy:(NSError **)error;

@end
