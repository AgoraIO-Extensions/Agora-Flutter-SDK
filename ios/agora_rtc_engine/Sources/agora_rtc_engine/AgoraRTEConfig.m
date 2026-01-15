#import "AgoraRTEConfig.h"
#import "AgoraRTECommon.h"

@interface AgoraRTEConfig ()
@property (nonatomic, weak) AgoraRte *rte;
@end

@implementation AgoraRTEConfig

- (instancetype)initWithRte:(AgoraRte *)rte {
    self = [super init];
    if (self) {
        _rte = rte;
    }
    return self;
}

// Getters
- (NSString *)appId:(NSError **)error {
    CHECK_RTE_INSTANCE_NIL(self.rte, error);
    
    AgoraRteConfig *config = [[AgoraRteConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    
    BOOL success = [self.rte getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return nil;
    }
    
    AgoraRteError *getError = [[AgoraRteError alloc] init];
    NSString *appId = [config appId:getError];
    
    if (getError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(getError);
        return nil;
    }
    
    return appId ?: @"";
}

- (NSString *)logFolder:(NSError **)error {
    CHECK_RTE_INSTANCE_NIL(self.rte, error);
    
    AgoraRteConfig *config = [[AgoraRteConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    
    BOOL success = [self.rte getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return nil;
    }
    
    AgoraRteError *getError = [[AgoraRteError alloc] init];
    NSString *logFolder = [config logFolder:getError];
    
    if (getError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(getError);
        return nil;
    }
    
    return logFolder ?: @"";
}

- (NSNumber *)logFileSize:(NSError **)error {
    CHECK_RTE_INSTANCE_NIL(self.rte, error);
    
    AgoraRteConfig *config = [[AgoraRteConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    
    BOOL success = [self.rte getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return nil;
    }
    
    AgoraRteError *getError = [[AgoraRteError alloc] init];
    size_t logFileSize = [config logFileSize:getError];
    
    if (getError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(getError);
        return nil;
    }
    
    return @(logFileSize);
}

- (NSNumber *)areaCode:(NSError **)error {
    CHECK_RTE_INSTANCE_NIL(self.rte, error);
    
    AgoraRteConfig *config = [[AgoraRteConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    
    BOOL success = [self.rte getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return nil;
    }
    
    AgoraRteError *getError = [[AgoraRteError alloc] init];
    int32_t areaCode = [config areaCode:getError];
    
    if (getError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(getError);
        return nil;
    }
    
    return @(areaCode);
}

- (NSString *)cloudProxy:(NSError **)error {
    CHECK_RTE_INSTANCE_NIL(self.rte, error);
    
    AgoraRteConfig *config = [[AgoraRteConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    
    BOOL success = [self.rte getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return nil;
    }
    
    AgoraRteError *getError = [[AgoraRteError alloc] init];
    NSString *cloudProxy = [config cloudProxy:getError];
    
    if (getError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(getError);
        return nil;
    }
    
    return cloudProxy ?: @"";
}

- (NSString *)jsonParameter:(NSError **)error {
    CHECK_RTE_INSTANCE_NIL(self.rte, error);
    
    AgoraRteConfig *config = [[AgoraRteConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    
    BOOL success = [self.rte getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return nil;
    }
    
    AgoraRteError *getError = [[AgoraRteError alloc] init];
    NSString *jsonParameter = [config jsonParameter:getError];
    
    if (getError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(getError);
        return nil;
    }
    
    return jsonParameter ?: @"";
}

// Setters
- (BOOL)setAppId:(NSString *)appId error:(NSError **)error {
    CHECK_RTE_INSTANCE(self.rte, error);
    
    // 先获取当前配置，避免覆盖其他属性
    AgoraRteConfig *config = [[AgoraRteConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [self.rte getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // 只修改需要修改的属性
    [config setAppId:appId error:rteError];
    if (rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // 设置修改后的配置
    // AgoraRteError *setError = [[AgoraRteError alloc] init];
    // success = [self.rte setConfigs:config error:setError];
    // if (!success || setError.code != AgoraRteOk) {
    //     if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(setError);
    //     return NO;
    // }
    return YES;
}

- (BOOL)setLogFolder:(NSString *)logFolder error:(NSError **)error {
    CHECK_RTE_INSTANCE(self.rte, error);
    
    AgoraRteConfig *config = [[AgoraRteConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [self.rte getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    [config setLogFolder:logFolder error:rteError];
    if (rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // AgoraRteError *setError = [[AgoraRteError alloc] init];
    // success = [self.rte setConfigs:config error:setError];
    // if (!success || setError.code != AgoraRteOk) {
    //     if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(setError);
    //     return NO;
    // }
    return YES;
}

- (BOOL)setLogFileSize:(NSNumber *)logFileSize error:(NSError **)error {
    CHECK_RTE_INSTANCE(self.rte, error);
    
    AgoraRteConfig *config = [[AgoraRteConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [self.rte getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    [config setLogFileSize:[logFileSize unsignedLongValue] error:rteError];
    if (rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // AgoraRteError *setError = [[AgoraRteError alloc] init];
    // success = [self.rte setConfigs:config error:setError];
    // if (!success || setError.code != AgoraRteOk) {
    //     if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(setError);
    //     return NO;
    // }
    return YES;
}

- (BOOL)setAreaCode:(NSNumber *)areaCode error:(NSError **)error {
    CHECK_RTE_INSTANCE(self.rte, error);
    
    AgoraRteConfig *config = [[AgoraRteConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [self.rte getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    [config setAreaCode:[areaCode intValue] error:rteError];
    if (rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // AgoraRteError *setError = [[AgoraRteError alloc] init];
    // success = [self.rte setConfigs:config error:setError];
    // if (!success || setError.code != AgoraRteOk) {
    //     if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(setError);
    //     return NO;
    // }
    return YES;
}

- (BOOL)setCloudProxy:(NSString *)cloudProxy error:(NSError **)error {
    CHECK_RTE_INSTANCE(self.rte, error);
    
    AgoraRteConfig *config = [[AgoraRteConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [self.rte getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    [config setCloudProxy:cloudProxy error:rteError];
    if (rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // AgoraRteError *setError = [[AgoraRteError alloc] init];
    // success = [self.rte setConfigs:config error:setError];
    // if (!success || setError.code != AgoraRteOk) {
    //     if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(setError);
    //     return NO;
    // }
    return YES;
}

- (BOOL)setJsonParameter:(NSString *)jsonParameter error:(NSError **)error {
    CHECK_RTE_INSTANCE(self.rte, error);
    
    AgoraRteConfig *config = [[AgoraRteConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [self.rte getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    [config setJsonParameter:jsonParameter error:rteError];
    if (rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // AgoraRteError *setError = [[AgoraRteError alloc] init];
    // success = [self.rte setConfigs:config error:setError];
    // if (!success || setError.code != AgoraRteOk) {
    //     if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(setError);
    //     return NO;
    // }
    return YES;
}

@end
