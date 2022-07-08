#import <Flutter/Flutter.h>

@interface AgoraSurfaceViewFactory : NSObject <FlutterPlatformViewFactory>

- (instancetype)initWith:(NSObject<FlutterBinaryMessenger> *)messenger;

@end
