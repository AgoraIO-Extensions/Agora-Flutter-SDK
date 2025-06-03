#import <Flutter/Flutter.h>
#import "VideoViewController.h"

@interface AgoraSurfaceViewFactory : NSObject <FlutterPlatformViewFactory>

- (instancetype)initWith:(NSObject<FlutterBinaryMessenger> *)messenger
              controller:(VideoViewController *)controller;

@end
