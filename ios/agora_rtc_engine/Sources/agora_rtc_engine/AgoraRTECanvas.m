#import "AgoraRTECanvas.h"
#import "AgoraRTECommon.h"

#pragma mark - AgoraRTECanvas Implementation

@interface AgoraRTECanvas ()
@property (nonatomic, weak) AgoraRte *rte;
@end

@implementation AgoraRTECanvas

- (instancetype)initWithRte:(AgoraRte *)rte {
    self = [super init];
    if (self) {
        _rte = rte;
        _canvases = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark - Canvas Lifecycle

- (NSString *)createCanvas:(NSDictionary *)config error:(NSError **)error {
    CHECK_RTE_INSTANCE_NIL(self.rte, error);
    
    AgoraRteCanvasInitialConfig *initialConfig = [[AgoraRteCanvasInitialConfig alloc] init];
    AgoraRteCanvas *canvas = [[AgoraRteCanvas alloc] initWithRte:self.rte initialConfig:initialConfig];
    
    if (!canvas) {
        if (error) *error = RTE_NSERROR(-1, @"Failed to create canvas");
        return nil;
    }
    
    NSString *canvasId = [[NSUUID UUID] UUIDString];
    self.canvases[canvasId] = canvas;
    
    // Apply config if provided
    if (config && config.count > 0) {
        NSError *configError = nil;
        if (![self setConfigs:canvasId config:config error:&configError]) {
            [self.canvases removeObjectForKey:canvasId];
            if (error) *error = configError;
            return nil;
        }
    }
    
    return canvasId;
}

- (BOOL)destroyCanvas:(NSString *)canvasId error:(NSError **)error {
    AgoraRteCanvas *canvas = self.canvases[canvasId];
    if (!canvas) {
        if (error) *error = RTE_NSERROR(-1, @"Canvas not found");
        return NO;
    }
    
    [self.canvases removeObjectForKey:canvasId];
    return YES;
}

#pragma mark - Canvas Config

- (BOOL)setConfigs:(NSString *)canvasId config:(NSDictionary *)config error:(NSError **)error {
    GET_CANVAS_OR_RETURN(self.canvases, canvasId, error, NO);
    
    // 先获取当前配置，避免覆盖其他属性
    AgoraRteCanvasConfig *canvasConfig = [[AgoraRteCanvasConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [canvas getConfigs:canvasConfig error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // 只更新字典中提供的属性
    if (config[@"videoRenderMode"] && config[@"videoRenderMode"] != [NSNull null]) {
        [canvasConfig setVideoRenderMode:(AgoraRteVideoRenderMode)[config[@"videoRenderMode"] intValue] error:rteError];
        if (rteError.code != AgoraRteOk) {
            if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
            return NO;
        }
    }
    if (config[@"videoMirrorMode"] && config[@"videoMirrorMode"] != [NSNull null]) {
        [canvasConfig setVideoMirrorMode:(AgoraRteVideoMirrorMode)[config[@"videoMirrorMode"] intValue] error:rteError];
        if (rteError.code != AgoraRteOk) {
            if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
            return NO;
        }
    }
    if (config[@"cropArea"] && config[@"cropArea"] != [NSNull null]) {
        NSDictionary *cropAreaDict = config[@"cropArea"];
        AgoraRteRect *rect = [[AgoraRteRect alloc] init];
        [rect setX:[cropAreaDict[@"x"] intValue]];
        [rect setY:[cropAreaDict[@"y"] intValue]];
        [rect setWidth:[cropAreaDict[@"width"] intValue]];
        [rect setHeight:[cropAreaDict[@"height"] intValue]];
        [canvasConfig setCropArea:rect error:rteError];
        if (rteError.code != AgoraRteOk) {
            if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
            return NO;
        }
    }
    
    // 设置修改后的配置
    AgoraRteError *setError = [[AgoraRteError alloc] init];
    success = [canvas setConfigs:canvasConfig error:setError];
    
    if (!success || setError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(setError);
        return NO;
    }
    return YES;
}

- (NSDictionary *)getConfigs:(NSString *)canvasId error:(NSError **)error {
    AgoraRteCanvas *canvas = self.canvases[canvasId];
    if (!canvas) {
        if (error) *error = RTE_NSERROR(-1, @"Canvas not found");
        return nil;
    }
    
    AgoraRteCanvasConfig *config = [[AgoraRteCanvasConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    
    BOOL success = [canvas getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return nil;
    }
    
    AgoraRteError *getError = [[AgoraRteError alloc] init];
    AgoraRteRect *cropArea = [config cropArea:getError];
    
    return @{
        @"videoRenderMode": @([config videoRenderMode:getError]),
        @"videoMirrorMode": @([config videoMirrorMode:getError]),
        @"cropArea": @{
            @"x": @([cropArea x]),
            @"y": @([cropArea y]),
            @"width": @([cropArea width]),
            @"height": @([cropArea height])
        }
    };
}

// Individual Config Setters/Getters
- (BOOL)setVideoRenderMode:(NSString *)canvasId mode:(AgoraRteVideoRenderMode)mode error:(NSError **)error {
    GET_CANVAS_OR_RETURN(self.canvases, canvasId, error, NO);
    
    AgoraRteCanvasConfig *config = [[AgoraRteCanvasConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [canvas getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    [config setVideoRenderMode:mode error:rteError];
    if (rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // success = [canvas setConfigs:config error:rteError];
    // if (!success || rteError.code != AgoraRteOk) {
    //     if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
    //     return NO;
    // }
    return YES;
}

- (AgoraRteVideoRenderMode)getVideoRenderMode:(NSString *)canvasId error:(NSError **)error {
    GET_CANVAS_OR_RETURN(self.canvases, canvasId, error, AgoraRteVideoRenderModeHidden);
    
    AgoraRteCanvasConfig *config = [[AgoraRteCanvasConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [canvas getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return AgoraRteVideoRenderModeHidden;
    }
    return [config videoRenderMode:rteError];
}

- (BOOL)setVideoMirrorMode:(NSString *)canvasId mode:(AgoraRteVideoMirrorMode)mode error:(NSError **)error {
    GET_CANVAS_OR_RETURN(self.canvases, canvasId, error, NO);
    
    AgoraRteCanvasConfig *config = [[AgoraRteCanvasConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [canvas getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    [config setVideoMirrorMode:mode error:rteError];
    if (rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // success = [canvas setConfigs:config error:rteError];
    // if (!success || rteError.code != AgoraRteOk) {
    //     if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
    //     return NO;
    // }
    return YES;
}

- (AgoraRteVideoMirrorMode)getVideoMirrorMode:(NSString *)canvasId error:(NSError **)error {
    GET_CANVAS_OR_RETURN(self.canvases, canvasId, error, AgoraRteVideoMirrorModeDisabled);
    
    AgoraRteCanvasConfig *config = [[AgoraRteCanvasConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [canvas getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return AgoraRteVideoMirrorModeDisabled;
    }
    return [config videoMirrorMode:rteError];
}

- (BOOL)setCropArea:(NSString *)canvasId x:(int32_t)x y:(int32_t)y width:(int32_t)width height:(int32_t)height error:(NSError **)error {
    GET_CANVAS_OR_RETURN(self.canvases, canvasId, error, NO);
    
    AgoraRteCanvasConfig *config = [[AgoraRteCanvasConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [canvas getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    AgoraRteRect *rect = [[AgoraRteRect alloc] init];
    [rect setX:x];
    [rect setY:y];
    [rect setWidth:width];
    [rect setHeight:height];
    [config setCropArea:rect error:rteError];
    if (rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    
    // success = [canvas setConfigs:config error:rteError];
    // if (!success || rteError.code != AgoraRteOk) {
    //     if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
    //     return NO;
    // }
    return YES;
}

- (NSDictionary *)getCropArea:(NSString *)canvasId error:(NSError **)error {
    GET_CANVAS_OR_RETURN(self.canvases, canvasId, error, nil);
    
    AgoraRteCanvasConfig *config = [[AgoraRteCanvasConfig alloc] init];
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [canvas getConfigs:config error:rteError];
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return nil;
    }
    
    AgoraRteRect *cropArea = [config cropArea:rteError];
    if (rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return nil;
    }
    
    return @{
        @"x": @([cropArea x]),
        @"y": @([cropArea y]),
        @"width": @([cropArea width]),
        @"height": @([cropArea height])
    };
}

#pragma mark - Canvas View

- (BOOL)addView:(NSString *)canvasId view:(UIView *)view config:(NSDictionary *)config error:(NSError **)error {
    GET_CANVAS_OR_RETURN(self.canvases, canvasId, error, NO);
    
    AgoraRteViewConfig *viewConfig = nil;
    if (config && config != [NSNull null] && [config isKindOfClass:[NSDictionary class]] && config.count > 0) {
        viewConfig = [[AgoraRteViewConfig alloc] init];
        if (config[@"cropArea"]) {
            NSDictionary *cropAreaDict = config[@"cropArea"];
            AgoraRteRect *rect = [[AgoraRteRect alloc] init];
            [rect setX:[cropAreaDict[@"x"] intValue]];
            [rect setY:[cropAreaDict[@"y"] intValue]];
            [rect setWidth:[cropAreaDict[@"width"] intValue]];
            [rect setHeight:[cropAreaDict[@"height"] intValue]];
            AgoraRteError *rteError = [[AgoraRteError alloc] init];
            [viewConfig setCropArea:rect error:rteError];
        }
    }
    
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [canvas addView:view config:viewConfig error:rteError];
    
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    return YES;
}

- (BOOL)removeView:(NSString *)canvasId view:(UIView *)view config:(NSDictionary *)config error:(NSError **)error {
    GET_CANVAS_OR_RETURN(self.canvases, canvasId, error, NO);
    
    AgoraRteViewConfig *viewConfig = nil;
    if (config && config != [NSNull null] && [config isKindOfClass:[NSDictionary class]] && config.count > 0) {
        viewConfig = [[AgoraRteViewConfig alloc] init];
        if (config[@"cropArea"]) {
            NSDictionary *cropAreaDict = config[@"cropArea"];
            AgoraRteRect *rect = [[AgoraRteRect alloc] init];
            [rect setX:[cropAreaDict[@"x"] intValue]];
            [rect setY:[cropAreaDict[@"y"] intValue]];
            [rect setWidth:[cropAreaDict[@"width"] intValue]];
            [rect setHeight:[cropAreaDict[@"height"] intValue]];
            AgoraRteError *rteError = [[AgoraRteError alloc] init];
            [viewConfig setCropArea:rect error:rteError];
        }
    }
    
    AgoraRteError *rteError = [[AgoraRteError alloc] init];
    BOOL success = [canvas removeView:view config:viewConfig error:rteError];
    
    if (!success || rteError.code != AgoraRteOk) {
        if (error) *error = RTE_NSERROR_FROM_RTE_ERROR(rteError);
        return NO;
    }
    return YES;
}

- (AgoraRteCanvas *)getCanvas:(NSString *)canvasId {
    return self.canvases[canvasId];
}

@end
