#import "AgoraRTE.h"
#import "AgoraRTEConfig.h"
#import "AgoraRTECommon.h"

@interface AgoraRTE ()
@property (nonatomic, strong, readwrite) AgoraRte *rteInstance;
@property (nonatomic, strong) AgoraRTEConfig *config;
@end

@implementation AgoraRTE

- (instancetype)init {
    self = [super init];
    if (self) {
        _config = nil;
    }
    return self;
}

- (BOOL)getFromBridge:(NSError **)error {
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    self.rteInstance = [AgoraRte getFromBridge:rteError];
    
    if (!self.rteInstance || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // 创建配置管理器
    self.config = [[AgoraRTEConfig alloc] initWithRte:self.rteInstance];
    
    return YES;
}

- (BOOL)createWithConfig:(NSDictionary *)config error:(NSError **)error {
    AgoraRteInitialConfig *initialConfig = [[AgoraRteInitialConfig alloc] init];
    self.rteInstance = [[AgoraRte alloc] initWithInitialConfig:initialConfig];
    
    if (!self.rteInstance) {
        if (error) *error = RTE_NSERROR(-1, @"Failed to create RTE instance");
        return NO;
    }
    
    // 创建配置管理器
    self.config = [[AgoraRTEConfig alloc] initWithRte:self.rteInstance];
    
    if (config && config.count > 0) {
        return [self setConfigs:config error:error];
    }
    
    return YES;
}

- (BOOL)initMediaEngine:(void (^)(NSError *error))completion error:(NSError **)error {
    if (!self.rteInstance) {
        if (error) *error = RTE_NSERROR(-1, @"RTE instance not created");
        return NO;
    }
    
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [self.rteInstance initMediaEngine:^(AgoraRteError *err) {
        NSError *nsError = nil;
        if (err && err.code != AgoraRteOk) {
            nsError = RTE_NSERROR_FROM_RTE_ERROR(err);
        }
        if (completion) completion(nsError);
    } error:rteError];
    
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    return YES;
}

- (BOOL)destroy:(NSError **)error {
    if (!self.rteInstance) return YES;
    
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [self.rteInstance destroy:rteError];
    
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    self.rteInstance = nil;
    self.config = nil;
    return YES;
}
- (BOOL)setConfigs:(NSDictionary *)config error:(NSError **)error {
    CHECK_RTE_INSTANCE(self.rteInstance, error);
    
    // 先获取当前配置，避免覆盖其他属性
    AgoraRteConfig *rteConfig = [[AgoraRteConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [self.rteInstance getConfigs:rteConfig error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // 只更新字典中提供的属性
    if (config[@"appId"] && config[@"appId"] != [NSNull null]) {
        [rteConfig setAppId:config[@"appId"] error:rteError];
        if (rteError.code != AgoraRteOk) {
            if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
            return NO;
        }
    }
    if (config[@"logFolder"] && config[@"logFolder"] != [NSNull null]) {
        [rteConfig setLogFolder:config[@"logFolder"] error:rteError];
        if (rteError.code != AgoraRteOk) {
            if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
            return NO;
        }
    }
    if (config[@"logFileSize"] && config[@"logFileSize"] != [NSNull null]) {
        [rteConfig setLogFileSize:[config[@"logFileSize"] unsignedLongValue] error:rteError];
        if (rteError.code != AgoraRteOk) {
            if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
            return NO;
        }
    }
    if (config[@"areaCode"] && config[@"areaCode"] != [NSNull null]) {
        [rteConfig setAreaCode:[config[@"areaCode"] intValue] error:rteError];
        if (rteError.code != AgoraRteOk) {
            if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
            return NO;
        }
    }
    if (config[@"cloudProxy"] && config[@"cloudProxy"] != [NSNull null]) {
        [rteConfig setCloudProxy:config[@"cloudProxy"] error:rteError];
        if (rteError.code != AgoraRteOk) {
            if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
            return NO;
        }
    }
    if (config[@"jsonParameter"] && config[@"jsonParameter"] != [NSNull null]) {
        [rteConfig setJsonParameter:config[@"jsonParameter"] error:rteError];
        if (rteError.code != AgoraRteOk) {
            if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
            return NO;
        }
    }
    
    // 设置修改后的配置
    AgoraRteError *setError = [[AgoraRteError alloc] init];
    success = [self.rteInstance setConfigs:rteConfig error:setError];
    
    if (!success || setError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(setError);
        return NO;
    }
    return YES;
}

- (NSDictionary *)getConfigs:(NSError **)error {
    CHECK_RTE_INSTANCE_NIL(self.rteInstance, error);
    
    AgoraRteConfig *config = [[AgoraRteConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    
    BOOL success = [self.rteInstance getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return nil;
    }
    
    AgoraRteError *getError = [[AgoraRteError alloc] init];
    return @{
        @"appId": [config appId:getError] ?: @"",
        @"logFolder": [config logFolder:getError] ?: @"",
        @"logFileSize": @([config logFileSize:getError]),
        @"areaCode": @([config areaCode:getError]),
        @"cloudProxy": [config cloudProxy:getError] ?: @"",
        @"jsonParameter": [config jsonParameter:getError] ?: @""
    };
}
- (AgoraRTEConfig *)config {
    return _config;
}

@end
