#import <Foundation/Foundation.h>
#import <AgoraRtcKit/AgoraRteKit.h>


/// RTE 配置管理类
@interface AgoraRTEConfig : NSObject

- (instancetype)initWithRte:(AgoraRte *)rte;

// Getters
- (NSString *)appId:(NSError **)error;
- (NSString *)logFolder:(NSError **)error;
- (NSNumber *)logFileSize:(NSError **)error;
- (NSNumber *)areaCode:(NSError **)error;
- (NSString *)cloudProxy:(NSError **)error;
- (NSString *)jsonParameter:(NSError **)error;

// Setters
- (BOOL)setAppId:(NSString *)appId error:(NSError **)error;
- (BOOL)setLogFolder:(NSString *)logFolder error:(NSError **)error;
- (BOOL)setLogFileSize:(NSNumber *)logFileSize error:(NSError **)error;
- (BOOL)setAreaCode:(NSNumber *)areaCode error:(NSError **)error;
- (BOOL)setCloudProxy:(NSString *)cloudProxy error:(NSError **)error;
- (BOOL)setJsonParameter:(NSString *)jsonParameter error:(NSError **)error;

@end
