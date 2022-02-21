#ifndef AgoraSurfaceViewFactory_h
#define AgoraSurfaceViewFactory_h

#import <Flutter/Flutter.h>

@interface AgoraSurfaceViewFactory : NSObject <FlutterPlatformViewFactory>

- (instancetype)initWith:(NSObject<FlutterBinaryMessenger> *)messenger
                  engine:(void *)engine;

@end


#endif /* AgoraSurfaceViewFactory_h */
