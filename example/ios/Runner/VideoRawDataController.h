#ifndef VideoRawDataController_h
#define VideoRawDataController_h

@interface VideoRawDataController : NSObject

- (instancetype)initWith:(NSString *) appId;
- (intptr_t)getNativeHandle;
- (void)dispose;

@end

#endif /* VideoRawDataController_h */
